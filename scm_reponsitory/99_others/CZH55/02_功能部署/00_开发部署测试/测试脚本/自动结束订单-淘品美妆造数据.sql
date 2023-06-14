--淘品-发饰-发夹的订单，结束时间7月30号  '07'  '0703'  '070301'
--淘品-发饰-头饰的订单，结束时间8月5号   '07'  '0703'  '070302'
--淘品-首饰-戒指的订单，结束时间7月31号  '07'  '0707'  '070702'
--淘品-服饰配件-帽子的订单，结束时间8月3号  '07'  '0704'  '070401'

--美妆 06 -用具 062 -美发工具 06202 的订单，结束时间7月30号
--美妆 06 -护肤 061 -护发 06105 的订单，结束时间8月5号
--美妆 06 -彩妆 060 -甲饰类 06006 的订单，结束时间7月31号
--美妆 06 -彩妆 060 -唇液 06015 的订单，结束时间8月3号

DECLARE
  v_category       VARCHAR2(32) := '06';
  v_product_cate   VARCHAR2(32) := '060';
  v_samll_category VARCHAR2(32) := '06015';
  v_finish_time    DATE := to_date('2021-08-03', 'YYYY-MM-DD');
  v_company_id     VARCHAR2(32) := 'b6cc680ad0f599cde0531164a8c0337f';
BEGIN

  FOR order_rec IN (SELECT a.company_id, a.order_id
                      FROM scmdata.t_orders a
                     INNER JOIN scmdata.t_commodity_info b
                        ON a.company_id = b.company_id
                       AND a.goo_id = b.goo_id
                     WHERE a.company_id = 'b6cc680ad0f599cde0531164a8c0337f'
                       AND b.category = v_category
                       AND b.product_cate = v_product_cate
                       AND b.samll_category = v_samll_category) LOOP
  
    UPDATE scmdata.t_ordered t
       SET t.finish_time = v_finish_time
     WHERE t.company_id = 'b6cc680ad0f599cde0531164a8c0337f'
       AND t.order_code = order_rec.order_id;
  
  END LOOP;

END;

SELECT a.company_id, a.order_id, t.finish_time
  FROM scmdata.t_ordered t
 INNER JOIN scmdata.t_orders a
    ON t.company_id = a.company_id
   AND t.order_code = a.order_id
 INNER JOIN scmdata.t_commodity_info b
    ON a.company_id = b.company_id
   AND a.goo_id = b.goo_id
 WHERE a.company_id = 'b6cc680ad0f599cde0531164a8c0337f'
   AND b.category = '06'
   AND b.product_cate = '061'
   AND b.samll_category = '06105'
