--��Ʒ-����-���еĶ���������ʱ��7��30��  '07'  '0703'  '070301'
--��Ʒ-����-ͷ�εĶ���������ʱ��8��5��   '07'  '0703'  '070302'
--��Ʒ-����-��ָ�Ķ���������ʱ��7��31��  '07'  '0707'  '070702'
--��Ʒ-�������-ñ�ӵĶ���������ʱ��8��3��  '07'  '0704'  '070401'

--��ױ 06 -�þ� 062 -�������� 06202 �Ķ���������ʱ��7��30��
--��ױ 06 -���� 061 -���� 06105 �Ķ���������ʱ��8��5��
--��ױ 06 -��ױ 060 -������ 06006 �Ķ���������ʱ��7��31��
--��ױ 06 -��ױ 060 -��Һ 06015 �Ķ���������ʱ��8��3��

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
