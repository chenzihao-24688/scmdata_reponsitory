DECLARE
  v_sql CLOB;
BEGIN
  v_sql := q'[--修改后的查询代码
SELECT v.supplier_info_id,
       v.company_id,
       v.supplier_info_origin,
       v.status,
       v.pause,
       v.regist_status,
       v.bind_status,
       v.supplier_code,
       v.inside_supplier_code,
       v.supplier_company_id,
       v.supplier_company_name,
       v.supplier_company_abbreviation,
       v.cooperation_type_sp,
       nvl(v.cooperation_classification_sp, f.group_dict_name) cooperation_classification_sp, --合作分类：不验厂取申请单的数据，验厂取报告以及能力评估明细表
       --nvl(v.cooperation_subcategory_sp, g.group_dict_name) cooperation_subcategory_sp, --合作子类：不验厂取申请单的数据，验厂取报告以及能力评估明细表
       v.cooperation_model_sp,
       v.company_type,
       v.cooperation_method_sp,
       v.production_mode_sp,
       v.ask_date,
       v.check_date,
       v.create_supp_date,
       v.social_credit_code,
       v.company_contact_person,
       v.company_contact_phone
  FROM (SELECT e.group_dict_name supplier_info_origin,
               sp.status,
               sp.pause,
               nvl2(sp.supplier_company_id,'已注册','未注册') regist_status,
               sp.bind_status,
               sp.supplier_code,
               sp.inside_supplier_code,
               sp.supplier_company_name,
               sp.supplier_company_abbreviation,
               ar.ask_date,
               fr.check_date,
               sp.create_supp_date,
               sp.social_credit_code,
               sp.regist_address,
               sp.legal_representative,
               sp.company_create_date,
               sp.regist_price,
               a.group_dict_name cooperation_type_sp,
               (SELECT listagg(DISTINCT t.group_dict_name, ';') within GROUP(ORDER BY t.group_dict_value)
                  FROM scmdata.sys_group_dict t, scmdata.t_coop_scope sa
                 WHERE sa.company_id = sp.company_id
                   AND sa.supplier_info_id = sp.supplier_info_id
                   AND t.group_dict_type = sp.cooperation_type
                   AND t.group_dict_value = sa.coop_classification
                   AND t.pause = 0) cooperation_classification_sp,
               b.group_dict_name cooperation_method_sp,
               c.group_dict_name cooperation_model_sp,
               d.group_dict_name production_mode_sp,
               sp.company_contact_person,
               sp.company_contact_phone,
               sp.create_date,
               sp.supplier_info_origin_id,
               sp.cooperation_type,
               sp.supplier_info_id,
               sp.supplier_company_id,
               sp.company_id,
               f.group_dict_name company_type
          FROM scmdata.t_supplier_info sp
          LEFT JOIN scmdata.t_factory_ask fa
            ON sp.supplier_info_origin_id = fa.factory_ask_id
          LEFT JOIN scmdata.t_factory_report fr
            ON fa.factory_ask_id = fr.factory_ask_id
          LEFT JOIN scmdata.t_ask_record ar
            ON fa.ask_record_id = ar.ask_record_id
          LEFT JOIN scmdata.sys_group_dict a
            ON a.group_dict_type = 'COOPERATION_TYPE'
           AND sp.cooperation_type = a.group_dict_value
          LEFT JOIN scmdata.sys_group_dict b
            ON b.group_dict_type = 'COOP_METHOD'
           AND b.group_dict_value = sp.cooperation_method
          LEFT JOIN scmdata.sys_group_dict c
            ON c.group_dict_type = 'SUPPLY_TYPE'
           AND c.group_dict_value = sp.cooperation_model
          LEFT JOIN scmdata.sys_group_dict d
            ON d.group_dict_type = 'CPMODE_TYPE'
           AND d.group_dict_value = sp.production_mode
          LEFT JOIN scmdata.sys_group_dict e
            ON e.group_dict_type = 'ORIGIN_TYPE'
           AND e.group_dict_value = sp.supplier_info_origin
          LEFT JOIN scmdata.sys_group_dict f
            ON f.group_dict_type = 'COMPANY_TYPE'
           AND f.group_dict_value = sp.company_type
          LEFT JOIN scmdata.sys_company fc
            ON sp.social_credit_code = fc.licence_num
         WHERE sp.company_id = %default_company_id%
           AND sp.status = 1
           AND sp.supplier_info_origin <> 'II') v --先不展示接口导入的数据
  LEFT JOIN scmdata.t_factory_ask fa
    ON fa.factory_ask_id = v.supplier_info_origin_id
  LEFT JOIN scmdata.sys_group_dict f
    ON f.group_dict_type = v.cooperation_type
   AND f.group_dict_value = fa.cooperation_classification
  LEFT JOIN scmdata.sys_group_dict g
    ON g.group_dict_type = fa.cooperation_classification
   AND g.group_dict_value = fa.cooperation_subcategory
ORDER BY v.supplier_code DESC]';

  UPDATE bw3.sys_item_list t
     SET t.select_sql = v_sql
   WHERE t.item_id = 'a_supp_160';
END;
