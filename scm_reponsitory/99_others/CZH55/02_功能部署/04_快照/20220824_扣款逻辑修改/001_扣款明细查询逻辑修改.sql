DECLARE
v_sql CLOB;
BEGIN
  v_sql :='--20220831 czh修改扣款方式、比例
WITH group_dict AS
 (SELECT t.group_dict_type, t.group_dict_value, t.group_dict_name
    FROM scmdata.sys_group_dict t)
SELECT td.deduction_id,
       --td.orgin,
       a.group_dict_name orgin,
       pr.product_gress_code,
       gd.group_dict_name anomaly_class,
       nvl(abn.delay_date, 0) delay_date,
       nvl(td.deduction_amount, 0) delay_amount,
       (SELECT a.group_dict_name
          FROM group_dict a
         WHERE a.group_dict_type = ''DEDUCTION_METHOD''
           AND a.group_dict_value = td.discount_type) deduction_method_desc,
       td.discount_unit_price deduction_unit_price,
       td.discount_proportion deduction_ratio_pr,
       ---20220714新增调整类型、责任部门1级、原因细分 修改人:LSL167
       td.discount_price, --扣款金额
       td.actual_discount_price, --实际扣款金额
       td.adjust_price, --调整金额
       td.adjust_type, --调整类型
       td.adjust_reason, --调整理由
       abn.responsible_dept first_dept_id,
       abn.responsible_dept responsible_dept, --责任部门1级
       abn.cause_detailed cause_detail_desc, --原因细分
       abn.detailed_reasons, --问题描述
       td.memo, --备注
       nvl(su.company_user_name, u.username) adjust_person,
       td.update_time adjust_time,
       :approve_status approve_status
  FROM scmdata.t_deduction td
 INNER JOIN scmdata.t_production_progress pr
    ON td.company_id = pr.company_id
   AND td.order_id = pr.order_id
 INNER JOIN scmdata.t_orders pln
    ON pln.goo_id = pr.goo_id
   AND pln.order_id = pr.order_id
   AND pln.company_id = pr.company_id
 INNER JOIN scmdata.t_ordered po
    ON po.order_code = pln.order_id
   AND po.company_id = pln.company_id
 INNER JOIN scmdata.t_abnormal abn
    ON pr.company_id = abn.company_id
   AND pr.order_id = abn.order_id
   AND pr.goo_id = abn.goo_id
   AND td.abnormal_id = abn.abnormal_id
 INNER JOIN group_dict gd
    ON gd.group_dict_type = ''ANOMALY_CLASSIFICATION_DICT''
   AND gd.group_dict_value = abn.anomaly_class
 INNER JOIN group_dict a
    ON a.group_dict_type = ''ORIGIN_TYPE''
   AND a.group_dict_value = td.orgin
  LEFT JOIN scmdata.sys_company_user su
    ON su.company_id = td.company_id
   AND su.user_id = td.update_id
  LEFT JOIN scmdata.sys_user u
    ON u.user_account = td.update_id
 WHERE td.company_id = %default_company_id%
   AND td.order_id = :order_code
 ORDER BY td.orgin DESC, abn.anomaly_class DESC';
 
 UPDATE  bw3.sys_item_list t SET t.select_sql = v_sql WHERE t.item_id = 'a_product_130_3';
END;
/
DECLARE
v_sql CLOB;
BEGIN
  v_sql :='--20220831 czh修改扣款方式、比例
WITH group_dict AS
 (SELECT t.group_dict_type, t.group_dict_value, t.group_dict_name
    FROM scmdata.sys_group_dict t)
SELECT td.deduction_id,
       a.group_dict_name orgin,
       pr.product_gress_code,
       gd.group_dict_name anomaly_class,
       nvl(abn.delay_date, 0) delay_date,
       decode(td.orgin,
              ''SC'',
              nvl(abn.delay_amount, 0),
              ''MA'',
              (SELECT SUM(dr.delivery_amount)
                 FROM scmdata.t_delivery_record dr
                WHERE dr.company_id = pr.company_id
                  AND dr.order_code = pr.order_id
                  AND dr.goo_id = pr.goo_id)) delay_amount,
       (SELECT a.group_dict_name
          FROM group_dict a
         WHERE a.group_dict_type = ''DEDUCTION_METHOD''
           AND a.group_dict_value = td.discount_type) deduction_method_desc,
       td.discount_unit_price deduction_unit_price,
       td.discount_proportion deduction_ratio_pr,
       ---20220718 1.调整问题描述、实际扣款金额字段顺序 2.隐藏调整人、调整时间 3.新增原因细分  修改人：LSL167
       td.discount_price,
       td.actual_discount_price,
       abn.cause_detailed       cause_detail_desc,
       abn.detailed_reasons,
       --end lsl167
       td.adjust_price,
       td.adjust_reason,
       su.company_user_name adjust_person,
       td.update_time       adjust_time,
       :approve_status      approve_status
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
    ON gd.group_dict_type = ''ANOMALY_CLASSIFICATION_DICT''
   AND gd.group_dict_value = abn.anomaly_class
 INNER JOIN group_dict a
    ON a.group_dict_type = ''ORIGIN_TYPE''
   AND a.group_dict_value = td.orgin
  LEFT JOIN scmdata.sys_company_user su
    ON su.company_id = td.company_id
   AND su.user_id = td.update_id
 WHERE pr.supplier_code IN
       (SELECT supplier_code
          FROM scmdata.t_supplier_info
         WHERE supplier_company_id = %default_company_id%)
   AND td.order_id = :order_code
      ---20220804.增加原因细分不等于不可抗力时,供应商是否免责=1的不显示 修改人：LSL167
   AND (abn.cause_detailed = ''不可抗力'' OR abn.is_sup_responsible = 0)
---end lsl167
 ORDER BY td.orgin DESC, abn.anomaly_class DESC';
 
 UPDATE  bw3.sys_item_list t SET t.select_sql = v_sql WHERE t.item_id = 'a_product_140_3';
END;
/
