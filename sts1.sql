col sql_id for a15
col plan_hash_value for 999999999999999999
var sqlset_name varchar2(256);
exec :sqlset_name:= '&1';
select 
	distinct sql_id, plan_hash_value 
from 
	dba_sqlset_plans 
where 
	sqlset_name = upper(:sqlset_name);
