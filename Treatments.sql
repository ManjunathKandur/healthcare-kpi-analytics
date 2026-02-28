INSERT INTO treatments 
(admission_id, treatment_name, treatment_cost, treatment_date)

SELECT 
    a.admission_id,

    -- Treatment selection based on diagnosis
    CASE a.diagnosis

        WHEN 'Pneumonia' THEN 
            ELT(FLOOR(1 + RAND()*3),
                'Antibiotic Therapy',
                'Oxygen Therapy',
                'Chest Physiotherapy')

        WHEN 'Fracture' THEN 
            ELT(FLOOR(1 + RAND()*3),
                'X-Ray',
                'Casting',
                'Orthopedic Procedure')

        WHEN 'Minor Surgery' THEN 
            ELT(FLOOR(1 + RAND()*3),
                'Surgical Procedure',
                'Anesthesia',
                'Post-Operative Care')

        WHEN 'Infection' THEN 
            ELT(FLOOR(1 + RAND()*3),
                'IV Antibiotics',
                'Blood Test',
                'Observation')

        WHEN 'Cardiac Observation' THEN 
            ELT(FLOOR(1 + RAND()*3),
                'ECG Monitoring',
                'Echo Test',
                'Cardiac Medication')

        WHEN 'Appendicitis' THEN 
            ELT(FLOOR(1 + RAND()*3),
                'Appendectomy',
                'Surgical Supplies',
                'Post-Surgery Monitoring')

    END AS treatment_name,

    -- Cost by diagnosis severity
    CASE a.diagnosis

        WHEN 'Pneumonia' THEN ROUND(12000 + RAND()*8000,2)
        WHEN 'Fracture' THEN ROUND(10000 + RAND()*7000,2)
        WHEN 'Minor Surgery' THEN ROUND(15000 + RAND()*10000,2)
        WHEN 'Infection' THEN ROUND(5000 + RAND()*5000,2)
        WHEN 'Cardiac Observation' THEN ROUND(20000 + RAND()*15000,2)
        WHEN 'Appendicitis' THEN ROUND(25000 + RAND()*15000,2)

    END AS treatment_cost,

    -- GUARANTEED valid date
    DATE_ADD(
        a.admission_date,
        INTERVAL FLOOR(
            RAND() * (DATEDIFF(a.discharge_date, a.admission_date) + 1)
        ) DAY
    ) AS treatment_date

FROM admissions a

-- Generate 4 possible rows
JOIN (
    SELECT 1 n UNION ALL 
    SELECT 2 UNION ALL 
    SELECT 3 UNION ALL 
    SELECT 4
) t

-- Randomly choose 2–4 treatments
WHERE t.n <= FLOOR(2 + RAND()*3)

AND a.discharge_date IS NOT NULL;
