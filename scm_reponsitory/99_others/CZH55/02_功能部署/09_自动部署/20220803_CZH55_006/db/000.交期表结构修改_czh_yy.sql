ALTER TABLE SCMDATA.PT_ORDERED ADD SHO_ID VARCHAR2(256);
comment on column scmdata.PT_ORDERED.SHO_ID
  is '�ֿ�';
--QC���±�־�ֶ�Ҫˢ��
BEGIN  
  UPDATE scmdata.pt_ordered t SET t.updated_qc = 0 WHERE t.updated_qc IS NULL;
END;
/  
  
