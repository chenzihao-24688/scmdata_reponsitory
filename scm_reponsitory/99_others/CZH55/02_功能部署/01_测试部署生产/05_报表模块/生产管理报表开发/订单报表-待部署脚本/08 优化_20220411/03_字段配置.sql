DECLARE
  v_sql CLOB;
BEGIN
  v_sql := q'[SELECT DISTINCT c.company_dict_name NAME, NULL VALUE
  FROM scmdata.sys_group_dict a
 INNER JOIN scmdata.sys_group_dict b
    ON a.group_dict_value = b.group_dict_type
   AND a.group_dict_type = 'PRODUCT_TYPE'
 INNER JOIN scmdata.sys_company_dict c
    ON b.group_dict_value = c.company_dict_type
 WHERE :abnc_fileds_type = '01'
   AND a.group_dict_value = :abn_category
   AND c.company_id = %default_company_id%
UNION ALL
SELECT DISTINCT t.supplier_code VALUE, t.supplier_company_name NAME
  FROM scmdata.pt_ordered t
 WHERE t.company_id = %default_company_id%
   AND :abn_category = t.category
   AND t.supplier_code IS NOT NULL
   AND :abnc_fileds_type = '02'
UNION ALL
SELECT DISTINCT t.factory_code VALUE, t.factory_company_name NAME
  FROM scmdata.pt_ordered t
 WHERE t.company_id = %default_company_id%
   AND :abn_category = t.category
   AND t.factory_code IS NOT NULL
   AND :abnc_fileds_type = '03'
UNION ALL
SELECT DISTINCT a.user_id VALUE, a.company_user_name NAME
  FROM scmdata.pt_ordered t
 INNER JOIN scmdata.sys_company_user a
    ON instr(t.qc, a.user_id) > 0
   AND t.company_id = a.company_id
 WHERE t.company_id = %default_company_id%
   AND :abn_category = t.category
   AND t.qc IS NOT NULL
   AND :abnc_fileds_type = '04'
UNION ALL
SELECT DISTINCT a.user_id VALUE, a.company_user_name NAME
  FROM scmdata.pt_ordered t
 INNER JOIN scmdata.sys_company_user a
    ON instr(t.flw_order, a.user_id) > 0
   AND t.company_id = a.company_id
 WHERE t.company_id = %default_company_id%
   AND :abn_category = t.category
   AND t.flw_order IS NOT NULL
   AND :abnc_fileds_type = '05']';
  UPDATE bw3.sys_param_list t
     SET t.value_sql = v_sql
   WHERE t.param_name = 'ABNC_FILEDS_TYPE_A';
END;
