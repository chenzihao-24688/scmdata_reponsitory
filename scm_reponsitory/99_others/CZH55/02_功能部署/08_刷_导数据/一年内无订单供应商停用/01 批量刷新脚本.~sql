--修改：启用、停用增加输入原因
DECLARE
  v_sup_id  VARCHAR2(32);
  v_comp_id VARCHAR2(32) := 'b6cc680ad0f599cde0531164a8c0337f';
BEGIN
  FOR i IN (SELECT t.col_1 sup_code FROM scmdata.t_excel_import t) LOOP
  
    SELECT sp.supplier_info_id
      INTO v_sup_id
      FROM scmdata.t_supplier_info sp
     WHERE sp.company_id = v_comp_id
       AND sp.supplier_code = i.sup_code;
  
    pkg_supplier_info.update_supplier_info_status(p_supplier_info_id => v_sup_id,
                                                  p_reason           => '一年内没有订单的无效供应商',
                                                  p_status           => 1,
                                                  p_user_id          => 'ADMIN',
                                                  p_company_id       => v_comp_id);
    --启停合作工厂关系
    pkg_supplier_info.p_check_sup_fac_pause(p_company_id => v_comp_id,
                                            p_sup_id     => v_sup_id);
  
    --zc314 add
    /*    FOR i IN (SELECT supplier_info_id, company_id, supplier_code
     FROM scmdata.t_supplier_info
    WHERE supplier_info_id = v_sup_id
      AND company_id = v_comp_id) LOOP*/
    scmdata.pkg_capacity_inqueue.p_common_inqueue(v_curuserid => 'ADMIN',
                                                  v_compid    => v_comp_id,
                                                  v_tab       => 'SCMDATA.T_SUPPLIER_INFO',
                                                  v_viewtab   => NULL,
                                                  v_unqfields => 'SUPPLIER_INFO_ID,COMPANY_ID',
                                                  v_ckfields  => 'PAUSE,UPDATE_ID,UPDATE_DATE',
                                                  v_conds     => 'SUPPLIER_INFO_ID = ''' ||
                                                                 v_sup_id ||
                                                                 ''' AND COMPANY_ID = ''' ||
                                                                 v_comp_id || '''',
                                                  v_method    => 'UPD',
                                                  v_viewlogic => NULL,
                                                  v_queuetype => 'CAPC_SUPCAPCAPP_INFO_U');
  
  /*      --zwh73 qc工厂配置禁用
          scmdata.pkg_qcfactory_config.p_status_qc_factory_config_by_factory(p_factory_code => i.supplier_code,
                                                                             p_company_id   => i.company_id,
                                                                             p_status       => 1);*/
  -- END LOOP;
  END LOOP;
END;
