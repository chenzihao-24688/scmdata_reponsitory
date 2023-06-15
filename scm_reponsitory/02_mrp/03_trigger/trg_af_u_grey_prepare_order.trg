CREATE OR REPLACE TRIGGER MRP.TRG_AF_U_GREY_PREPARE_ORDER
  AFTER  UPDATE OF prepare_status, expect_arrival_time, order_num ON mrp.GREY_PREPARE_ORDER
  FOR EACH ROW

 DECLARE
  /*v_operate_company_id VARCHAR2(32);
  v_ds_parent_code     VARCHAR2(32);
  v_ds_child_code      VARCHAR2(32);
  v_user_id            VARCHAR2(32);*/
  V_REC SCMDATA.T_DOCUMENT_CHANGE_TRACE%ROWTYPE;
 BEGIN
   
  IF :old.prepare_status = 0 AND :new.prepare_status = 1 THEN 
    NULL;
  ELSE  
  SCMDATA.PKG_PLAT_LOG.P_GET_DOCUMENT_CHANGE_TRACE_PARAMS(P_COMPANY_ID    =>  'b6cc680ad0f599cde0531164a8c0337f',
                                                            P_DOCUMENT_ID   => :OLD.PREPARE_ORDER_ID,
                                                            PO_DOCUMENT_REC => V_REC);  
                                                            
  END IF;                                                          
 
 /*SELECT T.OPERATE_COMPANY_ID,
        T.DATA_SOURCE_PARENT_CODE,
        T.DATA_SOURCE_CHILD_CODE,
        T.UPDATE_ID
   INTO V_OPERATE_COMPANY_ID, V_DS_PARENT_CODE, V_DS_CHILD_CODE, V_USER_ID
   FROM SCMDATA.T_DOCUMENT_CHANGE_TRACE T
  WHERE T.COMPANY_ID = 'b6cc680ad0f599cde0531164a8c0337f'
    AND T.DOCUMENT_ID = :OLD.PREPARE_ORDER_ID;*/

 --1.备料状态
 IF SCMDATA.PKG_PLAT_COMM.F_IS_CHECK_FIELDS_EQ(P_OLD_FIELD => :OLD.PREPARE_STATUS,
                                               P_NEW_FIELD => :NEW.PREPARE_STATUS) = 0 THEN
   --1.1 接单 待接单 => 生产中
   IF :OLD.PREPARE_STATUS = 1 AND :NEW.PREPARE_STATUS = 2 THEN
     SCMDATA.PKG_PLAT_LOG.P_SYNC_RECORD_PLAT_LOG(P_COMPANY_ID         => 'b6cc680ad0f599cde0531164a8c0337f',
                                                 P_APPLY_MODULE       => 'prematerial_211',
                                                 P_APPLY_MODULE_DESC  => '坯布备料单',
                                                 P_BASE_TABLE         => 'GREY_PREPARE_ORDER',
                                                 P_APPLY_PK_ID        => :OLD.PREPARE_ORDER_ID,
                                                 P_ACTION_TYPE        => 'UPDATE',
                                                 P_LOG_DICT_TYPE      => V_REC.DATA_SOURCE_PARENT_CODE,
                                                 P_LOG_TYPE           => V_REC.DATA_SOURCE_CHILD_CODE,
                                                 P_LOG_MSG            => '备料单号：' ||
                                                                         :OLD.PREPARE_ORDER_ID ||
                                                                         '被接单',
                                                 P_OPERATE_FIELD      => 'PREPARE_STATUS',
                                                 P_FIELD_TYPE         => 'NUMBER',
                                                 P_FIELD_DESC         => NULL,
                                                 P_OLD_CODE           => 1,
                                                 P_NEW_CODE           => 2,
                                                 P_OLD_VALUE          => '待接单',
                                                 P_NEW_VALUE          => '生产中',
                                                 P_OPERATE_COMPANY_ID => V_REC.OPERATE_COMPANY_ID,
                                                 P_USER_ID            => V_REC.UPDATE_ID,
                                                 P_MEMO               => NULL,
                                                 P_MEMO_DESC          => NULL,
                                                 P_TYPE               => 2);
   ELSIF :old.prepare_status in (1,0) AND :NEW.PREPARE_STATUS = 4 THEN
     --1.2 取消备料单 待审核/待接单 => 已取消
     SCMDATA.PKG_PLAT_LOG.P_SYNC_RECORD_PLAT_LOG(P_COMPANY_ID         => 'b6cc680ad0f599cde0531164a8c0337f',
                                                 P_APPLY_MODULE       => 'a_prematerial_211_1',
                                                 P_APPLY_MODULE_DESC  => '坯布备料单明细',
                                                 P_BASE_TABLE         => 'GREY_PREPARE_ORDER',
                                                 P_APPLY_PK_ID        => :OLD.PREPARE_ORDER_ID,
                                                 P_ACTION_TYPE        => 'UPDATE',
                                                 P_LOG_DICT_TYPE      => V_REC.DATA_SOURCE_PARENT_CODE,
                                                 P_LOG_TYPE           => V_REC.DATA_SOURCE_CHILD_CODE,
                                                 P_LOG_MSG            => '取消备料单号：' ||
                                                                         :OLD.PREPARE_ORDER_ID,
                                                 P_OPERATE_FIELD      => 'PREPARE_STATUS',
                                                 P_FIELD_TYPE         => 'NUMBER',
                                                 P_FIELD_DESC         => NULL,
                                                 P_OLD_CODE           => 1,
                                                 P_NEW_CODE           => 4,
                                                 P_OLD_VALUE          => CASE WHEN :old.prepare_status = 1 THEN '待接单' WHEN :old.prepare_status = 0 THEN '待审核' END,
                                                 P_NEW_VALUE          => '已取消',
                                                 P_OPERATE_COMPANY_ID => V_REC.OPERATE_COMPANY_ID,
                                                 P_USER_ID            => V_REC.UPDATE_ID,
                                                 P_MEMO               => NULL,
                                                 P_MEMO_DESC          => NULL,
                                                 P_TYPE               => 2);

   ELSIF :OLD.PREPARE_STATUS = 2 AND :NEW.PREPARE_STATUS = 4 THEN
     --1.3 取消生产单 备料单状态：生产中 => 已取消
     SCMDATA.PKG_PLAT_LOG.P_SYNC_RECORD_PLAT_LOG(P_COMPANY_ID         => 'b6cc680ad0f599cde0531164a8c0337f',
                                                 P_APPLY_MODULE       => 'a_prematerial_212',
                                                 P_APPLY_MODULE_DESC  => '坯布备料单',
                                                 P_BASE_TABLE         => 'COLOR_PREPARE_PRODUCT_ORDER',
                                                 P_APPLY_PK_ID        => :OLD.PREPARE_ORDER_ID,
                                                 P_ACTION_TYPE        => 'UPDATE',
                                                 P_LOG_DICT_TYPE      => V_REC.DATA_SOURCE_PARENT_CODE,
                                                 P_LOG_TYPE           => V_REC.DATA_SOURCE_CHILD_CODE,
                                                 P_LOG_MSG            => '取消生产单号：' ||
                                                                         :OLD.PRODUCT_ORDER_ID,
                                                 P_OPERATE_FIELD      => 'PREPARE_STATUS',
                                                 P_FIELD_TYPE         => 'NUMBER',
                                                 P_FIELD_DESC         => NULL,
                                                 P_OLD_CODE           => 2,
                                                 P_NEW_CODE           => 4,
                                                 P_OLD_VALUE          => '生产中',
                                                 P_NEW_VALUE          => '已取消',
                                                 P_OPERATE_COMPANY_ID => V_REC.OPERATE_COMPANY_ID,
                                                 P_USER_ID            => V_REC.UPDATE_ID,
                                                 P_MEMO               => NULL,
                                                 P_MEMO_DESC          => NULL,
                                                 P_TYPE               => 2);

   ELSIF :OLD.PREPARE_STATUS = 2 AND :NEW.PREPARE_STATUS = 3 THEN
     --订单完成 生产中 => 已完成
     SCMDATA.PKG_PLAT_LOG.P_SYNC_RECORD_PLAT_LOG(P_COMPANY_ID         => 'b6cc680ad0f599cde0531164a8c0337f',
                                                 P_APPLY_MODULE       => 'a_prematerial_212',
                                                 P_APPLY_MODULE_DESC  => '坯布备料单',
                                                 P_BASE_TABLE         => 'COLOR_PREPARE_PRODUCT_ORDER',
                                                 P_APPLY_PK_ID        => :OLD.PREPARE_ORDER_ID,
                                                 P_ACTION_TYPE        => 'UPDATE',
                                                 P_LOG_DICT_TYPE      => V_REC.DATA_SOURCE_PARENT_CODE,
                                                 P_LOG_TYPE           => V_REC.DATA_SOURCE_CHILD_CODE,
                                                 P_LOG_MSG            => '完成生产单号：' ||
                                                                         :OLD.PRODUCT_ORDER_ID,
                                                 P_OPERATE_FIELD      => 'PREPARE_STATUS',
                                                 P_FIELD_TYPE         => 'NUMBER',
                                                 P_FIELD_DESC         => NULL,
                                                 P_OLD_CODE           => 2,
                                                 P_NEW_CODE           => 3,
                                                 P_OLD_VALUE          => '生产中',
                                                 P_NEW_VALUE          => '已完成',
                                                 P_OPERATE_COMPANY_ID => V_REC.OPERATE_COMPANY_ID,
                                                 P_USER_ID            => V_REC.UPDATE_ID,
                                                 P_MEMO               => NULL,
                                                 P_MEMO_DESC          => NULL,
                                                 P_TYPE               => 2);
   ELSE
     NULL;
   END IF;
 END IF;

 --2.预计到仓日期
 IF SCMDATA.PKG_PLAT_COMM.F_IS_CHECK_FIELDS_EQ(P_OLD_FIELD => :OLD.EXPECT_ARRIVAL_TIME,
                                               P_NEW_FIELD => :NEW.EXPECT_ARRIVAL_TIME) = 0 THEN
   SCMDATA.PKG_PLAT_LOG.P_SYNC_RECORD_PLAT_LOG(P_COMPANY_ID         => 'b6cc680ad0f599cde0531164a8c0337f',
                                               P_APPLY_MODULE       => 'a_prematerial_211_1',
                                               P_APPLY_MODULE_DESC  => '坯布备料单明细',
                                               P_BASE_TABLE         => 'GREY_PREPARE_ORDER',
                                               P_APPLY_PK_ID        => :OLD.PREPARE_ORDER_ID,
                                               P_ACTION_TYPE        => 'UPDATE',
                                               P_LOG_DICT_TYPE      => V_REC.DATA_SOURCE_PARENT_CODE,
                                               P_LOG_TYPE           => V_REC.DATA_SOURCE_CHILD_CODE,
                                               P_LOG_MSG            => '备料单号：' ||
                                                                       :OLD.PREPARE_ORDER_ID || '；' ||
                                                                       CHR(10) ||
                                                                       '预计到仓日期：' ||
                                                                       TO_CHAR(:NEW.EXPECT_ARRIVAL_TIME,
                                                                               'yyyy-mm-dd') ||
                                                                       ' 12:00:00' ||
                                                                       '【操作前：' ||
                                                                       TO_CHAR(:OLD.EXPECT_ARRIVAL_TIME,
                                                                               'yyyy-mm-dd hh24:mi:ss') || '】' || '；',
                                               P_OPERATE_FIELD      => 'EXPECT_ARRIVAL_TIME',
                                               P_FIELD_TYPE         => 'DATE',
                                               P_FIELD_DESC         => NULL,
                                               P_OLD_CODE           => NULL,
                                               P_NEW_CODE           => NULL,
                                               P_OLD_VALUE          => :OLD.EXPECT_ARRIVAL_TIME,
                                               P_NEW_VALUE          => :NEW.EXPECT_ARRIVAL_TIME,
                                               P_OPERATE_COMPANY_ID => V_REC.OPERATE_COMPANY_ID,
                                               P_USER_ID            => V_REC.UPDATE_ID,
                                               P_TYPE               => 2);
 END IF;

 --3.订单量
 IF SCMDATA.PKG_PLAT_COMM.F_IS_CHECK_FIELDS_EQ(P_OLD_FIELD => :OLD.ORDER_NUM,
                                               P_NEW_FIELD => :NEW.ORDER_NUM) = 0 THEN

   SCMDATA.PKG_PLAT_LOG.P_SYNC_RECORD_PLAT_LOG(P_COMPANY_ID         => 'b6cc680ad0f599cde0531164a8c0337f',
                                               P_APPLY_MODULE       => 'a_prematerial_211_1',
                                               P_APPLY_MODULE_DESC  => '坯布备料单明细',
                                               P_BASE_TABLE         => 'GREY_PREPARE_ORDER',
                                               P_APPLY_PK_ID        => :OLD.PREPARE_ORDER_ID,
                                               P_ACTION_TYPE        => 'UPDATE',
                                               P_LOG_DICT_TYPE      => V_REC.DATA_SOURCE_PARENT_CODE,
                                               P_LOG_TYPE           => V_REC.DATA_SOURCE_CHILD_CODE,
                                               P_LOG_MSG            => '备料单号：' ||
                                                                       :OLD.PREPARE_ORDER_ID || '；' ||
                                                                       CHR(10) ||
                                                                       '订单量：' ||
                                                                       :NEW.ORDER_NUM ||
                                                                       '【操作前：' ||
                                                                       :OLD.ORDER_NUM || '】' || '；',
                                               P_OPERATE_FIELD      => 'ORDER_NUM',
                                               P_FIELD_TYPE         => 'NUMBER',
                                               P_FIELD_DESC         => NULL,
                                               P_OLD_CODE           => NULL,
                                               P_NEW_CODE           => NULL,
                                               P_OLD_VALUE          => :OLD.ORDER_NUM,
                                               P_NEW_VALUE          => :NEW.ORDER_NUM,
                                               P_OPERATE_COMPANY_ID => V_REC.OPERATE_COMPANY_ID,
                                               P_USER_ID            => V_REC.UPDATE_ID,
                                               P_TYPE               => 2);
 END IF;

 END TRG_AF_U_GREY_PREPARE_ORDER;
/

