--新增供应商
DECLARE
  p_sp_data            scmdata.t_supplier_info%ROWTYPE;
  p_default_company_id VARCHAR2(1000) := 'a972dd1ffe3b3a10e0533c281cac8fd7';
  p_status             VARCHAR2(20) := 'NEW';
BEGIN
  SELECT 'GY2105315513694916',
         NULL,
         NULL,
         '菲托服装公司',
         '130000',
         '130600',
         '130683',
         '河北保定安国',
         '菲托服装公司',
         '112233445566778811',
         '陈子豪',
         NULL,
         '00',
         'ODM',
         NULL,
         NULL,
         NULL,
         NULL,
         'PRODUCT_TYPE',
         'CZH',
         'MA',
         NULL
    INTO p_sp_data.supplier_info_id,
         p_sp_data.supplier_code,
         p_sp_data.inside_supplier_code,
         p_sp_data.supplier_company_name,
         p_sp_data.company_province,
         p_sp_data.company_city,
         p_sp_data.company_county,
         p_sp_data.company_address,
         p_sp_data.supplier_company_abbreviation,
         p_sp_data.social_credit_code,
         p_sp_data.legal_representative,
         p_sp_data.company_contact_person,
         p_sp_data.company_type,
         p_sp_data.cooperation_model,
         p_sp_data.cooperation_classification,
         p_sp_data.company_contact_phone,
         p_sp_data.certificate_file,
         p_sp_data.company_say,
         p_sp_data.cooperation_type,
         p_sp_data.create_id,
         p_sp_data.supplier_info_origin,
         p_sp_data.remarks
    FROM dual;
  scmdata.pkg_supplier_info.check_save_t_supplier_info(p_sp_data            => p_sp_data,
                                                       p_default_company_id => p_default_company_id,
                                                       p_status             => p_status);
  scmdata.pkg_supplier_info.insert_supplier_info(p_sp_data            => p_sp_data,
                                                 p_default_company_id => p_default_company_id);
END;
/
--新增合作范围
DECLARE p_cp_data scmdata.t_coop_scope%ROWTYPE;
BEGIN
  p_cp_data.coop_scope_id       := scmdata.f_get_uuid();
  p_cp_data.supplier_info_id    := 'GY2105315513694916';
  p_cp_data.company_id          := 'a972dd1ffe3b3a10e0533c281cac8fd7';
  p_cp_data.coop_classification := '00';
  p_cp_data.coop_product_cate   := '0011';
  p_cp_data.coop_subcategory    := '001102';
  p_cp_data.create_id           := 'CZH';
  p_cp_data.create_time         := SYSDATE;
  p_cp_data.update_id           := 'CZH';
  p_cp_data.update_time         := SYSDATE;
  p_cp_data.remarks             := '';
  p_cp_data.pause               := 0;
  p_cp_data.sharing_type        := '00';
  p_cp_data.publish_id          := '';
  p_cp_data.publish_date        := '';
  scmdata.pkg_supplier_info.insert_coop_scope(p_cp_data => p_cp_data);
END;
/
--提交
DECLARE
BEGIN
  pkg_supplier_info.submit_t_supplier_info(p_supplier_info_id   => 'GY2105315513694916',
                                           p_default_company_id => 'a972dd1ffe3b3a10e0533c281cac8fd7',
                                           p_user_id            => '18172543571');
END;
