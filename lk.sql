set line window
select (select username from gv$session where sid = a.sid) blocker, a.sid bsid, (select serial# from gv$session where sid = a.sid) bserial#, (select status from gv$session where sid = a.sid) b_status, a.type blocker_type, (select username from gv$session where sid = b.sid) blockee, b.sid blockee_sid, a.type blockee_type, (select row_wait_obj# from gv$session where sid = b.sid) row_wait_obj#, (select row_wait_file# from gv$session where sid = b.sid) row_wait_file#, (select row_wait_block# from gv$session where sid = b.sid) row_wait_block#, (select row_wait_row# from gv$session where sid = b.sid) row_wait_row# from gv$lock a, gv$lock b  where a.block = 1 and b.request > 0 and a.id1 = b.id1 and a.id2 = b.id2  order by 1,2;
