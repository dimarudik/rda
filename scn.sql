set linesize 200;
set pagesize 100;
col inst_id for 9999999 heading 'Instance #'
col file_nr for 9999999 heading 'File #'
col file_name for A50 heading 'File name'
col checkpoint_change_nr for 99999999999999 heading 'Checkpoint #'
col checkpoint_change_time for A20 heading 'Checkpoint time'
col last_change_nr for 99999999999999 heading 'Last change #'
SELECT
      fe.inst_id,
      fe.fenum file_nr,
      fn.fnnam file_name,
      TO_NUMBER (fe.fecps) checkpoint_change_nr,
      fe.fecpt checkpoint_change_time,
      fe.fests last_change_nr,
      DECODE (
              fe.fetsn,
              0, DECODE (BITAND (fe.festa, 2), 0, 'SYSOFF', 'SYSTEM'),
              DECODE (BITAND (fe.festa, 18),
                      0, 'OFFLINE',
                      2, 'ONLINE',
                      'RECOVER')
      ) status
FROM x$kccfe fe,
     x$kccfn fn
WHERE    (   (fe.fepax != 65535 AND fe.fepax != 0 )
          OR (fe.fepax = 65535 OR fe.fepax = 0)
         )
     AND fn.fnfno = fe.fenum
     AND fe.fefnh = fn.fnnum
     AND fe.fedup != 0
     AND fn.fntyp = 4
     AND fn.fnnam IS NOT NULL
     AND BITAND (fn.fnflg, 4) != 4
ORDER BY fe.fenum;
