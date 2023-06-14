DECLARE
  v_sql CLOB;
BEGIN
  v_sql := 'DECLARE
  v_is_sup_exemption     NUMBER;
  v_first_dept_id        VARCHAR2(100);
  v_second_dept_id       VARCHAR2(100);
  v_is_quality           NUMBER;
  v_dept_name            VARCHAR2(100);
  v_progress_update_date DATE;
  vo_forecast_date       DATE;
  vo_forecast_days       INT;
  v_need_comp_id         VARCHAR2(32);
  v_operate_company_id   VARCHAR2(32);
BEGIN
  IF (:old_delay_problem_class_pr IS NOT NULL AND
     :delay_problem_class_pr IS NULL) OR
     (:old_delay_problem_class_pr IS NULL AND
     :delay_problem_class_pr IS NOT NULL) OR
     (:old_responsible_dept_sec IS NULL AND
     :responsible_dept_sec IS NOT NULL) OR (:old_responsible_dept_sec IS NOT NULL AND
     :responsible_dept_sec IS NULL) OR
     (:old_problem_desc_pr IS NOT NULL AND :problem_desc_pr IS NULL) OR
     (:old_delay_problem_class_pr IS NOT NULL AND
     (:old_delay_problem_class_pr <> :delay_problem_class_pr OR
     :old_delay_cause_class_pr <> :delay_cause_class_pr OR
     :old_delay_cause_detailed_pr <> :delay_cause_detailed_pr OR
     :old_problem_desc_pr <> :problem_desc_pr OR
     :old_responsible_dept_sec <> :responsible_dept_sec)) THEN
     
    SELECT MAX(v.operate_company_id)
      INTO v_operate_company_id
      FROM (SELECT t.operate_company_id
              FROM t_plat_log t
             WHERE t.apply_pk_id = :product_gress_id
               AND t.log_type = ''01''
             ORDER BY t.update_time DESC) v
     WHERE rownum = 1;
  
    IF v_operate_company_id IS NOT NULL AND
       v_operate_company_id <> %default_company_id% AND
       :old_delay_problem_class_pr IS NOT NULL THEN
      raise_application_error(-20002,
                              '' 保存失败！延期原因已确定不可修改，如需修改请联系客户跟单。 '');

    END IF;
  END IF;
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
  SELECT t.company_id INTO v_need_comp_id FROM scmdata.t_production_progress t WHERE t.product_gress_id = :product_gress_id;

  scmdata.pkg_production_progress_a.p_forecast_delivery_date(p_progress_id          => :product_gress_id,
                                                             p_company_id           => v_need_comp_id,
                                                             p_progress_status      => :progress_status_pr,
                                                             p_progress_update_date => v_progress_update_date,
                                                             p_plan_date            => :plan_delivery_date,
                                                             p_delivery_date        => :delivery_date_pr,
                                                             p_curlink_complet_prom => round(:curlink_complet_ratio,
                                                                                             2),
                                                             po_forecast_date       => vo_forecast_date,
                                                             po_forecast_days       => vo_forecast_days);

  --修改校验
  scmdata.pkg_production_progress_a.p_check_updprogress(p_item_id               => ''a_product_210'',
                                                        p_company_id            => v_need_comp_id,
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
END;';
  UPDATE bw3.sys_item_list t
     SET t.update_sql = v_sql
   WHERE t.item_id = 'a_product_210';
END;
/
