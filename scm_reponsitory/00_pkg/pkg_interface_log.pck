CREATE OR REPLACE PACKAGE SCMDATA.PKG_INTERFACE_LOG IS

  /*=================================================================================

    商品档案 goo_id 通用校验

    用途：
      用于校验参数 V_INGOODID 是否存在于 Scm 商品档案中

    参数：
      V_INGOODID ：用于校验的商品档案编码（GOO_ID)
      V_INCOMPID : 用于校验的企业Id

    返回值：
      NUMBER类型：1存在，0不存在

    版本：
      2021-10-18 : 该函数已固定

  =================================================================================*/
  FUNCTION F_CHECK_GOOD_COMMODITY_EXIST(V_INGOODID   IN VARCHAR2,
                                        V_INCOMPID   IN VARCHAR2) RETURN NUMBER;


  /*=================================================================================

    商品档案 rela_goo_id 通用校验

    用途：
      用于校验参数 V_INRELAGOOID 是否存在于 Scm 商品档案中

    参数：
      V_INRELAGOOID ：用于校验的关联货号（RELA_GOO_ID）
      V_INCOMPID    : 用于校验的企业Id

    返回值：
      NUMBER类型：1存在，0不存在

    版本：
      2021-10-18 : 该函数已固定

  =================================================================================*/
  FUNCTION F_CHECK_RELAGOOD_COMMODITY_EXIST(V_INRELAGOOID   IN VARCHAR2,
                                            V_INCOMPID      IN VARCHAR2) RETURN NUMBER;


  /*=================================================================================

    供应商档案 supplier_code 通用校验

    用途：
      用于校验参数 V_INSUPCODE 是否存在于 Scm 供应商档案中

    参数：
      V_INSUPCODE   ：用于校验的供应商编号（SUPPLIER_CODE）
      V_INCOMPID    : 用于校验的企业Id

    返回值：
      NUMBER类型：1存在，0不存在

    版本：
      2021-10-18 : 该函数已固定

  =================================================================================*/
  FUNCTION F_CHECK_SUPCODE_EXIST(V_INSUPCODE   IN VARCHAR2,
                                 V_INCOMPID    IN VARCHAR2) RETURN NUMBER;


  /*=================================================================================

    供应商档案 inside_supplier_code 通用校验

    用途：
      用于校验参数 V_INISDSUPCODE 是否存在于 Scm 供应商档案中

    参数：
      V_INISDSUPCODE ：用于校验的内部供应商编号（INSIDE_SUPPLIER_CODE）
      V_INCOMPID    : 用于校验的企业Id

    返回值：
      NUMBER类型：1存在，0不存在

    版本：
      2021-10-18 : 该函数已固定

  =================================================================================*/
  FUNCTION F_CHECK_ISDSUPCODE_EXIST(V_INISDSUPCODE   IN VARCHAR2,
                                    V_INCOMPID       IN VARCHAR2) RETURN NUMBER;


  /*=================================================================================

   商品档案校验并生成校验错误信息

   用途：
     用于校验商品档案中是否存在该 V_GOOID，
     存在返回GOO_ID, 不存在返回错误信息

   参数：
     V_GOOID  ：用于校验的商品档案编码（GOO_ID)
     V_COMPID : 用于校验的企业Id

   返回值：
     正确返回值格式：21000001
     错误返回值格式：“错误信息:V_GOOID不存在于商品档案中”

   版本：
      2021-10-18 : 该函数已实现正确时返回商品档案编号，错误时返回错误信息，
                   后续如果对错误信息有修改，请保留错误返回中的“错误信息”字段

  =================================================================================*/
  FUNCTION F_CHECK_GOOD_AND_GENERATE_ERRINFO(V_GOOID  IN VARCHAR2,
                                             V_COMPID IN VARCHAR2) RETURN VARCHAR2;



  /*=================================================================================

   供应商档案校验并生成校验错误信息

   用途：
     用于校验参数 V_SUPPLIER_CODE 是否存在于 Scm 供应商档案中
     存在供应商档案，返回SUPPLIER_CODE,
     不存在供应商档案，返回错误信息

   参数：
     V_SUPPLIER_CODE ：用于校验的供应商编号（SUPPLIER_CODE）
     V_INCOMPID      : 用于校验的企业Id

   返回值：
     正确返回值格式：C00001
     错误返回值格式：“错误信息:V_SUPPLIER_CODE不存在于商品档案中”

   版本：
      2021-10-18 : 该函数已实现正确时返回供应商档案编号，错误时返回错误信息，
                   后续如果对错误信息有修改，请保留错误返回中的“错误信息”字段

  =================================================================================*/
  FUNCTION F_CHECK_SUPPLIER_AND_GENERATE_ERRINFO(V_SUPPLIER_CODE  IN VARCHAR2,
                                                 V_COMPID         IN VARCHAR2) RETURN VARCHAR2;


  /*=================================================================================

   变量初始化

   变量说明
     SSNUM    : 成功数
     RTNUM    : 执行失败数
     RTIDS    : 执行失败id值
     RTDETAIL : 执行失败具体信息
     CKNUM    : 校验失败数
     CKIDS    : 校验失败id值
     CKDETAIL : 校验失败具体信息

   用途：
     当 V_EOBJID 不存在变量:
        变量初始化，接口日志表没有值
     当 V_EOBJID 存在变量:
       变量最后更新时间未超过 V_MINUTE 分钟——变量值保留，接口日志表没有值
     当 V_EOBJID 存在变量：
       变量最后更新时间超过 V_MINUTE 分钟——变量值初始化，接口日志表插入1条数据

   参数：
     V_EOBJID  : 执行对象id，有可能是action，也有可能是item
     V_COMPID  : 企业Id
     V_MINUTE  : 分钟数，建议设置为 1

   版本：
      2021-10-18 : 该过程已固定

  =================================================================================*/
  PROCEDURE P_INSERT_INFO_AND_INIT_VARIABLE(V_EOBJID     IN VARCHAR2,
                                            V_COMPID    IN VARCHAR2,
                                            V_MINUTE    IN NUMBER);


  /*=================================================================================

   取出接口相关的变量

   变量说明
     V_SSNUM    : 成功数
     V_RTNUM    : 执行失败数
     V_RTIDS    : 执行失败id值
     V_RTDETAIL : 执行失败具体信息
     V_CKNUM    : 校验失败数
     V_CKIDS    : 校验失败id值
     V_CKDETAIL : 校验失败具体信息

   用途：
     取出 SYS_ACTION.ELEMENT_ID = V_EOBJID接口相关变量

   版本：
      2021-10-18 : 该过程已固定

  =================================================================================*/
  PROCEDURE P_GET_PORT_VARIABLE(V_EOBJID     IN VARCHAR2,
                                V_COMPID    IN VARCHAR2,
                                V_SSNUM     IN OUT NUMBER,
                                V_RTNUM     IN OUT NUMBER,
                                V_RTIDS     IN OUT CLOB,
                                V_RTDETAIL  IN OUT CLOB,
                                V_CKNUM     IN OUT NUMBER,
                                V_CKIDS     IN OUT CLOB,
                                V_CKDETAIL  IN OUT CLOB);



  /*=================================================================================

    更新接口相关变量

    用途：
      更新接口相关变量，用于记录成功、校验失败，运行失败相关变量

    入参：
      V_EOBJID  : 执行对象id，有可能是action，也有可能是item
      V_COMPID  : 企业Id
      V_UNQVAL  : 唯一列值，用于RTIDS、CKIDS记录ID
      V_ERRINFO : 错误信息
      V_MODE    : 错误模式 RE-执行错误 CE-校验错误

    版本：
      2021-10-16 : 从 PKG_VARIABLE 移动到 PKG_ASN_INTERFACE
      2021-10-18 : 该过程已固定

  =================================================================================*/
  PROCEDURE P_UPDATE_INTERFACE_VARIABLE(V_EOBJID   IN VARCHAR2,
                                        V_COMPID  IN VARCHAR2,
                                        V_UNQVAL  IN VARCHAR2,
                                        V_ERRINFO IN VARCHAR2,
                                        V_MODE    IN VARCHAR2);



  /*=================================================================================

   生成执行错误信息

   用途：
     用于生成执行错误信息

   参数：
     V_TAB      ：错误发生表
     V_UNQCOLS  : 错误发生唯一列
     V_UNQVALS  ：错误发生唯一值
     V_ERRSTACK ：错误栈
     V_ERRSQL   ：执行错误sql

   返回值：
     格式：
       错误表:V_TAB
       错误时间:YYYY-MM-DD HH24-MI-SS
       错误唯一列:V_UNQCOLS
       错误唯一值:V_UNQVALS
       错误信息:V_ERRSTACK
       错误sql:V_ERRSQL

   版本：
      2021-10-18 : 该过程已固定

  =================================================================================*/
  FUNCTION F_GENERATE_RUNTIME_ERRINFO(V_TAB            IN VARCHAR2,
                                      V_UNQCOLS        IN VARCHAR2,
                                      V_UNQVALS        IN VARCHAR2,
                                      V_ERRSTACK       IN VARCHAR2,
                                      V_ERRSQL         IN VARCHAR2) RETURN VARCHAR2;



  /*====================================================================================================

    执行错误处理逻辑

    说明：
      用于执行错误处理，当执行错误后，记录错误时间，错误唯一列，
      错误接口和错误SQL，并记入接口变量，待后续生成日志

    入参：
      V_EOBJID  : 执行对象Id，有可能是action，也有可能是item
      V_COMPID  : 执行企业Id
      V_TAB     : 接口表
      V_ERRSQL  : 执行错误SQL
      V_UNQCOLS : 执行错误列
      V_UNQVALS : 执行错误值
      V_ST      : 执行错误信息

    版本：
      2021-10-17 : 整合接口错误处理逻辑为 P_ITF_RUNTIME_ERROR_LOGIC
      2021-10-18 : 作为基本的条件语句拼接功能已完成，后续如果再增加新的数据类型，
                   直接在函数的 IF...ELSE 中添加对应逻辑，另，本函数待完善部分为：
                   当数据类型选择为空时，应增加数据字典插入/更新逻辑

  ====================================================================================================*/
  PROCEDURE P_ITF_RUNTIME_ERROR_LOGIC(V_EOBJID   IN VARCHAR2,
                                      V_COMPID   IN VARCHAR2,
                                      V_TAB      IN VARCHAR2,
                                      V_ERRSQL   IN CLOB,
                                      V_UNQCOLS  IN VARCHAR2,
                                      V_UNQVALS  IN VARCHAR2,
                                      V_ST       IN VARCHAR2);



  /*=================================================================================

    生成条件语句

    用途：
      依据输入参数生成对应的条件语句

    参数：
      V_TAB     ：表名
      V_COL     : 列名，不支持多列
      V_VAL     : 列值，不支持多值
                  日期/时间格式：YYYY-MM-DD HH24-MI-SS 否则会报错
      V_CONDSTR : 外部条件语句，用于拼接

    返回值:
      NUMBER类型：1存在，0不存在

    版本:
      2021-10-18 : 作为基本的条件语句拼接功能已完成，后续如果再增加新的数据类型，
                   直接在函数的 IF...ELSE 中添加对应逻辑，另，本函数待完善部分为：
                   当数据类型选择为空时，应增加数据字典插入/更新逻辑

  =================================================================================*/
  FUNCTION F_GET_CONDSTR(V_TAB     IN VARCHAR2,
                         V_COL     IN VARCHAR2,
                         V_VAL     IN VARCHAR2,
                         V_CONDSTR IN VARCHAR2) RETURN VARCHAR2;


  /*=================================================================================

    值是否存在于某表通用校验

    用途：
      用于校验参数 V_INRELAGOOID 是否存在于 Scm 商品档案中

    参数：
      V_TAB  ：表名
      V_COLS : 列名，支持多列，用逗号隔开
      V_VALS : 列值，支持多值，用逗号隔开，
              日期/时间格式：YYYY-MM-DD HH24-MI-SS 否则会报错

    返回值：
      NUMBER类型：1存在，0不存在

    版本:
      2021-10-18: 该函数已固定

  =================================================================================*/
  FUNCTION F_CHECK_EXISTS_BY_COND(V_TAB   IN VARCHAR2,
                                  V_COLS  IN VARCHAR2,
                                  V_VALS  IN VARCHAR2) RETURN NUMBER;


  /*=================================================================================

    ACTION 动态生成/更新

    用途：
      使用接口配置表内字段值，动态生成/更新action

    参数：
      V_ITFLGID ：通用接口日志配置表主键

    版本:
      2021-10-18 : 该过程已固定

  =================================================================================*/
  PROCEDURE P_GEN_OR_UPD_ACTION(V_ITFLGID  IN VARCHAR2);



  /*=================================================================================

    动态生成/更新定时任务

    用途：
      用于配置处动态生成/更新定时任务

    参数：
      V_ITFLGID ：通用接口日志配置表主键
      V_CUID    : 当前操作人id

    版本:
      2021-10-18 : 该过程已固定

  =================================================================================*/
  PROCEDURE P_GEN_OR_UPD_XXLJOB(V_ITFLGID  IN VARCHAR2,
                                V_CUID     IN VARCHAR2);

END PKG_INTERFACE_LOG;
/

CREATE OR REPLACE PACKAGE BODY SCMDATA.PKG_INTERFACE_LOG IS

  /*=================================================================================

    商品档案 goo_id 通用校验

    用途：
      用于校验参数 V_INGOODID 是否存在于 Scm 商品档案中

    参数：
      V_INGOODID ：用于校验的商品档案编码（GOO_ID)
      V_INCOMPID : 用于校验的企业Id

    返回值：
      NUMBER类型：1存在，0不存在

    版本：
      2021-10-18 : 该函数已固定

  =================================================================================*/
  FUNCTION F_CHECK_GOOD_COMMODITY_EXIST(V_INGOODID   IN VARCHAR2,
                                        V_INCOMPID   IN VARCHAR2) RETURN NUMBER IS
    V_RETNUM     NUMBER(1);
  BEGIN
    SELECT COUNT(1)
      INTO V_RETNUM
      FROM SCMDATA.T_COMMODITY_INFO
     WHERE GOO_ID = V_INGOODID
       AND COMPANY_ID = V_INCOMPID
       AND ROWNUM = 1;
    RETURN V_RETNUM;
  END F_CHECK_GOOD_COMMODITY_EXIST;



  /*=================================================================================

    商品档案 rela_goo_id 通用校验

    用途：
      用于校验参数 V_INRELAGOOID 是否存在于 Scm 商品档案中

    参数：
      V_INRELAGOOID ：用于校验的关联货号（RELA_GOO_ID）
      V_INCOMPID    : 用于校验的企业Id

    返回值：
      NUMBER类型：1存在，0不存在

    版本：
      2021-10-18 : 该函数已固定

  =================================================================================*/
  FUNCTION F_CHECK_RELAGOOD_COMMODITY_EXIST(V_INRELAGOOID   IN VARCHAR2,
                                            V_INCOMPID      IN VARCHAR2) RETURN NUMBER IS
    V_RETNUM     NUMBER(1);
  BEGIN
    SELECT COUNT(1)
      INTO V_RETNUM
      FROM SCMDATA.T_COMMODITY_INFO
     WHERE RELA_GOO_ID = V_INRELAGOOID
       AND COMPANY_ID = V_INCOMPID
       AND ROWNUM = 1;
    RETURN V_RETNUM;
  END F_CHECK_RELAGOOD_COMMODITY_EXIST;



  /*=================================================================================

    供应商档案 supplier_code 通用校验

    用途：
      用于校验参数 V_INSUPCODE 是否存在于 Scm 供应商档案中

    参数：
      V_INSUPCODE   ：用于校验的供应商编号（SUPPLIER_CODE）
      V_INCOMPID    : 用于校验的企业Id

    返回值：
      NUMBER类型：1存在，0不存在

    版本：
      2021-10-18 : 该函数已固定

  =================================================================================*/
  FUNCTION F_CHECK_SUPCODE_EXIST(V_INSUPCODE   IN VARCHAR2,
                                 V_INCOMPID    IN VARCHAR2) RETURN NUMBER IS
    V_RETNUM     NUMBER(1);
  BEGIN
    SELECT COUNT(1)
      INTO V_RETNUM
      FROM SCMDATA.T_SUPPLIER_INFO
     WHERE SUPPLIER_CODE = V_INSUPCODE
       AND COMPANY_ID = V_INCOMPID
       AND ROWNUM = 1;
    RETURN V_RETNUM;
  END F_CHECK_SUPCODE_EXIST;




  /*=================================================================================

    供应商档案 inside_supplier_code 通用校验

    用途：
      用于校验参数 V_INISDSUPCODE 是否存在于 Scm 供应商档案中

    参数：
      V_INISDSUPCODE ：用于校验的内部供应商编号（INSIDE_SUPPLIER_CODE）
      V_INCOMPID    : 用于校验的企业Id

    返回值：
      NUMBER类型：1存在，0不存在

    版本：
      2021-10-18 : 该函数已固定

  =================================================================================*/
  FUNCTION F_CHECK_ISDSUPCODE_EXIST(V_INISDSUPCODE   IN VARCHAR2,
                                    V_INCOMPID       IN VARCHAR2) RETURN NUMBER IS
    V_RETNUM     NUMBER(1);
  BEGIN
    SELECT COUNT(1)
      INTO V_RETNUM
      FROM SCMDATA.T_SUPPLIER_INFO
     WHERE INSIDE_SUPPLIER_CODE = V_INISDSUPCODE
       AND COMPANY_ID = V_INCOMPID
       AND ROWNUM = 1;
    RETURN V_RETNUM;
  END F_CHECK_ISDSUPCODE_EXIST;



  /*=================================================================================

   商品档案校验并生成校验错误信息

   用途：
     用于校验商品档案中是否存在该 V_GOOID，
     存在返回GOO_ID, 不存在返回错误信息

   参数：
     V_GOOID  ：用于校验的商品档案编码（GOO_ID)
     V_COMPID : 用于校验的企业Id

   返回值：
     正确返回值格式：21000001
     错误返回值格式：“错误信息:V_GOOID不存在于商品档案中”

   版本：
      2021-10-18 : 该函数已实现正确时返回商品档案编号，错误时返回错误信息，
                   后续如果对错误信息有修改，请保留错误返回中的“错误信息”字段

  =================================================================================*/
  FUNCTION F_CHECK_GOOD_AND_GENERATE_ERRINFO(V_GOOID  IN VARCHAR2,
                                             V_COMPID IN VARCHAR2) RETURN VARCHAR2 IS
    V_JUGNUM NUMBER(1);
    V_RETMSG VARCHAR2(512);
  BEGIN
    SELECT COUNT(1),MAX(GOO_ID)
      INTO V_JUGNUM,V_RETMSG
      FROM SCMDATA.T_COMMODITY_INFO
     WHERE RELA_GOO_ID = V_GOOID
       AND COMPANY_ID = V_COMPID
       AND ROWNUM = 1;

    IF V_JUGNUM = 0 THEN
      V_RETMSG := '错误信息:'||V_GOOID||'不存在于商品档案中'||CHR(10);
    END IF;
    RETURN V_RETMSG;
  END F_CHECK_GOOD_AND_GENERATE_ERRINFO;


  /*=================================================================================

   供应商档案校验并生成校验错误信息

   用途：
     用于校验参数 V_SUPPLIER_CODE 是否存在于 Scm 供应商档案中
     存在供应商档案，返回SUPPLIER_CODE,
     不存在供应商档案，返回错误信息

   参数：
     V_SUPPLIER_CODE ：用于校验的供应商编号（SUPPLIER_CODE）
     V_INCOMPID      : 用于校验的企业Id

   返回值：
     正确返回值格式：C00001
     错误返回值格式：“错误信息:V_SUPPLIER_CODE不存在于商品档案中”

   版本：
      2021-10-18 : 该函数已实现正确时返回供应商档案编号，错误时返回错误信息，
                   后续如果对错误信息有修改，请保留错误返回中的“错误信息”字段

  =================================================================================*/
  FUNCTION F_CHECK_SUPPLIER_AND_GENERATE_ERRINFO(V_SUPPLIER_CODE  IN VARCHAR2,
                                                 V_COMPID         IN VARCHAR2) RETURN VARCHAR2 IS
    V_JUGNUM NUMBER(1);
    V_RETMSG VARCHAR2(512);
  BEGIN
    SELECT COUNT(1),MAX(SUPPLIER_CODE)
      INTO V_JUGNUM,V_RETMSG
      FROM SCMDATA.T_SUPPLIER_INFO
     WHERE INSIDE_SUPPLIER_CODE = V_SUPPLIER_CODE
       AND COMPANY_ID = V_COMPID
       AND ROWNUM = 1;

    IF V_JUGNUM = 0 THEN
      V_RETMSG := '错误信息:'||V_SUPPLIER_CODE||'不存在于供应商档案中'||CHR(10);
    END IF;
    RETURN V_RETMSG;
  END F_CHECK_SUPPLIER_AND_GENERATE_ERRINFO;



  /*=================================================================================

   变量初始化

   变量说明
     SSNUM    : 成功数
     RTNUM    : 执行失败数
     RTIDS    : 执行失败id值
     RTDETAIL : 执行失败具体信息
     CKNUM    : 校验失败数
     CKIDS    : 校验失败id值
     CKDETAIL : 校验失败具体信息

   用途：
     当 V_EOBJID 不存在变量:
        变量初始化，接口日志表没有值
     当 V_EOBJID 存在变量:
       变量最后更新时间未超过 V_MINUTE 分钟——变量值保留，接口日志表没有值
     当 V_EOBJID 存在变量：
       变量最后更新时间超过 V_MINUTE 分钟——变量值初始化，接口日志表插入1条数据

   参数：
     V_EOBJID  : 执行对象id，有可能是action，也有可能是item
     V_COMPID  : 企业Id
     V_MINUTE  : 分钟数，建议设置为 1

   版本：
      2021-10-18 : 该过程已固定

  =================================================================================*/
  PROCEDURE P_INSERT_INFO_AND_INIT_VARIABLE(V_EOBJID    IN VARCHAR2,
                                            V_COMPID    IN VARCHAR2,
                                            V_MINUTE    IN NUMBER) IS
    V_JUGNUM       NUMBER(4);
    V_MAXUPDTIME   DATE;
    V_EXESQL       VARCHAR2(512);
    V_SSNUM        NUMBER(8);
    V_RTNUM        NUMBER(8);
    V_RTIDS        CLOB;
    V_RTDETAIL     CLOB;
    V_CKNUM        NUMBER(8);
    V_CKIDS        CLOB;
    V_CKDETAIL     CLOB;
  BEGIN
    SELECT COUNT(1),MAX(LAST_UPDTIME)
      INTO V_JUGNUM,V_MAXUPDTIME
      FROM SCMDATA.T_VARIABLE
     WHERE OBJ_ID = V_EOBJID
       AND COMPANY_ID = V_COMPID;

    IF V_JUGNUM = 0 THEN
      V_EXESQL := 'INSERT INTO SCMDATA.T_VARIABLE '||
                  '(OBJ_ID,COMPANY_ID,VAR_NAME,VAR_TYPE,VAR_NUMBER)'||
                  'VALUES (:A,:B,:C,:D,:E)';
      EXECUTE IMMEDIATE V_EXESQL USING V_EOBJID,V_COMPID,'SSNUM','NUMBER',0;
      EXECUTE IMMEDIATE V_EXESQL USING V_EOBJID,V_COMPID,'RTNUM','NUMBER',0;
      EXECUTE IMMEDIATE V_EXESQL USING V_EOBJID,V_COMPID,'CKNUM','NUMBER',0;
      V_EXESQL := 'INSERT INTO SCMDATA.T_VARIABLE '||
                  '(OBJ_ID,COMPANY_ID,VAR_NAME,VAR_TYPE,VAR_CLOB)'||
                  'VALUES (:A,:B,:C,:D,:E)';
      EXECUTE IMMEDIATE V_EXESQL USING V_EOBJID,V_COMPID,'RTIDS','CLOB','';
      EXECUTE IMMEDIATE V_EXESQL USING V_EOBJID,V_COMPID,'RTDETAIL','CLOB','';
      EXECUTE IMMEDIATE V_EXESQL USING V_EOBJID,V_COMPID,'CKIDS','CLOB','';
      EXECUTE IMMEDIATE V_EXESQL USING V_EOBJID,V_COMPID,'CKDETAIL','CLOB','';
    ELSE
      IF V_MAXUPDTIME < SYSDATE - (V_MINUTE/(60*24)) THEN
        --取数
        P_GET_PORT_VARIABLE(V_EOBJID    => V_EOBJID,
                            V_COMPID    => V_COMPID,
                            V_SSNUM     => V_SSNUM,
                            V_RTNUM     => V_RTNUM,
                            V_RTIDS     => V_RTIDS,
                            V_RTDETAIL  => V_RTDETAIL,
                            V_CKNUM     => V_CKNUM,
                            V_CKIDS     => V_CKIDS,
                            V_CKDETAIL  => V_CKDETAIL);

        --插入到表
        INSERT INTO SCMDATA.T_INTERFACE_LOG
          (IL_ID,ELEMENT_ID,RUNNING_TIME,SUCCESS_NUM,RTERR_NUM,RTERR_IDS,
           RTERR_DETAIL,CKERR_NUM,CKERR_IDS,CKERR_DETAIL)
        VALUES
          (SCMDATA.F_GET_UUID(),V_EOBJID,SYSDATE-(V_MINUTE+2/(24*60)),V_SSNUM,
           V_RTNUM,V_RTIDS,V_RTDETAIL,V_CKNUM,V_CKIDS,V_CKDETAIL);

        --值初始化
        UPDATE SCMDATA.T_VARIABLE
           SET VAR_NUMBER = 0,
               LAST_UPDTIME = NULL
         WHERE OBJ_ID = V_EOBJID
           AND COMPANY_ID = V_COMPID
           AND VAR_NAME IN ('SSNUM','RTNUM','CKNUM');

        UPDATE SCMDATA.T_VARIABLE
           SET VAR_CLOB = NULL,
               LAST_UPDTIME = NULL
         WHERE OBJ_ID = V_EOBJID
           AND COMPANY_ID = V_COMPID
           AND VAR_NAME IN ('RTIDS','RTDETAIL','CKIDS','CKDETAIL');
      END IF;
    END IF;
  END P_INSERT_INFO_AND_INIT_VARIABLE;




  /*=================================================================================

   取出接口相关的变量

   变量说明
     V_SSNUM    : 成功数
     V_RTNUM    : 执行失败数
     V_RTIDS    : 执行失败id值
     V_RTDETAIL : 执行失败具体信息
     V_CKNUM    : 校验失败数
     V_CKIDS    : 校验失败id值
     V_CKDETAIL : 校验失败具体信息

   用途：
     取出 SYS_ACTION.ELEMENT_ID = V_EOBJID接口相关变量

   版本：
      2021-10-18 : 该过程已固定

  =================================================================================*/
  PROCEDURE P_GET_PORT_VARIABLE(V_EOBJID    IN VARCHAR2,
                                V_COMPID    IN VARCHAR2,
                                V_SSNUM     IN OUT NUMBER,
                                V_RTNUM     IN OUT NUMBER,
                                V_RTIDS     IN OUT CLOB,
                                V_RTDETAIL  IN OUT CLOB,
                                V_CKNUM     IN OUT NUMBER,
                                V_CKIDS     IN OUT CLOB,
                                V_CKDETAIL  IN OUT CLOB) IS
    V_EXESQL VARCHAR2(512);
  BEGIN
    V_EXESQL := 'SELECT VAR_NUMBER FROM SCMDATA.T_VARIABLE WHERE OBJ_ID = :A '||
                'AND COMPANY_ID = :B AND VAR_NAME = :C';
    EXECUTE IMMEDIATE V_EXESQL INTO V_SSNUM USING V_EOBJID,V_COMPID,'SSNUM';
    EXECUTE IMMEDIATE V_EXESQL INTO V_RTNUM USING V_EOBJID,V_COMPID,'RTNUM';
    EXECUTE IMMEDIATE V_EXESQL INTO V_CKNUM USING V_EOBJID,V_COMPID,'CKNUM';
    V_EXESQL := 'SELECT VAR_CLOB FROM SCMDATA.T_VARIABLE WHERE OBJ_ID = :A '||
                'AND COMPANY_ID = :B AND VAR_NAME = :C';
    EXECUTE IMMEDIATE V_EXESQL INTO V_RTIDS USING V_EOBJID,V_COMPID,'RTIDS';
    EXECUTE IMMEDIATE V_EXESQL INTO V_RTDETAIL USING V_EOBJID,V_COMPID,'RTDETAIL';
    EXECUTE IMMEDIATE V_EXESQL INTO V_CKIDS USING V_EOBJID,V_COMPID,'CKIDS';
    EXECUTE IMMEDIATE V_EXESQL INTO V_CKDETAIL USING V_EOBJID,V_COMPID,'CKDETAIL';
  END P_GET_PORT_VARIABLE;







  /*=================================================================================

    更新接口错误相关变量

    用途:
      用于更新接口相关变量，分别有执行错误和校验错误2种更新方法，
      将接口执行错误/校验错误2种错误更新至该接口的相关变量中

    入参:
      V_EOBJID    :  执行对象Id
      V_COMPID    :  企业Id
      V_ASNID     :  ASN单号
      V_ERRINFO   :  错误信息
      V_MODE      :  模式:RE-执行错误模式，CE-校验错误模式


     版本:
       2021-10-18:已固定，不会/不可被修改

  =================================================================================*/
  PROCEDURE P_UPDATE_INTERFACE_VARIABLE(V_EOBJID  IN VARCHAR2,
                                        V_COMPID  IN VARCHAR2,
                                        V_UNQVAL  IN VARCHAR2,
                                        V_ERRINFO IN VARCHAR2,
                                        V_MODE    IN VARCHAR2) IS

  BEGIN
    IF V_MODE = 'RE' THEN
      SCMDATA.PKG_VARIABLE.P_APPEND_CLOB_VARIABLE(V_OBJID   => V_EOBJID,
                                                  V_COMPID  => V_COMPID,
                                                  V_VARNAME => 'RTIDS',
                                                  V_APPSTR  => V_UNQVAL);

      SCMDATA.PKG_VARIABLE.P_APPEND_CLOB_VARIABLE(V_OBJID   => V_EOBJID,
                                                  V_COMPID  => V_COMPID,
                                                  V_VARNAME => 'RTDETAIL',
                                                  V_APPSTR  => V_ERRINFO);

      SCMDATA.PKG_VARIABLE.P_SET_VARIABLE_INCREMENT(V_OBJID    => V_EOBJID,
                                                    V_COMPID   => V_COMPID,
                                                    V_VARNAME  => 'RTNUM');

    ELSIF V_MODE = 'CE' THEN
      SCMDATA.PKG_VARIABLE.P_APPEND_CLOB_VARIABLE(V_OBJID   => V_EOBJID,
                                                  V_COMPID  => V_COMPID,
                                                  V_VARNAME => 'CKIDS',
                                                  V_APPSTR  => V_UNQVAL);

      SCMDATA.PKG_VARIABLE.P_APPEND_CLOB_VARIABLE(V_OBJID   => V_EOBJID,
                                                  V_COMPID  => V_COMPID,
                                                  V_VARNAME => 'CKDETAIL',
                                                  V_APPSTR  => V_ERRINFO);

      SCMDATA.PKG_VARIABLE.P_SET_VARIABLE_INCREMENT(V_OBJID    => V_EOBJID,
                                                    V_COMPID   => V_COMPID,
                                                    V_VARNAME  => 'CKNUM');
    END IF;
  END P_UPDATE_INTERFACE_VARIABLE;



  /*=================================================================================

   生成执行错误信息

   用途：
     用于生成执行错误信息

   参数：
     V_TAB      ：错误发生表
     V_UNQCOLS  : 错误发生唯一列
     V_UNQVALS  ：错误发生唯一值
     V_ERRSTACK ：错误栈
     V_ERRSQL   ：执行错误sql

   返回值：
     格式：
       错误表:V_TAB
       错误时间:YYYY-MM-DD HH24-MI-SS
       错误唯一列:V_UNQCOLS
       错误唯一值:V_UNQVALS
       错误信息:V_ERRSTACK
       错误sql:V_ERRSQL

   版本：
      2021-10-18 : 该过程已固定

  =================================================================================*/
  FUNCTION F_GENERATE_RUNTIME_ERRINFO(V_TAB            IN VARCHAR2,
                                      V_UNQCOLS        IN VARCHAR2,
                                      V_UNQVALS        IN VARCHAR2,
                                      V_ERRSTACK       IN VARCHAR2,
                                      V_ERRSQL         IN VARCHAR2) RETURN VARCHAR2 IS
    RET_VARCHAR  VARCHAR2(4000);
  BEGIN
    RET_VARCHAR := '错误表:'||V_TAB||CHR(10)||
                   '错误时间:'||TO_CHAR(SYSDATE,'YYYY-MM-DD HH24-MI-SS')||CHR(10)||
                   '错误唯一列:'||V_UNQCOLS||CHR(10)||
                   '错误唯一值:'||V_UNQVALS||CHR(10)||
                   '错误信息:'||V_ERRSTACK||CHR(10)||
                   '错误sql:'||V_ERRSQL||CHR(10);
    RETURN RET_VARCHAR;
  END F_GENERATE_RUNTIME_ERRINFO;



  /*====================================================================================================

    执行错误处理逻辑

    说明：
      用于执行错误处理，当执行错误后，记录错误时间，错误唯一列，
      错误接口和错误SQL，并记入接口变量，待后续生成日志

    入参：
      V_EOBJID  : 执行对象Id，有可能是action，也有可能是item
      V_COMPID  : 执行企业Id
      V_TAB     : 接口表
      V_ERRSQL  : 执行错误SQL
      V_UNQCOLS : 执行错误列
      V_UNQVALS : 执行错误值
      V_ST      : 执行错误信息

    版本：
      2021-10-17 : 整合接口错误处理逻辑为 P_ITF_RUNTIME_ERROR_LOGIC
      2021-10-18 : 作为基本的条件语句拼接功能已完成，后续如果再增加新的数据类型，
                   直接在函数的 IF...ELSE 中添加对应逻辑，另，本函数待完善部分为：
                   当数据类型选择为空时，应增加数据字典插入/更新逻辑

  ====================================================================================================*/
  PROCEDURE P_ITF_RUNTIME_ERROR_LOGIC(V_EOBJID   IN VARCHAR2,
                                      V_COMPID   IN VARCHAR2,
                                      V_TAB      IN VARCHAR2,
                                      V_ERRSQL   IN CLOB,
                                      V_UNQCOLS  IN VARCHAR2,
                                      V_UNQVALS  IN VARCHAR2,
                                      V_ST       IN VARCHAR2) IS
    V_ERRINFO  CLOB;
  BEGIN
    V_ERRINFO := F_GENERATE_RUNTIME_ERRINFO(V_TAB      => V_TAB,
                                            V_UNQCOLS  => V_UNQCOLS,
                                            V_UNQVALS  => V_UNQVALS,
                                            V_ERRSTACK => V_ST,
                                            V_ERRSQL   => V_ERRSQL);

    P_UPDATE_INTERFACE_VARIABLE(V_EOBJID  => V_EOBJID,
                                V_COMPID  => V_COMPID,
                                V_UNQVAL  => V_UNQVALS,
                                V_ERRINFO => V_ERRINFO,
                                V_MODE    => 'RE');
  END P_ITF_RUNTIME_ERROR_LOGIC;



  /*=================================================================================

    生成条件语句

    用途：
      依据输入参数生成对应的条件语句

    参数：
      V_TAB     ：表名
      V_COL     : 列名，不支持多列
      V_VAL     : 列值，不支持多值
                  日期/时间格式：YYYY-MM-DD HH24-MI-SS 否则会报错
      V_CONDSTR : 外部条件语句，用于拼接

    返回值:
      NUMBER类型：1存在，0不存在

    版本:
      2021-10-18 : 作为基本的条件语句拼接功能已完成，后续如果再增加新的数据类型，
                   直接在函数的 IF...ELSE 中添加对应逻辑，另，本函数待完善部分为：
                   当数据类型选择为空时，应增加数据字典插入/更新逻辑

  =================================================================================*/
  FUNCTION F_GET_CONDSTR(V_TAB     IN VARCHAR2,
                         V_COL     IN VARCHAR2,
                         V_VAL     IN VARCHAR2,
                         V_CONDSTR IN VARCHAR2) RETURN VARCHAR2 IS
    V_DATATYPE VARCHAR2(8);
    V_RETSTR   VARCHAR2(2048);
  BEGIN
    SELECT MAX(DATA_TYPE)
      INTO V_DATATYPE
      FROM SCMDATA.ALL_TAB_COLUMNS_BACKUP
     WHERE OWNER = 'SCMDATA'
       AND TABLE_NAME = V_TAB
       AND COLUMN_NAME = V_COL;

    IF V_DATATYPE = 'CHAR' OR V_DATATYPE = 'VARCHAR2' OR V_DATATYPE = 'CLOB' OR V_DATATYPE = 'BLOB' THEN
      V_RETSTR := V_CONDSTR || ' AND ' || V_COL || '=''' || V_VAL ||'''';
    ELSIF V_DATATYPE = 'NUMBER' OR V_DATATYPE = 'FLOAT' THEN
      V_RETSTR := V_CONDSTR || ' AND ' || V_COL || '=' || V_VAL;
    ELSIF V_DATATYPE = 'DATE' THEN
      V_RETSTR := V_CONDSTR || ' AND ' || V_COL || '=TO_DATE(''' || V_VAL ||''',''YYYY-MM-DD HH24-MI-SS'')';
    END IF;
    RETURN V_RETSTR;
  END F_GET_CONDSTR;



  /*=================================================================================

    值是否存在于某表通用校验

    用途：
      用于校验参数 V_INRELAGOOID 是否存在于 Scm 商品档案中

    参数：
      V_TAB  ：表名
      V_COLS : 列名，支持多列，用逗号隔开
      V_VALS : 列值，支持多值，用逗号隔开，
              日期/时间格式：YYYY-MM-DD HH24-MI-SS 否则会报错

    返回值：
      NUMBER类型：1存在，0不存在

    版本:
      2021-10-18: 该函数已固定

  =================================================================================*/
  FUNCTION F_CHECK_EXISTS_BY_COND(V_TAB   IN VARCHAR2,
                                  V_COLS  IN VARCHAR2,
                                  V_VALS  IN VARCHAR2) RETURN NUMBER IS
    V_COLCOM   NUMBER(4);
    V_VALCOM   NUMBER(4);
    V_TMPCOLS  VARCHAR2(512):=','||V_COLS||',';
    V_TMPVALS  VARCHAR2(2048):=','||V_VALS||',';
    V_JUGNUM   NUMBER(4):=REGEXP_COUNT(V_TMPCOLS,',');
    V_RETNUM   NUMBER(1);
    V_TMPCOL   VARCHAR2(32);
    V_TMPVAL   VARCHAR2(128);
    V_TMPCOND  VARCHAR2(2048);
    V_EXESQL   VARCHAR2(4000);
  BEGIN
    V_COLCOM := REGEXP_COUNT(V_TMPCOLS,',');
    V_VALCOM := REGEXP_COUNT(V_TMPVALS,',');

    IF V_COLCOM <> V_VALCOM THEN
      RAISE_APPLICATION_ERROR(-20002,'输入列与输入列值数量不符！');
    ELSE
      FOR I IN 1..V_JUGNUM LOOP
        IF I < V_JUGNUM THEN
          V_TMPCOL := SUBSTR(V_TMPCOLS,
                             INSTR(V_TMPCOLS,',',1,I)+1,
                             INSTR(V_TMPCOLS,',',1,I+1)-INSTR(V_TMPCOLS,',',1,I)-1);

          V_TMPVAL := SUBSTR(V_TMPVALS,
                             INSTR(V_TMPVALS,',',1,I)+1,
                             INSTR(V_TMPVALS,',',1,I+1)-INSTR(V_TMPVALS,',',1,I)-1);

          V_TMPCOND := F_GET_CONDSTR(V_TAB     => V_TAB,
                                     V_COL     => V_TMPCOL,
                                     V_VAL     => V_TMPVAL,
                                     V_CONDSTR => V_TMPCOND);
        END IF;
      END LOOP;

      V_TMPCOND := LTRIM(V_TMPCOND,' AND ');

      V_EXESQL  := 'SELECT COUNT(1) FROM ' || V_TAB || ' WHERE ' || V_TMPCOND ||' AND ROWNUM = 1';

      EXECUTE IMMEDIATE V_EXESQL INTO V_RETNUM;

    END IF;
    RETURN V_RETNUM;
  END F_CHECK_EXISTS_BY_COND;



  /*=================================================================================

    ACTION 动态生成/更新

    用途：
      使用接口配置表内字段值，动态生成/更新action

    参数：
      V_ITFLGID ：通用接口日志配置表主键

    版本:
      2021-10-18 : 该过程已固定

  =================================================================================*/
  PROCEDURE P_GEN_OR_UPD_ACTION(V_ITFLGID  IN VARCHAR2) IS
    V_JUGNUM  NUMBER(1);
    V_EXESQL  VARCHAR2(2048);
  BEGIN
    FOR I IN (SELECT * FROM SCMDATA.T_ITF_LOG_CONFIG
               WHERE ITFCFG_ID = V_ITFLGID) LOOP
      SELECT COUNT(1)
        INTO V_JUGNUM
        FROM BW3.SYS_ACTION Z
       WHERE ELEMENT_ID = I.ELEMENT_ID
         AND EXISTS (SELECT 1
                       FROM BW3.SYS_ELEMENT
                      WHERE ELEMENT_ID = Z.ELEMENT_ID)
         AND ROWNUM = 1;

      IF V_JUGNUM > 0 THEN
        V_EXESQL := 'UPDATE BW3.SYS_ACTION SET ACTION_SQL = :A, PORT_ID = :B, PORT_SQL = :C WHERE ELEMENT_ID = :D';
        EXECUTE IMMEDIATE V_EXESQL USING I.ACSQL,I.PORT_ID,I.WHOLE_LOGIC,I.ELEMENT_ID;
      ELSE
        V_EXESQL := 'BEGIN
                      INSERT INTO BW3.SYS_ELEMENT
                        (ELEMENT_ID,ELEMENT_TYPE,DATA_SOURCE,PAUSE)
                      VALUES
                        (:A,''action'',''oracle_scmdata'',0);

                      INSERT INTO BW3.SYS_ACTION
                        (ELEMENT_ID,CAPTION,ACTION_TYPE,ACTION_SQL,REFRESH_FLAG,PORT_ID,PORT_SQL)
                      VALUES
                        (:A,:B,8,:C,1,:D,:E);
                     END;';
        EXECUTE IMMEDIATE V_EXESQL USING I.ELEMENT_ID,I.ELEMENT_ID,I.CAPTION,I.ACSQL,I.PORT_ID,I.WHOLE_LOGIC;
      END IF;
    END LOOP;
  END P_GEN_OR_UPD_ACTION;



  /*=================================================================================

    动态生成/更新定时任务

    用途：
      用于配置处动态生成/更新定时任务

    参数：
      V_ITFLGID ：通用接口日志配置表主键
      V_CUID    : 当前操作人id

    版本:
      2021-10-18 : 该过程已固定

  =================================================================================*/
  PROCEDURE P_GEN_OR_UPD_XXLJOB(V_ITFLGID  IN VARCHAR2,
                                V_CUID     IN VARCHAR2) IS
    V_JUGNUM NUMBER(1);
    V_CRON   VARCHAR2(32);
    V_EXESQL VARCHAR2(2048);
  BEGIN
    FOR I IN (SELECT * FROM SCMDATA.T_ITF_LOG_CONFIG
               WHERE ITFCFG_ID = V_ITFLGID) LOOP
      SELECT COUNT(1)
        INTO V_JUGNUM
        FROM BW3.XXL_JOB_INFO
       WHERE ID = I.XXL_SEQ;

      V_CRON := '0 0/'||I.TIME_INTERVAL||' * * *  ?';

      IF V_JUGNUM > 0 THEN
        V_EXESQL := 'UPDATE BW3.XXL_JOB_INFO SET JOB_CRON = :A, EXECUTOR_PARAM = :B WHERE ID = :C';
        EXECUTE IMMEDIATE V_EXESQL USING V_CRON, I.ELEMENT_ID, I.XXL_SEQ;
      ELSE
        V_EXESQL := 'INSERT INTO BW3.XXL_JOB_INFO
                        (ID,APP_ID,JOB_GROUP,JOB_CRON,
                         EXECUTOR_HANDLER,EXECUTOR_PARAM,
                         JOB_DESC,ADD_TIME,UPDATE_TIME,
                         AUTHOR,GLUE_TYPE,GLUE_UPDATETIME,
                         CHILD_JOBID,EXECUTOR_ROUTE_STRATEGY,
                         EXECUTOR_BLOCK_STRATEGY,TRIGGER_STATUS)
                      VALUES
                        (XXL_JOB_INFO_SEQ.NEXTVAL,
                         ''scm'',''402'',:A,
                         ''actionJobHandler'',:B,
                         :C,SYSDATE,SYSDATE,
                         :D,''BEAN'',SYSDATE,NULL,''ROUND'',
                         ''SERIAL_EXECUTION'',0)';
        EXECUTE IMMEDIATE V_EXESQL USING V_CRON,I.ELEMENT_ID,I.CAPTION,V_CUID;
      END IF;
    END LOOP;
  END P_GEN_OR_UPD_XXLJOB;

END PKG_INTERFACE_LOG;
/

