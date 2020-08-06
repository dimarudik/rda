--col sid for a15
set numwidth 16
--col fblker for a8
col event for a38
col machine for a28
col program for a24
col osuser for a8
col username for a8
col sid for 999999
col serial# for 999999
col FBLKER for 999999
col status for a8
col sql_id for a13
col sql_exec_start for a20
col LOGON_TIME for a20
col blk_sid for 9999999
col fblk_sid for 9999999
col lc_et for 99999
var s number;
exec :s := &1;
select 
	v.sid, 
	v.serial#, 
	v.blocking_session blk_sid, 
	v.final_blocking_session fblk_sid, 
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
	v.sql_id, 
	--v.sql_exec_start, 
	v.logon_time, 
	v.last_call_et lc_et
from 
	v$session v 
where 
	sid = decode(:s,-1,sid,:s)
	&2;
