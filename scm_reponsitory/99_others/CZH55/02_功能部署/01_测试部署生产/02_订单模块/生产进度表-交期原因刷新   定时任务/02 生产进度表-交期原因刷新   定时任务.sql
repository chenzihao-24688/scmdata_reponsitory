BEGIN
  pkg_run_proc.merge_day_proc(p_seqno     => 10000, --任务号
                              p_sql       => 'begin pkg_day_proc.p_merge_order_dayproc; end;', --执行sql / plsql块
                              p_pause     => 1, --是否启用 1：启用 0：停用
                              p_proc_name => '订单底层数据表-自动更新', --任务名称 
                              p_remarks   => '执行周期：每天更新订单交期数据表
                                              更新频率：每天凌晨0000更新1次数据
                                              更新说明：每月5号0000，上月数据更新最后1次，后续不再更新；（按订单交期月份判断是否为上月数据）'); --备注 

END;
/
BEGIN
  pkg_run_proc.merge_day_proc(p_seqno     => 12000, --任务号
                              p_sql       => 'begin pkg_day_proc.p_update_product_progress_dayproc; end;', --执行sql / plsql块
                              p_pause     => 1, --是否启用 1：启用 0：停用
                              p_proc_name => '生产进度表-交期原因', --任务名称 
                              p_remarks   => '执行周期：每天凌晨跑一次   处理逻辑：订单交期延期≤2天，延期原因为空时，默认为其他问题-其他问题影响-其他，可修改，不为空时则不赋值。'); --备注 

END;
/
DECLARE
  job NUMBER;
BEGIN
  dbms_job.submit(job       => job, /*自动生成JOB_ID*/
                  what      => 'begin pkg_run_proc.run_proc_sql(p_seqno => 12000); end;', /*需要执行的存储过程名称或SQL语句*/
                  next_date => to_date('2021-12-09 00:00:00',
                                       'yyyy-mm-dd hh24:mi:ss'), /*初次执行时间 */
                  INTERVAL  => 'TRUNC(sysdate+1)' /*每天0点执行一次*/);
  COMMIT;
END;
