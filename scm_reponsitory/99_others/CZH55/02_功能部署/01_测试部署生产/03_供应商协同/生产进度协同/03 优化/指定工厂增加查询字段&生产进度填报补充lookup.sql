--指定工厂增加查询字段
begin
update bw3.sys_action t set t.query_fields = 'FACTORY_NAME' where t.element_id = 'action_a_order_201';
end;
/
--生产进度填报补充lookup
begin
insert into bw3.sys_item_element_rela (ITEM_ID, ELEMENT_ID, SEQ_NO, PAUSE, LEVEL_NO)
values ('a_product_211', 'lookup_a_product_111_1', 1, 0, null);
end;
