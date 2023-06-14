CREATE OR REPLACE PACKAGE mrp.pkg_material_color_cloth_stock IS
  --查询 MATERIAL_COLOR_CLOTH_STOCK
  FUNCTION f_query_material_color_cloth_stock RETURN CLOB;

  --新增 MATERIAL_COLOR_CLOTH_STOCK
  PROCEDURE p_insert_material_color_cloth_stock(p_mater_rec material_color_cloth_stock%ROWTYPE);

  --修改 MATERIAL_COLOR_CLOTH_STOCK
  PROCEDURE p_update_material_color_cloth_stock(p_mater_rec material_color_cloth_stock%ROWTYPE);

  --删除 MATERIAL_COLOR_CLOTH_STOCK
  PROCEDURE p_delete_material_color_cloth_stock(p_mater_rec material_color_cloth_stock%ROWTYPE);

END pkg_material_color_cloth_stock;
/
CREATE OR REPLACE PACKAGE BODY mrp.pkg_material_color_cloth_stock IS
  --查询 MATERIAL_COLOR_CLOTH_STOCK
  FUNCTION f_query_material_color_cloth_stock RETURN CLOB IS
    v_sql CLOB; 
  BEGIN
    v_sql := '
SELECT t.color_cloth_stock_id, --供应商色布库存主键
       t.mater_supplier_code, --物料供应商编号
       t.material_sku, --物料SKU
       t.unit, --单位
       t.total_stock, --总库存数
       t.brand_stock, --品牌仓库存数
       t.supplier_stock, --供应商仓库存数
       t.company_id, --企业编码
       t.create_id, --创建者
       t.create_time, --创建时间
       t.update_id, --更新者
       t.update_time, --更新时间
       t.whether_del --是否删除，0否1是
  FROM material_color_cloth_stock t
 WHERE 1 = 1
';
    RETURN v_sql;
  END f_query_material_color_cloth_stock;

  --新增 MATERIAL_COLOR_CLOTH_STOCK
  PROCEDURE p_insert_material_color_cloth_stock(p_mater_rec material_color_cloth_stock%ROWTYPE) IS
  BEGIN
  
    INSERT INTO material_color_cloth_stock
      (color_cloth_stock_id, mater_supplier_code, material_sku, unit,
       total_stock, brand_stock, supplier_stock, company_id, create_id,
       create_time, update_id, update_time, whether_del)
    VALUES
      (p_mater_rec.color_cloth_stock_id, p_mater_rec.mater_supplier_code,
       p_mater_rec.material_sku, p_mater_rec.unit, p_mater_rec.total_stock,
       p_mater_rec.brand_stock, p_mater_rec.supplier_stock,
       p_mater_rec.company_id, p_mater_rec.create_id,
       p_mater_rec.create_time, p_mater_rec.update_id,
       p_mater_rec.update_time, p_mater_rec.whether_del);
  END p_insert_material_color_cloth_stock;

  --修改 MATERIAL_COLOR_CLOTH_STOCK
  PROCEDURE p_update_material_color_cloth_stock(p_mater_rec material_color_cloth_stock%ROWTYPE) IS
  BEGIN  
    UPDATE material_color_cloth_stock t
       SET t.mater_supplier_code = p_mater_rec.mater_supplier_code, --物料供应商编号
           t.material_sku        = p_mater_rec.material_sku, --物料SKU
           t.unit                = p_mater_rec.unit, --单位
           t.total_stock         = p_mater_rec.total_stock, --总库存数
           t.brand_stock         = p_mater_rec.brand_stock, --品牌仓库存数
           t.supplier_stock      = p_mater_rec.supplier_stock, --供应商仓库存数
           t.company_id          = p_mater_rec.company_id, --企业编码
           t.create_id           = p_mater_rec.create_id, --创建者
           t.create_time         = p_mater_rec.create_time, --创建时间
           t.update_id           = p_mater_rec.update_id, --更新者
           t.update_time         = p_mater_rec.update_time, --更新时间
           t.whether_del         = p_mater_rec.whether_del --是否删除，0否1是
     WHERE t.color_cloth_stock_id = p_mater_rec.color_cloth_stock_id;
  END p_update_material_color_cloth_stock;

  --删除 MATERIAL_COLOR_CLOTH_STOCK
  PROCEDURE p_delete_material_color_cloth_stock(p_mater_rec material_color_cloth_stock%ROWTYPE) IS
  BEGIN  
    DELETE FROM material_color_cloth_stock t WHERE 1 = 0;
  END p_delete_material_color_cloth_stock;

END pkg_material_color_cloth_stock;
/
