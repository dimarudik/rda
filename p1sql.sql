--col sid for a15
set numwidth 16
--col fblker for a8
col event for a42
col machine for a30
col program for a40
col osuser for a12
col username for a10
col sample_time for a26
var SQL_ID varchar2(256);
exec :SQL_ID:= '&1';
select v.sample_time, v.session_id, v.event, v.p1, v.p2, v.current_obj#, v.sql_id, v.sql_exec_start, v.machine, v.program from v$active_session_history v where v.sql_id = :SQL_ID and sample_time > sysdate - 1/48 order by v.sample_time;
select v.sid, v.serial#, v.event, v.p1raw, v.p1, v.p2, v.final_blocking_session fblker, v.username, v.osuser, v.status, v.machine, v.program, v.sql_id, v.sql_exec_start, v.logon_time from v$session v where sql_id = :SQL_ID;
