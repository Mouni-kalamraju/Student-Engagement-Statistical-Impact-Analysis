#  Student Engagement Statistical Impact Analysis

## Project Overview

This project is a comprehensive **statistical and predictive analysis** of student engagement on an online coaching platform, specifically evaluating the impact of new platform features launched between **Q2 2021 and Q2 2022**. The analysis moves beyond descriptive statistics to apply advanced hypothesis testing and predictive modeling to deliver **data-driven conclusions** on product success and strategy.

Full statistical writeup: [analysis/student_engagement_full_report.md](./analysis/student_engagement_full_report.md)

## Business Question

Did the introduction of new features (courses, career tracks, and exams) lead to a statistically significant increase in user engagement (Minutes Watched) for both Paid and Free student segments?

## Data Source

This analysis uses a course-work dataset (minutes watched and certificates issued, Q2 2021 vs. Q2 2022, Free vs. Paid segments) provided as part of a data analytics coursework project. Noted here for transparency since the dataset's provenance affects how findings should be generalized.

## Key Findings & Conclusions

The analysis revealed a genuine mean-median divergence — and student-level cohort tracking (matching student IDs across years) reveals exactly which subscribers are driving it.

| Cohort | Mean Change (YoY) | Median Change (YoY) | Statistical Evidence (T-Test) | Strategic Implication |
| :--- | :--- | :--- | :--- | :--- |
| **Free Users** | +12.9% | **+78.5%** | Reject $\text{H}_0$ ($P \ll 0.05$) | **Success:** Typical (median) engagement nearly doubled — broad-based growth across the majority of free users, not just a few outliers. |
| **Paid Users** | −18.9% | **−26.0%** | Fail to Reject $\text{H}_0$ for Increase ($P \ll 0.05$, decline confirmed) | **Decline driven by retained-subscriber disengagement:** Cohort tracking shows 83.4% of the 2022 paid base are new subscribers (not the cause of the decline — their median engagement is actually higher than returning subscribers'). The decline is concentrated in the 457 returning subscribers, whose median engagement fell 66.7% year-over-year (paired t = 8.26, p = 1.6×10⁻¹⁵) — these are paying customers quietly disengaging while remaining subscribed. |

### Predictive Modeling Insight (R² Analysis)

A Linear Regression model (`minutes_watched` → `certificates_issued`, 80/20 train/test split, `random_state=365` per project spec) yields:

* **Linear equation:** certificates = 1.211 + 0.00169 × minutes_watched
* **R² (training set):** **0.2218**
* **Prediction for a student who watched 1,200 minutes:** 3.24 → **rounded up to 4 certificates**

An R² of 0.2218 means only about **22% of the variance in certificates issued is explained by minutes watched alone** — a moderate-to-weak predictor, and future modeling should incorporate additional behavioral metrics (e.g., assignments, practice time).

*Supplementary check: scoring this same model on the held-out test set instead of the training set gives R² = 0.468 — notably higher, which is a useful reminder that with a dataset this size (~659 rows, ~132-row test set), a single train/test split carries real sampling variance. The 0.2218 training-set figure above is the one specified by the project methodology and used consistently throughout this writeup.*

##  Technical Stack & Methodology

| Category | Tools & Libraries | Application |
| :--- | :--- | :--- |
| **Data Handling** | **SQL, Pandas** | Data extraction, cleaning, segmentation (Paid vs. Free, Q2 2021 vs. Q2 2022), and outlier removal (99th percentile). |
| **Statistical Analysis** | **Excel** | Calculation of Mean, Median, 95% Confidence Intervals (CI). Validation of assumptions via **F-Tests**. **Two-Sample Independent T-Tests** for hypothesis testing. |
| **Modeling & Prediction** | **Scikit-learn** | Linear Regression model to assess the relationship between Minutes Watched and Certificates Earned. |
| **Visualization** | **Matplotlib, Tableau** | Visualization of skewed distributions (KDE plots) and dashboard creation for communicating core insights (CI, Median vs. Mean divergence). |

## Key Takeaways for Business Strategy

1.  **Retained-Subscriber Re-engagement (Urgent):** 69.6% of subscribers who paid in both 2021 and 2022 show declining engagement, with a 66.7% median drop — a strong leading indicator of future cancellation despite currently-active subscriptions. This group, not new subscribers, should be the immediate retention priority.
2.  **Platform-Wide Low Retention:** Only 7.2% of Q2 2022 watchers had also watched in Q2 2021 — watching in one quarter is statistically dependent on (and lower than chance predicts for) watching in the other. Retention is a platform-wide challenge, not one confined to Paid users.
3.  **Model Expansion:** Future data science efforts must prioritize collecting and modeling non-video behavioral data to accurately predict student success.

## Repository Structure

```
├── README.md
├── requirements.txt
├── data/
│   └── raw/
│       └── student_engagement_database_dump.sql   # Raw source MySQL database
├── sql/
│   └── data_handling.sql                          # Data extraction & transformation queries
├── notebooks/
│   └── student_engagement_analysis.ipynb          # Data cleaning, cohort tracking, regression model
├── analysis/
│   ├── student_engagement_full_report.md          # Full statistical writeup
│   └── statistical_analysis.xlsx                  # Excel-based hypothesis testing & CI calculations
└── dashboard/
    └── student_engagement_dashboard.twbx           # Tableau dashboard workbook
```

## Tableau Dashboard
<img width="1600" height="900" alt="Dashboard" src="https://github.com/user-attachments/assets/f0009958-0feb-47ff-9cbc-267f1deec481" />

-----
