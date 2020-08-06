col sql_id for a16
col SQL_OPNAME for a16
col object_type for a20
col object_name for a30
col tm_delta_time for 999,999,999,999
col tm_delta_cpu_time for 999,999,999,999
col tm_delta_db_time for 999,999,999,999
col delta_time for 999,999,999,999
col time_waited for 999,999,999,999
select * from 
(
	select 
	      --count(*) cnt, 
              --session_id,	
	      --sql_id, 
	      --SQL_OPNAME,
	      o.object_type,
              ash.current_obj# object_id,
	      o.object_name,
              sum(time_waited) time_waited
              --sum(tm_delta_cpu_time) tm_delta_cpu_time,
              --sum(tm_delta_db_time) tm_delta_db_time,
              --sum(delta_time) delta_time
	      --,CURRENT_FILE# filenumber
	      --,CURRENT_BLOCK#
	from  
		v$active_session_history ash , 
	        dba_objects o
	where 
		event like 'latch: cache buffers chains' and
		o.object_id (+) = ash.CURRENT_OBJ#
		and CURRENT_BLOCK# <> 0
	group by
		--session_id, 
		--sql_id, 
	        --SQL_OPNAME, 
	        current_obj#, 
	        --current_file#,
	        --current_block#, 
	        o.object_name,
	        o.object_type
	order by 
		--count(*) desc
		4 desc
)
where rownum < 20
order by time_waited;
