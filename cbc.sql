col "Object name" for a30
col "OBJ name" for a30
col "Count" for 999999999999
col "Time waited" for 999999999999
select 
	p.object_name "Object name", 
	o.object_name "OBJ name",
	count(1) "Count", 
	sum(time_waited) "Time waited"
from 
	v$active_session_history r, v$sql_plan p
	, dba_objects o
where 
	r.sample_time > sysdate - 1/24
	and r.event = 'latch: cache buffers chains'
	and r.sql_id = p.sql_id
	and r.SQL_PLAN_HASH_VALUE = p.PLAN_HASH_VALUE
	and r.SQL_PLAN_LINE_ID = p.ID
	and o.object_id (+) = r.current_obj#
group by 
	p.object_name
	, o.object_name
order by count(1);
select
        p.object_name "Object name",
        count(1) "Count",
        sum(time_waited) "Time waited"
from
        v$active_session_history r, v$sql_plan p
where
        --r.sample_time between to_date('15.03.2021 20:27:00','dd.mm.yyyy hh24:mi:ss') and to_date('15.03.2021 20:29:00','dd.mm.yyyy hh24:mi:ss')
        r.sample_time > sysdate - 1/24
        and r.event = 'latch: cache buffers chains'
        and r.sql_id = p.sql_id
        and r.SQL_PLAN_HASH_VALUE = p.PLAN_HASH_VALUE
        and r.SQL_PLAN_LINE_ID = p.ID
group by
        p.object_name
order by count(1);
