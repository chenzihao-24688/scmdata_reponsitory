DECLARE
  v_sql_s    CLOB;
  v_sql_i    CLOB;
  v_sql_u    CLOB;
  v_sql_d    CLOB;
  v_ns_field CLOB;
  v_nd_field CLOB;
BEGIN
  v_sql_s    := '{DECLARE
  v_class_data_privs CLOB;
  v_sql              CLOB;
BEGIN
  v_class_data_privs := pkg_data_privs.parse_json(p_jsonstr => %data_privs_json_strs%,
                                                  p_key     => ''COL_2'');
  v_sql              := q''[WITH supp AS
 (SELECT sp.company_id, sp.supplier_code, sp.supplier_company_name
    FROM scmdata.t_supplier_info sp),
group_dict AS
 (SELECT group_dict_type, group_dict_value, group_dict_name
    FROM scmdata.sys_group_dict)
SELECT t.product_gress_id,
       t.company_id,
       t.product_gress_code product_gress_code_pr,
       t.progress_status progress_status_pr,
       t.curlink_complet_ratio,
       t.product_gress_remarks,
       t.progress_update_date,
       t.order_rise_status,
       t.order_id order_id_pr,
       cf.rela_goo_id,
       cf.style_number style_number_pr,
       cf.style_name style_name_pr,
       t.supplier_code supplier_code_pr,
       d.company_name customer,
       t.factory_code factory_code_pr,
       sp1.supplier_company_name factory_company_name_pr,
       (SELECT listagg(fu.company_user_name, '';'') within GROUP(ORDER BY oh.deal_follower)
          FROM scmdata.sys_company_user fu
         WHERE instr(oh.deal_follower, fu.user_id) > 0
           AND fu.company_id = oh.company_id) deal_follower,
       oh.delivery_date delivery_date_pr, --update by czh 20210527（1）生产进度表中的订单交期取下单列表的订单交期（即熊猫的交期日期）
       t.forecast_delivery_date forecast_delivery_date_pr,
       ceil(t.forecast_delivery_date - oh.delivery_date) forecast_delay_day_pr,
       MAX(od.delivery_date) over(PARTITION BY od.order_id) latest_planned_delivery_date_pr, --update by czh 20210527（2）生产进度表中的”最新计划完成日期“字段名更改为“最新计划交期”，取下单列表中的最新计划交期（即熊猫的新交货日期）
       t.plan_delivery_date,
       t.actual_delivery_date actual_delivery_date_pr,
       t.actual_delay_day actual_delay_day_pr,
       t.order_amount order_amount_pr,
       t.delivery_amount delivery_amount_pr,
       decode(sign(t.order_amount - t.delivery_amount),
              -1,
              0,
              t.order_amount - t.delivery_amount) owe_amount_pr,    
       t.delay_problem_class delay_problem_class_pr,
       t.delay_cause_class delay_cause_class_pr,
       t.delay_cause_detailed delay_cause_detailed_pr,
       t.problem_desc problem_desc_pr,
       t.is_sup_responsible,
       t.responsible_dept first_dept_id,
       t.responsible_dept_sec,
       t.approve_edition, --Edit by zc
       cf.is_set_fabric,
       t.fabric_check fabric_check,
       t.check_link,
       t.qc_check qc_check_pr,
       t.qa_check qa_check_pr,
       decode(t.exception_handle_status,
              ''01'',
              ''处理中'',
              ''02'',
              ''已处理'',
              ''无异常'') exception_handle_status_pr,
       gd_d.group_dict_name handle_opinions_pr,
       w.picture,
       t.goo_id,
       decode(oh.send_by_sup, 1, ''是'', ''否'') send_by_sup,
       oh.create_time create_time_po,
       oh.memo memo_po,
       a.group_dict_name category,
       b.group_dict_name cooperation_product_cate_sp,
       c.company_dict_name product_subclass_desc,
       oh.finish_time,
       t.update_company_id,
       ucu.company_user_name update_id_pr,
       t.update_time update_date_pr
  FROM scmdata.t_ordered oh
 INNER JOIN (SELECT c.company_id, c.company_name, b.supplier_code
               FROM scmdata.t_supplier_info b
              INNER JOIN scmdata.sys_company c
                 ON b.company_id = c.company_id
              WHERE b.supplier_company_id = %default_company_id%) d
    ON oh.company_id = d.company_id
   AND oh.supplier_code = d.supplier_code
 INNER JOIN scmdata.t_orders od
    ON oh.company_id = od.company_id
   AND oh.order_code = od.order_id
   AND oh.order_status = ''OS01''
   AND oh.is_product_order = 1
 INNER JOIN t_production_progress t
    ON t.company_id = od.company_id
   AND t.order_id = od.order_id
   AND t.goo_id = od.goo_id
   AND t.progress_status <> ''01''
 INNER JOIN scmdata.t_commodity_info cf
    ON t.company_id = cf.company_id
   AND t.goo_id = cf.goo_id
  LEFT JOIN scmdata.t_commodity_picture w
    ON w.goo_id = cf.goo_id
   AND w.company_id = cf.company_id
  LEFT JOIN supp sp1
    ON t.company_id = sp1.company_id
   AND t.factory_code = sp1.supplier_code
  LEFT JOIN group_dict a
    ON a.group_dict_type = ''PRODUCT_TYPE''
   AND a.group_dict_value = cf.category
  LEFT JOIN group_dict b
    ON b.group_dict_type = a.group_dict_value
   AND b.group_dict_value = cf.product_cate
  LEFT JOIN scmdata.sys_company_dict c
    ON c.company_dict_type = b.group_dict_value
   AND c.company_dict_value = cf.samll_category
   AND c.company_id = cf.company_id
  LEFT JOIN group_dict gd_d
    ON gd_d.group_dict_type = ''HANDLE_RESULT''
   AND gd_d.group_dict_value = t.handle_opinions
  LEFT JOIN scmdata.sys_company_user ucu
    ON ucu.company_id = t.update_company_id
   AND ucu.user_id = t.update_id
 WHERE ((%is_company_admin%) = 1 OR
       instr_priv(p_str1  => '']''||v_class_data_privs||q''['',
                   p_str2  => cf.category,
                   p_split => '';'') > 0)
 ORDER BY t.product_gress_code DESC, t.create_time DESC
]'';
  @strresult := v_sql;
END;}';
  v_sql_u    := 'DECLARE
  v_is_sup_exemption     NUMBER;
  v_first_dept_id        VARCHAR2(100);
  v_second_dept_id       VARCHAR2(100);
  v_is_quality           NUMBER;
  v_dept_name            VARCHAR2(100);
  v_progress_update_date DATE;
  vo_forecast_date       DATE;
  vo_forecast_days       INT;
  v_need_comp_id         VARCHAR2(32);
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
    IF :old_update_company_id IS NOT NULL AND
       :old_update_company_id <> %default_company_id% AND
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
  v_ns_field := 'PRODUCT_GRESS_ID,FABRIC_CHECK,COMPANY_ID,SUPPLIER_CODE_PR,FACTORY_CODE_PR,ORDER_ID_PR,PROGRESS_STATUS_PR,QC_CHECK_PR,QA_CHECK_PR,APPROVE_EDITION,IS_SUP_RESPONSIBLE,RESPONSIBLE_DEPT,RESPONSIBLE_DEPT_SEC,CHECK_LINK,CUSTOMER,GOO_ID_PR,ORDER_RISE_STATUS,FIRST_DEPT_ID,RESPONSIBLE_DEPT_SEC';
  v_nd_field := 'DELIVERY_DATE_PR';
  UPDATE bw3.sys_item_list t
     SET t.select_sql    = v_sql_s,
         t.update_sql    = v_sql_u,
         t.noshow_fields = v_ns_field,
         t.noedit_fields = v_nd_field
   WHERE t.item_id = 'a_product_210';
END;
/
DECLARE
  v_sql_s    CLOB;
  v_sql_i    CLOB;
  v_sql_u    CLOB;
  v_sql_d    CLOB;
  v_ns_field CLOB;
  v_nd_field CLOB;
BEGIN
  v_sql_s    := '{DECLARE
  v_class_data_privs CLOB;
  v_sql              CLOB;
BEGIN
  v_class_data_privs := pkg_data_privs.parse_json(p_jsonstr => %data_privs_json_strs%,
                                                  p_key     => ''COL_2'');
  v_sql              := q''[WITH supp AS
 (SELECT sp.company_id, sp.supplier_code, sp.supplier_company_name
    FROM scmdata.t_supplier_info sp),
group_dict AS
 (SELECT group_dict_type, group_dict_value, group_dict_name
    FROM scmdata.sys_group_dict)
SELECT t.product_gress_id,
       t.company_id,
       t.product_gress_code product_gress_code_pr,
       t.progress_status progress_status_pr,
       a.group_dict_name progress_status_desc,
       t.curlink_complet_ratio,
       t.product_gress_remarks,
       t.progress_update_date,
       t.order_rise_status,
       t.order_id order_id_pr,
       cf.rela_goo_id,
       cf.style_number style_number_pr,
       cf.style_name style_name_pr,
       t.supplier_code supplier_code_pr,
       sp2.supplier_company_name supplier_company_name_pr,
       t.factory_code factory_code_pr,
       sp1.supplier_company_name factory_company_name_pr,
       (SELECT listagg(fu.company_user_name, '';'') within GROUP(ORDER BY oh.deal_follower)
          FROM scmdata.sys_company_user fu
         WHERE instr(oh.deal_follower, fu.user_id) > 0
           AND fu.company_id = oh.company_id) deal_follower,
       oh.delivery_date delivery_date_pr,
       oh.finish_time_scm finish_time_scm_pr,
       t.forecast_delivery_date forecast_delivery_date_pr,
       ceil(t.forecast_delivery_date - oh.delivery_date) forecast_delay_day_pr,
       MAX(od.delivery_date) over(PARTITION BY od.order_id) latest_planned_delivery_date_pr,
       t.plan_delivery_date,
       t.actual_delivery_date actual_delivery_date_pr,
       t.actual_delay_day actual_delay_day_pr,
       t.order_amount order_amount_pr,
       t.delivery_amount delivery_amount_pr,
       decode(sign(t.order_amount - t.delivery_amount),
              -1,
              0,
              t.order_amount - t.delivery_amount) owe_amount_pr,
       t.delay_problem_class delay_problem_class_pr,
       t.delay_cause_class delay_cause_class_pr,
       t.delay_cause_detailed delay_cause_detailed_pr,
       t.problem_desc problem_desc_pr,
       t.approve_edition,
       cf.is_set_fabric,
       t.fabric_check fabric_check,
       t.check_link,
       t.qc_check qc_check_pr,
       t.qa_check qa_check_pr,
       decode(t.exception_handle_status,
              ''01'',
              ''处理中'',
              ''02'',
              ''已处理'',
              ''无异常'') exception_handle_status_pr,
       gd.group_dict_name handle_opinions_pr,
       w.picture,
       t.goo_id,
       decode(oh.is_product_order, 1, ''是'', ''否'') is_product_order,
       oh.create_time create_time_po,
       oh.memo memo_po,
       c.group_dict_name category,
       d.group_dict_name cooperation_product_cate_sp,
       e.company_dict_name product_subclass_desc,
       oh.finish_time,
       t.update_company_id,
       ucu.company_user_name update_id_pr,
       t.update_time update_date_pr
  FROM scmdata.t_ordered oh
 INNER JOIN (SELECT c.company_id, c.company_name, b.supplier_code
               FROM scmdata.t_supplier_info b
              INNER JOIN scmdata.sys_company c
                 ON b.company_id = c.company_id
              WHERE b.supplier_company_id = %default_company_id%) d
    ON oh.company_id = d.company_id
   AND oh.supplier_code = d.supplier_code
 INNER JOIN scmdata.t_orders od
    ON oh.company_id = od.company_id
   AND oh.order_code = od.order_id
   AND oh.order_status IN (''OS01'', ''OS02'')
 INNER JOIN t_production_progress t
    ON t.company_id = od.company_id
   AND t.order_id = od.order_id
   AND t.goo_id = od.goo_id
   AND t.progress_status = ''01''
 INNER JOIN scmdata.t_commodity_info cf
    ON t.company_id = cf.company_id
   AND t.goo_id = cf.goo_id
  LEFT JOIN scmdata.t_commodity_picture w
    ON w.goo_id = cf.goo_id
   AND w.company_id = cf.company_id
 INNER JOIN group_dict a
    ON a.group_dict_value = t.progress_status
 INNER JOIN group_dict b
    ON b.group_dict_value = a.group_dict_type
   AND b.group_dict_value = ''PROGRESS_TYPE''
  LEFT JOIN supp sp1
    ON t.company_id = sp1.company_id
   AND t.factory_code = sp1.supplier_code
 INNER JOIN supp sp2
    ON t.company_id = sp2.company_id
   AND t.supplier_code = sp2.supplier_code
  LEFT JOIN group_dict c
    ON c.group_dict_type = ''PRODUCT_TYPE''
   AND c.group_dict_value = cf.category
  LEFT JOIN group_dict d
    ON d.group_dict_type = c.group_dict_value
   AND d.group_dict_value = cf.product_cate
  LEFT JOIN scmdata.sys_company_dict e
    ON e.company_dict_type = d.group_dict_value
   AND e.company_dict_value = cf.samll_category
   AND e.company_id = cf.company_id
  LEFT JOIN group_dict gd
    ON gd.group_dict_type = ''HANDLE_RESULT''
   AND gd.group_dict_value = t.handle_opinions
  LEFT JOIN scmdata.sys_company_user ucu
    ON ucu.company_id = t.update_company_id
   AND ucu.user_id = t.update_id
 WHERE ((%is_company_admin%) = 1 OR
       instr_priv(p_str1  => '']''||v_class_data_privs||q''['',
                   p_str2  => cf.category,
                   p_split => '';'') > 0)
 ORDER BY t.product_gress_code DESC, oh.finish_time_scm DESC
]'';
  @strresult := v_sql;
END;}';

  v_ns_field := 'PRODUCT_GRESS_ID,FABRIC_CHECK,PRODUCT_GRESS_ID,COMPANY_ID,SUPPLIER_CODE_PR,FACTORY_CODE_PR,ORDER_ID_PR,PROGRESS_STATUS_PR,QC_CHECK_PR,QA_CHECK_PR,APPROVE_EDITION,CHECK_LINK,CUSTOMER,GOO_ID_PR,ORDER_RISE_STATUS';

  UPDATE bw3.sys_item_list t
     SET t.select_sql    = v_sql_s,
         t.noshow_fields = v_ns_field
   WHERE t.item_id = 'a_product_216';
END;
/
DECLARE
  v_sql_s    CLOB;
  v_sql_i    CLOB;
  v_sql_u    CLOB;
  v_sql_d    CLOB;
  v_ns_field CLOB;
  v_nd_field CLOB;
BEGIN
  v_sql_s    := '{DECLARE
  v_class_data_privs CLOB;
  v_sql              CLOB;
BEGIN
  v_class_data_privs := pkg_data_privs.parse_json(p_jsonstr => %data_privs_json_strs%,
                                                  p_key     => ''COL_2'');
  v_sql              := q''[WITH supp AS
 (SELECT sp.company_id, sp.supplier_code, sp.supplier_company_name
    FROM scmdata.t_supplier_info sp),
group_dict AS
 (SELECT group_dict_type, group_dict_value, group_dict_name
    FROM scmdata.sys_group_dict)
SELECT t.product_gress_id,
       t.company_id,
       t.product_gress_code product_gress_code_pr,
       t.order_rise_status,
       t.order_id order_id_pr,
       cf.rela_goo_id,
       cf.style_number style_number_pr,
       cf.style_name style_name_pr,
       t.supplier_code supplier_code_pr,
       d.company_name customer,
       t.factory_code factory_code_pr,
       sp1.supplier_company_name factory_company_name_pr,
       (SELECT listagg(fu.company_user_name, '';'') within GROUP(ORDER BY oh.deal_follower)
          FROM scmdata.sys_company_user fu
         WHERE instr(oh.deal_follower, fu.user_id) > 0
           AND fu.company_id = oh.company_id) deal_follower,
       oh.delivery_date delivery_date_pr, --update by czh 20210527（1）生产进度表中的订单交期取下单列表的订单交期（即熊猫的交期日期）
       t.forecast_delivery_date forecast_delivery_date_pr,
       ceil(t.forecast_delivery_date - oh.delivery_date) forecast_delay_day_pr,
       MAX(od.delivery_date) over(PARTITION BY od.order_id) latest_planned_delivery_date_pr, --update by czh 20210527（2）生产进度表中的”最新计划完成日期“字段名更改为“最新计划交期”，取下单列表中的最新计划交期（即熊猫的新交货日期）
       t.plan_delivery_date,
       t.actual_delivery_date actual_delivery_date_pr,
       t.actual_delay_day actual_delay_day_pr,
       t.order_amount order_amount_pr,
       t.delivery_amount delivery_amount_pr,
       decode(sign(t.order_amount - t.delivery_amount),
              -1,
              0,
              t.order_amount - t.delivery_amount) owe_amount_pr,
       t.delay_problem_class delay_problem_class_pr,
       t.delay_cause_class delay_cause_class_pr,
       t.delay_cause_detailed delay_cause_detailed_pr,
       t.problem_desc problem_desc_pr,
       t.approve_edition, --Edit by zc
       cf.is_set_fabric,
       t.fabric_check fabric_check,
       t.check_link,
       t.qc_check qc_check_pr,
       t.qa_check qa_check_pr,
       decode(t.exception_handle_status,
              ''01'',
              ''处理中'',
              ''02'',
              ''已处理'',
              ''无异常'') exception_handle_status_pr,
       gd_d.group_dict_name handle_opinions_pr,
       w.picture,
       t.goo_id,
       decode(oh.send_by_sup, 1, ''是'', ''否'') send_by_sup,
       oh.create_time create_time_po,
       oh.memo memo_po,
       a.group_dict_name category,
       b.group_dict_name cooperation_product_cate_sp,
       c.company_dict_name product_subclass_desc,
       oh.finish_time,
       t.update_company_id,
       ucu.company_user_name update_id_pr,
       t.update_time update_date_pr
  FROM scmdata.t_ordered oh
 INNER JOIN (SELECT c.company_id, c.company_name, b.supplier_code
               FROM scmdata.t_supplier_info b
              INNER JOIN scmdata.sys_company c
                 ON b.company_id = c.company_id
              WHERE b.supplier_company_id = %default_company_id%) d
    ON oh.company_id = d.company_id
   AND oh.supplier_code = d.supplier_code
 INNER JOIN scmdata.t_orders od
    ON oh.company_id = od.company_id
   AND oh.order_code = od.order_id
   AND oh.order_status = ''OS01''
   AND oh.is_product_order = 0
 INNER JOIN t_production_progress t
    ON t.company_id = od.company_id
   AND t.order_id = od.order_id
   AND t.goo_id = od.goo_id
   AND t.progress_status <> ''01''
 INNER JOIN scmdata.t_commodity_info cf
    ON t.company_id = cf.company_id
   AND t.goo_id = cf.goo_id
  LEFT JOIN scmdata.t_commodity_picture w
    ON w.goo_id = cf.goo_id
   AND w.company_id = cf.company_id
  LEFT JOIN supp sp1
    ON t.company_id = sp1.company_id
   AND t.factory_code = sp1.supplier_code
  LEFT JOIN group_dict a
    ON a.group_dict_type = ''PRODUCT_TYPE''
   AND a.group_dict_value = cf.category
  LEFT JOIN group_dict b
    ON b.group_dict_type = a.group_dict_value
   AND b.group_dict_value = cf.product_cate
  LEFT JOIN scmdata.sys_company_dict c
    ON c.company_dict_type = b.group_dict_value
   AND c.company_dict_value = cf.samll_category
   AND c.company_id = cf.company_id
  LEFT JOIN group_dict gd_d
    ON gd_d.group_dict_type = ''HANDLE_RESULT''
   AND gd_d.group_dict_value = t.handle_opinions
  LEFT JOIN scmdata.sys_company_user ucu
    ON ucu.company_id = t.update_company_id
   AND ucu.user_id = t.update_id
 WHERE ((%is_company_admin%) = 1 OR
       instr_priv(p_str1  => '']''||v_class_data_privs||q''['',
                   p_str2  => cf.category,
                   p_split => '';'') > 0)
 ORDER BY t.product_gress_code DESC, t.create_time DESC
]'';
  @strresult := v_sql;
END;}';
  v_sql_u    := 'DECLARE
  v_is_sup_exemption NUMBER;
  v_first_dept_id    VARCHAR2(100);
  v_second_dept_id   VARCHAR2(100);
  v_is_quality       NUMBER;
  v_dept_name        VARCHAR2(100);
  v_need_comp_id     VARCHAR2(32);
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
    IF :old_update_company_id IS NOT NULL AND
       :old_update_company_id <> %default_company_id% AND
       :old_delay_problem_class_pr IS NOT NULL THEN
      raise_application_error(-20002,
                              '' 保存失败！延期原因已确定不可修改，如需修改请联系客户跟单。 '');
    END IF;
  END IF;

  SELECT t.company_id INTO v_need_comp_id FROM scmdata.t_production_progress t WHERE t.product_gress_id = :product_gress_id;
  
  --修改校验
  scmdata.pkg_production_progress_a.p_check_updprogress(p_item_id               => 'a_product_217',
                                                        p_company_id            => v_need_comp_id,
                                                        p_goo_id                => :goo_id_pr,
                                                        p_delay_problem_class   => :delay_problem_class_pr,
                                                        p_delay_cause_class     => :delay_cause_class_pr,
                                                        p_delay_cause_detailed  => :delay_cause_detailed_pr,
                                                        p_problem_desc          => :problem_desc_pr,
                                                        p_responsible_dept_sec  => :responsible_dept_sec,
                                                        --p_progress_status       => :progress_status_pr,
                                                        p_curlink_complet_ratio => :curlink_complet_ratio,
                                                        p_order_rise_status     => :order_rise_status,
                                                        --p_progress_update_date  => v_progress_update_date,
                                                        po_is_sup_exemption     => v_is_sup_exemption,
                                                        po_first_dept_id        => v_first_dept_id,
                                                        po_second_dept_id       => v_second_dept_id,
                                                        po_is_quality           => v_is_quality,
                                                        po_dept_name            => v_dept_name);
  UPDATE scmdata.t_production_progress t
     SET t.delay_problem_class  = :delay_problem_class_pr,
         t.delay_cause_class    = :delay_cause_class_pr,
         t.delay_cause_detailed = :delay_cause_detailed_pr,
         t.problem_desc         = :problem_desc_pr,
         t.is_sup_responsible   = v_is_sup_exemption,
         t.responsible_dept     = v_first_dept_id,
         t.responsible_dept_sec = nvl(:responsible_dept_sec,
                                      v_second_dept_id),
         t.is_quality           = v_is_quality,
         t.update_company_id    = %default_company_id%,
         t.update_id            = :user_id,
         t.update_time          = SYSDATE,
         t.order_rise_status    = :order_rise_status,
         t.plan_delivery_date   = :plan_delivery_date
   WHERE t.product_gress_id = :product_gress_id;
END;';
  v_ns_field := 'PRODUCT_GRESS_ID,FABRIC_CHECK,COMPANY_ID,SUPPLIER_CODE_PR,FACTORY_CODE_PR,ORDER_ID_PR,PROGRESS_STATUS_PR,QC_CHECK_PR,QA_CHECK_PR,APPROVE_EDITION,CHECK_LINK,PROGRESS_STATUS_DESC,IS_SET_FABRIC,FABRIC_CHECK_PR,LAST_CHECK_LINK_DESC,QC_CHECK_PR,QA_CHECK_PR,EXCEPTION_HANDLE_STATUS_PR,HANDLE_OPINIONS_PR,CUSTOMER,GOO_ID_PR,ORDER_RISE_STATUS';
  v_nd_field := 'DELIVERY_DATE_PR';
  UPDATE bw3.sys_item_list t
     SET t.select_sql    = v_sql_s,
         t.update_sql    = v_sql_u,
         t.delete_sql    = v_sql_d,
         t.noshow_fields = v_ns_field,
         t.noedit_fields = v_nd_field
   WHERE t.item_id = 'a_product_217';
END;
/
BEGIN
  insert into bw3.sys_element (ELEMENT_ID, ELEMENT_TYPE, DATA_SOURCE, PAUSE, MESSAGE, IS_HIDE, MEMO, IS_ASYNC, IS_PER_EXE, ENABLE_STAND_PERMISSION)
values ('look_a_product_210_10', 'lookup', 'oracle_scmdata', 0, null, null, null, null, null, null);
insert into bw3.sys_look_up (ELEMENT_ID, FIELD_NAME, LOOK_UP_SQL, DATA_TYPE, KEY_FIELD, RESULT_FIELD, BEFORE_FIELD, SEARCH_FLAG, MULTI_VALUE_FLAG, DISABLED_FIELD, GROUP_FIELD, VALUE_SEP, ICON, PORT_ID, PORT_SQL)
values ('look_a_product_210_10', 'PROGRESS_STATUS_DESC', '{DECLARE
  v_sql             CLOB;
  v_cate            VARCHAR2(2000);
  v_pcate           VARCHAR2(2000);
  v_scate           VARCHAR2(2000);
  v_need_company_id VARCHAR2(32);
BEGIN
  SELECT DISTINCT oh.company_id
    INTO v_need_company_id
    FROM scmdata.t_ordered oh
   INNER JOIN (SELECT c.company_id, c.company_name, b.supplier_code
                 FROM scmdata.t_supplier_info b
                INNER JOIN scmdata.sys_company c
                   ON b.company_id = c.company_id
                WHERE b.supplier_company_id = %default_company_id%) d
      ON oh.company_id = d.company_id
     AND oh.supplier_code = d.supplier_code;
  
   v_sql := q''[SELECT a.group_dict_value progress_status_pr,
                     a.group_dict_name  progress_status_desc
               FROM scmdata.sys_group_dict a
              WHERE a.group_dict_type = ''PROGRESS_TYPE''
               AND a.group_dict_value in( ''00'',''01'')
              UNION ALL
             SELECT pv.progress_value progress_status_pr,
                    pv.progress_name  progress_status_desc
              FROM v_product_progress_status pv
            WHERE pv.company_id = '']'' || v_need_company_id || q''['']'';

  IF :product_gress_id IS NOT NULL THEN
    SELECT MAX(a.category), MAX(a.product_cate), MAX(a.samll_category)
      INTO v_cate, v_pcate, v_scate
      FROM scmdata.t_production_progress t
     INNER JOIN scmdata.t_commodity_info a
        ON a.goo_id = t.goo_id
       AND a.company_id = t.company_id
     WHERE t.product_gress_id = :product_gress_id;
  
    v_sql := q''[SELECT a.progress_node_name PROGRESS_STATUS_PR, a.progress_node_desc PROGRESS_STATUS_DESC
    FROM scmdata.t_progress_range_config t
   INNER JOIN scmdata.t_progress_node_config a
      ON a.progress_config_id = t.progress_config_id
     AND a.company_id = t.company_id
     AND a.pause = 0
     AND t.pause = 0
   WHERE t.industry_classification = '']'' || v_cate || q''[''
     AND t.production_category = '']'' || v_pcate || q''[''
     AND instr(t.product_subclass, '']'' || v_scate ||
             q''['') > 0
     AND t.company_id = '']'' || v_need_company_id || q''[''
   ORDER BY a.progress_node_name ASC]'';
  END IF;
  @strresult := v_sql;
END;}', '1', 'PROGRESS_STATUS_PR', 'PROGRESS_STATUS_DESC', 'PROGRESS_STATUS_PR', 1, 0, null, null, null, null, null, null);
insert into bw3.sys_item_element_rela (ITEM_ID, ELEMENT_ID, SEQ_NO, PAUSE, LEVEL_NO)
values ('a_product_210', 'look_a_product_210_10', 1, 0, null);

END;
/
BEGIN
  UPDATE bw3.sys_pivot_list t
     SET t.row_fields    = 'anomaly_class_name,category_name,product_subclass_name,problem_class,cause_class,abn_sum_propotion,abn_money',
         t.column_fields = 'handle_opinions_name',
         t.value_fields  = 'abn_money'
   WHERE t.pivot_id = 'p_a_report_abn_101';
END;
/
BEGIN
  UPDATE bw3.sys_pivot_list t
     SET t.row_fields    = 'category_name,deal_follower_name,sup_cnt,owe_goo_cnt,owe_amount',
         t.column_fields = 'progress_status_desc',
         t.value_fields  = 'pst_cnt'
   WHERE t.pivot_id = 'p_a_report_prostatus_100';
END;
