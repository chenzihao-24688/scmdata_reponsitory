BEGIN
insert into bw3.sys_element (ELEMENT_ID, ELEMENT_TYPE, DATA_SOURCE, PAUSE, MESSAGE, IS_HIDE, MEMO, IS_ASYNC, IS_PER_EXE)
values ('action_a_product_110_4', 'action', 'oracle_scmdata', 0, null, null, null, null, null);

insert into bw3.sys_action (ELEMENT_ID, CAPTION, ICON_NAME, ACTION_TYPE, ACTION_SQL, SELECT_FIELDS, REFRESH_FLAG, MULTI_PAGE_FLAG, PRE_FLAG, FILTER_EXPRESS, UPDATE_FIELDS, PORT_ID, PORT_SQL, LOCK_SQL, SELECTION_FLAG, CALL_ID, OPERATE_MODE, PORT_TYPE, QUERY_FIELDS, SELECTION_METHOD)
values ('action_a_product_110_4', '批量复制延期问题', 'icon-daoru', 4, 'DECLARE
  p_pro_rec            t_production_progress%ROWTYPE;
  v_product_gress_code VARCHAR2(100) := @product_gress_code_pr@; --输入的生产订单
  v_company_id         VARCHAR2(100) := %default_company_id%;
  v_iabn_config_id     VARCHAR2(100);
  v_cabn_config_id     VARCHAR2(100);
  --所选的需要复制延期问题的生产订单
  CURSOR pro_cur IS
    SELECT pc.*
      FROM scmdata.t_production_progress pc
     WHERE pc.company_id = v_company_id
       AND pc.product_gress_code IN (@selection);
BEGIN
  --输入的生产订单
  SELECT pi.*
    INTO p_pro_rec
    FROM scmdata.t_production_progress pi
   WHERE pi.company_id = v_company_id
     AND pi.product_gress_code = v_product_gress_code;
  --校验输入的生产单，是否配置了异常处理
  v_iabn_config_id := scmdata.pkg_production_progress.check_abnormal_config(p_company_id => p_pro_rec.company_id,
                                                                            p_goo_id     => p_pro_rec.goo_id);

  IF v_iabn_config_id IS NOT NULL THEN
    --所选的需要复制延期问题的生产订单  
    FOR pro_rec IN pro_cur LOOP
      ----校验需复制的生产单，是否配置了异常处理
      v_cabn_config_id := scmdata.pkg_production_progress.check_abnormal_config(p_company_id => pro_rec.company_id,
                                                                                p_goo_id     => pro_rec.goo_id);
      IF v_cabn_config_id IS NOT NULL THEN
        --校验输入的/需复制的生产单（商品）是否属于同一模板
        IF v_iabn_config_id = v_cabn_config_id THEN
          --模板一致，将延期异常问题复制至需复制的生产单
          UPDATE t_production_progress t
             SET t.delay_problem_class  = p_pro_rec.delay_problem_class,
                 t.delay_cause_class    = p_pro_rec.delay_cause_class,
                 t.delay_cause_detailed = p_pro_rec.delay_cause_detailed,
                 t.problem_desc         = p_pro_rec.problem_desc
           WHERE t.company_id = pro_rec.company_id
             AND t.product_gress_id = pro_rec.product_gress_id;
        ELSE
          raise_application_error(-20002,
                                  ''需复制的生产单：['' || pro_rec.product_gress_code ||
                                  ''],与输入的生产单模板不一致，请重新选择！！'');
        END IF;
      
      ELSE
        raise_application_error(-20002,
                                ''需复制的生产单：['' || pro_rec.product_gress_code ||
                                ''],无异常处理配置,请联系管理员！！'');
      END IF;
    
    END LOOP;
  ELSE
    raise_application_error(-20002,
                            ''输入的生产单，无异常处理配置,请联系管理员！！'');
  
  END IF;
END;', 'PRODUCT_GRESS_CODE_PR', 1, 1, null, null, null, null, null, null, 0, null, null, 1, null, 2);

insert into bw3.sys_item_element_rela (ITEM_ID, ELEMENT_ID, SEQ_NO, PAUSE, LEVEL_NO)
values ('a_product_110', 'action_a_product_110_4', 2, 0, null);

END;
/
DECLARE
v_select_sql_1 CLOB;
v_select_sql_2 CLOB;
BEGIN
v_select_sql_1 := q'[WITH supp AS
 (SELECT sp.company_id, sp.supplier_code, sp.supplier_company_name
    FROM scmdata.t_supplier_info sp),
group_dict AS
 (SELECT group_dict_type, group_dict_value, group_dict_name
    FROM scmdata.sys_group_dict)
SELECT t.product_gress_id,
       t.company_id,
       t.progress_status progress_status_pr,
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
       decode(sign(t.order_amount - t.delivery_amount),
              -1,
              0,
              t.order_amount - t.delivery_amount) owe_amount_pr,
       nvl(t.order_full_rate,0) order_full_rate_pr,
       --t.order_status order_status_pr,
       t.delay_problem_class delay_problem_class_pr,
       t.delay_cause_class delay_cause_class_pr,
       t.delay_cause_detailed delay_cause_detailed_pr,
       t.problem_desc problem_desc_pr,
       t.is_sup_responsible,
       t.responsible_dept,
       t.responsible_dept_sec,
       t.approve_edition, --Edit by zc 
       t.fabric_check fabric_check,
       t.qc_check qc_check_pr,
       t.qa_check qa_check_pr,
       decode(t.exception_handle_status,
              '01',
              '处理中',
              '02',
              '已处理',
              '无异常') exception_handle_status_pr,
       (SELECT gd.group_dict_name
          FROM group_dict gd
         WHERE gd.group_dict_type = 'HANDLE_RESULT'
           AND gd.group_dict_value = t.handle_opinions) handle_opinions_pr,
       t.goo_id goo_id_pr, --这里goo_id是货号
       oh.create_time create_time_po,  
       oh.memo memo_po
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
 ORDER BY t.create_time DESC]';

v_select_sql_2 := q'[WITH supp AS
 (SELECT sp.company_id, sp.supplier_code, sp.supplier_company_name
    FROM scmdata.t_supplier_info sp),
group_dict AS
 (SELECT group_dict_type, group_dict_value, group_dict_name FROM scmdata.sys_group_dict)
SELECT t.product_gress_id,
       t.company_id,
       t.progress_status progress_status_pr,
       t.product_gress_code product_gress_code_pr,       
       a.group_dict_name progress_status_desc,
       t.order_id order_id_pr,
       cf.rela_goo_id,
       cf.style_number style_number_pr,
       cf.style_name style_name_pr,
       t.supplier_code supplier_code_pr,
       sp2.supplier_company_name supplier_company_name_pr,
       t.factory_code factory_code_pr,
       sp1.supplier_company_name factory_company_name_pr,
       od.delivery_date delivery_date_pr,
       oh.finish_time_scm finish_time_scm_pr,
       t.forecast_delivery_date forecast_delivery_date_pr,
       decode(sign(ceil(t.forecast_delivery_date - od.delivery_date)),-1,0,ceil(t.forecast_delivery_date - od.delivery_date)) forecast_delay_day_pr,
       t.latest_planned_delivery_date latest_planned_delivery_date_pr,
       t.actual_delivery_date actual_delivery_date_pr,
       t.actual_delay_day actual_delay_day_pr,
       t.order_amount order_amount_pr,
       t.delivery_amount delivery_amount_pr,
       decode(sign(t.order_amount - t.delivery_amount),-1,0,t.order_amount - t.delivery_amount) owe_amount_pr,
       nvl(t.order_full_rate,0) order_full_rate_pr,
       --t.order_status order_status_pr,
       t.delay_problem_class delay_problem_class_pr,
       t.delay_cause_class delay_cause_class_pr,
       t.delay_cause_detailed delay_cause_detailed_pr,
       t.problem_desc problem_desc_pr,
       t.approve_edition, --Edit by zc
       t.fabric_check fabric_check,
       t.qc_check qc_check_pr,
       t.qa_check qa_check_pr,
       decode(t.exception_handle_status,'01','处理中','02','已处理','无异常') exception_handle_status_pr,
       (SELECT gd.group_dict_name
          FROM scmdata.sys_group_dict gd
            WHERE gd.group_dict_type = 'HANDLE_RESULT'
           AND gd.group_dict_value = t.handle_opinions) handle_opinions_pr,
       t.goo_id goo_id_pr,
       oh.create_time create_time_po,  
       oh.memo memo_po
  FROM scmdata.t_ordered oh
 INNER JOIN scmdata.t_orders od
    ON oh.company_id = od.company_id
   AND oh.order_code = od.order_id
   AND oh.order_status IN ('OS01','OS02') --待修改
 INNER JOIN t_production_progress t
    ON t.company_id = od.company_id
   AND t.order_id = od.order_id
   AND t.goo_id = od.goo_id
   AND t.progress_status = '01'
 INNER JOIN group_dict a
    ON a.group_dict_value = t.progress_status
 INNER JOIN group_dict b
    ON b.group_dict_value = a.group_dict_type
   AND b.group_dict_value = 'PROGRESS_TYPE'
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
ORDER BY oh.finish_time_scm DESC]';

update bw3.sys_item_list t set t.select_sql = v_select_sql_1
 WHERE t.item_id = 'a_product_110';
 
update bw3.sys_item_list t set t.select_sql = v_select_sql_2
 WHERE t.item_id = 'a_product_116';

END;
/
BEGIN
INSERT INTO bw3.sys_field_list (field_name,caption,requiered_flag,read_only_flag,no_edit,no_copy,no_sort,alignment,ime_care,ime_open)
VALUES('CREATE_TIME_PO', '订单创建时间', 0, 1, 1, 0, 0, 0, 0, 0);

INSERT INTO bw3.sys_field_list (field_name,caption,requiered_flag,read_only_flag,no_edit,no_copy,no_sort,alignment,ime_care,ime_open)
VALUES('MEMO_PO', '订单备注', 0, 1, 1, 0, 0, 0, 0, 0);

update bw3.sys_action t set t.selection_method = 2 where t.element_id = 'action_a_product_110';
update bw3.sys_action t set t.selection_method = 2 where t.element_id = 'action_a_product_110_1';

END;
