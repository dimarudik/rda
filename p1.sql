--col sid for a15
set numwidth 16
--col fblker for a8
col event for a42
col machine for a40
col program for a40
col osuser for a12
col username for a10
col sid for 999999
col serial# for 999999
col FBLKER for 999999
col status for a12
var s number;
exec :s := &1;
select v.sid, v.serial#, v.event, v.p1raw, v.p1, v.p2, v.final_blocking_session fblker, v.username, v.osuser, v.status, v.machine, v.program, v.sql_id, v.sql_exec_start, v.logon_time, v.last_call_et
from 
	v$session v 
where 
	sid = decode(:s,-1,sid,:s)
	&2;
