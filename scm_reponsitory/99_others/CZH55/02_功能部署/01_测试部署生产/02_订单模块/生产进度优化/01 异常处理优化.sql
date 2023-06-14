alter table scmdata.t_abnormal add  abnormal_range VARCHAR2(32);
/
alter table scmdata.t_abnormal add  DELIVERY_AMOUNT VARCHAR2(32);
/
begin
update bw3.sys_field_list t set t.caption = '异常数量' where t.field_name = 'DELAY_AMOUNT_PR';
insert into bw3.sys_field_list (FIELD_NAME, CAPTION, REQUIERED_FLAG, INPUT_HINT, VALID_CHARS, INVALID_CHARS, CHECK_EXPRESS, CHECK_MESSAGE, READ_ONLY_FLAG, NO_EDIT, NO_COPY, NO_SUM, NO_SORT, ALIGNMENT, MAX_LENGTH, MIN_LENGTH, DISPLAY_WIDTH, DISPLAY_FORMAT, EDIT_FORMT, DATA_TYPE, MAX_VALUE, MIN_VALUE, DEFAULT_VALUE, IME_CARE, IME_OPEN, VALUE_LISTS, VALUE_LIST_TYPE, HYPER_RES, MULTI_VALUE_FLAG, TRUE_EXPR, FALSE_EXPR, NAME_RULE_FLAG, NAME_RULE_ID, DATA_TYPE_FLAG, ALLOW_SCAN, VALUE_ENCRYPT, VALUE_SENSITIVE, OPERATOR_FLAG, VALUE_DISPLAY_STYLE, TO_ITEM_ID, VALUE_SENSITIVE_REPLACEMENT, STORE_SOURCE, ENABLE_STAND_PERMISSION)
values ('ABN_RANGE_DESC', '异常范围', 1, null, null, null, null, null, 0, 0, 0, 0, 0, 3, null, null, null, null, null, '10', null, null, null, 0, 0, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into bw3.sys_element (ELEMENT_ID, ELEMENT_TYPE, DATA_SOURCE, PAUSE, MESSAGE, IS_HIDE, MEMO, IS_ASYNC, IS_PER_EXE, ENABLE_STAND_PERMISSION)
values ('pick_a_product_118_6', 'pick', 'oracle_scmdata', 0, null, null, null, null, null, null);
insert into bw3.sys_pick_list (ELEMENT_ID, FIELD_NAME, CAPTION, PICK_SQL, FROM_FIELD, QUERY_FIELDS, OTHER_FIELDS, TREE_FIELDS, LEVEL_FIELD, IMAGE_NAMES, TREE_ID, SEPERATOR, MULTI_VALUE_FLAG, RECURSION_FLAG, CUSTOM_QUERY, NAME_LIST_SQL, PORT_ID, PORT_SQL)
values ('pick_a_product_118_6', 'ABN_RANGE_DESC', '异常范围', 'SELECT a.group_dict_value abn_range,
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
           AND od.goo_id = :goo_id_pr) v

', 'ABN_RANGE_DESC', 'ABN_RANGE_DESC', 'ABN_RANGE,ABN_RANGE_DESC', 'ABN_RANGE_DESC', null, null, null, ';', 1, 0, 0, null, null, null);

insert into bw3.sys_item_element_rela (ITEM_ID, ELEMENT_ID, SEQ_NO, PAUSE, LEVEL_NO)
values ('a_product_120_1', 'pick_a_product_118_6', 1, 0, null);

insert into bw3.sys_item_element_rela (ITEM_ID, ELEMENT_ID, SEQ_NO, PAUSE, LEVEL_NO)
values ('a_product_118', 'pick_a_product_118_6', 1, 0, null);

insert into bw3.sys_item_element_rela (ITEM_ID, ELEMENT_ID, SEQ_NO, PAUSE, LEVEL_NO)
values ('a_product_120_2', 'pick_a_product_118_6', 1, 1, null);

end;
/
declare
v_sql clob;
v_sql1 clob;
v_sql2 clob;
begin
v_sql := 'WITH supp AS
 (SELECT sp.company_id, sp.supplier_code, sp.supplier_company_name
    FROM scmdata.t_supplier_info sp
   WHERE sp.company_id = %default_company_id%),
group_dict AS
 (SELECT group_dict_type, group_dict_value, group_dict_name
    FROM scmdata.sys_group_dict),
color_dict AS
 (SELECT a.group_dict_value abn_range,
         a.group_dict_name abn_range_desc,
         '''' order_id,
         '''' goo_id
    FROM scmdata.sys_group_dict a
   WHERE a.group_dict_type = ''ABN_RANGE''
     AND a.pause = 0
  UNION ALL
  SELECT tcs.color_code abn_range,
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
       listagg(ld.abn_range_desc,'' '')over(partition by a.abnormal_code) ABN_RANGE_DESC,
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
       decode(t.progress_status, ''02'',pno.pno_status,''00'',gd_b.group_dict_name) progress_status_desc,
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
  LEFT JOIN (SELECT pno_status, product_gress_id
               FROM (SELECT row_number() over(partition by pn.product_gress_id order by pn.node_num desc) rn,
                            pn.node_name || gd_a.group_dict_name pno_status,
                            pn.product_gress_id
                       FROM scmdata.t_production_node pn
                      inner join group_dict gd_a
                         on gd_a.group_dict_type = ''PROGRESS_NODE_TYPE''
                        and gd_a.group_dict_value = pn.progress_status
                      WHERE pn.company_id = %default_company_id%
                        AND pn.progress_status IS NOT NULL)
              where rn = 1) pno
    on pno.product_gress_id = t.product_gress_id
  LEFT JOIN group_dict gd_b
    on gd_b.group_dict_type = ''PROGRESS_TYPE''
   AND gd_b.group_dict_value = t.progress_status
 INNER JOIN scmdata.t_abnormal a
    ON t.company_id = a.company_id
   AND t.order_id = a.order_id
   AND t.goo_id = a.goo_id
   AND a.progress_status = ''00''
  LEFT JOIN group_dict gd
    ON gd.group_dict_type = ''ANOMALY_CLASSIFICATION_DICT''
   AND gd.group_dict_value = a.anomaly_class
 LEFT JOIN color_dict ld
    ON (CASE
         WHEN a.abnormal_range = ''00'' THEN
          '' 00 ''
         WHEN a.abnormal_range = ''01'' THEN
          '' 01 ''
         ELSE
          '' 02 ''
       END) = '' '' || ld.abn_range || '' ''
    OR (instr('' '' || a.abnormal_range || '' '', '' '' || ld.abn_range || '' '') > 0 AND
       ld.order_id = a.order_id AND ld.goo_id = a.goo_id)
 WHERE oh.company_id = %default_company_id%
   AND a.create_id = :user_id AND ((%is_company_admin% = 1) OR instr_priv(p_str1 => @subsql@, p_str2 => cf.category, p_split => '';'') > 0) ORDER BY a.create_time DESC )';
   
 v_sql1 := 'DECLARE
  v_abnormal_code VARCHAR2(32);
  p_abn_rec       scmdata.t_abnormal%ROWTYPE;
  v_order_amount number;
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
  p_abn_rec.abnormal_range       := ''00'';
  
  SELECT nvl(max(t.order_amount),0) into v_order_amount
  FROM scmdata.t_production_progress t
 WHERE t.goo_id = :goo_id_pr AND t.order_id = :order_id_pr
   AND t.company_id = %default_company_id%;
   
  p_abn_rec.delay_amount         := v_order_amount;
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

END;';
v_sql2 := 'DECLARE
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
  ELSIF v_anomaly_class = ''AC_QUALITY'' THEN
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

  p_abn_rec.delay_date     := :delay_date_pr;
  p_abn_rec.abnormal_range := :abn_range;

  IF instr('' '' || :abn_range || '' '', '' 00 '') > 0 THEN
    IF :delay_amount_pr IS NULL OR instr(:delay_amount_pr, '' '') > 0 THEN
      NULL;
    ELSE
      raise_application_error(-20002,
                              ''保存失败！异常范围选择全部/订单颜色时，无需填写异常数量！'');
    END IF;
    SELECT nvl(MAX(t.order_amount), 0)
      INTO v_order_amount
      FROM scmdata.t_production_progress t
     WHERE t.goo_id = :goo_id_pr
       AND t.order_id = :order_id_pr
       AND t.company_id = %default_company_id%;
  
    p_abn_rec.delay_amount := v_order_amount;
  
  ELSIF instr('' '' || :abn_range || '' '', '' 01 '') > 0 THEN
    p_abn_rec.delay_amount := :delay_amount_pr;
  ELSE
    IF :delay_amount_pr IS NULL OR instr(:delay_amount_pr, '' '') > 0 THEN
      NULL;
    ELSE
      raise_application_error(-20002,
                              ''保存失败！异常范围选择全部/订单颜色时，无需填写异常数量！'');
    END IF;
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
update bw3.sys_item_list t set t.select_sql = v_sql,t.insert_sql = v_sql1,t.update_sql = v_sql2,t.noshow_fields = 'PRODUCT_GRESS_ID,COMPANY_ID,SUPPLIER_CODE_PR,FACTORY_CODE_PR,ORDER_ID_PR,ABNORMAL_ID_PR,ABNORMAL_STATUS_PR,IS_DEDUCTION_PR,HANDLE_OPINIONS_PR,ANOMALY_CLASS_PR,RESPONSIBLE_PARTY_PR,DEDUCTION_METHOD_PR,ABN_RANGE' where t.item_id = 'a_product_118';
end;
/
declare
v_sql clob;
v_sql1 clob;
v_sql2 clob;
begin
v_sql := 'WITH supp AS
 (SELECT sp.company_id, sp.supplier_code, sp.supplier_company_name
    FROM scmdata.t_supplier_info sp),
group_dict AS
 (SELECT group_dict_type, group_dict_value, group_dict_name
    FROM scmdata.sys_group_dict),
su_user AS
 (SELECT su.company_id, su.user_id, su.company_user_name
    FROM scmdata.sys_company_user su),
color_dict AS
 (SELECT a.group_dict_value abn_range,
         a.group_dict_name abn_range_desc,
         '''' order_id,
         '''' goo_id
    FROM scmdata.sys_group_dict a
   WHERE a.group_dict_type = ''ABN_RANGE''
     AND a.pause = 0
  UNION ALL
  SELECT tcs.color_code abn_range,
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
       listagg(ld.abn_range_desc,'' '')over(partition by a.abnormal_code) ABN_RANGE_DESC,
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
       decode(t.progress_status,
              ''02'',
              pno.pno_status,
              ''00'',
              gd_b.group_dict_name) progress_status_desc,
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
  LEFT JOIN (SELECT pno_status, product_gress_id
               FROM (SELECT row_number() over(partition by pn.product_gress_id order by pn.node_num desc) rn,
                            pn.node_name || gd_a.group_dict_name pno_status,
                            pn.product_gress_id
                       FROM scmdata.t_production_node pn
                      inner join group_dict gd_a
                         on gd_a.group_dict_type = ''PROGRESS_NODE_TYPE''
                        and gd_a.group_dict_value = pn.progress_status
                      WHERE pn.company_id = %default_company_id%
                        AND pn.progress_status IS NOT NULL)
              WHERE rn = 1) pno
    ON pno.product_gress_id = t.product_gress_id
  LEFT JOIN group_dict gd_b
    ON gd_b.group_dict_type = ''PROGRESS_TYPE''
   AND gd_b.group_dict_value = t.progress_status
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
 LEFT JOIN color_dict ld
    ON (CASE
         WHEN a.abnormal_range = ''00'' THEN
          '' 00 ''
         WHEN a.abnormal_range = ''01'' THEN
          '' 01 ''
         ELSE
          '' 02 ''
       END) = '' '' || ld.abn_range || '' ''
    OR (instr('' '' || a.abnormal_range || '' '', '' '' || ld.abn_range || '' '') > 0 AND
       ld.order_id = a.order_id AND ld.goo_id = a.goo_id)
 WHERE oh.company_id = %default_company_id%
   AND ((%is_company_admin% = 1) OR
   instr_priv(p_str1  => @subsql@ ,p_str2  => cf.category ,p_split => '';'') > 0)
 ORDER BY a.create_time DESC)';
    
   v_sql1 := 'DECLARE
  v_abnormal_code VARCHAR2(32);
  v_anomaly_class VARCHAR2(32);
  p_abn_rec       scmdata.t_abnormal%ROWTYPE;
  v_flag number;
  v_order_amount number;
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
  p_abn_rec.abnormal_range       := :abn_range;
  
  IF instr('' '' || :abn_range || '' '', '' 00 '') > 0 THEN
    IF :delay_amount_pr IS NULL OR instr(:delay_amount_pr, '' '') > 0 THEN
      NULL;
    ELSE
      raise_application_error(-20002,
                              ''保存失败！异常范围选择全部/订单颜色时，无需填写异常数量！'');
    END IF;
  SELECT nvl(max(t.order_amount),0) into v_order_amount
  FROM scmdata.t_production_progress t
 WHERE t.goo_id = :goo_id_pr AND t.order_id = :order_id_pr
   AND t.company_id = %default_company_id%;
   p_abn_rec.delay_amount := v_order_amount;
  ELSIF instr('' ''||:abn_range||'' '','' 01 '') > 0 THEN
   p_abn_rec.delay_amount         := :delay_amount_pr;
  ELSE
    IF :delay_amount_pr IS NULL OR instr(:delay_amount_pr, '' '') > 0 THEN
      NULL;
    ELSE
      raise_application_error(-20002,
                              ''保存失败！异常范围选择全部/订单颜色时，无需填写异常数量！'');
    END IF;
   SELECT SUM(CASE
                 WHEN instr('' '' || :abn_range || '' '', '' '' || tcs.color_code || '' '') > 0 THEN
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
update bw3.sys_item_list t set t.select_sql = v_sql,t.update_sql = v_sql1,t.noshow_fields = 'ABNORMAL_ID,ANOMALY_CLASS_PR,PRODUCT_GRESS_ID,COMPANY_ID,SUPPLIER_CODE_PR,FACTORY_CODE_PR,ORDER_ID_PR,ABNORMAL_STATUS_PR,HANDLE_OPINIONS_PR,IS_DEDUCTION_PR,CONFIRM_ID,CONFIRM_DATE,DEDUCTION_METHOD_PR,RESPONSIBLE_PARTY_PR,ABN_RANGE' where t.item_id = 'a_product_120_1';
end;
/
declare
v_sql clob;
v_sql1 clob;
v_sql2 clob;
begin
v_sql := 'WITH supp AS
 (SELECT sp.company_id, sp.supplier_code, sp.supplier_company_name
    FROM scmdata.t_supplier_info sp),
group_dict AS
 (SELECT group_dict_type, group_dict_value, group_dict_name
    FROM scmdata.sys_group_dict),
su_user AS
 (SELECT su.company_id, su.user_id, su.company_user_name
    FROM scmdata.sys_company_user su),
color_dict AS
 (SELECT a.group_dict_value abn_range,
         a.group_dict_name abn_range_desc,
         '''' order_id,
         '''' goo_id
    FROM scmdata.sys_group_dict a
   WHERE a.group_dict_type = ''ABN_RANGE''
     AND a.pause = 0
  UNION ALL
  SELECT tcs.color_code abn_range,
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
       listagg(ld.abn_range_desc,'' '')over(partition by a.abnormal_code) ABN_RANGE_DESC,
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
       decode(t.progress_status,
              ''02'',
              pno.pno_status,
              ''00'',
              gd_b.group_dict_name) progress_status_desc,
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
 LEFT JOIN (SELECT pno_status, product_gress_id
               FROM (SELECT row_number() over(partition by pn.product_gress_id order by pn.node_num desc) rn,
                            pn.node_name || gd_a.group_dict_name pno_status,
                            pn.product_gress_id
                       FROM scmdata.t_production_node pn
                      inner join group_dict gd_a
                         on gd_a.group_dict_type = ''PROGRESS_NODE_TYPE''
                        and gd_a.group_dict_value = pn.progress_status
                      WHERE pn.company_id = %default_company_id%
                        AND pn.progress_status IS NOT NULL)
              WHERE rn = 1) pno
    ON pno.product_gress_id = t.product_gress_id
  LEFT JOIN group_dict gd_b
    ON gd_b.group_dict_type = ''PROGRESS_TYPE''
   AND gd_b.group_dict_value = t.progress_status
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
 LEFT JOIN color_dict ld
    ON (CASE
         WHEN a.abnormal_range = ''00'' THEN
          '' 00 ''
         WHEN a.abnormal_range = ''01'' THEN
          '' 01 ''
         ELSE
          '' 02 ''
       END) = '' '' || ld.abn_range || '' ''
    OR (instr('' '' || a.abnormal_range || '' '', '' '' || ld.abn_range || '' '') > 0 AND
       ld.order_id = a.order_id AND ld.goo_id = a.goo_id)
 WHERE oh.company_id = %default_company_id%
  AND ((%is_company_admin% = 1) OR
  instr_priv(p_str1  => @subsql@ ,p_str2  => cf.category ,p_split => '';'') > 0)
 ORDER BY a.confirm_date DESC)';

update bw3.sys_item_list t set t.select_sql = v_sql,t.noshow_fields = 'ANOMALY_CLASS_PR,PRODUCT_GRESS_ID,COMPANY_ID,SUPPLIER_CODE_PR,FACTORY_CODE_PR,ORDER_ID_PR,ABNORMAL_ID,ABNORMAL_STATUS_PR,HANDLE_OPINIONS_PR,IS_DEDUCTION_PR,ABN_RANGE' where t.item_id = 'a_product_120_2';
end;
/
begin
insert into scmdata.sys_group_dict (GROUP_DICT_ID, PARENT_ID, PARENT_IDS, GROUP_DICT_NAME, GROUP_DICT_VALUE, GROUP_DICT_TYPE, DESCRIPTION, GROUP_DICT_SORT, GROUP_DICT_STATUS, TREE_LEVEL, IS_LEAF, IS_INITIAL, CREATE_ID, CREATE_TIME, UPDATE_ID, UPDATE_TIME, REMARKS, DEL_FLAG, PAUSE, IS_COMPANY_DICT_RELA)
values ('dce5c9dc7aca58b8e0533c281cacb8de', 'b49875ce1b307703e0533c281cac44e0', 'b49875ce1b307703e0533c281cac44e0', '异常范围', 'ABN_RANGE', 'ORDER_PRODUCE_QUALITY_DICT', null, 1, '1', 1, 1, 0, 'CZH', to_date('18-04-2022 10:48:00', 'dd-mm-yyyy hh24:mi:ss'), 'CZH', to_date('18-04-2022 10:48:00', 'dd-mm-yyyy hh24:mi:ss'), null, 0, 0, '0');

insert into scmdata.sys_group_dict (GROUP_DICT_ID, PARENT_ID, PARENT_IDS, GROUP_DICT_NAME, GROUP_DICT_VALUE, GROUP_DICT_TYPE, DESCRIPTION, GROUP_DICT_SORT, GROUP_DICT_STATUS, TREE_LEVEL, IS_LEAF, IS_INITIAL, CREATE_ID, CREATE_TIME, UPDATE_ID, UPDATE_TIME, REMARKS, DEL_FLAG, PAUSE, IS_COMPANY_DICT_RELA)
values ('dce5ce41ed164ecfe0533c281cac0639', 'dce5c9dc7aca58b8e0533c281cacb8de', 'dce5c9dc7aca58b8e0533c281cacb8de', '全部', '00', 'ABN_RANGE', null, 1, '1', 1, 1, 0, 'CZH', to_date('18-04-2022 10:49:14', 'dd-mm-yyyy hh24:mi:ss'), 'CZH', to_date('18-04-2022 10:49:14', 'dd-mm-yyyy hh24:mi:ss'), null, 0, 0, '0');

insert into scmdata.sys_group_dict (GROUP_DICT_ID, PARENT_ID, PARENT_IDS, GROUP_DICT_NAME, GROUP_DICT_VALUE, GROUP_DICT_TYPE, DESCRIPTION, GROUP_DICT_SORT, GROUP_DICT_STATUS, TREE_LEVEL, IS_LEAF, IS_INITIAL, CREATE_ID, CREATE_TIME, UPDATE_ID, UPDATE_TIME, REMARKS, DEL_FLAG, PAUSE, IS_COMPANY_DICT_RELA)
values ('dce5ce41ed174ecfe0533c281cac0639', 'dce5c9dc7aca58b8e0533c281cacb8de', 'dce5c9dc7aca58b8e0533c281cacb8de', '指定数量', '01', 'ABN_RANGE', null, 1, '1', 1, 1, 0, 'CZH', to_date('18-04-2022 10:49:14', 'dd-mm-yyyy hh24:mi:ss'), 'CZH', to_date('18-04-2022 10:49:14', 'dd-mm-yyyy hh24:mi:ss'), null, 0, 0, '0');

insert into scmdata.sys_group_dict (GROUP_DICT_ID, PARENT_ID, PARENT_IDS, GROUP_DICT_NAME, GROUP_DICT_VALUE, GROUP_DICT_TYPE, DESCRIPTION, GROUP_DICT_SORT, GROUP_DICT_STATUS, TREE_LEVEL, IS_LEAF, IS_INITIAL, CREATE_ID, CREATE_TIME, UPDATE_ID, UPDATE_TIME, REMARKS, DEL_FLAG, PAUSE, IS_COMPANY_DICT_RELA)
values ('dce5ce41ed184ecfe0533c281cac0639', 'dce5c9dc7aca58b8e0533c281cacb8de', 'dce5c9dc7aca58b8e0533c281cacb8de', '订单颜色', '02', 'ABN_RANGE', null, 1, '1', 1, 1, 0, 'CZH', to_date('18-04-2022 10:49:14', 'dd-mm-yyyy hh24:mi:ss'), 'CZH', to_date('18-04-2022 10:49:14', 'dd-mm-yyyy hh24:mi:ss'), null, 0, 1, '0');

end;
