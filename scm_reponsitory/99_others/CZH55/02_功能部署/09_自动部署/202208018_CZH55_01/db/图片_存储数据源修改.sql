BEGIN
UPDATE bw3.sys_field_list t
   SET t.store_source = 'MONGO#PRO'
 WHERE t.store_source IS NULL
   AND t.data_type = 51
   AND t.field_name NOT IN ('PICTURE', 'PICTURE1', 'PICTURE_PR');
END;
/
