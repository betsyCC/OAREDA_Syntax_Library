# Run these two lines before you load library(ROracle). 
# This should set your timezone to match the IRDBs and should prevent the time shifting

Sys.setenv(TZ = Sys.timezone())
Sys.setenv(ORA_SDTZ = Sys.timezone())

library(ROracle)

# Cannot include Regex in SQL query.  Escape character \ causes error
# Also no double quotes because your query string in R is defined with double quotes

################################ GET DATA ######################################
#------------------------------------------------------------------------------#

con <-
  dbConnect(
    dbDriver("Oracle"),
    dbname = "IRDBPROD",
    # dbname = "IRDBTEST",
    user = "TYPE_YOUR_USERNAME_HERE",
    password = rstudioapi::askForPassword("Database password:")
  )

# run SQL queries
zip_lu <- dbGetQuery(con, "SELECT * FROM IR.ZIPCODE_LU")
col_lu <- dbGetQuery(con, "SELECT * FROM IR.COLLEGE_LOOKUP")

# You can also save the query in a separate file and source it here...
source('long_SQL_query_for_testing.R')
ret_grad <- dbGetQuery(con, long_query)

# optionally convert posix dates to regular R dates 
ret_grad <- ret_grad %>% 
  mutate(across(lubridate::is.POSIXct, as.Date))


dbDisconnect(con)
rm(con)

