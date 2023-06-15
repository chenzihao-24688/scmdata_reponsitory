prompt PL/SQL Developer Export User Objects for user SCMDATA@ORCL_SCMTEST
prompt Created by SANFU on 2023年6月15日
set define off
spool 20230614_table.log

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
prompt Creating procedure P_PRINT_CLOB_INTO_CONSOLE
prompt ============================================
prompt
@@p_print_clob_into_console.prc

prompt Done
spool off
set define on
