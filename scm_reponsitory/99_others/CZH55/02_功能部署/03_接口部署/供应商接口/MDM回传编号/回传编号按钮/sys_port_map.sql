declare
begin
delete from bw3.sys_port_http t where t.PORT_NAME = 'port_a_supp_110_9';

insert into bw3.sys_port_map (PORT_NAME, FIELD_NAME, PATH_NAME, AS_ARRAY, DEFAULT_VALUE, SEQNO, METHOD_ID, IS_REQUIRE, TYPE)
values ('port_a_supp_110_9', 'batch_id', 'batch_id', 0, null, 110, 'method_a_supp_110_9', 0, 'req_path');

insert into bw3.sys_port_map (PORT_NAME, FIELD_NAME, PATH_NAME, AS_ARRAY, DEFAULT_VALUE, SEQNO, METHOD_ID, IS_REQUIRE, TYPE)
values ('port_a_supp_110_9', 'code', 'code', 0, null, 110, 'method_a_supp_110_9', 0, 'resp');

insert into bw3.sys_port_map (PORT_NAME, FIELD_NAME, PATH_NAME, AS_ARRAY, DEFAULT_VALUE, SEQNO, METHOD_ID, IS_REQUIRE, TYPE)
values ('port_a_supp_110_9', 'data', 'data', 0, null, 110, 'method_a_supp_110_9', 0, 'resp');

insert into bw3.sys_port_map (PORT_NAME, FIELD_NAME, PATH_NAME, AS_ARRAY, DEFAULT_VALUE, SEQNO, METHOD_ID, IS_REQUIRE, TYPE)
values ('port_a_supp_110_9', 'errCode', 'errCode', 0, null, 110, 'method_a_supp_110_9', 0, 'resp');

insert into bw3.sys_port_map (PORT_NAME, FIELD_NAME, PATH_NAME, AS_ARRAY, DEFAULT_VALUE, SEQNO, METHOD_ID, IS_REQUIRE, TYPE)
values ('port_a_supp_110_9', 'fet_flag', 'fet_flag', 0, null, 110, 'method_a_supp_110_9', 0, 'req_path');

insert into bw3.sys_port_map (PORT_NAME, FIELD_NAME, PATH_NAME, AS_ARRAY, DEFAULT_VALUE, SEQNO, METHOD_ID, IS_REQUIRE, TYPE)
values ('port_a_supp_110_9', 'fet_time', 'fet_time', 0, null, 110, 'method_a_supp_110_9', 0, 'req_path');

insert into bw3.sys_port_map (PORT_NAME, FIELD_NAME, PATH_NAME, AS_ARRAY, DEFAULT_VALUE, SEQNO, METHOD_ID, IS_REQUIRE, TYPE)
values ('port_a_supp_110_9', 'msg', 'msg', 0, null, 110, 'method_a_supp_110_9', 0, 'resp');

insert into bw3.sys_port_map (PORT_NAME, FIELD_NAME, PATH_NAME, AS_ARRAY, DEFAULT_VALUE, SEQNO, METHOD_ID, IS_REQUIRE, TYPE)
values ('port_a_supp_110_9', 'send_flag', 'send_flag', 0, null, 110, 'method_a_supp_110_9', 0, 'req_path');

insert into bw3.sys_port_map (PORT_NAME, FIELD_NAME, PATH_NAME, AS_ARRAY, DEFAULT_VALUE, SEQNO, METHOD_ID, IS_REQUIRE, TYPE)
values ('port_a_supp_110_9', 'send_time', 'send_time', 0, null, 110, 'method_a_supp_110_9', 0, 'req_path');

insert into bw3.sys_port_map (PORT_NAME, FIELD_NAME, PATH_NAME, AS_ARRAY, DEFAULT_VALUE, SEQNO, METHOD_ID, IS_REQUIRE, TYPE)
values ('port_a_supp_110_9', 'type', 'type', 0, null, 110, 'method_a_supp_110_9', 0, 'resp');

end;
