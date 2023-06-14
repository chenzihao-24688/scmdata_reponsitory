CREATE OR REPLACE VIEW V_PRODUCT_PROGRESS_STATUS AS
SELECT b.company_id,
       c.company_dict_value progress_value,
       c.company_dict_name  progress_name,
       c.company_dict_sort  status_sort
  FROM scmdata.sys_group_dict a
 INNER JOIN scmdata.sys_company_dict b
    ON b.company_dict_type = a.group_dict_value
   AND a.pause = 0
   AND b.pause = 0
 INNER JOIN scmdata.sys_company_dict c
    ON c.company_dict_type = b.company_dict_value
   AND c.company_id = b.company_id
   AND c.pause = 0
 WHERE a.group_dict_type = 'PROGRESS_TYPE'
   AND a.group_dict_value = '02';
