--1.业务报表生成逻辑，统一写至pkg_db_job
--2.执行任务，处理逻辑，统一写至pkg_day_proc
--3.统一将执行任务记录至 scmdata.t_day_proc表
BEGIN
  pkg_run_proc.merge_day_proc(p_seqno     => 10000, --任务号
                              p_sql       => 'begin pkg_day_proc.p_merge_order_dayproc; end;', --执行sql / plsql块
                              p_pause     => 1, --是否启用 1：启用 0：停用
                              p_proc_name => '订单数据表-自动更新', --任务名称 
                              p_remarks   => ''); --备注 

END;
--4.定时任务，what=》'begin pkg_run_proc.run_proc_sql(p_seqno => 10000); end;’ 
--统一调用pkg_run_proc.run_proc_sql，参数p_seqno为：执行相应任务号
--该过程将记录定时任务的执行日志
--相关表：任务执行表： scmdata.t_day_proc;  日志表： scmdata.t_log;
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
--5.查看定时任务
SELECT * FROM user_jobs;
--执行任务
select * from scmdata.t_day_proc;
--执行日志
select * from scmdata.t_log;

begin dbms_job.interval(job => 21,interval=>'TRUNC(sysdate,''mi'') + 3/ (24*60)'); end;


--任务模拟执行
begin pkg_run_proc.run_proc_sql(p_seqno => 10000); end;
begin pkg_run_proc.run_proc_sql(p_seqno => 10001); end;
