
Sys.setenv(TZ = Sys.timezone())
Sys.setenv(ORA_SDTZ = Sys.timezone())

library(tidyverse)
library(ROracle)

con <-
  dbConnect(
    dbDriver("Oracle"),
    dbname = "IRDBPROD2",
    user = "ttdbh",
    password = rstudioapi::askForPassword("Database password:")
  )

# query IRA table and store as tibble
ira_cohort <- dbGetQuery(con, "
SELECT * 
FROM IRDB_DW.WC_IRA_TERM_COHORT_HST_D 
WHERE IR_CHRT_TERM_DATE in ('01-sep-2008','01-sep-2009','01-sep-2010','01-sep-2011','01-sep-2012')
") %>%
  as_tibble()

dbDisconnect(con)

# pipe operator %>%
# allows sequential composition of functions

round(log(sqrt(25)),2)

a <- 25
b <- sqrt(a)
c <- log(b)
d <- round(c, 2)
d

25 %>% sqrt() %>% log() %>% round(2)

# can pipe over several rows
25 %>%
  sqrt() %>%
  log() %>%
  round(2)

# use assignment operator <- to save result
result <- 25 %>% sqrt() %>% log() %>% round(2)

result

# can also reverse assignment operator to -> save result at the end of the pipe
25 %>% sqrt() %>% log() %>% round(2) -> result

result

ira_cohort

# select variables by name
select(ira_cohort, 
       IR_CHRT_TERM_DATE, 
       IR_YR06_IPEDS_GRS_LVL_CODE, 
       IR_CHRT_FULL_PART_TYPE_CODE, 
       IR_CHRT_NEW_STUDENT_CODE, 
       IR_CHRT_DEGR_PURSUED_LEV_CODE)


# same using pipe
ira_cohort %>% select(IR_CHRT_TERM_DATE, 
                      IR_YR06_IPEDS_GRS_LVL_CODE, 
                      IR_CHRT_FULL_PART_TYPE_CODE, 
                      IR_CHRT_NEW_STUDENT_CODE, 
                      IR_CHRT_DEGR_PURSUED_LEV_CODE)

# need assignment operator to save new table
ira2 <- ira_cohort %>% select(IR_CHRT_TERM_DATE, 
                              IR_YR06_IPEDS_GRS_LVL_CODE, 
                              IR_CHRT_FULL_PART_TYPE_CODE, 
                              IR_CHRT_NEW_STUDENT_CODE, 
                              IR_CHRT_DEGR_PURSUED_LEV_CODE)


ira2

# select range of variables
ira_cohort %>% 
  select(IR_CHRT_TERM_DATE:IR_CHRT_FULL_PART_TYPE_CODE)

# select range of variables by position
ira_cohort %>% 
  select(10:14)

# remove columns
ira_cohort %>% 
  select(-IR_CHRT_ROW_HST_WID, -IR_CHRT_SCHOLAR_HST_WID)

ira_cohort %>% 
  select(-c(IR_CHRT_SCHOLAR_ID:IR_Y6NX_CLASS_LEVEL))

ira_cohort %>% 
  select(-c(5:290))

# select by string match
ira_cohort %>%
  select(starts_with("IR_YR06"))

ira_cohort %>%
  select(contains("IPEDS"))

# select with several different methods
ira_cohort %>%
  select(IR_CHRT_SCHOLAR_ID, 
         9:11,
         contains("Y1LS"),
         -ends_with("CODE"))

# reorder columns with select and everything()
ira_cohort %>% 
  select(IR_CHRT_COLLEGE_ID, IR_CHRT_STUDENT_ID, everything())

# rename columns
# drops unselected
ira_cohort %>% 
  select(college = IR_CHRT_COLLEGE_ID, student_id = IR_CHRT_STUDENT_ID)

# everything() keeps unnamed columns
ira_cohort %>% 
  select(college = IR_CHRT_COLLEGE_ID, student_id = IR_CHRT_STUDENT_ID, everything())

# rename keeps unnamed columns, doesn't reorder
ira_cohort %>% 
  rename(college = IR_CHRT_COLLEGE_ID, student_id = IR_CHRT_STUDENT_ID)

# filter rows
ira_cohort %>%
  select(IR_CHRT_STUDENT_ID:IR_CHRT_COLLEGE_ID) %>%
  filter(IR_CHRT_TERM_DATE == '2012-09-01')

# multiple filters: & or ,
ira_cohort %>%
  select(IR_CHRT_STUDENT_ID:IR_CHRT_COLLEGE_ID) %>%
  filter(IR_CHRT_TERM_DATE == '2012-09-01' & IR_CHRT_COLLEGE_ID == '03')

ira_cohort %>%
  select(IR_CHRT_STUDENT_ID:IR_CHRT_COLLEGE_ID) %>%
  filter(IR_CHRT_TERM_DATE == '2012-09-01', 
         IR_CHRT_COLLEGE_ID == '03')

# or filter
ira_cohort %>%
  select(IR_CHRT_STUDENT_ID:IR_CHRT_COLLEGE_ID) %>%
  filter(IR_CHRT_TERM_DATE == '2012-09-01' | IR_CHRT_COLLEGE_ID == '03')

# %in% filter, use c() to concatenate values
ira_cohort %>%
  select(IR_CHRT_STUDENT_ID:IR_CHRT_COLLEGE_ID) %>%
  filter(IR_CHRT_COLLEGE_ID %in% c('03', '04'))


# select and filter in either order, but can't filter on variables not selected, obviously
ira_cohort %>%
  filter(IR_CHRT_TERM_DATE == '2012-09-01', 
         IR_CHRT_COLLEGE_ID == '03') %>%
  select(IR_CHRT_STUDENT_ID:IR_CHRT_COLLEGE_ID)

ira_cohort %>%
  filter(IR_CHRT_FULL_PART_TYPE_CODE == '1') %>%
  select(IR_CHRT_STUDENT_ID:IR_CHRT_COLLEGE_ID)

ira_cohort %>%
  select(IR_CHRT_STUDENT_ID:IR_CHRT_COLLEGE_ID) %>%
  filter(IR_CHRT_FULL_PART_TYPE_CODE == '1')

# sort data with arrange
ira_cohort %>%
  select(IR_CHRT_STUDENT_ID:IR_CHRT_COLLEGE_ID) %>%
  arrange(IR_CHRT_COLLEGE_ID)

# seperate nested sort with comma
ira_cohort %>%
  select(IR_CHRT_STUDENT_ID:IR_CHRT_COLLEGE_ID) %>%
  arrange(IR_CHRT_COLLEGE_ID, IR_CHRT_TERM_DATE)

# sort descending with desc() function
ira_cohort %>%
  select(IR_CHRT_STUDENT_ID:IR_CHRT_COLLEGE_ID) %>%
  arrange(IR_CHRT_COLLEGE_ID, desc(IR_CHRT_TERM_DATE))

# create new columns with mutate()
ira_cohort %>% 
  select(IR_CHRT_TERM_DATE, IR_CHRT_STUDENT_ID, IR_CHRT_FULL_PART_TYPE_CODE, IR_CHRT_NEW_STUDENT_CODE) %>%
  mutate(FTFTF = IR_CHRT_FULL_PART_TYPE_CODE == '1' & IR_CHRT_NEW_STUDENT_CODE == '1')

# seperate new columns with commas
ira_cohort %>%
  select(IR_CHRT_TERM_DATE, IR_CHRT_STUDENT_ID, IR_CHRT_FULL_PART_TYPE_CODE, IR_CHRT_NEW_STUDENT_CODE) %>%
  mutate(FTFTF = IR_CHRT_FULL_PART_TYPE_CODE == '1' & IR_CHRT_NEW_STUDENT_CODE == '1',
         year = lubridate::year(IR_CHRT_TERM_DATE))


# you can refer to columns just created
ira_cohort %>% 
  select(IR_CHRT_TERM_DATE, IR_CHRT_STUDENT_ID, IR_CHRT_FULL_PART_TYPE_CODE, IR_CHRT_NEW_STUDENT_CODE) %>%
  mutate(FTFTF = IR_CHRT_FULL_PART_TYPE_CODE == '1' & IR_CHRT_NEW_STUDENT_CODE == '1',
         FTFTF_DESC = if_else(FTFTF, "full-time, first-time freshmen", "something else"))

# mutate more than one column at a time
ira_cohort %>%
  select(IR_CHRT_TERM_DATE, IR_CHRT_STUDENT_ID, IR_CHRT_COLLEGE_ID, IR_Y1LS_TERM_DATE, IR_Y1LS_COLLEGE_ID) %>%
  mutate_if(lubridate::is.POSIXct, as.Date) %>%
  mutate_at(vars(contains("COLLEGE")),
            ~ recode(.,
                     `05` = "Brooklyn",
                     `06` = "Queens",
                     `07` = "CSI"
                     ))

# save table with the assignment operator <-

ira_ftft <- ira_cohort %>% 
  select(IR_CHRT_TERM_DATE, IR_CHRT_STUDENT_ID, IR_CHRT_FULL_PART_TYPE_CODE, IR_CHRT_NEW_STUDENT_CODE) %>%
  mutate(FTFTF = IR_CHRT_FULL_PART_TYPE_CODE == '1' & IR_CHRT_NEW_STUDENT_CODE == '1',
         FTFTF_DESC = if_else(FTFTF, "full-time, first-time freshmen", "something else"))

# view table in RStudio by enclosing in or piping to View() 

View(ira_cohort %>% 
       select(IR_CHRT_TERM_DATE, IR_CHRT_STUDENT_ID, IR_CHRT_FULL_PART_TYPE_CODE, IR_CHRT_NEW_STUDENT_CODE) %>%
       mutate(FTFTF = IR_CHRT_FULL_PART_TYPE_CODE == '1' & IR_CHRT_NEW_STUDENT_CODE == '1',
              FTFTF_DESC = if_else(FTFTF, "full-time, first-time freshmen", "something else")))

ira_cohort %>% 
  select(IR_CHRT_TERM_DATE, IR_CHRT_STUDENT_ID, IR_CHRT_FULL_PART_TYPE_CODE, IR_CHRT_NEW_STUDENT_CODE) %>%
  mutate(FTFTF = IR_CHRT_FULL_PART_TYPE_CODE == '1' & IR_CHRT_NEW_STUDENT_CODE == '1',
         FTFTF_DESC = if_else(FTFTF, "full-time, first-time freshmen", "something else")) %>%
  View()


# group_by groups the table - has no visible effect on it's own, but powerful in combination with filter(), mutate(), or summarise()

ira_cohort %>% 
  select(IR_CHRT_TERM_DATE, 
         IR_CHRT_STUDENT_ID, 
         IR_CHRT_COLLEGE_ID, 
         IR_CHRT_FULL_PART_TYPE_CODE, 
         IR_CHRT_NEW_STUDENT_CODE, 
         IR_CHRT_DEGR_PURSUED_LEV_CODE) %>%
  group_by(IR_CHRT_COLLEGE_ID)

# filter highest degree pursued by college
ira_cohort %>% 
  select(IR_CHRT_TERM_DATE, 
         IR_CHRT_STUDENT_ID, 
         IR_CHRT_COLLEGE_ID, 
         IR_CHRT_FULL_PART_TYPE_CODE, 
         IR_CHRT_NEW_STUDENT_CODE, 
         IR_CHRT_DEGR_PURSUED_LEV_CODE) %>%
  group_by(IR_CHRT_COLLEGE_ID) %>%
  filter(IR_CHRT_DEGR_PURSUED_LEV_CODE == max(IR_CHRT_DEGR_PURSUED_LEV_CODE))

table(.Last.value$IR_CHRT_DEGR_PURSUED_LEV_CODE)
table(ira_cohort$IR_CHRT_DEGR_PURSUED_LEV_CODE)

# filter only colleges with associate programs
ira_cohort %>% 
  select(IR_CHRT_TERM_DATE, 
         IR_CHRT_STUDENT_ID, 
         IR_CHRT_COLLEGE_ID, 
         IR_CHRT_FULL_PART_TYPE_CODE, 
         IR_CHRT_NEW_STUDENT_CODE, 
         IR_CHRT_DEGR_PURSUED_LEV_CODE) %>%
  group_by(IR_CHRT_COLLEGE_ID) %>% 
  filter(any(IR_CHRT_DEGR_PURSUED_LEV_CODE == '2') )

table(.Last.value$IR_CHRT_COLLEGE_ID)

# use to view duplicates
ira_cohort %>% 
  select(IR_CHRT_TERM_DATE, 
         IR_CHRT_STUDENT_ID, 
         IR_CHRT_COLLEGE_ID, 
         IR_CHRT_FULL_PART_TYPE_CODE, 
         IR_CHRT_NEW_STUDENT_CODE, 
         IR_CHRT_DEGR_PURSUED_LEV_CODE) %>%
  group_by(IR_CHRT_STUDENT_ID) %>% 
  filter(n() > 1) %>% 
  arrange(IR_CHRT_STUDENT_ID, IR_CHRT_TERM_DATE) %>%
  View()

# arrange first to remove duplicates
ira_cohort %>% 
  select(IR_CHRT_TERM_DATE, 
         IR_CHRT_STUDENT_ID, 
         IR_CHRT_COLLEGE_ID, 
         IR_CHRT_FULL_PART_TYPE_CODE, 
         IR_CHRT_NEW_STUDENT_CODE, 
         IR_CHRT_DEGR_PURSUED_LEV_CODE) %>%
  arrange(IR_CHRT_STUDENT_ID, IR_CHRT_TERM_DATE, IR_CHRT_DEGR_PURSUED_LEV_CODE) %>%
  group_by(IR_CHRT_STUDENT_ID) %>%
  filter(row_number() == 1) 


table(ira_cohort$IR_CHRT_NEW_STUDENT_DESCR)

# use group_by with mutate
ira_cohort %>% 
  select(IR_CHRT_TERM_DATE, 
         IR_CHRT_STUDENT_ID, 
         IR_CHRT_COLLEGE_ID, 
         IR_CHRT_FULL_PART_TYPE_CODE, 
         IR_CHRT_NEW_STUDENT_CODE, 
         IR_CHRT_DEGR_PURSUED_LEV_CODE) %>%
  arrange(IR_CHRT_TERM_DATE) %>%
  group_by(IR_CHRT_STUDENT_ID) %>%
  mutate(is_highest_degr_purs = IR_CHRT_DEGR_PURSUED_LEV_CODE == max(IR_CHRT_DEGR_PURSUED_LEV_CODE),
         rn = row_number())

# group_by with summarise collapses to one row per grouping
ira_cohort %>%
  group_by(IR_CHRT_TERM_DATE) %>%
  summarise(total_count = n(),
            grad6 = sum(IR_YR06_IPEDS_GRS_LVL_CODE %in% c('19','20','21')),
            grad_rate = grad6 / total_count,
            grad6_rate = mean(IR_YR06_IPEDS_GRS_LVL_CODE %in% c('19','20','21')))

by_college_and_term <- ira_cohort %>%
  group_by(IR_CHRT_COLLEGE_ID, IR_CHRT_TERM_DATE) %>%
  summarise(total_count = n(),
            ftf = sum(IR_CHRT_NEW_STUDENT_CODE == '1'),
            pct_ftf = ftf / total_count,
            fulltime = sum(IR_CHRT_FULL_PART_TYPE_CODE == '1'),
            pct_fulltime = fulltime / total_count)

by_college_and_term
# summarised tibbles retain all grouping variables except the last, allowing for subsequent grouping operations
by_college_and_term %>% 
  summarise(total_count = sum(total_count),
            total_ftf = sum(ftf),
            pct_ftf = total_ftf / total_count)


# spread to reshape data to wide format
by_college_and_term %>% 
  ungroup() %>%
  select(IR_CHRT_COLLEGE_ID, IR_CHRT_TERM_DATE, pct_ftf) %>%
  spread(IR_CHRT_TERM_DATE, pct_ftf)

# calculate ba 6yr IRA institutional rates
ira_6yr_inst_rates <- ira_cohort %>%
  filter(IR_CHRT_FULL_PART_TYPE_CODE == '1',
         IR_CHRT_NEW_STUDENT_CODE == '1',
         IR_CHRT_DEGR_PURSUED_LEV_CODE == '3') %>%
  group_by(IR_CHRT_TERM_DATE) %>%
  summarise(COHORT = n(),
            GRAD6 = sum(IR_YR06_IPEDS_GRS_LVL_CODE %in% c('19','20','21')),
            GRAD6RATE = round(100 * GRAD6 / COHORT, 1))

ira_6yr_inst_rates

# SQL for comparison

# select IR_CHRT_TERM_DATE,
# count(*) as COHORT,
# sum(case when IR_YR06_IPEDS_GRS_LVL_CODE in ('19','20','21') then 1 else null end) as GRAD6  
# from irdb_dw.WC_IRA_TERM_COHORT_HST_D 
# where IR_CHRT_TERM_DATE in ('01-sep-2008','01-sep-2009','01-sep-2010','01-sep-2011','01-sep-2012') 
# and IR_CHRT_FULL_PART_TYPE_CODE='1'
# and IR_CHRT_NEW_STUDENT_CODE='1'
# and IR_CHRT_DEGR_PURSUED_LEV_CODE='3' 
# group by IR_CHRT_TERM_DATE
# order by IR_CHRT_TERM_DATE  
# ;