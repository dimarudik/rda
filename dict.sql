col table_name for a30
col comments for a100
select * from dict where table_name like upper('%&1%') order by 1;
