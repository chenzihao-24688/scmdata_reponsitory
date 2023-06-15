create or replace package mrp.pkg_material_send_goods is

 --色布品牌仓
PROCEDURE P_SKU_BRANDSTOCK_OUT_BY_MT(PI_SENDAMOUNT     IN NUMBER,
                                     PI_SKU_BRANDSTOCK IN NUMBER,
                                     PI_USERID         IN VARCHAR2,
                                     PI_REC            IN MRP.T_FABRIC_PURCHASE_SHEET%ROWTYPE,
                                     PO_REMAINAMOUNT   OUT NUMBER);
                                     
 PROCEDURE P_SKU_SUPSTOCK_OUT_BY_MT(PI_SENDAMOUNT     IN NUMBER,
                                     PI_SKU_SUPSTOCK IN NUMBER,
                                     PI_USERID         IN VARCHAR2,
                                     PI_REC            IN MRP.T_FABRIC_PURCHASE_SHEET%ROWTYPE,
                                     PO_REMAINAMOUNT   OUT NUMBER);
                                     
  --坯布品牌仓
 PROCEDURE P_SPU_BRANDSTOCK_OUT_BY_MT(PI_SENDAMOUNT     IN NUMBER,
                                      PI_SPU_BRANDSTOCK IN NUMBER,
                                      PI_USERID         IN VARCHAR2,
                                      PI_SPU            IN VARCHAR2,
                                      PI_DYE_LOSS_LATE  IN  NUMBER,
                                      PI_REC            IN MRP.T_FABRIC_PURCHASE_SHEET%ROWTYPE,
                                      PO_REMAINAMOUNT   OUT NUMBER );
 
  --坯布供应商仓                                    
  PROCEDURE P_SPU_SUPSTOCK_OUT_BY_MT(PI_SENDAMOUNT     IN NUMBER,
                                      PI_SPU_SUPSTOCK IN NUMBER,
                                      PI_USERID         IN VARCHAR2,
                                      PI_SPU            IN VARCHAR2,
                                      PI_DYE_LOSS_LATE  IN  NUMBER,
                                      PI_REC            IN MRP.T_FABRIC_PURCHASE_SHEET%ROWTYPE,
                                      PO_REMAINAMOUNT   OUT NUMBER );          
                                      
   PROCEDURE P_STOCK_INOUT_BOUND_BY_MT(V_REC IN  MRP.T_FABRIC_PURCHASE_SHEET%ROWTYPE,
                                     PI_SENDS_AMOUNT IN NUMBER,
                                     PI_USERID IN VARCHAR2  );   
                                     
  PROCEDURE P_DELIVER_GOODS_BYACTION(PI_PINID  IN VARCHAR2,
                                   PI_COMPID IN VARCHAR2,
                                   PI_USERID IN VARCHAR2,
                                   PI_IS_END IN VARCHAR2,
                                   PI_NUM    IN VARCHAR2,
                                   PI_OP_COM IN VARCHAR2);  
                                   
   FUNCTION F_QUERY_MTSKU_PICK(PI_COMID IN VARCHAR2,
                             PI_PROSUPID IN VARCHAR2) RETURN CLOB;  
                             
    PROCEDURE P_CREATE_FABRIC_INVOICE(PI_PROSUP    IN VARCHAR2,
                                  PI_MATSUP    IN VARCHAR2,
                                  PI_USERID    IN VARCHAR2,
                                  PI_CREDATE   IN DATE,
                                  PI_COMPID    IN VARCHAR2,
                                  PO_INVOICEID OUT VARCHAR2);
                                  
     PROCEDURE P_SYNC_SUPPLIER_COLOR_STOCK(P_SCIOB_REC  MRP.SUPPLIER_COLOR_IN_OUT_BOUND%ROWTYPE,
                                      P_COMPANY_ID VARCHAR2,
                                      P_USER_ID    VARCHAR2);                                                                                                                                                                                                                                                       


   PROCEDURE P_CHECK_ISEXISTS_FABSHEET (PI_SUPID IN VARCHAR2,
                                     PI_MATESUPID IN VARCHAR2,
                                     PI_SKU IN VARCHAR2,
                                     PI_COMPID IN VARCHAR2,
                                     PI_RN IN NUMBER,
                                     PO_MESS IN OUT VARCHAR2);


    PROCEDURE P_SUBMIT_SENDGOODSHEET(P_ID     IN VARCHAR2,
                                     P_COMID  IN VARCHAR2,
                                     P_USERID IN VARCHAR2,
                                     PI_OP_COM IN VARCHAR2);
   
END pkg_material_send_goods;
/

CREATE OR REPLACE PACKAGE BODY MRP.pkg_material_send_goods IS

--色布品牌仓
PROCEDURE P_SKU_BRANDSTOCK_OUT_BY_MT(PI_SENDAMOUNT     IN NUMBER,
                                     PI_SKU_BRANDSTOCK IN NUMBER,
                                     PI_USERID         IN VARCHAR2,
                                     PI_REC            IN MRP.T_FABRIC_PURCHASE_SHEET%ROWTYPE,
                                     PO_REMAINAMOUNT   OUT NUMBER) IS

  V_REMAINS NUMBER;
  V_NUM1    NUMBER;
  V_REC     MATERIAL_COLOR_IN_OUT_BOUND%ROWTYPE;
BEGIN

  --校验公式：【品牌仓色布库存】 - （【面料发货单明细-发货数量】) ≥ 0
  V_NUM1 := PI_SKU_BRANDSTOCK - PI_SENDAMOUNT;
  --落表至【物料商库存-色布出入库单表】  【品牌仓】
  --当≥0时，数量=面料发货单明细-发货数量
  --当<0时，数量=品牌仓色布库存

  V_REC.BOUND_NUM := MRP.PKG_PLAT_COMM.F_GET_DOCUNO(PI_TABLE_NAME  => 'MRP.MATERIAL_COLOR_IN_OUT_BOUND',
                                                    PI_COLUMN_NAME => 'BOUND_NUM',
                                                    PI_PRE         => 'WKCK' ||
                                                                      TO_CHAR(SYSDATE,
                                                                              'YYYYMMDD'),
                                                    PI_SERAIL_NUM  => 5); --色布出入库单号
  V_REC.ASCRIPTION          := 0; --出入库归属，0出库1入库
  V_REC.BOUND_TYPE          := 1; --出入库类型，1订单出库，2盘亏出库，3领料出库，10品牌备料入库，11供应商现货入库，12临时补充入库，13盘盈入库，14临时坯转色入库 15 供应商色布入库 16 供应商现货出库
  V_REC.MATER_SUPPLIER_CODE := PI_REC.MATER_SUPPLIER_CODE; --物料供应商编号
  V_REC.MATERIAL_SKU        := PI_REC.MATERIAL_SKU; --物料SKU
  V_REC.UNIT                := PI_REC.UNIT; --单位
  V_REC.NUM                 := ABS((CASE WHEN V_NUM1 >= 0 THEN PI_SENDAMOUNT  ELSE PI_SKU_BRANDSTOCK END)); --数量
  V_REC.STOCK_TYPE          := 1; --仓库类型，1品牌仓，2供应商仓
  V_REC.RELATE_NUM          := PI_REC.FABRIC_ID; --关联单号
  V_REC.RELATE_NUM_TYPE     := 4; --关联单号类型，1色布生产单/2色布盘点单/3色布领料单/4面料采购单/5坯布出库单
  V_REC.RELATE_SKC          := PI_REC.GOODS_SKC; --关联SKC
  V_REC.RELATE_PURCHASE     := PI_REC.PURCHASE_ORDER_NUM; --关联采购单号
  V_REC.COMPANY_ID          := PI_REC.COMPANY_ID; --企业编码
  V_REC.CREATE_ID           := PI_USERID; --创建者
  V_REC.CREATE_TIME         := SYSDATE; --创建时间
  V_REC.UPDATE_ID           := PI_USERID; --更新者
  V_REC.UPDATE_TIME         := SYSDATE; --更新时间
  V_REC.WHETHER_DEL         := 0; --是否删除，0否1是
  V_REC.WHETHER_INNER_MATER := 1; --是否内部物料，0否1是

  MRP.PKG_MATERIAL_COLOR_IN_OUT_BOUND.P_INSERT_MATERIAL_COLOR_IN_OUT_BOUND(P_MATER_REC => V_REC);

  --更新色布仓库存明细【品牌仓】
  UPDATE MRP.MATERIAL_COLOR_CLOTH_STOCK T
     SET T.TOTAL_STOCK = T.TOTAL_STOCK - (CASE WHEN V_NUM1 >= 0 THEN PI_SENDAMOUNT ELSE PI_SKU_BRANDSTOCK END),
         T.BRAND_STOCK = T.BRAND_STOCK - (CASE WHEN V_NUM1 >= 0 THEN PI_SENDAMOUNT ELSE PI_SKU_BRANDSTOCK END),
         T.UPDATE_ID   = PI_USERID,
         T.UPDATE_TIME = SYSDATE
   WHERE T.MATER_SUPPLIER_CODE = PI_REC.MATER_SUPPLIER_CODE
     AND T.MATERIAL_SKU = PI_REC.MATERIAL_SKU
     AND T.UNIT = PI_REC.UNIT
     AND T.WHETHER_DEL = 0
     AND T.COMPANY_ID = PI_REC.COMPANY_ID;

  IF V_NUM1 > 0 THEN
    V_REMAINS := 0;

  ELSE
    V_REMAINS := PI_SENDAMOUNT - PI_SKU_BRANDSTOCK;
  END IF;
  PO_REMAINAMOUNT := V_REMAINS;
END P_SKU_BRANDSTOCK_OUT_BY_MT;

--色布供应商仓
PROCEDURE P_SKU_SUPSTOCK_OUT_BY_MT(PI_SENDAMOUNT     IN NUMBER,
                                     PI_SKU_SUPSTOCK IN NUMBER,
                                     PI_USERID         IN VARCHAR2,
                                     PI_REC            IN MRP.T_FABRIC_PURCHASE_SHEET%ROWTYPE,
                                     PO_REMAINAMOUNT   OUT NUMBER) IS

  V_REMAINS NUMBER;
  V_NUM2    NUMBER;
  V_REC     material_color_in_out_bound%ROWTYPE;
BEGIN
   --校验公式
    V_NUM2:=PI_SKU_SUPSTOCK - PI_SENDAMOUNT;
      V_REC.BOUND_NUM :=  MRP.PKG_PLAT_COMM.F_GET_DOCUNO(PI_TABLE_NAME  => 'MRP.MATERIAL_COLOR_IN_OUT_BOUND',
                                                   PI_COLUMN_NAME => 'BOUND_NUM',
                                                   PI_PRE         => 'WKCK' ||
                                                                     TO_CHAR(SYSDATE,
                                                                             'YYYYMMDD'),
                                                   PI_SERAIL_NUM  => 5);--色布出入库单号
V_REC.ASCRIPTION :=  0;--出入库归属，0出库1入库
V_REC.BOUND_TYPE :=  1;--出入库类型，1订单出库，2盘亏出库，3领料出库，10品牌备料入库，11供应商现货入库，12临时补充入库，13盘盈入库，14临时坯转色入库 15 供应商色布入库 16 供应商现货出库
V_REC.MATER_SUPPLIER_CODE :=  PI_REC.MATER_SUPPLIER_CODE;--物料供应商编号
V_REC.MATERIAL_SKU :=  PI_REC.MATERIAL_SKU;--物料SKU
V_REC.UNIT :=  PI_REC.UNIT;--单位
V_REC.NUM := ABS((CASE WHEN V_NUM2 >=0 THEN PI_SENDAMOUNT ELSE PI_SKU_SUPSTOCK END));--数量
V_REC.STOCK_TYPE :=  2;--仓库类型，1品牌仓，2供应商仓
V_REC.RELATE_NUM :=  PI_REC.FABRIC_ID;--关联单号
V_REC.RELATE_NUM_TYPE :=  4;--关联单号类型，1色布生产单/2色布盘点单/3色布领料单/4面料采购单/5坯布出库单
V_REC.RELATE_SKC :=  PI_REC.GOODS_SKC;--关联SKC
V_REC.RELATE_PURCHASE :=  PI_REC.PURCHASE_ORDER_NUM;--关联采购单号
V_REC.COMPANY_ID :=  PI_REC.COMPANY_ID;--企业编码
V_REC.CREATE_ID :=  PI_USERID;--创建者
V_REC.CREATE_TIME :=  SYSDATE;--创建时间
V_REC.UPDATE_ID :=  PI_USERID;--更新者
V_REC.UPDATE_TIME :=  SYSDATE;--更新时间
V_REC.WHETHER_DEL := 0;--是否删除，0否1是
V_REC.WHETHER_INNER_MATER :=  1;--是否内部物料，0否1是

mrp.pkg_material_color_in_out_bound.p_insert_material_color_in_out_bound(p_mater_rec =>V_REC);
          
       --更新色布仓库存明细【供应商仓】
      UPDATE MRP.MATERIAL_COLOR_CLOTH_STOCK T
         SET T.SUPPLIER_STOCK = T.SUPPLIER_STOCK-(CASE WHEN V_NUM2 >=0 THEN PI_SENDAMOUNT ELSE PI_SKU_SUPSTOCK END),
             T.TOTAL_STOCK = T.TOTAL_STOCK - (CASE WHEN V_NUM2 >=0 THEN PI_SENDAMOUNT ELSE PI_SKU_SUPSTOCK END),
             T.UPDATE_ID = PI_USERID,
             T.UPDATE_TIME = SYSDATE
       WHERE T.MATER_SUPPLIER_CODE=PI_REC.MATER_SUPPLIER_CODE
         AND T.MATERIAL_SKU = PI_REC.MATERIAL_SKU
         AND T.UNIT = PI_REC.UNIT
         AND T.WHETHER_DEL = 0
         AND T.COMPANY_ID =PI_REC.Company_Id;
  IF V_NUM2 >= 0 THEN 
    V_REMAINS:=0;
    
  ELSE 
    V_REMAINS :=PI_SENDAMOUNT-PI_SKU_SUPSTOCK;
  END IF;
  PO_REMAINAMOUNT:=V_REMAINS;
 END;        
 
 --坯布品牌仓
 PROCEDURE P_SPU_BRANDSTOCK_OUT_BY_MT(PI_SENDAMOUNT     IN NUMBER,
                                      PI_SPU_BRANDSTOCK IN NUMBER,
                                      PI_USERID         IN VARCHAR2,
                                      PI_SPU            IN VARCHAR2,
                                      PI_DYE_LOSS_LATE  IN  NUMBER,
                                      PI_REC            IN MRP.T_FABRIC_PURCHASE_SHEET%ROWTYPE,
                                      PO_REMAINAMOUNT   OUT NUMBER ) IS 
                                      
  V_NUM3 NUMBER;
  V_REMAINS     NUMBER;                              
  P_MATER_REC  MATERIAL_GREY_IN_OUT_BOUND%ROWTYPE;
 BEGIN
   --校验公式：【品牌仓坯布库存】 - （【发货剩余量】/(1-【染损率/100】) ≥ 0 
    V_NUM3:=PI_SPU_BRANDSTOCK - (PI_SENDAMOUNT/(1-PI_DYE_LOSS_LATE/100));
     /*V_NUM3:= mrp.pkg_color_prepare_order_manager.f_check_color_fabric_is_enough(p_brand_stock => V_BRAND_STOCK_SPU,
                                                                                p_plan_product_num => V_SHENGXIA2,
                                                                                --p_sup_store_num => :p_sup_store_num,
                                                                                p_dye_loss_late => v_dye_loss_late,
                                                                                p_store_type =>1);*/
       
      --生成坯布品牌仓出库单
  P_MATER_REC.BOUND_NUM :=   mrp.pkg_plat_comm.f_get_docuno(pi_table_name  => 'MATERIAL_GREY_IN_OUT_BOUND',
                                                            pi_column_name => 'BOUND_NUM',
                                                            pi_pre         => 'WPCK' || to_char(trunc(SYSDATE),'YYYYMMDD'),
                                                            pi_serail_num  => 5);--坯布出入库单号
P_MATER_REC.ASCRIPTION :=  0;--出入库归属，0出库1入库
P_MATER_REC.BOUND_TYPE :=  3;--出入库类型，1色布备料出库/ 2盘亏出库/ 3临时坯转色出库/ 4坯布备料出库/ 11品牌备料入库/ 12供应商现货入库/ 13盘盈入库/ 14临时补充入库
P_MATER_REC.MATER_SUPPLIER_CODE := PI_REC.MATER_SUPPLIER_CODE;--物料供应商编号
P_MATER_REC.MATERIAL_SPU :=  PI_SPU;--物料SPU
P_MATER_REC.UNIT := PI_REC.UNIT;--单位
P_MATER_REC.NUM := (CASE WHEN V_NUM3 >=0 THEN (PI_SENDAMOUNT/(1-PI_DYE_LOSS_LATE/100)) ELSE PI_SPU_BRANDSTOCK END  );--数量
P_MATER_REC.STOCK_TYPE :=  1;--仓库类型，1品牌仓，2供应商仓
P_MATER_REC.RELATE_NUM :=  PI_REC.FABRIC_ID;--关联单号
P_MATER_REC.RELATE_NUM_TYPE :=  5;--关联单号类型，1色布生产单/ 2坯布盘点单/ 3色布领料单/ 4坯布生产单/5面料采购单/6色布入库单
P_MATER_REC.RELATE_SKC := PI_REC.GOODS_SKC;--关联SKC
P_MATER_REC.COMPANY_ID := PI_REC.COMPANY_ID;--企业编码
P_MATER_REC.CREATE_ID :=  PI_USERID;--创建者
P_MATER_REC.CREATE_TIME :=  SYSDATE;--创建时间，入库时间
P_MATER_REC.UPDATE_ID := PI_USERID;--更新者
P_MATER_REC.UPDATE_TIME :=  SYSDATE;--更新时间
P_MATER_REC.WHETHER_DEL :=  0;--是否删除，0否1是
P_MATER_REC.RELATE_PURCHASE_ORDER_NUM := PI_REC.PURCHASE_ORDER_NUM;--关联采购单号

   MRP.PKG_MATERIAL_GREY_IN_OUT_BOUND.P_INSERT_MATERIAL_GREY_IN_OUT_BOUND(P_MATER_REC => P_MATER_REC);   
   
   --更新坯布品牌仓库存明细
   
   UPDATE MRP.MATERIAL_GREY_STOCK T 
      SET T.TOTAL_STOCK = T.TOTAL_STOCK - (CASE WHEN V_NUM3 >=0 THEN (PI_SENDAMOUNT/(1-PI_DYE_LOSS_LATE/100)) ELSE PI_SPU_BRANDSTOCK END  ),
          T.BRAND_STOCK = T.BRAND_STOCK -(CASE WHEN V_NUM3 >=0 THEN (PI_SENDAMOUNT/(1-PI_DYE_LOSS_LATE/100)) ELSE PI_SPU_BRANDSTOCK END  ),
          T.UPDATE_ID = PI_USERID,
          T.UPDATE_TIME = SYSDATE
   WHERE T.MATER_SUPPLIER_CODE = PI_REC.MATER_SUPPLIER_CODE
     AND T.MATERIAL_SPU = PI_SPU
     AND T.UNIT = PI_REC.UNIT
     AND T.COMPANY_ID = PI_REC.COMPANY_ID
     AND T.WHETHER_DEL= 0;
     
IF V_NUM3 >= 0 THEN 
    V_REMAINS:=0;
    
  ELSE 
    V_REMAINS :=(PI_SENDAMOUNT/(1-PI_DYE_LOSS_LATE/100))-PI_SPU_BRANDSTOCK;
  END IF;
  PO_REMAINAMOUNT:=V_REMAINS;
 END;             


 --坯布供应商仓
  PROCEDURE P_SPU_SUPSTOCK_OUT_BY_MT(PI_SENDAMOUNT     IN NUMBER,
                                      PI_SPU_SUPSTOCK IN NUMBER,
                                      PI_USERID         IN VARCHAR2,
                                      PI_SPU            IN VARCHAR2,
                                      PI_DYE_LOSS_LATE  IN  NUMBER,
                                      PI_REC            IN MRP.T_FABRIC_PURCHASE_SHEET%ROWTYPE,
                                      PO_REMAINAMOUNT   OUT NUMBER ) IS
    
    V_NUM4   NUMBER;
    V_REMAINS NUMBER;
    P_MATER_REC      MATERIAL_GREY_IN_OUT_BOUND%ROWTYPE;                          
   BEGIN
     
   --落表【物料商库存-色布出入库单表】 【供应商仓】
      --校验公式：【供应商仓坯布库存】-（【发货剩余量】/(1-【染损率/100】) ≥ 0 
      V_NUM4:=PI_SPU_SUPSTOCK - (PI_SENDAMOUNT/(1-PI_DYE_LOSS_LATE/100));
           --生成坯布供应商仓出库单
           P_MATER_REC.BOUND_NUM :=   mrp.pkg_plat_comm.f_get_docuno(pi_table_name  => 'MATERIAL_GREY_IN_OUT_BOUND',
                                                            pi_column_name => 'BOUND_NUM',
                                                            pi_pre         => 'WPCK' || to_char(trunc(SYSDATE),'YYYYMMDD'),
                                                            pi_serail_num  => 5);--坯布出入库单号
P_MATER_REC.ASCRIPTION :=  0;--出入库归属，0出库1入库
P_MATER_REC.BOUND_TYPE :=  3;--出入库类型，1色布备料出库/ 2盘亏出库/ 3临时坯转色出库/ 4坯布备料出库/ 11品牌备料入库/ 12供应商现货入库/ 13盘盈入库/ 14临时补充入库
P_MATER_REC.MATER_SUPPLIER_CODE := PI_REC.MATER_SUPPLIER_CODE;--物料供应商编号
P_MATER_REC.MATERIAL_SPU := PI_SPU;--物料SPU
P_MATER_REC.UNIT := PI_REC.UNIT;--单位
P_MATER_REC.NUM := (CASE WHEN V_NUM4 >=0 THEN (PI_SENDAMOUNT/(1-PI_DYE_LOSS_LATE/100)) ELSE PI_SPU_SUPSTOCK END) ;--数量
P_MATER_REC.STOCK_TYPE :=  2;--仓库类型，1品牌仓，2供应商仓
P_MATER_REC.RELATE_NUM := PI_REC.FABRIC_PURCHASE_SHEET_ID;--关联单号
P_MATER_REC.RELATE_NUM_TYPE :=  5;--关联单号类型，1色布生产单/ 2坯布盘点单/ 3色布领料单/ 4坯布生产单/5面料采购单/6色布入库单
P_MATER_REC.RELATE_SKC := PI_REC.GOODS_SKC;--关联SKC
P_MATER_REC.COMPANY_ID := PI_REC.COMPANY_ID;--企业编码
P_MATER_REC.CREATE_ID :=  PI_USERID;--创建者
P_MATER_REC.CREATE_TIME :=  SYSDATE;--创建时间，入库时间
P_MATER_REC.UPDATE_ID := PI_USERID;--更新者
P_MATER_REC.UPDATE_TIME :=  SYSDATE;--更新时间
P_MATER_REC.WHETHER_DEL :=  0;--是否删除，0否1是
P_MATER_REC.RELATE_PURCHASE_ORDER_NUM := PI_REC.PURCHASE_ORDER_NUM;--关联采购单号

   MRP.PKG_MATERIAL_GREY_IN_OUT_BOUND.P_INSERT_MATERIAL_GREY_IN_OUT_BOUND(P_MATER_REC => P_MATER_REC);   
          
          --更新坯布供应商仓库存
          UPDATE MRP.MATERIAL_GREY_STOCK T 
             SET T.TOTAL_STOCK = T.TOTAL_STOCK - (CASE WHEN V_NUM4 >=0 THEN (PI_SENDAMOUNT/(1-PI_DYE_LOSS_LATE/100)) ELSE PI_SPU_SUPSTOCK END),
                 T.SUPPLIER_STOCK = T.SUPPLIER_STOCK - (CASE WHEN V_NUM4 >=0 THEN (PI_SENDAMOUNT/(1-PI_DYE_LOSS_LATE/100)) ELSE PI_SPU_SUPSTOCK END),
                 T.UPDATE_ID = PI_USERID,
                 T.UPDATE_TIME = SYSDATE
           WHERE T.MATER_SUPPLIER_CODE = PI_REC.MATER_SUPPLIER_CODE
             AND T.MATERIAL_SPU = PI_SPU
             AND T.UNIT = PI_REC.UNIT
             AND T.COMPANY_ID =  PI_REC.COMPANY_ID
             AND T.WHETHER_DEL= 0;                                    
             
   IF V_NUM4 >= 0 THEN 
    V_REMAINS:=0;
    
  ELSE 
    V_REMAINS :=(PI_SENDAMOUNT/(1-PI_DYE_LOSS_LATE/100))-PI_SPU_SUPSTOCK;
  END IF;
  PO_REMAINAMOUNT:=V_REMAINS;
 END; 
 
 
 PROCEDURE P_STOCK_INOUT_BOUND_BY_MT(V_REC IN  MRP.T_FABRIC_PURCHASE_SHEET%ROWTYPE,
                                     PI_SENDS_AMOUNT IN NUMBER,
                                     PI_USERID IN VARCHAR2  ) IS





  V_REMIANS_AMOUNT  NUMBER;
  V_BRAND_STOCK_SKU NUMBER;
  V_SUP_STOCK_SKU   NUMBER;
  V_BRAND_STOCK_SPU NUMBER;
  V_SUP_STOCK_SPU   NUMBER;
  V_MATERIAL_SPU    VARCHAR2(32);
  V_DYE_LOSS_LATE   NUMBER;


BEGIN
--找出品牌仓库存数 校验【品牌仓库存数】＞0
      V_BRAND_STOCK_SKU := MRP.PKG_COLOR_PREPARE_ORDER_MANAGER.F_GET_STOCK_NUM(P_COMPANY_ID => V_REC.COMPANY_ID,
                                                                               P_SUP_MODE   => 1,
                                                                               P_TYPE       => 'SKU',
                                                                               -- p_pro_supplier_code => :p_pro_supplier_code,
                                                                               P_MATER_SUPPLIER_CODE => V_REC.MATER_SUPPLIER_CODE,
                                                                               P_UNIT                => V_REC.UNIT,
                                                                               P_MATERIAL_ID         => V_REC.MATERIAL_SKU,
                                                                               P_STORE_TYPE          => 1);
      IF V_BRAND_STOCK_SKU > 0 THEN
        --扣减色布品牌仓
        MRP.PKG_MATERIAL_SEND_GOODS.P_SKU_BRANDSTOCK_OUT_BY_MT(PI_SENDAMOUNT     => PI_SENDS_AMOUNT,
                                                               PI_SKU_BRANDSTOCK => V_BRAND_STOCK_SKU,
                                                               PI_USERID         => PI_USERID,
                                                               PI_REC            => V_REC,
                                                               PO_REMAINAMOUNT   => V_REMIANS_AMOUNT);
      
      ELSE
        V_REMIANS_AMOUNT := PI_SENDS_AMOUNT;
      
      END IF;
      IF V_REMIANS_AMOUNT > 0 THEN
        --扣减色布供应商仓
        --找出供应商仓库存数 校验【供应商仓库存数】＞0
        V_SUP_STOCK_SKU := MRP.PKG_COLOR_PREPARE_ORDER_MANAGER.F_GET_STOCK_NUM(P_COMPANY_ID => V_REC.COMPANY_ID,
                                                                               P_SUP_MODE   => 1,
                                                                               P_TYPE       => 'SKU',
                                                                               -- p_pro_supplier_code => :p_pro_supplier_code,
                                                                               P_MATER_SUPPLIER_CODE => V_REC.MATER_SUPPLIER_CODE,
                                                                               P_UNIT                => V_REC.UNIT,
                                                                               P_MATERIAL_ID         => V_REC.MATERIAL_SKU,
                                                                               P_STORE_TYPE          => 2);
      
        IF V_SUP_STOCK_SKU > 0 THEN
          --扣减色布供应商仓
          MRP.PKG_MATERIAL_SEND_GOODS.P_SKU_SUPSTOCK_OUT_BY_MT(PI_SENDAMOUNT   => V_REMIANS_AMOUNT,
                                                               PI_SKU_SUPSTOCK => V_SUP_STOCK_SKU,
                                                               PI_USERID       => PI_USERID,
                                                               PI_REC          => V_REC,
                                                               PO_REMAINAMOUNT => V_REMIANS_AMOUNT);
        
        ELSE
          V_REMIANS_AMOUNT := V_REMIANS_AMOUNT;
        END IF;
      END IF;
        --1.1 获取物料spu
        V_MATERIAL_SPU := MRP.PKG_COLOR_PREPARE_ORDER_MANAGER.F_GET_MT_MATERIAL_SPU(P_MATERIAL_SKU => V_REC.MATERIAL_SKU);
      
        --1.3获取染损率
        V_DYE_LOSS_LATE := MRP.PKG_COLOR_PREPARE_ORDER_MANAGER.F_GET_MT_DYE_LOSS_LATE(P_MATER_SUPPLIER_CODE => V_REC.MATER_SUPPLIER_CODE,
                                                                                      P_MATERIAL_SKU        => V_REC.MATERIAL_SKU);
      
        IF V_REMIANS_AMOUNT > 0 THEN
          --扣减坯布品牌仓
          --获取spu品牌仓
          V_BRAND_STOCK_SPU := MRP.PKG_COLOR_PREPARE_ORDER_MANAGER.F_GET_STOCK_NUM(P_COMPANY_ID => V_REC.COMPANY_ID,
                                                                                   P_SUP_MODE   => 1,
                                                                                   P_TYPE       => 'SPU',
                                                                                   -- p_pro_supplier_code => :p_pro_supplier_code,
                                                                                   P_MATER_SUPPLIER_CODE => V_REC.MATER_SUPPLIER_CODE,
                                                                                   P_UNIT                => V_REC.UNIT,
                                                                                   P_MATERIAL_ID         => V_MATERIAL_SPU,
                                                                                   P_STORE_TYPE          => 1);
          IF V_BRAND_STOCK_SPU > 0 THEN
            --扣减坯布品牌仓
            MRP.PKG_MATERIAL_SEND_GOODS.P_SPU_BRANDSTOCK_OUT_BY_MT(PI_SENDAMOUNT     => V_REMIANS_AMOUNT,
                                                                   PI_SPU_BRANDSTOCK => V_BRAND_STOCK_SPU,
                                                                   PI_USERID         => PI_USERID,
                                                                   PI_SPU            => V_MATERIAL_SPU,
                                                                   PI_DYE_LOSS_LATE  => V_DYE_LOSS_LATE,
                                                                   PI_REC            => V_REC,
                                                                   PO_REMAINAMOUNT   => V_REMIANS_AMOUNT);
          
          ELSE
            V_REMIANS_AMOUNT := V_REMIANS_AMOUNT;
          END IF;
        ELSE
          NULL;
        END IF;
      
        IF V_REMIANS_AMOUNT > 0 THEN
          --获取坯布供应商仓
          V_SUP_STOCK_SPU := MRP.PKG_COLOR_PREPARE_ORDER_MANAGER.F_GET_STOCK_NUM(P_COMPANY_ID => V_REC.COMPANY_ID,
                                                                                 P_SUP_MODE   => 1,
                                                                                 P_TYPE       => 'SPU',
                                                                                 -- p_pro_supplier_code => :p_pro_supplier_code,
                                                                                 P_MATER_SUPPLIER_CODE => V_REC.MATER_SUPPLIER_CODE,
                                                                                 P_UNIT                => V_REC.UNIT,
                                                                                 P_MATERIAL_ID         => V_MATERIAL_SPU,
                                                                                 P_STORE_TYPE          => 2);
        
          IF V_SUP_STOCK_SPU > 0 THEN
            MRP.PKG_MATERIAL_SEND_GOODS.P_SPU_SUPSTOCK_OUT_BY_MT(PI_SENDAMOUNT    => V_REMIANS_AMOUNT,
                                                                 PI_SPU_SUPSTOCK  => V_SUP_STOCK_SPU,
                                                                 PI_USERID        => PI_USERID,
                                                                 PI_SPU           => V_MATERIAL_SPU,
                                                                 PI_DYE_LOSS_LATE => V_DYE_LOSS_LATE,
                                                                 PI_REC           => V_REC,
                                                                 PO_REMAINAMOUNT  => V_REMIANS_AMOUNT);
          
          END IF;
        
        ELSE
          NULL;
        END IF;
   END   P_STOCK_INOUT_BOUND_BY_MT; 
 
 
 --发货按钮
PROCEDURE P_DELIVER_GOODS_BYACTION(PI_PINID  IN VARCHAR2,
                                   PI_COMPID IN VARCHAR2,
                                   PI_USERID IN VARCHAR2,
                                   PI_IS_END IN VARCHAR2,
                                   PI_NUM    IN VARCHAR2,
                                   PI_OP_COM IN VARCHAR2) IS

  V_TOTAL_WF        NUMBER;
  V_WEIFA_AMOUNT   NUMBER;
  P_T_FAB_REC       MRP.T_FABRIC_INVOICE_DETAIL%ROWTYPE;
  V_SENDS_AMOUNT    NUMBER;
  V_MIANL_ID        VARCHAR2(32);
  V_MIANL_ID2       VARCHAR2(32);
  --V_REMIANS_AMOUNT  NUMBER;
  V_REC             MRP.T_FABRIC_PURCHASE_SHEET%ROWTYPE;
  P_T_FAB_REC2      MRP.T_FABRIC_INVOICE%ROWTYPE;
  --V_BRAND_STOCK_SKU NUMBER;
  --V_SUP_STOCK_SKU   NUMBER;
  --V_BRAND_STOCK_SPU NUMBER;
  --V_SUP_STOCK_SPU   NUMBER;
  --V_MATERIAL_SPU    VARCHAR2(32);
  --V_DYE_LOSS_LATE   NUMBER;
  V_PRO_SUPPLIER_CODE       VARCHAR2(32);
  V_MATER_SUPPLIER_CODE    VARCHAR2(32);
  V_LIANXIREN       VARCHAR2(32);
  V_LIANXIDIANH     VARCHAR2(512);
  V_DIZHI           VARCHAR2(512);
  V_DOCNUM          NUMBER;
  V_NUM2            NUMBER;
  --VO_LOG_ID         VARCHAR2(32);
BEGIN
   


 ---发货后库存扣减顺序依次为：品牌仓色布→供应商仓色布→品牌仓坯布→供应商仓胚布

 --面料采购单
    --所有采购单的未发货量
    SELECT SUM(Z.NOT_DELIVER_AMOUNT),SUM(Z.NOT_DELIVER_AMOUNT)
      INTO V_TOTAL_WF,V_WEIFA_AMOUNT
      FROM MRP.T_FABRIC_PURCHASE_SHEET Z
     WHERE Z.GROUP_KEY = PI_PINID
       AND Z.FABRIC_STATUS = 'S02'
       AND Z.COMPANY_ID = PI_COMPID;

  IF PI_NUM >= V_WEIFA_AMOUNT AND PI_IS_END = 0 THEN 
     RAISE_APPLICATION_ERROR(-20002,'本次发货量≥未发货量时，应当完成本次发货!');
  END IF;
  
     
 

  SELECT MAX(T.PRO_SUPPLIER_CODE),MAX(T.MATER_SUPPLIER_CODE)
    INTO V_PRO_SUPPLIER_CODE,V_MATER_SUPPLIER_CODE
    FROM MRP.T_FABRIC_PURCHASE_SHEET T
  WHERE T.GROUP_KEY = PI_PINID
    AND T.FABRIC_STATUS = 'S02'
    AND T.COMPANY_ID = PI_COMPID;
 
  
  
  --收货联系人、收货联系电话、收货地址、
  SELECT MAX(T.FA_CONTACT_NAME), MAX(T.FA_CONTACT_PHONE), MAX(T.COMPANY_ADDRESS)
    INTO V_LIANXIREN, V_LIANXIDIANH, V_DIZHI
    FROM SCMDATA.T_SUPPLIER_INFO T
   WHERE T.SUPPLIER_INFO_ID = V_PRO_SUPPLIER_CODE
     AND T.COMPANY_ID = PI_COMPID;

  --生成面料发货单
    --生成面料发货单ID
  V_MIANL_ID := MRP.PKG_PLAT_COMM.F_GET_DOCUNO(PI_TABLE_NAME  => 'MRP.T_FABRIC_INVOICE',
                                                                         PI_COLUMN_NAME => 'FABRIC_INVOICE_NUMBER',
                                                                         PI_PRE         => 'WCG' ||
                                                                                           TO_CHAR(SYSDATE,
                                                                                                   'YYYYMMDD'),
                                                                         PI_SERAIL_NUM  => 5);
  V_MIANL_ID2 :=  MRP.PKG_PLAT_COMM.F_GET_UUID();

  P_T_FAB_REC2.FABRIC_INVOICE_ID        := V_MIANL_ID2; --主键
  P_T_FAB_REC2.COMPANY_ID               := PI_COMPID; --企业ID
  P_T_FAB_REC2.FABRIC_INVOICE_NUMBER    := V_MIANL_ID; --面料发货单号
  P_T_FAB_REC2.FABRIC_STATUS            := 'S03'; --采购状态(已发货:S03/已收货:S04)
  P_T_FAB_REC2.MATER_SUPPLIER_CODE      := V_MATER_SUPPLIER_CODE; --物料供应商编号
  P_T_FAB_REC2.PRO_SUPPLIER_CODE        := V_PRO_SUPPLIER_CODE; --成品供应商编号
  P_T_FAB_REC2.RECEIVE_GOODS_CONTACT_ID := V_LIANXIREN; --收货联系人 
  P_T_FAB_REC2.RECEIVE_GOODS_TELEPHONE  := V_LIANXIDIANH; --收货联系电话 
  P_T_FAB_REC2.RECEIVE_GOODS_ADDRESS    := V_DIZHI; --收货地址 
  P_T_FAB_REC2.PURCHASE_ORDER_NUMBER    := NULL; --含面料采购单单数 
  P_T_FAB_REC2.RECEIVE_GOODS_ID         := NULL; --收货人 
  P_T_FAB_REC2.RECEIVE_TIME             := NULL; --收货时间 
  P_T_FAB_REC2.REMARKS                  := NULL; --备注
  P_T_FAB_REC2.CREATE_ID                := PI_USERID; --创建ID
  P_T_FAB_REC2.CREATE_TIME              := SYSDATE; --创建时间
  P_T_FAB_REC2.UPDATE_ID                := PI_USERID; --更新ID
  P_T_FAB_REC2.UPDATE_TIME              := SYSDATE; --更新时间    

  MRP.PKG_T_FABRIC_INVOICE.P_INSERT_T_FABRIC_INVOICE(P_T_FAB_REC => P_T_FAB_REC2);

 


  IF PI_IS_END = 1 THEN
    --当【是否完成全部发货】=是时
  
    -- 一条【面料采购单信息】生成一条【面料发货单明细】信息 mrp.t_fabric_invoice_detail
    FOR I IN (SELECT t.fabric_purchase_sheet_id,t.company_id,t.fabric_id,t.pro_supplier_code,t.mater_supplier_code,t.material_sku,
      t.whether_inner_mater,t.unit,t.suggest_pick_amount,t.actual_pick_amount,t.already_deliver_amount,t.not_deliver_amount,
      t.practical_door_with,t.gram_weight,t.material_specifications,(PI_NUM * t.NOT_DELIVER_AMOUNT) / sum(t.NOT_DELIVER_AMOUNT) over(partition by 1) TOTAL_NOT_DELIVER_AMOUNT
                FROM MRP.T_FABRIC_PURCHASE_SHEET T
               WHERE T.GROUP_KEY = PI_PINID
                 AND T.FABRIC_STATUS = 'S02'
                 AND T.COMPANY_ID = PI_COMPID) LOOP
    
      --【发货数量】：【发货弹窗编辑区】-本次发货量*对应【面料采购单】的【未发货量】/找到的所有面料采购单的【未发货量】，四舍五入保留2位小数；
      --【收货数量】：默认为0；  
    
      V_SENDS_AMOUNT := ROUND(i.TOTAL_NOT_DELIVER_AMOUNT,2);
    
      --V_REMIANS_AMOUNT := V_SENDS_AMOUNT;
    
      P_T_FAB_REC.FABRIC_INVOICE_DETAIL_ID := MRP.PKG_PLAT_COMM.F_GET_UUID(); --主键
      P_T_FAB_REC.COMPANY_ID               := I.COMPANY_ID; --企业ID
      P_T_FAB_REC.FABRIC_INVOICE_NUMBER    := V_MIANL_ID; --面料发货单号
      P_T_FAB_REC.FABRIC_ID                := I.FABRIC_ID; --面料采购单号
      P_T_FAB_REC.MATER_SUPPLIER_CODE      := I.MATER_SUPPLIER_CODE; --物料供应商编号
      P_T_FAB_REC.PRO_SUPPLIER_CODE        := I.PRO_SUPPLIER_CODE; --成品供应商编号
      P_T_FAB_REC.MATERIAL_SKU             := I.MATERIAL_SKU; --物料SKU
      P_T_FAB_REC.WHETHER_INNER_MATER      := I.WHETHER_INNER_MATER; --是否内部面料
      P_T_FAB_REC.UNIT                     := I.UNIT; --单位
      P_T_FAB_REC.SEND_GOODS_AMOUNT        := V_SENDS_AMOUNT; --发货数量
      P_T_FAB_REC.RECEIVE_GOODS_AMOUNT     := 0; --收货数量
      P_T_FAB_REC.REMARKS                  := NULL; --备注
      P_T_FAB_REC.CREATE_ID                := PI_USERID; --创建ID
      P_T_FAB_REC.CREATE_TIME              := SYSDATE; --创建时间
      P_T_FAB_REC.UPDATE_ID                := PI_USERID; --更新ID
      P_T_FAB_REC.UPDATE_TIME              := SYSDATE; --更新时间
    
      MRP.PKG_T_FABRIC_INVOICE_DETAIL.P_INSERT_T_FABRIC_INVOICE_DETAIL(P_T_FAB_REC => P_T_FAB_REC);
    
      --修改【面料采购单】信息 mrp.t_fabric_purchase_sheet 
      scmdata.pkg_plat_log.p_document_change_trace(p_company_id              => I.COMPANY_ID,
                                               p_document_id             => I.FABRIC_ID,
                                               p_data_source_parent_code => 'FABRIC_SHEET_LOG',
                                               p_data_source_child_code  => '05',
                                               p_operate_company_id      => PI_OP_COM,
                                               p_user_id                 => PI_USERID); 
      
      --【采购状态】：修改为“已发货”；【已发货量】：【原已货量】+本次生成【面料发货单明细-发货数量】；【未发货量】：=0；【发货人】：当前登录用户ID 【发货时间】
      UPDATE MRP.T_FABRIC_PURCHASE_SHEET T 
         SET T.FABRIC_STATUS          = 'S03',
             T.ALREADY_DELIVER_AMOUNT = NVL(I.ALREADY_DELIVER_AMOUNT, 0) +
                                        V_SENDS_AMOUNT,
             T.NOT_DELIVER_AMOUNT     = 0,
             T.SEND_ORDER_ID          = PI_USERID,
             T.SEND_ORDER_TIME        = SYSDATE
       WHERE T.FABRIC_PURCHASE_SHEET_ID = I.FABRIC_PURCHASE_SHEET_ID;
    
      --记录操作日志
       /* SCMDATA.PKG_PLAT_LOG.P_RECORD_PLAT_LOG(P_COMPANY_ID         => I.COMPANY_ID,
                                               P_APPLY_MODULE       => 'a_prematerial_412',
                                               P_BASE_TABLE         => 'T_FABRIC_PURCHASE_SHEET',
                                               P_APPLY_PK_ID        => I.FABRIC_ID,
                                               P_ACTION_TYPE        => 'UPDATE',
                                               P_LOG_ID             => vo_log_id,
                                               P_LOG_TYPE           => '05',
                                               P_LOG_MSG            => '操作【发货】，本次发货量=' ||
                                                                       V_SENDS_AMOUNT ||
                                                                       '，发货状态=已完成',
                                               P_OPERATE_FIELD      => 'ALREADY_DELIVER_AMOUNT',
                                               P_FIELD_TYPE         => 'VARCHAR2',
                                               P_OLD_CODE           => 0,
                                               P_NEW_CODE           => 1,
                                               P_OLD_VALUE          => '待发货',
                                               P_NEW_VALUE          => '已发货',
                                               P_USER_ID            => PI_USERID,
                                               P_OPERATE_COMPANY_ID => PI_OP_COM,
                                               P_SEQ_NO             => 1,
                                               PO_LOG_ID            => vo_log_id);*/
      
        /*scmdata.pkg_plat_log.p_insert_plat_log_to_plm_or_mrp(p_log_id      => vo_log_id,
                                                             p_log_msg     => '操作【发货】，本次发货量=' ||
                                                                              v_num ||
                                                                              '，领料状态=已完成',
                                                             p_class_name  => '领料任务',
                                                             p_method_name => '领料出库',
                                                             p_type        => 2);*/
    
    
      SELECT *
        INTO V_REC
        FROM MRP.T_FABRIC_PURCHASE_SHEET T
       WHERE T.FABRIC_PURCHASE_SHEET_ID = I.FABRIC_PURCHASE_SHEET_ID;
       
       --色布、坯布出库
       mrp.pkg_material_send_goods.P_STOCK_INOUT_BOUND_BY_MT(V_REC => V_REC,
                                                        PI_SENDS_AMOUNT => V_SENDS_AMOUNT,
                                                        PI_USERID => PI_USERID);
    
     /* --找出品牌仓库存数 校验【品牌仓库存数】＞0
      V_BRAND_STOCK_SKU := MRP.PKG_COLOR_PREPARE_ORDER_MANAGER.F_GET_STOCK_NUM(P_COMPANY_ID => I.COMPANY_ID,
                                                                               P_SUP_MODE   => 1,
                                                                               P_TYPE       => 'SKU',
                                                                               -- p_pro_supplier_code => :p_pro_supplier_code,
                                                                               P_MATER_SUPPLIER_CODE => I.MATER_SUPPLIER_CODE,
                                                                               P_UNIT                => I.UNIT,
                                                                               P_MATERIAL_ID         => I.MATERIAL_SKU,
                                                                               P_STORE_TYPE          => 1);
      IF V_BRAND_STOCK_SKU > 0 THEN
        --扣减色布品牌仓
        MRP.PKG_MATERIAL_SEND_GOODS.P_SKU_BRANDSTOCK_OUT_BY_MT(PI_SENDAMOUNT     => V_SENDS_AMOUNT,
                                                               PI_SKU_BRANDSTOCK => V_BRAND_STOCK_SKU,
                                                               PI_USERID         => PI_USERID,
                                                               PI_REC            => V_REC,
                                                               PO_REMAINAMOUNT   => V_REMIANS_AMOUNT);
      
      ELSE
        V_REMIANS_AMOUNT := V_SENDS_AMOUNT;
      
      END IF;
      IF V_REMIANS_AMOUNT > 0 THEN
        --扣减色布供应商仓
        --找出供应商仓库存数 校验【供应商仓库存数】＞0
        V_SUP_STOCK_SKU := MRP.PKG_COLOR_PREPARE_ORDER_MANAGER.F_GET_STOCK_NUM(P_COMPANY_ID => I.COMPANY_ID,
                                                                               P_SUP_MODE   => 1,
                                                                               P_TYPE       => 'SKU',
                                                                               -- p_pro_supplier_code => :p_pro_supplier_code,
                                                                               P_MATER_SUPPLIER_CODE => I.MATER_SUPPLIER_CODE,
                                                                               P_UNIT                => I.UNIT,
                                                                               P_MATERIAL_ID         => I.MATERIAL_SKU,
                                                                               P_STORE_TYPE          => 2);
      
        IF V_SUP_STOCK_SKU > 0 THEN
          --扣减色布供应商仓
          MRP.PKG_MATERIAL_SEND_GOODS.P_SKU_SUPSTOCK_OUT_BY_MT(PI_SENDAMOUNT   => V_REMIANS_AMOUNT,
                                                               PI_SKU_SUPSTOCK => V_SUP_STOCK_SKU,
                                                               PI_USERID       => PI_USERID,
                                                               PI_REC          => V_REC,
                                                               PO_REMAINAMOUNT => V_REMIANS_AMOUNT);
        
        ELSE
          V_REMIANS_AMOUNT := V_REMIANS_AMOUNT;
        END IF;
      END IF;
        --1.1 获取物料spu
        V_MATERIAL_SPU := MRP.PKG_COLOR_PREPARE_ORDER_MANAGER.F_GET_MT_MATERIAL_SPU(P_MATERIAL_SKU => I.MATERIAL_SKU);
      
        --1.3获取染损率
        V_DYE_LOSS_LATE := MRP.PKG_COLOR_PREPARE_ORDER_MANAGER.F_GET_MT_DYE_LOSS_LATE(P_MATER_SUPPLIER_CODE => I.MATER_SUPPLIER_CODE,
                                                                                      P_MATERIAL_SKU        => I.MATERIAL_SKU);
      
        IF V_REMIANS_AMOUNT > 0 THEN
          --扣减坯布品牌仓
          --获取spu品牌仓
          V_BRAND_STOCK_SPU := MRP.PKG_COLOR_PREPARE_ORDER_MANAGER.F_GET_STOCK_NUM(P_COMPANY_ID => I.COMPANY_ID,
                                                                                   P_SUP_MODE   => 1,
                                                                                   P_TYPE       => 'SPU',
                                                                                   -- p_pro_supplier_code => :p_pro_supplier_code,
                                                                                   P_MATER_SUPPLIER_CODE => I.MATER_SUPPLIER_CODE,
                                                                                   P_UNIT                => I.UNIT,
                                                                                   P_MATERIAL_ID         => V_MATERIAL_SPU,
                                                                                   P_STORE_TYPE          => 1);
          IF V_BRAND_STOCK_SPU > 0 THEN
            --扣减坯布品牌仓
            MRP.PKG_MATERIAL_SEND_GOODS.P_SPU_BRANDSTOCK_OUT_BY_MT(PI_SENDAMOUNT     => V_REMIANS_AMOUNT,
                                                                   PI_SPU_BRANDSTOCK => V_BRAND_STOCK_SPU,
                                                                   PI_USERID         => PI_USERID,
                                                                   PI_SPU            => V_MATERIAL_SPU,
                                                                   PI_DYE_LOSS_LATE  => V_DYE_LOSS_LATE,
                                                                   PI_REC            => V_REC,
                                                                   PO_REMAINAMOUNT   => V_REMIANS_AMOUNT);
          
          ELSE
            V_REMIANS_AMOUNT := V_REMIANS_AMOUNT;
          END IF;
        ELSE
          NULL;
        END IF;
      
        IF V_REMIANS_AMOUNT > 0 THEN
          --获取坯布供应商仓
          V_SUP_STOCK_SPU := MRP.PKG_COLOR_PREPARE_ORDER_MANAGER.F_GET_STOCK_NUM(P_COMPANY_ID => I.COMPANY_ID,
                                                                                 P_SUP_MODE   => 1,
                                                                                 P_TYPE       => 'SPU',
                                                                                 -- p_pro_supplier_code => :p_pro_supplier_code,
                                                                                 P_MATER_SUPPLIER_CODE => I.MATER_SUPPLIER_CODE,
                                                                                 P_UNIT                => I.UNIT,
                                                                                 P_MATERIAL_ID         => V_MATERIAL_SPU,
                                                                                 P_STORE_TYPE          => 2);
        
          IF V_SUP_STOCK_SPU > 0 THEN
            MRP.PKG_MATERIAL_SEND_GOODS.P_SPU_SUPSTOCK_OUT_BY_MT(PI_SENDAMOUNT    => V_REMIANS_AMOUNT,
                                                                 PI_SPU_SUPSTOCK  => V_SUP_STOCK_SPU,
                                                                 PI_USERID        => PI_USERID,
                                                                 PI_SPU           => V_MATERIAL_SPU,
                                                                 PI_DYE_LOSS_LATE => V_DYE_LOSS_LATE,
                                                                 PI_REC           => V_REC,
                                                                 PO_REMAINAMOUNT  => V_REMIANS_AMOUNT);
          
          END IF;
        
        ELSE
          NULL;
        END IF;*/

    END LOOP;
  
  ELSE
     --是否全部发货=否
    --当【是否完成全部发货】=否时 
    V_NUM2 :=PI_NUM;
    --将弹窗编辑【发货量】对应【面料采购单-未发货量】进行“先进先出”匹配
     FOR A IN (SELECT *
              FROM  MRP.T_FABRIC_PURCHASE_SHEET T
               WHERE T.GROUP_KEY = PI_PINID
                 AND T.FABRIC_STATUS = 'S02'
                 AND T.COMPANY_ID=PI_COMPID 
                 ORDER BY T.CREATE_TIME ASC,t.fabric_id ASC) LOOP
                 
                 
   -- 一条【面料采购单信息】生成一条【面料发货单明细】信息 mrp.t_fabric_invoice_detail 
    --发货量
    
    --待发货量=0时退出循环
    IF V_NUM2 = 0 THEN
      EXIT;
    END IF;
    
    IF V_NUM2 >A.NOT_DELIVER_AMOUNT THEN 
      --发货量
      V_SENDS_AMOUNT:= A.NOT_DELIVER_AMOUNT;      
      
      V_NUM2:=V_NUM2-A.NOT_DELIVER_AMOUNT;
    ELSE 
      V_SENDS_AMOUNT:= V_NUM2;
      
      V_NUM2 :=0;
      
    END IF;  
    --发货明细
      P_T_FAB_REC.FABRIC_INVOICE_DETAIL_ID := MRP.PKG_PLAT_COMM.F_GET_UUID(); --主键
      P_T_FAB_REC.COMPANY_ID               := A.COMPANY_ID; --企业ID
      P_T_FAB_REC.FABRIC_INVOICE_NUMBER    := V_MIANL_ID; --面料发货单号
      P_T_FAB_REC.FABRIC_ID                := A.FABRIC_ID; --面料采购单号
      P_T_FAB_REC.MATER_SUPPLIER_CODE      := A.MATER_SUPPLIER_CODE; --物料供应商编号
      P_T_FAB_REC.PRO_SUPPLIER_CODE        := A.PRO_SUPPLIER_CODE; --成品供应商编号
      P_T_FAB_REC.MATERIAL_SKU             := A.MATERIAL_SKU; --物料SKU
      P_T_FAB_REC.WHETHER_INNER_MATER      := A.WHETHER_INNER_MATER; --是否内部面料
      P_T_FAB_REC.UNIT                     := A.UNIT; --单位
      P_T_FAB_REC.SEND_GOODS_AMOUNT        := V_SENDS_AMOUNT; --发货数量
      P_T_FAB_REC.RECEIVE_GOODS_AMOUNT     := 0; --收货数量
      P_T_FAB_REC.REMARKS                  := NULL; --备注
      P_T_FAB_REC.CREATE_ID                := PI_USERID; --创建ID
      P_T_FAB_REC.CREATE_TIME              := SYSDATE; --创建时间
      P_T_FAB_REC.UPDATE_ID                :=PI_USERID; --更新ID
      P_T_FAB_REC.UPDATE_TIME              := SYSDATE; --更新时间
      
    MRP.PKG_T_FABRIC_INVOICE_DETAIL.P_INSERT_T_FABRIC_INVOICE_DETAIL(P_T_FAB_REC =>P_T_FAB_REC);
    
    --更新面料采购单
    
    scmdata.pkg_plat_log.p_document_change_trace(p_company_id              =>A.COMPANY_ID,
                                               p_document_id             => A.FABRIC_ID,
                                               p_data_source_parent_code => 'FABRIC_SHEET_LOG',
                                               p_data_source_child_code  => '05',
                                               p_operate_company_id      => PI_OP_COM,
                                               p_user_id                 => PI_USERID); 
    UPDATE MRP.T_FABRIC_PURCHASE_SHEET T
       SET T.FABRIC_STATUS = (CASE WHEN t.suggest_pick_amount - (NVL(A.ALREADY_DELIVER_AMOUNT,0)+V_SENDS_AMOUNT) = 0 THEN  'S03' ELSE t.fabric_status END),
           T.ALREADY_DELIVER_AMOUNT =NVL(A.ALREADY_DELIVER_AMOUNT,0)+V_SENDS_AMOUNT,
           T.NOT_DELIVER_AMOUNT = t.suggest_pick_amount - (NVL(A.ALREADY_DELIVER_AMOUNT,0)+V_SENDS_AMOUNT),
           T.SEND_ORDER_ID = PI_USERID,
           T.SEND_ORDER_TIME = SYSDATE
     WHERE T.FABRIC_PURCHASE_SHEET_ID = A.FABRIC_PURCHASE_SHEET_ID;
     
     --记录操作日志
        /*SCMDATA.PKG_PLAT_LOG.P_RECORD_PLAT_LOG(P_COMPANY_ID         => A.COMPANY_ID,
                                               P_APPLY_MODULE       => 'a_prematerial_412',
                                               P_BASE_TABLE         => 'T_FABRIC_PURCHASE_SHEET',
                                               P_APPLY_PK_ID        => A.FABRIC_ID,
                                               P_ACTION_TYPE        => 'UPDATE',
                                               P_LOG_ID             => vo_log_id,
                                               P_LOG_TYPE           => '05',
                                               P_LOG_MSG            => '操作【发货】，本次发货量=' ||
                                                                       V_SENDS_AMOUNT ||
                                                                       '，发货状态=已完成',
                                               P_OPERATE_FIELD      => 'ALREADY_DELIVER_AMOUNT',
                                               P_FIELD_TYPE         => 'VARCHAR2',
                                               P_OLD_CODE           => 0,
                                               P_NEW_CODE           => 1,
                                               P_OLD_VALUE          => '待发货',
                                               P_NEW_VALUE          => '已发货',
                                               P_USER_ID            => PI_USERID,
                                               P_OPERATE_COMPANY_ID => PI_OP_COM,
                                               P_SEQ_NO             => 1,
                                               PO_LOG_ID            => vo_log_id);*/
     
     
     
      SELECT *
        INTO V_REC
        FROM MRP.T_FABRIC_PURCHASE_SHEET T
       WHERE T.FABRIC_PURCHASE_SHEET_ID = A.FABRIC_PURCHASE_SHEET_ID;
       
       --色布、坯布出库
       mrp.pkg_material_send_goods.P_STOCK_INOUT_BOUND_BY_MT(V_REC => V_REC,
                                                        PI_SENDS_AMOUNT => V_SENDS_AMOUNT,
                                                        PI_USERID => PI_USERID);
    
    END LOOP;
    
  END IF;
  
  SELECT COUNT(1) INTO V_DOCNUM
    FROM MRP.T_FABRIc_invoice_detail T
    WHERE T.FABRIC_INVOICE_NUMBER= V_MIANL_ID2;
  UPDATE MRP.T_FABRIC_INVOICE U 
     SET U.PURCHASE_ORDER_NUMBER = V_DOCNUM
     WHERE U.FABRIC_INVOICE_ID=V_MIANL_ID2;
  
  
END P_DELIVER_GOODS_BYACTION;

 FUNCTION F_QUERY_MTSKU_PICK(PI_COMID IN VARCHAR2,
                             PI_PROSUPID IN VARCHAR2) RETURN CLOB
   IS
   
   V_SQL CLOB;
   
   BEGIN
     IF PI_PROSUPID IS NOT NULL THEN 
        V_SQL :=q'[ SELECT A.*,ROWNUM rn  FROM (
     SELECT DISTINCT (CASE
         WHEN E.FABRIC_PURCHASE_SHEET_ID IS NOT NULL THEN
          '是'
         ELSE
          '否'
       END) IS_EXIST_FPS, --是否存在待处理采购单
       A.SUPPLIER_MATERIAL_NAME SUPPLIER_MATERIAL_NAME, --供应商物料名称
       A.MATERIAL_SKU, --物料sku
       A.SUPPLIER_COLOR MATERIAL_SUPPLIER_COLOR, --供应商物料颜色
       A.SUPPLIER_SHADES V_SUPPLIER_SHADES, --供应商色号
       
       F.RESULT MATERIAL_CLASSIFICATION_DESC, --物料分类
       D.UNIT, --单位
       G.BRAND_STOCK BRAND_SKU_STOCK, --品牌色布库存
       G.SUPPLIER_STOCK SUPP_SKU_STOCK, --供应商色布库存
       G.TOTAL_STOCK SKU_TOTAL_STOCK_DESC, --现有总库存
       D.PRACTICAL_DOOR_WITH V_PRACTICAL_DOOR_WITH, --门幅
       D.GRAM_WEIGHT CR_GRAM_WEIGHT_N, --克重
       D.MATERIAL_SPECIFICATIONS, --规格
       D.MATERIAL_CLASSIFICATION  MATERIAL_CLASSIFICATION
  FROM MRP.MRP_INTERNAL_SUPPLIER_MATERIAL A
 INNER JOIN MRP.MRP_DETERMINE_SUPPLIER_ARCHIVES B
    ON A.SUPPLIER_CODE = B.SUPPLIER_CODE
 INNER JOIN MRP.MRP_INTERNAL_MATERIAL_SKU C
    ON C.MATERIAL_SKU = A.MATERIAL_SKU
 INNER JOIN MRP.MRP_INTERNAL_MATERIAL_SPU D
    ON D.MATERIAL_SPU = C.MATERIAL_SPU
  LEFT JOIN MRP.MATERIAL_COLOR_CLOTH_STOCK G
    ON G.MATERIAL_SKU = A.MATERIAL_SKU
   AND D.UNIT = G.UNIT
   AND A.SUPPLIER_CODE = G.MATER_SUPPLIER_CODE
  LEFT JOIN  (SELECT NVL(T4.COMPANY_DICT_ID, T3.COMPANY_DICT_ID) CATEGORY_ID,
                    T1.COMPANY_DICT_NAME CATEGORY,
                    T2.COMPANY_DICT_NAME NAME1,
                    T3.COMPANY_DICT_NAME NAME2,
                    T4.COMPANY_DICT_NAME NAME4,
                    (T1.COMPANY_DICT_NAME || '/' || T2.COMPANY_DICT_NAME || '/' ||
                    T3.COMPANY_DICT_NAME || (CASE
                      WHEN T4.COMPANY_DICT_NAME IS NOT NULL THEN
                       '/' || T4.COMPANY_DICT_NAME
                      ELSE
                       NULL
                    END)) RESULT
               FROM SCMDATA.SYS_COMPANY_DICT T1
              LEFT JOIN SCMDATA.SYS_COMPANY_DICT T2
                 ON T1.COMPANY_ID = T2.COMPANY_ID
                AND T1.COMPANY_DICT_TYPE = 'MRP_MATERIAL_CLASSIFICATION'
                AND T2.COMPANY_DICT_TYPE = T1.COMPANY_DICT_VALUE
                AND T2.PAUSE = 0 AND T1.PAUSE=0
              LEFT JOIN SCMDATA.SYS_COMPANY_DICT T3
                 ON T2.COMPANY_ID = T3.COMPANY_ID
                AND T3.COMPANY_DICT_TYPE = T2.COMPANY_DICT_VALUE
                AND T3.PAUSE = 0
               LEFT JOIN SCMDATA.SYS_COMPANY_DICT T4
                 ON T3.COMPANY_ID = T4.COMPANY_ID
                AND T4.COMPANY_DICT_TYPE = T3.COMPANY_DICT_VALUE
                AND T4.PAUSE = 0) F ON F.CATEGORY_ID = D.MATERIAL_CLASSIFICATION  
  LEFT JOIN MRP.T_FABRIC_PURCHASE_SHEET E
    ON E.MATERIAL_SKU = A.MATERIAL_SKU
   AND E.PRO_SUPPLIER_CODE = ']'||PI_PROSUPID||q'['
   AND E.MATER_SUPPLIER_CODE = A.SUPPLIER_CODE AND E.FABRIC_STATUS IN ('S01','S02')
 WHERE B.SUPPLIER_COMPANY_ID = %DEFAULT_COMPANY_ID%
   AND A.SUPPLIER_MATERIAL_STATUS = 1
   AND C.SKU_STATUS = 1
   AND B.COMPANY_ID =']'||PI_COMID||q'['  ) A ORDER BY A.IS_EXIST_FPS ASC]';
       
       
     ELSE
     V_SQL:=q'[ SELECT NULL IS_EXIST_FPS,
        NULL SUPPLIER_MATERIAL_NAME,
        NULL MATERIAL_SKU,
        NULL MATERIAL_SUPPLIER_COLOR,
        NULL V_SUPPLIER_SHADES,
        NULL MATERIAL_CLASSIFICATION_DESC,
        NULL UNIT,
        NULL BRAND_SKU_STOCK,
        NULL SUPP_SKU_STOCK,
        NULL SKU_TOTAL_STOCK_DESC,
        NULL V_PRACTICAL_DOOR_WITH,
        NULL CR_GRAM_WEIGHT_N,
        NULL MATERIAL_SPECIFICATIONS,
        NULL MATERIAL_CLASSIFICATION
   FROM DUAL  ]';
  END IF; 
   
   RETURN v_sql;
   END F_QUERY_MTSKU_PICK;
   
   
--生成面料发货单
PROCEDURE P_CREATE_FABRIC_INVOICE(PI_PROSUP    IN VARCHAR2,
                                  PI_MATSUP    IN VARCHAR2,
                                  PI_USERID    IN VARCHAR2,
                                  PI_CREDATE   IN DATE,
                                  PI_COMPID    IN VARCHAR2,
                                  PO_INVOICEID OUT VARCHAR2) IS
  V_FLAG        NUMBER;
  V_ID          VARCHAR2(32);
  V_REC         MRP.T_FABRIC_INVOICE%ROWTYPE;
  V_LIANXIREN   VARCHAR2(2000);
  V_LIANXIDIANH VARCHAR2(2000);
  V_DIZHI       VARCHAR2(2000);
BEGIN

  --查询是否存在同一创建人同一时间的发货单
  SELECT COUNT(1), MAX(T.FABRIC_INVOICE_NUMBER)
    INTO V_FLAG, V_ID
    FROM MRP.T_FABRIC_INVOICE T
   WHERE T.PRO_SUPPLIER_CODE = PI_PROSUP
     AND T.MATER_SUPPLIER_CODE = PI_MATSUP
     AND T.CREATE_ID = PI_USERID
     AND T.CREATE_TIME = PI_CREDATE;

  IF V_FLAG = 0 THEN
    --获取成品供应商信息
    --收货联系人、收货联系电话、收货地址、
    SELECT MAX(T.FA_CONTACT_NAME),
           MAX(T.FA_CONTACT_PHONE),
           MAX(T.COMPANY_ADDRESS)
      INTO V_LIANXIREN, V_LIANXIDIANH, V_DIZHI
      FROM SCMDATA.T_SUPPLIER_INFO T
     WHERE T.SUPPLIER_INFO_ID = PI_PROSUP
       AND T.COMPANY_ID = PI_COMPID;
  
    --新增发货单
    V_ID                           := MRP.PKG_PLAT_COMM.F_GET_DOCUNO(PI_TABLE_NAME  => 'MRP.T_FABRIC_INVOICE',
                                                                     PI_COLUMN_NAME => 'FABRIC_INVOICE_NUMBER',
                                                                     PI_PRE         => 'WCG' ||
                                                                                       TO_CHAR(SYSDATE,
                                                                                               'YYYYMMDD'),
                                                                     PI_SERAIL_NUM  => 5);
    V_REC.FABRIC_INVOICE_ID        := MRP.PKG_PLAT_COMM.F_GET_UUID(); --主键
    V_REC.COMPANY_ID               := PI_COMPID; --企业ID
    V_REC.FABRIC_INVOICE_NUMBER    := V_ID; --面料发货单号
    V_REC.FABRIC_STATUS            := 'S03'; --采购状态(已发货:S03/已收货:S04)
    V_REC.MATER_SUPPLIER_CODE      := PI_MATSUP; --物料供应商编号
    V_REC.PRO_SUPPLIER_CODE        := PI_PROSUP; --成品供应商编号
    V_REC.RECEIVE_GOODS_CONTACT_ID := V_LIANXIREN; --收货联系人 
    V_REC.RECEIVE_GOODS_TELEPHONE  := V_LIANXIDIANH; --收货联系电话 
    V_REC.RECEIVE_GOODS_ADDRESS    := V_DIZHI; --收货地址 
    V_REC.PURCHASE_ORDER_NUMBER    := ''; --含面料采购单单数 
    V_REC.RECEIVE_GOODS_ID         := ''; --收货人 
    V_REC.RECEIVE_TIME             := ''; --收货时间 
    V_REC.REMARKS                  := ''; --备注
    V_REC.CREATE_ID                := PI_USERID; --创建ID
    V_REC.CREATE_TIME              := SYSDATE; --创建时间
  
    MRP.PKG_T_FABRIC_INVOICE.P_INSERT_T_FABRIC_INVOICE(P_T_FAB_REC => V_REC);
  
  ELSE
    NULL;
  END IF;

  PO_INVOICEID := V_ID;

END;

 --更新、插入供应商色布库存明细
 PROCEDURE P_SYNC_SUPPLIER_COLOR_STOCK(P_SCIOB_REC  MRP.SUPPLIER_COLOR_IN_OUT_BOUND%ROWTYPE,
                                      P_COMPANY_ID VARCHAR2,
                                      P_USER_ID    VARCHAR2) IS
  V_SCCS_REC SUPPLIER_COLOR_CLOTH_STOCK%ROWTYPE;
  V_FLAG     INT;
BEGIN
  --是否找到色布库存
  V_FLAG := MRP.PKG_COLOR_PREPARE_ORDER_MANAGER.F_IS_FIND_COLOR_STOCK(P_PRO_SUPPLIER_CODE   => P_SCIOB_REC.PRO_SUPPLIER_CODE,
                                                                      P_MATER_SUPPLIER_CODE => P_SCIOB_REC.MATER_SUPPLIER_CODE,
                                                                      P_MATERIAL_SKU        => P_SCIOB_REC.MATERIAL_SKU,
                                                                      P_UNIT                => P_SCIOB_REC.UNIT,
                                                                      P_PREPARE_OBJECT      => 0);

  IF V_FLAG > 0 THEN
    --找得到更新供应商仓库存
    UPDATE MRP.SUPPLIER_COLOR_CLOTH_STOCK T
       SET T.TOTAL_STOCK    = NVL(T.TOTAL_STOCK, 0) + P_SCIOB_REC.NUM,
           T.SUPPLIER_STOCK = NVL(T.SUPPLIER_STOCK, 0) + P_SCIOB_REC.NUM,
           T.UPDATE_ID      = P_USER_ID,
           T.UPDATE_TIME    = SYSDATE
     WHERE T.PRO_SUPPLIER_CODE = P_SCIOB_REC.PRO_SUPPLIER_CODE
       AND T.MATER_SUPPLIER_CODE = P_SCIOB_REC.MATER_SUPPLIER_CODE
       AND T.MATERIAL_SKU = P_SCIOB_REC.MATERIAL_SKU
       AND T.UNIT = P_SCIOB_REC.UNIT;
  ELSE
    V_SCCS_REC.COLOR_CLOTH_STOCK_ID := MRP.PKG_PLAT_COMM.F_GET_UUID(); --供应商色布库存主键
    V_SCCS_REC.PRO_SUPPLIER_CODE    := P_SCIOB_REC.PRO_SUPPLIER_CODE; --成品供应商编号
    V_SCCS_REC.MATER_SUPPLIER_CODE  := P_SCIOB_REC.MATER_SUPPLIER_CODE; --物料供应商编号
    V_SCCS_REC.MATERIAL_SKU         := P_SCIOB_REC.MATERIAL_SKU; --物料SKU
    V_SCCS_REC.WHETHER_INNER_MATER  := P_SCIOB_REC.WHETHER_INNER_MATER; --是否内部物料，0否1是
    V_SCCS_REC.UNIT                 := P_SCIOB_REC.UNIT; --单位
    V_SCCS_REC.TOTAL_STOCK          := NVL(V_SCCS_REC.TOTAL_STOCK, 0) +
                                       P_SCIOB_REC.NUM; --总库存数
    V_SCCS_REC.BRAND_STOCK          := 0; --品牌仓库存数
    V_SCCS_REC.SUPPLIER_STOCK       := NVL(V_SCCS_REC.SUPPLIER_STOCK, 0) +
                                       P_SCIOB_REC.NUM; --供应商仓库存数
    V_SCCS_REC.COMPANY_ID           := P_COMPANY_ID; --企业编码
    V_SCCS_REC.CREATE_ID            := P_USER_ID; --创建者
    V_SCCS_REC.CREATE_TIME          := SYSDATE; --创建时间
    V_SCCS_REC.UPDATE_ID            := P_USER_ID; --更新者
    V_SCCS_REC.UPDATE_TIME          := SYSDATE; --更新时间
    V_SCCS_REC.WHETHER_DEL          := 0; --是否删除，0否1是
  
    MRP.PKG_SUPPLIER_COLOR_CLOTH_STOCK.P_INSERT_SUPPLIER_COLOR_CLOTH_STOCK(P_SUPPL_REC => V_SCCS_REC);
  
  END IF;

END P_SYNC_SUPPLIER_COLOR_STOCK;


 PROCEDURE P_CHECK_ISEXISTS_FABSHEET (PI_SUPID IN VARCHAR2,
                                     PI_MATESUPID IN VARCHAR2,
                                     PI_SKU IN VARCHAR2,
                                     PI_COMPID IN VARCHAR2,
                                     PI_RN IN NUMBER,
                                     PO_MESS IN OUT VARCHAR2) IS 
V_ERR_MESS VARCHAR2(2000):=PO_MESS;    
V_FLAG NUMBER;
 V_SUPNAME    VARCHAR2(256);                             
BEGIN
  SELECT COUNT(1)
    INTO V_FLAG
    FROM mrp.t_fabric_purchase_sheet t
  WHERE t.pro_supplier_code= PI_SUPID
    AND t.mater_supplier_code = PI_MATESUPID
    AND t.material_sku = PI_SKU 
    AND t.fabric_status IN ('S02','S01');
    
  IF V_FLAG >0 THEN 
    
    SELECT A.SUPPLIER_COMPANY_NAME
      INTO V_SUPNAME
      FROM SCMDATA.T_SUPPLIER_INFO A
     WHERE A.SUPPLIER_INFO_ID =  PI_SUPID
       AND A.COMPANY_ID=PI_COMPID;
  
  
     --V_ERR_MESS:=V_ERR_MESS||'【成品供应商】'||V_SUPNAME||'-【物料SKU:'||PI_SKU||'】 '; 
     V_ERR_MESS:=V_ERR_MESS||'第【'||PI_RN||'】条；';
      
   ELSE 
     V_ERR_MESS:=V_ERR_MESS;
  END IF;
  
  PO_MESS :=  V_ERR_MESS; 
     
END P_CHECK_ISEXISTS_FABSHEET; 

 



--新建发货单 - 提交
  --一行生成一张采购单，一张采购单生成一张发货明细，相同成品供应商的数据生成一张发货单

  --【新建发货单】页信息
     --生成【面料采购单表】 MCG+YYYY+MM+DD+5位序号 待收货 物料商发货
       --生成【面料发货单】 
        --生成【面料发货单明细】
          --【物料商库存-色布出入库单表】
          --【物料商库存-坯布出入库单表】
          --【物料商库存-色布仓库存明细】
          --【物料商库存-坯布仓库存明细】
          --【供应商库存-色布出入库单表】
          --【供应商库存-色布仓库存明细】
PROCEDURE P_SUBMIT_SENDGOODSHEET(P_ID     IN VARCHAR2,
                                          P_COMID  IN VARCHAR2,
                                          P_USERID IN VARCHAR2,
                                          PI_OP_COM IN VARCHAR2) IS
                                          
  
  V_MATERIAL_SPU            VARCHAR2(32); --物料spu 
  V_COLOR_PICTURE_ID        VARCHAR2(32); --颜色图
  V_MATERIAL_COLOR          VARCHAR2(32); --物料颜色 
  V_NET_PRICE_GOOD          NUMBER(10, 2); --优选大货净价 
  V_PER_METER_GOOD          NUMBER(10, 2); --优选大货米价 
  V_BENCHMARK_PRICE         NUMBER(10, 2); --基准价 
  V_UNIT                    VARCHAR2(6); --单位
  V_PRACTICAL_DOOR_WITH     NUMBER(10, 2); --实用门幅，单位厘米 
  V_GRAM_WEIGHT             NUMBER(6, 2); --克重，单位每平米 
  V_MATERIAL_NAME           VARCHAR2(64); --物料名称 
  V_INGREDIENTS             VARCHAR2(2560);
  V_MATERIAL_SPECIFICATIONS VARCHAR2(32); --物料规格，为辅料时必填 
  V_SUPPLIER_MATERIAL_NAME  VARCHAR2(50); --供应商物料名称 
  V_SKU_ABUTMENT_CODE       VARCHAR2(200); --供应商物料sku对接码 
  V_SUPPLIER_COLOR          VARCHAR2(150); --供应商颜色 
  V_SUPPLIER_SHADES         VARCHAR2(30); --供应商色号 
  V_OPTIMIZATION            NUMBER(1); --是否优选 
  V_DISPARITY               NUMBER(10, 2); --空差 
  V_GOOD_QUOTE              NUMBER(10, 2); --供应商大货报价 
  V_GOOD_NET_PRICE          NUMBER(10, 2); --供应商大货净价 
  V2_PICTURE_ID             VARCHAR2(64); --特征图
  V3_PICTURE_ID             VARCHAR2(64); --色卡图
  V_REC1                    MRP.T_SEND_GOODS_SHEET_TEMP%ROWTYPE;
  V_REC2                    MRP.T_FABRIC_PURCHASE_SHEET%ROWTYPE;
  V_REC3                    MRP.T_FABRIC_INVOICE_DETAIL%ROWTYPE;
  V_REC4                    MRP.SUPPLIER_COLOR_IN_OUT_BOUND%ROWTYPE;
  P_T_FAB_REC               MRP.T_FABRIC_PURCHASE_SHEET%ROWTYPE;
  P_SUPPL_REC               MRP.SUPPLIER_COLOR_IN_OUT_BOUND%ROWTYPE;
  P_T_FAB_REC2              MRP.T_FABRIC_INVOICE_DETAIL%ROWTYPE;
  V_MATERIAL_SUPPCODE       VARCHAR2(32);
  V_SHEET_ID                VARCHAR2(32);
  V_FAIN_DETAIL_ID          VARCHAR2(32);
  V_SUP_INOUT_SPUBOUND      VARCHAR2(64);
  V_MIANL_ID                VARCHAR2(32);
  --vo_log_id                 VARCHAR2(32);
BEGIN
  SELECT *
    INTO V_REC1
    FROM MRP.T_SEND_GOODS_SHEET_TEMP T
   WHERE T.SEND_GOODS_SHEET_TEMP_ID = P_ID;

   --单位
   V_UNIT :=V_REC1.UNIT;

  --物料供应商编号

  V_MATERIAL_SUPPCODE := MRP.PKG_STOCK_MANAGEMENT.F_GET_WLSUPCODE(V_CURRENT_COMPID => V_REC1.OPERATE_COMPANY_ID,
                                                                  V_NEED_COMPID    => V_REC1.COMPANY_ID);

  --获取物料信息  物料SPU、特征图、物料名称、物料成分、实用门幅、克重、规格、颜色图、物料颜色、优选大货净价、优选大货米价、基准价、
  --供应商物料SKU对接码、供应商物料名称、色卡图、供应商颜色、供应商色号、是否优选、空差、供应商大货报价、供应商大货净价

  --sku信息
  SELECT MAX(MATERIAL_SPU), --物料spu
         MAX(MATERIAL_COLOR), --物料颜色 
         MAX(PREFERRED_NET_PRICE_OF_LARGE_GOOD), --优选大货净价 
         MAX(PREFERRED_PER_METER_PRICE_OF_LARGE_GOOD), --优选大货米价 
         MAX(BENCHMARK_PRICE) --基准价 
    INTO V_MATERIAL_SPU,
         V_MATERIAL_COLOR,
         V_NET_PRICE_GOOD,
         V_PER_METER_GOOD,
         V_BENCHMARK_PRICE
    FROM MRP.MRP_INTERNAL_MATERIAL_SKU TM
   WHERE TM.MATERIAL_SKU = V_REC1.MATERIAL_SKU;

  /*查找内部物料SPU信息表——颜色图*/
  SELECT MAX(T.PICTURE_ID)
    INTO V_COLOR_PICTURE_ID
    FROM MRP.MRP_PICTURE T
   WHERE T.PICTURE_TYPE = '2'
     AND T.THIRDPART_ID = V_REC1.MATERIAL_SKU;

  /*查找内部物料SPU信息表*/
  SELECT /*MAX(UNIT), --单位 */
         MAX(PRACTICAL_DOOR_WITH), --实用门幅，单位厘米 
         MAX(GRAM_WEIGHT), --克重，单位每平米 
         MAX(MATERIAL_NAME), --物料名称 
         MAX(MATERIAL_SPECIFICATIONS) --物料规格，为辅料时必填 
    INTO /*V_UNIT,*/
         V_PRACTICAL_DOOR_WITH,
         V_GRAM_WEIGHT,
         V_MATERIAL_NAME,
         V_MATERIAL_SPECIFICATIONS
    FROM MRP.MRP_INTERNAL_MATERIAL_SPU TMS
   WHERE TMS.MATERIAL_SPU = V_MATERIAL_SPU;

  /*查找内部物料SPU信息表——特征图，物料spu*/
  SELECT MAX(T.PICTURE_ID)
    INTO V2_PICTURE_ID
    FROM MRP.MRP_PICTURE T
   WHERE T.PICTURE_TYPE = '1'
     AND T.THIRDPART_ID = V_MATERIAL_SPU
     AND ROWNUM = 1;

  --成分
  MRP.PKG_BULK_CARGO_BOM.P_GET_INGREDIENTS_BYSPU(PI_SPUID       => V_MATERIAL_SPU,
                                                 PO_INGREDIENTS => V_INGREDIENTS);

  /* 查找内部供应商物料信息表 */
  SELECT MAX(SUPPLIER_MATERIAL_NAME), --供应商物料名称 
         MAX(SKU_ABUTMENT_CODE), --供应商物料sku对接码 
         MAX(SUPPLIER_COLOR), --供应商颜色  
         MAX(SUPPLIER_SHADES), --供应商色号 
         MAX(OPTIMIZATION), --是否优选 
         MAX(DISPARITY), --空差 
         MAX(SUPPLIER_LARGE_GOOD_QUOTE), --供应商大货报价 
         MAX(SUPPLIER_LARGE_GOOD_NET_PRICE) --供应商大货净价 
    INTO V_SUPPLIER_MATERIAL_NAME,
         V_SKU_ABUTMENT_CODE,
         V_SUPPLIER_COLOR,
         V_SUPPLIER_SHADES,
         V_OPTIMIZATION,
         V_DISPARITY,
         V_GOOD_QUOTE,
         V_GOOD_NET_PRICE
    FROM MRP.MRP_INTERNAL_SUPPLIER_MATERIAL T
   WHERE T.MATERIAL_SKU = V_REC1.MATERIAL_SKU
     AND T.SUPPLIER_CODE = V_MATERIAL_SUPPCODE;
  /*查找内部物料SPU信息表——色卡图，物料spu*/
  SELECT MAX(T.PICTURE_ID)
    INTO V3_PICTURE_ID
    FROM MRP.MRP_PICTURE T
   WHERE T.PICTURE_TYPE = '3'
     AND T.THIRDPART_ID = V_SKU_ABUTMENT_CODE
   ORDER BY T.UPLOAD_TIME DESC;

  V_SHEET_ID := MRP.PKG_PLAT_COMM.F_GET_DOCUNO(PI_TABLE_NAME  => 't_fabric_purchase_sheet',
                                               PI_COLUMN_NAME => 'fabric_id',
                                               PI_PRE         => 'MCG' ||
                                                                 TO_CHAR(SYSDATE,
                                                                         'yyyymmdd'),
                                               PI_SERAIL_NUM  => 5);
  --生成面料采购单
  P_T_FAB_REC.FABRIC_PURCHASE_SHEET_ID                := MRP.PKG_PLAT_COMM.F_GET_UUID(); --主键
  P_T_FAB_REC.COMPANY_ID                              := V_REC1.COMPANY_ID; --企业ID
  P_T_FAB_REC.FABRIC_ID                               := V_SHEET_ID; --面料采购单号
  P_T_FAB_REC.FABRIC_STATUS                           := 'S03'; --采购状态(待下单:S00/待接单:S01/待发货:S02/待收货:S03/已收货:S04/已取消:S05)
  P_T_FAB_REC.FABRIC_SOURCE                           := 2; --采购单来源(品牌采购单:0/供应商自采:1/物料商发货:2)
  P_T_FAB_REC.PRO_SUPPLIER_CODE                       := V_REC1.PRO_SUPPLIER_CODE; --成品供应商编号
  P_T_FAB_REC.MATERIAL_SKU                            := V_REC1.MATERIAL_SKU; --物料SKU 
  P_T_FAB_REC.MATER_SUPPLIER_CODE                     := V_MATERIAL_SUPPCODE; --物料供应商编号 
  P_T_FAB_REC.WHETHER_INNER_MATER                     := 1; --是否内部物料,0否1是 
  P_T_FAB_REC.UNIT                                    := V_UNIT; --单位
  P_T_FAB_REC.PURCHASE_SKC_ORDER_AMOUNT               := ''; --采购SKC订单量
  P_T_FAB_REC.SUGGEST_PICK_AMOUNT                     := V_REC1.SEND_AMOUNT; --建议采购量
  P_T_FAB_REC.ACTUAL_PICK_AMOUNT                      := V_REC1.SEND_AMOUNT; --实际采购量
  P_T_FAB_REC.ALREADY_DELIVER_AMOUNT                  := V_REC1.SEND_AMOUNT; --已发货量
  P_T_FAB_REC.NOT_DELIVER_AMOUNT                      := 0; --未发货量
  P_T_FAB_REC.DELIVERY_AMOUNT                         := ''; --已收货量
  P_T_FAB_REC.PURCHASE_ORDER_NUM                      := ''; --采购订单编号
  P_T_FAB_REC.GOODS_SKC                               := ''; --货色SKC
  P_T_FAB_REC.BULK_CARGO_BOM_ID                       := ''; --大货BOMID
  P_T_FAB_REC.MATERIAL_DETAIL_ID                      := ''; --大货BOM物料明细
  P_T_FAB_REC.MATERIAL_SPU                            := V_MATERIAL_SPU; --物料SPU 
  P_T_FAB_REC.FEATURES                                := V2_PICTURE_ID; --特征图
  P_T_FAB_REC.MATERIAL_NAME                           := V_MATERIAL_NAME; --物料名称 
  P_T_FAB_REC.INGREDIENTS                             := V_INGREDIENTS; --物料成分 
  P_T_FAB_REC.PRACTICAL_DOOR_WITH                     := V_PRACTICAL_DOOR_WITH; --实用门幅 
  P_T_FAB_REC.GRAM_WEIGHT                             := V_GRAM_WEIGHT; --克重
  P_T_FAB_REC.MATERIAL_SPECIFICATIONS                 := V_MATERIAL_SPECIFICATIONS; --物料规格
  P_T_FAB_REC.COLOR_PICTURE                           := V_COLOR_PICTURE_ID; --颜色图
  P_T_FAB_REC.MATERIAL_COLOR                          := V_MATERIAL_COLOR; --物料颜色
  P_T_FAB_REC.PREFERRED_NET_PRICE_OF_LARGE_GOOD       := V_NET_PRICE_GOOD; --优选大货净价
  P_T_FAB_REC.PREFERRED_PER_METER_PRICE_OF_LARGE_GOOD := V_PER_METER_GOOD; --优选大货米价
  P_T_FAB_REC.BENCHMARK_PRICE                         := V_BENCHMARK_PRICE; --基准价
  P_T_FAB_REC.SKU_ABUTMENT_CODE                       := V_SKU_ABUTMENT_CODE; --供应商物料SKU对接码
  P_T_FAB_REC.SUPPLIER_MATERIAL_NAME                  := V_SUPPLIER_MATERIAL_NAME; --供应商物料名称
  P_T_FAB_REC.COLOR_CARD_PICTURE                      := V3_PICTURE_ID; --色卡图
  P_T_FAB_REC.SUPPLIER_COLOR                          := V_SUPPLIER_COLOR; --供应商颜色
  P_T_FAB_REC.SUPPLIER_SHADES                         := V_SUPPLIER_SHADES; --供应商色号
  P_T_FAB_REC.OPTIMIZATION                            := V_OPTIMIZATION; --是否优选
  P_T_FAB_REC.DISPARITY                               := V_DISPARITY; --空差
  P_T_FAB_REC.SUPPLIER_LARGE_GOOD_QUOTE               := V_GOOD_QUOTE; --供应商大货报价
  P_T_FAB_REC.SUPPLIER_LARGE_GOOD_NET_PRICE           := V_GOOD_NET_PRICE; --供应商大货净价
  P_T_FAB_REC.CREATE_ID                               := P_USERID; --创建ID
  P_T_FAB_REC.CREATE_TIME                             := SYSDATE; --创建时间
  P_T_FAB_REC.ORDER_ID                                := P_USERID; --下单人ID
  P_T_FAB_REC.ORDER_TIME                              := SYSDATE; --下单时间
  P_T_FAB_REC.RECEIVE_ORDER_ID                        := P_USERID; --接单人ID
  P_T_FAB_REC.RECEIVE_ORDER_TIME                      := SYSDATE; --接单时间
  P_T_FAB_REC.SEND_ORDER_ID                           := P_USERID; --发货人ID
  P_T_FAB_REC.SEND_ORDER_TIME                         := SYSDATE; --发货人时间

 scmdata.pkg_plat_log.p_document_change_trace(p_company_id              => V_REC1.COMPANY_ID,
                                               p_document_id             => V_SHEET_ID,
                                               p_data_source_parent_code => 'FABRIC_SHEET_LOG',
                                               p_data_source_child_code  => '00',
                                               p_operate_company_id      => PI_OP_COM,
                                               p_user_id                 => P_USERID); 


  --
  MRP.PKG_T_FABRIC_PURCHASE_SHEET.P_INSERT_T_FABRIC_PURCHASE_SHEET(P_T_FAB_REC => P_T_FAB_REC);

  --面料采购单GROUP_KEY
  MRP.PKG_BULK_CARGO_BOM.P_FABRIC_PURCHASE_SHEET_GROUP_KEY;
  
   --记录操作日志
        /*SCMDATA.PKG_PLAT_LOG.P_RECORD_PLAT_LOG(P_COMPANY_ID         => V_REC1.COMPANY_ID,
                                               P_APPLY_MODULE       => 'a_prematerial_420',
                                               P_BASE_TABLE         => 'T_FABRIC_PURCHASE_SHEET',
                                               P_APPLY_PK_ID        => V_SHEET_ID,
                                               P_ACTION_TYPE        => 'UPDATE',
                                               P_LOG_ID             => vo_log_id,
                                               P_LOG_TYPE           => '00',
                                               P_LOG_MSG            => '操作【新建发货单】，采购单来源=物料商发货',
                                               P_OPERATE_FIELD      => 'FABRIC_ID',
                                               P_FIELD_TYPE         => 'VARCHAR2',
                                               P_OLD_CODE           => 0,
                                               P_NEW_CODE           => 1,
                                               P_OLD_VALUE          => '',
                                               P_NEW_VALUE          => V_SHEET_ID,
                                               P_USER_ID            => P_USERID,
                                               P_OPERATE_COMPANY_ID => PI_OP_COM,
                                               P_SEQ_NO             => 1,
                                               PO_LOG_ID            => vo_log_id);*/

  --发货单
  MRP.PKG_MATERIAL_SEND_GOODS.P_CREATE_FABRIC_INVOICE(PI_PROSUP    => V_REC1.PRO_SUPPLIER_CODE,
                                                      PI_MATSUP    => V_REC1.MATERIAL_SKU,
                                                      PI_USERID    => P_USERID,
                                                      PI_CREDATE   => SYSDATE,
                                                      PI_COMPID    => V_REC1.COMPANY_ID,
                                                      PO_INVOICEID => V_MIANL_ID);

  --发货单明细
  V_FAIN_DETAIL_ID                      := MRP.PKG_PLAT_COMM.F_GET_UUID();
  P_T_FAB_REC2.FABRIC_INVOICE_DETAIL_ID := V_FAIN_DETAIL_ID; --主键
  P_T_FAB_REC2.COMPANY_ID               := V_REC1.COMPANY_ID; --企业ID
  P_T_FAB_REC2.FABRIC_INVOICE_NUMBER    := V_MIANL_ID; --面料发货单号
  P_T_FAB_REC2.FABRIC_ID                := V_SHEET_ID; --面料采购单号
  P_T_FAB_REC2.MATER_SUPPLIER_CODE      := V_MATERIAL_SUPPCODE; --物料供应商编号
  P_T_FAB_REC2.PRO_SUPPLIER_CODE        := V_REC1.PRO_SUPPLIER_CODE; --成品供应商编号
  P_T_FAB_REC2.MATERIAL_SKU             := V_REC1.MATERIAL_SKU; --物料SKU
  P_T_FAB_REC2.WHETHER_INNER_MATER      := 1; --是否内部面料
  P_T_FAB_REC2.UNIT                     := V_UNIT; --单位
  P_T_FAB_REC2.SEND_GOODS_AMOUNT        := V_REC1.SEND_AMOUNT; --发货数量
  P_T_FAB_REC2.RECEIVE_GOODS_AMOUNT     := ''; --收货数量
  P_T_FAB_REC2.REMARKS                  := NULL; --备注
  P_T_FAB_REC2.CREATE_ID                := P_USERID; --创建ID
  P_T_FAB_REC2.CREATE_TIME              := SYSDATE; --创建时间
  P_T_FAB_REC2.UPDATE_ID                := P_USERID; --更新ID
  P_T_FAB_REC2.UPDATE_TIME              := SYSDATE; --更新时间

  MRP.PKG_T_FABRIC_INVOICE_DETAIL.P_INSERT_T_FABRIC_INVOICE_DETAIL(P_T_FAB_REC => P_T_FAB_REC2);

  SELECT *
    INTO V_REC2
    FROM MRP.T_FABRIC_PURCHASE_SHEET T
   WHERE T.FABRIC_ID = V_SHEET_ID;

  --色布、坯布出库
  MRP.PKG_MATERIAL_SEND_GOODS.P_STOCK_INOUT_BOUND_BY_MT(V_REC           => V_REC2,
                                                        PI_SENDS_AMOUNT => V_REC1.SEND_AMOUNT,
                                                        PI_USERID       => P_USERID);

  --供应商色布库存
  --根据发货单明细生成色布入库单   
  SELECT *
    INTO V_REC3
    FROM MRP.T_FABRIC_INVOICE_DETAIL T
   WHERE T.FABRIC_INVOICE_DETAIL_ID = V_FAIN_DETAIL_ID;

  V_SUP_INOUT_SPUBOUND := MRP.PKG_PLAT_COMM.F_GET_DOCUNO(PI_TABLE_NAME  => 'MRP.SUPPLIER_COLOR_IN_OUT_BOUND',
                                                         PI_COLUMN_NAME => 'BOUND_NUM',
                                                         PI_PRE         => 'CKRK' ||
                                                                           TO_CHAR(SYSDATE,
                                                                                   'YYYYMMDD'),
                                                         PI_SERAIL_NUM  => 5);

  P_SUPPL_REC.BOUND_NUM  := V_SUP_INOUT_SPUBOUND; --色布出入库单号
  P_SUPPL_REC.ASCRIPTION := 1; --出入库归属，0出库1入库
  P_SUPPL_REC.BOUND_TYPE := 17; --出入库类型，1订单出库，2盘亏出库，3领料出库，10品牌备料入库，11供应商现货入库，12临时补充入库，13盘盈入库，14临时坯转色入库 15 供应商色布入库 16 供应商现货出库 17 手工采购入库

  P_SUPPL_REC.PRO_SUPPLIER_CODE   := V_REC3.PRO_SUPPLIER_CODE; --成品供应商编号
  P_SUPPL_REC.MATER_SUPPLIER_CODE := V_REC3.MATER_SUPPLIER_CODE; --物料供应商编号
  P_SUPPL_REC.MATERIAL_SKU        := V_REC2.MATERIAL_SKU; --物料SKU
  P_SUPPL_REC.WHETHER_INNER_MATER := V_REC3.WHETHER_INNER_MATER; --是否内部物料，0否1是
  P_SUPPL_REC.UNIT                := V_REC3.UNIT; --单位
  P_SUPPL_REC.NUM                 := V_REC3.SEND_GOODS_AMOUNT; --数量
  P_SUPPL_REC.STOCK_TYPE          := 2; --仓库类型，1品牌仓，2供应商仓
  P_SUPPL_REC.RELATE_NUM          := V_REC3.FABRIC_ID; --关联单号
  P_SUPPL_REC.RELATE_NUM_TYPE     := 4; --关联单号类型，1色布生产单/2色布盘点单/3色布领料单/4面料采购单/5坯布出库单
  P_SUPPL_REC.RELATE_SKC          := ''; --关联SKC
  P_SUPPL_REC.RELATE_PURCHASE     := ''; --关联采购单号
  P_SUPPL_REC.COMPANY_ID          := V_REC3.COMPANY_ID; --企业编码
  P_SUPPL_REC.CREATE_ID           := V_REC3.CREATE_ID; --创建者
  P_SUPPL_REC.CREATE_TIME         := SYSDATE; --创建时间
  P_SUPPL_REC.WHETHER_DEL         := 0; --是否删除，0否1是

  MRP.PKG_SUPPLIER_COLOR_IN_OUT_BOUND.P_INSERT_SUPPLIER_COLOR_IN_OUT_BOUND(P_SUPPL_REC => P_SUPPL_REC);

  SELECT *
    INTO V_REC4
    FROM MRP.SUPPLIER_COLOR_IN_OUT_BOUND U
   WHERE U.BOUND_NUM = V_SUP_INOUT_SPUBOUND;

  --更新供应商色布库存明细
  MRP.PKG_MATERIAL_SEND_GOODS.P_SYNC_SUPPLIER_COLOR_STOCK(P_SCIOB_REC  => V_REC4,
                                                          P_COMPANY_ID => P_COMID,
                                                          P_USER_ID    => P_USERID);
                                                          
 UPDATE MRP.T_SEND_GOODS_SHEET_TEMP T
    SET T.STATUS = 2
    WHERE T.SEND_GOODS_SHEET_TEMP_ID = V_REC1.SEND_GOODS_SHEET_TEMP_ID;                                                         

END P_SUBMIT_SENDGOODSHEET;


END PKG_MATERIAL_SEND_GOODS;
/

