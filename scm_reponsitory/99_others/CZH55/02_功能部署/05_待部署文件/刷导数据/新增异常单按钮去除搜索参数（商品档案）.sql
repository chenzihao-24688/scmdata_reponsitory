BEGIN
  UPDATE bw3.sys_action t
     SET t.query_fields = 'product_gress_code_pr,rela_goo_id,style_number_pr'
   WHERE t.element_id IN ('action_a_product_118_2',
                          'action_a_product_118_3',
                          'action_a_product_118_4');
END;
/
