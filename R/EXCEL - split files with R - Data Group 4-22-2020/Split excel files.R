
# to install needed packages, uncomment and run:
# install.packages("tidyverse") # also includes readxl and lubridate
# install.packages("writexl")

library(tidyverse)
library(readxl)
library(writexl)

#setwd("O:/!Projects/Data Group/20200422 Split excel files with R")

# check to see if "Output files" directory exists, and if not, create it
if (!file.exists("Output files")) {
  dir.create("Output files")
}

##############################################################################################
# step by step example

# read file
all_colleges <- read_xlsx("Input Data.xlsx")

# convert date formats
all_colleges <- mutate_if(all_colleges, lubridate::is.POSIXct, as.Date) 

#split by college
college_split <- group_split(all_colleges, INSTITUTION)

# loop over colleges and write to excel files
for (col in college_split) {
  write_xlsx(col,
             path = paste0("Output files/output_", col$INSTITUTION[1], ".xlsx"))
}

##############################################################################################
# the whole process in two commands using pipes

all_colleges <- read_xlsx("Input Data.xlsx") %>%
  mutate_if(lubridate::is.POSIXct, as.Date)

all_colleges %>% 
  group_by(INSTITUTION) %>%
  group_map(~ write_xlsx(.x, path = paste0("Output files/output_", .y$INSTITUTION, ".xlsx")), 
            keep = TRUE)


##############################################################################################
# split as tabs in one file instead of separate files, uses base split function to keep names for tab titles
# write_xlsx by default outputs a list of data frames as separate tabs within one excel file

all_colleges %>%
  split(.$INSTITUTION) %>%
  write_xlsx(path = paste0("Output files/output_tabs.xlsx"))

