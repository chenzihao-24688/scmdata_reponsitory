BEGIN
  UPDATE bw3.sys_field_list t
     SET t.check_express = '^[1-9][0-9]?$',
         t.check_message = '����š�ֻ����д�������������������λ��'
   WHERE t.field_name = 'NEW_SEQ_NUM';
END;
/
