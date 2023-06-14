--供应商档案修改脚本
--1.待建档
--1) 待建档供应商列表去掉编号、供应商编号；
--2) 合作类型放在统一社会信用代码后；
--3) “来源”放置最后；
DECLARE
  v_select_sql     CLOB;
  v_no_show_fields CLOB;
BEGIN
  v_select_sql := q'[SELECT v.supplier_info_id,
       v.company_id,
       v.status,
       v.pause,
       v.supplier_code,
       v.inside_supplier_code,
       v.supplier_company_id,
       v.supplier_company_name,
       v.supplier_company_abbreviation,
       nvl(v.cooperation_classification_sp,
           (SELECT f.group_dict_name
              FROM scmdata.sys_group_dict f
             WHERE f.group_dict_type = v.cooperation_type
               AND f.group_dict_value = fa.cooperation_classification)) cooperation_classification_sp, --合作分类：不验厂取申请单的数据，验厂取报告以及能力评估明细表
       --合作子类 注释原因：暂不开放出来
       /*       nvl(v.cooperation_subcategory_sp,
       g.group_dict_name
       (SELECT *
          FROM scmdata.sys_group_dict g
         WHERE g.group_dict_type = fa.cooperation_classification
           AND g.group_dict_value = fa.cooperation_subcategory)) cooperation_subcategory_sp,*/ --合作子类：不验厂取申请单的数据，验厂取报告以及能力评估明细表 
       v.cooperation_model_sp,
       v.company_type,
       v.cooperation_method_sp,
       v.production_mode_sp,
       v.ask_date,
       v.check_date,
       v.create_supp_date,
       v.social_credit_code,
       v.cooperation_type_sp,
       v.company_contact_person,
       v.company_contact_phone,
       v.supplier_info_origin,
       v.supplier_info_origin_id factory_ask_id
  FROM (SELECT (SELECT e.group_dict_name
                  FROM scmdata.sys_group_dict e
                 WHERE e.group_dict_type = 'ORIGIN_TYPE'
                   AND e.group_dict_value = sp.supplier_info_origin) supplier_info_origin,
               sp.status,
               sp.pause,
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
               (SELECT a.group_dict_name
                  FROM scmdata.sys_group_dict a
                 WHERE a.group_dict_type = 'COOPERATION_TYPE'
                   AND sp.cooperation_type = a.group_dict_value) cooperation_type_sp,
               (SELECT listagg(DISTINCT t.group_dict_name, ';') within GROUP(ORDER BY t.group_dict_value)
                  FROM scmdata.sys_group_dict t, scmdata.t_coop_scope sa
                 WHERE sa.company_id = sp.company_id
                   AND sa.supplier_info_id = sp.supplier_info_id
                   AND t.group_dict_type = sp.cooperation_type
                   AND t.group_dict_value = sa.coop_classification
                   AND t.pause = 0) cooperation_classification_sp,
               (SELECT b.group_dict_name
                  FROM scmdata.sys_group_dict b
                 WHERE b.group_dict_type = 'COOP_METHOD'
                   AND b.group_dict_value = sp.cooperation_method) cooperation_method_sp,
               (SELECT c.group_dict_name
                  FROM scmdata.sys_group_dict c
                 WHERE c.group_dict_type = 'SUPPLY_TYPE'
                   AND c.group_dict_value = sp.cooperation_model) cooperation_model_sp,
               (SELECT d.group_dict_name
                  FROM scmdata.sys_group_dict d
                 WHERE d.group_dict_type = 'CPMODE_TYPE'
                   AND d.group_dict_value = sp.production_mode) production_mode_sp,
               sp.company_contact_person,
               sp.company_contact_phone,
               sp.create_date,
               sp.supplier_info_origin_id,
               sp.cooperation_type,
               sp.supplier_info_id,
               sp.supplier_company_id,
               sp.company_id,
               (SELECT f.group_dict_name
                  FROM scmdata.sys_group_dict f
                 WHERE f.group_dict_type = 'COMPANY_TYPE'
                   AND f.group_dict_value = sp.company_type) company_type
          FROM scmdata.t_supplier_info sp
          LEFT JOIN scmdata.t_factory_ask fa
            ON sp.supplier_info_origin_id = fa.factory_ask_id
          LEFT JOIN scmdata.t_factory_report fr
            ON fa.factory_ask_id = fr.factory_ask_id
          LEFT JOIN scmdata.t_ask_record ar
            ON fa.ask_record_id = ar.ask_record_id
         WHERE sp.company_id = %default_company_id%
           AND sp.status = 0
           AND sp.supplier_info_origin <> 'II') v --先不展示接口导入的数据
  LEFT JOIN scmdata.t_factory_ask fa
    ON fa.factory_ask_id = v.supplier_info_origin_id
 ORDER BY v.create_date DESC]';

  UPDATE nbw.sys_item t
     SET t.show_rowid = 7
   WHERE t.item_id = 'a_supp_150';

  v_no_show_fields := 'supplier_info_id,supplier_code,company_id,supplier_company_id,supplier_info_origin_id,status,pause,cooperation_method_sp,production_mode_sp,sp_status_desc,pause_desc,CREATE_SUPP_DATE,inside_supplier_code,factory_ask_id';

  UPDATE nbw.sys_item_list t
     SET t.select_sql = v_select_sql, t.noshow_fields = v_no_show_fields
   WHERE t.item_id = 'a_supp_150';
END;
/

--2.已建档
--1) 已建档供应商列表去掉编号
--2) 合作类型、注册状态、绑定状态放在统一信用代码后
--3) “来源”放置最后；

DECLARE
  v_select_sql     CLOB;
  v_no_show_fields CLOB;
BEGIN
  v_select_sql := q'[SELECT v.supplier_info_id,
        v.company_id,
        v.status,
        v.pause,
        v.supplier_code,
        v.inside_supplier_code,
        v.supplier_company_id,
        v.supplier_company_name,
        v.supplier_company_abbreviation,
        nvl(v.cooperation_classification_sp,
            (SELECT f.group_dict_name
               FROM scmdata.sys_group_dict f
              WHERE f.group_dict_type = v.cooperation_type
                AND f.group_dict_value = fa.cooperation_classification)) cooperation_classification_sp, --合作分类：不验厂取申请单的数据，验厂取报告以及能力评估明细表
        /*nvl(v.cooperation_subcategory_sp,
        (SELECT g.group_dict_name
           FROM scmdata.sys_group_dict g
             WHERE g.group_dict_type = fa.cooperation_classification
            AND g.group_dict_value = fa.cooperation_subcategory)) cooperation_subcategory_sp,*/ --合作子类：不验厂取申请单的数据，验厂取报告以及能力评估明细表
        v.cooperation_model_sp,
        v.company_type,
        v.cooperation_method_sp,
        v.production_mode_sp,
        v.ask_date,
        v.check_date,
        v.create_supp_date,
        v.social_credit_code,
        v.cooperation_type_sp,
        v.regist_status,
        v.bind_status,
        v.company_contact_person,
        v.company_contact_phone,
        v.supplier_info_origin,
        v.supplier_info_origin_id factory_ask_id
   FROM (SELECT (SELECT e.group_dict_name
                   FROM scmdata.sys_group_dict e
                  WHERE e.group_dict_type = 'ORIGIN_TYPE'
                    AND e.group_dict_value = sp.supplier_info_origin) supplier_info_origin,
                sp.status,
                sp.pause,
                nvl2(sp.supplier_company_id, '已注册', '未注册') regist_status,
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
                (SELECT a.group_dict_name
                   FROM scmdata.sys_group_dict a
                  WHERE a.group_dict_type = 'COOPERATION_TYPE'
                    AND sp.cooperation_type = a.group_dict_value) cooperation_type_sp,
                (SELECT listagg(DISTINCT t.group_dict_name, ';') within GROUP(ORDER BY t.group_dict_value)
                   FROM scmdata.sys_group_dict t, scmdata.t_coop_scope sa
                  WHERE sa.company_id = sp.company_id
                    AND sa.supplier_info_id = sp.supplier_info_id
                    AND t.group_dict_type = sp.cooperation_type
                    AND t.group_dict_value = sa.coop_classification
                    AND t.pause = 0) cooperation_classification_sp,
                (SELECT b.group_dict_name
                   FROM scmdata.sys_group_dict b
                  WHERE b.group_dict_type = 'COOP_METHOD'
                    AND b.group_dict_value = sp.cooperation_method) cooperation_method_sp,
                (SELECT c.group_dict_name
                   FROM scmdata.sys_group_dict c
                  WHERE c.group_dict_type = 'SUPPLY_TYPE'
                    AND c.group_dict_value = sp.cooperation_model) cooperation_model_sp,
                (SELECT d.group_dict_name
                   FROM scmdata.sys_group_dict d
                  WHERE d.group_dict_type = 'CPMODE_TYPE'
                    AND d.group_dict_value = sp.production_mode) production_mode_sp,
                sp.company_contact_person,
                sp.company_contact_phone,
                sp.create_date,
                sp.supplier_info_origin_id,
                sp.cooperation_type,
                sp.supplier_info_id,
                sp.supplier_company_id,
                sp.company_id,
                (SELECT f.group_dict_name
                   FROM scmdata.sys_group_dict f
                  WHERE f.group_dict_type = 'COMPANY_TYPE'
                    AND f.group_dict_value = sp.company_type) company_type
           FROM scmdata.t_supplier_info sp
           LEFT JOIN scmdata.t_factory_ask fa
             ON sp.supplier_info_origin_id = fa.factory_ask_id
           LEFT JOIN scmdata.t_factory_report fr
             ON fa.factory_ask_id = fr.factory_ask_id
           LEFT JOIN scmdata.t_ask_record ar
             ON fa.ask_record_id = ar.ask_record_id
           LEFT JOIN scmdata.sys_company fc
             ON sp.social_credit_code = fc.licence_num
          WHERE sp.company_id = %default_company_id%
            AND sp.status = 1
            AND sp.supplier_info_origin <> 'II') v --先不展示接口导入的数据
   LEFT JOIN scmdata.t_factory_ask fa
     ON fa.factory_ask_id = v.supplier_info_origin_id
  ORDER BY v.create_date DESC]';

  UPDATE nbw.sys_item t
     SET t.show_rowid = 5
   WHERE t.item_id = 'a_supp_160';

  v_no_show_fields := 'supplier_info_id,company_id,supplier_company_id,supplier_info_origin_id,status,pause,cooperation_method_sp,production_mode_sp,sp_status_desc,bind_status,factory_ask_id';

  UPDATE nbw.sys_item_list t
     SET t.select_sql = v_select_sql, t.noshow_fields = v_no_show_fields
   WHERE t.item_id = 'a_supp_160';
END;
/

--4.  增加流程操作详情：从合作申请开始至建档的整个流程操作；
DECLARE
BEGIN
  INSERT INTO nbw.sys_item_rela
    (item_id, relate_id, relate_type, seq_no, pause)
  VALUES
    ('a_supp_150', 'a_coop_106', 'S', 1, 0);

  INSERT INTO nbw.sys_item_rela
    (item_id, relate_id, relate_type, seq_no, pause)
  VALUES
    ('a_supp_160', 'a_coop_106', 'S', 2, 0);
END;
/

--5.供应商档案关联Tab页
DECLARE
BEGIN
  UPDATE nbw.sys_item t
     SET t.item_type = 'manylist'
   WHERE t.item_id = 'a_supp_100';

  INSERT INTO sys_web_union
    (item_id, union_item_id, seqno, pause)
  VALUES
    ('a_supp_100', 'a_supp_150', 1, 0);

  INSERT INTO sys_web_union
    (item_id, union_item_id, seqno, pause)
  VALUES
    ('a_supp_100', 'a_supp_160', 2, 0);
END;









