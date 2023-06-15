CREATE OR REPLACE PACKAGE MRP.pkg_t_fabric_purchase_sheet IS

  -- Author  : CZH55
  -- Created : 2023/4/25 17:39:55
  -- Purpose : 面料采购单管理-基础程序包

  --查询 T_FABRIC_PURCHASE_SHEET
  FUNCTION f_query_t_fabric_purchase_sheet(p_order_num VARCHAR2) RETURN CLOB;

  --新增 T_FABRIC_PURCHASE_SHEET
  PROCEDURE p_insert_t_fabric_purchase_sheet(p_t_fab_rec t_fabric_purchase_sheet%ROWTYPE);

  --修改 T_FABRIC_PURCHASE_SHEET
  PROCEDURE p_update_t_fabric_purchase_sheet(p_t_fab_rec t_fabric_purchase_sheet%ROWTYPE);

  --删除 T_FABRIC_PURCHASE_SHEET
  PROCEDURE p_delete_t_fabric_purchase_sheet(p_t_fab_rec t_fabric_purchase_sheet%ROWTYPE);

END pkg_t_fabric_purchase_sheet;
/

CREATE OR REPLACE PACKAGE BODY MRP.pkg_t_fabric_purchase_sheet IS
  --查询 T_FABRIC_PURCHASE_SHEET
  FUNCTION f_query_t_fabric_purchase_sheet(p_order_num VARCHAR2) RETURN CLOB IS
    v_sql CLOB;
  BEGIN
    v_sql := q'[
SELECT *
  FROM (SELECT tc.colorname bl_colorname_n, --颜色
               gd.group_dict_name bl_status_n, --采购状态(待下单:s00/待接单:s01/待发货:s02/待收货:s03/已收货:s04/已取消:s05) 
               t.goods_skc bl_relate_skc_n, --关联SKC              
               t.supplier_material_name bl_sup_material_name_n, --供应商物料名称                
               t.material_sku bl_material_sku_n, --物料sku                
               sa.supplier_name bl_mater_supplier_name_n, --物料供应商             
               t.supplier_color bl_supplier_color_n, --供应商颜色 
               t.supplier_shades bl_supplier_shades_n, --供应商色号 
               '面料采购单' bl_type_n,
               t.fabric_id bl_relate_code_n --面料采购单号 
          FROM mrp.t_fabric_purchase_sheet t
          LEFT JOIN scmdata.t_commodity_color tc
            ON tc.commodity_color_code = t.goods_skc
           AND tc.company_id = t.company_id
          LEFT JOIN scmdata.sys_group_dict gd
            ON gd.group_dict_type = 'PURCHASE_STATUS'
           AND gd.group_dict_value = t.fabric_status
          LEFT JOIN mrp.mrp_determine_supplier_archives sa
            ON sa.supplier_code = t.mater_supplier_code
           AND sa.company_id = t.company_id
         WHERE t.purchase_order_num = ']' || p_order_num || q'['
         ORDER BY t.goods_skc ASC) va
]';
    RETURN v_sql;
  END f_query_t_fabric_purchase_sheet;

  --新增 T_FABRIC_PURCHASE_SHEET
  PROCEDURE p_insert_t_fabric_purchase_sheet(p_t_fab_rec t_fabric_purchase_sheet%ROWTYPE) IS
  BEGIN
  
    INSERT INTO t_fabric_purchase_sheet
      (fabric_purchase_sheet_id, company_id, fabric_id, fabric_status,
       fabric_source, pro_supplier_code, material_sku, mater_supplier_code,
       whether_inner_mater, unit, purchase_skc_order_amount,
       suggest_pick_amount, actual_pick_amount, already_deliver_amount,
       not_deliver_amount, delivery_amount, purchase_order_num, goods_skc,
       bulk_cargo_bom_id, material_detail_id, material_spu, features,
       material_name, ingredients, practical_door_with, gram_weight,
       material_specifications, color_picture, material_color,
       preferred_net_price_of_large_good,
       preferred_per_meter_price_of_large_good, benchmark_price,
       sku_abutment_code, supplier_material_name, color_card_picture,
       supplier_color, supplier_shades, optimization, disparity,
       supplier_large_good_quote, supplier_large_good_net_price, create_id,
       create_time, order_id, order_time, receive_order_id,
       receive_order_time, send_order_id, send_order_time, cancel_id,
       cancel_time, cancel_cause, remarks, update_id, update_time, group_key)
    VALUES
      (p_t_fab_rec.fabric_purchase_sheet_id, p_t_fab_rec.company_id,
       p_t_fab_rec.fabric_id, p_t_fab_rec.fabric_status,
       p_t_fab_rec.fabric_source, p_t_fab_rec.pro_supplier_code,
       p_t_fab_rec.material_sku, p_t_fab_rec.mater_supplier_code,
       p_t_fab_rec.whether_inner_mater, p_t_fab_rec.unit,
       p_t_fab_rec.purchase_skc_order_amount,
       p_t_fab_rec.suggest_pick_amount, p_t_fab_rec.actual_pick_amount,
       p_t_fab_rec.already_deliver_amount, p_t_fab_rec.not_deliver_amount,
       p_t_fab_rec.delivery_amount, p_t_fab_rec.purchase_order_num,
       p_t_fab_rec.goods_skc, p_t_fab_rec.bulk_cargo_bom_id,
       p_t_fab_rec.material_detail_id, p_t_fab_rec.material_spu,
       p_t_fab_rec.features, p_t_fab_rec.material_name,
       p_t_fab_rec.ingredients, p_t_fab_rec.practical_door_with,
       p_t_fab_rec.gram_weight, p_t_fab_rec.material_specifications,
       p_t_fab_rec.color_picture, p_t_fab_rec.material_color,
       p_t_fab_rec.preferred_net_price_of_large_good,
       p_t_fab_rec.preferred_per_meter_price_of_large_good,
       p_t_fab_rec.benchmark_price, p_t_fab_rec.sku_abutment_code,
       p_t_fab_rec.supplier_material_name, p_t_fab_rec.color_card_picture,
       p_t_fab_rec.supplier_color, p_t_fab_rec.supplier_shades,
       p_t_fab_rec.optimization, p_t_fab_rec.disparity,
       p_t_fab_rec.supplier_large_good_quote,
       p_t_fab_rec.supplier_large_good_net_price, p_t_fab_rec.create_id,
       p_t_fab_rec.create_time, p_t_fab_rec.order_id, p_t_fab_rec.order_time,
       p_t_fab_rec.receive_order_id, p_t_fab_rec.receive_order_time,
       p_t_fab_rec.send_order_id, p_t_fab_rec.send_order_time,
       p_t_fab_rec.cancel_id, p_t_fab_rec.cancel_time,
       p_t_fab_rec.cancel_cause, p_t_fab_rec.remarks, p_t_fab_rec.update_id,
       p_t_fab_rec.update_time, p_t_fab_rec.group_key);
  END p_insert_t_fabric_purchase_sheet;

  --修改 T_FABRIC_PURCHASE_SHEET
  PROCEDURE p_update_t_fabric_purchase_sheet(p_t_fab_rec t_fabric_purchase_sheet%ROWTYPE) IS
  BEGIN
  
    UPDATE t_fabric_purchase_sheet t
       SET t.company_id                              = p_t_fab_rec.company_id, --企业ID
           t.fabric_id                               = p_t_fab_rec.fabric_id, --面料采购单号
           t.fabric_status                           = p_t_fab_rec.fabric_status, --采购状态(待下单:S00/待接单:S01/待发货:S02/待收货:S03/已收货:S04/已取消:S05)
           t.fabric_source                           = p_t_fab_rec.fabric_source, --采购单来源(品牌采购单:0/供应商自采:1/物料商发货:2)
           t.pro_supplier_code                       = p_t_fab_rec.pro_supplier_code, --成品供应商编号
           t.material_sku                            = p_t_fab_rec.material_sku, --物料SKU
           t.mater_supplier_code                     = p_t_fab_rec.mater_supplier_code, --物料供应商编号
           t.whether_inner_mater                     = p_t_fab_rec.whether_inner_mater, --是否内部物料,0否1是
           t.unit                                    = p_t_fab_rec.unit, --单位
           t.purchase_skc_order_amount               = p_t_fab_rec.purchase_skc_order_amount, --采购SKC订单量
           t.suggest_pick_amount                     = p_t_fab_rec.suggest_pick_amount, --建议采购量
           t.actual_pick_amount                      = p_t_fab_rec.actual_pick_amount, --实际采购量
           t.already_deliver_amount                  = p_t_fab_rec.already_deliver_amount, --已发货量
           t.not_deliver_amount                      = p_t_fab_rec.not_deliver_amount, --未发货量
           t.delivery_amount                         = p_t_fab_rec.delivery_amount, --已收货量
           t.purchase_order_num                      = p_t_fab_rec.purchase_order_num, --采购订单编号
           t.goods_skc                               = p_t_fab_rec.goods_skc, --货色SKC
           t.bulk_cargo_bom_id                       = p_t_fab_rec.bulk_cargo_bom_id, --大货BOMID
           t.material_detail_id                      = p_t_fab_rec.material_detail_id, --大货BOM物料明细
           t.material_spu                            = p_t_fab_rec.material_spu, --物料SPU
           t.features                                = p_t_fab_rec.features, --特征图
           t.material_name                           = p_t_fab_rec.material_name, --物料名称
           t.ingredients                             = p_t_fab_rec.ingredients, --物料成分
           t.practical_door_with                     = p_t_fab_rec.practical_door_with, --实用门幅
           t.gram_weight                             = p_t_fab_rec.gram_weight, --克重
           t.material_specifications                 = p_t_fab_rec.material_specifications, --物料规格
           t.color_picture                           = p_t_fab_rec.color_picture, --颜色图
           t.material_color                          = p_t_fab_rec.material_color, --物料颜色
           t.preferred_net_price_of_large_good       = p_t_fab_rec.preferred_net_price_of_large_good, --优选大货净价
           t.preferred_per_meter_price_of_large_good = p_t_fab_rec.preferred_per_meter_price_of_large_good, --优选大货米价
           t.benchmark_price                         = p_t_fab_rec.benchmark_price, --基准价
           t.sku_abutment_code                       = p_t_fab_rec.sku_abutment_code, --供应商物料SKU对接码
           t.supplier_material_name                  = p_t_fab_rec.supplier_material_name, --供应商物料名称
           t.color_card_picture                      = p_t_fab_rec.color_card_picture, --色卡图
           t.supplier_color                          = p_t_fab_rec.supplier_color, --供应商颜色
           t.supplier_shades                         = p_t_fab_rec.supplier_shades, --供应商色号
           t.optimization                            = p_t_fab_rec.optimization, --是否优选
           t.disparity                               = p_t_fab_rec.disparity, --空差
           t.supplier_large_good_quote               = p_t_fab_rec.supplier_large_good_quote, --供应商大货报价
           t.supplier_large_good_net_price           = p_t_fab_rec.supplier_large_good_net_price, --供应商大货净价
           t.create_id                               = p_t_fab_rec.create_id, --创建ID
           t.create_time                             = p_t_fab_rec.create_time, --创建时间
           t.order_id                                = p_t_fab_rec.order_id, --下单人ID
           t.order_time                              = p_t_fab_rec.order_time, --下单时间
           t.receive_order_id                        = p_t_fab_rec.receive_order_id, --接单人ID
           t.receive_order_time                      = p_t_fab_rec.receive_order_time, --接单时间
           t.send_order_id                           = p_t_fab_rec.send_order_id, --发货人ID
           t.send_order_time                         = p_t_fab_rec.send_order_time, --发货人时间
           t.cancel_id                               = p_t_fab_rec.cancel_id, --取消人ID
           t.cancel_time                             = p_t_fab_rec.cancel_time, --取消人时间
           t.cancel_cause                            = p_t_fab_rec.cancel_cause, --取消人原因
           t.remarks                                 = p_t_fab_rec.remarks, --备注
           t.update_id                               = p_t_fab_rec.update_id, --更新ID
           t.update_time                             = p_t_fab_rec.update_time, --更新时间
           t.group_key                               = p_t_fab_rec.group_key --
     WHERE t.fabric_purchase_sheet_id =
           p_t_fab_rec.fabric_purchase_sheet_id;
  END p_update_t_fabric_purchase_sheet;

  --删除 T_FABRIC_PURCHASE_SHEET
  PROCEDURE p_delete_t_fabric_purchase_sheet(p_t_fab_rec t_fabric_purchase_sheet%ROWTYPE) IS
  BEGIN
    DELETE FROM t_fabric_purchase_sheet t
     WHERE t.fabric_purchase_sheet_id =
           p_t_fab_rec.fabric_purchase_sheet_id;
  END p_delete_t_fabric_purchase_sheet;

END pkg_t_fabric_purchase_sheet;
/

