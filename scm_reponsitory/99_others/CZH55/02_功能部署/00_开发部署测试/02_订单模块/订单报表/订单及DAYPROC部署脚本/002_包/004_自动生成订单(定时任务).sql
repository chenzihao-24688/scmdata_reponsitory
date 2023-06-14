BEGIN
  pkg_run_proc.merge_day_proc(p_seqno     => 10000, --任务号
                              p_sql       => 'begin pkg_day_proc.p_merge_order_dayproc; end;', --执行sql / plsql块
                              p_pause     => 1, --是否启用 1：启用 0：停用
                              p_proc_name => '订单数据表-自动更新', --任务名称 
                              p_remarks   => ''); --备注 

END;
/
DECLARE
  job NUMBER;
BEGIN
  dbms_job.submit(job       => job, /*自动生成JOB_ID*/
                  what      => 'begin pkg_run_proc.run_proc_sql(p_seqno => 10000); end;', /*需要执行的存储过程名称或SQL语句*/
                  next_date => to_date('2021-09-19 00:00:00',
                                       'yyyy-mm-dd hh24:mi:ss'), /*初次执行时间 */
                  INTERVAL  => 'TRUNC(sysdate+1)' /*每天0点执行一次*/);
  COMMIT;
END;
