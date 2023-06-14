DECLARE
BEGIN
  UPDATE scmdata.t_supplier_info t
     SET t.update_id    = NULL,
         t.update_date  = NULL,
         t.publish_id   = NULL,
         t.publish_date = NULL
   WHERE t.supplier_code = 'C01511'
     AND t.company_id = 'b6cc680ad0f599cde0531164a8c0337f';
END;
/
