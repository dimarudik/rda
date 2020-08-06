col sql_id for a15
col plan_hash_value for 999999999999999999
var sqlset_name varchar2(256);
exec :sqlset_name:= '&1';
var sql_id varchar2(256);
exec :sql_id:= '&2';
select 
	distinct sql_id, plan_hash_value 
from 
	dba_sqlset_plans 
where 
	sqlset_name = upper(:sqlset_name) and
        sql_id = decode(:sql_id,'-1',sql_id,:sql_id);
