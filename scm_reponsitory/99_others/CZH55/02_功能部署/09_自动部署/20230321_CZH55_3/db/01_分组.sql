DECLARE
v_sql CLOB;
BEGIN
  v_sql := 'SUPPLIER_INFO_ID,COMPANY_ID,SUPPLIER_INFO_ORIGIN_ID,TAXPAYER,COOPERATION_CLASSIFICATION,COOPERATION_SUBCATEGORY,COOPERATION_METHOD,COOPERATION_MODEL,COOPERATION_TYPE,PRODUCTION_MODE,COOPERATION_METHOD_SP,PRODUCTION_MODE_SP,PAY_TYPE,SETTLEMENT_TYPE,SHARING_TYPE,PROVINCE,CITY,COUNTY,COMPANY_VILL,COOPSTATE,BRAND_TYPE,PATTERN_CAP,FABRIC_PURCHASE_CAP,FABRIC_CHECK_CAP,COST_STEP,FA_BRAND_TYPE,GROUP_NAME,OMPANY_TYPE_Y,SP_PRODUCT_TYPE_Y,SP_PRODUCT_LINK_N,SP_PRODUCT_LINE_N,SP_QUALITY_STEP_N,SP_COMPANY_TYPE_Y,COOPERATION_BRAND,SP_COOPERATION_TYPE_Y,SP_COOPERATION_MODEL_Y,SP_QUALITY_STEP_Y,SP_PATTERN_CAP_Y,SP_FABRIC_CHECK_CAP_Y,AR_COMPANY_VILL_Y,SP_FABRIC_PURCHASE_CAP_Y,AR_PAY_TERM_N,AR_IS_OUR_FACTORY_Y,SP_COOP_STATE_Y,SP_COOP_POSITION_N,SP_GROUP_NAME_N';
  UPDATE bw3.sys_item_list t SET t.noshow_fields = v_sql WHERE t.item_id = 'a_supp_151';
END;
/
BEGIN
insert into bw3.sys_element (ELEMENT_ID, ELEMENT_TYPE, DATA_SOURCE, PAUSE, MESSAGE, IS_HIDE, MEMO, IS_ASYNC, IS_PER_EXE, ENABLE_STAND_PERMISSION)
values ('look_a_supp_161_1', 'lookup', 'oracle_scmdata', 0, null, null, null, null, null, null);

insert into bw3.sys_look_up (ELEMENT_ID, FIELD_NAME, LOOK_UP_SQL, DATA_TYPE, KEY_FIELD, RESULT_FIELD, BEFORE_FIELD, SEARCH_FLAG, MULTI_VALUE_FLAG, DISABLED_FIELD, GROUP_FIELD, VALUE_SEP, ICON, PORT_ID, PORT_SQL)
values ('look_a_supp_161_1', 'GROUP_NAME_DESC', 'SELECT t.group_name group_name_desc, t.group_config_id sp_group_name_n
  FROM scmdata.t_supplier_group_config t
 WHERE t.company_id = %default_company_id%
   AND t.pause = 1', '1', 'SP_GROUP_NAME_N', 'GROUP_NAME_DESC', 'SP_GROUP_NAME_N', null, null, null, null, null, null, null, null);

insert into bw3.sys_item_element_rela (ITEM_ID, ELEMENT_ID, SEQ_NO, PAUSE, LEVEL_NO)
values ('a_supp_151', 'look_a_supp_161_1', 1, 0, null);
END;
/
