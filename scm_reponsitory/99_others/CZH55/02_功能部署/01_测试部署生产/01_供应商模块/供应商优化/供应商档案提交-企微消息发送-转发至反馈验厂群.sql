DECLARE
v_sql CLOB;
BEGIN
  v_sql := '{DECLARE
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

    --zc314 add
    SCMDATA.PKG_CAPACITY_INQUEUE.P_COMMON_INQUEUE(V_CURUSERID  => %CURRENT_USERID%,
                                                  V_COMPID     => %DEFAULT_COMPANY_ID%,
                                                  V_TAB        => ''SCMDATA.T_SUPPLIER_INFO'',
                                                  V_VIEWTAB    => NULL,
                                                  V_UNQFIELDS  => ''SUPPLIER_INFO_ID,COMPANY_ID'',
                                                  V_CKFIELDS   => ''STATUS,UPDATE_ID,UPDATE_DATE'',
                                                  V_CONDS      => ''SUPPLIER_INFO_ID = ''''''||:SUPPLIER_INFO_ID||'''''' AND COMPANY_ID = ''''''||%DEFAULT_COMPANY_ID%||'''''''',
                                                  V_METHOD     => ''UPD'',
                                                  V_VIEWLOGIC  => NULL,
                                                  V_QUEUETYPE  => ''CAPC_SUPCAPCAPP_INFO_U'');

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
}';
  UPDATE BW3.sys_action t SET t.action_sql = v_sql WHERE t.element_id = 'action_a_supp_151_1';
END;
