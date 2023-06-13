BEGIN
  UPDATE scmdata.t_supplier_info t
     SET t.publish_id   = NULL,
         t.publish_date = NULL,
         t.update_id    = t.create_id,
         t.update_date  = t.create_date
   WHERE t.supplier_code = 'C02259'
     AND t.company_id = 'b6cc680ad0f599cde0531164a8c0337f';
END;
/
