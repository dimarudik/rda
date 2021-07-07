--col sid for a15
set numwidth 16
col sessid for 99999
col event for a42
col machine for a29
col program for a27
col osuser for a8
col username for a8
col sample_time for a26
col obj for 99999999
col objname for a29
col subobname for a10
col sql_id for a13
col "Temp Gb" for 99999
col status for a10
var SQL_ID varchar2(256);
col sql_exec_start for a20
col logon_time for a20
exec :SQL_ID:= '&1';
select 
	v.sample_time, 
	v.session_id sessid, 
	v.event, 
	v.p1, 
	v.p2, 
	--v.current_obj#, 
	--v.sql_id, 
	v.sql_exec_start, 
	v.machine, 
	v.program, 
	v.current_obj# obj,
	o.object_name objname,
	o.subobject_name subobname,
	round(v.temp_space_allocated/1024/1024/1024) "Temp Gb"
from 
	v$active_session_history v 
	,dba_objects o
where 
	v.sql_id = :SQL_ID and 
	v.current_obj# = o.data_object_id and
        --v.sql_exec_id = (select max(vv.sql_exec_id) from v$active_session_history vv where vv.sql_id = :SQL_ID) and
	sample_time > sysdate - 1/96 
order by 
	v.sample_time;
select 
	v.sid, 
	v.serial#, 
	v.event, 
	v.p1raw, 
	v.p1, 
	v.p2, 
	v.final_blocking_session fblker, 
	v.username, 
	v.osuser, 
	v.status, 
	v.machine, 
	v.program, 
	v.sql_exec_start, 
	v.logon_time 
from 
	v$session v 
where 
	sql_id = :SQL_ID;
