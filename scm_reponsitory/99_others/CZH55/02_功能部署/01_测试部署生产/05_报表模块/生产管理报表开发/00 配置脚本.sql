select t.*,rowid from nbw.sys_item_field_custom t;
select rowid,t.* from nbw.sys_param_list t where t.param_name like '%ABN%'; --in ('START_TIME','ABN_BEGIN_TIME','ABN_END_TIME','BEGIN_DATE','END_DATE') ;
select rowid,t.* from nbw.sys_param_list t where t.param_name like '%RDL%'; 
select rowid,t.* from nbw.sys_field_list t where t.field_name like '%ABN%';--in ('START_TIME','ABN_BEGIN_TIME','ABN_END_TIME','BEGIN_DATE','END_DATE') ;
SELECT ROWID, t.* FROM nbw.sys_item t where t.item_id in ('a_report_abn_100','a_report_abn_101','a_report_abn_102','a_report_abn_103','a_report_abn_201','a_report_abn_202');
select rowid,t.* from nbw.sys_tree_list t where t.item_id in ('a_report_abn_100','a_report_abn_101','a_report_abn_102','a_report_abn_103','a_report_abn_201','a_report_abn_202');
select rowid,t.* from nbw.sys_item_list t where t.item_id in ('a_report_abn_101','a_report_abn_102','a_report_abn_103','a_report_abn_201','a_report_abn_201','a_report_abn_202');  
select rowid,t.* from nbw.sys_item_list t where t.item_id in ('a_report_order_100','a_report_order_101','a_report_delivery_101_1','a_report_prostatus_100');  
select rowid,t.* from nbw.sys_web_union t where t.item_id in ('a_report_abn_100','a_report_abn_200'); 

select rowid,t.* from nbw.sys_element t  where t.element_id = 'adt_a_report_abn_101';
select rowid,t.* from nbw.sys_adt_field t  where t.element_id = 'adt_a_report_abn_101';
select rowid,t.* from nbw.sys_item_element_rela t  where t.element_id = 'adt_a_report_abn_101';

select rowid,t.* from nbw.sys_item_rela t where t.item_id = 'a_report_prostatus_100';

select rowid,t.* from nbw.sys_pivot_list t where t.pivot_id in ('p_a_report_abn_101','p_a_report_prostatus_100');

scmdata.pkg_report_analy.f_get_abn_distribut

SELECT ROWID, t.* FROM nbw.sys_item t where t.item_id like '%a_product%';
SELECT ROWID, t.* FROM nbw.sys_item t where t.item_id in ('a_report_order_100','a_report_order_101','a_report_delivery_101_1');
select rowid,t.* from nbw.sys_tree_list t where t.item_id in ('a_report_order_100','a_report_order_101','a_report_delivery_101_1');
select rowid,t.* from nbw.sys_item_list t where t.item_id in ('a_report_order_100','a_report_order_101','a_report_delivery_101_1','a_report_prostatus_100');  
select rowid,t.* from nbw.sys_web_union t where t.item_id in ('a_product_101'); 

select rowid,t.* from nbw.sys_element t  where t.element_id = 'action_a_report_order_100_1';
select rowid,t.* from nbw.sys_action t  where t.element_id in ('action_g_520_1','action_a_report_order_100_1');
select rowid,t.* from nbw.sys_associate t where t.element_id = 'associate_a_report_order_100_1'; 
select rowid,t.* from nbw.sys_item_element_rela t  where t.element_id = 'action_a_report_order_100_1';
select t.*,rowid from nbw.sys_item_field_custom t where t.item_id = 'a_report_delivery_101_1';
select rowid,t.* from nbw.sys_param_list t where t.param_name like '%RDL%'; 
select rowid,t.* from nbw.sys_element_hint t; 


select rowid,t.* from nbw.sys_item_list t where t.item_id = 'a_product_110' 


