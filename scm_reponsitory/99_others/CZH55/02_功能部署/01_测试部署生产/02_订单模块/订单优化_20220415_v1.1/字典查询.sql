SELECT a.group_dict_value VALUE, a.group_dict_name NAME
  FROM scmdata.sys_group_dict a
 WHERE a.group_dict_type = 'PROGRESS_TYPE'
   AND a.group_dict_value not in ('01','02','03')
UNION ALL
SELECT c.company_dict_value VALUE, c.company_dict_name NAME
  FROM scmdata.sys_group_dict a
 INNER JOIN scmdata.sys_company_dict b
    ON b.company_dict_type = a.group_dict_value
    and substr(b.company_dict_value,3,4) = '01'
 INNER JOIN scmdata.sys_company_dict c
    ON c.company_dict_type = b.company_dict_value
   AND c.company_id = b.company_id
 WHERE a.group_dict_type = 'PROGRESS_TYPE'
   AND a.group_dict_value = '02'
   AND b.company_id = 'a972dd1ffe3b3a10e0533c281cac8fd7';

