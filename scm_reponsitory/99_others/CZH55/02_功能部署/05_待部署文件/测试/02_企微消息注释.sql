???prompt Importing table bw3.sys_action...
set feedback off
set define off
insert into bw3.sys_action (ELEMENT_ID, CAPTION, ICON_NAME, ACTION_TYPE, ACTION_SQL, SELECT_FIELDS, REFRESH_FLAG, MULTI_PAGE_FLAG, PRE_FLAG, FILTER_EXPRESS, UPDATE_FIELDS, PORT_ID, PORT_SQL, LOCK_SQL, SELECTION_FLAG, CALL_ID, OPERATE_MODE, PORT_TYPE, QUERY_FIELDS, SELECTION_METHOD)
values ('action_a_coop_311', '同意准入', null, 4, '--czh 重构代码
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
    raise_application_error(-20002, ''流程状态已改变！不能执行该操作！'');
  END IF;

  IF p_is_trialorder = 1 AND p_trialorder_type IS  NULL THEN
    raise_application_error(-20002, ''试单时，试单模式必填！'');
  ELSIF p_is_trialorder = 0 AND p_trialorder_type IS NOT NULL THEN
    raise_application_error(-20002, ''不试单时，试单模式无需填写！'');
  ELSIF :factory_ask_type IS NOT NULL AND :factory_ask_type <> 0 THEN
    UPDATE t_factory_report
       SET review_date   = SYSDATE,
           review_id     = :user_id,
           admit_result  = p_trialorder_type,
           is_trialorder = p_is_trialorder
     WHERE factory_ask_id = :factory_ask_id;
  END IF;
  --生成档案
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

 /* --供应流程 触发企微机器人发送消息
  v_wx_sql := scmdata.pkg_supplier_info.send_fac_wx_msg(p_company_id     => %default_company_id%,
                                                        p_factory_ask_id => :factory_ask_id,
                                                        p_msgtype        => ''text'', --消息类型 text、markdown
                                                        p_msg_title      => ''验厂结果通知'', --消息标题
                                                        p_bot_key        => ''94bc653e-e4ed-4d58-bc7e-57b918645bd2'', --机器人key
                                                        p_robot_type     => ''SUP_MSG'' --机器人配置类型
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
    raise_application_error(-20002, ''流程状态已改变！不能执行该操作！'');
  END IF;

  IF p_is_trialorder = 1 AND p_trialorder_type IS  NULL THEN
    raise_application_error(-20002, ''试单时，试单模式必填！'');
  ELSIF p_is_trialorder = 0 AND p_trialorder_type IS NOT NULL THEN
    raise_application_error(-20002, ''不试单时，试单模式无需填写！'');
  ELSIF :factory_ask_type IS NOT NULL AND :factory_ask_type <> 0 THEN
    UPDATE t_factory_report
       SET review_date   = SYSDATE,
           review_id     = :user_id,
           admit_result  = p_trialorder_type,
           is_trialorder = p_is_trialorder
     WHERE factory_ask_id = :factory_ask_id;
  END IF;
  --生成档案
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

END;}*/', null, 1, 1, 0, null, null, null, 'select 1 from dual', null, 0, null, 0, 1, null, 1);

insert into bw3.sys_action (ELEMENT_ID, CAPTION, ICON_NAME, ACTION_TYPE, ACTION_SQL, SELECT_FIELDS, REFRESH_FLAG, MULTI_PAGE_FLAG, PRE_FLAG, FILTER_EXPRESS, UPDATE_FIELDS, PORT_ID, PORT_SQL, LOCK_SQL, SELECTION_FLAG, CALL_ID, OPERATE_MODE, PORT_TYPE, QUERY_FIELDS, SELECTION_METHOD)
values ('action_a_supp_151_1', '提交', null, 4, 'DECLARE
  v_wx_sql     CLOB;
  v_origin     VARCHAR2(32);
  v_origin_id  VARCHAR2(32);
  v_submit_btn VARCHAR2(256) := :supplier_company_name;
  v_supcode    VARCHAR2(32);
  v_robot_key  VARCHAR2(400);
BEGIN
  --因速狮原因，点击生成档案时，会自动触发两次提交按钮。
  --故获取必填项做校验，当v_submit_btn不为空时，则执行提交按钮。
  IF v_submit_btn IS NOT NULL THEN
    pkg_supplier_info.submit_t_supplier_info(p_supplier_info_id   => :supplier_info_id,
                                             p_default_company_id => %default_company_id%,
                                             p_user_id            => %user_id%);
  
    --启用qc工厂内容
    scmdata.pkg_qcfactory_config.p_enable_qc_factory_config_by_pro(p_supplier_info => :supplier_info_id,
                                                                   p_company_id    => %default_company_id%);
  
  END IF;
  /*  --建档通知
    SELECT t.supplier_info_origin, t.supplier_info_origin_id
      INTO v_origin, v_origin_id
      FROM scmdata.t_supplier_info t
     WHERE t.company_id = %default_company_id%
       AND t.supplier_info_id = :supplier_info_id;
  
   IF v_origin = ''AA'' THEN
      --触发企微机器人发送消息
      SELECT MAX(a.robot_key)
        INTO v_robot_key
      FROM scmdata.sys_company_wecom_config a
       WHERE a.company_id = %default_company_id%
        AND a.robot_type = ''SUP_MSG'';
      v_wx_sql := scmdata.pkg_supplier_info.send_fac_wx_msg(p_company_id     => %default_company_id%,
                                                            p_factory_ask_id => v_origin_id,
                                                            p_msgtype        => ''text'', --消息类型 text、markdown
                                                            p_msg_title      => ''建档通知通知'', --消息标题
                                                            p_bot_key        => v_robot_key, --机器人key
                                                            p_robot_type     => ''SUP_MSG'' --机器人配置类型
                                                            );
    ELSE
      v_wx_sql := ''select ''''text'''' MSGTYPE,''''新增供应商-建档通知''''  CONTENT,''''999bc2eb-55b8-400d-a70e-5ea148e59396'''' key from dual'';
    END IF;
  ELSE
    v_wx_sql := ''select ''''text'''' MSGTYPE,''''新增供应商-建档通知''''  CONTENT,''''999bc2eb-55b8-400d-a70e-5ea148e59396'''' key from dual'';
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
  --因速狮原因，点击生成档案时，会自动触发两次提交按钮。
  --故获取必填项做校验，当v_submit_btn不为空时，则执行提交按钮。
  IF v_submit_btn IS NOT NULL THEN
    pkg_supplier_info.submit_t_supplier_info(p_supplier_info_id   => :supplier_info_id,
                                             p_default_company_id => %default_company_id%,
                                             p_user_id            => %user_id%);

    --启用qc工厂内容
    scmdata.pkg_qcfactory_config.p_enable_qc_factory_config_by_pro(p_supplier_info => :supplier_info_id,
                                                                   p_company_id    => %default_company_id%);


    --建档通知
    SELECT t.supplier_info_origin, t.supplier_info_origin_id
      INTO v_origin, v_origin_id
      FROM scmdata.t_supplier_info t
     WHERE t.company_id = %default_company_id%
       AND t.supplier_info_id = :supplier_info_id;

    IF v_origin = ''AA'' THEN
      --触发企微机器人发送消息
      SELECT MAX(a.robot_key)
        INTO v_robot_key
      FROM scmdata.sys_company_wecom_config a
       WHERE a.company_id = %default_company_id%
        AND a.robot_type = ''SUP_MSG'';
      v_wx_sql := scmdata.pkg_supplier_info.send_fac_wx_msg(p_company_id     => %default_company_id%,
                                                            p_factory_ask_id => v_origin_id,
                                                            p_msgtype        => ''text'', --消息类型 text、markdown
                                                            p_msg_title      => ''建档通知通知'', --消息标题
                                                            p_bot_key        => v_robot_key, --机器人key
                                                            p_robot_type     => ''SUP_MSG'' --机器人配置类型
                                                            );
    ELSE
      v_wx_sql := ''select ''''text'''' MSGTYPE,''''新增供应商-建档通知''''  CONTENT,''''999bc2eb-55b8-400d-a70e-5ea148e59396'''' key from dual'';
    END IF;
  ELSE
    v_wx_sql := ''select ''''text'''' MSGTYPE,''''新增供应商-建档通知''''  CONTENT,''''999bc2eb-55b8-400d-a70e-5ea148e59396'''' key from dual'';
  END IF;

  @strresult := v_wx_sql;

END;
}*/', null, 3, 1, null, null, null, null, 'select 1 from dual', null, 0, null, null, 1, null, 1);

prompt Done.
