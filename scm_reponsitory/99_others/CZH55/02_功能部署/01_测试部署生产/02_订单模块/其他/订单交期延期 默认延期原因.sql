--�����������ڡ�2�죬����ԭ��Ϊ��ʱ��Ĭ��Ϊ��������-��������Ӱ��-���������޸ģ���Ϊ��ʱ�򲻸�ֵ��

DECLARE
  v_flag NUMBER;
BEGIN
  SELECT COUNT(1)
    INTO v_flag
    FROM scmdata.t_production_progress t
   WHERE t.company_id = 'b6cc680ad0f599cde0531164a8c0337f'
     AND t.progress_status <> '01'
     AND t.actual_delay_day <= 2
     AND t.delay_problem_class IS NULL
     AND rownum = 1;
  IF v_flag > 0 THEN
    UPDATE scmdata.t_production_progress t
       SET t.delay_problem_class  = '��������',
           t.delay_cause_class    = '��������Ӱ��',
           t.delay_cause_detailed = '����',
           t.problem_desc         = '����'
     WHERE t.company_id = 'b6cc680ad0f599cde0531164a8c0337f'
       AND t.progress_status <> '01'
       AND t.actual_delay_day <= 2
       AND t.delay_problem_class IS NULL;
  ELSE
    NULL;
  END IF;
END;
