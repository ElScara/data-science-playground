# Mercedes-Benz Greener Manufacturing: Test Bench Time Optimization

A machine learning regression project implemented in Python to predict the time (in seconds) an automobile configuration spends on the test bench. By applying zero-variance feature filtering, label encoding, Principal Component Analysis (PCA) for dimensionality reduction, and XGBoost regression, this project aims to streamline the testing cycle, lower carbon dioxide emissions, and support sustainable vehicle manufacturing.

---

## 📁 Repository Contents

* [`_Mercedes_Benz_Greener_Manufacturing.ipynb`](_Mercedes_Benz_Greener_Manufacturing.ipynb): Complete Jupyter notebook containing data ingestion, null checks, zero-variance feature elimination, label encoding, PCA dimensionality reduction, and XGBoost model training and inference.
* [`mercedes_benz_project_brief.pdf`](mercedes_benz_project_brief.pdf): Project scope, problem definition, objectives, and evaluation requirements.
* [`mercedes_benz_project_report.pdf`](mercedes_benz_project_report.pdf): Comprehensive project report detailing methodology, feature transformations, and analytical findings.
* [`mercedes_benz_project_visuals.pdf`](mercedes_benz_project_visuals.pdf): Visual outputs, feature distribution analyses, and diagnostic figures.
* [`mercedes_xgboost_results.csv`](mercedes_xgboost_results.csv): Final prediction submission file mapping each test vehicle `ID` to its predicted test duration `y`.

---

## 🎯 Project Objectives & Problem Statement

* **Industrial Context:** To optimize Mercedes-Benz vehicle safety and performance testing without compromising standards. Complex hardware customisation creates high variance in test bench processing durations.
* **Target Objective:** Accurately forecast the continuous target variable `y` (the time in seconds a vehicle spends on the test rig) based on an anonymized set of binary and categorical feature combinations.
* **Dimensionality Challenge:** Handle an ultra-wide feature space (over 370 variables for ~4,200 samples) by filtering constant signals and projecting high-dimensional multi-collinear attributes into orthogonal principal components.
* **Algorithm Selection:** Train an optimized `XGBRegressor` on the transformed feature representations to output continuous test-duration estimates.

---

## 🛠️ Tech Stack & Libraries

* **Language:** Python
* **Data Manipulation & Preprocessing:** `pandas`, `numpy`, `scikit-learn` (`LabelEncoder`, `PCA`)
* **Machine Learning Model:** `xgboost` (`xgb.XGBRegressor`)
* **Core Concepts:** Zero-Variance Thresholding, Label Encoding, Principal Component Analysis (PCA), Gradient Boosted Trees

---

## 🔬 Workflow & Implementation Details

The implementation pipeline inside [`_Mercedes_Benz_Greener_Manufacturing.ipynb`](_Mercedes_Benz_Greener_Manufacturing.ipynb) proceeds through the following stages:

1. **Data Ingestion & Integrity Audits:**
   * Ingests `train.csv` (4,209 rows, 378 columns) and `test.csv` (4,209 rows, 377 columns).
   * Verifies dataset completeness (`isnull().sum().any()`), confirming 0 missing or null entries across both training and testing sets.
2. **Zero-Variance Feature Elimination:**
   * Evaluates the variance of numeric columns and removes attributes displaying zero variance (constant columns), as they supply zero discriminative information to regression trees.
   * Drops 12 zero-variance features from both train and test partitions: `X11`, `X93`, `X107`, `X233`, `X235`, `X268`, `X289`, `X290`, `X293`, `X297`, `X330`, and `X347`.
3. **Categorical Label Encoding:**
   * Identifies non-numeric categorical attributes (`X0`, `X1`, `X2`, `X3`, `X4`, `X5`, `X6`, `X8`).
   * Fits `LabelEncoder` across the combined unique values of both train and test sets to guarantee consistent category-to-integer mapping across partitions.
4. **Dimensionality Reduction via PCA:**
   * Isolates the target `y` and drops vehicle identifier `ID`.
   * Projects the 364 remaining engineered features into 12 principal components using `PCA(n_components=12, random_state=42)`.
   * Reduces feature redundancy while capturing the primary axes of data variance.
5. **XGBoost Regression & Inference:**
   * Configures `XGBRegressor` with `objective='reg:squarederror'`, `learning_rate=0.1`, `max_depth=4`, `n_estimators=150`, and `random_state=42`.
   * Trains the model on the 12-dimensional PCA training matrix.
   * Generates continuous duration predictions on `X_test_pca` and exports them to `mercedes_xgboost_results.csv`.

---

## 📈 Summary of Data Dimensionality Transformations

| Stage | Input Train Shape | Input Test Shape | Action Description | Output Features |
| :--- | :---: | :---: | :--- | :---: |
| **Raw Data** | (4209, 378) | (4209, 377) | Load datasets, verify zero nulls | 376 features + `ID` (+ `y` in train) |
| **Variance Filtering** | (4209, 378) | (4209, 377) | Drop 12 zero-variance constant features | 364 features |
| **Encoding** | (4209, 366) | (4209, 365) | Fit and transform 8 object columns with LabelEncoder | 364 features |
| **PCA Reduction** | (4209, 364) | (4209, 364) | Apply PCA with 12 components on `X_train` & `X_test` | **12 Principal Components** |
| **XGBoost Output** | (4209, 12) | (4209, 12) | Fit `XGBRegressor` and output predictions for 4,209 test vehicles | Final `mercedes_xgboost_results.csv` |

---

## 🚀 Execution Guide

1. Clone the repository and navigate to the project directory:
   ```bash
   git clone [https://github.com/ElScara/data-science-playground.git](https://github.com/ElScara/data-science-playground.git)
   cd data-science-playground/05_Machine_Learning_Python/mercedes_benz_greener_manufacturing


## Additional reproducibility and model-validation audit

The original `train.csv` and `test.csv` are **not included** in this repository. The historical notebook and its reported workflow are retained for reference; its performance has not been independently rerun in this maintenance update. Its label encoding uses both training and competition test feature values, and it does not provide a separate labeled holdout evaluation.

An optional [validation.py](validation.py) now provides a **separate, leakage-aware evaluation**: a mean-prediction baseline, 80/20 holdout, five-fold cross-validation on training data, and an XGBoost preprocessing pipeline fitted inside each fold. This is a new evaluation design, not a reproduction of the original notebook's PCA specification or its previously reported outputs.

```bash
python -m pip install -r requirements.txt
python validation.py --train /path/to/original/train.csv
```

No new scores are claimed until the script is run on the original dataset. If validation results differ from the historical report, document both and explain the evaluation differences.
