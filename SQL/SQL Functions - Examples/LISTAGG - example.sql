-------------------------------------------------------------------------------------------------
-- Name:   Example - LISTAGG.sql
-- Date:   2019-08-27
-- Author: Mark Casazza
--
-- Purpose: Example of how LISTAGG works as an aggregate function. The second example uses the
--          DISTINCT modifier for the LISTAGG command.
-------------------------------------------------------------------------------------------------

-- create an aggregated list of prior awards and when they were earned 
SELECT
  institution,
  emplid,
  LISTAGG(degree
          || '-'
          || completion_term, ', ') WITHIN GROUP(
    ORDER BY
      completion_term
    )
FROM
  fnd_cf.ps_acad_degr
GROUP BY
  institution,
  emplid;
  
-- If the field you're aggregating contains duplicate values, you can also use DISTINCT modifier
-- if the database compatibility is set to 19c or higher.

SELECT
  institution,
  dap_stu_id,
  dap_school,
  dap_audit_date,
  LISTAGG(DISTINCT audit_block_value, ',') WITHIN GROUP(
  ORDER BY
    audit_block_num
  ) acad_plan_list
FROM
  fnd_dw.ir_audit_unpivoted
WHERE
  ir_recent_audit_flag = 'Y'
  AND audit_block_name = 'MAJOR'
GROUP BY
  institution,
  dap_stu_id,
  dap_school,
  dap_audit_date
ORDER BY
  institution,
  dap_stu_id,
  dap_school,
  dap_audit_date;
