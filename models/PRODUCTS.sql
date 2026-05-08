{{ 
    config(
        materialized='incremental'
        ,unique_key='product_id'
        ,incremental_strategy='delete+insert'
    ) 
    
}}


select
    product_id, 
    product_name, 
    billing_frequency
from {{ ref('products') }} -- points to the seeded table

