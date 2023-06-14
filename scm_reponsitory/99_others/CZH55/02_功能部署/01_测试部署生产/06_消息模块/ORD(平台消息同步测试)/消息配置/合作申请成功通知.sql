DECLARE
v_action_sql1 clob;
v_action_sql2 clob;
BEGIN
  v_action_sql1 := q'[--czh add 在原有基础上增加消息（通知申请公司，通知被申请公司）
DECLARE
  p_i                      INT;
  --czh add消息
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
    raise_application_error(-20002, '请至少填写一个合作意向范围');
  END IF;
  IF :ask_date IS NOT NULL THEN
    raise_application_error(-20002, '已提交过的申请不需要重复提交');
  END IF;
  /*
  if pkg_ask_record_mange.is_access_audit_pass(:company_id, :be_company_id) = 1 then
    raise_application_error(-20002,
                            '您已通过该企业的准入合作，不可重新发起申请！');
  end if;
  if pkg_ask_record_mange.is_cooperation_running(:company_id,
                                                 :be_company_id) = 1 then
    raise_application_error(-20002, '存在申请中的表单，请耐心等待');
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

  --czh add 企业主动申请：企业申请成功通知：系统自动通知被申请企业（无需配置通知人员）

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

  --1)通知申请公司
  v_msg := '尊敬的[' || v_company_name || ']公司，恭喜您已成功申请为我司[' ||
             v_becompany_name || ']的供应商，期待合作！';

  v_target_user := scmdata.pkg_msg_config.get_company_admin(%default_company_id%);

  scmdata.pkg_msg_config.config_plag_msg(p_msg_id      => scmdata.f_get_uuid(),
                                         p_urgent      => 0,
                                         p_msg_title   => '企业申请成功通知',
                                         p_msg_content => v_msg,
                                         p_target_user => v_target_user,
                                         p_sender_name => v_becompany_name,
                                         p_msg_type    => 'SYSTEM',
                                         p_object_id   => '');

  --2)通知被申请公司  通知被申请公司：尊敬的Y公司，X公司已申请成为您的供应商，期待合作！
  v_bemsg := '尊敬的[' || v_becompany_name || ']公司，我司[' || v_company_name ||
           ']已申请成为您的供应商，期待合作！';

  v_betarget_user := scmdata.pkg_msg_config.get_company_admin(v_cooperation_company_id);

  scmdata.pkg_msg_config.config_plag_msg(p_msg_id      => scmdata.f_get_uuid(),
                                         p_urgent      => 0,
                                         p_msg_title   => '企业申请成功通知',
                                         p_msg_content => v_bemsg,
                                         p_target_user => v_betarget_user,
                                         p_sender_name => v_company_name,
                                         p_msg_type    => 'SYSTEM',
                                         p_object_id   => '');

END;



--原逻辑
/*declare
  p_i int;
begin
  select nvl(max(1), 0)
    into p_i
    from scmdata.t_ask_scope
   where object_id = :ask_record_id
     and object_type = 'HZ';
  if p_i = 0 then
    raise_application_error(-20002, '请至少填写一个合作意向范围');
  end if;
  if :ask_date is not null then
    raise_application_error(-20002, '已提交过的申请不需要重复提交');
  end if;
  /*
  if pkg_ask_record_mange.is_access_audit_pass(:company_id, :be_company_id) = 1 then
    raise_application_error(-20002,
                            '您已通过该企业的准入合作，不可重新发起申请！');
  end if;
  if pkg_ask_record_mange.is_cooperation_running(:company_id,
                                                 :be_company_id) = 1 then
    raise_application_error(-20002, '存在申请中的表单，请耐心等待');
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

v_action_sql2 := q'[--czh add 在原有基础上增加消息（通知申请公司，通知被申请公司）
declare
  p_i int;
  p_c varchar2(32);
  --czh add消息
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
    raise_application_error(-20002, '请至少填写一个合作意向范围');
  end if;
  select max(coor_ask_flow_status)
    into p_c
    from t_ask_record
   where ask_record_id = :ask_record_id;
  if p_c in ('CA01') then
    raise_application_error(-20002, '申请已提交，不需要重复提交');
  end if;
  if p_c in ('CA02') then
    raise_application_error(-20002, '申请不通过，请线下确定详细原因');
  end if;
  /*
  if pkg_ask_record_mange.is_access_audit_pass(:company_id,:be_company_id) = 1 then
    raise_application_error(-20002, '您已通过该企业的准入合作，不可重新发起申请！');
  end if;
  if pkg_ask_record_mange.is_cooperation_running(:company_id,:be_company_id) = 1 then
    raise_application_error(-20002, '存在申请中的表单，请耐心等待');
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
   
  --czh add 企业主动申请：企业申请成功通知：系统自动通知被申请企业（无需配置通知人员）

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

  --1)通知申请公司
  v_msg := '尊敬的[' || v_company_name || ']公司，恭喜您已成功申请为我司[' ||
             v_becompany_name || ']的供应商，期待合作！';

  v_target_user := scmdata.pkg_msg_config.get_company_admin(%default_company_id%);

  scmdata.pkg_msg_config.config_plag_msg(p_msg_id      => scmdata.f_get_uuid(),
                                         p_urgent      => 0,
                                         p_msg_title   => '企业申请成功通知',
                                         p_msg_content => v_msg,
                                         p_target_user => v_target_user,
                                         p_sender_name => v_becompany_name,
                                         p_msg_type    => 'SYSTEM',
                                         p_object_id   => '');

  --2)通知被申请公司  通知被申请公司：尊敬的Y公司，X公司已申请成为您的供应商，期待合作！
  v_bemsg := '尊敬的[' || v_becompany_name || ']公司，我司[' || v_company_name ||
           ']已申请成为您的供应商，期待合作！';

  v_betarget_user := scmdata.pkg_msg_config.get_company_admin(v_cooperation_company_id);

  scmdata.pkg_msg_config.config_plag_msg(p_msg_id      => scmdata.f_get_uuid(),
                                         p_urgent      => 0,
                                         p_msg_title   => '企业申请成功通知',
                                         p_msg_content => v_bemsg,
                                         p_target_user => v_betarget_user,
                                         p_sender_name => v_company_name,
                                         p_msg_type    => 'SYSTEM',
                                         p_object_id   => '');


end;

--原有逻辑
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
    raise_application_error(-20002, '请至少填写一个合作意向范围');
  end if;
  select max(coor_ask_flow_status)
    into p_c
    from t_ask_record
   where ask_record_id = :ask_record_id;
  if p_c in ('CA01') then
    raise_application_error(-20002, '申请已提交，不需要重复提交');
  end if;
  if p_c in ('CA02') then
    raise_application_error(-20002, '申请不通过，请线下确定详细原因');
  end if;
  /*
  if pkg_ask_record_mange.is_access_audit_pass(:company_id,:be_company_id) = 1 then
    raise_application_error(-20002, '您已通过该企业的准入合作，不可重新发起申请！');
  end if;
  if pkg_ask_record_mange.is_cooperation_running(:company_id,:be_company_id) = 1 then
    raise_application_error(-20002, '存在申请中的表单，请耐心等待');
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
