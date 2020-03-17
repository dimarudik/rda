col "Owner" for a20
col "Object Name" for a40
var objd number;
exec :objd := &1;
WITH t1 AS
(
    select 
           decode(a.type#, 0, 'NEXT OBJECT', 1, 'INDEX', 2, 'TABLE', 3, 'CLUSTER',
                  4, 'VIEW', 5, 'SYNONYM', 6, 'SEQUENCE',
                  7, 'PROCEDURE', 8, 'FUNCTION', 9, 'PACKAGE',
                  11, 'PACKAGE BODY', 12, 'TRIGGER',
                  13, 'TYPE', 14, 'TYPE BODY',
                  19, 'TABLE PARTITION', 20, 'INDEX PARTITION', 21, 'LOB',
                  22, 'LIBRARY', 23, 'DIRECTORY',  24, 'QUEUE',
                  28, 'JAVA SOURCE', 29, 'JAVA CLASS', 30, 'JAVA RESOURCE',
                  32, 'INDEXTYPE', 33, 'OPERATOR',
                  34, 'TABLE SUBPARTITION', 35, 'INDEX SUBPARTITION',
                  40, 'LOB PARTITION', 41, 'LOB SUBPARTITION',
                  42, CASE (SELECT BITAND(s.xpflags, 8388608 + 34359738368)
                    FROM sum$ s
                    WHERE s.obj#=a.objd)
                  WHEN 8388608 THEN 'REWRITE EQUIVALENCE'
                  WHEN 34359738368 THEN 'MATERIALIZED ZONEMAP'
                  ELSE 'MATERIALIZED VIEW'
                  END,
                  43, 'DIMENSION',
                  44, 'CONTEXT', 46, 'RULE SET', 47, 'RESOURCE PLAN',
                  48, 'CONSUMER GROUP',
                  51, 'SUBSCRIPTION', 52, 'LOCATION',
                  55, 'XML SCHEMA', 56, 'JAVA DATA',
                  57, 'EDITION', 59, 'RULE',
                  60, 'CAPTURE', 61, 'APPLY',
                  62, 'EVALUATION CONTEXT',
                  66, 'JOB', 67, 'PROGRAM', 68, 'JOB CLASS', 69, 'WINDOW',
                  72, 'SCHEDULER GROUP', 74, 'SCHEDULE', 79, 'CHAIN',
                  81, 'FILE GROUP', 82, 'MINING MODEL',  87, 'ASSEMBLY',
                  90, 'CREDENTIAL', 92, 'CUBE DIMENSION', 93, 'CUBE',
                  94, 'MEASURE FOLDER', 95, 'CUBE BUILD PROCESS',
                  100, 'FILE WATCHER', 101, 'DESTINATION',
                  114, 'SQL TRANSLATION PROFILE',
                  115, 'UNIFIED AUDIT POLICY',
                  144, 'MINING MODEL PARTITION',
                  148, 'LOCKDOWN PROFILE',
                  150, 'HIERARCHY',
                  151, 'ATTRIBUTE DIMENSION',
                  152, 'ANALYTIC VIEW',
                  'UNDEFINED') object_type,
                a.owner,
                a.object_name,
                a.subobject_name,
                a.num_blocks,
                a.objd
    from 
    (
        SELECT  
                o.type#,
                u.name owner,
                o.name object_name,
                o.subname subobject_name,
                count(distinct file#||block#) num_blocks,
                --count( file#||block#) num_blocks,
                bh.objd
        FROM    
                obj$ o,
                user$ u,
                v$bh bh
        WHERE   o.dataobj# = bh.objd
        	and u.name not in ('SYS', 'SYSTEM','GSMADMIN_INTERNAL','XDB','PERFSTAT','OUTLN','DBSNMP','AUDSYS','WMSYS')
                --and u.name not in ('SYS', 'SYSTEM', 'XDB', 'AUDSYS', 'DBSNMP')
                and bh.status != 'free'
                and o.owner# = u.user#
                and decode(:objd,-1,objd,:objd) = objd
        GROUP BY 
                o.type#,
                u.name,
                o.name,
                o.subname,
                bh.objd
    ) a
)
SELECT  t1.objd as "Object ID",
        t1.owner "Owner",
        object_name "Object Name",
        object_type,
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
        --having sum (num_blocks) > 10
ORDER BY SUM(num_blocks);
/*
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
*/
