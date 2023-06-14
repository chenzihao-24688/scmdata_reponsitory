CREATE OR REPLACE PACKAGE PLM.pkg_plat_comm IS

  -- Author  : CZH
  -- Created : 2022/7/26 14:31:12
  -- Purpose : 平台公共函数

  /*============================================*
  * AUTHOR   : CZH
  * CREATED  : 2022-07-26 16:57:42
  * ALERTER  : 
  * ALERTER_TIME  : 
  * PURPOSE  :  生成PLM单据编号        
  *            生成规则：单据名称前2位大写字母（如：HZ）+年月日6位（如：20210921）+ N位序列
  * OBJ_NAME    : F_GET_PLAT_KEY_ID
  * ARG_NUMBER  : 3
  * PI_PRE : 前缀
  * PI_SEQNAME : 序列名
  *============================================*/
  FUNCTION f_get_plat_key_id(pi_pre VARCHAR2, pi_seqname VARCHAR2)
    RETURN VARCHAR2;

  /*--------------------------------------------------------------------
   id生成
  入参：
    V_TABLE_NAME    表名
    V_COLUMN_NAME   列名
    V_PRE           前缀
    V_SERAIL_NUM    流水号长度   
  
  
   ------------------------------------------------------------------*/
  FUNCTION f_get_keycode(v_table_name  IN VARCHAR2,
                         v_column_name IN VARCHAR2,
                         v_pre         IN VARCHAR2,
                         v_serail_num  NUMBER) RETURN VARCHAR2;

  --根据分隔符拆分，获取分隔符前后字符串
  FUNCTION f_get_val_by_delimit(p_character VARCHAR2,
                                p_separate  CHAR,
                                p_is_pre    INT DEFAULT 1) RETURN VARCHAR2;

  --asscoate data_sql
  --获取pkid，rest方法（POST;DELETE;PUT;GET）,动态参数
  --sup123/ALL;GET;POST;PUT;DELETE?PARAM1&PARAM2
  PROCEDURE p_get_rest_val_method_params(p_character     VARCHAR2,
                                         po_pk_id        OUT VARCHAR2,
                                         po_rest_methods OUT VARCHAR2,
                                         po_params       OUT VARCHAR2);
  --  解析JSON字符串  --
  ------------------------------
  --p_jsonstr json字符串
  --p_key 键
  --返回p_key对应的值
  --'{"COL_1": "PRODUCT_TYPE","COL_2": "00;01","COL_3": "","COL_4": "","COL_5": "","COL_6": "","COL_7": "","COL_8": "","COL_9": "","COL_10": "","COL_11": "YWZ","COL_21": "","COL_22": ""}'
  FUNCTION parse_json(p_jsonstr VARCHAR2, p_key VARCHAR2) RETURN CLOB;

  FUNCTION f_get_uuid RETURN VARCHAR;

  --获取字典lookup
  FUNCTION f_get_company_dict_lookup_sql(p_company_id VARCHAR2,
                                         p_dict_type  VARCHAR2,
                                         p_value      VARCHAR2,
                                         p_desc       VARCHAR2,
                                         p_rtn_type   INT DEFAULT 0)
    RETURN CLOB;

  --通过vaule或id 获取字典值
  --0 获取value
  --1 获取id
  FUNCTION f_get_company_dict_by_value_or_id(p_company_id VARCHAR2,
                                             p_dict_type  VARCHAR2,
                                             p_valueorid  VARCHAR2,
                                             p_type       INT DEFAULT 0)
    RETURN VARCHAR2;

  --获取图片/附件相关信息
  PROCEDURE p_get_file_info(p_file_unique VARCHAR2,
                            po_file_name  OUT VARCHAR2,
                            po_file_size  OUT NUMBER,
                            po_attachment OUT BLOB);

  --plm、mrp系统
  --blob图片、附件存值至scmdata file_info,file_data
  --scm前端通过速狮配置后，用file_unique字段返显文件
  PROCEDURE p_other_system_file_blob_to_scm(p_file_unique VARCHAR2,
                                            p_file_name   VARCHAR2 DEFAULT NULL,
                                            p_file_size   NUMBER DEFAULT NULL,
                                            p_file_blob   BLOB DEFAULT NULL,
                                            p_update_time DATE DEFAULT NULL,
                                            p_type        INT);
END pkg_plat_comm;
/
CREATE OR REPLACE PACKAGE BODY PLM.pkg_plat_comm IS

  /*============================================*
  * AUTHOR   : CZH
  * CREATED  : 2022-07-26 16:57:42
  * ALERTER  : 
  * ALERTER_TIME  : 
  * PURPOSE  :  生成PLM单据编号        
  *            生成规则：单据名称前2位大写字母（如：HZ）+年月日6位（如：20210921）+ N位序列
  * OBJ_NAME    : F_GET_PLAT_KEY_ID
  * ARG_NUMBER  : 3
  * PI_PRE : 前缀
  * PI_SEQNAME : 序列名
  *============================================*/
  FUNCTION f_get_plat_key_id(pi_pre VARCHAR2, pi_seqname VARCHAR2)
    RETURN VARCHAR2 IS
    p_pre       VARCHAR2(20) := upper(pi_pre); --前缀
    p_seqname   VARCHAR2(100) := upper(pi_seqname); --序列名称 
    v_max_value NUMBER;
    v_code      VARCHAR2(1000); --生成编码
    v_date      VARCHAR2(30); --年月日
    v_seqno     VARCHAR2(100); --序列
    v_flag      NUMBER;
  BEGIN
    --1.年月日6位
    SELECT substr(to_char(SYSDATE, 'YYYYMMDD'), 1, 8)
      INTO v_date
      FROM dual;
    --2.校验序列是否为空
    IF p_seqname IS NULL THEN
      raise_application_error(-20002, '请填写序列名称');
    ELSE
      --3.判断此序列是否存在
      SELECT COUNT(1)
        INTO v_flag
        FROM all_sequences a
       WHERE a.sequence_name = p_seqname;
    
      IF v_flag > 0 THEN
        --4.存在序列 
        EXECUTE IMMEDIATE 'SELECT plm.' || p_seqname ||
                          '.nextval FROM dual'
          INTO v_seqno;
      
        --获取序列最大值位数
        SELECT length(a.max_value)
          INTO v_max_value
          FROM all_sequences a
         WHERE a.sequence_name = p_seqname
           AND a.sequence_owner = 'PLM';
      
        v_seqno := lpad(v_seqno, v_max_value, '0');
      
        --5.生成编号
        SELECT p_pre || v_date || v_seqno INTO v_code FROM dual;
      ELSE
        raise_application_error(-20002, '不存在序列');
      END IF;
    END IF;
    RETURN v_code;
  END f_get_plat_key_id;

  /*--------------------------------------------------------------------
   id生成
  入参：
    V_TABLE_NAME    表名
    V_COLUMN_NAME   列名
    V_PRE           前缀
    V_SERAIL_NUM    流水号长度   
   ------------------------------------------------------------------*/
  FUNCTION f_get_keycode(v_table_name  IN VARCHAR2,
                         v_column_name IN VARCHAR2,
                         v_pre         IN VARCHAR2,
                         v_serail_num  NUMBER) RETURN VARCHAR2 IS
  
    p_length INT;
    p_id     NUMBER(38);
    p_sql    VARCHAR2(4000);
    p_result VARCHAR2(50);
  BEGIN
    SELECT MAX(decode(data_type, 'NUMBER', data_precision, data_length))
      INTO p_length
      FROM all_tab_columns
     WHERE table_name = upper(v_table_name)
       AND column_name = upper(v_column_name);
  
    --dbms_output.put_line(p_length);
  
    p_sql := 'SELECT nvl(MAX(v.tcode), 0)
  FROM (SELECT DISTINCT MAX(to_number(substr(' || v_column_name || ',
                                             nvl(length(''' ||
             v_pre ||
             '''), 0) + 1,
                                             length(''' ||
             v_column_name || ''')))) over(PARTITION BY substr(' ||
             v_column_name || ', 0, nvl(length(''' || v_pre ||
             '''), 0))) tcode
          FROM ' || v_table_name || ' 
         WHERE ' || v_column_name || ' IS NOT NULL
           AND substr(' || v_column_name ||
             ', 0, nvl(length(''' || v_pre || '''), 0)) = ''' || v_pre || '''
           AND regexp_like(substr(' || v_column_name || ',
                                  nvl(length(''' || v_pre ||
             '''), 0) + 1,
                                  length(''' || v_column_name ||
             ''')),' || '''^[0-9]+[0-9]$''' || ')) v';
  
    --dbms_output.put_line(p_sql);
  
    EXECUTE IMMEDIATE p_sql
      INTO p_id;
  
    IF (length(v_pre) + length(lpad(to_char(p_id + 1), v_serail_num, '0'))) >
       p_length THEN
      dbms_output.put_line('超出字段長度');
      raise_application_error(-20002, SQLERRM);
    END IF;
  
    p_result := v_pre || lpad(to_char(p_id + 1), v_serail_num, '0');
  
    /*dbms_output.put_line(V_PRE ||
    lpad(to_char(p_id + 1), pi_serail_num, '0'));*/
  
    RETURN p_result;
    /*dbms_output.put_line(V_PRE ||
    lpad(to_char(p_id + 1), pi_serail_num, '0'));*/
  
  EXCEPTION
    WHEN OTHERS THEN
      --dbms_output.put_line(p_sql);
      raise_application_error(-20002, SQLERRM);
      RETURN NULL;
  END f_get_keycode;

  --根据分隔符拆分，获取分隔符前后字符串
  FUNCTION f_get_val_by_delimit(p_character VARCHAR2,
                                p_separate  CHAR,
                                p_is_pre    INT DEFAULT 1) RETURN VARCHAR2 IS
    v_val VARCHAR2(4000);
  BEGIN
    IF p_is_pre = 1 THEN
      v_val := substr(p_character,
                      1,
                      instr(p_character, p_separate, -1) - 1);
    ELSIF p_is_pre = 0 THEN
      v_val := substr(p_character, instr(p_character, p_separate, -1) + 1);
    ELSE
      v_val := NULL;
    END IF;
    RETURN v_val;
  END f_get_val_by_delimit;

  --asscoate data_sql
  --获取pkid，rest方法（POST;DELETE;PUT;GET）,动态参数
  --sup123/ALL;GET;POST;PUT;DELETE?PARAM1=123&PARAM2=456
  PROCEDURE p_get_rest_val_method_params(p_character     VARCHAR2,
                                         po_pk_id        OUT VARCHAR2,
                                         po_rest_methods OUT VARCHAR2,
                                         po_params       OUT VARCHAR2) IS
    vo_pkid    VARCHAR2(256);
    vo_methods VARCHAR2(256);
    vo_params  VARCHAR2(256);
  BEGIN
  
    vo_pkid := f_get_val_by_delimit(p_character => p_character,
                                    p_separate  => '/',
                                    p_is_pre    => 1);
  
    vo_methods := f_get_val_by_delimit(p_character => p_character,
                                       p_separate  => '/',
                                       p_is_pre    => 0);
    IF instr(vo_methods, '?') > 0 THEN
      vo_methods := f_get_val_by_delimit(p_character => vo_methods,
                                         p_separate  => '?',
                                         p_is_pre    => 1);
    END IF;
  
    vo_params := f_get_val_by_delimit(p_character => p_character,
                                      p_separate  => '?',
                                      p_is_pre    => 0);
  
    po_pk_id        := vo_pkid;
    po_rest_methods := vo_methods;
    po_params       := vo_params;
  
  END p_get_rest_val_method_params;

  -- 解析JSON字符串  
  --p_jsonstr json字符串
  --p_key 键
  --返回p_key对应的值
  --'{"COL_1": "PRODUCT_TYPE","COL_2": "00;01","COL_3": "","COL_4": "","COL_5": "","COL_6": "","COL_7": "","COL_8": "","COL_9": "","COL_10": "","COL_11": "YWZ","COL_21": "","COL_22": ""}'
  FUNCTION parse_json(p_jsonstr VARCHAR2, p_key VARCHAR2) RETURN CLOB IS
    rtnval    VARCHAR2(50);
    i         NUMBER(2);
    jsonkey   VARCHAR2(50);
    jsonvalue VARCHAR2(50);
    json      VARCHAR2(1000);
  BEGIN
    IF p_jsonstr IS NOT NULL THEN
      json := REPLACE(p_jsonstr, '{', '');
      json := REPLACE(json, '}', '');
      json := REPLACE(json, '"', '');
    
      /*SELECT column_value VALUE
      FROM sf_get_arguments_pkg.get_strarray(av_str   => json, --要分割的字符串
                                             av_split => ',' --分隔符号
                                             )*/
    
      FOR temprow IN (SELECT str_value
                        FROM (SELECT regexp_substr(json,
                                                   '[^' || ',' || ']+',
                                                   1,
                                                   LEVEL,
                                                   'i') AS str_value
                                FROM dual
                              CONNECT BY LEVEL <=
                                         length(json) -
                                         length(regexp_replace(json, ',', '')) + 1)
                       WHERE instr(str_value, p_key) > 0) LOOP
      
        IF temprow.str_value IS NOT NULL THEN
          IF instr(temprow.str_value, p_key) > 0 THEN
            i         := 0;
            jsonkey   := '';
            jsonvalue := '';
            FOR tem2 IN (SELECT regexp_substr(temprow.str_value,
                                              '[^' || ':' || ']+',
                                              1,
                                              LEVEL,
                                              'i') AS VALUE
                           FROM dual
                         CONNECT BY LEVEL <=
                                    length(temprow.str_value) -
                                    length(regexp_replace(temprow.str_value,
                                                          ':',
                                                          '')) + 1) LOOP
              IF i = 0 THEN
                jsonkey := tem2.value;
              END IF;
              IF i = 1 THEN
                jsonvalue := tem2.value;
                IF (jsonkey = p_key) THEN
                  rtnval := TRIM(jsonvalue);
                  EXIT;
                END IF;
              END IF;
            
              IF i = 0 THEN
                i := i + 1;
              ELSE
                i := 0;
              END IF;
            
            END LOOP;
            EXIT;
          ELSE
            CONTINUE;
          END IF;
        END IF;
      END LOOP;
    END IF;
  
    RETURN rtnval;
  END parse_json;
  /* createtime: 2020-7-1
     author: HX87
     memo:通过UUID获取主键
  */
  FUNCTION f_get_uuid RETURN VARCHAR IS
    guid VARCHAR(50);
  BEGIN
    guid := lower(rawtohex(sys_guid()));
    RETURN guid;
  END f_get_uuid;
  --获取字典lookup
  --0 获取value
  --1 获取id
  FUNCTION f_get_company_dict_lookup_sql(p_company_id VARCHAR2,
                                         p_dict_type  VARCHAR2,
                                         p_value      VARCHAR2,
                                         p_desc       VARCHAR2,
                                         p_rtn_type   INT DEFAULT 0)
    RETURN CLOB IS
    v_sql CLOB;
  BEGIN
    IF p_rtn_type = 0 THEN
      v_sql := q'[SELECT t.company_dict_name ]' || p_desc ||
               q'[, t.company_dict_value ]' || p_value || q'[
      FROM scmdata.sys_company_dict t
     WHERE t.company_id = ']' || p_company_id || q'['
       AND t.company_dict_type = ']' || p_dict_type || q'['
       AND t.pause = 0 ]';
    ELSIF p_rtn_type = 1 THEN
      v_sql := q'[SELECT t.company_dict_name ]' || p_desc ||
               q'[, t.company_dict_id ]' || p_value || q'[
      FROM scmdata.sys_company_dict t
     WHERE t.company_id = ']' || p_company_id || q'['
       AND t.company_dict_type = ']' || p_dict_type || q'['
       AND t.pause = 0 ]';
    ELSE
      raise_application_error(-20002, '无法获取字典lookup');
    END IF;
    RETURN v_sql;
  END f_get_company_dict_lookup_sql;

  --通过vaule或id 获取字典值
  --0 获取value
  --1 获取id
  FUNCTION f_get_company_dict_by_value_or_id(p_company_id VARCHAR2,
                                             p_dict_type  VARCHAR2,
                                             p_valueorid  VARCHAR2,
                                             p_type       INT DEFAULT 0)
    RETURN VARCHAR2 IS
    v_sql  CLOB;
    v_name VARCHAR2(256);
  BEGIN
  
    v_sql := q'[SELECT max(t.company_dict_name)
        FROM scmdata.sys_company_dict t
       WHERE t.company_id = :company_id
         AND t.company_dict_type = :dict_type
         AND t.pause = 0]';
  
    IF p_type = 0 THEN
      v_sql := v_sql || ' AND t.company_dict_value = :company_dict_value';
    ELSIF p_type = 1 THEN
      v_sql := v_sql || ' AND t.company_dict_id = :company_dict_id';
    ELSE
      raise_application_error(-20002, '无法通过vaule或id 获取字典值');
    END IF;
  
    EXECUTE IMMEDIATE v_sql
      INTO v_name
      USING p_company_id, p_dict_type, p_valueorid;
  
    RETURN v_name;
  END f_get_company_dict_by_value_or_id;

  --获取图片/附件相关信息
  PROCEDURE p_get_file_info(p_file_unique VARCHAR2,
                            po_file_name  OUT VARCHAR2,
                            po_file_size  OUT NUMBER,
                            po_attachment OUT BLOB) IS
    v_file_name  VARCHAR2(256);
    v_file_size  NUMBER(20);
    v_attachment BLOB;
  BEGIN
    SELECT a.file_name, a.file_size, b.attachment
      INTO v_file_name, v_file_size, v_attachment
      FROM scmdata.file_info a
     INNER JOIN scmdata.file_data b
        ON b.file_id = a.md5
     WHERE a.file_unique = p_file_unique;
    po_file_name  := v_file_name;
    po_file_size  := v_file_size;
    po_attachment := v_attachment;
  END p_get_file_info;

  /*============================================*
  * Author   : CZH
  * Created  : 2022-09-20 16:06:19
  * ALERTER  : 
  * ALERTER_TIME  : 
  * Purpose  :  plm、mrp 文件上传（新增、修改、删除）时
  *             需将文件相关信息同步至scmdata file_info,file_data
  *             scm才可获取file_unique字段，通过速狮配置反显文件。
  * Obj_Name    : P_OTHER_SYSTEM_FILE_BLOB_TO_SCM
  * Arg_Number  : 6
  * < IN PARAMS >  
  * P_FILE_UNIQUE : 文件唯一键  必填 (PLM：存PLM_FILE表的主键【FILE_ID】 MRP：存MRP_PICTURE表的主键【PICTURE_ID】)
  * P_FILE_NAME :   文件名  （新增、修改时必填，删除可不填）
  * P_FILE_SIZE :   文件大小 （新增、修改时必填，删除可不填）
  * P_FILE_BLOB :   文件的BLOB格式 （新增、修改时必填，删除可不填）
  * P_UPDATE_TIME： 文件的更新时间 （新增、修改时必填，删除可不填）
  * P_TYPE :        操作类型 必填（0：新增，1：修改，2：删除）
  *============================================*/

  PROCEDURE p_other_system_file_blob_to_scm(p_file_unique VARCHAR2,
                                            p_file_name   VARCHAR2 DEFAULT NULL,
                                            p_file_size   NUMBER DEFAULT NULL,
                                            p_file_blob   BLOB DEFAULT NULL,
                                            p_update_time DATE DEFAULT NULL,
                                            p_type        INT) IS
    v_md5 VARCHAR2(32);
    v_str VARCHAR2(48);
  BEGIN
    --新增
    IF p_type = 0 THEN
      v_str := p_file_unique || to_char(p_update_time, 'yyyymmddhhmiss');
      --按文件唯一键+更新时间 重新生成MD5
      v_md5 := utl_raw.cast_to_raw(dbms_obfuscation_toolkit.md5(input_string => v_str));
    
      INSERT INTO scmdata.file_info
        (file_unique, file_name, file_size, md5, app_id, store_type, store_sid, store_status, lastupdatetime, store_source)
      VALUES
        (p_file_unique, p_file_name, p_file_size, v_md5, 'scm', 10, v_md5, 0, SYSDATE, 'DB#oracle_scmdata');
    
      INSERT INTO scmdata.file_data
        (file_id, attachment, file_size, create_date, pause, file_ext_name, lastupdatetime, is_hana)
      VALUES
        (v_md5, p_file_blob, p_file_size, SYSDATE, 0, substr(p_file_name,instr(p_file_name,'.',-1) + 1), SYSDATE, 0);
      --更新  
    ELSIF p_type = 1 THEN
    
      /* UPDATE scmdata.file_info t
         SET t.file_name      = p_file_name,
             t.file_size      = p_file_size,
             t.lastupdatetime = SYSDATE
       WHERE t.file_unique = p_file_unique;
      
      UPDATE scmdata.file_data t
         SET t.file_size      = p_file_size,
             t.attachment     = p_file_blob,
             t.lastupdatetime = SYSDATE
       WHERE t.file_id = (SELECT a.md5
                            FROM scmdata.file_info a
                           WHERE a.file_unique = p_file_unique);*/
      --更新时，需先删除                   
      p_other_system_file_blob_to_scm(p_file_unique => p_file_unique,
                                      p_type        => 2);
      --再重新生成file_info,file_data                                
      p_other_system_file_blob_to_scm(p_file_unique => p_file_unique,
                                      p_file_name   => p_file_name,
                                      p_file_size   => p_file_size,
                                      p_file_blob   => p_file_blob,
                                      p_update_time => p_update_time,
                                      p_type        => 0);
/*      --缓存
      INSERT INTO scmdata.file_cache
        (cache_id, file_id, is_cache, create_id, create_time, update_id, update_time, memo)
      VALUES
        (plm.pkg_plat_comm.f_get_uuid(), p_file_unique, 1, 'ADMIN', SYSDATE, 'ADMIN', SYSDATE, NULL);*/
      --删除
    ELSIF p_type = 2 THEN
      DELETE FROM scmdata.file_data t
       WHERE t.file_id = (SELECT a.md5
                            FROM scmdata.file_info a
                           WHERE a.file_unique = p_file_unique);
    
      DELETE FROM scmdata.file_info a WHERE a.file_unique = p_file_unique;
    ELSE
      NULL;
    END IF;
  END p_other_system_file_blob_to_scm;

END pkg_plat_comm;
/
