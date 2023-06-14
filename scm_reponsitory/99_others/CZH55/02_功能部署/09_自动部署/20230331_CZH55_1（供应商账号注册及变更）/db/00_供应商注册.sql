DECLARE
  p_result  VARCHAR2(1000);
  p_msg     VARCHAR2(1000);
  p_user_id VARCHAR2(32);
  p_logo    VARCHAR2(32);
  p_c       INT;
  p_u       INT;
  p_s       INT;
BEGIN
  FOR x IN (SELECT *
              FROM scmdata.sys_company_user_temp a
             WHERE a.user_id =
                   (SELECT user_id
                      FROM scmdata.sys_user u
                     WHERE u.user_account = '18172543571')) LOOP
    --���û�ж�Ӧ�Ĺ�Ӧ�̵���Ҳ��������
    SELECT nvl(MAX(1), 0)
      INTO p_s
      FROM scmdata.t_supplier_info si
     WHERE si.social_credit_code = ltrim(rtrim(x.group_role_name))
       AND si.company_id = x.company_id;
    IF p_s = 0 THEN
      dbms_output.put_line(x.user_name || '��Ӧ�̵���������');
      CONTINUE;
    END IF;
  
    SELECT nvl(MAX(1), 0)
      INTO p_c
      FROM scmdata.sys_company c
     WHERE c.logn_name = ltrim(rtrim(x.user_name));
    SELECT nvl(MAX(1), 0)
      INTO p_u
      FROM scmdata.sys_user u
     WHERE u.user_account = x.phone;
  
    IF p_c = 1 AND p_u = 1 THEN
      dbms_output.put_line(x.user_name || '�ѵ���');
      CONTINUE;
    END IF;
    IF p_u = 0 THEN
      scmdata.pkg_plat_comm.p_user_register(pi_moblie       => x.phone,
                                            pi_uuid         => NULL,
                                            pi_devicesystem => NULL);
    END IF;
  
    SELECT MAX(user_id)
      INTO p_user_id
      FROM scmdata.sys_user a
     WHERE a.user_account = x.phone;
    UPDATE scmdata.sys_user a
       SET a.password = '496d234c7d6f6f7a422d634747632d4273616173422d6d05'
     WHERE a.user_id = p_user_id;
  
    UPDATE scmdata.sys_user a
       SET a.username  = ltrim(rtrim(x.dept_name)),
           a.nick_name = ltrim(rtrim(x.dept_name))
     WHERE a.user_id = p_user_id;
    UPDATE scmdata.sys_company_user a
       SET a.company_user_name = ltrim(rtrim(x.dept_name)),
           a.nick_name         = ltrim(rtrim(x.dept_name))
     WHERE a.user_id = p_user_id;
    p_logo := '1';
    scmdata.pkg_user_my_company.p_register_company(pi_user_id     => p_user_id,
                                                   pi_logo        => p_logo,
                                                   pi_name        => ltrim(rtrim(x.dept_name)),
                                                   pi_logn_name   => ltrim(rtrim(x.user_name)),
                                                   pi_licence_num => ltrim(rtrim(x.group_role_name)),
                                                   pi_tips        => ltrim(rtrim(x.dept_name)),
                                                   po_result      => p_result,
                                                   po_msg         => p_msg);
  
    IF p_result < 0 THEN
      dbms_output.put_line(x.user_name || p_msg);
    END IF;
  
    IF scmdata.pkg_user_default_company.f_count_user_company(p_user_id) = 1 THEN
      scmdata.pkg_user_default_company.p_user_company_default_when_user_change(p_user_id,
                                                                               p_result,
                                                                               p_msg);
      IF p_result < 0 THEN
        dbms_output.put_line(x.user_name || p_msg);
      END IF;
    END IF;
  END LOOP;
END;
/
