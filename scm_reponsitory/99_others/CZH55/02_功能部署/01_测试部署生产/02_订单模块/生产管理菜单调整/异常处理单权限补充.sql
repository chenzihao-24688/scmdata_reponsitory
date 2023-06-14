begin
insert into bw3.sys_cond_list (COND_ID, COND_SQL, COND_TYPE, SHOW_TEXT, DATA_SOURCE, COND_FIELD_NAME, MEMO)
values ('cond_node_a_product_200', 'select pkg_plat_comm.F_USERHASACTION_APP_SEE(%Current_UserID%,%Default_Company_ID%,''apply_16'') from dual', 0, null, 'oracle_scmdata', null, null);
insert into bw3.sys_cond_rela (COND_ID, OBJ_TYPE, CTL_ID, CTL_TYPE, SEQ_NO, PAUSE, ITEM_ID)
values ('cond_node_a_product_200', 0, 'node_a_product_200', 0, 1, 1, null);
end;
