DECLARE
v_sql CLOB;
BEGIN
v_sql := 'DECLARE
  v_company_id         VARCHAR2(32);
  v_product_gress_code VARCHAR2(100) := @product_gress_code_pr@; --输入的生产订单
BEGIN

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
END;';
UPDATE bw3.sys_action t SET t.action_sql = v_sql WHERE t.element_id = 'action_a_product_110_6';
END;
