   SELECT MAX(dd.group_config_id)
      INTO v_group_config_id
      FROM (SELECT *
              FROM (SELECT sa.coop_classification,
                           sa.coop_product_cate,
                           sp.company_province,
                           sp.company_city,
                           sp.company_id,
                           sp.supplier_info_id,
                           row_number() over(ORDER BY sa.create_time) rn
                      FROM scmdata.t_supplier_info sp
                     INNER JOIN scmdata.t_coop_scope sa
                        ON sa.company_id = sp.company_id
                       AND sa.supplier_info_id = sp.supplier_info_id
                     WHERE sa.supplier_info_id = p_supp_id
                       AND sa.company_id = p_company_id) va
             WHERE va.rn = 1) cc
     INNER JOIN (SELECT aa.group_name,
                        aa.group_config_id,
                        aa.area_group_leader,
                        bb.cooperation_classification,
                        bb.cooperation_product_cate,
                        ee.province_id,
                        ee.city_id
                   FROM scmdata.t_supplier_group_config aa
                  INNER JOIN scmdata.t_supplier_group_category_config bb
                     ON aa.group_config_id = bb.group_config_id
                    AND aa.pause = 1
                    AND bb.pause = 1
                  INNER JOIN scmdata.t_supplier_group_area_config ee
                     ON ee.pause = 1
                    AND instr(bb.area_config_id, ee.group_area_config_id) > 0
                  WHERE trunc(SYSDATE) BETWEEN trunc(aa.effective_time) AND
                        trunc(aa.end_time)) dd
        ON instr(';' || dd.cooperation_classification || ';',
                 ';' || cc.coop_classification || ';') > 0
       AND instr(';' || dd.cooperation_product_cate || ';',
                 ';' || cc.coop_product_cate || ';') > 0
       AND (instr(';' || dd.province_id || ';',
                  ';' || cc.company_province || ';') > 0 AND
            instr(';' || dd.city_id || ';', ';' || cc.company_city || ';') > 0)
