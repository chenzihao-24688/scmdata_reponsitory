declare
v_sql clob;
begin
v_sql := 'DECLARE
  p_factory_ask_type         VARCHAR2(32);
  p_factrory_ask_flow_status VARCHAR2(32);
  p_company_id               VARCHAR2(32);
  p_i                        INT;
  vo_target_company          VARCHAR2(100);
  vo_target_user             VARCHAR2(4000);
  vo_msg                     CLOB;
  p_memo                     VARCHAR2(600);
BEGIN

  SELECT COUNT(*)
    INTO p_i
    FROM scmdata.t_ask_scope a
   WHERE a.object_id = :factory_ask_id
     AND a.object_type = ''CA''
     AND a.be_company_id = %default_company_id%;
  IF p_i = 0 THEN
    raise_application_error(-20002, ''��������дһ��������Χ'');
  END IF;
  p_factory_ask_type := @factory_ask_type@;
  p_memo             := @remarks@;
  IF p_factory_ask_type = 0 THEN
    p_company_id               := NULL;
    p_factrory_ask_flow_status := ''FA12'';
    IF p_memo IS NULL THEN
      raise_application_error(-20002, ''���鳧ʱ��ע�ֶ�Ϊ����'');
    END IF;
  ELSE
    p_company_id               := %default_company_id%;
    p_factrory_ask_flow_status := ''FA11'';
  END IF;
  UPDATE scmdata.t_factory_ask
     SET ask_company_id   = p_company_id,
         factory_ask_type = p_factory_ask_type,
         remarks          = p_memo,
         update_id        = :user_id,
         update_date      = SYSDATE
   WHERE factory_ask_id = :factory_ask_id;

  --���̲�����¼
  pkg_ask_record_mange.p_log_fac_records_oper(p_company_id   => %default_company_id%,
                                              p_user_id      => :user_id,
                                              p_fac_ask_id   => :factory_ask_id,
                                              p_flow_status  => ''AGREE'',
                                              p_fac_ask_flow => p_factrory_ask_flow_status,
                                              p_memo         => p_memo);

  IF p_factory_ask_type = 0 THEN
    --2. czh add ׼���������֪ͨ��ͨ��/��ͨ������ϵͳ�Զ�֪ͨ�鳧�����ˣ���������֪ͨ��Ա��  ����X����׼�������账���뼰ʱ����лл��
    scmdata.pkg_msg_config.config_t_factory_ask_msg(p_company_id        => %default_company_id%,
                                                    p_factory_ask_id    => :factory_ask_id,
                                                    p_flow_node_name_af => ''׼������'',
                                                    p_oper_code_desc    => ''ͬ��'',
                                                    p_oper_code         => ''AGREE'',
                                                    p_status_af         => ''FA12'',
                                                    p_type              => ''FAC_AGREE_S'',
                                                    po_target_company   => vo_target_company,
                                                    po_target_user      => vo_target_user,
                                                    po_msg              => vo_msg);

    scmdata.pkg_msg_config.send_msg(p_company_id  => vo_target_company,
                                    p_user_id     => vo_target_user,
                                    p_node_id     => ''node_a_coop_310'',
                                    p_msg_title   => ''׼���������֪ͨ'',
                                    p_msg_content => vo_msg,
                                    p_type        => ''FAC_AGREE_S'');
  END IF;

END;';
update bw3.sys_action t set t.action_sql = v_sql where t.element_id = 'action_a_coop_220_1';
end;
