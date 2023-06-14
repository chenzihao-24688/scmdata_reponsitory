declare
v_sql clob;
begin
  v_sql := '--修改：启用、停用增加输入原因
DECLARE
BEGIN
  pkg_supplier_info.update_supplier_info_status(p_supplier_info_id => %selection%,
                                                   p_reason           => @U_REASON_SP@,
                                                   p_status           => 0,
                                                   p_user_id          => :user_id,
                                                   p_company_id       => %default_company_id%);
  --启停合作工厂关系
  pkg_supplier_info.p_check_sup_fac_pause(p_company_id => %default_company_id%,p_sup_id => %selection%);
END;';
update bw3.sys_action t set t.action_sql = v_sql where t.element_id = 'action_a_supp_160_1';
end;
/
declare
v_sql clob;
begin
  v_sql := '--修改：启用、停用增加输入原因
DECLARE
BEGIN
  pkg_supplier_info.update_supplier_info_status(p_supplier_info_id => %selection%,
                                                   p_reason           => @D_REASON_SP@,
                                                   p_status           => 1,
                                                   p_user_id          => :user_id,
                                                   p_company_id       => %default_company_id%);
  --启停合作工厂关系
  pkg_supplier_info.p_check_sup_fac_pause(p_company_id => %default_company_id%,p_sup_id => %selection%);
END;';
update bw3.sys_action t set t.action_sql = v_sql where t.element_id = 'action_a_supp_160_2';
end;
