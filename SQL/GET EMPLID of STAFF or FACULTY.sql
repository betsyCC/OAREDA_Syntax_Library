--------------------------------------------------------------------------------------------------------
-- Name: Example - Get EMPLID of staff or faculty.sql
-- Date: 2023-01-09
-- Author: Pauline Hua
--
-- Purpose: Example of how to get EMPLID of staff/faculty member from HR data via the
--          ADW tables CF_116A_GENERIC (current live data) and XS_CF_116A_GENERIC (historical data).
--
--------------------------------------------------------------------------------------------------------
SELECT
    last_update_date,
    full_name, 
    first_name,
    last_name,
    emplid, 
    email_addr_config1, 
    descr_jobcode, 
    descr_dept
FROM fnd_cf.adw_cf_116a_generic 
     --fnd_cf.adw_xs_cf_116a_generic --Use this if you're looking for historical dates
WHERE
       first_name = 'Pauline'
       --first_name LIKE '%Paul%'  --Try LIKE operator with '%' if you're not getting results
    AND last_name = 'Hua'
ORDER BY 
    last_update_date;
    