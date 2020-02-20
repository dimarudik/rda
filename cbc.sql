col cbc_latches heading 'CBC Latch|Count'
col buffers heading 'Buffer Cache|Buffers'
col min_nuffers_per_latch heading 'Min Buffer|Per Latch'
col max_buffers_per_latch heading 'Max Buffer|Per Latch'
col avg_buffer_per_latch heading 'Avg Buffer|Per Latch'
select
	count(distinct l.addr) cbc_latches,
	sum(count(*)) buffers,
	min(count(*)) min_nuffers_per_latch,
	max(count(*)) max_buffers_per_latch,
	round(avg(count(*))) avg_buffer_per_latch
from
	x$bh b,
	v$latch_children l
where
	l.addr = b.hladdr and
	l.name = 'cache buffers chains'
group by
	l.addr;
