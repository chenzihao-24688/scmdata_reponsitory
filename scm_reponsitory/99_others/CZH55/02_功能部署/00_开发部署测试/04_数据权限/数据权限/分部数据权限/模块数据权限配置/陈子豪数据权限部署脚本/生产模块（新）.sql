--生产模块增加数据权限
DECLARE
v_str1 clob;
v_str2 clob;
v_str3 clob;
v_str4 clob;

v_str5 clob;
v_str6 clob;
v_str7 clob;
v_str8 clob;

v_str9 clob;
v_str10 clob;
v_str11 clob;
v_str12 clob;

v_str13 clob;
v_str14 clob;
BEGIN
--a_product_110
v_str1 := q'[WITH supp AS
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
       nvl(t.order_full_rate, 0) order_full_rate_pr,
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
 --AND ((%is_company_admin%) = 1  OR instr(%coop_class_priv%,cf.category) > 0)
 AND ((%is_company_admin% = 1) OR 
 instr_priv(p_str1  => @subsql@ ,p_str2  => cf.category ,p_split => ';') > 0)
 ORDER BY t.create_time DESC]';
 
v_str2 := '{declare
v_class_data_privs clob;
begin
 v_class_data_privs := pkg_data_privs.parse_json(p_jsonstr => %data_privs_json_strs%,p_key => ''COL_2'');
 @strresult :=' || '''' ||
           q'[(SELECT * FROM (SELECT ' || '''' || v_class_data_privs || '''' || ' FROM dual))]' || '''' ||
           '; 
end;}';

--a_product_116
v_str3 := q'[WITH supp AS
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
       --od.delivery_date delivery_date_pr,
       oh.delivery_date delivery_date_pr, --update by czh 20210527（1）生产进度表中的订单交期取下单列表的订单交期（即熊猫的交期日期）
       oh.finish_time_scm finish_time_scm_pr,
       t.forecast_delivery_date forecast_delivery_date_pr,
       decode(sign(ceil(t.forecast_delivery_date - oh.delivery_date)),-1,0,ceil(t.forecast_delivery_date - oh.delivery_date)) forecast_delay_day_pr,
       --t.latest_planned_delivery_date latest_planned_delivery_date_pr,
       MAX(od.delivery_date) over(PARTITION BY od.order_id) latest_planned_delivery_date_pr, --update by czh 20210527（2）生产进度表中的”最新计划完成日期“字段名更改为“最新计划交期”，取下单列表中的最新计划交期（即熊猫的新交货日期）
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
       decode(t.exception_handle_status,
              '01',
              '处理中',
              '02',
              '已处理',
              '无异常') exception_handle_status_pr,
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
   --AND ((%is_company_admin%) = 1  OR instr(%coop_class_priv%,cf.category) > 0)
    AND ((%is_company_admin% = 1) OR
     instr_priv(p_str1  => @subsql@ ,p_str2  => cf.category ,p_split => ';') > 0)
ORDER BY oh.finish_time_scm DESC]';

v_str4 := '{declare
v_class_data_privs clob;
begin
 v_class_data_privs := pkg_data_privs.parse_json(p_jsonstr => %data_privs_json_strs%,p_key => ''COL_2'');
 @strresult :=' || '''' ||
           q'[(SELECT * FROM (SELECT ' || '''' || v_class_data_privs || '''' || ' FROM dual))]' || '''' ||
           '; 
end;}';

--a_product_118
v_str5 := q'[WITH supp AS
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
   AND oh.order_status = 'OS01' --待修改
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
   AND a.progress_status = '00'
  LEFT JOIN scmdata.sys_group_dict gd
    ON gd.group_dict_type = 'ANOMALY_CLASSIFICATION_DICT'
   AND gd.group_dict_value = a.anomaly_class
 WHERE oh.company_id = %default_company_id%
   AND a.create_id = :user_id
  --AND ((%is_company_admin%) = 1  OR instr(%coop_class_priv%,cf.category) > 0)
   AND ((%is_company_admin% = 1) OR instr_priv(p_str1  => @subsql@ ,p_str2  => cf.category ,p_split => ';') > 0)
 ORDER BY a.create_time DESC]';
 
v_str6 := '{declare
v_class_data_privs clob;
begin
 v_class_data_privs := pkg_data_privs.parse_json(p_jsonstr => %data_privs_json_strs%,p_key => ''COL_2'');
 @strresult :=' || '''' ||
           q'[(SELECT * FROM (SELECT ' || '''' || v_class_data_privs || '''' || ' FROM dual))]' || '''' ||
           '; 
end;}';

--a_product_120_1
v_str7 := q'[WITH supp AS
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
       a.confirm_date confirm_date
  FROM scmdata.t_ordered oh
 INNER JOIN scmdata.t_orders od
    ON oh.company_id = od.company_id
   AND oh.order_code = od.order_id
   AND oh.order_status = 'OS01'
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
   AND a.progress_status = '01'
   AND a.origin <> 'SC'
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
    ON gd.group_dict_type = 'ANOMALY_CLASSIFICATION_DICT'
   AND gd.group_dict_value = a.anomaly_class
 WHERE oh.company_id = %default_company_id%
  --AND ((%is_company_admin%) = 1  OR instr(%coop_class_priv%,cf.category) > 0)
   AND ((%is_company_admin% = 1) OR 
   instr_priv(p_str1  => @subsql@ ,p_str2  => cf.category ,p_split => ';') > 0)
 ORDER BY a.create_time DESC]';
 
v_str8 := '{declare
v_class_data_privs clob;
begin
 v_class_data_privs := pkg_data_privs.parse_json(p_jsonstr => %data_privs_json_strs%,p_key => ''COL_2'');
 @strresult :=' || '''' ||
           q'[(SELECT * FROM (SELECT ' || '''' || v_class_data_privs || '''' || ' FROM dual))]' || '''' ||
           '; 
end;}';

--a_product_120_2
v_str9 := q'[WITH supp AS
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
         WHERE b.group_dict_type = 'DEDUCTION_METHOD'
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
              (SELECT a.group_dict_name
                 FROM group_dict a
                WHERE a.group_dict_type = 'PROGRESS_TYPE'
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
       a.confirm_date confirm_date
  FROM scmdata.t_ordered oh
 INNER JOIN scmdata.t_orders od
    ON oh.company_id = od.company_id
   AND oh.order_code = od.order_id
   AND oh.order_status IN ('OS01', 'OS02') --待修改
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
   AND a.progress_status = '02'
   AND a.origin <> 'SC'
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
    ON gd.group_dict_type = 'ANOMALY_CLASSIFICATION_DICT'
   AND gd.group_dict_value = a.anomaly_class
 WHERE oh.company_id = %default_company_id%
  --AND ((%is_company_admin%) = 1  OR instr(%coop_class_priv%,cf.category) > 0)
  AND ((%is_company_admin% = 1) OR 
  instr_priv(p_str1  => @subsql@ ,p_str2  => cf.category ,p_split => ';') > 0)
 ORDER BY a.confirm_date DESC]';
 
v_str10 := '{declare
v_class_data_privs clob;
begin
 v_class_data_privs := pkg_data_privs.parse_json(p_jsonstr => %data_privs_json_strs%,p_key => ''COL_2'');
 @strresult :=' || '''' ||
           q'[(SELECT * FROM (SELECT ' || '''' || v_class_data_privs || '''' || ' FROM dual))]' || '''' ||
           '; 
end;}';

--a_product_130_1
v_str11 := q'[SELECT DISTINCT po.order_id,
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
  --AND ((%is_company_admin%) = 1  OR instr(%coop_class_priv%,tc.category) > 0)
  AND ((%is_company_admin% = 1) OR 
  instr_priv(p_str1  => @subsql@ ,p_str2  => tc.category ,p_split => ';') > 0)
 ORDER BY po.finish_time_scm DESC]';
 
v_str12 := '{declare
v_class_data_privs clob;
begin
 v_class_data_privs := pkg_data_privs.parse_json(p_jsonstr => %data_privs_json_strs%,p_key => ''COL_2'');
 @strresult :=' || '''' ||
           q'[(SELECT * FROM (SELECT ' || '''' || v_class_data_privs || '''' || ' FROM dual))]' || '''' ||
           '; 
end;}';

--a_product_130_2
v_str13 := q'[SELECT DISTINCT po.order_id,
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
 --AND ((%is_company_admin%) = 1  OR instr(%coop_class_priv%,tc.category) > 0)
 AND ((%is_company_admin% = 1) OR
  instr_priv(p_str1  => @subsql@ ,p_str2  => tc.category ,p_split => ';') > 0)
 ORDER BY po.approve_time DESC]';
 
v_str14 := '{declare
v_class_data_privs clob;
begin
 v_class_data_privs := pkg_data_privs.parse_json(p_jsonstr => %data_privs_json_strs%,p_key => ''COL_2'');
 @strresult :=' || '''' ||
           q'[(SELECT * FROM (SELECT ' || '''' || v_class_data_privs || '''' || ' FROM dual))]' || '''' ||
           '; 
end;}';

update bw3.sys_item_list t set t.select_sql = v_str1 ,t.subselect_sql = v_str2 WHERE t.item_id = 'a_product_110';
update bw3.sys_item_list t set t.select_sql = v_str3 ,t.subselect_sql = v_str4 WHERE t.item_id = 'a_product_116';

update bw3.sys_item_list t set t.select_sql = v_str5 ,t.subselect_sql = v_str6 WHERE t.item_id = 'a_product_118';
update bw3.sys_item_list t set t.select_sql = v_str7 ,t.subselect_sql = v_str8 WHERE t.item_id = 'a_product_120_1';

update bw3.sys_item_list t set t.select_sql = v_str9 ,t.subselect_sql = v_str10 WHERE t.item_id = 'a_product_120_2';
update bw3.sys_item_list t set t.select_sql = v_str11 ,t.subselect_sql = v_str12 WHERE t.item_id = 'a_product_130_1';

update bw3.sys_item_list t set t.select_sql = v_str13 ,t.subselect_sql = v_str14 WHERE t.item_id = 'a_product_130_2';



END;
