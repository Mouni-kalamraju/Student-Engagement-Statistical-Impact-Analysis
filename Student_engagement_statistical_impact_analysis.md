
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
| **Paid Students (Q2 2021)** | **2,281** | 360.11 | 161.93 | 339.6 – 380.6 | N/A | Unequal |
| **Paid Students (Q2 2022)** | **2,758** | 292.22 | 119.75 | 276.0 – 307.0 | $1.5 \times 10^{-23}$ | Unequal (Welch's Test Used) |
| **Free Students (Q2 2021)** | **5,280** | 14.22 | 2.79 | 13.55 – 14.87 | N/A | Equal |
| **Free Students (Q2 2022)** | **5,994** | 16.03 | 4.98 | 15.4 – 16.6 | $0.196$ | Equal (Pooled T-test Used) |

### Hypothesis Testing (T-Test) Results

| Cohort | T-Statistic | P($T \le t$) One-Tail | Decision | Feature Impact Inference |
| :--- | :--- | :--- | :--- | :--- |
| Free-Plan Students | $-3.95$ | $3.91 \times 10^{-5}$ | Reject $\text{H}_0$ | Successful (Significant Increase) |
| Paying Students | $+5.16$ | $1.3 \times 10^{-7}$ | Fail to Reject $\text{H}_0$ | Unsuccessful (Confirmed Significant Decline) |

---

## 3. Analysis of Findings: Engagement and Acquisition

The student counts provide crucial context for interpreting the statistical shift in central tendency.

### Paid Cohort: Systemic Engagement Decline

The Paid segment experienced an engagement failure despite successful acquisition:

* **Acquisition Success:** The cohort grew significantly by $\approx 21.6\%$ (from 2,305 to 2,786 students), indicating successful marketing or onboarding.
* **Engagement Failure:** The **Median Minutes Watched** dropped by $\mathbf{26\%}$ (161.93 $\to$ 119.75), confirming that the typical paid user found less value in the updated platform.
* **High-Value User Loss:** The $19\%$ drop in the Mean confirms that the decline was magnified by the loss of high-consumption, "super-users."
* **Conclusion:** The features failed to drive engagement for the new, larger Paid customer base.

### Free Cohort: Strong Acquisition Momentum

The Free segment demonstrated healthy growth, suggesting the new features did not deter initial adoption.

* **Acquisition Success:** The Free cohort grew by $\approx 13.5\%$ (from 5,334 to 6,055 students).
* **Conclusion:** The platform successfully leveraged the new features to expand the top-of-funnel, setting up a good opportunity for future monetization.

---

## 4. Predictive Modeling and Achievement Drivers (Steps 8-9)

### Machine Learning: Linear Regression Model Analysis

A Linear Regression model used Minutes Watched as the predictor and Certificates Issued as the target.

* **Correlation ($r$):** $0.512$
* **$R^2$ Value:** $\mathbf{0.2218}$

**Interpretation of $R^2$ (0.2218)**
The low $R^2$ value leads to strong inferences about the model's limitations and the nature of student achievement:

* **Limited Explanatory Power:** Only about $22.18\%$ of the variability in the number of certificates issued can be explained by minutes watched using this linear regression model. A large portion (around $77.82\%$) of the variation in certificates issued is not accounted for by minutes watched.
* **Poor Fit:** The model does not fit the data particularly well. While it captures some of the relationship, a significant amount of the data points lie far from the regression line.
* **Conclusion:** An $R^2$ of $0.2218$ indicates that minutes watched alone is a poor predictor of certificates issued, and the model needs further development, likely by including more influential factors, to improve its performance and explanatory power.

---

## 5. Final Conclusions and Recommendations

### Final Conclusions

* **Paid User Failure:** The T-test confirmed a statistically significant decline in the overall average Minutes Watched, and the corrected Median value confirms a **systemic 26% drop in engagement** for the typical paid customer.
* **Free-Plan Success:** The new features statistically increased free user engagement and drove robust customer acquisition.
* **Future Modeling:** The low $R^2$ value proves Minutes Watched is not the only factor driving achievement.

### Strategic Recommendations

1.  **Immediate Feature Audit (Paid Cohort):** The $26\%$ drop in Median engagement for the Paid Cohort is a critical financial risk. The platform must immediately investigate which new features are being ignored or which critical old features were negatively affected by the update.
2.  **Data Enrichment:** Future efforts must focus on collecting data on non-video activities, assignment completion rates, and user interface interactions to build a robust predictive model with a higher $R^2$.
