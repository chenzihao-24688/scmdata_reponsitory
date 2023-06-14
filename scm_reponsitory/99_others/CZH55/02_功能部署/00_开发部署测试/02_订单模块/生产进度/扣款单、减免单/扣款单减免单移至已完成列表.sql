DECLARE
BEGIN
  update bw3.sys_item_element_rela t set t.item_id = 'a_product_130_2' where t.element_id = 'word_a_product_130_1';
  update bw3.sys_item_element_rela t set t.item_id = 'a_product_130_2' where t.element_id = 'word_a_product_130_2';
END;
