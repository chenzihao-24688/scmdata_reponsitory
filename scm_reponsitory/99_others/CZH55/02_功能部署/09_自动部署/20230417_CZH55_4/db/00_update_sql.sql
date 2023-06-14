DECLARE
v_sql CLOB;
BEGIN
v_sql := '--update sql by czh55 2023-01-10 02:54:52
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
  --v_t_sup_rec.supplier_code               := :sp_supplier_code_n; --供应商编号
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
   WHERE fc.licence_num = :sp_social_credit_code_y;

  v_t_sup_rec.supplier_company_id := v_supp_company_id; --供应商在平台的企业id
  v_t_sup_rec.cooperation_type    := :sp_cooperation_type_y; --合作类型
  v_t_sup_rec.cooperation_model   := REPLACE(:sp_cooperation_model_y,
                                             '' '',
                                             '';''); --合作模式
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
  IF scmdata.pkg_plat_comm.f_is_check_fields_eq(p_old_field => :old_company_province || :old_company_city,
                                                p_new_field => :company_province || :company_city) = 0 THEN
    pkg_supplier_info.p_update_group_name(p_company_id       => %default_company_id%,
                                          p_supplier_info_id => v_supp_id,
                                          p_is_by_pick       => 1,
                                          p_province         => :company_province,
                                          p_city             => :company_city);
  END IF;
  --3.同步合作工厂
  IF scmdata.pkg_plat_comm.f_is_check_fields_eq(p_old_field => :old_ar_is_our_factory_y || :old_sp_coop_state_y,
                                                p_new_field => :ar_is_our_factory_y || :sp_coop_state_y) = 0 THEN
    scmdata.pkg_supplier_info_a.p_generate_t_coop_factory_by_iu(p_company_id => %default_company_id%,
                                                                p_supp_id    => v_supp_id,
                                                                p_user_id    => :user_id);
  END IF;
END update_supp_info;
]'';
  ELSE
    v_sql := NULL;
  END IF;
  @strresult := v_sql;
END;
}';
UPDATE bw3.sys_item_list t SET t.update_sql = v_sql WHERE t.item_id = 'a_supp_151';
END;
/
