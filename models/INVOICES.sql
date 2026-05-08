{{ 
    config(
        materialized='incremental'
        ,unique_key='invoice_id'
        ,incremental_strategy='delete+insert'
    ) 
    
}}


select
     invoice_id, 
     customer_id, 
     subscription_id, 
     product_id, 
     invoice_date, 
     billing_start_date, 
     billing_end_date, 
     amount_usd
from {{ ref('invoices') }} -- points to the seeded table