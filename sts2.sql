var sqlset_name varchar2(256);
exec :sqlset_name:= '&1';
var sql_id varchar2(256);
exec :sql_id:= '&2';
var phv varchar2(256);
exec :phv:= '&3';
select 
	* 
from 
	table(dbms_xplan.display_sqlset(sqlset_name => :sqlset_name, sql_id => :sql_id, plan_hash_value => :phv));
