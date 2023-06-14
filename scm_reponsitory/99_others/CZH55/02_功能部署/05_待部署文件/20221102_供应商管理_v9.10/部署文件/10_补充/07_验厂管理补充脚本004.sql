update bw3.sys_field_list t
   set t.check_express = '^[+]{0,1}(\d+)$',t.data_type = '10'
 where t.field_name in ('PRODUCT_LINE_NUM','PRODUCT_LINE_NUM_N','AR_PRODUCT_LINE_NUM_N','AR_MACHINE_NUM_Y');
