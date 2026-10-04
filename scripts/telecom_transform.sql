USE telecom_dw;

DROP TABLE IF EXISTS customer_usage_raw;

CREATE EXTERNAL TABLE customer_usage_raw (
    usage_id INT,
    customer_id STRING,
    plan STRING,
    call_minutes INT,
    sms_count INT,
    data_gb DECIMAL(10,2),
    usage_date DATE,
    circle STRING
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
STORED AS TEXTFILE
LOCATION 'hdfs://localhost:9000/telecom/raw/customer_usage';

DROP TABLE IF EXISTS customer_usage_fact;

CREATE TABLE customer_usage_fact
STORED AS PARQUET
AS
SELECT
    usage_id,
    customer_id,
    UPPER(plan) AS plan,
    call_minutes,
    sms_count,
    data_gb,
    usage_date,
    circle,
    call_minutes + sms_count + CAST(data_gb * 10 AS INT) AS call_usage_score
FROM customer_usage_raw
WHERE call_minutes >= 0
  AND sms_count >= 0
  AND data_gb >= 0;

DROP TABLE IF EXISTS customer_usage_summary;

CREATE TABLE customer_usage_summary
STORED AS PARQUET
AS
SELECT
    customer_id,
    MAX(plan) AS plan,
    SUM(call_minutes) AS total_call_minutes,
    SUM(sms_count) AS total_sms_count,
    SUM(data_gb) AS total_data_gb
FROM customer_usage_fact
GROUP BY customer_id;
