------------------------------------
--Cheryl Littman
--2023-01-03
------------------------------------

--get table comments
--filters on table name and/or owner

select
'BIRD' AS ENVIRONMENT,
tc.*
from 
all_tab_comments tc
where 
tc.table_name NOT LIKE 'BIN%' AND 
tc.owner like '%BIRD_%'
order by tc.owner, tc.table_name
;


--get column comments
--filters on table name and/or owner

select
'BIRD' AS ENVIRONMENT,
cc.*
from 
all_col_comments cc
where 
cc.table_name NOT LIKE 'BIN%' AND 
cc.owner like '%BIRD_%'
order by cc.owner, cc.table_name, cc.column_name
;
