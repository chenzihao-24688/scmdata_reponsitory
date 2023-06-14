BEGIN
 insert into bw3.sys_element (ELEMENT_ID, ELEMENT_TYPE, DATA_SOURCE, PAUSE, MESSAGE, IS_HIDE, MEMO, IS_ASYNC, IS_PER_EXE, ENABLE_STAND_PERMISSION)
values ('control_a_good_110_1', 'control', 'oracle_plm', 0, null, null, null, null, null, null);

insert into bw3.sys_field_control (ELEMENT_ID, FROM_FIELD, CONTROL_EXPRESS, CONTROL_FIELDS, CONTROL_TYPE)
values ('control_a_good_110_1', 'CATEGORY_GD', '''{{CATEGORY_GD}}''==''ÄÐ×°''', 'associate_a_good_110', 2);

insert into bw3.sys_item_element_rela (ITEM_ID, ELEMENT_ID, SEQ_NO, PAUSE, LEVEL_NO)
values ('a_good_110', 'control_a_good_110_1', 1, 1, null);
 
END;
/
