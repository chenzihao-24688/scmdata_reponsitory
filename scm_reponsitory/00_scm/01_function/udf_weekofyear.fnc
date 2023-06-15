CREATE OR REPLACE FUNCTION SCMDATA.UDF_WEEKOFYEAR(V_DATE  IN date,
                                          formate IN VARCHAR2)
return char AS
  v_ret  char(36);
  v_ret1 char(32);
  v_ret3 NUMBER;
BEGIN

  v_ret3 := TO_CHAR(v_date, 'iw');
  IF v_ret3 = 1 AND TO_CHAR(v_date, 'mm') = '12' then
    --判断是否是最后一个月 周次算成下年了第一周
    SELECT TO_CHAR(DECODE(SIGN((V_DATE +
                               TO_NUMBER(DECODE(TO_CHAR(TRUNC(V_DATE,
                                                               'YYYY'),
                                                         'D'),
                                                 '1',
                                                 '8',
                                                 TO_CHAR(TRUNC(V_DATE,
                                                               'YYYY'),
                                                         'D'))) - 2) -
                               LAST_DAY(V_DATE)),
                          1,
                          LAST_DAY(V_DATE),
                          (V_DATE +
                          TO_NUMBER(DECODE(TO_CHAR(TRUNC(V_DATE, 'YYYY'),
                                                    'D'),
                                            '1',
                                            '8',
                                            TO_CHAR(TRUNC(V_DATE, 'YYYY'),
                                                    'D'))) - 2)),
                   'WW') as week
      into v_ret1
      FROM DUAL;
    return to_char(v_date, 'yyyy') || v_ret1;
 else
  v_ret := TO_CHAR(v_date, formate); --正常情况下按自然周处理
  RETURN v_ret;
 end if;
END;
/

