col opname for a32
col target for a30
col target_desc for a30
col sid for 999999
col serial# for 999999
col sofar for 99,999,999,999 
col totalwork for 99,999,999,999
col TIME_REMAIN for 999,999
col ELAPSED_SECONDS for 999,999
var s number;
exec :s := &1;
select 
	lo.sid, lo.serial#, lo.opname, lo.target, lo.target_desc, lo.sofar, lo.totalwork, lo.start_time, lo.time_remaining time_remain, lo.elapsed_seconds from v$session_longops lo, v$session v
where 
	lo.sid in (select decode(:s,-1,lo.sid,:s) from dual 
		union all 
		select px.sid from gv$px_session px where px.QCSID = decode(:s,-1,px.sid,:s) and px.sid <> decode(:s,-1,px.sid,:s)) 
  	and lo.sid= lo.sid
	and v.serial# = lo.serial#
order by start_time;
