CREATE OR REPLACE PACKAGE scmdata.pkg_check_data_comm IS

  -- Author  : CZH55
  -- Created : 2020/9/22 16:23:15
  -- Purpose : У������-ͨ��
  FUNCTION f_check_integer(pi_data VARCHAR2, pi_type NUMBER) RETURN NUMBER;

  FUNCTION f_check_varchar(pi_data VARCHAR2, pi_type NUMBER) RETURN NUMBER;

  FUNCTION f_check_phone(pi_data VARCHAR2) RETURN NUMBER;

  FUNCTION f_check_id_card(pi_data VARCHAR2) RETURN NUMBER;

  FUNCTION f_check_email(pi_data VARCHAR2) RETURN NUMBER;

  FUNCTION f_check_soial_code(pi_data VARCHAR2) RETURN NUMBER;

  FUNCTION f_check_logn_name(pi_data VARCHAR2) RETURN NUMBER;

  FUNCTION f_check_telandphone(pi_data VARCHAR2) RETURN NUMBER;

  --У�����֣�С����ǰ��λ��
  FUNCTION f_check_number(p_num         VARCHAR2,
                          p_integer_num INT,
                          p_decimal_num INT) RETURN NUMBER;

  --У�����֣�С����ǰ��λ��
  PROCEDURE p_check_number(p_num         VARCHAR2,
                           p_integer_num INT,
                           p_decimal_num INT,
                           p_desc        VARCHAR2);

  --У���ַ�����
  FUNCTION f_check_str_length(p_str VARCHAR2, p_length INT) RETURN NUMBER;

  --У���ַ�����
  PROCEDURE p_check_str_length(p_str      VARCHAR2,
                               p_str_desc VARCHAR2,
                               p_length   INT);

  --У���ַ��Ƿ�Ϊ��
  FUNCTION f_check_str_is_null(p_str VARCHAR2) RETURN NUMBER;

  --У���ַ��Ƿ�Ϊ��
  PROCEDURE p_check_str_is_null(p_str      VARCHAR2,
                                p_str_desc VARCHAR2 DEFAULT NULL,
                                p_err_msg  VARCHAR2 DEFAULT NULL);

END pkg_check_data_comm;
/
CREATE OR REPLACE PACKAGE BODY scmdata.pkg_check_data_comm IS

  /*============================================*
  * Author   : CZH55
  * Created  : 2020-09-23 10:42:29
  * ALERTER  : 
  * ALERTER_TIME  : 
  * Purpose  :  У�����֣�������С����λ��
  * Obj_Name    : F_CHECK_INTEGER
  * Arg_Number  : 2
  * PI_DATA :У���ֶ�
  * PI_TYPE :У�����ͣ�0��������1��С����λ
  *============================================*/
  FUNCTION f_check_integer(pi_data VARCHAR2, pi_type NUMBER) RETURN NUMBER IS
  BEGIN
    --У������ pi_type:0
    IF pi_type = 0 THEN
      IF regexp_like(to_char(pi_data), '^[0-9]+$') THEN
        RETURN 1;
      ELSE
        RETURN 0;
      END IF;
    ELSIF pi_type = 1 THEN
      --У��С����������λ pi_type:1
      IF regexp_like(to_char(pi_data), '^[0-9\.]+$') AND
         length(substr(pi_data,
                       instr(pi_data, '.', 1, 1) + 1,
                       length(pi_data))) = 2 THEN
        RETURN 1;
      ELSE
        RETURN 0;
      END IF;
    ELSE
      raise_application_error(-20002, '��ֵ���ʹ���');
    END IF;
  END f_check_integer;

  /*============================================*
  * Author   : SANFU
  * Created  : 2020-09-23 10:43:47
  * ALERTER  : 
  * ALERTER_TIME  : 
  * Purpose  : У���ַ�(���֣�Ӣ��)
  * Obj_Name    : F_CHECK_VARCHAR
  * Arg_Number  : 2
  * PI_DATA : У���ֶ�
  * PI_TYPE : У������ ��0���Ƿ�������ģ�1��У��Ӣ���»���
  *============================================*/

  FUNCTION f_check_varchar(pi_data VARCHAR2, pi_type NUMBER) RETURN NUMBER IS
    --v_flag NUMBER;
  BEGIN
    --У�麺�� pi_type:0
    IF pi_type = 0 THEN
      /*SELECT nvl(MAX(1), 0)
       INTO v_flag
       FROM dual
      WHERE asciistr(pi_data) LIKE '%\%'; --�ַ�����������*/
      --����+����
      IF regexp_like(to_char(pi_data),
                     unistr('^([\4e00-\9fa5]|\\��|\\��){0,}$')) THEN
        RETURN 1;
      ELSE
        RETURN 0;
      END IF;
    
    ELSIF pi_type = 1 THEN
      --У��Ӣ�� pi_type:1
      IF regexp_like(to_char(pi_data), '^[a-zA-Z_]+$') THEN
        RETURN 1;
      ELSE
        RETURN 0;
      END IF;
    ELSE
      raise_application_error(-20002, '�ַ����ʹ���');
    END IF;
  END f_check_varchar;

  /*============================================*
  * Author   : SANFU
  * Created  : 2020-09-23 10:44:57
  * ALERTER  : 
  * ALERTER_TIME  : 
  * Purpose  : У���ֻ��ţ�11λ��   1 :��ȷ  0 ��ʧ��
  * Obj_Name    : F_CHECK_PHONE
  * Arg_Number  : 1
  * PI_DATA : У���ֶ�
  *============================================*/
  FUNCTION f_check_phone(pi_data VARCHAR2) RETURN NUMBER IS
  BEGIN
    IF regexp_like(pi_data,
                   '^((13[0-9])|(14([1]|[4-9]))|(15([0-3]|[5-9]))|(16([2]|[5-7]))|(17([0-3]|[5-8]))|(18[0-9])|(19[0-9]))\d{8}$') THEN
      RETURN 1;
    ELSE
      RETURN 0;
    END IF;
  END f_check_phone;

  /*============================================*
  * Author   : SANFU
  * Created  : 2020-09-23 10:45:47
  * ALERTER  : 
  * ALERTER_TIME  : 
  * Purpose  : У�����֤��18���̶�λ����
  * Obj_Name    : F_CHECK_ID_CARD
  * Arg_Number  : 1
  * PI_DATA :У���ֶ�
  *============================================*/

  FUNCTION f_check_id_card(pi_data VARCHAR2) RETURN NUMBER IS
  BEGIN
    IF regexp_like(pi_data,
                   '^(\d{6})(\d{4})(\d{2})(\d{2})(\d{3})([0-9]|X)$') THEN
      RETURN 1;
    ELSE
      RETURN 0;
    END IF;
  END f_check_id_card;
  --5.
  /*============================================*
  * Author   : SANFU
  * Created  : 2020-09-23 10:46:28
  * ALERTER  : 
  * ALERTER_TIME  : 
  * Purpose  : У�����䣨�ַ���@�ַ���.�ַ�����
  * Obj_Name    : F_CHECK_EMAIL
  * Arg_Number  : 1
  * PI_DATA : У���ֶ�
  *============================================*/

  FUNCTION f_check_email(pi_data VARCHAR2) RETURN NUMBER IS
  BEGIN
    IF regexp_like(pi_data,
                   '^[a-zA-Z0-9_-]+@[a-zA-Z0-9_-]+(\.[a-zA-Z0-9_-]+)+$') THEN
      RETURN 1;
    ELSE
      RETURN 0;
    END IF;
  END f_check_email;

  /*============================================*
  * Author   : SANFU
  * Created  : 2020-09-23 10:47:24
  * ALERTER  : 
  * ALERTER_TIME  : 
  * Purpose  : У��ͳһ������ô��루18λ��  1 :��ȷ  0 ��ʧ��
  * Obj_Name    : F_CHECK_SOIAL_CODE
  * Arg_Number  : 1
  * PI_DATA : У���ֶ�
  *============================================*/

  FUNCTION f_check_soial_code(pi_data VARCHAR2) RETURN NUMBER IS
  BEGIN
    IF regexp_like(pi_data, '^[a-zA-Z0-9]{18}$') THEN
      RETURN 1;
    ELSE
      RETURN 0;
    END IF;
  END f_check_soial_code;

  /*============================================*
  * Author   : zwh73
  * Created  : 2020-09-23 10:43:47
  * ALERTER  : 
  * ALERTER_TIME  : 
  * Purpose  : У�鹫˾���ƣ�ֻ�������ĺ����ţ�
  * Obj_Name    : F_CHECK_VARCHAR
  * Arg_Number  : 2
  * PI_DATA : У���ֶ�
  *============================================*/

  FUNCTION f_check_logn_name(pi_data VARCHAR2) RETURN NUMBER IS
    --v_flag NUMBER;
  BEGIN
    IF regexp_like(to_char(pi_data),
                   unistr('^([\4e00-\9fa5\ff08\ff09]){1,}$')) THEN
      RETURN 1;
    ELSE
      RETURN 0;
    END IF;
  END f_check_logn_name;

  /*============================================*
  * Author   : SANFU
  * Created  : 2020-09-23 10:44:57
  * ALERTER  : 
  * ALERTER_TIME  : 
  * Purpose  : У���ֻ��ţ�11λ����������   1 :��ȷ  0 ��ʧ��
  * Obj_Name    : F_CHECK_TELANDPHONE
  * Arg_Number  : 1
  * PI_DATA : У���ֶ�
  *============================================*/
  FUNCTION f_check_telandphone(pi_data VARCHAR2) RETURN NUMBER IS
  BEGIN
    IF regexp_like(pi_data,
                   '^(((\d{3,4}-)?[0-9]{7,8})|(1(3|4|5|6|7|8|9)\d{9}))$') THEN
      RETURN 1;
    ELSE
      RETURN 0;
    END IF;
  END f_check_telandphone;

  --У�����֣�С����ǰ��λ��
  FUNCTION f_check_number(p_num         VARCHAR2,
                          p_integer_num INT,
                          p_decimal_num INT) RETURN NUMBER IS
    v_str VARCHAR2(256);
  BEGIN
    v_str := '^([0]{1}|[1-9]\d{0,' || to_char(p_integer_num - 1) ||
             '})(\.\d{1,' || to_char(p_decimal_num) || '})?$';
  
    IF regexp_like(p_num, v_str) THEN
      RETURN 1;
    ELSE
      RETURN 0;
    END IF;
  END f_check_number;

  --У�����֣�С����ǰ��λ��
  PROCEDURE p_check_number(p_num         VARCHAR2,
                           p_integer_num INT,
                           p_decimal_num INT,
                           p_desc        VARCHAR2) IS
    v_str VARCHAR2(256);
  BEGIN
    v_str := '^([0]{1}|[1-9]\d{0,' || to_char(p_integer_num - 1) ||
             '})(\.\d{1,' || to_char(p_decimal_num) || '})?$';
  
    IF regexp_like(p_num, v_str) THEN
      NULL;
    ELSE
      raise_application_error(-20002,
                              '��' || p_desc || '����֧����д' || p_integer_num ||
                              'λ��Ȼ����С�������' || p_decimal_num || 'λ�����飡');
    END IF;
  END p_check_number;

  --У���ַ�����
  FUNCTION f_check_str_length(p_str VARCHAR2, p_length INT) RETURN NUMBER IS
    v_str VARCHAR2(256);
  BEGIN
    v_str := '^.{0,' || to_char(p_length) || '}$';
  
    IF regexp_like(p_str, v_str) THEN
      RETURN 1;
    ELSE
      RETURN 0;
    END IF;
  END f_check_str_length;

  --У���ַ�����
  PROCEDURE p_check_str_length(p_str      VARCHAR2,
                               p_str_desc VARCHAR2,
                               p_length   INT) IS
    v_str VARCHAR2(256);
  BEGIN
    v_str := '^.{0,' || to_char(p_length) || '}$';
  
    IF regexp_like(p_str, v_str) THEN
      NULL;
    ELSE
      raise_application_error(-20002,
                              '��' || p_str_desc || '����֧����д' || p_length ||
                              '���ַ������飡');
    END IF;
  END p_check_str_length;

  --У���ַ��Ƿ�Ϊ��
  FUNCTION f_check_str_is_null(p_str VARCHAR2) RETURN NUMBER IS
  BEGIN
    IF TRIM(p_str) IS NULL THEN
      RETURN 1;
    ELSE
      RETURN 0;
    END IF;
  END f_check_str_is_null;

  --У���ַ��Ƿ�Ϊ��
  PROCEDURE p_check_str_is_null(p_str      VARCHAR2,
                                p_str_desc VARCHAR2 DEFAULT NULL,
                                p_err_msg  VARCHAR2 DEFAULT NULL) IS
  BEGIN
    IF TRIM(p_str) IS NULL THEN
      raise_application_error(-20002,
                              (CASE WHEN p_err_msg IS NOT NULL THEN
                               p_err_msg ELSE
                               '��' || p_str_desc || '������Ϊ�գ����飡' END));
    ELSE
      NULL;
    END IF;
  END p_check_str_is_null;

END pkg_check_data_comm;
/
