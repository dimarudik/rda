col opname for a40
col target for a40
col target_desc for a40
col sid for 999999
col serial# for 999999
col sofar for 99,999,999 
col totalwork for 99,999,999
col TIME_REMAINING for 999,999
col ELAPSED_SECONDS for 999,999
var s number;
exec :s := &1;
select 
	sid, serial#, opname, target, target_desc, sofar, totalwork, start_time, time_remaining, elapsed_seconds from v$session_longops 
where 
	sid in (select decode(:s,-1,sid,:s) from dual 
		union all 
		select px.sid from gv$px_session px where px.QCSID = decode(:s,-1,px.sid,:s) and px.sid <> decode(:s,-1,px.sid,:s)) 
order by start_time;
