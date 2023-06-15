CREATE OR REPLACE PACKAGE MRP.pkg_color_prepare_order_manager IS

  -- Author  : CZH55
  -- Created : 2023/4/25 17:39:55
  -- Purpose : 成品、物料供应商色布备料单管理-业务程序包

  --色布备料单 主表查询  
  FUNCTION f_query_color_prepare_order_header(p_company_id     VARCHAR2,
                                              p_prepare_object INT,
                                              p_prepare_status INT)
    RETURN CLOB;

  --色布备料生产单 主表查询  
  FUNCTION f_query_color_prepare_product_order_header(p_company_id     VARCHAR2,
                                                      p_prepare_object INT)
    RETURN CLOB;

  --主表 更新色布备料单
  --关联生产单
  PROCEDURE p_generate_color_prepare_order(p_group_key        VARCHAR2,
                                           p_product_order_id VARCHAR2,
                                           p_company_id       VARCHAR2,
                                           p_user_id          VARCHAR2);

  --从表 更新色布备料单
  --关联生产单
  PROCEDURE p_generate_color_prepare_order_sub(p_cpo_rec          mrp.color_prepare_order%ROWTYPE,
                                               p_user_id          VARCHAR2,
                                               p_product_order_id VARCHAR2);
  --生成色布备料生产单
  PROCEDURE p_generate_color_prepare_product_order(p_cpo_rec          mrp.color_prepare_order%ROWTYPE,
                                                   p_product_order_id VARCHAR2,
                                                   p_order_num        NUMBER,
                                                   p_order_cnt        NUMBER,
                                                   p_relate_skc       VARCHAR2,
                                                   p_company_id       VARCHAR2,
                                                   p_user_id          VARCHAR2);
  --主表 接单按钮
  PROCEDURE p_receive_orders(p_company_id VARCHAR2,
                             p_user_id    VARCHAR2,
                             p_cpo_rec    mrp.color_prepare_order%ROWTYPE);

  --从表 接单按钮
  PROCEDURE p_receive_orders_sub(p_company_id VARCHAR2,
                                 p_user_id    VARCHAR2,
                                 p_cpop_id    VARCHAR2,
                                 p_cpo_rec    mrp.color_prepare_order%ROWTYPE,
                                 p_order_num  NUMBER,
                                 p_order_cnt  NUMBER,
                                 p_relate_skc VARCHAR2);

  --成品供应商 坯布转色布
  PROCEDURE p_fabric_gray_convert_color(p_cpop_rec mrp.color_prepare_product_order%ROWTYPE,
                                        p_user_id  VARCHAR2);
  --物料供应商 坯布转色布
  PROCEDURE p_material_fabric_gray_convert_color(p_cpop_rec mrp.color_prepare_product_order%ROWTYPE,
                                                 p_user_id  VARCHAR2);

  --获取物料spu
  FUNCTION f_get_material_spu(p_material_sku      VARCHAR2,
                              p_sup_code          VARCHAR2 DEFAULT NULL,
                              p_is_inner_material INT) RETURN VARCHAR2;

  --获取物料供应商 物料spu
  FUNCTION f_get_mt_material_spu(p_material_sku VARCHAR2) RETURN VARCHAR2;

  --获取品牌仓、供应商仓数
  --1 品牌仓
  --2 供应商仓
  FUNCTION f_get_brand_stock(p_company_id          VARCHAR2,
                             p_prepare_object      INT,
                             p_pro_supplier_code   VARCHAR2 DEFAULT NULL,
                             p_mater_supplier_code VARCHAR2,
                             p_unit                VARCHAR2,
                             p_material_spu        VARCHAR2,
                             p_store_type          INT) RETURN NUMBER;

  --获取品牌仓、供应商仓数  DYY
  FUNCTION f_get_stock_num(p_company_id          VARCHAR2,
                           p_sup_mode            INT, --0 成品 1 物料
                           p_type                VARCHAR2, --sku/spu
                           p_pro_supplier_code   VARCHAR2 DEFAULT NULL,
                           p_mater_supplier_code VARCHAR2,
                           p_unit                VARCHAR2,
                           p_material_id         VARCHAR2,
                           p_store_type          INT --1 品牌仓 2 供应商仓
                           ) RETURN NUMBER;

  --获成品供应商 取染损率
  FUNCTION f_get_dye_loss_late(p_pro_supplier_code   VARCHAR2 DEFAULT NULL,
                               p_mater_supplier_code VARCHAR2,
                               p_material_sku        VARCHAR2,
                               p_is_inner_material   INT) RETURN NUMBER;

  --物料供应商 获取染损率
  FUNCTION f_get_mt_dye_loss_late(p_mater_supplier_code VARCHAR2,
                                  p_material_sku        VARCHAR2)
    RETURN NUMBER;

  --校验“品牌仓/供应商仓 坯布库存”转化为色布是否够用
  PROCEDURE p_check_color_fabric_is_enough(p_brand_stock      NUMBER,
                                           p_plan_product_num NUMBER,
                                           p_sup_store_num    NUMBER DEFAULT 0,
                                           p_dye_loss_late    NUMBER,
                                           p_store_type       INT,
                                           po_is_enough_flag  OUT INT,
                                           po_num             OUT NUMBER);

  --据备料对象（成品、物料供应商）生成【供应商库存-坯布出入库单表】信息
  PROCEDURE p_generate_brand_inout_bound_by_pro(p_cpop_rec     mrp.color_prepare_product_order%ROWTYPE,
                                                p_store_type   INT,
                                                p_material_spu VARCHAR2,
                                                p_num          NUMBER,
                                                p_user_id      VARCHAR2,
                                                po_bound_num   OUT VARCHAR2);

  --物料供应商生成【供应商库存-坯布出入库单表】信息
  PROCEDURE p_generate_brand_inout_bound_by_mt(p_cpop_rec     mrp.color_prepare_product_order%ROWTYPE,
                                               p_store_type   INT,
                                               p_material_spu VARCHAR2,
                                               p_num          NUMBER,
                                               p_user_id      VARCHAR2,
                                               po_bound_num   OUT VARCHAR2);
  --品牌仓-生成坯布出入库单
  PROCEDURE p_generate_brand_inout_bound(p_cpop_rec     mrp.color_prepare_product_order%ROWTYPE,
                                         p_store_type   INT,
                                         p_material_spu VARCHAR2,
                                         p_num          NUMBER,
                                         p_user_id      VARCHAR2,
                                         po_bound_num   OUT VARCHAR2);

  --成品供应商 供应商仓-生成坯布出入库单
  PROCEDURE p_generate_sup_brand_inout_bound_by_pro(p_cpop_rec     mrp.color_prepare_product_order%ROWTYPE,
                                                    p_store_type   INT,
                                                    p_material_spu VARCHAR2,
                                                    p_sup_num      NUMBER,
                                                    p_user_id      VARCHAR2);

  --物料供应商 供应商仓-生成坯布出入库单
  PROCEDURE p_generate_sup_brand_inout_bound_by_mt(p_cpop_rec     mrp.color_prepare_product_order%ROWTYPE,
                                                   p_store_type   INT,
                                                   p_material_spu VARCHAR2,
                                                   p_sup_num      NUMBER,
                                                   p_user_id      VARCHAR2);
  --供应商仓-生成坯布出入库单
  PROCEDURE p_generate_sup_brand_inout_bound(p_cpop_rec      mrp.color_prepare_product_order%ROWTYPE,
                                             p_store_type    INT,
                                             p_material_spu  VARCHAR2,
                                             p_brand_stock   NUMBER,
                                             p_dye_loss_late NUMBER,
                                             p_user_id       VARCHAR2);

  --更新【供应商库存-坯布仓库存明细】相应数据
  PROCEDURE p_generate_grey_stock(p_sgiob_rec   mrp.supplier_grey_in_out_bound%ROWTYPE,
                                  p_inout_stock NUMBER,
                                  p_user_id     VARCHAR2);

  --物料供应商 更新【供应商库存-坯布仓库存明细】相应数据
  PROCEDURE p_generate_material_grey_stock(p_mgiob_rec   mrp.material_grey_in_out_bound%ROWTYPE,
                                           p_inout_stock NUMBER,
                                           p_user_id     VARCHAR2);

  --取消备料单
  PROCEDURE p_cancle_color_prepare_order(p_prepare_order_id   VARCHAR2,
                                         p_cancel_reason      VARCHAR2,
                                         p_company_id         VARCHAR2,
                                         p_operate_company_id VARCHAR2,
                                         p_user_id            VARCHAR2);

  --修改订单数量
  PROCEDURE p_update_order_num(p_prepare_order_id   VARCHAR2,
                               p_order_num          VARCHAR2,
                               p_company_id         VARCHAR2,
                               p_operate_company_id VARCHAR2,
                               p_user_id            VARCHAR2);

  --修改预计到仓日期
  PROCEDURE p_update_expect_arrival_time(p_prepare_order_id    VARCHAR2,
                                         p_prepare_status      INT,
                                         p_expect_arrival_time DATE,
                                         p_company_id          VARCHAR2,
                                         p_operate_company_id  VARCHAR2,
                                         p_user_id             VARCHAR2);

  --生产单 取消订单
  PROCEDURE p_cancel_product_order(p_product_order_id   VARCHAR2,
                                   p_cancel_reason      VARCHAR2,
                                   p_company_id         VARCHAR2,
                                   p_operate_company_id VARCHAR2,
                                   p_user_id            VARCHAR2);

  --完成订单
  PROCEDURE p_finish_product_order(p_product_order_id     VARCHAR2,
                                   p_cur_finished_num     VARCHAR2,
                                   p_is_finished_preorder NUMBER,
                                   p_company_id           VARCHAR2,
                                   p_operate_company_id   VARCHAR2,
                                   p_user_id              VARCHAR2);

  --成品供应商 色布入库
  PROCEDURE p_color_cloth_storage(p_cppo_rec   mrp.color_prepare_product_order%ROWTYPE,
                                  p_company_id VARCHAR2,
                                  p_user_id    VARCHAR2,
                                  p_batch_num  NUMBER,
                                  po_bound_num OUT VARCHAR2);

  --物料供应商 色布入库
  PROCEDURE p_material_color_cloth_storage(p_cppo_rec   mrp.color_prepare_product_order%ROWTYPE,
                                           p_company_id VARCHAR2,
                                           p_user_id    VARCHAR2,
                                           p_batch_num  NUMBER,
                                           po_bound_num OUT VARCHAR2);

  --是否找到色布库存
  --区分备料对象 
  --p_prepare_object：0 成品供应商 1 物料供应商
  FUNCTION f_is_find_color_stock(p_pro_supplier_code   VARCHAR2 DEFAULT NULL,
                                 p_mater_supplier_code VARCHAR2,
                                 p_material_sku        VARCHAR2,
                                 p_unit                VARCHAR2,
                                 p_prepare_object      INT) RETURN NUMBER;

  --成品供应商 色布仓库存
  PROCEDURE p_sync_supplier_color_cloth_stock(p_sciob_rec  mrp.supplier_color_in_out_bound%ROWTYPE,
                                              p_company_id VARCHAR2,
                                              p_user_id    VARCHAR2);

  --物料供应商 色布仓库存
  PROCEDURE p_sync_material_color_cloth_stock(p_mciob_rec  mrp.material_color_in_out_bound%ROWTYPE,
                                              p_company_id VARCHAR2,
                                              p_user_id    VARCHAR2);

  --备料进度查询  
  FUNCTION f_query_prepare_order_process(p_order_num VARCHAR2) RETURN CLOB;

  --备料状态同步至生产进度表
  PROCEDURE p_sync_prepare_status(p_order_num  VARCHAR2,
                                  p_company_id VARCHAR2);

END pkg_color_prepare_order_manager;
/

CREATE OR REPLACE PACKAGE BODY MRP.pkg_color_prepare_order_manager IS

  --色布备料单 主表查询  
  FUNCTION f_query_color_prepare_order_header(p_company_id     VARCHAR2,
                                              p_prepare_object INT,
                                              p_prepare_status INT)
    RETURN CLOB IS
    v_sql CLOB;
  BEGIN
    v_sql := q'[
SELECT va.group_key,
       va.material_name           cr_material_name_n, --物料名称
       va.is_delay                cr_is_delay_n, --是否逾期
       mp.file_unique             cr_features_n,
       va.supplier_color          cr_supplier_color_n, --颜色   
       va.supplier_shades         cr_supplier_shades_n, --色号
       va.unit                    cr_unit_n, --单位   
       va.order_cnt               cr_order_cnt_n, --订单数
       va.order_num               cr_order_num_n, --订单数量
       ]' || (CASE
               WHEN p_prepare_status IN (3) THEN
                ' va.finish_num cr_finish_num_n, --已完成数量
                  va.finish_num/va.order_num cr_finish_rate_n, --完成率'
               ELSE
                NULL
             END) || q'[
       va.practical_door_with     cr_practical_door_with_n, --实用门幅
       va.gram_weight             cr_gram_weight_n, --克重
       va.material_specifications cr_material_specifications_n, --规格    
       va.material_sku            cr_material_sku_n --物料sku
  FROM ]' || (CASE
               WHEN p_prepare_object = 0 THEN
                'scmdata.t_supplier_info'
               WHEN p_prepare_object = 1 THEN
                'mrp.mrp_determine_supplier_archives'
               ELSE
                NULL
             END) || q'[ sp
 INNER JOIN mrp.v_color_prepare_order va
    ON ]' || (CASE
               WHEN p_prepare_object = 0 THEN
                'va.pro_supplier_code = sp.supplier_info_id'
               WHEN p_prepare_object = 1 THEN
                'va.mater_supplier_code = sp.supplier_code'
               ELSE
                NULL
             END) || q'[
   AND va.company_id = sp.company_id
   AND va.prepare_status = ]' || p_prepare_status || q'[
   AND va.prepare_object = ]' || p_prepare_object || q'[
 LEFT JOIN mrp.mrp_picture mp 
  ON to_char(mp.picture_id) = va.features
 WHERE sp.company_id = ']' || p_company_id || q'[' 
   AND sp.supplier_company_id = %default_company_id%
 ORDER BY va.order_time DESC
]';
    RETURN v_sql;
  END f_query_color_prepare_order_header;

  --色布备料生产单 主表查询  
  FUNCTION f_query_color_prepare_product_order_header(p_company_id     VARCHAR2,
                                                      p_prepare_object INT)
    RETURN CLOB IS
    v_sql CLOB;
  BEGIN
    v_sql := q'[SELECT t.product_order_id, --色布生产单号
       t.supplier_material_name cr_material_name_n, --供应商物料名称
       decode(sign(to_number(SYSDATE - va.min_expect_arrival_time)),
              1,
              '是',
              '否') cr_is_delay_n, --是否逾期 待做
       mp.file_unique cr_features_n, --特征图，图片ID，第一张
       t.supplier_color cr_supplier_color_n, --供应商颜色
       t.supplier_shades cr_supplier_shades_n, --供应商色号
       t.unit cr_unit_n, --单位
       t.contain_color_prepare_num cr_order_cnt_n, --含色布备料单数
       t.plan_product_quantity cr_order_num_n, --计划生产数量
       t.batch_finish_num cr_finish_num_n, --已完成数量
       t.batch_finish_percent cr_finish_rate_n, --完成率
       t.practical_door_with cr_practical_door_with_n, --实用门幅
       t.gram_weight cr_gram_weight_n, --克重
       t.material_specifications cr_material_specifications_n, --物料规格  
       t.material_sku cr_material_sku_n --物料SKU
  FROM ]' || (CASE
               WHEN p_prepare_object = 0 THEN
                'scmdata.t_supplier_info'
               WHEN p_prepare_object = 1 THEN
                'mrp.mrp_determine_supplier_archives'
               ELSE
                NULL
             END) || q'[ sp
 INNER JOIN mrp.color_prepare_product_order t
    ON ]' || (CASE
               WHEN p_prepare_object = 0 THEN
                't.pro_supplier_code = sp.supplier_info_id'
               WHEN p_prepare_object = 1 THEN
                't.mater_supplier_code = sp.supplier_code'
               ELSE
                NULL
             END) || q'[
   AND t.company_id = sp.company_id
   AND t.product_status = 1
   AND t.prepare_object = ]' || p_prepare_object || q'[
  LEFT JOIN (SELECT MIN(po.expect_arrival_time) min_expect_arrival_time,
                    po.product_order_id,
                    po.company_id
               FROM mrp.color_prepare_order po
              WHERE po.whether_del = 0
              GROUP BY po.product_order_id, po.company_id) va
    ON va.product_order_id = t.product_order_id
   AND va.company_id = t.company_id
  LEFT JOIN mrp.mrp_picture mp 
   ON to_char(mp.picture_id) = t.features
 WHERE t.company_id = ']' || p_company_id || q'['
   AND sp.supplier_company_id = %default_company_id%
   AND t.whether_del = 0
 ORDER BY t.receive_time DESC
]';
    RETURN v_sql;
  END f_query_color_prepare_product_order_header;

  --主表 更新色布备料单
  --关联生产单
  PROCEDURE p_generate_color_prepare_order(p_group_key        VARCHAR2,
                                           p_product_order_id VARCHAR2,
                                           p_company_id       VARCHAR2,
                                           p_user_id          VARCHAR2) IS
  BEGIN
    FOR cpo_rec IN (SELECT t.*
                      FROM mrp.color_prepare_order t
                     WHERE t.company_id = p_company_id
                       AND t.group_key = p_group_key
                       AND t.prepare_status = 1) LOOP
      cpo_rec.prepare_status       := 2;
      cpo_rec.receive_id           := p_user_id;
      cpo_rec.receive_time         := SYSDATE;
      cpo_rec.product_order_id     := p_product_order_id;
      cpo_rec.batch_finish_num     := 0;
      cpo_rec.batch_finish_percent := 0;
      cpo_rec.complete_num         := cpo_rec.order_num;
      mrp.pkg_color_prepare_order.p_update_color_prepare_order(p_color_rec => cpo_rec);
    END LOOP;
  END p_generate_color_prepare_order;

  --从表 更新色布备料单
  --关联生产单
  PROCEDURE p_generate_color_prepare_order_sub(p_cpo_rec          mrp.color_prepare_order%ROWTYPE,
                                               p_user_id          VARCHAR2,
                                               p_product_order_id VARCHAR2) IS
    v_cpo_rec mrp.color_prepare_order%ROWTYPE;
  BEGIN
    v_cpo_rec                      := p_cpo_rec;
    v_cpo_rec.prepare_status       := 2;
    v_cpo_rec.receive_id           := p_user_id;
    v_cpo_rec.receive_time         := SYSDATE;
    v_cpo_rec.product_order_id     := p_product_order_id;
    v_cpo_rec.batch_finish_num     := 0;
    v_cpo_rec.batch_finish_percent := 0;
    v_cpo_rec.complete_num         := p_cpo_rec.order_num;
  
    mrp.pkg_color_prepare_order.p_update_color_prepare_order(p_color_rec => v_cpo_rec);
  END p_generate_color_prepare_order_sub;

  --生成色布备料生产单
  PROCEDURE p_generate_color_prepare_product_order(p_cpo_rec          mrp.color_prepare_order%ROWTYPE,
                                                   p_product_order_id VARCHAR2,
                                                   p_order_num        NUMBER,
                                                   p_order_cnt        NUMBER,
                                                   p_relate_skc       VARCHAR2,
                                                   p_company_id       VARCHAR2,
                                                   p_user_id          VARCHAR2) IS
    v_cpop_rec mrp.color_prepare_product_order%ROWTYPE;
  BEGIN
    v_cpop_rec.product_order_id        := p_product_order_id; --色布生产单号
    v_cpop_rec.product_status          := 1; --生产单状态，1生产中，2已完成，3已取消
    v_cpop_rec.prepare_object          := p_cpo_rec.prepare_object; --备料对象
    v_cpop_rec.material_sku            := p_cpo_rec.material_sku; --物料SKU
    v_cpop_rec.pro_supplier_code       := p_cpo_rec.pro_supplier_code; --成品供应商编号
    v_cpop_rec.mater_supplier_code     := p_cpo_rec.mater_supplier_code; --物料供应商编号
    v_cpop_rec.whether_inner_mater     := p_cpo_rec.whether_inner_mater; --是否内部物料，0否1是
    v_cpop_rec.material_name           := p_cpo_rec.material_name; --物料名称
    v_cpop_rec.material_color          := p_cpo_rec.material_color; --物料颜色
    v_cpop_rec.unit                    := p_cpo_rec.unit; --单位
    v_cpop_rec.supplier_material_name  := p_cpo_rec.supplier_material_name; --供应商物料名称
    v_cpop_rec.supplier_color          := p_cpo_rec.supplier_color; --供应商颜色
    v_cpop_rec.supplier_shades         := p_cpo_rec.supplier_shades; --供应商色号
    v_cpop_rec.practical_door_with     := p_cpo_rec.practical_door_with; --实用门幅
    v_cpop_rec.gram_weight             := p_cpo_rec.gram_weight; --克重
    v_cpop_rec.material_specifications := p_cpo_rec.material_specifications; --物料规格
    v_cpop_rec.features                := p_cpo_rec.features; --特征图，图片ID，第一张
    v_cpop_rec.ingredients             := p_cpo_rec.ingredients; --物料成份，成份ID，页面无显示
  
    v_cpop_rec.plan_product_quantity     := p_order_num; --计划生产数量
    v_cpop_rec.contain_color_prepare_num := p_order_cnt; --含色布备料单数
  
    --v_cpop_rec.actual_finish_num := p_cpo_rec.actual_finish_num; --实际完成数量
  
    v_cpop_rec.receive_id           := p_user_id; --接单人
    v_cpop_rec.receive_time         := SYSDATE; --接单日期
    v_cpop_rec.finish_id            := NULL; --总完成人
    v_cpop_rec.finish_num           := NULL; --总完成数量
    v_cpop_rec.finish_time          := NULL; --总完成日期
    v_cpop_rec.batch_finish_num     := 0; --分批完成累计数量
    v_cpop_rec.batch_finish_percent := 0; --分批完成累计百分比
    v_cpop_rec.complete_num         := p_order_num; --待完成数量
    v_cpop_rec.relate_skc           := p_relate_skc; --关联SKC
  
    /*v_cpop_rec.cancel_id     := p_cpo_rec.cancel_id; --取消人
    v_cpop_rec.cancel_time   := p_cpo_rec.cancel_time; --取消日期
    v_cpop_rec.cancel_reason := p_cpo_rec.cancel_reason; --取消原因*/
  
    v_cpop_rec.company_id  := p_company_id; --企业编码
    v_cpop_rec.create_id   := p_user_id; --创建者
    v_cpop_rec.create_time := SYSDATE; --创建时间
    v_cpop_rec.update_id   := p_user_id; --更新者
    v_cpop_rec.update_time := SYSDATE; --更新时间
    v_cpop_rec.whether_del := 0; --是否删除，0否1是
  
    mrp.pkg_color_prepare_product_order.p_insert_color_prepare_product_order(p_color_rec => v_cpop_rec);
  END p_generate_color_prepare_product_order;

  --主表 接单按钮
  PROCEDURE p_receive_orders(p_company_id VARCHAR2,
                             p_user_id    VARCHAR2,
                             p_cpo_rec    mrp.color_prepare_order%ROWTYPE) IS
    v_cpop_id   VARCHAR2(32);
    v_cpop_rec  mrp.color_prepare_product_order%ROWTYPE;
    v_order_num NUMBER := 0;
    v_order_cnt NUMBER := 0;
    v_skc_strs  VARCHAR2(500);
  BEGIN
    --色布生产单号                   
    v_cpop_id := mrp.pkg_plat_comm.f_get_docuno(pi_table_name  => 'COLOR_PREPARE_PRODUCT_ORDER',
                                                pi_column_name => 'PRODUCT_ORDER_ID',
                                                pi_pre         => (CASE
                                                                    WHEN p_cpo_rec.prepare_object = 0 THEN
                                                                     'CKSC'
                                                                    WHEN p_cpo_rec.prepare_object = 1 THEN
                                                                     'WKSC'
                                                                    ELSE
                                                                     NULL
                                                                  END) ||
                                                                  to_char(trunc(SYSDATE),
                                                                          'YYYYMMDD'),
                                                pi_serail_num  => 5);
    --1.生成色布备料生产单
    SELECT SUM(t.order_num),
           COUNT(t.prepare_order_id),
           listagg(t.goods_skc, '/')
      INTO v_order_num, v_order_cnt, v_skc_strs
      FROM mrp.color_prepare_order t
     WHERE t.company_id = p_company_id
       AND t.group_key = p_cpo_rec.group_key
       AND t.prepare_status = 1;
  
    p_generate_color_prepare_product_order(p_cpo_rec          => p_cpo_rec,
                                           p_product_order_id => v_cpop_id,
                                           p_order_num        => v_order_num,
                                           p_order_cnt        => v_order_cnt,
                                           p_relate_skc       => v_skc_strs,
                                           p_company_id       => p_company_id,
                                           p_user_id          => p_user_id);
  
    --2.更新色布备料单
    BEGIN
      --单据变更溯源
      scmdata.pkg_plat_log.p_document_change_trace(p_company_id              => 'a972dd1ffe3b3a10e0533c281cac8fd7',
                                                   p_document_id             => p_cpo_rec.prepare_order_id,
                                                   p_data_source_parent_code => 'PREMATERIAL_MANA_LOG',
                                                   p_data_source_child_code  => '00',
                                                   p_operate_company_id      => p_company_id,
                                                   p_user_id                 => p_user_id);
    
      --更新色布备料单
      p_generate_color_prepare_order(p_group_key        => p_cpo_rec.group_key,
                                     p_product_order_id => v_cpop_id,
                                     p_company_id       => p_company_id,
                                     p_user_id          => p_user_id);
    END;
  
    --3.根据生成的【色布备料生产单表】信息，生成【坯布出入库单表】信息    
    SELECT t.*
      INTO v_cpop_rec
      FROM mrp.color_prepare_product_order t
     WHERE t.product_order_id = v_cpop_id;
  
    --4.区分备料对象 进行坯转色  
    IF v_cpop_rec.prepare_object = 0 THEN
      --成品供应商
      p_fabric_gray_convert_color(p_cpop_rec => v_cpop_rec,
                                  p_user_id  => p_user_id);
    ELSIF v_cpop_rec.prepare_object = 1 THEN
      --物料供应商
      p_material_fabric_gray_convert_color(p_cpop_rec => v_cpop_rec,
                                           p_user_id  => p_user_id);
    ELSE
      NULL;
    END IF;
  END p_receive_orders;

  --从表 接单按钮
  PROCEDURE p_receive_orders_sub(p_company_id VARCHAR2,
                                 p_user_id    VARCHAR2,
                                 p_cpop_id    VARCHAR2,
                                 p_cpo_rec    mrp.color_prepare_order%ROWTYPE,
                                 p_order_num  NUMBER,
                                 p_order_cnt  NUMBER,
                                 p_relate_skc VARCHAR2) IS
    v_cpop_rec mrp.color_prepare_product_order%ROWTYPE;
  BEGIN
    --1.生成色布备料生产单
    p_generate_color_prepare_product_order(p_cpo_rec          => p_cpo_rec,
                                           p_product_order_id => p_cpop_id,
                                           p_order_num        => p_order_num,
                                           p_order_cnt        => p_order_cnt,
                                           p_relate_skc       => p_relate_skc,
                                           p_company_id       => p_company_id,
                                           p_user_id          => p_user_id);
    --2.根据生成的【色布备料生产单表】信息，生成【坯布出入库单表】信息    
    SELECT t.*
      INTO v_cpop_rec
      FROM mrp.color_prepare_product_order t
     WHERE t.product_order_id = p_cpop_id;
  
    --3.区分备料对象 进行坯转色
    --成品供应商
    IF v_cpop_rec.prepare_object = 0 THEN
      p_fabric_gray_convert_color(p_cpop_rec => v_cpop_rec,
                                  p_user_id  => p_user_id);
    ELSIF v_cpop_rec.prepare_object = 1 THEN
      p_material_fabric_gray_convert_color(p_cpop_rec => v_cpop_rec,
                                           p_user_id  => p_user_id);
    ELSE
      NULL;
    END IF;
  END p_receive_orders_sub;

  --成品供应商 坯布转色布
  PROCEDURE p_fabric_gray_convert_color(p_cpop_rec mrp.color_prepare_product_order%ROWTYPE,
                                        p_user_id  VARCHAR2) IS
    v_material_spu  VARCHAR2(256);
    v_brand_stock   NUMBER(18, 2);
    v_dye_loss_late NUMBER(11, 2);
    v_num           NUMBER; --品牌仓数
    v_flag          INT;
    v_sgiob_rec     mrp.supplier_grey_in_out_bound%ROWTYPE;
    vo_bound_num    VARCHAR2(32); --坯布出入库单单号
  BEGIN
    --1.1 获取物料spu
    v_material_spu := f_get_material_spu(p_material_sku      => p_cpop_rec.material_sku,
                                         p_sup_code          => p_cpop_rec.pro_supplier_code,
                                         p_is_inner_material => p_cpop_rec.whether_inner_mater);
  
    --1.2 获取品牌仓数
    v_brand_stock := f_get_brand_stock(p_company_id          => p_cpop_rec.company_id,
                                       p_prepare_object      => p_cpop_rec.prepare_object,
                                       p_pro_supplier_code   => p_cpop_rec.pro_supplier_code,
                                       p_mater_supplier_code => p_cpop_rec.mater_supplier_code,
                                       p_unit                => p_cpop_rec.unit,
                                       p_material_spu        => v_material_spu,
                                       p_store_type          => 1);
  
    --1.3获取染损率
    v_dye_loss_late := f_get_dye_loss_late(p_pro_supplier_code   => (CASE
                                                                      WHEN p_cpop_rec.whether_inner_mater = 1 THEN
                                                                       NULL
                                                                      ELSE
                                                                       p_cpop_rec.pro_supplier_code
                                                                    END),
                                           p_mater_supplier_code => p_cpop_rec.mater_supplier_code,
                                           p_material_sku        => p_cpop_rec.material_sku,
                                           p_is_inner_material   => p_cpop_rec.whether_inner_mater);
  
    --1.4 校验品牌仓数是否大于0
    --大于0，则品牌仓有库存     
    IF v_brand_stock > 0 THEN
      --校验“品牌仓坯布库存”转化为色布是否够用
      p_check_color_fabric_is_enough(p_brand_stock      => v_brand_stock,
                                     p_plan_product_num => p_cpop_rec.plan_product_quantity,
                                     p_dye_loss_late    => v_dye_loss_late,
                                     p_store_type       => 1,
                                     po_is_enough_flag  => v_flag,
                                     po_num             => v_num);
      --成品供应商生成品牌仓 出入库单
      p_generate_brand_inout_bound(p_cpop_rec     => p_cpop_rec,
                                   p_store_type   => 1,
                                   p_material_spu => v_material_spu,
                                   p_num          => v_num,
                                   p_user_id      => p_user_id,
                                   po_bound_num   => vo_bound_num);
    
      --是，则根据生成的【供应商库存-坯布出入库单表】信息，更新【供应商库存-坯布仓库存明细】相应数据
      SELECT gs.*
        INTO v_sgiob_rec
        FROM mrp.supplier_grey_in_out_bound gs
       WHERE gs.bound_num = vo_bound_num
         AND gs.whether_del = 0;
    
      --更新成品供应商库存-坯布仓库存明细
      p_generate_grey_stock(p_sgiob_rec   => v_sgiob_rec,
                            p_inout_stock => v_num, --出入库数
                            p_user_id     => p_user_id);
    
      --判断品牌仓库存是否够用
      IF v_flag = 1 THEN
        NULL;
      ELSE
        --否，则品牌仓库存不够，继续从供应商仓扣
        --生成供应商仓 出入库单
        p_generate_sup_brand_inout_bound(p_cpop_rec      => p_cpop_rec,
                                         p_store_type    => 2,
                                         p_material_spu  => v_material_spu,
                                         p_brand_stock   => v_brand_stock,
                                         p_dye_loss_late => v_dye_loss_late,
                                         p_user_id       => p_user_id);
      
      END IF;
    ELSE
      --1.5 否则，品牌仓无库存，直接从供应商仓扣
      --生成供应商仓 出入库单
      p_generate_sup_brand_inout_bound(p_cpop_rec      => p_cpop_rec,
                                       p_store_type    => 2,
                                       p_material_spu  => v_material_spu,
                                       p_brand_stock   => v_brand_stock,
                                       p_dye_loss_late => v_dye_loss_late,
                                       p_user_id       => p_user_id);
    
    END IF;
  END p_fabric_gray_convert_color;

  --物料供应商 坯布转色布
  PROCEDURE p_material_fabric_gray_convert_color(p_cpop_rec mrp.color_prepare_product_order%ROWTYPE,
                                                 p_user_id  VARCHAR2) IS
    v_material_spu  VARCHAR2(256);
    v_brand_stock   NUMBER(18, 2);
    v_dye_loss_late NUMBER(11, 2);
    v_flag          INT;
    v_num           NUMBER; --品牌仓数
    v_mgiob_rec     mrp.material_grey_in_out_bound%ROWTYPE;
    vo_bound_num    VARCHAR2(32); --坯布出入库单单号
  BEGIN
    --1.1 获取物料spu
    v_material_spu := f_get_mt_material_spu(p_material_sku => p_cpop_rec.material_sku);
  
    --1.2 获取品牌仓数
    v_brand_stock := f_get_brand_stock(p_company_id          => p_cpop_rec.company_id,
                                       p_prepare_object      => p_cpop_rec.prepare_object,
                                       p_mater_supplier_code => p_cpop_rec.mater_supplier_code,
                                       p_unit                => p_cpop_rec.unit,
                                       p_material_spu        => v_material_spu,
                                       p_store_type          => 1);
  
    --1.3获取染损率
    v_dye_loss_late := f_get_mt_dye_loss_late(p_mater_supplier_code => p_cpop_rec.mater_supplier_code,
                                              p_material_sku        => p_cpop_rec.material_sku);
  
    --1.4 校验品牌仓数是否大于0
    --大于0，则品牌仓有库存     
    IF v_brand_stock > 0 THEN
      --校验“品牌仓坯布库存”转化为色布是否够用
      p_check_color_fabric_is_enough(p_brand_stock      => v_brand_stock,
                                     p_plan_product_num => p_cpop_rec.plan_product_quantity,
                                     p_dye_loss_late    => v_dye_loss_late,
                                     p_store_type       => 1,
                                     po_is_enough_flag  => v_flag,
                                     po_num             => v_num);
      --物料供应商 生成品牌仓 出入库单
      p_generate_brand_inout_bound(p_cpop_rec     => p_cpop_rec,
                                   p_store_type   => 1,
                                   p_material_spu => v_material_spu,
                                   p_num          => v_num,
                                   p_user_id      => p_user_id,
                                   po_bound_num   => vo_bound_num);
    
      --是，则根据物料供应商 生成的【供应商库存-坯布出入库单表】信息，更新【供应商库存-坯布仓库存明细】相应数据   
      SELECT gs.*
        INTO v_mgiob_rec
        FROM mrp.material_grey_in_out_bound gs
       WHERE gs.bound_num = vo_bound_num
         AND gs.whether_del = 0;
    
      --更新物料供应商库存-坯布仓库存明细
      p_generate_material_grey_stock(p_mgiob_rec   => v_mgiob_rec,
                                     p_inout_stock => v_num, --出入库数
                                     p_user_id     => p_user_id);
    
      --判断品牌仓库存是否够用
      IF v_flag = 1 THEN
        NULL;
      ELSE
        --否，则品牌仓库存不够，继续从供应商仓扣
        --据备料对象（成品、物料供应商）生成供应商仓 出入库单
        p_generate_sup_brand_inout_bound(p_cpop_rec      => p_cpop_rec,
                                         p_store_type    => 2,
                                         p_material_spu  => v_material_spu,
                                         p_brand_stock   => v_brand_stock,
                                         p_dye_loss_late => v_dye_loss_late,
                                         p_user_id       => p_user_id);
      
      END IF;
    ELSE
      --1.5 否则，品牌仓无库存，直接从供应商仓扣
      --据备料对象（成品、物料供应商）生成供应商仓 出入库单
      p_generate_sup_brand_inout_bound(p_cpop_rec      => p_cpop_rec,
                                       p_store_type    => 2,
                                       p_material_spu  => v_material_spu,
                                       p_brand_stock   => v_brand_stock,
                                       p_dye_loss_late => v_dye_loss_late,
                                       p_user_id       => p_user_id);
    
    END IF;
  END p_material_fabric_gray_convert_color;

  --获取成品供应商 物料spu
  FUNCTION f_get_material_spu(p_material_sku      VARCHAR2,
                              p_sup_code          VARCHAR2 DEFAULT NULL,
                              p_is_inner_material INT) RETURN VARCHAR2 IS
    v_material_spu VARCHAR2(256);
  BEGIN
    IF p_is_inner_material = 0 THEN
      SELECT MAX(t.material_spu)
        INTO v_material_spu
        FROM mrp.mrp_outside_material_sku t
       WHERE t.material_sku = p_material_sku
         AND t.create_finished_supplier_code = p_sup_code
         AND t.whether_del = 0;
    ELSIF p_is_inner_material = 1 THEN
      SELECT MAX(t.material_spu)
        INTO v_material_spu
        FROM mrp.mrp_internal_material_sku t
       WHERE t.material_sku = p_material_sku;
    ELSE
      NULL;
    END IF;
    IF v_material_spu IS NULL THEN
      raise_application_error(-20002,
                              '数据有误：SPU不可为空，请联系管理员！');
    END IF;
    RETURN v_material_spu;
  END f_get_material_spu;

  --获取物料供应商 物料spu
  FUNCTION f_get_mt_material_spu(p_material_sku VARCHAR2) RETURN VARCHAR2 IS
    v_material_spu VARCHAR2(256);
  BEGIN
    SELECT MAX(t.material_spu)
      INTO v_material_spu
      FROM mrp.mrp_internal_material_sku t
     WHERE t.material_sku = p_material_sku;
  
    RETURN v_material_spu;
  END f_get_mt_material_spu;

  --获取品牌仓、供应商仓数
  --1 品牌仓
  --2 供应商仓
  FUNCTION f_get_brand_stock(p_company_id          VARCHAR2,
                             p_prepare_object      INT,
                             p_pro_supplier_code   VARCHAR2 DEFAULT NULL,
                             p_mater_supplier_code VARCHAR2,
                             p_unit                VARCHAR2,
                             p_material_spu        VARCHAR2,
                             p_store_type          INT) RETURN NUMBER IS
    v_brand_stock NUMBER(18, 2);
    v_sql         CLOB;
  BEGIN
    v_sql := q'[SELECT nvl((CASE
                 WHEN :p_store_type = 1 THEN
                  MAX(t.brand_stock)
                 WHEN :p_store_type = 2 THEN
                  MAX(t.supplier_stock)
                 ELSE
                  NULL
               END),
               0)     
      FROM ]' || (CASE
               WHEN p_prepare_object = 0 THEN
                ' mrp.supplier_grey_stock '
               WHEN p_prepare_object = 1 THEN
                ' mrp.material_grey_stock '
               ELSE
                NULL
             END) || q'[ t
     WHERE ]' || (CASE
               WHEN p_prepare_object = 0 THEN
                ' t.pro_supplier_code = :p_pro_supplier_code AND '
               ELSE
                NULL
             END) || q'[
        t.mater_supplier_code = :p_mater_supplier_code
       AND t.unit = :p_unit
       AND t.material_spu = :p_material_spu
       AND t.whether_del = 0
       AND t.company_id = :p_company_id]';
  
    IF p_prepare_object = 0 THEN
      EXECUTE IMMEDIATE v_sql
        INTO v_brand_stock
        USING p_store_type, p_store_type, p_pro_supplier_code, p_mater_supplier_code, p_unit, p_material_spu, p_company_id;
    ELSIF p_prepare_object = 1 THEN
      EXECUTE IMMEDIATE v_sql
        INTO v_brand_stock
        USING p_store_type, p_store_type, p_mater_supplier_code, p_unit, p_material_spu, p_company_id;
    ELSE
      NULL;
    END IF;
    RETURN v_brand_stock;
  END f_get_brand_stock;

  --获取品牌仓、供应商仓数  DYY
  FUNCTION f_get_stock_num(p_company_id          VARCHAR2,
                           p_sup_mode            INT, --0 成品 1 物料
                           p_type                VARCHAR2, --sku/spu
                           p_pro_supplier_code   VARCHAR2 DEFAULT NULL,
                           p_mater_supplier_code VARCHAR2,
                           p_unit                VARCHAR2,
                           p_material_id         VARCHAR2,
                           p_store_type          INT --1 品牌仓 2 供应商仓
                           ) RETURN NUMBER IS
    v_stock NUMBER(18, 2);
    v_sql   CLOB;
  BEGIN
    --IF p_type =  'SPU' AND p_prepare_object = 0 THEN 
    v_sql := 'SELECT nvl((CASE
                 WHEN :p_store_type = 1 THEN
                  MAX(t.brand_stock)
                 WHEN :p_store_type = 2 THEN
                  MAX(t.supplier_stock)
                 ELSE
                  NULL
               END),
               0)     
      FROM ' || CASE
               WHEN p_type = 'SPU' AND p_sup_mode = 0 THEN
                '  mrp.supplier_grey_stock t '
               WHEN p_type = 'SPU' AND p_sup_mode = 1 THEN
                '  MRP.MATERIAL_GREY_STOCK t '
               WHEN p_type = 'SKU' AND p_sup_mode = 0 THEN
                '   MRP.SUPPLIER_COLOR_CLOTH_STOCK T '
               WHEN p_type = 'SKU' AND p_sup_mode = 1 THEN
                ' MRP.MATERIAL_COLOR_CLOTH_STOCK t'
             END || '
     WHERE ' || (CASE
               WHEN p_sup_mode = 0 THEN
                ' t.pro_supplier_code = :p_pro_supplier_code AND '
               ELSE
                NULL
             END) || q'[
        t.mater_supplier_code = :p_mater_supplier_code
       AND t.unit = :p_unit
       AND ]' || (CASE
               WHEN p_type = 'SPU' THEN
                't.material_spu = :p_material_id '
               WHEN p_type = 'SKU' THEN
                't.MATERIAL_SKU =:p_material_id '
             END) || 'AND t.whether_del = 0
       AND t.company_id = :p_company_id ';
  
    IF p_sup_mode = 0 THEN
      EXECUTE IMMEDIATE v_sql
        INTO v_stock
        USING p_store_type, p_store_type, p_pro_supplier_code, p_mater_supplier_code, p_unit, p_material_id, p_company_id;
    ELSIF p_sup_mode = 1 THEN
      EXECUTE IMMEDIATE v_sql
        INTO v_stock
        USING p_store_type, p_store_type, p_mater_supplier_code, p_unit, p_material_id, p_company_id;
    ELSE
      NULL;
    END IF;
    RETURN v_stock;
  END f_get_stock_num;

  --成品供应商 获取染损率
  FUNCTION f_get_dye_loss_late(p_pro_supplier_code   VARCHAR2 DEFAULT NULL,
                               p_mater_supplier_code VARCHAR2,
                               p_material_sku        VARCHAR2,
                               p_is_inner_material   INT) RETURN NUMBER IS
    v_dye_loss_late NUMBER(11, 2);
  BEGIN
    IF p_is_inner_material = 0 THEN
      SELECT nvl(MAX(t.dye_loss_late), 0)
        INTO v_dye_loss_late
        FROM mrp.mrp_outside_supplier_material t
       WHERE t.supplier_code = p_mater_supplier_code
         AND t.create_finished_supplier_code = p_pro_supplier_code
         AND t.material_sku = p_material_sku
         AND t.whether_del = 0;
    ELSIF p_is_inner_material = 1 THEN
      SELECT nvl(MAX(t.dye_loss_late), 0)
        INTO v_dye_loss_late
        FROM mrp.mrp_internal_supplier_material t
       WHERE t.supplier_code = p_mater_supplier_code
         AND t.material_sku = p_material_sku;
    ELSE
      v_dye_loss_late := 0;
    END IF;
    RETURN v_dye_loss_late;
  END f_get_dye_loss_late;

  --物料供应商 获取染损率
  FUNCTION f_get_mt_dye_loss_late(p_mater_supplier_code VARCHAR2,
                                  p_material_sku        VARCHAR2)
    RETURN NUMBER IS
    v_dye_loss_late NUMBER(11, 2);
  BEGIN
  
    SELECT nvl(MAX(t.dye_loss_late), 0)
      INTO v_dye_loss_late
      FROM mrp.mrp_internal_supplier_material t
     WHERE t.supplier_code = p_mater_supplier_code
       AND t.material_sku = p_material_sku;
  
    RETURN v_dye_loss_late;
  END f_get_mt_dye_loss_late;

  --校验“品牌仓/供应商仓 坯布库存”转化为色布是否够用
  PROCEDURE p_check_color_fabric_is_enough(p_brand_stock      NUMBER,
                                           p_plan_product_num NUMBER,
                                           p_sup_store_num    NUMBER DEFAULT 0,
                                           p_dye_loss_late    NUMBER,
                                           p_store_type       INT,
                                           po_is_enough_flag  OUT INT,
                                           po_num             OUT NUMBER) IS
    v_num  NUMBER;
    v_flag INT;
  BEGIN
    --品牌仓
    IF p_store_type = 1 THEN
      --校验“品牌仓坯布库存”转化为色布是否够用：
      --校验公式：【品牌仓坯布库存】 - （生成的【色布备料生产单表-计划生产数量】/(1-【染损率/100】) ≥ 0 
      v_num := p_brand_stock -
               (p_plan_product_num / (1 - (p_dye_loss_late / 100)));
      -- 当≥0时 数量:【色布备料生产单表-计划生产数量】/(1-【染损率】】
      --当<0时 数量:【品牌仓坯布库存】
      IF v_num >= 0 THEN
        v_flag := 1;
        v_num  := p_plan_product_num / (1 - (p_dye_loss_late / 100));
      ELSE
        v_flag := 0;
        v_num  := p_brand_stock;
      END IF;
    ELSIF p_store_type = 2 THEN
      --校验”供应商仓坯布库存“转化为色布是否够用：    
      --校验公式：【供应商仓坯布库存】-（生成的【色布备料生产单表-计划生产数量】/(1-【染损率/100】-【品牌仓坯布库存】 ) ≥ 0 ；  
      --当≥0时，【数量】=（生成的【色布备料生产单表-计划生产数量】/(1-【染损率/100】-【品牌仓坯布库存】 )  ；   
      --当＜0时，数量=【供应商仓库存数】；
      v_num := p_sup_store_num -
               ((p_plan_product_num / (1 - (p_dye_loss_late / 100))) -
               p_brand_stock);
      IF v_num >= 0 THEN
        v_flag := 1;
        v_num  := (p_plan_product_num / (1 - (p_dye_loss_late / 100))) -
                  p_brand_stock;
      ELSE
        v_flag := 0;
        v_num  := p_sup_store_num;
      END IF;
    ELSE
      v_flag := 0;
    END IF;
    po_is_enough_flag := v_flag;
    po_num            := v_num;
  END p_check_color_fabric_is_enough;

  --成品供应商生成【供应商库存-坯布出入库单表】信息
  PROCEDURE p_generate_brand_inout_bound_by_pro(p_cpop_rec     mrp.color_prepare_product_order%ROWTYPE,
                                                p_store_type   INT,
                                                p_material_spu VARCHAR2,
                                                p_num          NUMBER,
                                                p_user_id      VARCHAR2,
                                                po_bound_num   OUT VARCHAR2) IS
    v_bound_num VARCHAR2(32);
    v_sgiob_rec mrp.supplier_grey_in_out_bound%ROWTYPE;
  BEGIN
    v_bound_num           := mrp.pkg_plat_comm.f_get_docuno(pi_table_name  => 'SUPPLIER_GREY_IN_OUT_BOUND',
                                                            pi_column_name => 'BOUND_NUM',
                                                            pi_pre         => 'CPCK' ||
                                                                              to_char(trunc(SYSDATE),
                                                                                      'YYYYMMDD'),
                                                            pi_serail_num  => 5);
    v_sgiob_rec.bound_num := v_bound_num;
  
    v_sgiob_rec.ascription          := 0; --出入库归属，0出库1入库
    v_sgiob_rec.bound_type          := 4; --坯布出入库类型，1色布备料出库/ 2盘亏出库/ 3临时坯转色出库/ 4坯布备料出库 /11品牌备料入库/ 12供应商现货入库/ 13盘盈入库/ 14临时补充入库/15 供应商色布入库
    v_sgiob_rec.pro_supplier_code   := p_cpop_rec.pro_supplier_code; --成品供应商编号
    v_sgiob_rec.mater_supplier_code := p_cpop_rec.mater_supplier_code; --物料供应商编号
    v_sgiob_rec.material_spu        := p_material_spu; --物料SPU
    v_sgiob_rec.whether_inner_mater := p_cpop_rec.whether_inner_mater; --是否内部物料，0否1是
    v_sgiob_rec.unit                := p_cpop_rec.unit; --单位
    v_sgiob_rec.num                 := p_num; --数量
    v_sgiob_rec.stock_type          := p_store_type; --仓库类型，1品牌仓，2供应商仓
  
    v_sgiob_rec.relate_num                := p_cpop_rec.product_order_id; --关联单号
    v_sgiob_rec.relate_num_type           := 1; --关联单号类型，1色布生产单/ 2坯布盘点单/ 3色布领料单/ 4坯布生产单/5面料采购单/6色布入库单
    v_sgiob_rec.relate_skc                := p_cpop_rec.relate_skc; --关联SKC
    v_sgiob_rec.company_id                := p_cpop_rec.company_id; --三福企业的【企业ID】
    v_sgiob_rec.create_id                 := p_user_id; --创建者
    v_sgiob_rec.create_time               := SYSDATE; --创建时间
    v_sgiob_rec.update_id                 := p_user_id; --更新者
    v_sgiob_rec.update_time               := SYSDATE; --更新时间
    v_sgiob_rec.whether_del               := 0; --是否删除，0否1是
    v_sgiob_rec.relate_purchase_order_num := NULL; --关联采购单号
  
    mrp.pkg_supplier_grey_in_out_bound.p_insert_supplier_grey_in_out_bound(p_suppl_rec => v_sgiob_rec);
    po_bound_num := v_bound_num;
  END p_generate_brand_inout_bound_by_pro;

  --物料供应商生成【供应商库存-坯布出入库单表】信息
  PROCEDURE p_generate_brand_inout_bound_by_mt(p_cpop_rec     mrp.color_prepare_product_order%ROWTYPE,
                                               p_store_type   INT,
                                               p_material_spu VARCHAR2,
                                               p_num          NUMBER,
                                               p_user_id      VARCHAR2,
                                               po_bound_num   OUT VARCHAR2) IS
    v_bound_num VARCHAR2(32);
    v_mciob_rec mrp.material_grey_in_out_bound%ROWTYPE;
  BEGIN
    v_bound_num           := mrp.pkg_plat_comm.f_get_docuno(pi_table_name  => 'MATERIAL_GREY_IN_OUT_BOUND',
                                                            pi_column_name => 'BOUND_NUM',
                                                            pi_pre         => 'WPCK' ||
                                                                              to_char(trunc(SYSDATE),
                                                                                      'YYYYMMDD'),
                                                            pi_serail_num  => 5);
    v_mciob_rec.bound_num := v_bound_num;
  
    v_mciob_rec.ascription          := 0; --出入库归属，0出库1入库
    v_mciob_rec.bound_type          := 4; --坯布出入库类型，1色布备料出库/ 2盘亏出库/ 3临时坯转色出库/ 4坯布备料出库 /11品牌备料入库/ 12供应商现货入库/ 13盘盈入库/ 14临时补充入库/15 供应商色布入库       
    v_mciob_rec.mater_supplier_code := p_cpop_rec.mater_supplier_code; --物料供应商编号
    v_mciob_rec.material_spu        := p_material_spu; --物料SPU
    --v_mciob_rec.whether_inner_mater := p_cpop_rec.whether_inner_mater; --是否内部物料，0否1是
    v_mciob_rec.unit       := p_cpop_rec.unit; --单位
    v_mciob_rec.num        := p_num; --数量
    v_mciob_rec.stock_type := p_store_type; --仓库类型，1品牌仓，2供应商仓
  
    v_mciob_rec.relate_num                := p_cpop_rec.product_order_id; --关联单号
    v_mciob_rec.relate_num_type           := 1; --关联单号类型，1色布生产单/ 2坯布盘点单/ 3色布领料单/ 4坯布生产单/5面料采购单/6色布入库单
    v_mciob_rec.relate_skc                := p_cpop_rec.relate_skc; --关联SKC
    v_mciob_rec.company_id                := p_cpop_rec.company_id; --三福企业的【企业ID】
    v_mciob_rec.create_id                 := p_user_id; --创建者
    v_mciob_rec.create_time               := SYSDATE; --创建时间
    v_mciob_rec.update_id                 := p_user_id; --更新者
    v_mciob_rec.update_time               := SYSDATE; --更新时间
    v_mciob_rec.whether_del               := 0; --是否删除，0否1是
    v_mciob_rec.relate_purchase_order_num := NULL; --关联采购单号
  
    mrp.pkg_material_grey_in_out_bound.p_insert_material_grey_in_out_bound(p_mater_rec => v_mciob_rec);
    po_bound_num := v_bound_num;
  END p_generate_brand_inout_bound_by_mt;

  --成品、物料供应商 品牌仓-生成坯布出入库单
  PROCEDURE p_generate_brand_inout_bound(p_cpop_rec     mrp.color_prepare_product_order%ROWTYPE,
                                         p_store_type   INT,
                                         p_material_spu VARCHAR2,
                                         p_num          NUMBER,
                                         p_user_id      VARCHAR2,
                                         po_bound_num   OUT VARCHAR2) IS
    v_bound_num VARCHAR2(32);
  BEGIN
  
    IF p_cpop_rec.prepare_object = 0 THEN
      --成品供应商 品牌仓 生成供应商库存-坯布出入库单表
      p_generate_brand_inout_bound_by_pro(p_cpop_rec     => p_cpop_rec,
                                          p_store_type   => p_store_type,
                                          p_material_spu => p_material_spu,
                                          p_num          => p_num,
                                          p_user_id      => p_user_id,
                                          po_bound_num   => v_bound_num);
    ELSIF p_cpop_rec.prepare_object = 1 THEN
      --物料供应商 品牌仓 生成供应商库存-坯布出入库单表
      p_generate_brand_inout_bound_by_mt(p_cpop_rec     => p_cpop_rec,
                                         p_store_type   => p_store_type,
                                         p_material_spu => p_material_spu,
                                         p_num          => p_num,
                                         p_user_id      => p_user_id,
                                         po_bound_num   => v_bound_num);
    ELSE
      NULL;
    END IF;
    po_bound_num := v_bound_num;
  END p_generate_brand_inout_bound;

  --成品供应商 供应商仓-生成坯布出入库单
  PROCEDURE p_generate_sup_brand_inout_bound_by_pro(p_cpop_rec     mrp.color_prepare_product_order%ROWTYPE,
                                                    p_store_type   INT,
                                                    p_material_spu VARCHAR2,
                                                    p_sup_num      NUMBER,
                                                    p_user_id      VARCHAR2) IS
    v_bound_num VARCHAR2(32);
    v_sgiob_rec mrp.supplier_grey_in_out_bound%ROWTYPE;
  BEGIN
    --供应商仓 生成供应商库存-坯布出入库单表
    v_bound_num := mrp.pkg_plat_comm.f_get_docuno(pi_table_name  => 'SUPPLIER_GREY_IN_OUT_BOUND',
                                                  pi_column_name => 'BOUND_NUM',
                                                  pi_pre         => 'CPCK' ||
                                                                    to_char(trunc(SYSDATE),
                                                                            'YYYYMMDD'),
                                                  pi_serail_num  => 5); --坯布出入库单号
  
    --成品供应商 供应商仓 生成供应商库存-坯布出入库单表
    p_generate_brand_inout_bound_by_pro(p_cpop_rec     => p_cpop_rec,
                                        p_store_type   => p_store_type,
                                        p_material_spu => p_material_spu,
                                        p_num          => p_sup_num,
                                        p_user_id      => p_user_id,
                                        po_bound_num   => v_bound_num);
  
    --是，则根据生成的【供应商库存-坯布出入库单表】信息，更新【供应商库存-坯布仓库存明细】相应数据
    SELECT gs.*
      INTO v_sgiob_rec
      FROM mrp.supplier_grey_in_out_bound gs
     WHERE gs.bound_num = v_bound_num
       AND gs.whether_del = 0;
  
    --更新成品供应商库存-坯布仓库存明细
    p_generate_grey_stock(p_sgiob_rec   => v_sgiob_rec,
                          p_inout_stock => p_sup_num, --出入库数
                          p_user_id     => p_user_id);
  
  END p_generate_sup_brand_inout_bound_by_pro;

  --物料供应商 供应商仓-生成坯布出入库单
  PROCEDURE p_generate_sup_brand_inout_bound_by_mt(p_cpop_rec     mrp.color_prepare_product_order%ROWTYPE,
                                                   p_store_type   INT,
                                                   p_material_spu VARCHAR2,
                                                   p_sup_num      NUMBER,
                                                   p_user_id      VARCHAR2) IS
    v_bound_num VARCHAR2(32);
    v_mgiob_rec mrp.material_grey_in_out_bound%ROWTYPE;
  BEGIN
    --供应商仓 生成供应商库存-坯布出入库单表
    p_generate_brand_inout_bound_by_mt(p_cpop_rec     => p_cpop_rec,
                                       p_store_type   => p_store_type,
                                       p_material_spu => p_material_spu,
                                       p_num          => p_sup_num,
                                       p_user_id      => p_user_id,
                                       po_bound_num   => v_bound_num);
    --是，则根据物料供应商 生成的【供应商库存-坯布出入库单表】信息，更新【供应商库存-坯布仓库存明细】相应数据   
    SELECT gs.*
      INTO v_mgiob_rec
      FROM mrp.material_grey_in_out_bound gs
     WHERE gs.bound_num = v_bound_num
       AND gs.whether_del = 0;
    --更新供应商库存-坯布仓库存明细
    p_generate_material_grey_stock(p_mgiob_rec   => v_mgiob_rec,
                                   p_inout_stock => p_sup_num, --出入库数
                                   p_user_id     => p_user_id);
  
  END p_generate_sup_brand_inout_bound_by_mt;

  --成品、物料供应商 供应商仓-生成坯布出入库单
  PROCEDURE p_generate_sup_brand_inout_bound(p_cpop_rec      mrp.color_prepare_product_order%ROWTYPE,
                                             p_store_type    INT,
                                             p_material_spu  VARCHAR2,
                                             p_brand_stock   NUMBER,
                                             p_dye_loss_late NUMBER,
                                             p_user_id       VARCHAR2) IS
    v_sup_brand_stock NUMBER(18, 2);
    v_flag            INT;
    v_sup_num         NUMBER; --供应商仓数 
  BEGIN
    --获取供应商仓库存数
    v_sup_brand_stock := f_get_brand_stock(p_company_id          => p_cpop_rec.company_id,
                                           p_prepare_object      => p_cpop_rec.prepare_object,
                                           p_pro_supplier_code   => p_cpop_rec.pro_supplier_code,
                                           p_mater_supplier_code => p_cpop_rec.mater_supplier_code,
                                           p_unit                => p_cpop_rec.unit,
                                           p_material_spu        => p_material_spu,
                                           p_store_type          => p_store_type);
    --判断供应商仓是否有库存 
    --有，则执行一下逻辑
    --无，则不作处理
    IF v_sup_brand_stock > 0 THEN
      --校验“供应商仓坯布库存”转化为色布是否够用
      p_check_color_fabric_is_enough(p_brand_stock      => p_brand_stock,
                                     p_plan_product_num => p_cpop_rec.plan_product_quantity,
                                     p_sup_store_num    => v_sup_brand_stock,
                                     p_dye_loss_late    => p_dye_loss_late,
                                     p_store_type       => p_store_type,
                                     po_is_enough_flag  => v_flag,
                                     po_num             => v_sup_num);
    
      IF p_cpop_rec.prepare_object = 0 THEN
        --成品供应商 供应商仓 生成供应商库存-坯布出入库单表
        --更新供应商库存-坯布仓库存明细 
        p_generate_sup_brand_inout_bound_by_pro(p_cpop_rec     => p_cpop_rec,
                                                p_store_type   => p_store_type,
                                                p_material_spu => p_material_spu,
                                                p_sup_num      => v_sup_num,
                                                p_user_id      => p_user_id);
      
      ELSIF p_cpop_rec.prepare_object = 1 THEN
        --物料供应商 供应商仓 生成供应商库存-坯布出入库单表
        --更新供应商库存-坯布仓库存明细 
        p_generate_sup_brand_inout_bound_by_mt(p_cpop_rec     => p_cpop_rec,
                                               p_store_type   => p_store_type,
                                               p_material_spu => p_material_spu,
                                               p_sup_num      => v_sup_num,
                                               p_user_id      => p_user_id);
      END IF;
    ELSE
      NULL;
    END IF;
  END p_generate_sup_brand_inout_bound;

  --成品供应商 更新【供应商库存-坯布仓库存明细】相应数据
  PROCEDURE p_generate_grey_stock(p_sgiob_rec   mrp.supplier_grey_in_out_bound%ROWTYPE,
                                  p_inout_stock NUMBER,
                                  p_user_id     VARCHAR2) IS
  
  BEGIN
    UPDATE mrp.supplier_grey_stock gs
       SET gs.total_stock = (CASE
                              WHEN p_sgiob_rec.ascription = 1 THEN
                               gs.total_stock + p_inout_stock --入库
                              WHEN p_sgiob_rec.ascription = 0 THEN
                               gs.total_stock - p_inout_stock --出库
                              ELSE
                               0
                            END),
           gs.brand_stock = (CASE
                            --品牌仓
                              WHEN p_sgiob_rec.stock_type = 1 THEN
                               (CASE
                                 WHEN p_sgiob_rec.ascription = 1 THEN
                                  gs.brand_stock + p_inout_stock --入库
                                 WHEN p_sgiob_rec.ascription = 0 THEN
                                  gs.brand_stock - p_inout_stock --出库
                                 ELSE
                                  0
                               END)
                            --供应商仓
                              WHEN p_sgiob_rec.stock_type = 2 THEN
                               gs.brand_stock
                              ELSE
                               0
                            END),
           gs.supplier_stock = (CASE
                               --品牌仓
                                 WHEN p_sgiob_rec.stock_type = 1 THEN
                                  gs.supplier_stock
                               --供应商仓
                                 WHEN p_sgiob_rec.stock_type = 2 THEN
                                  (CASE
                                    WHEN p_sgiob_rec.ascription = 1 THEN
                                     gs.supplier_stock + p_inout_stock --入库
                                    WHEN p_sgiob_rec.ascription = 0 THEN
                                     gs.supplier_stock - p_inout_stock --出库
                                    ELSE
                                     0
                                  END)
                                 ELSE
                                  0
                               END),
           gs.update_id      = p_user_id,
           gs.update_time    = SYSDATE
     WHERE gs.company_id = p_sgiob_rec.company_id
       AND gs.pro_supplier_code = p_sgiob_rec.pro_supplier_code
       AND gs.mater_supplier_code = p_sgiob_rec.mater_supplier_code
       AND gs.material_spu = p_sgiob_rec.material_spu
       AND gs.unit = p_sgiob_rec.unit
       AND gs.whether_del = 0;
  END p_generate_grey_stock;

  --物料供应商 更新【供应商库存-坯布仓库存明细】相应数据
  PROCEDURE p_generate_material_grey_stock(p_mgiob_rec   mrp.material_grey_in_out_bound%ROWTYPE,
                                           p_inout_stock NUMBER,
                                           p_user_id     VARCHAR2) IS
  
  BEGIN
    UPDATE mrp.material_grey_stock gs
       SET gs.total_stock = (CASE
                              WHEN p_mgiob_rec.ascription = 1 THEN
                               gs.total_stock + p_inout_stock --入库
                              WHEN p_mgiob_rec.ascription = 0 THEN
                               gs.total_stock - p_inout_stock --出库
                              ELSE
                               0
                            END),
           gs.brand_stock = (CASE
                            --品牌仓
                              WHEN p_mgiob_rec.stock_type = 1 THEN
                               (CASE
                                 WHEN p_mgiob_rec.ascription = 1 THEN
                                  gs.brand_stock + p_inout_stock --入库
                                 WHEN p_mgiob_rec.ascription = 0 THEN
                                  gs.brand_stock - p_inout_stock --出库
                                 ELSE
                                  0
                               END)
                            --供应商仓
                              WHEN p_mgiob_rec.stock_type = 2 THEN
                               gs.brand_stock
                              ELSE
                               0
                            END),
           gs.supplier_stock = (CASE
                               --品牌仓
                                 WHEN p_mgiob_rec.stock_type = 1 THEN
                                  gs.supplier_stock
                               --供应商仓
                                 WHEN p_mgiob_rec.stock_type = 2 THEN
                                  (CASE
                                    WHEN p_mgiob_rec.ascription = 1 THEN
                                     gs.supplier_stock + p_inout_stock --入库
                                    WHEN p_mgiob_rec.ascription = 0 THEN
                                     gs.supplier_stock - p_inout_stock --出库
                                    ELSE
                                     0
                                  END)
                                 ELSE
                                  0
                               END),
           gs.update_id      = p_user_id,
           gs.update_time    = SYSDATE
     WHERE gs.company_id = p_mgiob_rec.company_id
       AND gs.mater_supplier_code = p_mgiob_rec.mater_supplier_code
       AND gs.material_spu = p_mgiob_rec.material_spu
       AND gs.unit = p_mgiob_rec.unit
       AND gs.whether_del = 0;
  END p_generate_material_grey_stock;

  --取消备料单
  PROCEDURE p_cancle_color_prepare_order(p_prepare_order_id   VARCHAR2,
                                         p_cancel_reason      VARCHAR2,
                                         p_company_id         VARCHAR2,
                                         p_operate_company_id VARCHAR2,
                                         p_user_id            VARCHAR2) IS
  BEGIN
    --数据校验
    --备料状态
    mrp.pkg_color_prepare_order.p_check_prepare_status(p_prepare_order_id => p_prepare_order_id,
                                                       p_prepare_status   => 1);
    --取消原因
    mrp.pkg_color_prepare_order.p_check_cancel_reason(p_cancel_reason => p_cancel_reason);
  
    --单据变更溯源
    scmdata.pkg_plat_log.p_document_change_trace(p_company_id              => p_company_id,
                                                 p_document_id             => p_prepare_order_id,
                                                 p_data_source_parent_code => 'PREMATERIAL_MANA_LOG',
                                                 p_data_source_child_code  => '01',
                                                 p_operate_company_id      => p_operate_company_id,
                                                 p_user_id                 => p_user_id);
  
    --取消备料单
    mrp.pkg_color_prepare_order.p_update_color_prepare_order_status(p_prepare_order_id => p_prepare_order_id,
                                                                    p_cancel_reason    => p_cancel_reason,
                                                                    p_user_id          => p_user_id);
  
  END p_cancle_color_prepare_order;

  --修改订单数量
  PROCEDURE p_update_order_num(p_prepare_order_id   VARCHAR2,
                               p_order_num          VARCHAR2,
                               p_company_id         VARCHAR2,
                               p_operate_company_id VARCHAR2,
                               p_user_id            VARCHAR2) IS
  BEGIN
    --数据校验
    --备料状态
    mrp.pkg_color_prepare_order.p_check_prepare_status(p_prepare_order_id => p_prepare_order_id,
                                                       p_prepare_status   => 1);
    --订单数量
    mrp.pkg_color_prepare_order.p_check_order_num(p_prepare_order_id => p_prepare_order_id,
                                                  p_order_num        => p_order_num);
  
    --单据变更溯源
    scmdata.pkg_plat_log.p_document_change_trace(p_company_id              => p_company_id,
                                                 p_document_id             => p_prepare_order_id,
                                                 p_data_source_parent_code => 'PREMATERIAL_MANA_LOG',
                                                 p_data_source_child_code  => '02',
                                                 p_operate_company_id      => p_operate_company_id,
                                                 p_user_id                 => p_user_id);
  
    UPDATE mrp.color_prepare_order t
       SET t.order_num   = to_number(p_order_num),
           t.update_id   = p_user_id,
           t.update_time = SYSDATE
     WHERE t.prepare_order_id = p_prepare_order_id;
  END p_update_order_num;

  --修改预计到仓日期
  PROCEDURE p_update_expect_arrival_time(p_prepare_order_id    VARCHAR2,
                                         p_prepare_status      INT,
                                         p_expect_arrival_time DATE,
                                         p_company_id          VARCHAR2,
                                         p_operate_company_id  VARCHAR2,
                                         p_user_id             VARCHAR2) IS
  BEGIN
    --数据校验
    --备料状态
    mrp.pkg_color_prepare_order.p_check_prepare_status(p_prepare_order_id => p_prepare_order_id,
                                                       p_prepare_status   => p_prepare_status);
    --预计到仓日期
    mrp.pkg_color_prepare_order.p_check_expect_arrival_time(p_prepare_order_id    => p_prepare_order_id,
                                                            p_expect_arrival_time => to_char(p_expect_arrival_time,
                                                                                             'yyyy-mm-dd'));
  
    --单据变更溯源
    scmdata.pkg_plat_log.p_document_change_trace(p_company_id              => p_company_id,
                                                 p_document_id             => p_prepare_order_id,
                                                 p_data_source_parent_code => 'PREMATERIAL_MANA_LOG',
                                                 p_data_source_child_code  => '04',
                                                 p_operate_company_id      => p_operate_company_id,
                                                 p_user_id                 => p_user_id);
  
    UPDATE mrp.color_prepare_order t
       SET t.expect_arrival_time = to_date(to_char(p_expect_arrival_time,
                                                   'yyyy-mm-dd') ||
                                           ' 12:00:00',
                                           'yyyy-mm-dd hh:mi:ss'),
           t.expect_update_num   = t.expect_update_num + 1,
           t.update_id           = p_user_id,
           t.update_time         = SYSDATE
     WHERE t.prepare_order_id = p_prepare_order_id;
  END p_update_expect_arrival_time;

  --生产单逻辑
  --取消订单
  PROCEDURE p_cancel_product_order(p_product_order_id   VARCHAR2,
                                   p_cancel_reason      VARCHAR2,
                                   p_company_id         VARCHAR2,
                                   p_operate_company_id VARCHAR2,
                                   p_user_id            VARCHAR2) IS
  BEGIN
    --数据校验
    --生产单状态
    mrp.pkg_color_prepare_product_order.p_check_product_status(p_product_order_id => p_product_order_id,
                                                               p_product_status   => 1);
    --取消原因
    mrp.pkg_color_prepare_order.p_check_cancel_reason(p_cancel_reason => p_cancel_reason);
  
    --单据变更溯源
    scmdata.pkg_plat_log.p_document_change_trace(p_company_id              => p_company_id,
                                                 p_document_id             => p_product_order_id,
                                                 p_data_source_parent_code => 'PREMATERIAL_MANA_LOG',
                                                 p_data_source_child_code  => '05',
                                                 p_operate_company_id      => p_operate_company_id,
                                                 p_user_id                 => p_user_id);
  
    --取消生产单
    UPDATE mrp.color_prepare_product_order t
       SET t.product_status = 3,
           t.cancel_id      = p_user_id,
           t.cancel_time    = SYSDATE,
           t.cancel_reason  = p_cancel_reason
     WHERE t.product_order_id = p_product_order_id;
  
    --取消备料单
    FOR cpo_rec IN (SELECT po.prepare_order_id
                      FROM mrp.color_prepare_order po
                     WHERE po.product_order_id = p_product_order_id) LOOP
    
      --单据变更溯源
      scmdata.pkg_plat_log.p_document_change_trace(p_company_id              => p_company_id,
                                                   p_document_id             => cpo_rec.prepare_order_id,
                                                   p_data_source_parent_code => 'PREMATERIAL_MANA_LOG',
                                                   p_data_source_child_code  => '05',
                                                   p_operate_company_id      => p_operate_company_id,
                                                   p_user_id                 => p_user_id);
    
      mrp.pkg_color_prepare_order.p_update_color_prepare_order_status(p_prepare_order_id => cpo_rec.prepare_order_id,
                                                                      p_cancel_reason    => p_cancel_reason,
                                                                      p_user_id          => p_user_id);
    END LOOP;
  END p_cancel_product_order;

  --完成订单
  PROCEDURE p_finish_product_order(p_product_order_id     VARCHAR2,
                                   p_cur_finished_num     VARCHAR2,
                                   p_is_finished_preorder NUMBER,
                                   p_company_id           VARCHAR2,
                                   p_operate_company_id   VARCHAR2,
                                   p_user_id              VARCHAR2) IS
    v_cppo_rec               mrp.color_prepare_product_order%ROWTYPE;
    v_batch_finish_num       NUMBER; --分批完成数
    v_batch_finish_percent   NUMBER; --分批完成百分比
    v_batch_finish_percent_d NUMBER; --分批完成百分比 小数
  BEGIN
    SELECT *
      INTO v_cppo_rec
      FROM mrp.color_prepare_product_order t
     WHERE t.product_order_id = p_product_order_id;
  
    --校验生产单状态
    mrp.pkg_color_prepare_product_order.p_check_product_status(p_product_order_id => p_product_order_id,
                                                               p_product_status   => 1);
    --数据校验
    mrp.pkg_color_prepare_product_order.p_check_cur_finished_num(p_cur_finished_num => p_cur_finished_num);
    mrp.pkg_color_prepare_product_order.p_check_is_finished_preorder(p_is_finished_preorder => p_is_finished_preorder);
    --溢短装±3% 校验
    mrp.pkg_color_prepare_product_order.p_check_more_less_clause(p_cur_finished_num     => p_cur_finished_num,
                                                                 p_finished_num         => v_cppo_rec.batch_finish_num,
                                                                 p_order_num            => v_cppo_rec.plan_product_quantity,
                                                                 p_rate                 => 0.03,
                                                                 p_is_finished_preorder => p_is_finished_preorder);
    --校验通过，则落以下表
    --1.色布备料分批完成单表
    DECLARE
      v_cpbfo_rec mrp.color_prepare_batch_finish_order%ROWTYPE;
    BEGIN
      v_cpbfo_rec.prepare_batch_finish_id := mrp.pkg_plat_comm.f_get_docuno(pi_table_name  => 'COLOR_PREPARE_BATCH_FINISH_ORDER',
                                                                            pi_column_name => 'PREPARE_BATCH_FINISH_ID',
                                                                            pi_pre         => p_product_order_id,
                                                                            pi_serail_num  => 2); --色布分批完成单号
      v_cpbfo_rec.product_order_id        := p_product_order_id; --色布生产单号
      v_cpbfo_rec.batch_finish_time       := SYSDATE; --分批完成时间
      v_cpbfo_rec.unit                    := v_cppo_rec.unit; --单位
      v_cpbfo_rec.batch_finish_num        := to_number(p_cur_finished_num); --分批完成数量
      v_cpbfo_rec.batch_finish_percent    := round(to_number(p_cur_finished_num) /
                                                   v_cppo_rec.plan_product_quantity,
                                                   4) * 100; --分批完成百分比  ps:暂时与plm统一百分比格式
      v_cpbfo_rec.batch_finish_id         := p_user_id; --分批完成人
      v_cpbfo_rec.create_id               := p_user_id; --创建者
      v_cpbfo_rec.create_time             := SYSDATE; --创建时间
      v_cpbfo_rec.update_id               := p_user_id; --更新者
      v_cpbfo_rec.update_time             := SYSDATE; --更新时间
      v_cpbfo_rec.whether_del             := 0; --是否删除，0否1是
    
      mrp.pkg_color_prepare_batch_finish_order.p_insert_color_prepare_batch_finish_order(p_color_rec => v_cpbfo_rec);
    END;
  
    --分批完成数
    v_batch_finish_num := v_cppo_rec.batch_finish_num + p_cur_finished_num;
    --分批完成累计百分比
    v_batch_finish_percent := round((v_batch_finish_num) /
                                    v_cppo_rec.plan_product_quantity,
                                    4) * 100;
  
    v_batch_finish_percent_d := v_batch_finish_percent / 100;
  
    --2.修改色布备料生产单表相关数据   
    BEGIN
      IF p_is_finished_preorder = 1 THEN
        v_cppo_rec.product_status := 2; --生产单状态，1生产中，2已完成，3已取消
        v_cppo_rec.finish_id      := p_user_id; --总完成人
        v_cppo_rec.finish_num     := v_batch_finish_num; --总完成数量
        v_cppo_rec.finish_time    := SYSDATE; --总完成日期
        v_cppo_rec.complete_num   := 0; --待完成数量
      
      ELSE
        v_cppo_rec.complete_num := v_cppo_rec.plan_product_quantity -
                                   v_batch_finish_num; --待完成数量
      END IF;
    
      v_cppo_rec.batch_finish_num     := v_batch_finish_num; --分批完成累计数量   
      v_cppo_rec.batch_finish_percent := v_batch_finish_percent; --分批完成累计百分比
      v_cppo_rec.update_id            := p_user_id; --更新者
      v_cppo_rec.update_time          := SYSDATE; --更新时间
    
      --单据变更溯源
      scmdata.pkg_plat_log.p_document_change_trace(p_company_id              => p_company_id,
                                                   p_document_id             => p_product_order_id,
                                                   p_data_source_parent_code => 'PREMATERIAL_MANA_LOG',
                                                   p_data_source_child_code  => '06',
                                                   p_operate_company_id      => p_operate_company_id,
                                                   p_user_id                 => p_user_id);
    
      mrp.pkg_color_prepare_product_order.p_update_color_prepare_product_order(p_color_rec => v_cppo_rec);
    END;
    --3.色布备料单表
    --当【是否完成备料单表】=是时，则落表
    --否则，不作处理
    BEGIN
      FOR cpo_rec IN (SELECT *
                        FROM mrp.color_prepare_order t
                       WHERE t.product_order_id = p_product_order_id) LOOP
        IF p_is_finished_preorder = 1 THEN
          cpo_rec.prepare_status := 3; --备料状态，0待审核，1待接单，2生产中，3已完成，4已取消
          cpo_rec.finish_id      := p_user_id; --完成人
          cpo_rec.finish_num     := v_batch_finish_percent_d *
                                    cpo_rec.order_num; --完成数量
          cpo_rec.finish_time    := SYSDATE; --完成日期
        
          --单据变更溯源
          scmdata.pkg_plat_log.p_document_change_trace(p_company_id              => p_company_id,
                                                       p_document_id             => cpo_rec.prepare_order_id,
                                                       p_data_source_parent_code => 'PREMATERIAL_MANA_LOG',
                                                       p_data_source_child_code  => '06',
                                                       p_operate_company_id      => p_operate_company_id,
                                                       p_user_id                 => p_user_id);
        ELSE
          NULL;
        END IF;
        cpo_rec.batch_finish_num     := v_batch_finish_percent_d *
                                        cpo_rec.order_num; --分批完成累计数量
        cpo_rec.batch_finish_percent := v_batch_finish_percent; --分批完成累计百分比
        cpo_rec.complete_num         := cpo_rec.order_num *
                                        (1 - v_batch_finish_percent_d); --待完成数量
      
        cpo_rec.update_id   := p_user_id; --更新者
        cpo_rec.update_time := SYSDATE; --更新时间   
        mrp.pkg_color_prepare_order.p_update_color_prepare_order(p_color_rec => cpo_rec);
      END LOOP;
    END;
    --4.根据【备料对象】(0成品供应商，1物料供应商)，进行落表（色布出入库单表、色布仓库存明细）
    DECLARE
      vo_bound_num VARCHAR2(32);
      v_sciob_rec  mrp.supplier_color_in_out_bound%ROWTYPE;
      v_mciob_rec  mrp.material_color_in_out_bound%ROWTYPE;
    BEGIN
      IF v_cppo_rec.prepare_object = 0 THEN
        --4.1 色布入库
        p_color_cloth_storage(p_cppo_rec   => v_cppo_rec,
                              p_company_id => p_company_id,
                              p_user_id    => p_user_id,
                              p_batch_num  => v_batch_finish_num,
                              po_bound_num => vo_bound_num);
        --4.2 色布仓库存明细
        SELECT *
          INTO v_sciob_rec
          FROM mrp.supplier_color_in_out_bound t
         WHERE t.bound_num = vo_bound_num;
      
        p_sync_supplier_color_cloth_stock(p_sciob_rec  => v_sciob_rec,
                                          p_company_id => p_company_id,
                                          p_user_id    => p_user_id);
      ELSIF v_cppo_rec.prepare_object = 1 THEN
        --4.3 色布入库
        p_material_color_cloth_storage(p_cppo_rec   => v_cppo_rec,
                                       p_company_id => p_company_id,
                                       p_user_id    => p_user_id,
                                       p_batch_num  => v_batch_finish_num,
                                       po_bound_num => vo_bound_num);
        --4.4 色布仓库存明细
        SELECT *
          INTO v_mciob_rec
          FROM mrp.material_color_in_out_bound t
         WHERE t.bound_num = vo_bound_num;
      
        p_sync_material_color_cloth_stock(p_mciob_rec  => v_mciob_rec,
                                          p_company_id => p_company_id,
                                          p_user_id    => p_user_id);
      ELSE
        NULL;
      END IF;
    END;
  END p_finish_product_order;

  --成品供应商 色布入库
  PROCEDURE p_color_cloth_storage(p_cppo_rec   mrp.color_prepare_product_order%ROWTYPE,
                                  p_company_id VARCHAR2,
                                  p_user_id    VARCHAR2,
                                  p_batch_num  NUMBER,
                                  po_bound_num OUT VARCHAR2) IS
    v_sciob_rec supplier_color_in_out_bound%ROWTYPE;
    v_bound_num VARCHAR2(32);
  BEGIN
    v_bound_num                     := mrp.pkg_plat_comm.f_get_docuno(pi_table_name  => 'SUPPLIER_COLOR_IN_OUT_BOUND',
                                                                      pi_column_name => 'BOUND_NUM',
                                                                      pi_pre         => 'CKRK' ||
                                                                                        to_char(trunc(SYSDATE),
                                                                                                'YYYYMMDD'),
                                                                      pi_serail_num  => 5);
    v_sciob_rec.bound_num           := v_bound_num; --色布出入库单号
    v_sciob_rec.ascription          := 1; --出入库归属，0出库1入库
    v_sciob_rec.bound_type          := 10; --出入库类型，1订单出库，2盘亏出库，3领料出库，10品牌备料入库，11供应商现货入库，12临时补充入库，13盘盈入库，14临时坯转色入库 15 供应商色布入库 16 供应商现货出库
    v_sciob_rec.pro_supplier_code   := p_cppo_rec.pro_supplier_code; --成品供应商编号
    v_sciob_rec.mater_supplier_code := p_cppo_rec.mater_supplier_code; --物料供应商编号
    v_sciob_rec.material_sku        := p_cppo_rec.material_sku; --物料SKU
    v_sciob_rec.whether_inner_mater := p_cppo_rec.whether_inner_mater; --是否内部物料，0否1是
    v_sciob_rec.unit                := p_cppo_rec.unit; --单位
    v_sciob_rec.num                 := p_batch_num; --数量 
    v_sciob_rec.stock_type          := 1; --仓库类型，1品牌仓，2供应商仓
    v_sciob_rec.relate_num          := p_cppo_rec.product_order_id; --关联单号
    v_sciob_rec.relate_num_type     := 1; --关联单号类型，1色布生产单/2色布盘点单/3色布领料单/4面料采购单/5坯布出库单
    v_sciob_rec.relate_skc          := p_cppo_rec.relate_skc; --关联SKC
    v_sciob_rec.relate_purchase     := NULL; --关联采购单号
    v_sciob_rec.company_id          := p_company_id; --企业编码
    v_sciob_rec.create_id           := p_user_id; --创建者
    v_sciob_rec.create_time         := SYSDATE; --创建时间
    v_sciob_rec.update_id           := p_user_id; --更新者
    v_sciob_rec.update_time         := SYSDATE; --更新时间
    v_sciob_rec.whether_del         := 0; --是否删除，0否1是
  
    mrp.pkg_supplier_color_in_out_bound.p_insert_supplier_color_in_out_bound(p_suppl_rec => v_sciob_rec);
  
    po_bound_num := v_bound_num;
  END p_color_cloth_storage;

  --物料供应商 色布入库
  PROCEDURE p_material_color_cloth_storage(p_cppo_rec   mrp.color_prepare_product_order%ROWTYPE,
                                           p_company_id VARCHAR2,
                                           p_user_id    VARCHAR2,
                                           p_batch_num  NUMBER,
                                           po_bound_num OUT VARCHAR2) IS
    v_mciob_rec material_color_in_out_bound%ROWTYPE;
    v_bound_num VARCHAR2(32);
  BEGIN
    v_bound_num                     := mrp.pkg_plat_comm.f_get_docuno(pi_table_name  => 'MATERIAL_COLOR_IN_OUT_BOUND',
                                                                      pi_column_name => 'BOUND_NUM',
                                                                      pi_pre         => 'WKRK' ||
                                                                                        to_char(trunc(SYSDATE),
                                                                                                'YYYYMMDD'),
                                                                      pi_serail_num  => 5);
    v_mciob_rec.bound_num           := v_bound_num; --色布出入库单号
    v_mciob_rec.ascription          := 1; --出入库归属，0出库1入库
    v_mciob_rec.bound_type          := 10; --出入库类型，1订单出库，2盘亏出库，3领料出库，10品牌备料入库，11供应商现货入库，12临时补充入库，13盘盈入库，14临时坯转色入库 15 供应商色布入库 16 供应商现货出库
    v_mciob_rec.mater_supplier_code := p_cppo_rec.mater_supplier_code; --物料供应商编号
    v_mciob_rec.material_sku        := p_cppo_rec.material_sku; --物料SKU
    v_mciob_rec.unit                := p_cppo_rec.unit; --单位
    v_mciob_rec.num                 := p_batch_num; --数量
    v_mciob_rec.stock_type          := 1; --仓库类型，1品牌仓，2供应商仓
    v_mciob_rec.relate_num          := p_cppo_rec.product_order_id; --关联单号
    v_mciob_rec.relate_num_type     := 1; --关联单号类型，1色布生产单/2色布盘点单/3色布领料单/4面料采购单/5坯布出库单
    v_mciob_rec.relate_skc          := p_cppo_rec.relate_skc; --关联SKC
    v_mciob_rec.relate_purchase     := NULL; --关联采购单号
    v_mciob_rec.company_id          := p_company_id; --企业编码
    v_mciob_rec.create_id           := p_user_id; --创建者
    v_mciob_rec.create_time         := SYSDATE; --创建时间
    v_mciob_rec.update_id           := p_user_id; --更新者
    v_mciob_rec.update_time         := SYSDATE; --更新时间
    v_mciob_rec.whether_del         := 0; --是否删除，0否1是
    v_mciob_rec.whether_inner_mater := p_cppo_rec.whether_inner_mater; --是否内部物料，0否1是
  
    mrp.pkg_material_color_in_out_bound.p_insert_material_color_in_out_bound(p_mater_rec => v_mciob_rec);
  
    po_bound_num := v_bound_num;
  END p_material_color_cloth_storage;

  --是否找到色布库存
  --区分备料对象 
  --p_prepare_object：0 成品供应商 1 物料供应商
  FUNCTION f_is_find_color_stock(p_pro_supplier_code   VARCHAR2 DEFAULT NULL,
                                 p_mater_supplier_code VARCHAR2,
                                 p_material_sku        VARCHAR2,
                                 p_unit                VARCHAR2,
                                 p_prepare_object      INT) RETURN NUMBER IS
    v_cnt NUMBER := 0;
  BEGIN
    IF p_prepare_object = 0 THEN
      SELECT COUNT(1)
        INTO v_cnt
        FROM mrp.supplier_color_cloth_stock t
       WHERE t.pro_supplier_code = p_pro_supplier_code
         AND t.mater_supplier_code = p_mater_supplier_code
         AND t.material_sku = p_material_sku
         AND t.unit = p_unit;
    ELSIF p_prepare_object = 1 THEN
      SELECT COUNT(1)
        INTO v_cnt
        FROM mrp.material_color_cloth_stock t
       WHERE t.mater_supplier_code = p_mater_supplier_code
         AND t.material_sku = p_material_sku
         AND t.unit = p_unit;
    ELSE
      NULL;
    END IF;
    RETURN v_cnt;
  END f_is_find_color_stock;

  --成品供应商 色布仓库存
  PROCEDURE p_sync_supplier_color_cloth_stock(p_sciob_rec  mrp.supplier_color_in_out_bound%ROWTYPE,
                                              p_company_id VARCHAR2,
                                              p_user_id    VARCHAR2) IS
    v_sccs_rec supplier_color_cloth_stock%ROWTYPE;
    v_flag     INT;
  BEGIN
    --是否找到色布库存
    v_flag := f_is_find_color_stock(p_pro_supplier_code   => p_sciob_rec.pro_supplier_code,
                                    p_mater_supplier_code => p_sciob_rec.mater_supplier_code,
                                    p_material_sku        => p_sciob_rec.material_sku,
                                    p_unit                => p_sciob_rec.unit,
                                    p_prepare_object      => 0);
    IF v_flag > 0 THEN
      UPDATE mrp.supplier_color_cloth_stock t
         SET t.total_stock = nvl(t.total_stock, 0) + nvl(p_sciob_rec.num, 0),
             t.brand_stock = nvl(t.brand_stock, 0) + nvl(p_sciob_rec.num, 0),
             t.update_id   = p_user_id,
             t.update_time = SYSDATE
       WHERE t.pro_supplier_code = p_sciob_rec.pro_supplier_code
         AND t.mater_supplier_code = p_sciob_rec.mater_supplier_code
         AND t.material_sku = p_sciob_rec.material_sku
         AND t.unit = p_sciob_rec.unit;
    ELSE
      v_sccs_rec.color_cloth_stock_id := mrp.pkg_plat_comm.f_get_uuid(); --供应商色布库存主键
      v_sccs_rec.pro_supplier_code    := p_sciob_rec.pro_supplier_code; --成品供应商编号
      v_sccs_rec.mater_supplier_code  := p_sciob_rec.mater_supplier_code; --物料供应商编号
      v_sccs_rec.material_sku         := p_sciob_rec.material_sku; --物料SKU
      v_sccs_rec.whether_inner_mater  := p_sciob_rec.whether_inner_mater; --是否内部物料，0否1是
      v_sccs_rec.unit                 := p_sciob_rec.unit; --单位
      v_sccs_rec.total_stock          := nvl(v_sccs_rec.total_stock, 0) +
                                         nvl(p_sciob_rec.num, 0); --总库存数
      v_sccs_rec.brand_stock          := nvl(v_sccs_rec.brand_stock, 0) +
                                         nvl(p_sciob_rec.num, 0); --品牌仓库存数
      v_sccs_rec.supplier_stock       := 0; --供应商仓库存数
      v_sccs_rec.company_id           := p_company_id; --企业编码
      v_sccs_rec.create_id            := p_user_id; --创建者
      v_sccs_rec.create_time          := SYSDATE; --创建时间
      v_sccs_rec.update_id            := p_user_id; --更新者
      v_sccs_rec.update_time          := SYSDATE; --更新时间
      v_sccs_rec.whether_del          := 0; --是否删除，0否1是
    
      mrp.pkg_supplier_color_cloth_stock.p_insert_supplier_color_cloth_stock(p_suppl_rec => v_sccs_rec);
    END IF;
  END p_sync_supplier_color_cloth_stock;

  --物料供应商 色布仓库存
  PROCEDURE p_sync_material_color_cloth_stock(p_mciob_rec  mrp.material_color_in_out_bound%ROWTYPE,
                                              p_company_id VARCHAR2,
                                              p_user_id    VARCHAR2) IS
    v_mccs_rec material_color_cloth_stock%ROWTYPE;
    v_flag     INT;
  BEGIN
    --是否找到色布库存
    v_flag := f_is_find_color_stock(p_mater_supplier_code => p_mciob_rec.mater_supplier_code,
                                    p_material_sku        => p_mciob_rec.material_sku,
                                    p_unit                => p_mciob_rec.unit,
                                    p_prepare_object      => 1);
    IF v_flag > 0 THEN
      UPDATE mrp.material_color_cloth_stock t
         SET t.total_stock = nvl(t.total_stock, 0) + nvl(p_mciob_rec.num, 0),
             t.brand_stock = nvl(t.brand_stock, 0) + nvl(p_mciob_rec.num, 0),
             t.update_id   = p_user_id,
             t.update_time = SYSDATE
       WHERE t.mater_supplier_code = p_mciob_rec.mater_supplier_code
         AND t.material_sku = p_mciob_rec.material_sku
         AND t.unit = p_mciob_rec.unit;
    ELSE
      v_mccs_rec.color_cloth_stock_id := mrp.pkg_plat_comm.f_get_uuid(); --供应商色布库存主键
      v_mccs_rec.mater_supplier_code  := p_mciob_rec.mater_supplier_code; --物料供应商编号
      v_mccs_rec.material_sku         := p_mciob_rec.material_sku; --物料SKU
      v_mccs_rec.unit                 := p_mciob_rec.unit; --单位
      v_mccs_rec.total_stock          := nvl(v_mccs_rec.total_stock, 0) +
                                         nvl(p_mciob_rec.num, 0); --总库存数
      v_mccs_rec.brand_stock          := nvl(v_mccs_rec.brand_stock, 0) +
                                         nvl(p_mciob_rec.num, 0); --品牌仓库存数
      v_mccs_rec.supplier_stock       := 0; --供应商仓库存数
      v_mccs_rec.company_id           := p_company_id; --企业编码
      v_mccs_rec.create_id            := p_user_id; --创建者
      v_mccs_rec.create_time          := SYSDATE; --创建时间
      v_mccs_rec.update_id            := p_user_id; --更新者
      v_mccs_rec.update_time          := SYSDATE; --更新时间
      v_mccs_rec.whether_del          := 0; --是否删除，0否1是
    
      mrp.pkg_material_color_cloth_stock.p_insert_material_color_cloth_stock(p_mater_rec => v_mccs_rec);
    END IF;
  END p_sync_material_color_cloth_stock;

  --备料进度查询  
  FUNCTION f_query_prepare_order_process(p_order_num VARCHAR2) RETURN CLOB IS
    v_pick_sql     CLOB;
    v_purchase_sql CLOB;
    v_sql          CLOB;
  BEGIN
    v_pick_sql     := mrp.pkg_pick_list.f_query_pick_list(p_order_num => p_order_num);
    v_purchase_sql := mrp.pkg_t_fabric_purchase_sheet.f_query_t_fabric_purchase_sheet(p_order_num => p_order_num);
  
    v_sql := v_pick_sql || ' UNION ALL ' || v_purchase_sql;
    RETURN v_sql;
  END f_query_prepare_order_process;

  --备料状态同步至生产进度表
  PROCEDURE p_sync_prepare_status(p_order_num  VARCHAR2,
                                  p_company_id VARCHAR2) IS
    v_pcnt   INT;
    v_fcnt   INT;
    v_cnt    INT;
    v_status VARCHAR2(32);
  BEGIN
    SELECT COUNT(1)
      INTO v_pcnt
      FROM mrp.pick_list t
     WHERE t.relate_product_order_num = p_order_num;
  
    SELECT COUNT(1)
      INTO v_fcnt
      FROM mrp.t_fabric_purchase_sheet t
     WHERE t.purchase_order_num = p_order_num
       AND t.company_id = p_company_id;
  
    v_cnt := v_pcnt + v_fcnt;
  
    IF v_cnt = 0 THEN
      v_status := '00'; --无备料
    ELSE
      --领料单
      SELECT COUNT(1) cnt
        INTO v_pcnt
        FROM mrp.pick_list t
       WHERE t.relate_product_order_num = p_order_num
         AND t.pick_status = 0;
    
      --面料采购单
      SELECT SUM(va.cnt) cnt
        INTO v_fcnt
        FROM (SELECT COUNT(1) cnt
                FROM mrp.t_fabric_purchase_sheet t
               WHERE t.purchase_order_num = p_order_num
                 AND t.fabric_status IN ('S00', 'S01', 'S02', 'S03')) va;
    
      v_cnt := v_pcnt + v_fcnt;
    
      IF v_cnt > 0 THEN
        v_status := '01'; --未完成
      ELSE
        v_status := '02'; --已完成
      END IF;
    END IF;
  
    --将备料状态同步至生产进度表
    UPDATE scmdata.t_production_progress t
       SET t.prepare_status = v_status
     WHERE t.product_gress_code = p_order_num
       AND t.company_id = p_company_id;
  
  END p_sync_prepare_status;
END pkg_color_prepare_order_manager;
/

