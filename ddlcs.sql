--set line 180 timing off
set pagesize 10000
set long 300000
set longchunksize 30000
var OWNER varchar2(256);
var ONAME varchar2(256);
exec :OWNER := upper(SUBSTR('&1',1,INSTR('&1','.')-1));
exec :ONAME := SUBSTR('&1',INSTR('&1','.')+1);
select dbms_metadata.get_ddl (
  decode(object_type,
    'DATABASE LINK',      'DB_LINK',
    'JOB',                'PROCOBJ',
    'RULE SET',           'PROCOBJ',
    'RULE',               'PROCOBJ',
    'EVALUATION CONTEXT', 'PROCOBJ',
    'PACKAGE',            'PACKAGE_SPEC',
    'PACKAGE BODY',       'PACKAGE_BODY',
    'TYPE',               'TYPE_SPEC',
    'TYPE BODY',          'TYPE_BODY',
    'MATERIALIZED VIEW',  'MATERIALIZED_VIEW',
    'QUEUE',              'AQ_QUEUE',
    'JAVA CLASS',         'JAVA_CLASS',
    'JAVA TYPE',          'JAVA_TYPE',
    'JAVA SOURCE',        'JAVA_SOURCE',
    'JAVA RESOURCE',      'JAVA_RESOURCE',
    object_type
),
:ONAME, upper(:OWNER))||decode(object_type,'TABLE',';',null) as ddl from dba_objects WHERE OWNER = upper(:OWNER) and object_name = :ONAME and object_type not in ('TABLE SUBPARTITION','TABLE PARTITION','INDEX PARTITION');
