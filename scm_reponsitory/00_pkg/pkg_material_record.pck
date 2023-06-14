create or replace package scmdata.pkg_material_record is

  -- Author  : zwh73
  -- Created : 2020/10/12 14:00:08
  -- Purpose : 物料列表管理
  --商品档案使用物料
  Procedure p_use_material_record_item(pi_material_record_item_id in varchar2,
                                       pi_commodity_info_id       in varchar2,
                                       pi_company_id              in varchar2);

  --商品档案删除物料
  Procedure p_disuse_material_record_item(pi_commodity_material_id in varchar2);

  --计算参考均价
  Procedure p_calculate_avarage_price(pi_material_record_id in varchar2);
  --校验物料编码（内部物料编码）是否企业级唯一，返回0为是唯一的
  Function f_check_material_code(pi_material_code varchar2,
                                 pi_company_id    varchar2) return number;

  --判断物料档案是否可以被删除，返回0为可以
  Function f_can_delete_material_record(pi_material_record_id   varchar2,
                                        pi_material_record_code varchar2,
                                        pi_company_id           varchar2)
    return number;
  --判断物料明细是否可以被删除，返回0为可以
  Function f_can_delete_material_record_item(pi_material_record_item_code varchar2,
                                             pi_company_id                in varchar2)
    return number;

  --导入主档校验
  PROCEDURE check_importdatas_material_record(p_material_record_import_temp_id IN VARCHAR2);

  --提交主档
  PROCEDURE submit_material_record(p_company_id IN VARCHAR2,
                                   p_user_id    IN VARCHAR2);

  --导入明细校验
  PROCEDURE check_importdatas_material_record_item(p_material_record_item_import_id IN VARCHAR2);

  --提交明细
  PROCEDURE submit_material_record_item(p_company_id IN VARCHAR2,
                                        p_user_id    IN VARCHAR2);

  PROCEDURE check_importdatas_material_record_cate(p_material_record_cate_temp_id IN VARCHAR2);

  PROCEDURE submit_material_record_cate(p_company_id IN VARCHAR2,
                                        p_user_id    IN VARCHAR2);
end pkg_material_record;
/

create or replace package body scmdata.pkg_material_record is

  --商品档案使用物料
  Procedure p_use_material_record_item(pi_material_record_item_id in varchar2,
                                       pi_commodity_info_id       in varchar2,
                                       pi_company_id              in varchar2) is
    p_material_record      t_material_record%rowtype;
    p_material_record_item t_material_record_item%rowtype;
    p_commodity_info       t_commodity_info%rowtype;
  begin
    --将物料明细的内容选出来
    select *
      into p_material_record_item
      from t_material_record_item
     where material_record_item_id = pi_material_record_item_id;
    --将物料档案内容选出来
    select *
      into p_material_record
      from t_material_record
     where material_record_id = p_material_record_item.material_record_id;
    --将商品档案内容选出来
    select *
      into p_commodity_info
      from t_commodity_info
     where commodity_info_id = pi_commodity_info_id;
    --插入商品物料档案
    insert into t_commodity_material_record
      (commodity_material_id,
       commodity_info_id,
       company_id,
       material_record_code,
       material_type,
       goo_id,
       material_record_item_code)
    values
      (f_get_uuid(),
       pi_commodity_info_id,
       pi_company_id,
       p_material_record.material_record_code,
       p_material_record.material_type,
       p_commodity_info.goo_id,
       p_material_record_item.material_record_item_code);
    --插入使用记录
    insert into t_material_use_record
      (material_use_id,
       company_id,
       material_record_id,
       material_record_item_id,
       goo_id,
       style_number,
       origin,
       style_name,
       product_supplier,
       color,
       specification,
       price,
       price_unit,
       materials,
       materials_unit,
       use_time,
       remarks,
       rela_goo_id)
    values
      (f_get_uuid(),
       pi_company_id,
       p_material_record_item.material_record_id,
       pi_material_record_item_id,
       p_commodity_info.goo_id,
       p_commodity_info.style_number,
       p_material_record.origin,
       p_commodity_info.style_name,
       p_commodity_info.supplier_code,
       p_material_record_item.color,
       p_material_record_item.specification,
       p_material_record_item.firm_price,
       p_material_record_item.unit,
       null,
       null,
       sysdate,
       null,
       p_commodity_info.rela_goo_id);
    pkg_material_record.p_calculate_avarage_price(p_material_record_item.material_record_id);
  end p_use_material_record_item;

  --商品档案删除物料
  Procedure p_disuse_material_record_item(pi_commodity_material_id in varchar2) is
    p_commodity_material t_commodity_material_record%rowtype;
    p_material_record_id varchar2(32);
  begin
    --将需要删除的商品物料档案选出
    select a.*
      into p_commodity_material
      from t_commodity_material_record a
     where a.commodity_material_id = pi_commodity_material_id;
    --找到物料的id
    select material_record_id
      into p_material_record_id
      from t_material_record a
     where a.material_record_code =
           p_commodity_material.material_record_code
       and a.company_id = p_commodity_material.company_id;
    --删除对应使用记录
    delete from t_material_use_record
     where company_id = p_commodity_material.company_id
       and style_number =
           (select style_number
              from t_commodity_info
             where commodity_info_id =
                   p_commodity_material.commodity_info_id)
       and material_record_item_id =
           (select material_record_item_id
              from t_material_record_item
             where material_record_item_code =
                   p_commodity_material.material_record_item_code);
    --删除商品档案物料
    delete from t_commodity_material_record
     where commodity_material_id = pi_commodity_material_id;
    pkg_material_record.p_calculate_avarage_price(p_material_record_id);
  end p_disuse_material_record_item;

  --计算参考均价
  Procedure p_calculate_avarage_price(pi_material_record_id in varchar2) is
    p_result number(32, 8);
  begin
    select max(price)
      into p_result
      from t_material_use_record
    
     where use_time =
           (select max(use_time)
              from t_material_use_record
             where material_record_id = pi_material_record_id);
    if p_result is null then
      select avg(firm_price)
        into p_result
        from t_material_record_item
       where material_record_id = pi_material_record_id
         and pause = 0;
    end if;
    update t_material_record
       set average_price = p_result
     where material_record_id = pi_material_record_id;
  end p_calculate_avarage_price;

  --校验物料编码（内部物料编码）是否企业级唯一，返回0为是唯一的（暂时禁用)
  Function f_check_material_code(pi_material_code varchar2,
                                 pi_company_id    varchar2) return number is
    p_result number(1);
  begin
    select nvl(max(1), 0)
      into p_result
      from t_material_record
     where company_id = pi_company_id
       and material_code = pi_material_code;
    return p_result;
  end f_check_material_code;

  --判断物料档案是否可以被删除，返回0为可以
  Function f_can_delete_material_record(pi_material_record_id   varchar2,
                                        pi_material_record_code varchar2,
                                        pi_company_id           varchar2)
    return number is
    p_result number(1);
  begin
    select nvl(max(1), 0)
      into p_result
      from t_material_record_item
     where material_record_id = pi_material_record_id;
    if p_result = 0 then
      select nvl(max(1), 0)
        into p_result
        from t_commodity_material_record a
       where a.material_record_code = pi_material_record_code
         and company_id = pi_company_id;
    end if;
    return p_result;
  end f_can_delete_material_record;

  --判断物料明细是否可以被删除 返回0为可以
  Function f_can_delete_material_record_item(pi_material_record_item_code varchar2,
                                             pi_company_id                in varchar2)
    return number is
    p_result number(1);
  begin
    select nvl(max(1), 0)
      into p_result
      from t_commodity_material_record a
     where a.material_record_item_code = pi_material_record_item_code
       and company_id = pi_company_id;
    return p_result;
  end f_can_delete_material_record_item;

  --导入主档校验
  PROCEDURE check_importdatas_material_record(p_material_record_import_temp_id IN VARCHAR2) is
    p_t_material_record_import_temp scmdata.t_material_record_import_temp%ROWTYPE;
    p_flag                          INT;
    p_i                             INT;
    p_i2                            int;
    p_msg                           VARCHAR2(1000);
    p_desc                          VARCHAR2(256);
    p_temp_id                       varchar2(32);
    p_type_code                     varchar2(32);
    p_big_code                      varchar2(32);
    p_small_code                    varchar2(32);
  BEGIN
    p_i := 0;
    SELECT t.*
      INTO p_t_material_record_import_temp
      FROM scmdata.t_material_record_import_temp t
     WHERE t.t_material_record_import_temp_id =
           p_material_record_import_temp_id;
  
    --编号是否重复
    SELECT MAX(t.material_code)
      INTO p_temp_id
      FROM scmdata.t_material_record t
     WHERE t.material_code = p_t_material_record_import_temp.material_code
       AND t.company_id = p_t_material_record_import_temp.company_id;
    IF p_temp_id IS NOT NULL THEN
      p_i   := p_i + 1;
      p_msg := p_msg || p_i || ')物料档案中已存在重复的物料编码';
    END IF;
    SELECT COUNT(*)
      INTO p_flag
      FROM t_material_record_import_temp t
     WHERE t.material_code = p_t_material_record_import_temp.material_code
       AND t.create_id = p_t_material_record_import_temp.create_id
       AND t.company_id = p_t_material_record_import_temp.company_id;
    IF p_flag > 1 THEN
      p_i   := p_i + 1;
      p_msg := p_msg || p_i || ')本次导入的物料档案中存在重复的物料编码，请检查';
    END IF;
  
    --检验物料类型
    SELECT MAX(a.group_dict_value)
      INTO p_type_code
      FROM sys_group_dict a
     WHERE a.group_dict_name =
           p_t_material_record_import_temp.material_type
       AND a.group_dict_type = 'MATERIAL_OBJECT_TYPE'
       AND pause = 0;
    IF p_type_code IS NULL THEN
      p_i   := p_i + 1;
      p_msg := p_msg || p_i || ')请输入正确的物料类型,';
    END IF;
  
    --检测大类
    SELECT MAX(a.group_dict_value)
      INTO p_big_code
      FROM sys_group_dict a
     WHERE a.group_dict_name = p_t_material_record_import_temp.big_category
       AND a.group_dict_type = p_type_code
          
       AND pause = 0;
    if p_type_code is not null and p_big_code IS NULL THEN
      p_i   := p_i + 1;
      p_msg := p_msg || p_i || ')请输入正确的大类';
    END IF;
    --检验小类
    SELECT MAX(a.group_dict_value)
      INTO p_small_code
      FROM sys_group_dict a
     WHERE a.group_dict_name =
           p_t_material_record_import_temp.small_category
       AND a.group_dict_type = p_big_code
       AND pause = 0;
    IF p_big_code is not null and p_small_code IS NULL THEN
      p_i   := p_i + 1;
      p_msg := p_msg || p_i || ')请输入正确的小类';
    
    END IF;
  
    --检验单位
    SELECT MAX(a.group_dict_value)
      INTO p_desc
      FROM sys_group_dict a
     WHERE a.group_dict_name = p_t_material_record_import_temp.unit
       AND a.group_dict_type = 'PRICE_UNIT'
       AND pause = 0;
    IF p_desc IS NULL THEN
      p_i   := p_i + 1;
      p_msg := p_msg || p_i || ')请输入正确的单位';
    END IF;
  
    if p_t_material_record_import_temp.product_category is not null then
    
      SELECT listagg(a.group_dict_value, ';') within GROUP(ORDER BY 1)
        INTO p_desc
        FROM sys_group_dict a
       WHERE instr(';' || p_t_material_record_import_temp.product_category || ';',
                   ';' || a.group_dict_name || ';') > 0
         AND a.group_dict_type = p_big_code || '_SUIT';
    
      if p_desc is null then
        p_i   := p_i + 1;
        p_msg := p_msg || p_i || ')适用产品类别错误';
      else
      
        SELECT nvl(length(regexp_replace(p_desc, '[^;]', '')), 0),
               nvl(length(regexp_replace(p_t_material_record_import_temp.product_category,
                                         '[^;]',
                                         '')),
                   0)
          into p_i2, p_flag
          FROM dual;
        if p_i2 <> p_flag then
          p_i   := p_i + 1;
          p_msg := p_msg || p_i || ')适用产品类别错误';
        end if;
      end if;
    end if;
    --修改信息
    IF p_msg IS NOT NULL THEN
      UPDATE scmdata.t_material_record_import_temp t
         SET t.msg_type = 'E', t.error_msg = p_msg
       WHERE t.t_material_record_import_temp_id =
             p_material_record_import_temp_id;
    ELSE
      UPDATE scmdata.t_material_record_import_temp t
         SET t.msg_type = 'N', t.error_msg = NULL
       WHERE t.t_material_record_import_temp_id =
             p_material_record_import_temp_id;
    END IF;
  
  end;

  --提交主档
  PROCEDURE submit_material_record(p_company_id IN VARCHAR2,
                                   p_user_id    IN VARCHAR2) is
    p_id         VARCHAR2(32);
    p_code       varchar2(32);
    p_type_code  varchar2(32);
    p_big_code   varchar2(32);
    p_small_code varchar2(32);
    p_pro_code   varchar2(32);
  BEGIN
    FOR data_rec IN (SELECT *
                       FROM scmdata.t_material_record_import_temp t
                      WHERE t.company_id = p_company_id
                        AND t.create_id = p_user_id) LOOP
      IF data_rec.msg_type = 'E' OR data_rec.msg_type IS NULL THEN
        raise_application_error(-20002,
                                '请检查数据是否都已检验成功，修改正确后再提交!');
      ELSE
        p_id := f_get_uuid();
      
        p_code := pkg_plat_comm.f_getkeyid_plat(upper('WL'),
                                                upper('SEQ_t_material_record'),
                                                99);
        --获取供应商内部企业级编号
        --获取子类
        SELECT a.group_dict_value
          into p_type_code
          FROM sys_group_dict a
         WHERE a.group_dict_name = data_rec.material_type
           AND a.group_dict_type = 'MATERIAL_OBJECT_TYPE';
      
        SELECT a.group_dict_value
          into p_big_code
          FROM sys_group_dict a
         WHERE a.group_dict_name = data_rec.big_category
           AND a.group_dict_type = p_type_code;
      
        SELECT a.group_dict_value
          into p_small_code
          FROM sys_group_dict a
         WHERE a.group_dict_name = data_rec.small_category
           AND a.group_dict_type = p_big_code;
        SELECT listagg(a.group_dict_value, ';') within GROUP(ORDER BY 1)
          INTO p_pro_code
          FROM sys_group_dict a
         WHERE instr(';' || data_rec.product_category || ';',
                     ';' || a.group_dict_name || ';') > 0
           AND a.group_dict_type = p_big_code || '_SUIT';
        --开始新增
        insert into scmdata.t_material_record
          (material_record_id,
           company_id,
           material_pic,
           material_name,
           ingredient,
           material_record_code,
           material_code,
           material_type,
           big_category,
           small_category,
           average_price,
           unit,
           supplier_code,
           product_category,
           create_id,
           create_time,
           origin,
           remarks,
           update_id,
           update_time,
           pause,
           orgin_material_record_id,
           SUPPLIER_NAME)
        values
          (p_id,
           p_company_id,
           data_rec.material_pic,
           data_rec.material_name,
           data_rec.ingredient,
           p_code,
           data_rec.material_code,
           p_type_code,
           p_big_code,
           p_small_code,
           data_rec.average_price,
           (SELECT a.group_dict_value
              FROM sys_group_dict a
             WHERE a.group_dict_name = data_rec.unit
               AND a.group_dict_type = 'PRICE_UNIT'),
           data_rec.supplier_code,
           p_pro_code,
           p_user_id,
           sysdate,
           'IN_CREATE',
           null,
           p_user_id,
           sysdate,
           0,
           data_rec.orgin_material_record_id,
           data_rec.supplier_name);
      
      END IF;
    end loop;
    delete from t_material_record_import_temp
     where company_id = p_company_id
       and create_id = p_user_id;
  end submit_material_record;
  --导入明细校验
  PROCEDURE check_importdatas_material_record_item(p_material_record_item_import_id IN VARCHAR2) is
    p_t_material_record_item_import scmdata.t_material_record_item_import%ROWTYPE;
    p_i                             INT;
    p_msg                           VARCHAR2(3000);
    p_desc                          VARCHAR2(100);
    p_temp_id                       varchar2(32);
    p_warning                       varchar2(500);
    p_warning_i                     int;
    p_unit                          varchar2(32);
  BEGIN
    p_i := 0;
    SELECT t.*
      INTO p_t_material_record_item_import
      FROM scmdata.t_material_record_item_import t
     WHERE t.material_record_item_import_id =
           p_material_record_item_import_id;
  
    --物料编码对应的物料档案不存在
    SELECT MAX(t.material_record_id), max(unit)
      INTO p_temp_id, p_unit
      FROM scmdata.t_material_record t
     WHERE t.material_code = p_t_material_record_item_import.material_code
       AND t.company_id = p_t_material_record_item_import.company_id;
    IF p_temp_id IS NULL THEN
      p_i   := p_i + 1;
      p_msg := p_msg || p_i || ')物料编码对应的物料档案不存在';
    END IF;
  
    --单位新增
    update t_material_record_item_import a
       set a.unit = p_unit
     where a.material_record_item_import_id =
           p_material_record_item_import_id;
  
    IF p_t_material_record_item_import.price IS NULL THEN
      p_i   := p_i + 1;
      p_msg := p_msg || p_i || ')请输入正确的报价';
    END IF;
  
    IF p_t_material_record_item_import.firm_price IS NULL THEN
      p_i   := p_i + 1;
      p_msg := p_msg || p_i || ')请输入正确的确认价格';
    END IF;
  
    if p_temp_id is not null then
      p_warning_i := 0;
      --校验本次导入是否有重复
      select max(a.color)
        into p_desc
        from t_material_record_item_import a
       where a.material_code =
             p_t_material_record_item_import.material_code
         and a.create_id = p_t_material_record_item_import.create_id
         and a.material_record_item_import_id <>
             p_t_material_record_item_import.material_record_item_import_id
         and a.color = p_t_material_record_item_import.color
         and a.company_id = p_t_material_record_item_import.company_id;
      if p_desc is not null then
        p_warning_i := p_warning_i + 1;
        p_warning   := p_warning_i || ')本次导入中，该物料颜色信息重复，请确认是否添加。';
      end if;
    
      select max(a.color)
        into p_desc
        from t_material_record_item a
       where a.material_record_id = p_temp_id
         and a.color = p_t_material_record_item_import.color;
      if p_desc is not null then
        p_warning_i := p_warning_i + 1;
        p_warning   := p_warning || p_warning_i || ')已有该颜色信息，确认是否重新添加。';
      end if;
    END IF;
  
    if p_warning is not null then
      p_warning := '警告：' || p_warning;
    end if;
    --修改信息
    IF p_msg IS NOT NULL THEN
      UPDATE scmdata.t_material_record_item_import t
         SET t.msg_type = 'E', t.error_msg = p_msg || p_warning
       WHERE t.material_record_item_import_id =
             p_material_record_item_import_id;
    ELSE
      UPDATE scmdata.t_material_record_item_import t
         SET t.msg_type = 'N', t.error_msg = p_warning
       WHERE t.material_record_item_import_id =
             p_material_record_item_import_id;
    END IF;
  
  END check_importdatas_material_record_item;

  --提交明细
  PROCEDURE submit_material_record_item(p_company_id IN VARCHAR2,
                                        p_user_id    IN VARCHAR2) is
    p_id                 VARCHAR2(32);
    p_material_record_id varchar2(32);
    p_code               varchar2(32);
  
  BEGIN
    FOR data_rec IN (SELECT *
                       FROM scmdata.t_material_record_item_import t
                      WHERE t.company_id = p_company_id
                        AND t.create_id = p_user_id) LOOP
      IF data_rec.msg_type = 'E' OR data_rec.msg_type IS NULL THEN
        raise_application_error(-20002,
                                '请检查数据是否都已检验成功，修改正确后再提交!');
      ELSE
        p_id := f_get_uuid();
        --找到物料档案
        SELECT MAX(t.material_record_id)
          INTO p_material_record_id
          FROM scmdata.t_material_record t
         WHERE t.material_code = data_rec.material_code
           AND t.company_id = p_company_id;
      
        --生成企业级明细编号
        p_code := pkg_plat_comm.f_getkeyid_plat(upper('WM'),
                                                upper('SEQ_t_material_record_item'),
                                                99);
        --开始新增
        insert into scmdata.t_material_record_item
          (material_record_item_id,
           material_record_id,
           company_id,
           origin,
           color,
           specification,
           price,
           unit,
           create_id,
           create_time,
           remarks,
           pause,
           firm_price,
           material_record_item_code)
        values
          (p_id,
           p_material_record_id,
           p_company_id,
           'IN_CREATE',
           data_rec.color,
           data_rec.specification,
           data_rec.price,
           data_rec.unit,
           p_user_id,
           sysdate,
           data_rec.remarks,
           0,
           data_rec.firm_price,
           p_code);
      
        pkg_material_record.p_calculate_avarage_price(pi_material_record_id => p_material_record_id);
      
      END IF;
    end loop;
    delete from t_material_record_item_import
     where company_id = p_company_id
       and create_id = p_user_id;
  end submit_material_record_item;

  --导入范围校验
  PROCEDURE check_importdatas_material_record_cate(p_material_record_cate_temp_id IN VARCHAR2) is
    p_material_record_category_temp scmdata.t_material_record_category_temp%ROWTYPE;
    p_i                             INT;
    p_msg                           VARCHAR2(3000);
    p_desc                          VARCHAR2(100);
    p_temp_id                       varchar2(32);
    p_unit                          varchar2(32);
    p_flag                          number(1);
  BEGIN
    p_i := 0;
    SELECT t.*
      INTO p_material_record_category_temp
      FROM scmdata.t_material_record_category_temp t
     WHERE t.material_record_category_temp_id =
           p_material_record_cate_temp_id;
  
    --物料编码对应的物料档案不存在
    SELECT MAX(t.material_record_id), max(unit)
      INTO p_temp_id, p_unit
      FROM scmdata.t_material_record t
     WHERE t.material_code = p_material_record_category_temp.material_code
       AND t.company_id = p_material_record_category_temp.company_id;
    IF p_temp_id IS NULL THEN
      p_i   := p_i + 1;
      p_msg := p_msg || p_i || ')物料编码对应的物料档案不存在';
    END IF;
  
    --检测重复
    select nvl(max(1), 0)
      into p_flag
      FROM scmdata.t_material_record_category_temp t
     where t.category = p_material_record_category_temp.category
       and t.product_cate = p_material_record_category_temp.product_cate
       and t.material_record_category_temp_id <>
           p_material_record_cate_temp_id;
    IF p_flag=1 THEN
      p_i   := p_i + 1;
      p_msg := p_msg || p_i || ')本次物料导入过程中存在重复的分类+生产类别';
    end if;
    --检验大类
    SELECT MAX(a.group_dict_value)
      INTO p_material_record_category_temp.CATEGORY_val
      FROM sys_group_dict a
     WHERE a.group_dict_name = p_material_record_category_temp.CATEGORY
       AND a.group_dict_type = 'PRODUCT_TYPE'
       AND pause = 0;
    IF p_material_record_category_temp.CATEGORY_val IS NULL THEN
      p_i   := p_i + 1;
      p_msg := p_msg || p_i || ')不存在的分类';
    ELSE
      update scmdata.t_material_record_category_temp t
         set t.category_val = p_material_record_category_temp.CATEGORY_val
       where t.material_record_category_temp_id =
             p_material_record_cate_temp_id;
    END IF;
  
    --校验分类
    SELECT MAX(a.group_dict_value)
      INTO p_material_record_category_temp.PRODUCT_CATE_VAL
      FROM sys_group_dict a
     WHERE a.group_dict_name = p_material_record_category_temp.PRODUCT_CATE
       AND a.group_dict_type = p_material_record_category_temp.CATEGORY_val
       AND pause = 0;
    IF p_material_record_category_temp.PRODUCT_CATE_VAL IS NULL THEN
      p_i   := p_i + 1;
      p_msg := p_msg || p_i || ')不存在的生产类别';
    ELSE
      UPDATE scmdata.t_material_record_category_temp t
         SET t.PRODUCT_CATE_val = p_material_record_category_temp.PRODUCT_CATE_val
       WHERE material_record_category_temp_id =
             p_material_record_cate_temp_id;
    END IF;
    IF p_temp_id IS NOT NULL AND
       p_material_record_category_temp.PRODUCT_CATE_val IS NOT NULL AND
       p_material_record_category_temp.CATEGORY_val IS NOT NULL THEN
      SELECT nvl(MAX(1), 0)
        INTO p_flag
        FROM scmdata.t_material_record_product_category a
       where a.category = p_material_record_category_temp.CATEGORY_val
         and a.product_cate =
             p_material_record_category_temp.PRODUCT_CATE_VAL
         and a.material_record_id = p_temp_id;
      IF p_flag = 1 THEN
        p_i   := p_i + 1;
        p_msg := p_msg || p_i || ')对应物料档案已有重复的分类+生产类别';
      END IF;
    END IF;
  
    --校验小类
  
    IF p_material_record_category_temp.SMALL_CATEGORY IS NULL THEN
      UPDATE scmdata.t_material_record_category_temp t
         SET SMALL_CATEGORY_val =
             (SELECT listagg(company_dict_value, ';') within GROUP(ORDER BY 1)
                FROM sys_company_dict
               WHERE company_dict_type =
                     p_material_record_category_temp.PRODUCT_CATE_VAL
                 AND company_id = p_material_record_category_temp.company_id),
             SMALL_CATEGORY    =
             (SELECT listagg(company_dict_name, ';') within GROUP(ORDER BY 1)
                FROM sys_company_dict
               WHERE company_dict_type =
                     p_material_record_category_temp.PRODUCT_CATE_VAL
                 AND company_id = p_material_record_category_temp.company_id)
       WHERE material_record_category_temp_id =
             p_material_record_cate_temp_id;
    ELSE
      SELECT listagg(c.company_dict_value, ';') within GROUP(ORDER BY 1)
        INTO p_material_record_category_temp.SMALL_CATEGORY_val
        FROM scmdata.sys_company_dict c
       WHERE c.company_id = p_material_record_category_temp.company_id
         AND company_dict_type =
             p_material_record_category_temp.PRODUCT_CATE_VAL
         AND instr(';' || p_material_record_category_temp.SMALL_CATEGORY || ';',
                   ';' || company_dict_name || ';') > 0;
      IF p_material_record_category_temp.SMALL_CATEGORY_val IS NULL THEN
        p_i   := p_i + 1;
        p_msg := p_msg || p_i || ')不存在的可合作产品子类';
      
      ELSE
        UPDATE scmdata.t_material_record_category_temp t
           SET t.small_category_val = p_material_record_category_temp.SMALL_CATEGORY_val
         WHERE material_record_category_temp_id =
               p_material_record_cate_temp_id;
      
      END IF;
    END IF;
  
    --校验不存在的子类
    SELECT nvl(length(regexp_replace(p_material_record_category_temp.SMALL_CATEGORY_val,
                                     '[^;]',
                                     '')),
               0),
           nvl(length(regexp_replace(p_material_record_category_temp.SMALL_CATEGORY,
                                     '[^;]',
                                     '')),
               0)
      INTO p_i, p_flag
      FROM dual;
    IF p_i <> p_flag THEN
      SELECT listagg(c.company_dict_name, ';') within GROUP(ORDER BY 1)
        INTO p_desc
        FROM scmdata.sys_company_dict c
       WHERE c.company_id = p_material_record_category_temp.company_id
         AND company_dict_type = p_material_record_category_temp.company_id
         AND instr(';' ||
                   p_material_record_category_temp.SMALL_CATEGORY_val || ';',
                   ';' || company_dict_value || ';') > 0;
      p_i   := p_i + 1;
      p_msg := p_msg || p_i || ')有部分产品子类没有在scm中设置，请检查，当前关联部分为：' || p_desc;
    END IF;
    --校驗子類重複
    SELECT COUNT(col) - COUNT(DISTINCT col)
      INTO p_flag
      FROM (SELECT regexp_substr(p_material_record_category_temp.SMALL_CATEGORY_val,
                                 '[^;]+',
                                 1,
                                 LEVEL,
                                 'i') col,
                   LEVEL seq_no
              FROM dual
            CONNECT BY LEVEL <= length(p_material_record_category_temp.SMALL_CATEGORY_val) -
                       length(regexp_replace(p_material_record_category_temp.SMALL_CATEGORY_val,
                                                      ';',
                                                      '')) + 1);
    IF p_flag > 0 THEN
      p_i   := p_i + 1;
      p_msg := p_msg || p_i || ')存在重复的可合作产品子类';
    
    END IF;
  
    --修改信息
    IF p_msg IS NOT NULL THEN
      UPDATE scmdata.t_material_record_category_temp t
         SET t.msg_type = 'E', t.error_msg = p_msg
       WHERE t.material_record_category_temp_id =
             p_material_record_cate_temp_id;
    ELSE
      UPDATE scmdata.t_material_record_category_temp t
         SET t.msg_type = 'N', t.error_msg = null
       WHERE t.material_record_category_temp_id =
             p_material_record_cate_temp_id;
    END IF;
  
  END check_importdatas_material_record_cate;

  --提交明细
  PROCEDURE submit_material_record_cate(p_company_id IN VARCHAR2,
                                        p_user_id    IN VARCHAR2) is
    p_id                 VARCHAR2(32);
    p_material_record_id varchar2(32);
    --  p_code               varchar2(32);
  BEGIN
    FOR data_rec IN (SELECT *
                       FROM scmdata.t_material_record_category_temp t
                      WHERE t.company_id = p_company_id
                        AND t.create_id = p_user_id) LOOP
      IF data_rec.msg_type = 'E' OR data_rec.msg_type IS NULL THEN
        raise_application_error(-20002,
                                '请检查数据是否都已检验成功，修改正确后再提交!');
      ELSE
        p_id := f_get_uuid();
        --找到物料档案
        SELECT MAX(t.material_record_id)
          INTO p_material_record_id
          FROM scmdata.t_material_record t
         WHERE t.material_code = data_rec.material_code
           AND t.company_id = p_company_id;
      
        --开始新增
        insert into scmdata.t_material_record_product_category
          (material_record_product_category_id,
           company_id,
           category,
           product_cate,
           small_category,
           create_id,
           create_time,
           update_id,
           update_time,
           memo,
           pause,
           material_record_id)
        values
          (f_get_uuid(),
           data_rec.company_id,
           data_rec.category_val,
           data_rec.product_cate_val,
           data_rec.small_category_val,
           data_rec.create_id,
           sysdate,
           null,
           null,
           null,
           0,
           (SELECT MAX(t.material_record_id)
              FROM scmdata.t_material_record t
             WHERE t.material_code = data_rec.material_code
               AND t.company_id = data_rec.company_id));
      
      END IF;
    end loop;
    delete from t_material_record_category_temp
     where company_id = p_company_id
       and create_id = p_user_id;
  end submit_material_record_cate;

end pkg_material_record;
/

