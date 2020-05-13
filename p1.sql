--col sid for a15
set numwidth 16
--col fblker for a8
col event for a42
col machine for a24
col program for a40
col osuser for a12
col username for a10
col sid for 999999
col serial# for 999999
col FBLKER for 999999
col status for a12
col sql_id for a13
col sql_exec_start for a20
col LOGON_TIME for a20
col blking_sid for 9999999999
col fnl_blking_sid for 9999999999
var s number;
exec :s := &1;
select v.sid, v.serial#, v.blocking_session blking_sid, v.final_blocking_session fnl_blking_sid, v.event, v.p1raw, v.p1, v.p2, v.final_blocking_session fblker, v.username, v.osuser, v.status, v.machine, v.program, v.sql_id, v.sql_exec_start, v.logon_time, v.last_call_et
from 
	v$session v 
where 
	sid = decode(:s,-1,sid,:s)
	&2;
