DECLARE
  job NUMBER;
BEGIN
  dbms_job.submit(job       => job, /*自动生成JOB_ID*/
                  what      => 'begin pkg_run_proc.run_proc_sql(p_seqno => 15000); end;', /*需要执行的存储过程名称或SQL语句*/
                  next_date => to_date('2022-06-11 00:00:00',
                                       'yyyy-mm-dd hh24:mi:ss'), /*初次执行时间 */
                  INTERVAL  => 'TRUNC(sysdate,''mi'') + 5 / (24*60)' /*每5分钟执行一次*/);
  COMMIT;
END;
/
DECLARE
  job NUMBER;
BEGIN
  dbms_job.submit(job       => job, /*自动生成JOB_ID*/
                  what      => 'begin pkg_run_proc.run_proc_sql(p_seqno => 16000); end;', /*需要执行的存储过程名称或SQL语句*/
                  next_date => to_date('2022-06-11 00:00:00',
                                       'yyyy-mm-dd hh24:mi:ss'), /*初次执行时间 */
                  INTERVAL  => 'TRUNC(sysdate,''mi'') + 5 / (24*60)' /*每5分钟执行一次*/);
  COMMIT;
END;
/
DECLARE
  job NUMBER;
BEGIN
  dbms_job.submit(job       => job, /*自动生成JOB_ID*/
                  what      => 'begin pkg_run_proc.run_proc_sql(p_seqno => 17000); end;', /*需要执行的存储过程名称或SQL语句*/
                  next_date => to_date('2022-06-11 00:00:00',
                                       'yyyy-mm-dd hh24:mi:ss'), /*初次执行时间 */
                  INTERVAL  => 'TRUNC(sysdate,''mi'') + 5 / (24*60)' /*每5分钟执行一次*/);
  COMMIT;
END;
