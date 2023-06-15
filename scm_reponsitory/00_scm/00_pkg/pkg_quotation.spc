CREATE OR REPLACE PACKAGE SCMDATA.pkg_quotation IS

  -- Author  : CZH55
  -- Created : 2022/7/25 17:01:01
  -- Purpose : ODM报价管理
  --校验
  PROCEDURE p_check_quotation(p_company_id VARCHAR2,
                              p_quota_rec  plm.quotation%ROWTYPE);
  --纸格件数校验
  PROCEDURE p_check_bag_paper(p_company_id      VARCHAR2,
                              p_quotation_class VARCHAR2,
                              p_bag_paper       VARCHAR2);

  --获取报价分类末级lookup
  FUNCTION f_get_quotation_class_lookup(p_company_id VARCHAR2,
                                        p_val        VARCHAR2,
                                        p_desc       VARCHAR2) RETURN CLOB;

  --根据报价分类层级 获取相应报价分类lookup
  FUNCTION f_get_quotation_class_lookup_by_out_type(p_company_id VARCHAR2,
                                                    p_val        VARCHAR2,
                                                    p_desc       VARCHAR2,
                                                    p_out_type   INT)
    RETURN CLOB;

  --根据末级分类 获取报价分类
  FUNCTION f_get_quotation_class_by_id(p_company_id               VARCHAR2,
                                       p_quotation_classification VARCHAR2,
                                       p_out_type                 INT DEFAULT 1,
                                       p_is_name                  INT DEFAULT 0)
    RETURN VARCHAR2;
  --根据物料分类末级获取物料分类名称（拼接）
  FUNCTION f_get_material_class_look_up(p_company_id VARCHAR2,
                                        p_val        VARCHAR2,
                                        p_desc       VARCHAR2) RETURN CLOB;

  FUNCTION f_query_quotation(p_company_id     VARCHAR2,
                             p_sup_company_id VARCHAR2,
                             p_item_id        VARCHAR2 DEFAULT NULL)
    RETURN CLOB;

  --同款报价单信息
  FUNCTION f_query_same_quotation(p_quotation_id VARCHAR2) RETURN CLOB;

  FUNCTION f_query_quotation_by_id(p_quotation_id    VARCHAR2,
                                   p_type            INT,
                                   p_company_id      VARCHAR2 DEFAULT NULL,
                                   p_quotation_class VARCHAR2 DEFAULT NULL)
    RETURN CLOB;

  PROCEDURE p_insert_quotation(p_quota_rec plm.quotation%ROWTYPE);

  PROCEDURE p_update_quotation(p_quota_rec       plm.quotation%ROWTYPE,
                               p_type            INT,
                               p_company_id      VARCHAR2 DEFAULT NULL,
                               p_quotation_class VARCHAR2 DEFAULT NULL);

  --校验生产工序
  PROCEDURE p_check_working_procedure(p_qt_rec       plm.quotation%ROWTYPE,
                                      p_type         INT,
                                      p_out_err_type INT DEFAULT 0,
                                      po_error_msg   OUT CLOB);
  --校验其他费用
  PROCEDURE p_check_other_fees(p_qt_rec       plm.quotation%ROWTYPE,
                               p_type         INT,
                               p_out_err_type INT DEFAULT 0,
                               po_error_msg   OUT CLOB);
  --校验附件
  PROCEDURE p_check_files(p_qt_rec       plm.quotation%ROWTYPE,
                          p_out_err_type INT DEFAULT 0,
                          po_error_msg   OUT CLOB);
  --提交报价单校验 
  PROCEDURE p_check_quotation_by_submit(p_company_id   VARCHAR2,
                                        p_quotation_id VARCHAR2,
                                        p_out_err_msg  OUT CLOB);
  --提交报价单
  PROCEDURE p_submit_quotation(p_company_id   VARCHAR2,
                               p_quotation_id VARCHAR2,
                               p_user_id      VARCHAR2);

  --取消报价单
  PROCEDURE p_cancel_quotation(p_quotation_id VARCHAR2, p_user_id VARCHAR2);
  --获取状态lookup
  FUNCTION f_get_quotation_lookup RETURN CLOB;

  --通过报价分类校验耗材BOM库是否有耗材明细
  FUNCTION f_check_is_exist_material_details(p_quotation_classification VARCHAR2)
    RETURN INT;

  --通过物料sku获取mrp确定供应商编号和简称
  PROCEDURE p_get_mrp_internal_sup_info(p_material_sku IN VARCHAR2,
                                        po_sup_code    OUT VARCHAR2);

  --选择供应商picklist
  FUNCTION p_get_mrp_internal_sup_info_pick(p_material_sku IN VARCHAR2)
    RETURN CLOB;
  --耗材明细
  --计算耗材金额
  PROCEDURE p_cal_consumables_detail_total_amount(p_quotation_id VARCHAR2);
  --校验耗材物料明细
  PROCEDURE p_check_consumables_consumption_detail(p_consu_rec plm.consumables_consumption_detail%ROWTYPE,
                                                   p_type      INT);

  FUNCTION f_query_consumables_consumption_detail(p_quotation_id              VARCHAR2,
                                                  p_is_exist_material_details INT)
    RETURN CLOB;

  PROCEDURE p_insert_consumables_consumption_detail(p_consu_rec plm.consumables_consumption_detail%ROWTYPE);

  PROCEDURE p_update_consumables_consumption_detail(p_consu_rec plm.consumables_consumption_detail%ROWTYPE,
                                                    p_type      INT);
  --特殊工艺
  --通过特殊工艺id获取中文
  FUNCTION f_get_special_craft_by_id(p_craft_classification VARCHAR2)
    RETURN VARCHAR2;
  --特殊工艺分类弹窗
  FUNCTION f_get_special_craft_pick RETURN CLOB;

  --通过特殊工艺一级分类 获取特殊工艺价格
  FUNCTION f_get_craft_price(p_process_name_pt   VARCHAR2,
                             p_craft_unit_price  NUMBER,
                             p_craft_consumption NUMBER,
                             p_washing_percent   NUMBER) RETURN NUMBER;
  --计算工艺金额
  PROCEDURE p_cal_craft_price_total_amount(p_quotation_id VARCHAR2);

  --校验特殊工艺
  PROCEDURE p_check_special_craft_quotation(p_speci_rec plm.special_craft_quotation%ROWTYPE);

  FUNCTION f_query_special_craft_quotation(p_quotation_id VARCHAR2)
    RETURN CLOB;

  PROCEDURE p_insert_special_craft_quotation(p_speci_rec plm.special_craft_quotation%ROWTYPE);
  PROCEDURE p_update_special_craft_quotation(p_speci_rec plm.special_craft_quotation%ROWTYPE);

  PROCEDURE p_delete_special_craft_quotation(p_company_id VARCHAR2,
                                             p_user_id    VARCHAR2,
                                             p_speci_rec  plm.special_craft_quotation%ROWTYPE);

  --包装及运费
  --鞋成本配置
  --鞋盒选择 pick
  FUNCTION f_get_shoe_cost_configuration_pick(p_quotation_id              VARCHAR2,
                                              p_shoe_craft_category       VARCHAR2,
                                              p_shoe_packing_type         VARCHAR2,
                                              p_shoe_packing_number       VARCHAR2,
                                              p_shoe_transportation_route VARCHAR2)
    RETURN CLOB;
  FUNCTION f_query_shoes_fee(p_quotation_id VARCHAR2) RETURN CLOB;
  PROCEDURE p_insert_shoes_fee(p_shoes_rec plm.shoes_fee%ROWTYPE);
  PROCEDURE p_insert_shoes_fee_all(p_shoe_rec plm.shoes_fee%ROWTYPE);
  PROCEDURE p_update_shoes_fee(p_shoes_rec plm.shoes_fee%ROWTYPE,
                               p_type      INT);

  --计算工序金额
  PROCEDURE p_cal_working_procedure_total_amount(p_quotation_id VARCHAR2);
  --计算其他费用
  PROCEDURE p_cal_others_total_amount(p_quotation_id VARCHAR2, p_type INT);
  --物料明细
  --新增物料
  PROCEDURE p_insert_material_detail_quotation(p_material_rec plm.material_detail_quotation%ROWTYPE);

  --根据报价单ID 生成新的报价单
  PROCEDURE p_generate_copy_new_quotation(p_quotation_id VARCHAR2,
                                          p_user_id      VARCHAR2);

  --新增核价单
  PROCEDURE p_insert_examine_price(p_exprice_rec plm.examine_price%ROWTYPE);
  --特殊工艺核价信息
  PROCEDURE p_insert_special_craft_examine_price(p_special_craft special_craft_examine_price%ROWTYPE);
  --生成核价单
  PROCEDURE p_generate_examine_price(p_company_id   VARCHAR2,
                                     p_quotation_id VARCHAR2,
                                     p_user_id      VARCHAR2);

  --通过平台唯一建获取供应商企业ID
  FUNCTION f_get_sup_company_id_by_uqid(p_company_id VARCHAR2,
                                        p_uq_id      VARCHAR2)
    RETURN VARCHAR2;

  --新增附件
  PROCEDURE p_insert_plm_file(p_plm_f_rec plm.plm_file%ROWTYPE);
  --更新附件
  PROCEDURE p_update_plm_file(p_plm_f_rec plm.plm_file%ROWTYPE);
  --更新报价单附件
  PROCEDURE p_update_quotation_file(p_quotation_id VARCHAR2,
                                    p_file_type    INT,
                                    p_file_blob    BLOB);
END pkg_quotation;
/

