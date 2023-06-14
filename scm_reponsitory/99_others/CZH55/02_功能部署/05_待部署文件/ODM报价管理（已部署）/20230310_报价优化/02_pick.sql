DECLARE
  v_sql CLOB;
BEGIN
  UPDATE bw3.sys_field_list t
     SET t.caption = '辅料明细'
   WHERE t.field_name = 'CONSUMABLES_MATERIAL_NAME';
  UPDATE bw3.sys_field_list t
     SET t.caption = '常规辅料报价分类'
   WHERE t.field_name = 'MATERIAL_QUOTATION_CLASS_DESC';
  UPDATE bw3.sys_field_list t
     SET t.caption = '辅料来源'
   WHERE t.field_name = 'MATERIAL_SOURCE_DESC';

  v_sql := q'[SELECT v.quotation_classification_n1,
       v.quotation_classification_n2,
       v.quotation_classification_v2 quotation_classification,
       v.quotation_classification_n1 || '/' ||
       v.quotation_classification_n2  quotation_classification_n
  FROM (SELECT a.company_dict_name quotation_classification_n1,               
               nvl2(d.company_dict_name,
                    b.company_dict_name || '-' || c.company_dict_name || '/' ||
                    d.company_dict_name,
                    nvl2(c.company_dict_name,
                         b.company_dict_name || '-' || c.company_dict_name,
                         b.company_dict_name)) quotation_classification_n2,               
               nvl(d.company_dict_id,
                   nvl(c.company_dict_id, b.company_dict_id)) quotation_classification_v2        
          FROM scmdata.sys_company_dict a
          LEFT JOIN scmdata.sys_company_dict b
            ON b.company_dict_type = a.company_dict_value
           AND b.company_id = a.company_id
           AND a.pause = 0
           AND b.pause = 0
          LEFT JOIN scmdata.sys_company_dict c
            ON c.company_dict_type = b.company_dict_value
           AND c.company_id = b.company_id
           AND c.pause = 0
          LEFT JOIN scmdata.sys_company_dict d
            ON d.company_dict_type = c.company_dict_value
           AND d.company_id = c.company_id
           AND d.pause = 0
         WHERE a.company_dict_type = 'PLM_READY_PRICE_CLASSIFICATION'
           AND a.company_id = 'b6cc680ad0f599cde0531164a8c0337f') v]';

  UPDATE bw3.sys_pick_list t
     SET t.pick_sql     = v_sql,
         t.query_fields = 'QUOTATION_CLASSIFICATION_N1,QUOTATION_CLASSIFICATION_N2',
         t.tree_fields  = 'QUOTATION_CLASSIFICATION_N1,QUOTATION_CLASSIFICATION_N2'
   WHERE t.element_id = 'pick_a_quotation_110';
END;
/
