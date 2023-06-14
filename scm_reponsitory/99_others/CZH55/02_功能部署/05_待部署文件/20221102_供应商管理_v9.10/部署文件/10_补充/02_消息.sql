insert into scmdata.sys_group_wecom_msg_pattern (SYS_GROUP_WECOM_MSG_PATTERN_ID, PAUSE, APPLY_ID, SYS_GROUP_WECOM_MSG_PATTERN_CODE, SYS_GROUP_WECOM_MSG_PATTERN_NAME, MSG_PATTERN, PARAM_NAME_LIST, DESCRIPTORS, QUANTIFIER, COMPLEX_LIMIT, HINT_SQL)
values ('f4b44c1213e012f0e0533c281cac6a83', 0, 'apply_3', 'TF_SUBMIT_00', '供应商生成档案', 'SCM系统消息：你好!{{SUP_NAME}}已建档，请知。', 'SUP_NAME', '供应商', '家', null, null);

insert into scmdata.sys_group_wecom_msg_pattern (SYS_GROUP_WECOM_MSG_PATTERN_ID, PAUSE, APPLY_ID, SYS_GROUP_WECOM_MSG_PATTERN_CODE, SYS_GROUP_WECOM_MSG_PATTERN_NAME, MSG_PATTERN, PARAM_NAME_LIST, DESCRIPTORS, QUANTIFIER, COMPLEX_LIMIT, HINT_SQL)
values ('f4b4719fee0f3639e0533c281cac87df', 0, 'apply_1', 'FA_AGREE_01', '特批_同意准入', 'SCM系统消息：您好！{{SUP_NAME}}待建档，请您前往【成品供应商】待建档供应商页面建档。', 'SUP_NAME', '供应商', '家', null, null);


declare
 v_sql clob := '--czh 重构代码
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
    raise_application_error(-20002, ''流程状态已改变！不能执行该操作！'');
  END IF;

  IF p_is_trialorder = 1 AND p_trialorder_type IS NULL THEN
    raise_application_error(-20002, ''试单时，试单模式必填！'');
  ELSIF p_is_trialorder = 0 AND p_trialorder_type IS NOT NULL THEN
    raise_application_error(-20002, ''试单模式无需填写！'');
  ELSIF v_factory_ask_type IS NOT NULL AND v_factory_ask_type <> 0 THEN
    UPDATE t_factory_report
       SET review_date   = SYSDATE,
           review_id     = :user_id,
           admit_result  = p_trialorder_type,
           is_trialorder = p_is_trialorder
     WHERE factory_ask_id = :factory_ask_id;
  END IF;

  --生成档案
  pkg_supplier_info.p_create_t_supplier_info(p_company_id      => %default_company_id%,
                                             p_factory_ask_id  => :factory_ask_id,
                                             p_user_id         => :user_id,
                                             p_is_trialorder   => p_is_trialorder,
                                             p_trialorder_type => p_trialorder_type);

  --更新单据状态同时记录流程操作日志
  scmdata.pkg_ask_record_mange.p_update_flow_status_and_logger(p_company_id       => %default_company_id%,
                                                               p_user_id          => :user_id,
                                                               p_fac_ask_id       => :factory_ask_id, --验厂申请单ID
                                                               p_ask_record_id    => NULL, --合作申请单ID
                                                               p_flow_oper_status => ''AGREE'', --流程操作方式编码
                                                               p_flow_af_status   => p_status_af_oper, --操作后流程状态
                                                               p_memo             => @audit_comment_sp@);

  --lsl add 20230116
  --个人企微消息推送
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
