begin
update bw3.sys_item t set t.caption_sql = '待结束清单' where t.item_id = 'a_report_order_100';
update bw3.sys_item t set t.caption_sql = '非生产订单跟进表' where t.item_id = 'a_product_150';
update bw3.sys_item t set t.caption_sql = '非生产订单跟进表' where t.item_id = 'a_product_217';
update bw3.sys_item t set t.caption_sql = '扣款处理列表' where t.item_id = 'a_product_130';
update bw3.sys_field_list t set t.caption = '合计' where t.field_name = 'CATE_ORDER_CNT';
update bw3.sys_field_list t set t.caption = '正常订单' where t.field_name = 'NM_ORDER_CNT';
update bw3.sys_field_list t set t.caption = '无原因' where t.field_name = 'ABN_ORDER_CNT_NL';
update bw3.sys_field_list t set t.caption = '有原因' where t.field_name = 'ABN_ORDER_CNT_N';
end;
/
begin
insert into bw3.sys_element (ELEMENT_ID, ELEMENT_TYPE, DATA_SOURCE, PAUSE, MESSAGE, IS_HIDE, MEMO, IS_ASYNC, IS_PER_EXE, ENABLE_STAND_PERMISSION)
values ('adt_a_report_order_100', 'adt', 'oracle_scmdata', 0, null, null, null, null, null, null);

insert into bw3.sys_adt_field (ELEMENT_ID, FIELD_NAME, CAPTION, SUB_FIELDS)
values ('adt_a_report_order_100', 'ABN_ORDER', '异常订单', 'ABN_ORDER_CNT_NL,ABN_ORDER_CNT_N');

insert into bw3.sys_item_element_rela (ITEM_ID, ELEMENT_ID, SEQ_NO, PAUSE, LEVEL_NO)
values ('a_report_order_100', 'adt_a_report_order_100', 1, 0, null);
end;



  

 
