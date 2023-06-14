--配置data_source
select rowid,t.* FROM nbw.sys_data_source t;--20,30,50,100,200,500
--表结构修改
--scmdata.T_PLAT_LOGS
--FIELD_DESC varchar2(256)
--页面配置
SELECT rowid,t.* from nbw.sys_item t WHERE t.item_id IN ('a_quotation_100','a_quotation_110','a_quotation_210','a_quotation_310','a_quotation_410','a_quotation_510');
SELECT rowid,t.* from nbw.sys_tree_list t WHERE t.item_id IN ('a_quotation_100','a_quotation_110','a_quotation_210','a_quotation_310','a_quotation_410','a_quotation_510');
SELECT rowid,t.* from nbw.sys_item_list t WHERE t.item_id IN ('a_quotation_100','a_quotation_110','a_quotation_210','a_quotation_310','a_quotation_410','a_quotation_510');
SELECT rowid,t.* from nbw.sys_web_union t WHERE t.item_id = 'a_quotation_100';
SELECT rowid,t.* from nbw.sys_item_rela t WHERE t.item_id = 'a_quotation_110'; 

--报价明细

SELECT rowid,t.* from nbw.sys_item t WHERE t.item_id IN ('a_quotation_111','a_quotation_111_1','a_quotation_111_2','a_quotation_111_3','a_quotation_111_4','a_quotation_111_5','a_quotation_111_6','a_quotation_111_7');
SELECT rowid,t.* from nbw.sys_tree_list t WHERE t.item_id IN ('a_quotation_110','a_quotation_111','a_quotation_111_1','a_quotation_111_2','a_quotation_111_3','a_quotation_111_4','a_quotation_111_5','a_quotation_111_6','a_quotation_111_7');
SELECT rowid,t.* from nbw.sys_item_list t WHERE t.item_id IN ('a_quotation_110','a_quotation_111','a_quotation_111_1','a_quotation_111_2','a_quotation_111_3','a_quotation_111_4','a_quotation_111_5','a_quotation_111_6','a_quotation_111_7');

SELECT rowid,t.* from nbw.sys_element t WHERE t.element_id IN ('associate_a_quotation_111','associate_a_quotation_211','associate_a_quotation_410');
SELECT rowid,t.* from nbw.sys_associate t WHERE t.element_id IN ('associate_a_quotation_111','associate_a_quotation_211','associate_a_quotation_410');
SELECT rowid,t.* from nbw.sys_item_element_rela t WHERE t.element_id IN ('associate_a_quotation_111','associate_a_quotation_211','associate_a_quotation_410');
SELECT rowid,t.* from nbw.sys_element_hint t WHERE t.item_id IN ('a_quotation_110','a_quotation_210','a_quotation_310'); --QUOTATION_DETAILS

--从表 
SELECT rowid,t.* from nbw.sys_item_rela t WHERE t.item_id = 'a_quotation_111'; --a_quotation_111_1  
SELECT rowid,t.* from nbw.sys_element t WHERE t.element_id IN ('pick_a_quotation_110','pick_a_quotation_111_2','assign_a_supp_131');
SELECT rowid,t.* from nbw.sys_field_control t WHERE t.element_id = 'control_a_quotation_111_5';--pick_a_quotation_111_5
SELECT rowid,t.* from nbw.sys_pick_list t WHERE t.element_id IN ('pick_a_quotation_110','pick_a_quotation_111_2','pick_a_quotation_111_3','pick_a_quotation_111_5');
SELECT ROWID,t.* FROM nbw.sys_default t WHERE t.element_id = 'default_a_quotation_112';
SELECT rowid,t.* from nbw.sys_assign t  WHERE t.element_id = 'assign_a_supp_131';
SELECT rowid,t.* from nbw.sys_span t WHERE t.element_id = 'a_quotation_111_2'; 
SELECT rowid,t.* from nbw.sys_look_up t WHERE t.element_id in ('look_a_quotation_111_2_1','look_a_quotation_111_5_3'); 
SELECT rowid,t.* from nbw.sys_item_element_rela t WHERE t.element_id IN ('pick_a_quotation_110','pick_a_quotation_111_2','assign_a_supp_131');

--权限控制cond list   a_quotation_111_5 
SELECT rowid,t.* from nbw.sys_cond_list t WHERE t.cond_id IN ('cond_a_quotation_111_5','cond_a_quotation_111','cond_a_quotation_111_6');
SELECT rowid,t.* from nbw.sys_cond_rela t WHERE t.cond_id IN ('cond_a_quotation_111_5','cond_a_quotation_111','cond_a_quotation_111_6'); 

--按钮  action_a_quotation_111_5 废弃
SELECT rowid,t.* from nbw.sys_element t WHERE t.element_id IN ('action_a_quotation_111_5');
SELECT rowid,t.* from nbw.sys_action t WHERE t.element_id IN ('action_a_quotation_111_5','action_a_quotation_111','action_a_approve_111_0');
SELECT rowid,t.* from nbw.sys_item_element_rela t WHERE t.element_id IN ('action_a_quotation_111_5');

--oracle_plm
SELECT rowid,t.* from nbw.sys_field_list t WHERE t.field_name IN ('TRIALORDER_TYPE','SHOE_CRAFT_CATEGORY','SHOE_PACKING_TYPE','SHOE_PACKING_NUMBER','SHOE_TRANSPORTATION_ROUTE','SHOE_SELECT');
SELECT rowid,t.* from nbw.sys_param_list t WHERE t.param_name IN ('TRIALORDER_TYPE','SHOE_CRAFT_CATEGORY','SHOE_PACKING_TYPE','SHOE_PACKING_NUMBER','SHOE_TRANSPORTATION_ROUTE','SHOE_SELECT'); 


SELECT rowid,t.* from nbw.sys_item_element_rela t WHERE t.element_id = 'associate_a_quotation_410';   

--字段控制
SELECT rowid,t.* from nbw.sys_element t WHERE t.element_id IN ('control_a_outmaterial_110_1','control_a_quotation_111_5','control_a_quotation_111_3');
SELECT rowid,t.* from nbw.sys_field_control t WHERE t.element_id IN ('control_a_outmaterial_110_1','control_a_quotation_111_5','control_a_quotation_111_3');--pick_a_quotation_111_5
SELECT rowid,t.* from nbw.sys_item_element_rela t WHERE t.element_id IN ('control_a_outmaterial_110_1','control_a_quotation_111_5','control_a_quotation_111_3');

--quotation_status  

SELECT rowid,t.* from nbw.sys_look_up t WHERE t.element_id LIKE '%a_quotation%';
SELECT rowid,t.* from nbw.sys_field_list t WHERE t.field_name IN ('STYLE_PICTURE_FJ','PATTERN_FILE','MARKER_FILE','PICTURE','STYLE_PICTURE_QT','PICTURE1');
SELECT rowid,t.* FROM nbw.sys_field_list_file t WHERE t.field_name IN ('STYLE_PICTURE_FJ','PATTERN_FILE','MARKER_FILE','STYLE_PICTURE_NAME','PATTERN_FILE_NAME','MARKER_FILE_NAME');
SELECT rowid,t.* from nbw.sys_blob_list t ;
STYLE_PICTURE_FJ
--181
SELECT rowid,t.* from bw3.sys_blob_list t;
SELECT rowid,t.* from nsfdata.allmails t;
SELECT * from sfsys.itemlist t WHERE t.itemid = 4;

SELECT * from nbw.sys_mongo_source;
SELECT t.data_type_flag from nbw.sys_field_list t WHERE t.data_type_flag IS NOT NULL;
SELECT rowid,t.* from nbw.SYS_DATA_SOURCE t;
SELECT rowid,t.* from nbw.SYS_APP t;--DB#oracle_scmdata

plm.pkg_quotation
