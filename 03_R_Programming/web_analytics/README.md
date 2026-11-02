# Web Analytics & User Behavior Modeling

An exploratory data analysis and statistical modeling project implemented in R to evaluate user engagement, assess the relationship between traffic volume and unique page views, and identify key drivers of user exits and session metrics using ordinary least squares (OLS) regression.

---

## 📁 Repository Contents

* [`web_analytics_script.R`](web_analytics_script.R): Main R script containing data ingestion, descriptive summarization, correlation testing, and linear regression modeling workflows.
* [`User_Behavior_Statistical_Analysis.pdf`](User_Behavior_Statistical_Analysis.pdf): Comprehensive report detailing the statistical findings and behavioral insights derived from the model outputs.
* [`Web_Analytics_Project_Overview.pdf`](Web_Analytics_Project_Overview.pdf): High-level project summary highlighting analytical objectives and methodology.
* [`web_analytics_brief.pdf`](web_analytics_brief.pdf): Project scope, business problem statement, and task guidelines.
* [`web_analytics_plot_visuals.pdf`](web_analytics_plot_visuals.pdf): Visual outputs, including scatter plots with fitted regression lines and categorical box plots.
* [`web_analytics_script2/`](web_analytics_script2): Additional supplementary scripts and experimental workflows.

---

## 🎯 Analytical Objectives

* **Metric Correlation:** Quantify the linear relationship between `Visits` and `Uniquepageviews` using Pearson correlation testing and bivariate regression modeling.
* **Exit Driver Analysis:** Determine which website engagement indicators (`Bounces`, `Timeinpage`, `Uniquepageviews`, `Visits`, `Continent`, and `Sourcegroup`) significantly impact total user `Exits`.
* **Multivariate Influence:** Examine secondary behavioral models assessing predictors that influence `Timeinpage` and `Bounces`.

---

## 🛠️ Tools & Libraries

* **Language:** R
* **Data Manipulation & Ingestion:** `readxl`, `dplyr`
* **Visualization:** `ggplot2`
* **Statistical Diagnostics:** `car` (used for Variance Inflation Factor / multicollinearity evaluation via `vif()`)

---

## 🔬 Methodology & Script Workflow

The analytical steps executed in [`web_analytics_script.R`](web_analytics_script.R) include:

1. **Data Ingestion & Cleaning:**
   * Loaded raw data (`1555058318_internet_dataset.xlsx`) and standardized column names to syntactic R formats via `make.names()`.
   * Converted categorical attributes (`Continent`, `Source.group`) into factor variables.
2. **Exploratory Data Summaries:**
   * Computed non-parametric and parametric summaries (`min`, `max`, `mean`, `median`, `sd`) for continuous metrics and cardinality checks for categorical fields.
3. **Bivariate Modeling (`Uniquepageviews ~ Visits`):**
   * Conducted Pearson correlation analysis (`cor.test`) and fitted a bivariate linear model (`lm`).
   * Plotted `Visits` against `Uniquepageviews` with a fitted regression trendline (`geom_smooth(method = "lm")`).
4. **Multivariate Regression & Diagnostics (`Exits`):**
   * Modeled `Exits` against engagement factors (`Bounces`, `Continent`, `Sourcegroup`, `Timeinpage`, `Uniquepageviews`, `Visits`).
   * Evaluated variance analysis using `anova()` and checked for multicollinearity using `vif()`.
   * Implemented automated bidirectional stepwise variable selection (`step(..., direction = "both")`) to identify optimal predictor subsets.
5. **Engagement Diagnostics:**
   * Generated distribution plots and bivariate diagnostics (`Exits` vs. `Bounces`, `Timeinpage`, `Visits`, and box plots segmented by `Continent` and `Sourcegroup`).
   * Fitted complementary OLS models evaluating drivers of user session duration (`Timeinpage`) and bounce behavior (`Bounces`).

---

## 🚀 Running the Script

1. Clone or download this repository directory.
2. Ensure required R packages are installed:
   ```R
   install.packages(c("car", "ggplot2", "dplyr", "readxl"))
