INSERT INTO payments 
(admission_id, payment_date, amount_paid, payment_mode)

SELECT 
    a.admission_id,

    -- Payment date must match discharge
    a.discharge_date AS payment_date,

    -- Total = Room bill + Treatment total
    (
        a.total_bill + 
        IFNULL(SUM(t.treatment_cost), 0)
    ) AS amount_paid,

    -- Realistic payment mode distribution
    CASE 
        WHEN RAND() < 0.25 THEN 'Cash'
        WHEN RAND() < 0.50 THEN 'UPI'
        WHEN RAND() < 0.75 THEN 'Card'
        ELSE 'Insurance'
    END AS payment_mode

FROM admissions a

LEFT JOIN treatments t 
    ON a.admission_id = t.admission_id

WHERE a.discharge_date IS NOT NULL

GROUP BY 
    a.admission_id,
    a.discharge_date,
    a.total_bill;