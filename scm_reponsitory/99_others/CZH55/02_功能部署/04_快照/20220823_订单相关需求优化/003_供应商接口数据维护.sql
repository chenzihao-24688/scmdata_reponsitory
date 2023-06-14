BEGIN
  UPDATE scmdata.t_supplier_info t
     SET t.public_id = NULL, t.publish_date = NULL
   WHERE t.supplier_code IN ('C01567', 'C01552', 'C01462');
END;
/
