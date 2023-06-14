CREATE OR REPLACE PACKAGE mrp.pkg_material_grey_in_out_bound IS
  -- Author  : CZH55
  -- Created : 2023/4/25 17:39:55
  -- Purpose : 物料供应商坯布出入库单-基础程序包

  --查询 MATERIAL_GREY_IN_OUT_BOUND
  FUNCTION f_query_material_grey_in_out_bound RETURN CLOB;

  --查询 通过ID MATERIAL_GREY_IN_OUT_BOUND
  FUNCTION f_query_material_grey_in_out_bound_by_id(p_bound_num VARCHAR2)
    RETURN CLOB;

  --新增 MATERIAL_GREY_IN_OUT_BOUND
  PROCEDURE p_insert_material_grey_in_out_bound(p_mater_rec material_grey_in_out_bound%ROWTYPE);

  --修改 MATERIAL_GREY_IN_OUT_BOUND
  PROCEDURE p_update_material_grey_in_out_bound(p_mater_rec material_grey_in_out_bound%ROWTYPE);

  --删除 MATERIAL_GREY_IN_OUT_BOUND
  PROCEDURE p_delete_material_grey_in_out_bound(p_mater_rec material_grey_in_out_bound%ROWTYPE);

  --删除 通过ID MATERIAL_GREY_IN_OUT_BOUND
  PROCEDURE p_delete_material_grey_in_out_bound_by_id(p_bound_num VARCHAR2);

  --校验 BOUND_NUM MATERIAL_GREY_IN_OUT_BOUND
  PROCEDURE p_check_bound_num(p_bound_num VARCHAR2);

  --校验 MATERIAL_SPU MATERIAL_GREY_IN_OUT_BOUND
  PROCEDURE p_check_material_spu(p_material_spu VARCHAR2);

  --校验 CREATE_ID MATERIAL_GREY_IN_OUT_BOUND
  PROCEDURE p_check_create_id(p_create_id VARCHAR2);

  --校验 CREATE_TIME MATERIAL_GREY_IN_OUT_BOUND
  PROCEDURE p_check_create_time(p_create_time DATE);
  --调用 MATERIAL_GREY_IN_OUT_BOUND
  PROCEDURE p_invoke_material_grey_in_out_bound(p_mater_rec material_grey_in_out_bound%ROWTYPE);

END pkg_material_grey_in_out_bound;
/
CREATE OR REPLACE PACKAGE BODY mrp.pkg_material_grey_in_out_bound IS
  --查询 MATERIAL_GREY_IN_OUT_BOUND
  FUNCTION f_query_material_grey_in_out_bound RETURN CLOB IS
    v_sql CLOB;
  
  BEGIN
    v_sql := '
SELECT t.bound_num, --坯布出入库单号
       t.ascription, --出入库归属，0出库1入库
       t.bound_type, --出入库类型，1色布备料出库/ 2盘亏出库/ 3临时坯转色出库/ 4坯布备料出库/ 11品牌备料入库/ 12供应商现货入库/ 13盘盈入库/ 14临时补充入库
       t.mater_supplier_code, --物料供应商编号
       t.material_spu, --物料SPU
       t.unit, --单位
       t.num, --数量
       t.stock_type, --仓库类型，1品牌仓，2供应商仓
       t.relate_num, --关联单号
       t.relate_num_type, --关联单号类型，1色布生产单/ 2坯布盘点单/ 3色布领料单/ 4坯布生产单/5面料采购单/6色布入库单
       t.relate_skc, --关联SKC
       t.company_id, --企业编码
       t.create_id, --创建者
       t.create_time, --创建时间，入库时间
       t.update_id, --更新者
       t.update_time, --更新时间
       t.whether_del, --是否删除，0否1是
       t.relate_purchase_order_num --关联采购单号
  FROM material_grey_in_out_bound t
 WHERE 1 = 1
';
    RETURN v_sql;
  END f_query_material_grey_in_out_bound;
  --查询 通过ID MATERIAL_GREY_IN_OUT_BOUND
  FUNCTION f_query_material_grey_in_out_bound_by_id(p_bound_num VARCHAR2)
    RETURN CLOB IS
    v_sql CLOB;
  
    v_bound_num VARCHAR2(32) := p_bound_num;
  BEGIN
    v_sql := '
SELECT t.bound_num, --坯布出入库单号
       t.ascription, --出入库归属，0出库1入库
       t.bound_type, --出入库类型，1色布备料出库/ 2盘亏出库/ 3临时坯转色出库/ 4坯布备料出库/ 11品牌备料入库/ 12供应商现货入库/ 13盘盈入库/ 14临时补充入库
       t.mater_supplier_code, --物料供应商编号
       t.material_spu, --物料SPU
       t.unit, --单位
       t.num, --数量
       t.stock_type, --仓库类型，1品牌仓，2供应商仓
       t.relate_num, --关联单号
       t.relate_num_type, --关联单号类型，1色布生产单/ 2坯布盘点单/ 3色布领料单/ 4坯布生产单/5面料采购单/6色布入库单
       t.relate_skc, --关联SKC
       t.company_id, --企业编码
       t.create_id, --创建者
       t.create_time, --创建时间，入库时间
       t.update_id, --更新者
       t.update_time, --更新时间
       t.whether_del, --是否删除，0否1是
       t.relate_purchase_order_num --关联采购单号
  FROM material_grey_in_out_bound t
 WHERE t.bound_num = ''' || v_bound_num || '''
';
    RETURN v_sql;
  END f_query_material_grey_in_out_bound_by_id;
  --新增 MATERIAL_GREY_IN_OUT_BOUND
  PROCEDURE p_insert_material_grey_in_out_bound(p_mater_rec material_grey_in_out_bound%ROWTYPE) IS
  BEGIN
  
    INSERT INTO material_grey_in_out_bound
      (bound_num, ascription, bound_type, mater_supplier_code, material_spu,
       unit, num, stock_type, relate_num, relate_num_type, relate_skc,
       company_id, create_id, create_time, update_id, update_time,
       whether_del, relate_purchase_order_num)
    VALUES
      (p_mater_rec.bound_num, p_mater_rec.ascription,
       p_mater_rec.bound_type, p_mater_rec.mater_supplier_code,
       p_mater_rec.material_spu, p_mater_rec.unit, p_mater_rec.num,
       p_mater_rec.stock_type, p_mater_rec.relate_num,
       p_mater_rec.relate_num_type, p_mater_rec.relate_skc,
       p_mater_rec.company_id, p_mater_rec.create_id,
       p_mater_rec.create_time, p_mater_rec.update_id,
       p_mater_rec.update_time, p_mater_rec.whether_del,
       p_mater_rec.relate_purchase_order_num);
  END p_insert_material_grey_in_out_bound;

  --修改 MATERIAL_GREY_IN_OUT_BOUND
  PROCEDURE p_update_material_grey_in_out_bound(p_mater_rec material_grey_in_out_bound%ROWTYPE) IS
  BEGIN
  
    UPDATE material_grey_in_out_bound t
       SET t.ascription                = p_mater_rec.ascription, --出入库归属，0出库1入库
           t.bound_type                = p_mater_rec.bound_type, --出入库类型，1色布备料出库/ 2盘亏出库/ 3临时坯转色出库/ 4坯布备料出库/ 11品牌备料入库/ 12供应商现货入库/ 13盘盈入库/ 14临时补充入库
           t.mater_supplier_code       = p_mater_rec.mater_supplier_code, --物料供应商编号
           t.material_spu              = p_mater_rec.material_spu, --物料SPU
           t.unit                      = p_mater_rec.unit, --单位
           t.num                       = p_mater_rec.num, --数量
           t.stock_type                = p_mater_rec.stock_type, --仓库类型，1品牌仓，2供应商仓
           t.relate_num                = p_mater_rec.relate_num, --关联单号
           t.relate_num_type           = p_mater_rec.relate_num_type, --关联单号类型，1色布生产单/ 2坯布盘点单/ 3色布领料单/ 4坯布生产单/5面料采购单/6色布入库单
           t.relate_skc                = p_mater_rec.relate_skc, --关联SKC
           t.company_id                = p_mater_rec.company_id, --企业编码
           t.create_id                 = p_mater_rec.create_id, --创建者
           t.create_time               = p_mater_rec.create_time, --创建时间，入库时间
           t.update_id                 = p_mater_rec.update_id, --更新者
           t.update_time               = p_mater_rec.update_time, --更新时间
           t.whether_del               = p_mater_rec.whether_del, --是否删除，0否1是
           t.relate_purchase_order_num = p_mater_rec.relate_purchase_order_num --关联采购单号
     WHERE t.bound_num = p_mater_rec.bound_num;
  END p_update_material_grey_in_out_bound;

  --删除 MATERIAL_GREY_IN_OUT_BOUND
  PROCEDURE p_delete_material_grey_in_out_bound(p_mater_rec material_grey_in_out_bound%ROWTYPE) IS 
  BEGIN
  
    DELETE FROM material_grey_in_out_bound t WHERE 1 = 0;
  END p_delete_material_grey_in_out_bound;

  --删除 通过ID MATERIAL_GREY_IN_OUT_BOUND
  PROCEDURE p_delete_material_grey_in_out_bound_by_id(p_bound_num VARCHAR2) IS
  
    v_bound_num VARCHAR2(32) := p_bound_num;
  BEGIN
  
    DELETE FROM material_grey_in_out_bound t
     WHERE t.bound_num = v_bound_num;
  END p_delete_material_grey_in_out_bound_by_id;

  --校验 BOUND_NUM MATERIAL_GREY_IN_OUT_BOUND
  PROCEDURE p_check_bound_num(p_bound_num VARCHAR2) IS
  
  BEGIN
  
    IF p_bound_num IS NULL THEN
      raise_application_error(-20002, '【坯布出入库单号】必填，请检查！');
    END IF;
  END p_check_bound_num;

  --校验 MATERIAL_SPU MATERIAL_GREY_IN_OUT_BOUND
  PROCEDURE p_check_material_spu(p_material_spu VARCHAR2) IS
  
  BEGIN
  
    IF p_material_spu IS NULL THEN
      raise_application_error(-20002, '【物料SPU】必填，请检查！');
    END IF;
  END p_check_material_spu;

  --校验 CREATE_ID MATERIAL_GREY_IN_OUT_BOUND
  PROCEDURE p_check_create_id(p_create_id VARCHAR2) IS
  
  BEGIN
  
    IF p_create_id IS NULL THEN
      raise_application_error(-20002, '【创建者】必填，请检查！');
    END IF;
  END p_check_create_id;

  --校验 CREATE_TIME MATERIAL_GREY_IN_OUT_BOUND
  PROCEDURE p_check_create_time(p_create_time DATE) IS
  
  BEGIN
  
    IF p_create_time IS NULL THEN
      raise_application_error(-20002,
                              '【创建时间，入库时间】必填，请检查！');
    END IF;
  END p_check_create_time;
  --调用 MATERIAL_GREY_IN_OUT_BOUND
  PROCEDURE p_invoke_material_grey_in_out_bound(p_mater_rec material_grey_in_out_bound%ROWTYPE) IS
  BEGIN
  
    mrp.pkg_material_grey_in_out_bound.p_check_bound_num(p_bound_num => p_mater_rec.bound_num);
    mrp.pkg_material_grey_in_out_bound.p_check_material_spu(p_material_spu => p_mater_rec.material_spu);
    mrp.pkg_material_grey_in_out_bound.p_check_create_id(p_create_id => p_mater_rec.create_id);
    mrp.pkg_material_grey_in_out_bound.p_check_create_time(p_create_time => p_mater_rec.create_time);
  END p_invoke_material_grey_in_out_bound;

END pkg_material_grey_in_out_bound;
/
