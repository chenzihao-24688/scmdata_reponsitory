DECLARE
v_sql CLOB;
BEGIN
  v_sql := '--czh �ع�����
DECLARE
  p_status_af_oper  VARCHAR2(32);
  p_msg             VARCHAR2(256);
  p_ask_user        VARCHAR2(32);
  p_trialorder_type VARCHAR2(32);
  p_is_trialorder   VARCHAR2(32);
  v_wx_sql          CLOB;
BEGIN
  p_is_trialorder   := @is_trialorder@;
  p_trialorder_type := @trialorder_type@;

  IF :factrory_ask_flow_status = ''FA12'' THEN
    p_status_af_oper := ''FA22'';
  ELSIF :factrory_ask_flow_status = ''FA31'' THEN
    p_status_af_oper := ''FA32'';
  ELSE
    raise_application_error(-20002, ''����״̬�Ѹı䣡����ִ�иò�����'');
  END IF;

  IF p_is_trialorder = 1 AND p_trialorder_type IS  NULL THEN
    raise_application_error(-20002, ''�Ե�ʱ���Ե�ģʽ���'');
  ELSIF p_is_trialorder = 0 AND p_trialorder_type IS NOT NULL THEN
    raise_application_error(-20002, ''���Ե�ʱ���Ե�ģʽ������д��'');
  ELSIF :factory_ask_type IS NOT NULL AND :factory_ask_type <> 0 THEN
    UPDATE t_factory_report
       SET review_date   = SYSDATE,
           review_id     = :user_id,
           admit_result  = p_trialorder_type,
           is_trialorder = p_is_trialorder
     WHERE factory_ask_id = :factory_ask_id;
  END IF;
  --���ɵ���
  pkg_supplier_info.create_t_supplier_info(p_company_id     => %default_company_id%,
                                           p_factory_ask_id => :factory_ask_id,
                                           p_user_id        => :user_id,
                                           p_is_trialorder  => p_is_trialorder,
                                           p_trialorder_type => p_trialorder_type);
  --���̲�����¼
  pkg_ask_record_mange.p_log_fac_records_oper(p_company_id   => %default_company_id%,
                                              p_user_id      => :user_id,
                                              p_fac_ask_id   => :factory_ask_id,
                                              p_flow_status  => ''AGREE'',
                                              p_fac_ask_flow => p_status_af_oper,
                                              p_memo         => @audit_comment_sp@);

 /* --��Ӧ���� ������΢�����˷�����Ϣ
  v_wx_sql := scmdata.pkg_supplier_info.send_fac_wx_msg(p_company_id     => %default_company_id%,
                                                        p_factory_ask_id => :factory_ask_id,
                                                        p_msgtype        => ''text'', --��Ϣ���� text��markdown
                                                        p_msg_title      => ''�鳧���֪ͨ'', --��Ϣ����
                                                        p_bot_key        => ''94bc653e-e4ed-4d58-bc7e-57b918645bd2'', --������key
                                                        p_robot_type     => ''SUP_MSG'' --��������������
                                                        );

  @strresult := v_wx_sql;*/

END;

/*
{DECLARE
  p_status_af_oper  VARCHAR2(32);
  p_msg             VARCHAR2(256);
  p_ask_user        VARCHAR2(32);
  p_trialorder_type VARCHAR2(32);
  p_is_trialorder   VARCHAR2(32);
  v_wx_sql          CLOB;
BEGIN
  p_is_trialorder   := @is_trialorder@;
  p_trialorder_type := @trialorder_type@;

  IF :factrory_ask_flow_status = ''FA12'' THEN
    p_status_af_oper := ''FA22'';
  ELSIF :factrory_ask_flow_status = ''FA31'' THEN
    p_status_af_oper := ''FA32'';
  ELSE
    raise_application_error(-20002, ''����״̬�Ѹı䣡����ִ�иò�����'');
  END IF;

  IF p_is_trialorder = 1 AND p_trialorder_type IS  NULL THEN
    raise_application_error(-20002, ''�Ե�ʱ���Ե�ģʽ���'');
  ELSIF p_is_trialorder = 0 AND p_trialorder_type IS NOT NULL THEN
    raise_application_error(-20002, ''���Ե�ʱ���Ե�ģʽ������д��'');
  ELSIF :factory_ask_type IS NOT NULL AND :factory_ask_type <> 0 THEN
    UPDATE t_factory_report
       SET review_date   = SYSDATE,
           review_id     = :user_id,
           admit_result  = p_trialorder_type,
           is_trialorder = p_is_trialorder
     WHERE factory_ask_id = :factory_ask_id;
  END IF;
  --���ɵ���
  pkg_supplier_info.create_t_supplier_info(p_company_id     => %default_company_id%,
                                           p_factory_ask_id => :factory_ask_id,
                                           p_user_id        => :user_id,
                                           p_is_trialorder  => p_is_trialorder,
                                           p_trialorder_type => p_trialorder_type);
  --���̲�����¼
  pkg_ask_record_mange.p_log_fac_records_oper(p_company_id   => %default_company_id%,
                                              p_user_id      => :user_id,
                                              p_fac_ask_id   => :factory_ask_id,
                                              p_flow_status  => ''AGREE'',
                                              p_fac_ask_flow => p_status_af_oper,
                                              p_memo         => @audit_comment_sp@);

  --��Ӧ���� ������΢�����˷�����Ϣ
  v_wx_sql := scmdata.pkg_supplier_info.send_fac_wx_msg(p_company_id     => %default_company_id%,
                                                        p_factory_ask_id => :factory_ask_id,
                                                        p_msgtype        => ''text'', --��Ϣ���� text��markdown
                                                        p_msg_title      => ''�鳧���֪ͨ'', --��Ϣ����
                                                        p_bot_key        => ''94bc653e-e4ed-4d58-bc7e-57b918645bd2'', --������key
                                                        p_robot_type     => ''SUP_MSG'' --��������������
                                                        );

  @strresult := v_wx_sql;

END;}*/';

UPDATE bw3.sys_action t SET t.action_type = 4,t.port_id = NULL,t.action_sql = v_sql WHERE t.element_id = 'action_a_coop_311'; 

END;
/
DECLARE
v_sql CLOB;
BEGIN
  v_sql := 'DECLARE
  v_wx_sql     CLOB;
  v_origin     VARCHAR2(32);
  v_origin_id  VARCHAR2(32);
  --v_submit_btn VARCHAR2(256) := :supplier_company_name;
  v_supcode    VARCHAR2(32);
  v_robot_key  VARCHAR2(400);
BEGIN
  --����ʨԭ�򣬵�����ɵ���ʱ�����Զ����������ύ��ť��
  --�ʻ�ȡ��������У�飬��v_submit_btn��Ϊ��ʱ����ִ���ύ��ť��
  --IF v_submit_btn IS NOT NULL THEN
    pkg_supplier_info.submit_t_supplier_info(p_supplier_info_id   => :supplier_info_id,
                                             p_default_company_id => %default_company_id%,
                                             p_user_id            => %user_id%);
  
    --����qc��������
    scmdata.pkg_qcfactory_config.p_enable_qc_factory_config_by_pro(p_supplier_info => :supplier_info_id,
                                                                   p_company_id    => %default_company_id%);
  
  --END IF;
  /*  --����֪ͨ
    SELECT t.supplier_info_origin, t.supplier_info_origin_id
      INTO v_origin, v_origin_id
      FROM scmdata.t_supplier_info t
     WHERE t.company_id = %default_company_id%
       AND t.supplier_info_id = :supplier_info_id;
  
   IF v_origin = ''AA'' THEN
      --������΢�����˷�����Ϣ
      SELECT MAX(a.robot_key)
        INTO v_robot_key
      FROM scmdata.sys_company_wecom_config a
       WHERE a.company_id = %default_company_id%
        AND a.robot_type = ''SUP_MSG'';
      v_wx_sql := scmdata.pkg_supplier_info.send_fac_wx_msg(p_company_id     => %default_company_id%,
                                                            p_factory_ask_id => v_origin_id,
                                                            p_msgtype        => ''text'', --��Ϣ���� text��markdown
                                                            p_msg_title      => ''����֪֪ͨͨ'', --��Ϣ����
                                                            p_bot_key        => v_robot_key, --������key
                                                            p_robot_type     => ''SUP_MSG'' --��������������
                                                            );
    ELSE
      v_wx_sql := ''select ''''text'''' MSGTYPE,''''������Ӧ��-����֪ͨ''''  CONTENT,''''999bc2eb-55b8-400d-a70e-5ea148e59396'''' key from dual'';
    END IF;
  ELSE
    v_wx_sql := ''select ''''text'''' MSGTYPE,''''������Ӧ��-����֪ͨ''''  CONTENT,''''999bc2eb-55b8-400d-a70e-5ea148e59396'''' key from dual'';
  END IF;
  
  @strresult := v_wx_sql;*/
END;

/*
{DECLARE
  v_wx_sql     CLOB;
  v_origin     VARCHAR2(32);
  v_origin_id  VARCHAR2(32);
  v_submit_btn VARCHAR2(256) := :supplier_company_name;
  V_SUPCODE    VARCHAR2(32);
  v_robot_key  VARCHAR2(400);
BEGIN
  --����ʨԭ�򣬵�����ɵ���ʱ�����Զ����������ύ��ť��
  --�ʻ�ȡ��������У�飬��v_submit_btn��Ϊ��ʱ����ִ���ύ��ť��
  IF v_submit_btn IS NOT NULL THEN
    pkg_supplier_info.submit_t_supplier_info(p_supplier_info_id   => :supplier_info_id,
                                             p_default_company_id => %default_company_id%,
                                             p_user_id            => %user_id%);

    --����qc��������
    scmdata.pkg_qcfactory_config.p_enable_qc_factory_config_by_pro(p_supplier_info => :supplier_info_id,
                                                                   p_company_id    => %default_company_id%);


    --����֪ͨ
    SELECT t.supplier_info_origin, t.supplier_info_origin_id
      INTO v_origin, v_origin_id
      FROM scmdata.t_supplier_info t
     WHERE t.company_id = %default_company_id%
       AND t.supplier_info_id = :supplier_info_id;

    IF v_origin = ''AA'' THEN
      --������΢�����˷�����Ϣ
      SELECT MAX(a.robot_key)
        INTO v_robot_key
      FROM scmdata.sys_company_wecom_config a
       WHERE a.company_id = %default_company_id%
        AND a.robot_type = ''SUP_MSG'';
      v_wx_sql := scmdata.pkg_supplier_info.send_fac_wx_msg(p_company_id     => %default_company_id%,
                                                            p_factory_ask_id => v_origin_id,
                                                            p_msgtype        => ''text'', --��Ϣ���� text��markdown
                                                            p_msg_title      => ''����֪֪ͨͨ'', --��Ϣ����
                                                            p_bot_key        => v_robot_key, --������key
                                                            p_robot_type     => ''SUP_MSG'' --��������������
                                                            );
    ELSE
      v_wx_sql := ''select ''''text'''' MSGTYPE,''''������Ӧ��-����֪ͨ''''  CONTENT,''''999bc2eb-55b8-400d-a70e-5ea148e59396'''' key from dual'';
    END IF;
  ELSE
    v_wx_sql := ''select ''''text'''' MSGTYPE,''''������Ӧ��-����֪ͨ''''  CONTENT,''''999bc2eb-55b8-400d-a70e-5ea148e59396'''' key from dual'';
  END IF;

  @strresult := v_wx_sql;

END;
}*/';

UPDATE bw3.sys_action t SET t.action_type = 4,t.port_id = NULL,t.action_sql = v_sql WHERE t.element_id = 'action_a_supp_151_1'; 

END;
/
