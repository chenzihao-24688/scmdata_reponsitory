/*SELECT *
  FROM scmdata.sys_group_dict t
 WHERE t.group_dict_value = 'BRA_00'
   AND t.group_dict_type = 'COOPERATION_BRAND';
   
select * from  scmdata.sys_group_dict t WHERE t.group_dict_type = 'BRA_00';
select * from scmdata.sys_group_dict t WHERE t.group_dict_type = 'BRA_01';
select * from scmdata.sys_group_dict t WHERE t.group_dict_type = 'BRA_02';
select * from  scmdata.sys_group_dict t WHERE t.group_dict_type = 'BRA_03';

DELETE FROM scmdata.sys_group_dict t WHERE t.group_dict_type = 'BRA_00';
DELETE FROM scmdata.sys_group_dict t WHERE t.group_dict_type = 'BRA_01';
DELETE FROM scmdata.sys_group_dict t WHERE t.group_dict_type = 'BRA_02';
DELETE FROM scmdata.sys_group_dict t WHERE t.group_dict_type = 'BRA_03';*/
begin
DELETE FROM scmdata.sys_group_dict t WHERE t.group_dict_type = 'BRA_00';
DELETE FROM scmdata.sys_group_dict t WHERE t.group_dict_type = 'BRA_01';
DELETE FROM scmdata.sys_group_dict t WHERE t.group_dict_type = 'BRA_02';
DELETE FROM scmdata.sys_group_dict t WHERE t.group_dict_type = 'BRA_03';
end;
DECLARE
v_count number := 0;
BEGIN
 for i in (select a.col_1,a.col_2,a.col_3,a.col_4 from scmdata.t_excel_import a) loop
 v_count := v_count + 1 ;
 if i.col_1 is null then 
   null;
   else
      insert into scmdata.sys_group_dict (GROUP_DICT_ID, PARENT_ID, PARENT_IDS, GROUP_DICT_NAME, GROUP_DICT_VALUE, GROUP_DICT_TYPE, DESCRIPTION, GROUP_DICT_SORT, GROUP_DICT_STATUS, TREE_LEVEL, IS_LEAF, IS_INITIAL, CREATE_ID, CREATE_TIME, UPDATE_ID, UPDATE_TIME, REMARKS, DEL_FLAG, PAUSE, IS_COMPANY_DICT_RELA)
values (scmdata.f_get_uuid(), 'c9e4a48cd6ee3a71e0533c281caca337', 'c9e4a48cd6ee3a71e0533c281caca337', i.col_1, 'BRA_00'||''||lpad(v_count,3,0) ||'', 'BRA_00', null, v_count, '1', 1, 1, 0, 'ADMIN', sysdate, 'ADMIN', sysdate, null, 0, 0, '0');

   end if;
   
   if i.col_2 is null then 
   null;
   else
      insert into scmdata.sys_group_dict (GROUP_DICT_ID, PARENT_ID, PARENT_IDS, GROUP_DICT_NAME, GROUP_DICT_VALUE, GROUP_DICT_TYPE, DESCRIPTION, GROUP_DICT_SORT, GROUP_DICT_STATUS, TREE_LEVEL, IS_LEAF, IS_INITIAL, CREATE_ID, CREATE_TIME, UPDATE_ID, UPDATE_TIME, REMARKS, DEL_FLAG, PAUSE, IS_COMPANY_DICT_RELA)
values (scmdata.f_get_uuid(), 'c9e4a48cd6ef3a71e0533c281caca337', 'c9e4a48cd6ef3a71e0533c281caca337', i.col_2, 'BRA_01'||''||lpad(v_count,2,0) ||'', 'BRA_01', null, v_count, '1', 1, 1, 0, 'ADMIN', sysdate, 'ADMIN', sysdate, null, 0, 0, '0');

   end if;
     
   if i.col_3 is null then 
   null;
   else
      insert into scmdata.sys_group_dict (GROUP_DICT_ID, PARENT_ID, PARENT_IDS, GROUP_DICT_NAME, GROUP_DICT_VALUE, GROUP_DICT_TYPE, DESCRIPTION, GROUP_DICT_SORT, GROUP_DICT_STATUS, TREE_LEVEL, IS_LEAF, IS_INITIAL, CREATE_ID, CREATE_TIME, UPDATE_ID, UPDATE_TIME, REMARKS, DEL_FLAG, PAUSE, IS_COMPANY_DICT_RELA)
values (scmdata.f_get_uuid(), 'c9e4a48cd6f03a71e0533c281caca337', 'c9e4a48cd6f03a71e0533c281caca337', i.col_3, 'BRA_02'||''||lpad(v_count,2,0) ||'', 'BRA_02', null, v_count, '1', 1, 1, 0, 'ADMIN', sysdate, 'ADMIN', sysdate, null, 0, 0, '0');

   end if;
     
   if i.col_4 is null then 
   null;
   else
      insert into scmdata.sys_group_dict (GROUP_DICT_ID, PARENT_ID, PARENT_IDS, GROUP_DICT_NAME, GROUP_DICT_VALUE, GROUP_DICT_TYPE, DESCRIPTION, GROUP_DICT_SORT, GROUP_DICT_STATUS, TREE_LEVEL, IS_LEAF, IS_INITIAL, CREATE_ID, CREATE_TIME, UPDATE_ID, UPDATE_TIME, REMARKS, DEL_FLAG, PAUSE, IS_COMPANY_DICT_RELA)
values (scmdata.f_get_uuid(), 'c9e4a48cd6f13a71e0533c281caca337', 'c9e4a48cd6f13a71e0533c281caca337', i.col_4, 'BRA_03'||''||lpad(v_count,2,0) ||'', 'BRA_03', null, v_count, '1', 1, 1, 0, 'ADMIN', sysdate, 'ADMIN', sysdate, null, 0, 0, '0');

   end if;
 end loop;
END;
