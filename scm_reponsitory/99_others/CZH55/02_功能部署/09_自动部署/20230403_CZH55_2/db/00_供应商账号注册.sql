BEGIN
  UPDATE scmdata.t_supplier_info t
     SET t.supplier_company_id = 'dce65fe7bf4c6ea5e0531164a8c06c89'
   WHERE t.supplier_code = 'C00288'
     AND t.company_id = 'b6cc680ad0f599cde0531164a8c0337f';
END;
/
