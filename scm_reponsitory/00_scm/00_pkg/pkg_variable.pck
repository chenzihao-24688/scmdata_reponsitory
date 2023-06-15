CREATE OR REPLACE PACKAGE SCMDATA.pkg_variable IS

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
  PROCEDURE p_ins_or_upd_variable(v_objid   IN VARCHAR2,
                                  v_compid  IN VARCHAR2,
                                  v_varname IN VARCHAR2,
                                  v_vartype IN VARCHAR2,
                                  v_number  IN NUMBER DEFAULT 0,
                                  v_varchar IN VARCHAR2 DEFAULT NULL,
                                  v_date    IN DATE DEFAULT NULL,
                                  v_clob    IN CLOB DEFAULT NULL);

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
  PROCEDURE p_ins_or_upd_variable_at(v_objid   IN VARCHAR2,
                                     v_compid  IN VARCHAR2,
                                     v_varname IN VARCHAR2,
                                     v_vartype IN VARCHAR2,
                                     v_number  IN NUMBER DEFAULT 0,
                                     v_varchar IN VARCHAR2 DEFAULT NULL,
                                     v_date    IN DATE DEFAULT NULL,
                                     v_clob    IN CLOB DEFAULT NULL);

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
  PROCEDURE p_ins_or_upd_variable_with_chaid(v_objid   IN VARCHAR2,
                                             v_compid  IN VARCHAR2,
                                             v_varname IN VARCHAR2,
                                             v_vartype IN VARCHAR2,
                                             v_number  IN NUMBER DEFAULT 0,
                                             v_varchar IN VARCHAR2 DEFAULT NULL,
                                             v_date    IN DATE DEFAULT NULL,
                                             v_clob    IN CLOB DEFAULT NULL,
                                             v_chaid   IN VARCHAR2);

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
  PROCEDURE p_ins_or_upd_variable_with_chaid_at(v_objid   IN VARCHAR2,
                                                v_compid  IN VARCHAR2,
                                                v_varname IN VARCHAR2,
                                                v_vartype IN VARCHAR2,
                                                v_number  IN NUMBER DEFAULT 0,
                                                v_varchar IN VARCHAR2 DEFAULT NULL,
                                                v_date    IN DATE DEFAULT NULL,
                                                v_clob    IN CLOB DEFAULT NULL,
                                                v_chaid   IN VARCHAR2);

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
  FUNCTION f_get_varchar(v_objid   IN VARCHAR2,
                         v_compid  IN VARCHAR2,
                         v_varname IN VARCHAR2) RETURN VARCHAR2;

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
  FUNCTION f_get_varchar_with_chaid(v_objid   IN VARCHAR2,
                                    v_compid  IN VARCHAR2,
                                    v_varname IN VARCHAR2,
                                    v_chaid   IN VARCHAR2) RETURN VARCHAR2;

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
  FUNCTION f_get_number(v_objid   IN VARCHAR2,
                        v_compid  IN VARCHAR2,
                        v_varname IN VARCHAR2) RETURN NUMBER;

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
  FUNCTION f_get_number_with_chaid(v_objid   IN VARCHAR2,
                                   v_compid  IN VARCHAR2,
                                   v_varname IN VARCHAR2,
                                   v_chaid   IN VARCHAR2) RETURN NUMBER;

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
  FUNCTION f_get_date(v_objid   IN VARCHAR2,
                      v_compid  IN VARCHAR2,
                      v_varname IN VARCHAR2) RETURN DATE;

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
  FUNCTION f_get_date_with_chaid(v_objid   IN VARCHAR2,
                                 v_compid  IN VARCHAR2,
                                 v_varname IN VARCHAR2,
                                 v_chaid   IN VARCHAR2) RETURN DATE;

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
  FUNCTION f_get_clob(v_objid   IN VARCHAR2,
                      v_compid  IN VARCHAR2,
                      v_varname IN VARCHAR2) RETURN CLOB;

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
  FUNCTION f_get_clob_with_chaid(v_objid   IN VARCHAR2,
                                 v_compid  IN VARCHAR2,
                                 v_varname IN VARCHAR2,
                                 v_chaid   IN VARCHAR2) RETURN CLOB;

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
  PROCEDURE p_set_variable_increment(v_objid   IN VARCHAR2,
                                     v_compid  IN VARCHAR2,
                                     v_varname IN VARCHAR2);

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
  PROCEDURE p_set_variable_increment_with_chaid(v_objid   IN VARCHAR2,
                                                v_compid  IN VARCHAR2,
                                                v_varname IN VARCHAR2,
                                                v_chaid   IN VARCHAR2);

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
  PROCEDURE p_append_clob_variable(v_objid   IN VARCHAR2,
                                   v_compid  IN VARCHAR2,
                                   v_varname IN VARCHAR2,
                                   v_appstr  IN VARCHAR2);

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
  PROCEDURE p_append_clob_variable_with_chaid(v_objid   IN VARCHAR2,
                                              v_compid  IN VARCHAR2,
                                              v_varname IN VARCHAR2,
                                              v_appstr  IN VARCHAR2,
                                              v_chaid   IN VARCHAR2);

END pkg_variable;
/

CREATE OR REPLACE PACKAGE BODY SCMDATA.pkg_variable IS

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
  PROCEDURE p_ins_or_upd_variable(v_objid   IN VARCHAR2,
                                  v_compid  IN VARCHAR2,
                                  v_varname IN VARCHAR2,
                                  v_vartype IN VARCHAR2,
                                  v_number  IN NUMBER DEFAULT 0,
                                  v_varchar IN VARCHAR2 DEFAULT NULL,
                                  v_date    IN DATE DEFAULT NULL,
                                  v_clob    IN CLOB DEFAULT NULL) IS
    v_jugnum NUMBER(1);
    v_exesql VARCHAR2(2048);
  BEGIN
    SELECT COUNT(1)
      INTO v_jugnum
      FROM scmdata.t_variable
     WHERE obj_id = v_objid
       AND company_id = v_compid
       AND var_name = v_varname
       AND rownum < 2;
  
    --类型为：NUMBER，不存在于 VARIABLE 表中
    IF v_vartype = 'NUMBER'
       AND v_jugnum = 0 THEN
      v_exesql := 'INSERT INTO SCMDATA.T_VARIABLE (OBJ_ID,COMPANY_ID,VAR_NAME,VAR_TYPE,VAR_NUMBER) VALUES (:A,:B,:C,:D,:E)';
      EXECUTE IMMEDIATE v_exesql
        USING v_objid, v_compid, v_varname, v_vartype, v_number;
    
      --类型为：NUMBER，存在于 VARIABLE 表中
    ELSIF v_vartype = 'NUMBER'
          AND v_jugnum > 0 THEN
      v_exesql := 'UPDATE SCMDATA.T_VARIABLE SET VAR_NUMBER = :A, LAST_UPDTIME = SYSDATE WHERE OBJ_ID = :B AND COMPANY_ID = :C AND VAR_NAME = :D';
      EXECUTE IMMEDIATE v_exesql
        USING v_number, v_objid, v_compid, v_varname;
    
      --类型为：VARCHAR，不存在于 VARIABLE 表中
    ELSIF v_vartype = 'VARCHAR'
          AND v_jugnum = 0 THEN
      v_exesql := 'INSERT INTO SCMDATA.T_VARIABLE (OBJ_ID,COMPANY_ID,VAR_NAME,VAR_TYPE,VAR_VARCHAR) VALUES (:A,:B,:C,:D,:E)';
      EXECUTE IMMEDIATE v_exesql
        USING v_objid, v_compid, v_varname, v_vartype, v_varchar;
    
      --类型为：VARCHAR，存在于 VARIABLE 表中
    ELSIF v_vartype = 'VARCHAR'
          AND v_jugnum > 0 THEN
      v_exesql := 'UPDATE SCMDATA.T_VARIABLE SET VAR_VARCHAR = :A, LAST_UPDTIME = SYSDATE WHERE OBJ_ID = :B AND COMPANY_ID = :C AND VAR_NAME = :D';
      EXECUTE IMMEDIATE v_exesql
        USING v_varchar, v_objid, v_compid, v_varname;
    
      --类型为：DATE，不存在于 VARIABLE 表中
    ELSIF v_vartype = 'DATE'
          AND v_jugnum = 0 THEN
      v_exesql := 'INSERT INTO SCMDATA.T_VARIABLE (OBJ_ID,COMPANY_ID,VAR_NAME,VAR_TYPE,VAR_DATE) VALUES (:A,:B,:C,:D,:E)';
      EXECUTE IMMEDIATE v_exesql
        USING v_objid, v_compid, v_varname, v_vartype, v_date;
    
      --类型为：DATE，存在于 VARIABLE 表中
    ELSIF v_vartype = 'DATE'
          AND v_jugnum > 0 THEN
      v_exesql := 'UPDATE SCMDATA.T_VARIABLE SET VAR_DATE = :A, LAST_UPDTIME = SYSDATE WHERE OBJ_ID = :B AND COMPANY_ID = :C AND VAR_NAME = :D';
      EXECUTE IMMEDIATE v_exesql
        USING v_date, v_objid, v_compid, v_varname;
    
      --类型为：CLOB，不存在于 VARIABLE 表中
    ELSIF v_vartype = 'CLOB'
          AND v_jugnum = 0 THEN
      v_exesql := 'INSERT INTO SCMDATA.T_VARIABLE (OBJ_ID,COMPANY_ID,VAR_NAME,VAR_TYPE,VAR_CLOB) VALUES (:A,:B,:C,:D,:E)';
      EXECUTE IMMEDIATE v_exesql
        USING v_objid, v_compid, v_varname, v_vartype, v_clob;
    
      --类型为：CLOB，存在于 VARIABLE 表中
    ELSIF v_vartype = 'CLOB'
          AND v_jugnum > 0 THEN
      v_exesql := 'UPDATE SCMDATA.T_VARIABLE SET VAR_CLOB = :A, LAST_UPDTIME = SYSDATE WHERE OBJ_ID = :B AND COMPANY_ID = :C AND VAR_NAME = :D';
      EXECUTE IMMEDIATE v_exesql
        USING v_clob, v_objid, v_compid, v_varname;
    
    END IF;
  END p_ins_or_upd_variable;

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
  PROCEDURE p_ins_or_upd_variable_at(v_objid   IN VARCHAR2,
                                     v_compid  IN VARCHAR2,
                                     v_varname IN VARCHAR2,
                                     v_vartype IN VARCHAR2,
                                     v_number  IN NUMBER DEFAULT 0,
                                     v_varchar IN VARCHAR2 DEFAULT NULL,
                                     v_date    IN DATE DEFAULT NULL,
                                     v_clob    IN CLOB DEFAULT NULL) IS
    PRAGMA AUTONOMOUS_TRANSACTION;
    v_jugnum NUMBER(1);
    v_exesql VARCHAR2(2048);
  BEGIN
    SELECT COUNT(1)
      INTO v_jugnum
      FROM scmdata.t_variable
     WHERE obj_id = v_objid
       AND company_id = v_compid
       AND var_name = v_varname
       AND rownum < 2;
  
    --类型为：NUMBER，不存在于 VARIABLE 表中
    IF v_vartype = 'NUMBER'
       AND v_jugnum = 0 THEN
      v_exesql := 'INSERT INTO SCMDATA.T_VARIABLE (OBJ_ID,COMPANY_ID,VAR_NAME,VAR_TYPE,VAR_NUMBER) VALUES (:A,:B,:C,:D,:E)';
      EXECUTE IMMEDIATE v_exesql
        USING v_objid, v_compid, v_varname, v_vartype, v_number;
    
      --类型为：NUMBER，存在于 VARIABLE 表中
    ELSIF v_vartype = 'NUMBER'
          AND v_jugnum > 0 THEN
      v_exesql := 'UPDATE SCMDATA.T_VARIABLE SET VAR_NUMBER = :A, LAST_UPDTIME = SYSDATE WHERE OBJ_ID = :B AND COMPANY_ID = :C AND VAR_NAME = :D';
      EXECUTE IMMEDIATE v_exesql
        USING v_number, v_objid, v_compid, v_varname;
    
      --类型为：VARCHAR，不存在于 VARIABLE 表中
    ELSIF v_vartype = 'VARCHAR'
          AND v_jugnum = 0 THEN
      v_exesql := 'INSERT INTO SCMDATA.T_VARIABLE (OBJ_ID,COMPANY_ID,VAR_NAME,VAR_TYPE,VAR_VARCHAR) VALUES (:A,:B,:C,:D,:E)';
      EXECUTE IMMEDIATE v_exesql
        USING v_objid, v_compid, v_varname, v_vartype, v_varchar;
    
      --类型为：VARCHAR，存在于 VARIABLE 表中
    ELSIF v_vartype = 'VARCHAR'
          AND v_jugnum > 0 THEN
      v_exesql := 'UPDATE SCMDATA.T_VARIABLE SET VAR_VARCHAR = :A, LAST_UPDTIME = SYSDATE WHERE OBJ_ID = :B AND COMPANY_ID = :C AND VAR_NAME = :D';
      EXECUTE IMMEDIATE v_exesql
        USING v_varchar, v_objid, v_compid, v_varname;
    
      --类型为：DATE，不存在于 VARIABLE 表中
    ELSIF v_vartype = 'DATE'
          AND v_jugnum = 0 THEN
      v_exesql := 'INSERT INTO SCMDATA.T_VARIABLE (OBJ_ID,COMPANY_ID,VAR_NAME,VAR_TYPE,VAR_DATE) VALUES (:A,:B,:C,:D,:E)';
      EXECUTE IMMEDIATE v_exesql
        USING v_objid, v_compid, v_varname, v_vartype, v_date;
    
      --类型为：DATE，存在于 VARIABLE 表中
    ELSIF v_vartype = 'DATE'
          AND v_jugnum > 0 THEN
      v_exesql := 'UPDATE SCMDATA.T_VARIABLE SET VAR_DATE = :A, LAST_UPDTIME = SYSDATE WHERE OBJ_ID = :B AND COMPANY_ID = :C AND VAR_NAME = :D';
      EXECUTE IMMEDIATE v_exesql
        USING v_date, v_objid, v_compid, v_varname;
    
      --类型为：CLOB，不存在于 VARIABLE 表中
    ELSIF v_vartype = 'CLOB'
          AND v_jugnum = 0 THEN
      v_exesql := 'INSERT INTO SCMDATA.T_VARIABLE (OBJ_ID,COMPANY_ID,VAR_NAME,VAR_TYPE,VAR_CLOB) VALUES (:A,:B,:C,:D,:E)';
      EXECUTE IMMEDIATE v_exesql
        USING v_objid, v_compid, v_varname, v_vartype, v_clob;
    
      --类型为：CLOB，存在于 VARIABLE 表中
    ELSIF v_vartype = 'CLOB'
          AND v_jugnum > 0 THEN
      v_exesql := 'UPDATE SCMDATA.T_VARIABLE SET VAR_CLOB = :A, LAST_UPDTIME = SYSDATE WHERE OBJ_ID = :B AND COMPANY_ID = :C AND VAR_NAME = :D';
      EXECUTE IMMEDIATE v_exesql
        USING v_clob, v_objid, v_compid, v_varname;
    
    END IF;
  
    COMMIT;
  END p_ins_or_upd_variable_at;

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
  PROCEDURE p_ins_or_upd_variable_with_chaid(v_objid   IN VARCHAR2,
                                             v_compid  IN VARCHAR2,
                                             v_varname IN VARCHAR2,
                                             v_vartype IN VARCHAR2,
                                             v_number  IN NUMBER DEFAULT 0,
                                             v_varchar IN VARCHAR2 DEFAULT NULL,
                                             v_date    IN DATE DEFAULT NULL,
                                             v_clob    IN CLOB DEFAULT NULL,
                                             v_chaid   IN VARCHAR2) IS
    v_jugnum NUMBER(1);
    v_exesql VARCHAR2(2048);
  BEGIN
    SELECT COUNT(1)
      INTO v_jugnum
      FROM scmdata.t_variable_cha
     WHERE obj_id = v_objid
       AND company_id = v_compid
       AND var_name = v_varname
       AND cha_id = v_chaid
       AND rownum = 1;
  
    --类型为：NUMBER，不存在于 VARIABLE 表中
    IF v_vartype = 'NUMBER'
       AND v_jugnum = 0 THEN
      v_exesql := 'INSERT INTO SCMDATA.T_VARIABLE_CHA  (OBJ_ID,COMPANY_ID,VAR_NAME,VAR_TYPE,VAR_NUMBER,CHA_ID) VALUES (:A,:B,:C,:D,:E,:F)';
      EXECUTE IMMEDIATE v_exesql
        USING v_objid, v_compid, v_varname, v_vartype, v_number, v_chaid;
    
      --类型为：NUMBER，存在于 VARIABLE 表中
    ELSIF v_vartype = 'NUMBER'
          AND v_jugnum > 0 THEN
      v_exesql := 'UPDATE SCMDATA.T_VARIABLE_CHA SET VAR_NUMBER = :A, LAST_UPDTIME = SYSDATE WHERE OBJ_ID = :B AND COMPANY_ID = :C AND VAR_NAME = :D AND CHA_ID = :E';
      EXECUTE IMMEDIATE v_exesql
        USING v_number, v_objid, v_compid, v_varname, v_chaid;
    
      --类型为：VARCHAR，不存在于 VARIABLE 表中
    ELSIF v_vartype = 'VARCHAR'
          AND v_jugnum = 0 THEN
      v_exesql := 'INSERT INTO SCMDATA.T_VARIABLE_CHA (OBJ_ID,COMPANY_ID,VAR_NAME,VAR_TYPE,VAR_VARCHAR,CHA_ID) VALUES (:A,:B,:C,:D,:E,:F)';
      EXECUTE IMMEDIATE v_exesql
        USING v_objid, v_compid, v_varname, v_vartype, v_varchar, v_chaid;
    
      --类型为：VARCHAR，存在于 VARIABLE 表中
    ELSIF v_vartype = 'VARCHAR'
          AND v_jugnum > 0 THEN
      v_exesql := 'UPDATE SCMDATA.T_VARIABLE_CHA SET VAR_VARCHAR = :A, LAST_UPDTIME = SYSDATE WHERE OBJ_ID = :B AND COMPANY_ID = :C AND VAR_NAME = :D AND CHA_ID = :E';
      EXECUTE IMMEDIATE v_exesql
        USING v_varchar, v_objid, v_compid, v_varname, v_chaid;
    
      --类型为：DATE，不存在于 VARIABLE 表中
    ELSIF v_vartype = 'DATE'
          AND v_jugnum = 0 THEN
      v_exesql := 'INSERT INTO SCMDATA.T_VARIABLE_CHA (OBJ_ID,COMPANY_ID,VAR_NAME,VAR_TYPE,VAR_DATE,CHA_ID) VALUES (:A,:B,:C,:D,:E,:F)';
      EXECUTE IMMEDIATE v_exesql
        USING v_objid, v_compid, v_varname, v_vartype, v_date, v_chaid;
    
      --类型为：DATE，存在于 VARIABLE 表中
    ELSIF v_vartype = 'DATE'
          AND v_jugnum > 0 THEN
      v_exesql := 'UPDATE SCMDATA.T_VARIABLE_CHA SET VAR_DATE = :A, LAST_UPDTIME = SYSDATE WHERE OBJ_ID = :B AND COMPANY_ID = :C AND VAR_NAME = :D AND CHA_ID = :E';
      EXECUTE IMMEDIATE v_exesql
        USING v_date, v_objid, v_compid, v_varname, v_chaid;
    
      --类型为：CLOB，不存在于 VARIABLE 表中
    ELSIF v_vartype = 'CLOB'
          AND v_jugnum = 0 THEN
      v_exesql := 'INSERT INTO SCMDATA.T_VARIABLE_CHA (OBJ_ID,COMPANY_ID,VAR_NAME,VAR_TYPE,VAR_CLOB,CHA_ID) VALUES (:A,:B,:C,:D,:E,:F)';
      EXECUTE IMMEDIATE v_exesql
        USING v_objid, v_compid, v_varname, v_vartype, v_clob, v_chaid;
    
      --类型为：CLOB，存在于 VARIABLE 表中
    ELSIF v_vartype = 'CLOB'
          AND v_jugnum > 0 THEN
      v_exesql := 'UPDATE SCMDATA.T_VARIABLE_CHA SET VAR_CLOB = :A, LAST_UPDTIME = SYSDATE WHERE OBJ_ID = :B AND COMPANY_ID = :C AND VAR_NAME = :D AND CHA_ID = :E';
      EXECUTE IMMEDIATE v_exesql
        USING v_clob, v_objid, v_compid, v_varname, v_chaid;
    
    END IF;
  END p_ins_or_upd_variable_with_chaid;

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
  PROCEDURE p_ins_or_upd_variable_with_chaid_at(v_objid   IN VARCHAR2,
                                                v_compid  IN VARCHAR2,
                                                v_varname IN VARCHAR2,
                                                v_vartype IN VARCHAR2,
                                                v_number  IN NUMBER DEFAULT 0,
                                                v_varchar IN VARCHAR2 DEFAULT NULL,
                                                v_date    IN DATE DEFAULT NULL,
                                                v_clob    IN CLOB DEFAULT NULL,
                                                v_chaid   IN VARCHAR2) IS
    PRAGMA AUTONOMOUS_TRANSACTION;
    v_jugnum NUMBER(1);
    v_exesql VARCHAR2(2048);
  BEGIN
    SELECT COUNT(1)
      INTO v_jugnum
      FROM scmdata.t_variable_cha
     WHERE obj_id = v_objid
       AND company_id = v_compid
       AND var_name = v_varname
       AND cha_id = v_chaid
       AND rownum = 1;
  
    --类型为：NUMBER，不存在于 VARIABLE 表中
    IF v_vartype = 'NUMBER'
       AND v_jugnum = 0 THEN
      v_exesql := 'INSERT INTO SCMDATA.T_VARIABLE_CHA  (OBJ_ID,COMPANY_ID,VAR_NAME,VAR_TYPE,VAR_NUMBER,CHA_ID) VALUES (:A,:B,:C,:D,:E,:F)';
      EXECUTE IMMEDIATE v_exesql
        USING v_objid, v_compid, v_varname, v_vartype, v_number, v_chaid;
    
      --类型为：NUMBER，存在于 VARIABLE 表中
    ELSIF v_vartype = 'NUMBER'
          AND v_jugnum > 0 THEN
      v_exesql := 'UPDATE SCMDATA.T_VARIABLE_CHA SET VAR_NUMBER = :A, LAST_UPDTIME = SYSDATE WHERE OBJ_ID = :B AND COMPANY_ID = :C AND VAR_NAME = :D AND CHA_ID = :E';
      EXECUTE IMMEDIATE v_exesql
        USING v_number, v_objid, v_compid, v_varname, v_chaid;
    
      --类型为：VARCHAR，不存在于 VARIABLE 表中
    ELSIF v_vartype = 'VARCHAR'
          AND v_jugnum = 0 THEN
      v_exesql := 'INSERT INTO SCMDATA.T_VARIABLE_CHA (OBJ_ID,COMPANY_ID,VAR_NAME,VAR_TYPE,VAR_VARCHAR,CHA_ID) VALUES (:A,:B,:C,:D,:E,:F)';
      EXECUTE IMMEDIATE v_exesql
        USING v_objid, v_compid, v_varname, v_vartype, v_varchar, v_chaid;
    
      --类型为：VARCHAR，存在于 VARIABLE 表中
    ELSIF v_vartype = 'VARCHAR'
          AND v_jugnum > 0 THEN
      v_exesql := 'UPDATE SCMDATA.T_VARIABLE_CHA SET VAR_VARCHAR = :A, LAST_UPDTIME = SYSDATE WHERE OBJ_ID = :B AND COMPANY_ID = :C AND VAR_NAME = :D AND CHA_ID = :E';
      EXECUTE IMMEDIATE v_exesql
        USING v_varchar, v_objid, v_compid, v_varname, v_chaid;
    
      --类型为：DATE，不存在于 VARIABLE 表中
    ELSIF v_vartype = 'DATE'
          AND v_jugnum = 0 THEN
      v_exesql := 'INSERT INTO SCMDATA.T_VARIABLE_CHA (OBJ_ID,COMPANY_ID,VAR_NAME,VAR_TYPE,VAR_DATE,CHA_ID) VALUES (:A,:B,:C,:D,:E,:F)';
      EXECUTE IMMEDIATE v_exesql
        USING v_objid, v_compid, v_varname, v_vartype, v_date, v_chaid;
    
      --类型为：DATE，存在于 VARIABLE 表中
    ELSIF v_vartype = 'DATE'
          AND v_jugnum > 0 THEN
      v_exesql := 'UPDATE SCMDATA.T_VARIABLE_CHA SET VAR_DATE = :A, LAST_UPDTIME = SYSDATE WHERE OBJ_ID = :B AND COMPANY_ID = :C AND VAR_NAME = :D AND CHA_ID = :E';
      EXECUTE IMMEDIATE v_exesql
        USING v_date, v_objid, v_compid, v_varname, v_chaid;
    
      --类型为：CLOB，不存在于 VARIABLE 表中
    ELSIF v_vartype = 'CLOB'
          AND v_jugnum = 0 THEN
      v_exesql := 'INSERT INTO SCMDATA.T_VARIABLE_CHA (OBJ_ID,COMPANY_ID,VAR_NAME,VAR_TYPE,VAR_CLOB,CHA_ID) VALUES (:A,:B,:C,:D,:E,:F)';
      EXECUTE IMMEDIATE v_exesql
        USING v_objid, v_compid, v_varname, v_vartype, v_clob, v_chaid;
    
      --类型为：CLOB，存在于 VARIABLE 表中
    ELSIF v_vartype = 'CLOB'
          AND v_jugnum > 0 THEN
      v_exesql := 'UPDATE SCMDATA.T_VARIABLE_CHA SET VAR_CLOB = :A, LAST_UPDTIME = SYSDATE WHERE OBJ_ID = :B AND COMPANY_ID = :C AND VAR_NAME = :D AND CHA_ID = :E';
      EXECUTE IMMEDIATE v_exesql
        USING v_clob, v_objid, v_compid, v_varname, v_chaid;
    
    END IF;
    COMMIT;
  END p_ins_or_upd_variable_with_chaid_at;

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
  FUNCTION f_get_varchar(v_objid   IN VARCHAR2,
                         v_compid  IN VARCHAR2,
                         v_varname IN VARCHAR2) RETURN VARCHAR2 IS
    ret_str VARCHAR2(128);
  BEGIN
    SELECT MAX(var_varchar)
      INTO ret_str
      FROM scmdata.t_variable
     WHERE obj_id = v_objid
       AND company_id = v_compid
       AND var_name = v_varname
       AND var_type = 'VARCHAR';
    RETURN ret_str;
  END f_get_varchar;

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
  FUNCTION f_get_varchar_with_chaid(v_objid   IN VARCHAR2,
                                    v_compid  IN VARCHAR2,
                                    v_varname IN VARCHAR2,
                                    v_chaid   IN VARCHAR2) RETURN VARCHAR2 IS
    ret_str VARCHAR2(128);
  BEGIN
    SELECT MAX(var_varchar)
      INTO ret_str
      FROM scmdata.t_variable_cha
     WHERE obj_id = v_objid
       AND company_id = v_compid
       AND var_name = v_varname
       AND var_type = 'VARCHAR'
       AND cha_id = v_chaid;
    RETURN ret_str;
  END f_get_varchar_with_chaid;

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
  FUNCTION f_get_number(v_objid   IN VARCHAR2,
                        v_compid  IN VARCHAR2,
                        v_varname IN VARCHAR2) RETURN NUMBER IS
    ret_num NUMBER(16);
  BEGIN
    SELECT MAX(var_number)
      INTO ret_num
      FROM scmdata.t_variable
     WHERE obj_id = v_objid
       AND company_id = v_compid
       AND var_name = v_varname
       AND var_type = 'NUMBER';
    RETURN ret_num;
  END f_get_number;

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
  FUNCTION f_get_number_with_chaid(v_objid   IN VARCHAR2,
                                   v_compid  IN VARCHAR2,
                                   v_varname IN VARCHAR2,
                                   v_chaid   IN VARCHAR2) RETURN NUMBER IS
    ret_num NUMBER(16);
  BEGIN
    SELECT MAX(var_number)
      INTO ret_num
      FROM scmdata.t_variable_cha
     WHERE obj_id = v_objid
       AND company_id = v_compid
       AND var_name = v_varname
       AND var_type = 'NUMBER'
       AND cha_id = v_chaid;
    RETURN ret_num;
  END f_get_number_with_chaid;

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
  FUNCTION f_get_date(v_objid   IN VARCHAR2,
                      v_compid  IN VARCHAR2,
                      v_varname IN VARCHAR2) RETURN DATE IS
    ret_date DATE;
  BEGIN
    SELECT MAX(var_date)
      INTO ret_date
      FROM scmdata.t_variable
     WHERE obj_id = v_objid
       AND company_id = v_compid
       AND var_name = v_varname
       AND var_type = 'DATE';
    RETURN ret_date;
  END f_get_date;

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
  FUNCTION f_get_date_with_chaid(v_objid   IN VARCHAR2,
                                 v_compid  IN VARCHAR2,
                                 v_varname IN VARCHAR2,
                                 v_chaid   IN VARCHAR2) RETURN DATE IS
    ret_date DATE;
  BEGIN
    SELECT MAX(var_date)
      INTO ret_date
      FROM scmdata.t_variable_cha
     WHERE obj_id = v_objid
       AND company_id = v_compid
       AND var_name = v_varname
       AND var_type = 'DATE'
       AND cha_id = v_chaid;
    RETURN ret_date;
  END f_get_date_with_chaid;

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
  FUNCTION f_get_clob(v_objid   IN VARCHAR2,
                      v_compid  IN VARCHAR2,
                      v_varname IN VARCHAR2) RETURN CLOB IS
    v_jugnum NUMBER;
    ret_clob CLOB;
  BEGIN
    SELECT COUNT(1)
      INTO v_jugnum
      FROM scmdata.t_variable
     WHERE obj_id = v_objid
       AND company_id = v_compid
       AND var_name = v_varname
       AND var_type = 'CLOB'
       AND rownum = 1;
  
    IF v_jugnum > 0 THEN
      SELECT var_clob
        INTO ret_clob
        FROM scmdata.t_variable
       WHERE obj_id = v_objid
         AND company_id = v_compid
         AND var_name = v_varname
         AND var_type = 'CLOB';
    END IF;
    RETURN ret_clob;
  END f_get_clob;

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
  FUNCTION f_get_clob_with_chaid(v_objid   IN VARCHAR2,
                                 v_compid  IN VARCHAR2,
                                 v_varname IN VARCHAR2,
                                 v_chaid   IN VARCHAR2) RETURN CLOB IS
    v_jugnum NUMBER;
    ret_clob CLOB;
  BEGIN
    SELECT COUNT(1)
      INTO v_jugnum
      FROM scmdata.t_variable_cha
     WHERE obj_id = v_objid
       AND company_id = v_compid
       AND var_name = v_varname
       AND var_type = 'CLOB'
       AND cha_id = v_chaid
       AND rownum = 1;
  
    IF v_jugnum > 0 THEN
      SELECT var_clob
        INTO ret_clob
        FROM scmdata.t_variable_cha
       WHERE obj_id = v_objid
         AND company_id = v_compid
         AND var_name = v_varname
         AND var_type = 'CLOB'
         AND cha_id = v_chaid;
    END IF;
    RETURN ret_clob;
  END f_get_clob_with_chaid;

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
  PROCEDURE p_set_variable_increment(v_objid   IN VARCHAR2,
                                     v_compid  IN VARCHAR2,
                                     v_varname IN VARCHAR2) IS
  BEGIN
    UPDATE scmdata.t_variable t
       SET var_number   = nvl(t.var_number, 0) + 1,
           last_updtime = SYSDATE
     WHERE obj_id = v_objid
       AND company_id = v_compid
       AND var_name = v_varname;
  END p_set_variable_increment;

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
  PROCEDURE p_set_variable_increment_with_chaid(v_objid   IN VARCHAR2,
                                                v_compid  IN VARCHAR2,
                                                v_varname IN VARCHAR2,
                                                v_chaid   IN VARCHAR2) IS
  BEGIN
    UPDATE scmdata.t_variable_cha t
       SET var_number   = nvl(t.var_number, 0) + 1,
           last_updtime = SYSDATE
     WHERE obj_id = v_objid
       AND company_id = v_compid
       AND var_name = v_varname
       AND cha_id = v_chaid;
  END p_set_variable_increment_with_chaid;

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
  PROCEDURE p_append_clob_variable(v_objid   IN VARCHAR2,
                                   v_compid  IN VARCHAR2,
                                   v_varname IN VARCHAR2,
                                   v_appstr  IN VARCHAR2) IS
    v_clob CLOB;
  BEGIN
    v_clob := f_get_clob(v_objid   => v_objid,
                         v_compid  => v_compid,
                         v_varname => v_varname);
    IF instr(v_clob, v_appstr) = 0
       OR v_clob IS NULL THEN
      UPDATE scmdata.t_variable t
         SET var_clob     = t.var_clob || chr(10) || v_appstr,
             last_updtime = SYSDATE
       WHERE obj_id = v_objid
         AND company_id = v_compid
         AND var_name = v_varname
         AND var_type = 'CLOB';
    END IF;
  END p_append_clob_variable;

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
  PROCEDURE p_append_clob_variable_with_chaid(v_objid   IN VARCHAR2,
                                              v_compid  IN VARCHAR2,
                                              v_varname IN VARCHAR2,
                                              v_appstr  IN VARCHAR2,
                                              v_chaid   IN VARCHAR2) IS
    v_clob CLOB;
  BEGIN
    v_clob := f_get_clob_with_chaid(v_objid   => v_objid,
                                    v_compid  => v_compid,
                                    v_varname => v_varname,
                                    v_chaid   => v_chaid);
    IF instr(v_clob, v_appstr) = 0
       OR v_clob IS NULL THEN
      UPDATE scmdata.t_variable_cha t
         SET var_clob     = t.var_clob || chr(10) || v_appstr,
             last_updtime = SYSDATE
       WHERE obj_id = v_objid
         AND company_id = v_compid
         AND var_name = v_varname
         AND var_type = 'CLOB'
         AND cha_id = v_chaid;
    END IF;
  END p_append_clob_variable_with_chaid;

END pkg_variable;
/

