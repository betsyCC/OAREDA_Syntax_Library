-------------------------------------------------------------------------------------------------
-- Name:   SUBSTR_and_INSTR_example.sql
-- Date:   2021-08-26
-- Author: Mark Casazza
--
-- Purpose:
-------------------------------------------------------------------------------------------------
select
  rad_course_key,
  substr(rad_course_key, 1, instr(rad_course_key, ' ')-1) first_part,
  substr(rad_course_key, instr(rad_course_key, ' ', -1)+1) last_part
from
  fnd_dw.rad_class_dtl
;

-- get the portion of the plan value that is after the dash, if there is a dash
select
  acad_plan,
  substr(acad_plan, instr(acad_plan,'-',1)+1) after_dash
from
  fnd_cf.ps_adm_appl_plan
;
