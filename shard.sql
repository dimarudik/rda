col table_name for a50
set numwith 20
var OWNER varchar2(256);
exec :OWNER := '&1';
select t.table_name, t.last_analyzed, sum(t.num_rows) num_rows, sum(inserts) inserts, sum(updates) updates, sum(deletes) deletes 
	from 
		dba_tab_modifications m, dba_tables t 
	where 
		m.table_owner = upper(:OWNER) and 
t.owner = upper(:OWNER) and t.owner = m.table_owner and t.table_name (+) = m.table_name group by t.table_name, t.last_analyzed order by sum(t.num_rows);
