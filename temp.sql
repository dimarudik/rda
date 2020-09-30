col TABLESPACE for a12
select 
	'TEMP' TABLESPACE, 
	(select sum(blocks) from v$tempseg_usage)/(select sum(maxblocks) from dba_temp_files)*100 perc 
from 
	dual;

COL TABLESPACE_SIZE FOR 999,999,999,999,999
COL ALLOCATED_SPACE FOR 999,999,999,999,999
COL FREE_SPACE FOR 999,999,999,999,999
SELECT 
	TABLESPACE_NAME TABLESPACE,
	TABLESPACE_SIZE,
	ALLOCATED_SPACE,
	FREE_SPACE
FROM   dba_temp_free_space;

select 
	(s.tot_used_blocks/f.total_blocks)*100 as "percent used"
from 
	(
		select 
			sum(used_blocks) tot_used_blocks 
		from 
			v$sort_segment 
		where 
			tablespace_name='TEMP'
	) s, 
	(
		select 
			sum(blocks) total_blocks 
		from 
			dba_temp_files where tablespace_name='TEMP'
	) f;
