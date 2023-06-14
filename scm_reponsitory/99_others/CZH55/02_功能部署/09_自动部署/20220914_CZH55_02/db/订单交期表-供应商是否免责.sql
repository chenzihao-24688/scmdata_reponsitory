BEGIN
  UPDATE scmdata.pt_ordered t
     SET t.is_sup_duty = NULL
   WHERE t.responsible_dept IS NULL
     AND t.is_sup_duty IS NOT NULL;
END;
/
