ALTER TABLE plm.PLM_FILE ADD file_blob BLOB;
/
ALTER TABLE plm.PLM_FILE ADD file_unique VARCHAR2(32);
/
ALTER TABLE plm.PLM_FILE ADD file_size NUMBER(20);
/
comment on column plm.PLM_FILE.file_blob
  is '�ļ���BLOB��ʽ(SCM)';
/
comment on column plm.PLM_FILE.file_unique
  is '�ļ�Ψһ��(SCM����FILE_INFO������� ��FILE_UNIQUE�� ��PLM����PLM_FILE���������FILE_ID��)';
/
comment on column plm.PLM_FILE.file_size
  is '�ļ���С';
/
ALTER TABLE mrp.mrp_picture ADD file_blob BLOB;
/
ALTER TABLE mrp.mrp_picture ADD file_unique VARCHAR2(32);
/
ALTER TABLE mrp.mrp_picture ADD file_size NUMBER(20);
/
comment on column MRP.MRP_PICTURE.file_blob
  is '�ļ���BLOB��ʽ(SCM)';
/
comment on column MRP.MRP_PICTURE.file_unique
  is '�ļ�Ψһ��(SCM����FILE_INFO������� ��FILE_UNIQUE�� ��PLM����PLM_FILE���������FILE_ID��)';
/
comment on column MRP.MRP_PICTURE.file_size
  is '�ļ���С';
/
