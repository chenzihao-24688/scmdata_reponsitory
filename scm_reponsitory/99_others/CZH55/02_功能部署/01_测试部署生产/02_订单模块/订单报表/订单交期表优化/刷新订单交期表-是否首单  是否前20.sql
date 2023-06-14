--是否前20%
DECLARE
  p_company_id VARCHAR2(32) := 'b6cc680ad0f599cde0531164a8c0337f';
BEGIN
  UPDATE scmdata.pt_ordered pt
     SET pt.is_twenty = 1
   WHERE pt.company_id = p_company_id
     AND EXISTS (SELECT 1
            FROM scmdata.t_bestgoodsofmonth t
           INNER JOIN scmdata.t_commodity_info tc
              ON t.goo_id = tc.goo_id
             AND t.company_id = tc.company_id
           WHERE tc.rela_goo_id = pt.goo_id
             AND tc.company_id = pt.company_id);
END;
/
--是否首单 
DECLARE p_company_id VARCHAR2(32) := 'b6cc680ad0f599cde0531164a8c0337f';
v_count NUMBER := 0;
BEGIN
  FOR o_rec IN (SELECT t.order_id, t.company_id, t.isfirstordered
                  FROM scmdata.t_ordered t
                 WHERE t.company_id = p_company_id) LOOP
    UPDATE scmdata.pt_ordered pt
       SET pt.is_first_order = o_rec.isfirstordered
     WHERE pt.order_id = o_rec.order_id
       AND pt.company_id = o_rec.company_id;
    v_count := v_count + 1;
    IF MOD(v_count, 1000) = 0 THEN
      COMMIT;
    ELSE
      NULL;
      --COMMIT;
    END IF;
  END LOOP;
  COMMIT;
END;
