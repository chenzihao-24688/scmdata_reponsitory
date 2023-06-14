begin
insert into bw3.sys_element (ELEMENT_ID, ELEMENT_TYPE, DATA_SOURCE, PAUSE, MESSAGE, IS_HIDE, MEMO, IS_ASYNC, IS_PER_EXE, ENABLE_STAND_PERMISSION)
values ('associate_a_supp_151_7', 'associate', 'oracle_scmdata', 0, null, null, null, null, null, null);

insert into bw3.sys_associate (NODE_ID, ELEMENT_ID, FIELD_NAME, ASSOCIATE_TYPE, CAPTION, ICON_NAME, DATA_TYPE, DATA_SQL, OPEN_TYPE)
values ('node_a_supp_161', 'associate_a_supp_151_7', 'COOP_FACTORY_ID', 6, '²é¿´ÏêÇé', null, 2, 'select t.fac_sup_info_id SUPPLIER_INFO_ID from scmdata.t_coop_factory t where t.coop_factory_id = :COOP_FACTORY_ID
--select t.fac_sup_info_id||'';''||t.is_qr_sup SUPPLIER_INFO_ID from scmdata.t_coop_factory t where t.coop_factory_id =  :COOP_FACTORY_ID', null);

insert into bw3.sys_item_element_rela (ITEM_ID, ELEMENT_ID, SEQ_NO, PAUSE, LEVEL_NO)
values ('a_supp_151_7', 'associate_a_supp_151_7', 2, 0, null);
end;



