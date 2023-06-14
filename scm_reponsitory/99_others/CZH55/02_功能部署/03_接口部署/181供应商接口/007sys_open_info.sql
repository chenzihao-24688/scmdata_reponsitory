prompt Importing table bwptest1.sys_open_info...
set feedback off
set define off
insert into bwptest1.sys_open_info (OPEN_ID, APP_KEY, APP_SECRET, GLOBAL_SQL)
values ('open_scm_supp_code', 'scm_supp_code_key', 'scm_supp_code_secret', null);

prompt Done.
