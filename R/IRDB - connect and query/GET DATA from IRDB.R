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


dbDisconnect(con)
rm(con)

