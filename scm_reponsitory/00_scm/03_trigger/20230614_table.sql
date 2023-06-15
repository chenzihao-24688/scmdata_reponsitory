prompt PL/SQL Developer Export User Objects for user SCMDATA@ORCL_SCMTEST
prompt Created by SANFU on 2023年6月15日
set define off
spool 20230614_table.log

prompt
prompt Creating trigger SF_SYS_USER_TRI
prompt ================================
prompt
@@sf_sys_user_tri.trg
prompt
prompt Creating trigger TRGAFINTCOMPANY
prompt ================================
prompt
@@trgafintcompany.trg
prompt
prompt Creating trigger TRGBFDELCOMPANY_ROLE
prompt =====================================
prompt
@@trgbfdelcompany_role.trg
prompt
prompt Creating trigger TRGBFINT_COMPANY_APPLY_SEE
prompt ===========================================
prompt
@@trgbfint_company_apply_see.trg
prompt
prompt Creating trigger TRGBFUDCOMPANY_ROLE
prompt ====================================
prompt
@@trgbfudcompany_role.trg
prompt
prompt Creating trigger TRG_AFU_SENDORDERS
prompt ===================================
prompt
@@trg_afu_sendorders.trg
prompt
prompt Creating trigger TRG_AF_FINISH_T_ORDERED_FOR_QC
prompt ===============================================
prompt
@@trg_af_finish_t_ordered_for_qc.trg
prompt
prompt Creating trigger TRG_AF_IUD_SYS_COMPANY_USER_DEPT_FOR_QC
prompt ========================================================
prompt
@@trg_af_iud_sys_company_user_dept_for_qc.trg
prompt
prompt Creating trigger TRG_AF_IUD_SYS_COMPANY_USER_FOR_QC
prompt ===================================================
prompt
@@trg_af_iud_sys_company_user_for_qc.trg
prompt
prompt Creating trigger TRG_AF_IU_T_ORDERED
prompt ====================================
prompt
@@trg_af_iu_t_ordered.trg
prompt
prompt Creating trigger TRG_AF_IU_T_ORDERS
prompt ===================================
prompt
@@trg_af_iu_t_orders.trg
prompt
prompt Creating trigger TRG_AF_I_SYS_APP_PRIVILEGE
prompt ===========================================
prompt
@@trg_af_i_sys_app_privilege.trg
prompt
prompt Creating trigger TRG_AF_PT_ORDERED
prompt ==================================
prompt
@@trg_af_pt_ordered.trg
prompt
prompt Creating trigger TRG_AF_UPDATE_COMMODITY_INFO
prompt =============================================
prompt
@@trg_af_update_commodity_info.trg
prompt
prompt Creating trigger TRG_AF_UPDATE_COMPANY_USER
prompt ===========================================
prompt
@@trg_af_update_company_user.trg
prompt
prompt Creating trigger TRG_AF_U_T_PRODUCTION_PROGRESS
prompt ===============================================
prompt
@@trg_af_u_t_production_progress.trg
prompt
prompt Creating trigger TRG_AF_U_T_RETURN_MANAGEMENT
prompt =============================================
prompt
@@trg_af_u_t_return_management.trg
prompt
prompt Creating trigger TRG_BF_DEL_T_MATERIAL_RECORD
prompt =============================================
prompt
@@trg_bf_del_t_material_record.trg
prompt
prompt Creating trigger TRG_BF_DEL_T_MATERIAL_RECORD_ITEM
prompt ==================================================
prompt
@@trg_bf_del_t_material_record_item.trg
prompt
prompt Creating trigger TRG_BF_INSERTORUPDATE_T_COOP_SCOPE
prompt ===================================================
prompt
@@trg_bf_insertorupdate_t_coop_scope.trg
prompt
prompt Creating trigger TRG_BF_INSERT_T_ASK_SCOPE
prompt ==========================================
prompt
@@trg_bf_insert_t_ask_scope.trg
prompt
prompt Creating trigger TRG_BF_IU_T_COOP_FACTORY
prompt =========================================
prompt
@@trg_bf_iu_t_coop_factory.trg
prompt
prompt Creating trigger TRG_BF_IU_T_COOP_SCOPE
prompt =======================================
prompt
@@trg_bf_iu_t_coop_scope.trg
prompt
prompt Creating trigger TRG_BF_I_T_FABRIC_EVALUATE
prompt ===========================================
prompt
@@trg_bf_i_t_fabric_evaluate.trg
prompt
prompt Creating trigger TRG_BF_I_T_PRODUCTION_PROGRESS
prompt ===============================================
prompt
@@trg_bf_i_t_production_progress.trg
prompt
prompt Creating trigger TRG_BF_PT_ORDERDS_BYFILEDS
prompt ===========================================
prompt
@@trg_bf_pt_orderds_byfileds.trg
prompt
prompt Creating trigger TRG_BF_UPDATE_SYS_COMPANY_PERSON_WECOM_MSG
prompt ===========================================================
prompt
@@trg_bf_update_sys_company_person_wecom_msg.trg
prompt
prompt Creating trigger TRG_BF_UPDATE_T_ASK_SCOPE
prompt ==========================================
prompt
@@trg_bf_update_t_ask_scope.trg
prompt
prompt Creating trigger TRG_BF_U_T_SUPPLIER_INFO
prompt =========================================
prompt
@@trg_bf_u_t_supplier_info.trg
prompt
prompt Creating trigger TRG_BF_U_T_SUPPLIER_INFO_A
prompt ===========================================
prompt
@@trg_bf_u_t_supplier_info_a.trg
prompt
prompt Creating trigger TRG_SYS_FIELD_LIST_WMSITF_LIMIT
prompt ================================================
prompt
@@trg_sys_field_list_wmsitf_limit.trg
prompt
prompt Creating trigger TRG_TRIAL_ORDER_REPORT_SEND_WX
prompt ===============================================
prompt
@@trg_trial_order_report_send_wx.trg
prompt
prompt Creating trigger TRG_U_T_ORDERED
prompt ================================
prompt
@@trg_u_t_ordered.trg
prompt
prompt Creating trigger TRG_U_T_ORDERS
prompt ===============================
prompt
@@trg_u_t_orders.trg
prompt
prompt Creating trigger TR_BF_D_SYS_APP_PRIVILEGE
prompt ==========================================
prompt
@@tr_bf_d_sys_app_privilege.trg
prompt
prompt Creating trigger TR_BF_D_SYS_APP_ROLE
prompt =====================================
prompt
@@tr_bf_d_sys_app_role.trg
prompt
prompt Creating trigger T_ORDER_FACCODE_AFTER_UPDATE
prompt =============================================
prompt
@@t_order_faccode_after_update.trg

prompt Done
spool off
set define on
