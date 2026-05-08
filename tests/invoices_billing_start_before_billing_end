select *
from {{ ref('INVOICES') }}
where billing_start_date >= billing_end_date
