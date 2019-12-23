select
	sql_id,
	count(sql_plan_hash_value)
from
(
	select
		distinct
		sql_id,
		sql_plan_hash_value
	from
		v$active_session_history
	where
		sql_plan_hash_value <> 0 and
		sql_opname <> 'INSERT'
)
group by
	sql_id
having
	count(sql_plan_hash_value) > 1
;
