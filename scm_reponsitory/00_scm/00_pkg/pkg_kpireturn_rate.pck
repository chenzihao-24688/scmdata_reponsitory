CREATE OR REPLACE PACKAGE SCMDATA.PKG_KPIRETURN_RATE IS

  -- Author  : DYY153
  -- Created : 2022/5/9 15:38:26
  -- Purpose : 获取kpi退货率数据


  /*------------------------分部----------------------------------------------
   V_METHOD ： 0  全部历史数据
              1 只更新上一个维度（月份、季度、半年度、年度）的数据
   V_TYPE  ： 0 更新全部指标
              1  更新门店退货和进货数据
              2  更新仓库退货数据

  --------------------------------------------------------------------------     */

  --时间维度：月度
  PROCEDURE P_GETDATA_KPIRTCATE_MONTH(V_METHOD IN NUMBER, V_TYPE IN NUMBER);

  --时间维度 ：季度
  PROCEDURE P_GETDATA_KPIRTCATE_QUARTER(V_METHOD IN NUMBER,
                                        V_TYPE   IN NUMBER);

  --时间维度 ：半年度
  PROCEDURE P_GETDATA_KPIRTCATE_HAIFYEAR(V_METHOD IN NUMBER,
                                         V_TYPE   IN NUMBER);

  --时间维度 ：年度
  PROCEDURE P_GETDATA_KPIRTCATE_YEAR(V_METHOD IN NUMBER, V_TYPE IN NUMBER);


  /*---------------------------------------------------------------------------
  对象：
      P_RTKPI_THISMONTH
  统计维度：
      分类、区域组、款式名称、产品子类、供应商、跟单、跟单主管、qc、qc主管
  时间维度：
      本月
  用途：
      多维度指标查询本月数据表（T_RTKPI_THISMONTH）
  更新规则：
      每天晚上凌晨4点半更新前一天的数据
  p_type参数解析
       p_type = 0 更新全部历史数据
       p_type = 1 只更新上一个维度（月份）的数据
  -----------------------------------------------------------------------------*/
  PROCEDURE P_RTKPI_THISMONTH(P_TYPE NUMBER);

  PROCEDURE P_RTKPI_MONTH(P_TYPE NUMBER);
  PROCEDURE P_RTKPI_QUARTER(P_TYPE NUMBER);
  PROCEDURE P_RTKPI_HALFYEAR(P_TYPE NUMBER);
  PROCEDURE P_RTKPI_YEAR(P_TYPE NUMBER);
  FUNCTION F_GET_159_SELECTSQL(KPI_TIMETYPE       VARCHAR2,
                               KPI_TIME           VARCHAR2,
                               KPI_DIMENSION      VARCHAR2,
                               KPI_GROUP          VARCHAR2,
                               KPI_CATEGORY       VARCHAR2,
                               P_CLASS_DATA_PRIVS CLOB,
                               COMPANY_ID         VARCHAR2) RETURN CLOB;

  FUNCTION F_KPI_159_1_CAPTIONSQL (V_STRING VARCHAR2, V_ID VARCHAR2) RETURN CLOB;

   FUNCTION F_KPI_159_1_SELECTSQL(V_TIME       VARCHAR2,
                              V_DIMENSION  VARCHAR2,
                              V_SORT       VARCHAR2,
                              V_GROUP      VARCHAR2,
                              V_CATEGORY   VARCHAR2,
                              V_COMPANY_ID VARCHAR2) RETURN CLOB;
    PROCEDURE P_GET_RTDATA;

END PKG_KPIRETURN_RATE;
/

CREATE OR REPLACE PACKAGE BODY SCMDATA.PKG_KPIRETURN_RATE IS

  /*==================================================================
  kpi t_kpireturn_month表数据更新

    V_METHOD 更新类型，0更新全部历史数据，1更新上月数据
    V_TYPE  指标类型

  ===================================================================*/
  PROCEDURE P_GETDATA_KPIRTCATE_MONTH(V_METHOD IN NUMBER, V_TYPE IN NUMBER) IS
    V_SQL     CLOB;
    V_WH_SQL2 CLOB;
    V_EXSQL   CLOB;
    V_WM_SQL1 CLOB;
    V_U_SQL2  VARCHAR(2000);
    V_U1_SQL2 VARCHAR(2000);
    V_U2_SQL2 VARCHAR(2000);
    V_I_SQL3  VARCHAR(2000);
  BEGIN
    V_SQL := 'MERGE INTO SCMDATA.t_kpireturn_cate_rate_month G
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
                FROM SCMDATA.T_INGOOD A
               INNER JOIN SCMDATA.T_INGOODS B
                  ON A.ING_ID = B.ING_ID
                 AND A.COMPANY_ID = B.COMPANY_ID
               INNER JOIN SCMDATA.T_COMMODITY_INFO C
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
       c.category,
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
           END)*c.price) WHRT_MONEY
 FROM scmdata.t_qa_report a
 INNER JOIN scmdata.t_qa_scope b ON a.qa_report_id=b.qa_report_id AND a.company_id=b.company_id
 INNER JOIN scmdata.t_commodity_info c ON a.goo_id=c.goo_id AND a.company_id=c.company_id
 WHERE a.status IN (''N_ACF'', ''R_ACF'')
 GROUP BY a.company_id,
       EXTRACT(YEAR FROM B.COMMIT_TIME),
       EXTRACT(MONTH FROM B.COMMIT_TIME),
       c.category
) x ON x.company_id=Y.COMPANY_ID AND x.YEAR=y.year AND x.month=y.month AND x.category=y.category
    LEFT JOIN SCMDATA.SYS_GROUP_DICT w ON w.GROUP_DICT_VALUE=Z.CATEGORY AND w.GROUP_DICT_TYPE=''PRODUCT_TYPE''';
    --上一个月的数据
    V_WM_SQL1 := q'[
              WHERE (Z.YEAR||LPAD(Z.MONTH,2,0)) = TO_CHAR(ADD_MONTHS(SYSDATE,-1),'yyyymm')) H
                ON (G.COMPANY_ID=H.COMPANY_ID AND G.year =H.YEAR AND G.quarter =H.quarter AND G.month =H.MONTH AND G.category = H.CATEGORY AND G.category_name =H.GROUP_DICT_NAME）
               WHEN MATCHED THEN ]';

    --全部历史数据
    V_WH_SQL2 := q'[
                WHERE (Z.YEAR||LPAD(Z.MONTH,2,0)) < TO_CHAR(SYSDATE,'YYYYMM') AND (Z.YEAR||LPAD(Z.MONTH,2,0)) >= '202112') H
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
                 H.RETURN_AMOUNT,H.return_money,H.WHRT_AMOUNT,H.whrt_money,'ADMIN',SYSDATE,h.halfyear)
                 ]';

    -- V_TYPE = 0 更新全部指标
    IF V_TYPE = 0 THEN

      IF V_METHOD = 0 THEN
        --更新全部历史数据
        V_EXSQL := V_SQL || V_WH_SQL2 || V_U_SQL2 || V_I_SQL3;

      ELSIF V_METHOD = 1 THEN
        --更新上月数据
        V_EXSQL := V_SQL || V_WM_SQL1 || V_U_SQL2 || V_I_SQL3;
      END IF;

      --V_TYPE = 1 更新门店退货(只更新不插入）
    ELSIF V_TYPE = 1 THEN
      IF V_METHOD = 0 THEN
        V_EXSQL := V_SQL || V_WH_SQL2 || V_U1_SQL2;

      ELSIF V_METHOD = 1 THEN
        V_EXSQL := V_SQL || V_WM_SQL1 || V_U1_SQL2;
      END IF;

      --V_TYPE = 2 更新仓库退货
    ELSIF V_TYPE = 2 THEN
      IF V_METHOD = 0 THEN
        V_EXSQL := V_SQL || V_WH_SQL2 || V_U2_SQL2;
      ELSIF V_METHOD = 1 THEN
        V_EXSQL := V_SQL || V_WM_SQL1 || V_U2_SQL2;
      END IF;

    END IF;

    EXECUTE IMMEDIATE V_EXSQL;
    --DBMS_OUTPUT.put_line(V_EXSQL);

  END P_GETDATA_KPIRTCATE_MONTH;

  PROCEDURE P_GETDATA_KPIRTCATE_QUARTER(V_METHOD IN NUMBER,
                                        V_TYPE   IN NUMBER) IS
    V_SQL     CLOB;
    V_WH_SQL2 CLOB;
    V_EXSQL   CLOB;
    V_WQ_SQL1 CLOB;
    V_U_SQL2  VARCHAR(2000);
    V_U1_SQL2 VARCHAR(2000);
    V_U2_SQL2 VARCHAR(2000);
    V_I_SQL3  VARCHAR(2000);

  BEGIN
    V_SQL := 'MERGE INTO SCMDATA.T_KPIRETURN_CATE_RATE_QUARTER A
      USING ( SELECT Z.COMPANY_ID,
              Z.YEAR,
              Z.QUARTER,
              Z.CATEGORY,W.GROUP_DICT_NAME,
              Y.ORDER_AMOUNT,Y.ORDER_MONEY,
              Z.RETURN_AMOUNT,
              Z.RETURN_MONEY,
              X.WHRT_AMOUNT,
              X.WHRT_MONEY
   FROM (SELECT A.COMPANY_ID,
                A.YEAR,
                A.QUARTER,
                B.CATEGORY,
                SUM(A.EXAMOUNT) RETURN_AMOUNT,
                SUM(A.EXAMOUNT * B.PRICE) RETURN_MONEY
           FROM (SELECT P.* FROM SCMDATA.T_RETURN_MANAGEMENT P WHERE (P.YEAR||LPAD(P.MONTH,2,0)) >= ''202112'') A
          INNER JOIN SCMDATA.T_COMMODITY_INFO B
             ON A.GOO_ID = B.GOO_ID
            AND A.COMPANY_ID = B.COMPANY_ID
           LEFT JOIN SCMDATA.SYS_COMPANY_DEPT C
             ON A.FIRST_DEPT_ID = C.COMPANY_DEPT_ID
            AND A.COMPANY_ID = C.COMPANY_ID
          WHERE A.AUDIT_TIME IS NOT NULL
            AND C.DEPT_NAME = ''供应链管理部''
          GROUP BY A.COMPANY_ID, A.YEAR,A.QUARTER,  B.CATEGORY) Z
   LEFT JOIN (SELECT A.COMPANY_ID,
                     EXTRACT(YEAR FROM A.CREATE_TIME) YEAR,
                     --EXTRACT(MONTH FROM A.CREATE_TIME) MONTH,
                     TO_CHAR(A.CREATE_TIME,''Q'') QUARTER,
                     C.CATEGORY,
                     SUM(B.AMOUNT) ORDER_AMOUNT,
                     SUM(B.AMOUNT * C.PRICE) ORDER_MONEY
                FROM SCMDATA.T_INGOOD A
               INNER JOIN SCMDATA.T_INGOODS B
                  ON A.ING_ID = B.ING_ID
                 AND A.COMPANY_ID = B.COMPANY_ID
               INNER JOIN SCMDATA.T_COMMODITY_INFO C
                  ON C.GOO_ID = B.GOO_ID
                 AND A.COMPANY_ID = C.COMPANY_ID
               WHERE B.AMOUNT > 0
               GROUP BY A.COMPANY_ID,
                        EXTRACT(YEAR FROM A.CREATE_TIME),
                        TO_CHAR(A.CREATE_TIME,''Q''),
                        C.CATEGORY) Y
     ON Z.COMPANY_ID = Y.COMPANY_ID
    AND Z.YEAR = Y.YEAR
    AND Z.QUARTER = Y.QUARTER
    AND Z.CATEGORY = Y.CATEGORY
    LEFT JOIN (SELECT A.COMPANY_ID,
       EXTRACT(YEAR FROM B.COMMIT_TIME) YEAR,
       --EXTRACT(MONTH FROM B.COMMIT_TIME) MONTH,
       TO_CHAR(B.COMMIT_TIME,''Q'') QUARTER,
       C.CATEGORY,
       SUM((CASE
             WHEN A.CHECK_RESULT = ''UQ'' AND B.PROCESSING_TYPE = ''NM'' THEN
              B.SUBS_AMOUNT
              WHEN A.CHECK_RESULT = ''UQ'' AND B.PROCESSING_TYPE =''RT''OR B.PROCESSING_TYPE = ''RJ'' THEN B.PCOME_AMOUNT
              WHEN A.CHECK_RESULT =''QU'' THEN B.SUBS_AMOUNT
           END)) WHRT_AMOUNT,
      SUM((CASE
             WHEN A.CHECK_RESULT = ''UQ'' AND B.PROCESSING_TYPE = ''NM'' THEN
              B.SUBS_AMOUNT
              WHEN A.CHECK_RESULT = ''UQ'' AND B.PROCESSING_TYPE =''RT''OR B.PROCESSING_TYPE = ''RJ'' THEN B.PCOME_AMOUNT
              WHEN A.CHECK_RESULT =''QU'' THEN B.SUBS_AMOUNT
           END)*C.PRICE) WHRT_MONEY
 FROM SCMDATA.T_QA_REPORT A
 INNER JOIN SCMDATA.T_QA_SCOPE B ON A.QA_REPORT_ID=B.QA_REPORT_ID AND A.COMPANY_ID=B.COMPANY_ID
 INNER JOIN SCMDATA.T_COMMODITY_INFO C ON A.GOO_ID=C.GOO_ID AND A.COMPANY_ID=C.COMPANY_ID
 WHERE A.STATUS IN (''N_ACF'', ''R_ACF'')
 GROUP BY A.COMPANY_ID,
       EXTRACT(YEAR FROM B.COMMIT_TIME),
       TO_CHAR(B.COMMIT_TIME,''Q''),
       C.CATEGORY
) X ON X.COMPANY_ID=Y.COMPANY_ID AND X.YEAR=Y.YEAR AND X.QUARTER=Y.QUARTER AND X.CATEGORY=Y.CATEGORY
    LEFT JOIN SCMDATA.SYS_GROUP_DICT W ON W.GROUP_DICT_VALUE=Z.CATEGORY AND W.GROUP_DICT_TYPE=''PRODUCT_TYPE''';

    --上一季度
    V_WQ_SQL1 := '
               WHERE (Z.YEAR||Z.QUARTER) =(to_char(add_months(sysdate,-3),''yyyy'')||to_char(add_months(sysdate,-3),''q''))) H
               ON ( H.COMPANY_ID = A.COMPANY_ID AND H.YEAR=A.YEAR AND H.QUARTER = A.QUARTER AND H.CATEGORY = A.CATEGORY )
               WHEN MATCHED THEN ';

    --历史数据
    V_WH_SQL2 := '
               WHERE (Z.YEAR||Z.QUARTER) <=(to_char(add_months(sysdate,-3),''yyyy'')||to_char(add_months(sysdate,-3),''q'')) ) H
               ON ( H.COMPANY_ID = A.COMPANY_ID AND H.YEAR=A.YEAR AND H.QUARTER = A.QUARTER AND H.CATEGORY = A.CATEGORY )
               WHEN MATCHED THEN ';

    --全部字段更新
    V_U_SQL2 := q'[ UPDATE
                     SET A.INGOOD_AMOUNT = H.ORDER_AMOUNT,
                         A.INGOOD_MONEY  = H.ORDER_MONEY,
                         A.SHOP_RT_AMOUNT= H.RETURN_AMOUNT,
                         A.SHOP_RT_MONEY = H.RETURN_MONEY,
                         A.WAREHOUSE_RT_AMOUNT = H.WHRT_AMOUNT,
                         A.WAREHOUSE_RT_MONEY  = H.WHRT_MONEY,
                         A.UPDATE_ID     = 'ADMIN',
                         A.UPDATE_TIME   = SYSDATE  ]';

    --更新退货和进货
    V_U1_SQL2 := q'[ UPDATE
                      SET A.INGOOD_AMOUNT = H.ORDER_AMOUNT,
                          A.INGOOD_MONEY  = H.ORDER_MONEY,
                          A.SHOP_RT_AMOUNT= H.RETURN_AMOUNT,
                          A.SHOP_RT_MONEY = H.RETURN_MONEY,
                          A.UPDATE_ID     = 'ADMIN',
                          A.UPDATE_TIME   = SYSDATE  ]';

    --更新仓库
    V_U2_SQL2 := q'[ UPDATE
                       SET A.WAREHOUSE_RT_AMOUNT = H.WHRT_AMOUNT,
                           A.WAREHOUSE_RT_MONEY  = H.WHRT_MONEY,
                           A.UPDATE_ID     = 'ADMIN',
                           A.UPDATE_TIME   = SYSDATE   ]';

    --插入
    V_I_SQL3 := q'[
                  WHEN NOT MATCHED THEN
                    INSERT (KPIRTRQ_ID,COMPANY_ID,YEAR,QUARTER,CATEGORY,CATEGORY_NAME,INGOOD_AMOUNT,INGOOD_MONEY,SHOP_RT_AMOUNT,SHOP_RT_MONEY,WAREHOUSE_RT_AMOUNT,WAREHOUSE_RT_MONEY,CREATE_ID,CREATE_TIME)
                  VALUES( SCMDATA.F_GET_UUID(),H.COMPANY_ID,H.YEAR,H.QUARTER,H.CATEGORY,H.GROUP_DICT_NAME,H.ORDER_AMOUNT,H.ORDER_MONEY,H.RETURN_AMOUNT,H.RETURN_MONEY,H.WHRT_AMOUNT,H.WHRT_MONEY,'ADMIN',SYSDATE) ]';

    -- V_TYPE = 0 更新全部指标
    IF V_TYPE = 0 THEN

      IF V_METHOD = 0 THEN
        --更新全部历史数据
        V_EXSQL := V_SQL || V_WH_SQL2 || V_U_SQL2 || V_I_SQL3;

      ELSIF V_METHOD = 1 THEN
        --更新上一季度数据
        V_EXSQL := V_SQL || V_WQ_SQL1 || V_U_SQL2 || V_I_SQL3;
      END IF;

      --V_TYPE = 1 更新门店退货(只更新不插入）
    ELSIF V_TYPE = 1 THEN
      IF V_METHOD = 0 THEN
        V_EXSQL := V_SQL || V_WH_SQL2 || V_U1_SQL2;

      ELSIF V_METHOD = 1 THEN
        V_EXSQL := V_SQL || V_WQ_SQL1 || V_U1_SQL2;
      END IF;

      --V_TYPE = 2 更新仓库退货
    ELSIF V_TYPE = 2 THEN
      IF V_METHOD = 0 THEN
        V_EXSQL := V_SQL || V_WH_SQL2 || V_U2_SQL2;
      ELSIF V_METHOD = 1 THEN
        V_EXSQL := V_SQL || V_WQ_SQL1 || V_U2_SQL2;
      END IF;

    END IF;
    EXECUTE IMMEDIATE V_EXSQL;
    --DBMS_OUTPUT.put_line(V_EXSQL);

  END P_GETDATA_KPIRTCATE_QUARTER;

  PROCEDURE P_GETDATA_KPIRTCATE_HAIFYEAR(V_METHOD IN NUMBER,
                                         V_TYPE   IN NUMBER) IS
    V_SQL      CLOB;
    V_WH_SQL2  CLOB;
    V_EXSQL    CLOB;
    V_WHF_SQL1 CLOB;
    V_U_SQL2   VARCHAR(2000);
    V_U1_SQL2  VARCHAR(2000);
    V_U2_SQL2  VARCHAR(2000);
    V_I_SQL3   VARCHAR(2000);

  BEGIN
    V_SQL := 'MERGE INTO SCMDATA.T_KPIRETURN_CATE_RATE_HALFYEAR A
      USING(
       SELECT Z.COMPANY_ID,
              Z.YEAR,
              Z.halfyear,
              Z.CATEGORY,w.GROUP_DICT_NAME,
              Y.ORDER_AMOUNT,Y.order_money,
              Z.RETURN_AMOUNT,
              Z.return_money,
              X.WHRT_AMOUNT,
              x.whrt_money
   FROM (SELECT A.COMPANY_ID,
                A.YEAR,
                DECODE(A.quarter,1,''1'',2,''1'',3,''2'',4,''2'') halfyear,
                --A.QUARTER,
                B.CATEGORY,
                SUM(A.EXAMOUNT) RETURN_AMOUNT,
                SUM(A.EXAMOUNT * B.PRICE) return_money
           FROM (SELECT * FROM scmdata.T_RETURN_MANAGEMENT P WHERE (P.YEAR||LPAD(P.MONTH,2,0)) >= ''202112'') A
          INNER JOIN scmdata.T_COMMODITY_INFO B
             ON A.GOO_ID = B.GOO_ID
            AND A.COMPANY_ID = B.COMPANY_ID
           LEFT JOIN scmdata.SYS_COMPANY_DEPT C
             ON A.FIRST_DEPT_ID = C.COMPANY_DEPT_ID
            AND A.COMPANY_ID = C.COMPANY_ID
          WHERE A.AUDIT_TIME IS NOT NULL
            AND C.DEPT_NAME = ''供应链管理部''
          GROUP BY A.COMPANY_ID, A.YEAR,DECODE(A.quarter,1,''1'',2,''1'',3,''2'',4,''2''),  B.CATEGORY) Z
   LEFT JOIN (SELECT A.COMPANY_ID,
                     EXTRACT(YEAR FROM A.CREATE_TIME) YEAR,
                     --EXTRACT(MONTH FROM A.CREATE_TIME) MONTH,
                     DECODE(to_char(a.CREATE_TIME,''q''), 1,''1'',2,''1'',3,''2'',4,''2'') HALFYEAR,
                     C.CATEGORY,
                     SUM(B.AMOUNT) ORDER_AMOUNT,
                     SUM(B.AMOUNT * C.PRICE) order_money
                FROM scmdata.T_INGOOD A
               INNER JOIN scmdata.T_INGOODS B
                  ON A.ING_ID = B.ING_ID
                 AND A.COMPANY_ID = B.COMPANY_ID
               INNER JOIN scmdata. T_COMMODITY_INFO C
                  ON C.GOO_ID = B.GOO_ID
                 AND A.COMPANY_ID = C.COMPANY_ID
               WHERE B.AMOUNT > 0
               GROUP BY A.COMPANY_ID,
                        EXTRACT(YEAR FROM A.CREATE_TIME),
                        DECODE(to_char(a.CREATE_TIME,''q''), 1,''1'',2,''1'',3,''2'',4,''2''),
                        C.CATEGORY) Y
     ON Z.COMPANY_ID = Y.COMPANY_ID
    AND Z.YEAR = Y.YEAR
    AND Z.halfyear = Y.halfyear
    AND Z.CATEGORY = Y.CATEGORY
    LEFT JOIN (SELECT a.company_id,
       EXTRACT(YEAR FROM B.COMMIT_TIME) YEAR,
       --EXTRACT(MONTH FROM B.COMMIT_TIME) MONTH,
       DECODE (TO_CHAR(B.COMMIT_TIME,''q''),1,''1'',2,''1'',3,''2'',4,''2'') HALFYEAR,
       c.category,
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
           END)*c.price) WHRT_MONEY
 FROM scmdata.t_qa_report a
 INNER JOIN scmdata.t_qa_scope b ON a.qa_report_id=b.qa_report_id AND a.company_id=b.company_id
 INNER JOIN scmdata.t_commodity_info c ON a.goo_id=c.goo_id AND a.company_id=c.company_id
 WHERE a.status IN (''N_ACF'', ''R_ACF'')
 GROUP BY a.company_id,
       EXTRACT(YEAR FROM B.COMMIT_TIME),
       DECODE (TO_CHAR(B.COMMIT_TIME,''q''),1,''1'',2,''1'',3,''2'',4,''2''),
       c.category
) x ON x.company_id=Y.COMPANY_ID AND x.YEAR=y.year AND x.HALFYEAR=y.HALFYEAR AND x.category=y.category
    LEFT JOIN SCMDATA.SYS_GROUP_DICT w ON w.GROUP_DICT_VALUE=Z.CATEGORY AND w.GROUP_DICT_TYPE=''PRODUCT_TYPE''';

    --上一半年度
    V_WHF_SQL1 := '
              where (z.YEAR||z.halfyear) = pkg_kpipt_order.f_yearmonth ) H
              ON ( H.COMPANY_ID = A.COMPANY_ID AND H.YEAR=A.YEAR AND H.HALFYEAR = A.HALFYEAR AND H.CATEGORY = A.CATEGORY )
               WHEN MATCHED THEN ';

    --历史数据
    V_WH_SQL2 := '
              where (z.YEAR||z.halfyear) <= pkg_kpipt_order.f_yearmonth ) H
              ON ( H.COMPANY_ID = A.COMPANY_ID AND H.YEAR=A.YEAR AND H.HALFYEAR = A.HALFYEAR AND H.CATEGORY = A.CATEGORY )
               WHEN MATCHED THEN ';

    --全部字段更新
    V_U_SQL2 := q'[
                UPDATE
                   SET A.INGOOD_AMOUNT = H.ORDER_AMOUNT,
                       A.INGOOD_MONEY  = H.ORDER_MONEY,
                       A.SHOP_RT_AMOUNT = H.RETURN_AMOUNT,
                       A.SHOP_RT_MONEY  = H.RETURN_MONEY,
                       A.WAREHOUSE_RT_AMOUNT = H.WHRT_AMOUNT,
                       A.WAREHOUSE_RT_MONEY  =H.WHRT_MONEY,
                       A.UPDATE_ID     = 'ADMIN',
                       A.UPDATE_TIME   = SYSDATE   ]';

    --更新门店退货进货数
    V_U1_SQL2 := q'[
                UPDATE
                   SET A.INGOOD_AMOUNT = H.ORDER_AMOUNT,
                       A.INGOOD_MONEY  = H.ORDER_MONEY,
                       A.SHOP_RT_AMOUNT = H.RETURN_AMOUNT,
                       A.SHOP_RT_MONEY  = H.RETURN_MONEY,
                       A.UPDATE_ID     = 'ADMIN',
                       A.UPDATE_TIME   = SYSDATE     ]';

    --更新仓库退货数
    V_U2_SQL2 := q'[  UPDATE
                      SET A.WAREHOUSE_RT_AMOUNT = H.WHRT_AMOUNT,
                          A.WAREHOUSE_RT_MONEY  =H.WHRT_MONEY,
                          A.UPDATE_ID     = 'ADMIN',
                          A.UPDATE_TIME   = SYSDATE   ]';

    --插入数据
    V_I_SQL3 := q'[
                  WHEN NOT MATCHED THEN
                    INSERT (KPIRTRH_ID,COMPANY_ID,YEAR,HALFYEAR,CATEGORY,CATEGORY_NAME,INGOOD_AMOUNT,INGOOD_MONEY,
                            SHOP_RT_AMOUNT,SHOP_RT_MONEY,WAREHOUSE_RT_AMOUNT, WAREHOUSE_RT_MONEY, CREATE_ID, CREATE_TIME)
                    VALUES(SCMDATA.F_GET_UUID(),H.COMPANY_ID,H.YEAR,H.HALFYEAR,H.CATEGORY,H.GROUP_DICT_NAME,
                           H.ORDER_AMOUNT,H.ORDER_MONEY,H.RETURN_AMOUNT,H.RETURN_MONEY,H.WHRT_AMOUNT,H.WHRT_MONEY,'ADMIN',SYSDATE)]';

    -- V_TYPE = 0 更新全部指标
    IF V_TYPE = 0 THEN

      IF V_METHOD = 0 THEN
        --更新全部历史数据
        V_EXSQL := V_SQL || V_WH_SQL2 || V_U_SQL2 || V_I_SQL3;

      ELSIF V_METHOD = 1 THEN
        --更新上一半年数据
        V_EXSQL := V_SQL || V_WHF_SQL1 || V_U_SQL2 || V_I_SQL3;
      END IF;

      --V_TYPE = 1 更新门店退货(只更新不插入）
    ELSIF V_TYPE = 1 THEN
      IF V_METHOD = 0 THEN
        V_EXSQL := V_SQL || V_WH_SQL2 || V_U1_SQL2;

      ELSIF V_METHOD = 1 THEN
        V_EXSQL := V_SQL || V_WHF_SQL1 || V_U1_SQL2;
      END IF;

      --V_TYPE = 2 更新仓库退货
    ELSIF V_TYPE = 2 THEN
      IF V_METHOD = 0 THEN
        V_EXSQL := V_SQL || V_WH_SQL2 || V_U2_SQL2;
      ELSIF V_METHOD = 1 THEN
        V_EXSQL := V_SQL || V_WHF_SQL1 || V_U2_SQL2;
      END IF;

    END IF;
    EXECUTE IMMEDIATE V_EXSQL;
    --DBMS_OUTPUT.put_line(V_EXSQL);

  END P_GETDATA_KPIRTCATE_HAIFYEAR;

  PROCEDURE P_GETDATA_KPIRTCATE_YEAR(V_METHOD IN NUMBER, V_TYPE IN NUMBER) IS
    V_SQL     CLOB;
    V_WH_SQL2 CLOB;
    V_EXSQL   CLOB;
    V_WY_SQL1 CLOB;
    V_U_SQL2  VARCHAR(2000);
    V_U1_SQL2 VARCHAR(2000);
    V_U2_SQL2 VARCHAR(2000);
    V_I_SQL3  VARCHAR(2000);

  BEGIN
    V_SQL := 'MERGE INTO SCMDATA.T_KPIRETURN_CATE_RATE_YEAR A
           USING (SELECT Z.COMPANY_ID,
              Z.YEAR,
              Z.CATEGORY,w.GROUP_DICT_NAME,
              Y.ORDER_AMOUNT,Y.order_money,
              Z.RETURN_AMOUNT,
              Z.return_money,
              X.WHRT_AMOUNT,
              x.whrt_money
   FROM (SELECT A.COMPANY_ID,
                A.YEAR,
                B.CATEGORY,
                SUM(A.EXAMOUNT) RETURN_AMOUNT,
                SUM(A.EXAMOUNT * B.PRICE) return_money
           FROM ( SELECT * FROM scmdata.T_RETURN_MANAGEMENT P WHERE (P.YEAR||LPAD(P.MONTH,2,0)) >= ''202112'') A
          INNER JOIN scmdata.T_COMMODITY_INFO B
             ON A.GOO_ID = B.GOO_ID
            AND A.COMPANY_ID = B.COMPANY_ID
           LEFT JOIN scmdata.SYS_COMPANY_DEPT C
             ON A.FIRST_DEPT_ID = C.COMPANY_DEPT_ID
            AND A.COMPANY_ID = C.COMPANY_ID
          WHERE A.AUDIT_TIME IS NOT NULL
            AND C.DEPT_NAME = ''供应链管理部''
          GROUP BY A.COMPANY_ID, A.YEAR,  B.CATEGORY) Z
   LEFT JOIN (SELECT A.COMPANY_ID,
                     EXTRACT(YEAR FROM A.CREATE_TIME) YEAR,
                     C.CATEGORY,
                     SUM(B.AMOUNT) ORDER_AMOUNT,
                     SUM(B.AMOUNT * C.PRICE) order_money
                FROM scmdata.T_INGOOD A
               INNER JOIN scmdata.T_INGOODS B
                  ON A.ING_ID = B.ING_ID
                 AND A.COMPANY_ID = B.COMPANY_ID
               INNER JOIN scmdata. T_COMMODITY_INFO C
                  ON C.GOO_ID = B.GOO_ID
                 AND A.COMPANY_ID = C.COMPANY_ID
               WHERE B.AMOUNT > 0
               GROUP BY A.COMPANY_ID,
                        EXTRACT(YEAR FROM A.CREATE_TIME),
                        C.CATEGORY) Y
     ON Z.COMPANY_ID = Y.COMPANY_ID
    AND Z.YEAR = Y.YEAR
    AND Z.CATEGORY = Y.CATEGORY
    LEFT JOIN (SELECT a.company_id,
       EXTRACT(YEAR FROM B.COMMIT_TIME) YEAR,
       c.category,
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
           END)*c.price) WHRT_MONEY
 FROM scmdata.t_qa_report a
 INNER JOIN scmdata.t_qa_scope b ON a.qa_report_id=b.qa_report_id AND a.company_id=b.company_id
 INNER JOIN scmdata.t_commodity_info c ON a.goo_id=c.goo_id AND a.company_id=c.company_id
 WHERE a.status IN (''N_ACF'', ''R_ACF'')
 GROUP BY a.company_id,
       EXTRACT(YEAR FROM B.COMMIT_TIME),
       c.category
) x ON x.company_id=Y.COMPANY_ID
AND x.YEAR=y.year
AND x.category=y.category
    LEFT JOIN SCMDATA.SYS_GROUP_DICT w ON w.GROUP_DICT_VALUE=Z.CATEGORY AND w.GROUP_DICT_TYPE=''PRODUCT_TYPE''';

    --历史数据
    V_WH_SQL2 := q'[  where z.YEAR < to_char(sysdate,'yyyy') ) H
                   ON ( A.COMPANY_ID = H.COMPANY_ID AND A.YEAR = H.YEAR AND A.CATEGORY = H.CATEGORY )
                  WHEN MATCHED THEN  ]';

    --上一年数据
    V_WY_SQL1 := q'[ where z.year = to_char(sysdate,'yyyy')) H
                   ON ( A.COMPANY_ID = H.COMPANY_ID AND A.YEAR = H.YEAR AND A.CATEGORY = H.CATEGORY )
                  WHEN MATCHED THEN   ]';

    --更新全部数据
    V_U_SQL2 := q'[  UPDATE
                       SET A.INGOOD_AMOUNT = H.ORDER_AMOUNT,
                           A.INGOOD_MONEY  = H.ORDER_MONEY,
                           A.SHOP_RT_AMOUNT = H.RETURN_AMOUNT,
                           A.SHOP_RT_MONEY  = H.RETURN_MONEY,
                           A.WAREHOUSE_RT_AMOUNT = H.WHRT_AMOUNT,
                           A.WAREHOUSE_RT_MONEY  =H.WHRT_MONEY,
                           A.UPDATE_ID     = 'ADMIN',
                           A.UPDATE_TIME   = SYSDATE   ]';

    --更新门店退货进货数
    V_U1_SQL2 := q'[
                UPDATE
                   SET A.INGOOD_AMOUNT = H.ORDER_AMOUNT,
                       A.INGOOD_MONEY  = H.ORDER_MONEY,
                       A.SHOP_RT_AMOUNT = H.RETURN_AMOUNT,
                       A.SHOP_RT_MONEY  = H.RETURN_MONEY,
                       A.UPDATE_ID     = 'ADMIN',
                       A.UPDATE_TIME   = SYSDATE     ]';

    --更新仓库退货数
    V_U2_SQL2 := q'[  UPDATE
                      SET A.WAREHOUSE_RT_AMOUNT = H.WHRT_AMOUNT,
                          A.WAREHOUSE_RT_MONEY  =H.WHRT_MONEY,
                          A.UPDATE_ID     = 'ADMIN',
                          A.UPDATE_TIME   = SYSDATE   ]';

    V_I_SQL3 := q'[  WHEN NOT MATCHED THEN
               INSERT (KPIRTRY_ID, COMPANY_ID, YEAR, CATEGORY, CATEGORY_NAME, INGOOD_AMOUNT,INGOOD_MONEY, SHOP_RT_AMOUNT, SHOP_RT_MONEY, WAREHOUSE_RT_AMOUNT,
                        WAREHOUSE_RT_MONEY, CREATE_ID, CREATE_TIME )
               VALUES(SCMDATA.F_GET_UUID(),H.COMPANY_ID,H.YEAR,  H.CATEGORY,H.GROUP_DICT_NAME,
                           H.ORDER_AMOUNT,H.ORDER_MONEY,H.RETURN_AMOUNT,H.RETURN_MONEY,H.WHRT_AMOUNT,H.WHRT_MONEY,'ADMIN',SYSDATE)]';

    -- V_TYPE = 0 更新全部指标
    IF V_TYPE = 0 THEN

      IF V_METHOD = 0 THEN
        --更新全部历史数据
        V_EXSQL := V_SQL || V_WH_SQL2 || V_U_SQL2 || V_I_SQL3;

      ELSIF V_METHOD = 1 THEN
        --更新上一半年数据
        V_EXSQL := V_SQL || V_WY_SQL1 || V_U_SQL2 || V_I_SQL3;
      END IF;

      --V_TYPE = 1 更新门店退货(只更新不插入）
    ELSIF V_TYPE = 1 THEN
      IF V_METHOD = 0 THEN
        V_EXSQL := V_SQL || V_WH_SQL2 || V_U1_SQL2;

      ELSIF V_METHOD = 1 THEN
        V_EXSQL := V_SQL || V_WY_SQL1 || V_U1_SQL2;
      END IF;

      --V_TYPE = 2 更新仓库退货
    ELSIF V_TYPE = 2 THEN
      IF V_METHOD = 0 THEN
        V_EXSQL := V_SQL || V_WH_SQL2 || V_U2_SQL2;
      ELSIF V_METHOD = 1 THEN
        V_EXSQL := V_SQL || V_WY_SQL1 || V_U2_SQL2;
      END IF;

    END IF;
    EXECUTE IMMEDIATE V_EXSQL;
    --DBMS_OUTPUT.put_line(V_EXSQL);

  END P_GETDATA_KPIRTCATE_YEAR;



  /*---------------------------------------------------------------------------
  对象：
      P_RTKPI_THISMONTH
  统计维度：
      分类、区域组、款式名称、产品子类、供应商、跟单、跟单主管、qc、qc主管
  时间维度：
      本月
  用途：
      多维度指标查询本月数据表（T_RTKPI_THISMONTH）
  更新规则：
      每天晚上凌晨4点半更新前一天的数据
  p_type参数解析
       p_type = 0 更新全部历史数据
       p_type = 1 只更新上一个维度（月份）的数据
  -----------------------------------------------------------------------------*/
  PROCEDURE P_RTKPI_THISMONTH(P_TYPE NUMBER) IS
    V_SQL1     CLOB;
    V_SQL2     CLOB;
    V_WH_SQL2 CLOB; --全部历史数据
    V_EXSQL1   CLOB;
    V_EXSQL2   CLOB;
    V_WM_SQL1 CLOB; --上一时间维度
     V_U_SQL1  CLOB := q'[ update
                           set a.INGOOD_MONEY           =tkb.INGOOD_MONEY,
                               a.update_id              = 'ADMIN',
                               a.update_time            = sysdate
                 ]';
    V_U_SQL2  CLOB := q'[ update
                           set a.SHOP_RT_MONEY          = tkb.SHOP_RT_MONEY,
                               a.SHOP_RT_ORIGINAL_MONEY = tkb.SHOP_RT_ORIGINAL_MONEY,
                               a.update_id              = 'ADMIN',
                               a.update_time            = sysdate
                 ]';
    V_I_SQL1  CLOB := q'[
    WHEN NOT MATCHED THEN
      INSERT (A.t_rtkpi_tm_id,a.company_id,a.year,a.month,a.rtkpi_date,a.category,a.groupname,a.count_dimension,a.dimension_sort,a.ingood_money,a.create_id,a.create_time,a.update_id,a.update_time)
      values (scmdata.f_get_uuid(),
         tkb.company_id,
         tkb.year,
         tkb.month,
         tkb.rtkpi_date,
         tkb.category,
         tkb.group_name,
         tkb.count_dimension,
         tkb.dimension_sort,
         tkb.INGOOD_MONEY,
         'ADMIN',sysdate,'ADMIN',sysdate) ]';

    V_I_SQL2  CLOB := q'[
    WHEN NOT MATCHED THEN
      INSERT (A.t_rtkpi_tm_id,a.company_id,a.year,a.month,a.rtkpi_date,a.category,a.groupname,a.count_dimension,a.dimension_sort,a.shop_rt_money,a.shop_rt_original_money,a.create_id,a.create_time,a.update_id,a.update_time)
      values (scmdata.f_get_uuid(),
         tkb.company_id,
         tkb.year,
         tkb.month,
         tkb.rtkpi_date,
         tkb.category,
         tkb.group_name,
         tkb.count_dimension,
         tkb.dimension_sort,
         tkb.SHOP_RT_MONEY,
         tkb.SHOP_RT_ORIGINAL_MONEY,
         'ADMIN',sysdate,'ADMIN',sysdate) ]';

  BEGIN

    --全部历史数据
    V_WH_SQL2 := q'[
       WHERE to_date(y.RTKPI_DATE,'yyyy-mm-dd') < trunc(sysdate,'dd') and y.year>=2023
          ) tkb
          ON (tkb.company_id = a.company_id AND tkb.year = a.year AND tkb.month=a.month AND tkb.rtkpi_date = a.rtkpi_date AND tkb.category=a.category
           AND tkb.group_name = a.groupname AND tkb.count_dimension =a.count_dimension AND tkb.dimension_sort =a.dimension_sort  )
           when matched then ]';

    --上一时间维度
    V_WM_SQL1 := q'[
      where to_date(y.RTKPI_DATE,'yyyy-mm-dd') < trunc(sysdate,'dd')
        and to_date(y.RTKPI_DATE,'yyyy-mm-dd') >= trunc(sysdate,'mm')) tkb
      ON (tkb.company_id = a.company_id AND tkb.year = a.year AND tkb.month=a.month AND tkb.rtkpi_date = a.rtkpi_date AND tkb.category=a.category
           AND tkb.group_name = a.groupname AND tkb.count_dimension =a.count_dimension AND tkb.dimension_sort =a.dimension_sort  )
           when matched then ]';
    --分类维度
    V_SQL1:=q'[MERGE INTO SCMDATA.T_RTKPI_THISMONTH A
             USING (SELECT Y.COMPANY_ID, y.YEAR, y.MONTH, to_date(y.RTKPI_DATE,'yyyy-mm-dd') RTKPI_DATE, y.CATEGORY,
              y.GROUP_NAME, y.COUNT_DIMENSION, y.DIMENSION_SORT,
              Y.ORDER_MONEY INGOOD_MONEY
          FROM  (SELECT A.COMPANY_ID, EXTRACT(YEAR FROM A.CREATE_TIME) YEAR,
                       EXTRACT(MONTH FROM A.CREATE_TIME) MONTH,
                       TO_CHAR(A.CREATE_TIME, 'yyyy-mm-dd') RTKPI_DATE,
                       E.CATEGORY,
                       (CASE WHEN D.GROUP_NAME IS NULL THEN '1' ELSE D.GROUP_NAME END) GROUP_NAME,
                       '00' COUNT_DIMENSION,
                       E.CATEGORY DIMENSION_SORT,
                       SUM(A.AMOUNT * E.PRICE) ORDER_MONEY
                  FROM (SELECT T.DOCUMENT_NO,
                    T.COMPANY_ID,
                    TRUNC(T.CREATE_TIME) CREATE_TIME,
                    SUM(TL.AMOUNT) AMOUNT,
                    TL.GOO_ID
               FROM SCMDATA.T_INGOOD T
              INNER JOIN (SELECT TI.ING_ID,
                                TI.COMPANY_ID,
                                TI.GOO_ID,
                                TI.AMOUNT
                           FROM SCMDATA.T_INGOODS TI
                          WHERE TI.AMOUNT > 0) TL
                 ON TL.ING_ID = T.ING_ID
                AND TL.COMPANY_ID = T.COMPANY_ID
              WHERE TO_CHAR(T.CREATE_TIME, 'yyyy') >= 2022
              GROUP BY T.DOCUMENT_NO,
                       T.COMPANY_ID,
                       TRUNC(T.CREATE_TIME),
                       TL.GOO_ID) A
                  /*SCMDATA.T_INGOOD A
                 INNER JOIN SCMDATA.T_INGOODS B
                    ON A.ING_ID = B.ING_ID
                   AND A.COMPANY_ID = B.COMPANY_ID
                 LEFT JOIN SCMDATA.T_ORDERED C
                    ON C.ORDER_CODE = A.DOCUMENT_NO
                   AND A.COMPANY_ID = C.COMPANY_ID*/
                 LEFT JOIN SCMDATA.PT_ORDERED D
                    ON D.PRODUCT_GRESS_CODE = A.DOCUMENT_NO
                   AND D.COMPANY_ID = A.COMPANY_ID
                 INNER JOIN SCMDATA.T_COMMODITY_INFO E ON E.GOO_ID=A.GOO_ID AND E.COMPANY_ID=A.COMPANY_ID
                 --WHERE B.AMOUNT > 0
                 GROUP BY A.COMPANY_ID, EXTRACT(YEAR FROM A.CREATE_TIME),
                          EXTRACT(MONTH FROM A.CREATE_TIME),
                          TO_CHAR(A.CREATE_TIME, 'yyyy-mm-dd'), E.CATEGORY,
                          (CASE WHEN D.GROUP_NAME IS NULL THEN '1' ELSE D.GROUP_NAME END)) Y   ]';

    V_SQL2 := q'[MERGE INTO SCMDATA.T_RTKPI_THISMONTH A
             USING (SELECT y.COMPANY_ID, y.YEAR, y.MONTH, to_date(y.RTKPI_DATE,'yyyy-mm-dd') RTKPI_DATE, y.CATEGORY,
              y.GROUP_NAME, y.COUNT_DIMENSION, y.DIMENSION_SORT,
              /*Z.ORDER_MONEY INGOOD_MONEY,*/ Y.RMMONEY SHOP_RT_ORIGINAL_MONEY, X.RMMONEY2 SHOP_RT_MONEY
          FROM
         (SELECT A.COMPANY_ID, A.YEAR, A.MONTH,
                          TO_CHAR(A.ACCESS_TIME, 'yyyy-mm-dd') RTKPI_DATE,
                          B.CATEGORY,
                          (CASE WHEN A.SUP_GROUP_NAME2 IS NULL THEN '1' ELSE  A.SUP_GROUP_NAME2 END) GROUP_NAME,
                          '00' COUNT_DIMENSION,
                          B.CATEGORY DIMENSION_SORT,
                          SUM(CASE
                                WHEN REGEXP_COUNT(A.SUP_GROUP_NAME, ',') > 0 THEN
                                 A.EXAMOUNT /
                                 (REGEXP_COUNT(A.SUP_GROUP_NAME, ',') + 1) *
                                 B.PRICE
                                ELSE
                                 A.EXAMOUNT * B.PRICE
                              END) RMMONEY
                     FROM (SELECT Z.RM_ID, Z.COMPANY_ID, Z.YEAR, Z.MONTH,
                                   Z.ACCESS_TIME, Z.GOO_ID, Z.EXAMOUNT,
                                   Z.SUP_GROUP_NAME, Z.AUDIT_TIME,
                                   REGEXP_SUBSTR(Z.SUP_GROUP_NAME,
                                                  '[^,]+',
                                                  1,
                                                  LEVEL) SUP_GROUP_NAME2
                              FROM SCMDATA.T_RETURN_MANAGEMENT Z
                            CONNECT BY PRIOR RM_ID = RM_ID
                                   AND LEVEL <=
                                       LENGTH(Z.SUP_GROUP_NAME) -
                                       LENGTH(REGEXP_REPLACE(Z.SUP_GROUP_NAME,
                                                             ',',
                                                             '')) + 1
                                   AND PRIOR DBMS_RANDOM.VALUE IS NOT NULL) A
                    INNER JOIN SCMDATA.T_COMMODITY_INFO B
                       ON A.GOO_ID = B.GOO_ID
                      AND A.COMPANY_ID = B.COMPANY_ID
                    WHERE A.AUDIT_TIME IS NOT NULL
                    GROUP BY A.COMPANY_ID, A.YEAR, A.MONTH,
                             TO_CHAR(A.ACCESS_TIME, 'yyyy-mm-dd'), B.CATEGORY,
                             (CASE WHEN A.SUP_GROUP_NAME2 IS NULL THEN '1' ELSE  A.SUP_GROUP_NAME2 END)) Y

         LEFT JOIN (SELECT A.COMPANY_ID, A.YEAR, A.MONTH,
                          TO_CHAR(A.ACCESS_TIME, 'yyyy-mm-dd') RTKPI_DATE,
                          B.CATEGORY,
                          (CASE WHEN A.SUP_GROUP_NAME2 IS NULL THEN  '1' ELSE A.SUP_GROUP_NAME2 END) GROUP_NAME,
                           '00' COUNT_DIMENSION,
                          B.CATEGORY DIMENSION_SORT,
                          SUM(CASE
                                WHEN REGEXP_COUNT(A.SUP_GROUP_NAME, ',') > 0 THEN
                                 A.EXAMOUNT /
                                 (REGEXP_COUNT(A.SUP_GROUP_NAME, ',') + 1) *
                                 B.PRICE
                                ELSE
                                 A.EXAMOUNT * B.PRICE
                              END) RMMONEY2
                     FROM (SELECT Z.RM_ID, Z.COMPANY_ID, Z.YEAR, Z.MONTH,
                                   Z.ACCESS_TIME, Z.GOO_ID, Z.EXAMOUNT,
                                   Z.SUP_GROUP_NAME, Z.AUDIT_TIME,
                                   Z.CAUSE_DETAIL_ID, Z.FIRST_DEPT_ID,
                                   Z.SECOND_DEPT_ID,
                                   REGEXP_SUBSTR(Z.SUP_GROUP_NAME,
                                                  '[^,]+',
                                                  1,
                                                  LEVEL) SUP_GROUP_NAME2
                              FROM SCMDATA.T_RETURN_MANAGEMENT Z
                            CONNECT BY PRIOR RM_ID = RM_ID
                                   AND LEVEL <=
                                       LENGTH(Z.SUP_GROUP_NAME) -
                                       LENGTH(REGEXP_REPLACE(Z.SUP_GROUP_NAME,
                                                             ',',
                                                             '')) + 1
                                   AND PRIOR DBMS_RANDOM.VALUE IS NOT NULL) A
                    INNER JOIN SCMDATA.T_COMMODITY_INFO B
                       ON A.GOO_ID = B.GOO_ID
                      AND A.COMPANY_ID = B.COMPANY_ID
                     LEFT JOIN SCMDATA.T_ABNORMAL_DTL_CONFIG C
                       ON A.CAUSE_DETAIL_ID = C.ABNORMAL_DTL_CONFIG_ID
                      AND A.COMPANY_ID = C.COMPANY_ID
                      AND C.ANOMALY_CLASSIFICATION = 'AC_QUALITY'
                    INNER JOIN SCMDATA.SYS_COMPANY_DEPT D
                       ON D.COMPANY_DEPT_ID = A.FIRST_DEPT_ID
                    WHERE A.AUDIT_TIME IS NOT NULL
                      AND C.CAUSE_CLASSIFICATION <> '银饰氧化问题'
                      AND C.PROBLEM_CLASSIFICATION <> '非质量问题'
                      AND D.DEPT_NAME = '供应链管理部'
                    GROUP BY A.COMPANY_ID, A.YEAR, A.MONTH,
                             TO_CHAR(A.ACCESS_TIME, 'yyyy-mm-dd'), B.CATEGORY,
                             (CASE WHEN A.SUP_GROUP_NAME2 IS NULL THEN  '1' ELSE A.SUP_GROUP_NAME2 END)) X
           ON X.COMPANY_ID = Y.COMPANY_ID
          AND X.YEAR = Y.YEAR
          AND X.MONTH = Y.MONTH
          AND X.RTKPI_DATE = Y.RTKPI_DATE
          AND X.CATEGORY = Y.CATEGORY
          AND X.GROUP_NAME = Y.GROUP_NAME
          AND X.COUNT_DIMENSION = Y.COUNT_DIMENSION
          AND X.DIMENSION_SORT = Y.DIMENSION_SORT
          /*LEFT JOIN (SELECT A.COMPANY_ID, EXTRACT(YEAR FROM A.CREATE_TIME) YEAR,
                       EXTRACT(MONTH FROM A.CREATE_TIME) MONTH,
                       TO_CHAR(A.CREATE_TIME, 'yyyy-mm-dd') RTKPI_DATE,
                       D.CATEGORY,
                       (CASE
                         WHEN D.GROUP_NAME IS NULL THEN
                          '1'
                         ELSE
                          D.GROUP_NAME
                       END) GROUP_NAME, '00' COUNT_DIMENSION,
                       D.CATEGORY DIMENSION_SORT,
                       SUM(B.AMOUNT * E.PRICE) ORDER_MONEY
                  FROM SCMDATA.T_INGOOD A
                 INNER JOIN SCMDATA.T_INGOODS B
                    ON A.ING_ID = B.ING_ID
                   AND A.COMPANY_ID = B.COMPANY_ID
                 INNER JOIN SCMDATA.T_ORDERED C
                    ON C.ORDER_CODE = A.DOCUMENT_NO
                   AND A.COMPANY_ID = C.COMPANY_ID
                 INNER JOIN SCMDATA.PT_ORDERED D
                    ON D.ORDER_ID = C.ORDER_ID
                   AND D.COMPANY_ID = C.COMPANY_ID
                 INNER JOIN SCMDATA.T_COMMODITY_INFO E ON E.GOO_ID=B.GOO_ID AND E.COMPANY_ID=B.COMPANY_ID
                 WHERE B.AMOUNT > 0
                 GROUP BY A.COMPANY_ID, EXTRACT(YEAR FROM A.CREATE_TIME),
                          EXTRACT(MONTH FROM A.CREATE_TIME),
                          TO_CHAR(A.CREATE_TIME, 'yyyy-mm-dd'), D.CATEGORY,
                          D.GROUP_NAME) z ON Z.COMPANY_ID = Y.COMPANY_ID
          AND Z.YEAR = Y.YEAR
          AND Z.MONTH = Y.MONTH
          AND Z.RTKPI_DATE = Y.RTKPI_DATE
          AND Z.CATEGORY = Y.CATEGORY
          AND Z.GROUP_NAME = Y.GROUP_NAME
          AND Z.COUNT_DIMENSION = Y.COUNT_DIMENSION
          AND Z.DIMENSION_SORT = Y.DIMENSION_SORT*/ ]';
    /*p_type = 0 更新全部历史数据
    p_type = 1  只更新上一个月的数据 */
    IF P_TYPE = 0 THEN
      --进货
      V_EXSQL1 := V_SQL1||V_WH_SQL2||V_U_SQL1||V_I_SQL1;
      --退货
      V_EXSQL2 := V_SQL2 || V_WH_SQL2 || V_U_SQL2 || V_I_SQL2;


    ELSIF P_TYPE = 1 THEN
      --进货
      V_EXSQL1 := V_SQL1||V_WM_SQL1||V_U_SQL1||V_I_SQL1;
      --退货
      V_EXSQL2 := V_SQL2 || V_WM_SQL1 || V_U_SQL2 || V_I_SQL2;
    END IF;
    EXECUTE IMMEDIATE V_EXSQL2;
    EXECUTE IMMEDIATE V_EXSQL1;
    --dbms_output.put_line(V_EXSQL1);
    --dbms_output.put_line(V_EXSQL2);

    --区域组
    V_SQL1 := q'[MERGE INTO SCMDATA.T_RTKPI_THISMONTH A
USING (SELECT Y.COMPANY_ID, Y.YEAR, Y.MONTH, to_date(y.RTKPI_DATE,'yyyy-mm-dd') RTKPI_DATE, Y.CATEGORY,
              Y.GROUP_NAME, Y.COUNT_DIMENSION, Y.DIMENSION_SORT,
              Y.ORDER_MONEY INGOOD_MONEY
      FROM (SELECT A.COMPANY_ID,
       EXTRACT(YEAR FROM A.CREATE_TIME) YEAR,
       EXTRACT(MONTH FROM A.CREATE_TIME) MONTH,
       TO_CHAR(A.CREATE_TIME, 'yyyy-mm-dd') RTKPI_DATE,
       E.CATEGORY,
       (CASE WHEN D.GROUP_NAME IS NULL THEN  '1'  ELSE D.GROUP_NAME END) GROUP_NAME,
       '01' COUNT_DIMENSION,
       (CASE WHEN D.GROUP_NAME IS NULL THEN  '1'  ELSE D.GROUP_NAME END) DIMENSION_SORT,
       SUM(A.AMOUNT * E.PRICE) ORDER_MONEY
  FROM (SELECT T.DOCUMENT_NO,
                    T.COMPANY_ID,
                    TRUNC(T.CREATE_TIME) CREATE_TIME,
                    SUM(TL.AMOUNT) AMOUNT,
                    TL.GOO_ID
               FROM SCMDATA.T_INGOOD T
              INNER JOIN (SELECT TI.ING_ID,
                                TI.COMPANY_ID,
                                TI.GOO_ID,
                                TI.AMOUNT
                           FROM SCMDATA.T_INGOODS TI
                          WHERE TI.AMOUNT > 0) TL
                 ON TL.ING_ID = T.ING_ID
                AND TL.COMPANY_ID = T.COMPANY_ID
              WHERE TO_CHAR(T.CREATE_TIME, 'yyyy') >= 2022
              GROUP BY T.DOCUMENT_NO,
                       T.COMPANY_ID,
                       TRUNC(T.CREATE_TIME),
                       TL.GOO_ID) A
                  /*SCMDATA.T_INGOOD A
                 INNER JOIN SCMDATA.T_INGOODS B
                    ON A.ING_ID = B.ING_ID
                   AND A.COMPANY_ID = B.COMPANY_ID
                 LEFT JOIN SCMDATA.T_ORDERED C
                    ON C.ORDER_CODE = A.DOCUMENT_NO
                   AND A.COMPANY_ID = C.COMPANY_ID*/
                 LEFT JOIN SCMDATA.PT_ORDERED D
                    ON D.PRODUCT_GRESS_CODE = A.DOCUMENT_NO
                   AND D.COMPANY_ID = A.COMPANY_ID
                 INNER JOIN SCMDATA.T_COMMODITY_INFO E ON E.GOO_ID=A.GOO_ID AND E.COMPANY_ID=A.COMPANY_ID
                 --WHERE B.AMOUNT > 0
 GROUP BY A.COMPANY_ID,
          EXTRACT(YEAR FROM A.CREATE_TIME),
          EXTRACT(MONTH FROM A.CREATE_TIME),
          TO_CHAR(A.CREATE_TIME, 'yyyy-mm-dd'),
          E.CATEGORY,
          D.GROUP_NAME)  Y        ]';

    V_SQL2 := q'[MERGE INTO SCMDATA.T_RTKPI_THISMONTH A
USING (SELECT Y.COMPANY_ID, Y.YEAR, Y.MONTH, to_date(y.RTKPI_DATE,'yyyy-mm-dd') RTKPI_DATE, Y.CATEGORY,
              Y.GROUP_NAME, Y.COUNT_DIMENSION, Y.DIMENSION_SORT,
              /*Z.ORDER_MONEY INGOOD_MONEY,*/ Y.RMMONEY SHOP_RT_ORIGINAL_MONEY, X.RMMONEY2 SHOP_RT_MONEY

         FROM
         (SELECT A.COMPANY_ID, A.YEAR, A.MONTH,
                          TO_CHAR(A.ACCESS_TIME, 'yyyy-mm-dd') RTKPI_DATE,
                          B.CATEGORY,
                          (CASE
                            WHEN A.SUP_GROUP_NAME2 IS NULL THEN
                             '1'
                            ELSE
                             A.SUP_GROUP_NAME2
                          END) GROUP_NAME, '01' COUNT_DIMENSION,
                         (CASE
                            WHEN A.SUP_GROUP_NAME2 IS NULL THEN
                             '1'
                            ELSE
                             A.SUP_GROUP_NAME2
                          END) DIMENSION_SORT,
                          SUM(CASE
                                WHEN REGEXP_COUNT(A.SUP_GROUP_NAME, ',') > 0 THEN
                                 A.EXAMOUNT /
                                 (REGEXP_COUNT(A.SUP_GROUP_NAME, ',') + 1) *
                                 B.PRICE
                                ELSE
                                 A.EXAMOUNT * B.PRICE
                              END) RMMONEY
                     FROM (SELECT Z.RM_ID, Z.COMPANY_ID, Z.YEAR, Z.MONTH,
                                   Z.ACCESS_TIME, Z.GOO_ID, Z.EXAMOUNT,
                                   Z.SUP_GROUP_NAME, Z.AUDIT_TIME,
                                   REGEXP_SUBSTR(Z.SUP_GROUP_NAME,
                                                  '[^,]+',
                                                  1,
                                                  LEVEL) SUP_GROUP_NAME2
                              FROM   SCMDATA.T_RETURN_MANAGEMENT z
   CONNECT BY PRIOR RM_ID = RM_ID
          AND LEVEL <= LENGTH(z.SUP_GROUP_NAME) -
              LENGTH(REGEXP_REPLACE(z.SUP_GROUP_NAME, ',', '')) + 1
          AND PRIOR DBMS_RANDOM.VALUE IS NOT NULL) A
        INNER JOIN scmdata.T_COMMODITY_INFO B
             ON A.GOO_ID = B.GOO_ID
            AND A.COMPANY_ID = B.COMPANY_ID
       WHERE A.AUDIT_TIME IS NOT NULL
       GROUP BY A.COMPANY_ID,
                A.YEAR,
                A.MONTH,
                TO_CHAR(A.ACCESS_TIME,'yyyy-mm-dd'),
                B.CATEGORY,
                 A.SUP_GROUP_NAME2) Y

         LEFT JOIN (SELECT A.COMPANY_ID, A.YEAR, A.MONTH,
                          TO_CHAR(A.ACCESS_TIME, 'yyyy-mm-dd') RTKPI_DATE,
                          B.CATEGORY,
                          (CASE  WHEN A.SUP_GROUP_NAME2 IS NULL THEN '1'    ELSE   A.SUP_GROUP_NAME2 END) GROUP_NAME,
                           '01' COUNT_DIMENSION,
                         (CASE  WHEN A.SUP_GROUP_NAME2 IS NULL THEN '1'    ELSE   A.SUP_GROUP_NAME2 END) DIMENSION_SORT,
                          SUM(CASE
                                WHEN REGEXP_COUNT(A.SUP_GROUP_NAME, ',') > 0 THEN
                                 A.EXAMOUNT /
                                 (REGEXP_COUNT(A.SUP_GROUP_NAME, ',') + 1) *
                                 B.PRICE
                                ELSE
                                 A.EXAMOUNT * B.PRICE
                              END) RMMONEY2
                     FROM (SELECT Z.RM_ID, Z.COMPANY_ID, Z.YEAR, Z.MONTH,
                                   Z.ACCESS_TIME, Z.GOO_ID, Z.EXAMOUNT,
                                   Z.SUP_GROUP_NAME, Z.AUDIT_TIME,
                                   Z.CAUSE_DETAIL_ID, Z.FIRST_DEPT_ID,
                                   Z.SECOND_DEPT_ID,
                                   REGEXP_SUBSTR(Z.SUP_GROUP_NAME,
                                                  '[^,]+',
                                                  1,
                                                  LEVEL) SUP_GROUP_NAME2
                              FROM SCMDATA.T_RETURN_MANAGEMENT z
   CONNECT BY PRIOR RM_ID = RM_ID
          AND LEVEL <= LENGTH(z.SUP_GROUP_NAME) -
              LENGTH(REGEXP_REPLACE(z.SUP_GROUP_NAME, ',', '')) + 1
          AND PRIOR DBMS_RANDOM.VALUE IS NOT NULL) A
        INNER JOIN scmdata.T_COMMODITY_INFO B
             ON A.GOO_ID = B.GOO_ID
            AND A.COMPANY_ID = B.COMPANY_ID
          LEFT JOIN SCMDATA.T_abnormal_dtl_config C ON A.CAUSE_DETAIL_ID = C.ABNORMAL_DTL_CONFIG_ID AND A.COMPANY_ID = C.COMPANY_ID AND C.ANOMALY_CLASSIFICATION='AC_QUALITY'
         INNER JOIN SCMDATA.SYS_COMPANY_DEPT D ON D.COMPANY_DEPT_ID=A.FIRST_DEPT_ID
       WHERE A.AUDIT_TIME IS NOT NULL
       AND C.CAUSE_CLASSIFICATION <> '银饰氧化问题'
       AND C.PROBLEM_CLASSIFICATION <> '非质量问题'
        AND D.DEPT_NAME = '供应链管理部'
       GROUP BY A.COMPANY_ID,
                A.YEAR,
                A.MONTH,
                TO_CHAR(A.ACCESS_TIME,'yyyy-mm-dd'),
                B.CATEGORY,
                 A.SUP_GROUP_NAME2) X
           ON X.COMPANY_ID = Y.COMPANY_ID
          AND X.YEAR = Y.YEAR
          AND X.MONTH = Y.MONTH
          AND X.RTKPI_DATE = Y.RTKPI_DATE
          AND X.CATEGORY = Y.CATEGORY
          AND X.GROUP_NAME = Y.GROUP_NAME
          AND X.COUNT_DIMENSION = Y.COUNT_DIMENSION
          AND X.DIMENSION_SORT = Y.DIMENSION_SORT
        /*  LEFT JOIN
          (SELECT A.COMPANY_ID,
       EXTRACT(YEAR FROM A.CREATE_TIME) YEAR,
       EXTRACT(MONTH FROM A.CREATE_TIME) MONTH,
       TO_CHAR(A.CREATE_TIME, 'yyyy-mm-dd') RTKPI_DATE,
       D.CATEGORY,
       (CASE WHEN D.GROUP_NAME IS NULL THEN  '1'  ELSE D.GROUP_NAME END) GROUP_NAME,
       '01' COUNT_DIMENSION,
       (CASE WHEN D.GROUP_NAME IS NULL THEN  '1'  ELSE D.GROUP_NAME END) DIMENSION_SORT,
       SUM(B.AMOUNT * E.PRICE) ORDER_MONEY
  FROM SCMDATA.T_INGOOD A
 INNER JOIN SCMDATA.T_INGOODS B
    ON A.ING_ID = B.ING_ID
   AND A.COMPANY_ID = B.COMPANY_ID
 INNER JOIN SCMDATA.T_ORDERED C
    ON C.ORDER_CODE = A.DOCUMENT_NO
   AND A.COMPANY_ID = C.COMPANY_ID
 INNER JOIN SCMDATA.PT_ORDERED D
    ON D.ORDER_ID = C.ORDER_ID
   AND D.COMPANY_ID = C.COMPANY_ID
  INNER JOIN SCMDATA.T_COMMODITY_INFO E ON E.GOO_ID=B.GOO_ID AND E.COMPANY_ID=B.COMPANY_ID
 WHERE B.AMOUNT > 0
 GROUP BY A.COMPANY_ID,
          EXTRACT(YEAR FROM A.CREATE_TIME),
          EXTRACT(MONTH FROM A.CREATE_TIME),
          TO_CHAR(A.CREATE_TIME, 'yyyy-mm-dd'),
          D.CATEGORY,
          D.GROUP_NAME) z ON Z.COMPANY_ID = Y.COMPANY_ID
          AND Z.YEAR = Y.YEAR
          AND Z.MONTH = Y.MONTH
          AND Z.RTKPI_DATE = Y.RTKPI_DATE
          AND Z.CATEGORY = Y.CATEGORY
          AND Z.GROUP_NAME = Y.GROUP_NAME
          AND Z.COUNT_DIMENSION = Y.COUNT_DIMENSION
          AND Z.DIMENSION_SORT = Y.DIMENSION_SORT */]';
    /*p_type = 0 更新全部历史数据
    p_type = 1  只更新上一个月的数据 */
    IF P_TYPE = 0 THEN
      --进货
      V_EXSQL1 := V_SQL1||V_WH_SQL2||V_U_SQL1||V_I_SQL1;
      --退货
      V_EXSQL2 := V_SQL2 || V_WH_SQL2 || V_U_SQL2 || V_I_SQL2;


    ELSIF P_TYPE = 1 THEN
      --进货
      V_EXSQL1 := V_SQL1||V_WM_SQL1||V_U_SQL1||V_I_SQL1;
      --退货
      V_EXSQL2 := V_SQL2 || V_WM_SQL1 || V_U_SQL2 || V_I_SQL2;
    END IF;
    EXECUTE IMMEDIATE V_EXSQL2;
    EXECUTE IMMEDIATE V_EXSQL1;
    --dbms_output.put_line(V_EXSQL1);
    --dbms_output.put_line(V_EXSQL2);

    --款式名称
    V_SQL1:=q'[MERGE INTO SCMDATA.T_RTKPI_THISMONTH A
USING (SELECT Y.COMPANY_ID, Y.YEAR, Y.MONTH, to_date(y.RTKPI_DATE,'yyyy-mm-dd') RTKPI_DATE, Y.CATEGORY,
              Y.GROUP_NAME, Y.COUNT_DIMENSION, Y.DIMENSION_SORT,
              Y.ORDER_MONEY INGOOD_MONEY
    FROM ( SELECT A.COMPANY_ID,
       EXTRACT(YEAR FROM A.CREATE_TIME) YEAR,
       EXTRACT(MONTH FROM A.CREATE_TIME) MONTH,
       TO_CHAR(A.CREATE_TIME, 'yyyy-mm-dd') RTKPI_DATE,
       E.CATEGORY,
       (CASE WHEN D.GROUP_NAME IS NULL THEN  '1'  ELSE D.GROUP_NAME END) GROUP_NAME,
       '02' COUNT_DIMENSION,
       E.STYLE_NAME DIMENSION_SORT,
       SUM(A.AMOUNT * E.PRICE) ORDER_MONEY
  FROM (SELECT T.DOCUMENT_NO,
                    T.COMPANY_ID,
                    TRUNC(T.CREATE_TIME) CREATE_TIME,
                    SUM(TL.AMOUNT) AMOUNT,
                    TL.GOO_ID
               FROM SCMDATA.T_INGOOD T
              INNER JOIN (SELECT TI.ING_ID,
                                TI.COMPANY_ID,
                                TI.GOO_ID,
                                TI.AMOUNT
                           FROM SCMDATA.T_INGOODS TI
                          WHERE TI.AMOUNT > 0) TL
                 ON TL.ING_ID = T.ING_ID
                AND TL.COMPANY_ID = T.COMPANY_ID
              WHERE TO_CHAR(T.CREATE_TIME, 'yyyy') >= 2022
              GROUP BY T.DOCUMENT_NO,
                       T.COMPANY_ID,
                       TRUNC(T.CREATE_TIME),
                       TL.GOO_ID) A
                  /*SCMDATA.T_INGOOD A
                 INNER JOIN SCMDATA.T_INGOODS B
                    ON A.ING_ID = B.ING_ID
                   AND A.COMPANY_ID = B.COMPANY_ID
                 LEFT JOIN SCMDATA.T_ORDERED C
                    ON C.ORDER_CODE = A.DOCUMENT_NO
                   AND A.COMPANY_ID = C.COMPANY_ID*/
                 LEFT JOIN SCMDATA.PT_ORDERED D
                    ON D.PRODUCT_GRESS_CODE = A.DOCUMENT_NO
                   AND D.COMPANY_ID = A.COMPANY_ID
                 INNER JOIN SCMDATA.T_COMMODITY_INFO E ON E.GOO_ID=A.GOO_ID AND E.COMPANY_ID=A.COMPANY_ID
                 --WHERE B.AMOUNT > 0
 GROUP BY A.COMPANY_ID,
          EXTRACT(YEAR FROM A.CREATE_TIME),
          EXTRACT(MONTH FROM A.CREATE_TIME),
          TO_CHAR(A.CREATE_TIME, 'yyyy-mm-dd'),
          E.CATEGORY,
          D.GROUP_NAME,
          E.STYLE_NAME) Y ]';

    V_SQL2 := q'[MERGE INTO SCMDATA.T_RTKPI_THISMONTH A
USING (SELECT Y.COMPANY_ID, Y.YEAR, Y.MONTH, to_date(y.RTKPI_DATE,'yyyy-mm-dd') RTKPI_DATE, Y.CATEGORY,
              Y.GROUP_NAME, Y.COUNT_DIMENSION, Y.DIMENSION_SORT,
              /*Z.ORDER_MONEY INGOOD_MONEY,*/ Y.RMMONEY SHOP_RT_ORIGINAL_MONEY, X.RMMONEY2 SHOP_RT_MONEY

         FROM
         (SELECT A.COMPANY_ID, A.YEAR, A.MONTH,
                          TO_CHAR(A.ACCESS_TIME, 'yyyy-mm-dd') RTKPI_DATE,
                          B.CATEGORY,
                          (CASE
                            WHEN A.SUP_GROUP_NAME2 IS NULL THEN
                             '1'
                            ELSE
                             A.SUP_GROUP_NAME2
                          END) GROUP_NAME, '02' COUNT_DIMENSION,
                         B.STYLE_NAME DIMENSION_SORT,
                          SUM(CASE           WHEN REGEXP_COUNT(A.SUP_GROUP_NAME, ',') > 0 THEN
                                 A.EXAMOUNT /
                                 (REGEXP_COUNT(A.SUP_GROUP_NAME, ',') + 1) *
                                 B.PRICE
                                ELSE
                                 A.EXAMOUNT * B.PRICE
                              END) RMMONEY
                     FROM (SELECT Z.RM_ID, Z.COMPANY_ID, Z.YEAR, Z.MONTH,
                                   Z.ACCESS_TIME, Z.GOO_ID, Z.EXAMOUNT,
                                   Z.SUP_GROUP_NAME, Z.AUDIT_TIME,
                                   REGEXP_SUBSTR(Z.SUP_GROUP_NAME,
                                                  '[^,]+',
                                                  1,
                                                  LEVEL) SUP_GROUP_NAME2
                              FROM   SCMDATA.T_RETURN_MANAGEMENT z
   CONNECT BY PRIOR RM_ID = RM_ID
          AND LEVEL <= LENGTH(z.SUP_GROUP_NAME) -
              LENGTH(REGEXP_REPLACE(z.SUP_GROUP_NAME, ',', '')) + 1
          AND PRIOR DBMS_RANDOM.VALUE IS NOT NULL) A
        INNER JOIN scmdata.T_COMMODITY_INFO B
             ON A.GOO_ID = B.GOO_ID
            AND A.COMPANY_ID = B.COMPANY_ID
       WHERE A.AUDIT_TIME IS NOT NULL
       GROUP BY A.COMPANY_ID,
                A.YEAR,
                A.MONTH,
                TO_CHAR(A.ACCESS_TIME,'yyyy-mm-dd'),
                B.CATEGORY,
                 A.SUP_GROUP_NAME2,
                B.STYLE_NAME) Y

         LEFT JOIN (SELECT A.COMPANY_ID, A.YEAR, A.MONTH,
                          TO_CHAR(A.ACCESS_TIME, 'yyyy-mm-dd') RTKPI_DATE,
                          B.CATEGORY,
                          (CASE  WHEN A.SUP_GROUP_NAME2 IS NULL THEN '1'    ELSE   A.SUP_GROUP_NAME2 END) GROUP_NAME,
                           '02' COUNT_DIMENSION,
                         B.STYLE_NAME DIMENSION_SORT,
                          SUM(CASE
                                WHEN REGEXP_COUNT(A.SUP_GROUP_NAME, ',') > 0 THEN
                                 A.EXAMOUNT /
                                 (REGEXP_COUNT(A.SUP_GROUP_NAME, ',') + 1) *
                                 B.PRICE
                                ELSE
                                 A.EXAMOUNT * B.PRICE
                              END) RMMONEY2
                     FROM (SELECT Z.RM_ID, Z.COMPANY_ID, Z.YEAR, Z.MONTH,
                                   Z.ACCESS_TIME, Z.GOO_ID, Z.EXAMOUNT,
                                   Z.SUP_GROUP_NAME, Z.AUDIT_TIME,
                                   Z.CAUSE_DETAIL_ID, Z.FIRST_DEPT_ID,
                                   Z.SECOND_DEPT_ID,
                                   REGEXP_SUBSTR(Z.SUP_GROUP_NAME,
                                                  '[^,]+',
                                                  1,
                                                  LEVEL) SUP_GROUP_NAME2
                              FROM SCMDATA.T_RETURN_MANAGEMENT Z
        CONNECT BY PRIOR RM_ID = RM_ID
               AND LEVEL <=
                   LENGTH(Z.SUP_GROUP_NAME) -
                   LENGTH(REGEXP_REPLACE(Z.SUP_GROUP_NAME, ',', '')) + 1
               AND PRIOR DBMS_RANDOM.VALUE IS NOT NULL) A
 INNER JOIN SCMDATA.T_COMMODITY_INFO B
    ON A.GOO_ID = B.GOO_ID
   AND A.COMPANY_ID = B.COMPANY_ID
  LEFT JOIN SCMDATA.T_ABNORMAL_DTL_CONFIG C
    ON A.CAUSE_DETAIL_ID = C.ABNORMAL_DTL_CONFIG_ID
   AND A.COMPANY_ID = C.COMPANY_ID
   AND C.ANOMALY_CLASSIFICATION = 'AC_QUALITY'
 INNER JOIN SCMDATA.SYS_COMPANY_DEPT D
    ON D.COMPANY_DEPT_ID = A.FIRST_DEPT_ID
 WHERE A.AUDIT_TIME IS NOT NULL
   AND C.CAUSE_CLASSIFICATION <> '银饰氧化问题'
   AND C.PROBLEM_CLASSIFICATION <> '非质量问题'
   AND D.DEPT_NAME = '供应链管理部'
 GROUP BY A.COMPANY_ID,
          A.YEAR,
          A.MONTH,
          TO_CHAR(A.ACCESS_TIME, 'yyyy-mm-dd'),
          B.CATEGORY,
          A.SUP_GROUP_NAME2,
          B.STYLE_NAME) X
           ON X.COMPANY_ID = Y.COMPANY_ID
          AND X.YEAR = Y.YEAR
          AND X.MONTH = Y.MONTH
          AND X.RTKPI_DATE = Y.RTKPI_DATE
          AND X.CATEGORY = Y.CATEGORY
          AND X.GROUP_NAME = Y.GROUP_NAME
          AND X.COUNT_DIMENSION = Y.COUNT_DIMENSION
          AND X.DIMENSION_SORT = Y.DIMENSION_SORT
     /*     LEFT JOIN ( SELECT A.COMPANY_ID,
       EXTRACT(YEAR FROM A.CREATE_TIME) YEAR,
       EXTRACT(MONTH FROM A.CREATE_TIME) MONTH,
       TO_CHAR(A.CREATE_TIME, 'yyyy-mm-dd') RTKPI_DATE,
       D.CATEGORY,
       (CASE WHEN D.GROUP_NAME IS NULL THEN  '1'  ELSE D.GROUP_NAME END) GROUP_NAME,
       '02' COUNT_DIMENSION,
       D.STYLE_NAME DIMENSION_SORT,
       SUM(B.AMOUNT * E.PRICE) ORDER_MONEY
  FROM SCMDATA.T_INGOOD A
 INNER JOIN SCMDATA.T_INGOODS B
    ON A.ING_ID = B.ING_ID
   AND A.COMPANY_ID = B.COMPANY_ID
 INNER JOIN SCMDATA.T_ORDERED C
    ON C.ORDER_CODE = A.DOCUMENT_NO
   AND A.COMPANY_ID = C.COMPANY_ID
 INNER JOIN SCMDATA.PT_ORDERED D
    ON D.ORDER_ID = C.ORDER_ID
   AND D.COMPANY_ID = C.COMPANY_ID
  INNER JOIN SCMDATA.T_COMMODITY_INFO E ON E.GOO_ID=B.GOO_ID AND E.COMPANY_ID=B.COMPANY_ID
 WHERE B.AMOUNT > 0
 GROUP BY A.COMPANY_ID,
          EXTRACT(YEAR FROM A.CREATE_TIME),
          EXTRACT(MONTH FROM A.CREATE_TIME),
          TO_CHAR(A.CREATE_TIME, 'yyyy-mm-dd'),
          D.CATEGORY,
          D.GROUP_NAME,
          D.STYLE_NAME) z ON Z.COMPANY_ID = Y.COMPANY_ID
          AND Z.YEAR = Y.YEAR
          AND Z.MONTH = Y.MONTH
          AND Z.RTKPI_DATE = Y.RTKPI_DATE
          AND Z.CATEGORY = Y.CATEGORY
          AND Z.GROUP_NAME = Y.GROUP_NAME
          AND Z.COUNT_DIMENSION = Y.COUNT_DIMENSION
          AND Z.DIMENSION_SORT = Y.DIMENSION_SORT */]';
    IF P_TYPE = 0 THEN
      --进货
      V_EXSQL1 := V_SQL1||V_WH_SQL2||V_U_SQL1||V_I_SQL1;
      --退货
      V_EXSQL2 := V_SQL2 || V_WH_SQL2 || V_U_SQL2 || V_I_SQL2;


    ELSIF P_TYPE = 1 THEN
      --进货
      V_EXSQL1 := V_SQL1||V_WM_SQL1||V_U_SQL1||V_I_SQL1;
      --退货
      V_EXSQL2 := V_SQL2 || V_WM_SQL1 || V_U_SQL2 || V_I_SQL2;
    END IF;
    EXECUTE IMMEDIATE V_EXSQL2;
    EXECUTE IMMEDIATE V_EXSQL1;
    --dbms_output.put_line(V_EXSQL1);
    --dbms_output.put_line(V_EXSQL2);

    --产品子类
     V_SQL1 := q'[MERGE INTO SCMDATA.T_RTKPI_THISMONTH A
USING (SELECT Y.COMPANY_ID, Y.YEAR, Y.MONTH, to_date(y.RTKPI_DATE,'yyyy-mm-dd') RTKPI_DATE, Y.CATEGORY,
              Y.GROUP_NAME, Y.COUNT_DIMENSION, Y.DIMENSION_SORT,
              Y.ORDER_MONEY INGOOD_MONEY
      FROM (  SELECT A.COMPANY_ID,
       EXTRACT(YEAR FROM A.CREATE_TIME) YEAR,
       EXTRACT(MONTH FROM A.CREATE_TIME) MONTH,
       TO_CHAR(A.CREATE_TIME, 'yyyy-mm-dd') RTKPI_DATE,
       E.CATEGORY,
       (CASE WHEN D.GROUP_NAME IS NULL THEN  '1'  ELSE D.GROUP_NAME END) GROUP_NAME,
       '03' COUNT_DIMENSION,
       E.SAMLL_CATEGORY DIMENSION_SORT,
       SUM(A.AMOUNT * E.PRICE) ORDER_MONEY
  FROM (SELECT T.DOCUMENT_NO,
                    T.COMPANY_ID,
                    TRUNC(T.CREATE_TIME) CREATE_TIME,
                    SUM(TL.AMOUNT) AMOUNT,
                    TL.GOO_ID
               FROM SCMDATA.T_INGOOD T
              INNER JOIN (SELECT TI.ING_ID,
                                TI.COMPANY_ID,
                                TI.GOO_ID,
                                TI.AMOUNT
                           FROM SCMDATA.T_INGOODS TI
                          WHERE TI.AMOUNT > 0) TL
                 ON TL.ING_ID = T.ING_ID
                AND TL.COMPANY_ID = T.COMPANY_ID
              WHERE TO_CHAR(T.CREATE_TIME, 'yyyy') >= 2022
              GROUP BY T.DOCUMENT_NO,
                       T.COMPANY_ID,
                       TRUNC(T.CREATE_TIME),
                       TL.GOO_ID) A
                  /*SCMDATA.T_INGOOD A
                 INNER JOIN SCMDATA.T_INGOODS B
                    ON A.ING_ID = B.ING_ID
                   AND A.COMPANY_ID = B.COMPANY_ID
                 LEFT JOIN SCMDATA.T_ORDERED C
                    ON C.ORDER_CODE = A.DOCUMENT_NO
                   AND A.COMPANY_ID = C.COMPANY_ID*/
                 LEFT JOIN SCMDATA.PT_ORDERED D
                    ON D.PRODUCT_GRESS_CODE = A.DOCUMENT_NO
                   AND D.COMPANY_ID = A.COMPANY_ID
                 INNER JOIN SCMDATA.T_COMMODITY_INFO E ON E.GOO_ID=A.GOO_ID AND E.COMPANY_ID=A.COMPANY_ID
                 --WHERE B.AMOUNT > 0
 GROUP BY A.COMPANY_ID,
          EXTRACT(YEAR FROM A.CREATE_TIME),
          EXTRACT(MONTH FROM A.CREATE_TIME),
          TO_CHAR(A.CREATE_TIME, 'yyyy-mm-dd'),
          E.CATEGORY,
          D.GROUP_NAME,
          E.SAMLL_CATEGORY) Y
      ]';
    V_SQL2 := q'[MERGE INTO SCMDATA.T_RTKPI_THISMONTH A
USING (SELECT Y.COMPANY_ID, Y.YEAR, Y.MONTH, to_date(y.RTKPI_DATE,'yyyy-mm-dd') RTKPI_DATE, Y.CATEGORY,
              Y.GROUP_NAME, Y.COUNT_DIMENSION, Y.DIMENSION_SORT,
              /*Z.ORDER_MONEY INGOOD_MONEY,*/ Y.RMMONEY SHOP_RT_ORIGINAL_MONEY, X.RMMONEY2 SHOP_RT_MONEY

         FROM
         (SELECT A.COMPANY_ID, A.YEAR, A.MONTH,
                          TO_CHAR(A.ACCESS_TIME, 'yyyy-mm-dd') RTKPI_DATE,
                          B.CATEGORY,
                          (CASE
                            WHEN A.SUP_GROUP_NAME2 IS NULL THEN
                             '1'
                            ELSE
                             A.SUP_GROUP_NAME2
                          END) GROUP_NAME, '03' COUNT_DIMENSION,
                         B.SAMLL_CATEGORY DIMENSION_SORT,
                          SUM(CASE           WHEN REGEXP_COUNT(A.SUP_GROUP_NAME, ',') > 0 THEN
                                 A.EXAMOUNT /
                                 (REGEXP_COUNT(A.SUP_GROUP_NAME, ',') + 1) *
                                 B.PRICE
                                ELSE
                                 A.EXAMOUNT * B.PRICE
                              END) RMMONEY
                     FROM (SELECT Z.RM_ID, Z.COMPANY_ID, Z.YEAR, Z.MONTH,
                                   Z.ACCESS_TIME, Z.GOO_ID, Z.EXAMOUNT,
                                   Z.SUP_GROUP_NAME, Z.AUDIT_TIME,
                                   REGEXP_SUBSTR(Z.SUP_GROUP_NAME,
                                                  '[^,]+',
                                                  1,
                                                  LEVEL) SUP_GROUP_NAME2
                              FROM  SCMDATA.T_RETURN_MANAGEMENT z
   CONNECT BY PRIOR RM_ID = RM_ID
          AND LEVEL <= LENGTH(z.SUP_GROUP_NAME) -
              LENGTH(REGEXP_REPLACE(z.SUP_GROUP_NAME, ',', '')) + 1
          AND PRIOR DBMS_RANDOM.VALUE IS NOT NULL) A
        INNER JOIN scmdata.T_COMMODITY_INFO B
             ON A.GOO_ID = B.GOO_ID
            AND A.COMPANY_ID = B.COMPANY_ID
       WHERE A.AUDIT_TIME IS NOT NULL
       GROUP BY A.COMPANY_ID,
                A.YEAR,
                A.MONTH,
                TO_CHAR(A.ACCESS_TIME,'yyyy-mm-dd'),
                B.CATEGORY,
                 A.SUP_GROUP_NAME2,
                B.SAMLL_CATEGORY) Y

         LEFT JOIN (SELECT A.COMPANY_ID, A.YEAR, A.MONTH,
                          TO_CHAR(A.ACCESS_TIME, 'yyyy-mm-dd') RTKPI_DATE,
                          B.CATEGORY,
                          (CASE  WHEN A.SUP_GROUP_NAME2 IS NULL THEN '1'    ELSE   A.SUP_GROUP_NAME2 END) GROUP_NAME,
                           '03' COUNT_DIMENSION,
                         B.SAMLL_CATEGORY DIMENSION_SORT,
                          SUM(CASE
                                WHEN REGEXP_COUNT(A.SUP_GROUP_NAME, ',') > 0 THEN
                                 A.EXAMOUNT /
                                 (REGEXP_COUNT(A.SUP_GROUP_NAME, ',') + 1) *
                                 B.PRICE
                                ELSE
                                 A.EXAMOUNT * B.PRICE
                              END) RMMONEY2
                     FROM (SELECT Z.RM_ID, Z.COMPANY_ID, Z.YEAR, Z.MONTH,
                                   Z.ACCESS_TIME, Z.GOO_ID, Z.EXAMOUNT,
                                   Z.SUP_GROUP_NAME, Z.AUDIT_TIME,
                                   Z.CAUSE_DETAIL_ID, Z.FIRST_DEPT_ID,
                                   Z.SECOND_DEPT_ID,
                                   REGEXP_SUBSTR(Z.SUP_GROUP_NAME,
                                                  '[^,]+',
                                                  1,
                                                  LEVEL) SUP_GROUP_NAME2
                              FROM SCMDATA.T_RETURN_MANAGEMENT Z
        CONNECT BY PRIOR RM_ID = RM_ID
               AND LEVEL <=
                   LENGTH(Z.SUP_GROUP_NAME) -
                   LENGTH(REGEXP_REPLACE(Z.SUP_GROUP_NAME, ',', '')) + 1
               AND PRIOR DBMS_RANDOM.VALUE IS NOT NULL) A
 INNER JOIN SCMDATA.T_COMMODITY_INFO B
    ON A.GOO_ID = B.GOO_ID
   AND A.COMPANY_ID = B.COMPANY_ID
  LEFT JOIN SCMDATA.T_ABNORMAL_DTL_CONFIG C
    ON A.CAUSE_DETAIL_ID = C.ABNORMAL_DTL_CONFIG_ID
   AND A.COMPANY_ID = C.COMPANY_ID
   AND C.ANOMALY_CLASSIFICATION = 'AC_QUALITY'
 INNER JOIN SCMDATA.SYS_COMPANY_DEPT D
    ON D.COMPANY_DEPT_ID = A.FIRST_DEPT_ID
 WHERE A.AUDIT_TIME IS NOT NULL
   AND C.CAUSE_CLASSIFICATION <> '银饰氧化问题'
   AND C.PROBLEM_CLASSIFICATION <> '非质量问题'
   AND D.DEPT_NAME = '供应链管理部'
 GROUP BY A.COMPANY_ID,
          A.YEAR,
          A.MONTH,
          TO_CHAR(A.ACCESS_TIME, 'yyyy-mm-dd'),
          B.CATEGORY,
          A.SUP_GROUP_NAME2,
          B.SAMLL_CATEGORY) X
           ON X.COMPANY_ID = Y.COMPANY_ID
          AND X.YEAR = Y.YEAR
          AND X.MONTH = Y.MONTH
          AND X.RTKPI_DATE = Y.RTKPI_DATE
          AND X.CATEGORY = Y.CATEGORY
          AND X.GROUP_NAME = Y.GROUP_NAME
          AND X.COUNT_DIMENSION = Y.COUNT_DIMENSION
          AND X.DIMENSION_SORT = Y.DIMENSION_SORT
         /* LEFT JOIN
          (  SELECT A.COMPANY_ID,
       EXTRACT(YEAR FROM A.CREATE_TIME) YEAR,
       EXTRACT(MONTH FROM A.CREATE_TIME) MONTH,
       TO_CHAR(A.CREATE_TIME, 'yyyy-mm-dd') RTKPI_DATE,
       D.CATEGORY,
       (CASE WHEN D.GROUP_NAME IS NULL THEN  '1'  ELSE D.GROUP_NAME END) GROUP_NAME,
       '03' COUNT_DIMENSION,
       D.SAMLL_CATEGORY DIMENSION_SORT,
       SUM(B.AMOUNT * E.PRICE) ORDER_MONEY
  FROM SCMDATA.T_INGOOD A
 INNER JOIN SCMDATA.T_INGOODS B
    ON A.ING_ID = B.ING_ID
   AND A.COMPANY_ID = B.COMPANY_ID
 INNER JOIN SCMDATA.T_ORDERED C
    ON C.ORDER_CODE = A.DOCUMENT_NO
   AND A.COMPANY_ID = C.COMPANY_ID
 INNER JOIN SCMDATA.PT_ORDERED D
    ON D.ORDER_ID = C.ORDER_ID
   AND D.COMPANY_ID = C.COMPANY_ID
  INNER JOIN SCMDATA.T_COMMODITY_INFO E ON E.GOO_ID=B.GOO_ID AND E.COMPANY_ID=B.COMPANY_ID
 WHERE B.AMOUNT > 0
 GROUP BY A.COMPANY_ID,
          EXTRACT(YEAR FROM A.CREATE_TIME),
          EXTRACT(MONTH FROM A.CREATE_TIME),
          TO_CHAR(A.CREATE_TIME, 'yyyy-mm-dd'),
          D.CATEGORY,
          D.GROUP_NAME,
          D.SAMLL_CATEGORY) z ON Z.COMPANY_ID = Y.COMPANY_ID
          AND Z.YEAR = Y.YEAR
          AND Z.MONTH = Y.MONTH
          AND Z.RTKPI_DATE = Y.RTKPI_DATE
          AND Z.CATEGORY = Y.CATEGORY
          AND Z.GROUP_NAME = Y.GROUP_NAME
          AND Z.COUNT_DIMENSION = Y.COUNT_DIMENSION
          AND Z.DIMENSION_SORT = Y.DIMENSION_SORT*/ ]';
   IF P_TYPE = 0 THEN
      --进货
      V_EXSQL1 := V_SQL1||V_WH_SQL2||V_U_SQL1||V_I_SQL1;
      --退货
      V_EXSQL2 := V_SQL2 || V_WH_SQL2 || V_U_SQL2 || V_I_SQL2;


    ELSIF P_TYPE = 1 THEN
      --进货
      V_EXSQL1 := V_SQL1||V_WM_SQL1||V_U_SQL1||V_I_SQL1;
      --退货
      V_EXSQL2 := V_SQL2 || V_WM_SQL1 || V_U_SQL2 || V_I_SQL2;
    END IF;
   EXECUTE IMMEDIATE V_EXSQL2;
    EXECUTE IMMEDIATE V_EXSQL1;
    --dbms_output.put_line(V_EXSQL1);
    --dbms_output.put_line(V_EXSQL2);

    --  供应商
    V_SQL1:=q'[MERGE INTO SCMDATA.T_RTKPI_THISMONTH A
USING (SELECT Y.COMPANY_ID, Y.YEAR, Y.MONTH, to_date(y.RTKPI_DATE,'yyyy-mm-dd') RTKPI_DATE, Y.CATEGORY,
              Y.GROUP_NAME, Y.COUNT_DIMENSION, Y.DIMENSION_SORT,
              Y.ORDER_MONEY INGOOD_MONEY
     FROM (  SELECT A.COMPANY_ID,
       EXTRACT(YEAR FROM A.CREATE_TIME) YEAR,
       EXTRACT(MONTH FROM A.CREATE_TIME) MONTH,
       TO_CHAR(A.CREATE_TIME, 'yyyy-mm-dd') RTKPI_DATE,
       E.CATEGORY,
       (CASE WHEN D.GROUP_NAME IS NULL THEN  '1'  ELSE D.GROUP_NAME END) GROUP_NAME,
       '04' COUNT_DIMENSION,
       A.SUPPLIER_CODE DIMENSION_SORT,
       SUM(A.AMOUNT * E.PRICE) ORDER_MONEY
  FROM (SELECT T.DOCUMENT_NO,
                    T.COMPANY_ID,
                    TRUNC(T.CREATE_TIME) CREATE_TIME,
                    SUM(TL.AMOUNT) AMOUNT,
                    T.SUPPLIER_CODE,
                    TL.GOO_ID
               FROM SCMDATA.T_INGOOD T
              INNER JOIN (SELECT TI.ING_ID,
                                TI.COMPANY_ID,
                                TI.GOO_ID,
                                TI.AMOUNT
                           FROM SCMDATA.T_INGOODS TI
                          WHERE TI.AMOUNT > 0) TL
                 ON TL.ING_ID = T.ING_ID
                AND TL.COMPANY_ID = T.COMPANY_ID
              WHERE TO_CHAR(T.CREATE_TIME, 'yyyy') >= 2022
              GROUP BY T.DOCUMENT_NO,
                       T.COMPANY_ID,
                       TRUNC(T.CREATE_TIME),
                       T.SUPPLIER_CODE,
                       TL.GOO_ID) A
                  /*SCMDATA.T_INGOOD A
                 INNER JOIN SCMDATA.T_INGOODS B
                    ON A.ING_ID = B.ING_ID
                   AND A.COMPANY_ID = B.COMPANY_ID
                 LEFT JOIN SCMDATA.T_ORDERED C
                    ON C.ORDER_CODE = A.DOCUMENT_NO
                   AND A.COMPANY_ID = C.COMPANY_ID*/
                 LEFT JOIN SCMDATA.PT_ORDERED D
                    ON D.PRODUCT_GRESS_CODE = A.DOCUMENT_NO
                   AND D.COMPANY_ID = A.COMPANY_ID
                 INNER JOIN SCMDATA.T_COMMODITY_INFO E ON E.GOO_ID=A.GOO_ID AND E.COMPANY_ID=A.COMPANY_ID
                 --WHERE B.AMOUNT > 0
 GROUP BY A.COMPANY_ID,
          EXTRACT(YEAR FROM A.CREATE_TIME),
          EXTRACT(MONTH FROM A.CREATE_TIME),
          TO_CHAR(A.CREATE_TIME, 'yyyy-mm-dd'),
          E.CATEGORY,
          D.GROUP_NAME,
          A.SUPPLIER_CODE)  Y         ]';

    V_SQL2 := q'[ MERGE INTO SCMDATA.T_RTKPI_THISMONTH A
USING (SELECT Y.COMPANY_ID, Y.YEAR, Y.MONTH, to_date(y.RTKPI_DATE,'yyyy-mm-dd') RTKPI_DATE, Y.CATEGORY,
              Y.GROUP_NAME, Y.COUNT_DIMENSION, Y.DIMENSION_SORT,
              /*Z.ORDER_MONEY INGOOD_MONEY,*/ Y.RMMONEY SHOP_RT_ORIGINAL_MONEY, X.RMMONEY2 SHOP_RT_MONEY

         FROM
         (SELECT A.COMPANY_ID, A.YEAR, A.MONTH,
                          TO_CHAR(A.ACCESS_TIME, 'yyyy-mm-dd') RTKPI_DATE,
                          B.CATEGORY,
                          (CASE
                            WHEN A.SUP_GROUP_NAME2 IS NULL THEN
                             '1'
                            ELSE
                             A.SUP_GROUP_NAME2
                          END) GROUP_NAME, '04' COUNT_DIMENSION,
                         A.SUPPLIER_CODE DIMENSION_SORT,
                          SUM(CASE           WHEN REGEXP_COUNT(A.SUP_GROUP_NAME, ',') > 0 THEN
                                 A.EXAMOUNT /
                                 (REGEXP_COUNT(A.SUP_GROUP_NAME, ',') + 1) *
                                 B.PRICE
                                ELSE
                                 A.EXAMOUNT * B.PRICE
                              END) RMMONEY
                     FROM (SELECT Z.RM_ID, Z.COMPANY_ID, Z.YEAR, Z.MONTH,
                                   Z.ACCESS_TIME, Z.GOO_ID, Z.EXAMOUNT,
                                   Z.SUP_GROUP_NAME, Z.AUDIT_TIME,
                                   Z.SUPPLIER_CODE,
                                   REGEXP_SUBSTR(Z.SUP_GROUP_NAME,
                                                  '[^,]+',
                                                  1,
                                                  LEVEL) SUP_GROUP_NAME2
                              FROM SCMDATA.T_RETURN_MANAGEMENT z
   CONNECT BY PRIOR RM_ID = RM_ID
          AND LEVEL <= LENGTH(z.SUP_GROUP_NAME) -
              LENGTH(REGEXP_REPLACE(z.SUP_GROUP_NAME, ',', '')) + 1
          AND PRIOR DBMS_RANDOM.VALUE IS NOT NULL) A
        INNER JOIN scmdata.T_COMMODITY_INFO B
             ON A.GOO_ID = B.GOO_ID
            AND A.COMPANY_ID = B.COMPANY_ID
       WHERE A.AUDIT_TIME IS NOT NULL
       GROUP BY A.COMPANY_ID,
                A.YEAR,
                A.MONTH,
                TO_CHAR(A.ACCESS_TIME,'yyyy-mm-dd'),
                B.CATEGORY,
                 A.SUP_GROUP_NAME2,
                A.SUPPLIER_CODE) Y

         LEFT JOIN (SELECT A.COMPANY_ID, A.YEAR, A.MONTH,
                          TO_CHAR(A.ACCESS_TIME, 'yyyy-mm-dd') RTKPI_DATE,
                          B.CATEGORY,
                          (CASE  WHEN A.SUP_GROUP_NAME2 IS NULL THEN '1'    ELSE   A.SUP_GROUP_NAME2 END) GROUP_NAME,
                           '04' COUNT_DIMENSION,
                         A.SUPPLIER_CODE DIMENSION_SORT,
                          SUM(CASE
                                WHEN REGEXP_COUNT(A.SUP_GROUP_NAME, ',') > 0 THEN
                                 A.EXAMOUNT /
                                 (REGEXP_COUNT(A.SUP_GROUP_NAME, ',') + 1) *
                                 B.PRICE
                                ELSE
                                 A.EXAMOUNT * B.PRICE
                              END) RMMONEY2
                     FROM (SELECT Z.RM_ID, Z.COMPANY_ID, Z.YEAR, Z.MONTH,
                                   Z.ACCESS_TIME, Z.GOO_ID, Z.EXAMOUNT,
                                   Z.SUP_GROUP_NAME, Z.AUDIT_TIME,
                                   Z.CAUSE_DETAIL_ID, Z.FIRST_DEPT_ID,
                                   Z.SECOND_DEPT_ID,
                                   Z.SUPPLIER_CODE,
                                   REGEXP_SUBSTR(Z.SUP_GROUP_NAME,
                                                  '[^,]+',
                                                  1,
                                                  LEVEL) SUP_GROUP_NAME2
                              FROM SCMDATA.T_RETURN_MANAGEMENT Z
        CONNECT BY PRIOR RM_ID = RM_ID
               AND LEVEL <=
                   LENGTH(Z.SUP_GROUP_NAME) -
                   LENGTH(REGEXP_REPLACE(Z.SUP_GROUP_NAME, ',', '')) + 1
               AND PRIOR DBMS_RANDOM.VALUE IS NOT NULL) A
 INNER JOIN SCMDATA.T_COMMODITY_INFO B
    ON A.GOO_ID = B.GOO_ID
   AND A.COMPANY_ID = B.COMPANY_ID
  LEFT JOIN SCMDATA.T_ABNORMAL_DTL_CONFIG C
    ON A.CAUSE_DETAIL_ID = C.ABNORMAL_DTL_CONFIG_ID
   AND A.COMPANY_ID = C.COMPANY_ID
   AND C.ANOMALY_CLASSIFICATION = 'AC_QUALITY'
 INNER JOIN SCMDATA.SYS_COMPANY_DEPT D
    ON D.COMPANY_DEPT_ID = A.FIRST_DEPT_ID
 WHERE A.AUDIT_TIME IS NOT NULL
   AND C.CAUSE_CLASSIFICATION <> '银饰氧化问题'
   AND C.PROBLEM_CLASSIFICATION <> '非质量问题'
   AND D.DEPT_NAME = '供应链管理部'
 GROUP BY A.COMPANY_ID,
          A.YEAR,
          A.MONTH,
          TO_CHAR(A.ACCESS_TIME, 'yyyy-mm-dd'),
          B.CATEGORY,
          A.SUP_GROUP_NAME2,
          A.SUPPLIER_CODE) X
           ON X.COMPANY_ID = Y.COMPANY_ID
          AND X.YEAR = Y.YEAR
          AND X.MONTH = Y.MONTH
          AND X.RTKPI_DATE = Y.RTKPI_DATE
          AND X.CATEGORY = Y.CATEGORY
          AND X.GROUP_NAME = Y.GROUP_NAME
          AND X.COUNT_DIMENSION = Y.COUNT_DIMENSION
          AND X.DIMENSION_SORT = Y.DIMENSION_SORT
         /* LEFT JOIN
          --进货数据
          (  SELECT A.COMPANY_ID,
       EXTRACT(YEAR FROM A.CREATE_TIME) YEAR,
       EXTRACT(MONTH FROM A.CREATE_TIME) MONTH,
       TO_CHAR(A.CREATE_TIME, 'yyyy-mm-dd') RTKPI_DATE,
       D.CATEGORY,
       (CASE WHEN D.GROUP_NAME IS NULL THEN  '1'  ELSE D.GROUP_NAME END) GROUP_NAME,
       '04' COUNT_DIMENSION,
       C.SUPPLIER_CODE DIMENSION_SORT,
       SUM(B.AMOUNT * E.PRICE) ORDER_MONEY
  FROM SCMDATA.T_INGOOD A
 INNER JOIN SCMDATA.T_INGOODS B
    ON A.ING_ID = B.ING_ID
   AND A.COMPANY_ID = B.COMPANY_ID
 INNER JOIN SCMDATA.T_ORDERED C
    ON C.ORDER_CODE = A.DOCUMENT_NO
   AND A.COMPANY_ID = C.COMPANY_ID
 INNER JOIN SCMDATA.PT_ORDERED D
    ON D.ORDER_ID = C.ORDER_ID
   AND D.COMPANY_ID = C.COMPANY_ID
  INNER JOIN SCMDATA.T_COMMODITY_INFO E ON E.GOO_ID=B.GOO_ID AND E.COMPANY_ID=B.COMPANY_ID
 WHERE B.AMOUNT > 0
 GROUP BY A.COMPANY_ID,
          EXTRACT(YEAR FROM A.CREATE_TIME),
          EXTRACT(MONTH FROM A.CREATE_TIME),
          TO_CHAR(A.CREATE_TIME, 'yyyy-mm-dd'),
          D.CATEGORY,
          D.GROUP_NAME,
          C.SUPPLIER_CODE) z ON Z.COMPANY_ID = Y.COMPANY_ID
          AND Z.YEAR = Y.YEAR
          AND Z.MONTH = Y.MONTH
          AND Z.RTKPI_DATE = Y.RTKPI_DATE
          AND Z.CATEGORY = Y.CATEGORY
          AND Z.GROUP_NAME = Y.GROUP_NAME
          AND Z.COUNT_DIMENSION = Y.COUNT_DIMENSION
          AND Z.DIMENSION_SORT = Y.DIMENSION_SORT*/ ]';

      IF P_TYPE = 0 THEN
      --进货
      V_EXSQL1 := V_SQL1||V_WH_SQL2||V_U_SQL1||V_I_SQL1;
      --退货
      V_EXSQL2 := V_SQL2 || V_WH_SQL2 || V_U_SQL2 || V_I_SQL2;


    ELSIF P_TYPE = 1 THEN
      --进货
      V_EXSQL1 := V_SQL1||V_WM_SQL1||V_U_SQL1||V_I_SQL1;
      --退货
      V_EXSQL2 := V_SQL2 || V_WM_SQL1 || V_U_SQL2 || V_I_SQL2;
    END IF;
   EXECUTE IMMEDIATE V_EXSQL2;
    EXECUTE IMMEDIATE V_EXSQL1;
    --dbms_output.put_line(V_EXSQL1);
    --dbms_output.put_line(V_EXSQL2);

    --跟单
    V_SQL1:=q'[MERGE INTO SCMDATA.T_RTKPI_THISMONTH A
USING ( SELECT Y.COMPANY_ID, Y.YEAR, Y.MONTH, to_date(y.RTKPI_DATE,'yyyy-mm-dd') RTKPI_DATE, Y.CATEGORY,
              Y.GROUP_NAME, Y.COUNT_DIMENSION,
              Y.DIMENSION_SORT,
              Y.ORDER_MONEY INGOOD_MONEY
     FROM (SELECT A.COMPANY_ID, EXTRACT(YEAR FROM A.CREATE_TIME) YEAR,
                    EXTRACT(MONTH FROM A.CREATE_TIME) MONTH,
                    TO_CHAR(A.CREATE_TIME, 'yyyy-mm-dd') RTKPI_DATE,
                    E.CATEGORY,
                    (CASE WHEN D.GROUP_NAME IS NULL THEN  '1' ELSE D.GROUP_NAME END) GROUP_NAME, 
                    '05' COUNT_DIMENSION,
                    (CASE  WHEN D.GENDAN IS NULL OR D.GENDAN= 'ORDERED_ITF' THEN '1'
                      ELSE    D.GENDAN   END) DIMENSION_SORT,
                    SUM(CASE
                          WHEN REGEXP_COUNT(D.FLW_ORDER, ',') > 0 THEN
                           A.AMOUNT / NVL((REGEXP_COUNT(D.FLW_ORDER, ',') + 1),1) *
                           E.PRICE
                          ELSE
                           A.AMOUNT * E.PRICE
                        END) ORDER_MONEY
               FROM (SELECT T.DOCUMENT_NO,
                    T.COMPANY_ID,
                    TRUNC(T.CREATE_TIME) CREATE_TIME,
                    SUM(TL.AMOUNT) AMOUNT,
                    T.SUPPLIER_CODE,
                    TL.GOO_ID
               FROM SCMDATA.T_INGOOD T
              INNER JOIN (SELECT TI.ING_ID,
                                TI.COMPANY_ID,
                                TI.GOO_ID,
                                TI.AMOUNT
                           FROM SCMDATA.T_INGOODS TI
                          WHERE TI.AMOUNT > 0) TL
                 ON TL.ING_ID = T.ING_ID
                AND TL.COMPANY_ID = T.COMPANY_ID
              WHERE TO_CHAR(T.CREATE_TIME, 'yyyy') >= 2022
              GROUP BY T.DOCUMENT_NO,
                       T.COMPANY_ID,
                       TRUNC(T.CREATE_TIME),
                       T.SUPPLIER_CODE,
                       TL.GOO_ID) A
                  /*SCMDATA.T_INGOOD A
                 INNER JOIN SCMDATA.T_INGOODS B
                    ON A.ING_ID = B.ING_ID
                   AND A.COMPANY_ID = B.COMPANY_ID
                 LEFT JOIN SCMDATA.T_ORDERED C
                    ON C.ORDER_CODE = A.DOCUMENT_NO
                   AND A.COMPANY_ID = C.COMPANY_ID*/
              LEFT JOIN (SELECT Z.*,
                                REGEXP_SUBSTR(Z.FLW_ORDER, '[^,]+', 1, LEVEL) GENDAN
                           FROM SCMDATA.PT_ORDERED Z
                         CONNECT BY PRIOR Z.PT_ORDERED_ID = Z.PT_ORDERED_ID
                                AND LEVEL <=
                                    LENGTH(Z.FLW_ORDER) -
                                    LENGTH(REGEXP_REPLACE(Z.FLW_ORDER,
                                                          ',',
                                                          '')) + 1
                                AND PRIOR DBMS_RANDOM.VALUE IS NOT NULL) D
                 ON D.PRODUCT_GRESS_CODE  = A.DOCUMENT_NO
                AND D.COMPANY_ID = A.COMPANY_ID
               INNER JOIN SCMDATA.T_COMMODITY_INFO E ON E.GOO_ID=A.GOO_ID AND E.COMPANY_ID=A.COMPANY_ID
              --WHERE B.AMOUNT > 0
              GROUP BY A.COMPANY_ID, EXTRACT(YEAR FROM A.CREATE_TIME),
                       EXTRACT(MONTH FROM A.CREATE_TIME),
                       TO_CHAR(A.CREATE_TIME, 'yyyy-mm-dd'), E.CATEGORY,
                       (CASE WHEN D.GROUP_NAME IS NULL THEN  '1' ELSE D.GROUP_NAME END),
                       (CASE  WHEN D.GENDAN IS NULL OR D.GENDAN= 'ORDERED_ITF' THEN '1'
                      ELSE    D.GENDAN   END)) Y ]';

    V_SQL2 := q'[  MERGE INTO SCMDATA.T_RTKPI_THISMONTH A
USING (
WITH TEMP_RT AS
 (SELECT Z.*,
         Z.RM_ID || ROW_NUMBER() OVER(PARTITION BY Z.RM_ID ORDER BY 1) RM_ID2,
         Z.EXAMOUNT / (COUNT(Z.RM_ID) OVER(PARTITION BY(Z.RM_ID))) EXGAMOUNT2,
         REGEXP_SUBSTR(Z.SUP_GROUP_NAME, '[^,]+', 1, LEVEL) SUP_GROUP_NAME2
    FROM SCMDATA.T_RETURN_MANAGEMENT Z
   WHERE Z.AUDIT_TIME IS NOT NULL
  CONNECT BY PRIOR RM_ID = RM_ID
         AND LEVEL <= LENGTH(Z.SUP_GROUP_NAME) -
             LENGTH(REGEXP_REPLACE(Z.SUP_GROUP_NAME, ',', '')) + 1
         AND PRIOR DBMS_RANDOM.VALUE IS NOT NULL)

SELECT Y.COMPANY_ID, Y.YEAR, Y.MONTH, to_date(y.RTKPI_DATE,'yyyy-mm-dd') RTKPI_DATE, Y.CATEGORY, Y.GROUP_NAME,
       Y.COUNT_DIMENSION, Y.DIMENSION_SORT, /*Z.ORDER_MONEY INGOOD_MONEY,*/
       Y.RMMONEY SHOP_RT_ORIGINAL_MONEY, X.RMMONEY2 SHOP_RT_MONEY

  FROM (SELECT A.COMPANY_ID, A.YEAR, A.MONTH,
                TO_CHAR(A.ACCESS_TIME, 'yyyy-mm-dd') RTKPI_DATE, B.CATEGORY,
                (CASE
                  WHEN A.SUP_GROUP_NAME2 IS NULL THEN
                   '1'
                  ELSE
                   A.SUP_GROUP_NAME2
                END) GROUP_NAME, '05' COUNT_DIMENSION,
                (CASE
                  WHEN A.GENDAN2 IS NULL THEN
                   '1'
                  ELSE
                   A.GENDAN2
                END) DIMENSION_SORT, SUM(A.EXGAMOUNT3 * B.PRICE) RMMONEY
           FROM (SELECT Z.RM_ID, Z.COMPANY_ID, Z.YEAR, Z.MONTH, Z.ACCESS_TIME,
                         Z.GOO_ID, Z.EXAMOUNT, Z.SUP_GROUP_NAME, Z.AUDIT_TIME,
                         Z.SUP_GROUP_NAME2,
                         Z.EXGAMOUNT2 / NVL((REGEXP_COUNT(Z.MERCHER_ID, ',') + 1),1) EXGAMOUNT3,
                         REGEXP_SUBSTR(Z.MERCHER_ID, '[^,]+', 1, LEVEL) GENDAN2
                    FROM TEMP_RT Z

                  CONNECT BY PRIOR Z.RM_ID2 = Z.RM_ID2
                         AND LEVEL <=
                             LENGTH(Z.MERCHER_ID) -
                             LENGTH(REGEXP_REPLACE(Z.MERCHER_ID, ',', '')) + 1
                         AND PRIOR DBMS_RANDOM.VALUE IS NOT NULL) A
          INNER JOIN SCMDATA.T_COMMODITY_INFO B
             ON A.GOO_ID = B.GOO_ID
            AND A.COMPANY_ID = B.COMPANY_ID
          WHERE A.AUDIT_TIME IS NOT NULL
          GROUP BY A.COMPANY_ID, A.YEAR, A.MONTH,
                   TO_CHAR(A.ACCESS_TIME, 'yyyy-mm-dd'), B.CATEGORY,
                   A.SUP_GROUP_NAME2, A.GENDAN2) Y

  LEFT JOIN (SELECT A.COMPANY_ID, A.YEAR, A.MONTH,
                    TO_CHAR(A.ACCESS_TIME, 'yyyy-mm-dd') RTKPI_DATE,
                    B.CATEGORY,
                    (CASE
                      WHEN A.SUP_GROUP_NAME2 IS NULL THEN
                       '1'
                      ELSE
                       A.SUP_GROUP_NAME2
                    END) GROUP_NAME, '05' COUNT_DIMENSION,
                    (CASE
                      WHEN A.GENDAN2 IS NULL THEN
                       '1'
                      ELSE
                       A.GENDAN2
                    END) DIMENSION_SORT, SUM(A.EXGAMOUNT3 * B.PRICE) RMMONEY2
               FROM (SELECT Z.RM_ID, Z.COMPANY_ID, Z.YEAR, Z.MONTH,
                             Z.ACCESS_TIME, Z.GOO_ID, Z.EXAMOUNT,
                             Z.SUP_GROUP_NAME, Z.AUDIT_TIME, Z.CAUSE_DETAIL_ID,
                             Z.FIRST_DEPT_ID, Z.SUP_GROUP_NAME2,
                             Z.SECOND_DEPT_ID,
                             Z.EXGAMOUNT2 /
                              NVL((REGEXP_COUNT(Z.MERCHER_ID, ',') + 1),1) EXGAMOUNT3,
                             REGEXP_SUBSTR(Z.MERCHER_ID, '[^,]+', 1, LEVEL) GENDAN2
                        FROM TEMP_RT Z

                      CONNECT BY PRIOR Z.RM_ID2 = Z.RM_ID2
                             AND LEVEL <=
                                 LENGTH(Z.MERCHER_ID) -
                                 LENGTH(REGEXP_REPLACE(Z.MERCHER_ID, ',', '')) + 1
                             AND PRIOR DBMS_RANDOM.VALUE IS NOT NULL) A
              INNER JOIN SCMDATA.T_COMMODITY_INFO B
                 ON A.GOO_ID = B.GOO_ID
                AND A.COMPANY_ID = B.COMPANY_ID
               LEFT JOIN SCMDATA.T_ABNORMAL_DTL_CONFIG C
                 ON A.CAUSE_DETAIL_ID = C.ABNORMAL_DTL_CONFIG_ID
                AND A.COMPANY_ID = C.COMPANY_ID
                AND C.ANOMALY_CLASSIFICATION = 'AC_QUALITY'
              INNER JOIN SCMDATA.SYS_COMPANY_DEPT D
                 ON D.COMPANY_DEPT_ID = A.FIRST_DEPT_ID
              WHERE A.AUDIT_TIME IS NOT NULL
                AND C.CAUSE_CLASSIFICATION <> '银饰氧化问题'
                AND C.PROBLEM_CLASSIFICATION <> '非质量问题'
                AND D.DEPT_NAME = '供应链管理部'
                AND INSTR(A.SECOND_DEPT_ID,
                          'b550778b4f2d36b4e0533c281caca074') > 0
              GROUP BY A.COMPANY_ID, A.YEAR, A.MONTH,
                       TO_CHAR(A.ACCESS_TIME, 'yyyy-mm-dd'), B.CATEGORY,
                       A.SUP_GROUP_NAME2, A.GENDAN2) X
    ON X.COMPANY_ID = Y.COMPANY_ID
   AND X.YEAR = Y.YEAR
   AND X.MONTH = Y.MONTH
   AND X.RTKPI_DATE = Y.RTKPI_DATE
   AND X.CATEGORY = Y.CATEGORY
   AND X.GROUP_NAME = Y.GROUP_NAME
   AND X.COUNT_DIMENSION = Y.COUNT_DIMENSION
   AND X.DIMENSION_SORT = Y.DIMENSION_SORT
  /*LEFT JOIN (SELECT A.COMPANY_ID, EXTRACT(YEAR FROM A.CREATE_TIME) YEAR,
                    EXTRACT(MONTH FROM A.CREATE_TIME) MONTH,
                    TO_CHAR(A.CREATE_TIME, 'yyyy-mm-dd') RTKPI_DATE,
                    D.CATEGORY,
                    (CASE
                      WHEN D.GROUP_NAME IS NULL THEN
                       '1'
                      ELSE
                       D.GROUP_NAME
                    END) GROUP_NAME, '05' COUNT_DIMENSION,
                    (CASE
                      WHEN D.GENDAN IS NULL THEN
                       '1'
                      ELSE
                       D.GENDAN
                    END) DIMENSION_SORT,
                    SUM(CASE
                          WHEN REGEXP_COUNT(D.FLW_ORDER, ',') > 0 THEN
                           B.AMOUNT / NVL((REGEXP_COUNT(D.FLW_ORDER, ',') + 1),1) *
                           E.PRICE
                          ELSE
                           B.AMOUNT * E.PRICE
                        END) ORDER_MONEY
               FROM SCMDATA.T_INGOOD A
              INNER JOIN SCMDATA.T_INGOODS B
                 ON A.ING_ID = B.ING_ID
                AND A.COMPANY_ID = B.COMPANY_ID
              INNER JOIN SCMDATA.T_ORDERED C
                 ON C.ORDER_CODE = A.DOCUMENT_NO
                AND A.COMPANY_ID = C.COMPANY_ID
              INNER JOIN (SELECT Z.*,
                                REGEXP_SUBSTR(Z.FLW_ORDER, '[^,]+', 1, LEVEL) GENDAN
                           FROM SCMDATA.PT_ORDERED Z
                         CONNECT BY PRIOR Z.PT_ORDERED_ID = Z.PT_ORDERED_ID
                                AND LEVEL <=
                                    LENGTH(Z.FLW_ORDER) -
                                    LENGTH(REGEXP_REPLACE(Z.FLW_ORDER,
                                                          ',',
                                                          '')) + 1
                                AND PRIOR DBMS_RANDOM.VALUE IS NOT NULL) D
                 ON D.ORDER_ID = C.ORDER_ID
                AND D.COMPANY_ID = C.COMPANY_ID
               INNER JOIN SCMDATA.T_COMMODITY_INFO E ON E.GOO_ID=B.GOO_ID AND E.COMPANY_ID=B.COMPANY_ID
              WHERE B.AMOUNT > 0
              GROUP BY A.COMPANY_ID, EXTRACT(YEAR FROM A.CREATE_TIME),
                       EXTRACT(MONTH FROM A.CREATE_TIME),
                       TO_CHAR(A.CREATE_TIME, 'yyyy-mm-dd'), D.CATEGORY,
                       D.GROUP_NAME, D.GENDAN) Z
    ON Z.COMPANY_ID = Y.COMPANY_ID
   AND Z.YEAR = Y.YEAR
   AND Z.MONTH = Y.MONTH
   AND Z.RTKPI_DATE = Y.RTKPI_DATE
   AND Z.CATEGORY = Y.CATEGORY
   AND Z.GROUP_NAME = Y.GROUP_NAME
   AND Z.COUNT_DIMENSION = Y.COUNT_DIMENSION
   AND Z.DIMENSION_SORT = Y.DIMENSION_SORT*/ ]';
      IF P_TYPE = 0 THEN
      --进货
      V_EXSQL1 := V_SQL1||V_WH_SQL2||V_U_SQL1||V_I_SQL1;
      --退货
      V_EXSQL2 := V_SQL2 || V_WH_SQL2 || V_U_SQL2 || V_I_SQL2;


    ELSIF P_TYPE = 1 THEN
      --进货
      V_EXSQL1 := V_SQL1||V_WM_SQL1||V_U_SQL1||V_I_SQL1;
      --退货
      V_EXSQL2 := V_SQL2 || V_WM_SQL1 || V_U_SQL2 || V_I_SQL2;
    END IF;
    EXECUTE IMMEDIATE V_EXSQL2;
    EXECUTE IMMEDIATE V_EXSQL1;
    --dbms_output.put_line(V_EXSQL1);
    --dbms_output.put_line(V_EXSQL2);

    -- 06跟单主管
    V_SQL1:=q'[MERGE INTO SCMDATA.T_RTKPI_THISMONTH A
USING (SELECT Y.COMPANY_ID, Y.YEAR, Y.MONTH, to_date(y.RTKPI_DATE,'yyyy-mm-dd') RTKPI_DATE, Y.CATEGORY,
              Y.GROUP_NAME, Y.COUNT_DIMENSION, Y.DIMENSION_SORT,
              Y.ORDER_MONEY INGOOD_MONEY
     FROM (SELECT A.COMPANY_ID, EXTRACT(YEAR FROM A.CREATE_TIME) YEAR,
                      EXTRACT(MONTH FROM A.CREATE_TIME) MONTH,
                      TO_CHAR(A.CREATE_TIME, 'yyyy-mm-dd') RTKPI_DATE,
                      E.CATEGORY,
                      (CASE WHEN D.GROUP_NAME IS NULL THEN '1' ELSE D.GROUP_NAME END) GROUP_NAME,
                       '06' COUNT_DIMENSION,
                      (CASE WHEN D.GENDANZG IS NULL THEN '1' ELSE D.GENDANZG END) DIMENSION_SORT,
                      SUM(CASE
                            WHEN REGEXP_COUNT(D.FLW_ORDER_MANAGER, ',') > 0 THEN
                             A.AMOUNT /
                             NVL((REGEXP_COUNT(D.FLW_ORDER_MANAGER, ',') + 1),1) *
                             E.PRICE
                            ELSE
                             A.AMOUNT * E.PRICE
                          END) ORDER_MONEY
                 FROM (SELECT T.DOCUMENT_NO,
                    T.COMPANY_ID,
                    TRUNC(T.CREATE_TIME) CREATE_TIME,
                    SUM(TL.AMOUNT) AMOUNT,
                    T.SUPPLIER_CODE,
                    TL.GOO_ID
               FROM SCMDATA.T_INGOOD T
              INNER JOIN (SELECT TI.ING_ID,
                                TI.COMPANY_ID,
                                TI.GOO_ID,
                                TI.AMOUNT
                           FROM SCMDATA.T_INGOODS TI
                          WHERE TI.AMOUNT > 0) TL
                 ON TL.ING_ID = T.ING_ID
                AND TL.COMPANY_ID = T.COMPANY_ID
              WHERE TO_CHAR(T.CREATE_TIME, 'yyyy') >= 2022
              GROUP BY T.DOCUMENT_NO,
                       T.COMPANY_ID,
                       TRUNC(T.CREATE_TIME),
                       T.SUPPLIER_CODE,
                       TL.GOO_ID) A
                  /*SCMDATA.T_INGOOD A
                 INNER JOIN SCMDATA.T_INGOODS B
                    ON A.ING_ID = B.ING_ID
                   AND A.COMPANY_ID = B.COMPANY_ID
                 LEFT JOIN SCMDATA.T_ORDERED C
                    ON C.ORDER_CODE = A.DOCUMENT_NO
                   AND A.COMPANY_ID = C.COMPANY_ID*/
                LEFT JOIN (SELECT Z.*,
                                  REGEXP_SUBSTR(Z.FLW_ORDER_MANAGER,
                                                 '[^,]+',
                                                 1,
                                                 LEVEL) GENDANZG
                             FROM SCMDATA.PT_ORDERED Z
                           CONNECT BY PRIOR Z.PT_ORDERED_ID = Z.PT_ORDERED_ID
                                  AND LEVEL <=
                                      LENGTH(Z.FLW_ORDER_MANAGER) -
                                      LENGTH(REGEXP_REPLACE(Z.FLW_ORDER_MANAGER,
                                                            ',',
                                                            '')) + 1
                                  AND PRIOR DBMS_RANDOM.VALUE IS NOT NULL) D
                   ON D.PRODUCT_GRESS_CODE  = A.DOCUMENT_NO
                  AND D.COMPANY_ID = A.COMPANY_ID
                 INNER JOIN SCMDATA.T_COMMODITY_INFO E ON E.GOO_ID=A.GOO_ID AND E.COMPANY_ID=A.COMPANY_ID
                --WHERE B.AMOUNT > 0
                GROUP BY A.COMPANY_ID, EXTRACT(YEAR FROM A.CREATE_TIME),
                         EXTRACT(MONTH FROM A.CREATE_TIME),
                         TO_CHAR(A.CREATE_TIME, 'yyyy-mm-dd'), E.CATEGORY,
                         D.GROUP_NAME, D.GENDANZG) Y ]';

    V_SQL2 := q'[MERGE INTO SCMDATA.T_RTKPI_THISMONTH A
USING (
  WITH TEMP_RT AS
   (SELECT Z.*,
           Z.RM_ID || ROW_NUMBER() OVER(PARTITION BY Z.RM_ID ORDER BY 1) RM_ID2,
           Z.EXAMOUNT / (COUNT(Z.RM_ID) OVER(PARTITION BY(Z.RM_ID))) EXGAMOUNT2,
           REGEXP_SUBSTR(Z.SUP_GROUP_NAME, '[^,]+', 1, LEVEL) SUP_GROUP_NAME2
      FROM SCMDATA.T_RETURN_MANAGEMENT Z
     WHERE Z.AUDIT_TIME IS NOT NULL
    CONNECT BY PRIOR RM_ID = RM_ID
           AND LEVEL <=
               LENGTH(Z.SUP_GROUP_NAME) -
               LENGTH(REGEXP_REPLACE(Z.SUP_GROUP_NAME, ',', '')) + 1
           AND PRIOR DBMS_RANDOM.VALUE IS NOT NULL)
  SELECT Y.COMPANY_ID, Y.YEAR, Y.MONTH, to_date(y.RTKPI_DATE,'yyyy-mm-dd') RTKPI_DATE, Y.CATEGORY,
         Y.GROUP_NAME, Y.COUNT_DIMENSION, Y.DIMENSION_SORT,
         /*Z.ORDER_MONEY INGOOD_MONEY,*/ Y.RMMONEY SHOP_RT_ORIGINAL_MONEY,
         X.RMMONEY2 SHOP_RT_MONEY

    FROM (SELECT A.COMPANY_ID, A.YEAR, A.MONTH,
                  TO_CHAR(A.ACCESS_TIME, 'yyyy-mm-dd') RTKPI_DATE, B.CATEGORY,
                  (CASE WHEN A.SUP_GROUP_NAME2 IS NULL THEN  '1'  ELSE  A.SUP_GROUP_NAME2  END) GROUP_NAME,
                   '06' COUNT_DIMENSION,
                  (CASE WHEN A.GENDANZG2 IS NULL THEN '1' ELSE A.GENDANZG2 END) DIMENSION_SORT,
                  SUM(A.EXGAMOUNT3 * B.PRICE) RMMONEY
             FROM (SELECT Z.RM_ID, Z.COMPANY_ID, Z.YEAR, Z.MONTH, Z.ACCESS_TIME,
                           Z.GOO_ID, Z.EXAMOUNT, Z.SUP_GROUP_NAME, Z.AUDIT_TIME,Z.SUP_GROUP_NAME2,
                           Z.EXGAMOUNT2 /
                            NVL((REGEXP_COUNT(Z.MERCHER_DIRECTOR_ID, ',') + 1),1) EXGAMOUNT3,
                           REGEXP_SUBSTR(Z.MERCHER_DIRECTOR_ID,
                                          '[^,]+',
                                          1,
                                          LEVEL) GENDANZG2
                      FROM TEMP_RT Z

                    CONNECT BY PRIOR Z.RM_ID2 = Z.RM_ID2
                           AND LEVEL <= LENGTH(Z.MERCHER_DIRECTOR_ID) -
                               LENGTH(REGEXP_REPLACE(Z.MERCHER_DIRECTOR_ID, ',','')) + 1
                           AND PRIOR DBMS_RANDOM.VALUE IS NOT NULL) A
            INNER JOIN SCMDATA.T_COMMODITY_INFO B
               ON A.GOO_ID = B.GOO_ID
              AND A.COMPANY_ID = B.COMPANY_ID
            WHERE A.AUDIT_TIME IS NOT NULL
            GROUP BY A.COMPANY_ID, A.YEAR, A.MONTH,
                     TO_CHAR(A.ACCESS_TIME, 'yyyy-mm-dd'), B.CATEGORY,
                     A.SUP_GROUP_NAME2, A.GENDANZG2) Y

    LEFT JOIN (SELECT A.COMPANY_ID, A.YEAR, A.MONTH,
                      TO_CHAR(A.ACCESS_TIME, 'yyyy-mm-dd') RTKPI_DATE,
                      B.CATEGORY,
                      (CASE WHEN A.SUP_GROUP_NAME2 IS NULL THEN '1'ELSE A.SUP_GROUP_NAME2 END) GROUP_NAME,
                       '06' COUNT_DIMENSION,
                      (CASE WHEN A.GENDANZG2 IS NULL THEN '1' ELSE A.GENDANZG2 END) DIMENSION_SORT,
                      SUM(A.EXGAMOUNT3 * B.PRICE) RMMONEY2
                 FROM (SELECT Z.RM_ID, Z.COMPANY_ID, Z.YEAR, Z.MONTH,
                               Z.ACCESS_TIME, Z.GOO_ID, Z.EXAMOUNT,
                               Z.SUP_GROUP_NAME, Z.AUDIT_TIME,
                               Z.CAUSE_DETAIL_ID, Z.FIRST_DEPT_ID,Z.SUP_GROUP_NAME2,
                               Z.SECOND_DEPT_ID,
                               Z.EXGAMOUNT2 /
                                NVL((REGEXP_COUNT(Z.MERCHER_DIRECTOR_ID, ',') + 1),1) EXGAMOUNT3,
                               REGEXP_SUBSTR(Z.MERCHER_DIRECTOR_ID, '[^,]+', 1, LEVEL) GENDANZG2
                          FROM TEMP_RT Z

                        CONNECT BY PRIOR Z.RM_ID2 = Z.RM_ID2
                               AND LEVEL <=
                                   LENGTH(Z.MERCHER_DIRECTOR_ID) -
                                   LENGTH(REGEXP_REPLACE(Z.MERCHER_DIRECTOR_ID, ',', '')) + 1
                               AND PRIOR DBMS_RANDOM.VALUE IS NOT NULL) A
                INNER JOIN SCMDATA.T_COMMODITY_INFO B
                   ON A.GOO_ID = B.GOO_ID
                  AND A.COMPANY_ID = B.COMPANY_ID
                 LEFT JOIN SCMDATA.T_ABNORMAL_DTL_CONFIG C
                   ON A.CAUSE_DETAIL_ID = C.ABNORMAL_DTL_CONFIG_ID
                  AND A.COMPANY_ID = C.COMPANY_ID
                  AND C.ANOMALY_CLASSIFICATION = 'AC_QUALITY'
                INNER JOIN SCMDATA.SYS_COMPANY_DEPT D
                   ON D.COMPANY_DEPT_ID = A.FIRST_DEPT_ID
                WHERE A.AUDIT_TIME IS NOT NULL
                  AND C.CAUSE_CLASSIFICATION <> '银饰氧化问题'
                  AND C.PROBLEM_CLASSIFICATION <> '非质量问题'
                  AND D.DEPT_NAME = '供应链管理部'
                  AND INSTR(A.SECOND_DEPT_ID,
                            'b550778b4f2d36b4e0533c281caca074') > 0
                GROUP BY A.COMPANY_ID, A.YEAR, A.MONTH,
                         TO_CHAR(A.ACCESS_TIME, 'yyyy-mm-dd'), B.CATEGORY,
                         A.SUP_GROUP_NAME2, A.GENDANZG2) X
      ON X.COMPANY_ID = Y.COMPANY_ID
     AND X.YEAR = Y.YEAR
     AND X.MONTH = Y.MONTH
     AND X.RTKPI_DATE = Y.RTKPI_DATE
     AND X.CATEGORY = Y.CATEGORY
     AND X.GROUP_NAME = Y.GROUP_NAME
     AND X.COUNT_DIMENSION = Y.COUNT_DIMENSION
     AND X.DIMENSION_SORT = Y.DIMENSION_SORT
   /* LEFT JOIN (SELECT A.COMPANY_ID, EXTRACT(YEAR FROM A.CREATE_TIME) YEAR,
                      EXTRACT(MONTH FROM A.CREATE_TIME) MONTH,
                      TO_CHAR(A.CREATE_TIME, 'yyyy-mm-dd') RTKPI_DATE,
                      D.CATEGORY,
                      (CASE WHEN D.GROUP_NAME IS NULL THEN '1' ELSE D.GROUP_NAME END) GROUP_NAME,
                       '06' COUNT_DIMENSION,
                      (CASE WHEN D.GENDANZG IS NULL THEN '1' ELSE D.GENDANZG END) DIMENSION_SORT,
                      SUM(CASE
                            WHEN REGEXP_COUNT(D.FLW_ORDER_MANAGER, ',') > 0 THEN
                             B.AMOUNT /
                             NVL((REGEXP_COUNT(D.FLW_ORDER_MANAGER, ',') + 1),1) *
                             E.PRICE
                            ELSE
                             B.AMOUNT * E.PRICE
                          END) ORDER_MONEY
                 FROM SCMDATA.T_INGOOD A
                INNER JOIN SCMDATA.T_INGOODS B
                   ON A.ING_ID = B.ING_ID
                  AND A.COMPANY_ID = B.COMPANY_ID
                INNER JOIN SCMDATA.T_ORDERED C
                   ON C.ORDER_CODE = A.DOCUMENT_NO
                  AND A.COMPANY_ID = C.COMPANY_ID
                INNER JOIN (SELECT Z.*,
                                  REGEXP_SUBSTR(Z.FLW_ORDER_MANAGER,
                                                 '[^,]+',
                                                 1,
                                                 LEVEL) GENDANZG
                             FROM SCMDATA.PT_ORDERED Z
                           CONNECT BY PRIOR Z.PT_ORDERED_ID = Z.PT_ORDERED_ID
                                  AND LEVEL <=
                                      LENGTH(Z.FLW_ORDER_MANAGER) -
                                      LENGTH(REGEXP_REPLACE(Z.FLW_ORDER_MANAGER,
                                                            ',',
                                                            '')) + 1
                                  AND PRIOR DBMS_RANDOM.VALUE IS NOT NULL) D
                   ON D.ORDER_ID = C.ORDER_ID
                  AND D.COMPANY_ID = C.COMPANY_ID
                 INNER JOIN SCMDATA.T_COMMODITY_INFO E ON E.GOO_ID=B.GOO_ID AND E.COMPANY_ID=B.COMPANY_ID
                WHERE B.AMOUNT > 0
                GROUP BY A.COMPANY_ID, EXTRACT(YEAR FROM A.CREATE_TIME),
                         EXTRACT(MONTH FROM A.CREATE_TIME),
                         TO_CHAR(A.CREATE_TIME, 'yyyy-mm-dd'), D.CATEGORY,
                         D.GROUP_NAME, D.GENDANZG) Z
      ON Z.COMPANY_ID = Y.COMPANY_ID
     AND Z.YEAR = Y.YEAR
     AND Z.MONTH = Y.MONTH
     AND Z.RTKPI_DATE = Y.RTKPI_DATE
     AND Z.CATEGORY = Y.CATEGORY
     AND Z.GROUP_NAME = Y.GROUP_NAME
     AND Z.COUNT_DIMENSION = Y.COUNT_DIMENSION
     AND Z.DIMENSION_SORT = Y.DIMENSION_SORT*/  ]';
    IF P_TYPE = 0 THEN
      --进货
      V_EXSQL1 := V_SQL1||V_WH_SQL2||V_U_SQL1||V_I_SQL1;
      --退货
      V_EXSQL2 := V_SQL2 || V_WH_SQL2 || V_U_SQL2 || V_I_SQL2;


    ELSIF P_TYPE = 1 THEN
      --进货
      V_EXSQL1 := V_SQL1||V_WM_SQL1 ||V_U_SQL1||V_I_SQL1;
      --退货
      V_EXSQL2 := V_SQL2 || V_WM_SQL1 || V_U_SQL2 || V_I_SQL2;
    END IF;
    EXECUTE IMMEDIATE V_EXSQL2;
    EXECUTE IMMEDIATE V_EXSQL1;
    --dbms_output.put_line(V_EXSQL1);
    --dbms_output.put_line(V_EXSQL2);

    --07qc
    V_SQL1:=q'[ MERGE INTO SCMDATA.T_RTKPI_THISMONTH A
USING ( WITH TEMP_PTORDER AS
 (SELECT T1.PT_ORDERED_ID, T1.GOO_ID_PR,
         T1.PT_ORDERED_ID || ROW_NUMBER() OVER(PARTITION BY T1.PT_ORDERED_ID ORDER BY 1) ID2,
         T1.COMPANY_ID, T1.PRODUCT_GRESS_CODE, T1.ORDER_MONEY,
         (T1.ORDER_MONEY / COUNT(T1.PRODUCT_GRESS_CODE)
           OVER(PARTITION BY T1.PRODUCT_GRESS_CODE)) SUM1,
         REGEXP_SUBSTR(T1.QC, '[^,]+', 1, LEVEL) QC2
    FROM SCMDATA.PT_ORDERED T1
   WHERE T1.QC IS NOT NULL
  CONNECT BY PRIOR T1.PT_ORDERED_ID = T1.PT_ORDERED_ID
         AND LEVEL <=
             LENGTH(T1.QC) - LENGTH(REGEXP_REPLACE(T1.QC, ',', '')) + 1
         AND PRIOR DBMS_RANDOM.VALUE IS NOT NULL)
SELECT Y.COMPANY_ID, Y.YEAR, Y.MONTH, to_date(y.RTKPI_DATE,'yyyy-mm-dd') RTKPI_DATE, Y.CATEGORY, Y.GROUP_NAME,
       Y.COUNT_DIMENSION, Y.DIMENSION_SORT, Y.ORDER_MONEY INGOOD_MONEY
     FROM (SELECT A.COMPANY_ID, EXTRACT(YEAR FROM A.CREATE_TIME) YEAR,
                    EXTRACT(MONTH FROM A.CREATE_TIME) MONTH,
                    TO_CHAR(A.CREATE_TIME, 'yyyy-mm-dd') RTKPI_DATE,
                    E.CATEGORY,
                    (CASE  WHEN D.GROUP_NAME IS NULL THEN '1'  ELSE  D.GROUP_NAME  END) GROUP_NAME,
                     '07' COUNT_DIMENSION,
                    (CASE WHEN D.QC2 IS NULL THEN '1' ELSE  D.QC2  END) DIMENSION_SORT,
                    SUM(CASE
                          WHEN REGEXP_COUNT(D.QC, ',') > 0 THEN
                           A.AMOUNT / NVL((REGEXP_COUNT(D.QC, ',') + 1),1) *
                           E.PRICE
                          ELSE
                           A.AMOUNT * E.PRICE
                        END) ORDER_MONEY
               FROM (SELECT T.DOCUMENT_NO,
                    T.COMPANY_ID,
                    TRUNC(T.CREATE_TIME) CREATE_TIME,
                    SUM(TL.AMOUNT) AMOUNT,
                    T.SUPPLIER_CODE,
                    TL.GOO_ID
               FROM SCMDATA.T_INGOOD T
              INNER JOIN (SELECT TI.ING_ID,
                                TI.COMPANY_ID,
                                TI.GOO_ID,
                                TI.AMOUNT
                           FROM SCMDATA.T_INGOODS TI
                          WHERE TI.AMOUNT > 0) TL
                 ON TL.ING_ID = T.ING_ID
                AND TL.COMPANY_ID = T.COMPANY_ID
              WHERE TO_CHAR(T.CREATE_TIME, 'yyyy') >= 2022
              GROUP BY T.DOCUMENT_NO,
                       T.COMPANY_ID,
                       TRUNC(T.CREATE_TIME),
                       T.SUPPLIER_CODE,
                       TL.GOO_ID) A
                  /*SCMDATA.T_INGOOD A
                 INNER JOIN SCMDATA.T_INGOODS B
                    ON A.ING_ID = B.ING_ID
                   AND A.COMPANY_ID = B.COMPANY_ID
                 LEFT JOIN SCMDATA.T_ORDERED C
                    ON C.ORDER_CODE = A.DOCUMENT_NO
                   AND A.COMPANY_ID = C.COMPANY_ID*/
              LEFT JOIN (SELECT Z.*,
                                REGEXP_SUBSTR(Z.QC, '[^,]+', 1, LEVEL) QC2
                           FROM SCMDATA.PT_ORDERED Z
                         CONNECT BY PRIOR Z.PT_ORDERED_ID = Z.PT_ORDERED_ID
                                AND LEVEL <=
                                    LENGTH(Z.QC) -
                                    LENGTH(REGEXP_REPLACE(Z.QC, ',', '')) + 1
                                AND PRIOR DBMS_RANDOM.VALUE IS NOT NULL) D
                 ON D.PRODUCT_GRESS_CODE = A.DOCUMENT_NO
                AND D.COMPANY_ID = A.COMPANY_ID
               INNER JOIN SCMDATA.T_COMMODITY_INFO E ON E.GOO_ID=A.GOO_ID AND E.COMPANY_ID=A.COMPANY_ID
              --WHERE B.AMOUNT > 0
              GROUP BY A.COMPANY_ID, EXTRACT(YEAR FROM A.CREATE_TIME),
                       EXTRACT(MONTH FROM A.CREATE_TIME),
                       TO_CHAR(A.CREATE_TIME, 'yyyy-mm-dd'), E.CATEGORY,
                       D.GROUP_NAME, D.QC2) Y   ]';

    V_SQL2 := q'[  MERGE INTO SCMDATA.T_RTKPI_THISMONTH A
USING (
  WITH TEMP_RT AS
 (SELECT Z.RM_ID, Z.COMPANY_ID, Z.YEAR, Z.QUARTER, Z.MONTH, Z.ACCESS_TIME,Z.SUPPLIER_CODE,
         Z.GOO_ID, Z.EXAMOUNT, Z.QC_ID,
         Z.RM_ID || ROW_NUMBER() OVER(PARTITION BY Z.RM_ID ORDER BY 1) RM_ID2,
         Z.EXAMOUNT / (COUNT(Z.RM_ID) OVER(PARTITION BY(Z.RM_ID))) EXGAMOUNT2,
         REGEXP_SUBSTR(Z.SUP_GROUP_NAME, '[^,]+', 1, LEVEL) SUP_GROUP_NAME2
    FROM SCMDATA.T_RETURN_MANAGEMENT Z
   WHERE Z.AUDIT_TIME IS NOT NULL
  CONNECT BY PRIOR RM_ID = RM_ID
         AND LEVEL <= LENGTH(Z.SUP_GROUP_NAME) -
             LENGTH(REGEXP_REPLACE(Z.SUP_GROUP_NAME, ',', '')) + 1
         AND PRIOR DBMS_RANDOM.VALUE IS NOT NULL),
TEMP_RT2 AS
 (SELECT Z.RM_ID, Z.COMPANY_ID, Z.YEAR, Z.QUARTER, Z.MONTH, Z.ACCESS_TIME,Z.SUPPLIER_CODE,
         Z.GOO_ID, Z.EXAMOUNT, Z.QC_ID,
         Z.RM_ID || ROW_NUMBER() OVER(PARTITION BY Z.RM_ID ORDER BY 1) RM_ID2,
         Z.EXAMOUNT / (COUNT(Z.RM_ID) OVER(PARTITION BY(Z.RM_ID))) EXGAMOUNT2,
         REGEXP_SUBSTR(Z.SUP_GROUP_NAME, '[^,]+', 1, LEVEL) SUP_GROUP_NAME2
    FROM SCMDATA.T_RETURN_MANAGEMENT Z
    LEFT JOIN SCMDATA.T_ABNORMAL_DTL_CONFIG C
      ON Z.CAUSE_DETAIL_ID = C.ABNORMAL_DTL_CONFIG_ID
     AND Z.COMPANY_ID = C.COMPANY_ID
     AND C.ANOMALY_CLASSIFICATION = 'AC_QUALITY'
   INNER JOIN SCMDATA.SYS_COMPANY_DEPT D
      ON D.COMPANY_DEPT_ID = Z.FIRST_DEPT_ID
   WHERE Z.AUDIT_TIME IS NOT NULL
     AND C.CAUSE_CLASSIFICATION <> '银饰氧化问题'
     AND C.PROBLEM_CLASSIFICATION <> '非质量问题'
     AND D.DEPT_NAME = '供应链管理部'
     AND INSTR(Z.SECOND_DEPT_ID, 'b550778b4f2d36b4e0533c281caca074') > 0
  CONNECT BY PRIOR RM_ID = RM_ID
         AND LEVEL <= LENGTH(Z.SUP_GROUP_NAME) -
             LENGTH(REGEXP_REPLACE(Z.SUP_GROUP_NAME, ',', '')) + 1
         AND PRIOR DBMS_RANDOM.VALUE IS NOT NULL),
TEMP_PTORDER AS
 (SELECT T1.PT_ORDERED_ID, T1.GOO_ID_PR,T1.ORDER_ID, T1.DELIVERY_AMOUNT,
         T1.PT_ORDERED_ID || ROW_NUMBER() OVER(PARTITION BY T1.PT_ORDERED_ID ORDER BY 1) ID2,
         T1.COMPANY_ID, T1.PRODUCT_GRESS_CODE, T1.ORDER_MONEY,
         (T1.ORDER_MONEY / COUNT(T1.PRODUCT_GRESS_CODE)
           OVER(PARTITION BY T1.PRODUCT_GRESS_CODE)) SUM1,
         REGEXP_SUBSTR(T1.QC, '[^,]+', 1, LEVEL) QC2
    FROM SCMDATA.PT_ORDERED T1
   WHERE T1.QC IS NOT NULL
  CONNECT BY PRIOR T1.PT_ORDERED_ID = T1.PT_ORDERED_ID
         AND LEVEL <=
             LENGTH(T1.QC) - LENGTH(REGEXP_REPLACE(T1.QC, ',', '')) + 1
         AND PRIOR DBMS_RANDOM.VALUE IS NOT NULL)
SELECT Y.COMPANY_ID, Y.YEAR, Y.MONTH, to_date(y.RTKPI_DATE,'yyyy-mm-dd') RTKPI_DATE, Y.CATEGORY, Y.GROUP_NAME,
       '07' COUNT_DIMENSION, Y.DIMENSION_SORT DIMENSION_SORT, Y.RMMONEY SHOP_RT_ORIGINAL_MONEY,
       X.SHOP_RT_MONEY SHOP_RT_MONEY/*, Z.ORDER_MONEY INGOOD_MONEY*/
  FROM (SELECT A.COMPANY_ID, A.YEAR, A.MONTH,
                TO_CHAR(A.ACCESS_TIME, 'yyyy-mm-dd') RTKPI_DATE, B.CATEGORY,
                (CASE
                  WHEN A.SUP_GROUP_NAME2 IS NULL THEN
                   '1'
                  ELSE
                   A.SUP_GROUP_NAME2
                END) GROUP_NAME, '07' COUNT_DIMENSION, (CASE WHEN A.QC2 IS NULL THEN '1' ELSE A.QC2 END) DIMENSION_SORT,
                SUM(A.EXGAMOUNT3 * B.PRICE) RMMONEY
           FROM (SELECT Z.COMPANY_ID, Z.YEAR, Z.MONTH, Z.ACCESS_TIME, Z.GOO_ID,
                         Z.SUP_GROUP_NAME2,
                         Z.EXGAMOUNT2 / NVL((REGEXP_COUNT(Z.QC_ID, ',') + 1),1) EXGAMOUNT3,
                         REGEXP_SUBSTR(Z.QC_ID, '[^,]+', 1, LEVEL) QC2
                    FROM TEMP_RT Z
                   WHERE (EXISTS
                          (SELECT MAX(1)
                             FROM SCMDATA.T_PLAT_LOG X
                             INNER JOIN SCMDATA.T_PLAT_LOGS Y ON X.LOG_ID=Y.LOG_ID AND X.COMPANY_ID=Y.COMPANY_ID
                            WHERE X.APPLY_PK_ID = Z.RM_ID
                              AND Y.operate_field ='QC_ID'
                              AND X.ACTION_TYPE = 'UPDATE') OR
                          (NOT EXISTS
                           (SELECT MAX(1)
                              FROM SCMDATA.T_PLAT_LOG Y
                              INNER JOIN SCMDATA.T_PLAT_LOGS X ON X.LOG_ID=Y.LOG_ID AND X.COMPANY_ID=Y.COMPANY_ID
                             WHERE Y.APPLY_PK_ID = Z.RM_ID
                               AND X.OPERATE_FIELD = 'QC_ID'
                               AND Y.ACTION_TYPE = 'UPDATE') AND NOT EXISTS
                           (SELECT MAX(1)
                              FROM TEMP_PTORDER J
                           INNER JOIN SCMDATA.T_ORDERED P
                              ON P.ORDER_ID = J.ORDER_ID
                             AND P.COMPANY_ID = J.COMPANY_ID
                             WHERE J.GOO_ID_PR = Z.GOO_ID
                               AND J.COMPANY_ID = Z.COMPANY_ID AND P.SUPPLIER_CODE = Z.SUPPLIER_CODE AND J.DELIVERY_AMOUNT > 0 AND J.QC2 IS NOT NULL)))
                  CONNECT BY PRIOR Z.RM_ID2 = Z.RM_ID2
                         AND LEVEL <=
                             LENGTH(Z.QC_ID) -
                             LENGTH(REGEXP_REPLACE(Z.QC_ID, ',', '')) + 1
                         AND PRIOR DBMS_RANDOM.VALUE IS NOT NULL
                  UNION ALL
                  SELECT H.COMPANY_ID, H.YEAR, H.MONTH, H.ACCESS_TIME, H.GOO_ID,
                         H.SUP_GROUP_NAME2,
                         (H.EXGAMOUNT2 *((SELECT SUM(J.SUM1)
                               FROM TEMP_PTORDER J INNER JOIN SCMDATA.T_ORDERED P ON P.ORDER_ID = J.ORDER_ID AND P.COMPANY_ID = J.COMPANY_ID
                              WHERE J.GOO_ID_PR = H.GOO_ID
                                AND J.COMPANY_ID = H.COMPANY_ID AND P.SUPPLIER_CODE = H.SUPPLIER_CODE AND J.DELIVERY_AMOUNT > 0
                                AND J.QC2 = H.QC2) /
                          (SELECT SUM(J.ORDER_MONEY)
                               FROM TEMP_PTORDER J INNER JOIN SCMDATA.T_ORDERED P ON P.ORDER_ID = J.ORDER_ID AND P.COMPANY_ID = J.COMPANY_ID
                              WHERE J.GOO_ID_PR = H.GOO_ID
                                AND H.COMPANY_ID = J.COMPANY_ID AND P.SUPPLIER_CODE = H.SUPPLIER_CODE AND J.DELIVERY_AMOUNT > 0
                                AND J.QC2 IS NOT NULL))) EXGAMOUNT3, H.QC2
                    FROM (SELECT Z.*,
                                  REGEXP_SUBSTR(Z.QC_ID, '[^,]+', 1, LEVEL) QC2
                             FROM TEMP_RT Z
                            WHERE NOT EXISTS
                            (SELECT MAX(1)
                                     FROM SCMDATA.T_PLAT_LOG Y
                                     INNER JOIN SCMDATA.T_PLAT_LOGS X ON X.LOG_ID=Y.LOG_ID AND X.COMPANY_ID=Y.COMPANY_ID
                                    WHERE Y.APPLY_PK_ID = Z.RM_ID
                                      AND X.OPERATE_FIELD = 'QC_ID'
                                      AND Y.ACTION_TYPE = 'UPDATE')
                              AND EXISTS
                            (SELECT MAX(1)
                                     FROM TEMP_PTORDER J INNER JOIN SCMDATA.T_ORDERED P ON P.ORDER_ID = J.ORDER_ID AND P.COMPANY_ID = J.COMPANY_ID
                                    WHERE J.GOO_ID_PR = Z.GOO_ID AND P.SUPPLIER_CODE = Z.SUPPLIER_CODE AND J.DELIVERY_AMOUNT > 0 AND J.QC2 IS NOT NULL
                                      AND J.COMPANY_ID = Z.COMPANY_ID)
                           CONNECT BY PRIOR Z.RM_ID2 = Z.RM_ID2
                                  AND LEVEL <=
                                      LENGTH(Z.QC_ID) -
                                      LENGTH(REGEXP_REPLACE(Z.QC_ID, ',', '')) + 1
                                  AND PRIOR DBMS_RANDOM.VALUE IS NOT NULL) H) A
          INNER JOIN SCMDATA.T_COMMODITY_INFO B
             ON A.GOO_ID = B.GOO_ID
            AND A.COMPANY_ID = B.COMPANY_ID
          GROUP BY A.COMPANY_ID, A.YEAR, A.MONTH,
                   TO_CHAR(A.ACCESS_TIME, 'yyyy-mm-dd'), B.CATEGORY,
                   A.SUP_GROUP_NAME2, (CASE WHEN A.QC2 IS NULL THEN '1' ELSE A.QC2 END)) Y

  LEFT JOIN (SELECT A.COMPANY_ID, A.YEAR, A.MONTH,
                    TO_CHAR(A.ACCESS_TIME, 'yyyy-mm-dd') RTKPI_DATE,
                    B.CATEGORY,
                    (CASE  WHEN A.SUP_GROUP_NAME2 IS NULL THEN '1'  ELSE A.SUP_GROUP_NAME2  END) GROUP_NAME,
                    '07' COUNT_DIMENSION,
                    (CASE WHEN A.QC2 IS NULL THEN '1' ELSE A.QC2 END) DIMENSION_SORT,
                    SUM(A.EXGAMOUNT3 * B.PRICE) SHOP_RT_MONEY
               FROM (SELECT Z.COMPANY_ID, Z.YEAR, Z.MONTH, Z.ACCESS_TIME,
                             Z.GOO_ID, Z.SUP_GROUP_NAME2,
                             Z.EXGAMOUNT2 / NVL((REGEXP_COUNT(Z.QC_ID, ',') + 1),1) EXGAMOUNT3,
                             REGEXP_SUBSTR(Z.QC_ID, '[^,]+', 1, LEVEL) QC2
                        FROM TEMP_RT2 Z
                       WHERE (EXISTS
                              (SELECT MAX(1)
                                 FROM SCMDATA.T_PLAT_LOG X
                                 INNER JOIN SCMDATA.T_PLAT_LOGS Y ON X.LOG_ID=Y.LOG_ID AND X.COMPANY_ID=Y.COMPANY_ID
                                WHERE X.APPLY_PK_ID = Z.RM_ID
                                  AND operate_field ='QC_ID'
                                  AND X.ACTION_TYPE = 'UPDATE') OR
                              (NOT EXISTS
                               (SELECT MAX(1)
                                  FROM SCMDATA.T_PLAT_LOG Y
                                  INNER JOIN SCMDATA.T_PLAT_LOGS X ON X.LOG_ID=Y.LOG_ID AND X.COMPANY_ID=Y.COMPANY_ID
                                 WHERE Y.APPLY_PK_ID = Z.RM_ID
                                   AND operate_field ='QC_ID'
                                   AND Y.ACTION_TYPE = 'UPDATE') AND NOT EXISTS
                               (SELECT MAX(1)
                                  FROM TEMP_PTORDER J INNER JOIN SCMDATA.T_ORDERED P ON P.ORDER_ID = J.ORDER_ID AND P.COMPANY_ID = J.COMPANY_ID
                                 WHERE J.GOO_ID_PR = Z.GOO_ID AND P.SUPPLIER_CODE = Z.SUPPLIER_CODE AND J.DELIVERY_AMOUNT > 0 AND J.QC2 IS NOT NULL
                                   AND J.COMPANY_ID = Z.COMPANY_ID)))
                      CONNECT BY PRIOR Z.RM_ID2 = Z.RM_ID2
                             AND LEVEL <=
                                 LENGTH(Z.QC_ID) -
                                 LENGTH(REGEXP_REPLACE(Z.QC_ID, ',', '')) + 1
                             AND PRIOR DBMS_RANDOM.VALUE IS NOT NULL
                      UNION ALL
                      SELECT H.COMPANY_ID, H.YEAR, H.MONTH, H.ACCESS_TIME,
                             H.GOO_ID, H.SUP_GROUP_NAME2,
                             (H.EXGAMOUNT2 * ((SELECT SUM(J.SUM1)
                                   FROM TEMP_PTORDER J INNER JOIN SCMDATA.T_ORDERED P ON P.ORDER_ID = J.ORDER_ID AND P.COMPANY_ID = J.COMPANY_ID
                                  WHERE J.GOO_ID_PR = H.GOO_ID
                                    AND J.COMPANY_ID = H.COMPANY_ID AND P.SUPPLIER_CODE = H.SUPPLIER_CODE AND J.DELIVERY_AMOUNT > 0
                                    AND J.QC2 = H.QC2) /
                              (SELECT SUM(J.ORDER_MONEY)
                                   FROM TEMP_PTORDER J INNER JOIN SCMDATA.T_ORDERED P ON P.ORDER_ID = J.ORDER_ID AND P.COMPANY_ID = J.COMPANY_ID
                                  WHERE j.GOO_ID_PR = H.GOO_ID
                                    AND H.COMPANY_ID = j.COMPANY_ID
                                    AND j.QC2 IS NOT NULL AND P.SUPPLIER_CODE = H.SUPPLIER_CODE AND J.DELIVERY_AMOUNT > 0))) EXGAMOUNT3, H.QC2
                        FROM (SELECT Z.*,
                                      REGEXP_SUBSTR(Z.QC_ID, '[^,]+', 1, LEVEL) QC2
                                 FROM TEMP_RT2 Z
                                WHERE NOT EXISTS
                                (SELECT MAX(1)
                                         FROM SCMDATA.T_PLAT_LOG Y
                                         INNER JOIN SCMDATA.T_PLAT_LOGS X ON X.LOG_ID=Y.LOG_ID AND X.COMPANY_ID=Y.COMPANY_ID
                                        WHERE Y.APPLY_PK_ID = Z.RM_ID
                                          AND operate_field ='QC_ID'
                                          AND Y.ACTION_TYPE = 'UPDATE')
                                  AND EXISTS
                                (SELECT MAX(1)
                                         FROM TEMP_PTORDER J INNER JOIN SCMDATA.T_ORDERED P ON P.ORDER_ID = J.ORDER_ID AND P.COMPANY_ID = J.COMPANY_ID
                                        WHERE J.GOO_ID_PR = Z.GOO_ID AND P.SUPPLIER_CODE = Z.SUPPLIER_CODE AND J.DELIVERY_AMOUNT > 0 AND J.QC2 IS NOT NULL
                                          AND J.COMPANY_ID = Z.COMPANY_ID)
                               CONNECT BY PRIOR Z.RM_ID2 = Z.RM_ID2
                                      AND LEVEL <=
                                          LENGTH(Z.QC_ID) -
                                          LENGTH(REGEXP_REPLACE(Z.QC_ID, ',', '')) + 1
                                      AND PRIOR DBMS_RANDOM.VALUE IS NOT NULL) H) A
              INNER JOIN SCMDATA.T_COMMODITY_INFO B
                 ON A.GOO_ID = B.GOO_ID
                AND A.COMPANY_ID = B.COMPANY_ID
              GROUP BY A.COMPANY_ID, A.YEAR, A.MONTH,
                       TO_CHAR(A.ACCESS_TIME, 'yyyy-mm-dd'), B.CATEGORY,
                       A.SUP_GROUP_NAME2, (CASE WHEN A.QC2 IS NULL THEN '1' ELSE A.QC2 END)) X
    ON X.COMPANY_ID = Y.COMPANY_ID
   AND X.YEAR = Y.YEAR
   AND X.MONTH = Y.MONTH
   AND X.RTKPI_DATE = Y.RTKPI_DATE
   AND X.CATEGORY = Y.CATEGORY
   AND X.GROUP_NAME = Y.GROUP_NAME
   AND X.COUNT_DIMENSION = Y.COUNT_DIMENSION
   AND X.DIMENSION_SORT = Y.DIMENSION_SORT
 /* LEFT JOIN (SELECT A.COMPANY_ID, EXTRACT(YEAR FROM A.CREATE_TIME) YEAR,
                    EXTRACT(MONTH FROM A.CREATE_TIME) MONTH,
                    TO_CHAR(A.CREATE_TIME, 'yyyy-mm-dd') RTKPI_DATE,
                    D.CATEGORY,
                    (CASE  WHEN D.GROUP_NAME IS NULL THEN '1'  ELSE  D.GROUP_NAME  END) GROUP_NAME,
                     '07' COUNT_DIMENSION,
                    (CASE WHEN D.QC2 IS NULL THEN '1' ELSE  D.QC2  END) DIMENSION_SORT,
                    SUM(CASE
                          WHEN REGEXP_COUNT(D.QC, ',') > 0 THEN
                           B.AMOUNT / NVL((REGEXP_COUNT(D.QC, ',') + 1),1) *
                           E.PRICE
                          ELSE
                           B.AMOUNT * E.PRICE
                        END) ORDER_MONEY
               FROM SCMDATA.T_INGOOD A
              INNER JOIN SCMDATA.T_INGOODS B
                 ON A.ING_ID = B.ING_ID
                AND A.COMPANY_ID = B.COMPANY_ID
              INNER JOIN SCMDATA.T_ORDERED C
                 ON C.ORDER_CODE = A.DOCUMENT_NO
                AND A.COMPANY_ID = C.COMPANY_ID
              INNER JOIN (SELECT Z.*,
                                REGEXP_SUBSTR(Z.QC, '[^,]+', 1, LEVEL) QC2
                           FROM SCMDATA.PT_ORDERED Z
                         CONNECT BY PRIOR Z.PT_ORDERED_ID = Z.PT_ORDERED_ID
                                AND LEVEL <=
                                    LENGTH(Z.QC) -
                                    LENGTH(REGEXP_REPLACE(Z.QC, ',', '')) + 1
                                AND PRIOR DBMS_RANDOM.VALUE IS NOT NULL) D
                 ON D.ORDER_ID = C.ORDER_ID
                AND D.COMPANY_ID = C.COMPANY_ID
               INNER JOIN SCMDATA.T_COMMODITY_INFO E ON E.GOO_ID=B.GOO_ID AND E.COMPANY_ID=B.COMPANY_ID
              WHERE B.AMOUNT > 0
              GROUP BY A.COMPANY_ID, EXTRACT(YEAR FROM A.CREATE_TIME),
                       EXTRACT(MONTH FROM A.CREATE_TIME),
                       TO_CHAR(A.CREATE_TIME, 'yyyy-mm-dd'), D.CATEGORY,
                       D.GROUP_NAME, D.QC2) Z
    ON Z.COMPANY_ID = Y.COMPANY_ID
   AND Z.YEAR = Y.YEAR
   AND Z.MONTH = Y.MONTH
   AND Z.RTKPI_DATE = Y.RTKPI_DATE
   AND Z.CATEGORY = Y.CATEGORY
   AND Z.GROUP_NAME = Y.GROUP_NAME
   AND Z.COUNT_DIMENSION = Y.COUNT_DIMENSION
   AND Z.DIMENSION_SORT = Y.DIMENSION_SORT */
 ]';
    IF P_TYPE = 0 THEN
      --进货
      V_EXSQL1 := V_SQL1||V_WH_SQL2||V_U_SQL1||V_I_SQL1;
      --退货
      V_EXSQL2 := V_SQL2 || V_WH_SQL2 || V_U_SQL2 || V_I_SQL2;


    ELSIF P_TYPE = 1 THEN
      --进货
      V_EXSQL1 := V_SQL1||V_WM_SQL1||V_U_SQL1||V_I_SQL1;
      --退货
      V_EXSQL2 := V_SQL2 || V_WM_SQL1 || V_U_SQL2 || V_I_SQL2;
    END IF;
    EXECUTE IMMEDIATE V_EXSQL2;
    EXECUTE IMMEDIATE V_EXSQL1;
    --dbms_output.put_line(V_EXSQL1);
    --dbms_output.put_line(V_EXSQL2);

    --qc主管
    V_SQL1:=q'[MERGE INTO SCMDATA.T_RTKPI_THISMONTH A
USING (
   WITH TEMP_PTORDER AS
 (SELECT T1.PT_ORDERED_ID, T1.GOO_ID_PR,
         T1.PT_ORDERED_ID || ROW_NUMBER() OVER(PARTITION BY T1.PT_ORDERED_ID ORDER BY 1) ID2,
         T1.COMPANY_ID, T1.PRODUCT_GRESS_CODE, T1.ORDER_MONEY,
         (T1.ORDER_MONEY / COUNT(T1.PRODUCT_GRESS_CODE)
           OVER(PARTITION BY T1.PRODUCT_GRESS_CODE)) SUM1,
         REGEXP_SUBSTR(T1.QC_MANAGER, '[^,]+', 1, LEVEL) QCZG2
    FROM SCMDATA.PT_ORDERED T1
   WHERE T1.QC_MANAGER IS NOT NULL
  CONNECT BY PRIOR T1.PT_ORDERED_ID = T1.PT_ORDERED_ID
         AND LEVEL <=
             LENGTH(T1.QC_MANAGER) - LENGTH(REGEXP_REPLACE(T1.QC_MANAGER, ',', '')) + 1
         AND PRIOR DBMS_RANDOM.VALUE IS NOT NULL)

SELECT Y.COMPANY_ID, Y.YEAR, Y.MONTH, to_date(y.RTKPI_DATE,'yyyy-mm-dd') RTKPI_DATE, Y.CATEGORY, Y.GROUP_NAME,
       Y.COUNT_DIMENSION, Y.DIMENSION_SORT DIMENSION_SORT, Y.ORDER_MONEY INGOOD_MONEY
     FROM ( SELECT A.COMPANY_ID,
       EXTRACT(YEAR FROM A.CREATE_TIME) YEAR,
       EXTRACT(MONTH FROM A.CREATE_TIME) MONTH,
       TO_CHAR(A.CREATE_TIME, 'yyyy-mm-dd') RTKPI_DATE,
       E.CATEGORY,
       (CASE WHEN D.GROUP_NAME IS NULL THEN  '1'  ELSE D.GROUP_NAME END) GROUP_NAME,
       '08' COUNT_DIMENSION,
       (case when D.QCZG2 is null then '1' else D.QCZG2 end) DIMENSION_SORT,
       SUM(CASE WHEN REGEXP_COUNT(D.QC_MANAGER, ',') > 0 THEN
       A.AMOUNT/NVL((REGEXP_COUNT(D.QC_MANAGER, ',') + 1),1) * E.PRICE ELSE
           A.AMOUNT * E.PRICE END ) ORDER_MONEY
  FROM (SELECT T.DOCUMENT_NO,
                    T.COMPANY_ID,
                    TRUNC(T.CREATE_TIME) CREATE_TIME,
                    SUM(TL.AMOUNT) AMOUNT,
                    T.SUPPLIER_CODE,
                    TL.GOO_ID
               FROM SCMDATA.T_INGOOD T
              INNER JOIN (SELECT TI.ING_ID,
                                TI.COMPANY_ID,
                                TI.GOO_ID,
                                TI.AMOUNT
                           FROM SCMDATA.T_INGOODS TI
                          WHERE TI.AMOUNT > 0) TL
                 ON TL.ING_ID = T.ING_ID
                AND TL.COMPANY_ID = T.COMPANY_ID
              WHERE TO_CHAR(T.CREATE_TIME, 'yyyy') >= 2022
              GROUP BY T.DOCUMENT_NO,
                       T.COMPANY_ID,
                       TRUNC(T.CREATE_TIME),
                       T.SUPPLIER_CODE,
                       TL.GOO_ID) A
                  /*SCMDATA.T_INGOOD A
                 INNER JOIN SCMDATA.T_INGOODS B
                    ON A.ING_ID = B.ING_ID
                   AND A.COMPANY_ID = B.COMPANY_ID
                 LEFT JOIN SCMDATA.T_ORDERED C
                    ON C.ORDER_CODE = A.DOCUMENT_NO
                   AND A.COMPANY_ID = C.COMPANY_ID*/
 LEFT JOIN (SELECT Z.*, REGEXP_SUBSTR(Z.QC_MANAGER, '[^,]+', 1, LEVEL) QCZG2
  FROM SCMDATA.PT_ORDERED Z
CONNECT BY PRIOR Z.PT_ORDERED_ID = Z.PT_ORDERED_ID
       AND LEVEL <= LENGTH(Z.QC_MANAGER) -
           LENGTH(REGEXP_REPLACE(Z.QC_MANAGER, ',', '')) + 1
       AND PRIOR DBMS_RANDOM.VALUE IS NOT NULL
) D
    ON D.PRODUCT_GRESS_CODE  = A.DOCUMENT_NO
   AND D.COMPANY_ID = A.COMPANY_ID
  INNER JOIN SCMDATA.T_COMMODITY_INFO E ON E.GOO_ID=A.GOO_ID AND E.COMPANY_ID=A.COMPANY_ID
 --WHERE B.AMOUNT > 0
 GROUP BY A.COMPANY_ID,
          EXTRACT(YEAR FROM A.CREATE_TIME),
          EXTRACT(MONTH FROM A.CREATE_TIME),
          TO_CHAR(A.CREATE_TIME, 'yyyy-mm-dd'),
          E.CATEGORY,
          D.GROUP_NAME,
          D.QCZG2) Y  ]';

    V_SQL2 := q'[  MERGE INTO SCMDATA.T_RTKPI_THISMONTH A
USING (
   WITH TEMP_RT AS
 (SELECT Z.RM_ID, Z.COMPANY_ID, Z.YEAR, Z.QUARTER, Z.MONTH, Z.ACCESS_TIME,Z.SUPPLIER_CODE,
         Z.GOO_ID, Z.EXAMOUNT, Z.QC_DIRECTOR_ID,
         Z.RM_ID || ROW_NUMBER() OVER(PARTITION BY Z.RM_ID ORDER BY 1) RM_ID2,
         Z.EXAMOUNT / (COUNT(Z.RM_ID) OVER(PARTITION BY(Z.RM_ID))) EXGAMOUNT2,
         REGEXP_SUBSTR(Z.SUP_GROUP_NAME, '[^,]+', 1, LEVEL) SUP_GROUP_NAME2
    FROM SCMDATA.T_RETURN_MANAGEMENT Z
   WHERE Z.AUDIT_TIME IS NOT NULL
  CONNECT BY PRIOR RM_ID = RM_ID
         AND LEVEL <= LENGTH(Z.SUP_GROUP_NAME) -
             LENGTH(REGEXP_REPLACE(Z.SUP_GROUP_NAME, ',', '')) + 1
         AND PRIOR DBMS_RANDOM.VALUE IS NOT NULL),
 TEMP_RT2 AS
 (SELECT Z.RM_ID, Z.COMPANY_ID, Z.YEAR, Z.QUARTER, Z.MONTH, Z.ACCESS_TIME,Z.SUPPLIER_CODE,
         Z.GOO_ID, Z.EXAMOUNT, Z.QC_DIRECTOR_ID,
         Z.RM_ID || ROW_NUMBER() OVER(PARTITION BY Z.RM_ID ORDER BY 1) RM_ID2,
         Z.EXAMOUNT / (COUNT(Z.RM_ID) OVER(PARTITION BY(Z.RM_ID))) EXGAMOUNT2,
         REGEXP_SUBSTR(Z.SUP_GROUP_NAME, '[^,]+', 1, LEVEL) SUP_GROUP_NAME2
    FROM SCMDATA.T_RETURN_MANAGEMENT Z
    LEFT JOIN SCMDATA.T_ABNORMAL_DTL_CONFIG C
      ON Z.CAUSE_DETAIL_ID = C.ABNORMAL_DTL_CONFIG_ID
     AND Z.COMPANY_ID = C.COMPANY_ID
     AND C.ANOMALY_CLASSIFICATION = 'AC_QUALITY'
   INNER JOIN SCMDATA.SYS_COMPANY_DEPT D
      ON D.COMPANY_DEPT_ID = Z.FIRST_DEPT_ID
   WHERE Z.AUDIT_TIME IS NOT NULL
     AND C.CAUSE_CLASSIFICATION <> '银饰氧化问题'
     AND C.PROBLEM_CLASSIFICATION <> '非质量问题'
     AND D.DEPT_NAME = '供应链管理部'
     AND INSTR(Z.SECOND_DEPT_ID, 'b550778b4f2d36b4e0533c281caca074') > 0
  CONNECT BY PRIOR RM_ID = RM_ID
         AND LEVEL <= LENGTH(Z.SUP_GROUP_NAME) -
             LENGTH(REGEXP_REPLACE(Z.SUP_GROUP_NAME, ',', '')) + 1
         AND PRIOR DBMS_RANDOM.VALUE IS NOT NULL),
TEMP_PTORDER AS
 (SELECT T1.PT_ORDERED_ID, T1.GOO_ID_PR,T1.ORDER_ID, T1.DELIVERY_AMOUNT,
         T1.PT_ORDERED_ID || ROW_NUMBER() OVER(PARTITION BY T1.PT_ORDERED_ID ORDER BY 1) ID2,
         T1.COMPANY_ID, T1.PRODUCT_GRESS_CODE, T1.ORDER_MONEY,
         (T1.ORDER_MONEY / COUNT(T1.PRODUCT_GRESS_CODE)
           OVER(PARTITION BY T1.PRODUCT_GRESS_CODE)) SUM1,
         REGEXP_SUBSTR(T1.QC_MANAGER, '[^,]+', 1, LEVEL) QCZG2
    FROM SCMDATA.PT_ORDERED T1
   WHERE T1.QC_MANAGER IS NOT NULL
  CONNECT BY PRIOR T1.PT_ORDERED_ID = T1.PT_ORDERED_ID
         AND LEVEL <=
             LENGTH(T1.QC_MANAGER) - LENGTH(REGEXP_REPLACE(T1.QC_MANAGER, ',', '')) + 1
         AND PRIOR DBMS_RANDOM.VALUE IS NOT NULL)

SELECT Y.COMPANY_ID, Y.YEAR, Y.MONTH, to_date(y.RTKPI_DATE,'yyyy-mm-dd') RTKPI_DATE, Y.CATEGORY, Y.GROUP_NAME,
       '08' COUNT_DIMENSION, Y.DIMENSION_SORT DIMENSION_SORT, Y.RMMONEY SHOP_RT_ORIGINAL_MONEY,
       X.SHOP_RT_MONEY/*, Z.ORDER_MONEY INGOOD_MONEY*/
  FROM (SELECT A.COMPANY_ID, A.YEAR, A.MONTH,
       TO_CHAR(A.ACCESS_TIME, 'yyyy-mm-dd') RTKPI_DATE, B.CATEGORY,
       (CASE WHEN A.SUP_GROUP_NAME2 IS NULL THEN  '1' ELSE   A.SUP_GROUP_NAME2
       END) GROUP_NAME, '08' COUNT_DIMENSION, (CASE WHEN A.QCZG2 IS NULL THEN '1' ELSE A.QCZG2 END) DIMENSION_SORT,
       SUM(A.EXGAMOUNT3 * B.PRICE) RMMONEY FROM
         (SELECT Z.COMPANY_ID, Z.YEAR, Z.MONTH, Z.ACCESS_TIME, Z.GOO_ID,
                Z.SUP_GROUP_NAME2,
                Z.EXGAMOUNT2 / NVL((REGEXP_COUNT(Z.QC_DIRECTOR_ID, ',') + 1),1) EXGAMOUNT3,
                REGEXP_SUBSTR(Z.QC_DIRECTOR_ID, '[^,]+', 1, LEVEL) QCZG2
           FROM TEMP_RT Z
          WHERE (EXISTS (SELECT MAX(1)
                           FROM SCMDATA.T_PLAT_LOG X
                           INNER JOIN SCMDATA.T_PLAT_LOGS Y ON X.LOG_ID=Y.LOG_ID AND X.COMPANY_ID=Y.COMPANY_ID
                          WHERE X.APPLY_PK_ID = Z.RM_ID
                            AND Y.operate_field ='QC_DIRECTOR_ID'
                            AND X.ACTION_TYPE = 'UPDATE') OR
                 (NOT EXISTS (SELECT MAX(1)
                                       FROM SCMDATA.T_PLAT_LOG Y
                                       INNER JOIN SCMDATA.T_PLAT_LOGS X ON X.LOG_ID=Y.LOG_ID AND X.COMPANY_ID=Y.COMPANY_ID
                                      WHERE Y.APPLY_PK_ID = Z.RM_ID
                                        AND X.operate_field ='QC_DIRECTOR_ID'
                                        AND Y.ACTION_TYPE = 'UPDATE') AND
                  NOT EXISTS
                  (SELECT 1
                            FROM TEMP_PTORDER J
                           INNER JOIN SCMDATA.T_ORDERED P  ON P.ORDER_ID = J.ORDER_ID   AND P.COMPANY_ID = J.COMPANY_ID
                           WHERE J.GOO_ID_PR = Z.GOO_ID AND J.DELIVERY_AMOUNT > 0 AND  P.SUPPLIER_CODE = Z.SUPPLIER_CODE AND J.QCZG2 IS NOT NULL
                             AND J.COMPANY_ID = Z.COMPANY_ID)))
         CONNECT BY PRIOR Z.RM_ID2 = Z.RM_ID2
                AND LEVEL <= LENGTH(Z.QC_DIRECTOR_ID) -
                    LENGTH(REGEXP_REPLACE(Z.QC_DIRECTOR_ID, ',', '')) + 1
                AND PRIOR DBMS_RANDOM.VALUE IS NOT NULL
         UNION ALL
         SELECT H.COMPANY_ID, H.YEAR, H.MONTH, H.ACCESS_TIME, H.GOO_ID,
                H.SUP_GROUP_NAME2,
                (H.EXGAMOUNT2 *
                 ((SELECT SUM(J.SUM1)
                      FROM TEMP_PTORDER J INNER JOIN SCMDATA.T_ORDERED P  ON P.ORDER_ID = J.ORDER_ID   AND P.COMPANY_ID = J.COMPANY_ID
                     WHERE J.GOO_ID_PR = H.GOO_ID AND J.DELIVERY_AMOUNT > 0 AND  P.SUPPLIER_CODE = H.SUPPLIER_CODE
                       AND J.COMPANY_ID = H.COMPANY_ID
                       AND J.QCZG2 = H.QCZG2) /
                 (SELECT SUM(J.ORDER_MONEY)
                      FROM TEMP_PTORDER J INNER JOIN SCMDATA.T_ORDERED P  ON P.ORDER_ID = J.ORDER_ID   AND P.COMPANY_ID = J.COMPANY_ID
                     WHERE J.GOO_ID_PR = H.GOO_ID
                       AND H.COMPANY_ID = J.COMPANY_ID AND J.DELIVERY_AMOUNT > 0 AND  P.SUPPLIER_CODE = H.SUPPLIER_CODE
                       AND J.QCZG2 IS NOT NULL))) EXGAMOUNT3, H.QCZG2
           FROM (SELECT Z.*, REGEXP_SUBSTR(Z.QC_DIRECTOR_ID, '[^,]+', 1, LEVEL) QCZG2
                    FROM TEMP_RT Z
                   WHERE NOT EXISTS (SELECT MAX(1)
                            FROM SCMDATA.T_PLAT_LOG Y
                            INNER JOIN SCMDATA.T_PLAT_LOGS X ON X.LOG_ID=Y.LOG_ID AND X.COMPANY_ID=Y.COMPANY_ID
                           WHERE Y.APPLY_PK_ID = Z.RM_ID
                             AND X.operate_field ='QC_DIRECTOR_ID'
                             AND Y.ACTION_TYPE = 'UPDATE')
                     AND EXISTS
                   (SELECT MAX(1)
                            FROM TEMP_PTORDER J INNER JOIN SCMDATA.T_ORDERED P  ON P.ORDER_ID = J.ORDER_ID   AND P.COMPANY_ID = J.COMPANY_ID
                            WHERE J.GOO_ID_PR = Z.GOO_ID AND J.DELIVERY_AMOUNT > 0 AND  P.SUPPLIER_CODE = Z.SUPPLIER_CODE AND J.QCZG2 IS NOT NULL
                             AND J.COMPANY_ID = Z.COMPANY_ID)
                  CONNECT BY PRIOR Z.RM_ID2 = Z.RM_ID2
                         AND LEVEL <=
                             LENGTH(Z.QC_DIRECTOR_ID) -
                             LENGTH(REGEXP_REPLACE(Z.QC_DIRECTOR_ID, ',', '')) + 1
                         AND PRIOR DBMS_RANDOM.VALUE IS NOT NULL) H) A
 INNER JOIN SCMDATA.T_COMMODITY_INFO B
    ON A.GOO_ID = B.GOO_ID
   AND A.COMPANY_ID = B.COMPANY_ID
 GROUP BY A.COMPANY_ID, A.YEAR, A.MONTH,
          TO_CHAR(A.ACCESS_TIME, 'yyyy-mm-dd'), B.CATEGORY,
          A.SUP_GROUP_NAME2, A.QCZG2) Y

  LEFT JOIN (SELECT A.COMPANY_ID, A.YEAR, A.MONTH,
       TO_CHAR(A.ACCESS_TIME, 'yyyy-mm-dd') RTKPI_DATE, B.CATEGORY,
       (CASE
         WHEN A.SUP_GROUP_NAME2 IS NULL THEN
          '1'
         ELSE
          A.SUP_GROUP_NAME2
       END) GROUP_NAME, '08' COUNT_DIMENSION,( CASE WHEN A.QCZG2 IS NULL THEN '1' ELSE A.QCZG2 END) DIMENSION_SORT,
       SUM(A.EXGAMOUNT3 * B.PRICE) SHOP_RT_MONEY
  FROM (SELECT Z.COMPANY_ID, Z.YEAR, Z.MONTH, Z.ACCESS_TIME, Z.GOO_ID,
                Z.SUP_GROUP_NAME2,
                Z.EXGAMOUNT2 / NVL((REGEXP_COUNT(Z.QC_DIRECTOR_ID, ',') + 1),1) EXGAMOUNT3,
                REGEXP_SUBSTR(Z.QC_DIRECTOR_ID, '[^,]+', 1, LEVEL) QCZG2
           FROM TEMP_RT2 Z
          WHERE (EXISTS (SELECT MAX(1)
                           FROM SCMDATA.T_PLAT_LOG X
                           INNER JOIN SCMDATA.T_PLAT_LOGS Y ON X.LOG_ID=Y.LOG_ID AND X.COMPANY_ID=Y.COMPANY_ID
                          WHERE X.APPLY_PK_ID = Z.RM_ID
                            AND Y.operate_field ='QC_DIRECTOR_ID'
                            AND X.ACTION_TYPE = 'UPDATE') OR
                 (NOT EXISTS (SELECT MAX(1)
                                       FROM SCMDATA.T_PLAT_LOG Y
                                       INNER JOIN SCMDATA.T_PLAT_LOGS X ON X.LOG_ID=Y.LOG_ID AND X.COMPANY_ID=Y.COMPANY_ID
                                      WHERE Y.APPLY_PK_ID = Z.RM_ID
                                        AND X.operate_field ='QC_DIRECTOR_ID'
                                        AND Y.ACTION_TYPE = 'UPDATE') AND
                  NOT EXISTS
                  (SELECT 1
                            FROM TEMP_PTORDER J INNER JOIN SCMDATA.T_ORDERED P  ON P.ORDER_ID = J.ORDER_ID   AND P.COMPANY_ID = J.COMPANY_ID
                            WHERE J.GOO_ID_PR = Z.GOO_ID AND J.DELIVERY_AMOUNT > 0 AND  P.SUPPLIER_CODE = Z.SUPPLIER_CODE AND J.QCZG2 IS NOT NULL
                             AND J.COMPANY_ID = Z.COMPANY_ID)))
         CONNECT BY PRIOR Z.RM_ID2 = Z.RM_ID2
                AND LEVEL <= LENGTH(Z.QC_DIRECTOR_ID) -
                    LENGTH(REGEXP_REPLACE(Z.QC_DIRECTOR_ID, ',', '')) + 1
                AND PRIOR DBMS_RANDOM.VALUE IS NOT NULL
         UNION ALL
         SELECT H.COMPANY_ID, H.YEAR, H.MONTH, H.ACCESS_TIME, H.GOO_ID,
                H.SUP_GROUP_NAME2,
                (H.EXGAMOUNT2 *
                 ((SELECT SUM(J.SUM1)
                      FROM TEMP_PTORDER J INNER JOIN SCMDATA.T_ORDERED P  ON P.ORDER_ID = J.ORDER_ID   AND P.COMPANY_ID = J.COMPANY_ID
                     WHERE J.GOO_ID_PR = H.GOO_ID
                       AND J.COMPANY_ID = H.COMPANY_ID AND P.SUPPLIER_CODE = H.SUPPLIER_CODE AND J.DELIVERY_AMOUNT > 0
                       AND J.QCZG2 = H.QCZG2) /
                 (SELECT SUM(J.ORDER_MONEY)
                      FROM TEMP_PTORDER J INNER JOIN SCMDATA.T_ORDERED P  ON P.ORDER_ID = J.ORDER_ID   AND P.COMPANY_ID = J.COMPANY_ID
                     WHERE J.GOO_ID_PR = H.GOO_ID
                       AND H.COMPANY_ID = J.COMPANY_ID AND J.DELIVERY_AMOUNT > 0 AND  P.SUPPLIER_CODE = H.SUPPLIER_CODE
                       AND J.QCZG2 IS NOT NULL))) EXGAMOUNT3, H.QCZG2
           FROM (SELECT Z.*, REGEXP_SUBSTR(Z.QC_DIRECTOR_ID, '[^,]+', 1, LEVEL) QCZG2
                    FROM TEMP_RT2 Z
                   WHERE NOT EXISTS (SELECT MAX(1)
                            FROM SCMDATA.T_PLAT_LOG Y
                            INNER JOIN SCMDATA.T_PLAT_LOGS X ON X.LOG_ID=Y.LOG_ID AND X.COMPANY_ID=Y.COMPANY_ID
                           WHERE Y.APPLY_PK_ID = Z.RM_ID
                             AND X.operate_field ='QC_DIRECTOR_ID'
                             AND Y.ACTION_TYPE = 'UPDATE')
                     AND EXISTS
                   (SELECT MAX(1)
                            FROM TEMP_PTORDER J INNER JOIN SCMDATA.T_ORDERED P  ON P.ORDER_ID = J.ORDER_ID   AND P.COMPANY_ID = J.COMPANY_ID
                     WHERE J.GOO_ID_PR= Z.GOO_ID AND J.DELIVERY_AMOUNT > 0 AND  P.SUPPLIER_CODE = Z.SUPPLIER_CODE AND J.QCZG2 IS NOT NULL
                             AND J.COMPANY_ID = Z.COMPANY_ID)
                  CONNECT BY PRIOR Z.RM_ID2 = Z.RM_ID2
                         AND LEVEL <=
                             LENGTH(Z.QC_DIRECTOR_ID) -
                             LENGTH(REGEXP_REPLACE(Z.QC_DIRECTOR_ID, ',', '')) + 1
                         AND PRIOR DBMS_RANDOM.VALUE IS NOT NULL) H) A
 INNER JOIN SCMDATA.T_COMMODITY_INFO B
    ON A.GOO_ID = B.GOO_ID
   AND A.COMPANY_ID = B.COMPANY_ID
 GROUP BY A.COMPANY_ID, A.YEAR, A.MONTH,
          TO_CHAR(A.ACCESS_TIME, 'yyyy-mm-dd'), B.CATEGORY,
          A.SUP_GROUP_NAME2, A.QCZG2) X
    ON X.COMPANY_ID = Y.COMPANY_ID
   AND X.YEAR = Y.YEAR
   AND X.MONTH = Y.MONTH
   AND X.RTKPI_DATE = Y.RTKPI_DATE
   AND X.CATEGORY = Y.CATEGORY
   AND X.GROUP_NAME = Y.GROUP_NAME
   AND X.COUNT_DIMENSION = Y.COUNT_DIMENSION
   AND X.DIMENSION_SORT = Y.DIMENSION_SORT
  /*LEFT JOIN ( SELECT A.COMPANY_ID,
       EXTRACT(YEAR FROM A.CREATE_TIME) YEAR,
       EXTRACT(MONTH FROM A.CREATE_TIME) MONTH,
       TO_CHAR(A.CREATE_TIME, 'yyyy-mm-dd') RTKPI_DATE,
       D.CATEGORY,
       (CASE WHEN D.GROUP_NAME IS NULL THEN  '1'  ELSE D.GROUP_NAME END) GROUP_NAME,
       '08' COUNT_DIMENSION,
       (case when D.QCZG2 is null then '1' else D.QCZG2 end) DIMENSION_SORT,
       SUM(CASE WHEN REGEXP_COUNT(D.QC_MANAGER, ',') > 0 THEN
       B.AMOUNT/NVL((REGEXP_COUNT(D.QC_MANAGER, ',') + 1),1) * E.PRICE ELSE
           B.AMOUNT * E.PRICE END ) ORDER_MONEY
  FROM SCMDATA.T_INGOOD A
 INNER JOIN SCMDATA.T_INGOODS B
    ON A.ING_ID = B.ING_ID
   AND A.COMPANY_ID = B.COMPANY_ID
 INNER JOIN SCMDATA.T_ORDERED C
    ON C.ORDER_CODE = A.DOCUMENT_NO
   AND A.COMPANY_ID = C.COMPANY_ID
 INNER JOIN (SELECT Z.*, REGEXP_SUBSTR(Z.QC_MANAGER, '[^,]+', 1, LEVEL) QCZG2
  FROM SCMDATA.PT_ORDERED Z
CONNECT BY PRIOR Z.PT_ORDERED_ID = Z.PT_ORDERED_ID
       AND LEVEL <= LENGTH(Z.QC_MANAGER) -
           LENGTH(REGEXP_REPLACE(Z.QC_MANAGER, ',', '')) + 1
       AND PRIOR DBMS_RANDOM.VALUE IS NOT NULL
) D
    ON D.ORDER_ID = C.ORDER_ID
   AND D.COMPANY_ID = C.COMPANY_ID
  INNER JOIN SCMDATA.T_COMMODITY_INFO E ON E.GOO_ID=B.GOO_ID AND E.COMPANY_ID=B.COMPANY_ID
 WHERE B.AMOUNT > 0
 GROUP BY A.COMPANY_ID,
          EXTRACT(YEAR FROM A.CREATE_TIME),
          EXTRACT(MONTH FROM A.CREATE_TIME),
          TO_CHAR(A.CREATE_TIME, 'yyyy-mm-dd'),
          D.CATEGORY,
          D.GROUP_NAME,
          D.QCZG2) Z
    ON Z.COMPANY_ID = Y.COMPANY_ID
   AND Z.YEAR = Y.YEAR
   AND Z.MONTH = Y.MONTH
   AND Z.RTKPI_DATE = Y.RTKPI_DATE
   AND Z.CATEGORY = Y.CATEGORY
   AND Z.GROUP_NAME = Y.GROUP_NAME
   AND Z.COUNT_DIMENSION = Y.COUNT_DIMENSION
   AND Z.DIMENSION_SORT = Y.DIMENSION_SORT */ ]';

   IF P_TYPE = 0 THEN
      --进货
      V_EXSQL1 := V_SQL1||V_WH_SQL2||V_U_SQL1||V_I_SQL1;
      --退货
      V_EXSQL2 := V_SQL2 || V_WH_SQL2 || V_U_SQL2 || V_I_SQL2;


    ELSIF P_TYPE = 1 THEN
      --进货
      V_EXSQL1 := V_SQL1||V_WM_SQL1||V_U_SQL1||V_I_SQL1;
      --退货
      V_EXSQL2 := V_SQL2 || V_WM_SQL1 || V_U_SQL2 || V_I_SQL2;
    END IF;
    EXECUTE IMMEDIATE V_EXSQL2;
    EXECUTE IMMEDIATE V_EXSQL1;
    --dbms_output.put_line(V_EXSQL1);
    --dbms_output.put_line(V_EXSQL2);
  END P_RTKPI_THISMONTH;

  PROCEDURE P_RTKPI_MONTH(P_TYPE NUMBER) IS
    --V_SQL     CLOB;
    V_WH_SQL2 CLOB; --全部历史数据
    V_EXSQL1   CLOB;
    V_EXSQL2   CLOB;
    V_WM_SQL1 CLOB; --上一时间维度
    V_SQL1     CLOB;
    V_SQL2     CLOB;
    --进货数据
    V_U_SQL1  CLOB := q'[ update
                           set a.INGOOD_MONEY           =tkb.INGOOD_MONEY,
                               a.update_id              = 'ADMIN',
                               a.update_time            = sysdate
                 ]';
    --退货数据
    V_U_SQL2  CLOB := q'[ update
                           set a.SHOP_RT_MONEY          = tkb.SHOP_RT_MONEY,
                               a.SHOP_RT_ORIGINAL_MONEY = tkb.SHOP_RT_ORIGINAL_MONEY,
                               a.update_id              = 'ADMIN',
                               a.update_time            = sysdate
                 ]';

    --新增进货数据
    V_I_SQL1  CLOB := q'[
    WHEN NOT MATCHED THEN
      INSERT
        (A.T_RTKPI_M_ID, A.COMPANY_ID, A.YEAR, A.MONTH, A.CATEGORY, A.GROUPNAME, A.COUNT_DIMENSION, A.DIMENSION_SORT, A.INGOOD_MONEY, A.CREATE_ID, A.CREATE_TIME, A.UPDATE_ID, A.UPDATE_TIME)
      VALUES
        (SCMDATA.F_GET_UUID(), TKB.COMPANY_ID, TKB.YEAR, TKB.MONTH, TKB.CATEGORY, TKB.GROUP_NAME,  TKB.COUNT_DIMENSION, TKB.DIMENSION_SORT,TKB.INGOOD_MONEY, 'ADMIN', SYSDATE, 'ADMIN', SYSDATE)
 ]';

    --新增退货数据
    V_I_SQL2  CLOB := q'[
    WHEN NOT MATCHED THEN
      INSERT (a.T_RTKPI_M_ID,a.company_id,a.year,a.month,a.category,a.groupname,a.count_dimension,a.dimension_sort,a.shop_rt_money,a.shop_rt_original_money,a.create_id,a.create_time,a.update_id,a.update_time)
      values (scmdata.f_get_uuid(),
         tkb.company_id,
         tkb.year,
         tkb.month,
         tkb.category,
         tkb.group_name,
         tkb.count_dimension,
         tkb.dimension_sort,
         tkb.SHOP_RT_MONEY,
         tkb.SHOP_RT_ORIGINAL_MONEY,
         'ADMIN',sysdate,'ADMIN',sysdate) ]';

  BEGIN

    --全部历史数据
    V_WH_SQL2 := q'[
       WHERE (y.year||lpad(y.month,2,0)) < to_char(sysdate,'yyyymm') and y.year>=2023
          ) tkb
          ON (tkb.company_id = a.company_id AND tkb.year = a.year AND tkb.month=a.month  AND tkb.category=a.category
           AND tkb.group_name = a.groupname AND tkb.count_dimension =a.count_dimension AND tkb.dimension_sort =a.dimension_sort  )
           when matched then ]';

    --上一时间维度
    V_WM_SQL1 := q'[
      where (y.year||lpad(y.month,2,0)) = to_char(add_months(sysdate,-1),'yyyymm')
        ) tkb
      ON (tkb.company_id = a.company_id AND tkb.year = a.year AND tkb.month=a.month  AND tkb.category=a.category
           AND tkb.group_name = a.groupname AND tkb.count_dimension =a.count_dimension AND tkb.dimension_sort =a.dimension_sort  )
           when matched then ]';
    --分类维度
      --进货数据
       V_SQL1:= q'[MERGE INTO SCMDATA.T_RTKPI_MONTH A
             USING ( SELECT  Y.COMPANY_ID,Y.YEAR,Y.MONTH,Y.CATEGORY,Y.GROUP_NAME,Y.COUNT_DIMENSION,Y.DIMENSION_SORT,Y.ORDER_MONEY INGOOD_MONEY
                 FROM (
             SELECT A.COMPANY_ID, EXTRACT(YEAR FROM A.CREATE_TIME) YEAR,
                       EXTRACT(MONTH FROM A.CREATE_TIME) MONTH,
                       E.CATEGORY,
                       (CASE
                         WHEN D.GROUP_NAME IS NULL THEN
                          '1'
                         ELSE
                          D.GROUP_NAME
                       END) GROUP_NAME, '00' COUNT_DIMENSION,
                       E.CATEGORY DIMENSION_SORT,
                       SUM(A.AMOUNT * E.PRICE) ORDER_MONEY
                  FROM /*SCMDATA.T_INGOOD A
                 INNER JOIN SCMDATA.T_INGOODS B
                    ON A.ING_ID = B.ING_ID
                   AND A.COMPANY_ID = B.COMPANY_ID*/
                   (SELECT T.DOCUMENT_NO,
                    T.COMPANY_ID,
                    TRUNC(T.CREATE_TIME) CREATE_TIME,
                    SUM(TL.AMOUNT) AMOUNT,
                    TL.GOO_ID
               FROM SCMDATA.T_INGOOD T
              INNER JOIN (SELECT TI.ING_ID,
                                TI.COMPANY_ID,
                                TI.GOO_ID,
                                TI.AMOUNT
                           FROM SCMDATA.T_INGOODS TI
                          WHERE TI.AMOUNT > 0) TL
                 ON TL.ING_ID = T.ING_ID
                AND TL.COMPANY_ID = T.COMPANY_ID
              WHERE TO_CHAR(T.CREATE_TIME, 'yyyy') >= 2022
              GROUP BY T.DOCUMENT_NO,
                       T.COMPANY_ID,
                       TRUNC(T.CREATE_TIME),
                       TL.GOO_ID) A
                 /*LEFT JOIN SCMDATA.T_ORDERED C
                    ON C.ORDER_CODE = A.DOCUMENT_NO
                   AND A.COMPANY_ID = C.COMPANY_ID*/
                 LEFT JOIN SCMDATA.PT_ORDERED D
                    ON D.PRODUCT_GRESS_CODE = A.DOCUMENT_NO
                   AND D.COMPANY_ID = A.COMPANY_ID
                   INNER JOIN SCMDATA.T_COMMODITY_INFO E ON E.GOO_ID=A.GOO_ID AND E.COMPANY_ID=A.COMPANY_ID
                -- WHERE B.AMOUNT > 0
                 GROUP BY A.COMPANY_ID, EXTRACT(YEAR FROM A.CREATE_TIME),
                          EXTRACT(MONTH FROM A.CREATE_TIME), E.CATEGORY,
                          D.GROUP_NAME ) Y ]';


    --退货数据
    V_SQL2 := q'[MERGE INTO SCMDATA.T_RTKPI_MONTH A
             USING (SELECT y.COMPANY_ID, y.YEAR, y.MONTH,  y.CATEGORY,
              y.GROUP_NAME, y.COUNT_DIMENSION, y.DIMENSION_SORT,
              /*Z.ORDER_MONEY INGOOD_MONEY, */Y.RMMONEY SHOP_RT_ORIGINAL_MONEY, X.RMMONEY2 SHOP_RT_MONEY
          FROM
         (SELECT A.COMPANY_ID, A.YEAR, A.MONTH,
                          B.CATEGORY,
                          (CASE
                            WHEN A.SUP_GROUP_NAME2 IS NULL THEN
                             '1'
                            ELSE
                             A.SUP_GROUP_NAME2
                          END) GROUP_NAME, '00' COUNT_DIMENSION,
                          B.CATEGORY DIMENSION_SORT,
                          SUM(CASE
                                WHEN REGEXP_COUNT(A.SUP_GROUP_NAME, ',') > 0 THEN
                                 A.EXAMOUNT /
                                 (REGEXP_COUNT(A.SUP_GROUP_NAME, ',') + 1) *
                                 B.PRICE
                                ELSE
                                 A.EXAMOUNT * B.PRICE
                              END) RMMONEY
                     FROM (SELECT Z.RM_ID, Z.COMPANY_ID, Z.YEAR, Z.MONTH,
                                   Z.ACCESS_TIME, Z.GOO_ID, Z.EXAMOUNT,
                                   Z.SUP_GROUP_NAME, Z.AUDIT_TIME,
                                   REGEXP_SUBSTR(Z.SUP_GROUP_NAME,
                                                  '[^,]+',
                                                  1,
                                                  LEVEL) SUP_GROUP_NAME2
                              FROM SCMDATA.T_RETURN_MANAGEMENT Z
                            CONNECT BY PRIOR RM_ID = RM_ID
                                   AND LEVEL <=
                                       LENGTH(Z.SUP_GROUP_NAME) -
                                       LENGTH(REGEXP_REPLACE(Z.SUP_GROUP_NAME,
                                                             ',',
                                                             '')) + 1
                                   AND PRIOR DBMS_RANDOM.VALUE IS NOT NULL) A
                    INNER JOIN SCMDATA.T_COMMODITY_INFO B
                       ON A.GOO_ID = B.GOO_ID
                      AND A.COMPANY_ID = B.COMPANY_ID
                    WHERE A.AUDIT_TIME IS NOT NULL
                    GROUP BY A.COMPANY_ID, A.YEAR, A.MONTH,
                             B.CATEGORY,
                             A.SUP_GROUP_NAME2) Y

         LEFT JOIN (SELECT A.COMPANY_ID, A.YEAR, A.MONTH,
                          B.CATEGORY,
                          (CASE
                            WHEN A.SUP_GROUP_NAME2 IS NULL THEN
                             '1'
                            ELSE
                             A.SUP_GROUP_NAME2
                          END) GROUP_NAME, '00' COUNT_DIMENSION,
                          B.CATEGORY DIMENSION_SORT,
                          SUM(CASE
                                WHEN REGEXP_COUNT(A.SUP_GROUP_NAME, ',') > 0 THEN
                                 A.EXAMOUNT /
                                 (REGEXP_COUNT(A.SUP_GROUP_NAME, ',') + 1) *
                                 B.PRICE
                                ELSE
                                 A.EXAMOUNT * B.PRICE
                              END) RMMONEY2
                     FROM (SELECT Z.RM_ID, Z.COMPANY_ID, Z.YEAR, Z.MONTH,
                                   Z.ACCESS_TIME, Z.GOO_ID, Z.EXAMOUNT,
                                   Z.SUP_GROUP_NAME, Z.AUDIT_TIME,
                                   Z.CAUSE_DETAIL_ID, Z.FIRST_DEPT_ID,
                                   Z.SECOND_DEPT_ID,
                                   REGEXP_SUBSTR(Z.SUP_GROUP_NAME,
                                                  '[^,]+',
                                                  1,
                                                  LEVEL) SUP_GROUP_NAME2
                              FROM SCMDATA.T_RETURN_MANAGEMENT Z
                            CONNECT BY PRIOR RM_ID = RM_ID
                                   AND LEVEL <=
                                       LENGTH(Z.SUP_GROUP_NAME) -
                                       LENGTH(REGEXP_REPLACE(Z.SUP_GROUP_NAME,
                                                             ',',
                                                             '')) + 1
                                   AND PRIOR DBMS_RANDOM.VALUE IS NOT NULL) A
                    INNER JOIN SCMDATA.T_COMMODITY_INFO B
                       ON A.GOO_ID = B.GOO_ID
                      AND A.COMPANY_ID = B.COMPANY_ID
                     LEFT JOIN SCMDATA.T_ABNORMAL_DTL_CONFIG C
                       ON A.CAUSE_DETAIL_ID = C.ABNORMAL_DTL_CONFIG_ID
                      AND A.COMPANY_ID = C.COMPANY_ID
                      AND C.ANOMALY_CLASSIFICATION = 'AC_QUALITY'
                    INNER JOIN SCMDATA.SYS_COMPANY_DEPT D
                       ON D.COMPANY_DEPT_ID = A.FIRST_DEPT_ID
                    WHERE A.AUDIT_TIME IS NOT NULL
                      AND C.CAUSE_CLASSIFICATION <> '银饰氧化问题'
                      AND C.PROBLEM_CLASSIFICATION <> '非质量问题'
                      AND D.DEPT_NAME = '供应链管理部'
                    GROUP BY A.COMPANY_ID, A.YEAR, A.MONTH, B.CATEGORY,
                             A.SUP_GROUP_NAME2) X
           ON X.COMPANY_ID = Y.COMPANY_ID
          AND X.YEAR = Y.YEAR
          AND X.MONTH = Y.MONTH
          AND X.CATEGORY = Y.CATEGORY
          AND X.GROUP_NAME = Y.GROUP_NAME
          AND X.COUNT_DIMENSION = Y.COUNT_DIMENSION
          AND X.DIMENSION_SORT = Y.DIMENSION_SORT
          /*LEFT JOIN (SELECT A.COMPANY_ID, EXTRACT(YEAR FROM A.CREATE_TIME) YEAR,
                       EXTRACT(MONTH FROM A.CREATE_TIME) MONTH,
                       D.CATEGORY,
                       (CASE
                         WHEN D.GROUP_NAME IS NULL THEN
                          '1'
                         ELSE
                          D.GROUP_NAME
                       END) GROUP_NAME, '00' COUNT_DIMENSION,
                       D.CATEGORY DIMENSION_SORT,
                       SUM(B.AMOUNT * E.PRICE) ORDER_MONEY
                  FROM SCMDATA.T_INGOOD A
                 INNER JOIN SCMDATA.T_INGOODS B
                    ON A.ING_ID = B.ING_ID
                   AND A.COMPANY_ID = B.COMPANY_ID
                 INNER JOIN SCMDATA.T_ORDERED C
                    ON C.ORDER_CODE = A.DOCUMENT_NO
                   AND A.COMPANY_ID = C.COMPANY_ID
                 LEFT JOIN SCMDATA.PT_ORDERED D
                    ON D.ORDER_ID = C.ORDER_ID
                   AND D.COMPANY_ID = C.COMPANY_ID
                   INNER JOIN SCMDATA.T_COMMODITY_INFO E ON E.GOO_ID=B.GOO_ID AND E.COMPANY_ID=B.COMPANY_ID
                 WHERE B.AMOUNT > 0
                 GROUP BY A.COMPANY_ID, EXTRACT(YEAR FROM A.CREATE_TIME),
                          EXTRACT(MONTH FROM A.CREATE_TIME), D.CATEGORY,
                          D.GROUP_NAME) z ON Z.COMPANY_ID = Y.COMPANY_ID
          AND Z.YEAR = Y.YEAR
          AND Z.MONTH = Y.MONTH
          AND Z.CATEGORY = Y.CATEGORY
          AND Z.GROUP_NAME = Y.GROUP_NAME
          AND Z.COUNT_DIMENSION = Y.COUNT_DIMENSION
          AND Z.DIMENSION_SORT = Y.DIMENSION_SORT*/ ]';
    /*p_type = 0 更新全部历史数据
    p_type = 1  只更新上一个月的数据 */
    IF P_TYPE = 0 THEN
      --进货
      V_EXSQL1 := V_SQL1||V_WH_SQL2||V_U_SQL1||V_I_SQL1;
      --退货
      V_EXSQL2 := V_SQL2 || V_WH_SQL2 || V_U_SQL2 || V_I_SQL2;


    ELSIF P_TYPE = 1 THEN
      --进货
      V_EXSQL1 := V_SQL1||V_WM_SQL1||V_U_SQL1||V_I_SQL1;
      --退货
      V_EXSQL2 := V_SQL2 || V_WM_SQL1 || V_U_SQL2 || V_I_SQL2;
    END IF;
    
    --dbms_output.put_line(V_EXSQL1);
    --dbms_output.put_line(V_EXSQL2);
    EXECUTE IMMEDIATE V_EXSQL2;
    EXECUTE IMMEDIATE V_EXSQL1;

    --区域组
    --进货数据
    V_SQL1:=q'[MERGE INTO SCMDATA.T_RTKPI_MONTH A
             USING ( SELECT  Y.COMPANY_ID,Y.YEAR,Y.MONTH,Y.CATEGORY,Y.GROUP_NAME,Y.COUNT_DIMENSION,Y.DIMENSION_SORT,Y.ORDER_MONEY INGOOD_MONEY
                 FROM (SELECT A.COMPANY_ID,
       EXTRACT(YEAR FROM A.CREATE_TIME) YEAR,
       EXTRACT(MONTH FROM A.CREATE_TIME) MONTH,
       E.CATEGORY,
       (CASE WHEN D.GROUP_NAME IS NULL THEN  '1'  ELSE D.GROUP_NAME END) GROUP_NAME,
       '01' COUNT_DIMENSION,
       (CASE WHEN D.GROUP_NAME IS NULL THEN  '1'  ELSE D.GROUP_NAME END) DIMENSION_SORT,
       SUM(A.AMOUNT * E.PRICE) ORDER_MONEY
  FROM  /*SCMDATA.T_INGOOD A
                 INNER JOIN SCMDATA.T_INGOODS B
                    ON A.ING_ID = B.ING_ID
                   AND A.COMPANY_ID = B.COMPANY_ID*/
                   (SELECT T.DOCUMENT_NO,
                    T.COMPANY_ID,
                    TRUNC(T.CREATE_TIME) CREATE_TIME,
                    SUM(TL.AMOUNT) AMOUNT,
                    TL.GOO_ID
               FROM SCMDATA.T_INGOOD T
              INNER JOIN (SELECT TI.ING_ID,
                                TI.COMPANY_ID,
                                TI.GOO_ID,
                                TI.AMOUNT
                           FROM SCMDATA.T_INGOODS TI
                          WHERE TI.AMOUNT > 0) TL
                 ON TL.ING_ID = T.ING_ID
                AND TL.COMPANY_ID = T.COMPANY_ID
              WHERE TO_CHAR(T.CREATE_TIME, 'yyyy') >= 2022
              GROUP BY T.DOCUMENT_NO,
                       T.COMPANY_ID,
                       TRUNC(T.CREATE_TIME),
                       TL.GOO_ID) A
                 /*LEFT JOIN SCMDATA.T_ORDERED C
                    ON C.ORDER_CODE = A.DOCUMENT_NO
                   AND A.COMPANY_ID = C.COMPANY_ID*/
 LEFT JOIN SCMDATA.PT_ORDERED D
   ON D.PRODUCT_GRESS_CODE = A.DOCUMENT_NO
  AND D.COMPANY_ID = A.COMPANY_ID
     INNER JOIN SCMDATA.T_COMMODITY_INFO E ON E.GOO_ID=A.GOO_ID AND E.COMPANY_ID=A.COMPANY_ID
                -- WHERE B.AMOUNT > 0
 GROUP BY A.COMPANY_ID,
          EXTRACT(YEAR FROM A.CREATE_TIME),
          EXTRACT(MONTH FROM A.CREATE_TIME),
          E.CATEGORY,
          D.GROUP_NAME) Y
    ]';

    --退货数据
    V_SQL2 := q'[MERGE INTO SCMDATA.T_RTKPI_MONTH A
USING (SELECT Y.COMPANY_ID, Y.YEAR, Y.MONTH,  Y.CATEGORY,
              Y.GROUP_NAME, Y.COUNT_DIMENSION, Y.DIMENSION_SORT,
              /*Z.ORDER_MONEY INGOOD_MONEY,*/ Y.RMMONEY SHOP_RT_ORIGINAL_MONEY, X.RMMONEY2 SHOP_RT_MONEY

         FROM
         (SELECT A.COMPANY_ID, A.YEAR, A.MONTH,
                          B.CATEGORY,
                          (CASE
                            WHEN A.SUP_GROUP_NAME2 IS NULL THEN
                             '1'
                            ELSE
                             A.SUP_GROUP_NAME2
                          END) GROUP_NAME, '01' COUNT_DIMENSION,
                         (CASE
                            WHEN A.SUP_GROUP_NAME2 IS NULL THEN
                             '1'
                            ELSE
                             A.SUP_GROUP_NAME2
                          END) DIMENSION_SORT,
                          SUM(CASE
                                WHEN REGEXP_COUNT(A.SUP_GROUP_NAME, ',') > 0 THEN
                                 A.EXAMOUNT /
                                 (REGEXP_COUNT(A.SUP_GROUP_NAME, ',') + 1) *
                                 B.PRICE
                                ELSE
                                 A.EXAMOUNT * B.PRICE
                              END) RMMONEY
                     FROM (SELECT Z.RM_ID, Z.COMPANY_ID, Z.YEAR, Z.MONTH,
                                   Z.ACCESS_TIME, Z.GOO_ID, Z.EXAMOUNT,
                                   Z.SUP_GROUP_NAME, Z.AUDIT_TIME,
                                   REGEXP_SUBSTR(Z.SUP_GROUP_NAME,
                                                  '[^,]+',
                                                  1,
                                                  LEVEL) SUP_GROUP_NAME2
                              FROM   SCMDATA.T_RETURN_MANAGEMENT z
   CONNECT BY PRIOR RM_ID = RM_ID
          AND LEVEL <= LENGTH(z.SUP_GROUP_NAME) -
              LENGTH(REGEXP_REPLACE(z.SUP_GROUP_NAME, ',', '')) + 1
          AND PRIOR DBMS_RANDOM.VALUE IS NOT NULL) A
        INNER JOIN scmdata.T_COMMODITY_INFO B
             ON A.GOO_ID = B.GOO_ID
            AND A.COMPANY_ID = B.COMPANY_ID
       WHERE A.AUDIT_TIME IS NOT NULL
       GROUP BY A.COMPANY_ID,
                A.YEAR,
                A.MONTH,
                B.CATEGORY,
                 A.SUP_GROUP_NAME2) Y

         LEFT JOIN (SELECT A.COMPANY_ID, A.YEAR, A.MONTH,
                          B.CATEGORY,
                          (CASE  WHEN A.SUP_GROUP_NAME2 IS NULL THEN '1'    ELSE   A.SUP_GROUP_NAME2 END) GROUP_NAME,
                           '01' COUNT_DIMENSION,
                         (CASE  WHEN A.SUP_GROUP_NAME2 IS NULL THEN '1'    ELSE   A.SUP_GROUP_NAME2 END) DIMENSION_SORT,
                          SUM(CASE
                                WHEN REGEXP_COUNT(A.SUP_GROUP_NAME, ',') > 0 THEN
                                 A.EXAMOUNT /
                                 (REGEXP_COUNT(A.SUP_GROUP_NAME, ',') + 1) *
                                 B.PRICE
                                ELSE
                                 A.EXAMOUNT * B.PRICE
                              END) RMMONEY2
                     FROM (SELECT Z.RM_ID, Z.COMPANY_ID, Z.YEAR, Z.MONTH,
                                   Z.ACCESS_TIME, Z.GOO_ID, Z.EXAMOUNT,
                                   Z.SUP_GROUP_NAME, Z.AUDIT_TIME,
                                   Z.CAUSE_DETAIL_ID, Z.FIRST_DEPT_ID,
                                   Z.SECOND_DEPT_ID,
                                   REGEXP_SUBSTR(Z.SUP_GROUP_NAME,
                                                  '[^,]+',
                                                  1,
                                                  LEVEL) SUP_GROUP_NAME2
                              FROM SCMDATA.T_RETURN_MANAGEMENT z
   CONNECT BY PRIOR RM_ID = RM_ID
          AND LEVEL <= LENGTH(z.SUP_GROUP_NAME) -
              LENGTH(REGEXP_REPLACE(z.SUP_GROUP_NAME, ',', '')) + 1
          AND PRIOR DBMS_RANDOM.VALUE IS NOT NULL) A
        INNER JOIN scmdata.T_COMMODITY_INFO B
             ON A.GOO_ID = B.GOO_ID
            AND A.COMPANY_ID = B.COMPANY_ID
          LEFT JOIN SCMDATA.T_abnormal_dtl_config C ON A.CAUSE_DETAIL_ID = C.ABNORMAL_DTL_CONFIG_ID AND A.COMPANY_ID = C.COMPANY_ID AND C.ANOMALY_CLASSIFICATION='AC_QUALITY'
         INNER JOIN SCMDATA.SYS_COMPANY_DEPT D ON D.COMPANY_DEPT_ID=A.FIRST_DEPT_ID
       WHERE A.AUDIT_TIME IS NOT NULL
       AND C.CAUSE_CLASSIFICATION <> '银饰氧化问题'
       AND C.PROBLEM_CLASSIFICATION <> '非质量问题'
        AND D.DEPT_NAME = '供应链管理部'
       GROUP BY A.COMPANY_ID,
                A.YEAR,
                A.MONTH,
                B.CATEGORY,
                 A.SUP_GROUP_NAME2) X
           ON X.COMPANY_ID = Y.COMPANY_ID
          AND X.YEAR = Y.YEAR
          AND X.MONTH = Y.MONTH
          AND X.CATEGORY = Y.CATEGORY
          AND X.GROUP_NAME = Y.GROUP_NAME
          AND X.COUNT_DIMENSION = Y.COUNT_DIMENSION
          AND X.DIMENSION_SORT = Y.DIMENSION_SORT
          /*LEFT JOIN
          (SELECT A.COMPANY_ID,
       EXTRACT(YEAR FROM A.CREATE_TIME) YEAR,
       EXTRACT(MONTH FROM A.CREATE_TIME) MONTH,
       D.CATEGORY,
       (CASE WHEN D.GROUP_NAME IS NULL THEN  '1'  ELSE D.GROUP_NAME END) GROUP_NAME,
       '01' COUNT_DIMENSION,
       (CASE WHEN D.GROUP_NAME IS NULL THEN  '1'  ELSE D.GROUP_NAME END) DIMENSION_SORT,
       SUM(B.AMOUNT * E.PRICE) ORDER_MONEY
  FROM SCMDATA.T_INGOOD A
 INNER JOIN SCMDATA.T_INGOODS B
    ON A.ING_ID = B.ING_ID
   AND A.COMPANY_ID = B.COMPANY_ID
 INNER JOIN SCMDATA.T_ORDERED C
    ON C.ORDER_CODE = A.DOCUMENT_NO
   AND A.COMPANY_ID = C.COMPANY_ID
 INNER JOIN SCMDATA.PT_ORDERED D
    ON D.ORDER_ID = C.ORDER_ID
   AND D.COMPANY_ID = C.COMPANY_ID
   INNER JOIN SCMDATA.T_COMMODITY_INFO E ON E.GOO_ID=B.GOO_ID AND E.COMPANY_ID=B.COMPANY_ID
 WHERE B.AMOUNT > 0
 GROUP BY A.COMPANY_ID,
          EXTRACT(YEAR FROM A.CREATE_TIME),
          EXTRACT(MONTH FROM A.CREATE_TIME),
          D.CATEGORY,
          D.GROUP_NAME) z ON Z.COMPANY_ID = Y.COMPANY_ID
          AND Z.YEAR = Y.YEAR
          AND Z.MONTH = Y.MONTH
          AND Z.CATEGORY = Y.CATEGORY
          AND Z.GROUP_NAME = Y.GROUP_NAME
          AND Z.COUNT_DIMENSION = Y.COUNT_DIMENSION
          AND Z.DIMENSION_SORT = Y.DIMENSION_SORT */ ]';
    /*p_type = 0 更新全部历史数据
    p_type = 1  只更新上一个月的数据 */
    IF P_TYPE = 0 THEN
      --进货
      V_EXSQL1 := V_SQL1||V_WH_SQL2||V_U_SQL1||V_I_SQL1;
      --退货
      V_EXSQL2 := V_SQL2 || V_WH_SQL2 || V_U_SQL2 || V_I_SQL2;


    ELSIF P_TYPE = 1 THEN
      --进货
      V_EXSQL1 := V_SQL1||V_WM_SQL1||V_U_SQL1||V_I_SQL1;
      --退货
      V_EXSQL2 := V_SQL2 || V_WM_SQL1 || V_U_SQL2 || V_I_SQL2;
    END IF;
    EXECUTE IMMEDIATE V_EXSQL2;
    EXECUTE IMMEDIATE V_EXSQL1;
    --dbms_output.put_line(V_EXSQL1);
    --dbms_output.put_line(V_EXSQL2);

    --款式名称

    --进货数据
      V_SQL1:=q'[ MERGE INTO SCMDATA.T_RTKPI_MONTH A
             USING ( SELECT  Y.COMPANY_ID,Y.YEAR,Y.MONTH,Y.CATEGORY,Y.GROUP_NAME,Y.COUNT_DIMENSION,Y.DIMENSION_SORT,Y.ORDER_MONEY INGOOD_MONEY
                 FROM (SELECT A.COMPANY_ID,
       EXTRACT(YEAR FROM A.CREATE_TIME) YEAR,
       EXTRACT(MONTH FROM A.CREATE_TIME) MONTH,
       E.CATEGORY,
       (CASE WHEN D.GROUP_NAME IS NULL THEN  '1'  ELSE D.GROUP_NAME END) GROUP_NAME,
       '02' COUNT_DIMENSION,
       E.STYLE_NAME DIMENSION_SORT,
       SUM(A.AMOUNT * E.PRICE) ORDER_MONEY
  FROM  /*SCMDATA.T_INGOOD A
                 INNER JOIN SCMDATA.T_INGOODS B
                    ON A.ING_ID = B.ING_ID
                   AND A.COMPANY_ID = B.COMPANY_ID*/
                   (SELECT T.DOCUMENT_NO,
                    T.COMPANY_ID,
                    TRUNC(T.CREATE_TIME) CREATE_TIME,
                    SUM(TL.AMOUNT) AMOUNT,
                    TL.GOO_ID
               FROM SCMDATA.T_INGOOD T
              INNER JOIN (SELECT TI.ING_ID,
                                TI.COMPANY_ID,
                                TI.GOO_ID,
                                TI.AMOUNT
                           FROM SCMDATA.T_INGOODS TI
                          WHERE TI.AMOUNT > 0) TL
                 ON TL.ING_ID = T.ING_ID
                AND TL.COMPANY_ID = T.COMPANY_ID
              WHERE TO_CHAR(T.CREATE_TIME, 'yyyy') >= 2022
              GROUP BY T.DOCUMENT_NO,
                       T.COMPANY_ID,
                       TRUNC(T.CREATE_TIME),
                       TL.GOO_ID) A
                 /*LEFT JOIN SCMDATA.T_ORDERED C
                    ON C.ORDER_CODE = A.DOCUMENT_NO
                   AND A.COMPANY_ID = C.COMPANY_ID*/
 LEFT JOIN SCMDATA.PT_ORDERED D
   ON D.PRODUCT_GRESS_CODE = A.DOCUMENT_NO
  AND D.COMPANY_ID = A.COMPANY_ID
     INNER JOIN SCMDATA.T_COMMODITY_INFO E ON E.GOO_ID=A.GOO_ID AND E.COMPANY_ID=A.COMPANY_ID
                -- WHERE B.AMOUNT > 0
 GROUP BY A.COMPANY_ID,
          EXTRACT(YEAR FROM A.CREATE_TIME),
          EXTRACT(MONTH FROM A.CREATE_TIME),
          E.CATEGORY,
          D.GROUP_NAME,
          E.STYLE_NAME) Y      ]';

    --退货数据
    V_SQL2 := q'[MERGE INTO SCMDATA.T_RTKPI_MONTH A
USING (SELECT Y.COMPANY_ID, Y.YEAR, Y.MONTH, Y.CATEGORY,
              Y.GROUP_NAME, Y.COUNT_DIMENSION, Y.DIMENSION_SORT,
              /*Z.ORDER_MONEY INGOOD_MONEY,*/ Y.RMMONEY SHOP_RT_ORIGINAL_MONEY, X.RMMONEY2 SHOP_RT_MONEY

         FROM
         (SELECT A.COMPANY_ID, A.YEAR, A.MONTH,
                          B.CATEGORY,
                          (CASE
                            WHEN A.SUP_GROUP_NAME2 IS NULL THEN
                             '1'
                            ELSE
                             A.SUP_GROUP_NAME2
                          END) GROUP_NAME, '02' COUNT_DIMENSION,
                         B.STYLE_NAME DIMENSION_SORT,
                          SUM(CASE           WHEN REGEXP_COUNT(A.SUP_GROUP_NAME, ',') > 0 THEN
                                 A.EXAMOUNT /
                                 (REGEXP_COUNT(A.SUP_GROUP_NAME, ',') + 1) *
                                 B.PRICE
                                ELSE
                                 A.EXAMOUNT * B.PRICE
                              END) RMMONEY
                     FROM (SELECT Z.RM_ID, Z.COMPANY_ID, Z.YEAR, Z.MONTH,
                                   Z.ACCESS_TIME, Z.GOO_ID, Z.EXAMOUNT,
                                   Z.SUP_GROUP_NAME, Z.AUDIT_TIME,
                                   REGEXP_SUBSTR(Z.SUP_GROUP_NAME,
                                                  '[^,]+',
                                                  1,
                                                  LEVEL) SUP_GROUP_NAME2
                              FROM   SCMDATA.T_RETURN_MANAGEMENT z
   CONNECT BY PRIOR RM_ID = RM_ID
          AND LEVEL <= LENGTH(z.SUP_GROUP_NAME) -
              LENGTH(REGEXP_REPLACE(z.SUP_GROUP_NAME, ',', '')) + 1
          AND PRIOR DBMS_RANDOM.VALUE IS NOT NULL) A
        INNER JOIN scmdata.T_COMMODITY_INFO B
             ON A.GOO_ID = B.GOO_ID
            AND A.COMPANY_ID = B.COMPANY_ID
       WHERE A.AUDIT_TIME IS NOT NULL
       GROUP BY A.COMPANY_ID,
                A.YEAR,
                A.MONTH,
                B.CATEGORY,
                 A.SUP_GROUP_NAME2,
                B.STYLE_NAME) Y

         LEFT JOIN (SELECT A.COMPANY_ID, A.YEAR, A.MONTH,
                          B.CATEGORY,
                          (CASE  WHEN A.SUP_GROUP_NAME2 IS NULL THEN '1'    ELSE   A.SUP_GROUP_NAME2 END) GROUP_NAME,
                           '02' COUNT_DIMENSION,
                         B.STYLE_NAME DIMENSION_SORT,
                          SUM(CASE
                                WHEN REGEXP_COUNT(A.SUP_GROUP_NAME, ',') > 0 THEN
                                 A.EXAMOUNT /
                                 (REGEXP_COUNT(A.SUP_GROUP_NAME, ',') + 1) *
                                 B.PRICE
                                ELSE
                                 A.EXAMOUNT * B.PRICE
                              END) RMMONEY2
                     FROM (SELECT Z.RM_ID, Z.COMPANY_ID, Z.YEAR, Z.MONTH,
                                   Z.ACCESS_TIME, Z.GOO_ID, Z.EXAMOUNT,
                                   Z.SUP_GROUP_NAME, Z.AUDIT_TIME,
                                   Z.CAUSE_DETAIL_ID, Z.FIRST_DEPT_ID,
                                   Z.SECOND_DEPT_ID,
                                   REGEXP_SUBSTR(Z.SUP_GROUP_NAME,
                                                  '[^,]+',
                                                  1,
                                                  LEVEL) SUP_GROUP_NAME2
                              FROM SCMDATA.T_RETURN_MANAGEMENT Z
        CONNECT BY PRIOR RM_ID = RM_ID
               AND LEVEL <=
                   LENGTH(Z.SUP_GROUP_NAME) -
                   LENGTH(REGEXP_REPLACE(Z.SUP_GROUP_NAME, ',', '')) + 1
               AND PRIOR DBMS_RANDOM.VALUE IS NOT NULL) A
 INNER JOIN SCMDATA.T_COMMODITY_INFO B
    ON A.GOO_ID = B.GOO_ID
   AND A.COMPANY_ID = B.COMPANY_ID
  LEFT JOIN SCMDATA.T_ABNORMAL_DTL_CONFIG C
    ON A.CAUSE_DETAIL_ID = C.ABNORMAL_DTL_CONFIG_ID
   AND A.COMPANY_ID = C.COMPANY_ID
   AND C.ANOMALY_CLASSIFICATION = 'AC_QUALITY'
 INNER JOIN SCMDATA.SYS_COMPANY_DEPT D
    ON D.COMPANY_DEPT_ID = A.FIRST_DEPT_ID
 WHERE A.AUDIT_TIME IS NOT NULL
   AND C.CAUSE_CLASSIFICATION <> '银饰氧化问题'
   AND C.PROBLEM_CLASSIFICATION <> '非质量问题'
   AND D.DEPT_NAME = '供应链管理部'
 GROUP BY A.COMPANY_ID,
          A.YEAR,
          A.MONTH,
          B.CATEGORY,
          A.SUP_GROUP_NAME2,
          B.STYLE_NAME) X
           ON X.COMPANY_ID = Y.COMPANY_ID
          AND X.YEAR = Y.YEAR
          AND X.MONTH = Y.MONTH
          AND X.CATEGORY = Y.CATEGORY
          AND X.GROUP_NAME = Y.GROUP_NAME
          AND X.COUNT_DIMENSION = Y.COUNT_DIMENSION
          AND X.DIMENSION_SORT = Y.DIMENSION_SORT
         /* LEFT JOIN ( SELECT A.COMPANY_ID,
       EXTRACT(YEAR FROM A.CREATE_TIME) YEAR,
       EXTRACT(MONTH FROM A.CREATE_TIME) MONTH,
       D.CATEGORY,
       (CASE WHEN D.GROUP_NAME IS NULL THEN  '1'  ELSE D.GROUP_NAME END) GROUP_NAME,
       '02' COUNT_DIMENSION,
       D.STYLE_NAME DIMENSION_SORT,
       SUM(B.AMOUNT * E.PRICE) ORDER_MONEY
  FROM SCMDATA.T_INGOOD A
 INNER JOIN SCMDATA.T_INGOODS B
    ON A.ING_ID = B.ING_ID
   AND A.COMPANY_ID = B.COMPANY_ID
 INNER JOIN SCMDATA.T_ORDERED C
    ON C.ORDER_CODE = A.DOCUMENT_NO
   AND A.COMPANY_ID = C.COMPANY_ID
 INNER JOIN SCMDATA.PT_ORDERED D
    ON D.ORDER_ID = C.ORDER_ID
   AND D.COMPANY_ID = C.COMPANY_ID
  INNER JOIN SCMDATA.T_COMMODITY_INFO E ON E.GOO_ID=B.GOO_ID AND E.COMPANY_ID=B.COMPANY_ID
 WHERE B.AMOUNT > 0
 GROUP BY A.COMPANY_ID,
          EXTRACT(YEAR FROM A.CREATE_TIME),
          EXTRACT(MONTH FROM A.CREATE_TIME),
          D.CATEGORY,
          D.GROUP_NAME,
          D.STYLE_NAME) z ON Z.COMPANY_ID = Y.COMPANY_ID
          AND Z.YEAR = Y.YEAR
          AND Z.MONTH = Y.MONTH
          AND Z.CATEGORY = Y.CATEGORY
          AND Z.GROUP_NAME = Y.GROUP_NAME
          AND Z.COUNT_DIMENSION = Y.COUNT_DIMENSION
          AND Z.DIMENSION_SORT = Y.DIMENSION_SORT*/ ]';
   IF P_TYPE = 0 THEN
      --进货
      V_EXSQL1 := V_SQL1||V_WH_SQL2||V_U_SQL1||V_I_SQL1;
      --退货
      V_EXSQL2 := V_SQL2 || V_WH_SQL2 || V_U_SQL2 || V_I_SQL2;


    ELSIF P_TYPE = 1 THEN
      --进货
      V_EXSQL1 := V_SQL1||V_WM_SQL1||V_U_SQL1||V_I_SQL1;
      --退货
      V_EXSQL2 := V_SQL2 || V_WM_SQL1 || V_U_SQL2 || V_I_SQL2;
    END IF;
   EXECUTE IMMEDIATE V_EXSQL2;
    EXECUTE IMMEDIATE V_EXSQL1;
    --dbms_output.put_line(V_EXSQL1);
   -- dbms_output.put_line(V_EXSQL2);

    --产品子类
    --进货数据
    V_SQL1:=q'[ MERGE INTO SCMDATA.T_RTKPI_MONTH A
             USING ( SELECT  Y.COMPANY_ID,Y.YEAR,Y.MONTH,Y.CATEGORY,Y.GROUP_NAME,Y.COUNT_DIMENSION,Y.DIMENSION_SORT,Y.ORDER_MONEY INGOOD_MONEY
                 FROM  (SELECT A.COMPANY_ID,
       EXTRACT(YEAR FROM A.CREATE_TIME) YEAR,
       EXTRACT(MONTH FROM A.CREATE_TIME) MONTH,
       E.CATEGORY,
       (CASE WHEN D.GROUP_NAME IS NULL THEN  '1'  ELSE D.GROUP_NAME END) GROUP_NAME,
       '03' COUNT_DIMENSION,
       E.SAMLL_CATEGORY DIMENSION_SORT,
       SUM(A.AMOUNT * E.PRICE) ORDER_MONEY
  FROM  /*SCMDATA.T_INGOOD A
                 INNER JOIN SCMDATA.T_INGOODS B
                    ON A.ING_ID = B.ING_ID
                   AND A.COMPANY_ID = B.COMPANY_ID*/
                   (SELECT T.DOCUMENT_NO,
                    T.COMPANY_ID,
                    TRUNC(T.CREATE_TIME) CREATE_TIME,
                    SUM(TL.AMOUNT) AMOUNT,
                    TL.GOO_ID
               FROM SCMDATA.T_INGOOD T
              INNER JOIN (SELECT TI.ING_ID,
                                TI.COMPANY_ID,
                                TI.GOO_ID,
                                TI.AMOUNT
                           FROM SCMDATA.T_INGOODS TI
                          WHERE TI.AMOUNT > 0) TL
                 ON TL.ING_ID = T.ING_ID
                AND TL.COMPANY_ID = T.COMPANY_ID
              WHERE TO_CHAR(T.CREATE_TIME, 'yyyy') >= 2022
              GROUP BY T.DOCUMENT_NO,
                       T.COMPANY_ID,
                       TRUNC(T.CREATE_TIME),
                       TL.GOO_ID) A
                 /*LEFT JOIN SCMDATA.T_ORDERED C
                    ON C.ORDER_CODE = A.DOCUMENT_NO
                   AND A.COMPANY_ID = C.COMPANY_ID*/
 LEFT JOIN SCMDATA.PT_ORDERED D
   ON D.PRODUCT_GRESS_CODE = A.DOCUMENT_NO
  AND D.COMPANY_ID = A.COMPANY_ID
     INNER JOIN SCMDATA.T_COMMODITY_INFO E ON E.GOO_ID=A.GOO_ID AND E.COMPANY_ID=A.COMPANY_ID
                -- WHERE B.AMOUNT > 0
 GROUP BY A.COMPANY_ID,
          EXTRACT(YEAR FROM A.CREATE_TIME),
          EXTRACT(MONTH FROM A.CREATE_TIME),
          E.CATEGORY,
          D.GROUP_NAME,
          E.SAMLL_CATEGORY) Y
    ]';


    --退货数据
    V_SQL2 := q'[MERGE INTO SCMDATA.T_RTKPI_MONTH A
USING (SELECT Y.COMPANY_ID, Y.YEAR, Y.MONTH,  Y.CATEGORY,
              Y.GROUP_NAME, Y.COUNT_DIMENSION, Y.DIMENSION_SORT,
              /*Z.ORDER_MONEY INGOOD_MONEY,*/ Y.RMMONEY SHOP_RT_ORIGINAL_MONEY, X.RMMONEY2 SHOP_RT_MONEY

         FROM
         (SELECT A.COMPANY_ID, A.YEAR, A.MONTH,
                          B.CATEGORY,
                          (CASE
                            WHEN A.SUP_GROUP_NAME2 IS NULL THEN
                             '1'
                            ELSE
                             A.SUP_GROUP_NAME2
                          END) GROUP_NAME, '03' COUNT_DIMENSION,
                         B.SAMLL_CATEGORY DIMENSION_SORT,
                          SUM(CASE           WHEN REGEXP_COUNT(A.SUP_GROUP_NAME, ',') > 0 THEN
                                 A.EXAMOUNT /
                                 (REGEXP_COUNT(A.SUP_GROUP_NAME, ',') + 1) *
                                 B.PRICE
                                ELSE
                                 A.EXAMOUNT * B.PRICE
                              END) RMMONEY
                     FROM (SELECT Z.RM_ID, Z.COMPANY_ID, Z.YEAR, Z.MONTH,
                                   Z.ACCESS_TIME, Z.GOO_ID, Z.EXAMOUNT,
                                   Z.SUP_GROUP_NAME, Z.AUDIT_TIME,
                                   REGEXP_SUBSTR(Z.SUP_GROUP_NAME,
                                                  '[^,]+',
                                                  1,
                                                  LEVEL) SUP_GROUP_NAME2
                              FROM  SCMDATA.T_RETURN_MANAGEMENT z
   CONNECT BY PRIOR RM_ID = RM_ID
          AND LEVEL <= LENGTH(z.SUP_GROUP_NAME) -
              LENGTH(REGEXP_REPLACE(z.SUP_GROUP_NAME, ',', '')) + 1
          AND PRIOR DBMS_RANDOM.VALUE IS NOT NULL) A
        INNER JOIN scmdata.T_COMMODITY_INFO B
             ON A.GOO_ID = B.GOO_ID
            AND A.COMPANY_ID = B.COMPANY_ID
       WHERE A.AUDIT_TIME IS NOT NULL
       GROUP BY A.COMPANY_ID,
                A.YEAR,
                A.MONTH,
                B.CATEGORY,
                 A.SUP_GROUP_NAME2,
                B.SAMLL_CATEGORY) Y

         LEFT JOIN (SELECT A.COMPANY_ID, A.YEAR, A.MONTH,
                          B.CATEGORY,
                          (CASE  WHEN A.SUP_GROUP_NAME2 IS NULL THEN '1'    ELSE   A.SUP_GROUP_NAME2 END) GROUP_NAME,
                           '03' COUNT_DIMENSION,
                         B.SAMLL_CATEGORY DIMENSION_SORT,
                          SUM(CASE
                                WHEN REGEXP_COUNT(A.SUP_GROUP_NAME, ',') > 0 THEN
                                 A.EXAMOUNT /
                                 (REGEXP_COUNT(A.SUP_GROUP_NAME, ',') + 1) *
                                 B.PRICE
                                ELSE
                                 A.EXAMOUNT * B.PRICE
                              END) RMMONEY2
                     FROM (SELECT Z.RM_ID, Z.COMPANY_ID, Z.YEAR, Z.MONTH,
                                   Z.ACCESS_TIME, Z.GOO_ID, Z.EXAMOUNT,
                                   Z.SUP_GROUP_NAME, Z.AUDIT_TIME,
                                   Z.CAUSE_DETAIL_ID, Z.FIRST_DEPT_ID,
                                   Z.SECOND_DEPT_ID,
                                   REGEXP_SUBSTR(Z.SUP_GROUP_NAME,
                                                  '[^,]+',
                                                  1,
                                                  LEVEL) SUP_GROUP_NAME2
                              FROM SCMDATA.T_RETURN_MANAGEMENT Z
        CONNECT BY PRIOR RM_ID = RM_ID
               AND LEVEL <=
                   LENGTH(Z.SUP_GROUP_NAME) -
                   LENGTH(REGEXP_REPLACE(Z.SUP_GROUP_NAME, ',', '')) + 1
               AND PRIOR DBMS_RANDOM.VALUE IS NOT NULL) A
 INNER JOIN SCMDATA.T_COMMODITY_INFO B
    ON A.GOO_ID = B.GOO_ID
   AND A.COMPANY_ID = B.COMPANY_ID
  LEFT JOIN SCMDATA.T_ABNORMAL_DTL_CONFIG C
    ON A.CAUSE_DETAIL_ID = C.ABNORMAL_DTL_CONFIG_ID
   AND A.COMPANY_ID = C.COMPANY_ID
   AND C.ANOMALY_CLASSIFICATION = 'AC_QUALITY'
 INNER JOIN SCMDATA.SYS_COMPANY_DEPT D
    ON D.COMPANY_DEPT_ID = A.FIRST_DEPT_ID
 WHERE A.AUDIT_TIME IS NOT NULL
   AND C.CAUSE_CLASSIFICATION <> '银饰氧化问题'
   AND C.PROBLEM_CLASSIFICATION <> '非质量问题'
   AND D.DEPT_NAME = '供应链管理部'
 GROUP BY A.COMPANY_ID,
          A.YEAR,
          A.MONTH,
          B.CATEGORY,
          A.SUP_GROUP_NAME2,
          B.SAMLL_CATEGORY) X
           ON X.COMPANY_ID = Y.COMPANY_ID
          AND X.YEAR = Y.YEAR
          AND X.MONTH = Y.MONTH
          AND X.CATEGORY = Y.CATEGORY
          AND X.GROUP_NAME = Y.GROUP_NAME
          AND X.COUNT_DIMENSION = Y.COUNT_DIMENSION
          AND X.DIMENSION_SORT = Y.DIMENSION_SORT
          /*LEFT JOIN
          (  SELECT A.COMPANY_ID,
       EXTRACT(YEAR FROM A.CREATE_TIME) YEAR,
       EXTRACT(MONTH FROM A.CREATE_TIME) MONTH,
       D.CATEGORY,
       (CASE WHEN D.GROUP_NAME IS NULL THEN  '1'  ELSE D.GROUP_NAME END) GROUP_NAME,
       '03' COUNT_DIMENSION,
       D.SAMLL_CATEGORY DIMENSION_SORT,
       SUM(B.AMOUNT * E.PRICE) ORDER_MONEY
  FROM SCMDATA.T_INGOOD A
 INNER JOIN SCMDATA.T_INGOODS B
    ON A.ING_ID = B.ING_ID
   AND A.COMPANY_ID = B.COMPANY_ID
 INNER JOIN SCMDATA.T_ORDERED C
    ON C.ORDER_CODE = A.DOCUMENT_NO
   AND A.COMPANY_ID = C.COMPANY_ID
 INNER JOIN SCMDATA.PT_ORDERED D
    ON D.ORDER_ID = C.ORDER_ID
   AND D.COMPANY_ID = C.COMPANY_ID
  INNER JOIN SCMDATA.T_COMMODITY_INFO E ON E.GOO_ID=B.GOO_ID AND E.COMPANY_ID=B.COMPANY_ID
 WHERE B.AMOUNT > 0
 GROUP BY A.COMPANY_ID,
          EXTRACT(YEAR FROM A.CREATE_TIME),
          EXTRACT(MONTH FROM A.CREATE_TIME),
          D.CATEGORY,
          D.GROUP_NAME,
          D.SAMLL_CATEGORY) z ON Z.COMPANY_ID = Y.COMPANY_ID
          AND Z.YEAR = Y.YEAR
          AND Z.MONTH = Y.MONTH
          AND Z.CATEGORY = Y.CATEGORY
          AND Z.GROUP_NAME = Y.GROUP_NAME
          AND Z.COUNT_DIMENSION = Y.COUNT_DIMENSION
          AND Z.DIMENSION_SORT = Y.DIMENSION_SORT*/  ]';
   IF P_TYPE = 0 THEN
      --进货
      V_EXSQL1 := V_SQL1||V_WH_SQL2||V_U_SQL1||V_I_SQL1;
      --退货
      V_EXSQL2 := V_SQL2 || V_WH_SQL2 || V_U_SQL2 || V_I_SQL2;


    ELSIF P_TYPE = 1 THEN
      --进货
      V_EXSQL1 := V_SQL1||V_WM_SQL1||V_U_SQL1||V_I_SQL1;
      --退货
      V_EXSQL2 := V_SQL2 || V_WM_SQL1 || V_U_SQL2 || V_I_SQL2;
    END IF;
    EXECUTE IMMEDIATE V_EXSQL2;
    EXECUTE IMMEDIATE V_EXSQL1;
    --dbms_output.put_line(V_EXSQL1);
    --dbms_output.put_line(V_EXSQL2);

    --  供应商
    V_SQL1:=q'[MERGE INTO SCMDATA.T_RTKPI_MONTH A
             USING ( SELECT  Y.COMPANY_ID,Y.YEAR,Y.MONTH,Y.CATEGORY,Y.GROUP_NAME,Y.COUNT_DIMENSION,Y.DIMENSION_SORT,Y.ORDER_MONEY INGOOD_MONEY
                 FROM ( SELECT A.COMPANY_ID,
       EXTRACT(YEAR FROM A.CREATE_TIME) YEAR,
       EXTRACT(MONTH FROM A.CREATE_TIME) MONTH,
       E.CATEGORY,
       (CASE WHEN D.GROUP_NAME IS NULL THEN  '1'  ELSE D.GROUP_NAME END) GROUP_NAME,
       '04' COUNT_DIMENSION,
       A.SUPPLIER_CODE DIMENSION_SORT,
       SUM(A.AMOUNT * E.PRICE) ORDER_MONEY
  FROM  /*SCMDATA.T_INGOOD A
                 INNER JOIN SCMDATA.T_INGOODS B
                    ON A.ING_ID = B.ING_ID
                   AND A.COMPANY_ID = B.COMPANY_ID*/
                   (SELECT T.DOCUMENT_NO,
                    T.COMPANY_ID,
                    T.SUPPLIER_CODE,
                    TRUNC(T.CREATE_TIME) CREATE_TIME,
                    SUM(TL.AMOUNT) AMOUNT,
                    TL.GOO_ID
               FROM SCMDATA.T_INGOOD T
              INNER JOIN (SELECT TI.ING_ID,
                                TI.COMPANY_ID,
                                TI.GOO_ID,
                                TI.AMOUNT
                           FROM SCMDATA.T_INGOODS TI
                          WHERE TI.AMOUNT > 0) TL
                 ON TL.ING_ID = T.ING_ID
                AND TL.COMPANY_ID = T.COMPANY_ID
              WHERE TO_CHAR(T.CREATE_TIME, 'yyyy') >= 2022
              GROUP BY T.DOCUMENT_NO,
                       T.COMPANY_ID,
                       T.SUPPLIER_CODE,
                       TRUNC(T.CREATE_TIME),
                       TL.GOO_ID) A
                 /*LEFT JOIN SCMDATA.T_ORDERED C
                    ON C.ORDER_CODE = A.DOCUMENT_NO
                   AND A.COMPANY_ID = C.COMPANY_ID*/
 LEFT JOIN SCMDATA.PT_ORDERED D
   ON D.PRODUCT_GRESS_CODE = A.DOCUMENT_NO
  AND D.COMPANY_ID = A.COMPANY_ID
     INNER JOIN SCMDATA.T_COMMODITY_INFO E ON E.GOO_ID=A.GOO_ID AND E.COMPANY_ID=A.COMPANY_ID
                -- WHERE B.AMOUNT > 0
 GROUP BY A.COMPANY_ID,
          EXTRACT(YEAR FROM A.CREATE_TIME),
          EXTRACT(MONTH FROM A.CREATE_TIME),
          E.CATEGORY,
          D.GROUP_NAME,
          A.SUPPLIER_CODE) Y ]';

    V_SQL2 := q'[ MERGE INTO SCMDATA.T_RTKPI_MONTH A
USING (SELECT Y.COMPANY_ID, Y.YEAR, Y.MONTH,  Y.CATEGORY,
              Y.GROUP_NAME, Y.COUNT_DIMENSION, Y.DIMENSION_SORT,
              /*Z.ORDER_MONEY INGOOD_MONEY,*/ Y.RMMONEY SHOP_RT_ORIGINAL_MONEY, X.RMMONEY2 SHOP_RT_MONEY

         FROM
         (SELECT A.COMPANY_ID, A.YEAR, A.MONTH,
                          B.CATEGORY,
                          (CASE
                            WHEN A.SUP_GROUP_NAME2 IS NULL THEN
                             '1'
                            ELSE
                             A.SUP_GROUP_NAME2
                          END) GROUP_NAME, '04' COUNT_DIMENSION,
                         A.SUPPLIER_CODE DIMENSION_SORT,
                          SUM(CASE           WHEN REGEXP_COUNT(A.SUP_GROUP_NAME, ',') > 0 THEN
                                 A.EXAMOUNT /
                                 (REGEXP_COUNT(A.SUP_GROUP_NAME, ',') + 1) *
                                 B.PRICE
                                ELSE
                                 A.EXAMOUNT * B.PRICE
                              END) RMMONEY
                     FROM (SELECT Z.RM_ID, Z.COMPANY_ID, Z.YEAR, Z.MONTH,
                                   Z.ACCESS_TIME, Z.GOO_ID, Z.EXAMOUNT,
                                   Z.SUP_GROUP_NAME, Z.AUDIT_TIME,
                                   Z.SUPPLIER_CODE,
                                   REGEXP_SUBSTR(Z.SUP_GROUP_NAME,
                                                  '[^,]+',
                                                  1,
                                                  LEVEL) SUP_GROUP_NAME2
                              FROM SCMDATA.T_RETURN_MANAGEMENT z
   CONNECT BY PRIOR RM_ID = RM_ID
          AND LEVEL <= LENGTH(z.SUP_GROUP_NAME) -
              LENGTH(REGEXP_REPLACE(z.SUP_GROUP_NAME, ',', '')) + 1
          AND PRIOR DBMS_RANDOM.VALUE IS NOT NULL) A
        INNER JOIN scmdata.T_COMMODITY_INFO B
             ON A.GOO_ID = B.GOO_ID
            AND A.COMPANY_ID = B.COMPANY_ID
       WHERE A.AUDIT_TIME IS NOT NULL
       GROUP BY A.COMPANY_ID,
                A.YEAR,
                A.MONTH,
                B.CATEGORY,
                 A.SUP_GROUP_NAME2,
                A.SUPPLIER_CODE) Y

         LEFT JOIN (SELECT A.COMPANY_ID, A.YEAR, A.MONTH,
                          B.CATEGORY,
                          (CASE  WHEN A.SUP_GROUP_NAME2 IS NULL THEN '1'    ELSE   A.SUP_GROUP_NAME2 END) GROUP_NAME,
                           '04' COUNT_DIMENSION,
                         A.SUPPLIER_CODE DIMENSION_SORT,
                          SUM(CASE
                                WHEN REGEXP_COUNT(A.SUP_GROUP_NAME, ',') > 0 THEN
                                 A.EXAMOUNT /
                                 (REGEXP_COUNT(A.SUP_GROUP_NAME, ',') + 1) *
                                 B.PRICE
                                ELSE
                                 A.EXAMOUNT * B.PRICE
                              END) RMMONEY2
                     FROM (SELECT Z.RM_ID, Z.COMPANY_ID, Z.YEAR, Z.MONTH,
                                   Z.ACCESS_TIME, Z.GOO_ID, Z.EXAMOUNT,
                                   Z.SUP_GROUP_NAME, Z.AUDIT_TIME,
                                   Z.CAUSE_DETAIL_ID, Z.FIRST_DEPT_ID,
                                   Z.SECOND_DEPT_ID,
                                   Z.SUPPLIER_CODE,
                                   REGEXP_SUBSTR(Z.SUP_GROUP_NAME,
                                                  '[^,]+',
                                                  1,
                                                  LEVEL) SUP_GROUP_NAME2
                              FROM SCMDATA.T_RETURN_MANAGEMENT Z
        CONNECT BY PRIOR RM_ID = RM_ID
               AND LEVEL <=
                   LENGTH(Z.SUP_GROUP_NAME) -
                   LENGTH(REGEXP_REPLACE(Z.SUP_GROUP_NAME, ',', '')) + 1
               AND PRIOR DBMS_RANDOM.VALUE IS NOT NULL) A
 INNER JOIN SCMDATA.T_COMMODITY_INFO B
    ON A.GOO_ID = B.GOO_ID
   AND A.COMPANY_ID = B.COMPANY_ID
  LEFT JOIN SCMDATA.T_ABNORMAL_DTL_CONFIG C
    ON A.CAUSE_DETAIL_ID = C.ABNORMAL_DTL_CONFIG_ID
   AND A.COMPANY_ID = C.COMPANY_ID
   AND C.ANOMALY_CLASSIFICATION = 'AC_QUALITY'
 INNER JOIN SCMDATA.SYS_COMPANY_DEPT D
    ON D.COMPANY_DEPT_ID = A.FIRST_DEPT_ID
 WHERE A.AUDIT_TIME IS NOT NULL
   AND C.CAUSE_CLASSIFICATION <> '银饰氧化问题'
   AND C.PROBLEM_CLASSIFICATION <> '非质量问题'
   AND D.DEPT_NAME = '供应链管理部'
 GROUP BY A.COMPANY_ID,
          A.YEAR,
          A.MONTH,
          B.CATEGORY,
          A.SUP_GROUP_NAME2,
          A.SUPPLIER_CODE) X
           ON X.COMPANY_ID = Y.COMPANY_ID
          AND X.YEAR = Y.YEAR
          AND X.MONTH = Y.MONTH
          AND X.CATEGORY = Y.CATEGORY
          AND X.GROUP_NAME = Y.GROUP_NAME
          AND X.COUNT_DIMENSION = Y.COUNT_DIMENSION
          AND X.DIMENSION_SORT = Y.DIMENSION_SORT
          /*LEFT JOIN
          --进货数据
          (  SELECT A.COMPANY_ID,
       EXTRACT(YEAR FROM A.CREATE_TIME) YEAR,
       EXTRACT(MONTH FROM A.CREATE_TIME) MONTH,
       D.CATEGORY,
       (CASE WHEN D.GROUP_NAME IS NULL THEN  '1'  ELSE D.GROUP_NAME END) GROUP_NAME,
       '04' COUNT_DIMENSION,
       C.SUPPLIER_CODE DIMENSION_SORT,
       SUM(B.AMOUNT * E.PRICE) ORDER_MONEY
  FROM SCMDATA.T_INGOOD A
 INNER JOIN SCMDATA.T_INGOODS B
    ON A.ING_ID = B.ING_ID
   AND A.COMPANY_ID = B.COMPANY_ID
 INNER JOIN SCMDATA.T_ORDERED C
    ON C.ORDER_CODE = A.DOCUMENT_NO
   AND A.COMPANY_ID = C.COMPANY_ID
 INNER JOIN SCMDATA.PT_ORDERED D
    ON D.ORDER_ID = C.ORDER_ID
   AND D.COMPANY_ID = C.COMPANY_ID
  INNER JOIN SCMDATA.T_COMMODITY_INFO E ON E.GOO_ID=B.GOO_ID AND E.COMPANY_ID=B.COMPANY_ID
 WHERE B.AMOUNT > 0
 GROUP BY A.COMPANY_ID,
          EXTRACT(YEAR FROM A.CREATE_TIME),
          EXTRACT(MONTH FROM A.CREATE_TIME),
          D.CATEGORY,
          D.GROUP_NAME,
          C.SUPPLIER_CODE) z ON Z.COMPANY_ID = Y.COMPANY_ID
          AND Z.YEAR = Y.YEAR
          AND Z.MONTH = Y.MONTH
          AND Z.CATEGORY = Y.CATEGORY
          AND Z.GROUP_NAME = Y.GROUP_NAME
          AND Z.COUNT_DIMENSION = Y.COUNT_DIMENSION
          AND Z.DIMENSION_SORT = Y.DIMENSION_SORT */]';

     IF P_TYPE = 0 THEN
      --进货
      V_EXSQL1 := V_SQL1||V_WH_SQL2||V_U_SQL1||V_I_SQL1;
      --退货
      V_EXSQL2 := V_SQL2 || V_WH_SQL2 || V_U_SQL2 || V_I_SQL2;


    ELSIF P_TYPE = 1 THEN
      --进货
      V_EXSQL1 := V_SQL1||V_WM_SQL1||V_U_SQL1||V_I_SQL1;
      --退货
      V_EXSQL2 := V_SQL2 || V_WM_SQL1 || V_U_SQL2 || V_I_SQL2;
    END IF;
   EXECUTE IMMEDIATE V_EXSQL2;
   EXECUTE IMMEDIATE V_EXSQL1;
    --dbms_output.put_line(V_EXSQL1);
    --dbms_output.put_line(V_EXSQL2);

    --跟单
    --进货
    V_SQL1:=q'[ MERGE INTO SCMDATA.T_RTKPI_MONTH A
             USING ( SELECT  Y.COMPANY_ID,Y.YEAR,Y.MONTH,Y.CATEGORY,Y.GROUP_NAME,Y.COUNT_DIMENSION,
             Y.DIMENSION_SORT,
             Y.ORDER_MONEY INGOOD_MONEY
                 FROM   (SELECT A.COMPANY_ID, EXTRACT(YEAR FROM A.CREATE_TIME) YEAR,
                    EXTRACT(MONTH FROM A.CREATE_TIME) MONTH,
                    E.CATEGORY,
                    (CASE WHEN D.GROUP_NAME IS NULL THEN  '1'    ELSE    D.GROUP_NAME    END) GROUP_NAME, '05' COUNT_DIMENSION,
                    (CASE WHEN D.GENDAN IS NULL OR D.GENDAN = 'ORDERED_ITF' THEN '1' ELSE D.GENDAN  END) DIMENSION_SORT,
                    SUM(CASE  WHEN REGEXP_COUNT(D.FLW_ORDER, ',') > 0 THEN
                           A.AMOUNT / NVL((REGEXP_COUNT(D.FLW_ORDER, ',') + 1),1) *
                           E.PRICE
                          ELSE
                           A.AMOUNT * E.PRICE
                        END) ORDER_MONEY
               FROM  /*SCMDATA.T_INGOOD A
                 INNER JOIN SCMDATA.T_INGOODS B
                    ON A.ING_ID = B.ING_ID
                   AND A.COMPANY_ID = B.COMPANY_ID*/
                   (SELECT T.DOCUMENT_NO,
                    T.COMPANY_ID,
                    TRUNC(T.CREATE_TIME) CREATE_TIME,
                    SUM(TL.AMOUNT) AMOUNT,
                    TL.GOO_ID
               FROM SCMDATA.T_INGOOD T
              INNER JOIN (SELECT TI.ING_ID,
                                TI.COMPANY_ID,
                                TI.GOO_ID,
                                TI.AMOUNT
                           FROM SCMDATA.T_INGOODS TI
                          WHERE TI.AMOUNT > 0) TL
                 ON TL.ING_ID = T.ING_ID
                AND TL.COMPANY_ID = T.COMPANY_ID
              WHERE TO_CHAR(T.CREATE_TIME, 'yyyy') >= 2022
              GROUP BY T.DOCUMENT_NO,
                       T.COMPANY_ID,
                       TRUNC(T.CREATE_TIME),
                       TL.GOO_ID) A
                 /*LEFT JOIN SCMDATA.T_ORDERED C
                    ON C.ORDER_CODE = A.DOCUMENT_NO
                   AND A.COMPANY_ID = C.COMPANY_ID*/
              LEFT JOIN (SELECT Z.*, REGEXP_SUBSTR(Z.FLW_ORDER, '[^,]+', 1, LEVEL) GENDAN
                           FROM SCMDATA.PT_ORDERED Z
                         CONNECT BY PRIOR Z.PT_ORDERED_ID = Z.PT_ORDERED_ID
                                AND LEVEL <= LENGTH(Z.FLW_ORDER) -
                                    LENGTH(REGEXP_REPLACE(Z.FLW_ORDER, ',', '')) + 1
                                AND PRIOR DBMS_RANDOM.VALUE IS NOT NULL) D
                 ON D.PRODUCT_GRESS_CODE = A.DOCUMENT_NO
                AND D.COMPANY_ID = A.COMPANY_ID
              INNER JOIN SCMDATA.T_COMMODITY_INFO E ON E.GOO_ID=A.GOO_ID AND E.COMPANY_ID=A.COMPANY_ID
              --WHERE B.AMOUNT > 0
              GROUP BY A.COMPANY_ID, EXTRACT(YEAR FROM A.CREATE_TIME),
                       EXTRACT(MONTH FROM A.CREATE_TIME), E.CATEGORY,
                       D.GROUP_NAME, 
                       (CASE WHEN D.GENDAN IS NULL OR D.GENDAN = 'ORDERED_ITF' THEN '1'  ELSE   D.GENDAN  END)) Y ]';


    --退货
    V_SQL2 := q'[  MERGE INTO SCMDATA.T_RTKPI_MONTH A
USING (
WITH TEMP_RT AS
 (SELECT Z.*,
         Z.RM_ID || ROW_NUMBER() OVER(PARTITION BY Z.RM_ID ORDER BY 1) RM_ID2,
         Z.EXAMOUNT / (COUNT(Z.RM_ID) OVER(PARTITION BY(Z.RM_ID))) EXGAMOUNT2,
         REGEXP_SUBSTR(Z.SUP_GROUP_NAME, '[^,]+', 1, LEVEL) SUP_GROUP_NAME2
    FROM SCMDATA.T_RETURN_MANAGEMENT Z
   WHERE Z.AUDIT_TIME IS NOT NULL
  CONNECT BY PRIOR RM_ID = RM_ID
         AND LEVEL <= LENGTH(Z.SUP_GROUP_NAME) -
             LENGTH(REGEXP_REPLACE(Z.SUP_GROUP_NAME, ',', '')) + 1
         AND PRIOR DBMS_RANDOM.VALUE IS NOT NULL)

SELECT Y.COMPANY_ID, Y.YEAR, Y.MONTH,  Y.CATEGORY, Y.GROUP_NAME,
       Y.COUNT_DIMENSION, Y.DIMENSION_SORT, /*Z.ORDER_MONEY INGOOD_MONEY,*/
       Y.RMMONEY SHOP_RT_ORIGINAL_MONEY, X.RMMONEY2 SHOP_RT_MONEY

  FROM (SELECT A.COMPANY_ID, A.YEAR, A.MONTH, B.CATEGORY,
                (CASE WHEN A.SUP_GROUP_NAME2 IS NULL THEN  '1'    ELSE   A.SUP_GROUP_NAME2  END) GROUP_NAME, '05' COUNT_DIMENSION,
                (CASE WHEN A.GENDAN2 IS NULL THEN '1'  ELSE   A.GENDAN2  END) DIMENSION_SORT, SUM(A.EXGAMOUNT3 * B.PRICE) RMMONEY
           FROM (SELECT Z.RM_ID, Z.COMPANY_ID, Z.YEAR, Z.MONTH, Z.ACCESS_TIME,
                         Z.GOO_ID, Z.EXAMOUNT, Z.SUP_GROUP_NAME, Z.AUDIT_TIME,
                         Z.SUP_GROUP_NAME2,
                         Z.EXGAMOUNT2 / NVL((REGEXP_COUNT(Z.MERCHER_ID, ',') + 1),1) EXGAMOUNT3,
                         REGEXP_SUBSTR(Z.MERCHER_ID, '[^,]+', 1, LEVEL) GENDAN2
                    FROM TEMP_RT Z
                  CONNECT BY PRIOR Z.RM_ID2 = Z.RM_ID2
                         AND LEVEL <=
                             LENGTH(Z.MERCHER_ID) -
                             LENGTH(REGEXP_REPLACE(Z.MERCHER_ID, ',', '')) + 1
                         AND PRIOR DBMS_RANDOM.VALUE IS NOT NULL) A
          INNER JOIN SCMDATA.T_COMMODITY_INFO B
             ON A.GOO_ID = B.GOO_ID
            AND A.COMPANY_ID = B.COMPANY_ID
          WHERE A.AUDIT_TIME IS NOT NULL
          GROUP BY A.COMPANY_ID, A.YEAR, A.MONTH, B.CATEGORY,
                   A.SUP_GROUP_NAME2, A.GENDAN2) Y
  LEFT JOIN (SELECT A.COMPANY_ID, A.YEAR, A.MONTH,
                    B.CATEGORY,
                    (CASE WHEN A.SUP_GROUP_NAME2 IS NULL THEN '1'  ELSE  A.SUP_GROUP_NAME2  END) GROUP_NAME, '05' COUNT_DIMENSION,
                    (CASE  WHEN A.GENDAN2 IS NULL THEN  '1'    ELSE   A.GENDAN2    END) DIMENSION_SORT, SUM(A.EXGAMOUNT3 * B.PRICE) RMMONEY2
               FROM (SELECT Z.RM_ID, Z.COMPANY_ID, Z.YEAR, Z.MONTH,
                             Z.ACCESS_TIME, Z.GOO_ID, Z.EXAMOUNT,
                             Z.SUP_GROUP_NAME, Z.AUDIT_TIME, Z.CAUSE_DETAIL_ID,
                             Z.FIRST_DEPT_ID, Z.SUP_GROUP_NAME2,
                             Z.SECOND_DEPT_ID,
                             Z.EXGAMOUNT2 /
                              NVL((REGEXP_COUNT(Z.MERCHER_ID, ',') + 1),1) EXGAMOUNT3,
                             REGEXP_SUBSTR(Z.MERCHER_ID, '[^,]+', 1, LEVEL) GENDAN2
                        FROM TEMP_RT Z

                      CONNECT BY PRIOR Z.RM_ID2 = Z.RM_ID2
                             AND LEVEL <=
                                 LENGTH(Z.MERCHER_ID) -
                                 LENGTH(REGEXP_REPLACE(Z.MERCHER_ID, ',', '')) + 1
                             AND PRIOR DBMS_RANDOM.VALUE IS NOT NULL) A
              INNER JOIN SCMDATA.T_COMMODITY_INFO B
                 ON A.GOO_ID = B.GOO_ID
                AND A.COMPANY_ID = B.COMPANY_ID
               LEFT JOIN SCMDATA.T_ABNORMAL_DTL_CONFIG C
                 ON A.CAUSE_DETAIL_ID = C.ABNORMAL_DTL_CONFIG_ID
                AND A.COMPANY_ID = C.COMPANY_ID
                AND C.ANOMALY_CLASSIFICATION = 'AC_QUALITY'
              INNER JOIN SCMDATA.SYS_COMPANY_DEPT D
                 ON D.COMPANY_DEPT_ID = A.FIRST_DEPT_ID
              WHERE A.AUDIT_TIME IS NOT NULL
                AND C.CAUSE_CLASSIFICATION <> '银饰氧化问题'
                AND C.PROBLEM_CLASSIFICATION <> '非质量问题'
                AND D.DEPT_NAME = '供应链管理部'
                AND INSTR(A.SECOND_DEPT_ID,
                          'b550778b4f2d36b4e0533c281caca074') > 0
              GROUP BY A.COMPANY_ID, A.YEAR, A.MONTH, B.CATEGORY,
                       A.SUP_GROUP_NAME2, A.GENDAN2) X
    ON X.COMPANY_ID = Y.COMPANY_ID
   AND X.YEAR = Y.YEAR
   AND X.MONTH = Y.MONTH
   AND X.CATEGORY = Y.CATEGORY
   AND X.GROUP_NAME = Y.GROUP_NAME
   AND X.COUNT_DIMENSION = Y.COUNT_DIMENSION
   AND X.DIMENSION_SORT = Y.DIMENSION_SORT
  /*LEFT JOIN (SELECT A.COMPANY_ID, EXTRACT(YEAR FROM A.ACCESS_TIME) YEAR,
                    EXTRACT(MONTH FROM A.CREATE_TIME) MONTH,
                    D.CATEGORY,
                    (CASE
                      WHEN D.GROUP_NAME IS NULL THEN
                       '1'
                      ELSE
                       D.GROUP_NAME
                    END) GROUP_NAME, '05' COUNT_DIMENSION,
                    (CASE
                      WHEN D.GENDAN IS NULL THEN
                       '1'
                      ELSE
                       D.GENDAN
                    END) DIMENSION_SORT,
                    SUM(CASE
                          WHEN REGEXP_COUNT(D.FLW_ORDER, ',') > 0 THEN
                           B.AMOUNT / NVL((REGEXP_COUNT(D.FLW_ORDER, ',') + 1),1) *
                           E.PRICE
                          ELSE
                           B.AMOUNT * E.PRICE
                        END) ORDER_MONEY
               FROM SCMDATA.T_INGOOD A
              INNER JOIN SCMDATA.T_INGOODS B
                 ON A.ING_ID = B.ING_ID
                AND A.COMPANY_ID = B.COMPANY_ID
              INNER JOIN SCMDATA.T_ORDERED C
                 ON C.ORDER_CODE = A.DOCUMENT_NO
                AND A.COMPANY_ID = C.COMPANY_ID
              INNER JOIN (SELECT Z.*,
                                REGEXP_SUBSTR(Z.FLW_ORDER, '[^,]+', 1, LEVEL) GENDAN
                           FROM SCMDATA.PT_ORDERED Z
                         CONNECT BY PRIOR Z.PT_ORDERED_ID = Z.PT_ORDERED_ID
                                AND LEVEL <=
                                    LENGTH(Z.FLW_ORDER) -
                                    LENGTH(REGEXP_REPLACE(Z.FLW_ORDER,
                                                          ',',
                                                          '')) + 1
                                AND PRIOR DBMS_RANDOM.VALUE IS NOT NULL) D
                 ON D.ORDER_ID = C.ORDER_ID
                AND D.COMPANY_ID = C.COMPANY_ID
                 INNER JOIN SCMDATA.T_COMMODITY_INFO E ON E.GOO_ID=B.GOO_ID AND E.COMPANY_ID=B.COMPANY_ID
              WHERE B.AMOUNT > 0
              GROUP BY A.COMPANY_ID, EXTRACT(YEAR FROM A.CREATE_TIME),
                       EXTRACT(MONTH FROM A.CREATE_TIME), D.CATEGORY,
                       D.GROUP_NAME, D.GENDAN) Z
    ON Z.COMPANY_ID = Y.COMPANY_ID
   AND Z.YEAR = Y.YEAR
   AND Z.MONTH = Y.MONTH
   AND Z.CATEGORY = Y.CATEGORY
   AND Z.GROUP_NAME = Y.GROUP_NAME
   AND Z.COUNT_DIMENSION = Y.COUNT_DIMENSION
   AND Z.DIMENSION_SORT = Y.DIMENSION_SORT*/ ]';
    IF P_TYPE = 0 THEN
      --进货
      V_EXSQL1 := V_SQL1||V_WH_SQL2||V_U_SQL1||V_I_SQL1;
      --退货
      V_EXSQL2 := V_SQL2 || V_WH_SQL2 || V_U_SQL2 || V_I_SQL2;


    ELSIF P_TYPE = 1 THEN
      --进货
      V_EXSQL1 := V_SQL1||V_WM_SQL1||V_U_SQL1||V_I_SQL1;
      --退货
      V_EXSQL2 := V_SQL2 || V_WM_SQL1 || V_U_SQL2 || V_I_SQL2;
    END IF;
   EXECUTE IMMEDIATE V_EXSQL2;
   EXECUTE IMMEDIATE V_EXSQL1;
    --dbms_output.put_line(V_EXSQL1);
   --dbms_output.put_line(V_EXSQL2);

    -- 06跟单主管
    --进货
    V_SQL1:=q'[ MERGE INTO SCMDATA.T_RTKPI_MONTH A
             USING ( SELECT  Y.COMPANY_ID,Y.YEAR,Y.MONTH,Y.CATEGORY,Y.GROUP_NAME,Y.COUNT_DIMENSION,Y.DIMENSION_SORT,Y.ORDER_MONEY INGOOD_MONEY
                 FROM (SELECT A.COMPANY_ID, EXTRACT(YEAR FROM A.CREATE_TIME) YEAR,
                      EXTRACT(MONTH FROM A.CREATE_TIME) MONTH,
                      E.CATEGORY,
                      (CASE WHEN D.GROUP_NAME IS NULL THEN '1' ELSE D.GROUP_NAME END) GROUP_NAME,
                       '06' COUNT_DIMENSION,
                      (CASE WHEN D.GENDANZG IS NULL THEN '1' ELSE D.GENDANZG END) DIMENSION_SORT,
                      SUM(CASE
                            WHEN REGEXP_COUNT(D.FLW_ORDER_MANAGER, ',') > 0 THEN
                             A.AMOUNT /
                             NVL((REGEXP_COUNT(D.FLW_ORDER_MANAGER, ',') + 1),1) *
                             E.PRICE
                            ELSE
                             A.AMOUNT * E.PRICE
                          END) ORDER_MONEY
                 FROM /*SCMDATA.T_INGOOD A
                 INNER JOIN SCMDATA.T_INGOODS B
                    ON A.ING_ID = B.ING_ID
                   AND A.COMPANY_ID = B.COMPANY_ID*/
                   (SELECT T.DOCUMENT_NO,
                    T.COMPANY_ID,
                    TRUNC(T.CREATE_TIME) CREATE_TIME,
                    SUM(TL.AMOUNT) AMOUNT,
                    TL.GOO_ID
               FROM SCMDATA.T_INGOOD T
              INNER JOIN (SELECT TI.ING_ID,
                                TI.COMPANY_ID,
                                TI.GOO_ID,
                                TI.AMOUNT
                           FROM SCMDATA.T_INGOODS TI
                          WHERE TI.AMOUNT > 0) TL
                 ON TL.ING_ID = T.ING_ID
                AND TL.COMPANY_ID = T.COMPANY_ID
              WHERE TO_CHAR(T.CREATE_TIME, 'yyyy') >= 2022
              GROUP BY T.DOCUMENT_NO,
                       T.COMPANY_ID,
                       TRUNC(T.CREATE_TIME),
                       TL.GOO_ID) A
                 /*LEFT JOIN SCMDATA.T_ORDERED C
                    ON C.ORDER_CODE = A.DOCUMENT_NO
                   AND A.COMPANY_ID = C.COMPANY_ID*/
                LEFT JOIN (SELECT Z.*,
                                  REGEXP_SUBSTR(Z.FLW_ORDER_MANAGER,
                                                 '[^,]+',
                                                 1,
                                                 LEVEL) GENDANZG
                             FROM SCMDATA.PT_ORDERED Z
                           CONNECT BY PRIOR Z.PT_ORDERED_ID = Z.PT_ORDERED_ID
                                  AND LEVEL <=
                                      LENGTH(Z.FLW_ORDER_MANAGER) -
                                      LENGTH(REGEXP_REPLACE(Z.FLW_ORDER_MANAGER,
                                                            ',',
                                                            '')) + 1
                                  AND PRIOR DBMS_RANDOM.VALUE IS NOT NULL) D
                   ON A.DOCUMENT_NO = D.PRODUCT_GRESS_CODE
                  AND D.COMPANY_ID = A.COMPANY_ID
                  INNER JOIN SCMDATA.T_COMMODITY_INFO E ON E.GOO_ID=A.GOO_ID AND E.COMPANY_ID=A.COMPANY_ID
                --WHERE B.AMOUNT > 0
                GROUP BY A.COMPANY_ID, EXTRACT(YEAR FROM A.CREATE_TIME),
                         EXTRACT(MONTH FROM A.CREATE_TIME), E.CATEGORY,
                         D.GROUP_NAME, D.GENDANZG ) Y
    ]';

    --退货
    V_SQL2 := q'[MERGE INTO SCMDATA.T_RTKPI_MONTH A
USING (
  WITH TEMP_RT AS
   (SELECT Z.*,
           Z.RM_ID || ROW_NUMBER() OVER(PARTITION BY Z.RM_ID ORDER BY 1) RM_ID2,
           Z.EXAMOUNT / (COUNT(Z.RM_ID) OVER(PARTITION BY(Z.RM_ID))) EXGAMOUNT2,
           REGEXP_SUBSTR(Z.SUP_GROUP_NAME, '[^,]+', 1, LEVEL) SUP_GROUP_NAME2
      FROM SCMDATA.T_RETURN_MANAGEMENT Z
     WHERE Z.AUDIT_TIME IS NOT NULL
    CONNECT BY PRIOR RM_ID = RM_ID
           AND LEVEL <=
               LENGTH(Z.SUP_GROUP_NAME) -
               LENGTH(REGEXP_REPLACE(Z.SUP_GROUP_NAME, ',', '')) + 1
           AND PRIOR DBMS_RANDOM.VALUE IS NOT NULL)
  SELECT Y.COMPANY_ID, Y.YEAR, Y.MONTH,  Y.CATEGORY,
         Y.GROUP_NAME, Y.COUNT_DIMENSION, Y.DIMENSION_SORT,
         /*Z.ORDER_MONEY INGOOD_MONEY,*/ Y.RMMONEY SHOP_RT_ORIGINAL_MONEY,
         X.RMMONEY2 SHOP_RT_MONEY

    FROM (SELECT A.COMPANY_ID, A.YEAR, A.MONTH, B.CATEGORY,
                  (CASE WHEN A.SUP_GROUP_NAME2 IS NULL THEN  '1'  ELSE  A.SUP_GROUP_NAME2  END) GROUP_NAME,
                   '06' COUNT_DIMENSION,
                  (CASE WHEN A.GENDANZG2 IS NULL THEN '1' ELSE A.GENDANZG2 END) DIMENSION_SORT,
                  SUM(A.EXGAMOUNT3 * B.PRICE) RMMONEY
             FROM (SELECT Z.RM_ID, Z.COMPANY_ID, Z.YEAR, Z.MONTH, Z.ACCESS_TIME,
                           Z.GOO_ID, Z.EXAMOUNT, Z.SUP_GROUP_NAME, Z.AUDIT_TIME,Z.SUP_GROUP_NAME2,
                           Z.EXGAMOUNT2 /
                            NVL((REGEXP_COUNT(Z.MERCHER_DIRECTOR_ID, ',') + 1),1) EXGAMOUNT3,
                           REGEXP_SUBSTR(Z.MERCHER_DIRECTOR_ID,
                                          '[^,]+',
                                          1,
                                          LEVEL) GENDANZG2
                      FROM TEMP_RT Z

                    CONNECT BY PRIOR Z.RM_ID2 = Z.RM_ID2
                           AND LEVEL <= LENGTH(Z.MERCHER_DIRECTOR_ID) -
                               LENGTH(REGEXP_REPLACE(Z.MERCHER_DIRECTOR_ID, ',','')) + 1
                           AND PRIOR DBMS_RANDOM.VALUE IS NOT NULL) A
            INNER JOIN SCMDATA.T_COMMODITY_INFO B
               ON A.GOO_ID = B.GOO_ID
              AND A.COMPANY_ID = B.COMPANY_ID
            WHERE A.AUDIT_TIME IS NOT NULL
            GROUP BY A.COMPANY_ID, A.YEAR, A.MONTH, B.CATEGORY,
                     A.SUP_GROUP_NAME2, A.GENDANZG2) Y

    LEFT JOIN (SELECT A.COMPANY_ID, A.YEAR, A.MONTH,
                      B.CATEGORY,
                      (CASE WHEN A.SUP_GROUP_NAME2 IS NULL THEN '1'ELSE A.SUP_GROUP_NAME2 END) GROUP_NAME,
                       '06' COUNT_DIMENSION,
                      (CASE WHEN A.GENDANZG2 IS NULL THEN '1' ELSE A.GENDANZG2 END) DIMENSION_SORT,
                      SUM(A.EXGAMOUNT3 * B.PRICE) RMMONEY2
                 FROM (SELECT Z.RM_ID, Z.COMPANY_ID, Z.YEAR, Z.MONTH,
                               Z.ACCESS_TIME, Z.GOO_ID, Z.EXAMOUNT,
                               Z.SUP_GROUP_NAME, Z.AUDIT_TIME,
                               Z.CAUSE_DETAIL_ID, Z.FIRST_DEPT_ID,Z.SUP_GROUP_NAME2,
                               Z.SECOND_DEPT_ID,
                               Z.EXGAMOUNT2 /
                                NVL((REGEXP_COUNT(Z.MERCHER_DIRECTOR_ID, ',') + 1),1) EXGAMOUNT3,
                               REGEXP_SUBSTR(Z.MERCHER_DIRECTOR_ID, '[^,]+', 1, LEVEL) GENDANZG2
                          FROM TEMP_RT Z

                        CONNECT BY PRIOR Z.RM_ID2 = Z.RM_ID2
                               AND LEVEL <=
                                   LENGTH(Z.MERCHER_DIRECTOR_ID) -
                                   LENGTH(REGEXP_REPLACE(Z.MERCHER_DIRECTOR_ID, ',', '')) + 1
                               AND PRIOR DBMS_RANDOM.VALUE IS NOT NULL) A
                INNER JOIN SCMDATA.T_COMMODITY_INFO B
                   ON A.GOO_ID = B.GOO_ID
                  AND A.COMPANY_ID = B.COMPANY_ID
                 LEFT JOIN SCMDATA.T_ABNORMAL_DTL_CONFIG C
                   ON A.CAUSE_DETAIL_ID = C.ABNORMAL_DTL_CONFIG_ID
                  AND A.COMPANY_ID = C.COMPANY_ID
                  AND C.ANOMALY_CLASSIFICATION = 'AC_QUALITY'
                INNER JOIN SCMDATA.SYS_COMPANY_DEPT D
                   ON D.COMPANY_DEPT_ID = A.FIRST_DEPT_ID
                WHERE A.AUDIT_TIME IS NOT NULL
                  AND C.CAUSE_CLASSIFICATION <> '银饰氧化问题'
                  AND C.PROBLEM_CLASSIFICATION <> '非质量问题'
                  AND D.DEPT_NAME = '供应链管理部'
                  AND INSTR(A.SECOND_DEPT_ID,
                            'b550778b4f2d36b4e0533c281caca074') > 0
                GROUP BY A.COMPANY_ID, A.YEAR, A.MONTH, B.CATEGORY,
                         A.SUP_GROUP_NAME2, A.GENDANZG2) X
      ON X.COMPANY_ID = Y.COMPANY_ID
     AND X.YEAR = Y.YEAR
     AND X.MONTH = Y.MONTH
     AND X.CATEGORY = Y.CATEGORY
     AND X.GROUP_NAME = Y.GROUP_NAME
     AND X.COUNT_DIMENSION = Y.COUNT_DIMENSION
     AND X.DIMENSION_SORT = Y.DIMENSION_SORT
    /*LEFT JOIN (SELECT A.COMPANY_ID, EXTRACT(YEAR FROM A.CREATE_TIME) YEAR,
                      EXTRACT(MONTH FROM A.CREATE_TIME) MONTH,
                      D.CATEGORY,
                      (CASE WHEN D.GROUP_NAME IS NULL THEN '1' ELSE D.GROUP_NAME END) GROUP_NAME,
                       '06' COUNT_DIMENSION,
                      (CASE WHEN D.GENDANZG IS NULL THEN '1' ELSE D.GENDANZG END) DIMENSION_SORT,
                      SUM(CASE
                            WHEN REGEXP_COUNT(D.FLW_ORDER_MANAGER, ',') > 0 THEN
                             B.AMOUNT /
                             NVL((REGEXP_COUNT(D.FLW_ORDER_MANAGER, ',') + 1),1) *
                             E.PRICE
                            ELSE
                             B.AMOUNT * E.PRICE
                          END) ORDER_MONEY
                 FROM SCMDATA.T_INGOOD A
                INNER JOIN SCMDATA.T_INGOODS B
                   ON A.ING_ID = B.ING_ID
                  AND A.COMPANY_ID = B.COMPANY_ID
                INNER JOIN SCMDATA.T_ORDERED C
                   ON C.ORDER_CODE = A.DOCUMENT_NO
                  AND A.COMPANY_ID = C.COMPANY_ID
                INNER JOIN (SELECT Z.*,
                                  REGEXP_SUBSTR(Z.FLW_ORDER_MANAGER,
                                                 '[^,]+',
                                                 1,
                                                 LEVEL) GENDANZG
                             FROM SCMDATA.PT_ORDERED Z
                           CONNECT BY PRIOR Z.PT_ORDERED_ID = Z.PT_ORDERED_ID
                                  AND LEVEL <=
                                      LENGTH(Z.FLW_ORDER_MANAGER) -
                                      LENGTH(REGEXP_REPLACE(Z.FLW_ORDER_MANAGER,
                                                            ',',
                                                            '')) + 1
                                  AND PRIOR DBMS_RANDOM.VALUE IS NOT NULL) D
                   ON D.ORDER_ID = C.ORDER_ID
                  AND D.COMPANY_ID = C.COMPANY_ID
                  INNER JOIN SCMDATA.T_COMMODITY_INFO E ON E.GOO_ID=B.GOO_ID AND E.COMPANY_ID=B.COMPANY_ID
                WHERE B.AMOUNT > 0
                GROUP BY A.COMPANY_ID, EXTRACT(YEAR FROM A.CREATE_TIME),
                         EXTRACT(MONTH FROM A.CREATE_TIME), D.CATEGORY,
                         D.GROUP_NAME, D.GENDANZG) Z
      ON Z.COMPANY_ID = Y.COMPANY_ID
     AND Z.YEAR = Y.YEAR
     AND Z.MONTH = Y.MONTH
     AND Z.CATEGORY = Y.CATEGORY
     AND Z.GROUP_NAME = Y.GROUP_NAME
     AND Z.COUNT_DIMENSION = Y.COUNT_DIMENSION
     AND Z.DIMENSION_SORT = Y.DIMENSION_SORT */ ]';
    IF P_TYPE = 0 THEN
      --进货
      V_EXSQL1 := V_SQL1||V_WH_SQL2||V_U_SQL1||V_I_SQL1;
      --退货
      V_EXSQL2 := V_SQL2 || V_WH_SQL2 || V_U_SQL2 || V_I_SQL2;


    ELSIF P_TYPE = 1 THEN
      --进货
      V_EXSQL1 := V_SQL1||V_WM_SQL1||V_U_SQL1||V_I_SQL1;
      --退货
      V_EXSQL2 := V_SQL2 || V_WM_SQL1 || V_U_SQL2 || V_I_SQL2;
    END IF;
   EXECUTE IMMEDIATE V_EXSQL2;
   EXECUTE IMMEDIATE V_EXSQL1;
    --dbms_output.put_line(V_EXSQL1);
    --dbms_output.put_line(V_EXSQL2);

    --07qc
    --进货
    V_SQL1:=q'[ MERGE INTO SCMDATA.T_RTKPI_MONTH A
USING ( /*WITH TEMP_PTORDER AS
 (SELECT T1.PT_ORDERED_ID, T1.GOO_ID_PR,
         T1.PT_ORDERED_ID || ROW_NUMBER() OVER(PARTITION BY T1.PT_ORDERED_ID ORDER BY 1) ID2,
         T1.COMPANY_ID, T1.PRODUCT_GRESS_CODE, T1.ORDER_MONEY,
         (T1.ORDER_MONEY / COUNT(T1.PRODUCT_GRESS_CODE)
           OVER(PARTITION BY T1.PRODUCT_GRESS_CODE)) SUM1,
         REGEXP_SUBSTR(T1.QC, '[^,]+', 1, LEVEL) QC2
    FROM SCMDATA.PT_ORDERED T1
   WHERE T1.QC IS NOT NULL
  CONNECT BY PRIOR T1.PT_ORDERED_ID = T1.PT_ORDERED_ID
         AND LEVEL <=
             LENGTH(T1.QC) - LENGTH(REGEXP_REPLACE(T1.QC, ',', '')) + 1
         AND PRIOR DBMS_RANDOM.VALUE IS NOT NULL)*/

   SELECT  Y.COMPANY_ID,Y.YEAR,Y.MONTH,Y.CATEGORY,Y.GROUP_NAME,Y.COUNT_DIMENSION,Y.DIMENSION_SORT,Y.ORDER_MONEY INGOOD_MONEY
                 FROM   (SELECT A.COMPANY_ID, EXTRACT(YEAR FROM A.CREATE_TIME) YEAR,
                    EXTRACT(MONTH FROM A.CREATE_TIME) MONTH,
                    E.CATEGORY,
                    (CASE  WHEN D.GROUP_NAME IS NULL THEN '1'  ELSE  D.GROUP_NAME  END) GROUP_NAME,
                     '07' COUNT_DIMENSION,
                    (CASE WHEN D.QC2 IS NULL THEN '1' ELSE  D.QC2  END) DIMENSION_SORT,
                    SUM(CASE
                          WHEN REGEXP_COUNT(D.QC, ',') > 0 THEN
                           A.AMOUNT / NVL((REGEXP_COUNT(D.QC, ',') + 1),1) *
                           E.PRICE
                          ELSE
                           A.AMOUNT * E.PRICE
                        END) ORDER_MONEY
               FROM /*SCMDATA.T_INGOOD A
                 INNER JOIN SCMDATA.T_INGOODS B
                    ON A.ING_ID = B.ING_ID
                   AND A.COMPANY_ID = B.COMPANY_ID*/
                   (SELECT T.DOCUMENT_NO,
                    T.COMPANY_ID,
                    TRUNC(T.CREATE_TIME) CREATE_TIME,
                    SUM(TL.AMOUNT) AMOUNT,
                    TL.GOO_ID
               FROM SCMDATA.T_INGOOD T
              INNER JOIN (SELECT TI.ING_ID,
                                TI.COMPANY_ID,
                                TI.GOO_ID,
                                TI.AMOUNT
                           FROM SCMDATA.T_INGOODS TI
                          WHERE TI.AMOUNT > 0) TL
                 ON TL.ING_ID = T.ING_ID
                AND TL.COMPANY_ID = T.COMPANY_ID
              WHERE TO_CHAR(T.CREATE_TIME, 'yyyy') >= 2022
              GROUP BY T.DOCUMENT_NO,
                       T.COMPANY_ID,
                       TRUNC(T.CREATE_TIME),
                       TL.GOO_ID) A
                 /*LEFT JOIN SCMDATA.T_ORDERED C
                    ON C.ORDER_CODE = A.DOCUMENT_NO
                   AND A.COMPANY_ID = C.COMPANY_ID*/
              LEFT JOIN (SELECT Z.*,
                                REGEXP_SUBSTR(Z.QC, '[^,]+', 1, LEVEL) QC2
                           FROM SCMDATA.PT_ORDERED Z
                         CONNECT BY PRIOR Z.PT_ORDERED_ID = Z.PT_ORDERED_ID
                                AND LEVEL <=
                                    LENGTH(Z.QC) -
                                    LENGTH(REGEXP_REPLACE(Z.QC, ',', '')) + 1
                                AND PRIOR DBMS_RANDOM.VALUE IS NOT NULL) D
                 ON D.PRODUCT_GRESS_CODE = A.DOCUMENT_NO
                AND D.COMPANY_ID = A.COMPANY_ID
                INNER JOIN SCMDATA.T_COMMODITY_INFO E ON E.GOO_ID=A.GOO_ID AND E.COMPANY_ID=A.COMPANY_ID
              --WHERE B.AMOUNT > 0
              GROUP BY A.COMPANY_ID, EXTRACT(YEAR FROM A.CREATE_TIME),
                       EXTRACT(MONTH FROM A.CREATE_TIME), E.CATEGORY,
                       D.GROUP_NAME, D.QC2) Y      ]';

    --退货
    V_SQL2 := q'[  MERGE INTO SCMDATA.T_RTKPI_MONTH A
USING (
  WITH TEMP_RT AS
 (SELECT Z.RM_ID, Z.COMPANY_ID, Z.YEAR, Z.QUARTER, Z.MONTH, Z.ACCESS_TIME,Z.SUPPLIER_CODE,
         Z.GOO_ID, Z.EXAMOUNT, Z.QC_ID,
         Z.RM_ID || ROW_NUMBER() OVER(PARTITION BY Z.RM_ID ORDER BY 1) RM_ID2,
         Z.EXAMOUNT / (COUNT(Z.RM_ID) OVER(PARTITION BY(Z.RM_ID))) EXGAMOUNT2,
         REGEXP_SUBSTR(Z.SUP_GROUP_NAME, '[^,]+', 1, LEVEL) SUP_GROUP_NAME2
    FROM SCMDATA.T_RETURN_MANAGEMENT Z
   WHERE Z.AUDIT_TIME IS NOT NULL
  CONNECT BY PRIOR RM_ID = RM_ID
         AND LEVEL <= LENGTH(Z.SUP_GROUP_NAME) -
             LENGTH(REGEXP_REPLACE(Z.SUP_GROUP_NAME, ',', '')) + 1
         AND PRIOR DBMS_RANDOM.VALUE IS NOT NULL),
TEMP_RT2 AS
 (SELECT Z.RM_ID, Z.COMPANY_ID, Z.YEAR, Z.QUARTER, Z.MONTH, Z.ACCESS_TIME,Z.SUPPLIER_CODE,
         Z.GOO_ID, Z.EXAMOUNT, Z.QC_ID,
         Z.RM_ID || ROW_NUMBER() OVER(PARTITION BY Z.RM_ID ORDER BY 1) RM_ID2,
         Z.EXAMOUNT / (COUNT(Z.RM_ID) OVER(PARTITION BY(Z.RM_ID))) EXGAMOUNT2,
         REGEXP_SUBSTR(Z.SUP_GROUP_NAME, '[^,]+', 1, LEVEL) SUP_GROUP_NAME2
    FROM SCMDATA.T_RETURN_MANAGEMENT Z
    LEFT JOIN SCMDATA.T_ABNORMAL_DTL_CONFIG C
      ON Z.CAUSE_DETAIL_ID = C.ABNORMAL_DTL_CONFIG_ID
     AND Z.COMPANY_ID = C.COMPANY_ID
     AND C.ANOMALY_CLASSIFICATION = 'AC_QUALITY'
   INNER JOIN SCMDATA.SYS_COMPANY_DEPT D
      ON D.COMPANY_DEPT_ID = Z.FIRST_DEPT_ID
   WHERE Z.AUDIT_TIME IS NOT NULL
     AND C.CAUSE_CLASSIFICATION <> '银饰氧化问题'
     AND C.PROBLEM_CLASSIFICATION <> '非质量问题'
     AND D.DEPT_NAME = '供应链管理部'
     AND INSTR(Z.SECOND_DEPT_ID, 'b550778b4f2d36b4e0533c281caca074') > 0
  CONNECT BY PRIOR RM_ID = RM_ID
         AND LEVEL <= LENGTH(Z.SUP_GROUP_NAME) -
             LENGTH(REGEXP_REPLACE(Z.SUP_GROUP_NAME, ',', '')) + 1
         AND PRIOR DBMS_RANDOM.VALUE IS NOT NULL) ,
TEMP_PTORDER AS
 (SELECT T1.PT_ORDERED_ID, T1.GOO_ID_PR,T1.ORDER_ID,T1.DELIVERY_AMOUNT,
         T1.PT_ORDERED_ID || ROW_NUMBER() OVER(PARTITION BY T1.PT_ORDERED_ID ORDER BY 1) ID2,
         T1.COMPANY_ID, T1.PRODUCT_GRESS_CODE, T1.ORDER_MONEY,
         (T1.ORDER_MONEY / COUNT(T1.PRODUCT_GRESS_CODE)
           OVER(PARTITION BY T1.PRODUCT_GRESS_CODE)) SUM1,
         REGEXP_SUBSTR(T1.QC, '[^,]+', 1, LEVEL) QC2
    FROM SCMDATA.PT_ORDERED T1
   WHERE T1.QC IS NOT NULL
  CONNECT BY PRIOR T1.PT_ORDERED_ID = T1.PT_ORDERED_ID
         AND LEVEL <=
             LENGTH(T1.QC) - LENGTH(REGEXP_REPLACE(T1.QC, ',', '')) + 1
         AND PRIOR DBMS_RANDOM.VALUE IS NOT NULL)
SELECT Y.COMPANY_ID, Y.YEAR, Y.MONTH, Y.CATEGORY, Y.GROUP_NAME,
       '07' COUNT_DIMENSION, Y.DIMENSION_SORT DIMENSION_SORT, Y.RMMONEY SHOP_RT_ORIGINAL_MONEY,
       X.SHOP_RT_MONEY SHOP_RT_MONEY/*, Z.ORDER_MONEY INGOOD_MONEY*/
  FROM (SELECT A.COMPANY_ID, A.YEAR, A.MONTH, B.CATEGORY,
                (CASE
                  WHEN A.SUP_GROUP_NAME2 IS NULL THEN
                   '1'
                  ELSE
                   A.SUP_GROUP_NAME2
                END) GROUP_NAME, '07' COUNT_DIMENSION, (CASE WHEN A.QC2 IS NULL THEN '1' ELSE A.QC2 END) DIMENSION_SORT,
                SUM(A.EXGAMOUNT3 * B.PRICE) RMMONEY
           FROM (SELECT Z.COMPANY_ID, Z.YEAR, Z.MONTH, Z.ACCESS_TIME, Z.GOO_ID,
                         Z.SUP_GROUP_NAME2,
                         Z.EXGAMOUNT2 / NVL((REGEXP_COUNT(Z.QC_ID, ',') + 1),1) EXGAMOUNT3,
                         REGEXP_SUBSTR(Z.QC_ID, '[^,]+', 1, LEVEL) QC2
                    FROM TEMP_RT Z
                   WHERE (EXISTS
                          (SELECT MAX(1)
                             FROM SCMDATA.T_PLAT_LOG X
                             INNER JOIN SCMDATA.T_PLAT_LOGS Y ON X.LOG_ID = Y.LOG_ID AND X.COMPANY_ID = Y.COMPANY_ID
                            WHERE X.APPLY_PK_ID = Z.RM_ID
                              AND Y.operate_field ='QC_ID'
                              AND X.ACTION_TYPE = 'UPDATE') OR
                          (NOT EXISTS
                           (SELECT MAX(1)
                              FROM SCMDATA.T_PLAT_LOG Y
                              INNER JOIN SCMDATA.T_PLAT_LOGS X ON X.LOG_ID = Y.LOG_ID AND X.COMPANY_ID = Y.COMPANY_ID
                             WHERE Y.APPLY_PK_ID = Z.RM_ID
                               AND X.operate_field ='QC_ID'
                               AND Y.ACTION_TYPE = 'UPDATE') AND NOT EXISTS
                           (SELECT MAX(1)
                              FROM TEMP_PTORDER J
                               INNER JOIN SCMDATA.T_ORDERED P ON P.ORDER_ID = J.ORDER_ID AND P.COMPANY_ID = J.COMPANY_ID
                             WHERE J.GOO_ID_PR = Z.GOO_ID AND P.SUPPLIER_CODE=Z.SUPPLIER_CODE AND J.DELIVERY_AMOUNT >0 AND J.QC2 IS NOT NULL
                               AND J.COMPANY_ID = Z.COMPANY_ID)))
                  CONNECT BY PRIOR Z.RM_ID2 = Z.RM_ID2
                         AND LEVEL <=
                             LENGTH(Z.QC_ID) -
                             LENGTH(REGEXP_REPLACE(Z.QC_ID, ',', '')) + 1
                         AND PRIOR DBMS_RANDOM.VALUE IS NOT NULL
                  UNION ALL
                  SELECT H.COMPANY_ID, H.YEAR, H.MONTH, H.ACCESS_TIME, H.GOO_ID,
                         H.SUP_GROUP_NAME2,
                         (H.EXGAMOUNT2 *((SELECT SUM(J.SUM1)
                               FROM TEMP_PTORDER J
                               INNER JOIN SCMDATA.T_ORDERED P ON P.ORDER_ID = J.ORDER_ID AND P.COMPANY_ID = J.COMPANY_ID
                              WHERE J.GOO_ID_PR = H.GOO_ID
                                AND P.SUPPLIER_CODE = H.SUPPLIER_CODE
                                AND J.COMPANY_ID = H.COMPANY_ID
                                AND J.QC2 = H.QC2
                                AND J.DELIVERY_AMOUNT >0) /
                          (SELECT SUM(L.ORDER_MONEY)
                               FROM TEMP_PTORDER L
                               INNER JOIN SCMDATA.T_ORDERED P ON P.ORDER_ID = L.ORDER_ID AND P.COMPANY_ID = L.COMPANY_ID
                              WHERE L.GOO_ID_PR = H.GOO_ID
                                AND H.COMPANY_ID = L.COMPANY_ID
                                AND L.QC2 IS NOT NULL
                                AND L.DELIVERY_AMOUNT >0))) EXGAMOUNT3, H.QC2
                    FROM (SELECT Z.*,
                                  REGEXP_SUBSTR(Z.QC_ID, '[^,]+', 1, LEVEL) QC2
                             FROM TEMP_RT Z
                            WHERE NOT EXISTS
                            (SELECT MAX(1)
                                     FROM SCMDATA.T_PLAT_LOG Y
                                     INNER JOIN SCMDATA.T_PLAT_LOGS X ON X.LOG_ID = Y.LOG_ID AND X.COMPANY_ID = Y.COMPANY_ID
                                    WHERE Y.APPLY_PK_ID = Z.RM_ID
                                     AND X.operate_field ='QC_ID'
                                      AND Y.ACTION_TYPE = 'UPDATE')
                              AND EXISTS
                            (SELECT MAX(1)
                                     FROM TEMP_PTORDER L
                                     INNER JOIN SCMDATA.T_ORDERED P ON P.ORDER_ID = L.ORDER_ID AND P.COMPANY_ID = L.COMPANY_ID
                                    WHERE L.GOO_ID_PR = Z.GOO_ID
                                      AND L.COMPANY_ID = Z.COMPANY_ID
                                      AND L.DELIVERY_AMOUNT >0
                                      AND L.QC2 IS NOT NULL)
                           CONNECT BY PRIOR Z.RM_ID2 = Z.RM_ID2
                                  AND LEVEL <=
                                      LENGTH(Z.QC_ID) -
                                      LENGTH(REGEXP_REPLACE(Z.QC_ID, ',', '')) + 1
                                  AND PRIOR DBMS_RANDOM.VALUE IS NOT NULL) H) A
          INNER JOIN SCMDATA.T_COMMODITY_INFO B
             ON A.GOO_ID = B.GOO_ID
            AND A.COMPANY_ID = B.COMPANY_ID
          GROUP BY A.COMPANY_ID, A.YEAR, A.MONTH, B.CATEGORY,
                   A.SUP_GROUP_NAME2, A.QC2) Y

  LEFT JOIN (SELECT A.COMPANY_ID, A.YEAR, A.MONTH,
                    B.CATEGORY,
                    (CASE  WHEN A.SUP_GROUP_NAME2 IS NULL THEN '1'  ELSE A.SUP_GROUP_NAME2  END) GROUP_NAME,
                    '07' COUNT_DIMENSION,
                    (CASE WHEN A.QC2 IS NULL THEN '1' ELSE A.QC2 END) DIMENSION_SORT,
                    SUM(A.EXGAMOUNT3 * B.PRICE) SHOP_RT_MONEY
               FROM (SELECT Z.COMPANY_ID, Z.YEAR, Z.MONTH, Z.ACCESS_TIME,
                             Z.GOO_ID, Z.SUP_GROUP_NAME2,
                             Z.EXGAMOUNT2 / NVL((REGEXP_COUNT(Z.QC_ID, ',') + 1),1) EXGAMOUNT3,
                             REGEXP_SUBSTR(Z.QC_ID, '[^,]+', 1, LEVEL) QC2
                        FROM TEMP_RT2 Z
                       WHERE (EXISTS
                              (SELECT MAX(1)
                                 FROM SCMDATA.T_PLAT_LOG X
                                 INNER JOIN SCMDATA.T_PLAT_LOGS Y ON X.LOG_ID = Y.LOG_ID AND X.COMPANY_ID = Y.COMPANY_ID
                                WHERE X.APPLY_PK_ID = Z.RM_ID
                                  AND Y.operate_field ='QC_ID'
                                  AND X.ACTION_TYPE = 'UPDATE') OR
                              (NOT EXISTS
                               (SELECT MAX(1)
                                  FROM SCMDATA.T_PLAT_LOG Y
                                  INNER JOIN SCMDATA.T_PLAT_LOGS X ON X.LOG_ID = Y.LOG_ID AND X.COMPANY_ID = Y.COMPANY_ID
                                 WHERE Y.APPLY_PK_ID = Z.RM_ID
                                   AND X.operate_field ='QC_ID'
                                   AND Y.ACTION_TYPE = 'UPDATE') AND NOT EXISTS
                               (SELECT MAX(1)
                                  FROM TEMP_PTORDER J
                               INNER JOIN SCMDATA.T_ORDERED P ON P.ORDER_ID = J.ORDER_ID AND P.COMPANY_ID = J.COMPANY_ID
                             WHERE J.GOO_ID_PR = Z.GOO_ID AND P.SUPPLIER_CODE=Z.SUPPLIER_CODE AND J.DELIVERY_AMOUNT >0 AND J.QC2 IS NOT NULL
                               AND J.COMPANY_ID = Z.COMPANY_ID)))
                      CONNECT BY PRIOR Z.RM_ID2 = Z.RM_ID2
                             AND LEVEL <=
                                 LENGTH(Z.QC_ID) -
                                 LENGTH(REGEXP_REPLACE(Z.QC_ID, ',', '')) + 1
                             AND PRIOR DBMS_RANDOM.VALUE IS NOT NULL
                      UNION ALL
                      SELECT H.COMPANY_ID, H.YEAR, H.MONTH, H.ACCESS_TIME,
                             H.GOO_ID, H.SUP_GROUP_NAME2,
                             (H.EXGAMOUNT2 * ((SELECT SUM(J.SUM1)
                               FROM TEMP_PTORDER J
                               INNER JOIN SCMDATA.T_ORDERED P ON P.ORDER_ID = J.ORDER_ID AND P.COMPANY_ID = J.COMPANY_ID
                             WHERE J.GOO_ID_PR = H.GOO_ID AND P.SUPPLIER_CODE=H.SUPPLIER_CODE AND J.DELIVERY_AMOUNT >0 AND J.QC2 IS NOT NULL
                               AND J.COMPANY_ID = H.COMPANY_ID
                                    AND J.QC2 = H.QC2) /
                              (SELECT SUM(J.ORDER_MONEY)
                                   FROM TEMP_PTORDER J
                               INNER JOIN SCMDATA.T_ORDERED P ON P.ORDER_ID = J.ORDER_ID AND P.COMPANY_ID = J.COMPANY_ID
                             WHERE J.GOO_ID_PR = H.GOO_ID AND P.SUPPLIER_CODE=H.SUPPLIER_CODE AND J.DELIVERY_AMOUNT >0 AND J.QC2 IS NOT NULL
                               AND J.COMPANY_ID = H.COMPANY_ID))) EXGAMOUNT3, H.QC2
                        FROM (SELECT Z.*,
                                      REGEXP_SUBSTR(Z.QC_ID, '[^,]+', 1, LEVEL) QC2
                                 FROM TEMP_RT2 Z
                                WHERE NOT EXISTS
                                (SELECT MAX(1)
                                         FROM SCMDATA.T_PLAT_LOG Y
                                         INNER JOIN SCMDATA.T_PLAT_LOGS X ON X.LOG_ID = Y.LOG_ID AND X.COMPANY_ID = Y.COMPANY_ID
                                        WHERE Y.APPLY_PK_ID = Z.RM_ID
                                          AND X.operate_field ='QC_ID'
                                          AND Y.ACTION_TYPE = 'UPDATE')
                                  AND EXISTS
                                (SELECT MAX(1)
                                  FROM TEMP_PTORDER J
                               INNER JOIN SCMDATA.T_ORDERED P ON P.ORDER_ID = J.ORDER_ID AND P.COMPANY_ID = J.COMPANY_ID
                             WHERE J.GOO_ID_PR = Z.GOO_ID AND P.SUPPLIER_CODE=Z.SUPPLIER_CODE AND J.DELIVERY_AMOUNT >0 AND J.QC2 IS NOT NULL
                               AND J.COMPANY_ID = Z.COMPANY_ID)
                               CONNECT BY PRIOR Z.RM_ID2 = Z.RM_ID2
                                      AND LEVEL <=
                                          LENGTH(Z.QC_ID) -
                                          LENGTH(REGEXP_REPLACE(Z.QC_ID, ',', '')) + 1
                                      AND PRIOR DBMS_RANDOM.VALUE IS NOT NULL) H) A
              INNER JOIN SCMDATA.T_COMMODITY_INFO B
                 ON A.GOO_ID = B.GOO_ID
                AND A.COMPANY_ID = B.COMPANY_ID
              GROUP BY A.COMPANY_ID, A.YEAR, A.MONTH, B.CATEGORY,
                       A.SUP_GROUP_NAME2, A.QC2) X
    ON X.COMPANY_ID = Y.COMPANY_ID
   AND X.YEAR = Y.YEAR
   AND X.MONTH = Y.MONTH
   AND X.CATEGORY = Y.CATEGORY
   AND X.GROUP_NAME = Y.GROUP_NAME
   AND X.COUNT_DIMENSION = Y.COUNT_DIMENSION
   AND X.DIMENSION_SORT = Y.DIMENSION_SORT
 /* LEFT JOIN (SELECT A.COMPANY_ID, EXTRACT(YEAR FROM A.CREATE_TIME) YEAR,
                    EXTRACT(MONTH FROM A.CREATE_TIME) MONTH,
                    D.CATEGORY,
                    (CASE  WHEN D.GROUP_NAME IS NULL THEN '1'  ELSE  D.GROUP_NAME  END) GROUP_NAME,
                     '07' COUNT_DIMENSION,
                    (CASE WHEN D.QC2 IS NULL THEN '1' ELSE  D.QC2  END) DIMENSION_SORT,
                    SUM(CASE
                          WHEN REGEXP_COUNT(D.QC, ',') > 0 THEN
                           B.AMOUNT / NVL((REGEXP_COUNT(D.QC, ',') + 1),1) *
                           E.PRICE
                          ELSE
                           B.AMOUNT * E.PRICE
                        END) ORDER_MONEY
               FROM SCMDATA.T_INGOOD A
              INNER JOIN SCMDATA.T_INGOODS B
                 ON A.ING_ID = B.ING_ID
                AND A.COMPANY_ID = B.COMPANY_ID
              INNER JOIN SCMDATA.T_ORDERED C
                 ON C.ORDER_CODE = A.DOCUMENT_NO
                AND A.COMPANY_ID = C.COMPANY_ID
              INNER JOIN (SELECT Z.*,
                                REGEXP_SUBSTR(Z.QC, '[^,]+', 1, LEVEL) QC2
                           FROM SCMDATA.PT_ORDERED Z
                         CONNECT BY PRIOR Z.PT_ORDERED_ID = Z.PT_ORDERED_ID
                                AND LEVEL <=
                                    LENGTH(Z.QC) -
                                    LENGTH(REGEXP_REPLACE(Z.QC, ',', '')) + 1
                                AND PRIOR DBMS_RANDOM.VALUE IS NOT NULL) D
                 ON D.ORDER_ID = C.ORDER_ID
                AND D.COMPANY_ID = C.COMPANY_ID
                INNER JOIN SCMDATA.T_COMMODITY_INFO E ON E.GOO_ID=B.GOO_ID AND E.COMPANY_ID=B.COMPANY_ID
              WHERE B.AMOUNT > 0
              GROUP BY A.COMPANY_ID, EXTRACT(YEAR FROM A.CREATE_TIME),
                       EXTRACT(MONTH FROM A.CREATE_TIME), D.CATEGORY,
                       D.GROUP_NAME, D.QC2) Z
    ON Z.COMPANY_ID = Y.COMPANY_ID
   AND Z.YEAR = Y.YEAR
   AND Z.MONTH = Y.MONTH
   AND Z.CATEGORY = Y.CATEGORY
   AND Z.GROUP_NAME = Y.GROUP_NAME
   AND Z.COUNT_DIMENSION = Y.COUNT_DIMENSION
   AND Z.DIMENSION_SORT = Y.DIMENSION_SORT */
 ]';
    IF P_TYPE = 0 THEN
      --进货
      V_EXSQL1 := V_SQL1||V_WH_SQL2||V_U_SQL1||V_I_SQL1;
      --退货
      V_EXSQL2 := V_SQL2 || V_WH_SQL2 || V_U_SQL2 || V_I_SQL2;


    ELSIF P_TYPE = 1 THEN
      --进货
      V_EXSQL1 := V_SQL1||V_WM_SQL1||V_U_SQL1||V_I_SQL1;
      --退货
      V_EXSQL2 := V_SQL2 || V_WM_SQL1 || V_U_SQL2 || V_I_SQL2;
    END IF;
    EXECUTE IMMEDIATE V_EXSQL2;
    EXECUTE IMMEDIATE V_EXSQL1;
    --dbms_output.put_line(V_EXSQL1);
    --dbms_output.put_line(V_EXSQL2);

    --qc主管
    --进货
    V_SQL1:=q'[ MERGE INTO SCMDATA.T_RTKPI_MONTH A
USING (
   /*WITH TEMP_PTORDER AS
 (SELECT T1.PT_ORDERED_ID, T1.GOO_ID_PR,
         T1.PT_ORDERED_ID || ROW_NUMBER() OVER(PARTITION BY T1.PT_ORDERED_ID ORDER BY 1) ID2,
         T1.COMPANY_ID, T1.PRODUCT_GRESS_CODE, T1.ORDER_MONEY,
         (T1.ORDER_MONEY / COUNT(T1.PRODUCT_GRESS_CODE)
           OVER(PARTITION BY T1.PRODUCT_GRESS_CODE)) SUM1,
         REGEXP_SUBSTR(T1.QC_MANAGER, '[^,]+', 1, LEVEL) QCZG2
    FROM SCMDATA.PT_ORDERED T1
   WHERE T1.QC_MANAGER IS NOT NULL
  CONNECT BY PRIOR T1.PT_ORDERED_ID = T1.PT_ORDERED_ID
         AND LEVEL <=
             LENGTH(T1.QC_MANAGER) - LENGTH(REGEXP_REPLACE(T1.QC_MANAGER, ',', '')) + 1
         AND PRIOR DBMS_RANDOM.VALUE IS NOT NULL)*/
 SELECT  Y.COMPANY_ID,Y.YEAR,Y.MONTH,Y.CATEGORY,Y.GROUP_NAME,Y.COUNT_DIMENSION,Y.DIMENSION_SORT,Y.ORDER_MONEY INGOOD_MONEY
                 FROM   ( SELECT A.COMPANY_ID,
       EXTRACT(YEAR FROM A.CREATE_TIME) YEAR,
       EXTRACT(MONTH FROM A.CREATE_TIME) MONTH,
       E.CATEGORY,
       (CASE WHEN D.GROUP_NAME IS NULL THEN  '1'  ELSE D.GROUP_NAME END) GROUP_NAME,
       '08' COUNT_DIMENSION,
       (case when D.QCZG2 is null then '1' else D.QCZG2 end) DIMENSION_SORT,
       SUM(CASE WHEN REGEXP_COUNT(D.QC_MANAGER, ',') > 0 THEN
       A.AMOUNT/NVL((REGEXP_COUNT(D.QC_MANAGER, ',') + 1),1) * E.PRICE ELSE
           A.AMOUNT * E.PRICE END ) ORDER_MONEY
  FROM /*SCMDATA.T_INGOOD A
                 INNER JOIN SCMDATA.T_INGOODS B
                    ON A.ING_ID = B.ING_ID
                   AND A.COMPANY_ID = B.COMPANY_ID*/
                   (SELECT T.DOCUMENT_NO,
                    T.COMPANY_ID,
                    TRUNC(T.CREATE_TIME) CREATE_TIME,
                    SUM(TL.AMOUNT) AMOUNT,
                    TL.GOO_ID
               FROM SCMDATA.T_INGOOD T
              INNER JOIN (SELECT TI.ING_ID,
                                TI.COMPANY_ID,
                                TI.GOO_ID,
                                TI.AMOUNT
                           FROM SCMDATA.T_INGOODS TI
                          WHERE TI.AMOUNT > 0) TL
                 ON TL.ING_ID = T.ING_ID
                AND TL.COMPANY_ID = T.COMPANY_ID
              WHERE TO_CHAR(T.CREATE_TIME, 'yyyy') >= 2022
              GROUP BY T.DOCUMENT_NO,
                       T.COMPANY_ID,
                       TRUNC(T.CREATE_TIME),
                       TL.GOO_ID) A
                 /*LEFT JOIN SCMDATA.T_ORDERED C
                    ON C.ORDER_CODE = A.DOCUMENT_NO
                   AND A.COMPANY_ID = C.COMPANY_ID*/
 LEFT JOIN (SELECT Z.*, REGEXP_SUBSTR(Z.QC_MANAGER, '[^,]+', 1, LEVEL) QCZG2
  FROM SCMDATA.PT_ORDERED Z
CONNECT BY PRIOR Z.PT_ORDERED_ID = Z.PT_ORDERED_ID
       AND LEVEL <= LENGTH(Z.QC_MANAGER) -
           LENGTH(REGEXP_REPLACE(Z.QC_MANAGER, ',', '')) + 1
       AND PRIOR DBMS_RANDOM.VALUE IS NOT NULL
) D
    ON D.PRODUCT_GRESS_CODE = A.DOCUMENT_NO
   AND D.COMPANY_ID = A.COMPANY_ID
  INNER JOIN SCMDATA.T_COMMODITY_INFO E ON E.GOO_ID=A.GOO_ID AND E.COMPANY_ID=A.COMPANY_ID
 --WHERE B.AMOUNT > 0
 GROUP BY A.COMPANY_ID,
          EXTRACT(YEAR FROM A.CREATE_TIME),
          EXTRACT(MONTH FROM A.CREATE_TIME),
          E.CATEGORY,
          D.GROUP_NAME,
          D.QCZG2) Y
     ]';


    --退货
    V_SQL2 := q'[  MERGE INTO SCMDATA.T_RTKPI_MONTH A
USING (
   WITH TEMP_RT AS
 (SELECT Z.RM_ID, Z.COMPANY_ID, Z.YEAR, Z.QUARTER, Z.MONTH, Z.ACCESS_TIME,Z.SUPPLIER_CODE,
         Z.GOO_ID, Z.EXAMOUNT, Z.QC_DIRECTOR_ID,
         Z.RM_ID || ROW_NUMBER() OVER(PARTITION BY Z.RM_ID ORDER BY 1) RM_ID2,
         Z.EXAMOUNT / (COUNT(Z.RM_ID) OVER(PARTITION BY(Z.RM_ID))) EXGAMOUNT2,
         REGEXP_SUBSTR(Z.SUP_GROUP_NAME, '[^,]+', 1, LEVEL) SUP_GROUP_NAME2
    FROM SCMDATA.T_RETURN_MANAGEMENT Z
   WHERE Z.AUDIT_TIME IS NOT NULL
  CONNECT BY PRIOR RM_ID = RM_ID
         AND LEVEL <= LENGTH(Z.SUP_GROUP_NAME) -
             LENGTH(REGEXP_REPLACE(Z.SUP_GROUP_NAME, ',', '')) + 1
         AND PRIOR DBMS_RANDOM.VALUE IS NOT NULL),
 TEMP_RT2 AS
 (SELECT Z.RM_ID, Z.COMPANY_ID, Z.YEAR, Z.QUARTER, Z.MONTH, Z.ACCESS_TIME,Z.SUPPLIER_CODE,
         Z.GOO_ID, Z.EXAMOUNT, Z.QC_DIRECTOR_ID,
         Z.RM_ID || ROW_NUMBER() OVER(PARTITION BY Z.RM_ID ORDER BY 1) RM_ID2,
         Z.EXAMOUNT / (COUNT(Z.RM_ID) OVER(PARTITION BY(Z.RM_ID))) EXGAMOUNT2,
         REGEXP_SUBSTR(Z.SUP_GROUP_NAME, '[^,]+', 1, LEVEL) SUP_GROUP_NAME2
    FROM SCMDATA.T_RETURN_MANAGEMENT Z
    LEFT JOIN SCMDATA.T_ABNORMAL_DTL_CONFIG C
      ON Z.CAUSE_DETAIL_ID = C.ABNORMAL_DTL_CONFIG_ID
     AND Z.COMPANY_ID = C.COMPANY_ID
     AND C.ANOMALY_CLASSIFICATION = 'AC_QUALITY'
   INNER JOIN SCMDATA.SYS_COMPANY_DEPT D
      ON D.COMPANY_DEPT_ID = Z.FIRST_DEPT_ID
   WHERE Z.AUDIT_TIME IS NOT NULL
     AND C.CAUSE_CLASSIFICATION <> '银饰氧化问题'
     AND C.PROBLEM_CLASSIFICATION <> '非质量问题'
     AND D.DEPT_NAME = '供应链管理部'
     AND INSTR(Z.SECOND_DEPT_ID, 'b550778b4f2d36b4e0533c281caca074') > 0
  CONNECT BY PRIOR RM_ID = RM_ID
         AND LEVEL <= LENGTH(Z.SUP_GROUP_NAME) -
             LENGTH(REGEXP_REPLACE(Z.SUP_GROUP_NAME, ',', '')) + 1
         AND PRIOR DBMS_RANDOM.VALUE IS NOT NULL),
TEMP_PTORDER AS
 (SELECT T1.PT_ORDERED_ID, T1.GOO_ID_PR,T1.ORDER_ID, T1.DELIVERY_AMOUNT,
         T1.PT_ORDERED_ID || ROW_NUMBER() OVER(PARTITION BY T1.PT_ORDERED_ID ORDER BY 1) ID2,
         T1.COMPANY_ID, T1.PRODUCT_GRESS_CODE, T1.ORDER_MONEY,
         (T1.ORDER_MONEY / COUNT(T1.PRODUCT_GRESS_CODE)
           OVER(PARTITION BY T1.PRODUCT_GRESS_CODE)) SUM1,
         REGEXP_SUBSTR(T1.QC_MANAGER, '[^,]+', 1, LEVEL) QCZG2
    FROM SCMDATA.PT_ORDERED T1
   WHERE T1.QC_MANAGER IS NOT NULL
  CONNECT BY PRIOR T1.PT_ORDERED_ID = T1.PT_ORDERED_ID
         AND LEVEL <=
             LENGTH(T1.QC_MANAGER) - LENGTH(REGEXP_REPLACE(T1.QC_MANAGER, ',', '')) + 1
         AND PRIOR DBMS_RANDOM.VALUE IS NOT NULL)

SELECT Y.COMPANY_ID, Y.YEAR, Y.MONTH,  Y.CATEGORY, Y.GROUP_NAME,
       '08' COUNT_DIMENSION, Y.DIMENSION_SORT DIMENSION_SORT, Y.RMMONEY SHOP_RT_ORIGINAL_MONEY,
       X.SHOP_RT_MONEY/*, Z.ORDER_MONEY INGOOD_MONEY*/
  FROM (SELECT A.COMPANY_ID, A.YEAR, A.MONTH, B.CATEGORY,
       (CASE WHEN A.SUP_GROUP_NAME2 IS NULL THEN  '1' ELSE   A.SUP_GROUP_NAME2
       END) GROUP_NAME, '08' COUNT_DIMENSION, (CASE WHEN A.QCZG2 IS NULL THEN '1' ELSE A.QCZG2 END) DIMENSION_SORT,
       SUM(A.EXGAMOUNT3 * B.PRICE) RMMONEY FROM
         (SELECT Z.COMPANY_ID, Z.YEAR, Z.MONTH, Z.ACCESS_TIME, Z.GOO_ID,
                Z.SUP_GROUP_NAME2,
                Z.EXGAMOUNT2 / NVL((REGEXP_COUNT(Z.QC_DIRECTOR_ID, ',') + 1),1) EXGAMOUNT3,
                REGEXP_SUBSTR(Z.QC_DIRECTOR_ID, '[^,]+', 1, LEVEL) QCZG2
           FROM TEMP_RT Z
          WHERE (EXISTS (SELECT MAX(1)
                           FROM SCMDATA.T_PLAT_LOG X
                           INNER JOIN SCMDATA.T_PLAT_LOGS Y ON X.LOG_ID=Y.LOG_ID AND X.COMPANY_ID=Y.COMPANY_ID
                          WHERE X.APPLY_PK_ID = Z.RM_ID
                            AND Y.OPERATE_FIELD ='QC_DIRECTOR_ID'
                            AND X.ACTION_TYPE = 'UPDATE') OR
                 (NOT EXISTS (SELECT MAX(1)
                                       FROM SCMDATA.T_PLAT_LOG Y
                                       INNER JOIN SCMDATA.T_PLAT_LOGS X ON X.LOG_ID=Y.LOG_ID AND X.COMPANY_ID=Y.COMPANY_ID
                                      WHERE Y.APPLY_PK_ID = Z.RM_ID
                                        AND X.OPERATE_FIELD ='QC_DIRECTOR_ID'
                                        AND Y.ACTION_TYPE = 'UPDATE') AND
                  NOT EXISTS
                  (SELECT 1
                            FROM TEMP_PTORDER J
                           INNER JOIN SCMDATA.T_ORDERED P
                              ON P.ORDER_ID = J.ORDER_ID
                             AND P.COMPANY_ID = J.COMPANY_ID
                           WHERE J.GOO_ID_PR = Z.GOO_ID
                             AND P.SUPPLIER_CODE = Z.SUPPLIER_CODE
                             AND J.DELIVERY_AMOUNT > 0
                             AND J.COMPANY_ID = Z.COMPANY_ID
                             AND J.QCZG2 IS NOT NULL)))
         CONNECT BY PRIOR Z.RM_ID2 = Z.RM_ID2
                AND LEVEL <= LENGTH(Z.QC_DIRECTOR_ID) -
                    LENGTH(REGEXP_REPLACE(Z.QC_DIRECTOR_ID, ',', '')) + 1
                AND PRIOR DBMS_RANDOM.VALUE IS NOT NULL
         UNION ALL
         SELECT H.COMPANY_ID, H.YEAR, H.MONTH, H.ACCESS_TIME, H.GOO_ID,
                H.SUP_GROUP_NAME2,
                (H.EXGAMOUNT2 *
                 ((SELECT SUM(J.SUM1)
                      FROM TEMP_PTORDER J
                     INNER JOIN SCMDATA.T_ORDERED P
                        ON P.ORDER_ID = J.ORDER_ID
                       AND P.COMPANY_ID = J.COMPANY_ID
                     WHERE J.GOO_ID_PR = H.GOO_ID
                       AND P.SUPPLIER_CODE = H.SUPPLIER_CODE
                       AND J.COMPANY_ID = H.COMPANY_ID
                       AND J.QCZG2 = H.QCZG2
                       AND J.DELIVERY_AMOUNT > 0) /
                 (SELECT SUM(J.ORDER_MONEY)
                      FROM TEMP_PTORDER J
                     INNER JOIN SCMDATA.T_ORDERED P
                        ON P.ORDER_ID = J.ORDER_ID
                       AND P.COMPANY_ID = J.COMPANY_ID
                     WHERE J.GOO_ID_PR = H.GOO_ID
                       AND P.SUPPLIER_CODE = H.SUPPLIER_CODE
                       AND H.COMPANY_ID = J.COMPANY_ID
                       AND J.DELIVERY_AMOUNT > 0
                       AND J.QCZG2 IS NOT NULL))) EXGAMOUNT3, H.QCZG2
           FROM (SELECT Z.*, REGEXP_SUBSTR(Z.QC_DIRECTOR_ID, '[^,]+', 1, LEVEL) QCZG2
                    FROM TEMP_RT Z
                   WHERE NOT EXISTS (SELECT MAX(1)
                            FROM SCMDATA.T_PLAT_LOG Y
                            INNER JOIN SCMDATA.T_PLAT_LOGS X ON X.LOG_ID=Y.LOG_ID AND X.COMPANY_ID=Y.COMPANY_ID
                           WHERE Y.APPLY_PK_ID = Z.RM_ID
                            AND X.OPERATE_FIELD ='QC_DIRECTOR_ID'
                             AND Y.ACTION_TYPE = 'UPDATE')
                     AND EXISTS
                   (SELECT MAX(1)
                            FROM TEMP_PTORDER J
                     INNER JOIN SCMDATA.T_ORDERED P
                        ON P.ORDER_ID = J.ORDER_ID
                       AND P.COMPANY_ID = J.COMPANY_ID
                           WHERE J.GOO_ID_PR = Z.GOO_ID
                             AND P.SUPPLIER_CODE = Z.SUPPLIER_CODE
                             AND J.DELIVERY_AMOUNT > 0
                             AND J.QCZG2 IS NOT NULL
                             AND J.COMPANY_ID = Z.COMPANY_ID)
                  CONNECT BY PRIOR Z.RM_ID2 = Z.RM_ID2
                         AND LEVEL <=
                             LENGTH(Z.QC_DIRECTOR_ID) -
                             LENGTH(REGEXP_REPLACE(Z.QC_DIRECTOR_ID, ',', '')) + 1
                         AND PRIOR DBMS_RANDOM.VALUE IS NOT NULL) H) A
 INNER JOIN SCMDATA.T_COMMODITY_INFO B
    ON A.GOO_ID = B.GOO_ID
   AND A.COMPANY_ID = B.COMPANY_ID
 GROUP BY A.COMPANY_ID, A.YEAR, A.MONTH, B.CATEGORY,
          A.SUP_GROUP_NAME2, A.QCZG2) Y

  LEFT JOIN (SELECT A.COMPANY_ID, A.YEAR, A.MONTH, B.CATEGORY,
       (CASE
         WHEN A.SUP_GROUP_NAME2 IS NULL THEN
          '1'
         ELSE
          A.SUP_GROUP_NAME2
       END) GROUP_NAME, '08' COUNT_DIMENSION,( CASE WHEN A.QCZG2 IS NULL THEN '1' ELSE A.QCZG2 END) DIMENSION_SORT,
       SUM(A.EXGAMOUNT3 * B.PRICE) SHOP_RT_MONEY
  FROM (SELECT Z.COMPANY_ID, Z.YEAR, Z.MONTH, Z.ACCESS_TIME, Z.GOO_ID,
                Z.SUP_GROUP_NAME2,
                Z.EXGAMOUNT2 / NVL((REGEXP_COUNT(Z.QC_DIRECTOR_ID, ',') + 1),1) EXGAMOUNT3,
                REGEXP_SUBSTR(Z.QC_DIRECTOR_ID, '[^,]+', 1, LEVEL) QCZG2
           FROM TEMP_RT2 Z
          WHERE (EXISTS (SELECT MAX(1)
                           FROM SCMDATA.T_PLAT_LOG X
                           INNER JOIN SCMDATA.T_PLAT_LOGS Y ON X.LOG_ID=Y.LOG_ID AND X.COMPANY_ID=Y.COMPANY_ID
                          WHERE X.APPLY_PK_ID = Z.RM_ID
                           AND Y.OPERATE_FIELD ='QC_DIRECTOR_ID'
                            AND X.ACTION_TYPE = 'UPDATE') OR
                 (NOT EXISTS (SELECT MAX(1)
                                       FROM SCMDATA.T_PLAT_LOG Y
                                       INNER JOIN SCMDATA.T_PLAT_LOGS X ON  X.LOG_ID=Y.LOG_ID AND X.COMPANY_ID=Y.COMPANY_ID
                                      WHERE Y.APPLY_PK_ID = Z.RM_ID
                                        AND X.OPERATE_FIELD ='QC_DIRECTOR_ID'
                                        AND Y.ACTION_TYPE = 'UPDATE') AND
                  NOT EXISTS
                  (SELECT 1
                            FROM TEMP_PTORDER J
                     INNER JOIN SCMDATA.T_ORDERED P
                        ON P.ORDER_ID = J.ORDER_ID
                       AND P.COMPANY_ID = J.COMPANY_ID
                           WHERE J.GOO_ID_PR = Z.GOO_ID
                             AND J.QCZG2 IS NOT NULL
                             AND J.DELIVERY_AMOUNT >0
                             AND J.COMPANY_ID = Z.COMPANY_ID)))
         CONNECT BY PRIOR Z.RM_ID2 = Z.RM_ID2
                AND LEVEL <= LENGTH(Z.QC_DIRECTOR_ID) -
                    LENGTH(REGEXP_REPLACE(Z.QC_DIRECTOR_ID, ',', '')) + 1
                AND PRIOR DBMS_RANDOM.VALUE IS NOT NULL
         UNION ALL
         SELECT H.COMPANY_ID, H.YEAR, H.MONTH, H.ACCESS_TIME, H.GOO_ID,
                H.SUP_GROUP_NAME2,
                (H.EXGAMOUNT2 *
                 ((SELECT SUM(J.SUM1)
                      FROM TEMP_PTORDER J
                      INNER JOIN SCMDATA.T_ORDERED P
                        ON P.ORDER_ID = J.ORDER_ID
                       AND P.COMPANY_ID = J.COMPANY_ID
                     WHERE J.GOO_ID_PR = H.GOO_ID
                       AND J.COMPANY_ID = H.COMPANY_ID
                       AND P.SUPPLIER_CODE = H.SUPPLIER_CODE
                       AND J.DELIVERY_AMOUNT >0
                       AND J.QCZG2 = H.QCZG2) /
                 (SELECT SUM(L.ORDER_MONEY)
                      FROM TEMP_PTORDER L
                      INNER JOIN SCMDATA.T_ORDERED P
                        ON P.ORDER_ID = L.ORDER_ID
                       AND P.COMPANY_ID = L.COMPANY_ID
                     WHERE L.GOO_ID_PR = H.GOO_ID
                       AND H.COMPANY_ID = L.COMPANY_ID
                       AND P.SUPPLIER_CODE = H.SUPPLIER_CODE
                       AND L.QCZG2 IS NOT NULL
                       AND L.DELIVERY_AMOUNT >0))) EXGAMOUNT3, H.QCZG2
           FROM (SELECT Z.*, REGEXP_SUBSTR(Z.QC_DIRECTOR_ID, '[^,]+', 1, LEVEL) QCZG2
                    FROM TEMP_RT2 Z
                   WHERE NOT EXISTS (SELECT MAX(1)
                            FROM SCMDATA.T_PLAT_LOG Y
                            INNER JOIN SCMDATA.T_PLAT_LOGS X ON  X.LOG_ID=Y.LOG_ID AND X.COMPANY_ID=Y.COMPANY_ID
                           WHERE Y.APPLY_PK_ID = Z.RM_ID
                             AND X.OPERATE_FIELD ='QC_DIRECTOR_ID'
                             AND Y.ACTION_TYPE = 'UPDATE')
                     AND EXISTS
                   (SELECT MAX(1)
                            FROM TEMP_PTORDER L
                           INNER JOIN SCMDATA.T_ORDERED P
                              ON P.ORDER_ID = L.ORDER_ID
                             AND P.COMPANY_ID = L.COMPANY_ID
                           WHERE L.GOO_ID_PR = Z.GOO_ID
                             AND Z.COMPANY_ID = L.COMPANY_ID
                             AND P.SUPPLIER_CODE = Z.SUPPLIER_CODE
                             AND L.QCZG2 IS NOT NULL
                             AND L.DELIVERY_AMOUNT >0 )
                  CONNECT BY PRIOR Z.RM_ID2 = Z.RM_ID2
                         AND LEVEL <=
                             LENGTH(Z.QC_DIRECTOR_ID) -
                             LENGTH(REGEXP_REPLACE(Z.QC_DIRECTOR_ID, ',', '')) + 1
                         AND PRIOR DBMS_RANDOM.VALUE IS NOT NULL) H) A
 INNER JOIN SCMDATA.T_COMMODITY_INFO B
    ON A.GOO_ID = B.GOO_ID
   AND A.COMPANY_ID = B.COMPANY_ID
 GROUP BY A.COMPANY_ID, A.YEAR, A.MONTH,B.CATEGORY,
          A.SUP_GROUP_NAME2, A.QCZG2) X
    ON X.COMPANY_ID = Y.COMPANY_ID
   AND X.YEAR = Y.YEAR
   AND X.MONTH = Y.MONTH
   AND X.CATEGORY = Y.CATEGORY
   AND X.GROUP_NAME = Y.GROUP_NAME
   AND X.COUNT_DIMENSION = Y.COUNT_DIMENSION
   AND X.DIMENSION_SORT = Y.DIMENSION_SORT
 /* LEFT JOIN ( SELECT A.COMPANY_ID,
       EXTRACT(YEAR FROM A.CREATE_TIME) YEAR,
       EXTRACT(MONTH FROM A.CREATE_TIME) MONTH,
       D.CATEGORY,
       (CASE WHEN D.GROUP_NAME IS NULL THEN  '1'  ELSE D.GROUP_NAME END) GROUP_NAME,
       '08' COUNT_DIMENSION,
       (case when D.QCZG2 is null then '1' else D.QCZG2 end) DIMENSION_SORT,
       SUM(CASE WHEN REGEXP_COUNT(D.QC_MANAGER, ',') > 0 THEN
       B.AMOUNT/NVL((REGEXP_COUNT(D.QC_MANAGER, ',') + 1),1) * E.PRICE ELSE
           B.AMOUNT * E.PRICE END ) ORDER_MONEY
  FROM SCMDATA.T_INGOOD A
 INNER JOIN SCMDATA.T_INGOODS B
    ON A.ING_ID = B.ING_ID
   AND A.COMPANY_ID = B.COMPANY_ID
 INNER JOIN SCMDATA.T_ORDERED C
    ON C.ORDER_CODE = A.DOCUMENT_NO
   AND A.COMPANY_ID = C.COMPANY_ID
 INNER JOIN (SELECT Z.*, REGEXP_SUBSTR(Z.QC_MANAGER, '[^,]+', 1, LEVEL) QCZG2
  FROM SCMDATA.PT_ORDERED Z
CONNECT BY PRIOR Z.PT_ORDERED_ID = Z.PT_ORDERED_ID
       AND LEVEL <= LENGTH(Z.QC_MANAGER) -
           LENGTH(REGEXP_REPLACE(Z.QC_MANAGER, ',', '')) + 1
       AND PRIOR DBMS_RANDOM.VALUE IS NOT NULL
) D
    ON D.ORDER_ID = C.ORDER_ID
   AND D.COMPANY_ID = C.COMPANY_ID
  INNER JOIN SCMDATA.T_COMMODITY_INFO E ON E.GOO_ID=B.GOO_ID AND E.COMPANY_ID=B.COMPANY_ID
 WHERE B.AMOUNT > 0
 GROUP BY A.COMPANY_ID,
          EXTRACT(YEAR FROM A.CREATE_TIME),
          EXTRACT(MONTH FROM A.CREATE_TIME),
          D.CATEGORY,
          D.GROUP_NAME,
          D.QCZG2) Z
    ON Z.COMPANY_ID = Y.COMPANY_ID
   AND Z.YEAR = Y.YEAR
   AND Z.MONTH = Y.MONTH
   AND Z.CATEGORY = Y.CATEGORY
   AND Z.GROUP_NAME = Y.GROUP_NAME
   AND Z.COUNT_DIMENSION = Y.COUNT_DIMENSION
   AND Z.DIMENSION_SORT = Y.DIMENSION_SORT */ ]';

   /* IF P_TYPE = 0 THEN
      V_EXSQL2 := V_SQL2 || V_WH_SQL2 || V_U_SQL2 || V_I_SQL2;
    ELSIF P_TYPE = 1 THEN
      V_EXSQL2 := V_SQL2 || V_WM_SQL1 || V_U_SQL2 || V_I_SQL2;
    END IF;
    --EXECUTE IMMEDIATE V_EXSQL;
    dbms_output.put_line(V_EXSQL2);*/
    IF P_TYPE = 0 THEN
      --进货
      V_EXSQL1 := V_SQL1||V_WH_SQL2||V_U_SQL1||V_I_SQL1;
      --退货
      V_EXSQL2 := V_SQL2 || V_WH_SQL2 || V_U_SQL2 || V_I_SQL2;


    ELSIF P_TYPE = 1 THEN
      --进货
      V_EXSQL1 := V_SQL1||V_WM_SQL1||V_U_SQL1||V_I_SQL1;
      --退货
      V_EXSQL2 := V_SQL2 || V_WM_SQL1 || V_U_SQL2 || V_I_SQL2;
    END IF;
   EXECUTE IMMEDIATE V_EXSQL2;
   EXECUTE IMMEDIATE V_EXSQL1;
    --dbms_output.put_line(V_EXSQL1);
    --dbms_output.put_line(V_EXSQL2);
  END P_RTKPI_MONTH;

  PROCEDURE P_RTKPI_QUARTER(P_TYPE NUMBER) IS
    --V_SQL     CLOB;
    V_WH_SQL2 CLOB; --全部历史数据
    V_EXSQL1   CLOB;
    V_EXSQL2   CLOB;
    V_WM_SQL1 CLOB; --上一时间维度
    V_SQL1     CLOB;
    V_SQL2     CLOB;

    --进货数据
    V_U_SQL1  CLOB := q'[ update
                           set a.INGOOD_MONEY           =tkb.INGOOD_MONEY,
                               a.update_id              = 'ADMIN',
                               a.update_time            = sysdate
                 ]';
    --退货数据
    V_U_SQL2  CLOB := q'[ update
                           set a.SHOP_RT_MONEY          = tkb.SHOP_RT_MONEY,
                               a.SHOP_RT_ORIGINAL_MONEY = tkb.SHOP_RT_ORIGINAL_MONEY,
                               a.update_id              = 'ADMIN',
                               a.update_time            = sysdate
                 ]';

    --新增进货数据
    V_I_SQL1  CLOB := q'[
    WHEN NOT MATCHED THEN
      INSERT
        (A.T_RTKPI_Q_ID, A.COMPANY_ID, A.YEAR, A.QUARTER, A.CATEGORY, A.GROUPNAME, A.COUNT_DIMENSION, A.DIMENSION_SORT, A.INGOOD_MONEY, A.CREATE_ID, A.CREATE_TIME, A.UPDATE_ID, A.UPDATE_TIME)
      VALUES
        (SCMDATA.F_GET_UUID(), TKB.COMPANY_ID, TKB.YEAR, TKB.QUARTER, TKB.CATEGORY, TKB.GROUP_NAME,  TKB.COUNT_DIMENSION, TKB.DIMENSION_SORT,TKB.INGOOD_MONEY, 'ADMIN', SYSDATE, 'ADMIN', SYSDATE)
 ]';

    --新增退货数据
    V_I_SQL2  CLOB := q'[
    WHEN NOT MATCHED THEN
      INSERT (A.T_RTKPI_Q_ID,a.company_id,a.year,a.QUARTER,a.category,a.groupname,a.count_dimension,a.dimension_sort,a.shop_rt_money,a.shop_rt_original_money,a.create_id,a.create_time,a.update_id,a.update_time)
      values (scmdata.f_get_uuid(),
         tkb.company_id,
         tkb.year,
         tkb.QUARTER,
         tkb.category,
         tkb.group_name,
         tkb.count_dimension,
         tkb.dimension_sort,
         tkb.SHOP_RT_MONEY,
         tkb.SHOP_RT_ORIGINAL_MONEY,
         'ADMIN',sysdate,'ADMIN',sysdate) ]';

  BEGIN

    --全部历史数据
    V_WH_SQL2 := q'[
       WHERE (y.year||Y.QUARTER) <= (to_char(add_months(sysdate,-3),'yyyy')||to_char(add_months(sysdate,-3),'q'))
         and y.year>=2023
          ) tkb
          ON (tkb.company_id = a.company_id AND tkb.year = a.year AND tkb.QUARTER=a.QUARTER  AND tkb.category=a.category
           AND tkb.group_name = a.groupname AND tkb.count_dimension =a.count_dimension AND tkb.dimension_sort =a.dimension_sort  )
           when matched then ]';

    --上一时间维度
    V_WM_SQL1 := q'[
      where (y.year||Y.QUARTER) =  (to_char(add_months(sysdate,-3),'yyyy')||to_char(add_months(sysdate,-3),'q'))
        ) tkb
      ON (tkb.company_id = a.company_id AND tkb.year = a.year AND tkb.QUARTER=a.QUARTER  AND tkb.category=a.category
           AND tkb.group_name = a.groupname AND tkb.count_dimension =a.count_dimension AND tkb.dimension_sort =a.dimension_sort  )
           when matched then ]';
    --分类维度
     --进货
     V_SQL1:=q'[MERGE INTO SCMDATA.T_RTKPI_QUARTER A
             USING (SELECT y.COMPANY_ID, y.YEAR, y.QUARTER,  y.CATEGORY,
              y.GROUP_NAME, y.COUNT_DIMENSION, y.DIMENSION_SORT,Y.ORDER_MONEY INGOOD_MONEY
              FROM (SELECT A.COMPANY_ID, EXTRACT(YEAR FROM A.CREATE_TIME) YEAR,
                       to_char( A.CREATE_TIME,'Q') QUARTER,
                       E.CATEGORY,
                       (CASE
                         WHEN D.GROUP_NAME IS NULL THEN
                          '1'
                         ELSE
                          D.GROUP_NAME
                       END) GROUP_NAME, '00' COUNT_DIMENSION,
                       E.CATEGORY DIMENSION_SORT,
                       SUM(A.AMOUNT * E.PRICE) ORDER_MONEY
                  FROM (SELECT T.DOCUMENT_NO,
                    T.COMPANY_ID,
                    TRUNC(T.CREATE_TIME) CREATE_TIME,
                    SUM(TL.AMOUNT) AMOUNT,
                    TL.GOO_ID
               FROM SCMDATA.T_INGOOD T
              INNER JOIN (SELECT TI.ING_ID,
                                TI.COMPANY_ID,
                                TI.GOO_ID,
                                TI.AMOUNT
                           FROM SCMDATA.T_INGOODS TI
                          WHERE TI.AMOUNT > 0) TL
                 ON TL.ING_ID = T.ING_ID
                AND TL.COMPANY_ID = T.COMPANY_ID
              WHERE TO_CHAR(T.CREATE_TIME, 'yyyy') >= 2022
              GROUP BY T.DOCUMENT_NO,
                       T.COMPANY_ID,
                       TRUNC(T.CREATE_TIME),
                       TL.GOO_ID) A
                   /*SCMDATA.T_INGOOD A
                 INNER JOIN SCMDATA.T_INGOODS B
                    ON A.ING_ID = B.ING_ID
                   AND A.COMPANY_ID = B.COMPANY_ID
                 LEFT JOIN SCMDATA.T_ORDERED C
                    ON C.ORDER_CODE = A.DOCUMENT_NO
                   AND A.COMPANY_ID = C.COMPANY_ID*/
                 LEFT JOIN SCMDATA.PT_ORDERED D
                    ON D.PRODUCT_GRESS_CODE = A.DOCUMENT_NO
                   AND D.COMPANY_ID = A.COMPANY_ID
                  INNER JOIN SCMDATA.T_COMMODITY_INFO E ON E.GOO_ID=A.GOO_ID AND E.COMPANY_ID=A.COMPANY_ID
                -- WHERE B.AMOUNT > 0
                 GROUP BY A.COMPANY_ID, EXTRACT(YEAR FROM A.CREATE_TIME),
                          TO_CHAR(A.CREATE_TIME,'Q'), E.CATEGORY,
                          D.GROUP_NAME) Y ]';

    --退货
    V_SQL2 := q'[MERGE INTO SCMDATA.T_RTKPI_QUARTER A
             USING (SELECT y.COMPANY_ID, y.YEAR, y.QUARTER,  y.CATEGORY,
              y.GROUP_NAME, y.COUNT_DIMENSION, y.DIMENSION_SORT,
              /*Z.ORDER_MONEY INGOOD_MONEY,*/ Y.RMMONEY SHOP_RT_ORIGINAL_MONEY, X.RMMONEY2 SHOP_RT_MONEY
          FROM
         (SELECT A.COMPANY_ID, A.YEAR, A.QUARTER,
                          B.CATEGORY,
                          (CASE
                            WHEN A.SUP_GROUP_NAME2 IS NULL THEN
                             '1'
                            ELSE
                             A.SUP_GROUP_NAME2
                          END) GROUP_NAME, '00' COUNT_DIMENSION,
                          B.CATEGORY DIMENSION_SORT,
                          SUM(CASE
                                WHEN REGEXP_COUNT(A.SUP_GROUP_NAME, ',') > 0 THEN
                                 A.EXAMOUNT /
                                 (REGEXP_COUNT(A.SUP_GROUP_NAME, ',') + 1) *
                                 B.PRICE
                                ELSE
                                 A.EXAMOUNT * B.PRICE
                              END) RMMONEY
                     FROM (SELECT Z.RM_ID, Z.COMPANY_ID, Z.YEAR, Z.QUARTER,
                                   Z.ACCESS_TIME, Z.GOO_ID, Z.EXAMOUNT,
                                   Z.SUP_GROUP_NAME, Z.AUDIT_TIME,
                                   REGEXP_SUBSTR(Z.SUP_GROUP_NAME,
                                                  '[^,]+',
                                                  1,
                                                  LEVEL) SUP_GROUP_NAME2
                              FROM SCMDATA.T_RETURN_MANAGEMENT Z
                            CONNECT BY PRIOR RM_ID = RM_ID
                                   AND LEVEL <=
                                       LENGTH(Z.SUP_GROUP_NAME) -
                                       LENGTH(REGEXP_REPLACE(Z.SUP_GROUP_NAME,
                                                             ',',
                                                             '')) + 1
                                   AND PRIOR DBMS_RANDOM.VALUE IS NOT NULL) A
                    INNER JOIN SCMDATA.T_COMMODITY_INFO B
                       ON A.GOO_ID = B.GOO_ID
                      AND A.COMPANY_ID = B.COMPANY_ID
                    WHERE A.AUDIT_TIME IS NOT NULL
                    GROUP BY A.COMPANY_ID, A.YEAR, A.QUARTER,
                             B.CATEGORY,
                             A.SUP_GROUP_NAME2) Y

         LEFT JOIN (SELECT A.COMPANY_ID, A.YEAR, A.QUARTER,
                          B.CATEGORY,
                          (CASE
                            WHEN A.SUP_GROUP_NAME2 IS NULL THEN
                             '1'
                            ELSE
                             A.SUP_GROUP_NAME2
                          END) GROUP_NAME, '00' COUNT_DIMENSION,
                          B.CATEGORY DIMENSION_SORT,
                          SUM(CASE
                                WHEN REGEXP_COUNT(A.SUP_GROUP_NAME, ',') > 0 THEN
                                 A.EXAMOUNT /
                                 (REGEXP_COUNT(A.SUP_GROUP_NAME, ',') + 1) *
                                 B.PRICE
                                ELSE
                                 A.EXAMOUNT * B.PRICE
                              END) RMMONEY2
                     FROM (SELECT Z.RM_ID, Z.COMPANY_ID, Z.YEAR, Z.QUARTER,
                                   Z.ACCESS_TIME, Z.GOO_ID, Z.EXAMOUNT,
                                   Z.SUP_GROUP_NAME, Z.AUDIT_TIME,
                                   Z.CAUSE_DETAIL_ID, Z.FIRST_DEPT_ID,
                                   Z.SECOND_DEPT_ID,
                                   REGEXP_SUBSTR(Z.SUP_GROUP_NAME,
                                                  '[^,]+',
                                                  1,
                                                  LEVEL) SUP_GROUP_NAME2
                              FROM SCMDATA.T_RETURN_MANAGEMENT Z
                            CONNECT BY PRIOR RM_ID = RM_ID
                                   AND LEVEL <=
                                       LENGTH(Z.SUP_GROUP_NAME) -
                                       LENGTH(REGEXP_REPLACE(Z.SUP_GROUP_NAME,
                                                             ',',
                                                             '')) + 1
                                   AND PRIOR DBMS_RANDOM.VALUE IS NOT NULL) A
                    INNER JOIN SCMDATA.T_COMMODITY_INFO B
                       ON A.GOO_ID = B.GOO_ID
                      AND A.COMPANY_ID = B.COMPANY_ID
                     LEFT JOIN SCMDATA.T_ABNORMAL_DTL_CONFIG C
                       ON A.CAUSE_DETAIL_ID = C.ABNORMAL_DTL_CONFIG_ID
                      AND A.COMPANY_ID = C.COMPANY_ID
                      AND C.ANOMALY_CLASSIFICATION = 'AC_QUALITY'
                    INNER JOIN SCMDATA.SYS_COMPANY_DEPT D
                       ON D.COMPANY_DEPT_ID = A.FIRST_DEPT_ID
                    WHERE A.AUDIT_TIME IS NOT NULL
                      AND C.CAUSE_CLASSIFICATION <> '银饰氧化问题'
                      AND C.PROBLEM_CLASSIFICATION <> '非质量问题'
                      AND D.DEPT_NAME = '供应链管理部'
                    GROUP BY A.COMPANY_ID, A.YEAR, A.QUARTER, B.CATEGORY,
                             A.SUP_GROUP_NAME2) X
           ON X.COMPANY_ID = Y.COMPANY_ID
          AND X.YEAR = Y.YEAR
          AND X.QUARTER = Y.QUARTER
          AND X.CATEGORY = Y.CATEGORY
          AND X.GROUP_NAME = Y.GROUP_NAME
          AND X.COUNT_DIMENSION = Y.COUNT_DIMENSION
          AND X.DIMENSION_SORT = Y.DIMENSION_SORT
          /*LEFT JOIN (SELECT A.COMPANY_ID, EXTRACT(YEAR FROM A.CREATE_TIME) YEAR,
                       to_char( A.CREATE_TIME,'Q') QUARTER,
                       D.CATEGORY,
                       (CASE
                         WHEN D.GROUP_NAME IS NULL THEN
                          '1'
                         ELSE
                          D.GROUP_NAME
                       END) GROUP_NAME, '00' COUNT_DIMENSION,
                       D.CATEGORY DIMENSION_SORT,
                       SUM(B.AMOUNT * E.PRICE) ORDER_MONEY
                  FROM SCMDATA.T_INGOOD A
                 INNER JOIN SCMDATA.T_INGOODS B
                    ON A.ING_ID = B.ING_ID
                   AND A.COMPANY_ID = B.COMPANY_ID
                 INNER JOIN SCMDATA.T_ORDERED C
                    ON C.ORDER_CODE = A.DOCUMENT_NO
                   AND A.COMPANY_ID = C.COMPANY_ID
                 INNER JOIN SCMDATA.PT_ORDERED D
                    ON D.ORDER_ID = C.ORDER_ID
                   AND D.COMPANY_ID = C.COMPANY_ID
                  INNER JOIN SCMDATA.T_COMMODITY_INFO E ON E.GOO_ID=B.GOO_ID AND E.COMPANY_ID=B.COMPANY_ID
                 WHERE B.AMOUNT > 0
                 GROUP BY A.COMPANY_ID, EXTRACT(YEAR FROM A.CREATE_TIME),
                          TO_CHAR(A.CREATE_TIME,'Q'), D.CATEGORY,
                          D.GROUP_NAME) z ON Z.COMPANY_ID = Y.COMPANY_ID
          AND Z.YEAR = Y.YEAR
          AND Z.QUARTER = Y.QUARTER
          AND Z.CATEGORY = Y.CATEGORY
          AND Z.GROUP_NAME = Y.GROUP_NAME
          AND Z.COUNT_DIMENSION = Y.COUNT_DIMENSION
          AND Z.DIMENSION_SORT = Y.DIMENSION_SORT*/ ]';
    /*p_type = 0 更新全部历史数据
    p_type = 1  只更新上一个月的数据 */
    IF P_TYPE = 0 THEN
      --进货
      V_EXSQL1 := V_SQL1||V_WH_SQL2||V_U_SQL1||V_I_SQL1;
      --退货
      V_EXSQL2 := V_SQL2 || V_WH_SQL2 || V_U_SQL2 || V_I_SQL2;


    ELSIF P_TYPE = 1 THEN
      --进货
      V_EXSQL1 := V_SQL1||V_WM_SQL1||V_U_SQL1||V_I_SQL1;
      --退货
      V_EXSQL2 := V_SQL2 || V_WM_SQL1 || V_U_SQL2 || V_I_SQL2;
    END IF;
    EXECUTE IMMEDIATE V_EXSQL2;
    EXECUTE IMMEDIATE V_EXSQL1;
    --dbms_output.put_line(V_EXSQL1);
    --dbms_output.put_line(V_EXSQL2);

    --区域组
    --进货数据
    V_SQL1:=q'[MERGE INTO SCMDATA.T_RTKPI_QUARTER A
USING ( SELECT Y.COMPANY_ID, Y.YEAR, Y.QUARTER,  Y.CATEGORY,
              Y.GROUP_NAME, Y.COUNT_DIMENSION, Y.DIMENSION_SORT,
              Y.ORDER_MONEY INGOOD_MONEY
              FROM (SELECT A.COMPANY_ID,
       EXTRACT(YEAR FROM A.CREATE_TIME) YEAR,
       TO_CHAR( A.CREATE_TIME,'Q') QUARTER,
       E.CATEGORY,
       (CASE WHEN D.GROUP_NAME IS NULL THEN  '1'  ELSE D.GROUP_NAME END) GROUP_NAME,
       '01' COUNT_DIMENSION,
       (CASE WHEN D.GROUP_NAME IS NULL THEN  '1'  ELSE D.GROUP_NAME END) DIMENSION_SORT,
       SUM(A.AMOUNT * E.PRICE) ORDER_MONEY
  FROM (SELECT T.DOCUMENT_NO,
                    T.COMPANY_ID,
                    TRUNC(T.CREATE_TIME) CREATE_TIME,
                    SUM(TL.AMOUNT) AMOUNT,
                    TL.GOO_ID
               FROM SCMDATA.T_INGOOD T
              INNER JOIN (SELECT TI.ING_ID,
                                TI.COMPANY_ID,
                                TI.GOO_ID,
                                TI.AMOUNT
                           FROM SCMDATA.T_INGOODS TI
                          WHERE TI.AMOUNT > 0) TL
                 ON TL.ING_ID = T.ING_ID
                AND TL.COMPANY_ID = T.COMPANY_ID
              WHERE TO_CHAR(T.CREATE_TIME, 'yyyy') >= 2022
              GROUP BY T.DOCUMENT_NO,
                       T.COMPANY_ID,
                       TRUNC(T.CREATE_TIME),
                       TL.GOO_ID) A
                   /*SCMDATA.T_INGOOD A
                 INNER JOIN SCMDATA.T_INGOODS B
                    ON A.ING_ID = B.ING_ID
                   AND A.COMPANY_ID = B.COMPANY_ID
                 LEFT JOIN SCMDATA.T_ORDERED C
                    ON C.ORDER_CODE = A.DOCUMENT_NO
                   AND A.COMPANY_ID = C.COMPANY_ID*/
                 LEFT JOIN SCMDATA.PT_ORDERED D
                    ON D.PRODUCT_GRESS_CODE = A.DOCUMENT_NO
                   AND D.COMPANY_ID = A.COMPANY_ID
                  INNER JOIN SCMDATA.T_COMMODITY_INFO E ON E.GOO_ID=A.GOO_ID AND E.COMPANY_ID=A.COMPANY_ID
                -- WHERE B.AMOUNT > 0
 GROUP BY A.COMPANY_ID,
          EXTRACT(YEAR FROM A.CREATE_TIME),
          TO_CHAR( A.CREATE_TIME,'Q'),
          E.CATEGORY,
          D.GROUP_NAME) Y ]';


    --退货数据
    V_SQL2 := q'[MERGE INTO SCMDATA.T_RTKPI_QUARTER A
USING (SELECT Y.COMPANY_ID, Y.YEAR, Y.QUARTER,  Y.CATEGORY,
              Y.GROUP_NAME, Y.COUNT_DIMENSION, Y.DIMENSION_SORT,
             /* Z.ORDER_MONEY INGOOD_MONEY,*/ Y.RMMONEY SHOP_RT_ORIGINAL_MONEY, X.RMMONEY2 SHOP_RT_MONEY

         FROM
         (SELECT A.COMPANY_ID, A.YEAR, A.QUARTER,
                          B.CATEGORY,
                          (CASE
                            WHEN A.SUP_GROUP_NAME2 IS NULL THEN
                             '1'
                            ELSE
                             A.SUP_GROUP_NAME2
                          END) GROUP_NAME, '01' COUNT_DIMENSION,
                         (CASE
                            WHEN A.SUP_GROUP_NAME2 IS NULL THEN
                             '1'
                            ELSE
                             A.SUP_GROUP_NAME2
                          END) DIMENSION_SORT,
                          SUM(CASE
                                WHEN REGEXP_COUNT(A.SUP_GROUP_NAME, ',') > 0 THEN
                                 A.EXAMOUNT /
                                 (REGEXP_COUNT(A.SUP_GROUP_NAME, ',') + 1) *
                                 B.PRICE
                                ELSE
                                 A.EXAMOUNT * B.PRICE
                              END) RMMONEY
                     FROM (SELECT Z.RM_ID, Z.COMPANY_ID, Z.YEAR, Z.QUARTER,
                                   Z.ACCESS_TIME, Z.GOO_ID, Z.EXAMOUNT,
                                   Z.SUP_GROUP_NAME, Z.AUDIT_TIME,
                                   REGEXP_SUBSTR(Z.SUP_GROUP_NAME,
                                                  '[^,]+',
                                                  1,
                                                  LEVEL) SUP_GROUP_NAME2
                              FROM   SCMDATA.T_RETURN_MANAGEMENT z
   CONNECT BY PRIOR RM_ID = RM_ID
          AND LEVEL <= LENGTH(z.SUP_GROUP_NAME) -
              LENGTH(REGEXP_REPLACE(z.SUP_GROUP_NAME, ',', '')) + 1
          AND PRIOR DBMS_RANDOM.VALUE IS NOT NULL) A
        INNER JOIN scmdata.T_COMMODITY_INFO B
             ON A.GOO_ID = B.GOO_ID
            AND A.COMPANY_ID = B.COMPANY_ID
       WHERE A.AUDIT_TIME IS NOT NULL
       GROUP BY A.COMPANY_ID,
                A.YEAR,
                A.QUARTER,
                B.CATEGORY,
                 A.SUP_GROUP_NAME2) Y

         LEFT JOIN (SELECT A.COMPANY_ID, A.YEAR, A.QUARTER,
                          B.CATEGORY,
                          (CASE  WHEN A.SUP_GROUP_NAME2 IS NULL THEN '1'    ELSE   A.SUP_GROUP_NAME2 END) GROUP_NAME,
                           '01' COUNT_DIMENSION,
                         (CASE  WHEN A.SUP_GROUP_NAME2 IS NULL THEN '1'    ELSE   A.SUP_GROUP_NAME2 END) DIMENSION_SORT,
                          SUM(CASE
                                WHEN REGEXP_COUNT(A.SUP_GROUP_NAME, ',') > 0 THEN
                                 A.EXAMOUNT /
                                 (REGEXP_COUNT(A.SUP_GROUP_NAME, ',') + 1) *
                                 B.PRICE
                                ELSE
                                 A.EXAMOUNT * B.PRICE
                              END) RMMONEY2
                     FROM (SELECT Z.RM_ID, Z.COMPANY_ID, Z.YEAR, Z.QUARTER,
                                   Z.ACCESS_TIME, Z.GOO_ID, Z.EXAMOUNT,
                                   Z.SUP_GROUP_NAME, Z.AUDIT_TIME,
                                   Z.CAUSE_DETAIL_ID, Z.FIRST_DEPT_ID,
                                   Z.SECOND_DEPT_ID,
                                   REGEXP_SUBSTR(Z.SUP_GROUP_NAME,
                                                  '[^,]+',
                                                  1,
                                                  LEVEL) SUP_GROUP_NAME2
                              FROM SCMDATA.T_RETURN_MANAGEMENT z
   CONNECT BY PRIOR RM_ID = RM_ID
          AND LEVEL <= LENGTH(z.SUP_GROUP_NAME) -
              LENGTH(REGEXP_REPLACE(z.SUP_GROUP_NAME, ',', '')) + 1
          AND PRIOR DBMS_RANDOM.VALUE IS NOT NULL) A
        INNER JOIN scmdata.T_COMMODITY_INFO B
             ON A.GOO_ID = B.GOO_ID
            AND A.COMPANY_ID = B.COMPANY_ID
          LEFT JOIN SCMDATA.T_abnormal_dtl_config C ON A.CAUSE_DETAIL_ID = C.ABNORMAL_DTL_CONFIG_ID AND A.COMPANY_ID = C.COMPANY_ID AND C.ANOMALY_CLASSIFICATION='AC_QUALITY'
         INNER JOIN SCMDATA.SYS_COMPANY_DEPT D ON D.COMPANY_DEPT_ID=A.FIRST_DEPT_ID
       WHERE A.AUDIT_TIME IS NOT NULL
       AND C.CAUSE_CLASSIFICATION <> '银饰氧化问题'
       AND C.PROBLEM_CLASSIFICATION <> '非质量问题'
        AND D.DEPT_NAME = '供应链管理部'
       GROUP BY A.COMPANY_ID,
                A.YEAR,
                A.QUARTER,
                B.CATEGORY,
                 A.SUP_GROUP_NAME2) X
           ON X.COMPANY_ID = Y.COMPANY_ID
          AND X.YEAR = Y.YEAR
          AND X.QUARTER = Y.QUARTER
          AND X.CATEGORY = Y.CATEGORY
          AND X.GROUP_NAME = Y.GROUP_NAME
          AND X.COUNT_DIMENSION = Y.COUNT_DIMENSION
          AND X.DIMENSION_SORT = Y.DIMENSION_SORT
          /*LEFT JOIN
          (SELECT A.COMPANY_ID,
       EXTRACT(YEAR FROM A.CREATE_TIME) YEAR,
       TO_CHAR( A.CREATE_TIME,'Q') QUARTER,
       D.CATEGORY,
       (CASE WHEN D.GROUP_NAME IS NULL THEN  '1'  ELSE D.GROUP_NAME END) GROUP_NAME,
       '01' COUNT_DIMENSION,
       (CASE WHEN D.GROUP_NAME IS NULL THEN  '1'  ELSE D.GROUP_NAME END) DIMENSION_SORT,
       SUM(B.AMOUNT * E.PRICE) ORDER_MONEY
  FROM SCMDATA.T_INGOOD A
 INNER JOIN SCMDATA.T_INGOODS B
    ON A.ING_ID = B.ING_ID
   AND A.COMPANY_ID = B.COMPANY_ID
 INNER JOIN SCMDATA.T_ORDERED C
    ON C.ORDER_CODE = A.DOCUMENT_NO
   AND A.COMPANY_ID = C.COMPANY_ID
 INNER JOIN SCMDATA.PT_ORDERED D
    ON D.ORDER_ID = C.ORDER_ID
   AND D.COMPANY_ID = C.COMPANY_ID
  INNER JOIN SCMDATA.T_COMMODITY_INFO E ON E.GOO_ID=B.GOO_ID AND E.COMPANY_ID=B.COMPANY_ID
 WHERE B.AMOUNT > 0
 GROUP BY A.COMPANY_ID,
          EXTRACT(YEAR FROM A.CREATE_TIME),
          TO_CHAR( A.CREATE_TIME,'Q'),
          D.CATEGORY,
          D.GROUP_NAME) z ON Z.COMPANY_ID = Y.COMPANY_ID
          AND Z.YEAR = Y.YEAR
          AND Z.QUARTER = Y.QUARTER
          AND Z.CATEGORY = Y.CATEGORY
          AND Z.GROUP_NAME = Y.GROUP_NAME
          AND Z.COUNT_DIMENSION = Y.COUNT_DIMENSION
          AND Z.DIMENSION_SORT = Y.DIMENSION_SORT */]';
    /*p_type = 0 更新全部历史数据
    p_type = 1  只更新上一个月的数据 */
     IF P_TYPE = 0 THEN
      --进货
      V_EXSQL1 := V_SQL1||V_WH_SQL2||V_U_SQL1||V_I_SQL1;
      --退货
      V_EXSQL2 := V_SQL2 || V_WH_SQL2 || V_U_SQL2 || V_I_SQL2;


    ELSIF P_TYPE = 1 THEN
      --进货
      V_EXSQL1 := V_SQL1||V_WM_SQL1||V_U_SQL1||V_I_SQL1;
      --退货
      V_EXSQL2 := V_SQL2 || V_WM_SQL1 || V_U_SQL2 || V_I_SQL2;
    END IF;
     EXECUTE IMMEDIATE V_EXSQL1;
     EXECUTE IMMEDIATE V_EXSQL2;
    --dbms_output.put_line(V_EXSQL1);
    --dbms_output.put_line(V_EXSQL2);

    --款式名称
    V_SQL1:=q'[MERGE INTO SCMDATA.T_RTKPI_QUARTER A
USING (SELECT Y.COMPANY_ID, Y.YEAR, Y.QUARTER, Y.CATEGORY,
              Y.GROUP_NAME, Y.COUNT_DIMENSION, Y.DIMENSION_SORT,
              Y.ORDER_MONEY INGOOD_MONEY
         FROM ( SELECT A.COMPANY_ID,
       EXTRACT(YEAR FROM A.CREATE_TIME) YEAR,
       TO_CHAR( A.CREATE_TIME,'Q') QUARTER,
       E.CATEGORY,
       (CASE WHEN D.GROUP_NAME IS NULL THEN  '1'  ELSE D.GROUP_NAME END) GROUP_NAME,
       '02' COUNT_DIMENSION,
       E.STYLE_NAME DIMENSION_SORT,
       SUM(A.AMOUNT * E.PRICE) ORDER_MONEY
  FROM (SELECT T.DOCUMENT_NO,
                    T.COMPANY_ID,
                    TRUNC(T.CREATE_TIME) CREATE_TIME,
                    SUM(TL.AMOUNT) AMOUNT,
                    TL.GOO_ID
               FROM SCMDATA.T_INGOOD T
              INNER JOIN (SELECT TI.ING_ID,
                                TI.COMPANY_ID,
                                TI.GOO_ID,
                                TI.AMOUNT
                           FROM SCMDATA.T_INGOODS TI
                          WHERE TI.AMOUNT > 0) TL
                 ON TL.ING_ID = T.ING_ID
                AND TL.COMPANY_ID = T.COMPANY_ID
              WHERE TO_CHAR(T.CREATE_TIME, 'yyyy') >= 2022
              GROUP BY T.DOCUMENT_NO,
                       T.COMPANY_ID,
                       TRUNC(T.CREATE_TIME),
                       TL.GOO_ID) A
                   /*SCMDATA.T_INGOOD A
                 INNER JOIN SCMDATA.T_INGOODS B
                    ON A.ING_ID = B.ING_ID
                   AND A.COMPANY_ID = B.COMPANY_ID
                 LEFT JOIN SCMDATA.T_ORDERED C
                    ON C.ORDER_CODE = A.DOCUMENT_NO
                   AND A.COMPANY_ID = C.COMPANY_ID*/
                 LEFT JOIN SCMDATA.PT_ORDERED D
                    ON D.PRODUCT_GRESS_CODE = A.DOCUMENT_NO
                   AND D.COMPANY_ID = A.COMPANY_ID
                  INNER JOIN SCMDATA.T_COMMODITY_INFO E ON E.GOO_ID=A.GOO_ID AND E.COMPANY_ID=A.COMPANY_ID
                -- WHERE B.AMOUNT > 0
 GROUP BY A.COMPANY_ID,
          EXTRACT(YEAR FROM A.CREATE_TIME),
          TO_CHAR( A.CREATE_TIME,'Q'),
          E.CATEGORY,
          D.GROUP_NAME,
          E.STYLE_NAME) Y ]';


    V_SQL2 := q'[MERGE INTO SCMDATA.T_RTKPI_QUARTER A
USING (SELECT Y.COMPANY_ID, Y.YEAR, Y.QUARTER, Y.CATEGORY,
              Y.GROUP_NAME, Y.COUNT_DIMENSION, Y.DIMENSION_SORT,
              /*Z.ORDER_MONEY INGOOD_MONEY,*/ Y.RMMONEY SHOP_RT_ORIGINAL_MONEY, X.RMMONEY2 SHOP_RT_MONEY

         FROM
         (SELECT A.COMPANY_ID, A.YEAR, A.QUARTER,
                          B.CATEGORY,
                          (CASE
                            WHEN A.SUP_GROUP_NAME2 IS NULL THEN
                             '1'
                            ELSE
                             A.SUP_GROUP_NAME2
                          END) GROUP_NAME, '02' COUNT_DIMENSION,
                         B.STYLE_NAME DIMENSION_SORT,
                          SUM(CASE           WHEN REGEXP_COUNT(A.SUP_GROUP_NAME, ',') > 0 THEN
                                 A.EXAMOUNT /
                                 (REGEXP_COUNT(A.SUP_GROUP_NAME, ',') + 1) *
                                 B.PRICE
                                ELSE
                                 A.EXAMOUNT * B.PRICE
                              END) RMMONEY
                     FROM (SELECT Z.RM_ID, Z.COMPANY_ID, Z.YEAR, Z.QUARTER,
                                   Z.ACCESS_TIME, Z.GOO_ID, Z.EXAMOUNT,
                                   Z.SUP_GROUP_NAME, Z.AUDIT_TIME,
                                   REGEXP_SUBSTR(Z.SUP_GROUP_NAME,
                                                  '[^,]+',
                                                  1,
                                                  LEVEL) SUP_GROUP_NAME2
                              FROM   SCMDATA.T_RETURN_MANAGEMENT z
   CONNECT BY PRIOR RM_ID = RM_ID
          AND LEVEL <= LENGTH(z.SUP_GROUP_NAME) -
              LENGTH(REGEXP_REPLACE(z.SUP_GROUP_NAME, ',', '')) + 1
          AND PRIOR DBMS_RANDOM.VALUE IS NOT NULL) A
        INNER JOIN scmdata.T_COMMODITY_INFO B
             ON A.GOO_ID = B.GOO_ID
            AND A.COMPANY_ID = B.COMPANY_ID
       WHERE A.AUDIT_TIME IS NOT NULL
       GROUP BY A.COMPANY_ID,
                A.YEAR,
                A.QUARTER,
                B.CATEGORY,
                 A.SUP_GROUP_NAME2,
                B.STYLE_NAME) Y

         LEFT JOIN (SELECT A.COMPANY_ID, A.YEAR, A.QUARTER,
                          B.CATEGORY,
                          (CASE  WHEN A.SUP_GROUP_NAME2 IS NULL THEN '1'    ELSE   A.SUP_GROUP_NAME2 END) GROUP_NAME,
                           '02' COUNT_DIMENSION,
                         B.STYLE_NAME DIMENSION_SORT,
                          SUM(CASE
                                WHEN REGEXP_COUNT(A.SUP_GROUP_NAME, ',') > 0 THEN
                                 A.EXAMOUNT /
                                 (REGEXP_COUNT(A.SUP_GROUP_NAME, ',') + 1) *
                                 B.PRICE
                                ELSE
                                 A.EXAMOUNT * B.PRICE
                              END) RMMONEY2
                     FROM (SELECT Z.RM_ID, Z.COMPANY_ID, Z.YEAR, Z.QUARTER,
                                   Z.ACCESS_TIME, Z.GOO_ID, Z.EXAMOUNT,
                                   Z.SUP_GROUP_NAME, Z.AUDIT_TIME,
                                   Z.CAUSE_DETAIL_ID, Z.FIRST_DEPT_ID,
                                   Z.SECOND_DEPT_ID,
                                   REGEXP_SUBSTR(Z.SUP_GROUP_NAME,
                                                  '[^,]+',
                                                  1,
                                                  LEVEL) SUP_GROUP_NAME2
                              FROM SCMDATA.T_RETURN_MANAGEMENT Z
        CONNECT BY PRIOR RM_ID = RM_ID
               AND LEVEL <=
                   LENGTH(Z.SUP_GROUP_NAME) -
                   LENGTH(REGEXP_REPLACE(Z.SUP_GROUP_NAME, ',', '')) + 1
               AND PRIOR DBMS_RANDOM.VALUE IS NOT NULL) A
 INNER JOIN SCMDATA.T_COMMODITY_INFO B
    ON A.GOO_ID = B.GOO_ID
   AND A.COMPANY_ID = B.COMPANY_ID
  LEFT JOIN SCMDATA.T_ABNORMAL_DTL_CONFIG C
    ON A.CAUSE_DETAIL_ID = C.ABNORMAL_DTL_CONFIG_ID
   AND A.COMPANY_ID = C.COMPANY_ID
   AND C.ANOMALY_CLASSIFICATION = 'AC_QUALITY'
 INNER JOIN SCMDATA.SYS_COMPANY_DEPT D
    ON D.COMPANY_DEPT_ID = A.FIRST_DEPT_ID
 WHERE A.AUDIT_TIME IS NOT NULL
   AND C.CAUSE_CLASSIFICATION <> '银饰氧化问题'
   AND C.PROBLEM_CLASSIFICATION <> '非质量问题'
   AND D.DEPT_NAME = '供应链管理部'
 GROUP BY A.COMPANY_ID,
          A.YEAR,
          A.QUARTER,
          B.CATEGORY,
          A.SUP_GROUP_NAME2,
          B.STYLE_NAME) X
           ON X.COMPANY_ID = Y.COMPANY_ID
          AND X.YEAR = Y.YEAR
          AND X.QUARTER = Y.QUARTER
          AND X.CATEGORY = Y.CATEGORY
          AND X.GROUP_NAME = Y.GROUP_NAME
          AND X.COUNT_DIMENSION = Y.COUNT_DIMENSION
          AND X.DIMENSION_SORT = Y.DIMENSION_SORT
         /* LEFT JOIN ( SELECT A.COMPANY_ID,
       EXTRACT(YEAR FROM A.CREATE_TIME) YEAR,
       TO_CHAR( A.CREATE_TIME,'Q') QUARTER,
       D.CATEGORY,
       (CASE WHEN D.GROUP_NAME IS NULL THEN  '1'  ELSE D.GROUP_NAME END) GROUP_NAME,
       '02' COUNT_DIMENSION,
       D.STYLE_NAME DIMENSION_SORT,
       SUM(B.AMOUNT * E.PRICE) ORDER_MONEY
  FROM SCMDATA.T_INGOOD A
 INNER JOIN SCMDATA.T_INGOODS B
    ON A.ING_ID = B.ING_ID
   AND A.COMPANY_ID = B.COMPANY_ID
 INNER JOIN SCMDATA.T_ORDERED C
    ON C.ORDER_CODE = A.DOCUMENT_NO
   AND A.COMPANY_ID = C.COMPANY_ID
 INNER JOIN SCMDATA.PT_ORDERED D
    ON D.ORDER_ID = C.ORDER_ID
   AND D.COMPANY_ID = C.COMPANY_ID
  INNER JOIN SCMDATA.T_COMMODITY_INFO E ON E.GOO_ID=B.GOO_ID AND E.COMPANY_ID=B.COMPANY_ID
 WHERE B.AMOUNT > 0
 GROUP BY A.COMPANY_ID,
          EXTRACT(YEAR FROM A.CREATE_TIME),
          TO_CHAR( A.CREATE_TIME,'Q'),
          D.CATEGORY,
          D.GROUP_NAME,
          D.STYLE_NAME) z ON Z.COMPANY_ID = Y.COMPANY_ID
          AND Z.YEAR = Y.YEAR
          AND Z.QUARTER = Y.QUARTER
          AND Z.CATEGORY = Y.CATEGORY
          AND Z.GROUP_NAME = Y.GROUP_NAME
          AND Z.COUNT_DIMENSION = Y.COUNT_DIMENSION
          AND Z.DIMENSION_SORT = Y.DIMENSION_SORT*/ ]';
   IF P_TYPE = 0 THEN
      --进货
      V_EXSQL1 := V_SQL1||V_WH_SQL2||V_U_SQL1||V_I_SQL1;
      --退货
      V_EXSQL2 := V_SQL2 || V_WH_SQL2 || V_U_SQL2 || V_I_SQL2;


    ELSIF P_TYPE = 1 THEN
      --进货
      V_EXSQL1 := V_SQL1||V_WM_SQL1||V_U_SQL1||V_I_SQL1;
      --退货
      V_EXSQL2 := V_SQL2 || V_WM_SQL1 || V_U_SQL2 || V_I_SQL2;
    END IF;
     EXECUTE IMMEDIATE V_EXSQL1;
     EXECUTE IMMEDIATE V_EXSQL2;
    --dbms_output.put_line(V_EXSQL1);
    --dbms_output.put_line(V_EXSQL2);

    --产品子类
    V_SQL1:=q'[MERGE INTO SCMDATA.T_RTKPI_QUARTER A
USING (SELECT Y.COMPANY_ID, Y.YEAR, Y.QUARTER,  Y.CATEGORY,
              Y.GROUP_NAME, Y.COUNT_DIMENSION, Y.DIMENSION_SORT,
              Y.ORDER_MONEY INGOOD_MONEY
           FROM (  SELECT A.COMPANY_ID,
       EXTRACT(YEAR FROM A.CREATE_TIME) YEAR,
       TO_CHAR( A.CREATE_TIME,'Q') QUARTER,
       E.CATEGORY,
       (CASE WHEN D.GROUP_NAME IS NULL THEN  '1'  ELSE D.GROUP_NAME END) GROUP_NAME,
       '03' COUNT_DIMENSION,
       E.SAMLL_CATEGORY DIMENSION_SORT,
       SUM(a.AMOUNT * E.PRICE) ORDER_MONEY
  FROM (SELECT T.DOCUMENT_NO,
                    T.COMPANY_ID,
                    TRUNC(T.CREATE_TIME) CREATE_TIME,
                    SUM(TL.AMOUNT) AMOUNT,
                    TL.GOO_ID
               FROM SCMDATA.T_INGOOD T
              INNER JOIN (SELECT TI.ING_ID,
                                TI.COMPANY_ID,
                                TI.GOO_ID,
                                TI.AMOUNT
                           FROM SCMDATA.T_INGOODS TI
                          WHERE TI.AMOUNT > 0) TL
                 ON TL.ING_ID = T.ING_ID
                AND TL.COMPANY_ID = T.COMPANY_ID
              WHERE TO_CHAR(T.CREATE_TIME, 'yyyy') >= 2022
              GROUP BY T.DOCUMENT_NO,
                       T.COMPANY_ID,
                       TRUNC(T.CREATE_TIME),
                       TL.GOO_ID) A
                   /*SCMDATA.T_INGOOD A
                 INNER JOIN SCMDATA.T_INGOODS B
                    ON A.ING_ID = B.ING_ID
                   AND A.COMPANY_ID = B.COMPANY_ID
                 LEFT JOIN SCMDATA.T_ORDERED C
                    ON C.ORDER_CODE = A.DOCUMENT_NO
                   AND A.COMPANY_ID = C.COMPANY_ID*/
                 LEFT JOIN SCMDATA.PT_ORDERED D
                    ON D.PRODUCT_GRESS_CODE = A.DOCUMENT_NO
                   AND D.COMPANY_ID = A.COMPANY_ID
                  INNER JOIN SCMDATA.T_COMMODITY_INFO E ON E.GOO_ID=A.GOO_ID AND E.COMPANY_ID=A.COMPANY_ID
                -- WHERE B.AMOUNT > 0
 GROUP BY A.COMPANY_ID,
          EXTRACT(YEAR FROM A.CREATE_TIME),
          TO_CHAR(A.CREATE_TIME,'Q'),
          E.CATEGORY,
          D.GROUP_NAME,
          E.SAMLL_CATEGORY) Y   ]';
    V_SQL2 := q'[MERGE INTO SCMDATA.T_RTKPI_QUARTER A
USING (SELECT Y.COMPANY_ID, Y.YEAR, Y.QUARTER,  Y.CATEGORY,
              Y.GROUP_NAME, Y.COUNT_DIMENSION, Y.DIMENSION_SORT,
              /*Z.ORDER_MONEY INGOOD_MONEY,*/ Y.RMMONEY SHOP_RT_ORIGINAL_MONEY, X.RMMONEY2 SHOP_RT_MONEY

         FROM
         (SELECT A.COMPANY_ID, A.YEAR, A.QUARTER,
                          B.CATEGORY,
                          (CASE
                            WHEN A.SUP_GROUP_NAME2 IS NULL THEN
                             '1'
                            ELSE
                             A.SUP_GROUP_NAME2
                          END) GROUP_NAME, '03' COUNT_DIMENSION,
                         B.SAMLL_CATEGORY DIMENSION_SORT,
                          SUM(CASE           WHEN REGEXP_COUNT(A.SUP_GROUP_NAME, ',') > 0 THEN
                                 A.EXAMOUNT /
                                 (REGEXP_COUNT(A.SUP_GROUP_NAME, ',') + 1) *
                                 B.PRICE
                                ELSE
                                 A.EXAMOUNT * B.PRICE
                              END) RMMONEY
                     FROM (SELECT Z.RM_ID, Z.COMPANY_ID, Z.YEAR, Z.QUARTER,
                                   Z.ACCESS_TIME, Z.GOO_ID, Z.EXAMOUNT,
                                   Z.SUP_GROUP_NAME, Z.AUDIT_TIME,
                                   REGEXP_SUBSTR(Z.SUP_GROUP_NAME,
                                                  '[^,]+',
                                                  1,
                                                  LEVEL) SUP_GROUP_NAME2
                              FROM  SCMDATA.T_RETURN_MANAGEMENT z
   CONNECT BY PRIOR RM_ID = RM_ID
          AND LEVEL <= LENGTH(z.SUP_GROUP_NAME) -
              LENGTH(REGEXP_REPLACE(z.SUP_GROUP_NAME, ',', '')) + 1
          AND PRIOR DBMS_RANDOM.VALUE IS NOT NULL) A
        INNER JOIN scmdata.T_COMMODITY_INFO B
             ON A.GOO_ID = B.GOO_ID
            AND A.COMPANY_ID = B.COMPANY_ID
       WHERE A.AUDIT_TIME IS NOT NULL
       GROUP BY A.COMPANY_ID,
                A.YEAR,
                A.QUARTER,
                B.CATEGORY,
                 A.SUP_GROUP_NAME2,
                B.SAMLL_CATEGORY) Y

         LEFT JOIN (SELECT A.COMPANY_ID, A.YEAR, A.QUARTER,
                          B.CATEGORY,
                          (CASE  WHEN A.SUP_GROUP_NAME2 IS NULL THEN '1'    ELSE   A.SUP_GROUP_NAME2 END) GROUP_NAME,
                           '03' COUNT_DIMENSION,
                         B.SAMLL_CATEGORY DIMENSION_SORT,
                          SUM(CASE
                                WHEN REGEXP_COUNT(A.SUP_GROUP_NAME, ',') > 0 THEN
                                 A.EXAMOUNT /
                                 (REGEXP_COUNT(A.SUP_GROUP_NAME, ',') + 1) *
                                 B.PRICE
                                ELSE
                                 A.EXAMOUNT * B.PRICE
                              END) RMMONEY2
                     FROM (SELECT Z.RM_ID, Z.COMPANY_ID, Z.YEAR, Z.QUARTER,
                                   Z.ACCESS_TIME, Z.GOO_ID, Z.EXAMOUNT,
                                   Z.SUP_GROUP_NAME, Z.AUDIT_TIME,
                                   Z.CAUSE_DETAIL_ID, Z.FIRST_DEPT_ID,
                                   Z.SECOND_DEPT_ID,
                                   REGEXP_SUBSTR(Z.SUP_GROUP_NAME,
                                                  '[^,]+',
                                                  1,
                                                  LEVEL) SUP_GROUP_NAME2
                              FROM SCMDATA.T_RETURN_MANAGEMENT Z
        CONNECT BY PRIOR RM_ID = RM_ID
               AND LEVEL <=
                   LENGTH(Z.SUP_GROUP_NAME) -
                   LENGTH(REGEXP_REPLACE(Z.SUP_GROUP_NAME, ',', '')) + 1
               AND PRIOR DBMS_RANDOM.VALUE IS NOT NULL) A
 INNER JOIN SCMDATA.T_COMMODITY_INFO B
    ON A.GOO_ID = B.GOO_ID
   AND A.COMPANY_ID = B.COMPANY_ID
  LEFT JOIN SCMDATA.T_ABNORMAL_DTL_CONFIG C
    ON A.CAUSE_DETAIL_ID = C.ABNORMAL_DTL_CONFIG_ID
   AND A.COMPANY_ID = C.COMPANY_ID
   AND C.ANOMALY_CLASSIFICATION = 'AC_QUALITY'
 INNER JOIN SCMDATA.SYS_COMPANY_DEPT D
    ON D.COMPANY_DEPT_ID = A.FIRST_DEPT_ID
 WHERE A.AUDIT_TIME IS NOT NULL
   AND C.CAUSE_CLASSIFICATION <> '银饰氧化问题'
   AND C.PROBLEM_CLASSIFICATION <> '非质量问题'
   AND D.DEPT_NAME = '供应链管理部'
 GROUP BY A.COMPANY_ID,
          A.YEAR,
          A.QUARTER,
          B.CATEGORY,
          A.SUP_GROUP_NAME2,
          B.SAMLL_CATEGORY) X
           ON X.COMPANY_ID = Y.COMPANY_ID
          AND X.YEAR = Y.YEAR
          AND X.QUARTER = Y.QUARTER
          AND X.CATEGORY = Y.CATEGORY
          AND X.GROUP_NAME = Y.GROUP_NAME
          AND X.COUNT_DIMENSION = Y.COUNT_DIMENSION
          AND X.DIMENSION_SORT = Y.DIMENSION_SORT
         /* LEFT JOIN
          (  SELECT A.COMPANY_ID,
       EXTRACT(YEAR FROM A.CREATE_TIME) YEAR,
       TO_CHAR( A.CREATE_TIME,'Q') QUARTER,
       D.CATEGORY,
       (CASE WHEN D.GROUP_NAME IS NULL THEN  '1'  ELSE D.GROUP_NAME END) GROUP_NAME,
       '03' COUNT_DIMENSION,
       D.SAMLL_CATEGORY DIMENSION_SORT,
       SUM(B.AMOUNT * E.PRICE) ORDER_MONEY
  FROM SCMDATA.T_INGOOD A
 INNER JOIN SCMDATA.T_INGOODS B
    ON A.ING_ID = B.ING_ID
   AND A.COMPANY_ID = B.COMPANY_ID
 INNER JOIN SCMDATA.T_ORDERED C
    ON C.ORDER_CODE = A.DOCUMENT_NO
   AND A.COMPANY_ID = C.COMPANY_ID
 INNER JOIN SCMDATA.PT_ORDERED D
    ON D.ORDER_ID = C.ORDER_ID
   AND D.COMPANY_ID = C.COMPANY_ID
 INNER JOIN SCMDATA.T_COMMODITY_INFO E ON E.GOO_ID=B.GOO_ID AND E.COMPANY_ID=B.COMPANY_ID
 WHERE B.AMOUNT > 0
 GROUP BY A.COMPANY_ID,
          EXTRACT(YEAR FROM A.CREATE_TIME),
          TO_CHAR(A.CREATE_TIME,'Q'),
          D.CATEGORY,
          D.GROUP_NAME,
          D.SAMLL_CATEGORY) z ON Z.COMPANY_ID = Y.COMPANY_ID
          AND Z.YEAR = Y.YEAR
          AND Z.QUARTER = Y.QUARTER
          AND Z.CATEGORY = Y.CATEGORY
          AND Z.GROUP_NAME = Y.GROUP_NAME
          AND Z.COUNT_DIMENSION = Y.COUNT_DIMENSION
          AND Z.DIMENSION_SORT = Y.DIMENSION_SORT*/]';
    IF P_TYPE = 0 THEN
      --进货
      V_EXSQL1 := V_SQL1||V_WH_SQL2||V_U_SQL1||V_I_SQL1;
      --退货
      V_EXSQL2 := V_SQL2 || V_WH_SQL2 || V_U_SQL2 || V_I_SQL2;


    ELSIF P_TYPE = 1 THEN
      --进货
      V_EXSQL1 := V_SQL1||V_WM_SQL1||V_U_SQL1||V_I_SQL1;
      --退货
      V_EXSQL2 := V_SQL2 || V_WM_SQL1 || V_U_SQL2 || V_I_SQL2;
    END IF;
     EXECUTE IMMEDIATE V_EXSQL2;
     EXECUTE IMMEDIATE V_EXSQL1;
    --dbms_output.put_line(V_EXSQL1);
    --dbms_output.put_line(V_EXSQL2);

    --  供应商
    --进货
    V_SQL1:=q'[MERGE INTO SCMDATA.T_RTKPI_QUARTER A
USING (SELECT Y.COMPANY_ID, Y.YEAR, Y.QUARTER,  Y.CATEGORY,
              Y.GROUP_NAME, Y.COUNT_DIMENSION, Y.DIMENSION_SORT,
              Y.ORDER_MONEY INGOOD_MONEY
           FROM (  SELECT A.COMPANY_ID,
       EXTRACT(YEAR FROM A.CREATE_TIME) YEAR,
       TO_CHAR(A.CREATE_TIME,'Q') QUARTER,
       D.CATEGORY,
       (CASE WHEN D.GROUP_NAME IS NULL THEN  '1'  ELSE D.GROUP_NAME END) GROUP_NAME,
       '04' COUNT_DIMENSION,
       A.SUPPLIER_CODE DIMENSION_SORT,
       SUM(A.AMOUNT * E.PRICE) ORDER_MONEY
  FROM (SELECT T.DOCUMENT_NO,
                    T.COMPANY_ID,
                    TRUNC(T.CREATE_TIME) CREATE_TIME,
                    SUM(TL.AMOUNT) AMOUNT,
                    T.SUPPLIER_CODE,
                    TL.GOO_ID
               FROM SCMDATA.T_INGOOD T
              INNER JOIN (SELECT TI.ING_ID,
                                TI.COMPANY_ID,
                                TI.GOO_ID,
                                TI.AMOUNT
                           FROM SCMDATA.T_INGOODS TI
                          WHERE TI.AMOUNT > 0) TL
                 ON TL.ING_ID = T.ING_ID
                AND TL.COMPANY_ID = T.COMPANY_ID
              WHERE TO_CHAR(T.CREATE_TIME, 'yyyy') >= 2022
              GROUP BY T.DOCUMENT_NO,
                       T.COMPANY_ID,
                       TRUNC(T.CREATE_TIME),
                       T.SUPPLIER_CODE,
                       TL.GOO_ID) A
                   /*SCMDATA.T_INGOOD A
                 INNER JOIN SCMDATA.T_INGOODS B
                    ON A.ING_ID = B.ING_ID
                   AND A.COMPANY_ID = B.COMPANY_ID
                 LEFT JOIN SCMDATA.T_ORDERED C
                    ON C.ORDER_CODE = A.DOCUMENT_NO
                   AND A.COMPANY_ID = C.COMPANY_ID*/
                 LEFT JOIN SCMDATA.PT_ORDERED D
                    ON D.PRODUCT_GRESS_CODE = A.DOCUMENT_NO
                   AND D.COMPANY_ID = A.COMPANY_ID
                  INNER JOIN SCMDATA.T_COMMODITY_INFO E ON E.GOO_ID=A.GOO_ID AND E.COMPANY_ID=A.COMPANY_ID
                -- WHERE B.AMOUNT > 0
 GROUP BY A.COMPANY_ID,
          EXTRACT(YEAR FROM A.CREATE_TIME),
          TO_CHAR(A.CREATE_TIME,'Q'),
          D.CATEGORY,
          D.GROUP_NAME,
          A.SUPPLIER_CODE) Y    ]';

    --退货
    V_SQL2 := q'[ MERGE INTO SCMDATA.T_RTKPI_QUARTER A
USING (SELECT Y.COMPANY_ID, Y.YEAR, Y.QUARTER,  Y.CATEGORY,
              Y.GROUP_NAME, Y.COUNT_DIMENSION, Y.DIMENSION_SORT,
              /*Z.ORDER_MONEY INGOOD_MONEY,*/ Y.RMMONEY SHOP_RT_ORIGINAL_MONEY, X.RMMONEY2 SHOP_RT_MONEY

         FROM
         (SELECT A.COMPANY_ID, A.YEAR, A.QUARTER,
                          B.CATEGORY,
                          (CASE
                            WHEN A.SUP_GROUP_NAME2 IS NULL THEN
                             '1'
                            ELSE
                             A.SUP_GROUP_NAME2
                          END) GROUP_NAME, '04' COUNT_DIMENSION,
                         A.SUPPLIER_CODE DIMENSION_SORT,
                          SUM(CASE           WHEN REGEXP_COUNT(A.SUP_GROUP_NAME, ',') > 0 THEN
                                 A.EXAMOUNT /
                                 (REGEXP_COUNT(A.SUP_GROUP_NAME, ',') + 1) *
                                 B.PRICE
                                ELSE
                                 A.EXAMOUNT * B.PRICE
                              END) RMMONEY
                     FROM (SELECT Z.RM_ID, Z.COMPANY_ID, Z.YEAR, Z.QUARTER,
                                   Z.ACCESS_TIME, Z.GOO_ID, Z.EXAMOUNT,
                                   Z.SUP_GROUP_NAME, Z.AUDIT_TIME,
                                   Z.SUPPLIER_CODE,
                                   REGEXP_SUBSTR(Z.SUP_GROUP_NAME,
                                                  '[^,]+',
                                                  1,
                                                  LEVEL) SUP_GROUP_NAME2
                              FROM SCMDATA.T_RETURN_MANAGEMENT z
   CONNECT BY PRIOR RM_ID = RM_ID
          AND LEVEL <= LENGTH(z.SUP_GROUP_NAME) -
              LENGTH(REGEXP_REPLACE(z.SUP_GROUP_NAME, ',', '')) + 1
          AND PRIOR DBMS_RANDOM.VALUE IS NOT NULL) A
        INNER JOIN scmdata.T_COMMODITY_INFO B
             ON A.GOO_ID = B.GOO_ID
            AND A.COMPANY_ID = B.COMPANY_ID
       WHERE A.AUDIT_TIME IS NOT NULL
       GROUP BY A.COMPANY_ID,
                A.YEAR,
                A.QUARTER,
                B.CATEGORY,
                 A.SUP_GROUP_NAME2,
                A.SUPPLIER_CODE) Y

         LEFT JOIN (SELECT A.COMPANY_ID, A.YEAR, A.QUARTER,
                          B.CATEGORY,
                          (CASE  WHEN A.SUP_GROUP_NAME2 IS NULL THEN '1'    ELSE   A.SUP_GROUP_NAME2 END) GROUP_NAME,
                           '04' COUNT_DIMENSION,
                         A.SUPPLIER_CODE DIMENSION_SORT,
                          SUM(CASE
                                WHEN REGEXP_COUNT(A.SUP_GROUP_NAME, ',') > 0 THEN
                                 A.EXAMOUNT /
                                 (REGEXP_COUNT(A.SUP_GROUP_NAME, ',') + 1) *
                                 B.PRICE
                                ELSE
                                 A.EXAMOUNT * B.PRICE
                              END) RMMONEY2
                     FROM (SELECT Z.RM_ID, Z.COMPANY_ID, Z.YEAR, Z.QUARTER,
                                   Z.ACCESS_TIME, Z.GOO_ID, Z.EXAMOUNT,
                                   Z.SUP_GROUP_NAME, Z.AUDIT_TIME,
                                   Z.CAUSE_DETAIL_ID, Z.FIRST_DEPT_ID,
                                   Z.SECOND_DEPT_ID,
                                   Z.SUPPLIER_CODE,
                                   REGEXP_SUBSTR(Z.SUP_GROUP_NAME,
                                                  '[^,]+',
                                                  1,
                                                  LEVEL) SUP_GROUP_NAME2
                              FROM SCMDATA.T_RETURN_MANAGEMENT Z
        CONNECT BY PRIOR RM_ID = RM_ID
               AND LEVEL <=
                   LENGTH(Z.SUP_GROUP_NAME) -
                   LENGTH(REGEXP_REPLACE(Z.SUP_GROUP_NAME, ',', '')) + 1
               AND PRIOR DBMS_RANDOM.VALUE IS NOT NULL) A
 INNER JOIN SCMDATA.T_COMMODITY_INFO B
    ON A.GOO_ID = B.GOO_ID
   AND A.COMPANY_ID = B.COMPANY_ID
  LEFT JOIN SCMDATA.T_ABNORMAL_DTL_CONFIG C
    ON A.CAUSE_DETAIL_ID = C.ABNORMAL_DTL_CONFIG_ID
   AND A.COMPANY_ID = C.COMPANY_ID
   AND C.ANOMALY_CLASSIFICATION = 'AC_QUALITY'
 INNER JOIN SCMDATA.SYS_COMPANY_DEPT D
    ON D.COMPANY_DEPT_ID = A.FIRST_DEPT_ID
 WHERE A.AUDIT_TIME IS NOT NULL
   AND C.CAUSE_CLASSIFICATION <> '银饰氧化问题'
   AND C.PROBLEM_CLASSIFICATION <> '非质量问题'
   AND D.DEPT_NAME = '供应链管理部'
 GROUP BY A.COMPANY_ID,
          A.YEAR,
          A.QUARTER,
          B.CATEGORY,
          A.SUP_GROUP_NAME2,
          A.SUPPLIER_CODE) X
           ON X.COMPANY_ID = Y.COMPANY_ID
          AND X.YEAR = Y.YEAR
          AND X.QUARTER = Y.QUARTER
          AND X.CATEGORY = Y.CATEGORY
          AND X.GROUP_NAME = Y.GROUP_NAME
          AND X.COUNT_DIMENSION = Y.COUNT_DIMENSION
          AND X.DIMENSION_SORT = Y.DIMENSION_SORT
         /* LEFT JOIN
          --进货数据
          (  SELECT A.COMPANY_ID,
       EXTRACT(YEAR FROM A.CREATE_TIME) YEAR,
       TO_CHAR(A.CREATE_TIME,'Q') QUARTER,
       D.CATEGORY,
       (CASE WHEN D.GROUP_NAME IS NULL THEN  '1'  ELSE D.GROUP_NAME END) GROUP_NAME,
       '04' COUNT_DIMENSION,
       C.SUPPLIER_CODE DIMENSION_SORT,
       SUM(B.AMOUNT * E.PRICE) ORDER_MONEY
  FROM SCMDATA.T_INGOOD A
 INNER JOIN SCMDATA.T_INGOODS B
    ON A.ING_ID = B.ING_ID
   AND A.COMPANY_ID = B.COMPANY_ID
 INNER JOIN SCMDATA.T_ORDERED C
    ON C.ORDER_CODE = A.DOCUMENT_NO
   AND A.COMPANY_ID = C.COMPANY_ID
 INNER JOIN SCMDATA.PT_ORDERED D
    ON D.ORDER_ID = C.ORDER_ID
   AND D.COMPANY_ID = C.COMPANY_ID
  INNER JOIN SCMDATA.T_COMMODITY_INFO E ON E.GOO_ID=B.GOO_ID AND E.COMPANY_ID=B.COMPANY_ID
 WHERE B.AMOUNT > 0
 GROUP BY A.COMPANY_ID,
          EXTRACT(YEAR FROM A.CREATE_TIME),
          TO_CHAR(A.CREATE_TIME,'Q'),
          D.CATEGORY,
          D.GROUP_NAME,
          C.SUPPLIER_CODE) z ON Z.COMPANY_ID = Y.COMPANY_ID
          AND Z.YEAR = Y.YEAR
          AND Z.QUARTER = Y.QUARTER
          AND Z.CATEGORY = Y.CATEGORY
          AND Z.GROUP_NAME = Y.GROUP_NAME
          AND Z.COUNT_DIMENSION = Y.COUNT_DIMENSION
          AND Z.DIMENSION_SORT = Y.DIMENSION_SORT*/ ]';

    IF P_TYPE = 0 THEN
      --进货
      V_EXSQL1 := V_SQL1||V_WH_SQL2||V_U_SQL1||V_I_SQL1;
      --退货
      V_EXSQL2 := V_SQL2 || V_WH_SQL2 || V_U_SQL2 || V_I_SQL2;


    ELSIF P_TYPE = 1 THEN
      --进货
      V_EXSQL1 := V_SQL1||V_WM_SQL1||V_U_SQL1||V_I_SQL1;
      --退货
      V_EXSQL2 := V_SQL2 || V_WM_SQL1 || V_U_SQL2 || V_I_SQL2;
    END IF;
     EXECUTE IMMEDIATE V_EXSQL2;
     EXECUTE IMMEDIATE V_EXSQL1;
    --dbms_output.put_line(V_EXSQL1);
    --dbms_output.put_line(V_EXSQL2);

    --跟单

    V_SQL1:=q'[ MERGE INTO SCMDATA.T_RTKPI_QUARTER A
USING ( SELECT Y.COMPANY_ID, Y.YEAR, Y.QUARTER,  Y.CATEGORY, Y.GROUP_NAME,
       Y.COUNT_DIMENSION,
       Y.DIMENSION_SORT,
       Y.ORDER_MONEY INGOOD_MONEY
   FROM (SELECT A.COMPANY_ID, EXTRACT(YEAR FROM A.CREATE_TIME) YEAR,
                    TO_CHAR(A.CREATE_TIME,'Q') QUARTER,
                    E.CATEGORY,
                    (CASE  WHEN D.GROUP_NAME IS NULL THEN  '1'  ELSE  D.GROUP_NAME    END) GROUP_NAME, '05' COUNT_DIMENSION,
                    (CASE WHEN D.GENDAN IS NULL OR D.GENDAN = 'ORDERED_ITF' THEN '1' ELSE D.GENDAN END) DIMENSION_SORT,
                    SUM(CASE
                          WHEN REGEXP_COUNT(D.FLW_ORDER, ',') > 0 THEN
                           A.AMOUNT / NVL((REGEXP_COUNT(D.FLW_ORDER, ',') + 1),1) *
                           E.PRICE
                          ELSE
                           A.AMOUNT * E.PRICE
                        END) ORDER_MONEY
               FROM (SELECT T.DOCUMENT_NO,
                    T.COMPANY_ID,
                    TRUNC(T.CREATE_TIME) CREATE_TIME,
                    SUM(TL.AMOUNT) AMOUNT,
                    TL.GOO_ID
               FROM SCMDATA.T_INGOOD T
              INNER JOIN (SELECT TI.ING_ID,
                                TI.COMPANY_ID,
                                TI.GOO_ID,
                                TI.AMOUNT
                           FROM SCMDATA.T_INGOODS TI
                          WHERE TI.AMOUNT > 0) TL
                 ON TL.ING_ID = T.ING_ID
                AND TL.COMPANY_ID = T.COMPANY_ID
              WHERE TO_CHAR(T.CREATE_TIME, 'yyyy') >= 2022
              GROUP BY T.DOCUMENT_NO,
                       T.COMPANY_ID,
                       TRUNC(T.CREATE_TIME),
                       TL.GOO_ID) A
                   /*SCMDATA.T_INGOOD A
                 INNER JOIN SCMDATA.T_INGOODS B
                    ON A.ING_ID = B.ING_ID
                   AND A.COMPANY_ID = B.COMPANY_ID
                 LEFT JOIN SCMDATA.T_ORDERED C
                    ON C.ORDER_CODE = A.DOCUMENT_NO
                   AND A.COMPANY_ID = C.COMPANY_ID*/
              LEFT JOIN (SELECT Z.*,
                                REGEXP_SUBSTR(Z.FLW_ORDER, '[^,]+', 1, LEVEL) GENDAN
                           FROM SCMDATA.PT_ORDERED Z
                         CONNECT BY PRIOR Z.PT_ORDERED_ID = Z.PT_ORDERED_ID
                                AND LEVEL <=
                                    LENGTH(Z.FLW_ORDER) -
                                    LENGTH(REGEXP_REPLACE(Z.FLW_ORDER,
                                                          ',',
                                                          '')) + 1
                                AND PRIOR DBMS_RANDOM.VALUE IS NOT NULL) D
                 ON D.PRODUCT_GRESS_CODE = A.DOCUMENT_NO
                AND D.COMPANY_ID = A.COMPANY_ID
               INNER JOIN SCMDATA.T_COMMODITY_INFO E ON E.GOO_ID=A.GOO_ID AND E.COMPANY_ID=A.COMPANY_ID
              --WHERE B.AMOUNT > 0
              GROUP BY A.COMPANY_ID, EXTRACT(YEAR FROM A.CREATE_TIME),
                       TO_CHAR(A.CREATE_TIME,'Q'), E.CATEGORY,
                       (CASE  WHEN D.GROUP_NAME IS NULL THEN  '1'  ELSE  D.GROUP_NAME    END),
                       (CASE WHEN D.GENDAN IS NULL OR D.GENDAN = 'ORDERED_ITF' THEN '1' ELSE D.GENDAN END)) Y    ]';


    V_SQL2 := q'[  MERGE INTO SCMDATA.T_RTKPI_QUARTER A
USING (
WITH TEMP_RT AS
 (SELECT Z.*,
         Z.RM_ID || ROW_NUMBER() OVER(PARTITION BY Z.RM_ID ORDER BY 1) RM_ID2,
         Z.EXAMOUNT / (COUNT(Z.RM_ID) OVER(PARTITION BY(Z.RM_ID))) EXGAMOUNT2,
         REGEXP_SUBSTR(Z.SUP_GROUP_NAME, '[^,]+', 1, LEVEL) SUP_GROUP_NAME2
    FROM SCMDATA.T_RETURN_MANAGEMENT Z
   WHERE Z.AUDIT_TIME IS NOT NULL
  CONNECT BY PRIOR RM_ID = RM_ID
         AND LEVEL <= LENGTH(Z.SUP_GROUP_NAME) -
             LENGTH(REGEXP_REPLACE(Z.SUP_GROUP_NAME, ',', '')) + 1
         AND PRIOR DBMS_RANDOM.VALUE IS NOT NULL)

SELECT Y.COMPANY_ID, Y.YEAR, Y.QUARTER,  Y.CATEGORY, Y.GROUP_NAME,
       Y.COUNT_DIMENSION, Y.DIMENSION_SORT,/* Z.ORDER_MONEY INGOOD_MONEY,*/
       Y.RMMONEY SHOP_RT_ORIGINAL_MONEY, X.RMMONEY2 SHOP_RT_MONEY

  FROM (SELECT A.COMPANY_ID, A.YEAR, A.QUARTER, B.CATEGORY,
                (CASE
                  WHEN A.SUP_GROUP_NAME2 IS NULL THEN
                   '1'
                  ELSE
                   A.SUP_GROUP_NAME2
                END) GROUP_NAME, '05' COUNT_DIMENSION,
                (CASE
                  WHEN A.GENDAN2 IS NULL THEN
                   '1'
                  ELSE
                   A.GENDAN2
                END) DIMENSION_SORT, SUM(A.EXGAMOUNT3 * B.PRICE) RMMONEY
           FROM (SELECT Z.RM_ID, Z.COMPANY_ID, Z.YEAR, Z.QUARTER, Z.ACCESS_TIME,
                         Z.GOO_ID, Z.EXAMOUNT, Z.SUP_GROUP_NAME, Z.AUDIT_TIME,
                         Z.SUP_GROUP_NAME2,
                         Z.EXGAMOUNT2 / NVL((REGEXP_COUNT(Z.MERCHER_ID, ',') + 1),1) EXGAMOUNT3,
                         REGEXP_SUBSTR(Z.MERCHER_ID, '[^,]+', 1, LEVEL) GENDAN2
                    FROM TEMP_RT Z

                  CONNECT BY PRIOR Z.RM_ID2 = Z.RM_ID2
                         AND LEVEL <=
                             LENGTH(Z.MERCHER_ID) -
                             LENGTH(REGEXP_REPLACE(Z.MERCHER_ID, ',', '')) + 1
                         AND PRIOR DBMS_RANDOM.VALUE IS NOT NULL) A
          INNER JOIN SCMDATA.T_COMMODITY_INFO B
             ON A.GOO_ID = B.GOO_ID
            AND A.COMPANY_ID = B.COMPANY_ID
          WHERE A.AUDIT_TIME IS NOT NULL
          GROUP BY A.COMPANY_ID, A.YEAR, A.QUARTER, B.CATEGORY,
                   A.SUP_GROUP_NAME2, A.GENDAN2) Y

  LEFT JOIN (SELECT A.COMPANY_ID, A.YEAR, A.QUARTER,
                    B.CATEGORY,
                    (CASE
                      WHEN A.SUP_GROUP_NAME2 IS NULL THEN
                       '1'
                      ELSE
                       A.SUP_GROUP_NAME2
                    END) GROUP_NAME, '05' COUNT_DIMENSION,
                    (CASE
                      WHEN A.GENDAN2 IS NULL THEN
                       '1'
                      ELSE
                       A.GENDAN2
                    END) DIMENSION_SORT, SUM(A.EXGAMOUNT3 * B.PRICE) RMMONEY2
               FROM (SELECT Z.RM_ID, Z.COMPANY_ID, Z.YEAR, Z.QUARTER,
                             Z.ACCESS_TIME, Z.GOO_ID, Z.EXAMOUNT,
                             Z.SUP_GROUP_NAME, Z.AUDIT_TIME, Z.CAUSE_DETAIL_ID,
                             Z.FIRST_DEPT_ID, Z.SUP_GROUP_NAME2,
                             Z.SECOND_DEPT_ID,
                             Z.EXGAMOUNT2 /
                              NVL((REGEXP_COUNT(Z.MERCHER_ID, ',') + 1),1) EXGAMOUNT3,
                             REGEXP_SUBSTR(Z.MERCHER_ID, '[^,]+', 1, LEVEL) GENDAN2
                        FROM TEMP_RT Z

                      CONNECT BY PRIOR Z.RM_ID2 = Z.RM_ID2
                             AND LEVEL <=
                                 LENGTH(Z.MERCHER_ID) -
                                 LENGTH(REGEXP_REPLACE(Z.MERCHER_ID, ',', '')) + 1
                             AND PRIOR DBMS_RANDOM.VALUE IS NOT NULL) A
              INNER JOIN SCMDATA.T_COMMODITY_INFO B
                 ON A.GOO_ID = B.GOO_ID
                AND A.COMPANY_ID = B.COMPANY_ID
               LEFT JOIN SCMDATA.T_ABNORMAL_DTL_CONFIG C
                 ON A.CAUSE_DETAIL_ID = C.ABNORMAL_DTL_CONFIG_ID
                AND A.COMPANY_ID = C.COMPANY_ID
                AND C.ANOMALY_CLASSIFICATION = 'AC_QUALITY'
              INNER JOIN SCMDATA.SYS_COMPANY_DEPT D
                 ON D.COMPANY_DEPT_ID = A.FIRST_DEPT_ID
              WHERE A.AUDIT_TIME IS NOT NULL
                AND C.CAUSE_CLASSIFICATION <> '银饰氧化问题'
                AND C.PROBLEM_CLASSIFICATION <> '非质量问题'
                AND D.DEPT_NAME = '供应链管理部'
                AND INSTR(A.SECOND_DEPT_ID,
                          'b550778b4f2d36b4e0533c281caca074') > 0
              GROUP BY A.COMPANY_ID, A.YEAR, A.QUARTER, B.CATEGORY,
                       A.SUP_GROUP_NAME2, A.GENDAN2) X
    ON X.COMPANY_ID = Y.COMPANY_ID
   AND X.YEAR = Y.YEAR
   AND X.QUARTER = Y.QUARTER
   AND X.CATEGORY = Y.CATEGORY
   AND X.GROUP_NAME = Y.GROUP_NAME
   AND X.COUNT_DIMENSION = Y.COUNT_DIMENSION
   AND X.DIMENSION_SORT = Y.DIMENSION_SORT
  /*LEFT JOIN (SELECT A.COMPANY_ID, EXTRACT(YEAR FROM A.CREATE_TIME) YEAR,
                    TO_CHAR(A.CREATE_TIME,'Q') QUARTER,
                    D.CATEGORY,
                    (CASE
                      WHEN D.GROUP_NAME IS NULL THEN
                       '1'
                      ELSE
                       D.GROUP_NAME
                    END) GROUP_NAME, '05' COUNT_DIMENSION,
                    (CASE
                      WHEN D.GENDAN IS NULL THEN
                       '1'
                      ELSE
                       D.GENDAN
                    END) DIMENSION_SORT,
                    SUM(CASE
                          WHEN REGEXP_COUNT(D.FLW_ORDER, ',') > 0 THEN
                           B.AMOUNT / NVL((REGEXP_COUNT(D.FLW_ORDER, ',') + 1),1) *
                           E.PRICE
                          ELSE
                           B.AMOUNT * E.PRICE
                        END) ORDER_MONEY
               FROM SCMDATA.T_INGOOD A
              INNER JOIN SCMDATA.T_INGOODS B
                 ON A.ING_ID = B.ING_ID
                AND A.COMPANY_ID = B.COMPANY_ID
              INNER JOIN SCMDATA.T_ORDERED C
                 ON C.ORDER_CODE = A.DOCUMENT_NO
                AND A.COMPANY_ID = C.COMPANY_ID
              INNER JOIN (SELECT Z.*,
                                REGEXP_SUBSTR(Z.FLW_ORDER, '[^,]+', 1, LEVEL) GENDAN
                           FROM SCMDATA.PT_ORDERED Z
                         CONNECT BY PRIOR Z.PT_ORDERED_ID = Z.PT_ORDERED_ID
                                AND LEVEL <=
                                    LENGTH(Z.FLW_ORDER) -
                                    LENGTH(REGEXP_REPLACE(Z.FLW_ORDER,
                                                          ',',
                                                          '')) + 1
                                AND PRIOR DBMS_RANDOM.VALUE IS NOT NULL) D
                 ON D.ORDER_ID = C.ORDER_ID
                AND D.COMPANY_ID = C.COMPANY_ID
               INNER JOIN SCMDATA.T_COMMODITY_INFO E ON E.GOO_ID=B.GOO_ID AND E.COMPANY_ID=B.COMPANY_ID
              WHERE B.AMOUNT > 0
              GROUP BY A.COMPANY_ID, EXTRACT(YEAR FROM A.CREATE_TIME),
                       TO_CHAR(A.CREATE_TIME,'Q'), D.CATEGORY,
                       D.GROUP_NAME, D.GENDAN) Z
    ON Z.COMPANY_ID = Y.COMPANY_ID
   AND Z.YEAR = Y.YEAR
   AND Z.QUARTER = Y.QUARTER
   AND Z.CATEGORY = Y.CATEGORY
   AND Z.GROUP_NAME = Y.GROUP_NAME
   AND Z.COUNT_DIMENSION = Y.COUNT_DIMENSION
   AND Z.DIMENSION_SORT = Y.DIMENSION_SORT*/ ]';
   IF P_TYPE = 0 THEN
      --进货
      V_EXSQL1 := V_SQL1||V_WH_SQL2||V_U_SQL1||V_I_SQL1;
      --退货
      V_EXSQL2 := V_SQL2 || V_WH_SQL2 || V_U_SQL2 || V_I_SQL2;


    ELSIF P_TYPE = 1 THEN
      --进货
      V_EXSQL1 := V_SQL1||V_WM_SQL1||V_U_SQL1||V_I_SQL1;
      --退货
      V_EXSQL2 := V_SQL2 || V_WM_SQL1 || V_U_SQL2 || V_I_SQL2;
    END IF;
     EXECUTE IMMEDIATE V_EXSQL2;
     EXECUTE IMMEDIATE V_EXSQL1;
    --dbms_output.put_line(V_EXSQL1);
    --dbms_output.put_line(V_EXSQL2);

    -- 06跟单主管
    V_SQL1:=q'[MERGE INTO SCMDATA.T_RTKPI_QUARTER A
USING ( SELECT Y.COMPANY_ID, Y.YEAR, Y.QUARTER,  Y.CATEGORY,
         Y.GROUP_NAME, Y.COUNT_DIMENSION, Y.DIMENSION_SORT,
         Y.ORDER_MONEY INGOOD_MONEY
    FROM (SELECT A.COMPANY_ID, EXTRACT(YEAR FROM A.CREATE_TIME) YEAR,
                      TO_CHAR(A.CREATE_TIME,'Q') QUARTER,
                      E.CATEGORY,
                      (CASE WHEN D.GROUP_NAME IS NULL THEN '1' ELSE D.GROUP_NAME END) GROUP_NAME,
                       '06' COUNT_DIMENSION,
                      (CASE WHEN D.GENDANZG IS NULL THEN '1' ELSE D.GENDANZG END) DIMENSION_SORT,
                      SUM(CASE
                            WHEN REGEXP_COUNT(D.FLW_ORDER_MANAGER, ',') > 0 THEN
                             A.AMOUNT /
                             NVL((REGEXP_COUNT(D.FLW_ORDER_MANAGER, ',') + 1),1) *
                             E.PRICE
                            ELSE
                             A.AMOUNT * E.PRICE
                          END) ORDER_MONEY
                 FROM (SELECT T.DOCUMENT_NO,
                    T.COMPANY_ID,
                    TRUNC(T.CREATE_TIME) CREATE_TIME,
                    SUM(TL.AMOUNT) AMOUNT,
                    TL.GOO_ID
               FROM SCMDATA.T_INGOOD T
              INNER JOIN (SELECT TI.ING_ID,
                                TI.COMPANY_ID,
                                TI.GOO_ID,
                                TI.AMOUNT
                           FROM SCMDATA.T_INGOODS TI
                          WHERE TI.AMOUNT > 0) TL
                 ON TL.ING_ID = T.ING_ID
                AND TL.COMPANY_ID = T.COMPANY_ID
              WHERE TO_CHAR(T.CREATE_TIME, 'yyyy') >= 2022
              GROUP BY T.DOCUMENT_NO,
                       T.COMPANY_ID,
                       TRUNC(T.CREATE_TIME),
                       TL.GOO_ID) A
                   /*SCMDATA.T_INGOOD A
                 INNER JOIN SCMDATA.T_INGOODS B
                    ON A.ING_ID = B.ING_ID
                   AND A.COMPANY_ID = B.COMPANY_ID
                 LEFT JOIN SCMDATA.T_ORDERED C
                    ON C.ORDER_CODE = A.DOCUMENT_NO
                   AND A.COMPANY_ID = C.COMPANY_ID*/
                LEFT JOIN (SELECT Z.*,
                                  REGEXP_SUBSTR(Z.FLW_ORDER_MANAGER,
                                                 '[^,]+',
                                                 1,
                                                 LEVEL) GENDANZG
                             FROM SCMDATA.PT_ORDERED Z
                           CONNECT BY PRIOR Z.PT_ORDERED_ID = Z.PT_ORDERED_ID
                                  AND LEVEL <=
                                      LENGTH(Z.FLW_ORDER_MANAGER) -
                                      LENGTH(REGEXP_REPLACE(Z.FLW_ORDER_MANAGER,
                                                            ',',
                                                            '')) + 1
                                  AND PRIOR DBMS_RANDOM.VALUE IS NOT NULL) D
                   ON D.PRODUCT_GRESS_CODE = A.DOCUMENT_NO
                  AND D.COMPANY_ID = A.COMPANY_ID
                 INNER JOIN SCMDATA.T_COMMODITY_INFO E ON E.GOO_ID=A.GOO_ID AND E.COMPANY_ID=A.COMPANY_ID
                --WHERE B.AMOUNT > 0
                GROUP BY A.COMPANY_ID, EXTRACT(YEAR FROM A.CREATE_TIME),
                         TO_CHAR(A.CREATE_TIME,'Q'), E.CATEGORY,
                         D.GROUP_NAME, D.GENDANZG) Y ]';

    V_SQL2 := q'[MERGE INTO SCMDATA.T_RTKPI_QUARTER A
USING (
  WITH TEMP_RT AS
   (SELECT Z.*,
           Z.RM_ID || ROW_NUMBER() OVER(PARTITION BY Z.RM_ID ORDER BY 1) RM_ID2,
           Z.EXAMOUNT / (COUNT(Z.RM_ID) OVER(PARTITION BY(Z.RM_ID))) EXGAMOUNT2,
           REGEXP_SUBSTR(Z.SUP_GROUP_NAME, '[^,]+', 1, LEVEL) SUP_GROUP_NAME2
      FROM SCMDATA.T_RETURN_MANAGEMENT Z
     WHERE Z.AUDIT_TIME IS NOT NULL
    CONNECT BY PRIOR RM_ID = RM_ID
           AND LEVEL <=
               LENGTH(Z.SUP_GROUP_NAME) -
               LENGTH(REGEXP_REPLACE(Z.SUP_GROUP_NAME, ',', '')) + 1
           AND PRIOR DBMS_RANDOM.VALUE IS NOT NULL)
  SELECT Y.COMPANY_ID, Y.YEAR, Y.QUARTER,  Y.CATEGORY,
         Y.GROUP_NAME, Y.COUNT_DIMENSION, Y.DIMENSION_SORT,
         /*Z.ORDER_MONEY INGOOD_MONEY,*/ Y.RMMONEY SHOP_RT_ORIGINAL_MONEY,
         X.RMMONEY2 SHOP_RT_MONEY

    FROM (SELECT A.COMPANY_ID, A.YEAR, A.QUARTER, B.CATEGORY,
                  (CASE WHEN A.SUP_GROUP_NAME2 IS NULL THEN  '1'  ELSE  A.SUP_GROUP_NAME2  END) GROUP_NAME,
                   '06' COUNT_DIMENSION,
                  (CASE WHEN A.GENDANZG2 IS NULL THEN '1' ELSE A.GENDANZG2 END) DIMENSION_SORT,
                  SUM(A.EXGAMOUNT3 * B.PRICE) RMMONEY
             FROM (SELECT Z.RM_ID, Z.COMPANY_ID, Z.YEAR, Z.QUARTER, Z.ACCESS_TIME,
                           Z.GOO_ID, Z.EXAMOUNT, Z.SUP_GROUP_NAME, Z.AUDIT_TIME,Z.SUP_GROUP_NAME2,
                           Z.EXGAMOUNT2 /
                            NVL((REGEXP_COUNT(Z.MERCHER_DIRECTOR_ID, ',') + 1),1) EXGAMOUNT3,
                           REGEXP_SUBSTR(Z.MERCHER_DIRECTOR_ID,
                                          '[^,]+',
                                          1,
                                          LEVEL) GENDANZG2
                      FROM TEMP_RT Z

                    CONNECT BY PRIOR Z.RM_ID2 = Z.RM_ID2
                           AND LEVEL <= LENGTH(Z.MERCHER_DIRECTOR_ID) -
                               LENGTH(REGEXP_REPLACE(Z.MERCHER_DIRECTOR_ID, ',','')) + 1
                           AND PRIOR DBMS_RANDOM.VALUE IS NOT NULL) A
            INNER JOIN SCMDATA.T_COMMODITY_INFO B
               ON A.GOO_ID = B.GOO_ID
              AND A.COMPANY_ID = B.COMPANY_ID
            WHERE A.AUDIT_TIME IS NOT NULL
            GROUP BY A.COMPANY_ID, A.YEAR, A.QUARTER, B.CATEGORY,
                     A.SUP_GROUP_NAME2, A.GENDANZG2) Y

    LEFT JOIN (SELECT A.COMPANY_ID, A.YEAR, A.QUARTER,
                      B.CATEGORY,
                      (CASE WHEN A.SUP_GROUP_NAME2 IS NULL THEN '1'ELSE A.SUP_GROUP_NAME2 END) GROUP_NAME,
                       '06' COUNT_DIMENSION,
                      (CASE WHEN A.GENDANZG2 IS NULL THEN '1' ELSE A.GENDANZG2 END) DIMENSION_SORT,
                      SUM(A.EXGAMOUNT3 * B.PRICE) RMMONEY2
                 FROM (SELECT Z.RM_ID, Z.COMPANY_ID, Z.YEAR, Z.QUARTER,
                               Z.ACCESS_TIME, Z.GOO_ID, Z.EXAMOUNT,
                               Z.SUP_GROUP_NAME, Z.AUDIT_TIME,
                               Z.CAUSE_DETAIL_ID, Z.FIRST_DEPT_ID,Z.SUP_GROUP_NAME2,
                               Z.SECOND_DEPT_ID,
                               Z.EXGAMOUNT2 /
                                NVL((REGEXP_COUNT(Z.MERCHER_DIRECTOR_ID, ',') + 1),1) EXGAMOUNT3,
                               REGEXP_SUBSTR(Z.MERCHER_DIRECTOR_ID, '[^,]+', 1, LEVEL) GENDANZG2
                          FROM TEMP_RT Z

                        CONNECT BY PRIOR Z.RM_ID2 = Z.RM_ID2
                               AND LEVEL <=
                                   LENGTH(Z.MERCHER_DIRECTOR_ID) -
                                   LENGTH(REGEXP_REPLACE(Z.MERCHER_DIRECTOR_ID, ',', '')) + 1
                               AND PRIOR DBMS_RANDOM.VALUE IS NOT NULL) A
                INNER JOIN SCMDATA.T_COMMODITY_INFO B
                   ON A.GOO_ID = B.GOO_ID
                  AND A.COMPANY_ID = B.COMPANY_ID
                 LEFT JOIN SCMDATA.T_ABNORMAL_DTL_CONFIG C
                   ON A.CAUSE_DETAIL_ID = C.ABNORMAL_DTL_CONFIG_ID
                  AND A.COMPANY_ID = C.COMPANY_ID
                  AND C.ANOMALY_CLASSIFICATION = 'AC_QUALITY'
                INNER JOIN SCMDATA.SYS_COMPANY_DEPT D
                   ON D.COMPANY_DEPT_ID = A.FIRST_DEPT_ID
                WHERE A.AUDIT_TIME IS NOT NULL
                  AND C.CAUSE_CLASSIFICATION <> '银饰氧化问题'
                  AND C.PROBLEM_CLASSIFICATION <> '非质量问题'
                  AND D.DEPT_NAME = '供应链管理部'
                  AND INSTR(A.SECOND_DEPT_ID,
                            'b550778b4f2d36b4e0533c281caca074') > 0
                GROUP BY A.COMPANY_ID, A.YEAR, A.QUARTER, B.CATEGORY,
                         A.SUP_GROUP_NAME2, A.GENDANZG2) X
      ON X.COMPANY_ID = Y.COMPANY_ID
     AND X.YEAR = Y.YEAR
     AND X.QUARTER = Y.QUARTER
     AND X.CATEGORY = Y.CATEGORY
     AND X.GROUP_NAME = Y.GROUP_NAME
     AND X.COUNT_DIMENSION = Y.COUNT_DIMENSION
     AND X.DIMENSION_SORT = Y.DIMENSION_SORT
    /*LEFT JOIN (SELECT A.COMPANY_ID, EXTRACT(YEAR FROM A.CREATE_TIME) YEAR,
                      TO_CHAR(A.CREATE_TIME,'Q') QUARTER,
                      D.CATEGORY,
                      (CASE WHEN D.GROUP_NAME IS NULL THEN '1' ELSE D.GROUP_NAME END) GROUP_NAME,
                       '06' COUNT_DIMENSION,
                      (CASE WHEN D.GENDANZG IS NULL THEN '1' ELSE D.GENDANZG END) DIMENSION_SORT,
                      SUM(CASE
                            WHEN REGEXP_COUNT(D.FLW_ORDER_MANAGER, ',') > 0 THEN
                             B.AMOUNT /
                             NVL((REGEXP_COUNT(D.FLW_ORDER_MANAGER, ',') + 1),1) *
                             E.PRICE
                            ELSE
                             B.AMOUNT * E.PRICE
                          END) ORDER_MONEY
                 FROM SCMDATA.T_INGOOD A
                INNER JOIN SCMDATA.T_INGOODS B
                   ON A.ING_ID = B.ING_ID
                  AND A.COMPANY_ID = B.COMPANY_ID
                INNER JOIN SCMDATA.T_ORDERED C
                   ON C.ORDER_CODE = A.DOCUMENT_NO
                  AND A.COMPANY_ID = C.COMPANY_ID
                INNER JOIN (SELECT Z.*,
                                  REGEXP_SUBSTR(Z.FLW_ORDER_MANAGER,
                                                 '[^,]+',
                                                 1,
                                                 LEVEL) GENDANZG
                             FROM SCMDATA.PT_ORDERED Z
                           CONNECT BY PRIOR Z.PT_ORDERED_ID = Z.PT_ORDERED_ID
                                  AND LEVEL <=
                                      LENGTH(Z.FLW_ORDER_MANAGER) -
                                      LENGTH(REGEXP_REPLACE(Z.FLW_ORDER_MANAGER,
                                                            ',',
                                                            '')) + 1
                                  AND PRIOR DBMS_RANDOM.VALUE IS NOT NULL) D
                   ON D.ORDER_ID = C.ORDER_ID
                  AND D.COMPANY_ID = C.COMPANY_ID
                 INNER JOIN SCMDATA.T_COMMODITY_INFO E ON E.GOO_ID=B.GOO_ID AND E.COMPANY_ID=B.COMPANY_ID
                WHERE B.AMOUNT > 0
                GROUP BY A.COMPANY_ID, EXTRACT(YEAR FROM A.CREATE_TIME),
                         TO_CHAR(A.CREATE_TIME,'Q'), D.CATEGORY,
                         D.GROUP_NAME, D.GENDANZG) Z
      ON Z.COMPANY_ID = Y.COMPANY_ID
     AND Z.YEAR = Y.YEAR
     AND Z.QUARTER = Y.QUARTER
     AND Z.CATEGORY = Y.CATEGORY
     AND Z.GROUP_NAME = Y.GROUP_NAME
     AND Z.COUNT_DIMENSION = Y.COUNT_DIMENSION
     AND Z.DIMENSION_SORT = Y.DIMENSION_SORT*/  ]';
    IF P_TYPE = 0 THEN
      --进货
      V_EXSQL1 := V_SQL1||V_WH_SQL2||V_U_SQL1||V_I_SQL1;
      --退货
      V_EXSQL2 := V_SQL2 || V_WH_SQL2 || V_U_SQL2 || V_I_SQL2;


    ELSIF P_TYPE = 1 THEN
      --进货
      V_EXSQL1 := V_SQL1||V_WM_SQL1||V_U_SQL1||V_I_SQL1;
      --退货
      V_EXSQL2 := V_SQL2 || V_WM_SQL1 || V_U_SQL2 || V_I_SQL2;
    END IF;
    EXECUTE IMMEDIATE V_EXSQL2;
     EXECUTE IMMEDIATE V_EXSQL1;
    --dbms_output.put_line(V_EXSQL1);
    --dbms_output.put_line(V_EXSQL2);

    --07qc
    V_SQL1 :=q'[MERGE INTO SCMDATA.T_RTKPI_QUARTER A
USING (WITH TEMP_PTORDER AS
 (SELECT T1.PT_ORDERED_ID, T1.GOO_ID_PR,
         T1.PT_ORDERED_ID || ROW_NUMBER() OVER(PARTITION BY T1.PT_ORDERED_ID ORDER BY 1) ID2,
         T1.COMPANY_ID, T1.PRODUCT_GRESS_CODE, T1.ORDER_MONEY,
         (T1.ORDER_MONEY / COUNT(T1.PRODUCT_GRESS_CODE)
           OVER(PARTITION BY T1.PRODUCT_GRESS_CODE)) SUM1,
         REGEXP_SUBSTR(T1.QC, '[^,]+', 1, LEVEL) QC2
    FROM SCMDATA.PT_ORDERED T1
   WHERE T1.QC IS NOT NULL
  CONNECT BY PRIOR T1.PT_ORDERED_ID = T1.PT_ORDERED_ID
         AND LEVEL <=
             LENGTH(T1.QC) - LENGTH(REGEXP_REPLACE(T1.QC, ',', '')) + 1
         AND PRIOR DBMS_RANDOM.VALUE IS NOT NULL)
SELECT Y.COMPANY_ID, Y.YEAR, Y.QUARTER, Y.CATEGORY, Y.GROUP_NAME,
       Y.COUNT_DIMENSION, Y.DIMENSION_SORT, Y.ORDER_MONEY INGOOD_MONEY
  FROM   (SELECT A.COMPANY_ID, EXTRACT(YEAR FROM A.CREATE_TIME) YEAR,
                    TO_CHAR(A.CREATE_TIME,'Q') QUARTER,
                    E.CATEGORY,
                    (CASE  WHEN D.GROUP_NAME IS NULL THEN '1'  ELSE  D.GROUP_NAME  END) GROUP_NAME,
                     '07' COUNT_DIMENSION,
                    (CASE WHEN D.QC2 IS NULL THEN '1' ELSE  D.QC2  END) DIMENSION_SORT,
                    SUM(CASE
                          WHEN REGEXP_COUNT(D.QC, ',') > 0 THEN
                           A.AMOUNT / NVL((REGEXP_COUNT(D.QC, ',') + 1),1) *
                           E.PRICE
                          ELSE
                           A.AMOUNT * E.PRICE
                        END) ORDER_MONEY
               FROM (SELECT T.DOCUMENT_NO,
                    T.COMPANY_ID,
                    TRUNC(T.CREATE_TIME) CREATE_TIME,
                    SUM(TL.AMOUNT) AMOUNT,
                    TL.GOO_ID
               FROM SCMDATA.T_INGOOD T
              INNER JOIN (SELECT TI.ING_ID,
                                TI.COMPANY_ID,
                                TI.GOO_ID,
                                TI.AMOUNT
                           FROM SCMDATA.T_INGOODS TI
                          WHERE TI.AMOUNT > 0) TL
                 ON TL.ING_ID = T.ING_ID
                AND TL.COMPANY_ID = T.COMPANY_ID
              WHERE TO_CHAR(T.CREATE_TIME, 'yyyy') >= 2022
              GROUP BY T.DOCUMENT_NO,
                       T.COMPANY_ID,
                       TRUNC(T.CREATE_TIME),
                       TL.GOO_ID) A
                   /*SCMDATA.T_INGOOD A
                 INNER JOIN SCMDATA.T_INGOODS B
                    ON A.ING_ID = B.ING_ID
                   AND A.COMPANY_ID = B.COMPANY_ID
                 LEFT JOIN SCMDATA.T_ORDERED C
                    ON C.ORDER_CODE = A.DOCUMENT_NO
                   AND A.COMPANY_ID = C.COMPANY_ID*/
              LEFT JOIN (SELECT Z.*,
                                REGEXP_SUBSTR(Z.QC, '[^,]+', 1, LEVEL) QC2
                           FROM SCMDATA.PT_ORDERED Z
                         CONNECT BY PRIOR Z.PT_ORDERED_ID = Z.PT_ORDERED_ID
                                AND LEVEL <=
                                    LENGTH(Z.QC) -
                                    LENGTH(REGEXP_REPLACE(Z.QC, ',', '')) + 1
                                AND PRIOR DBMS_RANDOM.VALUE IS NOT NULL) D
                 ON D.PRODUCT_GRESS_CODE  = A.DOCUMENT_NO
                AND D.COMPANY_ID = A.COMPANY_ID
               INNER JOIN SCMDATA.T_COMMODITY_INFO E ON E.GOO_ID=A.GOO_ID AND E.COMPANY_ID=A.COMPANY_ID
              --WHERE B.AMOUNT > 0
              GROUP BY A.COMPANY_ID, EXTRACT(YEAR FROM A.CREATE_TIME),
                      TO_CHAR(A.CREATE_TIME,'Q'), E.CATEGORY,
                       D.GROUP_NAME, D.QC2) Y
    ]';

    V_SQL2 := q'[  MERGE INTO SCMDATA.T_RTKPI_QUARTER A
USING (
 WITH TEMP_RT AS
 (SELECT Z.RM_ID, Z.COMPANY_ID, Z.YEAR, Z.QUARTER, Z.ACCESS_TIME, Z.GOO_ID,Z.SUPPLIER_CODE,
         Z.EXAMOUNT, Z.QC_ID,
         Z.RM_ID || ROW_NUMBER() OVER(PARTITION BY Z.RM_ID ORDER BY 1) RM_ID2,
         Z.EXAMOUNT / (COUNT(Z.RM_ID) OVER(PARTITION BY(Z.RM_ID))) EXGAMOUNT2,
         REGEXP_SUBSTR(Z.SUP_GROUP_NAME, '[^,]+', 1, LEVEL) SUP_GROUP_NAME2
    FROM SCMDATA.T_RETURN_MANAGEMENT Z
   WHERE Z.AUDIT_TIME IS NOT NULL
  CONNECT BY PRIOR RM_ID = RM_ID
         AND LEVEL <= LENGTH(Z.SUP_GROUP_NAME) -
             LENGTH(REGEXP_REPLACE(Z.SUP_GROUP_NAME, ',', '')) + 1
         AND PRIOR DBMS_RANDOM.VALUE IS NOT NULL),
TEMP_RT2 AS
 (SELECT Z.RM_ID, Z.COMPANY_ID, Z.YEAR, Z.QUARTER, Z.ACCESS_TIME, Z.GOO_ID,Z.SUPPLIER_CODE,
         Z.EXAMOUNT, Z.QC_ID,
         Z.RM_ID || ROW_NUMBER() OVER(PARTITION BY Z.RM_ID ORDER BY 1) RM_ID2,
         Z.EXAMOUNT / (COUNT(Z.RM_ID) OVER(PARTITION BY(Z.RM_ID))) EXGAMOUNT2,
         REGEXP_SUBSTR(Z.SUP_GROUP_NAME, '[^,]+', 1, LEVEL) SUP_GROUP_NAME2
    FROM SCMDATA.T_RETURN_MANAGEMENT Z
    LEFT JOIN SCMDATA.T_ABNORMAL_DTL_CONFIG C
      ON Z.CAUSE_DETAIL_ID = C.ABNORMAL_DTL_CONFIG_ID
     AND Z.COMPANY_ID = C.COMPANY_ID
     AND C.ANOMALY_CLASSIFICATION = 'AC_QUALITY'
   INNER JOIN SCMDATA.SYS_COMPANY_DEPT D
      ON D.COMPANY_DEPT_ID = Z.FIRST_DEPT_ID
   WHERE Z.AUDIT_TIME IS NOT NULL
     AND C.CAUSE_CLASSIFICATION <> '银饰氧化问题'
     AND C.PROBLEM_CLASSIFICATION <> '非质量问题'
     AND D.DEPT_NAME = '供应链管理部'
     AND INSTR(Z.SECOND_DEPT_ID, 'b550778b4f2d36b4e0533c281caca074') > 0
  CONNECT BY PRIOR RM_ID = RM_ID
         AND LEVEL <= LENGTH(Z.SUP_GROUP_NAME) -
             LENGTH(REGEXP_REPLACE(Z.SUP_GROUP_NAME, ',', '')) + 1
         AND PRIOR DBMS_RANDOM.VALUE IS NOT NULL),
TEMP_PTORDER AS
 (SELECT T1.PT_ORDERED_ID, T1.GOO_ID_PR,T1.ORDER_ID,T1.DELIVERY_AMOUNT,
         T1.PT_ORDERED_ID || ROW_NUMBER() OVER(PARTITION BY T1.PT_ORDERED_ID ORDER BY 1) ID2,
         T1.COMPANY_ID, T1.PRODUCT_GRESS_CODE, T1.ORDER_MONEY,
         (T1.ORDER_MONEY / COUNT(T1.PRODUCT_GRESS_CODE)
           OVER(PARTITION BY T1.PRODUCT_GRESS_CODE)) SUM1,
         REGEXP_SUBSTR(T1.QC, '[^,]+', 1, LEVEL) QC2
    FROM SCMDATA.PT_ORDERED T1
   WHERE T1.QC IS NOT NULL
  CONNECT BY PRIOR T1.PT_ORDERED_ID = T1.PT_ORDERED_ID
         AND LEVEL <=
             LENGTH(T1.QC) - LENGTH(REGEXP_REPLACE(T1.QC, ',', '')) + 1
         AND PRIOR DBMS_RANDOM.VALUE IS NOT NULL)
SELECT Y.COMPANY_ID, Y.YEAR, Y.QUARTER, Y.CATEGORY, Y.GROUP_NAME,
       '07' COUNT_DIMENSION, Y.DIMENSION_SORT DIMENSION_SORT,
       Y.RMMONEY SHOP_RT_ORIGINAL_MONEY, X.SHOP_RT_MONEY SHOP_RT_MONEY /*, Z.ORDER_MONEY INGOOD_MONEY*/
  FROM (SELECT A.COMPANY_ID, A.YEAR, A.QUARTER, B.CATEGORY,
                (CASE
                  WHEN A.SUP_GROUP_NAME2 IS NULL THEN
                   '1'
                  ELSE
                   A.SUP_GROUP_NAME2
                END) GROUP_NAME, '07' COUNT_DIMENSION,
                (CASE
                  WHEN A.QC2 IS NULL THEN
                   '1'
                  ELSE
                   A.QC2
                END) DIMENSION_SORT, SUM(A.EXGAMOUNT3 * B.PRICE) RMMONEY
           FROM (SELECT Z.COMPANY_ID, Z.YEAR, Z.QUARTER, Z.ACCESS_TIME,
                         Z.GOO_ID, Z.SUP_GROUP_NAME2,
                         Z.EXGAMOUNT2 /
                          NVL((REGEXP_COUNT(Z.QC_ID, ',') + 1), 1) EXGAMOUNT3,
                         REGEXP_SUBSTR(Z.QC_ID, '[^,]+', 1, LEVEL) QC2
                    FROM TEMP_RT Z
                   WHERE (EXISTS (SELECT MAX(1)
                                    FROM SCMDATA.T_PLAT_LOG X
                                   INNER JOIN SCMDATA.T_PLAT_LOGS Y
                                      ON X.COMPANY_ID = Y.COMPANY_ID
                                     AND X.LOG_ID = Y.LOG_ID
                                   WHERE X.APPLY_PK_ID = Z.RM_ID
                                     AND Y.OPERATE_FIELD = 'QC_ID'
                                     AND X.ACTION_TYPE = 'UPDATE') OR
                          (NOT EXISTS (SELECT MAX(1)
                                                FROM SCMDATA.T_PLAT_LOG Y
                                               INNER JOIN SCMDATA.T_PLAT_LOGS X
                                                  ON X.COMPANY_ID = Y.COMPANY_ID
                                                 AND X.LOG_ID = Y.LOG_ID
                                               WHERE Y.APPLY_PK_ID = Z.RM_ID
                                                 AND X.OPERATE_FIELD = 'QC_ID'
                                                 AND Y.ACTION_TYPE = 'UPDATE') AND
                           NOT EXISTS
                           (SELECT MAX(1)
                                     FROM TEMP_PTORDER J
                               INNER JOIN SCMDATA.T_ORDERED P ON P.ORDER_ID = J.ORDER_ID AND P.COMPANY_ID = J.COMPANY_ID
                                WHERE    J.GOO_ID_PR = Z.GOO_ID AND P.SUPPLIER_CODE=Z.SUPPLIER_CODE AND J.DELIVERY_AMOUNT >0 AND J.QC2 IS NOT NULL
                               AND J.COMPANY_ID = Z.COMPANY_ID)))
                  CONNECT BY PRIOR Z.RM_ID2 = Z.RM_ID2
                         AND LEVEL <=
                             LENGTH(Z.QC_ID) -
                             LENGTH(REGEXP_REPLACE(Z.QC_ID, ',', '')) + 1
                         AND PRIOR DBMS_RANDOM.VALUE IS NOT NULL
                  UNION ALL
                  SELECT H.COMPANY_ID, H.YEAR, H.QUARTER, H.ACCESS_TIME,
                         H.GOO_ID, H.SUP_GROUP_NAME2,
                         (H.EXGAMOUNT2 *
                          ((SELECT SUM(J.SUM1)
                               FROM TEMP_PTORDER J
                               INNER JOIN SCMDATA.T_ORDERED P ON P.ORDER_ID = J.ORDER_ID AND P.COMPANY_ID = J.COMPANY_ID
                              WHERE J.GOO_ID_PR = H.GOO_ID
                                AND P.SUPPLIER_CODE=H.SUPPLIER_CODE
                                AND J.DELIVERY_AMOUNT >0
                                AND J.COMPANY_ID = H.COMPANY_ID
                                AND J.QC2 = H.QC2) /
                          (SELECT SUM(J.ORDER_MONEY)
                               FROM TEMP_PTORDER J
                               INNER JOIN SCMDATA.T_ORDERED P ON P.ORDER_ID = J.ORDER_ID AND P.COMPANY_ID = J.COMPANY_ID
                              WHERE J.GOO_ID_PR = H.GOO_ID AND J.DELIVERY_AMOUNT >0
                                AND P.SUPPLIER_CODE=H.SUPPLIER_CODE
                                AND H.COMPANY_ID = J.COMPANY_ID
                                AND J.QC2 IS NOT NULL))) EXGAMOUNT3, H.QC2
                    FROM (SELECT Z.*,
                                  REGEXP_SUBSTR(Z.QC_ID, '[^,]+', 1, LEVEL) QC2
                             FROM TEMP_RT Z
                            WHERE NOT EXISTS (SELECT MAX(1)
                                     FROM SCMDATA.T_PLAT_LOG Y
                                    INNER JOIN SCMDATA.T_PLAT_LOGS X
                                       ON X.COMPANY_ID = Y.COMPANY_ID
                                      AND X.LOG_ID = Y.LOG_ID
                                    WHERE Y.APPLY_PK_ID = Z.RM_ID
                                      AND X.OPERATE_FIELD = 'QC_ID'
                                      AND Y.ACTION_TYPE = 'UPDATE')
                              AND EXISTS
                            (SELECT MAX(1)
                                     FROM TEMP_PTORDER J
                               INNER JOIN SCMDATA.T_ORDERED P ON P.ORDER_ID = J.ORDER_ID AND P.COMPANY_ID = J.COMPANY_ID
                              WHERE J.GOO_ID_PR = Z.GOO_ID
                              AND P.SUPPLIER_CODE=Z.SUPPLIER_CODE
                              AND J.QC2 IS NOT NULL AND J.DELIVERY_AMOUNT >0
                                      AND J.COMPANY_ID = Z.COMPANY_ID)
                           CONNECT BY PRIOR Z.RM_ID2 = Z.RM_ID2
                                  AND LEVEL <=
                                      LENGTH(Z.QC_ID) -
                                      LENGTH(REGEXP_REPLACE(Z.QC_ID, ',', '')) + 1
                                  AND PRIOR DBMS_RANDOM.VALUE IS NOT NULL) H) A
          INNER JOIN SCMDATA.T_COMMODITY_INFO B
             ON A.GOO_ID = B.GOO_ID
            AND A.COMPANY_ID = B.COMPANY_ID
          GROUP BY A.COMPANY_ID, A.YEAR, A.QUARTER, B.CATEGORY,
                   A.SUP_GROUP_NAME2,
                   (CASE
                      WHEN A.QC2 IS NULL THEN
                       '1'
                      ELSE
                       A.QC2
                    END)) Y

  LEFT JOIN (SELECT A.COMPANY_ID, A.YEAR, A.QUARTER, B.CATEGORY,
                    (CASE
                      WHEN A.SUP_GROUP_NAME2 IS NULL THEN
                       '1'
                      ELSE
                       A.SUP_GROUP_NAME2
                    END) GROUP_NAME, '07' COUNT_DIMENSION,
                    (CASE
                      WHEN A.QC2 IS NULL THEN
                       '1'
                      ELSE
                       A.QC2
                    END) DIMENSION_SORT,
                    SUM(A.EXGAMOUNT3 * B.PRICE) SHOP_RT_MONEY
               FROM (SELECT Z.COMPANY_ID, Z.YEAR, Z.QUARTER, Z.ACCESS_TIME,
                             Z.GOO_ID, Z.SUP_GROUP_NAME2,
                             Z.EXGAMOUNT2 /
                              NVL((REGEXP_COUNT(Z.QC_ID, ',') + 1), 1) EXGAMOUNT3,
                             REGEXP_SUBSTR(Z.QC_ID, '[^,]+', 1, LEVEL) QC2
                        FROM TEMP_RT2 Z
                       WHERE (EXISTS
                              (SELECT MAX(1)
                                 FROM SCMDATA.T_PLAT_LOG X
                                INNER JOIN SCMDATA.T_PLAT_LOGS Y
                                   ON X.COMPANY_ID = Y.COMPANY_ID
                                  AND X.LOG_ID = Y.LOG_ID
                                WHERE X.APPLY_PK_ID = Z.RM_ID
                                  AND Y.OPERATE_FIELD = 'QC_ID'
                                  AND X.ACTION_TYPE = 'UPDATE') OR
                              (NOT EXISTS
                               (SELECT MAX(1)
                                  FROM SCMDATA.T_PLAT_LOG Y
                                 INNER JOIN SCMDATA.T_PLAT_LOGS X
                                    ON X.COMPANY_ID = Y.COMPANY_ID
                                   AND X.LOG_ID = Y.LOG_ID
                                 WHERE Y.APPLY_PK_ID = Z.RM_ID
                                   AND X.OPERATE_FIELD = 'QC_ID'
                                   AND Y.ACTION_TYPE = 'UPDATE') AND NOT EXISTS
                               (SELECT MAX(1)
                                  FROM TEMP_PTORDER J
                               INNER JOIN SCMDATA.T_ORDERED P ON P.ORDER_ID = J.ORDER_ID AND P.COMPANY_ID = J.COMPANY_ID
                              WHERE J.GOO_ID_PR = Z.GOO_ID
                                 AND P.SUPPLIER_CODE=Z.SUPPLIER_CODE AND J.DELIVERY_AMOUNT >0 AND J.QC2 IS NOT NULL
                                   AND J.COMPANY_ID = Z.COMPANY_ID)))
                      CONNECT BY PRIOR Z.RM_ID2 = Z.RM_ID2
                             AND LEVEL <=
                                 LENGTH(Z.QC_ID) -
                                 LENGTH(REGEXP_REPLACE(Z.QC_ID, ',', '')) + 1
                             AND PRIOR DBMS_RANDOM.VALUE IS NOT NULL
                      UNION ALL
                      SELECT H.COMPANY_ID, H.YEAR, H.QUARTER, H.ACCESS_TIME,
                             H.GOO_ID, H.SUP_GROUP_NAME2,
                             (H.EXGAMOUNT2 *
                              ((SELECT SUM(J.SUM1)
                                   FROM TEMP_PTORDER J INNER JOIN SCMDATA.T_ORDERED P ON P.ORDER_ID = J.ORDER_ID AND P.COMPANY_ID = J.COMPANY_ID
                              WHERE J.GOO_ID_PR  = H.GOO_ID AND P.SUPPLIER_CODE=H.SUPPLIER_CODE
                                    AND J.COMPANY_ID = H.COMPANY_ID
                                    AND J.QC2 = H.QC2) /
                              (SELECT SUM(J.ORDER_MONEY)
                                   FROM TEMP_PTORDER J INNER JOIN SCMDATA.T_ORDERED P ON P.ORDER_ID = J.ORDER_ID AND P.COMPANY_ID = J.COMPANY_ID
                              WHERE J.GOO_ID_PR = H.GOO_ID AND P.SUPPLIER_CODE = H.SUPPLIER_CODE AND J.DELIVERY_AMOUNT >0
                                    AND H.COMPANY_ID = J.COMPANY_ID
                                    AND J.QC2 IS NOT NULL))) EXGAMOUNT3, H.QC2
                        FROM (SELECT Z.*,
                                      REGEXP_SUBSTR(Z.QC_ID, '[^,]+', 1, LEVEL) QC2
                                 FROM TEMP_RT2 Z
                                WHERE NOT EXISTS
                                (SELECT MAX(1)
                                         FROM SCMDATA.T_PLAT_LOG Y
                                        INNER JOIN SCMDATA.T_PLAT_LOGS X
                                           ON X.COMPANY_ID = Y.COMPANY_ID
                                          AND X.LOG_ID = Y.LOG_ID
                                        WHERE Y.APPLY_PK_ID = Z.RM_ID
                                          AND X.OPERATE_FIELD = 'QC_ID'
                                          AND Y.ACTION_TYPE = 'UPDATE')
                                  AND EXISTS
                                (SELECT MAX(1)
                                         FROM TEMP_PTORDER J INNER JOIN SCMDATA.T_ORDERED P ON P.ORDER_ID = J.ORDER_ID AND P.COMPANY_ID = J.COMPANY_ID
                              WHERE J.GOO_ID_PR = Z.GOO_ID AND J.DELIVERY_AMOUNT >0 AND J.QC2 IS NOT NULL
                                          AND J.COMPANY_ID = Z.COMPANY_ID)
                               CONNECT BY PRIOR Z.RM_ID2 = Z.RM_ID2
                                      AND LEVEL <=
                                          LENGTH(Z.QC_ID) -
                                          LENGTH(REGEXP_REPLACE(Z.QC_ID, ',', '')) + 1
                                      AND PRIOR DBMS_RANDOM.VALUE IS NOT NULL) H) A
              INNER JOIN SCMDATA.T_COMMODITY_INFO B
                 ON A.GOO_ID = B.GOO_ID
                AND A.COMPANY_ID = B.COMPANY_ID
              GROUP BY A.COMPANY_ID, A.YEAR, A.QUARTER, B.CATEGORY,
                       A.SUP_GROUP_NAME2,
                       (CASE
                          WHEN A.QC2 IS NULL THEN
                           '1'
                          ELSE
                           A.QC2
                        END)) X
    ON X.COMPANY_ID = Y.COMPANY_ID
   AND X.YEAR = Y.YEAR
   AND X.QUARTER = Y.QUARTER
   AND X.CATEGORY = Y.CATEGORY
   AND X.GROUP_NAME = Y.GROUP_NAME
   AND X.COUNT_DIMENSION = Y.COUNT_DIMENSION
   AND X.DIMENSION_SORT = Y.DIMENSION_SORT
 /* LEFT JOIN (SELECT A.COMPANY_ID, EXTRACT(YEAR FROM A.CREATE_TIME) YEAR,
                    TO_CHAR(A.CREATE_TIME,'Q') QUARTER,
                    D.CATEGORY,
                    (CASE  WHEN D.GROUP_NAME IS NULL THEN '1'  ELSE  D.GROUP_NAME  END) GROUP_NAME,
                     '07' COUNT_DIMENSION,
                    (CASE WHEN D.QC2 IS NULL THEN '1' ELSE  D.QC2  END) DIMENSION_SORT,
                    SUM(CASE
                          WHEN REGEXP_COUNT(D.QC, ',') > 0 THEN
                           B.AMOUNT / NVL((REGEXP_COUNT(D.QC, ',') + 1),1) *
                           E.PRICE
                          ELSE
                           B.AMOUNT * E.PRICE
                        END) ORDER_MONEY
               FROM SCMDATA.T_INGOOD A
              INNER JOIN SCMDATA.T_INGOODS B
                 ON A.ING_ID = B.ING_ID
                AND A.COMPANY_ID = B.COMPANY_ID
              INNER JOIN SCMDATA.T_ORDERED C
                 ON C.ORDER_CODE = A.DOCUMENT_NO
                AND A.COMPANY_ID = C.COMPANY_ID
              INNER JOIN (SELECT Z.*,
                                REGEXP_SUBSTR(Z.QC, '[^,]+', 1, LEVEL) QC2
                           FROM SCMDATA.PT_ORDERED Z
                         CONNECT BY PRIOR Z.PT_ORDERED_ID = Z.PT_ORDERED_ID
                                AND LEVEL <=
                                    LENGTH(Z.QC) -
                                    LENGTH(REGEXP_REPLACE(Z.QC, ',', '')) + 1
                                AND PRIOR DBMS_RANDOM.VALUE IS NOT NULL) D
                 ON D.ORDER_ID = C.ORDER_ID
                AND D.COMPANY_ID = C.COMPANY_ID
               INNER JOIN SCMDATA.T_COMMODITY_INFO E ON E.GOO_ID=B.GOO_ID AND E.COMPANY_ID=B.COMPANY_ID
              WHERE B.AMOUNT > 0
              GROUP BY A.COMPANY_ID, EXTRACT(YEAR FROM A.CREATE_TIME),
                      TO_CHAR(A.CREATE_TIME,'Q'), D.CATEGORY,
                       D.GROUP_NAME, D.QC2) Z
    ON Z.COMPANY_ID = Y.COMPANY_ID
   AND Z.YEAR = Y.YEAR
   AND Z.QUARTER = Y.QUARTER
   AND Z.CATEGORY = Y.CATEGORY
   AND Z.GROUP_NAME = Y.GROUP_NAME
   AND Z.COUNT_DIMENSION = Y.COUNT_DIMENSION
   AND Z.DIMENSION_SORT = Y.DIMENSION_SORT */
 ]';
    IF P_TYPE = 0 THEN
      --进货
      V_EXSQL1 := V_SQL1||V_WH_SQL2||V_U_SQL1||V_I_SQL1;
      --退货
      V_EXSQL2 := V_SQL2 || V_WH_SQL2 || V_U_SQL2 || V_I_SQL2;


    ELSIF P_TYPE = 1 THEN
      --进货
      V_EXSQL1 := V_SQL1||V_WM_SQL1||V_U_SQL1||V_I_SQL1;
      --退货
      V_EXSQL2 := V_SQL2 || V_WM_SQL1 || V_U_SQL2 || V_I_SQL2;
    END IF;
    EXECUTE IMMEDIATE V_EXSQL2;
     EXECUTE IMMEDIATE V_EXSQL1;
    --dbms_output.put_line(V_EXSQL1);
    --dbms_output.put_line(V_EXSQL2);

    --qc主管
    V_SQL1:=q'[MERGE INTO SCMDATA.T_RTKPI_QUARTER A
USING (   WITH TEMP_PTORDER AS
 (SELECT T1.PT_ORDERED_ID, T1.GOO_ID_PR,
         T1.PT_ORDERED_ID || ROW_NUMBER() OVER(PARTITION BY T1.PT_ORDERED_ID ORDER BY 1) ID2,
         T1.COMPANY_ID, T1.PRODUCT_GRESS_CODE, T1.ORDER_MONEY,
         (T1.ORDER_MONEY / COUNT(T1.PRODUCT_GRESS_CODE)
           OVER(PARTITION BY T1.PRODUCT_GRESS_CODE)) SUM1,
         REGEXP_SUBSTR(T1.QC_MANAGER, '[^,]+', 1, LEVEL) QCZG2
    FROM SCMDATA.PT_ORDERED T1
   WHERE T1.QC_MANAGER IS NOT NULL
  CONNECT BY PRIOR T1.PT_ORDERED_ID = T1.PT_ORDERED_ID
         AND LEVEL <=
             LENGTH(T1.QC_MANAGER) - LENGTH(REGEXP_REPLACE(T1.QC_MANAGER, ',', '')) + 1
         AND PRIOR DBMS_RANDOM.VALUE IS NOT NULL)

SELECT Y.COMPANY_ID, Y.YEAR, Y.QUARTER,  Y.CATEGORY, Y.GROUP_NAME,
       Y.COUNT_DIMENSION, Y.DIMENSION_SORT, Y.ORDER_MONEY INGOOD_MONEY
    FROM ( SELECT A.COMPANY_ID,
       EXTRACT(YEAR FROM A.CREATE_TIME) YEAR,
       TO_CHAR(A.CREATE_TIME,'Q') QUARTER,
       E.CATEGORY,
       (CASE WHEN D.GROUP_NAME IS NULL THEN  '1'  ELSE D.GROUP_NAME END) GROUP_NAME,
       '08' COUNT_DIMENSION,
       (case when D.QCZG2 is null then '1' else D.QCZG2 end) DIMENSION_SORT,
       SUM(CASE WHEN REGEXP_COUNT(D.QC_MANAGER, ',') > 0 THEN
       A.AMOUNT/NVL((REGEXP_COUNT(D.QC_MANAGER, ',') + 1),1) * E.PRICE ELSE
           A.AMOUNT * E.PRICE END ) ORDER_MONEY
  FROM (SELECT T.DOCUMENT_NO,
                    T.COMPANY_ID,
                    TRUNC(T.CREATE_TIME) CREATE_TIME,
                    SUM(TL.AMOUNT) AMOUNT,
                    TL.GOO_ID
               FROM SCMDATA.T_INGOOD T
              INNER JOIN (SELECT TI.ING_ID,
                                TI.COMPANY_ID,
                                TI.GOO_ID,
                                TI.AMOUNT
                           FROM SCMDATA.T_INGOODS TI
                          WHERE TI.AMOUNT > 0) TL
                 ON TL.ING_ID = T.ING_ID
                AND TL.COMPANY_ID = T.COMPANY_ID
              WHERE TO_CHAR(T.CREATE_TIME, 'yyyy') >= 2022
              GROUP BY T.DOCUMENT_NO,
                       T.COMPANY_ID,
                       TRUNC(T.CREATE_TIME),
                       TL.GOO_ID) A
                   /*SCMDATA.T_INGOOD A
                 INNER JOIN SCMDATA.T_INGOODS B
                    ON A.ING_ID = B.ING_ID
                   AND A.COMPANY_ID = B.COMPANY_ID
                 LEFT JOIN SCMDATA.T_ORDERED C
                    ON C.ORDER_CODE = A.DOCUMENT_NO
                   AND A.COMPANY_ID = C.COMPANY_ID*/
 LEFT JOIN (SELECT Z.*, REGEXP_SUBSTR(Z.QC_MANAGER, '[^,]+', 1, LEVEL) QCZG2
  FROM SCMDATA.PT_ORDERED Z
CONNECT BY PRIOR Z.PT_ORDERED_ID = Z.PT_ORDERED_ID
       AND LEVEL <= LENGTH(Z.QC_MANAGER) -
           LENGTH(REGEXP_REPLACE(Z.QC_MANAGER, ',', '')) + 1
       AND PRIOR DBMS_RANDOM.VALUE IS NOT NULL
) D
    ON D.PRODUCT_GRESS_CODE = A.DOCUMENT_NO
   AND D.COMPANY_ID = A.COMPANY_ID
  INNER JOIN SCMDATA.T_COMMODITY_INFO E ON E.GOO_ID=A.GOO_ID AND E.COMPANY_ID=A.COMPANY_ID
 --WHERE B.AMOUNT > 0
 GROUP BY A.COMPANY_ID,
          EXTRACT(YEAR FROM A.CREATE_TIME),
          TO_CHAR(A.CREATE_TIME,'Q'),
          E.CATEGORY,
          D.GROUP_NAME,
          D.QCZG2) Y   ]';

    V_SQL2 := q'[  MERGE INTO SCMDATA.T_RTKPI_QUARTER A
USING (
   WITH TEMP_RT AS
 (SELECT Z.RM_ID, Z.COMPANY_ID, Z.YEAR, Z.QUARTER, Z.ACCESS_TIME,Z.SUPPLIER_CODE,
         Z.GOO_ID, Z.EXAMOUNT, Z.QC_DIRECTOR_ID,
         Z.RM_ID || ROW_NUMBER() OVER(PARTITION BY Z.RM_ID ORDER BY 1) RM_ID2,
         Z.EXAMOUNT / (COUNT(Z.RM_ID) OVER(PARTITION BY(Z.RM_ID))) EXGAMOUNT2,
         REGEXP_SUBSTR(Z.SUP_GROUP_NAME, '[^,]+', 1, LEVEL) SUP_GROUP_NAME2
    FROM SCMDATA.T_RETURN_MANAGEMENT Z
   WHERE Z.AUDIT_TIME IS NOT NULL
  CONNECT BY PRIOR RM_ID = RM_ID
         AND LEVEL <= LENGTH(Z.SUP_GROUP_NAME) -
             LENGTH(REGEXP_REPLACE(Z.SUP_GROUP_NAME, ',', '')) + 1
         AND PRIOR DBMS_RANDOM.VALUE IS NOT NULL),
 TEMP_RT2 AS
 (SELECT Z.RM_ID, Z.COMPANY_ID, Z.YEAR, Z.QUARTER,  Z.ACCESS_TIME,Z.SUPPLIER_CODE,
         Z.GOO_ID, Z.EXAMOUNT, Z.QC_DIRECTOR_ID,
         Z.RM_ID || ROW_NUMBER() OVER(PARTITION BY Z.RM_ID ORDER BY 1) RM_ID2,
         Z.EXAMOUNT / (COUNT(Z.RM_ID) OVER(PARTITION BY(Z.RM_ID))) EXGAMOUNT2,
         REGEXP_SUBSTR(Z.SUP_GROUP_NAME, '[^,]+', 1, LEVEL) SUP_GROUP_NAME2
    FROM SCMDATA.T_RETURN_MANAGEMENT Z
    LEFT JOIN SCMDATA.T_ABNORMAL_DTL_CONFIG C
      ON Z.CAUSE_DETAIL_ID = C.ABNORMAL_DTL_CONFIG_ID
     AND Z.COMPANY_ID = C.COMPANY_ID
     AND C.ANOMALY_CLASSIFICATION = 'AC_QUALITY'
   INNER JOIN SCMDATA.SYS_COMPANY_DEPT D
      ON D.COMPANY_DEPT_ID = Z.FIRST_DEPT_ID
   WHERE Z.AUDIT_TIME IS NOT NULL
     AND C.CAUSE_CLASSIFICATION <> '银饰氧化问题'
     AND C.PROBLEM_CLASSIFICATION <> '非质量问题'
     AND D.DEPT_NAME = '供应链管理部'
     AND INSTR(Z.SECOND_DEPT_ID, 'b550778b4f2d36b4e0533c281caca074') > 0
  CONNECT BY PRIOR RM_ID = RM_ID
         AND LEVEL <= LENGTH(Z.SUP_GROUP_NAME) -
             LENGTH(REGEXP_REPLACE(Z.SUP_GROUP_NAME, ',', '')) + 1
         AND PRIOR DBMS_RANDOM.VALUE IS NOT NULL),
TEMP_PTORDER AS
 (SELECT T1.PT_ORDERED_ID, T1.GOO_ID_PR,T1.ORDER_ID, T1.DELIVERY_AMOUNT,
         T1.PT_ORDERED_ID || ROW_NUMBER() OVER(PARTITION BY T1.PT_ORDERED_ID ORDER BY 1) ID2,
         T1.COMPANY_ID, T1.PRODUCT_GRESS_CODE, T1.ORDER_MONEY,
         (T1.ORDER_MONEY / COUNT(T1.PRODUCT_GRESS_CODE)
           OVER(PARTITION BY T1.PRODUCT_GRESS_CODE)) SUM1,
         REGEXP_SUBSTR(T1.QC_MANAGER, '[^,]+', 1, LEVEL) QCZG2
    FROM SCMDATA.PT_ORDERED T1
   WHERE T1.QC_MANAGER IS NOT NULL
  CONNECT BY PRIOR T1.PT_ORDERED_ID = T1.PT_ORDERED_ID
         AND LEVEL <=
             LENGTH(T1.QC_MANAGER) - LENGTH(REGEXP_REPLACE(T1.QC_MANAGER, ',', '')) + 1
         AND PRIOR DBMS_RANDOM.VALUE IS NOT NULL)

SELECT Y.COMPANY_ID, Y.YEAR, Y.QUARTER,  Y.CATEGORY, Y.GROUP_NAME,
       '08' COUNT_DIMENSION, Y.DIMENSION_SORT DIMENSION_SORT, Y.RMMONEY SHOP_RT_ORIGINAL_MONEY,
       X.SHOP_RT_MONEY/*, Z.ORDER_MONEY INGOOD_MONEY*/
  FROM (SELECT A.COMPANY_ID, A.YEAR, A.QUARTER, B.CATEGORY,
       (CASE WHEN A.SUP_GROUP_NAME2 IS NULL THEN  '1' ELSE   A.SUP_GROUP_NAME2
       END) GROUP_NAME, '08' COUNT_DIMENSION, (CASE WHEN A.QCZG2 IS NULL THEN '1' ELSE A.QCZG2 END) DIMENSION_SORT,
       SUM(A.EXGAMOUNT3 * B.PRICE) RMMONEY FROM
         (SELECT Z.COMPANY_ID, Z.YEAR, Z.QUARTER, Z.ACCESS_TIME, Z.GOO_ID,
                Z.SUP_GROUP_NAME2,
                Z.EXGAMOUNT2 / NVL((REGEXP_COUNT(Z.QC_DIRECTOR_ID, ',') + 1),1) EXGAMOUNT3,
                REGEXP_SUBSTR(Z.QC_DIRECTOR_ID, '[^,]+', 1, LEVEL) QCZG2
           FROM TEMP_RT Z
          WHERE (EXISTS (SELECT MAX(1)
                           FROM SCMDATA.T_PLAT_LOG X
                           INNER JOIN SCMDATA.T_PLAT_LOGS Y ON X.LOG_ID=Y.LOG_ID AND X.COMPANY_ID = Y.COMPANY_ID
                          WHERE X.APPLY_PK_ID = Z.RM_ID
                            AND Y.OPERATE_FIELD ='QC_DIRECTOR_ID'
                            AND X.ACTION_TYPE = 'UPDATE') OR
                 (NOT EXISTS (SELECT MAX(1)
                                       FROM SCMDATA.T_PLAT_LOG Y
                                       INNER JOIN SCMDATA.T_PLAT_LOGS X ON X.LOG_ID=Y.LOG_ID AND X.COMPANY_ID = Y.COMPANY_ID
                                      WHERE Y.APPLY_PK_ID = Z.RM_ID
                                        AND X.OPERATE_FIELD ='QC_DIRECTOR_ID'
                                        AND Y.ACTION_TYPE = 'UPDATE') AND
                  NOT EXISTS
                  (SELECT 1
                            FROM TEMP_PTORDER J
                           INNER JOIN SCMDATA.T_ORDERED P
                              ON P.ORDER_ID = J.ORDER_ID
                             AND P.COMPANY_ID = J.COMPANY_ID
                           WHERE J.GOO_ID_PR  = Z.GOO_ID
                             AND P.SUPPLIER_CODE = Z.SUPPLIER_CODE
                             AND J.DELIVERY_AMOUNT > 0
                             AND P.SUPPLIER_CODE=Z.SUPPLIER_CODE
                             AND J.QCZG2 IS NOT NULL
                             AND J.COMPANY_ID = Z.COMPANY_ID)))
         CONNECT BY PRIOR Z.RM_ID2 = Z.RM_ID2
                AND LEVEL <= LENGTH(Z.QC_DIRECTOR_ID) -
                    LENGTH(REGEXP_REPLACE(Z.QC_DIRECTOR_ID, ',', '')) + 1
                AND PRIOR DBMS_RANDOM.VALUE IS NOT NULL
         UNION ALL
         SELECT H.COMPANY_ID, H.YEAR, H.QUARTER, H.ACCESS_TIME, H.GOO_ID,
                H.SUP_GROUP_NAME2,
                (H.EXGAMOUNT2 *
                 ((SELECT SUM(J.SUM1)
                      FROM TEMP_PTORDER J
                      INNER JOIN SCMDATA.T_ORDERED P
                              ON P.ORDER_ID = J.ORDER_ID
                             AND P.COMPANY_ID = J.COMPANY_ID
                     WHERE J.GOO_ID_PR = H.GOO_ID
                       AND P.SUPPLIER_CODE = H.SUPPLIER_CODE
                       AND J.DELIVERY_AMOUNT > 0
                       AND P.SUPPLIER_CODE=H.SUPPLIER_CODE
                       AND J.COMPANY_ID = H.COMPANY_ID
                       AND J.QCZG2 = H.QCZG2) /
                 (SELECT SUM(J.ORDER_MONEY)
                      FROM TEMP_PTORDER J
                      INNER JOIN SCMDATA.T_ORDERED P
                              ON P.ORDER_ID = J.ORDER_ID
                             AND P.COMPANY_ID = J.COMPANY_ID
                     WHERE J.GOO_ID_PR = H.GOO_ID AND P.SUPPLIER_CODE=H.SUPPLIER_CODE AND J.QCZG2 >0 AND J.DELIVERY_AMOUNT > 0
                       AND H.COMPANY_ID = J.COMPANY_ID
                       AND J.QCZG2 IS NOT NULL))) EXGAMOUNT3, H.QCZG2
           FROM (SELECT Z.*, REGEXP_SUBSTR(Z.QC_DIRECTOR_ID, '[^,]+', 1, LEVEL) QCZG2
                    FROM TEMP_RT Z
                   WHERE NOT EXISTS (SELECT MAX(1)
                            FROM SCMDATA.T_PLAT_LOG Y
                            INNER JOIN SCMDATA.T_PLAT_LOGS X ON X.LOG_ID=Y.LOG_ID AND X.COMPANY_ID = Y.COMPANY_ID
                           WHERE Y.APPLY_PK_ID = Z.RM_ID
                             AND X.OPERATE_FIELD ='QC_DIRECTOR_ID'
                             AND Y.ACTION_TYPE = 'UPDATE')
                     AND EXISTS
                   (SELECT MAX(1)
                            FROM TEMP_PTORDER J
                      INNER JOIN SCMDATA.T_ORDERED P
                              ON P.ORDER_ID = J.ORDER_ID
                             AND P.COMPANY_ID = J.COMPANY_ID
                     WHERE J.GOO_ID_PR = Z.GOO_ID
                             AND J.COMPANY_ID = Z.COMPANY_ID AND J.QCZG2 IS NOT NULL AND P.SUPPLIER_CODE=Z.SUPPLIER_CODE AND J.DELIVERY_AMOUNT > 0)
                  CONNECT BY PRIOR Z.RM_ID2 = Z.RM_ID2
                         AND LEVEL <=
                             LENGTH(Z.QC_DIRECTOR_ID) -
                             LENGTH(REGEXP_REPLACE(Z.QC_DIRECTOR_ID, ',', '')) + 1
                         AND PRIOR DBMS_RANDOM.VALUE IS NOT NULL) H) A
 INNER JOIN SCMDATA.T_COMMODITY_INFO B
    ON A.GOO_ID = B.GOO_ID
   AND A.COMPANY_ID = B.COMPANY_ID
 GROUP BY A.COMPANY_ID, A.YEAR, A.QUARTER, B.CATEGORY,
          A.SUP_GROUP_NAME2, A.QCZG2) Y

  LEFT JOIN (SELECT A.COMPANY_ID, A.YEAR, A.QUARTER, B.CATEGORY,
       (CASE
         WHEN A.SUP_GROUP_NAME2 IS NULL THEN
          '1'
         ELSE
          A.SUP_GROUP_NAME2
       END) GROUP_NAME, '08' COUNT_DIMENSION,( CASE WHEN A.QCZG2 IS NULL THEN '1' ELSE A.QCZG2 END) DIMENSION_SORT,
       SUM(A.EXGAMOUNT3 * B.PRICE) SHOP_RT_MONEY
  FROM (SELECT Z.COMPANY_ID, Z.YEAR, Z.QUARTER, Z.ACCESS_TIME, Z.GOO_ID,
                Z.SUP_GROUP_NAME2,
                Z.EXGAMOUNT2 / NVL((REGEXP_COUNT(Z.QC_DIRECTOR_ID, ',') + 1),1) EXGAMOUNT3,
                REGEXP_SUBSTR(Z.QC_DIRECTOR_ID, '[^,]+', 1, LEVEL) QCZG2
           FROM TEMP_RT2 Z
          WHERE (EXISTS (SELECT MAX(1)
                           FROM SCMDATA.T_PLAT_LOG X
                           INNER JOIN SCMDATA.T_PLAT_LOGS Y ON X.LOG_ID=Y.LOG_ID AND X.COMPANY_ID = Y.COMPANY_ID
                          WHERE X.APPLY_PK_ID = Z.RM_ID
                            AND Y.OPERATE_FIELD ='QC_DIRECTOR_ID'
                            AND X.ACTION_TYPE = 'UPDATE') OR
                 (NOT EXISTS (SELECT MAX(1)
                                       FROM SCMDATA.T_PLAT_LOG Y
                                       INNER JOIN SCMDATA.T_PLAT_LOGS X ON X.LOG_ID=Y.LOG_ID AND X.COMPANY_ID = Y.COMPANY_ID
                                      WHERE Y.APPLY_PK_ID = Z.RM_ID
                                        AND X.OPERATE_FIELD ='QC_DIRECTOR_ID'
                                        AND Y.ACTION_TYPE = 'UPDATE') AND
                  NOT EXISTS
                  (SELECT 1
                            FROM TEMP_PTORDER J
                      INNER JOIN SCMDATA.T_ORDERED P
                              ON P.ORDER_ID = J.ORDER_ID
                             AND P.COMPANY_ID = J.COMPANY_ID
                           WHERE J.GOO_ID_PR  = Z.GOO_ID
                             AND J.COMPANY_ID = Z.COMPANY_ID
                             AND J.QCZG2 IS NOT NULL AND P.SUPPLIER_CODE=Z.SUPPLIER_CODE AND J.DELIVERY_AMOUNT > 0)))
         CONNECT BY PRIOR Z.RM_ID2 = Z.RM_ID2
                AND LEVEL <= LENGTH(Z.QC_DIRECTOR_ID) -
                    LENGTH(REGEXP_REPLACE(Z.QC_DIRECTOR_ID, ',', '')) + 1
                AND PRIOR DBMS_RANDOM.VALUE IS NOT NULL
         UNION ALL
         SELECT H.COMPANY_ID, H.YEAR, H.QUARTER, H.ACCESS_TIME, H.GOO_ID,
                H.SUP_GROUP_NAME2,
                (H.EXGAMOUNT2 *
                 ((SELECT SUM(J.SUM1)
                      FROM TEMP_PTORDER J
                      INNER JOIN SCMDATA.T_ORDERED P
                              ON P.ORDER_ID = J.ORDER_ID
                             AND P.COMPANY_ID = J.COMPANY_ID
                     WHERE J.GOO_ID_PR = H.GOO_ID
                       AND J.COMPANY_ID = H.COMPANY_ID
                       AND J.QCZG2 = H.QCZG2 AND P.SUPPLIER_CODE=H.SUPPLIER_CODE AND J.DELIVERY_AMOUNT > 0 ) /
                 (SELECT SUM(J.ORDER_MONEY)
                      FROM TEMP_PTORDER J
                      INNER JOIN SCMDATA.T_ORDERED P
                              ON P.ORDER_ID = J.ORDER_ID
                             AND P.COMPANY_ID = J.COMPANY_ID
                     WHERE J.GOO_ID_PR = H.GOO_ID
                       AND H.COMPANY_ID = J.COMPANY_ID
                       AND J.QCZG2 IS NOT NULL AND P.SUPPLIER_CODE=H.SUPPLIER_CODE AND J.DELIVERY_AMOUNT > 0))) EXGAMOUNT3, H.QCZG2
           FROM (SELECT Z.*, REGEXP_SUBSTR(Z.QC_DIRECTOR_ID, '[^,]+', 1, LEVEL) QCZG2
                    FROM TEMP_RT2 Z
                   WHERE NOT EXISTS (SELECT MAX(1)
                            FROM SCMDATA.T_PLAT_LOG Y
                            INNER JOIN SCMDATA.T_PLAT_LOGS X ON X.LOG_ID=Y.LOG_ID AND X.COMPANY_ID = Y.COMPANY_ID
                           WHERE Y.APPLY_PK_ID = Z.RM_ID
                             AND X.OPERATE_FIELD ='QC_DIRECTOR_ID'
                             AND Y.ACTION_TYPE = 'UPDATE')
                     AND EXISTS
                   (SELECT MAX(1)
                            FROM TEMP_PTORDER J
                      INNER JOIN SCMDATA.T_ORDERED P
                              ON P.ORDER_ID = J.ORDER_ID
                             AND P.COMPANY_ID = J.COMPANY_ID
                     WHERE J.GOO_ID_PR = Z.GOO_ID
                             AND J.COMPANY_ID = Z.COMPANY_ID
                             AND J.QCZG2 IS NOT NULL AND P.SUPPLIER_CODE=Z.SUPPLIER_CODE AND J.DELIVERY_AMOUNT > 0)
                  CONNECT BY PRIOR Z.RM_ID2 = Z.RM_ID2
                         AND LEVEL <=
                             LENGTH(Z.QC_DIRECTOR_ID) -
                             LENGTH(REGEXP_REPLACE(Z.QC_DIRECTOR_ID, ',', '')) + 1
                         AND PRIOR DBMS_RANDOM.VALUE IS NOT NULL) H) A
 INNER JOIN SCMDATA.T_COMMODITY_INFO B
    ON A.GOO_ID = B.GOO_ID
   AND A.COMPANY_ID = B.COMPANY_ID
 GROUP BY A.COMPANY_ID, A.YEAR, A.QUARTER,B.CATEGORY,
          A.SUP_GROUP_NAME2, A.QCZG2) X
    ON X.COMPANY_ID = Y.COMPANY_ID
   AND X.YEAR = Y.YEAR
   AND X.QUARTER = Y.QUARTER
   AND X.CATEGORY = Y.CATEGORY
   AND X.GROUP_NAME = Y.GROUP_NAME
   AND X.COUNT_DIMENSION = Y.COUNT_DIMENSION
   AND X.DIMENSION_SORT = Y.DIMENSION_SORT
  /*LEFT JOIN ( SELECT A.COMPANY_ID,
       EXTRACT(YEAR FROM A.CREATE_TIME) YEAR,
       TO_CHAR(A.CREATE_TIME,'Q') QUARTER,
       D.CATEGORY,
       (CASE WHEN D.GROUP_NAME IS NULL THEN  '1'  ELSE D.GROUP_NAME END) GROUP_NAME,
       '08' COUNT_DIMENSION,
       (case when D.QCZG2 is null then '1' else D.QCZG2 end) DIMENSION_SORT,
       SUM(CASE WHEN REGEXP_COUNT(D.QC_MANAGER, ',') > 0 THEN
       B.AMOUNT/NVL((REGEXP_COUNT(D.QC_MANAGER, ',') + 1),1) * E.PRICE ELSE
           B.AMOUNT * E.PRICE END ) ORDER_MONEY
  FROM SCMDATA.T_INGOOD A
 INNER JOIN SCMDATA.T_INGOODS B
    ON A.ING_ID = B.ING_ID
   AND A.COMPANY_ID = B.COMPANY_ID
 INNER JOIN SCMDATA.T_ORDERED C
    ON C.ORDER_CODE = A.DOCUMENT_NO
   AND A.COMPANY_ID = C.COMPANY_ID
 INNER JOIN (SELECT Z.*, REGEXP_SUBSTR(Z.QC_MANAGER, '[^,]+', 1, LEVEL) QCZG2
  FROM SCMDATA.PT_ORDERED Z
CONNECT BY PRIOR Z.PT_ORDERED_ID = Z.PT_ORDERED_ID
       AND LEVEL <= LENGTH(Z.QC_MANAGER) -
           LENGTH(REGEXP_REPLACE(Z.QC_MANAGER, ',', '')) + 1
       AND PRIOR DBMS_RANDOM.VALUE IS NOT NULL
) D
    ON D.ORDER_ID = C.ORDER_ID
   AND D.COMPANY_ID = C.COMPANY_ID
  INNER JOIN SCMDATA.T_COMMODITY_INFO E ON E.GOO_ID=B.GOO_ID AND E.COMPANY_ID=B.COMPANY_ID
 WHERE B.AMOUNT > 0
 GROUP BY A.COMPANY_ID,
          EXTRACT(YEAR FROM A.CREATE_TIME),
          TO_CHAR(A.CREATE_TIME,'Q'),
          D.CATEGORY,
          D.GROUP_NAME,
          D.QCZG2) Z
    ON Z.COMPANY_ID = Y.COMPANY_ID
   AND Z.YEAR = Y.YEAR
   AND Z.QUARTER = Y.QUARTER
   AND Z.CATEGORY = Y.CATEGORY
   AND Z.GROUP_NAME = Y.GROUP_NAME
   AND Z.COUNT_DIMENSION = Y.COUNT_DIMENSION
   AND Z.DIMENSION_SORT = Y.DIMENSION_SORT */ ]';

     IF P_TYPE = 0 THEN
      --进货
      V_EXSQL1 := V_SQL1||V_WH_SQL2||V_U_SQL1||V_I_SQL1;
      --退货
      V_EXSQL2 := V_SQL2 || V_WH_SQL2 || V_U_SQL2 || V_I_SQL2;


    ELSIF P_TYPE = 1 THEN
      --进货
      V_EXSQL1 := V_SQL1||V_WM_SQL1||V_U_SQL1||V_I_SQL1;
      --退货
      V_EXSQL2 := V_SQL2 || V_WM_SQL1 || V_U_SQL2 || V_I_SQL2;
    END IF;
    EXECUTE IMMEDIATE V_EXSQL2;
     EXECUTE IMMEDIATE V_EXSQL1;
    --dbms_output.put_line(V_EXSQL1);
    --dbms_output.put_line(V_EXSQL2);
  END P_RTKPI_QUARTER;

  PROCEDURE P_RTKPI_HALFYEAR(P_TYPE NUMBER) IS
    V_SQL1     CLOB;
    V_SQL2     CLOB;
    V_WH_SQL2 CLOB; --全部历史数据
    V_EXSQL1   CLOB;
    V_EXSQL2   CLOB;
    V_WM_SQL1 CLOB; --上一时间维度

    V_U_SQL1  CLOB := q'[ update
                           set a.INGOOD_MONEY           =tkb.INGOOD_MONEY,
                               a.update_id              = 'ADMIN',
                               a.update_time            = sysdate
                 ]';
    V_U_SQL2  CLOB := q'[ update
                           set a.SHOP_RT_MONEY          = tkb.SHOP_RT_MONEY,
                               a.SHOP_RT_ORIGINAL_MONEY = tkb.SHOP_RT_ORIGINAL_MONEY,
                               a.update_id              = 'ADMIN',
                               a.update_time            = sysdate
                 ]';
       V_I_SQL1  CLOB := q'[
    WHEN NOT MATCHED THEN
      INSERT (a.T_RTKPI_HF_ID,a.company_id,a.year,a.HALFYEAR,a.category,a.groupname,a.count_dimension,a.dimension_sort,a.ingood_money,a.create_id,a.create_time,a.update_id,a.update_time)
      values (scmdata.f_get_uuid(),
         tkb.company_id,
         tkb.year,
         tkb.HALFYEAR,
         tkb.category,
         tkb.group_name,
         tkb.count_dimension,
         tkb.dimension_sort,
         tkb.INGOOD_MONEY,
         'ADMIN',sysdate,'ADMIN',sysdate) ]';

    V_I_SQL2  CLOB := q'[
    WHEN NOT MATCHED THEN
      INSERT (a.T_RTKPI_HF_ID,a.company_id,a.year,a.HALFYEAR,a.category,a.groupname,a.count_dimension,a.dimension_sort,a.shop_rt_money,a.shop_rt_original_money,a.create_id,a.create_time,a.update_id,a.update_time)
      values (scmdata.f_get_uuid(),
         tkb.company_id,
         tkb.year,
         tkb.HALFYEAR,
         tkb.category,
         tkb.group_name,
         tkb.count_dimension,
         tkb.dimension_sort,
         tkb.SHOP_RT_MONEY,
         tkb.SHOP_RT_ORIGINAL_MONEY,
         'ADMIN',sysdate,'ADMIN',sysdate) ]';

  BEGIN

    --全部历史数据
    V_WH_SQL2 := q'[
       WHERE (y.year||Y.halfyear) <= scmdata.pkg_kpipt_order.f_yearmonth
         and y.year>=2023
          ) tkb
          ON (tkb.company_id = a.company_id AND tkb.year = a.year AND tkb.HALFYEAR=a.HALFYEAR  AND tkb.category=a.category
           AND tkb.group_name = a.groupname AND tkb.count_dimension =a.count_dimension AND tkb.dimension_sort =a.dimension_sort  )
           when matched then ]';

    --上一时间维度
    V_WM_SQL1 := q'[
      where (y.year||Y.halfyear) = scmdata.pkg_kpipt_order.f_yearmonth
        ) tkb
      ON (tkb.company_id = a.company_id AND tkb.year = a.year AND tkb.HALFYEAR=a.HALFYEAR  AND tkb.category=a.category
           AND tkb.group_name = a.groupname AND tkb.count_dimension =a.count_dimension AND tkb.dimension_sort =a.dimension_sort  )
           when matched then ]';
    --分类维度
    V_SQL1:=q'[MERGE INTO SCMDATA.T_RTKPI_HALFYEAR A
             USING (SELECT y.COMPANY_ID, y.YEAR, y.HALFYEAR,  y.CATEGORY,
              y.GROUP_NAME, y.COUNT_DIMENSION, y.DIMENSION_SORT,
              y.ORDER_MONEY INGOOD_MONEY
           from (SELECT A.COMPANY_ID, EXTRACT(YEAR FROM A.CREATE_TIME) YEAR,
                       DECODE(to_char( A.CREATE_TIME,'Q'),1,1,2,1,3,2,4,2) HALFYEAR,
                       E.CATEGORY,
                       (CASE
                         WHEN D.GROUP_NAME IS NULL THEN
                          '1'
                         ELSE
                          D.GROUP_NAME
                       END) GROUP_NAME, '00' COUNT_DIMENSION,
                       E.CATEGORY DIMENSION_SORT,
                       SUM(A.AMOUNT * E.PRICE) ORDER_MONEY
                  FROM (SELECT T.DOCUMENT_NO,
                    T.COMPANY_ID,
                    TRUNC(T.CREATE_TIME) CREATE_TIME,
                    SUM(TL.AMOUNT) AMOUNT,
                    TL.GOO_ID
               FROM SCMDATA.T_INGOOD T
              INNER JOIN (SELECT TI.ING_ID,
                                TI.COMPANY_ID,
                                TI.GOO_ID,
                                TI.AMOUNT
                           FROM SCMDATA.T_INGOODS TI
                          WHERE TI.AMOUNT > 0) TL
                 ON TL.ING_ID = T.ING_ID
                AND TL.COMPANY_ID = T.COMPANY_ID
              WHERE TO_CHAR(T.CREATE_TIME, 'yyyy') >= 2022
              GROUP BY T.DOCUMENT_NO,
                       T.COMPANY_ID,
                       TRUNC(T.CREATE_TIME),
                       TL.GOO_ID) A
                  /*SCMDATA.T_INGOOD A
                 INNER JOIN SCMDATA.T_INGOODS B
                    ON A.ING_ID = B.ING_ID
                   AND A.COMPANY_ID = B.COMPANY_ID
                 LEFT JOIN SCMDATA.T_ORDERED C
                    ON C.ORDER_CODE = A.DOCUMENT_NO
                   AND A.COMPANY_ID = C.COMPANY_ID*/
                 LEFT JOIN SCMDATA.PT_ORDERED D
                    ON D.PRODUCT_GRESS_CODE = A.DOCUMENT_NO
                   AND D.COMPANY_ID = A.COMPANY_ID
                  INNER JOIN SCMDATA.T_COMMODITY_INFO E ON E.GOO_ID=A.GOO_ID AND E.COMPANY_ID=A.COMPANY_ID
                 --WHERE B.AMOUNT > 0
                 GROUP BY A.COMPANY_ID, EXTRACT(YEAR FROM A.CREATE_TIME),
                          DECODE(TO_CHAR(A.CREATE_TIME,'Q'),1,1,2,1,3,2,4,2), E.CATEGORY,
                          D.GROUP_NAME) Y   ]';

    V_SQL2 := q'[MERGE INTO SCMDATA.T_RTKPI_HALFYEAR A
             USING (SELECT y.COMPANY_ID, y.YEAR, y.HALFYEAR,  y.CATEGORY,
              y.GROUP_NAME, y.COUNT_DIMENSION, y.DIMENSION_SORT,
              /*Z.ORDER_MONEY INGOOD_MONEY,*/ Y.RMMONEY SHOP_RT_ORIGINAL_MONEY, X.RMMONEY2 SHOP_RT_MONEY
          FROM
         (SELECT A.COMPANY_ID, A.YEAR, DECODE(A.QUARTER,1,1,2,1,3,2,4,2) HALFYEAR,
                          B.CATEGORY,
                          (CASE
                            WHEN A.SUP_GROUP_NAME2 IS NULL THEN
                             '1'
                            ELSE
                             A.SUP_GROUP_NAME2
                          END) GROUP_NAME, '00' COUNT_DIMENSION,
                          B.CATEGORY DIMENSION_SORT,
                          SUM(CASE
                                WHEN REGEXP_COUNT(A.SUP_GROUP_NAME, ',') > 0 THEN
                                 A.EXAMOUNT /
                                 (REGEXP_COUNT(A.SUP_GROUP_NAME, ',') + 1) *
                                 B.PRICE
                                ELSE
                                 A.EXAMOUNT * B.PRICE
                              END) RMMONEY
                     FROM (SELECT Z.RM_ID, Z.COMPANY_ID, Z.YEAR, Z.QUARTER,
                                   Z.ACCESS_TIME, Z.GOO_ID, Z.EXAMOUNT,
                                   Z.SUP_GROUP_NAME, Z.AUDIT_TIME,
                                   REGEXP_SUBSTR(Z.SUP_GROUP_NAME,
                                                  '[^,]+',
                                                  1,
                                                  LEVEL) SUP_GROUP_NAME2
                              FROM SCMDATA.T_RETURN_MANAGEMENT Z
                            CONNECT BY PRIOR RM_ID = RM_ID
                                   AND LEVEL <=
                                       LENGTH(Z.SUP_GROUP_NAME) -
                                       LENGTH(REGEXP_REPLACE(Z.SUP_GROUP_NAME,
                                                             ',',
                                                             '')) + 1
                                   AND PRIOR DBMS_RANDOM.VALUE IS NOT NULL) A
                    INNER JOIN SCMDATA.T_COMMODITY_INFO B
                       ON A.GOO_ID = B.GOO_ID
                      AND A.COMPANY_ID = B.COMPANY_ID
                    WHERE A.AUDIT_TIME IS NOT NULL
                    GROUP BY A.COMPANY_ID, A.YEAR, DECODE(A.QUARTER,1,1,2,1,3,2,4,2),
                             B.CATEGORY,
                             A.SUP_GROUP_NAME2) Y

         LEFT JOIN (SELECT A.COMPANY_ID, A.YEAR, DECODE(A.QUARTER,1,1,2,1,3,2,4,2) HALFYAER,
                          B.CATEGORY,
                          (CASE
                            WHEN A.SUP_GROUP_NAME2 IS NULL THEN
                             '1'
                            ELSE
                             A.SUP_GROUP_NAME2
                          END) GROUP_NAME, '00' COUNT_DIMENSION,
                          B.CATEGORY DIMENSION_SORT,
                          SUM(CASE
                                WHEN REGEXP_COUNT(A.SUP_GROUP_NAME, ',') > 0 THEN
                                 A.EXAMOUNT /
                                 (REGEXP_COUNT(A.SUP_GROUP_NAME, ',') + 1) *
                                 B.PRICE
                                ELSE
                                 A.EXAMOUNT * B.PRICE
                              END) RMMONEY2
                     FROM (SELECT Z.RM_ID, Z.COMPANY_ID, Z.YEAR, Z.QUARTER,
                                   Z.ACCESS_TIME, Z.GOO_ID, Z.EXAMOUNT,
                                   Z.SUP_GROUP_NAME, Z.AUDIT_TIME,
                                   Z.CAUSE_DETAIL_ID, Z.FIRST_DEPT_ID,
                                   Z.SECOND_DEPT_ID,
                                   REGEXP_SUBSTR(Z.SUP_GROUP_NAME,
                                                  '[^,]+',
                                                  1,
                                                  LEVEL) SUP_GROUP_NAME2
                              FROM SCMDATA.T_RETURN_MANAGEMENT Z
                            CONNECT BY PRIOR RM_ID = RM_ID
                                   AND LEVEL <=
                                       LENGTH(Z.SUP_GROUP_NAME) -
                                       LENGTH(REGEXP_REPLACE(Z.SUP_GROUP_NAME,
                                                             ',',
                                                             '')) + 1
                                   AND PRIOR DBMS_RANDOM.VALUE IS NOT NULL) A
                    INNER JOIN SCMDATA.T_COMMODITY_INFO B
                       ON A.GOO_ID = B.GOO_ID
                      AND A.COMPANY_ID = B.COMPANY_ID
                     LEFT JOIN SCMDATA.T_ABNORMAL_DTL_CONFIG C
                       ON A.CAUSE_DETAIL_ID = C.ABNORMAL_DTL_CONFIG_ID
                      AND A.COMPANY_ID = C.COMPANY_ID
                      AND C.ANOMALY_CLASSIFICATION = 'AC_QUALITY'
                    INNER JOIN SCMDATA.SYS_COMPANY_DEPT D
                       ON D.COMPANY_DEPT_ID = A.FIRST_DEPT_ID
                    WHERE A.AUDIT_TIME IS NOT NULL
                      AND C.CAUSE_CLASSIFICATION <> '银饰氧化问题'
                      AND C.PROBLEM_CLASSIFICATION <> '非质量问题'
                      AND D.DEPT_NAME = '供应链管理部'
                    GROUP BY A.COMPANY_ID, A.YEAR, DECODE(A.QUARTER,1,1,2,1,3,2,4,2), B.CATEGORY,
                             A.SUP_GROUP_NAME2) X
           ON X.COMPANY_ID = Y.COMPANY_ID
          AND X.YEAR = Y.YEAR
          AND X.HALFYAER = Y.HALFYEAR
          AND X.CATEGORY = Y.CATEGORY
          AND X.GROUP_NAME = Y.GROUP_NAME
          AND X.COUNT_DIMENSION = Y.COUNT_DIMENSION
          AND X.DIMENSION_SORT = Y.DIMENSION_SORT
          /*LEFT JOIN (SELECT A.COMPANY_ID, EXTRACT(YEAR FROM A.CREATE_TIME) YEAR,
                       DECODE(to_char( A.CREATE_TIME,'Q'),1,1,2,1,3,2,4,2) HALFYEAR,
                       D.CATEGORY,
                       (CASE
                         WHEN D.GROUP_NAME IS NULL THEN
                          '1'
                         ELSE
                          D.GROUP_NAME
                       END) GROUP_NAME, '00' COUNT_DIMENSION,
                       D.CATEGORY DIMENSION_SORT,
                       SUM(B.AMOUNT * E.PRICE) ORDER_MONEY
                  FROM SCMDATA.T_INGOOD A
                 INNER JOIN SCMDATA.T_INGOODS B
                    ON A.ING_ID = B.ING_ID
                   AND A.COMPANY_ID = B.COMPANY_ID
                 INNER JOIN SCMDATA.T_ORDERED C
                    ON C.ORDER_CODE = A.DOCUMENT_NO
                   AND A.COMPANY_ID = C.COMPANY_ID
                 INNER JOIN SCMDATA.PT_ORDERED D
                    ON D.ORDER_ID = C.ORDER_ID
                   AND D.COMPANY_ID = C.COMPANY_ID
                  INNER JOIN SCMDATA.T_COMMODITY_INFO E ON E.GOO_ID=B.GOO_ID AND E.COMPANY_ID=B.COMPANY_ID
                 WHERE B.AMOUNT > 0
                 GROUP BY A.COMPANY_ID, EXTRACT(YEAR FROM A.CREATE_TIME),
                          DECODE(TO_CHAR(A.CREATE_TIME,'Q'),1,1,2,1,3,2,4,2), D.CATEGORY,
                          D.GROUP_NAME) z ON Z.COMPANY_ID = Y.COMPANY_ID
          AND Z.YEAR = Y.YEAR
          AND Z.HALFYEAR = Y.HALFYEAR
          AND Z.CATEGORY = Y.CATEGORY
          AND Z.GROUP_NAME = Y.GROUP_NAME
          AND Z.COUNT_DIMENSION = Y.COUNT_DIMENSION
          AND Z.DIMENSION_SORT = Y.DIMENSION_SORT */]';
    /*p_type = 0 更新全部历史数据
    p_type = 1  只更新上一个月的数据 */
    IF P_TYPE = 0 THEN
      --进货
      V_EXSQL1 := V_SQL1||V_WH_SQL2||V_U_SQL1||V_I_SQL1;
      --退货
      V_EXSQL2 := V_SQL2 || V_WH_SQL2 || V_U_SQL2 || V_I_SQL2;


    ELSIF P_TYPE = 1 THEN
      --进货
      V_EXSQL1 := V_SQL1||V_WM_SQL1||V_U_SQL1||V_I_SQL1;
      --退货
      V_EXSQL2 := V_SQL2 || V_WM_SQL1 || V_U_SQL2 || V_I_SQL2;
    END IF;
    EXECUTE IMMEDIATE V_EXSQL2;
     EXECUTE IMMEDIATE V_EXSQL1;
    --dbms_output.put_line(V_EXSQL1);
    --dbms_output.put_line(V_EXSQL2);

    --区域组
    V_SQL1:=q'[MERGE INTO SCMDATA.T_RTKPI_HALFYEAR A
USING (SELECT Y.COMPANY_ID, Y.YEAR, Y.HALFYEAR,  Y.CATEGORY,
              Y.GROUP_NAME, Y.COUNT_DIMENSION, Y.DIMENSION_SORT,
              Y.ORDER_MONEY INGOOD_MONEY
    FROM  (SELECT A.COMPANY_ID,
       EXTRACT(YEAR FROM A.CREATE_TIME) YEAR,
       DECODE(TO_CHAR( A.CREATE_TIME,'Q'),1,1,2,1,3,2,4,2) HALFYEAR,
       E.CATEGORY,
       (CASE WHEN D.GROUP_NAME IS NULL THEN  '1'  ELSE D.GROUP_NAME END) GROUP_NAME,
       '01' COUNT_DIMENSION,
       (CASE WHEN D.GROUP_NAME IS NULL THEN  '1'  ELSE D.GROUP_NAME END) DIMENSION_SORT,
       SUM(A.AMOUNT * E.PRICE) ORDER_MONEY
  FROM (SELECT T.DOCUMENT_NO,
                    T.COMPANY_ID,
                    TRUNC(T.CREATE_TIME) CREATE_TIME,
                    SUM(TL.AMOUNT) AMOUNT,
                    TL.GOO_ID
               FROM SCMDATA.T_INGOOD T
              INNER JOIN (SELECT TI.ING_ID,
                                TI.COMPANY_ID,
                                TI.GOO_ID,
                                TI.AMOUNT
                           FROM SCMDATA.T_INGOODS TI
                          WHERE TI.AMOUNT > 0) TL
                 ON TL.ING_ID = T.ING_ID
                AND TL.COMPANY_ID = T.COMPANY_ID
              WHERE TO_CHAR(T.CREATE_TIME, 'yyyy') >= 2022
              GROUP BY T.DOCUMENT_NO,
                       T.COMPANY_ID,
                       TRUNC(T.CREATE_TIME),
                       TL.GOO_ID) A
                  /*SCMDATA.T_INGOOD A
                 INNER JOIN SCMDATA.T_INGOODS B
                    ON A.ING_ID = B.ING_ID
                   AND A.COMPANY_ID = B.COMPANY_ID
                 LEFT JOIN SCMDATA.T_ORDERED C
                    ON C.ORDER_CODE = A.DOCUMENT_NO
                   AND A.COMPANY_ID = C.COMPANY_ID*/
                 LEFT JOIN SCMDATA.PT_ORDERED D
                    ON D.PRODUCT_GRESS_CODE = A.DOCUMENT_NO
                   AND D.COMPANY_ID = A.COMPANY_ID
                  INNER JOIN SCMDATA.T_COMMODITY_INFO E ON E.GOO_ID=A.GOO_ID AND E.COMPANY_ID=A.COMPANY_ID
                 --WHERE B.AMOUNT > 0
 GROUP BY A.COMPANY_ID,
          EXTRACT(YEAR FROM A.CREATE_TIME),
          DECODE(TO_CHAR( A.CREATE_TIME,'Q'),1,1,2,1,3,2,4,2),
          E.CATEGORY,
          D.GROUP_NAME) Y          ]';

    V_SQL2 := q'[MERGE INTO SCMDATA.T_RTKPI_HALFYEAR A
USING (SELECT Y.COMPANY_ID, Y.YEAR, Y.HALFYEAR,  Y.CATEGORY,
              Y.GROUP_NAME, Y.COUNT_DIMENSION, Y.DIMENSION_SORT,
              /*Z.ORDER_MONEY INGOOD_MONEY,*/ Y.RMMONEY SHOP_RT_ORIGINAL_MONEY, X.RMMONEY2 SHOP_RT_MONEY

         FROM
         (SELECT A.COMPANY_ID, A.YEAR, DECODE(A.QUARTER,1,1,2,1,3,2,4,2) HALFYEAR,
                          B.CATEGORY,
                          (CASE
                            WHEN A.SUP_GROUP_NAME2 IS NULL THEN
                             '1'
                            ELSE
                             A.SUP_GROUP_NAME2
                          END) GROUP_NAME, '01' COUNT_DIMENSION,
                         (CASE
                            WHEN A.SUP_GROUP_NAME2 IS NULL THEN
                             '1'
                            ELSE
                             A.SUP_GROUP_NAME2
                          END) DIMENSION_SORT,
                          SUM(CASE
                                WHEN REGEXP_COUNT(A.SUP_GROUP_NAME, ',') > 0 THEN
                                 A.EXAMOUNT /
                                 (REGEXP_COUNT(A.SUP_GROUP_NAME, ',') + 1) *
                                 B.PRICE
                                ELSE
                                 A.EXAMOUNT * B.PRICE
                              END) RMMONEY
                     FROM (SELECT Z.RM_ID, Z.COMPANY_ID, Z.YEAR, Z.QUARTER,
                                   Z.ACCESS_TIME, Z.GOO_ID, Z.EXAMOUNT,
                                   Z.SUP_GROUP_NAME, Z.AUDIT_TIME,
                                   REGEXP_SUBSTR(Z.SUP_GROUP_NAME,
                                                  '[^,]+',
                                                  1,
                                                  LEVEL) SUP_GROUP_NAME2
                              FROM   SCMDATA.T_RETURN_MANAGEMENT z
   CONNECT BY PRIOR RM_ID = RM_ID
          AND LEVEL <= LENGTH(z.SUP_GROUP_NAME) -
              LENGTH(REGEXP_REPLACE(z.SUP_GROUP_NAME, ',', '')) + 1
          AND PRIOR DBMS_RANDOM.VALUE IS NOT NULL) A
        INNER JOIN scmdata.T_COMMODITY_INFO B
             ON A.GOO_ID = B.GOO_ID
            AND A.COMPANY_ID = B.COMPANY_ID
       WHERE A.AUDIT_TIME IS NOT NULL
       GROUP BY A.COMPANY_ID,
                A.YEAR,
                DECODE(A.QUARTER,1,1,2,1,3,2,4,2),
                B.CATEGORY,
                 A.SUP_GROUP_NAME2) Y

         LEFT JOIN (SELECT A.COMPANY_ID, A.YEAR, DECODE(A.QUARTER,1,1,2,1,3,2,4,2) HALFYEAR,
                          B.CATEGORY,
                          (CASE  WHEN A.SUP_GROUP_NAME2 IS NULL THEN '1'    ELSE   A.SUP_GROUP_NAME2 END) GROUP_NAME,
                           '01' COUNT_DIMENSION,
                         (CASE  WHEN A.SUP_GROUP_NAME2 IS NULL THEN '1'    ELSE   A.SUP_GROUP_NAME2 END) DIMENSION_SORT,
                          SUM(CASE
                                WHEN REGEXP_COUNT(A.SUP_GROUP_NAME, ',') > 0 THEN
                                 A.EXAMOUNT /
                                 (REGEXP_COUNT(A.SUP_GROUP_NAME, ',') + 1) *
                                 B.PRICE
                                ELSE
                                 A.EXAMOUNT * B.PRICE
                              END) RMMONEY2
                     FROM (SELECT Z.RM_ID, Z.COMPANY_ID, Z.YEAR, Z.QUARTER,
                                   Z.ACCESS_TIME, Z.GOO_ID, Z.EXAMOUNT,
                                   Z.SUP_GROUP_NAME, Z.AUDIT_TIME,
                                   Z.CAUSE_DETAIL_ID, Z.FIRST_DEPT_ID,
                                   Z.SECOND_DEPT_ID,
                                   REGEXP_SUBSTR(Z.SUP_GROUP_NAME,
                                                  '[^,]+',
                                                  1,
                                                  LEVEL) SUP_GROUP_NAME2
                              FROM SCMDATA.T_RETURN_MANAGEMENT z
   CONNECT BY PRIOR RM_ID = RM_ID
          AND LEVEL <= LENGTH(z.SUP_GROUP_NAME) -
              LENGTH(REGEXP_REPLACE(z.SUP_GROUP_NAME, ',', '')) + 1
          AND PRIOR DBMS_RANDOM.VALUE IS NOT NULL) A
        INNER JOIN scmdata.T_COMMODITY_INFO B
             ON A.GOO_ID = B.GOO_ID
            AND A.COMPANY_ID = B.COMPANY_ID
          LEFT JOIN SCMDATA.T_abnormal_dtl_config C ON A.CAUSE_DETAIL_ID = C.ABNORMAL_DTL_CONFIG_ID AND A.COMPANY_ID = C.COMPANY_ID AND C.ANOMALY_CLASSIFICATION='AC_QUALITY'
         INNER JOIN SCMDATA.SYS_COMPANY_DEPT D ON D.COMPANY_DEPT_ID=A.FIRST_DEPT_ID
       WHERE A.AUDIT_TIME IS NOT NULL
       AND C.CAUSE_CLASSIFICATION <> '银饰氧化问题'
       AND C.PROBLEM_CLASSIFICATION <> '非质量问题'
        AND D.DEPT_NAME = '供应链管理部'
       GROUP BY A.COMPANY_ID,
                A.YEAR,
                DECODE(A.QUARTER,1,1,2,1,3,2,4,2),
                B.CATEGORY,
                 A.SUP_GROUP_NAME2) X
           ON X.COMPANY_ID = Y.COMPANY_ID
          AND X.YEAR = Y.YEAR
          AND X.HALFYEAR = Y.HALFYEAR
          AND X.CATEGORY = Y.CATEGORY
          AND X.GROUP_NAME = Y.GROUP_NAME
          AND X.COUNT_DIMENSION = Y.COUNT_DIMENSION
          AND X.DIMENSION_SORT = Y.DIMENSION_SORT
          /*LEFT JOIN
          (SELECT A.COMPANY_ID,
       EXTRACT(YEAR FROM A.CREATE_TIME) YEAR,
       DECODE(TO_CHAR( A.CREATE_TIME,'Q'),1,1,2,1,3,2,4,2) HALFYEAR,
       D.CATEGORY,
       (CASE WHEN D.GROUP_NAME IS NULL THEN  '1'  ELSE D.GROUP_NAME END) GROUP_NAME,
       '01' COUNT_DIMENSION,
       (CASE WHEN D.GROUP_NAME IS NULL THEN  '1'  ELSE D.GROUP_NAME END) DIMENSION_SORT,
       SUM(B.AMOUNT * E.PRICE) ORDER_MONEY
  FROM SCMDATA.T_INGOOD A
 INNER JOIN SCMDATA.T_INGOODS B
    ON A.ING_ID = B.ING_ID
   AND A.COMPANY_ID = B.COMPANY_ID
 INNER JOIN SCMDATA.T_ORDERED C
    ON C.ORDER_CODE = A.DOCUMENT_NO
   AND A.COMPANY_ID = C.COMPANY_ID
 INNER JOIN SCMDATA.PT_ORDERED D
    ON D.ORDER_ID = C.ORDER_ID
   AND D.COMPANY_ID = C.COMPANY_ID
  INNER JOIN SCMDATA.T_COMMODITY_INFO E ON E.GOO_ID=B.GOO_ID AND E.COMPANY_ID=B.COMPANY_ID
 WHERE B.AMOUNT > 0
 GROUP BY A.COMPANY_ID,
          EXTRACT(YEAR FROM A.CREATE_TIME),
          DECODE(TO_CHAR( A.CREATE_TIME,'Q'),1,1,2,1,3,2,4,2),
          D.CATEGORY,
          D.GROUP_NAME) z ON Z.COMPANY_ID = Y.COMPANY_ID
          AND Z.YEAR = Y.YEAR
          AND Z.HALFYEAR = Y.HALFYEAR
          AND Z.CATEGORY = Y.CATEGORY
          AND Z.GROUP_NAME = Y.GROUP_NAME
          AND Z.COUNT_DIMENSION = Y.COUNT_DIMENSION
          AND Z.DIMENSION_SORT = Y.DIMENSION_SORT*/ ]';
    /*p_type = 0 更新全部历史数据
    p_type = 1  只更新上一个月的数据 */
     IF P_TYPE = 0 THEN
      --进货
      V_EXSQL1 := V_SQL1||V_WH_SQL2||V_U_SQL1||V_I_SQL1;
      --退货
      V_EXSQL2 := V_SQL2 || V_WH_SQL2 || V_U_SQL2 || V_I_SQL2;


    ELSIF P_TYPE = 1 THEN
      --进货
      V_EXSQL1 := V_SQL1||V_WM_SQL1||V_U_SQL1||V_I_SQL1;
      --退货
      V_EXSQL2 := V_SQL2 || V_WM_SQL1 || V_U_SQL2 || V_I_SQL2;
    END IF;
   EXECUTE IMMEDIATE V_EXSQL2;
     EXECUTE IMMEDIATE V_EXSQL1;
    --dbms_output.put_line(V_EXSQL1);
    --dbms_output.put_line(V_EXSQL2);

    --款式名称
    V_SQL1:=q'[MERGE INTO SCMDATA.T_RTKPI_HALFYEAR A
USING (SELECT Y.COMPANY_ID, Y.YEAR, Y.HALFYEAR, Y.CATEGORY,
              Y.GROUP_NAME, Y.COUNT_DIMENSION, Y.DIMENSION_SORT,
              Y.ORDER_MONEY INGOOD_MONEY
         FROM ( SELECT A.COMPANY_ID,
       EXTRACT(YEAR FROM A.CREATE_TIME) YEAR,
       DECODE(TO_CHAR( A.CREATE_TIME,'Q'),1,1,2,1,3,2,4,2) HALFYEAR,
       E.CATEGORY,
       (CASE WHEN D.GROUP_NAME IS NULL THEN  '1'  ELSE D.GROUP_NAME END) GROUP_NAME,
       '02' COUNT_DIMENSION,
       E.STYLE_NAME DIMENSION_SORT,
       SUM(A.AMOUNT * E.PRICE) ORDER_MONEY
  FROM (SELECT T.DOCUMENT_NO,
                    T.COMPANY_ID,
                    TRUNC(T.CREATE_TIME) CREATE_TIME,
                    SUM(TL.AMOUNT) AMOUNT,
                    TL.GOO_ID
               FROM SCMDATA.T_INGOOD T
              INNER JOIN (SELECT TI.ING_ID,
                                TI.COMPANY_ID,
                                TI.GOO_ID,
                                TI.AMOUNT
                           FROM SCMDATA.T_INGOODS TI
                          WHERE TI.AMOUNT > 0) TL
                 ON TL.ING_ID = T.ING_ID
                AND TL.COMPANY_ID = T.COMPANY_ID
              WHERE TO_CHAR(T.CREATE_TIME, 'yyyy') >= 2022
              GROUP BY T.DOCUMENT_NO,
                       T.COMPANY_ID,
                       TRUNC(T.CREATE_TIME),
                       TL.GOO_ID) A
                  /*SCMDATA.T_INGOOD A
                 INNER JOIN SCMDATA.T_INGOODS B
                    ON A.ING_ID = B.ING_ID
                   AND A.COMPANY_ID = B.COMPANY_ID
                 LEFT JOIN SCMDATA.T_ORDERED C
                    ON C.ORDER_CODE = A.DOCUMENT_NO
                   AND A.COMPANY_ID = C.COMPANY_ID*/
                 LEFT JOIN SCMDATA.PT_ORDERED D
                    ON D.PRODUCT_GRESS_CODE = A.DOCUMENT_NO
                   AND D.COMPANY_ID = A.COMPANY_ID
                  INNER JOIN SCMDATA.T_COMMODITY_INFO E ON E.GOO_ID=A.GOO_ID AND E.COMPANY_ID=A.COMPANY_ID
                 --WHERE B.AMOUNT > 0
 GROUP BY A.COMPANY_ID,
          EXTRACT(YEAR FROM A.CREATE_TIME),
          DECODE(TO_CHAR( A.CREATE_TIME,'Q'),1,1,2,1,3,2,4,2),
          E.CATEGORY,
          D.GROUP_NAME,
          E.STYLE_NAME) Y     ]';

    V_SQL2 := q'[MERGE INTO SCMDATA.T_RTKPI_HALFYEAR A
USING (SELECT Y.COMPANY_ID, Y.YEAR, Y.HALFYEAR, Y.CATEGORY,
              Y.GROUP_NAME, Y.COUNT_DIMENSION, Y.DIMENSION_SORT,
              /*Z.ORDER_MONEY INGOOD_MONEY,*/ Y.RMMONEY SHOP_RT_ORIGINAL_MONEY, X.RMMONEY2 SHOP_RT_MONEY

         FROM
         (SELECT A.COMPANY_ID, A.YEAR, DECODE(A.QUARTER,1,1,2,1,3,2,4,2) HALFYEAR,
                          B.CATEGORY,
                          (CASE
                            WHEN A.SUP_GROUP_NAME2 IS NULL THEN
                             '1'
                            ELSE
                             A.SUP_GROUP_NAME2
                          END) GROUP_NAME, '02' COUNT_DIMENSION,
                         B.STYLE_NAME DIMENSION_SORT,
                          SUM(CASE           WHEN REGEXP_COUNT(A.SUP_GROUP_NAME, ',') > 0 THEN
                                 A.EXAMOUNT /
                                 (REGEXP_COUNT(A.SUP_GROUP_NAME, ',') + 1) *
                                 B.PRICE
                                ELSE
                                 A.EXAMOUNT * B.PRICE
                              END) RMMONEY
                     FROM (SELECT Z.RM_ID, Z.COMPANY_ID, Z.YEAR, Z.QUARTER,
                                   Z.ACCESS_TIME, Z.GOO_ID, Z.EXAMOUNT,
                                   Z.SUP_GROUP_NAME, Z.AUDIT_TIME,
                                   REGEXP_SUBSTR(Z.SUP_GROUP_NAME,
                                                  '[^,]+',
                                                  1,
                                                  LEVEL) SUP_GROUP_NAME2
                              FROM   SCMDATA.T_RETURN_MANAGEMENT z
   CONNECT BY PRIOR RM_ID = RM_ID
          AND LEVEL <= LENGTH(z.SUP_GROUP_NAME) -
              LENGTH(REGEXP_REPLACE(z.SUP_GROUP_NAME, ',', '')) + 1
          AND PRIOR DBMS_RANDOM.VALUE IS NOT NULL) A
        INNER JOIN scmdata.T_COMMODITY_INFO B
             ON A.GOO_ID = B.GOO_ID
            AND A.COMPANY_ID = B.COMPANY_ID
       WHERE A.AUDIT_TIME IS NOT NULL
       GROUP BY A.COMPANY_ID,
                A.YEAR,
                DECODE(A.QUARTER,1,1,2,1,3,2,4,2),
                B.CATEGORY,
                 A.SUP_GROUP_NAME2,
                B.STYLE_NAME) Y

         LEFT JOIN (SELECT A.COMPANY_ID, A.YEAR, DECODE(A.QUARTER,1,1,2,1,3,2,4,2) HALFYEAR,
                          B.CATEGORY,
                          (CASE  WHEN A.SUP_GROUP_NAME2 IS NULL THEN '1'    ELSE   A.SUP_GROUP_NAME2 END) GROUP_NAME,
                           '02' COUNT_DIMENSION,
                         B.STYLE_NAME DIMENSION_SORT,
                          SUM(CASE
                                WHEN REGEXP_COUNT(A.SUP_GROUP_NAME, ',') > 0 THEN
                                 A.EXAMOUNT /
                                 (REGEXP_COUNT(A.SUP_GROUP_NAME, ',') + 1) *
                                 B.PRICE
                                ELSE
                                 A.EXAMOUNT * B.PRICE
                              END) RMMONEY2
                     FROM (SELECT Z.RM_ID, Z.COMPANY_ID, Z.YEAR, Z.QUARTER,
                                   Z.ACCESS_TIME, Z.GOO_ID, Z.EXAMOUNT,
                                   Z.SUP_GROUP_NAME, Z.AUDIT_TIME,
                                   Z.CAUSE_DETAIL_ID, Z.FIRST_DEPT_ID,
                                   Z.SECOND_DEPT_ID,
                                   REGEXP_SUBSTR(Z.SUP_GROUP_NAME,
                                                  '[^,]+',
                                                  1,
                                                  LEVEL) SUP_GROUP_NAME2
                              FROM SCMDATA.T_RETURN_MANAGEMENT Z
        CONNECT BY PRIOR RM_ID = RM_ID
               AND LEVEL <=
                   LENGTH(Z.SUP_GROUP_NAME) -
                   LENGTH(REGEXP_REPLACE(Z.SUP_GROUP_NAME, ',', '')) + 1
               AND PRIOR DBMS_RANDOM.VALUE IS NOT NULL) A
 INNER JOIN SCMDATA.T_COMMODITY_INFO B
    ON A.GOO_ID = B.GOO_ID
   AND A.COMPANY_ID = B.COMPANY_ID
  LEFT JOIN SCMDATA.T_ABNORMAL_DTL_CONFIG C
    ON A.CAUSE_DETAIL_ID = C.ABNORMAL_DTL_CONFIG_ID
   AND A.COMPANY_ID = C.COMPANY_ID
   AND C.ANOMALY_CLASSIFICATION = 'AC_QUALITY'
 INNER JOIN SCMDATA.SYS_COMPANY_DEPT D
    ON D.COMPANY_DEPT_ID = A.FIRST_DEPT_ID
 WHERE A.AUDIT_TIME IS NOT NULL
   AND C.CAUSE_CLASSIFICATION <> '银饰氧化问题'
   AND C.PROBLEM_CLASSIFICATION <> '非质量问题'
   AND D.DEPT_NAME = '供应链管理部'
 GROUP BY A.COMPANY_ID,
          A.YEAR,
          DECODE(A.QUARTER,1,1,2,1,3,2,4,2),
          B.CATEGORY,
          A.SUP_GROUP_NAME2,
          B.STYLE_NAME) X
           ON X.COMPANY_ID = Y.COMPANY_ID
          AND X.YEAR = Y.YEAR
          AND X.HALFYEAR = Y.HALFYEAR
          AND X.CATEGORY = Y.CATEGORY
          AND X.GROUP_NAME = Y.GROUP_NAME
          AND X.COUNT_DIMENSION = Y.COUNT_DIMENSION
          AND X.DIMENSION_SORT = Y.DIMENSION_SORT
       /*   LEFT JOIN ( SELECT A.COMPANY_ID,
       EXTRACT(YEAR FROM A.CREATE_TIME) YEAR,
       DECODE(TO_CHAR( A.CREATE_TIME,'Q'),1,1,2,1,3,2,4,2) HALFYEAR,
       D.CATEGORY,
       (CASE WHEN D.GROUP_NAME IS NULL THEN  '1'  ELSE D.GROUP_NAME END) GROUP_NAME,
       '02' COUNT_DIMENSION,
       D.STYLE_NAME DIMENSION_SORT,
       SUM(B.AMOUNT * E.PRICE) ORDER_MONEY
  FROM SCMDATA.T_INGOOD A
 INNER JOIN SCMDATA.T_INGOODS B
    ON A.ING_ID = B.ING_ID
   AND A.COMPANY_ID = B.COMPANY_ID
 INNER JOIN SCMDATA.T_ORDERED C
    ON C.ORDER_CODE = A.DOCUMENT_NO
   AND A.COMPANY_ID = C.COMPANY_ID
 INNER JOIN SCMDATA.PT_ORDERED D
    ON D.ORDER_ID = C.ORDER_ID
   AND D.COMPANY_ID = C.COMPANY_ID
  INNER JOIN SCMDATA.T_COMMODITY_INFO E ON E.GOO_ID=B.GOO_ID AND E.COMPANY_ID=B.COMPANY_ID
 WHERE B.AMOUNT > 0
 GROUP BY A.COMPANY_ID,
          EXTRACT(YEAR FROM A.CREATE_TIME),
          DECODE(TO_CHAR( A.CREATE_TIME,'Q'),1,1,2,1,3,2,4,2),
          D.CATEGORY,
          D.GROUP_NAME,
          D.STYLE_NAME) z ON Z.COMPANY_ID = Y.COMPANY_ID
          AND Z.YEAR = Y.YEAR
          AND Z.HALFYEAR = Y.HALFYEAR
          AND Z.CATEGORY = Y.CATEGORY
          AND Z.GROUP_NAME = Y.GROUP_NAME
          AND Z.COUNT_DIMENSION = Y.COUNT_DIMENSION
          AND Z.DIMENSION_SORT = Y.DIMENSION_SORT*/ ]';
    IF P_TYPE = 0 THEN
      --进货
      V_EXSQL1 := V_SQL1||V_WH_SQL2||V_U_SQL1||V_I_SQL1;
      --退货
      V_EXSQL2 := V_SQL2 || V_WH_SQL2 || V_U_SQL2 || V_I_SQL2;


    ELSIF P_TYPE = 1 THEN
      --进货
      V_EXSQL1 := V_SQL1||V_WM_SQL1||V_U_SQL1||V_I_SQL1;
      --退货
      V_EXSQL2 := V_SQL2 || V_WM_SQL1 || V_U_SQL2 || V_I_SQL2;
    END IF;
    EXECUTE IMMEDIATE V_EXSQL2;
     EXECUTE IMMEDIATE V_EXSQL1;
    --dbms_output.put_line(V_EXSQL1);
    --dbms_output.put_line(V_EXSQL2);

    --产品子类
    V_SQL1:=q'[MERGE INTO SCMDATA.T_RTKPI_HALFYEAR A
USING (SELECT Y.COMPANY_ID, Y.YEAR, Y.HALFYEAR,  Y.CATEGORY,
              Y.GROUP_NAME, Y.COUNT_DIMENSION, Y.DIMENSION_SORT,
              Y.ORDER_MONEY INGOOD_MONEY
       FROM (  SELECT A.COMPANY_ID,
       EXTRACT(YEAR FROM A.CREATE_TIME) YEAR,
       DECODE(TO_CHAR( A.CREATE_TIME,'Q'),1,1,2,1,3,2,4,2) HALFYEAR,
       E.CATEGORY,
       (CASE WHEN D.GROUP_NAME IS NULL THEN  '1'  ELSE D.GROUP_NAME END) GROUP_NAME,
       '03' COUNT_DIMENSION,
       E.SAMLL_CATEGORY DIMENSION_SORT,
       SUM(A.AMOUNT * E.PRICE) ORDER_MONEY
  FROM (SELECT T.DOCUMENT_NO,
                    T.COMPANY_ID,
                    TRUNC(T.CREATE_TIME) CREATE_TIME,
                    SUM(TL.AMOUNT) AMOUNT,
                    TL.GOO_ID
               FROM SCMDATA.T_INGOOD T
              INNER JOIN (SELECT TI.ING_ID,
                                TI.COMPANY_ID,
                                TI.GOO_ID,
                                TI.AMOUNT
                           FROM SCMDATA.T_INGOODS TI
                          WHERE TI.AMOUNT > 0) TL
                 ON TL.ING_ID = T.ING_ID
                AND TL.COMPANY_ID = T.COMPANY_ID
              WHERE TO_CHAR(T.CREATE_TIME, 'yyyy') >= 2022
              GROUP BY T.DOCUMENT_NO,
                       T.COMPANY_ID,
                       TRUNC(T.CREATE_TIME),
                       TL.GOO_ID) A
                  /*SCMDATA.T_INGOOD A
                 INNER JOIN SCMDATA.T_INGOODS B
                    ON A.ING_ID = B.ING_ID
                   AND A.COMPANY_ID = B.COMPANY_ID
                 LEFT JOIN SCMDATA.T_ORDERED C
                    ON C.ORDER_CODE = A.DOCUMENT_NO
                   AND A.COMPANY_ID = C.COMPANY_ID*/
                 LEFT JOIN SCMDATA.PT_ORDERED D
                    ON D.PRODUCT_GRESS_CODE = A.DOCUMENT_NO
                   AND D.COMPANY_ID = A.COMPANY_ID
                  INNER JOIN SCMDATA.T_COMMODITY_INFO E ON E.GOO_ID=A.GOO_ID AND E.COMPANY_ID=A.COMPANY_ID
                 --WHERE B.AMOUNT > 0
 GROUP BY A.COMPANY_ID,
          EXTRACT(YEAR FROM A.CREATE_TIME),
          DECODE(TO_CHAR(A.CREATE_TIME,'Q'),1,1,2,1,3,2,4,2),
          E.CATEGORY,
          D.GROUP_NAME,
          E.SAMLL_CATEGORY) Y       ]';

    V_SQL2 := q'[MERGE INTO SCMDATA.T_RTKPI_HALFYEAR A
USING (SELECT Y.COMPANY_ID, Y.YEAR, Y.HALFYEAR,  Y.CATEGORY,
              Y.GROUP_NAME, Y.COUNT_DIMENSION, Y.DIMENSION_SORT,
             /* Z.ORDER_MONEY INGOOD_MONEY,*/ Y.RMMONEY SHOP_RT_ORIGINAL_MONEY, X.RMMONEY2 SHOP_RT_MONEY

         FROM
         (SELECT A.COMPANY_ID, A.YEAR, DECODE(A.QUARTER,1,1,2,1,3,2,4,2) HALFYEAR,
                          B.CATEGORY,
                          (CASE
                            WHEN A.SUP_GROUP_NAME2 IS NULL THEN
                             '1'
                            ELSE
                             A.SUP_GROUP_NAME2
                          END) GROUP_NAME, '03' COUNT_DIMENSION,
                         B.SAMLL_CATEGORY DIMENSION_SORT,
                          SUM(CASE           WHEN REGEXP_COUNT(A.SUP_GROUP_NAME, ',') > 0 THEN
                                 A.EXAMOUNT /
                                 (REGEXP_COUNT(A.SUP_GROUP_NAME, ',') + 1) *
                                 B.PRICE
                                ELSE
                                 A.EXAMOUNT * B.PRICE
                              END) RMMONEY
                     FROM (SELECT Z.RM_ID, Z.COMPANY_ID, Z.YEAR, Z.QUARTER,
                                   Z.ACCESS_TIME, Z.GOO_ID, Z.EXAMOUNT,
                                   Z.SUP_GROUP_NAME, Z.AUDIT_TIME,
                                   REGEXP_SUBSTR(Z.SUP_GROUP_NAME,
                                                  '[^,]+',
                                                  1,
                                                  LEVEL) SUP_GROUP_NAME2
                              FROM  SCMDATA.T_RETURN_MANAGEMENT z
   CONNECT BY PRIOR RM_ID = RM_ID
          AND LEVEL <= LENGTH(z.SUP_GROUP_NAME) -
              LENGTH(REGEXP_REPLACE(z.SUP_GROUP_NAME, ',', '')) + 1
          AND PRIOR DBMS_RANDOM.VALUE IS NOT NULL) A
        INNER JOIN scmdata.T_COMMODITY_INFO B
             ON A.GOO_ID = B.GOO_ID
            AND A.COMPANY_ID = B.COMPANY_ID
       WHERE A.AUDIT_TIME IS NOT NULL
       GROUP BY A.COMPANY_ID,
                A.YEAR,
                DECODE(A.QUARTER,1,1,2,1,3,2,4,2),
                B.CATEGORY,
                 A.SUP_GROUP_NAME2,
                B.SAMLL_CATEGORY) Y

         LEFT JOIN (SELECT A.COMPANY_ID, A.YEAR, DECODE(A.QUARTER,1,1,2,1,3,2,4,2) HALFYEAR,
                          B.CATEGORY,
                          (CASE  WHEN A.SUP_GROUP_NAME2 IS NULL THEN '1'    ELSE   A.SUP_GROUP_NAME2 END) GROUP_NAME,
                           '03' COUNT_DIMENSION,
                         B.SAMLL_CATEGORY DIMENSION_SORT,
                          SUM(CASE
                                WHEN REGEXP_COUNT(A.SUP_GROUP_NAME, ',') > 0 THEN
                                 A.EXAMOUNT /
                                 (REGEXP_COUNT(A.SUP_GROUP_NAME, ',') + 1) *
                                 B.PRICE
                                ELSE
                                 A.EXAMOUNT * B.PRICE
                              END) RMMONEY2
                     FROM (SELECT Z.RM_ID, Z.COMPANY_ID, Z.YEAR, Z.QUARTER,
                                   Z.ACCESS_TIME, Z.GOO_ID, Z.EXAMOUNT,
                                   Z.SUP_GROUP_NAME, Z.AUDIT_TIME,
                                   Z.CAUSE_DETAIL_ID, Z.FIRST_DEPT_ID,
                                   Z.SECOND_DEPT_ID,
                                   REGEXP_SUBSTR(Z.SUP_GROUP_NAME,
                                                  '[^,]+',
                                                  1,
                                                  LEVEL) SUP_GROUP_NAME2
                              FROM SCMDATA.T_RETURN_MANAGEMENT Z
        CONNECT BY PRIOR RM_ID = RM_ID
               AND LEVEL <=
                   LENGTH(Z.SUP_GROUP_NAME) -
                   LENGTH(REGEXP_REPLACE(Z.SUP_GROUP_NAME, ',', '')) + 1
               AND PRIOR DBMS_RANDOM.VALUE IS NOT NULL) A
 INNER JOIN SCMDATA.T_COMMODITY_INFO B
    ON A.GOO_ID = B.GOO_ID
   AND A.COMPANY_ID = B.COMPANY_ID
  LEFT JOIN SCMDATA.T_ABNORMAL_DTL_CONFIG C
    ON A.CAUSE_DETAIL_ID = C.ABNORMAL_DTL_CONFIG_ID
   AND A.COMPANY_ID = C.COMPANY_ID
   AND C.ANOMALY_CLASSIFICATION = 'AC_QUALITY'
 INNER JOIN SCMDATA.SYS_COMPANY_DEPT D
    ON D.COMPANY_DEPT_ID = A.FIRST_DEPT_ID
 WHERE A.AUDIT_TIME IS NOT NULL
   AND C.CAUSE_CLASSIFICATION <> '银饰氧化问题'
   AND C.PROBLEM_CLASSIFICATION <> '非质量问题'
   AND D.DEPT_NAME = '供应链管理部'
 GROUP BY A.COMPANY_ID,
          A.YEAR,
         DECODE(A.QUARTER,1,1,2,1,3,2,4,2),
          B.CATEGORY,
          A.SUP_GROUP_NAME2,
          B.SAMLL_CATEGORY) X
           ON X.COMPANY_ID = Y.COMPANY_ID
          AND X.YEAR = Y.YEAR
          AND X.HALFYEAR = Y.HALFYEAR
          AND X.CATEGORY = Y.CATEGORY
          AND X.GROUP_NAME = Y.GROUP_NAME
          AND X.COUNT_DIMENSION = Y.COUNT_DIMENSION
          AND X.DIMENSION_SORT = Y.DIMENSION_SORT
         /* LEFT JOIN
          (  SELECT A.COMPANY_ID,
       EXTRACT(YEAR FROM A.CREATE_TIME) YEAR,
       DECODE(TO_CHAR( A.CREATE_TIME,'Q'),1,1,2,1,3,2,4,2) HALFYEAR,
       D.CATEGORY,
       (CASE WHEN D.GROUP_NAME IS NULL THEN  '1'  ELSE D.GROUP_NAME END) GROUP_NAME,
       '03' COUNT_DIMENSION,
       D.SAMLL_CATEGORY DIMENSION_SORT,
       SUM(B.AMOUNT * E.PRICE) ORDER_MONEY
  FROM SCMDATA.T_INGOOD A
 INNER JOIN SCMDATA.T_INGOODS B
    ON A.ING_ID = B.ING_ID
   AND A.COMPANY_ID = B.COMPANY_ID
 INNER JOIN SCMDATA.T_ORDERED C
    ON C.ORDER_CODE = A.DOCUMENT_NO
   AND A.COMPANY_ID = C.COMPANY_ID
 INNER JOIN SCMDATA.PT_ORDERED D
    ON D.ORDER_ID = C.ORDER_ID
   AND D.COMPANY_ID = C.COMPANY_ID
  INNER JOIN SCMDATA.T_COMMODITY_INFO E ON E.GOO_ID=B.GOO_ID AND E.COMPANY_ID=B.COMPANY_ID
 WHERE B.AMOUNT > 0
 GROUP BY A.COMPANY_ID,
          EXTRACT(YEAR FROM A.CREATE_TIME),
          DECODE(TO_CHAR(A.CREATE_TIME,'Q'),1,1,2,1,3,2,4,2),
          D.CATEGORY,
          D.GROUP_NAME,
          D.SAMLL_CATEGORY) z ON Z.COMPANY_ID = Y.COMPANY_ID
          AND Z.YEAR = Y.YEAR
          AND Z.HALFYEAR = Y.HALFYEAR
          AND Z.CATEGORY = Y.CATEGORY
          AND Z.GROUP_NAME = Y.GROUP_NAME
          AND Z.COUNT_DIMENSION = Y.COUNT_DIMENSION
          AND Z.DIMENSION_SORT = Y.DIMENSION_SORT*/ ]';
   IF P_TYPE = 0 THEN
      --进货
      V_EXSQL1 := V_SQL1||V_WH_SQL2||V_U_SQL1||V_I_SQL1;
      --退货
      V_EXSQL2 := V_SQL2 || V_WH_SQL2 || V_U_SQL2 || V_I_SQL2;


    ELSIF P_TYPE = 1 THEN
      --进货
      V_EXSQL1 := V_SQL1||V_WM_SQL1||V_U_SQL1||V_I_SQL1;
      --退货
      V_EXSQL2 := V_SQL2 || V_WM_SQL1 || V_U_SQL2 || V_I_SQL2;
    END IF;
    EXECUTE IMMEDIATE V_EXSQL2;
     EXECUTE IMMEDIATE V_EXSQL1;
    --dbms_output.put_line(V_EXSQL1);
    --dbms_output.put_line(V_EXSQL2);

    --  供应商
    V_SQL1:=q'[ MERGE INTO SCMDATA.T_RTKPI_HALFYEAR A
USING (SELECT Y.COMPANY_ID, Y.YEAR, Y.HALFYEAR,  Y.CATEGORY,
              Y.GROUP_NAME, Y.COUNT_DIMENSION, Y.DIMENSION_SORT,
              Y.ORDER_MONEY INGOOD_MONEY
        FROM (  SELECT A.COMPANY_ID,
       EXTRACT(YEAR FROM A.CREATE_TIME) YEAR,
       DECODE(TO_CHAR(A.CREATE_TIME,'Q'),1,1,2,1,3,2,4,2) HALFYEAR,
       E.CATEGORY,
       (CASE WHEN D.GROUP_NAME IS NULL THEN  '1'  ELSE D.GROUP_NAME END) GROUP_NAME,
       '04' COUNT_DIMENSION,
       A.SUPPLIER_CODE DIMENSION_SORT,
       SUM(A.AMOUNT * E.PRICE) ORDER_MONEY
  FROM (SELECT T.DOCUMENT_NO,
                    T.COMPANY_ID,
                    TRUNC(T.CREATE_TIME) CREATE_TIME,
                    SUM(TL.AMOUNT) AMOUNT,
                    T.SUPPLIER_CODE,
                    TL.GOO_ID
               FROM SCMDATA.T_INGOOD T
              INNER JOIN (SELECT TI.ING_ID,
                                TI.COMPANY_ID,
                                TI.GOO_ID,
                                TI.AMOUNT
                           FROM SCMDATA.T_INGOODS TI
                          WHERE TI.AMOUNT > 0) TL
                 ON TL.ING_ID = T.ING_ID
                AND TL.COMPANY_ID = T.COMPANY_ID
              WHERE TO_CHAR(T.CREATE_TIME, 'yyyy') >= 2022
              GROUP BY T.DOCUMENT_NO,
                       T.COMPANY_ID,
                       TRUNC(T.CREATE_TIME),
                       T.SUPPLIER_CODE,
                       TL.GOO_ID) A
                  /*SCMDATA.T_INGOOD A
                 INNER JOIN SCMDATA.T_INGOODS B
                    ON A.ING_ID = B.ING_ID
                   AND A.COMPANY_ID = B.COMPANY_ID
                 LEFT JOIN SCMDATA.T_ORDERED C
                    ON C.ORDER_CODE = A.DOCUMENT_NO
                   AND A.COMPANY_ID = C.COMPANY_ID*/
                 LEFT JOIN SCMDATA.PT_ORDERED D
                    ON D.PRODUCT_GRESS_CODE = A.DOCUMENT_NO
                   AND D.COMPANY_ID = A.COMPANY_ID
                  INNER JOIN SCMDATA.T_COMMODITY_INFO E ON E.GOO_ID=A.GOO_ID AND E.COMPANY_ID=A.COMPANY_ID
                 --WHERE B.AMOUNT > 0
 GROUP BY A.COMPANY_ID,
          EXTRACT(YEAR FROM A.CREATE_TIME),
          DECODE(TO_CHAR(A.CREATE_TIME,'Q'),1,1,2,1,3,2,4,2),
          E.CATEGORY,
          D.GROUP_NAME,
          A.SUPPLIER_CODE) Y      ]';


    V_SQL2 := q'[ MERGE INTO SCMDATA.T_RTKPI_HALFYEAR A
USING (SELECT Y.COMPANY_ID, Y.YEAR, Y.HALFYEAR,  Y.CATEGORY,
              Y.GROUP_NAME, Y.COUNT_DIMENSION, Y.DIMENSION_SORT,
              /*Z.ORDER_MONEY INGOOD_MONEY,*/ Y.RMMONEY SHOP_RT_ORIGINAL_MONEY, X.RMMONEY2 SHOP_RT_MONEY

         FROM
         (SELECT A.COMPANY_ID, A.YEAR,DECODE(A.QUARTER,1,1,2,1,3,2,4,2) HALFYEAR,
                          B.CATEGORY,
                          (CASE
                            WHEN A.SUP_GROUP_NAME2 IS NULL THEN
                             '1'
                            ELSE
                             A.SUP_GROUP_NAME2
                          END) GROUP_NAME, '04' COUNT_DIMENSION,
                         A.SUPPLIER_CODE DIMENSION_SORT,
                          SUM(CASE           WHEN REGEXP_COUNT(A.SUP_GROUP_NAME, ',') > 0 THEN
                                 A.EXAMOUNT /
                                 (REGEXP_COUNT(A.SUP_GROUP_NAME, ',') + 1) *
                                 B.PRICE
                                ELSE
                                 A.EXAMOUNT * B.PRICE
                              END) RMMONEY
                     FROM (SELECT Z.RM_ID, Z.COMPANY_ID, Z.YEAR, Z.QUARTER,
                                   Z.ACCESS_TIME, Z.GOO_ID, Z.EXAMOUNT,
                                   Z.SUP_GROUP_NAME, Z.AUDIT_TIME,
                                   Z.SUPPLIER_CODE,
                                   REGEXP_SUBSTR(Z.SUP_GROUP_NAME,
                                                  '[^,]+',
                                                  1,
                                                  LEVEL) SUP_GROUP_NAME2
                              FROM SCMDATA.T_RETURN_MANAGEMENT z
   CONNECT BY PRIOR RM_ID = RM_ID
          AND LEVEL <= LENGTH(z.SUP_GROUP_NAME) -
              LENGTH(REGEXP_REPLACE(z.SUP_GROUP_NAME, ',', '')) + 1
          AND PRIOR DBMS_RANDOM.VALUE IS NOT NULL) A
        INNER JOIN scmdata.T_COMMODITY_INFO B
             ON A.GOO_ID = B.GOO_ID
            AND A.COMPANY_ID = B.COMPANY_ID
       WHERE A.AUDIT_TIME IS NOT NULL
       GROUP BY A.COMPANY_ID,
                A.YEAR,
                DECODE(A.QUARTER,1,1,2,1,3,2,4,2),
                B.CATEGORY,
                 A.SUP_GROUP_NAME2,
                A.SUPPLIER_CODE) Y

         LEFT JOIN (SELECT A.COMPANY_ID, A.YEAR,DECODE(A.QUARTER,1,1,2,1,3,2,4,2) HALFYEAR,
                          B.CATEGORY,
                          (CASE  WHEN A.SUP_GROUP_NAME2 IS NULL THEN '1'    ELSE   A.SUP_GROUP_NAME2 END) GROUP_NAME,
                           '04' COUNT_DIMENSION,
                         A.SUPPLIER_CODE DIMENSION_SORT,
                          SUM(CASE
                                WHEN REGEXP_COUNT(A.SUP_GROUP_NAME, ',') > 0 THEN
                                 A.EXAMOUNT /
                                 (REGEXP_COUNT(A.SUP_GROUP_NAME, ',') + 1) *
                                 B.PRICE
                                ELSE
                                 A.EXAMOUNT * B.PRICE
                              END) RMMONEY2
                     FROM (SELECT Z.RM_ID, Z.COMPANY_ID, Z.YEAR, Z.QUARTER,
                                   Z.ACCESS_TIME, Z.GOO_ID, Z.EXAMOUNT,
                                   Z.SUP_GROUP_NAME, Z.AUDIT_TIME,
                                   Z.CAUSE_DETAIL_ID, Z.FIRST_DEPT_ID,
                                   Z.SECOND_DEPT_ID,
                                   Z.SUPPLIER_CODE,
                                   REGEXP_SUBSTR(Z.SUP_GROUP_NAME,
                                                  '[^,]+',
                                                  1,
                                                  LEVEL) SUP_GROUP_NAME2
                              FROM SCMDATA.T_RETURN_MANAGEMENT Z
        CONNECT BY PRIOR RM_ID = RM_ID
               AND LEVEL <=
                   LENGTH(Z.SUP_GROUP_NAME) -
                   LENGTH(REGEXP_REPLACE(Z.SUP_GROUP_NAME, ',', '')) + 1
               AND PRIOR DBMS_RANDOM.VALUE IS NOT NULL) A
 INNER JOIN SCMDATA.T_COMMODITY_INFO B
    ON A.GOO_ID = B.GOO_ID
   AND A.COMPANY_ID = B.COMPANY_ID
  LEFT JOIN SCMDATA.T_ABNORMAL_DTL_CONFIG C
    ON A.CAUSE_DETAIL_ID = C.ABNORMAL_DTL_CONFIG_ID
   AND A.COMPANY_ID = C.COMPANY_ID
   AND C.ANOMALY_CLASSIFICATION = 'AC_QUALITY'
 INNER JOIN SCMDATA.SYS_COMPANY_DEPT D
    ON D.COMPANY_DEPT_ID = A.FIRST_DEPT_ID
 WHERE A.AUDIT_TIME IS NOT NULL
   AND C.CAUSE_CLASSIFICATION <> '银饰氧化问题'
   AND C.PROBLEM_CLASSIFICATION <> '非质量问题'
   AND D.DEPT_NAME = '供应链管理部'
 GROUP BY A.COMPANY_ID,
          A.YEAR,
          DECODE(A.QUARTER,1,1,2,1,3,2,4,2),
          B.CATEGORY,
          A.SUP_GROUP_NAME2,
          A.SUPPLIER_CODE) X
           ON X.COMPANY_ID = Y.COMPANY_ID
          AND X.YEAR = Y.YEAR
          AND X.HALFYEAR = Y.HALFYEAR
          AND X.CATEGORY = Y.CATEGORY
          AND X.GROUP_NAME = Y.GROUP_NAME
          AND X.COUNT_DIMENSION = Y.COUNT_DIMENSION
          AND X.DIMENSION_SORT = Y.DIMENSION_SORT
         /* LEFT JOIN
          --进货数据
          (  SELECT A.COMPANY_ID,
       EXTRACT(YEAR FROM A.CREATE_TIME) YEAR,
       DECODE(TO_CHAR(A.CREATE_TIME,'Q'),1,1,2,1,3,2,4,2) HALFYEAR,
       D.CATEGORY,
       (CASE WHEN D.GROUP_NAME IS NULL THEN  '1'  ELSE D.GROUP_NAME END) GROUP_NAME,
       '04' COUNT_DIMENSION,
       C.SUPPLIER_CODE DIMENSION_SORT,
       SUM(B.AMOUNT * E.PRICE) ORDER_MONEY
  FROM SCMDATA.T_INGOOD A
 INNER JOIN SCMDATA.T_INGOODS B
    ON A.ING_ID = B.ING_ID
   AND A.COMPANY_ID = B.COMPANY_ID
 INNER JOIN SCMDATA.T_ORDERED C
    ON C.ORDER_CODE = A.DOCUMENT_NO
   AND A.COMPANY_ID = C.COMPANY_ID
 INNER JOIN SCMDATA.PT_ORDERED D
    ON D.ORDER_ID = C.ORDER_ID
   AND D.COMPANY_ID = C.COMPANY_ID
  INNER JOIN SCMDATA.T_COMMODITY_INFO E ON E.GOO_ID=B.GOO_ID AND E.COMPANY_ID=B.COMPANY_ID
 WHERE B.AMOUNT > 0
 GROUP BY A.COMPANY_ID,
          EXTRACT(YEAR FROM A.CREATE_TIME),
          DECODE(TO_CHAR(A.CREATE_TIME,'Q'),1,1,2,1,3,2,4,2),
          D.CATEGORY,
          D.GROUP_NAME,
          C.SUPPLIER_CODE) z ON Z.COMPANY_ID = Y.COMPANY_ID
          AND Z.YEAR = Y.YEAR
          AND Z.HALFYEAR = Y.HALFYEAR
          AND Z.CATEGORY = Y.CATEGORY
          AND Z.GROUP_NAME = Y.GROUP_NAME
          AND Z.COUNT_DIMENSION = Y.COUNT_DIMENSION
          AND Z.DIMENSION_SORT = Y.DIMENSION_SORT */]';

   IF P_TYPE = 0 THEN
      --进货
      V_EXSQL1 := V_SQL1||V_WH_SQL2||V_U_SQL1||V_I_SQL1;
      --退货
      V_EXSQL2 := V_SQL2 || V_WH_SQL2 || V_U_SQL2 || V_I_SQL2;


    ELSIF P_TYPE = 1 THEN
      --进货
      V_EXSQL1 := V_SQL1||V_WM_SQL1||V_U_SQL1||V_I_SQL1;
      --退货
      V_EXSQL2 := V_SQL2 || V_WM_SQL1 || V_U_SQL2 || V_I_SQL2;
    END IF;
   EXECUTE IMMEDIATE V_EXSQL2;
     EXECUTE IMMEDIATE V_EXSQL1;
    --dbms_output.put_line(V_EXSQL1);
    --dbms_output.put_line(V_EXSQL2);

    --跟单
    V_SQL1:=q'[MERGE INTO SCMDATA.T_RTKPI_HALFYEAR A
USING (SELECT Y.COMPANY_ID, Y.YEAR, Y.HALFYEAR,  Y.CATEGORY, Y.GROUP_NAME,
       Y.COUNT_DIMENSION, 
       Y.DIMENSION_SORT, Y.ORDER_MONEY INGOOD_MONEY
   FROM (SELECT A.COMPANY_ID, EXTRACT(YEAR FROM A.CREATE_TIME) YEAR,
                    DECODE(TO_CHAR(A.CREATE_TIME,'Q'),1,1,2,1,3,2,4,2) HALFYEAR,
                    E.CATEGORY,
                    (CASE  WHEN D.GROUP_NAME IS NULL THEN  '1' ELSE D.GROUP_NAME END) GROUP_NAME, 
                    '05' COUNT_DIMENSION,
                    (CASE  WHEN D.GENDAN IS NULL OR D.GENDAN = 'ORDERED_ITF' THEN '1' ELSE D.GENDAN END) DIMENSION_SORT,
                    SUM(CASE
                          WHEN REGEXP_COUNT(D.FLW_ORDER, ',') > 0 THEN
                           A.AMOUNT / NVL((REGEXP_COUNT(D.FLW_ORDER, ',') + 1),1) *
                           E.PRICE
                          ELSE
                           A.AMOUNT * E.PRICE
                        END) ORDER_MONEY
               FROM (SELECT T.DOCUMENT_NO,
                    T.COMPANY_ID,
                    TRUNC(T.CREATE_TIME) CREATE_TIME,
                    SUM(TL.AMOUNT) AMOUNT,
                    TL.GOO_ID
               FROM SCMDATA.T_INGOOD T
              INNER JOIN (SELECT TI.ING_ID,
                                TI.COMPANY_ID,
                                TI.GOO_ID,
                                TI.AMOUNT
                           FROM SCMDATA.T_INGOODS TI
                          WHERE TI.AMOUNT > 0) TL
                 ON TL.ING_ID = T.ING_ID
                AND TL.COMPANY_ID = T.COMPANY_ID
              WHERE TO_CHAR(T.CREATE_TIME, 'yyyy') >= 2022
              GROUP BY T.DOCUMENT_NO,
                       T.COMPANY_ID,
                       TRUNC(T.CREATE_TIME),
                       TL.GOO_ID) A
                  /*SCMDATA.T_INGOOD A
                 INNER JOIN SCMDATA.T_INGOODS B
                    ON A.ING_ID = B.ING_ID
                   AND A.COMPANY_ID = B.COMPANY_ID
                 LEFT JOIN SCMDATA.T_ORDERED C
                    ON C.ORDER_CODE = A.DOCUMENT_NO
                   AND A.COMPANY_ID = C.COMPANY_ID*/
              LEFT JOIN (SELECT Z.*,
                                REGEXP_SUBSTR(Z.FLW_ORDER, '[^,]+', 1, LEVEL) GENDAN
                           FROM SCMDATA.PT_ORDERED Z
                         CONNECT BY PRIOR Z.PT_ORDERED_ID = Z.PT_ORDERED_ID
                                AND LEVEL <=
                                    LENGTH(Z.FLW_ORDER) -
                                    LENGTH(REGEXP_REPLACE(Z.FLW_ORDER,
                                                          ',',
                                                          '')) + 1
                                AND PRIOR DBMS_RANDOM.VALUE IS NOT NULL) D
                 ON D.PRODUCT_GRESS_CODE = A.DOCUMENT_NO
                AND D.COMPANY_ID = A.COMPANY_ID
               INNER JOIN SCMDATA.T_COMMODITY_INFO E ON E.GOO_ID=A.GOO_ID AND E.COMPANY_ID=A.COMPANY_ID
              --WHERE B.AMOUNT > 0
              GROUP BY A.COMPANY_ID, EXTRACT(YEAR FROM A.CREATE_TIME),
                       DECODE(TO_CHAR(A.CREATE_TIME,'Q'),1,1,2,1,3,2,4,2), E.CATEGORY,
                       (CASE  WHEN D.GROUP_NAME IS NULL THEN  '1' ELSE D.GROUP_NAME END), 
                       (CASE  WHEN D.GENDAN IS NULL OR D.GENDAN = 'ORDERED_ITF' THEN '1' ELSE D.GENDAN END)) Y    ]';

    V_SQL2 := q'[  MERGE INTO SCMDATA.T_RTKPI_HALFYEAR A
USING (
WITH TEMP_RT AS
 (SELECT Z.*,
         Z.RM_ID || ROW_NUMBER() OVER(PARTITION BY Z.RM_ID ORDER BY 1) RM_ID2,
         Z.EXAMOUNT / (COUNT(Z.RM_ID) OVER(PARTITION BY(Z.RM_ID))) EXGAMOUNT2,
         REGEXP_SUBSTR(Z.SUP_GROUP_NAME, '[^,]+', 1, LEVEL) SUP_GROUP_NAME2
    FROM SCMDATA.T_RETURN_MANAGEMENT Z
   WHERE Z.AUDIT_TIME IS NOT NULL
  CONNECT BY PRIOR RM_ID = RM_ID
         AND LEVEL <= LENGTH(Z.SUP_GROUP_NAME) -
             LENGTH(REGEXP_REPLACE(Z.SUP_GROUP_NAME, ',', '')) + 1
         AND PRIOR DBMS_RANDOM.VALUE IS NOT NULL)

SELECT Y.COMPANY_ID, Y.YEAR, Y.HALFYEAR,  Y.CATEGORY, Y.GROUP_NAME,
       Y.COUNT_DIMENSION, Y.DIMENSION_SORT, /*Z.ORDER_MONEY INGOOD_MONEY,*/
       Y.RMMONEY SHOP_RT_ORIGINAL_MONEY, X.RMMONEY2 SHOP_RT_MONEY

  FROM (SELECT A.COMPANY_ID, A.YEAR, DECODE(A.QUARTER,1,1,2,1,3,2,4,2) HALFYEAR, B.CATEGORY,
                (CASE
                  WHEN A.SUP_GROUP_NAME2 IS NULL THEN
                   '1'
                  ELSE
                   A.SUP_GROUP_NAME2
                END) GROUP_NAME, '05' COUNT_DIMENSION,
                (CASE
                  WHEN A.GENDAN2 IS NULL THEN
                   '1'
                  ELSE
                   A.GENDAN2
                END) DIMENSION_SORT, SUM(A.EXGAMOUNT3 * B.PRICE) RMMONEY
           FROM (SELECT Z.RM_ID, Z.COMPANY_ID, Z.YEAR, Z.QUARTER, Z.ACCESS_TIME,
                         Z.GOO_ID, Z.EXAMOUNT, Z.SUP_GROUP_NAME, Z.AUDIT_TIME,
                         Z.SUP_GROUP_NAME2,
                         Z.EXGAMOUNT2 / NVL((REGEXP_COUNT(Z.MERCHER_ID, ',') + 1),1) EXGAMOUNT3,
                         REGEXP_SUBSTR(Z.MERCHER_ID, '[^,]+', 1, LEVEL) GENDAN2
                    FROM TEMP_RT Z

                  CONNECT BY PRIOR Z.RM_ID2 = Z.RM_ID2
                         AND LEVEL <=
                             LENGTH(Z.MERCHER_ID) -
                             LENGTH(REGEXP_REPLACE(Z.MERCHER_ID, ',', '')) + 1
                         AND PRIOR DBMS_RANDOM.VALUE IS NOT NULL) A
          INNER JOIN SCMDATA.T_COMMODITY_INFO B
             ON A.GOO_ID = B.GOO_ID
            AND A.COMPANY_ID = B.COMPANY_ID
          WHERE A.AUDIT_TIME IS NOT NULL
          GROUP BY A.COMPANY_ID, A.YEAR, DECODE(A.QUARTER,1,1,2,1,3,2,4,2), B.CATEGORY,
                   A.SUP_GROUP_NAME2, A.GENDAN2) Y

  LEFT JOIN (SELECT A.COMPANY_ID, A.YEAR, DECODE(A.QUARTER,1,1,2,1,3,2,4,2) HALFYEAR,
                    B.CATEGORY,
                    (CASE
                      WHEN A.SUP_GROUP_NAME2 IS NULL THEN
                       '1'
                      ELSE
                       A.SUP_GROUP_NAME2
                    END) GROUP_NAME, '05' COUNT_DIMENSION,
                    (CASE
                      WHEN A.GENDAN2 IS NULL THEN
                       '1'
                      ELSE
                       A.GENDAN2
                    END) DIMENSION_SORT, SUM(A.EXGAMOUNT3 * B.PRICE) RMMONEY2
               FROM (SELECT Z.RM_ID, Z.COMPANY_ID, Z.YEAR, Z.QUARTER,
                             Z.ACCESS_TIME, Z.GOO_ID, Z.EXAMOUNT,
                             Z.SUP_GROUP_NAME, Z.AUDIT_TIME, Z.CAUSE_DETAIL_ID,
                             Z.FIRST_DEPT_ID, Z.SUP_GROUP_NAME2,
                             Z.SECOND_DEPT_ID,
                             Z.EXGAMOUNT2 /
                              NVL((REGEXP_COUNT(Z.MERCHER_ID, ',') + 1),1) EXGAMOUNT3,
                             REGEXP_SUBSTR(Z.MERCHER_ID, '[^,]+', 1, LEVEL) GENDAN2
                        FROM TEMP_RT Z

                      CONNECT BY PRIOR Z.RM_ID2 = Z.RM_ID2
                             AND LEVEL <=
                                 LENGTH(Z.MERCHER_ID) -
                                 LENGTH(REGEXP_REPLACE(Z.MERCHER_ID, ',', '')) + 1
                             AND PRIOR DBMS_RANDOM.VALUE IS NOT NULL) A
              INNER JOIN SCMDATA.T_COMMODITY_INFO B
                 ON A.GOO_ID = B.GOO_ID
                AND A.COMPANY_ID = B.COMPANY_ID
               LEFT JOIN SCMDATA.T_ABNORMAL_DTL_CONFIG C
                 ON A.CAUSE_DETAIL_ID = C.ABNORMAL_DTL_CONFIG_ID
                AND A.COMPANY_ID = C.COMPANY_ID
                AND C.ANOMALY_CLASSIFICATION = 'AC_QUALITY'
              INNER JOIN SCMDATA.SYS_COMPANY_DEPT D
                 ON D.COMPANY_DEPT_ID = A.FIRST_DEPT_ID
              WHERE A.AUDIT_TIME IS NOT NULL
                AND C.CAUSE_CLASSIFICATION <> '银饰氧化问题'
                AND C.PROBLEM_CLASSIFICATION <> '非质量问题'
                AND D.DEPT_NAME = '供应链管理部'
                AND INSTR(A.SECOND_DEPT_ID,
                          'b550778b4f2d36b4e0533c281caca074') > 0
              GROUP BY A.COMPANY_ID, A.YEAR, DECODE(A.QUARTER,1,1,2,1,3,2,4,2), B.CATEGORY,
                       A.SUP_GROUP_NAME2, A.GENDAN2) X
    ON X.COMPANY_ID = Y.COMPANY_ID
   AND X.YEAR = Y.YEAR
   AND X.HALFYEAR = Y.HALFYEAR
   AND X.CATEGORY = Y.CATEGORY
   AND X.GROUP_NAME = Y.GROUP_NAME
   AND X.COUNT_DIMENSION = Y.COUNT_DIMENSION
   AND X.DIMENSION_SORT = Y.DIMENSION_SORT
 /* LEFT JOIN (SELECT A.COMPANY_ID, EXTRACT(YEAR FROM A.CREATE_TIME) YEAR,
                    DECODE(TO_CHAR(A.CREATE_TIME,'Q'),1,1,2,1,3,2,4,2) HALFYEAR,
                    D.CATEGORY,
                    (CASE
                      WHEN D.GROUP_NAME IS NULL THEN
                       '1'
                      ELSE
                       D.GROUP_NAME
                    END) GROUP_NAME, '05' COUNT_DIMENSION,
                    (CASE
                      WHEN D.GENDAN IS NULL THEN
                       '1'
                      ELSE
                       D.GENDAN
                    END) DIMENSION_SORT,
                    SUM(CASE
                          WHEN REGEXP_COUNT(D.FLW_ORDER, ',') > 0 THEN
                           B.AMOUNT / NVL((REGEXP_COUNT(D.FLW_ORDER, ',') + 1),1) *
                           E.PRICE
                          ELSE
                           B.AMOUNT * E.PRICE
                        END) ORDER_MONEY
               FROM SCMDATA.T_INGOOD A
              INNER JOIN SCMDATA.T_INGOODS B
                 ON A.ING_ID = B.ING_ID
                AND A.COMPANY_ID = B.COMPANY_ID
              INNER JOIN SCMDATA.T_ORDERED C
                 ON C.ORDER_CODE = A.DOCUMENT_NO
                AND A.COMPANY_ID = C.COMPANY_ID
              INNER JOIN (SELECT Z.*,
                                REGEXP_SUBSTR(Z.FLW_ORDER, '[^,]+', 1, LEVEL) GENDAN
                           FROM SCMDATA.PT_ORDERED Z
                         CONNECT BY PRIOR Z.PT_ORDERED_ID = Z.PT_ORDERED_ID
                                AND LEVEL <=
                                    LENGTH(Z.FLW_ORDER) -
                                    LENGTH(REGEXP_REPLACE(Z.FLW_ORDER,
                                                          ',',
                                                          '')) + 1
                                AND PRIOR DBMS_RANDOM.VALUE IS NOT NULL) D
                 ON D.ORDER_ID = C.ORDER_ID
                AND D.COMPANY_ID = C.COMPANY_ID
               INNER JOIN SCMDATA.T_COMMODITY_INFO E ON E.GOO_ID=B.GOO_ID AND E.COMPANY_ID=B.COMPANY_ID
              WHERE B.AMOUNT > 0
              GROUP BY A.COMPANY_ID, EXTRACT(YEAR FROM A.CREATE_TIME),
                       DECODE(TO_CHAR(A.CREATE_TIME,'Q'),1,1,2,1,3,2,4,2), D.CATEGORY,
                       D.GROUP_NAME, D.GENDAN) Z
    ON Z.COMPANY_ID = Y.COMPANY_ID
   AND Z.YEAR = Y.YEAR
   AND Z.HALFYEAR = Y.HALFYEAR
   AND Z.CATEGORY = Y.CATEGORY
   AND Z.GROUP_NAME = Y.GROUP_NAME
   AND Z.COUNT_DIMENSION = Y.COUNT_DIMENSION
   AND Z.DIMENSION_SORT = Y.DIMENSION_SORT*/ ]';
     IF P_TYPE = 0 THEN
      --进货
      V_EXSQL1 := V_SQL1||V_WH_SQL2||V_U_SQL1||V_I_SQL1;
      --退货
      V_EXSQL2 := V_SQL2 || V_WH_SQL2 || V_U_SQL2 || V_I_SQL2;


    ELSIF P_TYPE = 1 THEN
      --进货
      V_EXSQL1 := V_SQL1||V_WM_SQL1||V_U_SQL1||V_I_SQL1;
      --退货
      V_EXSQL2 := V_SQL2 || V_WM_SQL1 || V_U_SQL2 || V_I_SQL2;
    END IF;
    EXECUTE IMMEDIATE V_EXSQL2;
     EXECUTE IMMEDIATE V_EXSQL1;
    --dbms_output.put_line(V_EXSQL1);
    --dbms_output.put_line(V_EXSQL2);

    -- 06跟单主管
    V_SQL1:=q'[MERGE INTO SCMDATA.T_RTKPI_HALFYEAR A
USING (SELECT Y.COMPANY_ID, Y.YEAR, Y.HALFYEAR,  Y.CATEGORY,
         Y.GROUP_NAME, Y.COUNT_DIMENSION, Y.DIMENSION_SORT,
         Y.ORDER_MONEY INGOOD_MONEY
    FROM  (SELECT A.COMPANY_ID, EXTRACT(YEAR FROM A.CREATE_TIME) YEAR,
                      DECODE(TO_CHAR(A.CREATE_TIME,'Q'),1,1,2,1,3,2,4,2) HALFYEAR,
                      E.CATEGORY,
                      (CASE WHEN D.GROUP_NAME IS NULL THEN '1' ELSE D.GROUP_NAME END) GROUP_NAME,
                       '06' COUNT_DIMENSION,
                      (CASE WHEN D.GENDANZG IS NULL THEN '1' ELSE D.GENDANZG END) DIMENSION_SORT,
                      SUM(CASE
                            WHEN REGEXP_COUNT(D.FLW_ORDER_MANAGER, ',') > 0 THEN
                             A.AMOUNT /
                             NVL((REGEXP_COUNT(D.FLW_ORDER_MANAGER, ',') + 1),1) *
                             E.PRICE
                            ELSE
                             A.AMOUNT * E.PRICE
                          END) ORDER_MONEY
                 FROM (SELECT T.DOCUMENT_NO,
                    T.COMPANY_ID,
                    TRUNC(T.CREATE_TIME) CREATE_TIME,
                    SUM(TL.AMOUNT) AMOUNT,
                    TL.GOO_ID
               FROM SCMDATA.T_INGOOD T
              INNER JOIN (SELECT TI.ING_ID,
                                TI.COMPANY_ID,
                                TI.GOO_ID,
                                TI.AMOUNT
                           FROM SCMDATA.T_INGOODS TI
                          WHERE TI.AMOUNT > 0) TL
                 ON TL.ING_ID = T.ING_ID
                AND TL.COMPANY_ID = T.COMPANY_ID
              WHERE TO_CHAR(T.CREATE_TIME, 'yyyy') >= 2022
              GROUP BY T.DOCUMENT_NO,
                       T.COMPANY_ID,
                       TRUNC(T.CREATE_TIME),
                       TL.GOO_ID) A
                       /*SCMDATA.T_INGOOD A
                INNER JOIN SCMDATA.T_INGOODS B
                   ON A.ING_ID = B.ING_ID
                  AND A.COMPANY_ID = B.COMPANY_ID
                LEFT JOIN SCMDATA.T_ORDERED C
                   ON C.ORDER_CODE = A.DOCUMENT_NO
                  AND A.COMPANY_ID = C.COMPANY_ID*/
                LEFT JOIN (SELECT Z.*,
                                  REGEXP_SUBSTR(Z.FLW_ORDER_MANAGER,
                                                 '[^,]+',
                                                 1,
                                                 LEVEL) GENDANZG
                             FROM SCMDATA.PT_ORDERED Z
                           CONNECT BY PRIOR Z.PT_ORDERED_ID = Z.PT_ORDERED_ID
                                  AND LEVEL <=
                                      LENGTH(Z.FLW_ORDER_MANAGER) -
                                      LENGTH(REGEXP_REPLACE(Z.FLW_ORDER_MANAGER,
                                                            ',',
                                                            '')) + 1
                                  AND PRIOR DBMS_RANDOM.VALUE IS NOT NULL) D
                   ON D.PRODUCT_GRESS_CODE = A.DOCUMENT_NO
                  AND D.COMPANY_ID = A.COMPANY_ID
                  INNER JOIN SCMDATA.T_COMMODITY_INFO E ON E.GOO_ID=A.GOO_ID AND E.COMPANY_ID=A.COMPANY_ID
                --WHERE B.AMOUNT > 0
                GROUP BY A.COMPANY_ID, EXTRACT(YEAR FROM A.CREATE_TIME),
                         DECODE(TO_CHAR(A.CREATE_TIME,'Q'),1,1,2,1,3,2,4,2), E.CATEGORY,
                         D.GROUP_NAME, D.GENDANZG) Y    ]';

    V_SQL2 := q'[MERGE INTO SCMDATA.T_RTKPI_HALFYEAR A
USING (
  WITH TEMP_RT AS
   (SELECT Z.*,
           Z.RM_ID || ROW_NUMBER() OVER(PARTITION BY Z.RM_ID ORDER BY 1) RM_ID2,
           Z.EXAMOUNT / (COUNT(Z.RM_ID) OVER(PARTITION BY(Z.RM_ID))) EXGAMOUNT2,
           REGEXP_SUBSTR(Z.SUP_GROUP_NAME, '[^,]+', 1, LEVEL) SUP_GROUP_NAME2
      FROM SCMDATA.T_RETURN_MANAGEMENT Z
     WHERE Z.AUDIT_TIME IS NOT NULL
    CONNECT BY PRIOR RM_ID = RM_ID
           AND LEVEL <=
               LENGTH(Z.SUP_GROUP_NAME) -
               LENGTH(REGEXP_REPLACE(Z.SUP_GROUP_NAME, ',', '')) + 1
           AND PRIOR DBMS_RANDOM.VALUE IS NOT NULL)
  SELECT Y.COMPANY_ID, Y.YEAR, Y.HALFYEAR,  Y.CATEGORY,
         Y.GROUP_NAME, Y.COUNT_DIMENSION, Y.DIMENSION_SORT,
         /*Z.ORDER_MONEY INGOOD_MONEY,*/ Y.RMMONEY SHOP_RT_ORIGINAL_MONEY,
         X.RMMONEY2 SHOP_RT_MONEY

    FROM (SELECT A.COMPANY_ID, A.YEAR, DECODE(A.QUARTER,1,1,2,1,3,2,4,2) HALFYEAR, B.CATEGORY,
                  (CASE WHEN A.SUP_GROUP_NAME2 IS NULL THEN  '1'  ELSE  A.SUP_GROUP_NAME2  END) GROUP_NAME,
                   '06' COUNT_DIMENSION,
                  (CASE WHEN A.GENDANZG2 IS NULL THEN '1' ELSE A.GENDANZG2 END) DIMENSION_SORT,
                  SUM(A.EXGAMOUNT3 * B.PRICE) RMMONEY
             FROM (SELECT Z.RM_ID, Z.COMPANY_ID, Z.YEAR, Z.QUARTER, Z.ACCESS_TIME,
                           Z.GOO_ID, Z.EXAMOUNT, Z.SUP_GROUP_NAME, Z.AUDIT_TIME,Z.SUP_GROUP_NAME2,
                           Z.EXGAMOUNT2 /
                            NVL((REGEXP_COUNT(Z.MERCHER_DIRECTOR_ID, ',') + 1),1) EXGAMOUNT3,
                           REGEXP_SUBSTR(Z.MERCHER_DIRECTOR_ID,
                                          '[^,]+',
                                          1,
                                          LEVEL) GENDANZG2
                      FROM TEMP_RT Z

                    CONNECT BY PRIOR Z.RM_ID2 = Z.RM_ID2
                           AND LEVEL <= LENGTH(Z.MERCHER_DIRECTOR_ID) -
                               LENGTH(REGEXP_REPLACE(Z.MERCHER_DIRECTOR_ID, ',','')) + 1
                           AND PRIOR DBMS_RANDOM.VALUE IS NOT NULL) A
            INNER JOIN SCMDATA.T_COMMODITY_INFO B
               ON A.GOO_ID = B.GOO_ID
              AND A.COMPANY_ID = B.COMPANY_ID
            WHERE A.AUDIT_TIME IS NOT NULL
            GROUP BY A.COMPANY_ID, A.YEAR, DECODE(A.QUARTER,1,1,2,1,3,2,4,2), B.CATEGORY,
                     A.SUP_GROUP_NAME2, A.GENDANZG2) Y

    LEFT JOIN (SELECT A.COMPANY_ID, A.YEAR, DECODE(A.QUARTER,1,1,2,1,3,2,4,2) HALFYEAR,
                      B.CATEGORY,
                      (CASE WHEN A.SUP_GROUP_NAME2 IS NULL THEN '1'ELSE A.SUP_GROUP_NAME2 END) GROUP_NAME,
                       '06' COUNT_DIMENSION,
                      (CASE WHEN A.GENDANZG2 IS NULL THEN '1' ELSE A.GENDANZG2 END) DIMENSION_SORT,
                      SUM(A.EXGAMOUNT3 * B.PRICE) RMMONEY2
                 FROM (SELECT Z.RM_ID, Z.COMPANY_ID, Z.YEAR, Z.QUARTER,
                               Z.ACCESS_TIME, Z.GOO_ID, Z.EXAMOUNT,
                               Z.SUP_GROUP_NAME, Z.AUDIT_TIME,
                               Z.CAUSE_DETAIL_ID, Z.FIRST_DEPT_ID,Z.SUP_GROUP_NAME2,
                               Z.SECOND_DEPT_ID,
                               Z.EXGAMOUNT2 /
                                NVL((REGEXP_COUNT(Z.MERCHER_DIRECTOR_ID, ',') + 1),1) EXGAMOUNT3,
                               REGEXP_SUBSTR(Z.MERCHER_DIRECTOR_ID, '[^,]+', 1, LEVEL) GENDANZG2
                          FROM TEMP_RT Z

                        CONNECT BY PRIOR Z.RM_ID2 = Z.RM_ID2
                               AND LEVEL <=
                                   LENGTH(Z.MERCHER_DIRECTOR_ID) -
                                   LENGTH(REGEXP_REPLACE(Z.MERCHER_DIRECTOR_ID, ',', '')) + 1
                               AND PRIOR DBMS_RANDOM.VALUE IS NOT NULL) A
                INNER JOIN SCMDATA.T_COMMODITY_INFO B
                   ON A.GOO_ID = B.GOO_ID
                  AND A.COMPANY_ID = B.COMPANY_ID
                 LEFT JOIN SCMDATA.T_ABNORMAL_DTL_CONFIG C
                   ON A.CAUSE_DETAIL_ID = C.ABNORMAL_DTL_CONFIG_ID
                  AND A.COMPANY_ID = C.COMPANY_ID
                  AND C.ANOMALY_CLASSIFICATION = 'AC_QUALITY'
                INNER JOIN SCMDATA.SYS_COMPANY_DEPT D
                   ON D.COMPANY_DEPT_ID = A.FIRST_DEPT_ID
                WHERE A.AUDIT_TIME IS NOT NULL
                  AND C.CAUSE_CLASSIFICATION <> '银饰氧化问题'
                  AND C.PROBLEM_CLASSIFICATION <> '非质量问题'
                  AND D.DEPT_NAME = '供应链管理部'
                  AND INSTR(A.SECOND_DEPT_ID,
                            'b550778b4f2d36b4e0533c281caca074') > 0
                GROUP BY A.COMPANY_ID, A.YEAR, DECODE(A.QUARTER,1,1,2,1,3,2,4,2), B.CATEGORY,
                         A.SUP_GROUP_NAME2, A.GENDANZG2) X
      ON X.COMPANY_ID = Y.COMPANY_ID
     AND X.YEAR = Y.YEAR
     AND X.HALFYEAR = Y.HALFYEAR
     AND X.CATEGORY = Y.CATEGORY
     AND X.GROUP_NAME = Y.GROUP_NAME
     AND X.COUNT_DIMENSION = Y.COUNT_DIMENSION
     AND X.DIMENSION_SORT = Y.DIMENSION_SORT
    /*LEFT JOIN (SELECT A.COMPANY_ID, EXTRACT(YEAR FROM A.CREATE_TIME) YEAR,
                      DECODE(TO_CHAR(A.CREATE_TIME,'Q'),1,1,2,1,3,2,4,2) HALFYEAR,
                      D.CATEGORY,
                      (CASE WHEN D.GROUP_NAME IS NULL THEN '1' ELSE D.GROUP_NAME END) GROUP_NAME,
                       '06' COUNT_DIMENSION,
                      (CASE WHEN D.GENDANZG IS NULL THEN '1' ELSE D.GENDANZG END) DIMENSION_SORT,
                      SUM(CASE
                            WHEN REGEXP_COUNT(D.FLW_ORDER_MANAGER, ',') > 0 THEN
                             B.AMOUNT /
                             NVL((REGEXP_COUNT(D.FLW_ORDER_MANAGER, ',') + 1),1) *
                             E.PRICE
                            ELSE
                             B.AMOUNT * E.PRICE
                          END) ORDER_MONEY
                 FROM SCMDATA.T_INGOOD A
                INNER JOIN SCMDATA.T_INGOODS B
                   ON A.ING_ID = B.ING_ID
                  AND A.COMPANY_ID = B.COMPANY_ID
                INNER JOIN SCMDATA.T_ORDERED C
                   ON C.ORDER_CODE = A.DOCUMENT_NO
                  AND A.COMPANY_ID = C.COMPANY_ID
                INNER JOIN (SELECT Z.*,
                                  REGEXP_SUBSTR(Z.FLW_ORDER_MANAGER,
                                                 '[^,]+',
                                                 1,
                                                 LEVEL) GENDANZG
                             FROM SCMDATA.PT_ORDERED Z
                           CONNECT BY PRIOR Z.PT_ORDERED_ID = Z.PT_ORDERED_ID
                                  AND LEVEL <=
                                      LENGTH(Z.FLW_ORDER_MANAGER) -
                                      LENGTH(REGEXP_REPLACE(Z.FLW_ORDER_MANAGER,
                                                            ',',
                                                            '')) + 1
                                  AND PRIOR DBMS_RANDOM.VALUE IS NOT NULL) D
                   ON D.ORDER_ID = C.ORDER_ID
                  AND D.COMPANY_ID = C.COMPANY_ID
                  INNER JOIN SCMDATA.T_COMMODITY_INFO E ON E.GOO_ID=B.GOO_ID AND E.COMPANY_ID=B.COMPANY_ID
                WHERE B.AMOUNT > 0
                GROUP BY A.COMPANY_ID, EXTRACT(YEAR FROM A.CREATE_TIME),
                         DECODE(TO_CHAR(A.CREATE_TIME,'Q'),1,1,2,1,3,2,4,2), D.CATEGORY,
                         D.GROUP_NAME, D.GENDANZG) Z
      ON Z.COMPANY_ID = Y.COMPANY_ID
     AND Z.YEAR = Y.YEAR
     AND Z.HALFYEAR = Y.HALFYEAR
     AND Z.CATEGORY = Y.CATEGORY
     AND Z.GROUP_NAME = Y.GROUP_NAME
     AND Z.COUNT_DIMENSION = Y.COUNT_DIMENSION
     AND Z.DIMENSION_SORT = Y.DIMENSION_SORT */ ]';
     IF P_TYPE = 0 THEN
      --进货
      V_EXSQL1 := V_SQL1||V_WH_SQL2||V_U_SQL1||V_I_SQL1;
      --退货
      V_EXSQL2 := V_SQL2 || V_WH_SQL2 || V_U_SQL2 || V_I_SQL2;


    ELSIF P_TYPE = 1 THEN
      --进货
      V_EXSQL1 := V_SQL1||V_WM_SQL1||V_U_SQL1||V_I_SQL1;
      --退货
      V_EXSQL2 := V_SQL2 || V_WM_SQL1 || V_U_SQL2 || V_I_SQL2;
    END IF;
    EXECUTE IMMEDIATE V_EXSQL2;
     EXECUTE IMMEDIATE V_EXSQL1;
    --dbms_output.put_line(V_EXSQL1);
    --dbms_output.put_line(V_EXSQL2);

    --07qc
    V_SQL1:=q'[ MERGE INTO SCMDATA.T_RTKPI_HALFYEAR A
USING ( WITH TEMP_PTORDER AS
 (SELECT T1.PT_ORDERED_ID, T1.GOO_ID_PR,
         T1.PT_ORDERED_ID || ROW_NUMBER() OVER(PARTITION BY T1.PT_ORDERED_ID ORDER BY 1) ID2,
         T1.COMPANY_ID, T1.PRODUCT_GRESS_CODE, T1.ORDER_MONEY,
         (T1.ORDER_MONEY / COUNT(T1.PRODUCT_GRESS_CODE)
           OVER(PARTITION BY T1.PRODUCT_GRESS_CODE)) SUM1,
         REGEXP_SUBSTR(T1.QC, '[^,]+', 1, LEVEL) QC2
    FROM SCMDATA.PT_ORDERED T1
   WHERE T1.QC IS NOT NULL
  CONNECT BY PRIOR T1.PT_ORDERED_ID = T1.PT_ORDERED_ID
         AND LEVEL <=
             LENGTH(T1.QC) - LENGTH(REGEXP_REPLACE(T1.QC, ',', '')) + 1
         AND PRIOR DBMS_RANDOM.VALUE IS NOT NULL)
SELECT Y.COMPANY_ID, Y.YEAR, Y.HALFYEAR, Y.CATEGORY, Y.GROUP_NAME,
       Y.COUNT_DIMENSION, Y.DIMENSION_SORT DIMENSION_SORT, Y.ORDER_MONEY INGOOD_MONEY
 FROM  (SELECT A.COMPANY_ID, EXTRACT(YEAR FROM A.CREATE_TIME) YEAR,
                    DECODE(TO_CHAR(A.CREATE_TIME,'Q'),1,1,2,1,3,2,4,2) HALFYEAR,
                    E.CATEGORY,
                    (CASE  WHEN D.GROUP_NAME IS NULL THEN '1'  ELSE  D.GROUP_NAME  END) GROUP_NAME,
                     '07' COUNT_DIMENSION,
                    (CASE WHEN D.QC2 IS NULL THEN '1' ELSE  D.QC2  END) DIMENSION_SORT,
                    SUM(CASE
                          WHEN REGEXP_COUNT(D.QC, ',') > 0 THEN
                           A.AMOUNT / NVL((REGEXP_COUNT(D.QC, ',') + 1),1) *
                           E.PRICE
                          ELSE
                           A.AMOUNT * E.PRICE
                        END) ORDER_MONEY
               FROM (SELECT T.DOCUMENT_NO,
                    T.COMPANY_ID,
                    TRUNC(T.CREATE_TIME) CREATE_TIME,
                    SUM(TL.AMOUNT) AMOUNT,
                    TL.GOO_ID
               FROM SCMDATA.T_INGOOD T
              INNER JOIN (SELECT TI.ING_ID,
                                TI.COMPANY_ID,
                                TI.GOO_ID,
                                TI.AMOUNT
                           FROM SCMDATA.T_INGOODS TI
                          WHERE TI.AMOUNT > 0) TL
                 ON TL.ING_ID = T.ING_ID
                AND TL.COMPANY_ID = T.COMPANY_ID
              WHERE TO_CHAR(T.CREATE_TIME, 'yyyy') >= 2022
              GROUP BY T.DOCUMENT_NO,
                       T.COMPANY_ID,
                       TRUNC(T.CREATE_TIME),
                       TL.GOO_ID) A
                       /*SCMDATA.T_INGOOD A
                INNER JOIN SCMDATA.T_INGOODS B
                   ON A.ING_ID = B.ING_ID
                  AND A.COMPANY_ID = B.COMPANY_ID
                LEFT JOIN SCMDATA.T_ORDERED C
                   ON C.ORDER_CODE = A.DOCUMENT_NO
                  AND A.COMPANY_ID = C.COMPANY_ID*/
              LEFT JOIN (SELECT Z.*,
                                REGEXP_SUBSTR(Z.QC, '[^,]+', 1, LEVEL) QC2
                           FROM SCMDATA.PT_ORDERED Z
                         CONNECT BY PRIOR Z.PT_ORDERED_ID = Z.PT_ORDERED_ID
                                AND LEVEL <=
                                    LENGTH(Z.QC) -
                                    LENGTH(REGEXP_REPLACE(Z.QC, ',', '')) + 1
                                AND PRIOR DBMS_RANDOM.VALUE IS NOT NULL) D
                 ON D.PRODUCT_GRESS_CODE  = A.DOCUMENT_NO
                AND D.COMPANY_ID = A.COMPANY_ID
                INNER JOIN SCMDATA.T_COMMODITY_INFO E ON E.GOO_ID=A.GOO_ID AND E.COMPANY_ID=A.COMPANY_ID
              --WHERE B.AMOUNT > 0
              GROUP BY A.COMPANY_ID, EXTRACT(YEAR FROM A.CREATE_TIME),
                      DECODE(TO_CHAR(A.CREATE_TIME,'Q'),1,1,2,1,3,2,4,2), E.CATEGORY,
                       D.GROUP_NAME, D.QC2) Y ]';

    V_SQL2 := q'[  MERGE INTO SCMDATA.T_RTKPI_HALFYEAR A
USING (
 WITH TEMP_RT AS
 (SELECT Z.RM_ID, Z.COMPANY_ID, Z.YEAR, Z.QUARTER, Z.ACCESS_TIME, Z.GOO_ID,Z.SUPPLIER_CODE,
         Z.EXAMOUNT, Z.QC_ID,
         Z.RM_ID || ROW_NUMBER() OVER(PARTITION BY Z.RM_ID ORDER BY 1) RM_ID2,
         Z.EXAMOUNT / (COUNT(Z.RM_ID) OVER(PARTITION BY(Z.RM_ID))) EXGAMOUNT2,
         REGEXP_SUBSTR(Z.SUP_GROUP_NAME, '[^,]+', 1, LEVEL) SUP_GROUP_NAME2
    FROM SCMDATA.T_RETURN_MANAGEMENT Z
   WHERE Z.AUDIT_TIME IS NOT NULL
  CONNECT BY PRIOR RM_ID = RM_ID
         AND LEVEL <= LENGTH(Z.SUP_GROUP_NAME) -
             LENGTH(REGEXP_REPLACE(Z.SUP_GROUP_NAME, ',', '')) + 1
         AND PRIOR DBMS_RANDOM.VALUE IS NOT NULL),
TEMP_RT2 AS
 (SELECT Z.RM_ID, Z.COMPANY_ID, Z.YEAR, Z.QUARTER, Z.ACCESS_TIME, Z.GOO_ID,Z.SUPPLIER_CODE,
         Z.EXAMOUNT, Z.QC_ID,
         Z.RM_ID || ROW_NUMBER() OVER(PARTITION BY Z.RM_ID ORDER BY 1) RM_ID2,
         Z.EXAMOUNT / (COUNT(Z.RM_ID) OVER(PARTITION BY(Z.RM_ID))) EXGAMOUNT2,
         REGEXP_SUBSTR(Z.SUP_GROUP_NAME, '[^,]+', 1, LEVEL) SUP_GROUP_NAME2
    FROM SCMDATA.T_RETURN_MANAGEMENT Z
    LEFT JOIN SCMDATA.T_ABNORMAL_DTL_CONFIG C
      ON Z.CAUSE_DETAIL_ID = C.ABNORMAL_DTL_CONFIG_ID
     AND Z.COMPANY_ID = C.COMPANY_ID
     AND C.ANOMALY_CLASSIFICATION = 'AC_QUALITY'
   INNER JOIN SCMDATA.SYS_COMPANY_DEPT D
      ON D.COMPANY_DEPT_ID = Z.FIRST_DEPT_ID
   WHERE Z.AUDIT_TIME IS NOT NULL
     AND C.CAUSE_CLASSIFICATION <> '银饰氧化问题'
     AND C.PROBLEM_CLASSIFICATION <> '非质量问题'
     AND D.DEPT_NAME = '供应链管理部'
     AND INSTR(Z.SECOND_DEPT_ID, 'b550778b4f2d36b4e0533c281caca074') > 0
  CONNECT BY PRIOR RM_ID = RM_ID
         AND LEVEL <= LENGTH(Z.SUP_GROUP_NAME) -
             LENGTH(REGEXP_REPLACE(Z.SUP_GROUP_NAME, ',', '')) + 1
         AND PRIOR DBMS_RANDOM.VALUE IS NOT NULL),
TEMP_PTORDER AS
 (SELECT T1.PT_ORDERED_ID, T1.GOO_ID_PR,T1.ORDER_ID, T1.DELIVERY_AMOUNT,
         T1.PT_ORDERED_ID || ROW_NUMBER() OVER(PARTITION BY T1.PT_ORDERED_ID ORDER BY 1) ID2,
         T1.COMPANY_ID, T1.PRODUCT_GRESS_CODE, T1.ORDER_MONEY,
         (T1.ORDER_MONEY / COUNT(T1.PRODUCT_GRESS_CODE)
           OVER(PARTITION BY T1.PRODUCT_GRESS_CODE)) SUM1,
         REGEXP_SUBSTR(T1.QC, '[^,]+', 1, LEVEL) QC2
    FROM SCMDATA.PT_ORDERED T1
   WHERE T1.QC IS NOT NULL
  CONNECT BY PRIOR T1.PT_ORDERED_ID = T1.PT_ORDERED_ID
         AND LEVEL <=
             LENGTH(T1.QC) - LENGTH(REGEXP_REPLACE(T1.QC, ',', '')) + 1
         AND PRIOR DBMS_RANDOM.VALUE IS NOT NULL)
SELECT Y.COMPANY_ID, Y.YEAR, Y.HALFYEAR, Y.CATEGORY, Y.GROUP_NAME,
       '07' COUNT_DIMENSION, Y.DIMENSION_SORT DIMENSION_SORT,
       Y.RMMONEY SHOP_RT_ORIGINAL_MONEY, X.SHOP_RT_MONEY SHOP_RT_MONEY /*, Z.ORDER_MONEY INGOOD_MONEY*/
  FROM (SELECT A.COMPANY_ID, A.YEAR,
                DECODE(A.QUARTER, 1, 1, 2, 1, 3, 2, 4, 2) HALFYEAR, B.CATEGORY,
                (CASE
                  WHEN A.SUP_GROUP_NAME2 IS NULL THEN
                   '1'
                  ELSE
                   A.SUP_GROUP_NAME2
                END) GROUP_NAME, '07' COUNT_DIMENSION,
                (CASE
                  WHEN A.QC2 IS NULL THEN
                   '1'
                  ELSE
                   A.QC2
                END) DIMENSION_SORT, SUM(A.EXGAMOUNT3 * B.PRICE) RMMONEY
           FROM (SELECT Z.COMPANY_ID, Z.YEAR, Z.QUARTER, Z.ACCESS_TIME,
                         Z.GOO_ID, Z.SUP_GROUP_NAME2,
                         Z.EXGAMOUNT2 /
                          NVL((REGEXP_COUNT(Z.QC_ID, ',') + 1), 1) EXGAMOUNT3,
                         REGEXP_SUBSTR(Z.QC_ID, '[^,]+', 1, LEVEL) QC2
                    FROM TEMP_RT Z
                   WHERE (EXISTS (SELECT MAX(1)
                                    FROM SCMDATA.T_PLAT_LOG X
                                   INNER JOIN SCMDATA.T_PLAT_LOGS Y
                                      ON X.COMPANY_ID = Y.COMPANY_ID
                                     AND X.LOG_ID = Y.LOG_ID
                                   WHERE X.APPLY_PK_ID = Z.RM_ID
                                     AND Y.OPERATE_FIELD = 'QC_ID'
                                     AND X.ACTION_TYPE = 'UPDATE') OR
                          (NOT EXISTS (SELECT MAX(1)
                                                FROM SCMDATA.T_PLAT_LOG Y
                                               INNER JOIN SCMDATA.T_PLAT_LOGS X
                                                  ON X.COMPANY_ID = Y.COMPANY_ID
                                                 AND X.LOG_ID = Y.LOG_ID
                                               WHERE Y.APPLY_PK_ID = Z.RM_ID
                                                 AND X.OPERATE_FIELD = 'QC_ID'
                                                 AND Y.ACTION_TYPE = 'UPDATE') AND
                           NOT EXISTS
                           (SELECT MAX(1)
                               FROM  TEMP_PTORDER J
                           INNER JOIN SCMDATA.T_ORDERED P
                              ON P.ORDER_ID = J.ORDER_ID
                             AND P.COMPANY_ID = J.COMPANY_ID
                           WHERE J.GOO_ID_PR = Z.GOO_ID
                             AND J.COMPANY_ID = Z.COMPANY_ID AND P.SUPPLIER_CODE=Z.SUPPLIER_CODE AND J.QC2 IS NOT NULL AND J.DELIVERY_AMOUNT > 0  )))
                  CONNECT BY PRIOR Z.RM_ID2 = Z.RM_ID2
                         AND LEVEL <=
                             LENGTH(Z.QC_ID) -
                             LENGTH(REGEXP_REPLACE(Z.QC_ID, ',', '')) + 1
                         AND PRIOR DBMS_RANDOM.VALUE IS NOT NULL
                  UNION ALL
                  SELECT H.COMPANY_ID, H.YEAR, H.QUARTER, H.ACCESS_TIME,
                         H.GOO_ID, H.SUP_GROUP_NAME2,
                         (H.EXGAMOUNT2 *
                          ((SELECT SUM(J.SUM1)
                               FROM TEMP_PTORDER J
                               INNER JOIN SCMDATA.T_ORDERED P
                              ON P.ORDER_ID = J.ORDER_ID
                             AND P.COMPANY_ID = J.COMPANY_ID
                           WHERE J.GOO_ID_PR = H.GOO_ID
                                AND J.COMPANY_ID = H.COMPANY_ID
                                AND J.QC2 = H.QC2 AND P.SUPPLIER_CODE=H.SUPPLIER_CODE  AND J.DELIVERY_AMOUNT > 0) /
                          (SELECT SUM(J.ORDER_MONEY)
                               FROM TEMP_PTORDER J
                               INNER JOIN SCMDATA.T_ORDERED P
                              ON P.ORDER_ID = J.ORDER_ID
                             AND P.COMPANY_ID = J.COMPANY_ID
                           WHERE J.GOO_ID_PR = H.GOO_ID
                                AND H.COMPANY_ID = J.COMPANY_ID
                                AND J.QC2 IS NOT NULL AND P.SUPPLIER_CODE=H.SUPPLIER_CODE  AND J.DELIVERY_AMOUNT > 0))) EXGAMOUNT3, H.QC2
                    FROM (SELECT Z.*,
                                  REGEXP_SUBSTR(Z.QC_ID, '[^,]+', 1, LEVEL) QC2
                             FROM TEMP_RT Z
                            WHERE NOT EXISTS (SELECT MAX(1)
                                     FROM SCMDATA.T_PLAT_LOG Y
                                    INNER JOIN SCMDATA.T_PLAT_LOGS X
                                       ON X.COMPANY_ID = Y.COMPANY_ID
                                      AND X.LOG_ID = Y.LOG_ID
                                    WHERE Y.APPLY_PK_ID = Z.RM_ID
                                      AND X.OPERATE_FIELD = 'QC_ID'
                                      AND Y.ACTION_TYPE = 'UPDATE')
                              AND EXISTS
                            (SELECT MAX(1)
                                     FROM TEMP_PTORDER J
                               INNER JOIN SCMDATA.T_ORDERED P
                              ON P.ORDER_ID = J.ORDER_ID
                             AND P.COMPANY_ID = J.COMPANY_ID
                           WHERE J.GOO_ID_PR = Z.GOO_ID
                                      AND J.COMPANY_ID = Z.COMPANY_ID AND J.QC2 IS NOT NULL AND P.SUPPLIER_CODE=Z.SUPPLIER_CODE  AND J.DELIVERY_AMOUNT > 0 )
                           CONNECT BY PRIOR Z.RM_ID2 = Z.RM_ID2
                                  AND LEVEL <=
                                      LENGTH(Z.QC_ID) -
                                      LENGTH(REGEXP_REPLACE(Z.QC_ID, ',', '')) + 1
                                  AND PRIOR DBMS_RANDOM.VALUE IS NOT NULL) H) A
          INNER JOIN SCMDATA.T_COMMODITY_INFO B
             ON A.GOO_ID = B.GOO_ID
            AND A.COMPANY_ID = B.COMPANY_ID
          GROUP BY A.COMPANY_ID, A.YEAR,
                   DECODE(A.QUARTER, 1, 1, 2, 1, 3, 2, 4, 2), B.CATEGORY,
                   A.SUP_GROUP_NAME2,
                   (CASE
                      WHEN A.QC2 IS NULL THEN
                       '1'
                      ELSE
                       A.QC2
                    END)) Y

  LEFT JOIN (SELECT A.COMPANY_ID, A.YEAR,
                    DECODE(A.QUARTER, 1, 1, 2, 1, 3, 2, 4, 2) HALFYEAR,
                    B.CATEGORY,
                    (CASE
                      WHEN A.SUP_GROUP_NAME2 IS NULL THEN
                       '1'
                      ELSE
                       A.SUP_GROUP_NAME2
                    END) GROUP_NAME, '07' COUNT_DIMENSION,
                    (CASE
                      WHEN A.QC2 IS NULL THEN
                       '1'
                      ELSE
                       A.QC2
                    END) DIMENSION_SORT,
                    SUM(A.EXGAMOUNT3 * B.PRICE) SHOP_RT_MONEY
               FROM (SELECT Z.COMPANY_ID, Z.YEAR, Z.QUARTER, Z.ACCESS_TIME,
                             Z.GOO_ID, Z.SUP_GROUP_NAME2,
                             Z.EXGAMOUNT2 /
                              NVL((REGEXP_COUNT(Z.QC_ID, ',') + 1), 1) EXGAMOUNT3,
                             REGEXP_SUBSTR(Z.QC_ID, '[^,]+', 1, LEVEL) QC2
                        FROM TEMP_RT2 Z
                       WHERE (EXISTS
                              (SELECT MAX(1)
                                 FROM SCMDATA.T_PLAT_LOG X
                                INNER JOIN SCMDATA.T_PLAT_LOGS Y
                                   ON X.COMPANY_ID = Y.COMPANY_ID
                                  AND X.LOG_ID = Y.LOG_ID
                                WHERE X.APPLY_PK_ID = Z.RM_ID
                                  AND Y.OPERATE_FIELD = 'QC_ID'
                                  AND X.ACTION_TYPE = 'UPDATE') OR
                              (NOT EXISTS
                               (SELECT MAX(1)
                                  FROM SCMDATA.T_PLAT_LOG Y
                                 INNER JOIN SCMDATA.T_PLAT_LOGS X
                                    ON X.COMPANY_ID = Y.COMPANY_ID
                                   AND X.LOG_ID = Y.LOG_ID
                                 WHERE Y.APPLY_PK_ID = Z.RM_ID
                                   AND X.OPERATE_FIELD = 'QC_ID'
                                   AND Y.ACTION_TYPE = 'UPDATE') AND NOT EXISTS
                               (SELECT MAX(1)
                                  FROM TEMP_PTORDER J
                               INNER JOIN SCMDATA.T_ORDERED P
                              ON P.ORDER_ID = J.ORDER_ID
                             AND P.COMPANY_ID = J.COMPANY_ID
                               WHERE J.GOO_ID_PR= Z.GOO_ID
                                   AND J.COMPANY_ID = Z.COMPANY_ID AND J.QC2 IS NOT NULL AND P.SUPPLIER_CODE=Z.SUPPLIER_CODE  AND J.DELIVERY_AMOUNT > 0)))
                      CONNECT BY PRIOR Z.RM_ID2 = Z.RM_ID2
                             AND LEVEL <=
                                 LENGTH(Z.QC_ID) -
                                 LENGTH(REGEXP_REPLACE(Z.QC_ID, ',', '')) + 1
                             AND PRIOR DBMS_RANDOM.VALUE IS NOT NULL
                      UNION ALL
                      SELECT H.COMPANY_ID, H.YEAR, H.QUARTER, H.ACCESS_TIME,
                             H.GOO_ID, H.SUP_GROUP_NAME2,
                             (H.EXGAMOUNT2 *
                              ((SELECT SUM(J.SUM1)
                                   FROM  TEMP_PTORDER J
                               INNER JOIN SCMDATA.T_ORDERED P
                              ON P.ORDER_ID = J.ORDER_ID
                             AND P.COMPANY_ID = J.COMPANY_ID
                               WHERE J.GOO_ID_PR = H.GOO_ID AND P.SUPPLIER_CODE=H.SUPPLIER_CODE  AND J.DELIVERY_AMOUNT > 0
                                    AND J.COMPANY_ID = H.COMPANY_ID
                                    AND J.QC2 = H.QC2) /
                              (SELECT SUM(J.ORDER_MONEY)
                                   FROM TEMP_PTORDER J
                               INNER JOIN SCMDATA.T_ORDERED P
                              ON P.ORDER_ID = J.ORDER_ID
                             AND P.COMPANY_ID = J.COMPANY_ID
                               WHERE J.GOO_ID_PR = H.GOO_ID
                                    AND H.COMPANY_ID = J.COMPANY_ID
                                    AND J.QC2 IS NOT NULL AND P.SUPPLIER_CODE=H.SUPPLIER_CODE  AND J.DELIVERY_AMOUNT > 0))) EXGAMOUNT3, H.QC2
                        FROM (SELECT Z.*,
                                      REGEXP_SUBSTR(Z.QC_ID, '[^,]+', 1, LEVEL) QC2
                                 FROM TEMP_RT2 Z
                                WHERE NOT EXISTS
                                (SELECT MAX(1)
                                         FROM SCMDATA.T_PLAT_LOG Y
                                        INNER JOIN SCMDATA.T_PLAT_LOGS X
                                           ON X.COMPANY_ID = Y.COMPANY_ID
                                          AND X.LOG_ID = Y.LOG_ID
                                        WHERE Y.APPLY_PK_ID = Z.RM_ID
                                          AND X.OPERATE_FIELD = 'QC_ID'
                                          AND Y.ACTION_TYPE = 'UPDATE')
                                  AND EXISTS
                                (SELECT MAX(1)
                                         FROM TEMP_PTORDER J
                               INNER JOIN SCMDATA.T_ORDERED P
                              ON P.ORDER_ID = J.ORDER_ID
                             AND P.COMPANY_ID = J.COMPANY_ID
                               WHERE J.GOO_ID_PR = Z.GOO_ID
                                          AND J.COMPANY_ID = Z.COMPANY_ID AND P.SUPPLIER_CODE=Z.SUPPLIER_CODE  AND J.DELIVERY_AMOUNT > 0)
                               CONNECT BY PRIOR Z.RM_ID2 = Z.RM_ID2
                                      AND LEVEL <=
                                          LENGTH(Z.QC_ID) -
                                          LENGTH(REGEXP_REPLACE(Z.QC_ID, ',', '')) + 1
                                      AND PRIOR DBMS_RANDOM.VALUE IS NOT NULL) H) A
              INNER JOIN SCMDATA.T_COMMODITY_INFO B
                 ON A.GOO_ID = B.GOO_ID
                AND A.COMPANY_ID = B.COMPANY_ID
              GROUP BY A.COMPANY_ID, A.YEAR,
                       DECODE(A.QUARTER, 1, 1, 2, 1, 3, 2, 4, 2), B.CATEGORY,
                       A.SUP_GROUP_NAME2,
                       (CASE
                          WHEN A.QC2 IS NULL THEN
                           '1'
                          ELSE
                           A.QC2
                        END)) X
    ON X.COMPANY_ID = Y.COMPANY_ID
   AND X.YEAR = Y.YEAR
   AND X.HALFYEAR = Y.HALFYEAR
   AND X.CATEGORY = Y.CATEGORY
   AND X.GROUP_NAME = Y.GROUP_NAME
   AND X.COUNT_DIMENSION = Y.COUNT_DIMENSION
   AND X.DIMENSION_SORT = Y.DIMENSION_SORT
/*LEFT JOIN (SELECT A.COMPANY_ID, EXTRACT(YEAR FROM A.CREATE_TIME) YEAR,
                 DECODE(TO_CHAR(A.CREATE_TIME,'Q'),1,1,2,1,3,2,4,2) HALFYEAR,
                 D.CATEGORY,
                 (CASE  WHEN D.GROUP_NAME IS NULL THEN '1'  ELSE  D.GROUP_NAME  END) GROUP_NAME,
                  '07' COUNT_DIMENSION,
                 (CASE WHEN D.QC2 IS NULL THEN '1' ELSE  D.QC2  END) DIMENSION_SORT,
                 SUM(CASE
                       WHEN REGEXP_COUNT(D.QC, ',') > 0 THEN
                        B.AMOUNT / NVL((REGEXP_COUNT(D.QC, ',') + 1),1) *
                        E.PRICE
                       ELSE
                        B.AMOUNT * E.PRICE
                     END) ORDER_MONEY
            FROM SCMDATA.T_INGOOD A
           INNER JOIN SCMDATA.T_INGOODS B
              ON A.ING_ID = B.ING_ID
             AND A.COMPANY_ID = B.COMPANY_ID
           INNER JOIN SCMDATA.T_ORDERED C
              ON C.ORDER_CODE = A.DOCUMENT_NO
             AND A.COMPANY_ID = C.COMPANY_ID
           INNER JOIN (SELECT Z.*,
                             REGEXP_SUBSTR(Z.QC, '[^,]+', 1, LEVEL) QC2
                        FROM SCMDATA.PT_ORDERED Z
                      CONNECT BY PRIOR Z.PT_ORDERED_ID = Z.PT_ORDERED_ID
                             AND LEVEL <=
                                 LENGTH(Z.QC) -
                                 LENGTH(REGEXP_REPLACE(Z.QC, ',', '')) + 1
                             AND PRIOR DBMS_RANDOM.VALUE IS NOT NULL) D
              ON D.ORDER_ID = C.ORDER_ID
             AND D.COMPANY_ID = C.COMPANY_ID
             INNER JOIN SCMDATA.T_COMMODITY_INFO E ON E.GOO_ID=B.GOO_ID AND E.COMPANY_ID=B.COMPANY_ID
           WHERE B.AMOUNT > 0
           GROUP BY A.COMPANY_ID, EXTRACT(YEAR FROM A.CREATE_TIME),
                   DECODE(TO_CHAR(A.CREATE_TIME,'Q'),1,1,2,1,3,2,4,2), D.CATEGORY,
                    D.GROUP_NAME, D.QC2) Z
 ON Z.COMPANY_ID = Y.COMPANY_ID
AND Z.YEAR = Y.YEAR
AND Z.HALFYEAR = Y.HALFYEAR
AND Z.CATEGORY = Y.CATEGORY
AND Z.GROUP_NAME = Y.GROUP_NAME
AND Z.COUNT_DIMENSION = Y.COUNT_DIMENSION
AND Z.DIMENSION_SORT = Y.DIMENSION_SORT */

 ]';
      IF P_TYPE = 0 THEN
      --进货
      V_EXSQL1 := V_SQL1||V_WH_SQL2||V_U_SQL1||V_I_SQL1;
      --退货
      V_EXSQL2 := V_SQL2 || V_WH_SQL2 || V_U_SQL2 || V_I_SQL2;


    ELSIF P_TYPE = 1 THEN
      --进货
      V_EXSQL1 := V_SQL1||V_WM_SQL1||V_U_SQL1||V_I_SQL1;
      --退货
      V_EXSQL2 := V_SQL2 || V_WM_SQL1 || V_U_SQL2 || V_I_SQL2;
    END IF;
    EXECUTE IMMEDIATE V_EXSQL2;
     EXECUTE IMMEDIATE V_EXSQL1;
    --dbms_output.put_line(V_EXSQL1);
    --dbms_output.put_line(V_EXSQL2);

    --qc主管
    V_SQL1:=q'[MERGE INTO SCMDATA.T_RTKPI_HALFYEAR A
USING (
   WITH TEMP_PTORDER AS
 (SELECT T1.PT_ORDERED_ID, T1.GOO_ID_PR,
         T1.PT_ORDERED_ID || ROW_NUMBER() OVER(PARTITION BY T1.PT_ORDERED_ID ORDER BY 1) ID2,
         T1.COMPANY_ID, T1.PRODUCT_GRESS_CODE, T1.ORDER_MONEY,
         (T1.ORDER_MONEY / COUNT(T1.PRODUCT_GRESS_CODE)
           OVER(PARTITION BY T1.PRODUCT_GRESS_CODE)) SUM1,
         REGEXP_SUBSTR(T1.QC_MANAGER, '[^,]+', 1, LEVEL) QCZG2
    FROM SCMDATA.PT_ORDERED T1
   WHERE T1.QC_MANAGER IS NOT NULL
  CONNECT BY PRIOR T1.PT_ORDERED_ID = T1.PT_ORDERED_ID
         AND LEVEL <=
             LENGTH(T1.QC_MANAGER) - LENGTH(REGEXP_REPLACE(T1.QC_MANAGER, ',', '')) + 1
         AND PRIOR DBMS_RANDOM.VALUE IS NOT NULL)

SELECT Y.COMPANY_ID, Y.YEAR, Y.HALFYEAR,  Y.CATEGORY, Y.GROUP_NAME,
       Y.COUNT_DIMENSION, Y.DIMENSION_SORT, Y.ORDER_MONEY INGOOD_MONEY
  FROM ( SELECT A.COMPANY_ID,
       EXTRACT(YEAR FROM A.CREATE_TIME) YEAR,
       DECODE(TO_CHAR(A.CREATE_TIME,'Q'),1,1,2,1,3,2,4,2) HALFYEAR,
       E.CATEGORY,
       (CASE WHEN D.GROUP_NAME IS NULL THEN  '1'  ELSE D.GROUP_NAME END) GROUP_NAME,
       '08' COUNT_DIMENSION,
       (case when D.QCZG2 is null then '1' else D.QCZG2 end) DIMENSION_SORT,
       SUM(CASE WHEN REGEXP_COUNT(D.QC_MANAGER, ',') > 0 THEN
       A.AMOUNT/NVL((REGEXP_COUNT(D.QC_MANAGER, ',') + 1),1) * E.PRICE ELSE
           A.AMOUNT * E.PRICE END ) ORDER_MONEY
  FROM (SELECT T.DOCUMENT_NO,
                    T.COMPANY_ID,
                    TRUNC(T.CREATE_TIME) CREATE_TIME,
                    SUM(TL.AMOUNT) AMOUNT,
                    TL.GOO_ID
               FROM SCMDATA.T_INGOOD T
              INNER JOIN (SELECT TI.ING_ID,
                                TI.COMPANY_ID,
                                TI.GOO_ID,
                                TI.AMOUNT
                           FROM SCMDATA.T_INGOODS TI
                          WHERE TI.AMOUNT > 0) TL
                 ON TL.ING_ID = T.ING_ID
                AND TL.COMPANY_ID = T.COMPANY_ID
              WHERE TO_CHAR(T.CREATE_TIME, 'yyyy') >= 2022
              GROUP BY T.DOCUMENT_NO,
                       T.COMPANY_ID,
                       TRUNC(T.CREATE_TIME),
                       TL.GOO_ID) A
                       /*SCMDATA.T_INGOOD A
                INNER JOIN SCMDATA.T_INGOODS B
                   ON A.ING_ID = B.ING_ID
                  AND A.COMPANY_ID = B.COMPANY_ID
                LEFT JOIN SCMDATA.T_ORDERED C
                   ON C.ORDER_CODE = A.DOCUMENT_NO
                  AND A.COMPANY_ID = C.COMPANY_ID*/
 LEFT JOIN (SELECT Z.*, REGEXP_SUBSTR(Z.QC_MANAGER, '[^,]+', 1, LEVEL) QCZG2
  FROM SCMDATA.PT_ORDERED Z
CONNECT BY PRIOR Z.PT_ORDERED_ID = Z.PT_ORDERED_ID
       AND LEVEL <= LENGTH(Z.QC_MANAGER) -
           LENGTH(REGEXP_REPLACE(Z.QC_MANAGER, ',', '')) + 1
       AND PRIOR DBMS_RANDOM.VALUE IS NOT NULL
) D
    ON D.PRODUCT_GRESS_CODE = A.DOCUMENT_NO
   AND D.COMPANY_ID = A.COMPANY_ID
   INNER JOIN SCMDATA.T_COMMODITY_INFO E ON E.GOO_ID=A.GOO_ID AND E.COMPANY_ID=A.COMPANY_ID
 --WHERE B.AMOUNT > 0
 GROUP BY A.COMPANY_ID,
          EXTRACT(YEAR FROM A.CREATE_TIME),
          DECODE(TO_CHAR(A.CREATE_TIME,'Q'),1,1,2,1,3,2,4,2),
          E.CATEGORY,
          D.GROUP_NAME,
          D.QCZG2) Y ]';

    V_SQL2 := q'[  MERGE INTO SCMDATA.T_RTKPI_HALFYEAR A
USING (
   WITH TEMP_RT AS
 (SELECT Z.RM_ID, Z.COMPANY_ID, Z.YEAR, Z.QUARTER, Z.ACCESS_TIME,Z.SUPPLIER_CODE,
         Z.GOO_ID, Z.EXAMOUNT, Z.QC_DIRECTOR_ID,
         Z.RM_ID || ROW_NUMBER() OVER(PARTITION BY Z.RM_ID ORDER BY 1) RM_ID2,
         Z.EXAMOUNT / (COUNT(Z.RM_ID) OVER(PARTITION BY(Z.RM_ID))) EXGAMOUNT2,
         REGEXP_SUBSTR(Z.SUP_GROUP_NAME, '[^,]+', 1, LEVEL) SUP_GROUP_NAME2
    FROM SCMDATA.T_RETURN_MANAGEMENT Z
   WHERE Z.AUDIT_TIME IS NOT NULL
  CONNECT BY PRIOR RM_ID = RM_ID
         AND LEVEL <= LENGTH(Z.SUP_GROUP_NAME) -
             LENGTH(REGEXP_REPLACE(Z.SUP_GROUP_NAME, ',', '')) + 1
         AND PRIOR DBMS_RANDOM.VALUE IS NOT NULL),
 TEMP_RT2 AS
 (SELECT Z.RM_ID, Z.COMPANY_ID, Z.YEAR, Z.QUARTER,  Z.ACCESS_TIME,Z.SUPPLIER_CODE,
         Z.GOO_ID, Z.EXAMOUNT, Z.QC_DIRECTOR_ID,
         Z.RM_ID || ROW_NUMBER() OVER(PARTITION BY Z.RM_ID ORDER BY 1) RM_ID2,
         Z.EXAMOUNT / (COUNT(Z.RM_ID) OVER(PARTITION BY(Z.RM_ID))) EXGAMOUNT2,
         REGEXP_SUBSTR(Z.SUP_GROUP_NAME, '[^,]+', 1, LEVEL) SUP_GROUP_NAME2
    FROM SCMDATA.T_RETURN_MANAGEMENT Z
    LEFT JOIN SCMDATA.T_ABNORMAL_DTL_CONFIG C
      ON Z.CAUSE_DETAIL_ID = C.ABNORMAL_DTL_CONFIG_ID
     AND Z.COMPANY_ID = C.COMPANY_ID
     AND C.ANOMALY_CLASSIFICATION = 'AC_QUALITY'
   INNER JOIN SCMDATA.SYS_COMPANY_DEPT D
      ON D.COMPANY_DEPT_ID = Z.FIRST_DEPT_ID
   WHERE Z.AUDIT_TIME IS NOT NULL
     AND C.CAUSE_CLASSIFICATION <> '银饰氧化问题'
     AND C.PROBLEM_CLASSIFICATION <> '非质量问题'
     AND D.DEPT_NAME = '供应链管理部'
     AND INSTR(Z.SECOND_DEPT_ID, 'b550778b4f2d36b4e0533c281caca074') > 0
  CONNECT BY PRIOR RM_ID = RM_ID
         AND LEVEL <= LENGTH(Z.SUP_GROUP_NAME) -
             LENGTH(REGEXP_REPLACE(Z.SUP_GROUP_NAME, ',', '')) + 1
         AND PRIOR DBMS_RANDOM.VALUE IS NOT NULL),
TEMP_PTORDER AS
 (SELECT T1.PT_ORDERED_ID, T1.GOO_ID_PR,T1.ORDER_ID, T1.DELIVERY_AMOUNT,
         T1.PT_ORDERED_ID || ROW_NUMBER() OVER(PARTITION BY T1.PT_ORDERED_ID ORDER BY 1) ID2,
         T1.COMPANY_ID, T1.PRODUCT_GRESS_CODE, T1.ORDER_MONEY,
         (T1.ORDER_MONEY / COUNT(T1.PRODUCT_GRESS_CODE)
           OVER(PARTITION BY T1.PRODUCT_GRESS_CODE)) SUM1,
         REGEXP_SUBSTR(T1.QC_MANAGER, '[^,]+', 1, LEVEL) QCZG2
    FROM SCMDATA.PT_ORDERED T1
   WHERE T1.QC_MANAGER IS NOT NULL
  CONNECT BY PRIOR T1.PT_ORDERED_ID = T1.PT_ORDERED_ID
         AND LEVEL <=
             LENGTH(T1.QC_MANAGER) - LENGTH(REGEXP_REPLACE(T1.QC_MANAGER, ',', '')) + 1
         AND PRIOR DBMS_RANDOM.VALUE IS NOT NULL)

SELECT Y.COMPANY_ID, Y.YEAR, Y.HALFYEAR,  Y.CATEGORY, Y.GROUP_NAME,
       '08' COUNT_DIMENSION, Y.DIMENSION_SORT DIMENSION_SORT, Y.RMMONEY SHOP_RT_ORIGINAL_MONEY,
       X.SHOP_RT_MONEY/*, Z.ORDER_MONEY INGOOD_MONEY*/
  FROM (SELECT A.COMPANY_ID, A.YEAR, DECODE(A.QUARTER,1,1,2,1,3,2,4,2) HALFYEAR, B.CATEGORY,
       (CASE WHEN A.SUP_GROUP_NAME2 IS NULL THEN  '1' ELSE   A.SUP_GROUP_NAME2
       END) GROUP_NAME, '08' COUNT_DIMENSION, (CASE WHEN A.QCZG2 IS NULL THEN '1' ELSE A.QCZG2 END) DIMENSION_SORT,
       SUM(A.EXGAMOUNT3 * B.PRICE) RMMONEY FROM
         (SELECT Z.COMPANY_ID, Z.YEAR, Z.QUARTER, Z.ACCESS_TIME, Z.GOO_ID,
                Z.SUP_GROUP_NAME2,
                Z.EXGAMOUNT2 / NVL((REGEXP_COUNT(Z.QC_DIRECTOR_ID, ',') + 1),1) EXGAMOUNT3,
                REGEXP_SUBSTR(Z.QC_DIRECTOR_ID, '[^,]+', 1, LEVEL) QCZG2
           FROM TEMP_RT Z
          WHERE (EXISTS (SELECT MAX(1)
                           FROM SCMDATA.T_PLAT_LOG X
                           INNER JOIN SCMDATA.T_PLAT_LOGS Y ON X.COMPANY_ID=Y.COMPANY_ID AND X.LOG_ID = Y.LOG_ID
                          WHERE X.APPLY_PK_ID = Z.RM_ID
                            AND Y.OPERATE_FIELD ='QC_DIRECTOR_ID'
                            AND X.ACTION_TYPE = 'UPDATE') OR
                 (NOT EXISTS (SELECT MAX(1)
                                       FROM SCMDATA.T_PLAT_LOG Y
                                       INNER JOIN SCMDATA.T_PLAT_LOGS X ON X.COMPANY_ID=Y.COMPANY_ID AND X.LOG_ID = Y.LOG_ID
                                      WHERE Y.APPLY_PK_ID = Z.RM_ID
                                        AND X.OPERATE_FIELD ='QC_DIRECTOR_ID'
                                        AND Y.ACTION_TYPE = 'UPDATE') AND
                  NOT EXISTS
                  (SELECT 1
                            FROM TEMP_PTORDER J
                           INNER JOIN SCMDATA.T_ORDERED P
                              ON P.ORDER_ID = J.ORDER_ID
                             AND P.COMPANY_ID = J.COMPANY_ID
                           WHERE J.GOO_ID_PR= Z.GOO_ID
                             AND J.COMPANY_ID = Z.COMPANY_ID AND P.SUPPLIER_CODE = Z.SUPPLIER_CODE
                             AND J.DELIVERY_AMOUNT > 0
                             AND J.QCZG2 IS NOT NULL)))
         CONNECT BY PRIOR Z.RM_ID2 = Z.RM_ID2
                AND LEVEL <= LENGTH(Z.QC_DIRECTOR_ID) -
                    LENGTH(REGEXP_REPLACE(Z.QC_DIRECTOR_ID, ',', '')) + 1
                AND PRIOR DBMS_RANDOM.VALUE IS NOT NULL
         UNION ALL
         SELECT H.COMPANY_ID, H.YEAR, H.QUARTER, H.ACCESS_TIME, H.GOO_ID,
                H.SUP_GROUP_NAME2,
                (H.EXGAMOUNT2 *
                 ((SELECT SUM(J.SUM1)
                      FROM TEMP_PTORDER J
                           INNER JOIN SCMDATA.T_ORDERED P
                              ON P.ORDER_ID = J.ORDER_ID
                             AND P.COMPANY_ID = J.COMPANY_ID
                           WHERE J.GOO_ID_PR = H.GOO_ID AND P.SUPPLIER_CODE = H.SUPPLIER_CODE
                       AND J.COMPANY_ID = H.COMPANY_ID AND J.DELIVERY_AMOUNT > 0
                       AND J.QCZG2 = H.QCZG2) /
                 (SELECT SUM(J.ORDER_MONEY)
                      FROM TEMP_PTORDER J
                           INNER JOIN SCMDATA.T_ORDERED P
                              ON P.ORDER_ID = J.ORDER_ID
                             AND P.COMPANY_ID = J.COMPANY_ID
                           WHERE J.GOO_ID_PR = H.GOO_ID
                       AND H.COMPANY_ID = J.COMPANY_ID AND P.SUPPLIER_CODE = H.SUPPLIER_CODE AND J.DELIVERY_AMOUNT > 0
                       AND J.QCZG2 IS NOT NULL))) EXGAMOUNT3, H.QCZG2
           FROM (SELECT Z.*, REGEXP_SUBSTR(Z.QC_DIRECTOR_ID, '[^,]+', 1, LEVEL) QCZG2
                    FROM TEMP_RT Z
                   WHERE NOT EXISTS (SELECT MAX(1)
                            FROM SCMDATA.T_PLAT_LOG Y
                            INNER JOIN SCMDATA.T_PLAT_LOGS X ON X.COMPANY_ID=Y.COMPANY_ID AND X.LOG_ID = Y.LOG_ID
                           WHERE Y.APPLY_PK_ID = Z.RM_ID
                             AND X.OPERATE_FIELD ='QC_DIRECTOR_ID'
                             AND Y.ACTION_TYPE = 'UPDATE')
                     AND EXISTS
                   (SELECT MAX(1)
                            FROM  TEMP_PTORDER J
                           INNER JOIN  SCMDATA.T_ORDERED P
                              ON P.ORDER_ID = J.ORDER_ID
                             AND P.COMPANY_ID = J.COMPANY_ID
                           WHERE J.GOO_ID_PR = Z.GOO_ID AND P.SUPPLIER_CODE = Z.SUPPLIER_CODE AND J.DELIVERY_AMOUNT > 0 AND J.QCZG2 IS NOT NULL
                             AND J.COMPANY_ID = Z.COMPANY_ID)
                  CONNECT BY PRIOR Z.RM_ID2 = Z.RM_ID2
                         AND LEVEL <=
                             LENGTH(Z.QC_DIRECTOR_ID) -
                             LENGTH(REGEXP_REPLACE(Z.QC_DIRECTOR_ID, ',', '')) + 1
                         AND PRIOR DBMS_RANDOM.VALUE IS NOT NULL) H) A
 INNER JOIN SCMDATA.T_COMMODITY_INFO B
    ON A.GOO_ID = B.GOO_ID
   AND A.COMPANY_ID = B.COMPANY_ID
 GROUP BY A.COMPANY_ID, A.YEAR, DECODE(A.QUARTER,1,1,2,1,3,2,4,2), B.CATEGORY,
          A.SUP_GROUP_NAME2, A.QCZG2) Y

  LEFT JOIN (SELECT A.COMPANY_ID, A.YEAR, DECODE(A.QUARTER,1,1,2,1,3,2,4,2) HALFYEAR, B.CATEGORY,
       (CASE
         WHEN A.SUP_GROUP_NAME2 IS NULL THEN
          '1'
         ELSE
          A.SUP_GROUP_NAME2
       END) GROUP_NAME, '08' COUNT_DIMENSION,( CASE WHEN A.QCZG2 IS NULL THEN '1' ELSE A.QCZG2 END) DIMENSION_SORT,
       SUM(A.EXGAMOUNT3 * B.PRICE) SHOP_RT_MONEY
  FROM (SELECT Z.COMPANY_ID, Z.YEAR, Z.QUARTER, Z.ACCESS_TIME, Z.GOO_ID,
                Z.SUP_GROUP_NAME2,
                Z.EXGAMOUNT2 / NVL((REGEXP_COUNT(Z.QC_DIRECTOR_ID, ',') + 1),1) EXGAMOUNT3,
                REGEXP_SUBSTR(Z.QC_DIRECTOR_ID, '[^,]+', 1, LEVEL) QCZG2
           FROM TEMP_RT2 Z
          WHERE (EXISTS (SELECT MAX(1)
                           FROM SCMDATA.T_PLAT_LOG X
                          INNER JOIN SCMDATA.T_PLAT_LOGS Y ON X.COMPANY_ID=Y.COMPANY_ID AND X.LOG_ID = Y.LOG_ID
                          WHERE X.APPLY_PK_ID = Z.RM_ID
                            AND Y.OPERATE_FIELD ='QC_DIRECTOR_ID'
                            AND X.ACTION_TYPE = 'UPDATE') OR
                 (NOT EXISTS (SELECT MAX(1)
                                       FROM SCMDATA.T_PLAT_LOG Y
                                       INNER JOIN SCMDATA.T_PLAT_LOGS X ON X.COMPANY_ID=Y.COMPANY_ID AND X.LOG_ID = Y.LOG_ID
                                      WHERE Y.APPLY_PK_ID = Z.RM_ID
                                        AND X.OPERATE_FIELD ='QC_DIRECTOR_ID'
                                        AND Y.ACTION_TYPE = 'UPDATE') AND
                  NOT EXISTS
                  (SELECT 1
                            FROM TEMP_PTORDER J
                           INNER JOIN  SCMDATA.T_ORDERED P
                              ON P.ORDER_ID = J.ORDER_ID
                             AND P.COMPANY_ID = J.COMPANY_ID
                           WHERE J.GOO_ID_PR = Z.GOO_ID
                             AND J.COMPANY_ID = Z.COMPANY_ID AND P.SUPPLIER_CODE = Z.SUPPLIER_CODE AND J.DELIVERY_AMOUNT > 0 AND J.QCZG2 IS NOT NULL )))
         CONNECT BY PRIOR Z.RM_ID2 = Z.RM_ID2
                AND LEVEL <= LENGTH(Z.QC_DIRECTOR_ID) -
                    LENGTH(REGEXP_REPLACE(Z.QC_DIRECTOR_ID, ',', '')) + 1
                AND PRIOR DBMS_RANDOM.VALUE IS NOT NULL
         UNION ALL
         SELECT H.COMPANY_ID, H.YEAR, H.QUARTER, H.ACCESS_TIME, H.GOO_ID,
                H.SUP_GROUP_NAME2,
                (H.EXGAMOUNT2 *
                 ((SELECT SUM(J.SUM1)
                      FROM TEMP_PTORDER J
                      INNER JOIN  SCMDATA.T_ORDERED P
                              ON P.ORDER_ID = J.ORDER_ID
                             AND P.COMPANY_ID = J.COMPANY_ID
                      WHERE J.GOO_ID_PR = H.GOO_ID
                       AND J.COMPANY_ID = H.COMPANY_ID
                       AND J.QCZG2 = H.QCZG2 AND P.SUPPLIER_CODE = H.SUPPLIER_CODE AND J.DELIVERY_AMOUNT > 0) /
                 (SELECT SUM(J.ORDER_MONEY)
                      FROM TEMP_PTORDER J
                      INNER JOIN  SCMDATA.T_ORDERED P
                              ON P.ORDER_ID = J.ORDER_ID
                             AND P.COMPANY_ID = J.COMPANY_ID
                      WHERE J.GOO_ID_PR  = H.GOO_ID
                       AND H.COMPANY_ID = J.COMPANY_ID AND P.SUPPLIER_CODE = H.SUPPLIER_CODE AND J.DELIVERY_AMOUNT > 0
                       AND J.QCZG2 IS NOT NULL))) EXGAMOUNT3, H.QCZG2
           FROM (SELECT Z.*, REGEXP_SUBSTR(Z.QC_DIRECTOR_ID, '[^,]+', 1, LEVEL) QCZG2
                    FROM TEMP_RT2 Z
                   WHERE NOT EXISTS (SELECT MAX(1)
                            FROM SCMDATA.T_PLAT_LOG Y
                            INNER JOIN SCMDATA.T_PLAT_LOGS X ON X.COMPANY_ID=Y.COMPANY_ID AND X.LOG_ID = Y.LOG_ID
                           WHERE Y.APPLY_PK_ID = Z.RM_ID
                             AND X.OPERATE_FIELD ='QC_DIRECTOR_ID'
                             AND Y.ACTION_TYPE = 'UPDATE')
                     AND EXISTS
                   (SELECT MAX(1)
                            FROM TEMP_PTORDER J
                      INNER JOIN  SCMDATA.T_ORDERED P
                              ON P.ORDER_ID = J.ORDER_ID
                             AND P.COMPANY_ID = J.COMPANY_ID
                      WHERE J.GOO_ID_PR = Z.GOO_ID
                             AND J.COMPANY_ID = Z.COMPANY_ID AND P.SUPPLIER_CODE = Z.SUPPLIER_CODE AND J.DELIVERY_AMOUNT > 0 AND J.QCZG2 IS NOT NULL)
                  CONNECT BY PRIOR Z.RM_ID2 = Z.RM_ID2
                         AND LEVEL <=
                             LENGTH(Z.QC_DIRECTOR_ID) -
                             LENGTH(REGEXP_REPLACE(Z.QC_DIRECTOR_ID, ',', '')) + 1
                         AND PRIOR DBMS_RANDOM.VALUE IS NOT NULL) H) A
 INNER JOIN SCMDATA.T_COMMODITY_INFO B
    ON A.GOO_ID = B.GOO_ID
   AND A.COMPANY_ID = B.COMPANY_ID
 GROUP BY A.COMPANY_ID, A.YEAR, DECODE(A.QUARTER,1,1,2,1,3,2,4,2),B.CATEGORY,
          A.SUP_GROUP_NAME2, A.QCZG2) X
    ON X.COMPANY_ID = Y.COMPANY_ID
   AND X.YEAR = Y.YEAR
   AND X.HALFYEAR = Y.HALFYEAR
   AND X.CATEGORY = Y.CATEGORY
   AND X.GROUP_NAME = Y.GROUP_NAME
   AND X.COUNT_DIMENSION = Y.COUNT_DIMENSION
   AND X.DIMENSION_SORT = Y.DIMENSION_SORT
  /*LEFT JOIN ( SELECT A.COMPANY_ID,
       EXTRACT(YEAR FROM A.CREATE_TIME) YEAR,
       DECODE(TO_CHAR(A.CREATE_TIME,'Q'),1,1,2,1,3,2,4,2) HALFYEAR,
       D.CATEGORY,
       (CASE WHEN D.GROUP_NAME IS NULL THEN  '1'  ELSE D.GROUP_NAME END) GROUP_NAME,
       '08' COUNT_DIMENSION,
       (case when D.QCZG2 is null then '1' else D.QCZG2 end) DIMENSION_SORT,
       SUM(CASE WHEN REGEXP_COUNT(D.QC_MANAGER, ',') > 0 THEN
       B.AMOUNT/NVL((REGEXP_COUNT(D.QC_MANAGER, ',') + 1),1) * E.PRICE ELSE
           B.AMOUNT * E.PRICE END ) ORDER_MONEY
  FROM SCMDATA.T_INGOOD A
 INNER JOIN SCMDATA.T_INGOODS B
    ON A.ING_ID = B.ING_ID
   AND A.COMPANY_ID = B.COMPANY_ID
 INNER JOIN SCMDATA.T_ORDERED C
    ON C.ORDER_CODE = A.DOCUMENT_NO
   AND A.COMPANY_ID = C.COMPANY_ID
 INNER JOIN (SELECT Z.*, REGEXP_SUBSTR(Z.QC_MANAGER, '[^,]+', 1, LEVEL) QCZG2
  FROM SCMDATA.PT_ORDERED Z
CONNECT BY PRIOR Z.PT_ORDERED_ID = Z.PT_ORDERED_ID
       AND LEVEL <= LENGTH(Z.QC_MANAGER) -
           LENGTH(REGEXP_REPLACE(Z.QC_MANAGER, ',', '')) + 1
       AND PRIOR DBMS_RANDOM.VALUE IS NOT NULL
) D
    ON D.ORDER_ID = C.ORDER_ID
   AND D.COMPANY_ID = C.COMPANY_ID
   INNER JOIN SCMDATA.T_COMMODITY_INFO E ON E.GOO_ID=B.GOO_ID AND E.COMPANY_ID=B.COMPANY_ID
 WHERE B.AMOUNT > 0
 GROUP BY A.COMPANY_ID,
          EXTRACT(YEAR FROM A.CREATE_TIME),
          DECODE(TO_CHAR(A.CREATE_TIME,'Q'),1,1,2,1,3,2,4,2),
          D.CATEGORY,
          D.GROUP_NAME,
          D.QCZG2) Z
    ON Z.COMPANY_ID = Y.COMPANY_ID
   AND Z.YEAR = Y.YEAR
   AND Z.HALFYEAR = Y.HALFYEAR
   AND Z.CATEGORY = Y.CATEGORY
   AND Z.GROUP_NAME = Y.GROUP_NAME
   AND Z.COUNT_DIMENSION = Y.COUNT_DIMENSION
   AND Z.DIMENSION_SORT = Y.DIMENSION_SORT */ ]';

    IF P_TYPE = 0 THEN
      --进货
      V_EXSQL1 := V_SQL1||V_WH_SQL2||V_U_SQL1||V_I_SQL1;
      --退货
      V_EXSQL2 := V_SQL2 || V_WH_SQL2 || V_U_SQL2 || V_I_SQL2;


    ELSIF P_TYPE = 1 THEN
      --进货
      V_EXSQL1 := V_SQL1||V_WM_SQL1||V_U_SQL1||V_I_SQL1;
      --退货
      V_EXSQL2 := V_SQL2 || V_WM_SQL1 || V_U_SQL2 || V_I_SQL2;
    END IF;
    EXECUTE IMMEDIATE V_EXSQL2;
     EXECUTE IMMEDIATE V_EXSQL1;
    --dbms_output.put_line(V_EXSQL1);
    --dbms_output.put_line(V_EXSQL2);
  END P_RTKPI_HALFYEAR;

  PROCEDURE P_RTKPI_YEAR(P_TYPE NUMBER) IS
    V_SQL1    CLOB;
    V_SQL2     CLOB;
    V_WH_SQL2 CLOB; --全部历史数据
    V_EXSQL1   CLOB;
    V_EXSQL2   CLOB;
    V_WM_SQL1 CLOB; --上一时间维度
    V_U_SQL1  CLOB := q'[ update
                           set a.INGOOD_MONEY           =tkb.INGOOD_MONEY,
                               a.update_id              = 'ADMIN',
                               a.update_time            = sysdate
                 ]';
    V_U_SQL2  CLOB := q'[ update
                           set a.SHOP_RT_MONEY          = tkb.SHOP_RT_MONEY,
                               a.SHOP_RT_ORIGINAL_MONEY = tkb.SHOP_RT_ORIGINAL_MONEY,
                               a.update_id              = 'ADMIN',
                               a.update_time            = sysdate
                 ]';
    V_I_SQL1  CLOB := q'[
    WHEN NOT MATCHED THEN
      INSERT (a.T_RTKPI_Y_ID,a.company_id,a.year,a.category,a.groupname,a.count_dimension,a.dimension_sort,a.ingood_money,a.create_id,a.create_time,a.update_id,a.update_time)
      values (scmdata.f_get_uuid(),
         tkb.company_id,
         tkb.year,
         tkb.category,
         tkb.group_name,
         tkb.count_dimension,
         tkb.dimension_sort,
         tkb.INGOOD_MONEY,
         'ADMIN',sysdate,'ADMIN',sysdate) ]';

    V_I_SQL2  CLOB := q'[
    WHEN NOT MATCHED THEN
      INSERT (a.T_RTKPI_Y_ID,a.company_id,a.year,a.category,a.groupname,a.count_dimension,a.dimension_sort,a.shop_rt_money,a.shop_rt_original_money,a.create_id,a.create_time,a.update_id,a.update_time)
      values (scmdata.f_get_uuid(),
         tkb.company_id,
         tkb.year,
         tkb.category,
         tkb.group_name,
         tkb.count_dimension,
         tkb.dimension_sort,
         tkb.SHOP_RT_MONEY,
         tkb.SHOP_RT_ORIGINAL_MONEY,
         'ADMIN',sysdate,'ADMIN',sysdate) ]';

  BEGIN

    --全部历史数据
    V_WH_SQL2 := q'[
       WHERE y.year < TO_CHAR(SYSDATE,'YYYY')
        and y.year>=2023
          ) tkb
          ON (tkb.company_id = a.company_id AND tkb.year = a.year   AND tkb.category=a.category
           AND tkb.group_name = a.groupname AND tkb.count_dimension =a.count_dimension AND tkb.dimension_sort =a.dimension_sort  )
           when matched then ]';

    --上一时间维度
    V_WM_SQL1 := q'[
      where y.year = TO_CHAR(SYSDATE,'YYYY')-1
        ) tkb
      ON (tkb.company_id = a.company_id AND tkb.year = a.year AND tkb.category=a.category
           AND tkb.group_name = a.groupname AND tkb.count_dimension =a.count_dimension AND tkb.dimension_sort =a.dimension_sort  )
           when matched then ]';
    --分类维度
     V_SQL1 := q'[MERGE INTO SCMDATA.T_RTKPI_YEAR A
             USING (SELECT y.COMPANY_ID, y.YEAR,  y.CATEGORY,
              y.GROUP_NAME, y.COUNT_DIMENSION, y.DIMENSION_SORT,
              y.ORDER_MONEY INGOOD_MONEY
        FROM (SELECT A.COMPANY_ID, EXTRACT(YEAR FROM A.CREATE_TIME) YEAR,
                       E.CATEGORY,
                       (CASE
                         WHEN D.GROUP_NAME IS NULL THEN
                          '1'
                         ELSE
                          D.GROUP_NAME
                       END) GROUP_NAME, '00' COUNT_DIMENSION,
                       E.CATEGORY DIMENSION_SORT,
                       SUM(A.AMOUNT * E.PRICE) ORDER_MONEY
                  FROM (SELECT T.DOCUMENT_NO,
                    T.COMPANY_ID,
                    TRUNC(T.CREATE_TIME) CREATE_TIME,
                    SUM(TL.AMOUNT) AMOUNT,
                    TL.GOO_ID
               FROM SCMDATA.T_INGOOD T
              INNER JOIN (SELECT TI.ING_ID,
                                TI.COMPANY_ID,
                                TI.GOO_ID,
                                TI.AMOUNT
                           FROM SCMDATA.T_INGOODS TI
                          WHERE TI.AMOUNT > 0) TL
                 ON TL.ING_ID = T.ING_ID
                AND TL.COMPANY_ID = T.COMPANY_ID
              WHERE TO_CHAR(T.CREATE_TIME, 'yyyy') >= 2022
              GROUP BY T.DOCUMENT_NO,
                       T.COMPANY_ID,
                       TRUNC(T.CREATE_TIME),
                       TL.GOO_ID) A
                  /*SCMDATA.T_INGOOD A
                 INNER JOIN SCMDATA.T_INGOODS B
                    ON A.ING_ID = B.ING_ID
                   AND A.COMPANY_ID = B.COMPANY_ID
                 LEFT JOIN SCMDATA.T_ORDERED C
                    ON C.ORDER_CODE = A.DOCUMENT_NO
                   AND A.COMPANY_ID = C.COMPANY_ID*/
                 LEFT JOIN SCMDATA.PT_ORDERED D
                    ON D.PRODUCT_GRESS_CODE = A.DOCUMENT_NO
                   AND D.COMPANY_ID = A.COMPANY_ID
                  INNER JOIN SCMDATA.T_COMMODITY_INFO E ON E.GOO_ID=A.GOO_ID AND E.COMPANY_ID=A.COMPANY_ID
                 --WHERE B.AMOUNT > 0
                 GROUP BY A.COMPANY_ID, EXTRACT(YEAR FROM A.CREATE_TIME), E.CATEGORY,
                          D.GROUP_NAME) Y ]';

    V_SQL2 := q'[MERGE INTO SCMDATA.T_RTKPI_YEAR A
             USING (SELECT y.COMPANY_ID, y.YEAR,  y.CATEGORY,
              y.GROUP_NAME, y.COUNT_DIMENSION, y.DIMENSION_SORT,
              /*Z.ORDER_MONEY INGOOD_MONEY,*/ Y.RMMONEY SHOP_RT_ORIGINAL_MONEY, X.RMMONEY2 SHOP_RT_MONEY
          FROM
         (SELECT A.COMPANY_ID, A.YEAR,
                          B.CATEGORY,
                          (CASE
                            WHEN A.SUP_GROUP_NAME2 IS NULL THEN
                             '1'
                            ELSE
                             A.SUP_GROUP_NAME2
                          END) GROUP_NAME, '00' COUNT_DIMENSION,
                          B.CATEGORY DIMENSION_SORT,
                          SUM(CASE
                                WHEN REGEXP_COUNT(A.SUP_GROUP_NAME, ',') > 0 THEN
                                 A.EXAMOUNT /
                                 (REGEXP_COUNT(A.SUP_GROUP_NAME, ',') + 1) *
                                 B.PRICE
                                ELSE
                                 A.EXAMOUNT * B.PRICE
                              END) RMMONEY
                     FROM (SELECT Z.RM_ID, Z.COMPANY_ID, Z.YEAR, Z.QUARTER,
                                   Z.ACCESS_TIME, Z.GOO_ID, Z.EXAMOUNT,
                                   Z.SUP_GROUP_NAME, Z.AUDIT_TIME,
                                   REGEXP_SUBSTR(Z.SUP_GROUP_NAME,
                                                  '[^,]+',
                                                  1,
                                                  LEVEL) SUP_GROUP_NAME2
                              FROM SCMDATA.T_RETURN_MANAGEMENT Z
                            CONNECT BY PRIOR RM_ID = RM_ID
                                   AND LEVEL <=
                                       LENGTH(Z.SUP_GROUP_NAME) -
                                       LENGTH(REGEXP_REPLACE(Z.SUP_GROUP_NAME,
                                                             ',',
                                                             '')) + 1
                                   AND PRIOR DBMS_RANDOM.VALUE IS NOT NULL) A
                    INNER JOIN SCMDATA.T_COMMODITY_INFO B
                       ON A.GOO_ID = B.GOO_ID
                      AND A.COMPANY_ID = B.COMPANY_ID
                    WHERE A.AUDIT_TIME IS NOT NULL
                    GROUP BY A.COMPANY_ID, A.YEAR,
                             B.CATEGORY,
                             A.SUP_GROUP_NAME2) Y

         LEFT JOIN (SELECT A.COMPANY_ID, A.YEAR,
                          B.CATEGORY,
                          (CASE
                            WHEN A.SUP_GROUP_NAME2 IS NULL THEN
                             '1'
                            ELSE
                             A.SUP_GROUP_NAME2
                          END) GROUP_NAME, '00' COUNT_DIMENSION,
                          B.CATEGORY DIMENSION_SORT,
                          SUM(CASE
                                WHEN REGEXP_COUNT(A.SUP_GROUP_NAME, ',') > 0 THEN
                                 A.EXAMOUNT /
                                 (REGEXP_COUNT(A.SUP_GROUP_NAME, ',') + 1) *
                                 B.PRICE
                                ELSE
                                 A.EXAMOUNT * B.PRICE
                              END) RMMONEY2
                     FROM (SELECT Z.RM_ID, Z.COMPANY_ID, Z.YEAR, Z.QUARTER,
                                   Z.ACCESS_TIME, Z.GOO_ID, Z.EXAMOUNT,
                                   Z.SUP_GROUP_NAME, Z.AUDIT_TIME,
                                   Z.CAUSE_DETAIL_ID, Z.FIRST_DEPT_ID,
                                   Z.SECOND_DEPT_ID,
                                   REGEXP_SUBSTR(Z.SUP_GROUP_NAME,
                                                  '[^,]+',
                                                  1,
                                                  LEVEL) SUP_GROUP_NAME2
                              FROM SCMDATA.T_RETURN_MANAGEMENT Z
                            CONNECT BY PRIOR RM_ID = RM_ID
                                   AND LEVEL <=
                                       LENGTH(Z.SUP_GROUP_NAME) -
                                       LENGTH(REGEXP_REPLACE(Z.SUP_GROUP_NAME,
                                                             ',',
                                                             '')) + 1
                                   AND PRIOR DBMS_RANDOM.VALUE IS NOT NULL) A
                    INNER JOIN SCMDATA.T_COMMODITY_INFO B
                       ON A.GOO_ID = B.GOO_ID
                      AND A.COMPANY_ID = B.COMPANY_ID
                     LEFT JOIN SCMDATA.T_ABNORMAL_DTL_CONFIG C
                       ON A.CAUSE_DETAIL_ID = C.ABNORMAL_DTL_CONFIG_ID
                      AND A.COMPANY_ID = C.COMPANY_ID
                      AND C.ANOMALY_CLASSIFICATION = 'AC_QUALITY'
                    INNER JOIN SCMDATA.SYS_COMPANY_DEPT D
                       ON D.COMPANY_DEPT_ID = A.FIRST_DEPT_ID
                    WHERE A.AUDIT_TIME IS NOT NULL
                      AND C.CAUSE_CLASSIFICATION <> '银饰氧化问题'
                      AND C.PROBLEM_CLASSIFICATION <> '非质量问题'
                      AND D.DEPT_NAME = '供应链管理部'
                    GROUP BY A.COMPANY_ID, A.YEAR, B.CATEGORY,
                             A.SUP_GROUP_NAME2) X
           ON X.COMPANY_ID = Y.COMPANY_ID
          AND X.YEAR = Y.YEAR
          AND X.CATEGORY = Y.CATEGORY
          AND X.GROUP_NAME = Y.GROUP_NAME
          AND X.COUNT_DIMENSION = Y.COUNT_DIMENSION
          AND X.DIMENSION_SORT = Y.DIMENSION_SORT
          /*LEFT JOIN (SELECT A.COMPANY_ID, EXTRACT(YEAR FROM A.CREATE_TIME) YEAR,
                       D.CATEGORY,
                       (CASE
                         WHEN D.GROUP_NAME IS NULL THEN
                          '1'
                         ELSE
                          D.GROUP_NAME
                       END) GROUP_NAME, '00' COUNT_DIMENSION,
                       D.CATEGORY DIMENSION_SORT,
                       SUM(B.AMOUNT * E.PRICE) ORDER_MONEY
                  FROM SCMDATA.T_INGOOD A
                 INNER JOIN SCMDATA.T_INGOODS B
                    ON A.ING_ID = B.ING_ID
                   AND A.COMPANY_ID = B.COMPANY_ID
                 INNER JOIN SCMDATA.T_ORDERED C
                    ON C.ORDER_CODE = A.DOCUMENT_NO
                   AND A.COMPANY_ID = C.COMPANY_ID
                 INNER JOIN SCMDATA.PT_ORDERED D
                    ON D.ORDER_ID = C.ORDER_ID
                   AND D.COMPANY_ID = C.COMPANY_ID
                  INNER JOIN SCMDATA.T_COMMODITY_INFO E ON E.GOO_ID=B.GOO_ID AND E.COMPANY_ID=B.COMPANY_ID
                 WHERE B.AMOUNT > 0
                 GROUP BY A.COMPANY_ID, EXTRACT(YEAR FROM A.CREATE_TIME), D.CATEGORY,
                          D.GROUP_NAME) z ON Z.COMPANY_ID = Y.COMPANY_ID
          AND Z.YEAR = Y.YEAR
          AND Z.CATEGORY = Y.CATEGORY
          AND Z.GROUP_NAME = Y.GROUP_NAME
          AND Z.COUNT_DIMENSION = Y.COUNT_DIMENSION
          AND Z.DIMENSION_SORT = Y.DIMENSION_SORT*/ ]';
    /*p_type = 0 更新全部历史数据
    p_type = 1  只更新上一个月的数据 */
     IF P_TYPE = 0 THEN
      --进货
      V_EXSQL1 := V_SQL1||V_WH_SQL2||V_U_SQL1||V_I_SQL1;
      --退货
      V_EXSQL2 := V_SQL2 || V_WH_SQL2 || V_U_SQL2 || V_I_SQL2;


    ELSIF P_TYPE = 1 THEN
      --进货
      V_EXSQL1 := V_SQL1||V_WM_SQL1||V_U_SQL1||V_I_SQL1;
      --退货
      V_EXSQL2 := V_SQL2 || V_WM_SQL1 || V_U_SQL2 || V_I_SQL2;
    END IF;
    EXECUTE IMMEDIATE V_EXSQL2;
     EXECUTE IMMEDIATE V_EXSQL1;
    --dbms_output.put_line(V_EXSQL1);
    --dbms_output.put_line(V_EXSQL2);

    --区域组
    V_SQL1:=q'[MERGE INTO SCMDATA.T_RTKPI_YEAR A
USING (SELECT Y.COMPANY_ID, Y.YEAR,  Y.CATEGORY,
              Y.GROUP_NAME, Y.COUNT_DIMENSION, Y.DIMENSION_SORT,
              Y.ORDER_MONEY INGOOD_MONEY
         FROM (SELECT A.COMPANY_ID,
       EXTRACT(YEAR FROM A.CREATE_TIME) YEAR,
       E.CATEGORY,
       (CASE WHEN D.GROUP_NAME IS NULL THEN  '1'  ELSE D.GROUP_NAME END) GROUP_NAME,
       '01' COUNT_DIMENSION,
       (CASE WHEN D.GROUP_NAME IS NULL THEN  '1'  ELSE D.GROUP_NAME END) DIMENSION_SORT,
       SUM(A.AMOUNT * E.PRICE) ORDER_MONEY
  FROM (SELECT T.DOCUMENT_NO,
                    T.COMPANY_ID,
                    TRUNC(T.CREATE_TIME) CREATE_TIME,
                    SUM(TL.AMOUNT) AMOUNT,
                    TL.GOO_ID
               FROM SCMDATA.T_INGOOD T
              INNER JOIN (SELECT TI.ING_ID,
                                TI.COMPANY_ID,
                                TI.GOO_ID,
                                TI.AMOUNT
                           FROM SCMDATA.T_INGOODS TI
                          WHERE TI.AMOUNT > 0) TL
                 ON TL.ING_ID = T.ING_ID
                AND TL.COMPANY_ID = T.COMPANY_ID
              WHERE TO_CHAR(T.CREATE_TIME, 'yyyy') >= 2022
              GROUP BY T.DOCUMENT_NO,
                       T.COMPANY_ID,
                       TRUNC(T.CREATE_TIME),
                       TL.GOO_ID) A
                  /*SCMDATA.T_INGOOD A
                 INNER JOIN SCMDATA.T_INGOODS B
                    ON A.ING_ID = B.ING_ID
                   AND A.COMPANY_ID = B.COMPANY_ID
                 LEFT JOIN SCMDATA.T_ORDERED C
                    ON C.ORDER_CODE = A.DOCUMENT_NO
                   AND A.COMPANY_ID = C.COMPANY_ID*/
                 LEFT JOIN SCMDATA.PT_ORDERED D
                    ON D.PRODUCT_GRESS_CODE = A.DOCUMENT_NO
                   AND D.COMPANY_ID = A.COMPANY_ID
                  INNER JOIN SCMDATA.T_COMMODITY_INFO E ON E.GOO_ID=A.GOO_ID AND E.COMPANY_ID=A.COMPANY_ID
                 --WHERE B.AMOUNT > 0
 GROUP BY A.COMPANY_ID,
          EXTRACT(YEAR FROM A.CREATE_TIME),
          E.CATEGORY,
          D.GROUP_NAME) Y     ]';

    V_SQL2 := q'[MERGE INTO SCMDATA.T_RTKPI_YEAR A
USING (SELECT Y.COMPANY_ID, Y.YEAR,  Y.CATEGORY,
              Y.GROUP_NAME, Y.COUNT_DIMENSION, Y.DIMENSION_SORT,
              /*Z.ORDER_MONEY INGOOD_MONEY,*/ Y.RMMONEY SHOP_RT_ORIGINAL_MONEY, X.RMMONEY2 SHOP_RT_MONEY

         FROM
         (SELECT A.COMPANY_ID, A.YEAR,
                          B.CATEGORY,
                          (CASE
                            WHEN A.SUP_GROUP_NAME2 IS NULL THEN
                             '1'
                            ELSE
                             A.SUP_GROUP_NAME2
                          END) GROUP_NAME, '01' COUNT_DIMENSION,
                         (CASE
                            WHEN A.SUP_GROUP_NAME2 IS NULL THEN
                             '1'
                            ELSE
                             A.SUP_GROUP_NAME2
                          END) DIMENSION_SORT,
                          SUM(CASE
                                WHEN REGEXP_COUNT(A.SUP_GROUP_NAME, ',') > 0 THEN
                                 A.EXAMOUNT /
                                 (REGEXP_COUNT(A.SUP_GROUP_NAME, ',') + 1) *
                                 B.PRICE
                                ELSE
                                 A.EXAMOUNT * B.PRICE
                              END) RMMONEY
                     FROM (SELECT Z.RM_ID, Z.COMPANY_ID, Z.YEAR, Z.QUARTER,
                                   Z.ACCESS_TIME, Z.GOO_ID, Z.EXAMOUNT,
                                   Z.SUP_GROUP_NAME, Z.AUDIT_TIME,
                                   REGEXP_SUBSTR(Z.SUP_GROUP_NAME,
                                                  '[^,]+',
                                                  1,
                                                  LEVEL) SUP_GROUP_NAME2
                              FROM   SCMDATA.T_RETURN_MANAGEMENT z
   CONNECT BY PRIOR RM_ID = RM_ID
          AND LEVEL <= LENGTH(z.SUP_GROUP_NAME) -
              LENGTH(REGEXP_REPLACE(z.SUP_GROUP_NAME, ',', '')) + 1
          AND PRIOR DBMS_RANDOM.VALUE IS NOT NULL) A
        INNER JOIN scmdata.T_COMMODITY_INFO B
             ON A.GOO_ID = B.GOO_ID
            AND A.COMPANY_ID = B.COMPANY_ID
       WHERE A.AUDIT_TIME IS NOT NULL
       GROUP BY A.COMPANY_ID,
                A.YEAR,
                B.CATEGORY,
                 A.SUP_GROUP_NAME2) Y

         LEFT JOIN (SELECT A.COMPANY_ID, A.YEAR,
                          B.CATEGORY,
                          (CASE  WHEN A.SUP_GROUP_NAME2 IS NULL THEN '1'    ELSE   A.SUP_GROUP_NAME2 END) GROUP_NAME,
                           '01' COUNT_DIMENSION,
                         (CASE  WHEN A.SUP_GROUP_NAME2 IS NULL THEN '1'    ELSE   A.SUP_GROUP_NAME2 END) DIMENSION_SORT,
                          SUM(CASE
                                WHEN REGEXP_COUNT(A.SUP_GROUP_NAME, ',') > 0 THEN
                                 A.EXAMOUNT /
                                 (REGEXP_COUNT(A.SUP_GROUP_NAME, ',') + 1) *
                                 B.PRICE
                                ELSE
                                 A.EXAMOUNT * B.PRICE
                              END) RMMONEY2
                     FROM (SELECT Z.RM_ID, Z.COMPANY_ID, Z.YEAR,
                                   Z.ACCESS_TIME, Z.GOO_ID, Z.EXAMOUNT,
                                   Z.SUP_GROUP_NAME, Z.AUDIT_TIME,
                                   Z.CAUSE_DETAIL_ID, Z.FIRST_DEPT_ID,
                                   Z.SECOND_DEPT_ID,
                                   REGEXP_SUBSTR(Z.SUP_GROUP_NAME,
                                                  '[^,]+',
                                                  1,
                                                  LEVEL) SUP_GROUP_NAME2
                              FROM SCMDATA.T_RETURN_MANAGEMENT z
   CONNECT BY PRIOR RM_ID = RM_ID
          AND LEVEL <= LENGTH(z.SUP_GROUP_NAME) -
              LENGTH(REGEXP_REPLACE(z.SUP_GROUP_NAME, ',', '')) + 1
          AND PRIOR DBMS_RANDOM.VALUE IS NOT NULL) A
        INNER JOIN scmdata.T_COMMODITY_INFO B
             ON A.GOO_ID = B.GOO_ID
            AND A.COMPANY_ID = B.COMPANY_ID
          LEFT JOIN SCMDATA.T_abnormal_dtl_config C ON A.CAUSE_DETAIL_ID = C.ABNORMAL_DTL_CONFIG_ID AND A.COMPANY_ID = C.COMPANY_ID AND C.ANOMALY_CLASSIFICATION='AC_QUALITY'
         INNER JOIN SCMDATA.SYS_COMPANY_DEPT D ON D.COMPANY_DEPT_ID=A.FIRST_DEPT_ID
       WHERE A.AUDIT_TIME IS NOT NULL
       AND C.CAUSE_CLASSIFICATION <> '银饰氧化问题'
       AND C.PROBLEM_CLASSIFICATION <> '非质量问题'
        AND D.DEPT_NAME = '供应链管理部'
       GROUP BY A.COMPANY_ID,
                A.YEAR,
                B.CATEGORY,
                 A.SUP_GROUP_NAME2) X
           ON X.COMPANY_ID = Y.COMPANY_ID
          AND X.YEAR = Y.YEAR
          AND X.CATEGORY = Y.CATEGORY
          AND X.GROUP_NAME = Y.GROUP_NAME
          AND X.COUNT_DIMENSION = Y.COUNT_DIMENSION
          AND X.DIMENSION_SORT = Y.DIMENSION_SORT
         /* LEFT JOIN
          (SELECT A.COMPANY_ID,
       EXTRACT(YEAR FROM A.CREATE_TIME) YEAR,
       D.CATEGORY,
       (CASE WHEN D.GROUP_NAME IS NULL THEN  '1'  ELSE D.GROUP_NAME END) GROUP_NAME,
       '01' COUNT_DIMENSION,
       (CASE WHEN D.GROUP_NAME IS NULL THEN  '1'  ELSE D.GROUP_NAME END) DIMENSION_SORT,
       SUM(B.AMOUNT * E.PRICE) ORDER_MONEY
  FROM SCMDATA.T_INGOOD A
 INNER JOIN SCMDATA.T_INGOODS B
    ON A.ING_ID = B.ING_ID
   AND A.COMPANY_ID = B.COMPANY_ID
 INNER JOIN SCMDATA.T_ORDERED C
    ON C.ORDER_CODE = A.DOCUMENT_NO
   AND A.COMPANY_ID = C.COMPANY_ID
 INNER JOIN SCMDATA.PT_ORDERED D
    ON D.ORDER_ID = C.ORDER_ID
   AND D.COMPANY_ID = C.COMPANY_ID
  INNER JOIN SCMDATA.T_COMMODITY_INFO E ON E.GOO_ID=B.GOO_ID AND E.COMPANY_ID=B.COMPANY_ID
 WHERE B.AMOUNT > 0
 GROUP BY A.COMPANY_ID,
          EXTRACT(YEAR FROM A.CREATE_TIME),
          D.CATEGORY,
          D.GROUP_NAME) z ON Z.COMPANY_ID = Y.COMPANY_ID
          AND Z.YEAR = Y.YEAR
          AND Z.CATEGORY = Y.CATEGORY
          AND Z.GROUP_NAME = Y.GROUP_NAME
          AND Z.COUNT_DIMENSION = Y.COUNT_DIMENSION
          AND Z.DIMENSION_SORT = Y.DIMENSION_SORT*/ ]';
    /*p_type = 0 更新全部历史数据
    p_type = 1  只更新上一个月的数据 */
     IF P_TYPE = 0 THEN
      --进货
      V_EXSQL1 := V_SQL1||V_WH_SQL2||V_U_SQL1||V_I_SQL1;
      --退货
      V_EXSQL2 := V_SQL2 || V_WH_SQL2 || V_U_SQL2 || V_I_SQL2;


    ELSIF P_TYPE = 1 THEN
      --进货
      V_EXSQL1 := V_SQL1||V_WM_SQL1||V_U_SQL1||V_I_SQL1;
      --退货
      V_EXSQL2 := V_SQL2 || V_WM_SQL1 || V_U_SQL2 || V_I_SQL2;
    END IF;
    EXECUTE IMMEDIATE V_EXSQL2;
     EXECUTE IMMEDIATE V_EXSQL1;
    --dbms_output.put_line(V_EXSQL1);
    --dbms_output.put_line(V_EXSQL2);

    --款式名称
    V_SQL1:=q'[MERGE INTO SCMDATA.T_RTKPI_YEAR A
USING (SELECT Y.COMPANY_ID, Y.YEAR,  Y.CATEGORY,
              Y.GROUP_NAME, Y.COUNT_DIMENSION, Y.DIMENSION_SORT,
              Y.ORDER_MONEY INGOOD_MONEY
        FROM ( SELECT A.COMPANY_ID,
       EXTRACT(YEAR FROM A.CREATE_TIME) YEAR,
       E.CATEGORY,
       (CASE WHEN D.GROUP_NAME IS NULL THEN  '1'  ELSE D.GROUP_NAME END) GROUP_NAME,
       '02' COUNT_DIMENSION,
       E.STYLE_NAME DIMENSION_SORT,
       SUM(A.AMOUNT * E.PRICE) ORDER_MONEY
  FROM (SELECT T.DOCUMENT_NO,
                    T.COMPANY_ID,
                    TRUNC(T.CREATE_TIME) CREATE_TIME,
                    SUM(TL.AMOUNT) AMOUNT,
                    TL.GOO_ID
               FROM SCMDATA.T_INGOOD T
              INNER JOIN (SELECT TI.ING_ID,
                                TI.COMPANY_ID,
                                TI.GOO_ID,
                                TI.AMOUNT
                           FROM SCMDATA.T_INGOODS TI
                          WHERE TI.AMOUNT > 0) TL
                 ON TL.ING_ID = T.ING_ID
                AND TL.COMPANY_ID = T.COMPANY_ID
              WHERE TO_CHAR(T.CREATE_TIME, 'yyyy') >= 2022
              GROUP BY T.DOCUMENT_NO,
                       T.COMPANY_ID,
                       TRUNC(T.CREATE_TIME),
                       TL.GOO_ID) A
                  /*SCMDATA.T_INGOOD A
                 INNER JOIN SCMDATA.T_INGOODS B
                    ON A.ING_ID = B.ING_ID
                   AND A.COMPANY_ID = B.COMPANY_ID
                 LEFT JOIN SCMDATA.T_ORDERED C
                    ON C.ORDER_CODE = A.DOCUMENT_NO
                   AND A.COMPANY_ID = C.COMPANY_ID*/
                 LEFT JOIN SCMDATA.PT_ORDERED D
                    ON D.PRODUCT_GRESS_CODE = A.DOCUMENT_NO
                   AND D.COMPANY_ID = A.COMPANY_ID
                  INNER JOIN SCMDATA.T_COMMODITY_INFO E ON E.GOO_ID=A.GOO_ID AND E.COMPANY_ID=A.COMPANY_ID
                 --WHERE B.AMOUNT > 0
 GROUP BY A.COMPANY_ID,
          EXTRACT(YEAR FROM A.CREATE_TIME),
          E.CATEGORY,
          D.GROUP_NAME,
          E.STYLE_NAME) Y      ]';

    V_SQL2 := q'[MERGE INTO SCMDATA.T_RTKPI_YEAR A
USING (SELECT Y.COMPANY_ID, Y.YEAR,  Y.CATEGORY,
              Y.GROUP_NAME, Y.COUNT_DIMENSION, Y.DIMENSION_SORT,
              /*Z.ORDER_MONEY INGOOD_MONEY,*/ Y.RMMONEY SHOP_RT_ORIGINAL_MONEY, X.RMMONEY2 SHOP_RT_MONEY

         FROM
         (SELECT A.COMPANY_ID, A.YEAR,
                          B.CATEGORY,
                          (CASE
                            WHEN A.SUP_GROUP_NAME2 IS NULL THEN
                             '1'
                            ELSE
                             A.SUP_GROUP_NAME2
                          END) GROUP_NAME, '02' COUNT_DIMENSION,
                         B.STYLE_NAME DIMENSION_SORT,
                          SUM(CASE           WHEN REGEXP_COUNT(A.SUP_GROUP_NAME, ',') > 0 THEN
                                 A.EXAMOUNT /
                                 (REGEXP_COUNT(A.SUP_GROUP_NAME, ',') + 1) *
                                 B.PRICE
                                ELSE
                                 A.EXAMOUNT * B.PRICE
                              END) RMMONEY
                     FROM (SELECT Z.RM_ID, Z.COMPANY_ID, Z.YEAR, Z.QUARTER,
                                   Z.ACCESS_TIME, Z.GOO_ID, Z.EXAMOUNT,
                                   Z.SUP_GROUP_NAME, Z.AUDIT_TIME,
                                   REGEXP_SUBSTR(Z.SUP_GROUP_NAME,
                                                  '[^,]+',
                                                  1,
                                                  LEVEL) SUP_GROUP_NAME2
                              FROM   SCMDATA.T_RETURN_MANAGEMENT z
   CONNECT BY PRIOR RM_ID = RM_ID
          AND LEVEL <= LENGTH(z.SUP_GROUP_NAME) -
              LENGTH(REGEXP_REPLACE(z.SUP_GROUP_NAME, ',', '')) + 1
          AND PRIOR DBMS_RANDOM.VALUE IS NOT NULL) A
        INNER JOIN scmdata.T_COMMODITY_INFO B
             ON A.GOO_ID = B.GOO_ID
            AND A.COMPANY_ID = B.COMPANY_ID
       WHERE A.AUDIT_TIME IS NOT NULL
       GROUP BY A.COMPANY_ID,
                A.YEAR,
                B.CATEGORY,
                 A.SUP_GROUP_NAME2,
                B.STYLE_NAME) Y

         LEFT JOIN (SELECT A.COMPANY_ID, A.YEAR,
                          B.CATEGORY,
                          (CASE  WHEN A.SUP_GROUP_NAME2 IS NULL THEN '1'    ELSE   A.SUP_GROUP_NAME2 END) GROUP_NAME,
                           '02' COUNT_DIMENSION,
                         B.STYLE_NAME DIMENSION_SORT,
                          SUM(CASE
                                WHEN REGEXP_COUNT(A.SUP_GROUP_NAME, ',') > 0 THEN
                                 A.EXAMOUNT /
                                 (REGEXP_COUNT(A.SUP_GROUP_NAME, ',') + 1) *
                                 B.PRICE
                                ELSE
                                 A.EXAMOUNT * B.PRICE
                              END) RMMONEY2
                     FROM (SELECT Z.RM_ID, Z.COMPANY_ID, Z.YEAR, Z.QUARTER,
                                   Z.ACCESS_TIME, Z.GOO_ID, Z.EXAMOUNT,
                                   Z.SUP_GROUP_NAME, Z.AUDIT_TIME,
                                   Z.CAUSE_DETAIL_ID, Z.FIRST_DEPT_ID,
                                   Z.SECOND_DEPT_ID,
                                   REGEXP_SUBSTR(Z.SUP_GROUP_NAME,
                                                  '[^,]+',
                                                  1,
                                                  LEVEL) SUP_GROUP_NAME2
                              FROM SCMDATA.T_RETURN_MANAGEMENT Z
        CONNECT BY PRIOR RM_ID = RM_ID
               AND LEVEL <=
                   LENGTH(Z.SUP_GROUP_NAME) -
                   LENGTH(REGEXP_REPLACE(Z.SUP_GROUP_NAME, ',', '')) + 1
               AND PRIOR DBMS_RANDOM.VALUE IS NOT NULL) A
 INNER JOIN SCMDATA.T_COMMODITY_INFO B
    ON A.GOO_ID = B.GOO_ID
   AND A.COMPANY_ID = B.COMPANY_ID
  LEFT JOIN SCMDATA.T_ABNORMAL_DTL_CONFIG C
    ON A.CAUSE_DETAIL_ID = C.ABNORMAL_DTL_CONFIG_ID
   AND A.COMPANY_ID = C.COMPANY_ID
   AND C.ANOMALY_CLASSIFICATION = 'AC_QUALITY'
 INNER JOIN SCMDATA.SYS_COMPANY_DEPT D
    ON D.COMPANY_DEPT_ID = A.FIRST_DEPT_ID
 WHERE A.AUDIT_TIME IS NOT NULL
   AND C.CAUSE_CLASSIFICATION <> '银饰氧化问题'
   AND C.PROBLEM_CLASSIFICATION <> '非质量问题'
   AND D.DEPT_NAME = '供应链管理部'
 GROUP BY A.COMPANY_ID,
          A.YEAR,
          B.CATEGORY,
          A.SUP_GROUP_NAME2,
          B.STYLE_NAME) X
           ON X.COMPANY_ID = Y.COMPANY_ID
          AND X.YEAR = Y.YEAR
          AND X.CATEGORY = Y.CATEGORY
          AND X.GROUP_NAME = Y.GROUP_NAME
          AND X.COUNT_DIMENSION = Y.COUNT_DIMENSION
          AND X.DIMENSION_SORT = Y.DIMENSION_SORT
         /* LEFT JOIN ( SELECT A.COMPANY_ID,
       EXTRACT(YEAR FROM A.CREATE_TIME) YEAR,
       D.CATEGORY,
       (CASE WHEN D.GROUP_NAME IS NULL THEN  '1'  ELSE D.GROUP_NAME END) GROUP_NAME,
       '02' COUNT_DIMENSION,
       D.STYLE_NAME DIMENSION_SORT,
       SUM(B.AMOUNT * E.PRICE) ORDER_MONEY
  FROM SCMDATA.T_INGOOD A
 INNER JOIN SCMDATA.T_INGOODS B
    ON A.ING_ID = B.ING_ID
   AND A.COMPANY_ID = B.COMPANY_ID
 INNER JOIN SCMDATA.T_ORDERED C
    ON C.ORDER_CODE = A.DOCUMENT_NO
   AND A.COMPANY_ID = C.COMPANY_ID
 INNER JOIN SCMDATA.PT_ORDERED D
    ON D.ORDER_ID = C.ORDER_ID
   AND D.COMPANY_ID = C.COMPANY_ID
  INNER JOIN SCMDATA.T_COMMODITY_INFO E ON E.GOO_ID=B.GOO_ID AND E.COMPANY_ID=B.COMPANY_ID
 WHERE B.AMOUNT > 0
 GROUP BY A.COMPANY_ID,
          EXTRACT(YEAR FROM A.CREATE_TIME),
          D.CATEGORY,
          D.GROUP_NAME,
          D.STYLE_NAME) z ON Z.COMPANY_ID = Y.COMPANY_ID
          AND Z.YEAR = Y.YEAR
          AND Z.CATEGORY = Y.CATEGORY
          AND Z.GROUP_NAME = Y.GROUP_NAME
          AND Z.COUNT_DIMENSION = Y.COUNT_DIMENSION
          AND Z.DIMENSION_SORT = Y.DIMENSION_SORT */]';
    IF P_TYPE = 0 THEN
      --进货
      V_EXSQL1 := V_SQL1||V_WH_SQL2||V_U_SQL1||V_I_SQL1;
      --退货
      V_EXSQL2 := V_SQL2 || V_WH_SQL2 || V_U_SQL2 || V_I_SQL2;


    ELSIF P_TYPE = 1 THEN
      --进货
      V_EXSQL1 := V_SQL1||V_WM_SQL1||V_U_SQL1||V_I_SQL1;
      --退货
      V_EXSQL2 := V_SQL2 || V_WM_SQL1 || V_U_SQL2 || V_I_SQL2;
    END IF;
    EXECUTE IMMEDIATE V_EXSQL2;
     EXECUTE IMMEDIATE V_EXSQL1;
    --dbms_output.put_line(V_EXSQL1);
    --dbms_output.put_line(V_EXSQL2);

    --产品子类
     V_SQL1 := q'[MERGE INTO SCMDATA.T_RTKPI_YEAR A
USING (SELECT Y.COMPANY_ID, Y.YEAR,  Y.CATEGORY,
              Y.GROUP_NAME, Y.COUNT_DIMENSION, Y.DIMENSION_SORT,
              Y.ORDER_MONEY INGOOD_MONEY
        FROM (  SELECT A.COMPANY_ID,
       EXTRACT(YEAR FROM A.CREATE_TIME) YEAR,
       E.CATEGORY,
       (CASE WHEN D.GROUP_NAME IS NULL THEN  '1'  ELSE D.GROUP_NAME END) GROUP_NAME,
       '03' COUNT_DIMENSION,
       E.SAMLL_CATEGORY DIMENSION_SORT,
       SUM(A.AMOUNT * E.PRICE) ORDER_MONEY
  FROM (SELECT T.DOCUMENT_NO,
                    T.COMPANY_ID,
                    TRUNC(T.CREATE_TIME) CREATE_TIME,
                    SUM(TL.AMOUNT) AMOUNT,
                    TL.GOO_ID
               FROM SCMDATA.T_INGOOD T
              INNER JOIN (SELECT TI.ING_ID,
                                TI.COMPANY_ID,
                                TI.GOO_ID,
                                TI.AMOUNT
                           FROM SCMDATA.T_INGOODS TI
                          WHERE TI.AMOUNT > 0) TL
                 ON TL.ING_ID = T.ING_ID
                AND TL.COMPANY_ID = T.COMPANY_ID
              WHERE TO_CHAR(T.CREATE_TIME, 'yyyy') >= 2022
              GROUP BY T.DOCUMENT_NO,
                       T.COMPANY_ID,
                       TRUNC(T.CREATE_TIME),
                       TL.GOO_ID) A
                  /*SCMDATA.T_INGOOD A
                 INNER JOIN SCMDATA.T_INGOODS B
                    ON A.ING_ID = B.ING_ID
                   AND A.COMPANY_ID = B.COMPANY_ID
                 LEFT JOIN SCMDATA.T_ORDERED C
                    ON C.ORDER_CODE = A.DOCUMENT_NO
                   AND A.COMPANY_ID = C.COMPANY_ID*/
                 LEFT JOIN SCMDATA.PT_ORDERED D
                    ON D.PRODUCT_GRESS_CODE = A.DOCUMENT_NO
                   AND D.COMPANY_ID = A.COMPANY_ID
                  INNER JOIN SCMDATA.T_COMMODITY_INFO E ON E.GOO_ID=A.GOO_ID AND E.COMPANY_ID=A.COMPANY_ID
                 --WHERE B.AMOUNT > 0
 GROUP BY A.COMPANY_ID,
          EXTRACT(YEAR FROM A.CREATE_TIME),
          E.CATEGORY,
          D.GROUP_NAME,
          E.SAMLL_CATEGORY) Y
    ]';

    V_SQL2 := q'[MERGE INTO SCMDATA.T_RTKPI_YEAR A
USING (SELECT Y.COMPANY_ID, Y.YEAR,  Y.CATEGORY,
              Y.GROUP_NAME, Y.COUNT_DIMENSION, Y.DIMENSION_SORT,
              /*Z.ORDER_MONEY INGOOD_MONEY,*/ Y.RMMONEY SHOP_RT_ORIGINAL_MONEY, X.RMMONEY2 SHOP_RT_MONEY

         FROM
         (SELECT A.COMPANY_ID, A.YEAR,
                          B.CATEGORY,
                          (CASE
                            WHEN A.SUP_GROUP_NAME2 IS NULL THEN
                             '1'
                            ELSE
                             A.SUP_GROUP_NAME2
                          END) GROUP_NAME, '03' COUNT_DIMENSION,
                         B.SAMLL_CATEGORY DIMENSION_SORT,
                          SUM(CASE           WHEN REGEXP_COUNT(A.SUP_GROUP_NAME, ',') > 0 THEN
                                 A.EXAMOUNT /
                                 (REGEXP_COUNT(A.SUP_GROUP_NAME, ',') + 1) *
                                 B.PRICE
                                ELSE
                                 A.EXAMOUNT * B.PRICE
                              END) RMMONEY
                     FROM (SELECT Z.RM_ID, Z.COMPANY_ID, Z.YEAR, Z.QUARTER,
                                   Z.ACCESS_TIME, Z.GOO_ID, Z.EXAMOUNT,
                                   Z.SUP_GROUP_NAME, Z.AUDIT_TIME,
                                   REGEXP_SUBSTR(Z.SUP_GROUP_NAME,
                                                  '[^,]+',
                                                  1,
                                                  LEVEL) SUP_GROUP_NAME2
                              FROM  SCMDATA.T_RETURN_MANAGEMENT z
   CONNECT BY PRIOR RM_ID = RM_ID
          AND LEVEL <= LENGTH(z.SUP_GROUP_NAME) -
              LENGTH(REGEXP_REPLACE(z.SUP_GROUP_NAME, ',', '')) + 1
          AND PRIOR DBMS_RANDOM.VALUE IS NOT NULL) A
        INNER JOIN scmdata.T_COMMODITY_INFO B
             ON A.GOO_ID = B.GOO_ID
            AND A.COMPANY_ID = B.COMPANY_ID
       WHERE A.AUDIT_TIME IS NOT NULL
       GROUP BY A.COMPANY_ID,
                A.YEAR,
                B.CATEGORY,
                 A.SUP_GROUP_NAME2,
                B.SAMLL_CATEGORY) Y

         LEFT JOIN (SELECT A.COMPANY_ID, A.YEAR,
                          B.CATEGORY,
                          (CASE  WHEN A.SUP_GROUP_NAME2 IS NULL THEN '1'    ELSE   A.SUP_GROUP_NAME2 END) GROUP_NAME,
                           '03' COUNT_DIMENSION,
                         B.SAMLL_CATEGORY DIMENSION_SORT,
                          SUM(CASE
                                WHEN REGEXP_COUNT(A.SUP_GROUP_NAME, ',') > 0 THEN
                                 A.EXAMOUNT /
                                 (REGEXP_COUNT(A.SUP_GROUP_NAME, ',') + 1) *
                                 B.PRICE
                                ELSE
                                 A.EXAMOUNT * B.PRICE
                              END) RMMONEY2
                     FROM (SELECT Z.RM_ID, Z.COMPANY_ID, Z.YEAR, Z.QUARTER,
                                   Z.ACCESS_TIME, Z.GOO_ID, Z.EXAMOUNT,
                                   Z.SUP_GROUP_NAME, Z.AUDIT_TIME,
                                   Z.CAUSE_DETAIL_ID, Z.FIRST_DEPT_ID,
                                   Z.SECOND_DEPT_ID,
                                   REGEXP_SUBSTR(Z.SUP_GROUP_NAME,
                                                  '[^,]+',
                                                  1,
                                                  LEVEL) SUP_GROUP_NAME2
                              FROM SCMDATA.T_RETURN_MANAGEMENT Z
        CONNECT BY PRIOR RM_ID = RM_ID
               AND LEVEL <=
                   LENGTH(Z.SUP_GROUP_NAME) -
                   LENGTH(REGEXP_REPLACE(Z.SUP_GROUP_NAME, ',', '')) + 1
               AND PRIOR DBMS_RANDOM.VALUE IS NOT NULL) A
 INNER JOIN SCMDATA.T_COMMODITY_INFO B
    ON A.GOO_ID = B.GOO_ID
   AND A.COMPANY_ID = B.COMPANY_ID
  LEFT JOIN SCMDATA.T_ABNORMAL_DTL_CONFIG C
    ON A.CAUSE_DETAIL_ID = C.ABNORMAL_DTL_CONFIG_ID
   AND A.COMPANY_ID = C.COMPANY_ID
   AND C.ANOMALY_CLASSIFICATION = 'AC_QUALITY'
 INNER JOIN SCMDATA.SYS_COMPANY_DEPT D
    ON D.COMPANY_DEPT_ID = A.FIRST_DEPT_ID
 WHERE A.AUDIT_TIME IS NOT NULL
   AND C.CAUSE_CLASSIFICATION <> '银饰氧化问题'
   AND C.PROBLEM_CLASSIFICATION <> '非质量问题'
   AND D.DEPT_NAME = '供应链管理部'
 GROUP BY A.COMPANY_ID,
          A.YEAR,
          B.CATEGORY,
          A.SUP_GROUP_NAME2,
          B.SAMLL_CATEGORY) X
           ON X.COMPANY_ID = Y.COMPANY_ID
          AND X.YEAR = Y.YEAR
          AND X.CATEGORY = Y.CATEGORY
          AND X.GROUP_NAME = Y.GROUP_NAME
          AND X.COUNT_DIMENSION = Y.COUNT_DIMENSION
          AND X.DIMENSION_SORT = Y.DIMENSION_SORT
         /* LEFT JOIN
          (  SELECT A.COMPANY_ID,
       EXTRACT(YEAR FROM A.CREATE_TIME) YEAR,
       D.CATEGORY,
       (CASE WHEN D.GROUP_NAME IS NULL THEN  '1'  ELSE D.GROUP_NAME END) GROUP_NAME,
       '03' COUNT_DIMENSION,
       D.SAMLL_CATEGORY DIMENSION_SORT,
       SUM(B.AMOUNT * E.PRICE) ORDER_MONEY
  FROM SCMDATA.T_INGOOD A
 INNER JOIN SCMDATA.T_INGOODS B
    ON A.ING_ID = B.ING_ID
   AND A.COMPANY_ID = B.COMPANY_ID
 INNER JOIN SCMDATA.T_ORDERED C
    ON C.ORDER_CODE = A.DOCUMENT_NO
   AND A.COMPANY_ID = C.COMPANY_ID
 INNER JOIN SCMDATA.PT_ORDERED D
    ON D.ORDER_ID = C.ORDER_ID
   AND D.COMPANY_ID = C.COMPANY_ID
  INNER JOIN SCMDATA.T_COMMODITY_INFO E ON E.GOO_ID=B.GOO_ID AND E.COMPANY_ID=B.COMPANY_ID
 WHERE B.AMOUNT > 0
 GROUP BY A.COMPANY_ID,
          EXTRACT(YEAR FROM A.CREATE_TIME),
          D.CATEGORY,
          D.GROUP_NAME,
          D.SAMLL_CATEGORY) z ON Z.COMPANY_ID = Y.COMPANY_ID
          AND Z.YEAR = Y.YEAR
          AND Z.CATEGORY = Y.CATEGORY
          AND Z.GROUP_NAME = Y.GROUP_NAME
          AND Z.COUNT_DIMENSION = Y.COUNT_DIMENSION
          AND Z.DIMENSION_SORT = Y.DIMENSION_SORT*/]';
  IF P_TYPE = 0 THEN
      --进货
      V_EXSQL1 := V_SQL1||V_WH_SQL2||V_U_SQL1||V_I_SQL1;
      --退货
      V_EXSQL2 := V_SQL2 || V_WH_SQL2 || V_U_SQL2 || V_I_SQL2;


    ELSIF P_TYPE = 1 THEN
      --进货
      V_EXSQL1 := V_SQL1||V_WM_SQL1||V_U_SQL1||V_I_SQL1;
      --退货
      V_EXSQL2 := V_SQL2 || V_WM_SQL1 || V_U_SQL2 || V_I_SQL2;
    END IF;
    EXECUTE IMMEDIATE V_EXSQL2;
     EXECUTE IMMEDIATE V_EXSQL1;
    --dbms_output.put_line(V_EXSQL1);
    --dbms_output.put_line(V_EXSQL2);

    --  供应商
    V_SQL1:=q'[MERGE INTO SCMDATA.T_RTKPI_YEAR A
USING (SELECT Y.COMPANY_ID, Y.YEAR,  Y.CATEGORY,
              Y.GROUP_NAME, Y.COUNT_DIMENSION, Y.DIMENSION_SORT,
              Y.ORDER_MONEY INGOOD_MONEY
       FROM (  SELECT A.COMPANY_ID,
       EXTRACT(YEAR FROM A.CREATE_TIME) YEAR,
       E.CATEGORY,
       (CASE WHEN D.GROUP_NAME IS NULL THEN  '1'  ELSE D.GROUP_NAME END) GROUP_NAME,
       '04' COUNT_DIMENSION,
       A.SUPPLIER_CODE DIMENSION_SORT,
       SUM(A.AMOUNT * E.PRICE) ORDER_MONEY
  FROM (SELECT T.DOCUMENT_NO,
                    T.COMPANY_ID,
                    TRUNC(T.CREATE_TIME) CREATE_TIME,
                    SUM(TL.AMOUNT) AMOUNT,
                    T.SUPPLIER_CODE,
                    TL.GOO_ID
               FROM SCMDATA.T_INGOOD T
              INNER JOIN (SELECT TI.ING_ID,
                                TI.COMPANY_ID,
                                TI.GOO_ID,
                                TI.AMOUNT
                           FROM SCMDATA.T_INGOODS TI
                          WHERE TI.AMOUNT > 0) TL
                 ON TL.ING_ID = T.ING_ID
                AND TL.COMPANY_ID = T.COMPANY_ID
              WHERE TO_CHAR(T.CREATE_TIME, 'yyyy') >= 2022
              GROUP BY T.DOCUMENT_NO,
                       T.COMPANY_ID,
                       TRUNC(T.CREATE_TIME),
                       T.SUPPLIER_CODE,
                       TL.GOO_ID) A
                  /*SCMDATA.T_INGOOD A
                 INNER JOIN SCMDATA.T_INGOODS B
                    ON A.ING_ID = B.ING_ID
                   AND A.COMPANY_ID = B.COMPANY_ID
                 LEFT JOIN SCMDATA.T_ORDERED C
                    ON C.ORDER_CODE = A.DOCUMENT_NO
                   AND A.COMPANY_ID = C.COMPANY_ID*/
                 LEFT JOIN SCMDATA.PT_ORDERED D
                    ON D.PRODUCT_GRESS_CODE = A.DOCUMENT_NO
                   AND D.COMPANY_ID = A.COMPANY_ID
                  INNER JOIN SCMDATA.T_COMMODITY_INFO E ON E.GOO_ID=A.GOO_ID AND E.COMPANY_ID=A.COMPANY_ID
                 --WHERE B.AMOUNT > 0
 GROUP BY A.COMPANY_ID,
          EXTRACT(YEAR FROM A.CREATE_TIME),
          E.CATEGORY,
          D.GROUP_NAME,
          A.SUPPLIER_CODE) Y       ]';

    V_SQL2 := q'[ MERGE INTO SCMDATA.T_RTKPI_YEAR A
USING (SELECT Y.COMPANY_ID, Y.YEAR,  Y.CATEGORY,
              Y.GROUP_NAME, Y.COUNT_DIMENSION, Y.DIMENSION_SORT,
             /* Z.ORDER_MONEY INGOOD_MONEY,*/ Y.RMMONEY SHOP_RT_ORIGINAL_MONEY, X.RMMONEY2 SHOP_RT_MONEY

         FROM
         (SELECT A.COMPANY_ID, A.YEAR,
                          B.CATEGORY,
                          (CASE
                            WHEN A.SUP_GROUP_NAME2 IS NULL THEN
                             '1'
                            ELSE
                             A.SUP_GROUP_NAME2
                          END) GROUP_NAME, '04' COUNT_DIMENSION,
                         A.SUPPLIER_CODE DIMENSION_SORT,
                          SUM(CASE           WHEN REGEXP_COUNT(A.SUP_GROUP_NAME, ',') > 0 THEN
                                 A.EXAMOUNT /
                                 (REGEXP_COUNT(A.SUP_GROUP_NAME, ',') + 1) *
                                 B.PRICE
                                ELSE
                                 A.EXAMOUNT * B.PRICE
                              END) RMMONEY
                     FROM (SELECT Z.RM_ID, Z.COMPANY_ID, Z.YEAR, Z.QUARTER,
                                   Z.ACCESS_TIME, Z.GOO_ID, Z.EXAMOUNT,
                                   Z.SUP_GROUP_NAME, Z.AUDIT_TIME,
                                   Z.SUPPLIER_CODE,
                                   REGEXP_SUBSTR(Z.SUP_GROUP_NAME,
                                                  '[^,]+',
                                                  1,
                                                  LEVEL) SUP_GROUP_NAME2
                              FROM SCMDATA.T_RETURN_MANAGEMENT z
   CONNECT BY PRIOR RM_ID = RM_ID
          AND LEVEL <= LENGTH(z.SUP_GROUP_NAME) -
              LENGTH(REGEXP_REPLACE(z.SUP_GROUP_NAME, ',', '')) + 1
          AND PRIOR DBMS_RANDOM.VALUE IS NOT NULL) A
        INNER JOIN scmdata.T_COMMODITY_INFO B
             ON A.GOO_ID = B.GOO_ID
            AND A.COMPANY_ID = B.COMPANY_ID
       WHERE A.AUDIT_TIME IS NOT NULL
       GROUP BY A.COMPANY_ID,
                A.YEAR,
                B.CATEGORY,
                 A.SUP_GROUP_NAME2,
                A.SUPPLIER_CODE) Y

         LEFT JOIN (SELECT A.COMPANY_ID, A.YEAR,
                          B.CATEGORY,
                          (CASE  WHEN A.SUP_GROUP_NAME2 IS NULL THEN '1'    ELSE   A.SUP_GROUP_NAME2 END) GROUP_NAME,
                           '04' COUNT_DIMENSION,
                         A.SUPPLIER_CODE DIMENSION_SORT,
                          SUM(CASE
                                WHEN REGEXP_COUNT(A.SUP_GROUP_NAME, ',') > 0 THEN
                                 A.EXAMOUNT /
                                 (REGEXP_COUNT(A.SUP_GROUP_NAME, ',') + 1) *
                                 B.PRICE
                                ELSE
                                 A.EXAMOUNT * B.PRICE
                              END) RMMONEY2
                     FROM (SELECT Z.RM_ID, Z.COMPANY_ID, Z.YEAR, Z.QUARTER,
                                   Z.ACCESS_TIME, Z.GOO_ID, Z.EXAMOUNT,
                                   Z.SUP_GROUP_NAME, Z.AUDIT_TIME,
                                   Z.CAUSE_DETAIL_ID, Z.FIRST_DEPT_ID,
                                   Z.SECOND_DEPT_ID,
                                   Z.SUPPLIER_CODE,
                                   REGEXP_SUBSTR(Z.SUP_GROUP_NAME,
                                                  '[^,]+',
                                                  1,
                                                  LEVEL) SUP_GROUP_NAME2
                              FROM SCMDATA.T_RETURN_MANAGEMENT Z
        CONNECT BY PRIOR RM_ID = RM_ID
               AND LEVEL <=
                   LENGTH(Z.SUP_GROUP_NAME) -
                   LENGTH(REGEXP_REPLACE(Z.SUP_GROUP_NAME, ',', '')) + 1
               AND PRIOR DBMS_RANDOM.VALUE IS NOT NULL) A
 INNER JOIN SCMDATA.T_COMMODITY_INFO B
    ON A.GOO_ID = B.GOO_ID
   AND A.COMPANY_ID = B.COMPANY_ID
  LEFT JOIN SCMDATA.T_ABNORMAL_DTL_CONFIG C
    ON A.CAUSE_DETAIL_ID = C.ABNORMAL_DTL_CONFIG_ID
   AND A.COMPANY_ID = C.COMPANY_ID
   AND C.ANOMALY_CLASSIFICATION = 'AC_QUALITY'
 INNER JOIN SCMDATA.SYS_COMPANY_DEPT D
    ON D.COMPANY_DEPT_ID = A.FIRST_DEPT_ID
 WHERE A.AUDIT_TIME IS NOT NULL
   AND C.CAUSE_CLASSIFICATION <> '银饰氧化问题'
   AND C.PROBLEM_CLASSIFICATION <> '非质量问题'
   AND D.DEPT_NAME = '供应链管理部'
 GROUP BY A.COMPANY_ID,
          A.YEAR,
          B.CATEGORY,
          A.SUP_GROUP_NAME2,
          A.SUPPLIER_CODE) X
           ON X.COMPANY_ID = Y.COMPANY_ID
          AND X.YEAR = Y.YEAR
          AND X.CATEGORY = Y.CATEGORY
          AND X.GROUP_NAME = Y.GROUP_NAME
          AND X.COUNT_DIMENSION = Y.COUNT_DIMENSION
          AND X.DIMENSION_SORT = Y.DIMENSION_SORT
         /* LEFT JOIN
          --进货数据
          (  SELECT A.COMPANY_ID,
       EXTRACT(YEAR FROM A.CREATE_TIME) YEAR,
       D.CATEGORY,
       (CASE WHEN D.GROUP_NAME IS NULL THEN  '1'  ELSE D.GROUP_NAME END) GROUP_NAME,
       '04' COUNT_DIMENSION,
       C.SUPPLIER_CODE DIMENSION_SORT,
       SUM(B.AMOUNT * E.PRICE) ORDER_MONEY
  FROM SCMDATA.T_INGOOD A
 INNER JOIN SCMDATA.T_INGOODS B
    ON A.ING_ID = B.ING_ID
   AND A.COMPANY_ID = B.COMPANY_ID
 INNER JOIN SCMDATA.T_ORDERED C
    ON C.ORDER_CODE = A.DOCUMENT_NO
   AND A.COMPANY_ID = C.COMPANY_ID
 INNER JOIN SCMDATA.PT_ORDERED D
    ON D.ORDER_ID = C.ORDER_ID
   AND D.COMPANY_ID = C.COMPANY_ID
  INNER JOIN SCMDATA.T_COMMODITY_INFO E ON E.GOO_ID=B.GOO_ID AND E.COMPANY_ID=B.COMPANY_ID
 WHERE B.AMOUNT > 0
 GROUP BY A.COMPANY_ID,
          EXTRACT(YEAR FROM A.CREATE_TIME),
          D.CATEGORY,
          D.GROUP_NAME,
          C.SUPPLIER_CODE) z ON Z.COMPANY_ID = Y.COMPANY_ID
          AND Z.YEAR = Y.YEAR
          AND Z.CATEGORY = Y.CATEGORY
          AND Z.GROUP_NAME = Y.GROUP_NAME
          AND Z.COUNT_DIMENSION = Y.COUNT_DIMENSION
          AND Z.DIMENSION_SORT = Y.DIMENSION_SORT*/ ]';

    IF P_TYPE = 0 THEN
      --进货
      V_EXSQL1 := V_SQL1||V_WH_SQL2||V_U_SQL1||V_I_SQL1;
      --退货
      V_EXSQL2 := V_SQL2 || V_WH_SQL2 || V_U_SQL2 || V_I_SQL2;


    ELSIF P_TYPE = 1 THEN
      --进货
      V_EXSQL1 := V_SQL1||V_WM_SQL1||V_U_SQL1||V_I_SQL1;
      --退货
      V_EXSQL2 := V_SQL2 || V_WM_SQL1 || V_U_SQL2 || V_I_SQL2;
    END IF;
    EXECUTE IMMEDIATE V_EXSQL2;
     EXECUTE IMMEDIATE V_EXSQL1;
    --dbms_output.put_line(V_EXSQL1);
    --dbms_output.put_line(V_EXSQL2);

    --跟单
    V_SQL1:=q'[MERGE INTO SCMDATA.T_RTKPI_YEAR A
USING (SELECT Y.COMPANY_ID, Y.YEAR,  Y.CATEGORY,
              Y.GROUP_NAME, Y.COUNT_DIMENSION,
              Y.DIMENSION_SORT,
              Y.ORDER_MONEY INGOOD_MONEY
     FROM (SELECT A.COMPANY_ID, EXTRACT(YEAR FROM A.CREATE_TIME) YEAR,
                    E.CATEGORY,
                    (CASE WHEN D.GROUP_NAME IS NULL THEN '1' ELSE D.GROUP_NAME END) GROUP_NAME, 
                    '05' COUNT_DIMENSION,
                    (CASE WHEN D.GENDAN IS NULL OR D.GENDAN='ORDERED_ITF' THEN '1' ELSE D.GENDAN END) DIMENSION_SORT,
                    SUM(CASE
                          WHEN REGEXP_COUNT(D.FLW_ORDER, ',') > 0 THEN
                           A.AMOUNT / NVL((REGEXP_COUNT(D.FLW_ORDER, ',') + 1),1) *
                           E.PRICE
                          ELSE
                           A.AMOUNT * E.PRICE
                        END) ORDER_MONEY
               FROM (SELECT T.DOCUMENT_NO,
                    T.COMPANY_ID,
                    TRUNC(T.CREATE_TIME) CREATE_TIME,
                    SUM(TL.AMOUNT) AMOUNT,
                    TL.GOO_ID
               FROM SCMDATA.T_INGOOD T
              INNER JOIN (SELECT TI.ING_ID,
                                TI.COMPANY_ID,
                                TI.GOO_ID,
                                TI.AMOUNT
                           FROM SCMDATA.T_INGOODS TI
                          WHERE TI.AMOUNT > 0) TL
                 ON TL.ING_ID = T.ING_ID
                AND TL.COMPANY_ID = T.COMPANY_ID
              WHERE TO_CHAR(T.CREATE_TIME, 'yyyy') >= 2022
              GROUP BY T.DOCUMENT_NO,
                       T.COMPANY_ID,
                       TRUNC(T.CREATE_TIME),
                       TL.GOO_ID) A
                  /*SCMDATA.T_INGOOD A
                 INNER JOIN SCMDATA.T_INGOODS B
                    ON A.ING_ID = B.ING_ID
                   AND A.COMPANY_ID = B.COMPANY_ID
                 LEFT JOIN SCMDATA.T_ORDERED C
                    ON C.ORDER_CODE = A.DOCUMENT_NO
                   AND A.COMPANY_ID = C.COMPANY_ID*/                  
              LEFT JOIN (SELECT Z.*,
                                REGEXP_SUBSTR(Z.FLW_ORDER, '[^,]+', 1, LEVEL) GENDAN
                           FROM SCMDATA.PT_ORDERED Z
                         CONNECT BY PRIOR Z.PT_ORDERED_ID = Z.PT_ORDERED_ID
                                AND LEVEL <=
                                    LENGTH(Z.FLW_ORDER) -
                                    LENGTH(REGEXP_REPLACE(Z.FLW_ORDER,
                                                          ',',
                                                          '')) + 1
                                AND PRIOR DBMS_RANDOM.VALUE IS NOT NULL) D
                   ON D.PRODUCT_GRESS_CODE = A.DOCUMENT_NO
                   AND D.COMPANY_ID = A.COMPANY_ID
                  INNER JOIN SCMDATA.T_COMMODITY_INFO E ON E.GOO_ID=A.GOO_ID AND E.COMPANY_ID=A.COMPANY_ID
                 --WHERE B.AMOUNT > 0
              GROUP BY A.COMPANY_ID, EXTRACT(YEAR FROM A.CREATE_TIME), E.CATEGORY,
                       (CASE WHEN D.GROUP_NAME IS NULL THEN '1' ELSE D.GROUP_NAME END),
                       (CASE WHEN D.GENDAN IS NULL OR D.GENDAN='ORDERED_ITF' THEN '1' ELSE D.GENDAN END)) Y         ]';


    V_SQL2 := q'[  MERGE INTO SCMDATA.T_RTKPI_YEAR A
USING (
WITH TEMP_RT AS
 (SELECT Z.*,
         Z.RM_ID || ROW_NUMBER() OVER(PARTITION BY Z.RM_ID ORDER BY 1) RM_ID2,
         Z.EXAMOUNT / (COUNT(Z.RM_ID) OVER(PARTITION BY(Z.RM_ID))) EXGAMOUNT2,
         REGEXP_SUBSTR(Z.SUP_GROUP_NAME, '[^,]+', 1, LEVEL) SUP_GROUP_NAME2
    FROM SCMDATA.T_RETURN_MANAGEMENT Z
   WHERE Z.AUDIT_TIME IS NOT NULL
  CONNECT BY PRIOR RM_ID = RM_ID
         AND LEVEL <= LENGTH(Z.SUP_GROUP_NAME) -
             LENGTH(REGEXP_REPLACE(Z.SUP_GROUP_NAME, ',', '')) + 1
         AND PRIOR DBMS_RANDOM.VALUE IS NOT NULL)

SELECT Y.COMPANY_ID, Y.YEAR,   Y.CATEGORY, Y.GROUP_NAME,
       Y.COUNT_DIMENSION, Y.DIMENSION_SORT, /*Z.ORDER_MONEY INGOOD_MONEY,*/
       Y.RMMONEY SHOP_RT_ORIGINAL_MONEY, X.RMMONEY2 SHOP_RT_MONEY

  FROM (SELECT A.COMPANY_ID, A.YEAR,  B.CATEGORY,
                (CASE
                  WHEN A.SUP_GROUP_NAME2 IS NULL THEN
                   '1'
                  ELSE
                   A.SUP_GROUP_NAME2
                END) GROUP_NAME, '05' COUNT_DIMENSION,
                (CASE
                  WHEN A.GENDAN2 IS NULL THEN
                   '1'
                  ELSE
                   A.GENDAN2
                END) DIMENSION_SORT, SUM(A.EXGAMOUNT3 * B.PRICE) RMMONEY
           FROM (SELECT Z.RM_ID, Z.COMPANY_ID, Z.YEAR, Z.QUARTER, Z.ACCESS_TIME,
                         Z.GOO_ID, Z.EXAMOUNT, Z.SUP_GROUP_NAME, Z.AUDIT_TIME,
                         Z.SUP_GROUP_NAME2,
                         Z.EXGAMOUNT2 / NVL((REGEXP_COUNT(Z.MERCHER_ID, ',') + 1),1) EXGAMOUNT3,
                         REGEXP_SUBSTR(Z.MERCHER_ID, '[^,]+', 1, LEVEL) GENDAN2
                    FROM TEMP_RT Z

                  CONNECT BY PRIOR Z.RM_ID2 = Z.RM_ID2
                         AND LEVEL <=
                             LENGTH(Z.MERCHER_ID) -
                             LENGTH(REGEXP_REPLACE(Z.MERCHER_ID, ',', '')) + 1
                         AND PRIOR DBMS_RANDOM.VALUE IS NOT NULL) A
          INNER JOIN SCMDATA.T_COMMODITY_INFO B
             ON A.GOO_ID = B.GOO_ID
            AND A.COMPANY_ID = B.COMPANY_ID
          WHERE A.AUDIT_TIME IS NOT NULL
          GROUP BY A.COMPANY_ID, A.YEAR,  B.CATEGORY,
                   A.SUP_GROUP_NAME2, A.GENDAN2) Y

  LEFT JOIN (SELECT A.COMPANY_ID, A.YEAR,
                    B.CATEGORY,
                    (CASE
                      WHEN A.SUP_GROUP_NAME2 IS NULL THEN
                       '1'
                      ELSE
                       A.SUP_GROUP_NAME2
                    END) GROUP_NAME, '05' COUNT_DIMENSION,
                    (CASE
                      WHEN A.GENDAN2 IS NULL THEN
                       '1'
                      ELSE
                       A.GENDAN2
                    END) DIMENSION_SORT, SUM(A.EXGAMOUNT3 * B.PRICE) RMMONEY2
               FROM (SELECT Z.RM_ID, Z.COMPANY_ID, Z.YEAR, Z.QUARTER,
                             Z.ACCESS_TIME, Z.GOO_ID, Z.EXAMOUNT,
                             Z.SUP_GROUP_NAME, Z.AUDIT_TIME, Z.CAUSE_DETAIL_ID,
                             Z.FIRST_DEPT_ID, Z.SUP_GROUP_NAME2,
                             Z.SECOND_DEPT_ID,
                             Z.EXGAMOUNT2 /
                              NVL((REGEXP_COUNT(Z.MERCHER_ID, ',') + 1),1) EXGAMOUNT3,
                             REGEXP_SUBSTR(Z.MERCHER_ID, '[^,]+', 1, LEVEL) GENDAN2
                        FROM TEMP_RT Z

                      CONNECT BY PRIOR Z.RM_ID2 = Z.RM_ID2
                             AND LEVEL <=
                                 LENGTH(Z.MERCHER_ID) -
                                 LENGTH(REGEXP_REPLACE(Z.MERCHER_ID, ',', '')) + 1
                             AND PRIOR DBMS_RANDOM.VALUE IS NOT NULL) A
              INNER JOIN SCMDATA.T_COMMODITY_INFO B
                 ON A.GOO_ID = B.GOO_ID
                AND A.COMPANY_ID = B.COMPANY_ID
               LEFT JOIN SCMDATA.T_ABNORMAL_DTL_CONFIG C
                 ON A.CAUSE_DETAIL_ID = C.ABNORMAL_DTL_CONFIG_ID
                AND A.COMPANY_ID = C.COMPANY_ID
                AND C.ANOMALY_CLASSIFICATION = 'AC_QUALITY'
              INNER JOIN SCMDATA.SYS_COMPANY_DEPT D
                 ON D.COMPANY_DEPT_ID = A.FIRST_DEPT_ID
              WHERE A.AUDIT_TIME IS NOT NULL
                AND C.CAUSE_CLASSIFICATION <> '银饰氧化问题'
                AND C.PROBLEM_CLASSIFICATION <> '非质量问题'
                AND D.DEPT_NAME = '供应链管理部'
                AND INSTR(A.SECOND_DEPT_ID,
                          'b550778b4f2d36b4e0533c281caca074') > 0
              GROUP BY A.COMPANY_ID, A.YEAR, B.CATEGORY,
                       A.SUP_GROUP_NAME2, A.GENDAN2) X
    ON X.COMPANY_ID = Y.COMPANY_ID
   AND X.YEAR = Y.YEAR
   AND X.CATEGORY = Y.CATEGORY
   AND X.GROUP_NAME = Y.GROUP_NAME
   AND X.COUNT_DIMENSION = Y.COUNT_DIMENSION
   AND X.DIMENSION_SORT = Y.DIMENSION_SORT
  /*LEFT JOIN (SELECT A.COMPANY_ID, EXTRACT(YEAR FROM A.CREATE_TIME) YEAR,
                    D.CATEGORY,
                    (CASE
                      WHEN D.GROUP_NAME IS NULL THEN
                       '1'
                      ELSE
                       D.GROUP_NAME
                    END) GROUP_NAME, '05' COUNT_DIMENSION,
                    (CASE
                      WHEN D.GENDAN IS NULL THEN
                       '1'
                      ELSE
                       D.GENDAN
                    END) DIMENSION_SORT,
                    SUM(CASE
                          WHEN REGEXP_COUNT(D.FLW_ORDER, ',') > 0 THEN
                           B.AMOUNT / NVL((REGEXP_COUNT(D.FLW_ORDER, ',') + 1),1) *
                           E.PRICE
                          ELSE
                           B.AMOUNT * E.PRICE
                        END) ORDER_MONEY
               FROM SCMDATA.T_INGOOD A
              INNER JOIN SCMDATA.T_INGOODS B
                 ON A.ING_ID = B.ING_ID
                AND A.COMPANY_ID = B.COMPANY_ID
              INNER JOIN SCMDATA.T_ORDERED C
                 ON C.ORDER_CODE = A.DOCUMENT_NO
                AND A.COMPANY_ID = C.COMPANY_ID
              INNER JOIN (SELECT Z.*,
                                REGEXP_SUBSTR(Z.FLW_ORDER, '[^,]+', 1, LEVEL) GENDAN
                           FROM SCMDATA.PT_ORDERED Z
                         CONNECT BY PRIOR Z.PT_ORDERED_ID = Z.PT_ORDERED_ID
                                AND LEVEL <=
                                    LENGTH(Z.FLW_ORDER) -
                                    LENGTH(REGEXP_REPLACE(Z.FLW_ORDER,
                                                          ',',
                                                          '')) + 1
                                AND PRIOR DBMS_RANDOM.VALUE IS NOT NULL) D
                 ON D.ORDER_ID = C.ORDER_ID
                AND D.COMPANY_ID = C.COMPANY_ID
               INNER JOIN SCMDATA.T_COMMODITY_INFO E ON E.GOO_ID=B.GOO_ID AND E.COMPANY_ID=B.COMPANY_ID
              WHERE B.AMOUNT > 0
              GROUP BY A.COMPANY_ID, EXTRACT(YEAR FROM A.CREATE_TIME), D.CATEGORY,
                       D.GROUP_NAME, D.GENDAN) Z
    ON Z.COMPANY_ID = Y.COMPANY_ID
   AND Z.YEAR = Y.YEAR
   AND Z.CATEGORY = Y.CATEGORY
   AND Z.GROUP_NAME = Y.GROUP_NAME
   AND Z.COUNT_DIMENSION = Y.COUNT_DIMENSION
   AND Z.DIMENSION_SORT = Y.DIMENSION_SORT */]';
     IF P_TYPE = 0 THEN
      --进货
      V_EXSQL1 := V_SQL1||V_WH_SQL2||V_U_SQL1||V_I_SQL1;
      --退货
      V_EXSQL2 := V_SQL2 || V_WH_SQL2 || V_U_SQL2 || V_I_SQL2;


    ELSIF P_TYPE = 1 THEN
      --进货
      V_EXSQL1 := V_SQL1||V_WM_SQL1||V_U_SQL1||V_I_SQL1;
      --退货
      V_EXSQL2 := V_SQL2 || V_WM_SQL1 || V_U_SQL2 || V_I_SQL2;
    END IF;
    EXECUTE IMMEDIATE V_EXSQL2;
     EXECUTE IMMEDIATE V_EXSQL1;
    --dbms_output.put_line(V_EXSQL1);
    --dbms_output.put_line(V_EXSQL2);

    -- 06跟单主管
    V_SQL1:=q'[MERGE INTO SCMDATA.T_RTKPI_YEAR A
USING ( SELECT Y.COMPANY_ID, Y.YEAR,  Y.CATEGORY,
         Y.GROUP_NAME, Y.COUNT_DIMENSION, Y.DIMENSION_SORT,
         Y.ORDER_MONEY INGOOD_MONEY
     FROM (SELECT A.COMPANY_ID, EXTRACT(YEAR FROM A.CREATE_TIME) YEAR,
                      E.CATEGORY,
                      (CASE WHEN D.GROUP_NAME IS NULL THEN '1' ELSE D.GROUP_NAME END) GROUP_NAME,
                       '06' COUNT_DIMENSION,
                      (CASE WHEN D.GENDANZG IS NULL THEN '1' ELSE D.GENDANZG END) DIMENSION_SORT,
                      SUM(CASE
                            WHEN REGEXP_COUNT(D.FLW_ORDER_MANAGER, ',') > 0 THEN
                             A.AMOUNT /
                             NVL((REGEXP_COUNT(D.FLW_ORDER_MANAGER, ',') + 1),1) *
                             E.PRICE
                            ELSE
                             A.AMOUNT * E.PRICE
                          END) ORDER_MONEY
                 FROM (SELECT T.DOCUMENT_NO,
                    T.COMPANY_ID,
                    TRUNC(T.CREATE_TIME) CREATE_TIME,
                    SUM(TL.AMOUNT) AMOUNT,
                    TL.GOO_ID
               FROM SCMDATA.T_INGOOD T
              INNER JOIN (SELECT TI.ING_ID,
                                TI.COMPANY_ID,
                                TI.GOO_ID,
                                TI.AMOUNT
                           FROM SCMDATA.T_INGOODS TI
                          WHERE TI.AMOUNT > 0) TL
                 ON TL.ING_ID = T.ING_ID
                AND TL.COMPANY_ID = T.COMPANY_ID
              WHERE TO_CHAR(T.CREATE_TIME, 'yyyy') >= 2022
              GROUP BY T.DOCUMENT_NO,
                       T.COMPANY_ID,
                       TRUNC(T.CREATE_TIME),
                       TL.GOO_ID) A
                  /*SCMDATA.T_INGOOD A
                 INNER JOIN SCMDATA.T_INGOODS B
                    ON A.ING_ID = B.ING_ID
                   AND A.COMPANY_ID = B.COMPANY_ID
                 LEFT JOIN SCMDATA.T_ORDERED C
                    ON C.ORDER_CODE = A.DOCUMENT_NO
                   AND A.COMPANY_ID = C.COMPANY_ID*/  
                LEFT JOIN (SELECT Z.*,
                                  REGEXP_SUBSTR(Z.FLW_ORDER_MANAGER,
                                                 '[^,]+',
                                                 1,
                                                 LEVEL) GENDANZG
                             FROM SCMDATA.PT_ORDERED Z
                           CONNECT BY PRIOR Z.PT_ORDERED_ID = Z.PT_ORDERED_ID
                                  AND LEVEL <=
                                      LENGTH(Z.FLW_ORDER_MANAGER) -
                                      LENGTH(REGEXP_REPLACE(Z.FLW_ORDER_MANAGER,
                                                            ',',
                                                            '')) + 1
                                  AND PRIOR DBMS_RANDOM.VALUE IS NOT NULL) D
                   ON D.PRODUCT_GRESS_CODE = A.DOCUMENT_NO
                  AND D.COMPANY_ID = A.COMPANY_ID
                 INNER JOIN SCMDATA.T_COMMODITY_INFO E ON E.GOO_ID=A.GOO_ID AND E.COMPANY_ID=A.COMPANY_ID
                --WHERE B.AMOUNT > 0
                GROUP BY A.COMPANY_ID, EXTRACT(YEAR FROM A.CREATE_TIME), E.CATEGORY,
                         D.GROUP_NAME, D.GENDANZG) Y    ]';

    V_SQL2 := q'[MERGE INTO SCMDATA.T_RTKPI_YEAR A
USING (
  WITH TEMP_RT AS
   (SELECT Z.*,
           Z.RM_ID || ROW_NUMBER() OVER(PARTITION BY Z.RM_ID ORDER BY 1) RM_ID2,
           Z.EXAMOUNT / (COUNT(Z.RM_ID) OVER(PARTITION BY(Z.RM_ID))) EXGAMOUNT2,
           REGEXP_SUBSTR(Z.SUP_GROUP_NAME, '[^,]+', 1, LEVEL) SUP_GROUP_NAME2
      FROM SCMDATA.T_RETURN_MANAGEMENT Z
     WHERE Z.AUDIT_TIME IS NOT NULL
    CONNECT BY PRIOR RM_ID = RM_ID
           AND LEVEL <=
               LENGTH(Z.SUP_GROUP_NAME) -
               LENGTH(REGEXP_REPLACE(Z.SUP_GROUP_NAME, ',', '')) + 1
           AND PRIOR DBMS_RANDOM.VALUE IS NOT NULL)
  SELECT Y.COMPANY_ID, Y.YEAR,  Y.CATEGORY,
         Y.GROUP_NAME, Y.COUNT_DIMENSION, Y.DIMENSION_SORT,
         /*Z.ORDER_MONEY INGOOD_MONEY,*/ Y.RMMONEY SHOP_RT_ORIGINAL_MONEY,
         X.RMMONEY2 SHOP_RT_MONEY

    FROM (SELECT A.COMPANY_ID, A.YEAR,  B.CATEGORY,
                  (CASE WHEN A.SUP_GROUP_NAME2 IS NULL THEN  '1'  ELSE  A.SUP_GROUP_NAME2  END) GROUP_NAME,
                   '06' COUNT_DIMENSION,
                  (CASE WHEN A.GENDANZG2 IS NULL THEN '1' ELSE A.GENDANZG2 END) DIMENSION_SORT,
                  SUM(A.EXGAMOUNT3 * B.PRICE) RMMONEY
             FROM (SELECT Z.RM_ID, Z.COMPANY_ID, Z.YEAR, Z.QUARTER, Z.ACCESS_TIME,
                           Z.GOO_ID, Z.EXAMOUNT, Z.SUP_GROUP_NAME, Z.AUDIT_TIME,Z.SUP_GROUP_NAME2,
                           Z.EXGAMOUNT2 /
                            NVL((REGEXP_COUNT(Z.MERCHER_DIRECTOR_ID, ',') + 1),1) EXGAMOUNT3,
                           REGEXP_SUBSTR(Z.MERCHER_DIRECTOR_ID,
                                          '[^,]+',
                                          1,
                                          LEVEL) GENDANZG2
                      FROM TEMP_RT Z

                    CONNECT BY PRIOR Z.RM_ID2 = Z.RM_ID2
                           AND LEVEL <= LENGTH(Z.MERCHER_DIRECTOR_ID) -
                               LENGTH(REGEXP_REPLACE(Z.MERCHER_DIRECTOR_ID, ',','')) + 1
                           AND PRIOR DBMS_RANDOM.VALUE IS NOT NULL) A
            INNER JOIN SCMDATA.T_COMMODITY_INFO B
               ON A.GOO_ID = B.GOO_ID
              AND A.COMPANY_ID = B.COMPANY_ID
            WHERE A.AUDIT_TIME IS NOT NULL
            GROUP BY A.COMPANY_ID, A.YEAR,  B.CATEGORY,
                     A.SUP_GROUP_NAME2, A.GENDANZG2) Y

    LEFT JOIN (SELECT A.COMPANY_ID, A.YEAR,
                      B.CATEGORY,
                      (CASE WHEN A.SUP_GROUP_NAME2 IS NULL THEN '1'ELSE A.SUP_GROUP_NAME2 END) GROUP_NAME,
                       '06' COUNT_DIMENSION,
                      (CASE WHEN A.GENDANZG2 IS NULL THEN '1' ELSE A.GENDANZG2 END) DIMENSION_SORT,
                      SUM(A.EXGAMOUNT3 * B.PRICE) RMMONEY2
                 FROM (SELECT Z.RM_ID, Z.COMPANY_ID, Z.YEAR, Z.QUARTER,
                               Z.ACCESS_TIME, Z.GOO_ID, Z.EXAMOUNT,
                               Z.SUP_GROUP_NAME, Z.AUDIT_TIME,
                               Z.CAUSE_DETAIL_ID, Z.FIRST_DEPT_ID,Z.SUP_GROUP_NAME2,
                               Z.SECOND_DEPT_ID,
                               Z.EXGAMOUNT2 /
                                NVL((REGEXP_COUNT(Z.MERCHER_DIRECTOR_ID, ',') + 1),1) EXGAMOUNT3,
                               REGEXP_SUBSTR(Z.MERCHER_DIRECTOR_ID, '[^,]+', 1, LEVEL) GENDANZG2
                          FROM TEMP_RT Z

                        CONNECT BY PRIOR Z.RM_ID2 = Z.RM_ID2
                               AND LEVEL <=
                                   LENGTH(Z.MERCHER_DIRECTOR_ID) -
                                   LENGTH(REGEXP_REPLACE(Z.MERCHER_DIRECTOR_ID, ',', '')) + 1
                               AND PRIOR DBMS_RANDOM.VALUE IS NOT NULL) A
                INNER JOIN SCMDATA.T_COMMODITY_INFO B
                   ON A.GOO_ID = B.GOO_ID
                  AND A.COMPANY_ID = B.COMPANY_ID
                 LEFT JOIN SCMDATA.T_ABNORMAL_DTL_CONFIG C
                   ON A.CAUSE_DETAIL_ID = C.ABNORMAL_DTL_CONFIG_ID
                  AND A.COMPANY_ID = C.COMPANY_ID
                  AND C.ANOMALY_CLASSIFICATION = 'AC_QUALITY'
                INNER JOIN SCMDATA.SYS_COMPANY_DEPT D
                   ON D.COMPANY_DEPT_ID = A.FIRST_DEPT_ID
                WHERE A.AUDIT_TIME IS NOT NULL
                  AND C.CAUSE_CLASSIFICATION <> '银饰氧化问题'
                  AND C.PROBLEM_CLASSIFICATION <> '非质量问题'
                  AND D.DEPT_NAME = '供应链管理部'
                  AND INSTR(A.SECOND_DEPT_ID,
                            'b550778b4f2d36b4e0533c281caca074') > 0
                GROUP BY A.COMPANY_ID, A.YEAR, B.CATEGORY,
                         A.SUP_GROUP_NAME2, A.GENDANZG2) X
      ON X.COMPANY_ID = Y.COMPANY_ID
     AND X.YEAR = Y.YEAR
     AND X.CATEGORY = Y.CATEGORY
     AND X.GROUP_NAME = Y.GROUP_NAME
     AND X.COUNT_DIMENSION = Y.COUNT_DIMENSION
     AND X.DIMENSION_SORT = Y.DIMENSION_SORT
    /*LEFT JOIN (SELECT A.COMPANY_ID, EXTRACT(YEAR FROM A.CREATE_TIME) YEAR,
                      D.CATEGORY,
                      (CASE WHEN D.GROUP_NAME IS NULL THEN '1' ELSE D.GROUP_NAME END) GROUP_NAME,
                       '06' COUNT_DIMENSION,
                      (CASE WHEN D.GENDANZG IS NULL THEN '1' ELSE D.GENDANZG END) DIMENSION_SORT,
                      SUM(CASE
                            WHEN REGEXP_COUNT(D.FLW_ORDER_MANAGER, ',') > 0 THEN
                             B.AMOUNT /
                             NVL((REGEXP_COUNT(D.FLW_ORDER_MANAGER, ',') + 1),1) *
                             E.PRICE
                            ELSE
                             B.AMOUNT * E.PRICE
                          END) ORDER_MONEY
                 FROM SCMDATA.T_INGOOD A
                INNER JOIN SCMDATA.T_INGOODS B
                   ON A.ING_ID = B.ING_ID
                  AND A.COMPANY_ID = B.COMPANY_ID
                INNER JOIN SCMDATA.T_ORDERED C
                   ON C.ORDER_CODE = A.DOCUMENT_NO
                  AND A.COMPANY_ID = C.COMPANY_ID
                INNER JOIN (SELECT Z.*,
                                  REGEXP_SUBSTR(Z.FLW_ORDER_MANAGER,
                                                 '[^,]+',
                                                 1,
                                                 LEVEL) GENDANZG
                             FROM SCMDATA.PT_ORDERED Z
                           CONNECT BY PRIOR Z.PT_ORDERED_ID = Z.PT_ORDERED_ID
                                  AND LEVEL <=
                                      LENGTH(Z.FLW_ORDER_MANAGER) -
                                      LENGTH(REGEXP_REPLACE(Z.FLW_ORDER_MANAGER,
                                                            ',',
                                                            '')) + 1
                                  AND PRIOR DBMS_RANDOM.VALUE IS NOT NULL) D
                   ON D.ORDER_ID = C.ORDER_ID
                  AND D.COMPANY_ID = C.COMPANY_ID
                 INNER JOIN SCMDATA.T_COMMODITY_INFO E ON E.GOO_ID=B.GOO_ID AND E.COMPANY_ID=B.COMPANY_ID
                WHERE B.AMOUNT > 0
                GROUP BY A.COMPANY_ID, EXTRACT(YEAR FROM A.CREATE_TIME), D.CATEGORY,
                         D.GROUP_NAME, D.GENDANZG) Z
      ON Z.COMPANY_ID = Y.COMPANY_ID
     AND Z.YEAR = Y.YEAR
     AND Z.CATEGORY = Y.CATEGORY
     AND Z.GROUP_NAME = Y.GROUP_NAME
     AND Z.COUNT_DIMENSION = Y.COUNT_DIMENSION
     AND Z.DIMENSION_SORT = Y.DIMENSION_SORT */ ]';
      IF P_TYPE = 0 THEN
      --进货
      V_EXSQL1 := V_SQL1||V_WH_SQL2||V_U_SQL1||V_I_SQL1;
      --退货
      V_EXSQL2 := V_SQL2 || V_WH_SQL2 || V_U_SQL2 || V_I_SQL2;


    ELSIF P_TYPE = 1 THEN
      --进货
      V_EXSQL1 := V_SQL1||V_WM_SQL1||V_U_SQL1||V_I_SQL1;
      --退货
      V_EXSQL2 := V_SQL2 || V_WM_SQL1 || V_U_SQL2 || V_I_SQL2;
    END IF;
    EXECUTE IMMEDIATE V_EXSQL2;
     EXECUTE IMMEDIATE V_EXSQL1;
    --dbms_output.put_line(V_EXSQL1);
    --dbms_output.put_line(V_EXSQL2);

    --07qc
    V_SQL1:=q'[ MERGE INTO SCMDATA.T_RTKPI_YEAR A
USING (
  WITH TEMP_PTORDER AS
 (SELECT T1.PT_ORDERED_ID, T1.GOO_ID_PR,
         T1.PT_ORDERED_ID || ROW_NUMBER() OVER(PARTITION BY T1.PT_ORDERED_ID ORDER BY 1) ID2,
         T1.COMPANY_ID, T1.PRODUCT_GRESS_CODE, T1.ORDER_MONEY,
         (T1.ORDER_MONEY / COUNT(T1.PRODUCT_GRESS_CODE)
           OVER(PARTITION BY T1.PRODUCT_GRESS_CODE)) SUM1,
         REGEXP_SUBSTR(T1.QC, '[^,]+', 1, LEVEL) QC2
    FROM SCMDATA.PT_ORDERED T1
   WHERE T1.QC IS NOT NULL
  CONNECT BY PRIOR T1.PT_ORDERED_ID = T1.PT_ORDERED_ID
         AND LEVEL <=
             LENGTH(T1.QC) - LENGTH(REGEXP_REPLACE(T1.QC, ',', '')) + 1
         AND PRIOR DBMS_RANDOM.VALUE IS NOT NULL)
SELECT Y.COMPANY_ID, Y.YEAR,  Y.CATEGORY, Y.GROUP_NAME,
       Y.COUNT_DIMENSION, Y.DIMENSION_SORT DIMENSION_SORT, Y.ORDER_MONEY INGOOD_MONEY
  FROM (SELECT A.COMPANY_ID, EXTRACT(YEAR FROM A.CREATE_TIME) YEAR,
                    E.CATEGORY,
                    (CASE  WHEN D.GROUP_NAME IS NULL THEN '1'  ELSE  D.GROUP_NAME  END) GROUP_NAME,
                     '07' COUNT_DIMENSION,
                    (CASE WHEN D.QC2 IS NULL THEN '1' ELSE  D.QC2  END) DIMENSION_SORT,
                    SUM(CASE
                          WHEN REGEXP_COUNT(D.QC, ',') > 0 THEN
                           A.AMOUNT / NVL((REGEXP_COUNT(D.QC, ',') + 1),1) *
                           E.PRICE
                          ELSE
                           A.AMOUNT * E.PRICE
                        END) ORDER_MONEY
               FROM (SELECT T.DOCUMENT_NO,
                    T.COMPANY_ID,
                    TRUNC(T.CREATE_TIME) CREATE_TIME,
                    SUM(TL.AMOUNT) AMOUNT,
                    TL.GOO_ID
               FROM SCMDATA.T_INGOOD T
              INNER JOIN (SELECT TI.ING_ID,
                                TI.COMPANY_ID,
                                TI.GOO_ID,
                                TI.AMOUNT
                           FROM SCMDATA.T_INGOODS TI
                          WHERE TI.AMOUNT > 0) TL
                 ON TL.ING_ID = T.ING_ID
                AND TL.COMPANY_ID = T.COMPANY_ID
              WHERE TO_CHAR(T.CREATE_TIME, 'yyyy') >= 2022
              GROUP BY T.DOCUMENT_NO,
                       T.COMPANY_ID,
                       TRUNC(T.CREATE_TIME),
                       TL.GOO_ID) A
                  /*SCMDATA.T_INGOOD A
                 INNER JOIN SCMDATA.T_INGOODS B
                    ON A.ING_ID = B.ING_ID
                   AND A.COMPANY_ID = B.COMPANY_ID
                 LEFT JOIN SCMDATA.T_ORDERED C
                    ON C.ORDER_CODE = A.DOCUMENT_NO
                   AND A.COMPANY_ID = C.COMPANY_ID*/  
              LEFT JOIN (SELECT Z.*,
                                REGEXP_SUBSTR(Z.QC, '[^,]+', 1, LEVEL) QC2
                           FROM SCMDATA.PT_ORDERED Z
                         CONNECT BY PRIOR Z.PT_ORDERED_ID = Z.PT_ORDERED_ID
                                AND LEVEL <=
                                    LENGTH(Z.QC) -
                                    LENGTH(REGEXP_REPLACE(Z.QC, ',', '')) + 1
                                AND PRIOR DBMS_RANDOM.VALUE IS NOT NULL) D
                 ON D.PRODUCT_GRESS_CODE = A.DOCUMENT_NO
                AND D.COMPANY_ID = A.COMPANY_ID
               INNER JOIN SCMDATA.T_COMMODITY_INFO E ON E.GOO_ID=A.GOO_ID AND E.COMPANY_ID=A.COMPANY_ID
              --WHERE B.AMOUNT > 0
              GROUP BY A.COMPANY_ID, EXTRACT(YEAR FROM A.CREATE_TIME), E.CATEGORY,
                       D.GROUP_NAME, D.QC2) Y      ]';

    V_SQL2 := q'[  MERGE INTO SCMDATA.T_RTKPI_YEAR A
USING (
  WITH TEMP_RT AS
 (SELECT Z.RM_ID, Z.COMPANY_ID, Z.YEAR, Z.QUARTER, Z.ACCESS_TIME,Z.SUPPLIER_CODE,
         Z.GOO_ID, Z.EXAMOUNT, Z.QC_ID,
         Z.RM_ID || ROW_NUMBER() OVER(PARTITION BY Z.RM_ID ORDER BY 1) RM_ID2,
         Z.EXAMOUNT / (COUNT(Z.RM_ID) OVER(PARTITION BY(Z.RM_ID))) EXGAMOUNT2,
         REGEXP_SUBSTR(Z.SUP_GROUP_NAME, '[^,]+', 1, LEVEL) SUP_GROUP_NAME2
    FROM SCMDATA.T_RETURN_MANAGEMENT Z
   WHERE Z.AUDIT_TIME IS NOT NULL
  CONNECT BY PRIOR RM_ID = RM_ID
         AND LEVEL <= LENGTH(Z.SUP_GROUP_NAME) -
             LENGTH(REGEXP_REPLACE(Z.SUP_GROUP_NAME, ',', '')) + 1
         AND PRIOR DBMS_RANDOM.VALUE IS NOT NULL),
TEMP_RT2 AS
 (SELECT Z.RM_ID, Z.COMPANY_ID, Z.YEAR, Z.QUARTER, Z.ACCESS_TIME,Z.SUPPLIER_CODE,
         Z.GOO_ID, Z.EXAMOUNT, Z.QC_ID,
         Z.RM_ID || ROW_NUMBER() OVER(PARTITION BY Z.RM_ID ORDER BY 1) RM_ID2,
         Z.EXAMOUNT / (COUNT(Z.RM_ID) OVER(PARTITION BY(Z.RM_ID))) EXGAMOUNT2,
         REGEXP_SUBSTR(Z.SUP_GROUP_NAME, '[^,]+', 1, LEVEL) SUP_GROUP_NAME2
    FROM SCMDATA.T_RETURN_MANAGEMENT Z
    LEFT JOIN SCMDATA.T_ABNORMAL_DTL_CONFIG C
      ON Z.CAUSE_DETAIL_ID = C.ABNORMAL_DTL_CONFIG_ID
     AND Z.COMPANY_ID = C.COMPANY_ID
     AND C.ANOMALY_CLASSIFICATION = 'AC_QUALITY'
   INNER JOIN SCMDATA.SYS_COMPANY_DEPT D
      ON D.COMPANY_DEPT_ID = Z.FIRST_DEPT_ID
   WHERE Z.AUDIT_TIME IS NOT NULL
     AND C.CAUSE_CLASSIFICATION <> '银饰氧化问题'
     AND C.PROBLEM_CLASSIFICATION <> '非质量问题'
     AND D.DEPT_NAME = '供应链管理部'
     AND INSTR(Z.SECOND_DEPT_ID, 'b550778b4f2d36b4e0533c281caca074') > 0
  CONNECT BY PRIOR RM_ID = RM_ID
         AND LEVEL <= LENGTH(Z.SUP_GROUP_NAME) -
             LENGTH(REGEXP_REPLACE(Z.SUP_GROUP_NAME, ',', '')) + 1
         AND PRIOR DBMS_RANDOM.VALUE IS NOT NULL),
TEMP_PTORDER AS
 (SELECT T1.PT_ORDERED_ID, T1.GOO_ID_PR,T1.ORDER_ID, T1.DELIVERY_AMOUNT,
         T1.PT_ORDERED_ID || ROW_NUMBER() OVER(PARTITION BY T1.PT_ORDERED_ID ORDER BY 1) ID2,
         T1.COMPANY_ID, T1.PRODUCT_GRESS_CODE, T1.ORDER_MONEY,
         (T1.ORDER_MONEY / COUNT(T1.PRODUCT_GRESS_CODE)
           OVER(PARTITION BY T1.PRODUCT_GRESS_CODE)) SUM1,
         REGEXP_SUBSTR(T1.QC, '[^,]+', 1, LEVEL) QC2
    FROM SCMDATA.PT_ORDERED T1
   WHERE T1.QC IS NOT NULL
  CONNECT BY PRIOR T1.PT_ORDERED_ID = T1.PT_ORDERED_ID
         AND LEVEL <=
             LENGTH(T1.QC) - LENGTH(REGEXP_REPLACE(T1.QC, ',', '')) + 1
         AND PRIOR DBMS_RANDOM.VALUE IS NOT NULL)
SELECT Y.COMPANY_ID, Y.YEAR,  Y.CATEGORY, Y.GROUP_NAME,
       '07' COUNT_DIMENSION, Y.DIMENSION_SORT DIMENSION_SORT, Y.RMMONEY SHOP_RT_ORIGINAL_MONEY,
       X.SHOP_RT_MONEY SHOP_RT_MONEY/*, Z.ORDER_MONEY INGOOD_MONEY*/
  FROM (SELECT A.COMPANY_ID, A.YEAR,  B.CATEGORY,
                (CASE
                  WHEN A.SUP_GROUP_NAME2 IS NULL THEN
                   '1'
                  ELSE
                   A.SUP_GROUP_NAME2
                END) GROUP_NAME, '07' COUNT_DIMENSION, (CASE WHEN A.QC2 IS NULL THEN '1' ELSE A.QC2 END) DIMENSION_SORT,
                SUM(A.EXGAMOUNT3 * B.PRICE) RMMONEY
           FROM (SELECT Z.COMPANY_ID, Z.YEAR, Z.QUARTER, Z.ACCESS_TIME, Z.GOO_ID,
                         Z.SUP_GROUP_NAME2,
                         Z.EXGAMOUNT2 / NVL((REGEXP_COUNT(Z.QC_ID, ',') + 1),1) EXGAMOUNT3,
                         REGEXP_SUBSTR(Z.QC_ID, '[^,]+', 1, LEVEL) QC2
                    FROM TEMP_RT Z
                   WHERE (EXISTS
                          (SELECT MAX(1)
                             FROM SCMDATA.T_PLAT_LOG X
                             INNER JOIN SCMDATA.T_PLAT_LOGS Y ON X.COMPANY_ID = Y.COMPANY_ID AND X.LOG_ID=Y.LOG_ID
                            WHERE X.APPLY_PK_ID = Z.RM_ID
                              AND Y.OPERATE_FIELD ='QC_ID'
                              AND X.ACTION_TYPE = 'UPDATE') OR
                          (NOT EXISTS
                           (SELECT MAX(1)
                              FROM SCMDATA.T_PLAT_LOG Y
                              INNER JOIN SCMDATA.T_PLAT_LOGS X ON X.COMPANY_ID = Y.COMPANY_ID AND X.LOG_ID=Y.LOG_ID
                             WHERE Y.APPLY_PK_ID = Z.RM_ID
                               AND X.OPERATE_FIELD ='QC_ID'
                               AND Y.ACTION_TYPE = 'UPDATE') AND NOT EXISTS
                           (SELECT MAX(1)
                              FROM TEMP_PTORDER J
                           INNER JOIN SCMDATA.T_ORDERED P
                              ON P.ORDER_ID = J.ORDER_ID
                             AND P.COMPANY_ID = J.COMPANY_ID
                           WHERE J.GOO_ID_PR = Z.GOO_ID
                               AND J.COMPANY_ID = Z.COMPANY_ID AND P.SUPPLIER_CODE = Z.SUPPLIER_CODE AND J.QC2 IS NOT NULL
                             AND J.DELIVERY_AMOUNT > 0)))
                  CONNECT BY PRIOR Z.RM_ID2 = Z.RM_ID2
                         AND LEVEL <=
                             LENGTH(Z.QC_ID) -
                             LENGTH(REGEXP_REPLACE(Z.QC_ID, ',', '')) + 1
                         AND PRIOR DBMS_RANDOM.VALUE IS NOT NULL
                  UNION ALL
                  SELECT H.COMPANY_ID, H.YEAR, H.QUARTER, H.ACCESS_TIME, H.GOO_ID,
                         H.SUP_GROUP_NAME2,
                         (H.EXGAMOUNT2 *((SELECT SUM(J.SUM1)
                               FROM TEMP_PTORDER J INNER JOIN SCMDATA.T_ORDERED P ON P.ORDER_ID = J.ORDER_ID AND P.COMPANY_ID = J.COMPANY_ID
                              WHERE J.GOO_ID_PR = H.GOO_ID
                                AND J.COMPANY_ID = H.COMPANY_ID AND P.SUPPLIER_CODE = H.SUPPLIER_CODE AND J.DELIVERY_AMOUNT > 0
                                AND J.QC2 = H.QC2) /
                          (SELECT SUM(J.ORDER_MONEY)
                               FROM TEMP_PTORDER J INNER JOIN SCMDATA.T_ORDERED P ON P.ORDER_ID = J.ORDER_ID AND P.COMPANY_ID = J.COMPANY_ID
                              WHERE J.GOO_ID_PR = H.GOO_ID
                                AND H.COMPANY_ID = J.COMPANY_ID
                                AND J.QC2 IS NOT NULL AND P.SUPPLIER_CODE = H.SUPPLIER_CODE AND J.DELIVERY_AMOUNT > 0))) EXGAMOUNT3, H.QC2
                    FROM (SELECT Z.*,
                                  REGEXP_SUBSTR(Z.QC_ID, '[^,]+', 1, LEVEL) QC2
                             FROM TEMP_RT Z
                            WHERE NOT EXISTS
                            (SELECT MAX(1)
                                     FROM SCMDATA.T_PLAT_LOG Y
                                     INNER JOIN SCMDATA.T_PLAT_LOGS X ON X.COMPANY_ID = Y.COMPANY_ID AND X.LOG_ID=Y.LOG_ID
                                    WHERE Y.APPLY_PK_ID = Z.RM_ID
                                      AND X.OPERATE_FIELD ='QC_ID'
                                      AND Y.ACTION_TYPE = 'UPDATE')
                              AND EXISTS
                            (SELECT MAX(1)
                                     FROM TEMP_PTORDER J INNER JOIN SCMDATA.T_ORDERED P ON P.ORDER_ID = J.ORDER_ID AND P.COMPANY_ID = J.COMPANY_ID
                              WHERE J.GOO_ID_PR = Z.GOO_ID
                                      AND J.COMPANY_ID = Z.COMPANY_ID AND J.QC2 IS NOT NULL AND P.SUPPLIER_CODE = Z.SUPPLIER_CODE AND J.DELIVERY_AMOUNT > 0 )
                           CONNECT BY PRIOR Z.RM_ID2 = Z.RM_ID2
                                  AND LEVEL <=
                                      LENGTH(Z.QC_ID) -
                                      LENGTH(REGEXP_REPLACE(Z.QC_ID, ',', '')) + 1
                                  AND PRIOR DBMS_RANDOM.VALUE IS NOT NULL) H) A
          INNER JOIN SCMDATA.T_COMMODITY_INFO B
             ON A.GOO_ID = B.GOO_ID
            AND A.COMPANY_ID = B.COMPANY_ID
          GROUP BY A.COMPANY_ID, A.YEAR, B.CATEGORY,
                   A.SUP_GROUP_NAME2, (CASE WHEN A.QC2 IS NULL THEN '1' ELSE A.QC2 END)) Y

  LEFT JOIN (SELECT A.COMPANY_ID, A.YEAR,
                    B.CATEGORY,
                    (CASE  WHEN A.SUP_GROUP_NAME2 IS NULL THEN '1'  ELSE A.SUP_GROUP_NAME2  END) GROUP_NAME,
                    '07' COUNT_DIMENSION,
                    (CASE WHEN A.QC2 IS NULL THEN '1' ELSE A.QC2 END) DIMENSION_SORT,
                    SUM(A.EXGAMOUNT3 * B.PRICE) SHOP_RT_MONEY
               FROM (SELECT Z.COMPANY_ID, Z.YEAR, Z.QUARTER, Z.ACCESS_TIME,
                             Z.GOO_ID, Z.SUP_GROUP_NAME2,
                             Z.EXGAMOUNT2 / NVL((REGEXP_COUNT(Z.QC_ID, ',') + 1),1) EXGAMOUNT3,
                             REGEXP_SUBSTR(Z.QC_ID, '[^,]+', 1, LEVEL) QC2
                        FROM TEMP_RT2 Z
                       WHERE (EXISTS
                              (SELECT MAX(1)
                                 FROM SCMDATA.T_PLAT_LOG X
                                 INNER JOIN SCMDATA.T_PLAT_LOGS Y ON X.COMPANY_ID = Y.COMPANY_ID AND X.LOG_ID=Y.LOG_ID
                                WHERE X.APPLY_PK_ID = Z.RM_ID
                                  AND Y.OPERATE_FIELD ='QC_ID'
                                  AND X.ACTION_TYPE = 'UPDATE') OR
                              (NOT EXISTS
                               (SELECT MAX(1)
                                  FROM SCMDATA.T_PLAT_LOG Y
                                  INNER JOIN SCMDATA.T_PLAT_LOGS X ON X.COMPANY_ID = Y.COMPANY_ID AND X.LOG_ID=Y.LOG_ID
                                 WHERE Y.APPLY_PK_ID = Z.RM_ID
                                   AND X.OPERATE_FIELD ='QC_ID'
                                   AND Y.ACTION_TYPE = 'UPDATE') AND NOT EXISTS
                               (SELECT MAX(1)
                                  FROM TEMP_PTORDER J INNER JOIN SCMDATA.T_ORDERED P ON P.ORDER_ID = J.ORDER_ID AND P.COMPANY_ID = J.COMPANY_ID
                              WHERE J.GOO_ID_PR = Z.GOO_ID
                                   AND J.COMPANY_ID = Z.COMPANY_ID AND J.QC2 IS NOT NULL AND P.SUPPLIER_CODE = Z.SUPPLIER_CODE AND J.DELIVERY_AMOUNT > 0 )))
                      CONNECT BY PRIOR Z.RM_ID2 = Z.RM_ID2
                             AND LEVEL <=
                                 LENGTH(Z.QC_ID) -
                                 LENGTH(REGEXP_REPLACE(Z.QC_ID, ',', '')) + 1
                             AND PRIOR DBMS_RANDOM.VALUE IS NOT NULL
                      UNION ALL
                      SELECT H.COMPANY_ID, H.YEAR, H.QUARTER, H.ACCESS_TIME,
                             H.GOO_ID, H.SUP_GROUP_NAME2,
                             (H.EXGAMOUNT2 * ((SELECT SUM(J.SUM1)
                                   FROM TEMP_PTORDER J INNER JOIN SCMDATA.T_ORDERED P ON P.ORDER_ID = J.ORDER_ID AND P.COMPANY_ID = J.COMPANY_ID
                                  WHERE J.GOO_ID_PR = H.GOO_ID
                                    AND J.COMPANY_ID = H.COMPANY_ID AND P.SUPPLIER_CODE = H.SUPPLIER_CODE AND J.DELIVERY_AMOUNT > 0
                                    AND J.QC2 = H.QC2) /
                              (SELECT SUM(J.ORDER_MONEY)
                                   FROM TEMP_PTORDER J INNER JOIN SCMDATA.T_ORDERED P ON P.ORDER_ID = J.ORDER_ID AND P.COMPANY_ID = J.COMPANY_ID
                                  WHERE J.GOO_ID_PR= H.GOO_ID
                                    AND J.COMPANY_ID = H.COMPANY_ID
                                    AND J.QC2 IS NOT NULL AND P.SUPPLIER_CODE = H.SUPPLIER_CODE AND J.DELIVERY_AMOUNT > 0))) EXGAMOUNT3, H.QC2
                        FROM (SELECT Z.*,
                                      REGEXP_SUBSTR(Z.QC_ID, '[^,]+', 1, LEVEL) QC2
                                 FROM TEMP_RT2 Z
                                WHERE NOT EXISTS
                                (SELECT MAX(1)
                                         FROM SCMDATA.T_PLAT_LOG Y
                                         INNER JOIN SCMDATA.T_PLAT_LOGS X ON X.COMPANY_ID = Y.COMPANY_ID AND X.LOG_ID=Y.LOG_ID
                                        WHERE Y.APPLY_PK_ID = Z.RM_ID
                                          AND X.OPERATE_FIELD ='QC_ID'
                                          AND Y.ACTION_TYPE = 'UPDATE')
                                  AND EXISTS
                                (SELECT MAX(1)
                                   FROM TEMP_PTORDER J INNER JOIN SCMDATA.T_ORDERED P ON P.ORDER_ID = J.ORDER_ID AND P.COMPANY_ID = J.COMPANY_ID
                                  WHERE J.GOO_ID_PR = Z.GOO_ID AND J.QC2 IS NOT NULL AND P.SUPPLIER_CODE = Z.SUPPLIER_CODE AND J.DELIVERY_AMOUNT > 0
                                          AND J.COMPANY_ID = Z.COMPANY_ID)
                               CONNECT BY PRIOR Z.RM_ID2 = Z.RM_ID2
                                      AND LEVEL <=
                                          LENGTH(Z.QC_ID) -
                                          LENGTH(REGEXP_REPLACE(Z.QC_ID, ',', '')) + 1
                                      AND PRIOR DBMS_RANDOM.VALUE IS NOT NULL) H) A
              INNER JOIN SCMDATA.T_COMMODITY_INFO B
                 ON A.GOO_ID = B.GOO_ID
                AND A.COMPANY_ID = B.COMPANY_ID
              GROUP BY A.COMPANY_ID, A.YEAR, B.CATEGORY,
                       A.SUP_GROUP_NAME2, (CASE WHEN A.QC2 IS NULL THEN '1' ELSE A.QC2 END)) X
    ON X.COMPANY_ID = Y.COMPANY_ID
   AND X.YEAR = Y.YEAR
   AND X.CATEGORY = Y.CATEGORY
   AND X.GROUP_NAME = Y.GROUP_NAME
   AND X.COUNT_DIMENSION = Y.COUNT_DIMENSION
   AND X.DIMENSION_SORT = Y.DIMENSION_SORT
  /*LEFT JOIN (SELECT A.COMPANY_ID, EXTRACT(YEAR FROM A.CREATE_TIME) YEAR,
                    D.CATEGORY,
                    (CASE  WHEN D.GROUP_NAME IS NULL THEN '1'  ELSE  D.GROUP_NAME  END) GROUP_NAME,
                     '07' COUNT_DIMENSION,
                    (CASE WHEN D.QC2 IS NULL THEN '1' ELSE  D.QC2  END) DIMENSION_SORT,
                    SUM(CASE
                          WHEN REGEXP_COUNT(D.QC, ',') > 0 THEN
                           B.AMOUNT / NVL((REGEXP_COUNT(D.QC, ',') + 1),1) *
                           E.PRICE
                          ELSE
                           B.AMOUNT * E.PRICE
                        END) ORDER_MONEY
               FROM SCMDATA.T_INGOOD A
              INNER JOIN SCMDATA.T_INGOODS B
                 ON A.ING_ID = B.ING_ID
                AND A.COMPANY_ID = B.COMPANY_ID
              INNER JOIN SCMDATA.T_ORDERED C
                 ON C.ORDER_CODE = A.DOCUMENT_NO
                AND A.COMPANY_ID = C.COMPANY_ID
              INNER JOIN (SELECT Z.*,
                                REGEXP_SUBSTR(Z.QC, '[^,]+', 1, LEVEL) QC2
                           FROM SCMDATA.PT_ORDERED Z
                         CONNECT BY PRIOR Z.PT_ORDERED_ID = Z.PT_ORDERED_ID
                                AND LEVEL <=
                                    LENGTH(Z.QC) -
                                    LENGTH(REGEXP_REPLACE(Z.QC, ',', '')) + 1
                                AND PRIOR DBMS_RANDOM.VALUE IS NOT NULL) D
                 ON D.ORDER_ID = C.ORDER_ID
                AND D.COMPANY_ID = C.COMPANY_ID
               INNER JOIN SCMDATA.T_COMMODITY_INFO E ON E.GOO_ID=B.GOO_ID AND E.COMPANY_ID=B.COMPANY_ID
              WHERE B.AMOUNT > 0
              GROUP BY A.COMPANY_ID, EXTRACT(YEAR FROM A.CREATE_TIME), D.CATEGORY,
                       D.GROUP_NAME, D.QC2) Z
    ON Z.COMPANY_ID = Y.COMPANY_ID
   AND Z.YEAR = Y.YEAR
   AND Z.CATEGORY = Y.CATEGORY
   AND Z.GROUP_NAME = Y.GROUP_NAME
   AND Z.COUNT_DIMENSION = Y.COUNT_DIMENSION
   AND Z.DIMENSION_SORT = Y.DIMENSION_SORT */
 ]';
     IF P_TYPE = 0 THEN
      --进货
      V_EXSQL1 := V_SQL1||V_WH_SQL2||V_U_SQL1||V_I_SQL1;
      --退货
      V_EXSQL2 := V_SQL2 || V_WH_SQL2 || V_U_SQL2 || V_I_SQL2;


    ELSIF P_TYPE = 1 THEN
      --进货
      V_EXSQL1 := V_SQL1||V_WM_SQL1||V_U_SQL1||V_I_SQL1;
      --退货
      V_EXSQL2 := V_SQL2 || V_WM_SQL1 || V_U_SQL2 || V_I_SQL2;
    END IF;
    EXECUTE IMMEDIATE V_EXSQL2;
     EXECUTE IMMEDIATE V_EXSQL1;
    --dbms_output.put_line(V_EXSQL1);
    --dbms_output.put_line(V_EXSQL2);

    --qc主管
    V_SQL1:=q'[MERGE INTO SCMDATA.T_RTKPI_YEAR A
USING (
   WITH TEMP_PTORDER AS
 (SELECT T1.PT_ORDERED_ID, T1.GOO_ID_PR,
         T1.PT_ORDERED_ID || ROW_NUMBER() OVER(PARTITION BY T1.PT_ORDERED_ID ORDER BY 1) ID2,
         T1.COMPANY_ID, T1.PRODUCT_GRESS_CODE, T1.ORDER_MONEY,
         (T1.ORDER_MONEY / COUNT(T1.PRODUCT_GRESS_CODE)
           OVER(PARTITION BY T1.PRODUCT_GRESS_CODE)) SUM1,
         REGEXP_SUBSTR(T1.QC_MANAGER, '[^,]+', 1, LEVEL) QCZG2
    FROM SCMDATA.PT_ORDERED T1
   WHERE T1.QC_MANAGER IS NOT NULL
  CONNECT BY PRIOR T1.PT_ORDERED_ID = T1.PT_ORDERED_ID
         AND LEVEL <=
             LENGTH(T1.QC_MANAGER) - LENGTH(REGEXP_REPLACE(T1.QC_MANAGER, ',', '')) + 1
         AND PRIOR DBMS_RANDOM.VALUE IS NOT NULL)

SELECT Y.COMPANY_ID, Y.YEAR,   Y.CATEGORY, Y.GROUP_NAME,
       Y.COUNT_DIMENSION, Y.DIMENSION_SORT,  Y.ORDER_MONEY INGOOD_MONEY
  FROM ( SELECT A.COMPANY_ID,
       EXTRACT(YEAR FROM A.CREATE_TIME) YEAR,
       E.CATEGORY,
       (CASE WHEN D.GROUP_NAME IS NULL THEN  '1'  ELSE D.GROUP_NAME END) GROUP_NAME,
       '08' COUNT_DIMENSION,
       (case when D.QCZG2 is null then '1' else D.QCZG2 end) DIMENSION_SORT,
       SUM(CASE WHEN REGEXP_COUNT(D.QC_MANAGER, ',') > 0 THEN
       A.AMOUNT/NVL((REGEXP_COUNT(D.QC_MANAGER, ',') + 1),1) * E.PRICE ELSE
           A.AMOUNT * E.PRICE END ) ORDER_MONEY
  FROM (SELECT T.DOCUMENT_NO,
                    T.COMPANY_ID,
                    TRUNC(T.CREATE_TIME) CREATE_TIME,
                    SUM(TL.AMOUNT) AMOUNT,
                    TL.GOO_ID
               FROM SCMDATA.T_INGOOD T
              INNER JOIN (SELECT TI.ING_ID,
                                TI.COMPANY_ID,
                                TI.GOO_ID,
                                TI.AMOUNT
                           FROM SCMDATA.T_INGOODS TI
                          WHERE TI.AMOUNT > 0) TL
                 ON TL.ING_ID = T.ING_ID
                AND TL.COMPANY_ID = T.COMPANY_ID
              WHERE TO_CHAR(T.CREATE_TIME, 'yyyy') >= 2022
              GROUP BY T.DOCUMENT_NO,
                       T.COMPANY_ID,
                       TRUNC(T.CREATE_TIME),
                       TL.GOO_ID) A
                  /*SCMDATA.T_INGOOD A
                 INNER JOIN SCMDATA.T_INGOODS B
                    ON A.ING_ID = B.ING_ID
                   AND A.COMPANY_ID = B.COMPANY_ID
                 LEFT JOIN SCMDATA.T_ORDERED C
                    ON C.ORDER_CODE = A.DOCUMENT_NO
                   AND A.COMPANY_ID = C.COMPANY_ID*/ 
 LEFT JOIN (SELECT Z.*, REGEXP_SUBSTR(Z.QC_MANAGER, '[^,]+', 1, LEVEL) QCZG2
  FROM SCMDATA.PT_ORDERED Z
CONNECT BY PRIOR Z.PT_ORDERED_ID = Z.PT_ORDERED_ID
       AND LEVEL <= LENGTH(Z.QC_MANAGER) -
           LENGTH(REGEXP_REPLACE(Z.QC_MANAGER, ',', '')) + 1
       AND PRIOR DBMS_RANDOM.VALUE IS NOT NULL
) D
    ON D.PRODUCT_GRESS_CODE = A.DOCUMENT_NO
   AND D.COMPANY_ID = A.COMPANY_ID
  INNER JOIN SCMDATA.T_COMMODITY_INFO E ON E.GOO_ID=A.GOO_ID AND E.COMPANY_ID=A.COMPANY_ID
 --WHERE B.AMOUNT > 0
 GROUP BY A.COMPANY_ID,
          EXTRACT(YEAR FROM A.CREATE_TIME),
          E.CATEGORY,
          D.GROUP_NAME,
          D.QCZG2) Y ]';

    V_SQL2 := q'[  MERGE INTO SCMDATA.T_RTKPI_YEAR A
USING (
   WITH TEMP_RT AS
 (SELECT Z.RM_ID, Z.COMPANY_ID, Z.YEAR, Z.QUARTER, Z.ACCESS_TIME,Z.SUPPLIER_CODE,
         Z.GOO_ID, Z.EXAMOUNT, Z.QC_DIRECTOR_ID,
         Z.RM_ID || ROW_NUMBER() OVER(PARTITION BY Z.RM_ID ORDER BY 1) RM_ID2,
         Z.EXAMOUNT / (COUNT(Z.RM_ID) OVER(PARTITION BY(Z.RM_ID))) EXGAMOUNT2,
         REGEXP_SUBSTR(Z.SUP_GROUP_NAME, '[^,]+', 1, LEVEL) SUP_GROUP_NAME2
    FROM SCMDATA.T_RETURN_MANAGEMENT Z
   WHERE Z.AUDIT_TIME IS NOT NULL
  CONNECT BY PRIOR RM_ID = RM_ID
         AND LEVEL <= LENGTH(Z.SUP_GROUP_NAME) -
             LENGTH(REGEXP_REPLACE(Z.SUP_GROUP_NAME, ',', '')) + 1
         AND PRIOR DBMS_RANDOM.VALUE IS NOT NULL),
 TEMP_RT2 AS
 (SELECT Z.RM_ID, Z.COMPANY_ID, Z.YEAR, Z.QUARTER,  Z.ACCESS_TIME,Z.SUPPLIER_CODE,
         Z.GOO_ID, Z.EXAMOUNT, Z.QC_DIRECTOR_ID,
         Z.RM_ID || ROW_NUMBER() OVER(PARTITION BY Z.RM_ID ORDER BY 1) RM_ID2,
         Z.EXAMOUNT / (COUNT(Z.RM_ID) OVER(PARTITION BY(Z.RM_ID))) EXGAMOUNT2,
         REGEXP_SUBSTR(Z.SUP_GROUP_NAME, '[^,]+', 1, LEVEL) SUP_GROUP_NAME2
    FROM SCMDATA.T_RETURN_MANAGEMENT Z
    LEFT JOIN SCMDATA.T_ABNORMAL_DTL_CONFIG C
      ON Z.CAUSE_DETAIL_ID = C.ABNORMAL_DTL_CONFIG_ID
     AND Z.COMPANY_ID = C.COMPANY_ID
     AND C.ANOMALY_CLASSIFICATION = 'AC_QUALITY'
   INNER JOIN SCMDATA.SYS_COMPANY_DEPT D
      ON D.COMPANY_DEPT_ID = Z.FIRST_DEPT_ID
   WHERE Z.AUDIT_TIME IS NOT NULL
     AND C.CAUSE_CLASSIFICATION <> '银饰氧化问题'
     AND C.PROBLEM_CLASSIFICATION <> '非质量问题'
     AND D.DEPT_NAME = '供应链管理部'
     AND INSTR(Z.SECOND_DEPT_ID, 'b550778b4f2d36b4e0533c281caca074') > 0
  CONNECT BY PRIOR RM_ID = RM_ID
         AND LEVEL <= LENGTH(Z.SUP_GROUP_NAME) -
             LENGTH(REGEXP_REPLACE(Z.SUP_GROUP_NAME, ',', '')) + 1
         AND PRIOR DBMS_RANDOM.VALUE IS NOT NULL),
TEMP_PTORDER AS
 (SELECT T1.PT_ORDERED_ID, T1.GOO_ID_PR,T1.ORDER_ID, T1.DELIVERY_AMOUNT,
         T1.PT_ORDERED_ID || ROW_NUMBER() OVER(PARTITION BY T1.PT_ORDERED_ID ORDER BY 1) ID2,
         T1.COMPANY_ID, T1.PRODUCT_GRESS_CODE, T1.ORDER_MONEY,
         (T1.ORDER_MONEY / COUNT(T1.PRODUCT_GRESS_CODE)
           OVER(PARTITION BY T1.PRODUCT_GRESS_CODE)) SUM1,
         REGEXP_SUBSTR(T1.QC_MANAGER, '[^,]+', 1, LEVEL) QCZG2
    FROM SCMDATA.PT_ORDERED T1
   WHERE T1.QC_MANAGER IS NOT NULL
  CONNECT BY PRIOR T1.PT_ORDERED_ID = T1.PT_ORDERED_ID
         AND LEVEL <=
             LENGTH(T1.QC_MANAGER) - LENGTH(REGEXP_REPLACE(T1.QC_MANAGER, ',', '')) + 1
         AND PRIOR DBMS_RANDOM.VALUE IS NOT NULL)

SELECT Y.COMPANY_ID, Y.YEAR,   Y.CATEGORY, Y.GROUP_NAME,
       '08' COUNT_DIMENSION, Y.DIMENSION_SORT DIMENSION_SORT, Y.RMMONEY SHOP_RT_ORIGINAL_MONEY,
       X.SHOP_RT_MONEY/*, Z.ORDER_MONEY INGOOD_MONEY*/
  FROM (SELECT A.COMPANY_ID, A.YEAR,  B.CATEGORY,
       (CASE WHEN A.SUP_GROUP_NAME2 IS NULL THEN  '1' ELSE   A.SUP_GROUP_NAME2
       END) GROUP_NAME, '08' COUNT_DIMENSION, (CASE WHEN A.QCZG2 IS NULL THEN '1' ELSE A.QCZG2 END) DIMENSION_SORT,
       SUM(A.EXGAMOUNT3 * B.PRICE) RMMONEY FROM
         (SELECT Z.COMPANY_ID, Z.YEAR, Z.QUARTER, Z.ACCESS_TIME, Z.GOO_ID,
                Z.SUP_GROUP_NAME2,
                Z.EXGAMOUNT2 / NVL((REGEXP_COUNT(Z.QC_DIRECTOR_ID, ',') + 1),1) EXGAMOUNT3,
                REGEXP_SUBSTR(Z.QC_DIRECTOR_ID, '[^,]+', 1, LEVEL) QCZG2
           FROM TEMP_RT Z
          WHERE (EXISTS (SELECT MAX(1)
                           FROM SCMDATA.T_PLAT_LOG X
                           INNER JOIN SCMDATA.T_PLAT_LOGS Y ON X.COMPANY_ID=Y.COMPANY_ID AND X.LOG_ID=Y.LOG_ID
                          WHERE X.APPLY_PK_ID = Z.RM_ID
                            AND Y.OPERATE_FIELD = 'QC_DIRECTOR_ID'
                            AND X.ACTION_TYPE = 'UPDATE') OR
                 (NOT EXISTS (SELECT MAX(1)
                                       FROM SCMDATA.T_PLAT_LOG Y
                                       INNER JOIN SCMDATA.T_PLAT_LOGS X ON X.COMPANY_ID=Y.COMPANY_ID AND X.LOG_ID=Y.LOG_ID
                                      WHERE Y.APPLY_PK_ID = Z.RM_ID
                                        AND X.OPERATE_FIELD = 'QC_DIRECTOR_ID'
                                        AND Y.ACTION_TYPE = 'UPDATE') AND
                  NOT EXISTS
                  (SELECT 1
                            FROM TEMP_PTORDER J
                           INNER JOIN SCMDATA.T_ORDERED P
                              ON P.ORDER_ID = J.ORDER_ID
                             AND P.COMPANY_ID = J.COMPANY_ID
                           WHERE J.GOO_ID_PR = Z.GOO_ID
                             AND J.COMPANY_ID = Z.COMPANY_ID AND P.SUPPLIER_CODE = Z.SUPPLIER_CODE AND J.DELIVERY_AMOUNT >0 AND J.QCZG2 IS NOT NULL )))
         CONNECT BY PRIOR Z.RM_ID2 = Z.RM_ID2
                AND LEVEL <= LENGTH(Z.QC_DIRECTOR_ID) -
                    LENGTH(REGEXP_REPLACE(Z.QC_DIRECTOR_ID, ',', '')) + 1
                AND PRIOR DBMS_RANDOM.VALUE IS NOT NULL
         UNION ALL
         SELECT H.COMPANY_ID, H.YEAR, H.QUARTER, H.ACCESS_TIME, H.GOO_ID,
                H.SUP_GROUP_NAME2,
                (H.EXGAMOUNT2 *
                 ((SELECT SUM(J.SUM1)
                      FROM TEMP_PTORDER J INNER JOIN SCMDATA.T_ORDERED P ON P.ORDER_ID = J.ORDER_ID  AND P.COMPANY_ID = J.COMPANY_ID
                     WHERE J.GOO_ID_PR = H.GOO_ID
                       AND J.COMPANY_ID = H.COMPANY_ID AND P.SUPPLIER_CODE = H.SUPPLIER_CODE AND J.DELIVERY_AMOUNT >0
                       AND J.QCZG2 = H.QCZG2) /
                 (SELECT SUM(J.ORDER_MONEY)
                      FROM TEMP_PTORDER J INNER JOIN SCMDATA.T_ORDERED P ON P.ORDER_ID = J.ORDER_ID  AND P.COMPANY_ID = J.COMPANY_ID
                     WHERE J.GOO_ID_PR = H.GOO_ID
                       AND H.COMPANY_ID = J.COMPANY_ID AND P.SUPPLIER_CODE = H.SUPPLIER_CODE AND J.DELIVERY_AMOUNT >0
                       AND J.QCZG2 IS NOT NULL))) EXGAMOUNT3, H.QCZG2
           FROM (SELECT Z.*, REGEXP_SUBSTR(Z.QC_DIRECTOR_ID, '[^,]+', 1, LEVEL) QCZG2
                    FROM TEMP_RT Z
                   WHERE NOT EXISTS (SELECT MAX(1)
                            FROM SCMDATA.T_PLAT_LOG Y
                            INNER JOIN SCMDATA.T_PLAT_LOGS X ON X.COMPANY_ID=Y.COMPANY_ID AND X.LOG_ID=Y.LOG_ID
                           WHERE Y.APPLY_PK_ID = Z.RM_ID
                             AND X.OPERATE_FIELD = 'QC_DIRECTOR_ID'
                             AND Y.ACTION_TYPE = 'UPDATE')
                     AND EXISTS
                   (SELECT MAX(1)
                            FROM TEMP_PTORDER J INNER JOIN SCMDATA.T_ORDERED P ON P.ORDER_ID = J.ORDER_ID  AND P.COMPANY_ID = J.COMPANY_ID
                     WHERE J.GOO_ID_PR = Z.GOO_ID AND  P.SUPPLIER_CODE = Z.SUPPLIER_CODE AND J.DELIVERY_AMOUNT >0 AND J.QCZG2 IS NOT NULL
                             AND J.COMPANY_ID = Z.COMPANY_ID)
                  CONNECT BY PRIOR Z.RM_ID2 = Z.RM_ID2
                         AND LEVEL <=
                             LENGTH(Z.QC_DIRECTOR_ID) -
                             LENGTH(REGEXP_REPLACE(Z.QC_DIRECTOR_ID, ',', '')) + 1
                         AND PRIOR DBMS_RANDOM.VALUE IS NOT NULL) H) A
 INNER JOIN SCMDATA.T_COMMODITY_INFO B
    ON A.GOO_ID = B.GOO_ID
   AND A.COMPANY_ID = B.COMPANY_ID
 GROUP BY A.COMPANY_ID, A.YEAR,B.CATEGORY,
          A.SUP_GROUP_NAME2, A.QCZG2) Y

  LEFT JOIN (SELECT A.COMPANY_ID, A.YEAR,  B.CATEGORY,
       (CASE
         WHEN A.SUP_GROUP_NAME2 IS NULL THEN
          '1'
         ELSE
          A.SUP_GROUP_NAME2
       END) GROUP_NAME, '08' COUNT_DIMENSION,( CASE WHEN A.QCZG2 IS NULL THEN '1' ELSE A.QCZG2 END) DIMENSION_SORT,
       SUM(A.EXGAMOUNT3 * B.PRICE) SHOP_RT_MONEY
  FROM (SELECT Z.COMPANY_ID, Z.YEAR, Z.QUARTER, Z.ACCESS_TIME, Z.GOO_ID,
                Z.SUP_GROUP_NAME2,
                Z.EXGAMOUNT2 / NVL((REGEXP_COUNT(Z.QC_DIRECTOR_ID, ',') + 1),1) EXGAMOUNT3,
                REGEXP_SUBSTR(Z.QC_DIRECTOR_ID, '[^,]+', 1, LEVEL) QCZG2
           FROM TEMP_RT2 Z
          WHERE (EXISTS (SELECT MAX(1)
                           FROM SCMDATA.T_PLAT_LOG X
                           INNER JOIN SCMDATA.T_PLAT_LOGS Y ON X.COMPANY_ID=Y.COMPANY_ID AND X.LOG_ID=Y.LOG_ID
                          WHERE X.APPLY_PK_ID = Z.RM_ID
                            AND Y.OPERATE_FIELD = 'QC_DIRECTOR_ID'
                            AND X.ACTION_TYPE = 'UPDATE') OR
                 (NOT EXISTS (SELECT MAX(1)
                                       FROM SCMDATA.T_PLAT_LOG Y
                                       INNER JOIN SCMDATA.T_PLAT_LOGS X ON X.COMPANY_ID=Y.COMPANY_ID AND X.LOG_ID=Y.LOG_ID
                                      WHERE Y.APPLY_PK_ID = Z.RM_ID
                                        AND X.OPERATE_FIELD = 'QC_DIRECTOR_ID'
                                        AND Y.ACTION_TYPE = 'UPDATE') AND
                  NOT EXISTS
                  (SELECT 1
                            FROM TEMP_PTORDER J INNER JOIN SCMDATA.T_ORDERED P ON P.ORDER_ID = J.ORDER_ID  AND P.COMPANY_ID = J.COMPANY_ID
                     WHERE J.GOO_ID_PR = Z.GOO_ID AND P.SUPPLIER_CODE = Z.SUPPLIER_CODE AND J.DELIVERY_AMOUNT >0 AND J.QCZG2 IS NOT NULL
                             AND J.COMPANY_ID = Z.COMPANY_ID)))
         CONNECT BY PRIOR Z.RM_ID2 = Z.RM_ID2
                AND LEVEL <= LENGTH(Z.QC_DIRECTOR_ID) -
                    LENGTH(REGEXP_REPLACE(Z.QC_DIRECTOR_ID, ',', '')) + 1
                AND PRIOR DBMS_RANDOM.VALUE IS NOT NULL
         UNION ALL
         SELECT H.COMPANY_ID, H.YEAR, H.QUARTER, H.ACCESS_TIME, H.GOO_ID,
                H.SUP_GROUP_NAME2,
                (H.EXGAMOUNT2 *
                 ((SELECT SUM(J.SUM1)
                      FROM TEMP_PTORDER J INNER JOIN SCMDATA.T_ORDERED P ON P.ORDER_ID = J.ORDER_ID  AND P.COMPANY_ID = J.COMPANY_ID
                     WHERE J.GOO_ID_PR = H.GOO_ID
                       AND J.COMPANY_ID = H.COMPANY_ID AND P.SUPPLIER_CODE = H.SUPPLIER_CODE AND J.DELIVERY_AMOUNT >0
                       AND J.QCZG2 = H.QCZG2) /
                 (SELECT SUM(J.ORDER_MONEY)
                      FROM TEMP_PTORDER J INNER JOIN SCMDATA.T_ORDERED P ON P.ORDER_ID = J.ORDER_ID  AND P.COMPANY_ID = J.COMPANY_ID
                     WHERE J.GOO_ID_PR = H.GOO_ID
                       AND H.COMPANY_ID = J.COMPANY_ID
                       AND J.QCZG2 IS NOT NULL AND P.SUPPLIER_CODE = H.SUPPLIER_CODE AND J.DELIVERY_AMOUNT >0))) EXGAMOUNT3, H.QCZG2
           FROM (SELECT Z.*, REGEXP_SUBSTR(Z.QC_DIRECTOR_ID, '[^,]+', 1, LEVEL) QCZG2
                    FROM TEMP_RT2 Z
                   WHERE NOT EXISTS (SELECT MAX(1)
                            FROM SCMDATA.T_PLAT_LOG Y
                            INNER JOIN SCMDATA.T_PLAT_LOGS X ON X.COMPANY_ID=Y.COMPANY_ID AND X.LOG_ID=Y.LOG_ID
                           WHERE Y.APPLY_PK_ID = Z.RM_ID
                             AND X.OPERATE_FIELD = 'QC_DIRECTOR_ID'
                             AND Y.ACTION_TYPE = 'UPDATE')
                     AND EXISTS
                   (SELECT MAX(1)
                            FROM TEMP_PTORDER J INNER JOIN SCMDATA.T_ORDERED P ON P.ORDER_ID = J.ORDER_ID  AND P.COMPANY_ID = J.COMPANY_ID
                           WHERE J.GOO_ID_PR = Z.GOO_ID AND J.QCZG2 IS NOT NULL AND P.SUPPLIER_CODE = Z.SUPPLIER_CODE AND J.DELIVERY_AMOUNT >0
                             AND J.COMPANY_ID = Z.COMPANY_ID)
                  CONNECT BY PRIOR Z.RM_ID2 = Z.RM_ID2
                         AND LEVEL <=
                             LENGTH(Z.QC_DIRECTOR_ID) -
                             LENGTH(REGEXP_REPLACE(Z.QC_DIRECTOR_ID, ',', '')) + 1
                         AND PRIOR DBMS_RANDOM.VALUE IS NOT NULL) H) A
 INNER JOIN SCMDATA.T_COMMODITY_INFO B
    ON A.GOO_ID = B.GOO_ID
   AND A.COMPANY_ID = B.COMPANY_ID
 GROUP BY A.COMPANY_ID, A.YEAR, B.CATEGORY,
          A.SUP_GROUP_NAME2, A.QCZG2) X
    ON X.COMPANY_ID = Y.COMPANY_ID
   AND X.YEAR = Y.YEAR
   AND X.CATEGORY = Y.CATEGORY
   AND X.GROUP_NAME = Y.GROUP_NAME
   AND X.COUNT_DIMENSION = Y.COUNT_DIMENSION
   AND X.DIMENSION_SORT = Y.DIMENSION_SORT
  /*LEFT JOIN ( SELECT A.COMPANY_ID,
       EXTRACT(YEAR FROM A.CREATE_TIME) YEAR,
       D.CATEGORY,
       (CASE WHEN D.GROUP_NAME IS NULL THEN  '1'  ELSE D.GROUP_NAME END) GROUP_NAME,
       '08' COUNT_DIMENSION,
       (case when D.QCZG2 is null then '1' else D.QCZG2 end) DIMENSION_SORT,
       SUM(CASE WHEN REGEXP_COUNT(D.QC_MANAGER, ',') > 0 THEN
       B.AMOUNT/NVL((REGEXP_COUNT(D.QC_MANAGER, ',') + 1),1) * E.PRICE ELSE
           B.AMOUNT * E.PRICE END ) ORDER_MONEY
  FROM SCMDATA.T_INGOOD A
 INNER JOIN SCMDATA.T_INGOODS B
    ON A.ING_ID = B.ING_ID
   AND A.COMPANY_ID = B.COMPANY_ID
 INNER JOIN SCMDATA.T_ORDERED C
    ON C.ORDER_CODE = A.DOCUMENT_NO
   AND A.COMPANY_ID = C.COMPANY_ID
 INNER JOIN (SELECT Z.*, REGEXP_SUBSTR(Z.QC_MANAGER, '[^,]+', 1, LEVEL) QCZG2
  FROM SCMDATA.PT_ORDERED Z
CONNECT BY PRIOR Z.PT_ORDERED_ID = Z.PT_ORDERED_ID
       AND LEVEL <= LENGTH(Z.QC_MANAGER) -
           LENGTH(REGEXP_REPLACE(Z.QC_MANAGER, ',', '')) + 1
       AND PRIOR DBMS_RANDOM.VALUE IS NOT NULL
) D
    ON D.ORDER_ID = C.ORDER_ID
   AND D.COMPANY_ID = C.COMPANY_ID
  INNER JOIN SCMDATA.T_COMMODITY_INFO E ON E.GOO_ID=B.GOO_ID AND E.COMPANY_ID=B.COMPANY_ID
 WHERE B.AMOUNT > 0
 GROUP BY A.COMPANY_ID,
          EXTRACT(YEAR FROM A.CREATE_TIME),
          D.CATEGORY,
          D.GROUP_NAME,
          D.QCZG2) Z
    ON Z.COMPANY_ID = Y.COMPANY_ID
   AND Z.YEAR = Y.YEAR
   AND Z.CATEGORY = Y.CATEGORY
   AND Z.GROUP_NAME = Y.GROUP_NAME
   AND Z.COUNT_DIMENSION = Y.COUNT_DIMENSION
   AND Z.DIMENSION_SORT = Y.DIMENSION_SORT */ ]';

   IF P_TYPE = 0 THEN
      --进货
      V_EXSQL1 := V_SQL1||V_WH_SQL2||V_U_SQL1||V_I_SQL1;
      --退货
      V_EXSQL2 := V_SQL2 || V_WH_SQL2 || V_U_SQL2 || V_I_SQL2;


    ELSIF P_TYPE = 1 THEN
      --进货
      V_EXSQL1 := V_SQL1||V_WM_SQL1||V_U_SQL1||V_I_SQL1;
      --退货
      V_EXSQL2 := V_SQL2 || V_WM_SQL1 || V_U_SQL2 || V_I_SQL2;
    END IF;
    EXECUTE IMMEDIATE V_EXSQL2;
     EXECUTE IMMEDIATE V_EXSQL1;
    --dbms_output.put_line(V_EXSQL1);
    --dbms_output.put_line(V_EXSQL2);
  END P_RTKPI_YEAR;

  FUNCTION F_GET_159_SELECTSQL(KPI_TIMETYPE       VARCHAR2,
                               KPI_TIME           VARCHAR2,
                               KPI_DIMENSION      VARCHAR2,
                               KPI_GROUP          VARCHAR2,
                               KPI_CATEGORY       VARCHAR2,
                               P_CLASS_DATA_PRIVS CLOB,
                               COMPANY_ID         VARCHAR2) RETURN CLOB IS

    VC_SQL       CLOB;
    VC_SQL1      CLOB;
    K_TIME       VARCHAR2(128) := KPI_TIME;
    V_WHERE      CLOB;
    V1_WHERE     CLOB;
    V2_WHERE     CLOB;
    V_B          CLOB;
    V_B2         CLOB;
    V_S          CLOB;
    V_S1         CLOB;
    V_S2         CLOB;
    V_DIMENSION  CLOB;
    V1_DIMENSION CLOB;
    V2_DIMENSION CLOB;
    V_SORT       CLOB := '';
    V_GROUP      CLOB;
    V_ORDERBY    CLOB;

  BEGIN
    ---汇总字段条件
    IF KPI_TIMETYPE = '本月' THEN
      K_TIME := TO_CHAR(SYSDATE, 'yyyy-mm');
    END IF;
    ---汇总主键
    V1_DIMENSION := '{"COL_1":' || K_TIME || ',"COL_2":' || KPI_GROUP ||
                    ',"COL_3":' || KPI_CATEGORY || ' ,"COL_4":' ||
                    KPI_DIMENSION || ' }';
    ---拼接主键
    V2_DIMENSION := '''{"COL_1":' || K_TIME || ',"COL_2":' || KPI_GROUP ||
                    ',"COL_3":' || KPI_CATEGORY || ' ,"COL_4":' ||
                    KPI_DIMENSION || ' ,"COL_5":''' ||
                    '|| a.dimension_sort' || '||'' }''';

    --统计维度
    --分类
    IF KPI_DIMENSION = '00' THEN
      V1_WHERE := ' and count_dimension = ''00''';
      IF KPI_GROUP = '1' THEN
        V_DIMENSION := ' ''全部'' area_group  , category_name,' ||
                       V2_DIMENSION || ' pid ,';
        V_GROUP     := ' group by total_time , category_name,category,count_dimension,dimension_sort,' ||
                       V2_DIMENSION;
      ELSE
        V_DIMENSION := ' area_group,category_name,' || V2_DIMENSION ||
                       ' pid ,';
        V_GROUP     := ' group by total_time,area_group,category_name,count_dimension,dimension_sort,' ||
                       V2_DIMENSION;
      END IF;

      --区域组
    ELSIF KPI_DIMENSION = '01' THEN
      V1_WHERE := ' and count_dimension = ''01''';
      IF KPI_CATEGORY = '1' THEN
        V_DIMENSION := ' area_group ,''全部'' category_name,' || V2_DIMENSION ||
                       ' pid ,';
        V_GROUP     := ' group by total_time, area_group,count_dimension,dimension_sort,' ||
                       V2_DIMENSION;
      ELSE
        V_DIMENSION := ' area_group,category_name,' || V2_DIMENSION ||
                       ' pid ,';
        V_GROUP     := ' group by total_time,area_group, category_name,count_dimension,dimension_sort,' ||
                       V2_DIMENSION;
      END IF;

      --款式名称
    ELSIF KPI_DIMENSION = '02' THEN
      V1_WHERE := ' and count_dimension = ''02''';
      V_SORT   := ' '' ''style_names, ';

      IF KPI_CATEGORY = '1' AND KPI_GROUP = '1' THEN
        V_DIMENSION := ' ''全部'' area_group ,''全部'' category_name,dimension_sort style_names,' ||
                       V2_DIMENSION || ' pid ,';
        V_GROUP     := ' group by total_time,dimension_sort,count_dimension,dimension_sort,' ||
                       V2_DIMENSION;
      ELSIF KPI_CATEGORY = '1' AND KPI_GROUP <> '1' THEN
        V_DIMENSION := ' area_group ,''全部'' category_name,dimension_sort style_names,' ||
                       V2_DIMENSION || ' pid ,';
        V_GROUP     := ' group by total_time,area_group ,dimension_sort,count_dimension,dimension_sort,' ||
                       V2_DIMENSION;
      ELSIF KPI_CATEGORY <> '1' AND KPI_GROUP = '1' THEN
        V_DIMENSION := '''全部'' area_group ,category_name,dimension_sort style_names,' ||
                       V2_DIMENSION || ' pid ,';
        V_GROUP     := ' group by total_time ,category_name,dimension_sort,count_dimension,dimension_sort,' ||
                       V2_DIMENSION;
      ELSE
        V_DIMENSION := ' area_group ,category_name,dimension_sort style_names,' ||
                       V2_DIMENSION || ' pid ,';
        V_GROUP     := ' group by total_time,area_group ,category_name,dimension_sort,count_dimension,dimension_sort,' ||
                       V2_DIMENSION;
      END IF;

      --产品子类
    ELSIF KPI_DIMENSION = '03' THEN
      V1_WHERE := ' and count_dimension = ''03''';
      V_SORT   := ''' '' PROCATE_DESC,'' '' PRODUCT_SUBCATEGORY,'' ''small_category_gd, ';
      IF KPI_CATEGORY = '1' AND KPI_GROUP = '1' THEN
        V_DIMENSION := ' ''全部'' area_group ,''全部'' category_name,cate_category product_cate, samll_category PRODUCT_SUBCATEGORY,dimension_sort small_category_gd,' ||
                       V2_DIMENSION || ' pid ,';
        V_GROUP     := ' group by total_time,samll_category,cate_category,count_dimension,dimension_sort,' ||
                       V2_DIMENSION;
      ELSIF KPI_CATEGORY = '1' AND KPI_GROUP <> '1' THEN
        V_DIMENSION := ' area_group ,''全部'' category_name,cate_category product_cate, samll_category PRODUCT_SUBCATEGORY,dimension_sort small_category_gd,' ||
                       V2_DIMENSION || ' pid ,';
        V_GROUP     := ' group by total_time,area_group ,cate_category,samll_category,count_dimension,dimension_sort,' ||
                       V2_DIMENSION;
      ELSIF KPI_CATEGORY <> '1' AND KPI_GROUP = '1' THEN
        V_DIMENSION := '''全部'' area_group ,category_name,cate_category product_cate,  samll_category PRODUCT_SUBCATEGORY,dimension_sort small_category_gd,' ||
                       V2_DIMENSION || ' pid ,';
        V_GROUP     := ' group by total_time ,category_name,cate_category,samll_category,count_dimension,dimension_sort,' ||
                       V2_DIMENSION;
      ELSE
        V_DIMENSION := ' area_group ,category_name,cate_category product_cate, samll_category PRODUCT_SUBCATEGORY,dimension_sort small_category_gd,' ||
                       V2_DIMENSION || ' pid ,';
        V_GROUP     := ' group by total_time,area_group ,cate_category,category_name,samll_category,count_dimension,dimension_sort,' ||
                       V2_DIMENSION;
      END IF;

      --供应商
    ELSIF KPI_DIMENSION = '04' THEN
      V1_WHERE := ' and count_dimension = ''04''';
      V_SORT   := ''' ''SUPPLIER_CODE_N, '' '' SUPPLIER_NAME, ';
      IF KPI_CATEGORY = '1' AND KPI_GROUP = '1' THEN
        V_DIMENSION := ' ''全部'' area_group ,''全部'' category_name, supplier_code SUPPLIER_CODE_N,supplier SUPPLIER_NAME,' ||
                       V2_DIMENSION || ' pid ,';
        V_GROUP     := ' group by total_time,supplier_code,supplier,count_dimension,dimension_sort,' ||
                       V2_DIMENSION;
      ELSIF KPI_CATEGORY = '1' AND KPI_GROUP <> '1' THEN
        V_DIMENSION := ' area_group ,''全部'' category_name, supplier_code SUPPLIER_CODE_N, supplier SUPPLIER_NAME,' ||
                       V2_DIMENSION || ' pid ,';
        V_GROUP     := ' group by total_time,area_group ,supplier_code,supplier,count_dimension,dimension_sort,' ||
                       V2_DIMENSION;
      ELSIF KPI_CATEGORY <> '1' AND KPI_GROUP = '1' THEN
        V_DIMENSION := '''全部'' area_group ,category_name, supplier_code SUPPLIER_CODE_N, supplier SUPPLIER_NAME,' ||
                       V2_DIMENSION || ' pid ,';
        V_GROUP     := ' group by total_time ,category_name,supplier_code,supplier,count_dimension,dimension_sort,' ||
                       V2_DIMENSION;
      ELSE
        V_DIMENSION := ' area_group ,category_name, supplier_code SUPPLIER_CODE_N,supplier SUPPLIER_NAME,' ||
                       V2_DIMENSION || ' pid ,';
        V_GROUP     := ' group by total_time,area_group ,category_name,supplier_code,supplier,count_dimension,dimension_sort,' ||
                       V2_DIMENSION;
      END IF;

      --跟单
    ELSIF KPI_DIMENSION = '05' THEN
      V1_WHERE := ' and count_dimension = ''05''';
      V_SORT   := ''' ''FLW_ORDER_DESC, ';
      IF KPI_CATEGORY = '1' AND KPI_GROUP = '1' THEN
        V_DIMENSION := ' ''全部'' area_group ,''全部'' category_name, flw_order FLW_ORDER_DESC,' ||
                       V2_DIMENSION || ' pid ,';
        V_GROUP     := ' group by total_time,flw_order,count_dimension,dimension_sort,' ||
                       V2_DIMENSION;
      ELSIF KPI_CATEGORY = '1' AND KPI_GROUP <> '1' THEN
        V_DIMENSION := ' area_group ,''全部'' category_name,flw_order FLW_ORDER_DESC,' ||
                       V2_DIMENSION || ' pid ,';
        V_GROUP     := ' group by total_time,area_group ,flw_order,count_dimension,dimension_sort,' ||
                       V2_DIMENSION;
      ELSIF KPI_CATEGORY <> '1' AND KPI_GROUP = '1' THEN
        V_DIMENSION := '''全部'' area_group ,category_name,flw_order FLW_ORDER_DESC,' ||
                       V2_DIMENSION || ' pid ,';
        V_GROUP     := ' group by total_time,category_name,flw_order,count_dimension,dimension_sort,' ||
                       V2_DIMENSION;
      ELSE
        V_DIMENSION := ' area_group ,category_name, flw_order FLW_ORDER_DESC,' ||
                       V2_DIMENSION || ' pid ,';
        V_GROUP     := ' group by total_time,area_group ,category_name,flw_order,count_dimension,dimension_sort,' ||
                       V2_DIMENSION;
      END IF;

      --跟单主管
    ELSIF KPI_DIMENSION = '06' THEN
      V1_WHERE := ' AND COUNT_DIMENSION = ''06'' ';
      V_SORT   := ''' '' FOLLOWER_LEADER, ';
      IF KPI_CATEGORY = '1' AND KPI_GROUP = '1' THEN
        V_DIMENSION := ' ''全部'' area_group ,''全部'' category_name, FLW_ORDER_MANAGER FOLLOWER_LEADER,' ||
                       V2_DIMENSION || ' pid ,';
        V_GROUP     := ' group by total_time,FLW_ORDER_MANAGER,count_dimension,dimension_sort,' ||
                       V2_DIMENSION;
      ELSIF KPI_CATEGORY = '1' AND KPI_GROUP <> '1' THEN
        V_DIMENSION := ' area_group ,''全部'' category_name,FLW_ORDER_MANAGER FOLLOWER_LEADER,' ||
                       V2_DIMENSION || ' pid ,';
        V_GROUP     := ' group by total_time,area_group ,FLW_ORDER_MANAGER,count_dimension,dimension_sort,' ||
                       V2_DIMENSION;
      ELSIF KPI_CATEGORY <> '1' AND KPI_GROUP = '1' THEN
        V_DIMENSION := '''全部'' area_group ,category_name,FLW_ORDER_MANAGER FOLLOWER_LEADER,' ||
                       V2_DIMENSION || ' pid ,';
        V_GROUP     := ' group by total_time,category_name,FLW_ORDER_MANAGER,count_dimension,dimension_sort,' ||
                       V2_DIMENSION;
      ELSE
        V_DIMENSION := ' area_group ,category_name, FLW_ORDER_MANAGER FOLLOWER_LEADER,' ||
                       V2_DIMENSION || ' pid ,';
        V_GROUP     := ' group by total_time,area_group ,category_name,FLW_ORDER_MANAGER,count_dimension,dimension_sort,' ||
                       V2_DIMENSION;
      END IF;

      --QC
    ELSIF KPI_DIMENSION = '07' THEN
      V1_WHERE := ' and count_dimension = ''07''';
      V_SORT   := ''' ''QC_DESC, ';
      IF KPI_CATEGORY = '1' AND KPI_GROUP = '1' THEN
        V_DIMENSION := ' ''全部'' area_group ,''全部'' category_name, qc,' ||
                       V2_DIMENSION || ' pid ,';
        V_GROUP     := ' group by total_time,qc,count_dimension,dimension_sort,' ||
                       V2_DIMENSION;
      ELSIF KPI_CATEGORY = '1' AND KPI_GROUP <> '1' THEN
        V_DIMENSION := ' area_group ,''全部'' category_name,qc,' ||
                       V2_DIMENSION || ' pid ,';
        V_GROUP     := ' group by total_time,area_group ,qc,count_dimension,dimension_sort,' ||
                       V2_DIMENSION;
      ELSIF KPI_CATEGORY <> '1' AND KPI_GROUP = '1' THEN
        V_DIMENSION := '''全部'' area_group ,category_name,qc,' ||
                       V2_DIMENSION || ' pid ,';
        V_GROUP     := ' group by total_time,category_name,qc,count_dimension,dimension_sort,' ||
                       V2_DIMENSION;
      ELSE
        V_DIMENSION := ' area_group ,category_name, qc,' || V2_DIMENSION ||
                       ' pid ,';
        V_GROUP     := ' group by total_time,area_group ,category_name,qc,count_dimension,dimension_sort,' ||
                       V2_DIMENSION;
      END IF;

      --QC主管
    ELSIF KPI_DIMENSION = '08' THEN
      V1_WHERE := ' and count_dimension = ''08''';
      V_SORT   := ''' ''qc_leader, ';
      IF KPI_CATEGORY = '1' AND KPI_GROUP = '1' THEN
        V_DIMENSION := ' ''全部'' area_group ,''全部'' category_name, qc_leader,' ||
                       V2_DIMENSION || ' pid ,';
        V_GROUP     := ' group by total_time,qc_leader,count_dimension,dimension_sort,' ||
                       V2_DIMENSION;
      ELSIF KPI_CATEGORY = '1' AND KPI_GROUP <> '1' THEN
        V_DIMENSION := ' area_group ,''全部'' category_name,qc_leader,' ||
                       V2_DIMENSION || ' pid ,';
        V_GROUP     := ' group by total_time,area_group ,qc_leader,count_dimension,dimension_sort,' ||
                       V2_DIMENSION;
      ELSIF KPI_CATEGORY <> '1' AND KPI_GROUP = '1' THEN
        V_DIMENSION := '''全部'' area_group ,category_name,qc_leader,' ||
                       V2_DIMENSION || ' pid ,';
        V_GROUP     := ' group by total_time,category_name,qc_leader,count_dimension,dimension_sort,' ||
                       V2_DIMENSION;
      ELSE
        V_DIMENSION := ' area_group ,category_name, qc_leader,' ||
                       V2_DIMENSION || ' pid ,';
        V_GROUP     := ' group by total_time,area_group ,category_name,qc_leader,count_dimension,dimension_sort,' ||
                       V2_DIMENSION;
      END IF;
    END IF;

    --过滤条件：分部
    CASE
      WHEN KPI_CATEGORY = '1' THEN
        V1_WHERE := V1_WHERE || ' AND 1 = 1 ';

      ELSE
        V1_WHERE := V1_WHERE || ' AND category = ''' || KPI_CATEGORY ||
                    ''' ';
    END CASE;
    --过滤条件：区域组
    CASE
      WHEN KPI_GROUP = '1' THEN
        V1_WHERE := V1_WHERE || ' AND 1 = 1 ';

      ELSE
        V1_WHERE := V1_WHERE || ' AND groupname = ''' || KPI_GROUP || ''' ';
    END CASE;

    --字段
    V_S2 := '  a.group_dict_name category_name,
       t.category,
       t.groupname,
       ts.group_name area_group,
       t.count_dimension,
       t.dimension_sort,
       samll.samll_category,
       samll.cate_category,
       tsup.supplier_code,
       tsup.SUPPLIER_COMPANY_NAME  supplier,
       fel.company_user_name flw_order,
       gd2.company_user_name FLW_ORDER_MANAGER,
       q.company_user_name qc,
       q1.company_user_name qc_leader,
       t.INGOOD_MONEY,
       t.SHOP_RT_MONEY,
       t.SHOP_RT_ORIGINAL_MONEY ';

    --表关联
    V_B2 := q'[inner join scmdata.sys_group_dict a
            on a.group_dict_type = 'PRODUCT_TYPE'
           and a.group_dict_value = t.category
          left join scmdata.t_supplier_group_config ts
            on ts.group_config_id = t.groupname
          left join (select distinct c.group_dict_value,c1.group_dict_name cate_category,
                                    cd.company_dict_value,
                                    cd.company_dict_name samll_category
                      from scmdata.sys_group_dict c
                     inner join scmdata.sys_group_dict c1
                        on c1.group_dict_type = c.group_dict_value
                     inner join scmdata.sys_company_dict cd
                        on cd.company_dict_type = c1.group_dict_value
                       and cd.company_id = %default_company_id%
                     where c.group_dict_type = 'PRODUCT_TYPE') samll
            on samll.group_dict_value = t.category
           and samll.company_dict_value = t.dimension_sort
           and t.count_dimension = '03'
          left join scmdata.t_supplier_info tsup
            on tsup.company_id = t.company_id
           and tsup.supplier_code = t.dimension_sort
           and t.count_dimension = '04'
          left join scmdata.sys_company_user fel
            on fel.company_id = t.company_id
           and fel.user_id = t.dimension_sort
           and t.count_dimension = '05'
          left join scmdata.sys_company_user gd2
            on gd2.company_id = t.company_id
           and gd2.user_id = t.dimension_sort
           and t.count_dimension = '06'
          left join scmdata.sys_company_user q
            on q.company_id = t.company_id
           and q.user_id = t.dimension_sort
           and t.count_dimension = '07'
          left join scmdata.sys_company_user q1 --qc_leader
            on q1.company_id = t.company_id
           and q1.user_id = t.dimension_sort
           and t.count_dimension = '08'
         where /*t.INGOOD_MONEY is not null
           and*/ t.company_id = ']' || COMPANY_ID || ''' ' ||
            SCMDATA.PKG_KPIPT_ORDER.F_GET_DATAPRIVS_SQL(P_CLASS_DATA_PRIVS => P_CLASS_DATA_PRIVS,
                                                        P_PRE              => 't') ||
            V1_WHERE || ' ORDER BY  DIMENSION_SORT ) A';

    --过滤条件：时间
    IF KPI_TIMETYPE = '本月' THEN
      V_WHERE := ' where total_time2 = to_char(sysdate,''yyyy-mm'')';
    ELSE
      V_WHERE := ' where total_time = ''' || K_TIME || ''' ';
    END IF;

  V_ORDERBY := ' order by dimension_sort nulls first ,area_group nulls first ,category_name nulls first';

    --时间维度
    IF KPI_TIMETYPE = '本月' THEN
      V_B := ' from scmdata.t_rtkpi_thismonth t ';
      /*      v_s1 := 'to_char(t.kpi_date,''yyyy-mm'') ';*/
      V_S1 := ' to_char(t.rtkpi_date,''yyyy-mm'') total_time2, ''本月'' ';
      V_S  := ' select ' || V_S1 || ' total_time,' || V_S2 || V_B || V_B2 ||
              V_WHERE || V_GROUP||V_ORDERBY;
    ELSIF KPI_TIMETYPE = '月度' THEN
      V_B  := ' from scmdata.t_rtkpi_month t ';
      V_S1 := '(t.year || ''年'' || lpad(t.month, 2, 0) || ''月'')';
      V_S  := ' select ' || V_S1 || ' total_time,' || V_S2 || V_B || V_B2 ||
              V_WHERE || V_GROUP||V_ORDERBY;
    ELSIF KPI_TIMETYPE = '季度' THEN
      V_B  := ' from scmdata.t_rtkpi_quarter t ';
      V_S1 := '(t.year || ''年第'' || t.quarter || ''季度'')';
      V_S  := ' select ' || V_S1 || ' total_time,' || V_S2 || V_B || V_B2 ||
              V_WHERE || V_GROUP||V_ORDERBY;
    ELSIF KPI_TIMETYPE = '半年度' THEN
      V_B  := ' from scmdata.t_rtkpi_halfyear t ';
      V_S1 := '(t.year || ''年'' || decode(t.halfyear,1,''上'',2,''下'') || ''半年'' )';
      V_S  := ' select ' || V_S1 || ' total_time,' || V_S2 || V_B || V_B2 ||
              V_WHERE || V_GROUP||V_ORDERBY;
    ELSIF KPI_TIMETYPE = '年度' THEN
      V_B  := ' from scmdata.t_rtkpi_year t ';
      V_S1 := '(t.year || ''年'' )';
      V_S  := ' select ' || V_S1 || ' total_time,' || V_S2 || V_B || V_B2 ||
              V_WHERE || V_GROUP||V_ORDERBY;
    END IF;

    ---汇总字段条件
    IF KPI_TIMETYPE = '本月' THEN
      V2_WHERE := ' where to_char(t.rtkpi_date,''yyyy-mm'') = to_char(sysdate,''yyyy-mm'')  ' ||
                  V1_WHERE;
    ELSE
      V2_WHERE := ' where ' || V_S1 || '= ''' || K_TIME || '''' || V1_WHERE;
    END IF;

    ---汇总语句
    VC_SQL1 := q'[select '汇总' total_time,
       ' ' GROUPNAME_N,
       ' ' CLASSIFICATIONS,
]' || V_SORT || '''' || V1_DIMENSION || ''' pid, ''' ||
               q'[' count_dimension,' ' dimension_sort, nvl(sum(t.SHOP_RT_MONEY ),0)/ sum(nullif(t.INGOOD_MONEY, 0)) RT_RATE_PERFOR,
       nvl(sum(t.SHOP_RT_ORIGINAL_MONEY),0) / sum(nullif(t.INGOOD_MONEY, 0)) RT_RATE_ORIGINAL,
       nvl(sum(t.SHOP_RT_ORIGINAL_MONEY),0) / sum(nullif(t.INGOOD_MONEY, 0)) -
       nvl(sum(t.SHOP_RT_MONEY),0) / sum(nullif(t.INGOOD_MONEY, 0)) difference_value ]' || V_B ||
               V2_WHERE;
    ---返回sql
    VC_SQL := VC_SQL1 || q'[
union all
SELECT * FROM (
select total_time,
]' || V_DIMENSION || q'[a.count_dimension,a.dimension_sort,nvl(sum(A.SHOP_RT_MONEY),0) / sum(nullif(A.INGOOD_MONEY, 0)) RT_RATE_PERFOR,
       nvl(sum(A.SHOP_RT_ORIGINAL_MONEY),0) / sum(nullif(A.INGOOD_MONEY, 0)) RT_RATE_ORIGINAL,
       nvl(sum(A.SHOP_RT_ORIGINAL_MONEY),0) / sum(nullif(A.INGOOD_MONEY, 0)) -
       nvl(sum(A.SHOP_RT_MONEY),0) / sum(nullif(A.INGOOD_MONEY, 0))  difference_value
  from ( ]' || V_S||'  ) WHERE DIFFERENCE_VALUE IS NOT NULL ';

    RETURN VC_SQL;

  END F_GET_159_SELECTSQL;

  FUNCTION F_KPI_159_1_CAPTIONSQL(V_STRING VARCHAR2, V_ID VARCHAR2)
    RETURN CLOB IS
    V_GROUP     VARCHAR2(64);
    V1_GROUP    VARCHAR2(64);
    V_CATEGORY  VARCHAR2(32);
    V1_CATEGORY VARCHAR2(32);
    V_DIMENSION VARCHAR2(32);
    V_SORT      VARCHAR2(128);
    V1_SORT     VARCHAR2(128);
    V_SQL       CLOB; --返回值

  BEGIN
    -- v_time      := scmdata.parse_json(v_string, 'COL_1');
    V_GROUP     := SCMDATA.PARSE_JSON(V_STRING, 'COL_2');
    V_CATEGORY  := SCMDATA.PARSE_JSON(V_STRING, 'COL_3');
    V_DIMENSION := SCMDATA.PARSE_JSON(V_STRING, 'COL_4');
    V_SORT      := SCMDATA.PARSE_JSON(V_STRING, 'COL_5');
    IF V_SORT IS NULL THEN
      IF V_CATEGORY = '1' THEN
        V1_CATEGORY := '全部';
      ELSE
        SELECT T.GROUP_DICT_NAME
          INTO V1_CATEGORY
          FROM SCMDATA.SYS_GROUP_DICT T
         WHERE T.GROUP_DICT_TYPE = 'PRODUCT_TYPE'
           AND T.GROUP_DICT_VALUE = V_CATEGORY;
      END IF;
      IF V_GROUP = '1' THEN
        V1_GROUP := '全部';
      ELSE
        SELECT TS.GROUP_NAME
          INTO V1_GROUP
          FROM SCMDATA.T_SUPPLIER_GROUP_CONFIG TS
         WHERE TS.GROUP_CONFIG_ID = V_GROUP;
      END IF;
    ELSE
      IF V_DIMENSION = '00' THEN
        IF V_GROUP = '1' THEN
          V1_GROUP := '全部';
        ELSE
          SELECT TS.GROUP_NAME
            INTO V1_GROUP
            FROM SCMDATA.T_SUPPLIER_GROUP_CONFIG TS
           WHERE TS.GROUP_CONFIG_ID = V_GROUP;
        END IF;
        IF V_SORT = '1' THEN
          V1_CATEGORY := '全部';
        ELSE
          SELECT T.GROUP_DICT_NAME
            INTO V1_CATEGORY
            FROM SCMDATA.SYS_GROUP_DICT T
           WHERE T.GROUP_DICT_TYPE = 'PRODUCT_TYPE'
             AND T.GROUP_DICT_VALUE = V_SORT;
        END IF;
      ELSIF V_DIMENSION = '01' THEN
        IF V_CATEGORY = '1' THEN
          V1_CATEGORY := '全部';
        ELSE
          SELECT T.GROUP_DICT_NAME
            INTO V1_CATEGORY
            FROM SCMDATA.SYS_GROUP_DICT T
           WHERE T.GROUP_DICT_TYPE = 'PRODUCT_TYPE'
             AND T.GROUP_DICT_VALUE = V_CATEGORY;
        END IF;
        IF V_SORT = '1' THEN
          V1_GROUP := '全部';
        ELSE
          SELECT TS.GROUP_NAME
            INTO V1_GROUP
            FROM SCMDATA.T_SUPPLIER_GROUP_CONFIG TS
           WHERE TS.GROUP_CONFIG_ID = V_SORT;
        END IF;
      ELSIF V_DIMENSION NOT IN ('00', '01') THEN
        IF V_CATEGORY = '1' THEN
          V1_CATEGORY := '全部';
        ELSE
          SELECT T.GROUP_DICT_NAME
            INTO V1_CATEGORY
            FROM SCMDATA.SYS_GROUP_DICT T
           WHERE T.GROUP_DICT_TYPE = 'PRODUCT_TYPE'
             AND T.GROUP_DICT_VALUE = V_CATEGORY;
        END IF;
        IF V_GROUP = '1' THEN
          V1_GROUP := '全部';
        ELSE
          SELECT TS.GROUP_NAME
            INTO V1_GROUP
            FROM SCMDATA.T_SUPPLIER_GROUP_CONFIG TS
           WHERE TS.GROUP_CONFIG_ID = V_GROUP;
        END IF;
      END IF;
    END IF;
    IF V_DIMENSION = '02' THEN
      --统计维度：款式名称
      V1_SORT := V_SORT;
    ELSIF V_DIMENSION = '03' THEN
      --统计维度：产品子类
      SELECT MAX(CD.COMPANY_DICT_NAME) SAMLL_CATEGORY
        INTO V1_SORT
        FROM SCMDATA.SYS_GROUP_DICT C
       INNER JOIN SCMDATA.SYS_GROUP_DICT C1
          ON C1.GROUP_DICT_TYPE = C.GROUP_DICT_VALUE
       INNER JOIN SCMDATA.SYS_COMPANY_DICT CD
          ON CD.COMPANY_DICT_TYPE = C1.GROUP_DICT_VALUE
         AND CD.COMPANY_ID = V_ID
       WHERE C.GROUP_DICT_TYPE = 'PRODUCT_TYPE'
         AND CD.COMPANY_DICT_VALUE = V_SORT;
    ELSIF V_DIMENSION = '04' THEN
      --统计维度：供应商
      SELECT MAX(T.SUPPLIER_COMPANY_ABBREVIATION)
        INTO V1_SORT
        FROM SCMDATA.T_SUPPLIER_INFO T
       WHERE T.SUPPLIER_CODE = V_SORT
         AND T.COMPANY_ID = V_ID;

    ELSIF V_DIMENSION IN ('05', '06', '07', '08') THEN
      --统计维度：跟单/跟单主管/QC/QC主管
      SELECT MAX(F.COMPANY_USER_NAME)
        INTO V1_SORT
        FROM SCMDATA.SYS_COMPANY_USER F
       WHERE F.USER_ID = V_SORT
         AND F.COMPANY_ID = V_ID;
    END IF;
    IF V_SORT IS NULL THEN
      IF V_GROUP = '1' AND V_CATEGORY = '1' THEN
        V_SQL := 'select ''' || ' 门店退货率趋势图'' from dual';
      ELSIF V_GROUP = '1' AND V_CATEGORY <> '1' THEN
        V_SQL := 'select ''' || V1_CATEGORY || ' 门店退货率趋势图'' from dual';
      ELSIF V_GROUP <> '1' AND V_CATEGORY = '1' THEN
        V_SQL := 'select ''' || V1_GROUP || ' 门店退货率趋势图'' from dual';
      ELSIF V_GROUP <> '1' AND V_CATEGORY <> '1' THEN
        V_SQL := 'select ''' || V1_GROUP || ',' || V1_CATEGORY ||
                 ' 门店退货率趋势图'' from dual';
      END IF;
    ELSIF V1_SORT IS NULL AND V_DIMENSION = '05' THEN
      IF V_GROUP = '1' AND V_CATEGORY = '1' THEN
        V_SQL := 'select ''' || ' 跟单为空 门店退货率趋势图'' from dual';
      ELSIF V_GROUP = '1' AND V_CATEGORY <> '1' THEN
        V_SQL := 'select ''' || V1_CATEGORY || ' 跟单为空 门店退货率趋势图'' from dual';
      ELSIF V_GROUP <> '1' AND V_CATEGORY = '1' THEN
        V_SQL := 'select ''' || V1_GROUP || ' 跟单为空 门店退货率趋势图'' from dual';
      ELSIF V_GROUP <> '1' AND V_CATEGORY <> '1' THEN
        V_SQL := 'select ''' || V1_GROUP || ',' || V1_CATEGORY ||
                 ' 跟单为空 门店退货率趋势图'' from dual';
      END IF;
    ELSIF V1_SORT IS NULL AND V_DIMENSION = '06' THEN
      IF V_GROUP = '1' AND V_CATEGORY = '1' THEN
        V_SQL := 'select ''' || ' 跟单主管为空 门店退货率趋势图'' from dual';
      ELSIF V_GROUP = '1' AND V_CATEGORY <> '1' THEN
        V_SQL := 'select ''' || V1_CATEGORY ||
                 ' 跟单主管为空 门店退货率趋势图'' from dual';
      ELSIF V_GROUP <> '1' AND V_CATEGORY = '1' THEN
        V_SQL := 'select ''' || V1_GROUP || ' 跟单主管为空 门店退货率趋势图'' from dual';
      ELSIF V_GROUP <> '1' AND V_CATEGORY <> '1' THEN
        V_SQL := 'select ''' || V1_GROUP || ',' || V1_CATEGORY ||
                 ' 跟单主管为空 门店退货率趋势图'' from dual';
      END IF;
    ELSIF V1_SORT IS NULL AND V_DIMENSION = '07' THEN
      IF V_GROUP = '1' AND V_CATEGORY = '1' THEN
        V_SQL := 'select ''' || ' QC为空 门店退货率趋势图'' from dual';
      ELSIF V_GROUP = '1' AND V_CATEGORY <> '1' THEN
        V_SQL := 'select ''' || V1_CATEGORY || ' QC为空 门店退货率趋势图'' from dual';
      ELSIF V_GROUP <> '1' AND V_CATEGORY = '1' THEN
        V_SQL := 'select ''' || V1_GROUP || ' QC为空 门店退货率趋势图'' from dual';
      ELSIF V_GROUP <> '1' AND V_CATEGORY <> '1' THEN
        V_SQL := 'select ''' || V1_GROUP || ',' || V1_CATEGORY ||
                 ' QC为空 门店退货率趋势图'' from dual';
      END IF;
    ELSIF V1_SORT IS NULL AND V_DIMENSION = '08' THEN
      IF V_GROUP = '1' AND V_CATEGORY = '1' THEN
        V_SQL := 'select ''' || 'QC主管为空 门店退货率趋势图'' from dual';
      ELSIF V_GROUP = '1' AND V_CATEGORY <> '1' THEN
        V_SQL := 'select ''' || V1_CATEGORY ||
                 'QC主管为空 门店退货率趋势图'' from dual';
      ELSIF V_GROUP <> '1' AND V_CATEGORY = '1' THEN
        V_SQL := 'select ''' || V1_GROUP || 'QC主管为空 门店退货率趋势图'' from dual';
      ELSIF V_GROUP <> '1' AND V_CATEGORY <> '1' THEN
        V_SQL := 'select ''' || V1_GROUP || ',' || V1_CATEGORY ||
                 'QC主管为空 门店退货率趋势图'' from dual';
      END IF;
    ELSIF V_DIMENSION = '00' THEN
      IF V_GROUP = '1' THEN
        V_SQL := 'select ''' || V1_CATEGORY || ' 门店退货率趋势图'' from dual';
      ELSE
        V_SQL := 'select ''' || V1_GROUP || ',' || V1_CATEGORY ||
                 ' 门店退货率趋势图'' from dual';
      END IF;
    ELSIF V_DIMENSION = '01' THEN
      IF V_CATEGORY = '1' THEN
        V_SQL := 'select ''' || V1_GROUP || ' 门店退货率趋势图'' from dual';
      ELSE
        V_SQL := 'select ''' || V1_GROUP || ',' || V1_CATEGORY ||
                 ' 门店退货率趋势图'' from dual';
      END IF;
    ELSE
      IF V_GROUP = '1' AND V_CATEGORY = '1' THEN
        V_SQL := 'select ''' || V1_SORT || ' 门店退货率趋势图'' from dual';
      ELSIF V_GROUP = '1' AND V_CATEGORY <> '1' THEN
        V_SQL := 'select ''' || V1_CATEGORY || ',' || V1_SORT ||
                 ' 门店退货率趋势图'' from dual';
      ELSIF V_GROUP <> '1' AND V_CATEGORY = '1' THEN
        V_SQL := 'select ''' || V1_GROUP || ',' || V1_SORT ||
                 ' 门店退货率趋势图'' from dual';
      ELSIF V_GROUP <> '1' AND V_CATEGORY <> '1' THEN
        V_SQL := 'select ''' || V1_GROUP || ',' || V1_CATEGORY || ',' ||
                 V1_SORT || ' 门店退货率趋势图'' from dual';
      END IF;
    END IF;
    RETURN V_SQL;
  END F_KPI_159_1_CAPTIONSQL;

  FUNCTION F_KPI_159_1_SELECTSQL(V_TIME       VARCHAR2,
                              V_DIMENSION  VARCHAR2,
                              V_SORT       VARCHAR2,
                              V_GROUP      VARCHAR2,
                              V_CATEGORY   VARCHAR2,
                              V_COMPANY_ID VARCHAR2) RETURN CLOB IS
   V_SQL      CLOB;
   V_WHERE    CLOB;
   V1_WHERE   CLOB;
   V1_TIME    VARCHAR2(128);
   V_F        VARCHAR2(128);
   V_S        VARCHAR2(128);
   V_C        CLOB;
   V_MAX_DATE VARCHAR2(32);
   V_MIN_DATE VARCHAR2(32);
 BEGIN
   V_WHERE := ' where t.company_id = ''' || V_COMPANY_ID || '''';
   --过滤条件：分部
   CASE
     WHEN V_CATEGORY = '1' THEN
       V_WHERE := V_WHERE || ' and 1 = 1 ';
     ELSE
       V_WHERE := V_WHERE || ' and t.category = ''' || V_CATEGORY || ''' ';
   END CASE;
   --过滤条件：区域组
   CASE
     WHEN V_GROUP = '1' THEN
       V_WHERE := V_WHERE || ' and 1 = 1 ';
     ELSE
       V_WHERE := V_WHERE || ' and t.groupname = ''' || V_GROUP || ''' ';
   END CASE;
   --统计维度过滤
   IF V_SORT IS NULL THEN
     V_WHERE := V_WHERE || ' and t.count_dimension = '''|| V_DIMENSION ||'''';
   ELSIF  V_DIMENSION in ('05','06','07','08') then
     IF V_SORT = '1' THEN
     V_WHERE := V_WHERE || ' and t.count_dimension = '''|| V_DIMENSION ||''' and t.dimension_sort = ''1''';
     ELSE
     V_WHERE := V_WHERE || ' and t.count_dimension = '''|| V_DIMENSION ||''' and t.dimension_sort = ''' || V_SORT || '''';
     END IF;
   ELSE
     V_WHERE := V_WHERE || ' and t.count_dimension = '''|| V_DIMENSION ||''' and t.dimension_sort = ''' || V_SORT || '''';
   END IF;

   --时间维度
   IF SUBSTR(V_TIME,5,1) = '-' THEN
     V1_TIME    := TO_CHAR(SYSDATE, 'yyyy') || '年' || TO_CHAR(SYSDATE, 'mm') || '月';
     V_C        := SCMDATA.PKG_KPIPT_ORDER.F_KPI_MONTH(TOTAL_TIME => V1_TIME);
     V_MAX_DATE := SCMDATA.PARSE_JSON(V_C, 'COL_1');
     V_MIN_DATE := SCMDATA.PARSE_JSON(V_C, 'COL_2');
     V_SQL      := q'[ select total_time,
       (sum(t1.SHOP_RT_MONEY) / sum(nullif(t1.INGOOD_MONEY, 0))) * 100 RT_RATE_PERFOR,
       (sum(t1.SHOP_RT_ORIGINAL_MONEY) / sum(nullif(t1.INGOOD_MONEY, 0))) * 100 RT_RATE_ORIGINAL
  from (select to_char(t.rtkpi_date, 'yyyy') || '年' || to_char(t.rtkpi_date, 'mm') || '月' total_time,
               t.category, t.groupname, t.count_dimension, t.dimension_sort, t.INGOOD_MONEY,
               t.SHOP_RT_MONEY, t.SHOP_RT_ORIGINAL_MONEY
          from scmdata.t_rtkpi_thismonth t ]' || v_where || q'[
           and to_char(t.rtkpi_date, 'yyyy-mm') = to_char(sysdate, 'yyyy-mm')
        union all
        select t.year || '年' || lpad(t.month, 2, 0) || '月' total_time,
               t.category, t.groupname, t.count_dimension, t.dimension_sort, t.INGOOD_MONEY,
               t.SHOP_RT_MONEY, t.SHOP_RT_ORIGINAL_MONEY
          from scmdata.t_rtkpi_month t ]' || v_where || q'[
           and t.year || lpad(t.month, 2, 0) > ']' ||
                   v_min_date || q'['
           and t.year || lpad(t.month, 2, 0) <= ']' ||
                   v_max_date || q'[') t1
 group by total_time
 order by total_time ]';
   ELSE
     IF SUBSTR(V_TIME, -1) = '月' THEN
       V_C := SCMDATA.PKG_KPIPT_ORDER.F_KPI_MONTH(TOTAL_TIME => V_TIME);
       V_S := ' t.year||lpad(t.month, 2, 0) total_date,(t.year || ''年'' || lpad(t.month, 2, 0) || ''月'') ';
       V_F := ' from scmdata.t_rtkpi_month t';
     ELSIF SUBSTR(V_TIME, -2) = '季度' THEN
       V_C := SCMDATA.PKG_KPIPT_ORDER.F_KPI_QUARTER(TOTAL_TIME => V_TIME);
       V_S := ' t.year|| t.quarter total_date,(t.year || ''年第'' || t.quarter || ''季度'') ';
       V_F := ' from scmdata.t_rtkpi_quarter t';
     ELSIF SUBSTR(V_TIME, -2) = '半年' THEN
       V_C := SCMDATA.PKG_KPIPT_ORDER.F_KPI_HALFYEAR(TOTAL_TIME => V_TIME);
       V_S := 't.year||t.halfyear total_date,(t.year || ''年'' ||  decode(t.halfyear,1,''上'',2,''下'')  || ''半年'') ';
       V_F := ' from scmdata.t_rtkpi_halfyear t';
     ELSIF LENGTH(V_TIME) = '5' THEN
       V_C := SCMDATA.PKG_KPIPT_ORDER.F_KPI_YEAR(TOTAL_TIME => V_TIME);
       V_S := ' t.year total_date,(t.year || ''年'') ';
       V_F := ' from scmdata.t_rtkpi_year t';
     END IF;
     V_MAX_DATE := SCMDATA.PARSE_JSON(V_C, 'COL_1');
     V_MIN_DATE := SCMDATA.PARSE_JSON(V_C, 'COL_2');
     V1_WHERE   := ' where total_date >= ''' || V_MIN_DATE ||
                   ''' and total_date <= ''' || V_MAX_DATE || ''' ';
     V_SQL      := 'select total_time,total_date,
       (sum(t1.SHOP_RT_MONEY) / sum(nullif(t1.INGOOD_MONEY, 0)))*100 RT_RATE_PERFOR,
       (sum(t1.SHOP_RT_ORIGINAL_MONEY) / sum(nullif(t1.INGOOD_MONEY, 0)))*100 RT_RATE_ORIGINAL
  from ( select ' || v_s ||
                   'total_time,t.category,t.groupname,t.count_dimension,t.dimension_sort,t.INGOOD_MONEY,
            t.SHOP_RT_MONEY,t.SHOP_RT_ORIGINAL_MONEY' || v_f ||
                   v_where || ' ) t1 ' || v1_where || '
 group by total_time,total_date
 order by total_time';
   END IF;
   RETURN V_SQL;
 END F_KPI_159_1_SELECTSQL;

  PROCEDURE P_GET_RTDATA
  IS
  v_seal_day NUMBER;
  v_day DATE;
  BEGIN
    v_seal_day:=scmdata.pkg_db_job.f_get_seal_date(p_rtn_type => 0);

    SELECT TRUNC(SYSDATE,'mm') + v_seal_day INTO v_day
      FROM dual;

      IF TRUNC(SYSDATE,'dd') =  v_day    THEN
        --月度
        scmdata.pkg_kpireturn_rate.P_RTKPI_MONTH(P_TYPE => 1);


        IF to_char(SYSDATE,'mm') = '01' THEN
          --年度
          scmdata.pkg_kpireturn_rate.P_RTKPI_YEAR(P_TYPE => 1);
          --季度
          scmdata.pkg_kpireturn_rate.P_RTKPI_QUARTER(P_TYPE => 1);
          --半年度
          scmdata.pkg_kpireturn_rate.P_RTKPI_HALFYEAR(P_TYPE => 1);
        END IF;

        IF to_char(SYSDATE,'mm') IN ('04','10') THEN
          --季度
          scmdata.pkg_kpireturn_rate.P_RTKPI_QUARTER(P_TYPE => 1);
        END IF;

        IF to_char(SYSDATE,'mm') = '07' THEN
          --季度
          scmdata.pkg_kpireturn_rate.P_RTKPI_QUARTER(P_TYPE => 1);
          --半年度
          scmdata.pkg_kpireturn_rate.P_RTKPI_HALFYEAR(P_TYPE => 1);
        END IF;
    ELSE
      NULL;
    END IF;
END P_GET_RTDATA;


END PKG_KPIRETURN_RATE;
/

