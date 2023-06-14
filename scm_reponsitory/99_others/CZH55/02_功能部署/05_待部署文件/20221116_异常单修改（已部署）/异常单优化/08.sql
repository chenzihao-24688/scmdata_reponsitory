prompt Importing table nbw.sys_item_element_rela...
set feedback off
set define off

insert into nbw.sys_item_element_rela (ITEM_ID, ELEMENT_ID, SEQ_NO, PAUSE, LEVEL_NO)
values ('a_product_120_1', 'control_a_product_118', 1, 1, null);

insert into nbw.sys_item_element_rela (ITEM_ID, ELEMENT_ID, SEQ_NO, PAUSE, LEVEL_NO)
values ('a_product_118', 'control_a_product_118', 1, 1, null);

insert into nbw.sys_item_element_rela (ITEM_ID, ELEMENT_ID, SEQ_NO, PAUSE, LEVEL_NO)
values ('a_product_120_1', 'control_a_product_118_1', 2, 0, null);

insert into nbw.sys_item_element_rela (ITEM_ID, ELEMENT_ID, SEQ_NO, PAUSE, LEVEL_NO)
values ('a_product_118', 'control_a_product_118_1', 2, 0, null);

insert into nbw.sys_item_element_rela (ITEM_ID, ELEMENT_ID, SEQ_NO, PAUSE, LEVEL_NO)
values ('a_product_120_1', 'control_a_product_118_2', 3, 0, null);

insert into nbw.sys_item_element_rela (ITEM_ID, ELEMENT_ID, SEQ_NO, PAUSE, LEVEL_NO)
values ('a_product_118', 'control_a_product_118_2', 3, 0, null);

insert into nbw.sys_item_element_rela (ITEM_ID, ELEMENT_ID, SEQ_NO, PAUSE, LEVEL_NO)
values ('a_product_120_1', 'control_a_product_120_1', 1, 0, null);

insert into nbw.sys_item_element_rela (ITEM_ID, ELEMENT_ID, SEQ_NO, PAUSE, LEVEL_NO)
values ('a_product_118', 'control_a_product_120_1', 2, 0, null);

insert into nbw.sys_item_element_rela (ITEM_ID, ELEMENT_ID, SEQ_NO, PAUSE, LEVEL_NO)
values ('a_product_120_2', 'control_a_product_120_2', 3, 0, null);

insert into nbw.sys_item_element_rela (ITEM_ID, ELEMENT_ID, SEQ_NO, PAUSE, LEVEL_NO)
values ('a_product_120_1', 'control_a_product_120_2', 2, 0, null);

prompt Done.
