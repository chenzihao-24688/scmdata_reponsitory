--update sql by czh55 2023-01-10 02:54:52
DECLARE
  v_pk_id           VARCHAR2(32);
  v_rest_method     VARCHAR2(256);
  v_params          VARCHAR2(256);
  v_supp_company_id VARCHAR2(32);
BEGIN
  --获取asscoiate请求参数
  pkg_plat_comm.p_get_rest_val_method_params(p_character     => %supplier_info_id%,
                                             po_pk_id        => v_pk_id,
                                             po_rest_methods => v_rest_method,
                                             po_params       => v_params);

  IF instr(';' || v_rest_method || ';', ';' || 'PUT' || ';') > 0 THEN
  
    v_t_sup_rec.supplier_info_id := v_pk_id; --主键
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
    v_t_sup_rec.company_vill          := :sp_company_vill_y; --公司乡镇
    v_t_sup_rec.company_address       := :sp_company_address_y; --公司地址
    v_t_sup_rec.group_name            := :sp_group_name_n; --分组名称（v9.9版 存值改为分组ID）
    v_t_sup_rec.legal_representative  := :sp_legal_represent_n; --法定代表人
    v_t_sup_rec.company_contact_phone := :sp_company_contact_phone_n; --公司联系电话
    v_t_sup_rec.fa_contact_name       := :sp_contact_name_y; --业务联系人
    v_t_sup_rec.fa_contact_phone      := :sp_contact_phone_y; --业务联系人手机
    v_t_sup_rec.company_type          := :sp_company_type_y; --公司类型
    v_t_sup_rec.is_our_factory        := :sp_is_our_factory_y; --是否本厂
    v_t_sup_rec.factroy_area          := :sp_factroy_area_y; --工厂面积（m2）
    v_t_sup_rec.remarks               := :sp_remarks_n; --备注
  
    --生产信息
    v_t_sup_rec.product_type      := :sp_product_type_y; --生产类型
    v_t_sup_rec.brand_type        := :sp_brand_type_n; --合作品牌/客户 类型
    v_t_sup_rec.cooperation_brand := :sp_cooperation_brand_n; --合作品牌/客户
    v_t_sup_rec.product_link      := :sp_product_link_n; --生产环节
  
    v_t_sup_rec.product_line        := :sp_product_line_n; --生产线类型
    v_t_sup_rec.product_line_num    := :sp_product_line_num_n; --生产线数量
    v_t_sup_rec.quality_step        := :sp_quality_step_n; --质量等级
    v_t_sup_rec.work_hours_day      := :sp_work_hours_day_n; --上班时数/天
    v_t_sup_rec.worker_total_num    := :sp_worker_total_num_n; --总人数
    v_t_sup_rec.worker_num          := :sp_worker_num_n; --车位人数
    v_t_sup_rec.machine_num         := :sp_machine_num_n; --织机台数
    v_t_sup_rec.form_num            := :sp_form_num_n; --成型人数_鞋类
    v_t_sup_rec.product_efficiency  := :sp_product_efficiency_n; --产能效率
    v_t_sup_rec.pattern_cap         := :sp_pattern_cap_n; --打版能力
    v_t_sup_rec.fabric_purchase_cap := :sp_fabric_purchase_cap_n; --面料采购能力
    v_t_sup_rec.fabric_check_cap    := :sp_fabric_check_cap_n; --面料检测能力
  
    --合作信息
    v_t_sup_rec.pause := :sp_coop_status_y; --状态：0 启用 1 停用 2 试单  
  
    SELECT MAX(fc.company_id)
      INTO v_supp_company_id
      FROM scmdata.sys_company fc
     WHERE fc.company_id = %default_company_id%
       AND fc.licence_num = :sp_social_credit_code_y;
  
    v_t_sup_rec.supplier_company_id := v_supp_company_id; --供应商在平台的企业id   
    v_t_sup_rec.cooperation_type    := :sp_cooperation_type_y; --合作类型   
    v_t_sup_rec.cooperation_model   := :sp_cooperation_model_n; --合作模式
    v_t_sup_rec.coop_position       := :sp_coop_position_n; --合作定位
    v_t_sup_rec.pay_term            := :sp_pay_term_n; --付款条件    
  
    --附件资料
    v_t_sup_rec.certificate_file  := :sp_certificate_file_y; --上传营业执照
    v_t_sup_rec.supplier_gate     := :sp_supplier_gate_n; --公司大门附件地址
    v_t_sup_rec.supplier_office   := :sp_supplier_office_n; --公司办公室附件地址
    v_t_sup_rec.supplier_site     := :sp_supplier_site_n; --生产现场附件地址
    v_t_sup_rec.supplier_product  := :sp_supplier_product_n; --产品图片附件地址
    v_t_sup_rec.other_information := :sp_other_information_n; --其他资料
    
    --其它
    
  
    v_t_sup_rec.company_create_date        := :sp_company_create_date_n; --成立日期
    v_t_sup_rec.regist_address             := :sp_regist_address_n; --注册地址
    v_t_sup_rec.certificate_validity_start := :sp_certificate_validity_start_n; --营业执照开始有效期
    v_t_sup_rec.certificate_validity_end   := :sp_certificate_validity_end_n; --营业执照截止有效期  
  
    v_t_sup_rec.company_person         := :sp_company_person_n; --公司员工总人数（v9.10 作废）
    v_t_sup_rec.company_contact_person := :sp_company_contact_person_n; --公司联系人（v9.10 作废）
    v_t_sup_rec.company_contact_phone  := :sp_company_contact_phone_n; --公司联系人手机
    v_t_sup_rec.taxpayer               := :sp_taxpayer_n; --纳税人身份（v9.10 作废）
    v_t_sup_rec.company_say            := :sp_company_say_n; --公司简介（v9.10 作废）
  
    v_t_sup_rec.organization_file  := :sp_organization_file_n; --上传组织架构图（v9.10 作废）
    v_t_sup_rec.contract_stop_date := :sp_contract_stop_date_n; --合同有效期至（v9.10 作废）
    v_t_sup_rec.contract_file      := :sp_contract_file_n; --上传合同附件（v9.10 作废）
    v_t_sup_rec.cooperation_method := :sp_cooperation_method_n; --合作方式（v9.10 作废）
  
    v_t_sup_rec.production_mode := :sp_production_mode_n; --生产模式（v9.10 作废）
  
    v_t_sup_rec.cooperation_classification := :sp_cooperation_classification_n; --合作分类（v9.10 作废）
    v_t_sup_rec.cooperation_subcategory    := :sp_cooperation_subcategory_n; --合作子类（v9.10 作废）
    v_t_sup_rec.sharing_type               := :sp_sharing_type_n; --共享类型（v9.10 作废）
    v_t_sup_rec.public_accounts            := :sp_public_accounts_n; --对公账号（v9.10 作废）
    v_t_sup_rec.public_payment             := :sp_public_payment_n; --对公收款人（v9.10 作废）
    v_t_sup_rec.public_bank                := :sp_public_bank_n; --对公开户行（v9.10 作废）
    v_t_sup_rec.public_id                  := :sp_public_id_n; --对公身份证号（v9.10 作废）
    v_t_sup_rec.public_phone               := :sp_public_phone_n; --对公联系电话（v9.10 作废）
    v_t_sup_rec.personal_account           := :sp_personal_account_n; --个人账号（v9.10 作废）
    v_t_sup_rec.personal_payment           := :sp_personal_payment_n; --个人收款人（v9.10 作废）
    v_t_sup_rec.personal_bank              := :sp_personal_bank_n; --个人开户行（v9.10 作废）
    v_t_sup_rec.personal_idcard            := :sp_personal_idcard_n; --个人身份证号（v9.10 作废）
    v_t_sup_rec.personal_phone             := :sp_personal_phone_n; --个人联系电话（v9.10 作废）
    v_t_sup_rec.pay_type                   := :sp_pay_type_n; --付款方式（v9.10 作废）
    v_t_sup_rec.settlement_type            := :sp_settlement_type_n; --结算方式（v9.10 作废）
    v_t_sup_rec.reconciliation_user        := :sp_reconciliation_user_n; --对账联系人（v9.10 作废）
    v_t_sup_rec.reconciliation_phone       := :sp_reconciliation_phone_n; --对账联系电话（v9.10 作废）
    v_t_sup_rec.contract_start_date        := :sp_contract_start_date_n; --合同有效期从（v9.10 作废）
    v_t_sup_rec.create_supp_date           := :sp_create_supp_date_n; --建档日期
  
    v_t_sup_rec.gendan_perid            := :sp_gendan_perid_n; --跟单员ID
    v_t_sup_rec.supplier_info_origin    := :sp_supplier_info_origin_y; --来源
    v_t_sup_rec.supplier_info_origin_id := :sp_supplier_info_origin_id_n; --来源ID
    v_t_sup_rec.status                  := :sp_status_n; --建档状态：0 未建档 1 已建档
    v_t_sup_rec.coop_state              := :sp_coop_state_n; --合作状态：COOP_01 试单 COOP_02 正常 COOP_03 停用 （作废）
    v_t_sup_rec.bind_status             := :sp_bind_status_n; --绑定状态
  
    v_t_sup_rec.publish_id   := :sp_publish_id_n; --发布人（接口）
    v_t_sup_rec.publish_date := :sp_publish_date_n; --发布时间（接口）
    v_t_sup_rec.create_id    := :user_id; --创建人ID
    v_t_sup_rec.create_date  := SYSDATE; --创建时间
    v_t_sup_rec.update_id    := :user_id; --修改人ID
    v_t_sup_rec.update_date  := SYSDATE; --修改时间
  
    v_t_sup_rec.file_remark       := :sp_file_remark_n; --附件备注（v9.10 作废）
    v_t_sup_rec.reserve_capacity  := :sp_reserve_capacity_n; --预约产能占比（v9.10 作废）
    v_t_sup_rec.area_group_leader := :sp_area_group_leader_n; --区域组长（v9.10 作废）
    v_t_sup_rec.ask_files         := :sp_ask_files_n; --附件（v9.10 作废）
    v_t_sup_rec.admit_result      := :sp_admit_result_n; --准入结果
    v_t_sup_rec.pause_cause       := :sp_pause_cause_n; --启停原因
    v_t_sup_rec.group_name_origin := :sp_group_name_origin_n; --分组来源：AA 自动生成，MA 手动编辑
  
    v_t_sup_rec.regist_price := :sp_regist_price_n; --注册资本 
  
    --修改 t_supplier_info
    --1.更新=》保存，校验数据
    pkg_supplier_info.update_supplier_info(p_sp_data => v_sp_data);
    --2.更新所在区域
    pkg_supplier_info.p_update_group_name(p_company_id       => %default_company_id%,
                                          p_supplier_info_id => :supplier_info_id,
                                          p_is_by_pick       => 1,
                                          p_province         => :company_province,
                                          p_city             => :company_city);
  ELSE
    NULL;
  END IF;
END;
