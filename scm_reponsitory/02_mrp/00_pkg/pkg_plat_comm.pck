CREATE OR REPLACE PACKAGE MRP.pkg_plat_comm IS

  FUNCTION f_getkeycode(pi_table_name  VARCHAR2, --表名
                        pi_column_name VARCHAR2, --列名
                        pi_pre         VARCHAR2, --前缀
                        pi_serail_num  NUMBER) RETURN VARCHAR2;

  FUNCTION f_get_docuno(pi_table_name  IN VARCHAR2, --表名 例：MRP.SUPPLIER_COLOR_INVENTORY
                        pi_column_name IN VARCHAR2, --字段名 例：INVENTORY_CODE
                        pi_pre         IN VARCHAR2, --前缀 例：CKPD20230223
                        pi_serail_num  NUMBER --序号位数 例 5
                        ) RETURN VARCHAR2;

  FUNCTION f_get_uuid RETURN VARCHAR;

  --解析json
  FUNCTION f_parse_json(p_jsonstr VARCHAR2, p_key VARCHAR2) RETURN CLOB;

  --判断字段新旧值是否相等
  FUNCTION f_is_check_fields_eq(p_old_field VARCHAR2, p_new_field VARCHAR2)
    RETURN INT;

  --生成mrp数字类型id
  FUNCTION f_get_mrp_keyid(pi_pre     VARCHAR2,
                           pi_owner   VARCHAR2,
                           pi_seqname VARCHAR2,
                           pi_seqnum  NUMBER DEFAULT NULL) RETURN NUMBER;
END pkg_plat_comm;
/

CREATE OR REPLACE PACKAGE BODY MRP.pkg_plat_comm IS
  FUNCTION f_getkeycode(pi_table_name  VARCHAR2, --表名  例：MRP.SUPPLIER_COLOR_INVENTORY
                        pi_column_name VARCHAR2, --单号列名 例：INVENTORY_CODE
                        pi_pre         VARCHAR2, --前缀  例：CKPD20230223
                        pi_serail_num  NUMBER --序号位数 例 5
                        ) RETURN VARCHAR2 IS
    --流水号长度
    /*    pi_table_name  VARCHAR2(250) := 't_supplier_info';
    pi_column_name VARCHAR2(250) := 'supplier_code';
    pi_company_id  VARCHAR2(250) := 'a972dd1ffe3b3a10e0533c281cac8fd7';
    pi_pre         VARCHAR2(250) := 'C';
    pi_serail_num  NUMBER := 5;*/
    --p_length INT;
    p_id     NUMBER(38);
    p_sql    VARCHAR2(4000);
    p_result VARCHAR2(50);
  BEGIN
    /*SELECT MAX(decode(data_type, 'NUMBER', data_precision, data_length))
     INTO p_length
     FROM user_tab_columns
    WHERE table_name = upper(pi_table_name)
      AND column_name = upper(pi_column_name);*/
  
    --dbms_output.put_line(p_length);
  
    p_sql := 'SELECT nvl(MAX(v.tcode), 0)
  FROM (SELECT DISTINCT MAX(to_number(substr(' ||
             pi_column_name || ',
                                             nvl(length(''' ||
             pi_pre ||
             '''), 0) + 1,
                                             length(''' ||
             pi_column_name || ''')))) over(PARTITION BY substr(' ||
             pi_column_name || ', 0, nvl(length(''' || pi_pre ||
             '''), 0))) tcode
          FROM ' || pi_table_name || '
         WHERE ' || pi_column_name || ' IS NOT NULL
           AND substr(' || pi_column_name ||
             ', 0, nvl(length(''' || pi_pre || '''), 0)) = ''' || pi_pre || '''
           AND regexp_like(substr(' || pi_column_name || ',
                                  nvl(length(''' || pi_pre ||
             '''), 0) + 1,
                                  length(''' || pi_column_name ||
             ''')),' || '''^[0-9]+[0-9]$''' || ')) v';
  
    --dbms_output.put_line(p_sql);
  
    EXECUTE IMMEDIATE p_sql
      INTO p_id;
  
    /*IF (length(pi_pre) +
       length(lpad(to_char(p_id + 1), pi_serail_num, '0'))) > p_length THEN
      dbms_output.put_line('超出字段長度');
      raise_application_error(-20002, SQLERRM);
    END IF;*/
  
    p_result := pi_pre || lpad(to_char(p_id + 1), pi_serail_num, '0');
  
    /*dbms_output.put_line(pi_pre ||
    lpad(to_char(p_id + 1), pi_serail_num, '0'));*/
  
    RETURN p_result;
    /*dbms_output.put_line(pi_pre ||
    lpad(to_char(p_id + 1), pi_serail_num, '0'));*/
  
  EXCEPTION
    WHEN OTHERS THEN
      --dbms_output.put_line(p_sql);
      raise_application_error(-20002, SQLERRM);
      RETURN NULL;
  END f_getkeycode;

  FUNCTION f_get_docuno(pi_table_name  IN VARCHAR2, --表名 例：MRP.SUPPLIER_COLOR_INVENTORY
                        pi_column_name IN VARCHAR2, --字段名 例：INVENTORY_CODE
                        pi_pre         IN VARCHAR2, --前缀 例：CKPD20230223
                        pi_serail_num  NUMBER --序号位数 例 5
                        ) RETURN VARCHAR2 IS
  
    v_docuno VARCHAR2(32);
    v_sql    VARCHAR2(4000);
  BEGIN
    v_sql := 'SELECT * FROM ' || pi_table_name || ' WHERE ' ||
             pi_column_name || ' LIKE ''' || pi_pre || '%'' FOR UPDATE';
    EXECUTE IMMEDIATE v_sql;
    v_docuno := mrp.pkg_plat_comm.f_getkeycode(pi_table_name  => pi_table_name,
                                               pi_column_name => pi_column_name,
                                               pi_pre         => pi_pre,
                                               pi_serail_num  => pi_serail_num);
  
    RETURN v_docuno;
  
  END f_get_docuno;

  FUNCTION f_get_uuid RETURN VARCHAR IS
    guid VARCHAR(50);
  BEGIN
    guid := lower(rawtohex(sys_guid()));
    RETURN guid;
  END f_get_uuid;

  /*============================================*
  * Author   : CZH
  * Created  : 16-5月 -22
  * ALERTER  :
  * ALERTER_TIME  :
  * Purpose  :  解析JSON字符串 
  * p_jsonstr json字符串
  * p_key 键
  * 返回p_key对应的值
  * '{"COL_1": "PRODUCT_TYPE","COL_2": "00;01","COL_3": "","COL_4": "","COL_5": "","COL_6": "","COL_7": "","COL_8": "","COL_9": "","COL_10": "","COL_11": "YWZ","COL_21": "","COL_22": ""}'  
  * Obj_Name : F_PARSE_JSON
  *============================================*/
  FUNCTION f_parse_json(p_jsonstr VARCHAR2, p_key VARCHAR2) RETURN CLOB IS
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
  
    RETURN translate(rtnval, chr(13) || chr(10), ',');
  END f_parse_json;

  --判断字段新旧值是否相等
  --返回值 ：0 不相等 ，1 相等
  FUNCTION f_is_check_fields_eq(p_old_field VARCHAR2, p_new_field VARCHAR2)
    RETURN INT IS
  BEGIN
    IF (p_old_field IS NULL AND p_new_field IS NOT NULL) OR
       (p_old_field IS NOT NULL AND p_new_field IS NULL) OR
       (p_old_field <> p_new_field) THEN
      RETURN 0;
    ELSE
      RETURN 1;
    END IF;
  END f_is_check_fields_eq;

  FUNCTION f_get_mrp_keyid(pi_pre     VARCHAR2,
                           pi_owner   VARCHAR2,
                           pi_seqname VARCHAR2,
                           pi_seqnum  NUMBER DEFAULT NULL) RETURN NUMBER IS
  
    p_pre               VARCHAR2(20) := upper(pi_pre); --前缀 动态
    p_seqname           VARCHAR2(100) := pi_seqname; --序列名称 动态  seq_plat_code
    p_seqnum            NUMBER := pi_seqnum; --序列位数 0~99 最大值
    v_max_value         NUMBER;
    v_code              NUMBER; --生成编码
    v_date              VARCHAR2(30); --年月日
    v_seconds           NUMBER; --时分秒转换=》秒
    v_current_timestamp VARCHAR2(30); --时间戳获取毫秒
    v_seqno             VARCHAR2(100); --序列
    v_flag              NUMBER;
    --V_NUM               NUMBER;
  BEGIN
    --1.年月日6位
    SELECT to_char(SYSDATE, 'YYYYMMDD') INTO v_date FROM dual;
    --2.时分秒5位
    SELECT to_number(substr(to_char(SYSDATE, 'HH24:MI:SS'), 0, 2)) * 60 * 60 +
           
           to_number(substr(to_char(SYSDATE, 'HH24:MI:SS'), 4, 2)) * 60 +
           
           to_number(substr(to_char(SYSDATE, 'HH24:MI:SS'), 7, 2))
      INTO v_seconds
      FROM dual;
    --3.毫秒3位
    SELECT to_char(current_timestamp, 'ff3')
      INTO v_current_timestamp
      FROM dual;
  
    --随机数10位
    --SELECT to_number(SUBSTR(TO_CHAR(DBMS_RANDOM.VALUE(11, 99)), 4, 10)) INTO V_NUM from dual;
  
    --校验序列名称是否为空
    IF p_seqname IS NULL THEN
      raise_application_error(-20002, '请填写序列名称');
    END IF;
    --判断此序列是否存在
    SELECT COUNT(1)
      INTO v_flag
      FROM all_sequences a
     WHERE a.sequence_name = upper(p_seqname)
       AND a.sequence_owner = upper(pi_owner);
    IF v_flag > 0 THEN
      --4.存在序列
      EXECUTE IMMEDIATE 'SELECT ' || pi_owner || '.' || p_seqname ||
                        '.nextval FROM dual'
        INTO v_seqno;
    ELSE
      --不存在序列
      --校验序列最大值是否为空
      IF p_seqnum IS NULL THEN
        raise_application_error(-20002, '请填写序列最大值');
      END IF;
    
      EXECUTE IMMEDIATE 'create sequence' || pi_owner || '.' || p_seqname ||
                        ' minvalue 0 maxvalue ' || p_seqnum ||
                        ' start with 0 increment by 1 cache 2 cycle';
    
      EXECUTE IMMEDIATE 'SELECT ' || pi_owner || '.' || p_seqname ||
                        '.nextval FROM dual'
        INTO v_seqno;
    END IF;
    --获取序列最大值位数
    SELECT length(a.max_value)
      INTO v_max_value
      FROM all_sequences a
     WHERE a.sequence_name = upper(p_seqname)
       AND a.sequence_owner = upper(pi_owner);
  
    v_seqno := lpad(v_seqno, v_max_value, '0');
  
    --生成编号
    SELECT to_number(p_pre || v_date || v_seconds || v_current_timestamp /*||V_NUM*/
                     || v_seqno)
      INTO v_code
      FROM dual;
  
    RETURN v_code;
  END f_get_mrp_keyid;

END pkg_plat_comm;
/

