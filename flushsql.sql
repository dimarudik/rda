var SQL_ID varchar2(256);
--var CHILD varchar2(256);
exec :SQL_ID:= '&1';
--exec :CHILD:= '&2';
--col ADDRESS new_value ADDRESS
--col HASH_VALUE new_value HASH_VALUE
--select ADDRESS, HASH_VALUE from V$SQLAREA where SQL_ID = :SQL_ID;
begin
	for j in (select ADDRESS a, HASH_VALUE h from V$SQLAREA where SQL_ID = :SQL_ID)
	loop
		for i in 1..50 
		loop
			DBMS_SHARED_POOL.PURGE (j.a||', '||j.h, 'C');
		end loop;
	end loop;
end;
/
