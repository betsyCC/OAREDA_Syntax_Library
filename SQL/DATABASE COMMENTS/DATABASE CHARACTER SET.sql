-------------------------------------------------------------------------------------------------
-- Name:   DATABASE CHARACTER SET.sql
-- Date:   2023-04-10
-- Author: Mark Casazza
--
-- Purpose: Query the database to see what character set it is configured to use.
-------------------------------------------------------------------------------------------------

SELECT
  value AS db_charset
FROM
  nls_database_parameters
 WHERE
  parameter = 'NLS_CHARACTERSET'
;