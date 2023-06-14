???prompt Importing table bw3.sys_action...
set feedback off
set define off
insert into bw3.sys_action (ELEMENT_ID, CAPTION, ICON_NAME, ACTION_TYPE, ACTION_SQL, SELECT_FIELDS, REFRESH_FLAG, MULTI_PAGE_FLAG, PRE_FLAG, FILTER_EXPRESS, UPDATE_FIELDS, PORT_ID, PORT_SQL, LOCK_SQL, SELECTION_FLAG, CALL_ID, OPERATE_MODE, PORT_TYPE, QUERY_FIELDS, SELECTION_METHOD)
values ('action_a_product_118_2', '新增交期异常', 'icon-morencaidan', 5, '{DECLARE
  v_sql        CLOB;
  v_data_privs VARCHAR2(2000);
BEGIN
  v_data_privs := pkg_data_privs.parse_json(p_jsonstr => %data_privs_json_strs%,
                                            p_key     => ''COL_2'');
  v_sql        := q''[WITH supp AS
 (SELECT sp.company_id, sp.supplier_code, sp.supplier_company_name
    FROM scmdata.t_supplier_info sp
   WHERE sp.company_id = %default_company_id%),
group_dict AS
 (SELECT group_dict_type, group_dict_value, group_dict_name
    FROM scmdata.sys_group_dict WHERE pause = 0)
SELECT t.product_gress_id,
       t.company_id,
       t.product_gress_code product_gress_code_pr,
       gc.progress_name progress_status_desc,
       t.order_id order_id_pr,
       t.goo_id goo_id_pr,
       cf.rela_goo_id,
       cf.style_number style_number_pr,
       cf.style_name style_name_pr,
       t.supplier_code supplier_code_pr,
       sp2.supplier_company_name supplier_company_name_pr,
       t.factory_code factory_code_pr,
       sp1.supplier_company_name factory_company_name_pr,
       oh.delivery_date delivery_date_pr,
       t.forecast_delivery_date forecast_delivery_date_pr,
       ceil(t.forecast_delivery_date - oh.delivery_date) forecast_delay_day_pr,
       nvl(MAX(od.delivery_date) over(PARTITION BY od.order_id),
           od.delivery_date) latest_planned_delivery_date_pr,
       t.actual_delivery_date actual_delivery_date_pr,
       t.actual_delay_day actual_delay_day_pr,
       t.order_amount order_amount_pr,
       t.delivery_amount delivery_amount_pr,
       decode(sign(t.order_amount - t.delivery_amount),
              -1,
              0,
              t.order_amount - t.delivery_amount) owe_amount_pr,
       ga.group_dict_name approve_edition_pr,
       decode(t.fabric_check,
              ''FABRIC_EVELUATE_PASS'',
              ''通过'',
              ''FABRIC_EVELUATE_NO_PASS'',
              ''不通过'',
              '''') fabric_check_pr,
       decode(t.exception_handle_status,
              ''01'',
              ''处理中'',
              ''02'',
              ''已处理'',
              ''无异常'') exception_handle_status_pr,
       gb.group_dict_name handle_opinions_pr,
       t.progress_status progress_status_pr,
       t.delay_problem_class delay_problem_class_pr,
       t.delay_cause_class delay_cause_class_pr,
       t.delay_cause_detailed delay_cause_detailed_pr,
       t.problem_desc problem_desc_pr,
       t.is_sup_responsible,
       t.responsible_dept,
       t.responsible_dept_sec,
       ''AC_DATE'' anomaly_class_pr
  FROM scmdata.t_ordered oh
 INNER JOIN scmdata.t_orders od
    ON oh.company_id = od.company_id
   AND oh.order_code = od.order_id
   AND oh.order_status <> ''OS02''
 INNER JOIN t_production_progress t
    ON t.company_id = od.company_id
   AND t.order_id = od.order_id
   AND t.goo_id = od.goo_id
   AND t.progress_status NOT IN (''01'', ''03'')
   AND t.delay_problem_class IS NOT NULL
   AND t.delay_cause_class IS NOT NULL
   AND t.delay_cause_detailed IS NOT NULL
   AND t.problem_desc IS NOT NULL
 INNER JOIN scmdata.t_commodity_info cf
    ON t.company_id = cf.company_id
   AND t.goo_id = cf.goo_id
 LEFT JOIN (SELECT a.group_dict_value progress_value,
                    a.group_dict_name  progress_name
               FROM group_dict a
              WHERE a.group_dict_type = ''PROGRESS_TYPE''
                AND a.group_dict_value = ''00''
             UNION ALL
             SELECT pv.progress_value, pv.progress_name
               FROM v_product_progress_status pv
              WHERE pv.company_id = %default_company_id%) gc
    ON gc.progress_value = t.progress_status
  LEFT JOIN supp sp1
    ON t.company_id = sp1.company_id
   AND t.factory_code = sp1.supplier_code
  LEFT JOIN supp sp2
    ON t.company_id = sp2.company_id
   AND t.supplier_code = sp2.supplier_code
  LEFT JOIN group_dict ga
    ON ga.group_dict_type = ''APPROVE_STATUS''
   AND ga.group_dict_value = t.approve_edition
  LEFT JOIN group_dict gb
    ON gb.group_dict_type = ''HANDLE_RESULT''
   AND gb.group_dict_value = t.handle_opinions
 WHERE oh.company_id = %default_company_id%
     AND ((%is_company_admin% = 1) OR  instr_priv(p_str1  => '']'' ||
                  v_data_privs ||
                  q''['',p_str2  => cf.category,p_split => '';'') > 0)]'';
  @strresult   := v_sql;
END;}', null, 1, 1, 0, null, null, null, null, null, 0, null, null, 1, 'product_gress_code_pr,goo_id_pr,rela_goo_id,style_number_pr', null);

insert into bw3.sys_action (ELEMENT_ID, CAPTION, ICON_NAME, ACTION_TYPE, ACTION_SQL, SELECT_FIELDS, REFRESH_FLAG, MULTI_PAGE_FLAG, PRE_FLAG, FILTER_EXPRESS, UPDATE_FIELDS, PORT_ID, PORT_SQL, LOCK_SQL, SELECTION_FLAG, CALL_ID, OPERATE_MODE, PORT_TYPE, QUERY_FIELDS, SELECTION_METHOD)
values ('action_a_product_118_3', '新增质量异常', 'icon-morencaidan', 5, '{DECLARE
  v_sql        CLOB;
  v_data_privs VARCHAR2(2000);
BEGIN
  v_data_privs := pkg_data_privs.parse_json(p_jsonstr => %data_privs_json_strs%,
                                            p_key     => ''COL_2'');
  v_sql        := q''[WITH supp AS
 (SELECT sp.company_id, sp.supplier_code, sp.supplier_company_name
    FROM scmdata.t_supplier_info sp
   WHERE sp.company_id = %default_company_id%),
group_dict AS
 (SELECT group_dict_type, group_dict_value, group_dict_name
    FROM scmdata.sys_group_dict)
SELECT t.product_gress_id,
       t.company_id,
       t.product_gress_code product_gress_code_pr,
       gc.progress_name progress_status_desc,
       t.order_id order_id_pr,
       t.goo_id goo_id_pr,
       cf.rela_goo_id,
       cf.style_number style_number_pr,
       cf.style_name style_name_pr,
       t.supplier_code supplier_code_pr,
       sp2.supplier_company_name supplier_company_name_pr,
       t.factory_code factory_code_pr,
       sp1.supplier_company_name factory_company_name_pr,
       oh.delivery_date delivery_date_pr,
       t.forecast_delivery_date forecast_delivery_date_pr,
       ceil(t.forecast_delivery_date - oh.delivery_date) forecast_delay_day_pr,
       nvl(MAX(od.delivery_date) over(PARTITION BY od.order_id),
           od.delivery_date) latest_planned_delivery_date_pr,
       t.actual_delivery_date actual_delivery_date_pr,
       t.actual_delay_day actual_delay_day_pr,
       t.order_amount order_amount_pr,
       t.delivery_amount delivery_amount_pr,
       decode(sign(t.order_amount - t.delivery_amount),
              -1,
              0,
              t.order_amount - t.delivery_amount) owe_amount_pr,
       ga.group_dict_name approve_edition_pr,
       decode(t.fabric_check,
              ''FABRIC_EVELUATE_PASS'',
              ''通过'',
              ''FABRIC_EVELUATE_NO_PASS'',
              ''不通过'',
              '''') fabric_check_pr,
       decode(t.exception_handle_status,
              ''01'',
              ''处理中'',
              ''02'',
              ''已处理'',
              ''无异常'') exception_handle_status_pr,
       gb.group_dict_name handle_opinions_pr,
       t.progress_status progress_status_pr,
       ''AC_QUALITY'' anomaly_class_pr
  FROM scmdata.t_ordered oh
 INNER JOIN scmdata.t_orders od
    ON oh.company_id = od.company_id
   AND oh.order_code = od.order_id
   AND oh.order_status = ''OS01''
 INNER JOIN t_production_progress t
    ON t.company_id = od.company_id
   AND t.order_id = od.order_id
   AND t.goo_id = od.goo_id
   AND t.progress_status <> ''01''
 INNER JOIN scmdata.t_commodity_info cf
    ON t.company_id = cf.company_id
   AND t.goo_id = cf.goo_id
 LEFT JOIN (SELECT a.group_dict_value progress_value,
                    a.group_dict_name  progress_name
               FROM group_dict a
              WHERE a.group_dict_type = ''PROGRESS_TYPE''
                AND a.group_dict_value = ''00''
             UNION ALL
             SELECT pv.progress_value, pv.progress_name
               FROM v_product_progress_status pv
              WHERE pv.company_id = %default_company_id%) gc
    ON gc.progress_value = t.progress_status
  LEFT JOIN supp sp1
    ON t.company_id = sp1.company_id
   AND t.factory_code = sp1.supplier_code
 INNER JOIN supp sp2
    ON t.company_id = sp2.company_id
   AND t.supplier_code = sp2.supplier_code
  LEFT JOIN group_dict ga
    ON ga.group_dict_type = ''APPROVE_STATUS''
   AND ga.group_dict_value = t.approve_edition
  LEFT JOIN group_dict gb
    ON gb.group_dict_type = ''HANDLE_RESULT''
   AND gb.group_dict_value = t.handle_opinions
 WHERE oh.company_id = %default_company_id%
     AND ((%is_company_admin% = 1) OR  instr_priv(p_str1  => '']'' ||
                  v_data_privs ||
                  q''['',p_str2  => cf.category,p_split => '';'') > 0)]'';
  @strresult   := v_sql;
END;}', null, 1, 1, 0, null, null, null, null, null, 0, null, null, 1, 'product_gress_code_pr,goo_id_pr,rela_goo_id,style_number_pr', null);

insert into bw3.sys_action (ELEMENT_ID, CAPTION, ICON_NAME, ACTION_TYPE, ACTION_SQL, SELECT_FIELDS, REFRESH_FLAG, MULTI_PAGE_FLAG, PRE_FLAG, FILTER_EXPRESS, UPDATE_FIELDS, PORT_ID, PORT_SQL, LOCK_SQL, SELECTION_FLAG, CALL_ID, OPERATE_MODE, PORT_TYPE, QUERY_FIELDS, SELECTION_METHOD)
values ('action_a_product_118_4', '新增其他异常', 'icon-morencaidan', 5, '{DECLARE
  v_sql        CLOB;
  v_data_privs VARCHAR2(2000);
BEGIN
  v_data_privs := pkg_data_privs.parse_json(p_jsonstr => %data_privs_json_strs%,
                                            p_key     => ''COL_2'');
  v_sql        := q''[WITH supp AS
 (SELECT sp.company_id, sp.supplier_code, sp.supplier_company_name
    FROM scmdata.t_supplier_info sp
   WHERE sp.company_id = %default_company_id%),
group_dict AS
 (SELECT group_dict_type, group_dict_value, group_dict_name
    FROM scmdata.sys_group_dict)
SELECT t.product_gress_id,
       t.company_id,
       t.product_gress_code product_gress_code_pr,
       gc.progress_name progress_status_desc,
       t.order_id order_id_pr,
       t.goo_id goo_id_pr, --这里goo_id是货号
       cf.rela_goo_id,
       cf.style_number style_number_pr,
       cf.style_name style_name_pr,
       t.supplier_code supplier_code_pr,
       sp2.supplier_company_name supplier_company_name_pr,
       t.factory_code factory_code_pr,
       sp1.supplier_company_name factory_company_name_pr,
       oh.delivery_date delivery_date_pr,
       t.forecast_delivery_date forecast_delivery_date_pr,
       ceil(t.forecast_delivery_date - oh.delivery_date) forecast_delay_day_pr,
       nvl(MAX(od.delivery_date) over(PARTITION BY od.order_id),
           od.delivery_date) latest_planned_delivery_date_pr,
       t.actual_delivery_date actual_delivery_date_pr,
       t.actual_delay_day actual_delay_day_pr,
       t.order_amount order_amount_pr,
       t.delivery_amount delivery_amount_pr,
       decode(sign(t.order_amount - t.delivery_amount),
              -1,
              0,
              t.order_amount - t.delivery_amount) owe_amount_pr,
       ga.group_dict_name approve_edition_pr,
       decode(t.fabric_check,
              ''FABRIC_EVELUATE_PASS'',
              ''通过'',
              ''FABRIC_EVELUATE_NO_PASS'',
              ''不通过'',
              '''') fabric_check_pr,
       decode(t.exception_handle_status,
              ''01'',
              ''处理中'',
              ''02'',
              ''已处理'',
              ''无异常'') exception_handle_status_pr,
       gb.group_dict_name handle_opinions_pr,
       t.progress_status progress_status_pr,
       ''AC_OTHERS'' anomaly_class_pr,
       NULL delay_problem_class_pr,
       NULL delay_cause_class_pr,
       NULL delay_cause_detailed_pr
  FROM scmdata.t_ordered oh
 INNER JOIN scmdata.t_orders od
    ON oh.company_id = od.company_id
   AND oh.order_code = od.order_id
   AND oh.order_status = ''OS01''
 INNER JOIN t_production_progress t
    ON t.company_id = od.company_id
   AND t.order_id = od.order_id
   AND t.goo_id = od.goo_id
   AND t.progress_status <> ''01''
 INNER JOIN scmdata.t_commodity_info cf
    ON t.company_id = cf.company_id
   AND t.goo_id = cf.goo_id
  LEFT JOIN (SELECT a.group_dict_value progress_value,
                    a.group_dict_name  progress_name
               FROM group_dict a
              WHERE a.group_dict_type = ''PROGRESS_TYPE''
                AND a.group_dict_value = ''00''
             UNION ALL
             SELECT pv.progress_value, pv.progress_name
               FROM v_product_progress_status pv
              WHERE pv.company_id = %default_company_id%) gc
    ON gc.progress_value = t.progress_status
  LEFT JOIN supp sp1
    ON t.company_id = sp1.company_id
   AND t.factory_code = sp1.supplier_code
 INNER JOIN supp sp2
    ON t.company_id = sp2.company_id
   AND t.supplier_code = sp2.supplier_code
  LEFT JOIN group_dict ga
    ON ga.group_dict_type = ''APPROVE_STATUS''
   AND ga.group_dict_value = t.approve_edition
  LEFT JOIN group_dict gb
    ON gb.group_dict_type = ''HANDLE_RESULT''
   AND gb.group_dict_value = t.handle_opinions
 WHERE oh.company_id = %default_company_id%
     AND ((%is_company_admin% = 1) OR  instr_priv(p_str1  => '']'' ||
                  v_data_privs ||
                  q''['',p_str2  => cf.category,p_split => '';'') > 0)]'';
  @strresult   := v_sql;
END;}', null, 1, 1, 0, null, null, null, null, null, 0, null, null, 1, 'product_gress_code_pr,goo_id_pr,rela_goo_id,style_number_pr', null);

prompt Done.
