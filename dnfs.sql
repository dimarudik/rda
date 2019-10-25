col SVRNAME for a30
col PATH for a30
col LOCAL for a30
col DIRNAME for a30
select * from v$dnfs_servers;
select PNUM,SVRNAME, PATH, LOCAL, CH_ID, SVR_ID, SENDS, RECVS, PINGS from v$dnfs_channels order by sends;
