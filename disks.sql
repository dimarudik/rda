col NAME format a28
col FAILGROUP format a12
col LABEL format a28
col PATH format a58
col GROUP format a9
select GROUP_NUMBER, DISK_NUMBER, MOUNT_STATUS, MODE_STATUS, STATE, REDUNDANCY, NAME, FAILGROUP, LABEL, total_mb, PATH from v$asm_disk order by label, failgroup;
--select G.NAME as "GROUP", D.MOUNT_STATUS, D.MODE_STATUS, D.STATE, D.REDUNDANCY, D.NAME, D.FAILGROUP, D.LABEL, D.total_mb, D.PATH from v$asm_disk d, v$asm_diskgroup g where d.group_number = g.group_number and G.STATE = 'MOUNTED' order by label, failgroup;
