--新增生产进度表
/*DELETE FROM t_supplier_info;
DELETE FROM t_commodity_info;
DELETE FROM t_ordered;
DELETE FROM t_orders;
DELETE FROM t_production_progress;

SELECT * FROM t_supplier_info;
SELECT * FROM t_commodity_info;
SELECT * FROM t_ordered;
SELECT * FROM t_orders;
SELECT * FROM t_production_progress;*/

DECLARE
  v_year         VARCHAR2(10) := substr(to_char(SYSDATE, 'yyyy'), 3, 2);
  v_goo_id       VARCHAR2(100);
  v_rela_goo_id  VARCHAR2(100);
  v_style_number VARCHAR2(100);
  v_order_id     VARCHAR2(100);
  v_company_id   VARCHAR2(100) := 'a972dd1ffe3b3a10e0533c281cac8fd7';
  v_user_id      VARCHAR2(100) := 'czh';
  v_av_id        VARCHAR2(100) := 'czh';
  v_order_code   VARCHAR2(100);
  v_orders_id    VARCHAR2(100);
  v_orders_code  VARCHAR2(100);
  v_rea_goo_id   NUMBER := 0;

BEGIN
  BEGIN
    --1.生产商品档案
    FOR i IN 1 .. 3 LOOP
      v_goo_id       := scmdata.pkg_plat_comm.f_getkeycode(pi_table_name  => 't_commodity_info', --表名
                                                           pi_column_name => 'goo_id', --列名
                                                           pi_company_id  => v_company_id, --公司编号
                                                           pi_pre         => v_year, --前缀
                                                           pi_serail_num  => 6);
      v_rela_goo_id  := 'A00' || i;
      v_style_number := 'KA00' || i;
      --dbms_output.put_line(v_goo_id);
      --商品档案
      INSERT INTO scmdata.t_commodity_info
        (commodity_info_id,
         company_id,
         origin,
         style_pic,
         supplier_code,
         rela_goo_id,
         goo_id,
         sup_style_number,
         style_number, --需校验企业级唯一
         category,
         samll_category,
         style_name,
         YEAR,
         season,
         base_size,
         inprice,
         price,
         color_list,
         size_list,
         product_cate,
         create_time,
         create_id,
         update_time,
         update_id)
      VALUES
        (scmdata.f_get_uuid(),
         v_company_id,
         '新增',
         'aaa',
         'C0000' || i,
         v_rela_goo_id, --熊猫过来的关联货号
         v_goo_id,
         v_style_number,
         v_style_number,
         '00',
         '0011',
         '001102',
         v_year,
         '夏季',
         'GDV0100',
         i * 14,
         '50' + i,
         'R000',
         'GDV0100',
         '0011',
         SYSDATE,
         'czh',
         SYSDATE,
         'czh');
    END LOOP;
  END;
  --生产批版数据
  scmdata.pkg_approve_insert.p_insert_all_approve(v_company_id,
                                                  v_good_id,
                                                  v_user_id);

  --2.生产订单头
  BEGIN
    FOR i IN 1 .. 3 LOOP
      v_order_id   := scmdata.f_get_uuid();
      v_order_code := scmdata.pkg_plat_comm.f_getkeycode(pi_table_name  => 't_ordered', --表名
                                                         pi_column_name => 'order_code', --列名
                                                         pi_company_id  => v_company_id, --公司编号
                                                         pi_pre         => 'PO' ||
                                                                           to_char(SYSDATE,
                                                                                   'YYYYMMDD'), --前缀
                                                         pi_serail_num  => 3);
      INSERT INTO t_ordered
        (order_id,
         company_id,
         order_code,
         order_status,
         order_type,
         delivery_date,
         supplier_code,
         factory_code,
         send_order,
         send_order_date,
         receive_orderid,
         receive_company_id,
         receive_order_date,
         create_id,
         create_time,
         finish_time,
         origin,
         memo)
      VALUES
        (v_order_id,
         v_company_id,
         v_order_code,
         '已接单',
         '集采',
         SYSDATE,
         'C0000' || i,
         'C0000' || i,
         'czh',
         SYSDATE,
         'czh',
         v_company_id,
         SYSDATE,
         'czh',
         SYSDATE,
         SYSDATE,
         'chenzh',
         '');
    END LOOP;
  END;
  --3.生产订单行
  BEGIN
    FOR orders_rec IN (SELECT *
                         FROM t_ordered t
                        WHERE t.company_id = v_company_id) LOOP
    
      v_rea_goo_id  := v_rea_goo_id + 1;
      v_orders_id   := scmdata.f_get_uuid();
      v_orders_code := scmdata.pkg_plat_comm.f_getkeycode(pi_table_name  => 't_orders', --表名
                                                          pi_column_name => 'orders_code', --列名
                                                          pi_company_id  => v_company_id, --公司编号
                                                          pi_pre         => 'PO' ||
                                                                            to_char(SYSDATE,
                                                                                    'YYYYMMDD'), --前缀
                                                          pi_serail_num  => 3);
    
      --2.1 订单行
      INSERT INTO t_orders
        (orders_id,
         company_id,
         orders_code,
         order_id,
         goo_id,
         order_amount,
         got_amount,
         order_price,
         delivery_date,
         memo)
      VALUES
        (v_orders_id,
         v_company_id,
         v_orders_code,
         orders_rec.order_code,
         'A00' || to_char(v_rea_goo_id),
         2000,
         1050,
         2000,
         SYSDATE,
         '');
    
      --3.生产进度
      INSERT INTO t_production_progress
        (product_gress_id,
         company_id,
         product_gress_code,
         order_id,
         progress_status,
         goo_id,
         supplier_code,
         factory_code,
         forecast_delivery_date,
         forecast_delay_day,
         actual_delivery_date,
         actual_delay_day,
         latest_planned_delivery_date,
         order_amount,
         delivery_amount,
         approve_edition,
         fabric_check,
         qc_quality_check,
         exception_handle_status,
         handle_opinions,
         create_id,
         create_time,
         origin,
         memo,
         qc_check,
         qa_check)
      VALUES
        (scmdata.f_get_uuid(),
         v_company_id,
         orders_rec.order_code || '-' || 'A00' || to_char(v_rea_goo_id), --生产进度订单编号
         orders_rec.order_code,
         '未开始',
         'A00' || to_char(v_rea_goo_id),
         orders_rec.supplier_code,
         orders_rec.supplier_code,
         orders_rec.create_time,
         '',
         orders_rec.delivery_date,
         '',
         orders_rec.delivery_date,
         2000,
         1050,
         '未通过',
         '未通过',
         '',
         '处理中',
         '同意延期',
         'CZH',
         SYSDATE,
         '手动新增',
         '',
         '未检验',
         '未查货');
    
    END LOOP;
  
  END;

END;
