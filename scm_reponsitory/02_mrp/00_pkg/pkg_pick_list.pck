CREATE OR REPLACE PACKAGE MRP.pkg_pick_list IS

  -- Author  : CZH55
  -- Created : 2023/4/25 17:39:55
  -- Purpose : 领料单管理-基础程序包

  --查询 PICK_LIST
  FUNCTION f_query_pick_list(p_order_num VARCHAR2) RETURN CLOB;

  --新增 PICK_LIST
  PROCEDURE p_insert_pick_list(p_pick_rec pick_list%ROWTYPE);

  --修改 PICK_LIST
  PROCEDURE p_update_pick_list(p_pick_rec pick_list%ROWTYPE);

  --删除 PICK_LIST
  PROCEDURE p_delete_pick_list(p_pick_rec pick_list%ROWTYPE);

END pkg_pick_list;
/

CREATE OR REPLACE PACKAGE BODY MRP.pkg_pick_list IS
  --查询 PICK_LIST
  FUNCTION f_query_pick_list(p_order_num VARCHAR2) RETURN CLOB IS
    v_sql                 CLOB;
  BEGIN
    v_sql := q'[
SELECT *
  FROM (SELECT tc.colorname bl_colorname_n, --颜色
               gd.group_dict_name bl_status_n, --领料状态，0待完成，1已完成，2已取消
               t.relate_skc bl_relate_skc_n, --关联SKC
               bm.supplier_material_name bl_sup_material_name_n, --供应商物料名称 
               t.material_sku bl_material_sku_n, --物料sku 
               nvl(sa.supplier_name,sb.supplier_name) bl_mater_supplier_name_n, --物料供应商
               bm.supplier_color bl_supplier_color_n, --供应商颜色 
               bm.supplier_shades bl_supplier_shades_n, --供应商色号 
               '领料单' bl_type_n,
               t.pick_lict_code bl_relate_code_n --领料单号
          FROM mrp.pick_list t
          LEFT JOIN scmdata.t_commodity_color tc
            ON tc.commodity_color_code = t.relate_skc
          LEFT JOIN mrp.bulk_cargo_bom_material_detail bm
            ON bm.relate_develop_bom_material_detail_id =
               t.material_detail_id
           AND bm.bulk_cargo_bom_id = t.bulk_cargo_bom_id
          LEFT JOIN scmdata.sys_group_dict gd
            ON gd.group_dict_type = 'PICK_STATUS'
           AND gd.group_dict_value = t.pick_status
          LEFT JOIN mrp.mrp_determine_supplier_archives sa
            ON sa.supplier_code = t.mater_supplier_code
           AND sa.company_id = t.company_id            
          LEFT JOIN mrp.mrp_temporary_supplier_archives sb
            ON sb.supplier_code = t.mater_supplier_code
         WHERE t.relate_product_order_num = ']' || p_order_num || q'['
         ORDER BY t.relate_skc ASC) va
]';
    RETURN v_sql;
  END f_query_pick_list;

  --新增 PICK_LIST
  PROCEDURE p_insert_pick_list(p_pick_rec pick_list%ROWTYPE) IS
  BEGIN
    INSERT INTO pick_list
      (pick_lict_code, pick_status, pick_source, pro_supplier_code,
       mater_supplier_code, material_sku, whether_inner_mater, unit,
       purchase_skc_order_num, suggest_pick_num, pick_num, pick_percent,
       unpick_num, relate_product_order_num, relate_skc, bulk_cargo_bom_id,
       material_detail_id, company_id, create_id, create_time, update_id,
       update_time, whether_del, pick_id, pick_time, cancel_id, cancel_time,
       cancel_reason)
    VALUES
      (p_pick_rec.pick_lict_code, p_pick_rec.pick_status,
       p_pick_rec.pick_source, p_pick_rec.pro_supplier_code,
       p_pick_rec.mater_supplier_code, p_pick_rec.material_sku,
       p_pick_rec.whether_inner_mater, p_pick_rec.unit,
       p_pick_rec.purchase_skc_order_num, p_pick_rec.suggest_pick_num,
       p_pick_rec.pick_num, p_pick_rec.pick_percent, p_pick_rec.unpick_num,
       p_pick_rec.relate_product_order_num, p_pick_rec.relate_skc,
       p_pick_rec.bulk_cargo_bom_id, p_pick_rec.material_detail_id,
       p_pick_rec.company_id, p_pick_rec.create_id, p_pick_rec.create_time,
       p_pick_rec.update_id, p_pick_rec.update_time, p_pick_rec.whether_del,
       p_pick_rec.pick_id, p_pick_rec.pick_time, p_pick_rec.cancel_id,
       p_pick_rec.cancel_time, p_pick_rec.cancel_reason);
  END p_insert_pick_list;

  --修改 PICK_LIST
  PROCEDURE p_update_pick_list(p_pick_rec pick_list%ROWTYPE) IS
  BEGIN
    UPDATE pick_list t
       SET t.pick_status              = p_pick_rec.pick_status, --领料状态，0待完成，1已完成，2已取消
           t.pick_source              = p_pick_rec.pick_source, --领料单来源
           t.pro_supplier_code        = p_pick_rec.pro_supplier_code, --成品供应商编号
           t.mater_supplier_code      = p_pick_rec.mater_supplier_code, --物料供应商编号
           t.material_sku             = p_pick_rec.material_sku, --物料SKU
           t.whether_inner_mater      = p_pick_rec.whether_inner_mater, --是否内部物料，0否1是
           t.unit                     = p_pick_rec.unit, --单位
           t.purchase_skc_order_num   = p_pick_rec.purchase_skc_order_num, --采购SKC订单量
           t.suggest_pick_num         = p_pick_rec.suggest_pick_num, --建议领料量
           t.pick_num                 = p_pick_rec.pick_num, --已领料量
           t.pick_percent             = p_pick_rec.pick_percent, --已领料百分比
           t.unpick_num               = p_pick_rec.unpick_num, --未领料量
           t.relate_product_order_num = p_pick_rec.relate_product_order_num, --关联生产订单编号
           t.relate_skc               = p_pick_rec.relate_skc, --关联SKC
           t.bulk_cargo_bom_id        = p_pick_rec.bulk_cargo_bom_id, --关联大货BOMID
           t.material_detail_id       = p_pick_rec.material_detail_id, --关联大货BOM物料明细ID
           t.company_id               = p_pick_rec.company_id, --企业编码
           t.create_id                = p_pick_rec.create_id, --创建者
           t.create_time              = p_pick_rec.create_time, --创建时间
           t.update_id                = p_pick_rec.update_id, --更新者
           t.update_time              = p_pick_rec.update_time, --更新时间
           t.whether_del              = p_pick_rec.whether_del, --是否删除，0否1是
           t.pick_id                  = p_pick_rec.pick_id, --领料人
           t.pick_time                = p_pick_rec.pick_time, --领料时间
           t.cancel_id                = p_pick_rec.cancel_id, --取消人
           t.cancel_time              = p_pick_rec.cancel_time, --取消日期
           t.cancel_reason            = p_pick_rec.cancel_reason --取消原因
     WHERE t.pick_lict_code = p_pick_rec.pick_lict_code;
  END p_update_pick_list;

  --删除 PICK_LIST
  PROCEDURE p_delete_pick_list(p_pick_rec pick_list%ROWTYPE) IS
  BEGIN
    DELETE FROM pick_list t
     WHERE t.pick_lict_code = p_pick_rec.pick_lict_code;
  END p_delete_pick_list;

END pkg_pick_list;
/

