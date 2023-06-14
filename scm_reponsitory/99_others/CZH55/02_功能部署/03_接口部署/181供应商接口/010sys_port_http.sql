prompt Importing table bwptest1.sys_port_http...
set feedback off
set define off
insert into bwptest1.sys_port_http (PORT_NAME, URL, ACTION_TAG, APP_KEY, APP_SECRET, TOKEN_SQL, PORT_TYPE)
values ('port_itf_a_supp_140', 'http://172.28.40.62:9090/lion/scm/api/v1', 0, 'a_supp_140_key', 'a_supp_140_secret', null, 43);

insert into bwptest1.sys_port_http (PORT_NAME, URL, ACTION_TAG, APP_KEY, APP_SECRET, TOKEN_SQL, PORT_TYPE)
values ('port_itf_a_supp_141', 'http://172.28.40.62:9090/lion/scm/api/v1', 0, 'a_supp_scope_key', 'a_supp_scope_secret', null, 43);

prompt Done.
