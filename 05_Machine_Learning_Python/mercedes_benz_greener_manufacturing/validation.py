"""Optional leakage-safe evaluation using the original train.csv (not committed)."""
from pathlib import Path
import argparse
import json
import numpy as np
import pandas as pd
from sklearn.compose import ColumnTransformer
from sklearn.dummy import DummyRegressor
from sklearn.impute import SimpleImputer
from sklearn.metrics import mean_absolute_error, mean_squared_error, r2_score
from sklearn.model_selection import train_test_split, cross_val_score, KFold
from sklearn.pipeline import Pipeline
from sklearn.preprocessing import OneHotEncoder, StandardScaler
from sklearn.feature_selection import VarianceThreshold
from sklearn.decomposition import PCA
from xgboost import XGBRegressor


def evaluate(frame):
    if 'y' not in frame.columns:
        raise ValueError('Missing target column y')
    X = frame.drop(columns=['ID', 'y'], errors='ignore')
    y = frame['y']
    if len(frame) < 30 or X.empty:
        raise ValueError('Need at least 30 rows and predictor columns')
    cat = X.select_dtypes(include=['object', 'category']).columns.tolist()
    num = [col for col in X if col not in cat]
    transformers = []
    if num:
        transformers.append(('numeric', Pipeline([
            ('impute', SimpleImputer(strategy='median')),
            ('scale', StandardScaler()),
        ]), num))
    if cat:
        transformers.append(('categorical', Pipeline([
            ('impute', SimpleImputer(strategy='most_frequent')),
            ('encode', OneHotEncoder(handle_unknown='ignore', sparse_output=False)),
        ]), cat))
    pipeline = Pipeline([
        ('preprocess', ColumnTransformer(transformers, sparse_threshold=0)),
        ('variance', VarianceThreshold()),
        ('pca', PCA(n_components=0.95, svd_solver='full')),
        ('model', XGBRegressor(
            objective='reg:squarederror', n_estimators=150, max_depth=4,
            learning_rate=0.1, random_state=42, n_jobs=2)),
    ])
    X_train, X_test, y_train, y_test = train_test_split(
        X, y, test_size=0.2, random_state=42)
    baseline = DummyRegressor(strategy='mean').fit(X_train, y_train)
    pipeline.fit(X_train, y_train)

    def metrics(pred):
        return {
            'mae': float(mean_absolute_error(y_test, pred)),
            'rmse': float(np.sqrt(mean_squared_error(y_test, pred))),
            'r2': float(r2_score(y_test, pred)),
        }

    cv = KFold(n_splits=5, shuffle=True, random_state=42)
    scores = -cross_val_score(
        pipeline, X_train, y_train, cv=cv, scoring='neg_mean_absolute_error')
    return {
        'baseline_holdout': metrics(baseline.predict(X_test)),
        'xgboost_holdout': metrics(pipeline.predict(X_test)),
        'training_cv_mae_mean': float(scores.mean()),
        'training_cv_mae_std': float(scores.std()),
    }


if __name__ == '__main__':
    parser = argparse.ArgumentParser()
    parser.add_argument('--train', type=Path, default=Path(__file__).with_name('train.csv'))
    args = parser.parse_args()
    if not args.train.is_file():
        parser.error('Original train.csv is not included; supply it with --train')
    print(json.dumps(evaluate(pd.read_csv(args.train)), indent=2))
