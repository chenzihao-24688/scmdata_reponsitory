BEGIN
UPDATE bw3.sys_field_list_file t
   SET t.file_postfix = t.file_postfix || ',heic'
 WHERE 1 = 1
   AND t.file_postfix IS NOT NULL
   AND instr(t.file_postfix, ',heic') = 0;
END;
/
