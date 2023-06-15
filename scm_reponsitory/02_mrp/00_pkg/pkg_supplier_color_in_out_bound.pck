CREATE OR REPLACE PACKAGE MRP.pkg_supplier_color_in_out_bound IS

  -- Author  : CZH55
  -- Created : 2023/4/25 17:39:55
  -- Purpose : 成品供应商色布出入库单-基础程序包

  --查询 SUPPLIER_COLOR_IN_OUT_BOUND
  FUNCTION f_query_supplier_color_in_out_bound RETURN CLOB;

  --新增 SUPPLIER_COLOR_IN_OUT_BOUND
  PROCEDURE p_insert_supplier_color_in_out_bound(p_suppl_rec supplier_color_in_out_bound%ROWTYPE);

  --修改 SUPPLIER_COLOR_IN_OUT_BOUND
  PROCEDURE p_update_supplier_color_in_out_bound(p_suppl_rec supplier_color_in_out_bound%ROWTYPE);

  --删除 SUPPLIER_COLOR_IN_OUT_BOUND
  PROCEDURE p_delete_supplier_color_in_out_bound(p_suppl_rec supplier_color_in_out_bound%ROWTYPE);

END pkg_supplier_color_in_out_bound;
/

CREATE OR REPLACE PACKAGE BODY MRP.pkg_supplier_color_in_out_bound IS
  --查询 SUPPLIER_COLOR_IN_OUT_BOUND
  FUNCTION f_query_supplier_color_in_out_bound RETURN CLOB IS
    v_sql CLOB;  
  BEGIN
    v_sql := '
SELECT t.bound_num, --色布出入库单号
       t.ascription, --出入库归属，0出库1入库
       t.bound_type, --出入库类型，1订单出库，2盘亏出库，3领料出库，10品牌备料入库，11供应商现货入库，12临时补充入库，13盘盈入库，14临时坯转色入库 15 供应商色布入库 16 供应商现货出库
       t.pro_supplier_code, --成品供应商编号
       t.mater_supplier_code, --物料供应商编号
       t.material_sku, --物料SKU
       t.whether_inner_mater, --是否内部物料，0否1是
       t.unit, --单位
       t.num, --数量
       t.stock_type, --仓库类型，1品牌仓，2供应商仓
       t.relate_num, --关联单号
       t.relate_num_type, --关联单号类型，1色布生产单/2色布盘点单/3色布领料单/4面料采购单/5坯布出库单
       t.relate_skc, --关联SKC
       t.relate_purchase, --关联采购单号
       t.company_id, --企业编码
       t.create_id, --创建者
       t.create_time, --创建时间
       t.update_id, --更新者
       t.update_time, --更新时间
       t.whether_del --是否删除，0否1是
  FROM supplier_color_in_out_bound t
 WHERE 1 = 1
';
    RETURN v_sql;
  END f_query_supplier_color_in_out_bound;

  --新增 SUPPLIER_COLOR_IN_OUT_BOUND
  PROCEDURE p_insert_supplier_color_in_out_bound(p_suppl_rec supplier_color_in_out_bound%ROWTYPE) IS
  BEGIN
  
    INSERT INTO supplier_color_in_out_bound
      (bound_num, ascription, bound_type, pro_supplier_code,
       mater_supplier_code, material_sku, whether_inner_mater, unit, num,
       stock_type, relate_num, relate_num_type, relate_skc, relate_purchase,
       company_id, create_id, create_time, update_id, update_time,
       whether_del)
    VALUES
      (p_suppl_rec.bound_num, p_suppl_rec.ascription,
       p_suppl_rec.bound_type, p_suppl_rec.pro_supplier_code,
       p_suppl_rec.mater_supplier_code, p_suppl_rec.material_sku,
       p_suppl_rec.whether_inner_mater, p_suppl_rec.unit, p_suppl_rec.num,
       p_suppl_rec.stock_type, p_suppl_rec.relate_num,
       p_suppl_rec.relate_num_type, p_suppl_rec.relate_skc,
       p_suppl_rec.relate_purchase, p_suppl_rec.company_id,
       p_suppl_rec.create_id, p_suppl_rec.create_time, p_suppl_rec.update_id,
       p_suppl_rec.update_time, p_suppl_rec.whether_del);
  END p_insert_supplier_color_in_out_bound;

  --修改 SUPPLIER_COLOR_IN_OUT_BOUND
  PROCEDURE p_update_supplier_color_in_out_bound(p_suppl_rec supplier_color_in_out_bound%ROWTYPE) IS
  BEGIN
  
    UPDATE supplier_color_in_out_bound t
       SET t.ascription          = p_suppl_rec.ascription, --出入库归属，0出库1入库
           t.bound_type          = p_suppl_rec.bound_type, --出入库类型，1订单出库，2盘亏出库，3领料出库，10品牌备料入库，11供应商现货入库，12临时补充入库，13盘盈入库，14临时坯转色入库 15 供应商色布入库 16 供应商现货出库
           t.pro_supplier_code   = p_suppl_rec.pro_supplier_code, --成品供应商编号
           t.mater_supplier_code = p_suppl_rec.mater_supplier_code, --物料供应商编号
           t.material_sku        = p_suppl_rec.material_sku, --物料SKU
           t.whether_inner_mater = p_suppl_rec.whether_inner_mater, --是否内部物料，0否1是
           t.unit                = p_suppl_rec.unit, --单位
           t.num                 = p_suppl_rec.num, --数量
           t.stock_type          = p_suppl_rec.stock_type, --仓库类型，1品牌仓，2供应商仓
           t.relate_num          = p_suppl_rec.relate_num, --关联单号
           t.relate_num_type     = p_suppl_rec.relate_num_type, --关联单号类型，1色布生产单/2色布盘点单/3色布领料单/4面料采购单/5坯布出库单
           t.relate_skc          = p_suppl_rec.relate_skc, --关联SKC
           t.relate_purchase     = p_suppl_rec.relate_purchase, --关联采购单号
           t.company_id          = p_suppl_rec.company_id, --企业编码
           t.create_id           = p_suppl_rec.create_id, --创建者
           t.create_time         = p_suppl_rec.create_time, --创建时间
           t.update_id           = p_suppl_rec.update_id, --更新者
           t.update_time         = p_suppl_rec.update_time, --更新时间
           t.whether_del         = p_suppl_rec.whether_del --是否删除，0否1是
     WHERE t.bound_num = p_suppl_rec.bound_num;
  END p_update_supplier_color_in_out_bound;

  --删除 SUPPLIER_COLOR_IN_OUT_BOUND
  PROCEDURE p_delete_supplier_color_in_out_bound(p_suppl_rec supplier_color_in_out_bound%ROWTYPE) IS
  BEGIN
    DELETE FROM supplier_color_in_out_bound t WHERE t.bound_num = p_suppl_rec.bound_num;
  END p_delete_supplier_color_in_out_bound;

END pkg_supplier_color_in_out_bound;
/

