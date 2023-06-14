BEGIN
  UPDATE bw3.sys_field_list t
     SET t.store_source = 'MONGO#PRO'
   WHERE t.field_name IN ('SP_OTHER_INFORMATION_N', 'SP_CERTIFICATE_FILE_Y');
END;
/
