declare
begin
delete  from bw3.sys_port_submap t where t.seqno = 100;

insert into bw3.sys_port_submap (FIELD_NAME, CONVERT_NAME, DEFAULT_VALUE, PARENT_FIELD_NAME, SEQNO, IS_REQUIRE)
values ('return_msg', 'return_msg', null, 'data', 100, 0);

insert into bw3.sys_port_submap (FIELD_NAME, CONVERT_NAME, DEFAULT_VALUE, PARENT_FIELD_NAME, SEQNO, IS_REQUIRE)
values ('create_id', 'create_id', null, 'data', 100, 0);

insert into bw3.sys_port_submap (FIELD_NAME, CONVERT_NAME, DEFAULT_VALUE, PARENT_FIELD_NAME, SEQNO, IS_REQUIRE)
values ('create_time', 'create_time', null, 'data', 100, 0);

insert into bw3.sys_port_submap (FIELD_NAME, CONVERT_NAME, DEFAULT_VALUE, PARENT_FIELD_NAME, SEQNO, IS_REQUIRE)
values ('update_id', 'update_id', null, 'data', 100, 0);

insert into bw3.sys_port_submap (FIELD_NAME, CONVERT_NAME, DEFAULT_VALUE, PARENT_FIELD_NAME, SEQNO, IS_REQUIRE)
values ('ctl_id', 'ctl_id', null, 'data', 100, 0);

insert into bw3.sys_port_submap (FIELD_NAME, CONVERT_NAME, DEFAULT_VALUE, PARENT_FIELD_NAME, SEQNO, IS_REQUIRE)
values ('itf_id', 'itf_id', null, 'data', 100, 0);

insert into bw3.sys_port_submap (FIELD_NAME, CONVERT_NAME, DEFAULT_VALUE, PARENT_FIELD_NAME, SEQNO, IS_REQUIRE)
values ('itf_type', 'itf_type', null, 'data', 100, 0);

insert into bw3.sys_port_submap (FIELD_NAME, CONVERT_NAME, DEFAULT_VALUE, PARENT_FIELD_NAME, SEQNO, IS_REQUIRE)
values ('batch_id', 'batch_id', null, 'data', 100, 0);

insert into bw3.sys_port_submap (FIELD_NAME, CONVERT_NAME, DEFAULT_VALUE, PARENT_FIELD_NAME, SEQNO, IS_REQUIRE)
values ('batch_num', 'batch_num', null, 'data', 100, 0);

insert into bw3.sys_port_submap (FIELD_NAME, CONVERT_NAME, DEFAULT_VALUE, PARENT_FIELD_NAME, SEQNO, IS_REQUIRE)
values ('batch_time', 'batch_time', null, 'data', 100, 0);

insert into bw3.sys_port_submap (FIELD_NAME, CONVERT_NAME, DEFAULT_VALUE, PARENT_FIELD_NAME, SEQNO, IS_REQUIRE)
values ('sender', 'sender', null, 'data', 100, 0);

insert into bw3.sys_port_submap (FIELD_NAME, CONVERT_NAME, DEFAULT_VALUE, PARENT_FIELD_NAME, SEQNO, IS_REQUIRE)
values ('receiver', 'receiver', null, 'data', 100, 0);

insert into bw3.sys_port_submap (FIELD_NAME, CONVERT_NAME, DEFAULT_VALUE, PARENT_FIELD_NAME, SEQNO, IS_REQUIRE)
values ('receive_time', 'receive_time', null, 'data', 100, 0);

insert into bw3.sys_port_submap (FIELD_NAME, CONVERT_NAME, DEFAULT_VALUE, PARENT_FIELD_NAME, SEQNO, IS_REQUIRE)
values ('return_type', 'return_type', null, 'data', 100, 0);

insert into bw3.sys_port_submap (FIELD_NAME, CONVERT_NAME, DEFAULT_VALUE, PARENT_FIELD_NAME, SEQNO, IS_REQUIRE)
values ('update_time', 'update_time', null, 'data', 100, 0);

insert into bw3.sys_port_submap (FIELD_NAME, CONVERT_NAME, DEFAULT_VALUE, PARENT_FIELD_NAME, SEQNO, IS_REQUIRE)
values ('send_flag', 'send_flag', null, 'data', 100, 0);

insert into bw3.sys_port_submap (FIELD_NAME, CONVERT_NAME, DEFAULT_VALUE, PARENT_FIELD_NAME, SEQNO, IS_REQUIRE)
values ('fet_flag', 'fet_flag', null, 'data', 100, 0);

insert into bw3.sys_port_submap (FIELD_NAME, CONVERT_NAME, DEFAULT_VALUE, PARENT_FIELD_NAME, SEQNO, IS_REQUIRE)
values ('fet_time', 'fet_time', null, 'data', 100, 0);

insert into bw3.sys_port_submap (FIELD_NAME, CONVERT_NAME, DEFAULT_VALUE, PARENT_FIELD_NAME, SEQNO, IS_REQUIRE)
values ('SUPPLIER_CODE', 'SUPPLIER_CODE', null, 'data', 100, 0);

end;
