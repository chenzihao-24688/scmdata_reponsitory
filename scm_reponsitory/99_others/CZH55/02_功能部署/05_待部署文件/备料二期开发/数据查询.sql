SELECT * from mrp.color_prepare_order t WHERE t.prepare_order_id = 'CKBL2023050900003';
SELECT * from mrp.color_prepare_product_order t WHERE t.product_order_id = 'CKSC2023050900003';
SELECT * from mrp.supplier_grey_in_out_bound t WHERE t.relate_num = 'CKSC2023050900003';

SELECT *
  FROM mrp.supplier_grey_stock t
 WHERE t.pro_supplier_code = 'b4fb696c81933515e0533c281cacee22'
   AND t.mater_supplier_code = 'L2301702'
   AND t.unit = '¸ö'
   AND t.material_spu = 'WFH000016'
   AND t.whether_del = 0;

SELECT * from mrp.color_prepare_batch_finish_order t WHERE t.product_order_id = 'CKSC2023050900003';
