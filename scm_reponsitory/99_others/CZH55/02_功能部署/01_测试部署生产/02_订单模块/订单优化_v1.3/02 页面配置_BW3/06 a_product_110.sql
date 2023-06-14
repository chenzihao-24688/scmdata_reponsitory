DECLARE
  v_sql_u    CLOB;
BEGIN
  v_sql_u := 'DECLARE
  v_is_sup_exemption     NUMBER;
  v_first_dept_id        VARCHAR2(100);
  v_second_dept_id       VARCHAR2(100);
  v_is_quality           NUMBER;
  v_dept_name            VARCHAR2(100);
  v_progress_update_date DATE;
  vo_forecast_date       DATE;
  vo_forecast_days       INT;
BEGIN
  --获取进度更新日期
  --判断是否编辑过生产进度状态/当前环节完成比例/生产进度说明
  IF (((:old_progress_status_pr IS NULL AND :progress_status_pr IS NULL) OR
     (:old_progress_status_pr = ''00'' AND :progress_status_pr = ''00'')) AND
     (:old_curlink_complet_ratio IS NULL AND
     :curlink_complet_ratio IS NULL) AND (:old_product_gress_remarks IS NULL AND
     :product_gress_remarks IS NULL)) OR
     ((:old_progress_status_pr IS NOT NULL AND
     :progress_status_pr IS NOT NULL AND
     :old_progress_status_pr = :progress_status_pr) AND
     (:old_curlink_complet_ratio IS NOT NULL AND
     :curlink_complet_ratio IS NOT NULL AND
     :old_curlink_complet_ratio = :curlink_complet_ratio) AND
     (:old_product_gress_remarks IS NOT NULL AND
     :product_gress_remarks IS NOT NULL AND
     :old_product_gress_remarks = :product_gress_remarks)) THEN
    IF ((:old_progress_update_date IS NULL AND
       :progress_update_date IS NULL) OR
       (:old_progress_update_date IS NOT NULL AND
       :progress_update_date IS NOT NULL AND
       :old_progress_update_date = :progress_update_date)) THEN
      v_progress_update_date := :progress_update_date;
    ELSE
      v_progress_update_date := :progress_update_date;
    END IF;
  ELSE
    IF ((:old_progress_update_date IS NULL AND
       :progress_update_date IS NULL) OR
       (:old_progress_update_date IS NOT NULL AND
       :progress_update_date IS NOT NULL AND
       :old_progress_update_date = :progress_update_date)) THEN
      v_progress_update_date := SYSDATE;
    ELSE
      v_progress_update_date := :progress_update_date;
    END IF;
  END IF;
  --预测交期
  scmdata.pkg_production_progress_a.p_forecast_delivery_date(p_progress_id          => :product_gress_id,
                                                             p_company_id           => %default_company_id%,
                                                             p_progress_status      => :progress_status_pr,
                                                             p_progress_update_date => v_progress_update_date,
                                                             p_plan_date            => :plan_delivery_date,
                                                             p_delivery_date        => :delivery_date_pr,
                                                             p_curlink_complet_prom => round(:curlink_complet_ratio,
                                                                                             2),
                                                             po_forecast_date       => vo_forecast_date,
                                                             po_forecast_days       => vo_forecast_days);
  --保存校验                                                          
  scmdata.pkg_production_progress_a.p_check_updprogress(p_item_id               => ''a_product_110'',
                                                        p_company_id            => %default_company_id%,
                                                        p_goo_id                => :goo_id_pr,
                                                        p_delay_problem_class   => :delay_problem_class_pr,
                                                        p_delay_cause_class     => :delay_cause_class_pr,
                                                        p_delay_cause_detailed  => :delay_cause_detailed_pr,
                                                        p_problem_desc          => :problem_desc_pr,
                                                        p_responsible_dept_sec  => :responsible_dept_sec,
                                                        p_progress_status       => :progress_status_pr,
                                                        p_curlink_complet_ratio => :curlink_complet_ratio,
                                                        p_order_rise_status     => :order_rise_status,
                                                        p_progress_update_date  => v_progress_update_date,
                                                        po_is_sup_exemption     => v_is_sup_exemption,
                                                        po_first_dept_id        => v_first_dept_id,
                                                        po_second_dept_id       => v_second_dept_id,
                                                        po_is_quality           => v_is_quality,
                                                        po_dept_name            => v_dept_name);                                                           

  UPDATE scmdata.t_production_progress t
     SET t.delay_problem_class    = :delay_problem_class_pr,
         t.delay_cause_class      = :delay_cause_class_pr,
         t.delay_cause_detailed   = :delay_cause_detailed_pr,
         t.problem_desc           = :problem_desc_pr,
         t.is_sup_responsible     = v_is_sup_exemption,
         t.responsible_dept       = v_first_dept_id,
         t.responsible_dept_sec   = nvl(:responsible_dept_sec,
                                        v_second_dept_id),
         t.is_quality             = v_is_quality,
         t.update_company_id      = %default_company_id%,
         t.update_id              = :user_id,
         t.update_time            = SYSDATE,
         t.progress_status        = :progress_status_pr,
         t.product_gress_remarks  = :product_gress_remarks,
         t.curlink_complet_ratio  = round(:curlink_complet_ratio, 2),
         t.progress_update_date   = v_progress_update_date,
         t.order_rise_status      = :order_rise_status,
         t.plan_delivery_date     = :plan_delivery_date,
         t.forecast_delivery_date = vo_forecast_date,
         t.forecast_delay_day     = vo_forecast_days
   WHERE t.product_gress_id = :product_gress_id;
   --测试环境使用
   --UPDATE scmdata.t_ordered t SET t.delivery_date = :delivery_date_pr WHERE t.company_id = %default_company_id% AND t.order_code = :order_id_pr;
END;';

  UPDATE bw3.sys_item_list t
     SET t.update_sql = v_sql_u,t.noedit_fields = 'DELIVERY_DATE_PR'
   WHERE t.item_id = 'a_product_110';
END;
