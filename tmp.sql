var N1 varchar2(256);
var N2 varchar2(256);
var N3 varchar2(256);
var N4 varchar2(256);
var N5 varchar2(256);
exec :N1 := NULL;
exec :N2 := 'Утверждено';
exec :N3 := 'Направлена';
exec :N4 := 'Y';
exec :N5 := 'Y';
SELECT /* rda */
      T3.ROW_ID,
      T2.NAME,
      T1.ROW_ID,
      :N1
   FROM 
       SIEBEL.S_OPTY_X T1,
       SIEBEL.S_STG T2,
       SIEBEL.S_OPTY T3
   WHERE 
      T3.CURR_STG_ID = T2.ROW_ID AND
      T3.ROW_ID = T1.PAR_ROW_ID AND
      (T2.NAME = :N2 AND T3.STATUS_CD = :N3 AND T1.X_EXPORTED_TO_PRIME != :N4 AND T1.X_LOADING_TO_PRIME != :N5 AND NOT ((T1.X_OPTY_TYPE = '020200' OR T1.X_OPTY_TYPE = '210201')));
--SELECT /* rda */
/*      T3.CONFLICT_ID,
      T3.LAST_UPD,
      T3.CREATED,
      T3.LAST_UPD_BY,
      T3.CREATED_BY,
      T3.MODIFICATION_NUM,
      T3.ROW_ID,
      T1.X_OPTY_TYPE,
      T1.X_EXPORTED_TO_PRIME,
      T1.X_LOADING_TO_PRIME,
      T1.X_PREAPPROVE_PROD,
      T2.NAME,
      T3.CURR_STG_ID,
      T3.STATUS_CD,
      T3.BU_ID,
      T1.ROW_ID,
      T1.PAR_ROW_ID,
      T1.MODIFICATION_NUM,
      T1.CREATED_BY,
      T1.LAST_UPD_BY,
      T1.CREATED,
      T1.LAST_UPD,
      T1.CONFLICT_ID,
      T1.PAR_ROW_ID,
      :N1
   FROM
       SIEBEL.S_OPTY_X T1,
       SIEBEL.S_STG T2,
       SIEBEL.S_OPTY T3
   WHERE
      T3.CURR_STG_ID = T2.ROW_ID AND
      T3.ROW_ID = T1.PAR_ROW_ID AND
      (T2.NAME = :N2 AND T3.STATUS_CD = :N3 AND T1.X_EXPORTED_TO_PRIME != :N4 AND T1.X_LOADING_TO_PRIME != :N5 AND NOT ((T1.X_OPTY_TYPE = '020200' OR T1.X_OPTY_TYPE = '210201')));
*/
