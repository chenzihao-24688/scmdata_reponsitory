prompt PL/SQL Developer Export User Objects for user MRP@ORCL_SCMTEST
prompt Created by SANFU on 2023年6月15日
set define off
spool 20230614_table.log

prompt
prompt Creating trigger CLASS_ID_SEQ
prompt =============================
prompt
@@class_id_seq.trg
prompt
prompt Creating trigger TFG_AF_IU_FABRIC_PURCHASE_SHEET
prompt ================================================
prompt
@@tfg_af_iu_fabric_purchase_sheet.trg
prompt
prompt Creating trigger TFG_AF_IU_MATERIAL_COLOR_INVENTORY
prompt ===================================================
prompt
@@tfg_af_iu_material_color_inventory.trg
prompt
prompt Creating trigger TFG_AF_IU_MATERIAL_GREY_INVENTORY
prompt ==================================================
prompt
@@tfg_af_iu_material_grey_inventory.trg
prompt
prompt Creating trigger TFG_AF_IU_SUPPLIER_COLOR_INVENTORY
prompt ===================================================
prompt
@@tfg_af_iu_supplier_color_inventory.trg
prompt
prompt Creating trigger TFG_AF_IU_SUPPLIER_GREY_INVENTORY
prompt ==================================================
prompt
@@tfg_af_iu_supplier_grey_inventory.trg
prompt
prompt Creating trigger TFG_AF_U_PICK_LIST
prompt ===================================
prompt
@@tfg_af_u_pick_list.trg
prompt
prompt Creating trigger TFG_AF_U_SUPPLIER_COLOR_INVENTORY
prompt ==================================================
prompt
@@tfg_af_u_supplier_color_inventory.trg
prompt
prompt Creating trigger TFG_AF_U_SUPPLIER_GREY_INVENTORY
prompt =================================================
prompt
@@tfg_af_u_supplier_grey_inventory.trg
prompt
prompt Creating trigger TFG_BF_IU_FABRIC_PURCHASE_SHEET
prompt ================================================
prompt
@@tfg_bf_iu_fabric_purchase_sheet.trg
prompt
prompt Creating trigger TFG_BF_IU_PICK_LIST
prompt ====================================
prompt
@@tfg_bf_iu_pick_list.trg
prompt
prompt Creating trigger TRG_AF_U_COLOR_PREPARE_ORDER
prompt =============================================
prompt
@@trg_af_u_color_prepare_order.trg
prompt
prompt Creating trigger TRG_AF_U_COLOR_PREPARE_PRODUCT_ORDER
prompt =====================================================
prompt
@@trg_af_u_color_prepare_product_order.trg
prompt
prompt Creating trigger TRG_AF_U_GREY_PREPARE_ORDER
prompt ============================================
prompt
@@trg_af_u_grey_prepare_order.trg
prompt
prompt Creating trigger TRG_AF_U_GREY_PREPARE_PRODUCT_ORDER
prompt ====================================================
prompt
@@trg_af_u_grey_prepare_product_order.trg

prompt Done
spool off
set define on
