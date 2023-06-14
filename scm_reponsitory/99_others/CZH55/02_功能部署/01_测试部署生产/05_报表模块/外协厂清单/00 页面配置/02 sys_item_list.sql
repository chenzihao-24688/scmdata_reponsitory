begin
insert into bw3.sys_item_list (ITEM_ID, QUERY_TYPE, QUERY_FIELDS, QUERY_COUNT, EDIT_EXPRESS, NEWID_SQL, SELECT_SQL, DETAIL_SQL, SUBSELECT_SQL, INSERT_SQL, UPDATE_SQL, DELETE_SQL, NOSHOW_FIELDS, NOADD_FIELDS, NOMODIFY_FIELDS, NOEDIT_FIELDS, SUBNOSHOW_FIELDS, UI_TMPL, MULTI_PAGE_FLAG, OUTPUT_PARAMETER, LOCK_SQL, MONITOR_ID, END_FIELD, EXECUTE_TIME, SCANNABLE_FIELD, SCANNABLE_TYPE, AUTO_REFRESH, RFID_FLAG, SCANNABLE_TIME, MAX_ROW_COUNT, NOSHOW_APP_FIELDS, SCANNABLE_LOCATION_LINE, SUB_TABLE_JUDGE_FIELD, BACK_GROUND_ID, OPRETION_HINT, SUB_EDIT_STATE, HINT_TYPE, HEADER, FOOTER, JUMP_FIELD, JUMP_EXPRESS, OPEN_MODE, OPERATION_TYPE, OPERATE_TYPE, PAGE_SIZES)
values ('a_report_list_200', 13, 'inside_supplier_code,supplier_company_name,factory_code,factory_name', null, null, null, 'WITH dic AS
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
       dp.province || dc.city || dt.county fpcc,
       fb.company_address,
       fb.group_name FAC_GROUP_NAME,
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
  LEFT JOIN scmdata.dic_province dp
    ON dp.provinceid = fb.company_province
  LEFT JOIN scmdata.dic_city dc
    ON dc.provinceid = fb.company_province
   AND dc.cityno = fb.company_city
  LEFT JOIN scmdata.dic_county dt
    ON dt.cityno = dc.cityno
   AND dt.countyid = fb.company_county
 WHERE sp.company_id = %default_company_id%', null, null, null, null, null, 'product_type,product_link,product_line,pattern_cap,fabric_purchase_cap,fabric_check_cap,quality_step,cost_step', null, null, null, null, null, 1, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, 0, null);

end;
