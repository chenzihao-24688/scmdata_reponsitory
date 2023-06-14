CREATE OR REPLACE TRIGGER nsfdata.tr_bf_ud_asnfinishtime
  BEFORE UPDATE OF finishtime ON nsfdata.asnordered
  FOR EACH ROW
DECLARE
  v_bra_id       VARCHAR2(2);
  v_capacity     NUMBER(18);
  v_sho_id       VARCHAR2(6);
  v_pcomedate    VARCHAR2(10);
  v_pcomeamount  NUMBER(18);
  v_amount       NUMBER(18);
  total_amount   NUMBER(18);
  v_is_fcl_out   NUMBER(1);
  v_is_muchgoods NUMBER(1);
  v_asnid        VARCHAR2(15);
  v_flag         NUMBER(1);
  v_goo_id       goods.goo_id%TYPE;
  v_barcode      articles.barcode%TYPE;
  p_i            INT;
  p_j            INT;
  has_sku        INT;
  v_type         ordered.po_type%TYPE;
  v_muchgoods    ordered.is_much_goods%TYPE;
  PRAGMA AUTONOMOUS_TRANSACTION;
BEGIN

  --不控制产能标志位
  v_flag := -1;

  IF :new.finishtime IS NOT NULL AND
     nvl(:new.memo, '#') NOT LIKE '%系统自动生成%' THEN
     
    --czh add 获取 barcode ,goo_id
    SELECT ai.barcode, ai.goo_id
      INTO v_barcode, v_goo_id
      FROM nsfdata.asnordered ae
     INNER JOIN nsfdata.asnordersitem ai
        ON ai.asn_id = ae.asn_id
     WHERE ae.asn_id = :old.asn_id;
    --czh end
     
    --modified 2022-4-19
    --234  唇部妆容;235  面部妆容;238  眼部妆容;240  面部护理;241  面部清洁;
    --243  身体护理;244  特殊护理;465  美发护发;468  沐浴清洁;469  面膜护理
    --定价>0.1
    --订单量>200
    --必须录入生产批号
    SELECT MAX(1)
      INTO p_i
      FROM asnorders a
     INNER JOIN asnordered b
        ON a.asn_id = b.asn_id
     INNER JOIN goods c
        ON a.goo_id = c.goo_id
     WHERE a.asn_id = :old.asn_id
          --And c.Categorygroupno In ('159', '160')
       AND c.categorygroupno IN (SELECT a.code_value
                                   FROM nsfdata.dic_codes a
                                  WHERE a.code_type = 'ASNORDERED_CHECK'
                                    AND a.sub_code_type = 'CATEGORYGROUPNO'
                                    AND a.pause = 0)
       AND c.bra_id = '06'
          --add 2022-4-19
       AND c.price > 0.1
       AND EXISTS (SELECT 1
              FROM (SELECT SUM(orderamount) orderamount
                      FROM nsfdata.orders t
                     WHERE t.ord_id = b.ord_id)
             WHERE orderamount > 200);
    IF p_i = 1 THEN
      SELECT MAX(1), hascolorsize(c.goo_id)
        INTO p_i, has_sku
        FROM asnorders a
       INNER JOIN asnordered b
          ON a.asn_id = b.asn_id
       INNER JOIN goods c
          ON a.goo_id = c.goo_id
       WHERE a.asn_id = :old.asn_id
            --And c.Categorygroupno In ('159', '160')
         AND c.categorygroupno IN
             (SELECT a.code_value
                FROM nsfdata.dic_codes a
               WHERE a.code_type = 'ASNORDERED_CHECK'
                 AND a.sub_code_type = 'CATEGORYGROUPNO'
                 AND a.pause = 0)
         AND c.bra_id = '06'
            --add 2022-4-19
         AND c.price > 0.1
         AND EXISTS (SELECT 1
                FROM (SELECT SUM(orderamount) orderamount
                        FROM nsfdata.orders t
                       WHERE t.ord_id = b.ord_id)
               WHERE orderamount > 200)
       GROUP BY hascolorsize(c.goo_id);
    
      IF p_i = 1 THEN
        --czh end
        --商品无SKU时预计到货单商品表该字段必填;
        IF has_sku = 0 THEN
          SELECT MAX(1)
            INTO p_j
            FROM asnorders a
           WHERE a.asn_id = :old.asn_id
             AND (product_date IS NULL OR limit_use_date IS NULL OR
                 batchno IS NULL);
          IF p_j = 1 THEN
            raise_application_error(-20002,
                                    '商品无SKU,预计到货单商品表生产日期、限制使用日期和生产批号必填');
          END IF;
        
          --czh add 附件校验
          SELECT MAX(gs.attachname)
            INTO v_flag
            FROM goodsofinspect gs
           WHERE gs.goo_id = v_goo_id;
        
          IF v_flag IS NULL THEN
            raise_application_error(-20002,
                                    '商品无SKU,附件不可为空，请检查');
          END IF;
          --czh end     
        
          --录入的生产批号、生产日期、限制使用日期必须与质检报告对应
          SELECT MAX(1)
            INTO p_i
            FROM goodsofinspect g
           WHERE EXISTS (SELECT 1
                    FROM asnorders a
                  --Inner Join Asnordered b On a.Asn_Id = b.Asn_Id
                   WHERE a.asn_id = :old.asn_id
                     AND g.product_date = a.product_date
                     AND g.limit_use_date = a.limit_use_date
                     AND g.batchno = a.batchno);
        
          IF p_i IS NULL THEN
            raise_application_error(-20002,
                                    '录入的生产批号、生产日期、限制使用日期必须与质检报告对应');
          END IF;
        ELSE
          --has_sku=1
          SELECT MAX(1)
            INTO p_j
            FROM asnordersitem a
           WHERE a.asn_id = :old.asn_id
             AND (product_date IS NULL OR limit_use_date IS NULL OR
                 batchno IS NULL);
          IF p_j = 1 THEN
            raise_application_error(-20002,
                                    '存在SKU时,预计到货单SKU表生产日期、限制使用日期和生产批号必填');
          END IF;
        
          --czh add 附件校验
          SELECT MAX(gs.attachname)
            INTO v_flag
            FROM goodsofinspect gs
           WHERE gs.goo_id = v_goo_id
             AND gs.barcode = v_barcode;
        
          IF v_flag IS NULL THEN
            raise_application_error(-20002,
                                    '存在SKU时,附件不可为空，请检查');
          END IF;
          --czh end 
        
          --录入的生产批号、生产日期、限制使用日期必须与质检报告对应
          SELECT MAX(1)
            INTO p_j
            FROM goodsofinspect g
           WHERE NOT EXISTS (SELECT 1
                    FROM asnordersitem a
                  --Inner Join Asnordered b On a.Asn_Id = b.Asn_Id
                   WHERE a.asn_id = :old.asn_id
                     AND g.product_date = a.product_date
                     AND g.limit_use_date = a.limit_use_date
                     AND g.batchno = a.batchno);
          IF p_j IS NULL THEN
            raise_application_error(-20002,
                                    '录入的生产批号、生产日期、限制使用日期必须与质检报告对应');
          END IF;
        END IF; --has_sku
      END IF;
    END IF; --P_I=1
  
    --20230529 czh add begin
    --禅道：1218【结束修改】按钮增加校验条件
    SELECT MAX(1), hascolorsize(c.goo_id)
      INTO p_i, has_sku
      FROM asnorders a
     INNER JOIN asnordered b
        ON a.asn_id = b.asn_id
     INNER JOIN goods c
        ON a.goo_id = c.goo_id
     WHERE a.asn_id = :old.asn_id
       AND c.bra_id = '109'
       AND c.price > 0.1
     GROUP BY hascolorsize(c.goo_id);
  
    ----判断是否满足分部=食品，定价大于0.01元的ASN订单
    IF p_i > 0 THEN
      --判断是否有sku
      IF has_sku = 0 THEN
        SELECT MAX(1)
          INTO p_j
          FROM asnorders a
         WHERE a.asn_id = :old.asn_id
           AND (product_date IS NULL OR limit_use_date IS NULL OR
               batchno IS NULL);
        IF p_j = 1 THEN
          raise_application_error(-20002,
                                  '商品无SKU,预计到货单商品表生产日期、限制使用日期和生产批号必填');
        END IF;
      
        SELECT MAX(gs.attachname)
          INTO v_flag
          FROM goodsofinspect gs
         WHERE gs.goo_id = v_goo_id;
      
        IF v_flag IS NULL THEN
          raise_application_error(-20002, '商品无SKU,附件不可为空，请检查');
        END IF;
      ELSE
        --has_sku=1
        SELECT MAX(1)
          INTO p_j
          FROM asnordersitem a
         WHERE a.asn_id = :old.asn_id
           AND (product_date IS NULL OR limit_use_date IS NULL OR
               batchno IS NULL);
        IF p_j = 1 THEN
          raise_application_error(-20002,
                                  '存在SKU时,预计到货单SKU表生产日期、限制使用日期和生产批号必填');
        END IF;
        SELECT MAX(gs.attachname)
          INTO v_flag
          FROM goodsofinspect gs
         WHERE gs.goo_id = v_goo_id
           AND gs.barcode = v_barcode;
      
        IF v_flag IS NULL THEN
          raise_application_error(-20002, '存在SKU时,附件不可为空，请检查');
        END IF;
      END IF;
    END IF;
    --czh end
  
    SELECT nvl(b.is_much_goods, 0)
      INTO v_is_muchgoods
      FROM nsfdata.asnordered a
     INNER JOIN nsfdata.ordered b
        ON a.ord_id = b.ord_id
     WHERE a.asn_id = :old.asn_id;
    --是非补货订单才进行产能控制
    IF v_is_muchgoods <> 1 THEN
      SELECT to_char(a.pcomedate, 'yyyy-mm-dd'),
             b.bra_id,
             b.sho_id,
             a.asn_id
        INTO v_pcomedate, v_bra_id, v_sho_id, v_asnid
        FROM nsfdata.asnordered a
       INNER JOIN nsfdata.ordered b
          ON a.ord_id = b.ord_id
       WHERE a.asn_id = :old.asn_id;
    
      SELECT MAX(a.is_fcl_out)
        INTO v_is_fcl_out
        FROM nsfdata.asnorders a
       WHERE a.asn_id = :old.asn_id;
    
      --广州仓美妆直发订单取直发产能
      IF v_sho_id = 'GZZ' AND v_bra_id = '06' AND v_is_fcl_out = 1 THEN
        SELECT nvl(a.fcl_out_capacity, -1)
          INTO v_capacity
          FROM nsfdata.branchcapacity a
         WHERE a.bra_id = v_bra_id
           AND a.time_interval = :old.time_interval
           AND a.sho_id = v_sho_id;
      ELSE
        SELECT nvl(a.capacity, v_flag)
          INTO v_capacity
          FROM nsfdata.branchcapacity a
         WHERE a.bra_id = v_bra_id
           AND a.time_interval = :old.time_interval
           AND a.sho_id = v_sho_id;
      END IF;
      --如果产能是 -1 则 不控制 产能
      IF v_capacity <> v_flag THEN
        SELECT nvl(SUM(b.pcomeamount), 0)
          INTO total_amount
          FROM nsfdata.asnordered a
         INNER JOIN nsfdata.asnorders b
            ON a.asn_id = b.asn_id
         INNER JOIN nsfdata.ordered c
            ON a.ord_id = c.ord_id
         WHERE trunc(a.pcomedate) = trunc(:old.pcomedate)
           AND a.finishtime IS NOT NULL
           AND c.bra_id = v_bra_id
           AND a.time_interval = :old.time_interval
           AND c.sho_id = v_sho_id;
        SELECT SUM(b.pcomeamount)
          INTO v_pcomeamount
          FROM nsfdata.asnordered a
         INNER JOIN nsfdata.asnorders b
            ON a.asn_id = b.asn_id
         WHERE a.asn_id = :old.asn_id;
      
        v_capacity := v_capacity - total_amount;
        v_amount   := v_pcomeamount - v_capacity;
        IF v_amount > 0 THEN
          raise_application_error(-20002,
                                  'ASN单号:' || v_asnid || '到货日期' ||
                                  v_pcomedate || '【' || :new.time_interval ||
                                  '】时仓库【' || v_sho_id || '】剩余产能为【' ||
                                  v_capacity || '】,超出产能【' || v_amount ||
                                  '】,请修改预计到货时间或联系仓库管理员调整产能!');
        END IF;
      END IF;
    END IF;
  END IF;
END;
/
