DECLARE
v_sql CLOB;
BEGIN
  v_sql := '--修改：启用、停用增加输入原因
DECLARE
BEGIN
  --zc314 add
  FOR i IN (SELECT supplier_info_id, company_id, supplier_code
              FROM scmdata.t_supplier_info
             WHERE supplier_info_id IN (%selection%)
               AND company_id = %default_company_id%) LOOP
  
    pkg_supplier_info.update_supplier_info_status(p_supplier_info_id => i.supplier_info_id,
                                                  p_reason           => @u_reason_sp@,
                                                  p_status           => 0,
                                                  p_user_id          => :user_id,
                                                  p_company_id       => i.company_id);
    --启停合作工厂关系
    pkg_supplier_info.p_check_sup_fac_pause(p_company_id => i.company_id,
                                            p_sup_id     => i.supplier_info_id);
  
    scmdata.pkg_capacity_inqueue.p_common_inqueue(v_curuserid => %current_userid%,
                                                  v_compid    => %default_company_id%,
                                                  v_tab       => ''SCMDATA.T_SUPPLIER_INFO'',
                                                  v_viewtab   => NULL,
                                                  v_unqfields => ''SUPPLIER_INFO_ID,COMPANY_ID'',
                                                  v_ckfields  => ''PAUSE,UPDATE_ID,UPDATE_DATE'',
                                                  v_conds     => ''SUPPLIER_INFO_ID = '''''' ||
                                                                 i.supplier_info_id ||
                                                                 '''''' AND COMPANY_ID = '''''' ||
                                                                 i.company_id || '''''''',
                                                  v_method    => ''UPD'',
                                                  v_viewlogic => NULL,
                                                  v_queuetype => ''CAPC_SUPCAPCAPP_INFO_U'');
  
    --zwh73 qc工厂配置禁用
    scmdata.pkg_qcfactory_config.p_status_qc_factory_config_by_factory(p_factory_code => i.supplier_code,
                                                                       p_company_id   => i.company_id,
                                                                       p_status       => 0);
  END LOOP;
END;';
  UPDATE bw3.sys_action t SET t.action_sql = v_sql  WHERE t.element_id  = 'action_a_supp_160_1';
END;
/
DECLARE
v_sql CLOB;
BEGIN
  v_sql := '--修改：启用、停用增加输入原因
DECLARE
BEGIN
  --zc314 add
  FOR i IN (SELECT supplier_info_id, company_id, supplier_code
              FROM scmdata.t_supplier_info
             WHERE supplier_info_id IN (%selection%)
               AND company_id = %default_company_id%) LOOP
  
    pkg_supplier_info.update_supplier_info_status(p_supplier_info_id => i.supplier_info_id,
                                                  p_reason           => @d_reason_sp@,
                                                  p_status           => 1,
                                                  p_user_id          => :user_id,
                                                  p_company_id       => i.company_id);
    --启停合作工厂关系
    pkg_supplier_info.p_check_sup_fac_pause(p_company_id => i.company_id,
                                            p_sup_id     => i.supplier_info_id);
  
    scmdata.pkg_capacity_inqueue.p_common_inqueue(v_curuserid => %current_userid%,
                                                  v_compid    => %default_company_id%,
                                                  v_tab       => ''SCMDATA.T_SUPPLIER_INFO'',
                                                  v_viewtab   => NULL,
                                                  v_unqfields => ''SUPPLIER_INFO_ID,COMPANY_ID'',
                                                  v_ckfields  => ''PAUSE,UPDATE_ID,UPDATE_DATE'',
                                                  v_conds     => ''SUPPLIER_INFO_ID = '''''' ||
                                                                 i.supplier_info_id ||
                                                                 '''''' AND COMPANY_ID = '''''' ||
                                                                 i.company_id || '''''''',
                                                  v_method    => ''UPD'',
                                                  v_viewlogic => NULL,
                                                  v_queuetype => ''CAPC_SUPCAPCAPP_INFO_U'');
  
    --zwh73 qc工厂配置禁用
    scmdata.pkg_qcfactory_config.p_status_qc_factory_config_by_factory(p_factory_code => i.supplier_code,
                                                                       p_company_id   => i.company_id,
                                                                       p_status       => 1);
  END LOOP;
END;';
  UPDATE bw3.sys_action t SET t.action_sql = v_sql  WHERE t.element_id  = 'action_a_supp_160_2';
END;
/
BEGIN
UPDATE bw3.sys_item_element_rela t SET t.element_id = 'associate_a_report_list_304' WHERE t.item_id = 'a_report_140';
UPDATE bw3.sys_element_hint t SET t.element_id = 'associate_a_report_list_304',t.link_name = 'SUPPLIER_NAME'  WHERE t.item_id = 'a_report_140';
END;
/
