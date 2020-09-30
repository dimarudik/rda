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
col parses for 9,999,999,999
col "Execs-Pars" for 9,999,999,999
col ELAPSED_AVG for 9,999.999999
col LAST_ACTIVE_TIME for a20
col EXACT_MATCH_SIGNATURE for 999999999999999999999
col uname for a11
col pars_schema for a11
var uname varchar2(256);
exec :uname:= '&1';
var parsing_schema_name varchar2(256);
exec :parsing_schema_name:= '&2';
select * from (
select
        sql_id,
        --hash_value,
        plan_hash_value plan_hash_v,
        child_number child,
        executions execs,
        parse_calls parses,
        executions-parse_calls as "Execs-Pars",
        round(rows_processed/decode(executions,0,1,executions),2) as avgrows,
        --round(disk_reads/decode(executions,0,1,executions),6) as avgdiskreads,
        round(buffer_gets/decode(executions,0,1,executions),6) as avgbuffergets,
        --loads load,
        is_bind_sensitive bind_sensit,
        --is_bind_aware bind_aware,
        --decode(IO_CELL_OFFLOAD_ELIGIBLE_BYTES,0,'No','Yes') is_off,
        round((elapsed_time/decode(executions,0,1,executions))/1000000,7) elapsed_avg,
        last_active_time,
        u.name uname,
        parsing_schema_name pars_schema,
	sql_text sqltext
        --substr(sql_text,1,450) as sqltext
  from
        v$sql v,
        user$ u
  where
	v.parsing_user_id = u.user# and
        executions > 0 and 
	parsing_schema_name not in ('SYS','SYSTEM','DBSNMP') and
        upper(sql_text) like 'SELECT%' and
	parsing_schema_name = upper(decode(:parsing_schema_name,'-1',parsing_schema_name,:parsing_schema_name)) and
        u.name = upper(decode(:uname,'-1',u.name,:uname))
  order by
        parse_calls desc
        --executions-parse_calls
) where rownum <= 30
  order by parses;