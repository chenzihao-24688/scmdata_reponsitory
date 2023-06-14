DECLARE
  pi_table_name  VARCHAR2(250) := 't_supplier_info'; --表名
  pi_column_name VARCHAR2(250) := 'supplier_code'; --列名
  pi_company_id  VARCHAR2(250) := 'a972dd1ffe3b3a10e0533c281cac8fd7'; --公司编号
  pi_pre         VARCHAR2(250) := 'C'; --前缀
  pi_serail_num  NUMBER := 5; --流水号长度
  p_length       INT;
  p_id           NUMBER(38);
  p_sql          VARCHAR2(4000);
  p_result       VARCHAR2(50);
BEGIN
  SELECT MAX(decode(data_type, 'NUMBER', data_precision, data_length))
    INTO p_length
    FROM user_tab_columns
   WHERE table_name = upper(pi_table_name)
     AND column_name = upper(pi_column_name);

  dbms_output.put_line(p_length);

  p_sql := 'SELECT nvl(MAX(v.tcode), 0)
  FROM (SELECT DISTINCT MAX(to_number(substr('||pi_column_name||',
                                             nvl(length('''||pi_pre||'''), 0) + 1,
                                             length('''||pi_column_name||''')))) over(PARTITION BY substr('||pi_column_name||', 0, nvl(length('''||pi_pre||'''), 0))) tcode
          FROM '||pi_table_name||' 
         WHERE company_id = '''||pi_company_id||'''
           AND '||pi_column_name|| ' IS NOT NULL
           AND substr('||pi_column_name||', 0, nvl(length('''||pi_pre||'''), 0)) = '''||pi_pre||'''
           AND regexp_like(substr('||pi_column_name||',
                                  nvl(length('''||pi_pre||'''), 0) + 1,
                                  length('''||pi_column_name||''')),'||
                           '''^[0-9]+[0-9]$'''||')) v';

  dbms_output.put_line(p_sql);

  EXECUTE IMMEDIATE p_sql
    INTO p_id;
  IF (length(pi_pre) + length(p_id)) > p_length THEN
    dbms_output.put_line('超出字段長度');
  END IF;

  dbms_output.put_line(pi_pre || lpad(to_char(p_id + 1), pi_serail_num, '0'));

  -- RETURN to_char(p_id + 1);

EXCEPTION
  WHEN OTHERS THEN
    dbms_output.put_line(p_sql);
    raise_application_error(-20002, SQLERRM);
    -- RETURN NULL;
END;








--查询
SELECT nvl(MAX(v.tcode), 0)
  FROM (SELECT DISTINCT MAX(to_number(substr(supplier_code,
                                             nvl(length(''), 0) + 1,
                                             length(supplier_code)))) over(PARTITION BY substr(supplier_code, 0, nvl(length(''), 0))) tcode
          FROM t_supplier_info
         WHERE company_id = 'a972dd1ffe3b3a10e0533c281cac8fd7'
           AND supplier_code IS NOT NULL
           AND substr(supplier_code, 0, nvl(length(''), 0)) = ''
           AND regexp_like(substr(supplier_code,
                                  nvl(length(''), 0) + 1,
                                  length(supplier_code)),
                           '^[0-9]+[0-9]$')) v;
