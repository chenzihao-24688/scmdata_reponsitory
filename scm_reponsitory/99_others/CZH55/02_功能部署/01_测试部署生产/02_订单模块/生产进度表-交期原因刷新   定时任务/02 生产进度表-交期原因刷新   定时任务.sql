BEGIN
  pkg_run_proc.merge_day_proc(p_seqno     => 10000, --�����
                              p_sql       => 'begin pkg_day_proc.p_merge_order_dayproc; end;', --ִ��sql / plsql��
                              p_pause     => 1, --�Ƿ����� 1������ 0��ͣ��
                              p_proc_name => '�����ײ����ݱ�-�Զ�����', --�������� 
                              p_remarks   => 'ִ�����ڣ�ÿ����¶����������ݱ�
                                              ����Ƶ�ʣ�ÿ���賿0000����1������
                                              ����˵����ÿ��5��0000���������ݸ������1�Σ��������ٸ��£��������������·��ж��Ƿ�Ϊ�������ݣ�'); --��ע 

END;
/
BEGIN
  pkg_run_proc.merge_day_proc(p_seqno     => 12000, --�����
                              p_sql       => 'begin pkg_day_proc.p_update_product_progress_dayproc; end;', --ִ��sql / plsql��
                              p_pause     => 1, --�Ƿ����� 1������ 0��ͣ��
                              p_proc_name => '�������ȱ�-����ԭ��', --�������� 
                              p_remarks   => 'ִ�����ڣ�ÿ���賿��һ��   �����߼��������������ڡ�2�죬����ԭ��Ϊ��ʱ��Ĭ��Ϊ��������-��������Ӱ��-���������޸ģ���Ϊ��ʱ�򲻸�ֵ��'); --��ע 

END;
/
DECLARE
  job NUMBER;
BEGIN
  dbms_job.submit(job       => job, /*�Զ�����JOB_ID*/
                  what      => 'begin pkg_run_proc.run_proc_sql(p_seqno => 12000); end;', /*��Ҫִ�еĴ洢�������ƻ�SQL���*/
                  next_date => to_date('2021-12-09 00:00:00',
                                       'yyyy-mm-dd hh24:mi:ss'), /*����ִ��ʱ�� */
                  INTERVAL  => 'TRUNC(sysdate+1)' /*ÿ��0��ִ��һ��*/);
  COMMIT;
END;
