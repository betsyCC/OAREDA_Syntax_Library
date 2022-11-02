# Pivot SES data to long format for Tableau
# Travis Dale
# 8/17/2022

library(here)
library(tidyverse)
library(haven)
library(labelled)


# read spss data file
ses <- read_sav("O:/!Projects/OAREDA_Syntax_Library/DATA/ses2022_tab_20220816.sav")
# scs <- scs %>% filter(INCOMP == 1) # filter only completed surveys

ses_long <- ses %>% 
  select(-ends_with('TEXT'), -c(Q29, Q106)) %>% # remove open-ended qs
  pivot_longer(cols = Q3_1:Q90, names_to = 'q_name', values_to = 'q_response', values_transform = list(q_response = as.character)) # pivot to long

ses_labels <- tibble(q_label = unlist(lapply(var_label(ses), function(x) ifelse(is.null(x), NA, x)))) # extract labels
ses_labels$q_name <- names(ses)

ses_long <- left_join(ses_long, ses_labels, by="q_name") # join labels to long data frame

# convert to factors for value labels and pivot
ses_fact <- ses %>% select(EMPLID, Q3_1:Q106) %>% to_factor() %>% pivot_longer(cols = Q3_1:Q106, names_to = 'q_name', values_to = 'q_resp_label') 

# join value labels 
ses_long <- left_join(ses_long, ses_fact) %>% filter(!is.na(RESP_WT_COL)) #%>% # filter out 0 weight responses
  #select(EMPLID, COLLEGE, COLLTYPE, GENDERN, RESP_WT_COL, q_name, q_response, q_label, q_resp_label) # select only needed vars

# save as data frame
ses_long <- as.data.frame(ses_long) 
#write_rds(ses_long, here('Data', 'ses2022_long_20220816.rds'))
write_csv(ses_long, here('Data', 'ses2022_long_20220816.csv'))

# aggregate 
ses_long_agg <- ses_long %>% 
  group_by(IR_COLLEGE_ID, IR_INSTITUTION_CODE, AGE_25, GENDER, ETHRACE, FPTIME, DEGLVL, q_name, q_response, q_label, q_resp_label) %>%
  summarise(N_RESP = n(), SUM_WT = sum(RESP_WT_COL))

# output agg data
#write_rds(ses_long_agg, here('Data', 'ses2022_long_agg_20220816.rds'))
write_csv(ses_long_agg, here('Data', 'ses2022_long_agg_20220816.csv'))
