col "Date" for a21
col "Name Of Day" for a12
col "Block Changes Delta" for 999,999,999,999
col "Block Changes Total" for 999,999,999,999
col "Space Used Delta" for 999,999,999,999
col "Space Used Total" for 999,999,999,999
col "Space Allocated Delta" for 999,999,999,999
col "Space Allocated Total" for 999,999,999,999
var objd number;
exec :objd := &1;
select
    trunc(snh.begin_interval_time) "Date",
    to_char(snh.begin_interval_time,'DAY') "Name Of Day",
    sum(sgh.db_block_changes_delta) "Block Changes Delta",
    max(sgh.db_block_changes_total) "Block Changes Total",
    sum(sgh.space_used_delta) "Space Used Delta",
    max(sgh.space_used_total) "Space Used Total",
    sum(sgh.space_allocated_delta) "Space Allocated Delta",
    max(sgh.space_allocated_total) "Space Allocated Total"
from
    dba_hist_seg_stat sgh, dba_hist_snapshot snh
where
    decode(:objd,-1,sgh.dataobj#,:objd) = sgh.dataobj# and
    --sgh.dataobj# = 66601 and
    --sgh.dbid = 3847319087 and
    sgh.snap_id = snh.snap_id
group by
    trunc(snh.begin_interval_time),
    to_char(snh.begin_interval_time,'DAY')
order by 1 desc;
