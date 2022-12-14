SELECT
DEG.TERM_GRADUATED_DATE,
DEG.ACADEMIC_YEAR_DESC,
DEG.YEAR_GRADUATED,
DEG.SEMESTER_GRADUATED_CODE,
DEG.SEMESTER_GRADUATED_DESC,
COL.COLLEGE_NAME_CODE,
COL.COLLEGE_NAME_DESC,
COL.COLLEGE_TYPE_DESC,
DEG.DEGREE_EARNED_DESC,
DEG.DEGREE_EARNED_LEVEL_CODE, 
DEG.DEGREE_EARNED_LEVEL_DESC,
DEG.GENDER_DESC,
DEG.ETH_IMP_GROUP_1_DESC,
DEG.RESIDENCY_TYPE_DESC,
DEG.AGE_GROUP_2_DESC,
SUM(DEG.HEADCOUNT)
 
FROM
IR.DEGREE_FACTS DEG

LEFT OUTER JOIN
IR.COLLEGE_LOOKUP COL
ON DEG.COLLEGE_ID=COL.COLLEGE_ID

WHERE
DEG.ACADEMIC_YEAR_DESC != EXTRACT(YEAR FROM ADD_MONTHS(SYSDATE,-12)) || '-' || TO_CHAR(SYSDATE, 'YYYY')

GROUP BY
DEG.TERM_GRADUATED_DATE,
DEG.ACADEMIC_YEAR_DESC,
DEG.YEAR_GRADUATED,
DEG.SEMESTER_GRADUATED_CODE,
DEG.SEMESTER_GRADUATED_DESC,
COL.COLLEGE_NAME_CODE,
COL.COLLEGE_NAME_DESC,
COL.COLLEGE_TYPE_DESC,
DEG.DEGREE_EARNED_DESC,
DEG.DEGREE_EARNED_LEVEL_CODE, 
DEG.DEGREE_EARNED_LEVEL_DESC,
DEG.GENDER_DESC,
DEG.ETH_IMP_GROUP_1_DESC,
DEG.RESIDENCY_TYPE_DESC,
DEG.AGE_GROUP_2_DESC

ORDER BY
DEG.TERM_GRADUATED_DATE,
DEG.ACADEMIC_YEAR_DESC,
DEG.YEAR_GRADUATED,
DEG.SEMESTER_GRADUATED_CODE,
DEG.SEMESTER_GRADUATED_DESC,
COL.COLLEGE_NAME_CODE,
COL.COLLEGE_NAME_DESC,
COL.COLLEGE_TYPE_DESC,
DEG.DEGREE_EARNED_DESC,
DEG.DEGREE_EARNED_LEVEL_CODE, 
DEG.DEGREE_EARNED_LEVEL_DESC,
DEG.GENDER_DESC,
DEG.ETH_IMP_GROUP_1_DESC,
DEG.RESIDENCY_TYPE_DESC,
DEG.AGE_GROUP_2_DESC
;
