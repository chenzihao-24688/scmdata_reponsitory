CREATE OR REPLACE VIEW plm.V_PLM_QUOTATION_CLASS AS
SELECT v.quotation_classification_n1,
       v.quotation_classification_n2,
       v.quotation_classification_v2,
       v.quotation_classification quotation_classification,
       v.quotation_classification_n1 || '/' ||
       v.quotation_classification_n2 quotation_classification_n,
       v.company_id
  FROM (SELECT a.company_dict_name quotation_classification_n1,
               b.company_dict_value quotation_classification_v2,
               nvl2(d.company_dict_name,
                    b.company_dict_name || '/' || c.company_dict_name || '/' ||
                    d.company_dict_name,
                    nvl2(c.company_dict_name,
                         b.company_dict_name || '/' || c.company_dict_name,
                         b.company_dict_name)) quotation_classification_n2,
               nvl(d.company_dict_id,
                   nvl(c.company_dict_id, b.company_dict_id)) quotation_classification,
               a.company_id
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
         WHERE a.company_dict_type = 'PLM_READY_PRICE_CLASSIFICATION') v;
/
