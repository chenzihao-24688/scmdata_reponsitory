CREATE OR REPLACE PACKAGE MRP.pkg_supplier_grey_stock IS

  -- Author  : CZH55
  -- Created : 2023/4/25 17:39:55
  -- Purpose : 成品供应商坯布仓库存明细-基础程序包
  
  --查询 SUPPLIER_GREY_STOCK
  FUNCTION f_query_supplier_grey_stock RETURN CLOB;

  --查询 通过ID SUPPLIER_GREY_STOCK
  FUNCTION f_query_supplier_grey_stock_by_id(p_color_cloth_stock_id VARCHAR2)
    RETURN CLOB;

  --新增 SUPPLIER_GREY_STOCK
  PROCEDURE p_insert_supplier_grey_stock(p_suppl_rec supplier_grey_stock%ROWTYPE);

  --修改 SUPPLIER_GREY_STOCK
  PROCEDURE p_update_supplier_grey_stock(p_suppl_rec supplier_grey_stock%ROWTYPE);

  --删除 SUPPLIER_GREY_STOCK
  PROCEDURE p_delete_supplier_grey_stock(p_suppl_rec supplier_grey_stock%ROWTYPE);

  --删除 通过ID SUPPLIER_GREY_STOCK
  PROCEDURE p_delete_supplier_grey_stock_by_id(p_color_cloth_stock_id VARCHAR2);

  --校验 COLOR_CLOTH_STOCK_ID SUPPLIER_GREY_STOCK
  PROCEDURE p_check_color_cloth_stock_id(p_color_cloth_stock_id VARCHAR2);

  --校验 PRO_SUPPLIER_CODE SUPPLIER_GREY_STOCK
  PROCEDURE p_check_pro_supplier_code(p_pro_supplier_code VARCHAR2);

  --校验 MATER_SUPPLIER_CODE SUPPLIER_GREY_STOCK
  PROCEDURE p_check_mater_supplier_code(p_mater_supplier_code VARCHAR2);

  --校验 MATERIAL_SPU SUPPLIER_GREY_STOCK
  PROCEDURE p_check_material_spu(p_material_spu VARCHAR2);

  --校验 UNIT SUPPLIER_GREY_STOCK
  PROCEDURE p_check_unit(p_unit VARCHAR2);

  --校验 COMPANY_ID SUPPLIER_GREY_STOCK
  PROCEDURE p_check_company_id(p_company_id VARCHAR2);

  --校验 CREATE_ID SUPPLIER_GREY_STOCK
  PROCEDURE p_check_create_id(p_create_id VARCHAR2);

  --校验 CREATE_TIME SUPPLIER_GREY_STOCK
  PROCEDURE p_check_create_time(p_create_time DATE);
  --调用 SUPPLIER_GREY_STOCK
  PROCEDURE p_invoke_supplier_grey_stock(p_suppl_rec supplier_grey_stock%ROWTYPE);

END pkg_supplier_grey_stock;
/

CREATE OR REPLACE PACKAGE BODY MRP.pkg_supplier_grey_stock IS
  --查询 SUPPLIER_GREY_STOCK
  FUNCTION f_query_supplier_grey_stock RETURN CLOB IS
    v_sql CLOB;
  
  BEGIN
    v_sql := '

SELECT T.COLOR_CLOTH_STOCK_ID, --供应商坯布库存主键
T.PRO_SUPPLIER_CODE, --成品供应商编号
T.MATER_SUPPLIER_CODE, --物料供应商编号
T.MATERIAL_SPU, --物料SPU
T.WHETHER_INNER_MATER, --是否内部物料，0否1是
T.UNIT, --单位
T.TOTAL_STOCK, --总库存数
T.BRAND_STOCK, --品牌仓库存数
T.SUPPLIER_STOCK, --供应商仓库存数
T.COMPANY_ID, --企业编码
T.CREATE_ID, --创建者
T.CREATE_TIME, --创建时间
T.UPDATE_ID, --更新者
T.UPDATE_TIME, --更新时间
T.WHETHER_DEL --是否删除，0否1是
 FROM SUPPLIER_GREY_STOCK T  WHERE 1 = 1
';
    RETURN v_sql;
  END f_query_supplier_grey_stock;
  --查询 通过ID SUPPLIER_GREY_STOCK
  FUNCTION f_query_supplier_grey_stock_by_id(p_color_cloth_stock_id VARCHAR2)
    RETURN CLOB IS
    v_sql CLOB;
  
    v_color_cloth_stock_id VARCHAR2(32) := p_color_cloth_stock_id;
  BEGIN
    v_sql := '

SELECT T.COLOR_CLOTH_STOCK_ID, --供应商坯布库存主键
T.PRO_SUPPLIER_CODE, --成品供应商编号
T.MATER_SUPPLIER_CODE, --物料供应商编号
T.MATERIAL_SPU, --物料SPU
T.WHETHER_INNER_MATER, --是否内部物料，0否1是
T.UNIT, --单位
T.TOTAL_STOCK, --总库存数
T.BRAND_STOCK, --品牌仓库存数
T.SUPPLIER_STOCK, --供应商仓库存数
T.COMPANY_ID, --企业编码
T.CREATE_ID, --创建者
T.CREATE_TIME, --创建时间
T.UPDATE_ID, --更新者
T.UPDATE_TIME, --更新时间
T.WHETHER_DEL --是否删除，0否1是
 FROM SUPPLIER_GREY_STOCK T  WHERE T.COLOR_CLOTH_STOCK_ID = ''' ||
             v_color_cloth_stock_id || '''
';
    RETURN v_sql;
  END f_query_supplier_grey_stock_by_id;
  --新增 SUPPLIER_GREY_STOCK
  PROCEDURE p_insert_supplier_grey_stock(p_suppl_rec supplier_grey_stock%ROWTYPE) IS
  BEGIN
  
    INSERT INTO supplier_grey_stock
      (color_cloth_stock_id, pro_supplier_code, mater_supplier_code,
       material_spu, whether_inner_mater, unit, total_stock, brand_stock,
       supplier_stock, company_id, create_id, create_time, update_id,
       update_time, whether_del)
    VALUES
      (p_suppl_rec.color_cloth_stock_id, p_suppl_rec.pro_supplier_code,
       p_suppl_rec.mater_supplier_code, p_suppl_rec.material_spu,
       p_suppl_rec.whether_inner_mater, p_suppl_rec.unit,
       p_suppl_rec.total_stock, p_suppl_rec.brand_stock,
       p_suppl_rec.supplier_stock, p_suppl_rec.company_id,
       p_suppl_rec.create_id, p_suppl_rec.create_time, p_suppl_rec.update_id,
       p_suppl_rec.update_time, p_suppl_rec.whether_del);
  END p_insert_supplier_grey_stock;

  --修改 SUPPLIER_GREY_STOCK
  PROCEDURE p_update_supplier_grey_stock(p_suppl_rec supplier_grey_stock%ROWTYPE) IS
  BEGIN
  
    UPDATE supplier_grey_stock t
       SET t.pro_supplier_code   = p_suppl_rec.pro_supplier_code, --成品供应商编号
           t.mater_supplier_code = p_suppl_rec.mater_supplier_code, --物料供应商编号
           t.material_spu        = p_suppl_rec.material_spu, --物料SPU
           t.whether_inner_mater = p_suppl_rec.whether_inner_mater, --是否内部物料，0否1是
           t.unit                = p_suppl_rec.unit, --单位
           t.total_stock         = p_suppl_rec.total_stock, --总库存数
           t.brand_stock         = p_suppl_rec.brand_stock, --品牌仓库存数
           t.supplier_stock      = p_suppl_rec.supplier_stock, --供应商仓库存数
           t.company_id          = p_suppl_rec.company_id, --企业编码
           t.create_id           = p_suppl_rec.create_id, --创建者
           t.create_time         = p_suppl_rec.create_time, --创建时间
           t.update_id           = p_suppl_rec.update_id, --更新者
           t.update_time         = p_suppl_rec.update_time, --更新时间
           t.whether_del         = p_suppl_rec.whether_del --是否删除，0否1是
     WHERE t.color_cloth_stock_id = p_suppl_rec.color_cloth_stock_id;
  END p_update_supplier_grey_stock;

  --删除 SUPPLIER_GREY_STOCK
  PROCEDURE p_delete_supplier_grey_stock(p_suppl_rec supplier_grey_stock%ROWTYPE) IS
  BEGIN
  
    DELETE FROM supplier_grey_stock t WHERE 1 = 0;
  END p_delete_supplier_grey_stock;

  --删除 通过ID SUPPLIER_GREY_STOCK
  PROCEDURE p_delete_supplier_grey_stock_by_id(p_color_cloth_stock_id VARCHAR2) IS
  
    v_color_cloth_stock_id VARCHAR2(32) := p_color_cloth_stock_id;
  BEGIN
  
    DELETE FROM supplier_grey_stock t
     WHERE t.color_cloth_stock_id = v_color_cloth_stock_id;
  END p_delete_supplier_grey_stock_by_id;

  --校验 COLOR_CLOTH_STOCK_ID SUPPLIER_GREY_STOCK
  PROCEDURE p_check_color_cloth_stock_id(p_color_cloth_stock_id VARCHAR2) IS
  
  BEGIN
  
    IF p_color_cloth_stock_id IS NULL THEN
      raise_application_error(-20002,
                              '【供应商坯布库存主键】必填，请检查！');
    END IF;
  END p_check_color_cloth_stock_id;

  --校验 PRO_SUPPLIER_CODE SUPPLIER_GREY_STOCK
  PROCEDURE p_check_pro_supplier_code(p_pro_supplier_code VARCHAR2) IS
  
  BEGIN
  
    IF p_pro_supplier_code IS NULL THEN
      raise_application_error(-20002, '【成品供应商编号】必填，请检查！');
    END IF;
  END p_check_pro_supplier_code;

  --校验 MATER_SUPPLIER_CODE SUPPLIER_GREY_STOCK
  PROCEDURE p_check_mater_supplier_code(p_mater_supplier_code VARCHAR2) IS
  
  BEGIN
  
    IF p_mater_supplier_code IS NULL THEN
      raise_application_error(-20002, '【物料供应商编号】必填，请检查！');
    END IF;
  END p_check_mater_supplier_code;

  --校验 MATERIAL_SPU SUPPLIER_GREY_STOCK
  PROCEDURE p_check_material_spu(p_material_spu VARCHAR2) IS
  
  BEGIN
  
    IF p_material_spu IS NULL THEN
      raise_application_error(-20002, '【物料SPU】必填，请检查！');
    END IF;
  END p_check_material_spu;

  --校验 UNIT SUPPLIER_GREY_STOCK
  PROCEDURE p_check_unit(p_unit VARCHAR2) IS
  
  BEGIN
  
    IF p_unit IS NULL THEN
      raise_application_error(-20002, '【单位】必填，请检查！');
    END IF;
  END p_check_unit;

  --校验 COMPANY_ID SUPPLIER_GREY_STOCK
  PROCEDURE p_check_company_id(p_company_id VARCHAR2) IS
  
  BEGIN
  
    IF p_company_id IS NULL THEN
      raise_application_error(-20002, '【企业编码】必填，请检查！');
    END IF;
  END p_check_company_id;

  --校验 CREATE_ID SUPPLIER_GREY_STOCK
  PROCEDURE p_check_create_id(p_create_id VARCHAR2) IS
  
  BEGIN
  
    IF p_create_id IS NULL THEN
      raise_application_error(-20002, '【创建者】必填，请检查！');
    END IF;
  END p_check_create_id;

  --校验 CREATE_TIME SUPPLIER_GREY_STOCK
  PROCEDURE p_check_create_time(p_create_time DATE) IS
  
  BEGIN
  
    IF p_create_time IS NULL THEN
      raise_application_error(-20002, '【创建时间】必填，请检查！');
    END IF;
  END p_check_create_time;
  --调用 SUPPLIER_GREY_STOCK
  PROCEDURE p_invoke_supplier_grey_stock(p_suppl_rec supplier_grey_stock%ROWTYPE) IS
  BEGIN
  
    mrp.pkg_supplier_grey_stock.p_check_color_cloth_stock_id(p_color_cloth_stock_id => p_suppl_rec.color_cloth_stock_id);
    mrp.pkg_supplier_grey_stock.p_check_pro_supplier_code(p_pro_supplier_code => p_suppl_rec.pro_supplier_code);
    mrp.pkg_supplier_grey_stock.p_check_mater_supplier_code(p_mater_supplier_code => p_suppl_rec.mater_supplier_code);
    mrp.pkg_supplier_grey_stock.p_check_material_spu(p_material_spu => p_suppl_rec.material_spu);
    mrp.pkg_supplier_grey_stock.p_check_unit(p_unit => p_suppl_rec.unit);
    mrp.pkg_supplier_grey_stock.p_check_company_id(p_company_id => p_suppl_rec.company_id);
    mrp.pkg_supplier_grey_stock.p_check_create_id(p_create_id => p_suppl_rec.create_id);
    mrp.pkg_supplier_grey_stock.p_check_create_time(p_create_time => p_suppl_rec.create_time);
  END p_invoke_supplier_grey_stock;

END pkg_supplier_grey_stock;
/

