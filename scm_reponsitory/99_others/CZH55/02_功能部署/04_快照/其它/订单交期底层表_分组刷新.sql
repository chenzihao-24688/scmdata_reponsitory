BEGIN
  UPDATE scmdata.t_ordered a
     SET a.area_group_id       = NULL,
         a.area_group_leaderid = NULL,
         a.area_locatioin      = NULL
   WHERE (a.order_id, a.company_id) IN
         (SELECT t.order_id, t.company_id
            FROM scmdata.pt_ordered t
           WHERE t.company_id = 'b6cc680ad0f599cde0531164a8c0337f'
             AND t.year = '2022'
             AND t.group_name IS NULL
             AND t.factory_code NOT IN ('C00563', 'C00216'));
END;
/
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
                               AND t.year = '2022'
                               AND t.group_name IS NULL
                               AND t.factory_code NOT IN ('C00563', 'C00216'))) LOOP
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
BEGIN
  MERGE INTO (SELECT *
                FROM scmdata.pt_ordered t
               WHERE t.company_id = 'b6cc680ad0f599cde0531164a8c0337f'
                 AND t.year = '2022'
                 AND t.group_name IS NULL
                 AND t.factory_code NOT IN ('C00563', 'C00216')) pta
  USING (
    WITH supp_info AS
     (SELECT sp.company_id,
             sp.supplier_code,
             sp.inside_supplier_code,
             sp.supplier_company_name,
             province || city || county location_area,
             sp.group_name,
             sg.area_group_leader,
             sp.company_province,
             sp.company_city,
             sp.company_county
        FROM scmdata.t_supplier_info sp
        LEFT JOIN scmdata.dic_province p
          ON p.provinceid = sp.company_province
        LEFT JOIN scmdata.dic_city c
          ON c.cityno = sp.company_city
        LEFT JOIN scmdata.dic_county dc
          ON dc.countyid = sp.company_county
        LEFT JOIN scmdata.t_supplier_group_config sg
          ON sg.group_config_id = sp.group_name
         AND sg.pause = 1),
    group_dict AS
     (SELECT group_dict_type, group_dict_value, group_dict_name
        FROM scmdata.sys_group_dict),
    dilvery_info AS
     (SELECT company_id,
             order_code,
             goo_id,
             delivery_amount,
             delivery_date,
             predict_delivery_amount
        FROM scmdata.t_delivery_record)
    SELECT DISTINCT *
      FROM (SELECT (CASE
                     WHEN sp_b.inside_supplier_code NOT IN ('30928', '73036') THEN
                      (CASE
                        WHEN po.order_status = 'OS02' THEN
                         po.area_group_leaderid
                        ELSE
                         sp_b.area_group_leader
                      END)
                     ELSE
                      NULL
                   END) area_gp_leader, --区域组长
                   (CASE
                     WHEN sp_b.inside_supplier_code NOT IN ('30928', '73036') THEN
                      (CASE
                        WHEN po.order_status = 'OS02' THEN
                         po.area_group_id
                        ELSE
                         sp_b.group_name
                      END)
                     ELSE
                      NULL
                   END) group_name,
                   (CASE
                     WHEN sp_b.inside_supplier_code NOT IN ('30928', '73036') THEN
                      (CASE
                        WHEN po.order_status = 'OS02' THEN
                         po.area_locatioin
                        ELSE
                         sp_b.location_area
                      END)
                     ELSE
                      NULL
                   END) location_area,
                   po.order_id,
                   po.company_id,
                   pr.latest_planned_delivery_date,
                   po.is_product_order
              FROM scmdata.t_ordered po
             INNER JOIN scmdata.t_orders pln
                ON po.company_id = pln.company_id
               AND po.order_code = pln.order_id
             INNER JOIN scmdata.t_production_progress pr
                ON pln.company_id = pr.company_id
               AND pln.order_id = pr.order_id
               AND pln.goo_id = pr.goo_id
              LEFT JOIN supp_info sp_b
                ON sp_b.company_id = pr.company_id
               AND sp_b.supplier_code = pr.factory_code
             WHERE po.company_id = 'b6cc680ad0f599cde0531164a8c0337f')) ptb
        ON (pta.company_id = ptb.company_id AND pta.order_id = ptb.order_id) WHEN
     MATCHED THEN
      UPDATE
         SET pta.group_name     = ptb.group_name,
             pta.area_locatioin = ptb.location_area,
             pta.area_gp_leader = ptb.area_gp_leader;
END;
/
