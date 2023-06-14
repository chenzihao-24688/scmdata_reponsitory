DECLARE
  v_sql_s    CLOB;
  v_sql_i    CLOB;
  v_sql_u    CLOB;
  v_sql_d    CLOB;
  v_ns_field CLOB;
  v_nd_field CLOB;
BEGIN
  v_sql_s := 'SELECT a.progress_node_config_id,
       a.pause,
       a.progress_config_id,
       a.progress_node_num,
       a.progress_node_name,
       a.progress_node_desc,
       a.time_ratio,
       cua.company_user_name     creator,
       a.create_time,
       cub.company_user_name     updator,
       a.update_time
  FROM scmdata.t_progress_node_config a
 INNER JOIN sys_company_user cua
    ON a.create_id = cua.user_id
   AND a.company_id = cua.company_id
 INNER JOIN sys_company_user cub
    ON a.update_id = cub.user_id
   AND a.company_id = cub.company_id
 WHERE a.progress_config_id = :progress_config_id
 ORDER BY a.progress_node_num ASC';
  v_sql_i := 'DECLARE
  p_id VARCHAR2(32);
BEGIN
  p_id := f_get_uuid();

  INSERT INTO t_progress_node_config
    (progress_node_config_id,
     company_id,
     progress_config_id,
     progress_node_num,
     progress_node_name,
     progress_node_desc,
     time_ratio,
     pause,
     create_id,
     create_time,
     update_id,
     update_time,
     memo)
  VALUES
    (p_id,
     %default_company_id%,
     :progress_config_id,
     :progress_node_num,
     :progress_node_name,
     :progress_node_desc,
     :time_ratio,
     0,
     :user_id,
     SYSDATE,
     :user_id,
     SYSDATE,
     NULL);

  --czh add 校验逻辑
  scmdata.pkg_a_config_lib.p_check_pnode_config(p_company_id              => %default_company_id%,
                                                p_progress_config_id      => :progress_config_id,
                                                p_progress_node_config_id => nvl(:progress_node_config_id,p_id),
                                                p_node_name               => :progress_node_name);

END;';
  v_sql_u := 'BEGIN
  UPDATE t_progress_node_config a
     SET a.progress_node_num  = :progress_node_num,
         a.progress_node_name = :progress_node_name,
         a.progress_node_desc = :progress_node_desc,
         a.time_ratio         = :time_ratio,
         a.update_id          = :user_id,
         a.update_time        = SYSDATE
   WHERE a.progress_node_config_id = :progress_node_config_id;

  --czh add 校验逻辑
  scmdata.pkg_a_config_lib.p_check_pnode_config(p_company_id              => %default_company_id%,
                                                p_progress_config_id      => :progress_config_id,
                                                p_progress_node_config_id => :progress_node_config_id,
                                                p_node_name               => :progress_node_name);
END;';
  v_sql_d := 'BEGIN
  DELETE FROM t_progress_node_config
   WHERE progress_node_config_id = :progress_node_config_id;
  scmdata.pkg_a_config_lib.p_recalculate_node_order_num(pi_progress_config_id => :progress_config_id);
END;';                                              
  v_ns_field := 'pause,progress_node_config_id,progress_config_id,progress_node_name';
  UPDATE bw3.sys_item_list t
     SET t.select_sql    = v_sql_s,
         t.insert_sql    = v_sql_i,
         t.update_sql    = v_sql_u,
         t.delete_sql    = v_sql_d,
         t.noshow_fields = v_ns_field
   WHERE t.item_id = 'a_config_121_2';
END;
/
BEGIN
insert into bw3.sys_element (ELEMENT_ID, ELEMENT_TYPE, DATA_SOURCE, PAUSE, MESSAGE, IS_HIDE, MEMO, IS_ASYNC, IS_PER_EXE, ENABLE_STAND_PERMISSION)
values ('look_a_config_121_2', 'lookup', 'oracle_scmdata', 0, null, null, null, null, null, null);
insert into bw3.sys_look_up (ELEMENT_ID, FIELD_NAME, LOOK_UP_SQL, DATA_TYPE, KEY_FIELD, RESULT_FIELD, BEFORE_FIELD, SEARCH_FLAG, MULTI_VALUE_FLAG, DISABLED_FIELD, GROUP_FIELD, VALUE_SEP, ICON, PORT_ID, PORT_SQL)
values ('look_a_config_121_2', 'PROGRESS_NODE_DESC', '{DECLARE
  v_sql CLOB;
BEGIN
  v_sql := q''[SELECT b.company_dict_name category,c.company_dict_value progress_node_name,
       c.company_dict_name  progress_node_desc
  FROM scmdata.sys_group_dict a
 INNER JOIN scmdata.sys_company_dict b
    ON b.company_dict_type = a.group_dict_value
 INNER JOIN scmdata.sys_company_dict c
    ON c.company_dict_type = b.company_dict_value
   AND c.company_id = b.company_id
 WHERE a.group_dict_type = ''PROGRESS_TYPE''
   AND a.group_dict_value = ''02''
   AND b.company_id = %default_company_id%
  ORDER BY c.company_dict_value asc]'';

  IF :progress_config_id IS NOT NULL THEN
    v_sql := q''[SELECT b.company_dict_name category,c.company_dict_value progress_node_name,
       c.company_dict_name  progress_node_desc
  FROM scmdata.sys_group_dict a
 INNER JOIN scmdata.sys_company_dict b
    ON b.company_dict_type = a.group_dict_value
 INNER JOIN (SELECT DISTINCT d.industry_classification category
               FROM scmdata.t_progress_range_config d
              INNER JOIN scmdata.t_progress_node_config e
                 ON e.progress_config_id = d.progress_config_id
                 and e.company_id = d.company_id
              WHERE e.progress_config_id = :progress_config_id)
    ON substr(b.company_dict_value, 3, 4) = category
 INNER JOIN scmdata.sys_company_dict c
    ON c.company_dict_type = b.company_dict_value
   AND c.company_id = b.company_id
 WHERE a.group_dict_type = ''PROGRESS_TYPE''
   AND a.group_dict_value = ''02''
   AND b.company_id = %default_company_id%
 ORDER BY c.company_dict_value asc]'';
  END IF;
  @strresult := v_sql;
END;
}
/*
SELECT c.company_dict_value progress_node_name,
       c.company_dict_name  progress_node_desc
  FROM scmdata.sys_group_dict a
 INNER JOIN scmdata.sys_company_dict b
    ON b.company_dict_type = a.group_dict_value
 INNER JOIN (SELECT DISTINCT d.industry_classification category
               FROM scmdata.t_progress_range_config d
              INNER JOIN scmdata.t_progress_node_config e
                 ON e.progress_config_id = d.progress_config_id
                AND e.company_id = d.company_id
              WHERE e.progress_config_id = :progress_config_id)
    ON substr(b.company_dict_value, 3, 4) = category
 INNER JOIN scmdata.sys_company_dict c
    ON c.company_dict_type = b.company_dict_value
   AND c.company_id = b.company_id
 WHERE a.group_dict_type = ''PROGRESS_TYPE''
   AND a.group_dict_value = ''02''
   AND b.company_id = %default_company_id%
*/', '1', 'PROGRESS_NODE_NAME', 'PROGRESS_NODE_DESC', 'PROGRESS_NODE_NAME', 1, 0, null, 'CATEGORY', null, null, null, null);
insert into bw3.sys_item_element_rela (ITEM_ID, ELEMENT_ID, SEQ_NO, PAUSE, LEVEL_NO)
values ('a_config_121_2', 'look_a_config_121_2', 1, 0, null);

END;
/
--新增修改日志
BEGIN
insert into bw3.sys_item (ITEM_ID, ITEM_TYPE, CAPTION_SQL, DATA_SOURCE, BASE_TABLE, KEY_FIELD, NAME_FIELD, SETTING_ID, REPORT_TITLE, SUB_SCRIPTS, PAUSE, LINK_FIELD, HELP_ID, TAG_ID, CONFIG_PARAMS, TIME_OUT, OFFLINE_FLAG, PANEL_ID, INIT_SHOW, BADGE_FLAG, BADGE_SQL, MEMO, SHOW_ROWID, ENABLE_STAND_PERMISSION, FIX_CAPTION)
values ('a_order_201_10', 'list', '修改日志', 'oracle_scmdata', null, null, null, 'a_order_201_10', null, null, 0, null, null, null, null, null, null, null, null, null, null, null, null, 1, null);

insert into bw3.sys_tree_list (NODE_ID, TREE_ID, ITEM_ID, PARENT_ID, VAR_ID, APP_ID, ICON_NAME, IS_END, STAND_PRIV_FLAG, SEQ_NO, PAUSE, TERMINAL_FLAG, CAPTION_EXPLAIN, COMPETENCE_FLAG, NODE_TYPE, IS_AUTHORIZE, ENABLE_STAND_PERMISSION)
values ('node_a_order_201_10', 'tree_a_order', 'a_order_201_10', null, null, 'scm', null, null, null, 1, 0, 0, null, null, 1, 1, null);

insert into bw3.sys_item_list (ITEM_ID, QUERY_TYPE, QUERY_FIELDS, QUERY_COUNT, EDIT_EXPRESS, NEWID_SQL, SELECT_SQL, DETAIL_SQL, SUBSELECT_SQL, INSERT_SQL, UPDATE_SQL, DELETE_SQL, NOSHOW_FIELDS, NOADD_FIELDS, NOMODIFY_FIELDS, NOEDIT_FIELDS, SUBNOSHOW_FIELDS, UI_TMPL, MULTI_PAGE_FLAG, OUTPUT_PARAMETER, LOCK_SQL, MONITOR_ID, END_FIELD, EXECUTE_TIME, SCANNABLE_FIELD, SCANNABLE_TYPE, AUTO_REFRESH, RFID_FLAG, SCANNABLE_TIME, MAX_ROW_COUNT, NOSHOW_APP_FIELDS, SCANNABLE_LOCATION_LINE, SUB_TABLE_JUDGE_FIELD, BACK_GROUND_ID, OPRETION_HINT, SUB_EDIT_STATE, HINT_TYPE, HEADER, FOOTER, JUMP_FIELD, JUMP_EXPRESS, OPEN_MODE, OPERATION_TYPE, OPERATE_TYPE, PAGE_SIZES)
values ('a_order_201_10', null, null, null, null, null, '{DECLARE
  v_sql CLOB;
BEGIN
  v_sql      := scmdata.pkg_plat_comm.f_query_t_plat_log(p_apply_pk_id =>  :ORDER_ID,p_dict_type => ''ORDER_LOG'');
  @strresult := v_sql;
END;}', null, null, null, null, null, 'ORDERED_ID,ORDERS_ID,ORDER_ID,LOG_ID,COMPANY_ID', null, null, null, null, null, 2, null, null, null, null, null, null, null, 1, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, 0, null);

insert into bw3.sys_item_rela (ITEM_ID, RELATE_ID, RELATE_TYPE, SEQ_NO, PAUSE)
values ('a_order_201_0', 'a_order_201_10', 'S', 2, 0);

insert into bw3.sys_item_rela (ITEM_ID, RELATE_ID, RELATE_TYPE, SEQ_NO, PAUSE)
values ('a_order_201_1', 'a_order_201_10', 'S', 2, 0);

insert into bw3.sys_item_rela (ITEM_ID, RELATE_ID, RELATE_TYPE, SEQ_NO, PAUSE)
values ('a_order_101_1', 'a_order_201_10', 'S', 2, 0);

insert into bw3.sys_item_rela (ITEM_ID, RELATE_ID, RELATE_TYPE, SEQ_NO, PAUSE)
values ('a_order_201_4', 'a_order_201_10', 'S', 2, 0);

insert into bw3.sys_item_rela (ITEM_ID, RELATE_ID, RELATE_TYPE, SEQ_NO, PAUSE)
values ('a_order_101_0', 'a_order_201_10', 'S', 2, 0);

insert into bw3.sys_item_rela (ITEM_ID, RELATE_ID, RELATE_TYPE, SEQ_NO, PAUSE)
values ('a_order_101_3', 'a_order_201_10', 'S', 2, 0);

END;
/
--旧日志禁用
BEGIN
UPDATE bw3.sys_item_rela t SET t.pause = 1 WHERE t.relate_id = 'a_order_201_3';
END;
/
DECLARE
  v_sql_s    CLOB;
  v_sql_i    CLOB;
  v_sql_u    CLOB;
  v_ns_field CLOB;
  v_nd_field CLOB;
BEGIN
  v_sql_s := '{DECLARE
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
       sp2.supplier_company_name supplier_company_name_pr,
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
       t.is_sup_responsible,
       t.responsible_dept first_dept_id,
       sd.dept_name responsible_dept,
       t.responsible_dept_sec,
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
       t.goo_id goo_id_pr, --这里goo_id是货号
       t.goo_id,
       decode(oh.send_by_sup, 1, ''是'', ''否'') send_by_sup,
       oh.create_time create_time_po,
       oh.memo memo_po,
       cf.category category_code,
       a.group_dict_name category,
       b.group_dict_name cooperation_product_cate_sp,
       c.company_dict_name product_subclass_desc,
       oh.finish_time,
       t.update_company_id,
       ucu.company_user_name update_id_pr,
       t.update_time update_date_pr,
       CASE
         WHEN (t.actual_delay_day > 0 OR
              (t.actual_delay_day = 0 AND
              trunc(SYSDATE) - trunc(oh.delivery_date) > 0 AND
              (t.delivery_amount / t.order_amount) <= CASE
                WHEN cf.category = ''07'' THEN
                 0.86
                WHEN cf.category = ''06'' THEN
                 0.92
                ELSE
                 0.80
              END)) AND t.delay_problem_class IS NULL THEN
          10090495
         ELSE
          NULL
       END gridbackcolor
  FROM scmdata.t_ordered oh
 INNER JOIN scmdata.t_orders od
    ON oh.company_id = od.company_id
   AND oh.order_code = od.order_id
   AND oh.order_status = ''OS01'' --待修改
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
    ON cf.goo_id = w.goo_id
   AND cf.company_id = w.company_id
  LEFT JOIN supp sp1
    ON t.company_id = sp1.company_id
   AND t.factory_code = sp1.supplier_code
 INNER JOIN supp sp2
    ON t.company_id = sp2.company_id
   AND t.supplier_code = sp2.supplier_code
  LEFT JOIN group_dict a
    ON a.group_dict_type = ''PRODUCT_TYPE''
   AND a.group_dict_value = cf.category
  LEFT JOIN group_dict b
    ON b.group_dict_type = a.group_dict_value
   AND b.group_dict_value = cf.product_cate
  LEFT JOIN scmdata.sys_company_dict c
    ON c.company_dict_type = b.group_dict_value
   AND c.company_dict_value = cf.samll_category
   AND c.company_id = %default_company_id%
  LEFT JOIN scmdata.sys_company_dept sd
    ON sd.company_id = t.company_id
   AND sd.company_dept_id = t.responsible_dept
  LEFT JOIN group_dict gd_d
    ON gd_d.group_dict_type = ''HANDLE_RESULT''
   AND gd_d.group_dict_value = t.handle_opinions
  LEFT JOIN scmdata.sys_company_user ucu
    ON ucu.company_id = t.update_company_id
   AND ucu.user_id = t.update_id
 WHERE oh.company_id = %default_company_id%
   AND ((%is_company_admin%) = 1 OR
       instr_priv(p_str1  => '']'' ||
                        v_class_data_privs || q''['',
                   p_str2  => cf.category,
                   p_split => '';'') > 0)
 ORDER BY t.product_gress_code DESC, t.create_time DESC
]'';

  @strresult := v_sql;
END;}';
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
   
   UPDATE scmdata.t_ordered t SET t.delivery_date = :delivery_date_pr WHERE t.company_id = %default_company_id% AND t.order_code = :order_id_pr;

END;';
  v_ns_field := 'PRODUCT_GRESS_ID,FABRIC_CHECK,COMPANY_ID,SUPPLIER_CODE_PR,FACTORY_CODE_PR,ORDER_ID_PR,QC_CHECK_PR,QA_CHECK_PR,APPROVE_EDITION,CHECK_LINK,CATEGORY_CODE,FIRST_DEPT_ID,RESPONSIBLE_DEPT_SEC,GOO_ID_PR,PROGRESS_STATUS_PR,ORDER_RISE_STATUS,UPDATE_COMPANY_ID,UPDATE_ID_PR,UPDATE_DATE_PR';

  UPDATE bw3.sys_item_list t
     SET t.select_sql    = v_sql_s,
         t.update_sql    = v_sql_u,
         t.noshow_fields = v_ns_field
   WHERE t.item_id = 'a_product_110';
END;
/
DECLARE
  v_sql_s    CLOB;
  v_sql_i    CLOB;
  v_sql_u    CLOB;
  v_ns_field CLOB;
  v_nd_field CLOB;
BEGIN
  v_sql_s := '{DECLARE
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
       oh.delivery_date delivery_date_pr, --update by czh 20210527（1）生产进度表中的订单交期取下单列表的订单交期（即熊猫的交期日期）
       oh.finish_time_scm finish_time_scm_pr,
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
       t.is_sup_responsible,
       t.responsible_dept first_dept_id,
       t.responsible_dept_sec,
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
       decode(oh.send_by_sup, 1, ''是'', ''否'') send_by_sup,
       decode(oh.is_product_order, 1, ''是'', ''否'') is_product_order,
       oh.create_time create_time_po,
       oh.memo memo_po,
       cf.category category_code,
       c.group_dict_name category,
       d.group_dict_name cooperation_product_cate_sp,
       e.company_dict_name product_subclass_desc,
       oh.finish_time,
       oh.finish_time_scm,
       su.nick_name finish_id_pr,
       decode(oh.finish_type, ''01'', ''自动结束'', ''手动结束'') finish_type,
       t.update_company_id,
       ucu.company_user_name update_id_pr,
       t.update_time update_date_pr
  FROM scmdata.t_ordered oh
 INNER JOIN scmdata.t_orders od
    ON oh.company_id = od.company_id
   AND oh.order_code = od.order_id
   AND oh.order_status IN (''OS01'', ''OS02'') --待修改
 INNER JOIN t_production_progress t
    ON t.company_id = od.company_id
   AND t.order_id = od.order_id
   AND t.goo_id = od.goo_id
   AND t.progress_status = ''01''
 INNER JOIN group_dict a
    ON a.group_dict_type = ''PROGRESS_TYPE''
   AND a.group_dict_value = t.progress_status
 INNER JOIN scmdata.t_commodity_info cf
    ON t.company_id = cf.company_id
   AND t.goo_id = cf.goo_id
  LEFT JOIN scmdata.t_commodity_picture w
    ON cf.goo_id = w.goo_id
   AND cf.company_id = w.company_id
  LEFT JOIN supp sp1
    ON t.company_id = sp1.company_id
   AND t.factory_code = sp1.supplier_code
 INNER JOIN supp sp2
    ON t.company_id = sp2.company_id
   AND t.supplier_code = sp2.supplier_code
  LEFT JOIN scmdata.sys_user su
    ON su.user_id = oh.finish_id
  LEFT JOIN group_dict c
    ON c.group_dict_type = ''PRODUCT_TYPE''
   AND c.group_dict_value = cf.category
  LEFT JOIN group_dict d
    ON d.group_dict_type = c.group_dict_value
   AND d.group_dict_value = cf.product_cate
  LEFT JOIN scmdata.sys_company_dict e
    ON e.company_dict_type = d.group_dict_value
   AND e.company_dict_value = cf.samll_category
   AND e.company_id = %default_company_id%
  LEFT JOIN group_dict gd_d
    ON gd_d.group_dict_type = ''HANDLE_RESULT''
   AND gd_d.group_dict_value = t.handle_opinions
  LEFT JOIN scmdata.sys_company_user ucu
    ON ucu.company_id = t.update_company_id
   AND ucu.user_id = t.update_id
 WHERE oh.company_id = %default_company_id%
   AND ((%is_company_admin%) = 1 OR
       instr_priv(p_str1  => '']'' ||
                        v_class_data_privs || q''['',
                   p_str2  => cf.category,
                   p_split => '';'') > 0)
 ORDER BY t.product_gress_code DESC, oh.finish_time_scm DESC
]'';
  @strresult         := v_sql;
END;
}';
  v_ns_field := 'PRODUCT_GRESS_ID,FABRIC_CHECK,COMPANY_ID,SUPPLIER_CODE_PR,FACTORY_CODE_PR,ORDER_ID_PR,PROGRESS_STATUS_PR,QC_CHECK_PR,QA_CHECK_PR,APPROVE_EDITION,IS_SUP_RESPONSIBLE,FIRST_DEPT_ID,RESPONSIBLE_DEPT_SEC,CHECK_LINK,CATEGORY_CODE,GOO_ID_PR,ORDER_RISE_STATUS,UPDATE_COMPANY_ID,UPDATE_ID_PR,UPDATE_DATE_PR';
  UPDATE bw3.sys_item_list t
     SET t.select_sql    = v_sql_s,
         t.noshow_fields = v_ns_field
   WHERE t.item_id = 'a_product_116';
END;
/
DECLARE
  v_sql_s    CLOB;
  v_sql_i    CLOB;
  v_sql_u    CLOB;
  v_ns_field CLOB;
  v_nd_field CLOB;
BEGIN
  v_sql_s := '{DECLARE
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
       sp2.supplier_company_name supplier_company_name_pr,
       t.factory_code factory_code_pr,
       sp1.supplier_company_name factory_company_name_pr,
       (SELECT listagg(fu.company_user_name, '';'') within GROUP(ORDER BY oh.deal_follower)
          FROM scmdata.sys_company_user fu
         WHERE instr(oh.deal_follower, fu.user_id) > 0
           AND fu.company_id = oh.company_id) deal_follower,
       oh.delivery_date delivery_date_pr, --update by czh 20210527（1）生产进度表中的订单交期取下单列表的订单交期（即熊猫的交期日期）
       MAX(od.delivery_date) over(PARTITION BY od.order_id) latest_planned_delivery_date_pr, --update by czh 20210527（2）生产进度表中的”最新计划完成日期“字段名更改为“最新计划交期”，取下单列表中的最新计划交期（即熊猫的新交货日期）
       t.plan_delivery_date,
       t.forecast_delivery_date forecast_delivery_date_pr,
       ceil(t.forecast_delivery_date - oh.delivery_date) forecast_delay_day_pr,
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
       t.is_sup_responsible,
       t.responsible_dept first_dept_id,
       sd.dept_name responsible_dept,
       t.responsible_dept_sec,
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
       t.goo_id goo_id_pr, --这里goo_id是货号
       t.goo_id,
       decode(oh.send_by_sup, 1, ''是'', ''否'') send_by_sup,
       oh.create_time create_time_po,
       oh.memo memo_po,
       cf.category category_code,
       a.group_dict_name category,
       b.group_dict_name cooperation_product_cate_sp,
       c.company_dict_name product_subclass_desc,
       oh.finish_time,
       t.update_company_id,
       ucu.company_user_name update_id_pr,
       t.update_time update_date_pr,
       CASE
         WHEN (t.actual_delay_day > 0 OR
              (t.actual_delay_day = 0 AND
              trunc(SYSDATE) - trunc(oh.delivery_date) > 0 AND
              (t.delivery_amount / t.order_amount) <= CASE
                WHEN cf.category = ''07'' THEN
                 0.86
                WHEN cf.category = ''06'' THEN
                 0.92
                ELSE
                 0.80
              END)) AND t.delay_problem_class IS NULL THEN
          10090495
         ELSE
          NULL
       END gridbackcolor
  FROM scmdata.t_ordered oh
 INNER JOIN scmdata.t_orders od
    ON oh.company_id = od.company_id
   AND oh.order_code = od.order_id
   AND oh.order_status = ''OS01'' --待修改
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
    ON cf.goo_id = w.goo_id
   AND cf.company_id = w.company_id
  LEFT JOIN supp sp1
    ON t.company_id = sp1.company_id
   AND t.factory_code = sp1.supplier_code
 INNER JOIN supp sp2
    ON t.company_id = sp2.company_id
   AND t.supplier_code = sp2.supplier_code
  LEFT JOIN group_dict a
    ON a.group_dict_type = ''PRODUCT_TYPE''
   AND a.group_dict_value = cf.category
  LEFT JOIN group_dict b
    ON b.group_dict_type = a.group_dict_value
   AND b.group_dict_value = cf.product_cate
  LEFT JOIN scmdata.sys_company_dict c
    ON c.company_dict_type = b.group_dict_value
   AND c.company_dict_value = cf.samll_category
   AND c.company_id = %default_company_id%
  LEFT JOIN scmdata.sys_company_dept sd
    ON sd.company_id = t.company_id
   AND sd.company_dept_id = t.responsible_dept
  LEFT JOIN group_dict gd_d
    ON gd_d.group_dict_type = ''HANDLE_RESULT''
   AND gd_d.group_dict_value = t.handle_opinions
  LEFT JOIN scmdata.sys_company_user ucu
    ON ucu.company_id = t.update_company_id
   AND ucu.user_id = t.update_id
 WHERE oh.company_id = %default_company_id%
   AND ((%is_company_admin%) = 1 OR
       instr_priv(p_str1  => '']'' ||
                        v_class_data_privs ||
                        q''['',
                   p_str2  => cf.category,
                   p_split => '';'') > 0)
 ORDER BY t.product_gress_code DESC, t.create_time DESC
]'';

  @strresult := v_sql;
END;}';
  v_sql_u := 'DECLARE
  v_is_sup_exemption     NUMBER;
  v_first_dept_id        VARCHAR2(100);
  v_second_dept_id       VARCHAR2(100);
  v_is_quality           NUMBER;
  v_dept_name            VARCHAR2(100);
BEGIN
   --保存校验
  scmdata.pkg_production_progress_a.p_check_updprogress(p_item_id               => 'a_product_150',
                                                        p_company_id            => %default_company_id%,
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
         t.order_rise_status      = :order_rise_status,
         t.plan_delivery_date     = :plan_delivery_date
   WHERE t.product_gress_id = :product_gress_id;
   
 UPDATE scmdata.t_ordered t SET t.delivery_date = :delivery_date_pr WHERE t.company_id = %default_company_id% AND t.order_code = :order_id_pr;

END;';
  v_ns_field := 'PRODUCT_GRESS_ID,FABRIC_CHECK,COMPANY_ID,SUPPLIER_CODE_PR,FACTORY_CODE_PR,ORDER_ID_PR,PROGRESS_STATUS_PR,QC_CHECK_PR,QA_CHECK_PR,APPROVE_EDITION,CHECK_LINK,CATEGORY_CODE,FIRST_DEPT_ID,RESPONSIBLE_DEPT_SEC,PRODUCT_GRESS_REMARKS,PROGRESS_STATUS_DESC,IS_SET_FABRIC,FABRIC_CHECK_PR,LAST_CHECK_LINK_DESC,QC_CHECK_PR,QA_CHECK_PR,EXCEPTION_HANDLE_STATUS_PR,HANDLE_OPINIONS_PR,GOO_ID_PR,ORDER_RISE_STATUS,UPDATE_COMPANY_ID,UPDATE_ID_PR,UPDATE_DATE_PR';
  v_nd_field := 'DELIVERY_DATE_PR';
  UPDATE bw3.sys_item_list t
     SET t.select_sql    = v_sql_s,
         t.update_sql    = v_sql_u,
         t.noshow_fields = v_ns_field,
         t.noedit_fields = v_nd_field
   WHERE t.item_id = 'a_product_150';
END;
/
BEGIN
insert into bw3.sys_item (ITEM_ID, ITEM_TYPE, CAPTION_SQL, DATA_SOURCE, BASE_TABLE, KEY_FIELD, NAME_FIELD, SETTING_ID, REPORT_TITLE, SUB_SCRIPTS, PAUSE, LINK_FIELD, HELP_ID, TAG_ID, CONFIG_PARAMS, TIME_OUT, OFFLINE_FLAG, PANEL_ID, INIT_SHOW, BADGE_FLAG, BADGE_SQL, MEMO, SHOW_ROWID, ENABLE_STAND_PERMISSION, FIX_CAPTION)
values ('a_product_111_2', 'list', '进度跟进日志', 'oracle_scmdata', null, null, null, 'a_product_111_2', null, null, 0, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into bw3.sys_item_list (ITEM_ID, QUERY_TYPE, QUERY_FIELDS, QUERY_COUNT, EDIT_EXPRESS, NEWID_SQL, SELECT_SQL, DETAIL_SQL, SUBSELECT_SQL, INSERT_SQL, UPDATE_SQL, DELETE_SQL, NOSHOW_FIELDS, NOADD_FIELDS, NOMODIFY_FIELDS, NOEDIT_FIELDS, SUBNOSHOW_FIELDS, UI_TMPL, MULTI_PAGE_FLAG, OUTPUT_PARAMETER, LOCK_SQL, MONITOR_ID, END_FIELD, EXECUTE_TIME, SCANNABLE_FIELD, SCANNABLE_TYPE, AUTO_REFRESH, RFID_FLAG, SCANNABLE_TIME, MAX_ROW_COUNT, NOSHOW_APP_FIELDS, SCANNABLE_LOCATION_LINE, SUB_TABLE_JUDGE_FIELD, BACK_GROUND_ID, OPRETION_HINT, SUB_EDIT_STATE, HINT_TYPE, HEADER, FOOTER, JUMP_FIELD, JUMP_EXPRESS, OPEN_MODE, OPERATION_TYPE, OPERATE_TYPE, PAGE_SIZES)
values ('a_product_111_2', 2, null, null, null, null, '{DECLARE
  v_sql CLOB;
BEGIN
  v_sql      := scmdata.pkg_plat_comm.f_query_t_plat_log(p_apply_pk_id =>  :PRODUCT_GRESS_ID,p_dict_type => ''PROGRESS_LOG'');
  @strresult := v_sql;
END;}', null, null, null, null, null, null, null, null, null, null, null, 1, null, null, null, null, null, null, null, 3, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, 0, null);

insert into bw3.sys_item_rela (ITEM_ID, RELATE_ID, RELATE_TYPE, SEQ_NO, PAUSE)
values ('a_product_110', 'a_product_111_2', 'S', 2, 0);

insert into bw3.sys_item_rela (ITEM_ID, RELATE_ID, RELATE_TYPE, SEQ_NO, PAUSE)
values ('a_product_116', 'a_product_111_2', 'S', 2, 0);

insert into bw3.sys_item_rela (ITEM_ID, RELATE_ID, RELATE_TYPE, SEQ_NO, PAUSE)
values ('a_product_150', 'a_product_111_2', 'S', 2, 0);

insert into bw3.sys_item_rela (ITEM_ID, RELATE_ID, RELATE_TYPE, SEQ_NO, PAUSE)
values ('a_product_210', 'a_product_111_2', 'S', 2, 0);

insert into bw3.sys_item_rela (ITEM_ID, RELATE_ID, RELATE_TYPE, SEQ_NO, PAUSE)
values ('a_product_216', 'a_product_111_2', 'S', 2, 0);

insert into bw3.sys_item_rela (ITEM_ID, RELATE_ID, RELATE_TYPE, SEQ_NO, PAUSE)
values ('a_product_217', 'a_product_111_2', 'S', 2, 0);

UPDATE bw3.sys_item_rela t SET t.pause = 1 WHERE t.relate_id = 'a_product_111_1';
END;
/
BEGIN
insert into bw3.sys_element (ELEMENT_ID, ELEMENT_TYPE, DATA_SOURCE, PAUSE, MESSAGE, IS_HIDE, MEMO, IS_ASYNC, IS_PER_EXE, ENABLE_STAND_PERMISSION)
values ('look_a_product_110_10', 'lookup', 'oracle_scmdata', 0, null, null, null, null, null, null);

insert into bw3.sys_element (ELEMENT_ID, ELEMENT_TYPE, DATA_SOURCE, PAUSE, MESSAGE, IS_HIDE, MEMO, IS_ASYNC, IS_PER_EXE, ENABLE_STAND_PERMISSION)
values ('look_a_product_110_11', 'lookup', 'oracle_scmdata', 0, null, null, null, null, null, null);

insert into bw3.sys_element (ELEMENT_ID, ELEMENT_TYPE, DATA_SOURCE, PAUSE, MESSAGE, IS_HIDE, MEMO, IS_ASYNC, IS_PER_EXE, ENABLE_STAND_PERMISSION)
values ('look_a_product_110_12', 'lookup', 'oracle_scmdata', 0, null, null, null, null, null, null);

insert into bw3.sys_look_up (ELEMENT_ID, FIELD_NAME, LOOK_UP_SQL, DATA_TYPE, KEY_FIELD, RESULT_FIELD, BEFORE_FIELD, SEARCH_FLAG, MULTI_VALUE_FLAG, DISABLED_FIELD, GROUP_FIELD, VALUE_SEP, ICON, PORT_ID, PORT_SQL)
values ('look_a_product_110_10', 'PROGRESS_STATUS_DESC', '{DECLARE
  v_sql   CLOB;
  v_cate  VARCHAR2(2000);
  v_pcate VARCHAR2(2000);
  v_scate VARCHAR2(2000);
BEGIN
  v_sql := q''[SELECT a.group_dict_value progress_status_pr,
                     a.group_dict_name  progress_status_desc
               FROM scmdata.sys_group_dict a
              WHERE a.group_dict_type = ''PROGRESS_TYPE''
               AND a.group_dict_value in( ''00'',''01'')
              UNION ALL
             SELECT pv.progress_value progress_status_pr,
                    pv.progress_name  progress_status_desc
              FROM v_product_progress_status pv
            WHERE pv.company_id = %default_company_id%]'';

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
     AND t.company_id = %default_company_id%
   ORDER BY a.progress_node_num ASC]'';
  END IF;
  @strresult := v_sql;
END;
}', '1', 'PROGRESS_STATUS_PR', 'PROGRESS_STATUS_DESC', 'PROGRESS_STATUS_PR', 1, 0, null, null, null, null, null, null);

insert into bw3.sys_look_up (ELEMENT_ID, FIELD_NAME, LOOK_UP_SQL, DATA_TYPE, KEY_FIELD, RESULT_FIELD, BEFORE_FIELD, SEARCH_FLAG, MULTI_VALUE_FLAG, DISABLED_FIELD, GROUP_FIELD, VALUE_SEP, ICON, PORT_ID, PORT_SQL)
values ('look_a_product_110_11', 'ORDER_RISE_STATUS_DESC', 'SELECT t.group_dict_value order_rise_status,
       t.group_dict_name  order_rise_status_desc
  FROM scmdata.sys_group_dict t
 WHERE t.group_dict_type = ''ORDER_RISE_STATUS''', '1', 'ORDER_RISE_STATUS', 'ORDER_RISE_STATUS_DESC', 'ORDER_RISE_STATUS', 1, 0, null, null, null, null, null, null);

insert into bw3.sys_look_up (ELEMENT_ID, FIELD_NAME, LOOK_UP_SQL, DATA_TYPE, KEY_FIELD, RESULT_FIELD, BEFORE_FIELD, SEARCH_FLAG, MULTI_VALUE_FLAG, DISABLED_FIELD, GROUP_FIELD, VALUE_SEP, ICON, PORT_ID, PORT_SQL)
values ('look_a_product_110_12', 'PROGRESS_STATUS_DESC', 'SELECT a.group_dict_value progress_status_pr,
       a.group_dict_name  progress_status_desc
  FROM scmdata.sys_group_dict a
 WHERE a.group_dict_type = ''PROGRESS_TYPE''
   AND a.group_dict_value IN (''00'', ''01'')
UNION ALL
SELECT pv.progress_value progress_status_pr,
       pv.progress_name  progress_status_desc
  FROM v_product_progress_status pv
 WHERE pv.company_id = %default_company_id%', '1', 'PROGRESS_STATUS_PR', 'PROGRESS_STATUS_DESC', 'PROGRESS_STATUS_PR', 1, 0, null, null, null, null, null, null);

insert into bw3.sys_item_element_rela (ITEM_ID, ELEMENT_ID, SEQ_NO, PAUSE, LEVEL_NO)
values ('a_product_110', 'look_a_product_110_10', 1, 0, null);

insert into bw3.sys_item_element_rela (ITEM_ID, ELEMENT_ID, SEQ_NO, PAUSE, LEVEL_NO)
values ('a_product_110', 'look_a_product_110_11', 2, 0, null);

insert into bw3.sys_item_element_rela (ITEM_ID, ELEMENT_ID, SEQ_NO, PAUSE, LEVEL_NO)
values ('a_product_116', 'look_a_product_110_11', 2, 0, null);

insert into bw3.sys_item_element_rela (ITEM_ID, ELEMENT_ID, SEQ_NO, PAUSE, LEVEL_NO)
values ('a_product_150', 'look_a_product_110_11', 2, 0, null);

insert into bw3.sys_item_element_rela (ITEM_ID, ELEMENT_ID, SEQ_NO, PAUSE, LEVEL_NO)
values ('a_product_210', 'look_a_product_110_11', 2, 0, null);

insert into bw3.sys_item_element_rela (ITEM_ID, ELEMENT_ID, SEQ_NO, PAUSE, LEVEL_NO)
values ('a_product_217', 'look_a_product_110_11', 2, 0, null);

insert into bw3.sys_item_element_rela (ITEM_ID, ELEMENT_ID, SEQ_NO, PAUSE, LEVEL_NO)
values ('a_product_216', 'look_a_product_110_11', 2, 0, null);

insert into bw3.sys_item_element_rela (ITEM_ID, ELEMENT_ID, SEQ_NO, PAUSE, LEVEL_NO)
values ('a_product_120_2', 'look_a_product_110_12', 1, 0, null);

END;

/
BEGIN
  insert into bw3.sys_element (ELEMENT_ID, ELEMENT_TYPE, DATA_SOURCE, PAUSE, MESSAGE, IS_HIDE, MEMO, IS_ASYNC, IS_PER_EXE, ENABLE_STAND_PERMISSION)
values ('action_a_product_110_6', 'action', 'oracle_scmdata', 0, null, null, null, null, null, null);

insert into bw3.sys_action (ELEMENT_ID, CAPTION, ICON_NAME, ACTION_TYPE, ACTION_SQL, SELECT_FIELDS, REFRESH_FLAG, MULTI_PAGE_FLAG, PRE_FLAG, FILTER_EXPRESS, UPDATE_FIELDS, PORT_ID, PORT_SQL, LOCK_SQL, SELECTION_FLAG, CALL_ID, OPERATE_MODE, PORT_TYPE, QUERY_FIELDS, SELECTION_METHOD)
values ('action_a_product_110_6', '批量复制进度', 'icon-daoru', 4, 'DECLARE
  v_company_id         VARCHAR2(32) := %default_company_id%;
  v_product_gress_code VARCHAR2(100) := @product_gress_code_pr@; --输入的生产订单
  be_pro_rec           scmdata.t_production_progress%ROWTYPE;
  v_goo_cnt            INT;
  --所选的需要复制进度的生产订单
  CURSOR pro_cur IS
    SELECT p.goo_id,
           p.progress_status,
           p.curlink_complet_ratio,
           p.product_gress_remarks,
           p.order_rise_status,
           p.plan_delivery_date,
           p.product_gress_id,
           p.company_id
      FROM scmdata.t_production_progress p
     WHERE p.company_id = v_company_id
       AND p.product_gress_code IN (@selection);
BEGIN
  --判断输入的生产订单是否存在
  SELECT COUNT(DISTINCT p.goo_id)
    INTO v_goo_cnt
    FROM scmdata.t_production_progress p
   WHERE p.company_id = v_company_id
     AND p.product_gress_code = v_product_gress_code;

  IF v_goo_cnt = 0 THEN
    raise_application_error(-20002,
                            ''复制失败！输入的生产订单编号不存在，请检查！'');
  ELSE
    --判断需复制进度的生产订单 货号是否一致
    SELECT COUNT(DISTINCT p.goo_id)
      INTO v_goo_cnt
      FROM scmdata.t_production_progress p
     WHERE p.company_id = v_company_id
       AND p.product_gress_code IN (@selection);
  
    IF v_goo_cnt > 1 THEN
      raise_application_error(-20002,
                              ''复制失败！所选生产订单货号不一致，请检查！'');
    ELSE
      SELECT COUNT(DISTINCT p.goo_id)
        INTO v_goo_cnt
        FROM scmdata.t_production_progress p
       WHERE p.company_id = v_company_id
         AND (p.product_gress_code IN (@selection) OR
             p.product_gress_code = v_product_gress_code);
      IF v_goo_cnt > 1 THEN
        raise_application_error(-20002,
                                ''复制失败！所选生产订单货号与输入生产订单货号不一致，请检查！'');
      END IF;
    END IF;
    SELECT p.*
      INTO be_pro_rec
      FROM scmdata.t_production_progress p
     WHERE p.company_id = v_company_id
       AND p.product_gress_code = v_product_gress_code;
    --复制内容修改为：复制“生产进度状态、当前环节完成比例、生产进度说明、订单风险状态、计划到仓日期”
    FOR pro_rec IN pro_cur LOOP
    
      pro_rec.progress_status       := be_pro_rec.progress_status;
      pro_rec.curlink_complet_ratio := be_pro_rec.curlink_complet_ratio;
      pro_rec.product_gress_remarks := be_pro_rec.product_gress_remarks;
      pro_rec.order_rise_status     := be_pro_rec.order_rise_status;
      pro_rec.plan_delivery_date    := be_pro_rec.plan_delivery_date;
    
      UPDATE scmdata.t_production_progress t
         SET t.progress_status       = pro_rec.progress_status,
             t.curlink_complet_ratio = pro_rec.curlink_complet_ratio,
             t.product_gress_remarks = pro_rec.product_gress_remarks,
             t.order_rise_status     = pro_rec.order_rise_status,
             t.plan_delivery_date    = pro_rec.plan_delivery_date,
             t.update_id             = :user_id,
             t.update_time           = SYSDATE,
             t.update_company_id     = v_company_id
       WHERE t.product_gress_id = pro_rec.product_gress_id
         AND t.company_id = pro_rec.company_id;
    END LOOP;
  END IF;
END;', 'PRODUCT_GRESS_CODE_PR', 1, 1, null, null, null, null, null, null, 0, null, null, 1, null, 2);
insert into bw3.sys_item_element_rela (ITEM_ID, ELEMENT_ID, SEQ_NO, PAUSE, LEVEL_NO)
values ('a_product_110', 'action_a_product_110_6', 1, 0, null);

  UPDATE bw3.sys_item_element_rela t SET t.pause = 1 where t.element_id = 'action_a_product_110_1';
END;

/
DECLARE
  v_sql CLOB;
BEGIN
  v_sql := 'WITH supp AS
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
   AND ((%is_company_admin% = 1) OR
       instr_priv(p_str1  => pkg_data_privs.parse_json(p_jsonstr => %data_privs_json_strs%,
                                                        p_key     => ''COL_2''),
                   p_str2  => cf.category,
                   p_split => '';'') > 0)';
  UPDATE bw3.sys_action t SET t.action_sql = v_sql WHERE t.element_id = 'action_a_product_118_2';
END;
/
DECLARE
  v_sql CLOB;
BEGIN
  v_sql := 'WITH supp AS
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
   AND ((%is_company_admin% = 1) OR
       instr_priv(p_str1  => pkg_data_privs.parse_json(p_jsonstr => %data_privs_json_strs%,
                                                        p_key     => ''COL_2''),
                   p_str2  => cf.category,
                   p_split => '';'') > 0)';
  UPDATE bw3.sys_action t SET t.action_sql = v_sql WHERE t.element_id = 'action_a_product_118_3';
END;
/
DECLARE
  v_sql CLOB;
BEGIN
  v_sql := 'WITH supp AS
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
   AND ((%is_company_admin% = 1) OR
       instr_priv(p_str1  => pkg_data_privs.parse_json(p_jsonstr => %data_privs_json_strs%,
                                                        p_key     => ''COL_2''),
                   p_str2  => cf.category,
                   p_split => '';'') > 0)';
  UPDATE bw3.sys_action t SET t.action_sql = v_sql WHERE t.element_id = 'action_a_product_118_4';
END;
/
BEGIN
UPDATE bw3.sys_item_rela t SET t.pause = 1 WHERE t.relate_id = 'a_product_111';
UPDATE bw3.sys_item_rela t SET t.pause = 1 WHERE t.relate_id = 'a_product_211'; 
END;
/
BEGIN
insert into bw3.sys_item_element_rela (ITEM_ID, ELEMENT_ID, SEQ_NO, PAUSE, LEVEL_NO)
values ('a_product_118', 'look_a_product_110_10', 1, 0, null);

insert into bw3.sys_item_element_rela (ITEM_ID, ELEMENT_ID, SEQ_NO, PAUSE, LEVEL_NO)
values ('a_product_120_1', 'look_a_product_110_10', 1, 0, null);

insert into bw3.sys_item_element_rela (ITEM_ID, ELEMENT_ID, SEQ_NO, PAUSE, LEVEL_NO)
values ('a_product_120_2', 'look_a_product_110_10', 1, 0, null);

END;
/
DECLARE
  v_sql_s CLOB;
BEGIN
  v_sql_s := 'WITH supp AS
 (SELECT sp.company_id, sp.supplier_code, sp.supplier_company_name
    FROM scmdata.t_supplier_info sp
   WHERE sp.company_id = %default_company_id%),
group_dict AS
 (SELECT group_dict_type, group_dict_value, group_dict_name
    FROM scmdata.sys_group_dict),
range_dict AS
 (SELECT a.group_dict_value abn_range,
         a.group_dict_name abn_range_desc
    FROM scmdata.sys_group_dict a
   WHERE a.group_dict_type = ''ABN_RANGE''
     AND a.pause = 0),
color_dict AS
 (SELECT tcs.color_code abn_range,
         tcs.colorname abn_range_desc,
         od.order_id,
         od.goo_id
    FROM scmdata.t_ordersitem od
   INNER JOIN scmdata.t_commodity_info tc
      ON od.goo_id = tc.goo_id
   INNER JOIN scmdata.t_commodity_color_size tcs
      ON tc.commodity_info_id = tcs.commodity_info_id
     AND od.barcode = tcs.barcode
   WHERE od.company_id = %default_company_id%
   GROUP BY od.goo_id, od.order_id,tcs.color_code,tcs.colorname)
SELECT DISTINCT * FROM (
SELECT t.product_gress_id,
       t.company_id,
       t.order_id             order_id_pr,
       a.abnormal_id          abnormal_id_pr,
       a.abnormal_code        abnormal_code_pr,
       a.anomaly_class        anomaly_class_pr,
       gd.group_dict_name     anomaly_class_desc,
       t.product_gress_code   product_gress_code_pr,
       cf.rela_goo_id, 
       a.detailed_reasons     detailed_reasons_pr, --问题描述
       a.delay_date           delay_date_pr, --延期天数
       a.abnormal_range       abn_range,
       listagg(nvl(rd.abn_range_desc,ld.abn_range_desc),'' '')over(partition by a.abnormal_code) ABN_RANGE_DESC,
       a.delay_amount         delay_amount_pr, --延期数量
       a.handle_opinions      handle_opinions_pr,
       a.is_deduction         is_deduction_pr,
       a.deduction_method     deduction_method_pr,
       a.deduction_unit_price deduction_unit_price_pr,
       a.file_id              file_id_pr,
       a.problem_class        problem_class_pr,
       a.cause_class          cause_class_pr,
       a.cause_detailed       cause_detailed_pr,
       a.is_sup_responsible,
       a.responsible_dept     responsible_dept_pr,
       a.responsible_dept_sec responsible_dept_sec_pr,
       a.memo                 memo_pr,
       a.progress_status      abnormal_status_pr,
       t.progress_status progress_status_pr,
       t.supplier_code                supplier_code_pr,
       sp2.supplier_company_name      supplier_company_name_pr,
       t.goo_id                       goo_id_pr,
       cf.style_number                style_number_pr,
       cf.style_name                  style_name_pr,
       t.order_amount                 order_amount_pr,
       oh.delivery_date               delivery_date_pr,
       t.latest_planned_delivery_date latest_planned_delivery_date_pr
  FROM scmdata.t_ordered oh
 INNER JOIN scmdata.t_orders od
    ON oh.company_id = od.company_id
   AND oh.order_code = od.order_id
   AND oh.order_status = ''OS01'' --待修改
 INNER JOIN t_production_progress t
    ON t.company_id = od.company_id
   AND t.order_id = od.order_id
   AND t.goo_id = od.goo_id
 INNER JOIN scmdata.t_commodity_info cf
    ON t.company_id = cf.company_id
   AND t.goo_id = cf.goo_id
  LEFT JOIN supp sp1
    ON t.company_id = sp1.company_id
   AND t.factory_code = sp1.supplier_code
 INNER JOIN supp sp2
    ON t.company_id = sp2.company_id
   AND t.supplier_code = sp2.supplier_code
 INNER JOIN scmdata.t_abnormal a
    ON t.company_id = a.company_id
   AND t.order_id = a.order_id
   AND t.goo_id = a.goo_id
   AND a.progress_status = ''00''
  LEFT JOIN group_dict gd
    ON gd.group_dict_type = ''ANOMALY_CLASSIFICATION_DICT''
   AND gd.group_dict_value = a.anomaly_class
 LEFT JOIN range_dict rd
    ON (CASE
         WHEN a.abnormal_range = ''00'' THEN
          '' 00 ''
         WHEN a.abnormal_range = ''01'' THEN
          '' 01 ''
         ELSE
          '' 02 ''
       END) = '' '' || rd.abn_range || '' ''
 LEFT JOIN color_dict ld
    ON (instr('' '' || a.abnormal_range || '' '', '' '' || ld.abn_range || '' '') > 0 AND
       ld.order_id = a.order_id AND ld.goo_id = a.goo_id)
 WHERE oh.company_id = %default_company_id%
   AND a.create_id = :user_id AND ((%is_company_admin% = 1) OR instr_priv(p_str1 => @subsql@, p_str2 => cf.category, p_split => '';'') > 0) ORDER BY a.create_time DESC )';
  UPDATE bw3.sys_item_list t SET t.select_sql = v_sql_s,t.noshow_fields = 'PRODUCT_GRESS_ID,COMPANY_ID,SUPPLIER_CODE_PR,FACTORY_CODE_PR,ORDER_ID_PR,ABNORMAL_ID_PR,ABNORMAL_STATUS_PR,IS_DEDUCTION_PR,HANDLE_OPINIONS_PR,ANOMALY_CLASS_PR,RESPONSIBLE_PARTY_PR,DEDUCTION_METHOD_PR,ABN_RANGE,PROGRESS_STATUS_PR' WHERE t.item_id = 'a_product_118';
END;
/
DECLARE
  v_sql_s CLOB;
BEGIN
  v_sql_s := 'WITH supp AS
 (SELECT sp.company_id, sp.supplier_code, sp.supplier_company_name
    FROM scmdata.t_supplier_info sp),
group_dict AS
 (SELECT group_dict_type, group_dict_value, group_dict_name
    FROM scmdata.sys_group_dict),
su_user AS
 (SELECT su.company_id, su.user_id, su.company_user_name
    FROM scmdata.sys_company_user su),
range_dict AS
 (SELECT a.group_dict_value abn_range,
         a.group_dict_name abn_range_desc
    FROM scmdata.sys_group_dict a
   WHERE a.group_dict_type = ''ABN_RANGE''
     AND a.pause = 0),
color_dict AS
 (SELECT tcs.color_code abn_range,
         tcs.colorname abn_range_desc,
         od.order_id,
         od.goo_id
    FROM scmdata.t_ordersitem od
   INNER JOIN scmdata.t_commodity_info tc
      ON od.goo_id = tc.goo_id
   INNER JOIN scmdata.t_commodity_color_size tcs
      ON tc.commodity_info_id = tcs.commodity_info_id
     AND od.barcode = tcs.barcode
   WHERE od.company_id = %default_company_id%
   GROUP BY od.goo_id, od.order_id,tcs.color_code,tcs.colorname)
SELECT DISTINCT * FROM (
SELECT t.product_gress_id,
       t.company_id,
       t.order_id order_id_pr,
       a.abnormal_id,
       a.abnormal_code        abnormal_code_pr,
       a.anomaly_class anomaly_class_pr,
       gd.group_dict_name anomaly_class_desc,
       t.product_gress_code product_gress_code_pr,
       cf.rela_goo_id,
       a.detailed_reasons detailed_reasons_pr, --问题描述
       a.delay_date delay_date_pr, --延期天数
       a.abnormal_range       abn_range,
       listagg(nvl(rd.abn_range_desc,ld.abn_range_desc),'' '')over(partition by a.abnormal_code) ABN_RANGE_DESC,
       a.delay_amount delay_amount_pr, --延期数量
       a.handle_opinions handle_opinions_pr,
       a.is_deduction is_deduction_pr,
       a.deduction_method deduction_method_pr,
       a.deduction_unit_price deduction_unit_price_pr,
       a.file_id file_id_pr,
       a.problem_class problem_class_pr,
       a.cause_class cause_class_pr,
       a.cause_detailed cause_detailed_pr,
       a.is_sup_responsible,
       a.responsible_dept responsible_dept_pr,
       a.responsible_dept_sec responsible_dept_sec_pr,
       a.memo memo_pr,
       t.progress_status progress_status_pr,
       t.supplier_code supplier_code_pr,
       sp2.supplier_company_name supplier_company_name_pr,
       t.goo_id goo_id_pr,
       cf.style_number style_number_pr,
       cf.style_name style_name_pr,
       t.order_amount order_amount_pr,
       oh.delivery_date delivery_date_pr,
       t.latest_planned_delivery_date latest_planned_delivery_date_pr,
       sa.company_user_name create_id,
       a.create_time,
       sc.company_user_name update_id,
       a.update_time,
       sb.company_user_name confirm_id,
       a.confirm_date confirm_date,
       gd_c.group_dict_name cooperation_classification
  FROM scmdata.t_ordered oh
 INNER JOIN scmdata.t_orders od
    ON oh.company_id = od.company_id
   AND oh.order_code = od.order_id
   AND oh.order_status = ''OS01''
 INNER JOIN t_production_progress t
    ON t.company_id = od.company_id
   AND t.order_id = od.order_id
   AND t.goo_id = od.goo_id
 INNER JOIN scmdata.t_commodity_info cf
    ON t.company_id = cf.company_id
   AND t.goo_id = cf.goo_id
  LEFT JOIN group_dict gd_c
    ON gd_c.group_dict_type = ''PRODUCT_TYPE''
   AND gd_c.group_dict_value = cf.category
 INNER JOIN supp sp2
    ON t.company_id = sp2.company_id
   AND t.supplier_code = sp2.supplier_code
 INNER JOIN scmdata.t_abnormal a
    ON t.company_id = a.company_id
   AND t.order_id = a.order_id
   AND t.goo_id = a.goo_id
   AND a.progress_status = ''01''
   AND a.origin <> ''SC''
 INNER JOIN su_user sa
    ON a.company_id = sa.company_id
   AND a.create_id = sa.user_id
  LEFT JOIN su_user sb
    ON a.company_id = sb.company_id
   AND a.confirm_id = sb.user_id
  LEFT JOIN su_user sc
    ON a.company_id = sc.company_id
   AND a.update_id = sc.user_id
 INNER JOIN scmdata.sys_group_dict gd
    ON gd.group_dict_type = ''ANOMALY_CLASSIFICATION_DICT''
   AND gd.group_dict_value = a.anomaly_class
 LEFT JOIN range_dict rd
    ON (CASE
         WHEN a.abnormal_range = ''00'' THEN
          '' 00 ''
         WHEN a.abnormal_range = ''01'' THEN
          '' 01 ''
         ELSE
          '' 02 ''
       END) = '' '' || rd.abn_range || '' ''
 LEFT JOIN color_dict ld
    ON (instr('' '' || a.abnormal_range || '' '', '' '' || ld.abn_range || '' '') > 0 AND
       ld.order_id = a.order_id AND ld.goo_id = a.goo_id)
 WHERE oh.company_id = %default_company_id%
   AND ((%is_company_admin% = 1) OR
   instr_priv(p_str1  => @subsql@ ,p_str2  => cf.category ,p_split => '';'') > 0)
 ORDER BY a.create_time DESC)';
  UPDATE bw3.sys_item_list t SET t.select_sql = v_sql_s,t.noshow_fields = 'ABNORMAL_ID,ANOMALY_CLASS_PR,PRODUCT_GRESS_ID,COMPANY_ID,SUPPLIER_CODE_PR,FACTORY_CODE_PR,ORDER_ID_PR,ABNORMAL_STATUS_PR,HANDLE_OPINIONS_PR,IS_DEDUCTION_PR,CONFIRM_ID,CONFIRM_DATE,DEDUCTION_METHOD_PR,RESPONSIBLE_PARTY_PR,ABN_RANGE,PROGRESS_STATUS_PR' WHERE t.item_id = 'a_product_120_1';
END;
/
DECLARE
  v_sql_s CLOB;
BEGIN
  v_sql_s := 'WITH supp AS
 (SELECT sp.company_id, sp.supplier_code, sp.supplier_company_name
    FROM scmdata.t_supplier_info sp),
group_dict AS
 (SELECT group_dict_type, group_dict_value, group_dict_name
    FROM scmdata.sys_group_dict),
su_user AS
 (SELECT su.company_id, su.user_id, su.company_user_name
    FROM scmdata.sys_company_user su),
range_dict AS
 (SELECT a.group_dict_value abn_range,
         a.group_dict_name abn_range_desc
    FROM scmdata.sys_group_dict a
   WHERE a.group_dict_type = ''ABN_RANGE''
     AND a.pause = 0),
color_dict AS
 (SELECT tcs.color_code abn_range,
         tcs.colorname abn_range_desc,
         od.order_id,
         od.goo_id
    FROM scmdata.t_ordersitem od
   INNER JOIN scmdata.t_commodity_info tc
      ON od.goo_id = tc.goo_id
   INNER JOIN scmdata.t_commodity_color_size tcs
      ON tc.commodity_info_id = tcs.commodity_info_id
     AND od.barcode = tcs.barcode
   WHERE od.company_id = %default_company_id%
   GROUP BY od.goo_id, od.order_id,tcs.color_code,tcs.colorname)
SELECT DISTINCT * FROM (
SELECT t.product_gress_id,
       t.company_id,
       t.order_id order_id_pr,
       a.abnormal_id,
       a.anomaly_class anomaly_class_pr,
       gd.group_dict_name anomaly_class_desc,
       t.product_gress_code product_gress_code_pr,
       cf.rela_goo_id,
       a.detailed_reasons detailed_reasons_pr, --问题描述
       a.delay_date delay_date_pr, --延期天数
       a.abnormal_range       abn_range,
       listagg(nvl(rd.abn_range_desc,ld.abn_range_desc),'' '')over(partition by a.abnormal_code) ABN_RANGE_DESC,
       a.delay_amount delay_amount_pr, --延期数量
       a.delivery_amount delivery_amount_pr,
       a.handle_opinions handle_opinions_pr,
       a.is_deduction is_deduction_pr,
       gd_c.group_dict_name deduction_method_desc,
       a.deduction_unit_price deduction_unit_price_pr,
       a.file_id file_id_pr,
       a.problem_class problem_class_pr,
       a.cause_class cause_class_pr,
       a.cause_detailed cause_detailed_pr,
       a.is_sup_responsible,
       a.responsible_dept responsible_dept_pr,
       a.responsible_dept_sec responsible_dept_sec_pr,
       a.memo memo_pr,
       t.progress_status progress_status_pr,
       t.supplier_code supplier_code_pr,
       sp2.supplier_company_name supplier_company_name_pr,
       t.goo_id goo_id_pr,
       cf.style_number style_number_pr,
       cf.style_name style_name_pr,
       t.order_amount order_amount_pr,
       oh.delivery_date delivery_date_pr,
       t.latest_planned_delivery_date latest_planned_delivery_date_pr,
       sa.company_user_name create_id,
       a.create_time,
       sc.company_user_name update_id,
       a.update_time,
       sb.company_user_name confirm_id,
       a.confirm_date confirm_date,
       gd_d.group_dict_name cooperation_classification
  FROM scmdata.t_ordered oh
 INNER JOIN scmdata.t_orders od
    ON oh.company_id = od.company_id
   AND oh.order_code = od.order_id
   AND oh.order_status IN (''OS01'', ''OS02'') --待修改
 INNER JOIN t_production_progress t
    ON t.company_id = od.company_id
   AND t.order_id = od.order_id
   AND t.goo_id = od.goo_id
 INNER JOIN scmdata.t_commodity_info cf
    ON t.company_id = cf.company_id
   AND t.goo_id = cf.goo_id
 INNER JOIN supp sp2
    ON t.company_id = sp2.company_id
   AND t.supplier_code = sp2.supplier_code
 INNER JOIN scmdata.t_abnormal a
    ON t.company_id = a.company_id
   AND t.order_id = a.order_id
   AND t.goo_id = a.goo_id
   AND a.progress_status = ''02''
   AND a.origin <> ''SC''
 INNER JOIN su_user sa
    ON a.company_id = sa.company_id
   AND a.create_id = sa.user_id
 INNER JOIN su_user sb
    ON a.company_id = sb.company_id
   AND a.confirm_id = sb.user_id
  LEFT JOIN su_user sc
    ON a.company_id = sc.company_id
   AND a.update_id = sc.user_id
 INNER JOIN scmdata.sys_group_dict gd
    ON gd.group_dict_type = ''ANOMALY_CLASSIFICATION_DICT''
   AND gd.group_dict_value = a.anomaly_class
 LEFT JOIN group_dict gd_c
    ON gd_c.group_dict_type = ''DEDUCTION_METHOD''
  AND gd_c.group_dict_value = a.deduction_method
 LEFT JOIN group_dict gd_d
   ON gd_d.group_dict_type = ''PRODUCT_TYPE''
  AND gd_d.group_dict_value = cf.category
 LEFT JOIN range_dict rd
    ON (CASE
         WHEN a.abnormal_range = ''00'' THEN
          '' 00 ''
         WHEN a.abnormal_range = ''01'' THEN
          '' 01 ''
         ELSE
          '' 02 ''
       END) = '' '' || rd.abn_range || '' ''
 LEFT JOIN color_dict ld
    ON (instr('' '' || a.abnormal_range || '' '', '' '' || ld.abn_range || '' '') > 0 AND
       ld.order_id = a.order_id AND ld.goo_id = a.goo_id)
 WHERE oh.company_id = %default_company_id%
  AND ((%is_company_admin% = 1) OR
  instr_priv(p_str1  => @subsql@ ,p_str2  => cf.category ,p_split => '';'') > 0)
 ORDER BY a.confirm_date DESC)';
  UPDATE bw3.sys_item_list t SET t.select_sql = v_sql_s,t.noshow_fields = 'ANOMALY_CLASS_PR,PRODUCT_GRESS_ID,COMPANY_ID,SUPPLIER_CODE_PR,FACTORY_CODE_PR,ORDER_ID_PR,ABNORMAL_ID,ABNORMAL_STATUS_PR,HANDLE_OPINIONS_PR,IS_DEDUCTION_PR,ABN_RANGE,PROGRESS_STATUS_PR' WHERE t.item_id = 'a_product_120_2';
END;
