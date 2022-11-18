# Run these two lines before you load library(ROracle). 
# This should set your timezone to match the IRDBs and should prevent the time shifting
  
Sys.setenv(TZ = Sys.timezone())
Sys.setenv(ORA_SDTZ = Sys.timezone())

# also add this line after pulling any data from Oracle to convert all posix dates to regular R dates:
  
mutate(across(lubridate::is.POSIXct, as.Date))