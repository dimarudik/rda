SET PAGESIZE 5000
var SQL_ID varchar2(256);
var CHILD varchar2(256);
exec :SQL_ID:= '&1';
exec :CHILD:= '&2';
select * from table (dbms_xplan.display_cursor(:SQL_ID,:CHILD,'TYPICAL ADVANCED PEEKED_BINDS'));
