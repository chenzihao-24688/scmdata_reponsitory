declare
begin
  update scmdata.t_abnormal  a set a.origin='MA' where exists(select 1 from scmdata.t_qc_check qc where qc.qc_check_id=a.origin_id and qc.finish_time is not null) and a.origin='SC';
end;
