col force_matching_signature for 999999999999999999999999
select
	force_matching_signature,
	N
from
(
select 
	force_matching_signature, 
	count(1) N
from 
	v$sqlarea 
where
	force_matching_signature > 0
group by 
	force_matching_signature 
order by 
	2 desc
)
where
	rownum <= 30
order by
	N;
