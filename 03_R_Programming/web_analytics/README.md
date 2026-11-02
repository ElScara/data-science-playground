# Web Analytics & User Behavior Modeling

An exploratory data analysis and statistical modeling project implemented in R to evaluate user engagement, assess the relationship between traffic volume and unique page views, and identify key drivers of user exits and session metrics using ordinary least squares (OLS) regression and analysis of variance (ANOVA).

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

* **Metric Correlation:** Quantify whether `Uniquepageviews` depends on `Visits` using Pearson correlation testing and linear regression modeling.
* **Exit Driver Analysis:** Determine which website engagement indicators (`Bounces`, `Timeinpage`, `Uniquepageviews`, `Visits`, `Continent`, and `Source.group`) significantly impact total user `Exits`.
* **Multivariate Influence:** Examine secondary behavioral models assessing predictors that influence `Timeinpage` and user bounce behavior (`Bounces`).

---

## 🛠️ Tools & Libraries

* **Language:** R
* **Data Manipulation & Ingestion:** `readxl`, `dplyr`
* **Visualization:** `ggplot2`
* **Statistical Diagnostics:** `car` (Variance Inflation Factor evaluation via `vif()`)

---

## 💡 Key Statistical Findings

* **Correlation Between Visits & Unique Pageviews:** A strong positive linear correlation exists between `Visits` and `Uniquepageviews` ($r \approx 0.814, p < 2.2 \times 10^{-16}$), confirming that unique page views significantly depend on visit volume.
* **Primary Drivers of Exits:** Analysis of variance (ANOVA) demonstrates that **`Bounces`** and **`Uniquepageviews`** have the largest, most significant impact on website `Exits` ($p < 2.2 \times 10^{-16}$), followed by categorical dimensions (`Source.group` and `Continent`) and `Timeinpage`. Total `Visits` has comparatively lower relative significance in predicting exits.
* **Time on Page Predictors:** Evaluating factors affecting `Timeinpage` reveals that session duration is significantly influenced by `Exits`, `Uniquepageviews`, `Visits`, and `Bounces`, whereas `Source.group` shows no significant direct relationship.
* **Collinearity & Model Selection:** Bidirectional stepwise model selection (`step()`) eliminates redundant predictors to isolate the most parsimonious linear model for web exits.

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
   * Evaluates complementary models assessing drivers of session duration (`Timeinpage`) and user bounce behavior (`Bounces`).

---

## 🚀 Running the Script

1. Clone or download this repository directory.
2. Open RStudio and set your working directory to this folder (or open the script directly).
3. Run the script:
   ```R
   source("web_analytics_script.R")
