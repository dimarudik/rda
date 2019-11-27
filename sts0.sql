col name for a26
col owner for a16
col created for a20
col statement_count for 99999999999
col description for a50 
select
	name, 
	owner, 
	created, 
	statement_count,
	description
from 
	dba_sqlset 
order by 
	created;
