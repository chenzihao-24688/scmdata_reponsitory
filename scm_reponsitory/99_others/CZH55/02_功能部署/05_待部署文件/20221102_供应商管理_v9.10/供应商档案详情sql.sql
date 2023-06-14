WITH group_dict AS
 (SELECT t.group_dict_type,
         t.group_dict_value,
         t.group_dict_name,
         t.group_dict_id,
         t.parent_id
    FROM scmdata.sys_group_dict t
   WHERE t.pause = 0)
SELECT sp.supplier_info_id,
       sp.company_id,
       sp.supplier_info_origin_id,
       --基本信息 
       sp.supplier_company_name,
       sp.supplier_company_abbreviation,
       sp.social_credit_code,
       sp.supplier_code,
       sp.inside_supplier_code,
       sp.company_regist_date sp_company_regist_date_n,
       sp.company_province company_province,
       sp.company_city company_city,
       sp.company_county company_county,
       province || city || county location_area,
       sp.company_vill company_vill,
       nvl(sp.company_address, fc.address) company_address_sp,
       sp.group_name,
       sp.legal_representative,
       sp.company_contact_phone,
       sp.fa_contact_name,
       sp.fa_contact_phone,
       sp.company_type,
       sp.is_our_factory,
       sp.factroy_area,
       sp.remarks,
       --生产信息
       sp.product_type,
       sp.brand_type,
       sp.cooperation_brand,
       (SELECT listagg(b.group_dict_name, ';') within GROUP(ORDER BY b.group_dict_value)
          FROM group_dict t
          LEFT JOIN group_dict b
            ON t.group_dict_type = 'COOPERATION_BRAND'
           AND t.group_dict_id = b.parent_id
           AND instr(';' || sp.brand_type || ';',
                     ';' || t.group_dict_value || ';') > 0
           AND instr(';' || sp.cooperation_brand || ';',
                     ';' || b.group_dict_value || ';') > 0) cooperation_brand_desc,
       sp.product_link,
       sp.product_line,
       sp.product_line_num,
       sp.quality_step,
       sp.work_hours_day,
       sp.worker_total_num,
       sp.worker_num,
       sp.machine_num,
       sp.form_num,
       decode(sp.product_efficiency, NULL, '80', sp.product_efficiency) product_efficiency,      
       sp.pattern_cap pattern_cap,
       sp.fabric_purchase_cap ,
       sp.fabric_check_cap ,
       sp.cost_step cost_step,     
       --合作信息
       sp.pause coop_state,
       nvl2(sp.supplier_company_id, '已注册', '未注册') regist_status_sp,
       decode(sp.bind_status, 1, '已绑定', '未绑定') bind_status_sq,
       sp.cooperation_type,
       sp.cooperation_model,
       sp.coop_position,
       sp.pay_type,
       --附件资料
       sp.certificate_file,
       sp.supplier_gate,
       sp.supplier_office,
       sp.supplier_site,
       sp.supplier_product,
       sp.other_information,
       --其他
       sp.supplier_info_origin,
       sp.status
  FROM scmdata.t_supplier_info sp
  LEFT JOIN scmdata.t_factory_ask fa
    ON sp.supplier_info_origin_id = fa.factory_ask_id
  LEFT JOIN scmdata.dic_province p
    ON p.provinceid = nvl(sp.company_province, fa.company_province)
  LEFT JOIN scmdata.dic_city c
    ON c.cityno = nvl(sp.company_city, fa.company_city)
  LEFT JOIN scmdata.dic_county dc
    ON dc.countyid = nvl(sp.company_county, fa.company_county)
  LEFT JOIN scmdata.sys_company fc
    ON fc.company_id = sp.supplier_company_id
 INNER JOIN group_dict ga
    ON sp.cooperation_type = ga.group_dict_value
   AND ga.group_dict_type = 'COOPERATION_TYPE'
  LEFT JOIN group_dict gd
    ON gd.group_dict_type = 'COOPERATION_BRAND'
   AND gd.group_dict_value = sp.cooperation_brand
 WHERE sp.supplier_info_id = '' --']' || v_sup_id || q'['
   AND sp.company_id = %default_company_id%
