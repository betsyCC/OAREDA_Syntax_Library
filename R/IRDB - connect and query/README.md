# Using R to connect to IRDB

## Things to keep in mind when using R to query the IRDB

- I have not found a way to include Regex in SQL queries that are run in R (although I think Travis might know?).  The escape character \ causes an error.
- Double quotes will also throw an error because your query string in R is defined with double quotes since single quotes are often used in the query.

## ROracle Installation Instructions are in the [RORACLE folder](https://github.com/betsyCC/OAREDA_Syntax_Library/tree/main/R/RORACLE)