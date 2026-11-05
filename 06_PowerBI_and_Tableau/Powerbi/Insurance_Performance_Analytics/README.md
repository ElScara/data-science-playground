# Insurance Performance Analytics Dashboard

An end-to-end Power BI business intelligence solution designed to track, evaluate, and optimize underwriting performance, distribution channels, and policy profitability across commercial and personal insurance lines.

---

## 📌 Project Overview

This project provides insurance executives, underwriters, and portfolio managers with granular visibility into core operating metrics. By analyzing quotation activity, policy conversions (hit ratios), written premiums, loss ratios, and retention rates, this analytics suite enables data-driven underwriting strategies and channel partner evaluation.

---

## 📊 Key Metrics & Business Concepts

The data model processes transaction- and aggregate-level insurance metrics defined using custom DAX calculations:

- **Total Written Premium (Total WRTN):** Aggregate revenue generated from bound policies across lines of business.
- **Hit Ratio (Quote-to-Bind Conversion):** Measures quotation efficiency and competitive win rates across distinct agency automation/quoting platforms:
  - **Commercial Lines (CL):** Platforms include `eQT`, `MDS`, and `SBZ`.
  - **Personal Lines (PL):** Platforms include `APPLIED`, `ELINKS`, `eQTte`, `PLRANK`, and `TRANSACTNOW`.
- **Average Retention Ratio:** Tracking policyholder continuity and renewal health.
- **Average Loss Ratio:** Evaluates claims risk exposure and underwriting profitability, filtered to exclude null/blank reporting periods.

---

## 📐 Data Modeling & DAX Implementation

Key measures implemented in Power BI:

### 1. Loss & Retention Performance
```dax
Avg_Loss_Ratio = 
CALCULATE(
    AVERAGE(finalapi[LOSS_RATIO]), 
    NOT(ISBLANK(finalapi[LOSS_RATIO]))
)

Avg_Retention_Ratio = 
AVERAGE(finalapi[RETENTION_RATIO])
