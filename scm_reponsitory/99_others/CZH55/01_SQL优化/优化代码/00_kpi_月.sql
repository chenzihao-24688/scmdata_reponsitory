MERGE INTO SCMDATA.T_RTKPI_MONTH A
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
                       SUM(B.AMOUNT * E.PRICE) ORDER_MONEY
                  FROM SCMDATA.T_INGOOD A
                 INNER JOIN SCMDATA.T_INGOODS B
                    ON A.ING_ID = B.ING_ID
                   AND A.COMPANY_ID = B.COMPANY_ID
                 LEFT JOIN SCMDATA.T_ORDERED C
                    ON C.ORDER_CODE = A.DOCUMENT_NO
                   AND A.COMPANY_ID = C.COMPANY_ID
                 LEFT JOIN SCMDATA.PT_ORDERED D
                    ON D.ORDER_ID = C.ORDER_ID
                   AND D.COMPANY_ID = C.COMPANY_ID
                   INNER JOIN SCMDATA.T_COMMODITY_INFO E ON E.GOO_ID=B.GOO_ID AND E.COMPANY_ID=B.COMPANY_ID
                 WHERE B.AMOUNT > 0
                 GROUP BY A.COMPANY_ID, EXTRACT(YEAR FROM A.CREATE_TIME),
                          EXTRACT(MONTH FROM A.CREATE_TIME), E.CATEGORY,
                          D.GROUP_NAME ) Y 
      where (y.year||lpad(y.month,2,0)) = to_char(add_months(sysdate,-1),'yyyymm')
        ) tkb
      ON (tkb.company_id = a.company_id AND tkb.year = a.year AND tkb.month=a.month  AND tkb.category=a.category
           AND tkb.group_name = a.groupname AND tkb.count_dimension =a.count_dimension AND tkb.dimension_sort =a.dimension_sort  )
           when matched then  update
                           set a.INGOOD_MONEY           =tkb.INGOOD_MONEY,
                               a.update_id              = 'ADMIN',
                               a.update_time            = sysdate
                 
    WHEN NOT MATCHED THEN
      INSERT
        (A.T_RTKPI_M_ID, A.COMPANY_ID, A.YEAR, A.MONTH, A.CATEGORY, A.GROUPNAME, A.COUNT_DIMENSION, A.DIMENSION_SORT, A.INGOOD_MONEY, A.CREATE_ID, A.CREATE_TIME, A.UPDATE_ID, A.UPDATE_TIME)
      VALUES
        (SCMDATA.F_GET_UUID(), TKB.COMPANY_ID, TKB.YEAR, TKB.MONTH, TKB.CATEGORY, TKB.GROUP_NAME,  TKB.COUNT_DIMENSION, TKB.DIMENSION_SORT,TKB.INGOOD_MONEY, 'ADMIN', SYSDATE, 'ADMIN', SYSDATE)
 

MERGE INTO SCMDATA.T_RTKPI_MONTH A
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
          AND Z.DIMENSION_SORT = Y.DIMENSION_SORT*/ 
      where (y.year||lpad(y.month,2,0)) = to_char(add_months(sysdate,-1),'yyyymm')
        ) tkb
      ON (tkb.company_id = a.company_id AND tkb.year = a.year AND tkb.month=a.month  AND tkb.category=a.category
           AND tkb.group_name = a.groupname AND tkb.count_dimension =a.count_dimension AND tkb.dimension_sort =a.dimension_sort  )
           when matched then  update
                           set a.SHOP_RT_MONEY          = tkb.SHOP_RT_MONEY,
                               a.SHOP_RT_ORIGINAL_MONEY = tkb.SHOP_RT_ORIGINAL_MONEY,
                               a.update_id              = 'ADMIN',
                               a.update_time            = sysdate
                 
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
         'ADMIN',sysdate,'ADMIN',sysdate) 
MERGE INTO SCMDATA.T_RTKPI_MONTH A
             USING ( SELECT  Y.COMPANY_ID,Y.YEAR,Y.MONTH,Y.CATEGORY,Y.GROUP_NAME,Y.COUNT_DIMENSION,Y.DIMENSION_SORT,Y.ORDER_MONEY INGOOD_MONEY
                 FROM (SELECT A.COMPANY_ID,
       EXTRACT(YEAR FROM A.CREATE_TIME) YEAR,
       EXTRACT(MONTH FROM A.CREATE_TIME) MONTH,
       E.CATEGORY,
       (CASE WHEN D.GROUP_NAME IS NULL THEN  '1'  ELSE D.GROUP_NAME END) GROUP_NAME,
       '01' COUNT_DIMENSION,
       (CASE WHEN D.GROUP_NAME IS NULL THEN  '1'  ELSE D.GROUP_NAME END) DIMENSION_SORT,
       SUM(B.AMOUNT * E.PRICE) ORDER_MONEY
  FROM SCMDATA.T_INGOOD A
 INNER JOIN SCMDATA.T_INGOODS B
    ON A.ING_ID = B.ING_ID
   AND A.COMPANY_ID = B.COMPANY_ID
 LEFT JOIN SCMDATA.T_ORDERED C
    ON C.ORDER_CODE = A.DOCUMENT_NO
   AND A.COMPANY_ID = C.COMPANY_ID
 LEFT JOIN SCMDATA.PT_ORDERED D
    ON D.ORDER_ID = C.ORDER_ID
   AND D.COMPANY_ID = C.COMPANY_ID
   INNER JOIN SCMDATA.T_COMMODITY_INFO E ON E.GOO_ID=B.GOO_ID AND E.COMPANY_ID=B.COMPANY_ID
 WHERE B.AMOUNT > 0
 GROUP BY A.COMPANY_ID,
          EXTRACT(YEAR FROM A.CREATE_TIME),
          EXTRACT(MONTH FROM A.CREATE_TIME),
          E.CATEGORY,
          D.GROUP_NAME) Y
    
      where (y.year||lpad(y.month,2,0)) = to_char(add_months(sysdate,-1),'yyyymm')
        ) tkb
      ON (tkb.company_id = a.company_id AND tkb.year = a.year AND tkb.month=a.month  AND tkb.category=a.category
           AND tkb.group_name = a.groupname AND tkb.count_dimension =a.count_dimension AND tkb.dimension_sort =a.dimension_sort  )
           when matched then  update
                           set a.INGOOD_MONEY           =tkb.INGOOD_MONEY,
                               a.update_id              = 'ADMIN',
                               a.update_time            = sysdate
                 
    WHEN NOT MATCHED THEN
      INSERT
        (A.T_RTKPI_M_ID, A.COMPANY_ID, A.YEAR, A.MONTH, A.CATEGORY, A.GROUPNAME, A.COUNT_DIMENSION, A.DIMENSION_SORT, A.INGOOD_MONEY, A.CREATE_ID, A.CREATE_TIME, A.UPDATE_ID, A.UPDATE_TIME)
      VALUES
        (SCMDATA.F_GET_UUID(), TKB.COMPANY_ID, TKB.YEAR, TKB.MONTH, TKB.CATEGORY, TKB.GROUP_NAME,  TKB.COUNT_DIMENSION, TKB.DIMENSION_SORT,TKB.INGOOD_MONEY, 'ADMIN', SYSDATE, 'ADMIN', SYSDATE)
 
MERGE INTO SCMDATA.T_RTKPI_MONTH A
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
          AND Z.DIMENSION_SORT = Y.DIMENSION_SORT */ 
      where (y.year||lpad(y.month,2,0)) = to_char(add_months(sysdate,-1),'yyyymm')
        ) tkb
      ON (tkb.company_id = a.company_id AND tkb.year = a.year AND tkb.month=a.month  AND tkb.category=a.category
           AND tkb.group_name = a.groupname AND tkb.count_dimension =a.count_dimension AND tkb.dimension_sort =a.dimension_sort  )
           when matched then  update
                           set a.SHOP_RT_MONEY          = tkb.SHOP_RT_MONEY,
                               a.SHOP_RT_ORIGINAL_MONEY = tkb.SHOP_RT_ORIGINAL_MONEY,
                               a.update_id              = 'ADMIN',
                               a.update_time            = sysdate
                 
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
         'ADMIN',sysdate,'ADMIN',sysdate) 
 MERGE INTO SCMDATA.T_RTKPI_MONTH A
             USING ( SELECT  Y.COMPANY_ID,Y.YEAR,Y.MONTH,Y.CATEGORY,Y.GROUP_NAME,Y.COUNT_DIMENSION,Y.DIMENSION_SORT,Y.ORDER_MONEY INGOOD_MONEY
                 FROM (SELECT A.COMPANY_ID,
       EXTRACT(YEAR FROM A.CREATE_TIME) YEAR,
       EXTRACT(MONTH FROM A.CREATE_TIME) MONTH,
       E.CATEGORY,
       (CASE WHEN D.GROUP_NAME IS NULL THEN  '1'  ELSE D.GROUP_NAME END) GROUP_NAME,
       '02' COUNT_DIMENSION,
       E.STYLE_NAME DIMENSION_SORT,
       SUM(B.AMOUNT * E.PRICE) ORDER_MONEY
  FROM SCMDATA.T_INGOOD A
 INNER JOIN SCMDATA.T_INGOODS B
    ON A.ING_ID = B.ING_ID
   AND A.COMPANY_ID = B.COMPANY_ID
 LEFT JOIN SCMDATA.T_ORDERED C
    ON C.ORDER_CODE = A.DOCUMENT_NO
   AND A.COMPANY_ID = C.COMPANY_ID
 LEFT JOIN SCMDATA.PT_ORDERED D
    ON D.ORDER_ID = C.ORDER_ID
   AND D.COMPANY_ID = C.COMPANY_ID
  INNER JOIN SCMDATA.T_COMMODITY_INFO E ON E.GOO_ID=B.GOO_ID AND E.COMPANY_ID=B.COMPANY_ID
 WHERE B.AMOUNT > 0
 GROUP BY A.COMPANY_ID,
          EXTRACT(YEAR FROM A.CREATE_TIME),
          EXTRACT(MONTH FROM A.CREATE_TIME),
          E.CATEGORY,
          D.GROUP_NAME,
          E.STYLE_NAME) Y      
      where (y.year||lpad(y.month,2,0)) = to_char(add_months(sysdate,-1),'yyyymm')
        ) tkb
      ON (tkb.company_id = a.company_id AND tkb.year = a.year AND tkb.month=a.month  AND tkb.category=a.category
           AND tkb.group_name = a.groupname AND tkb.count_dimension =a.count_dimension AND tkb.dimension_sort =a.dimension_sort  )
           when matched then  update
                           set a.INGOOD_MONEY           =tkb.INGOOD_MONEY,
                               a.update_id              = 'ADMIN',
                               a.update_time            = sysdate
                 
    WHEN NOT MATCHED THEN
      INSERT
        (A.T_RTKPI_M_ID, A.COMPANY_ID, A.YEAR, A.MONTH, A.CATEGORY, A.GROUPNAME, A.COUNT_DIMENSION, A.DIMENSION_SORT, A.INGOOD_MONEY, A.CREATE_ID, A.CREATE_TIME, A.UPDATE_ID, A.UPDATE_TIME)
      VALUES
        (SCMDATA.F_GET_UUID(), TKB.COMPANY_ID, TKB.YEAR, TKB.MONTH, TKB.CATEGORY, TKB.GROUP_NAME,  TKB.COUNT_DIMENSION, TKB.DIMENSION_SORT,TKB.INGOOD_MONEY, 'ADMIN', SYSDATE, 'ADMIN', SYSDATE)
 
MERGE INTO SCMDATA.T_RTKPI_MONTH A
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
          AND Z.DIMENSION_SORT = Y.DIMENSION_SORT*/ 
      where (y.year||lpad(y.month,2,0)) = to_char(add_months(sysdate,-1),'yyyymm')
        ) tkb
      ON (tkb.company_id = a.company_id AND tkb.year = a.year AND tkb.month=a.month  AND tkb.category=a.category
           AND tkb.group_name = a.groupname AND tkb.count_dimension =a.count_dimension AND tkb.dimension_sort =a.dimension_sort  )
           when matched then  update
                           set a.SHOP_RT_MONEY          = tkb.SHOP_RT_MONEY,
                               a.SHOP_RT_ORIGINAL_MONEY = tkb.SHOP_RT_ORIGINAL_MONEY,
                               a.update_id              = 'ADMIN',
                               a.update_time            = sysdate
                 
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
         'ADMIN',sysdate,'ADMIN',sysdate) 
 MERGE INTO SCMDATA.T_RTKPI_MONTH A
             USING ( SELECT  Y.COMPANY_ID,Y.YEAR,Y.MONTH,Y.CATEGORY,Y.GROUP_NAME,Y.COUNT_DIMENSION,Y.DIMENSION_SORT,Y.ORDER_MONEY INGOOD_MONEY
                 FROM  (SELECT A.COMPANY_ID,
       EXTRACT(YEAR FROM A.CREATE_TIME) YEAR,
       EXTRACT(MONTH FROM A.CREATE_TIME) MONTH,
       E.CATEGORY,
       (CASE WHEN D.GROUP_NAME IS NULL THEN  '1'  ELSE D.GROUP_NAME END) GROUP_NAME,
       '03' COUNT_DIMENSION,
       E.SAMLL_CATEGORY DIMENSION_SORT,
       SUM(B.AMOUNT * E.PRICE) ORDER_MONEY
  FROM SCMDATA.T_INGOOD A
 INNER JOIN SCMDATA.T_INGOODS B
    ON A.ING_ID = B.ING_ID
   AND A.COMPANY_ID = B.COMPANY_ID
 LEFT JOIN SCMDATA.T_ORDERED C
    ON C.ORDER_CODE = A.DOCUMENT_NO
   AND A.COMPANY_ID = C.COMPANY_ID
 LEFT JOIN SCMDATA.PT_ORDERED D
    ON D.ORDER_ID = C.ORDER_ID
   AND D.COMPANY_ID = C.COMPANY_ID
  INNER JOIN SCMDATA.T_COMMODITY_INFO E ON E.GOO_ID=B.GOO_ID AND E.COMPANY_ID=B.COMPANY_ID
 WHERE B.AMOUNT > 0
 GROUP BY A.COMPANY_ID,
          EXTRACT(YEAR FROM A.CREATE_TIME),
          EXTRACT(MONTH FROM A.CREATE_TIME),
          E.CATEGORY,
          D.GROUP_NAME,
          E.SAMLL_CATEGORY) Y
    
      where (y.year||lpad(y.month,2,0)) = to_char(add_months(sysdate,-1),'yyyymm')
        ) tkb
      ON (tkb.company_id = a.company_id AND tkb.year = a.year AND tkb.month=a.month  AND tkb.category=a.category
           AND tkb.group_name = a.groupname AND tkb.count_dimension =a.count_dimension AND tkb.dimension_sort =a.dimension_sort  )
           when matched then  update
                           set a.INGOOD_MONEY           =tkb.INGOOD_MONEY,
                               a.update_id              = 'ADMIN',
                               a.update_time            = sysdate
                 
    WHEN NOT MATCHED THEN
      INSERT
        (A.T_RTKPI_M_ID, A.COMPANY_ID, A.YEAR, A.MONTH, A.CATEGORY, A.GROUPNAME, A.COUNT_DIMENSION, A.DIMENSION_SORT, A.INGOOD_MONEY, A.CREATE_ID, A.CREATE_TIME, A.UPDATE_ID, A.UPDATE_TIME)
      VALUES
        (SCMDATA.F_GET_UUID(), TKB.COMPANY_ID, TKB.YEAR, TKB.MONTH, TKB.CATEGORY, TKB.GROUP_NAME,  TKB.COUNT_DIMENSION, TKB.DIMENSION_SORT,TKB.INGOOD_MONEY, 'ADMIN', SYSDATE, 'ADMIN', SYSDATE)
 
MERGE INTO SCMDATA.T_RTKPI_MONTH A
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
          AND Z.DIMENSION_SORT = Y.DIMENSION_SORT*/  
      where (y.year||lpad(y.month,2,0)) = to_char(add_months(sysdate,-1),'yyyymm')
        ) tkb
      ON (tkb.company_id = a.company_id AND tkb.year = a.year AND tkb.month=a.month  AND tkb.category=a.category
           AND tkb.group_name = a.groupname AND tkb.count_dimension =a.count_dimension AND tkb.dimension_sort =a.dimension_sort  )
           when matched then  update
                           set a.SHOP_RT_MONEY          = tkb.SHOP_RT_MONEY,
                               a.SHOP_RT_ORIGINAL_MONEY = tkb.SHOP_RT_ORIGINAL_MONEY,
                               a.update_id              = 'ADMIN',
                               a.update_time            = sysdate
                 
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
         'ADMIN',sysdate,'ADMIN',sysdate) 
MERGE INTO SCMDATA.T_RTKPI_MONTH A
             USING ( SELECT  Y.COMPANY_ID,Y.YEAR,Y.MONTH,Y.CATEGORY,Y.GROUP_NAME,Y.COUNT_DIMENSION,Y.DIMENSION_SORT,Y.ORDER_MONEY INGOOD_MONEY
                 FROM ( SELECT A.COMPANY_ID,
       EXTRACT(YEAR FROM A.CREATE_TIME) YEAR,
       EXTRACT(MONTH FROM A.CREATE_TIME) MONTH,
       E.CATEGORY,
       (CASE WHEN D.GROUP_NAME IS NULL THEN  '1'  ELSE D.GROUP_NAME END) GROUP_NAME,
       '04' COUNT_DIMENSION,
       A.SUPPLIER_CODE DIMENSION_SORT,
       SUM(B.AMOUNT * E.PRICE) ORDER_MONEY
  FROM SCMDATA.T_INGOOD A
 INNER JOIN SCMDATA.T_INGOODS B
    ON A.ING_ID = B.ING_ID
   AND A.COMPANY_ID = B.COMPANY_ID
 LEFT JOIN SCMDATA.T_ORDERED C
    ON C.ORDER_CODE = A.DOCUMENT_NO
   AND A.COMPANY_ID = C.COMPANY_ID
 LEFT JOIN SCMDATA.PT_ORDERED D
    ON D.ORDER_ID = C.ORDER_ID
   AND D.COMPANY_ID = C.COMPANY_ID
  INNER JOIN SCMDATA.T_COMMODITY_INFO E ON E.GOO_ID=B.GOO_ID AND E.COMPANY_ID=B.COMPANY_ID
 WHERE B.AMOUNT > 0
 GROUP BY A.COMPANY_ID,
          EXTRACT(YEAR FROM A.CREATE_TIME),
          EXTRACT(MONTH FROM A.CREATE_TIME),
          E.CATEGORY,
          D.GROUP_NAME,
          A.SUPPLIER_CODE) Y 
      where (y.year||lpad(y.month,2,0)) = to_char(add_months(sysdate,-1),'yyyymm')
        ) tkb
      ON (tkb.company_id = a.company_id AND tkb.year = a.year AND tkb.month=a.month  AND tkb.category=a.category
           AND tkb.group_name = a.groupname AND tkb.count_dimension =a.count_dimension AND tkb.dimension_sort =a.dimension_sort  )
           when matched then  update
                           set a.INGOOD_MONEY           =tkb.INGOOD_MONEY,
                               a.update_id              = 'ADMIN',
                               a.update_time            = sysdate
                 
    WHEN NOT MATCHED THEN
      INSERT
        (A.T_RTKPI_M_ID, A.COMPANY_ID, A.YEAR, A.MONTH, A.CATEGORY, A.GROUPNAME, A.COUNT_DIMENSION, A.DIMENSION_SORT, A.INGOOD_MONEY, A.CREATE_ID, A.CREATE_TIME, A.UPDATE_ID, A.UPDATE_TIME)
      VALUES
        (SCMDATA.F_GET_UUID(), TKB.COMPANY_ID, TKB.YEAR, TKB.MONTH, TKB.CATEGORY, TKB.GROUP_NAME,  TKB.COUNT_DIMENSION, TKB.DIMENSION_SORT,TKB.INGOOD_MONEY, 'ADMIN', SYSDATE, 'ADMIN', SYSDATE)
 
 MERGE INTO SCMDATA.T_RTKPI_MONTH A
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
          AND Z.DIMENSION_SORT = Y.DIMENSION_SORT */
      where (y.year||lpad(y.month,2,0)) = to_char(add_months(sysdate,-1),'yyyymm')
        ) tkb
      ON (tkb.company_id = a.company_id AND tkb.year = a.year AND tkb.month=a.month  AND tkb.category=a.category
           AND tkb.group_name = a.groupname AND tkb.count_dimension =a.count_dimension AND tkb.dimension_sort =a.dimension_sort  )
           when matched then  update
                           set a.SHOP_RT_MONEY          = tkb.SHOP_RT_MONEY,
                               a.SHOP_RT_ORIGINAL_MONEY = tkb.SHOP_RT_ORIGINAL_MONEY,
                               a.update_id              = 'ADMIN',
                               a.update_time            = sysdate
                 
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
         'ADMIN',sysdate,'ADMIN',sysdate) 
 MERGE INTO SCMDATA.T_RTKPI_MONTH A
             USING ( SELECT  Y.COMPANY_ID,Y.YEAR,Y.MONTH,Y.CATEGORY,Y.GROUP_NAME,Y.COUNT_DIMENSION,
             Y.DIMENSION_SORT,
             Y.ORDER_MONEY INGOOD_MONEY
                 FROM   (SELECT A.COMPANY_ID, EXTRACT(YEAR FROM A.CREATE_TIME) YEAR,
                    EXTRACT(MONTH FROM A.CREATE_TIME) MONTH,
                    E.CATEGORY,
                    (CASE WHEN D.GROUP_NAME IS NULL THEN  '1'    ELSE    D.GROUP_NAME    END) GROUP_NAME, '05' COUNT_DIMENSION,
                    (CASE WHEN D.GENDAN IS NULL OR D.GENDAN = 'ORDERED_ITF' THEN '1' ELSE D.GENDAN  END) DIMENSION_SORT,
                    SUM(CASE  WHEN REGEXP_COUNT(D.FLW_ORDER, ',') > 0 THEN
                           B.AMOUNT / NVL((REGEXP_COUNT(D.FLW_ORDER, ',') + 1),1) *
                           E.PRICE
                          ELSE
                           B.AMOUNT * E.PRICE
                        END) ORDER_MONEY
               FROM SCMDATA.T_INGOOD A
              INNER JOIN SCMDATA.T_INGOODS B
                 ON A.ING_ID = B.ING_ID
                AND A.COMPANY_ID = B.COMPANY_ID
              LEFT JOIN SCMDATA.T_ORDERED C
                 ON C.ORDER_CODE = A.DOCUMENT_NO
                AND A.COMPANY_ID = C.COMPANY_ID
              LEFT JOIN (SELECT Z.*, REGEXP_SUBSTR(Z.FLW_ORDER, '[^,]+', 1, LEVEL) GENDAN
                           FROM SCMDATA.PT_ORDERED Z
                         CONNECT BY PRIOR Z.PT_ORDERED_ID = Z.PT_ORDERED_ID
                                AND LEVEL <= LENGTH(Z.FLW_ORDER) -
                                    LENGTH(REGEXP_REPLACE(Z.FLW_ORDER, ',', '')) + 1
                                AND PRIOR DBMS_RANDOM.VALUE IS NOT NULL) D
                 ON D.ORDER_ID = C.ORDER_ID
                AND D.COMPANY_ID = C.COMPANY_ID
                 INNER JOIN SCMDATA.T_COMMODITY_INFO E ON E.GOO_ID=B.GOO_ID AND E.COMPANY_ID=B.COMPANY_ID
              WHERE B.AMOUNT > 0
              GROUP BY A.COMPANY_ID, EXTRACT(YEAR FROM A.CREATE_TIME),
                       EXTRACT(MONTH FROM A.CREATE_TIME), E.CATEGORY,
                       D.GROUP_NAME, 
                       (CASE WHEN D.GENDAN IS NULL OR D.GENDAN = 'ORDERED_ITF' THEN '1'  ELSE   D.GENDAN  END)) Y 
      where (y.year||lpad(y.month,2,0)) = to_char(add_months(sysdate,-1),'yyyymm')
        ) tkb
      ON (tkb.company_id = a.company_id AND tkb.year = a.year AND tkb.month=a.month  AND tkb.category=a.category
           AND tkb.group_name = a.groupname AND tkb.count_dimension =a.count_dimension AND tkb.dimension_sort =a.dimension_sort  )
           when matched then  update
                           set a.INGOOD_MONEY           =tkb.INGOOD_MONEY,
                               a.update_id              = 'ADMIN',
                               a.update_time            = sysdate
                 
    WHEN NOT MATCHED THEN
      INSERT
        (A.T_RTKPI_M_ID, A.COMPANY_ID, A.YEAR, A.MONTH, A.CATEGORY, A.GROUPNAME, A.COUNT_DIMENSION, A.DIMENSION_SORT, A.INGOOD_MONEY, A.CREATE_ID, A.CREATE_TIME, A.UPDATE_ID, A.UPDATE_TIME)
      VALUES
        (SCMDATA.F_GET_UUID(), TKB.COMPANY_ID, TKB.YEAR, TKB.MONTH, TKB.CATEGORY, TKB.GROUP_NAME,  TKB.COUNT_DIMENSION, TKB.DIMENSION_SORT,TKB.INGOOD_MONEY, 'ADMIN', SYSDATE, 'ADMIN', SYSDATE)
 
  MERGE INTO SCMDATA.T_RTKPI_MONTH A
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
   AND Z.DIMENSION_SORT = Y.DIMENSION_SORT*/ 
      where (y.year||lpad(y.month,2,0)) = to_char(add_months(sysdate,-1),'yyyymm')
        ) tkb
      ON (tkb.company_id = a.company_id AND tkb.year = a.year AND tkb.month=a.month  AND tkb.category=a.category
           AND tkb.group_name = a.groupname AND tkb.count_dimension =a.count_dimension AND tkb.dimension_sort =a.dimension_sort  )
           when matched then  update
                           set a.SHOP_RT_MONEY          = tkb.SHOP_RT_MONEY,
                               a.SHOP_RT_ORIGINAL_MONEY = tkb.SHOP_RT_ORIGINAL_MONEY,
                               a.update_id              = 'ADMIN',
                               a.update_time            = sysdate
                 
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
         'ADMIN',sysdate,'ADMIN',sysdate) 
 MERGE INTO SCMDATA.T_RTKPI_MONTH A
             USING ( SELECT  Y.COMPANY_ID,Y.YEAR,Y.MONTH,Y.CATEGORY,Y.GROUP_NAME,Y.COUNT_DIMENSION,Y.DIMENSION_SORT,Y.ORDER_MONEY INGOOD_MONEY
                 FROM (SELECT A.COMPANY_ID, EXTRACT(YEAR FROM A.CREATE_TIME) YEAR,
                      EXTRACT(MONTH FROM A.CREATE_TIME) MONTH,
                      E.CATEGORY,
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
                LEFT JOIN SCMDATA.T_ORDERED C
                   ON C.ORDER_CODE = A.DOCUMENT_NO
                  AND A.COMPANY_ID = C.COMPANY_ID
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
                   ON D.ORDER_ID = C.ORDER_ID
                  AND D.COMPANY_ID = C.COMPANY_ID
                  INNER JOIN SCMDATA.T_COMMODITY_INFO E ON E.GOO_ID=B.GOO_ID AND E.COMPANY_ID=B.COMPANY_ID
                WHERE B.AMOUNT > 0
                GROUP BY A.COMPANY_ID, EXTRACT(YEAR FROM A.CREATE_TIME),
                         EXTRACT(MONTH FROM A.CREATE_TIME), E.CATEGORY,
                         D.GROUP_NAME, D.GENDANZG ) Y
    
      where (y.year||lpad(y.month,2,0)) = to_char(add_months(sysdate,-1),'yyyymm')
        ) tkb
      ON (tkb.company_id = a.company_id AND tkb.year = a.year AND tkb.month=a.month  AND tkb.category=a.category
           AND tkb.group_name = a.groupname AND tkb.count_dimension =a.count_dimension AND tkb.dimension_sort =a.dimension_sort  )
           when matched then  update
                           set a.INGOOD_MONEY           =tkb.INGOOD_MONEY,
                               a.update_id              = 'ADMIN',
                               a.update_time            = sysdate
                 
    WHEN NOT MATCHED THEN
      INSERT
        (A.T_RTKPI_M_ID, A.COMPANY_ID, A.YEAR, A.MONTH, A.CATEGORY, A.GROUPNAME, A.COUNT_DIMENSION, A.DIMENSION_SORT, A.INGOOD_MONEY, A.CREATE_ID, A.CREATE_TIME, A.UPDATE_ID, A.UPDATE_TIME)
      VALUES
        (SCMDATA.F_GET_UUID(), TKB.COMPANY_ID, TKB.YEAR, TKB.MONTH, TKB.CATEGORY, TKB.GROUP_NAME,  TKB.COUNT_DIMENSION, TKB.DIMENSION_SORT,TKB.INGOOD_MONEY, 'ADMIN', SYSDATE, 'ADMIN', SYSDATE)
 
MERGE INTO SCMDATA.T_RTKPI_MONTH A
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
     AND Z.DIMENSION_SORT = Y.DIMENSION_SORT */ 
      where (y.year||lpad(y.month,2,0)) = to_char(add_months(sysdate,-1),'yyyymm')
        ) tkb
      ON (tkb.company_id = a.company_id AND tkb.year = a.year AND tkb.month=a.month  AND tkb.category=a.category
           AND tkb.group_name = a.groupname AND tkb.count_dimension =a.count_dimension AND tkb.dimension_sort =a.dimension_sort  )
           when matched then  update
                           set a.SHOP_RT_MONEY          = tkb.SHOP_RT_MONEY,
                               a.SHOP_RT_ORIGINAL_MONEY = tkb.SHOP_RT_ORIGINAL_MONEY,
                               a.update_id              = 'ADMIN',
                               a.update_time            = sysdate
                 
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
         'ADMIN',sysdate,'ADMIN',sysdate) 
 MERGE INTO SCMDATA.T_RTKPI_MONTH A
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

   SELECT  Y.COMPANY_ID,Y.YEAR,Y.MONTH,Y.CATEGORY,Y.GROUP_NAME,Y.COUNT_DIMENSION,Y.DIMENSION_SORT,Y.ORDER_MONEY INGOOD_MONEY
                 FROM   (SELECT A.COMPANY_ID, EXTRACT(YEAR FROM A.CREATE_TIME) YEAR,
                    EXTRACT(MONTH FROM A.CREATE_TIME) MONTH,
                    E.CATEGORY,
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
              LEFT JOIN SCMDATA.T_ORDERED C
                 ON C.ORDER_CODE = A.DOCUMENT_NO
                AND A.COMPANY_ID = C.COMPANY_ID
              LEFT JOIN (SELECT Z.*,
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
                       EXTRACT(MONTH FROM A.CREATE_TIME), E.CATEGORY,
                       D.GROUP_NAME, D.QC2) Y      
      where (y.year||lpad(y.month,2,0)) = to_char(add_months(sysdate,-1),'yyyymm')
        ) tkb
      ON (tkb.company_id = a.company_id AND tkb.year = a.year AND tkb.month=a.month  AND tkb.category=a.category
           AND tkb.group_name = a.groupname AND tkb.count_dimension =a.count_dimension AND tkb.dimension_sort =a.dimension_sort  )
           when matched then  update
                           set a.INGOOD_MONEY           =tkb.INGOOD_MONEY,
                               a.update_id              = 'ADMIN',
                               a.update_time            = sysdate
                 
    WHEN NOT MATCHED THEN
      INSERT
        (A.T_RTKPI_M_ID, A.COMPANY_ID, A.YEAR, A.MONTH, A.CATEGORY, A.GROUPNAME, A.COUNT_DIMENSION, A.DIMENSION_SORT, A.INGOOD_MONEY, A.CREATE_ID, A.CREATE_TIME, A.UPDATE_ID, A.UPDATE_TIME)
      VALUES
        (SCMDATA.F_GET_UUID(), TKB.COMPANY_ID, TKB.YEAR, TKB.MONTH, TKB.CATEGORY, TKB.GROUP_NAME,  TKB.COUNT_DIMENSION, TKB.DIMENSION_SORT,TKB.INGOOD_MONEY, 'ADMIN', SYSDATE, 'ADMIN', SYSDATE)
 
  MERGE INTO SCMDATA.T_RTKPI_MONTH A
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
 
      where (y.year||lpad(y.month,2,0)) = to_char(add_months(sysdate,-1),'yyyymm')
        ) tkb
      ON (tkb.company_id = a.company_id AND tkb.year = a.year AND tkb.month=a.month  AND tkb.category=a.category
           AND tkb.group_name = a.groupname AND tkb.count_dimension =a.count_dimension AND tkb.dimension_sort =a.dimension_sort  )
           when matched then  update
                           set a.SHOP_RT_MONEY          = tkb.SHOP_RT_MONEY,
                               a.SHOP_RT_ORIGINAL_MONEY = tkb.SHOP_RT_ORIGINAL_MONEY,
                               a.update_id              = 'ADMIN',
                               a.update_time            = sysdate
                 
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
         'ADMIN',sysdate,'ADMIN',sysdate) 
 MERGE INTO SCMDATA.T_RTKPI_MONTH A
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
 SELECT  Y.COMPANY_ID,Y.YEAR,Y.MONTH,Y.CATEGORY,Y.GROUP_NAME,Y.COUNT_DIMENSION,Y.DIMENSION_SORT,Y.ORDER_MONEY INGOOD_MONEY
                 FROM   ( SELECT A.COMPANY_ID,
       EXTRACT(YEAR FROM A.CREATE_TIME) YEAR,
       EXTRACT(MONTH FROM A.CREATE_TIME) MONTH,
       E.CATEGORY,
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
 LEFT JOIN SCMDATA.T_ORDERED C
    ON C.ORDER_CODE = A.DOCUMENT_NO
   AND A.COMPANY_ID = C.COMPANY_ID
 LEFT JOIN (SELECT Z.*, REGEXP_SUBSTR(Z.QC_MANAGER, '[^,]+', 1, LEVEL) QCZG2
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
          E.CATEGORY,
          D.GROUP_NAME,
          D.QCZG2) Y
     
      where (y.year||lpad(y.month,2,0)) = to_char(add_months(sysdate,-1),'yyyymm')
        ) tkb
      ON (tkb.company_id = a.company_id AND tkb.year = a.year AND tkb.month=a.month  AND tkb.category=a.category
           AND tkb.group_name = a.groupname AND tkb.count_dimension =a.count_dimension AND tkb.dimension_sort =a.dimension_sort  )
           when matched then  update
                           set a.INGOOD_MONEY           =tkb.INGOOD_MONEY,
                               a.update_id              = 'ADMIN',
                               a.update_time            = sysdate
                 
    WHEN NOT MATCHED THEN
      INSERT
        (A.T_RTKPI_M_ID, A.COMPANY_ID, A.YEAR, A.MONTH, A.CATEGORY, A.GROUPNAME, A.COUNT_DIMENSION, A.DIMENSION_SORT, A.INGOOD_MONEY, A.CREATE_ID, A.CREATE_TIME, A.UPDATE_ID, A.UPDATE_TIME)
      VALUES
        (SCMDATA.F_GET_UUID(), TKB.COMPANY_ID, TKB.YEAR, TKB.MONTH, TKB.CATEGORY, TKB.GROUP_NAME,  TKB.COUNT_DIMENSION, TKB.DIMENSION_SORT,TKB.INGOOD_MONEY, 'ADMIN', SYSDATE, 'ADMIN', SYSDATE)
 
  MERGE INTO SCMDATA.T_RTKPI_MONTH A
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
   AND Z.DIMENSION_SORT = Y.DIMENSION_SORT */ 
      where (y.year||lpad(y.month,2,0)) = to_char(add_months(sysdate,-1),'yyyymm')
        ) tkb
      ON (tkb.company_id = a.company_id AND tkb.year = a.year AND tkb.month=a.month  AND tkb.category=a.category
           AND tkb.group_name = a.groupname AND tkb.count_dimension =a.count_dimension AND tkb.dimension_sort =a.dimension_sort  )
           when matched then  update
                           set a.SHOP_RT_MONEY          = tkb.SHOP_RT_MONEY,
                               a.SHOP_RT_ORIGINAL_MONEY = tkb.SHOP_RT_ORIGINAL_MONEY,
                               a.update_id              = 'ADMIN',
                               a.update_time            = sysdate
                 
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
         'ADMIN',sysdate,'ADMIN',sysdate) 
