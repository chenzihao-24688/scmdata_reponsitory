CREATE OR REPLACE PACKAGE SCMDATA.pkg_zc_code_helper IS

  -- Author  : zc314
  -- Created : 2023-04-26 20:20:16
  -- Purpose : generate update or delete sql detail info
  -- Version Change : [2023-04-27 11:16:27] can use on delete
  FUNCTION f_tabapi_get_update_or_delete_info
  (
    v_inp_column_names       IN CLOB,
    v_inp_fields_separator   IN VARCHAR2,
    v_inp_sentence_separator IN VARCHAR2
  ) RETURN CLOB;

  -- Author  : zc314
  -- Created : 2023-04-26 20:20:21
  -- Purpose : generate update sql
  FUNCTION f_tabapi_gen_update_sql
  (
    v_inp_owner         IN VARCHAR2,
    v_inp_tablename     IN VARCHAR2,
    v_inp_update_fields IN CLOB,
    v_inp_update_unique IN CLOB
  ) RETURN CLOB;

  -- Author  : zc314
  -- Created : 2023-04-26 20:20:21
  -- Purpose : generate insert sql
  FUNCTION f_tabapi_gen_insert_sql
  (
    v_inp_owner         IN VARCHAR2,
    v_inp_tablename     IN VARCHAR2,
    v_inp_insert_fields IN CLOB
  ) RETURN CLOB;

  -- Author  : zc314
  -- Created : 2023-04-27 11:23:35
  -- Purpose : generate delete sql
  FUNCTION f_tabapi_gen_delete_sql
  (
    v_inp_owner         IN VARCHAR2,
    v_inp_tablename     IN VARCHAR2,
    v_inp_unique_fields IN CLOB
  ) RETURN CLOB;

  -- Author  : zc314
  -- Created : 2023-04-26 20:54:47
  -- Purpose : generate input param
  FUNCTION f_tabapi_gen_input_param
  (
    v_inp_owner            IN VARCHAR2,
    v_inp_tablename        IN VARCHAR2,
    v_inp_fields           IN CLOB,
    v_inp_fields_separator IN VARCHAR2
  ) RETURN CLOB;

  -- Author  : zc314
  -- Created : 2023-04-27 09:33:45
  -- Purpose : generate zcstyle execute param
  FUNCTION f_tabapi_gen_zcstyle_execute_param(v_inp_insert_fields IN CLOB)
    RETURN CLOB;

  -- Author  : zc314
  -- Created : 2023-04-27 09:44:06
  -- Purpose : generate zcstyle insertsql exception sentence
  FUNCTION f_tabapi_gen_zcstyle_exception_sentence(v_inp_insert_fields IN CLOB)
    RETURN CLOB;

  -- Author  : zc314
  -- Created : 2023-04-27 09:54:47
  -- Purpose : generate zcstyle insert sql
  FUNCTION f_tabapi_gen_zcstyle_insert_sql
  (
    v_inp_procedure_name IN VARCHAR2,
    v_inp_owner          IN VARCHAR2,
    v_inp_tablename      IN VARCHAR2,
    v_inp_insert_fields  IN CLOB
  ) RETURN CLOB;

  -- Author  : zc314
  -- Created : 2023-04-27 11:02:42
  -- Purpose : generate zcstyle update sql
  FUNCTION f_tabapi_gen_zcstyle_update_sql
  (
    v_inp_procedure_name IN VARCHAR2,
    v_inp_owner          IN VARCHAR2,
    v_inp_tablename      IN VARCHAR2,
    v_inp_update_fields  IN CLOB,
    v_inp_update_unique  IN CLOB
  ) RETURN CLOB;

  -- Author  : zc314
  -- Created : 2023-04-27 11:02:42
  -- Purpose : generate zcstyle delete sql
  FUNCTION f_tabapi_gen_zcstyle_delete_sql
  (
    v_inp_procedure_name IN VARCHAR2,
    v_inp_owner          IN VARCHAR2,
    v_inp_tablename      IN VARCHAR2,
    v_inp_delete_unique  IN CLOB
  ) RETURN CLOB;

  -- Author  : zc314
  -- Created : 2023-04-27 13:54:59
  -- Purpose : generate zcstyle delete sql
  FUNCTION f_tabapi_gen_isexists_function
  (
    v_inp_procedure_name IN VARCHAR2,
    v_inp_owner          IN VARCHAR2,
    v_inp_tablename      IN VARCHAR2,
    v_inp_select_unique  IN CLOB
  ) RETURN CLOB;

END pkg_zc_code_helper;
/

CREATE OR REPLACE PACKAGE BODY SCMDATA.pkg_zc_code_helper IS

  -- Author  : zc314
  -- Created : 2023-04-26 20:20:16
  -- Purpose : generate update or delete sql detail info
  -- Version Change : [2023-04-27 11:16:27] can use on delete
  FUNCTION f_tabapi_get_update_or_delete_info
  (
    v_inp_column_names       IN CLOB,
    v_inp_fields_separator   IN VARCHAR2,
    v_inp_sentence_separator IN VARCHAR2
  ) RETURN CLOB IS
    v_retinfo CLOB;
  BEGIN
    FOR i IN (SELECT regexp_substr(v_inp_column_names,
                                   '[^' || v_inp_fields_separator || ']+',
                                   1,
                                   LEVEL) VALUE
                FROM dual
              CONNECT BY LEVEL <=
                         regexp_count(v_inp_column_names,
                                      '[^' || v_inp_fields_separator || ']+')) LOOP
      v_retinfo := scmdata.f_sentence_append_rc(v_sentence   => v_retinfo,
                                                v_appendstr  => to_char(i.value) ||
                                                                ' = :v_inp_' ||
                                                                to_char(i.value),
                                                v_middliestr => v_inp_sentence_separator || ' ');
    END LOOP;
  
    RETURN v_retinfo;
  END f_tabapi_get_update_or_delete_info;

  -- Author  : zc314
  -- Created : 2023-04-26 20:20:21
  -- Purpose : generate update sql
  FUNCTION f_tabapi_gen_update_sql
  (
    v_inp_owner         IN VARCHAR2,
    v_inp_tablename     IN VARCHAR2,
    v_inp_update_fields IN CLOB,
    v_inp_update_unique IN CLOB
  ) RETURN CLOB IS
    v_fields CLOB;
    v_conds  CLOB;
    v_sql    CLOB;
  BEGIN
    v_fields := f_tabapi_get_update_or_delete_info(v_inp_column_names       => v_inp_update_fields,
                                                   v_inp_fields_separator   => ',',
                                                   v_inp_sentence_separator => ',');
  
    v_conds := f_tabapi_get_update_or_delete_info(v_inp_column_names       => v_inp_update_unique,
                                                  v_inp_fields_separator   => ',',
                                                  v_inp_sentence_separator => ' and');
  
    v_sql := 'update ' || v_inp_owner || '.' || v_inp_tablename || ' set ' ||
             v_fields || ' where ' || v_conds;
  
    RETURN v_sql;
  END f_tabapi_gen_update_sql;

  -- Author  : zc314
  -- Created : 2023-04-26 20:20:21
  -- Purpose : generate insert sql
  FUNCTION f_tabapi_gen_insert_sql
  (
    v_inp_owner         IN VARCHAR2,
    v_inp_tablename     IN VARCHAR2,
    v_inp_insert_fields IN CLOB
  ) RETURN CLOB IS
    v_sql CLOB;
  BEGIN
    v_sql := 'insert into ' || v_inp_owner || '.' || v_inp_tablename || '(' ||
             v_inp_insert_fields || ') values (:v_inp_' ||
             REPLACE(v_inp_insert_fields, ',', ',:v_inp_') || ')';
  
    RETURN v_sql;
  END f_tabapi_gen_insert_sql;

  -- Author  : zc314
  -- Created : 2023-04-27 11:23:35
  -- Purpose : generate delete sql
  FUNCTION f_tabapi_gen_delete_sql
  (
    v_inp_owner         IN VARCHAR2,
    v_inp_tablename     IN VARCHAR2,
    v_inp_unique_fields IN CLOB
  ) RETURN CLOB IS
    v_conds CLOB;
    v_sql   CLOB;
  BEGIN
    v_conds := f_tabapi_get_update_or_delete_info(v_inp_column_names       => v_inp_unique_fields,
                                                  v_inp_fields_separator   => ',',
                                                  v_inp_sentence_separator => ' and');
  
    v_sql := 'delete from ' || v_inp_owner || '.' || v_inp_tablename ||
             ' where ' || v_conds;
  
    RETURN v_sql;
  END f_tabapi_gen_delete_sql;

  -- Author  : zc314
  -- Created : 2023-04-26 20:54:47
  -- Purpose : generate input param
  FUNCTION f_tabapi_gen_input_param
  (
    v_inp_owner            IN VARCHAR2,
    v_inp_tablename        IN VARCHAR2,
    v_inp_fields           IN CLOB,
    v_inp_fields_separator IN VARCHAR2
  ) RETURN CLOB IS
    v_ret_info CLOB;
  BEGIN
    FOR i IN (SELECT regexp_substr(v_inp_fields,
                                   '[^' || v_inp_fields_separator || ']+',
                                   1,
                                   LEVEL) VALUE
                FROM dual
              CONNECT BY LEVEL <=
                         regexp_count(v_inp_fields,
                                      '[^' || v_inp_fields_separator || ']+')) LOOP
      v_ret_info := scmdata.f_sentence_append_rc(v_sentence   => v_ret_info,
                                                 v_appendstr  => 'v_inp_' ||
                                                                 to_char(i.value) ||
                                                                 ' in ' ||
                                                                 v_inp_owner || '.' ||
                                                                 v_inp_tablename || '.' ||
                                                                 to_char(i.value) ||
                                                                 '%TYPE DEFAULT NULL',
                                                 v_middliestr => ',' ||
                                                                 chr(10));
    END LOOP;
    RETURN v_ret_info;
  END f_tabapi_gen_input_param;

  -- Author  : zc314
  -- Created : 2023-04-27 09:33:45
  -- Purpose : generate zcstyle execute param
  FUNCTION f_tabapi_gen_zcstyle_execute_param(v_inp_insert_fields IN CLOB)
    RETURN CLOB IS
    v_return_info CLOB;
  BEGIN
    FOR i IN (SELECT regexp_substr(v_inp_insert_fields, '[^,]+', 1, LEVEL) VALUE
                FROM dual
              CONNECT BY LEVEL <= regexp_count(v_inp_insert_fields, '[^,]+')) LOOP
      v_return_info := scmdata.f_sentence_append_rc(v_sentence   => v_return_info,
                                                    v_appendstr  => 'v_inp_' ||
                                                                    to_char(i.value),
                                                    v_middliestr => ',');
    END LOOP;
  
    RETURN v_return_info;
  END f_tabapi_gen_zcstyle_execute_param;

  -- Author  : zc314
  -- Created : 2023-04-27 09:44:06
  -- Purpose : generate zcstyle insertsql exception sentence
  FUNCTION f_tabapi_gen_zcstyle_exception_sentence(v_inp_insert_fields IN CLOB)
    RETURN CLOB IS
    v_return_info CLOB;
  BEGIN
    FOR i IN (SELECT regexp_substr(v_inp_insert_fields, '[^,]+', 1, LEVEL) VALUE
                FROM dual
              CONNECT BY LEVEL <= regexp_count(v_inp_insert_fields, '[^,]+')) LOOP
      v_return_info := scmdata.f_sentence_append_rc(v_sentence   => v_return_info,
                                                    v_appendstr  => '''v_inp_' ||
                                                                    to_char(i.value) ||
                                                                    ': '' || v_inp_' ||
                                                                    to_char(i.value),
                                                    v_middliestr => ' || chr(10) || ');
    END LOOP;
  
    RETURN v_return_info;
  END f_tabapi_gen_zcstyle_exception_sentence;

  -- Author  : zc314
  -- Created : 2023-04-27 09:54:47
  -- Purpose : generate zcstyle insert sql
  FUNCTION f_tabapi_gen_zcstyle_insert_sql
  (
    v_inp_procedure_name IN VARCHAR2,
    v_inp_owner          IN VARCHAR2,
    v_inp_tablename      IN VARCHAR2,
    v_inp_insert_fields  IN CLOB
  ) RETURN CLOB IS
    v_declaration        CLOB;
    v_procedure_params   CLOB;
    v_declaration_params CLOB;
    v_sql                CLOB;
    v_execute_sentence   CLOB;
    v_exception_sentence CLOB;
  BEGIN
    --generate declaration part
    v_declaration := 'procedure ' || v_inp_procedure_name || ' (' ||
                     chr(10);
  
    --generate procedure params part
    v_procedure_params := f_tabapi_gen_input_param(v_inp_owner            => v_inp_owner,
                                                   v_inp_tablename        => v_inp_tablename,
                                                   v_inp_fields           => v_inp_insert_fields,
                                                   v_inp_fields_separator => ',') ||
                          ', v_inp_invoke_object       IN VARCHAR2';
  
    --generate declaration params part
    v_declaration_params := ') IS
    priv_exception        EXCEPTION;
    v_sql                 CLOB;
    v_error_info          CLOB;
    v_sql_errm            VARCHAR2(512);
    v_allow_invoke_object CLOB := '''';
    v_self_description    VARCHAR2(1024) := '''';
  BEGIN
    --访问控制
    IF instr(v_allow_invoke_object, v_inp_invoke_object) = 0 THEN
      v_sql_errm := ''拒绝访问：调用方-'' || v_inp_invoke_object || '' 被调用方-'' ||
                    v_self_description;
      RAISE priv_exception;
    END IF;
  
    --执行 Sql 赋值
    v_sql := ''';
  
    --generate sql part
    v_sql := f_tabapi_gen_insert_sql(v_inp_owner         => v_inp_owner,
                                     v_inp_tablename     => v_inp_tablename,
                                     v_inp_insert_fields => v_inp_insert_fields) ||
             ''';' || chr(10);
  
    --generate zcstyle insertsql execute param
    v_execute_sentence := '--执行 Sql
    execute immediate v_sql using ' ||
                          f_tabapi_gen_zcstyle_execute_param(v_inp_insert_fields => v_inp_insert_fields) || '; ' ||
                          chr(10);
  
    --generate exception sentence
    v_exception_sentence := 'EXCEPTION
    WHEN priv_exception THEN
      --抛出报错
      raise_application_error(-20002, v_sql_errm);
    WHEN OTHERS THEN
      --错误信息赋值
      v_sql_errm   := substr(dbms_utility.format_error_stack, 1, 512);
      v_error_info := ''Error Object:'' || v_self_description || chr(10) ||
                      ''Error Info: '' || v_sql_errm || chr(10) ||
                      ''Execute sql: '' || v_sql || chr(10) || ''Params: '' ||
                      chr(10) || ' ||
                            f_tabapi_gen_zcstyle_exception_sentence(v_inp_insert_fields => v_inp_insert_fields) || '; 
                            
      --新增进入错误信息表
      scmdata.pkg_qa_ee.p_ins_errrecord_at(v_inp_errprogram     => v_self_description,
                                           v_inp_causeerruserid => v_inp_create_id,
                                           v_inp_erroccurtime   => SYSDATE,
                                           v_inp_errinfo        => v_error_info,
                                           v_inp_compid         => v_inp_company_id);
    
      --抛出报错
      raise_application_error(-20002, v_sql_errm);
    END ' || v_inp_procedure_name || ';';
  
    RETURN v_declaration || v_procedure_params || v_declaration_params || v_sql || v_execute_sentence || v_exception_sentence;
  END f_tabapi_gen_zcstyle_insert_sql;

  -- Author  : zc314
  -- Created : 2023-04-27 11:02:42
  -- Purpose : generate zcstyle update sql
  FUNCTION f_tabapi_gen_zcstyle_update_sql
  (
    v_inp_procedure_name IN VARCHAR2,
    v_inp_owner          IN VARCHAR2,
    v_inp_tablename      IN VARCHAR2,
    v_inp_update_fields  IN CLOB,
    v_inp_update_unique  IN CLOB
  ) RETURN CLOB IS
    v_declaration        CLOB;
    v_procedure_params   CLOB;
    v_declaration_params CLOB;
    v_sql                CLOB;
    v_execute_sentence   CLOB;
    v_exception_sentence CLOB;
  BEGIN
    --generate declaration part
    v_declaration := 'procedure ' || v_inp_procedure_name || ' (' ||
                     chr(10);
  
    --generate procedure params part
    v_procedure_params := f_tabapi_gen_input_param(v_inp_owner            => v_inp_owner,
                                                   v_inp_tablename        => v_inp_tablename,
                                                   v_inp_fields           => v_inp_update_unique || ',' ||
                                                                             v_inp_update_fields,
                                                   v_inp_fields_separator => ',') ||
                          ', v_inp_invoke_object       IN VARCHAR2';
  
    --generate declaration params part
    v_declaration_params := ') IS
    priv_exception        EXCEPTION;
    v_sql                 CLOB;
    v_error_info          CLOB;
    v_sql_errm            VARCHAR2(512);
    v_allow_invoke_object CLOB := '''';
    v_self_description    VARCHAR2(1024) := '''';
  BEGIN
    --访问控制
    IF instr(v_allow_invoke_object, v_inp_invoke_object) = 0 THEN
      v_sql_errm := ''拒绝访问：调用方-'' || v_inp_invoke_object || '' 被调用方-'' ||
                    v_self_description;
      RAISE priv_exception;
    END IF;
  
    --执行 Sql 赋值
    v_sql := ''';
  
    --generate sql part
    v_sql := f_tabapi_gen_update_sql(v_inp_owner         => v_inp_owner,
                                     v_inp_tablename     => v_inp_tablename,
                                     v_inp_update_fields => v_inp_update_fields,
                                     v_inp_update_unique => v_inp_update_unique) ||
             ''';' || chr(10);
  
    --generate zcstyle insertsql execute param
    v_execute_sentence := '--执行 Sql
    execute immediate v_sql using ' ||
                          f_tabapi_gen_zcstyle_execute_param(v_inp_insert_fields => v_inp_update_fields || ',' ||
                                                                                    v_inp_update_unique) || '; ' ||
                          chr(10);
  
    --generate exception sentence
    v_exception_sentence := 'EXCEPTION
    WHEN priv_exception THEN
      --抛出报错
      raise_application_error(-20002, v_sql_errm);
    WHEN OTHERS THEN
      --错误信息赋值
      v_sql_errm   := substr(dbms_utility.format_error_stack, 1, 512);
      v_error_info := ''Error Object:'' || v_self_description || chr(10) ||
                      ''Error Info: '' || v_sql_errm || chr(10) ||
                      ''Execute sql:'' || v_sql || chr(10) || ''Params: '' ||
                      chr(10) || ' ||
                            f_tabapi_gen_zcstyle_exception_sentence(v_inp_insert_fields => v_inp_update_fields || ',' ||
                                                                                           v_inp_update_unique) || '; 
                                                                                           
      --新增进入错误信息表
      scmdata.pkg_qa_ee.p_ins_errrecord_at(v_inp_errprogram     => v_self_description,
                                           v_inp_causeerruserid => v_inp_update_id,
                                           v_inp_erroccurtime   => SYSDATE,
                                           v_inp_errinfo        => v_error_info,
                                           v_inp_compid         => v_inp_company_id);
    
      --抛出报错
      raise_application_error(-20002, v_sql_errm);
    END ' || v_inp_procedure_name || ';';
  
    RETURN v_declaration || v_procedure_params || v_declaration_params || v_sql || v_execute_sentence || v_exception_sentence;
  END f_tabapi_gen_zcstyle_update_sql;

  -- Author  : zc314
  -- Created : 2023-04-27 11:02:42
  -- Purpose : generate zcstyle delete sql
  FUNCTION f_tabapi_gen_zcstyle_delete_sql
  (
    v_inp_procedure_name IN VARCHAR2,
    v_inp_owner          IN VARCHAR2,
    v_inp_tablename      IN VARCHAR2,
    v_inp_delete_unique  IN CLOB
  ) RETURN CLOB IS
    v_declaration        CLOB;
    v_procedure_params   CLOB;
    v_declaration_params CLOB;
    v_sql                CLOB;
    v_execute_sentence   CLOB;
    v_exception_sentence CLOB;
  BEGIN
    --generate declaration part
    v_declaration := 'procedure ' || v_inp_procedure_name || ' (' ||
                     chr(10);
  
    --generate procedure params part
    v_procedure_params := f_tabapi_gen_input_param(v_inp_owner            => v_inp_owner,
                                                   v_inp_tablename        => v_inp_tablename,
                                                   v_inp_fields           => v_inp_delete_unique,
                                                   v_inp_fields_separator => ',') ||
                          ', v_inp_invoke_object       IN VARCHAR2';
  
    --generate declaration params part
    v_declaration_params := ') IS
    priv_exception        EXCEPTION;
    v_sql                 CLOB;
    v_error_info          CLOB;
    v_sql_errm            VARCHAR2(512);
    v_allow_invoke_object CLOB := '''';
    v_self_description    VARCHAR2(1024) := '''';
  BEGIN
    --访问控制
    IF instr(v_allow_invoke_object, v_inp_invoke_object) = 0 THEN
      v_sql_errm := ''拒绝访问：调用方-'' || v_inp_invoke_object || '' 被调用方-'' ||
                    v_self_description;
      RAISE priv_exception;
    END IF;
  
    --执行 Sql 赋值
    v_sql := ''';
  
    --generate sql part
    v_sql := f_tabapi_gen_delete_sql(v_inp_owner         => v_inp_owner,
                                     v_inp_tablename     => v_inp_tablename,
                                     v_inp_unique_fields => v_inp_delete_unique) ||
             ''';' || chr(10);
  
    --generate zcstyle insertsql execute param
    v_execute_sentence := '--执行 Sql
    execute immediate v_sql using ' ||
                          f_tabapi_gen_zcstyle_execute_param(v_inp_insert_fields => v_inp_delete_unique) || '; ' ||
                          chr(10);
  
    --generate exception sentence
    v_exception_sentence := 'EXCEPTION
    WHEN priv_exception THEN
      --抛出报错
      raise_application_error(-20002, v_sql_errm);
    WHEN OTHERS THEN
      --错误信息赋值
      v_sql_errm   := substr(dbms_utility.format_error_stack, 1, 512);
      v_error_info := ''Error Object:'' || v_self_description || chr(10) ||
                      ''Error Info: '' || v_sql_errm || chr(10) ||
                      ''Execute sql:'' || v_sql || chr(10) || ''Params: '' ||
                      chr(10) || ' ||
                            f_tabapi_gen_zcstyle_exception_sentence(v_inp_insert_fields => v_inp_delete_unique) || '; 
                                                                                           
      --新增进入错误信息表
      scmdata.pkg_qa_ee.p_ins_errrecord_at(v_inp_errprogram     => v_self_description,
                                           v_inp_causeerruserid => v_inp_update_id,
                                           v_inp_erroccurtime   => SYSDATE,
                                           v_inp_errinfo        => v_error_info,
                                           v_inp_compid         => v_inp_company_id);
    
      --抛出报错
      raise_application_error(-20002, v_sql_errm);
    END ' || v_inp_procedure_name || ';';
  
    RETURN v_declaration || v_procedure_params || v_declaration_params || v_sql || v_execute_sentence || v_exception_sentence;
  END f_tabapi_gen_zcstyle_delete_sql;

  -- Author  : zc314
  -- Created : 2023-04-27 13:54:59
  -- Purpose : generate zcstyle delete sql
  FUNCTION f_tabapi_gen_isexists_function
  (
    v_inp_procedure_name IN VARCHAR2,
    v_inp_owner          IN VARCHAR2,
    v_inp_tablename      IN VARCHAR2,
    v_inp_select_unique  IN CLOB
  ) RETURN CLOB IS
    v_declaration      CLOB;
    v_procedure_params CLOB;
    v_conds            CLOB;
    v_sql              CLOB;
  BEGIN
    --generate declaration part
    v_declaration := 'function ' || v_inp_procedure_name || ' (' || chr(10);
  
    --generate procedure params part
    v_procedure_params := scmdata.pkg_zc_code_helper.f_tabapi_gen_input_param(v_inp_owner            => v_inp_owner,
                                                                              v_inp_tablename        => v_inp_tablename,
                                                                              v_inp_fields           => v_inp_select_unique,
                                                                              v_inp_fields_separator => ',') ||
                          ') return number is v_jugnum number(1); begin ' ||
                          chr(10);
  
    --generate conds
    v_conds := scmdata.pkg_zc_code_helper.f_tabapi_get_update_or_delete_info(v_inp_column_names       => v_inp_select_unique,
                                                                             v_inp_fields_separator   => ',',
                                                                             v_inp_sentence_separator => ' and');
  
    --conds replace                                                   
    v_conds := REPLACE(v_conds, ':', '');
  
    --generate sql part
    v_sql := '--获取结果' || chr(10) ||
             'select nvl(max(1), 0) into v_jugnum from ' || v_inp_owner || '.' ||
             v_inp_tablename || ' where ' || v_conds || ' and rownum = 1; ' ||
             chr(10) || '--返回结果' || chr(10) || 'return v_jugnum; ' ||
             chr(10) || ' end ' || v_inp_procedure_name || ';';
  
    --return info
    RETURN v_declaration || v_procedure_params || v_sql;
  END f_tabapi_gen_isexists_function;

END pkg_zc_code_helper;
/

