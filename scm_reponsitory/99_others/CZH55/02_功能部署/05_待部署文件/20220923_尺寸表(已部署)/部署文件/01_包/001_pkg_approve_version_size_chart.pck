CREATE OR REPLACE PACKAGE scmdata.pkg_approve_version_size_chart IS

  -- Author  : SANFU
  -- Created : 2022/10/17 11:15:49
  -- Purpose : 批版尺寸表

  --查询t_approve_version_size_chart_tmp
  FUNCTION f_query_t_approve_version_size_chart_tmp RETURN CLOB;
  --新增t_approve_version_size_chart_tmp
  PROCEDURE p_insert_t_approve_version_size_chart_tmp(p_t_siz_rec t_approve_version_size_chart_tmp%ROWTYPE);
  --修改t_approve_version_size_chart_tmp
  PROCEDURE p_update_t_approve_version_size_chart_tmp(p_t_siz_rec t_approve_version_size_chart_tmp%ROWTYPE);
  --删除尺寸临时表行数据
  PROCEDURE p_delete_t_approve_version_size_chart_tmp(p_size_chart_tmp_id VARCHAR2);
  --校验是否有选择模板生成的数据
  PROCEDURE p_check_is_has_size_chart_moudle_data(p_company_id VARCHAR2,
                                                  p_goo_id     VARCHAR2);
  --批版尺寸临时表删除校验
  PROCEDURE p_check_size_chart_tmp_by_delete(p_company_id VARCHAR2,
                                             p_goo_id     VARCHAR2);
  --判断是否存在尺寸表（业务表）
  FUNCTION f_check_is_has_size_chart(p_company_id VARCHAR2,
                                     p_goo_id     VARCHAR2) RETURN INT;
  /*============================================*
  * Author   : CZH
  * Created  : 23-9月 -22
  * ALERTER  :
  * ALERTER_TIME  :
  * Purpose  : 删除 t_approve_version_size_chart_tmp
  * Obj_Name    : p_delete_t_approve_version_size_chart_tmp
  *============================================*/
  PROCEDURE p_delete_t_approve_version_size_chart_tmp(p_company_id VARCHAR2,
                                                      p_goo_id     VARCHAR2);
  --根据选择模板 生成尺寸临时表
  PROCEDURE p_generate_size_chart_tmp(p_company_id        VARCHAR2,
                                      p_goo_id            VARCHAR2,
                                      p_user_id           VARCHAR2,
                                      p_size_chart_moudle VARCHAR2);

  --提交校验
  PROCEDURE p_check_size_chart_moudle_by_submit(p_goo_id     VARCHAR2,
                                                p_company_id VARCHAR2);

  /*============================================*
  * Author   : CZH
  * Created  : 23-9月 -22
  * ALERTER  :
  * ALERTER_TIME  :
  * Purpose  : 删除 所有尺寸表临时数据
  * Obj_Name    : P_DELETE_T_SIZE_CHART_TMP
  *============================================*/
  PROCEDURE p_delete_t_size_chart_all_tmp_data(p_company_id VARCHAR2,
                                               p_goo_id     VARCHAR2);

  /*============================================*
  * Author   : CZH
  * Created  : 23-9月 -22
  * ALERTER  :
  * ALERTER_TIME  :
  * Purpose  : 删除 T_APPROVE_VERSION_SIZE_CHART_DETAILS_TMP
  * Obj_Name    : P_DELETE_T_SIZE_CHART_TMP
  *============================================*/
  PROCEDURE p_delete_t_size_chart_dt_tmp(p_company_id VARCHAR2,
                                         p_goo_id     VARCHAR2);

  --尺寸表模板，提交生成尺寸临时表
  PROCEDURE p_generate_size_chart_dt_tmp(p_company_id VARCHAR2,
                                         p_goo_id     VARCHAR2,
                                         p_user_id    VARCHAR2);

  /*============================================*
  * Author   : CZH
  * Created  : 23-9月 -22
  * ALERTER  :
  * ALERTER_TIME  :
  * Purpose  : 查询 T_SIZE_CHART_DETAILS_TMP
  * Obj_Name    : F_QUERY_T_SIZE_CHART_DT_TMP
  *============================================*/
  FUNCTION f_query_t_approve_version_size_chart_details_tmp(p_user_id    VARCHAR2,
                                                            p_company_id VARCHAR2)
    RETURN CLOB;

  /*============================================*
  * Author   : CZH
  * Created  : 23-9月 -22
  * ALERTER  :
  * ALERTER_TIME  :
  * Purpose  : 新增 T_APPROVE_VERSION_SIZE_CHART_DETAILS_TMP
  * Obj_Name    : P_INSERT_T_SIZE_CHART_DT_TMP
  *============================================*/
  PROCEDURE p_insert_t_approve_version_size_chart_dt_tmp(p_t_siz_rec t_approve_version_size_chart_details_tmp%ROWTYPE);

  /*============================================*
  * Author   : CZH
  * Created  : 23-9月 -22
  * ALERTER  :
  * ALERTER_TIME  :
  * Purpose  :  修改 T_SIZE_CHART_DETAILS_TMP
  * Obj_Name    : P_UPDATE_T_SIZE_CHART_DT_TMP
  *============================================*/
  PROCEDURE p_update_t_approve_version_size_chart_details_tmp(p_t_siz_rec t_approve_version_size_chart_details_tmp%ROWTYPE);

  --删除尺寸临时表(含尺码)行数据
  PROCEDURE p_delete_t_approve_version_size_chart_details_tmp(p_company_id          VARCHAR2,
                                                              p_goo_id              VARCHAR2,
                                                              p_position            VARCHAR2,
                                                              p_quantitative_method VARCHAR2);

  /*============================================*
  * Author   : CZH
  * Created  : 23-9月 -22
  * ALERTER  :
  * ALERTER_TIME  :
  * Purpose  : 删除 T_SIZE_CHART_DETAILS_TMP
  * Obj_Name    : P_DELETE_T_SIZE_CHART_TMP
  *============================================*/
  PROCEDURE p_delete_t_approve_version_size_chart_details_tmp(p_company_id VARCHAR2,
                                                              p_goo_id     VARCHAR2);

  --尺寸临时表（含尺码）删除校验
  PROCEDURE p_check_size_chart_dt_tmp_by_delete(p_company_id VARCHAR2,
                                                p_goo_id     VARCHAR2);
  --判断是否已存在尺寸表(临时表)数据
  FUNCTION f_check_is_has_size_chart_tmp_data(p_company_id          VARCHAR2,
                                              p_goo_id              VARCHAR2,
                                              p_position            VARCHAR2,
                                              p_quantitative_method VARCHAR2)
    RETURN INT;
  --校验临时表尺码只能填数字
  PROCEDURE p_check_size_chart_by_update(p_measure_value VARCHAR2);
  --提交校验必填项是否为空
  PROCEDURE p_check_size_chart_by_submit(p_company_id VARCHAR2,
                                         p_goo_id     VARCHAR2);
  --生成尺寸表（业务表）
  PROCEDURE p_generate_size_chart(p_company_id VARCHAR2, p_goo_id VARCHAR2);
  /*============================================*
  * Author   : CZH
  * Created  : 23-9月 -22
  * ALERTER  :
  * ALERTER_TIME  :
  * Purpose  : 查询T_SIZE_CHART
  * Obj_Name    : F_QUERY_T_SIZE_CHART_TMP
  *============================================*/
  FUNCTION f_query_t_approve_version_size_chart(p_goo_id     VARCHAR2,
                                                p_company_id VARCHAR2)
    RETURN CLOB;
  /*============================================*
  * Author   : CZH
  * Created  : 11-10月-22
  * ALERTER  :
  * ALERTER_TIME  :
  * Purpose  : 新增T_SIZE_CHART
  * Obj_Name    : P_INSERT_T_SIZE_CHART
  *============================================*/
  PROCEDURE p_insert_t_approve_version_size_chart(p_t_siz_rec scmdata.t_approve_version_size_chart%ROWTYPE);

  /*============================================*
  * Author   : CZH
  * Created  : 11-10月-22
  * ALERTER  :
  * ALERTER_TIME  :
  * Purpose  : 修改T_SIZE_CHART
  * Obj_Name    : P_UPDATE_T_SIZE_CHART
  *============================================*/
  PROCEDURE p_update_t_approve_version_size_chart(p_t_siz_rec scmdata.t_approve_version_size_chart%ROWTYPE);

  /*============================================*
  * Author   : CZH
  * Created  : 11-10月-22
  * ALERTER  :
  * ALERTER_TIME  :
  * Purpose  : 删除T_SIZE_CHART
  * Obj_Name    : P_DELETE_T_SIZE_CHART
  *============================================*/
  PROCEDURE p_delete_t_approve_version_size_chart(p_t_siz_rec scmdata.t_approve_version_size_chart%ROWTYPE);
  /*============================================*
  * Author   : CZH
  * Created  : 11-10月-22
  * ALERTER  :
  * ALERTER_TIME  :
  * Purpose  : 新增T_SIZE_CHART_DETAILS
  * Obj_Name    : P_INSERT_T_SIZE_CHART_DETAILS
  *============================================*/
  PROCEDURE p_insert_t_approve_version_size_chart_details(p_t_siz_rec scmdata.t_approve_version_size_chart_details%ROWTYPE);

  /*============================================*
  * Author   : CZH
  * Created  : 11-10月-22
  * ALERTER  :
  * ALERTER_TIME  :
  * Purpose  : 修改T_SIZE_CHART_DETAILS
  * Obj_Name    : P_UPDATE_T_SIZE_CHART_DETAILS
  *============================================*/
  PROCEDURE p_update_t_approve_version_size_chart_details(p_t_siz_rec scmdata.t_approve_version_size_chart_details%ROWTYPE);

  /*============================================*
  * Author   : CZH
  * Created  : 11-10月-22
  * ALERTER  :
  * ALERTER_TIME  :
  * Purpose  : 删除T_SIZE_CHART_DETAILS
  * Obj_Name    : P_DELETE_T_SIZE_CHART_DETAILS
  *============================================*/
  PROCEDURE p_delete_t_approve_version_size_chart_details(p_t_siz_rec scmdata.t_approve_version_size_chart_details%ROWTYPE);

  --删除尺寸表（业务表）行数据
  PROCEDURE p_delete_t_approve_version_size_chart_row_data(p_company_id          VARCHAR2,
                                                           p_goo_id              VARCHAR2,
                                                           p_position            VARCHAR2,
                                                           p_quantitative_method VARCHAR2);

  --删除尺寸表（业务表）所有数据
  PROCEDURE p_delete_t_approve_version_size_chart_all_data(p_company_id VARCHAR2,
                                                           p_goo_id     VARCHAR2);
  --判断是否已存在尺寸表(业务表)行数据
  FUNCTION f_check_is_has_size_chart_data(p_company_id          VARCHAR2,
                                          p_goo_id              VARCHAR2,
                                          p_position            VARCHAR2,
                                          p_quantitative_method VARCHAR2)
    RETURN INT;
  --尺寸表含尺码（业务表）删除校验
  PROCEDURE p_check_t_approve_version_size_chart_by_delete(p_company_id VARCHAR2,
                                                           p_goo_id     VARCHAR2);
  --批版单据生成尺寸表，点击审核后同步更新至同货号商品档案
  PROCEDURE p_sync_apv_size_chart_to_gd_by_examine(p_company_id VARCHAR2,
                                                   p_goo_id     VARCHAR2);
END pkg_approve_version_size_chart;
/
CREATE OR REPLACE PACKAGE BODY scmdata.pkg_approve_version_size_chart IS
  /*============================================*
  * Author   : CZH
  * Created  : 23-9月 -22
  * ALERTER  :
  * ALERTER_TIME  :
  * Purpose  : 查询t_approve_version_size_chart_tmp
  * Obj_Name    : F_QUERY_t_approve_version_size_chart_tmp
  *============================================*/
  FUNCTION f_query_t_approve_version_size_chart_tmp RETURN CLOB IS
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
  FROM t_approve_version_size_chart_tmp t
 WHERE t.goo_id = :goo_id
   AND t.company_id = %default_company_id%
 ORDER BY t.seq_num ASC';
    RETURN v_sql;
  END f_query_t_approve_version_size_chart_tmp;

  /*============================================*
  * Author   : CZH
  * Created  : 23-9月 -22
  * ALERTER  :
  * ALERTER_TIME  :
  * Purpose  : 新增t_approve_version_size_chart_tmp
  * Obj_Name    : P_INSERT_t_approve_version_size_chart_tmp
  *============================================*/
  PROCEDURE p_insert_t_approve_version_size_chart_tmp(p_t_siz_rec t_approve_version_size_chart_tmp%ROWTYPE) IS
  BEGIN
    --校验部位唯一性
    scmdata.pkg_size_chart.p_check_size_chart_by_save(p_table      => 't_approve_version_size_chart_tmp',
                                                      p_company_id => p_t_siz_rec.company_id,
                                                      p_goo_id     => p_t_siz_rec.goo_id,
                                                      p_position   => p_t_siz_rec.position);
    INSERT INTO t_approve_version_size_chart_tmp
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
  END p_insert_t_approve_version_size_chart_tmp;

  /*============================================*
  * Author   : CZH
  * Created  : 23-9月 -22
  * ALERTER  :
  * ALERTER_TIME  :
  * Purpose  : 修改t_approve_version_size_chart_tmp
  * Obj_Name    : P_UPDATE_t_approve_version_size_chart_tmp
  *============================================*/
  PROCEDURE p_update_t_approve_version_size_chart_tmp(p_t_siz_rec t_approve_version_size_chart_tmp%ROWTYPE) IS
  BEGIN
    --校验部位唯一性
    scmdata.pkg_size_chart.p_check_size_chart_by_save(p_table      => 't_approve_version_size_chart_tmp',
                                                      p_company_id => p_t_siz_rec.company_id,
                                                      p_goo_id     => p_t_siz_rec.goo_id,
                                                      p_position   => p_t_siz_rec.position);
    UPDATE t_approve_version_size_chart_tmp t
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
  END p_update_t_approve_version_size_chart_tmp;

  --删除尺寸临时表行数据
  PROCEDURE p_delete_t_approve_version_size_chart_tmp(p_size_chart_tmp_id VARCHAR2) IS
  BEGIN
    DELETE FROM t_approve_version_size_chart_tmp t
     WHERE t.size_chart_tmp_id = p_size_chart_tmp_id;
  END p_delete_t_approve_version_size_chart_tmp;

  --校验是否有选择模板生成的数据
  PROCEDURE p_check_is_has_size_chart_moudle_data(p_company_id VARCHAR2,
                                                  p_goo_id     VARCHAR2) IS
    v_flag INT;
  BEGIN
    SELECT COUNT(1)
      INTO v_flag
      FROM t_approve_version_size_chart_tmp t
     WHERE t.company_id = p_company_id
       AND t.goo_id = p_goo_id;
    IF v_flag > 0 THEN
      NULL;
    ELSE
      raise_application_error(-20002, '不可新增，请先选择模板');
    END IF;
  END p_check_is_has_size_chart_moudle_data;

  --批版尺寸临时表删除校验
  PROCEDURE p_check_size_chart_tmp_by_delete(p_company_id VARCHAR2,
                                             p_goo_id     VARCHAR2) IS
    v_cnt INT;
  BEGIN
    SELECT COUNT(1)
      INTO v_cnt
      FROM t_approve_version_size_chart_tmp t
     WHERE t.company_id = p_company_id
       AND t.goo_id = p_goo_id;
    IF v_cnt <= 1 THEN
      raise_application_error(-20002,
                              '不可删除所有数据，至少需存在一条数据');
    END IF;
  END p_check_size_chart_tmp_by_delete;

  --判断是否存在尺寸表（业务表）
  FUNCTION f_check_is_has_size_chart(p_company_id VARCHAR2,
                                     p_goo_id     VARCHAR2) RETURN INT IS
    v_flag INT;
  BEGIN
    SELECT COUNT(1)
      INTO v_flag
      FROM scmdata.t_approve_version_size_chart t
     WHERE t.company_id = p_company_id
       AND t.goo_id = p_goo_id;
    RETURN v_flag;
  END f_check_is_has_size_chart;

  /*============================================*
  * Author   : CZH
  * Created  : 23-9月 -22
  * ALERTER  :
  * ALERTER_TIME  :
  * Purpose  : 删除 t_approve_version_size_chart_tmp
  * Obj_Name    : p_delete_t_approve_version_size_chart_tmp
  *============================================*/
  PROCEDURE p_delete_t_approve_version_size_chart_tmp(p_company_id VARCHAR2,
                                                      p_goo_id     VARCHAR2) IS
  BEGIN
    DELETE FROM t_approve_version_size_chart_tmp t
     WHERE t.company_id = p_company_id
       AND t.goo_id = p_goo_id;
  END p_delete_t_approve_version_size_chart_tmp;

  --根据选择模板 生成尺寸临时表
  PROCEDURE p_generate_size_chart_tmp(p_company_id        VARCHAR2,
                                      p_goo_id            VARCHAR2,
                                      p_user_id           VARCHAR2,
                                      p_size_chart_moudle VARCHAR2) IS
    p_size_chart_tmp      scmdata.t_approve_version_size_chart_tmp%ROWTYPE;
    v_size_chart_word_rec scmdata.t_size_chart_config_word_detail%ROWTYPE;
    v_size_chart_num_rec  scmdata.t_size_chart_config_word_detail%ROWTYPE;
    v_base_size_type      VARCHAR2(32);
    v_base_code           VARCHAR2(32);
  BEGIN
    p_delete_t_approve_version_size_chart_tmp(p_company_id => p_company_id,
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
      
        p_insert_t_approve_version_size_chart_tmp(p_t_siz_rec => p_size_chart_tmp);
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
        p_insert_t_approve_version_size_chart_tmp(p_t_siz_rec => p_size_chart_tmp);
      END LOOP;
    ELSE
      NULL;
    END IF;
  END p_generate_size_chart_tmp;

  --提交校验
  PROCEDURE p_check_size_chart_moudle_by_submit(p_goo_id     VARCHAR2,
                                                p_company_id VARCHAR2) IS
    v_flag INT;
  BEGIN
    FOR i IN (SELECT t.base_value
                FROM scmdata.t_approve_version_size_chart_tmp t
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
                            FROM scmdata.t_approve_version_size_chart_tmp a
                           WHERE a.goo_id = p_goo_id
                             AND a.company_id = p_company_id);
    IF v_flag = 0 THEN
      raise_application_error(-20002,
                              '当前尺寸表所选模板类型与商品档案尺码不一致,请重新选择模板');
    END IF;
  END p_check_size_chart_moudle_by_submit;

  /*============================================*
  * Author   : CZH
  * Created  : 23-9月 -22
  * ALERTER  :
  * ALERTER_TIME  :
  * Purpose  : 删除 T_APPROVE_VERSION_SIZE_CHART_DETAILS_TMP
  * Obj_Name    : P_DELETE_T_SIZE_CHART_TMP
  *============================================*/
  PROCEDURE p_delete_t_size_chart_dt_tmp(p_company_id VARCHAR2,
                                         p_goo_id     VARCHAR2) IS
  BEGIN
    DELETE FROM scmdata.t_approve_version_size_chart_details_tmp a
     WHERE a.size_chart_id IN
           (SELECT t.size_chart_tmp_id
              FROM t_approve_version_size_chart_tmp t
             WHERE t.company_id = p_company_id
               AND t.goo_id = p_goo_id);
  END p_delete_t_size_chart_dt_tmp;

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
  
    DELETE FROM scmdata.t_approve_version_size_chart_details_tmp a
     WHERE a.size_chart_id IN
           (SELECT t.size_chart_tmp_id
              FROM t_approve_version_size_chart_tmp t
             WHERE t.company_id = p_company_id
               AND t.goo_id = p_goo_id);
  
    DELETE FROM t_approve_version_size_chart_tmp t
     WHERE t.company_id = p_company_id
       AND t.goo_id = p_goo_id;
  
  END p_delete_t_size_chart_all_tmp_data;

  --尺寸表模板，提交生成尺寸临时表
  PROCEDURE p_generate_size_chart_dt_tmp(p_company_id VARCHAR2,
                                         p_goo_id     VARCHAR2,
                                         p_user_id    VARCHAR2) IS
    p_size_chart_dt_tmp scmdata.t_approve_version_size_chart_details_tmp%ROWTYPE;
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
                                               v_varname => 'APV_SIZE_CHART_GOO_ID',
                                               v_vartype => 'VARCHAR',
                                               v_varchar => p_goo_id);
  
    v_size_chart_moudle := scmdata.pkg_variable.f_get_varchar(v_objid   => p_user_id,
                                                              v_compid  => p_company_id,
                                                              v_varname => 'APV_SIZE_CHART_MOUDLE');
  
    --尺寸表模板
    FOR size_chart_rec IN (SELECT ts.*
                             FROM scmdata.t_approve_version_size_chart_tmp ts
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
      
        v_sizename := scmdata.pkg_size_chart.f_get_size_company_dict(p_company_id => p_company_id,
                                                                     p_size_name  => size_chart_dt_rec.sizename);
      
        p_size_chart_dt_tmp.measure := v_sizename; --尺码企业字典ID
        --除基码外的其他尺码值，根据填写的基码+选择的尺寸表模板对应的跳码规则自动生成;
        --模板中没有配置对应尺码的跳码规则，则该尺寸需手动录入；
        --基码
        IF size_chart_dt_rec.sizename = size_chart_rec.base_code THEN
          v_measure_value := size_chart_rec.base_value;
        ELSE
          v_measure_value := scmdata.pkg_size_chart.f_get_size_by_jump_size_rule(p_company_id        => p_company_id,
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
        p_insert_t_approve_version_size_chart_dt_tmp(p_t_siz_rec => p_size_chart_dt_tmp);
      END LOOP;
    END LOOP;
  END p_generate_size_chart_dt_tmp;

  /*============================================*
  * Author   : CZH
  * Created  : 23-9月 -22
  * ALERTER  :
  * ALERTER_TIME  :
  * Purpose  : 查询 T_SIZE_CHART_DETAILS_TMP
  * Obj_Name    : F_QUERY_T_SIZE_CHART_DT_TMP
  *============================================*/
  FUNCTION f_query_t_approve_version_size_chart_details_tmp(p_user_id    VARCHAR2,
                                                            p_company_id VARCHAR2)
    RETURN CLOB IS
    v_sql    CLOB;
    v_goo_id VARCHAR2(32);
  BEGIN
    v_goo_id := scmdata.pkg_variable.f_get_varchar(v_objid   => p_user_id,
                                                   v_compid  => p_company_id,
                                                   v_varname => 'APV_SIZE_CHART_GOO_ID');
  
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
  FROM scmdata.t_approve_version_size_chart_tmp a
  INNER JOIN t_approve_version_size_chart_details_tmp t
    ON t.size_chart_id = a.size_chart_tmp_id
  INNER JOIN scmdata.sys_company_dict b
    ON b.company_dict_id = t.measure
 WHERE a.goo_id = ''' || v_goo_id || '''
   AND a.company_id = ''' || p_company_id || '''
 ORDER BY a.seq_num ASC, b.company_dict_sort  ASC';
    RETURN v_sql;
  END f_query_t_approve_version_size_chart_details_tmp;

  /*============================================*
  * Author   : CZH
  * Created  : 23-9月 -22
  * ALERTER  :
  * ALERTER_TIME  :
  * Purpose  : 新增 T_APPROVE_VERSION_SIZE_CHART_DETAILS_TMP
  * Obj_Name    : P_INSERT_T_SIZE_CHART_DT_TMP
  *============================================*/
  PROCEDURE p_insert_t_approve_version_size_chart_dt_tmp(p_t_siz_rec t_approve_version_size_chart_details_tmp%ROWTYPE) IS
  BEGIN
    INSERT INTO t_approve_version_size_chart_details_tmp
      (size_chart_dt_tmp_id, size_chart_id, measure, measure_value, pause,
       create_id, create_time, update_id, update_time, memo)
    VALUES
      (p_t_siz_rec.size_chart_dt_tmp_id, p_t_siz_rec.size_chart_id,
       p_t_siz_rec.measure, p_t_siz_rec.measure_value, p_t_siz_rec.pause,
       p_t_siz_rec.create_id, p_t_siz_rec.create_time, p_t_siz_rec.update_id,
       p_t_siz_rec.update_time, p_t_siz_rec.memo);
  END p_insert_t_approve_version_size_chart_dt_tmp;

  /*============================================*
  * Author   : CZH
  * Created  : 23-9月 -22
  * ALERTER  :
  * ALERTER_TIME  :
  * Purpose  :  修改 T_SIZE_CHART_DETAILS_TMP
  * Obj_Name    : P_UPDATE_T_SIZE_CHART_DT_TMP
  *============================================*/
  PROCEDURE p_update_t_approve_version_size_chart_details_tmp(p_t_siz_rec t_approve_version_size_chart_details_tmp%ROWTYPE) IS
  BEGIN
    UPDATE t_approve_version_size_chart_details_tmp t
       SET t.measure_value = p_t_siz_rec.measure_value,
           t.pause         = p_t_siz_rec.pause,
           t.create_id     = p_t_siz_rec.create_id,
           t.create_time   = p_t_siz_rec.create_time,
           t.update_id     = p_t_siz_rec.update_id,
           t.update_time   = p_t_siz_rec.update_time,
           t.memo          = p_t_siz_rec.memo
     WHERE t.size_chart_id = p_t_siz_rec.size_chart_id
       AND t.measure = p_t_siz_rec.measure;
  END p_update_t_approve_version_size_chart_details_tmp;

  --删除尺寸临时表(含尺码)行数据
  PROCEDURE p_delete_t_approve_version_size_chart_details_tmp(p_company_id          VARCHAR2,
                                                              p_goo_id              VARCHAR2,
                                                              p_position            VARCHAR2,
                                                              p_quantitative_method VARCHAR2) IS
  BEGIN
    --删除校验
    p_check_size_chart_dt_tmp_by_delete(p_company_id => p_company_id,
                                        p_goo_id     => p_goo_id);
  
    DELETE FROM t_approve_version_size_chart_details_tmp a
     WHERE a.size_chart_id IN
           (SELECT t.size_chart_tmp_id
              FROM scmdata.t_size_chart_tmp t
             WHERE t.company_id = p_company_id
               AND p_goo_id = t.goo_id
               AND t.position = p_position
               AND t.quantitative_method = p_quantitative_method);
  
    DELETE FROM scmdata.t_approve_version_size_chart_tmp t
     WHERE t.company_id = p_company_id
       AND p_goo_id = t.goo_id
       AND t.position = p_position
       AND t.quantitative_method = p_quantitative_method;
  END p_delete_t_approve_version_size_chart_details_tmp;

  /*============================================*
  * Author   : CZH
  * Created  : 23-9月 -22
  * ALERTER  :
  * ALERTER_TIME  :
  * Purpose  : 删除 T_SIZE_CHART_DETAILS_TMP
  * Obj_Name    : P_DELETE_T_SIZE_CHART_TMP
  *============================================*/
  PROCEDURE p_delete_t_approve_version_size_chart_details_tmp(p_company_id VARCHAR2,
                                                              p_goo_id     VARCHAR2) IS
  BEGIN
    DELETE FROM scmdata.t_approve_version_size_chart_details_tmp a
     WHERE a.size_chart_id IN
           (SELECT t.size_chart_tmp_id
              FROM t_size_chart_tmp t
             WHERE t.company_id = p_company_id
               AND t.goo_id = p_goo_id);
  END p_delete_t_approve_version_size_chart_details_tmp;

  --尺寸临时表（含尺码）删除校验
  PROCEDURE p_check_size_chart_dt_tmp_by_delete(p_company_id VARCHAR2,
                                                p_goo_id     VARCHAR2) IS
    v_cnt INT;
  BEGIN
    SELECT COUNT(DISTINCT a.seq_num)
      INTO v_cnt
      FROM t_approve_version_size_chart_tmp a
     INNER JOIN t_approve_version_size_chart_details_tmp b
        ON b.size_chart_id = a.size_chart_tmp_id
     WHERE a.company_id = p_company_id
       AND a.goo_id = p_goo_id;
    IF v_cnt <= 1 THEN
      raise_application_error(-20002,
                              '不可删除所有数据，至少需存在一条数据');
    END IF;
  END p_check_size_chart_dt_tmp_by_delete;

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
      FROM scmdata.t_approve_version_size_chart_tmp t
     WHERE t.company_id = p_company_id
       AND t.goo_id = p_goo_id
       AND t.position = p_position
       AND t.quantitative_method = p_quantitative_method;
    RETURN v_flag;
  END f_check_is_has_size_chart_tmp_data;

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

  --提交校验必填项是否为空
  PROCEDURE p_check_size_chart_by_submit(p_company_id VARCHAR2,
                                         p_goo_id     VARCHAR2) IS
    v_flag INT;
  BEGIN
    SELECT COUNT(1)
      INTO v_flag
      FROM scmdata.t_approve_version_size_chart_tmp t
     INNER JOIN scmdata.t_approve_version_size_chart_details_tmp a
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
    p_t_siz_rec     t_approve_version_size_chart%ROWTYPE;
    p_t_siz_dt_rec  t_approve_version_size_chart_details%ROWTYPE;
    v_size_chart_id VARCHAR2(32);
  BEGIN
    --提交校验必填项是否为空
    p_check_size_chart_by_submit(p_company_id => p_company_id,
                                 p_goo_id     => p_goo_id);
    --生成尺寸表前，删除该货号对应的所有尺寸表数据
    p_delete_t_approve_version_size_chart_all_data(p_company_id => p_company_id,
                                                   p_goo_id     => p_goo_id);
    --生成尺寸表                              
    FOR p_t_siz_tmp_rec IN (SELECT *
                              FROM scmdata.t_approve_version_size_chart_tmp t
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
    
      p_insert_t_approve_version_size_chart(p_t_siz_rec => p_t_siz_rec);
    
      FOR p_t_siz_dt_tmp_rec IN (SELECT *
                                   FROM scmdata.t_approve_version_size_chart_details_tmp dt
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
        p_insert_t_approve_version_size_chart_details(p_t_siz_rec => p_t_siz_dt_rec);
      END LOOP;
    END LOOP;
  END p_generate_size_chart;

  /*============================================*
  * Author   : CZH
  * Created  : 23-9月 -22
  * ALERTER  :
  * ALERTER_TIME  :
  * Purpose  : 查询T_SIZE_CHART
  * Obj_Name    : F_QUERY_T_SIZE_CHART_TMP
  *============================================*/
  FUNCTION f_query_t_approve_version_size_chart(p_goo_id     VARCHAR2,
                                                p_company_id VARCHAR2)
    RETURN CLOB IS
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
  FROM scmdata.t_approve_version_size_chart a
 INNER JOIN scmdata.t_approve_version_size_chart_details b
    ON b.size_chart_id = a.size_chart_id
 INNER JOIN scmdata.sys_company_dict c
    ON c.company_dict_id = b.measure
 WHERE a.goo_id = ''' || p_goo_id || '''
   AND a.company_id = ''' || p_company_id || '''
 ORDER BY a.seq_num ASC, c.company_dict_sort  ASC';
    RETURN v_sql;
  END f_query_t_approve_version_size_chart;
  /*============================================*
  * Author   : CZH
  * Created  : 11-10月-22
  * ALERTER  :
  * ALERTER_TIME  :
  * Purpose  : 新增T_SIZE_CHART
  * Obj_Name    : P_INSERT_T_SIZE_CHART
  *============================================*/
  PROCEDURE p_insert_t_approve_version_size_chart(p_t_siz_rec scmdata.t_approve_version_size_chart%ROWTYPE) IS
  BEGIN
    --校验部位唯一性
    scmdata.pkg_size_chart.p_check_size_chart_by_save(p_table      => 't_approve_version_size_chart',
                                                      p_company_id => p_t_siz_rec.company_id,
                                                      p_goo_id     => p_t_siz_rec.goo_id,
                                                      p_position   => p_t_siz_rec.position);
    INSERT INTO t_approve_version_size_chart
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
  END p_insert_t_approve_version_size_chart;

  /*============================================*
  * Author   : CZH
  * Created  : 11-10月-22
  * ALERTER  :
  * ALERTER_TIME  :
  * Purpose  : 修改T_SIZE_CHART
  * Obj_Name    : P_UPDATE_T_SIZE_CHART
  *============================================*/
  PROCEDURE p_update_t_approve_version_size_chart(p_t_siz_rec scmdata.t_approve_version_size_chart%ROWTYPE) IS
  BEGIN
    --校验部位唯一性
    scmdata.pkg_size_chart.p_check_size_chart_by_save(p_table      => 't_approve_version_size_chart',
                                                      p_company_id => p_t_siz_rec.company_id,
                                                      p_goo_id     => p_t_siz_rec.goo_id,
                                                      p_position   => p_t_siz_rec.position);
    UPDATE t_approve_version_size_chart t
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
  END p_update_t_approve_version_size_chart;

  /*============================================*
  * Author   : CZH
  * Created  : 11-10月-22
  * ALERTER  :
  * ALERTER_TIME  :
  * Purpose  : 删除T_SIZE_CHART
  * Obj_Name    : P_DELETE_T_SIZE_CHART
  *============================================*/
  PROCEDURE p_delete_t_approve_version_size_chart(p_t_siz_rec scmdata.t_approve_version_size_chart%ROWTYPE) IS
  BEGIN
    DELETE FROM t_approve_version_size_chart t
     WHERE t.size_chart_id = p_t_siz_rec.size_chart_id;
  END p_delete_t_approve_version_size_chart;
  /*============================================*
  * Author   : CZH
  * Created  : 11-10月-22
  * ALERTER  :
  * ALERTER_TIME  :
  * Purpose  : 新增T_SIZE_CHART_DETAILS
  * Obj_Name    : P_INSERT_T_SIZE_CHART_DETAILS
  *============================================*/
  PROCEDURE p_insert_t_approve_version_size_chart_details(p_t_siz_rec scmdata.t_approve_version_size_chart_details%ROWTYPE) IS
  BEGIN
    INSERT INTO t_approve_version_size_chart_details
      (size_chart_dt_id, size_chart_id, measure, measure_value, pause,
       create_id, create_time, update_id, update_time, memo)
    VALUES
      (p_t_siz_rec.size_chart_dt_id, p_t_siz_rec.size_chart_id,
       p_t_siz_rec.measure, p_t_siz_rec.measure_value, p_t_siz_rec.pause,
       p_t_siz_rec.create_id, p_t_siz_rec.create_time, p_t_siz_rec.update_id,
       p_t_siz_rec.update_time, p_t_siz_rec.memo);
  END p_insert_t_approve_version_size_chart_details;

  /*============================================*
  * Author   : CZH
  * Created  : 11-10月-22
  * ALERTER  :
  * ALERTER_TIME  :
  * Purpose  : 修改T_SIZE_CHART_DETAILS
  * Obj_Name    : P_UPDATE_T_SIZE_CHART_DETAILS
  *============================================*/
  PROCEDURE p_update_t_approve_version_size_chart_details(p_t_siz_rec scmdata.t_approve_version_size_chart_details%ROWTYPE) IS
  BEGIN
    UPDATE t_approve_version_size_chart_details t
       SET t.measure_value = p_t_siz_rec.measure_value,
           t.pause         = p_t_siz_rec.pause,
           t.create_id     = p_t_siz_rec.create_id,
           t.create_time   = p_t_siz_rec.create_time,
           t.update_id     = p_t_siz_rec.update_id,
           t.update_time   = p_t_siz_rec.update_time,
           t.memo          = p_t_siz_rec.memo
     WHERE t.size_chart_id = p_t_siz_rec.size_chart_id
       AND t.measure = p_t_siz_rec.measure;
  END p_update_t_approve_version_size_chart_details;

  /*============================================*
  * Author   : CZH
  * Created  : 11-10月-22
  * ALERTER  :
  * ALERTER_TIME  :
  * Purpose  : 删除T_SIZE_CHART_DETAILS
  * Obj_Name    : P_DELETE_T_SIZE_CHART_DETAILS
  *============================================*/
  PROCEDURE p_delete_t_approve_version_size_chart_details(p_t_siz_rec scmdata.t_approve_version_size_chart_details%ROWTYPE) IS
  BEGIN
    DELETE FROM t_approve_version_size_chart_details t
     WHERE t.size_chart_dt_id = p_t_siz_rec.size_chart_dt_id;
  END p_delete_t_approve_version_size_chart_details;

  --删除尺寸表（业务表）行数据
  PROCEDURE p_delete_t_approve_version_size_chart_row_data(p_company_id          VARCHAR2,
                                                           p_goo_id              VARCHAR2,
                                                           p_position            VARCHAR2,
                                                           p_quantitative_method VARCHAR2) IS
  BEGIN
    --删除校验
    p_check_t_approve_version_size_chart_by_delete(p_company_id => p_company_id,
                                                   p_goo_id     => p_goo_id);
  
    DELETE FROM t_approve_version_size_chart_details a
     WHERE a.size_chart_id IN
           (SELECT t.size_chart_id
              FROM scmdata.t_approve_version_size_chart t
             WHERE t.company_id = p_company_id
               AND t.goo_id = p_goo_id
               AND t.position = p_position
               AND t.quantitative_method = p_quantitative_method);
  
    DELETE FROM scmdata.t_approve_version_size_chart t
     WHERE t.company_id = p_company_id
       AND p_goo_id = t.goo_id
       AND t.position = p_position
       AND t.quantitative_method = p_quantitative_method;
  END p_delete_t_approve_version_size_chart_row_data;

  --删除尺寸表（业务表）所有数据
  PROCEDURE p_delete_t_approve_version_size_chart_all_data(p_company_id VARCHAR2,
                                                           p_goo_id     VARCHAR2) IS
  BEGIN
    DELETE FROM t_approve_version_size_chart_details a
     WHERE a.size_chart_id IN
           (SELECT t.size_chart_id
              FROM scmdata.t_approve_version_size_chart t
             WHERE t.company_id = p_company_id
               AND p_goo_id = t.goo_id);
  
    DELETE FROM scmdata.t_approve_version_size_chart t
     WHERE t.company_id = p_company_id
       AND p_goo_id = t.goo_id;
  END p_delete_t_approve_version_size_chart_all_data;

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
      FROM scmdata.t_approve_version_size_chart t
     WHERE t.company_id = p_company_id
       AND t.goo_id = p_goo_id
       AND t.position = p_position
       AND t.quantitative_method = p_quantitative_method;
    RETURN v_flag;
  END f_check_is_has_size_chart_data;

  --尺寸表含尺码（业务表）删除校验
  PROCEDURE p_check_t_approve_version_size_chart_by_delete(p_company_id VARCHAR2,
                                                           p_goo_id     VARCHAR2) IS
    v_cnt INT;
  BEGIN
    SELECT COUNT(DISTINCT a.seq_num)
      INTO v_cnt
      FROM t_approve_version_size_chart a
     INNER JOIN t_approve_version_size_chart_details b
        ON b.size_chart_id = a.size_chart_id
     WHERE a.company_id = p_company_id
       AND a.goo_id = p_goo_id;
    IF v_cnt <= 1 THEN
      raise_application_error(-20002,
                              '不可删除所有数据，至少需存在一条数据');
    END IF;
  END p_check_t_approve_version_size_chart_by_delete;

  --批版单据生成尺寸表，点击审核后同步更新至同货号商品档案
  PROCEDURE p_sync_apv_size_chart_to_gd_by_examine(p_company_id VARCHAR2,
                                                   p_goo_id     VARCHAR2) IS
    p_t_siz_rec     t_size_chart%ROWTYPE;
    p_t_siz_dt_rec  t_size_chart_details%ROWTYPE;
    v_size_chart_id VARCHAR2(32);
  BEGIN
    --必填校验
    p_check_size_chart_by_submit(p_company_id => p_company_id,
                                 p_goo_id     => p_goo_id);
    --清空批版已生成的尺寸表数据
    scmdata.pkg_size_chart.p_delete_t_size_chart_all_data(p_company_id => p_company_id,
                                                          p_goo_id     => p_goo_id);
  
    --同步商品档案尺寸表至批版                              
    FOR p_t_siz_tmp_rec IN (SELECT *
                              FROM scmdata.t_approve_version_size_chart t
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
    
      scmdata.pkg_size_chart.p_insert_t_size_chart(p_t_siz_rec => p_t_siz_rec);
    
      FOR p_t_siz_dt_tmp_rec IN (SELECT *
                                   FROM scmdata.t_approve_version_size_chart_details dt
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
        scmdata.pkg_size_chart.p_insert_t_size_chart_details(p_t_siz_rec => p_t_siz_dt_rec);
      END LOOP;
    END LOOP;
  END p_sync_apv_size_chart_to_gd_by_examine;

END pkg_approve_version_size_chart;
/
