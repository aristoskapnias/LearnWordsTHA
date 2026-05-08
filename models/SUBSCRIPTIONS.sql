{{ 
    config(
        materialized='incremental'
        ,unique_key='subscription_id'
        ,incremental_strategy='delete+insert'
    ) 
    
}}


select
    subscription_id, 
    subscription_type, 
    school_id, 
    billing_method, 
    status, 
    start_date, 
    billed_until_date
from {{ ref('subscriptions') }} -- points to the seeded table