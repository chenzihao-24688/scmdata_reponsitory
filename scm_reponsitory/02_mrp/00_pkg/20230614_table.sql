prompt PL/SQL Developer Export User Objects for user MRP@ORCL_SCMTEST
prompt Created by SANFU on 2023年6月15日
set define off
spool 20230614_table.log

prompt
prompt Creating package PKG_BULK_CARGO_BOM
prompt ===================================
prompt
@@pkg_bulk_cargo_bom.pck
prompt
prompt Creating package PKG_CHECK_DATA_COMM
prompt ====================================
prompt
@@pkg_check_data_comm.pck
prompt
prompt Creating package PKG_COLOR_PREPARE_BATCH_FINISH_ORDER
prompt =====================================================
prompt
@@pkg_color_prepare_batch_finish_order.pck
prompt
prompt Creating package PKG_COLOR_PREPARE_ORDER
prompt ========================================
prompt
@@pkg_color_prepare_order.pck
prompt
prompt Creating package PKG_COLOR_PREPARE_ORDER_MANAGER
prompt ================================================
prompt
@@pkg_color_prepare_order_manager.pck
prompt
prompt Creating package PKG_COLOR_PREPARE_PRODUCT_ORDER
prompt ================================================
prompt
@@pkg_color_prepare_product_order.pck
prompt
prompt Creating package PKG_MATERIAL_COLOR_CLOTH_STOCK
prompt ===============================================
prompt
@@pkg_material_color_cloth_stock.pck
prompt
prompt Creating package PKG_MATERIAL_COLOR_IN_OUT_BOUND
prompt ================================================
prompt
@@pkg_material_color_in_out_bound.pck
prompt
prompt Creating package PKG_MATERIAL_GREY_IN_OUT_BOUND
prompt ===============================================
prompt
@@pkg_material_grey_in_out_bound.pck
prompt
prompt Creating package PKG_MATERIAL_GREY_STOCK
prompt ========================================
prompt
@@pkg_material_grey_stock.pck
prompt
prompt Creating package PKG_MATERIAL_PREPARATION_STAGE_3
prompt =================================================
prompt
@@pkg_material_preparation_stage_3.pck
prompt
prompt Creating package PKG_MATERIAL_SEND_GOODS
prompt ========================================
prompt
@@pkg_material_send_goods.pck
prompt
prompt Creating package PKG_PICK_LIST
prompt ==============================
prompt
@@pkg_pick_list.pck
prompt
prompt Creating package PKG_PLAT_COMM
prompt ==============================
prompt
@@pkg_plat_comm.pck
prompt
prompt Creating package PKG_PREMATERIAL_MANA_SPU
prompt =========================================
prompt
@@pkg_prematerial_mana_spu.pck
prompt
prompt Creating package PKG_STOCK_MANAGEMENT
prompt =====================================
prompt
@@pkg_stock_management.pck
prompt
prompt Creating package PKG_SUPPLIER_COLOR_CLOTH_STOCK
prompt ===============================================
prompt
@@pkg_supplier_color_cloth_stock.pck
prompt
prompt Creating package PKG_SUPPLIER_COLOR_IN_OUT_BOUND
prompt ================================================
prompt
@@pkg_supplier_color_in_out_bound.pck
prompt
prompt Creating package PKG_SUPPLIER_GREY_IN_OUT_BOUND
prompt ===============================================
prompt
@@pkg_supplier_grey_in_out_bound.pck
prompt
prompt Creating package PKG_SUPPLIER_GREY_STOCK
prompt ========================================
prompt
@@pkg_supplier_grey_stock.pck
prompt
prompt Creating package PKG_T_FABRIC_INVOICE
prompt =====================================
prompt
@@pkg_t_fabric_invoice.pck
prompt
prompt Creating package PKG_T_FABRIC_INVOICE_DETAIL
prompt ============================================
prompt
@@pkg_t_fabric_invoice_detail.pck
prompt
prompt Creating package PKG_T_FABRIC_PURCHASE_SHEET
prompt ============================================
prompt
@@pkg_t_fabric_purchase_sheet.pck

prompt Done
spool off
set define on
