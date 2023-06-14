DECLARE
v_sql CLOB;
BEGIN
  v_sql := 'DECLARE
  v_df       VARCHAR2(256) := @deal_follower@;
  v_flw_mana VARCHAR2(256);
BEGIN
  --У�鶩���Ƿ��ѷ��/�ѽ���
  FOR i IN (SELECT t.pt_ordered_id,
                   t.company_id,
                   t.goo_id,
                   t.delay_problem_class,
                   t.delay_cause_class,
                   t.delay_cause_detailed,
                   t.problem_desc,
                   t.responsible_dept_sec
              FROM scmdata.pt_ordered t
             WHERE order_id IN (%selection%)
               AND company_id = %default_company_id%) LOOP
    scmdata.pkg_pt_ordered.p_check_orders(p_pt_ordered_id => i.pt_ordered_id);
  END LOOP;
  --��ȡ��������
  IF v_df IS NOT NULL THEN
    v_flw_mana := scmdata.pkg_db_job.f_get_manager(p_company_id     => %default_company_id%,
                                                   p_user_id        => v_df,
                                                   p_company_job_id => ''1001005003005002'');
  END IF;
  --���¸�������������
  UPDATE scmdata.pt_ordered t
     SET t.flw_order         = v_df,
         t.flw_order_manager = v_flw_mana,
         t.updated_flw       = 1,
         t.update_id         = %current_userid%,
         t.update_time       = SYSDATE
   WHERE order_id IN (%selection%)
     AND company_id = %default_company_id%;
END;';

UPDATE bw3.sys_action t SET t.action_sql = v_sql WHERE t.element_id IN ('action_a_report_120_1'); 
END;
/
