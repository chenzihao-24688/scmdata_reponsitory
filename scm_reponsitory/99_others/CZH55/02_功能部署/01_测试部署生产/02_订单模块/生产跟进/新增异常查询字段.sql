alter table bw3.sys_action modify query_fields varchar2(64); 
/
declare
begin
update  bw3.sys_action t set t.query_fields = 'product_gress_code_pr,goo_id_pr,rela_goo_id,style_number_pr' where t.element_id = 'action_a_product_118_2';
update  bw3.sys_action t set t.query_fields = 'product_gress_code_pr,goo_id_pr,rela_goo_id,style_number_pr' where t.element_id = 'action_a_product_118_3';
update  bw3.sys_action t set t.query_fields = 'product_gress_code_pr,goo_id_pr,rela_goo_id,style_number_pr' where t.element_id = 'action_a_product_118_4';
end;
