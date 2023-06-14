--1.0~99�����
SELECT trunc(dbms_random.value(0, 99), 0) FROM dual;

SELECT abs(MOD(dbms_random.random, 100)) FROM dual;

--2λ����

--2.������
SELECT substr(to_char(SYSDATE, 'YYYYMMDD'), 3, 8) AS date_time FROM dual;

--2.ʱ����ת������
SELECT to_number(substr(to_char(SYSDATE, 'HH24:MI:SS'), 0, 2)) * 60 * 60 +
       
       to_number(substr(to_char(SYSDATE, 'HH24:MI:SS'), 4, 2)) * 60 +
       
       to_number(substr(to_char(SYSDATE, 'HH24:MI:SS'), 7, 2)) AS seconds
  FROM dual;

--3.��ȡ���룺
SELECT to_char(current_timestamp, 'ff3'), to_char(systimestamp, 'ff3')
  FROM dual;
--��ȡ���룺 6λ����
SELECT to_char(current_timestamp, 'ff6'), to_char(systimestamp, 'ff6')
  FROM dual;

--4.����
SELECT lpad(scmdata.seq_plat_code.nextval, 2, 0) FROM dual;

SELECT lpad(scmdata.seq_plat_code_test.nextval, 3, 0) FROM dual;


--��ע�⣬���ڰ���ִ��ʱ���ᱨȨ�޲���Ĵ��󡣽���������ڰ�˵������   AUTHID CURRENT_USER
DECLARE
  p_pre               VARCHAR2(20) := 'GY'; --ǰ׺ ��̬
  p_seqname           VARCHAR2(100) := 'seq_plat_code_test'; --�������� ��̬  seq_plat_code
  p_seqnum            NUMBER; --����λ�� 0~99 ���ֵ
  v_max_value         NUMBER;
  v_code              VARCHAR2(1000); --���ɱ���
  v_date              VARCHAR2(30); --������
  v_seconds           NUMBER; --ʱ����ת��=����
  v_current_timestamp VARCHAR2(30); --ʱ�����ȡ����
  v_seqno             VARCHAR2(100); --����
  v_flag              NUMBER;
BEGIN

  --1.������6λ
  SELECT substr(to_char(SYSDATE, 'YYYYMMDD'), 3, 8) INTO v_date FROM dual;
  --2.ʱ����5λ
  SELECT to_number(substr(to_char(SYSDATE, 'HH24:MI:SS'), 0, 2)) * 60 * 60 +
         
         to_number(substr(to_char(SYSDATE, 'HH24:MI:SS'), 4, 2)) * 60 +
         
         to_number(substr(to_char(SYSDATE, 'HH24:MI:SS'), 7, 2))
    INTO v_seconds
    FROM dual;
  --3.����3λ
  SELECT to_char(current_timestamp, 'ff3')
    INTO v_current_timestamp
    FROM dual;
  --У�����������Ƿ�Ϊ��
  IF p_seqname IS NULL THEN
    raise_application_error(-20002, '����д��������');
  END IF;
  --�жϴ������Ƿ����
  SELECT COUNT(1)
    INTO v_flag
    FROM all_sequences a
   WHERE a.sequence_name = upper(p_seqname);

  IF v_flag > 0 THEN
    --4.�������� 
    EXECUTE IMMEDIATE 'SELECT scmdata.' || p_seqname ||
                      '.nextval FROM dual'
      INTO v_seqno;
  ELSE
    --����������
    --У���������ֵ�Ƿ�Ϊ��
    IF p_seqnum IS NULL THEN
      raise_application_error(-20002, '����д�������ֵ');
    END IF;
  
    EXECUTE IMMEDIATE 'create sequence scmdata.' || p_seqname ||
                      ' minvalue 0 maxvalue ' || p_seqnum ||
                      ' start with 0 increment by 1 cache 2 cycle';
  
    EXECUTE IMMEDIATE 'SELECT scmdata.' || p_seqname ||
                      '.nextval FROM dual'
      INTO v_seqno;
  END IF;
  --��ȡ�������ֵλ��
  SELECT length(a.max_value)
    INTO v_max_value
    FROM all_sequences a
   WHERE a.sequence_name = upper(p_seqname);

  v_seqno := lpad(v_seqno, v_max_value, '0');

  --dbms_output.put_line(v_max_value || ',' || v_seqno);

  --���ɱ��
  SELECT p_pre || v_date || v_seconds || v_current_timestamp || v_seqno
    INTO v_code
    FROM dual;

  --dbms_output.put_line(v_code);

END;
