# Web Analytics & User Behavior Modeling

An exploratory data analysis and statistical modeling project implemented in R to evaluate user engagement, assess the relationship between traffic volume and unique page views, and identify key drivers of user exits and session metrics using ordinary least squares (OLS) regression.

---

## 📁 Repository Contents

- [1555058318_internet_dataset.xlsx](1555058318_internet_dataset.xlsx): Raw web traffic and session metrics dataset in Excel format.
- [web_analytics_script.R](web_analytics_script.R): Main R script containing data ingestion, descriptive summarization, correlation testing, linear regression workflows, and diagnostic checks.
- [User_Behavior_Statistical_Analysis.pdf](User_Behavior_Statistical_Analysis.pdf): Comprehensive statistical report detailing model coefficients, variance tests, and behavioral insights.
- [Web_Analytics_Project_Overview.pdf](Web_Analytics_Project_Overview.pdf): Executive summary highlighting business background, analytical questions, and high-level findings.
- [web_analytics_brief.pdf](web_analytics_brief.pdf): Project scope, analytical problem statement, and task guidelines.
- [web_analytics_plot_visuals.pdf](web_analytics_plot_visuals.pdf): Visual outputs compiling regression scatter plots, confidence bands, and categorical factor distributions.


---

## 🎯 Analytical Objectives

- **Traffic & Pageview Association:** Quantify the linear relationship between `Visits` and `Uniquepageviews` using Pearson correlation testing and bivariate OLS modeling.
- **Exit Driver Identification:** Determine which website engagement indicators (`Bounces`, `Continent`, `Source.group`, `Timeinpage`, `Uniquepageviews`, and `Visits`) significantly drive user `Exits`.
- **Multicollinearity & Model Selection:** Detect variance inflation using the Variance Inflation Factor (`vif()`) and isolate the optimal predictor subset via bidirectional stepwise selection (`step()`).
- **Secondary Engagement Models:** Evaluate complementary regression architectures modeling drivers of duration (`Timeinpage`) and single-page abandonment (`Bounces`).

---

## 🛠️ Tools & Libraries

- **Language:** R
- **Environment Automation:** `rstudioapi` (automatic script working directory resolution)
- **Data Ingestion & Wrangling:** `readxl`, `dplyr`
- **Visualization:** `ggplot2`
- **Regression Diagnostics:** `car` (used for `vif()` multicollinearity analysis)

---

## 🔬 Methodology & Script Workflow

The analytical pipeline executed in [web_analytics_script.R](web_analytics_script.R) follows seven structured phases:

1. **Ingestion & Environment Setup:**
   - Detects the script folder using `rstudioapi` or provides an interactive `file.choose()` fallback.
   - Loads `1555058318_internet_dataset.xlsx` and standardizes headers into valid R identifiers with `make.names()`.
2. **Exploratory Summaries:**
   - Evaluates parametric and non-parametric distributions (`min`, `max`, `mean`, `median`, `sd`) and checks categorical factor cardinality.
3. **Factor Encoding:**
   - Explicitly recodes categorical predictors (`Continent`, `Source.group`) into R `factor` data types.
4. **Bivariate Modeling (`Uniquepageviews ~ Visits`):**
   - Conducts Pearson correlation testing (`cor.test`) and fits a linear model (`lm`).
   - Generates scatter plots fitted with an OLS regression trendline.
5. **Multivariate Regression & Diagnostics (`Exits`):**
   - Fits the full model: `Exits ~ Bounces + Continent + Source.group + Timeinpage + Uniquepageviews + Visits`.
   - Evaluates variance decomposition with `anova()` and checks for severe collinearity with `vif()` (safeguarded against aliased terms).
   - Executes automated bidirectional stepwise selection (`step(..., direction = "both")`) to identify the minimum AIC model.
6. **Engagement Visualizations:**
   - Produces diagnostic scatter plots (`Exits` vs. `Bounces`, `Timeinpage`, `Uniquepageviews`, and `Visits`) and categorical factor distributions (`Continent`, `Source.group`) using `ggplot2`.
7. **Secondary Multivariate Models:**
   - Examines behavioral drivers of session duration (`Timeinpage`) and single-page bounce rates (`Bounces`) against engagement metrics.

---

## 🚀 Getting Started

### 1. Prerequisites
Install all required packages from CRAN:

```r
install.packages(c("readxl", "dplyr", "ggplot2", "car", "rstudioapi"))
