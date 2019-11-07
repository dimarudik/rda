col blocker for a20
col blocker_sid for 999999
col blocker_sess_status for a19
col blocker_lock_type for a18
col description for a20
col blockee for a20
col blockee_lock_type for a18
col lmode_desc for a12
col request_desc for a18
col status for a18
select 
	gv1.username blocker,
	a.sid blocker_sid, 
	gv1.serial# blocker_serial#, 
	gv1.status blocker_sess_status, 
	a.type blocker_lock_type, 
    	decode(a.TYPE,
        	'MR', 'Media Recovery',
        	'RT', 'Redo Thread',
        	'UN', 'User Name',
        	'TX', 'Transaction',
        	'TM', 'DML',
        	'UL', 'PL/SQL User Lock',
        	'DX', 'Distributed Xaction',
        	'CF', 'Control File',
        	'IS', 'Instance State',
        	'FS', 'File Set',
        	'IR', 'Instance Recovery',
        	'ST', 'Disk Space Transaction',
        	'TS', 'Temp Segment',
        	'IV', 'Library Cache Invalidation',
        	'LS', 'Log Start or Switch',
        	'RW', 'Row Wait',
        	'SQ', 'Sequence Number',
        	'TE', 'Extend Table',
        	'TT', 'Temp Table', a.type) description,
	(select username from gv$session where sid = b.sid) blockee,
	b.sid blockee_sid, 
    decode(a.LMODE,
        0, 'None',
        1, 'Null',
        2, 'Row-S (SS)',
        3, 'Row-X (SX)',
        4, 'Share',
        5, 'S/Row-X (SSX)',
        6, 'Exclusive', a.lmode) lmode_desc,
    decode(b.REQUEST,
        0, 'None',
        1, 'Null',
        2, 'Row-S (SS)',
        3, 'Row-X (SX)',
        4, 'Share',
        5, 'S/Row-X (SSX)',
        6, 'Exclusive', b.request) request_desc,
    decode(b.BLOCK,
        0, 'Not Blocking',
        1, 'Blocking',
        2, 'Global', b.block) status,
	(select row_wait_obj# from gv$session where sid = b.sid) row_wait_obj#, 
	(select row_wait_file# from gv$session where sid = b.sid) row_wait_file#, 
	(select row_wait_block# from gv$session where sid = b.sid) row_wait_block#, 
	(select row_wait_row# from gv$session where sid = b.sid) row_wait_row# 
from 
	gv$lock a, 
	gv$lock b,
	gv$session gv1
where 
	a.block = 1 and 
	b.request > 0 and 
	a.id1 = b.id1 and 
	a.id2 = b.id2 and
	a.sid = gv1.sid
order by 1,2;
