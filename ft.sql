set pagesize 0
--set termout off
set heading off
set feed off
set timing off
--set wrap off
set trimspool on
alter session set nls_date_format='dd-MON-yyyy hh24:mi:ss';
var SQL_ID varchar2(256);
var CHILD varchar2(256);
exec :SQL_ID:= '&1';
exec :CHILD:= '&2';
spool /tmp/run.sql
select 'alter session set nls_date_format=''dd-MON-yyyy hh24:mi:ss'';' v from dual;
select distinct v from (select 'var '||substr(name,instr(name,':') + 1)||' '||decode(datatype_string,'DATE','VARCHAR2(20)',datatype_string)||';' v from v$sql_bind_capture where sql_id = :SQL_ID and child_number = :CHILD);
--for SIEBEL
select distinct v from (select 'exec '||name||' := '||nvl(decode(datatype_string,'NUMBER',value_string,''''||decode(datatype_string,'DATE',NULL,value_string)||''''),'NULL')||';' v from v$sql_bind_capture where sql_id = :SQL_ID and child_number = :CHILD);
-- for OTHERS
--select distinct v from (select 'exec '||name||' := '||nvl(decode(datatype_string,'NUMBER',value_string,''''||decode(datatype_string,'DATE',to_date(value_string,'mm/dd/yyyy hh24:mi:ss'),value_string)||''''),'NULL')||';' v from v$sql_bind_capture where sql_id = :SQL_ID and child_number = :CHILD);
set line 3000
set long 300000
set longchunksize 5000
select sql_fulltext||';' from v$sql where sql_id = :SQL_ID and child_number = :CHILD;
spool off
