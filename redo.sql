set numwidth 15
col member for a80
col con_id noprint
col members noprint
col dbid noprint
col status for a10
select group#, member from v$logfile;
select * from v$log order by sequence#, first_time;
select * from v$standby_log;
