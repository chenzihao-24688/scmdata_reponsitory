CREATE OR REPLACE PACKAGE SCMDATA.PKG_VARIABLE IS

  /*=================================================================================

    变量值插入/更新

    用途:
      用于在 SCMDATA.T_VARIABLE 表中插入/更新一个变量

    入参：
      V_OBJID   :  对象Id，对应 SCMDATA.T_VARIABLE.OBJ_ID
      V_COMPID  :  企业Id
      V_VARNAME :  变量名
      V_VARTYPE :  变量类型
      V_NUMBER  :  变量值（NUMBER类型）
      V_VARCHAR :  变量值（VARCHAR类型）
      V_DATE    :  变量值（DATE类型）
      V_CLOB    :  变量值（CLOB类型）

    版本:
      2021-10-18: NUMBER,VARCHAR,DATE,CLOB类型数据已固定

  =================================================================================*/
  PROCEDURE P_INS_OR_UPD_VARIABLE(V_OBJID   IN VARCHAR2,
                                  V_COMPID  IN VARCHAR2,
                                  V_VARNAME IN VARCHAR2,
                                  V_VARTYPE IN VARCHAR2,
                                  V_NUMBER  IN NUMBER DEFAULT 0,
                                  V_VARCHAR IN VARCHAR2 DEFAULT NULL,
                                  V_DATE    IN DATE DEFAULT NULL,
                                  V_CLOB    IN CLOB DEFAULT NULL);
                                  
                                 
  /*=================================================================================

    变量值插入/更新

    用途:
      用于在 SCMDATA.T_VARIABLE 表中插入/更新一个变量

    入参：
      V_OBJID   :  对象Id，对应 SCMDATA.T_VARIABLE.OBJ_ID
      V_COMPID  :  企业Id
      V_VARNAME :  变量名
      V_VARTYPE :  变量类型
      V_NUMBER  :  变量值（NUMBER类型）
      V_VARCHAR :  变量值（VARCHAR类型）
      V_DATE    :  变量值（DATE类型）
      V_CLOB    :  变量值（CLOB类型）

    版本:
      2021-10-18: NUMBER,VARCHAR,DATE,CLOB类型数据已固定

  =================================================================================*/
  PROCEDURE P_INS_OR_UPD_VARIABLE_AT(V_OBJID   IN VARCHAR2,
                                     V_COMPID  IN VARCHAR2,
                                     V_VARNAME IN VARCHAR2,
                                     V_VARTYPE IN VARCHAR2,
                                     V_NUMBER  IN NUMBER DEFAULT 0,
                                     V_VARCHAR IN VARCHAR2 DEFAULT NULL,
                                     V_DATE    IN DATE DEFAULT NULL,
                                     V_CLOB    IN CLOB DEFAULT NULL);


  /*=================================================================================

    变量值插入/更新（通过特征值）

    用途:
      用于在 SCMDATA.T_VARIABLE 表中通过特征值插入/更新一个变量

    入参：
      V_OBJID   :  对象Id，对应 SCMDATA.T_VARIABLE.OBJ_ID
      V_COMPID  :  企业Id
      V_VARNAME :  变量名
      V_VARTYPE :  变量类型
      V_NUMBER  :  变量值（NUMBER类型）
      V_VARCHAR :  变量值（VARCHAR类型）
      V_DATE    :  变量值（DATE类型）
      V_CLOB    :  变量值（CLOB类型）
      V_CHAID   :  特征Id，一般为当前操作人User_Id

    版本:
      2021-11-04: 加入CHA_ID以实现某人的全局变量

  =================================================================================*/
  PROCEDURE P_INS_OR_UPD_VARIABLE_WITH_CHAID(V_OBJID   IN VARCHAR2,
                                             V_COMPID  IN VARCHAR2,
                                             V_VARNAME IN VARCHAR2,
                                             V_VARTYPE IN VARCHAR2,
                                             V_NUMBER  IN NUMBER DEFAULT 0,
                                             V_VARCHAR IN VARCHAR2 DEFAULT NULL,
                                             V_DATE    IN DATE DEFAULT NULL,
                                             V_CLOB    IN CLOB DEFAULT NULL,
                                             V_CHAID   IN VARCHAR2);
                                             
                                             
  /*=================================================================================

    变量值插入/更新（通过特征值）

    用途:
      用于在 SCMDATA.T_VARIABLE 表中通过特征值插入/更新一个变量

    入参：
      V_OBJID   :  对象Id，对应 SCMDATA.T_VARIABLE.OBJ_ID
      V_COMPID  :  企业Id
      V_VARNAME :  变量名
      V_VARTYPE :  变量类型
      V_NUMBER  :  变量值（NUMBER类型）
      V_VARCHAR :  变量值（VARCHAR类型）
      V_DATE    :  变量值（DATE类型）
      V_CLOB    :  变量值（CLOB类型）
      V_CHAID   :  特征Id，一般为当前操作人User_Id

    版本:
      2021-11-04: 加入CHA_ID以实现某人的全局变量

  =================================================================================*/
  PROCEDURE P_INS_OR_UPD_VARIABLE_WITH_CHAID_AT(V_OBJID   IN VARCHAR2,
                                                V_COMPID  IN VARCHAR2,
                                                V_VARNAME IN VARCHAR2,
                                                V_VARTYPE IN VARCHAR2,
                                                V_NUMBER  IN NUMBER DEFAULT 0,
                                                V_VARCHAR IN VARCHAR2 DEFAULT NULL,
                                                V_DATE    IN DATE DEFAULT NULL,
                                                V_CLOB    IN CLOB DEFAULT NULL,
                                                V_CHAID   IN VARCHAR2);
                                             


  /*=================================================================================

    获取 VARCHAR 类型变量

    用途:
      用于在 SCMDATA.T_VARIABLE 表中获取一个 VARCHAR 类型的变量

    入参：
      V_OBJID   :  对象Id，对应 SCMDATA.T_VARIABLE.OBJ_ID
      V_COMPID  :  企业Id
      V_VARNAME :  变量名

    版本:
      2021-10-18: 该函数已固定

  =================================================================================*/
  FUNCTION F_GET_VARCHAR(V_OBJID   IN VARCHAR2,
                         V_COMPID  IN VARCHAR2,
                         V_VARNAME IN VARCHAR2) RETURN VARCHAR2;


  /*=================================================================================

    获取 VARCHAR 类型变量（通过特征值）

    用途:
      用于在 SCMDATA.T_VARIABLE 表中通过特征值获取一个 VARCHAR 类型的变量

    入参：
      V_OBJID   :  对象Id，对应 SCMDATA.T_VARIABLE.OBJ_ID
      V_COMPID  :  企业Id
      V_VARNAME :  变量名
      V_CHAID   :  特征Id，一般为当前操作人User_Id

    版本:
      2021-11-04: 该函数已固定

  =================================================================================*/
  FUNCTION F_GET_VARCHAR_WITH_CHAID(V_OBJID   IN VARCHAR2,
                                    V_COMPID  IN VARCHAR2,
                                    V_VARNAME IN VARCHAR2,
                                    V_CHAID   IN VARCHAR2) RETURN VARCHAR2;


  /*=================================================================================

    获取 NUMBER 类型变量

    用途:
      用于在 SCMDATA.T_VARIABLE 表中获取一个 NUMBER 类型的变量

    入参：
      V_OBJID   :  对象Id，对应 SCMDATA.T_VARIABLE.OBJ_ID
      V_COMPID  :  企业Id
      V_VARNAME :  变量名

    版本:
      2021-10-18: 该函数已固定

  =================================================================================*/
  FUNCTION F_GET_NUMBER(V_OBJID   IN VARCHAR2,
                        V_COMPID  IN VARCHAR2,
                        V_VARNAME IN VARCHAR2) RETURN NUMBER;


  /*=================================================================================

    获取 NUMBER 类型变量（通过特征值）

    用途:
      用于在 SCMDATA.T_VARIABLE 表中通过特征值获取一个 NUMBER 类型的变量

    入参：
      V_OBJID   :  对象Id，对应 SCMDATA.T_VARIABLE.OBJ_ID
      V_COMPID  :  企业Id
      V_VARNAME :  变量名
      V_CHAID   :  特征Id，一般为当前操作人User_Id

    版本:
      2021-11-04 : 该函数已固定

  =================================================================================*/
  FUNCTION F_GET_NUMBER_WITH_CHAID(V_OBJID   IN VARCHAR2,
                                   V_COMPID  IN VARCHAR2,
                                   V_VARNAME IN VARCHAR2,
                                   V_CHAID   IN VARCHAR2) RETURN NUMBER;


  /*=================================================================================

    获取 DATE 类型变量

    用途:
      用于在 SCMDATA.T_VARIABLE 表中获取一个 DATE 类型的变量

    入参：
      V_OBJID   :  对象Id，对应 SCMDATA.T_VARIABLE.OBJ_ID
      V_COMPID  :  企业Id
      V_VARNAME :  变量名
      V_CHAID   :  特征Id，一般为当前操作人User_Id

    版本:
      2021-10-18 : 该函数已固定

  =================================================================================*/
  FUNCTION F_GET_DATE(V_OBJID   IN VARCHAR2,
                      V_COMPID  IN VARCHAR2,
                      V_VARNAME IN VARCHAR2) RETURN DATE;


  /*=================================================================================

    获取 DATE 类型变量（通过特征值）

    用途:
      用于在 SCMDATA.T_VARIABLE 表中通过特征值获取一个 DATE 类型的变量

    入参：
      V_OBJID    :  对象Id，对应 SCMDATA.T_VARIABLE.OBJ_ID
      V_COMPID   :  企业Id
      V_VARNAME  :  变量名
      V_CHAID   :  特征Id，一般为当前操作人User_Id

    版本:
      2021-11-04 : 该函数已固定

  =================================================================================*/
  FUNCTION F_GET_DATE_WITH_CHAID(V_OBJID   IN VARCHAR2,
                                 V_COMPID  IN VARCHAR2,
                                 V_VARNAME IN VARCHAR2,
                                 V_CHAID   IN VARCHAR2) RETURN DATE;


  /*=================================================================================

    获取 CLOB 类型变量

    用途:
      用于在 SCMDATA.T_VARIABLE 表中获取一个 CLOB 类型的变量

    入参：
      V_OBJID    :  对象Id，对应 SCMDATA.T_VARIABLE.OBJ_ID
      V_COMPID   :  企业Id
      V_VARNAME  :  变量名

    版本:
      2021-10-18 : 该函数已固定

  =================================================================================*/
  FUNCTION F_GET_CLOB(V_OBJID   IN VARCHAR2,
                      V_COMPID  IN VARCHAR2,
                      V_VARNAME IN VARCHAR2) RETURN CLOB;


  /*=================================================================================

    获取 CLOB 类型变量（通过特征值）

    用途:
      用于在 SCMDATA.T_VARIABLE 表中通过特征值获取一个 CLOB 类型的变量

    入参：
      V_OBJID    :  对象Id，对应 SCMDATA.T_VARIABLE.OBJ_ID
      V_COMPID   :  企业Id
      V_VARNAME  :  变量名
      V_CHAID   :  特征Id，一般为当前操作人User_Id

    版本:
      2021-11-04 : 该函数已固定

  =================================================================================*/
  FUNCTION F_GET_CLOB_WITH_CHAID(V_OBJID   IN VARCHAR2,
                                 V_COMPID  IN VARCHAR2,
                                 V_VARNAME IN VARCHAR2,
                                 V_CHAID   IN VARCHAR2) RETURN CLOB;


  /*=================================================================================

    SCMDATA.T_VARIABLE 表特定名称 NUMBER 类型数据自增1

    用途:
      用于对 SCMDATA.T_VARIABLE 表中一个 NUMBER 类型的变量自增1，
      并修改最后更新时间为当前时间

    入参：
      V_OBJID    :  对象Id，对应 SCMDATA.T_VARIABLE.OBJ_ID
      V_COMPID   :  企业Id
      V_VARNAME  :  变量名

    版本:
      2021-10-18: 该过程已固定

  =================================================================================*/
  PROCEDURE P_SET_VARIABLE_INCREMENT(V_OBJID     IN VARCHAR2,
                                     V_COMPID    IN VARCHAR2,
                                     V_VARNAME   IN VARCHAR2);


  /*=================================================================================

    SCMDATA.T_VARIABLE 表特定名称 NUMBER 类型数据自增1（通过特征值）

    用途:
      通过特征对 SCMDATA.T_VARIABLE 表中值一个 NUMBER 类型的变量自增1，
      并修改最后更新时间为当前时间

    入参：
      V_OBJID   :  对象Id，对应 SCMDATA.T_VARIABLE.OBJ_ID
      V_COMPID  :  企业Id
      V_VARNAME :  变量名
      V_CHAID   :  特征Id，一般为当前操作人User_Id

    版本:
      2021-11-04 : 该过程已固定

  =================================================================================*/
  PROCEDURE P_SET_VARIABLE_INCREMENT_WITH_CHAID(V_OBJID     IN VARCHAR2,
                                                V_COMPID    IN VARCHAR2,
                                                V_VARNAME   IN VARCHAR2,
                                                V_CHAID     IN VARCHAR2);


  /*=================================================================================

    对 SCMDATA.T_VARIABLE 表中 CLOB 类型数据追加新数据

    用途:
      用于对 SCMDATA.T_VARIABLE 表中一个 NUMBER 类型的变量自增1，
      并修改最后更新时间为当前时间

    入参：
      V_OBJID   :  对象Id，对应 SCMDATA.T_VARIABLE.OBJ_ID
      V_COMPID  :  企业Id
      V_VARNAME :  变量名
      V_APPSTR  :  追加字段

    版本:
      2021-10-18: 该过程已固定

  =================================================================================*/
  PROCEDURE P_APPEND_CLOB_VARIABLE(V_OBJID   IN VARCHAR2,
                                   V_COMPID  IN VARCHAR2,
                                   V_VARNAME IN VARCHAR2,
                                   V_APPSTR  IN VARCHAR2);


  /*=================================================================================

    对 SCMDATA.T_VARIABLE 表中 CLOB 类型数据追加新数据（通过特征值）

    用途:
      通过特征值对 SCMDATA.T_VARIABLE 表中一个 NUMBER 类型的变量自增1，
      并修改最后更新时间为当前时间

    入参：
      V_OBJID   :  对象Id，对应 SCMDATA.T_VARIABLE.OBJ_ID
      V_COMPID  :  企业Id
      V_VARNAME :  变量名
      V_APPSTR  :  追加字段
      V_CHAID   :  特征Id，一般为当前操作人User_Id

    版本:
      2021-11-04 : 该过程已固定

  =================================================================================*/
  PROCEDURE P_APPEND_CLOB_VARIABLE_WITH_CHAID(V_OBJID   IN VARCHAR2,
                                              V_COMPID  IN VARCHAR2,
                                              V_VARNAME IN VARCHAR2,
                                              V_APPSTR  IN VARCHAR2,
                                              V_CHAID   IN VARCHAR2);

END PKG_VARIABLE;
/

CREATE OR REPLACE PACKAGE BODY SCMDATA.PKG_VARIABLE IS

  /*=================================================================================

    变量值插入/更新

    用途:
      用于在 SCMDATA.T_VARIABLE 表中插入/更新一个变量

    入参：
      V_OBJID   :  对象Id，对应 SCMDATA.T_VARIABLE.OBJ_ID
      V_COMPID  :  企业Id
      V_VARNAME :  变量名
      V_VARTYPE :  变量类型
      V_NUMBER  :  变量值（NUMBER类型）
      V_VARCHAR :  变量值（VARCHAR类型）
      V_DATE    :  变量值（DATE类型）
      V_CLOB    :  变量值（CLOB类型）

    版本:
      2021-10-18: NUMBER,VARCHAR,DATE,CLOB类型数据已固定

  =================================================================================*/
  PROCEDURE P_INS_OR_UPD_VARIABLE(V_OBJID   IN VARCHAR2,
                                  V_COMPID  IN VARCHAR2,
                                  V_VARNAME IN VARCHAR2,
                                  V_VARTYPE IN VARCHAR2,
                                  V_NUMBER  IN NUMBER DEFAULT 0,
                                  V_VARCHAR IN VARCHAR2 DEFAULT NULL,
                                  V_DATE    IN DATE DEFAULT NULL,
                                  V_CLOB    IN CLOB DEFAULT NULL) IS
    V_JUGNUM   NUMBER(1);
    V_EXESQL   VARCHAR2(2048);
  BEGIN
    SELECT COUNT(1)
      INTO V_JUGNUM
      FROM SCMDATA.T_VARIABLE
     WHERE OBJ_ID = V_OBJID
       AND COMPANY_ID = V_COMPID
       AND VAR_NAME = V_VARNAME
       AND ROWNUM < 2;

    --类型为：NUMBER，不存在于 VARIABLE 表中
    IF V_VARTYPE = 'NUMBER' AND V_JUGNUM = 0 THEN
      V_EXESQL := 'INSERT INTO SCMDATA.T_VARIABLE (OBJ_ID,COMPANY_ID,VAR_NAME,VAR_TYPE,VAR_NUMBER) VALUES (:A,:B,:C,:D,:E)';
      EXECUTE IMMEDIATE V_EXESQL USING V_OBJID,V_COMPID,V_VARNAME,V_VARTYPE,V_NUMBER;

    --类型为：NUMBER，存在于 VARIABLE 表中
    ELSIF V_VARTYPE = 'NUMBER' AND V_JUGNUM > 0 THEN
      V_EXESQL := 'UPDATE SCMDATA.T_VARIABLE SET VAR_NUMBER = :A, LAST_UPDTIME = SYSDATE WHERE OBJ_ID = :B AND COMPANY_ID = :C AND VAR_NAME = :D';
      EXECUTE IMMEDIATE V_EXESQL USING V_NUMBER,V_OBJID,V_COMPID,V_VARNAME;

    --类型为：VARCHAR，不存在于 VARIABLE 表中
    ELSIF V_VARTYPE = 'VARCHAR' AND V_JUGNUM = 0  THEN
      V_EXESQL := 'INSERT INTO SCMDATA.T_VARIABLE (OBJ_ID,COMPANY_ID,VAR_NAME,VAR_TYPE,VAR_VARCHAR) VALUES (:A,:B,:C,:D,:E)';
      EXECUTE IMMEDIATE V_EXESQL USING V_OBJID,V_COMPID,V_VARNAME,V_VARTYPE,V_VARCHAR;

    --类型为：VARCHAR，存在于 VARIABLE 表中
    ELSIF V_VARTYPE = 'VARCHAR' AND V_JUGNUM > 0 THEN
      V_EXESQL := 'UPDATE SCMDATA.T_VARIABLE SET VAR_VARCHAR = :A, LAST_UPDTIME = SYSDATE WHERE OBJ_ID = :B AND COMPANY_ID = :C AND VAR_NAME = :D';
      EXECUTE IMMEDIATE V_EXESQL USING V_VARCHAR,V_OBJID,V_COMPID,V_VARNAME;

    --类型为：DATE，不存在于 VARIABLE 表中
    ELSIF V_VARTYPE = 'DATE' AND V_JUGNUM = 0 THEN
      V_EXESQL := 'INSERT INTO SCMDATA.T_VARIABLE (OBJ_ID,COMPANY_ID,VAR_NAME,VAR_TYPE,VAR_DATE) VALUES (:A,:B,:C,:D,:E)';
      EXECUTE IMMEDIATE V_EXESQL USING V_OBJID,V_COMPID,V_VARNAME,V_VARTYPE,V_DATE;

    --类型为：DATE，存在于 VARIABLE 表中
    ELSIF V_VARTYPE = 'DATE' AND V_JUGNUM > 0 THEN
      V_EXESQL := 'UPDATE SCMDATA.T_VARIABLE SET VAR_DATE = :A, LAST_UPDTIME = SYSDATE WHERE OBJ_ID = :B AND COMPANY_ID = :C AND VAR_NAME = :D';
      EXECUTE IMMEDIATE V_EXESQL USING V_DATE,V_OBJID,V_COMPID,V_VARNAME;

    --类型为：CLOB，不存在于 VARIABLE 表中
    ELSIF V_VARTYPE = 'CLOB' AND V_JUGNUM = 0 THEN
      V_EXESQL := 'INSERT INTO SCMDATA.T_VARIABLE (OBJ_ID,COMPANY_ID,VAR_NAME,VAR_TYPE,VAR_CLOB) VALUES (:A,:B,:C,:D,:E)';
      EXECUTE IMMEDIATE V_EXESQL USING V_OBJID,V_COMPID,V_VARNAME,V_VARTYPE,V_CLOB;

    --类型为：CLOB，存在于 VARIABLE 表中
    ELSIF V_VARTYPE = 'CLOB' AND V_JUGNUM > 0 THEN
      V_EXESQL := 'UPDATE SCMDATA.T_VARIABLE SET VAR_CLOB = :A, LAST_UPDTIME = SYSDATE WHERE OBJ_ID = :B AND COMPANY_ID = :C AND VAR_NAME = :D';
      EXECUTE IMMEDIATE V_EXESQL USING V_CLOB,V_OBJID,V_COMPID,V_VARNAME;

    END IF;
  END P_INS_OR_UPD_VARIABLE;



  /*=================================================================================

    变量值插入/更新

    用途:
      用于在 SCMDATA.T_VARIABLE 表中插入/更新一个变量

    入参：
      V_OBJID   :  对象Id，对应 SCMDATA.T_VARIABLE.OBJ_ID
      V_COMPID  :  企业Id
      V_VARNAME :  变量名
      V_VARTYPE :  变量类型
      V_NUMBER  :  变量值（NUMBER类型）
      V_VARCHAR :  变量值（VARCHAR类型）
      V_DATE    :  变量值（DATE类型）
      V_CLOB    :  变量值（CLOB类型）

    版本:
      2021-10-18: NUMBER,VARCHAR,DATE,CLOB类型数据已固定

  =================================================================================*/
  PROCEDURE P_INS_OR_UPD_VARIABLE_AT(V_OBJID   IN VARCHAR2,
                                     V_COMPID  IN VARCHAR2,
                                     V_VARNAME IN VARCHAR2,
                                     V_VARTYPE IN VARCHAR2,
                                     V_NUMBER  IN NUMBER DEFAULT 0,
                                     V_VARCHAR IN VARCHAR2 DEFAULT NULL,
                                     V_DATE    IN DATE DEFAULT NULL,
                                     V_CLOB    IN CLOB DEFAULT NULL) IS
    PRAGMA AUTONOMOUS_TRANSACTION;
    V_JUGNUM   NUMBER(1);
    V_EXESQL   VARCHAR2(2048);
  BEGIN
    SELECT COUNT(1)
      INTO V_JUGNUM
      FROM SCMDATA.T_VARIABLE
     WHERE OBJ_ID = V_OBJID
       AND COMPANY_ID = V_COMPID
       AND VAR_NAME = V_VARNAME
       AND ROWNUM < 2;

    --类型为：NUMBER，不存在于 VARIABLE 表中
    IF V_VARTYPE = 'NUMBER' AND V_JUGNUM = 0 THEN
      V_EXESQL := 'INSERT INTO SCMDATA.T_VARIABLE (OBJ_ID,COMPANY_ID,VAR_NAME,VAR_TYPE,VAR_NUMBER) VALUES (:A,:B,:C,:D,:E)';
      EXECUTE IMMEDIATE V_EXESQL USING V_OBJID,V_COMPID,V_VARNAME,V_VARTYPE,V_NUMBER;

    --类型为：NUMBER，存在于 VARIABLE 表中
    ELSIF V_VARTYPE = 'NUMBER' AND V_JUGNUM > 0 THEN
      V_EXESQL := 'UPDATE SCMDATA.T_VARIABLE SET VAR_NUMBER = :A, LAST_UPDTIME = SYSDATE WHERE OBJ_ID = :B AND COMPANY_ID = :C AND VAR_NAME = :D';
      EXECUTE IMMEDIATE V_EXESQL USING V_NUMBER,V_OBJID,V_COMPID,V_VARNAME;

    --类型为：VARCHAR，不存在于 VARIABLE 表中
    ELSIF V_VARTYPE = 'VARCHAR' AND V_JUGNUM = 0  THEN
      V_EXESQL := 'INSERT INTO SCMDATA.T_VARIABLE (OBJ_ID,COMPANY_ID,VAR_NAME,VAR_TYPE,VAR_VARCHAR) VALUES (:A,:B,:C,:D,:E)';
      EXECUTE IMMEDIATE V_EXESQL USING V_OBJID,V_COMPID,V_VARNAME,V_VARTYPE,V_VARCHAR;

    --类型为：VARCHAR，存在于 VARIABLE 表中
    ELSIF V_VARTYPE = 'VARCHAR' AND V_JUGNUM > 0 THEN
      V_EXESQL := 'UPDATE SCMDATA.T_VARIABLE SET VAR_VARCHAR = :A, LAST_UPDTIME = SYSDATE WHERE OBJ_ID = :B AND COMPANY_ID = :C AND VAR_NAME = :D';
      EXECUTE IMMEDIATE V_EXESQL USING V_VARCHAR,V_OBJID,V_COMPID,V_VARNAME;

    --类型为：DATE，不存在于 VARIABLE 表中
    ELSIF V_VARTYPE = 'DATE' AND V_JUGNUM = 0 THEN
      V_EXESQL := 'INSERT INTO SCMDATA.T_VARIABLE (OBJ_ID,COMPANY_ID,VAR_NAME,VAR_TYPE,VAR_DATE) VALUES (:A,:B,:C,:D,:E)';
      EXECUTE IMMEDIATE V_EXESQL USING V_OBJID,V_COMPID,V_VARNAME,V_VARTYPE,V_DATE;

    --类型为：DATE，存在于 VARIABLE 表中
    ELSIF V_VARTYPE = 'DATE' AND V_JUGNUM > 0 THEN
      V_EXESQL := 'UPDATE SCMDATA.T_VARIABLE SET VAR_DATE = :A, LAST_UPDTIME = SYSDATE WHERE OBJ_ID = :B AND COMPANY_ID = :C AND VAR_NAME = :D';
      EXECUTE IMMEDIATE V_EXESQL USING V_DATE,V_OBJID,V_COMPID,V_VARNAME;

    --类型为：CLOB，不存在于 VARIABLE 表中
    ELSIF V_VARTYPE = 'CLOB' AND V_JUGNUM = 0 THEN
      V_EXESQL := 'INSERT INTO SCMDATA.T_VARIABLE (OBJ_ID,COMPANY_ID,VAR_NAME,VAR_TYPE,VAR_CLOB) VALUES (:A,:B,:C,:D,:E)';
      EXECUTE IMMEDIATE V_EXESQL USING V_OBJID,V_COMPID,V_VARNAME,V_VARTYPE,V_CLOB;

    --类型为：CLOB，存在于 VARIABLE 表中
    ELSIF V_VARTYPE = 'CLOB' AND V_JUGNUM > 0 THEN
      V_EXESQL := 'UPDATE SCMDATA.T_VARIABLE SET VAR_CLOB = :A, LAST_UPDTIME = SYSDATE WHERE OBJ_ID = :B AND COMPANY_ID = :C AND VAR_NAME = :D';
      EXECUTE IMMEDIATE V_EXESQL USING V_CLOB,V_OBJID,V_COMPID,V_VARNAME;

    END IF;
    
    COMMIT;
  END P_INS_OR_UPD_VARIABLE_AT;



  /*=================================================================================

    变量值插入/更新（通过特征值）

    用途:
      用于在 SCMDATA.T_VARIABLE 表中通过特征值插入/更新一个变量

    入参：
      V_OBJID   :  对象Id，对应 SCMDATA.T_VARIABLE.OBJ_ID
      V_COMPID  :  企业Id
      V_VARNAME :  变量名
      V_VARTYPE :  变量类型
      V_NUMBER  :  变量值（NUMBER类型）
      V_VARCHAR :  变量值（VARCHAR类型）
      V_DATE    :  变量值（DATE类型）
      V_CLOB    :  变量值（CLOB类型）
      V_CHAID   :  特征Id，一般为当前操作人User_Id

    版本:
      2021-11-04: 加入CHA_ID以实现某人的全局变量

  =================================================================================*/
  PROCEDURE P_INS_OR_UPD_VARIABLE_WITH_CHAID(V_OBJID   IN VARCHAR2,
                                             V_COMPID  IN VARCHAR2,
                                             V_VARNAME IN VARCHAR2,
                                             V_VARTYPE IN VARCHAR2,
                                             V_NUMBER  IN NUMBER DEFAULT 0,
                                             V_VARCHAR IN VARCHAR2 DEFAULT NULL,
                                             V_DATE    IN DATE DEFAULT NULL,
                                             V_CLOB    IN CLOB DEFAULT NULL,
                                             V_CHAID   IN VARCHAR2) IS
    V_JUGNUM   NUMBER(1);
    V_EXESQL   VARCHAR2(2048);
  BEGIN
    SELECT COUNT(1)
      INTO V_JUGNUM
      FROM SCMDATA.T_VARIABLE_CHA
     WHERE OBJ_ID = V_OBJID
       AND COMPANY_ID = V_COMPID
       AND VAR_NAME = V_VARNAME
       AND CHA_ID = V_CHAID
       AND ROWNUM = 1;

    --类型为：NUMBER，不存在于 VARIABLE 表中
    IF V_VARTYPE = 'NUMBER' AND V_JUGNUM = 0 THEN
      V_EXESQL := 'INSERT INTO SCMDATA.T_VARIABLE_CHA  (OBJ_ID,COMPANY_ID,VAR_NAME,VAR_TYPE,VAR_NUMBER,CHA_ID) VALUES (:A,:B,:C,:D,:E,:F)';
      EXECUTE IMMEDIATE V_EXESQL USING V_OBJID,V_COMPID,V_VARNAME,V_VARTYPE,V_NUMBER,V_CHAID;

    --类型为：NUMBER，存在于 VARIABLE 表中
    ELSIF V_VARTYPE = 'NUMBER' AND V_JUGNUM > 0 THEN
      V_EXESQL := 'UPDATE SCMDATA.T_VARIABLE_CHA SET VAR_NUMBER = :A, LAST_UPDTIME = SYSDATE WHERE OBJ_ID = :B AND COMPANY_ID = :C AND VAR_NAME = :D AND CHA_ID = :E';
      EXECUTE IMMEDIATE V_EXESQL USING V_NUMBER,V_OBJID,V_COMPID,V_VARNAME,V_CHAID;

    --类型为：VARCHAR，不存在于 VARIABLE 表中
    ELSIF V_VARTYPE = 'VARCHAR' AND V_JUGNUM = 0  THEN
      V_EXESQL := 'INSERT INTO SCMDATA.T_VARIABLE_CHA (OBJ_ID,COMPANY_ID,VAR_NAME,VAR_TYPE,VAR_VARCHAR,CHA_ID) VALUES (:A,:B,:C,:D,:E,:F)';
      EXECUTE IMMEDIATE V_EXESQL USING V_OBJID,V_COMPID,V_VARNAME,V_VARTYPE,V_VARCHAR,V_CHAID;

    --类型为：VARCHAR，存在于 VARIABLE 表中
    ELSIF V_VARTYPE = 'VARCHAR' AND V_JUGNUM > 0 THEN
      V_EXESQL := 'UPDATE SCMDATA.T_VARIABLE_CHA SET VAR_VARCHAR = :A, LAST_UPDTIME = SYSDATE WHERE OBJ_ID = :B AND COMPANY_ID = :C AND VAR_NAME = :D AND CHA_ID = :E';
      EXECUTE IMMEDIATE V_EXESQL USING V_VARCHAR,V_OBJID,V_COMPID,V_VARNAME,V_CHAID;

    --类型为：DATE，不存在于 VARIABLE 表中
    ELSIF V_VARTYPE = 'DATE' AND V_JUGNUM = 0 THEN
      V_EXESQL := 'INSERT INTO SCMDATA.T_VARIABLE_CHA (OBJ_ID,COMPANY_ID,VAR_NAME,VAR_TYPE,VAR_DATE,CHA_ID) VALUES (:A,:B,:C,:D,:E,:F)';
      EXECUTE IMMEDIATE V_EXESQL USING V_OBJID,V_COMPID,V_VARNAME,V_VARTYPE,V_DATE,V_CHAID;

    --类型为：DATE，存在于 VARIABLE 表中
    ELSIF V_VARTYPE = 'DATE' AND V_JUGNUM > 0 THEN
      V_EXESQL := 'UPDATE SCMDATA.T_VARIABLE_CHA SET VAR_DATE = :A, LAST_UPDTIME = SYSDATE WHERE OBJ_ID = :B AND COMPANY_ID = :C AND VAR_NAME = :D AND CHA_ID = :E';
      EXECUTE IMMEDIATE V_EXESQL USING V_DATE,V_OBJID,V_COMPID,V_VARNAME,V_CHAID;

    --类型为：CLOB，不存在于 VARIABLE 表中
    ELSIF V_VARTYPE = 'CLOB' AND V_JUGNUM = 0 THEN
      V_EXESQL := 'INSERT INTO SCMDATA.T_VARIABLE_CHA (OBJ_ID,COMPANY_ID,VAR_NAME,VAR_TYPE,VAR_CLOB,CHA_ID) VALUES (:A,:B,:C,:D,:E,:F)';
      EXECUTE IMMEDIATE V_EXESQL USING V_OBJID,V_COMPID,V_VARNAME,V_VARTYPE,V_CLOB,V_CHAID;

    --类型为：CLOB，存在于 VARIABLE 表中
    ELSIF V_VARTYPE = 'CLOB' AND V_JUGNUM > 0 THEN
      V_EXESQL := 'UPDATE SCMDATA.T_VARIABLE_CHA SET VAR_CLOB = :A, LAST_UPDTIME = SYSDATE WHERE OBJ_ID = :B AND COMPANY_ID = :C AND VAR_NAME = :D AND CHA_ID = :E';
      EXECUTE IMMEDIATE V_EXESQL USING V_CLOB,V_OBJID,V_COMPID,V_VARNAME,V_CHAID;

    END IF;
  END P_INS_OR_UPD_VARIABLE_WITH_CHAID;
  
  
  
  /*=================================================================================

    变量值插入/更新（通过特征值）

    用途:
      用于在 SCMDATA.T_VARIABLE 表中通过特征值插入/更新一个变量

    入参：
      V_OBJID   :  对象Id，对应 SCMDATA.T_VARIABLE.OBJ_ID
      V_COMPID  :  企业Id
      V_VARNAME :  变量名
      V_VARTYPE :  变量类型
      V_NUMBER  :  变量值（NUMBER类型）
      V_VARCHAR :  变量值（VARCHAR类型）
      V_DATE    :  变量值（DATE类型）
      V_CLOB    :  变量值（CLOB类型）
      V_CHAID   :  特征Id，一般为当前操作人User_Id

    版本:
      2021-11-04: 加入CHA_ID以实现某人的全局变量

  =================================================================================*/
  PROCEDURE P_INS_OR_UPD_VARIABLE_WITH_CHAID_AT(V_OBJID   IN VARCHAR2,
                                                V_COMPID  IN VARCHAR2,
                                                V_VARNAME IN VARCHAR2,
                                                V_VARTYPE IN VARCHAR2,
                                                V_NUMBER  IN NUMBER DEFAULT 0,
                                                V_VARCHAR IN VARCHAR2 DEFAULT NULL,
                                                V_DATE    IN DATE DEFAULT NULL,
                                                V_CLOB    IN CLOB DEFAULT NULL,
                                                V_CHAID   IN VARCHAR2) IS
    PRAGMA AUTONOMOUS_TRANSACTION;
    V_JUGNUM   NUMBER(1);
    V_EXESQL   VARCHAR2(2048);
  BEGIN
    SELECT COUNT(1)
      INTO V_JUGNUM
      FROM SCMDATA.T_VARIABLE_CHA
     WHERE OBJ_ID = V_OBJID
       AND COMPANY_ID = V_COMPID
       AND VAR_NAME = V_VARNAME
       AND CHA_ID = V_CHAID
       AND ROWNUM = 1;

    --类型为：NUMBER，不存在于 VARIABLE 表中
    IF V_VARTYPE = 'NUMBER' AND V_JUGNUM = 0 THEN
      V_EXESQL := 'INSERT INTO SCMDATA.T_VARIABLE_CHA  (OBJ_ID,COMPANY_ID,VAR_NAME,VAR_TYPE,VAR_NUMBER,CHA_ID) VALUES (:A,:B,:C,:D,:E,:F)';
      EXECUTE IMMEDIATE V_EXESQL USING V_OBJID,V_COMPID,V_VARNAME,V_VARTYPE,V_NUMBER,V_CHAID;

    --类型为：NUMBER，存在于 VARIABLE 表中
    ELSIF V_VARTYPE = 'NUMBER' AND V_JUGNUM > 0 THEN
      V_EXESQL := 'UPDATE SCMDATA.T_VARIABLE_CHA SET VAR_NUMBER = :A, LAST_UPDTIME = SYSDATE WHERE OBJ_ID = :B AND COMPANY_ID = :C AND VAR_NAME = :D AND CHA_ID = :E';
      EXECUTE IMMEDIATE V_EXESQL USING V_NUMBER,V_OBJID,V_COMPID,V_VARNAME,V_CHAID;

    --类型为：VARCHAR，不存在于 VARIABLE 表中
    ELSIF V_VARTYPE = 'VARCHAR' AND V_JUGNUM = 0  THEN
      V_EXESQL := 'INSERT INTO SCMDATA.T_VARIABLE_CHA (OBJ_ID,COMPANY_ID,VAR_NAME,VAR_TYPE,VAR_VARCHAR,CHA_ID) VALUES (:A,:B,:C,:D,:E,:F)';
      EXECUTE IMMEDIATE V_EXESQL USING V_OBJID,V_COMPID,V_VARNAME,V_VARTYPE,V_VARCHAR,V_CHAID;

    --类型为：VARCHAR，存在于 VARIABLE 表中
    ELSIF V_VARTYPE = 'VARCHAR' AND V_JUGNUM > 0 THEN
      V_EXESQL := 'UPDATE SCMDATA.T_VARIABLE_CHA SET VAR_VARCHAR = :A, LAST_UPDTIME = SYSDATE WHERE OBJ_ID = :B AND COMPANY_ID = :C AND VAR_NAME = :D AND CHA_ID = :E';
      EXECUTE IMMEDIATE V_EXESQL USING V_VARCHAR,V_OBJID,V_COMPID,V_VARNAME,V_CHAID;

    --类型为：DATE，不存在于 VARIABLE 表中
    ELSIF V_VARTYPE = 'DATE' AND V_JUGNUM = 0 THEN
      V_EXESQL := 'INSERT INTO SCMDATA.T_VARIABLE_CHA (OBJ_ID,COMPANY_ID,VAR_NAME,VAR_TYPE,VAR_DATE,CHA_ID) VALUES (:A,:B,:C,:D,:E,:F)';
      EXECUTE IMMEDIATE V_EXESQL USING V_OBJID,V_COMPID,V_VARNAME,V_VARTYPE,V_DATE,V_CHAID;

    --类型为：DATE，存在于 VARIABLE 表中
    ELSIF V_VARTYPE = 'DATE' AND V_JUGNUM > 0 THEN
      V_EXESQL := 'UPDATE SCMDATA.T_VARIABLE_CHA SET VAR_DATE = :A, LAST_UPDTIME = SYSDATE WHERE OBJ_ID = :B AND COMPANY_ID = :C AND VAR_NAME = :D AND CHA_ID = :E';
      EXECUTE IMMEDIATE V_EXESQL USING V_DATE,V_OBJID,V_COMPID,V_VARNAME,V_CHAID;

    --类型为：CLOB，不存在于 VARIABLE 表中
    ELSIF V_VARTYPE = 'CLOB' AND V_JUGNUM = 0 THEN
      V_EXESQL := 'INSERT INTO SCMDATA.T_VARIABLE_CHA (OBJ_ID,COMPANY_ID,VAR_NAME,VAR_TYPE,VAR_CLOB,CHA_ID) VALUES (:A,:B,:C,:D,:E,:F)';
      EXECUTE IMMEDIATE V_EXESQL USING V_OBJID,V_COMPID,V_VARNAME,V_VARTYPE,V_CLOB,V_CHAID;

    --类型为：CLOB，存在于 VARIABLE 表中
    ELSIF V_VARTYPE = 'CLOB' AND V_JUGNUM > 0 THEN
      V_EXESQL := 'UPDATE SCMDATA.T_VARIABLE_CHA SET VAR_CLOB = :A, LAST_UPDTIME = SYSDATE WHERE OBJ_ID = :B AND COMPANY_ID = :C AND VAR_NAME = :D AND CHA_ID = :E';
      EXECUTE IMMEDIATE V_EXESQL USING V_CLOB,V_OBJID,V_COMPID,V_VARNAME,V_CHAID;

    END IF;
    COMMIT;
  END P_INS_OR_UPD_VARIABLE_WITH_CHAID_AT;



  /*=================================================================================

    获取 VARCHAR 类型变量

    用途:
      用于在 SCMDATA.T_VARIABLE 表中获取一个 VARCHAR 类型的变量

    入参：
      V_OBJID   :  对象Id，对应 SCMDATA.T_VARIABLE.OBJ_ID
      V_COMPID  :  企业Id
      V_VARNAME :  变量名

    版本:
      2021-10-18: 该函数已固定

  =================================================================================*/
  FUNCTION F_GET_VARCHAR(V_OBJID   IN VARCHAR2,
                         V_COMPID  IN VARCHAR2,
                         V_VARNAME IN VARCHAR2) RETURN VARCHAR2 IS
    RET_STR  VARCHAR2(128);
  BEGIN
    SELECT MAX(VAR_VARCHAR)
      INTO RET_STR
      FROM SCMDATA.T_VARIABLE
     WHERE OBJ_ID = V_OBJID
       AND COMPANY_ID = V_COMPID
       AND VAR_NAME = V_VARNAME
       AND VAR_TYPE = 'VARCHAR';
    RETURN RET_STR;
  END F_GET_VARCHAR;



  /*=================================================================================

    获取 VARCHAR 类型变量（通过特征值）

    用途:
      用于在 SCMDATA.T_VARIABLE 表中通过特征值获取一个 VARCHAR 类型的变量

    入参：
      V_OBJID   :  对象Id，对应 SCMDATA.T_VARIABLE.OBJ_ID
      V_COMPID  :  企业Id
      V_VARNAME :  变量名
      V_CHAID   :  特征Id，一般为当前操作人User_Id

    版本:
      2021-11-04: 该函数已固定

  =================================================================================*/
  FUNCTION F_GET_VARCHAR_WITH_CHAID(V_OBJID   IN VARCHAR2,
                                    V_COMPID  IN VARCHAR2,
                                    V_VARNAME IN VARCHAR2,
                                    V_CHAID   IN VARCHAR2) RETURN VARCHAR2 IS
    RET_STR  VARCHAR2(128);
  BEGIN
    SELECT MAX(VAR_VARCHAR)
      INTO RET_STR
      FROM SCMDATA.T_VARIABLE_CHA
     WHERE OBJ_ID = V_OBJID
       AND COMPANY_ID = V_COMPID
       AND VAR_NAME = V_VARNAME
       AND VAR_TYPE = 'VARCHAR'
       AND CHA_ID = V_CHAID;
    RETURN RET_STR;
  END F_GET_VARCHAR_WITH_CHAID;




  /*=================================================================================

    获取 NUMBER 类型变量

    用途:
      用于在 SCMDATA.T_VARIABLE 表中获取一个 NUMBER 类型的变量

    入参：
      V_OBJID   :  对象Id，对应 SCMDATA.T_VARIABLE.OBJ_ID
      V_COMPID  :  企业Id
      V_VARNAME :  变量名

    版本:
      2021-10-18: 该函数已固定

  =================================================================================*/
  FUNCTION F_GET_NUMBER(V_OBJID   IN VARCHAR2,
                        V_COMPID  IN VARCHAR2,
                        V_VARNAME IN VARCHAR2) RETURN NUMBER IS
    RET_NUM  NUMBER(16);
  BEGIN
    SELECT MAX(VAR_NUMBER)
      INTO RET_NUM
      FROM SCMDATA.T_VARIABLE
     WHERE OBJ_ID = V_OBJID
       AND COMPANY_ID = V_COMPID
       AND VAR_NAME = V_VARNAME
       AND VAR_TYPE = 'NUMBER';
    RETURN RET_NUM;
  END F_GET_NUMBER;



  /*=================================================================================

    获取 NUMBER 类型变量（通过特征值）

    用途:
      用于在 SCMDATA.T_VARIABLE 表中通过特征值获取一个 NUMBER 类型的变量

    入参：
      V_OBJID   :  对象Id，对应 SCMDATA.T_VARIABLE.OBJ_ID
      V_COMPID  :  企业Id
      V_VARNAME :  变量名
      V_CHAID   :  特征Id，一般为当前操作人User_Id

    版本:
      2021-11-04 : 该函数已固定

  =================================================================================*/
  FUNCTION F_GET_NUMBER_WITH_CHAID(V_OBJID   IN VARCHAR2,
                                   V_COMPID  IN VARCHAR2,
                                   V_VARNAME IN VARCHAR2,
                                   V_CHAID   IN VARCHAR2) RETURN NUMBER IS
    RET_NUM  NUMBER(16);
  BEGIN
    SELECT MAX(VAR_NUMBER)
      INTO RET_NUM
      FROM SCMDATA.T_VARIABLE_CHA
     WHERE OBJ_ID = V_OBJID
       AND COMPANY_ID = V_COMPID
       AND VAR_NAME = V_VARNAME
       AND VAR_TYPE = 'NUMBER'
       AND CHA_ID = V_CHAID;
    RETURN RET_NUM;
  END F_GET_NUMBER_WITH_CHAID;




  /*=================================================================================

    获取 DATE 类型变量

    用途:
      用于在 SCMDATA.T_VARIABLE 表中获取一个 DATE 类型的变量

    入参：
      V_OBJID   :  对象Id，对应 SCMDATA.T_VARIABLE.OBJ_ID
      V_COMPID  :  企业Id
      V_VARNAME :  变量名
      V_CHAID   :  特征Id，一般为当前操作人User_Id

    版本:
      2021-10-18 : 该函数已固定

  =================================================================================*/
  FUNCTION F_GET_DATE(V_OBJID   IN VARCHAR2,
                      V_COMPID  IN VARCHAR2,
                      V_VARNAME IN VARCHAR2) RETURN DATE IS
    RET_DATE  DATE;
  BEGIN
    SELECT MAX(VAR_DATE)
      INTO RET_DATE
      FROM SCMDATA.T_VARIABLE
     WHERE OBJ_ID = V_OBJID
       AND COMPANY_ID = V_COMPID
       AND VAR_NAME = V_VARNAME
       AND VAR_TYPE = 'DATE';
    RETURN RET_DATE;
  END F_GET_DATE;




  /*=================================================================================

    获取 DATE 类型变量（通过特征值）

    用途:
      用于在 SCMDATA.T_VARIABLE 表中通过特征值获取一个 DATE 类型的变量

    入参：
      V_OBJID    :  对象Id，对应 SCMDATA.T_VARIABLE.OBJ_ID
      V_COMPID   :  企业Id
      V_VARNAME  :  变量名
      V_CHAID   :  特征Id，一般为当前操作人User_Id

    版本:
      2021-11-04 : 该函数已固定

  =================================================================================*/
  FUNCTION F_GET_DATE_WITH_CHAID(V_OBJID   IN VARCHAR2,
                                 V_COMPID  IN VARCHAR2,
                                 V_VARNAME IN VARCHAR2,
                                 V_CHAID   IN VARCHAR2) RETURN DATE IS
    RET_DATE  DATE;
  BEGIN
    SELECT MAX(VAR_DATE)
      INTO RET_DATE
      FROM SCMDATA.T_VARIABLE_CHA
     WHERE OBJ_ID = V_OBJID
       AND COMPANY_ID = V_COMPID
       AND VAR_NAME = V_VARNAME
       AND VAR_TYPE = 'DATE'
       AND CHA_ID = V_CHAID;
    RETURN RET_DATE;
  END F_GET_DATE_WITH_CHAID;




  /*=================================================================================

    获取 CLOB 类型变量

    用途:
      用于在 SCMDATA.T_VARIABLE 表中获取一个 CLOB 类型的变量

    入参：
      V_OBJID    :  对象Id，对应 SCMDATA.T_VARIABLE.OBJ_ID
      V_COMPID   :  企业Id
      V_VARNAME  :  变量名

    版本:
      2021-10-18 : 该函数已固定

  =================================================================================*/
  FUNCTION F_GET_CLOB(V_OBJID   IN VARCHAR2,
                      V_COMPID  IN VARCHAR2,
                      V_VARNAME IN VARCHAR2) RETURN CLOB IS
    V_JUGNUM  NUMBER;
    RET_CLOB  CLOB;
  BEGIN
    SELECT COUNT(1)
      INTO V_JUGNUM
      FROM SCMDATA.T_VARIABLE
     WHERE OBJ_ID = V_OBJID
       AND COMPANY_ID = V_COMPID
       AND VAR_NAME = V_VARNAME
       AND VAR_TYPE = 'CLOB'
       AND ROWNUM = 1;

    IF V_JUGNUM > 0 THEN
      SELECT VAR_CLOB
        INTO RET_CLOB
        FROM SCMDATA.T_VARIABLE
       WHERE OBJ_ID = V_OBJID
         AND COMPANY_ID = V_COMPID
         AND VAR_NAME = V_VARNAME
         AND VAR_TYPE = 'CLOB';
    END IF;
    RETURN RET_CLOB;
  END F_GET_CLOB;



  /*=================================================================================

    获取 CLOB 类型变量（通过特征值）

    用途:
      用于在 SCMDATA.T_VARIABLE 表中通过特征值获取一个 CLOB 类型的变量

    入参：
      V_OBJID    :  对象Id，对应 SCMDATA.T_VARIABLE.OBJ_ID
      V_COMPID   :  企业Id
      V_VARNAME  :  变量名
      V_CHAID   :  特征Id，一般为当前操作人User_Id

    版本:
      2021-11-04 : 该函数已固定

  =================================================================================*/
  FUNCTION F_GET_CLOB_WITH_CHAID(V_OBJID   IN VARCHAR2,
                                 V_COMPID  IN VARCHAR2,
                                 V_VARNAME IN VARCHAR2,
                                 V_CHAID   IN VARCHAR2) RETURN CLOB IS
    V_JUGNUM  NUMBER;
    RET_CLOB  CLOB;
  BEGIN
    SELECT COUNT(1)
      INTO V_JUGNUM
      FROM SCMDATA.T_VARIABLE_CHA
     WHERE OBJ_ID = V_OBJID
       AND COMPANY_ID = V_COMPID
       AND VAR_NAME = V_VARNAME
       AND VAR_TYPE = 'CLOB'
       AND CHA_ID = V_CHAID
       AND ROWNUM = 1;

    IF V_JUGNUM > 0 THEN
      SELECT VAR_CLOB
        INTO RET_CLOB
        FROM SCMDATA.T_VARIABLE_CHA
       WHERE OBJ_ID = V_OBJID
         AND COMPANY_ID = V_COMPID
         AND VAR_NAME = V_VARNAME
         AND VAR_TYPE = 'CLOB'
         AND CHA_ID = V_CHAID;
    END IF;
    RETURN RET_CLOB;
  END F_GET_CLOB_WITH_CHAID;



  /*=================================================================================

    SCMDATA.T_VARIABLE 表特定名称 NUMBER 类型数据自增1

    用途:
      用于对 SCMDATA.T_VARIABLE 表中一个 NUMBER 类型的变量自增1，
      并修改最后更新时间为当前时间

    入参：
      V_OBJID    :  对象Id，对应 SCMDATA.T_VARIABLE.OBJ_ID
      V_COMPID   :  企业Id
      V_VARNAME  :  变量名

    版本:
      2021-10-18: 该过程已固定

  =================================================================================*/
  PROCEDURE P_SET_VARIABLE_INCREMENT(V_OBJID     IN VARCHAR2,
                                     V_COMPID    IN VARCHAR2,
                                     V_VARNAME   IN VARCHAR2) IS
  BEGIN
    UPDATE SCMDATA.T_VARIABLE T
       SET VAR_NUMBER   = NVL(T.VAR_NUMBER,0)+1,
           LAST_UPDTIME = SYSDATE
     WHERE OBJ_ID     = V_OBJID
       AND COMPANY_ID = V_COMPID
       AND VAR_NAME   = V_VARNAME;
  END P_SET_VARIABLE_INCREMENT;



  /*=================================================================================

    SCMDATA.T_VARIABLE 表特定名称 NUMBER 类型数据自增1（通过特征值）

    用途:
      通过特征对 SCMDATA.T_VARIABLE 表中值一个 NUMBER 类型的变量自增1，
      并修改最后更新时间为当前时间

    入参：
      V_OBJID   :  对象Id，对应 SCMDATA.T_VARIABLE.OBJ_ID
      V_COMPID  :  企业Id
      V_VARNAME :  变量名
      V_CHAID   :  特征Id，一般为当前操作人User_Id

    版本:
      2021-11-04 : 该过程已固定

  =================================================================================*/
  PROCEDURE P_SET_VARIABLE_INCREMENT_WITH_CHAID(V_OBJID     IN VARCHAR2,
                                                V_COMPID    IN VARCHAR2,
                                                V_VARNAME   IN VARCHAR2,
                                                V_CHAID     IN VARCHAR2) IS
  BEGIN
    UPDATE SCMDATA.T_VARIABLE_CHA T
       SET VAR_NUMBER   = NVL(T.VAR_NUMBER,0)+1,
           LAST_UPDTIME = SYSDATE
     WHERE OBJ_ID     = V_OBJID
       AND COMPANY_ID = V_COMPID
       AND VAR_NAME   = V_VARNAME
       AND CHA_ID     = V_CHAID;
  END P_SET_VARIABLE_INCREMENT_WITH_CHAID;



  /*=================================================================================

    对 SCMDATA.T_VARIABLE 表中 CLOB 类型数据追加新数据

    用途:
      用于对 SCMDATA.T_VARIABLE 表中一个 NUMBER 类型的变量自增1，
      并修改最后更新时间为当前时间

    入参：
      V_OBJID   :  对象Id，对应 SCMDATA.T_VARIABLE.OBJ_ID
      V_COMPID  :  企业Id
      V_VARNAME :  变量名
      V_APPSTR  :  追加字段

    版本:
      2021-10-18: 该过程已固定

  =================================================================================*/
  PROCEDURE P_APPEND_CLOB_VARIABLE(V_OBJID   IN VARCHAR2,
                                   V_COMPID  IN VARCHAR2,
                                   V_VARNAME IN VARCHAR2,
                                   V_APPSTR  IN VARCHAR2) IS
    V_CLOB    CLOB;
  BEGIN
    V_CLOB := F_GET_CLOB(V_OBJID   => V_OBJID,
                         V_COMPID  => V_COMPID,
                         V_VARNAME => V_VARNAME);
    IF INSTR(V_CLOB,V_APPSTR) = 0 OR V_CLOB IS NULL THEN
      UPDATE SCMDATA.T_VARIABLE T
         SET VAR_CLOB = T.VAR_CLOB || CHR(10) || V_APPSTR,
             LAST_UPDTIME = SYSDATE
       WHERE OBJ_ID = V_OBJID
         AND COMPANY_ID = V_COMPID
         AND VAR_NAME = V_VARNAME
         AND VAR_TYPE = 'CLOB';
    END IF;
  END P_APPEND_CLOB_VARIABLE;



  /*=================================================================================

    对 SCMDATA.T_VARIABLE 表中 CLOB 类型数据追加新数据（通过特征值）

    用途:
      通过特征值对 SCMDATA.T_VARIABLE 表中一个 NUMBER 类型的变量自增1，
      并修改最后更新时间为当前时间

    入参：
      V_OBJID   :  对象Id，对应 SCMDATA.T_VARIABLE.OBJ_ID
      V_COMPID  :  企业Id
      V_VARNAME :  变量名
      V_APPSTR  :  追加字段
      V_CHAID   :  特征Id，一般为当前操作人User_Id

    版本:
      2021-11-04 : 该过程已固定

  =================================================================================*/
  PROCEDURE P_APPEND_CLOB_VARIABLE_WITH_CHAID(V_OBJID   IN VARCHAR2,
                                              V_COMPID  IN VARCHAR2,
                                              V_VARNAME IN VARCHAR2,
                                              V_APPSTR  IN VARCHAR2,
                                              V_CHAID   IN VARCHAR2) IS
    V_CLOB    CLOB;
  BEGIN
    V_CLOB := F_GET_CLOB_WITH_CHAID(V_OBJID   => V_OBJID,
                                    V_COMPID  => V_COMPID,
                                    V_VARNAME => V_VARNAME,
                                    V_CHAID   => V_CHAID);
    IF INSTR(V_CLOB,V_APPSTR) = 0 OR V_CLOB IS NULL THEN
      UPDATE SCMDATA.T_VARIABLE_CHA T
         SET VAR_CLOB     = T.VAR_CLOB || CHR(10) || V_APPSTR,
             LAST_UPDTIME = SYSDATE
       WHERE OBJ_ID     = V_OBJID
         AND COMPANY_ID = V_COMPID
         AND VAR_NAME   = V_VARNAME
         AND VAR_TYPE   = 'CLOB'
         AND CHA_ID     = V_CHAID;
    END IF;
  END P_APPEND_CLOB_VARIABLE_WITH_CHAID;

END PKG_VARIABLE;
/

