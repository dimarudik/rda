set line 180 timing off
set pagesize 10000
set long 300000
set longchunksize 30000
var OWNER varchar2(256);
exec :OWNER := UPPER('&1');
select dbms_metadata.get_ddl ('USER', upper(:OWNER))||' ;' as ddl from dba_users WHERE username = upper(:OWNER) union all
select dbms_metadata.get_ddl ('PROFILE', (select profile from dba_users where username = upper(:OWNER)))||' ;' from dba_users WHERE username = upper(:OWNER) union all
select to_clob('  GRANT '||privilege||' TO '||grantee||' ;') from dba_sys_privs where grantee = upper(:OWNER) union all
select to_clob(chr(10)) from dual union all
select to_clob('  GRANT '||granted_role||' TO '||grantee||' ;') from dba_role_privs where grantee = upper(:OWNER) union all
select to_clob(chr(10)) from dual union all
select to_clob('  GRANT '||privilege||' ON '||owner||'.'||table_name||' TO '||grantee||' ;') from dba_tab_privs where grantee = upper(:OWNER);

