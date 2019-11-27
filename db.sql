col OPEN_RESETLOGS format a15
col NAME format a15
col LOG_MODE format a15
col OPEN_MODE format a25
col DATABASE_ROLE format a16
col FLASHBACK_ON format a15
col FORCE_LOGGING format a15
col supplemental_log_data_all for a25
col supplemental_log_data_min for a25
col supplemental_log_data_pk for a25
col supplemental_log_data_ui for a25
col supplemental_log_data_fk for a25
col supplemental_log_data_pl for a25
select 
	DBID, 
	NAME, 
	LOG_MODE, 
	OPEN_RESETLOGS, 
	OPEN_MODE, 
	DATABASE_ROLE, 
	FLASHBACK_ON, 
	FORCE_LOGGING, 
	supplemental_log_data_all,
	supplemental_log_data_min, 
	supplemental_log_data_pk, 
	supplemental_log_data_ui,
	supplemental_log_data_fk,
	supplemental_log_data_pl,
	PROTECTION_MODE 
from 
	v$database;
