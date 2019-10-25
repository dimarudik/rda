col KSPPINM for a40
col KSPPSTVL for a20
col ksppdesc for a50
var HIDDEN_PARAMETER varchar2(256);
exec :HIDDEN_PARAMETER := '&1';
select ksppinm, ksppstvl, ksppdesc from x$ksppi a, x$ksppsv b where a.indx=b.indx and substr(ksppinm,1,1) = '_' and upper(ksppinm) like upper(:HIDDEN_PARAMETER);
