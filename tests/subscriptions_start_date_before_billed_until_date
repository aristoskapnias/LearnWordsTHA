select *
from {{ ref('SUBSCRIPTIONS') }}
where start_date >= billed_until_date
