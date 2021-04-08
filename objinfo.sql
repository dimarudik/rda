col owner for a20
col object_name for a60
col subobject_name for a30
col object_type for a20
var ONAME varchar2(256);
exec :ONAME:= '&1';
select
	owner||'.'|| object_name object_name,
	subobject_name,
	object_id,
	data_object_id,
	object_type,
	created,
	last_ddl_time,
	status
from
	dba_objects
where
	object_name like upper(:ONAME);
