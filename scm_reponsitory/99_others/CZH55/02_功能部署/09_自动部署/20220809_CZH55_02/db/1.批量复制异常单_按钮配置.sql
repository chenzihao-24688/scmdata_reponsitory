DECLARE
  v_sql CLOB;
BEGIN
  v_sql := 'DECLARE
  v_abn_code_cp    VARCHAR2(32) := @abnormal_code_cp@;
  v_flag           NUMBER;
  v_abn_range      VARCHAR2(4000);
  v_order_id       VARCHAR2(4000);
  v_order_amount   NUMBER;
  v_color_code     VARCHAR2(4000);
  v_interset_color VARCHAR2(4000);
BEGIN
  SELECT COUNT(1)
    INTO v_flag
    FROM scmdata.t_abnormal t
   WHERE t.company_id = %default_company_id%
     AND t.create_id = :user_id
     AND t.abnormal_code = v_abn_code_cp;
  IF v_flag = 0 THEN
    raise_application_error(-20002,
                            ''提示：输入异常处理编码不存在/错误，请检查！！'');
  ELSE
    SELECT COUNT(1)
      INTO v_flag
      FROM scmdata.t_abnormal a
     WHERE a.company_id = %default_company_id%
       AND a.create_id = :user_id
       AND a.abnormal_code IN (@selection)
       AND NOT EXISTS
     (SELECT 1
              FROM scmdata.t_abnormal b
             WHERE b.company_id = a.company_id
               AND b.create_id = a.create_id
               AND b.abnormal_code = v_abn_code_cp
               AND b.goo_id = a.goo_id
               AND b.anomaly_class = a.anomaly_class);
  
    IF v_flag > 0 THEN
      raise_application_error(-20002,
                              ''提示：所勾选异常单与被复制异常单的[货号+异常分类]相同时才可复制，请检查！！'');
    ELSE
    
      SELECT MAX(b.abnormal_range)
        INTO v_abn_range
        FROM scmdata.t_abnormal b
       WHERE b.company_id = %default_company_id%
         AND b.create_id = :user_id
         AND b.abnormal_code = v_abn_code_cp;
    
      IF v_abn_range NOT IN (''00'', ''01'') THEN
        SELECT listagg(a.order_id, ''、'')
          INTO v_order_id
          FROM scmdata.t_abnormal a
          LEFT JOIN (SELECT od.goo_id,
                            od.order_id,
                            listagg(tcs.color_code, '' '') color_code
                       FROM scmdata.t_ordersitem od
                      INNER JOIN scmdata.t_commodity_info tc
                         ON od.goo_id = tc.goo_id
                      INNER JOIN scmdata.t_commodity_color_size tcs
                         ON tc.commodity_info_id = tcs.commodity_info_id
                        AND od.barcode = tcs.barcode
                      WHERE od.company_id = %default_company_id%
                      GROUP BY od.goo_id, od.order_id) v
            ON v.goo_id = a.goo_id
           AND v.order_id = a.order_id
         WHERE a.company_id = %default_company_id%
           AND a.create_id = :user_id
           AND a.abnormal_code IN (@selection)
           AND scmdata.instr_priv(p_str1  => '' '' || v_abn_range || '' '',
                                  p_str2  => '' '' || v.color_code || '' '',
                                  p_split => '' '') = 0;
        IF v_order_id IS NOT NULL THEN
          raise_application_error(-20002,
                                  ''复制失败！所选订单('' || v_order_id ||
                                  '') 与被复制订单”异常范围“的颜色不一致，请检查！！'');
        END IF;
      END IF;
      --满足校验逻辑，则进行异常单复制
      FOR abn_rec IN (SELECT t.*
                        FROM scmdata.t_abnormal t
                       WHERE t.company_id = %default_company_id%
                         AND t.create_id = :user_id
                         AND t.abnormal_code IN (@selection)) LOOP
        --判断被复制异常单的异常范围，数量取值按以下逻辑赋值
        --全部 则复制订单数量
        --指定数量 则为空，提交时校验必填
        --颜色  勾选异常单订单颜色与被复制异常单订单颜色的交集，并获取对应颜色的订单数量
        IF '' '' || v_abn_range || '' '' = '' 00 '' THEN
          SELECT nvl(MAX(t.order_amount), 0)
            INTO v_order_amount
            FROM scmdata.t_production_progress t
           WHERE t.goo_id = abn_rec.goo_id
             AND t.order_id = abn_rec.order_id
             AND t.company_id = %default_company_id%;
          abn_rec.abnormal_range := v_abn_range;
          abn_rec.delay_amount := v_order_amount;
        ELSIF '' '' || v_abn_range || '' '' = '' 01 '' THEN
          abn_rec.abnormal_range := v_abn_range;
          abn_rec.delay_amount := NULL;
        ELSE
          SELECT listagg(DISTINCT tcs.color_code, '' '') within GROUP(ORDER BY tcs.color_code ASC) color_code
            INTO v_color_code
            FROM scmdata.t_ordersitem od
           INNER JOIN scmdata.t_commodity_info tc
              ON od.goo_id = tc.goo_id
           INNER JOIN scmdata.t_commodity_color_size tcs
              ON tc.commodity_info_id = tcs.commodity_info_id
             AND od.barcode = tcs.barcode
           WHERE od.company_id = %default_company_id%
             AND od.goo_id = abn_rec.goo_id
             AND od.order_id = abn_rec.order_id
           GROUP BY od.goo_id, od.order_id;
          --获取勾选异常单订单颜色与被复制异常单订单颜色的交集
          v_interset_color := scmdata.pkg_plat_comm.f_get_varchar_intersect(p_str1     => v_abn_range,
                                                                            p_str2     => v_color_code,
                                                                            p_separate => '' '');
          --通过颜色交集 获取对应颜色的订单数量
          SELECT SUM(CASE
                       WHEN scmdata.instr_priv(p_str1  => '' '' || tcs.color_code || '' '',
                                               p_str2  => '' '' || v_interset_color || '' '',
                                               p_split => '' '') > 0 THEN
                        od.order_amount
                       ELSE
                        0
                     END) order_amount
            INTO v_order_amount
            FROM scmdata.t_ordersitem od
           INNER JOIN scmdata.t_commodity_info tc
              ON od.goo_id = tc.goo_id
           INNER JOIN scmdata.t_commodity_color_size tcs
              ON tc.commodity_info_id = tcs.commodity_info_id
             AND od.barcode = tcs.barcode
           WHERE od.goo_id = abn_rec.goo_id
             AND od.order_id = abn_rec.order_id
             AND od.company_id = %default_company_id%;
          --范围、数量赋值
          abn_rec.abnormal_range := v_interset_color;
          abn_rec.delay_amount := v_order_amount;
        END IF;
        --批量复制异常单
        --1)v_abn_rec 勾选异常单
        --2)p_abnormal_code_cp 被复制异常单编码
        pkg_production_progress.batch_copy_abnormal(p_company_id       => %default_company_id%,
                                                    p_user_id          => :user_id,
                                                    v_abn_rec          => abn_rec, --勾选异常单
                                                    p_abnormal_code_cp => v_abn_code_cp);
      END LOOP;
    END IF;
  END IF;
END;';
  UPDATE bw3.sys_action t
     SET t.action_sql = v_sql
   WHERE t.element_id IN ('action_a_product_118_5');
END;
/ 
DECLARE
 v_sql CLOB;
BEGIN
  v_sql := 'DECLARE
  v_abn_code_cp  VARCHAR2(32) := @abnormal_code_cp@;
  v_flag         NUMBER;
  v_abn_range    VARCHAR2(4000);
  v_order_id     VARCHAR2(4000);
  v_order_amount NUMBER;
  v_color_code VARCHAR2(4000);
  v_interset_color VARCHAR2(4000);
BEGIN
  SELECT COUNT(1)
    INTO v_flag
    FROM scmdata.t_abnormal t
   WHERE t.company_id = %default_company_id%
     --AND t.create_id = :user_id
     AND t.abnormal_code = v_abn_code_cp;
  IF v_flag = 0 THEN
    raise_application_error(-20002,
                            ''提示：输入异常处理编码不存在/错误，请检查！！'');
  ELSE
  SELECT COUNT(1)
    INTO v_flag
    FROM scmdata.t_abnormal a
   WHERE a.company_id = %default_company_id%
     --AND a.create_id = :user_id
     AND a.abnormal_code IN (@selection)
     AND NOT EXISTS (SELECT 1
            FROM scmdata.t_abnormal b
           WHERE b.company_id = a.company_id
             --AND b.create_id = a.create_id
             AND b.abnormal_code = v_abn_code_cp
             AND b.goo_id = a.goo_id
             AND b.anomaly_class = a.anomaly_class);

  IF v_flag > 0 THEN
    raise_application_error(-20002,
                            ''提示：所勾选异常单与被复制异常单的[货号+异常分类]相同时才可复制，请检查！！'');
  ELSE
  
    SELECT MAX(b.abnormal_range)
      INTO v_abn_range
      FROM scmdata.t_abnormal b
     WHERE b.company_id = %default_company_id%
       --AND b.create_id = :user_id
       AND b.abnormal_code = v_abn_code_cp;
  
    IF v_abn_range NOT IN (''00'', ''01'') THEN
      SELECT listagg(a.order_id, ''、'')
        INTO v_order_id
        FROM scmdata.t_abnormal a
        LEFT JOIN (SELECT od.goo_id,
                          od.order_id,
                          listagg(tcs.color_code, '' '') color_code
                     FROM scmdata.t_ordersitem od
                    INNER JOIN scmdata.t_commodity_info tc
                       ON od.goo_id = tc.goo_id
                    INNER JOIN scmdata.t_commodity_color_size tcs
                       ON tc.commodity_info_id = tcs.commodity_info_id
                      AND od.barcode = tcs.barcode
                    WHERE od.company_id = %default_company_id%
                    GROUP BY od.goo_id, od.order_id) v
          ON v.goo_id = a.goo_id
         AND v.order_id = a.order_id
       WHERE a.company_id = %default_company_id%
         --AND a.create_id = :user_id
         AND a.abnormal_code IN (@selection)
         AND scmdata.instr_priv(p_str1  => '' '' || v_abn_range || '' '',
                                p_str2  => '' '' || v.color_code || '' '',
                                p_split => '' '') = 0;
      IF v_order_id IS NOT NULL THEN
        raise_application_error(-20002,
                                ''复制失败！所选订单('' || v_order_id ||
                                '') 与被复制订单”异常范围“的颜色不一致，请检查！！'');
      END IF;
    END IF;
    --满足校验逻辑，则进行异常单复制
    FOR abn_rec IN (SELECT t.*
                      FROM scmdata.t_abnormal t
                     WHERE t.company_id = %default_company_id%
                       --AND t.create_id = :user_id
                       AND t.abnormal_code IN (@selection)) LOOP
      --判断被复制异常单的异常范围，数量取值按以下逻辑赋值
      --全部 则复制订单数量
      --指定数量 则为空，提交时校验必填
      --颜色  勾选异常单订单颜色与被复制异常单订单颜色的交集，并获取对应颜色的订单数量
      IF '' '' || v_abn_range || '' '' = '' 00 '' THEN
        SELECT nvl(MAX(t.order_amount), 0)
          INTO v_order_amount
          FROM scmdata.t_production_progress t
         WHERE t.goo_id = abn_rec.goo_id
           AND t.order_id = abn_rec.order_id
           AND t.company_id = %default_company_id%;
        abn_rec.abnormal_range := v_abn_range;
        abn_rec.delay_amount := v_order_amount;
      ELSIF '' '' || v_abn_range || '' '' = '' 01 '' THEN
        abn_rec.abnormal_range := v_abn_range;
        abn_rec.delay_amount := NULL;
      ELSE
        SELECT listagg(distinct tcs.color_code, '' '') within group (order by tcs.color_code asc) color_code
          INTO v_color_code
          FROM scmdata.t_ordersitem od
         INNER JOIN scmdata.t_commodity_info tc
            ON od.goo_id = tc.goo_id
         INNER JOIN scmdata.t_commodity_color_size tcs
            ON tc.commodity_info_id = tcs.commodity_info_id
           AND od.barcode = tcs.barcode
         WHERE od.company_id = %default_company_id%
           AND od.goo_id = abn_rec.goo_id
           AND od.order_id = abn_rec.order_id
         GROUP BY od.goo_id, od.order_id;
        --获取勾选异常单订单颜色与被复制异常单订单颜色的交集
        v_interset_color := scmdata.pkg_plat_comm.f_get_varchar_intersect(p_str1     => v_abn_range,
                                                                          p_str2     => v_color_code,
                                                                          p_separate => '' '');
        --通过颜色交集 获取对应颜色的订单数量
        SELECT SUM(CASE
                     WHEN scmdata.instr_priv(p_str1  => '' '' || tcs.color_code || '' '',p_str2  => '' '' || v_interset_color || '' '',p_split => '' '') > 0  THEN
                      od.order_amount
                     ELSE
                      0
                   END) order_amount
          INTO v_order_amount
          FROM scmdata.t_ordersitem od
         INNER JOIN scmdata.t_commodity_info tc
            ON od.goo_id = tc.goo_id
         INNER JOIN scmdata.t_commodity_color_size tcs
            ON tc.commodity_info_id = tcs.commodity_info_id
           AND od.barcode = tcs.barcode
         WHERE od.goo_id = abn_rec.goo_id
           AND od.order_id = abn_rec.order_id
           AND od.company_id = %default_company_id%;
        --范围、数量赋值
        abn_rec.abnormal_range := v_interset_color;
        abn_rec.delay_amount := v_order_amount;
      END IF;
      --批量复制异常单
      --1)v_abn_rec 勾选异常单
      --2)p_abnormal_code_cp 被复制异常单编码
      pkg_production_progress.batch_copy_abnormal(p_company_id       => %default_company_id%,
                                                  p_user_id          => :user_id,
                                                  v_abn_rec          => abn_rec, --勾选异常单
                                                  p_abnormal_code_cp => v_abn_code_cp);
    END LOOP;
  END IF;
 END IF;
END;';
  UPDATE bw3.sys_action t
     SET t.action_sql = v_sql
   WHERE t.element_id IN ('action_a_product_118_5_all');
END;
/
