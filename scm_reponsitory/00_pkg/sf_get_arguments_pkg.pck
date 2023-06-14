CREATE OR REPLACE PACKAGE SCMDATA.sf_get_arguments_pkg IS

  -- Author  : SANFU
  -- Created : 2020/7/22 14:40:49
  -- Purpose : 动态获取包中存储过程或者函数的参数

  --获取数据库存储过程，函数等方法参数，形成注释
  PROCEDURE get_arguments(p_pkg_name IN VARCHAR2, p_obj_name IN VARCHAR2);
  --获取数据库存储过程，函数等方法参数
  PROCEDURE pf_get_arguments(p_pkg_name   IN VARCHAR2,
                             p_obj_name   IN VARCHAR2,
                             p_table_name IN VARCHAR2 DEFAULT NULL,
                             p_is_print   INT DEFAULT 1,
                             po_sql       OUT CLOB,
                             po_params    OUT CLOB);

  --自动获取新增，修改 参数
  -- p_method:新增 i  修改 u    
  -- p_table_name 表名
  --p_pre 前缀 可为空
  PROCEDURE get_iu_table_datas(p_method      VARCHAR2,
                               p_table_name  VARCHAR2,
                               p_col_name    VARCHAR2 DEFAULT NULL,
                               p_fpre        VARCHAR2 DEFAULT NULL,
                               p_pre         VARCHAR2,
                               p_suf         VARCHAR2,
                               p_where_sql   VARCHAR2 DEFAULT NULL,
                               p_is_impl     INT DEFAULT 0,
                               p_is_comments INT DEFAULT 1,
                               po_sql        OUT CLOB);

  --获取表字段 初始化field_list
  PROCEDURE get_field_list_init_sql(p_tb_pre     VARCHAR2 DEFAULT 'nbw',
                                    p_table_name VARCHAR2,
                                    p_md_pre     VARCHAR2 DEFAULT NULL,
                                    p_suf        VARCHAR2 DEFAULT NULL,
                                    po_sql       OUT CLOB);

  --表字段没配置json时调用改过程生成field_list
  PROCEDURE get_field_list_init_sql_no_tbconfig(p_tb_pre     VARCHAR2 DEFAULT 'nbw',
                                                p_table_name VARCHAR2,
                                                p_md_pre     VARCHAR2 DEFAULT NULL,
                                                p_suf        VARCHAR2 DEFAULT NULL,
                                                po_sql       OUT CLOB);

  --函数/过程初始化 begin
  PROCEDURE get_func_proc_init_begin_sql(p_table_name  VARCHAR2,
                                         p_col_name    VARCHAR2 DEFAULT NULL,
                                         p_method      VARCHAR2,
                                         p_method_type INT DEFAULT 0,
                                         p_pre         VARCHAR2,
                                         p_is_dec      INT DEFAULT 1,
                                         po_sql        OUT CLOB);
  --函数/过程初始化 end
  PROCEDURE get_func_proc_init_end_sql(p_table_name  VARCHAR2,
                                       p_col_name    VARCHAR2 DEFAULT NULL,
                                       p_method      VARCHAR2,
                                       p_method_type INT DEFAULT 0,
                                       p_is_dec      INT DEFAULT 1,
                                       po_sql        OUT CLOB);
  --初始化包
  PROCEDURE get_init_pkg(p_table_name VARCHAR2, po_sql OUT CLOB);

  --初始化item_list增删改查
  PROCEDURE get_init_item_list_crud(p_pkg_name   VARCHAR2,
                                    p_table_name VARCHAR2,
                                    p_moudle_pre VARCHAR2 DEFAULT NULL,
                                    p_user       VARCHAR2 DEFAULT 'admin',
                                    p_is_restful INT DEFAULT 0,
                                    p_ass_id     VARCHAR2 DEFAULT NULL,
                                    po_sql       OUT CLOB);

  --生成item_list增删改查
  PROCEDURE get_init_item_list_crud(p_pkg_name      VARCHAR2,
                                    p_table_name    VARCHAR2 DEFAULT NULL,
                                    p_method_name   VARCHAR2,
                                    p_moudle_pre    VARCHAR2 DEFAULT NULL,
                                    p_is_restful    INT DEFAULT 0,
                                    p_is_get_params INT DEFAULT 1,
                                    p_ass_id        VARCHAR2 DEFAULT NULL,
                                    p_rest_method   VARCHAR2 DEFAULT NULL,
                                    po_sql          OUT CLOB);

  --初始化所有基础sql
  PROCEDURE get_init_all_base_sql(p_table_name           VARCHAR2,
                                  p_moudle_pre           VARCHAR2 DEFAULT NULL,
                                  p_is_config_field_list INT DEFAULT 0,
                                  po_sql                 OUT CLOB);

  FUNCTION my_concat(tablename VARCHAR2, TYPE VARCHAR2, where_sql VARCHAR2)
    RETURN VARCHAR2;

  PROCEDURE autogeneratesql(tablename  VARCHAR2,
                            TYPE       VARCHAR2,
                            out_result OUT VARCHAR2,
                            where_sql  IN VARCHAR2);

  FUNCTION remove_constants(p_query IN VARCHAR2) RETURN VARCHAR2;

  --分割
  FUNCTION get_strarraylength(av_str   VARCHAR2, --要分割的字符串
                              av_split VARCHAR2 --分隔符号
                              ) RETURN NUMBER;
  --提取
  FUNCTION get_strarraystrofindex(av_str   VARCHAR2, --要分割的字符串
                                  av_split VARCHAR2, --分隔符号
                                  av_index NUMBER --取第几个元素
                                  ) RETURN VARCHAR2;
  /*  --提取字符数组
  FUNCTION get_strarray(av_str   VARCHAR2, --要分割的字符串
                        av_split VARCHAR2 --分隔符号
                        ) RETURN role_name_tb_type;*/

  --获取字符中的json数据
  FUNCTION get_json_str(p_str CLOB) RETURN CLOB;

END sf_get_arguments_pkg;
/

CREATE OR REPLACE PACKAGE BODY SCMDATA.sf_get_arguments_pkg IS

  --获取数据库存储过程，函数等方法参数，形成注释
  PROCEDURE get_arguments(p_pkg_name IN VARCHAR2, p_obj_name IN VARCHAR2) IS
    v_pkg_name   VARCHAR2(100) := upper(p_pkg_name);
    v_obj_name   VARCHAR2(100) := upper(p_obj_name);
    v_arg_number NUMBER;
    CURSOR data_cur IS
      SELECT t.package_name,
             t.object_name,
             t.argument_name,
             t.in_out,
             COUNT(t.argument_name) over(PARTITION BY t.object_name) arg_number,
             row_number() over(PARTITION BY t.object_name ORDER BY t.position ASC) rank_position
        FROM sys.user_arguments t
       WHERE t.package_name = v_pkg_name
         AND t.object_name = v_obj_name
         AND t.position <> 0;
  
  BEGIN
    SELECT COUNT(1)
      INTO v_arg_number
      FROM sys.user_arguments t
     WHERE t.package_name = v_pkg_name
       AND t.object_name = v_obj_name
       AND t.position <> 0;
  
    dbms_output.put_line('/*============================================*');
    dbms_output.put_line(' * Author   : CZH');
    dbms_output.put_line(' * Created  : ' ||
                         to_char(SYSDATE, 'YYYY-MM-DD HH24:MI:SS'));
  
    dbms_output.put_line(' * ALERTER  : ');
    dbms_output.put_line(' * ALERTER_TIME  : ');
    dbms_output.put_line(' * Purpose  : ');
    dbms_output.put_line(' * Obj_Name    : ' || v_obj_name);
    dbms_output.put_line(' * Arg_Number  : ' || v_arg_number);
    dbms_output.put_line(' * < IN PARAMS >  ');
    FOR rec IN data_cur LOOP
      dbms_output.put_line(' * ' || rec.argument_name || ' :');
    END LOOP;
    dbms_output.put_line(' *============================================*/');
  END get_arguments;

  --获取数据库存储过程，函数等方法参数
  PROCEDURE pf_get_arguments(p_pkg_name   IN VARCHAR2,
                             p_obj_name   IN VARCHAR2,
                             p_table_name IN VARCHAR2 DEFAULT NULL,
                             p_is_print   INT DEFAULT 1,
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
    IF p_is_print = 1 THEN
      dbms_output.put_line(v_pkg_name || '.' || v_obj_name || '(');
    END IF;
    FOR rec IN data_cur LOOP
      IF rec.in_out = 'IN' THEN
        v_attr := 'v_';
      ELSIF rec.in_out = 'OUT' THEN
        v_attr := 'vo_';
      ELSIF rec.in_out = 'IN/OUT' THEN
        v_attr := 'v_';
      END IF;
      IF p_is_print = 1 AND data_cur%ROWCOUNT = rec.arg_number THEN
        dbms_output.put_line(lower(rec.argument_name) || ' =>' || ' ' ||
                             v_attr || lower(rec.argument_name));
      ELSE
        NULL; /*dbms_output.put_line(lower(rec.argument_name) || '        =>' ||
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     '   ' || v_attr || lower(rec.argument_name) || ',');*/
      END IF;
      vo_sql := vo_sql || ',' || lower(rec.argument_name) || '  =>' || ' ' ||
                v_attr || ltrim(lower(rec.argument_name), 'p_');
    
      vo_params := vo_params || v_attr || ltrim(lower(rec.argument_name), 'p_') || ' ' ||
                   (CASE
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
    IF p_is_print = 1 THEN
      dbms_output.put_line(');');
    END IF;
    po_sql    := v_pkg_name || '.' || v_obj_name || '(' ||
                 ltrim(vo_sql, ',') || ');';
    po_params := vo_params;
  END pf_get_arguments;
  --自动获取新增，修改 参数
  -- p_method:新增 i  修改 u  新增 s   初始化赋值 fz
  -- p_table_name 表名
  --p_pre 前缀 可为空
  --p_suf 后缀
  PROCEDURE get_iu_table_datas(p_method      VARCHAR2,
                               p_table_name  VARCHAR2,
                               p_col_name    VARCHAR2 DEFAULT NULL,
                               p_fpre        VARCHAR2 DEFAULT NULL,
                               p_pre         VARCHAR2,
                               p_suf         VARCHAR2,
                               p_where_sql   VARCHAR2 DEFAULT NULL,
                               p_is_impl     INT DEFAULT 0,
                               p_is_comments INT DEFAULT 1,
                               po_sql        OUT CLOB) IS
    v_sql   CLOB;
    v_pk_id VARCHAR2(256);
    v_str   VARCHAR2(256);
    v_str1  VARCHAR2(256);
    --v_str3   VARCHAR2(256);
    v_str4 VARCHAR2(256);
    --v_utc_rec user_tab_columns%ROWTYPE;
    v_ucc_rec user_col_comments%ROWTYPE;
    CURSOR fl_cur IS
      SELECT q'[INSERT INTO nbw.sys_field_list (field_name,caption,requiered_flag,read_only_flag,no_edit,no_copy,no_sort,alignment,ime_care,ime_open)
VALUES(']' || p_pre || t.column_name ||
              nvl(p_suf,
                  (CASE
                    WHEN t.nullable = 'Y' THEN
                     '_N'
                    ELSE
                     '_Y'
                  END)) || q'[', ']' || c.comments || q'[', ]' || (CASE
                WHEN t.nullable = 'Y' THEN
                 '0'
                ELSE
                 '1'
              END) || q'[, 0, 0, 0, 0, 0, 0, 0)]' || ';' AS insert_sql
        FROM user_tab_columns t
       INNER JOIN user_col_comments c
          ON t.table_name = c.table_name
         AND t.column_name = c.column_name
       WHERE t.table_name = upper(p_table_name)
       ORDER BY t.column_id;
  BEGIN
    SELECT MAX(a.column_name)
      INTO v_pk_id
      FROM user_cons_columns a
     INNER JOIN user_constraints b
        ON b.constraint_name = a.constraint_name
       AND b.constraint_type = 'P'
     WHERE a.table_name = upper(p_table_name);
  
    IF p_col_name IS NOT NULL THEN
      SELECT c.*
        INTO v_ucc_rec
        FROM user_tab_columns t
       INNER JOIN user_col_comments c
          ON t.table_name = c.table_name
         AND t.column_name = c.column_name
       WHERE t.table_name = upper(p_table_name)
         AND t.column_name = upper(p_col_name);
    END IF;
    v_str := ' WHERE t.' || v_pk_id || ' = ' || q'[''' || v_]' || v_pk_id ||
             q'[ || ''']';
  
    v_str1 := ' WHERE t.' || v_pk_id || ' = v_' || v_pk_id || ';';
  
    /* v_str3 := ' WHERE t.' || v_pk_id || ' = ' || q'[''' || ]' || p_pre ||
    v_pk_id || q'[ || ''']';*/
  
    v_str4 := ' WHERE t.' || v_pk_id || ' = ' || p_pre || v_pk_id || ';';
  
    /*  SELECT t.*
     INTO v_utc_rec
     FROM user_tab_columns t
    WHERE t.table_name = upper(p_table_name);*/
    --新增
    IF upper(p_method) = 'I' THEN
      SELECT 'INSERT INTO ' || listagg(DISTINCT(t.table_name)) || ' (' ||
             rtrim(xmlagg(xmlparse(content t.column_name || ',' wellformed) ORDER BY t.column_id).getclobval(),
                   ',') || ')' || ' VALUES( ' ||
             rtrim(xmlagg(xmlparse(content p_pre || t.column_name || ',' wellformed) ORDER BY t.column_id).getclobval(),
                   ',') || ' );'
        INTO v_sql
        FROM user_tab_columns t
       WHERE t.table_name = upper(p_table_name);
    
      dbms_output.put_line(v_sql);
      po_sql := v_sql;
      --删除
    ELSIF upper(p_method) = 'D' THEN
      v_sql  := 'DELETE FROM ' || p_table_name || ' t ' ||
                nvl(p_where_sql, ' WHERE 1 = 0;');
      po_sql := v_sql;
    ELSIF upper(p_method) = 'D_ID' THEN
      v_sql  := 'DELETE FROM ' || p_table_name || ' t ';
      po_sql := v_sql || nvl(p_where_sql, v_str1);
      --修改
    ELSIF upper(p_method) = 'U' THEN
      SELECT 'UPDATE ' || listagg(DISTINCT(t.table_name)) || ' t ' ||
             ' SET ' || rtrim(xmlagg(xmlparse(content(CASE
                                WHEN t.column_name = v_pk_id THEN
                                 NULL
                                ELSE
                                /*(CASE
                                  WHEN p_is_comments = 1 THEN
                                   chr(10) || '--' || c.comments || chr(10)
                                  ELSE
                                   NULL
                                END) ||*/
                                 ' t.' || t.column_name || ' =  ' || p_pre || t.column_name || ',' ||
                                 (CASE
                                   WHEN p_is_comments = 1 THEN
                                    ' --' || c.comments || chr(10)
                                   ELSE
                                    NULL
                                 END)
                              END) wellformed) ORDER BY t.column_id).getclobval(),
                              ',') ||
             nvl(nvl(p_where_sql, v_str4), ' WHERE 1 = 0;')
        INTO v_sql
        FROM user_tab_columns t
       INNER JOIN user_col_comments c
          ON t.table_name = c.table_name
         AND t.column_name = c.column_name
       WHERE t.table_name = upper(p_table_name);
    
      v_sql := regexp_replace(v_sql, '(.)', '', instr(v_sql, ',', -1), 1);
      dbms_output.put_line(v_sql);
      po_sql := v_sql;
      --修改 通过ID
    ELSIF upper(p_method) = 'U_ID' THEN
      SELECT 'UPDATE ' || listagg(DISTINCT(t.table_name)) || ' t ' ||
             ' SET ' || rtrim(xmlagg(xmlparse(content(CASE
                                WHEN t.column_name = v_pk_id THEN
                                 NULL
                                ELSE
                                 (CASE
                                   WHEN p_is_comments = 1 THEN
                                    chr(10) || ' --' || c.comments || chr(10)
                                   ELSE
                                    NULL
                                 END) || ' t.' || t.column_name || ' =  ' || p_pre ||
                                 t.column_name || ','
                              END) wellformed) ORDER BY t.column_id).getclobval(),
                              ',')
        INTO v_sql
        FROM user_tab_columns t
       INNER JOIN user_col_comments c
          ON t.table_name = c.table_name
         AND t.column_name = c.column_name
       WHERE t.table_name = upper(p_table_name);
      v_sql := regexp_replace(v_sql, '(.)', '', instr(v_sql, ',', -1), 1);
      dbms_output.put_line(v_sql);
      po_sql := v_sql || nvl(p_where_sql, v_str1);
      --新增 去空
    ELSIF upper(p_method) = 'IN' THEN
      SELECT 'INSERT INTO ' || listagg(DISTINCT(t.table_name)) || ' (' ||
             rtrim(listagg(t.column_name || ',', '') within
                   GROUP(ORDER BY t.column_id),
                   ',') || ')' || ' VALUES( ' ||
             rtrim(listagg(decode(t.nullable,
                                  'Y',
                                  q'['']',
                                  'N',
                                  p_pre || t.column_name,
                                  q'['']') || ',',
                           '') within GROUP(ORDER BY t.column_id),
                   ',') || ' );'
        INTO v_sql
        FROM user_tab_columns t
       WHERE t.table_name = upper(p_table_name);
    
      dbms_output.put_line(v_sql);
      po_sql := v_sql;
      --修改 去空
    ELSIF upper(p_method) = 'UN' THEN
      SELECT 'UPDATE ' || listagg(DISTINCT(t.table_name)) || ' t ' ||
             ' SET ' ||
             rtrim(listagg(' t.' || t.column_name || ' =  ' ||
                           decode(t.nullable,
                                  'Y',
                                  q'['']',
                                  'N',
                                  p_pre || t.column_name,
                                  q'['']') || ',',
                           '') within GROUP(ORDER BY t.column_id),
                   ',') || nvl(p_where_sql, ' WHERE 1 = 0;')
        INTO v_sql
        FROM user_tab_columns t
       WHERE t.table_name = upper(p_table_name);
    
      dbms_output.put_line(v_sql);
      po_sql := v_sql;
      --查询
    ELSIF upper(p_method) = 'S' THEN
      SELECT 'SELECT ' ||
             rtrim(listagg('t.' || t.column_name || ',' || (CASE
                             WHEN p_is_comments = 1 THEN
                              ' --' || c.comments || chr(10)
                             ELSE
                              NULL
                           END),
                           '') within GROUP(ORDER BY t.column_id),
                   ',') || ' FROM ' || p_table_name || ' t ' ||
             nvl(p_where_sql, ' WHERE 1 = 1 ')
        INTO v_sql
        FROM user_tab_columns t
       INNER JOIN user_col_comments c
          ON t.table_name = c.table_name
         AND t.column_name = c.column_name
       WHERE t.table_name = upper(p_table_name);
      v_sql := regexp_replace(v_sql, '(.)', '', instr(v_sql, ',', -1), 1);
      --dbms_output.put_line(v_sql);
      po_sql := v_sql;
      --查询 通过ID,WHERE_SQL
    ELSIF upper(p_method) = 'S_ID' THEN
      SELECT 'SELECT ' ||
             rtrim(listagg('t.' || t.column_name || ',' || (CASE
                             WHEN p_is_comments = 1 THEN
                              ' --' || c.comments || chr(10)
                             ELSE
                              NULL
                           END),
                           '') within GROUP(ORDER BY t.column_id),
                   ',') || ' FROM ' || p_table_name || ' t '
        INTO v_sql
        FROM user_tab_columns t
       INNER JOIN user_col_comments c
          ON t.table_name = c.table_name
         AND t.column_name = c.column_name
       WHERE t.table_name = upper(p_table_name);
      v_sql := regexp_replace(v_sql, '(.)', '', instr(v_sql, ',', -1), 1);
      --dbms_output.put_line(v_sql);
      po_sql := v_sql || nvl(p_where_sql, v_str);
      --初始化赋值
    ELSIF upper(p_method) = 'FZ' THEN
      SELECT rtrim(xmlagg(xmlparse(content p_fpre || t.column_name || ' :=  ' || (CASE
                     WHEN p_is_impl = 1 AND t.column_name = v_pk_id THEN
                      'scmdata.f_get_uuid()'
                     WHEN t.column_name IN ('UPDATE_ID', 'CREATE_ID') THEN
                      ':user_id'
                     WHEN t.column_name IN ('UPDATE_TIME',
                                            'CREATE_TIME',
                                            'UPDATE_DATE',
                                            'CREATE_DATE') THEN
                      'SYSDATE'
                     ELSE
                      ':' || p_pre || t.column_name ||
                      nvl(p_suf,
                          (CASE
                            WHEN t.nullable = 'Y' THEN
                             '_N'
                            ELSE
                             '_Y'
                          END))
                   END) || ';' || '--' || c.comments || chr(10) wellformed) ORDER BY t.column_id).getclobval(),
                   ',')
        INTO v_sql
        FROM user_tab_columns t
       INNER JOIN user_col_comments c
          ON t.table_name = c.table_name
         AND t.column_name = c.column_name
       WHERE t.table_name = upper(p_table_name);
    
      --dbms_output.put_line(v_sql);
      po_sql := v_sql;
      --初始化赋值 去空
    ELSIF upper(p_method) = 'FZN' THEN
      SELECT rtrim(listagg(p_pre || t.column_name || ' :=  ' ||
                           decode(t.nullable,
                                  'Y',
                                  q'['']',
                                  'N',
                                  ':' || t.column_name,
                                  q'['']') || ';',
                           '') within GROUP(ORDER BY t.column_id),
                   ',')
        INTO v_sql
        FROM user_tab_columns t
       WHERE t.table_name = upper(p_table_name);
    
      dbms_output.put_line(v_sql);
      po_sql := v_sql;
      --查询起别名
    ELSIF upper(p_method) = 'BZ' THEN
      SELECT 'SELECT ' ||
             rtrim(listagg('t.' || t.column_name || ' ' || p_pre ||
                           upper(t.column_name) ||
                           nvl(p_suf,
                               (CASE
                                 WHEN t.nullable = 'Y' THEN
                                  '_N'
                                 ELSE
                                  '_Y'
                               END)) || ',' || (CASE
                             WHEN p_is_comments = 1 THEN
                              ' --' || c.comments || chr(10)
                             ELSE
                              NULL
                           END),
                           '') within GROUP(ORDER BY t.column_id),
                   ',') || ' FROM ' || p_table_name || ' t ' ||
             nvl(p_where_sql, ' WHERE 1 = 1 ')
        INTO v_sql
        FROM user_tab_columns t
       INNER JOIN user_col_comments c
          ON t.table_name = c.table_name
         AND t.column_name = c.column_name
       WHERE t.table_name = upper(p_table_name);
      v_sql := regexp_replace(v_sql, '(.)', '', instr(v_sql, ',', -1), 1);
      dbms_output.put_line(v_sql);
      po_sql := v_sql;
      --fieldlist
    ELSIF upper(p_method) = 'FL' THEN
      FOR fl_rec IN fl_cur LOOP
        dbms_output.put_line(fl_rec.insert_sql);
        dbms_output.put_line('');
        po_sql := po_sql || fl_rec.insert_sql;
      END LOOP;
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
  END get_iu_table_datas;

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
        dbms_output.put_line('');
        dbms_output.put_line(vo_sql);
      END IF;
    END LOOP;
    po_sql := vo_sql;
  END get_field_list_init_sql;

  --表字段没配置json时调用改过程生成field_list
  PROCEDURE get_field_list_init_sql_no_tbconfig(p_tb_pre     VARCHAR2 DEFAULT 'nbw',
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
      v_fd_rec.field_name := v_pre || tab_rec.column_name ||
                             nvl(v_suf,
                                 (CASE
                                   WHEN v_rtn = 1 THEN
                                    '_Y'
                                   ELSE
                                    '_N'
                                 END));
    
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
      v_fd_rec.value_sensitive             := 0;
      v_fd_rec.operator_flag               := 0;
      v_fd_rec.value_display_style         := 'NULL';
      v_fd_rec.to_item_id                  := 'NULL';
      v_fd_rec.value_sensitive_replacement := 'NULL';
      v_fd_rec.store_source                := 'NULL';
      v_fd_rec.enable_stand_permission     := 0;
    
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
      --dbms_output.put_line('-------1');
    --dbms_output.put_line(vo_sql);
    END LOOP;
    po_sql := vo_sql;
  END get_field_list_init_sql_no_tbconfig;

  --函数/过程初始化 begin
  PROCEDURE get_func_proc_init_begin_sql(p_table_name  VARCHAR2,
                                         p_col_name    VARCHAR2 DEFAULT NULL,
                                         p_method      VARCHAR2,
                                         p_method_type INT DEFAULT 0,
                                         p_pre         VARCHAR2,
                                         p_is_dec      INT DEFAULT 1,
                                         po_sql        OUT CLOB) IS
    vo_sql        CLOB;
    v_method_type VARCHAR2(256);
    v_pk_id       VARCHAR2(256);
    v_var         VARCHAR2(256);
    v_str         VARCHAR2(256);
    v_data_type   VARCHAR2(256);
    v_params      VARCHAR2(2000);
    v_var_define  VARCHAR2(256);
    v_var_define1 VARCHAR2(256);
    v_var_define2 VARCHAR2(256);
  BEGIN
    SELECT t.column_name, t.data_type
      INTO v_pk_id, v_data_type
      FROM user_tab_columns t
     WHERE t.table_name = upper(p_table_name)
       AND t.column_id = 1;
  
    IF p_method_type = 0 THEN
      v_method_type := NULL;
    ELSIF p_method_type = 1 THEN
      v_method_type := '_BY_ID';
      v_var         := 'v_' || v_pk_id || ' ' || v_data_type || '(32) := ' || 'p_' ||
                       v_pk_id || ';';
      v_params      := '(p_' || v_pk_id || ' ' || v_data_type || ')';
    ELSIF p_method_type = 2 THEN
      v_method_type := '_BY_COND';
    ELSIF p_method_type = 3 THEN
      SELECT MAX(t.data_type)
        INTO v_data_type
        FROM user_tab_columns t
       WHERE t.table_name = upper(p_table_name)
         AND t.column_name = upper(p_col_name);
      v_method_type := '_' || p_col_name;
      v_params := '(p_' || p_col_name || ' ' || (CASE
                    WHEN instr(p_method, 'CALL') > 0 THEN
                     ' => ' || 'P_' || substr(p_table_name, 0, 5) || '_rec.' ||
                     p_col_name
                    ELSE
                     v_data_type
                  END) || ')';
    ELSE
      v_method_type := NULL;
    END IF;
  
    v_str := (CASE
               WHEN p_method_type = 1 THEN
                '通过ID '
               WHEN p_method_type = 3 THEN
                p_col_name || ' '
               ELSE
                NULL
             END);
  
    v_var_define := (CASE
                      WHEN p_method_type = 1 THEN
                       v_params
                      ELSE
                       NULL
                    END) || q'[ RETURN CLOB IS 
v_sql CLOB;
]' || chr(13) || (CASE
                      WHEN p_method_type = 1 THEN
                       v_var
                      ELSE
                       NULL
                    END) || q'[
BEGIN 
v_sql := ']' || chr(13);
  
    v_var_define1 := (CASE
                       WHEN p_method_type IN (1, 3) THEN
                        v_params
                       ELSE
                        NULL
                     END) || q'[ IS
]' || chr(13) || (CASE
                       WHEN p_method_type IN (1, 3) THEN
                        v_var
                       ELSE
                        NULL
                     END) || q'[
BEGIN 
]' || chr(13);
  
    v_var_define2 := q'[ IS
BEGIN 
]' || chr(13);
  
    IF upper(p_method) = 'QUERY' THEN
      vo_sql := '--查询 ' || v_str || p_table_name || chr(13);
      --是否是声明
      IF p_is_dec = 1 THEN
        vo_sql := vo_sql || 'FUNCTION F_' || p_method || '_' || p_table_name ||
                  v_method_type || (CASE
                    WHEN p_method_type = 1 THEN
                     v_params
                    ELSE
                     NULL
                  END) || ' RETURN CLOB;' || chr(13);
      ELSIF p_is_dec = 0 THEN
        vo_sql := vo_sql || 'FUNCTION F_' || p_method || '_' ||
                  p_table_name || v_method_type || v_var_define;
      ELSE
        NULL;
      END IF;
      --调用
    ELSIF instr(upper(p_method), 'CALL') > 0 THEN
      vo_sql := vo_sql || 'scmdata.PKG_' || p_table_name || '.P_' ||
                substr(p_method, instr(p_method, '_') + 1) || (CASE
                  WHEN p_method_type = 3 THEN
                   NULL
                  ELSE
                   '_' || p_table_name
                END) || v_method_type || v_params || ';' || chr(13);
    ELSE
      vo_sql := (CASE
                  WHEN upper(p_method) = 'INSERT' THEN
                   '--新增 '
                  WHEN upper(p_method) = 'UPDATE' THEN
                   '--修改 '
                  WHEN upper(p_method) = 'DELETE' THEN
                   '--删除 '
                  WHEN upper(p_method) = 'CHECK' THEN
                   '--校验 '
                  WHEN upper(p_method) = 'INVOKE' THEN
                   '--调用 '
                END) || v_str || p_table_name || chr(13);
    
      IF p_method_type IN (1, 3) THEN
        --是否是声明
        IF p_is_dec = 1 THEN
          vo_sql := vo_sql || 'PROCEDURE P_' || p_method || (CASE
                      WHEN p_method_type = 3 THEN
                       NULL
                      ELSE
                       '_' || p_table_name
                    END) || v_method_type || v_params || ';' || chr(13);
        ELSE
          vo_sql := vo_sql || 'PROCEDURE P_' || p_method || (CASE
                      WHEN p_method_type = 3 THEN
                       NULL
                      ELSE
                       '_' || p_table_name
                    END) || v_method_type /*|| v_params*/
                    || v_var_define1;
        END IF;
      ELSE
        --是否是声明
        IF p_is_dec = 1 THEN
          vo_sql := vo_sql || 'PROCEDURE P_' || p_method || '_' ||
                    p_table_name || v_method_type || '(P_' ||
                    substr(p_table_name, 0, 5) || '_rec ' || p_pre ||
                    p_table_name || '%ROWTYPE)' || ';' || chr(13);
        ELSE
          vo_sql := vo_sql || 'PROCEDURE P_' || p_method || '_' ||
                    p_table_name || v_method_type || '(P_' ||
                    substr(p_table_name, 0, 5) || '_rec ' || p_pre ||
                    p_table_name || '%ROWTYPE)' || v_var_define2;
        END IF;
      END IF;
    END IF;
    po_sql := vo_sql;
  END get_func_proc_init_begin_sql;

  --函数/过程初始化 end
  PROCEDURE get_func_proc_init_end_sql(p_table_name  VARCHAR2,
                                       p_col_name    VARCHAR2 DEFAULT NULL,
                                       p_method      VARCHAR2,
                                       p_method_type INT DEFAULT 0,
                                       p_is_dec      INT DEFAULT 1,
                                       po_sql        OUT CLOB) IS
    vo_sql        CLOB;
    v_method_type VARCHAR2(256);
  BEGIN
    v_method_type := (CASE
                       WHEN p_method_type = 0 THEN
                        NULL
                       WHEN p_method_type = 1 THEN
                        '_BY_ID'
                       WHEN p_method_type = 2 THEN
                        '_BY_COND'
                       WHEN p_method_type = 3 THEN
                        '_' || p_col_name
                       ELSE
                        NULL
                     END);
    IF upper(p_method) = 'QUERY' THEN
      IF p_is_dec = 1 THEN
        NULL;
      ELSIF p_is_dec = 0 THEN
        vo_sql := q'[';
        RETURN v_sql;]' || chr(13) || q'[END F_]' ||
                  p_method || q'[_]' || p_table_name || v_method_type ||
                  q'[;]';
      ELSE
        NULL;
      END IF;
    ELSE
      vo_sql := 'END P_' || p_method || (CASE
                  WHEN p_method_type = 3 THEN
                   NULL
                  ELSE
                   '_' || p_table_name
                END) || v_method_type || ';' || chr(13);
    END IF;
    po_sql := vo_sql;
  END get_func_proc_init_end_sql;

  --初始化包
  /*p_pre 表前缀, 
  p_table_name 表名,
  p_query_type 查询类型 默认 'S',
  p_query_pre 查询前缀 默认 NULL,
  p_query_suf 查询后缀 默认 NULL*/
  PROCEDURE get_init_pkg(p_table_name VARCHAR2, po_sql OUT CLOB) IS
    v_pkg_name   VARCHAR2(256) := 'PKG_' || p_table_name;
    vo_begin_sql CLOB;
    vo_end_sql   CLOB;
    vo_call_sql  CLOB;
    vo_sql       CLOB;
    vo_sql1      CLOB;
    v_rtn        VARCHAR2(256);
  BEGIN
    --包声明
    --1.包头
    vo_sql := '/*************包头*************/';
    vo_sql := vo_sql || chr(13) || 'CREATE OR REPLACE PACKAGE ' ||
              v_pkg_name || ' IS';
    --查询
    get_func_proc_init_begin_sql(p_table_name  => p_table_name,
                                 p_method      => 'QUERY',
                                 p_method_type => 0,
                                 p_pre         => '',
                                 p_is_dec      => 1,
                                 po_sql        => vo_begin_sql);
  
    vo_sql := vo_sql || chr(13) || vo_begin_sql;
  
    --查询 通过ID
    get_func_proc_init_begin_sql(p_table_name  => p_table_name,
                                 p_method      => 'QUERY',
                                 p_method_type => 1,
                                 p_pre         => '',
                                 p_is_dec      => 1,
                                 po_sql        => vo_begin_sql);
  
    vo_sql := vo_sql || chr(13) || vo_begin_sql;
  
    --新增
    get_func_proc_init_begin_sql(p_table_name  => p_table_name,
                                 p_method      => 'INSERT',
                                 p_method_type => 0,
                                 p_pre         => '',
                                 p_is_dec      => 1,
                                 po_sql        => vo_begin_sql);
  
    vo_sql := vo_sql || chr(13) || vo_begin_sql;
  
    --修改
    get_func_proc_init_begin_sql(p_table_name  => p_table_name,
                                 p_method      => 'UPDATE',
                                 p_method_type => 0,
                                 p_pre         => '',
                                 p_is_dec      => 1,
                                 po_sql        => vo_begin_sql);
  
    vo_sql := vo_sql || chr(13) || vo_begin_sql;
  
    /* --修改 通过ID
    get_func_proc_init_begin_sql(p_table_name  => p_table_name,
                                 p_method      => 'UPDATE',
                                 p_method_type => 1,
                                 p_pre         => '',
                                 p_is_dec      => 1,
                                 po_sql        => vo_begin_sql);
    
    vo_sql := vo_sql || chr(13) || vo_begin_sql;*/
  
    --删除
    get_func_proc_init_begin_sql(p_table_name  => p_table_name,
                                 p_method      => 'DELETE',
                                 p_method_type => 0,
                                 p_pre         => '',
                                 p_is_dec      => 1,
                                 po_sql        => vo_begin_sql);
  
    vo_sql := vo_sql || chr(13) || vo_begin_sql;
  
    --删除 通过ID
    get_func_proc_init_begin_sql(p_table_name  => p_table_name,
                                 p_method      => 'DELETE',
                                 p_method_type => 1,
                                 p_pre         => '',
                                 p_is_dec      => 1,
                                 po_sql        => vo_begin_sql);
  
    vo_sql := vo_sql || chr(13) || vo_begin_sql;
  
    --所有必填项校验
    FOR ck_rec IN (SELECT c.column_name,
                          c.comments,
                          (CASE
                            WHEN t.nullable = 'N' THEN
                             '1'
                            ELSE
                             '0'
                          END) requred
                     FROM user_tab_columns t
                    INNER JOIN user_col_comments c
                       ON t.table_name = c.table_name
                      AND t.column_name = c.column_name
                    WHERE t.table_name = upper(p_table_name)) LOOP
    
      v_rtn := nvl(scmdata.pkg_plat_comm.f_parse_json(get_json_str(ck_rec.comments),
                                                  p_key => 'RUN'),
                   ck_rec.requred);
      IF v_rtn = '1' THEN
        get_func_proc_init_begin_sql(p_table_name  => p_table_name,
                                     p_col_name    => ck_rec.column_name,
                                     p_method      => 'CHECK',
                                     p_method_type => 3,
                                     p_pre         => '',
                                     p_is_dec      => 1,
                                     po_sql        => vo_begin_sql);
      
        vo_sql := vo_sql || chr(13) || vo_begin_sql;
      END IF;
    END LOOP;
  
    --调用
    get_func_proc_init_begin_sql(p_table_name  => p_table_name,
                                 p_method      => 'INVOKE',
                                 p_method_type => 0,
                                 p_pre         => '',
                                 p_is_dec      => 1,
                                 po_sql        => vo_begin_sql);
  
    vo_sql := vo_sql || vo_begin_sql;
  
    vo_sql := vo_sql || chr(13) || 'END pkg_' || p_table_name || ';';
  
    --2.包体
    vo_sql := vo_sql || chr(13) || '/';
    vo_sql := vo_sql || chr(13) || '/*************包体*************/';
    vo_sql := vo_sql || chr(13) || 'CREATE OR REPLACE PACKAGE BODY ' ||
              v_pkg_name || ' IS';
  
    --查询
    get_func_proc_init_begin_sql(p_table_name  => p_table_name,
                                 p_method      => 'QUERY',
                                 p_method_type => 0,
                                 p_pre         => '',
                                 p_is_dec      => 0,
                                 po_sql        => vo_begin_sql);
  
    vo_sql := vo_sql || chr(13) || vo_begin_sql;
  
    get_iu_table_datas(p_method     => 'S',
                       p_table_name => p_table_name,
                       p_pre        => '',
                       p_suf        => '',
                       p_where_sql  => '',
                       po_sql       => vo_sql1);
  
    vo_sql := vo_sql || chr(13) || vo_sql1;
  
    get_func_proc_init_end_sql(p_table_name => p_table_name,
                               p_method     => 'QUERY',
                               p_is_dec     => 0,
                               po_sql       => vo_end_sql);
  
    vo_sql := vo_sql || chr(13) || vo_end_sql;
  
    --查询 通过ID
    get_func_proc_init_begin_sql(p_table_name  => p_table_name,
                                 p_method      => 'QUERY',
                                 p_method_type => 1,
                                 p_pre         => '',
                                 p_is_dec      => 0,
                                 po_sql        => vo_begin_sql);
  
    vo_sql := vo_sql || chr(13) || vo_begin_sql;
  
    get_iu_table_datas(p_method     => 'S_ID',
                       p_table_name => p_table_name,
                       p_pre        => '',
                       p_suf        => '',
                       p_where_sql  => '',
                       po_sql       => vo_sql1);
  
    vo_sql := vo_sql || chr(13) || vo_sql1;
  
    get_func_proc_init_end_sql(p_table_name  => p_table_name,
                               p_method      => 'QUERY',
                               p_method_type => 1,
                               p_is_dec      => 0,
                               po_sql        => vo_end_sql);
  
    vo_sql := vo_sql || chr(13) || vo_end_sql;
  
    --新增
    get_func_proc_init_begin_sql(p_table_name  => p_table_name,
                                 p_method      => 'INSERT',
                                 p_method_type => 0,
                                 p_pre         => '',
                                 p_is_dec      => 0,
                                 po_sql        => vo_begin_sql);
  
    vo_sql := vo_sql || chr(13) || vo_begin_sql;
  
    get_iu_table_datas(p_method     => 'I',
                       p_table_name => p_table_name,
                       p_pre        => 'p_' || substr(p_table_name, 0, 5) ||
                                       '_rec.',
                       p_suf        => '',
                       po_sql       => vo_sql1);
  
    vo_sql := vo_sql || chr(13) || vo_sql1;
  
    get_func_proc_init_end_sql(p_table_name  => p_table_name,
                               p_method      => 'INSERT',
                               p_method_type => 0,
                               p_is_dec      => 0,
                               po_sql        => vo_end_sql);
  
    vo_sql := vo_sql || chr(13) || vo_end_sql;
  
    --修改
    get_func_proc_init_begin_sql(p_table_name  => p_table_name,
                                 p_method      => 'UPDATE',
                                 p_method_type => 0,
                                 p_pre         => '',
                                 p_is_dec      => 0,
                                 po_sql        => vo_begin_sql);
  
    vo_sql := vo_sql || chr(13) || vo_begin_sql;
  
    get_iu_table_datas(p_method     => 'U',
                       p_table_name => p_table_name,
                       p_pre        => 'p_' || substr(p_table_name, 0, 5) ||
                                       '_rec.',
                       p_suf        => '',
                       po_sql       => vo_sql1);
  
    vo_sql := vo_sql || chr(13) || vo_sql1;
  
    get_func_proc_init_end_sql(p_table_name  => p_table_name,
                               p_method      => 'UPDATE',
                               p_method_type => 0,
                               p_is_dec      => 0,
                               po_sql        => vo_end_sql);
  
    vo_sql := vo_sql || chr(13) || vo_end_sql;
  
    --修改 通过ID
    /*get_func_proc_init_begin_sql(p_table_name  => p_table_name,
                                 p_method      => 'UPDATE',
                                 p_method_type => 1,
                                 p_pre         => '',
                                 p_is_dec      => 0,
                                 po_sql        => vo_begin_sql);
    
    vo_sql := vo_sql || chr(13) || vo_begin_sql;
    
    get_iu_table_datas(p_method     => 'U_ID',
                       p_table_name => p_table_name,
                       p_pre        => 'p_' || substr(p_table_name, 0, 5) ||
                                       '_rec.',
                       p_suf        => '',
                       po_sql       => vo_sql1);
    
    vo_sql := vo_sql || chr(13) || vo_sql1;
    
    get_func_proc_init_end_sql(p_table_name  => p_table_name,
                               p_method      => 'UPDATE',
                               p_method_type => 1,
                               p_is_dec      => 0,
                               po_sql        => vo_end_sql);
    
    vo_sql := vo_sql || chr(13) || vo_end_sql;*/
  
    --删除
    get_func_proc_init_begin_sql(p_table_name  => p_table_name,
                                 p_method      => 'DELETE',
                                 p_method_type => 0,
                                 p_pre         => '',
                                 p_is_dec      => 0,
                                 po_sql        => vo_begin_sql);
  
    vo_sql := vo_sql || chr(13) || vo_begin_sql;
  
    get_iu_table_datas(p_method     => 'D',
                       p_table_name => p_table_name,
                       p_pre        => 'p_' || substr(p_table_name, 0, 5) ||
                                       '_rec.',
                       p_suf        => '',
                       po_sql       => vo_sql1);
  
    vo_sql := vo_sql || chr(13) || vo_sql1;
  
    get_func_proc_init_end_sql(p_table_name  => p_table_name,
                               p_method      => 'DELETE',
                               p_method_type => 0,
                               p_is_dec      => 0,
                               po_sql        => vo_end_sql);
  
    vo_sql := vo_sql || chr(13) || vo_end_sql;
  
    --删除 通过ID
    get_func_proc_init_begin_sql(p_table_name  => p_table_name,
                                 p_method      => 'DELETE',
                                 p_method_type => 1,
                                 p_pre         => '',
                                 p_is_dec      => 0,
                                 po_sql        => vo_begin_sql);
  
    vo_sql := vo_sql || chr(13) || vo_begin_sql;
  
    get_iu_table_datas(p_method     => 'D_ID',
                       p_table_name => p_table_name,
                       p_pre        => 'p_' || substr(p_table_name, 0, 5) ||
                                       '_rec.',
                       p_suf        => '',
                       po_sql       => vo_sql1);
  
    vo_sql := vo_sql || chr(13) || vo_sql1;
  
    get_func_proc_init_end_sql(p_table_name  => p_table_name,
                               p_method      => 'DELETE',
                               p_method_type => 1,
                               p_is_dec      => 0,
                               po_sql        => vo_end_sql);
  
    vo_sql := vo_sql || chr(13) || vo_end_sql;
  
    --所有必填项校验
    FOR ck_rec IN (SELECT c.column_name,
                          c.comments,
                          (CASE
                            WHEN t.nullable = 'N' THEN
                             '1'
                            ELSE
                             '0'
                          END) requred
                     FROM user_tab_columns t
                    INNER JOIN user_col_comments c
                       ON t.table_name = c.table_name
                      AND t.column_name = c.column_name
                    WHERE t.table_name = upper(p_table_name)) LOOP
    
      v_rtn := nvl(scmdata.pkg_plat_comm.f_parse_json(get_json_str(ck_rec.comments),
                                                  p_key => 'RUN'),
                   ck_rec.requred); --为空默认为run
    
      IF v_rtn = '1' THEN
        get_func_proc_init_begin_sql(p_table_name  => p_table_name,
                                     p_col_name    => ck_rec.column_name,
                                     p_method      => 'CHECK',
                                     p_method_type => 3,
                                     p_pre         => '',
                                     p_is_dec      => 0,
                                     po_sql        => vo_begin_sql);
      
        vo_sql := vo_sql || chr(13) || vo_begin_sql;
      
        get_iu_table_datas(p_method     => 'CK',
                           p_table_name => p_table_name,
                           p_col_name   => ck_rec.column_name,
                           p_pre        => '',
                           p_suf        => '',
                           po_sql       => vo_sql1);
      
        vo_sql := vo_sql || chr(13) || vo_sql1;
      
        get_func_proc_init_end_sql(p_table_name  => p_table_name,
                                   p_col_name    => ck_rec.column_name,
                                   p_method      => 'CHECK',
                                   p_method_type => 3,
                                   p_is_dec      => 0,
                                   po_sql        => vo_end_sql);
      
        vo_sql := vo_sql || chr(13) || vo_end_sql;
      
        get_func_proc_init_begin_sql(p_table_name  => p_table_name,
                                     p_col_name    => ck_rec.column_name,
                                     p_method      => 'CALL_CHECK',
                                     p_method_type => 3,
                                     p_pre         => '',
                                     p_is_dec      => 0,
                                     po_sql        => vo_begin_sql);
        vo_call_sql := vo_call_sql || vo_begin_sql;
      END IF;
    END LOOP;
  
    --调用
    get_func_proc_init_begin_sql(p_table_name  => p_table_name,
                                 p_method      => 'INVOKE',
                                 p_method_type => 0,
                                 p_pre         => '',
                                 p_is_dec      => 0,
                                 po_sql        => vo_begin_sql);
  
    vo_sql := vo_sql || vo_begin_sql;
    vo_sql := vo_sql || nvl(vo_call_sql, ' NULL;');
  
    get_func_proc_init_end_sql(p_table_name  => p_table_name,
                               p_method      => 'INVOKE',
                               p_method_type => 0,
                               p_is_dec      => 0,
                               po_sql        => vo_end_sql);
    vo_sql := vo_sql || vo_end_sql;
  
    vo_sql := vo_sql || chr(13) || 'END pkg_' || p_table_name || ';';
    vo_sql := vo_sql || chr(13) || '/';
    dbms_output.put_line(upper(vo_sql));
    po_sql := upper(vo_sql);
  END get_init_pkg;

  --初始化item_list增删改查
  PROCEDURE get_init_item_list_crud(p_pkg_name   VARCHAR2,
                                    p_table_name VARCHAR2,
                                    p_moudle_pre VARCHAR2 DEFAULT NULL,
                                    p_user       VARCHAR2 DEFAULT 'admin',
                                    p_is_restful INT DEFAULT 0,
                                    p_ass_id     VARCHAR2 DEFAULT NULL,
                                    po_sql       OUT CLOB) IS
    vo_select_sql CLOB;
    vo_insert_sql CLOB;
    vo_update_sql CLOB;
    vo_delete_sql CLOB;
    vo_sql        CLOB;
    v_pk_id       VARCHAR2(256);
    v_ass_id      VARCHAR2(2000);
  BEGIN
    IF p_ass_id IS NULL THEN
      SELECT MAX(a.column_name)
        INTO v_pk_id
        FROM user_cons_columns a
       INNER JOIN user_constraints b
          ON b.constraint_name = a.constraint_name
         AND b.constraint_type = 'P'
       WHERE a.table_name = upper(p_table_name);
      v_ass_id := '%' || v_pk_id || '%';
    ELSE
      v_ass_id := p_ass_id;
    END IF;
    --查询
    get_init_item_list_crud(p_pkg_name      => p_pkg_name,
                            p_table_name    => p_table_name,
                            p_moudle_pre    => p_moudle_pre,
                            p_method_name   => 'f_query_' || p_table_name,
                            p_is_restful    => p_is_restful,
                            p_is_get_params => 0,
                            p_ass_id        => v_ass_id,
                            p_rest_method   => 'GET',
                            po_sql          => vo_select_sql);
    vo_select_sql := '--select sql ' || 'by ' || p_user || ' ' ||
                     to_char(SYSDATE, 'yyyy-mm-dd hh:mi:ss') || chr(10) ||
                     vo_select_sql || chr(10);
    --新增
    get_init_item_list_crud(p_pkg_name    => p_pkg_name,
                            p_table_name  => p_table_name,
                            p_moudle_pre  => p_moudle_pre,
                            p_method_name => 'p_insert_' || p_table_name,
                            p_is_restful  => p_is_restful,
                            p_ass_id      => v_ass_id,
                            p_rest_method => 'POST',
                            po_sql        => vo_insert_sql);
    vo_insert_sql := '--insert sql ' || 'by ' || p_user || ' ' ||
                     to_char(SYSDATE, 'yyyy-mm-dd hh:mi:ss') || chr(10) ||
                     vo_insert_sql || chr(10);
    --修改
    get_init_item_list_crud(p_pkg_name    => p_pkg_name,
                            p_table_name  => p_table_name,
                            p_moudle_pre  => p_moudle_pre,
                            p_method_name => 'p_update_' || p_table_name,
                            p_is_restful  => p_is_restful,
                            p_ass_id      => v_ass_id,
                            p_rest_method => 'PUT',
                            po_sql        => vo_update_sql);
    vo_update_sql := '--update sql ' || 'by ' || p_user || ' ' ||
                     to_char(SYSDATE, 'yyyy-mm-dd hh:mi:ss') || chr(10) ||
                     vo_update_sql || chr(10);
    --删除
    get_init_item_list_crud(p_pkg_name    => p_pkg_name,
                            p_table_name  => p_table_name,
                            p_moudle_pre  => p_moudle_pre,
                            p_method_name => 'p_delete_' || p_table_name,
                            p_is_restful  => p_is_restful,
                            p_ass_id      => v_ass_id,
                            p_rest_method => 'DELETE',
                            po_sql        => vo_delete_sql);
  
    vo_delete_sql := '--delete sql ' || 'by ' || p_user || ' ' ||
                     to_char(SYSDATE, 'yyyy-mm-dd hh:mi:ss') || chr(10) ||
                     vo_delete_sql || chr(10);
    vo_sql        := vo_select_sql || vo_insert_sql || vo_update_sql ||
                     vo_delete_sql;
    po_sql        := vo_sql;
    --dbms_output.put_line(vo_sql);
  
  END get_init_item_list_crud;

  --生成item_list增删改查 sql
  PROCEDURE get_init_item_list_crud(p_pkg_name      VARCHAR2,
                                    p_table_name    VARCHAR2 DEFAULT NULL,
                                    p_method_name   VARCHAR2,
                                    p_moudle_pre    VARCHAR2 DEFAULT NULL,
                                    p_is_restful    INT DEFAULT 0,
                                    p_is_get_params INT DEFAULT 1,
                                    p_ass_id        VARCHAR2 DEFAULT NULL,
                                    p_rest_method   VARCHAR2 DEFAULT NULL,
                                    po_sql          OUT CLOB) IS
    v_sql         CLOB;
    v_rest_sql_0  CLOB;
    v_rest_sql_1  CLOB;
    v_rest_sql_2  CLOB;
    v_rest_sql_3  CLOB;
    v_rest_sql_4  CLOB;
    vo_sql        CLOB;
    vo_params_sql CLOB;
    vo_params     CLOB;
  BEGIN
    --获取方法参数
    pf_get_arguments(p_pkg_name   => p_pkg_name,
                     p_obj_name   => p_method_name,
                     p_table_name => p_table_name,
                     p_is_print   => 0,
                     po_sql       => vo_sql,
                     po_params    => vo_params);
    --参数赋值                
    IF p_is_get_params = 1 THEN
      get_iu_table_datas(p_method     => 'FZ',
                         p_table_name => p_table_name,
                         p_fpre       => 'v_' || substr(p_table_name, 0, 5) ||
                                         '_rec' || '.',
                         p_pre        => p_moudle_pre,
                         p_suf        => '',
                         p_is_impl    => CASE
                                           WHEN p_rest_method = 'POST' THEN
                                            1
                                           ELSE
                                            0
                                         END,
                         po_sql       => vo_params_sql);
    END IF;
  
    v_rest_sql_0 := q'[
DECLARE ]' || (CASE
                      WHEN p_is_restful = 0 THEN
                       NULL
                      ELSE
                       q'[
  v_pk_id       VARCHAR2(32);
  v_rest_method VARCHAR2(256);
  v_params      VARCHAR2(256);]'
                    END) || q'[
  v_sql         CLOB;
]' || (CASE
                      WHEN p_rest_method = 'GET' THEN
                       vo_params
                      ELSE
                       NULL
                    END) || q'[
BEGIN]';
    v_rest_sql_1 := (CASE
                      WHEN p_is_restful = 0 THEN
                       NULL
                      ELSE
                       q'[
  --获取asscoiate请求参数
  pkg_plat_comm.p_get_rest_val_method_params(p_character     => ]' ||
                       p_ass_id || q'[,
                                             po_pk_id        => v_pk_id,
                                             po_rest_methods => v_rest_method,
                                             po_params       => v_params);

  IF instr(';' || v_rest_method || ';', ';' || ']' ||
                       p_rest_method || q'[' || ';') > 0 THEN
    ]'
                    END);
  
    v_rest_sql_2 := (CASE
                      WHEN p_is_restful = 0 THEN
                       NULL
                      ELSE
                       q'[ 
  ELSE
    v_sql :=  NULL; 
  END IF;]'
                    END);
  
    v_rest_sql_3 := chr(10) || '--' || (CASE
                                          WHEN p_rest_method = 'GET' THEN
                                           '查询 '
                                          WHEN p_rest_method = 'POST' THEN
                                           '新增 '
                                          WHEN p_rest_method = 'PUT' THEN
                                           '修改 '
                                          WHEN p_rest_method = 'DELETE' THEN
                                           '删除 '
                                        END) || p_table_name;
  
    v_rest_sql_4 := q'[
  @strresult := v_sql;
END;]';
  
    --组合sql
    IF p_rest_method = 'GET' THEN
      v_sql := v_rest_sql_0 || v_rest_sql_1 || v_rest_sql_3 ||
               q'[          
    v_sql := ]' || vo_sql || v_rest_sql_2 || v_rest_sql_4;
    
    ELSE
      v_sql := v_rest_sql_0 || v_rest_sql_1 || q'^          
    v_sql := q'[
DECLARE 
^' || vo_params || q'^
BEGIN
      ^' || vo_params_sql || chr(10) || v_rest_sql_3 ||
               chr(10) || vo_sql || q'^
END;
]';
    ^' || v_rest_sql_2 || v_rest_sql_4;
    END IF;
  
    dbms_output.put_line('{' || chr(10) || v_sql || chr(10) || '}');
    po_sql := '{' || v_sql || chr(10) || '}';
  END get_init_item_list_crud;

  --初始化所有基础sql
  PROCEDURE get_init_all_base_sql(p_table_name           VARCHAR2,
                                  p_moudle_pre           VARCHAR2 DEFAULT NULL,
                                  p_is_config_field_list INT DEFAULT 0,
                                  po_sql                 OUT CLOB) IS
    vo_sql    CLOB;
    v_pkg_sql CLOB;
    v_fd_sql  CLOB;
  BEGIN
    --1.filed_list 表-映射字段
    IF p_is_config_field_list = 0 THEN
      get_field_list_init_sql_no_tbconfig(p_table_name => p_table_name,
                                          p_md_pre     => p_moudle_pre,
                                          po_sql       => v_fd_sql);
    ELSE
      get_field_list_init_sql(p_table_name => p_table_name,
                              p_md_pre     => p_moudle_pre,
                              po_sql       => v_fd_sql);
    END IF;
    --2.初始化包
    get_init_pkg(p_table_name => p_table_name, po_sql => v_pkg_sql);
  
    --3.item_list dml——sql
    vo_sql := '--1.初始化filed_list 映射字段' || chr(13) || v_fd_sql || chr(13) ||
              '--2.初始化包' || chr(13) || v_pkg_sql;
  
    po_sql := vo_sql;
  END get_init_all_base_sql;

  --生成update
  FUNCTION my_concat(tablename VARCHAR2, TYPE VARCHAR2, where_sql VARCHAR2)
    RETURN VARCHAR2 IS
    TYPE typ_cursor IS REF CURSOR;
    v_cursor typ_cursor;
    v_temp   VARCHAR2(30);
    v_result VARCHAR2(4000) := '';
    v_sql    VARCHAR2(200);
  BEGIN
    v_sql := 'select COLUMN_NAME from user_tab_columns where table_name = ''' ||
             upper(tablename) || ''' order by COLUMN_ID asc';
    OPEN v_cursor FOR v_sql;
    LOOP
      FETCH v_cursor
        INTO v_temp;
      EXIT WHEN v_cursor%NOTFOUND;
      IF TYPE = 'select' OR TYPE = 'insert' THEN
        v_result := v_result || ',' || v_temp;
      ELSIF TYPE = 'update' THEN
        v_result := v_result || ',' || v_temp || ' = ?';
      ELSIF TYPE = 'javabean' THEN
        v_result := v_result || ',bean.get' || upper(substr(v_temp, 1, 1)) ||
                    lower(substr(v_temp, 2)) || '()';
      END IF;
    END LOOP;
    v_result := v_result || ' ' || where_sql;
    RETURN substr(v_result, 2);
  END;

  PROCEDURE autogeneratesql(tablename  VARCHAR2,
                            TYPE       VARCHAR2,
                            out_result OUT VARCHAR2,
                            where_sql  IN VARCHAR2) IS
    sql_insert   VARCHAR2(2000);
    sql_update   VARCHAR2(2000);
    sql_select   VARCHAR2(2000);
    javabean_str VARCHAR2(2000);
    field_num    INTEGER; --字段个数  
    type_info    VARCHAR2(20); --参数类型判断信息  
  BEGIN
  
    sql_insert   := 'insert into ' || upper(tablename) || '(' ||
                    sf_get_arguments_pkg.my_concat(tablename,
                                                   TYPE,
                                                   where_sql) ||
                    ') values (';
    sql_update   := 'update ' || upper(tablename) || ' set ';
    sql_select   := 'select ';
    javabean_str := '';
    type_info    := '';
  
    SELECT COUNT(*)
      INTO field_num
      FROM user_tab_columns
     WHERE table_name = upper(tablename);
    SELECT decode(TYPE,
                  'insert',
                  TYPE,
                  'update',
                  TYPE,
                  'select',
                  TYPE,
                  'javabean',
                  TYPE,
                  'error')
      INTO type_info
      FROM dual;
  
    IF field_num = 0 THEN
      -- 表不存在时     
      out_result := '表不存在！请重新输入!';
    ELSIF type_info = 'error' THEN
      --type参数错误时  
      out_result := 'type参数错误：类型只能是insert、update、select、javabean之一';
    ELSIF field_num > 0 THEN
      IF TYPE = 'insert' THEN
        --生成insert 语句  
        FOR i IN 1 .. field_num LOOP
          sql_insert := sql_insert || '?';
          IF i < field_num THEN
            sql_insert := sql_insert || ',';
          END IF;
        END LOOP;
        sql_insert := sql_insert || ')';
        out_result := sql_insert;
      ELSIF TYPE = 'update' THEN
        --生成update 语句        
        sql_update := sql_update ||
                      sf_get_arguments_pkg.my_concat(tablename,
                                                     TYPE,
                                                     where_sql);
        out_result := sql_update;
      ELSIF TYPE = 'select' THEN
        --生成select 语句    
        sql_select := sql_select ||
                      sf_get_arguments_pkg.my_concat(tablename,
                                                     TYPE,
                                                     where_sql) || ' from ' ||
                      upper(tablename) || ' a';
        out_result := sql_select;
      ELSIF TYPE = 'javabean' THEN
        --生成javabean的get方法  
        javabean_str := sf_get_arguments_pkg.my_concat(tablename,
                                                       TYPE,
                                                       where_sql);
        out_result   := javabean_str;
      END IF;
    END IF;
  
  END autogeneratesql;

  --找出未使用绑定变量的sql
  FUNCTION remove_constants(p_query IN VARCHAR2) RETURN VARCHAR2 IS
    l_query     CLOB;
    l_char      VARCHAR2(10);
    l_in_quotes BOOLEAN DEFAULT FALSE;
  BEGIN
    FOR i IN 1 .. length(p_query) LOOP
    
      l_char := substr(p_query, i, 1);
    
      IF (l_char = '''' AND l_in_quotes) THEN
      
        l_in_quotes := FALSE;
      
      ELSIF (l_char = '''' AND NOT l_in_quotes) THEN
        l_in_quotes := TRUE;
        l_query     := l_query || '''#';
      
      END IF;
    
      IF (NOT l_in_quotes) THEN
        l_query := l_query || l_char;
      
      END IF;
    
    END LOOP;
    l_query := translate(l_query, '0123456789', '@@@@@@@@@@');
  
    FOR i IN 0 .. 8 LOOP
      l_query := REPLACE(l_query, lpad('@', 10 - i, '@'), '@');
      l_query := REPLACE(l_query, lpad(' ', 10 - i, ' '), ' ');
    END LOOP;
    RETURN upper(l_query);
  
  END remove_constants;

  /*============================================*
  * Author   : SANFU
  * Created  : 2020-08-25 15:25:46
  * ALERTER  : 
  * ALERTER_TIME  : 
  * Purpose  : 分割
  * Obj_Name    : GET_STRARRAYLENGTH
  * Arg_Number  : 2
  * AV_STR : 要分割的字符串
  * AV_SPLIT :分隔符号
  *============================================*/

  FUNCTION get_strarraylength(av_str   VARCHAR2, --要分割的字符串
                              av_split VARCHAR2 --分隔符号
                              ) RETURN NUMBER IS
    lv_str    VARCHAR2(1000);
    lv_length NUMBER;
  BEGIN
    lv_str    := ltrim(rtrim(av_str));
    lv_length := 0;
    WHILE instr(lv_str, av_split) <> 0 LOOP
      lv_length := lv_length + 1;
      lv_str    := substr(lv_str,
                          instr(lv_str, av_split) + length(av_split),
                          length(lv_str));
    END LOOP;
    lv_length := lv_length + 1;
    RETURN lv_length;
  END get_strarraylength;

  /*============================================*
  * Author   : SANFU
  * Created  : 2020-08-25 15:38:52
  * ALERTER  : 
  * ALERTER_TIME  : 
  * Purpose  : 提取
  * Obj_Name    : GET_STRARRAYSTROFINDEX
  * Arg_Number  : 3
  * AV_STR :要分割的字符串
  * AV_SPLIT :分隔符号
  * AV_INDEX :取第几个元素
  *============================================*/

  FUNCTION get_strarraystrofindex(av_str   VARCHAR2, --要分割的字符串
                                  av_split VARCHAR2, --分隔符号
                                  av_index NUMBER --取第几个元素
                                  ) RETURN VARCHAR2 IS
    lv_str        VARCHAR2(1024);
    lv_strofindex VARCHAR2(1024);
    lv_length     NUMBER;
  BEGIN
    lv_str    := ltrim(rtrim(av_str));
    lv_str    := concat(lv_str, av_split);
    lv_length := av_index;
    IF lv_length = 0 THEN
      lv_strofindex := substr(lv_str,
                              1,
                              instr(lv_str, av_split) - length(av_split));
    ELSE
      lv_length     := av_index + 1;
      lv_strofindex := substr(lv_str,
                              instr(lv_str, av_split, 1, av_index) +
                              length(av_split),
                              instr(lv_str, av_split, 1, lv_length) -
                              instr(lv_str, av_split, 1, av_index) -
                              length(av_split));
    END IF;
    RETURN lv_strofindex;
  END get_strarraystrofindex;

  /*============================================*
  * Author   : SANFU
  * Created  : 2020-08-25 17:34:59
  * ALERTER  : 
  * ALERTER_TIME  : 
  * Purpose  :  获取字符数组
  * Obj_Name    : GET_STRARRAY
  * Arg_Number  : 2
  * AV_STR : 要分割的字符串
  * AV_SPLIT : 分隔符号
  *============================================*/

  /*FUNCTION get_strarray(av_str   VARCHAR2, --要分割的字符串
                        av_split VARCHAR2 --分隔符号
                        ) RETURN role_name_tb_type IS
  
    v_av_str   VARCHAR2(4000) := av_str; --要切割的字符串
    v_av_split VARCHAR2(100) := av_split; --分割符
    v_length   NUMBER;
    --TYPE role_name_tb_type is table of varchar2(128);
    role_name_tb role_name_tb_type := role_name_tb_type();
  
  BEGIN
    v_length := get_strarraylength(v_av_str, v_av_split);
  
    FOR i IN 0 ..(v_length - 1) LOOP
      --扩展数组
      role_name_tb.extend;
      SELECT get_strarraystrofindex(v_av_str, v_av_split, i)
        INTO role_name_tb(role_name_tb.count)
        FROM dual;
    
    END LOOP;
    \*    for i in 0 .. (v_length - 1) loop
      dbms_output.put_line(role_name_tb(i));
    
    end loop;*\
    RETURN role_name_tb;
  END get_strarray;*/

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

END sf_get_arguments_pkg;
/

