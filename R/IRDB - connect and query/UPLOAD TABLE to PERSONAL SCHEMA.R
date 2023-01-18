# To upload a table to ddIRDW personal schema from RStudio

# connect to ddIRDW

library(DBI)
library(odbc)

Sys.setenv(TZ = "GMT")
Sys.setenv(ORA_SDTZ = "GMT")

ddIRDW <- DBI::dbConnect(odbc::odbc(),
                           Driver = "Oracle in OraClient12Home1",
                           DBQ = "IRAdevDB1.CUNY.Edu:2483/ddIRDW_HUD",
                           SVC = "user_id", # schema when connection opens
                           UID = "user_id", # user id
                           PWD = "user_password") # user password

# change field names to all caps

df%<>%
  rename_all(., toupper)


# upload table df to personal schema

dbWriteTable(ddIRDW, schema="USER_ID","TABLE_NAME", df, overwrite = TRUE)
