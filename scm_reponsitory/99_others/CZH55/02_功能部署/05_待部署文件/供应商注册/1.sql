prompt Importing table bw3.sys_element...
set feedback off
set define off

insert into bw3.sys_element (ELEMENT_ID, ELEMENT_TYPE, DATA_SOURCE, PAUSE, MESSAGE, IS_HIDE, MEMO, IS_ASYNC, IS_PER_EXE, ENABLE_STAND_PERMISSION)
values ('action_a_supp_regist', 'action', 'oracle_scmdata', 0, null, null, null, null, null, null);

prompt Done.
