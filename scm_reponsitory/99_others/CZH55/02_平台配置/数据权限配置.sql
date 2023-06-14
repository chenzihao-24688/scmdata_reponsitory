--原分部-数据权限配置
SELECT * FROM scmdata.sys_company_data_priv;
SELECT * FROM scmdata.sys_company_dept_data_priv;

--数据权限配置
--数据权限组
SELECT * FROM sys_company_data_priv_group;
--数据权限
SELECT * FROM sys_data_privs;
--数据（权限组-数据权限）中间表
SELECT * FROM sys_company_data_priv_middle;
--数据权限字段表
SELECT * FROM sys_company_data_priv_fields;
--数据权限页面配置表
SELECT * FROM sys_company_data_priv_page;
--企业数据权限（组-页面配置）中间表
SELECT * FROM sys_company_data_priv_page_middle;
----企业数据权限（组-人员配置）中间表
select * from scmdata.sys_company_data_priv_user_middle;
select * from scmdata.sys_company_data_priv_dept_middle;

--数据权限字段表
--SELECT * FROM sys_company_data_priv_fields;
SELECT * FROM sys_data_priv_pick_fields;
SELECT * FROM sys_data_priv_lookup_fields;
SELECT * FROM sys_data_priv_date_fields;



--页面配置
SELECT ROWID, t.* FROM nbw.sys_item t WHERE t.item_id LIKE '%c_24%';
SELECT ROWID, t.* FROM nbw.sys_tree_list t WHERE t.item_id LIKE '%c_24%';
SELECT ROWID, t.* FROM nbw.sys_item_list t WHERE t.item_id LIKE '%c_24%';

SELECT ROWID, t.* FROM nbw.sys_item_rela t WHERE t.item_id LIKE '%c_24%';
SELECT ROWID, t.* FROM nbw.sys_web_union t WHERE t.item_id LIKE '%c_24%';

SELECT ROWID, t.* FROM nbw.sys_item t WHERE t.item_id LIKE '%g_560%';
SELECT ROWID, t.* FROM nbw.sys_tree_list t WHERE t.item_id LIKE '%g_560%';
SELECT ROWID, t.* FROM nbw.sys_item_list t WHERE t.item_id LIKE '%g_560%';

SELECT ROWID, t.*
  FROM nbw.sys_field_list t
 WHERE t.field_name = upper('data_priv_field_type');

SELECT ROWID, t.*
  FROM nbw.sys_param_list t
 WHERE t.param_name = upper('data_priv_field_type');

--ACTION
SELECT ROWID, t.*
  FROM nbw.sys_element t
 WHERE t.element_id = 'action_c_2412_1';
SELECT ROWID, t.*
  FROM nbw.sys_action t
 WHERE t.element_id = 'action_c_2412_1';
SELECT ROWID, t.*
  FROM nbw.sys_item_element_rela t
 WHERE t.element_id = 'action_c_2412_1';

--CHECK_ACTION
SELECT ROWID, t.*
  FROM nbw.sys_cond_list t
 WHERE t.cond_id = 'cond_c_2420_1';

SELECT ROWID, t.*
  FROM nbw.sys_cond_rela t
 WHERE t.cond_id = 'cond_c_2420_1';

SELECT ROWID, t.*
  FROM nbw.sys_cond_operate t
 WHERE t.cond_id = 'cond_c_2420_1';
 
--sys_associate
SELECT ROWID, t.*
  FROM nbw.sys_element t
 WHERE t.element_id = 'associate_c_2420_1';
SELECT ROWID, t.*
  FROM nbw.sys_associate t
 WHERE t.element_id = 'associate_c_2420_1';
SELECT ROWID, t.*
  FROM nbw.sys_item_element_rela t
 WHERE t.element_id = 'associate_c_2420_1';

--PICK_LIST
SELECT ROWID, t.*
  FROM nbw.sys_element t
 WHERE t.element_id like '%c_24%';
 
SELECT ROWID, t.* FROM nbw.sys_pick_list t WHERE t.element_id like '%pick_c_24%';
SELECT ROWID, t.* FROM nbw.sys_look_up t WHERE t.element_id like '%look_c_24%';

SELECT ROWID, t.*
  FROM nbw.sys_item_element_rela t
 WHERE t.element_id like '%c_24%';
 
select rowid,t.* from nbw.sys_element_hint t ;

--DATE
--LOOKUP

--删除数据权限
BEGIN
  --数据权限页面配置表
  DELETE FROM sys_company_data_priv_page_middle;

  DELETE FROM sys_company_data_priv_page;

  ----企业数据权限（组-人员配置）中间表
  DELETE FROM scmdata.sys_company_data_priv_user_middle;

  DELETE FROM scmdata.sys_company_data_priv_dept_middle;

  --数据（权限组-数据权限）中间表
  DELETE FROM sys_company_data_priv_middle;

  --数据权限字段表
  DELETE FROM sys_company_data_priv_fields;

  DELETE FROM sys_data_priv_pick_fields;
  DELETE FROM sys_data_priv_lookup_fields;
  DELETE FROM sys_data_priv_date_fields;

  DELETE FROM sys_data_privs;
END;
