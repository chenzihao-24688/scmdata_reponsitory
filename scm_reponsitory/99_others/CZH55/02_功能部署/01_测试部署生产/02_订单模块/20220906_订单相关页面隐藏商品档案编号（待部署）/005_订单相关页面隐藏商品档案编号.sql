BEGIN
 UPDATE bw3.sys_element t SET t.is_hide = 1 WHERE t.element_id = 'asso_a_good_201_1';  
END;
/
DECLARE
v_sql CLOB;
BEGIN
  v_sql := 'PRODUCT_GRESS_ID,COMPANY_ID,SUPPLIER_CODE_PR,FACTORY_CODE_PR,ORDER_ID_PR,ABNORMAL_ID_PR,ABNORMAL_STATUS_PR,IS_DEDUCTION_PR,HANDLE_OPINIONS_PR,ANOMALY_CLASS_PR,RESPONSIBLE_PARTY_PR,DEDUCTION_METHOD_PR,ABN_RANGE,PROGRESS_STATUS_PR,FIRST_DEPT_ID,SECOND_DEPT_ID,GOO_ID_PR,GOO_ID';
UPDATE bw3.sys_item_list t SET t.noshow_fields = v_sql WHERE t.item_id = 'a_product_118';
END;
/
DECLARE
v_sql CLOB;
BEGIN
  v_sql := 'ABNORMAL_ID,ANOMALY_CLASS_PR,PRODUCT_GRESS_ID,COMPANY_ID,SUPPLIER_CODE_PR,FACTORY_CODE_PR,ORDER_ID_PR,ABNORMAL_STATUS_PR,HANDLE_OPINIONS_PR,IS_DEDUCTION_PR,CONFIRM_ID,CONFIRM_DATE,DEDUCTION_METHOD_PR,RESPONSIBLE_PARTY_PR,ABN_RANGE,PROGRESS_STATUS_PR,FIRST_DEPT_ID,SECOND_DEPT_ID,GOO_ID_PR,GOO_ID';
UPDATE bw3.sys_item_list t SET t.noshow_fields = v_sql WHERE t.item_id = 'a_product_120_1';
END;
/
DECLARE
v_sql CLOB;
BEGIN
  v_sql := 'ANOMALY_CLASS_PR,PRODUCT_GRESS_ID,COMPANY_ID,SUPPLIER_CODE_PR,FACTORY_CODE_PR,ORDER_ID_PR,ABNORMAL_ID,ABNORMAL_STATUS_PR,HANDLE_OPINIONS_PR,IS_DEDUCTION_PR,ABN_RANGE,PROGRESS_STATUS_PR,FIRST_DEPT_ID,SECOND_DEPT_ID,GOO_ID_PR,GOO_ID';
UPDATE bw3.sys_item_list t SET t.noshow_fields = v_sql WHERE t.item_id = 'a_product_120_2';
END;
/
DECLARE
v_sql CLOB;
BEGIN
  v_sql := 'PRODUCT_GRESS_ID,FABRIC_CHECK,COMPANY_ID,SUPPLIER_CODE_PR,FACTORY_CODE_PR,ORDER_ID_PR,QC_CHECK_PR,QA_CHECK_PR,APPROVE_EDITION,CHECK_LINK,CATEGORY_CODE,FIRST_DEPT_ID,RESPONSIBLE_DEPT_SEC,GOO_ID_PR,PROGRESS_STATUS_PR,ORDER_RISE_STATUS,UPDATE_COMPANY_ID,UPDATE_ID_PR,UPDATE_DATE_PR,GROUP_NAME,GOO_ID_PR,GOO_ID';
UPDATE bw3.sys_item_list t SET t.noshow_fields = v_sql WHERE t.item_id = 'a_product_110';
END;
/
DECLARE
v_sql CLOB;
BEGIN
  v_sql := 'PRODUCT_GRESS_ID,FABRIC_CHECK,COMPANY_ID,SUPPLIER_CODE_PR,FACTORY_CODE_PR,ORDER_ID_PR,PROGRESS_STATUS_PR,QC_CHECK_PR,QA_CHECK_PR,APPROVE_EDITION,CHECK_LINK,CATEGORY_CODE,FIRST_DEPT_ID,RESPONSIBLE_DEPT_SEC,PRODUCT_GRESS_REMARKS,PROGRESS_STATUS_DESC,IS_SET_FABRIC,FABRIC_CHECK_PR,LAST_CHECK_LINK_DESC,QC_CHECK_PR,QA_CHECK_PR,EXCEPTION_HANDLE_STATUS_PR,HANDLE_OPINIONS_PR,GOO_ID_PR,ORDER_RISE_STATUS,UPDATE_COMPANY_ID,UPDATE_ID_PR,UPDATE_DATE_PR,GROUP_NAME,GOO_ID_PR,GOO_ID';
UPDATE bw3.sys_item_list t SET t.noshow_fields = v_sql WHERE t.item_id = 'a_product_150';
END;
/
DECLARE
v_sql CLOB;
BEGIN
  v_sql := 'PRODUCT_GRESS_ID,FABRIC_CHECK,COMPANY_ID,SUPPLIER_CODE_PR,FACTORY_CODE_PR,ORDER_ID_PR,PROGRESS_STATUS_PR,QC_CHECK_PR,QA_CHECK_PR,APPROVE_EDITION,IS_SUP_RESPONSIBLE,FIRST_DEPT_ID,RESPONSIBLE_DEPT_SEC,CHECK_LINK,CATEGORY_CODE,GOO_ID_PR,ORDER_RISE_STATUS,UPDATE_COMPANY_ID,UPDATE_ID_PR,UPDATE_DATE_PR,GROUP_NAME,GOO_ID_PR,GOO_ID';
UPDATE bw3.sys_item_list t SET t.noshow_fields = v_sql WHERE t.item_id = 'a_product_116';
END;
/
DECLARE
v_sql CLOB;
BEGIN
  v_sql := 'PRODUCT_GRESS_ID,FABRIC_CHECK,PRODUCT_GRESS_ID,COMPANY_ID,SUPPLIER_CODE_PR,SUPPLIER_COMPANY_NAME_PR,FACTORY_CODE_PR,ORDER_ID_PR,PROGRESS_STATUS_PR,QC_CHECK_PR,QA_CHECK_PR,APPROVE_EDITION,CHECK_LINK,CUSTOMER,GOO_ID_PR,ORDER_RISE_STATUS,GOO_ID_PR,GOO_ID';
UPDATE bw3.sys_item_list t SET t.noshow_fields = v_sql WHERE t.item_id = 'a_product_216';
END;
/
DECLARE
v_sql1 CLOB;
v_sql2 CLOB;
BEGIN
  v_sql1 := 'PRODUCT_GRESS_ID,FABRIC_CHECK,COMPANY_ID,SUPPLIER_CODE_PR,FACTORY_CODE_PR,ORDER_ID_PR,PROGRESS_STATUS_PR,QC_CHECK_PR,QA_CHECK_PR,APPROVE_EDITION,IS_SUP_RESPONSIBLE,RESPONSIBLE_DEPT,RESPONSIBLE_DEPT_SEC,CHECK_LINK,CUSTOMER,GOO_ID_PR,ORDER_RISE_STATUS,FIRST_DEPT_ID,RESPONSIBLE_DEPT_SEC,GOO_ID';
  v_sql2 := '{DECLARE
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
       t.goo_id goo_id_pr,
       t.goo_id,
       --20220720 增加是否首单 修改人：lsl167
       (case when oh.isfirstordered  = 1 then ''是'' when oh.isfirstordered = 0 then ''否'' end) IS_FIRST_ORDER,
       --end
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
UPDATE bw3.sys_item_list t SET t.noshow_fields = v_sql1,t.select_sql = v_sql2 WHERE t.item_id = 'a_product_210';
END;
/
DECLARE
v_sql1 CLOB;
v_sql2 CLOB;
BEGIN
  v_sql1 := 'PRODUCT_GRESS_ID,FABRIC_CHECK,COMPANY_ID,SUPPLIER_CODE_PR,FACTORY_CODE_PR,ORDER_ID_PR,PROGRESS_STATUS_PR,QC_CHECK_PR,QA_CHECK_PR,APPROVE_EDITION,CHECK_LINK,PROGRESS_STATUS_DESC,IS_SET_FABRIC,FABRIC_CHECK_PR,LAST_CHECK_LINK_DESC,QC_CHECK_PR,QA_CHECK_PR,EXCEPTION_HANDLE_STATUS_PR,HANDLE_OPINIONS_PR,CUSTOMER,GOO_ID_PR,ORDER_RISE_STATUS,GOO_ID';
  v_sql2 := '{DECLARE
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
       t.goo_id goo_id_pr,
       t.goo_id,
       --20220720 增加是否首单 修改人：lsl167
       (case when oh.isfirstordered  = 1 then ''是'' when oh.isfirstordered = 0 then ''否'' end) IS_FIRST_ORDER,
       --end
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
UPDATE bw3.sys_item_list t SET t.noshow_fields = v_sql1,t.select_sql = v_sql2 WHERE t.item_id = 'a_product_217';
END;
/
