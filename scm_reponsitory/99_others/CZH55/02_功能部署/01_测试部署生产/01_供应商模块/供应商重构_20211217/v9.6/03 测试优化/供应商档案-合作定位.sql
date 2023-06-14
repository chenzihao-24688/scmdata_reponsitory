declare
v_sql clob;
begin
  v_sql := '--不考虑供应商是否已经在平台注册
DECLARE
  p_sp_data    scmdata.t_supplier_info%ROWTYPE;
  vo_group_name            VARCHAR2(32);
  vo_area_group_leader     VARCHAR2(32);
BEGIN

  p_sp_data.supplier_info_id := scmdata.pkg_plat_comm.f_getkeyid_plat(''GY'',''seq_plat_code'',99);
  p_sp_data.company_id       := %default_company_id%;
  --基本信息
  p_sp_data.supplier_company_name         := :supplier_company_name;
  p_sp_data.supplier_company_abbreviation := :supplier_company_abbreviation;
  --p_sp_data.supplier_code                 := :supplier_code;
  p_sp_data.inside_supplier_code          := :inside_supplier_code;
  p_sp_data.social_credit_code            := :social_credit_code;
  p_sp_data.legal_representative          := :legal_representative;
  p_sp_data.inside_supplier_code          := :inside_supplier_code;
  p_sp_data.company_province              := :company_province;
  p_sp_data.company_city                  := :company_city;
  p_sp_data.company_county                := :company_county;
  p_sp_data.company_address               := :company_address_sp;
  p_sp_data.group_name                    := :v_group_name;
  p_sp_data.company_contact_phone         := :company_contact_phone;
  p_sp_data.fa_contact_name               := :fa_contact_name;
  p_sp_data.fa_contact_phone              := :fa_contact_phone;
  p_sp_data.company_type                  := :company_type;
  --生产信息
  p_sp_data.product_type        := :product_type;
  p_sp_data.product_link        := :product_link;
  p_sp_data.brand_type          := :brand_type;
  p_sp_data.cooperation_brand   := :cooperation_brand;
  p_sp_data.product_line        := :product_line;
  p_sp_data.product_line_num    := :product_line_num;
  p_sp_data.worker_num          := :worker_num;
  p_sp_data.machine_num         := :machine_num;
  p_sp_data.quality_step        := :quality_step;
  p_sp_data.pattern_cap         := :pattern_cap;
  p_sp_data.fabric_purchase_cap := :fabric_purchase_cap;
  p_sp_data.fabric_check_cap    := :fabric_check_cap;
  p_sp_data.cost_step           := :cost_step;
  p_sp_data.reserve_capacity    := rtrim(:reserve_capacity,''%'');
  p_sp_data.product_efficiency  := rtrim(:product_efficiency,''%'');
  p_sp_data.work_hours_day      := :work_hours_day;
  --合作信息
  p_sp_data.pause               := :coop_state;
  p_sp_data.cooperation_model   := :cooperation_model;
  --平台注册状态
  --应用绑定状态
  p_sp_data.cooperation_type  := :cooperation_type;
  p_sp_data.cooperation_model := :cooperation_model;
  IF instr(:cooperation_model,''OF'')> 0 THEN
  p_sp_data.coop_position     := ''外协厂'';
  ELSE
  IF :coop_position IS NULL THEN
  p_sp_data.coop_position     := ''普通型'';
  ELSE
  p_sp_data.coop_position     := :coop_position;
  END IF;
  END IF;
  --相关附件
  p_sp_data.certificate_file := :certificate_file_sp;
  p_sp_data.ask_files := :ask_files;
  p_sp_data.supplier_gate    := :supplier_gate;
  p_sp_data.supplier_office  := :supplier_office;
  p_sp_data.supplier_site    := :supplier_site;
  p_sp_data.supplier_product := :supplier_product;
  p_sp_data.file_remark      := :file_remark;

  p_sp_data.company_say          := :company_say;
  p_sp_data.create_id            := :user_id;
  p_sp_data.create_date          := SYSDATE;
  p_sp_data.supplier_info_origin := ''MA'';
  p_sp_data.status               := 0;

  --1.新增 => 保存，校验数据
  scmdata.pkg_supplier_info.check_save_t_supplier_info(p_sp_data => p_sp_data);
  --2.插入数据
  scmdata.pkg_supplier_info.insert_supplier_info(p_sp_data => p_sp_data);
  --3.更新所在区域 区域组长
  pkg_supplier_info.update_group_name(p_company_id       => %default_company_id%,
                                      p_supplier_info_id => p_sp_data.supplier_info_id);

END;';
update bw3.sys_item_list t set t.insert_sql = v_sql where t.item_id = 'a_supp_171';
end;
/
declare
v_sql clob;
begin
  v_sql := '{DECLARE
  v_sql CLOB;
  v_origin  VARCHAR2(32);
BEGIN
  --来源为手动新增
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
  --来源为a_supp_171-手动新增 则供应商名称、简称和统一社会信用代码 可更改

  --基本信息
  v_sp_data.supplier_company_name         := :supplier_company_name;
  v_sp_data.supplier_company_abbreviation := :supplier_company_abbreviation;
  v_sp_data.social_credit_code            := :social_credit_code;
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
  IF instr(:cooperation_model,''OF'')> 0 THEN
  v_sp_data.coop_position     := ''外协厂'';
  ELSE
  IF :coop_position IS NULL THEN
  v_sp_data.coop_position     := ''普通型'';
  ELSE
  v_sp_data.coop_position     := :coop_position;
  END IF;
  END IF;
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
  pkg_supplier_info.update_supplier_info(p_sp_data => v_sp_data);
  --2.更新所在区域 区域组长
  pkg_supplier_info.update_group_name(p_company_id       => %default_company_id%,
                                      p_supplier_info_id => :supplier_info_id);
END;]'';
  @strresult := v_sql;
END;}';
update bw3.sys_item_list t set t.update_sql = v_sql where t.item_id = 'a_supp_171';
end;
