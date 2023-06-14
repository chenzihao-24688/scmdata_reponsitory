CREATE OR REPLACE PACKAGE pkg_day_proc IS

  -- Author  : SANFU
  -- Created : 2021/9/18 11:01:02
  -- Purpose : ִ�ж�ʱ����
  --�������ݱ�
  --ÿ����¶����������ݱ�
  --����Ƶ�ʣ�ÿ���賿0000����1������
  --����˵����ÿ��5��0000���������ݸ������1�Σ��������ٸ��£��������������·��ж��Ƿ�Ϊ�������ݣ�
  PROCEDURE p_merge_order_dayproc;
END pkg_day_proc;
/
CREATE OR REPLACE PACKAGE BODY pkg_day_proc IS
  --�������ݱ�
  --ÿ����¶����������ݱ�
  --����Ƶ�ʣ�ÿ���賿0000����1������
  --����˵����ÿ��5��0000���������ݸ������1�Σ��������ٸ��£��������������·��ж��Ƿ�Ϊ�������ݣ�
  PROCEDURE p_merge_order_dayproc IS
    v_begin_date DATE;
    v_end_date   DATE;
  BEGIN
    --����1��  
    v_begin_date := trunc(SYSDATE, 'mm');
    --�������һ��
    v_end_date := last_day(SYSDATE);
  
    FOR p_com_rec IN (SELECT fc.company_id FROM scmdata.sys_company fc) LOOP
      pkg_db_job.p_merge_order(p_company_id => p_com_rec.company_id,
                               p_begin_date => v_begin_date,
                               p_end_date   => v_end_date);
    END LOOP;
  END p_merge_order_dayproc;
END pkg_day_proc;
/
