INSERT INTO opd_visits
(patient_id, doctor_id, visit_date, diagnosis, consultation_fee)

SELECT
    p.patient_id,
    d.doctor_id,
    p.registration_date AS visit_date,

    ELT(FLOOR(1 + RAND()*8),
        'Fever',
        'Cold & Cough',
        'Skin Allergy',
        'Routine Checkup',
        'Back Pain',
        'Migraine',
        'Stomach Pain',
        'Viral Infection'
    ) AS diagnosis,

    d.consultation_fee

FROM patients p

JOIN doctors d 
    ON d.department_id =
        CASE 
            WHEN TIMESTAMPDIFF(YEAR, p.date_of_birth, p.registration_date) < 17
            THEN 2
            ELSE d.department_id
        END

WHERE
    (
        TIMESTAMPDIFF(YEAR, p.date_of_birth, p.registration_date) < 17 
        AND d.department_id = 2
    )
    OR
    (
        TIMESTAMPDIFF(YEAR, p.date_of_birth, p.registration_date) >= 17 
        AND d.department_id != 2
    )

ORDER BY RAND()
LIMIT 3500;

SELECT
* FROM OPD_VISITS;