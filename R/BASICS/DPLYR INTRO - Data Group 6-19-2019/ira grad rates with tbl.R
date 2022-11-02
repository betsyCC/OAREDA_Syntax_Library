
# this got fixed and should work now!

Sys.setenv(TZ = Sys.timezone())
Sys.setenv(ORA_SDTZ = Sys.timezone())

library(tidyverse)
library(ROracle)
library(dbplyr)

con <-
  dbConnect(
    dbDriver("Oracle"),
    dbname = "IRDBPROD2",
    user = "ttdbh",
    password = rstudioapi::askForPassword("Database password:")
  )

# use tbl() function to create links to SQL tables in the database
# applying dplyr functions to an Oracle table translates the dplyr to SQL
# sql_render() shows the generated SQL
# collect() pulls the data into R using the generated SQL

#ba 6yr
#IRA institutional rates
ira_inst_rates_sql <- tbl(con, in_schema('IRDB_DW', 'WC_IRA_TERM_COHORT_HST_D')) %>%
  filter(IR_CHRT_TERM_DATE %in% c('01-sep-2008','01-sep-2009','01-sep-2010','01-sep-2011','01-sep-2012'),
         IR_CHRT_FULL_PART_TYPE_CODE == '1',
         IR_CHRT_NEW_STUDENT_CODE == '1',
         IR_CHRT_DEGR_PURSUED_LEV_CODE == '3') %>%
  group_by(IR_CHRT_TERM_DATE) %>%
  summarise(COHORT = n(),
            GRAD6 = sum(if_else(IR_YR06_IPEDS_GRS_LVL_CODE %in% c('19','20','21'), 1, 0))) %>%
  mutate(GRAD6RATE = GRAD6 / COHORT) %>%
  arrange(IR_CHRT_TERM_DATE)

ira_inst_rates_sql %>% sql_render()

ira_inst_rates <- ira_inst_rates_sql %>% collect()

#IRDB system rates
irdb_sys_rates <- tbl(con, in_schema('IR', 'COHORT_FACTS')) %>%
  filter(FA01_TERM_ENROLLED_DATE %in% c('01-sep-2008','01-sep-2009','01-sep-2010','01-sep-2011','01-sep-2012'),
         FA01_FULL_PART_TYPE_CODE == '1',
         FA01_NEW_STUDENT_CODE == '1',
         FA01_DEGREE_PURSUED_LEVEL_CODE == '3') %>%
  group_by(FA01_TERM_ENROLLED_DATE) %>%
  summarise(COHORT = n(),
            GRAD6 = sum(if_else(RT06_RETENTION_CATEGORY_CODE == '4', 1, 0))) %>%
  mutate(GRAD6RATE = GRAD6 / COHORT) %>%
  arrange(FA01_TERM_ENROLLED_DATE)  %>% 
  collect()

dbDisconnect(con)

#comparison
left_join(ira_inst_rates %>%
            select(cohort_date = IR_CHRT_TERM_DATE,
                   ira_6yr_inst_rate = GRAD6RATE),
          
          irdb_sys_rates %>%
            select(cohort_date = FA01_TERM_ENROLLED_DATE,
                   irdb_6yr_sys_rate = GRAD6RATE)
          ) %>%
  mutate(difference_in_rate = irdb_6yr_sys_rate - ira_6yr_inst_rate) %>%
  mutate_at(vars(ends_with("rate")), scales::percent)

View(.Last.value)
