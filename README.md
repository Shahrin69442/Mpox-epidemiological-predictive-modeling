# Spatial-Temporal Epidemiology & Predictive Modeling of Mpox

An advanced epidemiological data science project focused on survival analysis and future case trajectory forecasting for Mpox using R.

## 📋 Project Overview
This project analyzes a retrospective clinical dataset containing **6,322 longitudinal patient records** tracking Mpox cases from 2022 to 2026. The objective is to identify demographic and spatial-temporal predictors affecting clinical recovery and to simulate next-year case distributions for proactive health interventions.

## 🔬 Core Methodologies
1. **Time-to-Recovery Analysis:** Implemented the non-parametric **Kaplan-Meier estimator** to analyze the cumulative probability of recovery over time, stratified across different demographic categories.
2. **Predictive Case Forecasting:** Constructed optimized **ARIMA time-series models** to project monthly case counts and epidemiological trajectories.

## 🛠️ Tech Stack & Key R Packages
* **Data Wrangling:** `tidyverse`, `lubridate`
* **Survival Analysis:** `survival`, `survminer`
* **Time-Series Forecasting:** `forecast`

## 📊 Key Findings & Visualizations
* **Kaplan-Meier Curves:** Stratified survival curves showing the time-lapse (in days) from initial diagnosis to confirmed clinical recovery.
* **ARIMA Projections:** Point forecasts with 80% and 95% confidence intervals displaying the projected monthly distribution of new cases.

## 📂 Repository Structure
* `Mpox_Predictive_Modeling.R` - Core R script containing data preprocessing, survival modeling, and time-series forecasting.
* `README.md` - Documentation of the project.

***Note:** Due to patient data privacy regulations (HIPAA/GDPR compliance), the raw patient dataset (`mpox_cohort.csv`) is anonymized and withheld from the public repository.*

## 📬 Contact & Collaboration
Developed by **Md Shahrin Parvez**. I am open to research collaborations and discussions in Biostatistics, Predictive Modeling, and Global Health Data Science. Feel free to connect with me on LinkedIn!
