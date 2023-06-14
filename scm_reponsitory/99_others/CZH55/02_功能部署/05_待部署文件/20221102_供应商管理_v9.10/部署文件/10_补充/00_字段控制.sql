BEGIN
  insert into bw3.sys_element (ELEMENT_ID, ELEMENT_TYPE, DATA_SOURCE, PAUSE, MESSAGE, IS_HIDE, MEMO, IS_ASYNC, IS_PER_EXE, ENABLE_STAND_PERMISSION)
values ('control_a_coop_150_1', 'control', 'oracle_scmdata', 0, null, null, null, null, null, null);

insert into bw3.sys_element (ELEMENT_ID, ELEMENT_TYPE, DATA_SOURCE, PAUSE, MESSAGE, IS_HIDE, MEMO, IS_ASYNC, IS_PER_EXE, ENABLE_STAND_PERMISSION)
values ('control_a_coop_151_1', 'control', 'oracle_scmdata', 0, null, null, null, null, null, null);

insert into bw3.sys_element (ELEMENT_ID, ELEMENT_TYPE, DATA_SOURCE, PAUSE, MESSAGE, IS_HIDE, MEMO, IS_ASYNC, IS_PER_EXE, ENABLE_STAND_PERMISSION)
values ('control_a_coop_151_2', 'control', 'oracle_scmdata', 0, null, null, null, null, null, null);

insert into bw3.sys_element (ELEMENT_ID, ELEMENT_TYPE, DATA_SOURCE, PAUSE, MESSAGE, IS_HIDE, MEMO, IS_ASYNC, IS_PER_EXE, ENABLE_STAND_PERMISSION)
values ('control_a_coop_151_2_1', 'control', 'oracle_scmdata', 0, null, null, null, null, null, null);

insert into bw3.sys_element (ELEMENT_ID, ELEMENT_TYPE, DATA_SOURCE, PAUSE, MESSAGE, IS_HIDE, MEMO, IS_ASYNC, IS_PER_EXE, ENABLE_STAND_PERMISSION)
values ('control_a_coop_151_3', 'control', 'oracle_scmdata', 0, null, null, null, null, null, null);

insert into bw3.sys_field_control (ELEMENT_ID, FROM_FIELD, CONTROL_EXPRESS, CONTROL_FIELDS, CONTROL_TYPE)
values ('control_a_coop_151_3', 'AR_IS_OUR_FAC_DESC_Y', '''{{AR_IS_OUR_FAC_DESC_Y}}''==''否''', 'AR_FACTORY_NAME_Y,FACTORY_PROVINCE,FACTORY_CITY,FACTORY_COUNTY,AR_FACTORY_AREA_Y,AR_FACTORY_VILL_Y,AR_FACTORY_VILL_DESC_Y,AR_FACTROY_DETAILS_ADDRESS_Y', 0);

insert into bw3.sys_field_control (ELEMENT_ID, FROM_FIELD, CONTROL_EXPRESS, CONTROL_FIELDS, CONTROL_TYPE)
values ('control_a_coop_150_1', 'STATUS_AF_OPER', '''{{STATUS_AF_OPER}}''==''CA01''||''{{STATUS_AF_OPER}}''==''FA03''', 'asso_a_coop_150_3', 2);

insert into bw3.sys_field_control (ELEMENT_ID, FROM_FIELD, CONTROL_EXPRESS, CONTROL_FIELDS, CONTROL_TYPE)
values ('control_a_coop_151_1', 'AR_COOP_MODEL_DESC_Y', '''{{AR_COOP_MODEL_DESC_Y}}''!=''外协工厂''&&''{{AR_COOP_MODEL_DESC_Y}}''!=''''', 'AR_PAY_TERM_DESC_N', 0);

insert into bw3.sys_field_control (ELEMENT_ID, FROM_FIELD, CONTROL_EXPRESS, CONTROL_FIELDS, CONTROL_TYPE)
values ('control_a_coop_151_2_1', 'ORGIN_VAL', '''{{ORGIN_VAL}}''==''MA''||''{{ORGIN_VAL}}''==''''', 'AR_EQUIPMENT_CATE_N,AR_EQUIP_CATE_DESC_N,AR_EQUIPMENT_NAME_Y', 0);

insert into bw3.sys_field_control (ELEMENT_ID, FROM_FIELD, CONTROL_EXPRESS, CONTROL_FIELDS, CONTROL_TYPE)
values ('control_a_coop_151_2', 'AR_COMPANY_TYPE_DESC_Y', '''{{AR_COMPANY_TYPE_DESC_Y}}''!=''''', 'pick_a_coop_151_4', 2);

insert into bw3.sys_item_element_rela (ITEM_ID, ELEMENT_ID, SEQ_NO, PAUSE, LEVEL_NO)
values ('a_coop_151', 'control_a_coop_151_2', 2, 1, null);

insert into bw3.sys_item_element_rela (ITEM_ID, ELEMENT_ID, SEQ_NO, PAUSE, LEVEL_NO)
values ('a_coop_150', 'control_a_coop_150_1', 1, 0, null);

insert into bw3.sys_item_element_rela (ITEM_ID, ELEMENT_ID, SEQ_NO, PAUSE, LEVEL_NO)
values ('a_coop_151', 'control_a_coop_151_1', 1, 0, null);

insert into bw3.sys_item_element_rela (ITEM_ID, ELEMENT_ID, SEQ_NO, PAUSE, LEVEL_NO)
values ('a_coop_151', 'control_a_coop_151_3', 3, 0, null);

insert into bw3.sys_item_element_rela (ITEM_ID, ELEMENT_ID, SEQ_NO, PAUSE, LEVEL_NO)
values ('a_coop_151_2', 'control_a_coop_151_2_1', 1, 0, null);

insert into bw3.sys_item_element_rela (ITEM_ID, ELEMENT_ID, SEQ_NO, PAUSE, LEVEL_NO)
values ('a_check_101_1_6', 'control_a_coop_151_2_1', 1, 0, null);

insert into bw3.sys_item_element_rela (ITEM_ID, ELEMENT_ID, SEQ_NO, PAUSE, LEVEL_NO)
values ('a_coop_150_3_2', 'control_a_coop_151_2_1', 1, 0, null);

insert into bw3.sys_item_element_rela (ITEM_ID, ELEMENT_ID, SEQ_NO, PAUSE, LEVEL_NO)
values ('a_supp_151_10', 'control_a_coop_151_2_1', 1, 0, null);


insert into bw3.sys_field_list (FIELD_NAME, CAPTION, REQUIERED_FLAG, INPUT_HINT, VALID_CHARS, INVALID_CHARS, CHECK_EXPRESS, CHECK_MESSAGE, READ_ONLY_FLAG, NO_EDIT, NO_COPY, NO_SUM, NO_SORT, ALIGNMENT, MAX_LENGTH, MIN_LENGTH, DISPLAY_WIDTH, DISPLAY_FORMAT, EDIT_FORMT, DATA_TYPE, MAX_VALUE, MIN_VALUE, DEFAULT_VALUE, IME_CARE, IME_OPEN, VALUE_LISTS, VALUE_LIST_TYPE, HYPER_RES, MULTI_VALUE_FLAG, TRUE_EXPR, FALSE_EXPR, NAME_RULE_FLAG, NAME_RULE_ID, DATA_TYPE_FLAG, ALLOW_SCAN, VALUE_ENCRYPT, VALUE_SENSITIVE, OPERATOR_FLAG, VALUE_DISPLAY_STYLE, TO_ITEM_ID, VALUE_SENSITIVE_REPLACEMENT, STORE_SOURCE, ENABLE_STAND_PERMISSION)
values ('FLOW_NODE_NAME_BF', '流程节点', 0, null, null, null, null, null, 0, 0, 0, null, 0, 3, null, null, null, null, null, null, null, null, null, 0, 0, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into bw3.sys_field_list (FIELD_NAME, CAPTION, REQUIERED_FLAG, INPUT_HINT, VALID_CHARS, INVALID_CHARS, CHECK_EXPRESS, CHECK_MESSAGE, READ_ONLY_FLAG, NO_EDIT, NO_COPY, NO_SUM, NO_SORT, ALIGNMENT, MAX_LENGTH, MIN_LENGTH, DISPLAY_WIDTH, DISPLAY_FORMAT, EDIT_FORMT, DATA_TYPE, MAX_VALUE, MIN_VALUE, DEFAULT_VALUE, IME_CARE, IME_OPEN, VALUE_LISTS, VALUE_LIST_TYPE, HYPER_RES, MULTI_VALUE_FLAG, TRUE_EXPR, FALSE_EXPR, NAME_RULE_FLAG, NAME_RULE_ID, DATA_TYPE_FLAG, ALLOW_SCAN, VALUE_ENCRYPT, VALUE_SENSITIVE, OPERATOR_FLAG, VALUE_DISPLAY_STYLE, TO_ITEM_ID, VALUE_SENSITIVE_REPLACEMENT, STORE_SOURCE, ENABLE_STAND_PERMISSION)
values ('FLOW_NODE_STATUS_DESC_BF', '流程状态', 0, null, null, null, null, null, 0, 0, 0, null, 0, 3, null, null, null, null, null, null, null, null, null, 0, 0, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

UPDATE bw3.sys_field_list t SET t.caption = '当前流程节点' WHERE t.field_name = 'FLOW_NODE_NAME_AF'; 
UPDATE bw3.sys_field_list t SET t.caption = '当前流程状态' WHERE t.field_name = 'FLOW_NODE_STATUS_DESC_AF'; 

insert into bw3.sys_field_list (FIELD_NAME, CAPTION, REQUIERED_FLAG, INPUT_HINT, VALID_CHARS, INVALID_CHARS, CHECK_EXPRESS, CHECK_MESSAGE, READ_ONLY_FLAG, NO_EDIT, NO_COPY, NO_SUM, NO_SORT, ALIGNMENT, MAX_LENGTH, MIN_LENGTH, DISPLAY_WIDTH, DISPLAY_FORMAT, EDIT_FORMT, DATA_TYPE, MAX_VALUE, MIN_VALUE, DEFAULT_VALUE, IME_CARE, IME_OPEN, VALUE_LISTS, VALUE_LIST_TYPE, HYPER_RES, MULTI_VALUE_FLAG, TRUE_EXPR, FALSE_EXPR, NAME_RULE_FLAG, NAME_RULE_ID, DATA_TYPE_FLAG, ALLOW_SCAN, VALUE_ENCRYPT, VALUE_SENSITIVE, OPERATOR_FLAG, VALUE_DISPLAY_STYLE, TO_ITEM_ID, VALUE_SENSITIVE_REPLACEMENT, STORE_SOURCE, ENABLE_STAND_PERMISSION)
values ('CREATE_DATE_N', '创建时间', 0, null, null, null, null, null, 0, 0, 0, null, 0, 0, null, null, null, null, null, null, null, null, null, 0, 0, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into bw3.sys_field_list (FIELD_NAME, CAPTION, REQUIERED_FLAG, INPUT_HINT, VALID_CHARS, INVALID_CHARS, CHECK_EXPRESS, CHECK_MESSAGE, READ_ONLY_FLAG, NO_EDIT, NO_COPY, NO_SUM, NO_SORT, ALIGNMENT, MAX_LENGTH, MIN_LENGTH, DISPLAY_WIDTH, DISPLAY_FORMAT, EDIT_FORMT, DATA_TYPE, MAX_VALUE, MIN_VALUE, DEFAULT_VALUE, IME_CARE, IME_OPEN, VALUE_LISTS, VALUE_LIST_TYPE, HYPER_RES, MULTI_VALUE_FLAG, TRUE_EXPR, FALSE_EXPR, NAME_RULE_FLAG, NAME_RULE_ID, DATA_TYPE_FLAG, ALLOW_SCAN, VALUE_ENCRYPT, VALUE_SENSITIVE, OPERATOR_FLAG, VALUE_DISPLAY_STYLE, TO_ITEM_ID, VALUE_SENSITIVE_REPLACEMENT, STORE_SOURCE, ENABLE_STAND_PERMISSION)
values ('CREATE_ID_N', '创建人', 0, null, null, null, null, null, 0, 0, 0, null, 0, 0, null, null, null, null, null, null, null, null, null, 0, 0, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into bw3.sys_element (ELEMENT_ID, ELEMENT_TYPE, DATA_SOURCE, PAUSE, MESSAGE, IS_HIDE, MEMO, IS_ASYNC, IS_PER_EXE, ENABLE_STAND_PERMISSION)
values ('control_a_coop_150_2', 'control', 'oracle_scmdata', 0, null, null, null, null, null, null);

insert into bw3.sys_field_control (ELEMENT_ID, FROM_FIELD, CONTROL_EXPRESS, CONTROL_FIELDS, CONTROL_TYPE)
values ('control_a_coop_150_2', 'STATUS_AF_OPER', '''{{STATUS_AF_OPER}}''==''FA21'' || ''{{STATUS_AF_OPER}}''==''FA33''', 'action_specialapply', 2);

insert into bw3.sys_item_element_rela (ITEM_ID, ELEMENT_ID, SEQ_NO, PAUSE, LEVEL_NO)
values ('a_coop_150', 'control_a_coop_150_2', 2, 0, null);

insert into bw3.sys_field_list (FIELD_NAME, CAPTION, REQUIERED_FLAG, INPUT_HINT, VALID_CHARS, INVALID_CHARS, CHECK_EXPRESS, CHECK_MESSAGE, READ_ONLY_FLAG, NO_EDIT, NO_COPY, NO_SUM, NO_SORT, ALIGNMENT, MAX_LENGTH, MIN_LENGTH, DISPLAY_WIDTH, DISPLAY_FORMAT, EDIT_FORMT, DATA_TYPE, MAX_VALUE, MIN_VALUE, DEFAULT_VALUE, IME_CARE, IME_OPEN, VALUE_LISTS, VALUE_LIST_TYPE, HYPER_RES, MULTI_VALUE_FLAG, TRUE_EXPR, FALSE_EXPR, NAME_RULE_FLAG, NAME_RULE_ID, DATA_TYPE_FLAG, ALLOW_SCAN, VALUE_ENCRYPT, VALUE_SENSITIVE, OPERATOR_FLAG, VALUE_DISPLAY_STYLE, TO_ITEM_ID, VALUE_SENSITIVE_REPLACEMENT, STORE_SOURCE, ENABLE_STAND_PERMISSION)
values ('FR_CHECK_FAC_RESULT_DESC_N', '验厂结论', 0, null, null, null, null, null, 0, 0, 0, null, 0, 0, null, null, null, null, null, null, null, null, null, 0, 0, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into bw3.sys_field_list (FIELD_NAME, CAPTION, REQUIERED_FLAG, INPUT_HINT, VALID_CHARS, INVALID_CHARS, CHECK_EXPRESS, CHECK_MESSAGE, READ_ONLY_FLAG, NO_EDIT, NO_COPY, NO_SUM, NO_SORT, ALIGNMENT, MAX_LENGTH, MIN_LENGTH, DISPLAY_WIDTH, DISPLAY_FORMAT, EDIT_FORMT, DATA_TYPE, MAX_VALUE, MIN_VALUE, DEFAULT_VALUE, IME_CARE, IME_OPEN, VALUE_LISTS, VALUE_LIST_TYPE, HYPER_RES, MULTI_VALUE_FLAG, TRUE_EXPR, FALSE_EXPR, NAME_RULE_FLAG, NAME_RULE_ID, DATA_TYPE_FLAG, ALLOW_SCAN, VALUE_ENCRYPT, VALUE_SENSITIVE, OPERATOR_FLAG, VALUE_DISPLAY_STYLE, TO_ITEM_ID, VALUE_SENSITIVE_REPLACEMENT, STORE_SOURCE, ENABLE_STAND_PERMISSION)
values ('FR_CHECK_DATE_N', '验厂日期', 0, null, null, null, null, null, 0, 0, 0, null, 0, 0, null, null, null, null, null, null, null, null, null, 0, 0, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into bw3.sys_field_list (FIELD_NAME, CAPTION, REQUIERED_FLAG, INPUT_HINT, VALID_CHARS, INVALID_CHARS, CHECK_EXPRESS, CHECK_MESSAGE, READ_ONLY_FLAG, NO_EDIT, NO_COPY, NO_SUM, NO_SORT, ALIGNMENT, MAX_LENGTH, MIN_LENGTH, DISPLAY_WIDTH, DISPLAY_FORMAT, EDIT_FORMT, DATA_TYPE, MAX_VALUE, MIN_VALUE, DEFAULT_VALUE, IME_CARE, IME_OPEN, VALUE_LISTS, VALUE_LIST_TYPE, HYPER_RES, MULTI_VALUE_FLAG, TRUE_EXPR, FALSE_EXPR, NAME_RULE_FLAG, NAME_RULE_ID, DATA_TYPE_FLAG, ALLOW_SCAN, VALUE_ENCRYPT, VALUE_SENSITIVE, OPERATOR_FLAG, VALUE_DISPLAY_STYLE, TO_ITEM_ID, VALUE_SENSITIVE_REPLACEMENT, STORE_SOURCE, ENABLE_STAND_PERMISSION)
values ('ASSESSMENT_PERIOD', '考核期', 0, null, null, null, null, null, 0, 0, 0, null, 0, 0, null, null, null, null, null, null, null, null, null, 0, 0, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

END;
/
