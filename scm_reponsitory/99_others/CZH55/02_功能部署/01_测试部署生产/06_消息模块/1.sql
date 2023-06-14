???prompt Importing table nbw.sys_cond_list...
set feedback off
set define off
insert into nbw.sys_cond_list (COND_ID, COND_SQL, COND_TYPE, SHOW_TEXT, DATA_SOURCE, COND_FIELD_NAME, MEMO)
values ('cond_hint_2104125726584782', 'SELECT MAX(1)
    FROM dual
   WHERE pkg_msg_config.check_person(p_company_id   => %default_company_id%,
                                     p_user_id      => %user_id%,
                                     p_group_msg_id => ''bfbf206e13fc0acae0533c281cace147'') = 1', null, null, 'oracle_scmdata', null, null);

insert into nbw.sys_cond_list (COND_ID, COND_SQL, COND_TYPE, SHOW_TEXT, DATA_SOURCE, COND_FIELD_NAME, MEMO)
values ('cond_hint_2104126014018883', 'SELECT MAX(1)
    FROM dual
   WHERE pkg_msg_config.check_person(p_company_id   => %default_company_id%,
                                     p_user_id      => %user_id%,
                                     p_group_msg_id => ''bfc37de4157f36e1e0533c281cac3b4f'') = 1', null, null, 'oracle_scmdata', null, null);

insert into nbw.sys_cond_list (COND_ID, COND_SQL, COND_TYPE, SHOW_TEXT, DATA_SOURCE, COND_FIELD_NAME, MEMO)
values ('cond_hint_2104126118444984', 'SELECT MAX(1)
    FROM dual
   WHERE pkg_msg_config.check_person(p_company_id   => %default_company_id%,
                                     p_user_id      => %user_id%,
                                     p_group_msg_id => ''bfc37de4158036e1e0533c281cac3b4f'') = 1', null, null, 'oracle_scmdata', null, null);

insert into nbw.sys_cond_list (COND_ID, COND_SQL, COND_TYPE, SHOW_TEXT, DATA_SOURCE, COND_FIELD_NAME, MEMO)
values ('cond_hint_2104126153891885', 'SELECT MAX(1)
    FROM dual
   WHERE pkg_msg_config.check_person(p_company_id   => %default_company_id%,
                                     p_user_id      => %user_id%,
                                     p_group_msg_id => ''bfbf206e13fd0acae0533c281cace147'') = 1', null, null, 'oracle_scmdata', null, null);

prompt Done.
