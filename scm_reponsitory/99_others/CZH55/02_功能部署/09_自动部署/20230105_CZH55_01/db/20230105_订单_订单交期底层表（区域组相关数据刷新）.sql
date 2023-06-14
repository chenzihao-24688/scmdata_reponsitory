DECLARE
  v_group_name   VARCHAR2(256);
  v_group_leader VARCHAR2(256);
BEGIN
  FOR order_rec IN (SELECT t.order_id, t.company_id, t.factory_code
                      FROM scmdata.pt_ordered t
                     WHERE t.delivery_date BETWEEN
                           to_date('2023-01-01', 'yyyy-mm-dd') AND
                           to_date('2023-01-05', 'yyyy-mm-dd')
                       AND t.order_finish_time IS NOT NULL
                       AND t.group_name IS NULL
                       AND t.area_gp_leader IS NULL
                       AND t.supplier_code NOT IN ('30928', '73036')) LOOP
  
    SELECT MAX(a.group_name), MAX(a.area_group_leader)
      INTO v_group_name, v_group_leader
      FROM scmdata.t_supplier_info a
     WHERE a.company_id = order_rec.company_id
       AND a.supplier_code = order_rec.factory_code;
  
    UPDATE scmdata.t_ordered po
       SET po.area_group_id       = v_group_name,
           po.area_group_leaderid = v_group_leader
     WHERE po.order_id = order_rec.order_id
       AND po.company_id = order_rec.company_id;
  
    UPDATE scmdata.pt_ordered pt
       SET pt.group_name = v_group_name, pt.area_gp_leader = v_group_leader
     WHERE pt.order_id = order_rec.order_id
       AND pt.company_id = order_rec.company_id;  
  END LOOP;
END;
/
