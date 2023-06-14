DECLARE
  job NUMBER;
BEGIN
  dbms_job.submit(job       => job, /*�Զ�����JOB_ID*/
                  what      => 'begin pkg_run_proc.run_proc_sql(p_seqno => 15000); end;', /*��Ҫִ�еĴ洢�������ƻ�SQL���*/
                  next_date => to_date('2022-06-11 00:00:00',
                                       'yyyy-mm-dd hh24:mi:ss'), /*����ִ��ʱ�� */
                  INTERVAL  => 'TRUNC(sysdate,''mi'') + 5 / (24*60)' /*ÿ5����ִ��һ��*/);
  COMMIT;
END;
/
DECLARE
  job NUMBER;
BEGIN
  dbms_job.submit(job       => job, /*�Զ�����JOB_ID*/
                  what      => 'begin pkg_run_proc.run_proc_sql(p_seqno => 16000); end;', /*��Ҫִ�еĴ洢�������ƻ�SQL���*/
                  next_date => to_date('2022-06-11 00:00:00',
                                       'yyyy-mm-dd hh24:mi:ss'), /*����ִ��ʱ�� */
                  INTERVAL  => 'TRUNC(sysdate,''mi'') + 5 / (24*60)' /*ÿ5����ִ��һ��*/);
  COMMIT;
END;
/
DECLARE
  job NUMBER;
BEGIN
  dbms_job.submit(job       => job, /*�Զ�����JOB_ID*/
                  what      => 'begin pkg_run_proc.run_proc_sql(p_seqno => 17000); end;', /*��Ҫִ�еĴ洢�������ƻ�SQL���*/
                  next_date => to_date('2022-06-11 00:00:00',
                                       'yyyy-mm-dd hh24:mi:ss'), /*����ִ��ʱ�� */
                  INTERVAL  => 'TRUNC(sysdate,''mi'') + 5 / (24*60)' /*ÿ5����ִ��һ��*/);
  COMMIT;
END;
