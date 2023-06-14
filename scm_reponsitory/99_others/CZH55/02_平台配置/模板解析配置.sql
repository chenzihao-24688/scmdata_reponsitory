select rowid,t.* from nbw.sys_item t where t.item_id in ('sf-test-contract','a_product_130_1','g_508_3');
select rowid,t.* from nbw.sys_tree_list t where t.item_id in ('sf-test-contract','a_product_130_1','g_508_3');
select rowid,t.* from nbw.sys_item_list t where t.item_id in ('sf-test-contract','a_product_130_1','g_508_3');
select rowid,t.* from nbw.sys_item_rela t where t.item_id in ('sf-test-contract','a_product_130_1','g_508_3');
select rowid,t.* from nbw.sys_element t where t.element_id in ('sf-test-word-1','word_a_product_130_1','word_a_product_130_2');
select rowid,t.* from nbw.sys_action t;
select rowid,t.* from nbw.sys_file_template t where t.element_id in ('word_g_508_1','sf-test-word-1','word_a_product_130_1','word_a_product_130_2');
select rowid,t.* from nbw.sys_file_template_table t where t.element_id in ('word_g_508_1','sf-test-word-1','word_a_product_130_1','word_a_product_130_2');
select rowid,t.* from nbw.sys_item_element_rela t where t.element_id in ('word_g_508_1','sf-test-word-1','word_a_product_130_1','word_a_product_130_2');
select rowid,t.* from nbw.sys_field_list t;

--------------------------------------------

select rowid,t.* from nbw.sys_element t where t.element_id in ('sf-test-word-1','word_a_product_130_1','word_a_product_130_2');
select rowid,t.* from nbw.sys_action t;
select rowid,t.* from nbw.sys_file_template t where t.element_id in ('word_g_508_1','sf-test-word-1','word_a_product_130_1','word_a_product_130_2');
select rowid,t.* from nbw.sys_file_template_table t where t.element_id in ('word_g_508_1','sf-test-word-1','word_a_product_130_1','word_a_product_130_2');
select rowid,t.* from nbw.sys_item_element_rela t where t.element_id in ('word_g_508_1','sf-test-word-1','word_a_product_130_1','word_a_product_130_2');

SELECT ROWID,t.* from scmdata.file_info t WHERE t.file_name LIKE '%±¨¼Ûµ¥%';

SELECT * from scmdata.file_data t WHERE t.file_id = '216BDFA50B0672348109AD52BA014384';--md5

SELECT * from scmdata.file














