-------------------------------------------------------------------------------------------------
-- Name:   CREATE COLUMN COMMENTS.sql
-- Date:   01-03-2023
-- Author: Betsy Rosalen
--
-- Purpose: Example code to add comments/documentation to a database table
-------------------------------------------------------------------------------------------------


-------------------------------------------------------------------------------------------------
-- This section creates a template with all the table and column names filled in for you that you can 
-- just copy and add comments to and then run to add comments to a table.  
-- See the following section for sample output

SELECT
  'comment on column '
  || owner
  || '.'
  || table_name
  || '.'
  || column_name
  || ' is q''[]'';'
FROM
  all_tab_cols@IRDBTEST
WHERE
      owner      = 'EROSALEN'
  AND table_name = 'ZIPCODE_LK'
ORDER BY
  column_id;


-------------------------------------------------------------------------------------------------
-- The code above creates output like the lines below...

comment on column EROSALEN.ZIPCODE_LK.ZIPCODE is q'[]';
comment on column EROSALEN.ZIPCODE_LK.ZIPCODE_CREATED is q'[]';
comment on column EROSALEN.ZIPCODE_LK.ZIPCODE_UPDATED is q'[]';
comment on column EROSALEN.ZIPCODE_LK.ZIPCODE_USERID is q'[]';
comment on column EROSALEN.ZIPCODE_LK.ZIPCODE_CITY_DESC is q'[]';
comment on column EROSALEN.ZIPCODE_LK.ZIPCODE_CITY is q'[]';
comment on column EROSALEN.ZIPCODE_LK.ZIPCODE_COUNTY is q'[]';
comment on column EROSALEN.ZIPCODE_LK.ZIPCODE_COUNTY_CODE is q'[]';
comment on column EROSALEN.ZIPCODE_LK.ZIPCODE_COUNTY_DESC is q'[]';
comment on column EROSALEN.ZIPCODE_LK.ZIPCODE_STATE_CODE is q'[]';
comment on column EROSALEN.ZIPCODE_LK.ZIPCODE_STATE_DESC is q'[]';
comment on column EROSALEN.ZIPCODE_LK.NYC_NEIGHBORHOOD is q'[]';
comment on column EROSALEN.ZIPCODE_LK.COUNTRY_CODE is q'[]';
comment on column EROSALEN.ZIPCODE_LK.COUNTRY_DESC is q'[]';
comment on column EROSALEN.ZIPCODE_LK.LATITUDE is q'[]';
comment on column EROSALEN.ZIPCODE_LK.LONGITUDE is q'[]';


-------------------------------------------------------------------------------------------------
-- Just fill in the comments you want to add in between the brackets [] 
-- and run the code to add the comments to the database table.
-- See the example below...
  
comment on column EROSALEN.ZIPCODE_LK.ZIPCODE is q'[5-digit zip code, includes all US Postal Service zip codes including military and US territories]';
comment on column EROSALEN.ZIPCODE_LK.ZIPCODE_CREATED is q'[date the zip code was added to the lookup table]';
comment on column EROSALEN.ZIPCODE_LK.ZIPCODE_UPDATED is q'[last date the zipcode was verified or updated]';
comment on column EROSALEN.ZIPCODE_LK.ZIPCODE_USERID is q'[user ID of the person who added the zip code to the lookup table]';
comment on column EROSALEN.ZIPCODE_LK.ZIPCODE_CITY_DESC is q'[most specific NYC neighborhood descriptions, more granular than NYC_NEIGHBORHOOD, matches ZIPCODE_CITY for all other locations]';
comment on column EROSALEN.ZIPCODE_LK.ZIPCODE_CITY is q'[5 borough names for NYC, and city names for all other locations, matches ZIPCODE_CITY_DESC except for NYC]';
comment on column EROSALEN.ZIPCODE_LK.ZIPCODE_COUNTY is q'[full county name for all zipcodes]';
comment on column EROSALEN.ZIPCODE_LK.ZIPCODE_COUNTY_CODE is q'[numerical codes corresponding to ZIPCODE_COUNTY_DESC field values, possible values are 1 - 19]';
comment on column EROSALEN.ZIPCODE_LK.ZIPCODE_COUNTY_DESC is q'[broad categories to describe where the zip code is located, includes all 5 counties in NYC, 2 counties on Long Island, 7 specific counties in NJ and upstate NY, other NY, other NJ, other US, military, and US territories]';
comment on column EROSALEN.ZIPCODE_LK.ZIPCODE_STATE_CODE is q'[2-letter state/territory/military abbreviation]';
comment on column EROSALEN.ZIPCODE_LK.ZIPCODE_STATE_DESC is q'[full state or territory name]';
comment on column EROSALEN.ZIPCODE_LK.NYC_NEIGHBORHOOD is q'[broad neighborhood categories for all NYC zip codes and 'Not NYC' for all other zipcodes]';
comment on column EROSALEN.ZIPCODE_LK.COUNTRY_CODE is q'[2-letter country abbreviation]';
comment on column EROSALEN.ZIPCODE_LK.COUNTRY_DESC is q'[full name of country, includes non-US military locations]';
comment on column EROSALEN.ZIPCODE_LK.LATITUDE is q'[latitude rounded to 2 digits]';
comment on column EROSALEN.ZIPCODE_LK.LONGITUDE is q'[longitude rounded to 2 digits]';


-------------------------------------------------------------------------------------------------
-- run the following line to view your comments after you've added them.

select * from user_col_comments where table_name = 'ZIPCODE_LK';

