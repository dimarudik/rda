var SQL_ID varchar2(256);
exec :SQL_ID:= '&1';
select 'alter system kill session '''||sid||','||serial#||''' immediate;' as stmt from v$session where sql_id = :SQL_ID;
