col VALUE_STRING for a50
col sql_id for a20
col name for a12
col DATATYPE_STRING for a40
var SQL_ID varchar2(256);
exec :SQL_ID:= '&1';
select SQL_ID,CHILD_NUMBER,NAME,POSITION,DUP_POSITION,DATATYPE,DATATYPE_STRING,CHARACTER_SID,PRECISION,SCALE,MAX_LENGTH,WAS_CAPTURED,LAST_CAPTURED,VALUE_STRING from v$sql_bind_capture where sql_id = :SQL_ID;
