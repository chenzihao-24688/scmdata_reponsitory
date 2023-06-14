declare
begin
delete from  bw3.sys_field_back_color t where t.item_id in ('a_product_110','a_product_116');

insert into bw3.sys_field_back_color (ITEM_ID, FIELD_NAME, BACK_WHEN, BACK_COLOR, PAUSE, FONT_COLOR)
values ('a_product_110', 'APPROVE_EDITION_PR', '''{{APPROVE_EDITION}}''==''AS04''', 255, 0, 0);

insert into bw3.sys_field_back_color (ITEM_ID, FIELD_NAME, BACK_WHEN, BACK_COLOR, PAUSE, FONT_COLOR)
values ('a_product_110', 'EXCEPTION_HANDLE_STATUS_PR', '''{{EXCEPTION_HANDLE_STATUS_PR}}''==''处理中''', 255, 0, 0);

insert into bw3.sys_field_back_color (ITEM_ID, FIELD_NAME, BACK_WHEN, BACK_COLOR, PAUSE, FONT_COLOR)
values ('a_product_110', 'FABRIC_CHECK_PR', '''{{FABRIC_CHECK}}''==''FABRIC_EVELUATE_NO_PASS''', 255, 0, 0);

insert into bw3.sys_field_back_color (ITEM_ID, FIELD_NAME, BACK_WHEN, BACK_COLOR, PAUSE, FONT_COLOR)
values ('a_product_116', 'APPROVE_EDITION_PR', '''{{APPROVE_EDITION}}''==''AS04''', 255, 0, 0);

insert into bw3.sys_field_back_color (ITEM_ID, FIELD_NAME, BACK_WHEN, BACK_COLOR, PAUSE, FONT_COLOR)
values ('a_product_116', 'EXCEPTION_HANDLE_STATUS_PR', '''{{EXCEPTION_HANDLE_STATUS_PR}}''==''处理中''', 255, 0, 0);

insert into bw3.sys_field_back_color (ITEM_ID, FIELD_NAME, BACK_WHEN, BACK_COLOR, PAUSE, FONT_COLOR)
values ('a_product_116', 'FABRIC_CHECK_PR', '''{{FABRIC_CHECK}}''==''FABRIC_EVELUATE_NO_PASS''', 255, 0, 0);

end;

select rowid,t.* from  bw3.sys_field_back_color t where t.item_id in ('a_product_110','a_product_116');
