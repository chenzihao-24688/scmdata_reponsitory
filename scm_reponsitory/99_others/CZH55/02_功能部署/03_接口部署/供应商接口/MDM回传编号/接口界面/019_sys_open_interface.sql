declare
begin
insert into bw3.sys_open_interface (OPEN_ID, MODULE_NAME, OPER_TYPE, ITEM_ID, REQ_SQL, TB_ID)
values ('open_a_supp_140', 'supp_140', 3, 'a_supp_140', null, 16);

insert into bw3.sys_open_interface (OPEN_ID, MODULE_NAME, OPER_TYPE, ITEM_ID, REQ_SQL, TB_ID)
values ('open_a_supp_scope', 'a_supp_scope', 3, 'a_supp_141', null, 17);

end;

