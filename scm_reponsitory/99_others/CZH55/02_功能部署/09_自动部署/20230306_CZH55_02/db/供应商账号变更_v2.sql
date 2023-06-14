DECLARE
  p_user_id VARCHAR2(256);
  v_user_name VARCHAR2(256) := '�Ź��Ҿ���Ʒ';
  v_phone VARCHAR2(256) := '18653120815';
  v_licence_num VARCHAR2(256) := '91440106MAC14MY400';
BEGIN
  scmdata.pkg_plat_comm.p_user_register(pi_moblie       => v_phone,
                                        pi_uuid         => NULL,
                                        pi_devicesystem => NULL);

  SELECT MAX(user_id)
    INTO p_user_id
    FROM scmdata.sys_user a
   WHERE a.user_account = v_phone;

  UPDATE scmdata.sys_user a
     SET a.password = '496d234c7d6f6f7a422d634747632d4273616173422d6d05'
   WHERE a.user_id = p_user_id;

  UPDATE scmdata.sys_user a
     SET a.username  = ltrim(rtrim(v_user_name)),
         a.nick_name = ltrim(rtrim(v_user_name))
   WHERE a.user_id = p_user_id;

  UPDATE scmdata.sys_company_user a
     SET a.company_user_name = ltrim(rtrim(v_user_name)),
         a.nick_name         = ltrim(rtrim(v_user_name)),
         a.phone             = v_phone
   WHERE a.user_id = p_user_id;

  UPDATE scmdata.sys_company t
     SET t.attributor_id = p_user_id
   WHERE t.licence_num = v_licence_num;
END;
/
DECLARE
  p_user_id VARCHAR2(256);
  v_user_name VARCHAR2(256) := '�Ŵ�';
  v_phone VARCHAR2(256) := '18928825908';
  v_licence_num VARCHAR2(256) := '91440101MA5CX8K815';
BEGIN
  SELECT MAX(user_id)
    INTO p_user_id
    FROM scmdata.sys_user a
   WHERE a.user_account = v_phone;

  UPDATE scmdata.sys_user a
     SET a.password = '496d234c7d6f6f7a422d634747632d4273616173422d6d05'
   WHERE a.user_id = p_user_id;

  UPDATE scmdata.sys_user a
     SET a.username  = ltrim(rtrim(v_user_name)),
         a.nick_name = ltrim(rtrim(v_user_name))
   WHERE a.user_id = p_user_id;

  UPDATE scmdata.sys_company_user a
     SET a.company_user_name = ltrim(rtrim(v_user_name)),
         a.nick_name         = ltrim(rtrim(v_user_name)),
         a.phone             = v_phone
   WHERE a.user_id = p_user_id;

  UPDATE scmdata.sys_company t
     SET t.attributor_id = p_user_id
   WHERE t.licence_num = v_licence_num;
END;
/
