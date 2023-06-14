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
  FUNCTION f_query_coop_fp_supplier(p_type   NUMBER,
                                    p_origin VARCHAR2 DEFAULT NULL)
    RETURN CLOB;

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
  --PROCEDURE p_insert_factory_ask_out(p_fo_rec scmdata.t_factory_ask_out%ROWTYPE);
  --新增意向合作范围
  PROCEDURE p_insert_ask_scope(p_scope_rec scmdata.t_ask_scope%ROWTYPE);
  --Update
  --修改验厂申请单（供应商）
  PROCEDURE p_update_factory_ask(p_fa_rec scmdata.t_factory_ask%ROWTYPE);
  --修改验厂申请单（工厂）
  --PROCEDURE p_update_factory_ask_out(p_fo_rec scmdata.t_factory_ask_out%ROWTYPE);
  --Save
  --验厂申请保存
  PROCEDURE p_save_factory_ask(p_fa_rec scmdata.t_factory_ask%ROWTYPE);
  --除合作申请已提交、验厂待申请、验厂待审批状态外，都不可保存
  FUNCTION f_check_fask_status(p_factory_ask_id VARCHAR2) RETURN BOOLEAN;

  --验厂申请单保存时校验
  PROCEDURE p_check_factory_ask_by_save(p_fa_rec scmdata.t_factory_ask%ROWTYPE);
  --判断是否生成工厂信息
  --FUNCTION f_is_create_fask(p_factory_ask_out_id VARCHAR2) RETURN NUMBER;
  --3. 准入申请
  --待审核申请
  FUNCTION f_query_uncheck_admit_ask RETURN CLOB;
  --已审核申请
  FUNCTION f_query_checked_admit_ask RETURN CLOB;
  --验厂记录
  FUNCTION f_query_checked_records RETURN CLOB;
  --4.验厂报告  
  --待验厂
  FUNCTION f_query_uncheck_factory RETURN CLOB;
  --已验厂
  --p_type 0 待审核  1 已审核
  FUNCTION f_query_checked_factory(p_type NUMBER) RETURN CLOB;
  --添加验厂报告 基础信息
  FUNCTION f_query_check_factory_base RETURN CLOB;
  --添加验厂报告  附件
  FUNCTION f_query_check_factory_file RETURN CLOB;
  --update
  --添加验厂报告-修改
  PROCEDURE p_update_check_factory_report(p_fac_rec scmdata.t_factory_report%ROWTYPE,
                                          p_type    NUMBER);

  --lookup
  --生产线类型
  FUNCTION f_query_product_line_looksql(p_product_line_field VARCHAR2,
                                        p_suffix             VARCHAR2)
    RETURN CLOB;
  --质量等级
  FUNCTION f_query_quality_step_looksql(p_quality_step_field VARCHAR2,
                                        p_suffix             VARCHAR2)
    RETURN CLOB;
  --打版能力
  FUNCTION f_query_pattern_cap_looksql(p_pattern_cap_field VARCHAR2,
                                       p_suffix            VARCHAR2)
    RETURN CLOB;
  --面辅料采购能力
  FUNCTION f_query_fabric_purchase_cap_looksql(p_fabric_purchase_cap_field VARCHAR2,
                                               p_suffix                    VARCHAR2)
    RETURN CLOB;
  --面辅料检测能力
  FUNCTION f_query_fabric_check_cap_looksql(p_fabric_check_cap_field VARCHAR2,
                                            p_suffix                 VARCHAR2)
    RETURN CLOB;
  --成本等级
  FUNCTION f_query_cost_step_looksql(p_cost_step_field VARCHAR2,
                                     p_suffix          VARCHAR2) RETURN CLOB;
  --验厂结论
  FUNCTION f_query_check_result_looksql(p_check_result_field VARCHAR2,
                                        p_suffix             VARCHAR2)
    RETURN CLOB;
  --Action
  --验厂审核状态
  --验厂通过 验厂环节 待审核 => 已审核 FA13=>FA12
  --验厂不通过   验厂环节 待审核 =>不通过 =>意向合作清单  FA13=>FA14
  --驳回 验厂环节 待审核 => 待验厂  FA13=>FA11
  PROCEDURE p_check_fac_status_action(p_company_id VARCHAR2,
                                      p_user_id    VARCHAR2,
                                      p_fac_ask_id VARCHAR2,
                                      p_oper_code  VARCHAR2,
                                      p_status     VARCHAR2);

  --流程操作记录
  --流程操作记录
  PROCEDURE p_log_fac_records_oper(p_company_id    VARCHAR2,
                                   p_user_id       VARCHAR2,
                                   p_fac_ask_id    VARCHAR2 DEFAULT NULL, --验厂申请单ID
                                   p_ask_record_id VARCHAR2 DEFAULT NULL, --合作申请单ID
                                   p_flow_status   VARCHAR2, --流程操作 编码
                                   p_fac_ask_flow  VARCHAR2, --流程状态
                                   p_memo          VARCHAR2 DEFAULT NULL);

  --提交时校验必填项是否填写
  PROCEDURE p_tips_by_submit(p_data VARCHAR2, p_split VARCHAR2 DEFAULT ';');
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
                              '统一社会信用代码重复,该企业已准入通过,不可重新发起申请！');
    END IF;
  
    --是否已建档 已是企业的供应商，不需要发起申请
    SELECT nvl(MAX(1), 0)
      INTO p_result
      FROM t_supplier_info tsi
     WHERE tsi.social_credit_code = pi_social_credit_code
       AND tsi.company_id = pi_be_company_id;
    IF p_result = 1 THEN
      raise_application_error(-20002,
                              '统一社会信用代码重复,该企业已建档,不可重新发起申请！');
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
      raise_application_error(-20002,
                              '统一社会信用代码重复,该企业存在申请中的表单,不可重新发起申请！');
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
    --czh add校验
    IF pi_cooperation_classification IS NOT NULL AND
       pi_cooperation_product_cate IS NOT NULL AND
       pi_cooperation_type IS NOT NULL THEN
      NULL;
    ELSE
      raise_application_error(-20002,
                              '必填项不可为空,请填写完整合作范围！！');
    END IF;
  
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

  -------------------------------CZH ADD 所在分组配置--------------------------------
  --1.合作申请
  --QUERY
  --1.成品供应商
  --P_TYPE : 0:合作申请 成品供应商  A_COOP_121   1:重新申请  A_COOP_132_1  2：新增意向供应商 A_COOP_151
  FUNCTION f_query_coop_fp_supplier(p_type   NUMBER,
                                    p_origin VARCHAR2 DEFAULT NULL)
    RETURN CLOB IS
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
  
    --CZH 重构代码
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
       a.sapply_user ask_user_name,
       a.sapply_phone ask_user_phone,
       a.company_province,
       a.company_city,
       a.company_county,
       dp.province || dc.city || dco.county pcc,      
       a.company_address,
       a.cooperation_type,
       ga.group_dict_name cooperation_type_desc,
       a.cooperation_model,' || CASE
                     WHEN p_type = 2 OR p_origin IS NOT NULL THEN
                      NULL
                     ELSE
                      'a.ask_say,'
                   END || '
       a.remarks,
       a.certificate_file,
       a.other_file,
       a.legal_representative,
       a.company_contact_phone,
       a.company_type,
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

  --PICK
  --合作品牌/客户
  FUNCTION f_query_coop_brand_picksql(p_brand_field             VARCHAR2,
                                      p_cooperation_brand_field VARCHAR2,
                                      p_suffix                  VARCHAR2)
    RETURN CLOB IS
    v_query_sql CLOB;
  BEGIN
    --BRAND_TYPE,BRAND_TYPE_DESCCOOPERATION_BRAND
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
  --LOOK
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

  --INSERT
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

  --UPDATE
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
           t.company_name          = p_ar_rec.company_name,
           t.social_credit_code    = p_ar_rec.social_credit_code,
           t.remarks               = p_ar_rec.remarks
    /*  T.ASK_DATE                   = P_AR_REC.ASK_DATE,
    T.ASK_USER_ID                = P_AR_REC.ASK_USER_ID,     
    T.PRODUCTION_MODE            = P_AR_REC.PRODUCTION_MODE,             
    T.REMARKS                    = P_AR_REC.REMARKS,
    T.COOR_ASK_FLOW_STATUS       = P_AR_REC.COOR_ASK_FLOW_STATUS,
    T.COLLECTION                 = P_AR_REC.COLLECTION,
    T.ORIGIN                     = P_AR_REC.ORIGIN,
    T.COMPANY_NAME               = P_AR_REC.COMPANY_NAME,
    T.SOCIAL_CREDIT_CODE         = P_AR_REC.SOCIAL_CREDIT_CODE,
    T.COOPERATION_STATEMENT      = P_AR_REC.COOPERATION_STATEMENT,*/
     WHERE t.ask_record_id = p_ar_rec.ask_record_id;
  EXCEPTION
    WHEN OTHERS THEN
      ROLLBACK;
      sys_raise_app_error_pkg.is_running_error(p_is_running_error => 'T',
                                               p_is_log           => 1);
  END p_update_t_ask_record;

  --DELETE
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

  --CHECK
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
     WHERE be_company_id = p_company_id --P_AR_REC.BE_COMPANY_ID
       AND company_name = p_company_name --P_AR_REC.COMPANY_NAME
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
  --校验公司类型为XXX时，意向合作模式只能为XXX
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
                                '公司类型为制造型时，意向合作模式只可选择OEM、外协厂！');
      ELSE
        NULL;
      END IF;
    ELSE
      NULL;
    END IF;
  END p_check_company_type;

  --保存时校验数据
  --P_TYPE : 0:合作申请 成品供应商/重新申请  1：新增意向供应商
  PROCEDURE p_check_data_by_save(p_ar_rec scmdata.t_ask_record%ROWTYPE,
                                 p_type   NUMBER) IS
  
  BEGIN
    --公司所在区域必填
    IF p_ar_rec.company_province IS NULL OR p_ar_rec.company_city IS NULL OR
       p_ar_rec.company_county IS NULL THEN
      raise_application_error(-20002, '公司所在区域必填！');
    END IF;
    --校验公司类型为XXX时，意向合作模式只能为XXX
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
  --QUERY P_TYPE : 0 :申请验厂 a_coop_150_3  1：申请详情  a_coop_211  a_coop_221
  FUNCTION f_query_factory_ask(p_type NUMBER DEFAULT NULL) RETURN CLOB IS
    v_query_sql CLOB;
  BEGIN
    v_query_sql := Q'[ WITH dic AS
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
                       AND user_id = tfa.ask_user_id )) check_dept_name,
           (SELECT company_user_name
              FROM scmdata.sys_company_user
             WHERE company_id = %default_company_id%
               AND user_id = tfa.ask_user_id ) checkapply_person,
           (SELECT phone
              FROM scmdata.sys_user
             WHERE user_id = tfa.ask_user_id ) checkapply_phone,
           nvl(tfa.is_urgent,0) is_urgent,
           tfa.ask_date factory_ask_date,
           'PRODUCT_TYPE' cooperation_type,
           (SELECT group_dict_name
              FROM scmdata.sys_group_dict
             WHERE group_dict_value = 'PRODUCT_TYPE') cooperation_type_desc,
           tfa.cooperation_model,
         (SELECT listagg(distinct group_dict_name, ';') within GROUP(ORDER BY group_dict_value)
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
           tfa.factory_name,
           (SELECT b.pcc
              FROM pcc_dict b
             WHERE b.provinceid = tfa.factory_province
               AND b.cityno = tfa.factory_city
               AND b.countyid = tfa.factory_county) fpcc,
           tfa.ask_address,
           tfa.legal_representative,
           tfa.company_contact_phone,
           tfa.contact_name ask_user_name,
           tfa.contact_phone ask_user_phone,
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
           tfa.ask_files,
           tfa.supplier_gate,
           tfa.supplier_site,
           tfa.supplier_office,
           tfa.supplier_product,
           tfa.company_province,
           tfa.company_city,
           tfa.company_county,
           tfa.factory_province,
           tfa.factory_city,
           tfa.factory_county,
           TFA.FACTORY_ASK_ID,
           tfa.rela_supplier_id,
           (select t.supplier_company_name from scmdata.t_supplier_info t where t.company_id = tfa.company_id and t.social_credit_code = tfa.rela_supplier_id ) rela_supplier_id_desc,
           tfa.product_link,
           tfa.memo remarks, 
           --生产信息
           tfa.worker_num,
           tfa.machine_num,
           --需求原因，需删除预约产能占比
           --decode(tfa.reserve_capacity,null,'',tfa.reserve_capacity||'%') reserve_capacity,
           decode(tfa.product_efficiency,null,'80%',tfa.product_efficiency||'%') product_efficiency,
           tfa.work_hours_day,
           tfa.factory_ask_type                 
      FROM scmdata.t_factory_ask tfa ]' || CASE
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
    v_query_sql := Q'[WITH dic AS
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
       sapply_user ask_user_name,
       sapply_phone ask_user_phone,
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
         WHERE company_id =
               decode(tar.origin, 'MA', tar.be_company_id, tar.company_id)
           AND user_id = tar.create_id) creator,
       tar.create_date create_time,
       tar.ask_record_id,
       tar.factory_ask_id,
       tar.ask_user_id,
       tar.company_id,
       CASE
         WHEN tar.is_urgent = '1' THEN
          10090495
         ELSE
          NULL
       END gridbackcolor
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
               b.is_urgent,
               b.factory_ask_id
          FROM scmdata.t_ask_record a
          LEFT JOIN (SELECT *
                      FROM (SELECT c.ask_record_id,
                                   c.factory_ask_id,
                                   c.is_urgent,
                                   row_number() over(PARTITION BY c.ask_record_id ORDER BY c.create_date DESC) rn
                              FROM scmdata.t_factory_ask c) t
                     WHERE t.rn = 1) b
            ON a.ask_record_id = b.ask_record_id
         WHERE be_company_id = %default_company_id%
           AND instr('CA03,CA00,', coor_ask_flow_status || ',') = 0) tar
 ORDER BY nvl(tar.is_urgent, 0) DESC,
          nvl(collection, 0) DESC,
          coop_apply_date DESC ]';
    RETURN v_query_sql;
  END f_query_coop_supp_list;

  --验厂申请 我的申请记录  a_coop_210
  FUNCTION f_query_my_ask_rec RETURN CLOB IS
    v_query_sql CLOB;
  BEGIN
    v_query_sql := Q'[WITH dic AS
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
       tfa.factory_name,
       tfa.ask_address,
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
       CASE
         WHEN tfa.is_urgent = '1' THEN
          10090495
         ELSE
          NULL
       END gridbackcolor
  FROM (SELECT factory_ask_id,
               factrory_ask_flow_status,
               ask_date,
               factory_ask_type,
               cooperation_company_id,
               ask_company_id,
               ask_user_id,
               cooperation_type,
               cooperation_model,
               company_name,
               company_address,
               company_id,
               factory_name,
               ask_address,
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
  LEFT JOIN scmdata.sys_user su
    ON tfa.ask_user_id = su.user_id
 ORDER BY nvl(tfa.is_urgent, 0) DESC, tfa.create_date DESC
]';
  
    RETURN v_query_sql;
  END f_query_my_ask_rec;

  --验厂申请 待审核申请  a_coop_220
  FUNCTION f_query_uncheck_ask_rec RETURN CLOB IS
    v_query_sql CLOB;
  BEGIN
    v_query_sql := Q'[ WITH dic AS
     (SELECT group_dict_value, group_dict_name, group_dict_type,group_dict_id,parent_id
        FROM scmdata.sys_group_dict),
         data_pri AS
 (SELECT listagg(DISTINCT cooperation_classification, ';') within GROUP(ORDER BY cooperation_classification) category,
         object_id factory_ask_id
    FROM scmdata.t_ask_scope
   WHERE object_type = 'CA'
   GROUP BY object_id)
SELECT a.factory_ask_id,
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
       (SELECT listagg(group_dict_name, ';') within GROUP(ORDER BY group_dict_value)
              FROM dic
             WHERE group_dict_type = 'SUPPLY_TYPE'
               AND instr(';' || a.cooperation_model || ';',
                         ';' || group_dict_value || ';') > 0) cooperation_model_desc,
       a.factory_name,
       a.ask_address,
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
       CASE WHEN a.is_urgent = '1' THEN 10090495   ELSE NULL END GRIDBACKCOLOR
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
 WHERE a.company_id = %default_company_id%
   AND a.factrory_ask_flow_status = 'FA02'
/*   AND (instr_priv(%coop_class_priv%, c.category) > 0 OR
%is_company_admin% = '1')*/
 ORDER BY nvl(a.is_urgent,0) DESC,a.ask_date ASC
]';
    RETURN v_query_sql;
  END f_query_uncheck_ask_rec;

  --验厂申请 已审核申请 a_coop_230
  FUNCTION f_query_checked_ask_rec RETURN CLOB IS
    v_query_sql CLOB;
  BEGIN
    v_query_sql := Q'[ WITH dic AS
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
       (SELECT listagg(group_dict_name, ';') within GROUP(ORDER BY group_dict_value)
              FROM dic
             WHERE group_dict_type = 'SUPPLY_TYPE'
               AND instr(';' || a.cooperation_model || ';',
                         ';' || group_dict_value || ';') > 0) cooperation_model_desc,
       a.factory_name,
       a.ask_address,
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
       decode(a.factory_ask_type,
              0,
              '不验厂',
              1,
              '内部验厂',
              2,
              '第三方验厂') check_method,
       a.remarks,
       c2.logn_name check_company_name,
       CASE WHEN a.is_urgent = '1' THEN 10090495   ELSE NULL END GRIDBACKCOLOR
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
 WHERE a.company_id = %default_company_id%
   AND (a.factrory_ask_flow_status LIKE 'FA%' OR a.factrory_ask_flow_status = 'SP_01')
   AND factrory_ask_flow_status <> 'FA02'
 ORDER BY nvl(a.is_urgent,0) DESC,k.audit_time DESC
]';
    RETURN v_query_sql;
  END f_query_checked_ask_rec;

  --LOOKUP
  --是否紧急
  FUNCTION f_query_lookup_is_urgent RETURN CLOB IS
    v_query_sql CLOB;
  BEGIN
    v_query_sql := Q'[SELECT 0 is_urgent, '否' is_urgent_desc FROM dual
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
    v_query_sql := 'SELECT SUPPLIER_INFO_ID ' || p_rela_supplier_field ||
                   ', SUPPLIER_COMPANY_NAME ' || p_rela_supplier_field ||
                   p_suffix || '
  FROM SCMDATA.T_SUPPLIER_INFO
 WHERE COMPANY_ID = %DEFAULT_COMPANY_ID% AND STATUS = 1';
    RETURN v_query_sql;
  END f_query_lookup_rela_supplier;

  --INSERT 
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
       product_link,
       memo)
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
       p_fa_rec.product_link,
       p_fa_rec.memo);
  EXCEPTION
    WHEN OTHERS THEN
      ROLLBACK;
      sys_raise_app_error_pkg.is_running_error(p_is_running_error => 'T',
                                               p_is_log           => 1);
  END p_insert_factory_ask;
  --新增验厂申请单（工厂）
  /* PROCEDURE p_insert_factory_ask_out(p_fo_rec scmdata.t_factory_ask_out%ROWTYPE) IS
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
  EXCEPTION
    WHEN OTHERS THEN
      ROLLBACK;
      sys_raise_app_error_pkg.is_running_error(p_is_running_error => 'T',
                                               p_is_log           => 1);
  END p_insert_factory_ask_out;*/

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
  EXCEPTION
    WHEN OTHERS THEN
      ROLLBACK;
      sys_raise_app_error_pkg.is_running_error(p_is_running_error => 'T',
                                               p_is_log           => 1);
  END p_insert_ask_scope;
  --UPDATE
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
           t.factory_name          = p_fa_rec.factory_name,
           t.factory_province      = p_fa_rec.factory_province,
           t.factory_city          = p_fa_rec.factory_city,
           t.factory_county        = p_fa_rec.factory_county,
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
           t.ask_files             = p_fa_rec.ask_files,
           t.supplier_gate         = p_fa_rec.supplier_gate,
           t.supplier_office       = p_fa_rec.supplier_office,
           t.supplier_site         = p_fa_rec.supplier_site,
           t.supplier_product      = p_fa_rec.supplier_product,
           t.remarks               = p_fa_rec.remarks,
           t.memo                  = p_fa_rec.memo,
           --生产信息
           t.worker_num  = p_fa_rec.worker_num,
           t.machine_num = p_fa_rec.machine_num,
           --t.reserve_capacity   = p_fa_rec.reserve_capacity,
           t.product_efficiency = p_fa_rec.product_efficiency,
           t.work_hours_day     = p_fa_rec.work_hours_day,
           --其他
           --t.ask_user_id      = p_fa_rec.ask_user_id,
           t.update_id        = p_fa_rec.update_id,
           t.update_date      = p_fa_rec.update_date,
           t.rela_supplier_id = p_fa_rec.rela_supplier_id,
           t.product_link     = p_fa_rec.product_link
     WHERE t.factory_ask_id = p_fa_rec.factory_ask_id;
    --T.ASK_USER_ID        = P_FA_REC.ASK_USER_ID,    
    --T.COOPERATION_METHOD = P_FA_REC.COOPERATION_METHOD,          
    --T.ORIGIN                   = P_FA_REC.ORIGIN,           
    --T.REMARKS     = P_FA_REC.REMARKS,
    --T.ASK_COMPANY_ID           = P_FA_REC.ASK_COMPANY_ID,
    --T.ASK_RECORD_ID            = P_FA_REC.ASK_RECORD_ID,
    --T.FACTRORY_ASK_FLOW_STATUS = P_FA_REC.FACTRORY_ASK_FLOW_STATUS,
    --T.FACTORY_ASK_TYPE         = P_FA_REC.FACTORY_ASK_TYPE,
    --T.COOPERATION_TYPE         = P_FA_REC.COOPERATION_TYPE,
    --T.COOPERATION_COMPANY_ID   = P_FA_REC.COOPERATION_COMPANY_ID,
    --T.ASK_USER_DEPT_ID         = P_FA_REC.ASK_USER_DEPT_ID,          
    --T.ASK_FILES                = P_FA_REC.ASK_FILES,          
    --T.SOCIAL_CREDIT_CODE       = P_FA_REC.SOCIAL_CREDIT_CODE,
    --T.RELA_SUPPLIER_ID         = P_FA_REC.RELA_SUPPLIER_ID,                    
    --T.COMPANY_MOLD          = P_FA_REC.COMPANY_MOLD,
    /*  EXCEPTION
    WHEN OTHERS THEN
      ROLLBACK;
      sys_raise_app_error_pkg.is_running_error(p_is_running_error => 'T',
                                               p_is_log           => 1);*/
  END p_update_factory_ask;

  --修改验厂申请单（工厂）
  /*PROCEDURE p_update_factory_ask_out(p_fo_rec scmdata.t_factory_ask_out%ROWTYPE) IS
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
  EXCEPTION
    WHEN OTHERS THEN
      ROLLBACK;
      sys_raise_app_error_pkg.is_running_error(p_is_running_error => 'T',
                                               p_is_log           => 1);
  END p_update_factory_ask_out;*/

  --DELETE
  --SAVE
  --验厂申请保存
  PROCEDURE p_save_factory_ask(p_fa_rec scmdata.t_factory_ask%ROWTYPE) IS
  
  BEGIN
  
    p_check_factory_ask_by_save(p_fa_rec => p_fa_rec);
  
    p_update_factory_ask(p_fa_rec => p_fa_rec);
  
    /*IF F_IS_CREATE_FASK(P_FACTORY_ASK_OUT_ID => P_FO_REC.FACTORY_ASK_OUT_ID) = 0 THEN
      P_INSERT_FACTORY_ASK_OUT(P_FO_REC => P_FO_REC);
    ELSE
      P_UPDATE_FACTORY_ASK_OUT(P_FO_REC => P_FO_REC);
    END IF;*/
  
  END p_save_factory_ask;
  --CHECK
  --判断是否生成工厂信息
  /*  FUNCTION f_is_create_fask(p_factory_ask_out_id VARCHAR2) RETURN NUMBER IS
    v_flag NUMBER;
  BEGIN
    SELECT COUNT(1)
      INTO v_flag
      FROM scmdata.t_factory_ask_out t
     WHERE t.factory_ask_out_id = p_factory_ask_out_id;
    RETURN v_flag;
  END f_is_create_fask;*/

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
  PROCEDURE p_check_factory_ask_by_save(p_fa_rec scmdata.t_factory_ask%ROWTYPE) IS
    --v_area VARCHAR2(256);
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
    
      --4.校验流程中 工厂名称是否重复  
      /*P_CHECK_SUPP_NAME(P_COMPANY_ID   => P_FO_REC.COMPANY_ID,
      P_COMPANY_NAME => P_FO_REC.FACTORY_NAME);*/
    
      --5.校验供应商信息 公司类型为XXX时，意向合作模式只能为XXX
      p_check_company_type(p_company_type      => p_fa_rec.company_type,
                           p_cooperation_model => p_fa_rec.cooperation_model);
    
      --6.校验工厂信息 公司类型为XXX时，意向合作模式只能为XXX
      /* P_CHECK_COMPANY_TYPE(P_COMPANY_TYPE      => P_FO_REC.FACTORY_TYPE,
      P_COOPERATION_MODEL => P_FO_REC.FACTORY_COOP_MODEL);*/
    
      --7.当意向合作模式为外协工厂时，必须填写关联供应商！
      IF p_fa_rec.cooperation_model = 'OF' AND
         p_fa_rec.rela_supplier_id IS NULL THEN
        /* IF P_FO_REC.FA_RELA_SUPPLIER_ID IS NULL THEN
          RAISE_APPLICATION_ERROR(-20002,
                                  '当意向合作模式为外协工厂时，必须填写关联供应商！');
        END IF;*/
        raise_application_error(-20002,
                                '当意向合作模式为外协工厂时，必须填写关联供应商！');
      ELSE
        NULL;
      END IF;
      --公司所在区域与公司详细地址需在同一区域 舍去
      /*      SELECT a.province || b.city || c.county
        INTO v_area
        FROM scmdata.dic_province a
       INNER JOIN scmdata.dic_city b
          ON a.provinceid = b.provinceid
       INNER JOIN scmdata.dic_county c
          ON b.cityno = c.cityno
       WHERE a.provinceid = p_fa_rec.company_province
         AND b.cityno = p_fa_rec.company_city
         AND c.countyid = p_fa_rec.company_county;
      
      IF instr(p_fa_rec.company_address, v_area) = 0 THEN
        raise_application_error(-20002,
                                '公司所在区域与公司详细地址需在同一区域！');
      END IF;*/
    
    ELSE
      raise_application_error(-20002,
                              '除合作申请已提交、验厂待申请、验厂待审批状态外，都不可保存');
    END IF;
  END p_check_factory_ask_by_save;
  --3. 准入申请
  --待审核申请 a_coop_310
  FUNCTION f_query_uncheck_admit_ask RETURN CLOB IS
    v_query_sql CLOB;
  BEGIN
    v_query_sql := Q'[WITH dic AS
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
       end CHECK_FAC_RESULT,  
       fr.FACTORY_RESULT_SUGGEST,
       a.ask_date FACTORY_ASK_DATE,
       case
         when a.factory_ask_type <> 0 then
          fr.check_date
         else
          null
       end check_date,
       CASE WHEN a.is_urgent = '1' THEN 10090495   ELSE NULL END GRIDBACKCOLOR
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
  left join dic fals
    on a.factrory_ask_flow_status = fals.group_dict_value
   and fals.group_dict_type = 'FACTORY_ASK_FLOW'
 where a.factrory_ask_flow_status in ('FA12', 'FA31')
   and a.company_id = %default_company_id%
   AND (%is_company_admin% = 1 or
       instr_priv(%coop_class_priv%, c.category) > 0 or
       instr_priv(%coop_class_priv%, frc.category) > 0)
 order by nvl(a.is_urgent,0) DESC,k.audit_time asc]';
    RETURN v_query_sql;
  END f_query_uncheck_admit_ask;

  --已审核申请 a_coop_320
  FUNCTION f_query_checked_admit_ask RETURN CLOB IS
    v_query_sql CLOB;
  BEGIN
    v_query_sql := Q'[WITH dic AS
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
       end CHECK_FAC_RESULT,
       fr.FACTORY_RESULT_SUGGEST,
       a.ask_date FACTORY_ASK_DATE,
       case
         when a.factory_ask_type <> 0 then
          fr.check_date
         else
          null
       end check_date,
       CASE WHEN a.is_urgent = '1' THEN 10090495   ELSE NULL END GRIDBACKCOLOR
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
  left join dic fals
    on a.factrory_ask_flow_status = fals.group_dict_value
   and fals.group_dict_type = 'FACTORY_ASK_FLOW'
 where a.factrory_ask_flow_status in ('FA22', 'FA21', 'FA32', 'FA33','SP_01')
   and a.company_id = %default_company_id%
   AND (%is_company_admin% = 1 or
       instr_priv(%coop_class_priv%, c.category) > 0 or
       instr_priv(%coop_class_priv%, frc.category) > 0)
 order by nvl(a.is_urgent,0) DESC,k.audit_time desc]';
    RETURN v_query_sql;
  END f_query_checked_admit_ask;
  --验厂记录
  FUNCTION f_query_checked_records RETURN CLOB IS
    v_query_sql CLOB;
  BEGIN
    v_query_sql := q'[ SELECT *
  FROM (SELECT fa.factory_ask_id,
               fa.company_id,
               nvl((fr.check_date), '') check_date,
               (SELECT fc.logn_name
                  FROM scmdata.sys_company fc
                 WHERE fc.company_id = fa.company_id) fa_company_name,
               fa.ask_address,
               fr.check_result check_fac_result,
               fr.check_report_file,
               fa.factory_ask_id supplier_info_origin_id,
               nvl(fr.admit_result, '') trialorder_type
          FROM scmdata.t_factory_ask fa
         INNER JOIN scmdata.t_ask_record ar
            ON fa.ask_record_id = ar.ask_record_id
         INNER JOIN scmdata.t_factory_report fr
            ON fa.factory_ask_id = fr.factory_ask_id) v
 WHERE v.supplier_info_origin_id IN
       (SELECT sa.supplier_info_origin_id
          FROM scmdata.t_supplier_info sa
         WHERE sa.supplier_info_id = :supplier_info_id)
   AND v.company_id = %default_company_id%]';
    RETURN v_query_sql;
  END f_query_checked_records;

  --4.验厂报告  
  --待验厂  
  FUNCTION f_query_uncheck_factory RETURN CLOB IS
    v_query_sql CLOB;
  BEGIN
    v_query_sql := q'[WITH dic AS
 (SELECT group_dict_value, group_dict_name, group_dict_type
    FROM scmdata.sys_group_dict)
SELECT tfa.factory_ask_id,
       tfa.factrory_ask_flow_status,
       substr(status, instr(status, '+') + 1, length(status)) flow_node_status_desc,
       tfa.ask_date factory_ask_date,
       (SELECT company_user_name
          FROM scmdata.sys_company_user
         WHERE company_id = tfa.company_id
           AND user_id = tfa.ask_user_id) check_apply_username,
       su.phone check_apply_phone,
       tfa.company_name ask_company_name,
       (SELECT listagg(b.group_dict_name, ';')
          FROM (SELECT DISTINCT cooperation_classification tmp
                  FROM scmdata.t_ask_scope
                 WHERE object_id = tfa.factory_ask_id
                   AND be_company_id = tfa.company_id) a
         INNER JOIN dic b
            ON a.tmp = b.group_dict_value
           AND b.group_dict_type = 'PRODUCT_TYPE') cooperation_classification_desc,
       (SELECT listagg(group_dict_name, ';') within GROUP(ORDER BY group_dict_value)
              FROM dic
             WHERE group_dict_type = 'SUPPLY_TYPE'
               AND instr(';' || tfa.cooperation_model || ';',
                         ';' || group_dict_value || ';') > 0) cooperation_model_desc,
       tfa.company_address,
       tfa.factory_name,
       tfa.ask_address,
       (SELECT group_dict_name
          FROM dic
         WHERE group_dict_value = tfa.cooperation_type
           AND group_dict_type = 'COOPERATION_TYPE') cooperation_type_desc,
       tfa.factory_ask_type check_method,
       (SELECT group_dict_name
          FROM dic
         WHERE group_dict_value = CAST(tfa.factory_ask_type AS VARCHAR2(32))
           AND group_dict_type = 'FACTORY_ASK_TYPE') check_method_sp,
       CASE WHEN tfa.is_urgent = '1' THEN 10090495   ELSE NULL END GRIDBACKCOLOR
  FROM (SELECT factory_ask_id,
               factrory_ask_flow_status,
               ask_date,
               factory_ask_type,
               cooperation_company_id,
               ask_company_id,
               ask_user_id,
               factory_name,
               ask_address,
               cooperation_type,
               cooperation_model,
               company_name,
               company_address,
               company_id,
               create_date,
               (SELECT group_dict_name
                  FROM scmdata.sys_group_dict
                 WHERE group_dict_value = factrory_ask_flow_status
                   AND group_dict_type = 'FACTORY_ASK_FLOW') status,
               a.is_urgent
          FROM scmdata.t_factory_ask a
         WHERE ask_company_id = %default_company_id%
           AND factrory_ask_flow_status = 'FA11') tfa
  LEFT JOIN scmdata.sys_user su
    ON tfa.ask_user_id = su.user_id
 ORDER BY nvl(tfa.is_urgent,0) DESC, tfa.create_date DESC]';
    RETURN v_query_sql;
  END f_query_uncheck_factory;
  --已验厂  
  --p_type 0 待审核  1 已审核
  FUNCTION f_query_checked_factory(p_type NUMBER) RETURN CLOB IS
    v_query_sql CLOB;
  BEGIN
    v_query_sql := q'[WITH dic AS
 (SELECT group_dict_value, group_dict_name, group_dict_type
    FROM scmdata.sys_group_dict)
SELECT tfa.factory_ask_id, --验厂申请ID
       tfa.factrory_ask_flow_status, --流程状态
       substr(status, 1, instr(status, '+') - 1) flow_node_name,
       substr(status, instr(status, '+') + 1, length(status)) flow_node_status_desc,
       tfa.ask_date factory_ask_date, --验厂申请日期
       (SELECT company_user_name
          FROM scmdata.sys_company_user
         WHERE company_id = tfa.company_id
           AND user_id = tfa.ask_user_id) check_apply_username, --验厂申请人
       su.phone check_apply_phone, --验厂申请人手机
       tfa.company_name ask_company_name, --公司名称
       (SELECT listagg(b.group_dict_name, ';')
          FROM (SELECT DISTINCT cooperation_classification tmp
                  FROM scmdata.t_ask_scope
                 WHERE object_id = tfa.factory_ask_id) a
         INNER JOIN dic b
            ON a.tmp = b.group_dict_value
           AND b.group_dict_type = 'PRODUCT_TYPE') cooperation_classification_desc,
        (SELECT listagg(group_dict_name, ';') within GROUP(ORDER BY group_dict_value)
              FROM dic
             WHERE group_dict_type = 'SUPPLY_TYPE'
               AND instr(';' || tfa.cooperation_model || ';',
                         ';' || group_dict_value || ';') > 0) cooperation_model_desc,
       tfa.company_address, --公司地址
       tfa.factory_name,
       tfa.ask_address,
       (SELECT group_dict_name
          FROM dic
         WHERE group_dict_value = tfa.cooperation_type
           AND group_dict_type = 'COOPERATION_TYPE') cooperation_type_desc, --意向合作类型-名称
       tfa.factory_ask_type check_method, --验厂方式
       (SELECT group_dict_name
          FROM dic
         WHERE group_dict_value = CAST(tfa.factory_ask_type AS VARCHAR2(32))
           AND group_dict_type = 'FACTORY_ASK_TYPE') check_method_sp, --验厂方式-名称
       fr.factory_report_id,
       fr.check_result CHECK_FAC_RESULT,]' || CASE
                     WHEN p_type = 0 THEN
                      NULL
                     ELSE
                      ' fr.FACTORY_RESULT_SUGGEST, '
                   END || q'[
       CASE WHEN tfa.is_urgent = '1' THEN 10090495   ELSE NULL END GRIDBACKCOLOR
  FROM (SELECT factory_ask_id,
               factrory_ask_flow_status,
               ask_date,
               factory_ask_type,
               cooperation_company_id,
               ask_company_id,
               ask_user_id,
               factory_name,
               ask_address,
               cooperation_type,
               cooperation_model,
               company_name,
               company_id,
               company_address,
               create_date,
               (SELECT group_dict_name
                  FROM dic
                 WHERE group_dict_value = factrory_ask_flow_status
                   AND group_dict_type = 'FACTORY_ASK_FLOW') status,
               a.is_urgent
          FROM scmdata.t_factory_ask a ]' || CASE
                     WHEN p_type = 0 THEN
                      q'[ WHERE instr('FA13,',factrory_ask_flow_status || ',') > 0 AND]'
                     WHEN p_type = 1 THEN
                      q'[ WHERE instr('FA12,FA14,FA21,FA22,FA32,FA33,SP_01,',factrory_ask_flow_status || ',') > 0 AND]'
                     ELSE
                      ' WHERE '
                   END || q'[ ask_company_id = %default_company_id%) tfa
  inner join scmdata.t_factory_report fr on tfa.company_id = fr.company_id and tfa.factory_ask_id = fr.factory_ask_id
  LEFT JOIN scmdata.sys_user su
    ON tfa.ask_user_id = su.user_id
 ORDER BY nvl(tfa.is_urgent,0) desc,tfa.create_date DESC
]';
    RETURN v_query_sql;
  END f_query_checked_factory;

  --添加验厂报告  基础信息  a_check_101_1
  FUNCTION f_query_check_factory_base RETURN CLOB IS
    v_query_sql CLOB;
  BEGIN
    v_query_sql := Q'[WITH dic AS
 (SELECT group_dict_value,
         group_dict_name,
         group_dict_type,
         group_dict_id,
         parent_id
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
      ON dc.cityno = dt.cityno),
company_user AS
 (SELECT company_id, company_user_name, phone, user_id
    FROM scmdata.sys_company_user)
--申请信息
SELECT (SELECT dept_name
          FROM scmdata.sys_company_dept
         WHERE company_dept_id =
               (SELECT company_dept_id
                  FROM sys_company_user_dept
                 WHERE company_id = %default_company_id%
                   AND user_id = tfa.ask_user_id )) check_dept_name,
       (SELECT company_user_name
          FROM company_user
         WHERE company_id = %default_company_id%
           AND user_id = tfa.ask_user_id ) checkapply_person,
       (SELECT phone
          FROM company_user
         WHERE company_id = %default_company_id%
           AND user_id = tfa.ask_user_id ) checkapply_phone,
       nvl(tfa.is_urgent, 0) is_urgent,
       tfa.ask_date factory_ask_date,
       'PRODUCT_TYPE' cooperation_type,
       (SELECT group_dict_name
          FROM scmdata.sys_group_dict
         WHERE group_dict_value = 'PRODUCT_TYPE') cooperation_type_desc,
       tfa.cooperation_model,
       (SELECT listagg(group_dict_name, ';') within GROUP(ORDER BY group_dict_value)
          FROM scmdata.t_ask_scope t
         INNER JOIN dic
            ON group_dict_value = t.cooperation_classification
           AND group_dict_type = t.cooperation_type
         WHERE t.be_company_id = %default_company_id%
           AND t.object_id = tfa.factory_ask_id) cooperation_classification_des,
       nvl(tfa.product_type, '00') product_type,
       tfa.ask_say checkapply_intro,
       tfa.factrory_ask_flow_status,
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
       tfa.factory_name,
       (SELECT b.pcc
          FROM pcc_dict b
         WHERE b.provinceid = tfa.factory_province
           AND b.cityno = tfa.factory_city
           AND b.countyid = tfa.factory_county) fpcc,
       tfa.ask_address,
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
       (SELECT a.group_dict_name
          FROM dic a
         WHERE a.group_dict_type = 'COM_MANUFACTURER'
           AND a.group_dict_value = tfa.com_manufacturer) com_manufacturer_desc,
       tfa.company_province,
       tfa.company_city,
       tfa.company_county,
       tfa.factory_ask_id,
       tfa.rela_supplier_id,
       (SELECT t.supplier_company_name
          FROM scmdata.t_supplier_info t
         WHERE t.company_id = tfa.company_id
           AND t.supplier_info_id = tfa.rela_supplier_id) rela_supplier_id_desc,
       tfa.product_link,
       fr.remarks,
       --生产信息
       fr.factory_report_id,
       fr.product_line,
       fr.product_line_num,
       decode(fr.worker_num,null,nvl(tfa.worker_num,0),fr.worker_num) worker_num,
       decode(fr.machine_num,null,nvl(tfa.machine_num,0),fr.machine_num) machine_num,
       --decode(fr.reserve_capacity,null,nvl(tfa.reserve_capacity||'%',''),fr.reserve_capacity||'%') reserve_capacity,
       decode(fr.product_efficiency,null,nvl(tfa.product_efficiency||'%','80%'),fr.product_efficiency||'%') product_efficiency,
       decode(fr.work_hours_day,null,nvl(tfa.work_hours_day,0),fr.work_hours_day) work_hours_day,
       nvl(fr.quality_step, '01') quality_step,
       nvl(fr.pattern_cap, '00') pattern_cap,
       nvl(fr.fabric_purchase_cap, '00') fabric_purchase_cap,
       nvl(fr.fabric_check_cap, '00') fabric_check_cap,
       nvl(fr.cost_step, '01') cost_step,
       --验厂结果
       nvl(fr.check_person1, %current_userid%) check_person1,
       (SELECT company_user_name
          FROM company_user
         WHERE company_id = %default_company_id%
           AND user_id = nvl(fr.check_person1, %current_userid%)) check_person1_desc,
       nvl(fr.check_person1_phone,
           (SELECT phone
              FROM company_user
             WHERE company_id = %default_company_id%
               AND user_id = %current_userid%)) check_person1_phone,
       fr.check_date,
       fr.check_person2,
       (SELECT company_user_name
          FROM company_user
         WHERE company_id = %default_company_id%
           AND user_id = fr.check_person2) check_person2_desc,
       fr.check_person2_phone,
       fr.check_result check_fac_result,
       fr.check_say,
       tfa.factory_ask_type
  FROM scmdata.t_factory_ask tfa
 INNER JOIN scmdata.t_factory_report fr
    ON tfa.company_id = fr.company_id
   AND tfa.factory_ask_id = fr.factory_ask_id
 WHERE tfa.factory_ask_id = :factory_ask_id]';
    RETURN v_query_sql;
  END f_query_check_factory_base;

  --添加验厂报告   附件
  FUNCTION f_query_check_factory_file RETURN CLOB IS
    v_query_sql CLOB;
  BEGIN
    v_query_sql := Q'[SELECT fr.FACTORY_REPORT_ID,
           nvl(fr.certificate_file,tfa.certificate_file) certificate_file,
           nvl(fr.ask_files,tfa.ask_files) ask_files,
           fr.check_report_file,
           nvl(fr.supplier_gate,tfa.supplier_gate) supplier_gate,
           nvl(fr.supplier_site,tfa.supplier_site) supplier_site,
           nvl(fr.supplier_office,tfa.supplier_office) supplier_office,
           nvl(fr.supplier_product,tfa.supplier_product) supplier_product
      FROM scmdata.t_factory_ask tfa
     INNER JOIN scmdata.t_factory_report fr
        ON tfa.company_id = fr.company_id
       AND tfa.factory_ask_id = fr.factory_ask_id
     WHERE fr.FACTORY_REPORT_ID = :FACTORY_REPORT_ID]';
    RETURN v_query_sql;
  END f_query_check_factory_file;
  --update
  --添加验厂报告-修改
  PROCEDURE p_update_check_factory_report(p_fac_rec scmdata.t_factory_report%ROWTYPE,
                                          p_type    NUMBER) IS
  BEGIN
    IF p_type = 0 THEN
      UPDATE t_factory_report t
         SET t.product_line     = p_fac_rec.product_line,
             t.product_line_num = p_fac_rec.product_line_num,
             t.worker_num       = p_fac_rec.worker_num,
             t.machine_num      = p_fac_rec.machine_num,
             --t.reserve_capacity    = p_fac_rec.reserve_capacity,
             t.product_efficiency  = p_fac_rec.product_efficiency,
             t.work_hours_day      = p_fac_rec.work_hours_day,
             t.quality_step        = p_fac_rec.quality_step,
             t.pattern_cap         = p_fac_rec.pattern_cap,
             t.fabric_purchase_cap = p_fac_rec.fabric_purchase_cap,
             t.fabric_check_cap    = p_fac_rec.fabric_check_cap,
             t.cost_step           = p_fac_rec.cost_step,
             t.check_person1       = p_fac_rec.check_person1,
             t.check_person1_phone = p_fac_rec.check_person1_phone,
             t.check_person2       = p_fac_rec.check_person2,
             t.check_person2_phone = p_fac_rec.check_person2_phone,
             t.check_say           = p_fac_rec.check_say,
             t.check_result        = p_fac_rec.check_result,
             t.check_date          = p_fac_rec.check_date,
             t.update_id           = p_fac_rec.update_id,
             t.update_date         = p_fac_rec.update_date,
             t.remarks             = p_fac_rec.remarks
       WHERE t.factory_report_id = p_fac_rec.factory_report_id;
    ELSIF p_type = 1 THEN
      UPDATE t_factory_report t
         SET t.certificate_file  = p_fac_rec.certificate_file,
             t.ask_files         = p_fac_rec.ask_files,
             t.supplier_gate     = p_fac_rec.supplier_gate,
             t.supplier_office   = p_fac_rec.supplier_office,
             t.supplier_site     = p_fac_rec.supplier_site,
             t.supplier_product  = p_fac_rec.supplier_product,
             t.check_report_file = p_fac_rec.check_report_file,
             t.update_id         = p_fac_rec.update_id,
             t.update_date       = p_fac_rec.update_date
       WHERE t.factory_report_id = p_fac_rec.factory_report_id;
    ELSE
      raise_application_error(-20002, '修改类型出错，请联系管理员！');
    END IF;
  EXCEPTION
    WHEN OTHERS THEN
      ROLLBACK;
      sys_raise_app_error_pkg.is_running_error(p_is_running_error => 'T',
                                               p_is_log           => 1);
  END p_update_check_factory_report;

  --lookup
  --生产线类型
  FUNCTION f_query_product_line_looksql(p_product_line_field VARCHAR2,
                                        p_suffix             VARCHAR2)
    RETURN CLOB IS
    v_query_sql CLOB;
  BEGIN
    v_query_sql := 'SELECT t.group_dict_value ' || p_product_line_field ||
                   ', t.group_dict_name ' || p_product_line_field ||
                   p_suffix || ' 
      FROM scmdata.sys_group_dict t
     WHERE t.group_dict_type = ''PRODUCT_LINE''';
    RETURN v_query_sql;
  END f_query_product_line_looksql;
  --质量等级
  FUNCTION f_query_quality_step_looksql(p_quality_step_field VARCHAR2,
                                        p_suffix             VARCHAR2)
    RETURN CLOB IS
    v_query_sql CLOB;
  BEGIN
    v_query_sql := 'SELECT t.group_dict_value ' || p_quality_step_field ||
                   ', t.group_dict_name ' || p_quality_step_field ||
                   p_suffix || ' 
      FROM scmdata.sys_group_dict t
     WHERE t.group_dict_type = ''QUALITY_STEP''';
    RETURN v_query_sql;
  END f_query_quality_step_looksql;
  --打版能力
  FUNCTION f_query_pattern_cap_looksql(p_pattern_cap_field VARCHAR2,
                                       p_suffix            VARCHAR2)
    RETURN CLOB IS
    v_query_sql CLOB;
  BEGIN
    v_query_sql := 'SELECT t.group_dict_value ' || p_pattern_cap_field ||
                   ', t.group_dict_name ' || p_pattern_cap_field ||
                   p_suffix || ' 
      FROM scmdata.sys_group_dict t
     WHERE t.group_dict_type = ''PATTERN_CAP''';
    RETURN v_query_sql;
  END f_query_pattern_cap_looksql;
  --面辅料采购能力
  FUNCTION f_query_fabric_purchase_cap_looksql(p_fabric_purchase_cap_field VARCHAR2,
                                               p_suffix                    VARCHAR2)
    RETURN CLOB IS
    v_query_sql CLOB;
  BEGIN
    v_query_sql := 'SELECT t.group_dict_value ' ||
                   p_fabric_purchase_cap_field || ', t.group_dict_name ' ||
                   p_fabric_purchase_cap_field || p_suffix || ' 
      FROM scmdata.sys_group_dict t
     WHERE t.group_dict_type = ''FABRIC_PURCHASE_CAP''';
    RETURN v_query_sql;
  END f_query_fabric_purchase_cap_looksql;
  --面辅料检测能力
  FUNCTION f_query_fabric_check_cap_looksql(p_fabric_check_cap_field VARCHAR2,
                                            p_suffix                 VARCHAR2)
    RETURN CLOB IS
    v_query_sql CLOB;
  BEGIN
    v_query_sql := 'SELECT t.group_dict_value ' || p_fabric_check_cap_field ||
                   ', t.group_dict_name ' || p_fabric_check_cap_field ||
                   p_suffix || ' 
      FROM scmdata.sys_group_dict t
     WHERE t.group_dict_type = ''FABRIC_CHECK_CAP''';
    RETURN v_query_sql;
  END f_query_fabric_check_cap_looksql;
  --成本等级
  FUNCTION f_query_cost_step_looksql(p_cost_step_field VARCHAR2,
                                     p_suffix          VARCHAR2) RETURN CLOB IS
    v_query_sql CLOB;
  BEGIN
    v_query_sql := 'SELECT t.group_dict_value ' || p_cost_step_field ||
                   ', t.group_dict_name ' || p_cost_step_field || p_suffix || ' 
      FROM scmdata.sys_group_dict t
     WHERE t.group_dict_type = ''COST_STEP''';
    RETURN v_query_sql;
  END f_query_cost_step_looksql;
  --验厂结论
  FUNCTION f_query_check_result_looksql(p_check_result_field VARCHAR2,
                                        p_suffix             VARCHAR2)
    RETURN CLOB IS
    v_query_sql CLOB;
  BEGIN
    v_query_sql := 'SELECT t.group_dict_value ' || p_check_result_field ||
                   ', t.group_dict_name ' || p_check_result_field ||
                   p_suffix || ' 
      FROM scmdata.sys_group_dict t
     WHERE t.group_dict_type = ''CHECK_RESULT''
     ORDER BY t.group_dict_sort asc';
    RETURN v_query_sql;
  END f_query_check_result_looksql;
  --Action
  --验厂审核状态
  --验厂通过 验厂环节 待审核 => 已审核 FA13=>FA12
  --验厂不通过   验厂环节 待审核 =>不通过 =>意向合作清单  FA13=>FA14
  --驳回 验厂环节 待审核 => 待验厂  FA13=>FA11
  PROCEDURE p_check_fac_status_action(p_company_id VARCHAR2,
                                      p_user_id    VARCHAR2,
                                      p_fac_ask_id VARCHAR2,
                                      p_oper_code  VARCHAR2,
                                      p_status     VARCHAR2) IS
  
  BEGIN
    INSERT INTO scmdata.t_factory_ask_oper_log
      (log_id,
       factory_ask_id,
       oper_user_id,
       oper_code,
       status_af_oper,
       ask_record_id,
       oper_time,
       oper_user_company_id)
    VALUES
      (scmdata.f_get_uuid(),
       p_fac_ask_id,
       p_user_id,
       p_oper_code,
       p_status,
       (SELECT ask_record_id
          FROM scmdata.t_factory_ask
         WHERE factory_ask_id = p_fac_ask_id),
       SYSDATE,
       p_company_id);
  
    UPDATE scmdata.t_factory_ask
       SET factrory_ask_flow_status = p_status
     WHERE factory_ask_id = p_fac_ask_id
       AND company_id = p_company_id;
  
  EXCEPTION
    WHEN OTHERS THEN
      ROLLBACK;
      sys_raise_app_error_pkg.is_running_error(p_is_running_error => 'T',
                                               p_is_log           => 1);
  END p_check_fac_status_action;

  --流程操作记录
  PROCEDURE p_log_fac_records_oper(p_company_id    VARCHAR2,
                                   p_user_id       VARCHAR2,
                                   p_fac_ask_id    VARCHAR2 DEFAULT NULL, --验厂申请单ID
                                   p_ask_record_id VARCHAR2 DEFAULT NULL, --合作申请单ID
                                   p_flow_status   VARCHAR2, --流程操作 编码
                                   p_fac_ask_flow  VARCHAR2, --流程状态
                                   p_memo          VARCHAR2 DEFAULT NULL) IS
    v_ask_record_id VARCHAR2(32);
  BEGIN
    SELECT MAX(ask_record_id)
      INTO v_ask_record_id
      FROM t_factory_ask
     WHERE factory_ask_id = p_fac_ask_id;
  
    --验厂申请单
    IF p_fac_ask_id IS NOT NULL THEN
      UPDATE scmdata.t_factory_ask
         SET factrory_ask_flow_status = p_fac_ask_flow,
             update_id                = p_user_id,
             update_date              = SYSDATE
       WHERE factory_ask_id = p_fac_ask_id
         AND company_id = p_company_id;
    
      IF p_flow_status = 'CA03' THEN
        UPDATE t_ask_record
           SET coor_ask_flow_status = p_fac_ask_flow, ask_date = NULL
         WHERE ask_record_id = v_ask_record_id;
      ELSE
        NULL;
      END IF;
      --合作申请单    
    ELSIF p_ask_record_id IS NOT NULL THEN
      UPDATE t_ask_record
         SET ask_date = CASE
                          WHEN p_fac_ask_flow IN ('CA00', 'CA03') THEN
                           NULL
                          ELSE
                           SYSDATE
                        END,
             coor_ask_flow_status = p_fac_ask_flow,
             update_id            = p_user_id,
             update_date          = SYSDATE
       WHERE ask_record_id = p_ask_record_id;
    ELSE
      NULL;
    END IF;
    --记录操作日志
    INSERT INTO t_factory_ask_oper_log
      (log_id,
       factory_ask_id,
       oper_user_id,
       oper_code,
       status_af_oper,
       remarks,
       ask_record_id,
       oper_time,
       oper_user_company_id)
    VALUES
      (f_get_uuid(),
       p_fac_ask_id,
       p_user_id,
       p_flow_status,
       p_fac_ask_flow,
       p_memo,
       nvl(p_ask_record_id, v_ask_record_id),
       SYSDATE,
       p_company_id);
  
  EXCEPTION
    WHEN OTHERS THEN
      ROLLBACK;
      sys_raise_app_error_pkg.is_running_error(p_is_running_error => 'T',
                                               p_is_log           => 1);
  END;

  --提交时校验必填项是否填写
  PROCEDURE p_tips_by_submit(p_data VARCHAR2, p_split VARCHAR2 DEFAULT ';') IS
  BEGIN
    FOR i IN (SELECT regexp_substr(p_data,
                                   '[^' || p_split || ']+',
                                   1,
                                   LEVEL,
                                   'i') AS str
                FROM dual
              CONNECT BY LEVEL <=
                         length(p_data) -
                         length(regexp_replace(p_data, p_split, '')) + 1) LOOP
    
      IF i.str IS NULL THEN
        raise_application_error(-20002,
                                '必填项不可为空,请检查并填写完整！！');
      ELSE
        NULL;
      END IF;
    END LOOP;
  
  END p_tips_by_submit;

END pkg_ask_record_mange;
/
