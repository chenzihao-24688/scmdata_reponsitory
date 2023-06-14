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
 WHERE a.group_dict_value = :abn_category_a
   AND :abn_fileds_type = '01'
   AND c.company_id = %default_company_id%
UNION ALL
SELECT v.supplier_code VALUE,v.supplier_company_name NAME
  FROM (SELECT listagg(DISTINCT tc.coop_classification, ';') coop_classification,
               t.supplier_code,
               t.supplier_company_name
          FROM scmdata.t_supplier_info t
          LEFT JOIN scmdata.t_coop_scope tc
            ON tc.supplier_info_id = t.supplier_info_id
           AND tc.company_id = t.company_id
          AND tc.pause = 0
         WHERE t.company_id = %default_company_id%
           AND t.status = 1
         GROUP BY tc.coop_classification, t.supplier_code,t.supplier_company_name, t.company_id) v
 WHERE :abn_fileds_type = '02'
   AND instr(';' || v.coop_classification || ';',
             ';' || :abn_category_a || ';') > 0]';
UPDATE bw3.sys_param_list t SET t.value_sql = v_sql WHERE t.param_name ='ABN_FILEDS_TYPE_A';
END;
/
