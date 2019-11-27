select 
	sql_id, sql_exec_id, count(1) 
from 
	v$active_session_history 
where 
	event in ('direct path read','direct path read temp','direct path write','direct path write temp') and
	sql_opname <> 'INSERT'
group by sql_id, sql_exec_id order by 3;
