col pool for a16
col name for a34
col mbytes for 99,999,999
select
	pool,
	name,
	round(bytes/1024/1024) as mbytes
from
	v$sgastat 
order by 
	pool,
	bytes desc,
	name;
