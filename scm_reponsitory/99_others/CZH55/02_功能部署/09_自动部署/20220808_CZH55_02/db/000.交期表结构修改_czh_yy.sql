--QC更新标志字段要刷新
BEGIN  
  UPDATE scmdata.pt_ordered t SET t.updated_qc = 0 WHERE t.updated_qc IS NULL;
END;
/  
  
