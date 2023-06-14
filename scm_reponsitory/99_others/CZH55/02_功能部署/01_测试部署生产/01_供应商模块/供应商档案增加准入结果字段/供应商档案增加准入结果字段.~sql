alter table scmdata.t_supplier_info add admit_result varchar2(32);
/
comment on column t_supplier_info.admit_result is '准入结果';
/
declare
v_sql clob;
begin
  v_sql := '--czh 重构代码
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

END;}';
update bw3.sys_action t set t.action_sql = v_sql where t.element_id = 'action_a_coop_311' ;
end;
/
--历史数据处理
BEGIN
  FOR tri_rec IN (SELECT sa.company_id,
                         sa.supplier_info_id,
                         nvl(fr.admit_result, 0) trialorder_type
                    FROM scmdata.t_supplier_info sa
                   INNER JOIN scmdata.t_factory_ask fa
                      ON sa.supplier_info_origin_id = fa.factory_ask_id
                     AND sa.supplier_info_origin = 'AA'
                     AND sa.company_id = fa.company_id
                   INNER JOIN scmdata.t_factory_report fr
                      ON fa.factory_ask_id = fr.factory_ask_id
                     AND fa.company_id = fr.company_id
                     AND sa.company_id = 'b6cc680ad0f599cde0531164a8c0337f') LOOP
    UPDATE scmdata.t_supplier_info t
       SET t.admit_result = tri_rec.trialorder_type
     WHERE t.supplier_info_id = tri_rec.supplier_info_id
       AND t.company_id = tri_rec.company_id;
  END LOOP;
END;
