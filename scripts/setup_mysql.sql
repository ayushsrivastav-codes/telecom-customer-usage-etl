CREATE DATABASE IF NOT EXISTS telecom_db;

USE telecom_db;

CREATE TABLE IF NOT EXISTS customer_usage (
    usage_id INT PRIMARY KEY,
    customer_id VARCHAR(20),
    plan VARCHAR(30),
    call_minutes INT,
    sms_count INT,
    data_gb DECIMAL(10,2),
    usage_date DATE,
    circle VARCHAR(50)
);

INSERT INTO customer_usage VALUES
(1,'C101','Premium',120,50,8.50,'2026-09-28','Karnataka'),
(2,'C102','Basic',45,20,2.30,'2026-09-28','Maharashtra'),
(3,'C103','Premium',200,75,15.20,'2026-09-28','Delhi'),
(4,'C104','Standard',80,30,5.60,'2026-09-28','Karnataka'),
(5,'C105','Basic',35,15,1.80,'2026-09-28','Tamil Nadu'),
(6,'C101','Premium',150,60,10.20,'2026-09-28','Karnataka'),
(7,'C102','Basic',55,25,3.10,'2026-09-28','Maharashtra'),
(8,'C106','Standard',90,40,6.40,'2026-09-28','Telangana'),
(9,'C107','Premium',180,80,14.50,'2026-09-28','Delhi'),
(10,'C108','Basic',40,18,2.00,'2026-09-28','Kerala');
