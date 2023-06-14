--业务联系人，联系电话 取消默认值
begin
update  bw3.sys_field_list t set t.requiered_flag = 1 where t.field_name in ('ASK_USER_NAME','ASK_USER_PHONE');  
update bw3.sys_item_element_rela t set t.pause = 1 where t.item_id = 'a_coop_151' and t.element_id in ('default_a_coop_151','default_a_coop_151_1');
end;
/
