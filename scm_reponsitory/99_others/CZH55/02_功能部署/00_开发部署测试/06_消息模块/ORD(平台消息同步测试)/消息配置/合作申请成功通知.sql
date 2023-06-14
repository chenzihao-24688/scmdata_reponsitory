DECLARE
v_action_sql1 clob;
v_action_sql2 clob;
BEGIN
  v_action_sql1 := q'[--czh add ��ԭ�л�����������Ϣ��֪ͨ���빫˾��֪ͨ�����빫˾��
DECLARE
  p_i                      INT;
  --czh add��Ϣ
  v_becompany_name         VARCHAR2(100);
  v_company_name           VARCHAR2(100);
  v_cooperation_company_id VARCHAR2(100);
  v_bemsg                  VARCHAR2(4000);
  v_betarget_user          VARCHAR2(4000);
  v_msg                    VARCHAR2(4000);
  v_target_user            VARCHAR2(4000);

BEGIN
  SELECT nvl(MAX(1), 0)
    INTO p_i
    FROM scmdata.t_ask_scope
   WHERE object_id = :ask_record_id
     AND object_type = 'HZ';
  IF p_i = 0 THEN
    raise_application_error(-20002, '��������дһ����������Χ');
  END IF;
  IF :ask_date IS NOT NULL THEN
    raise_application_error(-20002, '���ύ�������벻��Ҫ�ظ��ύ');
  END IF;
  /*
  if pkg_ask_record_mange.is_access_audit_pass(:company_id, :be_company_id) = 1 then
    raise_application_error(-20002,
                            '����ͨ������ҵ��׼��������������·������룡');
  end if;
  if pkg_ask_record_mange.is_cooperation_running(:company_id,
                                                 :be_company_id) = 1 then
    raise_application_error(-20002, '���������еı��������ĵȴ�');
  end if;
  */

  pkg_ask_record_mange.has_coop_submit(pi_be_company_id      => :be_company_id,
                                       pi_social_credit_code => :social_credit_code);

  UPDATE t_ask_record
     SET ask_user_id          = :user_id,
         ask_date             = SYSDATE,
         sapply_user         =
         (SELECT MAX(company_user_name)
            FROM sys_company_user
           WHERE user_id = :user_id
             AND company_id = %default_company_id%),
         sapply_phone        =
         (SELECT phone FROM sys_user WHERE user_id = :user_id),
         coor_ask_flow_status = 'CA01'
   WHERE ask_record_id = :ask_record_id;

  INSERT INTO t_factory_ask_oper_log
    (log_id,
     ask_record_id,
     oper_user_id,
     oper_code,
     oper_time,
     status_af_oper,
     oper_user_company_id)
  VALUES
    (f_get_uuid(),
     :ask_record_id,
     :user_id,
     'SUBMIT',
     SYSDATE,
     'CA01',
     %default_company_id%);

  --czh add ��ҵ�������룺��ҵ����ɹ�֪ͨ��ϵͳ�Զ�֪ͨ��������ҵ����������֪ͨ��Ա��

  SELECT (SELECT a.logn_name
            FROM scmdata.sys_company a
           WHERE a.company_id = fa.company_id) company_name,
         (SELECT b.logn_name
            FROM scmdata.sys_company b
           WHERE b.company_id = fa.be_company_id) becompany_name,
         fa.be_company_id
    INTO v_company_name, v_becompany_name, v_cooperation_company_id
    FROM scmdata.t_ask_record fa
   WHERE fa.company_id = %default_company_id%
     AND fa.be_company_id = :be_company_id;

  --1)֪ͨ���빫˾
  v_msg := '�𾴵�[' || v_company_name || ']��˾����ϲ���ѳɹ�����Ϊ��˾[' ||
             v_becompany_name || ']�Ĺ�Ӧ�̣��ڴ�������';

  v_target_user := scmdata.pkg_msg_config.get_company_admin(%default_company_id%);

  scmdata.pkg_msg_config.config_plag_msg(p_msg_id      => scmdata.f_get_uuid(),
                                         p_urgent      => 0,
                                         p_msg_title   => '��ҵ����ɹ�֪ͨ',
                                         p_msg_content => v_msg,
                                         p_target_user => v_target_user,
                                         p_sender_name => v_becompany_name,
                                         p_msg_type    => 'SYSTEM',
                                         p_object_id   => '');

  --2)֪ͨ�����빫˾  ֪ͨ�����빫˾���𾴵�Y��˾��X��˾�������Ϊ���Ĺ�Ӧ�̣��ڴ�������
  v_bemsg := '�𾴵�[' || v_becompany_name || ']��˾����˾[' || v_company_name ||
           ']�������Ϊ���Ĺ�Ӧ�̣��ڴ�������';

  v_betarget_user := scmdata.pkg_msg_config.get_company_admin(v_cooperation_company_id);

  scmdata.pkg_msg_config.config_plag_msg(p_msg_id      => scmdata.f_get_uuid(),
                                         p_urgent      => 0,
                                         p_msg_title   => '��ҵ����ɹ�֪ͨ',
                                         p_msg_content => v_bemsg,
                                         p_target_user => v_betarget_user,
                                         p_sender_name => v_company_name,
                                         p_msg_type    => 'SYSTEM',
                                         p_object_id   => '');

END;



--ԭ�߼�
/*declare
  p_i int;
begin
  select nvl(max(1), 0)
    into p_i
    from scmdata.t_ask_scope
   where object_id = :ask_record_id
     and object_type = 'HZ';
  if p_i = 0 then
    raise_application_error(-20002, '��������дһ����������Χ');
  end if;
  if :ask_date is not null then
    raise_application_error(-20002, '���ύ�������벻��Ҫ�ظ��ύ');
  end if;
  /*
  if pkg_ask_record_mange.is_access_audit_pass(:company_id, :be_company_id) = 1 then
    raise_application_error(-20002,
                            '����ͨ������ҵ��׼��������������·������룡');
  end if;
  if pkg_ask_record_mange.is_cooperation_running(:company_id,
                                                 :be_company_id) = 1 then
    raise_application_error(-20002, '���������еı��������ĵȴ�');
  end if;
  */
  
pkg_ask_record_mange.has_coop_submit(pi_be_company_id => :be_company_id, pi_social_credit_code =>:social_credit_code );

 update t_ask_record
   set ask_user_id          = :user_id,
       ask_date             = sysdate,
       sapply_user         =
       (select max(company_user_name)
          from sys_company_user
         where user_id = :user_id
           and company_id = %default_company_id%),
       sapply_phone        =
       (select phone from sys_user where user_id = :user_id),
       COOR_ASK_FLOW_STATUS = 'CA01'
 where ask_record_id = :ask_record_id;
insert into t_factory_ask_oper_log
  (log_id,
   ask_record_id,
   oper_user_id,
   oper_code,
   oper_time,
   status_af_oper,
   oper_user_company_id)
values
  (f_get_uuid(),
   :ask_record_id,
   :user_id,
   'SUBMIT',
   sysdate,
   'CA01',
   %default_company_id%);

end;*/]';

v_action_sql2 := q'[--czh add ��ԭ�л�����������Ϣ��֪ͨ���빫˾��֪ͨ�����빫˾��
declare
  p_i int;
  p_c varchar2(32);
  --czh add��Ϣ
  v_becompany_name         VARCHAR2(100);
  v_company_name           VARCHAR2(100);
  v_cooperation_company_id VARCHAR2(100);
  v_bemsg                  VARCHAR2(4000);
  v_betarget_user          VARCHAR2(4000);
  v_msg                    VARCHAR2(4000);
  v_target_user            VARCHAR2(4000);
begin
 select nvl(max(1), 0)
    into p_i
    from scmdata.t_ask_scope
   where object_id = :ask_record_id
     and object_type = 'HZ';
  if p_i = 0 then
    raise_application_error(-20002, '��������дһ����������Χ');
  end if;
  select max(coor_ask_flow_status)
    into p_c
    from t_ask_record
   where ask_record_id = :ask_record_id;
  if p_c in ('CA01') then
    raise_application_error(-20002, '�������ύ������Ҫ�ظ��ύ');
  end if;
  if p_c in ('CA02') then
    raise_application_error(-20002, '���벻ͨ����������ȷ����ϸԭ��');
  end if;
  /*
  if pkg_ask_record_mange.is_access_audit_pass(:company_id,:be_company_id) = 1 then
    raise_application_error(-20002, '����ͨ������ҵ��׼��������������·������룡');
  end if;
  if pkg_ask_record_mange.is_cooperation_running(:company_id,:be_company_id) = 1 then
    raise_application_error(-20002, '���������еı��������ĵȴ�');
  end if;
  */
  
pkg_ask_record_mange.has_coop_submit(pi_be_company_id => :be_company_id, pi_social_credit_code =>:social_credit_code );
  update t_ask_record
     set ask_user_id          = :user_id,
         ask_date             = sysdate,
         COOR_ASK_FLOW_STATUS = 'CA01',
         sapply_user         =
       (select max(company_user_name)
          from sys_company_user
         where user_id = :user_id
           and company_id = %default_company_id%),
       sapply_phone        =
       (select phone from sys_user where user_id = :user_id)
   where ask_record_id = :ask_record_id;
  insert into t_factory_ask_oper_log
  (log_id,
   ask_record_id,
   oper_user_id,
   oper_code,
   oper_time,
   status_af_oper,
   oper_user_company_id)
values
  (f_get_uuid(),
   :ask_record_id,
   :user_id,
   'SUBMIT',
   sysdate,
   'CA01',
   %default_company_id%);
   
  --czh add ��ҵ�������룺��ҵ����ɹ�֪ͨ��ϵͳ�Զ�֪ͨ��������ҵ����������֪ͨ��Ա��

  SELECT (SELECT a.logn_name
            FROM scmdata.sys_company a
           WHERE a.company_id = fa.company_id) company_name,
         (SELECT b.logn_name
            FROM scmdata.sys_company b
           WHERE b.company_id = fa.be_company_id) becompany_name,
         fa.be_company_id
    INTO v_company_name, v_becompany_name, v_cooperation_company_id
    FROM scmdata.t_ask_record fa
   WHERE fa.company_id = %default_company_id%
     AND fa.be_company_id = :be_company_id;

  --1)֪ͨ���빫˾
  v_msg := '�𾴵�[' || v_company_name || ']��˾����ϲ���ѳɹ�����Ϊ��˾[' ||
             v_becompany_name || ']�Ĺ�Ӧ�̣��ڴ�������';

  v_target_user := scmdata.pkg_msg_config.get_company_admin(%default_company_id%);

  scmdata.pkg_msg_config.config_plag_msg(p_msg_id      => scmdata.f_get_uuid(),
                                         p_urgent      => 0,
                                         p_msg_title   => '��ҵ����ɹ�֪ͨ',
                                         p_msg_content => v_msg,
                                         p_target_user => v_target_user,
                                         p_sender_name => v_becompany_name,
                                         p_msg_type    => 'SYSTEM',
                                         p_object_id   => '');

  --2)֪ͨ�����빫˾  ֪ͨ�����빫˾���𾴵�Y��˾��X��˾�������Ϊ���Ĺ�Ӧ�̣��ڴ�������
  v_bemsg := '�𾴵�[' || v_becompany_name || ']��˾����˾[' || v_company_name ||
           ']�������Ϊ���Ĺ�Ӧ�̣��ڴ�������';

  v_betarget_user := scmdata.pkg_msg_config.get_company_admin(v_cooperation_company_id);

  scmdata.pkg_msg_config.config_plag_msg(p_msg_id      => scmdata.f_get_uuid(),
                                         p_urgent      => 0,
                                         p_msg_title   => '��ҵ����ɹ�֪ͨ',
                                         p_msg_content => v_bemsg,
                                         p_target_user => v_betarget_user,
                                         p_sender_name => v_company_name,
                                         p_msg_type    => 'SYSTEM',
                                         p_object_id   => '');


end;

--ԭ���߼�
/*declare
  p_i int;
  p_c varchar2(32);
begin
 select nvl(max(1), 0)
    into p_i
    from scmdata.t_ask_scope
   where object_id = :ask_record_id
     and object_type = 'HZ';
  if p_i = 0 then
    raise_application_error(-20002, '��������дһ����������Χ');
  end if;
  select max(coor_ask_flow_status)
    into p_c
    from t_ask_record
   where ask_record_id = :ask_record_id;
  if p_c in ('CA01') then
    raise_application_error(-20002, '�������ύ������Ҫ�ظ��ύ');
  end if;
  if p_c in ('CA02') then
    raise_application_error(-20002, '���벻ͨ����������ȷ����ϸԭ��');
  end if;
  /*
  if pkg_ask_record_mange.is_access_audit_pass(:company_id,:be_company_id) = 1 then
    raise_application_error(-20002, '����ͨ������ҵ��׼��������������·������룡');
  end if;
  if pkg_ask_record_mange.is_cooperation_running(:company_id,:be_company_id) = 1 then
    raise_application_error(-20002, '���������еı��������ĵȴ�');
  end if;
  */
  
pkg_ask_record_mange.has_coop_submit(pi_be_company_id => :be_company_id, pi_social_credit_code =>:social_credit_code );
  update t_ask_record
     set ask_user_id          = :user_id,
         ask_date             = sysdate,
         COOR_ASK_FLOW_STATUS = 'CA01',
         sapply_user         =
       (select max(company_user_name)
          from sys_company_user
         where user_id = :user_id
           and company_id = %default_company_id%),
       sapply_phone        =
       (select phone from sys_user where user_id = :user_id)
   where ask_record_id = :ask_record_id;
  insert into t_factory_ask_oper_log
  (log_id,
   ask_record_id,
   oper_user_id,
   oper_code,
   oper_time,
   status_af_oper,
   oper_user_company_id)
values
  (f_get_uuid(),
   :ask_record_id,
   :user_id,
   'SUBMIT',
   sysdate,
   'CA01',
   %default_company_id%);


end;*/]';

  update bw3.sys_action t set t.action_sql = v_action_sql1 where t.element_id = 'action_a_coop_121';
  update bw3.sys_action t set t.action_sql = v_action_sql2 where t.element_id = 'action_a_coop_130';
END;
