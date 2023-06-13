--1.0~99随机数
SELECT trunc(dbms_random.value(0, 99), 0) FROM dual;

SELECT abs(MOD(dbms_random.random, 100)) FROM dual;

--2位序列

--2.年月日
SELECT substr(to_char(SYSDATE, 'YYYYMMDD'), 3, 8) AS date_time FROM dual;

--2.时分秒转换成秒
SELECT to_number(substr(to_char(SYSDATE, 'HH24:MI:SS'), 0, 2)) * 60 * 60 +
       
       to_number(substr(to_char(SYSDATE, 'HH24:MI:SS'), 4, 2)) * 60 +
       
       to_number(substr(to_char(SYSDATE, 'HH24:MI:SS'), 7, 2)) AS seconds
  FROM dual;

--3.获取毫秒：
SELECT to_char(current_timestamp, 'ff3'), to_char(systimestamp, 'ff3')
  FROM dual;
--获取毫秒： 6位毫秒
SELECT to_char(current_timestamp, 'ff6'), to_char(systimestamp, 'ff6')
  FROM dual;

--4.序列
SELECT lpad(scmdata.seq_plat_code.nextval, 2, 0) FROM dual;

SELECT lpad(scmdata.seq_plat_code_test.nextval, 3, 0) FROM dual;


--需注意，放在包中执行时，会报权限不足的错误。解决方案：在包说明加上   AUTHID CURRENT_USER
DECLARE
  p_pre               VARCHAR2(20) := 'GY'; --前缀 动态
  p_seqname           VARCHAR2(100) := 'seq_plat_code_test'; --序列名称 动态  seq_plat_code
  p_seqnum            NUMBER; --序列位数 0~99 最大值
  v_max_value         NUMBER;
  v_code              VARCHAR2(1000); --生成编码
  v_date              VARCHAR2(30); --年月日
  v_seconds           NUMBER; --时分秒转换=》秒
  v_current_timestamp VARCHAR2(30); --时间戳获取毫秒
  v_seqno             VARCHAR2(100); --序列
  v_flag              NUMBER;
BEGIN

  --1.年月日6位
  SELECT substr(to_char(SYSDATE, 'YYYYMMDD'), 3, 8) INTO v_date FROM dual;
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
  --校验序列名称是否为空
  IF p_seqname IS NULL THEN
    raise_application_error(-20002, '请填写序列名称');
  END IF;
  --判断此序列是否存在
  SELECT COUNT(1)
    INTO v_flag
    FROM all_sequences a
   WHERE a.sequence_name = upper(p_seqname);

  IF v_flag > 0 THEN
    --4.存在序列 
    EXECUTE IMMEDIATE 'SELECT scmdata.' || p_seqname ||
                      '.nextval FROM dual'
      INTO v_seqno;
  ELSE
    --不存在序列
    --校验序列最大值是否为空
    IF p_seqnum IS NULL THEN
      raise_application_error(-20002, '请填写序列最大值');
    END IF;
  
    EXECUTE IMMEDIATE 'create sequence scmdata.' || p_seqname ||
                      ' minvalue 0 maxvalue ' || p_seqnum ||
                      ' start with 0 increment by 1 cache 2 cycle';
  
    EXECUTE IMMEDIATE 'SELECT scmdata.' || p_seqname ||
                      '.nextval FROM dual'
      INTO v_seqno;
  END IF;
  --获取序列最大值位数
  SELECT length(a.max_value)
    INTO v_max_value
    FROM all_sequences a
   WHERE a.sequence_name = upper(p_seqname);

  v_seqno := lpad(v_seqno, v_max_value, '0');

  --dbms_output.put_line(v_max_value || ',' || v_seqno);

  --生成编号
  SELECT p_pre || v_date || v_seconds || v_current_timestamp || v_seqno
    INTO v_code
    FROM dual;

  --dbms_output.put_line(v_code);

END;
