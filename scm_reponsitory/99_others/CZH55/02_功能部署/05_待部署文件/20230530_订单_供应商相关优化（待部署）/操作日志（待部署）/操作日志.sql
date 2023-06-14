--操作日志
--表
--T_DOCUMENT_CHANGE_TRACE
--T_PLAT_LOG

--包
--scmdata.pkg_t_document_change_trace
--scmdata.pkg_plat_comm
--scmdata.pkg_plat_log

--触发器
--mrp.trg_af_u_color_prepare_order
--mrp.trg_af_u_color_prepare_product_order

scmdata.pkg_scm_reverse_generation

mrp.pkg_color_prepare_order_manager 

BEGIN
  scmdata.pkg_plat_log.p_document_change_trace(p_company_id              => 'a972dd1ffe3b3a10e0533c281cac8fd7',
                                               p_document_id             => 'A1;B1;C1',
                                               p_data_source_parent_code => 'A001',
                                               p_data_source_child_code  => 'AB001',
                                               p_operate_company_id      => 'a972dd1ffe3b3a10e0533c281cac8fd7',
                                               p_user_id                 => 'CZH55');
END;

SELECT * from scmdata.t_document_change_trace;
DELETE from scmdata.t_document_change_trace;
scmdata.pkg_scm_reverse_generation
