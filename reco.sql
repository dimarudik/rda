/*
revoke restricted session from dba;
revoke restricted session from strmadmin;
alter system enable restricted session;

alter system disable restricted session;
grant restricted session to dba;
grant restricted session to strmadmin;
*/
select 'exec dbms_transaction.purge_lost_db_entry('''||local_tran_id||'''); commit;'  from dba_2pc_pending;
select 'rollback force '''||local_tran_id||''';'  from dba_2pc_pending;
