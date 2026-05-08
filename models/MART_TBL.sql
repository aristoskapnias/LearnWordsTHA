{{ 
    config(
        materialized='table'
    ) 
    
}}


WITH invoice_months AS (
    SELECT
        INV.invoice_id,
        INV.customer_id,
        INV.subscription_id,
        INV.amount_usd,
        Billed_Month::date AS billed_month,
        INV.amount_usd / COUNT(*) OVER (PARTITION BY INV.invoice_id) AS monthly_amount_usd
    FROM {{ ref('INVOICES') }} INV
    CROSS JOIN LATERAL generate_series(
        date_trunc('month', INV.billing_start_date),
        date_trunc('month', INV.billing_end_date),
        interval '1 month'
    ) AS Billed_Month
)

SELECT
    SC.use_case AS "School Use Case",
    CUST.country AS "Country Name",
    to_char(IM.billed_month, 'Mon-YYYY') AS "Calendar Month",
    SUM(IM.monthly_amount_usd) AS "Monthly Recurring Revenue"
FROM invoice_months IM
INNER JOIN {{ ref('SUBSCRIPTIONS') }} SUB
    ON IM.subscription_id = SUB.subscription_id
INNER JOIN {{ ref('SCHOOLS') }} SC
    ON SUB.school_id = SC.school_id
INNER JOIN {{ ref('CUSTOMERS') }} CUST
    ON IM.customer_id = CUST.customer_id
GROUP BY
    SC.use_case,
    CUST.country,
    IM.billed_month
ORDER BY
    IM.billed_month,
    SC.use_case,
    CUST.country