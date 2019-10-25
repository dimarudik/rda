set numwidth 20
col name for a46
select l.addr, a.addr, a.p1, l.name, a.count, 'PARENT' type from v$latch l, (select p1, lpad(trim(to_char(p1,'XXXXXXXXXXX')),16,'0') addr, count(1) count from v$active_session_history where event = 'latch free' group by p1) a where a.addr = l.addr
union all
select l.addr, a.addr, a.p1, l.name, a.count, 'CHILD' type from v$latch_children l, (select p1, lpad(trim(to_char(p1,'XXXXXXXXXXX')),16,'0') addr, count(1) count from v$active_session_history where event = 'latch free' group by p1) a where a.addr = l.addr;
select l.addr, a.addr, a.p1, l.name, a.count, 'PARENT' type from v$latch l, (select p1, lpad(trim(to_char(p1,'XXXXXXXXXXX')),16,'0') addr, count(1) count from dba_hist_active_sess_history where event = 'latch free' group by p1) a where a.addr = l.addr
union all
select l.addr, a.addr, a.p1, l.name, a.count, 'CHILD' type from v$latch_children l, (select p1, lpad(trim(to_char(p1,'XXXXXXXXXXX')),16,'0') addr, count(1) count from dba_hist_active_sess_history where event = 'latch free' group by p1) a where a.addr = l.addr;
