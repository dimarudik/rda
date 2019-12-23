col sql_id for a16
col SQL_OPNAME for a16
col object_type for a20
col object_name for a30
select * from 
(
	select 
	      count(*) cnt, 
              --session_id,	
	      --sql_id, 
	      --SQL_OPNAME,
	      o.object_type,
              ash.current_obj# object_id,
	      o.object_name,
	      CURRENT_FILE# filenumber,
	      CURRENT_BLOCK#
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
	        current_file#,
	        current_block#, 
	        o.object_name,
	        o.object_type
	order by count(*) desc
)
where rownum < 100
order by cnt;
