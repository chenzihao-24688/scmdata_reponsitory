--订单交期延期≤2天，延期原因为空时，默认为其他问题-其他问题影响-其他，可修改，不为空时则不赋值；

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
       SET t.delay_problem_class  = '其他问题',
           t.delay_cause_class    = '其他问题影响',
           t.delay_cause_detailed = '其他',
           t.problem_desc         = '其他'
     WHERE t.company_id = 'b6cc680ad0f599cde0531164a8c0337f'
       AND t.progress_status <> '01'
       AND t.actual_delay_day <= 2
       AND t.delay_problem_class IS NULL;
  ELSE
    NULL;
  END IF;
END;
