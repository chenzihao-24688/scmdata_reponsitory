prompt PL/SQL Developer Export User Objects for user MRP@ORCL_SCMTEST
prompt Created by SANFU on 2023年6月15日
set define off
spool 20230614_table.log

prompt
prompt Creating view V_COLOR_PREPARE_ORDER
prompt ===================================
prompt
@@v_color_prepare_order.vw

prompt Done
spool off
set define on
