CREATE OR REPLACE PACKAGE SCMDATA.PKG_COMMON_CHECK IS

  /*===================================================================================

    CommonCheckLogic
    通用校验——供应商

    入参:
      V_SUPCODE  :  供应商编码
      V_COMPID   :  企业Id
      V_ERRINFO  :  错误信息

    出参:
      CLOB类型的错误信息

    版本:
      2022-08-10 : 通用校验——供应商

  ===================================================================================*/
  PROCEDURE P_COMM_CHECK_SUPCODE(V_SUPCODE  IN VARCHAR2,
                                 V_COMPID   IN VARCHAR2,
                                 V_ERRINFO  IN OUT CLOB);

  /*===================================================================================

    CommonCheckLogic
    通用校验——分类

    入参:
      V_CATE     :  分类Id
      V_COMPID   :  企业Id
      V_ERRINFO  :  错误信息

    出参:
      CLOB类型的错误信息

    版本:
      2022-08-10 : 通用校验——分类

  ===================================================================================*/
  PROCEDURE P_COMM_CHECK_CATE(V_CATE     IN VARCHAR2,
                              V_ERRINFO  IN OUT CLOB);

  /*===================================================================================

    CommonCheckLogic
    通用校验——生产分类

    入参:
      V_PROCATE  :  生产分类Id
      V_CATE     :  分类Id
      V_COMPID   :  企业Id
      V_ERRINFO  :  错误信息

    出参:
      CLOB类型的错误信息

    版本:
      2022-08-10 : 通用校验——生产分类

  ===================================================================================*/
  PROCEDURE P_COMM_CHECK_PROCATE(V_PROCATE  IN VARCHAR2,
                                 V_CATE     IN VARCHAR2,
                                 V_ERRINFO  IN OUT CLOB);

  /*===================================================================================

    CommonCheckLogic
    通用校验——产品子类

    入参:
      V_SUBCATE  :  产品子类Id
      V_PROCATE  :  生产分类Id
      V_COMPID   :  企业Id
      V_ERRINFO  :  错误信息

    出参:
      CLOB类型的错误信息

    版本:
      2022-08-10 : 通用校验——分类

  ===================================================================================*/
  PROCEDURE P_COMM_CHECK_SUBCATE(V_SUBCATE  IN VARCHAR2,
                                 V_PROCATE  IN VARCHAR2,
                                 V_COMPID   IN VARCHAR2,
                                 V_ERRINFO  IN OUT CLOB);



END PKG_COMMON_CHECK;
/

CREATE OR REPLACE PACKAGE BODY SCMDATA.PKG_COMMON_CHECK IS

  /*===================================================================================

    CommonCheckLogic
    通用校验——供应商

    入参:
      V_SUPCODE  :  供应商编码
      V_COMPID   :  企业Id
      V_ERRINFO  :  错误信息

    出参:
      CLOB类型的错误信息

    版本:
      2022-08-10 : 通用校验——供应商

  ===================================================================================*/
  PROCEDURE P_COMM_CHECK_SUPCODE(V_SUPCODE  IN VARCHAR2,
                                 V_COMPID   IN VARCHAR2,
                                 V_ERRINFO  IN OUT CLOB) IS
    V_JUGNUM  NUMBER(1);
  BEGIN
    IF V_SUPCODE IS NULL THEN
      V_ERRINFO := SCMDATA.F_SENTENCE_APPEND_RC(V_SENTENCE   => V_ERRINFO,
                                                V_APPENDSTR  => '供应商编码不能为空',
                                                V_MIDDLIESTR => CHR(10));
    ELSE
      SELECT COUNT(1)
        INTO V_JUGNUM
        FROM SCMDATA.T_SUPPLIER_INFO
       WHERE SUPPLIER_CODE = V_SUPCODE
         AND COMPANY_ID = V_COMPID
         AND ROWNUM = 1;

      IF V_JUGNUM = 0 THEN
        V_ERRINFO := SCMDATA.F_SENTENCE_APPEND_RC(V_SENTENCE   => V_ERRINFO,
                                                  V_APPENDSTR  => '供应商编码不存在于供应商档案中',
                                                  V_MIDDLIESTR => CHR(10));
      END IF;
    END IF;
  END P_COMM_CHECK_SUPCODE;



  /*===================================================================================

    CommonCheckLogic
    通用校验——分类

    入参:
      V_CATE     :  分类Id
      V_COMPID   :  企业Id
      V_ERRINFO  :  错误信息

    出参:
      CLOB类型的错误信息

    版本:
      2022-08-10 : 通用校验——分类

  ===================================================================================*/
  PROCEDURE P_COMM_CHECK_CATE(V_CATE     IN VARCHAR2,
                              V_ERRINFO  IN OUT CLOB) IS
    V_JUGNUM  NUMBER(1);
  BEGIN
    IF V_CATE IS NULL THEN
      V_ERRINFO := SCMDATA.F_SENTENCE_APPEND_RC(V_SENTENCE   => V_ERRINFO,
                                                V_APPENDSTR  => '分类不能为空',
                                                V_MIDDLIESTR => CHR(10));
    ELSE
      SELECT COUNT(1)
        INTO V_JUGNUM
        FROM SCMDATA.SYS_GROUP_DICT
       WHERE GROUP_DICT_VALUE = V_CATE
         AND GROUP_DICT_TYPE = 'PRODUCT_TYPE'
         AND ROWNUM = 1;

      IF V_JUGNUM = 0 THEN
        V_ERRINFO := SCMDATA.F_SENTENCE_APPEND_RC(V_SENTENCE   => V_ERRINFO,
                                                  V_APPENDSTR  => '分类不存在于字典中',
                                                  V_MIDDLIESTR => CHR(10));
      END IF;
    END IF;
  END P_COMM_CHECK_CATE;



  /*===================================================================================

    CommonCheckLogic
    通用校验——生产分类

    入参:
      V_PROCATE  :  生产分类Id
      V_CATE     :  分类Id
      V_COMPID   :  企业Id
      V_ERRINFO  :  错误信息

    出参:
      CLOB类型的错误信息

    版本:
      2022-08-10 : 通用校验——生产分类

  ===================================================================================*/
  PROCEDURE P_COMM_CHECK_PROCATE(V_PROCATE  IN VARCHAR2,
                                 V_CATE     IN VARCHAR2,
                                 V_ERRINFO  IN OUT CLOB) IS
    V_JUGNUM  NUMBER(1);
  BEGIN
    IF V_PROCATE IS NULL THEN
      V_ERRINFO := SCMDATA.F_SENTENCE_APPEND_RC(V_SENTENCE   => V_ERRINFO,
                                                V_APPENDSTR  => '生产分类不能为空',
                                                V_MIDDLIESTR => CHR(10));

    ELSE
      SELECT COUNT(1)
        INTO V_JUGNUM
        FROM SCMDATA.SYS_GROUP_DICT
       WHERE GROUP_DICT_VALUE = V_PROCATE
         AND GROUP_DICT_TYPE = V_CATE
         AND ROWNUM = 1;

      IF V_JUGNUM = 0 THEN
        V_ERRINFO := SCMDATA.F_SENTENCE_APPEND_RC(V_SENTENCE   => V_ERRINFO,
                                                  V_APPENDSTR  => '生产分类不存在于字典中',
                                                  V_MIDDLIESTR => CHR(10));
      END IF;
    END IF;
  END P_COMM_CHECK_PROCATE;



  /*===================================================================================

    CommonCheckLogic
    通用校验——产品子类

    入参:
      V_SUBCATE  :  产品子类Id
      V_PROCATE  :  生产分类Id
      V_COMPID   :  企业Id
      V_ERRINFO  :  错误信息

    出参:
      CLOB类型的错误信息

    版本:
      2022-08-10 : 通用校验——分类

  ===================================================================================*/
  PROCEDURE P_COMM_CHECK_SUBCATE(V_SUBCATE  IN VARCHAR2,
                                 V_PROCATE  IN VARCHAR2,
                                 V_COMPID   IN VARCHAR2,
                                 V_ERRINFO  IN OUT CLOB) IS
    V_JUGNUM  NUMBER(1);
  BEGIN
    IF V_SUBCATE IS NULL THEN
      V_ERRINFO := SCMDATA.F_SENTENCE_APPEND_RC(V_SENTENCE   => V_ERRINFO,
                                                V_APPENDSTR  => '产品子类不能为空',
                                                V_MIDDLIESTR => CHR(10));
    ELSE
      SELECT COUNT(1)
        INTO V_JUGNUM
        FROM SCMDATA.SYS_COMPANY_DICT
       WHERE COMPANY_DICT_VALUE = V_SUBCATE
         AND COMPANY_DICT_TYPE = V_PROCATE
         AND COMPANY_ID = V_COMPID
         AND ROWNUM = 1;

      IF V_JUGNUM = 0 THEN
        V_ERRINFO := SCMDATA.F_SENTENCE_APPEND_RC(V_SENTENCE   => V_ERRINFO,
                                                  V_APPENDSTR  => '产品子类不存在于字典中',
                                                  V_MIDDLIESTR => CHR(10));
      END IF;
    END IF;
  END P_COMM_CHECK_SUBCATE;

END PKG_COMMON_CHECK;
/

