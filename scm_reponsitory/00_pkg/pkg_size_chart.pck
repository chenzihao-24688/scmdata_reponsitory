CREATE OR REPLACE PACKAGE SCMDATA.pkg_size_chart IS

  -- Author  : SANFU
  -- Created : 2022/9/23 14:08:00
  -- Purpose : 尺寸表(商品档案尺寸表)

  --查询T_SIZE_CHART_TMP
  FUNCTION f_query_t_size_chart_tmp RETURN CLOB;
  --新增T_SIZE_CHART_TMP
  PROCEDURE p_insert_t_size_chart_tmp(p_t_siz_rec t_size_chart_tmp%ROWTYPE);

  --修改T_SIZE_CHART_TMP
  PROCEDURE p_update_t_size_chart_tmp(p_t_siz_rec t_size_chart_tmp%ROWTYPE);

  --删除尺寸临时表行数据
  PROCEDURE p_delete_t_size_chart_tmp(p_size_chart_tmp_id VARCHAR2);
  --删除T_SIZE_CHART_TMP
  PROCEDURE p_delete_t_size_chart_tmp(p_company_id VARCHAR2,
                                      p_goo_id     VARCHAR2);
  --删除 所有尺寸表临时数据
  PROCEDURE p_delete_t_size_chart_all_tmp_data(p_company_id VARCHAR2,
                                               p_goo_id     VARCHAR2);
  --校验商品档案/批版列表 尺寸表、临时表部位唯一
  PROCEDURE p_check_size_chart_by_save(p_table      VARCHAR2,
                                       p_company_id VARCHAR2,
                                       p_goo_id     VARCHAR2,
                                       p_position   VARCHAR2);
  --尺寸临时表删除校验
  PROCEDURE p_check_size_chart_tmp_by_delete(p_company_id VARCHAR2,
                                             p_goo_id     VARCHAR2);
  --校验是否有选择模板生成的数据
  PROCEDURE p_check_is_has_size_chart_moudle_data(p_company_id VARCHAR2,
                                                  p_goo_id     VARCHAR2);
  --查询 T_SIZE_CHART_DETAILS_TMP
  FUNCTION f_query_t_size_chart_dt_tmp(p_user_id    VARCHAR2,
                                       p_company_id VARCHAR2) RETURN CLOB;
  --新增 T_SIZE_CHART_DETAILS_TMP
  PROCEDURE p_insert_t_size_chart_dt_tmp(p_t_siz_rec t_size_chart_details_tmp%ROWTYPE);
  --修改 T_SIZE_CHART_DETAILS_TMP
  PROCEDURE p_update_t_size_chart_dt_tmp(p_t_siz_rec t_size_chart_details_tmp%ROWTYPE);
  --删除尺寸临时表(含尺码)行数据
  PROCEDURE p_delete_t_size_chart_dt_tmp(p_company_id          VARCHAR2,
                                         p_goo_id              VARCHAR2,
                                         p_position            VARCHAR2,
                                         p_quantitative_method VARCHAR2);
  --删除 T_SIZE_CHART_DETAILS_TMP
  PROCEDURE p_delete_t_size_chart_dt_tmp(p_company_id VARCHAR2,
                                         p_goo_id     VARCHAR2);

  --尺寸临时表（含尺码）删除校验
  PROCEDURE p_check_size_chart_dt_tmp_by_delete(p_company_id VARCHAR2,
                                                p_goo_id     VARCHAR2);
  --尺寸表模板校验
  PROCEDURE p_check_size_chart_moudle(p_goo_id     VARCHAR2,
                                      p_company_id VARCHAR2);
  --选择模板
  FUNCTION f_get_size_chart_moudle(p_goo_id     VARCHAR2,
                                   p_company_id VARCHAR2) RETURN CLOB;
  --获取尺码对应的企业字典ID
  FUNCTION f_get_size_company_dict(p_company_id VARCHAR2,
                                   p_size_name  VARCHAR2) RETURN VARCHAR2;
  --通过尺码类型获取尺码
  FUNCTION f_get_size_company_dict_by_type(p_company_id VARCHAR2,
                                           p_type       VARCHAR2) RETURN CLOB;
  --生成尺寸临时表
  PROCEDURE p_generate_size_chart_tmp(p_company_id        VARCHAR2,
                                      p_goo_id            VARCHAR2,
                                      p_user_id           VARCHAR2,
                                      p_size_chart_moudle VARCHAR2);
  --提交校验
  PROCEDURE p_check_size_chart_moudle_by_submit(p_goo_id     VARCHAR2,
                                                p_company_id VARCHAR2);
  --校验临时表尺码只能填数字
  PROCEDURE p_check_size_chart_by_update(p_measure_value VARCHAR2);

  --判断是否已存在尺寸表（临时表）数据
  FUNCTION f_check_is_has_size_chart_tmp_data(p_company_id          VARCHAR2,
                                              p_goo_id              VARCHAR2,
                                              p_position            VARCHAR2,
                                              p_quantitative_method VARCHAR2)
    RETURN INT;

  --根据模板的跳码规则，计算其他码数对应的尺码值
  FUNCTION f_get_size_by_jump_size_rule(p_company_id        VARCHAR2,
                                        p_size_chart_moudle VARCHAR2,
                                        p_position          VARCHAR2,
                                        p_size_name         VARCHAR2,
                                        p_base_size         NUMBER)
    RETURN NUMBER;

  --提交时，需根据基码+模板的跳码规则，计算其他码数对应的尺码值
  PROCEDURE p_generate_size_chart_dt_tmp(p_company_id VARCHAR2,
                                         p_goo_id     VARCHAR2,
                                         p_user_id    VARCHAR2);
  --判断是否存在尺寸表（业务表）
  FUNCTION f_check_is_has_size_chart(p_company_id VARCHAR2,
                                     p_goo_id     VARCHAR2) RETURN INT;
  --判断是否已存在尺寸表(业务表)数据
  FUNCTION f_check_is_has_size_chart_data(p_company_id          VARCHAR2,
                                          p_goo_id              VARCHAR2,
                                          p_position            VARCHAR2,
                                          p_quantitative_method VARCHAR2)
    RETURN INT;
  --查询T_SIZE_CHART
  FUNCTION f_query_t_size_chart RETURN CLOB;
  --新增T_SIZE_CHART
  PROCEDURE p_insert_t_size_chart(p_t_siz_rec scmdata.t_size_chart%ROWTYPE);
  --修改T_SIZE_CHART
  PROCEDURE p_update_t_size_chart(p_t_siz_rec scmdata.t_size_chart%ROWTYPE);
  --删除T_SIZE_CHART
  PROCEDURE p_delete_t_size_chart(p_t_siz_rec scmdata.t_size_chart%ROWTYPE);

  --新增T_SIZE_CHART_DETAILS
  PROCEDURE p_insert_t_size_chart_details(p_t_siz_rec scmdata.t_size_chart_details%ROWTYPE);
  --修改T_SIZE_CHART_DETAILS
  PROCEDURE p_update_t_size_chart_details(p_t_siz_rec scmdata.t_size_chart_details%ROWTYPE);
  --删除T_SIZE_CHART_DETAILS
  PROCEDURE p_delete_t_size_chart_details(p_t_siz_rec scmdata.t_size_chart_details%ROWTYPE);
  --删除尺寸表（业务表）行数据
  PROCEDURE p_delete_t_size_chart_row_data(p_company_id          VARCHAR2,
                                           p_goo_id              VARCHAR2,
                                           p_position            VARCHAR2,
                                           p_quantitative_method VARCHAR2);
  --删除尺寸表（业务表）所有数据
  PROCEDURE p_delete_t_size_chart_all_data(p_company_id VARCHAR2,
                                           p_goo_id     VARCHAR2);
  --提交校验必填项是否为空
  PROCEDURE p_check_size_chart_by_submit(p_company_id VARCHAR2,
                                         p_goo_id     VARCHAR2);
  --生成尺寸表（业务表）
  PROCEDURE p_generate_size_chart(p_company_id VARCHAR2, p_goo_id VARCHAR2);
  --尺寸表含尺码（业务表）删除校验
  PROCEDURE p_check_t_size_chart_by_delete(p_company_id VARCHAR2,
                                           p_goo_id     VARCHAR2);
  --商品档案生成尺寸表后同步更新至同货号批版单据
  PROCEDURE p_sync_gd_size_chart_to_apv(p_company_id VARCHAR2,
                                        p_goo_id     VARCHAR2);
  --尺寸表导入表 修改，删除校验
  PROCEDURE p_check_t_size_chart_import_tmp_by_update(p_seq_num NUMBER,
                                                      p_type    INT DEFAULT 0);

  --尺寸导入表 提交校验
  PROCEDURE p_check_t_size_chart_import_tmp_by_submit(p_company_id VARCHAR2,
                                                      p_goo_id     VARCHAR2,
                                                      p_type       INT DEFAULT 0);

  --判断是否已存在尺寸导入表 行数据
  FUNCTION f_check_is_has_size_chart_import_data(p_company_id          VARCHAR2,
                                                 p_goo_id              VARCHAR2,
                                                 p_position            VARCHAR2,
                                                 p_quantitative_method VARCHAR2)
    RETURN INT;

  /*============================================*
  * Author   : CZH
  * Created  : 23-9月 -22
  * ALERTER  :
  * ALERTER_TIME  :
  * Purpose  : 查询 t_size_chart_import_tmp
  * Obj_Name    : f_query_t_size_chart_import_tmp
  *============================================*/
  FUNCTION f_query_t_size_chart_import_tmp(p_company_id VARCHAR2,
                                           p_goo_id     VARCHAR2) RETURN CLOB;
  /*============================================*
  * Author   : CZH
  * Created  : 11-10月-22
  * ALERTER  :
  * ALERTER_TIME  :
  * Purpose  : 新增 t_size_chart_import_tmp
  * Obj_Name    : p_insert_t_size_chart_import_tmp
  *============================================*/
  PROCEDURE p_insert_t_size_chart_import_tmp(p_t_siz_rec scmdata.t_size_chart_import_tmp%ROWTYPE);

  /*============================================*
  * Author   : CZH
  * Created  : 11-10月-22
  * ALERTER  :
  * ALERTER_TIME  :
  * Purpose  : 修改 t_size_chart_import_tmp
  * Obj_Name    : p_update_t_size_chart_import_tmp
  *============================================*/
  PROCEDURE p_update_t_size_chart_import_tmp(p_t_siz_rec scmdata.t_size_chart_import_tmp%ROWTYPE);

  /*============================================*
  * Author   : CZH
  * Created  : 11-10月-22
  * ALERTER  :
  * ALERTER_TIME  :
  * Purpose  : 删除 t_size_chart_import_tmp
  * Obj_Name    : p_delete_t_size_chart_import_tmp
  *============================================*/
  PROCEDURE p_delete_t_size_chart_import_tmp(p_t_siz_rec scmdata.t_size_chart_import_tmp%ROWTYPE);
  /*============================================*
  * Author   : CZH
  * Created  : 11-10月-22
  * ALERTER  :
  * ALERTER_TIME  :
  * Purpose  : 新增t_size_chart_details_import_tmp
  * Obj_Name    : P_INSERT_t_size_chart_details_import_tmp
  *============================================*/
  PROCEDURE p_insert_t_size_chart_details_import_tmp(p_t_siz_rec scmdata.t_size_chart_details_import_tmp%ROWTYPE);

  /*============================================*
  * Author   : CZH
  * Created  : 11-10月-22
  * ALERTER  :
  * ALERTER_TIME  :
  * Purpose  : 修改t_size_chart_details_import_tmp
  * Obj_Name    : P_UPDATE_t_size_chart_details_import_tmp
  *============================================*/
  PROCEDURE p_update_t_size_chart_details_import_tmp(p_t_siz_rec scmdata.t_size_chart_details_import_tmp%ROWTYPE);

  /*============================================*
  * Author   : CZH
  * Created  : 11-10月-22
  * ALERTER  :
  * ALERTER_TIME  :
  * Purpose  : 删除t_size_chart_details_import_tmp
  * Obj_Name    : P_DELETE_t_size_chart_details_import_tmp
  *============================================*/
  PROCEDURE p_delete_t_size_chart_details_import_tmp(p_t_siz_rec scmdata.t_size_chart_details_import_tmp%ROWTYPE);

  --删除尺寸导入表行数据
  PROCEDURE p_delete_t_size_chart_import_tmp_row_data(p_company_id          VARCHAR2,
                                                      p_goo_id              VARCHAR2,
                                                      p_position            VARCHAR2,
                                                      p_quantitative_method VARCHAR2);

  --删除尺寸导入表 所有数据
  PROCEDURE p_delete_t_size_chart_import_tmp_all_data(p_company_id VARCHAR2,
                                                      p_goo_id     VARCHAR2);
  --删除尺寸导入表初始化生成的数据
  PROCEDURE p_delete_t_size_chart_import_first_generate_data(p_company_id VARCHAR2,
                                                             p_goo_id     VARCHAR2,
                                                             p_seq_num    INT);
  --根据商品档案-尺码表 初始化尺寸导入表
  PROCEDURE p_first_generate_size_chart_imp_tmp_data(p_company_id VARCHAR2,
                                                     p_goo_id     VARCHAR2,
                                                     p_user_id    VARCHAR2);

  --重置尺寸导入表
  PROCEDURE p_reset_size_chart_imp_tmp_data(p_company_id VARCHAR2,
                                            p_goo_id     VARCHAR2,
                                            p_user_id    VARCHAR2);

  --商品档案尺寸表导入，点提交生成数据至尺寸表（业务表）
  PROCEDURE p_generate_size_chart_by_good_import(p_company_id VARCHAR2,
                                                 p_goo_id     VARCHAR2);
  --批版尺寸表导入，点提交生成数据至尺寸表（业务表）
  PROCEDURE p_generate_size_chart_by_apv_import(p_company_id VARCHAR2,
                                                p_goo_id     VARCHAR2);
  --获取商品档案带入的尺码表类型
  --字母码，数字码
  FUNCTION f_get_good_size_chart_type(p_company_id VARCHAR2,
                                      p_goo_id     VARCHAR2) RETURN VARCHAR2;

  --尺寸表增加尺码列
  PROCEDURE p_insert_size_chart_col(p_company_id VARCHAR2,
                                    p_goo_id     VARCHAR2,
                                    p_user_id    VARCHAR2,
                                    p_size_col   VARCHAR2);

  --自动生成尺寸相关表序号
  FUNCTION f_get_size_chart_seq_num(p_company_id VARCHAR2,
                                    p_goo_id     VARCHAR2,
                                    p_table      VARCHAR2) RETURN NUMBER;
  --序号校验
  PROCEDURE p_check_new_seq_no(p_new_seq_num VARCHAR2);

  --序号重排
  --有序的尺寸表中插入或删除序号，并保持有序
  --5
  --1,2,3,4,5,6,7,8,9,10
  PROCEDURE p_reset_size_chart_seq_num(p_company_id    VARCHAR2,
                                       p_goo_id        VARCHAR2,
                                       p_orgin_seq_num NUMBER, --原序号
                                       p_new_seq_num   NUMBER DEFAULT NULL, --1）找要插入的位置 
                                       p_type          INT,
                                       p_table         VARCHAR2,
                                       p_table_pk_id   VARCHAR2,
                                       p_is_check      INT DEFAULT 0);

  --判断尺寸表数据行是否存在
  FUNCTION f_is_has_size_chart_row_data(p_company_id          VARCHAR2,
                                        p_goo_id              VARCHAR2,
                                        p_position            VARCHAR2,
                                        p_quantitative_method VARCHAR2,
                                        p_table               VARCHAR2)
    RETURN INT;
  --根据部位判断是否存在克重
  PROCEDURE p_is_has_grammage(p_company_id VARCHAR2,
                              p_goo_id     VARCHAR2,
                              p_table      VARCHAR2,
                              p_grammage   VARCHAR2 DEFAULT NULL,
                              p_type       INT DEFAULT 0);
  --克重新增判断
  PROCEDURE p_is_has_grammage_row_data(p_company_id          VARCHAR2,
                                       p_goo_id              VARCHAR2,
                                       p_position            VARCHAR2,
                                       p_quantitative_method VARCHAR2,
                                       p_table1              VARCHAR2,
                                       p_table2              VARCHAR2,
                                       p_table1_pk_id        VARCHAR2 DEFAULT 'size_chart_id');

END pkg_size_chart;
/

CREATE OR REPLACE PACKAGE BODY SCMDATA.pkg_size_chart IS
  /*============================================*
  * Author   : CZH
  * Created  : 23-9月 -22
  * ALERTER  :
  * ALERTER_TIME  :
  * Purpose  : 查询T_SIZE_CHART_TMP
  * Obj_Name    : F_QUERY_T_SIZE_CHART_TMP
  *============================================*/
  FUNCTION f_query_t_size_chart_tmp RETURN CLOB IS
    v_sql CLOB;
  BEGIN
    v_sql := 'SELECT t.size_chart_tmp_id,
       t.company_id,
       t.goo_id,
       LPAD(t.seq_num,2,''0'') seq_num,
       t.position,
       t.quantitative_method,
       t.base_code,
       t.base_value,
       abs(t.plus_toleran_range) plus_toleran_range,
       abs(t.negative_toleran_range) negative_toleran_range
  FROM t_size_chart_tmp t
 WHERE t.goo_id = :goo_id
   AND t.company_id = %default_company_id%
 ORDER BY t.seq_num ASC';
    RETURN v_sql;
  END f_query_t_size_chart_tmp;

  /*============================================*
  * Author   : CZH
  * Created  : 23-9月 -22
  * ALERTER  :
  * ALERTER_TIME  :
  * Purpose  : 新增T_SIZE_CHART_TMP
  * Obj_Name    : P_INSERT_T_SIZE_CHART_TMP
  *============================================*/
  PROCEDURE p_insert_t_size_chart_tmp(p_t_siz_rec t_size_chart_tmp%ROWTYPE) IS
  BEGIN
    --校验部位唯一性
    p_check_size_chart_by_save(p_table      => 't_size_chart_tmp',
                               p_company_id => p_t_siz_rec.company_id,
                               p_goo_id     => p_t_siz_rec.goo_id,
                               p_position   => p_t_siz_rec.position);
  
    INSERT INTO t_size_chart_tmp
      (size_chart_tmp_id, company_id, goo_id, seq_num, position,
       quantitative_method, base_code, base_value, plus_toleran_range,
       negative_toleran_range, pause, create_id, create_time, update_id,
       update_time, memo)
    VALUES
      (p_t_siz_rec.size_chart_tmp_id, p_t_siz_rec.company_id,
       p_t_siz_rec.goo_id, p_t_siz_rec.seq_num, p_t_siz_rec.position,
       p_t_siz_rec.quantitative_method, p_t_siz_rec.base_code,
       p_t_siz_rec.base_value, p_t_siz_rec.plus_toleran_range,
       p_t_siz_rec.negative_toleran_range, p_t_siz_rec.pause,
       p_t_siz_rec.create_id, p_t_siz_rec.create_time, p_t_siz_rec.update_id,
       p_t_siz_rec.update_time, p_t_siz_rec.memo);
  END p_insert_t_size_chart_tmp;

  /*============================================*
  * Author   : CZH
  * Created  : 23-9月 -22
  * ALERTER  :
  * ALERTER_TIME  :
  * Purpose  : 修改T_SIZE_CHART_TMP
  * Obj_Name    : P_UPDATE_T_SIZE_CHART_TMP
  *============================================*/
  PROCEDURE p_update_t_size_chart_tmp(p_t_siz_rec t_size_chart_tmp%ROWTYPE) IS
  BEGIN
    --校验部位唯一性
    p_check_size_chart_by_save(p_table      => 't_size_chart_tmp',
                               p_company_id => p_t_siz_rec.company_id,
                               p_goo_id     => p_t_siz_rec.goo_id,
                               p_position   => p_t_siz_rec.position);
  
    UPDATE t_size_chart_tmp t
       SET t.seq_num                = p_t_siz_rec.seq_num,
           t.position               = p_t_siz_rec.position,
           t.quantitative_method    = p_t_siz_rec.quantitative_method,
           t.base_code              = p_t_siz_rec.base_code,
           t.base_value             = p_t_siz_rec.base_value,
           t.plus_toleran_range     = p_t_siz_rec.plus_toleran_range,
           t.negative_toleran_range = p_t_siz_rec.negative_toleran_range,
           t.pause                  = p_t_siz_rec.pause,
           t.create_id              = p_t_siz_rec.create_id,
           t.create_time            = p_t_siz_rec.create_time,
           t.update_id              = p_t_siz_rec.update_id,
           t.update_time            = p_t_siz_rec.update_time,
           t.memo                   = p_t_siz_rec.memo
     WHERE t.size_chart_tmp_id = p_t_siz_rec.size_chart_tmp_id;
  END p_update_t_size_chart_tmp;

  --删除尺寸临时表行数据
  PROCEDURE p_delete_t_size_chart_tmp(p_size_chart_tmp_id VARCHAR2) IS
  BEGIN
    DELETE FROM t_size_chart_tmp t
     WHERE t.size_chart_tmp_id = p_size_chart_tmp_id;
  END p_delete_t_size_chart_tmp;

  /*============================================*
  * Author   : CZH
  * Created  : 23-9月 -22
  * ALERTER  :
  * ALERTER_TIME  :
  * Purpose  : 删除 T_SIZE_CHART_DETAILS_TMP
  * Obj_Name    : P_DELETE_T_SIZE_CHART_TMP
  *============================================*/
  PROCEDURE p_delete_t_size_chart_tmp(p_company_id VARCHAR2,
                                      p_goo_id     VARCHAR2) IS
  BEGIN
    DELETE FROM t_size_chart_tmp t
     WHERE t.company_id = p_company_id
       AND t.goo_id = p_goo_id;
  END p_delete_t_size_chart_tmp;

  /*============================================*
  * Author   : CZH
  * Created  : 23-9月 -22
  * ALERTER  :
  * ALERTER_TIME  :
  * Purpose  : 删除 所有尺寸表临时数据
  * Obj_Name    : P_DELETE_T_SIZE_CHART_TMP
  *============================================*/
  PROCEDURE p_delete_t_size_chart_all_tmp_data(p_company_id VARCHAR2,
                                               p_goo_id     VARCHAR2) IS
  BEGIN
  
    DELETE FROM scmdata.t_size_chart_details_tmp a
     WHERE a.size_chart_id IN
           (SELECT t.size_chart_tmp_id
              FROM t_size_chart_tmp t
             WHERE t.company_id = p_company_id
               AND t.goo_id = p_goo_id);
  
    DELETE FROM t_size_chart_tmp t
     WHERE t.company_id = p_company_id
       AND t.goo_id = p_goo_id;
  
  END p_delete_t_size_chart_all_tmp_data;

  --校验商品档案/批版列表 尺寸表、临时表部位唯一
  PROCEDURE p_check_size_chart_by_save(p_table      VARCHAR2,
                                       p_company_id VARCHAR2,
                                       p_goo_id     VARCHAR2,
                                       p_position   VARCHAR2) IS
    v_sql VARCHAR2(512);
    v_cnt INT;
  BEGIN
    v_sql := ' SELECT count(1) from scmdata.' || p_table ||
             ' t WHERE t.position = :position AND t.company_id = :company_id AND t.goo_id = :goo_id ';
    EXECUTE IMMEDIATE v_sql
      INTO v_cnt
      USING p_position, p_company_id, p_goo_id;
    IF v_cnt >= 1 THEN
      raise_application_error('-20002',
                              '部位【' || p_position || '】不可重复');
    ELSE
      NULL;
    END IF;
  END p_check_size_chart_by_save;

  --尺寸临时表删除校验
  PROCEDURE p_check_size_chart_tmp_by_delete(p_company_id VARCHAR2,
                                             p_goo_id     VARCHAR2) IS
    v_cnt INT;
  BEGIN
    SELECT COUNT(1)
      INTO v_cnt
      FROM t_size_chart_tmp t
     WHERE t.company_id = p_company_id
       AND t.goo_id = p_goo_id;
    IF v_cnt <= 1 THEN
      raise_application_error(-20002,
                              '不可删除所有数据，至少需存在一条数据');
    END IF;
  END p_check_size_chart_tmp_by_delete;

  --校验是否有选择模板生成的数据
  PROCEDURE p_check_is_has_size_chart_moudle_data(p_company_id VARCHAR2,
                                                  p_goo_id     VARCHAR2) IS
    v_flag INT;
  BEGIN
    SELECT COUNT(1)
      INTO v_flag
      FROM t_size_chart_tmp t
     WHERE t.company_id = p_company_id
       AND t.goo_id = p_goo_id;
    IF v_flag > 0 THEN
      NULL;
    ELSE
      raise_application_error(-20002, '不可新增，请先选择模板');
    END IF;
  END p_check_is_has_size_chart_moudle_data;

  /*============================================*
  * Author   : CZH
  * Created  : 23-9月 -22
  * ALERTER  :
  * ALERTER_TIME  :
  * Purpose  : 查询 T_SIZE_CHART_DETAILS_TMP
  * Obj_Name    : F_QUERY_T_SIZE_CHART_DT_TMP
  *============================================*/
  FUNCTION f_query_t_size_chart_dt_tmp(p_user_id    VARCHAR2,
                                       p_company_id VARCHAR2) RETURN CLOB IS
    v_sql    CLOB;
    v_goo_id VARCHAR2(32);
  BEGIN
    v_goo_id := scmdata.pkg_variable.f_get_varchar(v_objid   => p_user_id,
                                                   v_compid  => p_company_id,
                                                   v_varname => 'SIZE_CHART_GOO_ID');
  
    v_sql := 'SELECT t.size_chart_dt_tmp_id,
       a.size_chart_tmp_id,
       a.company_id,
       a.goo_id,
       LPAD(a.seq_num,2,''0'') seq_num,
       a.position,
       a.quantitative_method,
       a.base_code,
       a.base_value,
       abs(a.plus_toleran_range) plus_toleran_range,
       abs(a.negative_toleran_range) negative_toleran_range,
       b.company_dict_name measure,
       t.measure_value
  FROM scmdata.t_size_chart_tmp a
  INNER JOIN t_size_chart_details_tmp t
    ON t.size_chart_id = a.size_chart_tmp_id
  INNER JOIN scmdata.sys_company_dict b
    ON b.company_dict_id = t.measure
 WHERE a.goo_id = ''' || v_goo_id || '''
   AND a.company_id = ''' || p_company_id || '''
 ORDER BY a.seq_num ASC, b.company_dict_sort  ASC';
    RETURN v_sql;
  END f_query_t_size_chart_dt_tmp;

  /*============================================*
  * Author   : CZH
  * Created  : 23-9月 -22
  * ALERTER  :
  * ALERTER_TIME  :
  * Purpose  : 新增 T_SIZE_CHART_DETAILS_TMP
  * Obj_Name    : P_INSERT_T_SIZE_CHART_DT_TMP
  *============================================*/
  PROCEDURE p_insert_t_size_chart_dt_tmp(p_t_siz_rec t_size_chart_details_tmp%ROWTYPE) IS
  BEGIN
    INSERT INTO t_size_chart_details_tmp
      (size_chart_dt_tmp_id, size_chart_id, measure, measure_value, pause,
       create_id, create_time, update_id, update_time, memo)
    VALUES
      (p_t_siz_rec.size_chart_dt_tmp_id, p_t_siz_rec.size_chart_id,
       p_t_siz_rec.measure, p_t_siz_rec.measure_value, p_t_siz_rec.pause,
       p_t_siz_rec.create_id, p_t_siz_rec.create_time, p_t_siz_rec.update_id,
       p_t_siz_rec.update_time, p_t_siz_rec.memo);
  END p_insert_t_size_chart_dt_tmp;
  /*============================================*
  * Author   : CZH
  * Created  : 23-9月 -22
  * ALERTER  :
  * ALERTER_TIME  :
  * Purpose  :  修改 T_SIZE_CHART_DETAILS_TMP
  * Obj_Name    : P_UPDATE_T_SIZE_CHART_DT_TMP
  *============================================*/
  PROCEDURE p_update_t_size_chart_dt_tmp(p_t_siz_rec t_size_chart_details_tmp%ROWTYPE) IS
  BEGIN
    UPDATE t_size_chart_details_tmp t
       SET t.measure_value = p_t_siz_rec.measure_value,
           t.pause         = p_t_siz_rec.pause,
           t.create_id     = p_t_siz_rec.create_id,
           t.create_time   = p_t_siz_rec.create_time,
           t.update_id     = p_t_siz_rec.update_id,
           t.update_time   = p_t_siz_rec.update_time,
           t.memo          = p_t_siz_rec.memo
     WHERE t.size_chart_id = p_t_siz_rec.size_chart_id
       AND t.measure = p_t_siz_rec.measure;
  END p_update_t_size_chart_dt_tmp;

  --删除尺寸临时表(含尺码)行数据
  PROCEDURE p_delete_t_size_chart_dt_tmp(p_company_id          VARCHAR2,
                                         p_goo_id              VARCHAR2,
                                         p_position            VARCHAR2,
                                         p_quantitative_method VARCHAR2) IS
  BEGIN
    --删除校验
    p_check_size_chart_dt_tmp_by_delete(p_company_id => p_company_id,
                                        p_goo_id     => p_goo_id);
  
    DELETE FROM t_size_chart_details_tmp a
     WHERE a.size_chart_id IN
           (SELECT t.size_chart_tmp_id
              FROM scmdata.t_size_chart_tmp t
             WHERE t.company_id = p_company_id
               AND p_goo_id = t.goo_id
               AND t.position = p_position
               AND t.quantitative_method = p_quantitative_method);
  
    DELETE FROM scmdata.t_size_chart_tmp t
     WHERE t.company_id = p_company_id
       AND p_goo_id = t.goo_id
       AND t.position = p_position
       AND t.quantitative_method = p_quantitative_method;
  END p_delete_t_size_chart_dt_tmp;

  /*============================================*
  * Author   : CZH
  * Created  : 23-9月 -22
  * ALERTER  :
  * ALERTER_TIME  :
  * Purpose  : 删除 T_SIZE_CHART_DETAILS_TMP
  * Obj_Name    : P_DELETE_T_SIZE_CHART_TMP
  *============================================*/
  PROCEDURE p_delete_t_size_chart_dt_tmp(p_company_id VARCHAR2,
                                         p_goo_id     VARCHAR2) IS
  BEGIN
    DELETE FROM scmdata.t_size_chart_details_tmp a
     WHERE a.size_chart_id IN
           (SELECT t.size_chart_tmp_id
              FROM t_size_chart_tmp t
             WHERE t.company_id = p_company_id
               AND t.goo_id = p_goo_id);
  END p_delete_t_size_chart_dt_tmp;

  --尺寸临时表（含尺码）删除校验
  PROCEDURE p_check_size_chart_dt_tmp_by_delete(p_company_id VARCHAR2,
                                                p_goo_id     VARCHAR2) IS
    v_cnt INT;
  BEGIN
    NULL;
    SELECT COUNT(DISTINCT a.seq_num)
      INTO v_cnt
      FROM t_size_chart_tmp a
     INNER JOIN t_size_chart_details_tmp b
        ON b.size_chart_id = a.size_chart_tmp_id
     WHERE a.company_id = p_company_id
       AND a.goo_id = p_goo_id;
    IF v_cnt <= 1 THEN
      raise_application_error(-20002,
                              '不可删除所有数据，至少需存在一条数据');
    END IF;
  END p_check_size_chart_dt_tmp_by_delete;

  --尺寸表模板校验
  PROCEDURE p_check_size_chart_moudle(p_goo_id     VARCHAR2,
                                      p_company_id VARCHAR2) IS
    v_cate  VARCHAR2(32);
    v_pcate VARCHAR2(32);
    v_scate VARCHAR2(32);
    v_flag  NUMBER;
  BEGIN
    /*    数据校验：   
    1.根据在待批版页面选中的数据行（获取货号对应的分类+生产类别+产品子类），点击[选择模板]按钮时需要校验尺寸表配置中是否存在该分类+生产类别+产品子类的尺寸表配置，且状态=“启用”；    
      1.1）如果对应的分类+生产类别+产品子类未配置尺寸模板时，给出提示信息：该货号对应的产品子类暂未配置尺寸表模板，请先配置；    
      1.2）如果对应的分类+生产类别+产品子类已配置尺寸模板时，则弹窗显示尺寸表模板选择（具体逻辑看弹窗区图2-1 说明）；       
    2.如果对应的分类+生产类别+产品子类已生成尺寸表，点击[生成尺寸表模板]时，选择尺寸表模板后，覆盖原来的尺寸表数据（具体逻辑看弹窗区图2-1 说明）；*/
    SELECT MAX(tc.category), MAX(tc.product_cate), MAX(tc.samll_category)
      INTO v_cate, v_pcate, v_scate
      FROM scmdata.t_commodity_info tc
     WHERE tc.goo_id = p_goo_id
       AND tc.company_id = p_company_id;
  
    SELECT COUNT(1)
      INTO v_flag
      FROM scmdata.t_size_chart_config t
     WHERE t.category = v_cate
       AND t.product_cate = v_pcate
       AND instr(t.subcategory, v_scate) > 0
       AND t.pause = 0
       AND t.wether_del = 0
       AND t.usable = 1;
  
    IF v_flag > 0 THEN
      NULL;
    ELSE
      raise_application_error(-20002,
                              '该货号对应的产品子类暂未配置尺寸表模板，请先配置');
    END IF;
  END p_check_size_chart_moudle;
  --选择模板
  FUNCTION f_get_size_chart_moudle(p_goo_id     VARCHAR2,
                                   p_company_id VARCHAR2) RETURN CLOB IS
    v_sql   CLOB;
    v_cate  VARCHAR2(32);
    v_pcate VARCHAR2(32);
    v_scate VARCHAR2(32);
  BEGIN
    --选择模板，需删除原临时表内容
    /*p_delete_t_size_chart_tmp(p_company_id => p_company_id,
    p_goo_id     => p_goo_id);*/
  
    --查询模板
    SELECT MAX(tc.category), MAX(tc.product_cate), MAX(tc.samll_category)
      INTO v_cate, v_pcate, v_scate
      FROM scmdata.t_commodity_info tc
     WHERE tc.goo_id = p_goo_id
       AND tc.company_id = p_company_id;
  
    v_sql := 'SELECT t.size_chart_config_id   size_chart_config_code,
           t.size_chart_config_name size_chart_config_value
      FROM scmdata.t_size_chart_config t
     WHERE t.category = ''' || v_cate || '''
       AND t.product_cate = ''' || v_pcate || '''
       AND instr(t.subcategory, ''' || v_scate ||
             ''') > 0
       AND t.pause = 0
       AND t.wether_del = 0
       AND t.usable = 1';
    RETURN v_sql;
  END f_get_size_chart_moudle;

  --获取尺码对应的企业字典ID
  FUNCTION f_get_size_company_dict(p_company_id VARCHAR2,
                                   p_size_name  VARCHAR2) RETURN VARCHAR2 IS
    v_company_dict_id VARCHAR2(32);
  BEGIN
    SELECT MAX(t.company_dict_id)
      INTO v_company_dict_id
      FROM scmdata.sys_company_dict t
     WHERE t.company_dict_type IN ('SL_GDV', 'SL_GDN')
       AND t.company_id = p_company_id
       AND t.extend_01 = 'SIZE_CHART'
       AND t.company_dict_name = p_size_name;
    RETURN v_company_dict_id;
  END f_get_size_company_dict;

  --通过尺码类型获取尺码
  FUNCTION f_get_size_company_dict_by_type(p_company_id VARCHAR2,
                                           p_type       VARCHAR2) RETURN CLOB IS
    v_sql CLOB;
  BEGIN
    v_sql := q'[SELECT t.company_dict_id measure_id,t.company_dict_name  measure
      FROM scmdata.sys_company_dict t
     WHERE t.company_dict_type = ']' || p_type || q'['
       AND t.company_id = ']' || p_company_id || q'['
       AND t.extend_01 = 'SIZE_CHART']';
    RETURN v_sql;
  END f_get_size_company_dict_by_type;

  --根据选择模板 生成尺寸临时表
  PROCEDURE p_generate_size_chart_tmp(p_company_id        VARCHAR2,
                                      p_goo_id            VARCHAR2,
                                      p_user_id           VARCHAR2,
                                      p_size_chart_moudle VARCHAR2) IS
    p_size_chart_tmp      scmdata.t_size_chart_tmp%ROWTYPE;
    v_size_chart_word_rec scmdata.t_size_chart_config_word_detail%ROWTYPE;
    v_size_chart_num_rec  scmdata.t_size_chart_config_word_detail%ROWTYPE;
    v_base_size_type      VARCHAR2(32);
    v_base_code           VARCHAR2(32);
  BEGIN
    --选择模板，需删除原临时表内容
    p_delete_t_size_chart_tmp(p_company_id => p_company_id,
                              p_goo_id     => p_goo_id);
  
    SELECT MAX(t.base_size_type), MAX(t.base_size_value)
      INTO v_base_size_type, v_base_code
      FROM scmdata.t_size_chart_config t
     WHERE t.size_chart_config_id = p_size_chart_moudle
       AND t.company_id = p_company_id;
    --字母
    IF v_base_size_type = 'SL_GDV' THEN
      FOR v_size_chart_word_rec IN (SELECT *
                                      FROM scmdata.t_size_chart_config_word_detail tw
                                     WHERE tw.size_chart_config_id =
                                           p_size_chart_moudle
                                       AND tw.company_id = p_company_id) LOOP
        p_size_chart_tmp.size_chart_tmp_id      := scmdata.f_get_uuid();
        p_size_chart_tmp.company_id             := p_company_id;
        p_size_chart_tmp.goo_id                 := p_goo_id;
        p_size_chart_tmp.seq_num                := v_size_chart_word_rec.seq_no;
        p_size_chart_tmp.position               := v_size_chart_word_rec.position;
        p_size_chart_tmp.quantitative_method    := v_size_chart_word_rec.method;
        p_size_chart_tmp.base_code              := v_base_code;
        p_size_chart_tmp.base_value             := 0;
        p_size_chart_tmp.plus_toleran_range     := v_size_chart_word_rec.tolerance_plus;
        p_size_chart_tmp.negative_toleran_range := v_size_chart_word_rec.tolerance_minus;
        p_size_chart_tmp.pause                  := 0;
        p_size_chart_tmp.create_id              := p_user_id;
        p_size_chart_tmp.create_time            := SYSDATE;
        p_size_chart_tmp.update_id              := p_user_id;
        p_size_chart_tmp.update_time            := SYSDATE;
        p_size_chart_tmp.memo                   := NULL;
      
        p_insert_t_size_chart_tmp(p_t_siz_rec => p_size_chart_tmp);
      END LOOP;
      --数字
    ELSIF v_base_size_type = 'SL_GDN' THEN
      FOR v_size_chart_num_rec IN (SELECT *
                                     FROM scmdata.t_size_chart_config_num_detail tn
                                    WHERE tn.size_chart_config_id =
                                          p_size_chart_moudle
                                      AND tn.company_id = p_company_id) LOOP
      
        p_size_chart_tmp.size_chart_tmp_id      := scmdata.f_get_uuid();
        p_size_chart_tmp.company_id             := p_company_id;
        p_size_chart_tmp.goo_id                 := p_goo_id;
        p_size_chart_tmp.seq_num                := v_size_chart_num_rec.seq_no;
        p_size_chart_tmp.position               := v_size_chart_num_rec.position;
        p_size_chart_tmp.quantitative_method    := v_size_chart_num_rec.method;
        p_size_chart_tmp.base_code              := v_base_code;
        p_size_chart_tmp.base_value             := 0;
        p_size_chart_tmp.plus_toleran_range     := v_size_chart_num_rec.tolerance_plus;
        p_size_chart_tmp.negative_toleran_range := v_size_chart_num_rec.tolerance_minus;
        p_size_chart_tmp.pause                  := 0;
        p_size_chart_tmp.create_id              := p_user_id;
        p_size_chart_tmp.create_time            := SYSDATE;
        p_size_chart_tmp.update_id              := p_user_id;
        p_size_chart_tmp.update_time            := SYSDATE;
        p_size_chart_tmp.memo                   := NULL;
        p_insert_t_size_chart_tmp(p_t_siz_rec => p_size_chart_tmp);
      END LOOP;
    ELSE
      NULL;
    END IF;
  END p_generate_size_chart_tmp;

  --选择模板后
  --提交校验
  PROCEDURE p_check_size_chart_moudle_by_submit(p_goo_id     VARCHAR2,
                                                p_company_id VARCHAR2) IS
    v_flag INT;
  BEGIN
    FOR i IN (SELECT t.base_value
                FROM scmdata.t_size_chart_tmp t
               WHERE t.goo_id = p_goo_id
                 AND t.company_id = p_company_id) LOOP
      IF i.base_value IS NULL OR i.base_value = 0 THEN
        raise_application_error(-20002,
                                '当前尺寸表存在基码未填，请完善数据后再提交');
      ELSE
        NULL;
      END IF;
    END LOOP;
  
    SELECT COUNT(1)
      INTO v_flag
      FROM (SELECT DISTINCT t.sizename, t.goo_id, t.company_id, t.sizecode
              FROM scmdata.t_commodity_color_size t
             WHERE t.goo_id = p_goo_id
               AND t.company_id = p_company_id) v
     WHERE v.sizename IN (SELECT DISTINCT a.base_code
                            FROM scmdata.t_size_chart_tmp a
                           WHERE a.goo_id = p_goo_id
                             AND a.company_id = p_company_id);
    IF v_flag = 0 THEN
      raise_application_error(-20002, '档案中的尺码没有该模板配置中的基码');
    END IF;
  END p_check_size_chart_moudle_by_submit;

  --根据模板的跳码规则，计算其他码数对应的尺码值
  FUNCTION f_get_size_by_jump_size_rule(p_company_id        VARCHAR2,
                                        p_size_chart_moudle VARCHAR2,
                                        p_position          VARCHAR2,
                                        p_size_name         VARCHAR2,
                                        p_base_size         NUMBER)
    RETURN NUMBER IS
    v_size            NUMBER;
    v_base_size_type  VARCHAR2(32);
    v_jump_size_value NUMBER;
  BEGIN
    SELECT MAX(t.base_size_type)
      INTO v_base_size_type
      FROM scmdata.t_size_chart_config t
     WHERE t.size_chart_config_id = p_size_chart_moudle
       AND t.company_id = p_company_id;
    --字母
    IF v_base_size_type = 'SL_GDV' THEN
      SELECT MAX(v.jump_size_value)
        INTO v_jump_size_value
        FROM (SELECT size_chart_config_word_detail_id,
                     size_chart_config_id,
                     position,
                     size_name,
                     jump_size_value
                FROM (SELECT t.size_chart_config_word_detail_id,
                             t.size_chart_config_id,
                             t.position,
                             t.xs,
                             t.s,
                             t.m,
                             t.l,
                             t.xl,
                             t.xxl,
                             t.xxxl,
                             t.xxxxl
                        FROM scmdata.t_size_chart_config_word_detail t
                       WHERE t.size_chart_config_id = p_size_chart_moudle) unpivot((jump_size_value) FOR size_name IN(xs,
                                                                                                                      s,
                                                                                                                      m,
                                                                                                                      l,
                                                                                                                      xl,
                                                                                                                      xxl,
                                                                                                                      xxxl,
                                                                                                                      xxxxl))) v
       WHERE v.size_name = p_size_name
         AND v.position = p_position;
      --数字
    ELSIF v_base_size_type = 'SL_GDN' THEN
      SELECT MAX(v.jump_size_value)
        INTO v_jump_size_value
        FROM (SELECT size_chart_config_num_detail_id,
                     size_chart_config_id,
                     position,
                     scmdata.pkg_plat_comm.f_get_val_by_delimit(p_character => size_name,
                                                                p_separate  => '_',
                                                                p_is_pre    => 0) size_name,
                     jump_size_value
                FROM (SELECT t.size_chart_config_num_detail_id,
                             t.size_chart_config_id,
                             t.position,
                             t.num_27,
                             t.num_28,
                             t.num_29,
                             t.num_30,
                             t.num_31,
                             t.num_32,
                             t.num_33,
                             t.num_34,
                             t.num_35,
                             t.num_36,
                             t.num_37,
                             t.num_38
                        FROM scmdata.t_size_chart_config_num_detail t
                       WHERE t.size_chart_config_id = p_size_chart_moudle) unpivot((jump_size_value) FOR size_name IN(num_27,
                                                                                                                      num_28,
                                                                                                                      num_29,
                                                                                                                      num_30,
                                                                                                                      num_31,
                                                                                                                      num_32,
                                                                                                                      num_33,
                                                                                                                      num_34,
                                                                                                                      num_35,
                                                                                                                      num_36,
                                                                                                                      num_37,
                                                                                                                      num_38))) v
       WHERE v.size_name = p_size_name
         AND v.position = p_position;
    ELSE
      NULL;
    END IF;
    --根据基码+跳码规则，获取相应尺码值
    IF v_jump_size_value IS NULL THEN
      v_size := NULL;
    ELSE
      v_size := p_base_size + v_jump_size_value;
    END IF;
    RETURN v_size;
  END f_get_size_by_jump_size_rule;

  --校验临时表尺码只能填数字
  PROCEDURE p_check_size_chart_by_update(p_measure_value VARCHAR2) IS
    v_flag INT;
  BEGIN
    IF p_measure_value IS NULL THEN
      raise_application_error(-20002, '尺码不可为空，请检查');
    ELSE
      IF p_measure_value = '0' THEN
        raise_application_error(-20002, '尺码不可为0，请检查');
      END IF;
      SELECT COUNT(1)
        INTO v_flag
        FROM (SELECT 1
                FROM dual
               WHERE regexp_like(p_measure_value,
                                 '^(0|[1-9]\d{0,9})(\.\d{1,4})?$'));
      IF v_flag > 0 THEN
        NULL;
      ELSE
        raise_application_error(-20002, '尺码仅支持填数字，请检查');
      END IF;
    END IF;
  END p_check_size_chart_by_update;

  --判断是否已存在尺寸表(临时表)数据
  FUNCTION f_check_is_has_size_chart_tmp_data(p_company_id          VARCHAR2,
                                              p_goo_id              VARCHAR2,
                                              p_position            VARCHAR2,
                                              p_quantitative_method VARCHAR2)
    RETURN INT IS
    v_flag INT;
  BEGIN
    SELECT COUNT(1)
      INTO v_flag
      FROM scmdata.t_size_chart_tmp t
     WHERE t.company_id = p_company_id
       AND t.goo_id = p_goo_id
       AND t.position = p_position
       AND t.quantitative_method = p_quantitative_method;
    RETURN v_flag;
  END f_check_is_has_size_chart_tmp_data;

  --尺寸表模板，提交生成尺寸临时表
  PROCEDURE p_generate_size_chart_dt_tmp(p_company_id VARCHAR2,
                                         p_goo_id     VARCHAR2,
                                         p_user_id    VARCHAR2) IS
    p_size_chart_dt_tmp scmdata.t_size_chart_details_tmp%ROWTYPE;
    v_measure_value     NUMBER;
    v_size_chart_moudle VARCHAR2(32);
    v_sizename          VARCHAR2(32);
  BEGIN
    --提交校验
    p_check_size_chart_moudle_by_submit(p_goo_id     => p_goo_id,
                                        p_company_id => p_company_id);
    --删除已生成的尺寸表
    p_delete_t_size_chart_dt_tmp(p_goo_id     => p_goo_id,
                                 p_company_id => p_company_id);
    --提交时携带变量至生成尺寸表页面
    scmdata.pkg_variable.p_ins_or_upd_variable(v_objid   => p_user_id,
                                               v_compid  => p_company_id,
                                               v_varname => 'SIZE_CHART_GOO_ID',
                                               v_vartype => 'VARCHAR',
                                               v_varchar => p_goo_id);
  
    v_size_chart_moudle := scmdata.pkg_variable.f_get_varchar(v_objid   => p_user_id,
                                                              v_compid  => p_company_id,
                                                              v_varname => 'SIZE_CHART_MOUDLE');
  
    --尺寸表模板
    FOR size_chart_rec IN (SELECT ts.*
                             FROM scmdata.t_size_chart_tmp ts
                            WHERE ts.goo_id = p_goo_id
                              AND ts.company_id = p_company_id) LOOP
      --获取尺码  从商品档案-从表-色码表-尺码中获取，根据货号动态展示
      FOR size_chart_dt_rec IN (SELECT DISTINCT t.sizename,
                                                t.goo_id,
                                                t.company_id,
                                                t.sizecode
                                  FROM scmdata.t_commodity_color_size t
                                 WHERE t.goo_id = p_goo_id
                                   AND t.company_id = p_company_id
                                 ORDER BY t.sizecode ASC) LOOP
      
        p_size_chart_dt_tmp.size_chart_dt_tmp_id := scmdata.f_get_uuid();
        p_size_chart_dt_tmp.size_chart_id        := size_chart_rec.size_chart_tmp_id;
      
        v_sizename := f_get_size_company_dict(p_company_id => p_company_id,
                                              p_size_name  => size_chart_dt_rec.sizename);
      
        p_size_chart_dt_tmp.measure := v_sizename; --尺码企业字典ID
        --除基码外的其他尺码值，根据填写的基码+选择的尺寸表模板对应的跳码规则自动生成;
        --模板中没有配置对应尺码的跳码规则，则该尺寸需手动录入；
        --基码
        IF size_chart_dt_rec.sizename = size_chart_rec.base_code THEN
          v_measure_value := size_chart_rec.base_value;
        ELSE
          v_measure_value := f_get_size_by_jump_size_rule(p_company_id        => p_company_id,
                                                          p_size_chart_moudle => v_size_chart_moudle,
                                                          p_position          => size_chart_rec.position,
                                                          p_size_name         => size_chart_dt_rec.sizename,
                                                          p_base_size         => size_chart_rec.base_value);
        END IF;
        p_size_chart_dt_tmp.measure_value := v_measure_value;
        p_size_chart_dt_tmp.pause         := 0;
        p_size_chart_dt_tmp.create_id     := p_user_id;
        p_size_chart_dt_tmp.create_time   := SYSDATE;
        p_size_chart_dt_tmp.update_id     := p_user_id;
        p_size_chart_dt_tmp.update_time   := SYSDATE;
        p_size_chart_dt_tmp.memo          := NULL;
        p_insert_t_size_chart_dt_tmp(p_t_siz_rec => p_size_chart_dt_tmp);
      END LOOP;
    END LOOP;
  END p_generate_size_chart_dt_tmp;

  --判断是否存在尺寸表（业务表）
  FUNCTION f_check_is_has_size_chart(p_company_id VARCHAR2,
                                     p_goo_id     VARCHAR2) RETURN INT IS
    v_flag INT;
  BEGIN
    SELECT COUNT(1)
      INTO v_flag
      FROM scmdata.t_size_chart t
     WHERE t.company_id = p_company_id
       AND t.goo_id = p_goo_id;
    RETURN v_flag;
  END f_check_is_has_size_chart;

  --判断是否已存在尺寸表(业务表)行数据
  FUNCTION f_check_is_has_size_chart_data(p_company_id          VARCHAR2,
                                          p_goo_id              VARCHAR2,
                                          p_position            VARCHAR2,
                                          p_quantitative_method VARCHAR2)
    RETURN INT IS
    v_flag INT;
  BEGIN
    SELECT COUNT(1)
      INTO v_flag
      FROM scmdata.t_size_chart t
     WHERE t.company_id = p_company_id
       AND t.goo_id = p_goo_id
       AND t.position = p_position
       AND t.quantitative_method = p_quantitative_method;
    RETURN v_flag;
  END f_check_is_has_size_chart_data;

  /*============================================*
  * Author   : CZH
  * Created  : 23-9月 -22
  * ALERTER  :
  * ALERTER_TIME  :
  * Purpose  : 查询T_SIZE_CHART
  * Obj_Name    : F_QUERY_T_SIZE_CHART_TMP
  *============================================*/
  FUNCTION f_query_t_size_chart RETURN CLOB IS
    v_sql CLOB;
  BEGIN
    v_sql := 'SELECT a.size_chart_id,
       a.company_id,
       a.goo_id,
       LPAD(a.seq_num,2,''0'') seq_num,
       a.position,
       a.quantitative_method,
       a.base_code,
       a.base_value,
       abs(a.plus_toleran_range) plus_toleran_range,
       abs(a.negative_toleran_range) negative_toleran_range,
       c.company_dict_name measure,
       b.measure_value
  FROM scmdata.t_size_chart a
 INNER JOIN scmdata.t_size_chart_details b
    ON b.size_chart_id = a.size_chart_id
 INNER JOIN scmdata.sys_company_dict c
    ON c.company_dict_id = b.measure
 WHERE a.goo_id = :goo_id
   AND a.company_id = %default_company_id%
 ORDER BY a.seq_num ASC, c.company_dict_sort ASC';
    RETURN v_sql;
  END f_query_t_size_chart;
  /*============================================*
  * Author   : CZH
  * Created  : 11-10月-22
  * ALERTER  :
  * ALERTER_TIME  :
  * Purpose  : 新增T_SIZE_CHART
  * Obj_Name    : P_INSERT_T_SIZE_CHART
  *============================================*/
  PROCEDURE p_insert_t_size_chart(p_t_siz_rec scmdata.t_size_chart%ROWTYPE) IS
  BEGIN
    --校验部位唯一性
    p_check_size_chart_by_save(p_table      => 't_size_chart',
                               p_company_id => p_t_siz_rec.company_id,
                               p_goo_id     => p_t_siz_rec.goo_id,
                               p_position   => p_t_siz_rec.position);
    INSERT INTO t_size_chart
      (size_chart_id, company_id, goo_id, seq_num, position,
       quantitative_method, base_code, base_value, plus_toleran_range,
       negative_toleran_range, pause, create_id, create_time, update_id,
       update_time, memo)
    VALUES
      (p_t_siz_rec.size_chart_id, p_t_siz_rec.company_id,
       p_t_siz_rec.goo_id, p_t_siz_rec.seq_num, p_t_siz_rec.position,
       p_t_siz_rec.quantitative_method, p_t_siz_rec.base_code,
       p_t_siz_rec.base_value, p_t_siz_rec.plus_toleran_range,
       p_t_siz_rec.negative_toleran_range, p_t_siz_rec.pause,
       p_t_siz_rec.create_id, p_t_siz_rec.create_time, p_t_siz_rec.update_id,
       p_t_siz_rec.update_time, p_t_siz_rec.memo);
  END p_insert_t_size_chart;

  /*============================================*
  * Author   : CZH
  * Created  : 11-10月-22
  * ALERTER  :
  * ALERTER_TIME  :
  * Purpose  : 修改T_SIZE_CHART
  * Obj_Name    : P_UPDATE_T_SIZE_CHART
  *============================================*/
  PROCEDURE p_update_t_size_chart(p_t_siz_rec scmdata.t_size_chart%ROWTYPE) IS
  BEGIN
    --校验部位唯一性
    p_check_size_chart_by_save(p_table      => 't_size_chart',
                               p_company_id => p_t_siz_rec.company_id,
                               p_goo_id     => p_t_siz_rec.goo_id,
                               p_position   => p_t_siz_rec.position);
  
    UPDATE t_size_chart t
       SET t.seq_num                = p_t_siz_rec.seq_num,
           t.position               = p_t_siz_rec.position,
           t.quantitative_method    = p_t_siz_rec.quantitative_method,
           t.base_code              = p_t_siz_rec.base_code,
           t.base_value             = p_t_siz_rec.base_value,
           t.plus_toleran_range     = p_t_siz_rec.plus_toleran_range,
           t.negative_toleran_range = p_t_siz_rec.negative_toleran_range,
           t.pause                  = p_t_siz_rec.pause,
           t.create_id              = p_t_siz_rec.create_id,
           t.create_time            = p_t_siz_rec.create_time,
           t.update_id              = p_t_siz_rec.update_id,
           t.update_time            = p_t_siz_rec.update_time,
           t.memo                   = p_t_siz_rec.memo
     WHERE t.size_chart_id = p_t_siz_rec.size_chart_id;
  END p_update_t_size_chart;

  /*============================================*
  * Author   : CZH
  * Created  : 11-10月-22
  * ALERTER  :
  * ALERTER_TIME  :
  * Purpose  : 删除T_SIZE_CHART
  * Obj_Name    : P_DELETE_T_SIZE_CHART
  *============================================*/
  PROCEDURE p_delete_t_size_chart(p_t_siz_rec scmdata.t_size_chart%ROWTYPE) IS
  BEGIN
    DELETE FROM t_size_chart t
     WHERE t.size_chart_id = p_t_siz_rec.size_chart_id;
  END p_delete_t_size_chart;
  /*============================================*
  * Author   : CZH
  * Created  : 11-10月-22
  * ALERTER  :
  * ALERTER_TIME  :
  * Purpose  : 新增T_SIZE_CHART_DETAILS
  * Obj_Name    : P_INSERT_T_SIZE_CHART_DETAILS
  *============================================*/
  PROCEDURE p_insert_t_size_chart_details(p_t_siz_rec scmdata.t_size_chart_details%ROWTYPE) IS
  BEGIN
    INSERT INTO t_size_chart_details
      (size_chart_dt_id, size_chart_id, measure, measure_value, pause,
       create_id, create_time, update_id, update_time, memo)
    VALUES
      (p_t_siz_rec.size_chart_dt_id, p_t_siz_rec.size_chart_id,
       p_t_siz_rec.measure, p_t_siz_rec.measure_value, p_t_siz_rec.pause,
       p_t_siz_rec.create_id, p_t_siz_rec.create_time, p_t_siz_rec.update_id,
       p_t_siz_rec.update_time, p_t_siz_rec.memo);
  END p_insert_t_size_chart_details;

  /*============================================*
  * Author   : CZH
  * Created  : 11-10月-22
  * ALERTER  :
  * ALERTER_TIME  :
  * Purpose  : 修改T_SIZE_CHART_DETAILS
  * Obj_Name    : P_UPDATE_T_SIZE_CHART_DETAILS
  *============================================*/
  PROCEDURE p_update_t_size_chart_details(p_t_siz_rec scmdata.t_size_chart_details%ROWTYPE) IS
  BEGIN
    UPDATE t_size_chart_details t
       SET t.measure_value = p_t_siz_rec.measure_value,
           t.pause         = p_t_siz_rec.pause,
           t.create_id     = p_t_siz_rec.create_id,
           t.create_time   = p_t_siz_rec.create_time,
           t.update_id     = p_t_siz_rec.update_id,
           t.update_time   = p_t_siz_rec.update_time,
           t.memo          = p_t_siz_rec.memo
     WHERE t.size_chart_id = p_t_siz_rec.size_chart_id
       AND t.measure = p_t_siz_rec.measure;
  END p_update_t_size_chart_details;

  /*============================================*
  * Author   : CZH
  * Created  : 11-10月-22
  * ALERTER  :
  * ALERTER_TIME  :
  * Purpose  : 删除T_SIZE_CHART_DETAILS
  * Obj_Name    : P_DELETE_T_SIZE_CHART_DETAILS
  *============================================*/
  PROCEDURE p_delete_t_size_chart_details(p_t_siz_rec scmdata.t_size_chart_details%ROWTYPE) IS
  BEGIN
    DELETE FROM t_size_chart_details t
     WHERE t.size_chart_dt_id = p_t_siz_rec.size_chart_dt_id;
  END p_delete_t_size_chart_details;

  --删除尺寸表（业务表）行数据
  PROCEDURE p_delete_t_size_chart_row_data(p_company_id          VARCHAR2,
                                           p_goo_id              VARCHAR2,
                                           p_position            VARCHAR2,
                                           p_quantitative_method VARCHAR2) IS
  BEGIN
    --删除校验
    p_check_t_size_chart_by_delete(p_company_id => p_company_id,
                                   p_goo_id     => p_goo_id);
  
    DELETE FROM t_size_chart_details a
     WHERE a.size_chart_id IN
           (SELECT t.size_chart_id
              FROM scmdata.t_size_chart t
             WHERE t.company_id = p_company_id
               AND t.goo_id = p_goo_id
               AND t.position = p_position
               AND t.quantitative_method = p_quantitative_method);
  
    DELETE FROM scmdata.t_size_chart t
     WHERE t.company_id = p_company_id
       AND p_goo_id = t.goo_id
       AND t.position = p_position
       AND t.quantitative_method = p_quantitative_method;
  END p_delete_t_size_chart_row_data;

  --删除尺寸表（业务表）所有数据
  PROCEDURE p_delete_t_size_chart_all_data(p_company_id VARCHAR2,
                                           p_goo_id     VARCHAR2) IS
  BEGIN
    DELETE FROM t_size_chart_details a
     WHERE a.size_chart_id IN
           (SELECT t.size_chart_id
              FROM scmdata.t_size_chart t
             WHERE t.company_id = p_company_id
               AND p_goo_id = t.goo_id);
  
    DELETE FROM scmdata.t_size_chart t
     WHERE t.company_id = p_company_id
       AND p_goo_id = t.goo_id;
  END p_delete_t_size_chart_all_data;

  --提交校验必填项是否为空
  PROCEDURE p_check_size_chart_by_submit(p_company_id VARCHAR2,
                                         p_goo_id     VARCHAR2) IS
    v_flag INT;
  BEGIN
    SELECT COUNT(1)
      INTO v_flag
      FROM scmdata.t_size_chart_tmp t
     INNER JOIN scmdata.t_size_chart_details_tmp a
        ON a.size_chart_id = t.size_chart_tmp_id
     WHERE t.goo_id = p_goo_id
       AND t.company_id = p_company_id
       AND a.measure_value IS NULL;
  
    IF v_flag > 0 THEN
      raise_application_error(-20002, '存在尺码为空,请完善数据后提交');
    END IF;
  END p_check_size_chart_by_submit;
  --生成尺寸表（业务表）
  PROCEDURE p_generate_size_chart(p_company_id VARCHAR2, p_goo_id VARCHAR2) IS
    p_t_siz_rec     t_size_chart%ROWTYPE;
    p_t_siz_dt_rec  t_size_chart_details%ROWTYPE;
    v_size_chart_id VARCHAR2(32);
  BEGIN
    --校验必填项
    p_check_size_chart_by_submit(p_company_id => p_company_id,
                                 p_goo_id     => p_goo_id);
    --生成尺寸表前，删除该货号对应的所有尺寸表数据
    p_delete_t_size_chart_all_data(p_company_id => p_company_id,
                                   p_goo_id     => p_goo_id);
    --生成尺寸表                              
    FOR p_t_siz_tmp_rec IN (SELECT *
                              FROM scmdata.t_size_chart_tmp t
                             WHERE t.goo_id = p_goo_id
                               AND t.company_id = p_company_id) LOOP
      v_size_chart_id                    := scmdata.f_get_uuid();
      p_t_siz_rec.size_chart_id          := v_size_chart_id;
      p_t_siz_rec.company_id             := p_t_siz_tmp_rec.company_id;
      p_t_siz_rec.goo_id                 := p_t_siz_tmp_rec.goo_id;
      p_t_siz_rec.seq_num                := p_t_siz_tmp_rec.seq_num;
      p_t_siz_rec.position               := p_t_siz_tmp_rec.position;
      p_t_siz_rec.quantitative_method    := p_t_siz_tmp_rec.quantitative_method;
      p_t_siz_rec.base_code              := p_t_siz_tmp_rec.base_code;
      p_t_siz_rec.base_value             := p_t_siz_tmp_rec.base_value;
      p_t_siz_rec.plus_toleran_range     := p_t_siz_tmp_rec.plus_toleran_range;
      p_t_siz_rec.negative_toleran_range := p_t_siz_tmp_rec.negative_toleran_range;
      p_t_siz_rec.pause                  := p_t_siz_tmp_rec.pause;
      p_t_siz_rec.create_id              := p_t_siz_tmp_rec.create_id;
      p_t_siz_rec.create_time            := p_t_siz_tmp_rec.create_time;
      p_t_siz_rec.update_id              := p_t_siz_tmp_rec.update_id;
      p_t_siz_rec.update_time            := p_t_siz_tmp_rec.update_time;
      p_t_siz_rec.memo                   := p_t_siz_tmp_rec.memo;
    
      p_insert_t_size_chart(p_t_siz_rec => p_t_siz_rec);
    
      FOR p_t_siz_dt_tmp_rec IN (SELECT *
                                   FROM scmdata.t_size_chart_details_tmp dt
                                  WHERE dt.size_chart_id =
                                        p_t_siz_tmp_rec.size_chart_tmp_id) LOOP
      
        p_t_siz_dt_rec.size_chart_dt_id := scmdata.f_get_uuid();
        p_t_siz_dt_rec.size_chart_id    := v_size_chart_id;
        p_t_siz_dt_rec.measure          := p_t_siz_dt_tmp_rec.measure;
        p_t_siz_dt_rec.measure_value    := p_t_siz_dt_tmp_rec.measure_value;
        p_t_siz_dt_rec.pause            := p_t_siz_dt_tmp_rec.pause;
        p_t_siz_dt_rec.create_id        := p_t_siz_dt_tmp_rec.create_id;
        p_t_siz_dt_rec.create_time      := p_t_siz_dt_tmp_rec.create_time;
        p_t_siz_dt_rec.update_id        := p_t_siz_dt_tmp_rec.update_id;
        p_t_siz_dt_rec.update_time      := p_t_siz_dt_tmp_rec.update_time;
        p_t_siz_dt_rec.memo             := p_t_siz_dt_tmp_rec.memo;
        p_insert_t_size_chart_details(p_t_siz_rec => p_t_siz_dt_rec);
      END LOOP;
    END LOOP;
    --商品档案生成尺寸表后同步更新至同货号批版单据
    p_sync_gd_size_chart_to_apv(p_company_id => p_company_id,
                                p_goo_id     => p_goo_id);
  END p_generate_size_chart;

  --尺寸表含尺码（业务表）删除校验
  PROCEDURE p_check_t_size_chart_by_delete(p_company_id VARCHAR2,
                                           p_goo_id     VARCHAR2) IS
    v_cnt INT;
  BEGIN
    SELECT COUNT(DISTINCT a.seq_num)
      INTO v_cnt
      FROM t_size_chart a
     INNER JOIN t_size_chart_details b
        ON b.size_chart_id = a.size_chart_id
     WHERE a.company_id = p_company_id
       AND a.goo_id = p_goo_id;
    IF v_cnt <= 1 THEN
      raise_application_error(-20002,
                              '不可删除所有数据，至少需存在一条数据');
    END IF;
  END p_check_t_size_chart_by_delete;

  --商品档案生成尺寸表后同步更新至同货号批版单据
  PROCEDURE p_sync_gd_size_chart_to_apv(p_company_id VARCHAR2,
                                        p_goo_id     VARCHAR2) IS
    p_t_siz_rec     t_approve_version_size_chart%ROWTYPE;
    p_t_siz_dt_rec  t_approve_version_size_chart_details%ROWTYPE;
    v_size_chart_id VARCHAR2(32);
    v_flag          INT;
  BEGIN
    --清空批版已生成的尺寸表数据
    scmdata.pkg_approve_version_size_chart.p_delete_t_approve_version_size_chart_all_data(p_company_id => p_company_id,
                                                                                          p_goo_id     => p_goo_id);
    SELECT COUNT(1)
      INTO v_flag
      FROM scmdata.t_size_chart t
     WHERE t.goo_id = p_goo_id
       AND t.company_id = p_company_id;
  
    IF v_flag > 0 THEN
      --同步商品档案尺寸表至批版                              
      FOR p_t_siz_tmp_rec IN (SELECT *
                                FROM scmdata.t_size_chart t
                               WHERE t.goo_id = p_goo_id
                                 AND t.company_id = p_company_id) LOOP
        v_size_chart_id                    := scmdata.f_get_uuid();
        p_t_siz_rec.size_chart_id          := v_size_chart_id;
        p_t_siz_rec.company_id             := p_t_siz_tmp_rec.company_id;
        p_t_siz_rec.goo_id                 := p_t_siz_tmp_rec.goo_id;
        p_t_siz_rec.seq_num                := p_t_siz_tmp_rec.seq_num;
        p_t_siz_rec.position               := p_t_siz_tmp_rec.position;
        p_t_siz_rec.quantitative_method    := p_t_siz_tmp_rec.quantitative_method;
        p_t_siz_rec.base_code              := p_t_siz_tmp_rec.base_code;
        p_t_siz_rec.base_value             := p_t_siz_tmp_rec.base_value;
        p_t_siz_rec.plus_toleran_range     := p_t_siz_tmp_rec.plus_toleran_range;
        p_t_siz_rec.negative_toleran_range := p_t_siz_tmp_rec.negative_toleran_range;
        p_t_siz_rec.pause                  := p_t_siz_tmp_rec.pause;
        p_t_siz_rec.create_id              := p_t_siz_tmp_rec.create_id;
        p_t_siz_rec.create_time            := p_t_siz_tmp_rec.create_time;
        p_t_siz_rec.update_id              := p_t_siz_tmp_rec.update_id;
        p_t_siz_rec.update_time            := p_t_siz_tmp_rec.update_time;
        p_t_siz_rec.memo                   := p_t_siz_tmp_rec.memo;
      
        scmdata.pkg_approve_version_size_chart.p_insert_t_approve_version_size_chart(p_t_siz_rec => p_t_siz_rec);
      
        FOR p_t_siz_dt_tmp_rec IN (SELECT *
                                     FROM scmdata.t_size_chart_details dt
                                    WHERE dt.size_chart_id =
                                          p_t_siz_tmp_rec.size_chart_id) LOOP
        
          p_t_siz_dt_rec.size_chart_dt_id := scmdata.f_get_uuid();
          p_t_siz_dt_rec.size_chart_id    := v_size_chart_id;
          p_t_siz_dt_rec.measure          := p_t_siz_dt_tmp_rec.measure;
          p_t_siz_dt_rec.measure_value    := p_t_siz_dt_tmp_rec.measure_value;
          p_t_siz_dt_rec.pause            := p_t_siz_dt_tmp_rec.pause;
          p_t_siz_dt_rec.create_id        := p_t_siz_dt_tmp_rec.create_id;
          p_t_siz_dt_rec.create_time      := p_t_siz_dt_tmp_rec.create_time;
          p_t_siz_dt_rec.update_id        := p_t_siz_dt_tmp_rec.update_id;
          p_t_siz_dt_rec.update_time      := p_t_siz_dt_tmp_rec.update_time;
          p_t_siz_dt_rec.memo             := p_t_siz_dt_tmp_rec.memo;
          scmdata.pkg_approve_version_size_chart.p_insert_t_approve_version_size_chart_details(p_t_siz_rec => p_t_siz_dt_rec);
        END LOOP;
      END LOOP;
    END IF;
  END p_sync_gd_size_chart_to_apv;

  --尺寸表导入
  --尺寸表导入表 修改，删除校验
  PROCEDURE p_check_t_size_chart_import_tmp_by_update(p_seq_num NUMBER,
                                                      p_type    INT DEFAULT 0) IS
  BEGIN
    IF p_seq_num = 0 THEN
      IF p_type = 0 THEN
        raise_application_error(-20002, '不可修改初始化提示数据');
      ELSE
        raise_application_error(-20002, '不可删除初始化提示数据');
      END IF;
    END IF;
  END p_check_t_size_chart_import_tmp_by_update;

  --尺寸导入表 提交校验
  PROCEDURE p_check_t_size_chart_import_tmp_by_submit(p_company_id VARCHAR2,
                                                      p_goo_id     VARCHAR2,
                                                      p_type       INT DEFAULT 0) IS
    v_cnt INT;
  BEGIN
    SELECT COUNT(DISTINCT a.seq_num)
      INTO v_cnt
      FROM t_size_chart_import_tmp a
     INNER JOIN t_size_chart_details_import_tmp b
        ON b.size_chart_id = a.size_chart_tmp_id
     WHERE a.company_id = p_company_id
       AND a.goo_id = p_goo_id
       AND a.seq_num <> 0;
    IF v_cnt < 1 THEN
      IF p_type = 0 THEN
        raise_application_error(-20002, '不可提交，至少需存在一条数据');
      ELSE
        raise_application_error(-20002, '不可删除，至少需存在一条数据');
      END IF;
    END IF;
  END p_check_t_size_chart_import_tmp_by_submit;

  --判断是否已存在尺寸导入表 行数据
  FUNCTION f_check_is_has_size_chart_import_data(p_company_id          VARCHAR2,
                                                 p_goo_id              VARCHAR2,
                                                 p_position            VARCHAR2,
                                                 p_quantitative_method VARCHAR2)
    RETURN INT IS
    v_flag INT;
  BEGIN
    SELECT COUNT(1)
      INTO v_flag
      FROM scmdata.t_size_chart_import_tmp t
     WHERE t.company_id = p_company_id
       AND t.goo_id = p_goo_id
       AND t.position = p_position
       AND t.quantitative_method = p_quantitative_method;
    RETURN v_flag;
  END f_check_is_has_size_chart_import_data;

  /*============================================*
  * Author   : CZH
  * Created  : 23-9月 -22
  * ALERTER  :
  * ALERTER_TIME  :
  * Purpose  : 查询 t_size_chart_import_tmp
  * Obj_Name    : f_query_t_size_chart_import_tmp
  *============================================*/
  FUNCTION f_query_t_size_chart_import_tmp(p_company_id VARCHAR2,
                                           p_goo_id     VARCHAR2) RETURN CLOB IS
    v_sql CLOB;
  BEGIN
    v_sql := 'SELECT a.size_chart_tmp_id,
       a.company_id,
       a.goo_id,
       LPAD(a.seq_num,2,''0'') seq_num,
       a.position,
       a.quantitative_method,
       a.base_code,
       a.base_value,
       abs(a.plus_toleran_range) plus_toleran_range,
       abs(a.negative_toleran_range) negative_toleran_range,
       c.company_dict_name measure,
       b.measure_value
  FROM scmdata.t_size_chart_import_tmp a
 INNER JOIN scmdata.t_size_chart_details_import_tmp b
    ON b.size_chart_id = a.size_chart_tmp_id
 INNER JOIN scmdata.sys_company_dict c
    ON c.company_dict_id = b.measure
 WHERE a.goo_id = ''' || p_goo_id || '''
   AND a.company_id = ''' || p_company_id || ''' 
 ORDER BY a.seq_num ASC,c.company_dict_sort ASC';
    RETURN v_sql;
  END f_query_t_size_chart_import_tmp;
  /*============================================*
  * Author   : CZH
  * Created  : 11-10月-22
  * ALERTER  :
  * ALERTER_TIME  :
  * Purpose  : 新增 t_size_chart_import_tmp
  * Obj_Name    : p_insert_t_size_chart_import_tmp
  *============================================*/
  PROCEDURE p_insert_t_size_chart_import_tmp(p_t_siz_rec scmdata.t_size_chart_import_tmp%ROWTYPE) IS
  BEGIN
    --校验部位唯一性
    p_check_size_chart_by_save(p_table      => 't_size_chart_import_tmp',
                               p_company_id => p_t_siz_rec.company_id,
                               p_goo_id     => p_t_siz_rec.goo_id,
                               p_position   => p_t_siz_rec.position);
    INSERT INTO t_size_chart_import_tmp
      (size_chart_tmp_id, company_id, goo_id, seq_num, position,
       quantitative_method, base_code, base_value, plus_toleran_range,
       negative_toleran_range, pause, create_id, create_time, update_id,
       update_time, memo)
    VALUES
      (p_t_siz_rec.size_chart_tmp_id, p_t_siz_rec.company_id,
       p_t_siz_rec.goo_id, p_t_siz_rec.seq_num, p_t_siz_rec.position,
       p_t_siz_rec.quantitative_method, p_t_siz_rec.base_code,
       p_t_siz_rec.base_value, p_t_siz_rec.plus_toleran_range,
       p_t_siz_rec.negative_toleran_range, p_t_siz_rec.pause,
       p_t_siz_rec.create_id, p_t_siz_rec.create_time, p_t_siz_rec.update_id,
       p_t_siz_rec.update_time, p_t_siz_rec.memo);
  END p_insert_t_size_chart_import_tmp;

  /*============================================*
  * Author   : CZH
  * Created  : 11-10月-22
  * ALERTER  :
  * ALERTER_TIME  :
  * Purpose  : 修改 t_size_chart_import_tmp
  * Obj_Name    : p_update_t_size_chart_import_tmp
  *============================================*/
  PROCEDURE p_update_t_size_chart_import_tmp(p_t_siz_rec scmdata.t_size_chart_import_tmp%ROWTYPE) IS
  BEGIN
    --校验部位唯一性
    p_check_size_chart_by_save(p_table      => 't_size_chart_import_tmp',
                               p_company_id => p_t_siz_rec.company_id,
                               p_goo_id     => p_t_siz_rec.goo_id,
                               p_position   => p_t_siz_rec.position);
    UPDATE t_size_chart_import_tmp t
       SET t.seq_num                = p_t_siz_rec.seq_num,
           t.position               = p_t_siz_rec.position,
           t.quantitative_method    = p_t_siz_rec.quantitative_method,
           t.base_code              = p_t_siz_rec.base_code,
           t.base_value             = p_t_siz_rec.base_value,
           t.plus_toleran_range     = p_t_siz_rec.plus_toleran_range,
           t.negative_toleran_range = p_t_siz_rec.negative_toleran_range,
           t.pause                  = p_t_siz_rec.pause,
           t.create_id              = p_t_siz_rec.create_id,
           t.create_time            = p_t_siz_rec.create_time,
           t.update_id              = p_t_siz_rec.update_id,
           t.update_time            = p_t_siz_rec.update_time,
           t.memo                   = p_t_siz_rec.memo
     WHERE t.size_chart_tmp_id = p_t_siz_rec.size_chart_tmp_id;
  END p_update_t_size_chart_import_tmp;

  /*============================================*
  * Author   : CZH
  * Created  : 11-10月-22
  * ALERTER  :
  * ALERTER_TIME  :
  * Purpose  : 删除 t_size_chart_import_tmp
  * Obj_Name    : p_delete_t_size_chart_import_tmp
  *============================================*/
  PROCEDURE p_delete_t_size_chart_import_tmp(p_t_siz_rec scmdata.t_size_chart_import_tmp%ROWTYPE) IS
  BEGIN
    DELETE FROM t_size_chart_import_tmp t
     WHERE t.size_chart_tmp_id = p_t_siz_rec.size_chart_tmp_id;
  END p_delete_t_size_chart_import_tmp;
  /*============================================*
  * Author   : CZH
  * Created  : 11-10月-22
  * ALERTER  :
  * ALERTER_TIME  :
  * Purpose  : 新增t_size_chart_details_import_tmp
  * Obj_Name    : P_INSERT_t_size_chart_details_import_tmp
  *============================================*/
  PROCEDURE p_insert_t_size_chart_details_import_tmp(p_t_siz_rec scmdata.t_size_chart_details_import_tmp%ROWTYPE) IS
  BEGIN
    INSERT INTO t_size_chart_details_import_tmp
      (size_chart_dt_tmp_id, size_chart_id, measure, measure_value, pause,
       create_id, create_time, update_id, update_time, memo)
    VALUES
      (p_t_siz_rec.size_chart_dt_tmp_id, p_t_siz_rec.size_chart_id,
       p_t_siz_rec.measure, p_t_siz_rec.measure_value, p_t_siz_rec.pause,
       p_t_siz_rec.create_id, p_t_siz_rec.create_time, p_t_siz_rec.update_id,
       p_t_siz_rec.update_time, p_t_siz_rec.memo);
  END p_insert_t_size_chart_details_import_tmp;

  /*============================================*
  * Author   : CZH
  * Created  : 11-10月-22
  * ALERTER  :
  * ALERTER_TIME  :
  * Purpose  : 修改t_size_chart_details_import_tmp
  * Obj_Name    : P_UPDATE_t_size_chart_details_import_tmp
  *============================================*/
  PROCEDURE p_update_t_size_chart_details_import_tmp(p_t_siz_rec scmdata.t_size_chart_details_import_tmp%ROWTYPE) IS
  BEGIN
    UPDATE t_size_chart_details_import_tmp t
       SET t.measure_value = p_t_siz_rec.measure_value,
           t.pause         = p_t_siz_rec.pause,
           t.create_id     = p_t_siz_rec.create_id,
           t.create_time   = p_t_siz_rec.create_time,
           t.update_id     = p_t_siz_rec.update_id,
           t.update_time   = p_t_siz_rec.update_time,
           t.memo          = p_t_siz_rec.memo
     WHERE t.size_chart_id = p_t_siz_rec.size_chart_id
       AND t.measure = p_t_siz_rec.measure;
  END p_update_t_size_chart_details_import_tmp;

  /*============================================*
  * Author   : CZH
  * Created  : 11-10月-22
  * ALERTER  :
  * ALERTER_TIME  :
  * Purpose  : 删除t_size_chart_details_import_tmp
  * Obj_Name    : P_DELETE_t_size_chart_details_import_tmp
  *============================================*/
  PROCEDURE p_delete_t_size_chart_details_import_tmp(p_t_siz_rec scmdata.t_size_chart_details_import_tmp%ROWTYPE) IS
  BEGIN
    DELETE FROM t_size_chart_details_import_tmp t
     WHERE t.size_chart_dt_tmp_id = p_t_siz_rec.size_chart_dt_tmp_id;
  END p_delete_t_size_chart_details_import_tmp;

  --删除尺寸导入表行数据
  PROCEDURE p_delete_t_size_chart_import_tmp_row_data(p_company_id          VARCHAR2,
                                                      p_goo_id              VARCHAR2,
                                                      p_position            VARCHAR2,
                                                      p_quantitative_method VARCHAR2) IS
  BEGIN
    --校验尺寸导入表
    p_check_t_size_chart_import_tmp_by_submit(p_company_id => p_company_id,
                                              p_goo_id     => p_goo_id,
                                              p_type       => 1);
  
    DELETE FROM t_size_chart_details_import_tmp a
     WHERE a.size_chart_id IN
           (SELECT t.size_chart_tmp_id
              FROM scmdata.t_size_chart_import_tmp t
             WHERE t.company_id = p_company_id
               AND t.goo_id = p_goo_id
               AND t.position = p_position
               AND t.quantitative_method = p_quantitative_method);
  
    DELETE FROM scmdata.t_size_chart_import_tmp t
     WHERE t.company_id = p_company_id
       AND p_goo_id = t.goo_id
       AND t.position = p_position
       AND t.quantitative_method = p_quantitative_method;
  END p_delete_t_size_chart_import_tmp_row_data;

  --删除尺寸导入表 所有数据
  PROCEDURE p_delete_t_size_chart_import_tmp_all_data(p_company_id VARCHAR2,
                                                      p_goo_id     VARCHAR2) IS
  BEGIN
    DELETE FROM t_size_chart_details_import_tmp a
     WHERE a.size_chart_id IN
           (SELECT t.size_chart_tmp_id
              FROM scmdata.t_size_chart_import_tmp t
             WHERE t.company_id = p_company_id
               AND p_goo_id = t.goo_id);
  
    DELETE FROM scmdata.t_size_chart_import_tmp t
     WHERE t.company_id = p_company_id
       AND p_goo_id = t.goo_id;
  END p_delete_t_size_chart_import_tmp_all_data;

  --删除尺寸导入表初始化生成的数据
  PROCEDURE p_delete_t_size_chart_import_first_generate_data(p_company_id VARCHAR2,
                                                             p_goo_id     VARCHAR2,
                                                             p_seq_num    INT) IS
    v_flag INT;
  BEGIN
    SELECT COUNT(1)
      INTO v_flag
      FROM scmdata.t_size_chart_import_tmp t
     WHERE t.company_id = p_company_id
       AND t.goo_id = p_goo_id
       AND t.seq_num = p_seq_num;
    IF v_flag > 0 THEN
      DELETE FROM t_size_chart_details_import_tmp a
       WHERE a.size_chart_id IN
             (SELECT t.size_chart_tmp_id
                FROM scmdata.t_size_chart_import_tmp t
               WHERE t.company_id = p_company_id
                 AND t.goo_id = p_goo_id
                 AND t.seq_num = p_seq_num);
    
      DELETE FROM scmdata.t_size_chart_import_tmp t
       WHERE t.company_id = p_company_id
         AND p_goo_id = t.goo_id
         AND t.seq_num = p_seq_num;
    ELSE
      NULL;
    END IF;
  END p_delete_t_size_chart_import_first_generate_data;

  --重置尺寸导入表
  PROCEDURE p_reset_size_chart_imp_tmp_data(p_company_id VARCHAR2,
                                            p_goo_id     VARCHAR2,
                                            p_user_id    VARCHAR2) IS
  BEGIN
    --清空所有数据
    p_delete_t_size_chart_import_tmp_all_data(p_company_id => p_company_id,
                                              p_goo_id     => p_goo_id);
    --根据商品档案-尺码表 初始化尺寸导入表
    p_first_generate_size_chart_imp_tmp_data(p_company_id => p_company_id,
                                             p_goo_id     => p_goo_id,
                                             p_user_id    => p_user_id);
  END p_reset_size_chart_imp_tmp_data;

  --根据商品档案-尺码表 初始化尺寸导入表
  PROCEDURE p_first_generate_size_chart_imp_tmp_data(p_company_id VARCHAR2,
                                                     p_goo_id     VARCHAR2,
                                                     p_user_id    VARCHAR2) IS
    p_t_siz_rec     t_size_chart_import_tmp%ROWTYPE;
    p_t_siz_dt_rec  t_size_chart_details_import_tmp%ROWTYPE;
    v_size_chart_id VARCHAR2(32);
    v_sizename      VARCHAR2(32);
  BEGIN
    v_size_chart_id                    := scmdata.f_get_uuid();
    p_t_siz_rec.size_chart_tmp_id      := v_size_chart_id;
    p_t_siz_rec.company_id             := p_company_id;
    p_t_siz_rec.goo_id                 := p_goo_id;
    p_t_siz_rec.seq_num                := 0;
    p_t_siz_rec.position               := '请从右侧工具栏先导出空数据模板，再进行尺寸表导入';
    p_t_siz_rec.quantitative_method    := NULL;
    p_t_siz_rec.base_code              := NULL;
    p_t_siz_rec.base_value             := NULL;
    p_t_siz_rec.plus_toleran_range     := NULL;
    p_t_siz_rec.negative_toleran_range := NULL;
    p_t_siz_rec.pause                  := 0;
    p_t_siz_rec.create_id              := p_user_id;
    p_t_siz_rec.create_time            := SYSDATE;
    p_t_siz_rec.update_id              := p_user_id;
    p_t_siz_rec.update_time            := SYSDATE;
    p_t_siz_rec.memo                   := NULL;
    --新增尺寸表主表
    scmdata.pkg_size_chart.p_insert_t_size_chart_import_tmp(p_t_siz_rec => p_t_siz_rec);
  
    FOR size_chart_dt_rec IN (SELECT DISTINCT t.sizename,
                                              t.goo_id,
                                              t.company_id,
                                              t.sizecode
                                FROM scmdata.t_commodity_color_size t
                               WHERE t.goo_id = p_goo_id
                                 AND t.company_id = p_company_id
                               ORDER BY t.sizecode ASC) LOOP
      p_t_siz_dt_rec.size_chart_dt_tmp_id := scmdata.f_get_uuid();
      p_t_siz_dt_rec.size_chart_id        := v_size_chart_id;
      v_sizename                          := scmdata.pkg_size_chart.f_get_size_company_dict(p_company_id => p_company_id,
                                                                                            p_size_name  => size_chart_dt_rec.sizename);
      p_t_siz_dt_rec.measure              := v_sizename;
      p_t_siz_dt_rec.measure_value        := NULL;
      p_t_siz_dt_rec.pause                := 0;
      p_t_siz_dt_rec.create_id            := p_user_id;
      p_t_siz_dt_rec.create_time          := SYSDATE;
      p_t_siz_dt_rec.update_id            := p_user_id;
      p_t_siz_dt_rec.update_time          := SYSDATE;
      p_t_siz_dt_rec.memo                 := NULL;
      --新增尺码
      scmdata.pkg_size_chart.p_insert_t_size_chart_details_import_tmp(p_t_siz_rec => p_t_siz_dt_rec);
    END LOOP;
  END p_first_generate_size_chart_imp_tmp_data;

  --商品档案尺寸表导入，点提交生成数据至尺寸表（业务表）
  PROCEDURE p_generate_size_chart_by_good_import(p_company_id VARCHAR2,
                                                 p_goo_id     VARCHAR2) IS
    p_t_siz_rec     t_size_chart%ROWTYPE;
    p_t_siz_dt_rec  t_size_chart_details%ROWTYPE;
    v_size_chart_id VARCHAR2(32);
  BEGIN
    --提交校验尺寸导入表
    p_check_t_size_chart_import_tmp_by_submit(p_company_id => p_company_id,
                                              p_goo_id     => p_goo_id);
  
    --生成尺寸表前，删除该货号对应的所有尺寸表数据
    p_delete_t_size_chart_all_data(p_company_id => p_company_id,
                                   p_goo_id     => p_goo_id);
    --生成尺寸表                              
    FOR p_t_siz_tmp_rec IN (SELECT *
                              FROM scmdata.t_size_chart_import_tmp t
                             WHERE t.goo_id = p_goo_id
                               AND t.company_id = p_company_id) LOOP
      v_size_chart_id                    := scmdata.f_get_uuid();
      p_t_siz_rec.size_chart_id          := v_size_chart_id;
      p_t_siz_rec.company_id             := p_t_siz_tmp_rec.company_id;
      p_t_siz_rec.goo_id                 := p_t_siz_tmp_rec.goo_id;
      p_t_siz_rec.seq_num                := p_t_siz_tmp_rec.seq_num;
      p_t_siz_rec.position               := p_t_siz_tmp_rec.position;
      p_t_siz_rec.quantitative_method    := p_t_siz_tmp_rec.quantitative_method;
      p_t_siz_rec.base_code              := p_t_siz_tmp_rec.base_code;
      p_t_siz_rec.base_value             := p_t_siz_tmp_rec.base_value;
      p_t_siz_rec.plus_toleran_range     := p_t_siz_tmp_rec.plus_toleran_range;
      p_t_siz_rec.negative_toleran_range := p_t_siz_tmp_rec.negative_toleran_range;
      p_t_siz_rec.pause                  := p_t_siz_tmp_rec.pause;
      p_t_siz_rec.create_id              := p_t_siz_tmp_rec.create_id;
      p_t_siz_rec.create_time            := p_t_siz_tmp_rec.create_time;
      p_t_siz_rec.update_id              := p_t_siz_tmp_rec.update_id;
      p_t_siz_rec.update_time            := p_t_siz_tmp_rec.update_time;
      p_t_siz_rec.memo                   := p_t_siz_tmp_rec.memo;
    
      p_insert_t_size_chart(p_t_siz_rec => p_t_siz_rec);
    
      FOR p_t_siz_dt_tmp_rec IN (SELECT *
                                   FROM scmdata.t_size_chart_details_import_tmp dt
                                  WHERE dt.size_chart_id =
                                        p_t_siz_tmp_rec.size_chart_tmp_id) LOOP
      
        p_t_siz_dt_rec.size_chart_dt_id := scmdata.f_get_uuid();
        p_t_siz_dt_rec.size_chart_id    := v_size_chart_id;
        p_t_siz_dt_rec.measure          := p_t_siz_dt_tmp_rec.measure;
        p_t_siz_dt_rec.measure_value    := p_t_siz_dt_tmp_rec.measure_value;
        p_t_siz_dt_rec.pause            := p_t_siz_dt_tmp_rec.pause;
        p_t_siz_dt_rec.create_id        := p_t_siz_dt_tmp_rec.create_id;
        p_t_siz_dt_rec.create_time      := p_t_siz_dt_tmp_rec.create_time;
        p_t_siz_dt_rec.update_id        := p_t_siz_dt_tmp_rec.update_id;
        p_t_siz_dt_rec.update_time      := p_t_siz_dt_tmp_rec.update_time;
        p_t_siz_dt_rec.memo             := p_t_siz_dt_tmp_rec.memo;
        p_insert_t_size_chart_details(p_t_siz_rec => p_t_siz_dt_rec);
      END LOOP;
    END LOOP;
    --商品档案生成尺寸表后同步更新至同货号批版单据
    p_sync_gd_size_chart_to_apv(p_company_id => p_company_id,
                                p_goo_id     => p_goo_id);
  END p_generate_size_chart_by_good_import;

  --批版尺寸表导入，点提交生成数据至尺寸表（业务表）
  PROCEDURE p_generate_size_chart_by_apv_import(p_company_id VARCHAR2,
                                                p_goo_id     VARCHAR2) IS
    p_t_siz_rec     t_approve_version_size_chart%ROWTYPE;
    p_t_siz_dt_rec  t_approve_version_size_chart_details%ROWTYPE;
    v_size_chart_id VARCHAR2(32);
  BEGIN
    --提交校验尺寸导入表
    p_check_t_size_chart_import_tmp_by_submit(p_company_id => p_company_id,
                                              p_goo_id     => p_goo_id);
  
    --生成尺寸表前，删除该货号对应的所有尺寸表数据
    p_delete_t_size_chart_all_data(p_company_id => p_company_id,
                                   p_goo_id     => p_goo_id);
    --生成尺寸表                              
    FOR p_t_siz_tmp_rec IN (SELECT *
                              FROM scmdata.t_size_chart_import_tmp t
                             WHERE t.goo_id = p_goo_id
                               AND t.company_id = p_company_id) LOOP
      v_size_chart_id                    := scmdata.f_get_uuid();
      p_t_siz_rec.size_chart_id          := v_size_chart_id;
      p_t_siz_rec.company_id             := p_t_siz_tmp_rec.company_id;
      p_t_siz_rec.goo_id                 := p_t_siz_tmp_rec.goo_id;
      p_t_siz_rec.seq_num                := p_t_siz_tmp_rec.seq_num;
      p_t_siz_rec.position               := p_t_siz_tmp_rec.position;
      p_t_siz_rec.quantitative_method    := p_t_siz_tmp_rec.quantitative_method;
      p_t_siz_rec.base_code              := p_t_siz_tmp_rec.base_code;
      p_t_siz_rec.base_value             := p_t_siz_tmp_rec.base_value;
      p_t_siz_rec.plus_toleran_range     := p_t_siz_tmp_rec.plus_toleran_range;
      p_t_siz_rec.negative_toleran_range := p_t_siz_tmp_rec.negative_toleran_range;
      p_t_siz_rec.pause                  := p_t_siz_tmp_rec.pause;
      p_t_siz_rec.create_id              := p_t_siz_tmp_rec.create_id;
      p_t_siz_rec.create_time            := p_t_siz_tmp_rec.create_time;
      p_t_siz_rec.update_id              := p_t_siz_tmp_rec.update_id;
      p_t_siz_rec.update_time            := p_t_siz_tmp_rec.update_time;
      p_t_siz_rec.memo                   := p_t_siz_tmp_rec.memo;
    
      scmdata.pkg_approve_version_size_chart.p_insert_t_approve_version_size_chart(p_t_siz_rec => p_t_siz_rec);
    
      FOR p_t_siz_dt_tmp_rec IN (SELECT *
                                   FROM scmdata.t_size_chart_details_import_tmp dt
                                  WHERE dt.size_chart_id =
                                        p_t_siz_tmp_rec.size_chart_tmp_id) LOOP
      
        p_t_siz_dt_rec.size_chart_dt_id := scmdata.f_get_uuid();
        p_t_siz_dt_rec.size_chart_id    := v_size_chart_id;
        p_t_siz_dt_rec.measure          := p_t_siz_dt_tmp_rec.measure;
        p_t_siz_dt_rec.measure_value    := p_t_siz_dt_tmp_rec.measure_value;
        p_t_siz_dt_rec.pause            := p_t_siz_dt_tmp_rec.pause;
        p_t_siz_dt_rec.create_id        := p_t_siz_dt_tmp_rec.create_id;
        p_t_siz_dt_rec.create_time      := p_t_siz_dt_tmp_rec.create_time;
        p_t_siz_dt_rec.update_id        := p_t_siz_dt_tmp_rec.update_id;
        p_t_siz_dt_rec.update_time      := p_t_siz_dt_tmp_rec.update_time;
        p_t_siz_dt_rec.memo             := p_t_siz_dt_tmp_rec.memo;
        scmdata.pkg_approve_version_size_chart.p_insert_t_approve_version_size_chart_details(p_t_siz_rec => p_t_siz_dt_rec);
      END LOOP;
    END LOOP;
  END p_generate_size_chart_by_apv_import;

  --获取商品档案带入的尺码表类型
  --字母码，数字码
  FUNCTION f_get_good_size_chart_type(p_company_id VARCHAR2,
                                      p_goo_id     VARCHAR2) RETURN VARCHAR2 IS
    v_rtn_val VARCHAR2(32);
  BEGIN
    SELECT CASE
             WHEN regexp_like(sizename, '^[0-9]+[0-9]$') THEN
              'SL_GDN'
             ELSE
              'SL_GDV'
           END
      INTO v_rtn_val
      FROM (SELECT DISTINCT t.sizename
              FROM scmdata.t_commodity_color_size t
             WHERE t.goo_id = p_goo_id
               AND t.company_id = p_company_id)
     WHERE rownum = 1;
    RETURN v_rtn_val;
  END f_get_good_size_chart_type;
  --尺寸表增加尺码列
  PROCEDURE p_insert_size_chart_col(p_company_id VARCHAR2,
                                    p_goo_id     VARCHAR2,
                                    p_user_id    VARCHAR2,
                                    p_size_col   VARCHAR2) IS
    p_t_siz_dt_rec scmdata.t_size_chart_details_import_tmp%ROWTYPE;
    v_flag         INT;
  BEGIN
    SELECT COUNT(1)
      INTO v_flag
      FROM (SELECT listagg(DISTINCT a.measure, ';') measure
              FROM scmdata.t_size_chart_import_tmp t
             INNER JOIN scmdata.t_size_chart_details_import_tmp a
                ON a.size_chart_id = t.size_chart_tmp_id
             WHERE t.goo_id = p_goo_id
               AND t.company_id = p_company_id) v
     WHERE instr(v.measure, p_size_col) > 0;
  
    IF v_flag > 0 THEN
      raise_application_error(-20002, '当前尺码已存在，不可添加');
    END IF;
  
    FOR size_chart_rec IN (SELECT t.size_chart_tmp_id
                             FROM scmdata.t_size_chart_import_tmp t
                            WHERE t.goo_id = p_goo_id
                              AND t.company_id = p_company_id) LOOP
      p_t_siz_dt_rec.size_chart_dt_tmp_id := scmdata.f_get_uuid();
      p_t_siz_dt_rec.size_chart_id        := size_chart_rec.size_chart_tmp_id;
      p_t_siz_dt_rec.measure              := p_size_col;
      p_t_siz_dt_rec.measure_value        := NULL;
      p_t_siz_dt_rec.pause                := 0;
      p_t_siz_dt_rec.create_id            := p_user_id;
      p_t_siz_dt_rec.create_time          := SYSDATE;
      p_t_siz_dt_rec.update_id            := p_user_id;
      p_t_siz_dt_rec.update_time          := SYSDATE;
      p_t_siz_dt_rec.memo                 := '';
      p_insert_t_size_chart_details_import_tmp(p_t_siz_rec => p_t_siz_dt_rec);
    END LOOP;
  END p_insert_size_chart_col;

  --自动生成尺寸相关表序号
  --默认加1
  FUNCTION f_get_size_chart_seq_num(p_company_id VARCHAR2,
                                    p_goo_id     VARCHAR2,
                                    p_table      VARCHAR2) RETURN NUMBER IS
    v_sql     CLOB;
    v_seq_num NUMBER;
  BEGIN
    v_sql := q'[SELECT NVL(MAX(t.seq_num),0) + 1
    FROM ]' || p_table || q'[ t
   WHERE t.goo_id = :goo_id
     AND t.company_id = :company_id
     AND t.seq_num <> 99]';
  
    EXECUTE IMMEDIATE v_sql
      INTO v_seq_num
      USING p_goo_id, p_company_id;
    RETURN v_seq_num;
  END f_get_size_chart_seq_num;

  --序号校验
  PROCEDURE p_check_new_seq_no(p_new_seq_num VARCHAR2) IS
    v_flag INT;
  BEGIN
    IF p_new_seq_num = 99 THEN
      raise_application_error(-20002,
                              '序号为99的仅用于克重部位，不可作为其他部位的序号，请修改！');
    END IF;
  
    SELECT COUNT(1)
      INTO v_flag
      FROM dual
     WHERE regexp_like(p_new_seq_num, '^[1-9][0-9]?$');
  
    IF v_flag = 0 THEN
      raise_application_error(-20002,
                              '【序号】只能填写正整数，且限制最大两位数');
    END IF;
  END p_check_new_seq_no;

  --序号重排
  --有序的尺寸表中插入或删除序号，并保持有序
  --5
  --1,2,3,4,5,6,7,8,9,10
  PROCEDURE p_reset_size_chart_seq_num(p_company_id    VARCHAR2,
                                       p_goo_id        VARCHAR2,
                                       p_orgin_seq_num NUMBER, --原序号
                                       p_new_seq_num   NUMBER DEFAULT NULL, --1）找要插入的位置 
                                       p_type          INT,
                                       p_table         VARCHAR2,
                                       p_table_pk_id   VARCHAR2,
                                       p_is_check      INT DEFAULT 0) IS
    v_orgin_size_chart_id VARCHAR2(32);
    v_sql                 CLOB;
    v_flag                INT;
    v_max_seq_num         INT;
  BEGIN
    IF p_is_check = 1 THEN
      IF p_orgin_seq_num = 99 THEN
        raise_application_error(-20002, '【克重】序号默认为99，不可调整！');
      END IF;
      SELECT COUNT(1)
        INTO v_flag
        FROM dual
       WHERE regexp_like(p_new_seq_num, '^[1-9][0-9]?$');
    
      IF v_flag = 0 THEN
        raise_application_error(-20002,
                                '【序号】只能填写正整数，且限制最大两位数');
      ELSE
        EXECUTE IMMEDIATE 'SELECT MAX(t.seq_num)
        FROM scmdata.' || p_table || ' t
       WHERE t.goo_id = :goo_id
         AND t.company_id = :company_id
         AND t.seq_num <> 99'
          INTO v_max_seq_num
          USING p_goo_id, p_company_id;
      
        IF p_new_seq_num > v_max_seq_num THEN
          raise_application_error(-20002,
                                  '不可调整序号！输入的序号不能大于当前尺寸表最大序号');
        END IF;
      END IF;
    END IF;
    --插入序号 
    IF p_type = 0 THEN
      --获取原序号对应的ID
      EXECUTE IMMEDIATE 'SELECT MAX(t.' || p_table_pk_id || ')
        FROM scmdata.' || p_table || ' t
       WHERE t.goo_id = :goo_id
         AND t.company_id = :company_id
         AND t.seq_num = :orgin_seq_num
         AND t.seq_num <> 99'
        INTO v_orgin_size_chart_id
        USING p_goo_id, p_company_id, p_orgin_seq_num;
    
      --2）将该位置后面的数据，都往后挪一位
    
      IF p_orgin_seq_num > p_new_seq_num THEN
        EXECUTE IMMEDIATE 'UPDATE scmdata.' || p_table || ' t
         SET t.seq_num = (CASE WHEN t.seq_num = 99 THEN 99 ELSE t.seq_num + 1 END)
       WHERE t.goo_id = :goo_id
         AND t.company_id = :company_id
         AND t.seq_num >= :new_seq_num
         AND t.seq_num < :orgin_seq_num'
          USING p_goo_id, p_company_id, p_new_seq_num, p_orgin_seq_num;
      ELSIF p_orgin_seq_num < p_new_seq_num THEN
        EXECUTE IMMEDIATE 'UPDATE scmdata.' || p_table || ' t
         SET t.seq_num = (CASE WHEN t.seq_num = 99 THEN 99 ELSE t.seq_num - 1 END)
       WHERE t.goo_id = :goo_id
         AND t.company_id = :company_id
         AND t.seq_num > :orgin_seq_num
         AND t.seq_num <= :new_seq_num'
          USING p_goo_id, p_company_id, p_orgin_seq_num, p_new_seq_num;
      ELSE
        NULL;
      END IF;
    
      --3）把新数据插到该位置
      EXECUTE IMMEDIATE 'UPDATE scmdata.' || p_table || ' t
         SET t.seq_num = :new_seq_num
       WHERE t.goo_id = :goo_id
         AND t.company_id = :company_id
         AND t.' || p_table_pk_id ||
                        ' = :orgin_size_chart_id'
        USING p_new_seq_num, p_goo_id, p_company_id, v_orgin_size_chart_id;
      --删除序号
    ELSIF p_type = 1 THEN
      --2）将该位置后面的数据，都往前挪一位       
      v_sql := q'[UPDATE ]' || p_table || q'[ a
         SET a.seq_num = (CASE WHEN a.seq_num = 99 THEN 99 ELSE a.seq_num - 1 END)
       WHERE a.]' || p_table_pk_id ||
               q'[ IN
             (SELECT t.]' || p_table_pk_id || q'[ 
                FROM ]' || p_table ||
               q'[ t
               WHERE t.goo_id = :goo_id
                 AND t.company_id = :company_id
                 AND t.seq_num > :orgin_seq_num)]';
    
      EXECUTE IMMEDIATE v_sql
        USING p_goo_id, p_company_id, p_orgin_seq_num;
    END IF;
  
  END p_reset_size_chart_seq_num;

  --判断尺寸表数据行是否存在
  FUNCTION f_is_has_size_chart_row_data(p_company_id          VARCHAR2,
                                        p_goo_id              VARCHAR2,
                                        p_position            VARCHAR2,
                                        p_quantitative_method VARCHAR2,
                                        p_table               VARCHAR2)
    RETURN INT IS
    v_flag INT;
    v_sql  CLOB;
  BEGIN
    v_sql := q'[
    SELECT COUNT(1)
      FROM ]' || p_table ||
             q'[ t
     WHERE t.goo_id = :goo_id
       AND t.company_id = :company_id
       AND t.position = :position
       AND t.quantitative_method = :quantitative_method]';
  
    EXECUTE IMMEDIATE v_sql
      INTO v_flag
      USING p_goo_id, p_company_id, p_position, p_quantitative_method;
  
    RETURN v_flag;
  END f_is_has_size_chart_row_data;
  --根据部位判断是否存在克重
  PROCEDURE p_is_has_grammage(p_company_id VARCHAR2,
                              p_goo_id     VARCHAR2,
                              p_table      VARCHAR2,
                              p_grammage   VARCHAR2 DEFAULT NULL,
                              p_type       INT DEFAULT 0) IS
    v_flag         INT;
    v_old_grammage VARCHAR2(256);
    v_sql          CLOB;
  BEGIN
    v_sql := q'[SELECT COUNT(1), MAX(t.position)
      FROM scmdata.]' || p_table || q'[ t
     WHERE t.company_id = :company_id
       AND t.goo_id = :goo_id
       AND t.seq_num = 99]';
  
    EXECUTE IMMEDIATE v_sql
      INTO v_flag, v_old_grammage
      USING p_company_id, p_goo_id;
  
    IF v_flag > 0 THEN
      IF p_type = 0 THEN
        IF v_old_grammage = p_grammage THEN
          NULL;
        ELSE
          raise_application_error(-20002,
                                  '已存在克重，请删除克重后再新增！');
        END IF;
      ELSIF p_type = 1 THEN
        raise_application_error(-20002, '已存在克重，请删除克重后再新增！');
      ELSE
        NULL;
      END IF;
    END IF;
  END p_is_has_grammage;
  --克重新增判断
  PROCEDURE p_is_has_grammage_row_data(p_company_id          VARCHAR2,
                                       p_goo_id              VARCHAR2,
                                       p_position            VARCHAR2,
                                       p_quantitative_method VARCHAR2,
                                       p_table1              VARCHAR2,
                                       p_table2              VARCHAR2,
                                       p_table1_pk_id        VARCHAR2 DEFAULT 'size_chart_id') IS
    v_all_measure_sql      CLOB;
    v_grammage_measure_sql CLOB;
    v_all_measure_cnt      INT;
    v_grammage_measure_cnt INT;
  BEGIN
    v_all_measure_sql := q'[SELECT COUNT(DISTINCT ts.measure)
      FROM scmdata.]' || p_table1 ||
                         q'[ t
     INNER JOIN scmdata.]' || p_table2 ||
                         q'[ ts
        ON ts.size_chart_id = t.]' ||
                         p_table1_pk_id || q'[
     WHERE t.company_id = :company_id
       AND t.goo_id = :goo_id
       AND t.position <> :position
       AND t.quantitative_method <> :quantitative_method]';
  
    EXECUTE IMMEDIATE v_all_measure_sql
      INTO v_all_measure_cnt
      USING p_company_id, p_goo_id, p_position, p_quantitative_method;
  
    v_grammage_measure_sql := q'[SELECT COUNT(1)
      FROM scmdata.]' || p_table1 ||
                              q'[ t
     INNER JOIN scmdata.]' || p_table2 ||
                              q'[ ts
        ON ts.size_chart_id = t.]' ||
                              p_table1_pk_id || q'[
     WHERE t.company_id = :company_id
       AND t.goo_id = :goo_id
       AND t.position = :position
       AND t.quantitative_method = :quantitative_method]';
    EXECUTE IMMEDIATE v_grammage_measure_sql
      INTO v_grammage_measure_cnt
      USING p_company_id, p_goo_id, p_position, p_quantitative_method;
  
    IF v_grammage_measure_cnt > v_all_measure_cnt THEN
      raise_application_error(-20002, '已存在克重，不可新增！');
    ELSE
      NULL;
    END IF;
  
  END p_is_has_grammage_row_data;

END pkg_size_chart;
/

