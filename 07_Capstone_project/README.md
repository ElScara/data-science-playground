# Restaurant Discovery & Recommendation Insights | Data Analytics Capstone

## Project Overview

An exploratory analysis of restaurant listings designed to support a **restaurant-discovery and recommendation-oriented B2C platform**. The work investigates geographic coverage, restaurant ratings, cuisine diversity, price levels, booking and delivery availability, and indicators of customer engagement.

The project brings together Python notebooks for inspection, cleaning, exploratory data analysis (EDA), and dashboard preparation, alongside a packaged Tableau workbook and a written capstone report.

> **Scope:** This repository documents exploratory analysis and dashboard preparation. A deployed recommendation engine or validated recommendation-model accuracy is **not** claimed here.

## Business Questions

- Which cities and restaurant brands have the greatest representation in the dataset?
- How are restaurant ratings distributed, and how do they relate to price, cuisine variety, and customer votes?
- How common are online delivery and table-booking services?
- Which cuisines appear most frequently?
- How can the insights support restaurant discovery, customer-facing filters, and marketing prioritization?

## Project Contents

| File | Description |
| --- | --- |
| [01_data_inspection_cleaning.ipynb](01_data_inspection_cleaning.ipynb) | Initial data inspection, missing-value checks, duplication checks, and cleaning steps. |
| [02_eda_analysis.ipynb](02_eda_analysis.ipynb) | Geographic, rating, franchise, booking, delivery, cuisine, pricing, and correlation analysis with charts. |
| [03_dashboard_prep.ipynb](03_dashboard_prep.ipynb) | Splits multi-cuisine fields into individual cuisine records to prepare data for Tableau. |
| [Untitled11.ipynb](Untitled11.ipynb) | Additional exploratory notebook with cleaning and comparison plots; retained under its original filename. |
| [zomato_cleaned.csv](zomato_cleaned.csv) | Cleaned restaurant data file included in the repository. |
| [DAshb.twbx](DAshb.twbx) | Packaged Tableau workbook for reviewing the dashboard. |
| [capstone write up.docx](capstone%20write%20up.docx) | Supporting capstone write-up. |

## Analytical Workflow

### 1. Data Inspection & Cleaning

The first notebook checks the shape of the data, missing fields, numeric summaries, and duplicate records. It includes steps for standardizing column names and exporting data for subsequent analysis.

### 2. Exploratory Data Analysis

The EDA notebook examines:

- **Geography:** The number of restaurants represented in each city.
- **Ratings:** The distribution of aggregate restaurant ratings.
- **Restaurant chains:** Repeated restaurant names as an indicator of presence across locations.
- **Services:** Table booking and online delivery availability.
- **Cuisine:** Popular cuisine types and the relationship between cuisine count and rating.
- **Cost:** Price distribution and associations between cost and ratings.
- **Engagement:** Customer vote totals and relationships with delivery services.

Visualizations include bar charts, distributions, box plots, scatter plots, and a correlation heatmap. The notebook saves figures to `../reports/figures/` when those directories exist.

### 3. Dashboard Preparation & Tableau

The dashboard-preparation notebook splits comma-separated cuisine names into individual records using Pandas `explode()`, providing a more useful structure for cuisine-level Tableau analysis.

The packaged workbook can be opened in **Tableau Desktop** (or another Tableau application that supports `.twbx` files). Some features or data connections may need attention depending on the Tableau version and packaged sources.

## Dashboard Screenshot (Optional)

An image can be added later without changing the structure of this README:

1. Export the Tableau dashboard as a PNG and name it `restaurant_dashboard.png`.
2. Commit it at `07_Capstone_project/images/restaurant_dashboard.png`.
3. Remove the HTML comment markers surrounding the image reference below.

<!--
![Restaurant analytics Tableau dashboard](images/restaurant_dashboard.png)
-->

No screenshot is included by this README change; the image reference is intentionally inactive until the asset is uploaded.

## Technology Stack

| Technology | Use |
| --- | --- |
| Python / Jupyter | Data inspection and exploratory analysis |
| Pandas / NumPy | Data manipulation and feature preparation |
| Matplotlib / Seaborn / Plotly | Statistical and business-oriented visualizations |
| Tableau | Dashboard reporting and visual exploration |
| CSV | Cleaned dataset storage |

## Reproducing the Analysis

Clone the repository and open the capstone folder:

```bash
git clone https://github.com/ElScara/data-science-playground.git
cd data-science-playground/07_Capstone_project
pip install pandas numpy matplotlib seaborn plotly openpyxl jupyter
jupyter notebook
```

**Important path limitations:** The notebooks were written against a different directory layout: some expect `../data/raw/data.xlsx`, `../data/raw/Country-Code.xlsx`, and `../data/processed/cleaned_data.csv`. These files and directories are **not** present at those paths in the current repository. One additional notebook expects a local `data.xlsx`. The included `zomato_cleaned.csv` may help with exploration, but its schema and cleaning lineage should be checked before substituting it into notebooks. To run the entire workflow, obtain the original raw inputs and adjust the file paths or refactor the notebooks to use the available dataset.

The first cleaning notebook also creates a `df_cleaned` object but later saves `df`; verify the intended cleaning output before relying on the exported file.

## Interpretation & Limitations

The charts and descriptive relationships are **exploratory**, not causal evidence. Franchise presence based on repeated names may need additional entity-resolution checks; online delivery and booking variables describe availability in the dataset rather than real-time restaurant services. Coverage and any recommendations depend on the representativeness and freshness of the underlying restaurant records.

## Skills Demonstrated

- Data cleaning and quality assessment
- Exploratory data analysis and statistical visualization
- Categorical transformation for dashboarding
- Business question framing
- Tableau dashboard development
- Communication of analytical findings

[Back to Data Science Playground](../README.md)
