# Web Analytics & User Behavior Modeling

An exploratory data analysis and statistical modeling project implemented in R to evaluate user engagement, assess the relationship between traffic volume and unique page views, and identify key drivers of user exits and session metrics using ordinary least squares (OLS) regression.

---

## 📁 Repository Contents

* [`1555058318_internet_dataset.xlsx`](1555058318_internet_dataset.xlsx): Source web analytics dataset containing session metrics and user categorical dimensions.
* [`web_analytics_script.R`](web_analytics_script.R): Main R script containing data ingestion, descriptive summarization, correlation testing, diagnostic plotting, and linear regression workflows.
* [`User_Behavior_Statistical_Analysis.pdf`](User_Behavior_Statistical_Analysis.pdf): Comprehensive report detailing statistical findings and behavioral insights derived from model outputs.
* [`Web_Analytics_Project_Overview.pdf`](Web_Analytics_Project_Overview.pdf): High-level project summary highlighting analytical objectives and methodology.
* [`web_analytics_brief.pdf`](web_analytics_brief.pdf): Project scope, business problem statement, and task guidelines.
* [`web_analytics_plot_visuals.pdf`](web_analytics_plot_visuals.pdf): Visual outputs, including scatter plots with fitted regression lines and categorical box plots.

---

## 🎯 Analytical Objectives

* **Metric Correlation:** Quantify the linear relationship between `Visits` and `Uniquepageviews` using Pearson correlation testing and bivariate regression modeling.
* **Exit Driver Analysis:** Determine which website engagement indicators (`Bounces`, `Timeinpage`, `Uniquepageviews`, `Visits`, `Continent`, and `Source.group`) significantly impact total user `Exits`.
* **Multivariate Influence:** Examine secondary behavioral models assessing predictors that influence `Timeinpage` and `Bounces`.

---

## 🛠️ Tools & Libraries

* **Language:** R
* **Data Manipulation & Ingestion:** `readxl`, `dplyr`
* **Visualization:** `ggplot2`
* **Statistical Diagnostics:** `car` (used for Variance Inflation Factor / multicollinearity evaluation via `vif()`)

---

## 💡 Key Analytical Findings

* **Volume Scaling:** `Visits` and `Uniquepageviews` exhibit an almost perfect positive linear correlation ($r \approx 0.99$), confirming predictable baseline user acquisition across traffic channels.
* **Primary Exit Drivers:** In multiple linear regression modeling, `Bounces` and `Visits` serve as the primary statistically significant predictors of user `Exits` ($p < 0.001$).
* **Collinearity & Selection:** Substantial collinearity between visit volume metrics was diagnosed via `vif()`, and bidirectional stepwise regression successfully reduced model redundancy to isolate the most impactful engagement signals.
* **Session Duration Impact:** Session duration (`Timeinpage`) exhibits minimal direct predictive power over exit spikes compared to direct bounce events.

---

## 🔬 Methodology & Script Workflow

The analytical steps executed in [`web_analytics_script.R`](web_analytics_script.R) include:

1. **Data Ingestion & Cleaning:**
   * Loads `1555058318_internet_dataset.xlsx` using local path detection with interactive fallback.
   * Standardizes column names to syntactic R formats via `make.names()` and encodes categorical attributes (`Continent`, `Source.group`) as factors.
2. **Exploratory Data Summaries:**
   * Computes parametric and non-parametric statistics (`min`, `max`, `mean`, `median`, `sd`) and evaluates categorical cardinality.
3. **Bivariate Modeling (`Uniquepageviews ~ Visits`):**
   * Conducts Pearson correlation analysis (`cor.test`) and fits a bivariate linear model (`lm`).
   * Visualizes relationship using `ggplot2` with an OLS regression trendline.
4. **Multivariate Regression & Diagnostics (`Exits`):**
   * Fits full OLS regression modeling `Exits` against engagement factors.
   * Evaluates variance analysis via `anova()` and checks collinearity via `vif()`.
   * Implements automated bidirectional stepwise variable selection (`step(..., direction = "both")`).
5. **Engagement Diagnostics & Secondary Models:**
   * Generates distribution plots and categorical box plots segmented by `Continent` and `Source.group`.
   * Evaluates complementary OLS models assessing drivers of session duration (`Timeinpage`) and user bounce behavior (`Bounces`).

---

## 🚀 Running the Script

1. Clone or download this repository directory.
2. Open RStudio and set your working directory to this folder (or open the script directly).
3. Run the script:
   ```R
   source("web_analytics_script.R")
