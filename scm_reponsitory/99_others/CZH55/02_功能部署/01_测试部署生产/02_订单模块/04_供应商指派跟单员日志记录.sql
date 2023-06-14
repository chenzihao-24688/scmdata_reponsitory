declare
v_sql clob;
begin
  v_sql := 'DECLARE
  v_flw_order     VARCHAR2(4000);
  v_reason        VARCHAR2(256);
  v_gendan_name_n VARCHAR2(256);
BEGIN
  --跟单员
  v_flw_order := @flw_order@;

  --变更后
  SELECT listagg(nvl(fc.nick_name, fc.company_user_name), '','') gendan_name_n
    INTO v_gendan_name_n
    FROM scmdata.sys_company_user fc
   WHERE fc.company_id = %default_company_id%
     AND instr(@flw_order@, fc.user_id) > 0;

  UPDATE scmdata.t_supplier_info t
     SET t.gendan_perid = v_flw_order
   WHERE t.supplier_info_id IN (@selection);

  --新增指派跟单员操作日志
  FOR i IN (SELECT t.supplier_info_id
              FROM scmdata.t_supplier_info t
             WHERE t.supplier_info_id IN (%selection%)
               AND t.company_id = %default_company_id%) LOOP
    v_reason := ''指派跟单员为['' || v_gendan_name_n || '']'';
    scmdata.pkg_supplier_info.insert_oper_log(i.supplier_info_id,
                                              ''指派跟单员'',
                                              v_reason,
                                              :user_id,
                                              %default_company_id%,
                                              SYSDATE);
  END LOOP;
END;';
update bw3.sys_action t set t.action_sql = v_sql where t.element_id = 'action_a_supp_160_5';
end;
