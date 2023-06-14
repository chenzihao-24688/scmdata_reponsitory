CREATE OR REPLACE PACKAGE scmdata.pkg_ask_record_mange IS

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
  --校验流程字段在流程中是否重复
  --type = 1 供应资源库 2 验厂申请、验厂报告 3.供应商档案
  PROCEDURE p_check_flow_fields_is_repeat(p_company_id     VARCHAR2,
                                          p_object_id      VARCHAR2,
                                          p_flow_field     VARCHAR2,
                                          p_flow_field_val VARCHAR2,
                                          p_type           INT);
  --供应商资源库校验流程字段（公司名称;公司简称;统一社会信用代码）是否在流程中是否重复
  PROCEDURE p_check_flow_fields_ar_is_repeat(p_company_id     VARCHAR2,
                                             p_ask_record_id  VARCHAR2,
                                             p_flow_field     VARCHAR2,
                                             p_flow_field_val VARCHAR2);

  --准入流程校验流程字段（公司名称;公司简称;统一社会信用代码）是否在流程中是否重复
  PROCEDURE p_check_flow_fields_fa_fr_is_repeat(p_company_id     VARCHAR2,
                                                p_factory_ask_id VARCHAR2,
                                                p_flow_field     VARCHAR2,
                                                p_flow_field_val VARCHAR2);

  --供应商档案校验流程字段（公司名称;公司简称;统一社会信用代码）是否在流程中是否重复
  PROCEDURE p_check_flow_fields_sup_is_repeat(p_company_id     VARCHAR2,
                                              p_sup_id         VARCHAR2,
                                              p_flow_field     VARCHAR2,
                                              p_flow_field_val VARCHAR2);
  --合作申请
  --新增供应商原逻辑
  --现仅供供应商端使用
  FUNCTION f_query_coop_fp_supplier(p_type   NUMBER,
                                    p_origin VARCHAR2 DEFAULT NULL)
    RETURN CLOB;
  --合作申请
  --Query
  --1.新增意向供应商
  --p_item_id : 
  /* 0:合作申请 成品供应商  A_COOP_121  
  1:重新申请  A_COOP_132_1  
  2：新增意向供应商、查看详情 A_COOP_151*/
  FUNCTION f_query_coop_fp_supplier(p_item_id       VARCHAR2,
                                    p_ask_record_id VARCHAR2) RETURN CLOB;

  --Pick
  --合作品牌/客户
  FUNCTION f_query_coop_brand_picksql(p_brand_field_value             VARCHAR2,
                                      p_cooperation_brand_field_value VARCHAR2,
                                      p_brand_field_desc              VARCHAR2,
                                      p_cooperation_brand_field_desc  VARCHAR2)
    RETURN CLOB;
  --查询街道pick
  FUNCTION f_query_vill_picksql(p_county     VARCHAR2,
                                p_vill_value VARCHAR2,
                                p_vill_desc  VARCHAR2) RETURN CLOB;
  --按类型查询pick，同时置空其它字段
  FUNCTION f_query_picksql_by_type(p_group_dict_type   VARCHAR2,
                                   p_dict_value        VARCHAR2,
                                   p_dict_desc         VARCHAR2,
                                   p_setnull_fdvalue_1 VARCHAR2 DEFAULT 'fdvalue_1',
                                   p_setnull_fddesc_1  VARCHAR2 DEFAULT 'fddesc_1',
                                   p_setnull_fdvalue_2 VARCHAR2 DEFAULT 'fdvalue_2',
                                   p_setnull_fddesc_2  VARCHAR2 DEFAULT 'fddesc_2',
                                   p_setnull_fdvalue_3 VARCHAR2 DEFAULT 'fdvalue_3',
                                   p_setnull_fddesc_3  VARCHAR2 DEFAULT 'fddesc_3')
    RETURN CLOB;
  --Insert
  --新增意向供应商
  PROCEDURE p_insert_t_ask_record(p_ar_rec scmdata.t_ask_record%ROWTYPE);

  --Update
  --修改意向供应商
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
  --获取验厂申请人所在组织架构的三级部门
  FUNCTION f_get_check_third_dept_id(p_company_id VARCHAR2,
                                     p_user_id    VARCHAR2) RETURN VARCHAR2;
  --申请验厂
  PROCEDURE p_generate_factory_ask(p_ask_record_id VARCHAR2,
                                   p_company_id    VARCHAR2,
                                   p_user_id       VARCHAR2);
  --Query p_type : 0 :申请验厂
  FUNCTION f_query_factory_ask(p_item_id VARCHAR2, p_object_id VARCHAR2)
    RETURN CLOB;
  --验厂申请  意向合作清单
  FUNCTION f_query_coop_supp_list(p_data_privs VARCHAR2) RETURN CLOB;
  --验厂申请 我的申请记录
  FUNCTION f_query_my_ask_rec RETURN CLOB;
  --验厂申请 待审核申请
  FUNCTION f_query_uncheck_ask_rec RETURN CLOB;
  --验厂申请 已审核申请
  FUNCTION f_query_checked_ask_rec RETURN CLOB;
  --PICK_LIST
  --验厂申请人
  FUNCTION f_query_check_person_picksql RETURN CLOB;
  --验厂部门
  FUNCTION f_query_check_dept_name_picksql(p_company_id VARCHAR2,
                                           p_user_id    VARCHAR2) RETURN CLOB;
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
  --验厂申请提交校验
  PROCEDURE p_check_factory_ask_by_submit(p_fa_rec scmdata.t_factory_ask%ROWTYPE);

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

  --更新单据状态同时记录流程操作日志
  PROCEDURE p_update_flow_status_and_logger(p_company_id       VARCHAR2,
                                            p_user_id          VARCHAR2,
                                            p_fac_ask_id       VARCHAR2 DEFAULT NULL, --验厂申请单ID
                                            p_ask_record_id    VARCHAR2 DEFAULT NULL, --合作申请单ID
                                            p_flow_oper_status VARCHAR2, --流程操作方式编码
                                            --p_flow_bf_status   VARCHAR2, --操作前流程状态
                                            p_flow_af_status VARCHAR2, --操作后流程状态
                                            p_memo           VARCHAR2 DEFAULT NULL);
  --查询流程日志
  FUNCTION f_query_flow_status_logger(p_ask_record_id VARCHAR2 DEFAULT NULL,
                                      p_ask_fac_id    VARCHAR2 DEFAULT NULL)
    RETURN CLOB;

  --提交时校验必填项是否填写
  PROCEDURE p_tips_by_submit(p_data VARCHAR2, p_split VARCHAR2 DEFAULT ';');

  --合作范围
  --查询
  FUNCTION f_query_t_ask_scope(p_object_id VARCHAR2) RETURN CLOB;
  --新增T_ASK_SCOPE
  PROCEDURE p_insert_t_ask_scope(p_t_ask_rec scmdata.t_ask_scope%ROWTYPE);
  --修改T_ASK_SCOPE
  PROCEDURE p_update_t_ask_scope(p_t_ask_rec scmdata.t_ask_scope%ROWTYPE);
  --删除T_ASK_SCOPE
  PROCEDURE p_delete_t_ask_scope(p_t_ask_rec scmdata.t_ask_scope%ROWTYPE);
  --合作申请
  --人员、机器配置
  --查询T_PERSON_CONFIG_HZ
  FUNCTION f_query_t_person_config_hz(p_ask_record_id VARCHAR2) RETURN CLOB;
  --新增T_PERSON_CONFIG_HZ
  PROCEDURE p_insert_t_person_config_hz(p_t_per_rec t_person_config_hz%ROWTYPE);
  --修改T_PERSON_CONFIG_HZ
  PROCEDURE p_update_t_person_config_hz(p_t_per_rec t_person_config_hz%ROWTYPE);
  --删除T_PERSON_CONFIG_HZ
  PROCEDURE p_delete_t_person_config_hz(p_t_per_rec t_person_config_hz%ROWTYPE);

  --查询T_MACHINE_EQUIPMENT_HZ
  FUNCTION f_query_t_machine_equipment_hz(p_ask_record_id VARCHAR2)
    RETURN CLOB;
  --新增T_MACHINE_EQUIPMENT_HZ
  PROCEDURE p_insert_t_machine_equipment_hz(p_t_mac_rec t_machine_equipment_hz%ROWTYPE);
  --修改T_MACHINE_EQUIPMENT_HZ
  PROCEDURE p_update_t_machine_equipment_hz(p_t_mac_rec t_machine_equipment_hz%ROWTYPE);
  --新增 修改校验
  PROCEDURE p_check_t_machine_equipment_hz(p_t_mac_rec t_machine_equipment_hz%ROWTYPE);
  --删除校验
  PROCEDURE p_check_t_machine_equipment_hz_by_delete(p_orgin VARCHAR2);
  --删除T_MACHINE_EQUIPMENT_HZ
  PROCEDURE p_delete_t_machine_equipment_hz(p_t_mac_rec t_machine_equipment_hz%ROWTYPE);

  --新增意向供应商时，同步生成人员、机器配置
  PROCEDURE p_generate_person_machine_config(p_company_id    VARCHAR2,
                                             p_user_id       VARCHAR2,
                                             p_ask_record_id VARCHAR2);
  --人员配置保存
  --同步更新主表中生产信息的”总人数“、”车位人数“、”成型人数_鞋类“、”打版能力“、”面料采购能力“
  PROCEDURE p_generate_ask_record_product_info(p_company_id    VARCHAR2,
                                               p_ask_record_id VARCHAR2);
END pkg_ask_record_mange;
/
CREATE OR REPLACE PACKAGE BODY scmdata.pkg_ask_record_mange IS
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

  -------------------------------CZH ADD 配置--------------------------------
  --校验流程字段在流程中是否重复
  --p_object_id 为空：校验所有  不为空：排除当前ID的其它数据
  --type = 1 供应资源库 2 验厂申请、验厂报告 3.供应商档案
  --p_flow_field 字段名  多值则以;号分隔  COMPANY_NAME;COMPANY_ABBREVIATION;SOCIAL_CREDIT_CODE
  --p_flow_field_val 字段值 多值则以;号分隔  aaa;bbb;ccc
  PROCEDURE p_check_flow_fields_is_repeat(p_company_id     VARCHAR2,
                                          p_object_id      VARCHAR2,
                                          p_flow_field     VARCHAR2,
                                          p_flow_field_val VARCHAR2,
                                          p_type           INT) IS
    v_flow_field_val VARCHAR2(2000);
    v_factory_ask_id VARCHAR2(32);
    v_ask_record_id  VARCHAR2(32);
    v_origin_id      VARCHAR2(32);
  BEGIN
    FOR str_rec IN (SELECT regexp_substr(temp.str, '[^;]+', 1, LEVEL) str,
                           LEVEL rn
                      FROM (SELECT p_flow_field str FROM dual) temp
                    CONNECT BY LEVEL <= regexp_count(p_flow_field, '[^;]+')) LOOP
      SELECT MAX(v.str)
        INTO v_flow_field_val
        FROM (SELECT regexp_substr(temp.str, '[^;]+', 1, LEVEL) str,
                     LEVEL rn
                FROM (SELECT p_flow_field_val str FROM dual) temp
              CONNECT BY LEVEL <= regexp_count(p_flow_field_val, '[^;]+')) v
       WHERE v.rn = str_rec.rn;
      IF p_type = 1 THEN
        --供应商档案校验流程字段（公司名称;公司简称;统一社会信用代码）是否在流程中是否重复
        p_check_flow_fields_sup_is_repeat(p_company_id     => p_company_id,
                                          p_sup_id         => NULL,
                                          p_flow_field     => str_rec.str,
                                          p_flow_field_val => v_flow_field_val);
      
        SELECT MAX(t.factory_ask_id)
          INTO v_factory_ask_id
          FROM scmdata.t_factory_ask t
         WHERE t.ask_record_id = p_object_id
           AND t.company_id = p_company_id
         ORDER BY t.create_date DESC;
      
        --准入流程校验流程字段（公司名称;公司简称;统一社会信用代码）是否在流程中是否重复
        p_check_flow_fields_fa_fr_is_repeat(p_company_id     => p_company_id,
                                            p_factory_ask_id => v_factory_ask_id,
                                            p_flow_field     => str_rec.str,
                                            p_flow_field_val => v_flow_field_val);
      
        --供应商资源库校验流程字段（公司名称;公司简称;统一社会信用代码）是否在流程中是否重复
        p_check_flow_fields_ar_is_repeat(p_company_id     => p_company_id,
                                         p_ask_record_id  => p_object_id,
                                         p_flow_field     => str_rec.str,
                                         p_flow_field_val => v_flow_field_val);
      
      ELSIF p_type = 2 THEN
        --供应商档案校验流程字段（公司名称;公司简称;统一社会信用代码）是否在流程中是否重复
        p_check_flow_fields_sup_is_repeat(p_company_id     => p_company_id,
                                          p_sup_id         => NULL,
                                          p_flow_field     => str_rec.str,
                                          p_flow_field_val => v_flow_field_val);
      
        --准入流程校验流程字段（公司名称;公司简称;统一社会信用代码）是否在流程中是否重复
        p_check_flow_fields_fa_fr_is_repeat(p_company_id     => p_company_id,
                                            p_factory_ask_id => p_object_id,
                                            p_flow_field     => str_rec.str,
                                            p_flow_field_val => v_flow_field_val);
        SELECT MAX(t.ask_record_id)
          INTO v_ask_record_id
          FROM scmdata.t_factory_ask t
         WHERE t.factory_ask_id = p_object_id
           AND t.company_id = p_company_id
         ORDER BY t.create_date DESC;
      
        --供应商资源库校验流程字段（公司名称;公司简称;统一社会信用代码）是否在流程中是否重复
        p_check_flow_fields_ar_is_repeat(p_company_id     => p_company_id,
                                         p_ask_record_id  => v_ask_record_id,
                                         p_flow_field     => str_rec.str,
                                         p_flow_field_val => v_flow_field_val);
      
      ELSIF p_type = 3 THEN
        --新增档案时校验
        p_check_flow_fields_sup_is_repeat(p_company_id     => p_company_id,
                                          p_sup_id         => p_object_id,
                                          p_flow_field     => str_rec.str,
                                          p_flow_field_val => v_flow_field_val);
      
        SELECT MAX(t.supplier_info_origin_id)
          INTO v_origin_id
          FROM scmdata.t_supplier_info t
         WHERE t.supplier_info_id = p_object_id
           AND t.company_id = p_company_id;
      
        --校验是否存在并发运行的单据是否与新增档案时重复  
        IF v_origin_id IS NULL THEN
          --准入流程校验流程字段（公司名称;公司简称;统一社会信用代码）是否在流程中是否重复
          p_check_flow_fields_fa_fr_is_repeat(p_company_id     => p_company_id,
                                              p_factory_ask_id => NULL,
                                              p_flow_field     => str_rec.str,
                                              p_flow_field_val => v_flow_field_val);
        
          --供应商资源库校验流程字段（公司名称;公司简称;统一社会信用代码）是否在流程中是否重复
          p_check_flow_fields_ar_is_repeat(p_company_id     => p_company_id,
                                           p_ask_record_id  => NULL,
                                           p_flow_field     => str_rec.str,
                                           p_flow_field_val => v_flow_field_val);
        
        ELSE
          SELECT MAX(t.ask_record_id), MAX(t.factory_ask_id)
            INTO v_ask_record_id, v_factory_ask_id
            FROM scmdata.t_factory_ask t
           WHERE t.factory_ask_id = v_origin_id
             AND t.company_id = p_company_id
           ORDER BY t.create_date DESC;
          --准入流程校验流程字段（公司名称;公司简称;统一社会信用代码）是否在流程中是否重复
          p_check_flow_fields_fa_fr_is_repeat(p_company_id     => p_company_id,
                                              p_factory_ask_id => v_factory_ask_id,
                                              p_flow_field     => str_rec.str,
                                              p_flow_field_val => v_flow_field_val);
          --供应商资源库校验流程字段（公司名称;公司简称;统一社会信用代码）是否在流程中是否重复
          p_check_flow_fields_ar_is_repeat(p_company_id     => p_company_id,
                                           p_ask_record_id  => v_ask_record_id,
                                           p_flow_field     => str_rec.str,
                                           p_flow_field_val => v_flow_field_val);
        
        END IF;
      ELSE
        NULL;
      END IF;
    END LOOP;
  END p_check_flow_fields_is_repeat;

  --供应商资源库校验流程字段（公司名称;公司简称;统一社会信用代码）是否在流程中是否重复
  PROCEDURE p_check_flow_fields_ar_is_repeat(p_company_id     VARCHAR2,
                                             p_ask_record_id  VARCHAR2,
                                             p_flow_field     VARCHAR2,
                                             p_flow_field_val VARCHAR2) IS
    v_cnt INT;
    v_sql CLOB;
  BEGIN
    IF p_ask_record_id IS NULL THEN
      v_sql := q'[SELECT COUNT(1)
        FROM scmdata.t_ask_record ar
       WHERE ar.be_company_id = :company_id
         AND ar.]' || p_flow_field ||
               q'[ = :flow_field_val
         AND ar.coor_ask_flow_status = 'CA01']';
    
      EXECUTE IMMEDIATE v_sql
        INTO v_cnt
        USING p_company_id, p_flow_field_val;
    ELSE
      v_sql := q'[SELECT COUNT(1)
        FROM scmdata.t_ask_record ar
       WHERE ar.be_company_id = :company_id
         AND ar.]' || p_flow_field ||
               q'[ = :flow_field_val
         AND ar.ask_record_id <> :ask_record_id
         AND ar.coor_ask_flow_status = 'CA01']';
    
      EXECUTE IMMEDIATE v_sql
        INTO v_cnt
        USING p_company_id, p_flow_field_val, p_ask_record_id;
    END IF;
  
    IF v_cnt > 0 THEN
      raise_application_error(-20002,
                              (CASE WHEN p_flow_field = 'COMPANY_NAME' THEN
                               '【公司名称】' WHEN
                               p_flow_field = 'COMPANY_ABBREVIATION' THEN
                               '【公司简称】' WHEN
                               p_flow_field = 'SOCIAL_CREDIT_CODE' THEN
                               '【统一社会信用代码】' ELSE NULL END) ||
                              '不能与当前企业在【供应商资源库】中的' ||
                              (CASE WHEN p_flow_field = 'COMPANY_NAME' THEN
                               '公司名称' WHEN
                               p_flow_field = 'COMPANY_ABBREVIATION' THEN
                               '公司简称' WHEN
                               p_flow_field = 'SOCIAL_CREDIT_CODE' THEN
                               '统一社会信用代码' ELSE NULL END) || '重复');
    END IF;
  END p_check_flow_fields_ar_is_repeat;

  --准入流程校验流程字段（公司名称;公司简称;统一社会信用代码）是否在流程中是否重复
  PROCEDURE p_check_flow_fields_fa_fr_is_repeat(p_company_id     VARCHAR2,
                                                p_factory_ask_id VARCHAR2,
                                                p_flow_field     VARCHAR2,
                                                p_flow_field_val VARCHAR2) IS
    v_cnt INT;
    v_sql CLOB;
  BEGIN
    IF p_factory_ask_id IS NULL THEN
      v_sql := q'[SELECT COUNT(1)
      FROM scmdata.t_factory_ask a
     WHERE a.company_id = :company_id
       AND a.]' || p_flow_field ||
               q'[ = :flow_field_val
       AND a.factrory_ask_flow_status IN
           ('FA01','FA02', 'FA11', 'FA12', 'FA22', 'FA31')]';
    
      EXECUTE IMMEDIATE v_sql
        INTO v_cnt
        USING p_company_id, p_flow_field_val;
    ELSE
      v_sql := q'[SELECT COUNT(1)
      FROM scmdata.t_factory_ask a
     WHERE a.company_id = :company_id
       AND a.]' || p_flow_field ||
               q'[ = :flow_field_val
       AND a.factory_ask_id <> :factory_ask_id
       AND a.factrory_ask_flow_status IN
           ('FA01','FA02', 'FA11', 'FA12', 'FA22', 'FA31')]';
    
      EXECUTE IMMEDIATE v_sql
        INTO v_cnt
        USING p_company_id, p_flow_field_val, p_factory_ask_id;
    END IF;
  
    IF v_cnt > 0 THEN
      raise_application_error(-20002,
                              (CASE WHEN p_flow_field = 'COMPANY_NAME' THEN
                               '【公司名称】' WHEN
                               p_flow_field = 'COMPANY_ABBREVIATION' THEN
                               '【公司简称】' WHEN
                               p_flow_field = 'SOCIAL_CREDIT_CODE' THEN
                               '【统一社会信用代码】' ELSE NULL END) ||
                              '不能与当前企业在【准入流程】中的' ||
                              (CASE WHEN p_flow_field = 'COMPANY_NAME' THEN
                               '公司名称' WHEN
                               p_flow_field = 'COMPANY_ABBREVIATION' THEN
                               '公司简称' WHEN
                               p_flow_field = 'SOCIAL_CREDIT_CODE' THEN
                               '统一社会信用代码' ELSE NULL END) || '重复');
    END IF;
  END p_check_flow_fields_fa_fr_is_repeat;

  --供应商档案校验流程字段（公司名称;公司简称;统一社会信用代码）是否在流程中是否重复
  PROCEDURE p_check_flow_fields_sup_is_repeat(p_company_id     VARCHAR2,
                                              p_sup_id         VARCHAR2,
                                              p_flow_field     VARCHAR2,
                                              p_flow_field_val VARCHAR2) IS
    v_cnt        INT;
    v_sql        CLOB;
    v_status     INT;
    v_flow_field VARCHAR2(256);
  BEGIN
    v_flow_field := (CASE
                      WHEN p_flow_field = 'COMPANY_NAME' THEN
                       'SUPPLIER_COMPANY_NAME'
                      WHEN p_flow_field = 'COMPANY_ABBREVIATION' THEN
                       'SUPPLIER_COMPANY_ABBREVIATION'
                      WHEN p_flow_field = 'SOCIAL_CREDIT_CODE' THEN
                       'SOCIAL_CREDIT_CODE'
                      ELSE
                       NULL
                    END);
    IF p_sup_id IS NULL THEN
      v_sql := q'[SELECT COUNT(*)
      FROM scmdata.t_supplier_info a
     WHERE a.company_id = :company_id
       AND a.]' || v_flow_field || q'[ = :flow_field_val]';
    
      EXECUTE IMMEDIATE v_sql
        INTO v_cnt
        USING p_company_id, p_flow_field_val;
    ELSE
      v_sql := q'[SELECT COUNT(*)
      FROM scmdata.t_supplier_info a
     WHERE a.company_id = :company_id
       AND a.supplier_company_name = :company_name
       AND a.supplier_info_id <> :supplier_info_id]';
    
      EXECUTE IMMEDIATE v_sql
        INTO v_cnt
        USING p_company_id, p_flow_field_val, p_sup_id;
    END IF;
  
    IF v_cnt > 0 THEN
      SELECT MAX(t.status)
        INTO v_status
        FROM scmdata.t_supplier_info t
       WHERE t.supplier_info_id = p_sup_id
         AND t.company_id = p_company_id;
    
      raise_application_error(-20002,
                              (CASE WHEN p_flow_field = 'COMPANY_NAME' THEN
                               '【公司名称】' WHEN
                               p_flow_field = 'COMPANY_ABBREVIATION' THEN
                               '【公司简称】' WHEN
                               p_flow_field = 'SOCIAL_CREDIT_CODE' THEN
                               '【统一社会信用代码】' ELSE NULL END) ||
                              '不能与当前企业在【供应商档案】' ||
                              (CASE WHEN v_status = 0 THEN '待建档' WHEN
                               v_status = 1 THEN '已建档' ELSE '待建档,已建档' END) || '的' ||
                              (CASE WHEN
                               v_flow_field = 'SUPPLIER_COMPANY_NAME' THEN
                               '公司名称' WHEN v_flow_field =
                               'SUPPLIER_COMPANY_ABBREVIATION' THEN '公司简称' WHEN
                               v_flow_field = 'SOCIAL_CREDIT_CODE' THEN
                               '统一社会信用代码' ELSE NULL END) || '重复');
    END IF;
  END p_check_flow_fields_sup_is_repeat;

  --合作申请
  --新增供应商原逻辑
  --现仅供供应商端使用
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
       a.company_vill,
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
  --1.合作申请
  --QUERY
  --1.新增意向供应商
  --原p_item_id : 
  /* 0:合作申请 成品供应商  A_COOP_121  
  1:重新申请  A_COOP_132_1  
  2：新增意向供应商、查看详情 A_COOP_151*/
  --新共用item：a_coop_151
  FUNCTION f_query_coop_fp_supplier(p_item_id       VARCHAR2,
                                    p_ask_record_id VARCHAR2) RETURN CLOB IS
    v_query_sql CLOB;
    v_where     CLOB;
  BEGIN
    IF p_item_id = 'a_coop_121' THEN
      v_where := q'[ WHERE t.company_id = %default_company_id%
   AND t.coor_ask_flow_status IN ('CA00')
   AND t.be_company_id =
       (SELECT company_id
          FROM t_supplier_type
         WHERE supplier_type_id = :supplier_type_id)
 ORDER BY t.create_date DESC]';
    ELSIF p_item_id IN ('a_coop_132_1', 'a_coop_151_1') THEN
      v_where := ' WHERE t.ask_record_id = ''' || p_ask_record_id || '''';
    ELSIF p_item_id = 'a_coop_151' THEN
      v_where := q'[ WHERE t.coor_ask_flow_status = 'CA00'
   AND t.be_company_id = %default_company_id%
   AND t.create_id = %current_userid%
 ORDER BY t.create_date DESC ]';
    ELSE
      raise_application_error(-20002, '查询类型错误，请联系管理员');
    END IF;
  
    --CZH 重构代码
    v_query_sql := q'[WITH group_dict AS
 (SELECT t.group_dict_type,
         t.group_dict_value,
         t.group_dict_name,
         t.group_dict_id,
         t.parent_id
    FROM scmdata.sys_group_dict t
   WHERE t.pause = 0)
--基本资料
SELECT t.ask_record_id,
       t.company_id,
       t.be_company_id,
       t.company_name ar_company_name_y,
       t.company_abbreviation ar_company_abbreviation_y,
       t.social_credit_code ar_social_credit_code_y,
       t.company_province,
       t.company_city,
       t.company_county,
       dp.province || dc.city || dt.county ar_company_area_y,
       t.company_vill ar_company_vill_y,
       dv.vill ar_company_vill_desc_y,
       t.company_address ar_company_address_y,
       t.company_regist_date ar_company_regist_date_y,
       t.pay_term ar_pay_term_n,
       --gdd.group_dict_name ar_pay_term_desc_n,
       t.legal_representative ar_legal_representative_n,
       t.company_contact_phone ar_company_contact_phone_n,
       t.sapply_user ar_sapply_user_y,
       t.sapply_phone ar_sapply_phone_y,
       t.company_type ar_company_type_y,
       gda.group_dict_name ar_company_type_desc_y,
       t.brand_type,
       t.cooperation_brand,
       (SELECT listagg(b.group_dict_name, ';') within GROUP(ORDER BY b.group_dict_value)
          FROM group_dict a
          LEFT JOIN group_dict b
            ON a.group_dict_type = 'COOPERATION_BRAND'
           AND a.group_dict_id = b.parent_id
           AND instr(';' || t.brand_type || ';',
                     ';' || a.group_dict_value || ';') > 0
           AND instr(';' || t.cooperation_brand || ';',
                     ';' || b.group_dict_value || ';') > 0) ar_coop_brand_desc_n,
       t.cooperation_type ar_cooperation_type_y,
       t.cooperation_model ar_cooperation_model_y,     
       --gdb.group_dict_name ar_coop_model_desc_y,
       --因多字段级联问题，需特殊处理
       replace((SELECT listagg(gdb.group_dict_name, ';') within GROUP(ORDER BY gdb.group_dict_value)
          FROM group_dict gdb
         WHERE gdb.group_dict_type = 'SUPPLY_TYPE'
           AND instr(t.cooperation_model, gdb.group_dict_value) > 0),';',' ') ar_coop_model_desc_y,
       t.product_type ar_product_type_y,
       gde.group_dict_name ar_product_type_desc_y,
       t.product_link ar_product_link_n,
       --t.rela_supplier_id ar_rela_supplier_id_y,
       t.is_our_factory ar_is_our_factory_y,
       gdc.group_dict_name ar_is_our_fac_desc_y,
       t.factory_name ar_factory_name_y,
       t.factory_province,
       t.factory_city,
       t.factory_county,
       fdp.province || fdc.city || fdt.county ar_factory_area_y,
       t.factory_vill ar_factory_vill_y,
       fdv.vill ar_factory_vill_desc_y,
       t.factroy_details_address ar_factroy_details_address_y,
        t.factroy_area ar_factroy_area_y,]' || CASE
                     WHEN p_item_id IN ('a_coop_151', 'a_coop_151_1') THEN
                      NULL
                     ELSE
                      't.ask_say ar_ask_say_n,'
                   END || q'[
       t.remarks ar_remarks_n,
       --生产信息
       t.product_line ar_product_line_n,
       t.product_line_num ar_product_line_num_n,
       t.quality_step ar_quality_step_n,
       t.work_hours_day ar_work_hours_day_y,
       nvl(t.worker_total_num, 0) ar_worker_total_num_y,
       nvl(t.worker_num, 0) ar_worker_num_y,
       t.machine_num ar_machine_num_y,
       nvl(t.form_num, 0) ar_form_num_y,
       t.product_efficiency ar_product_efficiency_y,
       nvl(t.pattern_cap, '00') ar_pattern_cap_y,
       nvl(t.fabric_purchase_cap, '00') ar_fabric_purchase_cap_y,
       t.fabric_check_cap ar_fabric_check_cap_n,
       --附件资料
       t.certificate_file  ar_certificate_file_y,
       t.supplier_gate     ar_supplier_gate_n,
       t.supplier_office   ar_supplier_office_n,
       t.supplier_site     ar_supplier_site_n,
       t.supplier_product  ar_supplier_product_n,
       t.other_information ar_other_information_n,
       t.create_id         ar_create_id_n,
       t.create_date       ar_create_date_n
  FROM t_ask_record t
  LEFT JOIN dic_province dp
    ON t.company_province = to_char(dp.provinceid)
  LEFT JOIN dic_city dc
    ON t.company_city = to_char(dc.cityno)
  LEFT JOIN dic_county dt
    ON t.company_county = to_char(dt.countyid)
  LEFT JOIN dic_village dv
    ON dv.countyid = dt.countyid
   AND dv.villid = t.company_vill
  LEFT JOIN dic_province fdp
    ON t.factory_province = to_char(fdp.provinceid)
  LEFT JOIN dic_city fdc
    ON t.factory_city = to_char(fdc.cityno)
  LEFT JOIN dic_county fdt
    ON t.factory_county = to_char(fdt.countyid)
  LEFT JOIN dic_village fdv
    ON fdv.countyid = fdt.countyid
   AND fdv.villid = t.factory_vill
  LEFT JOIN group_dict gd
    ON gd.group_dict_type = 'COOPERATION_BRAND'
   AND gd.group_dict_value = t.cooperation_brand
  LEFT JOIN group_dict gda
    ON gda.group_dict_type = 'COMPANY_TYPE'
   AND gda.group_dict_value = t.company_type
  LEFT JOIN group_dict gdc
    ON gdc.group_dict_type = 'IS_OUR_FACTORY'
   AND gdc.group_dict_value = t.is_our_factory
  /*LEFT JOIN group_dict gdb
    ON gdb.group_dict_type = 'SUPPLY_TYPE'
   AND gdb.group_dict_value = t.cooperation_model
  LEFT JOIN group_dict gdd
    ON gdd.group_dict_type = 'PAY_TERM'
   AND gdd.group_dict_value = t.pay_term*/
  LEFT JOIN group_dict gde
    ON gde.group_dict_type = 'FA_PRODUCT_TYPE'
   AND gde.group_dict_value = t.product_type
       ]' || v_where;
    RETURN v_query_sql;
  END f_query_coop_fp_supplier;

  --PICK
  --合作品牌/客户
  FUNCTION f_query_coop_brand_picksql(p_brand_field_value             VARCHAR2,
                                      p_cooperation_brand_field_value VARCHAR2,
                                      p_brand_field_desc              VARCHAR2,
                                      p_cooperation_brand_field_desc  VARCHAR2)
    RETURN CLOB IS
    v_query_sql CLOB;
  BEGIN
    --BRAND_TYPE,BRAND_TYPE_DESC,COOPERATION_BRAND,COOPERATION_BRAND_DESC
    v_query_sql := 'SELECT t.group_dict_value ' || p_brand_field_value || ',
       t.group_dict_name  ' || p_brand_field_desc || ',
       b.group_dict_value ' ||
                   p_cooperation_brand_field_value || ',
       b.group_dict_name  ' ||
                   p_cooperation_brand_field_desc || '
  FROM scmdata.sys_group_dict t
 INNER JOIN scmdata.sys_group_dict b
    ON t.group_dict_type = ''COOPERATION_BRAND''
   AND t.group_dict_id = b.parent_id
   AND t.pause = 0
   AND b.pause = 0';
    RETURN v_query_sql;
  END f_query_coop_brand_picksql;

  --查询街道pick
  FUNCTION f_query_vill_picksql(p_county     VARCHAR2,
                                p_vill_value VARCHAR2,
                                p_vill_desc  VARCHAR2) RETURN CLOB IS
    v_sql CLOB;
  BEGIN
    v_sql := q'[SELECT a.villid ]' || p_vill_value || q'[, a.vill ]' ||
             p_vill_desc || q'[
      FROM scmdata.dic_village a
     INNER JOIN scmdata.dic_county b
        ON a.countyid = b.countyid
     WHERE a.countyid = ]' || p_county || q'[
       AND a.pause = 0
       AND b.pause = 0]';
    RETURN v_sql;
  END f_query_vill_picksql;

  --按类型查询pick，同时置空其它字段
  FUNCTION f_query_picksql_by_type(p_group_dict_type   VARCHAR2,
                                   p_dict_value        VARCHAR2,
                                   p_dict_desc         VARCHAR2,
                                   p_setnull_fdvalue_1 VARCHAR2 DEFAULT 'fdvalue_1',
                                   p_setnull_fddesc_1  VARCHAR2 DEFAULT 'fddesc_1',
                                   p_setnull_fdvalue_2 VARCHAR2 DEFAULT 'fdvalue_2',
                                   p_setnull_fddesc_2  VARCHAR2 DEFAULT 'fddesc_2',
                                   p_setnull_fdvalue_3 VARCHAR2 DEFAULT 'fdvalue_3',
                                   p_setnull_fddesc_3  VARCHAR2 DEFAULT 'fddesc_3')
    RETURN CLOB IS
    v_sql CLOB;
  BEGIN
    v_sql := q'[SELECT t.group_dict_value ]' || p_dict_value || q'[,
           t.group_dict_name  ]' || p_dict_desc || q'[,
           NULL               ]' || p_setnull_fdvalue_1 || q'[,
           NULL               ]' || p_setnull_fddesc_1 || q'[,
           NULL               ]' || p_setnull_fdvalue_2 || q'[,
           NULL               ]' || p_setnull_fddesc_2 || q'[,
           NULL               ]' || p_setnull_fdvalue_3 || q'[,
           NULL               ]' || p_setnull_fddesc_3 || q'[
      FROM scmdata.sys_group_dict t
     WHERE t.group_dict_type = ']' || p_group_dict_type || q'['
       AND t.pause = 0]';
    RETURN v_sql;
  END f_query_picksql_by_type;
  --CHECK
  --TODO..
  --INSERT
  --新增意向供应商
  PROCEDURE p_insert_t_ask_record(p_ar_rec scmdata.t_ask_record%ROWTYPE) IS
  BEGIN
    INSERT INTO t_ask_record
      (ask_record_id, company_id, be_company_id, company_province,
       company_city, company_county, company_address, ask_date, ask_user_id,
       ask_say, cooperation_type, cooperation_model, certificate_file,
       other_file, company_name, company_abbreviation, social_credit_code,
       cooperation_statement, sapply_user, sapply_phone,
       legal_representative, company_contact_phone, company_type, brand_type,
       cooperation_brand, product_link, supplier_gate, supplier_office,
       supplier_site, supplier_product, coor_ask_flow_status, collection,
       origin, create_id, create_date, update_id, update_date, remarks,
       company_vill, company_regist_date, pay_term, product_type,
       rela_supplier_id, is_our_factory, factory_name, factory_province,
       factory_city, factory_county, factory_vill, factroy_details_address,
       factroy_area, product_line, product_line_num, quality_step,
       work_hours_day, worker_total_num, worker_num, machine_num, form_num,
       product_efficiency, pattern_cap, fabric_purchase_cap,
       fabric_check_cap, other_information)
    VALUES
      (p_ar_rec.ask_record_id, p_ar_rec.company_id, p_ar_rec.be_company_id,
       p_ar_rec.company_province, p_ar_rec.company_city,
       p_ar_rec.company_county, p_ar_rec.company_address, p_ar_rec.ask_date,
       p_ar_rec.ask_user_id, p_ar_rec.ask_say, p_ar_rec.cooperation_type,
       p_ar_rec.cooperation_model, p_ar_rec.certificate_file,
       p_ar_rec.other_file, p_ar_rec.company_name,
       p_ar_rec.company_abbreviation, p_ar_rec.social_credit_code,
       p_ar_rec.cooperation_statement, p_ar_rec.sapply_user,
       p_ar_rec.sapply_phone, p_ar_rec.legal_representative,
       p_ar_rec.company_contact_phone, p_ar_rec.company_type,
       p_ar_rec.brand_type, p_ar_rec.cooperation_brand,
       p_ar_rec.product_link, p_ar_rec.supplier_gate,
       p_ar_rec.supplier_office, p_ar_rec.supplier_site,
       p_ar_rec.supplier_product, p_ar_rec.coor_ask_flow_status,
       p_ar_rec.collection, p_ar_rec.origin, p_ar_rec.create_id,
       p_ar_rec.create_date, p_ar_rec.update_id, p_ar_rec.update_date,
       p_ar_rec.remarks, p_ar_rec.company_vill, p_ar_rec.company_regist_date,
       p_ar_rec.pay_term, p_ar_rec.product_type, p_ar_rec.rela_supplier_id,
       p_ar_rec.is_our_factory, p_ar_rec.factory_name,
       p_ar_rec.factory_province, p_ar_rec.factory_city,
       p_ar_rec.factory_county, p_ar_rec.factory_vill,
       p_ar_rec.factroy_details_address, p_ar_rec.factroy_area,
       p_ar_rec.product_line, p_ar_rec.product_line_num,
       p_ar_rec.quality_step, p_ar_rec.work_hours_day,
       p_ar_rec.worker_total_num, p_ar_rec.worker_num, p_ar_rec.machine_num,
       p_ar_rec.form_num, p_ar_rec.product_efficiency, p_ar_rec.pattern_cap,
       p_ar_rec.fabric_purchase_cap, p_ar_rec.fabric_check_cap,
       p_ar_rec.other_information);
  EXCEPTION
    WHEN OTHERS THEN
      ROLLBACK;
      sys_raise_app_error_pkg.is_running_error(p_is_running_error => 'T',
                                               p_is_log           => 1);
  END p_insert_t_ask_record;

  --UPDATE
  --修改意向供应商
  PROCEDURE p_update_t_ask_record(p_ar_rec scmdata.t_ask_record%ROWTYPE) IS
  BEGIN
  
    UPDATE t_ask_record t
       SET t.company_province        = p_ar_rec.company_province,
           t.company_city            = p_ar_rec.company_city,
           t.company_county          = p_ar_rec.company_county,
           t.company_address         = p_ar_rec.company_address,
           t.ask_say                 = p_ar_rec.ask_say,
           t.cooperation_type        = p_ar_rec.cooperation_type,
           t.cooperation_model       = p_ar_rec.cooperation_model,
           t.certificate_file        = p_ar_rec.certificate_file,
           t.company_name            = p_ar_rec.company_name,
           t.company_abbreviation    = p_ar_rec.company_abbreviation,
           t.social_credit_code      = p_ar_rec.social_credit_code,
           t.cooperation_statement   = p_ar_rec.cooperation_statement,
           t.sapply_user             = p_ar_rec.sapply_user,
           t.sapply_phone            = p_ar_rec.sapply_phone,
           t.legal_representative    = p_ar_rec.legal_representative,
           t.company_contact_phone   = p_ar_rec.company_contact_phone,
           t.company_type            = p_ar_rec.company_type,
           t.brand_type              = p_ar_rec.brand_type,
           t.cooperation_brand       = p_ar_rec.cooperation_brand,
           t.product_link            = p_ar_rec.product_link,
           t.supplier_gate           = p_ar_rec.supplier_gate,
           t.supplier_office         = p_ar_rec.supplier_office,
           t.supplier_site           = p_ar_rec.supplier_site,
           t.supplier_product        = p_ar_rec.supplier_product,
           t.update_id               = p_ar_rec.update_id,
           t.update_date             = p_ar_rec.update_date,
           t.remarks                 = p_ar_rec.remarks,
           t.company_vill            = p_ar_rec.company_vill,
           t.company_regist_date     = p_ar_rec.company_regist_date,
           t.pay_term                = p_ar_rec.pay_term,
           t.product_type            = p_ar_rec.product_type,
           t.rela_supplier_id        = p_ar_rec.rela_supplier_id,
           t.is_our_factory          = p_ar_rec.is_our_factory,
           t.factory_name            = p_ar_rec.factory_name,
           t.factory_province        = p_ar_rec.factory_province,
           t.factory_city            = p_ar_rec.factory_city,
           t.factory_county          = p_ar_rec.factory_county,
           t.factory_vill            = p_ar_rec.factory_vill,
           t.factroy_details_address = p_ar_rec.factroy_details_address,
           t.factroy_area            = p_ar_rec.factroy_area,
           t.product_line            = p_ar_rec.product_line,
           t.product_line_num        = p_ar_rec.product_line_num,
           t.quality_step            = p_ar_rec.quality_step,
           t.work_hours_day          = p_ar_rec.work_hours_day,
           t.worker_total_num        = p_ar_rec.worker_total_num,
           t.worker_num              = p_ar_rec.worker_num,
           t.machine_num             = p_ar_rec.machine_num,
           t.form_num                = p_ar_rec.form_num,
           t.product_efficiency      = p_ar_rec.product_efficiency,
           t.pattern_cap             = p_ar_rec.pattern_cap,
           t.fabric_purchase_cap     = p_ar_rec.fabric_purchase_cap,
           t.fabric_check_cap        = p_ar_rec.fabric_check_cap,
           t.other_information       = p_ar_rec.other_information
     WHERE t.ask_record_id = p_ar_rec.ask_record_id;
  
  EXCEPTION
    WHEN OTHERS THEN
      ROLLBACK;
      sys_raise_app_error_pkg.is_running_error(p_is_running_error => 'T',
                                               p_is_log           => 1);
  END p_update_t_ask_record;

  --DELETE
  PROCEDURE p_delete_t_ask_record(p_ask_record_id VARCHAR2) IS
    v_judge NUMBER(1);
  BEGIN
    SELECT COUNT(1)
      INTO v_judge
      FROM scmdata.t_factory_ask
     WHERE ask_record_id = p_ask_record_id;
  
    IF v_judge = 0 THEN
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
    v_judge NUMBER(1);
  BEGIN
  
    SELECT COUNT(1)
      INTO v_judge
      FROM scmdata.t_ask_record
     WHERE be_company_id = p_company_id
       AND company_name = p_company_name
       AND coor_ask_flow_status <> 'CA00';
  
    IF v_judge = 0 THEN
      SELECT COUNT(1)
        INTO v_judge
        FROM (SELECT DISTINCT first_value(company_name) over(PARTITION BY ask_record_id ORDER BY create_date DESC) company_name
                FROM scmdata.t_factory_ask
               WHERE factrory_ask_flow_status NOT IN
                     ('CA01', 'FA01', 'FA03', 'FA21', 'FA33')
                 AND company_id = p_company_id)
       WHERE company_name = p_company_name;
    
      IF v_judge = 0 THEN
        SELECT COUNT(1)
          INTO v_judge
          FROM scmdata.t_supplier_info
         WHERE company_id = p_company_id
           AND supplier_company_name = p_company_name;
      
        IF v_judge > 0 THEN
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
    IF p_type = 0 THEN
      --已提交的申请不能重新修改
      p_check_ask_flow_status(p_ask_record_id => p_ar_rec.ask_record_id);
    ELSIF p_type = 1 THEN
      --除成品供应商外，其余合作类型未开放
      IF p_ar_rec.cooperation_type <> 'PRODUCT_TYPE' THEN
        raise_application_error(-20002,
                                '除成品供应商外，其余合作类型未开放！');
      END IF;
      --公司所在区域必填
      IF p_ar_rec.company_province IS NULL OR p_ar_rec.company_city IS NULL OR
         p_ar_rec.company_county IS NULL THEN
        raise_application_error(-20002, '公司所在区域必填！');
      END IF;
      --意向合作模式必填
      IF p_ar_rec.cooperation_model IS NULL THEN
        raise_application_error(-20002, '意向合作模式必填！');
      ELSE
        IF p_ar_rec.cooperation_model <> 'OF' AND
           (p_ar_rec.pay_term IS NULL OR instr(p_ar_rec.pay_term, ' ') > 0) THEN
          raise_application_error(-20002,
                                  '“合作模式” 不等于外协工厂时，“付款条件”为必填项！');
        END IF;
      END IF;
      --企业证照必填校验
      IF p_ar_rec.certificate_file IS NULL THEN
        raise_application_error(-20002, '企业证照必填！');
      END IF;
      --校验流程字段在流程中是否重复
      p_check_flow_fields_is_repeat(p_company_id     => p_ar_rec.be_company_id,
                                    p_object_id      => p_ar_rec.ask_record_id,
                                    p_flow_field     => 'COMPANY_NAME;COMPANY_ABBREVIATION;SOCIAL_CREDIT_CODE',
                                    p_flow_field_val => p_ar_rec.company_name || ';' ||
                                                        p_ar_rec.company_abbreviation || ';' ||
                                                        p_ar_rec.social_credit_code,
                                    p_type           => 1);
    ELSE
      raise_application_error(-20002, '无此校验类型，请联系管理员！');
    END IF;
  END p_check_data_by_save;

  --2.验厂申请
  --获取验厂申请人所在组织架构的三级部门
  FUNCTION f_get_check_third_dept_id(p_company_id VARCHAR2,
                                     p_user_id    VARCHAR2) RETURN VARCHAR2 IS
    v_last_dept_id  VARCHAR2(32);
    v_third_dept_id VARCHAR2(32);
  BEGIN
    SELECT MAX(b.company_dept_id)
      INTO v_last_dept_id
      FROM scmdata.sys_company_user a
     INNER JOIN scmdata.sys_company_user_dept b
        ON b.user_id = a.user_id
       AND b.company_id = a.company_id
     INNER JOIN scmdata.sys_company_dept c
        ON c.company_dept_id = b.company_dept_id
       AND c.company_id = b.company_id
     WHERE a.user_id = p_user_id
       AND a.company_id = p_company_id;
  
    SELECT nvl(MAX(va.company_dept_id), v_last_dept_id) third_dept_id
      INTO v_third_dept_id
      FROM (SELECT row_number() over(ORDER BY v.dept_level DESC) rn,
                   v.company_dept_id,
                   v.dept_name
              FROM (SELECT c.company_dept_id,
                           c.company_id,
                           c.dept_name,
                           LEVEL dept_level
                      FROM scmdata.sys_company_dept c
                     WHERE c.company_id = p_company_id
                     START WITH c.company_dept_id = v_last_dept_id
                    CONNECT BY c.company_dept_id = PRIOR c.parent_id) v) va
     WHERE va.rn = 3;
    RETURN v_third_dept_id;
  END f_get_check_third_dept_id;
  --申请验厂
  PROCEDURE p_generate_factory_ask(p_ask_record_id VARCHAR2,
                                   p_company_id    VARCHAR2,
                                   p_user_id       VARCHAR2) IS
    v_judge         NUMBER(1);
    v_tmp           NUMBER(5);
    p_fa_rec        scmdata.t_factory_ask%ROWTYPE;
    v_fs_id         VARCHAR2(32);
    v_ask_record_id VARCHAR2(32) := p_ask_record_id;
  
  BEGIN
    --除 CA01/FA01/FA02 外，都不能点击，点击报错
    SELECT COUNT(1)
      INTO v_judge
      FROM (SELECT status_af_oper
              FROM (SELECT status_af_oper
                      FROM scmdata.t_factory_ask_oper_log
                     WHERE ask_record_id = v_ask_record_id
                     ORDER BY oper_time DESC)
             WHERE rownum < 2)
     WHERE status_af_oper IN ('CA01', 'FA01', 'FA03', 'FA21', 'FA33');
  
    IF v_judge = 0 THEN
      raise_application_error(-20002,
                              '已有单据在流程中或该供应商已准入通过，请勿重复申请！');
    ELSE
      --待验厂单据唯一判定
      SELECT COUNT(factory_ask_id)
        INTO v_judge
        FROM scmdata.t_factory_ask
       WHERE ask_record_id = v_ask_record_id
         AND factrory_ask_flow_status = 'CA01';
    
      IF v_judge = 0 THEN
        --是否处于可再次申请验厂的范围
        SELECT COUNT(factrory_ask_flow_status)
          INTO v_tmp
          FROM scmdata.t_factory_ask
         WHERE ask_record_id = v_ask_record_id;
      
        SELECT COUNT(factrory_ask_flow_status)
          INTO v_judge
          FROM scmdata.t_factory_ask
         WHERE ask_record_id = v_ask_record_id
           AND factrory_ask_flow_status IN ('FA03', 'FA21', 'FA33');
      
        IF v_tmp = 0 OR v_judge > 0 THEN
          --流程中是否有单据判定
          SELECT COUNT(factrory_ask_flow_status)
            INTO v_judge
            FROM (SELECT *
                    FROM (SELECT factrory_ask_flow_status
                            FROM scmdata.t_factory_ask
                           WHERE ask_record_id = v_ask_record_id
                           ORDER BY create_date DESC)
                   WHERE rownum < 3)
           WHERE factrory_ask_flow_status NOT IN
                 ('CA01', 'FA03', 'FA21', 'FA33')
             AND rownum < 2;
          IF v_judge = 0 THEN
          
            v_fs_id := scmdata.f_getkeyid_plat('CA', 'seq_ca');
            DECLARE
              p_ask_rec scmdata.t_ask_record%ROWTYPE;
            BEGIN
              SELECT *
                INTO p_ask_rec
                FROM scmdata.t_ask_record t
               WHERE t.ask_record_id = v_ask_record_id;
            
              p_fa_rec.factory_ask_id := v_fs_id;
              p_fa_rec.company_id     := p_company_id;
              --申请信息
              p_fa_rec.ask_user_id       := p_user_id;
              p_fa_rec.ask_user_dept_id  := f_get_check_third_dept_id(p_company_id => p_company_id,
                                                                      p_user_id    => p_user_id);
              p_fa_rec.ask_company_id    := p_company_id;
              p_fa_rec.ask_date          := SYSDATE;
              p_fa_rec.is_urgent         := 0;
              p_fa_rec.cooperation_type  := 'PRODUCT_TYPE';
              p_fa_rec.cooperation_model := p_ask_rec.cooperation_model;
              p_fa_rec.product_type      := p_ask_rec.product_type;
              p_fa_rec.pay_term          := p_ask_rec.pay_term;
              p_fa_rec.ask_say           := nvl(p_ask_rec.ask_say, ' ');
              --基本信息
              p_fa_rec.company_name          := p_ask_rec.company_name;
              p_fa_rec.company_abbreviation  := p_ask_rec.company_abbreviation;
              p_fa_rec.social_credit_code    := p_ask_rec.social_credit_code;
              p_fa_rec.company_province      := p_ask_rec.company_province;
              p_fa_rec.company_city          := p_ask_rec.company_city;
              p_fa_rec.company_county        := p_ask_rec.company_county;
              p_fa_rec.company_vill          := p_ask_rec.company_vill;
              p_fa_rec.company_address       := p_ask_rec.company_address;
              p_fa_rec.company_regist_date   := p_ask_rec.company_regist_date;
              p_fa_rec.legal_representative  := p_ask_rec.legal_representative;
              p_fa_rec.company_contact_phone := p_ask_rec.company_contact_phone;
              p_fa_rec.contact_name          := p_ask_rec.sapply_user;
              p_fa_rec.contact_phone         := p_ask_rec.sapply_phone;
              p_fa_rec.company_type          := p_ask_rec.company_type;
              p_fa_rec.brand_type            := p_ask_rec.brand_type;
              p_fa_rec.cooperation_brand     := p_ask_rec.cooperation_brand;
              p_fa_rec.product_link          := p_ask_rec.product_link;
              p_fa_rec.rela_supplier_id      := p_ask_rec.rela_supplier_id;
              p_fa_rec.is_our_factory        := p_ask_rec.is_our_factory;
              p_fa_rec.factory_name          := p_ask_rec.factory_name;
              p_fa_rec.factory_province      := p_ask_rec.factory_province;
              p_fa_rec.factory_city          := p_ask_rec.factory_city;
              p_fa_rec.factory_county        := p_ask_rec.factory_county;
              p_fa_rec.factory_vill          := p_ask_rec.factory_vill;
              p_fa_rec.ask_address           := p_ask_rec.factroy_details_address;
              p_fa_rec.factroy_area          := p_ask_rec.factroy_area;
              p_fa_rec.remarks               := p_ask_rec.remarks;
              --生产信息
              p_fa_rec.product_line        := p_ask_rec.product_line;
              p_fa_rec.product_line_num    := p_ask_rec.product_line_num;
              p_fa_rec.quality_step        := p_ask_rec.quality_step;
              p_fa_rec.work_hours_day      := p_ask_rec.work_hours_day;
              p_fa_rec.worker_total_num    := p_ask_rec.worker_total_num;
              p_fa_rec.worker_num          := p_ask_rec.worker_num;
              p_fa_rec.machine_num         := p_ask_rec.machine_num;
              p_fa_rec.form_num            := p_ask_rec.form_num;
              p_fa_rec.product_efficiency  := p_ask_rec.product_efficiency;
              p_fa_rec.pattern_cap         := p_ask_rec.pattern_cap;
              p_fa_rec.fabric_purchase_cap := p_ask_rec.fabric_purchase_cap;
              p_fa_rec.fabric_check_cap    := p_ask_rec.fabric_check_cap;
              --附件资料
              p_fa_rec.certificate_file := p_ask_rec.certificate_file;
              p_fa_rec.supplier_gate    := p_ask_rec.supplier_gate;
              p_fa_rec.supplier_office  := p_ask_rec.supplier_office;
              p_fa_rec.supplier_site    := p_ask_rec.supplier_site;
              p_fa_rec.supplier_product := p_ask_rec.supplier_product;
              p_fa_rec.ask_files        := p_ask_rec.other_information;
              --其他
              p_fa_rec.origin                   := 'CA';
              p_fa_rec.create_id                := p_user_id;
              p_fa_rec.create_date              := SYSDATE;
              p_fa_rec.update_id                := p_user_id;
              p_fa_rec.update_date              := SYSDATE;
              p_fa_rec.memo                     := p_ask_rec.remarks;
              p_fa_rec.ask_record_id            := p_ask_rec.ask_record_id;
              p_fa_rec.factory_ask_type         := NULL;
              p_fa_rec.factrory_ask_flow_status := 'CA01';
            
              --v9.10 作废字段
              /*  p_fa_rec.cooperation_company_id := p_ask_rec.cooperation_company_id;
              p_fa_rec.cooperation_method := p_ask_rec.cooperation_method;
              p_fa_rec.company_mold       := p_ask_rec.company_mold;
              p_fa_rec.ask_address        := p_ask_rec.ask_address;
              p_fa_rec.ask_files          := p_ask_rec.ask_files;
              p_fa_rec.com_manufacturer := p_ask_rec.com_manufacturer;*/
            
              --新增验厂申请单（供应商）
              p_insert_factory_ask(p_fa_rec => p_fa_rec);
            END insert_factory_ask;
            --新增合作范围
            DECLARE
              p_scope_rec scmdata.t_ask_scope%ROWTYPE;
            BEGIN
              FOR p_ask_row_rec IN (SELECT *
                                      FROM scmdata.t_ask_scope
                                     WHERE object_id = v_ask_record_id) LOOP
              
                p_scope_rec.ask_scope_id               := scmdata.f_get_uuid();
                p_scope_rec.company_id                 := p_company_id;
                p_scope_rec.object_id                  := v_fs_id;
                p_scope_rec.object_type                := 'CA';
                p_scope_rec.cooperation_type           := p_ask_row_rec.cooperation_type;
                p_scope_rec.cooperation_classification := p_ask_row_rec.cooperation_classification;
                p_scope_rec.cooperation_product_cate   := p_ask_row_rec.cooperation_product_cate;
                p_scope_rec.cooperation_subcategory    := p_ask_row_rec.cooperation_subcategory;
                p_scope_rec.be_company_id              := p_ask_row_rec.be_company_id;
                p_scope_rec.update_time                := SYSDATE;
                p_scope_rec.update_id                  := p_user_id;
                p_scope_rec.create_id                  := p_user_id;
                p_scope_rec.create_time                := SYSDATE;
                p_scope_rec.remarks                    := NULL;
                p_scope_rec.pause                      := 0;
              
                scmdata.pkg_ask_record_mange.p_insert_ask_scope(p_scope_rec => p_scope_rec);
              END LOOP;
            END insert_ask_record;
            --人员配置
            --机器配置
            scmdata.pkg_ask_record_mange_a.p_generate_person_machine_config(p_company_id     => p_company_id,
                                                                            p_user_id        => p_user_id,
                                                                            p_factory_ask_id => v_fs_id,
                                                                            p_ask_record_id  => v_ask_record_id);
            --修改合作申请流程状态
            UPDATE scmdata.t_ask_record
               SET coor_ask_flow_status = 'CA01'
             WHERE ask_record_id = v_ask_record_id;
          
            p_update_flow_status_and_logger(p_company_id       => p_company_id,
                                            p_user_id          => p_user_id,
                                            p_fac_ask_id       => v_fs_id, --验厂申请单ID
                                            p_ask_record_id    => v_ask_record_id, --合作申请单ID
                                            p_flow_oper_status => 'ASK_FACTORY', --流程操作方式编码
                                            p_flow_af_status   => 'FA01', --操作后流程状态
                                            p_memo             => NULL);
          
          END IF;
        END IF;
      END IF;
    END IF;
  END p_generate_factory_ask;

  --QUERY P_TYPE : 0 :申请验厂 a_coop_150_3  1：申请详情  a_coop_211  a_coop_221
  FUNCTION f_query_factory_ask(p_item_id VARCHAR2, p_object_id VARCHAR2)
    RETURN CLOB IS
    v_query_sql CLOB;
  BEGIN
    v_query_sql := Q'[ 
WITH group_dict AS
 (SELECT gd.group_dict_type,
         gd.group_dict_value,
         gd.group_dict_name,
         gd.group_dict_id,
         gd.parent_id
    FROM scmdata.sys_group_dict gd
   WHERE gd.pause = 0)
--申请信息
SELECT tfa.ask_user_id fa_check_person_y,
       su.company_user_name fa_check_person_desc_y,
       tfa.ask_user_dept_id fa_check_dept_name_y,
       dp.dept_name fa_dept_name_desc_y,
       tfa.ask_date fa_ask_date_n,
       nvl(tfa.is_urgent,0) fa_is_urgent_n,
       'PRODUCT_TYPE' ar_cooperation_type_y,
       tfa.cooperation_model ar_cooperation_model_y,
       replace((SELECT listagg(DISTINCT gdb.group_dict_name, ';') within GROUP(ORDER BY gdb.group_dict_value)
          FROM group_dict gdb
         WHERE gdb.group_dict_type = 'SUPPLY_TYPE'
           AND instr(';' || tfa.cooperation_model || ';',
                             ';' || gdb.group_dict_value || ';') > 0),';',' ') ar_coop_model_desc_y,
       (SELECT listagg(DISTINCT group_dict_name, ';') within GROUP(ORDER BY group_dict_value)
          FROM scmdata.t_ask_scope t
         INNER JOIN group_dict
            ON group_dict_value = t.cooperation_classification
           AND group_dict_type = t.cooperation_type
         WHERE t.be_company_id = tfa.company_id
           AND t.object_id = tfa.factory_ask_id) ar_coop_class_desc_n,
       tfa.product_type ar_product_type_y,
       tfa.pay_term ar_pay_term_n,
       gde.group_dict_name ar_product_type_desc_y,
       tfa.ask_say fa_ask_say_y,
       --基本信息
       tfa.company_name ar_company_name_y,
       tfa.company_abbreviation ar_company_abbreviation_y,
       tfa.social_credit_code ar_social_credit_code_y,
       tfa.company_province,
       tfa.company_city,
       tfa.company_county,
       dp.province || dc.city || dt.county ar_company_area_y,
       tfa.company_vill ar_company_vill_y,
       dv.vill ar_company_vill_desc_y,
       tfa.company_address ar_company_address_y,
       tfa.company_regist_date ar_company_regist_date_y,
       tfa.legal_representative ar_legal_representative_n,
       tfa.company_contact_phone ar_company_contact_phone_n,
       tfa.contact_name ar_sapply_user_y,
       tfa.contact_phone ar_sapply_phone_y,
       tfa.company_type ar_company_type_y,
       gda.group_dict_name ar_company_type_desc_y,
       tfa.brand_type,
       tfa.cooperation_brand,
       (SELECT listagg(b.group_dict_name, ';') within GROUP(ORDER BY b.group_dict_value)
          FROM group_dict a
          LEFT JOIN group_dict b
            ON a.group_dict_type = 'COOPERATION_BRAND'
           AND a.group_dict_id = b.parent_id
           AND instr(';' || tfa.brand_type || ';',
                     ';' || a.group_dict_value || ';') > 0
           AND instr(';' || tfa.cooperation_brand || ';',
                     ';' || b.group_dict_value || ';') > 0) ar_coop_brand_desc_n,       
       tfa.product_link ar_product_link_n,
       tfa.rela_supplier_id ar_rela_supplier_id_n,
       tfa.is_our_factory ar_is_our_factory_y,
       gdc.group_dict_name ar_is_our_fac_desc_y,
       tfa.factory_name ar_factory_name_y,
       tfa.factory_province,
       tfa.factory_city,
       tfa.factory_county,
       fdp.province || fdc.city || fdt.county ar_factory_area_y,
       tfa.factory_vill ar_factory_vill_y,
       fdv.vill ar_factory_vill_desc_y,
       tfa.ask_address ar_factroy_details_address_y,
       tfa.factroy_area ar_factroy_area_y,
       tfa.remarks ar_remarks_n,
       --生产信息
       tfa.product_line ar_product_line_n,
       tfa.product_line_num ar_product_line_num_n,
       tfa.quality_step ar_quality_step_n,
       tfa.work_hours_day ar_work_hours_day_y,
       nvl(tfa.worker_total_num, 0) ar_worker_total_num_y,
       nvl(tfa.worker_num, 0) ar_worker_num_y,
       tfa.machine_num ar_machine_num_y,
       nvl(tfa.form_num, 0) ar_form_num_y,
       tfa.product_efficiency ar_product_efficiency_y,
       nvl(tfa.pattern_cap, '00') ar_pattern_cap_y,
       nvl(tfa.fabric_purchase_cap, '00') ar_fabric_purchase_cap_y,
       tfa.fabric_check_cap ar_fabric_check_cap_n,
       --附件资料
       tfa.certificate_file  ar_certificate_file_y,
       tfa.supplier_gate     ar_supplier_gate_n,
       tfa.supplier_office   ar_supplier_office_n,
       tfa.supplier_site     ar_supplier_site_n,
       tfa.supplier_product  ar_supplier_product_n,
       tfa.ask_files         ar_other_information_n,
       tfa.factory_ask_id,
       tfa.factory_ask_type
  FROM scmdata.t_factory_ask tfa
  LEFT JOIN sys_company_user_dept udp
    ON udp.user_id = tfa.ask_user_id
   AND udp.company_id = tfa.company_id
  LEFT JOIN scmdata.sys_company_dept dp
    ON dp.company_dept_id = udp.company_dept_id
   AND dp.company_id = udp.company_id
  LEFT JOIN scmdata.sys_company_user su
    ON su.user_id = tfa.ask_user_id
   AND su.company_id = tfa.company_id
  LEFT JOIN dic_province dp
    ON tfa.company_province = to_char(dp.provinceid)
  LEFT JOIN dic_city dc
    ON tfa.company_city = to_char(dc.cityno)
  LEFT JOIN dic_county dt
    ON tfa.company_county = to_char(dt.countyid)
  LEFT JOIN dic_village dv
    ON dv.countyid = dt.countyid
   AND dv.villid = tfa.company_vill
  LEFT JOIN dic_province fdp
    ON tfa.factory_province = to_char(fdp.provinceid)
  LEFT JOIN dic_city fdc
    ON tfa.factory_city = to_char(fdc.cityno)
  LEFT JOIN dic_county fdt
    ON tfa.factory_county = to_char(fdt.countyid)
  LEFT JOIN dic_village fdv
    ON fdv.countyid = fdt.countyid
   AND fdv.villid = tfa.factory_vill
  LEFT JOIN group_dict gd
    ON gd.group_dict_type = 'COOPERATION_BRAND'
   AND gd.group_dict_value = tfa.cooperation_brand
  LEFT JOIN group_dict gda
    ON gda.group_dict_type = 'COMPANY_TYPE'
   AND gda.group_dict_value = tfa.company_type
  LEFT JOIN group_dict gdc
    ON gdc.group_dict_type = 'IS_OUR_FACTORY'
   AND gdc.group_dict_value = to_char(tfa.is_our_factory)
  LEFT JOIN group_dict gde
    ON gde.group_dict_type = 'FA_PRODUCT_TYPE'
   AND gde.group_dict_value = tfa.product_type ]' || CASE
                     WHEN p_item_id IN ('a_coop_211', 'a_coop_221') THEN
                      q'[ WHERE tfa.factory_ask_id = ']' || p_object_id ||
                      q'[']'
                     ELSE
                      q'[ WHERE tfa.ask_record_id = ']' || p_object_id || q'['
     ORDER BY tfa.create_date DESC]'
                   END;
    v_query_sql := 'SELECT * FROM (' || v_query_sql ||
                   ') WHERE ROWNUM <= 1';
    RETURN v_query_sql;
  END f_query_factory_ask;

  --验厂申请  意向合作清单
  FUNCTION f_query_coop_supp_list(p_data_privs VARCHAR2) RETURN CLOB IS
    v_query_sql CLOB;
  BEGIN
    v_query_sql := q'[
WITH dic AS
 (SELECT group_dict_name, group_dict_value, group_dict_type
    FROM scmdata.sys_group_dict)
SELECT v.company_name ar_company_name_n,
       v.company_abbreviation ar_company_abbreviation_n,
       v.status_af_oper,
       v.coor_ask_flow_status,
       /*substr(v.coor_ask_flow_status,
              1,
              instr(v.coor_ask_flow_status, '+') - 1) flow_node_name,*/
       substr(v.coor_ask_flow_status,
              instr(v.coor_ask_flow_status, '+') + 1,
              length(v.coor_ask_flow_status)) ar_coor_ask_flow_status_n,
       decode(v.is_cooperation, 1, '是', 0, '否') ar_is_cooperation_n,
       v.coop_classification_desc ar_coop_class_desc_n,
       v.cooperation_model_desc ar_coop_model_desc_n,
       v.company_address ar_company_address_n,
       v.sapply_user ar_sapply_user_n,
       v.sapply_phone ar_sapply_phone_n,
       v.company_user_name create_id_n,
       v.create_date create_date_n,
       v.ask_record_id
  FROM (SELECT a.company_name,
               a.company_abbreviation,
               tfv.status_af_oper,
               gda.group_dict_name coor_ask_flow_status,
               (CASE WHEN nvl(sp.status, 0) = 0 OR sp.pause = 1 THEN
                     0
                ELSE
                     1
                END) is_cooperation,
               (SELECT listagg(y.group_dict_name, ';')
                  FROM (SELECT DISTINCT cooperation_classification tmp
                          FROM scmdata.t_ask_scope
                         WHERE object_id = a.ask_record_id
                           AND company_id = decode(a.origin,
                                                   'MA',
                                                   a.be_company_id,
                                                   a.company_id)) z
                 INNER JOIN dic y
                    ON z.tmp = y.group_dict_value
                   AND y.group_dict_type = 'PRODUCT_TYPE') coop_classification_desc,
               a.cooperation_model,
               (SELECT listagg(group_dict_name, ';') within GROUP(ORDER BY group_dict_value)
                  FROM dic
                 WHERE group_dict_type = 'SUPPLY_TYPE'
                   AND instr(';' || a.cooperation_model || ';',
                             ';' || group_dict_value || ';') > 0) cooperation_model_desc,
               a.company_address,
               a.sapply_user,
               a.sapply_phone,
               su.company_user_name,
               a.create_date,
               c.cooperation_classification cate,
               a.ask_record_id
          FROM scmdata.t_ask_record a
          LEFT JOIN scmdata.t_supplier_info sp
            ON sp.social_credit_code = a.social_credit_code
           AND sp.company_id =
               decode(a.origin, 'MA', a.be_company_id, a.company_id)
          LEFT JOIN scmdata.sys_company_user su
            ON su.company_id =
               decode(a.origin, 'MA', a.be_company_id, a.company_id)
           AND su.user_id = a.create_id
          LEFT JOIN (SELECT object_id,
                           company_id,
                           listagg(cooperation_classification, ';') within GROUP(ORDER BY 1) cooperation_classification
                      FROM scmdata.t_ask_scope
                     GROUP BY object_id, company_id) c
            ON c.object_id = a.ask_record_id
           AND c.company_id =
               decode(a.origin, 'MA', a.be_company_id, a.company_id)
          LEFT JOIN (SELECT tf.status_af_oper,
                           tf.ask_record_id,
                           row_number() over(PARTITION BY tf.ask_record_id ORDER BY tf.oper_time DESC) rn
                      FROM scmdata.t_factory_ask_oper_log tf) tfv
            ON tfv.ask_record_id = a.ask_record_id
           AND tfv.rn = 1
          LEFT JOIN dic gda
            ON gda.group_dict_type = 'FACTORY_ASK_FLOW'
           AND gda.group_dict_value =
               nvl(tfv.status_af_oper, a.coor_ask_flow_status)
         WHERE a.be_company_id = %default_company_id%
           AND instr('CA03,CA00,', a.coor_ask_flow_status || ',') = 0) v
 WHERE ((%is_company_admin% = 1) OR
       scmdata.instr_priv(p_str1  => ']' || p_data_privs ||
                   q'[',p_str2  => v.cate,
                          p_split => ';') > 0)
 ORDER BY v.create_date DESC, v.ask_record_id DESC
]';
    RETURN v_query_sql;
  END f_query_coop_supp_list;

  --验厂申请 我的申请记录  a_coop_210
  FUNCTION f_query_my_ask_rec RETURN CLOB IS
    v_query_sql CLOB;
  BEGIN
    v_query_sql := Q'[
WITH dic AS
 (SELECT group_dict_value, group_dict_name, group_dict_type
    FROM scmdata.sys_group_dict)
SELECT v.company_name ar_company_name_n,
       v.company_abbreviation ar_company_abbreviation_n,
       /*substr(status, 1, instr(status, '+') - 1) flow_node_name,
       substr(status, instr(status, '+') + 1, length(status)) flow_node_status_desc,*/
       substr(v.coor_ask_flow_status,
              instr(v.coor_ask_flow_status, '+') + 1,
              length(v.coor_ask_flow_status)) ar_coor_ask_flow_status_n,
       v.coop_classification_desc ar_coop_class_desc_n,
       v.cooperation_model_desc ar_coop_model_desc_n,
       v.company_address ar_company_address_n,
       v.company_user_name fa_check_person_n,
       v.dept_name fa_check_dept_name_n,
       v.create_date fa_ask_date_n,
       v.factory_ask_id
  FROM (SELECT fa.factory_ask_id,
               fa.factrory_ask_flow_status,
               fa.ask_date,
               fa.factory_ask_type,
               fa.cooperation_company_id,
               fa.ask_company_id,
               fa.ask_user_id,
               fa.cooperation_type,
               fa.cooperation_model,
               fa.company_name,
               fa.company_abbreviation,
               fa.company_address,
               fa.company_id,
               fa.factory_name,
               fa.ask_address,
               fa.create_date,
               gd.group_dict_name coor_ask_flow_status,
               fa.is_urgent,
               (SELECT listagg(gda.group_dict_name, ';')
                  FROM (SELECT DISTINCT ta.cooperation_classification tmp
                          FROM scmdata.t_ask_scope ta
                         WHERE ta.object_id = fa.ask_record_id
                           AND ta.company_id = fa.company_id) z
                 INNER JOIN dic gda
                    ON z.tmp = gda.group_dict_value
                   AND gda.group_dict_type = 'PRODUCT_TYPE') coop_classification_desc,
               fa.cooperation_model,
               (SELECT listagg(gdb.group_dict_name, ';') within GROUP(ORDER BY gdb.group_dict_value)
                  FROM dic gdb
                 WHERE gdb.group_dict_type = 'SUPPLY_TYPE'
                   AND instr(';' || fa.cooperation_model || ';',
                             ';' || gdb.group_dict_value || ';') > 0) cooperation_model_desc,
               fa.ask_user_id fa_check_person_y,
               su.company_user_name,
               fa.ask_user_dept_id fa_check_dept_name_y,
               dp.dept_name
          FROM scmdata.t_factory_ask fa
          LEFT JOIN dic gd
            ON gd.group_dict_value = fa.factrory_ask_flow_status
           AND gd.group_dict_type = 'FACTORY_ASK_FLOW'
          LEFT JOIN sys_company_user_dept udp
            ON udp.user_id = fa.ask_user_id
           AND udp.company_id = fa.company_id
          LEFT JOIN scmdata.sys_company_dept dp
            ON dp.company_dept_id = udp.company_dept_id
           AND dp.company_id = udp.company_id
          LEFT JOIN scmdata.sys_company_user su
            ON su.user_id = fa.ask_user_id
           AND su.company_id = fa.company_id
         WHERE fa.company_id = %default_company_id%
           AND fa.ask_user_id = %current_userid%
           AND fa.factrory_ask_flow_status <> 'CA01'
         ORDER BY fa.create_date DESC) v
 ORDER BY v.create_date DESC, v.factory_ask_id DESC
]';
  
    RETURN v_query_sql;
  END f_query_my_ask_rec;

  --验厂申请 待审核申请  a_coop_220
  FUNCTION f_query_uncheck_ask_rec RETURN CLOB IS
    v_query_sql CLOB;
  BEGIN
    v_query_sql := Q'[
    WITH dic AS
 (SELECT group_dict_value, group_dict_name, group_dict_type
    FROM scmdata.sys_group_dict)
SELECT v.company_name ar_company_name_n,
       v.company_abbreviation ar_company_abbreviation_n,
       decode(v.is_urgent, 1, '是', '否') is_urgent,
       v.coop_classification_desc ar_coop_class_desc_n,
       v.cooperation_model_desc ar_coop_model_desc_n,
       v.fa_product_type_desc_n,
       v.factory_name fa_factory_name_n,
       v.ask_address fa_factroy_details_address_n,
       v.company_user_name fa_check_person_n,
       v.dept_name fa_check_dept_name_n,
       v.create_date fa_ask_date_n,
       v.factory_ask_id
  FROM (SELECT fa.factory_ask_id,
               fa.factrory_ask_flow_status,
               fa.ask_date,
               fa.factory_ask_type,
               fa.cooperation_company_id,
               fa.ask_company_id,
               fa.ask_user_id,
               fa.cooperation_type,
               fa.cooperation_model,
               fa.company_name,
               fa.company_abbreviation,
               fa.company_address,
               fa.company_id,
               fa.factory_name,
               fa.ask_address,
               fa.create_date,
               gd.group_dict_name status,
               fa.is_urgent,
               (SELECT listagg(gda.group_dict_name, ';')
                  FROM (SELECT DISTINCT ta.cooperation_classification tmp
                          FROM scmdata.t_ask_scope ta
                         WHERE ta.object_id = fa.ask_record_id
                           AND ta.company_id = fa.company_id) z
                 INNER JOIN dic gda
                    ON z.tmp = gda.group_dict_value
                   AND gda.group_dict_type = 'PRODUCT_TYPE') coop_classification_desc,
               fa.cooperation_model,
               (SELECT listagg(gdb.group_dict_name, ';') within GROUP(ORDER BY gdb.group_dict_value)
                  FROM dic gdb
                 WHERE gdb.group_dict_type = 'SUPPLY_TYPE'
                   AND instr(';' || fa.cooperation_model || ';',
                             ';' || gdb.group_dict_value || ';') > 0) cooperation_model_desc,
               fa.ask_user_id fa_check_person_y,
               su.company_user_name,
               fa.ask_user_dept_id fa_check_dept_name_y,
               dp.dept_name,
               gde.group_dict_name fa_product_type_desc_n
          FROM scmdata.t_factory_ask fa
          LEFT JOIN dic gd
            ON gd.group_dict_value = fa.factrory_ask_flow_status
           AND gd.group_dict_type = 'FACTORY_ASK_FLOW'
          LEFT JOIN sys_company_user_dept udp
            ON udp.user_id = fa.ask_user_id
           AND udp.company_id = fa.company_id
          LEFT JOIN scmdata.sys_company_dept dp
            ON dp.company_dept_id = udp.company_dept_id
           AND dp.company_id = udp.company_id
          LEFT JOIN scmdata.sys_company_user su
            ON su.user_id = fa.ask_user_id
           AND su.company_id = fa.company_id
          LEFT JOIN dic gde
           ON gde.group_dict_type = 'FA_PRODUCT_TYPE'
          AND gde.group_dict_value = fa.product_type 
         WHERE fa.company_id = %default_company_id%
           --AND fa.ask_user_id = %current_userid%
           AND fa.factrory_ask_flow_status = 'FA02'
         ORDER BY fa.create_date DESC) v
 ORDER BY v.is_urgent DESC, v.create_date DESC, v.factory_ask_id DESC
]';
    RETURN v_query_sql;
  END f_query_uncheck_ask_rec;

  --验厂申请 已审核申请 a_coop_230
  FUNCTION f_query_checked_ask_rec RETURN CLOB IS
    v_query_sql CLOB;
  BEGIN
    v_query_sql := Q'[ 
WITH dic AS
 (SELECT group_dict_value, group_dict_name, group_dict_type
    FROM scmdata.sys_group_dict)
SELECT v.company_name ar_company_name_n,
       v.company_abbreviation ar_company_abbreviation_n,
      /*substr(status, 1, instr(status, '+') - 1) flow_node_name,
       substr(status, instr(status, '+') + 1, length(status)) flow_node_status_desc,*/
       substr(v.coor_ask_flow_status,
              instr(v.coor_ask_flow_status, '+') + 1,
              length(v.coor_ask_flow_status)) ar_coor_ask_flow_status_n,
       v.factory_ask_type,
       v.coop_classification_desc ar_coop_class_desc_n,
       v.cooperation_model_desc ar_coop_model_desc_n,
       v.factory_name fa_factory_name_n,
       v.ask_address fa_factroy_details_address_n,
       v.company_user_name fa_check_person_n,
       v.dept_name fa_check_dept_name_n,
       v.create_date fa_ask_date_n,
       v.audit_time fa_audit_time_n,
       v.factory_ask_id
  FROM (SELECT fa.factory_ask_id,
               fa.factrory_ask_flow_status,
               fa.ask_date,
               fa.factory_ask_type,
               fa.cooperation_company_id,
               fa.ask_company_id,
               fa.ask_user_id,
               fa.cooperation_type,
               fa.cooperation_model,
               fa.company_name,
               fa.company_abbreviation,
               fa.company_address,
               fa.company_id,
               fa.factory_name,
               fa.ask_address,
               fa.create_date,
               gd.group_dict_name coor_ask_flow_status,
               fa.is_urgent,
               (SELECT listagg(gda.group_dict_name, ';')
                  FROM (SELECT DISTINCT ta.cooperation_classification tmp
                          FROM scmdata.t_ask_scope ta
                         WHERE ta.object_id = fa.ask_record_id
                           AND ta.company_id = fa.company_id) z
                 INNER JOIN dic gda
                    ON z.tmp = gda.group_dict_value
                   AND gda.group_dict_type = 'PRODUCT_TYPE') coop_classification_desc,
               fa.cooperation_model,
               (SELECT listagg(gdb.group_dict_name, ';') within GROUP(ORDER BY gdb.group_dict_value)
                  FROM dic gdb
                 WHERE gdb.group_dict_type = 'SUPPLY_TYPE'
                   AND instr(';' || fa.cooperation_model || ';',
                             ';' || gdb.group_dict_value || ';') > 0) cooperation_model_desc,
               fa.ask_user_id fa_check_person_y,
               su.company_user_name,
               fa.ask_user_dept_id fa_check_dept_name_y,
               dp.dept_name,
               gv.audit_time,
               fa.ask_record_id
          FROM scmdata.t_factory_ask fa
          LEFT JOIN dic gd
            ON gd.group_dict_value = fa.factrory_ask_flow_status
           AND gd.group_dict_type = 'FACTORY_ASK_FLOW'
          LEFT JOIN sys_company_user_dept udp
            ON udp.user_id = fa.ask_user_id
           AND udp.company_id = fa.company_id
          LEFT JOIN scmdata.sys_company_dept dp
            ON dp.company_dept_id = udp.company_dept_id
           AND dp.company_id = udp.company_id
          LEFT JOIN scmdata.sys_company_user su
            ON su.user_id = fa.ask_user_id
           AND su.company_id = fa.company_id
         INNER JOIN (SELECT ol.oper_time audit_time,ol.factory_ask_id,
                     row_number() over(PARTITION BY ol.ask_record_id ORDER BY ol.oper_time DESC) rn
                      FROM t_factory_ask_oper_log ol
                     WHERE ol.status_af_oper IN ('FA03', 'FA11', 'FA12')
                        OR (ol.status_af_oper = 'FA01' AND
                           ol.oper_code IN ('BACK'))) gv
            ON gv.factory_ask_id = fa.factory_ask_id
           AND gv.rn = 1
         WHERE fa.company_id = %default_company_id%
           --AND fa.ask_user_id = %current_userid%
           AND (fa.factrory_ask_flow_status LIKE 'FA%' OR
               fa.factrory_ask_flow_status = 'SP_01')
           AND fa.factrory_ask_flow_status <> 'FA02'
         ORDER BY fa.create_date DESC) v
 ORDER BY v.audit_time DESC, v.factory_ask_id DESC
]';
    RETURN v_query_sql;
  END f_query_checked_ask_rec;
  --PICK_LIST
  --验厂申请人
  FUNCTION f_query_check_person_picksql RETURN CLOB IS
    v_sql CLOB;
  BEGIN
    v_sql := q'[SELECT su.user_id           fa_check_person_y,
         su.company_user_name fa_check_person_desc_y,
         NULL                 fa_check_dept_name_y,
         NULL                 fa_dept_name_desc_y
    FROM scmdata.sys_company_user su
   WHERE su.company_id = %default_company_id%
     AND su.pause = 0]';
    RETURN v_sql;
  END f_query_check_person_picksql;
  --验厂部门
  FUNCTION f_query_check_dept_name_picksql(p_company_id VARCHAR2,
                                           p_user_id    VARCHAR2) RETURN CLOB IS
    v_sql            CLOB;
    v_last_dept_id   VARCHAR2(32);
    v_last_dept_name VARCHAR2(256);
  BEGIN
    SELECT MAX(b.company_dept_id), MAX(c.dept_name)
      INTO v_last_dept_id, v_last_dept_name
      FROM scmdata.sys_company_user a
     INNER JOIN scmdata.sys_company_user_dept b
        ON b.user_id = a.user_id
       AND b.company_id = a.company_id
     INNER JOIN scmdata.sys_company_dept c
        ON c.company_dept_id = b.company_dept_id
       AND c.company_id = b.company_id
     WHERE a.user_id = p_user_id
       AND a.company_id = p_company_id;
  
    v_sql := q'[SELECT nvl(MAX(va.company_dept_id), ']' || v_last_dept_id ||
             q'[') fa_check_dept_name_y,
           nvl(max(va.dept_name),']' || v_last_dept_name ||
             q'[') fa_dept_name_desc_y
      FROM (SELECT row_number() over(ORDER BY v.dept_level DESC) rn,
                   v.company_dept_id,
                   v.dept_name
              FROM (SELECT c.company_dept_id,
                           c.company_id,
                           c.dept_name,
                           LEVEL dept_level
                      FROM scmdata.sys_company_dept c
                     WHERE c.company_id = ']' || p_company_id || q'['
                     START WITH c.company_dept_id = ']' ||
             v_last_dept_id || q'['
                    CONNECT BY c.company_dept_id = PRIOR c.parent_id) v) va
     WHERE va.rn = 3]';
    RETURN v_sql;
  END f_query_check_dept_name_picksql;

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
      (factory_ask_id, company_id, cooperation_company_id, ask_user_id,
       ask_company_id, ask_record_id, ask_user_dept_id, is_urgent,
       company_province, company_city, company_county, contact_name,
       contact_phone, company_type, cooperation_method, cooperation_model,
       cooperation_type, company_name, company_abbreviation, company_address,
       social_credit_code, legal_representative, company_contact_phone,
       company_mold, brand_type, cooperation_brand, product_type,
       product_link, rela_supplier_id, ask_date, ask_address, ask_say,
       ask_files, factory_ask_type, factrory_ask_flow_status, supplier_gate,
       supplier_office, supplier_site, supplier_product, com_manufacturer,
       certificate_file, origin, create_id, create_date, update_id,
       update_date, remarks, factory_name, factory_province, factory_city,
       factory_county, worker_num, machine_num, reserve_capacity,
       product_efficiency, work_hours_day, memo, company_vill, factory_vill,
       pay_term, company_regist_date, is_our_factory, factroy_area,
       product_line, product_line_num, quality_step, worker_total_num,
       form_num, pattern_cap, fabric_purchase_cap, fabric_check_cap)
    VALUES
      (p_fa_rec.factory_ask_id, p_fa_rec.company_id,
       p_fa_rec.cooperation_company_id, p_fa_rec.ask_user_id,
       p_fa_rec.ask_company_id, p_fa_rec.ask_record_id,
       p_fa_rec.ask_user_dept_id, p_fa_rec.is_urgent,
       p_fa_rec.company_province, p_fa_rec.company_city,
       p_fa_rec.company_county, p_fa_rec.contact_name,
       p_fa_rec.contact_phone, p_fa_rec.company_type,
       p_fa_rec.cooperation_method, p_fa_rec.cooperation_model,
       p_fa_rec.cooperation_type, p_fa_rec.company_name,
       p_fa_rec.company_abbreviation, p_fa_rec.company_address,
       p_fa_rec.social_credit_code, p_fa_rec.legal_representative,
       p_fa_rec.company_contact_phone, p_fa_rec.company_mold,
       p_fa_rec.brand_type, p_fa_rec.cooperation_brand,
       p_fa_rec.product_type, p_fa_rec.product_link,
       p_fa_rec.rela_supplier_id, p_fa_rec.ask_date, p_fa_rec.ask_address,
       p_fa_rec.ask_say, p_fa_rec.ask_files, p_fa_rec.factory_ask_type,
       p_fa_rec.factrory_ask_flow_status, p_fa_rec.supplier_gate,
       p_fa_rec.supplier_office, p_fa_rec.supplier_site,
       p_fa_rec.supplier_product, p_fa_rec.com_manufacturer,
       p_fa_rec.certificate_file, p_fa_rec.origin, p_fa_rec.create_id,
       p_fa_rec.create_date, p_fa_rec.update_id, p_fa_rec.update_date,
       p_fa_rec.remarks, p_fa_rec.factory_name, p_fa_rec.factory_province,
       p_fa_rec.factory_city, p_fa_rec.factory_county, p_fa_rec.worker_num,
       p_fa_rec.machine_num, p_fa_rec.reserve_capacity,
       p_fa_rec.product_efficiency, p_fa_rec.work_hours_day, p_fa_rec.memo,
       p_fa_rec.company_vill, p_fa_rec.factory_vill, p_fa_rec.pay_term,
       p_fa_rec.company_regist_date, p_fa_rec.is_our_factory,
       p_fa_rec.factroy_area, p_fa_rec.product_line,
       p_fa_rec.product_line_num, p_fa_rec.quality_step,
       p_fa_rec.worker_total_num, p_fa_rec.form_num, p_fa_rec.pattern_cap,
       p_fa_rec.fabric_purchase_cap, p_fa_rec.fabric_check_cap);
  EXCEPTION
    WHEN OTHERS THEN
      ROLLBACK;
      sys_raise_app_error_pkg.is_running_error(p_is_running_error => 'T',
                                               p_is_log           => 1);
  END p_insert_factory_ask;

  --新增意向合作范围
  PROCEDURE p_insert_ask_scope(p_scope_rec scmdata.t_ask_scope%ROWTYPE) IS
  BEGIN
    INSERT INTO t_ask_scope
      (ask_scope_id, company_id, object_id, object_type, cooperation_type,
       cooperation_classification, cooperation_product_cate,
       cooperation_subcategory, be_company_id, update_time, update_id,
       create_id, create_time, remarks, pause)
    VALUES
      (p_scope_rec.ask_scope_id, p_scope_rec.company_id,
       p_scope_rec.object_id, p_scope_rec.object_type,
       p_scope_rec.cooperation_type, p_scope_rec.cooperation_classification,
       p_scope_rec.cooperation_product_cate,
       p_scope_rec.cooperation_subcategory, p_scope_rec.be_company_id,
       p_scope_rec.update_time, p_scope_rec.update_id, p_scope_rec.create_id,
       p_scope_rec.create_time, p_scope_rec.remarks, p_scope_rec.pause);
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
    UPDATE t_factory_ask t --申请信息
       SET t.ask_user_id       = p_fa_rec.ask_user_id,
           t.ask_user_dept_id  = p_fa_rec.ask_user_dept_id,
           t.is_urgent         = p_fa_rec.is_urgent,
           t.cooperation_model = p_fa_rec.cooperation_model,
           t.product_type      = p_fa_rec.product_type,
           t.pay_term          = p_fa_rec.pay_term,
           t.ask_say           = p_fa_rec.ask_say,
           --基本信息
           t.company_name          = p_fa_rec.company_name,
           t.company_abbreviation  = p_fa_rec.company_abbreviation,
           t.company_province      = p_fa_rec.company_province,
           t.company_city          = p_fa_rec.company_city,
           t.company_county        = p_fa_rec.company_county,
           t.company_vill          = p_fa_rec.company_vill,
           t.company_address       = p_fa_rec.company_address,
           t.company_regist_date   = p_fa_rec.company_regist_date,
           t.legal_representative  = p_fa_rec.legal_representative,
           t.company_contact_phone = p_fa_rec.company_contact_phone,
           t.contact_name          = p_fa_rec.contact_name,
           t.contact_phone         = p_fa_rec.contact_phone,
           t.company_type          = p_fa_rec.company_type,
           t.brand_type            = p_fa_rec.brand_type,
           t.cooperation_brand     = p_fa_rec.cooperation_brand,
           t.product_link          = p_fa_rec.product_link,
           t.rela_supplier_id      = p_fa_rec.rela_supplier_id,
           t.is_our_factory        = p_fa_rec.is_our_factory,
           t.factory_name          = p_fa_rec.factory_name,
           t.factory_province      = p_fa_rec.factory_province,
           t.factory_city          = p_fa_rec.factory_city,
           t.factory_county        = p_fa_rec.factory_county,
           t.factory_vill          = p_fa_rec.factory_vill,
           t.ask_address           = p_fa_rec.ask_address,
           t.factroy_area          = p_fa_rec.factroy_area,
           t.remarks               = p_fa_rec.remarks,
           --生产信息
           t.product_line       = p_fa_rec.product_line,
           t.product_line_num   = p_fa_rec.product_line_num,
           t.quality_step       = p_fa_rec.quality_step,
           t.work_hours_day     = p_fa_rec.work_hours_day,
           t.machine_num        = p_fa_rec.machine_num,
           t.product_efficiency = p_fa_rec.product_efficiency,
           t.fabric_check_cap   = p_fa_rec.fabric_check_cap,
           --附件资料
           t.certificate_file = p_fa_rec.certificate_file,
           t.supplier_gate    = p_fa_rec.supplier_gate,
           t.supplier_office  = p_fa_rec.supplier_office,
           t.supplier_site    = p_fa_rec.supplier_site,
           t.supplier_product = p_fa_rec.supplier_product,
           t.ask_files        = p_fa_rec.ask_files,
           --其他  
           t.update_id   = p_fa_rec.update_id,
           t.update_date = p_fa_rec.update_date
     WHERE t.factory_ask_id = p_fa_rec.factory_ask_id;
  EXCEPTION
    WHEN OTHERS THEN
      ROLLBACK;
      sys_raise_app_error_pkg.is_running_error(p_is_running_error => 'T',
                                               p_is_log           => 1);
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
    v_judge NUMBER(1);
  BEGIN
    SELECT COUNT(1)
      INTO v_judge
      FROM scmdata.t_factory_ask
     WHERE factory_ask_id = p_factory_ask_id
       AND factrory_ask_flow_status IN ('CA01', 'FA01', 'FA02');
    IF v_judge = 0 THEN
      RETURN FALSE;
    ELSE
      RETURN TRUE;
    END IF;
  END f_check_fask_status;
  --验厂申请提交校验
  PROCEDURE p_check_factory_ask_by_submit(p_fa_rec scmdata.t_factory_ask%ROWTYPE) IS
  BEGIN
    --1.校验验厂申请说明不可为空
    IF p_fa_rec.ask_say IS NULL OR p_fa_rec.ask_say = ' ' THEN
      raise_application_error(-20002, '【验厂申请说明】不可为空！');
    END IF;
  
    --2.校验流程中是否已有单据
    scmdata.pkg_ask_record_mange_a.p_check_is_has_factory_ask(p_ask_record_id => p_fa_rec.ask_record_id,
                                                              p_company_id    => p_fa_rec.company_id);
  
    --3.校验流程字段在流程中是否重复
    p_check_flow_fields_is_repeat(p_company_id     => p_fa_rec.company_id,
                                  p_object_id      => p_fa_rec.factory_ask_id,
                                  p_flow_field     => 'COMPANY_NAME;COMPANY_ABBREVIATION;SOCIAL_CREDIT_CODE',
                                  p_flow_field_val => p_fa_rec.company_name || ';' ||
                                                      p_fa_rec.company_abbreviation || ';' ||
                                                      p_fa_rec.social_credit_code,
                                  p_type           => 2);
  
    --4.请填写意向合作范围后提交
    scmdata.pkg_ask_record_mange_a.p_check_t_ask_scope(p_factory_ask_id => p_fa_rec.factory_ask_id,
                                                       p_company_id     => p_fa_rec.company_id);
  
  END p_check_factory_ask_by_submit;

  --验厂申请单保存时校验
  PROCEDURE p_check_factory_ask_by_save(p_fa_rec scmdata.t_factory_ask%ROWTYPE) IS
  BEGIN
    --1.除合作申请已提交、验厂待申请、验厂待审批状态外，都不可保存
    IF f_check_fask_status(p_factory_ask_id => p_fa_rec.factory_ask_id) THEN
      --2.附件长度校验
      IF lengthb(p_fa_rec.ask_files) > 256 THEN
        raise_application_error(-20002, '最多只可上传7个附件！');
      END IF;
      --3.校验流程字段在流程中是否重复
      p_check_flow_fields_is_repeat(p_company_id     => p_fa_rec.company_id,
                                    p_object_id      => p_fa_rec.factory_ask_id,
                                    p_flow_field     => 'COMPANY_NAME;COMPANY_ABBREVIATION;SOCIAL_CREDIT_CODE',
                                    p_flow_field_val => p_fa_rec.company_name || ';' ||
                                                        p_fa_rec.company_abbreviation || ';' ||
                                                        p_fa_rec.social_credit_code,
                                    p_type           => 2);
    
      --4.校验供应商信息 公司类型为XXX时，意向合作模式只能为XXX
      /* p_check_company_type(p_company_type      => p_fa_rec.company_type,
      p_cooperation_model => p_fa_rec.cooperation_model);*/
    
      --意向合作模式必填
      IF p_fa_rec.cooperation_model IS NULL THEN
        raise_application_error(-20002, '意向合作模式必填！');
      ELSE
        --5.当意向合作模式为外协工厂时，必须填写关联供应商！
        IF p_fa_rec.cooperation_model = 'OF' AND
           p_fa_rec.rela_supplier_id IS NULL THEN
          raise_application_error(-20002,
                                  '当意向合作模式为外协工厂时，必须填写关联供应商！');
          --dyy153 20220407add 当意向合作模式≠外协厂时，无需填写关联供应商                     
        ELSIF p_fa_rec.cooperation_model <> 'OF' THEN
          IF p_fa_rec.rela_supplier_id IS NOT NULL THEN
            raise_application_error(-20002,
                                    '当意向合作模式不是外协工厂时，无需填写关联供应商！');
          END IF;
          IF p_fa_rec.pay_term IS NULL OR instr(p_fa_rec.pay_term, ' ') > 0 THEN
            raise_application_error(-20002,
                                    '“合作模式” 不等于外协工厂时，“付款条件”为必填项！');
          END IF;
        ELSE
          NULL;
        END IF;
      END IF;
      --营业执照
      IF p_fa_rec.certificate_file IS NULL THEN
        raise_application_error(-20002, '企业证照必填！');
      END IF;
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
    v_query_sql := Q'[
WITH dic AS
 (SELECT group_dict_value, group_dict_name, group_dict_type
    FROM scmdata.sys_group_dict)
SELECT v.company_name ar_company_name_n,
       v.company_abbreviation ar_company_abbreviation_n,
       decode(v.is_urgent, 1, '是', '否') is_urgent,
       /*substr(v.status, 1, instr(v.status, '+') - 1) flow_node_name,
       substr(v.status, instr(v.status, '+') + 1, length(v.status)) flow_node_status_desc,*/
       substr(v.coor_ask_flow_status,
              instr(v.coor_ask_flow_status, '+') + 1,
              length(v.coor_ask_flow_status)) ar_coor_ask_flow_status_n,
       v.factory_ask_type,
       decode(v.factory_ask_type, 0, '验厂申请', '验厂报告') factory_ask_report_detail,
       v.coop_classification_desc ar_coop_class_desc_n,
       v.cooperation_model_desc ar_coop_model_desc_n,
       v.fr_check_fac_result_n,
       v.factory_result_suggest,
       v.create_date fa_ask_date_n,
       v.check_date,
       v.factory_ask_id,
       v.factrory_ask_flow_status
  FROM (SELECT fa.factory_ask_id,
               fa.factrory_ask_flow_status,
               fa.ask_date,
               fa.factory_ask_type,
               fa.cooperation_company_id,
               fa.ask_company_id,
               fa.ask_user_id,
               fa.cooperation_type,
               fa.cooperation_model,
               fa.company_name,
               fa.company_abbreviation,
               fa.company_address,
               fa.company_id,
               fa.factory_name,
               fa.ask_address,
               fa.create_date,
               fa.update_date,
               gd.group_dict_name coor_ask_flow_status,
               fa.is_urgent,
               (SELECT listagg(gda.group_dict_name, ';')
                  FROM (SELECT DISTINCT ta.cooperation_classification tmp
                          FROM scmdata.t_ask_scope ta
                         WHERE ta.object_id = fa.ask_record_id
                           AND ta.company_id = fa.company_id) z
                 INNER JOIN dic gda
                    ON z.tmp = gda.group_dict_value
                   AND gda.group_dict_type = 'PRODUCT_TYPE') coop_classification_desc,
               fa.cooperation_model,
               (SELECT listagg(gdb.group_dict_name, ';') within GROUP(ORDER BY gdb.group_dict_value)
                  FROM dic gdb
                 WHERE gdb.group_dict_type = 'SUPPLY_TYPE'
                   AND instr(';' || fa.cooperation_model || ';',
                             ';' || gdb.group_dict_value || ';') > 0) cooperation_model_desc,
               fa.ask_user_id fa_check_person_y,
               su.company_user_name,
               fa.ask_user_dept_id fa_check_dept_name_y,
               dp.dept_name,
               CASE
                 WHEN fa.factory_ask_type <> 0 THEN
                  fr.check_result
                 ELSE
                  NULL
               END fr_check_fac_result_n,
               fr.factory_result_suggest,
               fr.check_date
          FROM scmdata.t_factory_ask fa
          LEFT JOIN t_factory_report fr
            ON fa.factory_ask_id = fr.factory_ask_id
          LEFT JOIN dic gd
            ON gd.group_dict_value = fa.factrory_ask_flow_status
           AND gd.group_dict_type = 'FACTORY_ASK_FLOW'
          LEFT JOIN sys_company_user_dept udp
            ON udp.user_id = fa.ask_user_id
           AND udp.company_id = fa.company_id
          LEFT JOIN scmdata.sys_company_dept dp
            ON dp.company_dept_id = udp.company_dept_id
           AND dp.company_id = udp.company_id
          LEFT JOIN scmdata.sys_company_user su
            ON su.user_id = fa.ask_user_id
           AND su.company_id = fa.company_id
         WHERE fa.factrory_ask_flow_status IN ('FA12', 'FA31')
           AND fa.company_id = %default_company_id%) v
 ORDER BY v.is_urgent DESC, v.update_date DESC, v.factory_ask_id DESC
]';
    RETURN v_query_sql;
  END f_query_uncheck_admit_ask;

  --已审核申请 a_coop_320
  FUNCTION f_query_checked_admit_ask RETURN CLOB IS
    v_query_sql CLOB;
  BEGIN
    v_query_sql := Q'[
    WITH dic AS
 (SELECT group_dict_value, group_dict_name, group_dict_type
    FROM scmdata.sys_group_dict)
SELECT v.company_name ar_company_name_n,
       v.company_abbreviation ar_company_abbreviation_n,
       decode(v.is_urgent, 1, '是', '否') is_urgent,
       /*substr(v.status, 1, instr(v.status, '+') - 1) flow_node_name,
       substr(v.status, instr(v.status, '+') + 1, length(v.status)) flow_node_status_desc,*/
       substr(v.coor_ask_flow_status,
              instr(v.coor_ask_flow_status, '+') + 1,
              length(v.coor_ask_flow_status)) ar_coor_ask_flow_status_n,
       decode(v.factory_ask_type, 0, '验厂申请', '验厂报告') factory_ask_report_detail,
       v.coop_classification_desc ar_coop_class_desc_n,
       v.cooperation_model_desc ar_coop_model_desc_n,
       (SELECT remarks
          FROM (SELECT remarks
                  FROM t_factory_ask_oper_log
                 WHERE factory_ask_id = v.factory_ask_id
                   AND status_af_oper IN ('FA22', 'FA21', 'FA32', 'FA33')
                 ORDER BY oper_time DESC)
         WHERE rownum <= 1) audit_comment,
       v.fr_check_fac_result_n,
       v.factory_result_suggest,
       v.create_date fa_ask_date_n,
       v.check_date,
       v.audit_date,
       v.factory_ask_id
  FROM (SELECT fa.factory_ask_id,
               fa.factrory_ask_flow_status,
               fa.ask_date,
               fa.factory_ask_type,
               fa.cooperation_company_id,
               fa.ask_company_id,
               fa.ask_user_id,
               fa.cooperation_type,
               fa.cooperation_model,
               fa.company_name,
               fa.company_abbreviation,
               fa.company_address,
               fa.company_id,
               fa.factory_name,
               fa.ask_address,
               fa.create_date,
               fa.update_date,
               gd.group_dict_name coor_ask_flow_status,
               fa.is_urgent,
               (SELECT listagg(gda.group_dict_name, ';')
                  FROM (SELECT DISTINCT ta.cooperation_classification tmp
                          FROM scmdata.t_ask_scope ta
                         WHERE ta.object_id = fa.ask_record_id
                           AND ta.company_id = fa.company_id) z
                 INNER JOIN dic gda
                    ON z.tmp = gda.group_dict_value
                   AND gda.group_dict_type = 'PRODUCT_TYPE') coop_classification_desc,
               fa.cooperation_model,
               (SELECT listagg(gdb.group_dict_name, ';') within GROUP(ORDER BY gdb.group_dict_value)
                  FROM dic gdb
                 WHERE gdb.group_dict_type = 'SUPPLY_TYPE'
                   AND instr(';' || fa.cooperation_model || ';',
                             ';' || gdb.group_dict_value || ';') > 0) cooperation_model_desc,
               fa.ask_user_id fa_check_person_y,
               su.company_user_name,
               fa.ask_user_dept_id fa_check_dept_name_y,
               dp.dept_name,
               CASE
                 WHEN fa.factory_ask_type <> 0 THEN
                  fr.check_result
                 ELSE
                  NULL
               END fr_check_fac_result_n,
               fr.factory_result_suggest,
               fr.check_date,
               sp.create_date audit_date
          FROM scmdata.t_factory_ask fa
          LEFT JOIN scmdata.t_factory_report fr
            ON fa.factory_ask_id = fr.factory_ask_id
          LEFT JOIN scmdata.t_supplier_info sp
            ON sp.supplier_info_origin_id = fa.factory_ask_id
           AND sp.company_id = fa.company_id
          LEFT JOIN dic gd
            ON gd.group_dict_value = fa.factrory_ask_flow_status
           AND gd.group_dict_type = 'FACTORY_ASK_FLOW'
          LEFT JOIN sys_company_user_dept udp
            ON udp.user_id = fa.ask_user_id
           AND udp.company_id = fa.company_id
          LEFT JOIN scmdata.sys_company_dept dp
            ON dp.company_dept_id = udp.company_dept_id
           AND dp.company_id = udp.company_id
          LEFT JOIN scmdata.sys_company_user su
            ON su.user_id = fa.ask_user_id
           AND su.company_id = fa.company_id
         WHERE fa.factrory_ask_flow_status IN
               ('FA22', 'FA21', 'FA32', 'FA33', 'SP_01')
           AND fa.company_id = %default_company_id%) v
 ORDER BY v.update_date DESC, v.factory_ask_id DESC
]';
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
       tfa.company_vill,
       tfa.company_address,
       tfa.factory_name,
       (SELECT b.pcc
          FROM pcc_dict b
         WHERE b.provinceid = tfa.factory_province
           AND b.cityno = tfa.factory_city
           AND b.countyid = tfa.factory_county) fpcc,
       tfa.factory_vill,
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
      (log_id, factory_ask_id, oper_user_id, oper_code, status_af_oper,
       ask_record_id, oper_time, oper_user_company_id)
    VALUES
      (scmdata.f_get_uuid(), p_fac_ask_id, p_user_id, p_oper_code, p_status,
       (SELECT ask_record_id
           FROM scmdata.t_factory_ask
          WHERE factory_ask_id = p_fac_ask_id), SYSDATE, p_company_id);
  
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

  --更新单据状态同时记录流程操作日志
  PROCEDURE p_update_flow_status_and_logger(p_company_id       VARCHAR2,
                                            p_user_id          VARCHAR2,
                                            p_fac_ask_id       VARCHAR2 DEFAULT NULL, --验厂申请单ID
                                            p_ask_record_id    VARCHAR2 DEFAULT NULL, --合作申请单ID
                                            p_flow_oper_status VARCHAR2, --流程操作方式编码
                                            --p_flow_bf_status   VARCHAR2, --操作前流程状态
                                            p_flow_af_status VARCHAR2, --操作后流程状态
                                            p_memo           VARCHAR2 DEFAULT NULL) IS
    v_ask_record_id  VARCHAR2(32) := p_ask_record_id;
    v_flow_bf_status VARCHAR2(32);
  BEGIN
    --验厂申请单
    IF p_fac_ask_id IS NOT NULL THEN
      SELECT MAX(ask_record_id), MAX(factrory_ask_flow_status)
        INTO v_ask_record_id, v_flow_bf_status
        FROM t_factory_ask
       WHERE factory_ask_id = p_fac_ask_id;
    
      UPDATE scmdata.t_factory_ask
         SET factrory_ask_flow_status = p_flow_af_status,
             update_id                = p_user_id,
             update_date              = SYSDATE
       WHERE factory_ask_id = p_fac_ask_id
         AND company_id = p_company_id;
    
      IF p_flow_oper_status = 'CA03' THEN
        SELECT MAX(coor_ask_flow_status)
          INTO v_flow_bf_status
          FROM t_ask_record
         WHERE ask_record_id = v_ask_record_id;
      
        UPDATE t_ask_record
           SET coor_ask_flow_status = p_flow_af_status,
               ask_date             = NULL,
               update_id            = p_user_id,
               update_date          = SYSDATE
         WHERE ask_record_id = v_ask_record_id;
      ELSE
        NULL;
      END IF;
      --合作申请单    
    ELSIF p_ask_record_id IS NOT NULL THEN
      SELECT MAX(coor_ask_flow_status)
        INTO v_flow_bf_status
        FROM t_ask_record
       WHERE ask_record_id = v_ask_record_id;
    
      UPDATE t_ask_record
         SET ask_date = CASE
                          WHEN p_flow_af_status IN ('CA00', 'CA03') THEN
                           NULL
                          ELSE
                           SYSDATE
                        END,
             coor_ask_flow_status = p_flow_af_status,
             update_id            = p_user_id,
             update_date          = SYSDATE
       WHERE ask_record_id = v_ask_record_id;
    ELSE
      NULL;
    END IF;
    --记录操作日志(暂不放触发器实现)
    INSERT INTO t_factory_ask_oper_log
      (log_id, factory_ask_id, oper_user_id, oper_code, status_af_oper,
       remarks, ask_record_id, oper_time, oper_user_company_id,
       status_bf_oper)
    VALUES
      (f_get_uuid(), p_fac_ask_id, p_user_id, p_flow_oper_status,
       p_flow_af_status, p_memo, v_ask_record_id, SYSDATE, p_company_id,
       v_flow_bf_status);
  EXCEPTION
    WHEN OTHERS THEN
      ROLLBACK;
      sys_raise_app_error_pkg.is_running_error(p_is_running_error => 'T',
                                               p_is_log           => 1);
  END p_update_flow_status_and_logger;

  --查询流程日志
  FUNCTION f_query_flow_status_logger(p_ask_record_id VARCHAR2 DEFAULT NULL,
                                      p_ask_fac_id    VARCHAR2 DEFAULT NULL)
    RETURN CLOB IS
    v_rtn_str CLOB;
  BEGIN
    v_rtn_str := q'[SELECT * FROM (
   SELECT  a.log_id,
           substr(sbf.group_dict_name,
                  0,
                  instr(sbf.group_dict_name, '+') - 1) flow_node_name_bf,
           substr(sbf.group_dict_name,
                  instr(sbf.group_dict_name, '+') + 1,
                  length(sbf.group_dict_name)) flow_node_status_desc_bf,
           fu.company_user_name oper_user_name,
           goper.group_dict_name oper_code_desc,
           a.oper_time,
           a.remarks,
           substr(saf.group_dict_name,
                  0,
                  instr(saf.group_dict_name, '+') - 1) flow_node_name_af,
           substr(saf.group_dict_name,
                  instr(saf.group_dict_name, '+') + 1,
                  length(saf.group_dict_name)) flow_node_status_desc_af,
           a.ask_record_id,
           a.status_bf_oper,
           a.status_af_oper
      FROM t_factory_ask_oper_log a
     INNER JOIN sys_group_dict goper
        ON goper.group_dict_value = upper(a.oper_code)
       AND goper.group_dict_type = 'DICT_FLOW_STATUS'
     LEFT JOIN sys_group_dict sbf
        ON sbf.group_dict_value = a.status_bf_oper
       AND sbf.group_dict_type = 'FACTORY_ASK_FLOW'
     INNER JOIN sys_group_dict saf
        ON saf.group_dict_value = a.status_af_oper
       AND saf.group_dict_type = 'FACTORY_ASK_FLOW'
     LEFT JOIN sys_company_user fu
        ON fu.user_id = a.oper_user_id
       AND fu.company_id = a.oper_user_company_id 
       ]' || (CASE
                   WHEN p_ask_fac_id IS NULL AND p_ask_record_id IS NOT NULL THEN
                    q'[
      WHERE a.ask_record_id = ']' || p_ask_record_id ||
                     q'[']'
                   WHEN p_ask_fac_id IS NOT NULL AND p_ask_record_id IS NULL THEN
                    q'[
      WHERE a.ask_record_id =(SELECT ask_record_id FROM t_factory_ask WHERE factory_ask_id = ']' ||
                     p_ask_fac_id || q'[')]'
                   ELSE
                    q'[
      WHERE 1 = 0]'
                 END) || q'[ 
      ORDER BY a.oper_time DESC) 
   WHERE status_af_oper NOT IN ('CA00','CA01')]';
    RETURN v_rtn_str;
  END f_query_flow_status_logger;

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

  --合作范围
  --查询
  FUNCTION f_query_t_ask_scope(p_object_id VARCHAR2) RETURN CLOB IS
    v_sql CLOB;
  BEGIN
    v_sql := q'[WITH dic AS
 (SELECT group_dict_value, group_dict_name, group_dict_type
    FROM scmdata.sys_group_dict)
SELECT tas.ask_scope_id,
       tas.company_id,
       tas.object_id,
       tas.object_type,
       tas.cooperation_type,
       tas.cooperation_classification,
       gda.group_dict_name cooperation_classification_des,
       tas.cooperation_product_cate,
       gdb.group_dict_name cooperation_product_cate_desc,
       tas.cooperation_subcategory,
       (SELECT listagg(b.company_dict_name, ';')
          FROM (SELECT regexp_substr(tas.cooperation_subcategory,
                                     '[^;]+',
                                     1,
                                     LEVEL) col
                  FROM dual
                CONNECT BY LEVEL <=
                           regexp_count(tas.cooperation_subcategory, '\;') + 1) a
         INNER JOIN scmdata.sys_company_dict b
            ON a.col = b.company_dict_value
           AND company_id = %default_company_id%
           AND b.company_dict_type = tas.cooperation_product_cate) cooperation_subcategory_desc
  FROM scmdata.t_ask_scope tas
 INNER JOIN dic gda
    ON gda.group_dict_value = tas.cooperation_classification
   AND gda.group_dict_type = tas.cooperation_type
 INNER JOIN dic gdb
    ON gdb.group_dict_value = tas.cooperation_product_cate
   AND gdb.group_dict_type = tas.cooperation_classification
 WHERE object_id = ']' || p_object_id || q'[']';
    RETURN v_sql;
  END f_query_t_ask_scope;

  /*============================================*
  * Author   : CZH
  * Created  : 13-12月-22
  * ALERTER  :
  * ALERTER_TIME  :
  * Purpose  : 新增 T_ASK_SCOPE
  * Obj_Name    : P_INSERT_T_ASK_SCOPE
  *============================================*/
  PROCEDURE p_insert_t_ask_scope(p_t_ask_rec scmdata.t_ask_scope%ROWTYPE) IS
  BEGIN
    INSERT INTO t_ask_scope
      (ask_scope_id, company_id, object_id, object_type, cooperation_type,
       cooperation_classification, cooperation_product_cate,
       cooperation_subcategory, be_company_id, update_time, update_id,
       create_id, create_time, remarks, pause)
    VALUES
      (p_t_ask_rec.ask_scope_id, p_t_ask_rec.company_id,
       p_t_ask_rec.object_id, p_t_ask_rec.object_type,
       p_t_ask_rec.cooperation_type, p_t_ask_rec.cooperation_classification,
       p_t_ask_rec.cooperation_product_cate,
       p_t_ask_rec.cooperation_subcategory, p_t_ask_rec.be_company_id,
       p_t_ask_rec.update_time, p_t_ask_rec.update_id, p_t_ask_rec.create_id,
       p_t_ask_rec.create_time, p_t_ask_rec.remarks, p_t_ask_rec.pause);
  END p_insert_t_ask_scope;

  /*============================================*
  * Author   : CZH
  * Created  : 13-12月-22
  * ALERTER  :
  * ALERTER_TIME  :
  * Purpose  : 修改 T_ASK_SCOPE
  * Obj_Name    : P_UPDATE_T_ASK_SCOPE
  *============================================*/
  PROCEDURE p_update_t_ask_scope(p_t_ask_rec scmdata.t_ask_scope%ROWTYPE) IS
  BEGIN
    UPDATE t_ask_scope t
       SET t.cooperation_classification = p_t_ask_rec.cooperation_classification,
           t.cooperation_product_cate   = p_t_ask_rec.cooperation_product_cate,
           t.cooperation_subcategory    = p_t_ask_rec.cooperation_subcategory,
           t.update_time                = p_t_ask_rec.update_time,
           t.update_id                  = p_t_ask_rec.update_id
     WHERE t.ask_scope_id = p_t_ask_rec.ask_scope_id;
  END p_update_t_ask_scope;

  /*============================================*
  * Author   : CZH
  * Created  : 13-12月-22
  * ALERTER  :
  * ALERTER_TIME  :
  * Purpose  : 删除 T_ASK_SCOPE
  * Obj_Name    : P_DELETE_T_ASK_SCOPE
  *============================================*/
  PROCEDURE p_delete_t_ask_scope(p_t_ask_rec scmdata.t_ask_scope%ROWTYPE) IS
  BEGIN
    DELETE FROM t_ask_scope t
     WHERE t.ask_scope_id = p_t_ask_rec.ask_scope_id;
  END p_delete_t_ask_scope;

  --合作申请
  --人员、机器配置
  /*============================================*
  * Author   : CZH
  * Created  : 08-11月-22
  * ALERTER  :
  * ALERTER_TIME  :
  * Purpose  : 查询T_PERSON_CONFIG_HZ
  * Obj_Name    : F_QUERY_T_PERSON_CONFIG_HZ
  *============================================*/
  FUNCTION f_query_t_person_config_hz(p_ask_record_id VARCHAR2) RETURN CLOB IS
    v_sql CLOB;
  BEGIN
    v_sql := 'SELECT t.person_config_id,
       t.company_id,
       t.person_role_id ar_person_role_n,
       t.department_id  ar_department_n,
       t.person_job_id  ar_person_job_n,
       t.apply_category_id ar_apply_cate_n,
       t.job_state         ar_job_state_n,
       t.person_num        ar_person_num_n,
       t.remarks           ar_remarks_n
  FROM t_person_config_hz t
 WHERE t.ask_record_id = ''' || p_ask_record_id || '''
   AND t.company_id = %default_company_id%';
    RETURN v_sql;
  END f_query_t_person_config_hz;

  /*============================================*
  * Author   : CZH
  * Created  : 08-11月-22
  * ALERTER  :
  * ALERTER_TIME  :
  * Purpose  : 新增T_PERSON_CONFIG_HZ
  * Obj_Name    : P_INSERT_T_PERSON_CONFIG_HZ
  *============================================*/
  PROCEDURE p_insert_t_person_config_hz(p_t_per_rec t_person_config_hz%ROWTYPE) IS
  BEGIN
    INSERT INTO t_person_config_hz
      (person_config_id, company_id, person_role_id, department_id,
       person_job_id, apply_category_id, job_state, person_num, seqno, pause,
       remarks, update_id, update_time, create_id, create_time,
       ask_record_id)
    VALUES
      (p_t_per_rec.person_config_id, p_t_per_rec.company_id,
       p_t_per_rec.person_role_id, p_t_per_rec.department_id,
       p_t_per_rec.person_job_id, p_t_per_rec.apply_category_id,
       p_t_per_rec.job_state, p_t_per_rec.person_num, p_t_per_rec.seqno,
       p_t_per_rec.pause, p_t_per_rec.remarks, p_t_per_rec.update_id,
       p_t_per_rec.update_time, p_t_per_rec.create_id,
       p_t_per_rec.create_time, p_t_per_rec.ask_record_id);
  END p_insert_t_person_config_hz;

  /*============================================*
  * Author   : CZH
  * Created  : 08-11月-22
  * ALERTER  :
  * ALERTER_TIME  :
  * Purpose  : 修改T_PERSON_CONFIG_HZ
  * Obj_Name    : P_UPDATE_T_PERSON_CONFIG_HZ
  *============================================*/
  PROCEDURE p_update_t_person_config_hz(p_t_per_rec t_person_config_hz%ROWTYPE) IS
  BEGIN
    UPDATE t_person_config_hz t
       SET t.person_num  = nvl(p_t_per_rec.person_num, 0),
           t.remarks     = p_t_per_rec.remarks,
           t.update_id   = p_t_per_rec.update_id,
           t.update_time = p_t_per_rec.update_time
     WHERE t.person_config_id = p_t_per_rec.person_config_id;
  END p_update_t_person_config_hz;

  /*============================================*
  * Author   : CZH
  * Created  : 08-11月-22
  * ALERTER  :
  * ALERTER_TIME  :
  * Purpose  : 删除T_PERSON_CONFIG_HZ
  * Obj_Name    : P_DELETE_T_PERSON_CONFIG_HZ
  *============================================*/
  PROCEDURE p_delete_t_person_config_hz(p_t_per_rec t_person_config_hz%ROWTYPE) IS
  BEGIN
    DELETE FROM t_person_config_hz t
     WHERE t.person_config_id = p_t_per_rec.person_config_id;
  END p_delete_t_person_config_hz;

  /*============================================*
  * Author   : CZH
  * Created  : 08-11月-22
  * ALERTER  :
  * ALERTER_TIME  :
  * Purpose  : 查询T_MACHINE_EQUIPMENT_HZ
  * Obj_Name    : F_QUERY_T_MACHINE_EQUIPMENT_HZ
  *============================================*/
  FUNCTION f_query_t_machine_equipment_hz(p_ask_record_id VARCHAR2)
    RETURN CLOB IS
    v_sql CLOB;
  BEGIN
    v_sql := 'SELECT t.machine_equipment_id,
           t.company_id,
           t.equipment_category_id ar_equipment_cate_n,
           t.equipment_name ar_equipment_name_y,
           t.machine_num ar_machine_num_n,
           t.remarks,
           t.orgin   orgin_val,
           decode(t.orgin,''AA'',''系统配置'',''MA'',''手动新增'') orgin
      FROM t_machine_equipment_hz t
    WHERE t.ask_record_id = ''' || p_ask_record_id || '''
   AND t.company_id = %default_company_id% 
   ORDER BY t.seqno ASC';
    RETURN v_sql;
  END f_query_t_machine_equipment_hz;

  /*============================================*
  * Author   : CZH
  * Created  : 08-11月-22
  * ALERTER  :
  * ALERTER_TIME  :
  * Purpose  : 新增T_MACHINE_EQUIPMENT_HZ
  * Obj_Name    : P_INSERT_T_MACHINE_EQUIPMENT_HZ
  *============================================*/
  PROCEDURE p_insert_t_machine_equipment_hz(p_t_mac_rec t_machine_equipment_hz%ROWTYPE) IS
  BEGIN
    INSERT INTO t_machine_equipment_hz
      (machine_equipment_id, company_id, equipment_category_id,
       equipment_name, machine_num, seqno, orgin, pause, remarks, update_id,
       update_time, create_id, create_time, ask_record_id)
    VALUES
      (p_t_mac_rec.machine_equipment_id, p_t_mac_rec.company_id,
       p_t_mac_rec.equipment_category_id, p_t_mac_rec.equipment_name,
       p_t_mac_rec.machine_num, p_t_mac_rec.seqno, p_t_mac_rec.orgin,
       p_t_mac_rec.pause, p_t_mac_rec.remarks, p_t_mac_rec.update_id,
       p_t_mac_rec.update_time, p_t_mac_rec.create_id,
       p_t_mac_rec.create_time, p_t_mac_rec.ask_record_id);
  END p_insert_t_machine_equipment_hz;

  /*============================================*
  * Author   : CZH
  * Created  : 08-11月-22
  * ALERTER  :
  * ALERTER_TIME  :
  * Purpose  : 修改T_MACHINE_EQUIPMENT_HZ
  * Obj_Name    : P_UPDATE_T_MACHINE_EQUIPMENT_HZ
  *============================================*/
  PROCEDURE p_update_t_machine_equipment_hz(p_t_mac_rec t_machine_equipment_hz%ROWTYPE) IS
  BEGIN
    UPDATE t_machine_equipment_hz t
       SET t.equipment_category_id = p_t_mac_rec.equipment_category_id,
           t.equipment_name        = p_t_mac_rec.equipment_name,
           t.machine_num           = p_t_mac_rec.machine_num,
           t.remarks               = p_t_mac_rec.remarks,
           t.update_id             = p_t_mac_rec.update_id,
           t.update_time           = p_t_mac_rec.update_time
     WHERE t.machine_equipment_id = p_t_mac_rec.machine_equipment_id;
  END p_update_t_machine_equipment_hz;

  --新增 修改校验
  PROCEDURE p_check_t_machine_equipment_hz(p_t_mac_rec t_machine_equipment_hz%ROWTYPE) IS
    v_cnt INT;
  BEGIN
    SELECT COUNT(1)
      INTO v_cnt
      FROM scmdata.t_machine_equipment_hz t
     WHERE t.machine_equipment_id <> p_t_mac_rec.machine_equipment_id
       AND t.ask_record_id = p_t_mac_rec.ask_record_id
       AND t.equipment_name = p_t_mac_rec.equipment_name;
    IF v_cnt > 0 THEN
      raise_application_error(-20002, '【设备名称】不可重复！');
    END IF;
  END p_check_t_machine_equipment_hz;

  --删除校验
  PROCEDURE p_check_t_machine_equipment_hz_by_delete(p_orgin VARCHAR2) IS
  BEGIN
    IF p_orgin = 'AA' THEN
      raise_application_error(-20002, '系统配置的数据不允许删除！');
    ELSE
      NULL;
    END IF;
  END p_check_t_machine_equipment_hz_by_delete;

  /*============================================*
  * Author   : CZH
  * Created  : 08-11月-22
  * ALERTER  :
  * ALERTER_TIME  :
  * Purpose  : 删除T_MACHINE_EQUIPMENT_HZ
  * Obj_Name    : P_DELETE_T_MACHINE_EQUIPMENT_HZ
  *============================================*/
  PROCEDURE p_delete_t_machine_equipment_hz(p_t_mac_rec t_machine_equipment_hz%ROWTYPE) IS
  BEGIN
    p_check_t_machine_equipment_hz_by_delete(p_orgin => p_t_mac_rec.orgin);
  
    DELETE FROM t_machine_equipment_hz t
     WHERE t.machine_equipment_id = p_t_mac_rec.machine_equipment_id;
  
  END p_delete_t_machine_equipment_hz;

  --新增意向供应商时，同步生成人员、机器配置
  PROCEDURE p_generate_person_machine_config(p_company_id    VARCHAR2,
                                             p_user_id       VARCHAR2,
                                             p_ask_record_id VARCHAR2) IS
    v_flag INT := 0;
  BEGIN
    --人员配置
    DECLARE
      v_t_per_rec t_person_config_hz%ROWTYPE;
    BEGIN
      SELECT COUNT(1)
        INTO v_flag
        FROM scmdata.t_person_config_hz t
       WHERE t.ask_record_id = p_ask_record_id
         AND t.company_id = p_company_id;
    
      IF v_flag > 0 THEN
        NULL;
      ELSE
        FOR p_t_per_rec IN (SELECT *
                              FROM scmdata.t_person_config t
                             WHERE t.company_id = p_company_id
                             ORDER BY t.seqno ASC) LOOP
          v_t_per_rec.person_config_id  := scmdata.f_get_uuid();
          v_t_per_rec.company_id        := p_company_id;
          v_t_per_rec.person_role_id    := p_t_per_rec.person_role_id;
          v_t_per_rec.department_id     := p_t_per_rec.department_id;
          v_t_per_rec.person_job_id     := p_t_per_rec.person_job_id;
          v_t_per_rec.apply_category_id := p_t_per_rec.apply_category_id;
          v_t_per_rec.job_state         := p_t_per_rec.job_state;
          v_t_per_rec.person_num        := 0;
          v_t_per_rec.seqno             := p_t_per_rec.seqno;
          v_t_per_rec.pause             := 0;
          v_t_per_rec.remarks           := NULL;
          v_t_per_rec.update_id         := p_user_id;
          v_t_per_rec.update_time       := SYSDATE;
          v_t_per_rec.create_id         := p_user_id;
          v_t_per_rec.create_time       := SYSDATE;
          v_t_per_rec.ask_record_id     := p_ask_record_id;
          scmdata.pkg_ask_record_mange.p_insert_t_person_config_hz(p_t_per_rec => v_t_per_rec);
        END LOOP;
      END IF;
    END person_config;
  
    --机器配置
    DECLARE
      v_t_mac_rec t_machine_equipment_hz%ROWTYPE;
    BEGIN
      SELECT COUNT(1)
        INTO v_flag
        FROM scmdata.t_machine_equipment_hz t
       WHERE t.ask_record_id = p_ask_record_id
         AND t.company_id = p_company_id;
    
      IF v_flag > 0 THEN
        NULL;
      ELSE
        FOR p_t_mac_rec IN (SELECT *
                              FROM scmdata.t_machine_equipment t
                             WHERE t.company_id = p_company_id
                               AND t.template_type = 'TYPE_00'
                             ORDER BY t.seqno ASC) LOOP
          v_t_mac_rec.machine_equipment_id  := scmdata.f_get_uuid();
          v_t_mac_rec.company_id            := p_company_id;
          v_t_mac_rec.equipment_category_id := p_t_mac_rec.equipment_category_id;
          v_t_mac_rec.equipment_name        := p_t_mac_rec.equipment_name;
          v_t_mac_rec.machine_num           := 0;
          v_t_mac_rec.seqno                 := p_t_mac_rec.seqno;
          v_t_mac_rec.orgin                 := 'AA';
          v_t_mac_rec.pause                 := 0;
          v_t_mac_rec.remarks               := NULL;
          v_t_mac_rec.update_id             := p_user_id;
          v_t_mac_rec.update_time           := SYSDATE;
          v_t_mac_rec.create_id             := p_user_id;
          v_t_mac_rec.create_time           := SYSDATE;
          v_t_mac_rec.ask_record_id         := p_ask_record_id;
        
          scmdata.pkg_ask_record_mange.p_insert_t_machine_equipment_hz(p_t_mac_rec => v_t_mac_rec);
        END LOOP;
      END IF;
    END machine_config;
  END p_generate_person_machine_config;

  --人员配置保存
  --同步更新主表中生产信息的”总人数“、”车位人数“、”成型人数_鞋类“、”打版能力“、”面料采购能力“
  PROCEDURE p_generate_ask_record_product_info(p_company_id    VARCHAR2,
                                               p_ask_record_id VARCHAR2) IS
    v_person_num_total INT;
    v_person_num_cw    INT;
    v_person_num_form  INT;
    v_person_num_db    INT;
    v_person_num_cg    INT;
  BEGIN
    SELECT SUM(t.person_num) person_num_total,
           SUM(CASE
                 WHEN t.person_job_id = 'ROLE_01_01_01' THEN
                  t.person_num
                 ELSE
                  0
               END) person_num_cw,
           SUM(CASE
                 WHEN t.person_job_id = 'ROLE_01_01_08' THEN
                  t.person_num
                 ELSE
                  0
               END) person_num_form,
           SUM(CASE
                 WHEN t.person_job_id = 'ROLE_00_01_00' THEN
                  t.person_num
                 ELSE
                  0
               END) person_num_db,
           SUM(CASE
                 WHEN t.person_job_id = 'ROLE_03_01_00' THEN
                  t.person_num
                 ELSE
                  0
               END) person_num_cg
      INTO v_person_num_total,
           v_person_num_cw,
           v_person_num_form,
           v_person_num_db,
           v_person_num_cg
      FROM scmdata.t_person_config_hz t
     WHERE t.ask_record_id = p_ask_record_id
       AND t.company_id = p_company_id;
  
    UPDATE scmdata.t_ask_record t
       SET t.worker_total_num    = v_person_num_total,
           t.worker_num          = v_person_num_cw,
           t.form_num            = v_person_num_form,
           t.pattern_cap = (CASE
                             WHEN v_person_num_db > 0 THEN
                              '00'
                             ELSE
                              '01'
                           END),
           t.fabric_purchase_cap = (CASE
                                     WHEN v_person_num_cg > 0 THEN
                                      '00'
                                     ELSE
                                      '01'
                                   END)
     WHERE t.ask_record_id = p_ask_record_id
       AND t.be_company_id = p_company_id;
  END p_generate_ask_record_product_info;

END pkg_ask_record_mange;
/
