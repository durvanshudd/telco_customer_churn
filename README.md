# 📊 Telco Customer Churn Analysis

![Python](https://img.shields.io/badge/Python-3.9%2B-blue)
![Pandas](https://img.shields.io/badge/Pandas-data%20wrangling-150458)
![PostgreSQL](https://img.shields.io/badge/PostgreSQL-SQL%20analysis-336791)
![SciPy](https://img.shields.io/badge/SciPy-hypothesis%20testing-8CAAE6)
![Status](https://img.shields.io/badge/status-completed-brightgreen)

> An end-to-end data analysis project investigating **why customers churn** from a telecom provider — combining Python-based data cleaning, SQL-driven business analysis, and formal statistical hypothesis testing to separate real drivers of churn from noise.

---

## Table of Contents

- [Overview](#overview)
- [Dataset](#dataset)
- [Project Structure](#project-structure)
- [Objectives](#objectives)
- [Tools & Technologies](#tools--technologies)
- [Methodology](#methodology)
- [Key Findings](#key-findings)
- [Statistical Validation Summary](#statistical-validation-summary)
- [Business Takeaways](#business-takeaways)
- [Setup & Installation](#setup--installation)
- [How to Run](#how-to-run)
- [Bug Fixes & Data Quality Corrections](#bug-fixes--data-quality-corrections)
- [Future Improvements](#future-improvements)
- [Author](#author)
- [Acknowledgments](#acknowledgments)

---

## Overview

Customer churn — when a subscriber stops using a company's service — is one of the most direct threats to recurring revenue in the telecom industry. This project analyzes the **IBM Telco Customer Churn** dataset to understand which customers are leaving, why they're leaving, and where the business is most exposed to revenue loss.

The project is organized as three sequential Jupyter notebooks, each handling one stage of the analysis pipeline: cleaning, exploratory/SQL analysis, and statistical validation.

## Dataset

- **Source:** [Telco Customer Churn — Kaggle](https://www.kaggle.com/datasets/blastchar/telco-customer-churn) (originally distributed as an IBM sample dataset)
- **Size:** 7,043 customer records × 21 columns
- **Target variable:** `Churn` (Yes/No)

| Category | Columns |
|---|---|
| Identifier | `customerID` |
| Demographics | `gender`, `SeniorCitizen`, `Partner`, `Dependents` |
| Account information | `tenure`, `Contract`, `PaperlessBilling`, `PaymentMethod`, `MonthlyCharges`, `TotalCharges` |
| Services subscribed | `PhoneService`, `MultipleLines`, `InternetService`, `OnlineSecurity`, `OnlineBackup`, `DeviceProtection`, `TechSupport`, `StreamingTV`, `StreamingMovies` |
| Target | `Churn` |

## Project Structure

Inferred from the relative paths used in the notebooks (`Path("..") / "Data" / ...` and `Path("..") / "Queries" / ...`) — rename to match your actual folder names if they differ:

```
├── Data/
│   └── Telco-Customer-Churn.csv
├── Notebooks/
│   ├── 01_Data_Cleaning.ipynb
│   ├── 02_EDA_and_SQL_queries.ipynb
│   └── 03_Stastistical_Testing.ipynb
├── Queries/
│   ├── 01_churn_rate_by_contract_type.sql
│   ├── 02_churn_rate_by_tenure_period.sql
│   ├── 03_churn_rate_by_Services_provided.sql
│   ├── 04_churn_rate_by_internet_type.sql
│   ├── 05_churn_rate_by_payment_method.sql
│   ├── 06_churn_rate_by_charge_category.sql
│   ├── 07_churn_rate_by_household_status.sql
│   ├── 08_churn_rate_by_age_status.sql
│   ├── 09_High_risk_profiles.sql
│   └── 10_Monthly_revenue_at_risk.sql
├── .env                # not committed — holds DB credentials
├── requirements.txt
└── README.md
```

## Objectives

- Load, audit, and clean the raw dataset so it's reliable for downstream analysis
- Calculate headline KPIs — churn rate, retention rate, revenue at risk
- Use SQL to answer business-focused questions about *who* churns and *why*
- Identify high-risk customer profiles and quantify their revenue impact
- Validate the EDA findings with formal statistical hypothesis tests
- Translate the findings into concrete retention recommendations

## Tools & Technologies

| Purpose | Technology |
|---|---|
| Language | Python 3.9+ |
| Data wrangling | Pandas, NumPy |
| Visualization | Matplotlib, Seaborn |
| Database & SQL | PostgreSQL, `psycopg2` |
| Statistics | SciPy (`scipy.stats`) |
| Config management | `python-dotenv` |
| Environment | Jupyter Notebook |

## Methodology

### 1️⃣ Data Cleaning — `01_Data_Cleaning.ipynb`

- Loaded the raw CSV (7,043 rows × 21 columns) and ran an initial data-quality assessment (dtypes, missing values, unique values per column)
- Checked for explicit nulls and duplicate rows
- Detected 11 records where `TotalCharges` was a **blank string** rather than a true null, converted the column to numeric, and filled the resulting missing values
- Removed records with non-positive `tenure`, `MonthlyCharges`, or `TotalCharges`
- Standardized `SeniorCitizen` into readable `Yes` / `No` categorical values
- Re-validated the cleaned dataset before handing it off to the analysis stage

### 2️⃣ EDA & SQL Analysis — `02_EDA_and_SQL_queries.ipynb`

Connects to a PostgreSQL database and computes headline KPIs (total/churned/retained customers, churn rate, retention rate, monthly revenue, revenue loss, ARPU, average tenure), then runs 10 SQL queries to answer specific business questions:

1. Churn rate by contract type
2. Churn rate by tenure period
3. Churn rate by services provided
4. Churn rate by internet type
5. Churn rate by payment method
6. Churn rate by charge category (discounts/add-ons)
7. Churn rate by household status (partner/dependents)
8. Churn rate by customer age status
9. High-risk customer profiles
10. Monthly revenue at risk from high-risk profiles

### 3️⃣ Statistical Testing — `03_Stastistical_Testing.ipynb`

Formally tests whether the patterns observed in the EDA stage are statistically significant, using a significance level of **α = 0.05** throughout:

- **Welch's t-test** — compares mean `tenure` and `MonthlyCharges` between churned and retained customers (does not assume equal variance)
- **Chi-square test of independence** — tests association between churn and `gender`, `Partner`, and `Dependents`

## Key Findings

**From the SQL/EDA analysis:**

- Customers on **month-to-month** contracts churn at a noticeably higher rate than annual or two-year contract holders
- Churn is heavily concentrated in the **first 0–12 months** of tenure
- **Streaming service** subscribers churn more, while **tech support** and **online security** subscribers churn less
- **Fiber optic** internet customers churn roughly **6×** more than customers with no internet service
- Customers paying by **electronic check** churn significantly more than those on automatic payment methods
- Customers receiving **discounts or add-on charges** churn about **3× less** than those receiving neither
- **Senior citizens** show a higher churn rate than non-senior customers (see the note in [Bug Fixes](#bug-fixes--data-quality-corrections) below before relying on this one)
- A **high-risk profile** — defined by contract type, tenure period, and internet service — was found for **916 customers**: 643 have already churned, and **273 remain as high-potential future churn**
- This high-risk segment is just **13.01%** of the customer base but accounts for a **70.2% churn rate** (vs. 20.0% for everyone else) and **38.2%** of total monthly revenue at risk
- Average monthly revenue at risk is **$82.70 per churned customer**, pushing potential monthly revenue at risk up by **42%**

**From statistical testing:** see the [Statistical Validation Summary](#statistical-validation-summary) below.

## Statistical Validation Summary

| Variable | Test | p-value | Significant at α = 0.05? | Direction |
|---|---|---|---|---|
| Tenure | Welch's t-test | ≈ 1.20 × 10⁻²³² | ✅ Yes | Churned customers have shorter tenure |
| Monthly Charges | Welch's t-test | ≈ 8.59 × 10⁻⁷³ | ✅ Yes | Churned customers pay more per month |
| Gender | Chi-square | 0.4866 | ❌ No | No meaningful association with churn |
| Partner status | Chi-square | ≈ 2.14 × 10⁻³⁶ | ✅ Yes | No-partner customers churn more |
| Dependents | Chi-square | ≈ 4.92 × 10⁻⁴³ | ✅ Yes | No-dependents customers churn more |

An interesting nuance: the SQL/EDA stage looked at partner + dependents together as a single "household status" segment and found it a relatively weak predictor, but the statistical tests treat them as **separate** variables — and both turn out to be individually significant. The combined view was masking a real effect.

## Business Takeaways

- **Target the first year.** Retention offers and proactive check-ins in months 0–12 address the single largest churn window.
- **Make month-to-month customers stickier.** Incentivize upgrades from month-to-month to longer-term contracts (e.g., a discount for a 1-year commitment).
- **Fix the electronic check experience — or nudge customers off it.** Encourage a switch to automatic payment methods, which show much lower churn.
- **Bundle support and security services.** Customers with tech support and online security churn less; consider bundling these with streaming plans.
- **Prioritize the high-risk segment.** With 13% of customers responsible for 38% of revenue at risk, retention spend is best concentrated here first.

## Setup & Installation

**Prerequisites:** Python 3.9+, PostgreSQL running locally (or accessible remotely), `pip`.

1. **Clone the repository** and navigate into it.

2. **Create and activate a virtual environment:**
   ```bash
   python -m venv venv
   source venv/bin/activate   # Windows: venv\Scripts\activate
   ```

3. **Install dependencies:**
   ```bash
   pip install pandas numpy matplotlib seaborn scipy psycopg2-binary python-dotenv jupyter
   ```
   Or, using a `requirements.txt`:
   ```
   pandas
   numpy
   matplotlib
   seaborn
   scipy
   psycopg2-binary
   python-dotenv
   jupyter
   ```

4. **Configure database credentials.** Create a `.env` file in the project root:
   ```
   DB_NAME=your_database_name
   DB_USER=your_database_user
   DB_PASSWORD=your_database_password
   ```
   (The host is currently hardcoded to `localhost` in the notebooks — update that directly if your database is elsewhere.)

5. **Load the cleaned data into PostgreSQL** in a table matching what the queries in `Queries/` expect, before running the second notebook.

## How to Run

Run the notebooks **in order** — each stage depends on the previous one:

```bash
jupyter notebook
```

1. `01_Data_Cleaning.ipynb` — produces the cleaned dataset
2. `02_EDA_and_SQL_queries.ipynb` — KPIs, SQL business analysis, high-risk profiling
3. `03_Stastistical_Testing.ipynb` — hypothesis tests validating the EDA findings

## Bug Fixes & Data Quality Corrections

Issues identified and resolved during development:

1. **Blank strings masquerading as "no missing data."** Standard null checks (`isna()`/`isnull()`) reported zero missing values, but `TotalCharges` actually contained 11 records with blank whitespace strings rather than true `NaN`s — invisible to a null check, but fatal to a numeric conversion. **Fix:** explicitly detected blank strings via a stripped-string comparison, then converted the column with `pd.to_numeric(..., errors="coerce")` and filled the resulting missing values.
2. **Invalid zero/negative values skewing calculations.** A handful of records had zero or negative `tenure`, `MonthlyCharges`, or `TotalCharges` values, which would have distorted KPI calculations and statistical test results. **Fix:** filtered out any row where these fields weren't strictly positive before analysis.

> Add any other bugs you fixed along the way (environment setup, dependency conflicts, notebook/kernel issues, SQL connection errors, etc.) — this section is meant to keep growing as you run into and resolve issues.

## Future Improvements

- Train a predictive model (e.g., logistic regression, random forest, XGBoost) to score churn risk per customer
- Build an interactive dashboard (Streamlit, Power BI, or Tableau) on top of the SQL queries
- Automate the CSV → PostgreSQL load step with a script instead of a manual step
- Add confidence intervals / effect sizes alongside the p-values for richer statistical reporting
- Expand hypothesis testing to the remaining categorical variables (contract type, internet type, payment method)

## Author

**Durvanshu**

## Acknowledgments

- Dataset: [Telco Customer Churn](https://www.kaggle.com/datasets/blastchar/telco-customer-churn) on Kaggle, originally sourced from IBM's sample data sets
