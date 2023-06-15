CREATE OR REPLACE PACKAGE SCMDATA.pkg_mock IS

  /*=============================================================================
  
     包：
       pkg_mock(模拟包)
  
     函数名:
       获取模拟字符串
  
     入参:
       v_inp_length       : 字符串生成长度
       v_inp_varstrategy  : 字符串生成策略
     
     返回值:
       varchar2 类型
  
     版本:
       2022-10-17_zc314 : 获取模拟字符串
       
  ==============================================================================*/
  FUNCTION f_get_mockstring(v_inp_length      IN NUMBER DEFAULT 1,
                            v_inp_varstrategy IN VARCHAR2) RETURN VARCHAR2;

  /*=============================================================================
  
     包：
       pkg_mock(模拟包)
  
     函数名:
       获取企业Id
  
     入参:
       v_inp_compname : 企业名称
     
     返回值:
       Varchar2 类型, 企业Id
  
     版本:
       2022-10-17_zc314 : 获取企业Id
       
  ==============================================================================*/
  FUNCTION f_get_companyid(v_inp_compname IN VARCHAR2) RETURN VARCHAR2;

  /*=============================================================================
  
     包：
       pkg_mock(模拟包)
  
     函数名:
       获取企业下员工 UserId
  
     入参:
       v_inp_compid : 企业Id
     
     返回值:
       Varchar2 类型, UserId
  
     版本:
       2022-10-17_zc314 : 获取企业下员工 UserId
       
  ==============================================================================*/
  FUNCTION f_get_mockcompanyuserid(v_inp_compid IN VARCHAR2) RETURN VARCHAR2;

  /*=============================================================================
  
     包：
       pkg_mock(模拟包)
  
     函数名:
       获取随机订单号
  
     入参:
       v_inp_compid : 企业Id
     
     返回值:
       Varchar2 类型, 订单号
  
     版本:
       2022-10-17_zc314 : 获取随机订单号
       
  ==============================================================================*/
  FUNCTION f_get_orderid(v_inp_compid IN VARCHAR2) RETURN VARCHAR2;

  /*=============================================================================
  
     包：
       pkg_qa_mock(模拟数据包)
  
     函数名:
       根据状态+条数获取特定数量的 Asnid
  
     入参:
       v_inp_asnstatus  : Asn状态
       v_inp_asnnumber  : 获取 Asn数量
       v_inp_compid     : 企业id
       
     版本:
       2022-10-18_zc314 : 根据状态+条数获取特定数量的 Asnid
       
  ==============================================================================*/
  FUNCTION f_get_asnidsbystatus(v_inp_asnstatus IN VARCHAR2 DEFAULT 'PC',
                                v_inp_asnnumber IN NUMBER DEFAULT 1,
                                v_inp_compid    IN VARCHAR2) RETURN CLOB;

  /*=============================================================================
  
     包：
       pkg_mock(模拟包)
  
     函数名:
       获取已存在订单号
  
     入参:
       v_inp_length       : 字符串生成长度
       v_inp_varstrategy  : 字符串生成策略
     
     返回值:
       varchar2 类型
  
     版本:
       2022-10-17_zc314 : 获取已存在订单号
       
  ==============================================================================*/
  FUNCTION f_get_mockordid(v_inp_compname IN VARCHAR2) RETURN VARCHAR2;

  /*=============================================================================
  
     包：
       pkg_mock(模拟包)
  
     函数名:
       返回随机字典值
  
     入参:
       v_inp_groupdictname : 字典名称
     
     返回值:
       Varchar2 类型, 订单号
  
     版本:
       2022-10-17_zc314 : 返回随机字典值
       
  ==============================================================================*/
  FUNCTION f_get_mockgroupdicval(v_inp_groupdictname IN VARCHAR2)
    RETURN VARCHAR2;

  /*=============================================================================
  
     包：
       pkg_mock(模拟包)
  
     函数名:
       获取模拟数字
  
     入参:
       v_inp_length : 数字生成长度
     
     返回值:
       Number 类型
  
     版本:
       2022-10-17_zc314 : 获取模拟数字
       
  ==============================================================================*/
  FUNCTION f_get_randomnum(v_inp_length IN NUMBER) RETURN NUMBER;

  /*=============================================================================
  
     包：
       pkg_mock(模拟包)
  
     函数名:
       获取模拟数字
  
     入参:
       v_inp_length       : 数字生成长度
       v_inp_numstrategy  : 字符串生成策略
     
     返回值:
       Number 类型
  
     版本:
       2022-10-17_zc314 : 获取模拟数字
       
  ==============================================================================*/
  FUNCTION f_get_mocknumber(v_inp_length      IN NUMBER DEFAULT 1,
                            v_inp_numstrategy IN VARCHAR2) RETURN NUMBER;

  /*=============================================================================
  
     包：
       pkg_mock(模拟包)
  
     函数名:
       获取模拟日期
  
     入参:
       v_inp_min          : 下限值
       v_inp_max          : 上限值
       v_inp_datestrategy : 日期生成策略
     
     返回值:
       Date 类型
  
     版本:
       2022-10-17_zc314 : 获取模拟日期
       
  ==============================================================================*/
  FUNCTION f_get_mockdate(v_inp_min          IN NUMBER DEFAULT 1,
                          v_inp_max          IN NUMBER DEFAULT 10,
                          v_inp_datestrategy IN VARCHAR2) RETURN DATE;

  /*=============================================================================
    
     包：
       pkg_mock(模拟包)
    
     函数名:
       模拟从分隔符字符串中提取值
    
     入参:
       v_inp_fields     :  带分隔符的字符串
       v_inp_seperator  :  分隔符
       
     返回值:
       Varchar2 类型
    
     版本:
       2022-10-24_zc314 : 模拟从分隔符字符串中提取值
         
  ==============================================================================*/
  FUNCTION f_get_mockrandomvalinfields(v_inp_fields    IN VARCHAR2,
                                       v_inp_seperator IN VARCHAR2)
    RETURN VARCHAR2;

  /*=============================================================================
  
     包：
       pkg_qa_mock(模拟数据包)
  
     过程名:
       根据表从属+表名获取打印输出字段
  
     入参:
       v_inp_owner  :  表从属
       v_inp_table  :  表名
  
     版本:
       2022-10-17_ZC314 : 根据表从属+表名获取打印输出字段
       
  ==============================================================================*/
  FUNCTION f_get_printfields(v_inp_owner IN VARCHAR2,
                             v_inp_table IN VARCHAR2) RETURN CLOB;

  /*=============================================================================
  
     包：
       pkg_qa_mock(模拟数据包)
  
     过程名:
       根据表从属+表名+条件语句获取打印数据语句
  
     入参:
       v_inp_owner  :  表从属
       v_inp_table  :  表名
  
     版本:
       2022-10-17_ZC314 : 根据表从属+表名+条件语句获取打印数据语句
       
  ==============================================================================*/
  FUNCTION f_get_printsql(v_inp_owner IN VARCHAR2,
                          v_inp_table IN VARCHAR2,
                          v_inp_cond  IN VARCHAR2) RETURN CLOB;

  /*=============================================================================
  
     包：
       pkg_qa_mock(模拟数据包)
  
     过程名:
       根据表从属+表名+条件语句打印数据
  
     入参:
       v_inp_owner  :  表从属
       v_inp_table  :  表名
  
     版本:
       2022-10-17_ZC314 : 根据表从属+表名+条件语句获取打印数据语句
       
  ==============================================================================*/
  PROCEDURE p_get_printdata(v_inp_owner IN VARCHAR2,
                            v_inp_table IN VARCHAR2,
                            v_inp_cond  IN VARCHAR2);

  /*=============================================================================
  
     包：
       pkg_qa_mock(模拟数据包)
  
     过程名:
       打印分隔行
  
     入参:
       v_inp_sperateinfo : 分隔信息
  
     版本:
       2022-10-17_ZC314 : 打印分隔行
       
  ==============================================================================*/
  PROCEDURE p_get_sperateline(v_inp_sperateinfo IN VARCHAR2);

END pkg_mock;
/

CREATE OR REPLACE PACKAGE BODY SCMDATA.pkg_mock IS

  /*=============================================================================
  
     包：
       pkg_mock(模拟包)
  
     函数名:
       获取模拟字符串
  
     入参:
       v_inp_length       : 字符串生成长度
       v_inp_varstrategy  : 字符串生成策略
     
     返回值:
       varchar2 类型
  
     版本:
       2022-10-17_zc314 : 获取模拟字符串
       
  ==============================================================================*/
  FUNCTION f_get_mockstring(v_inp_length      IN NUMBER DEFAULT 1,
                            v_inp_varstrategy IN VARCHAR2) RETURN VARCHAR2 IS
    v_nullstrategy   CONSTANT VARCHAR2(32) := 'NULL';
    v_randomstrategy CONSTANT VARCHAR2(32) := 'RANDOM';
    v_retvarchar2 VARCHAR2(4000);
  BEGIN
    --入参非空校验
    IF v_inp_length IS NULL OR v_inp_varstrategy IS NULL THEN
      --为空报错
      raise_application_error(-20002,
                              'scmdata.pkg_mock.f_get_mockstring, 入参存在空值' ||
                              chr(10) || 'v_inp_length: ' || v_inp_length ||
                              chr(10) || 'v_inp_varstrategy: ' ||
                              v_inp_varstrategy);
    ELSE
      --长度控制
      IF v_inp_length > 4000 THEN
        raise_application_error(-20002, '入参长度应小于最大允许长度4000！');
      END IF;
    
      --非空生成
      IF v_inp_varstrategy = v_nullstrategy THEN
        --空值策略赋值为空
        v_retvarchar2 := NULL;
      ELSIF v_inp_varstrategy = v_randomstrategy THEN
        --非随机值策略根据输入长度赋值
        FOR i IN 1 .. v_inp_length LOOP
          v_retvarchar2 := scmdata.f_sentence_append_rc(v_sentence   => v_retvarchar2,
                                                        v_appendstr  => CHR(64 +
                                                                            TRUNC(dbms_random.value(1,
                                                                                                    24))),
                                                        v_middliestr => '');
        END LOOP;
      ELSE
        --非允许策略，报错
        raise_application_error(-20002,
                                'scmdata.pkg_mock.f_get_string, 不存在输入的生成策略' ||
                                chr(10) || 'v_inp_varstrategy: ' ||
                                v_inp_varstrategy);
      END IF;
    END IF;
  
    --返回模拟字符串
    RETURN v_retvarchar2;
  END f_get_mockstring;

  /*=============================================================================
  
     包：
       pkg_mock(模拟包)
  
     函数名:
       获取企业Id
  
     入参:
       v_inp_compname : 企业名称
     
     返回值:
       Varchar2 类型, 企业Id
  
     版本:
       2022-10-17_zc314 : 获取企业Id
       
  ==============================================================================*/
  FUNCTION f_get_companyid(v_inp_compname IN VARCHAR2) RETURN VARCHAR2 IS
    v_compid VARCHAR2(32);
  BEGIN
    --根据企业名称获取企业Id
    SELECT MAX(company_id)
      INTO v_compid
      FROM scmdata.sys_company
     WHERE company_name = v_inp_compname;
  
    --返回对应企业Id
    RETURN v_compid;
  END f_get_companyid;

  /*=============================================================================
  
     包：
       pkg_mock(模拟包)
  
     函数名:
       获取企业下员工 UserId
  
     入参:
       v_inp_compid : 企业Id
     
     返回值:
       Varchar2 类型, UserId
  
     版本:
       2022-10-17_zc314 : 获取企业下员工 UserId
       
  ==============================================================================*/
  FUNCTION f_get_mockcompanyuserid(v_inp_compid IN VARCHAR2) RETURN VARCHAR2 IS
    v_totalnum  NUMBER(16);
    v_randomnum NUMBER(16);
    v_retuserid VARCHAR2(32);
  BEGIN
    --
    SELECT COUNT(1)
      INTO v_totalnum
      FROM scmdata.sys_company_user
     WHERE company_id = v_inp_compid;
  
    IF v_randomnum < 1 THEN
      raise_application_error(-20002,
                              '该企业下员工人数少于1人，不能获取 user_id！');
    ELSE
      v_randomnum := TRUNC(dbms_random.value(1, v_totalnum));
    END IF;
  
    SELECT MAX(user_id)
      INTO v_retuserid
      FROM (SELECT user_id, ROWNUM rn
              FROM scmdata.sys_company_user
             WHERE company_id = v_inp_compid)
     WHERE rn = v_randomnum;
  
    RETURN v_retuserid;
  END f_get_mockcompanyuserid;

  /*=============================================================================
  
     包：
       pkg_mock(模拟包)
  
     函数名:
       获取随机订单号
  
     入参:
       v_inp_compid : 企业Id
     
     返回值:
       Varchar2 类型, 订单号
  
     版本:
       2022-10-17_zc314 : 获取随机订单号
       
  ==============================================================================*/
  FUNCTION f_get_orderid(v_inp_compid IN VARCHAR2) RETURN VARCHAR2 IS
    v_ordid     VARCHAR2(32);
    v_maxnum    NUMBER(16);
    v_randomnum NUMBER(16);
  BEGIN
    --获取企业订单条数
    SELECT COUNT(1)
      INTO v_maxnum
      FROM scmdata.t_ordered
     WHERE company_id = v_inp_compid;
  
    --生成随机值
    v_randomnum := trunc(dbms_random.value(0, v_maxnum)) + 1;
  
    --获取订单id
    SELECT MAX(order_code)
      INTO v_ordid
      FROM (SELECT order_code, ROWNUM rn
              FROM scmdata.t_ordered
             WHERE company_id = v_inp_compid
             ORDER BY create_time DESC)
     WHERE rn = v_randomnum;
  
    --返回随机订单Id
    RETURN v_ordid;
  END f_get_orderid;

  /*=============================================================================
  
     包：
       pkg_qa_mock(模拟数据包)
  
     函数名:
       根据状态+条数获取特定数量的 Asnid
  
     入参:
       v_inp_asnstatus  : Asn状态
       v_inp_asnnumber  : 获取 Asn数量
       v_inp_compid     : 企业id
       
     版本:
       2022-10-18_zc314 : 根据状态+条数获取特定数量的 Asnid
       
  ==============================================================================*/
  FUNCTION f_get_asnidsbystatus(v_inp_asnstatus IN VARCHAR2 DEFAULT 'PC',
                                v_inp_asnnumber IN NUMBER DEFAULT 1,
                                v_inp_compid    IN VARCHAR2) RETURN CLOB IS
    v_asnids CLOB;
  BEGIN
    SELECT listagg(asn_id, ';')
      INTO v_asnids
      FROM (SELECT asn_id
              FROM scmdata.t_asnordered
             WHERE upper(status) = upper(v_inp_asnstatus)
               AND company_id = v_inp_compid
             ORDER BY asn_id
             FETCH FIRST v_inp_asnnumber ROWS ONLY);
  
    RETURN v_asnids;
  END f_get_asnidsbystatus;

  /*=============================================================================
  
     包：
       pkg_mock(模拟包)
  
     函数名:
       获取已存在订单号
  
     入参:
       v_inp_length       : 字符串生成长度
       v_inp_varstrategy  : 字符串生成策略
     
     返回值:
       varchar2 类型
  
     版本:
       2022-10-17_zc314 : 获取已存在订单号
       
  ==============================================================================*/
  FUNCTION f_get_mockordid(v_inp_compname IN VARCHAR2) RETURN VARCHAR2 IS
    v_compid VARCHAR2(32);
    v_ordid  VARCHAR2(32);
  BEGIN
    --输入企业名称不为空判定
    IF v_inp_compname IS NULL THEN
      --输入企业名称为空报错
      raise_application_error(-20002, '输入企业名称不能为空！');
    ELSE
      --获取企业Id
      v_compid := f_get_companyid(v_inp_compname => v_inp_compname);
    
      --判定获取企业Id不为空
      IF v_compid IS NULL THEN
        --企业Id为空报错
        raise_application_error(-20002, '输入企业名称不存在于系统中！');
      ELSE
        --获取订单Id
        v_ordid := f_get_orderid(v_inp_compid => v_compid);
      END IF;
    END IF;
  
    --获取订单Id 判空
    IF v_ordid IS NULL THEN
      --获取订单Id 为空报错
      raise_application_error(-20002, '未能获取到订单号');
    END IF;
  
    --返回订单Id
    RETURN v_ordid;
  END f_get_mockordid;

  /*=============================================================================
  
     包：
       pkg_mock(模拟包)
  
     函数名:
       返回随机字典值
  
     入参:
       v_inp_groupdictname : 字典名称
     
     返回值:
       Varchar2 类型, 订单号
  
     版本:
       2022-10-17_zc314 : 返回随机字典值
       
  ==============================================================================*/
  FUNCTION f_get_mockgroupdicval(v_inp_groupdictname IN VARCHAR2)
    RETURN VARCHAR2 IS
    v_groupdictval VARCHAR2(32);
    v_maxnum       NUMBER(16);
    v_randomnum    NUMBER(16);
  BEGIN
    --获取字典值条数
    SELECT COUNT(1)
      INTO v_maxnum
      FROM scmdata.sys_group_dict dic
     WHERE EXISTS (SELECT 1
              FROM scmdata.sys_group_dict
             WHERE GROUP_dict_name = v_inp_groupdictname
               AND group_dict_value = dic.group_dict_type);
  
    --字典条数判断
    IF v_maxnum = 0 THEN
      --字典条数=0，报错
      raise_application_error(-20002, '输入字典名称未找到对应字典值！');
    END IF;
  
    --生成随机值
    v_randomnum := trunc(dbms_random.value(0, v_maxnum)) + 1;
  
    --获取字典值
    SELECT MAX(group_dict_value)
      INTO v_groupdictval
      FROM (SELECT group_dict_value, ROWNUM rn
              FROM scmdata.sys_group_dict dic1
             WHERE EXISTS
             (SELECT 1
                      FROM scmdata.sys_group_dict
                     WHERE GROUP_dict_name = v_inp_groupdictname
                       AND group_dict_value = dic1.group_dict_type))
     WHERE rn = v_randomnum;
  
    --返回随机订单Id
    RETURN v_groupdictval;
  END f_get_mockgroupdicval;

  /*=============================================================================
  
     包：
       pkg_mock(模拟包)
  
     函数名:
       获取模拟数字
  
     入参:
       v_inp_length : 数字生成长度
     
     返回值:
       Number 类型
  
     版本:
       2022-10-17_zc314 : 获取模拟数字
       
  ==============================================================================*/
  FUNCTION f_get_randomnum(v_inp_length IN NUMBER) RETURN NUMBER IS
    v_tmpnum NUMBER(16);
    v_retnum NUMBER(16);
  BEGIN
    --正值赋值策略--根据输入长度赋正值
    FOR i IN 1 .. v_inp_length LOOP
      --临时数据变量赋值
      v_tmpnum := TRUNC(dbms_random.value(1, 10));
    
      --返回值赋值
      IF v_retnum IS NULL THEN
        IF v_tmpnum = 10 THEN
          v_retnum := 0;
        ELSE
          v_retnum := v_tmpnum;
        END IF;
      ELSE
        IF v_tmpnum = 10 THEN
          v_retnum := v_retnum * 10;
        ELSE
          v_retnum := v_retnum * 10 + v_tmpnum;
        END IF;
      END IF;
    END LOOP;
  
    --返回，返回值
    RETURN v_retnum;
  END f_get_randomnum;

  /*=============================================================================
  
     包：
       pkg_mock(模拟包)
  
     函数名:
       获取模拟数字
  
     入参:
       v_inp_length       : 数字生成长度
       v_inp_numstrategy  : 字符串生成策略
     
     返回值:
       Number 类型
  
     版本:
       2022-10-17_zc314 : 获取模拟数字
       
  ==============================================================================*/
  FUNCTION f_get_mocknumber(v_inp_length      IN NUMBER DEFAULT 1,
                            v_inp_numstrategy IN VARCHAR2) RETURN NUMBER IS
    v_positivestrategy CONSTANT VARCHAR2(32) := 'POSITIVE';
    v_negativestrategy CONSTANT VARCHAR2(32) := 'NAGATIVE';
    v_zerostrategy     CONSTANT VARCHAR2(32) := 'ZERO';
    v_nullstrategy     CONSTANT VARCHAR2(32) := 'NULL';
    v_retnum NUMBER(16);
  BEGIN
    --策略非空校验
    IF v_inp_length IS NULL OR v_inp_numstrategy IS NULL THEN
      --为空报错
      raise_application_error(-20002,
                              'scmdata.pkg_mock.f_get_mocknumber, 策略不能为空' ||
                              chr(10) || 'v_inp_numstrategy: ' ||
                              v_inp_numstrategy);
    ELSE
      --长度控制
      IF v_inp_length > 16 THEN
        raise_application_error(-20002, '入参长度应小于最大允许长度16！');
      END IF;
    
      --非空生成
      IF v_inp_numstrategy = v_nullstrategy THEN
        --空值策略赋值为空
        v_retnum := NULL;
      ELSIF v_inp_numstrategy = v_zerostrategy THEN
        --零值策略赋值为0
        v_retnum := 0;
      ELSIF v_inp_numstrategy = v_positivestrategy THEN
        --正值赋值策略--根据输入长度赋正值
        v_retnum := f_get_randomnum(v_inp_length => v_inp_length);
      ELSIF v_inp_numstrategy = v_negativestrategy THEN
        --正值赋值策略--根据输入长度赋正值
        v_retnum := f_get_randomnum(v_inp_length => v_inp_length) * -1;
      ELSE
        --非允许策略，报错
        raise_application_error(-20002,
                                'scmdata.pkg_mock.f_get_string, 不存在输入的生成策略' ||
                                chr(10) || 'v_inp_numstrategy: ' ||
                                v_inp_numstrategy);
      END IF;
    END IF;
  
    --返回模拟数字
    RETURN v_retnum;
  END f_get_mocknumber;

  /*=============================================================================
  
     包：
       pkg_mock(模拟包)
  
     函数名:
       获取模拟日期
  
     入参:
       v_inp_min          : 下限值
       v_inp_max          : 上限值
       v_inp_datestrategy : 日期生成策略
     
     返回值:
       Date 类型
  
     版本:
       2022-10-17_zc314 : 获取模拟日期
       
  ==============================================================================*/
  FUNCTION f_get_mockdate(v_inp_min          IN NUMBER DEFAULT 1,
                          v_inp_max          IN NUMBER DEFAULT 10,
                          v_inp_datestrategy IN VARCHAR2) RETURN DATE IS
    v_nullstrategy             CONSTANT VARCHAR2(32) := 'NULL';
    v_todaystrategy            CONSTANT VARCHAR2(32) := 'TODAY';
    v_greaterthentodaystrategy CONSTANT VARCHAR2(32) := 'GREATER THAN TODAY';
    v_smallerthentodaystrategy CONSTANT VARCHAR2(32) := 'LESS THAN TODAY';
    v_retdate DATE;
  BEGIN
    --入参校验
    IF v_inp_datestrategy IS NULL THEN
      --策略为空报错
      raise_application_error(-20002,
                              'scmdata.pkg_mock.f_get_mockdate, 入参存在空值' ||
                              chr(10) || 'v_inp_datestrategy: ' ||
                              v_inp_datestrategy);
    ELSIF v_inp_min >= v_inp_max THEN
      --下限大于上限报错
      raise_application_error(-20002,
                              'scmdata.pkg_mock.f_get_mockdate, 入参下限大于上限' ||
                              chr(10) || 'v_inp_min: ' || v_inp_min ||
                              chr(10) || 'v_inp_max: ' || v_inp_max);
    ELSIF v_inp_min >= 300 OR v_inp_max >= 300 THEN
      --上下限大于最大值报错
      raise_application_error(-20002,
                              'scmdata.pkg_mock.f_get_mockdate, 入参大于最大值300' ||
                              chr(10) || 'v_inp_min: ' || v_inp_min ||
                              chr(10) || 'v_inp_max: ' || v_inp_max);
    ELSE
      --空值策略
      IF v_inp_datestrategy = v_nullstrategy THEN
        --空值策略赋值为空
        v_retdate := NULL;
      
        --当前日策略
      ELSIF v_inp_datestrategy = v_todaystrategy THEN
        --当前日策略赋值为今天
        v_retdate := SYSDATE;
      
        --大于当前日策略
      ELSIF v_inp_datestrategy = v_greaterthentodaystrategy THEN
        --大于当前日策略--赋值为当前时间+限定上下限的值
        v_retdate := SYSDATE + dbms_random.value(v_inp_min, v_inp_max);
      
        --小于当前日策略
      ELSIF v_inp_datestrategy = v_smallerthentodaystrategy THEN
        --小于当前日策略--赋值为当前时间-限定上下限的值
        v_retdate := SYSDATE - dbms_random.value(v_inp_min, v_inp_max);
      
      ELSE
        --非允许策略，报错
        raise_application_error(-20002,
                                'scmdata.pkg_mock.f_get_string, 不存在输入的生成策略' ||
                                chr(10) || 'v_inp_datestrategy: ' ||
                                v_inp_datestrategy);
      
      END IF;
    END IF;
  
    --返回日期值
    RETURN v_retdate;
  END f_get_mockdate;

  /*=============================================================================
    
     包：
       pkg_mock(模拟包)
    
     函数名:
       模拟从分隔符字符串中提取值
    
     入参:
       v_inp_fields     :  带分隔符的字符串
       v_inp_seperator  :  分隔符
       
     返回值:
       Varchar2 类型
    
     版本:
       2022-10-24_zc314 : 模拟从分隔符字符串中提取值
         
  ==============================================================================*/
  FUNCTION f_get_mockrandomvalinfields(v_inp_fields    IN VARCHAR2,
                                       v_inp_seperator IN VARCHAR2)
    RETURN VARCHAR2 IS
    v_count     NUMBER(16);
    v_randomnum NUMBER(16);
    v_result    VARCHAR2(32);
  BEGIN
    --获取输入字符串内分隔符数量
    v_count := regexp_count(v_inp_fields, v_inp_seperator) - 1;
  
    --通过分隔符生成随机数
    v_randomnum := TRUNC(dbms_random.value(0, v_count + 1));
  
    --dbms_random.value 最大整数/最小整数取到机率低的解决方案
    IF v_randomnum = 0 OR v_randomnum = v_count + 1 THEN
      v_randomnum := 1;
    END IF;
  
    --结果赋值
    v_result := SUBSTR(v_inp_fields,
                       INSTR(v_inp_fields, v_inp_seperator, 1, v_randomnum) + 1,
                       INSTR(v_inp_fields,
                             v_inp_seperator,
                             1,
                             v_randomnum + 1) -
                       INSTR(v_inp_fields, v_inp_seperator, 1, v_randomnum) - 1);
  
    --返回结果           
    RETURN v_result;
  END f_get_mockrandomvalinfields;

  /*=============================================================================
  
     包：
       pkg_qa_mock(模拟数据包)
  
     过程名:
       根据表从属+表名获取打印输出字段
  
     入参:
       v_inp_owner  :  表从属
       v_inp_table  :  表名
  
     版本:
       2022-10-17_ZC314 : 根据表从属+表名获取打印输出字段
       
  ==============================================================================*/
  FUNCTION f_get_printfields(v_inp_owner IN VARCHAR2,
                             v_inp_table IN VARCHAR2) RETURN CLOB IS
    v_corestr CLOB;
  BEGIN
    FOR i IN (SELECT column_name, data_type
                FROM All_Tab_Columns
               WHERE upper(owner) = upper(v_inp_owner)
                 AND upper(table_name) = upper(v_inp_table)
               ORDER BY column_name) LOOP
      IF i.data_type = 'VARCHAR2' OR i.data_type = 'CLOB' THEN
        v_corestr := scmdata.f_sentence_append_rc(v_sentence   => v_corestr,
                                                  v_appendstr  => '''' ||
                                                                  i.column_name ||
                                                                  ':''||I.' ||
                                                                  i.column_name ||
                                                                  '||chr(10)' || '',
                                                  v_middliestr => '||');
      ELSIF i.data_type = 'NUMBER' THEN
        v_corestr := scmdata.f_sentence_append_rc(v_sentence   => v_corestr,
                                                  v_appendstr  => '''' ||
                                                                  i.column_name ||
                                                                  ':''||TO_CHAR(I.' ||
                                                                  i.column_name ||
                                                                  ')||chr(10)' || '',
                                                  v_middliestr => '||');
      ELSIF i.data_type = 'DATE' THEN
        v_corestr := scmdata.f_sentence_append_rc(v_sentence   => v_corestr,
                                                  v_appendstr  => '''' ||
                                                                  i.column_name ||
                                                                  ':''||TO_CHAR(I.' ||
                                                                  i.column_name ||
                                                                  ',''yyyy-mm-dd hh24:mi:ss'')||chr(10)' || '',
                                                  v_middliestr => '||');
      END IF;
    END LOOP;
    RETURN v_corestr || chr(10);
  END f_get_printfields;

  /*=============================================================================
  
     包：
       pkg_qa_mock(模拟数据包)
  
     过程名:
       根据表从属+表名+条件语句获取打印数据语句
  
     入参:
       v_inp_owner  :  表从属
       v_inp_table  :  表名
  
     版本:
       2022-10-17_ZC314 : 根据表从属+表名+条件语句获取打印数据语句
       
  ==============================================================================*/
  FUNCTION f_get_printsql(v_inp_owner IN VARCHAR2,
                          v_inp_table IN VARCHAR2,
                          v_inp_cond  IN VARCHAR2) RETURN CLOB IS
    v_sql           CLOB;
    v_fieldscombine CLOB;
  BEGIN
    v_fieldscombine := f_get_printfields(v_inp_owner => v_inp_owner,
                                         v_inp_table => v_inp_table);
    v_sql           := q'^DECLARE BEGIN FOR I IN (SELECT * FROM ^' ||
                       v_inp_owner || q'^.^' || v_inp_table || q'^ WHERE ^' ||
                       v_inp_cond || q'^) LOOP DBMS_OUTPUT.PUT_LINE(^' ||
                       v_fieldscombine || q'^); END LOOP; END;^';
  
    RETURN v_sql;
  END f_get_printsql;

  /*=============================================================================
  
     包：
       pkg_qa_mock(模拟数据包)
  
     过程名:
       根据表从属+表名+条件语句打印数据
  
     入参:
       v_inp_owner  :  表从属
       v_inp_table  :  表名
  
     版本:
       2022-10-17_ZC314 : 根据表从属+表名+条件语句获取打印数据语句
       
  ==============================================================================*/
  PROCEDURE p_get_printdata(v_inp_owner IN VARCHAR2,
                            v_inp_table IN VARCHAR2,
                            v_inp_cond  IN VARCHAR2) IS
    v_sql CLOB;
  BEGIN
    v_sql := f_get_printsql(v_inp_owner => v_inp_owner,
                            v_inp_table => v_inp_table,
                            v_inp_cond  => v_inp_cond);
  
    EXECUTE IMMEDIATE v_sql;
  END p_get_printdata;

  /*=============================================================================
  
     包：
       pkg_qa_mock(模拟数据包)
  
     过程名:
       打印分隔行
  
     入参:
       v_inp_sperateinfo : 分隔信息
  
     版本:
       2022-10-17_ZC314 : 打印分隔行
       
  ==============================================================================*/
  PROCEDURE p_get_sperateline(v_inp_sperateinfo IN VARCHAR2) IS
  
  BEGIN
    dbms_output.put_line('==' || v_inp_sperateinfo ||
                         '=================================================================================');
  END p_get_sperateline;

END pkg_mock;
/

