col OPEN_RESETLOGS format a15
col NAME format a10
col LOG_MODE format a15
col OPEN_MODE format a25
col DATABASE_ROLE format a14
col FB_ON format a6
col FORCELOG format a8
col suppl_log_data_all for a18
col suppl_log_data_min for a19
col suppl_log_data_pk for a17
col suppl_log_data_ui for a17
col suppl_log_data_fk for a17
col suppl_log_data_pl for a17
col PROTECTION_MODE for a20
select 
	DBID, 
	NAME, 
	LOG_MODE, 
	OPEN_RESETLOGS, 
	OPEN_MODE, 
	DATABASE_ROLE, 
	FLASHBACK_ON FB_ON, 
	FORCE_LOGGING FORCELOG, 
	supplemental_log_data_all suppl_log_data_all,
	supplemental_log_data_min suppl_log_data_min, 
	supplemental_log_data_pk suppl_log_data_pk, 
	supplemental_log_data_ui suppl_log_data_ui,
	supplemental_log_data_fk suppl_log_data_fk,
	supplemental_log_data_pl suppl_log_data_pl,
	PROTECTION_MODE 
from 
	v$database;
