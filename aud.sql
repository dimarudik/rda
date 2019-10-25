set rowlimit 100
set long 1000
col userid for a30
col userhost for a30
col terminal for a30
col NTIMESTAMP# for a30
col SQLTEXT for a110
select USERID, USERHOST, TERMINAL, NTIMESTAMP#, SQLTEXT from aud$ order by NTIMESTAMP# desc;
