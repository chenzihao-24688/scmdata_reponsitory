begin
insert into bw3.sys_pivot_list (PIVOT_ID, ROW_FIELDS, COLUMN_FIELDS, VALUE_FIELDS, TAG, MEMO)
values ('p_a_good_310_1_2', 'company_id,goo_id,base_code,base_value,seq_num,position,quantitative_method,plus_toleran_range,negative_toleran_range', 'measure', 'measure_value', null, null);

insert into bw3.sys_pivot_list (PIVOT_ID, ROW_FIELDS, COLUMN_FIELDS, VALUE_FIELDS, TAG, MEMO)
values ('p_a_good_310_3', 'seq_num,position,quantitative_method,base_code,base_value,plus_toleran_range,negative_toleran_range', 'measure', 'measure_value', null, null);

insert into bw3.sys_pivot_list (PIVOT_ID, ROW_FIELDS, COLUMN_FIELDS, VALUE_FIELDS, TAG, MEMO)
values ('p_a_approve_310_2', 'company_id,goo_id,base_code,base_value,seq_num,position,quantitative_method,plus_toleran_range,negative_toleran_range', 'measure', 'measure_value', null, null);

insert into bw3.sys_pivot_list (PIVOT_ID, ROW_FIELDS, COLUMN_FIELDS, VALUE_FIELDS, TAG, MEMO)
values ('p_a_approve_310_3', 'seq_num,position,quantitative_method,base_code,base_value,plus_toleran_range,negative_toleran_range', 'measure', 'measure_value', null, null);

insert into bw3.sys_pivot_list (PIVOT_ID, ROW_FIELDS, COLUMN_FIELDS, VALUE_FIELDS, TAG, MEMO)
values ('p_a_good_310_4', 'seq_num,position,quantitative_method,base_code,base_value,plus_toleran_range,negative_toleran_range', 'measure', 'measure_value', null, null);

insert into bw3.sys_item_rela (ITEM_ID, RELATE_ID, RELATE_TYPE, SEQ_NO, PAUSE)
values ('a_good_310_2', 'p_a_good_310_1_2', 'P', 1, 0);

insert into bw3.sys_item_rela (ITEM_ID, RELATE_ID, RELATE_TYPE, SEQ_NO, PAUSE)
values ('a_good_310_3', 'p_a_good_310_3', 'P', 1, 0);

insert into bw3.sys_item_rela (ITEM_ID, RELATE_ID, RELATE_TYPE, SEQ_NO, PAUSE)
values ('a_approve_310_2', 'p_a_approve_310_2', 'P', 1, 0);

insert into bw3.sys_item_rela (ITEM_ID, RELATE_ID, RELATE_TYPE, SEQ_NO, PAUSE)
values ('a_approve_310_3', 'p_a_approve_310_3', 'P', 1, 0);

insert into bw3.sys_item_rela (ITEM_ID, RELATE_ID, RELATE_TYPE, SEQ_NO, PAUSE)
values ('a_good_310_4', 'p_a_good_310_4', 'P', 1, 0);
END;
/
