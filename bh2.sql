--set line 340
set pagesize 36
set line 340
col owner for a16
col object_name for a34
col object_type for a22
col subobject_name for a30
var objd number;
exec :objd := &1;
SELECT  o.object_id,
        o.owner owner,
        o.object_name object_name,
        o.subobject_name subobject_name,
        o.object_type object_type,
        count(decode(bh.status,'xcur',block#,null)) "XCUR Exclusive",
        count(decode(bh.status,'cr',block#,null)) "CR Consistent read",
        count(decode(bh.status,'flashcur',block#,null)) "FLASCUR Flash cache",
        --count(decode(bh.status,'free',block#,null)) "FREE",
        --count(decode(bh.status,'flashfree',block#,null)) "FLASHFREE Free flash cache",
        count(decode(bh.status,'scur',block#,null)) "SCUR Shared current",
        count(decode(bh.status,'read',block#,null)) "READ Reading from disk",
        count(decode(bh.status,'mrec',block#,null)) "MREC Media recovery",
        count(decode(bh.status,'irec',block#,null)) "IREC Instance recovery",
        count(decode(bh.status,'pi',block#,null)) "PI Past image in RAC mode",
        count(decode(bh.status,'securefile',block#,null)) "SECUREFILE"
FROM    dba_objects o,
        v$bh bh
WHERE   o.data_object_id = bh.objd
        and o.owner not in ('SYS', 'SYSTEM','GSMADMIN_INTERNAL','XDB','PERFSTAT','OUTLN','DBSNMP','AUDSYS','WMSYS')
        and decode(:objd,-1,objd,:objd) = objd
GROUP BY
        o.object_id, 
        o.owner,
        o.object_name,
        o.subobject_name,
        o.object_type
order by
        "XCUR Exclusive";
        --o.object_name;
