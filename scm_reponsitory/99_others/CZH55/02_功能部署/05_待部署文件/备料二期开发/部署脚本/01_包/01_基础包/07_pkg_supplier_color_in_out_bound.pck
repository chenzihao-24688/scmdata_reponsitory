CREATE OR REPLACE PACKAGE mrp.pkg_supplier_color_in_out_bound IS

  -- Author  : CZH55
  -- Created : 2023/4/25 17:39:55
  -- Purpose : ��Ʒ��Ӧ��ɫ������ⵥ-���������

  --��ѯ SUPPLIER_COLOR_IN_OUT_BOUND
  FUNCTION f_query_supplier_color_in_out_bound RETURN CLOB;

  --���� SUPPLIER_COLOR_IN_OUT_BOUND
  PROCEDURE p_insert_supplier_color_in_out_bound(p_suppl_rec supplier_color_in_out_bound%ROWTYPE);

  --�޸� SUPPLIER_COLOR_IN_OUT_BOUND
  PROCEDURE p_update_supplier_color_in_out_bound(p_suppl_rec supplier_color_in_out_bound%ROWTYPE);

  --ɾ�� SUPPLIER_COLOR_IN_OUT_BOUND
  PROCEDURE p_delete_supplier_color_in_out_bound(p_suppl_rec supplier_color_in_out_bound%ROWTYPE);

END pkg_supplier_color_in_out_bound;
/
CREATE OR REPLACE PACKAGE BODY mrp.pkg_supplier_color_in_out_bound IS
  --��ѯ SUPPLIER_COLOR_IN_OUT_BOUND
  FUNCTION f_query_supplier_color_in_out_bound RETURN CLOB IS
    v_sql CLOB;  
  BEGIN
    v_sql := '
SELECT t.bound_num, --ɫ������ⵥ��
       t.ascription, --����������0����1���
       t.bound_type, --��������ͣ�1�������⣬2�̿����⣬3���ϳ��⣬10Ʒ�Ʊ�����⣬11��Ӧ���ֻ���⣬12��ʱ������⣬13��ӯ��⣬14��ʱ��תɫ��� 15 ��Ӧ��ɫ����� 16 ��Ӧ���ֻ�����
       t.pro_supplier_code, --��Ʒ��Ӧ�̱��
       t.mater_supplier_code, --���Ϲ�Ӧ�̱��
       t.material_sku, --����SKU
       t.whether_inner_mater, --�Ƿ��ڲ����ϣ�0��1��
       t.unit, --��λ
       t.num, --����
       t.stock_type, --�ֿ����ͣ�1Ʒ�Ʋ֣�2��Ӧ�̲�
       t.relate_num, --��������
       t.relate_num_type, --�����������ͣ�1ɫ��������/2ɫ���̵㵥/3ɫ�����ϵ�/4���ϲɹ���/5�������ⵥ
       t.relate_skc, --����SKC
       t.relate_purchase, --�����ɹ�����
       t.company_id, --��ҵ����
       t.create_id, --������
       t.create_time, --����ʱ��
       t.update_id, --������
       t.update_time, --����ʱ��
       t.whether_del --�Ƿ�ɾ����0��1��
  FROM supplier_color_in_out_bound t
 WHERE 1 = 1
';
    RETURN v_sql;
  END f_query_supplier_color_in_out_bound;

  --���� SUPPLIER_COLOR_IN_OUT_BOUND
  PROCEDURE p_insert_supplier_color_in_out_bound(p_suppl_rec supplier_color_in_out_bound%ROWTYPE) IS
  BEGIN
  
    INSERT INTO supplier_color_in_out_bound
      (bound_num, ascription, bound_type, pro_supplier_code,
       mater_supplier_code, material_sku, whether_inner_mater, unit, num,
       stock_type, relate_num, relate_num_type, relate_skc, relate_purchase,
       company_id, create_id, create_time, update_id, update_time,
       whether_del)
    VALUES
      (p_suppl_rec.bound_num, p_suppl_rec.ascription,
       p_suppl_rec.bound_type, p_suppl_rec.pro_supplier_code,
       p_suppl_rec.mater_supplier_code, p_suppl_rec.material_sku,
       p_suppl_rec.whether_inner_mater, p_suppl_rec.unit, p_suppl_rec.num,
       p_suppl_rec.stock_type, p_suppl_rec.relate_num,
       p_suppl_rec.relate_num_type, p_suppl_rec.relate_skc,
       p_suppl_rec.relate_purchase, p_suppl_rec.company_id,
       p_suppl_rec.create_id, p_suppl_rec.create_time, p_suppl_rec.update_id,
       p_suppl_rec.update_time, p_suppl_rec.whether_del);
  END p_insert_supplier_color_in_out_bound;

  --�޸� SUPPLIER_COLOR_IN_OUT_BOUND
  PROCEDURE p_update_supplier_color_in_out_bound(p_suppl_rec supplier_color_in_out_bound%ROWTYPE) IS
  BEGIN
  
    UPDATE supplier_color_in_out_bound t
       SET t.ascription          = p_suppl_rec.ascription, --����������0����1���
           t.bound_type          = p_suppl_rec.bound_type, --��������ͣ�1�������⣬2�̿����⣬3���ϳ��⣬10Ʒ�Ʊ�����⣬11��Ӧ���ֻ���⣬12��ʱ������⣬13��ӯ��⣬14��ʱ��תɫ��� 15 ��Ӧ��ɫ����� 16 ��Ӧ���ֻ�����
           t.pro_supplier_code   = p_suppl_rec.pro_supplier_code, --��Ʒ��Ӧ�̱��
           t.mater_supplier_code = p_suppl_rec.mater_supplier_code, --���Ϲ�Ӧ�̱��
           t.material_sku        = p_suppl_rec.material_sku, --����SKU
           t.whether_inner_mater = p_suppl_rec.whether_inner_mater, --�Ƿ��ڲ����ϣ�0��1��
           t.unit                = p_suppl_rec.unit, --��λ
           t.num                 = p_suppl_rec.num, --����
           t.stock_type          = p_suppl_rec.stock_type, --�ֿ����ͣ�1Ʒ�Ʋ֣�2��Ӧ�̲�
           t.relate_num          = p_suppl_rec.relate_num, --��������
           t.relate_num_type     = p_suppl_rec.relate_num_type, --�����������ͣ�1ɫ��������/2ɫ���̵㵥/3ɫ�����ϵ�/4���ϲɹ���/5�������ⵥ
           t.relate_skc          = p_suppl_rec.relate_skc, --����SKC
           t.relate_purchase     = p_suppl_rec.relate_purchase, --�����ɹ�����
           t.company_id          = p_suppl_rec.company_id, --��ҵ����
           t.create_id           = p_suppl_rec.create_id, --������
           t.create_time         = p_suppl_rec.create_time, --����ʱ��
           t.update_id           = p_suppl_rec.update_id, --������
           t.update_time         = p_suppl_rec.update_time, --����ʱ��
           t.whether_del         = p_suppl_rec.whether_del --�Ƿ�ɾ����0��1��
     WHERE t.bound_num = p_suppl_rec.bound_num;
  END p_update_supplier_color_in_out_bound;

  --ɾ�� SUPPLIER_COLOR_IN_OUT_BOUND
  PROCEDURE p_delete_supplier_color_in_out_bound(p_suppl_rec supplier_color_in_out_bound%ROWTYPE) IS
  BEGIN
    DELETE FROM supplier_color_in_out_bound t WHERE t.bound_num = p_suppl_rec.bound_num;
  END p_delete_supplier_color_in_out_bound;

END pkg_supplier_color_in_out_bound;
/
