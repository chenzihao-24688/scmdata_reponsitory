CREATE OR REPLACE PACKAGE SCMDATA.PKG_DYY_TEST IS

 /* PROCEDURE P_DEL_PROSCHE_BYPROCYCLE(V_SUPCODE IN VARCHAR2,
                                     V_CATE    IN VARCHAR2,
                                     V_PROCATE IN VARCHAR2,
                                     V_SUBCATE IN VARCHAR2,
                                     V_COMPID  IN VARCHAR2);

  PROCEDURE P_INS_PROSCHE_BYPROCYCLE(V_COMPID   IN VARCHAR2,
                                     V_CATE     IN VARCHAR2,
                                     V_PROCATE  IN VARCHAR2,
                                     V_SUBCATE  IN VARCHAR2,
                                     V_SUPCODE IN VARCHAR2 DEFAULT NULL,
                                     V_FIRSTD   IN NUMBER,
                                     V_ADDD     IN NUMBER,
                                     V_TRANSD   IN NUMBER);
   PROCEDURE P_UPD_PROSCHE_BYPROCYCLE(V_COMPID   IN VARCHAR2,
                                    V_CATE     IN VARCHAR2,
                                    V_PROCATE  IN VARCHAR2,
                                    V_SUBCATE  IN VARCHAR2,
                                    V_SUPCODE  IN VARCHAR2 DEFAULT NULL,
                                    V_FIRSTD   IN NUMBER,
                                    V_ADDD     IN NUMBER,
                                    V_TRANSD   IN NUMBER);

  PROCEDURE P_PROCYCLECFG_EFFLOGIC(V_QUEUEID   IN VARCHAR2,
                                   V_COMPID   IN VARCHAR2,
                                   V_COND     IN VARCHAR2,
                                   V_METHOD   IN VARCHAR2);

  PROCEDURE P_PROCYCLE_UPD_VIEWEFFLOGIC(V_COND     IN VARCHAR2,
                                        V_CATE     IN VARCHAR2,
                                        V_PROCATE  IN VARCHAR2,
                                        V_SUBCATE  IN VARCHAR2,
                                        V_SUPCODES IN VARCHAR2,
                                        V_FIRMD    IN NUMBER,
                                        V_ADDWD    IN NUMBER,
                                        V_PCTWD    IN NUMBER,
                                        V_UPDATEID IN VARCHAR2,
                                        V_UPDATIME IN VARCHAR2
                                        ) ;

    PROCEDURE P_PROCYCLE_INS_VIEWEFFLOGIC (V_PCCID    IN VARCHAR2,
                                           V_COMID    IN VARCHAR2,
                                           V_CATE     IN VARCHAR2,
                                           V_PROCATE  IN VARCHAR2,
                                           V_SUBCATE  IN VARCHAR2,
                                           V_SUPCODES IN VARCHAR2 DEFAULT NULL,
                                           V_FIRMD    IN NUMBER,
                                           V_ADDWD    IN NUMBER,
                                           V_PCTWD    IN NUMBER,
                                           V_CREID    IN VARCHAR2,
                                           V_CRETIME  IN VARCHAR2);

  PROCEDURE P_CAPAPLAN_CHANGE(V_CPCCID    IN VARCHAR2,
                              V_COMPID    IN VARCHAR2,
                              V_CURUSERID IN VARCHAR2,
                              V_CATE      IN VARCHAR2,
                              V_PROCATE   IN VARCHAR2,
                              V_SUBCATE   IN VARCHAR2,
                              V_INPLAN    IN NUMBER,
                              V_METHOD    IN VARCHAR2);

    PROCEDURE P_CATEPLANCFG_EFFLOGIC(V_QUEUEID  IN VARCHAR2,
                                     V_COMPID   IN VARCHAR2,
                                     V_COND     IN VARCHAR2,
                                     V_METHOD   IN VARCHAR2);

  PROCEDURE P_CATEPLAN_EFFLOGIC(V_COND    IN VARCHAR2,
                                V_CPCCID  IN VARCHAR2 DEFAULT NULL,
                                V_COMPID  IN VARCHAR2,
                                V_INPLAN  IN NUMBER   DEFAULT NULL,
                                V_CATE    IN VARCHAR2 DEFAULT NULL,
                                V_PROCATE IN VARCHAR2 DEFAULT NULL,
                                V_SUBCATE IN VARCHAR2 DEFAULT NULL,
                                V_METHOD  IN VARCHAR2,
                                V_CREID   IN VARCHAR2 DEFAULT NULL,
                                V_CRETIME IN VARCHAR2 DEFAULT NULL,
                                V_UPDID   IN VARCHAR2 DEFAULT NULL,
                                V_UPDTIME IN VARCHAR2 DEFAULT NULL);

  PROCEDURE P_CATEPLANCFG_DISABLE_EFFLEVELS(V_CATE    IN VARCHAR2,
                                            V_PROCATE IN VARCHAR2,
                                            V_SUBCATE IN VARCHAR2,
                                            V_COMPID  IN VARCHAR2,
                                            V_UPID    IN VARCHAR2,
                                            V_UPTIME  IN VARCHAR2);

  PROCEDURE P_CATEPLANCFG_ABLE_EFFLEVELS(V_CATE    IN VARCHAR2,
                                         V_PROCATE IN VARCHAR2,
                                         V_SUBCATE IN VARCHAR2,
                                         V_COMPID  IN VARCHAR2);


  PROCEDURE  P_GETDATA_KPIRT_MONTH ( V_METHOD  IN NUMBER,
                                    V_TYPE    IN NUMBER );*/

  FUNCTION F_RETURN_CAUSE_CATE_ANALYSIS(V_ORIGIN VARCHAR2,  --门店/仓库
                                   V_DUTY  VARCHAR2,  --全部责任部门/供应链
                                   V_DATE1 NUMBER,  --年
                                   V_DATE2 VARCHAR2,  --月/季/半年/年
                                   V_DATE3 NUMBER DEFAULT NULL,
                                   V_CATE  VARCHAR2,  --分部
                                   V_SELECT1 VARCHAR2, --产品子类/跟单/供应商/生产工厂/qc
                                   V_SELECT2 VARCHAR2 DEFAULT NULL,
                                   V_COMPID  VARCHAR2) RETURN CLOB;

 FUNCTION F_RETURN_CAUSE_QY_ANALYSIS(V_ORIGIN IN VARCHAR2,
                                     V_GROUP IN VARCHAR2,
                                     V_CATE   IN VARCHAR2,
                                     V_DUTY   IN VARCHAR2,
                                     V_DATE1  IN NUMBER,
                                     V_DATE2  IN VARCHAR2,
                                     V_DATE3  IN VARCHAR2 DEFAULT NULL,
                                     V_COMPID IN VARCHAR2) RETURN CLOB;
                                   
 FUNCTION F_UPD_RETURN(V_USERID IN VARCHAR2,
                       V_COMPID IN VARCHAR2) RETURN CLOB;
                       
  FUNCTION F_CHECK_APP_BUY(PI_COMPANY_ID      IN VARCHAR2,
                         PI_APPLY_ID        IN VARCHAR2,
                         PI_TYPE         IN NUMBER
                         ) RETURN VARCHAR2;                     
                       
 PROCEDURE P_APP_BUY_FOR_SUPP(PI_USER_ID      IN VARCHAR2,
                             PI_COMPANY_ID   IN VARCHAR2,
                             PI_TYPE         IN NUMBER,
                             PO_RESULT       OUT NUMBER,
                             PO_MESSAGE      OUT VARCHAR2);
  
 PROCEDURE P_register_company(pi_user_id     in varchar2,
                               pi_logo        in varchar,
                               pi_name        in varchar2,
                               pi_logn_name   in varchar2,
                               pi_LICENCE_NUM in varchar2,
                               pi_tips        in varchar2,
                               po_result      out number,
                               po_msg         out varchar2);                                                 

 FUNCTION f_getkeycode(pi_table_name  VARCHAR2, --表名
                        pi_column_name VARCHAR2, --列名
                        pi_pre         VARCHAR2, --前缀
                        pi_serail_num  NUMBER) RETURN VARCHAR2;
                        
FUNCTION f_query_material_detail(pi_material_id IN VARCHAR2,
                                 -- pi_supp_id     IN VARCHAR2,
                                  pi_type        IN VARCHAR2,
                                  pi_is_inner    IN VARCHAR2,
                                  --pi_comp_id     IN VARCHAR2,
                                  pi_supp_code   IN VARCHAR2) RETURN CLOB;  
PROCEDURE p_upd_suppstock(v_id IN VARCHAR2,
                          v_num IN NUMBER,
                          v_type IN VARCHAR2,--区分成品还是物料
                          V_mode IN VARCHAR2  --区分spu还是sku
                          );
                                                     
FUNCTION F_GET_CPSELECT_INVENTORY(PI_TYPE IN VARCHAR2) RETURN CLOB;

PROCEDURE P_REGISTER_MATERIALSUP(P_SUPCODE IN VARCHAR2);

PROCEDURE p_get_params(pi_source_id IN VARCHAR2,
                       pi_target_id IN VARCHAR2,
                       pi_key       IN VARCHAR2,
                       po_methods   OUT VARCHAR2,
                       po_param     OUT VARCHAR2);

END PKG_DYY_TEST;
/

CREATE OR REPLACE PACKAGE BODY SCMDATA.PKG_DYY_TEST IS


/*  \*=========================================================================
  删除下单规划（弃）






  ==========================================================================*\

 PROCEDURE P_DEL_PROSCHE_BYPROCYCLE(V_SUPCODE IN VARCHAR2,
                                    V_CATE    IN VARCHAR2,
                                    V_PROCATE IN VARCHAR2,
                                    V_SUBCATE IN VARCHAR2,
                                    V_COMPID  IN VARCHAR2) IS

   V_MINDATE DATE;

 BEGIN

   SELECT MIN(DD_DATE)
     INTO V_MINDATE
     FROM SCMDATA.T_DAY_DIM TAB
    WHERE EXISTS (SELECT 1
             FROM SCMDATA.T_DAY_DIM
            WHERE TRUNC(DD_DATE) = TRUNC(SYSDATE)
              AND YEARWEEK = TAB.YEARWEEK);

   --删除相关订单的生产排期数据
   FOR I IN (SELECT A.ORDER_CODE, A.COMPANY_ID
               FROM T_ORDERED A
              INNER JOIN T_ORDERS B
                 ON A.COMPANY_ID = B.COMPANY_ID
                AND A.ORDER_CODE = B.ORDER_ID
              INNER JOIN T_COMMODITY_INFO C
                 ON B.GOO_ID = C.GOO_ID
                AND C.COMPANY_ID = B.COMPANY_ID
              WHERE C.CATEGORY = V_CATE
                AND C.SAMLL_CATEGORY = V_SUBCATE
                AND C.PRODUCT_CATE = V_PROCATE
                AND B.FACTORY_CODE = V_SUPCODE) LOOP

     DELETE FROM SCMDATA.T_PRODUCTION_SCHEDULE
      WHERE ORDER_ID = I.ORDER_CODE
        AND COMPANY_ID = I.COMPANY_ID
        AND DAY >= V_MINDATE;
   END LOOP;

 --删除预计新品的生产排期数据
   FOR L IN (SELECT A.PN_ID, A.COMPANY_ID
               FROM SCMDATA.T_PLAN_NEWPRODUCT A
              WHERE A.CATEGORY = V_CATE
                AND A.PRODUCT_CATE = V_PROCATE
                AND A.SUBCATEGORY = V_SUBCATE
                AND A.SUPPLIER_CODE = V_SUPCODE
                AND A.COMPANY_ID = V_COMPID) LOOP

     DELETE FROM SCMDATA.T_PRODUCTION_SCHEDULE
      WHERE PN_ID = L.PN_ID
        AND COMPANY_ID = L.COMPANY_ID
        AND DAY >= V_MINDATE;

   END LOOP;

 END P_DEL_PROSCHE_BYPROCYCLE;

 \*=========================================================================
  修改生产排期后生产排期新增数据

    用途：
      修改生产排期后新增生产排期相关数据

    入参：
     V_COMPID     企业id
     V_CATE        分部
     V_PROCATE    生产类别
     V_SUBCATE    子类
     V_SUPCODE    供应商编码
     V_FIRSTD     首单待料天数
     V_ADDD       补单待料天数
     V_TRANSD     后整及物流天数

  ==========================================================================*\


   PROCEDURE P_INS_PROSCHE_BYPROCYCLE(V_COMPID   IN VARCHAR2,
                                      V_CATE     IN VARCHAR2,
                                      V_PROCATE  IN VARCHAR2,
                                      V_SUBCATE  IN VARCHAR2,
                                      V_SUPCODE IN VARCHAR2 DEFAULT NULL,
                                      V_FIRSTD   IN NUMBER,
                                      V_ADDD     IN NUMBER,
                                      V_TRANSD   IN NUMBER) IS

    V_INSDAYAMT     NUMBER;
    V_STARTDAY     DATE;
    V_ENDDAY       DATE;
    V_CALCDAYNUM   NUMBER;
    V_AVGAMOUNT    NUMBER;
      BEGIN

     FOR I IN (SELECT A.ORDER_CODE,
                     A.COMPANY_ID,
                     A.ISFIRSTORDERED,
                     A.CREATE_TIME,
                     A.DELIVERY_DATE,
                     B.ORDER_AMOUNT - B.GOT_AMOUNT CALCAMOUNT,
                     A.SUPPLIER_CODE,
                     B.FACTORY_CODE
                FROM (SELECT ORDER_CODE,
                             COMPANY_ID,
                             CREATE_TIME,
                             SUPPLIER_CODE,
                             DELIVERY_DATE,
                             ISFIRSTORDERED
                        FROM SCMDATA.T_ORDERED
                       WHERE COMPANY_ID = V_COMPID
                         AND ORDER_STATUS IN ('OS01', 'OS00')
                         AND DELIVERY_DATE BETWEEN SYSDATE AND
                             ADD_MONTHS(SYSDATE, 3)) A
               INNER JOIN SCMDATA.T_ORDERS B
                  ON A.ORDER_CODE = B.ORDER_ID
                 AND A.COMPANY_ID = B.COMPANY_ID
               INNER JOIN SCMDATA.T_COMMODITY_INFO C
                  ON B.GOO_ID = C.GOO_ID
                 AND C.COMPANY_ID = B.COMPANY_ID
               WHERE C.CATEGORY = V_CATE
                 AND C.PRODUCT_CATE = V_PROCATE
                 AND C.SAMLL_CATEGORY = V_SUBCATE
                 AND (B.FACTORY_CODE = V_SUPCODE OR V_SUPCODE IS NULL)
                 AND NOT EXISTS (SELECT 1
                        FROM SCMDATA.T_PRODUCTION_SCHEDULE
                       WHERE ORDER_ID = A.ORDER_CODE
                         AND COMPANY_ID = A.COMPANY_ID)
                 AND NOT EXISTS (SELECT 1
                        FROM SCMDATA.T_COOPCATE_SUPPLIER_CFG
                       WHERE SUPPLIER_CODE = A.SUPPLIER_CODE
                         AND COOP_CATEGORY = V_CATE
                         AND COOP_PRODUCTCATE = V_PROCATE
                         AND COOP_SUBCATEGORY = V_SUBCATE
                         AND PAUSE = 1)) LOOP

      IF I.ISFIRSTORDERED = 0 THEN
        V_STARTDAY := TRUNC(I.CREATE_TIME) + 1 + V_ADDD; --补单
      ELSE
        V_STARTDAY := TRUNC(I.CREATE_TIME) + 1 + V_FIRSTD; --首单
      END IF;

      V_ENDDAY     := TRUNC(I.DELIVERY_DATE) - V_TRANSD;
      V_CALCDAYNUM := TO_NUMBER(V_ENDDAY - V_STARTDAY) + 1;

      IF V_CALCDAYNUM <= 0 THEN
        V_CALCDAYNUM := 1;
        V_ENDDAY   := V_STARTDAY + 1;
      END IF;
      V_AVGAMOUNT := TRUNC(I.CALCAMOUNT / V_CALCDAYNUM); --平均日产量

      FOR E IN (SELECT DD_DATE
                  FROM SCMDATA.T_DAY_DIM
                 WHERE DD_DATE BETWEEN V_STARTDAY AND V_ENDDAY) LOOP

        IF E.DD_DATE <> V_ENDDAY AND V_CALCDAYNUM <> 1 THEN
          V_INSDAYAMT := V_AVGAMOUNT;
        ELSIF E.DD_DATE = V_ENDDAY AND V_CALCDAYNUM <> 1 THEN
          V_INSDAYAMT := I.CALCAMOUNT - (V_AVGAMOUNT * (V_CALCDAYNUM - 1));
        ELSIF V_CALCDAYNUM = 1 THEN
          V_INSDAYAMT := V_AVGAMOUNT;
        END IF;
        --插入生产排期表
        INSERT INTO SCMDATA.T_PRODUCTION_SCHEDULE
          (PS_ID, COMPANY_ID, ORDER_ID, DAY, PRODUCT_AMOUNT)
        VALUES
          (SCMDATA.F_GET_UUID(),
           I.COMPANY_ID,
           I.ORDER_CODE,
           E.DD_DATE,
           V_INSDAYAMT);
      END LOOP;
 END LOOP;
 END P_INS_PROSCHE_BYPROCYCLE;

  \*=========================================================================
  生产排期更新数据

    用途：
      配置修改后更新生产排期相关数据

    入参：
     V_COMPID     企业id
     V_CATE        分部
     V_PROCATE    生产类别
     V_SUBCATE    子类
     V_SUPCODE    供应商编码
     V_FIRSTD     首单待料天数
     V_ADDD       补单待料天数
     V_TRANSD     后整及物流天数

  ==========================================================================*\

 PROCEDURE P_UPD_PROSCHE_BYPROCYCLE(V_COMPID   IN VARCHAR2,
                                    V_CATE     IN VARCHAR2,
                                    V_PROCATE  IN VARCHAR2,
                                    V_SUBCATE  IN VARCHAR2,
                                    V_SUPCODE  IN VARCHAR2 DEFAULT NULL,
                                    V_FIRSTD   IN NUMBER,
                                    V_ADDD     IN NUMBER,
                                    V_TRANSD   IN NUMBER) IS
 V_MINDATE DATE;
 V_STARTDAY DATE;
 V_ENDDAY  DATE;
 V_CALCDAYNUM NUMBER;
 V_AVGAMOUNT  NUMBER;
 V_INSDAYAMT  NUMBER;
 V_DAYS    VARCHAR(2000);
 BEGIN

 SELECT MIN(DD_DATE)
     INTO V_MINDATE
     FROM SCMDATA.T_DAY_DIM TAB
    WHERE EXISTS (SELECT 1
             FROM SCMDATA.T_DAY_DIM
            WHERE TRUNC(DD_DATE) = TRUNC(SYSDATE)
              AND YEARWEEK = TAB.YEARWEEK);

    --找出生产排期中符合条件的订单

       FOR I IN (SELECT A.PS_ID,A.ORDER_ID,A.DAY,B.ISFIRSTORDERED,B.SUPPLIER_CODE,B.CREATE_TIME,B.DELIVERY_DATE,C.ORDER_AMOUNT - C.GOT_AMOUNT CALCAMOUNT,C.FACTORY_CODE
                   FROM SCMDATA.T_PRODUCTION_SCHEDULE A
                 INNER JOIN SCMDATA.T_ORDERED B ON B.ORDER_CODE=A.ORDER_ID AND A.COMPANY_ID=B.COMPANY_ID
                 INNER JOIN SCMDATA.T_ORDERS C ON C.ORDER_ID=A.ORDER_ID AND A.COMPANY_ID=C.COMPANY_ID
                 INNER JOIN SCMDATA.T_COMMODITY_INFO D ON D.GOO_ID=C.GOO_ID AND D.COMPANY_ID =C.COMPANY_ID
                 WHERE D.CATEGORY=V_CATE AND D.PRODUCT_CATE=V_PROCATE AND D.SAMLL_CATEGORY=V_SUBCATE
                 AND (C.FACTORY_CODE=V_SUPCODE OR V_SUPCODE IS NULL))LOOP



       SELECT LISTAGG(t.day,';') within GROUP (ORDER BY t.day) DAYS INTO V_DAYS   FROM SCMDATA.T_PRODUCTION_SCHEDULE T WHERE T.ORDER_ID = I.ORDER_ID AND T.COMPANY_ID=V_COMPID;


         IF I.ISFIRSTORDERED = 0 THEN
        V_STARTDAY := TRUNC(I.CREATE_TIME) + 1 + V_ADDD; --补单
      ELSE
        V_STARTDAY := TRUNC(I.CREATE_TIME) + 1 + V_FIRSTD; --首单
      END IF;

      V_ENDDAY     := TRUNC(I.DELIVERY_DATE) - V_TRANSD;
      V_CALCDAYNUM := TO_NUMBER(V_ENDDAY - V_STARTDAY) + 1;

      IF V_CALCDAYNUM <= 0 THEN
        V_CALCDAYNUM := 1;
        V_ENDDAY   := V_STARTDAY + 1;
      END IF;
      V_AVGAMOUNT := TRUNC(I.CALCAMOUNT / V_CALCDAYNUM); --平均日产量

      FOR E IN (SELECT DD_DATE
                  FROM SCMDATA.T_DAY_DIM
                 WHERE DD_DATE BETWEEN V_STARTDAY AND V_ENDDAY) LOOP

        IF E.DD_DATE <> V_ENDDAY AND V_CALCDAYNUM <> 1 THEN
          V_INSDAYAMT := V_AVGAMOUNT;
        ELSIF E.DD_DATE = V_ENDDAY AND V_CALCDAYNUM <> 1 THEN
          V_INSDAYAMT := I.CALCAMOUNT - (V_AVGAMOUNT * (V_CALCDAYNUM - 1));
        ELSIF V_CALCDAYNUM = 1 THEN
          V_INSDAYAMT := V_AVGAMOUNT;
        END IF;


      --如果日期相等，更新日产量
      IF E.DD_DATE = I.DAY THEN
        UPDATE SCMDATA.T_PRODUCTION_SCHEDULE T SET T.PRODUCT_AMOUNT = V_INSDAYAMT WHERE T.PS_ID = I.PS_ID AND COMPANY_ID =V_COMPID;

      --如果不存在则插入
      ELSIF INSTR (';'||V_DAYS||';', ';'||E.DD_DATE||';')=0 THEN
        INSERT INTO SCMDATA.T_PRODUCTION_SCHEDULE(ps_id,COMPANY_ID,ORDER_ID,DAY,PRODUCT_AMOUNT )
        VALUES(SCMDATA.F_GET_UUID(),V_COMPID,I.ORDER_ID,E.DD_DATE,V_INSDAYAMT);
      END IF;


      END LOOP;
   END LOOP;
 END;


  \*=================================================================

  生产周期生效

   用途：
      生产周期配置修改后相关表生效

   入参：
      V_QUEUEID   队列Id
      V_COMPID   企业id
      V_COND     唯一行条件
      V_METHOD   修改方式：INS-新增 UPD-修改 DEL-删除



  ==================================================================*\

  PROCEDURE P_PROCYCLECFG_EFFLOGIC(V_QUEUEID   IN VARCHAR2,
                                    V_COMPID   IN VARCHAR2,
                                    V_COND     IN VARCHAR2,
                                    V_METHOD   IN VARCHAR2) IS


    VC_PCCID         VARCHAR2(32);
    VC_COMPID        VARCHAR2(32);
    VC_CATE          VARCHAR2(32);
    VC_PROCATE       VARCHAR2(32);
    VC_SUBCATE       VARCHAR2(32);
    VC_SUPCODES      VARCHAR2(2000);
    VC_FIRDAY        VARCHAR2(32);
    VC_FIRD          NUMBER;
    VC_ADDDAY        VARCHAR2(32);
    VC_ADDD          NUMBER;
    VC_DELDAY        VARCHAR2(32);
    VC_DELD          NUMBER;
    VC_UPDATEID      VARCHAR2(32);
    VC_UPDATETIME    VARCHAR2(64);
    VC_CREATEID      VARCHAR2(32);
    VC_CREATETIME    VARCHAR2(64);
    --VC_DATE1         DATE;
    --VC_DATE2         DATE;
    V_MINDATE        DATE;
    V_SQL1           CLOB;
    V_SQL2           VARCHAR2(2000);
    TMP1  SCMDATA.T_PRODUCT_CYCLE_CFG%ROWTYPE;
    V1_CATE          VARCHAR2(32);
    V1_PROCATE       VARCHAR2(32);
    V1_SUBCATE       VARCHAR2(32);
    V1_SUPCOS        VARCHAR2(2000);
    V1_FIRSD         NUMBER;
    V1_ADDAY         NUMBER;
    V1_DELDAY        NUMBER;
  BEGIN

    SELECT MIN(DD_DATE)
      INTO V_MINDATE
      FROM SCMDATA.T_DAY_DIM TAB
     WHERE EXISTS (SELECT 1
              FROM SCMDATA.T_DAY_DIM
             WHERE DD_DATE = TRUNC(SYSDATE)
               AND YEARWEEK = TAB.YEARWEEK);

  SELECT MAX(CASE WHEN VC_COL ='PCC_ID' THEN VC_CURVAL END),
         MAX(CASE WHEN VC_COL ='COMPANY_ID' THEN VC_CURVAL END),
         MAX(CASE WHEN VC_COL ='CATEGORY' THEN VC_CURVAL END),
         MAX(CASE WHEN VC_COL ='PRODUCT_CATE' THEN VC_CURVAL END),
         MAX(CASE WHEN VC_COL ='SUBCATEGORY' THEN VC_CURVAL END),
         MAX(CASE WHEN VC_COL ='SUPPLIER_CODES' THEN VC_CURVAL END),
         MAX(CASE WHEN VC_COL ='FIRST_ORD_MAT_WAIT' THEN VC_CURVAL END),
         MAX(CASE WHEN VC_COL ='ADD_ORD_MAT_WAIT' THEN VC_CURVAL END),
         MAX(CASE WHEN VC_COL ='PC_AND_TRANS_WAIT' THEN VC_CURVAL END),
         MAX(CASE WHEN VC_COL ='UPDATE_ID' THEN VC_CURVAL END),
         MAX(CASE WHEN VC_COL ='UPDATE_TIME' THEN VC_CURVAL END),
         MAX(CASE WHEN VC_COL ='CREATE_ID' THEN VC_CURVAL END),
         MAX(CASE WHEN VC_COL ='CREATE_TIME' THEN VC_CURVAL END)
    INTO VC_PCCID, VC_COMPID,VC_CATE,VC_PROCATE,VC_SUBCATE,VC_SUPCODES,VC_FIRDAY,VC_ADDDAY,VC_DELDAY,VC_UPDATEID,
         VC_UPDATETIME, VC_CREATEID,VC_CREATETIME
     FROM SCMDATA.T_QUEUE_VALCHANGE
    WHERE QUEUE_ID = V_QUEUEID  AND COMPANY_ID = V_COMPID;

  VC_FIRD :=TO_NUMBER(VC_FIRDAY);  --首单待料天数
  VC_ADDD :=TO_NUMBER(VC_ADDDAY);  --补单待料天数
  VC_DELD :=TO_NUMBER(VC_DELDAY);  --后整天数

  --VC_DATE1 := TO_DATE(VC_UPDATETIME,'YYYY-MM-DD HH24:MI:SS');  --更新时间
 -- VC_DATE2 := TO_DATE(VC_CREATETIME,'YYYY-MM-DD HH24:MI:SS');  --创建时间

  IF V_METHOD = 'UPD'  THEN


     V_SQL1:='SELECT * FROM SCMDATA.T_PRODUCT_CYCLE_CFG WHERE '||V_COND;

      EXECUTE IMMEDIATE V_SQL1 INTO TMP1;

      --重算生产排期中的相关数据

       IF TMP1.SUPPLIER_CODES IS NOT NULL THEN
         FOR I IN (SELECT regexp_substr(TMP1.supplier_codes, '[^;]+',1,level) SUPPLIERC
                     FROM DUAL
                     CONNECT BY LEVEL <=(TMP1.supplier_codes)-length(replace(TMP1.supplier_codes,';',''))+1) LOOP

                 P_UPD_PROSCHE_BYPROCYCLE(V_COMPID   =>V_COMPID,
                                          V_CATE     =>TMP1.CATEGORY,
                                          V_PROCATE  =>TMP1.PRODUCT_CATE,
                                          V_SUBCATE  =>TMP1.SUBCATEGORY,
                                          V_SUPCODE  =>I.SUPPLIERC,
                                          V_FIRSTD   =>0,
                                          V_ADDD     =>0,
                                          V_TRANSD   =>0);



         END LOOP;
        ELSIF TMP1.SUPPLIER_CODES IS NULL THEN
                 P_UPD_PROSCHE_BYPROCYCLE(V_COMPID   =>V_COMPID,
                                          V_CATE     =>TMP1.CATEGORY,
                                          V_PROCATE  =>TMP1.PRODUCT_CATE,
                                          V_SUBCATE  =>TMP1.SUBCATEGORY,
                                         -- V_SUPCODE  =>I.SUPPLIERC,
                                          V_FIRSTD   =>0,
                                          V_ADDD     =>0,
                                          V_TRANSD   =>0);


       END IF;

        IF VC_CATE IS NULL THEN
          V1_CATE    := TMP1.CATEGORY;
          V1_PROCATE := TMP1.PRODUCT_CATE;
          V1_SUBCATE := TMP1.SUBCATEGORY;
        ELSE
            V1_CATE    := VC_CATE;
            V1_PROCATE := VC_PROCATE;
            V1_SUBCATE := VC_SUBCATE;
       END IF;

       IF VC_SUPCODES IS NULL THEN
         V1_SUPCOS := TMP1.SUPPLIER_CODES;

        ELSE
          V1_SUPCOS := VC_SUPCODES;
        END IF;

        IF  VC_FIRDAY IS  NULL THEN
          V1_FIRSD :=TMP1.FIRST_ORD_MAT_WAIT;
        ELSE
          V1_FIRSD :=VC_FIRDAY;
        END IF;

        IF VC_ADDDAY IS NULL THEN
          V1_ADDAY := TMP1.ADD_ORD_MAT_WAIT;
        ELSE
          V1_ADDAY := VC_ADDDAY;
        END IF;

        IF VC_DELDAY IS NULL THEN
          V1_DELDAY := TMP1.PC_AND_TRANS_WAIT;
        ELSE
          V1_DELDAY :=VC_DELDAY;
        END IF;

    P_PROCYCLE_UPD_VIEWEFFLOGIC(V_COND    => V_COND,
                               V_CATE     => VC_CATE,
                               V_PROCATE  => VC_PROCATE,
                               V_SUBCATE  => VC_SUBCATE,
                               V_SUPCODES => VC_SUPCODES,
                               V_FIRMD    => VC_FIRD,
                               V_ADDWD    => VC_ADDD,
                               V_PCTWD    => VC_DELD,
                               V_UPDATEID => VC_UPDATEID,
                               V_UPDATIME => VC_UPDATETIME
                                        );



         IF V1_SUPCOS IS NOT NULL THEN

         FOR J IN (SELECT   regexp_substr(V1_SUPCOS, '[^;]+',1,level) SUPPLIERC
                     FROM DUAL
                     CONNECT BY LEVEL <=(V1_SUPCOS)-length(replace(V1_SUPCOS,';',''))+1) LOOP

                  --重新生成生产排期相关数据
                  P_INS_PROSCHE_BYPROCYCLE(V_COMPID   => V_COMPID,
                                           V_CATE     => V1_CATE,
                                           V_PROCATE  => V1_PROCATE,
                                           V_SUBCATE  => V1_SUBCATE,
                                           V_SUPCODE  => J.SUPPLIERC,
                                           V_FIRSTD   => V1_FIRSD,
                                           V_ADDD     => V1_ADDAY,
                                           V_TRANSD   => V1_DELDAY);
             END LOOP;
           ELSIF V1_SUPCOS IS NULL THEN
                  P_INS_PROSCHE_BYPROCYCLE(V_COMPID   => V_COMPID,
                                           V_CATE     => V1_CATE,
                                           V_PROCATE  => V1_PROCATE,
                                           V_SUBCATE  => V1_SUBCATE,
                                           --V_SUPCODE  => J.SUPPLIERC,
                                           V_FIRSTD   => V1_FIRSD,
                                           V_ADDD     => V1_ADDAY,
                                           V_TRANSD   => V1_DELDAY);

         END IF;
   ELSIF V_METHOD ='INS' THEN

   --插入生产周期配置业务表
     P_PROCYCLE_INS_VIEWEFFLOGIC (V_PCCID    => VC_PCCID,
                                  V_COMID    => VC_COMPID,
                                  V_CATE     => VC_CATE,
                                  V_PROCATE  => VC_PROCATE,
                                  V_SUBCATE  => VC_SUBCATE,
                                  V_SUPCODES => VC_SUPCODES,
                                  V_FIRMD    => VC_FIRD,
                                  V_ADDWD    => VC_ADDD,
                                  V_PCTWD    => VC_DELD,
                                  V_CREID    => VC_CREATEID,
                                  V_CRETIME  => VC_CREATETIME);

   --新增生产排期相关数据
     P_INS_PROSCHE_BYPROCYCLE(V_COMPID   =>VC_COMPID,
                              V_CATE     =>VC_CATE,
                              V_PROCATE  =>VC_PROCATE,
                              V_SUBCATE  =>VC_SUBCATE,
                              V_SUPCODE  =>VC_SUPCODES,
                              V_FIRSTD   =>VC_FIRD,
                              V_ADDD     =>VC_ADDD,
                              V_TRANSD   =>VC_DELD);


   --新增周产能数据
     IF VC_SUPCODES IS NULL THEN
        FOR  C IN (SELECT SUPPLIER_CODE
                    FROM SCMDATA.T_COOPCATE_SUPPLIER_CFG A
                   WHERE A.COOP_CATEGORY= VC_CATE
                     AND A.COOP_PRODUCTCATE =VC_PROCATE
                     AND A.COOP_SUBCATEGORY=VC_SUBCATE
                     AND A.PAUSE = 0
                     AND A.COMPANY_ID = VC_COMPID) LOOP


      SCMDATA.PKG_CAPACITY_EFFLOGIC.P_IU_WEEKPLAN_DATA(V_SUPCODE   => C.SUPPLIER_CODE,
                                                                 V_CATE      => VC_CATE,
                                                                 V_PROCATE   =>VC_PROCATE,
                                                                 V_SUBCATE   =>VC_SUBCATE,
                                                                 V_OPERID    =>VC_UPDATEID,
                                                                 V_OPERTIME  =>VC_UPDATETIME,
                                                                 V_COMPID    => VC_COMPID);
          END LOOP;

      ELSIF  VC_SUPCODES IS NOT NULL THEN

        FOR D  IN (SELECT   regexp_substr(VC_SUPCODES, '[^;]+',1,level) SUPPLIERC
                     FROM DUAL
                     CONNECT BY LEVEL <=(VC_SUPCODES)-length(replace(VC_SUPCODES,';',''))+1) LOOP

         SCMDATA.PKG_CAPACITY_EFFLOGIC.P_IU_WEEKPLAN_DATA(V_SUPCODE   => D.SUPPLIERC,
                                                                 V_CATE      => VC_CATE,
                                                                 V_PROCATE   =>VC_PROCATE,
                                                                 V_SUBCATE   =>VC_SUBCATE,
                                                                 V_OPERID    =>VC_UPDATEID,
                                                                 V_OPERTIME  =>VC_UPDATETIME,
                                                                 V_COMPID    => VC_COMPID);

         END LOOP;

    END IF;

   ELSIF V_METHOD ='DEL' THEN

     --删除业务表
       V_SQL2 :='DELETE FROM SCMDATA.T_PRODUCT_CYCLE_CFG WHERE '||V_COND;
       EXECUTE IMMEDIATE V_SQL2;

       V_SQL2 :='SELECT MAX(category),max(product_cate),max(subcategory),max(supplier_codes)
                   FROM SCMDATA.T_PRODUCT_CYCLE_CFG_VIEW WHERE '||V_COND;

       EXECUTE IMMEDIATE V_SQL2 INTO V1_CATE,V1_PROCATE,V1_SUBCATE,V1_SUPCOS ;



       IF V1_SUPCOS IS NULL THEN
         --生产排期数据
                 P_UPD_PROSCHE_BYPROCYCLE(V_COMPID   =>V_COMPID,
                                          V_CATE     =>V1_CATE,
                                          V_PROCATE  =>V1_PROCATE,
                                          V_SUBCATE  =>V1_SUBCATE,
                                         -- V_SUPCODE  =>I.SUPPLIERC,
                                          V_FIRSTD   =>0,
                                          V_ADDD     =>0,
                                          V_TRANSD   =>0);
          --周产能数据
          FOR G IN (SELECT A.SUPPLIER_CODE, B.FACTORY_CODE
                      FROM SCMDATA.T_COOPCATE_SUPPLIER_CFG A
                     INNER JOIN SCMDATA.T_COOPCATE_FACTORY_CFG B ON A.csc_id =B.CSC_ID AND A.COMPANY_ID=B.COMPANY_ID
                   WHERE A.COOP_CATEGORY= V1_CATE
                     AND A.COOP_PRODUCTCATE =V1_PROCATE
                     AND A.COOP_SUBCATEGORY=V1_SUBCATE
                     AND A.PAUSE = 0
                     AND A.COMPANY_ID = V_COMPID) LOOP
              --先删除再重算
                SCMDATA.PKG_CAPACITY_EFFLOGIC.P_DELETE_WKPLANDATA(V_SUPCODE => G.SUPPLIER_CODE,
                                V_FACCODE  =>G.FACTORY_CODE,
                                V_CATE     => V1_CATE,
                                V_PROCATE  =>V1_PROCATE,
                                V_SUBCATE  =>V1_SUBCATE,
                                V_COMPID   => V_COMPID,
                                V_MINDATE  => V_MINDATE);
                SCMDATA.PKG_CAPACITY_EFFLOGIC.P_IU_WEEKPLAN_DATA(V_SUPCODE   => G.SUPPLIER_CODE,
                                                                 V_CATE      => V1_CATE,
                                                                 V_PROCATE   =>V1_PROCATE,
                                                                 V_SUBCATE   =>V1_SUBCATE,
                                                                 V_OPERID    =>VC_UPDATEID,
                                                                 V_OPERTIME  =>VC_UPDATETIME,
                                                                 V_COMPID    => V_COMPID);


              \*PKG_CAPACITY_MANAGEMENT.P_GEN_WEEKPLAN_DATA(V_SUPCODE =>G.SUPPLIER_CODE,
                                                          V_COMPID  =>V_COMPID);*\
             END LOOP;


       ELSIF V1_SUPCOS IS NOT NULL THEN


         --生产排期数据
         FOR A IN (SELECT regexp_substr(V1_SUPCOS, '[^;]+',1,level) SUPPLIERC
                     FROM DUAL
                     CONNECT BY LEVEL <=(V1_SUPCOS)-length(replace(V1_SUPCOS,';',''))+1) LOOP

                 P_UPD_PROSCHE_BYPROCYCLE(V_COMPID   =>V_COMPID,
                                          V_CATE     =>V1_CATE,
                                          V_PROCATE  =>V1_PROCATE,
                                          V_SUBCATE  =>V1_SUBCATE,
                                          V_SUPCODE  =>A.SUPPLIERC,
                                          V_FIRSTD   =>0,
                                          V_ADDD     =>0,
                                          V_TRANSD   =>0);
       --周产能数据
              SCMDATA.PKG_CAPACITY_EFFLOGIC.P_DELETE_WKPLANDATA(V_SUPCODE =>A.SUPPLIERC,
                                V_FACCODE  =>A.SUPPLIERC,
                                V_CATE     => V1_CATE,
                                V_PROCATE  =>V1_PROCATE,
                                V_SUBCATE  =>V1_SUBCATE,
                                V_COMPID   => V_COMPID,
                                V_MINDATE  => V_MINDATE);

              SCMDATA.PKG_CAPACITY_EFFLOGIC.P_IU_WEEKPLAN_DATA(V_SUPCODE   => A.SUPPLIERC,
                                                                 V_CATE      => V1_CATE,
                                                                 V_PROCATE   =>V1_PROCATE,
                                                                 V_SUBCATE   =>V1_SUBCATE,
                                                                 V_OPERID    =>VC_UPDATEID,
                                                                 V_OPERTIME  =>VC_UPDATETIME,
                                                                 V_COMPID    => V_COMPID);


          END LOOP;
         END IF;

  END IF;



  END P_PROCYCLECFG_EFFLOGIC;
    \*=================================================================

  生产周期view表生效

   用途：
      生产周期配置修改后view表生效到主表

   入参：
      V_COND      唯一列
      V_CATE      分部
      V_PROCATE   生产类别
      V_SUBCATE   子类
      V_SUPCODES  供应商编码
      V_FIRMD     首单待料天数
      V_ADDWD     补单待料天数
      V_PCTWD     后整及物流天数
      V_UPDATEID  修改人id
      V_UPDATIME  修改时间

  ==================================================================*\

  PROCEDURE P_PROCYCLE_UPD_VIEWEFFLOGIC(V_COND     IN VARCHAR2,
                                        V_CATE     IN VARCHAR2,
                                        V_PROCATE  IN VARCHAR2,
                                        V_SUBCATE  IN VARCHAR2,
                                        V_SUPCODES IN VARCHAR2,
                                        V_FIRMD    IN NUMBER,
                                        V_ADDWD    IN NUMBER,
                                        V_PCTWD    IN NUMBER,
                                        V_UPDATEID IN VARCHAR2,
                                        V_UPDATIME IN VARCHAR2
                                        ) IS

  V_SQL CLOB;

  BEGIN

    V_SQL := 'SCMDATA.T_PRODUCT_CYCLE_CFG SET';

    IF V_CATE IS NOT NULL THEN
      V_SQL := V_SQL||'CATEGORY ='''||V_CATE||''', PRODUCT_CATE ='''||V_PROCATE||''', SUBCATEGORY ='''||V_SUBCATE||'''';
    END IF;

    IF V_SUPCODES IS NOT NULL THEN
      V_SQL := V_SQL||'SUPPLIER_CODES ='''||V_SUPCODES||'''';
    END IF;

    IF V_FIRMD IS NOT NULL THEN
      V_SQL := V_SQL||'FIRST_ORD_MAT_WAIT = '||V_FIRMD;
    END IF;

    IF V_ADDWD IS NOT NULL THEN
      V_SQL := V_SQL||'ADD_ORD_MAT_WAIT ='||V_ADDWD;
    END IF;

    IF V_PCTWD IS NOT NULL THEN
      V_SQL := V_SQL||'PC_AND_TRANS_WAIT = '||V_PCTWD;
    END IF;

    V_SQL :=V_SQL||',UPDATE_ID ='''||V_UPDATEID||''', UPDATE_TIME =TO_DATE('''||V_UPDATIME||''',''YYYY-MM-DD HH24-MI-SS'') WHERE
              '||V_COND;

    EXECUTE IMMEDIATE V_SQL;

    END P_PROCYCLE_UPD_VIEWEFFLOGIC;


    \*=================================================================

  生产周期view表生效

   用途：
      生产周期配置新增后view表生效到主表

   入参：
      V_PCCID     主键
      V_COND      唯一列
      V_CATE      分部
      V_PROCATE   生产类别
      V_SUBCATE   子类
      V_SUPCODES  供应商编码
      V_FIRMD     首单待料天数
      V_ADDWD     补单待料天数
      V_PCTWD     后整及物流天数
      V_CREID     创建人id
      V_CRETIME   创建时间

  ==================================================================*\

  PROCEDURE P_PROCYCLE_INS_VIEWEFFLOGIC (V_PCCID    IN VARCHAR2,
                                         V_COMID    IN VARCHAR2,
                                         V_CATE     IN VARCHAR2,
                                         V_PROCATE  IN VARCHAR2,
                                         V_SUBCATE  IN VARCHAR2,
                                         V_SUPCODES IN VARCHAR2 DEFAULT NULL,
                                         V_FIRMD    IN NUMBER,
                                         V_ADDWD    IN NUMBER,
                                         V_PCTWD    IN NUMBER,
                                         V_CREID    IN VARCHAR2,
                                         V_CRETIME  IN VARCHAR2) IS

    V_SQL    CLOB;
    V_COLS   VARCHAR2(2000) :='PCC_ID,COMPANY_ID';
    V_VALUES VARCHAR2(2000):=''''||V_PCCID||''','''||V_COMID||'''';

    BEGIN

      IF v_cate IS NOT NULL THEN

        V_COLS  :=V_COLS||',CATEGORY,PRODUCT_CATE,SUBCATEGORY';
        V_VALUES:=V_VALUES||','''||V_CATE||''','''||V_PROCATE||''','''||V_SUBCATE||'''';

      END IF;

      IF V_SUPCODES IS NOT NULL THEN

        V_COLS   :=V_COLS||', SUPPLIER_CODES ';
        V_VALUES :=V_VALUES||','''||V_SUPCODES||'''';

       END IF;

       IF  V_FIRMD IS NOT NULL THEN

         V_COLS   :=V_COLS||',FIRST_ORD_MAT_WAIT,ADD_ORD_MAT_WAIT,PC_AND_TRANS_WAIT';
         V_VALUES :=V_VALUES||','||V_FIRMD||','||V_ADDWD||','||V_PCTWD;

        END IF;

        V_COLS:=V_COLS||',CREATE_ID,CREATE_TIME';
        V_VALUES :=V_VALUES||','''||V_CREID||''',to_date('''||V_CRETIME||''',''YYYY-MM-DD HH24-MI-SS'')';

        V_SQL:='INSERT INTO SCMDATA.T_PRODUCT_CYCLE_CFG('||V_COLS||') VALUES('||V_VALUES||')';

        EXECUTE IMMEDIATE V_SQL;

      END P_PROCYCLE_INS_VIEWEFFLOGIC;

  \*====================================================================





  =====================================================================*\

  \*PROCEDURE P_PROCYCLE_EFFLOGIC(V_COND      IN VARCHAR2,
                                V_COMPID    IN VARCHAR2,
                                V_CATE      IN VARCHAR2 DEFAULT NULL,
                                V_PROCATE   IN VARCHAR2 DEFAULT NULL,
                                V_SUBCATE   IN VARCHAR2 DEFAULT NULL,
                                V_SUPID     IN VARCHAR2 DEFAULT NULL,
                                V_FIRDAY    IN NUMBER   DEFAULT NULL,
                                V_ADDDAY    IN NUMBER   DEFAULT NULL,
                                V_DELDAY    IN NUMBER   DEFAULT NULL,
                                V_OPTUSERID IN VARCHAR2,
                                V_OPTDAY    IN DATE,
                                V_METHOD    IN VARCHAR2 ) IS


     TMP1   SCMDATA.T_PRODUCT_CYCLE_CFG%ROWTYPE;
    V_SQL  CLOB;
    V_SQL2 CLOB;

  BEGIN

    V_SQL2 := 'SELECT *
                 FROM SCMDATA.T_PRODUCT_CYCLE_CFG
                WHERE ' || V_COND;

      EXECUTE IMMEDIATE V_SQL2
        INTO TMP1;


    IF V_METHOD ='UPD'   THEN


      V_SQL :='UPDATE SCMDATA.T_PRODUCT_CYCLE_CFG A
                  SET UPDATE_ID ='''||V_OPTUSERID||''',
                      UPDATE_TIME ='''||V_OPTDAY||'''';



    --删除旧数据 重算

  END IF;
  END;*\
 \*===================================================================
 品类配置



 =====================================================================*\
  PROCEDURE P_CAPAPLAN_CHANGE(V_CPCCID    IN VARCHAR2,
                              V_COMPID    IN VARCHAR2,
                              V_CURUSERID IN VARCHAR2,
                              V_CATE      IN VARCHAR2,
                              V_PROCATE   IN VARCHAR2,
                              V_SUBCATE   IN VARCHAR2,
                              V_INPLAN    IN NUMBER,
                              V_METHOD    IN VARCHAR2) IS
    V_JUDNUM NUMBER(1);
  BEGIN
    IF V_METHOD = 'INS' THEN
      INSERT INTO SCMDATA.T_CAPAPLAN_CATE_CFG_VIEW
        (CPCCV_ID,
         COMPANY_ID,
         CPCC_ID,
         CATEGORY,
         PRODUCT_CATE,
         SUBCATEGORY,
         IN_PLANNING,
         OPERATE_ID,
         OPERATE_TIME,
         OPERATE_METHOD)
      VALUES
        (SCMDATA.F_GET_UUID(),
         V_COMPID,
         V_CPCCID,
         V_CATE,
         V_PROCATE,
         V_SUBCATE,
         V_INPLAN,
         V_CURUSERID,
         SYSDATE,
         V_METHOD);
    ELSE
     \* FOR I IN (SELECT *
                  FROM SCMDATA.T_CAPACITY_PLAN_CATEGORY_CFG
                 WHERE CPCC_ID = V_CPCCID
                   AND COMPANY_ID = V_COMPID) LOOP*\
        SELECT COUNT(1)
          INTO V_JUDNUM
          FROM SCMDATA.T_CAPAPLAN_CATE_CFG_VIEW
         WHERE CPCC_ID = V_CPCCID
           AND COMPANY_ID = V_COMPID
           AND ROWNUM = 1;

        IF V_JUDNUM = 0 THEN
          INSERT INTO SCMDATA.T_CAPAPLAN_CATE_CFG_VIEW
            (CPCCV_ID,
             COMPANY_ID,
             CPCC_ID,
             CATEGORY,
             PRODUCT_CATE,
             SUBCATEGORY,
             IN_PLANNING,
             OPERATE_ID,
             OPERATE_TIME,
             OPERATE_METHOD)
          VALUES
            (SCMDATA.F_GET_UUID(),
             V_COMPID,
             V_CPCCID,
             V_CATE,
             V_PROCATE,
             V_SUBCATE,
             V_INPLAN,
             V_CURUSERID,
             SYSDATE,
             V_METHOD);
        ELSE
          UPDATE SCMDATA.T_CAPAPLAN_CATE_CFG_VIEW
             SET CATEGORY       = V_CATE,
                 PRODUCT_CATE   = V_PROCATE,
                 SUBCATEGORY    = V_SUBCATE,
                 IN_PLANNING    = V_INPLAN,
                 OPERATE_ID     = V_CURUSERID,
                 OPERATE_TIME   = SYSDATE,
                 OPERATE_METHOD = V_METHOD
           WHERE CPCC_ID = V_CPCCID
             AND COMPANY_ID = V_COMPID;
        END IF;
     -- END LOOP;
    END IF;
  END P_CAPAPLAN_CHANGE;

  \*============================================================

   品类产能配置发生修改后生效逻辑

   用途：
       品类产能配置发生修改时生效逻辑

   入参：
        V_QUEUEID      :  队列Id
        V_COMPID       :  企业Id


  =============================================================*\
  PROCEDURE P_CATEPLANCFG_EFFLOGIC(V_QUEUEID  IN VARCHAR2,
                                   V_COMPID   IN VARCHAR2,
                                   V_COND     IN VARCHAR2,
                                   V_METHOD   IN VARCHAR2) IS
    V_VCCPCCID  VARCHAR2(32);
    V_VCCOMID   VARCHAR2(32);
    V_VCCATE    VARCHAR2(128);
    V_VCNUM     NUMBER(16);
    V_VCPROCATE VARCHAR2(128);
    V_VCSUBCATE VARCHAR2(128);
    V_VCINPLAN VARCHAR2(128);
    --V_VCDATE1   DATE;  --创建时间
    --V_VCDATE2   DATE;  --更新时间
    V_CREATEID   VARCHAR2(32);
    V_CREATETIME VARCHAR2(64);
    V_UPDATEID   VARCHAR2(32);
    V_UPDATETIME   VARCHAR2(64);
  BEGIN

    SELECT MAX(CASE WHEN VC_COL ='CPCC_ID' THEN VC_CURVAL END),
           MAX(CASE WHEN VC_COL ='COMPANY_ID' THEN VC_CURVAL END),
           MAX(CASE WHEN VC_COL ='CATEGORY' THEN VC_CURVAL END),
           MAX(CASE WHEN VC_COL ='PRODUCT_CATE' THEN VC_CURVAL END),
           MAX(CASE WHEN VC_COL ='SUBCATEGORY' THEN VC_CURVAL END),
           MAX(CASE WHEN VC_COL ='IN_PLANNING' THEN VC_CURVAL END),
           MAX(CASE WHEN VC_COL ='CREATE_ID' THEN VC_CURVAL END),
           MAX(CASE WHEN VC_COL ='CREATE_TIME' THEN VC_CURVAL END),
           MAX(CASE WHEN VC_COL ='UPDATE_ID' THEN VC_CURVAL END),
           MAX(CASE WHEN VC_COL ='UPDATE_TIME' THEN VC_CURVAL END)
      INTO  V_VCCPCCID, V_VCCOMID,V_VCCATE,V_VCPROCATE,V_VCSUBCATE,V_VCINPLAN,V_CREATEID,V_CREATETIME,V_UPDATEID,V_UPDATETIME
      FROM SCMDATA.T_QUEUE_VALCHANGE
     WHERE QUEUE_ID = V_QUEUEID
       AND COMPANY_ID = V_COMPID;


      V_VCNUM   := TO_NUMBER(V_VCINPLAN);
      --V_VCDATE1 := TO_DATE(V_CREATETIME, 'YYYY-MM-DD HH24:MI:SS');
      -- := TO_DATE(V_UPDATETIME, 'YYYY-MM-DD HH24:MI:SS');

      --生效逻辑
      P_CATEPLAN_EFFLOGIC(V_COND    => V_COND,
                          V_CPCCID  => V_VCCPCCID,
                          V_COMPID  => V_COMPID,
                          V_INPLAN  => V_VCNUM,
                          V_CATE    => V_VCCATE,
                          V_PROCATE => V_VCPROCATE,
                          V_SUBCATE => V_VCSUBCATE,
                          V_METHOD  => V_METHOD,
                          V_CREID   => V_CREATEID,
                          V_CRETIME => V_CREATETIME,
                          V_UPDID   => V_UPDATEID,
                          V_UPDTIME => V_UPDATETIME);


  END P_CATEPLANCFG_EFFLOGIC;

  \*=====================================================================

    品类产能配置层级生效逻辑

    用途：
      品类产能配置层级生效逻辑

    入参：
        V_COND      唯一条件
        V_COMPID    企业id
        V_INPLAN    启/停
        V_CATE      分部
        V_PROCATE   生产类别
        V_SUBCATE   子类
        V_METHOD    方式，INS-新增，UPD-更新，DEL-删除
        V_USERID    操作人id
        V_OPTIME    操作时间


  =======================================================================*\

  PROCEDURE P_CATEPLAN_EFFLOGIC(V_COND    IN VARCHAR2,
                                V_CPCCID  IN VARCHAR2 DEFAULT NULL,
                                V_COMPID  IN VARCHAR2,
                                V_INPLAN  IN NUMBER   DEFAULT NULL,
                                V_CATE    IN VARCHAR2 DEFAULT NULL,
                                V_PROCATE IN VARCHAR2 DEFAULT NULL,
                                V_SUBCATE IN VARCHAR2 DEFAULT NULL,
                                V_METHOD  IN VARCHAR2,
                                V_CREID   IN VARCHAR2 DEFAULT NULL,
                                V_CRETIME IN VARCHAR2 DEFAULT NULL,
                                V_UPDID   IN VARCHAR2 DEFAULT NULL,
                                V_UPDTIME IN VARCHAR2 DEFAULT NULL) IS

    TMP1   SCMDATA.T_CAPACITY_PLAN_CATEGORY_CFG%ROWTYPE;
    V_SQL  VARCHAR2(3000);
    V_SQL2 CLOB;
  BEGIN

      V_SQL2 := 'SELECT *
                 FROM SCMDATA.T_CAPACITY_PLAN_CATEGORY_CFG
                WHERE ' || V_COND;

      EXECUTE IMMEDIATE V_SQL2  INTO TMP1;

    IF V_METHOD = 'UPD' AND V_SUBCATE IS NULL AND V_INPLAN IS NOT NULL THEN

      IF V_INPLAN = 0 THEN
        P_CATEPLANCFG_DISABLE_EFFLEVELS(V_CATE    => TMP1.CATEGORY,
                                        V_PROCATE => TMP1.PRODUCT_CATE,
                                        V_SUBCATE => TMP1.SUBCATEGORY,
                                        V_COMPID  => V_COMPID,
                                        V_UPID    => V_UPDID,
                                        V_UPTIME  => V_UPDTIME);
      ELSIF V_INPLAN = 1 THEN
        P_CATEPLANCFG_ABLE_EFFLEVELS(V_CATE    => TMP1.CATEGORY,
                                     V_PROCATE => TMP1.PRODUCT_CATE,
                                     V_SUBCATE => TMP1.SUBCATEGORY,
                                     V_COMPID  => V_COMPID);

        END IF;
        V_SQL := 'UPDATE SCMDATA.T_CAPACITY_PLAN_CATEGORY_CFG A
                      SET A.IN_PLANNING ='||V_INPLAN||',   A.UPDATE_ID ='''||V_UPDID||''',  A.UPDATE_TIME =TO_DATE('''||V_UPDTIME||
                ''',''YYYY-MM-DD HH24-MI-SS'')  WHERE '||V_COND;


      ELSIF V_METHOD = 'UPD' AND V_SUBCATE IS NOT NULL  AND V_INPLAN IS NULL THEN

        V_SQL := 'UPDATE SCMDATA.T_CAPACITY_PLAN_CATEGORY_CFG A
            SET A.CATEGORY = ''' || V_CATE || ''',     A.PRODUCT_CATE = ''' || V_PROCATE || ''',  A.SUBCATEGORY = ''' || V_SUBCATE || ''',  A.UPDATE_ID = ''' || V_UPDID || ''',
                A.UPDATE_TIME =TO_DATE('''||V_UPDTIME||
                ''',''YYYY-MM-DD HH24-MI-SS'') WHERE ' ||   V_COND;

          IF TMP1.IN_PLANNING  = 1 THEN
                P_CATEPLANCFG_ABLE_EFFLEVELS(V_CATE    => V_CATE,
                                             V_PROCATE => V_PROCATE,
                                             V_SUBCATE => V_SUBCATE,
                                             V_COMPID  => V_COMPID);

          ELSIF TMP1.IN_PLANNING =0 THEN
                 P_CATEPLANCFG_DISABLE_EFFLEVELS(V_CATE    => V_CATE,
                                                 V_PROCATE => V_PROCATE,
                                                 V_SUBCATE => V_SUBCATE,
                                                 V_COMPID  => V_COMPID,
                                                 V_UPID    => V_UPDID,
                                                 V_UPTIME  => V_UPDTIME);

          END IF ;


      ELSIF V_METHOD = 'UPD' AND V_SUBCATE IS NOT NULL AND V_INPLAN IS NOT NULL THEN

        V_SQL := 'UPDATE SCMDATA.T_CAPACITY_PLAN_CATEGORY_CFG A
            SET A.IN_PLANNING =' || V_INPLAN || ',   A.CATEGORY = ''' || V_CATE || ''',
                A.PRODUCT_CATE = ''' || V_PROCATE || ''', A.SUBCATEGORY = ''' || V_SUBCATE || ''',  A.UPDATE_ID = ''' || V_UPDID || ''',
                A.UPDATE_TIME =TO_DATE('''||V_UPDTIME||
                ''',''YYYY-MM-DD HH24-MI-SS'') WHERE  ' ||   V_COND;
      --删除原先的数据
      P_CATEPLANCFG_DISABLE_EFFLEVELS(V_CATE    => TMP1.CATEGORY,
                                      V_PROCATE => TMP1.PRODUCT_CATE,
                                      V_SUBCATE => TMP1.SUBCATEGORY,
                                      V_COMPID  => TMP1.COMPANY_ID,
                                      V_UPID    => V_UPDID,
                                      V_UPTIME  => V_UPDTIME);




    IF V_INPLAN = 1 THEN

      P_CATEPLANCFG_ABLE_EFFLEVELS(V_CATE    => V_CATE,
                                   V_PROCATE => V_PROCATE,
                                   V_SUBCATE => V_SUBCATE,
                                   V_COMPID  => V_COMPID);


          ELSIF V_INPLAN = 0 THEN
            P_CATEPLANCFG_DISABLE_EFFLEVELS(V_CATE    => V_CATE,
                                            V_PROCATE => V_PROCATE,
                                            V_SUBCATE => V_SUBCATE,
                                            V_COMPID  => V_COMPID,
                                            V_UPID    => V_UPDID,
                                            V_UPTIME  => V_UPDTIME);
           END IF;




       --END IF;



    ELSIF V_METHOD = 'INS' THEN
      INSERT INTO SCMDATA.T_CAPACITY_PLAN_CATEGORY_CFG
        (CPCC_ID,
         COMPANY_ID,
         CATEGORY,
         PRODUCT_CATE,
         SUBCATEGORY,
         IN_PLANNING,
         CREATE_ID,
         CREATE_TIME)
      VALUES
        (V_CPCCID,
         V_COMPID,
         V_CATE,
         V_PROCATE,
         V_SUBCATE,
         V_INPLAN,
         V_CREID,
         to_date(V_CRETIME,'YYYY-MM-DD HH24-MI-SS'));

        IF V_INPLAN = 1 THEN

      P_CATEPLANCFG_ABLE_EFFLEVELS(V_CATE    => V_CATE,
                                   V_PROCATE => V_PROCATE,
                                   V_SUBCATE => V_SUBCATE,
                                   V_COMPID  => V_COMPID);


          ELSIF V_INPLAN = 0 THEN
            P_CATEPLANCFG_DISABLE_EFFLEVELS(V_CATE    => V_CATE,
                                                 V_PROCATE => V_PROCATE,
                                                 V_SUBCATE => V_SUBCATE,
                                                 V_COMPID  => V_COMPID,
                                                 V_UPID    => V_UPDID,
                                                 V_UPTIME  => V_UPDTIME);
           END IF;

    ELSIF V_METHOD = 'DEL' THEN

      V_SQL := 'DELETE FROM SCMDATA.T_CAPACITY_PLAN_CATEGORY_CFG A WHERE ' ||  V_COND;
     -- EXECUTE IMMEDIATE V_SQL;

      P_CATEPLANCFG_DISABLE_EFFLEVELS(V_CATE    => V_CATE,
                                      V_PROCATE => V_PROCATE,
                                      V_SUBCATE => V_SUBCATE,
                                      V_COMPID  => V_COMPID,
                                      V_UPID    => V_UPDID,
                                      V_UPTIME  => V_UPDTIME);

    END IF;

   execute immediate V_SQL;

  END P_CATEPLAN_EFFLOGIC;

  \*=====================================================================

   品类产能配置删除相关数据

      用途：品类配置发生删除/修改时，生产排期、周产能规划删除相关数据

      入参：
        V_CATE       分部
        V_PROCATE    生产类别
        V_SUBCATE    子类
        V_COMPID     企业id



  =======================================================================*\

  PROCEDURE P_CATEPLANCFG_DISABLE_EFFLEVELS(V_CATE    IN VARCHAR2,
                                            V_PROCATE IN VARCHAR2,
                                            V_SUBCATE IN VARCHAR2,
                                            V_COMPID  IN VARCHAR2,
                                            V_UPID    IN VARCHAR2,
                                            V_UPTIME  IN VARCHAR2
                                            ) IS
    V_MINDATE DATE;

  BEGIN
    SELECT MIN(DD_DATE)
      INTO V_MINDATE
      FROM SCMDATA.T_DAY_DIM TAB
     WHERE EXISTS (SELECT 1
              FROM SCMDATA.T_DAY_DIM
             WHERE DD_DATE = TRUNC(SYSDATE)
               AND YEARWEEK = TAB.YEARWEEK);

    ---下单规划相关数据删除
    FOR I IN (SELECT A.PS_ID, A.COMPANY_ID, C.FACTORY_CODE SUPPLIER_CODE
                FROM SCMDATA.T_PRODUCTION_SCHEDULE A
               INNER JOIN SCMDATA.T_ORDERED B
                  ON A.ORDER_ID = B.ORDER_CODE
                 AND A.COMPANY_ID = B.COMPANY_ID
               INNER JOIN SCMDATA.T_ORDERS C
                  ON B.ORDER_CODE = C.ORDER_ID
                 AND B.COMPANY_ID = C.COMPANY_ID
               INNER JOIN SCMDATA.T_COMMODITY_INFO D
                  ON C.GOO_ID = D.GOO_ID
                 AND D.COMPANY_ID = C.COMPANY_ID
               WHERE D.CATEGORY = V_CATE
                 AND D.PRODUCT_CATE = V_PROCATE
                 AND D.SAMLL_CATEGORY = V_SUBCATE
                 AND A.COMPANY_ID = V_COMPID
                 AND A.DAY > = V_MINDATE
                 AND EXISTS
               (SELECT 1
                        FROM SCMDATA.T_COOPCATE_SUPPLIER_CFG T
                       WHERE T.PAUSE = 0
                         AND T.SUPPLIER_CODE = B.SUPPLIER_CODE
                         AND T.COOP_CATEGORY = V_CATE
                         AND T.COOP_PRODUCTCATE = V_PROCATE
                         AND T.COOP_SUBCATEGORY = V_SUBCATE)
              UNION ALL
              SELECT A.PS_ID, A.COMPANY_ID, E.SUPPLIER_CODE
                FROM SCMDATA.T_PRODUCTION_SCHEDULE A
               INNER JOIN SCMDATA.T_PLAN_NEWPRODUCT E
                  ON A.PN_ID = E.PN_ID
                 AND A.COMPANY_ID = E.COMPANY_ID
               WHERE E.CATEGORY = V_CATE
                 AND E.PRODUCT_CATE = V_PROCATE
                 AND E.SUBCATEGORY = V_SUBCATE
                 AND A.COMPANY_ID = V_COMPID
                 AND A.DAY >= V_MINDATE
                 AND EXISTS
               (SELECT 1
                        FROM SCMDATA.T_COOPCATE_SUPPLIER_CFG T
                       WHERE T.PAUSE = 0
                         AND T.SUPPLIER_CODE = E.SUPPLIER_CODE
                         AND T.COOP_CATEGORY = V_CATE
                         AND T.COOP_PRODUCTCATE = V_PROCATE
                         AND T.COOP_SUBCATEGORY = V_SUBCATE)) LOOP
      DELETE FROM SCMDATA.T_PRODUCTION_SCHEDULE
       WHERE PS_ID = I.PS_ID
         AND COMPANY_ID = I.COMPANY_ID;
    END LOOP;

    ---周产能规划相关数据删除

    FOR C IN (SELECT a.supplier_code,b.factory_code
                FROM SCMDATA.T_COOPCATE_SUPPLIER_CFG a
                INNER JOIN SCMDATA.T_COOPCATE_FACTORY_CFG b ON a.csc_id = b.csc_id AND a.company_id=b.company_id
                WHERE a.pause=0 AND b.pause=0 AND A.COOP_CATEGORY = V_CATE
                                              AND A.COOP_PRODUCTCATE = V_PROCATE
                                              AND A.COOP_SUBCATEGORY = V_SUBCATE
                                              AND a.company_id=V_COMPID) LOOP
        SCMDATA.PKG_CAPACITY_EFFLOGIC.P_DELETE_WKPLANDATA(V_SUPCODE  =>C.SUPPLIER_CODE,
                                                          V_FACCODE  =>C.FACTORY_CODE,
                                                          V_CATE     =>V_CATE,
                                                          V_PROCATE  =>V_PROCATE,
                                                          V_SUBCATE  =>V_SUBCATE,
                                                          V_COMPID   =>V_COMPID,
                                                          V_MINDATE  =>V_MINDATE);





   --重算周产能
         SCMDATA.PKG_CAPACITY_EFFLOGIC.P_IU_WEEKPLAN_DATA(V_SUPCODE   =>c.supplier_code,
                                                          V_CATE      =>V_CATE,
                                                          V_PROCATE   =>V_PROCATE,
                                                          V_SUBCATE   =>V_SUBCATE,
                                                          V_OPERID    =>V_UPID,
                                                          V_OPERTIME  =>V_UPTIME,
                                                          V_COMPID    =>V_COMPID) ;



    END LOOP;

    \* FOR L IN (SELECT DISTINCT CWP_ID, COMPANY_ID
                FROM SCMDATA.T_CATEWEEKPLAN_CATE_DETAIL
               WHERE CATEGORY      = V_CATE
                 AND PRODUCT_CATE = V_PROCATE
                 AND SUBCATEGORY  = V_SUBCATE
                 AND DAY           >= V_MINDATE
                 AND COMPANY_ID    =  V_COMPID) LOOP
      DELETE FROM SCMDATA.T_CATECAPACITY_WEEK_PLAN
       WHERE CWP_ID = L.CWP_ID
         AND COMPANY_ID = L.COMPANY_ID;
    END LOOP;

    DELETE FROM SCMDATA.T_CATEWEEKPLAN_SUP_DETAIL
     WHERE CATEGORY      =  V_CATE
       AND PRODUCT_CATE = V_PROCATE
       AND SUBCATEGORY  = V_SUBCATE
       AND DAY           >= V_MINDATE
       AND COMPANY_ID    =  V_COMPID;

    DELETE FROM SCMDATA.T_CATEWEEKPLAN_CATE_DETAIL
     WHERE  CATEGORY      =  V_CATE
       AND PRODUCT_CATE = V_PROCATE
       AND SUBCATEGORY  = V_SUBCATE
       AND DAY           >= V_MINDATE
       AND COMPANY_ID    =  V_COMPID;

   --供应商周产能
      --该子类所有合作的供应商
       FOR  C IN (SELECT SUPPLIER_CODE
                    FROM SCMDATA.T_COOPCATE_SUPPLIER_CFG A
                   WHERE A.COOP_CATEGORY= V_CATE
                     AND A.COOP_PRODUCTCATE =V_PROCATE
                     AND A.COOP_SUBCATEGORY=V_SUBCATE
                     AND A.PAUSE = 0
                     AND A.COMPANY_ID = V_COMPID) LOOP

          FOR I IN (SELECT DISTINCT SWP_ID, COMPANY_ID
                FROM SCMDATA.T_SUPCAPCWEEKPLAN_CATE_DETAIL
               WHERE SUPPLIER_CODE =  C.SUPPLIER_CODE
                 AND CATEGORY      =  V_CATE
                 AND DAY           >= V_MINDATE
                 AND COMPANY_ID    =  V_COMPID) LOOP
          DELETE FROM SCMDATA.T_SUPCAPACITY_WEEK_PLAN
           WHERE SWP_ID = I.SWP_ID
             AND COMPANY_ID = I.COMPANY_ID;
          END LOOP;

    DELETE FROM SCMDATA.T_SUPCAPCWEEKPLAN_CATE_DETAIL
     WHERE SUPPLIER_CODE =  C.SUPPLIER_CODE
       AND CATEGORY      =  V_CATE
       AND DAY           >= V_MINDATE
       AND COMPANY_ID    =  V_COMPID;

    DELETE FROM SCMDATA.T_SUPCAPCWEEKPLAN_SUP_DETAIL
     WHERE SUPPLIER_CODE =  C.SUPPLIER_CODE
       AND CATEGORY      =  V_CATE
       AND DAY           >= V_MINDATE
       AND COMPANY_ID    =  V_COMPID;*\










  END P_CATEPLANCFG_DISABLE_EFFLEVELS;

  \*=========================================================================

      品类产能配置新增相关数据

      用途：品类配置发生新增/修改时，生产排期、周产能规划新增相关数据

      入参：
        V_CATE       分部
        V_PROCATE    生产类别
        V_SUBCATE    子类
        V_COMPID     企业id


  ==========================================================================*\

  PROCEDURE P_CATEPLANCFG_ABLE_EFFLEVELS(V_CATE    IN VARCHAR2,
                                         V_PROCATE IN VARCHAR2,
                                         V_SUBCATE IN VARCHAR2,
                                         V_COMPID  IN VARCHAR2) IS

    V_FIRSTWAITDAY NUMBER; --首单待料天数
    V_ADDWAITDAY   NUMBER; --补单待料天数
    V_PCTRANSDAY   NUMBER; --后整天数
    V_INSDAYAMT    NUMBER;
    V_STARTDAY     DATE;
    V_ENDDAY       DATE;
    V_CALCDAYNUM   NUMBER;
    V_AVGAMOUNT    NUMBER;
  BEGIN

    FOR I IN (SELECT A.ORDER_CODE,
                     A.COMPANY_ID,
                     A.ISFIRSTORDERED,
                     A.CREATE_TIME,
                     A.DELIVERY_DATE,
                     B.ORDER_AMOUNT - B.GOT_AMOUNT CALCAMOUNT,
                     A.SUPPLIER_CODE,
                     B.FACTORY_CODE
                FROM (SELECT ORDER_CODE,
                             COMPANY_ID,
                             CREATE_TIME,
                             SUPPLIER_CODE,
                             DELIVERY_DATE,
                             ISFIRSTORDERED
                        FROM SCMDATA.T_ORDERED
                       WHERE COMPANY_ID = V_COMPID
                         AND ORDER_STATUS IN ('OS01', 'OS00')
                         AND DELIVERY_DATE BETWEEN SYSDATE AND
                             ADD_MONTHS(SYSDATE, 3)) A
               INNER JOIN SCMDATA.T_ORDERS B
                  ON A.ORDER_CODE = B.ORDER_ID
                 AND A.COMPANY_ID = B.COMPANY_ID
               INNER JOIN SCMDATA.T_COMMODITY_INFO C
                  ON B.GOO_ID = C.GOO_ID
                 AND C.COMPANY_ID = B.COMPANY_ID
               WHERE C.CATEGORY = V_CATE
                 AND C.PRODUCT_CATE = V_PROCATE
                 AND C.SAMLL_CATEGORY = V_SUBCATE
                 AND NOT EXISTS (SELECT 1
                        FROM SCMDATA.T_PRODUCTION_SCHEDULE
                       WHERE ORDER_ID = A.ORDER_CODE
                         AND COMPANY_ID = A.COMPANY_ID)
                 AND NOT EXISTS (SELECT 1
                        FROM SCMDATA.T_COOPCATE_SUPPLIER_CFG
                       WHERE SUPPLIER_CODE = A.SUPPLIER_CODE
                         AND COOP_CATEGORY = V_CATE
                         AND COOP_PRODUCTCATE = V_PROCATE
                         AND COOP_SUBCATEGORY = V_SUBCATE
                         AND PAUSE = 1)) LOOP
      --该订单供应商的备料天数等
      SELECT FIRST_ORD_MAT_WAIT, ADD_ORD_MAT_WAIT, PC_AND_TRANS_WAIT
        INTO V_FIRSTWAITDAY, V_ADDWAITDAY, V_PCTRANSDAY
        FROM (SELECT FIRST_ORD_MAT_WAIT,
                     ADD_ORD_MAT_WAIT,
                     PC_AND_TRANS_WAIT,
                     SUPPLIER_CODES
                FROM SCMDATA.T_PRODUCT_CYCLE_CFG A
               WHERE A.CATEGORY = V_CATE
                 AND A.PRODUCT_CATE = V_PROCATE
                 AND A.SUBCATEGORY = V_SUBCATE
                 AND (A.SUPPLIER_CODES IS NULL OR
                     INSTR(';' || A.SUPPLIER_CODES || ';',
                            ';' || I.SUPPLIER_CODE || ';') > 0));

      IF I.ISFIRSTORDERED = 0 THEN
        V_STARTDAY := TRUNC(I.CREATE_TIME) + 1 + V_ADDWAITDAY; --补单
      ELSE
        V_STARTDAY := TRUNC(I.CREATE_TIME) + 1 + V_FIRSTWAITDAY; --首单
      END IF;

      V_ENDDAY     := TRUNC(I.DELIVERY_DATE) - V_PCTRANSDAY;
      V_CALCDAYNUM := TO_NUMBER(V_ENDDAY - V_STARTDAY) + 1;

      IF V_CALCDAYNUM <= 0 THEN
        V_CALCDAYNUM := 1;
        V_ENDDAY     := V_STARTDAY + 1;
      END IF;
      V_AVGAMOUNT := TRUNC(I.CALCAMOUNT / V_CALCDAYNUM); --平均日产量

      FOR E IN (SELECT DD_DATE
                  FROM SCMDATA.T_DAY_DIM
                 WHERE DD_DATE BETWEEN V_STARTDAY AND V_ENDDAY) LOOP

        IF E.DD_DATE <> V_ENDDAY AND V_CALCDAYNUM <> 1 THEN
          V_INSDAYAMT := V_AVGAMOUNT;
        ELSIF E.DD_DATE = V_ENDDAY AND V_CALCDAYNUM <> 1 THEN
          V_INSDAYAMT := I.CALCAMOUNT - (V_AVGAMOUNT * (V_CALCDAYNUM - 1));
        ELSIF V_CALCDAYNUM = 1 THEN
          V_INSDAYAMT := V_AVGAMOUNT;
        END IF;
        --插入生产排期表
        INSERT INTO SCMDATA.T_PRODUCTION_SCHEDULE
          (PS_ID, COMPANY_ID, ORDER_ID, DAY, PRODUCT_AMOUNT)
        VALUES
          (SCMDATA.F_GET_UUID(),
           I.COMPANY_ID,
           I.ORDER_CODE,
           E.DD_DATE,
           V_INSDAYAMT);
      END LOOP;
    END LOOP;
    --生成周产能相关数据
    FOR F IN (SELECT A.SUPPLIER_CODE
                FROM T_COOPCATE_SUPPLIER_CFG A
               WHERE A.PAUSE = 0
                 AND A.COOP_CATEGORY = V_CATE
                 AND A.COOP_PRODUCTCATE = V_PROCATE
                 AND A.COOP_SUBCATEGORY = V_SUBCATE
                 AND A.COMPANY_ID = V_COMPID) LOOP

         SCMDATA.PKG_CAPACITY_MANAGEMENT.P_GEN_WEEKPLAN_DATA(V_SUPCODE => F.SUPPLIER_CODE,
                                                             V_COMPID  => V_COMPID);





    END LOOP;

  END P_CATEPLANCFG_ABLE_EFFLEVELS;



  \*==================================================================
  kpi t_kpireturn_month表数据更新

    V_METHOD 更新类型，0更新全部历史数据，1更新上月数据
    V_TYPE  指标类型

  ===================================================================*\
 PROCEDURE  P_GETDATA_KPIRT_MONTH ( V_METHOD  IN NUMBER,
                                    V_TYPE    IN NUMBER )
   IS
   V_SQL    CLOB;
   V_WH_SQL2 CLOB;
   V_EXSQL   CLOB;
   V_WM_SQL1 CLOB;
   V_U_SQL2  VARCHAR(2000);
   V_U1_SQL2 VARCHAR(2000);
   V_U2_SQL2 VARCHAR(2000);
   V_I_SQL3  VARCHAR(2000);
 BEGIN
   V_SQL:='MERGE INTO SCMDATA.t_kpireturn_cate_rate G
USING (SELECT Z.COMPANY_ID,
              Z.YEAR,
              Z.MONTH,
              Z.quarter,
              Z.CATEGORY,w.GROUP_DICT_NAME,
              Y.ORDER_AMOUNT,Y.order_money,
              Z.RETURN_AMOUNT,
              Z.return_money,
              X.WHRT_AMOUNT,
              x.whrt_money,
              DECODE(Z.quarter,1,''1'',2,''1'',3,''2'',4,''2'') halfyear
   FROM (SELECT A.COMPANY_ID,
                A.YEAR,
                A.QUARTER,
                A.MONTH,
                B.CATEGORY,
                SUM(A.EXAMOUNT) RETURN_AMOUNT,
                SUM(A.EXAMOUNT * B.PRICE) return_money
           FROM scmdata.T_RETURN_MANAGEMENT A
          INNER JOIN scmdata.T_COMMODITY_INFO B
             ON A.GOO_ID = B.GOO_ID
            AND A.COMPANY_ID = B.COMPANY_ID
           LEFT JOIN scmdata.SYS_COMPANY_DEPT C
             ON A.FIRST_DEPT_ID = C.COMPANY_DEPT_ID
            AND A.COMPANY_ID = C.COMPANY_ID
          WHERE A.AUDIT_TIME IS NOT NULL
            AND C.DEPT_NAME = ''供应链管理部''
          GROUP BY A.COMPANY_ID, A.YEAR,A.QUARTER, A.MONTH, B.CATEGORY) Z
   LEFT JOIN (SELECT A.COMPANY_ID,
                     EXTRACT(YEAR FROM A.CREATE_TIME) YEAR,
                     EXTRACT(MONTH FROM A.CREATE_TIME) MONTH,
                     C.CATEGORY,
                     SUM(B.AMOUNT) ORDER_AMOUNT,
                     SUM(B.AMOUNT * C.PRICE) order_money
                FROM T_INGOOD A
               INNER JOIN T_INGOODS B
                  ON A.ING_ID = B.ING_ID
                 AND A.COMPANY_ID = B.COMPANY_ID
               INNER JOIN T_COMMODITY_INFO C
                  ON C.GOO_ID = B.GOO_ID
                 AND A.COMPANY_ID = C.COMPANY_ID
               WHERE B.AMOUNT > 0
               GROUP BY A.COMPANY_ID,
                        EXTRACT(YEAR FROM A.CREATE_TIME),
                        EXTRACT(MONTH FROM A.CREATE_TIME),
                        C.CATEGORY) Y
     ON Z.COMPANY_ID = Y.COMPANY_ID
    AND Z.YEAR = Y.YEAR
    AND Z.MONTH = Y.MONTH
    AND Z.CATEGORY = Y.CATEGORY
    LEFT JOIN (SELECT a.company_id,
       EXTRACT(YEAR FROM B.COMMIT_TIME) YEAR,
       EXTRACT(MONTH FROM B.COMMIT_TIME) MONTH,
       b.category,
       SUM((CASE
             WHEN A.CHECK_RESULT = ''UQ'' AND B.PROCESSING_TYPE = ''NM'' THEN
              B.SUBS_AMOUNT
              WHEN a.check_result = ''UQ'' AND b.processing_type =''RT''OR b.processing_type = ''RJ'' THEN B.PCOME_AMOUNT
              WHEN A.CHECK_RESULT =''QU'' THEN B.SUBS_AMOUNT
           END)) WHRT_AMOUNT,
      SUM((CASE
             WHEN A.CHECK_RESULT = ''UQ'' AND B.PROCESSING_TYPE = ''NM'' THEN
              B.SUBS_AMOUNT
              WHEN a.check_result = ''UQ'' AND b.processing_type =''RT''OR b.processing_type = ''RJ'' THEN B.PCOME_AMOUNT
              WHEN A.CHECK_RESULT =''QU'' THEN B.SUBS_AMOUNT
           END)*b.price) WHRT_MONEY
 FROM scmdata.t_qa_report a
 INNER JOIN scmdata.t_qa_scope b ON a.qa_report_id=b.qa_report_id AND a.company_id=b.company_id
 INNER JOIN scmdata.t_commodity_info b ON a.goo_id=b.goo_id AND a.company_id=b.company_id
 WHERE a.status IN (''N_ACF'', ''R_ACF'')
 GROUP BY a.company_id,
       EXTRACT(YEAR FROM B.COMMIT_TIME),
       EXTRACT(MONTH FROM B.COMMIT_TIME),
       b.category
) x ON x.company_id=Y.COMPANY_ID AND x.YEAR=y.year AND x.month=y.month AND x.category=y.category
    LEFT JOIN SCMDATA.SYS_GROUP_DICT w ON w.GROUP_DICT_VALUE=Z.CATEGORY AND w.GROUP_DICT_TYPE=''PRODUCT_TYPE''';
  --上一个月的数据
 V_WM_SQL1:=q'[
              WHERE (Z.YEAR||LPAD(Z.MONTH,2,0)) = TO_CHAR(ADD_MONTHS(SYSDATE,-1),'yyyymm')) H
                ON (G.COMPANY_ID=H.COMPANY_ID AND G.year =H.YEAR AND G.quarter =H.quarter AND G.month =H.MONTH AND G.category = H.CATEGORY AND G.category_name =H.GROUP_DICT_NAME）
               WHEN MATCHED THEN ]';

  --全部历史数据
  V_WH_SQL2 :=q'[
                WHERE (Z.YEAR||LPAD(Z.MONTH,2,0)) < TO_CHAR(SYSDATE,'YYYYMM')) H
                   ON (G.COMPANY_ID=H.COMPANY_ID AND G.year =H.YEAR AND G.quarter =H.quarter AND G.month =H.MONTH AND G.category = H.CATEGORY AND G.category_name =H.GROUP_DICT_NAME）
               WHEN MATCHED THEN ]';


  --更新全部数据
   V_U_SQL2 := q'[  UPDATE
                       SET G.ingood_amount       = H.ORDER_AMOUNT,
                           G.INGOOD_MONEY        = H.order_money,
                           G.SHOP_RT_AMOUNT      = H.RETURN_AMOUNT,
                           G.SHOP_RT_MONEY       = H.return_money,
                           G.WAREHOUSE_RT_AMOUNT = H.WHRT_AMOUNT,
                           G.WAREHOUSE_RT_MONEY  = H.whrt_money,
                           G.UPDATE_ID           = 'ADMIN',
                           G.UPDATE_TIME         = SYSDATE ]';

   --更新门店退货金额和总订货金额
   V_U1_SQL2 := q'[   UPDATE
                         SET G.ingood_amount  = H.ORDER_AMOUNT,
                             G.INGOOD_MONEY   = H.order_money,
                             G.SHOP_RT_AMOUNT = H.RETURN_AMOUNT,
                             G.SHOP_RT_MONEY  = H.return_money,
                             G.update_id      = 'ADMIN',
                             G.update_time    = SYSDATE ]';

   --更新仓库退货金额
   V_U2_SQL2 := q'[   UPDATE
                         SET  G.WAREHOUSE_RT_AMOUNT = H.WHRT_AMOUNT,
                              G.WAREHOUSE_RT_MONEY  = H.whrt_money,
                              G.update_id           = 'ADMIN',
                              G.update_time         = SYSDATE ]';

 --插入数据
   V_I_SQL3 := q'[
      WHEN NOT MATCHED THEN
           INSERT
                (G.KPIRTR_ID,G.COMPANY_ID,G.YEAR,G.QUARTER,G.MONTH,G.CATEGORY,G.CATEGORY_NAME,G.INGOOD_AMOUNT,G.INGOOD_MONEY,
                 G.SHOP_RT_AMOUNT,G.SHOP_RT_MONEY,G.WAREHOUSE_RT_AMOUNT,G.WAREHOUSE_RT_MONEY,G.CREATE_ID,G.CREATE_TIME,g.halfyear)
           VALUES
                (SCMDATA.F_GET_UUID(),H.COMPANY_ID,H.YEAR,H.quarter,H.MONTH,H.CATEGORY,H.GROUP_DICT_NAME,H.ORDER_AMOUNT,H.order_money,
                 H.RETURN_AMOUNT,H.return_money,H.WHRT_AMOUNT,H.whrt_money,'ADMIN',SYSDATE,h.halfyear);
                 ]';

   -- V_TYPE = 0 更新全部指标
   IF V_TYPE = 0 THEN

     IF  V_METHOD = 0 THEN
       --更新全部历史数据
       V_EXSQL:=V_SQL||V_WH_SQL2||V_U_SQL2||V_I_SQL3;

      ELSIF V_METHOD = 1 THEN
        --更新上月数据
       V_EXSQL:=V_SQL||V_WM_SQL1||V_U_SQL2||V_I_SQL3;
     END IF;

   --V_TYPE = 1 更新门店退货(只更新不插入）
    ELSIF V_TYPE = 1 THEN
      IF V_METHOD = 0 THEN
        V_EXSQL:=V_SQL||V_WH_SQL2||V_U1_SQL2;

       ELSIF V_METHOD = 1 THEN
         V_EXSQL:=V_SQL||V_WM_SQL1||V_U1_SQL2;
     END IF;

   --V_TYPE = 2 更新仓库退货
     ELSIF V_TYPE = 1 THEN
       IF V_METHOD = 0 THEN
        V_EXSQL:=V_SQL||V_WH_SQL2||V_U2_SQL2;
       ELSIF V_METHOD = 1 THEN
         V_EXSQL:=V_SQL||V_WM_SQL1||V_U2_SQL2;
       END IF;

    END IF;

     DBMS_OUTPUT.put_line(V_EXSQL);

 END P_GETDATA_KPIRT_MONTH;*/

 FUNCTION F_RETURN_CAUSE_CATE_ANALYSIS(V_ORIGIN VARCHAR2,  --门店/仓库
                                   V_DUTY  VARCHAR2,  --全部责任部门/供应链
                                   V_DATE1 NUMBER,  --年
                                   V_DATE2 VARCHAR2,  --月/季/半年/年
                                   V_DATE3 NUMBER DEFAULT NULL,
                                   V_CATE  VARCHAR2,  --分部
                                   V_SELECT1 VARCHAR2, --产品子类/跟单/供应商/生产工厂/qc
                                   V_SELECT2 VARCHAR2 DEFAULT NULL,
                                   V_COMPID  VARCHAR2) RETURN CLOB IS

   V_F_SQL CLOB;
   v_wh_sql CLOB;
   V_S_SQL CLOB;
   V_GR_SQL CLOB;
   V_SELE_TYPE CLOB;
   V_SQL CLOB;
   V_VALUE VARCHAR2(200);
   V_SQL0 CLOB;
  BEGIN

   IF V_SELECT1 = '01' THEN V_SELE_TYPE:='产品子类';
   ELSIF V_SELECT1 = '02' THEN V_SELE_TYPE := '跟单';
   ELSIF V_SELECT1 = '03' THEN V_SELE_TYPE := '供应商';
   ELSIF V_SELECT1 = '04'  THEN V_SELE_TYPE := '生产工厂';
   ELSIF V_SELECT1 = '05' THEN V_SELE_TYPE := 'QC';
   END IF;
  --门店退货
  IF V_ORIGIN='M' THEN

   V_S_SQL:=q'[SELECT D1.GROUP_DICT_NAME,C1.PROBLEM_CLASSIFICATION,C1.CAUSE_CLASSIFICATION,(CASE WHEN C1.IS_SUP_EXEMPTION=0 THEN '否' ELSE '是' END) IS_SUP_EXEMPTION,
       C2.DEPT_NAME,SUM(A.EXAMOUNT*B.PRICE) MONEY  ]';



    V_F_SQL :=q'[FROM SCMDATA.T_RETURN_MANAGEMENT A
 INNER JOIN SCMDATA.T_COMMODITY_INFO B ON A.GOO_ID=B.GOO_ID AND A.COMPANY_ID=B.COMPANY_ID
 INNER JOIN SCMDATA.T_ABNORMAL_DTL_CONFIG C1 ON C1.ABNORMAL_DTL_CONFIG_ID=A.CAUSE_DETAIL_ID AND C1.COMPANY_ID=A.COMPANY_ID
 INNER JOIN SCMDATA.SYS_COMPANY_DEPT C2 ON C1.FIRST_DEPT_ID=C2.COMPANY_DEPT_ID AND C1.COMPANY_ID=C2.COMPANY_ID
 INNER JOIN SCMDATA.SYS_GROUP_DICT D1 ON D1.GROUP_DICT_VALUE=B.CATEGORY AND D1.GROUP_DICT_TYPE='PRODUCT_TYPE']';

   v_wh_sql:='  where A.AUDIT_TIME IS NOT NULL ';



   --时间的条件
   IF V_DATE2 = '01' THEN V_WH_SQL:=V_WH_SQL||' and A.YEAR ='||V_DATE1||' AND lpad(a.month,2,0)='||V_DATE3;
   ELSIF v_date2 = '02' THEN V_WH_SQL:=V_WH_SQL||' and A.YEAR ='||V_DATE1||' AND lpad( A.QUARTER,2,0)='||V_DATE3;
   ELSIF V_DATE2 = '03' THEN V_WH_SQL:=V_WH_SQL||' and A.YEAR ='||V_DATE1||' AND  DECODE(A.QUARTER,1,00,2,00,3,01,4,01)='||V_DATE3;
   ELSIF v_date2 = '04' THEN V_WH_SQL:=V_WH_SQL||' AND A.YEAR = '||V_DATE1;
   END IF;

   --部门条件
   IF V_DUTY = '供应管理部' THEN V_WH_SQL:=V_WH_SQL||' and C2.DEPT_NAME='''||V_DUTY||'''';

   END IF;

  --筛选条件
   IF V_CATE = '1' THEN
     V_WH_SQL :=V_WH_SQL;
    ELSIF V_CATE <>'1' THEN
       V_WH_SQL:=V_WH_SQL||' and b.category = '''||V_CATE||'''';
   END IF;
   IF V_CATE <>'1'AND V_SELECT1 = '01' AND V_SELECT2 IS NOT NULL THEN
      V_WH_SQL:=V_WH_SQL||'   AND B.samll_category ='''||V_SELECT2||'''AND A.COMPANY_ID='''||V_COMPID||'''';
      V_SQL0:='SELECT DISTINCT B.COMPANY_DICT_NAME
                FROM SCMDATA.SYS_GROUP_DICT T
               INNER JOIN SCMDATA.SYS_GROUP_DICT T2
                  ON T2.GROUP_DICT_TYPE = T.GROUP_DICT_VALUE
                 AND T.GROUP_DICT_TYPE = ''PRODUCT_TYPE''
               INNER JOIN SCMDATA.SYS_COMPANY_DICT B
                  ON B.COMPANY_DICT_TYPE = T2.GROUP_DICT_VALUE
               WHERE T.GROUP_DICT_VALUE='''||V_CATE||'''  AND B.COMPANY_DICT_VALUE='''||V_SELECT2||''' AND B.COMPANY_ID='''||V_COMPID||'''';
    EXECUTE IMMEDIATE V_SQL0 INTO V_VALUE;

    ELSIF V_SELECT2 IS NULL THEN
       V_WH_SQL :=V_WH_SQL||'  AND A.COMPANY_ID='''||V_COMPID||'''';
    ELSIF V_CATE = '1' AND V_SELECT1 = '01' THEN
       V_WH_SQL:=V_WH_SQL||'   AND B.samll_category ='''||V_SELECT2||'''AND A.COMPANY_ID='''||V_COMPID||'''';
       V_SQL0:='SELECT T.COMPANY_DICT_NAME
                  FROM SCMDATA.SYS_COMPANY_DICT T WHERE T.COMPANY_DICT_VALUE='''||V_SELECT2||''' AND T.COMPANY_ID='''||V_COMPID||'''';
       EXECUTE IMMEDIATE V_SQL0 INTO V_VALUE;
   ELSIF  V_SELECT1 = '02' THEN  --跟单
      V_WH_SQL:=V_WH_SQL||'  AND A.MERCHER_ID='''||V_SELECT2||'''AND A.COMPANY_ID='''||V_COMPID||'''';
      V_SQL0:='SELECT X.COMPANY_USER_NAME
                 FROM SYS_COMPANY_USER X WHERE X.USER_ID= '''||V_SELECT2||'''AND A.COMPANY_ID='''||V_COMPID||'''';
      EXECUTE IMMEDIATE V_SQL0 INTO V_VALUE;

   ELSIF V_SELECT1 = '03' THEN --供应商
      V_WH_SQL:=V_WH_SQL||'  AND A.SUPPLIER_CODE='''||V_SELECT2||'''AND A.COMPANY_ID='''||V_COMPID||'''';
      V_SQL0:='SELECT supplier_company_name
                 FROM SCMDATA.T_SUPPLIER_INFO X WHERE X.supplier_code ='''||V_SELECT2||'''AND A.COMPANY_ID='''||V_COMPID||'''';
      EXECUTE IMMEDIATE V_SQL0 INTO V_VALUE;
   ELSIF  V_SELECT1 = '05' THEN  --QC
      --V_WH_SQL:=V_WH_SQL||' and b.category = '''||V_CATE||''' AND (A.qc_id = '''||V_SELECT2||''' OR A.qc_director_id='''||V_SELECT2||''') AND A.COMPANY_ID='''||V_COMPID||'''';
      V_WH_SQL:=V_WH_SQL||'  AND (INSTR('',''||A.qc_id||'','','',''||'''||V_SELECT2||'''||'','') >0 or instr('',''||A.qc_director_id||'','','',''||'''||V_SELECT2||'''||'','')>0) AND A.COMPANY_ID='''||V_COMPID||'''';

      V_SQL0:='SELECT COMPANY_USER_NAME
                 FROM SYS_COMPANY_USER X WHERE X.USER_ID= '''||V_SELECT2||'''AND x.COMPANY_ID='''||V_COMPID||'''';
      EXECUTE IMMEDIATE V_SQL0 INTO V_VALUE;


   END IF;
  --GROUP BY
  V_GR_SQL:=q'[  GROUP BY D1.GROUP_DICT_NAME,C1.PROBLEM_CLASSIFICATION,C1.CAUSE_CLASSIFICATION,IS_SUP_EXEMPTION,C2.DEPT_NAME]';

   v_sql:=q'[with tmp as (]'|| V_S_SQL||V_F_SQL||v_wh_sql||V_GR_SQL||')
          select GROUP_DICT_NAME, '''||V_VALUE||''' '||V_SELE_TYPE||q'[,  PROBLEM_CLASSIFICATION,
            CAUSE_CLASSIFICATION,IS_SUP_EXEMPTION,DEPT_NAME,money/(SELECT SUM(money) FROM tmp) RT_RATE,MONEY FROM tmp
            union all
            select '' GROUP_DICT_NAME,
                   ''  ]'||V_SELE_TYPE||q'[,
                   '' PROBLEM_CLASSIFICATION,
                   '' CAUSE_CLASSIFICATION,
                   '' IS_SUP_EXEMPTION,
                   '' DEPT_NAME,
                   1 RT_RATE,
                   SUM(money)   MONEY from tmp ]';


   --仓库
   ELSIF V_ORIGIN <>'M' THEN

       V_S_SQL:=q'[SELECT I.GROUP_DICT_NAME,--分部
       H.GROUP_DICT_NAME PROBLEM_NAME,
       (CASE WHEN C.UNQUALREASON_CLASS='MFL_FACTOR' OR
                  C.UNQUALREASON_CLASS='GY_FACTOR'  OR
                  C.UNQUALREASON_CLASS='WB_FACTOR' OR
                  C.UNQUALREASON_CLASS='BC_FACTOR' THEN '供应链管理部' ELSE '无'END) FIRST_RESP_DEPT,
        (CASE WHEN C.UNQUALREASON_CLASS='MFL_FACTOR' OR
                  C.UNQUALREASON_CLASS='GY_FACTOR'  OR
                  C.UNQUALREASON_CLASS='WB_FACTOR' OR
                  C.UNQUALREASON_CLASS='BC_FACTOR' THEN '否' ELSE '是' END) IS_SUPP_DEPT,
         SUM((CASE WHEN A.PROCESSING_TYPE ='NM' AND A.subs_amount >0 THEN A.SUBS_AMOUNT
            WHEN A.PROCESSING_TYPE <> 'NM' THEN A.pcome_amount  END)*B.PRICE)  MONEY ]';

      V_F_SQL:=q'[FROM SCMDATA.T_QA_SCOPE A
INNER JOIN SCMDATA.T_COMMODITY_INFO B ON A.GOO_ID= B.GOO_ID AND A.COMPANY_ID = B.COMPANY_ID
INNER JOIN scmdata.T_QA_REPORT C  ON A.QA_REPORT_ID=C.QA_REPORT_ID AND A.COMPANY_ID=C.COMPANY_ID
INNER JOIN SCMDATA.T_ORDERED D ON A.ORDER_ID = D.ORDER_CODE AND A.COMPANY_ID=D.COMPANY_ID
INNER JOIN scmdata.t_orders e ON e.order_id=d.order_code AND e.company_id=d.company_id
LEFT JOIN scmdata.t_qc_check_rela_order f ON f.orders_id=e.orders_id AND e.company_id=f.company_id
LEFT JOIN scmdata.t_qc_check g ON g.qc_check_id=f.qc_check_id AND g.qc_check_node='QC_FINAL_CHECK'
LEFT JOIN SCMDATA.SYS_GROUP_DICT H
    ON H.GROUP_DICT_TYPE = 'QA_UNQUAL_REASON_CLASS' AND C.UNQUALREASON_CLASS=H.GROUP_DICT_VALUE
INNER JOIN SCMDATA.SYS_GROUP_DICT I ON I.GROUP_DICT_VALUE=B.CATEGORY AND I.GROUP_DICT_TYPE='PRODUCT_TYPE']';

     V_WH_SQL:='   WHERE C.STATUS IN (''N_ACF'',''R_ACF'') ';
     IF V_ORIGIN ='GZZ' THEN
       V_WH_SQL := V_WH_SQL||' AND D.sho_id = ''GZZ'' ';
     ELSIF V_ORIGIN = 'YWZ' THEN
       V_WH_SQL:=V_WH_SQL||'  AND D.SHO_ID = ''YWZ'' ';
     ELSIF V_ORIGIN ='GDZ' THEN
       V_WH_SQL:=V_WH_SQL||'  AND D.SHO_ID = ''GDZ'' ';
     END IF;

   --时间的条件
      IF V_DATE2 = '01' THEN V_WH_SQL:=V_WH_SQL||' AND EXTRACT(YEAR FROM A.COMMIT_TIME) ='||V_DATE1||' AND LPAD (EXTRACT (MONTH FROM A.COMMIT_TIME),2,0)='||V_DATE3;
   ELSIF v_date2 = '02' THEN V_WH_SQL:=V_WH_SQL||' AND EXTRACT(YEAR FROM A.COMMIT_TIME) ='||V_DATE1||' AND  LPAD(TO_CHAR(A.COMMIT_TIME,''Q''),2,0)='||V_DATE3;
   ELSIF V_DATE2 = '03' THEN V_WH_SQL:=V_WH_SQL||' AND EXTRACT(YEAR FROM A.COMMIT_TIME) ='||V_DATE1||' AND  DECODE(A.QUARTER,1,1,2,1,3,2,4,2)='||V_DATE3;
   ELSIF v_date2 = '04' THEN V_WH_SQL:=V_WH_SQL||' AND EXTRACT(YEAR FROM A.COMMIT_TIME) = '||V_DATE1;
   END IF;



   --筛选条件

     IF V_CATE = '1' THEN
     V_WH_SQL :=V_WH_SQL;
    ELSIF V_CATE <>'1' THEN
     V_WH_SQL:=V_WH_SQL||' and b.category = '''||V_CATE||'''';
   END IF;
     IF  V_CATE <>'1' AND V_SELECT1 = '01' AND V_SELECT2 IS NOT NULL THEN  --产品子类
      V_WH_SQL:=V_WH_SQL||'   AND B.samll_category ='''||V_SELECT2||'''AND A.COMPANY_ID='''||V_COMPID||'''';

     V_SQL0:='SELECT DISTINCT B.COMPANY_DICT_NAME
                FROM SCMDATA.SYS_GROUP_DICT T
               INNER JOIN SCMDATA.SYS_GROUP_DICT T2
                  ON T2.GROUP_DICT_TYPE = T.GROUP_DICT_VALUE
                 AND T.GROUP_DICT_TYPE = ''PRODUCT_TYPE''
               INNER JOIN SCMDATA.SYS_COMPANY_DICT B
                  ON B.COMPANY_DICT_TYPE = T2.GROUP_DICT_VALUE
               WHERE T.GROUP_DICT_VALUE='''||V_CATE||'''  AND B.COMPANY_DICT_VALUE='''||V_SELECT2||''' AND B.COMPANY_ID='''||V_COMPID||'''';
    EXECUTE IMMEDIATE V_SQL0 INTO V_VALUE;

    ELSIF V_CATE ='1' AND V_SELECT1 = '01' THEN
      V_WH_SQL:=V_WH_SQL||'   AND B.samll_category ='''||V_SELECT2||'''AND A.COMPANY_ID='''||V_COMPID||'''';
      V_SQL0:='SELECT T.COMPANY_DICT_NAME
                  FROM SCMDATA.SYS_COMPANY_DICT T WHERE T.COMPANY_DICT_VALUE='''||V_SELECT2||''' AND T.COMPANY_ID='''||V_COMPID||'''';
       EXECUTE IMMEDIATE V_SQL0 INTO V_VALUE;
    ELSIF V_SELECT2 IS NULL THEN
      V_WH_SQL :=V_WH_SQL||'  AND A.COMPANY_ID='''||V_COMPID||'''';
    ELSIF  V_SELECT1 = '02' THEN  --跟单
      V_WH_SQL:=V_WH_SQL||'  AND INSTR('';''||D.DEAL_FOLLOWER||'';'','';''||'||V_SELECT2||''';'')>0 AND A.COMPANY_ID='''||V_COMPID||'''';

      V_SQL0:='SELECT X.COMPANY_USER_NAME
                 FROM SYS_COMPANY_USER X WHERE X.USER_ID= '''||V_SELECT2||'''AND A.COMPANY_ID='''||V_COMPID||'''';
      EXECUTE IMMEDIATE V_SQL0 INTO V_VALUE;

    ELSIF V_SELECT1 = '03' THEN --供应商
      V_WH_SQL:=V_WH_SQL||' AND  D.SUPPLIER_CODE ='''||V_SELECT2||'''AND A.COMPANY_ID='''||V_COMPID||'''';
      V_SQL0:='SELECT SUPPLIER_COMPANY_NAME
                 FROM SCMDATA.T_SUPPLIER_INFO X WHERE X.supplier_code ='''||V_SELECT2||'''AND X.COMPANY_ID='''||V_COMPID||'''';
      EXECUTE IMMEDIATE V_SQL0 INTO V_VALUE;

    ELSIF V_SELECT1='04' THEN --生产工厂
       V_WH_SQL:=V_WH_SQL||'  AND E.FACTORY_CODE= '''||V_SELECT2||'''AND A.COMPANY_ID='''||V_COMPID||'''';
       V_SQL0:='SELECT SUPPLIER_COMPANY_NAME
                 FROM SCMDATA.T_SUPPLIER_INFO X WHERE X.supplier_code ='''||V_SELECT2||'''AND X.COMPANY_ID='''||V_COMPID||'''';
      EXECUTE IMMEDIATE V_SQL0 INTO V_VALUE;

    ELSIF V_SELECT1='05' THEN --QC
       V_WH_SQL:=V_WH_SQL||'  AND G.FINISH_QC_ID= '''||V_SELECT2||'''AND A.COMPANY_ID='''||V_COMPID||'''';
       V_SQL0:='SELECT COMPANY_USER_NAME
                 FROM SYS_COMPANY_USER X WHERE X.USER_ID= '''||V_SELECT2||'''AND x.COMPANY_ID='''||V_COMPID||'''';
      EXECUTE IMMEDIATE V_SQL0 INTO V_VALUE;
     END IF;

   --GROUP BY
    V_GR_SQL:=q'[GROUP BY I.GROUP_DICT_NAME,--分部
        H.GROUP_DICT_NAME, --问题分类
       (CASE WHEN C.UNQUALREASON_CLASS='MFL_FACTOR' OR
                  C.UNQUALREASON_CLASS='GY_FACTOR'  OR
                  C.UNQUALREASON_CLASS='WB_FACTOR' OR
                  C.UNQUALREASON_CLASS='BC_FACTOR' THEN '供应链管理部' ELSE '无'END) ,
        (CASE WHEN C.UNQUALREASON_CLASS='MFL_FACTOR' OR
                  C.UNQUALREASON_CLASS='GY_FACTOR'  OR
                  C.UNQUALREASON_CLASS='WB_FACTOR' OR
                  C.UNQUALREASON_CLASS='BC_FACTOR' THEN '否' ELSE '是' END)]';

    v_sql:=q'[with tmp as (]'|| V_S_SQL||V_F_SQL||v_wh_sql||V_GR_SQL||')
              SELECT GROUP_DICT_NAME,'''||V_VALUE||''' '||V_SELE_TYPE||q'[,  PROBLEM_NAME, FIRST_RESP_DEPT, IS_SUPP_DEPT,
               money/(SELECT SUM(money) FROM tmp) RT_RATE, MONEY FROM tmp
            union all
            select '' GROUP_DICT_NAME,
                   ''  ]'||V_SELE_TYPE||q'[,
                   '' PROBLEM_NAME,
                   '' FIRST_RESP_DEPT,
                   '' IS_SUPP_DEPT,
                   1 RT_RATE,
                  SUM(money)   MONEY from tmp ]';

    END IF;





 /* V_SQL:=q'[SELECT GROUP_DICT_NAME, ']'|| V_VALUE||''' '||V_SELE_TYPE||q'[,  PROBLEM_CLASSIFICATION,
            CAUSE_CLASSIFICATION,IS_SUP_EXEMPTION,DEPT_NAME,MONEY FROM (]'||V_S_SQL||V_F_SQL||v_wh_sql||V_GR_SQL||')';
 */

 RETURN V_SQL;

 END F_RETURN_CAUSE_CATE_ANALYSIS;


 /*==================================================================================
 区域组



 ======================================================================================*/
 FUNCTION F_RETURN_CAUSE_QY_ANALYSIS(V_ORIGIN IN VARCHAR2,
                                     V_GROUP IN VARCHAR2,
                                     V_CATE   IN VARCHAR2,
                                     V_DUTY   IN VARCHAR2,
                                     V_DATE1  IN NUMBER,
                                     V_DATE2  IN VARCHAR2,
                                     V_DATE3  IN VARCHAR2 DEFAULT NULL,
                                     V_COMPID IN VARCHAR2) RETURN CLOB IS
   V_S_SQL CLOB;
   V_WH_SQL CLOB;
   V_GR_SQL CLOB;
   V_VALUE  VARCHAR2(64);
   V_SQL0  VARCHAR2(512);
   V_SQL CLOB;

  BEGIN

   IF V_ORIGIN = 'M' THEN

      V_S_SQL:=q'[SELECT A.SUP_GROUP_NAME, C.PROBLEM_CLASSIFICATION, C.CAUSE_CLASSIFICATION,
                         D.DEPT_NAME, (CASE WHEN C.IS_SUP_EXEMPTION = 0 THEN  '否' ELSE '是' END) IS_SUP_EXEMPTION,
                         SUM(A.EXAMOUNT * B.PRICE) MONEY
                    FROM SCMDATA.T_RETURN_MANAGEMENT A
                   INNER JOIN SCMDATA.T_COMMODITY_INFO B
                      ON A.GOO_ID = B.GOO_ID
                     AND A.COMPANY_ID = B.COMPANY_ID
                   INNER JOIN SCMDATA.T_ABNORMAL_DTL_CONFIG C
                      ON C.ABNORMAL_DTL_CONFIG_ID = A.CAUSE_DETAIL_ID
                     AND C.COMPANY_ID = A.COMPANY_ID
                   INNER JOIN SCMDATA.SYS_COMPANY_DEPT D
                      ON C.FIRST_DEPT_ID = D.COMPANY_DEPT_ID
                     AND C.COMPANY_ID = D.COMPANY_ID   ]';

   V_WH_SQL:='  where A.AUDIT_TIME IS NOT NULL ';

     --时间的条件
   IF V_DATE2 = '01' THEN V_WH_SQL:=V_WH_SQL||' and A.YEAR ='||V_DATE1||' AND lpad(a.month,2,0)='||V_DATE3;
   ELSIF V_DATE2 = '02' THEN V_WH_SQL:=V_WH_SQL||' and A.YEAR ='||V_DATE1||' AND lpad( A.QUARTER,2,0)='||V_DATE3;
   ELSIF V_DATE2 = '03' THEN V_WH_SQL:=V_WH_SQL||' and A.YEAR ='||V_DATE1||' AND  DECODE(A.QUARTER,1,00,2,00,3,01,4,01)='||V_DATE3;
   ELSIF V_DATE2 = '04' THEN V_WH_SQL:=V_WH_SQL||' AND A.YEAR = '||V_DATE1;
   END IF;

   --责任部门
   IF V_DUTY = '供应管理部' THEN V_WH_SQL:=V_WH_SQL||' and D.DEPT_NAME='''||V_DUTY||'''';
   END IF;

   --分部
   IF V_CATE <> '1' THEN
         V_WH_SQL:=V_WH_SQL||'  AND B.CATEGORY = '''||V_CATE||'''';
       V_SQL0:='SELECT GROUP_DICT_NAME
                  FROM SCMDATA.SYS_GROUP_DICT T WHERE T.GROUP_DICT_VALUE='''||V_CATE||''' AND T.GROUP_DICT_TYPE = ''PRODUCT_TYPE''';
       EXECUTE IMMEDIATE V_SQL0 INTO V_VALUE;

   ELSIF V_CATE = '1' THEN V_WH_SQL :=V_WH_SQL;
      V_VALUE:='全部';

   END IF;


     --区域的条件
    IF V_GROUP <>  '全部' THEN V_WH_SQL:=V_WH_SQL||'  AND A.SUP_GROUP_NAME = '''||V_GROUP||''' AND A.COMPANY_ID = '''||V_COMPID||'''';

   -- ELSIF V_GROUP = '全部' THEN V_WH_SQL:=V_WH_SQL||' AND A.COMPANY_ID = '''||V_COMPID||'''';
    END IF;

    --GROUP BY
    V_GR_SQL:=q'[   GROUP BY A.SUP_GROUP_NAME,
          C.PROBLEM_CLASSIFICATION,
          C.CAUSE_CLASSIFICATION,
          (CASE WHEN C.IS_SUP_EXEMPTION = 0 THEN '否'
            ELSE  '是' END),
          D.DEPT_NAME]';

    V_SQL:='WITH TMP AS ('||V_S_SQL||V_WH_SQL||V_GR_SQL||')
            SELECT SUP_GROUP_NAME,'''||V_VALUE||''' '||q'[分部,
                   PROBLEM_CLASSIFICATION,
                   CAUSE_CLASSIFICATION,
                   DEPT_NAME,
                   IS_SUP_EXEMPTION,
                   money/(SELECT SUM(money) FROM tmp) RT_RATE, MONEY FROM tmp
            union all
            SELECT '' SUP_GROUP_NAME,
                   '' 分部,
                   '' PROBLEM_CLASSIFICATION,
                   '' CAUSE_CLASSIFICATION,
                   '' DEPT_NAME,
                   '' IS_SUP_EXEMPTION,
                   1 RT_RATE,
                   SUM(money)   MONEY from tmp ]';
 -----仓库
   ELSIF V_ORIGIN <> 'M' THEN
      --IF V_ORIGIN = 'ALL' THEN
         V_S_SQL:= q'[SELECT E.GROUP_NAME,
       F.GROUP_DICT_NAME,
       (CASE WHEN C.UNQUALREASON_CLASS='MFL_FACTOR' OR
                  C.UNQUALREASON_CLASS='GY_FACTOR'  OR
                  C.UNQUALREASON_CLASS='WB_FACTOR' OR
                  C.UNQUALREASON_CLASS='BC_FACTOR' THEN '供应链管理部' ELSE '无'END) FIRST_RESP_DEPT,
       (CASE WHEN C.UNQUALREASON_CLASS='MFL_FACTOR' OR
                  C.UNQUALREASON_CLASS='GY_FACTOR'  OR
                  C.UNQUALREASON_CLASS='WB_FACTOR' OR
                  C.UNQUALREASON_CLASS='BC_FACTOR' THEN '否' ELSE '是' END) IS_SUPP_DEPT,
        SUM((CASE WHEN A.PROCESSING_TYPE ='NM' AND A.subs_amount >0 THEN A.SUBS_AMOUNT
            WHEN A.PROCESSING_TYPE <> 'NM' THEN A.pcome_amount  END)*B.PRICE)  MONEY
 FROM SCMDATA.T_QA_SCOPE A
 INNER JOIN SCMDATA.T_COMMODITY_INFO B ON A.GOO_ID=B.GOO_ID AND A.COMPANY_ID=B.COMPANY_ID
 INNER JOIN SCMDATA.T_QA_REPORT C ON A.QA_REPORT_ID=C.QA_REPORT_ID AND A.COMPANY_ID=C.COMPANY_ID
INNER JOIN SCMDATA.T_ORDERED D  ON D.ORDER_CODE= A.ORDER_ID AND A.COMPANY_ID=D.COMPANY_ID
INNER JOIN SCMDATA.PT_ORDERED E ON D.ORDER_ID=E.ORDER_ID AND E.COMPANY_ID=A.COMPANY_ID
LEFT JOIN SCMDATA.SYS_GROUP_DICT F ON F.GROUP_DICT_VALUE=C.UNQUALREASON_CLASS AND F.GROUP_DICT_TYPE = 'QA_UNQUAL_REASON_CLASS'  ]';


   V_WH_SQL:='   WHERE C.STATUS IN (''N_ACF'',''R_ACF'') ';

   --仓库条件
     IF V_ORIGIN ='GZZ' THEN
       V_WH_SQL := V_WH_SQL||' AND D.sho_id = ''GZZ'' ';
     ELSIF V_ORIGIN = 'YWZ' THEN
       V_WH_SQL:=V_WH_SQL||'  AND D.SHO_ID = ''YWZ'' ';
     ELSIF V_ORIGIN ='GDZ' THEN
       V_WH_SQL:=V_WH_SQL||'  AND D.SHO_ID = ''GDZ'' ';
     END IF;

   --时间的条件
      IF V_DATE2 = '01' THEN V_WH_SQL:=V_WH_SQL||' AND EXTRACT(YEAR FROM A.COMMIT_TIME) ='||V_DATE1||' AND LPAD (EXTRACT (MONTH FROM A.COMMIT_TIME),2,0)='||V_DATE3;
   ELSIF v_date2 = '02' THEN V_WH_SQL:=V_WH_SQL||' AND EXTRACT(YEAR FROM A.COMMIT_TIME) ='||V_DATE1||' AND  LPAD(TO_CHAR(A.COMMIT_TIME,''Q''),2,0)='||V_DATE3;
   ELSIF V_DATE2 = '03' THEN V_WH_SQL:=V_WH_SQL||' AND EXTRACT(YEAR FROM A.COMMIT_TIME) ='||V_DATE1||' AND  DECODE(A.QUARTER,1,1,2,1,3,2,4,2)='||V_DATE3;
   ELSIF v_date2 = '04' THEN V_WH_SQL:=V_WH_SQL||' AND EXTRACT(YEAR FROM A.COMMIT_TIME) = '||V_DATE1;
   END IF;

   --分部条件
      IF V_CATE <> '1' THEN V_WH_SQL:=V_WH_SQL||'  AND B.CATEGORY = '''||V_CATE||'''';
       V_SQL0:='SELECT GROUP_DICT_NAME
                  FROM SCMDATA.SYS_GROUP_DICT T WHERE T.GROUP_DICT_VALUE='''||V_CATE||''' AND T.GROUP_DICT_TYPE = ''PRODUCT_TYPE''';
       EXECUTE IMMEDIATE V_SQL0 INTO V_VALUE;
   ELSIF V_CATE = '1' THEN V_WH_SQL :=V_WH_SQL;
   END IF;

  /*     --责任部门
   IF V_DUTY = '供应管理部' THEN V_WH_SQL:=V_WH_SQL||' and FIRST_RESP_DEPT='''||V_DUTY||'''';
   END IF;
   */

   --区域组
   IF V_GROUP <>  '全部' THEN V_WH_SQL:=V_WH_SQL||'  AND E.GROUP_NAME = '''||V_GROUP||''' AND A.COMPANY_ID = '''||V_COMPID||'''';

   -- ELSIF V_GROUP = '全部' THEN V_WH_SQL:=V_WH_SQL||' AND A.COMPANY_ID = '''||V_COMPID||'''';
    END IF;

    V_GR_SQL:=q'[ GROUP BY E.GROUP_NAME,
       F.GROUP_DICT_NAME,(CASE WHEN C.UNQUALREASON_CLASS='MFL_FACTOR' OR
                  C.UNQUALREASON_CLASS='GY_FACTOR'  OR
                  C.UNQUALREASON_CLASS='WB_FACTOR' OR
                  C.UNQUALREASON_CLASS='BC_FACTOR' THEN '供应链管理部' ELSE '无'END),
       (CASE WHEN C.UNQUALREASON_CLASS='MFL_FACTOR' OR
                  C.UNQUALREASON_CLASS='GY_FACTOR'  OR
                  C.UNQUALREASON_CLASS='WB_FACTOR' OR
                  C.UNQUALREASON_CLASS='BC_FACTOR' THEN '否' ELSE '是' END) ]';

    V_SQL:='WITH TMP AS ( '||V_S_SQL||V_WH_SQL||V_GR_SQL||')
            SELECT GROUP_NAME, '''||V_VALUE||''' '||q'[分部,
                   GROUP_DICT_NAME,
                   FIRST_RESP_DEPT,
                   IS_SUPP_DEPT,
                   money/(SELECT SUM(money) FROM tmp) RT_RATE, MONEY FROM tmp where( FIRST_RESP_DEPT =']'||V_DUTY||q'[' or 1=1)
             union all
             select '' GROUP_NAME,
                    '' 分部,
                    '' GROUP_DICT_NAME,
                    '' FIRST_RESP_DEPT,
                    '' IS_SUPP_DEPT,
                    1  RT_RATE,
                    SUM(MONEY) MONEY FROM TMP ]';
    END IF;
  RETURN V_SQL;

 END F_RETURN_CAUSE_QY_ANALYSIS;
  
/* FUNCTION F_UPD_RETURNMANA(V_RT_REC SCMDATA.T_RETURN_MANAGEMENT%ROWTYPE)
   RETURN CLOB IS
  V_JUDGE1         VARCHAR2(100);
  
  V_QC_DIRECTOR_ID VARCHAR2(256);
  V_NUM1           NUMBER;
  V_NUM2           NUMBER;
  V_SQL            CLOB;  
 
 BEGIN

   IF V_RT_REC.QC_ID IS NOT NULL THEN 
   V_QC_DIRECTOR_ID := SCMDATA.PKG_DB_JOB.F_GET_MANAGER(P_COMPANY_ID     => V_RT_REC.COMPANY_ID,
                                                           P_USER_ID        => V_RT_REC.QC_ID,
                                                           P_COMPANY_JOB_ID => '1001005003005001');
    END IF;
   SELECT SCMDATA.PKG_PLAT_COMM.F_HASACTION_APPLICATION(V_RT_REC.UPDATE_ID,
                                                        V_RT_REC.COMPANY_ID,
                                                        'P0140106')
    INTO V_NUM1
    FROM DUAL;
    
   SELECT SCMDATA.PKG_PLAT_COMM.F_HASACTION_APPLICATION(V_RT_REC.UPDATE_ID,
                                               V_RT_REC.COMPANY_ID,
                                               'P0140107')
    INTO V_NUM2
    FROM DUAL; 
  IF V_NUM1 = 0 AND V_NUM2 = 1 THEN  
    V_SQL:='DECLARE 
          BEGIN 
             UPDATE SCMDATA.T_RETURN_MANAGEMENT A
                SET A.QC_ID          = '''||V_RT_REC.QC_ID||''',                                                    
                   A.QC_DIRECTOR_ID  ='''||V_QC_DIRECTOR_ID||''',
                   A.UPDATE_ID      = '''||V_RT_REC.UPDATE_ID||''',
                   A.UPDATE_TIME    = SYSDATE';
   END IF;
 END F_UPD_RETURNMANA;*/
 
 FUNCTION F_UPD_RETURN(V_USERID IN VARCHAR2,
                       V_COMPID IN VARCHAR2) RETURN CLOB IS
 
  V_NUM1           NUMBER;
  V_NUM2           NUMBER;
  V_NUM3           NUMBER;
  V_SQL            CLOB;  
 BEGIN
   SELECT SCMDATA.PKG_PLAT_COMM.F_HASACTION_APPLICATION(V_USERID,V_COMPID,'P0140106')
    INTO V_NUM1
    FROM DUAL;
    
   SELECT SCMDATA.PKG_PLAT_COMM.F_HASACTION_APPLICATION(V_USERID,V_COMPID,'P0140107')
    INTO V_NUM2
    FROM DUAL; 
    
   SELECT SCMDATA.PKG_PLAT_COMM.F_HASACTION_APPLICATION(V_USERID,V_COMPID,'P0140108')
    INTO V_NUM3
    FROM DUAL; 
    
   --QC编辑
   IF V_NUM1 = 0 AND V_NUM2 = 1 AND V_NUM3 = 0 THEN  
     V_SQL:='DECLARE
              V_QC_ID VARCHAR2(256):=:QC_ID;
              V_QCDIRE_ID VARCHAR2(256);
             BEGIN
               IF V_QCDIRE_ID IS NULL AND V_QC_ID IS NOT NULL THEN
                 V_QCDIRE_ID:=SCMDATA.PKG_DB_JOB.F_GET_MANAGER(P_COMPANY_ID     => '''||V_COMPID||''',
                                                             P_USER_ID        => V_QC_ID,
                                                             P_COMPANY_JOB_ID => ''1001005003005001'');
                 END IF;
                 UPDATE SCMDATA.T_RETURN_MANAGEMENT T
                    SET A.QC_ID = :QC_ID,
                        A.QC_DIRECTOR_ID = V_QCDIRE_ID,
                        A.UPDATE_ID = %CURRENT_USERID%,
                        A.UPDATE_TIME = SYSDATE 
                  WHERE A.COMPANY_ID = %DEFAULT_COMPANY_ID% AND A.RM_ID=:RM_ID;
              END;';
     --跟单编辑
     ELSIF V_NUM1=1 AND V_NUM2=0 AND V_NUM3 = 0 THEN 
       V_SQL:='DECLARE 
                V_JUDGE1 VARCHAR2(256);
               BEGIN
                 SELECT MAX(CAUSE_DETAIL)
                   INTO V_JUDGE1
                   FROM SCMDATA.T_ABNORMAL_DTL_CONFIG
                  WHERE ABNORMAL_DTL_CONFIG_ID = :CAUSE_DETAIL_ID
                    AND COMPANY_ID = %DEFAULT_COMPANY_ID%;
                    
      IF :RM_TYPE IS NULL OR :CAUSE_DETAIL_ID IS NULL OR
         :SECOND_DEPT_ID IS NULL THEN
        RAISE_APPLICATION_ERROR(-20002,
                                :RELA_GOO_ID || ''未填写必填项，请检查！'');
      ELSIF :RM_TYPE = ''零星'' AND V_JUDGE1 <> ''其他零星问题'' OR V_JUDGE1 IS NULL THEN
        RAISE_APPLICATION_ERROR(-20002,
                                :RELA_GOO_ID ||
                                ''“批量/零星”选择为“零星”时，问题分类，原因分类,原因细分只可为其他零星问题'');
      ELSIF :RM_TYPE = ''批量'' AND :CAUSE_DETAIL_DE = ''其他零星问题'' THEN
        RAISE_APPLICATION_ERROR(-20002,
                                ''“批量/零星”选择为“批量”时，问题不可为其他零星问题！'');  
      ELSIF :RM_TYPE IS NOT NULL AND :CAUSE_DETAIL_ID IS NOT NULL THEN                          
        UPDATE SCMDATA.T_RETURN_MANAGEMENT A
           SET A.RM_TYPE         = :RM_TYPE,
               A.CAUSE_DETAIL_ID = :CAUSE_DETAIL_ID,
               A.PROBLEM_DEC     = :PROBLEM_DESC,
               A.FIRST_DEPT_ID   = :FIRST_DEPT_ID,
               A.SECOND_DEPT_ID  = :SECOND_DEPT_ID,
               A.MEMO            = :MEMO,
               A.MERCHER_ID      = :MERCHER_ID,
               A.UPDATE_ID   = %CURRENT_USERID%,
               A.UPDATE_TIME = SYSDATE
         WHERE A.COMPANY_ID = %DEFAULT_COMPANY_ID%
           AND A.RM_ID = :RM_ID;
        END;';  
        
     ELSIF V_NUM3 = 1 THEN 
       V_SQL:='DECLARE
               V_JUDGE1 VARCHAR2(256);
               BEGIN
                 SELECT MAX(CAUSE_DETAIL)
                   INTO V_JUDGE1
                   FROM SCMDATA.T_ABNORMAL_DTL_CONFIG
                  WHERE ABNORMAL_DTL_CONFIG_ID = :CAUSE_DETAIL_ID
                    AND COMPANY_ID = %DEFAULT_COMPANY_ID%;
                    
      IF :RM_TYPE IS NULL OR :CAUSE_DETAIL_ID IS NULL OR
         :SECOND_DEPT_ID IS NULL THEN
        RAISE_APPLICATION_ERROR(-20002,
                                :RELA_GOO_ID || ''未填写必填项，请检查！'');
      ELSIF :RM_TYPE = ''零星'' AND V_JUDGE1 <> ''其他零星问题'' OR V_JUDGE1 IS NULL THEN
        RAISE_APPLICATION_ERROR(-20002,
                                :RELA_GOO_ID ||
                                ''“批量/零星”选择为“零星”时，问题分类，原因分类,原因细分只可为其他零星问题'');
      ELSIF :RM_TYPE = ''批量'' AND :CAUSE_DETAIL_DE = ''其他零星问题'' THEN
        RAISE_APPLICATION_ERROR(-20002,
                                ''“批量/零星”选择为“批量”时，问题不可为其他零星问题！'');  
      ELSIF :RM_TYPE IS NOT NULL AND :CAUSE_DETAIL_ID IS NOT NULL THEN 
        UPDATE SCMDATA.T_RETURN_MANAGEMENT A
       SET A.RM_TYPE         = :RM_TYPE,
           A.CAUSE_DETAIL_ID = :CAUSE_DETAIL_ID,
           A.PROBLEM_DEC     = :PROBLEM_DESC,
           A.FIRST_DEPT_ID   = :FIRST_DEPT_ID,
           A.SECOND_DEPT_ID  = :SECOND_DEPT_ID,
           A.MEMO            = :MEMO,
           A.MERCHER_ID      = :MERCHER_ID,
           A.QC_ID          = :QC_ID,
           A.QC_DIRECTOR_ID = V_QC_DIRECTOR_ID,
           A.UPDATE_ID      = :USER_ID,
           A.UPDATE_TIME    = SYSDATE
     WHERE A.RELA_GOO_ID = :RELA_GOO_ID
       AND A.COMPANY_ID = %DEFAULT_COMPANY_ID%
       AND A.EXG_ID = :EXG_ID
       AND A.RM_ID = :RM_ID;
       END;';
        
     END IF;
   RETURN V_SQL;
END;   

 FUNCTION F_CHECK_APP_BUY(PI_COMPANY_ID      IN VARCHAR2,
                         PI_APPLY_ID        IN VARCHAR2,
                         PI_TYPE         IN NUMBER
                         ) RETURN VARCHAR2
is
v_result       varchar2(200);
v_apply_status sys_group_apply.apply_status%type;
v_is_company   sys_group_apply.is_company%type;
v_i            int;
v_apply_name   sys_group_apply.apply_name%type;
v_apply_id     sys_company_apply.apply_id%type;
v_end_time     date;

begin
  --1.应用校验
  select max(a.apply_status),max(a.pause),max(a.is_company),max(a.apply_name)
    into v_apply_status,v_i,v_is_company,v_apply_name
    from scmdata.sys_group_apply a 
   where a.apply_id=pi_apply_id ;
   if v_apply_name is null then 
     v_result:='未找到该应用，无法购买/续订，请刷新窗口再操作';
     return v_result;
   end if;
   if v_i =1 then 
     v_result:='应用'''||v_apply_name||'''已被禁用，请刷新窗口再操作';
     return v_result;
   end if;
   if v_apply_status<>'0' then
     v_result:='应用'''||v_apply_name||'''已被下架，请刷新窗口再操作';
     return v_result; 
   end if;
   if v_is_company <>1 then 
     v_result:=''''||v_apply_name||'''非企业应用，无法购买，请前往个人中心应用商城购买';
     return v_result; 
   end if;
  if pi_type not in (1,2) then
    v_result:='传入的操作类型无法识别，请确认后重新调用';
    return v_result;
  end if;

  --2.企业应用校验：
   select max(a.apply_id)
     into v_apply_id
     from scmdata.sys_company_apply a
    where a.apply_id=pi_apply_id
      and a.company_id=PI_COMPANY_ID;
      
   select  max(a.end_time)
     into v_end_time
     from scmdata.sys_company_apply_buylog a
    where a.apply_id=PI_APPLY_ID and a.company_id=PI_COMPANY_ID;
  if PI_TYPE=1 then
    if v_apply_id is not null then 
      v_result:='应用'''||v_apply_name||'''已购买，无法再次购买';
    end if;
  elsif pi_type=2 then
    if v_apply_id is  null then 
      v_result:='应用'''||v_apply_name||'''未购买，无法续订';
    else 
      if  trunc(v_end_time)=date'2099-12-31' then
        v_result:=''''||v_apply_name||'''是免费应用，无法续订';
      end if;
    end if;
  else
     v_result:='传入的操作类型无法识别，请确认后重新调用';
  end if;
   
  return v_result;
end;
 


  PROCEDURE P_APP_BUY_FOR_SUPP(PI_USER_ID      IN VARCHAR2,
                             PI_COMPANY_ID   IN VARCHAR2,
                             PI_TYPE         IN NUMBER,
                             PO_RESULT       OUT NUMBER,
                             PO_MESSAGE      OUT VARCHAR2)
is
begin
  for item in (select * from SCMDATA.sys_group_apply a where a.APPLY_BELONG in (/*0,*/4) order by a.sort) loop
    po_message:=SCMDATA.PKG_DYY_TEST.F_CHECK_APP_BUY(PI_COMPANY_ID,item.apply_id,PI_TYPE);
    if po_message is not null then
      po_result:=-1;
      return;
    end if;
    
    insert into scmdata.sys_company_apply(company_apply_id,company_id,apply_id,sort,expired_time)
     values(f_get_uuid(),PI_COMPANY_ID,item.apply_id,1,date'2099-12-31');
     --现阶段都是免费，暂不支持收费模式
    insert into scmdata.sys_company_apply_buylog(apply_buylog_id,company_id,apply_id,apply_name,tips,apply_buylog_type,
                                         unit,num,price,pay_price,start_time,end_time,create_id,create_time)
    values(f_get_uuid(),PI_COMPANY_ID,item.apply_id,item.apply_name,null,'新增','个',1,0,0,sysdate,date'2099-12-31',PI_USER_ID,sysdate);
  end loop;
  exception when others then
    PO_RESULT:=-2;
    PO_MESSAGE:=(RTRIM(substrb('PACKAGE_ERROR:'||SQLERRM||':PKG_COMPANY_MANAGE.P_APP_BUY_FOR_SUPP:'||to_char(SQLCODE), 1, 255)));
END P_APP_BUY_FOR_SUPP;

  


        
  --注册企业
  PROCEDURE P_register_company(pi_user_id     in varchar2,
                               pi_logo        in varchar,
                               pi_name        in varchar2,
                               pi_logn_name   in varchar2,
                               pi_LICENCE_NUM in varchar2,
                               pi_tips        in varchar2,
                               po_result      out number,
                               po_msg         out varchar2) is
    p_id      varchar2(32);
    p_role_id varchar2(50);
    p_user    scmdata.sys_user%rowtype;
  begin
    po_result := 0;
    p_id      := F_get_uuid();
    
   /* if pkg_check_data_comm.f_check_logn_name(pi_logn_name)=0 then
      po_result := -1;
      po_msg    := '根据中国大陆相关法规，企业全称应只包含中文和括号！';
      return;
    end if;
    
    if F_check_licence_num(pi_LICENCE_NUM) = 0 then
      po_result := -1;
      po_msg    := '请输入18位正确的社会统一信用代码！';
      return;
    end if;*/
    
    
    --创建scmdata.sys_company
    insert into scmdata.sys_company
      (company_id,
       company_name,
       pause,
       logo,
       tips,
       licence_num,
       logn_name,
       is_open,
       attributor_id,
       create_time,
       update_id,
       update_time,
       id_status,
       company_role)
    values
      (p_id,
       pi_name,
       0,
       pi_logo,
       pi_tips,
       pi_licence_num,
       pi_logn_name,
       1,
       pi_user_id,
       sysdate,
       pi_user_id,
       sysdate,
       '0',
       'mrpp');
    if sql%rowcount <> 1 then
      po_result := -1;
      po_msg    := '新增企业信息失败！请联系管理员';
      return;
    end if;
    --创建scmdata.sys_user_company
    insert into scmdata.sys_user_company
      (company_id,
       user_id,
       user_company_id,
       is_default,
       company_alias,
       sort,
       pause,
       join_time)
    values
      (p_id, pi_user_id, F_get_uuid(), 0, pi_name, 1, 0, sysdate);
    if sql%rowcount <> 1 then
      po_result := -1;
      po_msg    := '关联企业与用户失败！请联系管理员';
      return;
    end if;
    --创建scmdata.sys_company_user
    select * into p_user from scmdata.sys_user where user_id = pi_user_id;
    insert into scmdata.sys_company_user
      (company_user_id,
       company_id,
       user_id,
       sort,
       nick_name,
       company_user_name,
       sex,
       pause,
       email,
       phone,
       update_id,
       update_time,
       nationality,
       id_card,
       education,
       profession,
       language,
       birth_place,
       household_TYPE,
       marriage,
       residence_address,
       living_address,
       emergency_name,
       emergency_contact,
       emergency_phone,
       self_evaluation)
    values
      (f_get_uuid(),
       p_id,
       pi_user_id,
       1,
       p_user.nick_name,
       nvl(p_user.username,p_user.nick_name),
       p_user.sex,
       0,
       p_user.email,
       p_user.phone,
       pi_user_id,
       sysdate,
       p_user.nationality,
       p_user.id_card,
       p_user.education,
       p_user.profession,
       p_user.language,
       p_user.birth_place,
       p_user.household_TYPE,
       p_user.marriage,
       p_user.residence_address,
       p_user.living_address,
       p_user.emergency_name,
       p_user.emergency_contact,
       p_user.emergency_phone,
       p_user.self_evaluation);
    if sql%rowcount <> 1 then
      po_result := -1;
      po_msg    := '新增企业用户失败！请联系管理员';
      return;
    end if;
    --获取触发器生成的企业拥有者id
    select max(company_role_id)
      into p_role_id
      from scmdata.sys_company_role
     where company_id = p_id
       and company_role_name = '超级管理员';
    --将企业拥有者权限增加给该用户
    insert into scmdata.sys_company_user_role
      (company_user_role_id, company_id, user_id, company_role_id)
    values
      (f_get_uuid(), p_id, pi_user_id, p_role_id);
    if sql%rowcount <> 1 then
      po_result := -1;
      po_msg    := '增加用户权限失败！请联系管理员';
      return;
    end if;
    --关联面料供应商档案，关联统一信用代码相同的公司
    update MRP.MRP_DETERMINE_SUPPLIER_ARCHIVES t
       set t.supplier_company_id = p_id
     where t.unified_social_credit_code = pi_LICENCE_NUM ;
     
    /*--自动将应用包赋值给供应方 2021-11-22 hx87
     \* pi_type = 1 第三个参数，代表新增应用*\
     SCMDATA.PKG_COMPANY_MANAGE.P_APP_BUY_FOR_SUPP(PI_USER_ID,p_id ,1,po_result,po_msg);*/  
     SCMDATA.PKG_DYY_TEST.P_APP_BUY_FOR_SUPP(PI_USER_ID,p_id ,1,po_result,po_msg);
     --新增应用
     
  exception
    when Dup_val_on_index then
      begin
        po_result := -1;
        po_msg    := '全称或统一信用代码已被注册！';
        return;
      end;
      
      
  end P_register_company;
  
  FUNCTION f_getkeycode(pi_table_name  VARCHAR2, --表名  例：MRP.SUPPLIER_COLOR_INVENTORY
                        pi_column_name VARCHAR2, --单号列名 例：INVENTORY_CODE
                        pi_pre         VARCHAR2, --前缀  例：CKPD20230223
                        pi_serail_num  NUMBER    --序号位数 例 5
                        ) RETURN VARCHAR2 IS
    --流水号长度
    /*    pi_table_name  VARCHAR2(250) := 't_supplier_info'; 
    pi_column_name VARCHAR2(250) := 'supplier_code'; 
    pi_company_id  VARCHAR2(250) := 'a972dd1ffe3b3a10e0533c281cac8fd7'; 
    pi_pre         VARCHAR2(250) := 'C'; 
    pi_serail_num  NUMBER := 5;*/
    --p_length INT;
    p_id     NUMBER(38);
    p_sql    VARCHAR2(4000);
    p_result VARCHAR2(50);
    --V_SQL  VARCHAR2(4000);
  BEGIN
    /*SELECT MAX(decode(data_type, 'NUMBER', data_precision, data_length))
      INTO p_length
      FROM user_tab_columns
     WHERE table_name = upper(pi_table_name)
       AND column_name = upper(pi_column_name);*/
  
    --dbms_output.put_line(p_length);
   
    p_sql := 'SELECT nvl(MAX(v.tcode), 0)
  FROM (SELECT DISTINCT MAX(to_number(substr(' ||
             pi_column_name || ',
                                             nvl(length(''' ||
             pi_pre ||
             '''), 0) + 1,
                                             length(''' ||
             pi_column_name || ''')))) over(PARTITION BY substr(' ||
             pi_column_name || ', 0, nvl(length(''' || pi_pre ||
             '''), 0))) tcode
          FROM ' || pi_table_name || ' 
         WHERE ' || pi_column_name || ' IS NOT NULL
           AND substr(' || pi_column_name ||
             ', 0, nvl(length(''' || pi_pre || '''), 0)) = ''' || pi_pre || '''
           AND regexp_like(substr(' || pi_column_name || ',
                                  nvl(length(''' || pi_pre ||
             '''), 0) + 1,
                                  length(''' || pi_column_name ||
             ''')),' || '''^[0-9]+[0-9]$''' || ')) v ';
  
    dbms_output.put_line(p_sql);
  
    EXECUTE IMMEDIATE p_sql
      INTO p_id;
  
    /*IF (length(pi_pre) +
       length(lpad(to_char(p_id + 1), pi_serail_num, '0'))) > p_length THEN
      dbms_output.put_line('超出字段長度');
      raise_application_error(-20002, SQLERRM);
    END IF;*/
  
    p_result := pi_pre || lpad(to_char(p_id + 1), pi_serail_num, '0');
  
    /*dbms_output.put_line(pi_pre ||
    lpad(to_char(p_id + 1), pi_serail_num, '0'));*/
  
    RETURN p_result;
    /*dbms_output.put_line(pi_pre ||
    lpad(to_char(p_id + 1), pi_serail_num, '0'));*/
  
  EXCEPTION
    WHEN OTHERS THEN
      --dbms_output.put_line(p_sql);
      raise_application_error(-20002, SQLERRM);
      RETURN NULL;
  END f_getkeycode;

 FUNCTION f_query_material_detail(pi_material_id IN VARCHAR2,
                                 -- pi_supp_id     IN VARCHAR2,
                                  pi_type        IN VARCHAR2,
                                  pi_is_inner    IN VARCHAR2,
                                  --pi_comp_id     IN VARCHAR2,
                                  pi_supp_code   IN VARCHAR2 ) RETURN CLOB
                                  
      IS 
  v_s_sql CLOB;
  v_f_sql CLOB;
  V_W_SQL CLOB;
  v_sql   CLOB;
  BEGIN 
    V_S_SQL :=q'[SELECT M.SUPPLIER_NAME  MATERIAL_SUPP_NAME, 
    M.MATERIAL_NAME,
    M.material_classification,
    M.UNIT, ]'|| CASE WHEN pi_type = 'SKU' THEN 'M.MATERIAL_COLOR' ELSE NULL end ||q'[
    M.PRACTICAL_DOOR_WITH, 
    M.GRAM_WEIGHT,
    M.MATERIAL_SPECIFICATIONS,
    M.MATERIAL_INGREDIENT,
    M.FILE_UNIQUE,
    M.SUPPLIER_MATERIAL_NAME,]'||CASE WHEN pi_type = 'SKU' THEN ' M.SUPPLIER_COLOR,
    M.SUPPLIER_SHADES, ' ELSE NULL END ||q'[ M.SUPPLIER_CODE, ]'||
    CASE WHEN pi_is_inner = 0 THEN ' ''否'' IS_INNER_MATERIAL ' WHEN pi_is_inner = 1 THEN ' ''是'' IS_INNER_MATERIAL 'END  ;
    
    IF pi_type = 'SKU' THEN 
      V_F_SQL :=q'[ (SELECT Z.MATERIAL_SKU,
       Z.MATERIAL_COLOR,
       Y.MATERIAL_NAME,
       X.SUPPLIER_MATERIAL_NAME,
       X.SUPPLIER_COLOR,
       y.material_classification,
       V.FILE_UNIQUE,
       (SELECT LISTAGG(T.INGREDIENT, ';') WITHIN GROUP(ORDER BY T.MATERIAL_SPU)
          FROM (SELECT A.MATERIAL_SPU,
                       T1.COMPANY_DICT_NAME || A.INGREDIENT_PROPORTION ||
                       A.PROPORTION_UNIT INGREDIENT
                  FROM MRP.MRP_OUTSIDE_MATERIAL_SPU_INGREDIENT_MAPPING A
                 INNER JOIN SCMDATA.SYS_COMPANY_DICT T1
                    ON A.MATERIAL_INGREDIENT_ID = T1.COMPANY_DICT_ID) T
         WHERE T.MATERIAL_SPU = Y.MATERIAL_SPU) MATERIAL_INGREDIENT,
       Y.MATERIAL_SPECIFICATIONS,
       Y.PRACTICAL_DOOR_WITH,
       Y.GRAM_WEIGHT,
       X.DISPARITY,
       Y.UNIT,
       W.SUPPLIER_NAME,
       W.BUSINESS_CONTACT,
       W.CONTACT_PHONE,
       W.DETAILED_ADDRESS,
       Z.PREFERRED_NET_PRICE_OF_LARGE_GOOD,
       Z.PREFERRED_PER_METER_PRICE_OF_LARGE_GOOD,
       X.SUPPLIER_SHADES,
       w.SUPPLIER_CODE
    FROM MRP.MRP_OUTSIDE_MATERIAL_SKU Z
   INNER JOIN MRP.MRP_OUTSIDE_MATERIAL_SPU Y
      ON Z.MATERIAL_SPU = Y.MATERIAL_SPU
   INNER JOIN MRP.MRP_OUTSIDE_SUPPLIER_MATERIAL X
      ON Z.MATERIAL_SKU = X.MATERIAL_SKU
   INNER JOIN MRP.MRP_TEMPORARY_SUPPLIER_ARCHIVES W
      ON W.SUPPLIER_CODE = X.SUPPLIER_CODE
   LEFT JOIN  (SELECT A.THIRDPART_ID,
                    A.FILE_UNIQUE,
                    ROW_NUMBER() OVER(PARTITION BY A.THIRDPART_ID ORDER BY A.UPLOAD_TIME DESC) AS RN
               FROM MRP.MRP_PICTURE A
              WHERE  A.PICTURE_TYPE = 1) V
    ON V.THIRDPART_ID = y.FEATURES
   AND V.RN = 1
    UNION ALL
    SELECT z.material_sku,
           Y.MATERIAL_COLOR,
       x.material_name,
       Z.SUPPLIER_MATERIAL_NAME,
       z.supplier_color,
       x.MATERIAL_CLASSIFICATION,
       V.FILE_UNIQUE,
       (SELECT LISTAGG(T.INGREDIENT, ';') WITHIN GROUP(ORDER BY T.MATERIAL_SPU)
          FROM (SELECT A.MATERIAL_SPU,
                       T1.COMPANY_DICT_NAME || A.INGREDIENT_PROPORTION ||
                       A.PROPORTION_UNIT INGREDIENT
                  FROM MRP.MRP_MATERIAL_SPU_INGREDIENT_MAPPING A
                 INNER JOIN SCMDATA.SYS_COMPANY_DICT T1
                    ON A.MATERIAL_INGREDIENT_ID = T1.COMPANY_DICT_ID) T
                   WHERE T.MATERIAL_SPU=X.MATERIAL_SPU) MATERIAL_INGR,
       x.material_specifications,
        x.practical_door_with,
        x.gram_weight,
       z.disparity,
       x.unit,
       w.SUPPLIER_ABBREVIATION SUPPLIER_NAME,
       w.BUSINESS_CONTACT,
       w.CONTACT_PHONE,
       w.DETAILED_ADDRESS,
       y.preferred_net_price_of_large_good,
      y.preferred_per_meter_price_of_large_good,
      z.supplier_shades,
      w.supplier_code
FROM mrp.MRP_INTERNAL_SUPPLIER_MATERIAL z
INNER JOIN mrp.mrp_internal_material_sku y ON z.material_sku=y.material_sku
INNER JOIN mrp.mrp_internal_material_spu x ON y.material_spu=x.material_spu
INNER JOIN mrp.mrp_determine_supplier_archives W  ON w.SUPPLIER_CODE=z.supplier_code
LEFT JOIN (SELECT A.THIRDPART_ID,
                    A.FILE_UNIQUE,
                    ROW_NUMBER() OVER(PARTITION BY A.THIRDPART_ID ORDER BY A.UPLOAD_TIME DESC) AS RN
               FROM MRP.MRP_PICTURE A
              WHERE  A.PICTURE_TYPE = 1) V
    ON V.THIRDPART_ID = x.FEATURES
   AND V.RN = 1) M ]';
   V_W_SQL :=q'[ WHERE M.MATERIAL_SKU= ']'||pi_material_id||q'[' AND M.SUPPLIER_CODE =']'||pi_supp_code||''' ' ;
   
    ELSIF pi_type = 'SPU' THEN 
      V_F_SQL :=q'[ (SELECT W.SUPPLIER_NAME,
                    W.SUPPLIER_CODE, 
                    Z.MATERIAL_SPU, 
                    Z.UNIT,  
                    Z.MATERIAL_NAME, 
                    Z.MATERIAL_CLASSIFICATION, 
                    V.FILE_UNIQUE,  
       (SELECT LISTAGG(T.INGREDIENT, ';') WITHIN GROUP(ORDER BY T.MATERIAL_SPU)
          FROM (SELECT A.MATERIAL_SPU,
                       T1.COMPANY_DICT_NAME || A.INGREDIENT_PROPORTION ||
                       A.PROPORTION_UNIT INGREDIENT
                  FROM MRP.MRP_OUTSIDE_MATERIAL_SPU_INGREDIENT_MAPPING A
                 INNER JOIN SCMDATA.SYS_COMPANY_DICT T1
                    ON A.MATERIAL_INGREDIENT_ID = T1.COMPANY_DICT_ID) T
         WHERE T.MATERIAL_SPU = Z.MATERIAL_SPU) MATERIAL_INGREDIENT, 
                    Z.PRACTICAL_DOOR_WITH, 
                    Z.GRAM_WEIGHT, 
                    Z.MATERIAL_SPECIFICATIONS, 
                    X.SUPPLIER_MATERIAL_NAME 
               FROM MRP.MRP_OUTSIDE_MATERIAL_SPU Z
              INNER JOIN (SELECT Y.MATERIAL_SPU, X.SUPPLIER_CODE,
                                X.CREATE_FINISHED_SUPPLIER_CODE,
                                MAX(X.SUPPLIER_MATERIAL_NAME) SUPPLIER_MATERIAL_NAME
                           FROM MRP.MRP_OUTSIDE_MATERIAL_SKU Y
                          INNER JOIN MRP.MRP_OUTSIDE_SUPPLIER_MATERIAL X
                             ON X.MATERIAL_SKU = Y.MATERIAL_SKU
                          GROUP BY Y.MATERIAL_SPU, X.SUPPLIER_CODE,
                                   X.CREATE_FINISHED_SUPPLIER_CODE) X
                 ON Z.MATERIAL_SPU = X.MATERIAL_SPU
              INNER JOIN MRP.MRP_TEMPORARY_SUPPLIER_ARCHIVES W
                 ON W.SUPPLIER_CODE = X.SUPPLIER_CODE
               LEFT JOIN  (SELECT A.THIRDPART_ID,
                    A.FILE_UNIQUE,
                    ROW_NUMBER() OVER(PARTITION BY A.THIRDPART_ID ORDER BY A.UPLOAD_TIME DESC) AS RN
               FROM MRP.MRP_PICTURE A
              WHERE  A.PICTURE_TYPE = 1) V
    ON V.THIRDPART_ID = Z.FEATURES
   AND V.RN = 1  
             UNION
             SELECT W.SUPPLIER_ABBREVIATION SUPPLIER_NAME,
                    X.SUPPLIER_CODE, 
                    Z.MATERIAL_SPU, 
                    Z.UNIT,  
                    Z.MATERIAL_NAME,
                    Z.MATERIAL_CLASSIFICATION, 
                    V.FILE_UNIQUE,
       (SELECT LISTAGG(T.INGREDIENT, ';') WITHIN GROUP(ORDER BY T.MATERIAL_SPU)
          FROM (SELECT A.MATERIAL_SPU,
                       T1.COMPANY_DICT_NAME || A.INGREDIENT_PROPORTION ||
                       A.PROPORTION_UNIT INGREDIENT
                  FROM MRP.MRP_OUTSIDE_MATERIAL_SPU_INGREDIENT_MAPPING A
                 INNER JOIN SCMDATA.SYS_COMPANY_DICT T1
                    ON A.MATERIAL_INGREDIENT_ID = T1.COMPANY_DICT_ID) T
         WHERE T.MATERIAL_SPU = Z.MATERIAL_SPU) MATERIAL_INGREDIENT,
                    Z.PRACTICAL_DOOR_WITH,
                    Z.GRAM_WEIGHT,
                    Z.MATERIAL_SPECIFICATIONS,
                    X.SUPPLIER_MATERIAL_NAME 
               FROM MRP.MRP_INTERNAL_MATERIAL_SPU Z
              INNER JOIN (SELECT R.MATERIAL_SPU, R.SUPPLIER_CODE,
                                MAX(R.SUPPLIER_MATERIAL_NAME) SUPPLIER_MATERIAL_NAME
                           FROM (SELECT Y.MATERIAL_SPU, X.SUPPLIER_CODE,
                                         X.SUPPLIER_MATERIAL_NAME
                                    FROM MRP.MRP_INTERNAL_MATERIAL_SKU Y
                                   INNER JOIN MRP.MRP_INTERNAL_SUPPLIER_MATERIAL X
                                      ON X.MATERIAL_SKU = Y.MATERIAL_SKU) R
                          GROUP BY R.MATERIAL_SPU, R.SUPPLIER_CODE) X
                 ON X.MATERIAL_SPU = Z.MATERIAL_SPU
              INNER JOIN MRP.MRP_DETERMINE_SUPPLIER_ARCHIVES W
                 ON W.SUPPLIER_CODE = X.SUPPLIER_CODE
             LEFT JOIN (SELECT A.THIRDPART_ID,
                    A.FILE_UNIQUE,
                    ROW_NUMBER() OVER(PARTITION BY A.THIRDPART_ID ORDER BY A.UPLOAD_TIME DESC) AS RN
               FROM MRP.MRP_PICTURE A
              WHERE  A.PICTURE_TYPE = 1) V
    ON V.THIRDPART_ID = Z.FEATURES
   AND V.RN = 1) M ]';
   V_W_SQL :=q'[WHERE M.MATERIAL_SPU=']'||pi_material_id||q'[' AND M.SUPPLIER_CODE=']'||pi_supp_code||''' ';
    END IF;
  v_sql :=v_s_sql||v_f_sql||v_w_sql;
  RETURN v_sql;  
    
  END f_query_material_detail;  
  
  PROCEDURE p_upd_suppstock(v_id IN VARCHAR2,
                          v_num IN NUMBER,
                          v_type IN VARCHAR2,--区分成品还是物料
                          V_mode IN VARCHAR2  --区分spu还是sku
                          )
  IS 
  --V_ORI_NUM NUMBER;
  V_NEW_TOTAL NUMBER;
  V_SQL VARCHAR2(4000); --查询总量sql
  V_SQL1 VARCHAR2(4000);  --更新sql
  BEGIN
   IF v_type ='CP' THEN 
     V_SQL:=q'[SELECT SUPPLIER_STOCK + ]'||v_num||q'[ FROM ]'||CASE WHEN V_MODE ='SKU' THEN ' MRP.SUPPLIER_COLOR_CLOTH_STOCK '
     WHEN V_MODE = 'SPU'THEN ' MRP.SUPPLIER_GREY_STOCK ' END ||' WHERE COLOR_CLOTH_STOCK_ID ='''||v_id||'''';
     DBMS_OUTPUT.put_line(V_SQL);
     EXECUTE IMMEDIATE V_SQL INTO V_NEW_TOTAL;
     
     
     V_SQL1:='UPDATE '||CASE WHEN V_MODE ='SKU' THEN ' MRP.SUPPLIER_COLOR_CLOTH_STOCK '
     WHEN V_MODE = 'SPU'THEN ' MRP.SUPPLIER_GREY_STOCK ' END ||' SET T.SUPPLIER_STOCK='||V_NEW_TOTAL||' WHERE COLOR_CLOTH_STOCK_ID ='''||v_id||'''';
     --EXECUTE IMMEDIATE V_SQL1;
     DBMS_OUTPUT.put_line(V_SQL1);
   
   ELSIF v_type ='WL' THEN 
     V_SQL:=q'[SELECT SUPPLIER_STOCK + ]'||v_num||q'[ FROM ]'||CASE WHEN V_MODE ='SKU' THEN ' MRP.MATERIAL_COLOR_CLOTH_STOCK '
     WHEN V_MODE = 'SPU'THEN ' MRP.MATERIAL_GREY_STOCK ' END ||' WHERE COLOR_CLOTH_STOCK_ID ='''||v_id||'''';
     EXECUTE IMMEDIATE V_SQL INTO V_NEW_TOTAL;
     DBMS_OUTPUT.put_line(V_SQL);
     
     V_SQL1:='UPDATE '||CASE WHEN V_MODE ='SKU' THEN ' MRP.MATERIAL_COLOR_CLOTH_STOCK '
     WHEN V_MODE = 'SPU'THEN ' MRP.MATERIAL_GREY_STOCK ' END ||' SET T.SUPPLIER_STOCK='||V_NEW_TOTAL||' WHERE COLOR_CLOTH_STOCK_ID ='''||v_id||'''';
     --EXECUTE IMMEDIATE V_SQL1;
     DBMS_OUTPUT.put_line(V_SQL1);
   
    END IF;
  END  p_upd_suppstock;                      

    FUNCTION F_GET_CPSELECT_INVENTORY(PI_TYPE IN VARCHAR2) RETURN CLOB
   IS
   
  V_S_SQL CLOB;
  --V_F_SQL CLOB;
  --V_SQL CLOB;
  BEGIN
     V_S_SQL:=q'[SELECT (CASE A.INVENTORY_TYPE
         WHEN 1 THEN
          '仓库全盘'
         WHEN 2 THEN
          '部分盘点'
       END) INVENTORY_TYPE, 
       A.INVENTORY_CODE, 
       (CASE A.STOCK_TYPE
         WHEN 1 THEN  '品牌仓'
         WHEN 2 THEN  '供应商仓'
         WHEN 3 THEN '品牌仓/供应商仓' END) STOCK_TYPE, 
       A.CREATE_TIME INVENTORY_CRETIME, --盘点创建时间
       A.END_TIME INVENTORY_ENDTIME, --盘点结束时间
       A.REMARKS INVENTORY_MEMO, --盘点备注
       NVL(B.USERNAME,B.NICK_NAME)  INVENTORY_CHECKER, --盘点人
       (SELECT LISTAGG(Y.LOGN_NAME, ';') WITHIN GROUP(ORDER BY 1)
          FROM SCMDATA.SYS_USER_COMPANY Z
          LEFT JOIN SCMDATA.SYS_COMPANY Y
            ON Z.COMPANY_ID = Y.COMPANY_ID
         WHERE Z.USER_ID = A.CREATE_ID
           AND Y.PAUSE = 0
           AND Y.COMPANY_ID=C.SUPPLIER_COMPANY_ID) INVENTORY_PARTY ]' || CASE WHEN pi_type=0 THEN ' FROM MRP.SUPPLIER_COLOR_INVENTORY A '
           WHEN pi_type = 1 THEN ' FROM MRP.SUPPLIER_GREY_INVENTORY A ' END ||q'[ INNER JOIN SCMDATA.SYS_USER B
    ON A.CREATE_ID = B.USER_ID
 INNER JOIN SCMDATA.T_SUPPLIER_INFO C ON A.PRO_SUPPLIER_CODE=C.SUPPLIER_INFO_ID 
 WHERE A.WHETHER_DEL=0 
   AND A.PRO_SUPPLIER_CODE=(SELECT T.SUPPLIER_INFO_ID
                              FROM SCMDATA.T_SUPPLIER_INFO T WHERE T.SUPPLIER_COMPANY_ID=%DEFAULT_COMPANY_ID%
                               AND T.COMPANY_ID='a972dd1ffe3b3a10e0533c281cac8fd7')
   AND A.COMPANY_ID='a972dd1ffe3b3a10e0533c281cac8fd7'   ]' ;       
  --DBMS_OUTPUT.put_line(V_S_SQL);
  RETURN V_S_SQL;
  END F_GET_CPSELECT_INVENTORY;                               

  PROCEDURE P_REGISTER_MATERIALSUP(P_SUPCODE IN VARCHAR2) IS 
   
   p_user     MRP.MRP_DETERMINE_SUPPLIER_ARCHIVES%rowtype;
   p_u        int;
   p_logo     varchar2(32);
   p_user_id  varchar2(32);
   p_result   varchar2(128);
   p_msg      varchar2(128);                              
BEGIN
  
  --获取该供应商等级、简称、全称、联系电话、社信代
    SELECT *
      INTO p_user
      FROM MRP.MRP_DETERMINE_SUPPLIER_ARCHIVES A
   WHERE a.supplier_code=P_SUPCODE ;
   
   IF p_user.cooperation_level = 'A' THEN 
    select nvl(max(1), 0)
      into p_u
      from scmdata.sys_user u
     where u.user_account =p_user.CONTACT_PHONE;
    
    if p_u=0 then 
  --用户手机注册
  scmdata.pkg_plat_comm.p_user_register(pi_moblie =>p_user.CONTACT_PHONE, pi_uuid =>NULL, pi_devicesystem =>NULL );
     END IF;
     
     select max(user_id)
      into p_user_id
      from scmdata.sys_user a
     where a.user_account = p_user.CONTACT_PHONE;
    --修改初始密码 
    update scmdata.sys_user a
       set a.password = '496d234c7d6f6f7a422d634747632d4273616173422d6d05'
     where a.user_id = p_user_id;
     
     --修改用户名称
     update scmdata.sys_user a
       set a.username = ltrim(RTRIM(p_user.SUPPLIER_ABBREVIATION)), a.nick_name = ltrim(RTRIM(p_user.SUPPLIER_ABBREVIATION))
     where a.user_id = p_user_id;
   
    p_logo := '1';
    --企业注册
   scmdata.pkg_user_my_company.p_register_company(pi_user_id     => p_user_id,
                                                  pi_logo        => p_logo,
                                                  pi_name        => ltrim(RTRIM(p_user.SUPPLIER_ABBREVIATION)),
                                                  pi_logn_name   => ltrim(rtrim(p_user.SUPPLIER_NAME)),
                                                  pi_LICENCE_NUM => ltrim(rtrim(p_user.UNIFIED_SOCIAL_CREDIT_CODE)),
                                                  pi_tips        => ltrim(RTRIM(p_user.SUPPLIER_ABBREVIATION)),
                                                  po_result      => p_result,
                                                  po_msg         => p_msg,pi_company_role => 'mrpp');
                                                  
   IF scmdata.pkg_user_default_company.f_count_user_company(p_user_id) = 1 THEN
      scmdata.pkg_user_default_company.p_user_company_default_when_user_change(p_user_id,
                                                                               p_result,
                                                                               p_msg);
   END IF;                                                                                                                            
  ELSE
    NULL;
  END IF;  

END P_REGISTER_MATERIALSUP;  

PROCEDURE p_get_params(pi_source_id IN VARCHAR2,
                       pi_target_id IN VARCHAR2,
                       pi_key       IN VARCHAR2,
                       po_methods   OUT VARCHAR2,
                       po_param     OUT VARCHAR2) IS
  v_param CLOB;
  vo_methods VARCHAR2(512);
  vo_param CLOB;
BEGIN
  SELECT t.tamout,t.tmoney INTO vo_methods,v_param
    FROM SCMDATA.TEST_TOP20_DYY t
    WHERE t.tyear=pi_source_id
      AND t.tmonth=pi_target_id;
      
    vo_param:=scmdata.pkg_plat_comm.f_parse_json(p_jsonstr => v_param, p_key =>pi_key  ) ;
   po_methods :=vo_methods;
   po_param:=vo_param;
END p_get_params;

END PKG_DYY_TEST;
/

