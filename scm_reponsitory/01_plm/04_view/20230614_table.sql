prompt PL/SQL Developer Export User Objects for user PLM@ORCL_SCMTEST
prompt Created by SANFU on 2023年6月15日
set define off
spool 20230614_table.log

prompt
prompt Creating view V_PLM_QUOTATION_CLASS
prompt ===================================
prompt
@@v_plm_quotation_class.vw

prompt Done
spool off
set define on
