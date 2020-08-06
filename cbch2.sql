col sql_id for a16
col SQL_OPNAME for a16
col object_type for a20
col object_name for a30
col time_waited for 999,999,999,999
var OBJ_ID varchar2(256);
var s number;
exec :s := &1;
select * from 
(
	select
              sql_id,	
	      CURRENT_BLOCK#,
              sum(time_waited) time_waited
              --sum(tm_delta_cpu_time) tm_delta_cpu_time,
	      --sum(tm_delta_db_time) tm_delta_db_time,
              --sum(delta_time) delta_time
	from  
		v$active_session_history ash , 
	        dba_objects o
	where 
		event like 'latch: cache buffers chains' and
		o.object_id = ash.CURRENT_OBJ#
		and CURRENT_BLOCK# <> 0
		and ash.current_obj# = decode(:s,-1,ash.current_obj#,:s)
	group by
                sql_id,
	        current_block# 
	order by 3 desc
)
where rownum < 20
order by time_waited;
