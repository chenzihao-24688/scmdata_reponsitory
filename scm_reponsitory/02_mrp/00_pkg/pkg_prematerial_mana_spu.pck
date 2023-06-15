CREATE OR REPLACE PACKAGE MRP.PKG_PREMATERIAL_MANA_SPU IS
 FUNCTION F_QUERY_SPUPREPARE(V_TYPE IN VARCHAR,
                               V_STATUS IN NUMBER,
                               V_COMPANY_ID IN VARCHAR2) RETURN CLOB;
  FUNCTION F_QUERY_SPUPRE_DETAIL(V_PIN IN VARCHAR2,
                                 V_TYPE IN VARCHAR2 DEFAULT NULL,
                                 V_STATUS IN NUMBER) RETURN CLOB;
                                    
    FUNCTION F_QUERY_PROPREPARE_SPU(V_TYPE IN VARCHAR2, 
                           V_STATUS IN NUMBER,
                           V_COMPANY_ID IN VARCHAR2) RETURN CLOB;   
                           
   FUNCTION F_QUERY_PROPREPARE_SPU_DETAIL(V_PROID IN VARCHAR2,
                                   V_STATUS IN NUMBER) RETURN CLOB;   
                                   
  FUNCTION F_QUERY_ALLSTATUS(V_TYPE IN VARCHAR2,
                             V_COMPANY_ID IN VARCHAR2) RETURN CLOB;   
  
  PROCEDURE P_INS_PREPROORDER(V_GROUPKEY IN VARCHAR2,
                              V_SKC      IN VARCHAR2,
                              V_DOCUNUM  IN NUMBER,
                              V_ORDERAMOUNT IN NUMBER,
                              V_TYPE     IN  VARCHAR2 DEFAULT NULL,
                              V_MATERIAL IN  VARCHAR2,
                              V_USERID   IN VARCHAR2,
                              V_COMPANY_ID IN VARCHAR2,
                              V_OPR_COM   IN VARCHAR2,                              
                              V_ORDERID  OUT VARCHAR2);   
                              
      --取消备料单表
PROCEDURE P_CANCEL_PREMATERIAL(V_USERID IN VARCHAR2,  --用户id
                               V_PREID  IN VARCHAR2,  --单据号
                               V_REASON IN VARCHAR2,
                               V_TYPE   IN VARCHAR2,-- --SKU/SPU
                               --V_MODE   IN VARCHAR2  --CP/WL
                               V_OPR_COM IN VARCHAR2 --操作人企业
                               );
      
  --修改备料单订单数量                         
     PROCEDURE P_UPD_ORDERAMOUNT(PI_USERID IN VARCHAR2, --用户
                            PI_PREID  IN VARCHAR2,  --单据号
                            PI_TYPE   IN VARCHAR2, --SKU/SPU
                            PI_ORDERAMOUNT IN VARCHAR2, --数量
                            V_OPR_COM IN VARCHAR2);                
    
  --修改预计到仓日期                        
   PROCEDURE P_UPD_EXARRTIME (PI_USERID IN VARCHAR2, --用户
                            PI_PREID  IN VARCHAR2,  --单据号
                            PI_TYPE   IN VARCHAR2, --SKU/SPU
                            PI_DATE   IN DATE,
                            V_OPR_COM IN VARCHAR2);   
                            
  --取消生产单 
  
  PROCEDURE P_CANCEL_PROORDER (PI_TYPE IN VARCHAR2, --SKU/SPU
                             PI_USERID IN VARCHAR2, --用户id
                             PI_PROID  IN VARCHAR2, --单据号
                             PI_REASON IN VARCHAR2,
                             V_OPR_COM IN VARCHAR2);
                             
   FUNCTION F_CHECK_SPUSTOCK_ISEXISTS (PI_SUPCODE IN VARCHAR2,
                                      PI_MATECODE IN VARCHAR2,
                                      PI_SPU     IN VARCHAR2,
                                      PI_UNIT    IN VARCHAR2,
                                      PI_MODE    IN VARCHAR2) RETURN NUMBER;
                                      
 PROCEDURE P_SPU_FINISH_PRODUCT(PI_PROID  IN VARCHAR2, --生产单号
                               PI_USERID IN VARCHAR2,   --用户id
                               PI_AMOUNT IN VARCHAR2,  --本次完成数量
                               PI_ISFINISH IN VARCHAR2,  --是否完成
                               PI_OPCOM   IN VARCHAR2) ;                                                                                                                                                                                                                                  

 --校验7位自然数，小数允许后2位
  FUNCTION F_CHECK_NUM(PI_NUM IN VARCHAR2) RETURN NUMBER;
  
  --主表接单更新坯布备料单表                               
PROCEDURE P_UPD_SPUPREMA(PI_USERID IN VARCHAR2,
                         PI_COMPANY_ID IN VARCHAR2,
                         PI_GROUP_KEY  IN VARCHAR2,
                         PI_PROOID    IN VARCHAR2,
                         V_OPR_COM    IN VARCHAR2);
      
  --主表接单按钮                   
PROCEDURE P_SPU_RECEIVE_ORDERS(PI_USERID IN VARCHAR2,
                               PI_COMPANY_ID IN VARCHAR2,
                               PI_OPR_COM  IN VARCHAR2,
                               PI_REC IN MRP.GREY_PREPARE_ORDER%ROWTYPE);

 END PKG_PREMATERIAL_MANA_SPU;
/

create or replace package body mrp.PKG_PREMATERIAL_MANA_SPU IS

   FUNCTION F_QUERY_SPUPREPARE(V_TYPE IN VARCHAR,
                               V_STATUS IN NUMBER,
                               V_COMPANY_ID IN VARCHAR2) RETURN CLOB
     IS
     V_SQL CLOB;

       BEGIN
       
       V_SQL :='SELECT GP.MATERIAL_NAME,'||CASE WHEN V_STATUS IN (1,4) THEN '
       (CASE WHEN  GP.EXPECT_ARRIVAL_TIME < SYSDATE THEN ''是'' ELSE ''否'' END) CR_IS_DELAY_N,--是否逾期'
       WHEN V_STATUS = 3 THEN '
         (CASE WHEN GP.IS_DELAY > 0 THEN ''是'' ELSE ''否'' END) CR_IS_DELAY_N,' END ||'
       P.FILE_UNIQUE CR_FEATURES_N, --特征图
       GP.UNIT,
       GP.CR_ORDER_CNT_N,
       GP.CP_ORDER_NUM_N,'||CASE WHEN V_STATUS = 3 THEN '
       GP.BATCH_FINISH_NUM CP_FINISHED_NUM_N,
       (GP.BATCH_FINISH_NUM/CP_ORDER_NUM_N)*100 CR_FINISH_RATE_N,' END ||'
       GP.PRACTICAL_DOOR_WITH CR_PRACTICAL_DOOR_WITH_N,
       GP.GRAM_WEIGHT CR_GRAM_WEIGHT_N,
       GP.MATERIAL_SPECIFICATIONS,
       GP.MATERIAL_SPU,
       GP.GROUP_KEY
  FROM (SELECT A.GROUP_KEY,
         MAX(A.SUPPLIER_MATERIAL_NAME) MATERIAL_NAME, --物料名称
         MAX(A.UNIT) UNIT, --单位
         MAX(A.FEATURES) FEATURES,
         MIN(A.EXPECT_ARRIVAL_TIME) EXPECT_ARRIVAL_TIME,
         MAX(A.ORDER_TIME) ORDER_TIME,
         COUNT(1) CR_ORDER_CNT_N, --订单数
         SUM(A.ORDER_NUM) CP_ORDER_NUM_N, --订单量'||
         CASE WHEN V_STATUS = 3 THEN '
           SUM(CASE  WHEN A.PREPARE_STATUS = 3 THEN
                      DECODE(SIGN(TO_NUMBER(A.FINISH_TIME - A.EXPECT_ARRIVAL_TIME)),
                             1, 1,   0)
                   END) IS_DELAY,
         SUM(A.BATCH_FINISH_NUM) BATCH_FINISH_NUM,
         MAX(A.BATCH_FINISH_PERCENT) BATCH_FINISH_PERCENT,' END||'
         MAX(A.PRACTICAL_DOOR_WITH) PRACTICAL_DOOR_WITH, --实用门幅
         MAX(A.GRAM_WEIGHT) GRAM_WEIGHT, --克重
         MAX(A.MATERIAL_SPECIFICATIONS) MATERIAL_SPECIFICATIONS, --规格
         MAX(A.MATERIAL_SPU) MATERIAL_SPU, --物料spu'||CASE WHEN V_TYPE ='CP' THEN '
         MAX(A.PRO_SUPPLIER_CODE) PRO_SUPPLIER_CODE,
         MAX(A.MATER_SUPPLIER_CODE) MATER_SUPPLIER_CODE' WHEN V_TYPE = 'WL' THEN '
         MAX(A.MATER_SUPPLIER_CODE) MATER_SUPPLIER_CODE 'END||'
          FROM MRP.GREY_PREPARE_ORDER A
         WHERE A.WHETHER_DEL =0 
           AND A.COMPANY_ID = '''||V_COMPANY_ID||'''
           AND A.PREPARE_STATUS ='||V_STATUS ||'
           AND '||CASE WHEN V_TYPE ='CP' THEN ' A.PRO_SUPPLIER_CODE =
               (SELECT Z.SUPPLIER_INFO_ID
                  FROM SCMDATA.T_SUPPLIER_INFO Z
                 WHERE Z.SUPPLIER_COMPANY_ID = %DEFAULT_COMPANY_ID%
                   AND Z.COMPANY_ID = '''||V_COMPANY_ID||''')
           AND  A.PREPARE_OBJECT = 0     '
                 WHEN V_TYPE = 'WL' THEN ' A.MATER_SUPPLIER_CODE =
               (SELECT SUPPLIER_CODE FROM MRP.MRP_DETERMINE_SUPPLIER_ARCHIVES F
                 WHERE F.supplier_company_id =%DEFAULT_COMPANY_ID%
                   AND F.COMPANY_ID = '''||V_COMPANY_ID||''')
           AND A.PREPARE_OBJECT = 1        ' END||
         'GROUP BY A.GROUP_KEY) GP
  LEFT JOIN  MRP.MRP_PICTURE  P
    ON P.PICTURE_ID = GP.FEATURES 
    ORDER BY GP.ORDER_TIME DESC';  
       
  /*V_SQL :='SELECT GP.MATERIAL_NAME,
       (CASE WHEN  GP.EXPECT_ARRIVAL_TIME < SYSDATE THEN ''是'' ELSE ''否'' END) CR_IS_DELAY_N,--是否逾期
       P.FILE_UNIQUE CR_FEATURES_N, --特征图
       GP.UNIT,
       GP.CR_ORDER_CNT_N,
       GP.CP_ORDER_NUM_N,'||CASE WHEN V_STATUS = 3 THEN '
       GP.BATCH_FINISH_NUM CP_FINISHED_NUM_N,
       (GP.BATCH_FINISH_NUM/CP_ORDER_NUM_N)*100 CR_FINISH_RATE_N,' END ||'
       GP.PRACTICAL_DOOR_WITH CR_PRACTICAL_DOOR_WITH_N,
       GP.GRAM_WEIGHT CR_GRAM_WEIGHT_N,
       GP.MATERIAL_SPECIFICATIONS,
       GP.MATERIAL_SPU,
       GP.GROUP_KEY
  FROM (SELECT A.GROUP_KEY,
         MAX(A.SUPPLIER_MATERIAL_NAME) MATERIAL_NAME, --物料名称
         MAX(A.UNIT) UNIT, --单位
         MAX(A.FEATURES) FEATURES,
         MIN(A.EXPECT_ARRIVAL_TIME) EXPECT_ARRIVAL_TIME,
         MAX(A.ORDER_TIME) ORDER_TIME,
         COUNT(1) CR_ORDER_CNT_N, --订单数
         SUM(A.ORDER_NUM) CP_ORDER_NUM_N, --订单量'||
         CASE WHEN V_STATUS = 3 THEN '
         SUM(A.BATCH_FINISH_NUM) BATCH_FINISH_NUM,
         MAX(A.BATCH_FINISH_PERCENT) BATCH_FINISH_PERCENT,' END||'
         MAX(A.PRACTICAL_DOOR_WITH) PRACTICAL_DOOR_WITH, --实用门幅
         MAX(A.GRAM_WEIGHT) GRAM_WEIGHT, --克重
         MAX(A.MATERIAL_SPECIFICATIONS) MATERIAL_SPECIFICATIONS, --规格
         MAX(A.MATERIAL_SPU) MATERIAL_SPU, --物料spu'||CASE WHEN V_TYPE ='CP' THEN '
         MAX(A.PRO_SUPPLIER_CODE) PRO_SUPPLIER_CODE,
         MAX(A.MATER_SUPPLIER_CODE) MATER_SUPPLIER_CODE' WHEN V_TYPE = 'WL' THEN '
         MAX(A.MATER_SUPPLIER_CODE) MATER_SUPPLIER_CODE 'END||'
          FROM MRP.GREY_PREPARE_ORDER A
         WHERE A.WHETHER_DEL =0 
           AND A.COMPANY_ID = '''||V_COMPANY_ID||'''
           AND A.PREPARE_STATUS ='||V_STATUS ||'
           AND '||CASE WHEN V_TYPE ='CP' THEN ' A.PRO_SUPPLIER_CODE =
               (SELECT Z.SUPPLIER_INFO_ID
                  FROM SCMDATA.T_SUPPLIER_INFO Z
                 WHERE Z.SUPPLIER_COMPANY_ID = %DEFAULT_COMPANY_ID%
                   AND Z.COMPANY_ID = '''||V_COMPANY_ID||''')
           AND  A.PREPARE_OBJECT = 0     '
                 WHEN V_TYPE = 'WL' THEN ' A.MATER_SUPPLIER_CODE =
               (SELECT SUPPLIER_CODE FROM MRP.MRP_DETERMINE_SUPPLIER_ARCHIVES F
                 WHERE F.supplier_company_id =%DEFAULT_COMPANY_ID%
                   AND F.COMPANY_ID = '''||V_COMPANY_ID||''')
           AND A.PREPARE_OBJECT = 1        ' END||
         'GROUP BY A.GROUP_KEY) GP
  LEFT JOIN  MRP.MRP_PICTURE  P
    ON P.PICTURE_ID = GP.FEATURES 
    ORDER BY GP.ORDER_TIME DESC';*/

   RETURN V_SQL;
     END F_QUERY_SPUPREPARE;
     
     FUNCTION F_QUERY_SPUPRE_DETAIL(V_PIN IN VARCHAR2,
                                    V_TYPE IN VARCHAR2 DEFAULT NULL,
                                    V_STATUS IN NUMBER) RETURN CLOB IS 
     
     V_SQL CLOB;
     BEGIN
       V_SQL :='SELECT A.PREPARE_ORDER_ID,  --备料单号 
       (CASE WHEN A.PREPARE_STATUS IN (1,2,4) AND SYSDATE>A.EXPECT_ARRIVAL_TIME THEN ''是''
         WHEN A.PREPARE_STATUS = 3 AND A.FINISH_TIME >A.EXPECT_ARRIVAL_TIME THEN ''是'' 
          ELSE ''否'' END) CR_IS_DELAY_N,  --是否逾期'||
        CASE WHEN V_STATUS IN (3,4) THEN ' 
          A.PRODUCT_ORDER_ID, ' END||CASE WHEN V_STATUS = 4 THEN '
          A.CANCEL_REASON CR_CANCEL_REASON_N,  ' END ||'            
       A.ORDER_NUM CP_ORDER_NUM_N,  --订单量'||
  CASE WHEN V_STATUS = 3 THEN ' 
    A.BATCH_FINISH_PERCENT CR_FINISH_RATE_N, 
    A.BATCH_FINISH_NUM COMPLETE_AMOUNT_PR, ' ELSE NULL END||'     
 C.STYLE_NUMBER,--款号
 C.RELA_GOO_ID,--货号
A.GOODS_SKC CR_GOODS_SKC_N,  --SKC
 B.COLORNAME, --颜色
 A.ORDER_TIME CR_ORDER_TIME_N, --下单日期
 A.EXPECT_ARRIVAL_TIME CR_EXPECT_ARRIVAL_TIME_N, --预计到仓日期
 ROUND(A.EXPECT_ARRIVAL_TIME - A.CREATE_TIME,1) CR_EXPECT_ARRIVAL_DAYS_N --预计到仓总耗天数'||CASE WHEN V_STATUS = 3 THEN '
 , ROUND((A.FINISH_TIME - A.CREATE_TIME),1) CR_REAL_ARRIVAL_DAYS_N' END ||CASE WHEN V_STATUS IN (3,4) THEN '
 , A.RECEIVE_TIME CR_RECEIVE_TIME_N,D.NICK_NAME RECEIVE_ORDER, ' END||
 CASE WHEN V_STATUS = 3 THEN '
   A.FINISH_TIME CR_FINISH_TIME_N, E.NICK_NAME CR_FINISH_ID_N ' END||CASE WHEN V_STATUS=4 THEN '
   A.CANCEL_TIME CR_CANCEL_TIME_N, F.NICK_NAME CR_CANCEL_ID_N ' END||'
FROM MRP.GREY_PREPARE_ORDER A 
LEFT JOIN SCMDATA.T_COMMODITY_COLOR B ON A.GOODS_SKC=B.COMMODITY_COLOR_CODE AND A.COMPANY_ID = B.COMPANY_ID
LEFT JOIN SCMDATA.T_COMMODITY_INFO C ON C.COMMODITY_INFO_ID=B.COMMODITY_INFO_ID
LEFT JOIN SCMDATA.SYS_USER D ON D.USER_ID = A.RECEIVE_ID 
LEFT JOIN SCMDATA.SYS_USER E ON E.USER_ID = A.FINISH_ID
LEFT JOIN SCMDATA.SYS_USER F ON F.USER_ID = A.CANCEL_ID
WHERE /*'  ||CASE WHEN V_TYPE ='CP' THEN ' A.PRO_SUPPLIER_CODE =
               (SELECT Z.SUPPLIER_INFO_ID
                  FROM SCMDATA.T_SUPPLIER_INFO Z
                 WHERE Z.SUPPLIER_COMPANY_ID = %DEFAULT_COMPANY_ID%
                 AND Z.COMPANY_ID = ''b6cc680ad0f599cde0531164a8c0337f'')
           AND  A.PREPARE_OBJECT = 0     '
                 WHEN V_TYPE = 'WL' THEN ' A.MATER_SUPPLIER_CODE =
               (SELECT SUPPLIER_CODE FROM MRP.MRP_DETERMINE_SUPPLIER_ARCHIVES F
                 WHERE F.supplier_company_id =%DEFAULT_COMPANY_ID%
                 AND F.COMPANY_ID = ''b6cc680ad0f599cde0531164a8c0337f'') 
           AND A.PREPARE_OBJECT = 1        ' END||' 
AND*/ A.WHETHER_DEL =0
AND  A.PREPARE_STATUS='||V_STATUS||' 
AND A.GROUP_KEY=''' ||V_PIN||''' 
ORDER BY A.ORDER_TIME DESC';
  RETURN V_SQL;
     END F_QUERY_SPUPRE_DETAIL;
     
     --生产中
     FUNCTION F_QUERY_PROPREPARE_SPU(V_TYPE IN VARCHAR2, 
                           V_STATUS IN NUMBER,
                           V_COMPANY_ID IN VARCHAR2) RETURN CLOB IS
  V_SQL CLOB;
BEGIN
  V_SQL := q'[SELECT A.PRODUCT_ORDER_ID, --生产单号
       A.SUPPLIER_MATERIAL_NAME MATERIAL_NAME, --物料名称
       (CASE WHEN SYSDATE > B.EXPECT_ARRIVAL_TIME THEN '是' ELSE '否' END ) CR_IS_DELAY_N,--是否逾期
       P.FILE_UNIQUE CR_FEATURES_N, --特征图
       A.UNIT, --单位
       A.CONTAIN_GREY_PREPARE_NUM CR_ORDER_CNT_N, --订单数
       A.PLAN_PRODUCT_QUANTITY CP_ORDER_NUM_N, --订单量
       A.BATCH_FINISH_NUM CP_FINISHED_NUM_N, --已完成数量
       --A.BATCH_FINISH_PERCENT*100 || '%' cr_finish_rate_n, --完成率
       A.BATCH_FINISH_PERCENT CR_FINISH_RATE_N, --完成率
       A.PRACTICAL_DOOR_WITH CR_PRACTICAL_DOOR_WITH_N, --实用门幅
       A.GRAM_WEIGHT CR_GRAM_WEIGHT_N, --克重
       A.MATERIAL_SPECIFICATIONS, --规格
       A.MATERIAL_SPU --物料spu
  FROM MRP.GREY_PREPARE_PRODUCT_ORDER A
 INNER JOIN (SELECT Z.PRODUCT_ORDER_ID,  MIN(Z.EXPECT_ARRIVAL_TIME) EXPECT_ARRIVAL_TIME,
         MAX(Z.ORDER_TIME) ORDER_TIME
               FROM MRP.GREY_PREPARE_ORDER Z
              GROUP BY Z.PRODUCT_ORDER_ID) B
    ON A.PRODUCT_ORDER_ID = B.PRODUCT_ORDER_ID
   LEFT JOIN  MRP.MRP_PICTURE  P
    ON P.PICTURE_ID = A.FEATURES 
 WHERE A.WHETHER_DEL = 0
 AND A.COMPANY_ID =']'||V_COMPANY_ID||q'['
 AND A.PRODUCT_STATUS =]' || V_STATUS || '
 AND ' || CASE
             WHEN V_TYPE = 'CP' THEN
              ' A.PRO_SUPPLIER_CODE =
               (SELECT Z.SUPPLIER_INFO_ID
                  FROM SCMDATA.T_SUPPLIER_INFO Z
                 WHERE Z.SUPPLIER_COMPANY_ID = %DEFAULT_COMPANY_ID%
                 AND Z.COMPANY_ID = '''||V_COMPANY_ID||''')'
             WHEN V_TYPE = 'WL' THEN
              ' A.MATER_SUPPLIER_CODE =
               (SELECT SUPPLIER_CODE FROM MRP.MRP_DETERMINE_SUPPLIER_ARCHIVES F
                 WHERE F.supplier_company_id =%DEFAULT_COMPANY_ID%
                 AND F.COMPANY_ID = '''||V_COMPANY_ID||''') '
           END || '
    ORDER BY B.ORDER_TIME DESC';
 RETURN V_SQL;   
    
END F_QUERY_PROPREPARE_SPU;

  --生产中从表
FUNCTION F_QUERY_PROPREPARE_SPU_DETAIL(V_PROID IN VARCHAR2,
                                   V_STATUS IN NUMBER) RETURN CLOB IS
  V_SQL CLOB;
BEGIN
  V_SQL :=q'[SELECT A.PREPARE_ORDER_ID, --备料单号
       (CASE  WHEN A.PREPARE_STATUS IN (1, 2, 4) AND
              SYSDATE > A.EXPECT_ARRIVAL_TIME THEN  '是'
         WHEN A.PREPARE_STATUS = 3 AND A.FINISH_TIME > A.EXPECT_ARRIVAL_TIME THEN '是'
         ELSE '否'   END) CR_IS_DELAY_N, --是否逾期       
       A.ORDER_NUM CP_ORDER_NUM_N, --订单量
       --B.BATCH_FINISH_PERCENT*100 || '%' cr_finish_rate_n, --完成率
       B.BATCH_FINISH_PERCENT CR_FINISH_RATE_N, --完成率
       A.ORDER_NUM * (B.BATCH_FINISH_PERCENT/100) COMPLETE_AMOUNT_PR, --完成数量
       D.STYLE_NUMBER, --款号
       D.RELA_GOO_ID, --货号
       A.GOODS_SKC CR_GOODS_SKC_N, --SKC
       C.COLORNAME, --颜色
       A.ORDER_TIME CR_ORDER_TIME_N, --下单日期
       A.EXPECT_ARRIVAL_TIME CR_EXPECT_ARRIVAL_TIME_N, --预计到仓日期
       ROUND(A.EXPECT_ARRIVAL_TIME - A.CREATE_TIME, 1) CR_EXPECT_ARRIVAL_DAYS_N, --预计到仓总耗天数
       A.RECEIVE_TIME CR_RECEIVE_TIME_N, --接单日期
       T.NICK_NAME RECEIVE_ORDER --接单人
  FROM MRP.GREY_PREPARE_ORDER A
 INNER JOIN MRP.GREY_PREPARE_PRODUCT_ORDER B
    ON A.PRODUCT_ORDER_ID = B.PRODUCT_ORDER_ID
 LEFT JOIN SCMDATA.T_COMMODITY_COLOR C
    ON A.GOODS_SKC = C.COMMODITY_COLOR_CODE
   AND A.COMPANY_ID = C.COMPANY_ID
 LEFT JOIN SCMDATA.T_COMMODITY_INFO D
    ON D.COMMODITY_INFO_ID = C.COMMODITY_INFO_ID
  LEFT JOIN SCMDATA.SYS_USER T ON T.USER_ID = A.RECEIVE_ID
 WHERE A.WHETHER_DEL =0
   AND A.PREPARE_STATUS = ]'||V_STATUS||'
   AND A.PRODUCT_ORDER_ID ='''||V_PROID||'''
    ORDER BY A.ORDER_TIME DESC ';
 
 RETURN V_SQL;   
    
 END F_QUERY_PROPREPARE_SPU_DETAIL; 
 
  FUNCTION F_QUERY_ALLSTATUS(V_TYPE IN VARCHAR2,
                             V_COMPANY_ID IN VARCHAR2) RETURN CLOB IS 
     
     V_SQL CLOB;
     BEGIN
       V_SQL :=q'[SELECT A.PREPARE_ORDER_ID, --备料单号
       C.STYLE_NUMBER, --款号
       A.SUPPLIER_MATERIAL_NAME MATERIAL_NAME, --物料名称
       A.PREPARE_STATUS, --备料状态
       (CASE   WHEN A.PREPARE_STATUS IN (1, 2, 4) AND SYSDATE > A.EXPECT_ARRIVAL_TIME THEN  '是'
        WHEN A.PREPARE_STATUS = 3 AND A.FINISH_TIME > A.EXPECT_ARRIVAL_TIME THEN '是'
        ELSE  '否'  END) CR_IS_DELAY_N, --是否逾期是否逾期
       A.CANCEL_REASON CR_CANCEL_REASON_N, --取消原因
       A.UNIT, --单位
       A.ORDER_NUM CP_ORDER_NUM_N, --订单量
       C.RELA_GOO_ID, --货号
       A.GOODS_SKC CR_GOODS_SKC_N, --SKC
       B.COLORNAME, --档案颜色
       P.FILE_UNIQUE FEATURES_FILE, -- 特征图
       A.PRACTICAL_DOOR_WITH CR_PRACTICAL_DOOR_WITH_N, --实用门幅
       A.GRAM_WEIGHT CR_GRAM_WEIGHT_N, --克重
       A.MATERIAL_SPECIFICATIONS, --规格
       D.GROUP_DICT_NAME CATEGORY, --分类
       A.PRODUCT_ORDER_ID, --生产单号
       A.MATERIAL_SPU, --物料spu
       A.ORDER_TIME CR_ORDER_TIME_N, --下单日期
       A.EXPECT_ARRIVAL_TIME CR_EXPECT_ARRIVAL_TIME_N, --预计到仓日期
       ROUND((A.EXPECT_ARRIVAL_TIME - A.CREATE_TIME), 1) CR_EXPECT_ARRIVAL_DAYS_N, --预计到仓总耗天数
       A.RECEIVE_TIME CR_RECEIVE_TIME_N, --接单日期
       E.NICK_NAME RECEIVE_ORDER, --接单人
       A.CANCEL_TIME CR_CANCEL_TIME_N, --取消日期
       F.NICK_NAME CR_CANCEL_ID_N, --取消人
       A.FINISH_TIME CR_FINISH_TIME_N, -- 完成日期
       G.NICK_NAME CR_FINISH_ID_N --完成人

  FROM MRP.GREY_PREPARE_ORDER A
 LEFT JOIN SCMDATA.T_COMMODITY_COLOR B
    ON A.GOODS_SKC = B.COMMODITY_COLOR_CODE
   AND A.COMPANY_ID = B.COMPANY_ID
 LEFT JOIN SCMDATA.T_COMMODITY_INFO C
    ON C.COMMODITY_INFO_ID = B.COMMODITY_INFO_ID
 LEFT JOIN SCMDATA.SYS_GROUP_DICT D
    ON D.GROUP_DICT_ID = A.APPLICABLE_CATEGORY
   AND D.GROUP_DICT_TYPE = 'PRODUCT_TYPE'
  LEFT JOIN SCMDATA.SYS_USER E
    ON E.USER_ID = A.RECEIVE_ID
  LEFT JOIN SCMDATA.SYS_USER F
    ON F.USER_ID = A.CANCEL_ID
  LEFT JOIN SCMDATA.SYS_USER G
    ON G.USER_ID = A.FINISH_ID
  LEFT JOIN MRP.MRP_PICTURE P
    ON A.FEATURES = P.PICTURE_ID 
    WHERE  A.WHETHER_DEL = 0 
    AND A.PREPARE_STATUS <> 0
    AND A.COMPANY_ID = ']'||V_COMPANY_ID ||q'['
    AND ]'||CASE WHEN V_TYPE ='CP' THEN ' A.PRO_SUPPLIER_CODE =
               (SELECT Z.SUPPLIER_INFO_ID
                  FROM SCMDATA.T_SUPPLIER_INFO Z
                 WHERE Z.SUPPLIER_COMPANY_ID = %DEFAULT_COMPANY_ID%
                   AND Z.COMPANY_ID = '''||V_COMPANY_ID||''' )
           AND  A.PREPARE_OBJECT = 0     '
                 WHEN V_TYPE = 'WL' THEN ' A.MATER_SUPPLIER_CODE =
               (SELECT SUPPLIER_CODE FROM MRP.MRP_DETERMINE_SUPPLIER_ARCHIVES F
                 WHERE F.SUPPLIER_COMPANY_ID =%DEFAULT_COMPANY_ID%
                   AND F.COMPANY_ID = '''||V_COMPANY_ID||''') 
           AND A.PREPARE_OBJECT = 1    
          ' END||'
    ORDER BY A.ORDER_TIME DESC ';
  RETURN V_SQL;
     END F_QUERY_ALLSTATUS;
     
     
  --生成生产单 状态：1生产中
  --传参 group_key,关联的skc 单数，总订单数量,成品/物料，色布/坯布,操作人id 返回生产单号   
     PROCEDURE P_INS_PREPROORDER(V_GROUPKEY IN VARCHAR2,
                              V_SKC      IN VARCHAR2,
                              V_DOCUNUM  IN NUMBER,
                              V_ORDERAMOUNT IN NUMBER,
                              V_TYPE     IN  VARCHAR2 DEFAULT NULL,
                              V_MATERIAL IN  VARCHAR2,
                              V_USERID   IN VARCHAR2,
                              V_COMPANY_ID IN VARCHAR2,
                              V_OPR_COM   IN VARCHAR2,                              
                              V_ORDERID  OUT VARCHAR2) IS 
    
  V_ID VARCHAR2(32);
  V_REC_SKU MRP.COLOR_PREPARE_ORDER%ROWTYPE;
  V_REC_SPU MRP.GREY_PREPARE_ORDER %ROWTYPE;
  --VO_LOG_ID VARCHAR2(32);
  BEGIN
    --先区分色布/坯布
    IF V_MATERIAL ='SPU' THEN
      --MRP.GREY_PREPARE_ORDER 
        --根据GROUP_KEY查出spu相关信息 spu,编号，名称，颜色，单位，门幅，克重，规格，成分
        /*SELECT MAX(A.MATERIAL_SPU),MAX(A.PRO_SUPPLIER_CODE),MAX(A.MATER_SUPPLIER_CODE),MAX(A.WHETHER_INNER_MATER),MAX(A.MATERIAL_NAME),
          MAX(A.UNIT),MAX(A.SUPPLIER_MATERIAL_NAME),MAX(A.PRACTICAL_DOOR_WITH),MAX(A.GRAM_WEIGHT),MAX(A.MATERIAL_SPECIFICATIONS),MAX(A.FEATURES),
          MAX(A.INGREDIENTS),MAX(A.PREPARE_OBJECT)
          INTO V_SPU,V_PROSUP,V_MATESUP,V_ISINNER,V_MATENAME,V_UNIT,V_SUPMATENAME,V_MENFU,V_KEZHONG,V_GUIGE,V_TEZHENGTU,V_CHENGFEN,V_BLDX
          FROM MRP.GREY_PREPARE_ORDER A
         WHERE A.GROUP_KEY = V_GROUPKEY
           AND A.PREPARE_STATUS=1;*/
         SELECT *
           INTO V_REC_SPU
           FROM MRP.GREY_PREPARE_ORDER A
          WHERE A.GROUP_KEY = V_GROUPKEY
            AND A.PREPARE_STATUS = 1
            AND ROWNUM = 1;
           
         IF V_REC_SPU.prepare_object = 0 OR V_TYPE = 'CP' THEN 
           V_ID :=MRP.PKG_PLAT_COMM.F_GET_DOCUNO(PI_TABLE_NAME  => 'MRP.GREY_PREPARE_PRODUCT_ORDER',
                                          PI_COLUMN_NAME => 'PRODUCT_ORDER_ID',
                                          PI_PRE         =>'CPSC'||to_char(SYSDATE,'yyyymmdd') ,
                                          PI_SERAIL_NUM  =>5 );
         ELSIF V_REC_SPU.prepare_object = 1 OR V_TYPE = 'WL' THEN 
           V_ID :=MRP.PKG_PLAT_COMM.F_GET_DOCUNO(PI_TABLE_NAME  => 'MRP.GREY_PREPARE_PRODUCT_ORDER',
                                          PI_COLUMN_NAME => 'PRODUCT_ORDER_ID',
                                          PI_PRE         =>'WPSC'||to_char(SYSDATE,'yyyymmdd') ,
                                          PI_SERAIL_NUM  =>5 );
         END IF;  
     scmdata.pkg_plat_log.p_document_change_trace(p_company_id              => 'b6cc680ad0f599cde0531164a8c0337f',
                                               p_document_id             => V_ID,
                                               p_data_source_parent_code => 'PREMATERIAL_MANA_LOG',
                                               p_data_source_child_code  => '00',
                                               p_operate_company_id      => V_OPR_COM,
                                               p_user_id                 => V_USERID); 
     
    
      INSERT INTO MRP.GREY_PREPARE_PRODUCT_ORDER (PRODUCT_ORDER_ID,PRODUCT_STATUS,PREPARE_OBJECT,MATERIAL_SPU,PRO_SUPPLIER_CODE,MATER_SUPPLIER_CODE,WHETHER_INNER_MATER,
      MATERIAL_NAME,UNIT,SUPPLIER_MATERIAL_NAME,PRACTICAL_DOOR_WITH,GRAM_WEIGHT,MATERIAL_SPECIFICATIONS,FEATURES,INGREDIENTS,
      PLAN_PRODUCT_QUANTITY,CONTAIN_GREY_PREPARE_NUM,RECEIVE_ID,RECEIVE_TIME,COMPLETE_NUM,RELATE_SKC,COMPANY_ID,CREATE_ID,CREATE_TIME,WHETHER_DEL)
      VALUES(V_ID,1,V_REC_SPU.prepare_object, V_REC_SPU.material_spu, V_REC_SPU.pro_supplier_code,V_REC_SPU.mater_supplier_code,V_REC_SPU.whether_inner_mater,
      V_REC_SPU.material_name,V_REC_SPU.unit,V_REC_SPU.supplier_material_name,V_REC_SPU.practical_door_with,V_REC_SPU.gram_weight,V_REC_SPU.material_specifications,V_REC_SPU.features,V_REC_SPU.ingredients,          
      V_ORDERAMOUNT,V_DOCUNUM,V_USERID,SYSDATE,V_ORDERAMOUNT,V_SKC,V_COMPANY_ID,V_USERID,SYSDATE,0);
      
      /*SCMDATA.PKG_PLAT_LOG.P_RECORD_PLAT_LOG(P_COMPANY_ID         => 'b6cc680ad0f599cde0531164a8c0337f',
                                         P_APPLY_MODULE       => 'a_prematerial_211',
                                         P_BASE_TABLE         => 'GREY_PREPARE_PRODUCT_ORDER ',
                                         P_APPLY_PK_ID        => V_ID,
                                         P_ACTION_TYPE        => 'UPDATE',
                                         P_LOG_ID             => VO_LOG_ID,
                                         P_LOG_TYPE           => '00',
                                         P_LOG_MSG            => '接单' ||
                                                                 V_ID,
                                         P_OPERATE_FIELD      => 'PRODUCT_ORDER_ID',
                                         P_FIELD_TYPE         => 'VARCHAR2',
                                         P_OLD_CODE           => NULL,
                                         P_NEW_CODE           => NULL,
                                         P_OLD_VALUE          => 0,
                                         P_NEW_VALUE          => 1,
                                         P_USER_ID            => V_USERID,
                                         P_OPERATE_COMPANY_ID => V_OPR_COM,
                                         P_SEQ_NO             => 1,
                                         PO_LOG_ID            => VO_LOG_ID);*/

      
  
     ELSIF V_MATERIAL = 'SKU' THEN
       --MRP.COLOR_PREPARE_ORDER
        --根据GROUP_KEY查出sku相关信息 sku,编号，名称，颜色，单位，门幅，克重，规格，成分
        /*SELECT MAX(A.MATERIAL_SPU),MAX(A.PRO_SUPPLIER_CODE),MAX(A.MATER_SUPPLIER_CODE),MAX(A.WHETHER_INNER_MATER),MAX(A.MATERIAL_NAME),MAX(A.MATERIAL_COLOR),
          MAX(A.UNIT),MAX(A.SUPPLIER_MATERIAL_NAME),MAX(A.PRACTICAL_DOOR_WITH),MAX(A.GRAM_WEIGHT),MAX(A.MATERIAL_SPECIFICATIONS),MAX(A.FEATURES),
          MAX(A.INGREDIENTS),MAX(A.PREPARE_OBJECT),MAX(A.SUPPLIER_COLOR),MAX(A.SUPPLIER_SHADES)
          INTO V_SKU,V_PROSUP,V_MATESUP,V_ISINNER,V_MATENAME,V_YANSE,V_UNIT,V_SUPMATENAME,V_MENFU,V_KEZHONG,V_GUIGE,V_TEZHENGTU,V_CHENGFEN,V_BLDX,
               V_GYSYANSE,V_SEHAO
          FROM MRP.COLOR_PREPARE_ORDER A
         WHERE A.GROUP_KEY = V_GROUPKEY
           AND A.PREPARE_STATUS=1;*/
           
         SELECT *
           INTO V_REC_SKU
           FROM MRP.COLOR_PREPARE_ORDER A
          WHERE A.GROUP_KEY = V_GROUPKEY
            AND A.PREPARE_STATUS = 1
            AND ROWNUM = 1;
           
            IF /*V_TYPE ='CP'*/ V_REC_SKU.prepare_object = 0  OR V_TYPE = 'CP' THEN 
           V_ID :=MRP.PKG_PLAT_COMM.F_GET_DOCUNO(PI_TABLE_NAME  => 'MRP.COLOR_PREPARE_PRODUCT_ORDER',
                                          PI_COLUMN_NAME => 'PRODUCT_ORDER_ID',
                                          PI_PRE         =>'CKSC'||to_char(SYSDATE,'yyyymmdd') ,
                                          PI_SERAIL_NUM  =>5 );
         ELSIF V_REC_SKU.prepare_object = 1 OR V_TYPE = 'WL' THEN 
           V_ID :=MRP.PKG_PLAT_COMM.F_GET_DOCUNO(PI_TABLE_NAME  => 'MRP.COLOR_PREPARE_PRODUCT_ORDER',
                                          PI_COLUMN_NAME => 'PRODUCT_ORDER_ID',
                                          PI_PRE         =>'WKSC'||to_char(SYSDATE,'yyyymmdd') ,
                                          PI_SERAIL_NUM  =>5 );
         END IF;  
         
         INSERT INTO MRP.COLOR_PREPARE_PRODUCT_ORDER(PRODUCT_ORDER_ID,PRODUCT_STATUS,PREPARE_OBJECT,MATERIAL_SKU,PRO_SUPPLIER_CODE,MATER_SUPPLIER_CODE,WHETHER_INNER_MATER,MATERIAL_NAME,MATERIAL_COLOR,
         UNIT,SUPPLIER_MATERIAL_NAME,SUPPLIER_COLOR,SUPPLIER_SHADES,PRACTICAL_DOOR_WITH,GRAM_WEIGHT,MATERIAL_SPECIFICATIONS,FEATURES,INGREDIENTS,
         PLAN_PRODUCT_QUANTITY,CONTAIN_COLOR_PREPARE_NUM,RECEIVE_ID,RECEIVE_TIME,COMPLETE_NUM,RELATE_SKC,COMPANY_ID,CREATE_ID,CREATE_TIME,WHETHER_DEL)
         VALUES(V_ID,1,V_REC_SKU.prepare_object,V_REC_SKU.material_sku,V_REC_SKU.pro_supplier_code,V_REC_SKU.mater_supplier_code ,V_REC_SKU.whether_inner_mater,V_REC_SKU.material_name,V_REC_SKU.material_color,
         V_REC_SKU.unit,V_REC_SKU.supplier_material_name,V_REC_SKU.supplier_color,V_REC_SKU.supplier_shades,V_REC_SKU.practical_door_with,V_REC_SKU.gram_weight,V_REC_SKU.material_specifications,V_REC_SKU.features,V_REC_SKU.ingredients,
         V_ORDERAMOUNT,V_DOCUNUM,V_USERID,SYSDATE,V_ORDERAMOUNT,V_SKC,V_COMPANY_ID,V_USERID,SYSDATE,0);
     
     END IF; 
     V_ORDERID:=V_ID;
  
  END P_INS_PREPROORDER;
  
  --取消备料单表
PROCEDURE P_CANCEL_PREMATERIAL(V_USERID IN VARCHAR2,  --用户id
                               V_PREID  IN VARCHAR2,  --单据号
                               V_REASON IN VARCHAR2,
                               V_TYPE   IN VARCHAR2,-- --SKU/SPU
                               --V_MODE   IN VARCHAR2  --CP/WL
                               V_OPR_COM IN VARCHAR2 --操作人企业
                               ) IS 
                               
  --VO_LOG_ID VARCHAR2(32);                             
 BEGIN
   
  IF V_TYPE = 'SKU' THEN 
    UPDATE MRP.COLOR_PREPARE_ORDER T 
       SET T.PREPARE_STATUS =4,
           T.cancel_id = V_USERID,
           T.cancel_time = SYSDATE,
           T.CANCEL_REASON = V_REASON
      WHERE T.PREPARE_ORDER_ID =  V_PREID;  
  
  ELSIF V_TYPE = 'SPU'  THEN 
     scmdata.pkg_plat_log.p_document_change_trace(p_company_id              => 'b6cc680ad0f599cde0531164a8c0337f',
                                               p_document_id             => V_PREID,
                                               p_data_source_parent_code => 'PREMATERIAL_MANA_LOG',
                                               p_data_source_child_code  => '01',
                                               p_operate_company_id      => V_OPR_COM,
                                               p_user_id                 => V_USERID); 
  
     UPDATE MRP.GREY_PREPARE_ORDER T
       SET T.PREPARE_STATUS = 4,
           T.CANCEL_ID = V_USERID,
           T.cancel_time = SYSDATE,
           T.CANCEL_REASON = V_REASON
      WHERE T.PREPARE_ORDER_ID = V_PREID; 
       /*SCMDATA.PKG_PLAT_LOG.P_RECORD_PLAT_LOG(P_COMPANY_ID         => 'b6cc680ad0f599cde0531164a8c0337f',
                                         P_APPLY_MODULE       => 'a_prematerial_211_1',
                                         P_BASE_TABLE         => 'GREY_PREPARE_ORDER',
                                         P_APPLY_PK_ID        => V_PREID,
                                         P_ACTION_TYPE        => 'UPDATE',
                                         P_LOG_ID             => VO_LOG_ID,
                                         P_LOG_TYPE           => '01',
                                         P_LOG_MSG            => '取消备料单表' ||
                                                                 V_PREID,
                                         P_OPERATE_FIELD      => 'PREPARE_STATUS',
                                         P_FIELD_TYPE         => 'VARCHAR2',
                                         P_FIELD_DESC        => '取消备料单表 ',
                                         P_OLD_CODE           => 1,
                                         P_NEW_CODE           => 4,
                                         P_OLD_VALUE          => '待接单',
                                         P_NEW_VALUE          => '已取消',
                                         P_USER_ID            => V_USERID,
                                         P_OPERATE_COMPANY_ID => V_OPR_COM,
                                         P_SEQ_NO             => 1,
                                         PO_LOG_ID            => VO_LOG_ID,
                                         P_TYPE               => 0);
    
    \*IF vo_log_id IS NOT NULL THEN
      scmdata.pkg_plat_log.p_update_plat_logmsg(p_company_id        => 'b6cc680ad0f599cde0531164a8c0337f',
                                                p_log_id            => vo_log_id,
                                                p_is_logsmsg        => 1,
                                                p_is_splice_fields  => 0,
                                                p_is_show_memo_desc => 1);
    END IF;*\
    
   scmdata.pkg_plat_log.p_insert_plat_log_to_plm_or_mrp(p_log_id      => VO_LOG_ID,
                                                        p_log_msg     => '取消备料单:' ||V_PREID,
                                                        p_class_name  => '坯布备料单管理',
                                                        p_method_name => '取消备料单',
                                                        p_type        => 2)  ;*/
  END IF ;
 
 
 END;   
 
 --修改订单数量
 PROCEDURE P_UPD_ORDERAMOUNT(PI_USERID IN VARCHAR2, --用户
                            PI_PREID  IN VARCHAR2,  --单据号
                            PI_TYPE   IN VARCHAR2, --SKU/SPU
                            PI_ORDERAMOUNT IN VARCHAR2, --数量
                            V_OPR_COM IN VARCHAR2) IS 
   V_FLAG NUMBER; 
   V_OLD_NUM VARCHAR2(64);  
   --VO_LOG_ID VARCHAR2(32);                      
  BEGIN                          
    --校验数量是否符合规格
    
    SELECT NVL(MAX(1),0) INTO V_FLAG FROM dual WHERE 
      regexp_like( PI_ORDERAMOUNT,'^(([1-9]{1}[0-9]{0,8})|([0]{1}))((\.{1}[0-9]{1,2}$)|$)');
      
      IF V_FLAG = 0 THEN 
        RAISE_APPLICATION_ERROR(-20002, '【订单量】支持填写9位自然数，小数允许后2位!');
      ELSE 
        NULL;
      END IF;  
      
      IF PI_TYPE = 'SKU' THEN 
        
        SELECT A.ORDER_NUM
          INTO V_OLD_NUM
          FROM MRP.COLOR_PREPARE_ORDER A
          WHERE A.PREPARE_ORDER_ID= PI_PREID;
      
        IF V_OLD_NUM = PI_ORDERAMOUNT THEN
            RAISE_APPLICATION_ERROR(-20002,'修改数量与原数量一致，无需修改。');
        ELSE    
         UPDATE MRP.COLOR_PREPARE_ORDER A 
            SET A.ORDER_NUM=TO_NUMBER(PI_ORDERAMOUNT),
                A.UPDATE_TIME=SYSDATE,
                A.UPDATE_ID  = PI_USERID
           WHERE A.PREPARE_ORDER_ID= PI_PREID  ;
        END IF;
      
      
      ELSIF PI_TYPE = 'SPU' THEN 
         SELECT  A.ORDER_NUM
          INTO V_OLD_NUM
          FROM MRP.GREY_PREPARE_ORDER A
          WHERE A.PREPARE_ORDER_ID= PI_PREID;
      
        IF V_OLD_NUM = PI_ORDERAMOUNT THEN
            RAISE_APPLICATION_ERROR(-20002,'修改数量与原数量一致，无需修改。');
        ELSE    
          scmdata.pkg_plat_log.p_document_change_trace(p_company_id              => 'b6cc680ad0f599cde0531164a8c0337f',
                                               p_document_id             => PI_PREID,
                                               p_data_source_parent_code => 'PREMATERIAL_MANA_LOG',
                                               p_data_source_child_code  => '02',
                                               p_operate_company_id      => V_OPR_COM,
                                               p_user_id                 => PI_USERID); 
        
         UPDATE MRP.GREY_PREPARE_ORDER A 
            SET A.ORDER_NUM=TO_NUMBER(PI_ORDERAMOUNT),
                A.UPDATE_TIME=SYSDATE,
                A.UPDATE_ID  = PI_USERID
           WHERE A.PREPARE_ORDER_ID= PI_PREID  ;
           
           
           /*SCMDATA.PKG_PLAT_LOG.P_RECORD_PLAT_LOG(P_COMPANY_ID         => 'b6cc680ad0f599cde0531164a8c0337f',
                                         P_APPLY_MODULE       => 'a_prematerial_211_1',
                                         P_BASE_TABLE         => 'GREY_PREPARE_ORDER',
                                         P_APPLY_PK_ID        => PI_PREID,
                                         P_ACTION_TYPE        => 'UPDATE',
                                         P_LOG_ID             => VO_LOG_ID,
                                         P_LOG_TYPE           => '02',
                                         P_LOG_MSG            => '备料单号：' || PI_PREID|| '；' || chr(10) ||
                                                              '订单数量：' || PI_ORDERAMOUNT || '【操作前：'|| TO_CHAR(V_OLD_NUM) ||'】；',
                                         P_OPERATE_FIELD      => 'ORDER_NUM',
                                         P_FIELD_TYPE         => 'NUMBER',
                                         P_FIELD_DESC         => '修改订单数量 ',
                                         P_OLD_CODE           => NULL,
                                         P_NEW_CODE           => NULL,
                                         P_OLD_VALUE          => V_OLD_NUM,
                                         P_NEW_VALUE          => PI_ORDERAMOUNT,
                                         P_USER_ID            => PI_USERID,
                                         P_OPERATE_COMPANY_ID => V_OPR_COM,
                                         P_SEQ_NO             => 1,
                                         PO_LOG_ID            => VO_LOG_ID,
                                         P_TYPE               => 0); 
           
       \*    IF vo_log_id IS NOT NULL THEN
      scmdata.pkg_plat_log.p_update_plat_logmsg(p_company_id        => 'b6cc680ad0f599cde0531164a8c0337f',
                                                p_log_id            => vo_log_id,
                                                p_is_logsmsg        => 1,
                                                p_is_splice_fields  => 0,
                                                p_is_show_memo_desc => 1);
    END IF;*\
                                         
                                         
           scmdata.pkg_plat_log.p_insert_plat_log_to_plm_or_mrp(p_log_id      => VO_LOG_ID,
                                                        p_log_msg     => '修改备料单订单数量:' ||PI_ORDERAMOUNT||',修改前:'||V_OLD_NUM,
                                                        p_class_name  => '坯布备料单管理',
                                                        p_method_name => '修改订单数量',
                                                        p_type        => 2)  ;*/
        END IF;
      END IF;
      
  END;
  
   PROCEDURE P_UPD_EXARRTIME (PI_USERID IN VARCHAR2, --用户
                            PI_PREID  IN VARCHAR2,  --单据号
                            PI_TYPE   IN VARCHAR2, --SKU/SPU
                            PI_DATE   IN DATE,
                            V_OPR_COM IN VARCHAR2) IS 
  
  V_OLD_DATE DATE; 
  V_ORDER_DATE DATE;
  --VO_LOG_ID VARCHAR2(32);
  --V_FLAG    VARCHAR2(64);
  BEGIN
     IF PI_TYPE = 'SPU' THEN 
    --校验是否跟原日期一样
    SELECT TRUNC(A.EXPECT_ARRIVAL_TIME),TRUNC(A.ORDER_TIME)
      INTO V_OLD_DATE,V_ORDER_DATE
      FROM MRP.GREY_PREPARE_ORDER A
     WHERE A.PREPARE_ORDER_ID =   PI_PREID ;
      
     IF  V_OLD_DATE = PI_DATE THEN 
       
       RAISE_APPLICATION_ERROR(-20002, '请修改预计到仓日期。');
       
     ELSIF   PI_DATE <= V_ORDER_DATE         THEN 
       RAISE_APPLICATION_ERROR(-20002, '预计到仓日期不能修改早于下单日期！');
     
     ELSE 
        scmdata.pkg_plat_log.p_document_change_trace(p_company_id              => 'b6cc680ad0f599cde0531164a8c0337f',
                                               p_document_id             => PI_PREID,
                                               p_data_source_parent_code => 'PREMATERIAL_MANA_LOG',
                                               p_data_source_child_code  => '04',
                                               p_operate_company_id      => V_OPR_COM,
                                               p_user_id                 => PI_USERID);
     
       UPDATE MRP.GREY_PREPARE_ORDER A 
          SET A.EXPECT_ARRIVAL_TIME = PI_DATE+12/24,
              A.EXPECT_UPDATE_NUM = NVL(A.EXPECT_UPDATE_NUM,0)+1,
              A.UPDATE_ID=PI_USERID,
              A.UPDATE_TIME = SYSDATE
          WHERE A.PREPARE_ORDER_ID=PI_PREID;
          /*SCMDATA.PKG_PLAT_LOG.P_RECORD_PLAT_LOG(P_COMPANY_ID         => 'b6cc680ad0f599cde0531164a8c0337f',
                                         P_APPLY_MODULE       => 'a_prematerial_211',
                                         P_BASE_TABLE         => 'GREY_PREPARE_ORDER',
                                         P_APPLY_PK_ID        => PI_PREID,
                                         P_ACTION_TYPE        => 'UPDATE',
                                         P_LOG_ID             => VO_LOG_ID,
                                         P_LOG_TYPE           => '04',
                                         P_LOG_MSG            => '备料单号：' || PI_PREID || '；' || chr(10) ||
                                                                '修改预计到仓日期：' || TO_CHAR(PI_DATE+12/24,'YYYY-MM-DD HH24:MI:SS')  || '【操作前：' || TO_CHAR(V_OLD_DATE,'YYYY-MM-DD HH24:MI:SS')|| '】；',
                                         P_OPERATE_FIELD      => 'EXPECT_ARRIVAL_TIME',
                                         P_FIELD_TYPE         => 'DATE',
                                         P_FIELD_DESC         => '修改预计到仓日期 ',
                                         P_OLD_CODE           => NULL,
                                         P_NEW_CODE           => NULL,
                                         P_OLD_VALUE          => TO_CHAR(V_OLD_DATE,'YYYY-MM-DD HH24:MI:SS'),
                                         P_NEW_VALUE          => TO_CHAR(PI_DATE+12/24,'YYYY-MM-DD HH24:MI:SS'),
                                         P_USER_ID            => PI_USERID,
                                         P_OPERATE_COMPANY_ID => V_OPR_COM,
                                         P_SEQ_NO             => 1,
                                         PO_LOG_ID            => VO_LOG_ID);
                                         
     \*   IF vo_log_id IS NOT NULL THEN
      scmdata.pkg_plat_log.p_update_plat_logmsg(p_company_id        => 'b6cc680ad0f599cde0531164a8c0337f',
                                                p_log_id            => vo_log_id,
                                                p_is_logsmsg        => 1,
                                                p_is_splice_fields  => 0,
                                                p_is_show_memo_desc => 1);
    END IF;  *\                                
           scmdata.pkg_plat_log.p_insert_plat_log_to_plm_or_mrp(p_log_id      => VO_LOG_ID,
                                                        p_log_msg     => '备料单号:'||PI_PREID||'；' || chr(10) ||'预计到仓日期:' || TO_CHAR(PI_DATE+12/24,'YYYY-MM-DD HH24:MI:SS')||'修改前'||TO_CHAR(V_OLD_DATE,'YYYY-MM-DD HH24:MI:SS'),
                                                        p_class_name  => '坯布备料单管理',
                                                        p_method_name => '修改预计到仓日期',
                                                        p_type        => 2)  ;  */                            
     
  /*   VO_LOG_ID:=NULL;
     SELECT MAX(B.PRODUCT_ORDER_ID)
  INTO V_FLAG
  FROM MRP.GREY_PREPARE_ORDER B
 WHERE B.PREPARE_ORDER_ID = PI_PREID
   AND B.PRODUCT_ORDER_ID IS NOT NULL;
IF V_FLAG IS NOT NULL THEN
  SCMDATA.PKG_PLAT_LOG.P_RECORD_PLAT_LOG(P_COMPANY_ID         => 'b6cc680ad0f599cde0531164a8c0337f',
                                         P_APPLY_MODULE       => 'a_prematerial_211',
                                         P_BASE_TABLE         => 'GREY_PREPARE_ORDER',
                                         P_APPLY_PK_ID        => V_FLAG,
                                         P_ACTION_TYPE        => 'UPDATE',
                                         P_LOG_ID             => VO_LOG_ID,
                                         P_LOG_TYPE           => '04',
                                         P_LOG_MSG            => '备料单号:'||PI_PREID || chr(10) ||'修改预计到仓日期' ||TO_CHAR(PI_DATE +12 / 24,'YYYY-MM-DD HH24:MI:SS')||'【操作前:'||TO_CHAR(V_OLD_DATE,'YYYY-MM-DD HH24:MI:SS')||'】',
                                         P_OPERATE_FIELD      => 'EXPECT_ARRIVAL_TIME',
                                         P_FIELD_TYPE         => 'DATE',
                                         P_FIELD_DESC         => PI_PREID||'修改预计到仓日期 ',
                                         P_OLD_CODE           => NULL,
                                         P_NEW_CODE           => NULL,
                                         P_OLD_VALUE          => TO_CHAR(V_OLD_DATE,'YYYY-MM-DD HH24:MI:SS'),
                                         P_NEW_VALUE          => TO_CHAR(PI_DATE+12/24, 'YYYY-MM-DD HH24:MI:SS'),
                                         P_USER_ID            => PI_USERID,
                                         P_OPERATE_COMPANY_ID => V_OPR_COM,
                                         P_SEQ_NO             => 1,
                                         PO_LOG_ID            => VO_LOG_ID);

 \* IF VO_LOG_ID IS NOT NULL THEN
    SCMDATA.PKG_PLAT_LOG.P_UPDATE_PLAT_LOGMSG(P_COMPANY_ID        => 'b6cc680ad0f599cde0531164a8c0337f',
                                              P_LOG_ID            => VO_LOG_ID,
                                              P_IS_LOGSMSG        => 1,
                                              P_IS_SPLICE_FIELDS  => 0,
                                              P_IS_SHOW_MEMO_DESC => 1);
  END IF;*\
  SCMDATA.PKG_PLAT_LOG.P_INSERT_PLAT_LOG_TO_PLM_OR_MRP(P_LOG_ID      => VO_LOG_ID,
                                                       P_LOG_MSG     =>  '备料单号:'||PI_PREID|| chr(10) ||'预计到仓日期:' ||
                                                                        TO_CHAR(PI_DATE +12 / 24, 'YYYY-MM-DD HH24:MI:SS') ||
                                                                        '修改前' || TO_CHAR(V_OLD_DATE,'YYYY-MM-DD HH24:MI:SS'),
                                                       P_CLASS_NAME  => '坯布备料单管理',
                                                       P_METHOD_NAME => '修改预计到仓日期',
                                                       P_TYPE        => 2);

END IF;*/
     
     
     END IF;
     
      
     ELSIF PI_TYPE = 'SKU' THEN
       --校验是否跟原日期一样
    SELECT TRUNC(A.EXPECT_ARRIVAL_TIME)
      INTO V_OLD_DATE
      FROM MRP.COLOR_PREPARE_ORDER A
     WHERE A.PREPARE_ORDER_ID =   PI_PREID ;
      
     IF  V_OLD_DATE = PI_DATE THEN 
       
       RAISE_APPLICATION_ERROR(-20002, '请修改预计到仓日期。');
       
     ELSE
       UPDATE MRP.COLOR_PREPARE_ORDER A 
          SET A.EXPECT_ARRIVAL_TIME = PI_DATE+12/24,
              A.EXPECT_UPDATE_NUM = NVL(A.EXPECT_UPDATE_NUM,0)+1,
              A.UPDATE_ID=PI_USERID,
              A.UPDATE_TIME = SYSDATE
          WHERE A.PREPARE_ORDER_ID=PI_PREID;
     END IF;
       
     END IF; 
  
  END P_UPD_EXARRTIME;
  
  
  
 --取消生产单 
  
  PROCEDURE P_CANCEL_PROORDER (PI_TYPE IN VARCHAR2, --SKU/SPU
                             PI_USERID IN VARCHAR2, --用户id
                             PI_PROID  IN VARCHAR2, --单据号
                             PI_REASON IN VARCHAR2,
                             V_OPR_COM IN VARCHAR2) IS
   
  --VO_LOG_ID VARCHAR2(32);                          
BEGIN
  IF PI_TYPE = 'SKU' THEN 
    UPDATE MRP.COLOR_PREPARE_PRODUCT_ORDER Y
       SET Y.CANCEL_REASON = PI_REASON,
           Y.CANCEL_ID = PI_USERID,
           Y.CANCEL_TIME = SYSDATE,
           Y.PRODUCT_STATUS = 3
      WHERE Y.PRODUCT_ORDER_ID = PI_PROID;
      
      UPDATE  MRP.COLOR_PREPARE_ORDER  X
         SET X.CANCEL_REASON =  PI_REASON,  
             X.CANCEL_ID = PI_USERID,
             X.CANCEL_TIME = SYSDATE,
             X.PREPARE_STATUS =4 
        WHERE X.PRODUCT_ORDER_ID = PI_PROID  ;
     
  
  
  ELSIF PI_TYPE = 'SPU' THEN
    
    scmdata.pkg_plat_log.p_document_change_trace(p_company_id              => 'b6cc680ad0f599cde0531164a8c0337f',
                                               p_document_id             =>PI_PROID,
                                               p_data_source_parent_code => 'PREMATERIAL_MANA_LOG',
                                               p_data_source_child_code  => '05',
                                               p_operate_company_id      => V_OPR_COM,
                                               p_user_id                 => PI_USERID);
  
    UPDATE MRP.GREY_PREPARE_PRODUCT_ORDER Y
       SET Y.CANCEL_REASON = PI_REASON,
           Y.CANCEL_ID = PI_USERID,
           Y.CANCEL_TIME = SYSDATE,
           Y.PRODUCT_STATUS = 3
      WHERE Y.PRODUCT_ORDER_ID = PI_PROID;
      
      /*SCMDATA.PKG_PLAT_LOG.P_RECORD_PLAT_LOG(P_COMPANY_ID         => 'b6cc680ad0f599cde0531164a8c0337f',
                                         P_APPLY_MODULE       => 'a_prematerial_212',
                                         P_BASE_TABLE         => 'GREY_PREPARE_PRODUCT_ORDER',
                                         P_APPLY_PK_ID        => PI_PROID,
                                         P_ACTION_TYPE        => 'UPDATE',
                                         P_LOG_ID             => VO_LOG_ID,
                                         P_LOG_TYPE           => '05',
                                         P_LOG_MSG            => '取消生产单号:' ||
                                                                 PI_PROID,
                                         P_OPERATE_FIELD      => 'PRODUCT_STATUS',
                                         P_FIELD_TYPE         => 'NUMBER',
                                         P_OLD_CODE           => 1,
                                         P_NEW_CODE           => 3,
                                         P_OLD_VALUE          => '生产中',
                                         P_NEW_VALUE          => '已取消',
                                         P_USER_ID            => PI_USERID,
                                         P_OPERATE_COMPANY_ID => V_OPR_COM,
                                         P_SEQ_NO             => 1,
                                         PO_LOG_ID            => VO_LOG_ID);
                                         
        \* IF vo_log_id IS NOT NULL THEN
      scmdata.pkg_plat_log.p_update_plat_logmsg(p_company_id        => 'b6cc680ad0f599cde0531164a8c0337f',
                                                p_log_id            => vo_log_id,
                                                p_is_logsmsg        => 1,
                                                p_is_splice_fields  => 0,
                                                p_is_show_memo_desc => 1);
    END IF; *\                                
                                         
       scmdata.pkg_plat_log.p_insert_plat_log_to_plm_or_mrp(p_log_id      => VO_LOG_ID,
                                                        p_log_msg     => '取消生产单:' ||PI_PROID,
                                                        p_class_name  => '坯布备料单管理',
                                                        p_method_name => '取消订单',
                                                        p_type        => 2)  ;    */                                           
      
      FOR I IN (SELECT Y.PREPARE_ORDER_ID FROM MRP.GREY_PREPARE_ORDER Y WHERE Y.PRODUCT_ORDER_ID = PI_PROID AND Y.PREPARE_STATUS = 2)LOOP
      --VO_LOG_ID := NULL;  
       scmdata.pkg_plat_log.p_document_change_trace(p_company_id              => 'b6cc680ad0f599cde0531164a8c0337f',
                                               p_document_id             =>I.PREPARE_ORDER_ID,
                                               p_data_source_parent_code => 'PREMATERIAL_MANA_LOG',
                                               p_data_source_child_code  => '05',
                                               p_operate_company_id      => V_OPR_COM,
                                               p_user_id                 => PI_USERID);
      
      
      UPDATE MRP.GREY_PREPARE_ORDER X
         SET X.CANCEL_REASON =  PI_REASON,  
             X.CANCEL_ID = PI_USERID,
             X.CANCEL_TIME = SYSDATE,
             X.PREPARE_STATUS =4 
        WHERE X.PREPARE_ORDER_ID = I.PREPARE_ORDER_ID  ;
        /*SCMDATA.PKG_PLAT_LOG.P_RECORD_PLAT_LOG(P_COMPANY_ID         => 'b6cc680ad0f599cde0531164a8c0337f',
                                         P_APPLY_MODULE       => 'a_prematerial_212',
                                         P_BASE_TABLE         => 'GREY_PREPARE_ORDER',
                                         P_APPLY_PK_ID        => I.PREPARE_ORDER_ID,
                                         P_ACTION_TYPE        => 'UPDATE',
                                         P_LOG_ID             => VO_LOG_ID,
                                         P_LOG_TYPE           => '05',
                                         P_LOG_MSG            => '取消生产单号:' ||
                                                                 PI_PROID,
                                         P_OPERATE_FIELD      => 'PREPARE_STATUS',
                                         P_FIELD_TYPE         => 'NUMBER',
                                         P_OLD_CODE           => 2,
                                         P_NEW_CODE           => 4,
                                         P_OLD_VALUE          => '生产中',
                                         P_NEW_VALUE          => '已取消',
                                         P_USER_ID            => PI_USERID,
                                         P_OPERATE_COMPANY_ID => V_OPR_COM,
                                         P_SEQ_NO             => 1,
                                         PO_LOG_ID            => VO_LOG_ID);
        scmdata.pkg_plat_log.p_insert_plat_log_to_plm_or_mrp(p_log_id      => VO_LOG_ID,
                                                        p_log_msg     => \*'备料单号:'||I.PREPARE_ORDER_ID||*\'取消生产单号:' ||PI_PROID,
                                                        p_class_name  => '坯布备料单管理',
                                                        p_method_name => '取消订单',
                                                        p_type        => 2)  ;   */    
        
      END LOOP;  
  END IF;

END P_CANCEL_PROORDER;   

  FUNCTION F_CHECK_SPUSTOCK_ISEXISTS (PI_SUPCODE IN VARCHAR2,
                                      PI_MATECODE IN VARCHAR2,
                                      PI_SPU     IN VARCHAR2,
                                      PI_UNIT    IN VARCHAR2,
                                      PI_MODE    IN VARCHAR2) RETURN NUMBER IS 
   
   V_FLAG NUMBER;
   V_NUM NUMBER; 
  
  BEGIN      
                               
    IF PI_MODE = 'CP' THEN 
      SELECT COUNT(1)
      INTO V_FLAG
      FROM MRP.SUPPLIER_GREY_STOCK A
     WHERE A.PRO_SUPPLIER_CODE = PI_SUPCODE
       AND A.MATER_SUPPLIER_CODE =PI_MATECODE
       AND A.MATERIAL_SPU = PI_SPU
       AND A.UNIT = PI_UNIT;
       
       IF V_FLAG >0 THEN 
         V_NUM := 1;
       ELSE 
         V_NUM := 0;
       END IF;    
         
       
    ELSIF PI_MODE = 'WL' THEN 
      SELECT COUNT(1)
        INTO V_FLAG
      FROM  MRP.MATERIAL_GREY_STOCK B
      WHERE B.MATER_SUPPLIER_CODE =PI_MATECODE
        AND B.MATERIAL_SPU =  PI_SPU
        AND B.UNIT = PI_UNIT;
        IF V_FLAG >0 THEN 
         V_NUM := 1;
       ELSE 
         V_NUM := 0;
       END IF;  
       
     
   END IF;
   RETURN V_NUM;
      
    END  F_CHECK_SPUSTOCK_ISEXISTS; 
    
    
    PROCEDURE P_SPU_FINISH_PRODUCT(PI_PROID  IN VARCHAR2, --生产单号
                               PI_USERID IN VARCHAR2,   --用户id
                               PI_AMOUNT IN VARCHAR2,  --本次完成数量
                               PI_ISFINISH IN VARCHAR2,  --是否完成
                               PI_OPCOM   IN VARCHAR2) 
   IS 
   V_FENPIID VARCHAR2(32);
   V_REC MRP.GREY_PREPARE_PRODUCT_ORDER%ROWTYPE;
   V_PRECENT NUMBER;
   V_BLFENPI NUMBER;
   V_ID      VARCHAR2(32);
   V_SGIOB_REC MRP.MATERIAL_GREY_IN_OUT_BOUND%ROWTYPE;
   V_SGIOB_REC2 MRP.SUPPLIER_GREY_IN_OUT_BOUND%ROWTYPE;
   V_FLAG_ISSPUEXISTS NUMBER;
   P_SUPPL_REC MRP.SUPPLIER_GREY_STOCK%ROWTYPE;
   P_MATER_REC MRP.MATERIAL_GREY_STOCK%ROWTYPE;
   --VO_LOG_ID  VARCHAR2(32);
   V_OLD_BATCH_FINISH_NUM NUMBER;
BEGIN
  --获取生产单表信息
  SELECT * 
  INTO V_REC
  FROM MRP.GREY_PREPARE_PRODUCT_ORDER A
  WHERE A.PRODUCT_ORDER_ID=PI_PROID;
  
  --溢短装校验
 mrp.pkg_color_prepare_product_order.p_check_more_less_clause(p_cur_finished_num     => PI_AMOUNT,
                                                              p_finished_num         => V_REC.BATCH_FINISH_NUM,
                                                              p_order_num            => V_REC.PLAN_PRODUCT_QUANTITY,
                                                              p_rate                 => 0.03,
                                                              p_is_finished_preorder => PI_ISFINISH);

  --先生成 坯布备料分批完成单表
    V_FENPIID :=MRP.PKG_PLAT_COMM.f_get_docuno(pi_table_name  => 'GREY_PREPARE_BATCH_FINISH_ORDER',
                                               pi_column_name => 'PREPARE_BATCH_FINISH_ID',
                                               pi_pre         => PI_PROID,
                                               pi_serail_num  => 2);
                                               
      INSERT INTO MRP.GREY_PREPARE_BATCH_FINISH_ORDER(PREPARE_BATCH_FINISH_ID,PRODUCT_ORDER_ID,BATCH_FINISH_TIME,UNIT,
      BATCH_FINISH_NUM,BATCH_FINISH_PERCENT,BATCH_FINISH_ID,CREATE_ID,CREATE_TIME,WHETHER_DEL)
       VALUES(V_FENPIID,V_REC.PRODUCT_ORDER_ID,SYSDATE, V_REC.UNIT, PI_AMOUNT, ROUND(PI_AMOUNT/V_REC.PLAN_PRODUCT_QUANTITY,4)*100,PI_USERID,PI_USERID,SYSDATE,0);                              
                                               
                                               
  --更新坯布备料生产单表  
    V_PRECENT :=ROUND((NVL(V_REC.batch_finish_num,0)+PI_AMOUNT)/V_REC.plan_product_quantity,4);
    
    
    SELECT MAX(T.BATCH_FINISH_NUM)
    INTO V_OLD_BATCH_FINISH_NUM
    FROM MRP.GREY_PREPARE_PRODUCT_ORDER T
   WHERE T.PRODUCT_ORDER_ID = PI_PROID;
   
   scmdata.pkg_plat_log.p_document_change_trace(p_company_id              => 'b6cc680ad0f599cde0531164a8c0337f',
                                               p_document_id             => PI_PROID,
                                               p_data_source_parent_code => 'PREMATERIAL_MANA_LOG',
                                               p_data_source_child_code  => '06',
                                               p_operate_company_id      => PI_OPCOM,
                                               p_user_id                 => PI_USERID); 
   
  UPDATE MRP.GREY_PREPARE_PRODUCT_ORDER T
     SET T.batch_finish_num = NVL(V_REC.batch_finish_num,0)+PI_AMOUNT,
         T.batch_finish_percent = V_PRECENT*100,
         T.complete_num = CASE WHEN PI_ISFINISH = 1 THEN 0 ELSE V_REC.plan_product_quantity-(NVL(V_REC.batch_finish_num,0)+PI_AMOUNT) END,
         T.FINISH_ID = CASE WHEN PI_ISFINISH = 1 THEN PI_USERID ELSE V_REC.FINISH_ID END,
         T.FINISH_TIME = CASE WHEN PI_ISFINISH = 1 THEN SYSDATE ELSE V_REC.FINISH_TIME END,
         T.FINISH_NUM = CASE WHEN PI_ISFINISH = 1 THEN V_REC.BATCH_FINISH_NUM+PI_AMOUNT ELSE V_REC.FINISH_NUM END,
         T.product_status = CASE WHEN PI_ISFINISH = 1 THEN 2 ELSE V_REC.PRODUCT_STATUS END
   WHERE T.PRODUCT_ORDER_ID =  PI_PROID;    
    /*SCMDATA.PKG_PLAT_LOG.P_RECORD_PLAT_LOG(P_COMPANY_ID         => 'b6cc680ad0f599cde0531164a8c0337f',
                                         P_APPLY_MODULE       => 'a_prematerial_212',
                                         P_BASE_TABLE         => 'GREY_PREPARE_PRODUCT_ORDER',
                                         P_APPLY_PK_ID        => PI_PROID,
                                         P_ACTION_TYPE        => 'UPDATE',
                                         P_LOG_TYPE           => '06',
                                         P_LOG_MSG            => '完成生产单号:' ||
                                                                 PI_PROID||';完成数量:'||TO_CHAR(NVL(V_REC.batch_finish_num,0)+PI_AMOUNT)||'【操作前:' || v_old_batch_finish_num || '】；' || chr(10) ||
                                                                      (CASE
                                                                        WHEN PI_ISFINISH = 1 THEN
                                                                         '【生产单状态】:已完成；'
                                                                        ELSE
                                                                         NULL
                                                                      END),
                                         P_OPERATE_FIELD      => 'PRODUCT_STATUS',
                                         P_FIELD_TYPE         => 'NUMBER',
                                         P_OLD_CODE           => 1,
                                         P_NEW_CODE           => 2,
                                         P_OLD_VALUE          => '生产中',
                                         P_NEW_VALUE          => (CASE WHEN PI_ISFINISH = 1 THEN '已完成'  ELSE NULL  END),
                                         P_USER_ID            => PI_USERID,
                                         P_OPERATE_COMPANY_ID => PI_OPCOM,
                                         P_SEQ_NO             => 1,
                                         PO_LOG_ID            => VO_LOG_ID);
                                         
       scmdata.pkg_plat_log.p_insert_plat_log_to_plm_or_mrp(p_log_id      => VO_LOG_ID,
                                                        p_log_msg     => '完成生产单号:' ||PI_PROID||';完成数量:'||TO_CHAR(NVL(V_REC.batch_finish_num,0)+PI_AMOUNT),
                                                        p_class_name  => '坯布备料单管理',
                                                        p_method_name => '完成订单',
                                                        p_type        => 2)  ;      */                             
  
    --是否完成
      --更新坯布备料单表 
      --V_BLFENPI :=Y.ORDER_NUM * V_PRECENT;
      --V_BLFENPI :=PI_AMOUNT;
      /*  UPDATE MRP.GREY_PREPARE_ORDER Y 
       SET Y.BATCH_FINISH_PERCENT =  V_PRECENT,
           Y.BATCH_FINISH_NUM  = V_BLFENPI,
           Y.COMPLETE_NUM = Y.ORDER_NUM -V_BLFENPI  ,
           Y.FINISH_ID = CASE WHEN PI_ISFINISH = 1 THEN PI_USERID ELSE NULL END ,
           Y.FINISH_NUM = CASE WHEN PI_ISFINISH = 1 THEN V_BLFENPI ELSE NULL END ,
           Y.FINISH_TIME = CASE WHEN PI_ISFINISH = 1 THEN  SYSDATE ELSE NULL END ,
           Y.PREPARE_STATUS = CASE WHEN PI_ISFINISH = 1 THEN 3 ELSE Y.PREPARE_STATUS END
     WHERE Y.PRODUCT_ORDER_ID = PI_PROID
       AND    Y.PREPARE_ORDER_ID = Y.PREPARE_ORDER_ID;   */
       FOR I IN (SELECT prepare_order_id,order_num  FROM MRP.GREY_PREPARE_ORDER Y WHERE Y.PRODUCT_ORDER_ID=PI_PROID AND Y.PREPARE_STATUS=2) LOOP
  --VO_LOG_ID:=NULL;
  V_BLFENPI :=i.ORDER_NUM * V_PRECENT;
  UPDATE MRP.GREY_PREPARE_ORDER U
     SET U.BATCH_FINISH_PERCENT = V_PRECENT*100,
         U.BATCH_FINISH_NUM     = i.order_num*V_PRECENT,
         U.COMPLETE_NUM         = i.ORDER_NUM - i.order_num*V_PRECENT,
         U.FINISH_ID            = CASE WHEN PI_ISFINISH = 1 THEN  PI_USERID  ELSE  NULL END,
         U.FINISH_NUM           = CASE WHEN PI_ISFINISH = 1 THEN V_BLFENPI ELSE  NULL END,
         U.FINISH_TIME          = CASE WHEN PI_ISFINISH = 1 THEN SYSDATE ELSE  NULL END,
         U.PREPARE_STATUS       = CASE  WHEN PI_ISFINISH = 1 THEN  3 ELSE U.PREPARE_STATUS END
   WHERE U.PREPARE_ORDER_ID     = I.PREPARE_ORDER_ID;

  IF PI_ISFINISH = 1 THEN
    scmdata.pkg_plat_log.p_document_change_trace(p_company_id              => 'b6cc680ad0f599cde0531164a8c0337f',
                                               p_document_id             =>  I.PREPARE_ORDER_ID,
                                               p_data_source_parent_code => 'PREMATERIAL_MANA_LOG',
                                               p_data_source_child_code  => '06',
                                               p_operate_company_id      => PI_OPCOM,
                                               p_user_id                 => PI_USERID);
  /*SCMDATA.PKG_PLAT_LOG.P_RECORD_PLAT_LOG(P_COMPANY_ID         => 'b6cc680ad0f599cde0531164a8c0337f',
                                         P_APPLY_MODULE       => 'a_prematerial_212',
                                         P_BASE_TABLE         => 'GREY_PREPARE_ORDER',
                                         P_APPLY_PK_ID        => I.PREPARE_ORDER_ID,
                                         P_ACTION_TYPE        => 'UPDATE',
                                         P_LOG_ID             => VO_LOG_ID,
                                         P_LOG_TYPE           => '06',
                                         P_LOG_MSG            => '完成生产单号' ||
                                                                 PI_PROID\*||';完成数量:'||i.order_num*\,
                                         P_OPERATE_FIELD      => 'PREPARE_STATUS',
                                         P_FIELD_TYPE         => 'NUMBER',
                                         P_OLD_CODE           => NULL,
                                         P_NEW_CODE           => NULL,
                                         P_OLD_VALUE          => 2,
                                         P_NEW_VALUE          => 3,
                                         P_USER_ID            => PI_USERID,
                                         P_OPERATE_COMPANY_ID => PI_OPCOM,
                                         P_SEQ_NO             => 1,
                                         PO_LOG_ID            => VO_LOG_ID);


 scmdata.pkg_plat_log.p_insert_plat_log_to_plm_or_mrp(p_log_id      => VO_LOG_ID,
                                                        p_log_msg     => '完成生产单号:' ||PI_PROID,
                                                        p_class_name  => '坯布备料单管理',
                                                        p_method_name => '完成订单',
                                                        p_type        => 2)  ; */
                                                        
  ELSE 
    NULL;
  END IF;                                                        

END LOOP;    
      
  
  --坯布出入库单、
    --备料对象为供应商
    IF V_REC.PREPARE_OBJECT = 0 THEN 
      V_ID :=MRP.PKG_PLAT_COMM.f_get_docuno(pi_table_name  => 'MRP.SUPPLIER_GREY_IN_OUT_BOUND',
                                               pi_column_name => 'BOUND_NUM',
                                               pi_pre         => 'CKRK'||TO_CHAR(SYSDATE,'YYYYMMDD'),
                                               pi_serail_num  => 5);
                                               
V_SGIOB_REC2.BOUND_NUM :=  V_ID;--坯布出入库单号
V_SGIOB_REC2.ASCRIPTION := 1;--出入库归属，0出库1入库
V_SGIOB_REC2.BOUND_TYPE := 11;--坯布出入库类型，1色布备料出库/ 2盘亏出库/ 3临时坯转色出库/ 11品牌备料入库/ 12供应商现货入库/ 13盘盈入库/ 14临时补充入库/15 供应商色布入库
V_SGIOB_REC2.PRO_SUPPLIER_CODE :=  V_REC.PRO_SUPPLIER_CODE;--成品供应商编号
V_SGIOB_REC2.MATER_SUPPLIER_CODE :=  V_REC.MATER_SUPPLIER_CODE;--物料供应商编号
V_SGIOB_REC2.MATERIAL_SPU :=  V_REC.MATERIAL_SPU;--物料SPU
V_SGIOB_REC2.WHETHER_INNER_MATER :=  V_REC.WHETHER_INNER_MATER;--是否内部物料，0否1是
V_SGIOB_REC2.UNIT :=  V_REC.UNIT;--单位
V_SGIOB_REC2.NUM :=  ABS(PI_AMOUNT);--数量
V_SGIOB_REC2.STOCK_TYPE :=  1;--仓库类型，1品牌仓，2供应商仓
V_SGIOB_REC2.RELATE_NUM :=  V_REC.PRODUCT_ORDER_ID;--关联单号
V_SGIOB_REC2.RELATE_NUM_TYPE :=  4;--关联单号类型，1色布生产单/ 2坯布盘点单/ 3色布领料单/ 4坯布生产单/5面料采购单/6色布入库单
V_SGIOB_REC2.RELATE_SKC :=  V_REC.RELATE_SKC;--关联SKC
V_SGIOB_REC2.COMPANY_ID :=  V_REC.COMPANY_ID;--企业编码
V_SGIOB_REC2.CREATE_ID :=  PI_USERID;--创建者
V_SGIOB_REC2.CREATE_TIME :=  SYSDATE;--创建时间
V_SGIOB_REC2.UPDATE_ID :=  PI_USERID;--更新者
V_SGIOB_REC2.UPDATE_TIME :=  SYSDATE;--更新时间
V_SGIOB_REC2.WHETHER_DEL :=  0;--是否删除，0否1是
V_SGIOB_REC2.RELATE_PURCHASE_ORDER_NUM :=  NULL;--关联采购单号                

 MRP.PKG_SUPPLIER_GREY_IN_OUT_BOUND.p_insert_supplier_grey_in_out_bound(p_suppl_rec =>V_SGIOB_REC2);                    
     
 --坯布库存明细
  --用【成品供应商编号】+【物料供应商编号】+【物料SPU】+【单位】入参，判断在【供应商库存-坯布仓库存明细】中是否对应数据
      --校验库存明细是否有spu
   V_FLAG_ISSPUEXISTS:= MRP.PKG_PREMATERIAL_MANA_SPU.F_CHECK_SPUSTOCK_ISEXISTS(PI_SUPCODE => V_REC.PRO_SUPPLIER_CODE,  --成品供应商编号（主键）
                                                                    PI_MATECODE => V_REC.MATER_SUPPLIER_CODE, --物料供应商编号
                                                                    PI_SPU => V_REC.MATERIAL_SPU, --spu
                                                                    PI_UNIT => V_REC.UNIT, --单位
                                                                    PI_MODE => 'CP'  --CP/WL
                                                                    );
    
   IF V_FLAG_ISSPUEXISTS > 0 THEN 
     --有 覆盖
    UPDATE MRP.SUPPLIER_GREY_STOCK C
       SET C.BRAND_STOCK = NVL(C.BRAND_STOCK,0) + PI_AMOUNT,
           C.TOTAL_STOCK = NVL(C.TOTAL_STOCK,0)+PI_AMOUNT,
           C.UPDATE_ID = PI_USERID,
           C.UPDATE_TIME = SYSDATE
    WHERE C.PRO_SUPPLIER_CODE=V_REC.PRO_SUPPLIER_CODE
      AND C.MATER_SUPPLIER_CODE = V_REC.MATER_SUPPLIER_CODE
      AND C.MATERIAL_SPU = V_REC.MATERIAL_SPU
      AND C.UNIT = V_REC.UNIT;       
   ELSE 
    --无  插入
    
    P_SUPPL_REC.COLOR_CLOTH_STOCK_ID := mrp.pkg_plat_comm.f_get_uuid();--供应商坯布库存主键
    P_SUPPL_REC.PRO_SUPPLIER_CODE := V_REC.PRO_SUPPLIER_CODE;--成品供应商编号
    P_SUPPL_REC.MATER_SUPPLIER_CODE :=   V_REC.MATER_SUPPLIER_CODE;--物料供应商编号
    P_SUPPL_REC.MATERIAL_SPU :=  V_REC.MATERIAL_SPU;--物料SPU
    P_SUPPL_REC.WHETHER_INNER_MATER := V_REC.WHETHER_INNER_MATER;--是否内部物料，0否1是
    P_SUPPL_REC.UNIT :=  V_REC.UNIT;--单位
    P_SUPPL_REC.TOTAL_STOCK := PI_AMOUNT ;--总库存数
    P_SUPPL_REC.BRAND_STOCK := PI_AMOUNT ;--品牌仓库存数
    P_SUPPL_REC.SUPPLIER_STOCK := 0 ;--供应商仓库存数
    P_SUPPL_REC.COMPANY_ID := V_REC.COMPANY_ID;--企业编码
    P_SUPPL_REC.CREATE_ID :=  PI_USERID;--创建者
    P_SUPPL_REC.CREATE_TIME :=  SYSDATE;--创建时间
    P_SUPPL_REC.UPDATE_ID :=  PI_USERID;--更新者
    P_SUPPL_REC.UPDATE_TIME :=  SYSDATE;--更新时间
    P_SUPPL_REC.WHETHER_DEL := 0;--是否删除，0否1是
    
    MRP.PKG_SUPPLIER_GREY_STOCK.P_INSERT_SUPPLIER_GREY_STOCK(P_SUPPL_REC => P_SUPPL_REC);
    
    END IF;
 
    --备料对象为物料商
    ELSIF V_REC.PREPARE_OBJECT = 1 THEN 
      
      --物料商库存坯布出入库单表
      V_ID :=MRP.PKG_PLAT_COMM.f_get_docuno(pi_table_name  => 'MRP.MATERIAL_GREY_IN_OUT_BOUND',
                                               pi_column_name => 'BOUND_NUM',
                                               pi_pre         => 'WPRK'||TO_CHAR(SYSDATE,'YYYYMMDD'),
                                               pi_serail_num  => 5);
     
V_SGIOB_REC.BOUND_NUM :=  V_ID;--坯布出入库单号
V_SGIOB_REC.ASCRIPTION := 1;--出入库归属，0出库1入库
V_SGIOB_REC.BOUND_TYPE := 11;--出入库类型，1色布备料出库/ 2盘亏出库/ 3临时坯转色出库/ 4坯布备料出库/ 11品牌备料入库/ 12供应商现货入库/ 13盘盈入库/ 14临时补充入库
V_SGIOB_REC.MATER_SUPPLIER_CODE :=  V_REC.MATER_SUPPLIER_CODE;--物料供应商编号
V_SGIOB_REC.MATERIAL_SPU :=  V_REC.MATERIAL_SPU;--物料SPU
V_SGIOB_REC.UNIT :=  V_REC.UNIT;--单位
V_SGIOB_REC.NUM :=  ABS(PI_AMOUNT);--数量
V_SGIOB_REC.STOCK_TYPE :=  1;--仓库类型，1品牌仓，2供应商仓
V_SGIOB_REC.RELATE_NUM :=  V_REC.PRODUCT_ORDER_ID;--关联单号
V_SGIOB_REC.RELATE_NUM_TYPE := 4;--关联单号类型，1色布生产单/ 2坯布盘点单/ 3色布领料单/ 4坯布生产单/5面料采购单/6色布入库单
V_SGIOB_REC.RELATE_SKC :=  V_REC.RELATE_SKC;--关联SKC
V_SGIOB_REC.COMPANY_ID :=  V_REC.COMPANY_ID;--企业编码
V_SGIOB_REC.CREATE_ID :=  PI_USERID;--创建者
V_SGIOB_REC.CREATE_TIME :=  SYSDATE;--创建时间，入库时间
V_SGIOB_REC.UPDATE_ID :=  PI_USERID;--更新者
V_SGIOB_REC.UPDATE_TIME :=  SYSDATE;--更新时间
V_SGIOB_REC.WHETHER_DEL :=  0;--是否删除，0否1是
V_SGIOB_REC.RELATE_PURCHASE_ORDER_NUM :=  NULL;--关联采购单号    
                                         
    MRP.PKG_MATERIAL_GREY_IN_OUT_BOUND.P_INSERT_MATERIAL_GREY_IN_OUT_BOUND(P_MATER_REC => V_SGIOB_REC);
    
    --物料商坯布仓库存明细      
     -- 用【物料供应商编号】+【物料SPU】+【单位】入参，在【供应商库存-坯布仓库存明细】中找出对应数据：
      --校验是否存在该spu
       V_FLAG_ISSPUEXISTS:= MRP.PKG_PREMATERIAL_MANA_SPU.F_CHECK_SPUSTOCK_ISEXISTS(PI_SUPCODE => V_REC.PRO_SUPPLIER_CODE,  --成品供应商编号（主键）
                                                                    PI_MATECODE => V_REC.MATER_SUPPLIER_CODE, --物料供应商编号
                                                                    PI_SPU => V_REC.MATERIAL_SPU, --spu
                                                                    PI_UNIT => V_REC.UNIT, --单位
                                                                    PI_MODE => 'WL'  --CP/WL
                                                                    );
      --有， 覆盖
      IF V_FLAG_ISSPUEXISTS > 0 THEN 
      UPDATE MRP.MATERIAL_GREY_STOCK A
         SET A.TOTAL_STOCK = NVL(A.TOTAL_STOCK,0)+PI_AMOUNT,
             A.BRAND_STOCK = NVL(A.BRAND_STOCK,0) +PI_AMOUNT,
             A.UPDATE_ID = PI_USERID,
             A.UPDATE_TIME = SYSDATE
        WHERE A.MATER_SUPPLIER_CODE = V_REC.MATER_SUPPLIER_CODE
          AND A.MATERIAL_SPU = V_REC.MATERIAL_SPU
          AND A.UNIT =  V_REC.UNIT;    
      
      
      --无，  新增    
      ELSE 
P_MATER_REC.COLOR_CLOTH_STOCK_ID :=  mrp.pkg_plat_comm.f_get_uuid();--供应商坯布库存主键
P_MATER_REC.MATER_SUPPLIER_CODE :=  V_REC.MATER_SUPPLIER_CODE;--物料供应商编号
P_MATER_REC.MATERIAL_SPU :=  V_REC.MATERIAL_SPU;--物料SPU
P_MATER_REC.UNIT :=  V_REC.UNIT;--单位
P_MATER_REC.TOTAL_STOCK :=  PI_AMOUNT;--总库存数
P_MATER_REC.BRAND_STOCK :=  PI_AMOUNT;--品牌仓库存数
P_MATER_REC.SUPPLIER_STOCK :=  0;--供应商仓库存数
P_MATER_REC.COMPANY_ID := V_REC.COMPANY_ID;--企业编码
P_MATER_REC.CREATE_ID :=  PI_USERID;--创建者
P_MATER_REC.CREATE_TIME :=  SYSDATE;--创建时间
P_MATER_REC.UPDATE_ID :=  PI_USERID;--更新者
P_MATER_REC.UPDATE_TIME :=  SYSDATE;--更新时间
P_MATER_REC.WHETHER_DEL :=  0;--是否删除，0否1是
      
  MRP.PKG_MATERIAL_GREY_STOCK.P_INSERT_MATERIAL_GREY_STOCK(P_MATER_REC => P_MATER_REC);    
      END IF;                                 
                                               
    
    END IF;

END P_SPU_FINISH_PRODUCT;   
  
 FUNCTION F_CHECK_NUM(PI_NUM IN VARCHAR2) RETURN NUMBER IS 
  
  V_FLAG NUMBER;
  
BEGIN
   SELECT NVL(MAX(1),0) INTO V_FLAG FROM DUAL WHERE REGEXP_LIKE(PI_NUM,'^(([1-9]{1}[0-9]{0,6})|([0]{1}))((\.{1}[0-9]{1,2}$)|$)');
   RETURN V_FLAG;
END F_CHECK_NUM;

--主表接单更新坯布备料单表                               
PROCEDURE P_UPD_SPUPREMA(PI_USERID IN VARCHAR2,
                         PI_COMPANY_ID IN VARCHAR2,
                         PI_GROUP_KEY  IN VARCHAR2,
                         PI_PROOID    IN VARCHAR2,
                         V_OPR_COM    IN VARCHAR2) IS 
 --VO_LOG_ID VARCHAR2(32); 

BEGIN
  FOR cpo_rec IN (SELECT t.*
                      FROM MRP.GREY_PREPARE_ORDER t
                     WHERE t.company_id = PI_COMPANY_ID
                       AND t.group_key = PI_GROUP_KEY
                       AND t.prepare_status = 1
                       AND T.WHETHER_DEL = 0) LOOP
    --VO_LOG_ID:=NULL;  
    
    scmdata.pkg_plat_log.p_document_change_trace(p_company_id              => 'b6cc680ad0f599cde0531164a8c0337f',
                                               p_document_id             =>  CPO_REC.PREPARE_ORDER_ID,
                                               p_data_source_parent_code => 'PREMATERIAL_MANA_LOG',
                                               p_data_source_child_code  => '00',
                                               p_operate_company_id      => V_OPR_COM,
                                               p_user_id                 => PI_USERID);                 
    UPDATE MRP.GREY_PREPARE_ORDER T 
       SET T.PREPARE_STATUS = 2,
           T.RECEIVE_ID = PI_USERID,
           T.RECEIVE_TIME = SYSDATE,
           T.PRODUCT_ORDER_ID  = PI_PROOID,
           T.BATCH_FINISH_NUM = 0,
           T.BATCH_FINISH_PERCENT = 0,
           T.COMPLETE_NUM = CPO_REC.ORDER_NUM
      WHERE T.PREPARE_ORDER_ID = CPO_REC.PREPARE_ORDER_ID;     
      /*SCMDATA.PKG_PLAT_LOG.P_RECORD_PLAT_LOG(P_COMPANY_ID         => 'b6cc680ad0f599cde0531164a8c0337f',
                                         P_APPLY_MODULE       => 'a_prematerial_211',
                                         P_BASE_TABLE         => 'GREY_PREPARE_ORDER',
                                         P_APPLY_PK_ID        => CPO_REC.PREPARE_ORDER_ID,
                                         P_ACTION_TYPE        => 'UPDATE',
                                         P_LOG_ID             => VO_LOG_ID,
                                         P_LOG_TYPE           => '00',
                                         P_LOG_MSG            => '备料单号' ||
                                                                 CPO_REC.PREPARE_ORDER_ID||'被接单',
                                         P_OPERATE_FIELD      => 'PREPARE_STATUS',
                                         P_FIELD_TYPE         => 'NUMBER',
                                         P_OLD_CODE           => NULL,
                                         P_NEW_CODE           => NULL,
                                         P_OLD_VALUE          => 0,
                                         P_NEW_VALUE          => 1,
                                         P_USER_ID            => PI_USERID,
                                         P_OPERATE_COMPANY_ID => V_OPR_COM,
                                         P_SEQ_NO             => 1,
                                         PO_LOG_ID            => VO_LOG_ID);
                                         
    
    scmdata.pkg_plat_log.p_insert_plat_log_to_plm_or_mrp(p_log_id      => VO_LOG_ID,
                                                        p_log_msg     => '备料单号:' ||CPO_REC.PREPARE_ORDER_ID||'被接单',
                                                        p_class_name  => '坯布备料单管理',
                                                        p_method_name => '备料单接单',
                                                        p_type        => 2)  ;          */                           
  END LOOP;                 
 
END P_UPD_SPUPREMA;

PROCEDURE P_SPU_RECEIVE_ORDERS(PI_USERID IN VARCHAR2,
                               PI_COMPANY_ID IN VARCHAR2,
                               PI_OPR_COM  IN VARCHAR2,
                               PI_REC IN MRP.GREY_PREPARE_ORDER%ROWTYPE) IS 
   V_ID VARCHAR2(32); --生产单号  
   V_SKC         VARCHAR2(512); 
   V_ORDERAMOUNT  NUMBER;
   V_ORDERCOUNT   NUMBER;                       
BEGIN
  --生成SPU备料生产单
  
 SELECT LISTAGG(A.GOODS_SKC,'/') WITHIN GROUP (ORDER BY 1),SUM(A.ORDER_NUM),COUNT(A.PREPARE_ORDER_ID) 
    INTO V_SKC,V_ORDERAMOUNT,V_ORDERCOUNT
   FROM MRP.GREY_PREPARE_ORDER A
  WHERE A.GROUP_KEY = PI_REC.GROUP_KEY 
    AND A.PREPARE_STATUS=1
    AND A.WHETHER_DEL = 0
    AND A.COMPANY_ID = PI_COMPANY_ID;
    MRP.PKG_PREMATERIAL_MANA_SPU.P_INS_PREPROORDER(V_GROUPKEY    => PI_REC.GROUP_KEY,
                                                   V_SKC         => V_SKC,
                                                   V_DOCUNUM     => V_ORDERCOUNT,
                                                   V_ORDERAMOUNT => V_ORDERAMOUNT,
                                                   V_MATERIAL    => 'SPU',
                                                   V_USERID      => PI_USERID,
                                                   V_COMPANY_ID  => PI_COMPANY_ID,
                                                   V_OPR_COM     => PI_OPR_COM,                                                   
                                                   V_ORDERID     => V_ID);
  
  --更新备料单
  MRP.PKG_PREMATERIAL_MANA_SPU.P_UPD_SPUPREMA(PI_USERID     => PI_USERID,
                                              PI_COMPANY_ID => PI_COMPANY_ID,
                                              PI_GROUP_KEY  => PI_REC.GROUP_KEY,
                                              PI_PROOID     => V_ID,
                                              V_OPR_COM     => PI_OPR_COM);

END; 


 END PKG_PREMATERIAL_MANA_SPU;
/

