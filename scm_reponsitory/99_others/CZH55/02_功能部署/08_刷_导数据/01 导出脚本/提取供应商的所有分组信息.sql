SELECT cc.supplier_code,
       cc.inside_supplier_code,
       cc.supplier_company_name,
       cc.supplier_company_abbreviation,
       cc.pause,
       dd.group_name
  FROM (SELECT sa.coop_classification,
               sa.coop_product_cate,
               sa.coop_subcategory,
               sp.company_province,
               sp.company_city,
               sp.company_id,
               sp.supplier_info_id,
               sp.pause,
               sp.supplier_code,
               sp.inside_supplier_code,
               sp.supplier_company_name,
               sp.supplier_company_abbreviation
          FROM scmdata.t_supplier_info sp
         INNER JOIN scmdata.t_coop_scope sa
            ON sa.company_id = sp.company_id
           AND sa.supplier_info_id = sp.supplier_info_id
           AND sa.pause = 0) cc
 INNER JOIN (SELECT aa.group_name,
                    aa.area_group_leader,
                    bb.cooperation_classification,
                    bb.cooperation_product_cate,
                    ff.subcategory,
                    ee.province_id,
                    ee.city_id
               FROM scmdata.t_supplier_group_config aa
              INNER JOIN scmdata.t_supplier_group_category_config bb
                 ON aa.group_config_id = bb.group_config_id
                AND aa.pause = 1
                AND bb.pause = 1
              INNER JOIN scmdata.t_supplier_group_subcate_config ff
                 ON ff.group_category_config_id =
                    bb.group_category_config_id
                AND ff.company_id = bb.company_id
                AND ff.pause = 1
              INNER JOIN scmdata.t_supplier_group_area_config ee
                 ON ee.pause = 1
                AND instr(bb.area_config_id, ee.group_area_config_id) > 0
              WHERE trunc(SYSDATE) BETWEEN trunc(aa.effective_time) AND
                    trunc(aa.end_time)) dd
    ON instr_priv(dd.cooperation_classification, cc.coop_classification) > 0
   AND instr_priv(dd.cooperation_product_cate, cc.coop_product_cate) > 0
   AND instr_priv(dd.subcategory, cc.coop_subcategory) > 0
   AND (instr(dd.province_id, cc.company_province) > 0 AND
        instr(dd.city_id, cc.company_city) > 0)
 WHERE cc.company_id = 'b6cc680ad0f599cde0531164a8c0337f';
