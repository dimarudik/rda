col "Owner" for a20
col "Object Name" for a40
var objd number;
exec :objd := &1;
WITH t1 AS
        (
                SELECT  o.owner owner,
                        o.object_name object_name,
                        o.subobject_name subobject_name,
                        o.object_type object_type,
                        count(distinct file#||block#) num_blocks,
                        --count( file#||block#) num_blocks,
                        bh.objd
                FROM    dba_objects o,
                        v$bh bh
                WHERE   o.data_object_id = bh.objd
                        and o.owner not in ('SYS', 'SYSTEM')
                        and bh.status != 'free'
                        and decode(:objd,-1,objd,:objd) = objd
                GROUP BY o.owner,
                        o.object_name,
                        o.subobject_name,
                        o.object_type,
                        bh.objd
                ORDER BY COUNT(DISTINCT file#||block#) DESC
        )
SELECT  t1.objd as "Object ID",
        t1.owner "Owner",
        object_name "Object Name",
        CASE
                WHEN object_type = 'TABLE PARTITION' THEN 'TAB PART'
                WHEN object_type = 'INDEX PARTITION' THEN 'IDX PART'
                ELSE object_type
        END "Object Type",
        SUM(num_blocks) "Blocks in Buffer Cache",
        round(SUM(num_blocks)  * (SUM(bytes) / SUM(blocks)) / 1024 / 1024 / 1024,3) "GB in Buffer Cache",
        round((SUM(num_blocks) / greatest(SUM(blocks), .001)) * 100,3) "Perc of object blocks in Buff"
FROM    t1,
        dba_segments s
WHERE   s.segment_name = t1.object_name
        AND s.owner = t1.owner
        AND s.segment_type = t1.object_type
        AND NVL(s.partition_name, '-') = NVL(t1.subobject_name, '-')
        --   and s.segment_name in ('')
GROUP BY
        t1.objd, 
        t1.owner,
        object_name,
        object_type
        having sum (num_blocks) > 10
ORDER BY SUM(num_blocks);
