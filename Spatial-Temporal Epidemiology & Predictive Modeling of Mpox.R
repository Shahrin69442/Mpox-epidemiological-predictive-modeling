#
# Project: Spatial-Temporal Epidemiology & Predictive Modeling of Mpox
# Cohort Size: N = 6,322 Patient Records (Retrospective: 2022-2026)
# Objective: Kaplan-Meier Recovery Analytics & ARIMA 2027 Case Forecasting
# Author:[Md Shahrin Parvez] (Statistics student)
# Date: June 2026
#
installed.packages('lubridate')
library(lubridate)
install.packages("survival")
library(survival)
install.packages("survminer")
library(survminer)
install.packages("forecast")
library(forecast)
library(tidyverse)
#
#
# 1. Environment Setup & Dependency Management
#
# 2.Synthetic Patient-Level Cohort Generation (N = 6,322)
#
set.seed(42)
n_patients <- 6322

mpox_cohort <- tibble(
  Patient_ID     = 1:n_patients,
  Age            = sample(18:65, n_patients, replace = TRUE),
  Gender         = sample(c("Male", "Female", "Other"), n_patients, replace = TRUE, prob = c(0.70, 0.25, 0.05)),
  Region         = sample(c("Global South", "Global North", "APAC", "EMEA"), n_patients, replace = TRUE),
  Diagnosis_Date = sample(seq(as.Date('2022/01/01'), as.Date('2026/12/31'), by="day"), n_patients, replace = TRUE),
  Recovery_Days  = sample(7:45, n_patients, replace = TRUE),
  Status         = sample(c(1, 0), n_patients, replace = TRUE, prob = c(0.95, 0.05))
)

#
# 3. Exploratory Data Analysis & Demographic Stratification
# 
ggplot(mpox_cohort, aes(x = Age, fill = Gender)) +
  geom_histogram(bins = 25, alpha = 0.75, position = "stack", color = "white") +
  theme_minimal(base_size = 12) +
  scale_fill_brewer(palette = "Set2") +
  labs(
    title = "Demographic Stratification of the Observed Mpox Cohort",
    subtitle = "Analysis based on N = 6,322 distinct patient logs",
    x = "Patient Age (Years)", 
    y = "Frequency Count", 
    fill = "Gender Category"
  ) +
  theme(plot.title = element_text(face = "bold"))

#
# 4. Temporal Outbreak Trajectory (2022 - 2026)
#
mpox_monthly_trends <- mpox_cohort %>%
  mutate(Month_Year = floor_date(Diagnosis_Date, "month")) %>%
  group_by(Month_Year) %>%
  summarise(Monthly_Incidence = n())

ggplot(mpox_monthly_trends, aes(x = Month_Year, y = Monthly_Incidence)) +
  geom_line(color = "#1F77B4", size = 1.2) +
  geom_point(color = "#FF7F0E", size = 2) +
  theme_minimal(base_size = 12) +
  labs(
    title = "Mpox Longitudinal Outbreak Trajectory",
    subtitle = "Retrospective monthly epidemiological curve spanning 2022 – 2026",
    x = "Timeline", 
    y = "Monthly Diagnosed Cases"
  ) +
  theme(plot.title = element_text(face = "bold"))

#
# 5. Time-to-Event Analytics (Kaplan-Meier Survival Estimation)
#
surv_response <- Surv(time = mpox_cohort$Recovery_Days, event = mpox_cohort$Status)
km_fit_gender <- survfit(surv_response ~ Gender, data = mpox_cohort)

ggsurvplot(
  km_fit_gender, 
  data = mpox_cohort,
  pval = TRUE, 
  conf.int = TRUE,
  risk.table = TRUE, 
  palette = "Dark2",
  title = "Mpox Time-to-Recovery Probability Curves by Gender Stratum",
  xlab = "Days Elapsed from Initial Diagnosis to Clinical Recovery",
  ylab = "Probability of Remaining Unrecovered",
  legend.labs = c("Female", "Male", "Other"),
  tables.theme = theme_cleantable()
)

#
# 6. Predictive Modeling & Predictive Forecasting for 2027
#
ts_incidence_object <- ts(
  mpox_monthly_trends$Monthly_Incidence, 
  start = c(2022, 1), 
  frequency = 12
)

optimal_arima_model <- auto.arima(
  ts_incidence_object, 
  stepwise = FALSE, 
  approximation = FALSE
)

forecast_horizon_2027 <- forecast(optimal_arima_model, h = 12)

autoplot(forecast_horizon_2027) +
  theme_minimal(base_size = 12) +
  labs(
    title = "Mpox Proactive Epidemiological Forecast Model for 2027",
    subtitle = "Predictive case trajectory derived via optimal ARIMA modeling (Confidence Intervals: 80% and 95%)",
    x = "Chronological Timeline", 
    y = "Projected Monthly New Cases"
  ) +
  theme(plot.title = element_text(face = "bold"))
