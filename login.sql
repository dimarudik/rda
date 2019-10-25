--set sqlprompt "_user'@'> "
set termout off
col db_name new_value db_name
select value db_name from v$parameter where upper(name) = 'DB_UNIQUE_NAME';
--select name db_name from v$database;
--SET SQLPROMPT "&db_name >"
set termout on
set sqlprompt "_user'@'&db_name>"
--SET SQLPROMPT '_CONNECT_IDENTIFIER > '
set time on timing on line window
--set time on timing on line 360
alter session set nls_date_format='dd-Mon-yyyy hh24:mi:ss';
