DECLARE
v_sql CLOB;
BEGIN
  v_sql := 'DECLARE
  p_status_af_oper  VARCHAR2(32);
  p_msg             VARCHAR2(256);
  p_ask_user        VARCHAR2(32);
  p_trialorder_type VARCHAR2(32);
  p_is_trialorder   VARCHAR2(32);
BEGIN
  p_is_trialorder   := @is_trialorder@;
  p_trialorder_type := @trialorder_type@;

  IF :factrory_ask_flow_status = ''FA12'' THEN
    p_status_af_oper := ''FA22'';
  ELSIF :factrory_ask_flow_status = ''FA31'' THEN
    p_status_af_oper := ''FA32'';
  ELSE
    raise_application_error(-20002, ''流程状态已改变！不能执行该操作！'');
  END IF;

  IF p_is_trialorder = 1 AND p_trialorder_type IS NULL THEN
    raise_application_error(-20002, ''试单时，试单模式必填！'');
  ELSIF :factory_ask_type IS NOT NULL AND :factory_ask_type <> 0 THEN
    UPDATE t_factory_report
       SET review_date   = SYSDATE,
           review_id     = :user_id,
           admit_result  = p_trialorder_type,
           is_trialorder = p_is_trialorder
     WHERE factory_ask_id = :factory_ask_id;
  END IF;

  pkg_supplier_info.create_t_supplier_info(p_company_id     => %default_company_id%,
                                           p_factory_ask_id => :factory_ask_id,
                                           p_user_id        => :user_id,
                                           p_is_trialorder  => p_is_trialorder,
                                           p_trialorder_type => p_trialorder_type);
  --流程操作记录
  pkg_ask_record_mange.p_log_fac_records_oper(p_company_id   => %default_company_id%,
                                              p_user_id      => :user_id,
                                              p_fac_ask_id   => :factory_ask_id,
                                              p_flow_status  => ''AGREE'',
                                              p_fac_ask_flow => p_status_af_oper,
                                              p_memo         => @audit_comment_sp@);
END;

/*--czh 重构代码
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
    raise_application_error(-20002, ''流程状态已改变！不能执行该操作！'');
  END IF;

  IF p_is_trialorder = 1 AND p_trialorder_type IS NULL THEN
    raise_application_error(-20002, ''试单时，试单模式必填！'');
  ELSIF :factory_ask_type IS NOT NULL AND :factory_ask_type <> 0 THEN
    UPDATE t_factory_report
       SET review_date   = SYSDATE,
           review_id     = :user_id,
           admit_result  = p_trialorder_type,
           is_trialorder = p_is_trialorder
     WHERE factory_ask_id = :factory_ask_id;
  END IF;

  pkg_supplier_info.create_t_supplier_info(p_company_id     => %default_company_id%,
                                           p_factory_ask_id => :factory_ask_id,
                                           p_user_id        => :user_id,
                                           p_is_trialorder  => p_is_trialorder,
                                           p_trialorder_type => p_trialorder_type);
  --流程操作记录
  pkg_ask_record_mange.p_log_fac_records_oper(p_company_id   => %default_company_id%,
                                              p_user_id      => :user_id,
                                              p_fac_ask_id   => :factory_ask_id,
                                              p_flow_status  => ''AGREE'',
                                              p_fac_ask_flow => p_status_af_oper,
                                              p_memo         => @audit_comment_sp@);

  --供应流程 触发企微机器人发送消息
  v_wx_sql := scmdata.pkg_supplier_info.send_fac_wx_msg(p_company_id     => %default_company_id%,
                                                        p_factory_ask_id => :factory_ask_id,
                                                        p_msgtype        => ''text'', --消息类型 text、markdown
                                                        p_msg_title      => ''验厂结果通知'', --消息标题
                                                        p_bot_key        => ''94bc653e-e4ed-4d58-bc7e-57b918645bd2'', --机器人key
                                                        p_robot_type     => ''SUP_MSG'' --机器人配置类型
                                                        );

  @strresult := v_wx_sql;

END;}*/';

UPDATE bw3.sys_action t SET t.action_type = 4,t.port_id = NULL,t.action_sql = v_sql WHERE t.element_id = 'action_a_coop_314'; 
END;
/
DECLARE
v_sql CLOB;
BEGIN
  v_sql := 'DECLARE
  p_status_af_oper VARCHAR2(32);
  p_msg            VARCHAR2(256);
  p_ask_user       VARCHAR2(32);
BEGIN
  IF :factrory_ask_flow_status = ''FA12'' THEN
    p_status_af_oper := ''FA21'';
  ELSIF :factrory_ask_flow_status = ''FA31'' THEN
    p_status_af_oper := ''FA33'';
  ELSE
    raise_application_error(-20002, ''流程状态已改变！不能执行该操作！'');
  END IF;

  --流程操作记录
  pkg_ask_record_mange.p_log_fac_records_oper(p_company_id   => %default_company_id%,
                                              p_user_id      => :user_id,
                                              p_fac_ask_id   => :factory_ask_id,
                                              p_flow_status  => ''DISAGREE'',
                                              p_fac_ask_flow => p_status_af_oper,
                                              p_memo         => @audit_comment@);


END;
/*--czh 重构代码
{DECLARE
  p_status_af_oper VARCHAR2(32);
  p_msg            VARCHAR2(256);
  p_ask_user       VARCHAR2(32);
  v_wx_sql         CLOB;

BEGIN
  IF :factrory_ask_flow_status = ''FA12'' THEN
    p_status_af_oper := ''FA21'';
  ELSIF :factrory_ask_flow_status = ''FA31'' THEN
    p_status_af_oper := ''FA33'';
  ELSE
    raise_application_error(-20002, ''流程状态已改变！不能执行该操作！'');
  END IF;

  --流程操作记录
  pkg_ask_record_mange.p_log_fac_records_oper(p_company_id   => %default_company_id%,
                                              p_user_id      => :user_id,
                                              p_fac_ask_id   => :factory_ask_id,
                                              p_flow_status  => ''DISAGREE'',
                                              p_fac_ask_flow => p_status_af_oper,
                                              p_memo         => @audit_comment@);

  --供应流程 触发企微机器人发送消息
  v_wx_sql := scmdata.pkg_supplier_info.send_fac_wx_msg(p_company_id     => %default_company_id%,
                                                        p_factory_ask_id => :factory_ask_id,
                                                        p_msgtype        => ''text'', --消息类型 text、markdown
                                                        p_msg_title      => ''验厂结果通知'', --消息标题
                                                        p_bot_key        => ''94bc653e-e4ed-4d58-bc7e-57b918645bd2'', --机器人key
                                                        p_robot_type     => ''SUP_MSG'' --机器人配置类型
                                                         );

  @strresult := v_wx_sql;
END;
}*/';

UPDATE bw3.sys_action t SET t.action_type = 4,t.port_id = NULL,t.action_sql = v_sql WHERE t.element_id = 'action_a_coop_315'; 
END;
/
