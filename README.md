# 🏥 Healthcare KPI Analytics
### Hospital Revenue & Operational Intelligence System (MySQL)

---

## 📌 Project Overview

This project simulates a real-world hospital database and applies advanced SQL analytics to evaluate operational performance, financial health, and patient flow trends.

The objective is to transform structured healthcare data into meaningful business insights using MySQL, advanced SQL queries, and window functions.

This project demonstrates end-to-end data analysis including:

- Relational database design
- Revenue modeling (Room + Treatment billing logic)
- Business KPI generation
- Window function-based trend analysis
- Department and doctor performance benchmarking

---

## 🗂 Database Architecture

The system is built using a normalized relational schema consisting of:

- **patients** – demographic and registration data
- **departments** – hospital departments
- **doctors** – doctor allocation and consultation details
- **rooms** – room type, capacity, and pricing
- **admissions** – inpatient records with diagnosis and billing
- **treatments** – treatment-level cost tracking
- **payments** – payment mode and revenue tracking
- **opd_visits** – outpatient visit records

The schema simulates realistic hospital operations including pediatric handling, ICU admissions, multi-treatment billing, and payment behavior analysis.

---

## 📊 Business Problems Solved

### 🏥 Patient Flow Analysis
- Monthly patient registration trends
- Month-over-month growth using `LAG()`
- Admission conversion rate
- Pediatric vs adult patient distribution
- City-wise patient acquisition insights

### 💰 Revenue & Profitability Analysis
- Total hospital revenue calculation
- Running monthly revenue trend using `SUM() OVER()`
- Diagnosis-wise revenue ranking using `DENSE_RANK()`
- Department contribution percentage
- ICU profitability evaluation

### 👨‍⚕️ Doctor Performance Analytics
- Revenue ranking of doctors within departments
- Doctor contribution percentage using window functions
- Top-performing doctor per department
- Revenue vs experience analysis

### 🛏 Room & Capacity Utilization
- Average length of stay
- Room type profitability ranking
- Longest admissions using `ROW_NUMBER()`
- Stay length benchmarking against hospital average

### 🧪 Treatment-Level Intelligence
- Treatments per admission
- Diagnosis-based treatment cost analysis
- Cumulative treatment revenue trend
- Cost benchmarking using `AVG() OVER()`

### 💳 Payment & Financial Risk Analysis
- Revenue distribution by payment mode
- Insurance dependency percentage
- High-value payment identification
- Month-over-month revenue growth

---

## 🛠 SQL Concepts & Techniques Used

- Complex JOIN operations
- 1:N revenue aggregation handling
- CTEs (Common Table Expressions)
- Window Functions:
  - `RANK()`
  - `DENSE_RANK()`
  - `ROW_NUMBER()`
  - `LAG()`
  - `SUM() OVER()`
  - `AVG() OVER()`
- Running totals
- Percentage contribution analysis
- Revenue modeling logic
- Business KPI-based querying

---

## 📈 Key Insights Generated

- Identification of peak revenue months
- Department-level revenue concentration
- ICU contribution to total revenue
- Insurance dependency risk exposure
- Top revenue-generating doctors
- Length-of-stay impact on hospital revenue

---

## 🚀 How to Run This Project

1. Execute `schema.sql` to create tables
2. Run data generation scripts
3. Execute admission, treatment, and payment logic scripts
4. Run `kpi_queries.sql` to generate business insights

---

## 🎯 Business Impact Simulation

This project demonstrates how hospital management can:

- Optimize resource allocation
- Identify high-performing departments
- Monitor financial health
- Reduce revenue concentration risk
- Improve operational efficiency

---

## 📌 Future Enhancements

- Power BI dashboard integration
- Stored procedures for automated KPI reporting
- Index optimization for performance tuning
- Revenue forecasting model
- Data visualization layer

---

## 👨‍💻 Author

**Manjunath Kandur**  
Aspiring Data Analyst | SQL | KPI Analytics | Business Intelligence  

---
