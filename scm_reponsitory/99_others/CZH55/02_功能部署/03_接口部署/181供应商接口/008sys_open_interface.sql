prompt Importing table bwptest1.sys_open_interface...
set feedback off
set define off
insert into bwptest1.sys_open_interface (OPEN_ID, MODULE_NAME, OPER_TYPE, ITEM_ID, REQ_SQL, TB_ID)
values ('open_scm_supp_code', 'mdm_supp_select', 3, 'itf_a_supp_140', null, 12);

prompt Done.
