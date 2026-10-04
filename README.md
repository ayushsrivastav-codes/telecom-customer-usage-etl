# 📡 Telecom Customer Usage ETL Pipeline

A production-style batch ETL pipeline that automates telecom customer usage data processing using MySQL, Apache Sqoop, HDFS, Apache Hive, and Apache Airflow.

The pipeline extracts customer usage data from MySQL, loads raw data into HDFS, waits for data readiness, validates the ready condition, transforms and validates the data using Hive, generates customer-level usage summaries, and orchestrates the complete workflow using Airflow.

---

## 📌 Project Overview

Telecom companies generate large amounts of customer usage data such as:

- Call minutes
- SMS count
- Mobile data usage
- Customer plans
- Usage dates
- Telecom circles

Processing this data manually is time-consuming and difficult to monitor.

This project automates the complete data pipeline from source database to analytical summary.

### Project Type

**ETL — Extract, Load, Transform**

```text
MySQL
   │
   │ Extract
   ▼
Apache Sqoop
   │
   │ Load
   ▼
HDFS Raw Layer
   │
   │ Data Readiness Check
   ▼
Airflow FileSensor
   │
   │ File Verification
   ▼
Airflow FSHook
   │
   │ Transform + Validate
   ▼
Apache Hive
   │
   ▼
Customer Usage Fact
   │
   │ Aggregate
   ▼
Customer Usage Summary
   │
   ▼
Analytics
