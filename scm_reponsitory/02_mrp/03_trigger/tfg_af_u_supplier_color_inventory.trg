CREATE OR REPLACE TRIGGER MRP.TFG_AF_U_SUPPLIER_COLOR_INVENTORY
AFTER UPDATE OF REMARKS ON SUPPLIER_COLOR_INVENTORY
FOR EACH ROW

DECLARE
 --v_supp_id          VARCHAR2(32) ;
 --v_operate          VARCHAR2(32) ;
 v_company_id       VARCHAR2(32) := 'b6cc680ad0f599cde0531164a8c0337f';
 V_LOG_MSG          VARCHAR2(4000);
 vo_log_id          VARCHAR2(32) ;
BEGIN

 --V_SUPP_ID :=PLM.Pkg_Outside_Material.F_GET_SUPCOM_ID(V_SUPINFO_ID => :NEW.PRO_SUPPLIER_CODE, V_NEED_COMPID =>v_company_id  );

 --操作人企业id
 /*SELECT a.company_id INTO v_operate 
   FROM SCMDATA.SYS_COMPANY_USER A 
  INNER JOIN SCMDATA.SYS_USER_COMPANY B ON A.COMPANY_ID=B.COMPANY_ID AND A.USER_ID=B.USER_ID
  WHERE A.USER_ID=:new.update_id AND a.pause=0 AND b.pause=0
  AND (A.COMPANY_ID =:NEW.COMPANY_ID OR A.COMPANY_ID= V_SUPP_ID );*/
 

  IF NVL(:NEW.REMARKS,1) <> NVL(:OLD.REMARKS,1) THEN
      scmdata.pkg_plat_log.p_record_plat_log(p_company_id         => v_company_id,
                                             p_apply_module       => 'a_prematerial_121',
                                             p_base_table         => 'SUPPLIER_COLOR_INVENTORY',
                                             p_apply_pk_id        => :NEW.INVENTORY_CODE,
                                             p_action_type        => 'UPDATE',
                                             p_log_id             => vo_log_id,
                                             p_log_type           => '01',
                                             p_field_desc         => '盘点备注 ',
                                             p_operate_field      => 'REMARKS',
                                             p_field_type         => 'VARCHAR',
                                             p_old_code           => '',
                                             p_new_code           => '',
                                             p_old_value          => :OLD.REMARKS,
                                             p_new_value          => :NEW.REMARKS,
                                             p_memo               => '02',
                                             p_memo_desc          => :OLD.REMARKS,
                                             p_user_id            => :new.update_id,
                                             p_operate_company_id => :NEW.UPDATE_COMPANY_ID,
                                             p_seq_no             => 1,
                                             po_log_id            => vo_log_id);
 
 --拼接日志明细
    IF vo_log_id IS NOT NULL THEN
      scmdata.pkg_plat_log.p_update_plat_logmsg(p_company_id        => v_company_id,
                                                p_log_id            => vo_log_id,
                                                p_is_logsmsg        => 1,
                                                p_is_splice_fields  => 0,
                                                p_is_show_memo_desc => 1);
    END IF;


  SELECT T.LOG_MSG INTO V_LOG_MSG
    FROM SCMDATA.T_PLAT_LOG T
    WHERE T.LOG_ID=  vo_log_id;


    scmdata.pkg_plat_log.p_insert_plat_log_to_plm_or_mrp(p_log_id      => vo_log_id,
                                                         p_log_msg     => V_LOG_MSG,
                                                         p_class_name  => 'SCM供应商色布盘点单',
                                                         p_method_name => '编辑盘点备注',
                                                         p_type        =>2 );


  ELSE
    NULL;
  END IF;



END;
/

