--set line window
col "Usage" for a50
col "Description" for a120
select 
	usage as "Usage",
	description as "Description"
from
(
			select '@aud'					as usage, 'Shows last 100 audit records'								as description from dual
        union all	select '@az         :sql_id'			as usage, 'Shows execs, disk reads, buffer gets by days'						as description from dual
        union all       select '@azh        :sql_id'            	as usage, 'Shows execs, disk reads, buffer gets by hours'                                               as description from dual
        union all       select '@bh1        -1 | :object_id'    	as usage, 'Shows percent of blocks in buffer cache by objects'                                          as description from dual
        union all       select '@bh2        -1 | :object_id'    	as usage, 'Shows total of blocks in buffer cache by objects and by types of buffer cache area'          as description from dual
        union all       select '@directs'      		       		as usage, 'Shows most producers of direct reads' 	                                                as description from dual
);
