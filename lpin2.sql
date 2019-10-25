var P1RAW varchar2(256);
exec :P1RAW:= '&1';
select sid, serial#, lpad(' ',level)||blocking_session "BLOCKING_SESSION", final_blocking_session, username, sql_id, sqltext, "Mode", "Req"  from (SELECT s.sid, s.serial#, s.sql_id, kglpnmod "Mode", kglpnreq "Req", s.username, s.blocking_session, s.final_blocking_session, (select substr(sql_text,1,40) from v$sqlarea where sql_id = s.sql_id) sqltext FROM x$kglpn p, v$session s WHERE p.kglpnuse=s.saddr AND kglpnhdl=:P1RAW) start with blocking_session is null CONNECT BY PRIOR  sid = blocking_session;
