DECLARE
	SQL_FTEXT CLOB;
begin
	SELECT SQL_FULLTEXT INTO SQL_FTEXT FROM V$SQLAREA WHERE SQL_ID = '8fq1ngtq9gn09';
	dbms_sqltune.import_sql_profile(
		name     => 'profile_8fq1ngtq9gn09',
		category => 'DEFAULT',
		sql_text => SQL_FTEXT,
		profile  => sqlprof_attr
(
'BEGIN_OUTLINE_DATA',
'IGNORE_OPTIM_EMBEDDED_HINTS',
'OPTIMIZER_FEATURES_ENABLE(''11.2.0.3'')',
'DB_VERSION(''11.2.0.4'')',
'OPT_PARAM(''_optimizer_max_permutations'' 100)',
'OPT_PARAM(''_always_anti_join'' ''off'')',
'OPT_PARAM(''_always_semi_join'' ''off'')',
'OPT_PARAM(''_partition_view_enabled'' ''false'')',
'OPT_PARAM(''_b_tree_bitmap_plans'' ''false'')',
'OPT_PARAM(''query_rewrite_enabled'' ''false'')',
'OPT_PARAM(''optimizer_dynamic_sampling'' 1)',
'OPT_PARAM(''_optimizer_cost_based_transformation'' ''off'')',
'OPT_PARAM(''optimizer_index_cost_adj'' 1)',
'ALL_ROWS',
'OUTLINE_LEAF(@"SEL$1")',
'INDEX_RS_ASC(@"SEL$1" "T38"@"SEL$1" ("S_ORDER"."OPTY_ID"))',
'INDEX_RS_ASC(@"SEL$1" "T37"@"SEL$1" ("S_PRI_LST"."ROW_ID"))',
'INDEX_RS_ASC(@"SEL$1" "T33"@"SEL$1" ("S_LOY_MEMBER"."ROW_ID"))',
'INDEX_RS_ASC(@"SEL$1" "T28"@"SEL$1" ("S_DOC_QUOTE"."ROW_ID"))',
'INDEX_RS_ASC(@"SEL$1" "T24"@"SEL$1" ("S_ADDR_PER"."ROW_ID"))',
'INDEX_RS_ASC(@"SEL$1" "T23"@"SEL$1" ("S_INVLOC"."ROW_ID"))',
'INDEX_RS_ASC(@"SEL$1" "T22"@"SEL$1" ("S_INVLOC"."ROW_ID"))',
'INDEX_RS_ASC(@"SEL$1" "T20"@"SEL$1" ("S_INV_PROF"."ROW_ID"))',
'INDEX_RS_ASC(@"SEL$1" "T17"@"SEL$1" ("S_ORG_EXT"."PAR_ROW_ID"))',
'INDEX_RS_ASC(@"SEL$1" "T11"@"SEL$1" ("S_ORDER"."ROW_ID"))',
'INDEX_RS_ASC(@"SEL$1" "T21"@"SEL$1" ("S_QUOTE_TNTX"."PAR_ROW_ID" "S_QUOTE_TNTX"."CONFLICT_ID"))',
'INDEX_RS_ASC(@"SEL$1" "T15"@"SEL$1" ("S_CONTACT"."PAR_ROW_ID"))',
'INDEX_RS_ASC(@"SEL$1" "T36"@"SEL$1" ("S_ORDER_PSX"."PAR_ROW_ID" "S_ORDER_PSX"."CONFLICT_ID"))',
'INDEX_RS_ASC(@"SEL$1" "T13"@"SEL$1" ("S_ORG_EXT"."PAR_ROW_ID"))',
'INDEX_RS_ASC(@"SEL$1" "T35"@"SEL$1" ("S_DOC_AGREE"."ROW_ID"))',
'INDEX_RS_ASC(@"SEL$1" "T25"@"SEL$1" ("S_ADDR_PER"."ROW_ID"))',
'INDEX_RS_ASC(@"SEL$1" "T6"@"SEL$1" ("S_ADDR_PER"."ROW_ID"))',
'INDEX(@"SEL$1" "T2"@"SEL$1" ("S_ADDR_PER_X"."PAR_ROW_ID" "S_ADDR_PER_X"."ATTRIB_37"))',
'INDEX(@"SEL$1" "T10"@"SEL$1" ("S_ADDR_PER"."ROW_ID" "S_ADDR_PER"."ZIPCODE"))',
'INDEX_RS_ASC(@"SEL$1" "T4"@"SEL$1" ("S_CONTACT"."PAR_ROW_ID"))',
'INDEX_RS_ASC(@"SEL$1" "T29"@"SEL$1" ("S_SRC_PAYMENT"."ROW_ID"))',
'INDEX(@"SEL$1" "T3"@"SEL$1" ("S_PARTY"."ROW_ID"))',
'INDEX(@"SEL$1" "T19"@"SEL$1" ("S_CONTACT"."PAR_ROW_ID" "S_CONTACT"."FST_NAME" "S_CONTACT"."LAST_NAME"))',
'INDEX(@"SEL$1" "T16"@"SEL$1" ("S_CONTACT"."PAR_ROW_ID" "S_CONTACT"."FST_NAME" "S_CONTACT"."LAST_NAME"))',
'INDEX_RS_ASC(@"SEL$1" "T9"@"SEL$1" ("S_ADDR_PER"."ROW_ID"))',
'INDEX_RS_ASC(@"SEL$1" "T5"@"SEL$1" ("S_ADDR_PER"."ROW_ID"))',
'INDEX(@"SEL$1" "T34"@"SEL$1" ("S_ADDR_PER_X"."PAR_ROW_ID" "S_ADDR_PER_X"."ATTRIB_37"))',
'INDEX_RS_ASC(@"SEL$1" "T12"@"SEL$1" ("S_ORG_EXT"."PAR_ROW_ID"))',
'INDEX_RS_ASC(@"SEL$1" "T27"@"SEL$1" ("S_ORDER_DTL"."PAR_ROW_ID" "S_ORDER_DTL"."CONFLICT_ID"))',
'INDEX_RS_ASC(@"SEL$1" "T18"@"SEL$1" ("S_ORDER_FMX"."PAR_ROW_ID" "S_ORDER_FMX"."CONFLICT_ID"))',
'INDEX_RS_ASC(@"SEL$1" "T14"@"SEL$1" ("S_LOCATION"."ROW_ID"))',
'INDEX_RS_ASC(@"SEL$1" "T7"@"SEL$1" ("S_LOCATION"."ROW_ID"))',
'INDEX_RS_ASC(@"SEL$1" "T32"@"SEL$1" ("S_ORG_EXT"."PAR_ROW_ID"))',
'INDEX(@"SEL$1" "T30"@"SEL$1" ("S_ORG_EXT"."PAR_ROW_ID" "S_ORG_EXT"."NAME"))',
'INDEX_RS_ASC(@"SEL$1" "T8"@"SEL$1" ("S_ORG_EXT"."PAR_ROW_ID"))',
'INDEX_RS_ASC(@"SEL$1" "T1"@"SEL$1" ("S_ADDR_PER"."ROW_ID"))',
'INDEX_RS_ASC(@"SEL$1" "T26"@"SEL$1" ("S_ORDER_TYPE"."ROW_ID"))',
'INDEX_RS_ASC(@"SEL$1" "T31"@"SEL$1" ("S_ORG_EXT_TNTX"."PAR_ROW_ID" "S_ORG_EXT_TNTX"."CONFLICT_ID"))',
'LEADING(@"SEL$1" "T38"@"SEL$1" "T37"@"SEL$1" "T33"@"SEL$1" "T28"@"SEL$1" "T24"@"SEL$1" "T23"@"SEL$1" "T22"@"SEL$1" "T20"@"SEL$1"',
' "T17"@"SEL$1" "T11"@"SEL$1" "T21"@"SEL$1" "T15"@"SEL$1" "T36"@"SEL$1" "T13"@"SEL$1" "T35"@"SEL$1" "T25"@"SEL$1" "T6"@"SEL$1"',
' "T2"@"SEL$1" "T10"@"SEL$1" "T4"@"SEL$1" "T29"@"SEL$1" "T3"@"SEL$1" "T19"@"SEL$1" "T16"@"SEL$1" "T9"@"SEL$1" "T5"@"SEL$1"',
' "T34"@"SEL$1" "T12"@"SEL$1" "T27"@"SEL$1" "T18"@"SEL$1" "T14"@"SEL$1" "T7"@"SEL$1" "T32"@"SEL$1" "T30"@"SEL$1" "T8"@"SEL$1"',
' "T1"@"SEL$1" "T26"@"SEL$1" "T31"@"SEL$1")',
'USE_NL(@"SEL$1" "T37"@"SEL$1")',
'USE_NL(@"SEL$1" "T33"@"SEL$1")',
'USE_NL(@"SEL$1" "T28"@"SEL$1")',
'USE_NL(@"SEL$1" "T24"@"SEL$1")',
'USE_NL(@"SEL$1" "T23"@"SEL$1")',
'USE_NL(@"SEL$1" "T22"@"SEL$1")',
'USE_NL(@"SEL$1" "T20"@"SEL$1")',
'USE_NL(@"SEL$1" "T17"@"SEL$1")',
'USE_NL(@"SEL$1" "T11"@"SEL$1")',
'USE_NL(@"SEL$1" "T21"@"SEL$1")',
'USE_NL(@"SEL$1" "T15"@"SEL$1")',
'USE_NL(@"SEL$1" "T36"@"SEL$1")',
'USE_NL(@"SEL$1" "T13"@"SEL$1")',
'USE_NL(@"SEL$1" "T35"@"SEL$1")',
'USE_NL(@"SEL$1" "T25"@"SEL$1")',
'USE_NL(@"SEL$1" "T6"@"SEL$1")',
'USE_NL(@"SEL$1" "T2"@"SEL$1")',
'USE_NL(@"SEL$1" "T10"@"SEL$1")',
'USE_NL(@"SEL$1" "T4"@"SEL$1")',
'USE_NL(@"SEL$1" "T29"@"SEL$1")',
'USE_NL(@"SEL$1" "T3"@"SEL$1")',
'USE_NL(@"SEL$1" "T19"@"SEL$1")',
'USE_NL(@"SEL$1" "T16"@"SEL$1")',
'USE_NL(@"SEL$1" "T9"@"SEL$1")',
'USE_NL(@"SEL$1" "T5"@"SEL$1")',
'USE_NL(@"SEL$1" "T34"@"SEL$1")',
'USE_NL(@"SEL$1" "T12"@"SEL$1")',
'USE_NL(@"SEL$1" "T27"@"SEL$1")',
'USE_NL(@"SEL$1" "T18"@"SEL$1")',
'USE_NL(@"SEL$1" "T14"@"SEL$1")',
'USE_NL(@"SEL$1" "T7"@"SEL$1")',
'USE_NL(@"SEL$1" "T32"@"SEL$1")',
'USE_NL(@"SEL$1" "T30"@"SEL$1")',
'USE_NL(@"SEL$1" "T8"@"SEL$1")',
'USE_NL(@"SEL$1" "T1"@"SEL$1")',
'USE_NL(@"SEL$1" "T26"@"SEL$1")',
'USE_NL(@"SEL$1" "T31"@"SEL$1")',
'END_OUTLINE_DATA'
)
);
end;
/
