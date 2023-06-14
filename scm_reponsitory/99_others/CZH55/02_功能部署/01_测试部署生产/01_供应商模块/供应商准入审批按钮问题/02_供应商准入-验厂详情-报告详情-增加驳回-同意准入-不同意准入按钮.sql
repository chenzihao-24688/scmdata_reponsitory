begin
insert into bw3.sys_item_element_rela (ITEM_ID, ELEMENT_ID, SEQ_NO, PAUSE, LEVEL_NO)
values ('a_check_102_1', 'action_a_coop_314', 1, 0, null);

insert into bw3.sys_item_element_rela (ITEM_ID, ELEMENT_ID, SEQ_NO, PAUSE, LEVEL_NO)
values ('a_check_102_1', 'action_a_coop_315', 2, 0, null);

insert into bw3.sys_item_element_rela (ITEM_ID, ELEMENT_ID, SEQ_NO, PAUSE, LEVEL_NO)
values ('a_check_102_1', 'action_a_coop_316', 3, 0, null);
end;
/
begin
 UPDATE bw3.sys_item_list t SET
 t.noshow_fields =
       'FACTORY_REPORT_ID,FACTORY_ASK_ID,COOPERATION_METHOD,COOPERATION_MODEL,PRODUCTION_MODE,COOPERATION_CLASSIFICATION,COOPERATION_SUBCATEGORY,CHECK_METHOD,COOPERATION_TYPE,rela_supplier_id,company_type,cooperation_brand,product_link,product_type,is_urgent,PRODUCT_LINE,QUALITY_STEP,PATTERN_CAP,FABRIC_PURCHASE_CAP,FABRIC_CHECK_CAP,COST_STEP,CHECK_FAC_RESULT,check_person1,check_person2,factory_ask_type'
 WHERE t.item_id = 'a_check_102_1';

 UPDATE bw3.sys_item_list t SET
 t.noshow_fields =
       'FACTRORY_ASK_FLOW_STATUS,COMPANY_ID,COOPERATION_TYPE,COOPERATION_CLASSIFICATION,COOPERATION_SUBCATEGORY,COOPERATION_METHOD,COOPERATION_MODEL,PRODUCTION_MODE,ASK_USER_DEPT_ID,COOPERATION_COMPANY_ID,COMPANY_PROVINCE,COMPANY_CITY,COMPANY_COUNTY,FACTORY_PROVINCE,FACTORY_CITY,FACTORY_COUNTY,FACTORY_ASK_ID,rela_supplier_id,company_type,cooperation_brand,product_link,product_type,is_urgent,factory_ask_type'
 WHERE t.item_id = 'a_coop_311';
end;
/
DECLARE
v_sql clob;
BEGIN
  v_sql := q'[--czh 重构代码
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

  IF :factrory_ask_flow_status = 'FA12' THEN
    p_status_af_oper := 'FA22';
  ELSIF :factrory_ask_flow_status = 'FA31' THEN
    p_status_af_oper := 'FA32';
  ELSE
    raise_application_error(-20002, '流程状态已改变！不能执行该操作！');
  END IF;

  IF p_is_trialorder = 1 AND p_trialorder_type IS NULL THEN
    raise_application_error(-20002, '试单时，试单模式必填！');
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
                                           p_is_trialorder  => p_is_trialorder);
  --流程操作记录
  pkg_ask_record_mange.p_log_fac_records_oper(p_company_id   => %default_company_id%,
                                              p_user_id      => :user_id,
                                              p_fac_ask_id   => :factory_ask_id,
                                              p_flow_status  => 'AGREE',
                                              p_fac_ask_flow => p_status_af_oper,
                                              p_memo         => @audit_comment_sp@);

  --供应流程 触发企微机器人发送消息 
  v_wx_sql := scmdata.pkg_supplier_info.send_fac_wx_msg(p_company_id     => %default_company_id%,
                                                        p_factory_ask_id => :factory_ask_id,
                                                        p_msgtype        => 'text', --消息类型 text、markdown
                                                        p_msg_title      => '验厂结果通知', --消息标题
                                                        p_bot_key        => '0b3bbb09-3475-42b1-8ddb-75753e1b9c96', --机器人key
                                                        p_robot_type     => 'SUP_MSG' --机器人配置类型
                                                        );

  @strresult := v_wx_sql;

END;}]';
  update bw3.sys_action t set t.action_type = 8 ,t.action_sql = v_sql,t.port_id = 'qw',t.port_sql = 'select 1 from dual' where t.element_id = 'action_a_coop_314'; 
END;
/
DECLARE
v_sql clob;
BEGIN
  v_sql := q'[--czh 重构代码
{DECLARE
  p_status_af_oper VARCHAR2(32);
  p_msg            VARCHAR2(256);
  p_ask_user       VARCHAR2(32);
  v_wx_sql         CLOB;

BEGIN
  IF :factrory_ask_flow_status = 'FA12' THEN
    p_status_af_oper := 'FA21';
  ELSIF :factrory_ask_flow_status = 'FA31' THEN
    p_status_af_oper := 'FA33';
  ELSE
    raise_application_error(-20002, '流程状态已改变！不能执行该操作！');
  END IF;

  --流程操作记录
  pkg_ask_record_mange.p_log_fac_records_oper(p_company_id   => %default_company_id%,
                                              p_user_id      => :user_id,
                                              p_fac_ask_id   => :factory_ask_id,
                                              p_flow_status  => 'DISAGREE',
                                              p_fac_ask_flow => p_status_af_oper,
                                              p_memo         => @audit_comment@);

  --供应流程 触发企微机器人发送消息
  v_wx_sql := scmdata.pkg_supplier_info.send_fac_wx_msg(p_company_id     => %default_company_id%,
                                                        p_factory_ask_id => :factory_ask_id,
                                                        p_msgtype        => 'text', --消息类型 text、markdown
                                                        p_msg_title      => '验厂结果通知', --消息标题
                                                        p_bot_key        => '0b3bbb09-3475-42b1-8ddb-75753e1b9c96', --机器人key
                                                        p_robot_type     => 'SUP_MSG' --机器人配置类型
                                                         );

  @strresult := v_wx_sql;
END;
}]';
  update bw3.sys_action t set t.action_type = 8 ,t.action_sql = v_sql,t.port_id = 'qw',t.port_sql = 'select 1 from dual' where t.element_id = 'action_a_coop_315'; 
END;
/
DECLARE
v_sql clob;
BEGIN
  v_sql := q'[--czh 重构代码
DECLARE
  vo_target_company VARCHAR2(100);
  vo_target_user    VARCHAR2(4000);
  vo_msg            CLOB;
BEGIN
  IF :factrory_ask_flow_status = 'FA31' THEN
    raise_application_error(-20002, '特批申请不能驳回，请选择同意或不同意');
  ELSIF :factrory_ask_flow_status <> 'FA12' THEN
    raise_application_error(-20002, '流程状态已改变！不能执行该操作！');
  END IF;

  IF :factory_ask_type = 0 THEN
    --流程操作记录
    pkg_ask_record_mange.p_log_fac_records_oper(p_company_id   => %default_company_id%,
                                                p_user_id      => :user_id,
                                                p_fac_ask_id   => :factory_ask_id,
                                                p_flow_status  => 'BACK',
                                                p_fac_ask_flow => 'FA02',
                                                p_memo         => @audit_comment@);

    --2. czh add 消息推送 准入驳回通知：如果单据需验厂,系统自动通知验厂人员

    scmdata.pkg_msg_config.config_t_factory_ask_msg(p_company_id        => %default_company_id%,
                                                    p_factory_ask_id    => :factory_ask_id,
                                                    p_flow_node_name_af => '验厂申请',
                                                    p_oper_code_desc    => '驳回',
                                                    p_oper_code         => 'BACK',
                                                    p_status_af         => 'FA02',
                                                    p_type              => 'SUP_RE_APPLY',
                                                    po_target_company   => vo_target_company,
                                                    po_target_user      => vo_target_user,
                                                    po_msg              => vo_msg);

    scmdata.pkg_msg_config.send_msg(p_company_id  => vo_target_company,
                                    p_user_id     => vo_target_user,
                                    p_node_id     => 'node_a_coop_200',
                                    p_msg_title   => '验厂申请-准入驳回通知',
                                    p_msg_content => vo_msg,
                                    p_type        => 'SUP_RE_APPLY');
  ELSE
    --流程操作记录
    pkg_ask_record_mange.p_log_fac_records_oper(p_company_id   => %default_company_id%,
                                                p_user_id      => :user_id,
                                                p_fac_ask_id   => :factory_ask_id,
                                                p_flow_status  => 'BACK',
                                                p_fac_ask_flow => 'FA11',
                                                p_memo         => @audit_comment@);

    --3.  czh add 消息推送 准入驳回通知：如果单据无需验厂，则系统自动通知验厂申请审批人（无需配置通知人员）

    scmdata.pkg_msg_config.config_t_factory_ask_msg(p_company_id        => %default_company_id%,
                                                    p_factory_ask_id    => :factory_ask_id,
                                                    p_flow_node_name_af => '验厂',
                                                    p_oper_code_desc    => '驳回',
                                                    p_oper_code         => 'BACK',
                                                    p_status_af         => 'FA11',
                                                    p_type              => 'SUP_RE_REPORT',
                                                    po_target_company   => vo_target_company,
                                                    po_target_user      => vo_target_user,
                                                    po_msg              => vo_msg);

    scmdata.pkg_msg_config.send_msg(p_company_id  => vo_target_company,
                                    p_user_id     => vo_target_user,
                                    p_node_id     => 'node_a_check_100',
                                    p_msg_title   => '验厂报告-准入驳回通知',
                                    p_msg_content => vo_msg,
                                    p_type        => 'SUP_RE_REPORT');
  END IF;

END;]';
  update bw3.sys_action t set t.action_sql = v_sql where t.element_id = 'action_a_coop_316'; 
END;
