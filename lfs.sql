col object_name for a40
col tm_delta_time for 999,999,999,999,999.99
col tm_delta_cpu_time for 999,999,999,999,999.99
col tm_delta_db_time for 999,999,999,999,999.99
select 
	current_obj#, 
	(select owner||'.'||object_name object_name from dba_objects o where a.current_obj# = o.object_id) object_name,
	sample_count, 
	tm_delta_time,
	tm_delta_cpu_time,
	tm_delta_db_time 
from 
(
	select 
		current_obj#, 
		count(1) sample_count, 
		sum(tm_delta_time) tm_delta_time,
                sum(tm_delta_cpu_time) tm_delta_cpu_time,
                sum(tm_delta_db_time) tm_delta_db_time
	from 
		v$active_session_history 
	where 
		event = 'log file sync' 
	group by 
		current_obj# order by 3 desc
) a
where
	rownum < 20 
order by tm_delta_time;
