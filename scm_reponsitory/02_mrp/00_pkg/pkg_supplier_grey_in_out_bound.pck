CREATE OR REPLACE PACKAGE MRP.pkg_supplier_grey_in_out_bound IS
  -- Author  : CZH55
  -- Created : 2023/4/25 17:39:55
  -- Purpose : 成品供应商坯布出入库单-基础程序包
  
  --查询 SUPPLIER_GREY_IN_OUT_BOUND
  FUNCTION f_query_supplier_grey_in_out_bound RETURN CLOB;

  --查询 通过ID SUPPLIER_GREY_IN_OUT_BOUND
  FUNCTION f_query_supplier_grey_in_out_bound_by_id(p_bound_num VARCHAR2)
    RETURN CLOB;

  --新增 SUPPLIER_GREY_IN_OUT_BOUND
  PROCEDURE p_insert_supplier_grey_in_out_bound(p_suppl_rec supplier_grey_in_out_bound%ROWTYPE);

  --修改 SUPPLIER_GREY_IN_OUT_BOUND
  PROCEDURE p_update_supplier_grey_in_out_bound(p_suppl_rec supplier_grey_in_out_bound%ROWTYPE);

  --删除 SUPPLIER_GREY_IN_OUT_BOUND
  PROCEDURE p_delete_supplier_grey_in_out_bound(p_suppl_rec supplier_grey_in_out_bound%ROWTYPE);

  --删除 通过ID SUPPLIER_GREY_IN_OUT_BOUND
  PROCEDURE p_delete_supplier_grey_in_out_bound_by_id(p_bound_num VARCHAR2);

  --校验 BOUND_NUM SUPPLIER_GREY_IN_OUT_BOUND
  PROCEDURE p_check_bound_num(p_bound_num VARCHAR2);

  --校验 PRO_SUPPLIER_CODE SUPPLIER_GREY_IN_OUT_BOUND
  PROCEDURE p_check_pro_supplier_code(p_pro_supplier_code VARCHAR2);

  --校验 MATER_SUPPLIER_CODE SUPPLIER_GREY_IN_OUT_BOUND
  PROCEDURE p_check_mater_supplier_code(p_mater_supplier_code VARCHAR2);

  --校验 MATERIAL_SPU SUPPLIER_GREY_IN_OUT_BOUND
  PROCEDURE p_check_material_spu(p_material_spu VARCHAR2);

  --校验 UNIT SUPPLIER_GREY_IN_OUT_BOUND
  PROCEDURE p_check_unit(p_unit VARCHAR2);

  --校验 COMPANY_ID SUPPLIER_GREY_IN_OUT_BOUND
  PROCEDURE p_check_company_id(p_company_id VARCHAR2);

  --校验 CREATE_ID SUPPLIER_GREY_IN_OUT_BOUND
  PROCEDURE p_check_create_id(p_create_id VARCHAR2);

  --校验 CREATE_TIME SUPPLIER_GREY_IN_OUT_BOUND
  PROCEDURE p_check_create_time(p_create_time DATE);
  --调用 SUPPLIER_GREY_IN_OUT_BOUND
  PROCEDURE p_invoke_supplier_grey_in_out_bound(p_suppl_rec supplier_grey_in_out_bound%ROWTYPE);

END pkg_supplier_grey_in_out_bound;
/

CREATE OR REPLACE PACKAGE BODY MRP.pkg_supplier_grey_in_out_bound IS
  --查询 SUPPLIER_GREY_IN_OUT_BOUND
  FUNCTION f_query_supplier_grey_in_out_bound RETURN CLOB IS
    v_sql CLOB;
  
  BEGIN
    v_sql := '

SELECT T.BOUND_NUM, --坯布出入库单号
T.ASCRIPTION, --出入库归属，0出库1入库
T.BOUND_TYPE, --坯布出入库类型，1色布备料出库/ 2盘亏出库/ 3临时坯转色出库/ 11品牌备料入库/ 12供应商现货入库/ 13盘盈入库/ 14临时补充入库/15 供应商色布入库
T.PRO_SUPPLIER_CODE, --成品供应商编号
T.MATER_SUPPLIER_CODE, --物料供应商编号
T.MATERIAL_SPU, --物料SPU
T.WHETHER_INNER_MATER, --是否内部物料，0否1是
T.UNIT, --单位
T.NUM, --数量
T.STOCK_TYPE, --仓库类型，1品牌仓，2供应商仓
T.RELATE_NUM, --关联单号
T.RELATE_NUM_TYPE, --关联单号类型，1色布生产单/ 2坯布盘点单/ 3色布领料单/ 4坯布生产单/5面料采购单/6色布入库单
T.RELATE_SKC, --关联SKC
T.COMPANY_ID, --企业编码
T.CREATE_ID, --创建者
T.CREATE_TIME, --创建时间
T.UPDATE_ID, --更新者
T.UPDATE_TIME, --更新时间
T.WHETHER_DEL, --是否删除，0否1是
T.RELATE_PURCHASE_ORDER_NUM --关联采购单号
 FROM SUPPLIER_GREY_IN_OUT_BOUND T  WHERE 1 = 1
';
    RETURN v_sql;
  END f_query_supplier_grey_in_out_bound;
  --查询 通过ID SUPPLIER_GREY_IN_OUT_BOUND
  FUNCTION f_query_supplier_grey_in_out_bound_by_id(p_bound_num VARCHAR2)
    RETURN CLOB IS
    v_sql CLOB;
  
    v_bound_num VARCHAR2(32) := p_bound_num;
  BEGIN
    v_sql := '

SELECT T.BOUND_NUM, --坯布出入库单号
T.ASCRIPTION, --出入库归属，0出库1入库
T.BOUND_TYPE, --坯布出入库类型，1色布备料出库/ 2盘亏出库/ 3临时坯转色出库/ 11品牌备料入库/ 12供应商现货入库/ 13盘盈入库/ 14临时补充入库/15 供应商色布入库
T.PRO_SUPPLIER_CODE, --成品供应商编号
T.MATER_SUPPLIER_CODE, --物料供应商编号
T.MATERIAL_SPU, --物料SPU
T.WHETHER_INNER_MATER, --是否内部物料，0否1是
T.UNIT, --单位
T.NUM, --数量
T.STOCK_TYPE, --仓库类型，1品牌仓，2供应商仓
T.RELATE_NUM, --关联单号
T.RELATE_NUM_TYPE, --关联单号类型，1色布生产单/ 2坯布盘点单/ 3色布领料单/ 4坯布生产单/5面料采购单/6色布入库单
T.RELATE_SKC, --关联SKC
T.COMPANY_ID, --企业编码
T.CREATE_ID, --创建者
T.CREATE_TIME, --创建时间
T.UPDATE_ID, --更新者
T.UPDATE_TIME, --更新时间
T.WHETHER_DEL, --是否删除，0否1是
T.RELATE_PURCHASE_ORDER_NUM --关联采购单号
 FROM SUPPLIER_GREY_IN_OUT_BOUND T  WHERE T.BOUND_NUM = ''' ||
             v_bound_num || '''
';
    RETURN v_sql;
  END f_query_supplier_grey_in_out_bound_by_id;
  --新增 SUPPLIER_GREY_IN_OUT_BOUND
  PROCEDURE p_insert_supplier_grey_in_out_bound(p_suppl_rec supplier_grey_in_out_bound%ROWTYPE) IS
  BEGIN
  
    INSERT INTO supplier_grey_in_out_bound
      (bound_num, ascription, bound_type, pro_supplier_code,
       mater_supplier_code, material_spu, whether_inner_mater, unit, num,
       stock_type, relate_num, relate_num_type, relate_skc, company_id,
       create_id, create_time, update_id, update_time, whether_del,
       relate_purchase_order_num)
    VALUES
      (p_suppl_rec.bound_num, p_suppl_rec.ascription,
       p_suppl_rec.bound_type, p_suppl_rec.pro_supplier_code,
       p_suppl_rec.mater_supplier_code, p_suppl_rec.material_spu,
       p_suppl_rec.whether_inner_mater, p_suppl_rec.unit, p_suppl_rec.num,
       p_suppl_rec.stock_type, p_suppl_rec.relate_num,
       p_suppl_rec.relate_num_type, p_suppl_rec.relate_skc,
       p_suppl_rec.company_id, p_suppl_rec.create_id,
       p_suppl_rec.create_time, p_suppl_rec.update_id,
       p_suppl_rec.update_time, p_suppl_rec.whether_del,
       p_suppl_rec.relate_purchase_order_num);
  END p_insert_supplier_grey_in_out_bound;

  --修改 SUPPLIER_GREY_IN_OUT_BOUND
  PROCEDURE p_update_supplier_grey_in_out_bound(p_suppl_rec supplier_grey_in_out_bound%ROWTYPE) IS
  BEGIN
  
    UPDATE supplier_grey_in_out_bound t
       SET t.ascription                = p_suppl_rec.ascription, --出入库归属，0出库1入库
           t.bound_type                = p_suppl_rec.bound_type, --坯布出入库类型，1色布备料出库/ 2盘亏出库/ 3临时坯转色出库/ 11品牌备料入库/ 12供应商现货入库/ 13盘盈入库/ 14临时补充入库/15 供应商色布入库
           t.pro_supplier_code         = p_suppl_rec.pro_supplier_code, --成品供应商编号
           t.mater_supplier_code       = p_suppl_rec.mater_supplier_code, --物料供应商编号
           t.material_spu              = p_suppl_rec.material_spu, --物料SPU
           t.whether_inner_mater       = p_suppl_rec.whether_inner_mater, --是否内部物料，0否1是
           t.unit                      = p_suppl_rec.unit, --单位
           t.num                       = p_suppl_rec.num, --数量
           t.stock_type                = p_suppl_rec.stock_type, --仓库类型，1品牌仓，2供应商仓
           t.relate_num                = p_suppl_rec.relate_num, --关联单号
           t.relate_num_type           = p_suppl_rec.relate_num_type, --关联单号类型，1色布生产单/ 2坯布盘点单/ 3色布领料单/ 4坯布生产单/5面料采购单/6色布入库单
           t.relate_skc                = p_suppl_rec.relate_skc, --关联SKC
           t.company_id                = p_suppl_rec.company_id, --企业编码
           t.create_id                 = p_suppl_rec.create_id, --创建者
           t.create_time               = p_suppl_rec.create_time, --创建时间
           t.update_id                 = p_suppl_rec.update_id, --更新者
           t.update_time               = p_suppl_rec.update_time, --更新时间
           t.whether_del               = p_suppl_rec.whether_del, --是否删除，0否1是
           t.relate_purchase_order_num = p_suppl_rec.relate_purchase_order_num --关联采购单号
     WHERE t.bound_num = p_suppl_rec.bound_num;
  END p_update_supplier_grey_in_out_bound;

  --删除 SUPPLIER_GREY_IN_OUT_BOUND
  PROCEDURE p_delete_supplier_grey_in_out_bound(p_suppl_rec supplier_grey_in_out_bound%ROWTYPE) IS
  BEGIN
  
    DELETE FROM supplier_grey_in_out_bound t WHERE 1 = 0;
  END p_delete_supplier_grey_in_out_bound;

  --删除 通过ID SUPPLIER_GREY_IN_OUT_BOUND
  PROCEDURE p_delete_supplier_grey_in_out_bound_by_id(p_bound_num VARCHAR2) IS
  
    v_bound_num VARCHAR2(32) := p_bound_num;
  BEGIN
  
    DELETE FROM supplier_grey_in_out_bound t
     WHERE t.bound_num = v_bound_num;
  END p_delete_supplier_grey_in_out_bound_by_id;

  --校验 BOUND_NUM SUPPLIER_GREY_IN_OUT_BOUND
  PROCEDURE p_check_bound_num(p_bound_num VARCHAR2) IS
  
  BEGIN
  
    IF p_bound_num IS NULL THEN
      raise_application_error(-20002, '【坯布出入库单号】必填，请检查！');
    END IF;
  END p_check_bound_num;

  --校验 PRO_SUPPLIER_CODE SUPPLIER_GREY_IN_OUT_BOUND
  PROCEDURE p_check_pro_supplier_code(p_pro_supplier_code VARCHAR2) IS
  
  BEGIN
  
    IF p_pro_supplier_code IS NULL THEN
      raise_application_error(-20002, '【成品供应商编号】必填，请检查！');
    END IF;
  END p_check_pro_supplier_code;

  --校验 MATER_SUPPLIER_CODE SUPPLIER_GREY_IN_OUT_BOUND
  PROCEDURE p_check_mater_supplier_code(p_mater_supplier_code VARCHAR2) IS
  
  BEGIN
  
    IF p_mater_supplier_code IS NULL THEN
      raise_application_error(-20002, '【物料供应商编号】必填，请检查！');
    END IF;
  END p_check_mater_supplier_code;

  --校验 MATERIAL_SPU SUPPLIER_GREY_IN_OUT_BOUND
  PROCEDURE p_check_material_spu(p_material_spu VARCHAR2) IS
  
  BEGIN
  
    IF p_material_spu IS NULL THEN
      raise_application_error(-20002, '【物料SPU】必填，请检查！');
    END IF;
  END p_check_material_spu;

  --校验 UNIT SUPPLIER_GREY_IN_OUT_BOUND
  PROCEDURE p_check_unit(p_unit VARCHAR2) IS
  
  BEGIN
  
    IF p_unit IS NULL THEN
      raise_application_error(-20002, '【单位】必填，请检查！');
    END IF;
  END p_check_unit;

  --校验 COMPANY_ID SUPPLIER_GREY_IN_OUT_BOUND
  PROCEDURE p_check_company_id(p_company_id VARCHAR2) IS
  
  BEGIN
  
    IF p_company_id IS NULL THEN
      raise_application_error(-20002, '【企业编码】必填，请检查！');
    END IF;
  END p_check_company_id;

  --校验 CREATE_ID SUPPLIER_GREY_IN_OUT_BOUND
  PROCEDURE p_check_create_id(p_create_id VARCHAR2) IS
  
  BEGIN
  
    IF p_create_id IS NULL THEN
      raise_application_error(-20002, '【创建者】必填，请检查！');
    END IF;
  END p_check_create_id;

  --校验 CREATE_TIME SUPPLIER_GREY_IN_OUT_BOUND
  PROCEDURE p_check_create_time(p_create_time DATE) IS
  
  BEGIN
  
    IF p_create_time IS NULL THEN
      raise_application_error(-20002, '【创建时间】必填，请检查！');
    END IF;
  END p_check_create_time;
  --调用 SUPPLIER_GREY_IN_OUT_BOUND
  PROCEDURE p_invoke_supplier_grey_in_out_bound(p_suppl_rec supplier_grey_in_out_bound%ROWTYPE) IS
  BEGIN
  
    mrp.pkg_supplier_grey_in_out_bound.p_check_bound_num(p_bound_num => p_suppl_rec.bound_num);
    mrp.pkg_supplier_grey_in_out_bound.p_check_pro_supplier_code(p_pro_supplier_code => p_suppl_rec.pro_supplier_code);
    mrp.pkg_supplier_grey_in_out_bound.p_check_mater_supplier_code(p_mater_supplier_code => p_suppl_rec.mater_supplier_code);
    mrp.pkg_supplier_grey_in_out_bound.p_check_material_spu(p_material_spu => p_suppl_rec.material_spu);
    mrp.pkg_supplier_grey_in_out_bound.p_check_unit(p_unit => p_suppl_rec.unit);
    mrp.pkg_supplier_grey_in_out_bound.p_check_company_id(p_company_id => p_suppl_rec.company_id);
    mrp.pkg_supplier_grey_in_out_bound.p_check_create_id(p_create_id => p_suppl_rec.create_id);
    mrp.pkg_supplier_grey_in_out_bound.p_check_create_time(p_create_time => p_suppl_rec.create_time);
  END p_invoke_supplier_grey_in_out_bound;

END pkg_supplier_grey_in_out_bound;
/

