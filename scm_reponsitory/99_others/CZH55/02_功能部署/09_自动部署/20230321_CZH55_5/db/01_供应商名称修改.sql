BEGIN
  FOR rec IN (SELECT t.company_user_id, a.company_name
                FROM scmdata.sys_company a
               INNER JOIN scmdata.sys_company_user t
                  ON t.company_id = a.company_id
               WHERE t.phone = '13924599894') LOOP
    UPDATE scmdata.sys_company_user t
       SET t.nick_name         = rec.company_name,
           t.company_user_name = rec.company_name
     WHERE t.company_user_id = rec.company_user_id;
  END LOOP;
END;
/
