CREATE OR REPLACE PACKAGE pkg_ask_record_mange IS

  -- Author  : zwh73
  -- Created : 2020/10/19 15:05:00
  -- Purpose : 合作申请管理

  --是否准入已通过
  FUNCTION is_access_audit_pass(pi_company_id    VARCHAR2,
                                pi_be_company_id VARCHAR2) RETURN NUMBER;

  --是否有正在运行的单子
  FUNCTION is_cooperation_running(pi_company_id    VARCHAR2,
                                  pi_be_company_id VARCHAR2) RETURN NUMBER;

  --是否已建档
  FUNCTION is_supplier_info_build(pi_company_id    VARCHAR2,
                                  pi_be_company_id VARCHAR2) RETURN NUMBER;

  --是否已经申请
  PROCEDURE has_coop_submit(pi_be_company_id      IN VARCHAR2,
                            pi_social_credit_code IN VARCHAR2);

  PROCEDURE has_company_name_repeat(pi_factory_ask_id IN VARCHAR2);

  --校验范围是否重复
  PROCEDURE check_repeat_scope(pi_ask_scope_id               IN VARCHAR2,
                               pi_object_id                  IN VARCHAR2,
                               pi_object_type                IN VARCHAR2,
                               pi_cooperation_classification IN VARCHAR2,
                               pi_cooperation_product_cate   IN VARCHAR2,
                               pi_cooperation_type           IN VARCHAR2);

  -------------------------------czh add 所在分组配置--------------------------------
  --合作申请
  --Query
  --1.成品供应商
  --p_type : 0:合作申请 成品供应商 1:重新申请  2：新增意向供应商
  FUNCTION f_query_coop_fp_supplier(p_type NUMBER) RETURN CLOB;

  --Pick
  --合作品牌/客户
  FUNCTION f_query_coop_brand_picksql(p_brand_field             VARCHAR2,
                                      p_cooperation_brand_field VARCHAR2,
                                      p_suffix                  VARCHAR2)
    RETURN CLOB;
  --lookup
  --生产环节
  FUNCTION f_query_product_link_looksql(p_product_link_field VARCHAR2,
                                        p_suffix             VARCHAR2)
    RETURN CLOB;
  --公司类型
  FUNCTION f_query_company_type_looksql(p_company_type_field VARCHAR2,
                                        p_suffix             VARCHAR2)
    RETURN CLOB;
  --意向合作模式
  FUNCTION f_query_supply_type_looksql(p_supply_type_field VARCHAR2,
                                       p_suffix            VARCHAR2)
    RETURN CLOB;

  --Insert
  --新增成品供应商
  PROCEDURE p_insert_t_ask_record(p_ar_rec scmdata.t_ask_record%ROWTYPE);

  --Update
  --修改成品供应商
  PROCEDURE p_update_t_ask_record(p_ar_rec scmdata.t_ask_record%ROWTYPE);
  --Delete
  PROCEDURE p_delete_t_ask_record(p_ask_record_id VARCHAR2);
  --Check
  --校验申请单状态
  PROCEDURE p_check_ask_flow_status(p_ask_record_id VARCHAR2);

  --校验公司名称
  PROCEDURE p_check_supp_name(p_company_id   VARCHAR2,
                              p_company_name VARCHAR2);
  --校验公司类型为xxx时，意向合作模式只能为xxx
  PROCEDURE p_check_company_type(p_company_type      VARCHAR2,
                                 p_cooperation_model VARCHAR2);
  --保存时校验数据
  --p_type : 0:合作申请 成品供应商/重新申请  1：新增意向供应商
  PROCEDURE p_check_data_by_save(p_ar_rec scmdata.t_ask_record%ROWTYPE,
                                 p_type   NUMBER);

  --2.验厂申请
  --Query p_type : 0 :申请验厂
  FUNCTION f_query_factory_ask(p_type NUMBER DEFAULT NULL) RETURN CLOB;
  --验厂申请  意向合作清单
  FUNCTION f_query_coop_supp_list RETURN CLOB;
  --验厂申请 我的申请记录
  FUNCTION f_query_my_ask_rec RETURN CLOB;
  --验厂申请 待审核申请
  FUNCTION f_query_uncheck_ask_rec RETURN CLOB;
  --验厂申请 已审核申请
  FUNCTION f_query_checked_ask_rec RETURN CLOB;
  --是否紧急
  FUNCTION f_query_lookup_is_urgent RETURN CLOB;
  --生产类型
  FUNCTION f_query_lookup_product_type(p_product_type_field VARCHAR2,
                                       p_suffix             VARCHAR2)
    RETURN CLOB;
  --生产工厂
  FUNCTION f_query_lookup_com_mnfacturer(p_com_mnfacturer_field VARCHAR2,
                                         p_suffix               VARCHAR2)
    RETURN CLOB;
  --关联供应商
  FUNCTION f_query_lookup_rela_supplier(p_rela_supplier_field VARCHAR2,
                                        p_suffix              VARCHAR2)
    RETURN CLOB;
  --Insert 
  --新增验厂申请单（供应商）
  PROCEDURE p_insert_factory_ask(p_fa_rec scmdata.t_factory_ask%ROWTYPE);
  --新增验厂申请单（工厂）
  PROCEDURE p_insert_factory_ask_out(p_fo_rec scmdata.t_factory_ask_out%ROWTYPE);
  --新增意向合作范围
  PROCEDURE p_insert_ask_scope(p_scope_rec scmdata.t_ask_scope%ROWTYPE);
  --Update
  --修改验厂申请单（供应商）
  PROCEDURE p_update_factory_ask(p_fa_rec scmdata.t_factory_ask%ROWTYPE);
  --修改验厂申请单（工厂）
  PROCEDURE p_update_factory_ask_out(p_fo_rec scmdata.t_factory_ask_out%ROWTYPE);
  --Save
  --验厂申请保存
  PROCEDURE p_save_factory_ask(p_fa_rec      scmdata.t_factory_ask%ROWTYPE);
  --除合作申请已提交、验厂待申请、验厂待审批状态外，都不可保存
  FUNCTION f_check_fask_status(p_factory_ask_id VARCHAR2) RETURN BOOLEAN;

  --验厂申请单保存时校验
  PROCEDURE p_check_factory_ask_by_save(p_fa_rec      scmdata.t_factory_ask%ROWTYPE);
  --判断是否生成工厂信息
  FUNCTION f_is_create_fask(p_factory_ask_out_id VARCHAR2) RETURN NUMBER;
  --3. 准入申请
  --待审核申请
  FUNCTION f_query_uncheck_admit_ask RETURN CLOB;
  --已审核申请
  FUNCTION f_query_checked_admit_ask RETURN CLOB;
END pkg_ask_record_mange;
/
CREATE OR REPLACE PACKAGE BODY pkg_ask_record_mange IS
  --是否准入已通过
  FUNCTION is_access_audit_pass(pi_company_id    VARCHAR2,
                                pi_be_company_id VARCHAR2) RETURN NUMBER IS
    p_result NUMBER(1);
  BEGIN
    SELECT nvl(MAX(1), 0)
      INTO p_result
      FROM t_factory_ask a
      LEFT JOIN t_ask_record ar
        ON ar.ask_record_id = a.ask_record_id
     WHERE a.company_id = pi_be_company_id
       AND (a.cooperation_company_id = pi_company_id OR
           ar.company_id = pi_company_id)
       AND a.factrory_ask_flow_status IN ('FA22', 'FA32');
    RETURN p_result;
  END is_access_audit_pass;
  --是否有正在运行的单子
  FUNCTION is_cooperation_running(pi_company_id    VARCHAR2,
                                  pi_be_company_id VARCHAR2) RETURN NUMBER IS
    p_result NUMBER(1);
  BEGIN
    SELECT nvl(MAX(1), 0)
      INTO p_result
      FROM t_factory_ask a
     WHERE a.company_id = pi_be_company_id
       AND a.cooperation_company_id = pi_company_id
       AND a.factrory_ask_flow_status IN ('FA02', 'FA11', 'FA12', ' FA31');
    IF p_result = 0 THEN
      SELECT nvl(MAX(1), 0)
        INTO p_result
        FROM (SELECT *
                FROM t_ask_record
               WHERE company_id = pi_company_id
                 AND be_company_id = pi_be_company_id
                 AND ask_date IS NOT NULL) a
        LEFT JOIN t_factory_ask fa
          ON a.ask_record_id = fa.ask_record_id
       WHERE fa.factrory_ask_flow_status IS NULL
         AND a.coor_ask_flow_status IN ('CA01');
    END IF;
    RETURN p_result;
  END is_cooperation_running;

  --是否已建档
  FUNCTION is_supplier_info_build(pi_company_id    VARCHAR2,
                                  pi_be_company_id VARCHAR2) RETURN NUMBER IS
    p_result NUMBER(1);
  BEGIN
    SELECT nvl(MAX(1), 0)
      INTO p_result
      FROM t_supplier_info tsi
     WHERE tsi.social_credit_code =
           (SELECT licence_num
              FROM sys_company
             WHERE company_id = pi_company_id)
       AND tsi.company_id = pi_be_company_id;
  
    RETURN p_result;
  END is_supplier_info_build;

  PROCEDURE has_coop_submit(pi_be_company_id      IN VARCHAR2,
                            pi_social_credit_code IN VARCHAR2) IS
    p_result NUMBER(1);
  BEGIN
  
    --是否准入已通过 已通过企业的准入合作，不可重新发起申请！
    SELECT nvl(MAX(1), 0)
      INTO p_result
      FROM t_factory_ask a
     WHERE a.company_id = pi_be_company_id
       AND a.social_credit_code = pi_social_credit_code
       AND a.factrory_ask_flow_status IN ('FA22', 'FA32');
    IF p_result = 1 THEN
      raise_application_error(-20002,
                              '已通过企业的准入合作，不可重新发起申请！');
    END IF;
  
    --是否已建档 已是企业的供应商，不需要发起申请
    SELECT nvl(MAX(1), 0)
      INTO p_result
      FROM t_supplier_info tsi
     WHERE tsi.social_credit_code = pi_social_credit_code
       AND tsi.company_id = pi_be_company_id;
    IF p_result = 1 THEN
      raise_application_error(-20002, '已是企业的供应商，不需要发起申请');
    END IF;
    --是否有正在运行的单子 存在申请中的表单，请耐心等待
    SELECT nvl(MAX(1), 0)
      INTO p_result
      FROM t_factory_ask a
     WHERE a.company_id = pi_be_company_id
       AND a.social_credit_code = pi_social_credit_code
       AND a.factrory_ask_flow_status IN ('FA02', 'FA11', 'FA12', 'FA31');
    IF p_result = 0 THEN
      SELECT nvl(MAX(1), 0)
        INTO p_result
        FROM (SELECT *
                FROM t_ask_record
               WHERE social_credit_code = pi_social_credit_code
                 AND be_company_id = pi_be_company_id
                 AND ask_date IS NOT NULL) a
        LEFT JOIN t_factory_ask fa
          ON a.ask_record_id = fa.ask_record_id
       WHERE (fa.factrory_ask_flow_status IS NULL OR
             fa.factrory_ask_flow_status IN ('CA01', 'FA01'))
         AND a.coor_ask_flow_status IN ('CA01');
    END IF;
    IF p_result = 1 THEN
      raise_application_error(-20002, '存在申请中的表单，请耐心等待');
    END IF;
  END has_coop_submit;

  --公司名称是否相同
  PROCEDURE has_company_name_repeat(pi_factory_ask_id IN VARCHAR2) IS
    p_factory_ask scmdata.t_factory_ask%ROWTYPE;
    p_i           INT;
  BEGIN
    SELECT *
      INTO p_factory_ask
      FROM scmdata.t_factory_ask a
     WHERE a.factory_ask_id = pi_factory_ask_id;
    SELECT COUNT(*)
      INTO p_i
      FROM scmdata.t_ask_record a
     WHERE a.company_name = p_factory_ask.company_name
       AND a.be_company_id = p_factory_ask.company_id
       AND a.ask_record_id <> p_factory_ask.ask_record_id
       AND a.coor_ask_flow_status = 'CA01';
    IF p_i >= 1 THEN
      raise_application_error(-20002,
                              '公司名称与当前企业意向合作供应商清单的公司名称重复');
    END IF;
    SELECT COUNT(*)
      INTO p_i
      FROM scmdata.t_factory_ask a
     WHERE a.company_name = p_factory_ask.company_name
       AND a.company_id = p_factory_ask.company_id
       AND a.factory_ask_id <> p_factory_ask.factory_ask_id
       AND (p_factory_ask.ask_record_id IS NULL OR
           p_factory_ask.ask_record_id <> a.ask_record_id)
       AND a.factrory_ask_flow_status IN
           ('FA02', 'FA11', 'FA12', 'FA22', 'FA31');
    IF p_i > 1 THEN
      raise_application_error(-20002,
                              '公司名称与当前企业在准入流程中的公司名称存在重复');
    END IF;
    SELECT COUNT(*)
      INTO p_i
      FROM scmdata.t_supplier_info a
     WHERE a.supplier_company_name = p_factory_ask.company_name
       AND a.company_id = p_factory_ask.company_id;
    IF p_i > 1 THEN
      raise_application_error(-20002,
                              '公司名称与当前企业供应商档案：待建档、已建档的供应商名称重复');
    END IF;
  END has_company_name_repeat;

  PROCEDURE check_repeat_scope(pi_ask_scope_id               IN VARCHAR2,
                               pi_object_id                  IN VARCHAR2,
                               pi_object_type                IN VARCHAR2,
                               pi_cooperation_classification IN VARCHAR2,
                               pi_cooperation_product_cate   IN VARCHAR2,
                               pi_cooperation_type           IN VARCHAR2) IS
    p_i           INT;
    p_coo_clasi   VARCHAR2(48);
    p_coo_product VARCHAR2(48);
  BEGIN
    SELECT nvl(MAX(1), 0)
      INTO p_i
      FROM t_ask_scope a
     WHERE a.ask_scope_id <> pi_ask_scope_id
       AND a.object_id = pi_object_id
       AND a.object_type = pi_object_type
       AND a.cooperation_classification = pi_cooperation_classification
       AND a.cooperation_product_cate = pi_cooperation_product_cate;
    SELECT MAX(group_dict_name)
      INTO p_coo_clasi
      FROM sys_group_dict
     WHERE group_dict_value = pi_cooperation_classification
       AND group_dict_type = pi_cooperation_type;
    SELECT MAX(group_dict_name)
      INTO p_coo_product
      FROM sys_group_dict
     WHERE group_dict_value = pi_cooperation_product_cate
       AND group_dict_type = pi_cooperation_classification;
  
    IF p_i = 1 THEN
      raise_application_error(-20002,
                              '存在重复的' || p_coo_clasi || p_coo_product ||
                              '范围，请检查！');
    END IF;
  END check_repeat_scope;

  -------------------------------czh add 所在分组配置--------------------------------
  --1.合作申请
  --Query
  --1.成品供应商
  --p_type : 0:合作申请 成品供应商  a_coop_121   1:重新申请  a_coop_132_1  2：新增意向供应商 a_coop_151
  FUNCTION f_query_coop_fp_supplier(p_type NUMBER) RETURN CLOB IS
    v_query_sql CLOB;
    v_where     CLOB;
  BEGIN
    IF p_type = 0 THEN
      v_where := ' WHERE a.company_id = %default_company_id%
   AND a.coor_ask_flow_status IN (''CA00'')
   AND be_company_id =
       (SELECT company_id
          FROM t_supplier_type
         WHERE supplier_type_id = :supplier_type_id)
 ORDER BY create_date DESC';
    ELSIF p_type = 1 THEN
      v_where := ' WHERE a.ask_record_id = :ask_record_id';
    ELSIF p_type = 2 THEN
      v_where := ' WHERE COOR_ASK_FLOW_STATUS = ''CA00''
   AND BE_COMPANY_ID = %DEFAULT_COMPANY_ID%
   AND CREATE_ID = %CURRENT_USERID%
   ORDER BY CREATE_DATE DESC ';
    ELSE
      raise_application_error(-20002, '查询类型错误，请联系管理员');
    END IF;
  
    --czh 重构代码
    v_query_sql := 'WITH group_dict AS
 (SELECT t.group_dict_type, t.group_dict_value, t.group_dict_name,t.group_dict_id,t.parent_id
    FROM scmdata.sys_group_dict t
   WHERE t.pause = 0)
SELECT a.ask_record_id,
       a.company_id,
       a.be_company_id,
       a.company_name ask_company_name,
       a.company_abbreviation,
       a.ask_date,
       a.ask_user_id,
       a.social_credit_code,
       (SELECT company_user_name
          FROM sys_company_user
         WHERE user_id = a.ask_user_id
           AND company_id = nvl(a.company_id, a.be_company_id)) ask_user_name,
       a.company_province,
       a.company_city,
       a.company_county,
       dp.province || dc.city || dco.county pcc,
       u.phone ask_user_phone,
       a.company_address,
       a.cooperation_type,
       ga.group_dict_name cooperation_type_desc,
       a.cooperation_model,' || CASE
                     WHEN p_type = 2 THEN
                      NULL
                     ELSE
                      'a.ask_say,'
                   END || '
       a.certificate_file,
       a.other_file,
       a.legal_representative,
       a.company_contact_phone,
       a.company_type,
       --gd.group_dict_name cooperation_brand_desc,
       (SELECT listagg(b.group_dict_name, '';'') within GROUP(ORDER BY b.group_dict_value)
          FROM group_dict t
          LEFT JOIN group_dict b
            ON t.group_dict_type = ''COOPERATION_BRAND''
           AND t.group_dict_id = b.parent_id
           AND instr('';'' || a.brand_type || '';'',
                     '';'' || t.group_dict_value || '';'') > 0
           AND instr('';'' || a.cooperation_brand || '';'',
                     '';'' || b.group_dict_value || '';'') > 0) cooperation_brand_desc,
       a.brand_type,
       a.cooperation_brand,
       a.product_link,
       a.supplier_gate,
       a.supplier_office,
       a.supplier_site,
       a.supplier_product,
       a.coor_ask_flow_status
  FROM t_ask_record a
 INNER JOIN sys_user u
    ON a.ask_user_id = u.user_id
 INNER JOIN group_dict ga
    ON a.cooperation_type = ga.group_dict_value
   AND ga.group_dict_type = ''COOPERATION_TYPE''
  LEFT JOIN dic_province dp
    ON a.company_province = to_char(dp.provinceid)
  LEFT JOIN dic_city dc
    ON a.company_city = to_char(dc.cityno)
  LEFT JOIN dic_county dco
    ON a.company_county = to_char(dco.countyid)
  LEFT JOIN group_dict gd
    ON gd.group_dict_type = ''COOPERATION_BRAND''
   AND gd.group_dict_value = a.cooperation_brand ' ||
                   v_where;
    RETURN v_query_sql;
  END f_query_coop_fp_supplier;

  --Pick
  --合作品牌/客户
  FUNCTION f_query_coop_brand_picksql(p_brand_field             VARCHAR2,
                                      p_cooperation_brand_field VARCHAR2,
                                      p_suffix                  VARCHAR2)
    RETURN CLOB IS
    v_query_sql CLOB;
  BEGIN
    --brand_type,brand_type_desccooperation_brand
    v_query_sql := 'SELECT t.group_dict_value ' || p_brand_field || ',
       t.group_dict_name  ' || p_brand_field || p_suffix || ',
       b.group_dict_value ' || p_cooperation_brand_field || ',
       b.group_dict_name  ' || p_cooperation_brand_field ||
                   p_suffix || '
  FROM scmdata.sys_group_dict t
 INNER JOIN scmdata.sys_group_dict b
    ON t.group_dict_type = ''COOPERATION_BRAND''
   AND t.group_dict_id = b.parent_id
   AND t.pause = 0
   AND b.pause = 0';
    RETURN v_query_sql;
  END f_query_coop_brand_picksql;
  --Look
  --公司类型
  FUNCTION f_query_company_type_looksql(p_company_type_field VARCHAR2,
                                        p_suffix             VARCHAR2)
    RETURN CLOB IS
    v_query_sql CLOB;
  BEGIN
    v_query_sql := 'SELECT t.group_dict_value ' || p_company_type_field ||
                   ',t.group_dict_name ' || p_company_type_field ||
                   p_suffix || ' FROM scmdata.sys_group_dict t
     WHERE t.group_dict_type = ''COMPANY_TYPE''
       AND t.pause = 0';
    RETURN v_query_sql;
  END f_query_company_type_looksql;

  --生产环节
  FUNCTION f_query_product_link_looksql(p_product_link_field VARCHAR2,
                                        p_suffix             VARCHAR2)
    RETURN CLOB IS
    v_query_sql CLOB;
  BEGIN
    v_query_sql := 'SELECT t.group_dict_value ' || p_product_link_field || ',
           t.group_dict_name  ' || p_product_link_field ||
                   p_suffix || '
      FROM scmdata.sys_group_dict t
     WHERE t.group_dict_type = ''PRODUCT_LINK''
       AND t.pause = 0   ';
    RETURN v_query_sql;
  END f_query_product_link_looksql;

  --意向合作模式
  FUNCTION f_query_supply_type_looksql(p_supply_type_field VARCHAR2,
                                       p_suffix            VARCHAR2)
    RETURN CLOB IS
    v_query_sql CLOB;
  BEGIN
    v_query_sql := 'SELECT group_dict_value ' || p_supply_type_field || ',
       group_dict_name  ' || p_supply_type_field ||
                   p_suffix || '
  FROM sys_group_dict
 WHERE group_dict_type = ''SUPPLY_TYPE''
   AND parent_id IS NOT NULL
   AND pause = 0
 ORDER BY group_dict_sort, group_dict_value';
    RETURN v_query_sql;
  END f_query_supply_type_looksql;

  --Insert
  --新增成品供应商
  PROCEDURE p_insert_t_ask_record(p_ar_rec scmdata.t_ask_record%ROWTYPE) IS
  BEGIN
    INSERT INTO t_ask_record
      (ask_record_id,
       company_id,
       be_company_id,
       company_province,
       company_city,
       company_county,
       company_address,
       ask_date,
       ask_user_id,
       ask_say,
       cooperation_type,
       cooperation_model,
       certificate_file,
       other_file,
       create_id,
       create_date,
       update_id,
       update_date,
       remarks,
       coor_ask_flow_status,
       collection,
       origin,
       company_name,
       social_credit_code,
       cooperation_statement,
       sapply_user,
       sapply_phone,
       legal_representative,
       company_contact_phone,
       company_type,
       company_abbreviation,
       brand_type,
       cooperation_brand,
       product_link,
       supplier_gate,
       supplier_office,
       supplier_site,
       supplier_product)
    VALUES
      (p_ar_rec.ask_record_id,
       p_ar_rec.company_id,
       p_ar_rec.be_company_id,
       p_ar_rec.company_province,
       p_ar_rec.company_city,
       p_ar_rec.company_county,
       p_ar_rec.company_address,
       p_ar_rec.ask_date,
       p_ar_rec.ask_user_id,
       p_ar_rec.ask_say,
       p_ar_rec.cooperation_type,
       p_ar_rec.cooperation_model,
       p_ar_rec.certificate_file,
       p_ar_rec.other_file,
       p_ar_rec.create_id,
       p_ar_rec.create_date,
       p_ar_rec.update_id,
       p_ar_rec.update_date,
       p_ar_rec.remarks,
       p_ar_rec.coor_ask_flow_status,
       p_ar_rec.collection,
       p_ar_rec.origin,
       p_ar_rec.company_name,
       p_ar_rec.social_credit_code,
       p_ar_rec.cooperation_statement,
       p_ar_rec.sapply_user,
       p_ar_rec.sapply_phone,
       p_ar_rec.legal_representative,
       p_ar_rec.company_contact_phone,
       p_ar_rec.company_type,
       p_ar_rec.company_abbreviation,
       p_ar_rec.brand_type,
       p_ar_rec.cooperation_brand,
       p_ar_rec.product_link,
       p_ar_rec.supplier_gate,
       p_ar_rec.supplier_office,
       p_ar_rec.supplier_site,
       p_ar_rec.supplier_product);
  EXCEPTION
    WHEN OTHERS THEN
      ROLLBACK;
      sys_raise_app_error_pkg.is_running_error(p_is_running_error => 'T',
                                               p_is_log           => 1);
  END p_insert_t_ask_record;

  --Update
  --修改成品供应商
  PROCEDURE p_update_t_ask_record(p_ar_rec scmdata.t_ask_record%ROWTYPE) IS
  BEGIN
  
    UPDATE t_ask_record t
       SET t.company_address       = p_ar_rec.company_address,
           t.cooperation_type      = p_ar_rec.cooperation_type,
           t.cooperation_model     = p_ar_rec.cooperation_model,
           t.ask_say               = p_ar_rec.ask_say,
           t.certificate_file      = p_ar_rec.certificate_file,
           t.other_file            = p_ar_rec.other_file,
           t.update_id             = p_ar_rec.update_id,
           t.update_date           = p_ar_rec.update_date,
           t.company_province      = p_ar_rec.company_province,
           t.company_city          = p_ar_rec.company_city,
           t.company_county        = p_ar_rec.company_county,
           t.company_abbreviation  = p_ar_rec.company_abbreviation,
           t.company_contact_phone = p_ar_rec.company_contact_phone,
           t.legal_representative  = p_ar_rec.legal_representative,
           t.brand_type            = p_ar_rec.brand_type,
           t.cooperation_brand     = p_ar_rec.cooperation_brand,
           t.product_link          = p_ar_rec.product_link,
           t.supplier_gate         = p_ar_rec.supplier_gate,
           t.supplier_office       = p_ar_rec.supplier_office,
           t.supplier_site         = p_ar_rec.supplier_site,
           t.supplier_product      = p_ar_rec.supplier_product,
           t.company_type          = p_ar_rec.company_type,
           t.sapply_user           = p_ar_rec.sapply_user,
           t.sapply_phone          = p_ar_rec.sapply_phone,
           t.company_name          = p_ar_rec.company_name
    /*  t.ask_date                   = p_ar_rec.ask_date,
    t.ask_user_id                = p_ar_rec.ask_user_id,     
    t.production_mode            = p_ar_rec.production_mode,             
    t.remarks                    = p_ar_rec.remarks,
    t.coor_ask_flow_status       = p_ar_rec.coor_ask_flow_status,
    t.collection                 = p_ar_rec.collection,
    t.origin                     = p_ar_rec.origin,
    t.company_name               = p_ar_rec.company_name,
    t.social_credit_code         = p_ar_rec.social_credit_code,
    t.cooperation_statement      = p_ar_rec.cooperation_statement,*/
     WHERE t.ask_record_id = p_ar_rec.ask_record_id;
  EXCEPTION
    WHEN OTHERS THEN
      ROLLBACK;
      sys_raise_app_error_pkg.is_running_error(p_is_running_error => 'T',
                                               p_is_log           => 1);
  END p_update_t_ask_record;

  --Delete
  PROCEDURE p_delete_t_ask_record(p_ask_record_id VARCHAR2) IS
    judge NUMBER(1);
  BEGIN
    SELECT COUNT(1)
      INTO judge
      FROM scmdata.t_factory_ask
     WHERE ask_record_id = p_ask_record_id;
  
    IF judge = 0 THEN
      DELETE FROM scmdata.t_ask_record
       WHERE ask_record_id = p_ask_record_id;
    ELSE
      raise_application_error(-20002, '已有单据在流程中不能删除！');
    END IF;
  END p_delete_t_ask_record;

  --Check
  --校验申请单状态
  PROCEDURE p_check_ask_flow_status(p_ask_record_id VARCHAR2) IS
    v_status VARCHAR2(32);
  BEGIN
    SELECT MAX(a.coor_ask_flow_status)
      INTO v_status
      FROM t_ask_record a
     WHERE a.ask_record_id = p_ask_record_id;
  
    IF v_status = 'CA01' THEN
      raise_application_error(-20002, '已提交的申请不能重新修改');
    ELSE
      NULL;
    END IF;
  END p_check_ask_flow_status;

  --校验流程中公司名称是否重复
  PROCEDURE p_check_supp_name(p_company_id   VARCHAR2,
                              p_company_name VARCHAR2) IS
    judge NUMBER(1);
  BEGIN
    SELECT COUNT(1)
      INTO judge
      FROM scmdata.t_ask_record
     WHERE be_company_id = p_company_id --p_ar_rec.be_company_id
       AND company_name = p_company_name --p_ar_rec.company_name
       AND coor_ask_flow_status <> 'CA00';
  
    IF judge = 0 THEN
      SELECT COUNT(1)
        INTO judge
        FROM (SELECT DISTINCT first_value(company_name) over(PARTITION BY ask_record_id ORDER BY create_date DESC) company_name
                FROM scmdata.t_factory_ask
               WHERE factrory_ask_flow_status NOT IN
                     ('CA01', 'FA01', 'FA03', 'FA21', 'FA33')
                 AND company_id = p_company_id)
       WHERE company_name = p_company_name;
    
      IF judge = 0 THEN
      
        SELECT COUNT(1)
          INTO judge
          FROM scmdata.t_supplier_info
         WHERE company_id = p_company_id
           AND supplier_company_name = p_company_name;
      
        IF judge > 0 THEN
          raise_application_error(-20002,
                                  '公司名称与待建档、已建档的供应商名称重复！');
        END IF;
      ELSE
        raise_application_error(-20002,
                                '公司名称与准入流程中的公司名称存在重复！');
      END IF;
    ELSE
      raise_application_error(-20002,
                              '公司名称与意向合作供应商清单的公司名称重复！');
    END IF;
  END p_check_supp_name;
  --校验公司类型为xxx时，意向合作模式只能为xxx
  PROCEDURE p_check_company_type(p_company_type      VARCHAR2,
                                 p_cooperation_model VARCHAR2) IS
  BEGIN
    IF p_company_type = '00' THEN
      NULL;
    ELSIF p_company_type = '01' THEN
      IF p_cooperation_model = 'ODM' THEN
        NULL;
      ELSE
        raise_application_error(-20002,
                                '公司类型为贸易型时，意向合作模式只可选择ODM！');
      END IF;
    ELSIF p_company_type = '02' THEN
      IF instr_priv(p_cooperation_model, 'ODM') > 0 THEN
        raise_application_error(-20002,
                                '公司类型为工厂型时，意向合作模式只可选择OEM、外协厂！');
      ELSE
        NULL;
      END IF;
    ELSE
      NULL;
    END IF;
  END p_check_company_type;

  --保存时校验数据
  --p_type : 0:合作申请 成品供应商/重新申请  1：新增意向供应商
  PROCEDURE p_check_data_by_save(p_ar_rec scmdata.t_ask_record%ROWTYPE,
                                 p_type   NUMBER) IS
  
  BEGIN
    --校验公司类型为xxx时，意向合作模式只能为xxx
    p_check_company_type(p_company_type      => p_ar_rec.company_type,
                         p_cooperation_model => p_ar_rec.cooperation_model);
    IF p_type = 0 THEN
      --已提交的申请不能重新修改
      p_check_ask_flow_status(p_ask_record_id => p_ar_rec.ask_record_id);
    ELSIF p_type = 1 THEN
      IF p_ar_rec.cooperation_type <> 'PRODUCT_TYPE' THEN
        raise_application_error(-20002,
                                '除成品供应商外，其余合作类型未开放！');
      ELSE
        --校验流程中公司名称是否重复
        p_check_supp_name(p_company_id   => p_ar_rec.be_company_id,
                          p_company_name => p_ar_rec.company_name);
      END IF;
    ELSE
      raise_application_error(-20002, '无此校验类型，请联系管理员！');
    END IF;
  
  END p_check_data_by_save;

  --2.验厂申请
  --Query p_type : 0 :申请验厂  1：申请详情
  FUNCTION f_query_factory_ask(p_type NUMBER DEFAULT NULL) RETURN CLOB IS
    v_query_sql CLOB;
  BEGIN
    v_query_sql := q'[ WITH dic AS
     (SELECT group_dict_value, group_dict_name, group_dict_type,group_dict_id,parent_id
        FROM scmdata.sys_group_dict),
    comp AS
     (SELECT company_id, logn_name, company_name FROM scmdata.sys_company),
    pcc_dict AS
     (SELECT dp.provinceid,
             dc.cityno,
             dt.countyid,
             dp.province || dc.city || dt.county pcc
        FROM scmdata.dic_province dp
       INNER JOIN scmdata.dic_city dc
          ON dp.provinceid = dc.provinceid
       INNER JOIN scmdata.dic_county dt
          ON dc.cityno = dt.cityno)
    --申请信息
    SELECT (SELECT dept_name
              FROM scmdata.sys_company_dept
             WHERE company_dept_id =
                   (SELECT company_dept_id
                      FROM sys_company_user_dept
                     WHERE company_id = %default_company_id%
                       AND user_id = %current_userid%)) check_dept_name,
           (SELECT company_user_name
              FROM scmdata.sys_company_user
             WHERE company_id = %default_company_id%
               AND user_id = %current_userid%) checkapply_person,
           (SELECT phone
              FROM scmdata.sys_user
             WHERE user_id = %current_userid%) checkapply_phone,
           nvl(tfa.is_urgent,0) is_urgent,
           tfa.ask_date factory_ask_date,
           'PRODUCT_TYPE' cooperation_type,
           (SELECT group_dict_name
              FROM scmdata.sys_group_dict
             WHERE group_dict_value = 'PRODUCT_TYPE') cooperation_type_desc,
           tfa.cooperation_model,
           /*(SELECT listagg(group_dict_name, ';') within GROUP(ORDER BY group_dict_value)
              FROM dic
             WHERE group_dict_type = 'SUPPLY_TYPE'
               AND instr(';' || tfa.cooperation_model || ';',
                         ';' || group_dict_value || ';') > 0) cooperation_model_desc,*/
         (SELECT listagg(group_dict_name, ';') within GROUP(ORDER BY group_dict_value)
          FROM scmdata.t_ask_scope t
         INNER JOIN dic
            ON group_dict_value = t.cooperation_classification
           AND group_dict_type = t.cooperation_type
         WHERE t.be_company_id = %default_company_id%
           AND t.object_id = tfa.factory_ask_id) cooperation_classification_des,
           nvl(tfa.product_type,'00') product_type,
           tfa.ask_say checkapply_intro,
           tfa.FACTRORY_ASK_FLOW_STATUS,
           --供应商基本信息 
           tfa.company_name ask_company_name,
           tfa.company_abbreviation,
           tfa.social_credit_code,
           (SELECT a.pcc
              FROM pcc_dict a
             WHERE a.provinceid = tfa.company_province
               AND a.cityno = tfa.company_city
               AND a.countyid = tfa.company_county) pcc,
           tfa.company_address,
           tfa.legal_representative,
           tfa.company_contact_phone,
           tfa.contact_name,
           tfa.contact_phone,
           tfa.company_type,
          (SELECT listagg(b.group_dict_name, ';') within GROUP(ORDER BY b.group_dict_value)
          FROM dic t
          LEFT JOIN dic b
            ON t.group_dict_type = 'COOPERATION_BRAND'
           AND t.group_dict_id = b.parent_id
           AND instr(';' || tfa.brand_type || ';',
                     ';' || t.group_dict_value || ';') > 0
           AND instr(';' || tfa.cooperation_brand || ';',
                     ';' || b.group_dict_value || ';') > 0) cooperation_brand_desc,
           tfa.brand_type,
           tfa.cooperation_brand,
           (select a.group_dict_name from dic a where a.group_dict_type = 'COM_MANUFACTURER' and a.group_dict_value = tfa.com_manufacturer) com_manufacturer_desc,
           --tfa.com_manufacturer,
           tfa.certificate_file,
           tfa.supplier_gate,
           tfa.supplier_site,
           tfa.supplier_office,
           tfa.supplier_product,
           tfa.company_province,
           tfa.company_city,
           tfa.company_county,
           TFA.FACTORY_ASK_ID,
           tfa.rela_supplier_id,
           (select t.supplier_company_name from scmdata.t_supplier_info t where t.company_id = tfa.company_id and t.social_credit_code = tfa.rela_supplier_id ) rela_supplier_id_desc,
           tfa.product_link          
           /*,
           --工厂基本信息
           fo.factory_ask_out_id,
           fo.factory_name,
           fo.factory_abbreviation,
           fo.fa_social_credit_code,
           (SELECT b.pcc
              FROM pcc_dict b
             WHERE b.provinceid = fo.factory_province
               AND b.cityno = fo.factory_city
               AND b.countyid = fo.factory_county) fpcc,
           fo.factory_detail_adress,
           fo.factory_representative,
           fo.factory_contact_phone fa_com_contact_phone,
           fo.fa_contact_name,
           fo.fa_contact_phone,          
           fo.factory_type,
           (SELECT listagg(b.group_dict_name, ';') within GROUP(ORDER BY b.group_dict_value)
          FROM dic t
          LEFT JOIN dic b
            ON t.group_dict_type = 'COOPERATION_BRAND'
           AND t.group_dict_id = b.parent_id
           AND instr(';' || fo.fa_brand_type || ';',
                     ';' || t.group_dict_value || ';') > 0
           AND instr(';' || fo.factory_coop_brand || ';',
                     ';' || b.group_dict_value || ';') > 0) factory_coop_brand_desc,
           fo.fa_brand_type,
           fo.factory_coop_brand,
           fo.factory_coop_model,
           fo.product_link,
           fo.fa_rela_supplier_id,
           fo.fa_certificate_file,
           fo.factory_gate,
           fo.factory_site,
           fo.factory_office,
           fo.factory_product,
           fo.factory_province,
           fo.factory_city,
           fo.factory_county*/
      FROM scmdata.t_factory_ask tfa
      /*LEFT JOIN scmdata.t_factory_ask_out fo
        ON tfa.factory_ask_id = fo.factory_ask_id*/ ]' || CASE
                     WHEN p_type = 1 THEN
                      ' WHERE tfa.factory_ask_id = :factory_ask_id'
                     ELSE
                      ' WHERE tfa.ask_record_id = :ask_record_id
     ORDER BY tfa.create_date DESC'
                   END;
  
    RETURN v_query_sql;
  END f_query_factory_ask;

  --验厂申请  意向合作清单
  FUNCTION f_query_coop_supp_list RETURN CLOB IS
    v_query_sql CLOB;
  BEGIN
    v_query_sql := q'[ WITH dic AS
     (SELECT group_dict_name, group_dict_value, group_dict_type
        FROM scmdata.sys_group_dict)
    SELECT (CASE
             WHEN tar.collection = 1 THEN
              '收藏'
           END) collection,
           tar.coor_ask_flow_status,
           tar.create_date coop_apply_date,
           tar.company_name ask_company_name,
           (SELECT listagg(y.group_dict_name, ';')
              FROM (SELECT DISTINCT cooperation_classification tmp
                      FROM scmdata.t_ask_scope
                     WHERE object_id = tar.ask_record_id
                       AND company_id = decode(tar.origin,
                                               'MA',
                                               tar.be_company_id,
                                               tar.company_id)) z
             INNER JOIN dic y
                ON z.tmp = y.group_dict_value
               AND y.group_dict_type = 'PRODUCT_TYPE') cooperation_classification_desc,
           tar.cooperation_model,
           (SELECT listagg(group_dict_name, ';') within GROUP(ORDER BY group_dict_value)
              FROM dic
             WHERE group_dict_type = 'SUPPLY_TYPE'
               AND instr(';' || tar.cooperation_model || ';',
                         ';' || group_dict_value || ';') > 0) cooperation_model_desc,
           substr(status, 1, instr(status, '+') - 1) flow_node_name,
           substr(status, instr(status, '+') + 1, length(status)) flow_node_status_desc,
           sapply_user,
           sapply_phone,
           (SELECT listagg(w.group_dict_name, ';')
              FROM (SELECT DISTINCT cooperation_type tmp
                      FROM scmdata.t_ask_scope
                     WHERE object_id = tar.ask_record_id) x
             INNER JOIN dic w
                ON x.tmp = w.group_dict_value
               AND w.group_dict_type = 'COOPERATION_TYPE') cooperation_type_desc,
           tar.company_address,
           (SELECT company_user_name
              FROM scmdata.sys_company_user
             WHERE company_id = decode(tar.origin,
                                       'MA',
                                       tar.be_company_id,
                                       tar.company_id)
               AND user_id = tar.create_id) creator,
           tar.create_date create_time,
           tar.ask_record_id,
           tar.ask_user_id,
           tar.company_id,
           CASE WHEN tar.is_urgent = '1' THEN 65535 ELSE NULL END GRIDBACKCOLOR
      FROM (SELECT a.*,
                   (SELECT group_dict_name
                      FROM dic
                     WHERE group_dict_type = 'FACTORY_ASK_FLOW'
                       AND group_dict_value =
                           nvl((SELECT status_af_oper
                                 FROM (SELECT status_af_oper
                                         FROM scmdata.t_factory_ask_oper_log
                                        WHERE ask_record_id = a.ask_record_id
                                        ORDER BY oper_time DESC)
                                WHERE rownum < 2),
                               a.coor_ask_flow_status)) status,
                   b.is_urgent
              FROM scmdata.t_ask_record a
              left join scmdata.t_factory_ask b on a.ask_record_id = b.ask_record_id and b.is_urgent is not null
             WHERE be_company_id = %default_company_id%
               AND instr('CA03,CA00,', coor_ask_flow_status || ',') = 0) tar
     ORDER BY tar.is_urgent DESC nulls last,collection DESC nulls last,coop_apply_date DESC]';
    RETURN v_query_sql;
  END f_query_coop_supp_list;

  --验厂申请 我的申请记录
  FUNCTION f_query_my_ask_rec RETURN CLOB IS
    v_query_sql CLOB;
  BEGIN
    v_query_sql := q'[WITH dic AS
 (SELECT group_dict_value, group_dict_name, group_dict_type
    FROM scmdata.sys_group_dict)
SELECT tfa.factory_ask_id,
       tfa.factrory_ask_flow_status,
       substr(status, 1, instr(status, '+') - 1) flow_node_name,
       substr(status, instr(status, '+') + 1, length(status)) flow_node_status_desc,
       tfa.company_name ask_company_name,
       (SELECT listagg(b.group_dict_name, ';')
          FROM (SELECT DISTINCT cooperation_classification tmp
                  FROM scmdata.t_ask_scope
                 WHERE object_id = tfa.factory_ask_id) a
         INNER JOIN dic b
            ON a.tmp = b.group_dict_value
           AND b.group_dict_type = 'PRODUCT_TYPE') cooperation_classification_desc,
       tfa.cooperation_model,
       (SELECT listagg(group_dict_name, ';') within GROUP(ORDER BY group_dict_value)
              FROM dic
             WHERE group_dict_type = 'SUPPLY_TYPE'
               AND instr(';' || tfa.cooperation_model || ';',
                         ';' || group_dict_value || ';') > 0) cooperation_model_desc,
       --tfa.factory_name,
       --tfa.ask_address,
       --fo.factory_name,
       --fo.factory_detail_adress ask_address,
       (SELECT dept_name
          FROM scmdata.sys_company_dept
         WHERE company_dept_id =
               (SELECT company_dept_id
                  FROM scmdata.sys_company_user_dept
                 WHERE user_id = %current_userid%
                   AND company_id = %default_company_id%)) check_dept_name,
       (SELECT company_user_name
          FROM scmdata.sys_company_user
         WHERE company_id = tfa.company_id
           AND user_id = tfa.ask_user_id) check_apply_username,
       tfa.ask_date factory_ask_date,
       (SELECT group_dict_name
          FROM dic
         WHERE group_dict_value = tfa.cooperation_type
           AND group_dict_type = 'COOPERATION_TYPE') cooperation_type_desc,
       tfa.factory_ask_type check_method,
       CASE
         WHEN factory_ask_type = 0 THEN
          '不验厂'
         WHEN factory_ask_type = 1 THEN
          '内部验厂'
         WHEN factory_ask_type = 2 THEN
          '第三方验厂'
       END check_method_sp,
       (SELECT logn_name
          FROM scmdata.sys_company
         WHERE company_id = tfa.ask_company_id) check_company_name,
       CASE WHEN tfa.is_urgent = '1' THEN 65535   ELSE NULL END GRIDBACKCOLOR
  FROM (SELECT factory_ask_id,
               factrory_ask_flow_status,
               ask_date,
               factory_ask_type,
               cooperation_company_id,
               ask_company_id,
               ask_user_id,
               ask_address,
               cooperation_type,
               cooperation_model,
               company_name,
               company_address,
               company_id,
               --factory_name,
               create_date,
               (SELECT group_dict_name
                  FROM dic
                 WHERE group_dict_value = factrory_ask_flow_status
                   AND group_dict_type = 'FACTORY_ASK_FLOW') status,
               is_urgent
          FROM scmdata.t_factory_ask
         WHERE company_id = %default_company_id%
           AND ask_user_id = %current_userid%
           AND factrory_ask_flow_status <> 'CA01'
         ORDER BY create_date DESC) tfa
/*  LEFT JOIN scmdata.t_factory_ask_out fo
    ON tfa.factory_ask_id = fo.factory_ask_id*/
  LEFT JOIN scmdata.sys_user su
    ON tfa.ask_user_id = su.user_id
 ORDER BY tfa.is_urgent DESC nulls last,tfa.create_date DESC
]';
  
    RETURN v_query_sql;
  END f_query_my_ask_rec;

  --验厂申请 待审核申请
  FUNCTION f_query_uncheck_ask_rec RETURN CLOB IS
    v_query_sql CLOB;
  BEGIN
    v_query_sql := q'[ WITH dic AS
     (SELECT group_dict_value, group_dict_name, group_dict_type,group_dict_id,parent_id
        FROM scmdata.sys_group_dict),
         data_pri AS
 (SELECT listagg(DISTINCT cooperation_classification, ';') within GROUP(ORDER BY cooperation_classification) category,
         object_id factory_ask_id
    FROM scmdata.t_ask_scope
   WHERE object_type = 'CA'
   GROUP BY object_id)
SELECT a.factory_ask_id,
       -- substr(fals.group_dict_name, 0, instr(fals.group_dict_name, '+') - 1) FLOW_NODE_NAME,
       substr(fals.group_dict_name,
              instr(fals.group_dict_name, '+') + 1,
              length(fals.group_dict_name)) flow_node_status_desc,
       a.company_name ask_company_name,
       (SELECT listagg(group_dict_name, ';') within GROUP(ORDER BY 1)
          FROM sys_group_dict
         WHERE group_dict_type = 'PRODUCT_TYPE'
           AND group_dict_value IN
               (SELECT DISTINCT cooperation_classification
                  FROM scmdata.t_ask_scope
                 WHERE object_id = a.factory_ask_id
                   AND object_type = 'CA')) cooperation_classification_desc,
       /* (SELECT listagg(group_dict_name, ';') within GROUP(ORDER BY 1)
       from (select distinct group_dict_name
               FROM sys_group_dict
              WHERE group_dict_type in
                    (select cooperation_classification
                       from scmdata.t_ask_scope
                      where object_id = a.factory_ask_id
                        and object_type = 'CA')
                AND group_dict_value in
                    (select cooperation_product_cate
                       from scmdata.t_ask_scope
                      where object_id = a.factory_ask_id
                        and object_type = 'CA'))) cooperation_product_cate_desc,*/
       (SELECT listagg(group_dict_name, ';') within GROUP(ORDER BY group_dict_value)
              FROM dic
             WHERE group_dict_type = 'SUPPLY_TYPE'
               AND instr(';' || a.cooperation_model || ';',
                         ';' || group_dict_value || ';') > 0) cooperation_model_desc,
       -- a.COMPANY_ADDRESS, 
       --a.factory_name,
       --a.ask_address,
       --fo.factory_name,
       --fo.factory_detail_adress ask_address,
       cd.dept_name ask_user_dept_name,
       (SELECT company_user_name
          FROM sys_company_user
         WHERE user_id = a.ask_user_id
           AND company_id = %default_company_id%) checkapply_person,
       a.ask_date factory_ask_date,
       (SELECT group_dict_name
          FROM sys_group_dict
         WHERE group_dict_value = a.cooperation_type
           AND group_dict_type = 'COOPERATION_TYPE') cooperation_type_desc,
       CASE
         WHEN a.origin = 'CA' THEN
          (SELECT company_id
             FROM t_ask_record
            WHERE ask_record_id = a.ask_record_id)
         ELSE
          a.cooperation_company_id
       END company_id,
       CASE WHEN a.is_urgent = '1' THEN 65535   ELSE NULL END GRIDBACKCOLOR
  FROM t_factory_ask a
 INNER JOIN data_pri c
    ON c.factory_ask_id = a.factory_ask_id
  LEFT JOIN sys_user u
    ON a.ask_user_id = u.user_id
  LEFT JOIN sys_company_dept cd
    ON a.ask_user_dept_id = cd.company_dept_id
  LEFT JOIN t_ask_record b
    ON a.ask_record_id = b.ask_record_id
  LEFT JOIN sys_group_dict ga
    ON a.cooperation_type = ga.group_dict_value
   AND ga.group_dict_type = 'COOPERATION_TYPE'
  LEFT JOIN sys_group_dict fals
    ON a.factrory_ask_flow_status = fals.group_dict_value
   AND fals.group_dict_type = 'FACTORY_ASK_FLOW'
  /*LEFT JOIN scmdata.t_factory_ask_out fo
    ON a.factory_ask_id = fo.factory_ask_id*/
 WHERE a.company_id = %default_company_id%
   AND a.factrory_ask_flow_status = 'FA02'
/*   AND (instr_priv(%coop_class_priv%, c.category) > 0 OR
%is_company_admin% = '1')*/
 ORDER BY a.is_urgent DESC nulls last,a.ask_date ASC
]';
  
    RETURN v_query_sql;
  END f_query_uncheck_ask_rec;

  --验厂申请 已审核申请
  FUNCTION f_query_checked_ask_rec RETURN CLOB IS
    v_query_sql CLOB;
  BEGIN
    v_query_sql := q'[ WITH dic AS
     (SELECT group_dict_value, group_dict_name, group_dict_type,group_dict_id,parent_id
        FROM scmdata.sys_group_dict),
         data_pri AS
 (SELECT listagg(DISTINCT cooperation_classification, ';') within GROUP(ORDER BY cooperation_classification ASC) category,
         object_id factory_ask_id
    FROM scmdata.t_ask_scope
   WHERE object_type = 'CA'
   GROUP BY object_id)
SELECT a.factory_ask_id,
       substr(fals.group_dict_name, 0, instr(fals.group_dict_name, '+') - 1) flow_node_name,
       substr(fals.group_dict_name,
              instr(fals.group_dict_name, '+') + 1,
              length(fals.group_dict_name)) flow_node_status_desc,
       a.company_name ask_company_name,
       (SELECT listagg(group_dict_name, ';') within GROUP(ORDER BY 1)
          FROM sys_group_dict
         WHERE group_dict_type = 'PRODUCT_TYPE'
           AND group_dict_value IN
               (SELECT DISTINCT cooperation_classification
                  FROM scmdata.t_ask_scope
                 WHERE object_id = a.factory_ask_id
                   AND object_type = 'CA')) cooperation_classification_desc,
       /* (SELECT listagg(group_dict_name, ';') within GROUP(ORDER BY 1)
       from (select distinct group_dict_name
               FROM sys_group_dict
              WHERE group_dict_type in
                    (select cooperation_classification
                       from scmdata.t_ask_scope
                      where object_id = a.factory_ask_id
                        and object_type = 'CA')
                AND group_dict_value in
                    (select cooperation_product_cate
                       from scmdata.t_ask_scope
                      where object_id = a.factory_ask_id
                        and object_type = 'CA'))) cooperation_product_cate_desc,*/
       (SELECT listagg(group_dict_name, ';') within GROUP(ORDER BY group_dict_value)
              FROM dic
             WHERE group_dict_type = 'SUPPLY_TYPE'
               AND instr(';' || a.cooperation_model || ';',
                         ';' || group_dict_value || ';') > 0) cooperation_model_desc,
       -- a.COMPANY_ADDRESS, 
       --a.factory_name,
       --a.ask_address,
       --fo.factory_name,
       --fo.factory_detail_adress ask_address,
       cd.dept_name ask_user_dept_name,
       (SELECT company_user_name
          FROM sys_company_user
         WHERE user_id = a.ask_user_id
           AND company_id = %default_company_id%) checkapply_person,
       a.ask_date factory_ask_date,
       (SELECT group_dict_name
          FROM sys_group_dict
         WHERE group_dict_value = a.cooperation_type
           AND group_dict_type = 'COOPERATION_TYPE') cooperation_type_desc,
       CASE
         WHEN a.origin = 'CA' THEN
          (SELECT company_id
             FROM t_ask_record
            WHERE ask_record_id = a.ask_record_id)
         ELSE
          a.cooperation_company_id
       END company_id,
       --   a.contact_name,
       -- a.contact_phone,
       decode(a.factory_ask_type,
              0,
              '不验厂',
              1,
              '内部验厂',
              2,
              '第三方验厂') check_method,
       a.remarks,
       c2.logn_name check_company_name,
       CASE WHEN a.is_urgent = '1' THEN 65535   ELSE NULL END GRIDBACKCOLOR
  FROM t_factory_ask a
 INNER JOIN (SELECT MAX(ol.oper_time) audit_time, ol.factory_ask_id
               FROM t_factory_ask_oper_log ol
              WHERE ol.status_af_oper IN ('FA03', 'FA11', 'FA12')
                 OR (ol.status_af_oper = 'FA01' AND ol.oper_code IN ('BACK'))
              GROUP BY ol.factory_ask_id) k
    ON k.factory_ask_id = a.factory_ask_id
 INNER JOIN data_pri c
    ON c.factory_ask_id = a.factory_ask_id
  LEFT JOIN sys_company c2
    ON a.ask_company_id = c2.company_id
   AND a.factory_ask_type <> '0'
  LEFT JOIN sys_user u
    ON a.ask_user_id = u.user_id
  LEFT JOIN sys_company_dept cd
    ON a.ask_user_dept_id = cd.company_dept_id
  LEFT JOIN t_ask_record b
    ON a.ask_record_id = b.ask_record_id
 INNER JOIN sys_group_dict ga
    ON a.cooperation_type = ga.group_dict_value
   AND ga.group_dict_type = 'COOPERATION_TYPE'
 INNER JOIN sys_group_dict fals
    ON a.factrory_ask_flow_status = fals.group_dict_value
   AND fals.group_dict_type = 'FACTORY_ASK_FLOW'
 /* LEFT JOIN scmdata.t_factory_ask_out fo
    ON a.factory_ask_id = fo.factory_ask_id*/
 WHERE a.company_id = %default_company_id%
   AND a.factrory_ask_flow_status LIKE 'FA%'
   AND factrory_ask_flow_status <> 'FA02'
   /*AND (instr_priv(%coop_class_priv%, c.category) > 0 OR
       %is_company_admin% = '1')*/
 ORDER BY a.is_urgent DESC nulls last,k.audit_time DESC
]';
    RETURN v_query_sql;
  END f_query_checked_ask_rec;

  --Lookup
  --是否紧急
  FUNCTION f_query_lookup_is_urgent RETURN CLOB IS
    v_query_sql CLOB;
  BEGIN
    v_query_sql := q'[SELECT 0 is_urgent, '否' is_urgent_desc FROM dual
  union all
  SELECT 1 is_urgent, '是' is_urgent_desc FROM dual]';
    RETURN v_query_sql;
  END f_query_lookup_is_urgent;

  --生产类型
  FUNCTION f_query_lookup_product_type(p_product_type_field VARCHAR2,
                                       p_suffix             VARCHAR2)
    RETURN CLOB IS
    v_query_sql CLOB;
  BEGIN
    v_query_sql := 'SELECT a.group_dict_value ' || p_product_type_field || ',
           a.group_dict_name  ' || p_product_type_field ||
                   p_suffix || '
      FROM scmdata.sys_group_dict a
     WHERE a.group_dict_type = ''FA_PRODUCT_TYPE''
       AND a.pause = 0';
    RETURN v_query_sql;
  END f_query_lookup_product_type;

  --生产工厂
  FUNCTION f_query_lookup_com_mnfacturer(p_com_mnfacturer_field VARCHAR2,
                                         p_suffix               VARCHAR2)
    RETURN CLOB IS
    v_query_sql CLOB;
  BEGIN
    v_query_sql := 'SELECT a.group_dict_value ' || p_com_mnfacturer_field || ',
           a.group_dict_name  ' || p_com_mnfacturer_field ||
                   p_suffix || '
      FROM scmdata.sys_group_dict a
     WHERE a.group_dict_type = ''COM_MANUFACTURER''
       AND a.pause = 0';
    RETURN v_query_sql;
  END f_query_lookup_com_mnfacturer;

  --关联供应商
  FUNCTION f_query_lookup_rela_supplier(p_rela_supplier_field VARCHAR2,
                                        p_suffix              VARCHAR2)
    RETURN CLOB IS
    v_query_sql CLOB;
  BEGIN
    --FA_RELA_SUPPLIER_ID RELA_SUPPLIER
    v_query_sql := 'SELECT SOCIAL_CREDIT_CODE ' || p_rela_supplier_field ||
                   ', SUPPLIER_COMPANY_NAME ' || p_rela_supplier_field ||
                   p_suffix || '
  FROM SCMDATA.T_SUPPLIER_INFO
 WHERE COMPANY_ID = %DEFAULT_COMPANY_ID%';
    RETURN v_query_sql;
  END f_query_lookup_rela_supplier;

  --Insert 
  --新增验厂申请单（供应商）
  PROCEDURE p_insert_factory_ask(p_fa_rec scmdata.t_factory_ask%ROWTYPE) IS
  BEGIN
    INSERT INTO t_factory_ask
      (factory_ask_id,
       company_id,
       ask_date,
       ask_user_id,
       company_city,
       company_province,
       company_county,
       ask_address,
       contact_name,
       contact_phone,
       company_type,
       cooperation_method,
       cooperation_model,
       ask_say,
       origin,
       create_id,
       create_date,
       update_id,
       update_date,
       remarks,
       ask_company_id,
       ask_record_id,
       factrory_ask_flow_status,
       factory_ask_type,
       cooperation_type,
       cooperation_company_id,
       ask_user_dept_id,
       company_address,
       ask_files,
       company_name,
       social_credit_code,
       rela_supplier_id,
       company_abbreviation,
       legal_representative,
       company_contact_phone,
       company_mold,
       cooperation_brand,
       supplier_gate,
       supplier_office,
       supplier_site,
       supplier_product,
       com_manufacturer,
       certificate_file,
       is_urgent,
       product_type,
       brand_type,
       product_link)
    VALUES
      (p_fa_rec.factory_ask_id,
       p_fa_rec.company_id,
       p_fa_rec.ask_date,
       p_fa_rec.ask_user_id,
       p_fa_rec.company_city,
       p_fa_rec.company_province,
       p_fa_rec.company_county,
       p_fa_rec.ask_address,
       p_fa_rec.contact_name,
       p_fa_rec.contact_phone,
       p_fa_rec.company_type,
       p_fa_rec.cooperation_method,
       p_fa_rec.cooperation_model,
       p_fa_rec.ask_say,
       p_fa_rec.origin,
       p_fa_rec.create_id,
       p_fa_rec.create_date,
       p_fa_rec.update_id,
       p_fa_rec.update_date,
       p_fa_rec.remarks,
       p_fa_rec.ask_company_id,
       p_fa_rec.ask_record_id,
       p_fa_rec.factrory_ask_flow_status,
       p_fa_rec.factory_ask_type,
       p_fa_rec.cooperation_type,
       p_fa_rec.cooperation_company_id,
       p_fa_rec.ask_user_dept_id,
       p_fa_rec.company_address,
       p_fa_rec.ask_files,
       p_fa_rec.company_name,
       p_fa_rec.social_credit_code,
       p_fa_rec.rela_supplier_id,
       p_fa_rec.company_abbreviation,
       p_fa_rec.legal_representative,
       p_fa_rec.company_contact_phone,
       p_fa_rec.company_mold,
       p_fa_rec.cooperation_brand,
       p_fa_rec.supplier_gate,
       p_fa_rec.supplier_office,
       p_fa_rec.supplier_site,
       p_fa_rec.supplier_product,
       p_fa_rec.com_manufacturer,
       p_fa_rec.certificate_file,
       p_fa_rec.is_urgent,
       p_fa_rec.product_type,
       p_fa_rec.brand_type,
       p_fa_rec.product_link);
  
  END p_insert_factory_ask;
  --新增验厂申请单（工厂）
  PROCEDURE p_insert_factory_ask_out(p_fo_rec scmdata.t_factory_ask_out%ROWTYPE) IS
  BEGIN
    INSERT INTO t_factory_ask_out
      (factory_ask_out_id,
       factory_ask_id,
       company_id,
       factory_name,
       factory_abbreviation,
       fa_social_credit_code,
       factory_province,
       factory_city,
       factory_county,
       factory_detail_adress,
       factory_representative,
       factory_contact_phone,
       fa_contact_name,
       fa_contact_phone,
       factory_type,
       factory_coop_model,
       factory_coop_brand,
       product_link,
       fa_rela_supplier_id,
       factory_gate,
       factory_office,
       factory_site,
       factory_product,
       fa_certificate_file,
       remarks,
       create_id,
       create_time,
       update_id,
       update_time,
       fa_brand_type)
    VALUES
      (p_fo_rec.factory_ask_out_id,
       p_fo_rec.factory_ask_id,
       p_fo_rec.company_id,
       p_fo_rec.factory_name,
       p_fo_rec.factory_abbreviation,
       p_fo_rec.fa_social_credit_code,
       p_fo_rec.factory_province,
       p_fo_rec.factory_city,
       p_fo_rec.factory_county,
       p_fo_rec.factory_detail_adress,
       p_fo_rec.factory_representative,
       p_fo_rec.factory_contact_phone,
       p_fo_rec.fa_contact_name,
       p_fo_rec.fa_contact_phone,
       p_fo_rec.factory_type,
       p_fo_rec.factory_coop_model,
       p_fo_rec.factory_coop_brand,
       p_fo_rec.product_link,
       p_fo_rec.fa_rela_supplier_id,
       p_fo_rec.factory_gate,
       p_fo_rec.factory_office,
       p_fo_rec.factory_site,
       p_fo_rec.factory_product,
       p_fo_rec.fa_certificate_file,
       p_fo_rec.remarks,
       p_fo_rec.create_id,
       p_fo_rec.create_time,
       p_fo_rec.update_id,
       p_fo_rec.update_time,
       p_fo_rec.fa_brand_type);
  
  END p_insert_factory_ask_out;

  --新增意向合作范围
  PROCEDURE p_insert_ask_scope(p_scope_rec scmdata.t_ask_scope%ROWTYPE) IS
  BEGIN
    INSERT INTO t_ask_scope
      (ask_scope_id,
       company_id,
       object_id,
       object_type,
       cooperation_type,
       cooperation_classification,
       cooperation_product_cate,
       cooperation_subcategory,
       be_company_id,
       update_time,
       update_id,
       create_id,
       create_time,
       remarks,
       pause)
    VALUES
      (p_scope_rec.ask_scope_id,
       p_scope_rec.company_id,
       p_scope_rec.object_id,
       p_scope_rec.object_type,
       p_scope_rec.cooperation_type,
       p_scope_rec.cooperation_classification,
       p_scope_rec.cooperation_product_cate,
       p_scope_rec.cooperation_subcategory,
       p_scope_rec.be_company_id,
       p_scope_rec.update_time,
       p_scope_rec.update_id,
       p_scope_rec.create_id,
       p_scope_rec.create_time,
       p_scope_rec.remarks,
       p_scope_rec.pause);
  
  END p_insert_ask_scope;
  --Update
  --修改验厂申请单（供应商）
  PROCEDURE p_update_factory_ask(p_fa_rec scmdata.t_factory_ask%ROWTYPE) IS
  BEGIN
    UPDATE t_factory_ask t
       SET t.ask_date          = p_fa_rec.ask_date,
           t.is_urgent         = p_fa_rec.is_urgent,
           t.cooperation_model = p_fa_rec.cooperation_model,
           t.product_type      = p_fa_rec.product_type,
           t.ask_say           = p_fa_rec.ask_say,
           --供应商基本信息
           t.company_name          = p_fa_rec.company_name,
           t.company_abbreviation  = p_fa_rec.company_abbreviation,
           t.company_province      = p_fa_rec.company_province,
           t.company_city          = p_fa_rec.company_city,
           t.company_county        = p_fa_rec.company_county,
           t.company_address       = p_fa_rec.company_address,
           t.ask_address           = p_fa_rec.ask_address,
           t.legal_representative  = p_fa_rec.legal_representative,
           t.company_contact_phone = p_fa_rec.company_contact_phone,
           t.contact_name          = p_fa_rec.contact_name,
           t.contact_phone         = p_fa_rec.contact_phone,
           t.company_type          = p_fa_rec.company_type,
           t.brand_type            = p_fa_rec.brand_type,
           t.cooperation_brand     = p_fa_rec.cooperation_brand,
           t.com_manufacturer      = p_fa_rec.com_manufacturer,
           t.certificate_file      = p_fa_rec.certificate_file,
           t.supplier_gate         = p_fa_rec.supplier_gate,
           t.supplier_office       = p_fa_rec.supplier_office,
           t.supplier_site         = p_fa_rec.supplier_site,
           t.supplier_product      = p_fa_rec.supplier_product,
           t.ask_user_id           = p_fa_rec.ask_user_id,
           t.update_id             = p_fa_rec.update_id,
           t.update_date           = p_fa_rec.update_date,
           t.rela_supplier_id      = p_fa_rec.rela_supplier_id,
           t.product_link          = p_fa_rec.product_link
     WHERE t.factory_ask_id = p_fa_rec.factory_ask_id;
    --t.ask_user_id        = p_fa_rec.ask_user_id,    
    --t.cooperation_method = p_fa_rec.cooperation_method,          
    --t.origin                   = p_fa_rec.origin,           
    --t.remarks     = p_fa_rec.remarks,
    --t.ask_company_id           = p_fa_rec.ask_company_id,
    --t.ask_record_id            = p_fa_rec.ask_record_id,
    --t.factrory_ask_flow_status = p_fa_rec.factrory_ask_flow_status,
    --t.factory_ask_type         = p_fa_rec.factory_ask_type,
    --t.cooperation_type         = p_fa_rec.cooperation_type,
    --t.cooperation_company_id   = p_fa_rec.cooperation_company_id,
    --t.ask_user_dept_id         = p_fa_rec.ask_user_dept_id,          
    --t.ask_files                = p_fa_rec.ask_files,          
    --t.social_credit_code       = p_fa_rec.social_credit_code,
    --t.rela_supplier_id         = p_fa_rec.rela_supplier_id,                    
    --t.company_mold          = p_fa_rec.company_mold,
  
  END p_update_factory_ask;

  --修改验厂申请单（工厂）
  PROCEDURE p_update_factory_ask_out(p_fo_rec scmdata.t_factory_ask_out%ROWTYPE) IS
  BEGIN
    UPDATE t_factory_ask_out t
       SET t.factory_name           = p_fo_rec.factory_name,
           t.factory_abbreviation   = p_fo_rec.factory_abbreviation,
           t.fa_social_credit_code  = p_fo_rec.fa_social_credit_code,
           t.factory_province       = p_fo_rec.factory_province,
           t.factory_city           = p_fo_rec.factory_city,
           t.factory_county         = p_fo_rec.factory_county,
           t.factory_detail_adress  = p_fo_rec.factory_detail_adress,
           t.factory_representative = p_fo_rec.factory_representative,
           t.factory_contact_phone  = p_fo_rec.factory_contact_phone,
           t.fa_contact_name        = p_fo_rec.fa_contact_name,
           t.fa_contact_phone       = p_fo_rec.fa_contact_phone,
           t.factory_type           = p_fo_rec.factory_type,
           t.factory_coop_model     = p_fo_rec.factory_coop_model,
           t.factory_coop_brand     = p_fo_rec.factory_coop_brand,
           t.product_link           = p_fo_rec.product_link,
           t.factory_gate           = p_fo_rec.factory_gate,
           t.factory_office         = p_fo_rec.factory_office,
           t.factory_site           = p_fo_rec.factory_site,
           t.factory_product        = p_fo_rec.factory_product,
           t.fa_certificate_file    = p_fo_rec.fa_certificate_file,
           t.remarks                = p_fo_rec.remarks,
           t.update_id              = p_fo_rec.update_id,
           t.update_time            = p_fo_rec.update_time,
           t.fa_brand_type          = p_fo_rec.fa_brand_type,
           t.fa_rela_supplier_id    = p_fo_rec.fa_rela_supplier_id
     WHERE t.factory_ask_out_id = p_fo_rec.factory_ask_out_id;
  
  END p_update_factory_ask_out;

  --Delete
  --Save
  --验厂申请保存
  PROCEDURE p_save_factory_ask(p_fa_rec      scmdata.t_factory_ask%ROWTYPE) IS
  
  BEGIN
  
    p_check_factory_ask_by_save(p_fa_rec      => p_fa_rec);
  
    p_update_factory_ask(p_fa_rec => p_fa_rec);
  
    /*IF f_is_create_fask(p_factory_ask_out_id => p_fo_rec.factory_ask_out_id) = 0 THEN
      p_insert_factory_ask_out(p_fo_rec => p_fo_rec);
    ELSE
      p_update_factory_ask_out(p_fo_rec => p_fo_rec);
    END IF;*/
  
  END p_save_factory_ask;
  --Check
  --判断是否生成工厂信息
  FUNCTION f_is_create_fask(p_factory_ask_out_id VARCHAR2) RETURN NUMBER IS
    v_flag NUMBER;
  BEGIN
    SELECT COUNT(1)
      INTO v_flag
      FROM scmdata.t_factory_ask_out t
     WHERE t.factory_ask_out_id = p_factory_ask_out_id;
    RETURN v_flag;
  END f_is_create_fask;

  --除合作申请已提交、验厂待申请、验厂待审批状态外，都不可保存
  FUNCTION f_check_fask_status(p_factory_ask_id VARCHAR2) RETURN BOOLEAN IS
    judge NUMBER(1);
  BEGIN
    SELECT COUNT(1)
      INTO judge
      FROM scmdata.t_factory_ask
     WHERE factory_ask_id = p_factory_ask_id
       AND factrory_ask_flow_status IN ('CA01', 'FA01', 'FA02');
    IF judge = 0 THEN
      RETURN FALSE;
    ELSE
      RETURN TRUE;
    END IF;
  END f_check_fask_status;

  --验厂申请单保存时校验
  PROCEDURE p_check_factory_ask_by_save(p_fa_rec      scmdata.t_factory_ask%ROWTYPE) IS
  BEGIN
    --1.除合作申请已提交、验厂待申请、验厂待审批状态外，都不可保存
    IF f_check_fask_status(p_factory_ask_id => p_fa_rec.factory_ask_id) THEN
      --2.附件长度校验
      IF lengthb(p_fa_rec.ask_files) > 256 THEN
        raise_application_error(-20002, '最多只可上传7个附件！');
      END IF;
      --3.校验流程中 供应商名称是否重复
      p_check_supp_name(p_company_id   => p_fa_rec.company_id,
                        p_company_name => p_fa_rec.company_name);
    
      --4.校验流程中 工厂名称是否重复  待做
      /*p_check_supp_name(p_company_id   => p_fo_rec.company_id,
      p_company_name => p_fo_rec.factory_name);*/
    
      --5.校验供应商信息 公司类型为xxx时，意向合作模式只能为xxx
      p_check_company_type(p_company_type      => p_fa_rec.company_type,
                           p_cooperation_model => p_fa_rec.cooperation_model);
    
      --6.校验工厂信息 公司类型为xxx时，意向合作模式只能为xxx
      /* p_check_company_type(p_company_type      => p_fo_rec.factory_type,
      p_cooperation_model => p_fo_rec.factory_coop_model);*/
    
      --7.当意向合作模式为外协工厂时，必须填写关联供应商！
      IF p_fa_rec.cooperation_model = 'OF' AND
         p_fa_rec.rela_supplier_id IS NULL THEN
        /* IF p_fo_rec.fa_rela_supplier_id IS NULL THEN
          raise_application_error(-20002,
                                  '当意向合作模式为外协工厂时，必须填写关联供应商！');
        END IF;*/
        raise_application_error(-20002,
                                '当意向合作模式为外协工厂时，必须填写关联供应商！');
      ELSE
        NULL;
      END IF;
    
    ELSE
      raise_application_error(-20002,
                              '除合作申请已提交、验厂待申请、验厂待审批状态外，都不可保存');
    END IF;
  END p_check_factory_ask_by_save;
  --3. 准入申请
  --待审核申请
  FUNCTION f_query_uncheck_admit_ask RETURN CLOB IS
    v_query_sql CLOB;
  BEGIN
    v_query_sql := q'[WITH dic AS
     (SELECT group_dict_value, group_dict_name, group_dict_type,group_dict_id,parent_id
        FROM scmdata.sys_group_dict),
     data_pri as
 (select listagg(distinct cooperation_classification, ';') within GROUP(ORDER BY cooperation_classification asc) category,
         object_id factory_ask_id
    from scmdata.t_ask_scope
   where  object_type = 'CA'
   group by object_id),
    data_ability as
 (select listagg(distinct cooperation_classification, ';') within GROUP(ORDER BY cooperation_classification asc) category,
         factory_report_id
    from scmdata.t_factory_report_ability
   group by factory_report_id)
   select a.factory_ask_id,
       a.factrory_ask_flow_status,
       substr(fals.group_dict_name,0,instr(fals.group_dict_name,'+')-1) FLOW_NODE_NAME,
       substr(fals.group_dict_name,instr(fals.group_dict_name,'+')+1,length(fals.group_dict_name)) FLOW_NODE_STATUS_DESC,
       a.factory_ask_type,
       decode(a.factory_ask_type, 0, '验厂申请', '验厂报告') factory_ask_report_detail,
       case
         when a.origin = 'CA' then
          (select company_id
             from t_ask_record
            where ask_record_id = a.ask_record_id)
         else
          a.cooperation_company_id
       end company_id,
       a.company_name ASK_COMPANY_NAME,
       ga.group_dict_name cooperation_type_sp,
       case
         when a.factory_ask_type = 0 then
          (SELECT listagg(group_dict_name, ';') within GROUP(ORDER BY 1)
             FROM dic
            WHERE group_dict_type = 'PRODUCT_TYPE'
              AND group_dict_value in
                  (select distinct cooperation_classification
                     from scmdata.t_ask_scope
                    where object_id = a.factory_ask_id
                      and object_type = 'CA'))
         else
          (SELECT listagg(distinct t.group_dict_name, ';') within GROUP(ORDER BY 1)
             FROM scmdata.t_factory_report_ability fra
             left join dic t
               on t.group_dict_value = fra.cooperation_classification
              AND t.group_dict_type = a.cooperation_type
            where fra.factory_report_id = fr.factory_report_id)
       end cooperation_classification_sp,
       (SELECT listagg(group_dict_name, ';') within GROUP(ORDER BY group_dict_value)
              FROM dic
             WHERE group_dict_type = 'SUPPLY_TYPE'
               AND instr(';' || a.cooperation_model || ';',
                         ';' || group_dict_value || ';') > 0) cooperation_model_desc,
        decode(a.factory_ask_type, 0, '不验厂', 1, '内部验厂', '第三方验厂') factory_ask_type_desc,
       case
         when a.factory_ask_type <> 0 then
          fr.check_result
         else
          null
       end check_result,  
       fr.admit_result,
       a.ask_date FACTORY_ASK_DATE,
       case
         when a.factory_ask_type <> 0 then
          fr.check_date
         else
          null
       end check_date,
       CASE WHEN a.is_urgent = '1' THEN 65535   ELSE NULL END GRIDBACKCOLOR
  from t_factory_ask a
  inner join data_pri c
    on c.factory_ask_id=a.factory_ask_id
  left join (select max(ol.oper_time) audit_time, ol.factory_ask_id
               from t_factory_ask_oper_log ol
              where ol.status_AF_OPER = 'FA12'
              group by ol.factory_ask_id) k
    on k.factory_ask_id = a.factory_ask_id
  left join t_factory_report fr
    on a.factory_ask_id = fr.factory_ask_id
     left join data_ability frc
    on frc.factory_report_id = fr.factory_report_id
  left join dic ga
    on a.cooperation_type = ga.group_dict_value
   and ga.group_dict_type = 'COOPERATION_TYPE'
/*  left join sys_group_dict gd
    on a.cooperation_model = gd.group_dict_value
   and gd.group_dict_type = 'SUPPLY_TYPE'*/
  left join dic fals
    on a.factrory_ask_flow_status = fals.group_dict_value
   and fals.group_dict_type = 'FACTORY_ASK_FLOW'
 where a.factrory_ask_flow_status in ('FA12', 'FA31')
   and a.company_id = %default_company_id%
   AND (%is_company_admin% = 1 or
       instr_priv(%coop_class_priv%, c.category) > 0 or
       instr_priv(%coop_class_priv%, frc.category) > 0)
 order by a.is_urgent DESC nulls last,k.audit_time asc]';
    RETURN v_query_sql;
  END f_query_uncheck_admit_ask;

  --已审核申请
  FUNCTION f_query_checked_admit_ask RETURN CLOB IS
    v_query_sql CLOB;
  BEGIN
    v_query_sql := q'[WITH dic AS
     (SELECT group_dict_value, group_dict_name, group_dict_type,group_dict_id,parent_id
        FROM scmdata.sys_group_dict),
      data_pri as
 (select listagg(distinct cooperation_classification, ';') within GROUP(ORDER BY cooperation_classification asc) category,
         object_id factory_ask_id
    from scmdata.t_ask_scope
   where object_type = 'CA'
   group by object_id),
 data_ability as
 (select listagg(distinct cooperation_classification, ';') within GROUP(ORDER BY cooperation_classification asc) category,
         factory_report_id
    from scmdata.t_factory_report_ability
   group by factory_report_id)
select a.factory_ask_id,
       a.factrory_ask_flow_status,
       a.factory_ask_type,
       substr(fals.group_dict_name, 0, instr(fals.group_dict_name, '+') - 1) FLOW_NODE_NAME,
       substr(fals.group_dict_name,
              instr(fals.group_dict_name, '+') + 1,
              length(fals.group_dict_name)) FLOW_NODE_STATUS_DESC,
       decode(a.factory_ask_type, 0, '验厂申请', '验厂报告') factory_ask_report_detail,
       case
         when a.origin = 'CA' then
          (select company_id
             from t_ask_record
            where ask_record_id = a.ask_record_id)
         else
          a.cooperation_company_id
       end company_id,
       a.company_name ASK_COMPANY_NAME,
       ga.group_dict_name cooperation_type_sp,
       case
         when a.factory_ask_type = 0 then
          (SELECT listagg(group_dict_name, ',') within GROUP(ORDER BY 1)
             FROM dic
            WHERE group_dict_type = 'PRODUCT_TYPE'
              AND group_dict_value in
                  (select distinct cooperation_classification
                     from scmdata.t_ask_scope
                    where object_id = a.factory_ask_id
                      and object_type = 'CA'))
         else
          (SELECT listagg(distinct t.group_dict_name, ',') within GROUP(ORDER BY 1)
             FROM scmdata.t_factory_report_ability fra
             left join dic t
               on t.group_dict_value = fra.cooperation_classification
              AND t.group_dict_type = a.cooperation_type
            where fra.factory_report_id = fr.factory_report_id)
       end cooperation_classification_sp,
       (SELECT listagg(group_dict_name, ';') within GROUP(ORDER BY group_dict_value)
              FROM dic
             WHERE group_dict_type = 'SUPPLY_TYPE'
               AND instr(';' || a.cooperation_model || ';',
                         ';' || group_dict_value || ';') > 0) cooperation_model_desc,
       --加个审核意见
       (select remarks
          from (select remarks
                  from t_factory_ask_oper_log
                 where factory_ask_id = a.factory_ask_id
                   and status_af_oper in ('FA22', 'FA21', 'FA32', 'FA33')
                 order by oper_time desc)
         where rownum <= 1) audit_comment,
       decode(a.factory_ask_type, 0, '不验厂', 1, '内部验厂', '第三方验厂') factory_ask_type_desc,
       case
         when a.factory_ask_type <> 0 then
          fr.check_result
         else
          null
       end check_result,
       fr.admit_result,
       a.ask_date FACTORY_ASK_DATE,
       case
         when a.factory_ask_type <> 0 then
          fr.check_date
         else
          null
       end check_date,
       CASE WHEN a.is_urgent = '1' THEN 65535   ELSE NULL END GRIDBACKCOLOR
  from t_factory_ask a
 inner join (select max(ol.oper_time) audit_time, ol.factory_ask_id
               from t_factory_ask_oper_log ol
              where ol.status_AF_OPER in ('FA21', 'FA22', 'FA32', 'FA33')
              group by ol.factory_ask_id) k
    on k.factory_ask_id = a.factory_ask_id
 inner join data_pri c
    on c.factory_ask_id = a.factory_ask_id
  left join t_factory_report fr
    on a.factory_ask_id = fr.factory_ask_id
  left join data_ability frc
    on frc.factory_report_id = fr.factory_report_id
  left join dic ga
    on a.cooperation_type = ga.group_dict_value
   and ga.group_dict_type = 'COOPERATION_TYPE'
  /*left join sys_group_dict gd
    on a.cooperation_model = gd.group_dict_value
   and gd.group_dict_type = 'SUPPLY_TYPE'*/
  left join dic fals
    on a.factrory_ask_flow_status = fals.group_dict_value
   and fals.group_dict_type = 'FACTORY_ASK_FLOW'
 where a.factrory_ask_flow_status in ('FA22', 'FA21', 'FA32', 'FA33')
   and a.company_id = %default_company_id%
   AND (%is_company_admin% = 1 or
       instr_priv(%coop_class_priv%, c.category) > 0 or
       instr_priv(%coop_class_priv%, frc.category) > 0)
 order by a.is_urgent DESC nulls last,k.audit_time desc]';
    RETURN v_query_sql;
  END f_query_checked_admit_ask;

END pkg_ask_record_mange;
/
