#  Student Engagement Statistical Impact Analysis

## Project Overview

This project is a comprehensive **statistical and predictive analysis** of student engagement on an online coaching platform, specifically evaluating the impact of new platform features launched between **Q2 2021 and Q2 2022**. The analysis moves beyond descriptive statistics to apply advanced hypothesis testing and predictive modeling to deliver **data-driven conclusions** on product success and strategy.

## Business Question

Did the introduction of new features (courses, career tracks, and exams) lead to a statistically significant increase in user engagement (Minutes Watched) for both Paid and Free student segments?

## Key Findings & Conclusions

The analysis revealed a complex "paradox" in user behavior, where features succeeded with the average user but failed with high-intensity consumers.

| Cohort | Mean Engagement Change (YoY) | Statistical Evidence (T-Test) | Strategic Implication |
| :--- | :--- | :--- | :--- |
| **Free Users** | **Significantly Increased** ($\mu_{2022} > \mu_{2021}$) | **Reject $\text{H}_0$** ($P \ll 0.05$) | **Success:** Features drive new user acquisition and engagement. |
| **Paid Users** | **Significantly Decreased** ($\mu_{2022} < \mu_{2021}$) | **Fail to Reject $\text{H}_0$ for Increase** | **Failure:** Features failed to retain high-volume "super-users," causing the mean to drop despite the median doubling. |

### Predictive Modeling Insight ($R^2$ Analysis)

The Linear Regression model correlating Minutes Watched with Certificates Issued yielded an **$R^2$ value of $0.2218$**. This confirms that **only $22.18\%$ of certification variance is explained by watch time**, proving that Minutes Watched alone is a **poor predictor** of achievement. This necessitates incorporating behavioral metrics (e.g., assignments, practice time) for future modeling.

##  Technical Stack & Methodology

| Category | Tools & Libraries | Application |
| :--- | :--- | :--- |
| **Data Handling** | **SQL, Pandas** | Data extraction, cleaning, segmentation (Paid vs. Free, Q2 2021 vs. Q2 2022), and outlier removal (99th percentile). |
| **Statistical Analysis** | **Excel** | Calculation of Mean, Median, 95% Confidence Intervals (CI). Validation of assumptions via **F-Tests**. **Two-Sample Independent T-Tests** for hypothesis testing. |
| **Modeling & Prediction** | **Scikit-learn** | Linear Regression model to assess the relationship between Minutes Watched and Certificates Earned. |
| **Visualization** | **Matplotlib, Tableau** | Visualization of skewed distributions (KDE plots) and dashboard creation for communicating core insights (CI, Median vs. Mean Paradox). |



## Key Takeaways for Business Strategy

1.  **Retention Focus:** An urgent investigation into the high-engagement (top 10%) Paid user segment is required to identify why new features led to a drop in their consumption.
2.  **Model Expansion:** Future data science efforts must prioritize collecting and modeling non-video behavioral data to accurately predict student success.

-----
