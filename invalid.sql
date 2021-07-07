col owner for a20
col object_name for a30
col subobject_name for a30
col object_type for a30
col timestamp for a30
select OWNER,OBJECT_NAME,SUBOBJECT_NAME,OBJECT_ID,DATA_OBJECT_ID,OBJECT_TYPE,CREATED,LAST_DDL_TIME,TIMESTAMP,TEMPORARY from dba_objects where status <> 'VALID' order by owner, object_name;
