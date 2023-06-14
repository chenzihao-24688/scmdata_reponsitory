DECLARE
v_str1 clob;
v_str2 clob;
v_str3 clob;
v_str4 clob;
BEGIN
v_str1 := q'[DATA_PRIV_ID,DATA_PRIV_CODE,COMPANY_ID,cooperation_type,cooperation_classification,cooperation_product_cate,PRODUCTION_CATEGORY_DESC]';

v_str2 := q'[select A.GROUP_DICT_NAME COOP_TYPE_DESC ,A.Group_Dict_Value COOPERATION_TYPE,
       B.GROUP_DICT_NAME COOP_CLASSIFICATION_DESC,B.Group_Dict_Value cooperation_classification--,
       --c.GROUP_DICT_NAME PRODUCTION_CATEGORY_DESC,c.Group_Dict_Value cooperation_product_cate
  from sys_group_dict a 
 left join sys_group_dict b on a.group_dict_value=b.group_dict_type
  left join sys_group_dict c on b.group_dict_value=c.group_dict_type
  where a.group_dict_type='COOPERATION_TYPE']';
  
v_str3 :=q'[COOP_TYPE_DESC,COOP_CLASSIFICATION_DESC]';

update bw3.sys_item_list t set t.noshow_fields = v_str1 WHERE t.item_id = 'c_2058';
update bw3.sys_pick_list t set t.pick_sql = v_str2,t.tree_fields = v_str3 where t.element_id = 'pick_c_2058';

insert into bw3.sys_item_element_rela values('c_2076','pick_c_2058','1','0',null);

END;

