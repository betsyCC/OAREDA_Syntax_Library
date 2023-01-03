----------------------------------------------
--Join standard census file from IRDB_DW/IRA schema
--Coder's First and Last Name
--Date Code was written (YYYY-MM-DD)
--Standard SQL template
----------------------------------------------

select 
hstf.IR_STUDENT_ID,
hstf.IR_SCHOLAR_ID as EMPLID,
oira.IR_STUDENT_ID_PERM as OIRA_STUDENT_ID,
hstf.IR_TERM_DATE,
hstf.IR_TERM_CODE,
term.IR_TERM_NAME,
hstf.IR_COLLEGE_ID,
hstf.IR_INSTITUTION_CODE,
inst.IR_COLLEGE_NAME,
inst.IR_COLLEGE_TYPE_1_CODE,
inst.IR_COLLEGE_TYPE_1_DESCR,
hstf.IR_ACAD_CAR_CODE,
hstd.IR_DEGREE_STATUS_CODE,
hstd.IR_DEGREE_STATUS_DESCR,
hstd.IR_FULL_PART_TYPE_CODE,
hstd.IR_FULL_PART_TYPE_DESCR,
hstd.IR_CLASS_STANDING_CODE,
hstd.IR_CLASS_STANDING_DESCR,
hstd.IR_CLASS_LEVEL_CODE,
hstd.IR_CLASS_LEVEL_DESCR,
hstd.IR_SPECIAL_INDICATOR_CODE,
hstd.IR_SPECIAL_INDICATOR_DESCR,
hstd.IR_OTHR_SPECIAL_PRG_CODE,
hstd.IR_OTHR_SPECIAL_PRG_DESCR,
hstd.IR_ADMISSION_TYPE_CODE,
hstd.IR_ADMISSION_TYPE_DESCR,
hstd.IR_NEW_STUDENT_CODE,
hstd.IR_NEW_STUDENT_DESCR,
hstd.IR_HIGH_SCHOOL_STUDENT_CODE,
hstd.IR_HIGH_SCHOOL_STUDENT_DESCR,
hstd.IR_DEGREE_PURSUED_LEVEL_CODE,     
hstd.IR_DEGREE_PURSUED_LEVEL_DESCR,   
hstd.IR_ZIPCODE,
ethd.IR_IMPUTED_ETHNICITY_CODE,
ethd.IR_IMPUTED_ETHNICITY_DESCR,  
ethd.IR_IPEDS_ETHNIC_GRP_CODE,
ethd.IR_IPEDS_ETHNIC_GRP_DESCR,   
demd.IR_AGE,
demd.IR_AGE_GROUP_1_CODE,
demd.IR_AGE_GROUP_1_DESCR,
demd.IR_AGE_GROUP_2_CODE,
demd.IR_AGE_GROUP_2_DESCR,
demd.IR_GENDER_RAW_CODE,
demd.IR_GENDER_RAW_DESCR,
demd.IR_GENDER_BINARY_CODE,
demd.IR_GENDER_BINARY_DESCR,
demd.IR_GENDER_CAT_CODE,
demd.IR_GENDER_CAT_DESCR,
demd.IR_ANCESTRY_CODE,
demd.IR_ANCESTRY_DESCR,
demd.IR_COUNTRY_GROUP_CODE,
demd.IR_COUNTRY_GROUP_DESCR,
demd.IR_NATIVE_LANG_CODE,
demd.IR_NATIVE_LANG_DESCR,
appd.IR_HS_CAS_SCHL_TYPE_CODE,
appd.IR_HS_CAS_SCHL_TYPE_DESCR,
appf.IR_CONS_HS12_CONVERT_GPA,
appf.IR_MATR_SATN_TOTAL_ANY_SCORE,
appf.IR_MATR_SATN_EBRW_ANY_SCORE,
appf.IR_MATR_SATN_MATH_ANY_SCORE,
fapd.IR_PELL_ELIGIBLE_FLG,
fapd.IR_PARENT_MARITAL_STAT_CODE,
fapd.IR_PARENT_MARITAL_STAT_DESCR,
fapd.IR_PARENT_NUM_FAMILY_MEMBERS,
fapd.IR_PARENT_AGI_AMT,
fapd.IR_PARENT_1_GRADE_LVL_CODE,
fapd.IR_PARENT_1_GRADE_LVL_DESCR,
fapd.IR_PARENT_2_GRADE_LVL_CODE,
fapd.IR_PARENT_2_GRADE_LVL_DESCR,
fapd.IR_STUDENT_DPNDCY_STAT_CODE,
fapd.IR_STUDENT_DPNDCY_STAT_DESCR,
fapd.IR_STUDENT_NUM_FAMILY_MEMBERS,
fapd.IR_STUDENT_VETERAN_FLG,
fapd.IR_STUDENT_MARITAL_STAT_CODE,
fapd.IR_STUDENT_MARITAL_STAT_DESCR,
fapd.IR_STUDENT_DEPENDENTS_FLG,
fapd.IR_STUDENT_AGI_AMT,
fapd.IR_HOUSEHLD_SIZE,
fapd.IR_HOUSEHLD_AGI_AMT,
fapd.IR_HOUSEHLD_LOW_INCOME_FLG,
fapd.IR_STUDENT_CITIZEN_STATUS_CODE,
fapd.IR_STUDENT_BIRTH_DT,
fapd.IR_STUDENT_CHILDREN_CODE,
fapd.IR_STUDENT_CHILDREN_DESCR,
faid.IR_TOT_FA_APPLIED_COUNT_DLY,
faid.IR_PARENT_AGI_RAW,
faid.IR_PARENT_UNTAXED_INCOME_RAW,
faid.IR_STUDENT_AGI_RAW,
faid.IR_STUDENT_UNTAXED_INCOME_RAW,
faid.IR_PARENT_AGI_AMT,
faid.IR_PARENT_UNTAXED_INCOME_AMT,
faid.IR_STUDENT_AGI_AMT,
faid.IR_STUDENT_UNTAXED_INCOME_AMT,
faid.IR_HOUSEHLD_AGI_AMT,
faid.IR_HOUSEHLD_UNTAXED_INCOME_AMT,
faid.IR_TOT_AID_AWD_AMT,
faid.IR_TOT_AID_AWD_CNT,
faid.IR_TOT_FED_AWD_AMT,
faid.IR_TOT_FED_AWD_CNT,
faid.IR_TOT_STATE_AWD_AMT,
faid.IR_TOT_STATE_AWD_CNT,
faid.IR_TOT_INST_AWD_AMT,
faid.IR_TOT_INST_AWD_CNT,
faid.IR_TOT_GRANT_AWD_AMT,
faid.IR_TOT_GRANT_AWD_CNT,
faid.IR_TOT_FED_GRANT_AWD_AMT,
faid.IR_TOT_FED_GRANT_AWD_CNT,
faid.IR_HEERF_AWD_AMT,
faid.IR_HEERF_AWD_CNT,
faid.IR_PELL_AWD_AMT,
faid.IR_PELL_AWD_CNT,
faid.IR_OTH_FED_GRANT_AWD_AMT,
faid.IR_OTH_FED_GRANT_AWD_CNT,
faid.IR_TOT_STATE_GRANT_AWD_AMT,
faid.IR_TOT_STATE_GRANT_AWD_CNT,
faid.IR_TAP_AWD_CNT,
faid.IR_TAPWV_AWD_AMT,
faid.IR_TAPWV_AWD_CNT,
faid.IR_SEEK_CD_AWD_AMT,
faid.IR_SEEK_CD_AWD_CNT,
faid.IR_VETERAN_AWD_AMT,
faid.IR_VETERAN_AWD_CNT,
faid.IR_NYS_EXCELSIOR_AWD_AMT,
faid.IR_NYS_EXCELSIOR_AWD_CNT,
faid.IR_NYC_COUNCIL_MERIT_AWD_AMT,
faid.IR_NYC_COUNCIL_MERIT_AWD_CNT,
faid.IR_TOT_INST_GRANT_AWD_AMT,
faid.IR_TOT_INST_GRANT_AWD_CNT,
faid.IR_ATHLETIC_DISB_AMT,
faid.IR_ATHLETIC_DISB_CNT,
faid.IR_TOT_LOAN_DISB_AMT,
faid.IR_TOT_LOAN_DISB_CNT,
faid.IR_TOT_FED_LOAN_DISB_AMT,
faid.IR_TOT_FED_LOAN_DISB_CNT,
skat.IR_INIT_ALL_TEST_STATUS_CODE, 
skat.IR_INIT_ALL_TEST_STATUS_DESCR,
hstf.IR_HEADCOUNT_HST,
hstf.IR_FTE_SEM_TOTAL_HST,
hstf.IR_FTE_UGRD_LVL_HST,
hstf.IR_FTE_GRAD_LVL_HST

from
irdb_dw.WC_IRA_TERM_ENRLMT_HST_F hstf

inner join 
irdb_dw.WC_IRA_TERM_ENRLMT_HST_D hstd   
 on hstf.IR_STUDENT_ID    = hstd.IR_STUDENT_ID  
and hstf.IR_TERM_DATE     = hstd.IR_TERM_DATE
and hstf.IR_COLLEGE_ID    = hstd.IR_COLLEGE_ID
and hstf.IR_ACAD_CAR_CODE = hstd.IR_ACAD_CAR_CODE      

inner join 
irdb_dw.WC_IRA_SCHOLAR_HST_D oira
on hstf.IR_STUDENT_ID=oira.IR_STUDENT_ID

left outer join irdb_dw.WC_IRA_INSTITUTION_D inst
 on hstf.IR_COLLEGE_ID      = inst.IR_COLLEGE_ID
and hstf.IR_TERM_CODE between inst.IR_BEGIN_TERM_CODE and inst.IR_END_TERM_CODE

left outer join 
irdb_dw.WC_IRA_INSTITUTION_D inst
 on hstf.IR_COLLEGE_ID      = inst.IR_COLLEGE_ID
and hstf.IR_TERM_CODE between inst.IR_BEGIN_TERM_CODE and inst.IR_END_TERM_CODE

left outer join 
irdb_dw.WC_IRA_TERM_ETHNICITY_HST_D ethd  --underdevelopment
 on hstf.IR_STUDENT_ID    = ethd.IR_STUDENT_ID  
and hstf.IR_TERM_DATE     = ethd.IR_TERM_DATE
and hstf.IR_COLLEGE_ID    = ethd.IR_COLLEGE_ID
and hstf.IR_ACAD_CAR_CODE = ethd.IR_ACAD_CAR_CODE

left outer join 
irdb_dw.WC_IRA_TERM_DEMOG_HST_D demd  --only recent terms currently loaded 2022-12-18
 on hstf.IR_STUDENT_ID    = demd.IR_STUDENT_ID  
and hstf.IR_TERM_DATE     = demd.IR_TERM_DATE
and hstf.IR_COLLEGE_ID    = demd.IR_COLLEGE_ID
and hstf.IR_ACAD_CAR_CODE = demd.IR_ACAD_CAR_CODE

left outer join 
irdb_dw.WC_IRA_ADM_APPLICANT_HSTD appd
 on hstf.IR_STUDENT_ID    = appd.IR_STUDENT_ID  
and hstf.IR_TERM_DATE     = appd.IR_TERM_DATE
and hstf.IR_COLLEGE_ID    = appd.IR_COLLEGE_ID
and hstf.IR_ACAD_CAR_CODE = appd.IR_ACAD_CAR_CODE

--as an alternative, the table below can be joined as an inner join to the table above
left outer join 
irdb_dw.WC_IRA_ADM_FUNNEL_HST_F appf
 on hstf.IR_STUDENT_ID    = appf.IR_STUDENT_ID  
and hstf.IR_TERM_DATE     = appf.IR_TERM_DATE
and hstf.IR_COLLEGE_ID    = appf.IR_COLLEGE_ID
and hstf.IR_ACAD_CAR_CODE = appf.IR_ACAD_CAR_CODE

left outer join 
irdb_dw.WC_IRA_SKAT_INITIAL_HST_D skat  --under development
 on hstf.IR_STUDENT_ID    = skat.IR_STUDENT_ID  
and hstf.IR_TERM_DATE     = skat.IR_TERM_DATE
and hstf.IR_COLLEGE_ID    = skat.IR_COLLEGE_ID
and hstf.IR_ACAD_CAR_CODE = skat.IR_ACAD_CAR_CODE

left outer join
irdb_dw.WC_IRA_FA_FED_AID_APP_HST_D fapd
 on hstf.IR_STUDENT_ID      = fapd.IR_STUDENT_ID
and hstf.IR_COLLEGE_ID      = fapd.IR_COLLEGE_ID
and hstf.IR_ACAD_CAR_CODE   = fapd.IR_ACAD_CAR_CODE
and hstf.IR_TERM_DATE       = fapd.IR_TERM_DATE

left outer join
irdb_dw.WC_IRA_TERM_FA_AWD_DISB_DLY_F faid
 on hstf.IR_STUDENT_ID      = faid.IR_STUDENT_ID
and hstf.IR_COLLEGE_ID      = faid.IR_COLLEGE_ID
and hstf.IR_ACAD_CAR_CODE   = faid.IR_ACAD_CAR_CODE
and hstf.IR_TERM_DATE       = faid.IR_TERM_DATE

--the join below will change the structure of the table
--joins multiple records - one for each class per student per institution per term
/*
inner join irdb_dw.WC_IRA_CLASS_PERF_HST_D clsd
 on hstd.IR_STUDENT_ID    = clsd.IR_STUDENT_ID  
and hstd.IR_TERM_DATE     = clsd.IR_TERM_DATE
and hstd.IR_COLLEGE_ID    = clsd.IR_COLLEGE_ID
and hstd.IR_ACAD_CAR_CODE = clsd.IR_ACAD_CAR_CODE
*/

--the join below will change the structure of the table unless
--a conditiion on maj_num is set to a single value (i.e., 1, for first major)
/*inner join irdb_dw.WC_IRA_ACAD_MAJ_PLAN_HST_D majd 
 on hstd.IR_STUDENT_ID=majd.IR_STUDENT_ID  
and hstd.IR_TERM_DATE=majd.IR_TERM_DATE
and hstd.IR_COLLEGE_ID=majd.IR_COLLEGE_ID
and hstd.IR_ACAD_CAR_CODE=majd.IR_ACAD_CAR_CODE      
*/

where 
hstf.IR_TERM_DATE               in (date '2021-09-01', date '2022-02-01') --limit to fall and spring terms
/*
and hstd.IR_HEADCOUNT_HST_CODE  = '1'  --students counted in the official headcount
and hstd.IR_NEW_STUDENT_CODE    = '1'  --first-time freshmen
and hstd.IR_FULL_PART_TYPE_CODE = '1'  --full-time students
and hstd.IR_DEGREE_PURSUED_LEVEL_CODE in ('2','3') --associate(2) and baccalaureate(3) students
*/
;