SELECT t.*, t.rowid from nbw.sys_item t WHERE t.item_id LIKE '%prematerial_2%';
SELECT t.*, t.rowid from nbw.SYS_ITEM_LIST T WHERE T.ITEM_ID LIKE '%prematerial_2%';
SELECT t.*, t.rowid from nbw.SYS_TREE_LIST T WHERE T.ITEM_ID LIKE '%prematerial_2%';
SELECT t.*, t.rowid from nbw.SYS_WEB_UNION T WHERE T.ITEM_ID LIKE '%prematerial_2%';
SELECT t.*, t.rowid from nbw.Sys_Item_Rela t WHERE T.ITEM_ID LIKE '%prematerial_2%';
SELECT t.*, t.rowid from nbw.SYS_ELEMENT T WHERE T.ELEMENT_ID LIKE '%prematerial_2%'; 
SELECT t.*, t.rowid from nbw.sys_action t WHERE T.ELEMENT_ID LIKE '%prematerial_2%';
SELECT t.*, t.rowid from nbw.Sys_Look_Up t WHERE t.element_id LIKE 'look_a_prematerial_2%';  
SELECT t.*, t.rowid from nbw.SYS_ITEM_ELEMENT_RELA T WHERE T.ITEM_ID LIKE '%prematerial_2%';

--°´Å¥¿ØÖÆ action_a_prematerial_221_1
SELECT rowid,t.* from nbw.sys_cond_list t WHERE t.cond_id LIKE 'cond_action_a_prematerial_2%';
SELECT rowid,t.* from nbw.sys_cond_rela t  WHERE t.cond_id LIKE 'cond_action_a_prematerial_2%';

SELECT rowid,t.* from nbw.sys_field_list t WHERE t.field_name LIKE 'CR\_%' ESCAPE '\'; 
SELECT rowid,t.* from nbw.sys_field_list t WHERE t.field_name LIKE 'CP\_%' ESCAPE '\'; 
SELECT rowid,t.* from nbw.sys_param_list t WHERE t.param_name LIKE 'CP\_%' ESCAPE '\'; 

SELECT t.*, t.rowid from nbw.sys_param_list t WHERE t.param_name IN ('ORDER_AMOUNT','PREPARE_ORDER_ID','UNIT','EXPECT_ARRIVAL_DATE','MATERIAL_NAME','COMPLETED_AMOUNT','UNFINISHED_AMOUNT','COMPLETION_RATE','COMPLETE_AMOUNT','UNIT_DESC',
'ORDER_AMOUNT_DESC','IS_FINISH_PAPRE','TOLERANCE_RATIO','CANCEL_REASON');
