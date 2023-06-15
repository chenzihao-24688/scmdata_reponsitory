CREATE OR REPLACE PACKAGE MRP.pkg_color_prepare_order IS
  /**
  成品、物料供应商 色布备料单 基础程序包
  */
  --查询 COLOR_PREPARE_ORDER
  FUNCTION f_query_color_prepare_order(p_company_id     VARCHAR2,
                                       p_prepare_object INT,
                                       p_prepare_status INT) RETURN CLOB;

  --查询所有 COLOR_PREPARE_ORDER
  FUNCTION f_query_color_prepare_order_all(p_company_id     VARCHAR2,
                                           p_prepare_object INT) RETURN CLOB;

  --新增 COLOR_PREPARE_ORDER
  PROCEDURE p_insert_color_prepare_order(p_color_rec color_prepare_order%ROWTYPE);

  --修改 COLOR_PREPARE_ORDER
  PROCEDURE p_update_color_prepare_order(p_color_rec color_prepare_order%ROWTYPE);

  --取消备料单
  PROCEDURE p_update_color_prepare_order_status(p_prepare_order_id VARCHAR2,
                                                p_cancel_reason    VARCHAR2,
                                                p_user_id          VARCHAR2);

  --删除 COLOR_PREPARE_ORDER
  PROCEDURE p_delete_color_prepare_order(p_color_rec color_prepare_order%ROWTYPE);

  --校验 cancel_reason COLOR_PREPARE_ORDER
  PROCEDURE p_check_cancel_reason(p_cancel_reason VARCHAR2);

  --校验 prepare_status COLOR_PREPARE_ORDER
  PROCEDURE p_check_prepare_status(p_prepare_order_id VARCHAR2,
                                   p_prepare_status   INT);

  --校验 order_num COLOR_PREPARE_ORDER
  PROCEDURE p_check_order_num(p_prepare_order_id VARCHAR2,
                              p_order_num        VARCHAR2);

  --校验 expect_arrival_time COLOR_PREPARE_ORDER
  PROCEDURE p_check_expect_arrival_time(p_prepare_order_id    VARCHAR2,
                                        p_expect_arrival_time VARCHAR2);
END pkg_color_prepare_order;
/

CREATE OR REPLACE PACKAGE BODY MRP.pkg_color_prepare_order IS
  --查询 COLOR_PREPARE_ORDER
  FUNCTION f_query_color_prepare_order(p_company_id     VARCHAR2,
                                       p_prepare_object INT,
                                       p_prepare_status INT) RETURN CLOB IS
    v_sql CLOB;
  BEGIN
    v_sql := q'[
SELECT t.prepare_order_id, --色布备料单号
       t.prepare_status cr_prepare_status_n, --备料状态，0待审核，1待接单，2生产中，3已完成，4已取消
       (CASE
         WHEN t.prepare_status IN (1, 2, 4) THEN
          decode(sign(to_number(SYSDATE - t.expect_arrival_time)), -1, '否', '是')
         WHEN t.prepare_status = 3 THEN
          decode(sign(to_number(t.finish_time - t.expect_arrival_time)), -1, '否', '是')
         ELSE
          NULL
       END) cr_is_delay_n, --是否逾期
       --已完成 begin
       t.product_order_id, --色布生产单号
       --已完成 end
       --已取消 begin
       t.cancel_reason  cr_cancel_reason_n, --取消原因
       --已取消 end
       t.order_num cr_order_num_n, --订单数量
       --生产中/已完成 begin
       t.batch_finish_percent  cr_finish_rate_n, --完成率       
       t.batch_finish_num  cr_batch_finish_num_n, --完成数量
       --生产中/已完成 end
       tf.style_number cr_style_number_n, --款号
       tc.rela_goo_id cr_rela_goo_id_n, --货号
       t.goods_skc cr_goods_skc_n, --货色SKC
       tc.colorname cr_colorname_n, --颜色                 
       t.order_time cr_order_time_n, --下单日期
       t.expect_arrival_time cr_expect_arrival_time_n, --预计到仓日期
       round(t.expect_arrival_time - t.create_time, 1) cr_expect_arrival_days_n,  --预计到仓总耗天数
       --已完成 begin
       round(t.finish_time - t.create_time, 1)   cr_real_arrival_days_n, --实际到仓总消耗天数
       --已完成 end
       --生产中/已完成  begin
       t.receive_time  cr_receive_time_n, --接单时间
       ua.nick_name  cr_receive_id_n, --接单人
       --生产中/已完成  end
       --已完成 begin
       t.finish_time   cr_finish_time_n, --完成时间
       uc.nick_name   cr_finish_id_n, --完成人
       --已完成 end
       --已取消 begin
       t.cancel_time cr_cancel_time_n, --取消日期
       ub.nick_name  cr_cancel_id_n --取消人
       --已取消 end
  FROM ]' || (CASE
               WHEN p_prepare_object = 0 THEN
                'scmdata.t_supplier_info'
               WHEN p_prepare_object = 1 THEN
                'mrp.mrp_determine_supplier_archives'
               ELSE
                NULL
             END) || q'[ sp
 INNER JOIN mrp.color_prepare_order t
    ON ]' || (CASE
               WHEN p_prepare_object = 0 THEN
                't.pro_supplier_code = sp.supplier_info_id'
               WHEN p_prepare_object = 1 THEN
                't.mater_supplier_code = sp.supplier_code'
               ELSE
                NULL
             END) || q'[
   AND t.company_id = sp.company_id
   AND t.whether_del = 0
   AND t.prepare_status = ]' || p_prepare_status || q'[
   AND t.prepare_object = ]' || p_prepare_object || q'[
  LEFT JOIN scmdata.t_commodity_color tc
    ON tc.commodity_color_code = t.goods_skc
   AND tc.company_id = t.company_id
  LEFT JOIN scmdata.t_commodity_info tf
    ON tf.commodity_info_id = tc.commodity_info_id
   AND tf.company_id = tc.company_id
  LEFT JOIN scmdata.sys_user ua 
    ON ua.user_id  = t.receive_id
  LEFT JOIN scmdata.sys_user ub 
    ON ub.user_id  = t.cancel_id
  LEFT JOIN scmdata.sys_user uc 
    ON uc.user_id  = t.finish_id
 WHERE sp.company_id = ']' || p_company_id || q'[' 
   AND sp.supplier_company_id = %default_company_id%
   ]' || (CASE
               WHEN p_prepare_status = 2 THEN
                ' AND t.product_order_id = :product_order_id '
               ELSE
                ' AND t.group_key = :group_key '
             END) || q'[  
 ORDER BY t.order_time DESC
]';
    RETURN v_sql;
  END f_query_color_prepare_order;

  --查询所有 COLOR_PREPARE_ORDER
  FUNCTION f_query_color_prepare_order_all(p_company_id     VARCHAR2,
                                           p_prepare_object INT) RETURN CLOB IS
    v_sql CLOB;
  BEGIN
    v_sql := q'[
SELECT t.prepare_order_id, --色布备料单号
       tf.style_number cr_style_number_n, --款号
       t.material_name           cr_material_name_n, --物料名称       
       t.prepare_status cr_prepare_status_n, --备料状态，0待审核，1待接单，2生产中，3已完成，4已取消
       t.cancel_reason  cr_cancel_reason_n, --取消原因
       t.unit                    cr_unit_n, --单位  
       t.order_num cr_order_num_n, --订单数量       
       (CASE
         WHEN t.prepare_status IN (1, 2, 4) THEN
          decode(sign(to_number(SYSDATE - t.expect_arrival_time)), -1, '否', '是')
         WHEN t.prepare_status = 3 THEN
          decode(sign(to_number(t.finish_time - t.expect_arrival_time)), -1, '否', '是')
         ELSE
          NULL
       END) cr_is_delay_n, --是否逾期
       tc.rela_goo_id cr_rela_goo_id_n, --货号
       t.goods_skc cr_goods_skc_n, --货色SKC
       tc.colorname cr_dc_colorname_n, --档案颜色
       t.features                cr_features_n,
       t.supplier_color          cr_mt_color_n, --颜色  
       t.supplier_shades         cr_supplier_shades_n, --色号
       t.practical_door_with     cr_practical_door_with_n, --实用门幅
       t.gram_weight             cr_gram_weight_n, --克重
       t.material_specifications cr_material_specifications_n, --规格
       gd.group_dict_name        cr_applicable_category_n,--分类
       t.product_order_id, --色布生产单号
       t.material_sku            cr_material_sku_n, --物料sku
       t.order_time cr_order_time_n, --下单日期
       t.expect_arrival_time cr_expect_arrival_time_n, --预计到仓日期
       t.receive_time  cr_receive_time_n, --接单时间
       ua.nick_name   cr_receive_id_n, --接单人
       t.cancel_time cr_cancel_time_n, --取消日期
       ub.nick_name  cr_cancel_id_n, --取消人
       t.finish_time   cr_finish_time_n, --完成时间
       uc.nick_name   cr_finish_id_n --完成人
  FROM ]' || (CASE
               WHEN p_prepare_object = 0 THEN
                'scmdata.t_supplier_info'
               WHEN p_prepare_object = 1 THEN
                'mrp.mrp_determine_supplier_archives'
               ELSE
                NULL
             END) || q'[ sp
 INNER JOIN mrp.color_prepare_order t
    ON ]' || (CASE
               WHEN p_prepare_object = 0 THEN
                't.pro_supplier_code = sp.supplier_info_id'
               WHEN p_prepare_object = 1 THEN
                't.mater_supplier_code = sp.supplier_code'
               ELSE
                NULL
             END) || q'[
   AND t.company_id = sp.company_id
   AND t.whether_del = 0
   AND t.prepare_object = ]' || p_prepare_object || q'[
   AND t.prepare_status <> 0
  LEFT JOIN scmdata.t_commodity_color tc
    ON tc.commodity_color_code = t.goods_skc
   AND tc.company_id = t.company_id
  LEFT JOIN scmdata.t_commodity_info tf
    ON tf.commodity_info_id = tc.commodity_info_id
   AND tf.company_id = tc.company_id
  LEFT JOIN scmdata.sys_user ua 
    ON ua.user_id  = t.receive_id
  LEFT JOIN scmdata.sys_user ub 
    ON ub.user_id  = t.cancel_id
  LEFT JOIN scmdata.sys_user uc 
    ON uc.user_id  = t.finish_id
  LEFT JOIN scmdata.sys_group_dict gd 
    ON gd.group_dict_id = t.applicable_category
 WHERE sp.company_id = ']' || p_company_id || q'[' 
   AND sp.supplier_company_id = %default_company_id%
 ORDER BY t.order_time DESC
]';
    RETURN v_sql;
  END f_query_color_prepare_order_all;

  --新增 COLOR_PREPARE_ORDER
  PROCEDURE p_insert_color_prepare_order(p_color_rec color_prepare_order%ROWTYPE) IS
  BEGIN
    INSERT INTO color_prepare_order
      (prepare_order_id, prepare_status, prepare_object, prepare_type,
       goods_skc, material_sku, pro_supplier_code, mater_supplier_code,
       whether_inner_mater, material_name, material_color, unit,
       supplier_material_name, supplier_color, supplier_shades,
       practical_door_with, gram_weight, material_specifications, features,
       ingredients, supplier_large_good_quote, supplier_large_good_net_price,
       disparity, order_num, order_time, expect_arrival_time,
       expect_update_num, examine_id, examine_time, receive_id, receive_time,
       product_order_id, finish_id, finish_num, finish_time,
       batch_finish_num, batch_finish_percent, complete_num, cancel_id,
       cancel_time, cancel_reason, company_id, create_id, create_time,
       update_id, update_time, whether_del, group_key, develop_bom_id,
       develop_bom_change_id, relate_material_detail_id, applicable_category)
    VALUES
      (p_color_rec.prepare_order_id, p_color_rec.prepare_status,
       p_color_rec.prepare_object, p_color_rec.prepare_type,
       p_color_rec.goods_skc, p_color_rec.material_sku,
       p_color_rec.pro_supplier_code, p_color_rec.mater_supplier_code,
       p_color_rec.whether_inner_mater, p_color_rec.material_name,
       p_color_rec.material_color, p_color_rec.unit,
       p_color_rec.supplier_material_name, p_color_rec.supplier_color,
       p_color_rec.supplier_shades, p_color_rec.practical_door_with,
       p_color_rec.gram_weight, p_color_rec.material_specifications,
       p_color_rec.features, p_color_rec.ingredients,
       p_color_rec.supplier_large_good_quote,
       p_color_rec.supplier_large_good_net_price, p_color_rec.disparity,
       p_color_rec.order_num, p_color_rec.order_time,
       p_color_rec.expect_arrival_time, p_color_rec.expect_update_num,
       p_color_rec.examine_id, p_color_rec.examine_time,
       p_color_rec.receive_id, p_color_rec.receive_time,
       p_color_rec.product_order_id, p_color_rec.finish_id,
       p_color_rec.finish_num, p_color_rec.finish_time,
       p_color_rec.batch_finish_num, p_color_rec.batch_finish_percent,
       p_color_rec.complete_num, p_color_rec.cancel_id,
       p_color_rec.cancel_time, p_color_rec.cancel_reason,
       p_color_rec.company_id, p_color_rec.create_id,
       p_color_rec.create_time, p_color_rec.update_id,
       p_color_rec.update_time, p_color_rec.whether_del,
       p_color_rec.group_key, p_color_rec.develop_bom_id,
       p_color_rec.develop_bom_change_id,
       p_color_rec.relate_material_detail_id,
       p_color_rec.applicable_category);
  END p_insert_color_prepare_order;

  --修改 COLOR_PREPARE_ORDER
  PROCEDURE p_update_color_prepare_order(p_color_rec color_prepare_order%ROWTYPE) IS
  BEGIN
    UPDATE color_prepare_order t
       SET t.prepare_status                = p_color_rec.prepare_status, --备料状态，0待审核，1待接单，2生产中，3已完成，4已取消
           t.prepare_object                = p_color_rec.prepare_object, --备料对象  备料对象 成品供应商-0，物料供应商-1
           t.prepare_type                  = p_color_rec.prepare_type, --备料类型 按款备料-0 按料备料-1
           t.goods_skc                     = p_color_rec.goods_skc, --货色SKC
           t.material_sku                  = p_color_rec.material_sku, --物料SKU
           t.pro_supplier_code             = p_color_rec.pro_supplier_code, --成品供应商编号
           t.mater_supplier_code           = p_color_rec.mater_supplier_code, --物料供应商编号
           t.whether_inner_mater           = p_color_rec.whether_inner_mater, --是否内部物料，0否1是
           t.material_name                 = p_color_rec.material_name, --物料名称
           t.material_color                = p_color_rec.material_color, --物料颜色
           t.unit                          = p_color_rec.unit, --单位
           t.supplier_material_name        = p_color_rec.supplier_material_name, --供应商物料名称
           t.supplier_color                = p_color_rec.supplier_color, --供应商颜色
           t.supplier_shades               = p_color_rec.supplier_shades, --供应商色号
           t.practical_door_with           = p_color_rec.practical_door_with, --实用门幅
           t.gram_weight                   = p_color_rec.gram_weight, --克重
           t.material_specifications       = p_color_rec.material_specifications, --物料规格
           t.features                      = p_color_rec.features, --特征图，图片ID
           t.ingredients                   = p_color_rec.ingredients, --物料成份，成份值，页面无显示
           t.supplier_large_good_quote     = p_color_rec.supplier_large_good_quote, --供应商大货报价，页面无显示
           t.supplier_large_good_net_price = p_color_rec.supplier_large_good_net_price, --供应商大货净价，页面无显示
           t.disparity                     = p_color_rec.disparity, --空差，页面无显示
           t.order_num                     = p_color_rec.order_num, --订单数量
           t.order_time                    = p_color_rec.order_time, --下单日期
           t.expect_arrival_time           = p_color_rec.expect_arrival_time, --预计到仓日期
           t.expect_update_num             = p_color_rec.expect_update_num, --预计到仓日期修改次数
           t.examine_id                    = p_color_rec.examine_id, --审核人
           t.examine_time                  = p_color_rec.examine_time, --审核时间
           t.receive_id                    = p_color_rec.receive_id, --接单人
           t.receive_time                  = p_color_rec.receive_time, --接单日期
           t.product_order_id              = p_color_rec.product_order_id, --色布生产单号
           t.finish_id                     = p_color_rec.finish_id, --完成人
           t.finish_num                    = p_color_rec.finish_num, --完成数量
           t.finish_time                   = p_color_rec.finish_time, --完成日期
           t.batch_finish_num              = p_color_rec.batch_finish_num, --分批完成累计数量
           t.batch_finish_percent          = p_color_rec.batch_finish_percent, --分批完成累计百分比
           t.complete_num                  = p_color_rec.complete_num, --待完成数量
           t.cancel_id                     = p_color_rec.cancel_id, --取消人
           t.cancel_time                   = p_color_rec.cancel_time, --取消日期
           t.cancel_reason                 = p_color_rec.cancel_reason, --取消原因
           t.company_id                    = p_color_rec.company_id, --企业编码
           t.create_id                     = p_color_rec.create_id, --创建者
           t.create_time                   = p_color_rec.create_time, --创建时间
           t.update_id                     = p_color_rec.update_id, --更新者
           t.update_time                   = p_color_rec.update_time, --更新时间
           t.whether_del                   = p_color_rec.whether_del, --是否删除，0否1是
           t.group_key                     = p_color_rec.group_key, --分组依据          
           t.develop_bom_id                = p_color_rec.develop_bom_id, --开发BOMID
           t.develop_bom_change_id         = p_color_rec.develop_bom_change_id, --开发BOM变更号
           t.relate_material_detail_id     = p_color_rec.relate_material_detail_id, --关联开发BOM物料明细
           t.applicable_category           = p_color_rec.applicable_category --适用品类
     WHERE t.prepare_order_id = p_color_rec.prepare_order_id;
  END p_update_color_prepare_order;

  --取消备料单
  PROCEDURE p_update_color_prepare_order_status(p_prepare_order_id VARCHAR2,
                                                p_cancel_reason    VARCHAR2,
                                                p_user_id          VARCHAR2) IS
  BEGIN
    UPDATE mrp.color_prepare_order t
       SET t.prepare_status = 4,
           t.cancel_reason  = p_cancel_reason,
           t.cancel_id      = p_user_id,
           t.cancel_time    = SYSDATE
     WHERE t.prepare_order_id = p_prepare_order_id;
  END p_update_color_prepare_order_status;

  --删除 COLOR_PREPARE_ORDER
  PROCEDURE p_delete_color_prepare_order(p_color_rec color_prepare_order%ROWTYPE) IS
  BEGIN
    DELETE FROM color_prepare_order t
     WHERE t.prepare_order_id = p_color_rec.prepare_order_id;
  END p_delete_color_prepare_order;

  --校验 cancel_reason COLOR_PREPARE_ORDER
  PROCEDURE p_check_cancel_reason(p_cancel_reason VARCHAR2) IS
    v_str_desc VARCHAR2(256) := '取消原因';
  BEGIN
    --校验是否为空
    mrp.pkg_check_data_comm.p_check_str_is_null(p_str      => p_cancel_reason,
                                                p_str_desc => v_str_desc);
    --校验字符长度                                           
    mrp.pkg_check_data_comm.p_check_str_length(p_str      => p_cancel_reason,
                                               p_str_desc => v_str_desc,
                                               p_length   => 200);
  END p_check_cancel_reason;

  --校验 prepare_status COLOR_PREPARE_ORDER
  PROCEDURE p_check_prepare_status(p_prepare_order_id VARCHAR2,
                                   p_prepare_status   INT) IS
    v_prepare_status INT;
  BEGIN
    SELECT nvl(MAX(t.prepare_status), -1)
      INTO v_prepare_status
      FROM mrp.color_prepare_order t
     WHERE t.prepare_order_id = p_prepare_order_id;
  
    IF mrp.pkg_plat_comm.f_is_check_fields_eq(v_prepare_status,
                                              p_prepare_status) = 0 THEN
      raise_application_error(-20002,
                              '只可对【' ||
                              (CASE WHEN p_prepare_status = 1 THEN '待接单' WHEN
                               p_prepare_status = 2 THEN '生产中' ELSE NULL END) ||
                              '】状态的备料单进行操作，请刷新页面重试！');
    END IF;
  END p_check_prepare_status;

  --校验 order_num COLOR_PREPARE_ORDER
  PROCEDURE p_check_order_num(p_prepare_order_id VARCHAR2,
                              p_order_num        VARCHAR2) IS
    v_order_num_old VARCHAR2(13);
    v_str_desc      VARCHAR2(32) := '订单数量';
  BEGIN
    --校验是否为空
    mrp.pkg_check_data_comm.p_check_str_is_null(p_str      => p_order_num,
                                                p_str_desc => v_str_desc);
  
    --校验数字
    mrp.pkg_check_data_comm.p_check_number(p_num         => p_order_num,
                                           p_integer_num => 9,
                                           p_decimal_num => 2,
                                           p_desc        => v_str_desc);
  
    SELECT to_char(MAX(t.order_num), 'fm999999990.00')
      INTO v_order_num_old
      FROM mrp.color_prepare_order t
     WHERE t.prepare_order_id = p_prepare_order_id;
  
    --校验新旧值是否相等
    IF mrp.pkg_plat_comm.f_is_check_fields_eq(p_old_field => v_order_num_old,
                                              p_new_field => p_order_num) = 1 THEN
      raise_application_error(-20002, '修改数量与原数量一致，无需修改！');
    END IF;
  END p_check_order_num;

  --校验 expect_arrival_time COLOR_PREPARE_ORDER
  PROCEDURE p_check_expect_arrival_time(p_prepare_order_id    VARCHAR2,
                                        p_expect_arrival_time VARCHAR2) IS
    v_expect_arrival_time_old VARCHAR2(32);
    v_order_time              DATE;
  BEGIN
    --校验是否为空
    mrp.pkg_check_data_comm.p_check_str_is_null(p_str      => p_expect_arrival_time,
                                                p_str_desc => '预计到仓日期');
  
    SELECT to_char(MAX(t.expect_arrival_time), 'yyyy-mm-dd'),
           trunc(MAX(t.order_time))
      INTO v_expect_arrival_time_old, v_order_time
      FROM mrp.color_prepare_order t
     WHERE t.prepare_order_id = p_prepare_order_id;
  
    IF mrp.pkg_plat_comm.f_is_check_fields_eq(p_old_field => v_expect_arrival_time_old,
                                              p_new_field => p_expect_arrival_time) = 1 THEN
      raise_application_error(-20002, '请修改预计到仓日期！');
    END IF;
  
    IF to_date(p_expect_arrival_time,'yyyy-mm-dd') <= v_order_time THEN
      raise_application_error(-20002, '预计到仓日期不能早于下单日期！');
    END IF;
  END p_check_expect_arrival_time;

END pkg_color_prepare_order;
/

