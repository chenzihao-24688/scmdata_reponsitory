CREATE OR REPLACE TRIGGER MRP.TFG_AF_IU_MATERIAL_GREY_INVENTORY
  AFTER INSERT OR UPDATE ON MATERIAL_GREY_INVENTORY
  FOR EACH ROW
DECLARE
  V_COMPANY_ID VARCHAR2(32) := 'b6cc680ad0f599cde0531164a8c0337f';
  /* v_operate_company_id VARCHAR2(32);
  v_ds_parent_code     VARCHAR2(32);
  v_ds_child_code      VARCHAR2(32);
  v_user_id            VARCHAR2(32);*/
  V_REC SCMDATA.T_DOCUMENT_CHANGE_TRACE%ROWTYPE;
BEGIN

  IF INSERTING THEN
    --获取操作方等信息
    SCMDATA.PKG_PLAT_LOG.P_GET_DOCUMENT_CHANGE_TRACE_PARAMS(P_COMPANY_ID    => V_COMPANY_ID,
                                                            P_DOCUMENT_ID   => :NEW.INVENTORY_CODE,
                                                            PO_DOCUMENT_REC => V_REC);
    /* SELECT t.operate_company_id,
          t.data_source_parent_code,
          t.data_source_child_code,
          t.update_id
     INTO v_operate_company_id, v_ds_parent_code, v_ds_child_code, v_user_id
     FROM scmdata.t_document_change_trace t
    WHERE t.company_id = 'b6cc680ad0f599cde0531164a8c0337f'
      AND t.document_id = :NEW.INVENTORY_CODE;*/
  
    --记录日志
    SCMDATA.PKG_PLAT_LOG.P_SYNC_RECORD_PLAT_LOG(P_COMPANY_ID         => V_COMPANY_ID,
                                                P_APPLY_MODULE       => 'a_prematerial_151',
                                                P_APPLY_MODULE_DESC  => '物料商坯布库存盘点',
                                                P_BASE_TABLE         => 'MATERIAL_GREY_INVENTORY',
                                                P_APPLY_PK_ID        => :NEW.INVENTORY_CODE,
                                                P_ACTION_TYPE        => 'INSERT',
                                                P_LOG_DICT_TYPE      => V_REC.DATA_SOURCE_PARENT_CODE,
                                                P_LOG_TYPE           => V_REC.DATA_SOURCE_CHILD_CODE,
                                                P_LOG_MSG            => '创建坯布盘点单:' ||
                                                                        :NEW.INVENTORY_CODE,
                                                P_OPERATE_FIELD      => 'INVENTORY_CODE',
                                                P_FIELD_TYPE         => 'VARCHAR2',
                                                P_FIELD_DESC         => '盘点单号',
                                                P_OLD_CODE           => NULL,
                                                P_NEW_CODE           => :NEW.INVENTORY_CODE,
                                                P_OLD_VALUE          => NULL,
                                                P_NEW_VALUE          => :NEW.INVENTORY_CODE,
                                                P_OPERATE_COMPANY_ID => V_REC.OPERATE_COMPANY_ID,
                                                P_USER_ID            => V_REC.UPDATE_ID,
                                                P_MEMO               => NULL,
                                                P_MEMO_DESC          => NULL,
                                                P_TYPE               => 2);
  
  END IF;

  IF UPDATING THEN
    IF SCMDATA.PKG_PLAT_COMM.F_IS_CHECK_FIELDS_EQ(P_OLD_FIELD => :OLD.REMARKS,
                                                  P_NEW_FIELD => :NEW.REMARKS) = 0 THEN
    
      --获取操作方等信息
      SCMDATA.PKG_PLAT_LOG.P_GET_DOCUMENT_CHANGE_TRACE_PARAMS(P_COMPANY_ID    => V_COMPANY_ID,
                                                              P_DOCUMENT_ID   => :OLD.INVENTORY_CODE,
                                                              PO_DOCUMENT_REC => V_REC);
    
      /* SELECT t.operate_company_id,
            t.data_source_parent_code,
            t.data_source_child_code,
            t.update_id
       INTO v_operate_company_id, v_ds_parent_code, v_ds_child_code, v_user_id
       FROM scmdata.t_document_change_trace t
      WHERE t.company_id = 'b6cc680ad0f599cde0531164a8c0337f'
        AND t.document_id = :OLD.INVENTORY_CODE;*/
    
      --记录日志
      SCMDATA.PKG_PLAT_LOG.P_SYNC_RECORD_PLAT_LOG(P_COMPANY_ID         => V_COMPANY_ID,
                                                  P_APPLY_MODULE       => 'a_prematerial_151',
                                                  P_APPLY_MODULE_DESC  => '物料商坯布盘点',
                                                  P_BASE_TABLE         => 'MATERIAL_GREY_INVENTORY',
                                                  P_APPLY_PK_ID        => :OLD.INVENTORY_CODE,
                                                  P_ACTION_TYPE        => 'UPDATE',
                                                  P_LOG_DICT_TYPE      => V_REC.DATA_SOURCE_PARENT_CODE,
                                                  P_LOG_TYPE           => V_REC.DATA_SOURCE_CHILD_CODE,
                                                  P_LOG_MSG            => '编辑盘点单备注:' ||
                                                                          :NEW.REMARKS ||
                                                                          '【操作前:' ||
                                                                          :OLD.REMARKS || '】',
                                                  P_OPERATE_FIELD      => 'REMARKS',
                                                  P_FIELD_TYPE         => 'VARCHAR2',
                                                  P_FIELD_DESC         => '盘点备注',
                                                  P_OLD_CODE           => 0,
                                                  P_NEW_CODE           => 1,
                                                  P_OLD_VALUE          => :OLD.REMARKS,
                                                  P_NEW_VALUE          => :NEW.REMARKS,
                                                  P_OPERATE_COMPANY_ID => V_REC.OPERATE_COMPANY_ID,
                                                  P_USER_ID            => V_REC.UPDATE_ID,
                                                  P_MEMO               => NULL,
                                                  P_MEMO_DESC          => NULL,
                                                  P_TYPE               => 2);
    ELSE
      NULL;
    END IF;
  
  END IF;

END;
/

