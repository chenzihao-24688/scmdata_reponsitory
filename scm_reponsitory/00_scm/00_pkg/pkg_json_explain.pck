CREATE OR REPLACE PACKAGE SCMDATA.PKG_JSON_EXPLAIN IS

  /*===========================================================================

    通用分割

    用途:
      用于拆分长字段分隔符次序与分隔符次序+1之间的字段

    入参:
      V_LONGSTR    : 需要被拆分的长字符
      V_CNT        : 分隔符次序
      V_SEPARATOR  : 分隔符

    返回值:
     拆分长字段分隔符次序与分隔符次序+1之间的字段

    版本:
      2021-11-11 : 用于拆分长字段分隔符次序与分隔符次序+1之间的字段

  ===========================================================================*/
  FUNCTION F_SEP_MULTI_VALUE(V_LONGSTR    IN VARCHAR2,
                             V_CNT        IN VARCHAR2,
                             V_SEPARATOR  IN VARCHAR2) RETURN VARCHAR2;

  /*===========================================================================

    JTABLE新增数据

    用途:
      通用 SCMDATA.T_JTABLE 新增数据

    入参:
      JC_ID       :  SCMDATA.T_JTABLE.CFG_ID/SCMDATA.T_JCONFIG.JC_ID
      COMPANY_ID  :  企业ID
      V_CURUSER   :  当前操作人
      V_JSONSTR   :  传入 JSON 语句

    返回值:
      执行 SQL 语句

  ===========================================================================*/
  PROCEDURE P_INSERT_JTABLE(V_JCID    IN VARCHAR2,
                            V_COMPID  IN VARCHAR2,
                            V_CURUSER IN VARCHAR2,
                            V_JSONSTR IN CLOB);

  /*===========================================================================

    获取通用解析语句

    用途:
      通过 SCMDATA.T_JCONFIG 解析传入 SCMDATA.T_JTABLE.JDATA

    入参:
      V_JCID    :  SCMDATA.T_JTABLE.CFG_ID/SCMDATA.T_JCONFIG.JC_ID
      V_COMPID  :  企业ID

    返回值:
      执行 SQL 语句

  ===========================================================================*/
  FUNCTION F_GET_JSON_PARSE_SQL(V_JCID   IN VARCHAR2,
                                V_COMPID IN VARCHAR2,
                                V_JSON   IN CLOB DEFAULT NULL) RETURN CLOB;

END PKG_JSON_EXPLAIN;
/

CREATE OR REPLACE PACKAGE BODY SCMDATA.PKG_JSON_EXPLAIN IS

  /*===========================================================================

    通用分割

    用途:
      用于拆分长字段分隔符次序与分隔符次序+1之间的字段

    入参:
      V_LONGSTR    : 需要被拆分的长字符
      V_CNT        : 分隔符次序
      V_SEPARATOR  : 分隔符

    返回值:
     拆分长字段分隔符次序与分隔符次序+1之间的字段

    版本:
      2021-11-11 : 用于拆分长字段分隔符次序与分隔符次序+1之间的字段

  ===========================================================================*/
  FUNCTION F_SEP_MULTI_VALUE(V_LONGSTR    IN VARCHAR2,
                             V_CNT        IN VARCHAR2,
                             V_SEPARATOR  IN VARCHAR2) RETURN VARCHAR2 IS
    V_RETVARCHAR  VARCHAR2(64);
  BEGIN
    IF V_CNT = 0 THEN
      V_RETVARCHAR  := SUBSTR(V_LONGSTR,1,INSTR(V_LONGSTR,V_SEPARATOR)-1);
    ELSE
      V_RETVARCHAR  := SUBSTR(V_LONGSTR,
                              INSTR(V_LONGSTR,V_SEPARATOR,1,V_CNT)+1,
                              INSTR(V_LONGSTR,V_SEPARATOR,1,V_CNT+1)-INSTR(V_LONGSTR,V_SEPARATOR,1,V_CNT)-1);
    END IF;
    RETURN V_RETVARCHAR;
  END F_SEP_MULTI_VALUE;



  /*===========================================================================

    JTABLE新增数据

    用途:
      通用 SCMDATA.T_JTABLE 新增数据

    入参:
      JC_ID       :  SCMDATA.T_JTABLE.CFG_ID/SCMDATA.T_JCONFIG.JC_ID
      COMPANY_ID  :  企业ID
      V_CURUSER   :  当前操作人
      V_JSONSTR   :  传入 JSON 语句

    返回值:
      执行 SQL 语句

  ===========================================================================*/
  PROCEDURE P_INSERT_JTABLE(V_JCID    IN VARCHAR2,
                            V_COMPID  IN VARCHAR2,
                            V_CURUSER IN VARCHAR2,
                            V_JSONSTR IN CLOB) IS

  BEGIN
    INSERT INTO SCMDATA.T_JTABLE
      (JT_ID,COMPANY_ID,STATUS,JC_ID,J_DATA,CREATE_ID,CREATE_TIME)
    VALUES
      (SCMDATA.F_GET_UUID(),V_COMPID,'NU',V_JCID,V_JSONSTR,V_CURUSER,SYSDATE);
  END P_INSERT_JTABLE;



  /*===========================================================================

    获取通用解析语句

    用途:
      通过 SCMDATA.T_JCONFIG 解析传入 SCMDATA.T_JTABLE.JDATA

    入参:
      V_JCID    :  SCMDATA.T_JTABLE.CFG_ID/SCMDATA.T_JCONFIG.JC_ID
      V_COMPID  :  企业ID

    返回值:
      执行 SQL 语句

  ===========================================================================*/
  FUNCTION F_GET_JSON_PARSE_SQL(V_JCID   IN VARCHAR2,
                                V_COMPID IN VARCHAR2,
                                V_JSON   IN CLOB DEFAULT NULL) RETURN CLOB IS
    V_DATAPATH   VARCHAR2(128);
    V_TABCOLS    CLOB;
    V_SGTABCOL   VARCHAR2(64);
    V_DATATYPES  CLOB;
    V_SGDATATYPE VARCHAR2(64);
    V_JSONCOLS   CLOB;
    V_SGJSONCOL  VARCHAR2(64);
    V_RETCLOB    CLOB;
    V_TMPCLOB    CLOB;
    V_CNT        NUMBER(4):=0;
  BEGIN
    SELECT DATA_PATH, TABLE_COLS||',', DATA_TYPES||',', JSON_COLS||','
      INTO V_DATAPATH, V_TABCOLS, V_DATATYPES, V_JSONCOLS
      FROM SCMDATA.T_JCONFIG
     WHERE JC_ID = V_JCID
       AND COMPANY_ID = V_COMPID;

    IF REGEXP_COUNT(V_TABCOLS,',')=REGEXP_COUNT(V_DATATYPES,',')
       AND REGEXP_COUNT(V_DATATYPES,',')=REGEXP_COUNT(V_JSONCOLS,',') THEN
      WHILE (V_CNT < REGEXP_COUNT(V_TABCOLS,',')) LOOP
        V_SGTABCOL   := F_SEP_MULTI_VALUE(V_LONGSTR    => V_TABCOLS,
                                          V_CNT        => V_CNT,
                                          V_SEPARATOR  => ',');

        V_SGDATATYPE := F_SEP_MULTI_VALUE(V_LONGSTR    => V_DATATYPES,
                                          V_CNT        => V_CNT,
                                          V_SEPARATOR  => ',');

        V_SGJSONCOL  := F_SEP_MULTI_VALUE(V_LONGSTR    => V_JSONCOLS,
                                          V_CNT        => V_CNT,
                                          V_SEPARATOR  => ',');

        V_TMPCLOB := V_TMPCLOB ||','|| V_SGTABCOL || ' ' || V_SGDATATYPE || ' PATH ''$.'||V_SGJSONCOL||'''';
        V_CNT := V_CNT + 1;
      END LOOP;
      
      IF V_JSON IS NULL THEN 
        V_RETCLOB := 'SELECT JT.'||REPLACE(RTRIM(V_TABCOLS,','),',',',JT.')||' FROM SCMDATA.T_JTABLE,JSON_TABLE(J_DATA, ''$'' COLUMNS(NESTED PATH '''||
                      V_DATAPATH || ''' COLUMNS ('||LTRIM(V_TMPCLOB,',')||'))) AS JT';
      ELSE
        V_RETCLOB := 'SELECT JT.'||REPLACE(RTRIM(V_TABCOLS,','),',',',JT.')||' FROM JSON_TABLE('''||V_JSON||''', ''$'' COLUMNS(NESTED PATH '''||
                      V_DATAPATH || ''' COLUMNS ('||LTRIM(V_TMPCLOB,',')||'))) AS JT';
      END IF;
      
    ELSE
      RAISE_APPLICATION_ERROR(-20002,'配置数据有误，请检查！');
    END IF;
    RETURN V_RETCLOB;
  END F_GET_JSON_PARSE_SQL;

END PKG_JSON_EXPLAIN;
/

