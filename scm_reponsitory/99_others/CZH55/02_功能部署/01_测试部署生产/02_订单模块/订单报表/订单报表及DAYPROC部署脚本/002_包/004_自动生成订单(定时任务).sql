BEGIN
  pkg_run_proc.merge_day_proc(p_seqno     => 10000, --�����
                              p_sql       => 'begin pkg_day_proc.p_merge_order_dayproc; end;', --ִ��sql / plsql��
                              p_pause     => 1, --�Ƿ����� 1������ 0��ͣ��
                              p_proc_name => '�������ݱ�-�Զ�����', --�������� 
                              p_remarks   => ''); --��ע 

END;
/
DECLARE
  job NUMBER;
BEGIN
  dbms_job.submit(job       => job, /*�Զ�����JOB_ID*/
                  what      => 'begin pkg_run_proc.run_proc_sql(p_seqno => 10000); end;', /*��Ҫִ�еĴ洢�������ƻ�SQL���*/
                  next_date => to_date('2021-09-19 00:00:00',
                                       'yyyy-mm-dd hh24:mi:ss'), /*����ִ��ʱ�� */
                  INTERVAL  => 'TRUNC(sysdate+1)' /*ÿ��0��ִ��һ��*/);
  COMMIT;
END;
