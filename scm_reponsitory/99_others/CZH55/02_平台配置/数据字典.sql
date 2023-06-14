--合作意向类型，分类，子类
SELECT c.rowid, c.*
  FROM scmdata.sys_group_dict p, scmdata.sys_group_dict c
 WHERE p.group_dict_id = c.parent_id
   AND p.parent_id IS NULL
   AND p.group_dict_value = 'COOPERATION_TYPE';

SELECT c.rowid, c.*
  FROM scmdata.sys_group_dict p, scmdata.sys_group_dict c
 WHERE p.group_dict_id = c.parent_id
   AND p.parent_id IS NULL
   AND p.group_dict_value = 'PRODUCT_TYPE';

SELECT c.*
  FROM scmdata.sys_group_dict p, scmdata.sys_group_dict c
 WHERE p.group_dict_id = c.parent_id
   AND p.parent_id IS NULL
   AND p.group_dict_value = '00';

SELECT p.rowid,p.*
  FROM scmdata.sys_group_dict p;
