BEGIN
UPDATE bw3.sys_cond_operate t SET t.to_cancel_item_id = NULL WHERE t.cond_id = 'cond_a_coop_150'; 
UPDATE bw3.sys_item_element_rela t SET t.pause = 1 WHERE t.element_id = 'look_a_supp_160_1';
END;
/
DECLARE
v_sql CLOB;
BEGIN
v_sql := 'SELECT a.provinceid company_province,
       a.province province_desc,
       b.cityno company_city,
       b.city city_desc,
       c.countyid company_county,
       c.county county_desc,
       a.province || b.city || c.county ar_company_area_y,
       NULL ar_company_vill_desc_y,
       NULL ar_company_vill_y
  FROM scmdata.dic_province a
  LEFT JOIN scmdata.dic_city b
    ON a.provinceid = b.provinceid
   AND b.pause = 0
  LEFT JOIN scmdata.dic_county c
    ON b.cityno = c.cityno
   AND c.pause = 0';
UPDATE bw3.sys_pick_list t SET t.pick_sql = v_sql WHERE t.element_id = 'picklist_address';
END;
/
DECLARE
v_sql CLOB;
BEGIN
v_sql := q'[ar_company_name_y,ar_company_abbreviation_y,ar_social_credit_code_y,ar_company_area_y,ar_company_vill_y,ar_company_vill_desc_y,ar_company_address_y,ar_company_regist_date_y,ar_legal_representative_n,ar_company_contact_phone_n,ar_cooperation_type_y,ar_cooperation_model_y,ar_coop_model_desc_y,ar_company_type_y,ar_company_type_desc_y,ar_pay_term_n,ar_pay_term_desc_n,ar_product_type_y,ar_product_type_desc_y,ar_sapply_user_y,ar_sapply_phone_y,ar_coop_brand_desc_n,ar_product_link_n,ar_rela_supplier_id_y,ar_is_our_factory_y,ar_is_our_fac_desc_y,ar_factory_name_y,ar_factory_area_y,ar_factory_vill_y,ar_factory_vill_desc_y,ar_factroy_details_address_y,ar_factroy_area_y,ar_ask_say_n,ar_remarks_n]';
UPDATE bw3.sys_detail_group t SET t.clo_names = v_sql WHERE t.item_id = 'a_coop_151' AND t.group_name = '基本信息';
END;
/
DECLARE
v_sql CLOB;
v_sql1 CLOB;
BEGIN
UPDATE bw3.sys_item_element_rela t SET t.pause = 1 WHERE t.element_id IN ('look_a_coop_151_3');

UPDATE bw3.sys_pick_list t SET t.other_fields = 'AR_COOP_MODEL_DESC_Y,AR_COOPERATION_MODEL_Y,AR_COMPANY_TYPE_DESC_Y,AR_COMPANY_TYPE_Y,AR_PAY_TERM_N,AR_PAY_TERM_DESC_N,AR_PRODUCT_TYPE_Y,AR_PRODUCT_TYPE_DESC_Y' WHERE t.element_id = 'pick_a_coop_151_4';

UPDATE bw3.sys_pick_list t SET t.other_fields = 'AR_COMPANY_TYPE_DESC_Y,AR_COMPANY_TYPE_Y' WHERE t.element_id = 'pick_a_coop_151_3';
END;
/
DECLARE
v_insert_sql CLOB;
v_update_sql CLOB;
BEGIN
 UPDATE bw3.sys_pick_list t SET t.seperator = ' ' WHERE t.element_id = 'pick_a_coop_151_4';
 v_insert_sql := '--czh 20221103 v9.10
{DECLARE
  v_sql         CLOB;
  v_ask_record_id   VARCHAR2(32);
  v_rest_method     VARCHAR2(256);
  v_params          VARCHAR2(2000);
BEGIN
  --获取asscoiate请求参数
  pkg_plat_comm.p_get_rest_val_method_params(p_character     => %ass_ask_record_id%,
                                             po_pk_id        => v_ask_record_id,
                                             po_rest_methods => v_rest_method,
                                             po_params       => v_params);
  v_rest_method := nvl(v_rest_method, ''POST'');
  IF instr('';'' || v_rest_method || '';'', '';'' || ''POST'' || '';'') > 0 THEN
  --v_ask_record_id := nvl(v_ask_record_id, :ask_record_id);
  v_sql :=  q''[
DECLARE
  v_company_id  VARCHAR2(32);
  p_ar_rec scmdata.t_ask_record%ROWTYPE;
  v_ask_record_id    VARCHAR2(32) := nvl('']'' || v_ask_record_id || q''['', :ask_record_id);
BEGIN
    SELECT MAX(company_id)
      INTO v_company_id
      FROM scmdata.sys_company
     WHERE licence_num = :ar_social_credit_code_y;

    p_ar_rec.ask_record_id := v_ask_record_id;
    p_ar_rec.company_id    := nvl(v_company_id, '''');
    p_ar_rec.be_company_id := %default_company_id%;
    --基本信息
    p_ar_rec.company_name            := :ar_company_name_y;
    p_ar_rec.company_abbreviation    := :ar_company_abbreviation_y;
    p_ar_rec.social_credit_code      := :ar_social_credit_code_y;
    p_ar_rec.company_province        := :company_province;
    p_ar_rec.company_city            := :company_city;
    p_ar_rec.company_county          := :company_county;
    p_ar_rec.company_vill            := :ar_company_vill_y;
    p_ar_rec.company_address         := :ar_company_address_y;
    p_ar_rec.company_regist_date     := :ar_company_regist_date_y;
    p_ar_rec.pay_term                := :ar_pay_term_n;
    p_ar_rec.legal_representative    := :ar_legal_representative_n;
    p_ar_rec.company_contact_phone   := :ar_company_contact_phone_n;
    p_ar_rec.sapply_user             := :ar_sapply_user_y;
    p_ar_rec.sapply_phone            := :ar_sapply_phone_y;
    p_ar_rec.company_type            := :ar_company_type_y;
    p_ar_rec.brand_type              := :brand_type;
    p_ar_rec.cooperation_brand       := :cooperation_brand;
    p_ar_rec.cooperation_type        := :ar_cooperation_type_y;
    p_ar_rec.cooperation_model       := replace(:ar_cooperation_model_y,'' '','';'');
    p_ar_rec.product_type            := :ar_product_type_y;
    p_ar_rec.product_link            := :ar_product_link_n;
    p_ar_rec.rela_supplier_id        := :ar_rela_supplier_id_n;
    p_ar_rec.is_our_factory          := :ar_is_our_factory_y;
    p_ar_rec.factory_name            := :ar_factory_name_y;
    p_ar_rec.factory_province        := :factory_province;
    p_ar_rec.factory_city            := :factory_city;
    p_ar_rec.factory_county          := :factory_county;
    p_ar_rec.factory_vill            := :ar_factory_vill_y;
    p_ar_rec.factroy_details_address := :ar_factroy_details_address_y;
    p_ar_rec.factroy_area            := :ar_factroy_area_y;
    p_ar_rec.ask_say                 := :ar_ask_say_n;
    p_ar_rec.remarks                 := :ar_remarks_n;
    --生产信息
    p_ar_rec.product_line        := :ar_product_line_n;
    p_ar_rec.product_line_num    := :ar_product_line_num_n;
    p_ar_rec.quality_step        := :ar_quality_step_n;
    p_ar_rec.work_hours_day      := :ar_work_hours_day_y;
    p_ar_rec.worker_total_num    := :ar_worker_total_num_y;
    p_ar_rec.worker_num          := :ar_worker_num_y;
    p_ar_rec.machine_num         := :ar_machine_num_y;
    p_ar_rec.form_num            := :ar_form_num_y;
    p_ar_rec.product_efficiency  := :ar_product_efficiency_y;
    p_ar_rec.pattern_cap         := :ar_pattern_cap_y;
    p_ar_rec.fabric_purchase_cap := :ar_fabric_purchase_cap_y;
    p_ar_rec.fabric_check_cap    := :ar_fabric_check_cap_n;
    --附件资料
    p_ar_rec.certificate_file  := :ar_certificate_file_y;
    p_ar_rec.supplier_gate     := :ar_supplier_gate_n;
    p_ar_rec.supplier_office   := :ar_supplier_office_n;
    p_ar_rec.supplier_site     := :ar_supplier_site_n;
    p_ar_rec.supplier_product  := :ar_supplier_product_n;
    p_ar_rec.other_information := :ar_other_information_n;
    --其它
    p_ar_rec.coor_ask_flow_status := ''CA00'';
    p_ar_rec.origin               := ''MA'';
    p_ar_rec.create_id            := :user_id;
    p_ar_rec.create_date          := SYSDATE;
    p_ar_rec.update_id            := :user_id;
    p_ar_rec.update_date          := SYSDATE;
    --废弃字段
    p_ar_rec.ask_date              := SYSDATE;
    p_ar_rec.ask_user_id           := :user_id;
    p_ar_rec.other_file            := NULL;
    p_ar_rec.cooperation_statement := NULL;
    p_ar_rec.collection            := 0;
    --1.新增校验
    scmdata.pkg_ask_record_mange.p_check_data_by_save(p_ar_rec => p_ar_rec,p_type => 1);
    --2.新增意向供应商
    scmdata.pkg_ask_record_mange.p_insert_t_ask_record(p_ar_rec => p_ar_rec);
    --3.新增意向供应商时，同步生成人员、机器配置
    scmdata.pkg_ask_record_mange.p_generate_person_machine_config(p_company_id    => %default_company_id%,
                                                                  p_user_id       => :user_id,
                                                                  p_ask_record_id => v_ask_record_id);
END;]'';
  ELSE
    v_sql := NULL;
  END IF;
  '|| CHR(64) ||'strresult := v_sql;
END;}';

v_update_sql := '--czh 20221103 v9.10
{DECLARE
  v_sql         CLOB;
  v_ask_record_id   VARCHAR2(32);
  v_rest_method     VARCHAR2(256);
  v_params          VARCHAR2(2000);
BEGIN
  --获取asscoiate请求参数
  pkg_plat_comm.p_get_rest_val_method_params(p_character     => %ass_ask_record_id%,
                                             po_pk_id        => v_ask_record_id,
                                             po_rest_methods => v_rest_method,
                                             po_params       => v_params);
  v_rest_method := nvl(v_rest_method, ''PUT'');
  IF instr('';'' || v_rest_method || '';'', '';'' || ''PUT'' || '';'') > 0 THEN
  --v_ask_record_id := nvl(v_ask_record_id, :ask_record_id);
  v_sql :=  q''[
DECLARE
  p_ar_rec scmdata.t_ask_record%ROWTYPE;
BEGIN
    p_ar_rec.ask_record_id := nvl('']'' || v_ask_record_id || q''['', :ask_record_id);
    p_ar_rec.company_id    := :company_id;
    p_ar_rec.be_company_id := %default_company_id%;
    --基本信息
    p_ar_rec.company_name            := :ar_company_name_y;
    p_ar_rec.company_abbreviation    := :ar_company_abbreviation_y;
    p_ar_rec.social_credit_code      := :ar_social_credit_code_y;
    p_ar_rec.company_province        := :company_province;
    p_ar_rec.company_city            := :company_city;
    p_ar_rec.company_county          := :company_county;
    p_ar_rec.company_vill            := :ar_company_vill_y;
    p_ar_rec.company_address         := :ar_company_address_y;
    p_ar_rec.company_regist_date     := :ar_company_regist_date_y;
    p_ar_rec.pay_term                := :ar_pay_term_n;
    p_ar_rec.legal_representative    := :ar_legal_representative_n;
    p_ar_rec.company_contact_phone   := :ar_company_contact_phone_n;
    p_ar_rec.sapply_user             := :ar_sapply_user_y;
    p_ar_rec.sapply_phone            := :ar_sapply_phone_y;
    p_ar_rec.company_type            := :ar_company_type_y;
    p_ar_rec.brand_type              := :brand_type;
    p_ar_rec.cooperation_brand       := :cooperation_brand;
    p_ar_rec.cooperation_type        := :ar_cooperation_type_y;
    p_ar_rec.cooperation_model       := replace(:ar_cooperation_model_y,'' '','';'');
    p_ar_rec.product_type            := :ar_product_type_y;
    p_ar_rec.product_link            := :ar_product_link_n;
    p_ar_rec.rela_supplier_id        := :ar_rela_supplier_id_n;
    p_ar_rec.is_our_factory          := :ar_is_our_factory_y;
    p_ar_rec.factory_name            := :ar_factory_name_y;
    p_ar_rec.factory_province        := :factory_province;
    p_ar_rec.factory_city            := :factory_city;
    p_ar_rec.factory_county          := :factory_county;
    p_ar_rec.factory_vill            := :ar_factory_vill_y;
    p_ar_rec.factroy_details_address := :ar_factroy_details_address_y;
    p_ar_rec.factroy_area            := :ar_factroy_area_y;
    p_ar_rec.ask_say                 := :ar_ask_say_n;
    p_ar_rec.remarks                 := :ar_remarks_n;
    --生产信息
    p_ar_rec.product_line        := :ar_product_line_n;
    p_ar_rec.product_line_num    := :ar_product_line_num_n;
    p_ar_rec.quality_step        := :ar_quality_step_n;
    p_ar_rec.work_hours_day      := :ar_work_hours_day_y;
    p_ar_rec.worker_total_num    := :ar_worker_total_num_y;
    p_ar_rec.worker_num          := :ar_worker_num_y;
    p_ar_rec.machine_num         := :ar_machine_num_y;
    p_ar_rec.form_num            := :ar_form_num_y;
    p_ar_rec.product_efficiency  := :ar_product_efficiency_y;
    p_ar_rec.pattern_cap         := :ar_pattern_cap_y;
    p_ar_rec.fabric_purchase_cap := :ar_fabric_purchase_cap_y;
    p_ar_rec.fabric_check_cap    := :ar_fabric_check_cap_n;
    --附件资料
    p_ar_rec.certificate_file  := :ar_certificate_file_y;
    p_ar_rec.supplier_gate     := :ar_supplier_gate_n;
    p_ar_rec.supplier_office   := :ar_supplier_office_n;
    p_ar_rec.supplier_site     := :ar_supplier_site_n;
    p_ar_rec.supplier_product  := :ar_supplier_product_n;
    p_ar_rec.other_information := :ar_other_information_n;
    --其它
    p_ar_rec.update_id            := :user_id;
    p_ar_rec.update_date          := SYSDATE;

    --1.修改校验
    scmdata.pkg_ask_record_mange.p_check_data_by_save(p_ar_rec => p_ar_rec,p_type => 1);
    --2.修改意向供应商
    scmdata.pkg_ask_record_mange.p_update_t_ask_record(p_ar_rec => p_ar_rec);
END;]'';
  ELSE
    v_sql := NULL;
  END IF;
  '|| CHR(64) ||'strresult := v_sql;
END;}';
 
UPDATE bw3.sys_item_list t SET t.insert_sql = v_insert_sql,t.update_sql = v_update_sql WHERE t.item_id = 'a_coop_151'; 
END;
/
DECLARE
v_update_sql CLOB; 
BEGIN
  v_update_sql := '--czh 20221103 v9.10
{
DECLARE
  v_sql            CLOB;
  v_ask_record_id  VARCHAR2(32);
  v_factory_ask_id VARCHAR2(32);
  v_rest_method    VARCHAR2(256);
  v_params         VARCHAR2(2000);
  v_item_id        VARCHAR(256);
BEGIN
  --获取asscoiate请求参数
  pkg_plat_comm.p_get_rest_val_method_params(p_character     => %ass_ask_record_id%,
                                             po_pk_id        => v_ask_record_id,
                                             po_rest_methods => v_rest_method,
                                             po_params       => v_params);
  IF instr('';'' || v_rest_method || '';'', '';'' || ''PUT'' || '';'') > 0 THEN

    SELECT MAX(t.factory_ask_id)
      INTO v_factory_ask_id
      FROM scmdata.t_factory_ask t
     WHERE t.ask_record_id = v_ask_record_id
       AND t.company_id = %default_company_id%;

    v_sql := q''[DECLARE
    p_fa_rec         scmdata.t_factory_ask%ROWTYPE;
    v_factory_ask_id VARCHAR2(32) := '']'' || v_factory_ask_id || q''['';
  BEGIN
    p_fa_rec.factory_ask_id := v_factory_ask_id;
    p_fa_rec.company_id := :company_id;
    --申请信息
    p_fa_rec.ask_user_id       := :fa_check_person_y;
    p_fa_rec.ask_user_dept_id  := :fa_check_dept_name_y;
    p_fa_rec.is_urgent         := :fa_is_urgent_n;
    p_fa_rec.cooperation_model := replace(:ar_cooperation_model_y,'' '','';'');
    p_fa_rec.product_type      := :ar_product_type_y;
    p_fa_rec.pay_term          := :ar_pay_term_n;
    p_fa_rec.ask_say           := :fa_ask_say_y;
    --基本信息
    p_fa_rec.company_name          := :ar_company_name_y;
    p_fa_rec.company_abbreviation  := :ar_company_abbreviation_y;
    p_fa_rec.company_province      := :company_province;
    p_fa_rec.company_city          := :company_city;
    p_fa_rec.company_county        := :company_county;
    p_fa_rec.company_vill          := :ar_company_vill_y;
    p_fa_rec.company_address       := :ar_company_address_y;
    p_fa_rec.company_regist_date   := :ar_company_regist_date_y;
    p_fa_rec.legal_representative  := :ar_legal_representative_n;
    p_fa_rec.company_contact_phone := :ar_company_contact_phone_n;
    p_fa_rec.contact_name          := :ar_sapply_user_y;
    p_fa_rec.contact_phone         := :ar_sapply_phone_y;
    p_fa_rec.company_type          := :ar_company_type_y;
    p_fa_rec.brand_type            := :brand_type;
    p_fa_rec.cooperation_brand     := :cooperation_brand;
    p_fa_rec.product_link          := :ar_product_link_n;
    p_fa_rec.rela_supplier_id      := :ar_rela_supplier_id_n;
    p_fa_rec.is_our_factory        := :ar_is_our_factory_y;
    p_fa_rec.factory_name          := :ar_factory_name_y;
    p_fa_rec.factory_province      := :factory_province;
    p_fa_rec.factory_city          := :factory_city;
    p_fa_rec.factory_county        := :factory_county;
    p_fa_rec.factory_vill          := :ar_factory_vill_y;
    p_fa_rec.ask_address           := :ar_factroy_details_address_y;
    p_fa_rec.factroy_area          := :ar_factroy_area_y;
    p_fa_rec.remarks               := :ar_remarks_n;
    --生产信息
    p_fa_rec.product_line       := :ar_product_line_n;
    p_fa_rec.product_line_num   := :ar_product_line_num_n;
    p_fa_rec.quality_step       := :ar_quality_step_n;
    p_fa_rec.work_hours_day     := :ar_work_hours_day_y;
    p_fa_rec.machine_num        := :ar_machine_num_y;
    p_fa_rec.product_efficiency := :ar_product_efficiency_y;
    p_fa_rec.fabric_check_cap   := :ar_fabric_check_cap_n;
    --附件资料
    p_fa_rec.certificate_file  := :ar_certificate_file_y;
    p_fa_rec.supplier_gate     := :ar_supplier_gate_n;
    p_fa_rec.supplier_office   := :ar_supplier_office_n;
    p_fa_rec.supplier_site     := :ar_supplier_site_n;
    p_fa_rec.supplier_product  := :ar_supplier_product_n;
    p_fa_rec.ask_files         := :ar_other_information_n;
    --其他
    p_fa_rec.update_id   := :user_id;
    p_fa_rec.update_date := SYSDATE;

    scmdata.pkg_ask_record_mange.p_save_factory_ask(p_fa_rec => p_fa_rec);
  END;]'';
  ELSE
    v_sql := NULL;
  END IF;
  '|| CHR(64) ||'strresult := v_sql;
END;
}';
UPDATE bw3.sys_item_list t SET t.update_sql = v_update_sql WHERE t.item_id = 'a_coop_150_3'; 
END;
/
DECLARE
v_1 CLOB;
v_2 CLOB;
v_3 CLOB;
BEGIN
v_1 := q'[ar_company_name_y,ar_company_abbreviation_y,ar_social_credit_code_y,ar_company_area_y,ar_company_vill_y,ar_company_vill_desc_y,ar_company_address_y,ar_company_regist_date_y,ar_legal_representative_n,ar_company_contact_phone_n,ar_cooperation_type_y,ar_cooperation_model_y,ar_coop_model_desc_y,ar_company_type_y,ar_company_type_desc_y,ar_pay_term_n,ar_pay_term_desc_n,ar_product_type_y,ar_product_type_desc_y,ar_sapply_user_y,ar_sapply_phone_y,ar_coop_brand_desc_n,ar_product_link_n,ar_rela_supplier_id_y,ar_is_our_factory_y,ar_is_our_fac_desc_y,ar_factory_name_y,ar_factory_area_y,ar_factory_vill_y,ar_factory_vill_desc_y,ar_factroy_details_address_y,ar_factroy_area_y,ar_ask_say_n,ar_remarks_n]';
UPDATE bw3.sys_detail_group t SET t.clo_names = v_1 WHERE t.item_id = 'a_coop_151' AND t.group_name = '基本信息';
v_2 := q'[fa_check_person_desc_y,fa_dept_name_desc_y,fa_check_person_y,fa_check_dept_name_y,fa_ask_date_n,fa_is_urgent_n,fa_is_urgent_desc_n,ar_cooperation_type_y,ar_cooperation_model_y,ar_coop_model_desc_y,ar_coop_class_desc_n,ar_pay_term_n,ar_product_type_y,ar_product_type_desc_y,fa_ask_say_y]';
UPDATE bw3.sys_detail_group t SET t.clo_names = v_2 WHERE t.item_id = 'a_coop_150_3' AND t.group_name = '申请信息';
v_3 := q'[sp_sup_company_name_y,sp_sup_company_abb_y,sp_social_credit_code_y,sp_supplier_code_n,sp_inside_supplier_code_n,sp_company_regist_date_y,sp_location_area_y,ar_company_vill_y,ar_company_vill_desc_y,sp_company_address_y,sp_group_name_n,sp_legal_represent_n,sp_company_contact_phone_n,sp_contact_name_y,sp_contact_phone_y,sp_company_type_y,ar_is_our_factory_y,sp_factroy_area_y,sp_remarks_n,]';
UPDATE bw3.sys_detail_group t SET t.clo_names = v_2 WHERE t.item_id = 'a_supp_151' AND t.group_name = '基本信息';
END;
/
DECLARE
v_sql1 CLOB;
v_sql2 CLOB;
v_sql3 CLOB;
BEGIN
UPDATE bw3.sys_item_element_rela t SET t.pause = 1 WHERE t.item_id = 'a_supp_151' AND t.element_id IN ('look_a_supp_111_8','look_a_supp_111_5','look_a_supp_111_1'); 
END;
/
DECLARE
v_sql1 CLOB;
v_sql2 CLOB;
BEGIN
  v_sql1 := '{
DECLARE
  v_sup_id      VARCHAR2(32);
  v_rest_method VARCHAR2(256);
  v_params      VARCHAR2(256);
  v_sql         CLOB;
BEGIN
  --获取asscoiate请求参数
  pkg_plat_comm.p_get_rest_val_method_params(p_character     => :supplier_info_id,
                                             po_pk_id        => v_sup_id,
                                             po_rest_methods => v_rest_method,
                                             po_params       => v_params);

  IF v_rest_method IS NULL OR instr('';'' || v_rest_method || '';'', '';'' || ''POST'' || '';'') > 0 THEN
    v_sql := q''[--不考虑供应商是否已经在平台注册
DECLARE
  v_t_sup_rec scmdata.t_supplier_info%ROWTYPE;
  v_supply_id VARCHAR2(32);
  v_supp_company_id VARCHAR2(32);
BEGIN

  v_supply_id                         := :supplier_info_id;
  v_t_sup_rec.supplier_info_id        := v_supply_id;
  v_t_sup_rec.company_id              := %default_company_id%;
  v_t_sup_rec.supplier_info_origin    := ''MA'';
  v_t_sup_rec.supplier_info_origin_id := NULL;
  v_t_sup_rec.status                  := 0;
  --基本信息
  v_t_sup_rec.supplier_company_name         := :sp_sup_company_name_y; --公司名称
  v_t_sup_rec.supplier_company_abbreviation := :sp_sup_company_abb_y; --公司简称
  v_t_sup_rec.social_credit_code            := :sp_social_credit_code_y; --统一社会信用代码
  --v_t_sup_rec.supplier_code                 := :sp_supplier_code_n; --供应商编号
  v_t_sup_rec.inside_supplier_code  := :sp_inside_supplier_code_n; --内部供应商编号
  v_t_sup_rec.company_regist_date   := :sp_company_regist_date_y; --公司注册日期
  v_t_sup_rec.company_province      := :company_province; --公司省
  v_t_sup_rec.company_city          := :company_city; --公司市
  v_t_sup_rec.company_county        := :company_county; --公司区
  v_t_sup_rec.company_vill          := :ar_company_vill_y; --公司乡镇
  v_t_sup_rec.company_address       := :sp_company_address_y; --公司地址
  v_t_sup_rec.group_name            := :sp_group_name_n; --分组名称（v9.9版 存值改为分组ID）
  v_t_sup_rec.legal_representative  := :sp_legal_represent_n; --法定代表人
  v_t_sup_rec.company_contact_phone := :sp_company_contact_phone_n; --公司联系电话
  v_t_sup_rec.fa_contact_name       := :sp_contact_name_y; --业务联系人
  v_t_sup_rec.fa_contact_phone      := :sp_contact_phone_y; --业务联系人手机
  v_t_sup_rec.company_type          := :sp_company_type_y; --公司类型
  v_t_sup_rec.is_our_factory        := :ar_is_our_factory_y; --是否本厂
  v_t_sup_rec.factroy_area          := :sp_factroy_area_y; --工厂面积（m2）
  v_t_sup_rec.remarks               := :sp_remarks_n; --备注

  --生产信息
  v_t_sup_rec.product_type      := :sp_product_type_y; --生产类型
  v_t_sup_rec.brand_type        := :sp_brand_type_n; --合作品牌/客户 类型
  v_t_sup_rec.cooperation_brand := :cooperation_brand; --合作品牌/客户
  v_t_sup_rec.product_link      := :sp_product_link_n; --生产环节

  v_t_sup_rec.product_line        := :sp_product_line_n; --生产线类型
  v_t_sup_rec.product_line_num    := :sp_product_line_num_n; --生产线数量
  v_t_sup_rec.quality_step        := :sp_quality_step_y; --质量等级
  v_t_sup_rec.work_hours_day      := :sp_work_hours_day_y; --上班时数/天
  v_t_sup_rec.worker_total_num    := :sp_worker_total_num_y; --总人数
  v_t_sup_rec.worker_num          := :sp_worker_num_y; --车位人数
  v_t_sup_rec.machine_num         := :sp_machine_num_y; --织机台数
  v_t_sup_rec.form_num            := :sp_form_num_y; --成型人数_鞋类
  v_t_sup_rec.product_efficiency  := :sp_product_efficiency_y; --产能效率
  v_t_sup_rec.pattern_cap         := :sp_pattern_cap_y; --打版能力
  v_t_sup_rec.fabric_purchase_cap := :sp_fabric_purchase_cap_y; --面料采购能力
  v_t_sup_rec.fabric_check_cap    := :sp_fabric_check_cap_y; --面料检测能力

  --合作信息
  v_t_sup_rec.pause := :sp_coop_state_y; --状态：0 启用 1 停用 2 试单

  SELECT MAX(fc.company_id)
    INTO v_supp_company_id
    FROM scmdata.sys_company fc
   WHERE fc.company_id = %default_company_id%
     AND fc.licence_num = :sp_social_credit_code_y;

  v_t_sup_rec.supplier_company_id := v_supp_company_id; --供应商在平台的企业id
  v_t_sup_rec.cooperation_type    := :sp_cooperation_type_y; --合作类型
  v_t_sup_rec.cooperation_model   := replace(:sp_cooperation_model_y,'' '','';'');
  v_t_sup_rec.coop_position       := :sp_coop_position_n; --合作定位
  v_t_sup_rec.pay_term            := :ar_pay_term_n; --付款条件

  --附件资料
  v_t_sup_rec.certificate_file  := :sp_certificate_file_y; --上传营业执照
  v_t_sup_rec.supplier_gate     := :sp_supplier_gate_n; --公司大门附件地址
  v_t_sup_rec.supplier_office   := :sp_supplier_office_n; --公司办公室附件地址
  v_t_sup_rec.supplier_site     := :sp_supplier_site_n; --生产现场附件地址
  v_t_sup_rec.supplier_product  := :sp_supplier_product_n; --产品图片附件地址
  v_t_sup_rec.other_information := :sp_other_information_n; --其他资料

  --其它
  v_t_sup_rec.create_id   := :user_id;
  v_t_sup_rec.create_date := SYSDATE;
  v_t_sup_rec.update_id   := :user_id; --修改人ID
  v_t_sup_rec.update_date := SYSDATE; --修改时间

  --1.新增 => 保存，校验数据
  scmdata.pkg_supplier_info.p_check_save_t_supplier_info(p_sp_data => v_t_sup_rec);
  --2.插入数据
  scmdata.pkg_supplier_info.p_insert_supplier_info(p_sp_data => v_t_sup_rec);
  --3.同步人员机器配置
  scmdata.pkg_supplier_info_a.p_generate_person_machine_config(p_company_id => %default_company_id%,p_user_id => :user_id,p_sup_id => v_supply_id);
END;
]'';
  ELSE
    v_sql := NULL;
  END IF;
  '|| CHR(64) ||'strresult := v_sql;
END;
}';
  v_sql2 := '--update sql by czh55 2023-01-10 02:54:52
{
DECLARE
  v_pk_id       VARCHAR2(32);
  v_rest_method VARCHAR2(256);
  v_params      VARCHAR2(256);
  v_sql         CLOB;
BEGIN
  --获取asscoiate请求参数
  pkg_plat_comm.p_get_rest_val_method_params(p_character     => NVL(%supplier_info_id%,:supplier_info_id),
                                             po_pk_id        => v_pk_id,
                                             po_rest_methods => v_rest_method,
                                             po_params       => v_params);

  IF v_rest_method IS NULL OR instr('';'' || v_rest_method || '';'', '';'' || ''PUT'' || '';'') > 0 THEN
    v_sql := q''[
    DECLARE
      v_t_sup_rec       scmdata.t_supplier_info%ROWTYPE;
      v_supp_company_id VARCHAR2(32);
      v_supp_id         VARCHAR2(32) := '']'' || v_pk_id || q''[''; --主键
    BEGIN
      v_t_sup_rec.supplier_info_id := v_supp_id; --主键
      v_t_sup_rec.company_id       := %default_company_id%; --公司编码
      --基本信息
      v_t_sup_rec.supplier_company_name         := :sp_sup_company_name_y; --公司名称
      v_t_sup_rec.supplier_company_abbreviation := :sp_sup_company_abb_y; --公司简称
      v_t_sup_rec.social_credit_code            := :sp_social_credit_code_y; --统一社会信用代码
      --v_t_sup_rec.supplier_code                 := :sp_supplier_code_n; --供应商编号
      v_t_sup_rec.inside_supplier_code  := :sp_inside_supplier_code_n; --内部供应商编号
      v_t_sup_rec.company_regist_date   := :sp_company_regist_date_y; --公司注册日期
      v_t_sup_rec.company_province      := :company_province; --公司省
      v_t_sup_rec.company_city          := :company_city; --公司市
      v_t_sup_rec.company_county        := :company_county; --公司区
      v_t_sup_rec.company_vill          := :ar_company_vill_y; --公司乡镇
      v_t_sup_rec.company_address       := :sp_company_address_y; --公司地址
      v_t_sup_rec.group_name            := :sp_group_name_n; --分组名称（v9.9版 存值改为分组ID）
      v_t_sup_rec.legal_representative  := :sp_legal_represent_n; --法定代表人
      v_t_sup_rec.company_contact_phone := :sp_company_contact_phone_n; --公司联系电话
      v_t_sup_rec.fa_contact_name       := :sp_contact_name_y; --业务联系人
      v_t_sup_rec.fa_contact_phone      := :sp_contact_phone_y; --业务联系人手机
      v_t_sup_rec.company_type          := :sp_company_type_y; --公司类型
      v_t_sup_rec.is_our_factory        := :ar_is_our_factory_y; --是否本厂
      v_t_sup_rec.factroy_area          := :sp_factroy_area_y; --工厂面积（m2）
      v_t_sup_rec.remarks               := :sp_remarks_n; --备注

      --生产信息
      v_t_sup_rec.product_type      := :sp_product_type_y; --生产类型
      v_t_sup_rec.brand_type        := :sp_brand_type_n; --合作品牌/客户 类型
      v_t_sup_rec.cooperation_brand := :cooperation_brand; --合作品牌/客户
      v_t_sup_rec.product_link      := :sp_product_link_n; --生产环节

      v_t_sup_rec.product_line        := :sp_product_line_n; --生产线类型
      v_t_sup_rec.product_line_num    := :sp_product_line_num_n; --生产线数量
      v_t_sup_rec.quality_step        := :sp_quality_step_y; --质量等级
      v_t_sup_rec.work_hours_day      := :sp_work_hours_day_y; --上班时数/天
      v_t_sup_rec.worker_total_num    := :sp_worker_total_num_y; --总人数
      v_t_sup_rec.worker_num          := :sp_worker_num_y; --车位人数
      v_t_sup_rec.machine_num         := :sp_machine_num_y; --织机台数
      v_t_sup_rec.form_num            := :sp_form_num_y; --成型人数_鞋类
      v_t_sup_rec.product_efficiency  := :sp_product_efficiency_y; --产能效率
      v_t_sup_rec.pattern_cap         := :sp_pattern_cap_y; --打版能力
      v_t_sup_rec.fabric_purchase_cap := :sp_fabric_purchase_cap_y; --面料采购能力
      v_t_sup_rec.fabric_check_cap    := :sp_fabric_check_cap_y; --面料检测能力

      --合作信息
      v_t_sup_rec.pause := :sp_coop_state_y; --状态：0 启用 1 停用 2 试单

      SELECT MAX(fc.company_id)
        INTO v_supp_company_id
        FROM scmdata.sys_company fc
       WHERE fc.company_id = %default_company_id%
         AND fc.licence_num = :sp_social_credit_code_y;

      v_t_sup_rec.supplier_company_id := v_supp_company_id; --供应商在平台的企业id
      v_t_sup_rec.cooperation_type    := :sp_cooperation_type_y; --合作类型
      v_t_sup_rec.cooperation_model   := replace(:sp_cooperation_model_y,'' '','';''); --合作模式
      v_t_sup_rec.coop_position       := :sp_coop_position_n; --合作定位
      v_t_sup_rec.pay_term            := :ar_pay_term_n; --付款条件

      --附件资料
      v_t_sup_rec.certificate_file  := :sp_certificate_file_y; --上传营业执照
      v_t_sup_rec.supplier_gate     := :sp_supplier_gate_n; --公司大门附件地址
      v_t_sup_rec.supplier_office   := :sp_supplier_office_n; --公司办公室附件地址
      v_t_sup_rec.supplier_site     := :sp_supplier_site_n; --生产现场附件地址
      v_t_sup_rec.supplier_product  := :sp_supplier_product_n; --产品图片附件地址
      v_t_sup_rec.other_information := :sp_other_information_n; --其他资料

      --其它
      v_t_sup_rec.update_id   := :user_id; --修改人ID
      v_t_sup_rec.update_date := SYSDATE; --修改时间

      --修改 t_supplier_info
      --1.更新=》保存，校验数据
      pkg_supplier_info.p_update_supplier_info(p_sp_data => v_t_sup_rec);
      --2.更新所在区域
      pkg_supplier_info.p_update_group_name(p_company_id       => %default_company_id%,
                                            p_supplier_info_id => v_supp_id,
                                            p_is_by_pick       => 1,
                                            p_province         => :company_province,
                                            p_city             => :company_city);
    END update_supp_info;]'';
  ELSE
    v_sql := NULL;
  END IF;
  '|| CHR(64) ||'strresult := v_sql;
END;
}';
UPDATE bw3.sys_item_list t SET t.insert_sql = v_sql1,t.update_sql = v_sql2 WHERE t.item_id = 'a_supp_151';
END;
/
DECLARE
v_1 CLOB;
v_2 CLOB;
v_3 CLOB;
BEGIN
v_1 := q'[sp_coop_state_y,sp_regist_status_n,sp_bind_status_n,sp_cooperation_type_y,sp_cooperation_model_y,sp_coop_model_desc_y,sp_coop_position_n,ar_pay_term_n]';
UPDATE bw3.sys_detail_group t SET t.clo_names = v_1 WHERE t.item_id = 'a_supp_151' AND t.group_name = '合作信息';
v_2 := q'[sp_sup_company_name_y,sp_sup_company_abb_y,sp_social_credit_code_y,sp_supplier_code_n,sp_inside_supplier_code_n,sp_company_regist_date_y,sp_location_area_y,ar_company_vill_y,ar_company_vill_desc_y,sp_company_address_y,sp_group_name_n,sp_legal_represent_n,sp_company_contact_phone_n,sp_contact_name_y,sp_contact_phone_y,sp_company_type_y,sp_company_type_desc_y,ar_is_our_factory_y,sp_factroy_area_y,sp_remarks_n]';
UPDATE bw3.sys_detail_group t SET t.clo_names = v_2 WHERE t.item_id = 'a_supp_151' AND t.group_name = '基本信息';

v_3 := q'[sp_product_type_y,sp_product_type_desc_y,brand_type,cooperation_brand,sp_coop_brand_desc_n,sp_product_link_n,sp_product_line_n,sp_product_line_num_n,sp_quality_step_y,sp_work_hours_day_y,sp_worker_total_num_y,sp_worker_num_y,sp_machine_num_y,sp_form_num_y,sp_product_efficiency_y,sp_pattern_cap_y,sp_fabric_purchase_cap_y,sp_fabric_check_cap_y]';
UPDATE bw3.sys_detail_group t SET t.clo_names = v_3 WHERE t.item_id = 'a_supp_151' AND t.group_name = '生产信息';
UPDATE bw3.sys_item_element_rela t SET t.pause = 1 WHERE t.element_id = 'associate_a_supp_110_3'; 
UPDATE bw3.sys_field_list t SET t.requiered_flag = 0 WHERE t.field_name IN ('SP_QUALITY_STEP_Y','SP_FABRIC_CHECK_CAP_Y','SP_QUALITY_STEP_DESC_Y','SP_FABRIC_CHECK_CAP_DESC_Y');
UPDATE bw3.sys_tree_list t SET t.pause = 1 WHERE t.node_id IN ('node_a_coop_312_320','node_a_coop_311_320');
END;
/
DECLARE
v_sql1 CLOB;
v_sql2 CLOB;
v_sql3 CLOB;
v_sql4 CLOB;
BEGIN
  v_sql1 := '--czh 20221103 v9.10
{DECLARE
  v_sql         CLOB;
  v_object_id VARCHAR2(32);
  v_rest_method   VARCHAR2(256);
  v_params        VARCHAR2(2000);
BEGIN
  --获取asscoiate请求参数
  pkg_plat_comm.p_get_rest_val_method_params(p_character     => %ass_ask_record_id%,
                                             po_pk_id        => v_object_id,
                                             po_rest_methods => v_rest_method,
                                             po_params       => v_params);
  v_rest_method := nvl(v_rest_method, ''GET'');
  IF instr('';'' || v_rest_method || '';'', '';'' || ''GET'' || '';'') > 0 THEN
    v_sql := pkg_ask_record_mange.f_query_t_ask_scope(p_object_id => :factory_ask_id);
  ELSE
    v_sql := NULL;
  END IF;
  '|| CHR(64) ||'strresult := v_sql;
END;}';

v_sql2 := '--czh 20221103 v9.10
{DECLARE
  v_sql         CLOB;
  v_ask_record_id VARCHAR2(32);
  v_rest_method   VARCHAR2(256);
  v_params        VARCHAR2(2000);
BEGIN
  --获取asscoiate请求参数
  pkg_plat_comm.p_get_rest_val_method_params(p_character     => %ass_ask_record_id%,
                                             po_pk_id        => v_ask_record_id,
                                             po_rest_methods => v_rest_method,
                                             po_params       => v_params);
  v_rest_method := nvl(v_rest_method, ''POST'');
  IF :factory_ask_id IS NULL AND instr('';'' || v_rest_method || '';'', '';'' || ''POST'' || '';'') > 0 THEN
    --v_ask_record_id := nvl(v_ask_record_id,:ask_record_id);
    v_sql := q''[DECLARE
  v_t_ask_rec scmdata.t_ask_scope%ROWTYPE;
  v_ask_record_id VARCHAR2(32) := nvl('']''|| v_ask_record_id || q''['',:ask_record_id);
BEGIN
  scmdata.pkg_ask_record_mange.check_repeat_scope(pi_ask_scope_id               => '' '',
                                                  pi_object_id                  => :factory_ask_id,
                                                  pi_object_type                => ''CA'',
                                                  pi_cooperation_classification => :cooperation_classification,
                                                  pi_cooperation_product_cate   => :cooperation_product_cate,
                                                  pi_cooperation_type           => :cooperation_type);

  v_t_ask_rec.ask_scope_id               := scmdata.f_get_uuid();
  v_t_ask_rec.company_id                 := %default_company_id%;
  v_t_ask_rec.object_id                  := :factory_ask_id;
  v_t_ask_rec.object_type                := ''CA'';
  v_t_ask_rec.cooperation_type           := :cooperation_type;
  v_t_ask_rec.cooperation_classification := :cooperation_classification;
  v_t_ask_rec.cooperation_product_cate   := :cooperation_product_cate;
  v_t_ask_rec.cooperation_subcategory    := :cooperation_subcategory;
  v_t_ask_rec.be_company_id              := %default_company_id%;
  v_t_ask_rec.update_time                := SYSDATE;
  v_t_ask_rec.update_id                  := :user_id;
  v_t_ask_rec.create_id                  := :user_id;
  v_t_ask_rec.create_time                := SYSDATE;
  v_t_ask_rec.remarks                    := NULL;
  v_t_ask_rec.pause                      := 0;

  scmdata.pkg_ask_record_mange.p_insert_t_ask_scope(p_t_ask_rec => v_t_ask_rec);
END;]'';
  ELSE
    v_sql := NULL;
  END IF;
  '|| CHR(64) ||'strresult := v_sql;
END;}';

v_sql3 := '--czh 20221103 v9.10
{DECLARE
  v_sql         CLOB;
  v_ask_record_id VARCHAR2(32);
  v_rest_method   VARCHAR2(256);
  v_params        VARCHAR2(2000);
BEGIN
  --获取asscoiate请求参数
  pkg_plat_comm.p_get_rest_val_method_params(p_character     => %ass_ask_record_id%,
                                             po_pk_id        => v_ask_record_id,
                                             po_rest_methods => v_rest_method,
                                             po_params       => v_params);
  v_rest_method := nvl(v_rest_method, ''PUT'');
  IF :factory_ask_id IS NULL AND instr('';'' || v_rest_method || '';'', '';'' || ''PUT'' || '';'') > 0 THEN
    --v_ask_record_id := nvl(v_ask_record_id,:ask_record_id);
    v_sql := q''[DECLARE
  v_t_ask_rec     scmdata.t_ask_scope%ROWTYPE;
  v_ask_record_id VARCHAR2(32) := nvl('']''|| v_ask_record_id || q''['',:ask_record_id);
BEGIN
  scmdata.pkg_ask_record_mange.check_repeat_scope(pi_ask_scope_id               => :ask_scope_id,
                                                  pi_object_id                  => :factory_ask_id,
                                                  pi_object_type                => ''CA'',
                                                  pi_cooperation_classification => :cooperation_classification,
                                                  pi_cooperation_product_cate   => :cooperation_product_cate,
                                                  pi_cooperation_type           => :cooperation_type);

  v_t_ask_rec.ask_scope_id               := :ask_scope_id;
  v_t_ask_rec.cooperation_classification := :cooperation_classification;
  v_t_ask_rec.cooperation_product_cate   := :cooperation_product_cate;
  v_t_ask_rec.cooperation_subcategory    := :cooperation_subcategory;
  v_t_ask_rec.update_time                := SYSDATE;
  v_t_ask_rec.update_id                  := :user_id;

  scmdata.pkg_ask_record_mange.p_update_t_ask_scope(p_t_ask_rec => v_t_ask_rec);
END;]'';
  ELSE
    v_sql := NULL;
  END IF;
  '|| CHR(64) ||'strresult := v_sql;
END;}';

v_sql4 := '--czh 20221103 v9.10
{DECLARE
  v_sql         CLOB;
  v_ask_record_id VARCHAR2(32);
  v_rest_method   VARCHAR2(256);
  v_params        VARCHAR2(2000);
BEGIN
  --获取asscoiate请求参数
  pkg_plat_comm.p_get_rest_val_method_params(p_character     => %ass_ask_record_id%,
                                             po_pk_id        => v_ask_record_id,
                                             po_rest_methods => v_rest_method,
                                             po_params       => v_params);
  v_rest_method := nvl(v_rest_method, ''DELETE'');
  IF :factory_ask_id IS NULL AND instr('';'' || v_rest_method || '';'', '';'' || ''DELETE'' || '';'') > 0 THEN
    v_sql := q''[DECLARE
  v_t_ask_rec scmdata.t_ask_scope%ROWTYPE;
BEGIN
  v_t_ask_rec.ask_scope_id := :ask_scope_id;
  scmdata.pkg_ask_record_mange.p_delete_t_ask_scope(p_t_ask_rec => v_t_ask_rec);
END;]'';
  ELSE
    v_sql := NULL;
  END IF;
  '|| CHR(64) ||'strresult := v_sql;
END;}';

UPDATE bw3.sys_item_list t
   SET t.select_sql = v_sql1,
       t.insert_sql = v_sql2,
       t.update_sql = v_sql3,
       t.delete_sql = v_sql4
 WHERE t.item_id = 'a_coop_159_1';
END;
/
DECLARE
v_sql CLOB;
BEGIN
v_sql := '--czh 20221103 v9.10
{
DECLARE
  v_sql            CLOB;
  v_ask_record_id  VARCHAR2(32);
  v_factory_ask_id VARCHAR2(32);
  v_rest_method    VARCHAR2(256);
  v_params         VARCHAR2(2000);
  v_item_id        VARCHAR(256);
  v_flow_status    VARCHAR2(256);
BEGIN
  --获取asscoiate请求参数
  pkg_plat_comm.p_get_rest_val_method_params(p_character     => %ass_ask_record_id%,
                                             po_pk_id        => v_ask_record_id,
                                             po_rest_methods => v_rest_method,
                                             po_params       => v_params);
     --因验厂申请页面（待审批，已审批 获取不了%ass_ask_record_id%）
     --做特殊处理                                      
     SELECT MAX(t.factrory_ask_flow_status)
       INTO v_flow_status
       FROM scmdata.t_factory_ask t
      WHERE t.factory_ask_id = :factory_ask_id;
     
  IF v_flow_status IN (''FA01'',''FA02'') OR instr('';'' || v_rest_method || '';'', '';'' || ''PUT'' || '';'') > 0 THEN    
      SELECT MAX(t.factory_ask_id)
        INTO v_factory_ask_id
        FROM scmdata.t_factory_ask t
       WHERE t.ask_record_id = v_ask_record_id
         AND t.company_id = %default_company_id%
       ORDER BY t.create_date DESC;
    v_factory_ask_id := NVL(v_factory_ask_id,:factory_ask_id);
    v_sql := q''[DECLARE
    p_fa_rec         scmdata.t_factory_ask%ROWTYPE;
    v_factory_ask_id VARCHAR2(32) := '']'' || v_factory_ask_id || q''['';
  BEGIN
    p_fa_rec.factory_ask_id := v_factory_ask_id;
    p_fa_rec.company_id := :company_id;
    --申请信息
    p_fa_rec.ask_user_id       := :fa_check_person_y;
    p_fa_rec.ask_user_dept_id  := :fa_check_dept_name_y;
    p_fa_rec.is_urgent         := :fa_is_urgent_n;
    p_fa_rec.cooperation_model := replace(:ar_cooperation_model_y,'' '','';'');
    p_fa_rec.product_type      := :ar_product_type_y;
    p_fa_rec.pay_term          := :ar_pay_term_n;
    p_fa_rec.ask_say           := :fa_ask_say_y;
    --基本信息
    p_fa_rec.company_name          := :ar_company_name_y;
    p_fa_rec.company_abbreviation  := :ar_company_abbreviation_y;
    p_fa_rec.company_province      := :company_province;
    p_fa_rec.company_city          := :company_city;
    p_fa_rec.company_county        := :company_county;
    p_fa_rec.company_vill          := :ar_company_vill_y;
    p_fa_rec.company_address       := :ar_company_address_y;
    p_fa_rec.company_regist_date   := :ar_company_regist_date_y;
    p_fa_rec.legal_representative  := :ar_legal_representative_n;
    p_fa_rec.company_contact_phone := :ar_company_contact_phone_n;
    p_fa_rec.contact_name          := :ar_sapply_user_y;
    p_fa_rec.contact_phone         := :ar_sapply_phone_y;
    p_fa_rec.company_type          := :ar_company_type_y;
    p_fa_rec.brand_type            := :brand_type;
    p_fa_rec.cooperation_brand     := :cooperation_brand;
    p_fa_rec.product_link          := :ar_product_link_n;
    p_fa_rec.rela_supplier_id      := :ar_rela_supplier_id_n;
    p_fa_rec.is_our_factory        := :ar_is_our_factory_y;
    p_fa_rec.factory_name          := :ar_factory_name_y;
    p_fa_rec.factory_province      := :factory_province;
    p_fa_rec.factory_city          := :factory_city;
    p_fa_rec.factory_county        := :factory_county;
    p_fa_rec.factory_vill          := :ar_factory_vill_y;
    p_fa_rec.ask_address           := :ar_factroy_details_address_y;
    p_fa_rec.factroy_area          := :ar_factroy_area_y;
    p_fa_rec.remarks               := :ar_remarks_n;
    --生产信息
    p_fa_rec.product_line       := :ar_product_line_n;
    p_fa_rec.product_line_num   := :ar_product_line_num_n;
    p_fa_rec.quality_step       := :ar_quality_step_n;
    p_fa_rec.work_hours_day     := :ar_work_hours_day_y;
    p_fa_rec.machine_num        := :ar_machine_num_y;
    p_fa_rec.product_efficiency := :ar_product_efficiency_y;
    p_fa_rec.fabric_check_cap   := :ar_fabric_check_cap_n;
    --附件资料
    p_fa_rec.certificate_file  := :ar_certificate_file_y;
    p_fa_rec.supplier_gate     := :ar_supplier_gate_n;
    p_fa_rec.supplier_office   := :ar_supplier_office_n;
    p_fa_rec.supplier_site     := :ar_supplier_site_n;
    p_fa_rec.supplier_product  := :ar_supplier_product_n;
    p_fa_rec.ask_files         := :ar_other_information_n;
    --其他
    p_fa_rec.update_id   := :user_id;
    p_fa_rec.update_date := SYSDATE;

    scmdata.pkg_ask_record_mange.p_save_factory_ask(p_fa_rec => p_fa_rec);
  END;]'';
  ELSE
    v_sql := NULL;
  END IF;
  '|| CHR(64) ||'strresult := v_sql;
END;
}';
UPDATE bw3.sys_item_list t SET t.update_sql = v_sql WHERE t.item_id = 'a_coop_150_3';
END;
/
DECLARE
v_sql1 CLOB;
v_sql2 CLOB;
BEGIN
v_sql1 := '--czh 20221103 v9.10
{
DECLARE
  v_sql         CLOB;
  v_ask_record_id VARCHAR2(32);
  v_rest_method   VARCHAR2(256);
  v_params        VARCHAR2(2000);
BEGIN
  --获取asscoiate请求参数
  pkg_plat_comm.p_get_rest_val_method_params(p_character     => %ass_ask_record_id%,
                                             po_pk_id        => v_ask_record_id,
                                             po_rest_methods => v_rest_method,
                                             po_params       => v_params);
  v_rest_method := nvl(v_rest_method, ''POST'');
  IF :factory_ask_id IS NULL AND instr('';'' || v_rest_method || '';'', '';'' || ''POST'' || '';'') > 0 THEN
    v_sql := q''[
DECLARE
  v_t_mac_rec t_machine_equipment_fa%ROWTYPE;
  v_seqno     INT;
BEGIN
  v_t_mac_rec.machine_equipment_id  := scmdata.f_get_uuid();
  v_t_mac_rec.company_id            := %default_company_id%;
  v_t_mac_rec.equipment_category_id := :ar_equipment_cate_n;
  v_t_mac_rec.equipment_name        := :ar_equipment_name_y;
  v_t_mac_rec.machine_num           := nvl(:ar_machine_num_n,0);

  SELECT nvl(MAX(t.seqno), 0) + 1
    INTO v_seqno
    FROM scmdata.t_machine_equipment_fa t
   WHERE t.factory_ask_id  = :factory_ask_id
     AND t.company_id = %default_company_id%;

  v_t_mac_rec.seqno         := v_seqno;
  v_t_mac_rec.orgin         := ''MA'';
  v_t_mac_rec.pause         := 0;
  v_t_mac_rec.remarks       := :remarks;
  v_t_mac_rec.update_id     := :user_id;
  v_t_mac_rec.update_time   := SYSDATE;
  v_t_mac_rec.create_id     := :user_id;
  v_t_mac_rec.create_time   := SYSDATE;
  v_t_mac_rec.factory_ask_id := :factory_ask_id;
  
  pkg_ask_record_mange_a.p_check_t_machine_equipment_fa(p_t_mac_rec => v_t_mac_rec);
  pkg_ask_record_mange_a.p_insert_t_machine_equipment_fa(p_t_mac_rec => v_t_mac_rec);
END;
]'';
  ELSE
    v_sql := NULL;
  END IF;
  '|| CHR(64) ||'strresult := v_sql;
END;
}';
v_sql2 := '--czh 20221103 v9.10
{
DECLARE
  v_sql         CLOB;
  v_ask_record_id VARCHAR2(32);
  v_rest_method   VARCHAR2(256);
  v_params        VARCHAR2(2000);
BEGIN
  --获取asscoiate请求参数
  pkg_plat_comm.p_get_rest_val_method_params(p_character     => %ass_ask_record_id%,
                                             po_pk_id        => v_ask_record_id,
                                             po_rest_methods => v_rest_method,
                                             po_params       => v_params);
  v_rest_method := nvl(v_rest_method, ''PUT'');
  IF :factory_ask_id IS NULL AND instr('';'' || v_rest_method || '';'', '';'' || ''PUT'' || '';'') > 0 THEN
    v_sql := q''[
DECLARE
  v_t_mac_rec t_machine_equipment_fa%ROWTYPE;
  v_seqno     INT;
BEGIN
  v_t_mac_rec.machine_equipment_id  := :machine_equipment_id;
  v_t_mac_rec.equipment_category_id := :ar_equipment_cate_n;
  v_t_mac_rec.equipment_name        := :ar_equipment_name_y;
  v_t_mac_rec.machine_num   := nvl(:ar_machine_num_n,0);
  v_t_mac_rec.remarks       := :remarks;
  v_t_mac_rec.update_id     := :user_id;
  v_t_mac_rec.update_time   := SYSDATE;
  v_t_mac_rec.factory_ask_id := :factory_ask_id;
  pkg_ask_record_mange_a.p_check_t_machine_equipment_fa(p_t_mac_rec => v_t_mac_rec);
  pkg_ask_record_mange_a.p_update_t_machine_equipment_fa(p_t_mac_rec => v_t_mac_rec);
END;
]'';
  ELSE
    v_sql := NULL;
  END IF;
  '|| CHR(64) ||'strresult := v_sql;
END;
}';

UPDATE bw3.sys_item_list t SET t.insert_sql = v_sql1,t.update_sql = v_sql2 WHERE t.item_id = 'a_coop_150_3_2';
END;
/
DECLARE
v_sql1 CLOB;
v_sql2 CLOB;
v_sql3 CLOB;
v_sql4 CLOB;
BEGIN
  v_sql1 := '--czh 20221103 v9.10
{
DECLARE
  v_sql         CLOB;
  v_ask_record_id VARCHAR2(32);
  v_rest_method   VARCHAR2(256);
  v_params        VARCHAR2(2000);
BEGIN
  --获取asscoiate请求参数
  pkg_plat_comm.p_get_rest_val_method_params(p_character     => %ass_ask_record_id%,
                                             po_pk_id        => v_ask_record_id,
                                             po_rest_methods => v_rest_method,
                                             po_params       => v_params);
  v_rest_method := nvl(v_rest_method, ''POST'');
  IF instr('';'' || v_rest_method || '';'', '';'' || ''POST'' || '';'') > 0 THEN
    v_sql := q''[
DECLARE
  v_t_mac_rec t_machine_equipment_hz%ROWTYPE;
  v_ask_record_id VARCHAR2(32) := nvl('']'' || v_ask_record_id || q''['',:ask_record_id);
  v_seqno     INT;
BEGIN
  v_t_mac_rec.machine_equipment_id  := scmdata.f_get_uuid();
  v_t_mac_rec.company_id            := %default_company_id%;
  v_t_mac_rec.equipment_category_id := :ar_equipment_cate_n;
  v_t_mac_rec.equipment_name        := :ar_equipment_name_y;
  v_t_mac_rec.machine_num           := nvl(:ar_machine_num_n,0);

  SELECT nvl(MAX(t.seqno), 0) + 1
    INTO v_seqno
    FROM scmdata.t_machine_equipment_hz t
   WHERE t.ask_record_id = v_ask_record_id
     AND t.company_id = %default_company_id%;

  v_t_mac_rec.seqno         := v_seqno;
  v_t_mac_rec.orgin         := ''MA'';
  v_t_mac_rec.pause         := 0;
  v_t_mac_rec.remarks       := :remarks;
  v_t_mac_rec.update_id     := :user_id;
  v_t_mac_rec.update_time   := SYSDATE;
  v_t_mac_rec.create_id     := :user_id;
  v_t_mac_rec.create_time   := SYSDATE;
  v_t_mac_rec.ask_record_id := v_ask_record_id;
  
  pkg_ask_record_mange.p_check_t_machine_equipment_hz(p_t_mac_rec => v_t_mac_rec);
  pkg_ask_record_mange.p_insert_t_machine_equipment_hz(p_t_mac_rec => v_t_mac_rec);
END;
]'';
  ELSE
    v_sql := NULL;
  END IF;
  '|| CHR(64) ||'strresult := v_sql;
END;
}';
  v_sql2 := '--czh 20221103 v9.10
{
DECLARE
  v_sql         CLOB;
  v_ask_record_id VARCHAR2(32);
  v_rest_method   VARCHAR2(256);
  v_params        VARCHAR2(2000);
BEGIN
  --获取asscoiate请求参数
  pkg_plat_comm.p_get_rest_val_method_params(p_character     => %ass_ask_record_id%,
                                             po_pk_id        => v_ask_record_id,
                                             po_rest_methods => v_rest_method,
                                             po_params       => v_params);
  v_rest_method := nvl(v_rest_method, ''PUT'');
  IF instr('';'' || v_rest_method || '';'', '';'' || ''PUT'' || '';'') > 0 THEN
    v_sql := q''[
DECLARE
  v_t_mac_rec t_machine_equipment_hz%ROWTYPE;
  v_ask_record_id VARCHAR2(32) := nvl('']'' || v_ask_record_id || q''['',:ask_record_id);
  v_seqno     INT;
BEGIN
  v_t_mac_rec.machine_equipment_id  := :machine_equipment_id;
  v_t_mac_rec.equipment_category_id := :ar_equipment_cate_n;
  v_t_mac_rec.equipment_name        := :ar_equipment_name_y;
  v_t_mac_rec.machine_num   := nvl(:ar_machine_num_n,0);
  v_t_mac_rec.remarks       := :remarks;
  v_t_mac_rec.update_id     := :user_id;
  v_t_mac_rec.update_time   := SYSDATE;
  v_t_mac_rec.ask_record_id := v_ask_record_id;
  
  pkg_ask_record_mange.p_check_t_machine_equipment_hz(p_t_mac_rec => v_t_mac_rec);
  pkg_ask_record_mange.p_update_t_machine_equipment_hz(p_t_mac_rec => v_t_mac_rec);
END;
]'';
  ELSE
    v_sql := NULL;
  END IF;
  '|| CHR(64) ||'strresult := v_sql;
END;
}';
UPDATE bw3.sys_item_list t SET t.insert_sql = v_sql1,t.update_sql = v_sql2 WHERE t.item_id = 'a_coop_151_2';
  v_sql3 := '--insert sql by czh55 2023-01-03 06:02:59
{
DECLARE
  v_pk_id       VARCHAR2(32);
  v_rest_method VARCHAR2(256);
  v_params      VARCHAR2(256);
  v_sql         CLOB;
BEGIN
  --获取asscoiate请求参数
  pkg_plat_comm.p_get_rest_val_method_params(p_character     => %ass_supplier_info_id%,
                                             po_pk_id        => v_pk_id,
                                             po_rest_methods => v_rest_method,
                                             po_params       => v_params);

  IF v_rest_method IS NULL OR instr('';'' || v_rest_method || '';'', '';'' || ''POST'' || '';'') > 0 THEN
   v_sql := q''[
    DECLARE
      v_t_mac_rec t_machine_equipment_sup%ROWTYPE;
      v_pk_id VARCHAR2(32) := NVL('']'' || v_pk_id || q''['',:supplier_info_id);
      v_seqno     INT;
    BEGIN
      v_t_mac_rec.machine_equipment_id  := scmdata.f_get_uuid(); --机器设备(供应商档案)主键ID
      v_t_mac_rec.company_id            := %default_company_id%; --企业ID
      v_t_mac_rec.equipment_category_id := :ar_equipment_cate_n; --设备分类ID
      v_t_mac_rec.equipment_name        := :ar_equipment_name_y; --设备名称
      SELECT nvl(MAX(t.seqno), 0) + 1
        INTO v_seqno
      FROM scmdata.t_machine_equipment_sup t
     WHERE t.supplier_info_id = v_pk_id
       AND t.company_id = %default_company_id%;
      v_t_mac_rec.seqno                 := v_seqno; --序号
      v_t_mac_rec.orgin                 := ''MA''; --来源
      v_t_mac_rec.pause                 := 0; --是否禁用(0正常,1禁用)
      v_t_mac_rec.remarks               := :remarks; --备注
      v_t_mac_rec.update_id             := :user_id; --更新人
      v_t_mac_rec.update_time           := SYSDATE; --更新时间
      v_t_mac_rec.create_id             := :user_id; --创建人
      v_t_mac_rec.create_time           := SYSDATE; --创建时间
      v_t_mac_rec.supplier_info_id      := v_pk_id; --供应商档案ID
      v_t_mac_rec.machine_num           := nvl(:ar_machine_num_n,0); --设备数量
      
      scmdata.pkg_supplier_info_a.p_check_t_machine_equipment_sup(p_t_mac_rec => v_t_mac_rec);
      --新增 t_machine_equipment_sup
      scmdata.pkg_supplier_info_a.p_insert_t_machine_equipment_sup(p_t_mac_rec => v_t_mac_rec);
    END;]'';
  ELSE
    v_sql := NULL;
  END IF;
  '|| CHR(64) ||'strresult := v_sql;
END;
}';
  v_sql4 := '--update sql by czh55 2023-01-03 06:02:59
{
DECLARE
  v_sql           CLOB;
  v_supp_id       VARCHAR2(32);
  v_rest_method   VARCHAR2(256);
  v_params        VARCHAR2(2000);
BEGIN
  --获取asscoiate请求参数
  pkg_plat_comm.p_get_rest_val_method_params(p_character     => %ass_supplier_info_id%,
                                             po_pk_id        => v_supp_id,
                                             po_rest_methods => v_rest_method,
                                             po_params       => v_params);
  v_rest_method := nvl(v_rest_method, ''PUT'');
  IF v_rest_method IS NULL OR instr('';'' || v_rest_method || '';'', '';'' || ''PUT'' || '';'') > 0 THEN
    v_sql := q''[
DECLARE
  v_t_mac_rec t_machine_equipment_sup%ROWTYPE;
  v_supp_id VARCHAR2(32) := NVL('']'' || v_supp_id || q''['',:supplier_info_id);
BEGIN
  v_t_mac_rec.machine_equipment_id  := :machine_equipment_id;
  v_t_mac_rec.equipment_category_id := :ar_equipment_cate_n;
  v_t_mac_rec.equipment_name        := :ar_equipment_name_y;
  v_t_mac_rec.machine_num           := nvl(:ar_machine_num_n,0);
  v_t_mac_rec.remarks               := :remarks;
  v_t_mac_rec.update_id             := :user_id;
  v_t_mac_rec.update_time           := SYSDATE;
  v_t_mac_rec.supplier_info_id      := v_supp_id; --供应商档案ID
  scmdata.pkg_supplier_info_a.p_check_t_machine_equipment_sup(p_t_mac_rec => v_t_mac_rec);
  scmdata.pkg_supplier_info_a.p_update_t_machine_equipment_sup(p_t_mac_rec => v_t_mac_rec);
END;
]'';
  ELSE
    v_sql := NULL;
  END IF;
  '|| CHR(64) ||'strresult := v_sql;
END;
}';
UPDATE bw3.sys_item_list t SET t.insert_sql = v_sql3,t.update_sql = v_sql4 WHERE t.item_id = 'a_supp_151_10';
END;
/
DECLARE
v_sql1 CLOB;
v_sql2 CLOB;
BEGIN
  UPDATE bw3.sys_item t
     SET t.key_field = 'COOP_SCOPE_ID'
   WHERE t.item_id = 'a_supp_151_1';

  UPDATE bw3.sys_item_element_rela t
     SET t.pause = 1
   WHERE t.item_id = 'a_supp_161_1'
     AND t.element_id IN ('action_a_supp_161_1_1', 'action_a_supp_161_1_2');
     
  v_sql1 := '{
DECLARE
  TYPE rest_arrs IS TABLE OF VARCHAR2(256);
  rest_arr          rest_arrs := NEW rest_arrs('|| CHR(64) ||'selection);
  v_coop_scope_id_a VARCHAR2(4000);
  v_sql             CLOB;
BEGIN
  --获取asscoiate请求参数
  FOR rest_rec IN 1 .. rest_arr.count LOOP
    v_coop_scope_id_a := v_coop_scope_id_a || rest_arr(rest_rec) || '''''','''''';
  END LOOP;
  v_coop_scope_id_a := '''''''' || rtrim(v_coop_scope_id_a, '','''''') || '''''''';

  v_sql      := q''[DECLARE
BEGIN
  FOR a_rec IN (SELECT tc.supplier_info_id,
                       tc.coop_scope_id,
                       tc.company_id,
                       tc.coop_classification,
                       tc.coop_product_cate,
                       tc.coop_subcategory
                  FROM scmdata.t_coop_scope tc
                 WHERE tc.coop_scope_id IN (]'' ||
                v_coop_scope_id_a ||
                q''[)) LOOP
    pkg_supplier_info.update_coop_scope_status(p_company_id       => %default_company_id%,
                                               p_user_id          => %user_id%,
                                               p_supplier_info_id => a_rec.supplier_info_id,
                                               p_coop_scope_id    => a_rec.coop_scope_id,
                                               p_status           => 0);
    --启用qc工厂配置
    scmdata.pkg_qcfactory_config.p_enable_qc_factory_config_by_pro(p_supplier_info => a_rec.supplier_info_id,
                                                                   p_company_id    => a_rec.company_id,
                                                                   p_category      => a_rec.coop_classification,
                                                                   p_product_cate  => a_rec.coop_product_cate,
                                                                   p_subcategory   => a_rec.coop_subcategory);
    scmdata.pkg_qcfactory_msg.send_unconfig_factory_msg(p_company_id => a_rec.company_id);
  END LOOP;
  --启停合作工厂关系
  FOR s_rec IN (SELECT DISTINCT tc.supplier_info_id
                  FROM scmdata.t_coop_scope tc
                 WHERE tc.coop_scope_id IN (]'' ||
                v_coop_scope_id_a ||
                q''[)) LOOP
    pkg_supplier_info.p_check_sup_fac_pause(p_company_id => %default_company_id%,
                                            p_sup_id     => s_rec.supplier_info_id);
  END LOOP;
  --ZC314 ADD
  FOR tmp IN (SELECT tc.coop_scope_id
                FROM scmdata.t_coop_scope tc
               WHERE tc.coop_scope_id IN (]'' ||
                v_coop_scope_id_a || q''[)) LOOP
    scmdata.pkg_capacity_inqueue.p_common_inqueue(v_curuserid => %current_userid%,
                                                  v_compid    => %default_company_id%,
                                                  v_tab       => ''SCMDATA.T_COOP_SCOPE'',
                                                  v_viewtab   => NULL,
                                                  v_unqfields => ''COOP_SCOPE_ID,COMPANY_ID'',
                                                  v_ckfields  => ''PAUSE,UPDATE_ID,UPDATE_TIME'',
                                                  v_conds     => ''COOP_SCOPE_ID = '''''' ||
                                                                 tmp.coop_scope_id ||
                                                                 '''''' AND COMPANY_ID = '''''' ||
                                                                 %default_company_id% || '''''''',
                                                  v_method    => ''UPD'',
                                                  v_viewlogic => NULL,
                                                  v_queuetype => ''CAPC_SUPFILE_COOPSCOPEINFO_IU'');

  END LOOP;
END;]'';
  '|| CHR(64) ||'strresult := v_sql;
END;
}';
  v_sql2 := '{
DECLARE
  TYPE rest_arrs IS TABLE OF VARCHAR2(256);
  rest_arr          rest_arrs := NEW rest_arrs('|| CHR(64) ||'selection);
  v_coop_scope_id_a VARCHAR2(4000);
  v_sql             CLOB;
BEGIN
  --获取asscoiate请求参数
  FOR rest_rec IN 1 .. rest_arr.count LOOP
    v_coop_scope_id_a := v_coop_scope_id_a || rest_arr(rest_rec) || '''''','''''';
  END LOOP;
  v_coop_scope_id_a := '''''''' || rtrim(v_coop_scope_id_a, '','''''') || '''''''';
  v_sql             := q''[DECLARE
  v_coop_scope_id VARCHAR2(100);
BEGIN
  FOR a_rec IN (SELECT tc.supplier_info_id,
                       tc.coop_scope_id,
                       tc.coop_classification,
                       tc.coop_product_cate,
                       tc.company_id,
                       si.supplier_code
                  FROM scmdata.t_coop_scope tc
                 inner join scmdata.t_supplier_info si
                    on si.supplier_info_id = tc.supplier_info_id
                 WHERE tc.coop_scope_id IN (]'' ||
                       v_coop_scope_id_a ||
                       q''[)) LOOP

    v_coop_scope_id := a_rec.coop_scope_id;
    pkg_supplier_info.update_coop_scope_status(p_company_id       => %default_company_id%,
                                               p_user_id          => %user_id%,
                                               p_supplier_info_id => a_rec.supplier_info_id,
                                               p_coop_scope_id    => a_rec.coop_scope_id,
                                               p_status           => 1);
    scmdata.pkg_qcfactory_config.p_delete_qc_factory_config_by_pro(p_factory_code => a_rec.supplier_code,
                                                                   p_company_id   => a_rec.company_id,
                                                                   p_category     => a_rec.coop_classification,
                                                                   p_product_cate => a_rec.coop_product_cate);
  END LOOP;
  --启停合作工厂关系
  FOR s_rec IN (SELECT distinct tc.supplier_info_id
                  FROM scmdata.t_coop_scope tc
                 WHERE tc.coop_scope_id IN (]'' ||
                       v_coop_scope_id_a ||
                       q''[)) LOOP
    pkg_supplier_info.p_check_sup_fac_pause(p_company_id => %default_company_id%,
                                            p_sup_id     => s_rec.supplier_info_id);
  END LOOP;

  --ZC314 ADD
  FOR TMP IN (SELECT TC.COOP_SCOPE_ID
                FROM SCMDATA.T_COOP_SCOPE TC
               WHERE TC.COOP_SCOPE_ID IN (]'' ||
                       v_coop_scope_id_a || q''[)) LOOP
    SCMDATA.PKG_CAPACITY_INQUEUE.P_COMMON_INQUEUE(V_CURUSERID => %CURRENT_USERID%,
                                                  V_COMPID    => %DEFAULT_COMPANY_ID%,
                                                  V_TAB       => ''SCMDATA.T_COOP_SCOPE'',
                                                  V_VIEWTAB   => NULL,
                                                  V_UNQFIELDS => ''COOP_SCOPE_ID,COMPANY_ID'',
                                                  V_CKFIELDS  => ''PAUSE,UPDATE_ID,UPDATE_TIME'',
                                                  V_CONDS     => ''COOP_SCOPE_ID = '''''' ||
                                                                 TMP.COOP_SCOPE_ID ||
                                                                 '''''' AND COMPANY_ID = '''''' ||
                                                                 %DEFAULT_COMPANY_ID% || '''''''',
                                                  V_METHOD    => ''UPD'',
                                                  V_VIEWLOGIC => NULL,
                                                  V_QUEUETYPE => ''CAPC_SUPFILE_COOPSCOPEINFO_IU'');
  END LOOP;
END;]'';
  '|| CHR(64) ||'strresult        := v_sql;
END;
}';
 
UPDATE bw3.sys_action t SET t.action_sql = v_sql1,t.select_fields = 'COOP_SCOPE_ID' WHERE t.element_id = 'action_a_supp_161_1_1';
UPDATE bw3.sys_action t SET t.action_sql = v_sql2,t.select_fields = 'COOP_SCOPE_ID' WHERE t.element_id = 'action_a_supp_161_1_2';
END;
/
DECLARE
v_sql1 CLOB;
v_sql2 CLOB;
BEGIN
v_sql1 := '{
DECLARE
  TYPE rest_arrs IS TABLE OF VARCHAR2(256);
  rest_arr            rest_arrs := NEW rest_arrs('|| CHR(64) ||'selection);
  v_coop_factory_id_a VARCHAR2(4000);
  v_sql               CLOB;
BEGIN
  --获取asscoiate请求参数
  FOR rest_rec IN 1 .. rest_arr.count LOOP
    v_coop_factory_id_a := v_coop_factory_id_a || rest_arr(rest_rec) || '''''',''''''; 
  END LOOP;
  v_coop_factory_id_a := '''''''' || rtrim(v_coop_factory_id_a, '','''''') || '''''''';
  
  v_sql := q''[
BEGIN
  FOR a_rec IN (SELECT t.company_id, t.coop_factory_id
                  FROM scmdata.t_coop_factory t
                 WHERE t.company_id = %default_company_id%
                   AND t.coop_factory_id IN (]'' ||
             v_coop_factory_id_a || q''[)) LOOP
    scmdata.pkg_supplier_info.p_coop_fac_pause(p_company_id      => a_rec.company_id,
                                               p_coop_factory_id => a_rec.coop_factory_id,
                                               p_user_id         => :user_id,
                                               p_status          => 0);

    SCMDATA.PKG_CAPACITY_INQUEUE.P_COMMON_INQUEUE(V_CURUSERID  => %CURRENT_USERID%,
                                                  V_COMPID     => %DEFAULT_COMPANY_ID%,
                                                  V_TAB        => ''SCMDATA.T_COOP_FACTORY'',
                                                  V_VIEWTAB    => NULL,
                                                  V_UNQFIELDS  => ''COOP_FACTORY_ID,COMPANY_ID'',
                                                  V_CKFIELDS   => ''FACTORY_CODE,PAUSE,UPDATE_ID,UPDATE_TIME'',
                                                  V_CONDS      => ''COOP_FACTORY_ID = ''''''||a_rec.coop_factory_id||'''''' AND COMPANY_ID = ''''''||a_rec.company_id||'''''''',
                                                  V_METHOD     => ''UPD'',
                                                  V_VIEWLOGIC  => NULL,
                                                  V_QUEUETYPE  => ''CAPC_SUPFILE_COOPFACINFO_IU'');
  END LOOP;
END;]'';
  '|| CHR(64) ||'strresult := v_sql;
END;
}';
  v_sql2 := '{
DECLARE
  TYPE rest_arrs IS TABLE OF VARCHAR2(256);
  rest_arr            rest_arrs := NEW rest_arrs('|| CHR(64) ||'selection);
  v_coop_factory_id_a VARCHAR2(4000);
  v_sql               CLOB;
BEGIN
  --获取asscoiate请求参数
  FOR rest_rec IN 1 .. rest_arr.count LOOP
    v_coop_factory_id_a := v_coop_factory_id_a || rest_arr(rest_rec) || '''''','''''';
  END LOOP;
  v_coop_factory_id_a := '''''''' || rtrim(v_coop_factory_id_a, '','''''') || '''''''';
  
  v_sql := q''[BEGIN
  FOR a_rec IN (SELECT t.company_id, t.coop_factory_id
                  FROM scmdata.t_coop_factory t
                 WHERE t.company_id = %default_company_id%
                   AND t.coop_factory_id IN (]'' ||
             v_coop_factory_id_a || q''[)) LOOP
    scmdata.pkg_supplier_info.p_coop_fac_pause(p_company_id      => a_rec.company_id,
                                               p_coop_factory_id => a_rec.coop_factory_id,
                                               p_user_id         => :user_id,
                                               p_status          => 1);

    SCMDATA.PKG_CAPACITY_INQUEUE.P_COMMON_INQUEUE(V_CURUSERID  => %CURRENT_USERID%,
                                                  V_COMPID     => %DEFAULT_COMPANY_ID%,
                                                  V_TAB        => ''SCMDATA.T_COOP_FACTORY'',
                                                  V_VIEWTAB    => NULL,
                                                  V_UNQFIELDS  => ''COOP_FACTORY_ID,COMPANY_ID'',
                                                  V_CKFIELDS   => ''FACTORY_CODE,PAUSE,UPDATE_ID,UPDATE_TIME'',
                                                  V_CONDS      => ''COOP_FACTORY_ID = ''''''||a_rec.coop_factory_id||'''''' AND COMPANY_ID = ''''''||a_rec.company_id||'''''''',
                                                  V_METHOD     => ''UPD'',
                                                  V_VIEWLOGIC  => NULL,
                                                  V_QUEUETYPE  => ''CAPC_SUPFILE_COOPFACINFO_IU'');
  END LOOP;
END;]'';
  '|| CHR(64) ||'strresult := v_sql;
END;
}';
 
UPDATE bw3.sys_action t SET t.action_sql = v_sql1,t.select_fields = 'COOP_FACTORY_ID' WHERE t.element_id = 'action_a_supp_151_7_1';
UPDATE bw3.sys_action t SET t.action_sql = v_sql2,t.select_fields = 'COOP_FACTORY_ID' WHERE t.element_id = 'action_a_supp_151_7_2';
END;
/
DECLARE
v_sql CLOB;
BEGIN
v_sql := '{DECLARE
  v_sql     CLOB;
  v_methods VARCHAR2(256) := ''GET;POST;PUT;DELETE'';
  v_params  VARCHAR2(256);
BEGIN
  --来源为准入/手动新增
  SELECT MAX(sp.supplier_info_origin)
    INTO v_params
    FROM scmdata.t_supplier_info sp
   WHERE sp.supplier_info_id = :supplier_info_id
     AND sp.company_id = %default_company_id%;

  v_params := v_params || '','' || ''"is_element_show"''||'':''||''"1"'';
  v_params := v_params || '','' || ''"item_id"''||'':''||''"a_supp_150"'';
  v_params := v_params || '','' || ''"item_name"''||'':''||''"供应商档案详情"'';

  v_sql      := ''select '''''' || :supplier_info_id || ''/'' || v_methods || ''?'' ||
                v_params || '''''' SUPPLIER_INFO_ID from dual'';
  '|| CHR(64) ||'strresult := v_sql;
END;}';
UPDATE bw3.sys_associate t SET t.data_sql = v_sql WHERE t.element_id = 'associate_a_supp_150_2';
END;
/
DECLARE
v_sql1 CLOB;
v_sql2 CLOB;
BEGIN
v_sql1 := '{
DECLARE
  v_sup_id      VARCHAR2(32);
  v_rest_method VARCHAR2(256);
  v_params      VARCHAR2(256);
  v_sql         CLOB;
BEGIN
  --获取asscoiate请求参数
  pkg_plat_comm.p_get_rest_val_method_params(p_character     => :supplier_info_id,
                                             po_pk_id        => v_sup_id,
                                             po_rest_methods => v_rest_method,
                                             po_params       => v_params);

  IF v_rest_method IS NULL OR (v_item_id NOT IN (''a_supp_150'',''a_supp_160'') AND instr('';'' || v_rest_method || '';'', '';'' || ''POST'' || '';'') > 0) THEN
    v_sql := q''[--不考虑供应商是否已经在平台注册
DECLARE
  v_t_sup_rec scmdata.t_supplier_info%ROWTYPE;
  v_supply_id VARCHAR2(32);
  v_supp_company_id VARCHAR2(32);
BEGIN

  v_supply_id                         := :supplier_info_id;
  v_t_sup_rec.supplier_info_id        := v_supply_id;
  v_t_sup_rec.company_id              := %default_company_id%;
  v_t_sup_rec.supplier_info_origin    := ''MA'';
  v_t_sup_rec.supplier_info_origin_id := NULL;
  v_t_sup_rec.status                  := 0;
  --基本信息
  v_t_sup_rec.supplier_company_name         := :sp_sup_company_name_y; --公司名称
  v_t_sup_rec.supplier_company_abbreviation := :sp_sup_company_abb_y; --公司简称
  v_t_sup_rec.social_credit_code            := :sp_social_credit_code_y; --统一社会信用代码
  --v_t_sup_rec.supplier_code                 := :sp_supplier_code_n; --供应商编号
  v_t_sup_rec.inside_supplier_code  := :sp_inside_supplier_code_n; --内部供应商编号
  v_t_sup_rec.company_regist_date   := :sp_company_regist_date_y; --公司注册日期
  v_t_sup_rec.company_province      := :company_province; --公司省
  v_t_sup_rec.company_city          := :company_city; --公司市
  v_t_sup_rec.company_county        := :company_county; --公司区
  v_t_sup_rec.company_vill          := :ar_company_vill_y; --公司乡镇
  v_t_sup_rec.company_address       := :sp_company_address_y; --公司地址
  v_t_sup_rec.group_name            := :sp_group_name_n; --分组名称（v9.9版 存值改为分组ID）
  v_t_sup_rec.legal_representative  := :sp_legal_represent_n; --法定代表人
  v_t_sup_rec.company_contact_phone := :sp_company_contact_phone_n; --公司联系电话
  v_t_sup_rec.fa_contact_name       := :sp_contact_name_y; --业务联系人
  v_t_sup_rec.fa_contact_phone      := :sp_contact_phone_y; --业务联系人手机
  v_t_sup_rec.company_type          := :sp_company_type_y; --公司类型
  v_t_sup_rec.is_our_factory        := :ar_is_our_factory_y; --是否本厂
  v_t_sup_rec.factroy_area          := :sp_factroy_area_y; --工厂面积（m2）
  v_t_sup_rec.remarks               := :sp_remarks_n; --备注

  --生产信息
  v_t_sup_rec.product_type      := :sp_product_type_y; --生产类型
  v_t_sup_rec.brand_type        := :sp_brand_type_n; --合作品牌/客户 类型
  v_t_sup_rec.cooperation_brand := :cooperation_brand; --合作品牌/客户
  v_t_sup_rec.product_link      := :sp_product_link_n; --生产环节

  v_t_sup_rec.product_line        := :sp_product_line_n; --生产线类型
  v_t_sup_rec.product_line_num    := :sp_product_line_num_n; --生产线数量
  v_t_sup_rec.quality_step        := :sp_quality_step_y; --质量等级
  v_t_sup_rec.work_hours_day      := :sp_work_hours_day_y; --上班时数/天
  v_t_sup_rec.worker_total_num    := :sp_worker_total_num_y; --总人数
  v_t_sup_rec.worker_num          := :sp_worker_num_y; --车位人数
  v_t_sup_rec.machine_num         := :sp_machine_num_y; --织机台数
  v_t_sup_rec.form_num            := :sp_form_num_y; --成型人数_鞋类
  v_t_sup_rec.product_efficiency  := :sp_product_efficiency_y; --产能效率
  v_t_sup_rec.pattern_cap         := :sp_pattern_cap_y; --打版能力
  v_t_sup_rec.fabric_purchase_cap := :sp_fabric_purchase_cap_y; --面料采购能力
  v_t_sup_rec.fabric_check_cap    := :sp_fabric_check_cap_y; --面料检测能力

  --合作信息
  v_t_sup_rec.pause := :sp_coop_state_y; --状态：0 启用 1 停用 2 试单

  SELECT MAX(fc.company_id)
    INTO v_supp_company_id
    FROM scmdata.sys_company fc
   WHERE fc.company_id = %default_company_id%
     AND fc.licence_num = :sp_social_credit_code_y;

  v_t_sup_rec.supplier_company_id := v_supp_company_id; --供应商在平台的企业id
  v_t_sup_rec.cooperation_type    := :sp_cooperation_type_y; --合作类型
  v_t_sup_rec.cooperation_model   := replace(:sp_cooperation_model_y,'' '','';'');
  v_t_sup_rec.coop_position       := :sp_coop_position_n; --合作定位
  v_t_sup_rec.pay_term            := :ar_pay_term_n; --付款条件

  --附件资料
  v_t_sup_rec.certificate_file  := :sp_certificate_file_y; --上传营业执照
  v_t_sup_rec.supplier_gate     := :sp_supplier_gate_n; --公司大门附件地址
  v_t_sup_rec.supplier_office   := :sp_supplier_office_n; --公司办公室附件地址
  v_t_sup_rec.supplier_site     := :sp_supplier_site_n; --生产现场附件地址
  v_t_sup_rec.supplier_product  := :sp_supplier_product_n; --产品图片附件地址
  v_t_sup_rec.other_information := :sp_other_information_n; --其他资料

  --其它
  v_t_sup_rec.create_id   := :user_id;
  v_t_sup_rec.create_date := SYSDATE;
  v_t_sup_rec.update_id   := :user_id; --修改人ID
  v_t_sup_rec.update_date := SYSDATE; --修改时间

  --1.新增 => 保存，校验数据
  scmdata.pkg_supplier_info.p_check_save_t_supplier_info(p_sp_data => v_t_sup_rec);
  --2.插入数据
  scmdata.pkg_supplier_info.p_insert_supplier_info(p_sp_data => v_t_sup_rec);
  --3.同步人员机器配置
  scmdata.pkg_supplier_info_a.p_generate_person_machine_config(p_company_id => %default_company_id%,p_user_id => :user_id,p_sup_id => v_supply_id);
  --4.同步合作工厂
  scmdata.pkg_supplier_info_a.p_generate_t_coop_factory_by_iu(p_company_id => %default_company_id%,p_supp_id => v_supply_id,p_user_id => :user_id);
END;
]'';
  ELSE
    v_sql := NULL;
  END IF;
  '|| CHR(64) ||'strresult := v_sql;
END;
}';
v_sql2 := '--update sql by czh55 2023-01-10 02:54:52
{
DECLARE
  v_pk_id       VARCHAR2(32);
  v_rest_method VARCHAR2(256);
  v_params      VARCHAR2(256);
  v_sql         CLOB;
BEGIN
  --获取asscoiate请求参数
  pkg_plat_comm.p_get_rest_val_method_params(p_character     => NVL(%supplier_info_id%,:supplier_info_id),
                                             po_pk_id        => v_pk_id,
                                             po_rest_methods => v_rest_method,
                                             po_params       => v_params);

  IF v_rest_method IS NULL OR instr('';'' || v_rest_method || '';'', '';'' || ''PUT'' || '';'') > 0 THEN
    v_sql := q''[
    DECLARE
      v_t_sup_rec       scmdata.t_supplier_info%ROWTYPE;
      v_supp_company_id VARCHAR2(32);
      v_supp_id         VARCHAR2(32) := '']'' || v_pk_id || q''[''; --主键
    BEGIN
      v_t_sup_rec.supplier_info_id := v_supp_id; --主键
      v_t_sup_rec.company_id       := %default_company_id%; --公司编码
      --基本信息
      v_t_sup_rec.supplier_company_name         := :sp_sup_company_name_y; --公司名称
      v_t_sup_rec.supplier_company_abbreviation := :sp_sup_company_abb_y; --公司简称
      v_t_sup_rec.social_credit_code            := :sp_social_credit_code_y; --统一社会信用代码
      --v_t_sup_rec.supplier_code                 := :sp_supplier_code_n; --供应商编号
      v_t_sup_rec.inside_supplier_code  := :sp_inside_supplier_code_n; --内部供应商编号
      v_t_sup_rec.company_regist_date   := :sp_company_regist_date_y; --公司注册日期
      v_t_sup_rec.company_province      := :company_province; --公司省
      v_t_sup_rec.company_city          := :company_city; --公司市
      v_t_sup_rec.company_county        := :company_county; --公司区
      v_t_sup_rec.company_vill          := :ar_company_vill_y; --公司乡镇
      v_t_sup_rec.company_address       := :sp_company_address_y; --公司地址
      v_t_sup_rec.group_name            := :sp_group_name_n; --分组名称（v9.9版 存值改为分组ID）
      v_t_sup_rec.legal_representative  := :sp_legal_represent_n; --法定代表人
      v_t_sup_rec.company_contact_phone := :sp_company_contact_phone_n; --公司联系电话
      v_t_sup_rec.fa_contact_name       := :sp_contact_name_y; --业务联系人
      v_t_sup_rec.fa_contact_phone      := :sp_contact_phone_y; --业务联系人手机
      v_t_sup_rec.company_type          := :sp_company_type_y; --公司类型
      v_t_sup_rec.is_our_factory        := :ar_is_our_factory_y; --是否本厂
      v_t_sup_rec.factroy_area          := :sp_factroy_area_y; --工厂面积（m2）
      v_t_sup_rec.remarks               := :sp_remarks_n; --备注

      --生产信息
      v_t_sup_rec.product_type      := :sp_product_type_y; --生产类型
      v_t_sup_rec.brand_type        := :sp_brand_type_n; --合作品牌/客户 类型
      v_t_sup_rec.cooperation_brand := :cooperation_brand; --合作品牌/客户
      v_t_sup_rec.product_link      := :sp_product_link_n; --生产环节

      v_t_sup_rec.product_line        := :sp_product_line_n; --生产线类型
      v_t_sup_rec.product_line_num    := :sp_product_line_num_n; --生产线数量
      v_t_sup_rec.quality_step        := :sp_quality_step_y; --质量等级
      v_t_sup_rec.work_hours_day      := :sp_work_hours_day_y; --上班时数/天
      v_t_sup_rec.worker_total_num    := :sp_worker_total_num_y; --总人数
      v_t_sup_rec.worker_num          := :sp_worker_num_y; --车位人数
      v_t_sup_rec.machine_num         := :sp_machine_num_y; --织机台数
      v_t_sup_rec.form_num            := :sp_form_num_y; --成型人数_鞋类
      v_t_sup_rec.product_efficiency  := :sp_product_efficiency_y; --产能效率
      v_t_sup_rec.pattern_cap         := :sp_pattern_cap_y; --打版能力
      v_t_sup_rec.fabric_purchase_cap := :sp_fabric_purchase_cap_y; --面料采购能力
      v_t_sup_rec.fabric_check_cap    := :sp_fabric_check_cap_y; --面料检测能力

      --合作信息
      v_t_sup_rec.pause := :sp_coop_state_y; --状态：0 启用 1 停用 2 试单

      SELECT MAX(fc.company_id)
        INTO v_supp_company_id
        FROM scmdata.sys_company fc
       WHERE fc.company_id = %default_company_id%
         AND fc.licence_num = :sp_social_credit_code_y;

      v_t_sup_rec.supplier_company_id := v_supp_company_id; --供应商在平台的企业id
      v_t_sup_rec.cooperation_type    := :sp_cooperation_type_y; --合作类型
      v_t_sup_rec.cooperation_model   := replace(:sp_cooperation_model_y,'' '','';''); --合作模式
      v_t_sup_rec.coop_position       := :sp_coop_position_n; --合作定位
      v_t_sup_rec.pay_term            := :ar_pay_term_n; --付款条件

      --附件资料
      v_t_sup_rec.certificate_file  := :sp_certificate_file_y; --上传营业执照
      v_t_sup_rec.supplier_gate     := :sp_supplier_gate_n; --公司大门附件地址
      v_t_sup_rec.supplier_office   := :sp_supplier_office_n; --公司办公室附件地址
      v_t_sup_rec.supplier_site     := :sp_supplier_site_n; --生产现场附件地址
      v_t_sup_rec.supplier_product  := :sp_supplier_product_n; --产品图片附件地址
      v_t_sup_rec.other_information := :sp_other_information_n; --其他资料

      --其它
      v_t_sup_rec.update_id   := :user_id; --修改人ID
      v_t_sup_rec.update_date := SYSDATE; --修改时间

      --修改 t_supplier_info
      --1.更新=》保存，校验数据
      pkg_supplier_info.p_update_supplier_info(p_sp_data => v_t_sup_rec);
      --2.更新所在区域
      pkg_supplier_info.p_update_group_name(p_company_id       => %default_company_id%,
                                            p_supplier_info_id => v_supp_id,
                                            p_is_by_pick       => 1,
                                            p_province         => :company_province,
                                            p_city             => :company_city);
      --3.同步合作工厂
      scmdata.pkg_supplier_info_a.p_generate_t_coop_factory_by_iu(p_company_id => %default_company_id%,p_supp_id => v_supp_id,p_user_id => :user_id);                                       
    END update_supp_info;]'';
  ELSE
    v_sql := NULL;
  END IF;
  '|| CHR(64) ||'strresult := v_sql;
END;
}';
UPDATE bw3.sys_item_list t SET t.insert_sql = v_sql1,t.update_sql = v_sql2 WHERE t.item_id = 'a_supp_151';
END;
/
DECLARE
v_sql1 CLOB;
v_sql2 CLOB;
BEGIN
  v_sql1 := '{
DECLARE
  v_sql       CLOB;
  v_where_sql CLOB;
BEGIN
  IF :ar_cooperation_model_y IS NULL THEN
    v_where_sql := q''[WHERE 1 = 0]'';
  ELSE
    IF instr(:ar_cooperation_model_y, ''OEM'') > 0 OR
       instr(:ar_cooperation_model_y, ''OF'') > 0 THEN
      v_where_sql := q''[WHERE AR_COMPANY_TYPE_Y = ''02'']'';
    ELSE
      v_where_sql := q''[WHERE AR_COMPANY_TYPE_Y IN (''01'',''02'')]'';
    END IF;
  END IF;
  v_sql      := scmdata.pkg_plat_comm.f_get_picksql_by_type(p_group_dict_type   => ''COMPANY_TYPE'',
                                                            p_dict_value        => ''AR_COMPANY_TYPE_Y'',
                                                            p_dict_desc         => ''AR_COMPANY_TYPE_DESC_Y'',
                                                            p_where_sql         => v_where_sql,
                                                            p_is_set_other_fd   => 1,
                                                            p_setnull_fdvalue_1 => ''AR_PAY_TERM_N'',
                                                            p_setnull_fddesc_1  => ''AR_PAY_TERM_DESC_N'',
                                                            p_setnull_fdvalue_2 => ''AR_PRODUCT_TYPE_Y'',
                                                            p_setnull_fddesc_2  => ''AR_PRODUCT_TYPE_DESC_Y'');
  '|| CHR(64) ||'strresult := v_sql;
END;
}';
v_sql2 := '{
DECLARE
  v_sql       CLOB;
  v_where_sql CLOB;
BEGIN
  IF :sp_cooperation_model_y IS NULL THEN
    v_where_sql := q''[WHERE 1 = 0]'';
  ELSE
    IF instr(:sp_cooperation_model_y, ''OEM'') > 0 OR
       instr(:sp_cooperation_model_y, ''OF'') > 0 THEN
      v_where_sql := q''[WHERE SP_COMPANY_TYPE_Y = ''02'']'';
    ELSE
      v_where_sql := q''[WHERE SP_COMPANY_TYPE_Y IN (''01'',''02'')]'';
    END IF;
  END IF;
  v_sql      := scmdata.pkg_plat_comm.f_get_picksql_by_type(p_group_dict_type   => ''COMPANY_TYPE'',
                                                            p_dict_value        => ''SP_COMPANY_TYPE_Y'',
                                                            p_dict_desc         => ''SP_COMPANY_TYPE_DESC_Y'',
                                                            p_where_sql         => v_where_sql,
                                                            p_is_set_other_fd   => 1,
                                                            p_setnull_fdvalue_1 => ''SP_PAY_TERM_N'',
                                                            p_setnull_fddesc_1  => ''SP_PAY_TERM_DESC_N'',
                                                            p_setnull_fdvalue_2 => ''SP_PRODUCT_TYPE_Y'',
                                                            p_setnull_fddesc_2  => ''SP_PRODUCT_TYPE_DESC_Y'');
  '|| CHR(64) ||'strresult := v_sql;
END;
}';

UPDATE bw3.sys_pick_list t SET t.pick_sql = v_sql1 WHERE t.element_id = 'pick_a_coop_151_3';
UPDATE bw3.sys_pick_list t SET t.pick_sql = v_sql2 WHERE t.element_id = 'pick_a_supp_111_6';
END;
/
BEGIN
  UPDATE bw3.sys_field_list t
   SET t.requiered_flag = 0
 WHERE t.field_name IN ('AR_FACTORY_NAME_Y',
                        'AR_FACTORY_AREA_Y',
                        'AR_FACTORY_VILL_Y',
                        'AR_FACTORY_VILL_DESC_Y',
                        'AR_FACTROY_DETAILS_ADDRESS_Y');
END;
/
DECLARE
v_sql CLOB;
BEGIN
v_sql := '{DECLARE
  v_sql     CLOB;
  v_methods VARCHAR2(256) := ''GET;POST;PUT;DELETE'';
  v_params  VARCHAR2(256);
BEGIN
  --来源为准入/手动新增
  SELECT MAX(sp.supplier_info_origin)
    INTO v_params
    FROM scmdata.t_supplier_info sp
   WHERE sp.supplier_info_id = :supplier_info_id
     AND sp.company_id = %default_company_id%;

  v_params := v_params || '','' || ''"is_element_show"''||'':''||''"0"'';
  v_params := v_params || '','' || ''"item_id"''||'':''||''"a_supp_160"'';
  v_params := v_params || '','' || ''"item_name"''||'':''||''"供应商档案详情"'';

  v_sql      := ''select '''''' || :supplier_info_id || ''/'' || v_methods || ''?'' ||
                v_params || '''''' SUPPLIER_INFO_ID from dual'';
  '|| CHR(64) ||'strresult := v_sql;
END;}';
UPDATE bw3.sys_associate t SET t.data_sql = v_sql WHERE t.element_id = 'associate_a_supp_160_1';
END;
/
DECLARE
  v_sql CLOB;
BEGIN
  v_sql := q'[
--CZH 重构逻辑
{
DECLARE
  v_sql             CLOB;
  v_methods         VARCHAR2(256) := 'GET;POST;PUT;DELETE';
  v_params          VARCHAR2(4000);
  v_is_show_element INT;
BEGIN
  --跳转携带参数
  --'{"COL_1": "PRODUCT_TYPE","COL_2": "00;01","COL_3": "","COL_4": "","COL_5": "","COL_6": "","COL_7": "","COL_8": "","COL_9": "","COL_10": "","COL_11": "YWZ","COL_21": "","COL_22": ""}'
  v_params := '"is_show_element"' || ':' || '"0"';
  v_params := v_params || ',' || '"item_id"' || ':' || '"a_coop_211"';
  v_params := v_params || ',' || '"item_name"' || ':' || '"查看申请详情"';
  v_params := '{' || v_params || '}';

  v_sql      := 'select ''' || :FACTORY_ASK_ID || '/' || v_methods || '?' ||
                v_params || ''' ASK_RECORD_ID from dual';
  ]'|| CHR(64) ||q'[strresult := v_sql;
END;
}]';
  UPDATE bw3.sys_associate t
     SET t.data_sql = v_sql
   WHERE t.element_id = 'associate_a_coop_221';
END;
/
DECLARE
  v_sql2 CLOB;
BEGIN
  v_sql2 := '{
DECLARE
  v_sql           CLOB;
  v_ask_record_id VARCHAR2(32);
  v_rest_method   VARCHAR2(256);
  v_params        VARCHAR2(2000);
  v_fac_ask_flow_status VARCHAR2(256);
BEGIN
  --获取asscoiate请求参数
  pkg_plat_comm.p_get_rest_val_method_params(p_character     => %ass_ask_record_id%,
                                             po_pk_id        => v_ask_record_id,
                                             po_rest_methods => v_rest_method,
                                             po_params       => v_params);
  IF :factory_ask_id IS NULL THEN
    v_rest_method := nvl(v_rest_method, ''PUT'');
  ELSE
    SELECT MAX(t.factrory_ask_flow_status)
      INTO v_fac_ask_flow_status
      FROM scmdata.t_factory_ask t
     WHERE t.factory_ask_id = :factory_ask_id
       AND t.company_id = %default_company_id%;
    IF v_fac_ask_flow_status = ''FA02'' THEN
      v_rest_method := nvl(v_rest_method, ''PUT'');
      ELSE
        NULL;
    END IF;
  END IF;
  IF instr('';'' || v_rest_method || '';'', '';'' || ''PUT'' || '';'') > 0 THEN
    v_sql := q''[
    DECLARE
      v_t_per_rec t_person_config_fa%ROWTYPE;
    BEGIN
      v_t_per_rec.person_config_id := :person_config_id;
      v_t_per_rec.person_num       := :ar_person_num_n;
      v_t_per_rec.remarks          := :ar_remarks_n;
      v_t_per_rec.update_id        := :user_id;
      v_t_per_rec.update_time      := SYSDATE;
      --更新人员配置
      scmdata.pkg_ask_record_mange_a.p_update_t_person_config_fa(p_t_per_rec => v_t_per_rec);
      --同步主表生产相关信息
      scmdata.pkg_ask_record_mange_a.p_generate_ask_record_product_info(p_company_id  => %default_company_id%,p_factory_ask_id => :factory_ask_id);
    END;
    ]'';
  ELSE
    v_sql := NULL;
  END IF;
  '|| CHR(64) ||'strresult := v_sql;
END;
}';

  UPDATE bw3.sys_item_list t
     SET t.update_sql = v_sql2
   WHERE t.item_id = 'a_coop_150_3_1';
END;
/
DECLARE
  v_sql1 CLOB;
  v_sql2 CLOB;
  v_sql3 CLOB;
BEGIN
  v_sql1 := '--czh 20221103 v9.10
{
DECLARE
  v_sql         CLOB;
  v_ask_record_id VARCHAR2(32);
  v_rest_method   VARCHAR2(256);
  v_params        VARCHAR2(2000);
  v_fac_ask_flow_status VARCHAR2(256);
BEGIN
  --获取asscoiate请求参数
  pkg_plat_comm.p_get_rest_val_method_params(p_character     => %ass_ask_record_id%,
                                             po_pk_id        => v_ask_record_id,
                                             po_rest_methods => v_rest_method,
                                             po_params       => v_params);
  IF :factory_ask_id IS NULL THEN
    v_rest_method := nvl(v_rest_method, ''POST'');
  ELSE
    SELECT MAX(t.factrory_ask_flow_status)
      INTO v_fac_ask_flow_status
      FROM scmdata.t_factory_ask t
     WHERE t.factory_ask_id = :factory_ask_id
       AND t.company_id = %default_company_id%;
    IF v_fac_ask_flow_status = ''FA02'' THEN
      v_rest_method := nvl(v_rest_method, ''POST'');
      ELSE
        NULL;
    END IF;
  END IF;
  
  IF instr('';'' || v_rest_method || '';'', '';'' || ''POST'' || '';'') > 0 THEN
    v_sql := q''[
DECLARE
  v_t_mac_rec t_machine_equipment_fa%ROWTYPE;
  v_seqno     INT;
BEGIN
  v_t_mac_rec.machine_equipment_id  := scmdata.f_get_uuid();
  v_t_mac_rec.company_id            := %default_company_id%;
  v_t_mac_rec.equipment_category_id := :ar_equipment_cate_n;
  v_t_mac_rec.equipment_name        := :ar_equipment_name_y;
  v_t_mac_rec.machine_num           := nvl(:ar_machine_num_n,0);

  SELECT nvl(MAX(t.seqno), 0) + 1
    INTO v_seqno
    FROM scmdata.t_machine_equipment_fa t
   WHERE t.factory_ask_id  = :factory_ask_id
     AND t.company_id = %default_company_id%;

  v_t_mac_rec.seqno         := v_seqno;
  v_t_mac_rec.orgin         := ''MA'';
  v_t_mac_rec.pause         := 0;
  v_t_mac_rec.remarks       := :remarks;
  v_t_mac_rec.update_id     := :user_id;
  v_t_mac_rec.update_time   := SYSDATE;
  v_t_mac_rec.create_id     := :user_id;
  v_t_mac_rec.create_time   := SYSDATE;
  v_t_mac_rec.factory_ask_id := :factory_ask_id;
  
  pkg_ask_record_mange_a.p_check_t_machine_equipment_fa(p_t_mac_rec => v_t_mac_rec);
  pkg_ask_record_mange_a.p_insert_t_machine_equipment_fa(p_t_mac_rec => v_t_mac_rec);
END;
]'';
  ELSE
    v_sql := NULL;
  END IF;
  '|| CHR(64) ||'strresult := v_sql;
END;
}';
  v_sql2 := '--czh 20221103 v9.10
{
DECLARE
  v_sql         CLOB;
  v_ask_record_id VARCHAR2(32);
  v_rest_method   VARCHAR2(256);
  v_params        VARCHAR2(2000);
  v_fac_ask_flow_status VARCHAR2(256);
BEGIN
  --获取asscoiate请求参数
  pkg_plat_comm.p_get_rest_val_method_params(p_character     => %ass_ask_record_id%,
                                             po_pk_id        => v_ask_record_id,
                                             po_rest_methods => v_rest_method,
                                             po_params       => v_params);
  IF :factory_ask_id IS NULL THEN
    v_rest_method := nvl(v_rest_method, ''PUT'');
  ELSE
    SELECT MAX(t.factrory_ask_flow_status)
      INTO v_fac_ask_flow_status
      FROM scmdata.t_factory_ask t
     WHERE t.factory_ask_id = :factory_ask_id
       AND t.company_id = %default_company_id%;
    IF v_fac_ask_flow_status = ''FA02'' THEN
      v_rest_method := nvl(v_rest_method, ''PUT'');
      ELSE
        NULL;
    END IF;
  END IF;
  
  IF instr('';'' || v_rest_method || '';'', '';'' || ''PUT'' || '';'') > 0 THEN
    v_sql := q''[
DECLARE
  v_t_mac_rec t_machine_equipment_fa%ROWTYPE;
  v_seqno     INT;
BEGIN
  v_t_mac_rec.machine_equipment_id  := :machine_equipment_id;
  v_t_mac_rec.equipment_category_id := :ar_equipment_cate_n;
  v_t_mac_rec.equipment_name        := :ar_equipment_name_y;
  v_t_mac_rec.machine_num   := nvl(:ar_machine_num_n,0);
  v_t_mac_rec.remarks       := :remarks;
  v_t_mac_rec.update_id     := :user_id;
  v_t_mac_rec.update_time   := SYSDATE;
  v_t_mac_rec.factory_ask_id := :factory_ask_id;
  
  pkg_ask_record_mange_a.p_check_t_machine_equipment_fa(p_t_mac_rec => v_t_mac_rec);
  pkg_ask_record_mange_a.p_update_t_machine_equipment_fa(p_t_mac_rec => v_t_mac_rec);
END;
]'';
  ELSE
    v_sql := NULL;
  END IF;
  '|| CHR(64) ||'strresult := v_sql;
END;
}';
  v_sql3 := '--czh 20221103 v9.10
{
DECLARE
  v_sql         CLOB;
  v_ask_record_id VARCHAR2(32);
  v_rest_method   VARCHAR2(256);
  v_params        VARCHAR2(2000);
  v_fac_ask_flow_status VARCHAR2(256);
BEGIN
  --获取asscoiate请求参数
  pkg_plat_comm.p_get_rest_val_method_params(p_character     => %ass_ask_record_id%,
                                             po_pk_id        => v_ask_record_id,
                                             po_rest_methods => v_rest_method,
                                             po_params       => v_params);
  IF :factory_ask_id IS NULL THEN
    v_rest_method := nvl(v_rest_method, ''DELETE'');
  ELSE
    SELECT MAX(t.factrory_ask_flow_status)
      INTO v_fac_ask_flow_status
      FROM scmdata.t_factory_ask t
     WHERE t.factory_ask_id = :factory_ask_id
       AND t.company_id = %default_company_id%;
    IF v_fac_ask_flow_status = ''FA02'' THEN
      v_rest_method := nvl(v_rest_method, ''DELETE'');
      ELSE
        NULL;
    END IF;
  END IF;
  IF instr('';'' || v_rest_method || '';'', '';'' || ''DELETE'' || '';'') > 0 THEN
    v_sql := q''[
DECLARE
  v_t_mac_rec t_machine_equipment_fa%ROWTYPE;
  v_seqno     INT;
BEGIN
  v_t_mac_rec.machine_equipment_id  := :machine_equipment_id;
  v_t_mac_rec.orgin                 := :orgin_val;
  pkg_ask_record_mange_a.p_delete_t_machine_equipment_fa(p_t_mac_rec => v_t_mac_rec);
END;
]'';
  ELSE
    v_sql := NULL;
  END IF;
  '|| CHR(64) ||'strresult := v_sql;
END;
}';
  
  UPDATE bw3.sys_item_list t
     SET t.insert_sql = v_sql1,
         t.update_sql = v_sql2,
         t.delete_sql = v_sql3
   WHERE t.item_id = 'a_coop_150_3_2';
END;
/
DECLARE
  v_sql1 CLOB;
  v_sql2 CLOB;
  v_sql3 CLOB;
BEGIN
  v_sql1 := '--czh 20221103 v9.10
{
DECLARE
  v_sql                 CLOB;
  v_ask_record_id       VARCHAR2(32);
  v_rest_method         VARCHAR2(256);
  v_params              VARCHAR2(2000);
  v_fac_ask_flow_status VARCHAR2(256);
BEGIN
  --获取asscoiate请求参数
  pkg_plat_comm.p_get_rest_val_method_params(p_character     => %ass_ask_record_id%,
                                             po_pk_id        => v_ask_record_id,
                                             po_rest_methods => v_rest_method,
                                             po_params       => v_params);
  IF :factory_ask_id IS NULL THEN
    v_rest_method := nvl(v_rest_method, ''POST'');
  ELSE
    SELECT MAX(t.factrory_ask_flow_status)
      INTO v_fac_ask_flow_status
      FROM scmdata.t_factory_ask t
     WHERE t.factory_ask_id = :factory_ask_id
       AND t.company_id = %default_company_id%;
    IF v_fac_ask_flow_status = ''FA02'' THEN
      v_rest_method := nvl(v_rest_method, ''POST'');
      ELSE
        NULL;
    END IF;
  END IF;

  IF instr('';'' || v_rest_method || '';'', '';'' || ''POST'' || '';'') > 0 THEN
    v_sql := q''[DECLARE
  v_t_ask_rec scmdata.t_ask_scope%ROWTYPE;
  v_ask_record_id VARCHAR2(32) := nvl('']'' || v_ask_record_id ||
             q''['',:ask_record_id);
BEGIN
  scmdata.pkg_ask_record_mange.check_repeat_scope(pi_ask_scope_id               => '' '',
                                                  pi_object_id                  => :factory_ask_id,
                                                  pi_object_type                => ''CA'',
                                                  pi_cooperation_classification => :cooperation_classification,
                                                  pi_cooperation_product_cate   => :cooperation_product_cate,
                                                  pi_cooperation_type           => :cooperation_type);

  v_t_ask_rec.ask_scope_id               := scmdata.f_get_uuid();
  v_t_ask_rec.company_id                 := %default_company_id%;
  v_t_ask_rec.object_id                  := :factory_ask_id;
  v_t_ask_rec.object_type                := ''CA'';
  v_t_ask_rec.cooperation_type           := :cooperation_type;
  v_t_ask_rec.cooperation_classification := :cooperation_classification;
  v_t_ask_rec.cooperation_product_cate   := :cooperation_product_cate;
  v_t_ask_rec.cooperation_subcategory    := :cooperation_subcategory;
  v_t_ask_rec.be_company_id              := %default_company_id%;
  v_t_ask_rec.update_time                := SYSDATE;
  v_t_ask_rec.update_id                  := :user_id;
  v_t_ask_rec.create_id                  := :user_id;
  v_t_ask_rec.create_time                := SYSDATE;
  v_t_ask_rec.remarks                    := NULL;
  v_t_ask_rec.pause                      := 0;

  scmdata.pkg_ask_record_mange.p_insert_t_ask_scope(p_t_ask_rec => v_t_ask_rec);
END;]'';
  ELSE
    v_sql := NULL;
  END IF;
  '|| CHR(64) ||'strresult := v_sql;
END;
}';
  v_sql2 := '--czh 20221103 v9.10
{
DECLARE
  v_sql         CLOB;
  v_ask_record_id VARCHAR2(32);
  v_rest_method   VARCHAR2(256);
  v_params        VARCHAR2(2000);
  v_fac_ask_flow_status VARCHAR2(256);
BEGIN
  --获取asscoiate请求参数
  pkg_plat_comm.p_get_rest_val_method_params(p_character     => %ass_ask_record_id%,
                                             po_pk_id        => v_ask_record_id,
                                             po_rest_methods => v_rest_method,
                                             po_params       => v_params);
 
  IF :factory_ask_id IS NULL THEN
     v_rest_method := nvl(v_rest_method, ''PUT'');
  ELSE
    SELECT MAX(t.factrory_ask_flow_status)
      INTO v_fac_ask_flow_status
      FROM scmdata.t_factory_ask t
     WHERE t.factory_ask_id = :factory_ask_id
       AND t.company_id = %default_company_id%;
    IF v_fac_ask_flow_status = ''FA02'' THEN
       v_rest_method := nvl(v_rest_method, ''PUT'');
    ELSE
        NULL;
    END IF;
  END IF;
  IF instr('';'' || v_rest_method || '';'', '';'' || ''PUT'' || '';'') > 0 THEN
    v_sql := q''[DECLARE
  v_t_ask_rec     scmdata.t_ask_scope%ROWTYPE;
  v_ask_record_id VARCHAR2(32) := nvl('']''|| v_ask_record_id || q''['',:ask_record_id);
BEGIN
  scmdata.pkg_ask_record_mange.check_repeat_scope(pi_ask_scope_id               => :ask_scope_id,
                                                  pi_object_id                  => :factory_ask_id,
                                                  pi_object_type                => ''CA'',
                                                  pi_cooperation_classification => :cooperation_classification,
                                                  pi_cooperation_product_cate   => :cooperation_product_cate,
                                                  pi_cooperation_type           => :cooperation_type);

  v_t_ask_rec.ask_scope_id               := :ask_scope_id;
  v_t_ask_rec.cooperation_classification := :cooperation_classification;
  v_t_ask_rec.cooperation_product_cate   := :cooperation_product_cate;
  v_t_ask_rec.cooperation_subcategory    := :cooperation_subcategory;
  v_t_ask_rec.update_time                := SYSDATE;
  v_t_ask_rec.update_id                  := :user_id;

  scmdata.pkg_ask_record_mange.p_update_t_ask_scope(p_t_ask_rec => v_t_ask_rec);
END;]'';
  ELSE
    v_sql := NULL;
  END IF;
  '|| CHR(64) ||'strresult := v_sql;
END;
}';
  v_sql3 := '--czh 20221103 v9.10
{
DECLARE
  v_sql         CLOB;
  v_ask_record_id VARCHAR2(32);
  v_rest_method   VARCHAR2(256);
  v_params        VARCHAR2(2000);
  v_fac_ask_flow_status VARCHAR2(256);
BEGIN
  --获取asscoiate请求参数
  pkg_plat_comm.p_get_rest_val_method_params(p_character     => %ass_ask_record_id%,
                                             po_pk_id        => v_ask_record_id,
                                             po_rest_methods => v_rest_method,
                                             po_params       => v_params);
  
  IF :factory_ask_id IS NULL THEN
     v_rest_method := nvl(v_rest_method, ''DELETE'');
  ELSE
    SELECT MAX(t.factrory_ask_flow_status)
      INTO v_fac_ask_flow_status
      FROM scmdata.t_factory_ask t
     WHERE t.factory_ask_id = :factory_ask_id
       AND t.company_id = %default_company_id%;
    IF v_fac_ask_flow_status = ''FA02'' THEN
       v_rest_method := nvl(v_rest_method, ''DELETE'');
    ELSE
       NULL;
    END IF;
  END IF;
  IF instr('';'' || v_rest_method || '';'', '';'' || ''DELETE'' || '';'') > 0 THEN
    v_sql := q''[DECLARE
  v_t_ask_rec scmdata.t_ask_scope%ROWTYPE;
BEGIN
  v_t_ask_rec.ask_scope_id := :ask_scope_id;
  scmdata.pkg_ask_record_mange.p_delete_t_ask_scope(p_t_ask_rec => v_t_ask_rec);
END;]'';
  ELSE
    v_sql := NULL;
  END IF;
  '|| CHR(64) ||'strresult := v_sql;
END;
}';
  
  UPDATE bw3.sys_item_list t
     SET t.insert_sql = v_sql1,
         t.update_sql = v_sql2,
         t.delete_sql = v_sql3
   WHERE t.item_id = 'a_coop_159_1';
END;
/
DECLARE
  v_sql1 CLOB;
  v_sql2 CLOB;
  v_sql3 CLOB;
BEGIN
  v_sql1 := '{
DECLARE
  v_sup_id      VARCHAR2(32);
  v_item_id     VARCHAR2(32);
  v_rest_method VARCHAR2(256);
  v_params      VARCHAR2(256);
  v_sql         CLOB;
BEGIN
  --获取asscoiate请求参数
  pkg_plat_comm.p_get_rest_val_method_params(p_character     => :supplier_info_id,
                                             po_pk_id        => v_sup_id,
                                             po_rest_methods => v_rest_method,
                                             po_params       => v_params);
                                             
  v_item_id := plm.pkg_plat_comm.parse_json(p_jsonstr => :supplier_info_id,p_key  => ''item_id'');
  
  IF v_rest_method IS NULL OR (v_item_id NOT IN (''a_supp_150'',''a_supp_160'') AND instr('';'' || v_rest_method || '';'', '';'' || ''POST'' || '';'') > 0) THEN
    v_sql := q''[--不考虑供应商是否已经在平台注册
DECLARE
  v_t_sup_rec scmdata.t_supplier_info%ROWTYPE;
  v_supply_id VARCHAR2(32);
  v_supp_company_id VARCHAR2(32);
BEGIN

  v_supply_id                         := :supplier_info_id;
  v_t_sup_rec.supplier_info_id        := v_supply_id;
  v_t_sup_rec.company_id              := %default_company_id%;
  v_t_sup_rec.supplier_info_origin    := ''MA'';
  v_t_sup_rec.supplier_info_origin_id := NULL;
  v_t_sup_rec.status                  := 0;
  --基本信息
  v_t_sup_rec.supplier_company_name         := :sp_sup_company_name_y; --公司名称
  v_t_sup_rec.supplier_company_abbreviation := :sp_sup_company_abb_y; --公司简称
  v_t_sup_rec.social_credit_code            := :sp_social_credit_code_y; --统一社会信用代码
  --v_t_sup_rec.supplier_code                 := :sp_supplier_code_n; --供应商编号
  v_t_sup_rec.inside_supplier_code  := :sp_inside_supplier_code_n; --内部供应商编号
  v_t_sup_rec.company_regist_date   := :sp_company_regist_date_y; --公司注册日期
  v_t_sup_rec.company_province      := :company_province; --公司省
  v_t_sup_rec.company_city          := :company_city; --公司市
  v_t_sup_rec.company_county        := :company_county; --公司区
  v_t_sup_rec.company_vill          := :ar_company_vill_y; --公司乡镇
  v_t_sup_rec.company_address       := :sp_company_address_y; --公司地址
  v_t_sup_rec.group_name            := :sp_group_name_n; --分组名称（v9.9版 存值改为分组ID）
  v_t_sup_rec.legal_representative  := :sp_legal_represent_n; --法定代表人
  v_t_sup_rec.company_contact_phone := :sp_company_contact_phone_n; --公司联系电话
  v_t_sup_rec.fa_contact_name       := :sp_contact_name_y; --业务联系人
  v_t_sup_rec.fa_contact_phone      := :sp_contact_phone_y; --业务联系人手机
  v_t_sup_rec.company_type          := :sp_company_type_y; --公司类型
  v_t_sup_rec.is_our_factory        := :ar_is_our_factory_y; --是否本厂
  v_t_sup_rec.factroy_area          := :sp_factroy_area_y; --工厂面积（m2）
  v_t_sup_rec.remarks               := :sp_remarks_n; --备注

  --生产信息
  v_t_sup_rec.product_type      := :sp_product_type_y; --生产类型
  v_t_sup_rec.brand_type        := :sp_brand_type_n; --合作品牌/客户 类型
  v_t_sup_rec.cooperation_brand := :cooperation_brand; --合作品牌/客户
  v_t_sup_rec.product_link      := :sp_product_link_n; --生产环节

  v_t_sup_rec.product_line        := :sp_product_line_n; --生产线类型
  v_t_sup_rec.product_line_num    := :sp_product_line_num_n; --生产线数量
  v_t_sup_rec.quality_step        := :sp_quality_step_y; --质量等级
  v_t_sup_rec.work_hours_day      := :sp_work_hours_day_y; --上班时数/天
  v_t_sup_rec.worker_total_num    := :sp_worker_total_num_y; --总人数
  v_t_sup_rec.worker_num          := :sp_worker_num_y; --车位人数
  v_t_sup_rec.machine_num         := :sp_machine_num_y; --织机台数
  v_t_sup_rec.form_num            := :sp_form_num_y; --成型人数_鞋类
  v_t_sup_rec.product_efficiency  := :sp_product_efficiency_y; --产能效率
  v_t_sup_rec.pattern_cap         := :sp_pattern_cap_y; --打版能力
  v_t_sup_rec.fabric_purchase_cap := :sp_fabric_purchase_cap_y; --面料采购能力
  v_t_sup_rec.fabric_check_cap    := :sp_fabric_check_cap_y; --面料检测能力

  --合作信息
  v_t_sup_rec.pause := :sp_coop_state_y; --状态：0 启用 1 停用 2 试单

  SELECT MAX(fc.company_id)
    INTO v_supp_company_id
    FROM scmdata.sys_company fc
   WHERE fc.company_id = %default_company_id%
     AND fc.licence_num = :sp_social_credit_code_y;

  v_t_sup_rec.supplier_company_id := v_supp_company_id; --供应商在平台的企业id
  v_t_sup_rec.cooperation_type    := :sp_cooperation_type_y; --合作类型
  v_t_sup_rec.cooperation_model   := replace(:sp_cooperation_model_y,'' '','';'');
  v_t_sup_rec.coop_position       := :sp_coop_position_n; --合作定位
  v_t_sup_rec.pay_term            := :ar_pay_term_n; --付款条件

  --附件资料
  v_t_sup_rec.certificate_file  := :sp_certificate_file_y; --上传营业执照
  v_t_sup_rec.supplier_gate     := :sp_supplier_gate_n; --公司大门附件地址
  v_t_sup_rec.supplier_office   := :sp_supplier_office_n; --公司办公室附件地址
  v_t_sup_rec.supplier_site     := :sp_supplier_site_n; --生产现场附件地址
  v_t_sup_rec.supplier_product  := :sp_supplier_product_n; --产品图片附件地址
  v_t_sup_rec.other_information := :sp_other_information_n; --其他资料

  --其它
  v_t_sup_rec.create_id   := :user_id;
  v_t_sup_rec.create_date := SYSDATE;
  v_t_sup_rec.update_id   := :user_id; --修改人ID
  v_t_sup_rec.update_date := SYSDATE; --修改时间

  --1.新增 => 保存，校验数据
  scmdata.pkg_supplier_info.p_check_save_t_supplier_info(p_sp_data => v_t_sup_rec);
  --2.插入数据
  scmdata.pkg_supplier_info.p_insert_supplier_info(p_sp_data => v_t_sup_rec);
  --3.同步人员机器配置
  scmdata.pkg_supplier_info_a.p_generate_person_machine_config(p_company_id => %default_company_id%,p_user_id => :user_id,p_sup_id => v_supply_id);
  --4.同步合作工厂
  scmdata.pkg_supplier_info_a.p_generate_t_coop_factory_by_iu(p_company_id => %default_company_id%,p_supp_id => v_supply_id,p_user_id => :user_id);
END;
]'';
  ELSE
    v_sql := NULL;
  END IF;
  '|| CHR(64) ||'strresult := v_sql;
END;
}';
  v_sql2 := '--update sql by czh55 2023-01-10 02:54:52
{
DECLARE
  v_pk_id       VARCHAR2(32);
  v_rest_method VARCHAR2(256);
  v_params      VARCHAR2(256);
  v_sql         CLOB;
BEGIN
  --获取asscoiate请求参数
  pkg_plat_comm.p_get_rest_val_method_params(p_character     => NVL(%ass_supplier_info_id%,:supplier_info_id),
                                             po_pk_id        => v_pk_id,
                                             po_rest_methods => v_rest_method,
                                             po_params       => v_params);

  IF v_rest_method IS NULL OR instr('';'' || v_rest_method || '';'', '';'' || ''PUT'' || '';'') > 0 THEN
    v_sql := q''[
    DECLARE
      v_t_sup_rec       scmdata.t_supplier_info%ROWTYPE;
      v_supp_company_id VARCHAR2(32);
      v_supp_id         VARCHAR2(32) := NVL('']'' || v_pk_id || q''['',:supplier_info_id); --主键
    BEGIN
      v_t_sup_rec.supplier_info_id := v_supp_id; --主键
      v_t_sup_rec.company_id       := %default_company_id%; --公司编码
      --基本信息
      v_t_sup_rec.supplier_company_name         := :sp_sup_company_name_y; --公司名称
      v_t_sup_rec.supplier_company_abbreviation := :sp_sup_company_abb_y; --公司简称
      v_t_sup_rec.social_credit_code            := :sp_social_credit_code_y; --统一社会信用代码
      --v_t_sup_rec.supplier_code                 := :sp_supplier_code_n; --供应商编号
      v_t_sup_rec.inside_supplier_code  := :sp_inside_supplier_code_n; --内部供应商编号
      v_t_sup_rec.company_regist_date   := :sp_company_regist_date_y; --公司注册日期
      v_t_sup_rec.company_province      := :company_province; --公司省
      v_t_sup_rec.company_city          := :company_city; --公司市
      v_t_sup_rec.company_county        := :company_county; --公司区
      v_t_sup_rec.company_vill          := :ar_company_vill_y; --公司乡镇
      v_t_sup_rec.company_address       := :sp_company_address_y; --公司地址
      v_t_sup_rec.group_name            := :sp_group_name_n; --分组名称（v9.9版 存值改为分组ID）
      v_t_sup_rec.legal_representative  := :sp_legal_represent_n; --法定代表人
      v_t_sup_rec.company_contact_phone := :sp_company_contact_phone_n; --公司联系电话
      v_t_sup_rec.fa_contact_name       := :sp_contact_name_y; --业务联系人
      v_t_sup_rec.fa_contact_phone      := :sp_contact_phone_y; --业务联系人手机
      v_t_sup_rec.company_type          := :sp_company_type_y; --公司类型
      v_t_sup_rec.is_our_factory        := :ar_is_our_factory_y; --是否本厂
      v_t_sup_rec.factroy_area          := :sp_factroy_area_y; --工厂面积（m2）
      v_t_sup_rec.remarks               := :sp_remarks_n; --备注

      --生产信息
      v_t_sup_rec.product_type      := :sp_product_type_y; --生产类型
      v_t_sup_rec.brand_type        := :sp_brand_type_n; --合作品牌/客户 类型
      v_t_sup_rec.cooperation_brand := :cooperation_brand; --合作品牌/客户
      v_t_sup_rec.product_link      := :sp_product_link_n; --生产环节

      v_t_sup_rec.product_line        := :sp_product_line_n; --生产线类型
      v_t_sup_rec.product_line_num    := :sp_product_line_num_n; --生产线数量
      v_t_sup_rec.quality_step        := :sp_quality_step_y; --质量等级
      v_t_sup_rec.work_hours_day      := :sp_work_hours_day_y; --上班时数/天
      v_t_sup_rec.worker_total_num    := :sp_worker_total_num_y; --总人数
      v_t_sup_rec.worker_num          := :sp_worker_num_y; --车位人数
      v_t_sup_rec.machine_num         := :sp_machine_num_y; --织机台数
      v_t_sup_rec.form_num            := :sp_form_num_y; --成型人数_鞋类
      v_t_sup_rec.product_efficiency  := :sp_product_efficiency_y; --产能效率
      v_t_sup_rec.pattern_cap         := :sp_pattern_cap_y; --打版能力
      v_t_sup_rec.fabric_purchase_cap := :sp_fabric_purchase_cap_y; --面料采购能力
      v_t_sup_rec.fabric_check_cap    := :sp_fabric_check_cap_y; --面料检测能力

      --合作信息
      v_t_sup_rec.pause := :sp_coop_state_y; --状态：0 启用 1 停用 2 试单

      SELECT MAX(fc.company_id)
        INTO v_supp_company_id
        FROM scmdata.sys_company fc
       WHERE fc.company_id = %default_company_id%
         AND fc.licence_num = :sp_social_credit_code_y;

      v_t_sup_rec.supplier_company_id := v_supp_company_id; --供应商在平台的企业id
      v_t_sup_rec.cooperation_type    := :sp_cooperation_type_y; --合作类型
      v_t_sup_rec.cooperation_model   := replace(:sp_cooperation_model_y,'' '','';''); --合作模式
      v_t_sup_rec.coop_position       := :sp_coop_position_n; --合作定位
      v_t_sup_rec.pay_term            := :ar_pay_term_n; --付款条件

      --附件资料
      v_t_sup_rec.certificate_file  := :sp_certificate_file_y; --上传营业执照
      v_t_sup_rec.supplier_gate     := :sp_supplier_gate_n; --公司大门附件地址
      v_t_sup_rec.supplier_office   := :sp_supplier_office_n; --公司办公室附件地址
      v_t_sup_rec.supplier_site     := :sp_supplier_site_n; --生产现场附件地址
      v_t_sup_rec.supplier_product  := :sp_supplier_product_n; --产品图片附件地址
      v_t_sup_rec.other_information := :sp_other_information_n; --其他资料

      --其它
      v_t_sup_rec.update_id   := :user_id; --修改人ID
      v_t_sup_rec.update_date := SYSDATE; --修改时间

      --修改 t_supplier_info
      --1.更新=》保存，校验数据
      pkg_supplier_info.p_update_supplier_info(p_sp_data => v_t_sup_rec);
      --2.更新所在区域
      pkg_supplier_info.p_update_group_name(p_company_id       => %default_company_id%,
                                            p_supplier_info_id => v_supp_id,
                                            p_is_by_pick       => 1,
                                            p_province         => :company_province,
                                            p_city             => :company_city);
      --3.同步合作工厂
      scmdata.pkg_supplier_info_a.p_generate_t_coop_factory_by_iu(p_company_id => %default_company_id%,p_supp_id => v_supp_id,p_user_id => :user_id);                                       
    END update_supp_info;]'';
  ELSE
    v_sql := NULL;
  END IF;
  '|| CHR(64) ||'strresult := v_sql;
END;
}';
  
  UPDATE bw3.sys_item_list t
     SET t.insert_sql = v_sql1,
         t.update_sql = v_sql2
   WHERE t.item_id = 'a_supp_151';
END;
/
DECLARE
  v_sql1 CLOB;
  v_sql2 CLOB;
  v_sql3 CLOB;
BEGIN
  v_sql1 := '--czh 重构逻辑
{
DECLARE
  v_sql         CLOB;
  v_sup_id      VARCHAR2(32);
  v_rest_method VARCHAR2(256);
  v_params      VARCHAR2(256);
BEGIN
  --获取asscoiate请求参数
  pkg_plat_comm.p_get_rest_val_method_params(p_character     => %ass_supplier_info_id%,
                                             po_pk_id        => v_sup_id,
                                             po_rest_methods => v_rest_method,
                                             po_params       => v_params);
  IF v_rest_method IS NULL OR instr('';'' || v_rest_method || '';'', '';'' || ''POST'' || '';'') > 0 THEN
    --v_sql := pkg_supplier_info.f_insert_sup_coop_list(p_item_id => ''a_supp_151_1'',p_supp_id => v_sup_id);
    v_sql := q''[
DECLARE
  p_cp_data scmdata.t_coop_scope%ROWTYPE;
  v_supp_id VARCHAR2(32) := NVL('']'' || v_sup_id || q''['',:supplier_info_id);
BEGIN
  p_cp_data.coop_scope_id       := scmdata.f_get_uuid();
  p_cp_data.supplier_info_id    := v_supp_id;
  p_cp_data.company_id          := %default_company_id%;
  p_cp_data.coop_classification := :coop_classification;
  p_cp_data.coop_product_cate   := :coop_product_cate;
  p_cp_data.coop_subcategory    := :coop_subcategory;
  p_cp_data.create_id           := %user_id%;
  p_cp_data.create_time         := SYSDATE;
  p_cp_data.update_id           := %user_id%;
  p_cp_data.update_time         := SYSDATE;
  p_cp_data.remarks             := '''';
  p_cp_data.pause               := 0;
  p_cp_data.sharing_type        := :sharing_type;
  p_cp_data.publish_id          := '''';
  p_cp_data.publish_date        := '''';

  IF p_cp_data.coop_product_cate IS NULL THEN
    raise_application_error(-20002, ''生产类别不能为空，请填写'');
  ELSIF p_cp_data.coop_subcategory IS NULL THEN
    raise_application_error(-20002, ''合作产品子类不能为空，请填写'');
  ELSE
    scmdata.pkg_supplier_info.insert_coop_scope(p_cp_data => p_cp_data);
  END IF;
  --2.同步更新合作工厂-合作关系
  pkg_supplier_info.p_check_sup_fac_pause(p_company_id => %default_company_id%,
                                          p_sup_id     => v_supp_id);
  --3.新增日志操作
  --scmdata.pkg_supplier_info.insert_oper_log(v_supp_id,''修改档案-新增合作范围'','''',%user_id%,%default_company_id%,SYSDATE);

  --ZC314 ADD
  scmdata.pkg_capacity_inqueue.p_common_inqueue(v_curuserid => %current_userid%,
                                                v_compid    => %default_company_id%,
                                                v_tab       => ''SCMDATA.T_COOP_SCOPE'',
                                                v_viewtab   => NULL,
                                                v_unqfields => ''COOP_SCOPE_ID,COMPANY_ID'',
                                                v_ckfields  => ''COOP_CLASSIFICATION,COOP_PRODUCT_CATE,COOP_SUBCATEGORY,PAUSE,CREATE_ID,CREATE_TIME'',
                                                v_conds     => ''COOP_SCOPE_ID = '''''' ||
                                                               p_cp_data.coop_scope_id ||
                                                               '''''' AND COMPANY_ID = '''''' ||
                                                               %default_company_id% || '''''''',
                                                v_method    => ''INS'',
                                                v_viewlogic => NULL,
                                                v_queuetype => ''CAPC_SUPFILE_COOPSCOPEINFO_IU'');
END;]'';
  ELSE
    v_sql := NULL;
  END IF;
  '|| CHR(64) ||'strresult := v_sql;
END;
}';
  v_sql2 := '--czh 重构逻辑
{
DECLARE
  v_sql         CLOB;
  v_sup_id      VARCHAR2(32);
  v_rest_method VARCHAR2(256);
  v_params      VARCHAR2(256);
BEGIN
  --获取asscoiate请求参数
  pkg_plat_comm.p_get_rest_val_method_params(p_character     => %ass_supplier_info_id%,
                                             po_pk_id        => v_sup_id,
                                             po_rest_methods => v_rest_method,
                                             po_params       => v_params);
  IF v_rest_method IS NULL OR instr('';'' || v_rest_method || '';'', '';'' || ''PUT'' || '';'') > 0 THEN
    --v_sql := pkg_supplier_info.f_update_sup_coop_list(p_item_id => ''a_supp_151_1'',p_supp_id => v_sup_id);
    v_sql := q''[DECLARE
  p_cp_data scmdata.t_coop_scope%ROWTYPE;
  v_supp_id VARCHAR2(32) := NVL('']'' || v_sup_id || q''['',:supplier_info_id);
BEGIN
  p_cp_data.coop_scope_id       := :coop_scope_id;
  p_cp_data.supplier_info_id    := v_supp_id;
  p_cp_data.company_id          := %default_company_id%;
  p_cp_data.coop_classification := :coop_classification;
  p_cp_data.coop_product_cate   := :coop_product_cate;
  p_cp_data.coop_subcategory    := :coop_subcategory;
  p_cp_data.update_id           := %user_id%;
  p_cp_data.update_time         := SYSDATE;
  IF p_cp_data.coop_product_cate IS NULL THEN RAISE_APPLICATION_ERROR(-20002, ''生产类别不能为空，请填写'');
  ELSIF p_cp_data.coop_subcategory IS NULL THEN RAISE_APPLICATION_ERROR(-20002, ''合作产品子类不能为空，请填写'');
  ELSE
  scmdata.pkg_supplier_info.update_coop_scope(p_cp_data => p_cp_data);
  END IF;
  --2.同步更新合作工厂-合作关系
  pkg_supplier_info.p_check_sup_fac_pause(p_company_id => %default_company_id%,p_sup_id => v_supp_id);
  --3.新增日志操作
  --scmdata.pkg_supplier_info.insert_oper_log(v_supp_id,''修改档案-修改合作范围'','''',%user_id%,%default_company_id%,SYSDATE);
  --ZC314 ADD
  SCMDATA.PKG_CAPACITY_INQUEUE.P_COMMON_INQUEUE(V_CURUSERID  => %CURRENT_USERID%,
                                                V_COMPID     => %DEFAULT_COMPANY_ID%,
                                                V_TAB        => ''SCMDATA.T_COOP_SCOPE'',
                                                V_VIEWTAB    => NULL,
                                                V_UNQFIELDS  => ''COOP_SCOPE_ID,COMPANY_ID'',
                                                V_CKFIELDS   => ''COOP_CLASSIFICATION,COOP_PRODUCT_CATE,COOP_SUBCATEGORY,PAUSE,UPDATE_ID,UPDATE_TIME'',
                                                V_CONDS      => ''COOP_SCOPE_ID = ''''''||:COOP_SCOPE_ID||'''''' AND COMPANY_ID = ''''''||%DEFAULT_COMPANY_ID%||'''''''',
                                                V_METHOD     => ''UPD'',
                                                V_VIEWLOGIC  => NULL,
                                                V_QUEUETYPE  => ''CAPC_SUPFILE_COOPSCOPEINFO_IU'');
END;]'';
  ELSE
    v_sql := NULL;
  END IF;
  '|| CHR(64) ||'strresult := v_sql;
END;
}';
  v_sql3 := '--czh 重构逻辑
{
DECLARE
  v_sql         CLOB;
  v_sup_id      VARCHAR2(32);
  v_rest_method VARCHAR2(256);
  v_params      VARCHAR2(256);
BEGIN
  --获取asscoiate请求参数
  pkg_plat_comm.p_get_rest_val_method_params(p_character     => %ass_supplier_info_id%,
                                             po_pk_id        => v_sup_id,
                                             po_rest_methods => v_rest_method,
                                             po_params       => v_params);
  IF v_rest_method IS NULL THEN
    --v_sup_id := nvl(v_sup_id,:supplier_info_id);
    v_sql := q''[DECLARE
  p_cp_data scmdata.t_coop_scope%ROWTYPE;
  v_supp_id VARCHAR2(32) := NVL('']'' || v_sup_id || q''['',:supplier_info_id);
BEGIN
  p_cp_data.coop_scope_id       := :coop_scope_id;
  p_cp_data.supplier_info_id    := v_supp_id;
  p_cp_data.company_id          := %default_company_id%;
  scmdata.pkg_supplier_info.delete_coop_scope(p_cp_data => p_cp_data);
  --更新所在分组，区域组长
  pkg_supplier_info.p_update_group_name(p_company_id  => %default_company_id%,p_supplier_info_id => v_supp_id);
END;]'';
  ELSE
    v_sql := NULL;
  END IF;
  '|| CHR(64) ||'strresult := v_sql;
END;
}';
  
  UPDATE bw3.sys_item_list t
     SET t.insert_sql = v_sql1,
         t.update_sql = v_sql2,
         t.delete_sql = v_sql3
   WHERE t.item_id = 'a_supp_151_1';
END;
/
DECLARE
  v_sql1 CLOB;
  v_sql2 CLOB;
  v_sql3 CLOB;
BEGIN
  v_sql1 := '--insert sql by czh55 2023-01-03 06:02:59
{
DECLARE
  v_pk_id       VARCHAR2(32);
  v_rest_method VARCHAR2(256);
  v_params      VARCHAR2(256);
  v_sql         CLOB;
BEGIN
  --获取asscoiate请求参数
  pkg_plat_comm.p_get_rest_val_method_params(p_character     => %ass_supplier_info_id%,
                                             po_pk_id        => v_pk_id,
                                             po_rest_methods => v_rest_method,
                                             po_params       => v_params);

  IF v_rest_method IS NULL OR instr('';'' || v_rest_method || '';'', '';'' || ''POST'' || '';'') > 0 THEN
   v_sql := q''[
    DECLARE
      v_t_mac_rec t_machine_equipment_sup%ROWTYPE;
      v_pk_id VARCHAR2(32) := NVL('']'' || v_pk_id || q''['',:supplier_info_id);
      v_seqno     INT;
    BEGIN
      v_t_mac_rec.machine_equipment_id  := scmdata.f_get_uuid(); --机器设备(供应商档案)主键ID
      v_t_mac_rec.company_id            := %default_company_id%; --企业ID
      v_t_mac_rec.equipment_category_id := :ar_equipment_cate_n; --设备分类ID
      v_t_mac_rec.equipment_name        := :ar_equipment_name_y; --设备名称
      SELECT nvl(MAX(t.seqno), 0) + 1
        INTO v_seqno
      FROM scmdata.t_machine_equipment_sup t
     WHERE t.supplier_info_id = v_pk_id
       AND t.company_id = %default_company_id%;
      v_t_mac_rec.seqno                 := v_seqno; --序号
      v_t_mac_rec.orgin                 := ''MA''; --来源
      v_t_mac_rec.pause                 := 0; --是否禁用(0正常,1禁用)
      v_t_mac_rec.remarks               := :remarks; --备注
      v_t_mac_rec.update_id             := :user_id; --更新人
      v_t_mac_rec.update_time           := SYSDATE; --更新时间
      v_t_mac_rec.create_id             := :user_id; --创建人
      v_t_mac_rec.create_time           := SYSDATE; --创建时间
      v_t_mac_rec.supplier_info_id      := v_pk_id; --供应商档案ID
      v_t_mac_rec.machine_num           := nvl(:ar_machine_num_n,0); --设备数量
      
      scmdata.pkg_supplier_info_a.p_check_t_machine_equipment_sup(p_t_mac_rec => v_t_mac_rec);
      --新增 t_machine_equipment_sup
      scmdata.pkg_supplier_info_a.p_insert_t_machine_equipment_sup(p_t_mac_rec => v_t_mac_rec);
    END;]'';
  ELSE
    v_sql := NULL;
  END IF;
  '|| CHR(64) ||'strresult := v_sql;
END;
}';
  v_sql2 := '--update sql by czh55 2023-01-03 06:02:59
{
DECLARE
  v_sql           CLOB;
  v_supp_id       VARCHAR2(32);
  v_rest_method   VARCHAR2(256);
  v_params        VARCHAR2(2000);
BEGIN
  --获取asscoiate请求参数
  pkg_plat_comm.p_get_rest_val_method_params(p_character     => %ass_supplier_info_id%,
                                             po_pk_id        => v_supp_id,
                                             po_rest_methods => v_rest_method,
                                             po_params       => v_params);
  v_rest_method := nvl(v_rest_method, ''PUT'');
  IF v_rest_method IS NULL OR instr('';'' || v_rest_method || '';'', '';'' || ''PUT'' || '';'') > 0 THEN
    v_sql := q''[
DECLARE
  v_t_mac_rec t_machine_equipment_sup%ROWTYPE;
  v_supp_id VARCHAR2(32) := NVL('']'' || v_supp_id || q''['',:supplier_info_id);
BEGIN
  v_t_mac_rec.machine_equipment_id  := :machine_equipment_id;
  v_t_mac_rec.equipment_category_id := :ar_equipment_cate_n;
  v_t_mac_rec.equipment_name        := :ar_equipment_name_y;
  v_t_mac_rec.machine_num           := nvl(:ar_machine_num_n,0);
  v_t_mac_rec.remarks               := :remarks;
  v_t_mac_rec.update_id             := :user_id;
  v_t_mac_rec.update_time           := SYSDATE;
  v_t_mac_rec.supplier_info_id      := v_supp_id; --供应商档案ID
  scmdata.pkg_supplier_info_a.p_check_t_machine_equipment_sup(p_t_mac_rec => v_t_mac_rec);
  scmdata.pkg_supplier_info_a.p_update_t_machine_equipment_sup(p_t_mac_rec => v_t_mac_rec);
END;
]'';
  ELSE
    v_sql := NULL;
  END IF;
  '|| CHR(64) ||'strresult := v_sql;
END;
}';
  v_sql3 := '--delete sql by czh55 2023-01-03 06:02:59
{
DECLARE
  v_sql           CLOB;
  v_supp_id       VARCHAR2(32);
  v_rest_method   VARCHAR2(256);
  v_params        VARCHAR2(2000);
BEGIN
  --获取asscoiate请求参数
  pkg_plat_comm.p_get_rest_val_method_params(p_character     => %ass_supplier_info_id%,
                                             po_pk_id        => v_supp_id,
                                             po_rest_methods => v_rest_method,
                                             po_params       => v_params);
  v_rest_method := nvl(v_rest_method, ''DELETE'');
  IF v_rest_method IS NULL OR instr('';'' || v_rest_method || '';'', '';'' || ''DELETE'' || '';'') > 0 THEN
    v_sql := q''[
DECLARE
  v_t_mac_rec t_machine_equipment_sup%ROWTYPE;
  v_supp_id VARCHAR2(32) := NVL('']'' || v_supp_id || q''['',:supplier_info_id);
BEGIN
  v_t_mac_rec.machine_equipment_id  := :machine_equipment_id;
  v_t_mac_rec.orgin                 := :orgin_val;
  scmdata.pkg_supplier_info_a.p_delete_t_machine_equipment_sup(p_t_mac_rec => v_t_mac_rec);
END;
]'';
  ELSE
    v_sql := NULL;
  END IF;
  '|| CHR(64) ||'strresult := v_sql;
END;
}';
  
  UPDATE bw3.sys_item_list t
     SET t.insert_sql = v_sql1,
         t.update_sql = v_sql2,
         t.delete_sql = v_sql3
   WHERE t.item_id = 'a_supp_151_10';
END;
/
DECLARE
 v_sql CLOB;
BEGIN
  v_sql := q'[
{
DECLARE
  v_sql CLOB;
BEGIN

  v_sql := scmdata.pkg_ask_record_mange.f_query_picksql_by_type(p_group_dict_type   => 'SUPPLY_TYPE',
                                                                p_dict_value        => 'AR_COOPERATION_MODEL_Y',
                                                                p_dict_desc         => 'AR_COOP_MODEL_DESC_Y',
                                                                p_setnull_fdvalue_1 => 'AR_PAY_TERM_N',
                                                                p_setnull_fddesc_1  => 'AR_PAY_TERM_DESC_N',
                                                                p_setnull_fdvalue_2 => 'AR_PRODUCT_TYPE_Y',
                                                                p_setnull_fddesc_2  => 'AR_PRODUCT_TYPE_DESC_Y',
                                                                p_setnull_fdvalue_3 => 'AR_COMPANY_TYPE_Y',
                                                                p_setnull_fddesc_3  => 'AR_COMPANY_TYPE_DESC_Y');

  ]'|| CHR(64) ||q'[strresult := v_sql;
END;
}]';
UPDATE bw3.sys_pick_list t SET t.pick_sql = v_sql WHERE t.element_id = 'pick_a_coop_151_4';
END;
/
DECLARE
v_sql CLOB;
BEGIN
v_sql := q'[--czh 重构代码
{DECLARE
  v_sql CLOB;
BEGIN
  v_sql      := scmdata.pkg_plat_comm.f_get_lookup_sql_by_type(p_group_dict_type => 'COM_MANUFACTURER',
                                                               p_field_value     => 'COOP_FACTORY_TYPE',
                                                               p_field_desc      => 'COOP_FACTORY_TYPE_DESC');
  ]'|| CHR(64) || q'[strresult := v_sql;
END;}]';
UPDATE bw3.sys_look_up t SET t.look_up_sql = v_sql WHERE t.element_id = 'look_a_supp_151_7_2'; 
END;
/
BEGIN
insert into bw3.sys_field_list (FIELD_NAME, CAPTION, REQUIERED_FLAG, INPUT_HINT, VALID_CHARS, INVALID_CHARS, CHECK_EXPRESS, CHECK_MESSAGE, READ_ONLY_FLAG, NO_EDIT, NO_COPY, NO_SUM, NO_SORT, ALIGNMENT, MAX_LENGTH, MIN_LENGTH, DISPLAY_WIDTH, DISPLAY_FORMAT, EDIT_FORMT, DATA_TYPE, MAX_VALUE, MIN_VALUE, DEFAULT_VALUE, IME_CARE, IME_OPEN, VALUE_LISTS, VALUE_LIST_TYPE, HYPER_RES, MULTI_VALUE_FLAG, TRUE_EXPR, FALSE_EXPR, NAME_RULE_FLAG, NAME_RULE_ID, DATA_TYPE_FLAG, ALLOW_SCAN, VALUE_ENCRYPT, VALUE_SENSITIVE, OPERATOR_FLAG, VALUE_DISPLAY_STYLE, TO_ITEM_ID, VALUE_SENSITIVE_REPLACEMENT, STORE_SOURCE, ENABLE_STAND_PERMISSION)
values ('FA_COMPANY_NAME', '工厂名称', 0, null, null, null, null, null, 0, 0, 0, null, 0, 2, null, null, null, null, null, null, null, null, null, 0, 0, null, null, null, null, null, null, null, null, 1, null, null, null, null, null, null, null, null, null);
END;
/
