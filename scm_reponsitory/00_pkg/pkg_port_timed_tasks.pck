CREATE OR REPLACE PACKAGE SCMDATA.PKG_PORT_TIMED_TASKS IS
 
  --获取机器名称
  FUNCTION F_GET_MAC_NAME RETURN VARCHAR2;

  --获取IP地址
  FUNCTION F_GET_IP_ADDRESS RETURN VARCHAR2;

  --获取与系统时间戳之间的秒数差
  FUNCTION F_GET_TWO_TIMESTAMPS_DIFFERENCE_HMS(INS_TIMESTAMP IN TIMESTAMP) RETURN NUMBER;

  --获取最后更新时间
  FUNCTION F_GET_LAST_UPDATE_TIMESTAMP(INS_TAB     IN VARCHAR2,
                                       INS_UNQCOND IN VARCHAR2) RETURN TIMESTAMP;

  --获取最后更新时间与系统更新时间秒数差(封装前两个)
  FUNCTION F_GET_SECOND_DIFFERENCE(INS_TAB     IN VARCHAR2,
                                   INS_UNQCOND IN VARCHAR2) RETURN NUMBER;

  --获取格式化列值(单行)
  FUNCTION F_GET_FMTVALS_S(INS_OAT   IN VARCHAR2,
                           INS_COLS  IN VARCHAR2,
                           INS_VALS  IN VARCHAR2) RETURN VARCHAR2;

  --获取格式化列值（运行后可存入单个变量）
  FUNCTION F_GET_FMTVALS_IN_ONE(INS_OAT   IN VARCHAR2,
                                INS_COLS  IN VARCHAR2,
                                INS_VALS  IN VARCHAR2) RETURN VARCHAR2;

  --普通插入
  PROCEDURE P_PUT_DATA_INTO_PTT(INS_OAT    IN VARCHAR2,
                                INS_OPER   IN VARCHAR2,
                                INS_COLS   IN VARCHAR2,
                                INS_VALS   IN CLOB,
                                INS_DU     IN VARCHAR2);

  --数据同步处理与执行
  PROCEDURE P_SYNC_DATA_PROCESS_AND_EXECUTE(INS_OPID  IN VARCHAR2,
                                            INS_SO    IN VARCHAR2,
                                            INS_OAT   IN VARCHAR2,
                                            INS_OPER  IN VARCHAR2,
                                            INS_COLS  IN VARCHAR2,
                                            INS_VALS  IN VARCHAR2,
                                            INS_DU    IN VARCHAR2,
                                            INS_EO    IN VARCHAR2,
                                            INS_SEC   IN NUMBER,
                                            INS_MACN  IN VARCHAR2,
                                            INS_IPAD  IN VARCHAR2,
                                            INS_LGID  IN VARCHAR2);

  --对于插入后触发器插入到 PORT_TIMED_TASKS 的值进行 SYNC_TIMESTAMP 的设置
  PROCEDURE P_SET_SYNC_TIMESTAMP(INS_OAT   IN VARCHAR2,
                                 INS_COLS  IN VARCHAR2,
                                 INS_VALS  IN VARCHAR2,
                                 INS_OPER  IN VARCHAR2,
                                 INS_DU    IN VARCHAR2);

  --插入到回写id表
  PROCEDURE P_INSERT_WBIDS(INS_SO      IN VARCHAR2,
                           INS_MACN    IN VARCHAR2,
                           INS_IPAD    IN VARCHAR2,
                           INS_OPERID  IN VARCHAR2);

  --删除相关id
  PROCEDURE P_DELETE_RELA_WBIDS(INS_SO      IN VARCHAR2,
                                INS_MACN    IN VARCHAR2,
                                INS_IPAD    IN VARCHAR2,
                                INS_IDS     IN VARCHAR2);

  --插入到 PORT_TIMED_TASKS
  PROCEDURE P_INSERT_PORT_TIMED_TASKS(INS_OPER  IN VARCHAR2,
                                      INS_OAT   IN VARCHAR2,
                                      INS_COLS  IN VARCHAR2,
                                      INS_VALS  IN VARCHAR2,
                                      INS_DU    IN VARCHAR2,
                                      INS_EO    IN VARCHAR2 DEFAULT NULL,
                                      INS_SYOI  IN VARCHAR2 DEFAULT NULL);

END PKG_PORT_TIMED_TASKS;
/

CREATE OR REPLACE PACKAGE BODY SCMDATA.PKG_PORT_TIMED_TASKS IS

  --获取机器名称
  FUNCTION F_GET_MAC_NAME RETURN VARCHAR2 IS
    MAC_NAME  VARCHAR2(128);
  BEGIN
    SELECT SYS_CONTEXT('USERENV', 'HOST', 128) 
      INTO MAC_NAME
      FROM DUAL;
    RETURN MAC_NAME;
  END F_GET_MAC_NAME;



  --获取IP地址
  FUNCTION F_GET_IP_ADDRESS RETURN VARCHAR2 IS
    IP_ADDRESS  VARCHAR2(32);
  BEGIN
    SELECT SYS_CONTEXT('USERENV', 'IP_ADDRESS', 32) 
      INTO IP_ADDRESS
      FROM DUAL;
    RETURN IP_ADDRESS;
  END F_GET_IP_ADDRESS;
    
  --获取最后更新时间
  FUNCTION F_GET_LAST_UPDATE_TIMESTAMP(INS_TAB     IN VARCHAR2,
                                       INS_UNQCOND IN VARCHAR2) RETURN TIMESTAMP IS
    EXE_SQL VARCHAR2(2048);
    RET_TS  TIMESTAMP;
  BEGIN
    EXE_SQL := 'SELECT SCN_TO_TIMESTAMP(ORA_ROWSCN) FROM '||INS_TAB||' WHERE '||INS_UNQCOND;
    EXECUTE IMMEDIATE EXE_SQL INTO RET_TS;
    RETURN RET_TS;
  END F_GET_LAST_UPDATE_TIMESTAMP;

  --获取最后更新时间与系统更新时间秒数差(封装前两个)
  FUNCTION F_GET_SECOND_DIFFERENCE(INS_TAB     IN VARCHAR2,
                                   INS_UNQCOND IN VARCHAR2) RETURN NUMBER IS
    TMPTS   TIMESTAMP;
    TMPSEC  NUMBER(16,6);
  BEGIN
    TMPTS := SCMDATA.PKG_PORT_TIMED_TASKS.F_GET_LAST_UPDATE_TIMESTAMP(INS_TAB     => INS_TAB,
                                                                      INS_UNQCOND => INS_UNQCOND);
    TMPSEC := SCMDATA.PKG_PORT_TIMED_TASKS.F_GET_TWO_TIMESTAMPS_DIFFERENCE_HMS(INS_TIMESTAMP => TMPTS);
    RETURN TMPSEC;
  END;

  --获取与系统时间戳之间的秒数差
  FUNCTION F_GET_TWO_TIMESTAMPS_DIFFERENCE_HMS(INS_TIMESTAMP IN TIMESTAMP) RETURN NUMBER IS
    TS1   TIMESTAMP:=INS_TIMESTAMP;
    TS2   TIMESTAMP:=SYSTIMESTAMP;
    SEC1  NUMBER(16,6);
    SEC2  NUMBER(16,6);
  BEGIN
    SELECT EXTRACT(HOUR FROM TS1)*60*60 +
           EXTRACT(MINUTE FROM TS1)*60 +
           EXTRACT(SECOND FROM TS1)
      INTO SEC1
      FROM DUAL;
    SELECT EXTRACT(HOUR FROM TS2)*60*60 +
           EXTRACT(MINUTE FROM TS2)*60 +
           EXTRACT(SECOND FROM TS2)
      INTO SEC2
      FROM DUAL;
    RETURN SEC2-SEC1;
  END F_GET_TWO_TIMESTAMPS_DIFFERENCE_HMS;



  --获取格式化列值(单行)
  FUNCTION F_GET_FMTVALS_S(INS_OAT   IN VARCHAR2,
                           INS_COLS  IN VARCHAR2,
                           INS_VALS  IN VARCHAR2) RETURN VARCHAR2 IS
    V_OWNER    VARCHAR2(32):=SUBSTR(INS_OAT,1,INSTR(INS_OAT,'.')-1);
    V_TABLE    VARCHAR2(32):=SUBSTR(INS_OAT,INSTR(INS_OAT,'.')+1,LENGTH(INS_OAT));
    ICOLS      VARCHAR2(2048):=INS_COLS||',';
    CCOL       VARCHAR2(32);
    IVALS      VARCHAR2(2048):=INS_VALS||',';
    CVAL       VARCHAR2(64);
    TMPV       VARCHAR2(64);
    JUDGE_STR  VARCHAR2(16);
    EXE_SQL    CLOB;
    ERR_INFO   CLOB;
    ISTVALS    VARCHAR2(2048);
    BEPOS      NUMBER(8);
  BEGIN
    WHILE LENGTH(ICOLS) > 0 LOOP
      CCOL  := SUBSTR(ICOLS, 1, INSTR(ICOLS, ',') - 1);
      ICOLS := SUBSTR(ICOLS, INSTR(ICOLS, ',') + 1, LENGTH(ICOLS));
      CVAL  := SUBSTR(IVALS, 1, INSTR(IVALS, ',') - 1);
      IF INSTR(CVAL,'(') > 0 THEN
        BEPOS := INSTR(IVALS,'),',INSTR(IVALS,','),1);
        CVAL  := SUBSTR(IVALS,1,BEPOS);
        IVALS := SUBSTR(IVALS,BEPOS+2,LENGTH(IVALS));
      ELSE 
        IVALS := SUBSTR(IVALS, INSTR(IVALS, ',') + 1, LENGTH(IVALS));
      END IF;
      BEGIN
        SELECT DATA_TYPE
          INTO JUDGE_STR
          FROM SCMDATA.ALL_TAB_COLUMNS_BACKUP
         WHERE OWNER = V_OWNER
           AND TABLE_NAME = V_TABLE
           AND COLUMN_NAME = CCOL;
      EXCEPTION
        WHEN OTHERS THEN
          ERR_INFO := 'ERR_MESSAGE: ' || SQLERRM || CHR(10) ||
                      'ERR_MENTION: WRONG TABLE COLUMN' || CHR(10) ||
                      'ERR_COL: ' || CCOL || CHR(10) ||
                      'ERR_COLS: ' || ICOLS || CHR(10) ||
                      'TABLE_NAME: ' || V_OWNER || '.' || V_TABLE;
          RAISE_APPLICATION_ERROR(-20002, ERR_INFO);
      END;
      IF JUDGE_STR = 'VARCHAR2' OR JUDGE_STR = 'BLOB' OR JUDGE_STR = 'CLOB' THEN
        ISTVALS := ISTVALS || ',' || 'q''['||CVAL||']''';
      ELSIF JUDGE_STR = 'DATE' THEN
        EXE_SQL := 'SELECT TO_CHAR(CAST('''||CVAL||''' AS DATE),''yyyy-MM-dd HH24-mi-ss'') FROM DUAL';
        EXECUTE IMMEDIATE EXE_SQL INTO TMPV;
        ISTVALS := ISTVALS || ',' || 'TO_DATE('''||TMPV||''', ''yyyy-MM-dd HH24-mi-ss'')';
      ELSIF JUDGE_STR = 'TIMESTAMP' THEN
        EXE_SQL := 'SELECT TO_CHAR('||CVAL||', ''yyyy-MM-dd HH24-mi-ss-ff'') FROM DUAL';
        EXECUTE IMMEDIATE EXE_SQL INTO TMPV;
        ISTVALS := ISTVALS || ',' || 'TO_TIMESTAMP('''||TMPV||''', ''yyyy-MM-dd HH24-mi-ss-ff'')';
      ELSIF JUDGE_STR = 'NUMBER' OR JUDGE_STR = 'INTEGER' THEN
        ISTVALS := ISTVALS || ',' || TMPV;
      END IF;
    END LOOP;
    ISTVALS := LTRIM(ISTVALS,',');
    RETURN ISTVALS;
  END F_GET_FMTVALS_S;



  --获取格式化列值（运行后可存入单个变量）
  FUNCTION F_GET_FMTVALS_IN_ONE(INS_OAT   IN VARCHAR2,
                                INS_COLS  IN VARCHAR2,
                                INS_VALS  IN VARCHAR2) RETURN VARCHAR2 IS
    V_OWNER    VARCHAR2(32):=SUBSTR(INS_OAT,1,INSTR(INS_OAT,'.')-1);
    V_TABLE    VARCHAR2(32):=SUBSTR(INS_OAT,INSTR(INS_OAT,'.')+1,LENGTH(INS_OAT));
    ICOLS      VARCHAR2(2048):=INS_COLS||',';
    CCOL       VARCHAR2(32);
    IVALS      VARCHAR2(2048):=INS_VALS||',';
    CVAL       VARCHAR2(64);
    TMPV       VARCHAR2(64);
    JUDGE_STR  VARCHAR2(16);
    EXE_SQL    CLOB;
    ERR_INFO   CLOB;
    ISTVALS    VARCHAR2(2048);
    BEPOS      NUMBER(8);
  BEGIN
    WHILE LENGTH(ICOLS) > 0 LOOP
      CCOL  := SUBSTR(ICOLS, 1, INSTR(ICOLS, ',') - 1);
      ICOLS := SUBSTR(ICOLS, INSTR(ICOLS, ',') + 1, LENGTH(ICOLS));
      CVAL  := SUBSTR(IVALS, 1, INSTR(IVALS, ',') - 1);
      IF INSTR(CVAL,'(') > 0 THEN
        BEPOS := INSTR(IVALS,'),',INSTR(IVALS,','),1);
        CVAL  := SUBSTR(IVALS,1,BEPOS);
        IVALS := SUBSTR(IVALS,BEPOS+2,LENGTH(IVALS));
      ELSE 
        IVALS := SUBSTR(IVALS, INSTR(IVALS, ',') + 1, LENGTH(IVALS));
      END IF;
      BEGIN
        SELECT DATA_TYPE
          INTO JUDGE_STR
          FROM SCMDATA.ALL_TAB_COLUMNS_BACKUP
         WHERE OWNER = V_OWNER
           AND TABLE_NAME = V_TABLE
           AND COLUMN_NAME = CCOL;
      EXCEPTION
        WHEN OTHERS THEN
          ERR_INFO := 'ERR_MESSAGE: ' || SQLERRM || CHR(10) ||
                      'ERR_MENTION: WRONG TABLE COLUMN' || CHR(10) ||
                      'ERR_COL: ' || CCOL || CHR(10) ||
                      'ERR_COLS: ' || ICOLS || CHR(10) ||
                      'TABLE_NAME: ' || V_OWNER || '.' || V_TABLE;
          RAISE_APPLICATION_ERROR(-20002, ERR_INFO);
      END;
      IF JUDGE_STR = 'VARCHAR2' OR JUDGE_STR = 'BLOB' OR JUDGE_STR = 'CLOB' THEN
        ISTVALS := ISTVALS || '||'',''||' || 'q''['||CVAL||']''';
      ELSIF JUDGE_STR = 'DATE' THEN
        EXE_SQL := 'SELECT TO_CHAR(CAST('''||CVAL||''' AS DATE),''yyyy-MM-dd HH24-mi-ss'') FROM DUAL';
        EXECUTE IMMEDIATE EXE_SQL INTO TMPV;
        ISTVALS := ISTVALS || '||'',''||' || 'TO_DATE('''||TMPV||''', ''yyyy-MM-dd HH24-mi-ss'')';
      ELSIF JUDGE_STR = 'TIMESTAMP' THEN
        EXE_SQL := 'SELECT TO_CHAR('||CVAL||', ''yyyy-MM-dd HH24-mi-ss-ff'') FROM DUAL';
        EXECUTE IMMEDIATE EXE_SQL INTO TMPV;
        ISTVALS := ISTVALS || '||'',''||' || 'TO_TIMESTAMP('''||TMPV||''', ''yyyy-MM-dd HH24-mi-ss-ff'')';
      ELSIF JUDGE_STR = 'NUMBER' OR JUDGE_STR = 'INTEGER' THEN
        ISTVALS := ISTVALS || '||'',''||' || TMPV;
      END IF;
    END LOOP;
    ISTVALS := LTRIM(ISTVALS,',');
    RETURN ISTVALS;
  END F_GET_FMTVALS_IN_ONE;




  --普通插入
  PROCEDURE P_PUT_DATA_INTO_PTT(INS_OAT    IN VARCHAR2,
                                INS_OPER   IN VARCHAR2,
                                INS_COLS   IN VARCHAR2,
                                INS_VALS   IN CLOB,
                                INS_DU     IN VARCHAR2) IS
    ISTVALS     VARCHAR2(2048);
  BEGIN
    ISTVALS := SCMDATA.PKG_PORT_TIMED_TASKS.F_GET_FMTVALS_S(INS_OAT  => INS_OAT,
                                                            INS_COLS => INS_COLS,
                                                            INS_VALS => INS_VALS); 
    INSERT INTO SCMDATA.PORT_TIMED_TASKS
      (OPER_ID,TAB_NAME,OPERATION,OPER_TIME, COL_NAMES,
       COL_VALUES,DATA_UNIQUE,LAST_UPDATE_TIMESTAMP,SELF_ORIGIN)
    VALUES
      (SCMDATA.F_GET_UUID(),INS_OAT,INS_OPER,SYSDATE,
       INS_COLS,ISTVALS,INS_DU,SYSTIMESTAMP,'scm');
  END P_PUT_DATA_INTO_PTT;



  --数据同步处理与执行
  PROCEDURE P_SYNC_DATA_PROCESS_AND_EXECUTE(INS_OPID  IN VARCHAR2,
                                            INS_SO    IN VARCHAR2,
                                            INS_OAT   IN VARCHAR2,
                                            INS_OPER  IN VARCHAR2,
                                            INS_COLS  IN VARCHAR2,
                                            INS_VALS  IN VARCHAR2,
                                            INS_DU    IN VARCHAR2,
                                            INS_EO    IN VARCHAR2,
                                            INS_SEC   IN NUMBER,
                                            INS_MACN  IN VARCHAR2,
                                            INS_IPAD  IN VARCHAR2,
                                            INS_LGID  IN VARCHAR2) IS
    TYPE PORTVALUE IS TABLE OF VARCHAR2(256) INDEX BY VARCHAR2(64);
    PV  PORTVALUE;
    TMP_COLS   VARCHAR2(2048):=INS_COLS||',';
    TMP_VALS   VARCHAR2(2048):=INS_VALS||',';
    TMP_COL    VARCHAR2(32);
    TMP_VAL    VARCHAR2(256); 
    BEPOS      NUMBER(8);
    TAR_TAB    VARCHAR2(64);
    SYORI      VARCHAR2(32):='scm'; 
    BUNQC      VARCHAR2(512);
    TAR_COLS   VARCHAR2(2048);
    TAR_VALS   VARCHAR2(2048);
    TCOL_PLUS  VARCHAR2(512);
    TVAL_PLUS  VARCHAR2(512);
    TAR_SEC    NUMBER(16,6);
    TAR_DU     VARCHAR2(512):=INS_DU;
    JUG_NUM    NUMBER(4);
    JUG_LUT    TIMESTAMP;
    EXE_SQL    VARCHAR2(2048);
  BEGIN
    WHILE LENGTH(TMP_COLS) > 0 LOOP
      TMP_COL  := SUBSTR(TMP_COLS,1,INSTR(TMP_COLS,',')-1);
      TMP_COLS := SUBSTR(TMP_COLS,INSTR(TMP_COLS,',')+1,LENGTH(TMP_COLS));
      TMP_VAL  := SUBSTR(TMP_VALS,1,INSTR(TMP_VALS,',')-1);
      IF REGEXP_COUNT(TMP_VAL,'\(') > 0 THEN
        BEPOS    := INSTR(TMP_VALS,'),',INSTR(TMP_VALS,','),1);
        TMP_VAL  := SUBSTR(TMP_VALS,1,BEPOS);
        PV(TMP_COL) := TMP_VAL;
        TMP_VALS := SUBSTR(TMP_VALS,BEPOS+2,LENGTH(TMP_VALS)-BEPOS);
      ELSE
        PV(TMP_COL) := TMP_VAL;
        TMP_VALS := SUBSTR(TMP_VALS,INSTR(TMP_VALS,',')+1,LENGTH(TMP_VALS));
      END IF;
    END LOOP;

    SELECT ORD_TABLE, BEORD_UNQCOLS
      INTO TAR_TAB, BUNQC
      FROM SCMDATA.PORT_TABLE_UNQ_COLUMNS
     WHERE BEORD_NAME = INS_SO
       AND ORD_NAME = SYORI
       AND BEORD_TABLE = INS_OAT;

    IF INS_OPER = 'I' THEN
      SELECT ','||LISTAGG(ORD_COLUMN,',')  WITHIN GROUP(ORDER BY RN), 
             ','||LISTAGG(DEFAULT_VAL,',') WITHIN GROUP(ORDER BY RN)
        INTO TCOL_PLUS,TVAL_PLUS
        FROM (SELECT ORD_COLUMN, DEFAULT_VAL, ROWNUM RN 
                FROM SCMDATA.PORT_ORD_DEFAULT_VALUES
               WHERE BEORD_NAME = INS_SO
                 AND ORD_NAME = SYORI
                 AND BEORD_TABLE = INS_OAT);

      FOR X IN (SELECT BEORD_COLUMN,ORD_COLUMN 
                  FROM SCMDATA.PORT_TABLE_COLUMN_MAPPING
                 WHERE BEORD_NAME = INS_SO
                   AND ORD_NAME = SYORI
                   AND BEORD_TABLE = INS_OAT
                   AND REGEXP_COUNT(INS_COLS||',',BEORD_COLUMN||',') > 0
                   AND PAUSE = 0) LOOP
        TAR_COLS := TAR_COLS||','||X.ORD_COLUMN;
        TAR_VALS := TAR_VALS||','||PV(X.BEORD_COLUMN);
        IF REGEXP_COUNT(BUNQC||',',X.BEORD_COLUMN||',') > 0 THEN
          TAR_DU := REPLACE(TAR_DU,X.BEORD_COLUMN,X.ORD_COLUMN);
        END IF;
      END LOOP;
      TAR_COLS := LTRIM(TAR_COLS,',');
      TAR_VALS := REPLACE(LTRIM(TAR_VALS,','),'''','''''');
      --查询比对
      SELECT COUNT(1)
        INTO JUG_NUM
        FROM SCMDATA.PORT_TIMED_TASKS
       WHERE OPERATION = INS_OPER
         AND TAB_NAME = TAR_TAB
         AND COL_NAMES = TAR_COLS
         AND COL_VALUES = TAR_VALS
         AND DATA_UNIQUE = TAR_DU;
      IF JUG_NUM = 0 THEN
        --未存在数据，最后更新时间无，或比当前数据更新时间小
        IF LENGTH(TCOL_PLUS) > 1 THEN 
          TAR_COLS := TAR_COLS||TCOL_PLUS;
          TAR_VALS := TAR_VALS||TVAL_PLUS;
        END IF;
        EXE_SQL := 'BEGIN INSERT INTO '||TAR_TAB||' ('||TAR_COLS||') VALUES ('||TAR_VALS||'); '||
                      INS_EO||' END;';
        --DBMS_OUTPUT.PUT_LINE(EXE_SQL); 
        EXECUTE IMMEDIATE REPLACE(EXE_SQL,'''''','''');
        --COMMIT;
        SCMDATA.PKG_PORT_TIMED_TASKS.P_SET_SYNC_TIMESTAMP(INS_OAT   => TAR_TAB,
                                                          INS_COLS  => TAR_COLS,
                                                          INS_VALS  => TAR_VALS,
                                                          INS_OPER  => 'I',
                                                          INS_DU    => TAR_DU);
          
      ELSE
        --已存在数据，更新时间“更”新（由别的端同步）
        EXE_SQL := 'SELECT '||REPLACE(TAR_COLS,',','||'',''||')||' FROM '||TAR_TAB||' WHERE '||TAR_DU;
        EXECUTE IMMEDIATE EXE_SQL INTO TAR_VALS;
        SCMDATA.PKG_PORT_TIMED_TASKS.P_INSERT_PORT_TIMED_TASKS(INS_OPER  => 'U',
                                                               INS_OAT   => TAR_TAB,
                                                               INS_COLS  => TAR_COLS,
                                                               INS_VALS  => TAR_VALS,
                                                               INS_DU    => TAR_DU);
      END IF; 
    ELSIF INS_OPER = 'U' THEN
      FOR Y IN (SELECT BEORD_COLUMN,ORD_COLUMN 
                  FROM SCMDATA.PORT_TABLE_COLUMN_MAPPING
                 WHERE BEORD_NAME = INS_SO
                   AND ORD_NAME = SYORI
                   AND BEORD_TABLE = INS_OAT
                   AND REGEXP_COUNT(INS_COLS||',',BEORD_COLUMN||',') > 0
                   AND PAUSE = 0) LOOP
        IF REGEXP_COUNT(BUNQC||',',Y.BEORD_COLUMN||',') = 0 THEN
          TAR_COLS := TAR_COLS||','||Y.ORD_COLUMN;
          TAR_VALS := TAR_VALS||','||PV(Y.BEORD_COLUMN);
        ELSE
          TAR_DU := REPLACE(TAR_DU,Y.BEORD_COLUMN,Y.ORD_COLUMN);
        END IF;
      END LOOP;
      TAR_COLS := LTRIM(TAR_COLS,',');
      TAR_VALS := REPLACE(LTRIM(TAR_VALS,','),'''','''''');
      --查询比对
      SELECT COUNT(1),MAX(LAST_UPDATE_TIMESTAMP)
        INTO JUG_NUM,JUG_LUT
        FROM SCMDATA.PORT_TIMED_TASKS
       WHERE OPERATION = INS_OPER
         AND TAB_NAME = TAR_TAB
         AND COL_NAMES = TAR_COLS
         AND COL_VALUES = TAR_VALS
         AND DATA_UNIQUE = TAR_DU;
      TAR_SEC := SCMDATA.PKG_PORT_TIMED_TASKS.F_GET_TWO_TIMESTAMPS_DIFFERENCE_HMS(INS_TIMESTAMP => JUG_LUT); 
      IF JUG_NUM = 0 OR (JUG_NUM > 0 AND TAR_SEC < INS_SEC) THEN
        EXE_SQL  := 'BEGIN UPDATE '||TAR_TAB||' SET ('||TAR_COLS||') = (SELECT '||TAR_VALS||
                     ' FROM DUAL) WHERE '||TAR_DU||'; '||INS_EO||' END;';
        DBMS_OUTPUT.PUT_LINE(EXE_SQL);
        /*EXECUTE IMMEDIATE EXE_SQL;
        SCMDATA.PKG_PORT_TIMED_TASKS.P_SET_SYNC_TIMESTAMP(INS_OAT   => INS_OAT,
                                                        INS_COLS  => INS_COLS,
                                                        INS_VALS  => INS_VALS,
                                                        INS_OPER  => INS_OPER,
                                                        INS_DU    => TAR_DU);*/
      ELSE
        EXE_SQL := 'SELECT '||REPLACE(TAR_COLS,',','||'',''||')||' FROM '||TAR_TAB||' WHERE '||TAR_DU;
        EXECUTE IMMEDIATE EXE_SQL INTO TAR_VALS;
        SCMDATA.PKG_PORT_TIMED_TASKS.P_INSERT_PORT_TIMED_TASKS(INS_OPER  => INS_OPER,
                                                               INS_OAT   => TAR_TAB,
                                                               INS_COLS  => TAR_COLS,
                                                               INS_VALS  => TAR_VALS,
                                                               INS_DU    => TAR_DU);
      END IF;  
    ELSIF INS_OPER = 'D' THEN
      FOR Z IN (SELECT BEORD_COLUMN,ORD_COLUMN 
                  FROM SCMDATA.PORT_TABLE_COLUMN_MAPPING
                 WHERE BEORD_NAME = INS_SO
                   AND ORD_NAME = SYORI
                   AND BEORD_TABLE = INS_OAT
                   AND REGEXP_COUNT(BUNQC||',',BEORD_COLUMN||',') > 0) LOOP
        TAR_DU := REPLACE(TAR_DU,Z.BEORD_COLUMN,Z.ORD_COLUMN);
      END LOOP;
      --查询比对
      SELECT COUNT(1)
        INTO JUG_NUM
        FROM SCMDATA.PORT_TIMED_TASKS
       WHERE OPERATION = INS_OPER
         AND TAB_NAME = TAR_TAB
         AND COL_NAMES = TAR_COLS
         AND COL_VALUES = TAR_VALS
         AND DATA_UNIQUE = TAR_DU;
      TAR_SEC := SCMDATA.PKG_PORT_TIMED_TASKS.F_GET_TWO_TIMESTAMPS_DIFFERENCE_HMS(INS_TIMESTAMP => JUG_LUT); 
      IF JUG_NUM = 0 OR (JUG_NUM > 0 AND TAR_SEC < INS_SEC) THEN
        EXE_SQL := 'BEGIN DELETE FROM '||TAR_TAB||' WHERE '||TAR_DU||'; '||INS_EO||' END;'; 
        DBMS_OUTPUT.PUT_LINE(EXE_SQL); 
        --EXECUTE IMMEDIATE EXE_SQL;
        /*SCMDATA.PKG_PORT_TIMED_TASKS.P_SET_SYNC_TIMESTAMP(INS_OAT   => INS_OAT,
                                                            INS_COLS  => INS_COLS,
                                                            INS_VALS  => INS_VALS,
                                                            INS_OPER  => INS_OPER,
                                                            INS_DU    => TAR_DU);*/
      END IF;
    END IF;
    --回写到表
    SCMDATA.PKG_PORT_TIMED_TASKS.P_INSERT_WBIDS(INS_SO   => INS_SO,
                                                INS_MACN => INS_MACN,
                                                INS_IPAD => INS_IPAD,
                                                INS_OPERID => INS_OPID);
    EXCEPTION 
      WHEN OTHERS THEN 
        UPDATE SCMDATA.PORT_TIMED_TASKS_LOG T
           SET ERR_INFO = NVL(T.ERR_INFO,' ')||' '||INS_OPID
         WHERE LOG_ID   = INS_LGID;
  END P_SYNC_DATA_PROCESS_AND_EXECUTE;



  --对于插入后触发器插入到 PORT_TIMED_TASKS 的值进行 SYNC_TIMESTAMP 的设置
  PROCEDURE P_SET_SYNC_TIMESTAMP(INS_OAT   IN VARCHAR2,
                                 INS_COLS  IN VARCHAR2,
                                 INS_VALS  IN VARCHAR2,
                                 INS_OPER  IN VARCHAR2,
                                 INS_DU    IN VARCHAR2) IS 
    TMP_VALS  VARCHAR2(2048):=INS_VALS;
  BEGIN
    TMP_VALS := REPLACE(REPLACE(REPLACE(TMP_VALS,'q[',''),']',''),'''','');
    TMP_VALS := SCMDATA.PKG_PORT_TIMED_TASKS.F_GET_FMTVALS_IN_ONE(INS_OAT  =>INS_OAT,
                                                                  INS_COLS =>INS_COLS,
                                                                  INS_VALS =>TMP_VALS);
    UPDATE SCMDATA.PORT_TIMED_TASKS
       SET SYNC_TIMESTAMP = SYSTIMESTAMP
     WHERE OPERATION  = INS_OPER
       AND TAB_NAME   = INS_OAT
       AND COL_NAMES = INS_COLS
       AND COL_VALUES = TMP_VALS
       AND DATA_UNIQUE = INS_DU;
  END P_SET_SYNC_TIMESTAMP;



  --插入到回写id表
  PROCEDURE P_INSERT_WBIDS(INS_SO      IN VARCHAR2,
                           INS_MACN    IN VARCHAR2,
                           INS_IPAD    IN VARCHAR2,
                           INS_OPERID  IN VARCHAR2) IS
  BEGIN
    INSERT INTO SCMDATA.PORT_WRITE_BACK_IDS
      (PWBI_ID, BEORD_NAME, MAC_NAME, IP_ADDRESS, CHANGED_ID)
    VALUES
      (SCMDATA.F_GET_UUID(), INS_SO, INS_MACN, INS_IPAD, INS_OPERID);
  END P_INSERT_WBIDS;

  
  
  --删除相关id
  PROCEDURE P_DELETE_RELA_WBIDS(INS_SO      IN VARCHAR2,
                                INS_MACN    IN VARCHAR2,
                                INS_IPAD    IN VARCHAR2,
                                INS_IDS     IN VARCHAR2) IS
  BEGIN
    DELETE FROM SCMDATA.PORT_WRITE_BACK_IDS 
     WHERE BEORD_NAME = INS_SO 
       AND MAC_NAME   = INS_MACN
       AND IP_ADDRESS = INS_IPAD
       AND REGEXP_COUNT(INS_IDS,CHANGED_ID) > 0;
  END P_DELETE_RELA_WBIDS;



  --插入到 PORT_TIMED_TASKS
  PROCEDURE P_INSERT_PORT_TIMED_TASKS(INS_OPER  IN VARCHAR2,
                                      INS_OAT   IN VARCHAR2,
                                      INS_COLS  IN VARCHAR2,
                                      INS_VALS  IN VARCHAR2,
                                      INS_DU    IN VARCHAR2,
                                      INS_EO    IN VARCHAR2,
                                      INS_SYOI  IN VARCHAR2 DEFAULT NULL) IS
    EXE_SQL  CLOB;
  BEGIN
    EXE_SQL := 'INSERT INTO SCMDATA.PORT_TIMED_TASKS 
                  (OPER_ID,OPERATION,OPER_TIME,TAB_NAME,COL_NAMES,COL_VALUES,
                   LAST_UPDATE_TIMESTAMP,DATA_UNIQUE,SELF_ORIGIN,EXTRA_OPERATION,SYNC_ORIGIN) 
                VALUES 
                  (SCMDATA.F_GET_UUID(),'||INS_OPER||',SYSDATE,'||INS_OAT||','||
                   INS_COLS||','||INS_VALS||','||SYSTIMESTAMP||','||INS_DU||',''scm'','||INS_EO||','||INS_SYOI||')';
    DBMS_OUTPUT.PUT_LINE(EXE_SQL); 
    --EXECUTE IMMEDIATE EXE_SQL;
   END P_INSERT_PORT_TIMED_TASKS;  


END PKG_PORT_TIMED_TASKS;
/

