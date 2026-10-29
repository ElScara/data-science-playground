# Restaurant Tips Prediction & Regression Analysis

A statistical modeling and exploratory data analysis project built in Excel to identify key determinants of restaurant tipping behavior and quantify their predictive power using multiple linear regression.

## 📁 Repository Contents
* [Restaurant_Tips_Dataset_Model.xlsx](Restaurant_Tips_Dataset_Model.xlsx): The core analytical workbook featuring summary statistics, correlation matrices, regression outputs, and the tip prediction model.
* [restaurant_tips_dataset.xlsx](restaurant_tips_dataset.xlsx): The clean source dataset containing dining transaction attributes (bill amount, tip, gender, smoking status, day, time, party size).
* [Regression_Analysis_Report.pdf](Regression_Analysis_Report.pdf): Detailed technical and statistical documentation interpreting model coefficients, $R^2$, $p$-values, and business implications.
* [Restaurant_Tips_Prediction_brief.pdf](Restaurant_Tips_Prediction_brief.pdf): Original project scope, analytical hypotheses, and business objectives.
* [Restaurant_Tips_Prediction_Visuals.pdf](Restaurant_Tips_Prediction_Visuals.pdf): High-resolution chart decks illustrating variable distributions, correlation heatmaps, and regression residual diagnostics.

## 🎯 Business Objective
To assist restaurant management in understanding table-level monetization drivers and server compensation patterns. By modeling tip amounts against total bill, party size, dining timeframe, and customer demographics, the analysis isolates actionable insights for shift scheduling and floor optimization.

## 🛠️ Statistical Techniques & Excel Tools
* **Parametric Modeling:** Multiple Ordinary Least Squares (OLS) Linear Regression using the Excel **Data Analysis Toolpak**.
* **Exploratory Data Analysis (EDA):** Bivariate correlation analysis (`PEARSON`, `CORREL`), descriptive summaries, and outlier screening.
* **Categorical Encoding:** Dummy variable transformation for qualitative predictors (time of day, day of the week, smoking preferences).
* **Data Presentation:** Trendline scatter plots, residual distribution charts, and dynamic predictor input cells.

## 💡 Key Findings & Analytical Highlights
* **Primary Driver:** Total bill size exhibits the highest positive coefficient and statistical significance ($p < 0.001$), serving as the foundational baseline for tip magnitude.
* **Party Size Dynamics:** While absolute tip value scales with larger dining parties, tip percentage shows diminishing returns as group size expands.
* **Shift Disparities:** Dinner service displays higher absolute tip variance compared to lunch shifts, correlating with higher average table spend.

## 🚀 How to Use the Model
1. Download [Restaurant_Tips_Dataset_Model.xlsx](Restaurant_Tips_Dataset_Model.xlsx).
2. Open the file in **Microsoft Excel**.
3. Inspect the **Regression Summary Output** tab for ANOVA statistics, standard errors, and coefficient tables.
4. Use the input cells on the prediction sheet to enter estimated bill amounts and party sizes to calculate expected tip yields.
