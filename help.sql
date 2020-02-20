set line window
select 
	name as "Name", 
	usage as "Usage",
	description as "Description"
from
(
			select 'aud.sql'	as name , '@aud.sql'			as usage, 'Shows last 100 audit records'								as description from dual
        union all	select 'az.sql'		as name , '@az.sql :sql_id'		as usage, 'Shows execs, disk reads, buffer gets from dba_hist_snapshot, dba_hist_sqlstat'		as description from dual
        union all       select 'bh1.sql'        as name , '@bh1.sql -1 | :object_id'    as usage, 'Shows percent of blocks in buffer cache by objects'                                          as description from dual
        union all       select 'bh2.sql'        as name , '@bh2.sql -1 | :object_id'    as usage, 'Shows total of blocks in buffer cache by objects and by types of buffer cache area'          as description from dual
);
