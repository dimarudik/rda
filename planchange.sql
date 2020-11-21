col sql_id for a13
col action for a40
select 
	sql_id,
	count(PLAN_HASH_VALUE) "PHV Count",
	action
from
(
	SELECT 
	    distinct 
	    STAT.SQL_ID, 
	    ACTION, 
	    --executions_total, 
	    PLAN_HASH_VALUE
	FROM 
	    DBA_HIST_SQLSTAT STAT, 
	    DBA_HIST_SNAPSHOT SS
	WHERE
	    SS.DBID = STAT.DBID AND
	    SS.INSTANCE_NUMBER = STAT.INSTANCE_NUMBER AND
	    STAT.SNAP_ID = SS.SNAP_ID AND
	    SS.BEGIN_INTERVAL_TIME >= sysdate - 1/24 and ss.END_INTERVAL_TIME <= sysdate
	    and PLAN_HASH_VALUE <> 0
)
group by 
    sql_id, action
having 
    count(plan_hash_value) > 1
order by "PHV Count"; 
