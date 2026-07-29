#  Student Engagement Statistical Impact Analysis

## Tableau Dashboard
<img width="1600" height="900" alt="Dashboard" src="https://github.com/user-attachments/assets/f0009958-0feb-47ff-9cbc-267f1deec481" />


## Project Overview

This project is a comprehensive **statistical and predictive analysis** of student engagement on an online coaching platform, specifically evaluating the impact of new platform features launched between **Q2 2021 and Q2 2022**. The analysis moves beyond descriptive statistics to apply advanced hypothesis testing and predictive modeling to deliver **data-driven conclusions** on product success and strategy.

Full statistical writeup: [analysis/student_engagement_full_report.md](./analysis/student_engagement_full_report.md)

## Business Question

Did the introduction of new features (courses, career tracks, and exams) lead to a statistically significant increase in user engagement (Minutes Watched) for both Paid and Free student segments?

## Data Source

This analysis uses a course-work dataset (minutes watched and certificates issued, Q2 2021 vs. Q2 2022, Free vs. Paid segments) provided as part of a data analytics coursework project. 

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

## Core Business and Feature strategies:

1.  **Urgent Focus on Retained-Subscriber Re-Engagement (Primary Retention Strategy):**

       *    **The Insight:** 69.6% of subscribers who maintained paid subscriptions in both 2021 and 2022 showed declining engagement, with a severe 66.7% median drop in minutes watched.
       *    **The Strategy:** Prioritize returning paid subscribers for targeted win-back and re-engagement campaigns immediately. Because these users are actively disengaging while still paying, they represent a high risk for impending subscription cancellations.
    
2.  **Address Platform-Wide Retention (Product & Growth Strategy):**
 
    *    **The Insight:**  Only 7.2% of users who watched content in Q2 2022 had also watched content in Q2 2021. Repeat engagement from one year to the next is statistically lower than expected by chance.
    *    **The Strategy:** Treat retention as a platform-wide structural challenge across both Free and Paid tiers—rather than assuming it is isolated to paid subscribers—by building ongoing learning habits, milestone incentives, or long-term career track roadmaps.
3.  **Expand Behavioral Data Tracking Beyond Video (Feature & Modeling Strategy):**
    *    **The Insight:** The current Linear Regression model relies solely on `minutes_watched` to predict `certificates_issued`, achieving an $R^2$ of 0.2218 (explaining only ~22% of the variance).
    *    **The Strategy:** Future product and data efforts must prioritize collecting non-video behavioral metrics—such as assignments submitted, quiz completions, and practice time—to build stronger predictive models for student success and tailor feature recommendations.

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


-----
