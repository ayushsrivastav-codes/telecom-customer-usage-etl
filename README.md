# 📡 Telecom Customer Usage ETL Pipeline

A production-style batch ETL pipeline that extracts telecom customer usage data from MySQL, loads raw data into HDFS using Sqoop, waits for data readiness using an Airflow Sensor, transforms and validates the data using Hive, and generates customer-level usage summaries.

---

## 📌 Project Overview

Telecom customer usage data is stored in a MySQL database.

The objective of this project is to automate the complete data pipeline:

**MySQL → Sqoop → HDFS → Airflow → Hive → Analytics**

The pipeline is orchestrated using Apache Airflow and runs as a scheduled ETL workflow.

---

## 🎯 Business Problem

Telecom companies generate large amounts of customer usage data such as:

- Call minutes
- SMS count
- Mobile data usage
- Customer plan
- Usage date
- Telecom circle

Processing this data manually is time-consuming and difficult to monitor.

This project automates the process of:

1. Extracting usage data from MySQL
2. Loading raw data into HDFS
3. Waiting for data readiness
4. Validating the ready condition
5. Transforming and validating data using Hive
6. Creating customer usage summaries
7. Orchestrating the entire workflow using Airflow

---

## 🏗️ Architecture

```text
                    ┌───────────────────┐
                    │      MySQL        │
                    │   telecom_db      │
                    │ customer_usage    │
                    └─────────┬─────────┘
                              │
                              │ Extract
                              ▼
                    ┌───────────────────┐
                    │      Sqoop        │
                    │   JDBC Import     │
                    └─────────┬─────────┘
                              │
                              │ Load Raw Data
                              ▼
                    ┌───────────────────┐
                    │       HDFS        │
                    │   /telecom/raw    │
                    └─────────┬─────────┘
                              │
                              │
                    ┌─────────▼─────────┐
                    │  Airflow Sensor   │
                    │  usage.ready      │
                    └─────────┬─────────┘
                              │
                              ▼
                    ┌───────────────────┐
                    │      FSHook       │
                    │ Verify readiness  │
                    └─────────┬─────────┘
                              │
                              ▼
                    ┌───────────────────┐
                    │       Hive        │
                    │ Transformation    │
                    └─────────┬─────────┘
                              │
                 ┌────────────┴────────────┐
                 ▼                         ▼
        ┌───────────────────┐     ┌────────────────────┐
        │ Customer Usage    │     │ Customer Usage     │
        │ Fact              │────▶│ Summary            │
        │ Parquet           │     │ Parquet            │
        └───────────────────┘     └────────────────────┘
                                           │
                                           ▼
                                    ┌───────────────┐
                                    │   Analytics   │
                                    └───────────────┘
