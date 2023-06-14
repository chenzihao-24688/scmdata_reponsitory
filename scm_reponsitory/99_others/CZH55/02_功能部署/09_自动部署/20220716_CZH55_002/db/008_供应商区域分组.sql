BEGIN
insert into bw3.sys_item (ITEM_ID, ITEM_TYPE, CAPTION_SQL, DATA_SOURCE, BASE_TABLE, KEY_FIELD, NAME_FIELD, SETTING_ID, REPORT_TITLE, SUB_SCRIPTS, PAUSE, LINK_FIELD, HELP_ID, TAG_ID, CONFIG_PARAMS, TIME_OUT, OFFLINE_FLAG, PANEL_ID, INIT_SHOW, BADGE_FLAG, BADGE_SQL, MEMO, SHOW_ROWID, ENABLE_STAND_PERMISSION, FIX_CAPTION)
values ('a_report_140', 'list', '供应商区域分组清单', 'oracle_scmdata', 'T_SUPPLIER_INFO', 'SUPPLIER_INFO_ID', null, null, null, null, 0, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into bw3.sys_tree_list (NODE_ID, TREE_ID, ITEM_ID, PARENT_ID, VAR_ID, APP_ID, ICON_NAME, IS_END, STAND_PRIV_FLAG, SEQ_NO, PAUSE, TERMINAL_FLAG, CAPTION_EXPLAIN, COMPETENCE_FLAG, NODE_TYPE, IS_AUTHORIZE, ENABLE_STAND_PERMISSION)
values ('node_a_report_140', 'tree_a_report', 'a_report_140', 'a_report_110', null, 'scm', 'icon-biaodandayin', 0, null, 1, 0, null, null, null, 1, 1, null);

insert into bw3.sys_item_list (ITEM_ID, QUERY_TYPE, QUERY_FIELDS, QUERY_COUNT, EDIT_EXPRESS, NEWID_SQL, SELECT_SQL, DETAIL_SQL, SUBSELECT_SQL, INSERT_SQL, UPDATE_SQL, DELETE_SQL, NOSHOW_FIELDS, NOADD_FIELDS, NOMODIFY_FIELDS, NOEDIT_FIELDS, SUBNOSHOW_FIELDS, UI_TMPL, MULTI_PAGE_FLAG, OUTPUT_PARAMETER, LOCK_SQL, MONITOR_ID, END_FIELD, EXECUTE_TIME, SCANNABLE_FIELD, SCANNABLE_TYPE, AUTO_REFRESH, RFID_FLAG, SCANNABLE_TIME, MAX_ROW_COUNT, NOSHOW_APP_FIELDS, SCANNABLE_LOCATION_LINE, SUB_TABLE_JUDGE_FIELD, BACK_GROUND_ID, OPRETION_HINT, SUB_EDIT_STATE, HINT_TYPE, HEADER, FOOTER, JUMP_FIELD, JUMP_EXPRESS, OPEN_MODE, OPERATION_TYPE, OPERATE_TYPE, PAGE_SIZES)
values ('a_report_140', 13, 'SUPPLIER_NAME,GROUP_NAME,COOP_CLASSIFICATION', null, null, null, 'WITH group_dict AS
 (SELECT group_dict_value, group_dict_type, group_dict_name
    FROM scmdata.sys_group_dict
   WHERE pause = 0)
SELECT t.supplier_company_abbreviation SUPPLIER_NAME,
       sg.group_name,
       gc.group_dict_name COOP_STATUS,
       va.cate_name COOP_CLASSIFICATION,
       (SELECT listagg(ga.group_dict_name, '';'') within GROUP(ORDER BY ga.group_dict_value)
          FROM group_dict ga
         WHERE ga.group_dict_type = ''SUPPLY_TYPE''
           AND instr('';'' || t.cooperation_model || '';'',
                     '';'' || ga.group_dict_value || '';'') > 0) COOPERATIONS_MODEL,
       fc.supplier_company_abbreviation ASSOCIATED_SUPPLIER,
       t.SUPPLIER_INFO_ID
  FROM scmdata.t_supplier_info t
  LEFT JOIN scmdata.t_factory_ask fa
    ON fa.factory_ask_id = t.supplier_info_origin_id
   AND fa.company_id = t.company_id
  LEFT JOIN scmdata.t_supplier_info fc
    ON fc.supplier_info_id = fa.rela_supplier_id
   AND fc.company_id = fa.company_id
  LEFT JOIN scmdata.t_supplier_group_config sg
    ON sg.company_id = t.company_id
   AND sg.group_config_id = t.group_name
   AND sg.pause = 1
 LEFT JOIN group_dict gc
    ON gc.group_dict_value = t.pause
   AND gc.group_dict_type = ''COOP_STATUS''
 LEFT JOIN (SELECT tc.supplier_info_id,
                    tc.company_id,
                    listagg(DISTINCT gb.group_dict_name, '';'') within GROUP(ORDER BY gb.group_dict_value) cate_name
               FROM scmdata.t_coop_scope tc
              INNER JOIN group_dict gb
                 ON gb.group_dict_value = tc.coop_classification
                AND gb.group_dict_type = ''PRODUCT_TYPE''
              WHERE tc.company_id = %default_company_id%
              GROUP BY tc.supplier_info_id, tc.company_id) va
    ON va.supplier_info_id = t.supplier_info_id
   AND va.company_id = t.company_id
 WHERE t.company_id = %default_company_id%
   AND t.pause <> 1
   AND t.status = 1', null, null, null, null, null, 'SUPPLIER_INFO_ID', null, null, null, null, null, 1, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, 0, '20,30,50,100,200,500');

/*insert into bw3.sys_element (ELEMENT_ID, ELEMENT_TYPE, DATA_SOURCE, PAUSE, MESSAGE, IS_HIDE, MEMO, IS_ASYNC, IS_PER_EXE, ENABLE_STAND_PERMISSION)
values ('associate_a_supp_160_1_1', 'associate', 'oracle_scmdata', 0, null, 1, null, null, null, null);

insert into bw3.sys_associate (NODE_ID, ELEMENT_ID, FIELD_NAME, ASSOCIATE_TYPE, CAPTION, ICON_NAME, DATA_TYPE, DATA_SQL, OPEN_TYPE)
values ('node_a_supp_161', 'associate_a_supp_160_1_1', 'SUPPLIER_INFO_ID', 6, '查看详情', null, 2, null, null);

insert into bw3.sys_item_element_rela (ITEM_ID, ELEMENT_ID, SEQ_NO, PAUSE, LEVEL_NO)
values ('a_report_140', 'associate_a_supp_160_1_1', 1, 0, null);

insert into bw3.sys_element_hint (ITEM_ID, ELEMENT_ID, MESSAGE, PAUSE, LINK_NAME, JUDGE_FIELD, HINT_TYPE)
values ('a_report_140', 'associate_a_supp_160_1_1', null, 0, 'SUPPLIER_COMPANY_NAME', null, null);*/

END;
/
