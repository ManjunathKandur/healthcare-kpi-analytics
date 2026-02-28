INSERT INTO admissions
(patient_id, doctor_id, room_id, admission_date, discharge_date, diagnosis, total_bill)

SELECT
    p.patient_id,
    d.doctor_id,
    r.room_id,
    p.registration_date AS admission_date,

    DATE_ADD(p.registration_date, INTERVAL stay.stay_days DAY) AS discharge_date,

    ELT(FLOOR(1 + RAND()*6),
        'Pneumonia',
        'Fracture',
        'Appendicitis',
        'Cardiac Observation',
        'Infection',
        'Minor Surgery'
    ) AS diagnosis,

    (r.daily_rate * stay.stay_days) AS total_bill

FROM patients p

JOIN (
    SELECT 
        patient_id,
        FLOOR(1 + RAND()*7) AS stay_days
    FROM patients
    ORDER BY RAND()
    LIMIT 2000
) stay ON stay.patient_id = p.patient_id

JOIN rooms r 
    ON r.room_id = FLOOR(1 + RAND()*4)   -- since you have 4 room types (1–4)

JOIN doctors d
    ON (
        CASE 
            WHEN TIMESTAMPDIFF(YEAR, p.date_of_birth, p.registration_date) < 17
            THEN d.department_id = 2
            ELSE d.department_id != 2
        END
    )

ORDER BY RAND()
LIMIT 2000;

SELECT * FROM admissions;