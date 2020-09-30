-- ONLINE4 inserts: d5smkxyf2nrgc bwvvpgjnkgmxy
col Date for a20
col "Name of day" for a11
col "Elapsed Avg" for 999.999999
col "BufferGets" for 99,999,999,999
col "DiskReads" for 99,999,999,999
col "BufferGets Avg" for 999,999,999.999
col "DiskReads Avg" for 999.999
var SQL_ID varchar2(256);
exec :SQL_ID:= '&1';
select 
        st.plan_hash_value,
	trunc(sn.begin_interval_time,'HH24') "Date", 
        SUM(st.executions_delta) "Executions",
        round(SUM(st.elapsed_time_delta/1000000) / SUM(st.executions_delta),6) "Elapsed Avg",
        round(SUM(st.buffer_gets_delta) / SUM(st.executions_delta),3) "BufferGets Avg",
        round(SUM(st.disk_reads_delta) / SUM(st.executions_delta),3) "DiskReads Avg",
	SUM(st.disk_reads_delta) "DiskReads", 
	SUM(st.buffer_gets_delta) "BufferGets", 
	count(1) "Snapshots"
from 
	dba_hist_snapshot sn, 
	dba_hist_sqlstat st 
where 
	st.sql_id = :SQL_ID and 
	sn.snap_id = st.snap_id and 
        st.executions_delta <> 0 and
	trunc(sn.begin_interval_time,'dd') > sysdate - 6
group by 
	trunc(sn.begin_interval_time,'HH24'), 
        st.plan_hash_value
order by trunc(sn.begin_interval_time,'HH24') desc;
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
