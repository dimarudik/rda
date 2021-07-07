col program for a40
col event for a50
select
    final_blocking_session,
    (select program from v$session s2 where a.final_blocking_session = s2.sid) as program,
    event,
    sess_count
from
(
    select 
        s1.final_blocking_session, 
        s1.event, 
        count(1) sess_count
    from 
        v$session s1 
    where 
        s1.status = 'ACTIVE' and 
        type = 'USER' 
    group by 
        final_blocking_session, 
        event
) a
order by sess_count desc;
