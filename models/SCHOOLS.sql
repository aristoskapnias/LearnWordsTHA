{{ 
    config(
        materialized='incremental'
        ,unique_key='school_id'
        ,incremental_strategy='delete+insert'
    ) 
    
}}


select
    school_id, 
    school_name, 
    use_case
from {{ ref('schools') }} -- points to the seeded table

