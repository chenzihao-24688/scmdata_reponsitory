CREATE OR REPLACE PACKAGE SCMDATA.pkg_scm_reverse_generation IS

  -- Author  : SANFU
  -- Created : 2023/5/26 10:27:49
  -- Purpose : Scm 逆向生成包

  /*=========================================================*
  * Author        : 
  * Created_Time  : 2023-05-26 15:55:37
  * Alerter       : 
  * Alerter_Time  : 
  * Purpose       : 获取包中所有对象的注释
  * Obj_Name      : P_GET_PKG_ALL_PF_ARGUMENTS
  * Arg_Number    : 3
  * < IN PARAMS > : 2
  * P_AUTHOR      : 开发者工号
  * P_PKG_NAME    : 包名
  * < OUT PARAMS >: 1
  * PO_SQL        : 注释
  *=========================================================*/

  PROCEDURE p_get_pkg_all_pf_arguments(p_author   VARCHAR2 DEFAULT 'CZH55',
                                       p_pkg_name IN VARCHAR2,
                                       po_sql     OUT CLOB);

  /*=========================================================*
  * Author        : CZH
  * Created_Time  : 2023-05-26 14:15:05
  * Alerter       : 
  * Alerter_Time  : 
  * Purpose       : 获取数据库存储过程，函数等方法参数，形成注释。
  * Obj_Name      : P_GET_ARGUMENTS
  * Arg_Number    : 3
  * < IN PARAMS > : 2
  * P_PKG_NAME    : 包名
  * P_OBJ_NAME    : 数据库对象（函数、过程）
  * < OUT PARAMS >: 1
  * PO_SQL        : 注释
  *=========================================================*/

  PROCEDURE p_get_arguments(p_author   VARCHAR2 DEFAULT 'CZH55',
                            p_pkg_name IN VARCHAR2,
                            p_obj_name IN VARCHAR2,
                            po_sql     OUT CLOB);

  /*=========================================================*
  * Author        : CZH
  * Created_Time  : 2023-05-26 14:41:39
  * Alerter       : 
  * Alerter_Time  : 
  * Purpose       : 获取数据库存储过程，函数等方法参数
  * Obj_Name      : P_GET_PF_ARGUMENTS
  * Arg_Number    : 5
  * < IN PARAMS > : 3
  * P_PKG_NAME    : 包名
  * P_OBJ_NAME    : 数据库对象（函数、过程）
  * P_TABLE_NAME  : 表名（选填） 当变量是记录类型时，需填写表名
  * < OUT PARAMS >: 2
  * PO_SQL        : 数据库存储过程，函数等方法
  * PO_PARAMS     : 方法参数
  *=========================================================*/

  PROCEDURE p_get_pf_arguments(p_pkg_name   IN VARCHAR2,
                               p_obj_name   IN VARCHAR2,
                               p_table_name IN VARCHAR2 DEFAULT NULL,
                               po_sql       OUT CLOB,
                               po_params    OUT CLOB);

  --获取表主键
  FUNCTION p_get_table_pk_id(p_table_name VARCHAR2) RETURN VARCHAR2;

  --表 新增操作
  PROCEDURE p_get_table_insert_sql(p_table_name VARCHAR2,
                                   p_pre        VARCHAR2,
                                   po_sql       OUT CLOB);

  --表 删除操作
  PROCEDURE p_get_table_delete_sql(p_table_name VARCHAR2,
                                   p_pre        VARCHAR2,
                                   p_where_sql  VARCHAR2 DEFAULT NULL,
                                   po_sql       OUT CLOB);

  --表 更新操作
  PROCEDURE p_get_table_update_sql(p_table_name  VARCHAR2,
                                   p_pre         VARCHAR2,
                                   p_where_sql   VARCHAR2 DEFAULT NULL,
                                   p_is_comments INT DEFAULT 1,
                                   po_sql        OUT CLOB);

  --表 更新操作
  PROCEDURE p_get_table_query_sql(p_table_name  VARCHAR2,
                                  p_pre         VARCHAR2,
                                  p_where_sql   VARCHAR2 DEFAULT NULL,
                                  p_is_bz       INT DEFAULT 0,
                                  p_bz_pre      VARCHAR2 DEFAULT NULL,
                                  p_bz_suf      VARCHAR2 DEFAULT NULL,
                                  p_is_comments INT DEFAULT 1,
                                  po_sql        OUT CLOB);

  --初始化赋值
  PROCEDURE p_get_init_assign_sql(p_table_name  VARCHAR2,
                                  p_pre         VARCHAR2,
                                  p_is_bz       INT DEFAULT 0,
                                  p_bz_pre      VARCHAR2 DEFAULT NULL,
                                  p_bz_suf      VARCHAR2 DEFAULT NULL,
                                  p_is_comments INT DEFAULT 1,
                                  po_sql        OUT CLOB);

  --平台逆向生成配置表 T_PLAT_REVERSE_GENERATION_CONFIG
  --获取表字段 初始化field_list
  /*
    [{"RUN":"1","CAPTION":"","DATA_TYPE":"",
  "INPUT_HINT":"","DEFAULT_VALUE":"","CHECK_EXPRESS":"","CHECK_MESSAGE":"","ALIGNMENT":"2",
  "REQUERED":"1","READ_ONLY":"0","NO_EDIT":"0","NO_COPY":"0","NO_SUM":"0","NO_SORT":"0",
  "MAX_VALUE":"","MIN_VALUE":"","MAX_LENGTH":"","MIN_LENGTH":"","DISPLAY_WIDTH":"",
  "DISPLAY_FORMAT":"","EDIT_FORMT":"","STORE_SOURCE":""}]
  */
  PROCEDURE get_field_list_init_sql(p_tb_pre     VARCHAR2 DEFAULT 'nbw',
                                    p_table_name VARCHAR2,
                                    p_md_pre     VARCHAR2 DEFAULT NULL,
                                    p_suf        VARCHAR2 DEFAULT NULL,
                                    po_sql       OUT CLOB);

  --表字段没配置json时调用改过程生成field_list
  --使用merge 合并  待做
  PROCEDURE get_field_list_init_sql_no_tbconfig(p_tb_pre     VARCHAR2 DEFAULT 'nbw',
                                                p_table_name VARCHAR2,
                                                p_method     VARCHAR2 DEFAULT 'I',
                                                p_is_bz      INT DEFAULT 0,
                                                p_bz_pre     VARCHAR2 DEFAULT NULL,
                                                p_bz_suf     VARCHAR2 DEFAULT NULL,
                                                po_sql       OUT CLOB);

  --获取表的所有基础操作
  PROCEDURE p_get_table_datas_base_operate(p_method      VARCHAR2,
                                           p_table_name  VARCHAR2,
                                           p_col_name    VARCHAR2 DEFAULT NULL,
                                           p_pre         VARCHAR2,
                                           p_is_bz       INT DEFAULT 0,
                                           p_bz_pre      VARCHAR2 DEFAULT NULL,
                                           p_bz_suf      VARCHAR2 DEFAULT NULL,
                                           p_is_comments INT DEFAULT 1,
                                           p_where_sql   VARCHAR2 DEFAULT NULL,
                                           po_sql        OUT CLOB);

  --获取字符中的json数据
  FUNCTION get_json_str(p_str CLOB) RETURN CLOB;
END pkg_scm_reverse_generation;
/

CREATE OR REPLACE PACKAGE BODY SCMDATA.pkg_scm_reverse_generation IS

  /*=========================================================*
  * Author        : 
  * Created_Time  : 2023-05-26 15:55:37
  * Alerter       : 
  * Alerter_Time  : 
  * Purpose       : 获取包中所有对象的注释
  * Obj_Name      : P_GET_PKG_ALL_PF_ARGUMENTS
  * Arg_Number    : 3
  * < IN PARAMS > : 2
  * P_AUTHOR      : 开发者工号
  * P_PKG_NAME    : 包名
  * < OUT PARAMS >: 1
  * PO_SQL        : 注释
  *=========================================================*/
  PROCEDURE p_get_pkg_all_pf_arguments(p_author   VARCHAR2 DEFAULT 'CZH55',
                                       p_pkg_name IN VARCHAR2,
                                       po_sql     OUT CLOB) IS
    v_pkg_name VARCHAR2(100) := upper(p_pkg_name);
    vo_sql     CLOB;
    vo_all_sql CLOB;
  BEGIN
    FOR rec IN (SELECT *
                  FROM (SELECT t.package_name,
                               t.object_name,
                               row_number() over(PARTITION BY t.object_name ORDER BY t.position ASC) rank_position
                          FROM sys.user_arguments t
                         WHERE t.package_name = v_pkg_name
                           AND t.position <> 0) va
                 WHERE va.rank_position = 1) LOOP
      p_get_arguments(p_author   => p_author,
                      p_pkg_name => rec.package_name,
                      p_obj_name => rec.object_name,
                      po_sql     => vo_sql);
      vo_all_sql := vo_all_sql || chr(10) || vo_sql;
    END LOOP;
    po_sql := vo_all_sql;
  END p_get_pkg_all_pf_arguments;

  /*=========================================================*
  * Author        : CZH
  * Created_Time  : 2023-05-26 14:15:05
  * Alerter       : 
  * Alerter_Time  : 
  * Purpose       : 获取数据库存储过程，函数等方法参数，形成注释。
  * Obj_Name      : P_GET_ARGUMENTS
  * Arg_Number    : 4
  * < IN PARAMS > : 3
  * P_AUTHOR      : 开发人员工号
  * P_PKG_NAME    : 包名
  * P_OBJ_NAME    : 数据库对象（函数、过程）
  * < OUT PARAMS >: 1
  * PO_SQL        : 注释
  *=========================================================*/

  PROCEDURE p_get_arguments(p_author   VARCHAR2 DEFAULT 'CZH55',
                            p_pkg_name IN VARCHAR2,
                            p_obj_name IN VARCHAR2,
                            po_sql     OUT CLOB) IS
    v_pkg_name    VARCHAR2(100) := upper(p_pkg_name);
    v_obj_name    VARCHAR2(100) := upper(p_obj_name);
    v_arg_number  NUMBER;
    v_in_num      NUMBER;
    v_out_num     NUMBER;
    v_arg_sql     CLOB;
    vo_sql        CLOB;
    v_object_type VARCHAR2(256);
    CURSOR data_cur(p_in_out VARCHAR2) IS
      SELECT t.package_name,
             t.object_name,
             t.argument_name,
             t.in_out,
             COUNT(t.argument_name) over(PARTITION BY t.object_name) arg_number,
             row_number() over(PARTITION BY t.object_name ORDER BY t.position ASC) rank_position
        FROM sys.user_arguments t
       WHERE t.package_name = v_pkg_name
         AND t.object_name = v_obj_name
         AND t.in_out = p_in_out
         AND t.position <> 0;
  BEGIN
  
    SELECT COUNT(1),
           SUM(CASE
                 WHEN t.in_out = 'IN' THEN
                  1
                 ELSE
                  0
               END) in_num,
           SUM(CASE
                 WHEN t.in_out = 'OUT' THEN
                  1
                 ELSE
                  0
               END) out_num
      INTO v_arg_number, v_in_num, v_out_num
      FROM sys.user_arguments t
     WHERE t.package_name = v_pkg_name
       AND t.object_name = v_obj_name
       AND t.position <> 0;
  
    vo_sql := vo_sql || chr(10) ||
              '/*=========================================================*';
    vo_sql := vo_sql || chr(10) || ' * Author        : ' || upper(p_author);
    vo_sql := vo_sql || chr(10) || ' * Created_Time  : ' ||
              to_char(SYSDATE, 'YYYY-MM-DD HH24:MI:SS');
    vo_sql := vo_sql || chr(10) || ' * Alerter       : ';
    vo_sql := vo_sql || chr(10) || ' * Alerter_Time  : ';
    vo_sql := vo_sql || chr(10) || ' * Purpose       : ';
    vo_sql := vo_sql || chr(10) || ' * Obj_Name      : ' || v_obj_name;
    IF v_arg_number = 0 THEN
      NULL;
    ELSE
      vo_sql := vo_sql || chr(10) || ' * Arg_Number    : ' || v_arg_number;
      IF v_in_num = 0 THEN
        NULL;
      ELSE
        vo_sql := vo_sql || chr(10) || ' * < IN PARAMS > : ' || v_in_num;
        FOR rec IN data_cur(p_in_out => 'IN') LOOP
          v_arg_sql := (CASE
                         WHEN length(rec.argument_name) > 14 THEN
                          rec.argument_name || ' '
                         ELSE
                          rpad(rec.argument_name, 14, ' ')
                       END) || ': ';
          vo_sql    := vo_sql || chr(10) || ' * ' || v_arg_sql;
        END LOOP;
      END IF;
    
      v_object_type := CASE
                         WHEN instr(v_obj_name, 'F_') > 0 THEN
                          'FUNCTION'
                         WHEN instr(v_obj_name, 'P_') > 0 THEN
                          'PROCEDURE'
                         ELSE
                          NULL
                       END;
    
      IF v_object_type = 'FUNCTION' THEN
        vo_sql := vo_sql || chr(10) || ' * < RETURN VALUE > ';
        vo_sql := vo_sql || chr(10) || ' * ' || rpad(' ', 14, ' ') || ': ';
      ELSIF v_object_type = 'PROCEDURE' THEN
        IF v_out_num = 0 THEN
          NULL;
        ELSE
          vo_sql := vo_sql || chr(10) || ' * < OUT PARAMS >: ' || v_out_num;
          FOR rec IN data_cur(p_in_out => 'OUT') LOOP
            v_arg_sql := (CASE
                           WHEN length(rec.argument_name) > 14 THEN
                            rec.argument_name || ' '
                           ELSE
                            rpad(rec.argument_name, 14, ' ')
                         END) || ': ';
            vo_sql    := vo_sql || chr(10) || ' * ' || v_arg_sql;
          END LOOP;
        END IF;
      ELSE
        NULL;
      END IF;
    END IF;
    vo_sql := vo_sql || chr(10) ||
              ' *=========================================================*/';
    po_sql := vo_sql;
  END p_get_arguments;

  /*=========================================================*
  * Author        : CZH
  * Created_Time  : 2023-05-26 14:41:39
  * Alerter       : 
  * Alerter_Time  : 
  * Purpose       : 获取数据库存储过程，函数等方法参数
  * Obj_Name      : P_GET_PF_ARGUMENTS
  * Arg_Number    : 5
  * < IN PARAMS > : 3
  * P_PKG_NAME    : 包名
  * P_OBJ_NAME    : 数据库对象（函数、过程）
  * P_TABLE_NAME  : 表名（选填） 当变量是记录类型时，需填写表名
  * < OUT PARAMS >: 2
  * PO_SQL        : 数据库存储过程，函数等方法
  * PO_PARAMS     : 方法参数
  *=========================================================*/

  PROCEDURE p_get_pf_arguments(p_pkg_name   IN VARCHAR2,
                               p_obj_name   IN VARCHAR2,
                               p_table_name IN VARCHAR2 DEFAULT NULL,
                               po_sql       OUT CLOB,
                               po_params    OUT CLOB) IS
    v_pkg_name VARCHAR2(100) := upper(p_pkg_name);
    v_obj_name VARCHAR2(100) := upper(p_obj_name);
    v_attr     VARCHAR2(100);
    vo_sql     CLOB;
    vo_params  CLOB;
    CURSOR data_cur IS
      SELECT t.package_name,
             t.object_name,
             t.argument_name,
             t.in_out,
             COUNT(t.argument_name) over(PARTITION BY t.object_name) arg_number,
             row_number() over(PARTITION BY t.object_name ORDER BY t.position ASC) rank_position,
             t.data_type
        FROM sys.user_arguments t
       WHERE t.package_name = v_pkg_name
         AND t.object_name = v_obj_name
         AND t.position <> 0;
  BEGIN
  
    FOR rec IN data_cur LOOP
      IF rec.in_out = 'IN' THEN
        v_attr := 'v_';
      ELSIF rec.in_out = 'OUT' THEN
        v_attr := 'vo_';
      ELSIF rec.in_out = 'IN/OUT' THEN
        v_attr := 'v_';
      END IF;
    
      vo_sql := vo_sql || ',' || lower(rec.argument_name) || '  =>' || ' ' ||
                v_attr || REPLACE(lower(rec.argument_name), 'p_', '');
    
      vo_params := vo_params || v_attr ||
                   REPLACE(lower(rec.argument_name), 'p_', '') || ' ' || (CASE
                     WHEN rec.data_type = 'VARCHAR2' THEN
                      rec.data_type || '(256);'
                     WHEN rec.data_type = 'NUMBER' THEN
                      rec.data_type || '(6);'
                     WHEN rec.data_type = 'PL/SQL RECORD' THEN
                      (CASE
                        WHEN p_table_name IS NOT NULL THEN
                         p_table_name || '%ROWTYPE' || ';'
                        ELSE
                         NULL
                      END)
                     ELSE
                      ';'
                   END) || chr(10);
    END LOOP;
    po_sql    := v_pkg_name || '.' || v_obj_name || '(' ||
                 ltrim(vo_sql, ',') || ');';
    po_params := vo_params;
  END p_get_pf_arguments;

  --获取表主键
  FUNCTION p_get_table_pk_id(p_table_name VARCHAR2) RETURN VARCHAR2 IS
    v_pk_id VARCHAR2(256);
  BEGIN
    SELECT MAX(a.column_name)
      INTO v_pk_id
      FROM user_cons_columns a
     INNER JOIN user_constraints b
        ON b.constraint_name = a.constraint_name
       AND b.constraint_type = 'P'
     WHERE a.table_name = upper(p_table_name);
    RETURN v_pk_id;
  END p_get_table_pk_id;

  --表 新增操作
  PROCEDURE p_get_table_insert_sql(p_table_name VARCHAR2,
                                   p_pre        VARCHAR2,
                                   po_sql       OUT CLOB) IS
    vo_sql CLOB;
  BEGIN
    SELECT 'INSERT INTO ' || listagg(DISTINCT(t.table_name)) || ' (' ||
           rtrim(xmlagg(xmlparse(content t.column_name || ',' wellformed) ORDER BY t.column_id).getclobval(),
                 ',') || ')' || ' VALUES( ' ||
           rtrim(xmlagg(xmlparse(content p_pre || t.column_name || ',' wellformed) ORDER BY t.column_id).getclobval(),
                 ',') || ' );'
      INTO vo_sql
      FROM user_tab_columns t
     WHERE t.table_name = upper(p_table_name);
    po_sql := vo_sql;
  END p_get_table_insert_sql;

  --表 删除操作
  PROCEDURE p_get_table_delete_sql(p_table_name VARCHAR2,
                                   p_pre        VARCHAR2,
                                   p_where_sql  VARCHAR2 DEFAULT NULL,
                                   po_sql       OUT CLOB) IS
    vo_sql  CLOB;
    v_pk_id VARCHAR2(256);
  BEGIN
    v_pk_id := p_get_table_pk_id(p_table_name => p_table_name);
  
    vo_sql := 'DELETE FROM ' || p_table_name || ' t ' ||
              nvl(p_where_sql,
                  (CASE
                    WHEN v_pk_id IS NULL THEN
                     ' WHERE 1 = 0'
                    ELSE
                     ' WHERE t.' || v_pk_id || ' = ' || p_pre || v_pk_id
                  END)) || ';';
    po_sql := vo_sql;
  END p_get_table_delete_sql;

  --表 更新操作
  PROCEDURE p_get_table_update_sql(p_table_name  VARCHAR2,
                                   p_pre         VARCHAR2,
                                   p_where_sql   VARCHAR2 DEFAULT NULL,
                                   p_is_comments INT DEFAULT 1,
                                   po_sql        OUT CLOB) IS
    vo_sql  CLOB;
    v_pk_id VARCHAR2(256);
  BEGIN
    v_pk_id := p_get_table_pk_id(p_table_name => p_table_name);
  
    SELECT 'UPDATE ' || listagg(DISTINCT(t.table_name)) || ' t ' || ' SET ' ||
           rtrim(xmlagg(xmlparse(content(CASE
                   WHEN t.column_name = v_pk_id THEN
                    NULL
                   ELSE
                    ' t.' || t.column_name || ' =  ' || p_pre || t.column_name || ',' ||
                    (CASE
                      WHEN p_is_comments = 1 THEN
                       ' --' || c.comments || chr(10)
                      ELSE
                       NULL
                    END)
                 END) wellformed) ORDER BY t.column_id).getclobval(),
                 ',') || nvl(p_where_sql,
                             (CASE
                               WHEN v_pk_id IS NULL THEN
                                ' WHERE 1 = 0'
                               ELSE
                                ' WHERE t.' || v_pk_id || ' = ' || p_pre || v_pk_id
                             END)) || ';'
      INTO vo_sql
      FROM user_tab_columns t
     INNER JOIN user_col_comments c
        ON t.table_name = c.table_name
       AND t.column_name = c.column_name
     WHERE t.table_name = upper(p_table_name);
  
    vo_sql := regexp_replace(vo_sql, '(.)', '', instr(vo_sql, ',', -1), 1);
    po_sql := vo_sql;
  END p_get_table_update_sql;

  --表 更新操作
  PROCEDURE p_get_table_query_sql(p_table_name  VARCHAR2,
                                  p_pre         VARCHAR2,
                                  p_where_sql   VARCHAR2 DEFAULT NULL,
                                  p_is_bz       INT DEFAULT 0,
                                  p_bz_pre      VARCHAR2 DEFAULT NULL,
                                  p_bz_suf      VARCHAR2 DEFAULT NULL,
                                  p_is_comments INT DEFAULT 1,
                                  po_sql        OUT CLOB) IS
    vo_sql  CLOB;
    v_pk_id VARCHAR2(256);
  BEGIN
    v_pk_id := p_get_table_pk_id(p_table_name => p_table_name);
  
    SELECT 'SELECT ' ||
           rtrim(listagg('t.' || t.column_name || ' ' || (CASE
                           WHEN p_is_bz = 0 THEN --是否起别名
                            NULL
                           ELSE
                            p_bz_pre || upper(t.column_name) ||
                            nvl(p_bz_suf,
                                (CASE
                                  WHEN t.nullable = 'Y' THEN
                                   '_N'
                                  ELSE
                                   '_Y'
                                END))
                         END) || ',' || (CASE --是否注释
                           WHEN p_is_comments = 1 THEN
                            ' --' || c.comments || chr(10)
                           ELSE
                            NULL
                         END),
                         '') within GROUP(ORDER BY t.column_id),
                 ',') || ' FROM ' || p_table_name || ' t ' ||
           nvl(p_where_sql,
               (CASE
                 WHEN v_pk_id IS NULL THEN
                  ' WHERE 1 = 1'
                 ELSE
                  ' WHERE t.' || v_pk_id || ' = ' || p_pre || v_pk_id
               END)) || ';'
      INTO vo_sql
      FROM user_tab_columns t
     INNER JOIN user_col_comments c
        ON t.table_name = c.table_name
       AND t.column_name = c.column_name
     WHERE t.table_name = upper(p_table_name);
  
    vo_sql := regexp_replace(vo_sql, '(.)', '', instr(vo_sql, ',', -1), 1);
    po_sql := vo_sql;
  END p_get_table_query_sql;

  --初始化赋值
  PROCEDURE p_get_init_assign_sql(p_table_name  VARCHAR2,
                                  p_pre         VARCHAR2,
                                  p_is_bz       INT DEFAULT 0,
                                  p_bz_pre      VARCHAR2 DEFAULT NULL,
                                  p_bz_suf      VARCHAR2 DEFAULT NULL,
                                  p_is_comments INT DEFAULT 1,
                                  po_sql        OUT CLOB) IS
    v_pk_id VARCHAR2(256);
    vo_sql  CLOB;
  BEGIN
    v_pk_id := p_get_table_pk_id(p_table_name => p_table_name);
  
    SELECT rtrim(xmlagg(xmlparse(content p_pre || t.column_name || ' :=  ' || (CASE
                   WHEN t.column_name = v_pk_id THEN
                    'scmdata.f_get_uuid()'
                   WHEN t.column_name IN ('UPDATE_ID', 'CREATE_ID') THEN
                    ':user_id'
                   WHEN t.column_name IN ('UPDATE_TIME',
                                          'CREATE_TIME',
                                          'UPDATE_DATE',
                                          'CREATE_DATE') THEN
                    'SYSDATE'
                   ELSE
                    (CASE
                      WHEN p_is_bz = 1 THEN
                       nvl(p_bz_pre, ':') || t.column_name ||
                       nvl(p_bz_suf,
                           (CASE
                             WHEN t.nullable = 'Y' THEN
                              '_N'
                             ELSE
                              '_Y'
                           END))
                      ELSE
                       ':' || t.column_name
                    END)
                 END) || ';' || (CASE --是否注释
                   WHEN p_is_comments = 1 THEN
                    ' --' || c.comments || chr(10)
                   ELSE
                    NULL
                 END) wellformed) ORDER BY t.column_id).getclobval(),
                 ',')
      INTO vo_sql
      FROM user_tab_columns t
     INNER JOIN user_col_comments c
        ON t.table_name = c.table_name
       AND t.column_name = c.column_name
     WHERE t.table_name = upper(p_table_name);
    po_sql := vo_sql;
  END p_get_init_assign_sql;

  --平台逆向生成配置表 T_PLAT_REVERSE_GENERATION_CONFIG
  --获取表字段 初始化field_list
  /*
    [{"RUN":"1","CAPTION":"","DATA_TYPE":"",
  "INPUT_HINT":"","DEFAULT_VALUE":"","CHECK_EXPRESS":"","CHECK_MESSAGE":"","ALIGNMENT":"2",
  "REQUERED":"1","READ_ONLY":"0","NO_EDIT":"0","NO_COPY":"0","NO_SUM":"0","NO_SORT":"0",
  "MAX_VALUE":"","MIN_VALUE":"","MAX_LENGTH":"","MIN_LENGTH":"","DISPLAY_WIDTH":"",
  "DISPLAY_FORMAT":"","EDIT_FORMT":"","STORE_SOURCE":""}]
  */
  PROCEDURE get_field_list_init_sql(p_tb_pre     VARCHAR2 DEFAULT 'nbw',
                                    p_table_name VARCHAR2,
                                    p_md_pre     VARCHAR2 DEFAULT NULL,
                                    p_suf        VARCHAR2 DEFAULT NULL,
                                    po_sql       OUT CLOB) IS
    v_tb_pre     VARCHAR2(256) := p_tb_pre;
    v_pre        VARCHAR2(256) := p_md_pre; --模块前缀
    v_suf        VARCHAR2(256) := p_suf;
    v_table_name VARCHAR2(256) := upper(p_table_name);
    v_rtn        VARCHAR2(2000);
    v_fd_rec     nbw.sys_field_list%ROWTYPE;
    v_sql        CLOB;
    vo_sql       CLOB;
    v_is_run     VARCHAR2(1);
  BEGIN
    FOR tab_rec IN (SELECT t.*, c.comments
                      FROM user_tab_columns t
                     INNER JOIN user_col_comments c
                        ON t.table_name = c.table_name
                       AND t.column_name = c.column_name
                     WHERE t.table_name = v_table_name
                     ORDER BY t.column_id) LOOP
      --是否执行
      v_is_run := scmdata.pkg_plat_comm.f_parse_json(scmdata.sf_get_arguments_pkg.get_json_str(tab_rec.comments),
                                                     p_key => 'RUN');
      IF v_is_run = '1' THEN
        v_rtn := scmdata.pkg_plat_comm.f_parse_json(scmdata.sf_get_arguments_pkg.get_json_str(tab_rec.comments),
                                                    p_key => 'REQUERED');
      
        --是否必填                    
        v_fd_rec.requiered_flag := (CASE
                                     WHEN v_rtn IS NOT NULL THEN
                                      to_number(v_rtn)
                                     ELSE
                                      (CASE
                                        WHEN tab_rec.nullable = 'Y' THEN
                                         0
                                        ELSE
                                         1
                                      END)
                                   END);
        v_rtn := (CASE
                   WHEN v_rtn = '1' THEN
                    'N'
                   WHEN v_rtn = '0' THEN
                    'Y'
                   ELSE
                    NULL
                 END);
      
        --字段名
        v_fd_rec.field_name := v_pre || tab_rec.column_name ||
                               nvl(v_suf,
                                   (CASE
                                     WHEN nvl(v_rtn, tab_rec.nullable) = 'Y' THEN
                                      '_N'
                                     ELSE
                                      '_Y'
                                   END));
      
        v_fd_rec.field_name := CASE
                                 WHEN v_fd_rec.field_name IS NULL THEN
                                  'NULL'
                                 ELSE
                                  '''' || v_fd_rec.field_name || ''''
                               END;
        v_rtn               := scmdata.pkg_plat_comm.f_parse_json(scmdata.sf_get_arguments_pkg.get_json_str(tab_rec.comments),
                                                                  p_key => 'CAPTION');
        --字段描述                    
        v_fd_rec.caption := nvl(v_rtn,
                                TRIM(substr(tab_rec.comments,
                                            0,
                                            instr(tab_rec.comments, '[') - 1)));
        v_fd_rec.caption := CASE
                              WHEN v_fd_rec.caption IS NULL THEN
                               'NULL'
                              ELSE
                               '''' || TRIM(translate(v_fd_rec.caption,
                                                      chr(13) || chr(10),
                                                      ',')) || ''''
                            END;
      
        v_rtn                  := scmdata.pkg_plat_comm.f_parse_json(scmdata.sf_get_arguments_pkg.get_json_str(tab_rec.comments),
                                                                     p_key => 'INPUT_HINT');
        v_fd_rec.input_hint := CASE
                                 WHEN v_rtn IS NULL THEN
                                  'NULL'
                                 ELSE
                                  '''' || v_rtn || ''''
                               END;
        v_fd_rec.valid_chars   := 'NULL';
        v_fd_rec.invalid_chars := 'NULL';
        v_rtn                  := scmdata.pkg_plat_comm.f_parse_json(scmdata.sf_get_arguments_pkg.get_json_str(tab_rec.comments),
                                                                     p_key => 'ALIGNMENT');
        v_fd_rec.alignment     := nvl(v_rtn, 2);
        v_rtn                  := scmdata.pkg_plat_comm.f_parse_json(scmdata.sf_get_arguments_pkg.get_json_str(tab_rec.comments),
                                                                     p_key => 'DATA_TYPE');
        v_fd_rec.data_type := CASE
                                WHEN v_rtn IS NULL THEN
                                 'NULL'
                                ELSE
                                 '''' || v_rtn || ''''
                              END;
        v_rtn                  := scmdata.pkg_plat_comm.f_parse_json(scmdata.sf_get_arguments_pkg.get_json_str(tab_rec.comments),
                                                                     p_key => 'CHECK_EXPRESS');
        v_fd_rec.check_express := CASE
                                    WHEN v_rtn IS NULL THEN
                                     'NULL'
                                    ELSE
                                     '''' || v_rtn || ''''
                                  END;
        v_rtn                  := scmdata.pkg_plat_comm.f_parse_json(scmdata.sf_get_arguments_pkg.get_json_str(tab_rec.comments),
                                                                     p_key => 'CHECK_MESSAGE');
        v_fd_rec.check_message := CASE
                                    WHEN v_rtn IS NULL THEN
                                     'NULL'
                                    ELSE
                                     '''' || v_rtn || ''''
                                  END;
      
        v_rtn                   := scmdata.pkg_plat_comm.f_parse_json(scmdata.sf_get_arguments_pkg.get_json_str(tab_rec.comments),
                                                                      p_key => 'DEFAULT_VALUE');
        v_fd_rec.default_value := CASE
                                    WHEN v_rtn IS NULL THEN
                                     'NULL'
                                    ELSE
                                     '''' || v_rtn || ''''
                                  END;
        v_rtn                   := scmdata.pkg_plat_comm.f_parse_json(scmdata.sf_get_arguments_pkg.get_json_str(tab_rec.comments),
                                                                      p_key => 'MAX_VALUE');
        v_fd_rec.max_value      := nvl(v_rtn, 0);
        v_rtn                   := scmdata.pkg_plat_comm.f_parse_json(scmdata.sf_get_arguments_pkg.get_json_str(tab_rec.comments),
                                                                      p_key => 'MIN_VALUE');
        v_fd_rec.min_value      := nvl(v_rtn, 0);
        v_rtn                   := scmdata.pkg_plat_comm.f_parse_json(scmdata.sf_get_arguments_pkg.get_json_str(tab_rec.comments),
                                                                      p_key => 'MAX_LENGTH');
        v_fd_rec.max_length     := nvl(v_rtn, 0);
        v_rtn                   := scmdata.pkg_plat_comm.f_parse_json(scmdata.sf_get_arguments_pkg.get_json_str(tab_rec.comments),
                                                                      p_key => 'MIN_LENGTH');
        v_fd_rec.min_length     := nvl(v_rtn, 0);
        v_rtn                   := scmdata.pkg_plat_comm.f_parse_json(scmdata.sf_get_arguments_pkg.get_json_str(tab_rec.comments),
                                                                      p_key => 'DISPLAY_WIDTH');
        v_fd_rec.display_width  := nvl(v_rtn, 0);
        v_rtn                   := scmdata.pkg_plat_comm.f_parse_json(scmdata.sf_get_arguments_pkg.get_json_str(tab_rec.comments),
                                                                      p_key => 'DISPLAY_FORMAT');
        v_fd_rec.display_format := CASE
                                     WHEN v_rtn IS NULL THEN
                                      'NULL'
                                     ELSE
                                      '''' || v_rtn || ''''
                                   END;
        v_rtn                   := scmdata.pkg_plat_comm.f_parse_json(scmdata.sf_get_arguments_pkg.get_json_str(tab_rec.comments),
                                                                      p_key => 'EDIT_FORMT');
        v_fd_rec.edit_formt := CASE
                                 WHEN v_rtn IS NULL THEN
                                  'NULL'
                                 ELSE
                                  '''' || v_rtn || ''''
                               END;
      
        v_rtn                   := scmdata.pkg_plat_comm.f_parse_json(scmdata.sf_get_arguments_pkg.get_json_str(tab_rec.comments),
                                                                      p_key => 'READ_ONLY');
        v_fd_rec.read_only_flag := nvl(v_rtn, 0);
        v_rtn                   := scmdata.pkg_plat_comm.f_parse_json(scmdata.sf_get_arguments_pkg.get_json_str(tab_rec.comments),
                                                                      p_key => 'NO_EDIT');
        v_fd_rec.no_edit        := nvl(v_rtn, 0);
        v_rtn                   := scmdata.pkg_plat_comm.f_parse_json(scmdata.sf_get_arguments_pkg.get_json_str(tab_rec.comments),
                                                                      p_key => 'NO_COPY');
        v_fd_rec.no_copy        := nvl(v_rtn, 0);
        v_rtn                   := scmdata.pkg_plat_comm.f_parse_json(scmdata.sf_get_arguments_pkg.get_json_str(tab_rec.comments),
                                                                      p_key => 'NO_SUM');
        v_fd_rec.no_sum         := nvl(v_rtn, 0);
        v_rtn                   := scmdata.pkg_plat_comm.f_parse_json(scmdata.sf_get_arguments_pkg.get_json_str(tab_rec.comments),
                                                                      p_key => 'NO_SORT');
        v_fd_rec.no_sort        := nvl(v_rtn, 0);
      
        v_fd_rec.ime_care                    := 0;
        v_fd_rec.ime_open                    := 0;
        v_fd_rec.value_lists                 := 'NULL';
        v_fd_rec.value_list_type             := 0;
        v_fd_rec.hyper_res                   := 'NULL';
        v_fd_rec.multi_value_flag            := 0;
        v_fd_rec.true_expr                   := 'NULL';
        v_fd_rec.false_expr                  := 'NULL';
        v_fd_rec.name_rule_flag              := 0;
        v_fd_rec.name_rule_id                := 0;
        v_fd_rec.data_type_flag              := 0;
        v_fd_rec.allow_scan                  := 0;
        v_fd_rec.value_encrypt               := 0;
        v_fd_rec.value_sensitive             := 0;
        v_fd_rec.operator_flag               := 0;
        v_fd_rec.value_display_style         := 'NULL';
        v_fd_rec.to_item_id                  := 'NULL';
        v_fd_rec.value_sensitive_replacement := 'NULL';
        v_rtn                                := scmdata.pkg_plat_comm.f_parse_json(scmdata.sf_get_arguments_pkg.get_json_str(tab_rec.comments),
                                                                                   p_key => 'STORE_SOURCE');
        v_fd_rec.store_source := CASE
                                   WHEN v_rtn IS NULL THEN
                                    'NULL'
                                   ELSE
                                    '''' || v_rtn || ''''
                                 END;
        v_fd_rec.enable_stand_permission     := 0;
        --meger
        v_sql := q'[INSERT INTO ]' || (CASE
                   WHEN v_tb_pre IS NOT NULL THEN
                    v_tb_pre || '.'
                   ELSE
                    NULL
                 END) || q'[sys_field_list 
  (field_name, caption, requiered_flag, input_hint, valid_chars,invalid_chars, check_express, check_message, read_only_flag, no_edit,no_copy, no_sum, no_sort, alignment, max_length, min_length,display_width, display_format, edit_formt, data_type, max_value,min_value, default_value, ime_care, ime_open, value_lists,value_list_type, hyper_res, multi_value_flag, true_expr, false_expr,name_rule_flag, name_rule_id, data_type_flag, allow_scan, value_encrypt,value_sensitive, operator_flag, value_display_style, to_item_id,value_sensitive_replacement, store_source, enable_stand_permission)
VALUES
  (]' || v_fd_rec.field_name || q'[,]' || v_fd_rec.caption ||
                 q'[,]' || v_fd_rec.requiered_flag || q'[,]' ||
                 v_fd_rec.input_hint || q'[,]' || v_fd_rec.valid_chars || q'[,]' ||
                 v_fd_rec.invalid_chars || q'[,]' || v_fd_rec.check_express ||
                 q'[,]' || v_fd_rec.check_message || q'[,]' ||
                 v_fd_rec.read_only_flag || q'[,]' || v_fd_rec.no_edit || q'[,]' ||
                 v_fd_rec.no_copy || q'[,]' || v_fd_rec.no_sum || q'[,]' ||
                 v_fd_rec.no_sort || q'[,]' || v_fd_rec.alignment || q'[,]' ||
                 v_fd_rec.max_length || q'[,]' || v_fd_rec.min_length || q'[,]' ||
                 v_fd_rec.display_width || q'[,]' || v_fd_rec.display_format ||
                 q'[,]' || v_fd_rec.edit_formt || q'[,]' || v_fd_rec.data_type ||
                 q'[,]' || v_fd_rec.max_value || q'[,]' || v_fd_rec.min_value ||
                 q'[,]' || v_fd_rec.default_value || q'[,]' || v_fd_rec.ime_care ||
                 q'[,]' || v_fd_rec.ime_open || q'[,]' || v_fd_rec.value_lists ||
                 q'[,]' || v_fd_rec.value_list_type || q'[,]' ||
                 v_fd_rec.hyper_res || q'[,]' || v_fd_rec.multi_value_flag ||
                 q'[,]' || v_fd_rec.true_expr || q'[,]' || v_fd_rec.false_expr ||
                 q'[,]' || v_fd_rec.name_rule_flag || q'[,]' ||
                 v_fd_rec.name_rule_id || q'[,]' || v_fd_rec.data_type_flag ||
                 q'[,]' || v_fd_rec.allow_scan || q'[,]' ||
                 v_fd_rec.value_encrypt || q'[,]' || v_fd_rec.value_sensitive ||
                 q'[,]' || v_fd_rec.operator_flag || q'[,]' ||
                 v_fd_rec.value_display_style || q'[,]' || v_fd_rec.to_item_id ||
                 q'[,]' || v_fd_rec.value_sensitive_replacement || q'[,]' ||
                 v_fd_rec.store_source || q'[,]' ||
                 v_fd_rec.enable_stand_permission || q'[);]';
        vo_sql := vo_sql || chr(13) || v_sql || chr(13);
      END IF;
    END LOOP;
    po_sql := vo_sql;
  END get_field_list_init_sql;

  --表字段没配置json时调用改过程生成field_list
  --使用merge 合并  待做
  PROCEDURE get_field_list_init_sql_no_tbconfig(p_tb_pre     VARCHAR2 DEFAULT 'nbw',
                                                p_table_name VARCHAR2,
                                                p_method     VARCHAR2 DEFAULT 'I',
                                                p_is_bz      INT DEFAULT 0,
                                                p_bz_pre     VARCHAR2 DEFAULT NULL,
                                                p_bz_suf     VARCHAR2 DEFAULT NULL,
                                                po_sql       OUT CLOB) IS
    v_tb_pre     VARCHAR2(256) := p_tb_pre; --属主
    v_pre        VARCHAR2(256) := p_bz_pre; --模块前缀
    v_suf        VARCHAR2(256) := p_bz_suf;
    v_table_name VARCHAR2(256) := upper(p_table_name);
    v_method     VARCHAR2(256) := upper(p_method);
    v_rtn        VARCHAR2(2000);
    v_fd_rec     nbw.sys_field_list%ROWTYPE;
    v_sql        CLOB;
    vo_sql       CLOB;
  BEGIN
    FOR tab_rec IN (SELECT t.*, c.comments
                      FROM user_tab_columns t
                     INNER JOIN user_col_comments c
                        ON t.table_name = c.table_name
                       AND t.column_name = c.column_name
                     WHERE t.table_name = v_table_name
                     ORDER BY t.column_id) LOOP
    
      v_rtn := CASE
                 WHEN tab_rec.nullable = 'N' THEN
                  1
                 ELSE
                  0
               END;
    
      --是否必填                    
      v_fd_rec.requiered_flag := v_rtn;
    
      --字段名
      v_fd_rec.field_name := (CASE
                               WHEN p_is_bz = 1 THEN --是否起别名
                                v_pre || tab_rec.column_name ||
                                nvl(v_suf,
                                    (CASE
                                      WHEN v_rtn = 1 THEN
                                       '_Y'
                                      ELSE
                                       '_N'
                                    END))
                               ELSE
                                tab_rec.column_name
                             END);
    
      v_fd_rec.field_name := CASE
                               WHEN v_fd_rec.field_name IS NULL THEN
                                'NULL'
                               ELSE
                                '''' || v_fd_rec.field_name || ''''
                             END;
      --字段描述                    
      v_fd_rec.caption := CASE
                            WHEN tab_rec.comments IS NULL THEN
                             'NULL'
                            ELSE
                             '''' || tab_rec.comments || ''''
                          END;
    
      v_fd_rec.input_hint    := 'NULL';
      v_fd_rec.valid_chars   := 'NULL';
      v_fd_rec.invalid_chars := 'NULL';
      v_fd_rec.alignment     := 2;
    
      v_fd_rec.data_type := CASE
                              WHEN tab_rec.data_type IS NULL THEN
                               'NULL'
                              WHEN tab_rec.data_type = 'VARCHAR2' THEN
                               '16'
                              WHEN tab_rec.data_type = 'DATE' THEN
                               '12'
                              WHEN tab_rec.data_type = 'NUMBER' THEN
                               '10'
                              ELSE
                               'NULL'
                            END;
    
      v_fd_rec.check_express  := 'NULL';
      v_fd_rec.check_message  := 'NULL';
      v_fd_rec.default_value  := 'NULL';
      v_fd_rec.max_value      := 0;
      v_fd_rec.min_value      := 0;
      v_fd_rec.max_length     := 0;
      v_fd_rec.min_length     := 0;
      v_fd_rec.display_width  := 0;
      v_fd_rec.display_format := 'NULL';
      v_fd_rec.edit_formt     := 'NULL';
      v_fd_rec.read_only_flag := 0;
      v_fd_rec.no_edit        := 0;
      v_fd_rec.no_copy        := 0;
      v_fd_rec.no_sum         := 0;
      v_fd_rec.no_sort        := 0;
    
      v_fd_rec.ime_care                    := 0;
      v_fd_rec.ime_open                    := 0;
      v_fd_rec.value_lists                 := 'NULL';
      v_fd_rec.value_list_type             := 0;
      v_fd_rec.hyper_res                   := 'NULL';
      v_fd_rec.multi_value_flag            := 0;
      v_fd_rec.true_expr                   := 'NULL';
      v_fd_rec.false_expr                  := 'NULL';
      v_fd_rec.name_rule_flag              := 0;
      v_fd_rec.name_rule_id                := 0;
      v_fd_rec.data_type_flag              := 0;
      v_fd_rec.allow_scan                  := 0;
      v_fd_rec.value_encrypt               := 0;
      v_fd_rec.value_sensitive             := 'NULL';
      v_fd_rec.operator_flag               := 0;
      v_fd_rec.value_display_style         := 'NULL';
      v_fd_rec.to_item_id                  := 'NULL';
      v_fd_rec.value_sensitive_replacement := 'NULL';
      v_fd_rec.store_source                := 'NULL';
      v_fd_rec.enable_stand_permission     := 0;
    
      DECLARE
        v_insert_sql CLOB;
        v_update_sql CLOB;
        v_flag       INT;
        v_tb_pre_sql CLOB;
      BEGIN
        v_tb_pre_sql := (CASE
                          WHEN v_tb_pre IS NOT NULL THEN
                           v_tb_pre || '.'
                          ELSE
                           'nbw.'
                        END);
        v_insert_sql := q'[INSERT INTO ]' || v_tb_pre_sql || q'[sys_field_list 
  (field_name, caption, requiered_flag, input_hint, valid_chars,invalid_chars, check_express, check_message, read_only_flag, no_edit,no_copy, no_sum, no_sort, alignment, max_length, min_length,display_width, display_format, edit_formt, data_type, max_value,min_value, default_value, ime_care, ime_open, value_lists,value_list_type, hyper_res, multi_value_flag, true_expr, false_expr,name_rule_flag, name_rule_id, data_type_flag, allow_scan, value_encrypt,value_sensitive, operator_flag, value_display_style, to_item_id,value_sensitive_replacement, store_source, enable_stand_permission)
VALUES
  (]' || v_fd_rec.field_name || q'[,]' ||
                        v_fd_rec.caption || q'[,]' ||
                        v_fd_rec.requiered_flag || q'[,]' ||
                        v_fd_rec.input_hint || q'[,]' ||
                        v_fd_rec.valid_chars || q'[,]' ||
                        v_fd_rec.invalid_chars || q'[,]' ||
                        v_fd_rec.check_express || q'[,]' ||
                        v_fd_rec.check_message || q'[,]' ||
                        v_fd_rec.read_only_flag || q'[,]' ||
                        v_fd_rec.no_edit || q'[,]' || v_fd_rec.no_copy ||
                        q'[,]' || v_fd_rec.no_sum || q'[,]' ||
                        v_fd_rec.no_sort || q'[,]' || v_fd_rec.alignment ||
                        q'[,]' || v_fd_rec.max_length || q'[,]' ||
                        v_fd_rec.min_length || q'[,]' ||
                        v_fd_rec.display_width || q'[,]' ||
                        v_fd_rec.display_format || q'[,]' ||
                        v_fd_rec.edit_formt || q'[,]' || v_fd_rec.data_type ||
                        q'[,]' || v_fd_rec.max_value || q'[,]' ||
                        v_fd_rec.min_value || q'[,]' ||
                        v_fd_rec.default_value || q'[,]' ||
                        v_fd_rec.ime_care || q'[,]' || v_fd_rec.ime_open ||
                        q'[,]' || v_fd_rec.value_lists || q'[,]' ||
                        v_fd_rec.value_list_type || q'[,]' ||
                        v_fd_rec.hyper_res || q'[,]' ||
                        v_fd_rec.multi_value_flag || q'[,]' ||
                        v_fd_rec.true_expr || q'[,]' || v_fd_rec.false_expr ||
                        q'[,]' || v_fd_rec.name_rule_flag || q'[,]' ||
                        v_fd_rec.name_rule_id || q'[,]' ||
                        v_fd_rec.data_type_flag || q'[,]' ||
                        v_fd_rec.allow_scan || q'[,]' ||
                        v_fd_rec.value_encrypt || q'[,]' ||
                        v_fd_rec.value_sensitive || q'[,]' ||
                        v_fd_rec.operator_flag || q'[,]' ||
                        v_fd_rec.value_display_style || q'[,]' ||
                        v_fd_rec.to_item_id || q'[,]' ||
                        v_fd_rec.value_sensitive_replacement || q'[,]' ||
                        v_fd_rec.store_source || q'[,]' ||
                        v_fd_rec.enable_stand_permission || q'[);]';
      
        v_update_sql := q'[
    UPDATE nbw.sys_field_list t
     SET t.caption = ]' || v_fd_rec.caption || q'[,
         t.requiered_flag = ]' ||
                        v_fd_rec.requiered_flag || q'[,
         t.input_hint = ]' || v_fd_rec.input_hint || q'[,
         t.valid_chars = ]' || v_fd_rec.valid_chars || q'[,
         t.invalid_chars = ]' ||
                        v_fd_rec.invalid_chars || q'[,
         t.check_express = ]' ||
                        v_fd_rec.check_express || q'[,
         t.check_message = ]' ||
                        v_fd_rec.check_message || q'[,
         t.read_only_flag = ]' ||
                        v_fd_rec.read_only_flag || q'[,
         t.no_edit = ]' || v_fd_rec.no_edit || q'[,
         t.no_copy = ]' || v_fd_rec.no_copy || q'[,
         t.no_sum = ]' || v_fd_rec.no_sum || q'[,
         t.no_sort = ]' || v_fd_rec.no_sort || q'[,
         t.alignment = ]' || v_fd_rec.alignment || q'[,
         t.max_length = ]' || v_fd_rec.max_length || q'[,
         t.min_length = ]' || v_fd_rec.min_length || q'[,
         t.display_width = ]' ||
                        v_fd_rec.display_width || q'[,
         t.display_format = ]' ||
                        v_fd_rec.display_format || q'[,
         t.edit_formt = ]' || v_fd_rec.edit_formt || q'[,
         t.data_type = ]' || v_fd_rec.data_type || q'[,
         t.max_value = ]' || v_fd_rec.max_value || q'[,
         t.min_value = ]' || v_fd_rec.min_value || q'[,
         t.default_value = ]' ||
                        v_fd_rec.default_value || q'[,
         t.ime_care = ]' || v_fd_rec.ime_care || q'[,
         t.ime_open = ]' || v_fd_rec.ime_open || q'[,
         t.value_lists = ]' || v_fd_rec.value_lists || q'[,
         t.value_list_type = ]' ||
                        v_fd_rec.value_list_type || q'[,
         t.hyper_res = ]' || v_fd_rec.hyper_res || q'[,
         t.multi_value_flag = ]' ||
                        v_fd_rec.multi_value_flag || q'[,
         t.true_expr = ]' || v_fd_rec.true_expr || q'[,
         t.false_expr = ]' || v_fd_rec.false_expr || q'[,
         t.name_rule_flag = ]' ||
                        v_fd_rec.name_rule_flag || q'[,
         t.name_rule_id = ]' ||
                        v_fd_rec.name_rule_id || q'[,
         t.data_type_flag = ]' ||
                        v_fd_rec.data_type_flag || q'[,
         t.allow_scan = ]' || v_fd_rec.allow_scan || q'[,
         t.value_encrypt = ]' ||
                        v_fd_rec.value_encrypt || q'[,
         t.value_sensitive = ]' ||
                        v_fd_rec.value_sensitive || q'[,
         t.operator_flag = ]' ||
                        v_fd_rec.operator_flag || q'[,
         t.value_display_style = ]' ||
                        v_fd_rec.value_display_style || q'[,
         t.to_item_id = ]' || v_fd_rec.to_item_id || q'[,
         t.value_sensitive_replacement = ]' ||
                        v_fd_rec.value_sensitive_replacement || q'[,
         t.store_source = ]' ||
                        v_fd_rec.store_source || q'[,
         t.enable_stand_permission = ]' ||
                        v_fd_rec.enable_stand_permission || q'[
   WHERE t.field_name = ]' || v_fd_rec.field_name || ';';
      
        IF v_method = 'I' THEN
          vo_sql := vo_sql || chr(13) || v_insert_sql || chr(13);
        ELSIF v_method = 'U' THEN
          vo_sql := vo_sql || chr(13) || v_update_sql || chr(13);
        ELSE
          v_sql := q'[SELECT COUNT(1) FROM ]' || v_tb_pre_sql ||
                   q'[sys_field_list t where t.field_name = :field_name]';
          EXECUTE IMMEDIATE v_sql
            INTO v_flag
            USING v_fd_rec.field_name;
          IF v_flag = 0 THEN
            vo_sql := vo_sql || chr(13) || v_insert_sql || chr(13);
          ELSE
            vo_sql := vo_sql || chr(13) || v_update_sql || chr(13);
          END IF;
        END IF;
      END;
    END LOOP;
    po_sql := vo_sql;
  END get_field_list_init_sql_no_tbconfig;

  --获取表的所有基础操作
  PROCEDURE p_get_table_datas_base_operate(p_method      VARCHAR2,
                                           p_table_name  VARCHAR2,
                                           p_col_name    VARCHAR2 DEFAULT NULL,
                                           p_pre         VARCHAR2,
                                           p_is_bz       INT DEFAULT 0,
                                           p_bz_pre      VARCHAR2 DEFAULT NULL,
                                           p_bz_suf      VARCHAR2 DEFAULT NULL,
                                           p_is_comments INT DEFAULT 1,
                                           p_where_sql   VARCHAR2 DEFAULT NULL,
                                           po_sql        OUT CLOB) IS
    v_sql        CLOB;
    v_table_name VARCHAR2(256) := upper(p_table_name);
    v_ucc_rec    user_col_comments%ROWTYPE;
  
  BEGIN
    IF p_col_name IS NOT NULL THEN
      SELECT c.*
        INTO v_ucc_rec
        FROM user_tab_columns t
       INNER JOIN user_col_comments c
          ON t.table_name = c.table_name
         AND t.column_name = c.column_name
       WHERE t.table_name = v_table_name
         AND t.column_name = upper(p_col_name);
    END IF;
  
    --新增
    IF upper(p_method) = 'I' THEN
      p_get_table_insert_sql(p_table_name => v_table_name,
                             p_pre        => p_pre,
                             po_sql       => v_sql);
      po_sql := v_sql;
      --删除
    ELSIF upper(p_method) = 'D' THEN
      p_get_table_delete_sql(p_table_name => v_table_name,
                             p_pre        => p_pre,
                             p_where_sql  => p_where_sql,
                             po_sql       => v_sql);
      po_sql := v_sql;
      --修改
    ELSIF upper(p_method) = 'U' THEN
      p_get_table_update_sql(p_table_name  => v_table_name,
                             p_pre         => p_pre,
                             p_where_sql   => p_where_sql,
                             p_is_comments => p_is_comments,
                             po_sql        => v_sql);
      po_sql := v_sql;
      --查询
    ELSIF upper(p_method) = 'S' THEN
      p_get_table_query_sql(p_table_name  => v_table_name,
                            p_pre         => p_pre,
                            p_where_sql   => p_where_sql,
                            p_is_bz       => p_is_bz,
                            p_bz_pre      => p_bz_pre,
                            p_bz_suf      => p_bz_suf,
                            p_is_comments => p_is_comments,
                            po_sql        => v_sql);
    
      po_sql := v_sql;
      --初始化赋值
    ELSIF upper(p_method) = 'FZ' THEN
      p_get_init_assign_sql(p_table_name  => v_table_name,
                            p_pre         => p_pre,
                            p_is_bz       => p_is_bz,
                            p_bz_pre      => p_bz_pre,
                            p_bz_suf      => p_bz_suf,
                            p_is_comments => p_is_comments,
                            po_sql        => v_sql);
      po_sql := v_sql;
      --fieldlist
    ELSIF upper(p_method) = 'FL' THEN
      NULL;
      /* FOR fl_rec IN fl_cur LOOP
        dbms_output.put_line(fl_rec.insert_sql);
        dbms_output.put_line('');
        po_sql := po_sql || fl_rec.insert_sql;
      END LOOP;*/
      --必填校验
    ELSIF upper(p_method) = 'CK' THEN
      DECLARE
        v_rtn      VARCHAR(2000);
        v_desc     VARCHAR2(256);
        v_requered VARCHAR2(1);
      BEGIN
        SELECT CASE
                 WHEN t.nullable = 'N' THEN
                  '1'
                 ELSE
                  '0'
               END
          INTO v_requered
          FROM user_tab_columns t
         WHERE t.table_name = upper(p_table_name)
           AND t.column_name = upper(p_col_name);
      
        v_rtn := nvl(scmdata.pkg_plat_comm.f_parse_json(get_json_str(v_ucc_rec.comments),
                                                        p_key => 'REQUERED'),
                     v_requered);
      
        IF v_rtn = '1' THEN
          v_desc := nvl(scmdata.pkg_plat_comm.f_parse_json(get_json_str(v_ucc_rec.comments),
                                                           p_key => 'CAPTION'),
                        v_ucc_rec.comments);
          v_sql  := q'[IF p_]' || p_col_name ||
                    q'[ IS NULL THEN
        raise_application_error(-20002,'【]' ||
                    nvl(v_desc,
                        TRIM(substr(v_ucc_rec.comments,
                                    0,
                                    instr(v_ucc_rec.comments, '[') - 1))) ||
                    q'[】必填，请检查！');
      END IF;]';
        END IF;
        po_sql := v_sql;
      END;
    ELSE
      dbms_output.put_line('目前仅支持查询/新增/修改/初始化赋值/fieldlist，自动生成参数..');
    END IF;
    po_sql := upper(po_sql);
  END p_get_table_datas_base_operate;

  --获取字符中的json数据
  FUNCTION get_json_str(p_str CLOB) RETURN CLOB IS
    v_str CLOB;
  BEGIN
    SELECT substr(p_str,
                  instr(p_str, '[') + 1,
                  instr(p_str, ']') - 1 - instr(p_str, '['))
      INTO v_str
      FROM dual;
    RETURN v_str;
  END get_json_str;
END pkg_scm_reverse_generation;
/

