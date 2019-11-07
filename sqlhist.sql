var SQL_ID varchar2(256);
exec :SQL_ID:= '&1';
select 
	trunc(sample_time,'DD'),
	sql_plan_hash_value,
	count(sql_exec_id) 
from 
	dba_hist_active_sess_history 
where 
	sql_id = :SQL_ID
group by
	trunc(sample_time,'DD'),
	sql_plan_hash_value
order by 
	trunc(sample_time,'DD'),
	count(sql_exec_id);
