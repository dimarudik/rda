set line window
alter session set nls_date_format='dd-Mon-yyyy hh24:mi:ss';
spool /tmp/.login.sql
show line
spool off
host cat /tmp/.login.sql | awk '{if ($2 >= 210) print "col sqltext for a80"; else print "col sqltext for a32"}' > /tmp/.login2.sql
@/tmp/.login2.sql
set termout off
col db_name new_value db_name
select value db_name from v$parameter where upper(name) = 'DB_UNIQUE_NAME';
set termout on
set sqlprompt "_user'@'&db_name>"
set time on timing on
set tab off
