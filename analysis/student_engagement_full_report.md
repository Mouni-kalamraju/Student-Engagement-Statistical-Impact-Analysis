
# Student Engagement and Statistical Impact Analysis
This report summarizes the analysis of student engagement on an online coaching platform, comparing performance in Q2 2021 vs. Q2 2022 to assess the impact of newly launched features. The project utilized SQL, Excel, and Python for data handling, statistical inference, and predictive modeling.

## 1. Project Methodology and Data Preparation (Steps 1-4)

The project established a robust dataset by defining key engagement periods and ensuring data quality.

### Data Extraction and Segmentation (Steps 1 & 2)

* **Data Preparation:** Student first engagement, subscription end dates (based on plans), and refunds were calculated and managed.
* **Cohort Creation:** Students were segregated into four cohorts for Year-over-Year (YoY) comparison: Paid Q2 2021, Free Q2 2021, Paid Q2 2022, and Free Q2 2022.

### Metric Creation and Cleaning (Steps 3 & 4)

* **Core Metrics:** Minutes Watched (engagement) and Certificates Earned (achievement) were calculated.
* **Exploratory Data Analysis (EDA):** KDE plots visualized the highly right-skewed distribution of Minutes Watched, confirming that most students consume low amounts of content.
* **Outlier Treatment:** The top 1% of outliers for Minutes Watched were removed. This process was highly precise, affecting approximately **1.0% of the student population** in each cohort.

---

## 2. Statistical Inference and Hypothesis Testing (Steps 5-7)

The analysis validated changes in engagement using descriptive statistics (Mean, Median) and inferential statistics (CI, T-test, F-test).

### Central Tendency and Variance Validation (Steps 5 & F-Test)

| Analysis Group | Student Count (N - Cleaned) | Mean ($\bar{x}$) | **Median** | 95% Confidence Interval (CI) | F-Test P-value | Variance Assumption |
| :--- | :--- | :--- | :--- | :--- | :--- | :--- |
| **Paid Students (Q2 2021)** | **2,281** | 360.10 | 161.93 | 339.6 – 380.6 | N/A | Unequal |
| **Paid Students (Q2 2022)** | **2,758** | 292.22 | 119.75 | 276.5 – 307.9 | $2.0 \times 10^{-18}$ | Unequal (Welch's Test Used) |
| **Free Students (Q2 2021)** | **5,280** | 14.21 | 2.79 | 13.55 – 14.87 | N/A | Equal |
| **Free Students (Q2 2022)** | **5,994** | 16.04 | 4.98 | 15.41 – 16.66 | $0.428$ | Equal (Pooled T-test Used) |

### Hypothesis Testing (T-Test) Results

| Cohort | T-Statistic | P($T \le t$) One-Tail | Decision | Feature Impact Inference |
| :--- | :--- | :--- | :--- | :--- |
| Free-Plan Students | $-3.95$ | $3.82 \times 10^{-5}$ | Reject $\text{H}_0$ | Successful (Significant Increase) |
| Paying Students | $+5.15$ | $1.33 \times 10^{-7}$ | Fail to Reject $\text{H}_0$ | Unsuccessful (Confirmed Significant Decline) |

---

## 3. Analysis of Findings: Tracing the Paid Decline to Its Source

Both cohorts show mean and median moving together in direction (both up for Free, both down for Paid) — but simply looking at population-level statistics doesn't reveal *who* is driving the Paid decline. Because student IDs repeat across years in the raw data, individual students can be tracked from 2021 to 2022, which allows the decline to be decomposed into "new subscribers" vs. "returning subscribers" rather than treated as a single undifferentiated population.

### Free Cohort: Broad-Based Growth, Not Just Acquisition

* **Acquisition Success:** The Free cohort grew by $\approx 13.5\%$ (from 5,280 to 5,994 students).
* **Engagement Growth — the real divergence:** Mean engagement rose a modest $+12.9\%$, but **median engagement rose $+78.5\%$** (2.79 → 4.98 minutes). A median that grows six times faster than the mean means the *typical* free user is engaging substantially more than before — broad-based growth across the bulk of the distribution, not a shift driven by a handful of outliers.
* **Conclusion:** The new features succeeded at both expanding the free user base and meaningfully increasing typical engagement within it.

### Paid Cohort: Isolating the Decline via Student-Level Cohort Tracking

**Step 1 — Who makes up the 2022 Paid population?**

| Group | N | Share of 2022 Paid base |
| :--- | :--- | :--- |
| New subscribers (not paid in 2021) | 2,301 | 83.4% |
| Returning subscribers (paid in both 2021 and 2022) | 457 | 16.6% |

**Step 2 — Which group has lower engagement?** If new, lower-engagement subscribers were diluting the population, new subscribers would show *lower* engagement than returning ones. The data shows the opposite:

| Group (within 2022) | Mean | Median |
| :--- | :--- | :--- |
| New subscribers | 305.2 | 132.1 |
| Returning subscribers | 226.8 | **63.6** |

New subscribers are *more* engaged than returning ones — ruling out a dilution explanation.

**Step 3 — Paired comparison: how did the same 457 returning students change from 2021 to 2022?**

* **Paired t-test:** t = 8.26, p = 1.6 × 10⁻¹⁵ (n = 457) — an extremely significant decline within the same individuals.
* **69.6%** of returning subscribers show lower engagement in 2022 than in 2021.
* **Median engagement per returning student fell 66.7%** year-over-year.

**Conclusion:** The Paid engagement decline is not explained by an influx of new, lower-quality subscribers — new subscribers are comparatively healthy. It is driven almost entirely by a sharp, statistically robust drop in engagement among **existing subscribers who remained paying customers** but dramatically reduced their usage. This is a "quiet disengagement" pattern: retention (measured by subscription status) looks fine, but the underlying behavior is a strong leading indicator of future churn.

---

## 4. Dependencies and Probabilities: Are Q2 2021 and Q2 2022 Watching Independent Events?

Using the raw (uncleaned) watch data — per the project's instruction to include outliers for this specific task — every student who watched a lecture in Q2 2021 and/or Q2 2022 was combined into a universal set to test whether watching in one period is independent of watching in the other.

| Quantity | Value |
| :--- | :--- |
| Universal set (watched a lecture at all) | 15,840 students |
| \|A\| — watched in Q2 2021 | 7,639 |
| \|B\| — watched in Q2 2022 | 8,841 |
| \|A ∩ B\| — watched in both | 640 |
| P(A) | 0.482 |
| P(B) | 0.558 |
| P(A ∩ B) | 0.040 |
| P(A) × P(B) | 0.269 |

Since P(A ∩ B) = 0.040 is far below the 0.269 expected under independence, **events A and B are dependent, not independent** — and dependent in a negative direction. **P(A\|B) = 0.072**: of students who watched in Q2 2022, only 7.2% had also watched in Q2 2021.

**This is a platform-wide confirmation of the same pattern found in the Paid cohort tracking analysis (Section 3):** the large majority of any quarter's active watchers are not returning users from the prior year. Retention across the whole platform, not just the Paid segment, appears to be low.

---

## 5. Predictive Modeling and Achievement Drivers (Steps 8-9)

### Machine Learning: Linear Regression Model Analysis

A Linear Regression model was built per the project specification: `minutes_watched` as the predictor, `certificates_issued` as the target, an 80/20 train/test split with `random_state=365`, fit on the training set.

* **Linear equation:** certificates = 1.2111 + 0.001689 × minutes_watched
* **R² (training set):** $\mathbf{0.2218}$
* **Prediction for a student who watched 1,200 minutes:** 3.24 → **rounded up to 4 certificates**

**Interpretation of R² (0.2218)**

* **Limited Explanatory Power:** About $22.18\%$ of the variability in certificates issued can be explained by minutes watched using this linear regression model. The remaining $77.82\%$ is driven by factors outside this model.
* **Poor-to-Moderate Fit:** The model captures a real but partial relationship; a substantial share of data points lie far from the regression line.
* **Conclusion:** An R² of 0.2218 indicates that minutes watched alone is a moderate-to-weak predictor of certificates issued. Future models should incorporate additional behavioral factors (assignment completion, practice time, session frequency) to improve explanatory power.

*Supplementary check: scoring this same fitted model against the held-out test set (rather than the training set) gives R² = 0.468 — notably higher. This is a useful illustration of sampling variance in a train/test split this size (~659 rows total, ~132-row test set), and worth knowing when interpreting a single R² figure, but the 0.2218 training-set value above is the one specified by the project methodology and is the primary figure reported here.*

---

## 6. Final Conclusions and Recommendations

### Final Conclusions

* **Paid User Decline — Root Cause Identified:** Student-level cohort tracking shows the Paid engagement decline is driven by existing subscribers whose usage collapsed while remaining subscribed (median −66.7%, paired t = 8.26, p < 0.001, n = 457), not by an influx of lower-engagement new subscribers, who in fact engage more than the (declining) returning group.
* **Platform-Wide Low Retention:** The dependency analysis confirms this isn't isolated to Paid users — only 7.2% of Q2 2022 watchers had also watched in Q2 2021, and watching in one quarter is statistically dependent on (and lower than chance predicts for) watching in the other. Retention, not acquisition, is the platform's core challenge.
* **Free-Plan Success:** The new features statistically increased free user engagement, with typical (median) engagement growing far faster than the mean — indicating broad-based adoption across the majority of free users, not just a few power users.
* **Future Modeling:** An R² of 0.2218 confirms Minutes Watched is not the only, or even the dominant, factor driving achievement.

### Strategic Recommendations

1.  **Immediate Re-engagement Campaign for At-Risk Retained Subscribers:** The 457 returning paid subscribers showing a 66.7% median engagement drop are still active accounts — a rare, high-value window to intervene before cancellation. Prioritize this group over broad-based retention spend, since new subscribers are already comparatively healthy.
2.  **Platform-Wide Retention Strategy:** Given the low cross-year return rate (7.2%) across the entire platform, retention initiatives should not be limited to the Paid segment — investigate re-engagement triggers (email, in-app prompts) for lapsed Free users as well.
3.  **Investigate the Specific Trigger:** With the "who" question answered, the next step is "why" — feature-level usage logs for the 457 returning subscribers (which features they stopped using) would identify which specific change coincided with their drop-off.
4.  **Data Enrichment:** Future efforts must focus on collecting data on non-video activities, assignment completion rates, and user interface interactions to build a robust predictive model with a higher R².
