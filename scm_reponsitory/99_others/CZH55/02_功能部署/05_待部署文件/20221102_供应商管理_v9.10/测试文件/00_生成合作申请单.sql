DECLARE
  v_company_id    VARCHAR2(32);
  p_ar_rec        scmdata.t_ask_record%ROWTYPE;
  v_ask_record_id VARCHAR2(32) := nvl('', 'HZ2212126131164931');
BEGIN
  SELECT MAX(company_id)
    INTO v_company_id
    FROM scmdata.sys_company
   WHERE licence_num = NULL;
  p_ar_rec.ask_record_id           := v_ask_record_id;
  p_ar_rec.company_id              := nvl(v_company_id, '');
  p_ar_rec.be_company_id           := 'a972dd1ffe3b3a10e0533c281cac8fd7';
  p_ar_rec.company_name            := '阳了阳了';
  p_ar_rec.company_abbreviation    := '阳了阳了';
  p_ar_rec.social_credit_code      := '988885555111111222';
  p_ar_rec.company_province        := '210000';
  p_ar_rec.company_city            := '210300';
  p_ar_rec.company_county          := '210311';
  p_ar_rec.company_vill            := '210311001';
  p_ar_rec.company_address         := '12343';
  p_ar_rec.company_regist_date     := timestamp'2022-12-12 00:00:00.0';
  p_ar_rec.pay_term                := '00';
  p_ar_rec.legal_representative    := NULL;
  p_ar_rec.company_contact_phone   := NULL;
  p_ar_rec.sapply_user             := 'hzc';
  p_ar_rec.sapply_phone            := '18172543571';
  p_ar_rec.company_type            := '01';
  p_ar_rec.brand_type              := NULL;
  p_ar_rec.cooperation_brand       := NULL;
  p_ar_rec.cooperation_type        := 'PRODUCT_TYPE';
  p_ar_rec.cooperation_model       := 'ODM';
  p_ar_rec.product_type            := '00';
  p_ar_rec.product_link            := '001';
  p_ar_rec.rela_supplier_id        := NULL;
  p_ar_rec.is_our_factory          := '1';
  p_ar_rec.factory_name            := '阳了阳了';
  p_ar_rec.factory_province        := '210000';
  p_ar_rec.factory_city            := '210300';
  p_ar_rec.factory_county          := '210311';
  p_ar_rec.factory_vill            := '210311001';
  p_ar_rec.factroy_details_address := '12343';
  p_ar_rec.factroy_area            := '123';
  p_ar_rec.ask_say                 := NULL;
  p_ar_rec.remarks                 := NULL;
  p_ar_rec.product_line            := NULL;
  p_ar_rec.product_line_num        := NULL;
  p_ar_rec.quality_step            := NULL;
  p_ar_rec.work_hours_day          := '12';
  p_ar_rec.worker_total_num        := '0';
  p_ar_rec.worker_num              := '0';
  p_ar_rec.machine_num             := '13';
  p_ar_rec.form_num                := '0';
  p_ar_rec.product_efficiency      := 80;
  p_ar_rec.pattern_cap             := '01';
  p_ar_rec.fabric_purchase_cap     := '01';
  p_ar_rec.fabric_check_cap        := NULL;
  p_ar_rec.certificate_file        := '2e5781159e7a4bfab7f685cfc9fd0c7d';
  p_ar_rec.supplier_gate           := NULL;
  p_ar_rec.supplier_office         := NULL;
  p_ar_rec.supplier_site           := NULL;
  p_ar_rec.supplier_product        := NULL;
  p_ar_rec.other_information       := NULL;
  p_ar_rec.coor_ask_flow_status    := 'CA00';
  p_ar_rec.origin                  := 'MA';
  p_ar_rec.create_id               := 'ZXP';
  p_ar_rec.create_date             := SYSDATE;
  p_ar_rec.update_id               := 'ZXP';
  p_ar_rec.update_date             := SYSDATE;
  p_ar_rec.ask_date                := SYSDATE;
  p_ar_rec.ask_user_id             := 'ZXP';
  p_ar_rec.other_file              := NULL;
  p_ar_rec.cooperation_statement   := NULL;
  p_ar_rec.collection              := 0;
  scmdata.pkg_ask_record_mange.p_check_data_by_save(p_ar_rec => p_ar_rec,
                                                    p_type   => 1);
  scmdata.pkg_ask_record_mange.p_insert_t_ask_record(p_ar_rec => p_ar_rec);
  scmdata.pkg_ask_record_mange.p_generate_person_machine_config(p_company_id    => 'a972dd1ffe3b3a10e0533c281cac8fd7',
                                                                p_user_id       => 'ZXP',
                                                                p_ask_record_id => v_ask_record_id);
END;
