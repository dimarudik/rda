col plan_hash_v for 9999999999
col hash_value for 9999999999
col sql_id for a14
col is_off for a8
col load for 9999
col AVGROWS for 99999
col CHILD for 9999
col EXECS for 99,999,999,999
col buffer_gets for 99999999
col avgdiskreads for 999,999,999.99
col avgbuffergets for 999,999,999.99
col PARSE_CALLS for 9,999,999,999
col ELAPSED_AVG for 9,999.999999
col LAST_ACTIVE_TIME for a20
col EXACT_MATCH_SIGNATURE for 999999999999999999999
col uname for a11
col pars_schema for a11
select 
	sql_id, 
	--hash_value, 
	plan_hash_value plan_hash_v, 
	child_number child, 
	executions execs, 
        parse_calls,
	round(rows_processed/decode(executions,0,1,executions),2) as avgrows, 
	round(disk_reads/decode(executions,0,1,executions),6) as avgdiskreads, 
	round(buffer_gets/decode(executions,0,1,executions),6) as avgbuffergets, 
	loads load, 
	is_bind_sensitive bind_sensit, 
	--is_bind_aware bind_aware, 
	--decode(IO_CELL_OFFLOAD_ELIGIBLE_BYTES,0,'No','Yes') is_off, 
	round((elapsed_time/decode(executions,0,1,executions))/1000000,7) elapsed_avg, 
	last_active_time, 
        u.name uname,
	--exact_matching_signature exact_match_signature, 
        parsing_schema_name pars_schema,
	sql_text sqltext
	--substr(sql_text,1,350) as sqltext 
  from 
	v$sql v,
        user$ u
  where 
        v.parsing_user_id = u.user# and
	upper(sql_text) like upper('&1')
  order by last_active_time;
