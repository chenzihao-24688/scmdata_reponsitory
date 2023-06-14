DECLARE
  v_licence_num      VARCHAR2(256) := '91440101MA5CX8K815';
  v_user_account_old VARCHAR2(256) := '18653120815';
  v_user_account_new VARCHAR2(256) := '18928825908';
  v_user_id          VARCHAR2(32);
  v_company_id       VARCHAR2(32);
BEGIN
  SELECT MAX(fu.user_id), MAX(fc.company_id)
    INTO v_user_id, v_company_id
    FROM scmdata.sys_company fc
   INNER JOIN scmdata.sys_company_user fu
      ON fu.company_id = fc.company_id
   WHERE fc.licence_num = v_licence_num
     AND fu.phone = v_user_account_old;

  UPDATE scmdata.sys_company_user t
     SET t.phone = v_user_account_new
   WHERE t.user_id = v_user_id
     AND t.company_id = v_company_id;

  UPDATE scmdata.sys_user t
     SET t.user_account = v_user_account_new, t.phone = v_user_account_new
   WHERE t.user_id = v_user_id;

  UPDATE bw3.sys_oper_logs t
     SET t.user_id = v_user_account_new
   WHERE t.user_id = v_user_account_old;
END;
/
