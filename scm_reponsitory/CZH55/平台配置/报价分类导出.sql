SELECT a.company_dict_name  quotation_classification_n1,
       b.company_dict_name  quotation_classification_n2,
       c.company_dict_name  quotation_classification_n3,
       d.company_dict_name  quotation_classification_n4,
       a.company_dict_value quotation_classification_v1,
       b.company_dict_value quotation_classification_v2,
       c.company_dict_value quotation_classification_v3,
       d.company_dict_value quotation_classification_v4
  FROM scmdata.sys_company_dict a
 INNER JOIN scmdata.sys_company_dict b
    ON b.company_dict_type = a.company_dict_value
   AND b.company_id = a.company_id
 INNER JOIN scmdata.sys_company_dict c
    ON c.company_dict_type = b.company_dict_value
   AND c.company_id = b.company_id
  LEFT JOIN scmdata.sys_company_dict d
    ON d.company_dict_type = c.company_dict_value
   AND d.company_id = c.company_id
 WHERE a.company_dict_type = 'PLM_READY_PRICE_CLASSIFICATION'
   AND a.company_id = 'b6cc680ad0f599cde0531164a8c0337f'
