--SELECT * FROM nbw.sys_item_list t WHERE t.item_id = 'c_2100';

DECLARE
  v_select_sql CLOB;
  v_insert_sql CLOB;
  v_update_sql CLOB;
BEGIN
  v_select_sql := 'SELECT company_user_temp_id,
       t.company_id,
       t.user_id,
       user_name,
       phone                import_phone,
       inner_emp_number,
       dept_name            import_dept_name,
       group_role_name      import_group_role_name,
       m.msg_type,
       m.msg,
       row_number() over(PARTITION BY m.msg_type ORDER BY t.user_id ASC) row_num
  FROM scmdata.sys_company_user_temp t
  LEFT JOIN scmdata.sys_company_import_msg m
    ON t.err_msg_id = m.msg_id
 WHERE t.company_id = %default_company_id%
   AND t.user_id = %user_id%';

  v_insert_sql := 'DECLARE
  
BEGIN
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
    (scmdata.sys_company_user_temp_s.nextval,
     %user_id%,
     :user_name,
     :import_phone,
     :inner_emp_number,
     :import_dept_name,
     :import_group_role_name,
     %default_company_id%);
  scmdata.sf_import_company_users_pkg.check_importdatas(%default_company_id%,%user_id%);
END;';

  v_update_sql := 'DECLARE

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
      
  scmdata.sf_import_company_users_pkg.check_updated_importdatas(%default_company_id%,
                                                                %user_id%,
                                                                :company_user_temp_id);
END;';

  UPDATE nbw.sys_item_list t
     SET t.select_sql = v_select_sql,
         t.insert_sql = v_insert_sql,
         t.update_sql = v_update_sql
   WHERE t.item_id = 'c_2100';
   
END;
