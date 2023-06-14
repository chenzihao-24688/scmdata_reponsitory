-- «∑Ò«∞20%
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
