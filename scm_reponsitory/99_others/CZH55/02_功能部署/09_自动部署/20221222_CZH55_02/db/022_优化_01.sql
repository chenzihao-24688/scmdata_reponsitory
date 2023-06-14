BEGIN
  UPDATE bw3.sys_field_list t
     SET t.check_express = '^[1-9][0-9]?$',
         t.check_message = '【序号】只能填写正整数，且限制最大两位数'
   WHERE t.field_name = 'NEW_SEQ_NUM';
END;
/
