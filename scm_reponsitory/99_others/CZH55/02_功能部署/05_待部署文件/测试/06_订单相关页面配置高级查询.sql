BEGIN
  UPDATE bw3.sys_item_list t
     SET t.query_type = 13
   WHERE t.item_id IN ('a_product_120_1',
                       'a_product_120_2',
                       'a_product_130_1',
                       'a_product_130_2',
                       'a_product_130_4');

END;
/
