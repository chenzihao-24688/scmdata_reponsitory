BEGIN
  FOR rec IN (SELECT *
                FROM scmdata.sys_company_user_temp a
               WHERE a.user_id =
                     (SELECT user_id
                        FROM scmdata.sys_user u
                       WHERE u.user_account = '18172543571')) LOOP
    UPDATE scmdata.t_supplier_info t
       SET t.group_name        = rec.phone,
           t.group_name_origin = 'MA',
           t.update_id         = 'ADMIN',
           t.update_date       = SYSDATE
     WHERE t.supplier_code = rec.user_name
       AND t.company_id = 'b6cc680ad0f599cde0531164a8c0337f';
  END LOOP;
END;
/
