--供应商档案管理  

--业务表
SELECT t.rowid, t.* FROM scmdata.t_supplier_info t;
SELECT ROWID, t.* FROM scmdata.t_factory_ask t;
SELECT ROWID, t.* FROM scmdata.t_factory_report t;
SELECT ROWID, t.* FROM scmdata.t_apply_form t;
select ROWID, ar.* from scmdata.t_ask_record  ar;

--配置表
SELECT ROWID, t.* FROM nbw.sys_item t WHERE t.item_id like '%a_supp_%';
SELECT ROWID, t.* FROM nbw.sys_tree_list t WHERE t.item_id like '%a_supp_%';
SELECT ROWID, t.* FROM nbw.sys_item_list t WHERE t.item_id like '%a_supp_%'; --node_a_coop_100
select rowid,t.* from nbw.sys_item_rela t  WHERE t.item_id like '%a_supp_%';--主从表
select rowid,t.* from nbw.sys_detail_group t WHERE t.item_id like '%a_supp_%';

--字段
INSERT INTO nbw.sys_field_list (field_name,caption,requiered_flag,read_only_flag,no_edit,no_copy,no_sort,alignment,ime_care,ime_open)
VALUES('GOO_ID', '货号', 0, 0, 0, 0, 0, 0, 0, 0);
--按钮
select rowid,t.* from nbw.sys_element t  ; 
select rowid,t.* from nbw.sys_action t  ;
select rowid,t.* from nbw.sys_item_element_rela t ;
--a_supp_110
select rowid,t.* from sys_item t ;

select rowid,t.* from nbw.sys_shortcut t ;

select rowid,t.* from nbw.sys_shortcut_node_rela t ;

select rowid,t.* from nbw.sys_item_custom t ;


SELECT ROWID, t.* FROM nbw.sys_element t;
SELECT ROWID, t.* FROM nbw.sys_associate t;
SELECT ROWID, t.* FROM nbw.sys_item_element_rela t;
--字段配置
SELECT ROWID, t.* FROM nbw.sys_element t;
SELECT ROWID, t.* FROM nbw.sys_look_up t;
SELECT ROWID, t.* FROM nbw.sys_item_element_rela t;
SELECT ROWID, t.* FROM nbw.sys_param_list t;

SELECT ROWID, t.* FROM nbw.sys_field_list t;



