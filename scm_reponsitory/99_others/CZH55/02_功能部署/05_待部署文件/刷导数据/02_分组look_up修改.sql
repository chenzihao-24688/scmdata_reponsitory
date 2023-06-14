DECLARE
v_sql CLOB;
BEGIN
v_sql := q'[SELECT t.group_name group_name_desc, t.group_config_id group_name
  FROM scmdata.t_supplier_group_config t
 WHERE t.company_id = %default_company_id%]';
 
UPDATE bw3.sys_look_up t SET t.look_up_sql = v_sql WHERE t.element_id = 'look_a_supp_151';
END;
/
