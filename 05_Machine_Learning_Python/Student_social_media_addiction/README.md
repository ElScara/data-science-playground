# Student Social Media Addiction & Relationship Dynamics: Machine Learning Analysis

A predictive modeling and exploratory data analysis project implemented in Python to examine the relationship between student social media habits, psychological well-being, and romantic relationship status. This project investigates whether behavioral indicators (such as daily screen time, platform choice, addiction score, sleep patterns, and interpersonal conflict) can effectively classify relationship dynamics using supervised classification algorithms.

---

## 📁 Repository Contents

* [`Students Social Media Addiction.csv`](Students%20Social%20Media%20Addiction.csv): The primary cross-sectional survey dataset containing 705 student responses across 13 behavioral, psychological, and demographic attributes.
* [`Student_social_media_addiction_ML.ipynb`](Student_social_media_addiction_ML.ipynb): End-to-end Jupyter/Colab notebook executing data ingestion, exploratory visualization, preprocessing pipelines, hyperparameter optimization, model comparison, feature importance extraction, and unseen sample prediction.

---

## 🎯 Project Objectives & Problem Statement

* **Research Problem:** Identify how digital media dependency, psychological health, and demographic contexts correlate with interpersonal relationship outcomes among students aged 18 to 24.
* **Target Classification:** Predict multi-class `Relationship_Status` categorized into three distinct classes:
  1. `Single` (baseline independent students)
  2. `In Relationship` (students in committed partnerships)
  3. `Complicated` (students experiencing relational ambiguity or conflict)
* **Comparative Machine Learning:** Train, tune, and evaluate multiple classification architectures to determine optimal generalization across imbalanced target classes.
* **Feature Importance Evaluation:** Identify the primary behavioral drivers influencing relational outcomes.

---

## 🛠️ Tech Stack & Dependencies

* **Language:** Python
* **Data Processing & Manipulation:** `pandas`, `numpy`
* **Visualization:** `matplotlib`, `seaborn`
* **Machine Learning & Pipeline Engineering:** `scikit-learn`
  * Preprocessing: `ColumnTransformer`, `Pipeline`, `StandardScaler`, `OneHotEncoder`, `LabelEncoder`, `SimpleImputer`
  * Model Selection & Tuning: `RandomizedSearchCV`, `train_test_split`, `cross_val_score`
  * Metrics: `accuracy_score`, `f1_score` (weighted), `confusion_matrix`, `classification_report`
* **Algorithms:**
  * `RandomForestClassifier`
  * `XGBClassifier` (`xgboost`)
  * `SVC` (Support Vector Classifier)

---

## 📊 Exploratory Data Analysis & Empirical Observations

Analysis of the 705 student records revealed distinct psychosocial patterns:

1. **Target Distribution:**
   * `In Relationship`: ~45%
   * `Single`: ~35%
   * `Complicated`: ~20%
2. **Behavioral Variations by Relationship Status:**
   * **Social Media Usage:** Students in `Complicated` relationships exhibit the highest average daily usage (mean ~5.8 hours), compared to `Single` (~4.9 hours) and `In Relationship` (~4.5 hours).
   * **Addiction & Interpersonal Conflict:** `Complicated` status strongly associates with elevated `Addicted_Score` (mean ~7.5) and higher counts of `Conflicts_Over_Social_Media`.
   * **Sleep Duration:** Students in stable relationships maintain higher median sleep hours, whereas students reporting `Complicated` status show the lowest sleep averages.
3. **Correlation Matrix Findings:**
   * Strong positive correlation between `Addicted_Score` and `Conflicts_Over_Social_Media` ($r = 0.93$).
   * Strong positive correlation between `Addicted_Score` and `Avg_Daily_Usage_Hours` ($r = 0.83$).
   * Strong inverse correlation between `Addicted_Score` and `Mental_Health_Score` ($r = -0.95$).
   * Inverse correlation between `Sleep_Hours_Per_Night` and `Avg_Daily_Usage_Hours` ($r = -0.79$).

---

## ⚙️ Data Preprocessing & Modeling Architecture

* **Data Partitioning:** Stratified 80/20 train/test split (`random_state=42`) based on the label-encoded target variable.
* **Pipeline Transformation (`ColumnTransformer`):**
  * **Numeric Pipeline:** Applied median imputation (`SimpleImputer`) followed by standard feature normalization (`StandardScaler`) on:
    * `Age`, `Avg_Daily_Usage_Hours`, `Sleep_Hours_Per_Night`, `Mental_Health_Score`, `Addicted_Score`, `Conflicts_Over_Social_Media`
  * **Categorical Pipeline:** Applied most-frequent imputation and one-hot encoding (`OneHotEncoder(handle_unknown='ignore')`) on:
    * `Gender`, `Academic_Level`, `Country`, `Most_Used_Platform`, `Affects_Academic_Performance`
* **Hyperparameter Optimization:** Conducted `RandomizedSearchCV` across 20 iterations using 5-fold cross-validation, optimizing specifically for `f1_weighted` to mitigate class distribution skew.

---

## 📈 Model Performance & Comparative Evaluation

| Model | Hyperparameters (Best) | Train CV F1 (Weighted) | Test Accuracy | Test F1 (Weighted) |
| :--- | :--- | :---: | :---: | :---: |
| **XGBoost Classifier** | `n_estimators: 300`, `max_depth: 3`, `learning_rate: 0.1`, `subsample: 0.8`, `scale_pos_weight: 1` | **0.8301** | **0.8652** | **0.8693** |
| **Support Vector Classifier (SVC)** | `kernel: 'linear'`, `C: 10`, `gamma: 0.1`, `class_weight: None` | 0.8615 | 0.8298 | 0.8318 |
| **Random Forest Classifier** | `n_estimators: 100`, `max_depth: None`, `min_samples_split: 5`, `class_weight: 'balanced'` | 0.8409 | 0.8085 | 0.8152 |

### Model Selection Verdict
* **XGBoost** demonstrated superior generalization on the unseen test set, achieving the top test accuracy (**86.52%**) and weighted F1-score (**0.8693**), maintaining minimal variance between cross-validation training and test evaluation.
* **SVC** exhibited higher training cross-validation performance but degraded slightly on test generalization, indicating marginal overfitting.

---

## 🔑 Key Feature Importance Insights

Based on the tree-based split importances extracted from the tuned XGBoost model:
1. **`Addicted_Score`:** The dominant predictive indicator of student relationship dynamics.
2. **`Avg_Daily_Usage_Hours` & `Mental_Health_Score`:** Second-tier influential factors governing classification splits.
3. **Platform Drivers:** Specific engagement on visually driven platforms (notably TikTok) exhibited stronger predictive signals than traditional networking channels.
4. **Demographics:** Attributes such as `Age`, `Country`, and `Academic_Level` demonstrated relatively minor predictive influence compared to active psychological and behavioral metrics.

---

## 🚀 Execution & Reproduction

1. Clone the repository and navigate to the project directory:
   ```bash
   git clone [https://github.com/ElScara/data-science-playground.git](https://github.com/ElScara/data-science-playground.git)
   cd data-science-playground/05_Machine_Learning_Python/Student_social_media_addiction
