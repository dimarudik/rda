set line window
col tracefile for a100
select tracefile from v$process where pname like 'LG%';
