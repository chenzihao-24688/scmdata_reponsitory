begin
insert into bw3.sys_element (ELEMENT_ID, ELEMENT_TYPE, DATA_SOURCE, PAUSE, MESSAGE, IS_HIDE, MEMO, IS_ASYNC, IS_PER_EXE, ENABLE_STAND_PERMISSION)
values ('action_c_2413_1', 'action', 'oracle_scmdata', 0, null, 1, null, null, null, null);

insert into bw3.sys_action (ELEMENT_ID, CAPTION, ICON_NAME, ACTION_TYPE, ACTION_SQL, SELECT_FIELDS, REFRESH_FLAG, MULTI_PAGE_FLAG, PRE_FLAG, FILTER_EXPRESS, UPDATE_FIELDS, PORT_ID, PORT_SQL, LOCK_SQL, SELECTION_FLAG, CALL_ID, OPERATE_MODE, PORT_TYPE, QUERY_FIELDS, SELECTION_METHOD)
values ('action_c_2413_1', '查看数据权限', 'icon-morencaidan', 5, 'SELECT h.data_priv_code, h.data_priv_name
  FROM scmdata.sys_company_data_priv_group b
 INNER JOIN scmdata.sys_company_data_priv_middle g
    ON b.company_id = g.company_id
   AND b.data_priv_group_id = g.data_priv_group_id
 INNER JOIN scmdata.sys_data_privs h
    ON h.data_priv_id = g.data_priv_id
   AND h.pause = 1
 WHERE b.company_id = %default_company_id%
   AND b.data_priv_group_code = :data_priv_group_code', null, 0, 1, 0, null, null, null, null, null, 0, null, null, 1, null, null);

update bw3.sys_item_element_rela t set t.element_id = 'action_c_2413_1',t.seq_no = 1  where t.item_id = 'c_2413';

insert into bw3.sys_element_hint values('c_2413','action_c_2413_1','',0,'DATA_PRIV_GROUP_NAME','','');

insert into bw3.sys_element_hint values('c_2412','action_c_2412_1','',0,'DATA_PRIV_GROUP_NAME','','');

insert into bw3.sys_item_element_rela values('c_2413','pick_c_2411_1',1,0,'');

end;



