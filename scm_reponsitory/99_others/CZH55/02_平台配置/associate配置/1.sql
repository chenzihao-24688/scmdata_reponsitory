???prompt Importing table nbw.sys_element...
set feedback off
set define off
insert into nbw.sys_element (ELEMENT_ID, ELEMENT_TYPE, DATA_SOURCE, PAUSE, MESSAGE, IS_HIDE, MEMO, IS_ASYNC, IS_PER_EXE)
values ('associate_a_supp_150_2', 'associate', 'oracle_scmdata', 0, null, null, null, null, null);

insert into nbw.sys_element (ELEMENT_ID, ELEMENT_TYPE, DATA_SOURCE, PAUSE, MESSAGE, IS_HIDE, MEMO, IS_ASYNC, IS_PER_EXE)
values ('associate_g_540_1', 'associate', 'scm_nbw', 0, null, 1, null, null, null);

prompt Done.
