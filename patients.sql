show databases

use cars
SELECT * FROM cars.patients;

show tables

CREATE TABLE patients (
    encounter_id BIGINT PRIMARY KEY,
    patient_nbr BIGINT,
    race VARCHAR(50),
    gender VARCHAR(10),
    age VARCHAR(20),
    admission_type_id INT,
    discharge_disposition_id INT,
    admission_source_id INT,
    time_in_hospital INT,
    occupation VARCHAR(50),
    num_lab_procedures INT,
    num_procedures INT,
    num_medications INT,
    number_outpatient INT,
    number_emergency INT,
    number_inpatient INT,
    diag_1 VARCHAR(10),
    diag_2 VARCHAR(10),
    diag_3 VARCHAR(10),
    number_diagnoses INT,
    metformin VARCHAR(10),
    repaglinide VARCHAR(10),
    nateglinide VARCHAR(10),
    chlorpropamide VARCHAR(10),
    glimepiride VARCHAR(10),
    acetohexamide VARCHAR(10),
    glipizide VARCHAR(10),
    glyburide VARCHAR(10),
    tolbutamide VARCHAR(10),
    pioglitazone VARCHAR(10),
    rosiglitazone VARCHAR(10),
    acarbose VARCHAR(10),
    miglitol VARCHAR(10),
    troglitazone VARCHAR(10),
    tolazamide VARCHAR(10),
    examide VARCHAR(10),
    citoglipton VARCHAR(10),
    insulin VARCHAR(10),
    glyburide_metformin VARCHAR(10),
    glipizide_metformin VARCHAR(10),
    glimepiride_pioglitazone VARCHAR(10),
    metformin_rosiglitazone VARCHAR(10),
    metformin_pioglitazone VARCHAR(10),
    `change` VARCHAR(10),
    diabetesMed VARCHAR(10),
    readmitted VARCHAR(20)
);

SELECT * FROM patients ORDER BY encounter_id DESC LIMIT 5;
SELECT * FROM patients;


SELECT * FROM patients WHERE encounter_id = 9999999;

SELECT encounter_id FROM patients ORDER BY encounter_id DESC LIMIT 10;

-- structure of the table
DESCRIBE patients;

-- Count --
SELECT COUNT(*) FROM patients;

-- Data Preview --
SELECT * FROM patients LIMIT 10;

-- Check for duplicates in encounter_id ---
SELECT encounter_id, COUNT(*) 
FROM patients 
GROUP BY encounter_id 
HAVING COUNT(*) > 1;


-- Gender distribution ----
SELECT gender, COUNT(*) AS count
FROM patients
GROUP BY gender;

-- Race distribution ---
SELECT race, COUNT(*) AS count
FROM patients
GROUP BY race;

-- Age group distribution ---
SELECT age, COUNT(*) AS count
FROM patients
GROUP BY age
ORDER BY age;

-- Count how many patients were prescribed insulin ---
SELECT insulin, COUNT(*) 
FROM patients
GROUP BY insulin;

-- Count of patients on metformin ----
SELECT metformin, COUNT(*) 
FROM patients
GROUP BY metformin;

-- Top 5 most commonly prescribed medications (based on binary flags) ----
SELECT 
    'metformin' AS medication, COUNT(*) FROM patients WHERE metformin = 'Yes'
UNION
SELECT 'insulin', COUNT(*) FROM patients WHERE insulin = 'Yes'
UNION
SELECT 'glipizide', COUNT(*) FROM patients WHERE glipizide = 'Yes'
UNION
SELECT 'glyburide', COUNT(*) FROM patients WHERE glyburide = 'Yes'
UNION
SELECT 'pioglitazone', COUNT(*) FROM patients WHERE pioglitazone = 'Yes';


-- Average length of hospital stay ---
SELECT AVG(time_in_hospital) AS avg_days_in_hospital
FROM patients;

-- Number of outpatient visits ----
SELECT number_outpatient, COUNT(*) 
FROM patients 
GROUP BY number_outpatient
ORDER BY number_outpatient DESC;

-- Distribution of number of lab procedures ---
SELECT num_lab_procedures, COUNT(*)
FROM patients
GROUP BY num_lab_procedures
ORDER BY num_lab_procedures DESC;

-- Most common primary diagnoses ---
SELECT diag_1, COUNT(*) 
FROM patients 
GROUP BY diag_1
ORDER BY COUNT(*) DESC
LIMIT 10;

-- Co-occurrence of diagnoses ---
SELECT diag_1, diag_2, COUNT(*) AS freq
FROM patients
GROUP BY diag_1, diag_2
ORDER BY freq DESC
LIMIT 10;

-- Readmission rates ----
SELECT readmitted, COUNT(*) 
FROM patients 
GROUP BY readmitted;

-- Readmission rate by age group ----
SELECT age, COUNT(*) AS total,
    SUM(CASE WHEN readmitted = '<30' THEN 1 ELSE 0 END) AS readmit_within_30_days
FROM patients
GROUP BY age
ORDER BY age;

-- Readmission rate by insulin usage ----
SELECT insulin, COUNT(*) AS total,
    SUM(CASE WHEN readmitted = '<30' THEN 1 ELSE 0 END) AS readmit_under_30
FROM patients
GROUP BY insulin;

-- Check for NULLs in key columns ----
SELECT 
    COUNT(*) AS total,
    SUM(CASE WHEN race IS NULL THEN 1 ELSE 0 END) AS null_race,
    SUM(CASE WHEN gender IS NULL THEN 1 ELSE 0 END) AS null_gender,
    SUM(CASE WHEN diag_1 IS NULL THEN 1 ELSE 0 END) AS null_diag_1
FROM patients;

-- Average number of medications per age group ----
SELECT age, AVG(num_medications) AS avg_meds
FROM patients
GROUP BY age;

-- Patients with frequent admissions (potential high risk) -----
SELECT patient_nbr, COUNT(*) AS total_admissions
FROM patients
GROUP BY patient_nbr
HAVING total_admissions > 3
ORDER BY total_admissions DESC;


