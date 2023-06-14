--供应商档案-分组刷新
BEGIN
  UPDATE scmdata.t_supplier_info t SET t.group_name = NULL,t.group_name_origin = NULL,t.area_group_leader = NULL WHERE  1 = 1;
END;
/
BEGIN
  FOR sup_rec IN (SELECT t.company_province,
                         t.company_city,
                         vc.coop_classification,
                         vc.coop_product_cate,
                         t.supplier_info_id,
                         t.company_id,
                         t.pause
                    FROM scmdata.t_supplier_info t
                   INNER JOIN (SELECT *
                                FROM (SELECT tc.coop_classification,
                                             tc.coop_product_cate,
                                             row_number() over(PARTITION BY tc.supplier_info_id, tc.company_id ORDER BY tc.create_time DESC) rn,
                                             tc.supplier_info_id,
                                             tc.company_id
                                        FROM scmdata.t_coop_scope tc
                                       WHERE tc.company_id =
                                             'b6cc680ad0f599cde0531164a8c0337f')
                               WHERE rn = 1) vc
                      ON vc.supplier_info_id = t.supplier_info_id
                     AND vc.company_id = t.company_id
                   WHERE t.company_id = 'b6cc680ad0f599cde0531164a8c0337f'
                     AND t.group_name IS NULL) LOOP
  
    scmdata.pkg_supplier_info.p_update_group_name(p_company_id       => sup_rec.company_id,
                                                  p_supplier_info_id => sup_rec.supplier_info_id,
                                                  p_is_trigger       => 0,
                                                  p_pause            => 1,
                                                  p_is_by_pick       => 1,
                                                  p_is_create_sup    => 1,
                                                  p_province         => sup_rec.company_province,
                                                  p_city             => sup_rec.company_city);
  END LOOP;
END;
/
--订单分组刷新
DECLARE
  v_location_area     VARCHAR2(256);
  v_group_name        VARCHAR2(256);
  v_area_group_leader VARCHAR2(256);
  v_cnt               INT;
BEGIN
  FOR p_pro_rec IN (SELECT pr.company_id,
                           pr.factory_code,
                           pr.product_gress_code order_code
                      FROM scmdata.t_production_progress pr
                     WHERE (pr.product_gress_code, pr.company_id) IN
                           (SELECT t.product_gress_code, t.company_id
                              FROM scmdata.pt_ordered t
                             WHERE t.company_id =
                                   'b6cc680ad0f599cde0531164a8c0337f'
                               AND t.year = 2023
                               AND t.order_finish_time IS NOT NULL)) LOOP
    --zxp 新增需求 获取订单供应商对应的“所在区域”、“分组名称”、“区域组长”，并存入订单表
    SELECT MAX(province || city || county) location_area,
           MAX(sp.group_name) group_name,
           MAX(sg.area_group_leader) area_group_leader
      INTO v_location_area, v_group_name, v_area_group_leader
      FROM scmdata.t_supplier_info sp
      LEFT JOIN scmdata.dic_province p
        ON p.provinceid = sp.company_province
      LEFT JOIN scmdata.dic_city c
        ON c.cityno = sp.company_city
      LEFT JOIN scmdata.dic_county dc
        ON dc.countyid = sp.company_county
      LEFT JOIN scmdata.t_supplier_group_config sg
        ON sg.group_config_id = sp.group_name
       AND sg.pause = 1
     WHERE sp.supplier_code = p_pro_rec.factory_code
       AND sp.company_id = p_pro_rec.company_id;
  
    UPDATE scmdata.t_ordered po
       SET po.area_group_id       = v_group_name,
           po.area_group_leaderid = v_area_group_leader
     WHERE po.company_id = p_pro_rec.company_id
       AND po.order_code = p_pro_rec.order_code;
    v_cnt := v_cnt + 1;
    IF MOD(v_cnt, 1000) = 0 THEN
      COMMIT;
    END IF;
  END LOOP;
END;
/ 
--交期底层表-分组刷新
DECLARE
  v_location_area     VARCHAR2(256);
  v_group_name        VARCHAR2(256);
  v_area_group_leader VARCHAR2(256);
BEGIN
  FOR p_pro_rec IN (SELECT pr.company_id,
                           pr.factory_code,
                           pr.product_gress_code
                      FROM scmdata.t_production_progress pr
                     WHERE (pr.product_gress_code, pr.company_id) IN
                           (SELECT t.product_gress_code, t.company_id
                              FROM scmdata.pt_ordered t
                             WHERE t.company_id =
                                   'b6cc680ad0f599cde0531164a8c0337f'
                               AND t.year = 2023
                               AND t.order_finish_time IS NOT NULL)) LOOP
    --zxp 新增需求 获取订单供应商对应的“所在区域”、“分组名称”、“区域组长”，并存入订单表
    SELECT MAX(province || city || county) location_area,
           MAX(sp.group_name) group_name,
           MAX(sg.area_group_leader) area_group_leader
      INTO v_location_area, v_group_name, v_area_group_leader
      FROM scmdata.t_supplier_info sp
      LEFT JOIN scmdata.dic_province p
        ON p.provinceid = sp.company_province
      LEFT JOIN scmdata.dic_city c
        ON c.cityno = sp.company_city
      LEFT JOIN scmdata.dic_county dc
        ON dc.countyid = sp.company_county
      LEFT JOIN scmdata.t_supplier_group_config sg
        ON sg.group_config_id = sp.group_name
       AND sg.pause = 1
     WHERE sp.supplier_code = p_pro_rec.factory_code
       AND sp.company_id = p_pro_rec.company_id;
  
    UPDATE scmdata.pt_ordered pt
       SET pt.group_name     = v_group_name,
           pt.area_gp_leader = v_area_group_leader
     WHERE pt.company_id = p_pro_rec.company_id
       AND pt.product_gress_code = p_pro_rec.product_gress_code;
  END LOOP;
END;
/
