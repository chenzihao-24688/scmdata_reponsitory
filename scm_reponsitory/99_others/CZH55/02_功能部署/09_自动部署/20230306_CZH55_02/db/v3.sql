DECLARE
  p_user_id     VARCHAR2(256);
  v_user_name   VARCHAR2(256) := '雅果家居用品';
  v_phone       VARCHAR2(256) := '18653120815';
  v_licence_num VARCHAR2(256) := '91440106MAC14MY400';
  p_result      VARCHAR2(1000);
  p_msg         VARCHAR2(1000);
BEGIN
  SELECT MAX(user_id)
    INTO p_user_id
    FROM scmdata.sys_user a
   WHERE a.user_account = v_phone;

/*  scmdata.pkg_plat_comm.p_user_register(pi_moblie       => v_phone,
                                        pi_uuid         => NULL,
                                        pi_devicesystem => NULL);*/

  scmdata.pkg_user_my_company.p_register_company(pi_user_id     => p_user_id,
                                                 pi_logo        => 1,
                                                 pi_name        => v_user_name,
                                                 pi_logn_name   => v_user_name,
                                                 pi_licence_num => v_licence_num,
                                                 pi_tips        => v_user_name,
                                                 po_result      => p_result,
                                                 po_msg         => p_msg);

  IF p_result < 0 THEN
    dbms_output.put_line(v_user_name || p_msg);
  END IF;

  IF scmdata.pkg_user_default_company.f_count_user_company(p_user_id) = 1 THEN
    scmdata.pkg_user_default_company.p_user_company_default_when_user_change(p_user_id,
                                                                             p_result,
                                                                             p_msg);
    IF p_result < 0 THEN
      dbms_output.put_line(v_user_name || p_msg);
    END IF;
  END IF;

  /* UPDATE scmdata.sys_user a
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
   WHERE t.licence_num = v_licence_num;*/
END;
