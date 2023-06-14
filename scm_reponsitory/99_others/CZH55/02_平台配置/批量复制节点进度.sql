DECLARE
  v_product_gress_code VARCHAR2(100) := @product_gress_code_pr@;
  v_company_id         VARCHAR2(100) := %default_company_id%;
  v_good_id_p          VARCHAR2(100); --需要复制节点进度的生产订单,货号
  v_good_id_c          VARCHAR2(100); --选择的生产订单货号
  v_good_id            VARCHAR2(100);
  vpn_code             VARCHAR2(100);
  v_flag               NUMBER;
  --pn_rec               scmdata.t_production_node%ROWTYPE;
  --需要复制节点进度的生产订单
  CURSOR pro_cur IS
    SELECT tc.goo_id t_goo_id, p.*
      FROM scmdata.t_production_progress p
     INNER JOIN scmdata.t_commodity_info tc
        ON p.company_id = tc.company_id
       AND p.goo_id = tc.rela_goo_id
     WHERE p.company_id = %default_company_id%
       AND p.product_gress_code IN (@selection);
BEGIN
  --生产订单的商品相同（货号相同），才可支持节点进度复制，不同时需提示用户：“所选生产订单的商品不一致，不支持同时复制节点进度！”

  --1. 需要复制节点进度的生产订单,商品档案编号不一致。
  SELECT COUNT(DISTINCT tc.goo_id), COUNT(*)
    INTO v_good_id_p, v_good_id
    FROM scmdata.t_production_progress p
   INNER JOIN scmdata.t_commodity_info tc
      ON p.company_id = v_company_id
     AND p.company_id = tc.company_id
     AND p.goo_id = tc.rela_goo_id
     AND p.product_gress_code IN (@selection);

  IF v_good_id_p <> v_good_id THEN
    raise_application_error(-20002,
                            '所选生产订单的商品不一致，不支持同时复制节点进度！');
  END IF;

  --输入的生产订单，对应节点进度 是否为空
  SELECT COUNT(1)
    INTO v_flag
    FROM scmdata.t_production_progress p
   INNER JOIN scmdata.t_production_node pn
      ON p.company_id = pn.company_id
     AND p.product_gress_id = pn.product_gress_id
     AND p.product_gress_code = v_product_gress_code
   WHERE p.company_id = v_company_id;

  --2. 需要复制节点进度的生产订单商品档案编号一致。

  --2.1 如果输入的生产订单，节点进度不存在
  IF v_flag = 0 THEN
    raise_application_error(-20002,
                            '复制失败，输入的生产订单不存在节点进度！');
  ELSE
    --输入的生产订单，对应商品档案的货号
    SELECT tc.goo_id
      INTO v_good_id_c
      FROM scmdata.t_production_progress p
     INNER JOIN scmdata.t_commodity_info tc
        ON p.company_id = tc.company_id
       AND p.goo_id = tc.rela_goo_id
       AND p.product_gress_code = v_product_gress_code
     WHERE p.company_id = v_company_id;
    --2.2 如果输入的生产订单，节点进度存在
    FOR pro_rec IN pro_cur LOOP
      --2.3 选择的生产订单商品档案编号不一致
      IF pro_rec.t_goo_id <> v_good_id_c THEN
        raise_application_error(-20002,
                                '所选生产订单与输入生产订单的商品不一致，不支持复制节点进度！');
      ELSE
        --2.4 校验需要复制节点进度的生产订单，是否有节点进度
        SELECT COUNT(1)
          INTO v_flag
          FROM scmdata.t_production_node pn
         WHERE pn.company_id = pro_rec.company_id
           AND pn.product_gress_id = pro_rec.product_gress_id
           AND pn.company_id = v_company_id;
      
        --2.5 没有节点进度，做新增操作
        IF v_flag = 0 THEN
          vpn_code := scmdata.pkg_plat_comm.f_getkeycode(pi_table_name  => 't_production_node', --表名
                                                         pi_column_name => 'product_node_code', --列名
                                                         pi_company_id  => v_company_id, --公司编号
                                                         pi_pre         => 'PNC', --前缀
                                                         pi_serail_num  => 6);
          INSERT INTO scmdata.t_production_node
            SELECT scmdata.f_get_uuid(),
                   v_company_id,
                   pro_rec.product_gress_id, --关联需要复制节点进度的生产订单
                   vpn_code,
                   pn_rec.node_num,
                   pn_rec.node_name,
                   pn_rec.time_ratio,
                   pn_rec.target_completion_time, --自动生成，后续需按规则修改
                   pn_rec.plan_completion_time,
                   pn_rec.actual_completion_time,
                   pn_rec.complete_amount,
                   pn_rec.progress_status,
                   pn_rec.progress_say,
                   pn_rec.update_id,
                   pn_rec.update_date,
                   pn_rec.create_id,
                   pn_rec.create_time,
                   pn_rec.memo
              FROM (SELECT pn.*
                      FROM scmdata.t_production_progress p
                     INNER JOIN scmdata.t_production_node pn
                        ON p.company_id = pn.company_id
                       AND p.product_gress_id = pn.product_gress_id
                       AND p.product_gress_code = v_product_gress_code
                     WHERE p.company_id = v_company_id) pn_rec; --输入的生产订单，对应节点进度
        ELSE
          --2.6 有节点进度 ,做更新操作
          FOR pn_rec IN (SELECT pn.*
                           FROM scmdata.t_production_progress p
                          INNER JOIN scmdata.t_production_node pn
                             ON p.company_id = pn.company_id
                            AND p.product_gress_id = pn.product_gress_id
                            AND p.product_gress_code = v_product_gress_code
                          WHERE p.company_id = v_company_id) LOOP
            UPDATE t_production_node t
               SET t.plan_completion_time   = pn_rec.plan_completion_time,
                   t.actual_completion_time = pn_rec.actual_completion_time,
                   t.complete_amount        = pn_rec.complete_amount,
                   t.progress_status        = pn_rec.progress_status,
                   t.progress_say           = pn_rec.progress_say,
                   t.update_id              = pn_rec.update_id,
                   t.update_date            = pn_rec.update_date,
                   t.create_id              = pn_rec.create_id,
                   t.create_time            = pn_rec.create_time,
                   t.memo                   = pn_rec.memo
             WHERE t.company_id = v_company_id
               AND t.product_gress_id = pro_rec.product_gress_id;
          END LOOP;
        END IF;
      
      END IF;
    
    END LOOP;
  
  END IF;

END;

SELECT COUNT(DISTINCT p.goo_id), COUNT(*)
  FROM scmdata.t_production_progress p
 INNER JOIN scmdata.t_commodity_info tc
    ON p.company_id = /*%default_company_id%*/
       'a972dd1ffe3b3a10e0533c281cac8fd7'
   AND p.goo_id = tc.rela_goo_id;

SELECT COUNT(DISTINCT tc.goo_id), COUNT(*)
  FROM scmdata.t_production_progress p
 INNER JOIN scmdata.t_commodity_info tc
    ON p.company_id = /*%default_company_id%*/
       'a972dd1ffe3b3a10e0533c281cac8fd7'
   AND p.company_id = tc.company_id
   AND p.goo_id = tc.rela_goo_id;

SELECT ROWID, t.*
  FROM scmdata.t_commodity_info t
 WHERE t.company_id = /*%default_company_id%*/
       'a972dd1ffe3b3a10e0533c281cac8fd7';

SELECT *
  FROM scmdata.t_production_progress p
 INNER JOIN scmdata.t_production_node pn
    ON p.company_id = pn.company_id
   AND p.product_gress_id = pn.product_gress_id
 WHERE p.company_id = %default_company_id%
