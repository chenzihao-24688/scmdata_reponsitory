BEGIN
  UPDATE bw3.sys_field_list t
     SET t.display_format = 'yyyy-MM-dd HH:mm:ss', t.data_type = 12
   WHERE t.field_name IN ('UPDATE_TIME_DEDU', 'APPROVE_TIME_PO');
END;
