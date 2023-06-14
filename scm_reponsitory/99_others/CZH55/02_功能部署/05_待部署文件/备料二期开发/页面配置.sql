--基础包
--mrp.pkg_color_prepare_order
--mrp.pkg_color_prepare_product_order

--坯布出入库、明细
--mrp.pkg_supplier_grey_in_out_bound
--mrp.pkg_supplier_grey_stock
--mrp.pkg_MATERIAL_GREY_IN_OUT_BOUND
--mrp.pkg_MATERIAL_GREY_STOCK

--mrp.PKG_COLOR_PREPARE_BATCH_FINISH_ORDER

--色布出入库、明细
--mrp.PKG_SUPPLIER_COLOR_IN_OUT_BOUND
--mrp.pkg_supplier_color_cloth_stock
--mrp.PKG_MATERIAL_COLOR_IN_OUT_BOUND
--mrp.PKG_MATERIAL_COLOR_CLOTH_STOCK

--业务包
--mrp.pkg_color_prepare_order_manager  
--数据校验包
--mrp.pkg_check_data_comm
--mrp.pkg_plat_comm
--SCMDATA.pkg_plat_comm
--scmdata.pkg_plat_log

--三期
--pkg_pick_list
--
--视图
--v_color_prepare_order 
SELECT t.*, t.rowid from nbw.sys_item t WHERE t.item_id LIKE '%prematerial_22%';
SELECT t.*, t.rowid from nbw.sys_item t WHERE t.item_id LIKE '%prematerial_24%';
SELECT t.*, t.rowid from nbw.SYS_ITEM_LIST T WHERE T.ITEM_ID LIKE '%prematerial_22%';
SELECT t.*, t.rowid from nbw.SYS_ITEM_LIST T WHERE T.ITEM_ID LIKE '%prematerial_24%';
SELECT t.*, t.rowid from nbw.SYS_TREE_LIST T WHERE T.ITEM_ID LIKE '%prematerial_22%';
SELECT t.*, t.rowid from nbw.SYS_TREE_LIST T WHERE T.ITEM_ID LIKE '%prematerial_24%';
SELECT t.*, t.rowid from nbw.SYS_WEB_UNION T WHERE T.ITEM_ID LIKE '%prematerial_22%';
SELECT t.*, t.rowid from nbw.SYS_WEB_UNION T WHERE T.ITEM_ID LIKE '%prematerial_24%';
SELECT t.*, t.rowid from nbw.Sys_Item_Rela t WHERE T.ITEM_ID LIKE '%prematerial_22%';
SELECT t.*, t.rowid from nbw.Sys_Item_Rela t WHERE T.ITEM_ID LIKE '%prematerial_24%'; 
SELECT t.*, t.rowid from nbw.SYS_ELEMENT T WHERE T.ELEMENT_ID LIKE '%prematerial_22%'; --action_a_prematerial_210_1
SELECT t.*, t.rowid from nbw.SYS_ELEMENT T WHERE T.ELEMENT_ID LIKE '%prematerial_24%';
SELECT t.*, t.rowid from nbw.sys_action t WHERE T.ELEMENT_ID LIKE '%prematerial_22%';
SELECT t.*, t.rowid from nbw.sys_action t WHERE T.ELEMENT_ID LIKE '%prematerial_24%';
--SELECT t.*, t.rowid from nbw.Sys_Look_Up t WHERE t.element_id ='look_a_prematerial_210_2'; --look_a_prematerial_210_2  
SELECT t.*, t.rowid from nbw.SYS_ITEM_ELEMENT_RELA T WHERE T.ITEM_ID LIKE '%prematerial_22%';
SELECT t.*, t.rowid from nbw.SYS_ITEM_ELEMENT_RELA T WHERE T.ITEM_ID LIKE '%prematerial_24%';

--按钮控制 action_a_prematerial_221_1
SELECT rowid,t.* from nbw.sys_cond_list t WHERE t.cond_id IN ('cond_action_a_prematerial_221_1','cond_action_a_prematerial_241_1','cond_action_a_prematerial_221_1_1');
SELECT rowid,t.* from nbw.sys_cond_rela t  WHERE t.cond_id IN ('cond_action_a_prematerial_221_1','cond_action_a_prematerial_241_1','cond_action_a_prematerial_221_1_1');
SELECT rowid,t.* from nbw.sys_field_list t WHERE t.field_name IN ('CRAFT_UNIT_PRICE','CR_CANCEL_REASON_N','CR_ORDER_NUM_N','CR_EXPECT_ARRIVAL_TIME_N','CR_PREPARE_ORDER_ID_N','CR_UNIT_N'); 
SELECT rowid,t.* from nbw.sys_param_list t WHERE t.param_name IN ('CR_CANCEL_REASON_N','CR_ORDER_NUM_N','CR_EXPECT_ARRIVAL_TIME_N','CR_PREPARE_ORDER_ID_N','CR_UNIT_N'); 

SELECT rowid,t.* from nbw.sys_field_list t WHERE t.field_name LIKE 'CR\_%' ESCAPE '\'; 
SELECT rowid,t.* from nbw.sys_param_list t WHERE t.param_name LIKE 'CR\_%' ESCAPE '\'; 
SELECT rowid,t.* from nbw.sys_param_list t WHERE t.param_name LIKE 'CP\_%' ESCAPE '\'; 

SELECT rowid,t.* from nbw.sys_action t WHERE t.element_id = 'action_a_prematerial_210_7' ;

SELECT t.*, t.rowid from nbw.SYS_ELEMENT T WHERE T.ELEMENT_ID LIKE '%look_a_prematerial_221_1%';
SELECT t.*, t.rowid from nbw.Sys_Look_Up t WHERE t.element_id ='look_a_prematerial_221_1'; --look_a_prematerial_210_2 
SELECT t.*, t.rowid from nbw.SYS_ITEM_ELEMENT_RELA T WHERE T.Element_Id LIKE '%look_a_prematerial_221_1%';

SELECT rowid,t.* from nbw.sys_item_rela t WHERE t.item_id IN ('a_product_110','a_product_210','a_product_116','a_product_216') AND t.relate_id = 'a_prematerial_226'; 
