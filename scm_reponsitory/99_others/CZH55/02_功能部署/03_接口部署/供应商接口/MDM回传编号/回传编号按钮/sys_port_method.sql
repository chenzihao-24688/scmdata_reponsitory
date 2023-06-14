declare
begin
delete from bw3.sys_port_method t where t.METHOD_ID = 'method_a_supp_110_9';

insert into bw3.sys_port_method (METHOD_ID, PORT_NAME, METHOD_NAME, REQ_PARAM, RESP_PARAM, FIXED_PARAM, ERR_PARAM, METHOD_TYPE, PARAM_FORMAT, SUCCESS_PARAM)
values ('method_a_supp_110_9', 'port_a_supp_110_9', 'get_mdm_supp_code', null, null, '{"servicePath":"/open/view/mdm_supp_select"}', null, 'post', 'json', null);

end;
