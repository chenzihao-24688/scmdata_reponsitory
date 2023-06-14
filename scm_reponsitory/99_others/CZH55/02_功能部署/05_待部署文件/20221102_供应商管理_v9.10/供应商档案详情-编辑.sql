--update sql by czh55 2023-01-10 02:54:52
DECLARE
  v_pk_id           VARCHAR2(32);
  v_rest_method     VARCHAR2(256);
  v_params          VARCHAR2(256);
  v_supp_company_id VARCHAR2(32);
BEGIN
  --��ȡasscoiate�������
  pkg_plat_comm.p_get_rest_val_method_params(p_character     => %supplier_info_id%,
                                             po_pk_id        => v_pk_id,
                                             po_rest_methods => v_rest_method,
                                             po_params       => v_params);

  IF instr(';' || v_rest_method || ';', ';' || 'PUT' || ';') > 0 THEN
  
    v_t_sup_rec.supplier_info_id := v_pk_id; --����
    v_t_sup_rec.company_id       := %default_company_id%; --��˾����
    --������Ϣ
    v_t_sup_rec.supplier_company_name         := :sp_sup_company_name_y; --��˾����
    v_t_sup_rec.supplier_company_abbreviation := :sp_sup_company_abb_y; --��˾���
    v_t_sup_rec.social_credit_code            := :sp_social_credit_code_y; --ͳһ������ô���
    --v_t_sup_rec.supplier_code                 := :sp_supplier_code_n; --��Ӧ�̱��
    v_t_sup_rec.inside_supplier_code  := :sp_inside_supplier_code_n; --�ڲ���Ӧ�̱��
    v_t_sup_rec.company_regist_date   := :sp_company_regist_date_y; --��˾ע������
    v_t_sup_rec.company_province      := :company_province; --��˾ʡ
    v_t_sup_rec.company_city          := :company_city; --��˾��
    v_t_sup_rec.company_county        := :company_county; --��˾��
    v_t_sup_rec.company_vill          := :sp_company_vill_y; --��˾����
    v_t_sup_rec.company_address       := :sp_company_address_y; --��˾��ַ
    v_t_sup_rec.group_name            := :sp_group_name_n; --�������ƣ�v9.9�� ��ֵ��Ϊ����ID��
    v_t_sup_rec.legal_representative  := :sp_legal_represent_n; --����������
    v_t_sup_rec.company_contact_phone := :sp_company_contact_phone_n; --��˾��ϵ�绰
    v_t_sup_rec.fa_contact_name       := :sp_contact_name_y; --ҵ����ϵ��
    v_t_sup_rec.fa_contact_phone      := :sp_contact_phone_y; --ҵ����ϵ���ֻ�
    v_t_sup_rec.company_type          := :sp_company_type_y; --��˾����
    v_t_sup_rec.is_our_factory        := :sp_is_our_factory_y; --�Ƿ񱾳�
    v_t_sup_rec.factroy_area          := :sp_factroy_area_y; --���������m2��
    v_t_sup_rec.remarks               := :sp_remarks_n; --��ע
  
    --������Ϣ
    v_t_sup_rec.product_type      := :sp_product_type_y; --��������
    v_t_sup_rec.brand_type        := :sp_brand_type_n; --����Ʒ��/�ͻ� ����
    v_t_sup_rec.cooperation_brand := :sp_cooperation_brand_n; --����Ʒ��/�ͻ�
    v_t_sup_rec.product_link      := :sp_product_link_n; --��������
  
    v_t_sup_rec.product_line        := :sp_product_line_n; --����������
    v_t_sup_rec.product_line_num    := :sp_product_line_num_n; --����������
    v_t_sup_rec.quality_step        := :sp_quality_step_n; --�����ȼ�
    v_t_sup_rec.work_hours_day      := :sp_work_hours_day_n; --�ϰ�ʱ��/��
    v_t_sup_rec.worker_total_num    := :sp_worker_total_num_n; --������
    v_t_sup_rec.worker_num          := :sp_worker_num_n; --��λ����
    v_t_sup_rec.machine_num         := :sp_machine_num_n; --֯��̨��
    v_t_sup_rec.form_num            := :sp_form_num_n; --��������_Ь��
    v_t_sup_rec.product_efficiency  := :sp_product_efficiency_n; --����Ч��
    v_t_sup_rec.pattern_cap         := :sp_pattern_cap_n; --�������
    v_t_sup_rec.fabric_purchase_cap := :sp_fabric_purchase_cap_n; --���ϲɹ�����
    v_t_sup_rec.fabric_check_cap    := :sp_fabric_check_cap_n; --���ϼ������
  
    --������Ϣ
    v_t_sup_rec.pause := :sp_coop_status_y; --״̬��0 ���� 1 ͣ�� 2 �Ե�  
  
    SELECT MAX(fc.company_id)
      INTO v_supp_company_id
      FROM scmdata.sys_company fc
     WHERE fc.company_id = %default_company_id%
       AND fc.licence_num = :sp_social_credit_code_y;
  
    v_t_sup_rec.supplier_company_id := v_supp_company_id; --��Ӧ����ƽ̨����ҵid   
    v_t_sup_rec.cooperation_type    := :sp_cooperation_type_y; --��������   
    v_t_sup_rec.cooperation_model   := :sp_cooperation_model_n; --����ģʽ
    v_t_sup_rec.coop_position       := :sp_coop_position_n; --������λ
    v_t_sup_rec.pay_term            := :sp_pay_term_n; --��������    
  
    --��������
    v_t_sup_rec.certificate_file  := :sp_certificate_file_y; --�ϴ�Ӫҵִ��
    v_t_sup_rec.supplier_gate     := :sp_supplier_gate_n; --��˾���Ÿ�����ַ
    v_t_sup_rec.supplier_office   := :sp_supplier_office_n; --��˾�칫�Ҹ�����ַ
    v_t_sup_rec.supplier_site     := :sp_supplier_site_n; --�����ֳ�������ַ
    v_t_sup_rec.supplier_product  := :sp_supplier_product_n; --��ƷͼƬ������ַ
    v_t_sup_rec.other_information := :sp_other_information_n; --��������
    
    --����
    
  
    v_t_sup_rec.company_create_date        := :sp_company_create_date_n; --��������
    v_t_sup_rec.regist_address             := :sp_regist_address_n; --ע���ַ
    v_t_sup_rec.certificate_validity_start := :sp_certificate_validity_start_n; --Ӫҵִ�տ�ʼ��Ч��
    v_t_sup_rec.certificate_validity_end   := :sp_certificate_validity_end_n; --Ӫҵִ�ս�ֹ��Ч��  
  
    v_t_sup_rec.company_person         := :sp_company_person_n; --��˾Ա����������v9.10 ���ϣ�
    v_t_sup_rec.company_contact_person := :sp_company_contact_person_n; --��˾��ϵ�ˣ�v9.10 ���ϣ�
    v_t_sup_rec.company_contact_phone  := :sp_company_contact_phone_n; --��˾��ϵ���ֻ�
    v_t_sup_rec.taxpayer               := :sp_taxpayer_n; --��˰����ݣ�v9.10 ���ϣ�
    v_t_sup_rec.company_say            := :sp_company_say_n; --��˾��飨v9.10 ���ϣ�
  
    v_t_sup_rec.organization_file  := :sp_organization_file_n; --�ϴ���֯�ܹ�ͼ��v9.10 ���ϣ�
    v_t_sup_rec.contract_stop_date := :sp_contract_stop_date_n; --��ͬ��Ч������v9.10 ���ϣ�
    v_t_sup_rec.contract_file      := :sp_contract_file_n; --�ϴ���ͬ������v9.10 ���ϣ�
    v_t_sup_rec.cooperation_method := :sp_cooperation_method_n; --������ʽ��v9.10 ���ϣ�
  
    v_t_sup_rec.production_mode := :sp_production_mode_n; --����ģʽ��v9.10 ���ϣ�
  
    v_t_sup_rec.cooperation_classification := :sp_cooperation_classification_n; --�������ࣨv9.10 ���ϣ�
    v_t_sup_rec.cooperation_subcategory    := :sp_cooperation_subcategory_n; --�������ࣨv9.10 ���ϣ�
    v_t_sup_rec.sharing_type               := :sp_sharing_type_n; --�������ͣ�v9.10 ���ϣ�
    v_t_sup_rec.public_accounts            := :sp_public_accounts_n; --�Թ��˺ţ�v9.10 ���ϣ�
    v_t_sup_rec.public_payment             := :sp_public_payment_n; --�Թ��տ��ˣ�v9.10 ���ϣ�
    v_t_sup_rec.public_bank                := :sp_public_bank_n; --�Թ������У�v9.10 ���ϣ�
    v_t_sup_rec.public_id                  := :sp_public_id_n; --�Թ����֤�ţ�v9.10 ���ϣ�
    v_t_sup_rec.public_phone               := :sp_public_phone_n; --�Թ���ϵ�绰��v9.10 ���ϣ�
    v_t_sup_rec.personal_account           := :sp_personal_account_n; --�����˺ţ�v9.10 ���ϣ�
    v_t_sup_rec.personal_payment           := :sp_personal_payment_n; --�����տ��ˣ�v9.10 ���ϣ�
    v_t_sup_rec.personal_bank              := :sp_personal_bank_n; --���˿����У�v9.10 ���ϣ�
    v_t_sup_rec.personal_idcard            := :sp_personal_idcard_n; --�������֤�ţ�v9.10 ���ϣ�
    v_t_sup_rec.personal_phone             := :sp_personal_phone_n; --������ϵ�绰��v9.10 ���ϣ�
    v_t_sup_rec.pay_type                   := :sp_pay_type_n; --���ʽ��v9.10 ���ϣ�
    v_t_sup_rec.settlement_type            := :sp_settlement_type_n; --���㷽ʽ��v9.10 ���ϣ�
    v_t_sup_rec.reconciliation_user        := :sp_reconciliation_user_n; --������ϵ�ˣ�v9.10 ���ϣ�
    v_t_sup_rec.reconciliation_phone       := :sp_reconciliation_phone_n; --������ϵ�绰��v9.10 ���ϣ�
    v_t_sup_rec.contract_start_date        := :sp_contract_start_date_n; --��ͬ��Ч�ڴӣ�v9.10 ���ϣ�
    v_t_sup_rec.create_supp_date           := :sp_create_supp_date_n; --��������
  
    v_t_sup_rec.gendan_perid            := :sp_gendan_perid_n; --����ԱID
    v_t_sup_rec.supplier_info_origin    := :sp_supplier_info_origin_y; --��Դ
    v_t_sup_rec.supplier_info_origin_id := :sp_supplier_info_origin_id_n; --��ԴID
    v_t_sup_rec.status                  := :sp_status_n; --����״̬��0 δ���� 1 �ѽ���
    v_t_sup_rec.coop_state              := :sp_coop_state_n; --����״̬��COOP_01 �Ե� COOP_02 ���� COOP_03 ͣ�� �����ϣ�
    v_t_sup_rec.bind_status             := :sp_bind_status_n; --��״̬
  
    v_t_sup_rec.publish_id   := :sp_publish_id_n; --�����ˣ��ӿڣ�
    v_t_sup_rec.publish_date := :sp_publish_date_n; --����ʱ�䣨�ӿڣ�
    v_t_sup_rec.create_id    := :user_id; --������ID
    v_t_sup_rec.create_date  := SYSDATE; --����ʱ��
    v_t_sup_rec.update_id    := :user_id; --�޸���ID
    v_t_sup_rec.update_date  := SYSDATE; --�޸�ʱ��
  
    v_t_sup_rec.file_remark       := :sp_file_remark_n; --������ע��v9.10 ���ϣ�
    v_t_sup_rec.reserve_capacity  := :sp_reserve_capacity_n; --ԤԼ����ռ�ȣ�v9.10 ���ϣ�
    v_t_sup_rec.area_group_leader := :sp_area_group_leader_n; --�����鳤��v9.10 ���ϣ�
    v_t_sup_rec.ask_files         := :sp_ask_files_n; --������v9.10 ���ϣ�
    v_t_sup_rec.admit_result      := :sp_admit_result_n; --׼����
    v_t_sup_rec.pause_cause       := :sp_pause_cause_n; --��ͣԭ��
    v_t_sup_rec.group_name_origin := :sp_group_name_origin_n; --������Դ��AA �Զ����ɣ�MA �ֶ��༭
  
    v_t_sup_rec.regist_price := :sp_regist_price_n; --ע���ʱ� 
  
    --�޸� t_supplier_info
    --1.����=�����棬У������
    pkg_supplier_info.update_supplier_info(p_sp_data => v_sp_data);
    --2.������������
    pkg_supplier_info.p_update_group_name(p_company_id       => %default_company_id%,
                                          p_supplier_info_id => :supplier_info_id,
                                          p_is_by_pick       => 1,
                                          p_province         => :company_province,
                                          p_city             => :company_city);
  ELSE
    NULL;
  END IF;
END;
