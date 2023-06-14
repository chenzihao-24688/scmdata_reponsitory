insert into scmdata.sys_group_wecom_msg_pattern (SYS_GROUP_WECOM_MSG_PATTERN_ID, PAUSE, APPLY_ID, SYS_GROUP_WECOM_MSG_PATTERN_CODE, SYS_GROUP_WECOM_MSG_PATTERN_NAME, MSG_PATTERN, PARAM_NAME_LIST, DESCRIPTORS, QUANTIFIER, COMPLEX_LIMIT, HINT_SQL)
values ('f4b44c1213e012f0e0533c281cac6a83', 0, 'apply_3', 'TF_SUBMIT_00', '��Ӧ�����ɵ���', 'SCMϵͳ��Ϣ�����!{{SUP_NAME}}�ѽ�������֪��', 'SUP_NAME', '��Ӧ��', '��', null, null);

insert into scmdata.sys_group_wecom_msg_pattern (SYS_GROUP_WECOM_MSG_PATTERN_ID, PAUSE, APPLY_ID, SYS_GROUP_WECOM_MSG_PATTERN_CODE, SYS_GROUP_WECOM_MSG_PATTERN_NAME, MSG_PATTERN, PARAM_NAME_LIST, DESCRIPTORS, QUANTIFIER, COMPLEX_LIMIT, HINT_SQL)
values ('f4b4719fee0f3639e0533c281cac87df', 0, 'apply_1', 'FA_AGREE_01', '����_ͬ��׼��', 'SCMϵͳ��Ϣ�����ã�{{SUP_NAME}}������������ǰ������Ʒ��Ӧ�̡���������Ӧ��ҳ�潨����', 'SUP_NAME', '��Ӧ��', '��', null, null);


declare
 v_sql clob := '--czh �ع�����
DECLARE
  p_status_af_oper  VARCHAR2(32);
  p_msg             VARCHAR2(256);
  p_ask_user        VARCHAR2(32);
  p_is_trialorder   VARCHAR2(32) := @is_trialorder@;
  p_trialorder_type VARCHAR2(32) := @trialorder_type@;
  v_company_name    VARCHAR2(256);
  v_factrory_ask_flow_status VARCHAR2(32);
  v_factory_ask_type VARCHAR2(32);
BEGIN
  SELECT MAX(t.factrory_ask_flow_status), MAX(t.factory_ask_type)
    INTO v_factrory_ask_flow_status, v_factory_ask_type
    FROM scmdata.t_factory_ask t
   WHERE t.factory_ask_id = :factory_ask_id
     AND t.company_id = %default_company_id%;

  IF v_factrory_ask_flow_status = ''FA12'' THEN
    p_status_af_oper := ''FA22'';
  ELSIF v_factrory_ask_flow_status = ''FA31'' THEN
    p_status_af_oper := ''FA32'';
  ELSE
    raise_application_error(-20002, ''����״̬�Ѹı䣡����ִ�иò�����'');
  END IF;

  IF p_is_trialorder = 1 AND p_trialorder_type IS NULL THEN
    raise_application_error(-20002, ''�Ե�ʱ���Ե�ģʽ���'');
  ELSIF p_is_trialorder = 0 AND p_trialorder_type IS NOT NULL THEN
    raise_application_error(-20002, ''�Ե�ģʽ������д��'');
  ELSIF v_factory_ask_type IS NOT NULL AND v_factory_ask_type <> 0 THEN
    UPDATE t_factory_report
       SET review_date   = SYSDATE,
           review_id     = :user_id,
           admit_result  = p_trialorder_type,
           is_trialorder = p_is_trialorder
     WHERE factory_ask_id = :factory_ask_id;
  END IF;

  --���ɵ���
  pkg_supplier_info.p_create_t_supplier_info(p_company_id      => %default_company_id%,
                                             p_factory_ask_id  => :factory_ask_id,
                                             p_user_id         => :user_id,
                                             p_is_trialorder   => p_is_trialorder,
                                             p_trialorder_type => p_trialorder_type);

  --���µ���״̬ͬʱ��¼���̲�����־
  scmdata.pkg_ask_record_mange.p_update_flow_status_and_logger(p_company_id       => %default_company_id%,
                                                               p_user_id          => :user_id,
                                                               p_fac_ask_id       => :factory_ask_id, --�鳧���뵥ID
                                                               p_ask_record_id    => NULL, --�������뵥ID
                                                               p_flow_oper_status => ''AGREE'', --���̲�����ʽ����
                                                               p_flow_af_status   => p_status_af_oper, --����������״̬
                                                               p_memo             => @audit_comment_sp@);

  --lsl add 20230116
  --������΢��Ϣ����
  SELECT company_name
    INTO v_company_name
    FROM scmdata.t_factory_ask
   WHERE factory_ask_id = :factory_ask_id;
  IF :factrory_ask_flow_status = ''FA12'' THEN
    scmdata.pkg_send_wx_msg.p_platform_person_wx_msg_push(v_company_id   => %default_company_id%,
                                                          v_supplier     => v_company_name,
                                                          v_pattern_code => ''FA_AGREE_00'',
                                                          v_user_id      => '''',
                                                          v_type         => 0);
  ELSIF :factrory_ask_flow_status = ''FA31'' THEN
    scmdata.pkg_send_wx_msg.p_platform_person_wx_msg_push(v_company_id   => %default_company_id%,
                                                          v_supplier     => v_company_name,
                                                          v_pattern_code => ''FA_AGREE_01'',
                                                          v_user_id      => '''',
                                                          v_type         => 0);
  END IF;
  --lsl end
END;';
begin
  update bw3.sys_action t
     set t.action_sql = v_sql
   where t.element_id = 'action_a_coop_310_1';
end;
/
