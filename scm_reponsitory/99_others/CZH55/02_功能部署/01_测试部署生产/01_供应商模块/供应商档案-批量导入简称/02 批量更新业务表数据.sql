BEGIN
  FOR sup_rec IN (SELECT col_1 sup_id, col_3 sup_name
                    FROM scmdata.t_excel_import) LOOP
    UPDATE scmdata.t_supplier_info t
       SET t.supplier_company_abbreviation = sup_rec.sup_name
     WHERE t.supplier_code = sup_rec.sup_id
       AND t.company_id = 'b6cc680ad0f599cde0531164a8c0337f';
  END LOOP;
END;
