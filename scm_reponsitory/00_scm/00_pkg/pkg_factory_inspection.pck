CREATE OR REPLACE PACKAGE SCMDATA.pkg_factory_inspection IS

  --判断新的子类是否重复
  PROCEDURE p_jug_multi_subcate(v_multi IN VARCHAR2, v_single IN VARCHAR2);

  --校验历史子类
  FUNCTION f_hissubcate_check(v_hissub IN VARCHAR2, v_newsub IN VARCHAR2)
    RETURN VARCHAR2;

  --判断分类/生产分类是否重复
  PROCEDURE p_jug_ins_cateorprocate_repeat(v_frid   IN VARCHAR2,
                                           v_type   IN VARCHAR2,
                                           v_cate   IN VARCHAR2,
                                           v_proc   IN VARCHAR2,
                                           v_compid IN VARCHAR2);

  --判断分类/生产分类是否重复
  PROCEDURE p_jug_upd_cateorprocate_repeat(v_frid   IN VARCHAR2,
                                           v_fraid  IN VARCHAR2,
                                           v_type   IN VARCHAR2,
                                           v_cate   IN VARCHAR2,
                                           v_proc   IN VARCHAR2,
                                           v_compid IN VARCHAR2);

  --针对验厂报告结果进行校验
  PROCEDURE p_jug_report_result(v_frid IN VARCHAR2, v_compid IN VARCHAR2);

  --校验是否是从意向合作分类带过来的数据
  FUNCTION f_jug_coopcps_and_fracps(v_faid   IN VARCHAR2,
                                    v_frid   IN VARCHAR2,
                                    v_compid IN VARCHAR2) RETURN VARCHAR2;

  --校验、新增能力评估项
  PROCEDURE p_check_cps(v_faid IN VARCHAR2, v_compid IN VARCHAR2);

  --驳回同时删除能力评估信息
  PROCEDURE p_reject_and_delete_ability_record(v_faid   IN VARCHAR2,
                                               v_compid IN VARCHAR2);

END pkg_factory_inspection;
/

CREATE OR REPLACE PACKAGE BODY SCMDATA.PKG_FACTORY_INSPECTION IS

  --判断新的子类是否重复
  PROCEDURE P_JUG_MULTI_SUBCATE(V_MULTI  IN VARCHAR2,
                                V_SINGLE IN VARCHAR2) IS
    JUG_STR VARCHAR2(1024):=V_MULTI||';';
    TMP_STR VARCHAR2(256):=V_SINGLE||';';
    TMP_SIN VARCHAR2(8);
  BEGIN
    IF V_MULTI IS NOT NULL THEN
      WHILE (TMP_STR IS NOT NULL) LOOP
        TMP_SIN := SUBSTR(TMP_STR,1,INSTR(TMP_STR,';')-1);
        TMP_STR := SUBSTR(TMP_STR,INSTR(TMP_STR,';')+1,LENGTH(TMP_STR));
        IF INSTR(JUG_STR,TMP_SIN) > 0 THEN
          RAISE_APPLICATION_ERROR(-20002,'存在重复子类，请检查！');
        END IF;
      END LOOP;
    END IF;
  END P_JUG_MULTI_SUBCATE;

  --校验历史子类
  FUNCTION F_HISSUBCATE_CHECK(V_HISSUB  IN VARCHAR2,
                              V_NEWSUB  IN VARCHAR2) RETURN VARCHAR2 IS
    TMP_HIS  VARCHAR2(512):=V_HISSUB||';';
    TMP_NEW  VARCHAR2(512):=V_NEWSUB||';';
    TMP_SUB  VARCHAR2(8);
    RET_STR  VARCHAR2(4):='PS';
  BEGIN
    IF LENGTH(TMP_HIS) = LENGTH(TMP_NEW) THEN 
      WHILE LENGTH(TMP_NEW)>0 LOOP
        TMP_SUB := SUBSTR(TMP_NEW,1,INSTR(TMP_NEW,';'));
        TMP_NEW := SUBSTR(TMP_NEW,INSTR(TMP_NEW,';')+1,LENGTH(TMP_NEW));
        TMP_HIS := REPLACE(TMP_HIS,TMP_SUB,'');
      END LOOP; 
      IF REGEXP_COUNT(TMP_HIS,'\w') > 0 THEN 
        RET_STR := 'ER';
      END IF;
    END IF;
    RETURN RET_STR;
  END F_HISSUBCATE_CHECK;


  --判断新增时分类/生产分类是否重复
  PROCEDURE P_JUG_INS_CATEORPROCATE_REPEAT(V_FRID   IN VARCHAR2,
                                           V_TYPE   IN VARCHAR2,
                                           V_CATE   IN VARCHAR2,
                                           V_PROC   IN VARCHAR2,
                                           V_COMPID IN VARCHAR2) IS
    JUG_NUM    NUMBER(1);
  BEGIN
    SELECT MAX(1)
      INTO JUG_NUM
      FROM SCMDATA.T_FACTORY_REPORT_ABILITY
     WHERE FACTORY_REPORT_ID = V_FRID
       AND COMPANY_ID = V_COMPID
       AND COOPERATION_TYPE = V_TYPE
       AND COOPERATION_CLASSIFICATION = V_CATE
       AND COOPERATION_PRODUCT_CATE = V_PROC;

    IF JUG_NUM > 0 THEN
      RAISE_APPLICATION_ERROR(-20002,'存在相同的分类-生产分类，请在原有分类-生产分类上进行修改！');
    END IF;
  END P_JUG_INS_CATEORPROCATE_REPEAT;


  --判断更新时分类/生产分类是否重复
  PROCEDURE P_JUG_UPD_CATEORPROCATE_REPEAT(V_FRID   IN VARCHAR2,
                                           V_FRAID  IN VARCHAR2,
                                           V_TYPE   IN VARCHAR2,
                                           V_CATE   IN VARCHAR2,
                                           V_PROC   IN VARCHAR2,
                                           V_COMPID IN VARCHAR2) IS
    JUG_NUM    NUMBER(1);
  BEGIN
    SELECT MAX(1)
      INTO JUG_NUM
      FROM SCMDATA.T_FACTORY_REPORT_ABILITY
     WHERE FACTORY_REPORT_ID = V_FRID
       AND FACTORY_REPORT_ABILITY_ID <> V_FRAID
       AND COMPANY_ID = V_COMPID
       AND COOPERATION_TYPE = V_TYPE
       AND COOPERATION_CLASSIFICATION = V_CATE
       AND COOPERATION_PRODUCT_CATE = V_PROC;

    IF JUG_NUM > 0 THEN
      RAISE_APPLICATION_ERROR(-20002,'存在相同的分类-生产分类，请在原有分类-生产分类上进行修改！');
    END IF;
  END P_JUG_UPD_CATEORPROCATE_REPEAT;


  --针对验厂报告结果进行校验
  PROCEDURE P_JUG_REPORT_RESULT(V_FRID    IN VARCHAR2,
                                V_COMPID  IN VARCHAR2) IS
    REP_RESULT   VARCHAR2(16);
    AS_SUB       VARCHAR2(2048);
    RAB_RESULTS  VARCHAR2(2048);
    V_FAID       VARCHAR2(32);
  BEGIN
    SELECT max(CHECK_RESULT)
      INTO REP_RESULT
      FROM SCMDATA.T_FACTORY_REPORT
     WHERE FACTORY_REPORT_ID = V_FRID
       AND COMPANY_ID = V_COMPID;
    --取合作范围与能力评估的交集
/* 原代码
   SELECT LISTAGG(COOPERATION_SUBCATEGORY,'^^^^')
      INTO AS_SUB
      FROM SCMDATA.T_ASK_SCOPE
     WHERE (OBJECT_ID,BE_COMPANY_ID)
        IN (SELECT FACTORY_ASK_ID,COMPANY_ID
              FROM SCMDATA.T_FACTORY_REPORT
             WHERE FACTORY_REPORT_ID = V_FRID
               AND COMPANY_ID = V_COMPID);*/
/*lsl167修改
优化从验厂带过来的产品子类
2022-3-31*/
-------开始
    SELECT max(FACTORY_ASK_ID)
      INTO V_FAID
      FROM SCMDATA.T_FACTORY_REPORT
     WHERE FACTORY_REPORT_ID= V_FRID
       AND COMPANY_ID = V_COMPID;

    SELECT LISTAGG(B.COOPERATION_SUBCATEGORY, '^^^^')
      INTO AS_SUB
      FROM (SELECT COOPERATION_TYPE,
                   COOPERATION_CLASSIFICATION,
                   COOPERATION_PRODUCT_CATE,
                   COOPERATION_SUBCATEGORY
              FROM SCMDATA.T_ASK_SCOPE
             WHERE OBJECT_ID = V_FAID
               AND BE_COMPANY_ID = V_COMPID) A
      LEFT JOIN (SELECT COOPERATION_CLASSIFICATION,
                        t.rowid,
                        COOPERATION_PRODUCT_CATE,
                        COOPERATION_SUBCATEGORY
                   FROM SCMDATA.T_FACTORY_REPORT_ABILITY t
                  WHERE FACTORY_REPORT_ID = V_FRID
                    AND COMPANY_ID = V_COMPID) B
        ON A.COOPERATION_CLASSIFICATION = B.COOPERATION_CLASSIFICATION
       AND A.COOPERATION_PRODUCT_CATE = B.COOPERATION_PRODUCT_CATE
       AND SCMDATA.INSTR_PRIV(A.COOPERATION_SUBCATEGORY, B.COOPERATION_SUBCATEGORY) > 0;
-----结束
    SELECT ','||LISTAGG(ABILITY_RESULT,',')||','
      INTO RAB_RESULTS
      FROM SCMDATA.T_FACTORY_REPORT_ABILITY
     WHERE FACTORY_REPORT_ID = V_FRID
       AND COMPANY_ID = V_COMPID
       AND INSTR(AS_SUB,COOPERATION_SUBCATEGORY) > 0;
       
    --试单/验厂通过 则校验能力评估需有符合的单据
    IF INSTR(',00,02,', ',' || REP_RESULT || ',') > 0 AND INSTR(RAB_RESULTS,',AGREE,') = 0 THEN
      RAISE_APPLICATION_ERROR(-20002,'能力评估中自动带入的意向合作范围，不存在"符合"的能力评估，请检查！');
    --验厂不通过
    ELSIF INSTR(',01,',',' || REP_RESULT || ',') > 0 AND INSTR(RAB_RESULTS,',DISAGREE,') = 0 THEN
      RAISE_APPLICATION_ERROR(-20002,'验厂结论为"验厂不通过",能力评估中自动带入的意向合作范围，不存在"不符合"的能力评估，请检查！');  
    ELSE
      NULL;
    END IF;
    
  END P_JUG_REPORT_RESULT;


  --校验是否是从意向合作分类带过来的数据
  FUNCTION F_JUG_COOPCPS_AND_FRACPS(V_FAID    IN VARCHAR2,
                                    V_FRID    IN VARCHAR2,
                                    V_COMPID  IN VARCHAR2) RETURN VARCHAR2 IS
    FRA_CCCP  VARCHAR2(16);
    FRA_CS    VARCHAR2(256);
    AS_CS     VARCHAR2(256);
    TMP_CS    VARCHAR2(8);
    RET_STR   VARCHAR2(8);
  BEGIN
    SELECT COOPERATION_CLASSIFICATION||'-'||COOPERATION_PRODUCT_CATE,
           COOPERATION_SUBCATEGORY||';'
      INTO FRA_CCCP, FRA_CS
      FROM SCMDATA.T_FACTORY_REPORT_ABILITY
     WHERE FACTORY_REPORT_ABILITY_ID = V_FAID
       AND COMPANY_ID = V_COMPID;

    SELECT COOPERATION_SUBCATEGORY||';'
      INTO AS_CS
      FROM SCMDATA.T_ASK_SCOPE
     WHERE COOPERATION_CLASSIFICATION||'-'||COOPERATION_PRODUCT_CATE = FRA_CCCP
       AND (OBJECT_ID,BE_COMPANY_ID) IN 
           (SELECT FACTORY_ASK_ID,COMPANY_ID
              FROM SCMDATA.T_FACTORY_REPORT
             WHERE FACTORY_REPORT_ID = V_FRID
               AND COMPANY_ID = V_COMPID);
    
    WHILE LENGTH(FRA_CS)>0 LOOP
      TMP_CS := SUBSTR(FRA_CS,1,INSTR(FRA_CS,';'));
      FRA_CS := SUBSTR(FRA_CS,INSTR(FRA_CS,';')+1,LENGTH(FRA_CS));
      AS_CS := REPLACE(AS_CS,TMP_CS);
    END LOOP;

    IF AS_CS IS NOT NULL AND REGEXP_COUNT(AS_CS,'\w') = 0 THEN
      --AFFIRM
      RET_STR := 'AF';
    ELSE 
      --NOT CONFRIM
      RET_STR := 'NC';
    END IF;
    RETURN RET_STR;
  END F_JUG_COOPCPS_AND_FRACPS;

  
  --校验、新增能力评估项
  PROCEDURE P_CHECK_CPS(V_FAID    IN VARCHAR2,
                        V_COMPID  IN VARCHAR2) IS
    V_FRID VARCHAR2(32);
  BEGIN
    SELECT FACTORY_REPORT_ID
      INTO V_FRID
      FROM SCMDATA.T_FACTORY_REPORT
     WHERE FACTORY_ASK_ID = V_FAID
       AND COMPANY_ID = V_COMPID;
   FOR I IN (SELECT A.COOPERATION_TYPE ATYPE,
                     A.COOPERATION_CLASSIFICATION ACLAS,
                     A.COOPERATION_PRODUCT_CATE APROC,
                     A.COOPERATION_SUBCATEGORY ASUBC,
                     B.COOPERATION_PRODUCT_CATE BPROC
                FROM (SELECT COOPERATION_TYPE,
                             COOPERATION_CLASSIFICATION,
                             COOPERATION_PRODUCT_CATE,
                             COOPERATION_SUBCATEGORY
                        FROM SCMDATA.T_ASK_SCOPE
                       WHERE OBJECT_ID = V_FAID
                         AND BE_COMPANY_ID = V_COMPID) A
                LEFT JOIN (SELECT COOPERATION_CLASSIFICATION,
                                  COOPERATION_PRODUCT_CATE,
                                  COOPERATION_SUBCATEGORY
                             FROM SCMDATA.T_FACTORY_REPORT_ABILITY
                            WHERE FACTORY_REPORT_ID = V_FRID
                              AND COMPANY_ID = V_COMPID) B
                  ON A.COOPERATION_CLASSIFICATION = B.COOPERATION_CLASSIFICATION
                 AND A.COOPERATION_PRODUCT_CATE = B.COOPERATION_PRODUCT_CATE
             /*原代码    AND A.COOPERATION_SUBCATEGORY = B.COOPERATION_SUBCATEGORY) LOOP*/
    /*  lsl167修改，优化产品子类
          2022-03-31 */
          ----开始
            AND SCMDATA.INSTR_PRIV(A.COOPERATION_SUBCATEGORY ,B.COOPERATION_SUBCATEGORY) >0)LOOP
          ----结束
      IF I.BPROC IS NULL THEN
        --DBMS_OUTPUT.PUT_LINE('插入');
        INSERT INTO SCMDATA.T_FACTORY_REPORT_ABILITY
          (FACTORY_REPORT_ABILITY_ID,COMPANY_ID,FACTORY_REPORT_ID,COOPERATION_TYPE,
           COOPERATION_CLASSIFICATION,COOPERATION_PRODUCT_CATE,COOPERATION_SUBCATEGORY,ABILITY_RESULT)
        VALUES
          (SCMDATA.F_GET_UUID(),V_COMPID,V_FRID,I.ATYPE,I.ACLAS,I.APROC,I.ASUBC,' ');
      END IF;
    END LOOP;
  END P_CHECK_CPS;


  --驳回同时删除能力评估信息
  PROCEDURE P_REJECT_AND_DELETE_ABILITY_RECORD(V_FAID   IN VARCHAR2,
                                               V_COMPID IN VARCHAR2) IS
    V_FRID  VARCHAR2(32);
    EXE_SQL VARCHAR2(512);
  BEGIN
    SELECT MAX(FACTORY_REPORT_ID)
      INTO V_FRID
      FROM SCMDATA.T_FACTORY_REPORT
     WHERE FACTORY_ASK_ID = V_FAID
       AND COMPANY_ID = V_COMPID;

    IF V_FRID IS NOT NULL THEN
      EXE_SQL := 'DELETE FROM SCMDATA.T_FACTORY_REPORT_ABILITY WHERE FACTORY_REPORT_ID = :A AND COMPANY_ID = :B';
      EXECUTE IMMEDIATE EXE_SQL USING V_FRID, V_COMPID;
      EXE_SQL := 'UPDATE SCMDATA.T_FACTORY_REPORT SET CHECK_SAY = '' '', CHECK_RESULT = '' '', CHECK_REPORT_FILE = '' '' '||
                 ' WHERE FACTORY_REPORT_ID = :A AND COMPANY_ID = :B';
      EXECUTE IMMEDIATE EXE_SQL USING V_FRID, V_COMPID;
    END IF;
  END P_REJECT_AND_DELETE_ABILITY_RECORD;

END PKG_FACTORY_INSPECTION;
/

