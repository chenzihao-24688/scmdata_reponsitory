begin
insert into bw3.sys_element (ELEMENT_ID, ELEMENT_TYPE, DATA_SOURCE, PAUSE, MESSAGE, IS_HIDE, MEMO, IS_ASYNC, IS_PER_EXE, ENABLE_STAND_PERMISSION)
values ('action_a_supp_151_7_1', 'action', 'oracle_scmdata', 0, null, 0, null, null, null, null);

insert into bw3.sys_element (ELEMENT_ID, ELEMENT_TYPE, DATA_SOURCE, PAUSE, MESSAGE, IS_HIDE, MEMO, IS_ASYNC, IS_PER_EXE, ENABLE_STAND_PERMISSION)
values ('action_a_supp_151_7_2', 'action', 'oracle_scmdata', 0, null, 0, null, null, null, null);

insert into bw3.sys_action (ELEMENT_ID, CAPTION, ICON_NAME, ACTION_TYPE, ACTION_SQL, SELECT_FIELDS, REFRESH_FLAG, MULTI_PAGE_FLAG, PRE_FLAG, FILTER_EXPRESS, UPDATE_FIELDS, PORT_ID, PORT_SQL, LOCK_SQL, SELECTION_FLAG, CALL_ID, OPERATE_MODE, PORT_TYPE, QUERY_FIELDS, SELECTION_METHOD)
values ('action_a_supp_151_7_1', 'ÆôÓÃ', 'icon-morencaidan', 4, 'BEGIN
  FOR a_rec IN (SELECT t.company_id, t.coop_factory_id
                  FROM scmdata.t_coop_factory t
                 WHERE t.company_id = %default_company_id%
                   AND t.coop_factory_id IN (@selection)) LOOP
    scmdata.pkg_supplier_info.p_coop_fac_pause(p_company_id      => a_rec.company_id,
                                               p_coop_factory_id => a_rec.coop_factory_id,
                                               p_user_id         => :user_id,
                                               p_status          => 0);
  END LOOP;
END;
', 'COOP_FACTORY_ID', 1, 1, 0, null, null, null, null, null, 0, null, null, 1, null, null);

insert into bw3.sys_action (ELEMENT_ID, CAPTION, ICON_NAME, ACTION_TYPE, ACTION_SQL, SELECT_FIELDS, REFRESH_FLAG, MULTI_PAGE_FLAG, PRE_FLAG, FILTER_EXPRESS, UPDATE_FIELDS, PORT_ID, PORT_SQL, LOCK_SQL, SELECTION_FLAG, CALL_ID, OPERATE_MODE, PORT_TYPE, QUERY_FIELDS, SELECTION_METHOD)
values ('action_a_supp_151_7_2', 'Í£ÓÃ', 'icon-morencaidan', 4, 'BEGIN
  FOR a_rec IN (SELECT t.company_id, t.coop_factory_id
                  FROM scmdata.t_coop_factory t
                 WHERE t.company_id = %default_company_id%
                   AND t.coop_factory_id IN (@selection)) LOOP
    scmdata.pkg_supplier_info.p_coop_fac_pause(p_company_id      => a_rec.company_id,
                                               p_coop_factory_id => a_rec.coop_factory_id,
                                               p_user_id         => :user_id,
                                               p_status          => 1);
  END LOOP;
END;
', 'COOP_FACTORY_ID', 1, 1, 0, null, null, null, null, null, 0, null, null, 1, null, null);

insert into bw3.sys_item_element_rela (ITEM_ID, ELEMENT_ID, SEQ_NO, PAUSE, LEVEL_NO)
values ('a_supp_151_7', 'action_a_supp_151_7_1', 1, 0, null);

insert into bw3.sys_item_element_rela (ITEM_ID, ELEMENT_ID, SEQ_NO, PAUSE, LEVEL_NO)
values ('a_supp_151_7', 'action_a_supp_151_7_2', 1, 0, null);
end;
