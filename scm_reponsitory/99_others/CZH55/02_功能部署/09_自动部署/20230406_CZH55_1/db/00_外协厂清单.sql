DECLARE
v_sql CLOB;
BEGIN
v_sql := 'WITH dic AS
 (SELECT group_dict_value,
         group_dict_name,
         group_dict_type,
         group_dict_id,
         parent_id,
         pause
    FROM scmdata.sys_group_dict)
SELECT sp.inside_supplier_code,
       sp.supplier_company_name,
       fb.inside_supplier_code factory_code,
       fb.supplier_company_name factory_name,
       fb.supplier_company_abbreviation factory_abbreviation_name,
       gde.group_dict_name fa_product_type_desc_n,
       dp.province || dc.city || dt.county fpcc,
       fb.company_address,
       fb.group_name group_name,
       fb.fa_contact_name,
       fb.fa_contact_phone,
       fb.product_type,
       fb.product_link,
       fb.product_line,
       fb.product_line_num,
       fb.worker_num,
       fb.machine_num,
       fb.pattern_cap,
       fb.fabric_purchase_cap,
       fb.fabric_check_cap,
       fb.quality_step,
       fb.cost_step,
       fc.coop_class
  FROM scmdata.t_supplier_info sp
 INNER JOIN scmdata.t_coop_factory fa
    ON sp.supplier_info_id = fa.supplier_info_id
   AND sp.company_id = fa.company_id
   AND fa.pause = 0
 INNER JOIN scmdata.t_supplier_info fb
    ON fa.fac_sup_info_id = fb.supplier_info_id
   AND fa.company_id = fb.company_id
 INNER JOIN (SELECT listagg(DISTINCT gd_a.group_dict_name, '';'') coop_class,
                    tc.supplier_info_id,
                    gd_a.group_dict_type
               FROM scmdata.t_coop_scope tc
              INNER JOIN dic gd_a
                 ON gd_a.group_dict_value = tc.coop_classification
                AND gd_a.pause = 0
              WHERE tc.company_id = %default_company_id%
              GROUP BY tc.supplier_info_id, gd_a.group_dict_type) fc
    ON fb.supplier_info_id = fc.supplier_info_id
   AND fb.cooperation_type = fc.group_dict_type
  LEFT JOIN scmdata.t_factory_ask tf
    ON fb.supplier_info_origin_id = tf.factory_ask_id
  LEFT JOIN dic gde
    ON gde.group_dict_type = ''FA_PRODUCT_TYPE''
  AND gde.group_dict_value = fb.product_type
  LEFT JOIN scmdata.dic_province dp
    ON dp.provinceid = nvl(fb.company_province, tf.company_province)
  LEFT JOIN scmdata.dic_city dc
    ON dc.provinceid = dp.provinceid
   AND dc.cityno = nvl(fb.company_city, tf.company_city)
  LEFT JOIN scmdata.dic_county dt
    ON dt.cityno = dc.cityno
   AND dt.countyid = nvl(fb.company_county, tf.company_county)
 WHERE sp.company_id = %default_company_id%';
 UPDATE bw3.sys_item_list t SET t.select_sql = v_sql WHERE t.item_id = 'a_report_list_200';
END;
/
