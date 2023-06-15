create or replace function scmdata.F_NextStartTime(P_StartTime date default sysdate,
                                           p_interval  varchar2 default 'null')
  return date is
  n_time date;
  v_time := P_StartTime;
  v_interval varchar2 := p_interval;
begin



end;



select  to_date('2021-12-05 00:00:00','yyyy-mm-dd hh24:mi:ss') from dual;
select  trunc(last_day(sysdate)+5) from dual;
/

