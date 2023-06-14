???prompt Importing table nbw.sys_field_list...
set feedback off
set define off
insert into nbw.sys_field_list (FIELD_NAME, CAPTION, REQUIERED_FLAG, INPUT_HINT, VALID_CHARS, INVALID_CHARS, CHECK_EXPRESS, CHECK_MESSAGE, READ_ONLY_FLAG, NO_EDIT, NO_COPY, NO_SUM, NO_SORT, ALIGNMENT, MAX_LENGTH, MIN_LENGTH, DISPLAY_WIDTH, DISPLAY_FORMAT, EDIT_FORMT, DATA_TYPE, MAX_VALUE, MIN_VALUE, DEFAULT_VALUE, IME_CARE, IME_OPEN, VALUE_LISTS, VALUE_LIST_TYPE, HYPER_RES, MULTI_VALUE_FLAG, TRUE_EXPR, FALSE_EXPR, NAME_RULE_FLAG, NAME_RULE_ID, DATA_TYPE_FLAG, ALLOW_SCAN, VALUE_ENCRYPT, VALUE_SENSITIVE, OPERATOR_FLAG, VALUE_DISPLAY_STYLE, TO_ITEM_ID, VALUE_SENSITIVE_REPLACEMENT)
values ('DEDUCTION_UNIT_PRICE_PR', '扣款单价/金额/比例', 0, null, null, null, '^[+]{0,1}(\d+)$|^[+]{0,1}(\d+\.\d+)$', '只可录入数字，且只可录入正数！', 0, 0, 0, 0, 0, 0, null, null, null, '0.##', '0.##', '10', null, null, null, 0, 0, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

prompt Done.
