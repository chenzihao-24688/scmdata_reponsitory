CREATE OR REPLACE TRIGGER SCMDATA.TRG_AF_U_T_RETURN_MANAGEMENT
  AFTER UPDATE OF MERCHER_ID, MERCHER_DIRECTOR_ID, QC_ID, QC_DIRECTOR_ID, CAUSE_DETAIL_ID, PROBLEM_DEC, RM_TYPE, FIRST_DEPT_ID, SECOND_DEPT_ID, MEMO ON SCMDATA.T_RETURN_MANAGEMENT
  FOR EACH ROW

DECLARE
  VO_LOG_ID    VARCHAR2(32);
  V_COMPANY_ID VARCHAR2(32) := :NEW.COMPANY_ID;
  V_UPDATE_ID  VARCHAR2(32) := :NEW.UPDATE_ID;
  V_RM_ID      VARCHAR2(32) := :NEW.RM_ID;
BEGIN
  --1.qc相关
  DECLARE
    V_OLD_QC         VARCHAR2(256);
    V_NEW_QC         VARCHAR2(256);
    V_OLD_QC_DIRE    VARCHAR2(256);
    V_NEW_QC_DIRE VARCHAR2(256);
  BEGIN
    IF SCMDATA.PKG_PLAT_LOG.F_IS_CHECK_FIELDS_EQ(:OLD.QC_ID, :NEW.QC_ID) = 0 THEN
      V_OLD_QC := SCMDATA.PKG_PLAT_COMM.F_GET_USERNAME(P_USER_ID    => :OLD.QC_ID,
                                                       P_IS_MUTIVAL => 1,
                                                       P_SPILT      => ',');
      V_NEW_QC := SCMDATA.PKG_PLAT_COMM.F_GET_USERNAME(P_USER_ID    => :NEW.QC_ID,
                                                       P_IS_MUTIVAL => 1,
                                                       P_SPILT      => ',');
      SCMDATA.PKG_PLAT_LOG.P_RECORD_PLAT_LOG(P_COMPANY_ID         => V_COMPANY_ID,
                                             P_APPLY_MODULE       => 'a_return_101',
                                             P_BASE_TABLE         => 'T_RETURN_MANAGEMENT',
                                             P_APPLY_PK_ID        => V_RM_ID,
                                             P_ACTION_TYPE        => 'UPDATE',
                                             P_LOG_ID             => VO_LOG_ID,
                                             P_LOG_TYPE           => '00',
                                             P_FIELD_DESC         => 'QC',
                                             P_OPERATE_FIELD      => 'QC_ID',
                                             P_FIELD_TYPE         => 'VARCHAR',
                                             P_OLD_CODE           => :OLD.QC_ID,
                                             P_NEW_CODE           => :NEW.QC_ID,
                                             P_OLD_VALUE          => V_OLD_QC,
                                             P_NEW_VALUE          => V_NEW_QC,
                                             P_MEMO               => '02',
                                             P_MEMO_DESC          => V_OLD_QC,
                                             P_USER_ID            => V_UPDATE_ID,
                                             P_OPERATE_COMPANY_ID => V_COMPANY_ID,
                                             P_SEQ_NO             => 1,
                                             PO_LOG_ID            => VO_LOG_ID);
    END IF;
    IF SCMDATA.PKG_PLAT_LOG.F_IS_CHECK_FIELDS_EQ(:OLD.QC_DIRECTOR_ID,
                                                 :NEW.QC_DIRECTOR_ID) = 0 THEN

      V_OLD_QC_DIRE := SCMDATA.PKG_PLAT_COMM.F_GET_USERNAME(P_USER_ID    => :OLD.QC_DIRECTOR_ID,
                                                            P_IS_MUTIVAL => 1,
                                                            P_SPILT      => ',');
      V_NEW_QC_DIRE := SCMDATA.PKG_PLAT_COMM.F_GET_USERNAME(P_USER_ID    => :NEW.QC_DIRECTOR_ID,
                                                            P_IS_MUTIVAL => 1,
                                                            P_SPILT      => ',');
      SCMDATA.PKG_PLAT_LOG.P_RECORD_PLAT_LOG(P_COMPANY_ID         => V_COMPANY_ID,
                                             P_APPLY_MODULE       => 'a_return_101',
                                             P_BASE_TABLE         => 'T_RETURN_MANAGEMENT',
                                             P_APPLY_PK_ID        => V_RM_ID,
                                             P_ACTION_TYPE        => 'UPDATE',
                                             P_LOG_ID             => VO_LOG_ID,
                                             P_LOG_TYPE           => '06',
                                             P_FIELD_DESC         => 'QC主管',
                                             P_OPERATE_FIELD      => 'QC_DIRECTOR_ID',
                                             P_FIELD_TYPE         => 'VARCHAR',
                                             P_OLD_CODE           => :OLD.QC_DIRECTOR_ID,
                                             P_NEW_CODE           => :NEW.QC_DIRECTOR_ID,
                                             P_OLD_VALUE          => V_OLD_QC_DIRE,
                                             P_NEW_VALUE          => V_NEW_QC_DIRE,
                                             P_MEMO               => '02',
                                             P_MEMO_DESC          => V_OLD_QC_DIRE,
                                             P_USER_ID            => V_UPDATE_ID,
                                             P_OPERATE_COMPANY_ID => V_COMPANY_ID,
                                             P_SEQ_NO             => 2,
                                             PO_LOG_ID            => VO_LOG_ID);
    END IF;

    IF VO_LOG_ID IS NOT NULL THEN
      SCMDATA.PKG_PLAT_LOG.P_UPDATE_PLAT_LOGMSG(P_COMPANY_ID        => V_COMPANY_ID,
                                                P_LOG_ID            => VO_LOG_ID,
                                                P_IS_LOGSMSG        => 1,
                                                P_IS_SPLICE_FIELDS  => 0,
                                                P_IS_SHOW_MEMO_DESC => 1);
    END IF;
  END QC;

  --跟单相关
  DECLARE
    V_OLD_FLW_ORDER         VARCHAR2(32);
    V_NEW_FLW_ORDER         VARCHAR2(32);
    V_OLD_FLW_ORDER_MANAGER VARCHAR2(32);
    V_NEW_FLW_ORDER_MANAGER VARCHAR2(32);
  BEGIN
    --跟单
    IF SCMDATA.PKG_PLAT_LOG.F_IS_CHECK_FIELDS_EQ(:OLD.MERCHER_ID,
                                                 :NEW.MERCHER_ID) = 0 THEN

      V_OLD_FLW_ORDER := SCMDATA.PKG_PLAT_COMM.F_GET_USERNAME(P_USER_ID    => :OLD.MERCHER_ID,
                                                              P_IS_MUTIVAL => 1,
                                                              P_SPILT      => ',');

      V_NEW_FLW_ORDER := SCMDATA.PKG_PLAT_COMM.F_GET_USERNAME(P_USER_ID    => :NEW.MERCHER_ID,
                                                              P_IS_MUTIVAL => 1,
                                                              P_SPILT      => ',');
      SCMDATA.PKG_PLAT_LOG.P_RECORD_PLAT_LOG(P_COMPANY_ID         => V_COMPANY_ID,
                                             P_APPLY_MODULE       => 'a_return_101',
                                             P_BASE_TABLE         => 'T_RETURN_MANAGEMENT',
                                             P_APPLY_PK_ID        => V_RM_ID,
                                             P_ACTION_TYPE        => 'UPDATE',
                                             P_LOG_ID             => VO_LOG_ID,
                                             P_LOG_TYPE           => '01',
                                             P_FIELD_DESC         => '跟单',
                                             P_OPERATE_FIELD      => 'MERCHER_ID',
                                             P_FIELD_TYPE         => 'VARCHAR',
                                             P_OLD_CODE           => :OLD.MERCHER_ID,
                                             P_NEW_CODE           => :NEW.MERCHER_ID,
                                             P_OLD_VALUE          => V_OLD_FLW_ORDER,
                                             P_NEW_VALUE          => V_NEW_FLW_ORDER,
                                             P_MEMO               => '02',
                                             P_MEMO_DESC          => V_OLD_FLW_ORDER,
                                             P_USER_ID            => V_UPDATE_ID,
                                             P_OPERATE_COMPANY_ID => V_COMPANY_ID,
                                             P_SEQ_NO             => 1,
                                             PO_LOG_ID            => VO_LOG_ID);
    END IF;
    IF SCMDATA.PKG_PLAT_LOG.F_IS_CHECK_FIELDS_EQ(:OLD.MERCHER_DIRECTOR_ID,
                                                 :NEW.MERCHER_DIRECTOR_ID) = 0 THEN

      V_OLD_FLW_ORDER_MANAGER := SCMDATA.PKG_PLAT_COMM.F_GET_USERNAME(P_USER_ID    => :OLD.MERCHER_DIRECTOR_ID,
                                                                      P_IS_MUTIVAL => 1,
                                                                      P_SPILT      => ',');

      V_NEW_FLW_ORDER_MANAGER := SCMDATA.PKG_PLAT_COMM.F_GET_USERNAME(P_USER_ID    => :NEW.MERCHER_DIRECTOR_ID,
                                                                      P_IS_MUTIVAL => 1,
                                                                      P_SPILT      => ',');

      SCMDATA.PKG_PLAT_LOG.P_RECORD_PLAT_LOG(P_COMPANY_ID         => V_COMPANY_ID,
                                             P_APPLY_MODULE       => 'a_return_101',
                                             P_BASE_TABLE         => 'T_RETURN_MANAGEMENT',
                                             P_APPLY_PK_ID        => V_RM_ID,
                                             P_ACTION_TYPE        => 'UPDATE',
                                             P_LOG_ID             => VO_LOG_ID,
                                             P_LOG_TYPE           => '01',
                                             P_FIELD_DESC         => '跟单主管',
                                             P_OPERATE_FIELD      => 'MERCHER_DIRECTOR_ID',
                                             P_FIELD_TYPE         => 'VARCHAR',
                                             P_OLD_CODE           => :OLD.MERCHER_DIRECTOR_ID,
                                             P_NEW_CODE           => :NEW.MERCHER_DIRECTOR_ID,
                                             P_OLD_VALUE          => V_OLD_FLW_ORDER_MANAGER,
                                             P_NEW_VALUE          => V_NEW_FLW_ORDER_MANAGER,
                                             P_MEMO               => '02',
                                             P_MEMO_DESC          => V_OLD_FLW_ORDER_MANAGER,
                                             P_USER_ID            => V_UPDATE_ID,
                                             P_OPERATE_COMPANY_ID => V_COMPANY_ID,
                                             P_SEQ_NO             => 2,
                                             PO_LOG_ID            => VO_LOG_ID);
    END IF;
    IF VO_LOG_ID IS NOT NULL THEN
      SCMDATA.PKG_PLAT_LOG.P_UPDATE_PLAT_LOGMSG(P_COMPANY_ID        => V_COMPANY_ID,
                                                P_LOG_ID            => VO_LOG_ID,
                                                P_IS_LOGSMSG        => 1,
                                                P_IS_SPLICE_FIELDS  => 0,
                                                P_IS_SHOW_MEMO_DESC => 1);
    END IF;
  END GENDAN;

  --退货原因

  DECLARE
    V_OLD_RESPONSIBLE_DEPT     VARCHAR2(256);
    V_NEW_RESPONSIBLE_DEPT     VARCHAR2(256);
    V_OLD_RESPONSIBLE_DEPT_SEC VARCHAR2(256);
    V_NEW_RESPONSIBLE_DEPT_SEC VARCHAR2(256);
    V_YUANYIN_OLD              VARCHAR2(256);
    V_YUANYIN                  VARCHAR2(256);
  BEGIN
    IF :NEW.RM_TYPE <> :OLD.RM_TYPE THEN
      SCMDATA.PKG_PLAT_LOG.P_RECORD_PLAT_LOG(P_COMPANY_ID         => V_COMPANY_ID,
                                             P_APPLY_MODULE       => 'a_return_101',
                                             P_BASE_TABLE         => 'T_RETURN_MANAGEMENT',
                                             P_APPLY_PK_ID        => V_RM_ID,
                                             P_ACTION_TYPE        => 'UPDATE',
                                             P_LOG_ID             => VO_LOG_ID,
                                             P_LOG_TYPE           => '02',
                                             P_FIELD_DESC         => '批量/零星',
                                             P_OPERATE_FIELD      => 'RM_TYPE',
                                             P_FIELD_TYPE         => 'VARCHAR',
                                             P_OLD_CODE           => '',
                                             P_NEW_CODE           => '',
                                             P_OLD_VALUE          => :OLD.RM_TYPE,
                                             P_NEW_VALUE          => :NEW.RM_TYPE,
                                             P_MEMO               => '02',
                                             P_MEMO_DESC          => :OLD.RM_TYPE,
                                             P_USER_ID            => V_UPDATE_ID,
                                             P_OPERATE_COMPANY_ID => V_COMPANY_ID,
                                             P_SEQ_NO             => 1,
                                             PO_LOG_ID            => VO_LOG_ID);
    END IF;
    IF SCMDATA.PKG_PLAT_LOG.F_IS_CHECK_FIELDS_EQ(:OLD.CAUSE_DETAIL_ID,
                                                 :NEW.CAUSE_DETAIL_ID) = 0 THEN
      SELECT MAX(T.PROBLEM_CLASSIFICATION) || '-' ||
             MAX(T.CAUSE_CLASSIFICATION)
        INTO V_YUANYIN
        FROM SCMDATA.T_ABNORMAL_DTL_CONFIG T
       WHERE T.ABNORMAL_DTL_CONFIG_ID = :NEW.CAUSE_DETAIL_ID
         AND T.COMPANY_ID = V_COMPANY_ID;
      SELECT MAX(T.PROBLEM_CLASSIFICATION) || '-' ||
             MAX(T.CAUSE_CLASSIFICATION)
        INTO V_YUANYIN_OLD
        FROM SCMDATA.T_ABNORMAL_DTL_CONFIG T
       WHERE T.ABNORMAL_DTL_CONFIG_ID = :OLD.CAUSE_DETAIL_ID
         AND T.COMPANY_ID = V_COMPANY_ID;
      SCMDATA.PKG_PLAT_LOG.P_RECORD_PLAT_LOG(P_COMPANY_ID         => V_COMPANY_ID,
                                             P_APPLY_MODULE       => 'a_return_101',
                                             P_BASE_TABLE         => 'T_RETURN_MANAGEMENT',
                                             P_APPLY_PK_ID        => V_RM_ID,
                                             P_ACTION_TYPE        => 'UPDATE',
                                             P_LOG_ID             => VO_LOG_ID,
                                             P_LOG_TYPE           => '02',
                                             P_FIELD_DESC         => '退货原因',
                                             P_OPERATE_FIELD      => ' PROBLEM_DESC',
                                             P_FIELD_TYPE         => 'VARCHAR',
                                             P_OLD_CODE           => :OLD.CAUSE_DETAIL_ID,
                                             P_NEW_CODE           => :NEW.CAUSE_DETAIL_ID,
                                             P_OLD_VALUE          => V_YUANYIN_OLD,
                                             P_NEW_VALUE          => V_YUANYIN,
                                             P_MEMO               => '02',
                                             P_MEMO_DESC          => V_YUANYIN_OLD,
                                             P_USER_ID            => V_UPDATE_ID,
                                             P_OPERATE_COMPANY_ID => V_COMPANY_ID,
                                             P_SEQ_NO             => 2,
                                             PO_LOG_ID            => VO_LOG_ID);
    END IF;
    IF SCMDATA.PKG_PLAT_LOG.F_IS_CHECK_FIELDS_EQ(:OLD.PROBLEM_DEC,
                                                 :NEW.PROBLEM_DEC) = 0 THEN

      SCMDATA.PKG_PLAT_LOG.P_RECORD_PLAT_LOG(P_COMPANY_ID         => V_COMPANY_ID,
                                             P_APPLY_MODULE       => 'a_return_101',
                                             P_BASE_TABLE         => 'T_RETURN_MANAGEMENT',
                                             P_APPLY_PK_ID        => V_RM_ID,
                                             P_ACTION_TYPE        => 'UPDATE',
                                             P_LOG_ID             => VO_LOG_ID,
                                             P_LOG_TYPE           => '02',
                                             P_FIELD_DESC         => '问题描述',
                                             P_OPERATE_FIELD      => 'PROBLEM_DESC',
                                             P_FIELD_TYPE         => 'VARCHAR',
                                             P_OLD_CODE           => '',
                                             P_NEW_CODE           => '',
                                             P_OLD_VALUE          => :OLD.PROBLEM_DEC,
                                             P_NEW_VALUE          => :NEW.PROBLEM_DEC,
                                             P_MEMO               => '02',
                                             P_MEMO_DESC          => :OLD.PROBLEM_DEC,
                                             P_USER_ID            => V_UPDATE_ID,
                                             P_OPERATE_COMPANY_ID => V_COMPANY_ID,
                                             P_SEQ_NO             => 3,
                                             PO_LOG_ID            => VO_LOG_ID);
    END IF;

    --责任部门（1级）
    IF SCMDATA.PKG_PLAT_LOG.F_IS_CHECK_FIELDS_EQ(:OLD.FIRST_DEPT_ID,
                                                 :NEW.FIRST_DEPT_ID) = 0 THEN

      V_OLD_RESPONSIBLE_DEPT := SCMDATA.PKG_PLAT_COMM.F_GET_COMPANY_DEPTNAME(P_COMPANY_ID => V_COMPANY_ID,
                                                                             P_DEPT_ID    => :OLD.FIRST_DEPT_ID);
      V_NEW_RESPONSIBLE_DEPT := SCMDATA.PKG_PLAT_COMM.F_GET_COMPANY_DEPTNAME(P_COMPANY_ID => V_COMPANY_ID,
                                                                             P_DEPT_ID    => :NEW.FIRST_DEPT_ID);
      SCMDATA.PKG_PLAT_LOG.P_RECORD_PLAT_LOG(P_COMPANY_ID         => V_COMPANY_ID,
                                             P_APPLY_MODULE       => 'a_return_101',
                                             P_BASE_TABLE         => 'T_RETURN_MANAGEMENT',
                                             P_APPLY_PK_ID        => V_RM_ID,
                                             P_ACTION_TYPE        => 'UPDATE',
                                             P_LOG_ID             => VO_LOG_ID,
                                             P_LOG_TYPE           => '02',
                                             P_FIELD_DESC         => '责任部门（1级）',
                                             P_OPERATE_FIELD      => 'FIRST_DEPT_ID',
                                             P_FIELD_TYPE         => 'VARCHAR',
                                             P_OLD_CODE           => :OLD.FIRST_DEPT_ID,
                                             P_NEW_CODE           => :NEW.FIRST_DEPT_ID,
                                             P_OLD_VALUE          => V_OLD_RESPONSIBLE_DEPT,
                                             P_NEW_VALUE          => V_NEW_RESPONSIBLE_DEPT,
                                             P_MEMO               => '02',
                                             P_MEMO_DESC          => V_OLD_RESPONSIBLE_DEPT,
                                             P_USER_ID            => V_UPDATE_ID,
                                             P_OPERATE_COMPANY_ID => V_COMPANY_ID,
                                             P_SEQ_NO             => 4,
                                             PO_LOG_ID            => VO_LOG_ID);

    END IF;

    --责任部门（2级）
    IF SCMDATA.PKG_PLAT_LOG.F_IS_CHECK_FIELDS_EQ(:OLD.SECOND_DEPT_ID,
                                                 :NEW.SECOND_DEPT_ID) = 0 THEN

      V_OLD_RESPONSIBLE_DEPT_SEC := SCMDATA.PKG_PLAT_COMM.F_GET_COMPANY_DEPTNAME(P_COMPANY_ID => V_COMPANY_ID,
                                                                                 P_DEPT_ID    => :OLD.SECOND_DEPT_ID);
      V_NEW_RESPONSIBLE_DEPT_SEC := SCMDATA.PKG_PLAT_COMM.F_GET_COMPANY_DEPTNAME(P_COMPANY_ID => V_COMPANY_ID,
                                                                                 P_DEPT_ID    => :NEW.SECOND_DEPT_ID);
      SCMDATA.PKG_PLAT_LOG.P_RECORD_PLAT_LOG(P_COMPANY_ID         => V_COMPANY_ID,
                                             P_APPLY_MODULE       => 'a_return_101',
                                             P_BASE_TABLE         => 'T_RETURN_MANAGEMENT',
                                             P_APPLY_PK_ID        => V_RM_ID,
                                             P_ACTION_TYPE        => 'UPDATE',
                                             P_LOG_ID             => VO_LOG_ID,
                                             P_LOG_TYPE           => '02',
                                             P_FIELD_DESC         => '责任部门（2级）',
                                             P_OPERATE_FIELD      => 'SECOND_DEPT_ID',
                                             P_FIELD_TYPE         => 'VARCHAR',
                                             P_OLD_CODE           => :OLD.SECOND_DEPT_ID,
                                             P_NEW_CODE           => :NEW.SECOND_DEPT_ID,
                                             P_OLD_VALUE          => V_OLD_RESPONSIBLE_DEPT_SEC,
                                             P_NEW_VALUE          => V_NEW_RESPONSIBLE_DEPT_SEC,
                                             P_MEMO               => '02',
                                             P_MEMO_DESC          => V_OLD_RESPONSIBLE_DEPT_SEC,
                                             P_USER_ID            => V_UPDATE_ID,
                                             P_OPERATE_COMPANY_ID => V_COMPANY_ID,
                                             P_SEQ_NO             => 5,
                                             PO_LOG_ID            => VO_LOG_ID);
    END IF;

    IF SCMDATA.PKG_PLAT_LOG.F_IS_CHECK_FIELDS_EQ(:OLD.MEMO, :NEW.MEMO) = 0 THEN

      SCMDATA.PKG_PLAT_LOG.P_RECORD_PLAT_LOG(P_COMPANY_ID         => V_COMPANY_ID,
                                             P_APPLY_MODULE       => 'a_return_101',
                                             P_BASE_TABLE         => 'T_RETURN_MANAGEMENT',
                                             P_APPLY_PK_ID        => V_RM_ID,
                                             P_ACTION_TYPE        => 'UPDATE',
                                             P_LOG_ID             => VO_LOG_ID,
                                             P_LOG_TYPE           => '02',
                                             P_FIELD_DESC         => '备注',
                                             P_OPERATE_FIELD      => 'MEMO',
                                             P_FIELD_TYPE         => 'VARCHAR',
                                             P_OLD_CODE           => '',
                                             P_NEW_CODE           => '',
                                             P_OLD_VALUE          => :OLD.MEMO,
                                             P_NEW_VALUE          => :NEW.MEMO,
                                             P_MEMO               => '02',
                                             P_MEMO_DESC          => :OLD.MEMO,
                                             P_USER_ID            => V_UPDATE_ID,
                                             P_OPERATE_COMPANY_ID => V_COMPANY_ID,
                                             P_SEQ_NO             => 6,
                                             PO_LOG_ID            => VO_LOG_ID);
    END IF;
    IF VO_LOG_ID IS NOT NULL THEN
      SCMDATA.PKG_PLAT_LOG.P_UPDATE_PLAT_LOGMSG(P_COMPANY_ID        => V_COMPANY_ID,
                                                P_LOG_ID            => VO_LOG_ID,
                                                P_IS_LOGSMSG        => 1,
                                                P_IS_SPLICE_FIELDS  => 0,
                                                P_IS_SHOW_MEMO_DESC => 1);
    END IF;
  END RETURN_CAUSE;

END TRG_AF_U_T_RETURN_MANAGEMENT;
/

