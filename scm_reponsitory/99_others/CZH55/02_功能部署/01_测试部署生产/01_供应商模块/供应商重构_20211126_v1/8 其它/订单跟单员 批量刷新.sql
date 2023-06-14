--订单跟单员 批量刷新
DECLARE
  v_gendan_perid VARCHAR2(4000);
  v_count        NUMBER := 0;
BEGIN
  FOR i IN (SELECT t.company_id, t.supplier_code, t.order_id
              FROM scmdata.t_ordered t
             WHERE t.company_id = 'b6cc680ad0f599cde0531164a8c0337f'
               AND t.deal_follower IS NULL) LOOP
  
    SELECT MAX(a.gendan_perid)
      INTO v_gendan_perid
      FROM scmdata.t_supplier_info a
     WHERE a.supplier_code = i.supplier_code
       AND a.company_id = i.company_id;
  
    UPDATE scmdata.t_ordered b
       SET b.deal_follower = v_gendan_perid
     WHERE b.order_id = i.order_id
       AND b.company_id = i.company_id;
  
    v_count := v_count + 1;
    --防止锁表
    IF MOD(v_count, 1000) = 0 THEN
      COMMIT;
    ELSE
      NULL;
    END IF;
  END LOOP;
END;
