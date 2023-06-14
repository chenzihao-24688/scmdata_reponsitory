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

  --�����Ʋ��ܱ�־λ
  v_flag := -1;

  IF :new.finishtime IS NOT NULL AND
     nvl(:new.memo, '#') NOT LIKE '%ϵͳ�Զ�����%' THEN
     
    --czh add ��ȡ barcode ,goo_id
    SELECT ai.barcode, ai.goo_id
      INTO v_barcode, v_goo_id
      FROM nsfdata.asnordered ae
     INNER JOIN nsfdata.asnordersitem ai
        ON ai.asn_id = ae.asn_id
     WHERE ae.asn_id = :old.asn_id;
    --czh end
     
    --modified 2022-4-19
    --234  ����ױ��;235  �沿ױ��;238  �۲�ױ��;240  �沿����;241  �沿���;
    --243  ���廤��;244  ���⻤��;465  ��������;468  ��ԡ���;469  ��Ĥ����
    --����>0.1
    --������>200
    --����¼����������
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
        --��Ʒ��SKUʱԤ�Ƶ�������Ʒ����ֶα���;
        IF has_sku = 0 THEN
          SELECT MAX(1)
            INTO p_j
            FROM asnorders a
           WHERE a.asn_id = :old.asn_id
             AND (product_date IS NULL OR limit_use_date IS NULL OR
                 batchno IS NULL);
          IF p_j = 1 THEN
            raise_application_error(-20002,
                                    '��Ʒ��SKU,Ԥ�Ƶ�������Ʒ���������ڡ�����ʹ�����ں��������ű���');
          END IF;
        
          --czh add ����У��
          SELECT MAX(gs.attachname)
            INTO v_flag
            FROM goodsofinspect gs
           WHERE gs.goo_id = v_goo_id;
        
          IF v_flag IS NULL THEN
            raise_application_error(-20002,
                                    '��Ʒ��SKU,��������Ϊ�գ�����');
          END IF;
          --czh end     
        
          --¼����������š��������ڡ�����ʹ�����ڱ������ʼ챨���Ӧ
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
                                    '¼����������š��������ڡ�����ʹ�����ڱ������ʼ챨���Ӧ');
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
                                    '����SKUʱ,Ԥ�Ƶ�����SKU���������ڡ�����ʹ�����ں��������ű���');
          END IF;
        
          --czh add ����У��
          SELECT MAX(gs.attachname)
            INTO v_flag
            FROM goodsofinspect gs
           WHERE gs.goo_id = v_goo_id
             AND gs.barcode = v_barcode;
        
          IF v_flag IS NULL THEN
            raise_application_error(-20002,
                                    '����SKUʱ,��������Ϊ�գ�����');
          END IF;
          --czh end 
        
          --¼����������š��������ڡ�����ʹ�����ڱ������ʼ챨���Ӧ
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
                                    '¼����������š��������ڡ�����ʹ�����ڱ������ʼ챨���Ӧ');
          END IF;
        END IF; --has_sku
      END IF;
    END IF; --P_I=1
  
    --20230529 czh add begin
    --������1218�������޸ġ���ť����У������
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
  
    ----�ж��Ƿ�����ֲ�=ʳƷ�����۴���0.01Ԫ��ASN����
    IF p_i > 0 THEN
      --�ж��Ƿ���sku
      IF has_sku = 0 THEN
        SELECT MAX(1)
          INTO p_j
          FROM asnorders a
         WHERE a.asn_id = :old.asn_id
           AND (product_date IS NULL OR limit_use_date IS NULL OR
               batchno IS NULL);
        IF p_j = 1 THEN
          raise_application_error(-20002,
                                  '��Ʒ��SKU,Ԥ�Ƶ�������Ʒ���������ڡ�����ʹ�����ں��������ű���');
        END IF;
      
        SELECT MAX(gs.attachname)
          INTO v_flag
          FROM goodsofinspect gs
         WHERE gs.goo_id = v_goo_id;
      
        IF v_flag IS NULL THEN
          raise_application_error(-20002, '��Ʒ��SKU,��������Ϊ�գ�����');
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
                                  '����SKUʱ,Ԥ�Ƶ�����SKU���������ڡ�����ʹ�����ں��������ű���');
        END IF;
        SELECT MAX(gs.attachname)
          INTO v_flag
          FROM goodsofinspect gs
         WHERE gs.goo_id = v_goo_id
           AND gs.barcode = v_barcode;
      
        IF v_flag IS NULL THEN
          raise_application_error(-20002, '����SKUʱ,��������Ϊ�գ�����');
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
    --�Ƿǲ��������Ž��в��ܿ���
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
    
      --���ݲ���ױֱ������ȡֱ������
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
      --��������� -1 �� ������ ����
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
                                  'ASN����:' || v_asnid || '��������' ||
                                  v_pcomedate || '��' || :new.time_interval ||
                                  '��ʱ�ֿ⡾' || v_sho_id || '��ʣ�����Ϊ��' ||
                                  v_capacity || '��,�������ܡ�' || v_amount ||
                                  '��,���޸�Ԥ�Ƶ���ʱ�����ϵ�ֿ����Ա��������!');
        END IF;
      END IF;
    END IF;
  END IF;
END;
/
