CREATE OR REPLACE PACKAGE mrp.pkg_material_grey_stock IS
  -- Author  : CZH55
  -- Created : 2023/4/25 17:39:55
  -- Purpose : 物料供应商坯布仓库存-基础程序包

  --查询 MATERIAL_GREY_STOCK
  FUNCTION f_query_material_grey_stock RETURN CLOB;

  --查询 通过ID MATERIAL_GREY_STOCK
  FUNCTION f_query_material_grey_stock_by_id(p_color_cloth_stock_id VARCHAR2)
    RETURN CLOB;

  --新增 MATERIAL_GREY_STOCK
  PROCEDURE p_insert_material_grey_stock(p_mater_rec material_grey_stock%ROWTYPE);

  --修改 MATERIAL_GREY_STOCK
  PROCEDURE p_update_material_grey_stock(p_mater_rec material_grey_stock%ROWTYPE);

  --删除 MATERIAL_GREY_STOCK
  PROCEDURE p_delete_material_grey_stock(p_mater_rec material_grey_stock%ROWTYPE);

  --删除 通过ID MATERIAL_GREY_STOCK
  PROCEDURE p_delete_material_grey_stock_by_id(p_color_cloth_stock_id VARCHAR2);

  --校验 CREATE_TIME MATERIAL_GREY_STOCK
  PROCEDURE p_check_create_time(p_create_time DATE);

  --校验 COLOR_CLOTH_STOCK_ID MATERIAL_GREY_STOCK
  PROCEDURE p_check_color_cloth_stock_id(p_color_cloth_stock_id VARCHAR2);

  --校验 MATER_SUPPLIER_CODE MATERIAL_GREY_STOCK
  PROCEDURE p_check_mater_supplier_code(p_mater_supplier_code VARCHAR2);

  --校验 MATERIAL_SPU MATERIAL_GREY_STOCK
  PROCEDURE p_check_material_spu(p_material_spu VARCHAR2);

  --校验 UNIT MATERIAL_GREY_STOCK
  PROCEDURE p_check_unit(p_unit VARCHAR2);

  --校验 COMPANY_ID MATERIAL_GREY_STOCK
  PROCEDURE p_check_company_id(p_company_id VARCHAR2);

  --校验 CREATE_ID MATERIAL_GREY_STOCK
  PROCEDURE p_check_create_id(p_create_id VARCHAR2);
  --调用 MATERIAL_GREY_STOCK
  PROCEDURE p_invoke_material_grey_stock(p_mater_rec material_grey_stock%ROWTYPE);

END pkg_material_grey_stock;
/
CREATE OR REPLACE PACKAGE BODY mrp.pkg_material_grey_stock IS
  --查询 MATERIAL_GREY_STOCK
  FUNCTION f_query_material_grey_stock RETURN CLOB IS
    v_sql CLOB;
  
  BEGIN
    v_sql := '
SELECT t.color_cloth_stock_id, --供应商坯布库存主键
       t.mater_supplier_code, --物料供应商编号
       t.material_spu, --物料SPU
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
  FROM material_grey_stock t
 WHERE 1 = 1
';
    RETURN v_sql;
  END f_query_material_grey_stock;
  --查询 通过ID MATERIAL_GREY_STOCK
  FUNCTION f_query_material_grey_stock_by_id(p_color_cloth_stock_id VARCHAR2)
    RETURN CLOB IS
    v_sql CLOB;
  
    v_color_cloth_stock_id VARCHAR2(32) := p_color_cloth_stock_id;
  BEGIN
    v_sql := '
SELECT t.color_cloth_stock_id, --供应商坯布库存主键
       t.mater_supplier_code, --物料供应商编号
       t.material_spu, --物料SPU
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
  FROM material_grey_stock t
 WHERE t.color_cloth_stock_id = ''' || v_color_cloth_stock_id || '''
';
    RETURN v_sql;
  END f_query_material_grey_stock_by_id;
  --新增 MATERIAL_GREY_STOCK
  PROCEDURE p_insert_material_grey_stock(p_mater_rec material_grey_stock%ROWTYPE) IS
  BEGIN
  
    INSERT INTO material_grey_stock
      (color_cloth_stock_id, mater_supplier_code, material_spu, unit,
       total_stock, brand_stock, supplier_stock, company_id, create_id,
       create_time, update_id, update_time, whether_del)
    VALUES
      (p_mater_rec.color_cloth_stock_id, p_mater_rec.mater_supplier_code,
       p_mater_rec.material_spu, p_mater_rec.unit, p_mater_rec.total_stock,
       p_mater_rec.brand_stock, p_mater_rec.supplier_stock,
       p_mater_rec.company_id, p_mater_rec.create_id,
       p_mater_rec.create_time, p_mater_rec.update_id,
       p_mater_rec.update_time, p_mater_rec.whether_del);
  END p_insert_material_grey_stock;

  --修改 MATERIAL_GREY_STOCK
  PROCEDURE p_update_material_grey_stock(p_mater_rec material_grey_stock%ROWTYPE) IS
  BEGIN
  
    UPDATE material_grey_stock t
       SET t.mater_supplier_code = p_mater_rec.mater_supplier_code, --物料供应商编号
           t.material_spu        = p_mater_rec.material_spu, --物料SPU
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
  END p_update_material_grey_stock;

  --删除 MATERIAL_GREY_STOCK
  PROCEDURE p_delete_material_grey_stock(p_mater_rec material_grey_stock%ROWTYPE) IS
  BEGIN
  
    DELETE FROM material_grey_stock t WHERE 1 = 0;
  END p_delete_material_grey_stock;

  --删除 通过ID MATERIAL_GREY_STOCK
  PROCEDURE p_delete_material_grey_stock_by_id(p_color_cloth_stock_id VARCHAR2) IS
  
    v_color_cloth_stock_id VARCHAR2(32) := p_color_cloth_stock_id;
  BEGIN
  
    DELETE FROM material_grey_stock t
     WHERE t.color_cloth_stock_id = v_color_cloth_stock_id;
  END p_delete_material_grey_stock_by_id;

  --校验 CREATE_TIME MATERIAL_GREY_STOCK
  PROCEDURE p_check_create_time(p_create_time DATE) IS
  
  BEGIN
  
    IF p_create_time IS NULL THEN
      raise_application_error(-20002, '【创建时间】必填，请检查！');
    END IF;
  END p_check_create_time;

  --校验 COLOR_CLOTH_STOCK_ID MATERIAL_GREY_STOCK
  PROCEDURE p_check_color_cloth_stock_id(p_color_cloth_stock_id VARCHAR2) IS
  
  BEGIN
  
    IF p_color_cloth_stock_id IS NULL THEN
      raise_application_error(-20002,
                              '【供应商坯布库存主键】必填，请检查！');
    END IF;
  END p_check_color_cloth_stock_id;

  --校验 MATER_SUPPLIER_CODE MATERIAL_GREY_STOCK
  PROCEDURE p_check_mater_supplier_code(p_mater_supplier_code VARCHAR2) IS
  
  BEGIN
  
    IF p_mater_supplier_code IS NULL THEN
      raise_application_error(-20002, '【物料供应商编号】必填，请检查！');
    END IF;
  END p_check_mater_supplier_code;

  --校验 MATERIAL_SPU MATERIAL_GREY_STOCK
  PROCEDURE p_check_material_spu(p_material_spu VARCHAR2) IS
  
  BEGIN
  
    IF p_material_spu IS NULL THEN
      raise_application_error(-20002, '【物料SPU】必填，请检查！');
    END IF;
  END p_check_material_spu;

  --校验 UNIT MATERIAL_GREY_STOCK
  PROCEDURE p_check_unit(p_unit VARCHAR2) IS
  
  BEGIN
  
    IF p_unit IS NULL THEN
      raise_application_error(-20002, '【单位】必填，请检查！');
    END IF;
  END p_check_unit;

  --校验 COMPANY_ID MATERIAL_GREY_STOCK
  PROCEDURE p_check_company_id(p_company_id VARCHAR2) IS
  
  BEGIN
  
    IF p_company_id IS NULL THEN
      raise_application_error(-20002, '【企业编码】必填，请检查！');
    END IF;
  END p_check_company_id;

  --校验 CREATE_ID MATERIAL_GREY_STOCK
  PROCEDURE p_check_create_id(p_create_id VARCHAR2) IS
  
  BEGIN
  
    IF p_create_id IS NULL THEN
      raise_application_error(-20002, '【创建者】必填，请检查！');
    END IF;
  END p_check_create_id;
  --调用 MATERIAL_GREY_STOCK
  PROCEDURE p_invoke_material_grey_stock(p_mater_rec material_grey_stock%ROWTYPE) IS
  BEGIN
  
    mrp.pkg_material_grey_stock.p_check_create_time(p_create_time => p_mater_rec.create_time);
    mrp.pkg_material_grey_stock.p_check_color_cloth_stock_id(p_color_cloth_stock_id => p_mater_rec.color_cloth_stock_id);
    mrp.pkg_material_grey_stock.p_check_mater_supplier_code(p_mater_supplier_code => p_mater_rec.mater_supplier_code);
    mrp.pkg_material_grey_stock.p_check_material_spu(p_material_spu => p_mater_rec.material_spu);
    mrp.pkg_material_grey_stock.p_check_unit(p_unit => p_mater_rec.unit);
    mrp.pkg_material_grey_stock.p_check_company_id(p_company_id => p_mater_rec.company_id);
    mrp.pkg_material_grey_stock.p_check_create_id(p_create_id => p_mater_rec.create_id);
  END p_invoke_material_grey_stock;

END pkg_material_grey_stock;
/
