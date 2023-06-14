DECLARE
  v_sql1     CLOB;
  v_sub_sql1 CLOB;
  v_sql2     CLOB;
  v_sql3     CLOB;
  v_sql4     CLOB;
  v_sql5     CLOB;
  v_sql6     CLOB;
BEGIN
  v_sql1     := 'WITH supp AS
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
 ORDER BY a.create_time DESC';
 
  v_sub_sql1 := '{declare
v_class_data_privs clob;
begin
 v_class_data_privs := pkg_data_privs.parse_json(p_jsonstr => %data_privs_json_strs%,p_key => ''COL_2'');
 @strresult :=''(SELECT * FROM (SELECT '' || '''''''' || v_class_data_privs || '''''''' || '' FROM dual))'';
end;}';

 UPDATE bw3.sys_item_list t
     SET t.select_sql = v_sql1, t.subselect_sql = v_sub_sql1
   WHERE t.item_id = 'a_product_120_1';
   
  v_sql2     := 'WITH supp AS
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
 ORDER BY a.confirm_date DESC';
 
 UPDATE bw3.sys_item_list t
     SET t.select_sql = v_sql2, t.subselect_sql = v_sub_sql1
   WHERE t.item_id = 'a_product_120_2';

END;
