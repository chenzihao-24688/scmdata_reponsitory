???prompt Importing table nbw.sys_port_http...
set feedback off
set define off
insert into nbw.sys_port_http (PORT_NAME, URL, ACTION_TAG, APP_KEY, APP_SECRET, TOKEN_SQL, PORT_TYPE)
values ('port_a_supp_110_9', 'http://172.28.40.45:8080/lion/app_sanfu_retail/api/v1', 0, 'scm_supp_code_key', 'scm_supp_code_secret', null, 43);

prompt Done.
