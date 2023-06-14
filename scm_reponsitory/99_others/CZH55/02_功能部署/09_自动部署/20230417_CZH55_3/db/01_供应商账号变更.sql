--根据企业变更
DECLARE
  v_licence_num      VARCHAR2(256) := '91440515708047306N';
  v_user_account_new VARCHAR2(256) := '13428336199';
BEGIN
  FOR user_rec IN (SELECT a.attributor_id user_id, b.user_account user_account_old
                     FROM scmdata.sys_company a
                    INNER JOIN scmdata.sys_user b
                       ON b.user_id = a.attributor_id
                    WHERE a.licence_num = v_licence_num) LOOP
    UPDATE scmdata.sys_company_user t
       SET t.phone = v_user_account_new
     WHERE t.user_id = user_rec.user_id;
  
    UPDATE scmdata.sys_user t
       SET t.user_account = v_user_account_new,
           t.phone        = v_user_account_new
     WHERE t.user_id = user_rec.user_id;
  
    UPDATE bw3.sys_oper_logs t
       SET t.user_id = v_user_account_new
     WHERE t.user_id = user_rec.user_account_old;
  END LOOP;
END;
/
