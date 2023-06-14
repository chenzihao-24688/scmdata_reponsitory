CREATE OR REPLACE PACKAGE mrp.pkg_color_prepare_product_order IS
  -- Author  : CZH55
  -- Created : 2023/4/25 17:39:55
  -- Purpose : 成品、物料供应商色布/坯布备料生产单-基础程序包

  --查询 COLOR_PREPARE_PRODUCT_ORDER
  FUNCTION f_query_color_prepare_product_order RETURN CLOB;

  --新增 COLOR_PREPARE_PRODUCT_ORDER
  PROCEDURE p_insert_color_prepare_product_order(p_color_rec color_prepare_product_order%ROWTYPE);

  --修改 COLOR_PREPARE_PRODUCT_ORDER
  PROCEDURE p_update_color_prepare_product_order(p_color_rec color_prepare_product_order%ROWTYPE);

  --删除 通过ID COLOR_PREPARE_PRODUCT_ORDER
  PROCEDURE p_delete_color_prepare_product_order_by_id(p_product_order_id VARCHAR2);

  --校验 product_status  COLOR_PREPARE_PRODUCT_ORDER
  PROCEDURE p_check_product_status(p_product_order_id VARCHAR2,
                                   p_product_status   INT);

  --校验 cur_finished_num  COLOR_PREPARE_PRODUCT_ORDER
  PROCEDURE p_check_cur_finished_num(p_cur_finished_num VARCHAR2);

  --校验 is_finished_preorder  COLOR_PREPARE_PRODUCT_ORDER
  PROCEDURE p_check_is_finished_preorder(p_is_finished_preorder NUMBER);

  --溢短装：±3% 校验
  PROCEDURE p_check_more_less_clause(p_cur_finished_num     NUMBER,
                                     p_finished_num         NUMBER,
                                     p_order_num            NUMBER,
                                     p_rate                 NUMBER,
                                     p_is_finished_preorder NUMBER);

END pkg_color_prepare_product_order;
/
CREATE OR REPLACE PACKAGE BODY mrp.pkg_color_prepare_product_order IS
  --查询 COLOR_PREPARE_PRODUCT_ORDER
  FUNCTION f_query_color_prepare_product_order RETURN CLOB IS
    v_sql CLOB;
  BEGIN
    v_sql := '
SELECT t.product_order_id, --色布生产单号
       t.product_status, --生产单状态，1生产中，2已完成，3已取消
       t.prepare_object, --备料对象
       t.material_sku, --物料SKU
       t.pro_supplier_code, --成品供应商编号
       t.mater_supplier_code, --物料供应商编号
       t.whether_inner_mater, --是否内部物料，0否1是
       t.material_name, --物料名称
       t.material_color, --物料颜色
       t.unit, --单位
       t.supplier_material_name, --供应商物料名称
       t.supplier_color, --供应商颜色
       t.supplier_shades, --供应商色号
       t.practical_door_with, --实用门幅
       t.gram_weight, --克重
       t.material_specifications, --物料规格
       t.features, --特征图，图片ID，第一张
       t.ingredients, --物料成份，成份ID，页面无显示
       t.plan_product_quantity, --计划生产数量
       t.contain_color_prepare_num, --含色布备料单数
       t.actual_finish_num, --实际完成数量
       t.receive_id, --接单人
       t.receive_time, --接单日期
       t.finish_id, --总完成人
       t.finish_num, --总完成数量
       t.finish_time, --总完成日期
       t.batch_finish_num, --分批完成累计数量
       t.batch_finish_percent, --分批完成累计百分比
       t.complete_num, --待完成数量
       t.relate_skc, --关联SKC
       t.cancel_id, --取消人
       t.cancel_time, --取消日期
       t.cancel_reason, --取消原因
       t.company_id, --企业编码
       t.create_id, --创建者
       t.create_time, --创建时间
       t.update_id, --更新者
       t.update_time, --更新时间
       t.whether_del --是否删除，0否1是
  FROM color_prepare_product_order t
 WHERE 1 = 1';
    RETURN v_sql;
  END f_query_color_prepare_product_order;

  --新增 COLOR_PREPARE_PRODUCT_ORDER
  PROCEDURE p_insert_color_prepare_product_order(p_color_rec color_prepare_product_order%ROWTYPE) IS
  BEGIN
  
    INSERT INTO color_prepare_product_order
      (product_order_id, product_status, prepare_object, material_sku,
       pro_supplier_code, mater_supplier_code, whether_inner_mater,
       material_name, material_color, unit, supplier_material_name,
       supplier_color, supplier_shades, practical_door_with, gram_weight,
       material_specifications, features, ingredients, plan_product_quantity,
       contain_color_prepare_num, actual_finish_num, receive_id,
       receive_time, finish_id, finish_num, finish_time, batch_finish_num,
       batch_finish_percent, complete_num, relate_skc, cancel_id,
       cancel_time, cancel_reason, company_id, create_id, create_time,
       update_id, update_time, whether_del)
    VALUES
      (p_color_rec.product_order_id, p_color_rec.product_status,
       p_color_rec.prepare_object, p_color_rec.material_sku,
       p_color_rec.pro_supplier_code, p_color_rec.mater_supplier_code,
       p_color_rec.whether_inner_mater, p_color_rec.material_name,
       p_color_rec.material_color, p_color_rec.unit,
       p_color_rec.supplier_material_name, p_color_rec.supplier_color,
       p_color_rec.supplier_shades, p_color_rec.practical_door_with,
       p_color_rec.gram_weight, p_color_rec.material_specifications,
       p_color_rec.features, p_color_rec.ingredients,
       p_color_rec.plan_product_quantity,
       p_color_rec.contain_color_prepare_num, p_color_rec.actual_finish_num,
       p_color_rec.receive_id, p_color_rec.receive_time,
       p_color_rec.finish_id, p_color_rec.finish_num,
       p_color_rec.finish_time, p_color_rec.batch_finish_num,
       p_color_rec.batch_finish_percent, p_color_rec.complete_num,
       p_color_rec.relate_skc, p_color_rec.cancel_id,
       p_color_rec.cancel_time, p_color_rec.cancel_reason,
       p_color_rec.company_id, p_color_rec.create_id,
       p_color_rec.create_time, p_color_rec.update_id,
       p_color_rec.update_time, p_color_rec.whether_del);
  END p_insert_color_prepare_product_order;

  --修改 COLOR_PREPARE_PRODUCT_ORDER
  PROCEDURE p_update_color_prepare_product_order(p_color_rec color_prepare_product_order%ROWTYPE) IS
  BEGIN
  
    UPDATE color_prepare_product_order t
       SET t.product_status            = p_color_rec.product_status, --生产单状态，1生产中，2已完成，3已取消
           t.prepare_object            = p_color_rec.prepare_object, --备料对象
           t.material_sku              = p_color_rec.material_sku, --物料SKU
           t.pro_supplier_code         = p_color_rec.pro_supplier_code, --成品供应商编号
           t.mater_supplier_code       = p_color_rec.mater_supplier_code, --物料供应商编号
           t.whether_inner_mater       = p_color_rec.whether_inner_mater, --是否内部物料，0否1是
           t.material_name             = p_color_rec.material_name, --物料名称
           t.material_color            = p_color_rec.material_color, --物料颜色
           t.unit                      = p_color_rec.unit, --单位
           t.supplier_material_name    = p_color_rec.supplier_material_name, --供应商物料名称
           t.supplier_color            = p_color_rec.supplier_color, --供应商颜色
           t.supplier_shades           = p_color_rec.supplier_shades, --供应商色号
           t.practical_door_with       = p_color_rec.practical_door_with, --实用门幅
           t.gram_weight               = p_color_rec.gram_weight, --克重
           t.material_specifications   = p_color_rec.material_specifications, --物料规格
           t.features                  = p_color_rec.features, --特征图，图片ID，第一张
           t.ingredients               = p_color_rec.ingredients, --物料成份，成份ID，页面无显示
           t.plan_product_quantity     = p_color_rec.plan_product_quantity, --计划生产数量
           t.contain_color_prepare_num = p_color_rec.contain_color_prepare_num, --含色布备料单数
           t.actual_finish_num         = p_color_rec.actual_finish_num, --实际完成数量
           t.receive_id                = p_color_rec.receive_id, --接单人
           t.receive_time              = p_color_rec.receive_time, --接单日期
           t.finish_id                 = p_color_rec.finish_id, --总完成人
           t.finish_num                = p_color_rec.finish_num, --总完成数量
           t.finish_time               = p_color_rec.finish_time, --总完成日期
           t.batch_finish_num          = p_color_rec.batch_finish_num, --分批完成累计数量
           t.batch_finish_percent      = p_color_rec.batch_finish_percent, --分批完成累计百分比
           t.complete_num              = p_color_rec.complete_num, --待完成数量
           t.relate_skc                = p_color_rec.relate_skc, --关联SKC
           t.cancel_id                 = p_color_rec.cancel_id, --取消人
           t.cancel_time               = p_color_rec.cancel_time, --取消日期
           t.cancel_reason             = p_color_rec.cancel_reason, --取消原因
           t.company_id                = p_color_rec.company_id, --企业编码
           t.create_id                 = p_color_rec.create_id, --创建者
           t.create_time               = p_color_rec.create_time, --创建时间
           t.update_id                 = p_color_rec.update_id, --更新者
           t.update_time               = p_color_rec.update_time, --更新时间
           t.whether_del               = p_color_rec.whether_del --是否删除，0否1是
     WHERE t.product_order_id = p_color_rec.product_order_id;
  END p_update_color_prepare_product_order;

  --删除 通过ID COLOR_PREPARE_PRODUCT_ORDER
  PROCEDURE p_delete_color_prepare_product_order_by_id(p_product_order_id VARCHAR2) IS
    v_product_order_id VARCHAR2(32) := p_product_order_id;
  BEGIN
    DELETE FROM color_prepare_product_order t
     WHERE t.product_order_id = v_product_order_id;
  END p_delete_color_prepare_product_order_by_id;

  --校验 product_status  COLOR_PREPARE_PRODUCT_ORDER
  PROCEDURE p_check_product_status(p_product_order_id VARCHAR2,
                                   p_product_status   INT) IS
    v_product_status INT;
  BEGIN
    SELECT nvl(MAX(t.product_status), -1)
      INTO v_product_status
      FROM mrp.color_prepare_product_order t
     WHERE t.product_order_id = p_product_order_id;
  
    IF v_product_status <> p_product_status THEN
      raise_application_error(-20002,
                              '只可对【' ||
                              (CASE WHEN p_product_status = 1 THEN '生产中' ELSE NULL END) ||
                              '】状态的订单进行操作，请检查！');
    END IF;
  END p_check_product_status;

  --校验 cur_finished_num  COLOR_PREPARE_PRODUCT_ORDER
  PROCEDURE p_check_cur_finished_num(p_cur_finished_num VARCHAR2) IS
  BEGIN
    --校验是否为空
    mrp.pkg_check_data_comm.p_check_str_is_null(p_str      => p_cur_finished_num,
                                                p_str_desc => '本次完成数量');
    --正则表达式校验
    mrp.pkg_check_data_comm.p_check_number(p_num         => p_cur_finished_num,
                                           p_integer_num => 9,
                                           p_decimal_num => 2,
                                           p_desc        => '本次完成数量');
  
  END p_check_cur_finished_num;

  --校验 is_finished_preorder  COLOR_PREPARE_PRODUCT_ORDER
  PROCEDURE p_check_is_finished_preorder(p_is_finished_preorder NUMBER) IS
  BEGIN
    --校验是否为空
    mrp.pkg_check_data_comm.p_check_str_is_null(p_str      => p_is_finished_preorder,
                                                p_str_desc => '是否完成备料单');
  END p_check_is_finished_preorder;

  --溢短装：±3% 校验
  PROCEDURE p_check_more_less_clause(p_cur_finished_num     NUMBER,
                                     p_finished_num         NUMBER,
                                     p_order_num            NUMBER,
                                     p_rate                 NUMBER,
                                     p_is_finished_preorder NUMBER) IS
  
  BEGIN
    --当【完成数量】+ 【已完成数量】≥ 【订单量】*（1-3%），【是否完成备料单】选中“否”，报错：【完成数量】+ 【已完成数量】≥ 【订单量】*（1-3%）时，【是否完成备料单】不可为“否”
    IF (p_cur_finished_num + p_finished_num) - p_order_num * (1 - p_rate) >= 0 AND
       p_is_finished_preorder = 0 THEN
      raise_application_error(-20002, 
                              '【完成数量】+ 【已完成数量】≥ 【订单量】*（1-3%）时，【是否完成备料单】不可为“否”');
    END IF;
  
    --【完成数量】+ 【已完成数量】＞ 【订单量】*（1+3%），报错：【总完成数量】不可超过【溢短装】要求
    IF (p_cur_finished_num + p_finished_num) - p_order_num * (1 + p_rate) > 0 THEN
      raise_application_error(-20002, '【总完成数量】不可超过【溢短装】要求');
    END IF;
  END p_check_more_less_clause;

END pkg_color_prepare_product_order;
/
