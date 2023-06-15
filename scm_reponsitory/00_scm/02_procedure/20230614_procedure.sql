prompt PL/SQL Developer Export User Objects for user SCMDATA@DEV_SCM
prompt Created by SANFU on 2023年6月14日
set define off
spool 20230614_procedure.log

prompt
prompt Creating procedure CHECK_IMPORT_CONSTRACT_CS
prompt ============================================
prompt
@@check_import_constract_cs.prc
prompt
prompt Creating procedure P_INSERT_SUPPLIER_INFO
prompt =========================================
prompt
@@p_insert_supplier_info.prc
prompt
prompt Creating procedure CREATE_T_SUPPLIER_INFO_CS
prompt ============================================
prompt
@@create_t_supplier_info_cs.prc
prompt
prompt Creating procedure DEMO_QUEUE_CALLBACK_PROCEDURE
prompt ================================================
prompt
@@demo_queue_callback_procedure.prc
prompt
prompt Creating procedure PGETGLOBALPARAMSSQL_PLAT
prompt ===========================================
prompt
@@pgetglobalparamssql_plat.prc
prompt
prompt Creating procedure PTESTGETGLOBALPARAMSSQL
prompt ==========================================
prompt
@@ptestgetglobalparamssql.prc
prompt
prompt Creating procedure P_INSERT_RM
prompt ==============================
prompt
@@p_insert_rm.prc
prompt
prompt Creating procedure P_PRINT_CLOB_INTO_CONSOLE
prompt ============================================
prompt
@@p_print_clob_into_console.prc
prompt
prompt Creating procedure P_RETURN_PLAN_MSG
prompt ====================================
prompt
@@p_return_plan_msg.prc
prompt
prompt Creating procedure P_SEND_WX_MSG
prompt ================================
prompt
@@p_send_wx_msg.prc
prompt
prompt Creating procedure P_T_KPIORDER_QU_HALFYEAR
prompt ===========================================
prompt
@@p_t_kpiorder_qu_halfyear.prc
prompt
prompt Creating procedure P_T_KPIORDER_QU_MONTH
prompt ========================================
prompt
@@p_t_kpiorder_qu_month.prc
prompt
prompt Creating procedure P_T_KPIORDER_QU_QUARTER
prompt ==========================================
prompt
@@p_t_kpiorder_qu_quarter.prc
prompt
prompt Creating procedure P_T_KPIORDER_QU_YEAR
prompt =======================================
prompt
@@p_t_kpiorder_qu_year.prc
prompt
prompt Creating procedure SUBMIT_T_CONTRACT_INFO_CS
prompt ============================================
prompt
@@submit_t_contract_info_cs.prc
prompt
prompt Creating procedure UPDATE_SUPPLIER_INFO_CS
prompt ==========================================
prompt
@@update_supplier_info_cs.prc

prompt Done
spool off
set define on
