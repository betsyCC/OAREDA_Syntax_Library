Sys.setenv(TZ = Sys.timezone())
Sys.setenv(ORA_SDTZ = Sys.timezone())

library(tidyverse)
library(ROracle)
library(here)
library(RCurl)
library(openxlsx)

con <-
  dbConnect(
    dbDriver("Oracle"),
    dbname = "IRDBTEST3",
    user = "ttdbh",
    password = rstudioapi::askForPassword("Database password:")
  )

SQL_query <-  "

SELECT * FROM (
SELECT idn.NAME_FIRST, idn.NAME_MIDDLE, idn.NAME_LAST, to_char(idn.BIRTH_DATE,'YYYYMMDD') AS BIRTH_DATE,
    to_char(tebs.TERM_ENROLLED_DATE,'YYYYMMDD') AS ENR_DATE, CL.COLLEGE_FICE_UNITID, tebs.COLLEGE_ID,  tebs.OIRA_STUDENT_ID, tebs.ACADEMIC_YEAR_DESC, 
    RANK() OVER (PARTITION BY tebs.OIRA_STUDENT_ID ORDER BY tebs.TERM_ENROLLED_DATE, ROWNUM) AS rank1

FROM ttdbh.TE_ENROLL_ALL tebs

LEFT OUTER JOIN IR.OIRA_ID_NUMBERS idn
ON tebs.OIRA_STUDENT_ID = idn.OIRA_STUDENT_ID 

LEFT OUTER JOIN IR.COLLEGE_LOOKUP CL
ON tebs.COLLEGE_ID=CL.COLLEGE_ID 

WHERE DEGREE_PURSUED_LEVEL_DESC = 'MASTER''S'
AND NAME_FIRST != 'NFN' AND idn.BIRTH_DATE IS NOT NULL
) 
WHERE rank1 = 1
"

te_b_nslc <- dbGetQuery(con, SQL_query) %>%
  transmute(colA = 'D1',
            colB = '',
            colC = NAME_FIRST,
            colD = str_sub(NAME_MIDDLE, 1, 1) %>% replace_na(""),
            colE = NAME_LAST,
            colF = '',
            colG = BIRTH_DATE,
            colH = ENR_DATE,
            colI = '',
            colJ = COLLEGE_FICE_UNITID,
            colK = '00',
            colL = paste(COLLEGE_ID, OIRA_STUDENT_ID, str_replace(ACADEMIC_YEAR_DESC, '-', 'A'), sep = '.')
            )

header_row <- paste("H1", "009999", "00", "CUNY Institutional Research", format(Sys.Date(),"%Y%m%d"), "PA", "S", "\n", sep = '\t')
trailer_row <- paste("T1", as.character(nrow(te_b_nslc) + 2), sep = '\t')

fname = paste0("OIRA_TD_009999_TE_menroll_AY0405_1920", format(Sys.Date(), "%Y%m%d"), ".txt")

write_file(header_row, path = here("NSLC", fname), append = FALSE)
write_tsv(te_b_nslc, path = here("NSLC", fname), append = TRUE, col_names = FALSE)
write_file(trailer_row, path = here("NSLC", fname), append = TRUE)

nslc_loc <- 'O:/!Projects/Collections/NSLC/Requests/'

file.copy(here('NSLC', fname), paste0(nslc_loc, 'request files/', fname))

openXL(paste0(nslc_loc, '!Request Log.xls'))

clipr::write_clip(paste0(c(fname, '---', Sys.Date(), 'Travis', '', '', nrow(te_b_nslc), '', here('nslc - prepare file ma enroll 20210816.R')), collapse = '\t'))

ftpUpload(here('NSLC', fname),
          paste0("sftp://ftps.nslc.org/Home/009999irst/", fname),
          userpwd = '009999irst:@LTaf#R7')




