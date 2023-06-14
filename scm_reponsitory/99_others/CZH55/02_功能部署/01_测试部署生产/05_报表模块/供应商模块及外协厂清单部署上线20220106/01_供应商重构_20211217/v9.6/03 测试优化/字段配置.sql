update bw3.sys_item_list t set t.noshow_fields = 'coop_factory_id,supplier_info_id,company_id,coop_factory_type,coop_status,FAC_SUP_INFO_ID,product_type,product_link,product_line' where t.item_id = 'a_supp_151_7' ;

update bw3.sys_field_list t set t.alignment = 3  where t.caption in ('车位人数','织机台数'); 

insert into bw3.sys_field_list (FIELD_NAME, CAPTION, REQUIERED_FLAG, INPUT_HINT, VALID_CHARS, INVALID_CHARS, CHECK_EXPRESS, CHECK_MESSAGE, READ_ONLY_FLAG, NO_EDIT, NO_COPY, NO_SUM, NO_SORT, ALIGNMENT, MAX_LENGTH, MIN_LENGTH, DISPLAY_WIDTH, DISPLAY_FORMAT, EDIT_FORMT, DATA_TYPE, MAX_VALUE, MIN_VALUE, DEFAULT_VALUE, IME_CARE, IME_OPEN, VALUE_LISTS, VALUE_LIST_TYPE, HYPER_RES, MULTI_VALUE_FLAG, TRUE_EXPR, FALSE_EXPR, NAME_RULE_FLAG, NAME_RULE_ID, DATA_TYPE_FLAG, ALLOW_SCAN, VALUE_ENCRYPT, VALUE_SENSITIVE, OPERATOR_FLAG, VALUE_DISPLAY_STYLE, TO_ITEM_ID, VALUE_SENSITIVE_REPLACEMENT, STORE_SOURCE, ENABLE_STAND_PERMISSION)
values ('ADMIT_RESULT_SP', '准入结果', 0, null, null, null, null, null, 0, 0, 0, null, 0, 0, null, null, null, null, null, null, null, null, null, 0, 0, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

update bw3.sys_field_list t set t.requiered_flag = 1,t.data_type = 28 where t.field_name = 'ASK_FILES';

update bw3.sys_field_list t set t.caption = '生产效率(%)' where t.field_name = 'PRODUCT_EFFICIENCY';

update bw3.sys_item_element_rela t set t.pause = 1 where t.item_id = 'a_supp_151_7' and t.element_id = 'pick_a_coop_150_3_1';

insert into bw3.sys_element (ELEMENT_ID, ELEMENT_TYPE, DATA_SOURCE, PAUSE, MESSAGE, IS_HIDE, MEMO, IS_ASYNC, IS_PER_EXE, ENABLE_STAND_PERMISSION)
values ('default_a_supp_171', 'default', 'oracle_scmdata', 0, null, null, null, null, null, null);

insert into bw3.sys_default (ELEMENT_ID, DEFAULT_SQL)
values ('default_a_supp_171', 'select ''80%'' product_efficiency from dual');

insert into bw3.sys_item_element_rela (ITEM_ID, ELEMENT_ID, SEQ_NO, PAUSE, LEVEL_NO)
values ('a_supp_171', 'default_a_supp_171', 1, 0, null);
