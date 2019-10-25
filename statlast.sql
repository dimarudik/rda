col target for a60
col target_type for a20
col objn for 9999999
col tsize for 9999999999
col start_time for a38
col end_time for a38
col job_name for a10
col status for a10
col notes for a130
var target varchar2(256);
exec :target:= '&1';
select
	OPID
	,TARGET
	,TARGET_OBJN objn
	,TARGET_TYPE
	,TARGET_SIZE tsize
	,START_TIME
	,END_TIME
	,STATUS
	--,JOB_NAME
	--,ESTIMATED_COST
	--,BATCHING_COEFF
	--,ACTIONS
	,PRIORITY
	--,FLAGS
	,NOTES
from 
	DBA_OPTSTAT_OPERATION_TASKS 
where 
	START_TIME > sysdate - 1 and
	target not like '%SYS%.%' and
	upper(target) like upper(decode(:target,'-1',target,:target))
order by
	start_time;
select dbms_stats.get_prefs('DEGREE') from dual;
