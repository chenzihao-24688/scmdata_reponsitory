SELECT ROWID, t.* FROM nbw.sys_item t WHERE t.item_id in('c_2100','c_2051','c_2090','a_good_101_4','a_good_101_4_1','a_supp_160_1') ;
SELECT ROWID, t.* FROM nbw.sys_tree_list t WHERE t.item_id in('c_2100','c_2051','c_2090','a_good_101_4','a_good_101_4_1','a_supp_160_1');
SELECT ROWID, t.* FROM nbw.sys_item_list t WHERE t.item_id in('c_2100','c_2051','c_2090','a_good_101_4','a_good_101_4_1','a_supp_160_1');--a_supp_160  

select rowid,t.* from nbw.sys_element t where t.element_id in ('action_a_good_101_4','action_c_2051_1','action_a_supp_160'); 
select rowid,t.* from nbw.sys_action t  where t.caption in ('批量导入','工艺单导入','供应商主档导入');
SELECT ROWID, t.* FROM nbw.sys_item_element_rela t  where t.element_id in ('action_a_good_101_4','action_c_2051_1','action_a_supp_160'); --

select rowid,t.* from nbw.sys_cond_rela t where t.cond_id in('cond_checkaction_c_2051_1','cond_checkaction_a_good_101_4'); --action_c_2051_1 t_commodity_craft_temp
select rowid,t.* from nbw.sys_cond_list t  where t.cond_id  in('cond_checkaction_c_2051_1','cond_checkaction_a_good_101_4');

select rowid,t.* from nbw.sys_cond_operate t where t.cond_id in('cond_checkaction_c_2051_1','cond_checkaction_a_good_101_4','cond_checkaction_a_supp_160');

select rowid,t.* from nbw.sys_action t  where t.caption in ('下载模板','上传','提交','重置');

SELECT t.company_id,
       t.supplier_company_name,
       t.cooperation_type_code,
       t.cooperation_type,
       t.company_province_code,
       t.company_province,
       t.company_city_code,
       t.company_city,      
       t.company_county_code,
       t.company_county,
       t.company_address,
       t.social_credit_code,
       t.legal_representative,
       t.company_contact_person,
       t.company_contact_phone,   
       m.msg
  FROM scmdata.t_supplier_info_temp t
  LEFT JOIN scmdata.t_supplier_info_import_msg m
    ON t.err_msg_id = m.msg_id
 WHERE t.company_id = %default_company_id%
   AND t.user_id = :user_id;
