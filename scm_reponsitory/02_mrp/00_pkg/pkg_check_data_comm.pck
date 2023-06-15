CREATE OR REPLACE PACKAGE MRP.pkg_check_data_comm IS

  -- Author  : CZH55
  -- Created : 2020/9/22 16:23:15
  -- Purpose : 校验数据-通用
  FUNCTION f_check_integer(pi_data VARCHAR2, pi_type NUMBER) RETURN NUMBER;

  FUNCTION f_check_varchar(pi_data VARCHAR2, pi_type NUMBER) RETURN NUMBER;

  FUNCTION f_check_phone(pi_data VARCHAR2) RETURN NUMBER;

  FUNCTION f_check_id_card(pi_data VARCHAR2) RETURN NUMBER;

  FUNCTION f_check_email(pi_data VARCHAR2) RETURN NUMBER;

  FUNCTION f_check_soial_code(pi_data VARCHAR2) RETURN NUMBER;

  FUNCTION f_check_logn_name(pi_data VARCHAR2) RETURN NUMBER;

  FUNCTION f_check_telandphone(pi_data VARCHAR2) RETURN NUMBER;

  /*=========================================================*
  * Author        : 
  * Created_Time  : 2023-05-31 09:58:31
  * Alerter       : 
  * Alerter_Time  : 
  * Purpose       : 校验数字，小数点前后位数
  * Obj_Name      : F_CHECK_NUMBER
  * Arg_Number    : 3
  * < IN PARAMS > : 3
  * P_NUM         : 需校验的数字
  * P_INTEGER_NUM : 整数位数
  * P_DECIMAL_NUM : 小数位数
  *=========================================================*/
  FUNCTION f_check_number(p_num         VARCHAR2,
                          p_integer_num INT,
                          p_decimal_num INT) RETURN NUMBER;

  --校验数字，小数点前后位数
  PROCEDURE p_check_number(p_num         VARCHAR2,
                           p_integer_num INT,
                           p_decimal_num INT,
                           p_desc        VARCHAR2);

  /*=========================================================*
  * Author        : CZH55
  * Created_Time  : 2023-05-31 10:05:20
  * Alerter       : 
  * Alerter_Time  : 
  * Purpose       : 校验字符长度
  * Obj_Name      : F_CHECK_STR_LENGTH
  * Arg_Number    : 2
  * < IN PARAMS > : 2
  * P_STR         : 需校验的字符串
  * P_LENGTH      : 字符长度
  *=========================================================*/
  FUNCTION f_check_str_length(p_str VARCHAR2, p_length INT) RETURN NUMBER;

  /*=========================================================*
  * Author        : CZH55
  * Created_Time  : 2023-05-31 10:05:22
  * Alerter       : 
  * Alerter_Time  : 
  * Purpose       : 校验字符长度
  * Obj_Name      : P_CHECK_STR_LENGTH
  * Arg_Number    : 3
  * < IN PARAMS > : 3
  * P_STR         : 需校验的字符串
  * P_STR_DESC    : 字段描述
  * P_LENGTH      : 字符长度
  *=========================================================*/
  PROCEDURE p_check_str_length(p_str      VARCHAR2,
                               p_str_desc VARCHAR2,
                               p_length   INT);

  /*=========================================================*
  * Author        : CZH55
  * Created_Time  : 2023-05-31 10:05:20
  * Alerter       : 
  * Alerter_Time  : 
  * Purpose       : 校验字符是否为空
  * Obj_Name      : F_CHECK_STR_IS_NULL
  * Arg_Number    : 1
  * < IN PARAMS > : 1
  * P_STR         : 需校验的字符串
  *=========================================================*/
  FUNCTION f_check_str_is_null(p_str VARCHAR2) RETURN NUMBER;

  /*=========================================================*
  * Author        : CZH55
  * Created_Time  : 2023-05-31 10:05:22
  * Alerter       : 
  * Alerter_Time  : 
  * Purpose       : 
  * Obj_Name      : 校验字符是否为空
  * Arg_Number    : 3
  * < IN PARAMS > : 3
  * P_STR         : 需校验的字符串
  * P_STR_DESC    : 字段描述
  * P_ERR_MSG     : 自定义错误提示
  *=========================================================*/
  PROCEDURE p_check_str_is_null(p_str      VARCHAR2,
                                p_str_desc VARCHAR2 DEFAULT NULL,
                                p_err_msg  VARCHAR2 DEFAULT NULL);

END pkg_check_data_comm;
/

CREATE OR REPLACE PACKAGE BODY MRP.pkg_check_data_comm IS

  /*============================================*
  * Author   : CZH55
  * Created  : 2020-09-23 10:42:29
  * ALERTER  : 
  * ALERTER_TIME  : 
  * Purpose  :  校验数字（整数，小数两位）
  * Obj_Name    : F_CHECK_INTEGER
  * Arg_Number  : 2
  * PI_DATA :校验字段
  * PI_TYPE :校验类型，0：整数，1：小数两位
  *============================================*/
  FUNCTION f_check_integer(pi_data VARCHAR2, pi_type NUMBER) RETURN NUMBER IS
  BEGIN
    --校验整数 pi_type:0
    IF pi_type = 0 THEN
      IF regexp_like(to_char(pi_data), '^[0-9]+$') THEN
        RETURN 1;
      ELSE
        RETURN 0;
      END IF;
    ELSIF pi_type = 1 THEN
      --校验小数，保留两位 pi_type:1
      IF regexp_like(to_char(pi_data), '^[0-9\.]+$') AND
         length(substr(pi_data,
                       instr(pi_data, '.', 1, 1) + 1,
                       length(pi_data))) = 2 THEN
        RETURN 1;
      ELSE
        RETURN 0;
      END IF;
    ELSE
      raise_application_error(-20002, '数值类型错误！');
    END IF;
  END f_check_integer;

  /*============================================*
  * Author   : SANFU
  * Created  : 2020-09-23 10:43:47
  * ALERTER  : 
  * ALERTER_TIME  : 
  * Purpose  : 校验字符(汉字，英文)
  * Obj_Name    : F_CHECK_VARCHAR
  * Arg_Number  : 2
  * PI_DATA : 校验字段
  * PI_TYPE : 校验类型 ，0：是否包含中文，1：校验英文下划线
  *============================================*/

  FUNCTION f_check_varchar(pi_data VARCHAR2, pi_type NUMBER) RETURN NUMBER IS
    --v_flag NUMBER;
  BEGIN
    --校验汉字 pi_type:0
    IF pi_type = 0 THEN
      /*SELECT nvl(MAX(1), 0)
       INTO v_flag
       FROM dual
      WHERE asciistr(pi_data) LIKE '%\%'; --字符串包含中文*/
      --中文+括号
      IF regexp_like(to_char(pi_data),
                     unistr('^([\4e00-\9fa5]|\\（|\\）){0,}$')) THEN
        RETURN 1;
      ELSE
        RETURN 0;
      END IF;
    
    ELSIF pi_type = 1 THEN
      --校验英文 pi_type:1
      IF regexp_like(to_char(pi_data), '^[a-zA-Z_]+$') THEN
        RETURN 1;
      ELSE
        RETURN 0;
      END IF;
    ELSE
      raise_application_error(-20002, '字符类型错误！');
    END IF;
  END f_check_varchar;

  /*============================================*
  * Author   : SANFU
  * Created  : 2020-09-23 10:44:57
  * ALERTER  : 
  * ALERTER_TIME  : 
  * Purpose  : 校验手机号（11位）   1 :正确  0 ：失败
  * Obj_Name    : F_CHECK_PHONE
  * Arg_Number  : 1
  * PI_DATA : 校验字段
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
  * Purpose  : 校验身份证（18，固定位数）
  * Obj_Name    : F_CHECK_ID_CARD
  * Arg_Number  : 1
  * PI_DATA :校验字段
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
  * Purpose  : 校验邮箱（字符串@字符串.字符串）
  * Obj_Name    : F_CHECK_EMAIL
  * Arg_Number  : 1
  * PI_DATA : 校验字段
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
  * Purpose  : 校验统一社会信用代码（18位）  1 :正确  0 ：失败
  * Obj_Name    : F_CHECK_SOIAL_CODE
  * Arg_Number  : 1
  * PI_DATA : 校验字段
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
  * Purpose  : 校验公司名称（只包含中文和括号）
  * Obj_Name    : F_CHECK_VARCHAR
  * Arg_Number  : 2
  * PI_DATA : 校验字段
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
  * Purpose  : 校验手机号（11位）或座机号   1 :正确  0 ：失败
  * Obj_Name    : F_CHECK_TELANDPHONE
  * Arg_Number  : 1
  * PI_DATA : 校验字段
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

  /*=========================================================*
  * Author        : CZH55
  * Created_Time  : 2023-05-31 09:58:31
  * Alerter       : 
  * Alerter_Time  : 
  * Purpose       : 校验数字，小数点前后位数
  * Obj_Name      : F_CHECK_NUMBER
  * Arg_Number    : 3
  * < IN PARAMS > : 3
  * P_NUM         : 需校验的数字
  * P_INTEGER_NUM : 整数位数
  * P_DECIMAL_NUM : 小数位数
  *=========================================================*/
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

  /*=========================================================*
  * Author        : CZH55
  * Created_Time  : 2023-05-31 10:01:19
  * Alerter       : 
  * Alerter_Time  : 
  * Purpose       : 校验数字，小数点前后位数
  * Obj_Name      : P_CHECK_NUMBER
  * Arg_Number    : 4
  * < IN PARAMS > : 4
  * P_NUM         : 需校验的数字
  * P_INTEGER_NUM : 整数位数
  * P_DECIMAL_NUM : 小数位数
  * P_DESC        : 字段描述
  *=========================================================*/
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
                              '【' || p_desc || '】仅支持填写' || p_integer_num ||
                              '位自然数，小数允许后' || p_decimal_num || '位，请检查！');
    END IF;
  END p_check_number;

  /*=========================================================*
  * Author        : CZH55
  * Created_Time  : 2023-05-31 10:05:20
  * Alerter       : 
  * Alerter_Time  : 
  * Purpose       : 校验字符长度
  * Obj_Name      : F_CHECK_STR_LENGTH
  * Arg_Number    : 2
  * < IN PARAMS > : 2
  * P_STR         : 需校验的字符串
  * P_LENGTH      : 字符长度
  *=========================================================*/
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

  /*=========================================================*
  * Author        : CZH55
  * Created_Time  : 2023-05-31 10:05:22
  * Alerter       : 
  * Alerter_Time  : 
  * Purpose       : 校验字符长度
  * Obj_Name      : P_CHECK_STR_LENGTH
  * Arg_Number    : 3
  * < IN PARAMS > : 3
  * P_STR         : 需校验的字符串
  * P_STR_DESC    : 字段描述
  * P_LENGTH      : 字符长度
  *=========================================================*/
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
                              '【' || p_str_desc || '】仅支持填写' || p_length ||
                              '个字符，请检查！');
    END IF;
  END p_check_str_length;

  /*=========================================================*
  * Author        : CZH55
  * Created_Time  : 2023-05-31 10:05:20
  * Alerter       : 
  * Alerter_Time  : 
  * Purpose       : 校验字符是否为空
  * Obj_Name      : F_CHECK_STR_IS_NULL
  * Arg_Number    : 1
  * < IN PARAMS > : 1
  * P_STR         : 需校验的字符串
  *=========================================================*/
  FUNCTION f_check_str_is_null(p_str VARCHAR2) RETURN NUMBER IS
  BEGIN
    IF TRIM(p_str) IS NULL THEN
      RETURN 1;
    ELSE
      RETURN 0;
    END IF;
  END f_check_str_is_null;

  /*=========================================================*
  * Author        : CZH55
  * Created_Time  : 2023-05-31 10:05:22
  * Alerter       : 
  * Alerter_Time  : 
  * Purpose       : 
  * Obj_Name      : 校验字符是否为空
  * Arg_Number    : 3
  * < IN PARAMS > : 3
  * P_STR         : 需校验的字符串
  * P_STR_DESC    : 字段描述
  * P_ERR_MSG     : 自定义错误提示
  *=========================================================*/
  PROCEDURE p_check_str_is_null(p_str      VARCHAR2,
                                p_str_desc VARCHAR2 DEFAULT NULL,
                                p_err_msg  VARCHAR2 DEFAULT NULL) IS
  BEGIN
    IF TRIM(p_str) IS NULL THEN
      raise_application_error(-20002,
                              (CASE WHEN p_err_msg IS NOT NULL THEN
                               p_err_msg ELSE
                               '【' || p_str_desc || '】不可为空，请检查！' END));
    ELSE
      NULL;
    END IF;
  END p_check_str_is_null;

END pkg_check_data_comm;
/

