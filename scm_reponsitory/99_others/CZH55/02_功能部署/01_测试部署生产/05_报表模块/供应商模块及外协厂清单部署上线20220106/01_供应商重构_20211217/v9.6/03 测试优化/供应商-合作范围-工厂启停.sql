declare
v_sql clob;
begin
  v_sql := '--修改：启用、停用增加输入原因
DECLARE
BEGIN
  pkg_supplier_info.update_supplier_info_status(p_supplier_info_id => %selection%,
                                                   p_reason           => @U_REASON_SP@,
                                                   p_status           => 0,
                                                   p_user_id          => pkg_personal.F_show_username_by_company(pi_user_id => :user_id , pi_company_id => %default_company_id%),
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
                                                   p_user_id          => pkg_personal.F_show_username_by_company(pi_user_id => :user_id , pi_company_id => %default_company_id%),
                                                   p_company_id       => %default_company_id%);
  --启停合作工厂关系
  pkg_supplier_info.p_check_sup_fac_pause(p_company_id => %default_company_id%,p_sup_id => %selection%);
END;';
  update bw3.sys_action t set t.action_sql = v_sql where t.element_id = 'action_a_supp_160_2';
end;
/
declare
v_sql clob;
begin
  v_sql := 'DECLARE
  v_coop_scope_id VARCHAR2(100);
BEGIN
  FOR a_rec IN (SELECT tc.supplier_info_id, tc.coop_scope_id
                  FROM scmdata.t_coop_scope tc
                 WHERE tc.coop_scope_id IN (@selection)) LOOP
  
    v_coop_scope_id := a_rec.coop_scope_id;
    pkg_supplier_info.update_coop_scope_status(p_company_id       => %default_company_id%,
                                               p_user_id          => %user_id%, 
                                               p_supplier_info_id => a_rec.supplier_info_id,
                                               p_coop_scope_id    => a_rec.coop_scope_id,
                                               p_status           => 0);                                               
  END LOOP;
  --启停合作工厂关系
  FOR s_rec IN (SELECT distinct tc.supplier_info_id
                  FROM scmdata.t_coop_scope tc
                 WHERE tc.coop_scope_id IN (@selection)) LOOP
  pkg_supplier_info.p_check_sup_fac_pause(p_company_id => %default_company_id%,p_sup_id => s_rec.supplier_info_id);
  END LOOP;
END;';
  update bw3.sys_action t set t.action_sql = v_sql where t.element_id = 'action_a_supp_161_1_1';
end;
/
declare
v_sql clob;
begin
  v_sql := 'DECLARE
  v_coop_scope_id VARCHAR2(100);
BEGIN
  FOR a_rec IN (SELECT tc.supplier_info_id, tc.coop_scope_id
                  FROM scmdata.t_coop_scope tc
                 WHERE tc.coop_scope_id IN (@selection)) LOOP
  
    v_coop_scope_id := a_rec.coop_scope_id;
    pkg_supplier_info.update_coop_scope_status(p_company_id       => %default_company_id%,
                                               p_user_id          => %user_id%,                     
                                               p_supplier_info_id => a_rec.supplier_info_id,
                                               p_coop_scope_id    => a_rec.coop_scope_id,
                                               p_status           => 1); 
  END LOOP;
  --启停合作工厂关系
  FOR s_rec IN (SELECT distinct tc.supplier_info_id
                  FROM scmdata.t_coop_scope tc
                 WHERE tc.coop_scope_id IN (@selection)) LOOP
  pkg_supplier_info.p_check_sup_fac_pause(p_company_id => %default_company_id%,p_sup_id => s_rec.supplier_info_id);
  END LOOP;
END;';
  update bw3.sys_action t set t.action_sql = v_sql where t.element_id = 'action_a_supp_161_1_2';
end;
/
declare
v_sql clob;
begin
  v_sql := '{DECLARE
  v_sql CLOB;
  v_origin  VARCHAR2(32);
BEGIN
  --来源为准入/手动新增
  SELECT MAX(sp.supplier_info_origin)
    INTO v_origin
    FROM scmdata.t_supplier_info sp
   WHERE sp.supplier_info_id = :supplier_info_id
     AND sp.company_id = %default_company_id%
     AND sp.status = 0;

  v_sql := q''[DECLARE
  v_sp_data t_supplier_info%ROWTYPE;
BEGIN
  --待建档数据
  v_sp_data.supplier_info_id := :supplier_info_id;
  v_sp_data.company_id       := :company_id;
  v_sp_data.status           := :status;
  v_sp_data.supplier_info_origin := '']'' || v_origin || q''['' ;
  --来源为准入 统一社会信用代码则 不可更改
  --来源为手动新增 待建档：统一社会信用代码 可以更改 ，已建档 不可以更改
  ]'' || CASE
             WHEN v_origin = ''MA'' THEN
              ''
               v_sp_data.social_credit_code            := :social_credit_code;
               ''
             ELSE
              ''''
           END || q''[
  --基本信息
  v_sp_data.supplier_company_name         := :supplier_company_name;
  v_sp_data.supplier_company_abbreviation := :supplier_company_abbreviation;
  v_sp_data.legal_representative := :legal_representative;
  v_sp_data.inside_supplier_code := :inside_supplier_code;
  v_sp_data.company_province     := :company_province;
  v_sp_data.company_city         := :company_city;
  v_sp_data.company_county       := :company_county;
  v_sp_data.company_address      := :company_address_sp;
  --v_sp_data.group_name                    := :group_name;
  v_sp_data.company_contact_phone := :company_contact_phone;
  v_sp_data.fa_contact_name       := :fa_contact_name;
  v_sp_data.fa_contact_phone      := :fa_contact_phone;
  v_sp_data.company_type          := :company_type;
  --生产信息
  v_sp_data.product_type        := :product_type;
  v_sp_data.product_link        := :product_link;
  v_sp_data.brand_type          := :brand_type;
  v_sp_data.cooperation_brand   := :cooperation_brand;
  v_sp_data.product_line        := :product_line;
  v_sp_data.product_line_num    := :product_line_num;
  v_sp_data.worker_num          := :worker_num;
  v_sp_data.machine_num         := :machine_num;
  v_sp_data.quality_step        := :quality_step;
  v_sp_data.pattern_cap         := :pattern_cap;
  v_sp_data.fabric_purchase_cap := :fabric_purchase_cap;
  v_sp_data.fabric_check_cap    := :fabric_check_cap;
  v_sp_data.cost_step           := :cost_step;
  v_sp_data.reserve_capacity    := rtrim(:reserve_capacity,''%'');
  v_sp_data.product_efficiency  := rtrim(:product_efficiency,''%'');
  v_sp_data.work_hours_day      := :work_hours_day;
  --合作信息
  v_sp_data.pause               := :coop_state;
  --v_sp_data.cooperation_type  := :cooperation_type;
  v_sp_data.cooperation_model := :cooperation_model;
  v_sp_data.coop_position := :coop_position;
  --附件资料
  v_sp_data.certificate_file := :certificate_file_sp;
  v_sp_data.ask_files := :ask_files;
  v_sp_data.supplier_gate    := :supplier_gate;
  v_sp_data.supplier_office  := :supplier_office;
  v_sp_data.supplier_site    := :supplier_site;
  v_sp_data.supplier_product := :supplier_product;
  v_sp_data.company_say      := :company_say;
  v_sp_data.file_remark      := :file_remark;
  v_sp_data.update_id        := :user_id;
  v_sp_data.update_date      := SYSDATE;
  --1.更新=》保存，校验数据
  pkg_supplier_info.update_supplier_info(p_sp_data => v_sp_data,p_item_id => ''a_supp_161'');
  --2.更新所在区域 区域组长
  pkg_supplier_info.update_group_name(p_company_id       => %default_company_id%,
                                      p_supplier_info_id => :supplier_info_id);
  --3.启停合作工厂关系                                                 
  pkg_supplier_info.p_check_sup_fac_pause(p_company_id => %default_company_id%,p_sup_id => :supplier_info_id);
END;]'';
  @strresult := v_sql;
END;}';
  update bw3.sys_item_list t set t.update_sql = v_sql where t.item_id = 'a_supp_161' ;
end;
