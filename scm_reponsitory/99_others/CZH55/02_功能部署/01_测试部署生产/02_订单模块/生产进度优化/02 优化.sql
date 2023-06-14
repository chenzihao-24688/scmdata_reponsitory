DECLARE
  v_sql CLOB;
BEGIN
  v_sql := 'SELECT a.group_dict_value abn_range,
       a.group_dict_name abn_range_desc,
       null  DELAY_AMOUNT_PR
  FROM scmdata.sys_group_dict a
 WHERE a.group_dict_type = ''ABN_RANGE''
   AND a.pause = 0
UNION ALL
SELECT abn_range,
       abn_range_desc,
       null  DELAY_AMOUNT_PR
  FROM (SELECT DISTINCT tcs.color_code abn_range,
                        tcs.colorname  abn_range_desc
          FROM scmdata.t_ordersitem od
         INNER JOIN scmdata.t_commodity_info tc
            ON od.goo_id = tc.goo_id
         INNER JOIN scmdata.t_commodity_color_size tcs
            ON tc.commodity_info_id = tcs.commodity_info_id
           AND od.barcode = tcs.barcode
         WHERE od.company_id = %default_company_id%
           AND od.order_id = :order_id_pr
           AND od.goo_id = :goo_id_pr) v';
  UPDATE bw3.sys_pick_list t
     SET t.pick_sql     = v_sql,
         t.other_fields = 'ABN_RANGE,ABN_RANGE_DESC,DELAY_AMOUNT_PR',t.seperator = ' '
   WHERE t.element_id = 'pick_a_product_118_6';
   
  update bw3.sys_item_element_rela t set t.pause = 0 where t.element_id = 'pick_a_product_118_6';
END;
/
begin
update bw3.sys_field_list t set t.requiered_flag = 0 ,t.check_express = null,t.check_message = null where t.field_name = 'DELAY_AMOUNT_PR';
end;
/
--20220505 修改
declare
v_sql clob;
v_sql1 clob;
begin
  v_sql :='DECLARE
  v_abnormal_code VARCHAR2(32);
  v_anomaly_class VARCHAR2(32);
  p_abn_rec       scmdata.t_abnormal%ROWTYPE;
  v_order_amount  NUMBER;
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
  ELSIF v_anomaly_class IN (''AC_QUALITY'', ''AC_OTHERS'') THEN
    p_abn_rec.problem_class        := :problem_class_pr;
    p_abn_rec.cause_class          := :cause_class_pr;
    p_abn_rec.cause_detailed       := :cause_detailed_pr;
    p_abn_rec.detailed_reasons     := :detailed_reasons_pr;
    p_abn_rec.is_sup_responsible   := :is_sup_responsible;
    p_abn_rec.responsible_dept     := :responsible_dept_pr;
    p_abn_rec.responsible_dept_sec := :responsible_dept_sec_pr;
  ELSE
    NULL;
  END IF;

  p_abn_rec.delay_date     := :delay_date_pr;
  p_abn_rec.abnormal_range := :abn_range;

  IF '' '' || :abn_range || '' '' = '' 00 '' THEN
    SELECT nvl(MAX(t.order_amount), 0)
      INTO v_order_amount
      FROM scmdata.t_production_progress t
     WHERE t.goo_id = :goo_id_pr
       AND t.order_id = :order_id_pr
       AND t.company_id = %default_company_id%;
  
    IF :delay_amount_pr IS NULL OR instr(:delay_amount_pr, '' '') > 0 OR
       :delay_amount_pr = v_order_amount THEN
      NULL;
    ELSE
      raise_application_error(-20002,
                              ''保存失败！异常范围选择全部时，无需填写异常数量！'');
    END IF;
  
    p_abn_rec.delay_amount := v_order_amount;
  
  ELSIF '' '' || :abn_range || '' '' = '' 01 '' THEN
    p_abn_rec.delay_amount := :delay_amount_pr;
  ELSE
    SELECT SUM(CASE
                 WHEN instr('' '' || :abn_range || '' '',
                            '' '' || tcs.color_code || '' '') > 0 THEN
                  od.order_amount
                 ELSE
                  0
               END) order_amount
      INTO v_order_amount
      FROM scmdata.t_ordersitem od
     INNER JOIN scmdata.t_commodity_info tc
        ON od.goo_id = tc.goo_id
     INNER JOIN scmdata.t_commodity_color_size tcs
        ON tc.commodity_info_id = tcs.commodity_info_id
       AND od.barcode = tcs.barcode
     WHERE od.goo_id = :goo_id_pr
       AND od.order_id = :order_id_pr
       AND od.company_id = %default_company_id%;
    IF :delay_amount_pr IS NULL OR instr(:delay_amount_pr, '' '') > 0 OR
       :delay_amount_pr = v_order_amount THEN
      NULL;
    ELSE
      raise_application_error(-20002,
                              ''保存失败！异常范围选择订单颜色时，无需填写异常数量！'');
    END IF;
    p_abn_rec.delay_amount := v_order_amount;
  END IF;

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

END;';
v_sql1 := 'DECLARE
  v_abnormal_code VARCHAR2(32);
  v_anomaly_class VARCHAR2(32);
  p_abn_rec       scmdata.t_abnormal%ROWTYPE;
  v_flag          NUMBER;
  v_order_amount  NUMBER;
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
  ELSIF v_anomaly_class IN (''AC_QUALITY'', ''AC_OTHERS'') THEN
    p_abn_rec.problem_class        := :problem_class_pr;
    p_abn_rec.cause_class          := :cause_class_pr;
    p_abn_rec.cause_detailed       := :cause_detailed_pr;
    p_abn_rec.detailed_reasons     := :detailed_reasons_pr;
    p_abn_rec.is_sup_responsible   := :is_sup_responsible;
    p_abn_rec.responsible_dept     := :responsible_dept_pr;
    p_abn_rec.responsible_dept_sec := :responsible_dept_sec_pr;
  ELSE
    NULL;
  END IF;

  p_abn_rec.delay_date     := :delay_date_pr;
  p_abn_rec.abnormal_range := :abn_range;

  IF '' '' || :abn_range || '' '' = '' 00 '' THEN
  
    SELECT nvl(MAX(t.order_amount), 0)
      INTO v_order_amount
      FROM scmdata.t_production_progress t
     WHERE t.goo_id = :goo_id_pr
       AND t.order_id = :order_id_pr
       AND t.company_id = %default_company_id%;
  
    IF :delay_amount_pr IS NULL OR instr(:delay_amount_pr, '' '') > 0 OR
       :delay_amount_pr = v_order_amount THEN
      NULL;
    ELSE
      raise_application_error(-20002,
                              ''保存失败！异常范围选择全部时，无需填写异常数量！'');
    END IF;
    p_abn_rec.delay_amount := v_order_amount;
  ELSIF '' '' || :abn_range || '' '' = '' 01 '' THEN
    p_abn_rec.delay_amount := :delay_amount_pr;
  ELSE
    SELECT SUM(CASE
                 WHEN instr('' '' || :abn_range || '' '',
                            '' '' || tcs.color_code || '' '') > 0 THEN
                  od.order_amount
                 ELSE
                  0
               END) order_amount
      INTO v_order_amount
      FROM scmdata.t_ordersitem od
     INNER JOIN scmdata.t_commodity_info tc
        ON od.goo_id = tc.goo_id
     INNER JOIN scmdata.t_commodity_color_size tcs
        ON tc.commodity_info_id = tcs.commodity_info_id
       AND od.barcode = tcs.barcode
     WHERE od.goo_id = :goo_id_pr
       AND od.order_id = :order_id_pr
       AND od.company_id = %default_company_id%;
    IF :delay_amount_pr IS NULL OR instr(:delay_amount_pr, '' '') > 0 OR
       :delay_amount_pr = v_order_amount THEN
      NULL;
    ELSE
      raise_application_error(-20002,
                              ''保存失败！异常范围选择订单颜色时，无需填写异常数量！'');
    END IF;
    p_abn_rec.delay_amount := v_order_amount;
  END IF;
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

END;';
update bw3.sys_item_list t set t.update_sql = v_sql where t.item_id = 'a_product_118';
update bw3.sys_item_list t set t.update_sql = v_sql1 where t.item_id = 'a_product_120_1';
update bw3.sys_item_list t set t.noedit_fields = 'GOO_ID_PR' where t.item_id in ('a_product_118','a_product_120_1') ;
end;
/
declare
v_sql clob;
begin
  v_sql := q'[WITH supp AS
 (SELECT sp.company_id, sp.supplier_code, sp.supplier_company_name
    FROM scmdata.t_supplier_info sp
   WHERE sp.company_id = %default_company_id%),
group_dict AS
 (SELECT group_dict_type, group_dict_value, group_dict_name
    FROM scmdata.sys_group_dict)
SELECT t.product_gress_id,
       t.company_id,
       t.product_gress_code product_gress_code_pr,
       decode(t.progress_status,
              '02',
              (SELECT pno_status
                 FROM (SELECT pn.node_name ||
                              (SELECT a.group_dict_name
                                 FROM group_dict a
                                INNER JOIN group_dict b
                                   ON a.group_dict_type = b.group_dict_value
                                  AND b.group_dict_value = 'PROGRESS_NODE_TYPE'
                                WHERE a.group_dict_value = pn.progress_status) pno_status
                         FROM scmdata.t_production_node pn
                        WHERE pn.company_id = t.company_id
                          AND pn.product_gress_id = t.product_gress_id
                          AND pn.progress_status IS NOT NULL
                        ORDER BY pn.node_num DESC)
                WHERE rownum = 1),
              '00',
              (SELECT a.group_dict_name
                 FROM group_dict a
                WHERE a.group_dict_type = 'PROGRESS_TYPE'
                  AND a.group_dict_value = t.progress_status)) progress_status_desc,
       t.order_id order_id_pr,
       t.goo_id goo_id_pr, --这里goo_id是货号
       cf.rela_goo_id,
       cf.style_number style_number_pr,
       cf.style_name style_name_pr,
       t.supplier_code supplier_code_pr,
       sp2.supplier_company_name supplier_company_name_pr,
       t.factory_code factory_code_pr,
       sp1.supplier_company_name factory_company_name_pr,
       /*nvl(MAX(od.delivery_date) over(PARTITION BY od.order_id),
           od.delivery_date) delivery_date_pr,*/ --最新计划交期,有值时取‘最新计划交期’，无则取‘计划交期’
       oh.delivery_date delivery_date_pr,
       t.forecast_delivery_date forecast_delivery_date_pr,
       decode(sign(ceil(t.forecast_delivery_date - od.delivery_date)),
              -1,
              0,
              ceil(t.forecast_delivery_date - od.delivery_date)) forecast_delay_day_pr,
       --t.latest_planned_delivery_date latest_planned_delivery_date_pr,
       nvl(MAX(od.delivery_date) over(PARTITION BY od.order_id),
           od.delivery_date) latest_planned_delivery_date_pr,
       t.actual_delivery_date actual_delivery_date_pr,
       t.actual_delay_day actual_delay_day_pr,
       t.order_amount order_amount_pr,
       t.delivery_amount delivery_amount_pr,
       decode(sign(t.order_amount - t.delivery_amount),-1,0,t.order_amount - t.delivery_amount) owe_amount_pr,
       (SELECT gd.group_dict_name
          FROM scmdata.sys_group_dict gd
        WHERE gd.group_dict_type = 'APPROVE_STATUS'
          AND gd.group_dict_value = t.approve_edition) approve_edition_pr,
       decode(t.fabric_check,
              'FABRIC_EVELUATE_PASS',
              '通过',
              'FABRIC_EVELUATE_NO_PASS',
              '不通过',
              '') fabric_check_pr,
       decode(t.exception_handle_status,
              '01',
              '处理中',
              '02',
              '已处理',
              '无异常') exception_handle_status_pr,
       (SELECT gd.group_dict_name
          FROM group_dict gd
         WHERE gd.group_dict_type = 'HANDLE_RESULT'
           AND gd.group_dict_value = t.handle_opinions) HANDLE_OPINIONS_PR,
       t.progress_status progress_status_pr,
       'AC_OTHERS' ANOMALY_CLASS_PR,
       NULL delay_problem_class_pr,
       NULL delay_cause_class_pr,
       NULL delay_cause_detailed_pr
  FROM scmdata.t_ordered oh
 INNER JOIN scmdata.t_orders od
    ON oh.company_id = od.company_id
   AND oh.order_code = od.order_id
   AND oh.order_status = 'OS01' --待修改
 INNER JOIN t_production_progress t
    ON t.company_id = od.company_id
   AND t.order_id = od.order_id
   AND t.goo_id = od.goo_id
   AND t.progress_status <> '01'
 INNER JOIN scmdata.t_commodity_info cf
    ON t.company_id = cf.company_id
   AND t.goo_id = cf.goo_id
  LEFT JOIN supp sp1
    ON t.company_id = sp1.company_id
   AND t.factory_code = sp1.supplier_code
 INNER JOIN supp sp2
    ON t.company_id = sp2.company_id
   AND t.supplier_code = sp2.supplier_code
 WHERE oh.company_id = %default_company_id%
  --AND (%is_company_admin% = 1 OR instr(%coop_class_priv%,cf.category)>0)
  AND ((%is_company_admin% = 1) OR
  instr_priv(p_str1  => pkg_data_privs.parse_json(p_jsonstr => %data_privs_json_strs%,p_key => 'COL_2'),p_str2  => cf.category ,p_split => ';') > 0 )
  ]';
update bw3.sys_action t set t.action_sql = v_sql where t.element_id = 'action_a_product_118_4'; 
end;
