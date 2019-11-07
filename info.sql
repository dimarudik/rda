--set long 300000
--set longchunksize 30000
--set line 330 timing off
set timing off
set pagesize 70
-- 
-- 
-- Table / Partitions / Subpartitions and statistocs of patitioning keys info
-- 
-- 
col owner for a20
col table_name for a20
col table_owner for a20
col partition_name for a16
col keypart_col for a16
col high_value for a34
col low_v for a20
col last_analyzed for a20
col high_v for a20
col initrs for 999
col num_rows for 99,999,999,999
col blocks for 9,999,999,999
col avg_row_len for 9999999
col sample_size for 999999999999
col subpartition_name for a20
col tbs_name for a16
col comments for a34
var OWNER varchar2(256);
var ONAME varchar2(256);
exec :OWNER := UPPER(SUBSTR('&1',1,INSTR('&1','.')-1));
exec :ONAME := UPPER(SUBSTR('&1',INSTR('&1','.')+1));
select TABLE_NAME, LAST_ANALYZED, PARTITION_NAME, PART_TYPE, SUBPARTITION_NAME, SUBPART_TYPE, PART_COL KEYPART_COL, HIGH_VALUE, low_v, high_v, NUM_ROWS, BLOCKS, AVG_ROW_LEN, SAMPLE_SIZE, tablespace_name as tbs_name, INI_TRANS initrs, COMMENTS from 
    (
    	-- TABLE info
		select 
				dt.table_name, 
				null partition_name, 
				null part_type, 
				null subpartition_name, 
				null subpart_type, 
				dt.num_rows, 
				dt.blocks, 
				dt.avg_row_len, 
				dt.sample_size, 
				dt.last_analyzed, 
				null high_value, 
				null partition_position, 
				null subpartition_position, 
				dt.tablespace_name, 
				dt.ini_trans,
				null low_v,
				null high_v,
				null part_col,
				dtm.comments
		from dba_tables dt, dba_tab_comments dtm
		where 
			dt.owner = upper(:owner) and 
			upper(dt.table_name) = upper(:oname) and
			dt.owner = dtm.owner and
			dt.table_name = dtm.table_name
		union all
		-- PARTITION info
		select 
				null table_name, 	 
				dtp.partition_name, 
				dpt.partitioning_type, 
				null subpartition_name, 
				null, 
				dtp.num_rows, 
				dtp.blocks, 
				dtp.avg_row_len, 
				dtp.sample_size, 
				dtp.last_analyzed, 	 
				dtp.high_value, 	  
				dtp.partition_position, 
				null subpartition_position, 
				dtp.tablespace_name, 
				dtp.ini_trans,
				decode(dtc.data_type
					,'NUMBER'       ,to_char(utl_raw.cast_to_number(dpcs.low_value))
					--,'VARCHAR2'     ,to_char(utl_raw.cast_to_varchar2(dtc.low_value))
					--,'NVARCHAR2'    ,to_char(utl_raw.cast_to_nvarchar2(dtc.low_value))
					,'BINARY_DOUBLE',to_char(utl_raw.cast_to_binary_double(dpcs.low_value))
					,'BINARY_FLOAT' ,to_char(utl_raw.cast_to_binary_float(dpcs.low_value))
					,'DATE',to_char(1780+to_number(substr(dpcs.low_value,1,2),'XX')
					+to_number(substr(dpcs.low_value,3,2),'XX'))||'-'
					||to_number(substr(dpcs.low_value,5,2),'XX')||'-'
					||to_number(substr(dpcs.low_value,7,2),'XX')||' '
					||(to_number(substr(dpcs.low_value,9,2),'XX')-1)||':'
					||(to_number(substr(dpcs.low_value,11,2),'XX')-1)||':'
					||(to_number(substr(dpcs.low_value,13,2),'XX')-1)
					,'TIMESTAMP(2)',to_char(1780+to_number(substr(dpcs.low_value,1,2),'XX')
					+to_number(substr(dpcs.low_value,3,2),'XX'))||'-'
					||to_number(substr(dpcs.low_value,5,2),'XX')||'-'
					||to_number(substr(dpcs.low_value,7,2),'XX')||' '
					||(to_number(substr(dpcs.low_value,9,2),'XX')-1)||':'
					||(to_number(substr(dpcs.low_value,11,2),'XX')-1)||':'
					||(to_number(substr(dpcs.low_value,13,2),'XX')-1)
				,  null) as low_v,
				decode(dtc.data_type
					,'NUMBER'       ,to_char(utl_raw.cast_to_number(dpcs.high_value))
					--,'VARCHAR2'     ,to_char(utl_raw.cast_to_varchar2(dtc.high_value))
					--,'NVARCHAR2'    ,to_char(utl_raw.cast_to_nvarchar2(dtc.high_value))
					,'BINARY_DOUBLE',to_char(utl_raw.cast_to_binary_double(dpcs.high_value))
					,'BINARY_FLOAT' ,to_char(utl_raw.cast_to_binary_float(dpcs.high_value))
					,'DATE',to_char(1780+to_number(substr(dpcs.high_value,1,2),'XX')
					+to_number(substr(dpcs.high_value,3,2),'XX'))||'-'
					||to_number(substr(dpcs.high_value,5,2),'XX')||'-'
					||to_number(substr(dpcs.high_value,7,2),'XX')||' '
					||(to_number(substr(dpcs.high_value,9,2),'XX')-1)||':'
					||(to_number(substr(dpcs.high_value,11,2),'XX')-1)||':'
					||(to_number(substr(dpcs.high_value,13,2),'XX')-1)
					,'TIMESTAMP(2)',to_char(1780+to_number(substr(dpcs.high_value,1,2),'XX')
					+to_number(substr(dpcs.high_value,3,2),'XX'))||'-'
					||to_number(substr(dpcs.high_value,5,2),'XX')||'-'
					||to_number(substr(dpcs.high_value,7,2),'XX')||' '
					||(to_number(substr(dpcs.high_value,9,2),'XX')-1)||':'
					||(to_number(substr(dpcs.high_value,11,2),'XX')-1)||':'
					||(to_number(substr(dpcs.high_value,13,2),'XX')-1)
				,  null) as high_v,
				dpk.column_name,
				null as comments
		from dba_tab_partitions dtp, dba_part_tables dpt, dba_part_key_columns dpk, dba_part_col_statistics dpcs, dba_tab_columns dtc
		where 
			dtp.table_owner = upper(:owner) and 
			upper(dtp.table_name) = upper(:oname) and 
			dtp.table_owner = dpt.owner and 
			dtp.table_name = dpt.table_name and
			dtp.table_owner = dpk.owner and
			dtp.table_name = dpk.name and
			dpk.object_type = 'TABLE' and
			dtp.table_owner = dpcs.owner and
			dtp.table_name = dpcs.table_name and
			dtp.partition_name = dpcs.partition_name and
			dpk.column_name = dpcs.column_name and
			dtp.table_owner = dtc.owner and
			dtp.table_name = dtc.table_name and
			dpk.column_name = dtc.column_name
		union all
		-- SUBPARTITION info
		select 
				null table_name, 
				null partition_name, 
				null part_type,	  
				dts.subpartition_name, 
				dpt.subpartitioning_type, 
				dts.num_rows, 
				dts.blocks, 
				dts.avg_row_len, 
				dts.sample_size, 
				dts.last_analyzed, 	 
				dts.high_value,  
				dtp.partition_position, 
				dts.subpartition_position, 
				dts.tablespace_name, 
				dts.ini_trans,
				decode(dtc.data_type
					,'NUMBER'       ,to_char(utl_raw.cast_to_number(dpcs.low_value))
					--,'VARCHAR2'     ,to_char(utl_raw.cast_to_varchar2(dtc.low_value))
					--,'NVARCHAR2'    ,to_char(utl_raw.cast_to_nvarchar2(dtc.low_value))
					,'BINARY_DOUBLE',to_char(utl_raw.cast_to_binary_double(dpcs.low_value))
					,'BINARY_FLOAT' ,to_char(utl_raw.cast_to_binary_float(dpcs.low_value))
					,'DATE',to_char(1780+to_number(substr(dpcs.low_value,1,2),'XX')
					+to_number(substr(dpcs.low_value,3,2),'XX'))||'-'
					||to_number(substr(dpcs.low_value,5,2),'XX')||'-'
					||to_number(substr(dpcs.low_value,7,2),'XX')||' '
					||(to_number(substr(dpcs.low_value,9,2),'XX')-1)||':'
					||(to_number(substr(dpcs.low_value,11,2),'XX')-1)||':'
					||(to_number(substr(dpcs.low_value,13,2),'XX')-1)
					,'TIMESTAMP(2)',to_char(1780+to_number(substr(dpcs.low_value,1,2),'XX')
					+to_number(substr(dpcs.low_value,3,2),'XX'))||'-'
					||to_number(substr(dpcs.low_value,5,2),'XX')||'-'
					||to_number(substr(dpcs.low_value,7,2),'XX')||' '
					||(to_number(substr(dpcs.low_value,9,2),'XX')-1)||':'
					||(to_number(substr(dpcs.low_value,11,2),'XX')-1)||':'
					||(to_number(substr(dpcs.low_value,13,2),'XX')-1)
				,  null) as low_v,
				decode(dtc.data_type
					,'NUMBER'       ,to_char(utl_raw.cast_to_number(dpcs.high_value))
					--,'VARCHAR2'     ,to_char(utl_raw.cast_to_varchar2(dtc.high_value))
					--,'NVARCHAR2'    ,to_char(utl_raw.cast_to_nvarchar2(dtc.high_value))
					,'BINARY_DOUBLE',to_char(utl_raw.cast_to_binary_double(dpcs.high_value))
					,'BINARY_FLOAT' ,to_char(utl_raw.cast_to_binary_float(dpcs.high_value))
					,'DATE',to_char(1780+to_number(substr(dpcs.high_value,1,2),'XX')
					+to_number(substr(dpcs.high_value,3,2),'XX'))||'-'
					||to_number(substr(dpcs.high_value,5,2),'XX')||'-'
					||to_number(substr(dpcs.high_value,7,2),'XX')||' '
					||(to_number(substr(dpcs.high_value,9,2),'XX')-1)||':'
					||(to_number(substr(dpcs.high_value,11,2),'XX')-1)||':'
					||(to_number(substr(dpcs.high_value,13,2),'XX')-1)
					,'TIMESTAMP(2)',to_char(1780+to_number(substr(dpcs.high_value,1,2),'XX')
					+to_number(substr(dpcs.high_value,3,2),'XX'))||'-'
					||to_number(substr(dpcs.high_value,5,2),'XX')||'-'
					||to_number(substr(dpcs.high_value,7,2),'XX')||' '
					||(to_number(substr(dpcs.high_value,9,2),'XX')-1)||':'
					||(to_number(substr(dpcs.high_value,11,2),'XX')-1)||':'
					||(to_number(substr(dpcs.high_value,13,2),'XX')-1)
				,  null) as high_v,
				dpk.column_name,
				null as comments
		from dba_tab_subpartitions dts, dba_part_tables dpt, dba_tab_partitions dtp, dba_subpart_key_columns dpk, dba_subpart_col_statistics dpcs, dba_tab_columns dtc
		where 
			dtp.table_owner = dts.table_owner and 
			dtp.table_name = dts.table_name and 
			dtp.partition_name = dts.partition_name and 
			dts.table_owner = upper(:owner) and 
			upper(dts.table_name) = upper(:oname) and 
			dts.table_owner = dpt.owner and 
			dts.table_name = dpt.table_name  
			         and
			dts.table_owner = dpk.owner and
			dts.table_name = dpk.name and
			dpk.object_type = 'TABLE' and
			dts.table_owner = dpcs.owner and
			dts.table_name = dpcs.table_name and
			--dts.partition_name = dpcs.partition_name and
			dts.subpartition_name = dpcs.subpartition_name and
			dpk.column_name = dpcs.column_name and
			dts.table_owner = dtc.owner and
			dts.table_name = dtc.table_name and
			dpk.column_name = dtc.column_name
	) order by partition_position nulls first, subpartition_position nulls first, partition_name nulls last;
-- 
-- 
-- Columns and statistocs of columns info
-- 
-- 
col column_name for a30
col data_type for a30
col "DEFAULT" for a13
col low_value for a30
col high_value for a30
col comments for a70
select
		dtc.column_name, 
		dtc.data_type||decode(dtc.char_length,	0,
		decode(dtc.data_precision,null,null,'('||dtc.data_precision||','||dtc.data_scale||')'),
		'('||dtc.char_length||decode(dtc.char_used,'B',' BYTE','C',' CHAR')||')') as data_type,
		dtc.nullable,
		dtc.data_default as "DEFAULT",
		dtc.histogram,
		dtc.last_analyzed,
		dtc.num_distinct,
		dtc.num_nulls,
		decode(dtc.data_type
			,'NUMBER'       ,to_char(utl_raw.cast_to_number(dtc.low_value))
			--,'VARCHAR2'     ,to_char(utl_raw.cast_to_varchar2(dtc.low_value))
			--,'NVARCHAR2'    ,to_char(utl_raw.cast_to_nvarchar2(dtc.low_value))
			,'BINARY_DOUBLE',to_char(utl_raw.cast_to_binary_double(dtc.low_value))
			,'BINARY_FLOAT' ,to_char(utl_raw.cast_to_binary_float(dtc.low_value))
			,'DATE',to_char(1780+to_number(substr(dtc.low_value,1,2),'XX')
			+to_number(substr(dtc.low_value,3,2),'XX'))||'-'
			||to_number(substr(dtc.low_value,5,2),'XX')||'-'
			||to_number(substr(dtc.low_value,7,2),'XX')||' '
			||(to_number(substr(dtc.low_value,9,2),'XX')-1)||':'
			||(to_number(substr(dtc.low_value,11,2),'XX')-1)||':'
			||(to_number(substr(dtc.low_value,13,2),'XX')-1)
			,'TIMESTAMP(2)',to_char(1780+to_number(substr(dtc.low_value,1,2),'XX')
			+to_number(substr(dtc.low_value,3,2),'XX'))||'-'
			||to_number(substr(dtc.low_value,5,2),'XX')||'-'
			||to_number(substr(dtc.low_value,7,2),'XX')||' '
			||(to_number(substr(dtc.low_value,9,2),'XX')-1)||':'
			||(to_number(substr(dtc.low_value,11,2),'XX')-1)||':'
			||(to_number(substr(dtc.low_value,13,2),'XX')-1)
		,  null) as low_value,
		decode(dtc.data_type
			,'NUMBER'       ,to_char(utl_raw.cast_to_number(dtc.high_value))
			--,'VARCHAR2'     ,to_char(utl_raw.cast_to_varchar2(dtc.high_value))
			--,'NVARCHAR2'    ,to_char(utl_raw.cast_to_nvarchar2(dtc.high_value))
			,'BINARY_DOUBLE',to_char(utl_raw.cast_to_binary_double(dtc.high_value))
			,'BINARY_FLOAT' ,to_char(utl_raw.cast_to_binary_float(dtc.high_value))
			,'DATE',to_char(1780+to_number(substr(dtc.high_value,1,2),'XX')
			+to_number(substr(dtc.high_value,3,2),'XX'))||'-'
			||to_number(substr(dtc.high_value,5,2),'XX')||'-'
			||to_number(substr(dtc.high_value,7,2),'XX')||' '
			||(to_number(substr(dtc.high_value,9,2),'XX')-1)||':'
			||(to_number(substr(dtc.high_value,11,2),'XX')-1)||':'
			||(to_number(substr(dtc.high_value,13,2),'XX')-1)
			,'TIMESTAMP(2)',to_char(1780+to_number(substr(dtc.high_value,1,2),'XX')
			+to_number(substr(dtc.high_value,3,2),'XX'))||'-'
			||to_number(substr(dtc.high_value,5,2),'XX')||'-'
			||to_number(substr(dtc.high_value,7,2),'XX')||' '
			||(to_number(substr(dtc.high_value,9,2),'XX')-1)||':'
			||(to_number(substr(dtc.high_value,11,2),'XX')-1)||':'
			||(to_number(substr(dtc.high_value,13,2),'XX')-1)
		,  null) as high_value,
		dcc.comments
	from 
		dba_tab_columns dtc,
		dba_col_comments dcc,
		dba_tables dt
	where 
		dtc.OWNER = upper(:OWNER) and 
		upper(dtc.table_name) = upper(:ONAME) and
		dtc.owner = dcc.owner and
		dtc.table_name = dcc.table_name and
		dtc.column_name = dcc.column_name and
		dt.owner = dtc.owner and
		dt.table_name = dtc.table_name
	order by dtc.column_id;
-- 
-- Indexes
--
col index_name for a37
col UNIQUENESS for a10
col tablespace_name for a18
col columns for a60
col blevel for 999999
col leaf_blocks for 999,999,999
col IND_T for a20
col index_type for a12
col status for a10
col VISIBILITY for a16
select INDEX_NAME, UNIQUENESS, IND_T, INDEX_TYPE, PARTITION_NAME, SUBPARTITION_NAME, LAST_ANALYZED, TABLESPACE_NAME, INI_TRANS initrs, BLEVEL, LEAF_BLOCKS, DISTINCT_KEYS, NUM_ROWS, CLUSTERING_FACTOR, STATUS, VISIBILITY, COLUMNS 
from
(
	-- GLOBAL NON-PARTITIONED
	select 
			di.index_name, 
			'GLOBAL' ind_t, 
			di.index_type, 
			di.last_analyzed, 
			di.uniqueness, 
			di.tablespace_name, 
			di.ini_trans, 
			di.blevel, 
			di.leaf_blocks, 
			di.distinct_keys, 
			di.num_rows, 
			di.clustering_factor, 
			di.status, 
			di.visibility, 
	    	(select listagg (dic.column_name, ', ') within group (order by dic.column_position) from dba_ind_columns dic where dic.index_name = di.index_name and di.owner = dic.index_owner group by index_name) columns,
	    	null partition_position,
	    	null partition_name,
	    	null iname,
	    	null subpartition_position,
	    	null subpartition_name,
	    	null pname
	    from dba_indexes di 
	    where 
	    	di.owner = upper(:owner) and 
	    	upper(di.table_name) = upper(:oname) and 
	    	di.partitioned = 'NO'
	union all
	-- GLOBAL PARTITIONED
	select 
			di.index_name, 
			'GLOBAL PARTITIONED' ind_t, 
			di.index_type, 
			di.last_analyzed, 
			di.uniqueness, 
			di.tablespace_name, 
			di.ini_trans, 
			di.blevel, 
			di.leaf_blocks, 
			di.distinct_keys, 
			di.num_rows, 
			di.clustering_factor, 
			decode(di.status,'N/A',null,di.status) status,
			di.visibility, 
	    	(select listagg (dic.column_name, ', ') within group (order by dic.column_position) from dba_ind_columns dic where dic.index_name = di.index_name and di.owner = dic.index_owner group by index_name) columns,
	    	0 partition_position,
	    	null partition_name,
	    	di.index_name iname,
	    	null subpartition_position,
	    	null subpartition_name,
	    	null pname
	    from dba_part_indexes dpi, dba_indexes di
	    where
	    	dpi.owner = di.owner and 
	    	dpi.index_name = di.index_name and
	    	di.owner = upper(:owner) and 
	    	upper(di.table_name) = upper(:oname) and
	    	dpi.locality = 'GLOBAL'
	union all
	-- PARTITIONS of GLOBAL PARTITIONED
	select 
			null index_name, 
			null ind_t, 
			null index_type, 
			null last_analyzed, 
			null uniqueness, 
			dip.tablespace_name, 
			dip.ini_trans, 
			dip.blevel, 
			dip.leaf_blocks, 
			dip.distinct_keys, 
			dip.num_rows, 
			dip.clustering_factor, 
			dip.status, 
			null visibility,
	    	null columns,
	    	dip.partition_position,
	    	dip.partition_name,
	    	di.index_name iname,
	    	null subpartition_position,
	    	null subpartition_name,
	    	null pname
	    from dba_part_indexes dpi, dba_ind_partitions dip, dba_indexes di
	    where
	    	dpi.owner = di.owner and 
	    	dpi.index_name = di.index_name and
	    	di.owner = upper(:owner) and 
	    	upper(di.table_name) = upper(:oname) and
	    	dpi.locality = 'GLOBAL' and
	    	dip.index_owner = dpi.owner and 
	    	dip.index_name = dpi.index_name
	union all
	-- LOCAL
	select 
			di.index_name, 
			'LOCAL PARTITIONED' ind_t, 
			di.index_type, 
			di.last_analyzed, 
			di.uniqueness, 
			di.tablespace_name, 
			di.ini_trans, 
			di.blevel, 
			di.leaf_blocks, 
			di.distinct_keys, 
			di.num_rows, 
			di.clustering_factor, 
			decode(di.status,'N/A',null,di.status) status,
			di.visibility, 
	    	(select listagg (dic.column_name, ', ') within group (order by dic.column_position) from dba_ind_columns dic where dic.index_name = di.index_name and di.owner = dic.index_owner group by index_name) columns,
	    	0 partition_position,
	    	null partition_name,
	    	di.index_name iname,
	    	null subpartition_position,
	    	null subpartition_name,
	    	null pname
	    from dba_part_indexes dpi, dba_indexes di
	    where
	    	dpi.owner = di.owner and 
	    	dpi.index_name = di.index_name and
	    	di.owner = upper(:owner) and 
	    	upper(di.table_name) = upper(:oname) and
	    	dpi.locality = 'LOCAL'
	union all
	-- PARTITIONS of LOCAL
	select 
			null index_name, 
			null ind_t, 
			null index_type, 
			null last_analyzed, 
			null uniqueness, 
			dip.tablespace_name, 
			dip.ini_trans, 
			dip.blevel, 
			dip.leaf_blocks, 
			dip.distinct_keys, 
			dip.num_rows, 
			dip.clustering_factor, 
			decode(dip.status,'N/A',null,dip.status) status,
			null visibility,
	    	null columns,
	    	dip.partition_position,
	    	dip.partition_name,
	    	di.index_name iname,
	    	null subpartition_position,
	    	null subpartition_name,
	    	dip.partition_name pname
	    from dba_part_indexes dpi, dba_ind_partitions dip, dba_indexes di
	    where
	    	dpi.owner = di.owner and 
	    	dpi.index_name = di.index_name and
	    	di.owner = upper(:owner) and 
	    	upper(di.table_name) = upper(:oname) and
	    	dpi.locality = 'LOCAL' and
	    	dip.index_owner = dpi.owner and 
	    	dip.index_name = dpi.index_name
	union all
	-- SUBPARTITIONS of LOCAL
	select 
			null index_name, 
			null ind_t, 
			null index_type, 
			null last_analyzed, 
			null uniqueness, 
			dis.tablespace_name, 
			dis.ini_trans, 
			dis.blevel, 
			dis.leaf_blocks, 
			dis.distinct_keys, 
			dis.num_rows, 
			dis.clustering_factor, 
			decode(dis.status,'N/A',null,dis.status) status,
			null visibility,
	    	null columns,
	    	dip.partition_position,
	    	null partition_name,
	    	di.index_name iname,
	    	dis.subpartition_position,
	    	dis.subpartition_name,
	    	dis.partition_name pname
	    from dba_part_indexes dpi, dba_ind_partitions dip, dba_indexes di, dba_ind_subpartitions dis
	    where
	    	dpi.owner = di.owner and 
	    	dpi.index_name = di.index_name and
	    	di.owner = upper(:owner) and 
	    	upper(di.table_name) = upper(:oname) and
	    	dpi.locality = 'LOCAL' and
	    	dip.index_owner = dpi.owner and 
	    	dip.index_name = dpi.index_name and
	    	dip.partition_name = dis.partition_name and
	    	dip.index_owner = dis.index_owner and
	    	dip.index_name = dis.index_name
) order by iname nulls first, partition_position nulls first, subpartition_position nulls first;
--
--
--
-- MODIFICATIONS
--
--
--
col inserts for 9,999,999,999
col updates for 9,999,999,999
col deletes for 9,999,999,999
select * from dba_tab_modifications where table_owner = upper(:owner) and upper(table_name) = upper(:oname) order by partition_name nulls first, subpartition_name nulls first;
--
--
--
-- TRIGGERS
--
--
--
col trigger_name for a30
col trigger_type for a20
col triggering_event for a20
col referencing_names for a40
col when_clause for a150
select 
	trigger_name, 
	trigger_type, 
	triggering_event,
	column_name,
	referencing_names,
	when_clause,
	status
	/*
	action_type
	before_statement,
	before_row,
	after_row,
	after_statement
	*/
from 	
	dba_triggers 
where 
	table_owner = upper(:owner) and upper(table_name) = upper(:oname);
