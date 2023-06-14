declare
v_sql clob;
begin
  v_sql := '--czh 重构代码
DECLARE
  jug_num   NUMBER(5);
  jug_str   VARCHAR2(256);
  coop_type VARCHAR2(64);
BEGIN
  scmdata.pkg_ask_record_mange.has_coop_submit(pi_be_company_id      => %default_company_id%,
                                               pi_social_credit_code => :social_credit_code);

  SELECT COUNT(1), listagg(DISTINCT cooperation_type, '','') || '',''
    INTO jug_num, jug_str
    FROM scmdata.t_ask_scope
   WHERE object_id = :ask_record_id
     AND company_id = %default_company_id%;

  IF jug_num > 0 THEN
    SELECT cooperation_type || '',''
      INTO coop_type
      FROM scmdata.t_ask_record
     WHERE ask_record_id = :ask_record_id
       AND be_company_id = %default_company_id%;

    IF jug_str <> coop_type THEN
      raise_application_error(-20002,
                              ''主表合作类型与子表合作类型不符，请修改后再提交！'');
    ELSE
      UPDATE scmdata.t_ask_record
         SET create_id = %current_userid%, create_date = SYSDATE,coor_ask_flow_status = ''CA01'',ask_date  = SYSDATE
       WHERE ask_record_id = :ask_record_id;

      --流程操作记录
      pkg_ask_record_mange.p_log_fac_records_oper(p_company_id    => %default_company_id%,
                                                  p_user_id       => :user_id,
                                                  p_ask_record_id => :ask_record_id,
                                                  p_flow_status   => ''SUBMIT'',
                                                  p_fac_ask_flow  => ''CA01'',
                                                  p_memo          => '''');

    END IF;
  ELSE
    raise_application_error(-20002, ''请填写意向合作范围后再提交！'');
  END IF;
END;
';
update bw3.sys_action t set t.action_sql = v_sql where t.element_id = 'action_a_coop_151';
end;

