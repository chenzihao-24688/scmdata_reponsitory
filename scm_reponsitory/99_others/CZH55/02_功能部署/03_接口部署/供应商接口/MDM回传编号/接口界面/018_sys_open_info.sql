declare
begin
insert into bw3.sys_open_info (OPEN_ID, APP_KEY, APP_SECRET, GLOBAL_SQL)
values ('open_a_supp_140', 'a_supp_140_key', 'a_supp_140_secret', null);

insert into bw3.sys_open_info (OPEN_ID, APP_KEY, APP_SECRET, GLOBAL_SQL)
values ('open_a_supp_scope', 'a_supp_scope_key', 'a_supp_scope_secret', null);

end;
