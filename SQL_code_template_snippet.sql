------------------------------------------------------------------------------------------
-- FILE NAME: [path]\filename.sql

-- CREATED: [YYYY-MM-DD]

-- WRITTEN BY: [First and Last Name of original code author]

-- PURPOSE AND BACKGROUND: 
-- [Purpose]

-- DATA TIME FRAME:
-- [what years or semesters were queried (original)?]

-- REVISIONS:
-- 
-- 
------------------------------------------------------------------------------------------ 

SELECT
hstf.IR_TERM_DATE,
hstf.IR_INSTITUTION_CODE,
inst.IR_COLLEGE_NAME,
hstd.IR_CLASS_LEVEL_CODE,
hstd.IR_CLASS_LEVEL_DESCR,
ethd.IR_IMPUTED_ETHNICITY_CODE,
ethd.IR_IMPUTED_ETHNICITY_DESCR,
demd.IR_GENDER_BINARY_CODE,
demd.IR_GENDER_BINARY_DESCR,
SUM(hstf.IR_HEADCOUNT_HST) as HEADCOUNT

FROM
irdb_dw.WC_IRA_TERM_ENRLMT_HST_F
inner join
irdb_dw.WC_IRA_TERM_ENRLMT_HST_D

 on hstf.IR_STUDENT_ID     = hstd.IR_STUDENT_ID
and hstf.ir_acad_car_code  = hstd.IR_ACAD_CAR_CODE
and hstf.Ir_College_Id     = hstd.Ir_College_Id
and hstf.IR_TERM_DATE      = hstd.IR_TERM_DATE

left outer join
irdb_dw.WC_IRA_INSTITUTION_D inst
 on hstf.IR_INSTITUTION_CODE = inst.IR_INSTITUTION_CODE
and hsft.IR_TERM_CODE BETWEEN inst.IR_TERM_BEGIN and inst.IR_TERM_END

inner join
irdb_dw.WC_IRA_TERM_ETHNICITY_HST_D ethd
 on hstf.IR_STUDENT_ID      = ethd.IR_STUDENT_ID
and hstf.IR_COLLEGE_ID      = ethd.IR_COLLEGE_ID
and hstf.IR_ACAD_CAR_CODE   = ethd.IR_ACAD_CAR_CODE
and hstf.IR_TERM_DATE       = ethd.IR_TERM_DATE

inner join
irdb_dw.WC_IRA_TERM_DEMOG_HST_D demd
 on hstf.IR_STUDENT_ID      = demd.IR_STUDENT_ID
and hstf.IR_COLLEGE_ID      = demd.IR_COLLEGE_ID
and hstf.IR_ACAD_CAR_CODE   = demd.IR_ACAD_CAR_CODE
and hstf.IR_TERM_DATE       = demd.IR_TERM_DATE

WHERE
hstf.IR_TERM_DATE >= add_months(SYSDATE), -11)
and extract(MONTH from hstf.IR_TERM_DATE) = 9

GROUP BY hstf.IR_TERM_DATE,
hstf.IR_INSTITUTION_CODE,
inst.IR_COLLEGE_NAME,
hstd.IR_CLASS_LEVEL_CODE,
hstd.IR_CLASS_LEVEL_DESCR,
ethd.IR_IMPUTED_ETHNICITY_CODE,
ethd.IR_IMPUTED_ETHNICITY_DESCR,
demd.IR_GENDER_BINARY_CODE,
demd.IR_GENDER_BINARY_DESCR

ORDER BY 
hstf.IR_TERM_DATE,
hstf.IR_INSTITUTION_CODE,
inst.IR_COLLEGE_NAME,
hstd.IR_CLASS_LEVEL_CODE,
hstd.IR_CLASS_LEVEL_DESCR,
ethd.IR_IMPUTED_ETHNICITY_CODE,
ethd.IR_IMPUTED_ETHNICITY_DESCR,
demd.IR_GENDER_BINARY_CODE,
demd.IR_GENDER_BINARY_DESCR
;
