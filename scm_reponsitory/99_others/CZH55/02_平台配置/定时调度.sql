--定时调度
select t.*,rowid from  nbw.sys_item t where t.ITEM_ID in ('pj_xxl_job','pj_xxl_job_mgr','pj_xxl_job_group');
select t.*,rowid from  nbw.sys_tree_list t where t.ITEM_ID in ('pj_xxl_job','pj_xxl_job_mgr','pj_xxl_job_group');
select t.*,rowid from  nbw.sys_item_list t where t.item_id in ('pj_xxl_job','pj_xxl_job_mgr','pj_xxl_job_group');

select rowid, t.* from nbw.sys_item t where t.item_id like '%pj_xxl%';
select rowid, t.* from nbw.sys_tree_list t where t.item_id like '%pj_xxl%';
select rowid, t.* from nbw.sys_item_list t where t.item_id like '%pj_xxl%';
select rowid,t.* from nbw.sys_field_list t where t.field_name like '%pj_xxl%';

select rowid,t.* from nbw.sys_element t where t.element_id like '%pj_xxl%';
select rowid,t.* from nbw.sys_look_up t where t.element_id like '%pj_xxl%'; 
select rowid,t.* from nbw.sys_action t where t.element_id like '%pj_xxl%';  
select rowid,t.* from nbw.sys_item_element_rela t where t.element_id like '%pj_xxl%';

XXL_JOB_INFO 

insert into sys_element
  (ELEMENT_ID, ELEMENT_TYPE, DATA_SOURCE, PAUSE, MESSAGE)
values
  ('pj_xxl_job_lp_ADDRESS_TYPE', 'lookup', 'scm_nbw', 0, null);

insert into sys_look_up
  (ELEMENT_ID,
   FIELD_NAME,
   LOOK_UP_SQL,
   DATA_TYPE,
   KEY_FIELD,
   RESULT_FIELD,
   BEFORE_FIELD)
values
  ('pj_xxl_job_lp_ADDRESS_TYPE',
   'ADDRESS_TYPE_NAME',
   '
select ''0'' ADDRESS_TYPE,''自动注册'' ADDRESS_TYPE_NAME from DUAL union
select ''1'' ADDRESS_TYPE,''手动注册'' ADDRESS_TYPE_NAME from DUAL',
   '1',
   'ADDRESS_TYPE',
   'ADDRESS_TYPE_NAME',
   NULL);

insert into sys_item_element_rela
  (ITEM_ID, ELEMENT_ID, SEQ_NO, PAUSE, LEVEL_NO)
values
  ('pj_xxl_job_group', 'pj_xxl_job_lp_ADDRESS_TYPE', 1, 0, 1);
