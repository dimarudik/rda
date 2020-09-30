col SVRNAME for a30
col PATH for a30
col LOCAL for a30
col DIRNAME for a30
col id for 999
col NFSVERSION for a10
select PNUM,SVRNAME, PATH, LOCAL, CH_ID, SVR_ID, SENDS, RECVS, PINGS from v$dnfs_channels order by sends;
select 
	ID,
	SVRNAME,
	DIRNAME,
	MNTPORT,
	NFSPORT,
	NFSVERSION,
	WTMAX,
	RTMAX,
	RDMAPORT
from 
	v$dnfs_servers;
