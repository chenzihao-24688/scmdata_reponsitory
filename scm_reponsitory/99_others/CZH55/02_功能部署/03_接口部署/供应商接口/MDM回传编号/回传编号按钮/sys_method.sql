declare
begin
delete from bw3.sys_method t where t.method_id = 'method_a_supp_110_9';

insert into bw3.sys_method (METHOD_ID, PORT_TYPE, DETAIL)
values ('method_a_supp_110_9', 'http', '��ȡmdm�ش�����');

end;
