prompt PL/SQL Developer Export User Objects for user PLM@ORCL_SCMTEST
prompt Created by SANFU on 2023年6月15日
set define off
spool 20230614_table.log

prompt
prompt Creating sequence SEQ_MRPPIC_ID
prompt ===============================
prompt
@@seq_mrppic_id.seq
prompt
prompt Creating sequence SEQ_OUTMATERIAL_ID
prompt ====================================
prompt
@@seq_outmaterial_id.seq

prompt Done
spool off
set define on
