# Restaurant Tips Prediction & Multiple Linear Regression

An econometric and statistical modeling project implemented in Excel to predict restaurant tipping behavior, evaluate feature correlations, and measure predictive accuracy using Ordinary Least Squares (OLS) regression and residual error metrics.

## 📁 Repository Contents
* [Restaurant_Tips_Dataset_Model.xlsx](Restaurant_Tips_Dataset_Model.xlsx): The complete working spreadsheet containing data encoding, correlation matrices, Data Analysis Toolpak regression tables, and row-level residual calculations.
* [restaurant_tips_dataset.xlsx](restaurant_tips_dataset.xlsx): The source dataset containing 244 dining records across total bill, tip, sex, smoker status, day, meal time, and party size.
* [Regression_Analysis_Report.pdf](Regression_Analysis_Report.pdf): Formal technical documentation interpreting model fit, coefficients, $p$-values, and conclusions.
* [Restaurant_Tips_Prediction_brief.pdf](Restaurant_Tips_Prediction_brief.pdf): Project scope, business context, and problem statement.
* [Restaurant_Tips_Prediction_Visuals.pdf](Restaurant_Tips_Prediction_Visuals.pdf): Step-by-step visual documentation capturing data preparation, formula logic, Toolpak configuration, and model evaluation metrics.


## 🎯 Business Objective
To determine which dining transaction attributes (total bill, party size, shift time, day of the week, and customer profile) serve as statistically significant predictors of tip amounts, and to assess whether linear modeling provides reliable forecasting for shift compensation.

## 🛠️ Statistical Techniques & Excel Architecture
* **Feature Engineering & Categorical Encoding:** Transformed qualitative attributes using conditional Excel logic (`IF`, nested `IF`s) into numeric dummy variables (`sex_num`, `smoker_num`, `day_num`, `time_num`).
* **Bivariate Correlation Screening:** Calculated feature-to-target Pearson correlation coefficients using `=CORREL()`:
  * `total_bill` vs `tip`: **+0.675** (strongest predictor)
  * `size` vs `tip`: **+0.488** (moderate positive relationship)
  * Demographic/temporal factors (`day`, `time`, `sex`, `smoker`): negligible direct linear correlation ($r < 0.14$).
* **Parametric Estimation:** Fitted an OLS multiple regression model using the Excel **Data Analysis Toolpak** across $N = 243$ observations.
* **Row-Level Residual & Accuracy Tracking:** 
  * Rebuilt the fitted regression equation in-cell to compute $\hat{y}$ (`predicted_tip`).
  * Evaluated predictive variance by computing explicit residuals (`Error`), squared errors (`Squared error`), **Mean Squared Error (MSE = 1.02)**, and **Root Mean Squared Error (RMSE = 1.01)**.

## 📊 Model Performance & Statistical Results
* **Multiple R:** `0.684`
* **R-Squared ($R^2$):** `0.468` (the model accounts for ~46.8% of variance in tipping amounts)
* **Adjusted $R^2$:** `0.455`
* **Standard Error:** `1.023`
* **Statistical Significance:** `Significance F = 6.99E-30`, confirming overall model significance.
* **Key Coefficient:** `total_bill` coefficient is **0.094** ($t = 9.86, p = 2.0\times 10^{-19}$), indicating roughly a 9.4-cent increase in tip per additional dollar spent.

## 🚀 How to Inspect the Model
1. Download [Restaurant_Tips_Dataset_Model.xlsx](Restaurant_Tips_Dataset_Model.xlsx).
2. Open the file in **Microsoft Excel**.
3. Inspect columns `A` through `K` for raw records and encoded dummy variables.
4. Review columns `L` through `P` to follow the row-level error propagation (`predicted_tip`, `Error`, `Squared error`, `MSE`, `RMSE`).
5. Reference [Restaurant_Tips_Prediction_Visuals.pdf](Restaurant_Tips_Prediction_Visuals.pdf) for the captured step-by-step audit trail.
