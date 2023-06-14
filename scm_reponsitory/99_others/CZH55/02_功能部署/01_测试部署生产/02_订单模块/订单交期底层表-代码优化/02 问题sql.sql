WITH supp_info AS
 (SELECT company_id,
         supplier_code,
         inside_supplier_code,
         supplier_company_name,
         area_group_leader
    FROM scmdata.t_supplier_info),
group_dict AS
 (SELECT group_dict_type, group_dict_value, group_dict_name
    FROM scmdata.sys_group_dict),
dilvery_info AS
 (SELECT company_id,
         order_code,
         goo_id,
         delivery_amount,
         delivery_date,
         predict_delivery_amount
    FROM scmdata.t_delivery_record)
SELECT DISTINCT *
  FROM (SELECT to_number(extract(YEAR FROM po.delivery_date)) YEAR,
               to_number(to_char(po.delivery_date, 'Q')) quarter,
               to_number(extract(MONTH FROM po.delivery_date)) MONTH,
               --pr.supplier_code,
               sp_a.inside_supplier_code,
               sp_a.supplier_company_name,
               pr.factory_code,
               sp_b.supplier_company_name factory_company_name,
               pr.product_gress_code,
               tc.rela_goo_id,
               tc.category,
               tc.product_cate,
               tc.samll_category,
               a.group_dict_name category_desc,
               b.group_dict_name coop_product_cate_desc,
               c.company_dict_name product_subclass_desc,
               tc.style_name,
               tc.style_number,
               po.deal_follower flw_order, --����Ա
               '' flw_order_manager, --��������  ��Դ�ֶδ���
               v.finish_qc_id qc, --qc
               '' qc_manager, --QC����  ��Դ�ֶδ���
               sp_a.area_group_leader area_gp_leader, --�����鳤
               --'' is_twenty, --�Ƿ�ǰ20%
               CASE
                 WHEN pr.delivery_amount = 0 THEN
                  CASE
                    WHEN pr.progress_status = '01' THEN
                     'ȡ������'
                    ELSE
                     'δ����'
                  END
                 ELSE
                  CASE
                    WHEN trunc(pr.actual_delivery_date) -
                         trunc(po.delivery_date) <= 0 THEN
                     '����'
                    ELSE
                     '����'
                  END
               END delivery_status, --����״̬
               pr.is_quality is_quality, --�Ƿ�������������
               pr.actual_delay_day,
               CASE
                 WHEN pr.actual_delay_day = 0 THEN
                  ''
                 WHEN pr.actual_delay_day BETWEEN 1 AND 3 THEN
                  '1~3��'
                 WHEN pr.actual_delay_day BETWEEN 4 AND 6 THEN
                  '4~6��'
                 ELSE
                  '7������'
               END delay_interval,
               pr.responsible_dept,
               pr.responsible_dept_sec,
               pr.delay_problem_class,
               pr.delay_cause_class,
               pr.delay_cause_detailed,
               pr.problem_desc,
               pln.order_price,
               tc.price,
               pr.order_amount,
               nvl(SUM(dr.predict_delivery_amount)
                   over(PARTITION BY pr.product_gress_id),
                   0) est_arrival_amount, --Ԥ�Ƶ�����
               pr.delivery_amount,
               SUM(CASE
                     WHEN trunc(dr.delivery_date) - trunc(po.delivery_date) <= 0 THEN
                      dr.delivery_amount
                     ELSE
                      0
                   END) over(PARTITION BY pr.product_gress_id) satisfy_amount, --��������
               pln.order_amount * tc.price order_money,
               pr.delivery_amount * tc.price delivery_money,
               SUM(CASE
                     WHEN trunc(dr.delivery_date) - trunc(po.delivery_date) <= 0 THEN
                      dr.delivery_amount
                     ELSE
                      0
                   END) over(PARTITION BY pr.product_gress_id) * tc.price satisfy_money, --������ * pln.order_price
               po.delivery_date,
               po.create_time,
               '' arrival_date, --��������
               '' sort_date, --�ּ�����
               po.isfirstordered isfirstordered, --�Ƿ��׵�
               po.memo,
               po.finish_time_scm,
               po.company_id,
               po.order_id
          FROM scmdata.t_ordered po
         INNER JOIN scmdata.t_orders pln
            ON po.company_id = pln.company_id
           AND po.order_code = pln.order_id
         INNER JOIN scmdata.t_production_progress pr
            ON pln.company_id = pr.company_id
           AND pln.order_id = pr.order_id
           AND pln.goo_id = pr.goo_id
         INNER JOIN scmdata.t_commodity_info tc
            ON pr.company_id = tc.company_id
           AND pr.goo_id = tc.goo_id
          LEFT JOIN dilvery_info dr
            ON pr.company_id = dr.company_id
           AND pr.order_id = dr.order_code
           AND pr.goo_id = dr.goo_id
          LEFT JOIN supp_info sp_a
            ON sp_a.company_id = pr.company_id
           AND sp_a.supplier_code = pr.supplier_code
          LEFT JOIN supp_info sp_b
            ON sp_b.company_id = pr.company_id
           AND sp_b.supplier_code = pr.factory_code
          LEFT JOIN group_dict a
            ON a.group_dict_type = 'PRODUCT_TYPE'
           AND a.group_dict_value = tc.category
          LEFT JOIN group_dict b
            ON b.group_dict_type = a.group_dict_value
           AND b.group_dict_value = tc.product_cate
          LEFT JOIN scmdata.sys_company_dict c
            ON c.company_dict_type = b.group_dict_value
           AND c.company_dict_value = tc.samll_category
           AND c.company_id = tc.company_id
          LEFT JOIN (SELECT qc_a.orders_id,
                           listagg(DISTINCT qc_b.finish_qc_id, ',') over(PARTITION BY qc_a.orders_id) finish_qc_id
                      FROM scmdata.t_qc_check_rela_order qc_a
                     INNER JOIN scmdata.t_qc_check qc_b
                        ON qc_b.finish_time IS NOT NULL
                       AND qc_b.qc_check_id = qc_a.qc_check_id
                       AND qc_b.qc_check_node = 'QC_FINAL_CHECK') v
            ON v.orders_id = pln.orders_id
         WHERE po.company_id = 'b6cc680ad0f599cde0531164a8c0337f'
              --1�������³����µ� ͬ�����¶���
           AND ((po.delivery_date BETWEEN
               to_date('2022-02-01', 'yyyy-mm-dd') AND
               to_date('2022-02-28', 'yyyy-mm-dd')) OR
               --2�������³�������5�� ͬ�����¶���
               to_char(po.delivery_date, 'yyyy-mm') = '2022-01'))
