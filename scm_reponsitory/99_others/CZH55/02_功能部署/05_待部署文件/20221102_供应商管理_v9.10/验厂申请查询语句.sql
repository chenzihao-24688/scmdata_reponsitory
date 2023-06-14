WITH group_dict AS
 (SELECT gd.group_dict_type,
         gd.group_dict_value,
         gd.group_dict_name,
         gd.group_dict_id,
         gd.parent_id
    FROM scmdata.sys_group_dict gd
   WHERE gd.pause = 0)
--申请信息
SELECT su.company_user_name fa_check_person_y,
       dp.dept_name fa_check_dept_name_y,
       tfa.ask_date fa_ask_date_n,
       nvl(tfa.is_urgent, 0) fa_is_urgent_n,
       'PRODUCT_TYPE' ar_cooperation_type_y,
       tfa.cooperation_model ar_cooperation_model_y,
       (SELECT listagg(DISTINCT group_dict_name, ';') within GROUP(ORDER BY group_dict_value)
          FROM scmdata.t_ask_scope t
         INNER JOIN group_dict
            ON group_dict_value = t.cooperation_classification
           AND group_dict_type = t.cooperation_type
         WHERE t.be_company_id = tfa.company_id
           AND t.object_id = tfa.factory_ask_id) ar_coop_class_desc_n,
       tfa.product_type ar_product_type_y,
       tfa.pay_term ar_pay_term_n,
       tfa.ask_say fa_ask_say_y,
       --基本信息
       tfa.company_name ar_company_name_y,
       tfa.company_abbreviation ar_company_abbreviation_y,
       tfa.social_credit_code ar_social_credit_code_y,
       tfa.company_province,
       tfa.company_city,
       tfa.company_county,
       dp.province || dc.city || dt.county ar_company_area_y,
       tfa.company_vill ar_company_vill_y,
       dv.vill ar_company_vill_desc_y,
       tfa.company_address ar_company_address_y,
       tfa.company_regist_date ar_company_regist_date_y,
       tfa.legal_representative ar_legal_representative_n,
       tfa.company_contact_phone ar_company_contact_phone_n,
       tfa.contact_name ar_sapply_user_y,
       tfa.contact_phone ar_sapply_phone_y,
       tfa.company_type ar_company_type_y,
       gda.group_dict_name ar_company_type_desc_y,
       tfa.brand_type,
       tfa.cooperation_brand,
       (SELECT listagg(b.group_dict_name, ';') within GROUP(ORDER BY b.group_dict_value)
          FROM group_dict a
          LEFT JOIN group_dict b
            ON a.group_dict_type = 'COOPERATION_BRAND'
           AND a.group_dict_id = b.parent_id
           AND instr(';' || tfa.brand_type || ';',
                     ';' || a.group_dict_value || ';') > 0
           AND instr(';' || tfa.cooperation_brand || ';',
                     ';' || b.group_dict_value || ';') > 0) ar_coop_brand_desc_n,       
       tfa.product_link ar_product_link_n,
       tfa.rela_supplier_id ar_rela_supplier_id_n,
       tfa.is_our_factory ar_is_our_factory_y,
       gdc.group_dict_name ar_is_our_fac_desc_y,
       tfa.factory_name ar_factory_name_y,
       tfa.factory_province,
       tfa.factory_city,
       tfa.factory_county,
       fdp.province || fdc.city || fdt.county ar_factory_area_y,
       tfa.factory_vill ar_factory_vill_y,
       fdv.vill ar_factory_vill_desc_y,
       tfa.factroy_details_address ar_factroy_details_address_y,
       tfa.factroy_area ar_factroy_area_y,
       tfa.remarks ar_remarks_n,
       --生产信息
       tfa.product_line ar_product_line_n,
       tfa.product_line_num ar_product_line_num_n,
       tfa.quality_step ar_quality_step_n,
       tfa.work_hours_day ar_work_hours_day_y,
       nvl(tfa.worker_total_num, 0) ar_worker_total_num_y,
       nvl(tfa.worker_num, 0) ar_worker_num_y,
       tfa.machine_num ar_machine_num_y,
       nvl(tfa.form_num, 0) ar_form_num_y,
       tfa.product_efficiency ar_product_efficiency_y,
       nvl(tfa.pattern_cap, '00') ar_pattern_cap_y,
       nvl(tfa.fabric_purchase_cap, '00') ar_fabric_purchase_cap_y,
       tfa.fabric_check_cap ar_fabric_check_cap_n,
       --附件资料
       tfa.certificate_file  ar_certificate_file_y,
       tfa.supplier_gate     ar_supplier_gate_n,
       tfa.supplier_office   ar_supplier_office_n,
       tfa.supplier_site     ar_supplier_site_n,
       tfa.supplier_product  ar_supplier_product_n,
       tfa.other_information ar_other_information_n
  FROM scmdata.t_factory_ask tfa
  LEFT JOIN sys_company_user_dept udp
    ON udp.user_id = tfa.ask_user_id
   AND udp.company_id = tfa.company_id
  LEFT JOIN scmdata.sys_company_dept dp
    ON dp.company_dept_id = udp.company_dept_id
   AND dp.company_id = udp.company_id
  LEFT JOIN scmdata.sys_company_user su
    ON su.user_id = tfa.ask_user_id
   AND su.company_id = tfa.company_id
  LEFT JOIN dic_province dp
    ON tfa.company_province = to_char(dp.provinceid)
  LEFT JOIN dic_city dc
    ON tfa.company_city = to_char(dc.cityno)
  LEFT JOIN dic_county dt
    ON tfa.company_county = to_char(dt.countyid)
  LEFT JOIN dic_village dv
    ON dv.countyid = dt.countyid
   AND dv.villid = tfa.company_vill
  LEFT JOIN dic_province fdp
    ON tfa.factory_province = to_char(fdp.provinceid)
  LEFT JOIN dic_city fdc
    ON tfa.factory_city = to_char(fdc.cityno)
  LEFT JOIN dic_county fdt
    ON tfa.factory_county = to_char(fdt.countyid)
  LEFT JOIN dic_village fdv
    ON fdv.countyid = fdt.countyid
   AND fdv.villid = tfa.factory_vill
  LEFT JOIN group_dict gd
    ON gd.group_dict_type = 'COOPERATION_BRAND'
   AND gd.group_dict_value = tfa.cooperation_brand
  LEFT JOIN group_dict gda
    ON gda.group_dict_type = 'COMPANY_TYPE'
   AND gda.group_dict_value = tfa.company_type
  LEFT JOIN group_dict gdc
    ON gdc.group_dict_type = 'IS_OUR_FACTORY'
   AND gdc.group_dict_value = tfa.is_our_factory
  LEFT JOIN group_dict gdb
    ON gdb.group_dict_type = 'SUPPLY_TYPE'
   AND gdb.group_dict_value = tfa.cooperation_model
WHERE tfa.factory_ask_id = '';


BEGIN

  --申请信息
  p_fa_rec.ask_user_id       := :ask_user_id;
  p_fa_rec.ask_user_dept_id  := :ask_user_dept_id;
  p_fa_rec.is_urgent         := :is_urgent;
  p_fa_rec.cooperation_model := :cooperation_model;
  p_fa_rec.product_type      := :product_type;
  p_fa_rec.pay_term          := :pay_term;
  p_fa_rec.ask_say           := :ask_say;
  --基本信息
  p_fa_rec.company_name          := :company_name;
  p_fa_rec.company_abbreviation  := :company_abbreviation;
  p_fa_rec.company_province      := :company_province;
  p_fa_rec.company_city          := :company_city;
  p_fa_rec.company_county        := :company_county;
  p_fa_rec.company_vill          := :company_vill;
  p_fa_rec.company_address       := :company_address;
  p_fa_rec.company_regist_date   := :company_regist_date;
  p_fa_rec.legal_representative  := :legal_representative;
  p_fa_rec.company_contact_phone := :company_contact_phone;
  p_fa_rec.contact_name          := :contact_name;
  p_fa_rec.contact_phone         := :contact_phone;
  p_fa_rec.company_type          := :company_type;
  p_fa_rec.brand_type            := :brand_type;
  p_fa_rec.cooperation_brand     := :cooperation_brand;
  p_fa_rec.product_link          := :product_link;
  p_fa_rec.rela_supplier_id      := :rela_supplier_id;
  p_fa_rec.is_our_factory        := :is_our_factory;
  p_fa_rec.factory_name          := :factory_name;
  p_fa_rec.factory_province      := :factory_province;
  p_fa_rec.factory_city          := :factory_city;
  p_fa_rec.factory_county        := :factory_county;
  p_fa_rec.factory_vill          := :factory_vill;
  p_fa_rec.ask_address           := :ask_address;
  p_fa_rec.factroy_area          := :factroy_area;
  p_fa_rec.remarks               := :remarks;
  --生产信息
  p_fa_rec.product_line       := :product_line;
  p_fa_rec.product_line_num   := :product_line_num;
  p_fa_rec.quality_step       := :quality_step;
  p_fa_rec.work_hours_day     := :work_hours_day;
  p_fa_rec.machine_num        := :machine_num;
  p_fa_rec.product_efficiency := :product_efficiency;
  p_fa_rec.fabric_check_cap   := :fabric_check_cap;
  --附件资料
  p_fa_rec.certificate_file  := :certificate_file;
  p_fa_rec.supplier_gate     := :supplier_gate;
  p_fa_rec.supplier_office   := :supplier_office;
  p_fa_rec.supplier_site     := :supplier_site;
  p_fa_rec.supplier_product  := :supplier_product;
  p_fa_rec.other_information := :other_information;
  --其他  
  p_fa_rec.update_id   := :user_id;
  p_fa_rec.update_date := SYSDATE;

END;

