--�ۿ�����ⵥ
DECLARE
  v_sql_01 CLOB;
  v_sql_02 CLOB;
BEGIN
  v_sql_01 := '{DECLARE
  v_select_sql CLOB;
  v_count      NUMBER;
BEGIN
  SELECT COUNT(DISTINCT a.supplier_code)
    INTO v_count
    FROM scmdata.t_ordered a
   WHERE a.company_id = %default_company_id%
     AND a.order_code IN (@selection);
  IF v_count > 1 THEN
    raise_application_error(-20002,
                            ''�빴ѡͬһ�ҹ�Ӧ���µĶ��������ɿۿ'');
  ELSE
    v_select_sql := ''SELECT ''''DT0001'''' template_code,
       a.company_id,
       (SELECT sp.supplier_company_name
          FROM scmdata.t_supplier_info sp
         WHERE sp.company_id = a.company_id
           AND sp.supplier_code = a.supplier_code) supplier_company_name,
       a.order_code,
       (SELECT SUM(td.actual_discount_price)
          FROM scmdata.t_deduction td
         WHERE td.company_id = a.company_id
           AND td.order_id = a.order_code) total_money
  FROM scmdata.t_ordered a
 WHERE a.company_id = %default_company_id%
   AND a.order_code in (@selection)'';
   @strresult   := v_select_sql;
  END IF;
END;}';

  v_sql_02 := '{DECLARE
  v_flag       NUMBER;
  v_select_sql CLOB;
  v_count      NUMBER := 0;
  v_sup_count  NUMBER;
BEGIN
  SELECT COUNT(DISTINCT a.supplier_code)
    INTO v_sup_count
    FROM scmdata.t_ordered a
   WHERE a.company_id = %default_company_id%
     AND a.order_code IN (@selection);
  --�빴ѡͬһ�ҹ�Ӧ���µĶ��������ɿۿ
  IF v_sup_count > 1 THEN
    raise_application_error(-20002,
                            ''�빴ѡͬһ�ҹ�Ӧ���µĶ��������ɿۿ���ⵥ'');
  ELSE
    FOR po_rec IN (SELECT a.company_id, a.order_code
                     FROM scmdata.t_ordered a
                    WHERE a.company_id = %default_company_id%
                      AND a.order_code IN (@selection)) LOOP
      --��ѡ�����ۿ���ϸֻ�е������Ϊ�����Ŀۿ�����ӡ
      SELECT COUNT(1)
        INTO v_flag
        FROM scmdata.t_deduction td
       WHERE td.company_id = po_rec.company_id
         AND td.order_id = po_rec.order_code
         AND sign(td.adjust_price) = -1;
    
      IF v_flag > 0 THEN
        v_count := v_count + 1;
      END IF;
    
    END LOOP;
  
    IF v_count > 0 THEN
      v_select_sql := ''WITH total_cal AS
 (SELECT SUM(td.actual_discount_price) total_money,
         SUM(td.adjust_price) total_reduction_price,
         SUM(td.actual_discount_price) total_actual_discount_price
    FROM scmdata.t_deduction td
   WHERE td.company_id = %default_company_id%
     AND td.order_id in (@selection))
SELECT ''''DT0002'''' template_code,
       a.company_id,
       a.order_code,
       (SELECT sp.supplier_company_name
          FROM scmdata.t_supplier_info sp
         WHERE sp.company_id = a.company_id
           AND sp.supplier_code = a.supplier_code) supplier_company_name,
       (SELECT td1.total_money FROM total_cal td1) total_money,
       '''''''' total_reduratio,
       (SELECT td2.total_reduction_price FROM total_cal td2) total_reduprice,
       (SELECT td3.total_actual_discount_price FROM total_cal td3) total_actprice
  FROM scmdata.t_ordered a
 WHERE a.company_id = %default_company_id%
   AND a.order_code in (@selection)'';
      @strresult   := v_select_sql;
    ELSE
      raise_application_error(-20002,
                              ''��ѡ�����ۿ���ϸֻ�е������Ϊ�����Ŀۿ�����ӡ'');
    END IF;
  END IF;
END;}';

  UPDATE bw3.sys_file_template t
     SET t.select_sql = v_sql_01, t.multi_select_flag = 2
   WHERE t.element_id = 'word_a_product_130_1';

  UPDATE bw3.sys_file_template t
     SET t.select_sql = v_sql_02, t.multi_select_flag = 2
   WHERE t.element_id = 'word_a_product_130_2';

END;

/

DECLARE v_sql_03 CLOB;
v_sql_04 CLOB;
BEGIN
  v_sql_03 := q'[WITH delivery_amount AS
 (SELECT * FROM scmdata.t_delivery_record dr),
deduction_ratio AS
 (SELECT dc.deduction_ratio,
         dc.section_start,
         dc.section_end,
         tc.company_id,
         tc.goo_id
    FROM scmdata.t_commodity_info tc
   INNER JOIN scmdata.t_deduction_range_config dr
      ON tc.company_id = dr.company_id
     AND tc.category = dr.industry_classification
     AND tc.product_cate = dr.production_category
     AND instr(';' || dr.product_subclass || ';',
               ';' || tc.samll_category || ';') > 0
     AND dr.pause = 0
   INNER JOIN scmdata.t_deduction_dtl_config dc
      ON dr.company_id = dc.company_id
     AND dr.deduction_config_id = dc.deduction_config_id
     AND dc.pause = 0
   INNER JOIN scmdata.t_deduction_config td
      ON td.company_id = dc.company_id
     AND td.deduction_config_id = dc.deduction_config_id
     AND td.pause = 0)
SELECT order_id "�������ݺ�",
       style_number "����",
       delay_amount "����",
       order_price "����",
       delay_amount * order_price "�ܼ�",
       to_char(delivery_date, 'yyyy-mm-dd') "Լ������",
       to_char(arrival_date, 'yyyy-mm-dd') "ʵ�ʽ���",
       detailed_reasons "�ۿ�ԭ��",
       deduction_ratio "Ӧ�۱���",
       ROUND(actual_discount_price,2) "Ӧ�۽��",
       adjust_reason "��ע"
  FROM (SELECT td.order_id order_id,
               (SELECT tc.style_number
                  FROM scmdata.t_commodity_info tc
                 WHERE tc.company_id = pr.company_id
                   AND tc.goo_id = pr.goo_id) style_number,
               decode(td.orgin,
                      'SC',
                      nvl(abn.delay_amount, 0),
                      'MA',
                      (SELECT SUM(dr1.delivery_amount)
                         FROM delivery_amount dr1
                        WHERE dr1.company_id = pr.company_id
                          AND dr1.order_code = pr.order_id
                          AND dr1.goo_id = pr.goo_id)) delay_amount,
               ln.order_price order_price,
               --td.actual_discount_price total_money,
               /*(SELECT ln.delivery_date
                FROM scmdata.t_orders ln
               WHERE ln.company_id = pr.company_id
                 AND ln.order_id = pr.order_id
                 AND ln.goo_id = pr.goo_id) delivery_date,*/
               po.delivery_date delivery_date,
               td.arrival_date arrival_date,
               decode(abn.anomaly_class,
                      'AC_QUALITY',
                      '�����ۿ�',
                      abn.detailed_reasons) detailed_reasons,
               decode(abn.deduction_method,
                      'METHOD_00',
                      abn.deduction_unit_price || 'Ԫ/��',
                      'METHOD_01',
                      NULL,
                      'METHOD_02',
                      decode(td.orgin,
                             'SC',
                             nvl((SELECT deduction_ratio
                                    FROM deduction_ratio drt
                                   WHERE drt.company_id = pr.company_id
                                     AND drt.goo_id = pr.goo_id
                                     AND (abn.delay_date >= drt.section_start AND
                                         abn.delay_date < drt.section_end)) || '%',
                                 NULL),
                             'MA',
                             abn.deduction_unit_price || '%',
                             NULL)) deduction_ratio,
               td.actual_discount_price,
               td.adjust_reason
          FROM scmdata.t_deduction td
         INNER JOIN scmdata.t_production_progress pr
            ON td.company_id = pr.company_id
           AND td.order_id = pr.order_id
         INNER JOIN scmdata.t_ordered po
            ON po.company_id = pr.company_id
           AND po.order_code = pr.order_id
         INNER JOIN scmdata.t_orders ln
            ON pr.company_id = ln.company_id
           AND pr.order_id = ln.order_id
           AND pr.goo_id = ln.goo_id
         INNER JOIN scmdata.t_abnormal abn
            ON pr.company_id = abn.company_id
           AND pr.order_id = abn.order_id
           AND pr.goo_id = abn.goo_id
           AND td.abnormal_id = abn.abnormal_id
         WHERE td.company_id = %default_company_id%
           AND td.order_id in (@selection))  
UNION ALL
SELECT distinct '�ϼƽ��' "�������ݺ�",
       NULL "����",
       NULL "����",
       NULL "����",
       NULL "�ܼ�",
       NULL "Լ������",
       NULL "ʵ�ʽ���",
       NULL "�ۿ�ԭ��",
       NULL "Ӧ�۱���",
       ROUND(SUM(discount_price),2) "Ӧ�۽��",
       NULL "��ע"
FROM (SELECT '�ϼƽ��' "�������ݺ�",
       NULL "����",
       NULL "����",
       NULL "����",
       NULL "�ܼ�",
       NULL "Լ������",
       NULL "ʵ�ʽ���",
       NULL "�ۿ�ԭ��",
       NULL "Ӧ�۱���",
       (SELECT SUM(td.actual_discount_price)
          FROM scmdata.t_deduction td
         WHERE td.company_id = a.company_id
           AND td.order_id = a.order_code) discount_price,
       NULL "��ע"
  FROM scmdata.t_ordered a
 WHERE a.company_id = %default_company_id% AND a.order_code in (@selection) )
 ]';

  v_sql_04 := q'[WITH delivery_amount AS
 (SELECT * FROM scmdata.t_delivery_record dr),
deduction_ratio AS
 (SELECT dc.deduction_ratio,
         dc.section_start,
         dc.section_end,
         tc.company_id,
         tc.goo_id
    FROM scmdata.t_commodity_info tc
   INNER JOIN scmdata.t_deduction_range_config dr
      ON tc.company_id = dr.company_id
     AND tc.category = dr.industry_classification
     AND tc.product_cate = dr.production_category
     AND instr(';' || dr.product_subclass || ';',
               ';' || tc.samll_category || ';') > 0
     AND dr.pause = 0
   INNER JOIN scmdata.t_deduction_dtl_config dc
      ON dr.company_id = dc.company_id
     AND dr.deduction_config_id = dc.deduction_config_id
     AND dc.pause = 0
   INNER JOIN scmdata.t_deduction_config td
      ON td.company_id = dc.company_id
     AND td.deduction_config_id = dc.deduction_config_id
     AND td.pause = 0),
total_cal AS
 (SELECT SUM(td.discount_price) total_money,
         SUM(td.adjust_price) total_reduction_price,
         SUM(td.actual_discount_price) total_actual_discount_price
    FROM scmdata.t_deduction td
   WHERE td.company_id = %default_company_id%
     AND td.order_id IN (@selection)
     AND sign(td.adjust_price) = -1)
SELECT order_id "�������ݺ�",
       style_number "����",
       delay_amount "����",
       order_price "����",
       delay_amount * order_price "�ܼ�",
       to_char(delivery_date, 'yyyy-mm-dd') "Լ������",
       to_char(arrival_date, 'yyyy-mm-dd') "ʵ�ʽ���",
       detailed_reasons "�ۿ�ԭ��",
       deduction_ratio "Ӧ�۱���",
       ROUND(discount_price,2) "Ӧ�۽��",
       reduction_ratio "�������",
       adjust_price * -1 "������",
       actual_discount_price "ʵ�۽��",
       adjust_reason "��ע"
  FROM (SELECT td.order_id order_id,
               (SELECT tc.style_number
                  FROM scmdata.t_commodity_info tc
                 WHERE tc.company_id = pr.company_id
                   AND tc.goo_id = pr.goo_id) style_number,
               decode(td.orgin,
                      'SC',
                      nvl(abn.delay_amount, 0),
                      'MA',
                      (SELECT SUM(dr1.delivery_amount)
                         FROM delivery_amount dr1
                        WHERE dr1.company_id = pr.company_id
                          AND dr1.order_code = pr.order_id
                          AND dr1.goo_id = pr.goo_id)) delay_amount,
               ln.order_price order_price,
               --td.actual_discount_price total_money,
               --ln.delivery_date delivery_date,
               po.delivery_date delivery_date,
               td.arrival_date arrival_date,
               decode(abn.anomaly_class,
                      'AC_QUALITY',
                      '�����ۿ�',
                      abn.detailed_reasons) detailed_reasons,
               decode(abn.deduction_method,
                      'METHOD_00',
                      abn.deduction_unit_price || 'Ԫ/��',
                      'METHOD_01',
                      NULL,
                      'METHOD_02',
                      decode(td.orgin,
                             'SC',
                             nvl((SELECT deduction_ratio
                                    FROM deduction_ratio drt
                                   WHERE drt.company_id = pr.company_id
                                     AND drt.goo_id = pr.goo_id
                                     AND (abn.delay_date >= drt.section_start AND
                                         abn.delay_date < drt.section_end)) || '%',
                                 NULL),
                             'MA',
                             abn.deduction_unit_price || '%',
                             NULL)) deduction_ratio,
               td.discount_price,
               '' reduction_ratio,
               td.adjust_price,
               td.actual_discount_price,
               td.adjust_reason
          FROM scmdata.t_deduction td
         INNER JOIN scmdata.t_production_progress pr
            ON td.company_id = pr.company_id
           AND td.order_id = pr.order_id
         INNER JOIN scmdata.t_ordered po
            ON po.company_id = pr.company_id
           AND po.order_code = pr.order_id
         INNER JOIN scmdata.t_orders ln
            ON pr.company_id = ln.company_id
           AND pr.order_id = ln.order_id
           AND pr.goo_id = ln.goo_id
         INNER JOIN scmdata.t_abnormal abn
            ON pr.company_id = abn.company_id
           AND pr.order_id = abn.order_id
           AND pr.goo_id = abn.goo_id
           AND td.abnormal_id = abn.abnormal_id
         WHERE td.company_id = %default_company_id%
           AND td.order_id IN (@selection)
           AND sign(td.adjust_price) = -1)
UNION ALL
SELECT '�ϼƽ��' "�������ݺ�",
       NULL "����",
       NULL "����",
       NULL "����",
       NULL "�ܼ�",
       NULL "Լ������",
       NULL "ʵ�ʽ���",
       NULL "�ۿ�ԭ��",
       NULL "Ӧ�۱���",
       ROUND(SUM(ded_price),2) "Ӧ�۽��",
       NULL "�������",
       ROUND(SUM(redu_price),2) "������",
       ROUND(SUM(actuded_price),2) "ʵ�۽��",
       NULL "��ע"
  FROM (SELECT '�ϼƽ��' "�������ݺ�",
               NULL "����",
               NULL "����",
               NULL "����",
               NULL "�ܼ�",
               NULL "Լ������",
               NULL "ʵ�ʽ���",
               NULL "�ۿ�ԭ��",
               NULL "Ӧ�۱���",
               td.total_money ded_price,
               NULL "�������",
               td.total_reduction_price * -1 redu_price,
               td.total_actual_discount_price actuded_price,
               NULL "��ע"
          FROM total_cal td)]';

  UPDATE bw3.sys_file_template_table t
     SET t.form_sql = v_sql_03,t.table_colwidths = '4000,4000,3000,3000,3000,5000,5000,5000,4000,4000,5000'
   WHERE t.element_id = 'word_a_product_130_1';

  UPDATE bw3.sys_file_template_table t
     SET t.form_sql = v_sql_04
   WHERE t.element_id = 'word_a_product_130_2';

END;
