CREATE OR REPLACE PACKAGE SCMDATA.PKG_INTERFACE_ERR IS
  --生成执行错误信息（有2个地方可以使用）
  FUNCTION F_GENERATE_RUNTIME_ERRINFO(V_TAB            IN VARCHAR2,
                                      V_UNQCOLS        IN VARCHAR2,
                                      V_UNQVALS        IN VARCHAR2,
                                      V_ERRSTACK       IN VARCHAR2,
                                      V_ERRSQL         IN VARCHAR2) RETURN VARCHAR2;

  --商品档案校验并生成校验错误信息
  --存在商品档案，返回GOO_ID, 不存在商品档案，返回错误信息
  FUNCTION F_CHECK_GOOD_AND_GENERATE_ERRINFO(V_GOOID          IN VARCHAR2,
                                             V_COMPID         IN VARCHAR2) RETURN VARCHAR2;

  --供应商档案校验并生成校验错误信息
  --存在供应商档案，返回SUPPLIER_CODE, 不存在供应商档案，返回错误信息
  FUNCTION F_CHECK_SUPPLIER_AND_GENERATE_ERRINFO(V_SUPPLIER_CODE  IN VARCHAR2,
                                                 V_COMPID         IN VARCHAR2) RETURN VARCHAR2;

  --VARIABLE表特定名称数据自增1
  PROCEDURE P_SET_VARIABLE_INCREMENT(V_OBJID     IN VARCHAR2,
                                     V_COMPID    IN VARCHAR2,
                                     V_VARNAME   IN VARCHAR2);

  --取出接口相关的变量
  PROCEDURE P_GET_PORT_VARIABLE(V_ELEID     IN VARCHAR2,
                                V_COMPID    IN VARCHAR2,
                                V_SSNUM     IN OUT NUMBER,
                                V_RTNUM     IN OUT NUMBER,
                                V_RTIDS     IN OUT CLOB,
                                V_RTDETAIL  IN OUT CLOB,
                                V_CKNUM     IN OUT NUMBER,
                                V_CKIDS     IN OUT CLOB,
                                V_CKDETAIL  IN OUT CLOB);

  --变量初始化
  ----解决方法，固定变量名，初始化，再调用都方便，可以直接调用
  ----SSNUM : 成功数
  ----RTNUM : 执行失败数
  ----RTIDS : 执行失败id值
  ----RTDETAIL : 执行失败具体信息
  ----CKNUM : 校验失败数
  ----CKIDS : 校验失败id值
  ----CKDETAIL : 校验失败具体信息
  ----不存在变量，执行——变量成功初始化，接口日志表没有值
  ----存在变量，变量最后更新时间未超过V_MINUTE分钟——变量值不初始化，接口日志表没有值
  ----存在变量，变量最后更新时间超过V_MINUTE分钟——变量值初始化，接口日志表插入1条数据
  PROCEDURE P_INSERT_INFO_AND_INIT_VARIABLE(V_ELEID     IN VARCHAR2,
                                            V_COMPID    IN VARCHAR2,
                                            V_MINUTE    IN NUMBER);

END PKG_INTERFACE_ERR;
/

CREATE OR REPLACE PACKAGE BODY SCMDATA.PKG_INTERFACE_ERR IS

  --生成执行错误信息（有2个地方可以使用）
  FUNCTION F_GENERATE_RUNTIME_ERRINFO(V_TAB            IN VARCHAR2,
                                      V_UNQCOLS        IN VARCHAR2,
                                      V_UNQVALS        IN VARCHAR2,
                                      V_ERRSTACK       IN VARCHAR2,
                                      V_ERRSQL         IN VARCHAR2) RETURN VARCHAR2 IS
    RET_VARCHAR  VARCHAR2(2048);
  BEGIN
    RET_VARCHAR := '错误表:'||V_TAB||CHR(10)||
                   '错误时间:'||TO_CHAR(SYSDATE,'YYYY-MM-DD HH24-MI-SS')||CHR(10)||
                   '错误唯一列:'||V_UNQCOLS||CHR(10)||
                   '错误唯一值:'||V_UNQVALS||CHR(10)||
                   '错误信息:'||V_ERRSTACK||CHR(10)||
                   '错误sql:'||V_ERRSQL||CHR(10);
    RETURN RET_VARCHAR;
  END F_GENERATE_RUNTIME_ERRINFO;


  --商品档案校验并生成校验错误信息
  --存在商品档案，返回GOO_ID, 不存在商品档案，返回错误信息
  FUNCTION F_CHECK_GOOD_AND_GENERATE_ERRINFO(V_GOOID          IN VARCHAR2,
                                             V_COMPID         IN VARCHAR2) RETURN VARCHAR2 IS
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


  --供应商档案校验并生成校验错误信息
  --存在供应商档案，返回SUPPLIER_CODE, 不存在供应商档案，返回错误信息
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
      V_RETMSG := '错误信息:'||V_SUPPLIER_CODE||'不存在于供应商档案中'||CHR(10)||CHR(10);
    END IF;
    RETURN V_RETMSG;
  END F_CHECK_SUPPLIER_AND_GENERATE_ERRINFO;


  --VARIABLE表特定名称数据自增1
  PROCEDURE P_SET_VARIABLE_INCREMENT(V_OBJID     IN VARCHAR2,
                                     V_COMPID    IN VARCHAR2,
                                     V_VARNAME   IN VARCHAR2) IS
  BEGIN
    UPDATE SCMDATA.T_VARIABLE T
       SET VAR_NUMBER = NVL(T.VAR_NUMBER,0)+1,
           LAST_UPDTIME = SYSDATE
     WHERE OBJ_ID = V_OBJID
       AND COMPANY_ID = V_COMPID
       AND VAR_NAME = V_VARNAME;
  END P_SET_VARIABLE_INCREMENT;


  --取出接口相关的变量
  PROCEDURE P_GET_PORT_VARIABLE(V_ELEID     IN VARCHAR2,
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
    EXECUTE IMMEDIATE V_EXESQL INTO V_SSNUM USING V_ELEID,V_COMPID,'SSNUM';
    EXECUTE IMMEDIATE V_EXESQL INTO V_RTNUM USING V_ELEID,V_COMPID,'RTNUM';
    EXECUTE IMMEDIATE V_EXESQL INTO V_CKNUM USING V_ELEID,V_COMPID,'CKNUM';
    V_EXESQL := 'SELECT VAR_CLOB FROM SCMDATA.T_VARIABLE WHERE OBJ_ID = :A '||
                'AND COMPANY_ID = :B AND VAR_NAME = :C';
    EXECUTE IMMEDIATE V_EXESQL INTO V_RTIDS USING V_ELEID,V_COMPID,'RTIDS';
    EXECUTE IMMEDIATE V_EXESQL INTO V_RTDETAIL USING V_ELEID,V_COMPID,'RTDETAIL';
    EXECUTE IMMEDIATE V_EXESQL INTO V_CKIDS USING V_ELEID,V_COMPID,'CKIDS';
    EXECUTE IMMEDIATE V_EXESQL INTO V_CKDETAIL USING V_ELEID,V_COMPID,'CKDETAIL';
  END P_GET_PORT_VARIABLE;


  --变量初始化
  --解决方法，固定变量名，初始化，再调用都方便，可以直接调用
  --SSNUM : 成功数
  --RTNUM : 执行失败数
  --RTIDS : 执行失败id值
  --RTDETAIL : 执行失败具体信息
  --CKNUM : 校验失败数
  --CKIDS : 校验失败id值
  --CKDETAIL : 校验失败具体信息
  PROCEDURE P_INSERT_INFO_AND_INIT_VARIABLE(V_ELEID     IN VARCHAR2,
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
     WHERE OBJ_ID = V_ELEID
       AND COMPANY_ID = V_COMPID;

    IF V_JUGNUM = 0 THEN
      V_EXESQL := 'INSERT INTO SCMDATA.T_VARIABLE '||
                  '(OBJ_ID,COMPANY_ID,VAR_NAME,VAR_TYPE,VAR_NUMBER)'||
                  'VALUES (:A,:B,:C,:D,:E)';
      EXECUTE IMMEDIATE V_EXESQL USING V_ELEID,V_COMPID,'SSNUM','NUMBER',0;
      EXECUTE IMMEDIATE V_EXESQL USING V_ELEID,V_COMPID,'RTNUM','NUMBER',0;
      EXECUTE IMMEDIATE V_EXESQL USING V_ELEID,V_COMPID,'CKNUM','NUMBER',0;
      V_EXESQL := 'INSERT INTO SCMDATA.T_VARIABLE '||
                  '(OBJ_ID,COMPANY_ID,VAR_NAME,VAR_TYPE,VAR_CLOB)'||
                  'VALUES (:A,:B,:C,:D,:E)';
      EXECUTE IMMEDIATE V_EXESQL USING V_ELEID,V_COMPID,'RTIDS','CLOB','';
      EXECUTE IMMEDIATE V_EXESQL USING V_ELEID,V_COMPID,'RTDETAIL','CLOB','';
      EXECUTE IMMEDIATE V_EXESQL USING V_ELEID,V_COMPID,'CKIDS','CLOB','';
      EXECUTE IMMEDIATE V_EXESQL USING V_ELEID,V_COMPID,'CKDETAIL','CLOB','';
    ELSE
      IF V_MAXUPDTIME < SYSDATE - (V_MINUTE/(60*24)) THEN
        --取数
        P_GET_PORT_VARIABLE(V_ELEID     => V_ELEID,
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
          (SCMDATA.F_GET_UUID(),V_ELEID,SYSDATE-(V_MINUTE+2/(24*60)),V_SSNUM,
           V_RTNUM,V_RTIDS,V_RTDETAIL,V_CKNUM,V_CKIDS,V_CKDETAIL);

        --值初始化
        UPDATE SCMDATA.T_VARIABLE
           SET VAR_NUMBER = 0,
               LAST_UPDTIME = NULL
         WHERE OBJ_ID = V_ELEID
           AND COMPANY_ID = V_COMPID
           AND VAR_NAME IN ('SSNUM','RTNUM','CKNUM');

        UPDATE SCMDATA.T_VARIABLE
           SET VAR_CLOB = NULL,
               LAST_UPDTIME = NULL
         WHERE OBJ_ID = V_ELEID
           AND COMPANY_ID = V_COMPID
           AND VAR_NAME IN ('RTIDS','RTDETAIL','CKIDS','CKDETAIL');
      END IF;
    END IF;
  END P_INSERT_INFO_AND_INIT_VARIABLE;

END PKG_INTERFACE_ERR;
/

