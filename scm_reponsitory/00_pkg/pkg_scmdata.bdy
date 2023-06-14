CREATE OR REPLACE PACKAGE BODY SCMDATA.PKG_SCMDATA.XXL_JOB_ERR_KILL IS

  /*=================================================================================

    杀掉 XXL_JOB 因语句导致锁表的 session

    用途:
      杀掉 XXL_JOB 因语句导致锁表的 session

    入参:
      V_SQLBEGIN    :  语句开始
      V_SQLEND      :  语句结束
    版本:
      2022-03-03 : 杀掉 XXL_JOB 因语句导致锁表的 session

  =================================================================================*/
  PROCEDURE P_KILL_SESSION_BY_CAUSELOCKSQL(V_SQLBEGIN IN VARCHAR2,
                                           V_SQLEND   IN VARCHAR2) IS
    V_BEGIN      VARCHAR2(1024);
    V_END        VARCHAR2(1024);
    V_EXESQL     CLOB;
  BEGIN

    IF INSTR(V_SQLBEGIN,'^') = 0 THEN
      V_BEGIN := '^'|| V_SQLBEGIN;
    ELSE
      V_BEGIN := '^'|| REPLACE(V_SQLBEGIN,'%','');
    END IF;

    IF INSTR(V_SQLEND,'$') = 0 THEN
      V_END := V_SQLEND||'$';
    ELSE
      V_END := REPLACE(V_SQLEND,'$','') || '$';
    END IF;

    V_EXESQL := 'DECLARE
      V_EXESQL VARCHAR2(128);
    BEGIN
      FOR I IN (SELECT L.SESSION_ID SID,
                       S.SERIAL#    SERIAL
                  FROM V$SQLAREA A, V$SESSION S, V$LOCKED_OBJECT L
                 WHERE L.SESSION_ID = S.SID
                   AND S.PREV_SQL_ADDR = A.ADDRESS
                   AND REGEXP_INSTR(A.SQL_TEXT,'''||V_BEGIN||''') > 0
                   AND REGEXP_INSTR(A.SQL_TEXT,'''||V_END||''') > 0
                 ORDER BY SID, S.SERIAL#) LOOP
        V_EXESQL := ''ALTER system kill session ''''''||TO_CHAR(I.SID)||'',''||TO_CHAR(I.SERIAL)||'''''''';
        EXECUTE IMMEDIATE V_EXESQL;
      END LOOP;
    END;';

    EXECUTE IMMEDIATE V_EXESQL;

  END P_KILL_SESSION_BY_CAUSELOCKSQL;

END PKG_XXL_JOB_ERR_KILL;
/

