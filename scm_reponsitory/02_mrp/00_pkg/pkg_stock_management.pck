CREATE OR REPLACE PACKAGE MRP.PKG_STOCK_MANAGEMENT IS
  -- Author  : DYY153
  -- Created : 2023/2/22 11:33:52
  -- Purpose : 库存管理模块

 --根据平台企业id获取面辅料供应商编号 MRP.MRP_DETERMINE_SUPPLIER_ARCHIVES
  FUNCTION F_GET_WLSUPCODE(v_current_compid IN VARCHAR2,
                         v_need_compid    IN VARCHAR2) RETURN VARCHAR2;
  
  --根据面辅料供应商编号获取平台企业id                       
  FUNCTION F_GET_WLSUPID(v_supcode IN VARCHAR2,
                        v_need_compid    IN VARCHAR2) RETURN VARCHAR2 ;    
                        
  --成品供应商-库存明细-SKU                       
 FUNCTION F_GET_CPSKU_STOCK (V_COMPANY_ID IN VARCHAR2) RETURN CLOB; 
  
  --成品供应商-库存明细-SPU 
  FUNCTION F_GET_CPSPU_STOCK (V_COMPANY_ID IN VARCHAR2) RETURN CLOB;    
  
  --物料供应商-库存明细-SKU                       
  FUNCTION F_GET_WLSKU_STOCK (V_COMPANY_ID IN VARCHAR2) RETURN CLOB;  
  
  --物料供应商-库存明细-SPU
    FUNCTION F_GET_WLSPU_STOCK (V_COMPANY_ID IN VARCHAR2) RETURN CLOB;                

/*========================================================
 获取物料详情信息
  入参
  pi_material_id  sku/spu编号
  pi_type         类型 sku/spu
  pi_is_inner     是否内部物料 0否1是
  pi_supp_code    面料供应商编号

 ==========================================================*/
  FUNCTION f_query_material_detail(pi_material_id IN VARCHAR2,
                                  pi_type        IN VARCHAR2,
                                  pi_is_inner    IN VARCHAR2,
                                  pi_supp_code   IN VARCHAR2 ) RETURN CLOB;
   
  
  /*========================================================
   生成单据号
   入参
   PI_TABLE_NAME 表名 例：MRP.SUPPLIER_COLOR_INVENTORY
   PI_COLUMN_NAME  单据号字段名 例：INVENTORY_CODE
   PI_PRE        前缀 例：CKPD20230223
   PI_SERAIL_NUM 序号位数 例 5
   
  ========================================================*/         
                        
   FUNCTION F_GET_DOCUNO(PI_TABLE_NAME IN VARCHAR2,
                      PI_COLUMN_NAME IN VARCHAR2,
                      PI_PRE IN VARCHAR2,
                      PI_SERAIL_NUM  NUMBER) RETURN VARCHAR2;
   
   
   /*=======================================================
 供应商库存入库，更新库存明细表
 v_id       单据号
 v_num      入库数量
 v_type     CP/WL --区分成品供应商还是物料供应商
 V_mode     SPU/SKU --区分spu还是sku
 V_USER     操作人id
 ============================================================*/     
               
   PROCEDURE p_upd_suppstock(v_id IN VARCHAR2,
                          v_num IN VARCHAR2,
                          v_type IN VARCHAR2,--区分成品还是物料
                          V_mode IN VARCHAR2,  --区分spu还是sku
                          V_USER IN VARCHAR2);
   
   
   /*==========================================================
  库存入库生成成品供应商出入库单
  入参
  PI_ID   库存明细主键
  PI_NUM  入库数量
  PI_TYPE --SKU/SPU
  PI_USERID 操作人id
  
  出参
  PO_BOUNDID  出入库单号
  
  ================================================================*/                       
    PROCEDURE P_INS_CPBOUND(PI_ID     IN VARCHAR2,
                          PI_NUM    IN VARCHAR2,
                          PI_TYPE   IN VARCHAR2,  --SKU/SPU
                          PI_USERID IN VARCHAR2,
                          PO_BOUNDID OUT VARCHAR2);
    
 /*==========================================================
  查询成品供应商盘点单 
  入参
  PI_TYPE :0 色布 1 坯布
        
 
=============================================================*/                        
    FUNCTION F_GET_CPSELECT_INVENTORY(PI_TYPE IN VARCHAR2) RETURN CLOB;

/*==========================================================
编辑成品供应商盘点单 
 入参
 PI_CODE   :     单据号
 PI_USERID :     修改人
 PI_MEMO   :     修改内容
 PI_TYPE   :     0 色布 1 坯布
=============================================================*/  
   PROCEDURE P_UPD_CPINVENTORY (pi_code IN VARCHAR2,
                               pi_userid IN VARCHAR2,
                               pi_memo   IN VARCHAR2,
                               PI_TYPE   IN VARCHAR2,
                               PI_OPCOM  IN VARCHAR2);
   /*==========================================================
 删除成品供应商盘点单 
 入参
 PI_CODE   :     单据号
 PI_TYPE   :     0 色布 1 坯布
        
=============================================================*/                            
     PROCEDURE P_DEL_CPINVENTORY(PI_CODE IN VARCHAR2, PI_TYPE IN VARCHAR2);
   
 /*==================================================================
 查询成品供应商盘点单详情
 入参
 PI_CODE  盘点单号
 
 PI_TYPE  --SPU/SKU
 
======================================================================*/
  
     FUNCTION F_QUERY_CPINVENTORY_DETAIL(PI_CODE  IN VARCHAR2,
                                         PI_TYPE  IN VARCHAR2 --SPU/SKU
                                          ) RETURN CLOB;
    
 
  /*====================================================================
 查询成品供应商出入库明细
 入参  
 V_SUPINFOID  供应商档案id
 V_TYPE       SPU/SKU
 
 =======================================================================*/                                
     FUNCTION F_QUERY_CPBOUNT(V_SUPINFOID IN VARCHAR2, --供应商档案id
                         V_TYPE      IN VARCHAR2  --SPU/SKU
                         ) RETURN CLOB; 
                                                                                                                              
    --成品供应商色布盘点单提交                                              
    PROCEDURE P_SUBMIT_CPSKUPD(PI_PDID IN VARCHAR2,
                           PI_PDUSER IN VARCHAR2
                           ); 
                                
    --成品供应商坯布盘点单提交                       
    PROCEDURE P_SUBMIT_CPSPUPD(PI_PDID IN VARCHAR2,
                           PI_PDUSER IN VARCHAR2                          
                           );  
                                                      
      --物料供应商入库                             
      PROCEDURE P_INS_WLINBOUND(PI_ID     IN VARCHAR2,
                          PI_NUM    IN VARCHAR2,
                          PI_TYPE   IN VARCHAR2,  --SKU/SPU
                          PI_USERID IN VARCHAR2, 
                          PO_BOUNDID OUT VARCHAR2);                     
     
/*==================================================================
 查询物料供应商出入库明细
 入参  
 V_SUPINFOID  物料供应商编号
 V_TYPE       SPU/SKU
======================================================================*/                      
     FUNCTION F_QUERY_WLBOUNT(V_WLSUPID IN VARCHAR2, --物料供应商编号
                         V_TYPE      IN VARCHAR2  --SPU/SKU
                         ) RETURN CLOB; 
     
 /*==========================================================
查询成品供应商盘点单 
 入参
 PI_TYPE :0 色布 1 坯布
=============================================================*/ 
     
     FUNCTION F_GET_WLSELECT_INVENTORY(PI_TYPE IN VARCHAR2) RETURN CLOB; 
     
/*==========================================================
 删除成品供应商盘点单 
 入参
 PI_CODE   :     单据号
 PI_TYPE   :     0 色布 1 坯布
 
=============================================================*/

  PROCEDURE P_DEL_WLINVENTORY(PI_CODE IN VARCHAR2, PI_TYPE IN VARCHAR2);
  
/*=========================================================
成品供应商提交sku盘点单按钮
入参 
PI_PDID    盘点单号
PI_PDUSER  操作人id
=========================================================*/
    PROCEDURE P_SUBMIT_WLSKUPD(PI_PDID IN VARCHAR2,
                           PI_PDUSER IN VARCHAR2                          
                           );
                           
 /*==========================================================
编辑物料供应商盘点单 
 入参
 PI_CODE   :     单据号
 PI_USERID :     修改人
 PI_MEMO   :     修改内容
 PI_TYPE   :     0 色布 1 坯布
 PI_OPCOM  :     修改人当前企业id       
 
=============================================================*/ 
  
  PROCEDURE P_UPD_WLINVENTORY (pi_code IN VARCHAR2,
                               pi_userid IN VARCHAR2,
                               pi_memo   IN VARCHAR2,
                               PI_TYPE   IN VARCHAR2,
                               PI_OPCOM  IN VARCHAR2);                         
   
  
/*=============================================================
 成品供应商提交spu盘点单按钮 
  入参 
    PI_PDID    盘点单号
    PI_PDUSER  操作人id
===============================================================*/
  PROCEDURE P_SUBMIT_WLSPUPD(PI_PDID IN VARCHAR2,
                           PI_PDUSER IN VARCHAR2                          
                           );                        
                           
  /*=============================================================
查询盘点单详情
 入参
 PI_CODE   盘点单号
 PI_MODE   CP/WL
 PI_TYPE   SPU/SKU
==================================================================*/
  FUNCTION F_QUERY_INVENTORY_DETAIL(PI_CODE  IN VARCHAR2,
                                    PI_MODE  IN VARCHAR2 ,--CP/WL
                                    PI_TYPE  IN VARCHAR2 --SPU/SKU
                                    ) RETURN CLOB;  
  
  /*==============================================================
sku库存入库生成spu出入库单
入参
 V_MODE          WL/CP
 V_BOUNDNUM      出入库单号
 V_USERID        操作人id
 V_TYPE          SKU
=====================================================================*/                                  
  PROCEDURE P_CRESPUBOUND_BYSKU(V_MODE      IN VARCHAR2, --WL/CP
                              V_BOUNDNUM     IN VARCHAR2,  --出入库id
                              V_USERID    IN VARCHAR2,
                              V_TYPE      IN VARCHAR2);                                                         
                           
END PKG_STOCK_MANAGEMENT;
/

create or replace package body mrp.PKG_STOCK_MANAGEMENT is


 --根据平台企业id获取面辅料供应商编号
 FUNCTION F_GET_WLSUPCODE(v_current_compid IN VARCHAR2,
                          v_need_compid    IN VARCHAR2) RETURN VARCHAR2 IS
                         
 v_suppid VARCHAR2(32);
  BEGIN
    EXECUTE IMMEDIATE '
 SELECT MAX(A.SUPPLIER_CODE) 
   FROM MRP.MRP_DETERMINE_SUPPLIER_ARCHIVES A WHERE A.SUPPLIER_COMPANY_ID =''' ||
                      v_current_compid || '''
   AND A.COMPANY_ID = ''' || v_need_compid || ''''
      INTO v_suppid;

    RETURN v_suppid; 

END F_GET_WLSUPCODE;

  --根据面辅料供应商编号获取平台企业id
 FUNCTION F_GET_WLSUPID(v_supcode IN VARCHAR2,
                        v_need_compid    IN VARCHAR2) RETURN VARCHAR2 IS
                         
 v_suppid VARCHAR2(32);
  BEGIN
    EXECUTE IMMEDIATE '
 SELECT MAX(A.SUPPLIER_COMPANY_ID) 
   FROM MRP.MRP_DETERMINE_SUPPLIER_ARCHIVES A WHERE A.SUPPLIER_CODE =''' ||
                      v_supcode || '''
   AND A.COMPANY_ID = ''' || v_need_compid || ''''
      INTO v_suppid;

    RETURN v_suppid; 

END F_GET_WLSUPID;
 




FUNCTION F_GET_CPSKU_STOCK (V_COMPANY_ID IN VARCHAR2) RETURN CLOB IS 
  
V_SQL CLOB;

BEGIN
  V_SQL:=q'[SELECT a.COLOR_CLOTH_STOCK_ID,
    '"COL_1":'||a.material_sku||',"COL_2":'||a.MATER_SUPPLIER_CODE||',"COL_3":'||'SKU'||',"COL_4":'||a.whether_inner_mater||',"COL_5":'||a.COLOR_CLOTH_STOCK_ID||',"COL_6":'||'CP'||',"COL_7":'||A.PRO_SUPPLIER_CODE  PIN_ID,
      b.SUPPLIER_NAME MATERIAL_SUPP_NAME,   --物料商名称
        a.material_sku,   --物料sku
    b.MATERIAL_NAME,  --物料名称
b.MATERIAL_COLOR,--物料颜色
 A.UNIT,--单位
 A.TOTAL_STOCK,--总库存
 A.BRAND_STOCK,--品牌库存
 A.SUPPLIER_STOCK,--供应商库存
 S.ORDER_NUM1 + CP.UNC_NUM2 + FP.ND_NUM3 BE_IN_STOCK, --即将入库
 PL.UNPICK_NUM BE_OUT_STOCK, --即将出库
b.MATERIAL_CLASSIFICATION,--物料分类
b.PRACTICAL_DOOR_WITH,--门幅
b.GRAM_WEIGHT,--克重
b.MATERIAL_SPECIFICATIONS,--规格
B.MATERIAL_SPU MATERIAL_INGREDIENT,  --成分
B.FILE_UNIQUE   FEATURES_FILE,
B.SUPPLIER_MATERIAL_NAME,--供应商物料名称
b.SUPPLIER_COLOR,--供应商物料颜色
b.SUPPLIER_SHADES,--供应商色号
a.MATER_SUPPLIER_CODE,--物料商编号
(CASE  a.whether_inner_mater WHEN 0 THEN '否'
  WHEN 1 THEN '是' END ) IS_INNER_MATERIAL, --是否三福物料
NVL(U.NICK_NAME,U.USERNAME) UPDATE_ID,
A.UPDATE_TIME
FROM MRP.SUPPLIER_COLOR_CLOTH_STOCK A
 INNER JOIN (SELECT Z.MATERIAL_SKU, z.material_color,Y.MATERIAL_NAME, X.SUPPLIER_COLOR,
                    Y.MATERIAL_CLASSIFICATION,
                    Y.MATERIAL_SPECIFICATIONS, Y.PRACTICAL_DOOR_WITH,Y.MATERIAL_SPU,V.FILE_UNIQUE,
                    Y.GRAM_WEIGHT, X.DISPARITY, Y.UNIT, W.SUPPLIER_NAME,
                    X.SUPPLIER_SHADES,x.supplier_material_name, W.SUPPLIER_CODE
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
             SELECT Z.MATERIAL_SKU,y.material_color, X.MATERIAL_NAME, Z.SUPPLIER_COLOR,
                    X.MATERIAL_CLASSIFICATION,
                    X.MATERIAL_SPECIFICATIONS, X.PRACTICAL_DOOR_WITH,X.MATERIAL_SPU,V.FILE_UNIQUE,
                    X.GRAM_WEIGHT, Z.DISPARITY, X.UNIT,
                    W.SUPPLIER_ABBREVIATION SUPPLIER_NAME,
                    Z.SUPPLIER_SHADES, z.SUPPLIER_MATERIAL_NAME,W.SUPPLIER_CODE
               FROM MRP.MRP_INTERNAL_SUPPLIER_MATERIAL Z
              INNER JOIN MRP.MRP_INTERNAL_MATERIAL_SKU Y
                 ON Z.MATERIAL_SKU = Y.MATERIAL_SKU
              INNER JOIN MRP.MRP_INTERNAL_MATERIAL_SPU X
                 ON Y.MATERIAL_SPU = X.MATERIAL_SPU
              INNER JOIN MRP.MRP_DETERMINE_SUPPLIER_ARCHIVES W
                 ON W.SUPPLIER_CODE = Z.SUPPLIER_CODE
                 LEFT JOIN (SELECT A.THIRDPART_ID,
                    A.FILE_UNIQUE,
                    ROW_NUMBER() OVER(PARTITION BY A.THIRDPART_ID ORDER BY A.UPLOAD_TIME DESC) AS RN
               FROM MRP.MRP_PICTURE A
              WHERE  A.PICTURE_TYPE = 1) V
    ON V.THIRDPART_ID = x.FEATURES
   AND V.RN = 1) B
    ON A.MATERIAL_SKU = B.MATERIAL_SKU  AND A.MATER_SUPPLIER_CODE = B.SUPPLIER_CODE
  LEFT JOIN (SELECT T.PRO_SUPPLIER_CODE,
                    T.MATER_SUPPLIER_CODE,
                    T.MATERIAL_SKU,
                    T.UNIT,
                    SUM(UNPICK_NUM) UNPICK_NUM
               FROM MRP.PICK_LIST T
              WHERE T.WHETHER_DEL = 0
                AND T.PICK_STATUS = 0
              GROUP BY T.PRO_SUPPLIER_CODE,
                       T.MATER_SUPPLIER_CODE,
                       T.MATERIAL_SKU,
                       T.UNIT) PL
    ON PL.PRO_SUPPLIER_CODE = A.PRO_SUPPLIER_CODE
   AND PL.MATER_SUPPLIER_CODE = A.MATER_SUPPLIER_CODE
   AND PL.MATERIAL_SKU = A.MATERIAL_SKU
   AND PL.UNIT = A.UNIT
  LEFT JOIN (SELECT T.PRO_SUPPLIER_CODE,
                    T.MATER_SUPPLIER_CODE,
                    T.MATERIAL_SKU,
                    T.UNIT,
                    SUM(ORDER_NUM) ORDER_NUM1
               FROM MRP.COLOR_PREPARE_ORDER T
              WHERE T.PREPARE_STATUS IN (0, 1)
                AND T.WHETHER_DEL = 0
              GROUP BY T.PRO_SUPPLIER_CODE,
                       T.MATER_SUPPLIER_CODE,
                       T.MATERIAL_SKU,
                       T.UNIT) S
    ON S.PRO_SUPPLIER_CODE = A.PRO_SUPPLIER_CODE
   AND S.MATER_SUPPLIER_CODE = A.MATER_SUPPLIER_CODE
   AND S.MATERIAL_SKU = A.MATERIAL_SKU
   AND S.UNIT = A.UNIT
  LEFT JOIN (SELECT L.PRO_SUPPLIER_CODE,
                    L.MATER_SUPPLIER_CODE,
                    L.MATERIAL_SKU,
                    L.UNIT,
                    SUM(COMPLETE_NUM) UNC_NUM2
               FROM MRP.COLOR_PREPARE_PRODUCT_ORDER L
              WHERE L.WHETHER_DEL = 0
              GROUP BY L.PRO_SUPPLIER_CODE,
                       L.MATER_SUPPLIER_CODE,
                       L.MATERIAL_SKU,
                       L.UNIT) CP
    ON CP.PRO_SUPPLIER_CODE = A.PRO_SUPPLIER_CODE
   AND CP.MATER_SUPPLIER_CODE = A.MATER_SUPPLIER_CODE
   AND CP.MATERIAL_SKU = A.MATERIAL_SKU
   AND CP.UNIT = A.UNIT
  LEFT JOIN (SELECT F.PRO_SUPPLIER_CODE,
                    F.MATER_SUPPLIER_CODE,
                    F.MATERIAL_SKU,
                    F.UNIT,
                    SUM(NOT_DELIVER_AMOUNT) ND_NUM3
               FROM MRP.T_FABRIC_PURCHASE_SHEET F
              WHERE F.FABRIC_STATUS IN ('S01', 'S02')
                AND F.FABRIC_SOURCE = 1
              GROUP BY F.PRO_SUPPLIER_CODE,
                       F.MATER_SUPPLIER_CODE,
                       F.MATERIAL_SKU,
                       F.UNIT) FP
    ON FP.PRO_SUPPLIER_CODE = A.PRO_SUPPLIER_CODE
   AND FP.MATER_SUPPLIER_CODE = A.MATER_SUPPLIER_CODE
   AND FP.MATERIAL_SKU = A.MATERIAL_SKU
   AND FP.UNIT = A.UNIT  
  LEFT JOIN SCMDATA.SYS_USER U 
  ON U.USER_ID = UPDATE_ID  
  WHERE  A.PRO_SUPPLIER_CODE =(SELECT T.SUPPLIER_INFO_ID
                                 FROM SCMDATA.T_SUPPLIER_INFO T
                                WHERE T.SUPPLIER_COMPANY_ID = %DEFAULT_COMPANY_ID% AND T.COMPANY_ID = ']'||v_company_id||q'[')
   AND A.COMPANY_ID=']'||V_COMPANY_ID||q'['  AND A.WHETHER_DEL=0
  ORDER BY A.UPDATE_TIME DESC]'; 
 RETURN V_SQL;
END F_GET_CPSKU_STOCK;



FUNCTION F_GET_CPSPU_STOCK (V_COMPANY_ID IN VARCHAR2) RETURN CLOB IS 
  V_SQL CLOB;
  
  BEGIN
    V_SQL:=q'[

SELECT A.COLOR_CLOTH_STOCK_ID,
           '"COL_1":'||A.MATERIAL_SPU||',"COL_2":'||A.MATER_SUPPLIER_CODE||',"COL_3":'||'SPU'||',"COL_4":'||a.whether_inner_mater||',"COL_5":'||a.COLOR_CLOTH_STOCK_ID||',"COL_6":'||'CP'||',"COL_7":'||A.PRO_SUPPLIER_CODE  PIN_ID,
       B.SUPPLIER_NAME MATERIAL_SUPP_NAME,--物料商名称
       A.MATERIAL_SPU,--物料spu
       B.MATERIAL_NAME, --物料名称
       A.UNIT,  --单位
       A.TOTAL_STOCK,--总库存
       A.BRAND_STOCK,--品牌库存
       A.SUPPLIER_STOCK, --供应商库存
       PG.ORDER_NUM1+OG.COMPLETE_NUM2 BE_IN_STOCK, --即将入库
       KB.ORDER_NUM BE_OUT_STOCK,--即将出库
       SS.TOTAL_STOCK SKU_TOTAL_STOCK,
       SS.BRAND_STOCK SKU_BRAND_STOCK,
       SS.SUPPLIER_STOCK SKU_SUPP_STOCK,
       /*(SELECT SUM(U.TOTAL_STOCK)
          FROM MRP.SUPPLIER_COLOR_CLOTH_STOCK U
          LEFT JOIN MRP.MRP_OUTSIDE_MATERIAL_SKU I
            ON I.MATERIAL_SKU = U.MATERIAL_SKU
          LEFT JOIN MRP.MRP_INTERNAL_MATERIAL_SKU P
            ON U.MATERIAL_SKU = P.MATERIAL_SKU
         WHERE NVL(I.MATERIAL_SPU,P.MATERIAL_SPU) = A.MATERIAL_SPU
           AND U.PRO_SUPPLIER_CODE = A.PRO_SUPPLIER_CODE
           AND U.MATER_SUPPLIER_CODE = A.MATER_SUPPLIER_CODE
           AND U.UNIT = A.UNIT) SKU_TOTAL_STOCK,
       (SELECT SUM(U.BRAND_STOCK)
          FROM MRP.SUPPLIER_COLOR_CLOTH_STOCK U
          LEFT JOIN MRP.MRP_OUTSIDE_MATERIAL_SKU I
            ON I.MATERIAL_SKU = U.MATERIAL_SKU
          LEFT JOIN MRP.MRP_INTERNAL_MATERIAL_SKU P
           ON U.MATERIAL_SKU = P.MATERIAL_SKU
         WHERE NVL(I.MATERIAL_SPU,P.MATERIAL_SPU) = A.MATERIAL_SPU
           AND U.PRO_SUPPLIER_CODE = A.PRO_SUPPLIER_CODE
           AND U.MATER_SUPPLIER_CODE = A.MATER_SUPPLIER_CODE
           AND U.UNIT = A.UNIT) SKU_BRAND_STOCK,
       (SELECT SUM(U.SUPPLIER_STOCK)
          FROM MRP.SUPPLIER_COLOR_CLOTH_STOCK U
          LEFT JOIN MRP.MRP_OUTSIDE_MATERIAL_SKU I
            ON I.MATERIAL_SKU = U.MATERIAL_SKU
          LEFT JOIN MRP.MRP_INTERNAL_MATERIAL_SKU P
            ON U.MATERIAL_SKU = P.MATERIAL_SKU
         WHERE NVL(I.MATERIAL_SPU,P.MATERIAL_SPU) = A.MATERIAL_SPU
           AND U.PRO_SUPPLIER_CODE = A.PRO_SUPPLIER_CODE
           AND U.MATER_SUPPLIER_CODE = A.MATER_SUPPLIER_CODE
           AND U.UNIT = A.UNIT) SKU_SUPP_STOCK,*/
       B.MATERIAL_CLASSIFICATION,--物料分类
       B.PRACTICAL_DOOR_WITH,--门幅
       B.GRAM_WEIGHT,--克重
       B.MATERIAL_SPECIFICATIONS, --规格
       A.MATERIAL_SPU MATERIAL_INGREDIENT,  --成分
       B.FILE_UNIQUE   FEATURES_FILE,
       B.SUPPLIER_MATERIAL_NAME, --供应商物料名称
        A.MATER_SUPPLIER_CODE, --物料商编号
       (CASE A.WHETHER_INNER_MATER
          WHEN 0 THEN  '否'
          WHEN 1 THEN '是' END) IS_INNER_MATERIAL, --是否三福物料
         NVL(U.NICK_NAME,U.USERNAME) UPDATE_ID,
A.UPDATE_TIME   
  FROM MRP.SUPPLIER_GREY_STOCK A
 INNER JOIN (SELECT W.SUPPLIER_NAME,--物料商名称
                    W.SUPPLIER_CODE, --物料商编号
                    Z.MATERIAL_SPU, --spu
                    Z.MATERIAL_NAME, --物料名称
                    Z.MATERIAL_CLASSIFICATION, --物料分类
                    Z.PRACTICAL_DOOR_WITH, --门幅
                    Z.GRAM_WEIGHT, --克重
                    Z.MATERIAL_SPECIFICATIONS, --规格 
                    V.FILE_UNIQUE,
                    X.SUPPLIER_MATERIAL_NAME --供应商物料名称
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
             SELECT W.SUPPLIER_ABBREVIATION SUPPLIER_NAME,--物料商名称
                    X.SUPPLIER_CODE, --物料商编号
                    Z.MATERIAL_SPU, --spu
                    Z.MATERIAL_NAME,--物料名称
                    Z.MATERIAL_CLASSIFICATION, --物料分类
                    Z.PRACTICAL_DOOR_WITH,--门幅
                    Z.GRAM_WEIGHT,--克重
                    Z.MATERIAL_SPECIFICATIONS,--规格
                    V.FILE_UNIQUE,
                    X.SUPPLIER_MATERIAL_NAME --供应商物料名称
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
                  LEFT JOIN  (SELECT A.THIRDPART_ID,
                    A.FILE_UNIQUE,
                    ROW_NUMBER() OVER(PARTITION BY A.THIRDPART_ID ORDER BY A.UPLOAD_TIME DESC) AS RN
               FROM MRP.MRP_PICTURE A
              WHERE  A.PICTURE_TYPE = 1) V
    ON V.THIRDPART_ID = Z.FEATURES
   AND V.RN = 1  ) B
    ON B.MATERIAL_SPU = A.MATERIAL_SPU AND A.MATER_SUPPLIER_CODE = B.SUPPLIER_CODE
      LEFT JOIN (SELECT NVL(I.MATERIAL_SPU, P.MATERIAL_SPU) MATERIAL_SPU,
       U.PRO_SUPPLIER_CODE,
       U.MATER_SUPPLIER_CODE,
       U.UNIT,
       SUM(U.TOTAL_STOCK) TOTAL_STOCK,
       SUM(U.BRAND_STOCK) BRAND_STOCK,
       SUM(U.SUPPLIER_STOCK) SUPPLIER_STOCK
  FROM MRP.SUPPLIER_COLOR_CLOTH_STOCK U
  LEFT JOIN MRP.MRP_OUTSIDE_MATERIAL_SKU I
    ON I.MATERIAL_SKU = U.MATERIAL_SKU
  LEFT JOIN MRP.MRP_INTERNAL_MATERIAL_SKU P
    ON U.MATERIAL_SKU = P.MATERIAL_SKU
 GROUP BY NVL(I.MATERIAL_SPU, P.MATERIAL_SPU),
          U.PRO_SUPPLIER_CODE,
          U.MATER_SUPPLIER_CODE,
          U.UNIT
) SS ON SS.PRO_SUPPLIER_CODE = A.PRO_SUPPLIER_CODE
AND SS.MATER_SUPPLIER_CODE = A.MATER_SUPPLIER_CODE
AND SS.MATERIAL_SPU = A.MATERIAL_SPU
AND SS.UNIT = A.UNIT
  LEFT JOIN (SELECT GP.PRO_SUPPLIER_CODE,
       GP.MATER_SUPPLIER_CODE,
       GP.MATERIAL_SPU,
       GP.UNIT,
       SUM(ORDER_NUM) ORDER_NUM1
  FROM MRP.GREY_PREPARE_ORDER GP --坯布备料单表
 WHERE GP.PREPARE_STATUS IN (0, 1)
   AND GP.WHETHER_DEL = 0
 GROUP BY GP.PRO_SUPPLIER_CODE,
          GP.MATER_SUPPLIER_CODE,
          GP.MATERIAL_SPU,
          GP.UNIT) PG ON PG.PRO_SUPPLIER_CODE =  A.PRO_SUPPLIER_CODE
   AND PG.MATER_SUPPLIER_CODE = A.MATER_SUPPLIER_CODE
   AND PG.MATERIAL_SPU = A.MATERIAL_SPU
   AND PG.UNIT = A.UNIT
   LEFT JOIN ( SELECT GO.PRO_SUPPLIER_CODE,
                  GO.MATER_SUPPLIER_CODE,
                  GO.MATERIAL_SPU,
                  GO.UNIT,
                  SUM(COMPLETE_NUM) COMPLETE_NUM2
             FROM MRP.GREY_PREPARE_PRODUCT_ORDER GO
            WHERE GO.WHETHER_DEL = 0
            GROUP BY GO.PRO_SUPPLIER_CODE,
                     GO.MATER_SUPPLIER_CODE,
                     GO.MATERIAL_SPU,
                     GO.UNIT) OG ON OG.PRO_SUPPLIER_CODE =  A.PRO_SUPPLIER_CODE
   AND OG.MATER_SUPPLIER_CODE = A.MATER_SUPPLIER_CODE
   AND OG.MATERIAL_SPU = A.MATERIAL_SPU
   AND OG.UNIT = A.UNIT
  LEFT JOIN (SELECT NVL(IP.MATERIAL_SPU, OP.MATERIAL_SPU) MATERIAL_SPU,
       CO.PRO_SUPPLIER_CODE,
       CO.MATER_SUPPLIER_CODE,
       CO.UNIT,
       SUM(ORDER_NUM) ORDER_NUM
  FROM MRP.COLOR_PREPARE_ORDER CO
  LEFT JOIN MRP.MRP_OUTSIDE_MATERIAL_SKU OK
    ON OK.MATERIAL_SKU = CO.MATERIAL_SKU
  LEFT JOIN MRP.MRP_INTERNAL_MATERIAL_SKU IK
    ON IK.MATERIAL_SKU = CO.MATERIAL_SKU
  LEFT JOIN MRP.MRP_INTERNAL_MATERIAL_SPU IP
    ON IP.MATERIAL_SPU = IK.MATERIAL_SPU
  LEFT JOIN MRP.MRP_OUTSIDE_MATERIAL_SPU OP
    ON OP.MATERIAL_SPU = OK.MATERIAL_SPU
   AND OP.CREATE_FINISHED_SUPPLIER_CODE = OK.CREATE_FINISHED_SUPPLIER_CODE
 WHERE CO.WHETHER_DEL = 0
   AND CO.PREPARE_STATUS = 1
 GROUP BY NVL(IP.MATERIAL_SPU, OP.MATERIAL_SPU),
          CO.PRO_SUPPLIER_CODE,
          CO.MATER_SUPPLIER_CODE,
          CO.UNIT) KB ON KB.MATERIAL_SPU = A.MATERIAL_SPU
          AND KB.PRO_SUPPLIER_CODE = A.PRO_SUPPLIER_CODE
          AND KB.MATER_SUPPLIER_CODE = A.MATER_SUPPLIER_CODE
          AND KB.UNIT = A.UNIT
    LEFT JOIN SCMDATA.SYS_USER U 
  ON U.USER_ID = UPDATE_ID   
    WHERE A.PRO_SUPPLIER_CODE=(SELECT U.SUPPLIER_INFO_ID
                                 FROM SCMDATA.T_SUPPLIER_INFO U
                                WHERE U.SUPPLIER_COMPANY_ID=%DEFAULT_COMPANY_ID% AND U.COMPANY_ID=']'||V_COMPANY_ID||q'[' )
      AND A.COMPANY_ID=']'||v_company_id||q'['  AND A.WHETHER_DEL=0
    ORDER BY A.UPDATE_TIME DESC]'; 
    
    RETURN V_SQL;
  END F_GET_CPSPU_STOCK;


FUNCTION F_GET_WLSKU_STOCK (V_COMPANY_ID IN VARCHAR2) RETURN CLOB IS 
  V_SQL CLOB;
  
  BEGIN
    V_SQL:=q'[

SELECT A.MATERIAL_SKU, --物料sku
           '"COL_1":'||a.material_sku||',"COL_2":'||a.MATER_SUPPLIER_CODE||
           ',"COL_3":'||'SKU'||',"COL_4":'||1||',"COL_5":'||
           a.COLOR_CLOTH_STOCK_ID||',"COL_6":'||'WL'  PIN_ID,
       B.MATERIAL_NAME, --物料名称
       B.MATERIAL_COLOR, --物料颜色
       A.UNIT, --单位
       A.TOTAL_STOCK, --总库存
       A.BRAND_STOCK, --品牌库存
       A.SUPPLIER_STOCK, --供应商库存
       OP.COMPLETE_NUM2 + CP.ORDER_NUM1 BE_IN_STOCK,
       FP.NOT_DELIVER_AMOUNT BE_OUT_STOCK,
       B.MATERIAL_CLASSIFICATION, --物料分类
       B.PRACTICAL_DOOR_WITH, --门幅
       B.GRAM_WEIGHT, --克重
       B.MATERIAL_SPECIFICATIONS, --规格
       B.MATERIAL_SPU MATERIAL_INGREDIENT,  --成分
       B.FILE_UNIQUE   FEATURES_FILE,
       B.SUPPLIER_MATERIAL_NAME, --供应商物料名称
       B.SUPPLIER_COLOR, --供应商物料颜色
       B.SUPPLIER_SHADES, --供应商色号
       A.COLOR_CLOTH_STOCK_ID,
       NVL(U.NICK_NAME,U.USERNAME) UPDATE_ID,
      A.UPDATE_TIME 
  FROM MRP.MATERIAL_COLOR_CLOTH_STOCK A
 INNER JOIN (SELECT Z.MATERIAL_SKU,
                    Y.MATERIAL_COLOR,
                    X.MATERIAL_NAME,
                    Z.SUPPLIER_MATERIAL_NAME,
                    Z.SUPPLIER_COLOR,
                    X.MATERIAL_CLASSIFICATION,
                    X.MATERIAL_SPECIFICATIONS,
                    X.PRACTICAL_DOOR_WITH,
                    X.GRAM_WEIGHT,
                    Z.DISPARITY,
                    X.UNIT,
                    V.FILE_UNIQUE,
                    X.MATERIAL_SPU,
                    W.SUPPLIER_ABBREVIATION SUPPLIER_NAME,
                    W.BUSINESS_CONTACT,
                    W.CONTACT_PHONE,
                    W.DETAILED_ADDRESS,
                    Y.PREFERRED_NET_PRICE_OF_LARGE_GOOD,
                    Y.PREFERRED_PER_METER_PRICE_OF_LARGE_GOOD,
                    Z.SUPPLIER_SHADES,
                    Z.SUPPLIER_CODE
               FROM MRP.MRP_INTERNAL_SUPPLIER_MATERIAL Z
              INNER JOIN MRP.MRP_INTERNAL_MATERIAL_SKU Y
                 ON Z.MATERIAL_SKU = Y.MATERIAL_SKU
              INNER JOIN MRP.MRP_INTERNAL_MATERIAL_SPU X
                 ON Y.MATERIAL_SPU = X.MATERIAL_SPU
              INNER JOIN MRP.MRP_DETERMINE_SUPPLIER_ARCHIVES W
                 ON W.SUPPLIER_CODE = Z.SUPPLIER_CODE
                  LEFT JOIN  (SELECT A.THIRDPART_ID,
                    A.FILE_UNIQUE,
                    ROW_NUMBER() OVER(PARTITION BY A.THIRDPART_ID ORDER BY A.UPLOAD_TIME DESC) AS RN
               FROM MRP.MRP_PICTURE A
              WHERE  A.PICTURE_TYPE = 1) V
    ON V.THIRDPART_ID = X.FEATURES
   AND V.RN = 1 ) B
    ON A.MATERIAL_SKU = B.MATERIAL_SKU
   AND A.MATER_SUPPLIER_CODE = B.SUPPLIER_CODE
 INNER JOIN MRP.MRP_DETERMINE_SUPPLIER_ARCHIVES C
    ON C.SUPPLIER_CODE = A.MATER_SUPPLIER_CODE
  LEFT JOIN (SELECT O.MATER_SUPPLIER_CODE,
                    O.MATERIAL_SKU,
                    O.UNIT,
                    SUM(O.ORDER_NUM) ORDER_NUM1
               FROM MRP.COLOR_PREPARE_ORDER O
              WHERE O.PREPARE_STATUS IN (0, 1)
                AND O.WHETHER_DEL = 0
              GROUP BY O.MATER_SUPPLIER_CODE, O.MATERIAL_SKU, O.UNIT) CP
    ON CP.MATER_SUPPLIER_CODE = A.MATER_SUPPLIER_CODE
   AND CP.MATERIAL_SKU = A.MATERIAL_SKU
   AND CP.UNIT = A.UNIT
  LEFT JOIN (SELECT PO.MATERIAL_SKU,
                    PO.MATER_SUPPLIER_CODE,
                    PO.UNIT,
                    SUM(PO.COMPLETE_NUM) COMPLETE_NUM2
               FROM MRP.COLOR_PREPARE_PRODUCT_ORDER PO
              WHERE PO.WHETHER_DEL = 0
              GROUP BY PO.MATERIAL_SKU, PO.MATER_SUPPLIER_CODE, PO.UNIT) OP
    ON OP.MATERIAL_SKU = A.MATERIAL_SKU
   AND OP.MATER_SUPPLIER_CODE = A.MATER_SUPPLIER_CODE
   AND OP.UNIT = A.UNIT
  LEFT JOIN (SELECT TF.MATER_SUPPLIER_CODE,
                    TF.MATERIAL_SKU,
                    TF.UNIT,
                    SUM(NOT_DELIVER_AMOUNT) NOT_DELIVER_AMOUNT
               FROM MRP.T_FABRIC_PURCHASE_SHEET TF
              WHERE TF.FABRIC_STATUS IN ('S00', 'S01', 'S02')
              GROUP BY TF.MATER_SUPPLIER_CODE, TF.MATERIAL_SKU, TF.UNIT) FP
    ON FP.MATER_SUPPLIER_CODE = A.MATER_SUPPLIER_CODE
   AND FP.MATERIAL_SKU = A.MATERIAL_SKU
   AND FP.UNIT = A.UNIT   
  LEFT JOIN SCMDATA.SYS_USER U 
  ON U.USER_ID = UPDATE_ID     
 WHERE C.SUPPLIER_COMPANY_ID = %DEFAULT_COMPANY_ID%
   AND C.COMPANY_ID=']'||V_COMPANY_ID||q'['
   ORDER BY A.UPDATE_TIME DESC ]'; 
   RETURN V_SQL;
  
 END  F_GET_WLSKU_STOCK;
   
FUNCTION F_GET_WLSPU_STOCK (V_COMPANY_ID IN VARCHAR2) RETURN CLOB IS 
  V_SQL CLOB;
  
  BEGIN
    V_SQL:=q'[

SELECT A.COLOR_CLOTH_STOCK_ID,
           '"COL_1":'||A.MATERIAL_SPU||',"COL_2":'||A.MATER_SUPPLIER_CODE||',"COL_3":'||'SPU'||',"COL_4":'||'1'||',"COL_5":'||a.COLOR_CLOTH_STOCK_ID||',"COL_6":'||'WL'  PIN_ID,

       A.MATERIAL_SPU,--物料spu
       B.MATERIAL_NAME, --物料名称
       A.UNIT,  --单位
       A.TOTAL_STOCK,--总库存
       A.BRAND_STOCK,--品牌库存
       A.SUPPLIER_STOCK, --供应商库存
       PG.ORDER_NUM1+OG.COMPLETE_NUM2 BE_IN_STOCK,
       OC.ORDER_NUM BE_OUT_STOCK,
       SS.TOTAL_STOCK SKU_TOTAL_STOCK,
       SS.BRAND_STOCK SKU_BRAND_STOCK,
       SS.SUPPLIER_STOCK SKU_SUPP_STOCK,
       B.MATERIAL_CLASSIFICATION,--物料分类
       B.PRACTICAL_DOOR_WITH,--门幅
       B.GRAM_WEIGHT,--克重
       B.MATERIAL_SPECIFICATIONS, --规格
       B.MATERIAL_SPU MATERIAL_INGREDIENT,  --成分
       B.FILE_UNIQUE   FEATURES_FILE,
       B.SUPPLIER_MATERIAL_NAME, --供应商物料名称
        A.MATER_SUPPLIER_CODE,
        NVL(U.NICK_NAME,U.USERNAME) UPDATE_ID,
A.UPDATE_TIME
  FROM MRP.MATERIAL_GREY_STOCK A
 INNER JOIN (
             SELECT W.SUPPLIER_ABBREVIATION SUPPLIER_NAME,--物料商名称
                    W.SUPPLIER_CODE, --物料商编号
                    Z.MATERIAL_SPU, --spu
                    Z.MATERIAL_NAME,--物料名称
                    Z.MATERIAL_CLASSIFICATION, --物料分类
                    Z.PRACTICAL_DOOR_WITH,--门幅
                    Z.GRAM_WEIGHT,--克重
                    Z.MATERIAL_SPECIFICATIONS,--规格
                    V.FILE_UNIQUE,
                    X.SUPPLIER_MATERIAL_NAME --供应商物料名称
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
                  LEFT JOIN  (SELECT A.THIRDPART_ID,
                    A.FILE_UNIQUE,
                    ROW_NUMBER() OVER(PARTITION BY A.THIRDPART_ID ORDER BY A.UPLOAD_TIME DESC) AS RN
               FROM MRP.MRP_PICTURE A
              WHERE  A.PICTURE_TYPE = 1) V
    ON V.THIRDPART_ID = Z.FEATURES
   AND V.RN = 1 ) B
    ON B.MATERIAL_SPU = A.MATERIAL_SPU AND B.SUPPLIER_CODE = A.MATER_SUPPLIER_CODE
 INNER JOIN MRP.MRP_DETERMINE_SUPPLIER_ARCHIVES C ON C.SUPPLIER_CODE=A.MATER_SUPPLIER_CODE
  LEFT JOIN (SELECT NVL(I.MATERIAL_SPU, P.MATERIAL_SPU) MATERIAL_SPU,
                    U.MATER_SUPPLIER_CODE,
                    U.UNIT,
                    SUM(U.TOTAL_STOCK) TOTAL_STOCK,
                    SUM(U.BRAND_STOCK) BRAND_STOCK,
                    SUM(U.SUPPLIER_STOCK) SUPPLIER_STOCK
               FROM MRP.MATERIAL_COLOR_CLOTH_STOCK U
               LEFT JOIN MRP.MRP_OUTSIDE_MATERIAL_SKU I
                 ON I.MATERIAL_SKU = U.MATERIAL_SKU
               LEFT JOIN MRP.MRP_INTERNAL_MATERIAL_SKU P
                 ON U.MATERIAL_SKU = P.MATERIAL_SKU
              GROUP BY NVL(I.MATERIAL_SPU, P.MATERIAL_SPU),
                       U.MATER_SUPPLIER_CODE,
                       U.UNIT) SS
    ON SS.MATER_SUPPLIER_CODE = A.MATER_SUPPLIER_CODE
   AND SS.MATERIAL_SPU = A.MATERIAL_SPU
   AND SS.UNIT = A.UNIT
  LEFT JOIN (SELECT IP.MATERIAL_SPU MATERIAL_SPU,
                    CO.MATER_SUPPLIER_CODE,
                    CO.UNIT,
                    SUM(ORDER_NUM) ORDER_NUM
               FROM MRP.COLOR_PREPARE_ORDER CO
               LEFT JOIN MRP.MRP_INTERNAL_MATERIAL_SKU IK
                 ON IK.MATERIAL_SKU = CO.MATERIAL_SKU
               LEFT JOIN MRP.MRP_INTERNAL_MATERIAL_SPU IP
                 ON IP.MATERIAL_SPU = IK.MATERIAL_SPU
              WHERE CO.WHETHER_DEL = 0
                AND CO.PREPARE_STATUS = 1
              GROUP BY IP.MATERIAL_SPU, CO.MATER_SUPPLIER_CODE, CO.UNIT) OC
    ON OC.MATERIAL_SPU = A.MATERIAL_SPU
   AND OC.MATER_SUPPLIER_CODE = A.MATER_SUPPLIER_CODE
   AND OC.UNIT = A.UNIT
  LEFT JOIN (SELECT GP.MATER_SUPPLIER_CODE,
                    GP.MATERIAL_SPU,
                    GP.UNIT,
                    SUM(ORDER_NUM) ORDER_NUM1
               FROM MRP.GREY_PREPARE_ORDER GP --坯布备料单表
              WHERE GP.PREPARE_STATUS IN (0, 1)
                AND GP.WHETHER_DEL = 0
              GROUP BY GP.MATER_SUPPLIER_CODE, GP.MATERIAL_SPU, GP.UNIT) PG
    ON PG.MATER_SUPPLIER_CODE = A.MATER_SUPPLIER_CODE
   AND PG.MATERIAL_SPU = A.MATERIAL_SPU
   AND PG.UNIT = A.UNIT
  LEFT JOIN (SELECT GO.MATER_SUPPLIER_CODE,
                    GO.MATERIAL_SPU,
                    GO.UNIT,
                    SUM(COMPLETE_NUM) COMPLETE_NUM2
               FROM MRP.GREY_PREPARE_PRODUCT_ORDER GO
              WHERE GO.WHETHER_DEL = 0
              GROUP BY GO.MATER_SUPPLIER_CODE, GO.MATERIAL_SPU, GO.UNIT) OG
    ON OG.MATER_SUPPLIER_CODE = A.MATER_SUPPLIER_CODE
   AND OG.MATERIAL_SPU = A.MATERIAL_SPU
   AND OG.UNIT = A.UNIT 
  LEFT JOIN SCMDATA.SYS_USER U 
  ON U.USER_ID = UPDATE_ID  
    WHERE C.SUPPLIER_COMPANY_ID=%DEFAULT_COMPANY_ID%
      AND A.COMPANY_ID=']'||v_company_id||q'['  AND A.WHETHER_DEL=0
    ORDER BY A.UPDATE_TIME DESC ]'; 
 
   RETURN V_SQL;
    
  END  F_GET_WLSPU_STOCK; 

 /*----------------------------------------------------
 获取物料详情信息
  入参
  pi_material_id  sku/spu编号
  pi_type         类型 sku/spu
  pi_is_inner     是否内部物料 0否1是
  pi_supp_code    面料供应商编号


 ----------------------------------------------------------*/

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
    M.UNIT, ]'|| CASE WHEN pi_type = 'SKU' THEN 'M.MATERIAL_COLOR,' ELSE NULL end ||q'[
    M.PRACTICAL_DOOR_WITH, 
    M.GRAM_WEIGHT,
    M.MATERIAL_SPECIFICATIONS,
    M.MATERIAL_INGREDIENT,
    M.FILE_UNIQUE MATERIAL_PIC,
    M.SUPPLIER_MATERIAL_NAME,]'||CASE WHEN pi_type = 'SKU' THEN ' M.SUPPLIER_COLOR,
    M.SUPPLIER_SHADES, ' ELSE NULL END ||q'[ M.SUPPLIER_CODE MATER_SUPPLIER_CODE, ]'||
    CASE WHEN pi_is_inner = 0 THEN ' ''否'' IS_INNER_MATERIAL ' WHEN pi_is_inner = 1 THEN ' ''是'' IS_INNER_MATERIAL 'END  ;
    
    IF pi_type = 'SKU' THEN 
      V_F_SQL :=q'[ FROM (SELECT Z.MATERIAL_SKU,
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
      V_F_SQL :=q'[ FROM (SELECT W.SUPPLIER_NAME,
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
  
  
  
  /*-----------------------------------------------------------
   生成单据号
   入参
   PI_TABLE_NAME 表名 例：MRP.SUPPLIER_COLOR_INVENTORY
   PI_COLUMN_NAME  单据号字段名 例：INVENTORY_CODE
   PI_PRE        前缀 例：CKPD20230223
   PI_SERAIL_NUM 序号位数 例 5
   
  
  ------------------------------------------------------------*/
  
  
  FUNCTION F_GET_DOCUNO(PI_TABLE_NAME IN VARCHAR2, 
                      PI_COLUMN_NAME IN VARCHAR2,  --字段名 例：INVENTORY_CODE
                      PI_PRE IN VARCHAR2,          --前缀 例：CKPD20230223
                      PI_SERAIL_NUM  NUMBER        --序号位数 例 5
                      ) RETURN VARCHAR2 IS
                      
  v_docuno VARCHAR2(32);                   
  v_sql    VARCHAR2(4000);
BEGIN
  V_SQL :='SELECT * FROM '|| pi_table_name || ' WHERE ' || pi_column_name || ' LIKE '''||pi_pre||'%'' FOR UPDATE' ;
   EXECUTE IMMEDIATE V_sql;
  v_docuno :=mrp.pkg_plat_comm.f_getkeycode(pi_table_name  => PI_TABLE_NAME,
                                            pi_column_name => PI_COLUMN_NAME,
                                            pi_pre         => PI_PRE,
                                            pi_serail_num  => PI_SERAIL_NUM);
                                            
   RETURN v_docuno;                                         

END F_GET_DOCUNO;

 /*--------------------------------------------------------
 供应商库存入库，更新库存明细表
 v_id       单据号
 v_num      入库数量
 v_type     CP/WL --区分成品供应商还是物料供应商
 V_mode     SPU/SKU --区分spu还是sku
 V_USER     操作人id
 
 -----------------------------------------------------------*/

 PROCEDURE p_upd_suppstock(v_id IN VARCHAR2,
                          v_num IN VARCHAR2,
                          v_type IN VARCHAR2,--区分成品还是物料
                          V_mode IN VARCHAR2,  --区分spu还是sku
                          V_USER IN VARCHAR2)
  IS 
  --V_ORI_NUM NUMBER;
  V_NEW_TOTAL NUMBER;
  V_NEW_SUP_TOTAL NUMBER;
  V_SQL VARCHAR2(4000); --查询总量sql
  V_SQL1 VARCHAR2(4000);  --更新sql
  V_SQL2 VARCHAR2(4000);
  V_FLAG NUMBER;
  BEGIN
    SELECT NVL(MAX(1),0) INTO V_FLAG FROM DUAL WHERE REGEXP_LIKE(v_num,'^(([1-9]{1}[0-9]{0,6})|([0]{1}))((\.{1}[0-9]{1,2}$)|$)');
    IF V_FLAG =0 THEN 
     RAISE_APPLICATION_ERROR(-20002, '【入库数量】支持填写7位自然数，小数允许后2位!');
    ELSE
   IF v_type ='CP' THEN 
     V_SQL:=q'[SELECT NVL(SUPPLIER_STOCK,0) + ]'||v_num||q'[ FROM ]'||CASE WHEN V_MODE ='SKU' THEN ' MRP.SUPPLIER_COLOR_CLOTH_STOCK '
     WHEN V_MODE = 'SPU'THEN ' MRP.SUPPLIER_GREY_STOCK ' END ||' WHERE COLOR_CLOTH_STOCK_ID ='''||v_id||'''';
     --DBMS_OUTPUT.put_line(V_SQL);
     EXECUTE IMMEDIATE V_SQL INTO V_NEW_SUP_TOTAL;
     
    V_SQL2:=q'[SELECT NVL(TOTAL_STOCK,0) + ]'||v_num||q'[ FROM ]'||CASE WHEN V_MODE ='SKU' THEN ' MRP.SUPPLIER_COLOR_CLOTH_STOCK '
     WHEN V_MODE = 'SPU'THEN ' MRP.SUPPLIER_GREY_STOCK ' END ||' WHERE COLOR_CLOTH_STOCK_ID ='''||v_id||'''';
     --DBMS_OUTPUT.put_line(V_SQL);
     EXECUTE IMMEDIATE V_SQL2 INTO V_NEW_TOTAL;
     
     
     V_SQL1:='UPDATE '||CASE WHEN V_MODE ='SKU' THEN ' MRP.SUPPLIER_COLOR_CLOTH_STOCK '
     WHEN V_MODE = 'SPU'THEN ' MRP.SUPPLIER_GREY_STOCK ' END ||' SET SUPPLIER_STOCK='||V_NEW_SUP_TOTAL||',
        TOTAL_STOCK ='||V_NEW_TOTAL||', UPDATE_ID ='''||V_USER||''', UPDATE_TIME = SYSDATE WHERE COLOR_CLOTH_STOCK_ID ='''||v_id||'''';
     EXECUTE IMMEDIATE V_SQL1;
     --DBMS_OUTPUT.put_line(V_SQL1);
   
   ELSIF v_type ='WL' THEN 
     V_SQL:=q'[SELECT NVL(SUPPLIER_STOCK,0) + ]'||v_num||q'[ FROM ]'||CASE WHEN V_MODE ='SKU' THEN ' MRP.MATERIAL_COLOR_CLOTH_STOCK '
     WHEN V_MODE = 'SPU'THEN ' MRP.MATERIAL_GREY_STOCK ' END ||' WHERE COLOR_CLOTH_STOCK_ID ='''||v_id||'''';
     EXECUTE IMMEDIATE V_SQL INTO V_NEW_SUP_TOTAL;
     --DBMS_OUTPUT.put_line(V_SQL);
     
     V_SQL2:=q'[SELECT NVL(TOTAL_STOCK,0) + ]'||v_num||q'[ FROM ]'||CASE WHEN V_MODE ='SKU' THEN ' MRP.MATERIAL_COLOR_CLOTH_STOCK '
     WHEN V_MODE = 'SPU'THEN ' MRP.MATERIAL_GREY_STOCK ' END ||' WHERE COLOR_CLOTH_STOCK_ID ='''||v_id||'''';
     --DBMS_OUTPUT.put_line(V_SQL2);
     EXECUTE IMMEDIATE V_SQL2 INTO V_NEW_TOTAL;
     
     V_SQL1:='UPDATE '||CASE WHEN V_MODE ='SKU' THEN ' MRP.MATERIAL_COLOR_CLOTH_STOCK '
     WHEN V_MODE = 'SPU'THEN ' MRP.MATERIAL_GREY_STOCK ' END ||' SET SUPPLIER_STOCK='||V_NEW_SUP_TOTAL||',
       TOTAL_STOCK='||V_NEW_TOTAL ||', UPDATE_ID ='''||V_USER||''', UPDATE_TIME = SYSDATE WHERE COLOR_CLOTH_STOCK_ID ='''||v_id||'''';
     --DBMS_OUTPUT.put_line(V_SQL1);
     EXECUTE IMMEDIATE V_SQL1;
     
   
    END IF;
    END IF;
  END  p_upd_suppstock;       
  
  
  /*---------------------------------------------------------
  库存入库生成成品供应商出入库单
  入参
  PI_ID   库存明细主键
  PI_NUM  入库数量
  PI_TYPE --SKU/SPU
  PI_USERID 操作人id
  
  出参
  PO_BOUNDID  出入库单号
  
  ------------------------------------------------------------*/
  
  
  PROCEDURE P_INS_CPBOUND(PI_ID     IN VARCHAR2,
                          PI_NUM    IN VARCHAR2,
                          PI_TYPE   IN VARCHAR2,  --SKU/SPU
                          PI_USERID IN VARCHAR2,
                          PO_BOUNDID OUT VARCHAR2)

 IS
  V_NUMID    VARCHAR2(32);
  V_CSKU_REC MRP.SUPPLIER_COLOR_CLOTH_STOCK%ROWTYPE;
  V_CSPU_REC MRP.SUPPLIER_GREY_STOCK%ROWTYPE;
BEGIN
  IF PI_TYPE ='SKU' THEN 
  SELECT *
    INTO V_CSKU_REC
    FROM MRP.SUPPLIER_COLOR_CLOTH_STOCK T
   WHERE T.COLOR_CLOTH_STOCK_ID = PI_ID;

  V_NUMID := MRP.PKG_PLAT_COMM.F_GET_DOCUNO(PI_TABLE_NAME  => 'MRP.SUPPLIER_COLOR_IN_OUT_BOUND',
                                                   PI_COLUMN_NAME => 'BOUND_NUM',
                                                   PI_PRE         => 'CKRK' ||
                                                                     TO_CHAR(SYSDATE,
                                                                             'YYYYMMDD'),
                                                   PI_SERAIL_NUM  => 5);
  INSERT INTO MRP.SUPPLIER_COLOR_IN_OUT_BOUND
    (BOUND_NUM,ASCRIPTION,BOUND_TYPE,PRO_SUPPLIER_CODE,MATER_SUPPLIER_CODE,MATERIAL_SKU,WHETHER_INNER_MATER,
     UNIT,NUM,STOCK_TYPE,COMPANY_ID,CREATE_ID,CREATE_TIME,UPDATE_ID,UPDATE_TIME,WHETHER_DEL)
  VALUES
    (V_NUMID,1, 11, V_CSKU_REC.PRO_SUPPLIER_CODE, V_CSKU_REC.MATER_SUPPLIER_CODE,V_CSKU_REC.MATERIAL_SKU,V_CSKU_REC.WHETHER_INNER_MATER,
     V_CSKU_REC.UNIT,ABS(to_number(PI_NUM)),2,'b6cc680ad0f599cde0531164a8c0337f',PI_USERID,SYSDATE,PI_USERID, SYSDATE,0);
   ELSIF PI_TYPE = 'SPU' THEN 
     SELECT *
    INTO V_CSPU_REC
    FROM MRP.SUPPLIER_GREY_STOCK T
   WHERE T.COLOR_CLOTH_STOCK_ID = PI_ID;
   
   V_NUMID := MRP.PKG_PLAT_COMM.F_GET_DOCUNO(PI_TABLE_NAME  => 'MRP.SUPPLIER_GREY_IN_OUT_BOUND',
                                                   PI_COLUMN_NAME => 'BOUND_NUM',
                                                   PI_PRE         => 'CPRK' ||
                                                                     TO_CHAR(SYSDATE,
                                                                             'YYYYMMDD'),
                                                   PI_SERAIL_NUM  => 5);
   INSERT INTO MRP.SUPPLIER_GREY_IN_OUT_BOUND(BOUND_NUM,ASCRIPTION,BOUND_TYPE,PRO_SUPPLIER_CODE,MATER_SUPPLIER_CODE,MATERIAL_SPU,WHETHER_INNER_MATER,UNIT,
   NUM,STOCK_TYPE,COMPANY_ID,CREATE_ID,CREATE_TIME,UPDATE_ID,UPDATE_TIME,WHETHER_DEL)
   VALUES
   (V_NUMID,1,12,V_CSPU_REC.PRO_SUPPLIER_CODE, V_CSPU_REC.MATER_SUPPLIER_CODE,V_CSPU_REC.MATERIAL_SPU,V_CSPU_REC.WHETHER_INNER_MATER,V_CSPU_REC.UNIT,
    ABS(TO_NUMBER(PI_NUM)),2,'b6cc680ad0f599cde0531164a8c0337f',PI_USERID,SYSDATE,PI_USERID, SYSDATE,0);
   END IF;  
  PO_BOUNDID:=V_NUMID;
END P_INS_CPBOUND;   

/*==========================================================
查询成品供应商盘点单 
 入参
 PI_TYPE :0 色布 1 坯布
        
 
=============================================================*/

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
         WHERE Z.USER_ID = :USER_ID
           AND Y.PAUSE = 0
           AND Y.COMPANY_ID =%DEFAULT_COMPANY_ID%
           /*AND (Y.COMPANY_ID = C.SUPPLIER_COMPANY_ID OR Y.COMPANY_ID=A.COMPANY_ID)*/) INVENTORY_PARTY, ]' || CASE WHEN pi_type=0 THEN '
            ''"COL_1":''||A.INVENTORY_CODE||'',"COL_2":''||''SKU''||'',"COL_3":''||''CP'' PIN_ID
            FROM MRP.SUPPLIER_COLOR_INVENTORY A '
           WHEN pi_type = 1 THEN ' 
              ''"COL_1":''||A.INVENTORY_CODE||'',"COL_2":''||''SPU''||'',"COL_3":''||''CP'' PIN_ID
             FROM MRP.SUPPLIER_GREY_INVENTORY A ' END ||q'[ LEFT JOIN SCMDATA.SYS_USER B
    ON A.CREATE_ID = B.USER_ID
 INNER JOIN SCMDATA.T_SUPPLIER_INFO C ON A.PRO_SUPPLIER_CODE=C.SUPPLIER_INFO_ID 
 WHERE A.WHETHER_DEL=0 
   AND A.PRO_SUPPLIER_CODE=(SELECT T.SUPPLIER_INFO_ID
                              FROM SCMDATA.T_SUPPLIER_INFO T WHERE T.SUPPLIER_COMPANY_ID=%DEFAULT_COMPANY_ID%
                               AND T.COMPANY_ID='b6cc680ad0f599cde0531164a8c0337f')
   AND A.COMPANY_ID='b6cc680ad0f599cde0531164a8c0337f' 
   ORDER BY A.END_TIME DESC  ]' ;       
  --DBMS_OUTPUT.put_line(V_S_SQL);
  RETURN V_S_SQL;
  END F_GET_CPSELECT_INVENTORY; 
  
  
  /*==========================================================
编辑成品供应商盘点单 
 入参
 PI_CODE   :     单据号
 PI_USERID :     修改人
 PI_MEMO   :     修改内容
 PI_TYPE   :     0 色布 1 坯布
        
=============================================================*/
  
  
  PROCEDURE P_UPD_CPINVENTORY (pi_code IN VARCHAR2,
                               pi_userid IN VARCHAR2,
                               pi_memo   IN VARCHAR2,
                               PI_TYPE   IN VARCHAR2,
                               PI_OPCOM  IN VARCHAR2) IS 
 V_SQL CLOB;                            
 V_DATE VARCHAR2(64);                            
BEGIN
  --校验结束时间
  V_SQL:=q'[SELECT NVL(to_char(END_TIME+90,'yyyymmdd'),0)
  FROM  ]'||CASE WHEN pi_type = 0 THEN ' MRP.SUPPLIER_COLOR_INVENTORY ' WHEN pi_type = 1 THEN ' MRP.SUPPLIER_GREY_INVENTORY ' END ||' WHERE INVENTORY_CODE = '''||pi_code||'''';
 
 EXECUTE IMMEDIATE V_SQL INTO V_DATE;
 IF V_DATE <>0 AND TO_CHAR(SYSDATE,'YYYYMMDD') > V_DATE THEN 
   RAISE_APPLICATION_ERROR(-20002,'盘点结束已超90天，不可再编辑盘点备注！');
 ELSE
   BEGIN
  scmdata.pkg_plat_log.p_document_change_trace(p_company_id              => 'b6cc680ad0f599cde0531164a8c0337f',
                                               p_document_id             => PI_CODE,
                                               p_data_source_parent_code => 'STOCK_MANA_LOG',
                                               p_data_source_child_code  => '01',
                                               p_operate_company_id      => PI_OPCOM ,
                                               p_user_id                 => PI_USERID);
END;    
 
   IF PI_TYPE =0 THEN 
     UPDATE MRP.SUPPLIER_COLOR_INVENTORY T
        SET T.REMARKS     = PI_MEMO,
            T.UPDATE_ID   = PI_USERID,
            T.UPDATE_TIME = SYSDATE,
            T.UPDATE_COMPANY_ID=PI_OPCOM
      WHERE T.INVENTORY_CODE = PI_CODE;
   ELSIF PI_TYPE =1 THEN
       UPDATE MRP.SUPPLIER_GREY_INVENTORY T
        SET T.REMARKS     = PI_MEMO,
            T.UPDATE_ID   = PI_USERID,
            T.UPDATE_TIME = SYSDATE,
            T.UPDATE_COMPANY_ID = PI_OPCOM
      WHERE T.INVENTORY_CODE = PI_CODE;
   END IF;
     
 END IF;

END P_UPD_CPINVENTORY; 

  /*==========================================================
 删除成品供应商盘点单 
 入参
 PI_CODE   :     单据号
 PI_TYPE   :     0 色布 1 坯布
        
=============================================================*/

  PROCEDURE P_DEL_CPINVENTORY(PI_CODE IN VARCHAR2, PI_TYPE IN VARCHAR2) IS
    V_SQL  CLOB;
    V_FLAG VARCHAR2(64);
  BEGIN
    V_SQL := q'[SELECT NVL(to_char(END_TIME,'yyyymmdd'),0)
  FROM  ]' || CASE
               WHEN PI_TYPE = 0 THEN
                ' MRP.SUPPLIER_COLOR_INVENTORY '
               WHEN PI_TYPE = 1 THEN
                ' MRP.SUPPLIER_GREY_INVENTORY '
             END || ' WHERE INVENTORY_CODE = ''' || PI_CODE || '''';
  
    EXECUTE IMMEDIATE V_SQL  INTO V_FLAG;
    --DBMS_OUTPUT.put_line(V_SQL);
    
    IF V_FLAG = 0 THEN
      IF PI_TYPE = 0 THEN
        UPDATE MRP.SUPPLIER_COLOR_INVENTORY T
           SET T.WHETHER_DEL = 1
         WHERE T.INVENTORY_CODE = PI_CODE;
        UPDATE MRP.SUPPLIER_COLOR_INVENTORY_DETAIL A
          SET A.WHETHER_DEL=1
          WHERE A.INVENTORY_CODE= PI_CODE;
      ELSIF PI_TYPE = 1 THEN
        UPDATE MRP.SUPPLIER_GREY_INVENTORY T
           SET T.WHETHER_DEL = 1
         WHERE T.INVENTORY_CODE = PI_CODE;
        UPDATE MRP.SUPPLIER_GREY_INVENTORY_DETAIL A
           SET A.WHETHER_DEL=1
         WHERE A.INVENTORY_CODE=  PI_CODE;
      END IF;
    
    ELSE
      RAISE_APPLICATION_ERROR(-20002, '不可删除已提交的盘点单！');
    END IF;
  
  END P_DEL_CPINVENTORY;

 /*----------------------------------------------------------------
 查询成品供应商盘点单详情
 入参
 PI_CODE  盘点单号
 
 PI_TYPE  --SPU/SKU
 
 ------------------------------------------------------------------*/

  FUNCTION F_QUERY_CPINVENTORY_DETAIL(PI_CODE  IN VARCHAR2,
                                    --PI_MODE  IN VARCHAR2 DEFAULT CP,--CP/WL
                                    PI_TYPE  IN VARCHAR2 --SPU/SKU
                                   -- PI_SUPID IN VARCHAR2
                                    ) RETURN CLOB IS 
   v_s_sql CLOB;                                
   v_f_sql CLOB;    
   V_SQL   CLOB;                             
 BEGIN
   V_S_SQL :=q'[SELECT A.INVENTORY_CODE,--盘点单号
        (CASE A.STOCK_TYPE
         WHEN 1 THEN  '品牌仓'
         WHEN 2 THEN  '供应商仓'
         WHEN 3 THEN '品牌仓/供应商仓' END) STOCK_TYPE,--仓库类型
        NVL(C.USERNAME,C.NICK_NAME)  INVENTORY_CHECKER, --盘点人
        (CASE A.INVENTORY_TYPE  WHEN 1 THEN '仓库全盘' WHEN 2 THEN '部分盘点' END) INVENTORY_TYPE,--盘点单类型
        A.CREATE_TIME INVENTORY_CRETIME, --盘点创建时间
        A.END_TIME INVENTORY_ENDTIME, M.SUPPLIER_NAME MATERIAL_SUPP_NAME, ]'||CASE PI_TYPE WHEN 'SKU' THEN ' B.MATERIAL_SKU,' WHEN 'SPU' THEN 'B.MATERIAL_SPU, ' END ||
        q'[ M.MATERIAL_NAME, ]'||CASE PI_TYPE WHEN 'SKU' THEN 'M.MATERIAL_COLOR, ' WHEN 'SPU' THEN NULL END||
        q'[B.UNIT, B.OLD_TOTAL_STOCK TOTAL_STOCK, B.OLD_BRAND_STOCK BRAND_STOCK, B.OLD_SUPPLIER_STOCK SUPPLIER_STOCK, B.BRAND_PROFIT_LOSS,
        B.SUPPLIER_PROFIT_LOSS, M.SUPPLIER_MATERIAL_NAME ]' ||
        CASE PI_TYPE WHEN 'SKU' THEN ', M.SUPPLIER_COLOR, M.SUPPLIER_SHADES,  M.SUPPLIER_CODE MATER_SUPPLIER_CODE,
        (CASE  B.WHETHER_INNER_MATER WHEN 0 THEN ''否'' WHEN 1 THEN ''是'' END)  IS_INNER_MATERIAL ' WHEN 'SPU' THEN NULL END ;
        
  IF PI_TYPE = 'SKU' THEN        
   V_F_SQL:=q'[  
    FROM MRP.SUPPLIER_COLOR_INVENTORY A --色布
INNER JOIN MRP.SUPPLIER_COLOR_INVENTORY_DETAIL B ON A.INVENTORY_CODE=B.INVENTORY_CODE AND A.PRO_SUPPLIER_CODE=B.PRO_SUPPLIER_CODE
INNER JOIN SCMDATA.SYS_USER C   ON A.CREATE_ID = C.USER_ID
INNER JOIN (SELECT Z.MATERIAL_SKU,
       Z.MATERIAL_COLOR,
       Y.MATERIAL_NAME,
       X.SUPPLIER_MATERIAL_NAME,
       X.SUPPLIER_COLOR,
       y.material_classification,
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
    UNION ALL
    SELECT z.material_sku,
           Y.MATERIAL_COLOR,
       x.material_name,
       Z.SUPPLIER_MATERIAL_NAME,
       z.supplier_color,
       x.MATERIAL_CLASSIFICATION,
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
) M ON M.material_sku=B.MATERIAL_SKU 
WHERE A.INVENTORY_CODE=']'||PI_CODE||''''; 
  ELSIF PI_TYPE = 'SPU' THEN 
   V_F_SQL:=q'[FROM MRP.SUPPLIER_GREY_INVENTORY A
  INNER JOIN MRP.SUPPLIER_GREY_INVENTORY_DETAIL B ON A.INVENTORY_CODE=B.INVENTORY_CODE AND A.PRO_SUPPLIER_CODE=B.PRO_SUPPLIER_CODE  
  INNER JOIN SCMDATA.SYS_USER C   ON A.CREATE_ID = C.USER_ID
  INNER JOIN (SELECT W.SUPPLIER_NAME,
                    W.SUPPLIER_CODE, 
                    Z.MATERIAL_SPU, 
                    Z.UNIT,  
                    Z.MATERIAL_NAME, 
                    Z.MATERIAL_CLASSIFICATION, 
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
             UNION
             SELECT W.SUPPLIER_ABBREVIATION SUPPLIER_NAME,
                    X.SUPPLIER_CODE, 
                    Z.MATERIAL_SPU, 
                    Z.UNIT,  
                    Z.MATERIAL_NAME,
                    Z.MATERIAL_CLASSIFICATION, 
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
) M ON M.MATERIAL_SPU = B.MATERIAL_SPU
   WHERE A.INVENTORY_CODE=']'||PI_CODE||'''';   
  END IF;     
  V_SQL:=V_S_SQL||V_F_SQL;
  RETURN V_SQL;
  
 END F_QUERY_CPINVENTORY_DETAIL; 
 
 /*-----------------------------------------------------------------------
 查询成品供应商出入库明细
 入参  
 V_SUPINFOID  供应商档案id
 V_TYPE       SPU/SKU
 
 
 ------------------------------------------------------------------------*/
 
 FUNCTION F_QUERY_CPBOUNT(V_SUPINFOID IN VARCHAR2, --供应商档案id
                         V_TYPE      IN VARCHAR2  --SPU/SKU
                         ) RETURN CLOB IS 
V_S_SQL CLOB;
V_F_SQL CLOB;
V_SQL   CLOB;

BEGIN
  V_S_SQL:=q'[SELECT  CASE A.ASCRIPTION  WHEN  0 THEN '出库' WHEN 1 THEN '入库' END BOUND_ASCRIPTION,
        A.BOUND_TYPE, 
        A.BOUND_NUM, 
        M.SUPPLIER_NAME MATERIAL_SUPP_NAME,]'|| CASE V_TYPE WHEN 'SKU' THEN' A.MATERIAL_SKU, ' WHEN 'SPU'  THEN ' A.MATERIAL_SPU, 'END ||
         
        'M.MATERIAL_NAME,'||CASE V_TYPE WHEN 'SKU' THEN ' M.MATERIAL_COLOR, ' WHEN 'SPU' THEN NULL END||
        q'[A.UNIT, 
        ABS(A.NUM) BOUND_AMOUNT, 
        (CASE  A.STOCK_TYPE WHEN 1 THEN '品牌仓' WHEN 2 THEN '供应商仓' END) STOCK_TYPE, 
        NVL(U.USERNAME,U.NICK_NAME) CREATE_ID,
        A.CREATE_TIME BOUND_TIME, 
        M.SUPPLIER_MATERIAL_NAME,]'||CASE V_TYPE WHEN 'SKU' THEN ' M.SUPPLIER_COLOR, M.SUPPLIER_SHADES,' WHEN 'SPU'THEN NULL END||
        'A.MATER_SUPPLIER_CODE,
         A.RELATE_NUM_TYPE,
         A.RELATE_NUM,'|| CASE WHEN V_TYPE='SKU' THEN '
            ''"COL_1":''||A.MATERIAL_SKU||'',"COL_2":''||A.MATER_SUPPLIER_CODE||'',"COL_3":''||''SKU''||'',"COL_4":''||A.WHETHER_INNER_MATER  PIN_ID,'
           WHEN V_TYPE = 'SPU' THEN ' 
              ''"COL_1":''||A.MATERIAL_SPU||'',"COL_2":''||A.MATER_SUPPLIER_CODE||'',"COL_3":''||''SPU''||'',"COL_4":''||A.WHETHER_INNER_MATER PIN_ID,' END||
         CASE V_TYPE WHEN 'SKU' THEN 'A.RELATE_PURCHASE, A.RELATE_SKC  'WHEN 'SPU' THEN 'A.RELATE_PURCHASE_ORDER_NUM RELATE_PURCHASE, A.RELATE_SKC ' END ;
  
  IF V_TYPE ='SKU' THEN 
    V_F_SQL:=q'[FROM MRP.SUPPLIER_COLOR_IN_OUT_BOUND A
INNER JOIN (SELECT Z.MATERIAL_SKU,
       Z.MATERIAL_COLOR,
       Y.MATERIAL_NAME,
       X.SUPPLIER_MATERIAL_NAME,
       X.SUPPLIER_COLOR,
       y.material_classification,
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
   INNER JOIN MRP.MRP_TEMPORARY_SUPPLIER_ARCHIVES W ON W.SUPPLIER_CODE=X.SUPPLIER_CODE
    UNION ALL
    SELECT z.material_sku,
           Y.MATERIAL_COLOR,
       x.material_name,
       Z.SUPPLIER_MATERIAL_NAME,
       z.supplier_color,
       x.MATERIAL_CLASSIFICATION,
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
INNER JOIN mrp.mrp_determine_supplier_archives W  ON w.SUPPLIER_CODE=z.supplier_code) M ON M.material_sku=A.MATERIAL_SKU AND M.supplier_code = A.MATER_SUPPLIER_CODE
LEFT JOIN SCMDATA.SYS_USER U ON U.USER_ID = A.CREATE_ID 
WHERE A.WHETHER_DEL = 0 AND A.COMPANY_ID = 'b6cc680ad0f599cde0531164a8c0337f' AND A.PRO_SUPPLIER_CODE =']'||V_SUPINFOID||'''
ORDER BY A.CREATE_TIME DESC';
  ELSIF V_TYPE  ='SPU' THEN 
    V_F_SQL:=q'[FROM MRP.SUPPLIER_GREY_IN_OUT_BOUND A
INNER JOIN (SELECT W.SUPPLIER_NAME,
                    W.SUPPLIER_CODE, 
                    Z.MATERIAL_SPU, 
                    Z.UNIT,  
                    Z.MATERIAL_NAME, 
                    Z.MATERIAL_CLASSIFICATION, 
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
             UNION
             SELECT W.SUPPLIER_ABBREVIATION SUPPLIER_NAME,
                    X.SUPPLIER_CODE, 
                    Z.MATERIAL_SPU, 
                    Z.UNIT,  
                    Z.MATERIAL_NAME,
                    Z.MATERIAL_CLASSIFICATION, 
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
) M ON M.MATERIAL_SPU = A.MATERIAL_SPU AND M.SUPPLIER_CODE = A.MATER_SUPPLIER_CODE
LEFT JOIN SCMDATA.SYS_USER U ON U.USER_ID = A.CREATE_ID
WHERE A.WHETHER_DEL = 0 AND A.COMPANY_ID ='b6cc680ad0f599cde0531164a8c0337f' AND A.PRO_SUPPLIER_CODE=']'||V_SUPINFOID||'''
ORDER BY A.CREATE_TIME DESC ';
  END IF;       
 V_SQL :=V_S_SQL||V_F_SQL;
 RETURN V_SQL;
END F_QUERY_CPBOUNT;   
 
/*-----------------------------------------------------------
成品供应商提交sku盘点单按钮
入参 
PI_PDID    盘点单号
PI_PDUSER  操作人id

---------------------------------------------------------------*/

PROCEDURE P_SUBMIT_CPSKUPD(PI_PDID IN VARCHAR2,
                           PI_PDUSER IN VARCHAR2                          
                           ) IS 
  V_PDTYPE NUMBER;
  V_STOCKTYPE NUMBER; 
  V_NUM1   NUMBER;
  V_NUM2   NUMBER;
  V_NUM3   NUMBER; 
  V_PCRID  VARCHAR2(32);
  V_SCRID  VARCHAR2(32);                     
  V_ERR    VARCHAR2(4000):=NULL;                     
BEGIN
  --仓库类型
    --品牌盘点量为空
  SELECT COUNT(1) INTO V_NUM1
    FROM MRP.SUPPLIER_COLOR_INVENTORY_DETAIL Z
    WHERE Z.INVENTORY_CODE=PI_PDID
      AND Z.WHETHER_DEL=0
      AND Z.BRAND_INVENTORY IS  NULL;
   
   --供应商盘点量为空
     SELECT COUNT(1) INTO V_NUM2
       FROM  MRP.SUPPLIER_COLOR_INVENTORY_DETAIL Z
    WHERE Z.INVENTORY_CODE=PI_PDID
      AND Z.WHETHER_DEL=0
      AND Z.SUPPLIER_INVENTORY IS NULL;
    
   --盘点明细总数   
    SELECT COUNT(1) INTO V_NUM3
      FROM  MRP.SUPPLIER_COLOR_INVENTORY_DETAIL Z
     WHERE Z.INVENTORY_CODE=PI_PDID
       AND Z.WHETHER_DEL=0;
      
    --所有品牌盘点量无值,  所有供应商盘点量无值
      IF V_NUM1=V_NUM3 AND V_NUM2 = V_NUM3 THEN 
        V_STOCKTYPE:='';
        V_ERR:='盘点单无任何盘点数量';
      --所有品牌盘点量无值, 供应商盘点量有值
      ELSIF V_NUM1 = V_NUM3 AND (0 <= V_NUM2 AND V_NUM2< V_NUM3) THEN 
        V_STOCKTYPE :=2;
      
      --所有品牌盘点量有值, 供应商盘点量无值
      ELSIF (0 <= V_NUM1 AND V_NUM1 < V_NUM3) AND V_NUM2=V_NUM3 THEN 
        V_STOCKTYPE:=1;
      
      ELSE 
        V_STOCKTYPE:=3;
      END IF;
        
      IF V_ERR IS NOT NULL THEN 
        RAISE_APPLICATION_ERROR(-20002,V_ERR);
       
      ELSE 
  
  --盘点类型
  SELECT (CASE WHEN COUNT(1) = 0 THEN '1' ELSE '2' END) INTO V_PDTYPE
     FROM MRP.SUPPLIER_COLOR_INVENTORY_DETAIL A
     WHERE A.INVENTORY_CODE=PI_PDID
       AND (A.BRAND_INVENTORY IS NULL OR A.SUPPLIER_INVENTORY IS NULL);  

  --落 盘点单
   UPDATE MRP.SUPPLIER_COLOR_INVENTORY T
      SET T.INVENTORY_TYPE = V_PDTYPE,
          T.STOCK_TYPE     = V_STOCKTYPE,
          T.END_TIME       = SYSDATE
    WHERE T.INVENTORY_CODE = PI_PDID;
      
  DELETE FROM MRP.SUPPLIER_COLOR_INVENTORY_DETAIL A WHERE A.INVENTORY_CODE= PI_PDID AND A.BRAND_INVENTORY IS NULL AND A.SUPPLIER_INVENTORY IS NULL;
      
    FOR X IN (SELECT * FROM MRP.SUPPLIER_COLOR_INVENTORY_DETAIL A WHERE A.WHETHER_DEL=0 AND A.INVENTORY_CODE= PI_PDID)LOOP
          
    --落出入库
     --品牌仓
    IF X.BRAND_PROFIT_LOSS <0 THEN 
      --【品牌盈亏量】<0时，生成【出入库类型】= 【盘亏出库】，【仓库类型】= 【品牌仓】的出入库单，【数量】=【品牌盈亏量】
      --出库单号
      V_PCRID :=MRP.PKG_PLAT_COMM.F_GET_DOCUNO(PI_TABLE_NAME  => 'MRP.SUPPLIER_COLOR_IN_OUT_BOUND',
                                              PI_COLUMN_NAME => 'BOUND_NUM',
                                              PI_PRE         => 'CKCK'||TO_CHAR(SYSDATE,'YYYYDDMM'),
                                              PI_SERAIL_NUM  =>5 );
      INSERT INTO MRP.SUPPLIER_COLOR_IN_OUT_BOUND
        (BOUND_NUM, ASCRIPTION, BOUND_TYPE, PRO_SUPPLIER_CODE, MATER_SUPPLIER_CODE, MATERIAL_SKU, WHETHER_INNER_MATER, UNIT, 
        NUM, STOCK_TYPE, RELATE_NUM, RELATE_NUM_TYPE,COMPANY_ID, CREATE_ID, CREATE_TIME, WHETHER_DEL)
      VALUES
        (V_PCRID, 0, 2, X.PRO_SUPPLIER_CODE, X.MATER_SUPPLIER_CODE,X.MATERIAL_SKU,X.WHETHER_INNER_MATER, X.UNIT, 
        ABS(X.BRAND_PROFIT_LOSS),1, X.INVENTORY_CODE, 2, 'b6cc680ad0f599cde0531164a8c0337f',PI_PDUSER, SYSDATE, 0);
        
      --落库存明细  
    UPDATE MRP.SUPPLIER_COLOR_CLOTH_STOCK Y 
      SET  Y.UPDATE_TIME=SYSDATE,
           Y.UPDATE_ID=PI_PDUSER,
           Y.BRAND_STOCK=NVL(Y.BRAND_STOCK,0)+NVL(X.BRAND_PROFIT_LOSS,0)
     WHERE Y.PRO_SUPPLIER_CODE=X.PRO_SUPPLIER_CODE 
       AND Y.MATER_SUPPLIER_CODE=X.MATER_SUPPLIER_CODE
       AND Y.MATERIAL_SKU=X.MATERIAL_SKU
       AND Y.UNIT = X.UNIT;
    ELSIF X.BRAND_PROFIT_LOSS >0 THEN 
      -- 当【品牌盈亏量】>0时，生成【出入库类型】= 【盘盈入库】，【仓库类型】= 【品牌仓】的出入库单，【数量】=【品牌盈亏量】 
      --入库单号
      V_PCRID :=MRP.PKG_PLAT_COMM.F_GET_DOCUNO(PI_TABLE_NAME  => 'MRP.SUPPLIER_COLOR_IN_OUT_BOUND',
                                              PI_COLUMN_NAME => 'BOUND_NUM',
                                              PI_PRE         => 'CKRK'||TO_CHAR(SYSDATE,'YYYYDDMM'),
                                              PI_SERAIL_NUM  =>5 );
      INSERT INTO MRP.SUPPLIER_COLOR_IN_OUT_BOUND
        (BOUND_NUM, ASCRIPTION, BOUND_TYPE, PRO_SUPPLIER_CODE, MATER_SUPPLIER_CODE, MATERIAL_SKU, WHETHER_INNER_MATER, UNIT, 
        NUM, STOCK_TYPE, RELATE_NUM, RELATE_NUM_TYPE,COMPANY_ID,  CREATE_ID, CREATE_TIME, WHETHER_DEL)
      VALUES
        (V_PCRID, 1, 13, X.PRO_SUPPLIER_CODE, X.MATER_SUPPLIER_CODE, X.MATERIAL_SKU, X.WHETHER_INNER_MATER, X.UNIT, 
        ABS(X.BRAND_PROFIT_LOSS), 1, X.INVENTORY_CODE, 2,'b6cc680ad0f599cde0531164a8c0337f', PI_PDUSER, SYSDATE, 0);
      
      --落库存明细                                     
       UPDATE MRP.SUPPLIER_COLOR_CLOTH_STOCK Y 
      SET  Y.UPDATE_TIME=SYSDATE,
           Y.UPDATE_ID=PI_PDUSER,
           Y.BRAND_STOCK=NVL(Y.BRAND_STOCK,0)+NVL(X.BRAND_PROFIT_LOSS,0)
     WHERE Y.PRO_SUPPLIER_CODE=X.PRO_SUPPLIER_CODE 
       AND Y.MATER_SUPPLIER_CODE=X.MATER_SUPPLIER_CODE
       AND Y.MATERIAL_SKU=X.MATERIAL_SKU
       AND Y.UNIT = X.UNIT;                                       
    END IF;
     --供应商仓
     IF X.SUPPLIER_PROFIT_LOSS <0 THEN 
       --当【供应商盈亏量】<0时，生成【出入库类型】= 【盘亏出库】，【仓库类型】= 【供应商仓】的出入库单 ，【数量】=【供应商盈亏量】
       V_SCRID :=MRP.PKG_PLAT_COMM.F_GET_DOCUNO(PI_TABLE_NAME  => 'MRP.SUPPLIER_COLOR_IN_OUT_BOUND',
                                              PI_COLUMN_NAME => 'BOUND_NUM',
                                              PI_PRE         => 'CKCK'||TO_CHAR(SYSDATE,'YYYYDDMM'),
                                              PI_SERAIL_NUM  =>5 );
       
       INSERT INTO MRP.SUPPLIER_COLOR_IN_OUT_BOUND
        (BOUND_NUM, ASCRIPTION, BOUND_TYPE, PRO_SUPPLIER_CODE, MATER_SUPPLIER_CODE, MATERIAL_SKU, WHETHER_INNER_MATER, UNIT, 
        NUM, STOCK_TYPE, RELATE_NUM, RELATE_NUM_TYPE,COMPANY_ID, CREATE_ID, CREATE_TIME, WHETHER_DEL)
      VALUES                                       
        (V_SCRID,0,2,X.PRO_SUPPLIER_CODE,X.MATER_SUPPLIER_CODE,X.MATERIAL_SKU,X.WHETHER_INNER_MATER,X.UNIT,
        ABS(X.SUPPLIER_PROFIT_LOSS),2,X.INVENTORY_CODE,2,'b6cc680ad0f599cde0531164a8c0337f', PI_PDUSER, SYSDATE, 0); 
     --落库存明细                                         
     UPDATE MRP.SUPPLIER_COLOR_CLOTH_STOCK Y 
      SET  Y.UPDATE_TIME=SYSDATE,
           Y.UPDATE_ID=PI_PDUSER,
           Y.SUPPLIER_STOCK = NVL(Y.SUPPLIER_STOCK,0)+NVL(X.SUPPLIER_PROFIT_LOSS,0)
     WHERE Y.PRO_SUPPLIER_CODE=X.PRO_SUPPLIER_CODE 
       AND Y.MATER_SUPPLIER_CODE=X.MATER_SUPPLIER_CODE
       AND Y.MATERIAL_SKU=X.MATERIAL_SKU
       AND Y.UNIT = X.UNIT; 
     
     
     ELSIF X.SUPPLIER_PROFIT_LOSS >0 THEN 
       --当【供应商盈亏量】>0时，生成【出入库类型】= 【盘盈入库】，【仓库类型】= 【供应商仓】的出入库单  ，【数量】=【供应商盈亏量】
       V_SCRID :=MRP.PKG_PLAT_COMM.F_GET_DOCUNO(PI_TABLE_NAME  => 'MRP.SUPPLIER_COLOR_IN_OUT_BOUND',
                                              PI_COLUMN_NAME => 'BOUND_NUM',
                                              PI_PRE         => 'CKRK'||TO_CHAR(SYSDATE,'YYYYDDMM'),
                                              PI_SERAIL_NUM  =>5 );
     
     INSERT INTO MRP.SUPPLIER_COLOR_IN_OUT_BOUND
        (BOUND_NUM, ASCRIPTION, BOUND_TYPE, PRO_SUPPLIER_CODE, MATER_SUPPLIER_CODE, MATERIAL_SKU, WHETHER_INNER_MATER, UNIT, 
        NUM, STOCK_TYPE, RELATE_NUM, RELATE_NUM_TYPE,COMPANY_ID, CREATE_ID, CREATE_TIME, WHETHER_DEL)
      VALUES
      (V_SCRID,1,13,X.PRO_SUPPLIER_CODE,X.MATER_SUPPLIER_CODE,X.MATERIAL_SKU,X.WHETHER_INNER_MATER,X.UNIT,
      ABS(X.SUPPLIER_PROFIT_LOSS),2,X.INVENTORY_CODE,2,'b6cc680ad0f599cde0531164a8c0337f', PI_PDUSER, SYSDATE, 0); 
     
     --落库存明细 
      UPDATE MRP.SUPPLIER_COLOR_CLOTH_STOCK Y 
      SET  Y.UPDATE_TIME=SYSDATE,
           Y.UPDATE_ID=PI_PDUSER,
           Y.SUPPLIER_STOCK =NVL(Y.SUPPLIER_STOCK,0)+NVL(X.SUPPLIER_PROFIT_LOSS,0)
     WHERE Y.PRO_SUPPLIER_CODE=X.PRO_SUPPLIER_CODE 
       AND Y.MATER_SUPPLIER_CODE=X.MATER_SUPPLIER_CODE
       AND Y.MATERIAL_SKU=X.MATERIAL_SKU
       AND Y.UNIT = X.UNIT; 
     
     END IF;
       UPDATE MRP.SUPPLIER_COLOR_CLOTH_STOCK Y
          SET Y.TOTAL_STOCK = NVL(Y.BRAND_STOCK,0)+NVL(Y.SUPPLIER_STOCK,0)
        WHERE Y.PRO_SUPPLIER_CODE=X.PRO_SUPPLIER_CODE 
          AND Y.MATER_SUPPLIER_CODE=X.MATER_SUPPLIER_CODE
          AND Y.MATERIAL_SKU=X.MATERIAL_SKU
          AND Y.UNIT = X.UNIT;
       
  END LOOP;  
    
  END IF;  



END;

/*-----------------------------------------------------------
成品供应商提交spu盘点单按钮
入参 
PI_PDID    盘点单号
PI_PDUSER  操作人id

---------------------------------------------------------------*/

PROCEDURE P_SUBMIT_CPSPUPD(PI_PDID IN VARCHAR2,
                           PI_PDUSER IN VARCHAR2                          
                           ) IS 
  V_PDTYPE NUMBER;
  V_STOCKTYPE NUMBER; 
  V_NUM1   NUMBER;
  V_NUM2   NUMBER;
  V_NUM3   NUMBER; 
  V_PCRID  VARCHAR2(32);
  V_SCRID  VARCHAR2(32);                     
  V_ERR    VARCHAR2(4000):=NULL;                         
BEGIN
  --仓库类型
    --品牌盘点量为空
  SELECT COUNT(1) INTO V_NUM1
    FROM MRP.SUPPLIER_GREY_INVENTORY_DETAIL Z
    WHERE Z.INVENTORY_CODE=PI_PDID
      AND Z.WHETHER_DEL=0
      AND Z.BRAND_INVENTORY IS  NULL;
   
   --供应商盘点量为空
     SELECT COUNT(1) INTO V_NUM2
       FROM  MRP.SUPPLIER_GREY_INVENTORY_DETAIL Z
    WHERE Z.INVENTORY_CODE=PI_PDID
      AND Z.WHETHER_DEL=0
      AND Z.SUPPLIER_INVENTORY IS NULL;
    
   --盘点明细总数   
    SELECT COUNT(1) INTO V_NUM3
      FROM  MRP.SUPPLIER_GREY_INVENTORY_DETAIL Z
     WHERE Z.INVENTORY_CODE=PI_PDID
       AND Z.WHETHER_DEL=0;
      
    --所有品牌盘点量无值,  所有供应商盘点量无值
      IF V_NUM1=V_NUM3 AND V_NUM2 = V_NUM3 THEN 
        V_STOCKTYPE:='';
         V_ERR:='盘点单无任何盘点数量';
      --所有品牌盘点量无值, 供应商盘点量有值
      ELSIF V_NUM1 = V_NUM3 AND (0 <= V_NUM2 AND V_NUM2< V_NUM3) THEN 
        V_STOCKTYPE :=2;
      
      --所有品牌盘点量有值, 供应商盘点量无值
      ELSIF (0 <= V_NUM1 AND V_NUM1 < V_NUM3) AND V_NUM2=V_NUM3 THEN 
        V_STOCKTYPE:=1;
      
      ELSE 
        V_STOCKTYPE:=3;
      END IF;
        
     IF V_ERR IS NOT NULL THEN 
        RAISE_APPLICATION_ERROR(-20002,V_ERR); 
       
      ELSE 
  
  --盘点类型
  SELECT (CASE WHEN COUNT(1) = 0 THEN '1' ELSE '2' END) INTO V_PDTYPE
     FROM MRP.SUPPLIER_GREY_INVENTORY_DETAIL A
     WHERE A.INVENTORY_CODE=PI_PDID
       AND (A.BRAND_INVENTORY IS NULL OR A.SUPPLIER_INVENTORY IS NULL);  

  --落 盘点单
   UPDATE MRP.SUPPLIER_GREY_INVENTORY T
      SET T.INVENTORY_TYPE = V_PDTYPE,
          T.STOCK_TYPE     = V_STOCKTYPE,
          T.END_TIME       = SYSDATE
    WHERE T.INVENTORY_CODE = PI_PDID;
      
  DELETE FROM MRP.SUPPLIER_GREY_INVENTORY_DETAIL A WHERE A.INVENTORY_CODE = PI_PDID AND A.BRAND_INVENTORY IS NULL AND A.SUPPLIER_INVENTORY IS NULL;
      
    FOR X IN (SELECT * FROM MRP.SUPPLIER_GREY_INVENTORY_DETAIL A WHERE A.WHETHER_DEL=0 AND A.INVENTORY_CODE= PI_PDID)LOOP
          
    --落出入库
     --品牌仓
    IF X.BRAND_PROFIT_LOSS <0 THEN 
      --【品牌盈亏量】<0时，生成【出入库类型】= 【盘亏出库】，【仓库类型】= 【品牌仓】的出入库单，【数量】=【品牌盈亏量】
      --出库单号
      V_PCRID :=MRP.PKG_PLAT_COMM.F_GET_DOCUNO(PI_TABLE_NAME  => 'MRP.SUPPLIER_GREY_IN_OUT_BOUND',
                                              PI_COLUMN_NAME => 'BOUND_NUM',
                                              PI_PRE         => 'CPCK'||TO_CHAR(SYSDATE,'YYYYDDMM'),
                                              PI_SERAIL_NUM  =>5 );
      INSERT INTO MRP.SUPPLIER_GREY_IN_OUT_BOUND
        (BOUND_NUM, ASCRIPTION, BOUND_TYPE, PRO_SUPPLIER_CODE, MATER_SUPPLIER_CODE, MATERIAL_SPU, WHETHER_INNER_MATER, UNIT, 
        NUM, STOCK_TYPE, RELATE_NUM, RELATE_NUM_TYPE,COMPANY_ID, CREATE_ID, CREATE_TIME, WHETHER_DEL)
      VALUES
        (V_PCRID, 0, 2, X.PRO_SUPPLIER_CODE, X.MATER_SUPPLIER_CODE,X.MATERIAL_SPU,X.WHETHER_INNER_MATER, X.UNIT, 
        ABS(X.BRAND_PROFIT_LOSS),1, X.INVENTORY_CODE, 2, 'b6cc680ad0f599cde0531164a8c0337f',PI_PDUSER, SYSDATE, 0);
        
      --落库存明细  
    UPDATE MRP.SUPPLIER_GREY_STOCK Y 
      SET  Y.UPDATE_TIME=SYSDATE,
           Y.UPDATE_ID=PI_PDUSER,
           Y.BRAND_STOCK=NVL(Y.BRAND_STOCK,0)+NVL(X.BRAND_PROFIT_LOSS,0)
     WHERE Y.PRO_SUPPLIER_CODE=X.PRO_SUPPLIER_CODE 
       AND Y.MATER_SUPPLIER_CODE=X.MATER_SUPPLIER_CODE
       AND Y.MATERIAL_SPU=X.MATERIAL_SPU
       AND Y.UNIT = X.UNIT;
    ELSIF X.BRAND_PROFIT_LOSS >0 THEN 
      -- 当【品牌盈亏量】>0时，生成【出入库类型】= 【盘盈入库】，【仓库类型】= 【品牌仓】的出入库单，【数量】=【品牌盈亏量】 
      --入库单号
      V_PCRID :=MRP.PKG_PLAT_COMM.F_GET_DOCUNO(PI_TABLE_NAME  => 'MRP.SUPPLIER_GREY_IN_OUT_BOUND',
                                              PI_COLUMN_NAME => 'BOUND_NUM',
                                              PI_PRE         => 'CPRK'||TO_CHAR(SYSDATE,'YYYYDDMM'),
                                              PI_SERAIL_NUM  =>5 );
      INSERT INTO MRP.SUPPLIER_GREY_IN_OUT_BOUND
        (BOUND_NUM, ASCRIPTION, BOUND_TYPE, PRO_SUPPLIER_CODE, MATER_SUPPLIER_CODE, MATERIAL_SPU, WHETHER_INNER_MATER, UNIT, 
        NUM, STOCK_TYPE, RELATE_NUM, RELATE_NUM_TYPE,COMPANY_ID,  CREATE_ID, CREATE_TIME, WHETHER_DEL)
      VALUES
        (V_PCRID, 1, 13, X.PRO_SUPPLIER_CODE, X.MATER_SUPPLIER_CODE, X.MATERIAL_SPU, X.WHETHER_INNER_MATER, X.UNIT, 
        ABS(X.BRAND_PROFIT_LOSS), 1, X.INVENTORY_CODE, 2,'b6cc680ad0f599cde0531164a8c0337f', PI_PDUSER, SYSDATE, 0);
      
      --落库存明细                                     
       UPDATE MRP.SUPPLIER_GREY_STOCK Y 
      SET  Y.UPDATE_TIME=SYSDATE,
           Y.UPDATE_ID=PI_PDUSER,
           Y.BRAND_STOCK=NVL(Y.BRAND_STOCK,0)+NVL(X.BRAND_PROFIT_LOSS,0)
     WHERE Y.PRO_SUPPLIER_CODE=X.PRO_SUPPLIER_CODE 
       AND Y.MATER_SUPPLIER_CODE=X.MATER_SUPPLIER_CODE
       AND Y.MATERIAL_SPU=X.MATERIAL_SPU
       AND Y.UNIT = X.UNIT;                                       
    END IF;
     --供应商仓
     IF X.SUPPLIER_PROFIT_LOSS <0 THEN 
       --当【供应商盈亏量】<0时，生成【出入库类型】= 【盘亏出库】，【仓库类型】= 【供应商仓】的出入库单 ，【数量】=【供应商盈亏量】
       V_SCRID :=MRP.PKG_PLAT_COMM.F_GET_DOCUNO(PI_TABLE_NAME  => 'MRP.SUPPLIER_GREY_IN_OUT_BOUND',
                                              PI_COLUMN_NAME => 'BOUND_NUM',
                                              PI_PRE         => 'CPCK'||TO_CHAR(SYSDATE,'YYYYDDMM'),
                                              PI_SERAIL_NUM  =>5 );
       
       INSERT INTO MRP.SUPPLIER_GREY_IN_OUT_BOUND
        (BOUND_NUM, ASCRIPTION, BOUND_TYPE, PRO_SUPPLIER_CODE, MATER_SUPPLIER_CODE, MATERIAL_SPU, WHETHER_INNER_MATER, UNIT, 
        NUM, STOCK_TYPE, RELATE_NUM, RELATE_NUM_TYPE,COMPANY_ID, CREATE_ID, CREATE_TIME, WHETHER_DEL)
      VALUES                                       
        (V_SCRID,0,2,X.PRO_SUPPLIER_CODE,X.MATER_SUPPLIER_CODE,X.MATERIAL_SPU,X.WHETHER_INNER_MATER,X.UNIT,
        ABS(X.SUPPLIER_PROFIT_LOSS),2,X.INVENTORY_CODE,2,'b6cc680ad0f599cde0531164a8c0337f', PI_PDUSER, SYSDATE, 0); 
     --落库存明细                                         
     UPDATE MRP.SUPPLIER_GREY_STOCK Y 
      SET  Y.UPDATE_TIME=SYSDATE,
           Y.UPDATE_ID=PI_PDUSER,
           Y.SUPPLIER_STOCK = NVL(Y.SUPPLIER_STOCK,0)+NVL(X.SUPPLIER_PROFIT_LOSS,0)
     WHERE Y.PRO_SUPPLIER_CODE=X.PRO_SUPPLIER_CODE 
       AND Y.MATER_SUPPLIER_CODE=X.MATER_SUPPLIER_CODE
       AND Y.MATERIAL_SPU=X.MATERIAL_SPU
       AND Y.UNIT = X.UNIT; 
     
     
     ELSIF X.SUPPLIER_PROFIT_LOSS >0 THEN 
       --当【供应商盈亏量】>0时，生成【出入库类型】= 【盘盈入库】，【仓库类型】= 【供应商仓】的出入库单  ，【数量】=【供应商盈亏量】
       V_SCRID :=MRP.PKG_PLAT_COMM.F_GET_DOCUNO(PI_TABLE_NAME  => 'MRP.SUPPLIER_GREY_IN_OUT_BOUND',
                                              PI_COLUMN_NAME => 'BOUND_NUM',
                                              PI_PRE         => 'CPRK'||TO_CHAR(SYSDATE,'YYYYDDMM'),
                                              PI_SERAIL_NUM  =>5 );
     
     INSERT INTO MRP.SUPPLIER_GREY_IN_OUT_BOUND
        (BOUND_NUM, ASCRIPTION, BOUND_TYPE, PRO_SUPPLIER_CODE, MATER_SUPPLIER_CODE, MATERIAL_SPU, WHETHER_INNER_MATER, UNIT, 
        NUM, STOCK_TYPE, RELATE_NUM, RELATE_NUM_TYPE,COMPANY_ID, CREATE_ID, CREATE_TIME, WHETHER_DEL)
      VALUES
      (V_SCRID,1,13,X.PRO_SUPPLIER_CODE,X.MATER_SUPPLIER_CODE,X.MATERIAL_SPU,X.WHETHER_INNER_MATER,X.UNIT,
      ABS(X.SUPPLIER_PROFIT_LOSS),2,X.INVENTORY_CODE,2,'b6cc680ad0f599cde0531164a8c0337f', PI_PDUSER, SYSDATE, 0); 
     
     --落库存明细 
      UPDATE MRP.SUPPLIER_GREY_STOCK Y 
      SET  Y.UPDATE_TIME=SYSDATE,
           Y.UPDATE_ID=PI_PDUSER,
           Y.SUPPLIER_STOCK = NVL(Y.SUPPLIER_STOCK,0)+NVL(X.SUPPLIER_PROFIT_LOSS,0)
     WHERE Y.PRO_SUPPLIER_CODE=X.PRO_SUPPLIER_CODE 
       AND Y.MATER_SUPPLIER_CODE=X.MATER_SUPPLIER_CODE
       AND Y.MATERIAL_SPU=X.MATERIAL_SPU
       AND Y.UNIT = X.UNIT; 
     
     END IF;
       UPDATE MRP.SUPPLIER_GREY_STOCK Y
          SET Y.TOTAL_STOCK = NVL(Y.BRAND_STOCK,0)+NVL(Y.SUPPLIER_STOCK,0)
        WHERE Y.PRO_SUPPLIER_CODE=X.PRO_SUPPLIER_CODE 
          AND Y.MATER_SUPPLIER_CODE=X.MATER_SUPPLIER_CODE
          AND Y.MATERIAL_SPU=X.MATERIAL_SPU
          AND Y.UNIT = X.UNIT;
       
  END LOOP;  
   END IF; 

END P_SUBMIT_CPSPUPD;
             
 /*---------------------------------------------------------
  库存入库生成物料供应商出入库单
  入参
  PI_ID   库存明细主键
  PI_NUM  入库数量
  PI_TYPE --SKU/SPU
  PI_USERID 操作人id
  
  出参
  PO_BOUNDID  出入库单号
  
  ------------------------------------------------------------*/
                         
 PROCEDURE P_INS_WLINBOUND(PI_ID     IN VARCHAR2,
                          PI_NUM    IN VARCHAR2,
                          PI_TYPE   IN VARCHAR2,  --SKU/SPU
                          PI_USERID IN VARCHAR2, 
                          PO_BOUNDID OUT VARCHAR2)

 IS
  V_NUMID    VARCHAR2(32);
  V_WSKU_REC MRP.MATERIAL_COLOR_CLOTH_STOCK%ROWTYPE;
  V_WSPU_REC MRP.MATERIAL_GREY_STOCK%ROWTYPE;
BEGIN
  IF PI_TYPE ='SKU' THEN 
  SELECT *
    INTO V_WSKU_REC
    FROM MRP.MATERIAL_COLOR_CLOTH_STOCK T
   WHERE T.COLOR_CLOTH_STOCK_ID = PI_ID;

  V_NUMID := MRP.PKG_PLAT_COMM.F_GET_DOCUNO(PI_TABLE_NAME  => 'MRP.MATERIAL_COLOR_IN_OUT_BOUND',
                                                   PI_COLUMN_NAME => 'BOUND_NUM',
                                                   PI_PRE         => 'WKRK' ||
                                                                     TO_CHAR(SYSDATE,
                                                                             'YYYYMMDD'),
                                                   PI_SERAIL_NUM  => 5);
  INSERT INTO MRP.MATERIAL_COLOR_IN_OUT_BOUND
    (BOUND_NUM,ASCRIPTION,BOUND_TYPE,MATER_SUPPLIER_CODE,MATERIAL_SKU,
     UNIT,NUM,STOCK_TYPE,COMPANY_ID,CREATE_ID,CREATE_TIME,UPDATE_ID,UPDATE_TIME,WHETHER_DEL)
  VALUES
    (V_NUMID,1, 11, V_WSKU_REC.MATER_SUPPLIER_CODE,V_WSKU_REC.MATERIAL_SKU,
     V_WSKU_REC.UNIT,ABS(TO_NUMBER(PI_NUM)),2,'b6cc680ad0f599cde0531164a8c0337f',PI_USERID,SYSDATE,PI_USERID, SYSDATE,0);
   ELSIF PI_TYPE = 'SPU' THEN 
     SELECT *
    INTO V_WSPU_REC
    FROM MRP.MATERIAL_GREY_STOCK T
   WHERE T.COLOR_CLOTH_STOCK_ID = PI_ID;
   
   V_NUMID := MRP.PKG_PLAT_COMM.F_GET_DOCUNO(PI_TABLE_NAME  => 'MRP.MATERIAL_GREY_IN_OUT_BOUND',
                                                   PI_COLUMN_NAME => 'BOUND_NUM',
                                                   PI_PRE         => 'WPRK' ||
                                                                     TO_CHAR(SYSDATE,
                                                                             'YYYYMMDD'),
                                                   PI_SERAIL_NUM  => 5);
   INSERT INTO MRP.MATERIAL_GREY_IN_OUT_BOUND(BOUND_NUM,ASCRIPTION,BOUND_TYPE,MATER_SUPPLIER_CODE,MATERIAL_SPU,UNIT,
   NUM,STOCK_TYPE,COMPANY_ID,CREATE_ID,CREATE_TIME,UPDATE_ID,UPDATE_TIME,WHETHER_DEL)
   VALUES
   (V_NUMID,1,12, V_WSPU_REC.MATER_SUPPLIER_CODE,V_WSPU_REC.MATERIAL_SPU,V_WSPU_REC.UNIT,
    ABS(TO_NUMBER(PI_NUM)),2,'b6cc680ad0f599cde0531164a8c0337f',PI_USERID,SYSDATE,PI_USERID, SYSDATE,0);
   END IF;  
 PO_BOUNDID:=V_NUMID;
END P_INS_WLINBOUND;   
 
 /*-----------------------------------------------------------------------
 查询物料供应商出入库明细
 入参  
 V_SUPINFOID  物料供应商编号
 V_TYPE       SPU/SKU
 
 ------------------------------------------------------------------------*/
 
   
 FUNCTION F_QUERY_WLBOUNT(V_WLSUPID IN VARCHAR2, --物料供应商编号
                         V_TYPE      IN VARCHAR2  --SPU/SKU
                         ) RETURN CLOB IS 
V_S_SQL CLOB;
V_F_SQL CLOB;
V_SQL   CLOB;

BEGIN
  V_S_SQL:=q'[SELECT  CASE A.ASCRIPTION  WHEN  0 THEN '出库' WHEN 1 THEN '入库' END BOUND_ASCRIPTION,
        A.BOUND_TYPE, 
        A.BOUND_NUM, 
        ]'|| CASE V_TYPE WHEN 'SKU' THEN' A.MATERIAL_SKU, ' WHEN 'SPU'  THEN ' A.MATERIAL_SPU, 'END ||
         
        'M.MATERIAL_NAME,'||CASE V_TYPE WHEN 'SKU' THEN ' M.MATERIAL_COLOR, ' WHEN 'SPU' THEN NULL END||
        q'[A.UNIT, 
        ABS(A.NUM) BOUND_AMOUNT, 
        (CASE  A.STOCK_TYPE WHEN 1 THEN '品牌仓' WHEN 2 THEN '供应商仓' END) STOCK_TYPE, 
        NVL(U.USERNAME,U.NICK_NAME) CREATE_ID,
        A.CREATE_TIME BOUND_TIME, 
        M.SUPPLIER_MATERIAL_NAME,]'||CASE V_TYPE WHEN 'SKU' THEN ' M.SUPPLIER_COLOR, M.SUPPLIER_SHADES,' WHEN 'SPU'THEN NULL END||
        'A.MATER_SUPPLIER_CODE,
         A.RELATE_NUM_TYPE,
         A.RELATE_NUM,'|| CASE WHEN V_TYPE='SKU' THEN '
            ''"COL_1":''||A.MATERIAL_SKU||'',"COL_2":''||A.MATER_SUPPLIER_CODE||'',"COL_3":''||''SKU''||'',"COL_4":''||''1''  PIN_ID,'
           WHEN V_TYPE = 'SPU' THEN ' 
              ''"COL_1":''||A.MATERIAL_SPU||'',"COL_2":''||A.MATER_SUPPLIER_CODE||'',"COL_3":''||''SPU''||'',"COL_4":''||''1'' PIN_ID,' END||
         CASE V_TYPE WHEN 'SKU' THEN 'A.RELATE_PURCHASE, A.RELATE_SKC  'WHEN 'SPU' THEN 'A.RELATE_PURCHASE_ORDER_NUM RELATE_PURCHASE, A.RELATE_SKC ' END ;
  
  IF V_TYPE ='SKU' THEN 
    V_F_SQL:=q'[FROM MRP.MATERIAL_COLOR_IN_OUT_BOUND A
INNER JOIN (
    SELECT z.material_sku,
           Y.MATERIAL_COLOR,
       x.material_name,
       Z.SUPPLIER_MATERIAL_NAME,
       z.supplier_color,
       x.MATERIAL_CLASSIFICATION,
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
      Z.supplier_code
FROM mrp.MRP_INTERNAL_SUPPLIER_MATERIAL z
INNER JOIN mrp.mrp_internal_material_sku y ON z.material_sku=y.material_sku
INNER JOIN mrp.mrp_internal_material_spu x ON y.material_spu=x.material_spu
INNER JOIN mrp.mrp_determine_supplier_archives W  ON w.SUPPLIER_CODE=z.supplier_code) M ON M.material_sku=A.MATERIAL_SKU  AND M.supplier_code = A.MATER_SUPPLIER_CODE
LEFT JOIN SCMDATA.SYS_USER U ON U.USER_ID = A.CREATE_ID 
WHERE A.WHETHER_DEL = 0 AND A.COMPANY_ID = 'b6cc680ad0f599cde0531164a8c0337f' 
 AND A.MATER_SUPPLIER_CODE =']'||V_WLSUPID||'''
ORDER BY A.CREATE_TIME DESC';
  ELSIF V_TYPE  ='SPU' THEN 
    V_F_SQL:=q'[FROM MRP.MATERIAL_GREY_IN_OUT_BOUND A
INNER JOIN (
             SELECT W.SUPPLIER_ABBREVIATION SUPPLIER_NAME,
                    X.SUPPLIER_CODE, 
                    Z.MATERIAL_SPU, 
                    Z.UNIT,  
                    Z.MATERIAL_NAME,
                    Z.MATERIAL_CLASSIFICATION, 
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
) M ON M.MATERIAL_SPU = A.MATERIAL_SPU  AND M.SUPPLIER_CODE=A.MATER_SUPPLIER_CODE
LEFT JOIN SCMDATA.SYS_USER U ON U.USER_ID = A.CREATE_ID 
WHERE A.WHETHER_DEL = 0 AND A.COMPANY_ID ='b6cc680ad0f599cde0531164a8c0337f' AND A.MATER_SUPPLIER_CODE=']'||V_WLSUPID||'''
ORDER BY A.CREATE_TIME DESC ';
  END IF;       
 V_SQL :=V_S_SQL||V_F_SQL;
 RETURN V_SQL;
END F_QUERY_WLBOUNT;   

/*==========================================================
查询成品供应商盘点单 
 入参
 PI_TYPE :0 色布 1 坯布
        
 


=============================================================*/

   FUNCTION F_GET_WLSELECT_INVENTORY(PI_TYPE IN VARCHAR2) RETURN CLOB
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
         WHERE Z.USER_ID = :USER_ID
           AND Y.PAUSE = 0
           AND Y.COMPANY_ID =%DEFAULT_COMPANY_ID%
           /*AND (Y.COMPANY_ID = C.SUPPLIER_COMPANY_ID OR Y.COMPANY_ID=A.COMPANY_ID)*/) INVENTORY_PARTY, ]' || CASE WHEN pi_type=0 THEN '
            ''"COL_1":''||A.INVENTORY_CODE||'',"COL_2":''||''SKU''||'',"COL_3":''||''WL'' PIN_ID
            FROM MRP.MATERIAL_COLOR_INVENTORY A '
           WHEN pi_type = 1 THEN ' 
              ''"COL_1":''||A.INVENTORY_CODE||'',"COL_2":''||''SPU''||'',"COL_3":''||''WL'' PIN_ID
             FROM MRP.MATERIAL_GREY_INVENTORY A ' END ||q'[ LEFT JOIN SCMDATA.SYS_USER B
    ON A.CREATE_ID = B.USER_ID
  INNER JOIN MRP.MRP_DETERMINE_SUPPLIER_ARCHIVES C ON C.SUPPLIER_CODE = A.MATER_SUPPLIER_CODE
    
 WHERE A.WHETHER_DEL=0 
   AND C.SUPPLIER_COMPANY_ID =%DEFAULT_COMPANY_ID%
   AND A.COMPANY_ID='b6cc680ad0f599cde0531164a8c0337f' 
   ORDER BY A.END_TIME DESC  ]' ;       
  --DBMS_OUTPUT.put_line(V_S_SQL);
  RETURN V_S_SQL;
  END F_GET_WLSELECT_INVENTORY; 
  
  
    /*==========================================================
 删除成品供应商盘点单 
 入参
 PI_CODE   :     单据号
 PI_TYPE   :     0 色布 1 坯布
        
 
=============================================================*/

  PROCEDURE P_DEL_WLINVENTORY(PI_CODE IN VARCHAR2, PI_TYPE IN VARCHAR2) IS
    V_SQL  CLOB;
    V_FLAG VARCHAR2(64);
  BEGIN
    V_SQL := q'[SELECT NVL(to_char(END_TIME,'yyyymmdd'),0)
  FROM  ]' || CASE
               WHEN PI_TYPE = 0 THEN
                ' MRP.MATERIAL_COLOR_INVENTORY '
               WHEN PI_TYPE = 1 THEN
                ' MRP.MATERIAL_GREY_INVENTORY '
             END || ' WHERE INVENTORY_CODE = ''' || PI_CODE || '''';
  
    EXECUTE IMMEDIATE V_SQL  INTO V_FLAG;
    --DBMS_OUTPUT.put_line(V_SQL);
    
    IF V_FLAG = 0 THEN
      IF PI_TYPE = 0 THEN
        UPDATE MRP.MATERIAL_COLOR_INVENTORY T
           SET T.WHETHER_DEL = 1
         WHERE T.INVENTORY_CODE = PI_CODE;
        UPDATE MRP.MATERIAL_COLOR_INVENTORY_DETAIL A
          SET A.WHETHER_DEL=1
          WHERE A.INVENTORY_CODE= PI_CODE;
      ELSIF PI_TYPE = 1 THEN
        UPDATE MRP.MATERIAL_GREY_INVENTORY T
           SET T.WHETHER_DEL = 1
         WHERE T.INVENTORY_CODE = PI_CODE;
        UPDATE MRP.MATERIAL_GREY_INVENTORY_DETAIL A
           SET A.WHETHER_DEL=1
         WHERE A.INVENTORY_CODE=  PI_CODE;
      END IF;
    
    ELSE
      RAISE_APPLICATION_ERROR(-20002, '不可删除已提交的盘点单！');
    END IF;
  
  END P_DEL_WLINVENTORY;
  
  
/*-----------------------------------------------------------
成品供应商提交sku盘点单按钮
入参 
PI_PDID    盘点单号
PI_PDUSER  操作人id

---------------------------------------------------------------*/
  PROCEDURE P_SUBMIT_WLSKUPD(PI_PDID IN VARCHAR2,
                           PI_PDUSER IN VARCHAR2                          
                           ) IS 
  V_PDTYPE NUMBER;
  V_STOCKTYPE NUMBER; 
  V_NUM1   NUMBER;
  V_NUM2   NUMBER;
  V_NUM3   NUMBER; 
  V_PCRID  VARCHAR2(32);
  V_SCRID  VARCHAR2(32);                     
  V_ERR    VARCHAR2(4000);                         
BEGIN
  --仓库类型
    --品牌盘点量为空
  SELECT COUNT(1) INTO V_NUM1
    FROM MRP.MATERIAL_COLOR_INVENTORY_DETAIL Z
    WHERE Z.INVENTORY_CODE=PI_PDID
      AND Z.WHETHER_DEL=0
      AND Z.BRAND_INVENTORY IS  NULL;
   
   --供应商盘点量为空
     SELECT COUNT(1) INTO V_NUM2
       FROM  MRP.MATERIAL_COLOR_INVENTORY_DETAIL Z
    WHERE Z.INVENTORY_CODE=PI_PDID
      AND Z.WHETHER_DEL=0
      AND Z.SUPPLIER_INVENTORY IS NULL;
    
   --盘点明细总数   
    SELECT COUNT(1) INTO V_NUM3
      FROM  MRP.MATERIAL_COLOR_INVENTORY_DETAIL Z
     WHERE Z.INVENTORY_CODE=PI_PDID
       AND Z.WHETHER_DEL=0;
      
    --所有品牌盘点量无值,  所有供应商盘点量无值
      IF V_NUM1=V_NUM3 AND V_NUM2 = V_NUM3 THEN 
        V_STOCKTYPE:='';
        V_ERR:='盘点单无任何盘点数量';
      --所有品牌盘点量无值, 供应商盘点量有值
      ELSIF V_NUM1 = V_NUM3 AND (0 <= V_NUM2 AND V_NUM2< V_NUM3) THEN 
        V_STOCKTYPE :=2;
      
      --所有品牌盘点量有值, 供应商盘点量无值
      ELSIF (0 <= V_NUM1 AND V_NUM1 < V_NUM3) AND V_NUM2=V_NUM3 THEN 
        V_STOCKTYPE:=1;
      
      ELSE 
        V_STOCKTYPE:=3;
      END IF;
        
       IF V_ERR IS NOT NULL THEN 
         RAISE_APPLICATION_ERROR(-20002,V_ERR);
         
       ELSE 
       
  
  --盘点类型
  SELECT (CASE WHEN COUNT(1) = 0 THEN '1' ELSE '2' END) INTO V_PDTYPE
     FROM MRP.MATERIAL_COLOR_INVENTORY_DETAIL A
     WHERE A.INVENTORY_CODE=PI_PDID
       AND (A.BRAND_INVENTORY IS NULL OR A.SUPPLIER_INVENTORY IS NULL);  

  --落 盘点单
   UPDATE MRP.MATERIAL_COLOR_INVENTORY T
      SET T.INVENTORY_TYPE = V_PDTYPE,
          T.STOCK_TYPE     = V_STOCKTYPE,
          T.END_TIME       = SYSDATE
    WHERE T.INVENTORY_CODE = PI_PDID;
      
  DELETE FROM MRP.MATERIAL_COLOR_INVENTORY_DETAIL A WHERE A.INVENTORY_CODE = PI_PDID AND A.BRAND_INVENTORY IS NULL AND A.SUPPLIER_INVENTORY IS NULL;
      
    FOR X IN (SELECT * FROM MRP.MATERIAL_COLOR_INVENTORY_DETAIL A WHERE A.WHETHER_DEL=0 AND A.INVENTORY_CODE= PI_PDID)LOOP
          
    --落出入库
     --品牌仓
    IF X.BRAND_PROFIT_LOSS <0 THEN 
      --【品牌盈亏量】<0时，生成【出入库类型】= 【盘亏出库】，【仓库类型】= 【品牌仓】的出入库单，【数量】=【品牌盈亏量】
      --出库单号
      V_PCRID :=MRP.PKG_PLAT_COMM.F_GET_DOCUNO(PI_TABLE_NAME  => 'MRP.MATERIAL_COLOR_IN_OUT_BOUND',
                                              PI_COLUMN_NAME => 'BOUND_NUM',
                                              PI_PRE         => 'PKCK'||TO_CHAR(SYSDATE,'YYYYDDMM'),
                                              PI_SERAIL_NUM  =>5 );
      INSERT INTO MRP.MATERIAL_COLOR_IN_OUT_BOUND
        (BOUND_NUM, ASCRIPTION, BOUND_TYPE,  MATER_SUPPLIER_CODE, MATERIAL_SKU,  UNIT, 
        NUM, STOCK_TYPE, RELATE_NUM, RELATE_NUM_TYPE,COMPANY_ID, CREATE_ID, CREATE_TIME, WHETHER_DEL)
      VALUES
        (V_PCRID, 0, 2,  X.MATER_SUPPLIER_CODE,X.MATERIAL_SKU, X.UNIT, 
        ABS(X.BRAND_PROFIT_LOSS),1, X.INVENTORY_CODE, 2, 'b6cc680ad0f599cde0531164a8c0337f',PI_PDUSER, SYSDATE, 0);
        
      --落库存明细  
    UPDATE MRP.MATERIAL_COLOR_CLOTH_STOCK Y 
      SET  Y.UPDATE_TIME=SYSDATE,
           Y.UPDATE_ID=PI_PDUSER,
           Y.BRAND_STOCK= NVL(Y.BRAND_STOCK,0)+NVL(X.BRAND_PROFIT_LOSS,0)
     WHERE  Y.MATER_SUPPLIER_CODE=X.MATER_SUPPLIER_CODE
       AND Y.MATERIAL_SKU=X.MATERIAL_SKU
       AND Y.UNIT = X.UNIT;
    ELSIF X.BRAND_PROFIT_LOSS >0 THEN 
      -- 当【品牌盈亏量】>0时，生成【出入库类型】= 【盘盈入库】，【仓库类型】= 【品牌仓】的出入库单，【数量】=【品牌盈亏量】 
      --入库单号
      V_PCRID :=MRP.PKG_PLAT_COMM.F_GET_DOCUNO(PI_TABLE_NAME  => 'MRP.MATERIAL_COLOR_IN_OUT_BOUND',
                                              PI_COLUMN_NAME => 'BOUND_NUM',
                                              PI_PRE         => 'PKRK'||TO_CHAR(SYSDATE,'YYYYDDMM'),
                                              PI_SERAIL_NUM  =>5 );
      INSERT INTO MRP.MATERIAL_COLOR_IN_OUT_BOUND
        (BOUND_NUM, ASCRIPTION, BOUND_TYPE, MATER_SUPPLIER_CODE, MATERIAL_SKU,  UNIT, 
        NUM, STOCK_TYPE, RELATE_NUM, RELATE_NUM_TYPE,COMPANY_ID,  CREATE_ID, CREATE_TIME, WHETHER_DEL)
      VALUES
        (V_PCRID, 1, 13,  X.MATER_SUPPLIER_CODE, X.MATERIAL_SKU,  X.UNIT, 
        ABS(X.BRAND_PROFIT_LOSS), 1, X.INVENTORY_CODE, 2,'b6cc680ad0f599cde0531164a8c0337f', PI_PDUSER, SYSDATE, 0);
      
      --落库存明细                                     
       UPDATE MRP.MATERIAL_COLOR_CLOTH_STOCK Y 
      SET  Y.UPDATE_TIME=SYSDATE,
           Y.UPDATE_ID=PI_PDUSER,
           Y.BRAND_STOCK= NVL(Y.BRAND_STOCK,0)+NVL(X.BRAND_PROFIT_LOSS,0)
     WHERE Y.MATER_SUPPLIER_CODE=X.MATER_SUPPLIER_CODE
       AND Y.MATERIAL_SKU=X.MATERIAL_SKU
       AND Y.UNIT = X.UNIT;                                       
    END IF;
     --供应商仓
     IF X.SUPPLIER_PROFIT_LOSS <0 THEN 
       --当【供应商盈亏量】<0时，生成【出入库类型】= 【盘亏出库】，【仓库类型】= 【供应商仓】的出入库单 ，【数量】=【供应商盈亏量】
       V_SCRID :=MRP.PKG_PLAT_COMM.F_GET_DOCUNO(PI_TABLE_NAME  => 'MRP.MATERIAL_COLOR_IN_OUT_BOUND',
                                              PI_COLUMN_NAME => 'BOUND_NUM',
                                              PI_PRE         => 'PKCK'||TO_CHAR(SYSDATE,'YYYYDDMM'),
                                              PI_SERAIL_NUM  =>5 );
       
       INSERT INTO MRP.MATERIAL_COLOR_IN_OUT_BOUND
        (BOUND_NUM, ASCRIPTION, BOUND_TYPE, MATER_SUPPLIER_CODE, MATERIAL_SKU,  UNIT, 
        NUM, STOCK_TYPE, RELATE_NUM, RELATE_NUM_TYPE,COMPANY_ID, CREATE_ID, CREATE_TIME, WHETHER_DEL)
      VALUES                                       
        (V_SCRID,0,2,X.MATER_SUPPLIER_CODE,X.MATERIAL_SKU,X.UNIT,
        ABS(X.SUPPLIER_PROFIT_LOSS),2,X.INVENTORY_CODE,2,'b6cc680ad0f599cde0531164a8c0337f', PI_PDUSER, SYSDATE, 0); 
     --落库存明细                                         
     UPDATE MRP.MATERIAL_COLOR_CLOTH_STOCK Y 
      SET  Y.UPDATE_TIME=SYSDATE,
           Y.UPDATE_ID=PI_PDUSER,
           Y.SUPPLIER_STOCK = NVL(Y.SUPPLIER_STOCK,0)+NVL(X.SUPPLIER_PROFIT_LOSS,0)
     WHERE Y.MATER_SUPPLIER_CODE=X.MATER_SUPPLIER_CODE
       AND Y.MATERIAL_SKU=X.MATERIAL_SKU
       AND Y.UNIT = X.UNIT; 
     
     
     ELSIF X.SUPPLIER_PROFIT_LOSS >0 THEN 
       --当【供应商盈亏量】>0时，生成【出入库类型】= 【盘盈入库】，【仓库类型】= 【供应商仓】的出入库单  ，【数量】=【供应商盈亏量】
       V_SCRID :=MRP.PKG_PLAT_COMM.F_GET_DOCUNO(PI_TABLE_NAME  => 'MRP.MATERIAL_COLOR_IN_OUT_BOUND',
                                              PI_COLUMN_NAME => 'BOUND_NUM',
                                              PI_PRE         => 'PKRK'||TO_CHAR(SYSDATE,'YYYYDDMM'),
                                              PI_SERAIL_NUM  =>5 );
     
     INSERT INTO MRP.MATERIAL_COLOR_IN_OUT_BOUND
        (BOUND_NUM, ASCRIPTION, BOUND_TYPE,  MATER_SUPPLIER_CODE, MATERIAL_SKU, UNIT, 
        NUM, STOCK_TYPE, RELATE_NUM, RELATE_NUM_TYPE,COMPANY_ID, CREATE_ID, CREATE_TIME, WHETHER_DEL)
      VALUES
      (V_SCRID,1,13,X.MATER_SUPPLIER_CODE,X.MATERIAL_SKU,X.UNIT,
      ABS(X.SUPPLIER_PROFIT_LOSS),2,X.INVENTORY_CODE,2,'b6cc680ad0f599cde0531164a8c0337f', PI_PDUSER, SYSDATE, 0); 
     
     --落库存明细 
      UPDATE MRP.MATERIAL_COLOR_CLOTH_STOCK Y 
      SET  Y.UPDATE_TIME=SYSDATE,
           Y.UPDATE_ID=PI_PDUSER,
           Y.SUPPLIER_STOCK = NVL(Y.SUPPLIER_STOCK,0)+NVL(X.SUPPLIER_PROFIT_LOSS,0)
     WHERE Y.MATER_SUPPLIER_CODE=X.MATER_SUPPLIER_CODE
       AND Y.MATERIAL_SKU=X.MATERIAL_SKU
       AND Y.UNIT = X.UNIT; 
     
     END IF;
       UPDATE MRP.MATERIAL_COLOR_CLOTH_STOCK Y
          SET Y.TOTAL_STOCK = NVL(Y.BRAND_STOCK,0)+NVL(Y.SUPPLIER_STOCK,0)
        WHERE Y.MATER_SUPPLIER_CODE=X.MATER_SUPPLIER_CODE
          AND Y.MATERIAL_SKU=X.MATERIAL_SKU
          AND Y.UNIT = X.UNIT;
       
  END LOOP;  
    
  END IF;  



END P_SUBMIT_WLSKUPD;


     /*==========================================================
编辑物料供应商盘点单 
 入参
 PI_CODE   :     单据号
 PI_USERID :     修改人
 PI_MEMO   :     修改内容
 PI_TYPE   :     0 色布 1 坯布
 PI_OPCOM  :     修改人当前企业id       
 
=============================================================*/
  
  
  PROCEDURE P_UPD_WLINVENTORY (pi_code IN VARCHAR2,
                               pi_userid IN VARCHAR2,
                               pi_memo   IN VARCHAR2,
                               PI_TYPE   IN VARCHAR2,
                               PI_OPCOM  IN VARCHAR2) IS 
 V_SQL CLOB;                            
 V_DATE VARCHAR2(64);                            
BEGIN
  --校验结束时间
  V_SQL:=q'[SELECT NVL(to_char(END_TIME+90,'yyyymmdd'),0)
  FROM  ]'||CASE WHEN pi_type = 0 THEN ' MRP.MATERIAL_COLOR_INVENTORY ' WHEN pi_type = 1 THEN ' MRP.MATERIAL_GREY_INVENTORY ' END ||' WHERE INVENTORY_CODE = '''||pi_code||'''';
 
 EXECUTE IMMEDIATE V_SQL INTO V_DATE;
 IF V_DATE <>0 AND TO_CHAR(SYSDATE,'YYYYMMDD') > V_DATE THEN 
   RAISE_APPLICATION_ERROR(-20002,'盘点结束已超90天，不可再编辑盘点备注！');
 ELSE
   BEGIN
  scmdata.pkg_plat_log.p_document_change_trace(p_company_id              => 'b6cc680ad0f599cde0531164a8c0337f',
                                               p_document_id             => PI_CODE,
                                               p_data_source_parent_code => 'STOCK_MANA_LOG',
                                               p_data_source_child_code  => '01',
                                               p_operate_company_id      => PI_OPCOM ,
                                               p_user_id                 => PI_USERID);
END;  
   IF PI_TYPE =0 THEN 
     UPDATE MRP.MATERIAL_COLOR_INVENTORY T
        SET T.REMARKS     = PI_MEMO,
            T.UPDATE_ID   = PI_USERID,
            T.UPDATE_TIME = SYSDATE,
            T.UPDATE_COMPANY_ID =PI_OPCOM
      WHERE T.INVENTORY_CODE = PI_CODE;
   ELSIF PI_TYPE =1 THEN
       UPDATE MRP.MATERIAL_GREY_INVENTORY T
        SET T.REMARKS     = PI_MEMO,
            T.UPDATE_ID   = PI_USERID,
            T.UPDATE_TIME = SYSDATE,
            T.UPDATE_COMPANY_ID = PI_OPCOM
      WHERE T.INVENTORY_CODE = PI_CODE;
   END IF;
     
 END IF;

END P_UPD_WLINVENTORY; 

/*-----------------------------------------------------------
成品供应商提交spu盘点单按钮
入参 
PI_PDID    盘点单号
PI_PDUSER  操作人id

---------------------------------------------------------------*/

PROCEDURE P_SUBMIT_WLSPUPD(PI_PDID IN VARCHAR2,
                           PI_PDUSER IN VARCHAR2                          
                           ) IS 
  V_PDTYPE NUMBER;
  V_STOCKTYPE NUMBER; 
  V_NUM1   NUMBER;
  V_NUM2   NUMBER;
  V_NUM3   NUMBER; 
  V_PCRID  VARCHAR2(32);
  V_SCRID  VARCHAR2(32);                     
  V_ERR    VARCHAR2(4000) :=NULL;                         
BEGIN
  --仓库类型
    --品牌盘点量为空
  SELECT COUNT(1) INTO V_NUM1
    FROM MRP.MATERIAL_GREY_INVENTORY_DETAIL Z
    WHERE Z.INVENTORY_CODE=PI_PDID
      AND Z.WHETHER_DEL=0
      AND Z.BRAND_INVENTORY IS  NULL;
   
   --供应商盘点量为空
     SELECT COUNT(1) INTO V_NUM2
       FROM  MRP.MATERIAL_GREY_INVENTORY_DETAIL Z
    WHERE Z.INVENTORY_CODE=PI_PDID
      AND Z.WHETHER_DEL=0
      AND Z.SUPPLIER_INVENTORY IS NULL;
    
   --盘点明细总数   
    SELECT COUNT(1) INTO V_NUM3
      FROM  MRP.MATERIAL_GREY_INVENTORY_DETAIL Z
     WHERE Z.INVENTORY_CODE=PI_PDID
       AND Z.WHETHER_DEL=0;
      
    --所有品牌盘点量无值,  所有供应商盘点量无值
      IF V_NUM1=V_NUM3 AND V_NUM2 = V_NUM3 THEN 
        V_STOCKTYPE:='';
        V_ERR:='盘点单无任何盘点数量'; 
      --所有品牌盘点量无值, 供应商盘点量有值
      ELSIF V_NUM1 = V_NUM3 AND (0 <= V_NUM2 AND V_NUM2< V_NUM3) THEN 
        V_STOCKTYPE :=2;
      
      --所有品牌盘点量有值, 供应商盘点量无值
      ELSIF (0 <= V_NUM1 AND V_NUM1 < V_NUM3) AND V_NUM2=V_NUM3 THEN 
        V_STOCKTYPE:=1;
      
      ELSE 
        V_STOCKTYPE:=3;
      END IF;
        
      IF V_ERR IS NOT NULL THEN 
        
      RAISE_APPLICATION_ERROR(-20002,V_ERR);
      
       ELSE
       
  
  --盘点类型
  SELECT (CASE WHEN COUNT(1) = 0 THEN '1' ELSE '2' END) INTO V_PDTYPE
     FROM MRP.MATERIAL_GREY_INVENTORY_DETAIL A
     WHERE A.INVENTORY_CODE=PI_PDID
       AND (A.BRAND_INVENTORY IS NULL OR A.SUPPLIER_INVENTORY IS NULL);  

  --落 盘点单
   UPDATE MRP.MATERIAL_GREY_INVENTORY T
      SET T.INVENTORY_TYPE = V_PDTYPE,
          T.STOCK_TYPE     = V_STOCKTYPE,
          T.END_TIME       = SYSDATE
    WHERE T.INVENTORY_CODE = PI_PDID;
      
  DELETE FROM MRP.MATERIAL_GREY_INVENTORY_DETAIL a WHERE A.BRAND_INVENTORY IS NULL AND A.SUPPLIER_INVENTORY IS NULL AND A.INVENTORY_CODE =PI_PDID;
      
    FOR X IN (SELECT * FROM MRP.MATERIAL_GREY_INVENTORY_DETAIL A WHERE A.WHETHER_DEL=0 AND A.INVENTORY_CODE= PI_PDID)LOOP
          
    --落出入库
     --品牌仓
    IF X.BRAND_PROFIT_LOSS <0 THEN 
      --【品牌盈亏量】<0时，生成【出入库类型】= 【盘亏出库】，【仓库类型】= 【品牌仓】的出入库单，【数量】=【品牌盈亏量】
      --出库单号
      V_PCRID :=MRP.PKG_PLAT_COMM.F_GET_DOCUNO(PI_TABLE_NAME  => 'MRP.MATERIAL_GREY_IN_OUT_BOUND',
                                              PI_COLUMN_NAME => 'BOUND_NUM',
                                              PI_PRE         => 'PPCK'||TO_CHAR(SYSDATE,'YYYYDDMM'),
                                              PI_SERAIL_NUM  =>5 );
      INSERT INTO MRP.MATERIAL_GREY_IN_OUT_BOUND
        (BOUND_NUM, ASCRIPTION, BOUND_TYPE,  MATER_SUPPLIER_CODE, MATERIAL_SPU, UNIT, 
        NUM, STOCK_TYPE, RELATE_NUM, RELATE_NUM_TYPE,COMPANY_ID, CREATE_ID, CREATE_TIME, WHETHER_DEL)
      VALUES
        (V_PCRID, 0, 2,  X.MATER_SUPPLIER_CODE,X.MATERIAL_SPU, X.UNIT, 
        ABS(X.BRAND_PROFIT_LOSS),1, X.INVENTORY_CODE, 2, 'b6cc680ad0f599cde0531164a8c0337f',PI_PDUSER, SYSDATE, 0);
        
      --落库存明细  
    UPDATE MRP.MATERIAL_GREY_STOCK Y 
      SET  Y.UPDATE_TIME=SYSDATE,
           Y.UPDATE_ID=PI_PDUSER,
           Y.BRAND_STOCK=NVL(Y.BRAND_STOCK,0)+NVL(X.BRAND_PROFIT_LOSS,0)
     WHERE Y.MATER_SUPPLIER_CODE=X.MATER_SUPPLIER_CODE
       AND Y.MATERIAL_SPU=X.MATERIAL_SPU
       AND Y.UNIT = X.UNIT;
    ELSIF X.BRAND_PROFIT_LOSS >0 THEN 
      -- 当【品牌盈亏量】>0时，生成【出入库类型】= 【盘盈入库】，【仓库类型】= 【品牌仓】的出入库单，【数量】=【品牌盈亏量】 
      --入库单号
      V_PCRID :=MRP.PKG_PLAT_COMM.F_GET_DOCUNO(PI_TABLE_NAME  => 'MRP.MATERIAL_GREY_IN_OUT_BOUND',
                                              PI_COLUMN_NAME => 'BOUND_NUM',
                                              PI_PRE         => 'PPRK'||TO_CHAR(SYSDATE,'YYYYDDMM'),
                                              PI_SERAIL_NUM  =>5 );
      INSERT INTO MRP.MATERIAL_GREY_IN_OUT_BOUND
        (BOUND_NUM, ASCRIPTION, BOUND_TYPE,  MATER_SUPPLIER_CODE, MATERIAL_SPU,  UNIT, 
        NUM, STOCK_TYPE, RELATE_NUM, RELATE_NUM_TYPE,COMPANY_ID,  CREATE_ID, CREATE_TIME, WHETHER_DEL)
      VALUES
        (V_PCRID, 1, 13,  X.MATER_SUPPLIER_CODE, X.MATERIAL_SPU,  X.UNIT, 
        ABS(X.BRAND_PROFIT_LOSS), 1, X.INVENTORY_CODE, 2,'b6cc680ad0f599cde0531164a8c0337f', PI_PDUSER, SYSDATE, 0);
      
      --落库存明细                                     
       UPDATE MRP.MATERIAL_GREY_STOCK Y 
      SET  Y.UPDATE_TIME=SYSDATE,
           Y.UPDATE_ID=PI_PDUSER,
           Y.BRAND_STOCK=NVL(Y.BRAND_STOCK,0)+NVL(X.BRAND_PROFIT_LOSS,0)
     WHERE Y.MATER_SUPPLIER_CODE=X.MATER_SUPPLIER_CODE
       AND Y.MATERIAL_SPU=X.MATERIAL_SPU
       AND Y.UNIT = X.UNIT;                                       
    END IF;
     --供应商仓
     IF X.SUPPLIER_PROFIT_LOSS <0 THEN 
       --当【供应商盈亏量】<0时，生成【出入库类型】= 【盘亏出库】，【仓库类型】= 【供应商仓】的出入库单 ，【数量】=【供应商盈亏量】
       V_SCRID :=MRP.PKG_PLAT_COMM.F_GET_DOCUNO(PI_TABLE_NAME  => 'MRP.MATERIAL_GREY_IN_OUT_BOUND',
                                              PI_COLUMN_NAME => 'BOUND_NUM',
                                              PI_PRE         => 'PPCK'||TO_CHAR(SYSDATE,'YYYYDDMM'),
                                              PI_SERAIL_NUM  =>5 );
       
       INSERT INTO MRP.MATERIAL_GREY_IN_OUT_BOUND
        (BOUND_NUM, ASCRIPTION, BOUND_TYPE,  MATER_SUPPLIER_CODE, MATERIAL_SPU, UNIT, 
        NUM, STOCK_TYPE, RELATE_NUM, RELATE_NUM_TYPE,COMPANY_ID, CREATE_ID, CREATE_TIME, WHETHER_DEL)
      VALUES                                       
        (V_SCRID,0,2,X.MATER_SUPPLIER_CODE,X.MATERIAL_SPU,X.UNIT,
        ABS(X.SUPPLIER_PROFIT_LOSS),2,X.INVENTORY_CODE,2,'b6cc680ad0f599cde0531164a8c0337f', PI_PDUSER, SYSDATE, 0); 
     --落库存明细                                         
     UPDATE MRP.MATERIAL_GREY_STOCK Y 
      SET  Y.UPDATE_TIME=SYSDATE,
           Y.UPDATE_ID=PI_PDUSER,
           Y.SUPPLIER_STOCK =NVL(Y.SUPPLIER_STOCK,0)+NVL(X.SUPPLIER_PROFIT_LOSS,0)
     WHERE Y.MATER_SUPPLIER_CODE=X.MATER_SUPPLIER_CODE
       AND Y.MATERIAL_SPU=X.MATERIAL_SPU
       AND Y.UNIT = X.UNIT; 
     
     
     ELSIF X.SUPPLIER_PROFIT_LOSS >0 THEN 
       --当【供应商盈亏量】>0时，生成【出入库类型】= 【盘盈入库】，【仓库类型】= 【供应商仓】的出入库单  ，【数量】=【供应商盈亏量】
       V_SCRID :=MRP.PKG_PLAT_COMM.F_GET_DOCUNO(PI_TABLE_NAME  => 'MRP.MATERIAL_GREY_IN_OUT_BOUND',
                                              PI_COLUMN_NAME => 'BOUND_NUM',
                                              PI_PRE         => 'PPRK'||TO_CHAR(SYSDATE,'YYYYDDMM'),
                                              PI_SERAIL_NUM  =>5 );
     
     INSERT INTO MRP.MATERIAL_GREY_IN_OUT_BOUND
        (BOUND_NUM, ASCRIPTION, BOUND_TYPE,  MATER_SUPPLIER_CODE, MATERIAL_SPU,  UNIT, 
        NUM, STOCK_TYPE, RELATE_NUM, RELATE_NUM_TYPE,COMPANY_ID, CREATE_ID, CREATE_TIME, WHETHER_DEL)
      VALUES
      (V_SCRID,1,13,X.MATER_SUPPLIER_CODE,X.MATERIAL_SPU,X.UNIT,
      ABS(X.SUPPLIER_PROFIT_LOSS),2,X.INVENTORY_CODE,2,'b6cc680ad0f599cde0531164a8c0337f', PI_PDUSER, SYSDATE, 0); 
     
     --落库存明细 
      UPDATE MRP.MATERIAL_GREY_STOCK Y 
      SET  Y.UPDATE_TIME=SYSDATE,
           Y.UPDATE_ID=PI_PDUSER,
           Y.SUPPLIER_STOCK = NVL(Y.SUPPLIER_STOCK,0)+NVL(X.SUPPLIER_PROFIT_LOSS,0)
     WHERE Y.MATER_SUPPLIER_CODE=X.MATER_SUPPLIER_CODE
       AND Y.MATERIAL_SPU=X.MATERIAL_SPU
       AND Y.UNIT = X.UNIT; 
     
     END IF;
       UPDATE MRP.MATERIAL_GREY_STOCK Y
          SET Y.TOTAL_STOCK = NVL(Y.BRAND_STOCK,0)+NVL(Y.SUPPLIER_STOCK,0)
        WHERE Y.MATER_SUPPLIER_CODE=X.MATER_SUPPLIER_CODE
          AND Y.MATERIAL_SPU=X.MATERIAL_SPU
          AND Y.UNIT = X.UNIT;
       
  END LOOP;  
  END IF;  

END P_SUBMIT_WLSPUPD;
 

/*-----------------------------------------------------------------
查询盘点单详情
 入参
 PI_CODE   盘点单号
 PI_MODE   CP/WL
 PI_TYPE   SPU/SKU

------------------------------------------------------------------*/
FUNCTION F_QUERY_INVENTORY_DETAIL(PI_CODE  IN VARCHAR2,
                                    PI_MODE  IN VARCHAR2 ,--CP/WL
                                    PI_TYPE  IN VARCHAR2 --SPU/SKU
                                   -- PI_SUPID IN VARCHAR2
                                    ) RETURN CLOB IS 
   v_s_sql CLOB;                                
   v_f_sql CLOB;    
   V_SQL   CLOB;                             
 BEGIN
   IF PI_MODE = 'WL' THEN
   V_S_SQL :=q'[SELECT A.INVENTORY_CODE,--盘点单号
        (CASE A.STOCK_TYPE
         WHEN 1 THEN  '品牌仓'
         WHEN 2 THEN  '供应商仓'
         WHEN 3 THEN '品牌仓/供应商仓' END) STOCK_TYPE,--仓库类型
        NVL(C.USERNAME,C.NICK_NAME)  INVENTORY_CHECKER, --盘点人
        (CASE A.INVENTORY_TYPE  WHEN 1 THEN '仓库全盘' WHEN 2 THEN '部分盘点' END) INVENTORY_TYPE,--盘点单类型
        A.CREATE_TIME INVENTORY_CRETIME, --盘点创建时间
        A.END_TIME INVENTORY_ENDTIME,  ]'||CASE PI_TYPE WHEN 'SKU' THEN ' B.MATERIAL_SKU,' WHEN 'SPU' THEN 'B.MATERIAL_SPU, ' END ||
        q'[ M.MATERIAL_NAME, ]'||CASE PI_TYPE WHEN 'SKU' THEN 'M.MATERIAL_COLOR, ' WHEN 'SPU' THEN NULL END||
        q'[B.UNIT, B.OLD_TOTAL_STOCK TOTAL_STOCK, B.OLD_BRAND_STOCK BRAND_STOCK, B.OLD_SUPPLIER_STOCK SUPPLIER_STOCK,
        B.BRAND_INVENTORY,
       B.SUPPLIER_INVENTORY,
        B.BRAND_PROFIT_LOSS,
        B.SUPPLIER_PROFIT_LOSS, M.SUPPLIER_MATERIAL_NAME ]' ||
        CASE PI_TYPE WHEN 'SKU' THEN ', M.SUPPLIER_COLOR, M.SUPPLIER_SHADES ' WHEN 'SPU' THEN NULL END ;
        
  IF PI_TYPE = 'SKU' THEN        
   V_F_SQL:=q'[  
    FROM MRP.MATERIAL_COLOR_INVENTORY A --色布
INNER JOIN MRP.MATERIAL_COLOR_INVENTORY_DETAIL B ON A.INVENTORY_CODE=B.INVENTORY_CODE AND A.MATER_SUPPLIER_CODE=B.MATER_SUPPLIER_CODE
INNER JOIN SCMDATA.SYS_USER C   ON A.CREATE_ID = C.USER_ID
INNER JOIN (
    SELECT z.material_sku,
           Y.MATERIAL_COLOR,
       x.material_name,
       Z.SUPPLIER_MATERIAL_NAME,
       z.supplier_color,
       x.MATERIAL_CLASSIFICATION,
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
) M ON M.material_sku=B.MATERIAL_SKU AND A.MATER_SUPPLIER_CODE = M.supplier_code
WHERE (B.BRAND_INVENTORY IS NOT NULL OR B.SUPPLIER_INVENTORY IS NOT NULL)
AND A.INVENTORY_CODE=']'||PI_CODE||''''; 
  ELSIF PI_TYPE = 'SPU' THEN 
   V_F_SQL:=q'[FROM MRP.MATERIAL_GREY_INVENTORY A
  INNER JOIN MRP.MATERIAL_GREY_INVENTORY_DETAIL B ON A.INVENTORY_CODE=B.INVENTORY_CODE AND A.MATER_SUPPLIER_CODE=B.MATER_SUPPLIER_CODE   
  INNER JOIN SCMDATA.SYS_USER C   ON A.CREATE_ID = C.USER_ID
  INNER JOIN (
             SELECT W.SUPPLIER_ABBREVIATION MATERIAL_SUPP_NAME,
                    X.SUPPLIER_CODE, 
                    Z.MATERIAL_SPU, 
                    Z.UNIT,  
                    Z.MATERIAL_NAME,
                    Z.MATERIAL_CLASSIFICATION, 
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
) M ON M.MATERIAL_SPU = B.MATERIAL_SPU AND A.MATER_SUPPLIER_CODE =M.SUPPLIER_CODE
   WHERE (B.BRAND_INVENTORY IS NOT NULL OR B.SUPPLIER_INVENTORY IS NOT NULL)
   AND A.INVENTORY_CODE=']'||PI_CODE||'''';   
  END IF;     
  ELSIF PI_MODE ='CP' THEN 
    V_S_SQL :=q'[SELECT A.INVENTORY_CODE,--盘点单号
        (CASE A.STOCK_TYPE
         WHEN 1 THEN  '品牌仓'
         WHEN 2 THEN  '供应商仓'
         WHEN 3 THEN '品牌仓/供应商仓' END) STOCK_TYPE,--仓库类型
        NVL(C.USERNAME,C.NICK_NAME)  INVENTORY_CHECKER, --盘点人
        (CASE A.INVENTORY_TYPE  WHEN 1 THEN '仓库全盘' WHEN 2 THEN '部分盘点' END) INVENTORY_TYPE,--盘点单类型
        A.CREATE_TIME INVENTORY_CRETIME, --盘点创建时间
        A.END_TIME INVENTORY_ENDTIME, M.SUPPLIER_NAME MATERIAL_SUPP_NAME, ]'||CASE PI_TYPE WHEN 'SKU' THEN ' B.MATERIAL_SKU,' WHEN 'SPU' THEN 'B.MATERIAL_SPU, ' END ||
        q'[ M.MATERIAL_NAME, ]'||CASE PI_TYPE WHEN 'SKU' THEN 'M.MATERIAL_COLOR, ' WHEN 'SPU' THEN NULL END||
        q'[B.UNIT, B.OLD_TOTAL_STOCK TOTAL_STOCK, B.OLD_BRAND_STOCK BRAND_STOCK, B.OLD_SUPPLIER_STOCK SUPPLIER_STOCK,
        B.BRAND_INVENTORY,B.SUPPLIER_INVENTORY,  
         B.BRAND_PROFIT_LOSS,
        B.SUPPLIER_PROFIT_LOSS, M.SUPPLIER_MATERIAL_NAME ]' ||
        CASE PI_TYPE WHEN 'SKU' THEN ', M.SUPPLIER_COLOR, M.SUPPLIER_SHADES,  M.SUPPLIER_CODE MATER_SUPPLIER_CODE,
        (CASE  B.WHETHER_INNER_MATER WHEN 0 THEN ''否'' WHEN 1 THEN ''是'' END)  IS_INNER_MATERIAL ' WHEN 'SPU' THEN NULL END ;
        
  IF PI_TYPE = 'SKU' THEN        
   V_F_SQL:=q'[  
    FROM MRP.SUPPLIER_COLOR_INVENTORY A --色布
INNER JOIN MRP.SUPPLIER_COLOR_INVENTORY_DETAIL B ON A.INVENTORY_CODE=B.INVENTORY_CODE AND A.PRO_SUPPLIER_CODE=B.PRO_SUPPLIER_CODE
INNER JOIN SCMDATA.SYS_USER C   ON A.CREATE_ID = C.USER_ID
INNER JOIN (SELECT Z.MATERIAL_SKU,
       Z.MATERIAL_COLOR,
       Y.MATERIAL_NAME,
       X.SUPPLIER_MATERIAL_NAME,
       X.SUPPLIER_COLOR,
       y.material_classification,
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
    UNION ALL
    SELECT z.material_sku,
           Y.MATERIAL_COLOR,
       x.material_name,
       Z.SUPPLIER_MATERIAL_NAME,
       z.supplier_color,
       x.MATERIAL_CLASSIFICATION,
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
) M ON M.material_sku=B.MATERIAL_SKU 
WHERE (B.brand_inventory IS NOT NULL OR B.supplier_inventory IS NOT NULL )
AND  A.INVENTORY_CODE=']'||PI_CODE||''''; 
  ELSIF PI_TYPE = 'SPU' THEN 
   V_F_SQL:=q'[FROM MRP.SUPPLIER_GREY_INVENTORY A
  INNER JOIN MRP.SUPPLIER_GREY_INVENTORY_DETAIL B ON A.INVENTORY_CODE=B.INVENTORY_CODE AND A.PRO_SUPPLIER_CODE=B.PRO_SUPPLIER_CODE  
  INNER JOIN SCMDATA.SYS_USER C   ON A.CREATE_ID = C.USER_ID
  INNER JOIN (SELECT W.SUPPLIER_NAME,
                    W.SUPPLIER_CODE, 
                    Z.MATERIAL_SPU, 
                    Z.UNIT,  
                    Z.MATERIAL_NAME, 
                    Z.MATERIAL_CLASSIFICATION, 
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
             UNION
             SELECT W.SUPPLIER_ABBREVIATION SUPPLIER_NAME,
                    X.SUPPLIER_CODE, 
                    Z.MATERIAL_SPU, 
                    Z.UNIT,  
                    Z.MATERIAL_NAME,
                    Z.MATERIAL_CLASSIFICATION, 
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
) M ON M.MATERIAL_SPU = B.MATERIAL_SPU
   WHERE (B.BRAND_INVENTORY IS NOT NULL OR B.SUPPLIER_INVENTORY IS NOT NULL)
   AND A.INVENTORY_CODE=']'||PI_CODE||''''; 
  
 END IF; 
 END IF;
  V_SQL:=V_S_SQL||V_F_SQL;
  RETURN V_SQL;
  
 END F_QUERY_INVENTORY_DETAIL; 

/*-------------------------------------------------------
sku库存入库生成spu出入库单
入参
 V_MODE          WL/CP
 V_BOUNDNUM      出入库单号
 V_USERID        操作人id
 V_TYPE          SKU

---------------------------------------------------------*/
PROCEDURE P_CRESPUBOUND_BYSKU(V_MODE      IN VARCHAR2, --WL/CP
                              --V_KCID      IN VARCHAR2, --库存明细id
                              V_BOUNDNUM     IN VARCHAR2,  --出入库id
                              V_USERID    IN VARCHAR2,
                              V_TYPE      IN VARCHAR2) IS
V_SPU       VARCHAR2(64);
V_RANSUNL   NUMBER;
V_PORSUP    VARCHAR2(64);
V_MATSUP    VARCHAR2(64);
V_SKU       VARCHAR2(64);
V_ISINNER   VARCHAR2(64);
V_UNIT      VARCHAR2(64);
V_CRKNUM    VARCHAR2(64);
V_BRAND_STOCK  NUMBER;
V_SUPP_STOCK  NUMBER;
V_NUM1       NUMBER;
V_NUM2       NUMBER;
V_CRKID     VARCHAR2(64);
V_CRKID2   VARCHAR2(64);
BEGIN
  IF V_MODE = 'CP' AND V_TYPE = 'SKU' THEN 

 /* SELECT T.PRO_SUPPLIER_CODE,T.MATER_SUPPLIER_CODE,T.UNIT,T.MATERIAL_SKU,T.WHETHER_INNER_MATER
    INTO V_PORSUP,V_MATSUP,V_UNIT,V_SKU,V_ISINNER
    FROM MRP.SUPPLIER_COLOR_CLOTH_STOCK T
   WHERE T.COLOR_CLOTH_STOCK_ID = V_KCID
     AND T.WHETHER_DEL=0;*/ 
     
     SELECT T.PRO_SUPPLIER_CODE,T.MATER_SUPPLIER_CODE,T.MATERIAL_SKU,T.WHETHER_INNER_MATER,T.UNIT,T.NUM
       INTO V_PORSUP,V_MATSUP,V_SKU,V_ISINNER,V_UNIT,V_CRKNUM
       FROM MRP.SUPPLIER_COLOR_IN_OUT_BOUND T
       WHERE T.BOUND_NUM=V_BOUNDNUM 
        AND T.WHETHER_DEL=0;
     --坯布出入库单
     --找到对应的spu
     SELECT M.MATERIAL_SPU,M.DYE_LOSS_LATE INTO V_SPU,V_RANSUNL
       FROM (SELECT Y.MATERIAL_SPU,
       X.CREATE_FINISHED_SUPPLIER_CODE,
      NVL( X.DYE_LOSS_LATE,0) DYE_LOSS_LATE, --染损率
      y.MATERIAL_SKU,
      0 IS_INNER
FROM MRP.MRP_OUTSIDE_MATERIAL_SKU Y
INNER JOIN MRP.MRP_OUTSIDE_MATERIAL_SPU Z ON Z.MATERIAL_SPU=Y.MATERIAL_SPU
INNER JOIN  MRP.MRP_OUTSIDE_SUPPLIER_MATERIAL X ON X.MATERIAL_SKU=Y.MATERIAL_SKU
UNION 
SELECT Z.MATERIAL_SPU,
       X.SUPPLIER_CODE,
       NVL(X.DYE_LOSS_LATE,0),
       Y.MATERIAL_SKU,
       1 IS_INNER
FROM MRP.MRP_INTERNAL_MATERIAL_SKU Y
INNER JOIN MRP.MRP_INTERNAL_MATERIAL_SPU Z ON Y.MATERIAL_SPU=Z.MATERIAL_SPU
INNER JOIN MRP.MRP_INTERNAL_SUPPLIER_MATERIAL X ON X.MATERIAL_SKU=Y.MATERIAL_SKU
                )  M WHERE (M.IS_INNER=V_ISINNER AND M.MATERIAL_SKU=V_SKU) OR (M.IS_INNER=V_ISINNER AND M.MATERIAL_SKU=V_SKU AND M.CREATE_FINISHED_SUPPLIER_CODE =V_PORSUP);
  
--坯布品牌仓库存数
SELECT MAX(A.BRAND_STOCK),MAX(A.SUPPLIER_STOCK) INTO V_BRAND_STOCK,V_SUPP_STOCK
  FROM  MRP.SUPPLIER_GREY_STOCK A
 WHERE A.PRO_SUPPLIER_CODE=V_PORSUP
   AND A.UNIT=V_UNIT
   AND A.MATERIAL_SPU= V_SPU             
   AND A.MATER_SUPPLIER_CODE=V_MATSUP;
 --校验【品牌仓库存数】>0
 
 IF V_BRAND_STOCK > 0 AND V_BRAND_STOCK IS NOT NULL THEN 
   --校验公式：【品牌仓坯布库存】 - （a中生成【色布出入库单表-数量】/(1-【染损率】) ≥ 0 
   V_NUM1 :=V_BRAND_STOCK -(V_CRKNUM/(1-V_RANSUNL/100));
   
   IF V_NUM1 >=0 THEN 
     --当≥0时， 落表至【供应商库存-坯布出入库单表】
       --【数量:c.2.1校验公式中的【色布出入库单表-数量】/(1-【染损率】】
       --c.2.1.1
     V_CRKID := MRP.PKG_PLAT_COMM.F_GET_DOCUNO(PI_TABLE_NAME  => 'MRP.SUPPLIER_GREY_IN_OUT_BOUND',
                                                   PI_COLUMN_NAME => 'BOUND_NUM',
                                                   PI_PRE         => 'CPCK' ||TO_CHAR(SYSDATE,'YYYYMMDD'),
                                                   PI_SERAIL_NUM  => 5);
     INSERT INTO MRP.SUPPLIER_GREY_IN_OUT_BOUND(BOUND_NUM,ASCRIPTION,BOUND_TYPE,PRO_SUPPLIER_CODE,MATER_SUPPLIER_CODE,MATERIAL_SPU,WHETHER_INNER_MATER,UNIT,NUM,
     STOCK_TYPE,RELATE_NUM,RELATE_NUM_TYPE,COMPANY_ID,CREATE_ID,CREATE_TIME,WHETHER_DEL)
     VALUES(V_CRKID,0,15,V_PORSUP,V_MATSUP,V_SPU,V_ISINNER,V_UNIT,ABS(V_CRKNUM/(1-V_RANSUNL/100)),1,V_BOUNDNUM,3,'b6cc680ad0f599cde0531164a8c0337f',V_USERID,SYSDATE,0);
  --坯布库存明细
    --总库存数】=【原总库存】 - 【坯布出入库单表:数量】；【品牌仓库存数】=【原品牌仓库存数】 - 【坯布出入库单表:数量】
   UPDATE MRP.SUPPLIER_GREY_STOCK A
     SET A.TOTAL_STOCK= A.TOTAL_STOCK-V_CRKNUM/(1-V_RANSUNL/100),
         A.BRAND_STOCK=A.BRAND_STOCK-V_CRKNUM/(1-V_RANSUNL/100),
         A.UPDATE_ID=V_USERID,
         A.UPDATE_TIME =SYSDATE
    WHERE A.PRO_SUPPLIER_CODE=V_PORSUP
      AND A.MATER_SUPPLIER_CODE=V_MATSUP
      AND A.MATERIAL_SPU=V_SPU
      AND A.UNIT=V_UNIT ;   
 
 
  ELSIF V_NUM1 < 0 THEN 
    --2.1.2
     --当<0时， 落表至【供应商库存-坯布出入库单表】【数量:c.2.1校验公式中的【品牌仓坯布库存】】
      V_CRKID := MRP.PKG_PLAT_COMM.F_GET_DOCUNO(PI_TABLE_NAME  => 'MRP.SUPPLIER_GREY_IN_OUT_BOUND',
                                                   PI_COLUMN_NAME => 'BOUND_NUM',
                                                   PI_PRE         => 'CPCK' ||TO_CHAR(SYSDATE,'YYYYMMDD'),
                                                   PI_SERAIL_NUM  => 5);
                                                   
     INSERT INTO MRP.SUPPLIER_GREY_IN_OUT_BOUND(BOUND_NUM,ASCRIPTION,BOUND_TYPE,PRO_SUPPLIER_CODE,MATER_SUPPLIER_CODE,MATERIAL_SPU,WHETHER_INNER_MATER,UNIT,NUM,
     STOCK_TYPE,RELATE_NUM,RELATE_NUM_TYPE,COMPANY_ID,CREATE_ID,CREATE_TIME,WHETHER_DEL)
       VALUES(V_CRKID,0,15,V_PORSUP,V_MATSUP,V_SPU,V_ISINNER,V_UNIT,ABS(V_BRAND_STOCK),1, V_BOUNDNUM,3,'b6cc680ad0f599cde0531164a8c0337f',V_USERID,SYSDATE,0);                                            
    --坯布库存明细 
     UPDATE MRP.SUPPLIER_GREY_STOCK A
     SET A.TOTAL_STOCK= A.TOTAL_STOCK-V_BRAND_STOCK,
         A.BRAND_STOCK=A.BRAND_STOCK-V_BRAND_STOCK,
         A.UPDATE_ID=V_USERID,
         A.UPDATE_TIME =SYSDATE
    WHERE A.PRO_SUPPLIER_CODE=V_PORSUP
      AND A.MATER_SUPPLIER_CODE=V_MATSUP
      AND A.MATERIAL_SPU=V_SPU
      AND A.UNIT=V_UNIT ;   
     
    
     IF V_SUPP_STOCK IS NOT NULL AND V_SUPP_STOCK >0 THEN 
       --2.1.3
       --【供应商坯布-坯布仓库存明细】中找出对应【供应商仓库存数】，并校验【供应商库存数】>0：
       --校验公式：【供应商仓坯布库存】-（a中生成【色布出入库单表-数量】/(1-【染损率】-【品牌仓坯布库存】 ) ≥ 0 ；
       V_NUM2:=V_SUPP_STOCK-(V_CRKNUM/(1-V_RANSUNL/100)-V_BRAND_STOCK);
       -- 【供应商库存-坯布出入库单表】
       
       V_CRKID2 := MRP.PKG_PLAT_COMM.F_GET_DOCUNO(PI_TABLE_NAME  => 'MRP.SUPPLIER_GREY_IN_OUT_BOUND',
                                                   PI_COLUMN_NAME => 'BOUND_NUM',
                                                   PI_PRE         => 'CPCK' ||TO_CHAR(SYSDATE,'YYYYMMDD'),
                                                   PI_SERAIL_NUM  => 5);
       INSERT INTO MRP.SUPPLIER_GREY_IN_OUT_BOUND(BOUND_NUM,ASCRIPTION,BOUND_TYPE,PRO_SUPPLIER_CODE,MATER_SUPPLIER_CODE,MATERIAL_SPU,
       WHETHER_INNER_MATER,UNIT,NUM,
     STOCK_TYPE,RELATE_NUM,RELATE_NUM_TYPE,COMPANY_ID,CREATE_ID,CREATE_TIME,WHETHER_DEL)
       VALUES
       (V_CRKID2,0,15,V_PORSUP,V_MATSUP,V_SPU,V_ISINNER,V_UNIT,ABS((CASE WHEN V_NUM2 >=0 THEN V_CRKNUM/(1-V_RANSUNL/100)-V_BRAND_STOCK ELSE V_SUPP_STOCK END)) ,2, V_BOUNDNUM,3,'b6cc680ad0f599cde0531164a8c0337f',V_USERID,SYSDATE,0);                                         
     
     --坯布库存明细   
       UPDATE MRP.SUPPLIER_GREY_STOCK A
         SET A.TOTAL_STOCK=NVL(A.TOTAL_STOCK,0)-(CASE WHEN V_NUM2 >=0 THEN V_CRKNUM/(1-V_RANSUNL/100)-V_BRAND_STOCK ELSE V_SUPP_STOCK END),
             A.SUPPLIER_STOCK = NVL(A.SUPPLIER_STOCK,0) -(CASE WHEN V_NUM2 >=0 THEN V_CRKNUM/(1-V_RANSUNL/100)-V_BRAND_STOCK ELSE V_SUPP_STOCK END),
             A.UPDATE_ID=V_USERID,
             A.UPDATE_TIME=SYSDATE
        WHERE A.PRO_SUPPLIER_CODE = V_PORSUP
          AND A.MATER_SUPPLIER_CODE=V_MATSUP
          AND A.MATERIAL_SPU=V_SPU
          AND A.UNIT=V_UNIT;
          
                                                   
     END IF;
     
   END IF;
 
 ELSE
    IF V_SUPP_STOCK IS NOT NULL AND V_SUPP_STOCK >0 THEN 
     V_NUM2:=V_SUPP_STOCK-V_CRKNUM/(1-V_RANSUNL/100);
       -- 【供应商库存-坯布出入库单表】
       
       V_CRKID2 := MRP.PKG_PLAT_COMM.F_GET_DOCUNO(PI_TABLE_NAME  => 'MRP.SUPPLIER_GREY_IN_OUT_BOUND',
                                                   PI_COLUMN_NAME => 'BOUND_NUM',
                                                   PI_PRE         => 'CPCK' ||TO_CHAR(SYSDATE,'YYYYMMDD'),
                                                   PI_SERAIL_NUM  => 5);
                                                   
       INSERT INTO MRP.SUPPLIER_GREY_IN_OUT_BOUND(BOUND_NUM,ASCRIPTION,BOUND_TYPE,PRO_SUPPLIER_CODE,MATER_SUPPLIER_CODE,MATERIAL_SPU,
       WHETHER_INNER_MATER,UNIT,NUM,
     STOCK_TYPE,RELATE_NUM,RELATE_NUM_TYPE,COMPANY_ID,CREATE_ID,CREATE_TIME,WHETHER_DEL)
       VALUES
       (V_CRKID2,0,15,V_PORSUP,V_MATSUP,V_SPU,V_ISINNER,V_UNIT, ABS((CASE WHEN V_NUM2 >=0 THEN V_CRKNUM/(1-V_RANSUNL/100) ELSE V_SUPP_STOCK END)) ,2, V_BOUNDNUM,3,'b6cc680ad0f599cde0531164a8c0337f',V_USERID,SYSDATE,0);                                            
    --坯布库存明细 
      UPDATE MRP.SUPPLIER_GREY_STOCK A
         SET A.TOTAL_STOCK=A.TOTAL_STOCK-(CASE WHEN V_NUM2 >=0 THEN V_CRKNUM/(1-V_RANSUNL/100) ELSE V_SUPP_STOCK END),
             A.SUPPLIER_STOCK = A.SUPPLIER_STOCK -(CASE WHEN V_NUM2 >=0 THEN V_CRKNUM/(1-V_RANSUNL/100) ELSE V_SUPP_STOCK END),
             A.UPDATE_ID=V_USERID,
             A.UPDATE_TIME=SYSDATE
        WHERE A.PRO_SUPPLIER_CODE = V_PORSUP
          AND A.MATER_SUPPLIER_CODE=V_MATSUP
          AND A.MATERIAL_SPU=V_SPU
          AND A.UNIT=V_UNIT;
    
    
     END IF;

 END IF; 
 
 ELSIF  V_MODE = 'WL' AND V_TYPE = 'SKU' THEN
 /* SELECT T.PRO_SUPPLIER_CODE,T.MATER_SUPPLIER_CODE,T.UNIT,T.MATERIAL_SKU,T.WHETHER_INNER_MATER
    INTO V_PORSUP,V_MATSUP,V_UNIT,V_SKU,V_ISINNER
    FROM MRP.SUPPLIER_COLOR_CLOTH_STOCK T
   WHERE T.COLOR_CLOTH_STOCK_ID = V_KCID
     AND T.WHETHER_DEL=0;*/ 
     
     SELECT T.MATER_SUPPLIER_CODE,T.MATERIAL_SKU,T.UNIT,T.NUM
       INTO V_MATSUP,V_SKU,V_UNIT,V_CRKNUM
       FROM MRP.MATERIAL_COLOR_IN_OUT_BOUND T
       WHERE T.BOUND_NUM=V_BOUNDNUM 
        AND T.WHETHER_DEL=0;
     --坯布出入库单
     --找到对应的spu
     SELECT M.MATERIAL_SPU,M.DYE_LOSS_LATE INTO V_SPU,V_RANSUNL
       FROM (
SELECT Z.MATERIAL_SPU,
       X.SUPPLIER_CODE,
       NVL(X.DYE_LOSS_LATE,0) DYE_LOSS_LATE,
       Y.MATERIAL_SKU
FROM MRP.MRP_INTERNAL_MATERIAL_SKU Y
INNER JOIN MRP.MRP_INTERNAL_MATERIAL_SPU Z ON Y.MATERIAL_SPU=Z.MATERIAL_SPU
INNER JOIN MRP.MRP_INTERNAL_SUPPLIER_MATERIAL X ON X.MATERIAL_SKU=Y.MATERIAL_SKU
                )  M WHERE  M.MATERIAL_SKU=V_SKU AND M.SUPPLIER_CODE = V_MATSUP ;
  
--坯布品牌仓库存数
SELECT MAX(A.BRAND_STOCK),MAX(A.SUPPLIER_STOCK) INTO V_BRAND_STOCK,V_SUPP_STOCK
  FROM  MRP.MATERIAL_GREY_STOCK A
 WHERE A.UNIT=V_UNIT
   AND A.MATERIAL_SPU= V_SPU             
   AND A.MATER_SUPPLIER_CODE=V_MATSUP;
 --校验【品牌仓库存数】>0
 
 IF V_BRAND_STOCK > 0 AND V_BRAND_STOCK IS NOT NULL THEN 
   --校验公式：【品牌仓坯布库存】 - （a中生成【色布出入库单表-数量】/(1-【染损率】) ≥ 0 
   V_NUM1 :=V_BRAND_STOCK -(V_CRKNUM/(1-V_RANSUNL/100));
   
   IF V_NUM1 >=0 THEN 
     --当≥0时， 落表至【供应商库存-坯布出入库单表】
       --【数量:c.2.1校验公式中的【色布出入库单表-数量】/(1-【染损率】】
       --c.2.1.1
     V_CRKID := MRP.PKG_PLAT_COMM.F_GET_DOCUNO(PI_TABLE_NAME  => 'MRP.MATERIAL_GREY_IN_OUT_BOUND',
                                                   PI_COLUMN_NAME => 'BOUND_NUM',
                                                   PI_PRE         => 'WPCK' ||TO_CHAR(SYSDATE,'YYYYMMDD'),
                                                   PI_SERAIL_NUM  => 5);
     INSERT INTO MRP.MATERIAL_GREY_IN_OUT_BOUND(BOUND_NUM,ASCRIPTION,BOUND_TYPE,MATER_SUPPLIER_CODE,MATERIAL_SPU,UNIT,NUM,
     STOCK_TYPE,RELATE_NUM,RELATE_NUM_TYPE,COMPANY_ID,CREATE_ID,CREATE_TIME,WHETHER_DEL)
     VALUES(V_CRKID,0,15,V_MATSUP,V_SPU,V_UNIT,ABS(V_CRKNUM/(1-V_RANSUNL/100)),1,V_BOUNDNUM,3,'b6cc680ad0f599cde0531164a8c0337f',V_USERID,SYSDATE,0);
  --坯布库存明细
    --总库存数】=【原总库存】 - 【坯布出入库单表:数量】；【品牌仓库存数】=【原品牌仓库存数】 - 【坯布出入库单表:数量】
   UPDATE MRP.MATERIAL_GREY_STOCK A
     SET A.TOTAL_STOCK= A.TOTAL_STOCK-V_CRKNUM/(1-V_RANSUNL/100),
         A.BRAND_STOCK=A.BRAND_STOCK-V_CRKNUM/(1-V_RANSUNL/100),
         A.UPDATE_ID=V_USERID,
         A.UPDATE_TIME =SYSDATE
    WHERE A.MATER_SUPPLIER_CODE=V_MATSUP
      AND A.MATERIAL_SPU=V_SPU
      AND A.UNIT=V_UNIT ;   
 
 
  ELSIF V_NUM1 < 0 THEN 
    --2.1.2
     --当<0时， 落表至【供应商库存-坯布出入库单表】【数量:c.2.1校验公式中的【品牌仓坯布库存】】
      V_CRKID := MRP.PKG_PLAT_COMM.F_GET_DOCUNO(PI_TABLE_NAME  => 'MRP.MATERIAL_GREY_IN_OUT_BOUND',
                                                   PI_COLUMN_NAME => 'BOUND_NUM',
                                                   PI_PRE         => 'WPCK' ||TO_CHAR(SYSDATE,'YYYYMMDD'),
                                                   PI_SERAIL_NUM  => 5);
                                                   
     INSERT INTO MRP.MATERIAL_GREY_IN_OUT_BOUND(BOUND_NUM,ASCRIPTION,BOUND_TYPE,MATER_SUPPLIER_CODE,MATERIAL_SPU,UNIT,NUM,
     STOCK_TYPE,RELATE_NUM,RELATE_NUM_TYPE,COMPANY_ID,CREATE_ID,CREATE_TIME,WHETHER_DEL)
       VALUES(V_CRKID,0,15,V_MATSUP,V_SPU,V_UNIT,ABS(V_BRAND_STOCK),1, V_BOUNDNUM,3,'b6cc680ad0f599cde0531164a8c0337f',V_USERID,SYSDATE,0);                                            
    --坯布库存明细 
     UPDATE MRP.MATERIAL_GREY_STOCK A
     SET A.TOTAL_STOCK= A.TOTAL_STOCK-V_BRAND_STOCK,
         A.BRAND_STOCK=A.BRAND_STOCK-V_BRAND_STOCK,
         A.UPDATE_ID=V_USERID,
         A.UPDATE_TIME =SYSDATE
    WHERE A.MATER_SUPPLIER_CODE=V_MATSUP
      AND A.MATERIAL_SPU=V_SPU
      AND A.UNIT=V_UNIT ;   
     
    
     IF V_SUPP_STOCK IS NOT NULL AND V_SUPP_STOCK >0 THEN 
       --2.1.3
       --【供应商坯布-坯布仓库存明细】中找出对应【供应商仓库存数】，并校验【供应商库存数】>0：
       --校验公式：【供应商仓坯布库存】-（a中生成【色布出入库单表-数量】/(1-【染损率】-【品牌仓坯布库存】 ) ≥ 0 ；
       V_NUM2:=V_SUPP_STOCK-(V_CRKNUM/(1-V_RANSUNL/100)-V_BRAND_STOCK);
       -- 【供应商库存-坯布出入库单表】
       
       V_CRKID2 := MRP.PKG_PLAT_COMM.F_GET_DOCUNO(PI_TABLE_NAME  => 'MRP.MATERIAL_GREY_IN_OUT_BOUND',
                                                   PI_COLUMN_NAME => 'BOUND_NUM',
                                                   PI_PRE         => 'WPCK' ||TO_CHAR(SYSDATE,'YYYYMMDD'),
                                                   PI_SERAIL_NUM  => 5);
       INSERT INTO MRP.MATERIAL_GREY_IN_OUT_BOUND(BOUND_NUM,ASCRIPTION,BOUND_TYPE,MATER_SUPPLIER_CODE,MATERIAL_SPU,UNIT,NUM,
     STOCK_TYPE,RELATE_NUM,RELATE_NUM_TYPE,COMPANY_ID,CREATE_ID,CREATE_TIME,WHETHER_DEL)
       VALUES
       (V_CRKID2,0,15,V_MATSUP,V_SPU,V_UNIT,ABS((CASE WHEN V_NUM2 >=0 THEN V_CRKNUM/(1-V_RANSUNL/100)-V_BRAND_STOCK ELSE V_SUPP_STOCK END)) ,2, V_BOUNDNUM,3,'b6cc680ad0f599cde0531164a8c0337f',V_USERID,SYSDATE,0);                                         
     
     --坯布库存明细   
       UPDATE MRP.MATERIAL_GREY_STOCK A
         SET A.TOTAL_STOCK=A.TOTAL_STOCK-(CASE WHEN V_NUM2 >=0 THEN V_CRKNUM/(1-V_RANSUNL/100)-V_BRAND_STOCK ELSE V_SUPP_STOCK END),
             A.SUPPLIER_STOCK = A.SUPPLIER_STOCK -(CASE WHEN V_NUM2 >=0 THEN V_CRKNUM/(1-V_RANSUNL/100)-V_BRAND_STOCK ELSE V_SUPP_STOCK END),
             A.UPDATE_ID=V_USERID,
             A.UPDATE_TIME=SYSDATE
        WHERE A.MATER_SUPPLIER_CODE=V_MATSUP
          AND A.MATERIAL_SPU=V_SPU
          AND A.UNIT=V_UNIT;
          
                                                   
     END IF;
     
   END IF;
 
 ELSE
    IF V_SUPP_STOCK IS NOT NULL AND V_SUPP_STOCK >0 THEN 
     V_NUM2:=V_SUPP_STOCK-V_CRKNUM/(1-V_RANSUNL/100);
       -- 【供应商库存-坯布出入库单表】
       
       V_CRKID2 := MRP.PKG_PLAT_COMM.F_GET_DOCUNO(PI_TABLE_NAME  => 'MRP.MATERIAL_GREY_IN_OUT_BOUND',
                                                   PI_COLUMN_NAME => 'BOUND_NUM',
                                                   PI_PRE         => 'WPCK' ||TO_CHAR(SYSDATE,'YYYYMMDD'),
                                                   PI_SERAIL_NUM  => 5);
                                                   
       INSERT INTO MRP.MATERIAL_GREY_IN_OUT_BOUND(BOUND_NUM,ASCRIPTION,BOUND_TYPE,MATER_SUPPLIER_CODE,MATERIAL_SPU,UNIT,NUM,
     STOCK_TYPE,RELATE_NUM,RELATE_NUM_TYPE,COMPANY_ID,CREATE_ID,CREATE_TIME,WHETHER_DEL)
       VALUES
       (V_CRKID2,0,15,V_MATSUP,V_SPU,V_UNIT, ABS((CASE WHEN V_NUM2 >=0 THEN V_CRKNUM/(1-V_RANSUNL/100) ELSE V_SUPP_STOCK END)) ,2, V_BOUNDNUM,3,'b6cc680ad0f599cde0531164a8c0337f',V_USERID,SYSDATE,0);                                            
    --坯布库存明细 
      UPDATE MRP.MATERIAL_GREY_STOCK A
         SET A.TOTAL_STOCK=A.TOTAL_STOCK-(CASE WHEN V_NUM2 >=0 THEN V_CRKNUM/(1-V_RANSUNL/100) ELSE V_SUPP_STOCK END),
             A.SUPPLIER_STOCK = A.SUPPLIER_STOCK -(CASE WHEN V_NUM2 >=0 THEN V_CRKNUM/(1-V_RANSUNL/100) ELSE V_SUPP_STOCK END),
             A.UPDATE_ID=V_USERID,
             A.UPDATE_TIME=SYSDATE
        WHERE A.MATER_SUPPLIER_CODE=V_MATSUP
          AND A.MATERIAL_SPU=V_SPU
          AND A.UNIT=V_UNIT;
    
    
     END IF;

 END IF; 
  END IF;
END; 
                               
 
end PKG_STOCK_MANAGEMENT;
/

