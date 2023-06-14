CREATE OR REPLACE PACKAGE pkg_a_config_lib IS

  -- Author  : zwh73
  -- Created : 2020/11/20 15:51:41
  -- Purpose : 业务管理配置通用包
  --PRODUCT_SUBCLASS production_category  PRODUCTION_CATEGORY industry_classification INDUSTRY_CLASSIFICATION
  --判断某个表的生产类别是否有重复，需要company_id，重复时返回重复的模型名称
  FUNCTION f_is_cate_repeat_by_tableacompany(pi_company_id              VARCHAR2,
                                             pi_table_name              VARCHAR2,
                                             pi_industry_classification VARCHAR2,
                                             pi_production_category     VARCHAR2,
                                             pi_new_id                  VARCHAR2,
                                             pi_key_name                VARCHAR2,
                                             pi_model_field_name        VARCHAR2,
                                             pi_model_id_name           VARCHAR2,
                                             pi_model_table_name        VARCHAR2)
    RETURN VARCHAR2;

  --判断某个表的生产类别是否有重复，如果重复，抛出错误
  PROCEDURE p_check_cate_repeat_by_tableacompany(pi_company_id              IN VARCHAR2,
                                                 pi_table_name              IN VARCHAR2,
                                                 pi_industry_classification IN VARCHAR2,
                                                 pi_production_category     IN VARCHAR2,
                                                 pi_new_id                  IN VARCHAR2,
                                                 pi_key_name                IN VARCHAR2,
                                                 pi_model_field_name        IN VARCHAR2,
                                                 pi_model_id_name           IN VARCHAR2,
                                                 pi_model_table_name        IN VARCHAR2);

  --判断某个表的生产类别是否有重复，需要company_id,无需返回模型名称
  FUNCTION f_is_cate_repeat_without_model(pi_company_id              VARCHAR2,
                                          pi_table_name              VARCHAR2,
                                          pi_industry_classification VARCHAR2,
                                          pi_production_category     VARCHAR2,
                                          pi_new_id                  VARCHAR2,
                                          pi_key_name                VARCHAR)
    RETURN NUMBER;
  --判断某个表的生产类别是否有重复，需要company_id,无需返回模型名称   ，如果重复，抛出错误      
  PROCEDURE p_check_cate_repeat_without_model(pi_company_id              IN VARCHAR2,
                                              pi_table_name              IN VARCHAR2,
                                              pi_industry_classification IN VARCHAR2,
                                              pi_production_category     IN VARCHAR2,
                                              pi_new_id                  IN VARCHAR2,
                                              pi_key_name                IN VARCHAR2);

  PROCEDURE p_check_cate_repeat_deduction_v2(pi_company_id              IN VARCHAR2,
                                             pi_config_id               IN VARCHAR2,
                                             pi_industry_classification IN VARCHAR2,
                                             pi_production_category     IN VARCHAR2,
                                             pi_product_subclass        IN VARCHAR2,
                                             pi_new_id                  IN VARCHAR2);

  PROCEDURE p_check_cate_repeat_abnormal_v2(pi_company_id              IN VARCHAR2,
                                            pi_config_id               IN VARCHAR2,
                                            pi_industry_classification IN VARCHAR2,
                                            pi_production_category     IN VARCHAR2,
                                            pi_product_subclass        IN VARCHAR2,
                                            pi_new_id                  IN VARCHAR2);

  PROCEDURE p_check_cate_repeat_progress_v2(pi_company_id              IN VARCHAR2,
                                            pi_config_id               IN VARCHAR2,
                                            pi_industry_classification IN VARCHAR2,
                                            pi_production_category     IN VARCHAR2,
                                            pi_product_subclass        IN VARCHAR2,
                                            pi_new_id                  IN VARCHAR2);

  --重算某个生产进度的模板下的生产模板配置
  PROCEDURE p_recalculate_node_order_num(pi_progress_config_id IN VARCHAR2);

  PROCEDURE p_check_model_name_repeat_progress(pi_company_id IN VARCHAR2,
                                               pi_config_id  IN VARCHAR2,
                                               pi_model_name IN VARCHAR2);
  PROCEDURE p_check_model_name_repeat_abnormal(pi_company_id IN VARCHAR2,
                                               pi_config_id  IN VARCHAR2,
                                               pi_model_name IN VARCHAR2);
  PROCEDURE p_check_model_name_repeat_deduction(pi_company_id IN VARCHAR2,
                                                pi_config_id  IN VARCHAR2,
                                                pi_model_name IN VARCHAR2);

  -------------------------------czh add 所在分组配置  begin--------------------------------
  --Query
  --1.所在分组
  --查询所在分组配置
  FUNCTION f_query_supplier_group_config(p_company_id VARCHAR2) RETURN CLOB;

  --查询所属品类
  FUNCTION f_query_supp_group_category(p_company_id      VARCHAR2,
                                       p_group_config_id VARCHAR2)
    RETURN CLOB;
  --查询所属区域
  FUNCTION f_query_supp_group_area(p_company_id VARCHAR2) RETURN CLOB;
  --Query Picklist
  --意向生产类别
  FUNCTION f_query_category_picksql RETURN CLOB;
  --意向生产类别
  FUNCTION f_query_product_cate_picksql RETURN CLOB;
  --区域配置
  --省市
  FUNCTION f_query_area_picksql(p_type NUMBER, p_is_nationwide NUMBER)
    RETURN CLOB;
  --所属区域
  FUNCTION f_query_group_area_picksql RETURN CLOB;
  --Query lookup
  --区域组长
  FUNCTION f_query_area_gl_leader(p_company_id VARCHAR2) RETURN CLOB;

  --Insert
  --新增所在分组配置
  PROCEDURE p_insert_supplier_group_config(p_gc_rec scmdata.t_supplier_group_config%ROWTYPE);
  --新增所在品类
  PROCEDURE p_insert_supp_group_category(p_gc_rec scmdata.t_supplier_group_category_config%ROWTYPE);
  --新增所在区域
  PROCEDURE p_insert_supp_group_area(p_gc_rec scmdata.t_supplier_group_area_config%ROWTYPE);

  --Update
  --修改所在分组配置
  PROCEDURE p_update_supplier_group_config(p_gc_rec scmdata.t_supplier_group_config%ROWTYPE);
  --修改所在品类
  PROCEDURE p_update_supp_group_category(p_gc_rec scmdata.t_supplier_group_category_config%ROWTYPE);
  --修改所在区域
  PROCEDURE p_update_supp_group_area(p_gc_rec scmdata.t_supplier_group_area_config%ROWTYPE);

  --Delete
  --删除所在分组配置
  PROCEDURE p_delete_supplier_group_config(p_group_config_id VARCHAR2,
                                           p_company_id      VARCHAR2);
  --删除所属品类
  PROCEDURE p_delete_supp_group_category(p_group_config_id VARCHAR2,
                                         p_company_id      VARCHAR2,
                                         p_gc_config_id    VARCHAR2);
  --删除所属区域
  PROCEDURE p_delete_supp_group_area(p_company_id   VARCHAR2,
                                     p_gc_config_id VARCHAR2);
  --Status
  --p_field:pause 启停  区域配置
  PROCEDURE p_pause_area_config(p_company_id           VARCHAR2,
                                p_group_area_config_id VARCHAR2,
                                p_field                VARCHAR2,
                                p_user_id              VARCHAR2,
                                p_status               NUMBER);
  --p_field:pause 启停  所在分组配置
  --p_field:config_status 提交 使所在分组 配置生效                                       
  --启停所在分组配置
  PROCEDURE p_pause_group_config(p_company_id      VARCHAR2,
                                 p_group_config_id VARCHAR2,
                                 p_field           VARCHAR2,
                                 p_user_id         VARCHAR2,
                                 p_status          NUMBER);

  --p_field:pause 
  --启停  品类、区域配置
  PROCEDURE p_pause_group_cate(p_company_id               VARCHAR2,
                               p_group_category_config_id VARCHAR2,
                               p_field                    VARCHAR2,
                               p_user_id                  VARCHAR2,
                               p_status                   NUMBER);
  --校验生效期间
  FUNCTION f_check_effective_time(p_company_id      VARCHAR2,
                                  p_group_config_id VARCHAR2,
                                  p_effective_time  DATE,
                                  p_end_time        DATE,
                                  p_group_name      VARCHAR2,
                                  p_group_leader    VARCHAR2) RETURN NUMBER;
  --校验品类\区域配置                                
  PROCEDURE p_check_cate_area_config(p_gc_rec scmdata.t_supplier_group_category_config%ROWTYPE);

  --Check
  --校验所在分组配置 
  --在有效期间内（生效时间~失效时间），且状态为“正常”，所在分组名称不可重复，一个区域组长只属于一个分组；
  --有效期间内（生效时间~失效时间），且状态为“正常”，选择区域时，需剔除已选的区域，如：广州/汕头组已选了广东省广州市了，其他分组则不可选择广东省广州市；品类同理
  PROCEDURE check_supp_group_config_by_submit(p_gc_rec scmdata.t_supplier_group_config%ROWTYPE);
  --区域配置校验
  PROCEDURE p_check_area_config(p_gc_rec scmdata.t_supplier_group_area_config%ROWTYPE);
  --校验合作分类，生产类别不可重复
  PROCEDURE p_check_coop_scope(p_gc_rec scmdata.t_supplier_group_category_config%ROWTYPE);
  -------------------------------czh add 所在分组配置  end --------------------------------

END pkg_a_config_lib;
/
CREATE OR REPLACE PACKAGE BODY pkg_a_config_lib IS

  FUNCTION f_is_cate_repeat_by_tableacompany(pi_company_id              VARCHAR2,
                                             pi_table_name              VARCHAR2,
                                             pi_industry_classification VARCHAR2,
                                             pi_production_category     VARCHAR2,
                                             pi_new_id                  VARCHAR2,
                                             pi_key_name                VARCHAR2,
                                             pi_model_field_name        VARCHAR2,
                                             pi_model_id_name           VARCHAR2,
                                             pi_model_table_name        VARCHAR2)
    RETURN VARCHAR2 IS
    p_sql        VARCHAR2(400);
    p_model_name VARCHAR2(100);
  BEGIN
    p_sql := 'select max(' || pi_model_id_name || ')
     from ' || pi_table_name || ' a
    where a.' || pi_key_name || '<> ''' || pi_new_id || '''
      and a.company_id = ''' || pi_company_id || '''
      and a.industry_classification = ''' ||
             pi_industry_classification || '''
      and a.production_category = ''' || pi_production_category || '''';
    /*p_sql := ' select max(:pi_model_id_name)
     from :pi_table_name a
    where a.:pi_key_name <> :pi_new_id
      and a.company_id = :pi_company_id
      and a.industry_classification = :pi_industry_classification
      and a.production_category = :pi_production_category';
     execute immediate p_sql
       into p_model_name
       using pi_model_id_name, pi_table_name, pi_key_name, pi_new_id, pi_company_id, pi_industry_classification, pi_production_category;*/
    EXECUTE IMMEDIATE p_sql
      INTO p_model_name;
    IF p_model_name IS NOT NULL THEN
      p_sql := 'select max(' || pi_model_field_name || ') from ' ||
               pi_model_table_name || ' where ' || pi_model_id_name ||
               '=''' || p_model_name || '''';
      EXECUTE IMMEDIATE p_sql
        INTO p_model_name;
    END IF;
    RETURN p_model_name;
  
  END f_is_cate_repeat_by_tableacompany;

  PROCEDURE p_check_cate_repeat_by_tableacompany(pi_company_id              IN VARCHAR2,
                                                 pi_table_name              IN VARCHAR2,
                                                 pi_industry_classification IN VARCHAR2,
                                                 pi_production_category     IN VARCHAR2,
                                                 pi_new_id                  IN VARCHAR2,
                                                 pi_key_name                IN VARCHAR2,
                                                 pi_model_field_name        IN VARCHAR2,
                                                 pi_model_id_name           IN VARCHAR2,
                                                 pi_model_table_name        IN VARCHAR2) IS
    p_model_name  VARCHAR2(100);
    p_coo_clasi   VARCHAR2(100);
    p_coo_product VARCHAR2(100);
  BEGIN
    p_model_name := f_is_cate_repeat_by_tableacompany(pi_company_id,
                                                      pi_table_name,
                                                      pi_industry_classification,
                                                      pi_production_category,
                                                      pi_new_id,
                                                      pi_key_name,
                                                      pi_model_field_name,
                                                      pi_model_id_name,
                                                      pi_model_table_name);
    IF p_model_name IS NOT NULL THEN
      SELECT MAX(group_dict_name)
        INTO p_coo_clasi
        FROM sys_group_dict
       WHERE group_dict_value = pi_industry_classification
         AND group_dict_type = 'PRODUCT_TYPE';
      SELECT MAX(group_dict_name)
        INTO p_coo_product
        FROM sys_group_dict
       WHERE group_dict_value = pi_production_category
         AND group_dict_type = pi_industry_classification;
      raise_application_error(-20002,
                              '类别' || p_coo_clasi || p_coo_product || '已被' ||
                              p_model_name || '占用，请检查！');
    END IF;
  END p_check_cate_repeat_by_tableacompany;

  --判断某个表的生产类别是否有重复，需要company_id,无需返回模型名称
  FUNCTION f_is_cate_repeat_without_model(pi_company_id              VARCHAR2,
                                          pi_table_name              VARCHAR2,
                                          pi_industry_classification VARCHAR2,
                                          pi_production_category     VARCHAR2,
                                          pi_new_id                  VARCHAR2,
                                          pi_key_name                VARCHAR)
    RETURN NUMBER IS
    p_sql VARCHAR2(400);
    p_i   INT;
  BEGIN
    p_sql := 'select nvl(max(1),0)
     from ' || pi_table_name || ' a
    where a.' || pi_key_name || '<> ''' || pi_new_id || '''
      and a.company_id = ''' || pi_company_id || '''
      and a.industry_classification = ''' ||
             pi_industry_classification || '''
      and a.production_category = ''' || pi_production_category || '''';
    EXECUTE IMMEDIATE p_sql
      INTO p_i;
    RETURN p_i;
  END f_is_cate_repeat_without_model;

  --判断某个表的生产类别是否有重复，需要company_id,无需返回模型名称   ，如果重复，抛出错误      
  PROCEDURE p_check_cate_repeat_without_model(pi_company_id              IN VARCHAR2,
                                              pi_table_name              IN VARCHAR2,
                                              pi_industry_classification IN VARCHAR2,
                                              pi_production_category     IN VARCHAR2,
                                              pi_new_id                  IN VARCHAR2,
                                              pi_key_name                IN VARCHAR2) IS
    p_i           INT;
    p_coo_clasi   VARCHAR2(100);
    p_coo_product VARCHAR2(100);
  BEGIN
    p_i := f_is_cate_repeat_without_model(pi_company_id,
                                          pi_table_name,
                                          pi_industry_classification,
                                          pi_production_category,
                                          pi_new_id,
                                          pi_key_name);
    IF p_i = 1 THEN
      SELECT MAX(group_dict_name)
        INTO p_coo_clasi
        FROM sys_group_dict
       WHERE group_dict_value = pi_industry_classification
         AND group_dict_type = 'PRODUCT_TYPE';
      SELECT MAX(group_dict_name)
        INTO p_coo_product
        FROM sys_group_dict
       WHERE group_dict_value = pi_production_category
         AND group_dict_type = pi_industry_classification;
      raise_application_error(-20002,
                              '类别' || p_coo_clasi || p_coo_product ||
                              '重复，请检查！');
    END IF;
  END p_check_cate_repeat_without_model;

  PROCEDURE p_check_cate_repeat_deduction_v2(pi_company_id              IN VARCHAR2,
                                             pi_config_id               IN VARCHAR2,
                                             pi_industry_classification IN VARCHAR2,
                                             pi_production_category     IN VARCHAR2,
                                             pi_product_subclass        IN VARCHAR2,
                                             pi_new_id                  IN VARCHAR2) IS
    p_model_name INT;
  BEGIN
    SELECT nvl(MAX(1), 0)
      INTO p_model_name
      FROM scmdata.t_deduction_range_config a
     WHERE a.deduction_range_config_id <> pi_new_id
       AND a.deduction_config_id = pi_config_id
       AND a.company_id = pi_company_id
       AND a.industry_classification = pi_industry_classification
       AND a.production_category = pi_production_category;
    IF p_model_name = 1 THEN
      raise_application_error(-20002,
                              '保存失败，已存在相同的分类及生产类别，请检查');
    END IF;
    SELECT nvl(MAX(1), 0)
      INTO p_model_name
      FROM scmdata.t_deduction_range_config a
     WHERE a.deduction_range_config_id <> pi_new_id
       AND a.deduction_config_id <> pi_config_id
       AND a.company_id = pi_company_id
       AND a.industry_classification = pi_industry_classification
       AND a.production_category = pi_production_category
       AND regexp_like(pi_product_subclass || ';',
                       REPLACE(a.product_subclass, ';', ';|'));
    IF p_model_name = 1 THEN
      raise_application_error(-20002,
                              '保存失败，其他模型已存在相同的分类、生产类别及产品子类，请检查！');
    END IF;
  
  END p_check_cate_repeat_deduction_v2;

  PROCEDURE p_check_cate_repeat_abnormal_v2(pi_company_id              IN VARCHAR2,
                                            pi_config_id               IN VARCHAR2,
                                            pi_industry_classification IN VARCHAR2,
                                            pi_production_category     IN VARCHAR2,
                                            pi_product_subclass        IN VARCHAR2,
                                            pi_new_id                  IN VARCHAR2) IS
    p_model_name INT;
  BEGIN
    SELECT nvl(MAX(1), 0)
      INTO p_model_name
      FROM scmdata.t_abnormal_range_config a
     WHERE a.abnormal_range_config_id <> pi_new_id
       AND a.abnormal_config_id = pi_config_id
       AND a.company_id = pi_company_id
       AND a.industry_classification = pi_industry_classification
       AND a.production_category = pi_production_category;
    IF p_model_name = 1 THEN
      raise_application_error(-20002,
                              '保存失败，已存在相同的分类及生产类别，请检查');
    END IF;
    SELECT nvl(MAX(1), 0)
      INTO p_model_name
      FROM scmdata.t_abnormal_range_config a
     WHERE a.abnormal_range_config_id <> pi_new_id
       AND a.abnormal_config_id <> pi_config_id
       AND a.company_id = pi_company_id
       AND a.industry_classification = pi_industry_classification
       AND a.production_category = pi_production_category
       AND regexp_like(pi_product_subclass || ';',
                       REPLACE(a.product_subclass, ';', ';|'));
    IF p_model_name = 1 THEN
      raise_application_error(-20002,
                              '保存失败，其他模型已存在相同的分类、生产类别及产品子类，请检查！');
    END IF;
  
  END p_check_cate_repeat_abnormal_v2;

  PROCEDURE p_check_cate_repeat_progress_v2(pi_company_id              IN VARCHAR2,
                                            pi_config_id               IN VARCHAR2,
                                            pi_industry_classification IN VARCHAR2,
                                            pi_production_category     IN VARCHAR2,
                                            pi_product_subclass        IN VARCHAR2,
                                            pi_new_id                  IN VARCHAR2) IS
    p_model_name INT;
  BEGIN
    SELECT nvl(MAX(1), 0)
      INTO p_model_name
      FROM scmdata.t_progress_range_config a
     WHERE a.progress_range_config_id <> pi_new_id
       AND a.progress_config_id = pi_config_id
       AND a.company_id = pi_company_id
       AND a.industry_classification = pi_industry_classification
       AND a.production_category = pi_production_category;
    IF p_model_name = 1 THEN
      raise_application_error(-20002,
                              '保存失败，已存在相同的分类及生产类别，请检查');
    END IF;
    SELECT nvl(MAX(1), 0)
      INTO p_model_name
      FROM scmdata.t_progress_range_config a
     WHERE a.progress_range_config_id <> pi_new_id
       AND a.progress_config_id <> pi_config_id
       AND a.company_id = pi_company_id
       AND a.industry_classification = pi_industry_classification
       AND a.production_category = pi_production_category
       AND regexp_like(pi_product_subclass || ';',
                       REPLACE(a.product_subclass, ';', ';|'));
  
    IF p_model_name = 1 THEN
      raise_application_error(-20002,
                              '保存失败，其他模型已存在相同的分类、生产类别及产品子类，请检查！');
    END IF;
  
  END p_check_cate_repeat_progress_v2;

  --重算某个生产进度的模板下的生产模板配置
  PROCEDURE p_recalculate_node_order_num(pi_progress_config_id IN VARCHAR2) IS
    p_i INT;
  BEGIN
    p_i := 0;
    FOR x IN (SELECT *
                FROM scmdata.t_progress_node_config
               WHERE progress_config_id = pi_progress_config_id
               ORDER BY progress_node_num) LOOP
      p_i := p_i + 1;
      UPDATE scmdata.t_progress_node_config a
         SET a.progress_node_num = p_i
       WHERE a.progress_node_config_id = x.progress_node_config_id;
    END LOOP;
  END;

  --查看模板名称是否重复
  PROCEDURE p_check_model_name_repeat_progress(pi_company_id IN VARCHAR2,
                                               pi_config_id  IN VARCHAR2,
                                               pi_model_name IN VARCHAR2) IS
    p_i INT;
  BEGIN
    SELECT nvl(MAX(1), 0)
      INTO p_i
      FROM scmdata.t_progress_config a
     WHERE a.company_id = pi_company_id
       AND a.progress_config_id <> pi_config_id
       AND a.progress_config_name = pi_model_name;
    IF p_i = 1 THEN
      raise_application_error(-20002, '已存在相同的节点模版名称，请检查！');
    END IF;
  END p_check_model_name_repeat_progress;

  PROCEDURE p_check_model_name_repeat_abnormal(pi_company_id IN VARCHAR2,
                                               pi_config_id  IN VARCHAR2,
                                               pi_model_name IN VARCHAR2) IS
    p_i INT;
  BEGIN
    SELECT nvl(MAX(1), 0)
      INTO p_i
      FROM scmdata.t_abnormal_config a
     WHERE a.company_id = pi_company_id
       AND a.abnormal_config_id <> pi_config_id
       AND a.abnormal_name = pi_model_name;
    IF p_i = 1 THEN
      raise_application_error(-20002, '已存在相同的节点模版名称，请检查！');
    END IF;
  END p_check_model_name_repeat_abnormal;

  PROCEDURE p_check_model_name_repeat_deduction(pi_company_id IN VARCHAR2,
                                                pi_config_id  IN VARCHAR2,
                                                pi_model_name IN VARCHAR2) IS
    p_i INT;
  BEGIN
    SELECT nvl(MAX(1), 0)
      INTO p_i
      FROM scmdata.t_deduction_config a
     WHERE a.company_id = pi_company_id
       AND a.deduction_config_id <> pi_config_id
       AND a.deduction_name = pi_model_name;
    IF p_i = 1 THEN
      raise_application_error(-20002, '已存在相同的节点模版名称，请检查！');
    END IF;
  END p_check_model_name_repeat_deduction;

  -------------------------------czh add 所在分组配置--------------------------------
  --Query
  --1.所在分组
  --查询所在分组配置
  FUNCTION f_query_supplier_group_config(p_company_id VARCHAR2) RETURN CLOB IS
    v_query_sql CLOB;
  BEGIN
    v_query_sql := q'[WITH company_user AS
 (SELECT fu.company_id, fu.user_id, fu.nick_name
    FROM scmdata.sys_company_user fu)
SELECT t.group_config_id,
       --decode(t.config_status, 1, '是', '否') config_status,
       decode(t.pause, 1, '正常', '停用') pause_desc,
       t.effective_time,
       t.end_time end_time_gp,
       t.group_name,
       t.area_group_leader AREA_GROUP_LEADER,
       t.remarks,
       a.nick_name create_id,
       t.create_time,
       b.nick_name update_id,
       t.update_time,
       t.company_id
  FROM scmdata.t_supplier_group_config t
 INNER JOIN company_user a
    ON t.company_id = a.company_id
   AND t.create_id = a.user_id
 INNER JOIN company_user b
    ON t.company_id = b.company_id
   AND t.update_id = b.user_id     
     WHERE t.company_id = ']' || p_company_id || q'[']';
    RETURN v_query_sql;
  END f_query_supplier_group_config;

  --查询品类、区域配置
  FUNCTION f_query_supp_group_category(p_company_id      VARCHAR2,
                                       p_group_config_id VARCHAR2)
    RETURN CLOB IS
    v_query_sql CLOB;
  BEGIN
    /*    (SELECT listagg(DISTINCT dp.province || dc.city, ';')
    FROM scmdata.dic_province dp
      INNER JOIN scmdata.dic_city dc
        ON dc.provinceid = to_char(dp.provinceid)
          AND instr(t.city_id, dc.cityno) > 0
        WHERE instr(t.province_id, dp.provinceid) > 0
        GROUP BY t.province_id)*/
    v_query_sql := q'[WITH company_user AS
 (SELECT fu.company_id, fu.user_id, fu.nick_name
    FROM scmdata.sys_company_user fu),
group_dict AS
 (SELECT group_dict_type, group_dict_value, group_dict_name
    FROM scmdata.sys_group_dict)
SELECT t.group_category_config_id,
       t.company_id,
       t.group_config_id,
       decode(t.pause, 1, '正常', '停用') pause_desc,
       a.group_dict_name coop_cate_desc,
       t.cooperation_classification,
       (SELECT listagg(b.group_dict_name, ';')
                  FROM group_dict b
                 WHERE b.group_dict_type = a.group_dict_value
                   AND instr(t.cooperation_product_cate, b.group_dict_value) > 0) product_cate_desc,
       t.cooperation_product_cate,
       t.area_name  group_area,
       t.area_config_id ,
       t.remarks,
       a.nick_name create_id,
       t.create_time,
       b.nick_name update_id,
       t.update_time
  FROM scmdata.t_supplier_group_category_config t
 INNER JOIN company_user a
    ON t.company_id = a.company_id
   AND t.create_id = a.user_id
 INNER JOIN company_user b
    ON t.company_id = b.company_id
   AND t.update_id = b.user_id
  LEFT JOIN group_dict a
    ON a.group_dict_type = 'PRODUCT_TYPE'
   AND a.group_dict_value = t.cooperation_classification
 WHERE t.company_id = ']' || p_company_id || q'['
       AND t.group_config_id = ']' || p_group_config_id ||
                   q'[']';
    RETURN v_query_sql;
  END f_query_supp_group_category;

  --查询区域配置
  FUNCTION f_query_supp_group_area(p_company_id VARCHAR2) RETURN CLOB IS
    v_query_sql CLOB;
  BEGIN
    v_query_sql := q'[WITH company_user AS
 (SELECT fu.company_id, fu.user_id, fu.nick_name
    FROM scmdata.sys_company_user fu)
SELECT t.group_area_config_id,
       t.company_id,
       decode(t.pause, 1, '正常', '停用') pause_desc,
       t.area_name,
       t.is_nationwide,      
       (SELECT listagg(dp.province, ';')
          FROM scmdata.dic_province dp
         WHERE instr(t.province_id, dp.provinceid) > 0) province,
       t.is_province_allcity,
       t.group_area,
       t.province_id,
       t.city_id,
       t.pause,
       t.remarks,
       a.nick_name create_id,
       t.create_time,
       b.nick_name update_id,
       t.update_time
  FROM scmdata.t_supplier_group_area_config t
 INNER JOIN company_user a
    ON t.company_id = a.company_id
   AND t.create_id = a.user_id
 INNER JOIN company_user b
    ON t.company_id = b.company_id
   AND t.update_id = b.user_id
 WHERE t.company_id = ']' || p_company_id || q'['
 ORDER BY t.create_time ASC]';
    RETURN v_query_sql;
  END f_query_supp_group_area;

  --Query Picklist 
  --所属品类
  --意向合作分类
  FUNCTION f_query_category_picksql RETURN CLOB IS
    v_query_sql CLOB;
  BEGIN
    v_query_sql := q'[SELECT b.group_dict_name  COOP_CATE_DESC,
           b.group_dict_value cooperation_classification
      FROM sys_group_dict a
      LEFT JOIN sys_group_dict b
        ON a.group_dict_value = b.group_dict_type    
     WHERE a.group_dict_type = 'COOPERATION_TYPE']';
  
    RETURN v_query_sql;
  END f_query_category_picksql;

  --意向生产类别
  FUNCTION f_query_product_cate_picksql RETURN CLOB IS
    v_query_sql CLOB;
  BEGIN
    /*      AND NOT EXISTS
    (SELECT 1
             FROM scmdata.t_supplier_group_category_config t
            WHERE t.company_id = ']' || p_company_id || q'['
              AND t.cooperation_classification = b.group_dict_value
              AND t.pause = 1
              AND t.cooperation_product_cate = c.group_dict_value)*/
  
    v_query_sql := q'[SELECT c.group_dict_name  PRODUCT_CATE_DESC,
           c.group_dict_value cooperation_product_cate
      FROM sys_group_dict a
      LEFT JOIN sys_group_dict b
        ON a.group_dict_value = b.group_dict_type
      LEFT JOIN sys_group_dict c
        ON b.group_dict_value = c.group_dict_type
     WHERE a.group_dict_type = 'COOPERATION_TYPE' 
      AND b.group_dict_value = :cooperation_classification]';
  
    RETURN v_query_sql;
  END f_query_product_cate_picksql;

  --区域配置
  --省市
  FUNCTION f_query_area_picksql(p_type NUMBER, p_is_nationwide NUMBER)
    RETURN CLOB IS
    v_query_sql CLOB := NULL;
  BEGIN
    IF p_is_nationwide = 1 THEN
      raise_application_error(-20002,
                              '“是否全国”当前配置为“是”时，不可修改！');
    
    ELSE
      IF p_type = 1 THEN
        v_query_sql := q'[SELECT a.provinceid province_id,
           a.province,
           --0 is_nationwide,
           0 is_province_allcity
      FROM scmdata.dic_province a]';
      ELSIF p_type = 2 THEN
        v_query_sql := q'[SELECT a.provinceid province_id,
           b.cityno city_id,
           a.province,
           b.city,
           a.province || b.city group_area
      FROM scmdata.dic_province a
     INNER JOIN scmdata.dic_city b
        ON a.provinceid = b.provinceid
      WHERE instr(:province_id,a.provinceid)>0]';
      ELSE
        raise_application_error(-20002, '无此类型Picklist,请联系管理员！');
      END IF;
    END IF;
    RETURN v_query_sql;
  END f_query_area_picksql;
  --所属区域
  FUNCTION f_query_group_area_picksql RETURN CLOB IS
    v_query_sql CLOB;
  BEGIN
    v_query_sql := q'[ SELECT t.area_name group_area, t.group_area_config_id area_config_id
  FROM scmdata.t_supplier_group_area_config t
 WHERE  t.pause = 1
   AND t.company_id = %default_company_id% ]';
  
    RETURN v_query_sql;
  END f_query_group_area_picksql;

  --Query Lookup
  --区域组长
  FUNCTION f_query_area_gl_leader(p_company_id VARCHAR2) RETURN CLOB IS
    v_query_sql CLOB;
  BEGIN
    v_query_sql := q'[SELECT d.dept_name,
           b.avatar,
           a.user_id           area_group_leader,
           a.company_user_name area_gl_desc
      FROM sys_company_user a
     INNER JOIN sys_user b
        ON a.user_id = b.user_id
      LEFT JOIN sys_company_user_dept c
        ON a.user_id = c.user_id
       AND a.company_id = c.company_id
      LEFT JOIN sys_company_dept d
        ON c.company_dept_id = d.company_dept_id
       AND c.company_id = d.company_id
     WHERE a.company_id = ']' || p_company_id || q'['
       AND a.pause = 0
       AND b.pause = 0]';
    RETURN v_query_sql;
  END f_query_area_gl_leader;

  --Insert
  --新增所在分组配置
  PROCEDURE p_insert_supplier_group_config(p_gc_rec scmdata.t_supplier_group_config%ROWTYPE) IS
  BEGIN
    --新增保存时校验，结束时间应大于生效时间
    IF p_gc_rec.end_time > p_gc_rec.effective_time THEN
      NULL;
    ELSE
      raise_application_error(-20002, '失效时间应大于生效时间！');
    END IF;
  
    INSERT INTO scmdata.t_supplier_group_config
      (group_config_id,
       group_name,
       area_group_leader,
       effective_time,
       end_time,
       config_status,
       pause,
       remarks,
       create_id,
       create_time,
       update_id,
       update_time,
       company_id)
    VALUES
      (p_gc_rec.group_config_id,
       p_gc_rec.group_name,
       p_gc_rec.area_group_leader,
       p_gc_rec.effective_time,
       p_gc_rec.end_time,
       nvl(p_gc_rec.config_status, 0),
       nvl(p_gc_rec.pause, 0),
       p_gc_rec.remarks,
       p_gc_rec.create_id,
       p_gc_rec.create_time,
       p_gc_rec.update_id,
       p_gc_rec.update_time,
       p_gc_rec.company_id);
  END p_insert_supplier_group_config;

  --新增所在品类
  PROCEDURE p_insert_supp_group_category(p_gc_rec scmdata.t_supplier_group_category_config%ROWTYPE) IS
  BEGIN
    IF p_gc_rec.cooperation_classification IS NULL OR
       p_gc_rec.cooperation_product_cate IS NULL OR
       p_gc_rec.area_name IS NULL THEN
      raise_application_error(-20002, '必填项不可为空！');
    END IF;
    --校验合作分类，生产类别不可重复
    p_check_coop_scope(p_gc_rec => p_gc_rec);
  
    INSERT INTO t_supplier_group_category_config
      (group_category_config_id,
       company_id,
       group_config_id,
       cooperation_classification,
       cooperation_product_cate,
       area_name,
       area_config_id,
       pause,
       remarks,
       create_id,
       create_time,
       update_id,
       update_time)
    VALUES
      (p_gc_rec.group_category_config_id,
       p_gc_rec.company_id,
       p_gc_rec.group_config_id,
       p_gc_rec.cooperation_classification,
       p_gc_rec.cooperation_product_cate,
       p_gc_rec.area_name,
       p_gc_rec.area_config_id,
       nvl(p_gc_rec.pause, 1),
       p_gc_rec.remarks,
       p_gc_rec.create_id,
       p_gc_rec.create_time,
       p_gc_rec.update_id,
       p_gc_rec.update_time);
  
  END p_insert_supp_group_category;

  --新增所在区域
  PROCEDURE p_insert_supp_group_area(p_gc_rec scmdata.t_supplier_group_area_config%ROWTYPE) IS
  BEGIN
    --区域配置校验
    p_check_area_config(p_gc_rec => p_gc_rec);
  
    INSERT INTO t_supplier_group_area_config
      (group_area_config_id,
       company_id,
       is_nationwide,
       is_province_allcity,
       area_name,
       province_id,
       city_id,
       group_area,
       pause,
       remarks,
       create_id,
       create_time,
       update_id,
       update_time)
    VALUES
      (p_gc_rec.group_area_config_id,
       p_gc_rec.company_id,
       p_gc_rec.is_nationwide,
       p_gc_rec.is_province_allcity,
       p_gc_rec.area_name,
       p_gc_rec.province_id,
       p_gc_rec.city_id,
       p_gc_rec.group_area,
       nvl(p_gc_rec.pause, 1),
       p_gc_rec.remarks,
       p_gc_rec.create_id,
       p_gc_rec.create_time,
       p_gc_rec.update_id,
       p_gc_rec.update_time);
  
  END p_insert_supp_group_area;

  --Update
  --修改所在分组配置
  PROCEDURE p_update_supplier_group_config(p_gc_rec scmdata.t_supplier_group_config%ROWTYPE) IS
  BEGIN
    --修改保存时校验，结束时间应大于生效时间
    IF p_gc_rec.end_time > p_gc_rec.effective_time THEN
      NULL;
    ELSE
      raise_application_error(-20002, '失效时间应大于生效时间！');
    END IF;
    UPDATE scmdata.t_supplier_group_config t
       SET t.group_name        = p_gc_rec.group_name,
           t.area_group_leader = p_gc_rec.area_group_leader,
           t.effective_time    = p_gc_rec.effective_time,
           t.end_time          = p_gc_rec.end_time,
           t.pause             = 0,
           t.remarks           = p_gc_rec.remarks,
           t.update_id         = p_gc_rec.update_id,
           t.update_time       = p_gc_rec.update_time
     WHERE t.group_config_id = p_gc_rec.group_config_id
       AND t.company_id = p_gc_rec.company_id;
  END p_update_supplier_group_config;

  --修改所在品类
  PROCEDURE p_update_supp_group_category(p_gc_rec scmdata.t_supplier_group_category_config%ROWTYPE) IS
  BEGIN
    IF p_gc_rec.cooperation_classification IS NULL OR
       p_gc_rec.cooperation_product_cate IS NULL OR
       p_gc_rec.area_name IS NULL THEN
      raise_application_error(-20002, '必填项不可为空！');
    END IF;
    --校验合作分类，生产类别不可重复
    p_check_coop_scope(p_gc_rec => p_gc_rec);
  
    UPDATE t_supplier_group_category_config t
       SET t.cooperation_classification = p_gc_rec.cooperation_classification,
           t.cooperation_product_cate   = p_gc_rec.cooperation_product_cate,
           t.area_name                  = p_gc_rec.area_name,
           t.area_config_id             = p_gc_rec.area_config_id,
           t.pause                      = nvl(p_gc_rec.pause, 1),
           t.remarks                    = p_gc_rec.remarks,
           t.update_id                  = p_gc_rec.update_id,
           t.update_time                = p_gc_rec.update_time
     WHERE t.company_id = p_gc_rec.company_id
       AND t.group_config_id = p_gc_rec.group_config_id
       AND t.group_category_config_id = p_gc_rec.group_category_config_id;
  
  END p_update_supp_group_category;

  --修改所在区域
  PROCEDURE p_update_supp_group_area(p_gc_rec scmdata.t_supplier_group_area_config%ROWTYPE) IS
  BEGIN
    --区域配置校验
    IF p_gc_rec.pause = 1 THEN
      p_check_area_config(p_gc_rec => p_gc_rec);
    ELSE
      NULL;
    END IF;
    UPDATE t_supplier_group_area_config t
       SET t.is_nationwide       = p_gc_rec.is_nationwide,
           t.is_province_allcity = p_gc_rec.is_province_allcity,
           t.area_name           = p_gc_rec.area_name,
           t.province_id         = p_gc_rec.province_id,
           t.city_id             = p_gc_rec.city_id,
           t.group_area          = p_gc_rec.group_area,
           --t.pause               = p_gc_rec.pause,
           t.remarks     = p_gc_rec.remarks,
           t.update_id   = p_gc_rec.update_id,
           t.update_time = p_gc_rec.update_time
     WHERE t.group_area_config_id = p_gc_rec.group_area_config_id
       AND t.company_id = p_gc_rec.company_id;
  
  END p_update_supp_group_area;

  --Delete
  --删除所在分组配置
  PROCEDURE p_delete_supplier_group_config(p_group_config_id VARCHAR2,
                                           p_company_id      VARCHAR2) IS
  BEGIN
  
    DELETE FROM scmdata.t_supplier_group_category_config t
     WHERE t.group_config_id = p_group_config_id
       AND t.company_id = p_company_id;
  
    DELETE FROM scmdata.t_supplier_group_config t
     WHERE t.group_config_id = p_group_config_id
       AND t.company_id = p_company_id;
  
  EXCEPTION
    WHEN OTHERS THEN
      sys_raise_app_error_pkg.is_running_error(p_is_running_error => 'T',
                                               p_is_log           => 1);
  END p_delete_supplier_group_config;

  --删除所属品类
  PROCEDURE p_delete_supp_group_category(p_group_config_id VARCHAR2,
                                         p_company_id      VARCHAR2,
                                         p_gc_config_id    VARCHAR2) IS
  BEGIN
    DELETE FROM scmdata.t_supplier_group_category_config t
     WHERE t.company_id = p_company_id
       AND t.group_config_id = p_group_config_id
       AND t.group_category_config_id = p_gc_config_id;
  EXCEPTION
    WHEN OTHERS THEN
      sys_raise_app_error_pkg.is_running_error(p_is_running_error => 'T',
                                               p_is_log           => 1);
  END p_delete_supp_group_category;

  --删除所属区域
  PROCEDURE p_delete_supp_group_area(p_company_id   VARCHAR2,
                                     p_gc_config_id VARCHAR2) IS
  BEGIN
    DELETE FROM scmdata.t_supplier_group_area_config t
     WHERE t.company_id = p_company_id
       AND t.group_area_config_id = p_gc_config_id;
  EXCEPTION
    WHEN OTHERS THEN
      sys_raise_app_error_pkg.is_running_error(p_is_running_error => 'T',
                                               p_is_log           => 1);
  END p_delete_supp_group_area;

  --Status
  --p_field:pause 启停  区域配置
  PROCEDURE p_pause_area_config(p_company_id           VARCHAR2,
                                p_group_area_config_id VARCHAR2,
                                p_field                VARCHAR2,
                                p_user_id              VARCHAR2,
                                p_status               NUMBER) IS
    v_where  VARCHAR2(4000);
    v_gc_rec scmdata.t_supplier_group_area_config%ROWTYPE;
  BEGIN
    IF p_status = 1 THEN
      SELECT *
        INTO v_gc_rec
        FROM scmdata.t_supplier_group_area_config t
       WHERE t.group_area_config_id = p_group_area_config_id
         AND t.company_id = p_company_id
         AND t.pause = 0;
      --区域配置校验
      p_check_area_config(p_gc_rec => v_gc_rec);
    END IF;
  
    v_where := q'[ where company_id = ']' || p_company_id ||
               q'[' and group_area_config_id  = ']' ||
               p_group_area_config_id || q'[']';
  
    EXECUTE IMMEDIATE 'begin           
  pkg_plat_comm.p_pause(p_table       => :t_supplier_group_area_config,
                        p_pause_field => :field,
                        p_where       => :p_where,
                        p_user_id     => :user_id,
                        p_status      => :status);
                        end;'
      USING 't_supplier_group_area_config', p_field, v_where, p_user_id, p_status;
  END p_pause_area_config;

  --p_field:pause 启停  所在分组配置
  --p_field:config_status 提交 使所在分组 配置生效
  PROCEDURE p_pause_group_config(p_company_id      VARCHAR2,
                                 p_group_config_id VARCHAR2,
                                 p_field           VARCHAR2,
                                 p_user_id         VARCHAR2,
                                 p_status          NUMBER) IS
    v_where  VARCHAR2(4000);
    p_gc_rec scmdata.t_supplier_group_category_config%ROWTYPE;
  BEGIN
    --校验 品类、区域配置
    IF p_status = 1 THEN
      FOR p_gc_rec IN (SELECT a.*
                         FROM scmdata.t_supplier_group_config t
                        INNER JOIN scmdata.t_supplier_group_category_config a
                           ON t.group_config_id = a.group_config_id
                          AND t.company_id = p_company_id
                        WHERE t.group_config_id = p_group_config_id
                          AND t.pause = 0
                          AND a.pause = 1) LOOP
        p_check_cate_area_config(p_gc_rec => p_gc_rec);
      END LOOP;
    END IF;
    v_where := q'[ where company_id = ']' || p_company_id ||
               q'[' and group_config_id = ']' || p_group_config_id ||
               q'[']';
  
    EXECUTE IMMEDIATE 'begin           
  pkg_plat_comm.p_pause(p_table       => :t_supplier_group_config,
                        p_pause_field => :field,
                        p_where       => :p_where,
                        p_user_id     => :user_id,
                        p_status      => :status);
                        end;'
      USING 't_supplier_group_config', p_field, v_where, p_user_id, p_status;
  END p_pause_group_config;

  --p_field:pause 
  --启停  品类、区域配置
  PROCEDURE p_pause_group_cate(p_company_id               VARCHAR2,
                               p_group_category_config_id VARCHAR2,
                               p_field                    VARCHAR2,
                               p_user_id                  VARCHAR2,
                               p_status                   NUMBER) IS
    v_where VARCHAR2(4000);
    --p_gc_rec scmdata.t_supplier_group_category_config%ROWTYPE;
  BEGIN
    --校验 品类、区域配置
    IF p_status = 1 THEN
      FOR p_gc_rec IN (SELECT *
                         FROM scmdata.t_supplier_group_category_config t
                        WHERE t.group_category_config_id =
                              p_group_category_config_id
                          AND t.company_id = p_company_id
                          AND t.pause = 0) LOOP
        p_check_cate_area_config(p_gc_rec => p_gc_rec);
      END LOOP;
    END IF;
  
    v_where := q'[ where company_id = ']' || p_company_id ||
               q'[' and group_category_config_id  = ']' ||
               p_group_category_config_id || q'[']';
  
    EXECUTE IMMEDIATE 'begin           
  pkg_plat_comm.p_pause(p_table       => :t_supplier_group_category_config,
                        p_pause_field => :field,
                        p_where       => :p_where,
                        p_user_id     => :user_id,
                        p_status      => :status);
                        end;'
      USING 't_supplier_group_category_config', p_field, v_where, p_user_id, p_status;
  
  END p_pause_group_cate;

  --校验生效期间
  FUNCTION f_check_effective_time(p_company_id      VARCHAR2,
                                  p_group_config_id VARCHAR2,
                                  p_effective_time  DATE,
                                  p_end_time        DATE,
                                  p_group_name      VARCHAR2,
                                  p_group_leader    VARCHAR2) RETURN NUMBER IS
    v_flag NUMBER;
  BEGIN
    SELECT COUNT(1)
      INTO v_flag
      FROM scmdata.t_supplier_group_config t
     WHERE t.company_id = p_company_id
       AND t.group_config_id <> p_group_config_id
       AND t.pause = 1
       AND EXISTS
     (SELECT 1
              FROM dual
             WHERE (((p_effective_time > t.effective_time AND
                   p_effective_time < t.end_time) OR
                   (p_end_time > t.effective_time AND
                   p_end_time < t.end_time)) OR
                   ((t.effective_time > p_effective_time AND
                   t.effective_time < p_end_time) OR
                   (t.end_time > p_effective_time AND
                   t.end_time < p_end_time)))
               AND (t.group_name = p_group_name OR
                   t.area_group_leader = p_group_leader));
    RETURN v_flag;
  END f_check_effective_time;

  --Check
  --校验品类\区域配置
  PROCEDURE p_check_cate_area_config(p_gc_rec scmdata.t_supplier_group_category_config%ROWTYPE) IS
    v_cate_num             NUMBER;
    v_cate_group_config_id VARCHAR2(4000);
    v_cate_group_name      VARCHAR2(4000);
    v_tips                 VARCHAR2(4000);
    v_effective_time       DATE;
    v_end_time             DATE;
  BEGIN
    --校验合作分类，生产类别不可重复
    p_check_coop_scope(p_gc_rec => p_gc_rec);
  
    SELECT MAX(a.effective_time), MAX(a.end_time)
      INTO v_effective_time, v_end_time
      FROM scmdata.t_supplier_group_config a
     WHERE a.group_config_id = p_gc_rec.group_config_id
       AND a.company_id = p_gc_rec.company_id;
  
    --品类、区域
    SELECT COUNT(1), listagg(t.group_config_id, ';')
      INTO v_cate_num, v_cate_group_config_id
      FROM scmdata.t_supplier_group_config a
     INNER JOIN scmdata.t_supplier_group_category_config t
        ON a.group_config_id = t.group_config_id
       AND a.company_id = t.company_id
     WHERE t.company_id = p_gc_rec.company_id
       AND t.group_category_config_id <> p_gc_rec.group_category_config_id
       AND instr_priv(t.cooperation_classification,
                      p_gc_rec.cooperation_classification) > 0
       AND instr_priv(t.cooperation_product_cate,
                      p_gc_rec.cooperation_product_cate) > 0
       AND instr_priv(t.area_config_id, p_gc_rec.area_config_id) > 0
       AND a.pause = 1
       AND t.pause = 1
       AND EXISTS
     (SELECT 1
              FROM dual
             WHERE (((v_effective_time BETWEEN a.effective_time AND
                   a.end_time) OR
                   (v_end_time BETWEEN a.effective_time AND a.end_time)) OR
                   ((a.effective_time BETWEEN v_effective_time AND
                   v_end_time) OR
                   (a.end_time BETWEEN v_effective_time AND v_end_time))));
  
    IF v_cate_num > 0 THEN
      SELECT listagg(t.group_name, ';')
        INTO v_cate_group_name
        FROM scmdata.t_supplier_group_config t
       WHERE instr(v_cate_group_config_id, t.group_config_id) > 0
         AND t.pause = 1;
      v_tips := '当前分类+生产类别+所在区域已存在分组：[' || v_cate_group_name || '],请检查！！';
      raise_application_error(-20002, v_tips);
    ELSE
      NULL;
    END IF;
  END p_check_cate_area_config;

  --校验所在分组配置 
  --在有效期间内（生效时间~失效时间），且状态为“正常”，所在分组名称不可重复，一个区域组长只属于一个分组；
  --有效期间内（生效时间~失效时间），且状态为“正常”，选择区域时，需剔除已选的区域，如：广州/汕头组已选了广东省广州市了，其他分组则不可选择广东省广州市；品类同理
  PROCEDURE check_supp_group_config_by_submit(p_gc_rec scmdata.t_supplier_group_config%ROWTYPE) IS
    v_flag NUMBER;
  BEGIN
    IF p_gc_rec.pause = 0 THEN
      IF p_gc_rec.end_time > p_gc_rec.effective_time THEN
        SELECT COUNT(1)
          INTO v_flag
          FROM scmdata.t_supplier_group_config a
         WHERE a.company_id = p_gc_rec.company_id
           AND a.group_config_id <> p_gc_rec.group_config_id
           AND a.pause = 1
           AND EXISTS
         (SELECT 1
                  FROM dual
                 WHERE (((p_gc_rec.effective_time BETWEEN a.effective_time AND
                       a.end_time) OR (p_gc_rec.end_time BETWEEN
                       a.effective_time AND a.end_time)) OR
                       ((a.effective_time BETWEEN p_gc_rec.effective_time AND
                       p_gc_rec.end_time) OR
                       (a.end_time BETWEEN p_gc_rec.effective_time AND
                       p_gc_rec.end_time)))
                   AND (a.group_name = p_gc_rec.group_name OR
                       a.area_group_leader = p_gc_rec.area_group_leader));
      
        IF v_flag > 0 THEN
          raise_application_error(-20002,
                                  '在有效期间内(生效时间~失效时间),且状态为“正常”,所在分组名称/区域组长不可重复!');
        ELSE
          NULL;
        END IF;
      ELSE
        raise_application_error(-20002, '失效时间应大于生效时间！');
      END IF;
    ELSE
      raise_application_error(-20002, '该配置已启用，不可重复操作！');
    END IF;
  
  END check_supp_group_config_by_submit;

  --区域配置校验
  PROCEDURE p_check_area_config(p_gc_rec scmdata.t_supplier_group_area_config%ROWTYPE) IS
    v_flag NUMBER;
  BEGIN
    --1.校验区域名称不可重复
    SELECT COUNT(1)
      INTO v_flag
      FROM scmdata.t_supplier_group_area_config t
     WHERE t.company_id = p_gc_rec.company_id
       AND t.group_area_config_id <> p_gc_rec.group_area_config_id
       AND t.pause = 1
       AND t.area_name = p_gc_rec.area_name;
    IF v_flag > 0 THEN
      raise_application_error(-20002, '区域名称不可重复！');
    END IF;
    --所在分组配置-区域配置为全国时，状态=“正常“时，需要校验不可重复
    IF p_gc_rec.is_nationwide = 1 THEN
      SELECT COUNT(1)
        INTO v_flag
        FROM scmdata.t_supplier_group_area_config t
       WHERE t.company_id = p_gc_rec.company_id
         AND t.group_area_config_id <> p_gc_rec.group_area_config_id
         AND t.pause = 1
         AND t.is_nationwide = p_gc_rec.is_nationwide;
    
      IF v_flag > 0 THEN
        raise_application_error(-20002,
                                '是否全国=“是”时，省份不可与其他组重复! ');
      END IF;
    ELSE
      IF p_gc_rec.is_province_allcity = 0 THEN
        --2.是否所有省/市=“部分”时,状态=“正常”，省份+区域不可与其他组是否所有省/市=“部分”的省份+区域重复；
        SELECT COUNT(1)
          INTO v_flag
          FROM scmdata.t_supplier_group_area_config t
         WHERE t.company_id = p_gc_rec.company_id
           AND t.group_area_config_id <> p_gc_rec.group_area_config_id
           AND t.pause = 1
           AND t.is_nationwide = p_gc_rec.is_nationwide
           AND t.is_province_allcity = p_gc_rec.is_province_allcity
           AND instr_priv(p_gc_rec.province_id, t.province_id) > 0
           AND instr_priv(p_gc_rec.city_id, t.city_id) > 0;
      
        IF v_flag > 0 THEN
          raise_application_error(-20002,
                                  '所有省份/市=“否”时，省份+所在区域不可与其他组重复！');
        END IF;
      ELSIF p_gc_rec.is_province_allcity = 1 THEN
        --3.是否所有省/市=“全部”时,状态=“正常”，省份+区域不可与其他组是否所有省/市=“否”的省份+区域重复；
        SELECT COUNT(1)
          INTO v_flag
          FROM scmdata.t_supplier_group_area_config t
         WHERE t.company_id = p_gc_rec.company_id
           AND t.group_area_config_id <> p_gc_rec.group_area_config_id
           AND t.pause = 1
           AND t.is_nationwide = p_gc_rec.is_nationwide
           AND t.is_province_allcity = p_gc_rec.is_province_allcity
           AND instr_priv(p_gc_rec.province_id, t.province_id) > 0;
      
        IF v_flag > 0 THEN
          raise_application_error(-20002,
                                  '所有省份/市=“是”时，省份不可与其他组重复! ');
        END IF;
      ELSE
        NULL;
      END IF;
    END IF;
  
  END p_check_area_config;
  --校验合作分类，生产类别不可重复
  PROCEDURE p_check_coop_scope(p_gc_rec scmdata.t_supplier_group_category_config%ROWTYPE) IS
    v_flag NUMBER;
  BEGIN
    SELECT COUNT(1)
      INTO v_flag
      FROM scmdata.t_supplier_group_config a
     INNER JOIN scmdata.t_supplier_group_category_config t
        ON a.group_config_id = t.group_config_id
       AND a.company_id = t.company_id
     WHERE a.company_id = p_gc_rec.company_id
       AND a.group_config_id = p_gc_rec.group_config_id
       AND t.group_category_config_id <> p_gc_rec.group_category_config_id
       AND instr_priv(t.cooperation_classification,
                      p_gc_rec.cooperation_classification) > 0
       AND instr_priv(t.cooperation_product_cate,
                      p_gc_rec.cooperation_product_cate) > 0
       AND t.pause = 1;
  
    IF v_flag > 0 THEN
      raise_application_error(-20002,
                              '合作分类、可生产类别，已经存在，请重新填写！');
    ELSE
      NULL;
    END IF;
  END p_check_coop_scope;

END pkg_a_config_lib;
/
