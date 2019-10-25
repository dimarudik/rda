col OPEN_RESETLOGS format a15
col NAME format a15
col LOG_MODE format a15
col OPEN_MODE format a25
col DATABASE_ROLE format a16
col FLASHBACK_ON format a15
col FORCE_LOGGING format a15
select DBID, NAME, LOG_MODE, OPEN_RESETLOGS, OPEN_MODE, DATABASE_ROLE, FLASHBACK_ON, FORCE_LOGGING, supplemental_log_data_min as supp_log,PROTECTION_MODE from v$database;
