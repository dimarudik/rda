col error_number for a10
col error_message for a70
select sql_id, SQL_EXEC_START, ERROR_NUMBER, ERROR_MESSAGE from v$sql_monitor where ERROR_NUMBER is not null order by SQL_EXEC_START;
