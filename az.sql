-- ONLINE4 inserts: d5smkxyf2nrgc bwvvpgjnkgmxy
col Date for a20
col "Name of day" for a10
col BUFFER_GETS for 99,999,999,999
col DISK_READS for 99,999,999,999
var SQL_ID varchar2(256);
exec :SQL_ID:= '&1';
select 
	trunc(sn.begin_interval_time) "Date", 
	to_char(sn.begin_interval_time,'DAY') "Name of day", 
	round(SUM(st.elapsed_time_delta/1000000) / SUM(st.executions_delta),4) elapsed_avg, 
	SUM(st.executions_delta) execs, 
	SUM(st.disk_reads_delta) disk_reads, 
	SUM(st.buffer_gets_delta) buffer_gets, 
	count(1) snapshots_cnt 
from 
	dba_hist_snapshot sn, 
	dba_hist_sqlstat st 
where 
	st.sql_id = :SQL_ID and 
	sn.snap_id = st.snap_id and 
	trunc(sn.begin_interval_time,'dd') > sysdate - 30 
group by 
	trunc(sn.begin_interval_time), 
	to_char(sn.begin_interval_time,'DAY') 
order by 1 desc;
/*
select
        trunc(sn.begin_interval_time) "Date",
        to_char(sn.begin_interval_time,'DAY') "Name of day",
        round(SUM(st.elapsed_time_delta/1000000) / SUM(st.executions_delta),4) elapsed_avg,
        SUM(st.executions_delta) execs,
        SUM(st.disk_reads_delta) disk_reads,
        SUM(st.buffer_gets_delta) buffer_gets,
        count(1) snapshots_cnt
from
        dba_hist_snapshot sn,
        dba_hist_sqlstat st
where
        st.sql_id in ('d5smkxyf2nrgc','bwvvpgjnkgmxy') and
        sn.snap_id = st.snap_id and
        sn.dbid = 878161549 and
        st.dbid = 878161549
group by
        trunc(sn.begin_interval_time),
        to_char(sn.begin_interval_time,'DAY')
order by 1 desc;
*/
