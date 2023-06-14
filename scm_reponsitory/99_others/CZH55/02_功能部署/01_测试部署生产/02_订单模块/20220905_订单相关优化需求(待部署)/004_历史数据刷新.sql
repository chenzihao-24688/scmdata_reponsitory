DECLARE
  v_company_id VARCHAR2(32) := 'b6cc680ad0f599cde0531164a8c0337f';
BEGIN
  FOR i IN (SELECT pr.product_gress_code, tc.season, sp.company_vill
              FROM scmdata.t_production_progress pr
              LEFT JOIN scmdata.t_commodity_info tc
                ON tc.goo_id = pr.goo_id
               AND tc.company_id = pr.company_id
              LEFT JOIN scmdata.t_supplier_info sp
                ON sp.supplier_code = pr.factory_code
               AND sp.company_id = pr.company_id
             WHERE pr.company_id = v_company_id
               AND pr.progress_status = '01') LOOP
    UPDATE scmdata.t_ordered po
       SET po.season = i.season, po.company_vill = i.company_vill
     WHERE po.company_id = v_company_id
       AND po.order_code = i.product_gress_code;
  END LOOP;
END;
/ 
DECLARE 
v_company_id VARCHAR2(32) := 'b6cc680ad0f599cde0531164a8c0337f';
v_cnt INT := 0;
BEGIN
  FOR i IN (SELECT pr.product_gress_code, tc.season
              FROM scmdata.t_production_progress pr
              LEFT JOIN scmdata.t_commodity_info tc
                ON tc.goo_id = pr.goo_id
               AND tc.company_id = pr.company_id
             WHERE pr.company_id = v_company_id) LOOP
    UPDATE scmdata.pt_ordered po
       SET po.season = i.season
     WHERE po.company_id = v_company_id
       AND po.product_gress_code = i.product_gress_code;
    v_cnt := v_cnt + 1;
    IF MOD(v_cnt, 1000) = 0 THEN
      COMMIT;
    END IF;
  END LOOP;
  COMMIT;
END;
/

