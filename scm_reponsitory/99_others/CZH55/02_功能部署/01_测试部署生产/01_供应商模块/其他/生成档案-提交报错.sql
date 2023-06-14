{DECLARE
  v_wx_sql     CLOB;
  v_origin     VARCHAR2(32);
  v_origin_id  VARCHAR2(32);
  v_submit_btn VARCHAR2(256) := :supplier_company_name;
  V_SUPCODE    VARCHAR2(32);
BEGIN
  --����ʨԭ�򣬵�����ɵ���ʱ�����Զ����������ύ��ť��
  --�ʻ�ȡ��������У�飬��v_submit_btn��Ϊ��ʱ����ִ���ύ��ť��
  IF v_submit_btn IS NOT NULL THEN
    pkg_supplier_info.submit_t_supplier_info(p_supplier_info_id   => :supplier_info_id,
                                             p_default_company_id => %default_company_id%,
                                             p_user_id            => %user_id%);

    --zc314 add
    SCMDATA.PKG_CAPACITY_INQUEUE.P_COMMON_INQUEUE(V_CURUSERID  => %CURRENT_USERID%,
                                                  V_COMPID     => %DEFAULT_COMPANY_ID%,
                                                  V_TAB        => 'SCMDATA.T_SUPPLIER_INFO',
                                                  V_VIEWTAB    => NULL,
                                                  V_UNQFIELDS  => 'SUPPLIER_INFO_ID,COMPANY_ID',
                                                  V_CKFIELDS   => 'STATUS,UPDATE_ID,UPDATE_DATE',
                                                  V_CONDS      => 'SUPPLIER_INFO_ID = '''||:SUPPLIER_INFO_ID||''' AND COMPANY_ID = '''||%DEFAULT_COMPANY_ID%||'''',
                                                  V_METHOD     => 'UPD',
                                                  V_VIEWLOGIC  => NULL,
                                                  V_QUEUETYPE  => 'CAPC_SUPCAPCAPP_INFO_U');

    --����qc��������
    /*scmdata.pkg_qcfactory_config.p_enable_qc_factory_config_by_pro(p_supplier_info => :supplier_info_id,
                                                                   p_company_id    => %default_company_id%);*/


    --����֪ͨ
    SELECT t.supplier_info_origin, t.supplier_info_origin_id
      INTO v_origin, v_origin_id
      FROM scmdata.t_supplier_info t
     WHERE t.company_id = %default_company_id%
       AND t.supplier_info_id = :supplier_info_id;

    IF v_origin = 'AA' THEN
      --������΢�����˷�����Ϣ
      v_wx_sql := scmdata.pkg_supplier_info.send_fac_wx_msg(p_company_id     => %default_company_id%,
                                                            p_factory_ask_id => v_origin_id,
                                                            p_msgtype        => 'text', --��Ϣ���� text��markdown
                                                            p_msg_title      => '����֪ͨ', --��Ϣ����
                                                            p_bot_key        => '0b3bbb09-3475-42b1-8ddb-75753e1b9c96', --������key
                                                            p_robot_type     => 'SUP_MSG' --��������������
                                                            );
    ELSE
      v_wx_sql := 'select ''text'' MSGTYPE,''������Ӧ��-����֪ͨ''  CONTENT,''999bc2eb-55b8-400d-a70e-5ea148e59396'' key from dual';
    END IF;
  ELSE
    v_wx_sql := 'select ''text'' MSGTYPE,''������Ӧ��-����֪ͨ''  CONTENT,''999bc2eb-55b8-400d-a70e-5ea148e59396'' key from dual';
  END IF;

  @strresult := v_wx_sql;

END;
}
