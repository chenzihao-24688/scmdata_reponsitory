prompt PL/SQL Developer Export User Objects for user SCMDATA@DEV_SCM
prompt Created by SANFU on 2023年6月14日
set define off
spool 20230614_view.log

prompt
prompt Creating view AQ$DEMO_QUEUE_TABLE
prompt =================================
prompt
@@aq$demo_queue_table.vw
prompt
prompt Creating view AQ$DEMO_QUEUE_TABLE_R
prompt ===================================
prompt
@@aq$demo_queue_table_r.vw
prompt
prompt Creating view AQ$DEMO_QUEUE_TABLE_S
prompt ===================================
prompt
@@aq$demo_queue_table_s.vw
prompt
prompt Creating view AQ$_DEMO_QUEUE_TABLE_F
prompt ====================================
prompt
@@aq$_demo_queue_table_f.vw
prompt
prompt Creating view V_ORDER_QCANDQCMANAGER_INFO
prompt =========================================
prompt
@@v_order_qcandqcmanager_info.vw
prompt
prompt Creating view V_ORDER_QCANDQCMANAGER_INFO1
prompt ==========================================
prompt
@@v_order_qcandqcmanager_info1.vw
prompt
prompt Creating view V_PRODUCT_PROGRESS_STATUS
prompt =======================================
prompt
@@v_product_progress_status.vw
prompt
prompt Creating view V_PRODUCT_PROGRESS_STATUS_SEQ
prompt ===========================================
prompt
@@v_product_progress_status_seq.vw
prompt
prompt Creating view V_SUP_LOCANDGROUPINFO
prompt ===================================
prompt
@@v_sup_locandgroupinfo.vw

prompt Done
spool off
set define on
