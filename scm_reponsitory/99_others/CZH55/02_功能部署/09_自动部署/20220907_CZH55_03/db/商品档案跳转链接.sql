BEGIN
  UPDATE bw3.sys_element t
     SET t.is_hide = 0
   WHERE t.element_id = 'asso_a_good_201_1';
END;
/
BEGIN
  UPDATE bw3.sys_item_element_rela a
     SET a.element_id = 'associate_a_approve_113_1'
   WHERE (a.item_id, a.element_id) IN
         (SELECT t.item_id, t.element_id
            FROM bw3.sys_item_element_rela t
           WHERE t.element_id = 'asso_a_good_201_1'
             AND t.item_id IN ('a_order_201_0',
                               'a_order_201_1',
                               'a_order_201_4',
                               'a_order_202_1',
                               'a_order_202_2',
                               'a_product_210',
                               'a_product_216',
                               'a_product_217'));

  UPDATE bw3.sys_element_hint a
     SET a.element_id = 'associate_a_approve_113_1'
   WHERE a.item_id IN ('a_order_201_0',
                       'a_order_201_1',
                       'a_order_201_4',
                       'a_order_202_1',
                       'a_order_202_2',
                       'a_product_210',
                       'a_product_216',
                       'a_product_217')
     AND a.element_id = 'asso_a_good_201_1';

END;
/
