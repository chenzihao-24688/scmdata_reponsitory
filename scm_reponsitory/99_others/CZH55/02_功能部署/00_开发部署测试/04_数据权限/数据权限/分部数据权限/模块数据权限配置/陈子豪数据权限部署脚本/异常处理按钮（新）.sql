--供应商档案增加数据权限
DECLARE
v_str1 clob;
v_str2 clob;
v_str3 clob;
v_str4 clob;
BEGIN
v_str1 := q'[WITH supp AS
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
           od.delivery_date) delivery_date_pr, --最新计划交期,有值时取‘最新计划交期’，无则取‘计划交期’*/
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
   --AND (trunc(SYSDATE) - trunc(oh.delivery_date)) > 0
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
 WHERE oh.company_id = %default_company_id%
  --AND (%is_company_admin% = 1 OR instr(%coop_class_priv%,cf.category)>0)
  AND ((%is_company_admin% = 1) OR
   instr_priv(p_str1  => pkg_data_privs.parse_json(p_jsonstr => %data_privs_json_strs%,p_key => 'COL_2'),p_str2  => cf.category ,p_split => ';') > 0 )
  ]';
v_str2 := q'[WITH supp AS
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
 WHERE oh.company_id = %default_company_id%
  --AND (%is_company_admin% = 1 OR instr(%coop_class_priv%,cf.category)>0)
  AND ((%is_company_admin% = 1) OR 
  instr_priv(p_str1  => pkg_data_privs.parse_json(p_jsonstr => %data_privs_json_strs%,p_key => 'COL_2'),p_str2  => cf.category ,p_split => ';') > 0 )
  ]';
v_str3 := q'[WITH supp AS
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
       '其它' delay_problem_class_pr,
       '其它' delay_cause_class_pr,
       '其它' delay_cause_detailed_pr
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

update bw3.sys_action t set t.action_sql = v_str1 WHERE t.element_id = 'action_a_product_118_2';
update bw3.sys_action t set t.action_sql = v_str2 WHERE t.element_id = 'action_a_product_118_3';
update bw3.sys_action t set t.action_sql = v_str3 WHERE t.element_id = 'action_a_product_118_4';

END;

