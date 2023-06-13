prompt Importing table bw3.sys_item_list...
set feedback off
set define off
insert into bw3.sys_item_list (ITEM_ID, QUERY_TYPE, QUERY_FIELDS, QUERY_COUNT, EDIT_EXPRESS, NEWID_SQL, SELECT_SQL, DETAIL_SQL, SUBSELECT_SQL, INSERT_SQL, UPDATE_SQL, DELETE_SQL, NOSHOW_FIELDS, NOADD_FIELDS, NOMODIFY_FIELDS, NOEDIT_FIELDS, SUBNOSHOW_FIELDS, UI_TMPL, MULTI_PAGE_FLAG, OUTPUT_PARAMETER, LOCK_SQL, MONITOR_ID, END_FIELD, EXECUTE_TIME, SCANNABLE_FIELD, SCANNABLE_TYPE, AUTO_REFRESH, RFID_FLAG, SCANNABLE_TIME, MAX_ROW_COUNT, NOSHOW_APP_FIELDS, SCANNABLE_LOCATION_LINE, SUB_TABLE_JUDGE_FIELD, BACK_GROUND_ID, OPRETION_HINT, SUB_EDIT_STATE, HINT_TYPE, HEADER, FOOTER, JUMP_FIELD, JUMP_EXPRESS, OPEN_MODE, OPERATION_TYPE, OPERATE_TYPE, PAGE_SIZES)
values ('a_product_110', 13, 'product_gress_code_pr,rela_goo_id,supplier_company_name_pr,style_number_pr', null, null, null, '
WITH supp AS
 (SELECT sp.company_id, sp.supplier_code, sp.supplier_company_name
    FROM scmdata.t_supplier_info sp),
group_dict AS
 (SELECT group_dict_type, group_dict_value, group_dict_name
    FROM scmdata.sys_group_dict),
SELECT t.product_gress_id,
       t.company_id,
       t.progress_status progress_status_pr,
       t.product_gress_code product_gress_code_pr,
       decode(t.progress_status,
              ''02'',
              (SELECT pno_status
                 FROM (SELECT pn.node_name ||
                              (SELECT a.group_dict_name
                                 FROM group_dict a
                                INNER JOIN group_dict b
                                   ON a.group_dict_type = b.group_dict_value
                                  AND b.group_dict_value = ''PROGRESS_NODE_TYPE''
                                WHERE a.group_dict_value = pn.progress_status) pno_status
                         FROM scmdata.t_production_node pn
                        WHERE pn.company_id = t.company_id
                          AND pn.product_gress_id = t.product_gress_id
                          AND pn.progress_status IS NOT NULL
                        ORDER BY pn.node_num DESC)
                WHERE rownum = 1),
              ''00'',
              (SELECT a.group_dict_name
                 FROM group_dict a
                WHERE a.group_dict_type = ''PROGRESS_TYPE''
                  AND a.group_dict_value = t.progress_status)) progress_status_desc,
       t.order_id order_id_pr,
       cf.rela_goo_id,
       cf.style_number style_number_pr,
       cf.style_name style_name_pr,
       t.supplier_code supplier_code_pr,
       sp2.supplier_company_name supplier_company_name_pr,
       t.factory_code factory_code_pr,
       sp1.supplier_company_name factory_company_name_pr,
       oh.delivery_date delivery_date_pr, --update by czh 20210527（1）生产进度表中的订单交期取下单列表的订单交期（即熊猫的交期日期）
       /*nvl(MAX(od.delivery_date) over(PARTITION BY od.order_id),
       od.delivery_date) delivery_date_pr,*/
       t.forecast_delivery_date forecast_delivery_date_pr,
       decode(sign(ceil(t.forecast_delivery_date - oh.delivery_date)),
              -1,
              0,
              ceil(t.forecast_delivery_date - oh.delivery_date)) forecast_delay_day_pr,
       --t.latest_planned_delivery_date latest_planned_delivery_date_pr,
       MAX(od.delivery_date) over(PARTITION BY od.order_id) latest_planned_delivery_date_pr, --update by czh 20210527（2）生产进度表中的”最新计划完成日期“字段名更改为“最新计划交期”，取下单列表中的最新计划交期（即熊猫的新交货日期）
       t.actual_delivery_date actual_delivery_date_pr,
       t.actual_delay_day actual_delay_day_pr,
       t.order_amount order_amount_pr,
       t.delivery_amount delivery_amount_pr,
       decode(sign(t.order_amount - t.delivery_amount),
              -1,
              0,
              t.order_amount - t.delivery_amount) owe_amount_pr,
       --nvl(t.order_full_rate, 0) order_full_rate_pr,
       --t.order_status order_status_pr,
       t.delay_problem_class delay_problem_class_pr,
       t.delay_cause_class delay_cause_class_pr,
       t.delay_cause_detailed delay_cause_detailed_pr,
       t.problem_desc problem_desc_pr,
       t.is_sup_responsible,
       t.responsible_dept,
       t.responsible_dept_sec,
       t.approve_edition, --Edit by zc
       cf.IS_SET_FABRIC,t.fabric_check fabric_check,t.CHECK_LINK,
       t.qc_check qc_check_pr,
       t.qa_check qa_check_pr,
       decode(t.exception_handle_status,
              ''01'',
              ''处理中'',
              ''02'',
              ''已处理'',
              ''无异常'') exception_handle_status_pr,
       (SELECT gd.group_dict_name
          FROM group_dict gd
         WHERE gd.group_dict_type = ''HANDLE_RESULT''
           AND gd.group_dict_value = t.handle_opinions) handle_opinions_pr,
       t.goo_id goo_id_pr, --这里goo_id是货号
       decode(oh.send_by_sup, 1, ''是'', ''否'') send_by_sup,
       oh.create_time create_time_po,
       --decode(oh.send_by_sup,1,''是'',''否'') send_by_sup,
       oh.memo memo_po,
       a.group_dict_name CATEGORY,
       b.group_dict_name cooperation_product_cate_sp,
       c.company_dict_name product_subclass_desc
       ,oh.finish_time
  FROM scmdata.t_ordered oh
 INNER JOIN scmdata.t_orders od
    ON oh.company_id = od.company_id
   AND oh.order_code = od.order_id
   AND oh.order_status = ''OS01'' --待修改
 INNER JOIN t_production_progress t
    ON t.company_id = od.company_id
   AND t.order_id = od.order_id
   AND t.goo_id = od.goo_id
   AND t.progress_status <> ''01''
 INNER JOIN scmdata.t_commodity_info cf
    ON t.company_id = cf.company_id
   AND t.goo_id = cf.goo_id
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
 WHERE oh.company_id = %default_company_id%
   AND ((%is_company_admin%) = 1 OR
       instr_priv(p_str1  => @subsql@ ,p_str2  => cf.category ,p_split => '';'') > 0)
 ORDER BY t.product_gress_code DESC, t.create_time DESC', null, '{declare
v_class_data_privs clob;
begin
 v_class_data_privs := pkg_data_privs.parse_json(p_jsonstr => %data_privs_json_strs%,p_key => ''COL_2'');
 @strresult :=''(SELECT * FROM (SELECT '' || '''''''' || v_class_data_privs || '''''''' || '' FROM dual))'';
end;}', null, 'DECLARE
  v_is_sup_exemption NUMBER;
  v_first_dept_id    VARCHAR2(100);
  v_second_dept_id   VARCHAR2(100);
  v_is_quality       NUMBER;
BEGIN

  --增加校验逻辑：延期问题分类、延期原因分类、延期原因细分有值，则问题描述必填
  IF :delay_problem_class_pr IS NOT NULL AND
     :delay_cause_class_pr IS NOT NULL AND
     :delay_cause_detailed_pr IS NOT NULL THEN
    IF :problem_desc_pr IS NULL THEN
      raise_application_error(-20002,''提示：延期问题分类、延期原因分类、延期原因细分有值，则问题描述必填！'');
    ELSE
      SELECT ad.is_sup_exemption,
             (SELECT sd.dept_name
                FROM scmdata.sys_company_dept sd
               WHERE sd.company_id = ad.company_id
                 AND sd.company_dept_id = ad.first_dept_id) first_dept_name,
             (SELECT sd.dept_name
                FROM scmdata.sys_company_dept sd
               WHERE sd.company_id = ad.company_id
                 AND sd.company_dept_id = ad.second_dept_id) second_dept_name,
             ad.is_quality_problem
        INTO v_is_sup_exemption,
             v_first_dept_id,
             v_second_dept_id,
             v_is_quality
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
         AND ad.anomaly_classification = ''AC_DATE''
         AND ad.problem_classification = :delay_problem_class_pr
         AND ad.cause_classification = :delay_cause_class_pr
         AND ad.cause_detail = :delay_cause_detailed_pr;

    END IF;
  END IF;

  UPDATE scmdata.t_production_progress t
     SET t.delay_problem_class  = :delay_problem_class_pr,
         t.delay_cause_class    = :delay_cause_class_pr,
         t.delay_cause_detailed = :delay_cause_detailed_pr,
         t.problem_desc         = :problem_desc_pr,
         t.is_sup_responsible   = v_is_sup_exemption,
         t.responsible_dept     = v_first_dept_id,
         t.responsible_dept_sec = v_second_dept_id,
         t.is_quality           = v_is_quality
   WHERE t.product_gress_id = :product_gress_id;

END;', null, 'fabric_check,product_gress_id,company_id,supplier_code_pr,factory_code_pr,order_id_pr,progress_status_pr,qc_check_pr,qa_check_pr,approve_edition,is_sup_responsible,responsible_dept,responsible_dept_sec,check_link', null, null, null, null, null, 1, null, null, null, null, null, null, null, 1, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, 0, null);

insert into bw3.sys_item_list (ITEM_ID, QUERY_TYPE, QUERY_FIELDS, QUERY_COUNT, EDIT_EXPRESS, NEWID_SQL, SELECT_SQL, DETAIL_SQL, SUBSELECT_SQL, INSERT_SQL, UPDATE_SQL, DELETE_SQL, NOSHOW_FIELDS, NOADD_FIELDS, NOMODIFY_FIELDS, NOEDIT_FIELDS, SUBNOSHOW_FIELDS, UI_TMPL, MULTI_PAGE_FLAG, OUTPUT_PARAMETER, LOCK_SQL, MONITOR_ID, END_FIELD, EXECUTE_TIME, SCANNABLE_FIELD, SCANNABLE_TYPE, AUTO_REFRESH, RFID_FLAG, SCANNABLE_TIME, MAX_ROW_COUNT, NOSHOW_APP_FIELDS, SCANNABLE_LOCATION_LINE, SUB_TABLE_JUDGE_FIELD, BACK_GROUND_ID, OPRETION_HINT, SUB_EDIT_STATE, HINT_TYPE, HEADER, FOOTER, JUMP_FIELD, JUMP_EXPRESS, OPEN_MODE, OPERATION_TYPE, OPERATE_TYPE, PAGE_SIZES)
values ('a_product_116', 13, 'product_gress_code_pr,rela_goo_id,supplier_company_name_pr,style_number_pr', null, null, null, 'WITH supp AS
 (SELECT sp.company_id, sp.supplier_code, sp.supplier_company_name
    FROM scmdata.t_supplier_info sp),
group_dict AS
 (SELECT group_dict_type, group_dict_value, group_dict_name
    FROM scmdata.sys_group_dict)
SELECT t.product_gress_id,
       t.company_id,
       t.progress_status         progress_status_pr,
       t.product_gress_code      product_gress_code_pr,
       a.group_dict_name         progress_status_desc,
       t.order_id                order_id_pr,
       cf.rela_goo_id,
       cf.style_number           style_number_pr,
       cf.style_name             style_name_pr,
       t.supplier_code           supplier_code_pr,
       sp2.supplier_company_name supplier_company_name_pr,
       t.factory_code            factory_code_pr,
       sp1.supplier_company_name factory_company_name_pr,
       --od.delivery_date delivery_date_pr,
       oh.delivery_date delivery_date_pr, --update by czh 20210527（1）生产进度表中的订单交期取下单列表的订单交期（即熊猫的交期日期）
       oh.finish_time_scm finish_time_scm_pr,
       t.forecast_delivery_date forecast_delivery_date_pr,
       decode(sign(ceil(t.forecast_delivery_date - oh.delivery_date)),
              -1,
              0,
              ceil(t.forecast_delivery_date - oh.delivery_date)) forecast_delay_day_pr,
       --t.latest_planned_delivery_date latest_planned_delivery_date_pr,
       MAX(od.delivery_date) over(PARTITION BY od.order_id) latest_planned_delivery_date_pr, --update by czh 20210527（2）生产进度表中的”最新计划完成日期“字段名更改为“最新计划交期”，取下单列表中的最新计划交期（即熊猫的新交货日期）
       t.actual_delivery_date actual_delivery_date_pr,
       t.actual_delay_day actual_delay_day_pr,
       t.order_amount order_amount_pr,
       t.delivery_amount delivery_amount_pr,
       decode(sign(t.order_amount - t.delivery_amount),
              -1,
              0,
              t.order_amount - t.delivery_amount) owe_amount_pr,
       --nvl(t.order_full_rate, 0) order_full_rate_pr,
       --t.order_status order_status_pr,
       t.delay_problem_class delay_problem_class_pr,
       t.delay_cause_class delay_cause_class_pr,
       t.delay_cause_detailed delay_cause_detailed_pr,
       t.problem_desc problem_desc_pr,
       t.approve_edition, --Edit by zc
       cf.IS_SET_FABRIC,t.fabric_check fabric_check,t.CHECK_LINK,
       t.qc_check qc_check_pr,
       t.qa_check qa_check_pr,
       decode(t.exception_handle_status,
              ''01'',
              ''处理中'',
              ''02'',
              ''已处理'',
              ''无异常'') exception_handle_status_pr,
       (SELECT gd.group_dict_name
          FROM scmdata.sys_group_dict gd
         WHERE gd.group_dict_type = ''HANDLE_RESULT''
           AND gd.group_dict_value = t.handle_opinions) handle_opinions_pr,
       t.goo_id goo_id_pr,
       decode(oh.send_by_sup, 1, ''是'', ''否'') send_by_sup,
       oh.create_time create_time_po,
       --decode(oh.send_by_sup,1,''是'',''否'') send_by_sup,
       oh.memo memo_po,
       c.group_dict_name CATEGORY,
       d.group_dict_name cooperation_product_cate_sp,
       e.company_dict_name product_subclass_desc,
       oh.finish_time,
       oh.finish_time_scm,
       su.nick_name finish_id_pr,
       decode(oh.finish_type,''01'',''自动结束'',''手动结束'') finish_type
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
    ON a.group_dict_value = t.progress_status
 INNER JOIN group_dict b
    ON b.group_dict_value = a.group_dict_type
   AND b.group_dict_value = ''PROGRESS_TYPE''
 INNER JOIN scmdata.t_commodity_info cf
    ON t.company_id = cf.company_id
   AND t.goo_id = cf.goo_id
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
 WHERE oh.company_id = %default_company_id%
   AND ((%is_company_admin%) = 1 OR
       instr_priv(p_str1  => @subsql@ ,p_str2  => cf.category ,p_split => '';'') > 0)
 ORDER BY t.product_gress_code DESC, oh.finish_time_scm DESC', null, '{declare
v_class_data_privs clob;
begin
 v_class_data_privs := pkg_data_privs.parse_json(p_jsonstr => %data_privs_json_strs%,p_key => ''COL_2'');
 @strresult :=''(SELECT * FROM (SELECT '' || '''''''' || v_class_data_privs || '''''''' || '' FROM dual))'';
end;}', null, null, null, 'fabric_check,product_gress_id,company_id,supplier_code_pr,factory_code_pr,order_id_pr,progress_status_pr,qc_check_pr,qa_check_pr,approve_edition,check_link', null, null, null, null, null, 1, null, null, null, null, null, null, null, 1, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, 0, null);

insert into bw3.sys_item_list (ITEM_ID, QUERY_TYPE, QUERY_FIELDS, QUERY_COUNT, EDIT_EXPRESS, NEWID_SQL, SELECT_SQL, DETAIL_SQL, SUBSELECT_SQL, INSERT_SQL, UPDATE_SQL, DELETE_SQL, NOSHOW_FIELDS, NOADD_FIELDS, NOMODIFY_FIELDS, NOEDIT_FIELDS, SUBNOSHOW_FIELDS, UI_TMPL, MULTI_PAGE_FLAG, OUTPUT_PARAMETER, LOCK_SQL, MONITOR_ID, END_FIELD, EXECUTE_TIME, SCANNABLE_FIELD, SCANNABLE_TYPE, AUTO_REFRESH, RFID_FLAG, SCANNABLE_TIME, MAX_ROW_COUNT, NOSHOW_APP_FIELDS, SCANNABLE_LOCATION_LINE, SUB_TABLE_JUDGE_FIELD, BACK_GROUND_ID, OPRETION_HINT, SUB_EDIT_STATE, HINT_TYPE, HEADER, FOOTER, JUMP_FIELD, JUMP_EXPRESS, OPEN_MODE, OPERATION_TYPE, OPERATE_TYPE, PAGE_SIZES)
values ('a_product_118', 12, 'product_gress_code_pr,rela_goo_id,supplier_company_name_pr,style_number_pr', null, null, null, 'WITH supp AS
 (SELECT sp.company_id, sp.supplier_code, sp.supplier_company_name
    FROM scmdata.t_supplier_info sp
   WHERE sp.company_id = %default_company_id%),
group_dict AS
 (SELECT group_dict_type, group_dict_value, group_dict_name
    FROM scmdata.sys_group_dict)
SELECT t.product_gress_id,
       t.company_id,
       t.order_id order_id_pr,
       a.abnormal_id abnormal_id_pr,
       a.abnormal_code abnormal_code_pr,
       a.anomaly_class anomaly_class_pr,
       gd.group_dict_name anomaly_class_desc,
       t.product_gress_code product_gress_code_pr,
       cf.rela_goo_id,
       a.detailed_reasons detailed_reasons_pr, --问题描述
       a.delay_date delay_date_pr, --延期天数
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
       --a.responsible_party responsible_party_pr,
       a.responsible_dept responsible_dept_pr,
       a.responsible_dept_sec responsible_dept_sec_pr,
       a.memo memo_pr,
       a.progress_status abnormal_status_pr,
       decode(t.progress_status,
              ''02'',
              (SELECT pno_status
                 FROM (SELECT pn.node_name ||
                              (SELECT a.group_dict_name
                                 FROM group_dict a
                                INNER JOIN group_dict b
                                   ON a.group_dict_type = b.group_dict_value
                                  AND b.group_dict_value = ''PROGRESS_NODE_TYPE''
                                WHERE a.group_dict_value = pn.progress_status) pno_status
                         FROM scmdata.t_production_node pn
                        WHERE pn.company_id = t.company_id
                          AND pn.product_gress_id = t.product_gress_id
                          AND pn.progress_status IS NOT NULL
                        ORDER BY pn.node_num DESC)
                WHERE rownum = 1),
              ''00'',
              (SELECT a.group_dict_name
                 FROM group_dict a
                WHERE a.group_dict_type = ''PROGRESS_TYPE''
                  AND a.group_dict_value = t.progress_status)) progress_status_desc,
       t.supplier_code supplier_code_pr,
       sp2.supplier_company_name supplier_company_name_pr,
       t.goo_id goo_id_pr,
       cf.style_number style_number_pr,
       cf.style_name style_name_pr,
       t.order_amount order_amount_pr,
       oh.delivery_date delivery_date_pr,
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
  LEFT JOIN scmdata.sys_group_dict gd
    ON gd.group_dict_type = ''ANOMALY_CLASSIFICATION_DICT''
   AND gd.group_dict_value = a.anomaly_class
 WHERE oh.company_id = %default_company_id%
   AND a.create_id = :user_id
   AND ((%is_company_admin% = 1) OR instr_priv(p_str1  => @subsql@ ,p_str2  => cf.category ,p_split => '';'') > 0)
 ORDER BY a.create_time DESC', null, '{declare
v_class_data_privs clob;
begin
 v_class_data_privs := pkg_data_privs.parse_json(p_jsonstr => %data_privs_json_strs%,p_key => ''COL_2'');
 @strresult :=''(SELECT * FROM (SELECT '' || '''''''' || v_class_data_privs || '''''''' || '' FROM dual))'';
end;}', 'DECLARE
  v_abnormal_code VARCHAR2(32);
  p_abn_rec       scmdata.t_abnormal%ROWTYPE;
BEGIN

  p_abn_rec.abnormal_id          := scmdata.f_get_uuid();
  p_abn_rec.company_id           := %default_company_id%;
  p_abn_rec.abnormal_code        := scmdata.pkg_plat_comm.f_getkeycode(pi_table_name  => ''t_abnormal'',
                                                                       pi_column_name => ''abnormal_code'',
                                                                       pi_company_id  => %default_company_id%,
                                                                       pi_pre         => ''ABN'',
                                                                       pi_serail_num  => ''6'');
  p_abn_rec.order_id             := :order_id_pr;
  p_abn_rec.progress_status      := ''00'';
  p_abn_rec.goo_id               := :goo_id_pr;
  p_abn_rec.anomaly_class        := nvl(:anomaly_class_pr, '' '');
  p_abn_rec.problem_class        := nvl(:delay_problem_class_pr, '' '');
  p_abn_rec.cause_class          := nvl(:delay_cause_class_pr, '' '');
  p_abn_rec.cause_detailed       := nvl(:delay_cause_detailed_pr, '' '');
  p_abn_rec.detailed_reasons     := nvl(:problem_desc_pr, '' '');
  p_abn_rec.is_sup_responsible   := :is_sup_responsible;
  p_abn_rec.responsible_dept_sec := :responsible_dept_sec;
  p_abn_rec.delay_date           := :delay_date;
  p_abn_rec.delay_amount         := :delay_amount_pr;
  p_abn_rec.responsible_party    := nvl(:responsible_party, '' '');
  p_abn_rec.responsible_dept     := nvl(:responsible_dept, '' '');
  p_abn_rec.handle_opinions      := :handle_opinions;
  p_abn_rec.quality_deduction    := nvl(:quality_deduction, 0);
  p_abn_rec.is_deduction         := nvl(:is_deduction, 0);
  p_abn_rec.deduction_method     := :deduction_method_pr;
  p_abn_rec.deduction_unit_price := :deduction_unit_price_pr;
  p_abn_rec.applicant_id         := :user_id;
  p_abn_rec.applicant_date       := SYSDATE;
  p_abn_rec.create_id            := :user_id;
  p_abn_rec.create_time          := SYSDATE;
  p_abn_rec.update_id            := :user_id;
  p_abn_rec.update_time          := SYSDATE;
  p_abn_rec.origin               := ''MA'';
  p_abn_rec.memo                 := :memo_pr;

  scmdata.pkg_production_progress.handle_abnormal(p_abn_rec => p_abn_rec);

END;', 'DECLARE
  v_abnormal_code VARCHAR2(32);
  v_anomaly_class VARCHAR2(32);
  p_abn_rec       scmdata.t_abnormal%ROWTYPE;
BEGIN

  p_abn_rec.abnormal_id   := :abnormal_id_pr;
  p_abn_rec.company_id    := %default_company_id%;
  p_abn_rec.abnormal_code := :abnormal_code_pr;
  p_abn_rec.order_id      := :order_id_pr;

  SELECT MAX(abn.anomaly_class)
    INTO v_anomaly_class
    FROM scmdata.t_abnormal abn
   WHERE abn.abnormal_id = :abnormal_id_pr;

  p_abn_rec.anomaly_class := v_anomaly_class;

  IF v_anomaly_class = ''AC_DATE'' THEN
    NULL;
  ELSIF v_anomaly_class = ''AC_QUALITY''  THEN
    p_abn_rec.problem_class        := :problem_class_pr;
    p_abn_rec.cause_class          := :cause_class_pr;
    p_abn_rec.cause_detailed       := :cause_detailed_pr;
    p_abn_rec.detailed_reasons     := :detailed_reasons_pr;
    p_abn_rec.is_sup_responsible   := :is_sup_responsible;
    p_abn_rec.responsible_dept     := :responsible_dept_pr;
    p_abn_rec.responsible_dept_sec := :responsible_dept_sec_pr;
  ELSIF  v_anomaly_class = ''AC_OTHERS'' THEN
    p_abn_rec.detailed_reasons     := :detailed_reasons_pr;
    p_abn_rec.is_sup_responsible   := :is_sup_responsible;
    p_abn_rec.responsible_dept     := :responsible_dept_pr;
    p_abn_rec.responsible_dept_sec := :responsible_dept_sec_pr;
  END IF;

  p_abn_rec.delay_date           := :delay_date_pr;
  p_abn_rec.delay_amount         := :delay_amount_pr;
  p_abn_rec.responsible_party    := :responsible_party_pr;
  p_abn_rec.handle_opinions      := :handle_opinions_pr;
  p_abn_rec.is_deduction         := :is_deduction_pr;
  p_abn_rec.deduction_method     := :deduction_method_pr;
  p_abn_rec.deduction_unit_price := :deduction_unit_price_pr;
  p_abn_rec.file_id              := :file_id_pr;
  p_abn_rec.applicant_id         := :user_id;
  p_abn_rec.applicant_date       := SYSDATE;
  p_abn_rec.memo                 := :memo_pr;
  p_abn_rec.update_id            := :user_id;
  p_abn_rec.update_time          := SYSDATE;

  scmdata.pkg_production_progress.update_abnormal(p_abn_rec => p_abn_rec);

END;', 'DELETE FROM scmdata.t_abnormal abn
 WHERE abn.company_id = %default_company_id%
   AND abn.abnormal_id = :abnormal_id_pr', 'product_gress_id,company_id,supplier_code_pr,factory_code_pr,order_id_pr,abnormal_id_pr,abnormal_status_pr,is_deduction_pr,handle_opinions_pr,anomaly_class_pr,responsible_party_pr,deduction_method_pr', null, null, null, null, null, 1, null, null, null, null, null, null, null, 1, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, 0, null);

insert into bw3.sys_item_list (ITEM_ID, QUERY_TYPE, QUERY_FIELDS, QUERY_COUNT, EDIT_EXPRESS, NEWID_SQL, SELECT_SQL, DETAIL_SQL, SUBSELECT_SQL, INSERT_SQL, UPDATE_SQL, DELETE_SQL, NOSHOW_FIELDS, NOADD_FIELDS, NOMODIFY_FIELDS, NOEDIT_FIELDS, SUBNOSHOW_FIELDS, UI_TMPL, MULTI_PAGE_FLAG, OUTPUT_PARAMETER, LOCK_SQL, MONITOR_ID, END_FIELD, EXECUTE_TIME, SCANNABLE_FIELD, SCANNABLE_TYPE, AUTO_REFRESH, RFID_FLAG, SCANNABLE_TIME, MAX_ROW_COUNT, NOSHOW_APP_FIELDS, SCANNABLE_LOCATION_LINE, SUB_TABLE_JUDGE_FIELD, BACK_GROUND_ID, OPRETION_HINT, SUB_EDIT_STATE, HINT_TYPE, HEADER, FOOTER, JUMP_FIELD, JUMP_EXPRESS, OPEN_MODE, OPERATION_TYPE, OPERATE_TYPE, PAGE_SIZES)
values ('a_product_120_1', 12, 'product_gress_code_pr,rela_goo_id,supplier_company_name_pr,style_number_pr', null, null, null, 'WITH supp AS
 (SELECT sp.company_id, sp.supplier_code, sp.supplier_company_name
    FROM scmdata.t_supplier_info sp),
group_dict AS
 (SELECT group_dict_type, group_dict_value, group_dict_name
    FROM scmdata.sys_group_dict),
su_user AS
 (SELECT su.company_id, su.user_id, su.company_user_name
    FROM scmdata.sys_company_user su)
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
       --a.responsible_party responsible_party_pr,
       a.responsible_dept responsible_dept_pr,
       a.responsible_dept_sec responsible_dept_sec_pr,
       a.memo memo_pr,
       decode(t.progress_status,
              ''02'',
              (SELECT pno_status
                 FROM (SELECT pn.node_name ||
                              (SELECT a.group_dict_name
                                 FROM group_dict a
                                INNER JOIN group_dict b
                                   ON a.group_dict_type = b.group_dict_value
                                  AND b.group_dict_value = ''PROGRESS_NODE_TYPE''
                                WHERE a.group_dict_value = pn.progress_status) pno_status
                         FROM scmdata.t_production_node pn
                        WHERE pn.company_id = t.company_id
                          AND pn.product_gress_id = t.product_gress_id
                          AND pn.progress_status IS NOT NULL
                        ORDER BY pn.node_num DESC)
                WHERE rownum = 1),
              ''00'',
              (SELECT a.group_dict_name
                 FROM group_dict a
                WHERE a.group_dict_type = ''PROGRESS_TYPE''
                  AND a.group_dict_value = t.progress_status)) progress_status_desc,
       t.supplier_code supplier_code_pr,
       sp2.supplier_company_name supplier_company_name_pr,
       t.goo_id goo_id_pr,
       cf.style_number style_number_pr,
       cf.style_name style_name_pr,
       t.order_amount order_amount_pr,
       oh.delivery_date delivery_date_pr,
       --t.delivery_amount delivery_amount_pr,
       t.latest_planned_delivery_date latest_planned_delivery_date_pr,
       sa.company_user_name create_id,
       a.create_time,
       sc.company_user_name update_id,
       a.update_time,
       sb.company_user_name confirm_id,
       a.confirm_date confirm_date,
       (SELECT f.group_dict_name
          FROM scmdata.sys_group_dict f
         WHERE f.group_dict_type = ''PRODUCT_TYPE''
           AND f.group_dict_value = cf.category) cooperation_classification
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
/*LEFT JOIN supp sp1
 ON t.company_id = sp1.company_id
AND t.factory_code = sp1.supplier_code*/
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
 WHERE oh.company_id = %default_company_id%
  --AND ((%is_company_admin%) = 1  OR instr(%coop_class_priv%,cf.category) > 0)
   AND ((%is_company_admin% = 1) OR
   instr_priv(p_str1  => @subsql@ ,p_str2  => cf.category ,p_split => '';'') > 0)
 ORDER BY a.create_time DESC', null, '{declare
v_class_data_privs clob;
begin
 v_class_data_privs := pkg_data_privs.parse_json(p_jsonstr => %data_privs_json_strs%,p_key => ''COL_2'');
 @strresult :=''(SELECT * FROM (SELECT '' || '''''''' || v_class_data_privs || '''''''' || '' FROM dual))'';
end;}', null, 'DECLARE
  v_abnormal_code VARCHAR2(32);
  v_anomaly_class VARCHAR2(32);
  p_abn_rec       scmdata.t_abnormal%ROWTYPE;
BEGIN

  p_abn_rec.abnormal_id   := :abnormal_id;
  p_abn_rec.company_id    := %default_company_id%;
  p_abn_rec.abnormal_code := :abnormal_code_pr;
  p_abn_rec.order_id      := :order_id_pr;

  SELECT MAX(abn.anomaly_class)
    INTO v_anomaly_class
    FROM scmdata.t_abnormal abn
   WHERE abn.abnormal_id = :abnormal_id;

  p_abn_rec.anomaly_class := v_anomaly_class;

  IF v_anomaly_class = ''AC_DATE'' THEN
    NULL;
  ELSIF v_anomaly_class = ''AC_QUALITY''  THEN
    p_abn_rec.problem_class        := :problem_class_pr;
    p_abn_rec.cause_class          := :cause_class_pr;
    p_abn_rec.cause_detailed       := :cause_detailed_pr;
    p_abn_rec.detailed_reasons     := :detailed_reasons_pr;
    p_abn_rec.is_sup_responsible   := :is_sup_responsible;
    p_abn_rec.responsible_dept     := :responsible_dept_pr;
    p_abn_rec.responsible_dept_sec := :responsible_dept_sec_pr;
  ELSIF v_anomaly_class = ''AC_OTHERS'' THEN
    p_abn_rec.detailed_reasons     := :detailed_reasons_pr;
    p_abn_rec.is_sup_responsible   := :is_sup_responsible;
    p_abn_rec.responsible_dept     := :responsible_dept_pr;
    p_abn_rec.responsible_dept_sec := :responsible_dept_sec_pr;
  END IF;

  p_abn_rec.delay_date           := :delay_date_pr;
  p_abn_rec.delay_amount         := :delay_amount_pr;
  p_abn_rec.responsible_party    := :responsible_party_pr;
  p_abn_rec.handle_opinions      := :handle_opinions_pr;
  p_abn_rec.is_deduction         := :is_deduction_pr;
  p_abn_rec.deduction_method     := :deduction_method_pr;
  p_abn_rec.deduction_unit_price := :deduction_unit_price_pr;
  p_abn_rec.file_id              := :file_id_pr;
  p_abn_rec.applicant_id         := :user_id;
  p_abn_rec.applicant_date       := SYSDATE;
  p_abn_rec.memo                 := :memo_pr;
  p_abn_rec.update_id            := :user_id;
  p_abn_rec.update_time          := SYSDATE;

  scmdata.pkg_production_progress.update_abnormal(p_abn_rec => p_abn_rec);

END;


/*DECLARE
  v_abnormal_code VARCHAR2(32);
  p_abn_rec       scmdata.t_abnormal%ROWTYPE;
BEGIN

  p_abn_rec.abnormal_id          := :abnormal_id;
  p_abn_rec.company_id           := %default_company_id%;
  p_abn_rec.abnormal_code        := :abnormal_code_pr;
  p_abn_rec.order_id             := :order_id_pr;
  --p_abn_rec.goo_id             := :rela_goo_id;
  p_abn_rec.anomaly_class        := :anomaly_class_pr;
  p_abn_rec.problem_class        := :problem_class_pr;
  p_abn_rec.cause_class          := :cause_class_pr;
  p_abn_rec.detailed_reasons     := :detailed_reasons_pr;
  p_abn_rec.delay_date           := :delay_date_pr;
  p_abn_rec.delay_amount         := :delay_amount_pr;
  p_abn_rec.responsible_party    := :responsible_party_pr;
  p_abn_rec.responsible_dept     := :responsible_dept_pr;
  p_abn_rec.handle_opinions      := :handle_opinions_pr;
  p_abn_rec.is_deduction         := :is_deduction_pr;
  p_abn_rec.deduction_method     := :deduction_method_pr;
  p_abn_rec.deduction_unit_price := :deduction_unit_price_pr;
  p_abn_rec.file_id              := :file_id_pr;
  p_abn_rec.applicant_id         := :user_id;
  p_abn_rec.applicant_date       := sysdate;
  p_abn_rec.memo                 := :memo_pr;
  p_abn_rec.update_id            := :user_id;
  p_abn_rec.update_time          := SYSDATE;

  scmdata.pkg_production_progress.update_abnormal(p_abn_rec => p_abn_rec);

END;*/', 'DECLARE
  v_flag     NUMBER;
  v_abn_flag NUMBER;
  p_abn_rec  scmdata.t_abnormal%ROWTYPE;
BEGIN
  p_abn_rec.company_id := %default_company_id%;
  p_abn_rec.order_id   := :order_id_pr;
  p_abn_rec.goo_id     := :goo_id_pr;

  DELETE FROM scmdata.t_abnormal abn
   WHERE abn.company_id = %default_company_id%
     AND abn.abnormal_id = :abnormal_id;

  --1.校验待处理列表是否有异常单，有则处理中，
  --2.无则校验已处理列表是否有异常单，有则已处理，无则无异常
  SELECT COUNT(1)
    INTO v_flag
    FROM scmdata.t_abnormal t
   WHERE t.company_id = p_abn_rec.company_id
        AND t.order_id = p_abn_rec.order_id
     AND t.goo_id = p_abn_rec.goo_id
     AND t.progress_status = ''01'';

  IF v_flag > 0 THEN

    scmdata.pkg_production_progress.sync_abnormal(p_abn_rec => p_abn_rec,
                                                  p_status  => ''01'');
  ELSE

    SELECT COUNT(1)
      INTO v_abn_flag
      FROM scmdata.t_abnormal t
     WHERE t.company_id = p_abn_rec.company_id
        AND t.order_id = p_abn_rec.order_id
       AND t.goo_id = p_abn_rec.goo_id
       AND t.progress_status = ''02'';

    IF v_abn_flag > 0 THEN
      p_abn_rec.handle_opinions := :handle_opinions_pr;
      scmdata.pkg_production_progress.sync_abnormal(p_abn_rec => p_abn_rec,
                                                    p_status  => ''02'');
    ELSE
      p_abn_rec.handle_opinions := '''';
      scmdata.pkg_production_progress.sync_abnormal(p_abn_rec => p_abn_rec,
                                                    p_status  => ''00'');
    END IF;

  END IF;
END;', 'abnormal_id,anomaly_class_pr,product_gress_id,company_id,supplier_code_pr,factory_code_pr,order_id_pr,abnormal_status_pr,handle_opinions_pr,is_deduction_pr,confirm_id,confirm_date,deduction_method_pr,responsible_party_pr', null, null, null, null, null, 1, null, null, null, null, null, null, null, 1, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, 0, null);

insert into bw3.sys_item_list (ITEM_ID, QUERY_TYPE, QUERY_FIELDS, QUERY_COUNT, EDIT_EXPRESS, NEWID_SQL, SELECT_SQL, DETAIL_SQL, SUBSELECT_SQL, INSERT_SQL, UPDATE_SQL, DELETE_SQL, NOSHOW_FIELDS, NOADD_FIELDS, NOMODIFY_FIELDS, NOEDIT_FIELDS, SUBNOSHOW_FIELDS, UI_TMPL, MULTI_PAGE_FLAG, OUTPUT_PARAMETER, LOCK_SQL, MONITOR_ID, END_FIELD, EXECUTE_TIME, SCANNABLE_FIELD, SCANNABLE_TYPE, AUTO_REFRESH, RFID_FLAG, SCANNABLE_TIME, MAX_ROW_COUNT, NOSHOW_APP_FIELDS, SCANNABLE_LOCATION_LINE, SUB_TABLE_JUDGE_FIELD, BACK_GROUND_ID, OPRETION_HINT, SUB_EDIT_STATE, HINT_TYPE, HEADER, FOOTER, JUMP_FIELD, JUMP_EXPRESS, OPEN_MODE, OPERATION_TYPE, OPERATE_TYPE, PAGE_SIZES)
values ('a_product_120_2', 12, 'product_gress_code_pr,rela_goo_id,supplier_company_name_pr,style_number_pr', null, null, null, 'WITH supp AS
 (SELECT sp.company_id, sp.supplier_code, sp.supplier_company_name
    FROM scmdata.t_supplier_info sp),
group_dict AS
 (SELECT group_dict_type, group_dict_value, group_dict_name
    FROM scmdata.sys_group_dict),
su_user AS
 (SELECT su.company_id, su.user_id, su.company_user_name
    FROM scmdata.sys_company_user su)
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
       a.delay_amount delay_amount_pr, --延期数量
       a.handle_opinions handle_opinions_pr,
       a.is_deduction is_deduction_pr,
       (SELECT b.group_dict_name
          FROM group_dict b
         WHERE b.group_dict_type = ''DEDUCTION_METHOD''
           AND b.group_dict_value = a.deduction_method) deduction_method_desc,
       a.deduction_unit_price deduction_unit_price_pr,
       a.file_id file_id_pr,
       a.problem_class problem_class_pr,
       a.cause_class cause_class_pr,
       a.cause_detailed cause_detailed_pr,
       a.is_sup_responsible,
       --a.responsible_party responsible_party_pr,
       a.responsible_dept responsible_dept_pr,
       a.responsible_dept_sec responsible_dept_sec_pr,
       a.memo memo_pr,
       decode(t.progress_status,
              ''02'',
              (SELECT pno_status
                 FROM (SELECT pn.node_name ||
                              (SELECT a.group_dict_name
                                 FROM group_dict a
                                INNER JOIN group_dict b
                                   ON a.group_dict_type = b.group_dict_value
                                  AND b.group_dict_value = ''PROGRESS_NODE_TYPE''
                                WHERE a.group_dict_value = pn.progress_status) pno_status
                         FROM scmdata.t_production_node pn
                        WHERE pn.company_id = t.company_id
                          AND pn.product_gress_id = t.product_gress_id
                          AND pn.progress_status IS NOT NULL
                        ORDER BY pn.node_num DESC)
                WHERE rownum = 1),
              (SELECT a.group_dict_name
                 FROM group_dict a
                WHERE a.group_dict_type = ''PROGRESS_TYPE''
                  AND a.group_dict_value = t.progress_status)) progress_status_desc,
       t.supplier_code supplier_code_pr,
       sp2.supplier_company_name supplier_company_name_pr,
       t.goo_id goo_id_pr,
       cf.style_number style_number_pr,
       cf.style_name style_name_pr,
       t.order_amount order_amount_pr,
       oh.delivery_date delivery_date_pr,
       --t.delivery_amount delivery_amount_pr,
       t.latest_planned_delivery_date latest_planned_delivery_date_pr,
       sa.company_user_name create_id,
       a.create_time,
       sc.company_user_name update_id,
       a.update_time,
       sb.company_user_name confirm_id,
       a.confirm_date confirm_date,
       (SELECT f.group_dict_name
          FROM scmdata.sys_group_dict f
         WHERE f.group_dict_type = ''PRODUCT_TYPE''
           AND f.group_dict_value = cf.category) cooperation_classification
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
/*LEFT JOIN supp sp1
 ON t.company_id = sp1.company_id
AND t.factory_code = sp1.supplier_code*/
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
 WHERE oh.company_id = %default_company_id%
  --AND ((%is_company_admin%) = 1  OR instr(%coop_class_priv%,cf.category) > 0)
  AND ((%is_company_admin% = 1) OR
  instr_priv(p_str1  => @subsql@ ,p_str2  => cf.category ,p_split => '';'') > 0)
 ORDER BY a.confirm_date DESC', null, '{declare
v_class_data_privs clob;
begin
 v_class_data_privs := pkg_data_privs.parse_json(p_jsonstr => %data_privs_json_strs%,p_key => ''COL_2'');
 @strresult :=''(SELECT * FROM (SELECT '' || '''''''' || v_class_data_privs || '''''''' || '' FROM dual))'';
end;}', null, null, null, 'anomaly_class_pr,product_gress_id,company_id,supplier_code_pr,factory_code_pr,order_id_pr,abnormal_id,abnormal_status_pr,handle_opinions_pr,is_deduction_pr', null, null, null, null, null, 1, null, null, null, null, null, null, null, 1, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, 0, null);

prompt Done.
