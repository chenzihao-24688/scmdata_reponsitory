declare
v_sql1 clob;
v_sql2 clob;
v_sql3 clob;
begin
v_sql1 := 'WITH supp AS
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
 v_sql2 := 'WITH supp AS
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

v_sql3 := 'WITH supp AS
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
 ORDER BY a.confirm_date DESC)'；
 
 update bw3.sys_item_list t set t.select_sql = v_sql1 where t.item_id = 'a_product_118';
 update bw3.sys_item_list t set t.select_sql = v_sql2 where t.item_id = 'a_product_120_1';
 update bw3.sys_item_list t set t.select_sql = v_sql3 where t.item_id = 'a_product_120_2';
end;
