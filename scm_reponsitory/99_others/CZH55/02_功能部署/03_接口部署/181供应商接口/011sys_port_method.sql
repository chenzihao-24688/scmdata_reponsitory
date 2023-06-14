prompt Importing table bwptest1.sys_port_method...
set feedback off
set define off
insert into bwptest1.sys_port_method (METHOD_ID, PORT_NAME, METHOD_NAME, REQ_PARAM, RESP_PARAM, FIXED_PARAM, ERR_PARAM, METHOD_TYPE, PARAM_FORMAT, SUCCESS_PARAM)
values ('method_itf_a_supp_141', 'port_itf_a_supp_141', 'get_supp_scope_data', null, null, '{"servicePath":"/open/view/a_supp_scope"}', null, 'post', 'json', null);

insert into bwptest1.sys_port_method (METHOD_ID, PORT_NAME, METHOD_NAME, REQ_PARAM, RESP_PARAM, FIXED_PARAM, ERR_PARAM, METHOD_TYPE, PARAM_FORMAT, SUCCESS_PARAM)
values ('method_itf_a_supp_140', 'port_itf_a_supp_140', 'get_supp_data', null, null, '{"servicePath":"/open/view/supp_140"}', null, 'post', 'json', null);

prompt Done.
