prompt PL/SQL Developer Export User Objects for user PLM@ORCL_SCMTEST
prompt Created by SANFU on 2023年6月15日
set define off
spool 20230614_table.log

prompt
prompt Creating package PKG_GOOD_RELA_PLM
prompt ==================================
prompt
@@pkg_good_rela_plm.pck
prompt
prompt Creating package PKG_OUTSIDE_MATERIAL
prompt =====================================
prompt
@@pkg_outside_material.pck
prompt
prompt Creating package PKG_PLAT_COMM
prompt ==============================
prompt
@@pkg_plat_comm.pck
prompt
prompt Creating package PKG_QUOTATION
prompt ==============================
prompt
@@pkg_quotation.pck

prompt Done
spool off
set define on
