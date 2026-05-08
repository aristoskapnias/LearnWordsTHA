{{ 
    config(
        materialized='incremental'
        ,unique_key='customer_id'
        ,incremental_strategy='delete+insert'
    ) 
    
}}


select
    customer_id,
    company_name,
    country,
    default_billing_method
from {{ ref('customers') }} -- points to the seeded table

