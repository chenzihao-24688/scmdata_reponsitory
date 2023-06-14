ALTER TABLE plm.PLM_FILE ADD file_blob BLOB;
/
ALTER TABLE plm.PLM_FILE ADD file_unique VARCHAR2(32);
/
ALTER TABLE plm.PLM_FILE ADD file_size NUMBER(20);
/
comment on column plm.PLM_FILE.file_blob
  is '文件，BLOB格式(SCM)';
/
comment on column plm.PLM_FILE.file_unique
  is '文件唯一键(SCM：存FILE_INFO表的主键 【FILE_UNIQUE】 ；PLM：存PLM_FILE表的主键【FILE_ID】)';
/
comment on column plm.PLM_FILE.file_size
  is '文件大小';
/
ALTER TABLE mrp.mrp_picture ADD file_blob BLOB;
/
ALTER TABLE mrp.mrp_picture ADD file_unique VARCHAR2(32);
/
ALTER TABLE mrp.mrp_picture ADD file_size NUMBER(20);
/
comment on column MRP.MRP_PICTURE.file_blob
  is '文件，BLOB格式(SCM)';
/
comment on column MRP.MRP_PICTURE.file_unique
  is '文件唯一键(SCM：存FILE_INFO表的主键 【FILE_UNIQUE】 ；PLM：存PLM_FILE表的主键【FILE_ID】)';
/
comment on column MRP.MRP_PICTURE.file_size
  is '文件大小';
/
