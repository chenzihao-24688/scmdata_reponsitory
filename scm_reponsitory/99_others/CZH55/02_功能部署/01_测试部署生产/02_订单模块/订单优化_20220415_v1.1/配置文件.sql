--配置中心
--相关包 增加校验逻辑
--scmdata.pkg_a_config_lib ,pkg_plat_comm,pkg_production_progress_a,pkg_plat_log, ,pkg_supp_order_coor,pkg_report_analy
--trg_af_iu_t_orders,trg_af_iu_t_ordered,trg_af_iu_t_ordered,trg_af_u_t_production_progress
--相关表新增字段
--t_product_progress
--生产节点配置
SELECT ROWID, t.* FROM nbw.sys_item_list t WHERE t.item_id in ('a_config_121_1','a_config_121_2');
select rowid,t.* from nbw.sys_element t where t.element_id in ('look_a_config_121_2');
select rowid,t.* from nbw.sys_look_up t where t.element_id = 'look_a_config_121_2';
select rowid,t.* from nbw.sys_item_element_rela t where t.element_id in ('look_a_config_121_2');
--select rowid,t.* from nbw.sys_pick_list t where t.element_id = 'pick_a_config_121_2'; 
--select rowid,t.* from nbw.sys_item_rela t where t.item_id = 'a_config_121';

/*select rowid,t.* from nbw.sys_item t where t.item_id in ('a_config_121','a_config_121_1','a_config_121_2','a_qcqa_121','a_qcqa_122_v2_0','a_qcqa_122_v2_1');
select rowid,t.* from nbw.sys_tree_list t where t.item_id in ('a_config_121','a_config_121_1','a_config_121_2','a_qcqa_121','a_qcqa_122_v2_0','a_qcqa_122_v2_1');
select rowid,t.* from nbw.sys_item_list t where t.item_id in ('a_config_121','a_config_121_1','a_config_121_2','a_qcqa_121','a_qcqa_122_v2_0','a_qcqa_122_v2_1');
select rowid,t.* from nbw.sys_web_union t where t.item_id in ('a_config_121','a_config_121_1','a_config_121_2','a_qcqa_121','a_qcqa_122_v2_0','a_qcqa_122_v2_1');
*/
--采购方
--生产进度
select rowid,t.* from nbw.sys_item_rela t where t.relate_id = 'a_product_111';
SELECT ROWID, t.* FROM nbw.sys_item_list t WHERE t.item_id in ('a_product_110','a_product_150','a_product_116','a_product_120_2');
select rowid,t.* from nbw.sys_element t where t.element_id in ('look_a_product_110_10','look_a_product_110_11');
select rowid,t.* from nbw.sys_look_up t where t.element_id in ('look_a_product_110_10','look_a_product_110_11','look_a_product_110_1');--look_a_product_110_10,action_a_product_118_2
select rowid,t.* from nbw.sys_item_element_rela t where t.element_id in ('look_a_product_110_10','look_a_product_110_11','look_a_product_110_1','look_a_product_110_12'); --a_product_120_2

--跟进日志
select rowid,t.* from nbw.sys_item t  where t.item_id in ('a_product_111_1','a_product_111_2');
select rowid,t.* from nbw.sys_tree_list t  where t.item_id in ('a_product_111_1','a_product_111_2');
select rowid,t.* from nbw.sys_item_list t  where t.item_id in ('a_product_111_1','a_product_111_2');
select rowid,t.* from nbw.sys_item_rela t where t.relate_id in ('a_product_111_1','a_product_111_2'); 
--批量复制进度
select rowid,t.* from nbw.sys_element t where t.element_id in ('action_a_product_110_1','action_a_product_110_6','action_a_product_110_4'); 
select rowid,t.* from nbw.sys_action t where t.element_id in ('action_a_product_110_1','action_a_product_110_6','action_a_product_110_4'); 
select rowid,t.* from nbw.sys_item_element_rela t where t.element_id in ('action_a_product_110_1','action_a_product_110_6','action_a_product_110_4'); 
select rowid,t.* from nbw.sys_field_list t where t.field_name like '%IS_PRODUCT_ORDER%';
select rowid,t.* from nbw.sys_field_list t where t.caption like '%生产订单%';

--异常处理单 
select rowid,t.* from nbw.sys_action t where t.element_id in ('action_a_product_118_2','action_a_product_118_3','action_a_product_118_4'); 

--供应商端
select rowid,t.* from nbw.sys_item t  where t.item_id in ('a_product_210','a_product_217','a_product_216');
select rowid,t.* from nbw.sys_tree_list t  where t.item_id in ('a_product_210','a_product_217','a_product_216');
select rowid,t.* from nbw.sys_item_list t  where t.item_id in ('a_product_210','a_product_217','a_product_216');
select rowid,t.* from nbw.sys_item_rela t  where t.item_id in ('a_product_210','a_product_217','a_product_216');

select rowid,t.* from nbw.sys_element t where t.element_id in ('look_a_product_210_10');
select rowid,t.* from nbw.sys_look_up t where t.element_id in ('look_a_product_210_10');
select rowid,t.* from nbw.sys_item_element_rela t where t.element_id in ('look_a_product_210_10'); 

--订单管理 a_order_201_3
select rowid,t.* from nbw.sys_item t  where t.item_id in ('a_order_201_3','a_order_201_10','a_order_101_0');
select rowid,t.* from nbw.sys_tree_list t  where t.item_id in ('a_order_201_3','a_order_201_10');
select rowid,t.* from nbw.sys_item_list t  where t.item_id in ('a_order_201_3','a_order_201_10','a_order_101_0');
select rowid,t.* from nbw.sys_item_rela t where t.relate_id in ('a_order_201_3','a_order_201_10'); 

select rowid,t.* from nbw.sys_action t where t.element_id in ('action_a_order_102','action_order_101_0_1','action_order_101_0_2'); 
select rowid,t.* from nbw.sys_element t where t.element_id in ('lookup_order_101_0');
select rowid,t.* from nbw.sys_look_up t where t.element_id in ('lookup_order_101_0');
select rowid,t.* from nbw.sys_item_element_rela t where t.element_id in ('lookup_order_101_0');--a_order_101_0,a_order_101_1,a_order_201_0,a_order_201_1,a_order_201_4
--供应商端
select rowid,t.* from nbw.sys_item_list t  where t.item_id in ('a_order_201_3','a_order_201_10','a_order_101_0');
select rowid,t.* from nbw.sys_item_list t  where t.item_id in ('a_order_201_0','a_order_201_1','a_order_201_4'); --deal_follower

--报表
select rowid,t.* from nbw.sys_item_list t  where t.item_id in ('a_report_delivery_101_1','a_report_prostatus_100'); --deal_follower
select rowid,t.* from nbw.sys_pivot_list t where t.pivot_id in ('p_a_report_abn_101','p_a_report_prostatus_100');

select rowid,t.* from nbw.sys_field_list t ;
