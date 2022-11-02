--IRA

select hstd.IR_STUDENT_ID,hstd.IR_SCHOLAR_ID as EMPLID,
oira.IR_STUDENT_ID_PERM as OIRA_STUDENT_ID,
hstd.IR_TERM_DATE,hstd.IR_TERM_CODE,
hstd.IR_COLLEGE_ID,hstd.IR_INSTITUTION_CODE,
hstd.IR_ACAD_CAR_CODE,
hstd.IR_DEGREE_STATUS_CODE,
hstd.IR_FULL_PART_TYPE_CODE,
hstd.IR_CLASS_STANDING_CODE,
hstd.IR_CLASS_LEVEL_CODE,
hstd.IR_SPECIAL_INDICATOR_CODE,
hstd.IR_OTHR_SPECIAL_PRG_CODE,
hstd.IR_ADMISSION_TYPE_CODE,
hstd.IR_NEW_STUDENT_CODE,
hstd.IR_HIGH_SCHOOL_STUDENT_CODE,
hstd.IR_DEGREE_PURSUED_LEVEL_CODE,       
hstd.IR_ZIPCODE,
oira.IR_BIRTH_DT,
oira.IR_GENDER_CODE,
ethd.IR_IMPUTED_ETHNICITY_CODE,
ethd.IR_IMPUTED_ETHNICITY_DESCR,  
ethd.IR_IPEDS_ETHNIC_GRP_CODE,
ethd.IR_IPEDS_ETHNIC_GRP_DESCR,   
casd.IR_HS_DEGREE_DT,
casd.IR_HS_CAS_SCHL_TYPE_CODE,
casd.IR_HS_CAS_SCHL_TYPE_DESCR,
casd.IR_SATN_TOTAL_SCORE,
inst.IR_COLLEGE_NAME,
inst.IR_COLLEGE_TYPE_1_CODE,
inst.IR_COLLEGE_TYPE_1_DESCR   



from irdb_dw.WC_IRA_TERM_ENRLMT_HST_D hstd



inner join irdb_dw.WC_IRA_TERM_ENRLMT_HST_F hstf   --Perf/end of term credits not yet available
on hstd.IR_STUDENT_ID=hstf.IR_STUDENT_ID  
and hstd.IR_TERM_DATE=hstf.IR_TERM_DATE
and hstd.IR_COLLEGE_ID=hstf.IR_COLLEGE_ID
and hstd.IR_ACAD_CAR_CODE=hstf.IR_ACAD_CAR_CODE      



inner join irdb_dw.WC_IRA_SCHOLAR_HST_D oira
on hstd.IR_STUDENT_ID=oira.IR_STUDENT_ID



inner join irdb_dw.WC_IRA_TERM_ETHNICITY_HST_D ethd  --underdevelopment
on hstd.IR_STUDENT_ID=ethd.IR_STUDENT_ID  
and hstd.IR_TERM_DATE=ethd.IR_TERM_DATE
and hstd.IR_COLLEGE_ID=ethd.IR_COLLEGE_ID
and hstd.IR_ACAD_CAR_CODE=ethd.IR_ACAD_CAR_CODE



inner join irdb_dw.WC_IRA_ADM_APPLICANT_HST_D casd  --underdevelopment
on hstd.IR_STUDENT_ID=casd.IR_STUDENT_ID  
and hstd.IR_TERM_DATE=casd.IR_TERM_DATE
and hstd.IR_COLLEGE_ID=casd.IR_COLLEGE_ID
and hstd.IR_ACAD_CAR_CODE=casd.IR_ACAD_CAR_CODE



inner join irdb_dw.WC_IRA_CLASS_PERF_HST_D clsd
on hstd.IR_STUDENT_ID=clsd.IR_STUDENT_ID  
and hstd.IR_TERM_DATE=clsd.IR_TERM_DATE
and hstd.IR_COLLEGE_ID=clsd.IR_COLLEGE_ID
and hstd.IR_ACAD_CAR_CODE=clsd.IR_ACAD_CAR_CODE



inner join irdb_dw.WC_IRA_SKAT_INITIAL_HST_D skat  --underdevelopment
on hstd.IR_STUDENT_ID=skat.IR_STUDENT_ID  
and hstd.IR_TERM_DATE=skat.IR_TERM_DATE
and hstd.IR_COLLEGE_ID=skat.IR_COLLEGE_ID
and hstd.IR_ACAD_CAR_CODE=skat.IR_ACAD_CAR_CODE



inner join irdb_dw.WC_IRA_ACAD_MAJ_PLAN_HST_D majd  --standard IR variables not yet available; reflects major at the end of term
on hstd.IR_STUDENT_ID=majd.IR_STUDENT_ID  
and hstd.IR_TERM_DATE=majd.IR_TERM_DATE
and hstd.IR_COLLEGE_ID=majd.IR_COLLEGE_ID
and hstd.IR_ACAD_CAR_CODE=majd.IR_ACAD_CAR_CODE      



inner join irdb_dw.WC_IRA_INSTITUTION_D inst
on hstd.IR_COLLEGE_ID = inst.IR_COLLEGE_ID
and hstd.IR_TERM_CODE>=inst.IR_BEGIN_TERM_CODE
and hstd.IR_TERM_CODE <inst.IR_END_TERM_CODE



where hstd.IR_TERM_DATE in ('01-sep-2020')
and hstd.IR_HEADCOUNT_HST_CODE='1'
and hstd.IR_NEW_STUDENT_CODE='1'
and hstd.IR_FULL_PART_TYPE_CODE='1'  
and hstd.IR_DEGREE_PURSUED_LEVEL_CODE in ('2','3')
;