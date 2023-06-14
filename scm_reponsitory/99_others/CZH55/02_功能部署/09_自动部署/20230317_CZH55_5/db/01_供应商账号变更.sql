DECLARE
  v_user_account_new VARCHAR2(256) := '13527688968';
BEGIN
  FOR user_rec IN (SELECT a.user_id
                     FROM scmdata.sys_user a
                    WHERE a.user_id = 'eb461bfd88952ccde0531e64a8c09007') LOOP
    UPDATE scmdata.sys_company_user t
       SET t.phone = v_user_account_new
     WHERE t.user_id = user_rec.user_id;
  
    UPDATE scmdata.sys_user t
       SET t.user_account = v_user_account_new,
           t.phone        = v_user_account_new
     WHERE t.user_id = user_rec.user_id;
  
    UPDATE bw3.sys_oper_logs t
       SET t.user_id = v_user_account_new
     WHERE t.user_id LIKE '%13527688968%';
  END LOOP;
END;
/
