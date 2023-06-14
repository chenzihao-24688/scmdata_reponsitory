DECLARE
  v_sql CLOB;
BEGIN
  v_sql := 'WITH group_dict AS
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
     AND instr('';'' || dr.product_subclass || '';'',
               '';'' || tc.samll_category || '';'') > 0
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
       a.group_dict_name orgin,
       pr.product_gress_code,
       gd.group_dict_name anomaly_class,
       abn.detailed_reasons,
       td.memo,
       nvl(abn.delay_date, 0) delay_date,
       nvl(td.deduction_amount, 0) delay_amount,
       (SELECT a.group_dict_name
          FROM group_dict a
         WHERE a.group_dict_type = ''DEDUCTION_METHOD''
           AND a.group_dict_value = abn.deduction_method) deduction_method_desc,
       td.discount_unit_price deduction_unit_price,
       decode(abn.deduction_method,
              ''METHOD_00'',
              0,
              ''METHOD_01'',
              0,
              ''METHOD_02'',
              decode(abn.anomaly_class,
                     ''AC_DATE'',
                     nvl((SELECT deduction_ratio
                           FROM deduction_ratio drt
                          WHERE drt.company_id = pr.company_id
                            AND drt.goo_id = pr.goo_id
                            AND (abn.delay_date >= drt.section_start AND
                                abn.delay_date < drt.section_end)),
                         0),
                     ''AC_OTHERS'',
                     abn.deduction_unit_price,
                     0)) deduction_ratio_pr,
       td.discount_price,
       td.adjust_price,
       td.adjust_reason,
       td.actual_discount_price,
       nvl(su.company_user_name,u.username) adjust_person,
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
    ON gd.group_dict_type = ''ANOMALY_CLASSIFICATION_DICT''
   AND gd.group_dict_value = abn.anomaly_class
 INNER JOIN group_dict a
    ON a.group_dict_type = ''ORIGIN_TYPE''
   AND a.group_dict_value = td.orgin
  LEFT JOIN scmdata.sys_company_user su
    ON su.company_id = td.company_id
   AND su.user_id = td.update_id
  LEFT JOIN scmdata.sys_user u ON u.user_account = td.update_id
 WHERE td.company_id = %default_company_id%
   AND td.order_id = :order_code
 ORDER BY td.orgin DESC, abn.anomaly_class DESC';
 
  UPDATE bw3.sys_item_list t
     SET t.select_sql = v_sql
   WHERE t.item_id = 'a_product_130_3';
END;
/
