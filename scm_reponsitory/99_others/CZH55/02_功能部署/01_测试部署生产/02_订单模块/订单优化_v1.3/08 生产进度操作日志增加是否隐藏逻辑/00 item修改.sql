ALTER TABLE scmdata.t_plat_log   ADD log_msg_f  varchar2(4000);
ALTER TABLE scmdata.t_plat_logs  ADD is_show number(1);
comment on column scmdata.t_plat_logs.is_show
  is '是否展示该字段  1：是 ，0：否';
comment on column scmdata.t_plat_log.log_msg_f 
  is '日志内容(过滤隐藏字段) ';

/
BEGIN
  insert into bw3.sys_item (ITEM_ID, ITEM_TYPE, CAPTION_SQL, DATA_SOURCE, BASE_TABLE, KEY_FIELD, NAME_FIELD, SETTING_ID, REPORT_TITLE, SUB_SCRIPTS, PAUSE, LINK_FIELD, HELP_ID, TAG_ID, CONFIG_PARAMS, TIME_OUT, OFFLINE_FLAG, PANEL_ID, INIT_SHOW, BADGE_FLAG, BADGE_SQL, MEMO, SHOW_ROWID, ENABLE_STAND_PERMISSION, FIX_CAPTION)
values ('a_product_211_2', 'list', '进度跟进日志', 'oracle_scmdata', null, null, null, 'a_product_211_2', null, null, 0, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into bw3.sys_item_list (ITEM_ID, QUERY_TYPE, QUERY_FIELDS, QUERY_COUNT, EDIT_EXPRESS, NEWID_SQL, SELECT_SQL, DETAIL_SQL, SUBSELECT_SQL, INSERT_SQL, UPDATE_SQL, DELETE_SQL, NOSHOW_FIELDS, NOADD_FIELDS, NOMODIFY_FIELDS, NOEDIT_FIELDS, SUBNOSHOW_FIELDS, UI_TMPL, MULTI_PAGE_FLAG, OUTPUT_PARAMETER, LOCK_SQL, MONITOR_ID, END_FIELD, EXECUTE_TIME, SCANNABLE_FIELD, SCANNABLE_TYPE, AUTO_REFRESH, RFID_FLAG, SCANNABLE_TIME, MAX_ROW_COUNT, NOSHOW_APP_FIELDS, SCANNABLE_LOCATION_LINE, SUB_TABLE_JUDGE_FIELD, BACK_GROUND_ID, OPRETION_HINT, SUB_EDIT_STATE, HINT_TYPE, HEADER, FOOTER, JUMP_FIELD, JUMP_EXPRESS, OPEN_MODE, OPERATION_TYPE, OPERATE_TYPE, PAGE_SIZES)
values ('a_product_211_2', 2, null, null, null, null, '{DECLARE
  v_sql CLOB;
BEGIN
  v_sql      := scmdata.pkg_plat_comm.f_query_t_plat_log(p_apply_pk_id =>  :PRODUCT_GRESS_ID,p_dict_type => ''PROGRESS_LOG'',p_is_flhide_fileds => 1);
  @strresult := v_sql;
END;}', null, null, null, null, null, null, null, null, null, null, null, 1, null, null, null, null, null, null, null, 3, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, 0, null);

UPDATE bw3.sys_item_rela t SET t.relate_id = 'a_product_211_2'  WHERE t.item_id IN ('a_product_210','a_product_216','a_product_217') AND t.relate_id = 'a_product_111_2'; 
END;
/
DECLARE
v_sql_s CLOB;
v_sql_u CLOB;
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
  v_sql_u := 'DECLARE
  v_is_sup_exemption NUMBER;
  v_first_dept_id    VARCHAR2(100);
  v_second_dept_id   VARCHAR2(100);
  v_is_quality       NUMBER;
  v_dept_name        VARCHAR2(100);
  v_need_comp_id     VARCHAR2(32);
  vo_forecast_date       DATE;
  vo_forecast_days       INT;
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
  --修改校验
  SELECT t.company_id INTO v_need_comp_id FROM scmdata.t_production_progress t WHERE t.product_gress_id = :product_gress_id;

  --修改校验
  scmdata.pkg_production_progress_a.p_check_updprogress(p_item_id               => ''a_product_217'',
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
  --预测交期
  scmdata.pkg_production_progress_a.p_forecast_delivery_date(p_progress_id          => :product_gress_id,
                                                             p_company_id           => v_need_comp_id,
                                                             p_is_product           => 0,
                                                             p_latest_delivery_date => :latest_planned_delivery_date_pr,
                                                             p_plan_date            => :plan_delivery_date,
                                                             p_delivery_date        => :delivery_date_pr,
                                                             po_forecast_date       => vo_forecast_date,
                                                             po_forecast_days       => vo_forecast_days);                                                          
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
         t.plan_delivery_date   = :plan_delivery_date,
         t.forecast_delivery_date = vo_forecast_date,
         t.forecast_delay_day     = vo_forecast_days
   WHERE t.product_gress_id = :product_gress_id;
END;';
UPDATE bw3.sys_item_list t SET t.select_sql = v_sql_s,t.update_sql = v_sql_u WHERE t.item_id = 'a_product_217';
END;
/
DECLARE
v_sql CLOB;
BEGIN
 v_sql := 'SELECT ad.problem_classification delay_problem_class_pr,
       ad.cause_classification   delay_cause_class_pr,
       ad.cause_detail           delay_cause_detailed_pr,
       ad.is_sup_exemption       is_sup_responsible,
       ad.first_dept_id,
       ad.second_dept_id         responsible_dept_sec
  FROM scmdata.t_commodity_info tc
 INNER JOIN scmdata.t_abnormal_range_config ar
    ON tc.company_id = ar.company_id
   AND tc.category = ar.industry_classification
   AND tc.product_cate = ar.production_category
   AND instr('';'' || ar.product_subclass || '';'',
             '';'' || tc.samll_category || '';'') > 0
   AND ar.pause = 0
 INNER JOIN scmdata.t_abnormal_dtl_config ad
    ON ar.company_id = ad.company_id
   AND ar.abnormal_config_id = ad.abnormal_config_id
   AND ad.pause = 0
 INNER JOIN scmdata.t_abnormal_config ab
    ON ab.company_id = ad.company_id
   AND ab.abnormal_config_id = ad.abnormal_config_id
   AND ab.pause = 0
 WHERE tc.company_id = :company_id
   AND tc.goo_id = :goo_id_pr
   AND ad.anomaly_classification = ''AC_DATE''';
UPDATE bw3.sys_pick_list t SET t.pick_sql = v_sql WHERE t.element_id = 'pick_a_product_110_1';
END;
/
BEGIN
UPDATE bw3.sys_item_list t SET t.query_fields = 'product_gress_code_pr,rela_goo_id,style_number_pr' WHERE t.item_id = 'a_product_216';
END;
