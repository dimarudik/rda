col os_user for a16
col os_pid for a10
col username for a20
col sid for 999999
col lock_type for a30
col lock_held for a30
col lock_requested for a20
col status for a30
col owner for a30
col object_name for a40
select
    OS_USER_NAME os_user,
    PROCESS os_pid,
    ORACLE_USERNAME username,
    l.SID,
    decode(l.TYPE,
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
        'TT', 'Temp Table', type) lock_type,
    decode(l.LMODE,
        0, 'None',
        1, 'Null',
        2, 'Row-S (SS)',
        3, 'Row-X (SX)',
        4, 'Share',
        5, 'S/Row-X (SSX)',
        6, 'Exclusive', lmode) lock_held,
    decode(REQUEST,
        0, 'None',
        1, 'Null',
        2, 'Row-S (SS)',
        3, 'Row-X (SX)',
        4, 'Share',
        5, 'S/Row-X (SSX)',
        6, 'Exclusive', request) lock_requested,
    decode(BLOCK,
        0, 'Not Blocking',
        1, 'Blocking',
        2, 'Global', block) status,
    OWNER,
    OBJECT_NAME
from       
    v$locked_object lo,
    dba_objects do,
    v$lock l
where      
    lo.OBJECT_ID = do.OBJECT_ID
    and l.SID = lo.SESSION_ID;
