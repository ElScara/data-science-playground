# Google Play Store App Rating Prediction

An end-to-end exploratory data analysis and predictive modeling workflow using Python, Pandas, and Scikit-learn to clean messy mobile app data, treat high-leverage outliers, and model user ratings via Ordinary Least Squares (OLS) Linear Regression.

## 📁 Repository Contents
* [App_Rating_Prediction.ipynb](App_Rating_Prediction.ipynb): Full Jupyter Notebook containing data ingestion, string cleaning, outlier clipping, log transforms, dummy encoding, and model evaluation.
* [googleplaystore.csv](googleplaystore.csv): The raw source dataset of 10,841 mobile application records across 13 feature columns.
* [App_Rating_Analysis_and_Model.pdf](App_Rating_Analysis_and_Model.pdf): Project documentation synthesizing data behavior, cleaning rationale, and linear modeling outcomes.
* [App_rating_Prediction_brief.pdf](App_rating_Prediction_brief.pdf): Business requirements, variable specifications, and project scope.
* [App_rating_prediction_visuals.pdf](App_rating_prediction_visuals.pdf): Step-by-step analytical visual deck of univariate histograms, box plots, and bivariate joint distributions.
* [App_rating_prediction_visuals_summary.pdf](App_rating_prediction_visuals_summary.pdf): Summary deck condensing visual distributions and analytical conclusions.

## 🎯 Analytical Objective
To clean and prepare the Google Play Store dataset, examine whether core metadata variables (such as installs, file size, review volume, category, and pricing) reliably predict an app's aggregate user rating, and measure the goodness-of-fit ($R^2$) of a baseline linear model.

## 🛠️ Data Preprocessing & Feature Engineering
* **Missing Value Handling:** Dropped records with null ratings and metadata, reducing the initial dataset from 10,841 down to 9,360 records.
* **String Parsing & Unit Normalization:**
  * `Size`: Handled mixed `'M'` and `'k'` suffixes by converting all values to kilobytes (KB) via a custom parsing function; imputed remaining `'Varies with device'` values with the median size.
  * `Installs`: Stripped `+` and `,` characters, casting strings to integer counts.
  * `Price`: Stripped `$` symbols and converted to float values.
  * `Reviews`: Converted to numeric float values.
* **Sanity Validation:**
  * Dropped rows with ratings strictly outside the valid 1 to 5 range.
  * Filtered out invalid records where `Reviews > Installs`.
  * Removed entries designated as `Type == 'Free'` with `Price > 0`.
* **Outlier Removal:**
  * Truncated high-price outliers (`Price >= 200`), removing junk applications (e.g., "I Am Rich" variants) and capping the maximum remaining app price at `$79.99`.
  * Removed applications with extreme review volumes (`Reviews > 2,000,000`), bringing the maximum review count to 1,986,068.
  * Identified that the 90th and 95th percentiles of installs clustered at 10,000,000, while the 99th percentile surged to 100,000,000; pruned values above the 95th percentile (`Installs > 10,000,000`), yielding a final modeling set of **8,496 rows**.
* **Log Transformation:** Applied `np.log1p()` to right-skewed predictors (`Reviews` and `Installs`) to stabilize variance.
* **Categorical Encoding:** One-hot encoded `Category`, `Genres`, `Content Rating`, and `Type` using `pd.get_dummies(..., drop_first=True)`, expanding the feature matrix to **156 predictors**.

## 📊 Exploratory Findings
* **Rating Distribution:** Heavily left-skewed with most apps scoring between 4.0 and 5.0.
* **Price vs. Rating:** Most apps are free or priced under $10; higher price tags show no measurable association with higher ratings.
* **Size vs. Rating:** App weights vary widely across the 0 to 100,000 KB spectrum, but file size demonstrates minimal influence on aggregate user sentiment.
* **Reviews vs. Rating:** High ratings occur across all review brackets, with the highest scores often concentrated among apps with low overall review counts.
* **Category Variations:** Categories such as `Events` and `Health & Fitness` display higher relative median rating distributions compared to broad store averages.

## ⚙️ Model Architecture & Evaluation
* **Train/Test Split:** 70% Train (5,947 rows) / 30% Test (2,549 rows), evaluated with `random_state=0`.
* **Algorithm:** Ordinary Least Squares `LinearRegression()` from `sklearn.linear_model`.
* **Goodness-of-Fit:**
  * **Train $R^2$:** `0.1072` (~10.7% variance explained)
  * **Test $R^2$:** `0.0874` (~8.7% variance explained)

The baseline linear regression demonstrates low predictive power, showing that mobile app ratings are largely driven by qualitative product satisfaction and utility rather than raw store metadata metrics.

## 🚀 Running the Notebook
1. Clone or download [App_Rating_Prediction.ipynb](App_Rating_Prediction.ipynb) and [googleplaystore.csv](googleplaystore.csv) into the same working directory.
2. Ensure dependencies are installed:
   ```bash
   pip install numpy pandas matplotlib seaborn scikit-learn
