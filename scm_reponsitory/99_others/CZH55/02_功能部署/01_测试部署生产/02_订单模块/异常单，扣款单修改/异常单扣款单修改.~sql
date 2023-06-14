--订单表新增字段
/*  alter table scmdata.t_ordered add update_id_dedu  varchar2(32);
  alter table scmdata.t_ordered add update_time_dedu  date;
  alter table scmdata.t_ordered add memo_dedu varchar2(256);
  alter table scmdata.t_deduction add arrival_date  date;*/
  
--1.新增【新增其他异常】按钮
DECLARE
v_action_sql clob;
BEGIN

insert into bw3.sys_element (ELEMENT_ID, ELEMENT_TYPE, DATA_SOURCE, PAUSE, MESSAGE, IS_HIDE, MEMO, IS_ASYNC, IS_PER_EXE)
values ('action_a_product_118_4', 'action', 'oracle_scmdata', 0, null, 0, null, null, null);

v_action_sql := 'WITH supp AS
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
       t.goo_id goo_id_pr, --这里goo_id是货号
       cf.rela_goo_id,
       cf.style_number style_number_pr,
       cf.style_name style_name_pr,
       t.supplier_code supplier_code_pr,
       sp2.supplier_company_name supplier_company_name_pr,
       t.factory_code factory_code_pr,
       sp1.supplier_company_name factory_company_name_pr,
       nvl(MAX(od.delivery_date) over(PARTITION BY od.order_id),
           od.delivery_date) delivery_date_pr, --最新计划交期,有值时取‘最新计划交期’，无则取‘计划交期’
       t.forecast_delivery_date forecast_delivery_date_pr,
       decode(sign(ceil(t.forecast_delivery_date - od.delivery_date)),
              -1,
              0,
              ceil(t.forecast_delivery_date - od.delivery_date)) forecast_delay_day_pr,
       t.latest_planned_delivery_date latest_planned_delivery_date_pr,
       t.actual_delivery_date actual_delivery_date_pr,
       t.actual_delay_day actual_delay_day_pr,
       t.order_amount order_amount_pr,
       t.delivery_amount delivery_amount_pr,
       decode(sign(t.order_amount - t.delivery_amount),-1,0,t.order_amount - t.delivery_amount) owe_amount_pr,
       (SELECT gd.group_dict_name
          FROM scmdata.sys_group_dict gd
        WHERE gd.group_dict_type = ''APPROVE_STATUS''
          AND gd.group_dict_value = t.approve_edition) approve_edition_pr,
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
       (SELECT gd.group_dict_name
          FROM group_dict gd
         WHERE gd.group_dict_type = ''HANDLE_RESULT''
           AND gd.group_dict_value = t.handle_opinions) handle_opinions_desc,
       t.progress_status progress_status_pr,
       ''AC_OTHERS'' ANOMALY_CLASS_PR,
       ''其它'' delay_problem_class_pr,
       ''其它'' delay_cause_class_pr,
       ''其它'' delay_cause_detailed_pr
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
 WHERE oh.company_id = %default_company_id%';

insert into bw3.sys_action (ELEMENT_ID, CAPTION, ICON_NAME, ACTION_TYPE, ACTION_SQL, SELECT_FIELDS, REFRESH_FLAG, MULTI_PAGE_FLAG, PRE_FLAG, FILTER_EXPRESS, UPDATE_FIELDS, PORT_ID, PORT_SQL, LOCK_SQL, SELECTION_FLAG, CALL_ID, OPERATE_MODE, PORT_TYPE, QUERY_FIELDS, SELECTION_METHOD)
values ('action_a_product_118_4', '新增其他异常', 'icon-morencaidan', 5, v_action_sql , null, 1, 1, 0, null, null, null, null, null, 0, null, null, 1, 'product_gress_code_pr,goo_id_pr', null);

insert into bw3.sys_item_element_rela (ITEM_ID, ELEMENT_ID, SEQ_NO, PAUSE, LEVEL_NO)
values ('a_product_118', 'action_a_product_118_4', 3, 0, null);

update bw3.sys_item_element_rela t set t.seq_no = 4 where t.item_id = 'a_product_118' and t.element_id = 'action_a_product_118_1';

END;
/
--异常单填写
DECLARE
v_lookup_sql clob;
v_update_sql1 clob;
v_update_sql2 clob;
BEGIN
insert into scmdata.sys_group_dict (GROUP_DICT_ID, PARENT_ID, PARENT_IDS, GROUP_DICT_NAME, GROUP_DICT_VALUE, GROUP_DICT_TYPE, DESCRIPTION, GROUP_DICT_SORT, GROUP_DICT_STATUS, TREE_LEVEL, IS_LEAF, IS_INITIAL, CREATE_ID, CREATE_TIME, UPDATE_ID, UPDATE_TIME, REMARKS, DEL_FLAG, PAUSE, IS_COMPANY_DICT_RELA)
values ('c1c801b2a21944efe0533c281cac7439', 'b4969d8db4fa0a5ce0533c281cacdca5', 'b4969d8db4fa0a5ce0533c281cacdca5', '其它异常', 'AC_OTHERS', 'ANOMALY_CLASSIFICATION_DICT', null, 1, '1', 1, 1, 0, 'CZH', to_date('08-05-2021 09:58:34', 'dd-mm-yyyy hh24:mi:ss'), 'CZH', to_date('08-05-2021 09:58:34', 'dd-mm-yyyy hh24:mi:ss'), null, 0, 0, '0');

v_lookup_sql := q'[SELECT a.group_dict_value deduction_method_pr,
       a.group_dict_name  deduction_method_desc
  FROM scmdata.sys_group_dict a
 WHERE a.group_dict_type = 'DEDUCTION_METHOD'
   --AND a.group_dict_value <> 'METHOD_02'
   AND a.pause = 0
ORDER BY a.group_dict_value]';

update bw3.sys_look_up t set t.look_up_sql = v_lookup_sql where t.element_id = 'look_a_product_118_5';
update bw3.sys_field_list t set t.caption = '扣款单价/金额/比例' where t.field_name = 'DEDUCTION_UNIT_PRICE_PR';
update bw3.sys_field_list t set t.caption = '数量',t.check_message = '数量只能是正整数' where t.field_name = 'DELAY_AMOUNT';
update bw3.sys_field_list t set t.caption = '数量',t.check_message = '数量只能是正整数' where t.field_name = 'DELAY_AMOUNT_PR';

v_update_sql1 := q'[DECLARE
  v_abnormal_code VARCHAR2(32);
  v_anomaly_class VARCHAR2(32);
  p_abn_rec       scmdata.t_abnormal%ROWTYPE;
BEGIN

  p_abn_rec.abnormal_id   := :abnormal_id_pr;
  p_abn_rec.company_id    := %default_company_id%;
  p_abn_rec.abnormal_code := :abnormal_code_pr;
  p_abn_rec.order_id      := :order_id_pr;

  SELECT abn.anomaly_class
    INTO v_anomaly_class
    FROM scmdata.t_abnormal abn
   WHERE abn.abnormal_id = :abnormal_id_pr;

  p_abn_rec.anomaly_class := v_anomaly_class;

  IF v_anomaly_class = 'AC_DATE' THEN
    NULL;
  ELSIF v_anomaly_class = 'AC_QUALITY'  THEN
    p_abn_rec.problem_class        := :problem_class_pr;
    p_abn_rec.cause_class          := :cause_class_pr;
    p_abn_rec.cause_detailed       := :cause_detailed_pr;
    p_abn_rec.detailed_reasons     := :detailed_reasons_pr;
    p_abn_rec.is_sup_responsible   := :is_sup_responsible;
    p_abn_rec.responsible_dept     := :responsible_dept_pr;
    p_abn_rec.responsible_dept_sec := :responsible_dept_sec_pr;
  ELSIF v_anomaly_class = 'AC_OTHERS' THEN
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

END;]';

update bw3.sys_item_list t set t.update_sql = v_update_sql1 where t.item_id = 'a_product_118';

v_update_sql2 := q'[DECLARE
  v_abnormal_code VARCHAR2(32);
  v_anomaly_class VARCHAR2(32);
  p_abn_rec       scmdata.t_abnormal%ROWTYPE;
BEGIN

  p_abn_rec.abnormal_id   := :abnormal_id;
  p_abn_rec.company_id    := %default_company_id%;
  p_abn_rec.abnormal_code := :abnormal_code_pr;
  p_abn_rec.order_id      := :order_id_pr;

  SELECT abn.anomaly_class
    INTO v_anomaly_class
    FROM scmdata.t_abnormal abn
   WHERE abn.abnormal_id = :abnormal_id;

  p_abn_rec.anomaly_class := v_anomaly_class;

  IF v_anomaly_class = 'AC_DATE' THEN
    NULL;
  ELSIF v_anomaly_class = 'AC_QUALITY' THEN
    p_abn_rec.problem_class        := :problem_class_pr;
    p_abn_rec.cause_class          := :cause_class_pr;
    p_abn_rec.cause_detailed       := :cause_detailed_pr;
    p_abn_rec.detailed_reasons     := :detailed_reasons_pr;
    p_abn_rec.is_sup_responsible   := :is_sup_responsible;
    p_abn_rec.responsible_dept     := :responsible_dept_pr;
    p_abn_rec.responsible_dept_sec := :responsible_dept_sec_pr;
  ELSIF v_anomaly_class = 'AC_OTHERS' THEN
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
]';

update bw3.sys_item_list t set t.update_sql = v_update_sql2 where t.item_id = 'a_product_120_1';

END;


/
--订单t_ordered增加字段
DECLARE
v_select_sql clob;
v_update_sql clob;
BEGIN 
INSERT INTO bw3.sys_field_list (field_name,caption,requiered_flag,read_only_flag,no_edit,no_copy,no_sort,alignment,ime_care,ime_open)
VALUES('UPDATE_ID_DEDU', '修改人', 0, 1, 1, 0, 0, 0, 0, 0);

INSERT INTO bw3.sys_field_list (field_name,caption,requiered_flag,read_only_flag,no_edit,no_copy,no_sort,alignment,ime_care,ime_open)
VALUES('UPDATE_TIME_DEDU', '修改时间', 0, 1, 1, 0, 0, 0, 0, 0);

INSERT INTO bw3.sys_field_list (field_name,caption,requiered_flag,read_only_flag,no_edit,no_copy,no_sort,alignment,ime_care,ime_open)
VALUES('MEMO_DEDU', '备注', 0, 0, 0, 0, 0, 0, 0, 0);

v_select_sql := q'[SELECT DISTINCT po.order_id,
                po.company_id,
                po.approve_status,
                po.order_code,
                fc.supplier_company_name,                
                listagg(DISTINCT tc.rela_goo_id, ';') within GROUP(ORDER BY pln.goo_id) over(PARTITION BY pln.order_id) rela_goo_id,
                SUM(pln.order_amount) over(PARTITION BY pln.order_id) order_amount,
                po.delivery_date,
                MAX(pln.delivery_date) over(PARTITION BY pln.order_id) latest_delivery_date,
                (SELECT MAX(dr.delivery_date)
                   FROM t_delivery_record dr
                  WHERE pr.company_id = dr.company_id
                    AND pr.order_id = dr.order_code
                    AND pr.goo_id = dr.goo_id) actual_delivery_date_dr,
                (SELECT SUM(dr.delivery_amount)
                   FROM t_delivery_record dr
                  WHERE pr.company_id = dr.company_id
                    AND pr.order_id = dr.order_code
                    AND pr.goo_id = dr.goo_id) delivery_amount_dr,
                MAX(pr.actual_delay_day) over(PARTITION BY pr.order_id) actual_delay_day,
                (SELECT SUM(abn.delay_amount)
                   FROM t_deduction td
                  INNER JOIN scmdata.t_abnormal abn
                     ON td.company_id = abn.company_id
                    AND td.abnormal_id = abn.abnormal_id
                    AND td.orgin = 'SC'
                  WHERE td.company_id = pr.company_id
                    AND td.order_id = pr.order_id) delivery_amount,
                (SELECT SUM(td.actual_discount_price)
                   FROM t_deduction td
                  WHERE td.company_id = pr.company_id
                    AND td.order_id = pr.order_id) actual_price,
                po.approve_id approve_id_po,
                po.approve_time approve_time_po,
                po.finish_time_scm,
                listagg(DISTINCT pln.goo_id, ';') within GROUP(ORDER BY pln.goo_id) over(PARTITION BY pln.order_id) goo_id,
                po.memo_dedu,
                po.update_id_dedu,
                po.update_time_dedu
  FROM scmdata.t_ordered po
 INNER JOIN scmdata.t_orders pln
    ON po.company_id = pln.company_id
   AND po.order_code = pln.order_id
 INNER JOIN scmdata.t_production_progress pr
    ON pln.company_id = pr.company_id
   AND pln.order_id = pr.order_id
   AND pln.goo_id = pr.goo_id
 INNER JOIN scmdata.t_supplier_info fc
    ON po.company_id = fc.company_id
   AND po.supplier_code = fc.supplier_code
 INNER JOIN scmdata.t_commodity_info tc
    ON tc.company_id = pr.company_id
   AND tc.goo_id = pr.goo_id
 WHERE po.company_id = %default_company_id%
   AND po.approve_status = '00'
 ORDER BY po.finish_time_scm DESC]';

v_update_sql := q'[DECLARE
  po_rec scmdata.t_ordered%ROWTYPE;
BEGIN
  po_rec.company_id := :company_id;
  po_rec.order_id   := :order_id;
  po_rec.memo_dedu := :memo_dedu;
  po_rec.update_id_dedu := :user_id;
  po_rec.update_time_dedu := SYSDATE;
  scmdata.pkg_production_progress.update_ordered(po_rec => po_rec);
END;]';

update bw3.sys_item_list t set t.select_sql = v_select_sql,t.update_sql = v_update_sql where t.item_id = 'a_product_130_1';

END;
/

DECLARE
v_select_sql clob;
v_select_sql1 clob;
v_update_sql clob;
BEGIN

v_select_sql := q'[SELECT DISTINCT po.order_id,
                po.company_id,
                po.approve_status,
                po.order_code,
                fc.supplier_company_name,
                --po.supplier_code,
                --po.order_type,
                listagg(DISTINCT tc.rela_goo_id, ';') within GROUP(ORDER BY pln.goo_id) over(PARTITION BY pln.order_id) rela_goo_id,
                SUM(pln.order_amount) over(PARTITION BY pln.order_id) order_amount,
                po.delivery_date,
                MAX(pln.delivery_date) over(PARTITION BY pln.order_id) latest_delivery_date,
                (SELECT MAX(dr.delivery_date)
                   FROM t_delivery_record dr
                  WHERE pr.company_id = dr.company_id
                    AND pr.order_id = dr.order_code
                    AND pr.goo_id = dr.goo_id) actual_delivery_date_dr,
                (SELECT SUM(dr.delivery_amount)
                   FROM t_delivery_record dr
                  WHERE pr.company_id = dr.company_id
                    AND pr.order_id = dr.order_code
                    AND pr.goo_id = dr.goo_id) delivery_amount_dr,
                MAX(pr.actual_delay_day) over(PARTITION BY pr.order_id) actual_delay_day,
                --SUM(pr.delivery_amount) over(PARTITION BY pr.order_id) delivery_amount,
                (SELECT SUM(abn.delay_amount)
                   FROM t_deduction td
                  INNER JOIN scmdata.t_abnormal abn
                     ON td.company_id = abn.company_id
                    AND td.abnormal_id = abn.abnormal_id
                    AND td.orgin = 'SC'
                  WHERE td.company_id = pr.company_id
                    AND td.order_id = pr.order_id) delivery_amount,
                (SELECT SUM(td.actual_discount_price)
                   FROM t_deduction td
                  WHERE td.company_id = pr.company_id
                    AND td.order_id = pr.order_id) actual_price,
                su.company_user_name approve_id_po,
                po.approve_time approve_time_po,
                listagg(DISTINCT pln.goo_id, ';') within GROUP(ORDER BY pln.goo_id) over(PARTITION BY pln.order_id) goo_id,
                po.memo_dedu,
                po.update_id_dedu,
                po.update_time_dedu
  FROM scmdata.t_ordered po
 INNER JOIN scmdata.t_orders pln
    ON po.company_id = pln.company_id
   AND po.order_code = pln.order_id
 INNER JOIN scmdata.t_production_progress pr
    ON pln.company_id = pr.company_id
   AND pln.order_id = pr.order_id
   AND pln.goo_id = pr.goo_id
 INNER JOIN scmdata.t_supplier_info fc
    ON po.company_id = fc.company_id
   AND po.supplier_code = fc.supplier_code
 INNER JOIN scmdata.t_commodity_info tc
    ON tc.company_id = pr.company_id
   AND tc.goo_id = pr.goo_id
 INNER JOIN scmdata.sys_company_user su
    ON su.company_id = po.company_id
   AND su.user_id = po.approve_id
 WHERE po.company_id = %default_company_id%
   AND po.approve_status = '01'
 ORDER BY po.approve_time DESC]';

v_update_sql := q'[DECLARE
  po_rec scmdata.t_ordered%ROWTYPE;
BEGIN
  po_rec.company_id := :company_id;
  po_rec.order_id   := :order_id;
  po_rec.memo_dedu := :memo_dedu;
  po_rec.update_id_dedu := :user_id;
  po_rec.update_time_dedu := SYSDATE;
  scmdata.pkg_production_progress.update_ordered(po_rec => po_rec);
END;]';

update bw3.sys_item_list t set t.select_sql = v_select_sql,t.update_sql = v_update_sql where t.item_id = 'a_product_130_2';

v_select_sql1 := q'[WITH group_dict AS
 (SELECT t.group_dict_type, t.group_dict_value, t.group_dict_name
    FROM scmdata.sys_group_dict t),
deduction_ratio AS
 (SELECT dc.deduction_ratio,
         dc.section_start,
         dc.section_end,
         tc.company_id,
         tc.goo_id
    FROM scmdata.t_commodity_info tc
   INNER JOIN scmdata.t_deduction_range_config dr
      ON tc.company_id = dr.company_id
     AND tc.category = dr.industry_classification
     AND tc.product_cate = dr.production_category
     AND instr(';' || dr.product_subclass || ';',
               ';' || tc.samll_category || ';') > 0
     AND dr.pause = 0
   INNER JOIN scmdata.t_deduction_dtl_config dc
      ON dr.company_id = dc.company_id
     AND dr.deduction_config_id = dc.deduction_config_id
     AND dc.pause = 0
   INNER JOIN scmdata.t_deduction_config td
      ON td.company_id = dc.company_id
     AND td.deduction_config_id = dc.deduction_config_id
     AND td.pause = 0)
SELECT td.deduction_id,
       --td.orgin,
       a.group_dict_name orgin,
       pr.product_gress_code,
       gd.group_dict_name anomaly_class,
       abn.detailed_reasons,
       nvl(abn.delay_date, 0) delay_date,
       decode(td.orgin,
              'SC',
              nvl(abn.delay_amount, 0),
              'MA',
              (SELECT SUM(dr.delivery_amount)
                 FROM scmdata.t_delivery_record dr
                WHERE dr.company_id = pr.company_id
                  AND dr.order_code = pr.order_id
                  AND dr.goo_id = pr.goo_id)) delay_amount,
       (SELECT a.group_dict_name
          FROM group_dict a
         WHERE a.group_dict_type = 'DEDUCTION_METHOD'
           AND a.group_dict_value = abn.deduction_method) deduction_method_desc,
       td.discount_unit_price deduction_unit_price,
       decode(abn.deduction_method,
              'METHOD_00',
              0,
              'METHOD_01',
              0,
              'METHOD_02',
              decode(abn.anomaly_class,
                     'AC_DATE',
                     nvl((SELECT deduction_ratio
                           FROM deduction_ratio drt
                          WHERE drt.company_id = pr.company_id
                            AND drt.goo_id = pr.goo_id
                            AND (abn.delay_date >= drt.section_start AND
                                abn.delay_date < drt.section_end)),
                         0),
                     'AC_OTHERS',
                     abn.deduction_unit_price,
                     0)) deduction_ratio_pr,
       td.discount_price,
       td.adjust_price,
       td.adjust_reason,
       td.actual_discount_price,
       su.company_user_name adjust_person,
       td.update_time adjust_time,
       :approve_status approve_status
  FROM scmdata.t_deduction td
 INNER JOIN scmdata.t_production_progress pr
    ON td.company_id = pr.company_id
   AND td.order_id = pr.order_id
 INNER JOIN scmdata.t_abnormal abn
    ON pr.company_id = abn.company_id
   AND pr.order_id = abn.order_id
   AND pr.goo_id = abn.goo_id
   AND td.abnormal_id = abn.abnormal_id
 INNER JOIN group_dict gd
    ON gd.group_dict_type = 'ANOMALY_CLASSIFICATION_DICT'
   AND gd.group_dict_value = abn.anomaly_class
 INNER JOIN group_dict a
    ON a.group_dict_type = 'ORIGIN_TYPE'
   AND a.group_dict_value = td.orgin
  LEFT JOIN scmdata.sys_company_user su
    ON su.company_id = td.company_id
   AND su.user_id = td.update_id
 WHERE td.company_id = %default_company_id%
   AND td.order_id = :order_code
]';
update bw3.sys_item_list t set t.select_sql = v_select_sql1 where t.item_id = 'a_product_130_3';
update bw3.sys_field_list t set t.display_format = '0.00',t.data_type = 10 where t.field_name = 'DISCOUNT_PRICE';

END;
/
--新增异常时，弹窗列表中欠货数量为负数；
DECLARE
v_action_sql1 clob;
v_action_sql2 clob;
BEGIN
  v_action_sql1 := q'[WITH supp AS
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
       nvl(MAX(od.delivery_date) over(PARTITION BY od.order_id),
           od.delivery_date) delivery_date_pr, --最新计划交期,有值时取‘最新计划交期’，无则取‘计划交期’
       t.forecast_delivery_date forecast_delivery_date_pr,
       decode(sign(ceil(t.forecast_delivery_date - od.delivery_date)),
              -1,
              0,
              ceil(t.forecast_delivery_date - od.delivery_date)) forecast_delay_day_pr,              
       t.latest_planned_delivery_date latest_planned_delivery_date_pr,
       t.actual_delivery_date actual_delivery_date_pr,
       t.actual_delay_day actual_delay_day_pr,
       t.order_amount order_amount_pr,
       t.delivery_amount delivery_amount_pr,
       decode(sign(t.order_amount - t.delivery_amount),-1,0,t.order_amount - t.delivery_amount) owe_amount_pr,
       (SELECT gd.group_dict_name
          FROM scmdata.sys_group_dict gd
        WHERE gd.group_dict_type = ''APPROVE_STATUS''
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
         WHERE gd.group_dict_type = ''HANDLE_RESULT''
           AND gd.group_dict_value = t.handle_opinions) handle_opinions_desc,
       t.progress_status progress_status_pr,
       t.delay_problem_class delay_problem_class_pr,
       t.delay_cause_class delay_cause_class_pr,
       t.delay_cause_detailed delay_cause_detailed_pr,
       t.problem_desc problem_desc_pr,
       t.is_sup_responsible,
       t.responsible_dept,
       t.responsible_dept_sec,
       'AC_DATE' ANOMALY_CLASS_PR
  FROM scmdata.t_ordered oh
 INNER JOIN scmdata.t_orders od
    ON oh.company_id = od.company_id
   AND oh.order_code = od.order_id
   AND oh.order_status <> 'OS02' --待修改
   AND (trunc(SYSDATE) - trunc(od.delivery_date)) > 2
 INNER JOIN t_production_progress t
    ON t.company_id = od.company_id
   AND t.order_id = od.order_id
   AND t.goo_id = od.goo_id
   AND t.progress_status NOT IN ('01', '03')
   AND t.delay_problem_class IS NOT NULL
   AND t.delay_cause_class IS NOT NULL
   AND t.delay_cause_detailed IS NOT NULL
   AND t.problem_desc IS NOT NULL
 INNER JOIN scmdata.t_commodity_info cf
    ON t.company_id = cf.company_id
   AND t.goo_id = cf.goo_id
  LEFT JOIN supp sp1
    ON t.company_id = sp1.company_id
   AND t.factory_code = sp1.supplier_code
 INNER JOIN supp sp2
    ON t.company_id = sp2.company_id
   AND t.supplier_code = sp2.supplier_code
 WHERE oh.company_id = %default_company_id%]';
 
 v_action_sql2 := q'[WITH supp AS
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
       nvl(MAX(od.delivery_date) over(PARTITION BY od.order_id),
           od.delivery_date) delivery_date_pr, --最新计划交期,有值时取‘最新计划交期’，无则取‘计划交期’
       t.forecast_delivery_date forecast_delivery_date_pr,
       decode(sign(ceil(t.forecast_delivery_date - od.delivery_date)),
              -1,
              0,
              ceil(t.forecast_delivery_date - od.delivery_date)) forecast_delay_day_pr,
       t.latest_planned_delivery_date latest_planned_delivery_date_pr,
       t.actual_delivery_date actual_delivery_date_pr,
       t.actual_delay_day actual_delay_day_pr,
       t.order_amount order_amount_pr,
       t.delivery_amount delivery_amount_pr,
       decode(sign(t.order_amount - t.delivery_amount),-1,0,t.order_amount - t.delivery_amount) owe_amount_pr,
       (SELECT gd.group_dict_name
          FROM scmdata.sys_group_dict gd
        WHERE gd.group_dict_type = ''APPROVE_STATUS''
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
         WHERE gd.group_dict_type = ''HANDLE_RESULT''
           AND gd.group_dict_value = t.handle_opinions) handle_opinions_desc,
       t.progress_status progress_status_pr,
       'AC_QUALITY' ANOMALY_CLASS_PR
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
 WHERE oh.company_id = %default_company_id%]';

  update bw3.sys_action t set t.action_sql = v_action_sql1 where t.element_id = 'action_a_product_118_2';
  update bw3.sys_action t set t.action_sql = v_action_sql2 where t.element_id = 'action_a_product_118_3';
END;
 
