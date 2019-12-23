var name varchar2(256);
exec :name := '&1';
set heading off
set timing off
set feedback off
set line 180
set pagesize 5000
col stmt for a200
spool /opt/oracle/rda/$ORACLE_SID.rman
select 'spool log to /opt/oracle/rda/'||:name||'.log;' stmt from dual union all
select 'run {' from dual union all
select 'allocate channel ch01 type disk;' from dual union all
select 'allocate channel ch02 type disk;' from dual union all
select 'allocate channel ch03 type disk;' from dual union all
select 'allocate channel ch04 type disk;' from dual union all
select 'allocate channel ch05 type disk;' from dual union all
select 'allocate channel ch06 type disk;' from dual union all
select 'allocate channel ch07 type disk;' from dual union all
select 'allocate channel ch08 type disk;' from dual union all
select 'allocate channel ch09 type disk;' from dual union all
select 'allocate channel ch10 type disk;' from dual union all
select 'allocate channel ch11 type disk;' from dual union all
select 'allocate channel ch12 type disk;' from dual union all
select 'allocate channel ch13 type disk;' from dual union all
select 'allocate channel ch14 type disk;' from dual union all
select 'allocate channel ch15 type disk;' from dual union all
select 'allocate channel ch16 type disk;' from dual union all
select 'allocate channel ch17 type disk;' from dual union all
select 'allocate channel ch18 type disk;' from dual union all
select 'allocate channel ch19 type disk;' from dual union all
select 'allocate channel ch20 type disk;' from dual union all
select 'allocate channel ch21 type disk;' from dual union all
select 'allocate channel ch22 type disk;' from dual union all
select 'allocate channel ch23 type disk;' from dual union all
select 'allocate channel ch24 type disk;' from dual union all
select 'allocate channel ch25 type disk;' from dual union all
select 'allocate channel ch26 type disk;' from dual union all
select 'allocate channel ch27 type disk;' from dual union all
select 'allocate channel ch28 type disk;' from dual union all
select 'allocate channel ch29 type disk;' from dual union all
select 'allocate channel ch30 type disk;' from dual union all
select 'allocate auxiliary channel ch105 type disk;' from dual union all
select 'allocate auxiliary channel ch106 type disk;' from dual union all
select 'allocate auxiliary channel ch107 type disk;' from dual union all
select 'allocate auxiliary channel ch108 type disk;' from dual union all
--select 'set newname for datafile '||file#||' to ''/oramnt/'||:name||'_prod_di0'||(Trunc(file#/300)+1)||substr(name,instr(name,'/',1,4))||''';' from v$datafile union all
select 'duplicate target database for standby from active database spfile' from dual union all
select 'set "db_unique_name"="'||:name||'_S"' from dual union all
select 'set "control_files"=''/oramnt/'||:name||'/'||:name||'_prod_redo/control01.ctl'',''/oramnt/'||:name||'/'||:name||'_prod_redo/control02.ctl'',''/oramnt/'||:name||'/'||:name||'_prod_redo/control03.ctl''' from dual union all
select 'set "db_recovery_file_dest"=''/oramnt/'||:name||'/'||:name||'_prod_redo/fra''' from dual union all
select 'set "db_file_name_convert"=''/oramnt'',''/oramnt/'||:name||'''' from dual union all
select 'reset "db_file_name_convert"' from dual union all
select 'reset "local_listener"' from dual union all
select 'reset "service_names"' from dual union all
select 'set "log_file_name_convert"=''/oramnt'',''/oramnt/'||:name||'''' from dual union all
select 'set "dg_broker_start"="false"' from dual union all
select 'reset "db_flash_cache_file"' from dual union all
select 'set "db_flash_cache_size"="0"' from dual union all
select 'set "log_archive_config"=""' from dual union all
select 'set "log_archive_dest_2"=""' from dual union all
select 'set "sga_target"="0"' from dual union all
select 'set "streams_pool_size"="1G"' from dual union all
select 'set "result_cache_max_size"="0"' from dual union all
select 'set "java_pool_size"="1G"' from dual union all
select 'set "shared_pool_size"="4G"' from dual union all
select 'set "db_cache_size"="10G"' from dual union all
--select 'set "large_pool_size"="20G"' from dual union all
select 'set "sga_max_size"="20G"' from dual union all
select 'set "audit_file_dest"="/opt/oracle/admin/'||:name||'/adump"' from dual union all
select 'set "pga_aggregate_target"="2G"' from dual union all
select 'set "processes"="220"' from dual union all
select 'set "diagnostic_dest"="/oramnt/'||:name||'/base"' from dual union all
select 'set "fal_server"="'||:name||'_N_ARCH"' from dual union all
select 'nofilenamecheck;' from dual union all
select '}' from dual;
spool off
