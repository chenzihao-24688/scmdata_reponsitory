--批量导入员工
DECLARE
  v_insert_sql CLOB;
  v_update_sql CLOB;
  v_delete_sql CLOB;
BEGIN
  v_insert_sql := q'[DECLARE
v_company_user_temp_id varchar2(100);
BEGIN

v_company_user_temp_id := scmdata.sys_company_user_temp_s.nextval;

 INSERT INTO scmdata.sys_company_user_temp
    (company_user_temp_id,
     user_id,
     user_name,
     phone,
     inner_emp_number,
     dept_name,
     group_role_name,
     company_id)
  VALUES
    (v_company_user_temp_id,
     %user_id%,
     :user_name,
     :import_phone,
     :inner_emp_number,
     :import_dept_name,
     :import_group_role_name,
     %default_company_id%);
  
  --新增数据后，自动进行校验 
  scmdata.sf_import_company_users_pkg.check_importdatas(%default_company_id%,%user_id%,v_company_user_temp_id);
END;]';

  v_update_sql := q'[DECLARE

BEGIN
  UPDATE scmdata.sys_company_user_temp t
     SET t.user_name        = :user_name,
         t.phone            = :import_phone,
         t.inner_emp_number = :inner_emp_number,
         t.dept_name        = :import_dept_name,
         t.group_role_name  = :import_group_role_name
   WHERE  t.company_id = %default_company_id%
      AND t.user_id = %user_id%   
     AND t.company_user_temp_id = :company_user_temp_id;
      
  --更新数据后，自动进行校验
  scmdata.sf_import_company_users_pkg.check_importdatas(%default_company_id%,
                                                                %user_id%,
                                                                :company_user_temp_id);
END;]';

  v_delete_sql := q'[DECLARE
BEGIN
  DELETE FROM scmdata.sys_company_import_msg m
   WHERE m.msg_id = (SELECT t.err_msg_id
                       FROM scmdata.sys_company_user_temp t
                      WHERE t.company_id = %default_company_id%
                        AND t.user_id = %user_id%
                        AND t.company_user_temp_id = :company_user_temp_id);
                        
  DELETE FROM scmdata.sys_company_user_temp t
   WHERE t.company_id = %default_company_id%
     AND t.user_id = %user_id%
     AND t.company_user_temp_id = :company_user_temp_id;
END;]';

  UPDATE nbw.sys_item_list t
     SET t.insert_sql = v_insert_sql,
         t.update_sql = v_update_sql,
         t.delete_sql = v_delete_sql
   WHERE t.item_id = 'c_2100';

END;
/
