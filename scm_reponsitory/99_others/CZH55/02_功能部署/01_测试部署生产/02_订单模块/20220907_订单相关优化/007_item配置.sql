DECLARE
  v_sql CLOB;
BEGIN
  v_sql := 'DECLARE
  v_company_id           VARCHAR2(32) := %default_company_id%;
  v_product_gress_code   VARCHAR2(100) := @product_gress_code_pr@; --输入的生产订单
  v_cate                 VARCHAR2(32);
  v_pcate                VARCHAR2(32);
  v_scate                VARCHAR2(32);
  v_inprogress_config_id VARCHAR2(32);
  v_ndprogress_config_id VARCHAR2(32);
  v_md_orders            CLOB;
BEGIN
  /*  SELECT DISTINCT p.company_id
   INTO v_company_id
   FROM scmdata.t_production_progress p
  WHERE p.product_gress_id IN (@selection@);*/

  --获取输入的生产进度所对应的的分类，生产类别，子类
  SELECT tc.category, tc.product_cate, tc.samll_category
    INTO v_cate, v_pcate, v_scate
    FROM scmdata.t_production_progress p
   INNER JOIN scmdata.t_commodity_info tc
      ON tc.goo_id = p.goo_id
     AND tc.company_id = p.company_id
   WHERE p.company_id = v_company_id
     AND p.product_gress_code = v_product_gress_code;

  --被复制的生产进度 对应的节点模板
  v_inprogress_config_id := scmdata.pkg_production_progress_a.f_get_progress_config_module(p_company_id => v_company_id,
                                                                                           p_cate       => v_cate,
                                                                                           p_pcate      => v_pcate,
                                                                                           p_scate      => v_scate);
  FOR nd_rec IN (SELECT p.product_gress_code,
                        tc.category,
                        tc.product_cate,
                        tc.samll_category
                   FROM scmdata.t_production_progress p
                  INNER JOIN scmdata.t_commodity_info tc
                     ON tc.goo_id = p.goo_id
                    AND tc.company_id = p.company_id
                  WHERE p.company_id = v_company_id
                    AND p.product_gress_id IN (@selection@)) LOOP
    v_ndprogress_config_id := scmdata.pkg_production_progress_a.f_get_progress_config_module(p_company_id => v_company_id,
                                                                                             p_cate       => nd_rec.category,
                                                                                             p_pcate      => nd_rec.product_cate,
                                                                                             p_scate      => nd_rec.samll_category);
    --校验：复制订单与被复制订单所使用的生产节点模版相同，才可支持节点进度复制。
    IF scmdata.pkg_plat_log.f_is_check_fields_eq(v_ndprogress_config_id,
                                                 v_inprogress_config_id) = 0 THEN
      v_md_orders := v_md_orders || nd_rec.product_gress_code || ''、'';
    END IF;
  END LOOP;
  IF v_md_orders IS NOT NULL THEN
    v_md_orders := rtrim(v_md_orders, ''、'');
    raise_application_error(-20002,
                            ''复制失败！所选订单('' || v_md_orders ||
                            '')与被复制订单的生产节点不一致，不可操作复制'');
  ELSE
    --需复制的生产单
    FOR nd_rec IN (SELECT p.product_gress_code, p.company_id
                     FROM scmdata.t_production_progress p
                    WHERE p.product_gress_id IN (@selection@)) LOOP
    
      scmdata.pkg_production_progress_a.p_batch_copy_progress(p_company_id           => nd_rec.company_id,
                                                              p_inproduct_gress_code => v_product_gress_code,
                                                              p_ndproduct_gress_code => nd_rec.product_gress_code,
                                                              p_item_id              => ''a_product_110'',
                                                              p_user_id              => :user_id);
    END LOOP;
  END IF;
END;';
  UPDATE bw3.sys_item_list t SET t.select_sql = v_sql WHERE t.item_id = 'action_a_product_110_6';
END;
/
DECLARE
  v_sql CLOB;
BEGIN
  v_sql := 'DECLARE
  v_company_id           VARCHAR2(32);
  v_product_gress_code   VARCHAR2(100) := @product_gress_code_pr@; --输入的生产订单
  v_cate                 VARCHAR2(32);
  v_pcate                VARCHAR2(32);
  v_scate                VARCHAR2(32);
  v_inprogress_config_id VARCHAR2(32);
  v_ndprogress_config_id VARCHAR2(32);
  v_md_orders            CLOB;
BEGIN
  SELECT DISTINCT p.company_id
    INTO v_company_id
    FROM scmdata.t_production_progress p
   WHERE p.product_gress_id IN (@selection@);
  --获取输入的生产进度所对应的的分类，生产类别，子类
  SELECT tc.category, tc.product_cate, tc.samll_category
    INTO v_cate, v_pcate, v_scate
    FROM scmdata.t_production_progress p
   INNER JOIN scmdata.t_commodity_info tc
      ON tc.goo_id = p.goo_id
     AND tc.company_id = p.company_id
   WHERE p.company_id = v_company_id
     AND p.product_gress_code = v_product_gress_code;

  --被复制的生产进度 对应的节点模板
  v_inprogress_config_id := scmdata.pkg_production_progress_a.f_get_progress_config_module(p_company_id => v_company_id,
                                                                                           p_cate       => v_cate,
                                                                                           p_pcate      => v_pcate,
                                                                                           p_scate      => v_scate);
  FOR nd_rec IN (SELECT p.product_gress_code,
                        tc.category,
                        tc.product_cate,
                        tc.samll_category
                   FROM scmdata.t_production_progress p
                  INNER JOIN scmdata.t_commodity_info tc
                     ON tc.goo_id = p.goo_id
                    AND tc.company_id = p.company_id
                  WHERE p.company_id = v_company_id
                    AND p.product_gress_id IN (@selection@)) LOOP
    v_ndprogress_config_id := scmdata.pkg_production_progress_a.f_get_progress_config_module(p_company_id => v_company_id,
                                                                                             p_cate       => nd_rec.category,
                                                                                             p_pcate      => nd_rec.product_cate,
                                                                                             p_scate      => nd_rec.samll_category);
    --校验：复制订单与被复制订单所使用的生产节点模版相同，才可支持节点进度复制。
    IF scmdata.pkg_plat_log.f_is_check_fields_eq(v_ndprogress_config_id,
                                                 v_inprogress_config_id) = 0 THEN
      v_md_orders := v_md_orders || nd_rec.product_gress_code || ''、'';
    END IF;
  END LOOP;
  IF v_md_orders IS NOT NULL THEN
    v_md_orders := rtrim(v_md_orders, ''、'');
    raise_application_error(-20002,
                            ''复制失败！所选订单('' || v_md_orders ||
                            '')与被复制订单的生产节点不一致，不可操作复制'');
  ELSE
    --需复制的生产单
    FOR nd_rec IN (SELECT p.product_gress_code, p.company_id
                     FROM scmdata.t_production_progress p
                    WHERE p.product_gress_id IN (@selection@)) LOOP
    
      scmdata.pkg_production_progress_a.p_batch_copy_progress(p_company_id           => nd_rec.company_id,
                                                              p_inproduct_gress_code => v_product_gress_code,
                                                              p_ndproduct_gress_code => nd_rec.product_gress_code,
                                                              p_item_id              => ''a_product_210'',
                                                              p_user_id              => :user_id);
    END LOOP;
  END IF;
END;';
  UPDATE bw3.sys_item_list t SET t.select_sql = v_sql WHERE t.item_id = 'action_a_product_210_1';
END;
/
