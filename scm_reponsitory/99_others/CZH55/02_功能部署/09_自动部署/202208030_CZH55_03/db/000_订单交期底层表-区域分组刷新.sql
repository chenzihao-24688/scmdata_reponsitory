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
                               AND t.group_name IS NULL)) LOOP
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
           po.area_group_leaderid = v_area_group_leader,
           po.area_locatioin      = v_location_area
     WHERE po.company_id = p_pro_rec.company_id
       AND po.order_code = p_pro_rec.order_code;
    v_cnt := v_cnt + 1;
    IF MOD(v_cnt, 1000) = 0 THEN
      COMMIT;
    END IF;
  END LOOP;
END;
/ 
DECLARE 
v_location_area VARCHAR2(256);
v_group_name VARCHAR2(256);
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
                               AND t.group_name IS NULL)) LOOP
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
           pt.area_gp_leader = v_area_group_leader,
           pt.area_locatioin = v_location_area
     WHERE pt.company_id = p_pro_rec.company_id
       AND pt.product_gress_code = p_pro_rec.product_gress_code;
  END LOOP;
END;
/
