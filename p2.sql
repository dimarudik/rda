var FILE_ID number;
var BLOCK_ID number;
exec :FILE_ID := &1;
exec :BLOCK_ID := &2;
select segment_name from dba_extents where file_id = :FILE_ID and :BLOCK_ID between block_id and block_id + blocks - 1 and rownum = 1;
