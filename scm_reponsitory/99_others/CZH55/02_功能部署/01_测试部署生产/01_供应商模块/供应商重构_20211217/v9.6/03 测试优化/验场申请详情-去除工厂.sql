declare
v_sql clob;
begin
  v_sql := '--czh 重构代码
DECLARE
  p_fa_rec scmdata.t_factory_ask%ROWTYPE;
  --p_fo_rec scmdata.t_factory_ask_out%ROWTYPE;
BEGIN
  --验厂申请
  --申请信息
  p_fa_rec.ask_date          := :factory_ask_date;
  p_fa_rec.is_urgent         := :is_urgent;
  p_fa_rec.cooperation_model := :cooperation_model;
  p_fa_rec.product_type      := :product_type;
  p_fa_rec.ask_say           := :checkapply_intro;
  --供应商基本信息
  p_fa_rec.factory_ask_id       := :factory_ask_id;
  p_fa_rec.company_name         := :ask_company_name;
  p_fa_rec.company_abbreviation := :company_abbreviation;
  --p_fa_rec.social_credit_code    := :social_credit_code;
  p_fa_rec.company_province      := :company_province;
  p_fa_rec.company_city          := :company_city;
  p_fa_rec.company_county        := :company_county;
  p_fa_rec.company_address       := :company_address;
  --p_fa_rec.ask_address           := :company_address;
  p_fa_rec.factory_name          := :factory_name;
  p_fa_rec.factory_province      := :factory_province;
  p_fa_rec.factory_city          := :factory_city;
  p_fa_rec.factory_county        := :factory_county;
  p_fa_rec.ask_address           := :ask_address;
  p_fa_rec.legal_representative  := :legal_representative;
  p_fa_rec.company_contact_phone := :company_contact_phone;
  p_fa_rec.contact_name          := :ask_user_name;
  p_fa_rec.contact_phone         := :ask_user_phone;
  p_fa_rec.company_type          := :company_type;
  p_fa_rec.brand_type            := :brand_type;
  p_fa_rec.cooperation_brand     := :cooperation_brand;
  p_fa_rec.com_manufacturer      := :com_manufacturer;
  p_fa_rec.certificate_file      := :certificate_file;
  p_fa_rec.ask_files             := :ask_files;
  p_fa_rec.supplier_gate         := :supplier_gate;
  p_fa_rec.supplier_office       := :supplier_office;
  p_fa_rec.supplier_site         := :supplier_site;
  p_fa_rec.supplier_product      := :supplier_product;
  p_fa_rec.ask_user_id           := %current_userid%;
  p_fa_rec.update_id             := %current_userid%;
  p_fa_rec.update_date           := SYSDATE;
  p_fa_rec.rela_supplier_id      := :rela_supplier_id;
  p_fa_rec.product_link          := :product_link;
  p_fa_rec.memo               := :remarks;
  --生产信息
  p_fa_rec.worker_num          := :worker_num;
  p_fa_rec.machine_num         := :machine_num;
  p_fa_rec.reserve_capacity    := rtrim(:reserve_capacity,''%'');
  p_fa_rec.product_efficiency  := rtrim(:product_efficiency,''%'');
  p_fa_rec.work_hours_day      := :work_hours_day;

  scmdata.pkg_ask_record_mange.p_save_factory_ask(p_fa_rec => p_fa_rec);

END;';
update bw3.sys_item_list t set t.update_sql = v_sql where t.item_id = 'a_coop_221';
end;
