declare
v_sql clob;
begin
  v_sql := '--czh �ع�����
{DECLARE
  judge               NUMBER(1);
  v_check_report_file VARCHAR2(256);
  v_wx_sql            CLOB;
BEGIN
  scmdata.pkg_factory_inspection.p_jug_report_result(v_frid   => :factory_report_id,
                                                     v_compid => %default_company_id%);

  SELECT MAX(fr.certificate_file)
    INTO v_check_report_file
    FROM scmdata.t_factory_report fr
   WHERE fr.company_id = %default_company_id%
     AND fr.factory_ask_id = :factory_ask_id;

  SELECT decode(:check_fac_result, NULL, 0, 1) +
         decode(:check_say, '' '', 0, 1) +
         decode(v_check_report_file, NULL, 0, 1)
    INTO judge
    FROM dual;

  IF judge >= 3 THEN
    SELECT COUNT(factory_report_ability_id)
      INTO judge
      FROM scmdata.t_factory_report_ability
     WHERE factory_report_id = :factory_report_id
       AND (cooperation_subcategory IS NULL OR ability_result IS NULL OR
           ability_result = '' '');
    IF judge = 0 THEN
      SELECT COUNT(factory_ask_id)
        INTO judge
        FROM scmdata.t_factory_ask
       WHERE factrory_ask_flow_status <> ''FA11''
         AND factory_ask_id =
             (SELECT factory_ask_id
                FROM scmdata.t_factory_report
               WHERE factory_report_id = :factory_report_id);
      IF judge = 0 THEN

        UPDATE scmdata.t_factory_report
           SET check_user_id = %current_userid%,
               create_id     = %current_userid%
         WHERE factory_ask_id = :factory_ask_id
           AND company_id = %default_company_id%;

        --���̲�����¼
        pkg_ask_record_mange.p_log_fac_records_oper(p_company_id   => %default_company_id%,
                                                    p_user_id      => :user_id,
                                                    p_fac_ask_id   => :factory_ask_id,
                                                    p_flow_status  => ''SUBMIT'',
                                                    p_fac_ask_flow => ''FA13'',
                                                    p_memo         => '''');

        --��Ӧ���� ������΢�����˷�����Ϣ
        v_wx_sql := scmdata.pkg_supplier_info.send_fac_wx_msg(p_company_id     => %default_company_id%,
                                                              p_factory_ask_id => :factory_ask_id,
                                                              p_msgtype        => ''text'', --��Ϣ���� text��markdown
                                                              p_msg_title      => ''�鳧���֪ͨ'', --��Ϣ����
                                                              p_bot_key        => ''94bc653e-e4ed-4d58-bc7e-57b918645bd2'', --������key
                                                              p_robot_type     => ''SUP_MSG'' --��������������
                                                              );
      ELSE
        raise_application_error(-20004,
                                ''���е����������л�ù�Ӧ����׼��ͨ���������ظ��ύ��'');
      END IF;
    ELSE
      raise_application_error(-20003, ''�뽫������������д��ɺ����ύ��'');
    END IF;
  ELSE
    raise_application_error(-20002, ''����дҳ�����������ύ��'');
  END IF;
  @strresult := v_wx_sql;
END;}';
update bw3.sys_action t set t.action_sql = v_sql where t.element_id = 'action_a_check_101_1_0';
end;
  
