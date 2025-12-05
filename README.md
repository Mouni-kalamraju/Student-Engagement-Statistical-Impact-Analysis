

##  Student Engagement and Statistical Impact Analysis

This report summarizes the analysis of student engagement on an online coaching platform, comparing performance in **Q2 2021 vs. Q2 2022** to assess the impact of newly launched features. The project utilized SQL, Excel, and Python for data handling, statistical inference, and predictive modeling.

---

## 1. Project Methodology and Data Preparation (Steps 1-4)

The project established a robust dataset by defining key engagement periods and ensuring data quality.

### Data Extraction and Segmentation (Steps 1 & 2)
* **Data Preparation:** Student first engagement, subscription end dates (based on plans), and refunds were calculated and managed.
* **Cohort Creation:** Students were segregated into four cohorts for Year-over-Year (YoY) comparison: Paid Q2 2021, Free Q2 2021, Paid Q2 2022, and Free Q2 2022.

### Metric Creation and Cleaning (Steps 3 & 4)
* **Core Metrics:** **Minutes Watched** (engagement) and **Certificates Earned** (achievement) were calculated.
* **Exploratory Data Analysis (EDA):** KDE plots visualized the highly **right-skewed** distribution of Minutes Watched, confirming that most students consume low amounts of content.
* **Outlier Treatment:** The top **1% of outliers** for **Minutes Watched** were removed. **Crucially, outliers were also removed from the 'certificates\_issued'** metric based on its own quantile to prevent extreme values from disproportionately influencing the regression model.

---

## 2. Statistical Inference and Hypothesis Testing (Steps 5-7)

The analysis validated changes in engagement using descriptive statistics (Mean, Median) and inferential statistics (CI, T-test, F-test).

### Central Tendency and Variance Validation (Steps 5 & F-Test)
| Analysis Group | Mean ($\bar{x}$) | Median | **95% Confidence Interval (CI)** | F-Test P-value | Variance Assumption |
| :--- | :---: | :---: | :---: | :---: | :---: |
| **Paid Students (Q2 2021)** | 360.11 | 61.93 | **339.6 – 380.6** | N/A | Unequal |
| **Paid Students (Q2 2022)** | 292.22 | 119.75 | **276.0 – 307.0** | $1.5 \times 10^{-23}$ | Unequal (Welch's Test Used) |
| **Free Students (Q2 2021)** | 14.22 | 2.79 | **13.55 – 14.87** | N/A | Equal |
| **Free Students (Q2 2022)** | 16.03 | 4.98 | **15.4 – 16.6** | $0.196$ | Equal (Pooled T-test Used) |

### Hypothesis Testing (T-Test) Results
A **Left-Tailed T-Test** was run to test for a significant increase in mean watch time ($\text{H}_a: \mu_{2022} > \mu_{2021}$).

| Cohort | T-Statistic | P(T<=t) One-Tail | Decision | **Feature Impact Inference** |
| :--- | :---: | :---: | :---: | :--- |
| **Free-Plan Students** | $-3.95$ | **$3.91 \times 10^{-5}$** | **Reject $\text{H}_0$** | **Successful (Significant Increase)** |
| **Paying Students** | $+5.16$ | **$1.3 \times 10^{-7}$** | **Fail to Reject $\text{H}_0$** | **Unsuccessful (Confirmed Significant Decline)** |

---

## 3. Predictive Modeling and Achievement Drivers (Steps 8-9)

### Event Dependency
The analysis found that the events of being engaged in 2021 and 2022 are **Dependent** ($P(\text{Intersection}) = 0.04 \ne P(E_{2021}) \times P(E_{2022})$), confirming low overlap and high churn/user base shift.

### Machine Learning: Linear Regression Model Analysis

A Linear Regression model used **Minutes Watched** as the predictor and **Certificates Issued** as the target.

* **Correlation ($r$):** $0.512$
* **$R^2$ Value:** $\mathbf{0.2218}$

#### Interpretation of $R^2$ (0.2218)

The low $R^2$ value leads to strong inferences about the model's limitations and the nature of student achievement:

* **Limited Explanatory Power:** Only about **$22.18\%$** of the variability in the number of certificates issued can be explained by minutes watched using this linear regression model. A large portion (**around $77.82\%$**) of the variation in certificates issued is not accounted for by minutes watched.
* **Poor Fit:** The model does not fit the data particularly well. While it captures some of the relationship, a significant amount of the data points lie far from the regression line.
* **Many Other Factors:** This low $R^2$ value strongly suggests that minutes watched is not the only, or even the primary, factor influencing certificates issued. There are likely many other influential variables, such as:
    * **Student engagement:** Active participation and completing assignments.
    * **Prior knowledge/skills:** Students with a stronger foundation.
    * **Motivation/Goal-setting:** Personal drive to complete courses.
* **Limited Predictive Accuracy:** The model, based solely on minutes watched, will likely not be very accurate in predicting the exact number of certificates issued for a new student. Its predictions will have a high degree of error.
* **Conclusion:** An $R^2$ of $0.2218$ indicates that **minutes watched alone is a poor predictor of certificates issued**, and the model needs further development, likely by including more influential factors, to improve its performance and explanatory power.

---

## 4. 🔑 Final Conclusions and Recommendations

1.  **Free-Plan Success:** The new features **statistically increased** free user engagement ($\text{H}_0$ rejected).
2.  **Paid User Strategy Shift:** The T-test confirms a **statistically significant decline** in the overall average Minutes Watched for paying students. The platform must investigate why the new features failed to retain the highly active **"super-users"** who drove the 2021 average.
3.  **Future Modeling:** The low $R^2$ value **proves Minutes Watched is not the only factor** driving achievement. Future efforts must focus on collecting data on activities and other factors to build a robust model with higher explanatory power.
