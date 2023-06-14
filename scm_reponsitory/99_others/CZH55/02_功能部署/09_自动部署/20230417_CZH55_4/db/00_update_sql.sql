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
  --��ȡasscoiate�������
  pkg_plat_comm.p_get_rest_val_method_params(p_character     => NVL(%ass_supplier_info_id%,:supplier_info_id),
                                             po_pk_id        => v_pk_id,
                                             po_rest_methods => v_rest_method,
                                             po_params       => v_params);

  IF v_rest_method IS NULL OR instr('';'' || v_rest_method || '';'', '';'' || ''PUT'' || '';'') > 0 THEN
    v_sql := q''[
DECLARE
  v_t_sup_rec       scmdata.t_supplier_info%ROWTYPE;
  v_supp_company_id VARCHAR2(32);
  v_supp_id         VARCHAR2(32) := NVL('']'' || v_pk_id || q''['',:supplier_info_id); --����
BEGIN
  v_t_sup_rec.supplier_info_id := v_supp_id; --����
  v_t_sup_rec.company_id       := %default_company_id%; --��˾����
  --������Ϣ
  v_t_sup_rec.supplier_company_name         := :sp_sup_company_name_y; --��˾����
  v_t_sup_rec.supplier_company_abbreviation := :sp_sup_company_abb_y; --��˾���
  v_t_sup_rec.social_credit_code            := :sp_social_credit_code_y; --ͳһ������ô���
  --v_t_sup_rec.supplier_code               := :sp_supplier_code_n; --��Ӧ�̱��
  v_t_sup_rec.inside_supplier_code  := :sp_inside_supplier_code_n; --�ڲ���Ӧ�̱��
  v_t_sup_rec.company_regist_date   := :sp_company_regist_date_y; --��˾ע������
  v_t_sup_rec.company_province      := :company_province; --��˾ʡ
  v_t_sup_rec.company_city          := :company_city; --��˾��
  v_t_sup_rec.company_county        := :company_county; --��˾��
  v_t_sup_rec.company_vill          := :ar_company_vill_y; --��˾����
  v_t_sup_rec.company_address       := :sp_company_address_y; --��˾��ַ
  v_t_sup_rec.group_name            := :sp_group_name_n; --�������ƣ�v9.9�� ��ֵ��Ϊ����ID��
  v_t_sup_rec.legal_representative  := :sp_legal_represent_n; --����������
  v_t_sup_rec.company_contact_phone := :sp_company_contact_phone_n; --��˾��ϵ�绰
  v_t_sup_rec.fa_contact_name       := :sp_contact_name_y; --ҵ����ϵ��
  v_t_sup_rec.fa_contact_phone      := :sp_contact_phone_y; --ҵ����ϵ���ֻ�
  v_t_sup_rec.company_type          := :sp_company_type_y; --��˾����
  v_t_sup_rec.is_our_factory        := :ar_is_our_factory_y; --�Ƿ񱾳�
  v_t_sup_rec.factroy_area          := :sp_factroy_area_y; --���������m2��
  v_t_sup_rec.remarks               := :sp_remarks_n; --��ע

  --������Ϣ
  v_t_sup_rec.product_type      := :sp_product_type_y; --��������
  v_t_sup_rec.brand_type        := :sp_brand_type_n; --����Ʒ��/�ͻ� ����
  v_t_sup_rec.cooperation_brand := :cooperation_brand; --����Ʒ��/�ͻ�
  v_t_sup_rec.product_link      := :sp_product_link_n; --��������

  v_t_sup_rec.product_line        := :sp_product_line_n; --����������
  v_t_sup_rec.product_line_num    := :sp_product_line_num_n; --����������
  v_t_sup_rec.quality_step        := :sp_quality_step_y; --�����ȼ�
  v_t_sup_rec.work_hours_day      := :sp_work_hours_day_y; --�ϰ�ʱ��/��
  v_t_sup_rec.worker_total_num    := :sp_worker_total_num_y; --������
  v_t_sup_rec.worker_num          := :sp_worker_num_y; --��λ����
  v_t_sup_rec.machine_num         := :sp_machine_num_y; --֯��̨��
  v_t_sup_rec.form_num            := :sp_form_num_y; --��������_Ь��
  v_t_sup_rec.product_efficiency  := :sp_product_efficiency_y; --����Ч��
  v_t_sup_rec.pattern_cap         := :sp_pattern_cap_y; --�������
  v_t_sup_rec.fabric_purchase_cap := :sp_fabric_purchase_cap_y; --���ϲɹ�����
  v_t_sup_rec.fabric_check_cap    := :sp_fabric_check_cap_y; --���ϼ������

  --������Ϣ
  v_t_sup_rec.pause := :sp_coop_state_y; --״̬��0 ���� 1 ͣ�� 2 �Ե�

  SELECT MAX(fc.company_id)
    INTO v_supp_company_id
    FROM scmdata.sys_company fc
   WHERE fc.licence_num = :sp_social_credit_code_y;

  v_t_sup_rec.supplier_company_id := v_supp_company_id; --��Ӧ����ƽ̨����ҵid
  v_t_sup_rec.cooperation_type    := :sp_cooperation_type_y; --��������
  v_t_sup_rec.cooperation_model   := REPLACE(:sp_cooperation_model_y,
                                             '' '',
                                             '';''); --����ģʽ
  v_t_sup_rec.coop_position       := :sp_coop_position_n; --������λ
  v_t_sup_rec.pay_term            := :ar_pay_term_n; --��������

  --��������
  v_t_sup_rec.certificate_file  := :sp_certificate_file_y; --�ϴ�Ӫҵִ��
  v_t_sup_rec.supplier_gate     := :sp_supplier_gate_n; --��˾���Ÿ�����ַ
  v_t_sup_rec.supplier_office   := :sp_supplier_office_n; --��˾�칫�Ҹ�����ַ
  v_t_sup_rec.supplier_site     := :sp_supplier_site_n; --�����ֳ�������ַ
  v_t_sup_rec.supplier_product  := :sp_supplier_product_n; --��ƷͼƬ������ַ
  v_t_sup_rec.other_information := :sp_other_information_n; --��������

  --����
  v_t_sup_rec.update_id   := :user_id; --�޸���ID
  v_t_sup_rec.update_date := SYSDATE; --�޸�ʱ��

  --�޸� t_supplier_info
  --1.����=�����棬У������
  pkg_supplier_info.p_update_supplier_info(p_sp_data => v_t_sup_rec);
  --2.������������
  IF scmdata.pkg_plat_comm.f_is_check_fields_eq(p_old_field => :old_company_province || :old_company_city,
                                                p_new_field => :company_province || :company_city) = 0 THEN
    pkg_supplier_info.p_update_group_name(p_company_id       => %default_company_id%,
                                          p_supplier_info_id => v_supp_id,
                                          p_is_by_pick       => 1,
                                          p_province         => :company_province,
                                          p_city             => :company_city);
  END IF;
  --3.ͬ����������
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
