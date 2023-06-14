CREATE OR REPLACE PACKAGE mrp.pkg_material_color_in_out_bound IS
  -- Author  : CZH55
  -- Created : 2023/4/25 17:39:55
  -- Purpose : ���Ϲ�Ӧ��ɫ���ֿ�����-���������

  --��ѯ MATERIAL_COLOR_IN_OUT_BOUND
  FUNCTION f_query_material_color_in_out_bound RETURN CLOB;

  --���� MATERIAL_COLOR_IN_OUT_BOUND
  PROCEDURE p_insert_material_color_in_out_bound(p_mater_rec material_color_in_out_bound%ROWTYPE);

  --�޸� MATERIAL_COLOR_IN_OUT_BOUND
  PROCEDURE p_update_material_color_in_out_bound(p_mater_rec material_color_in_out_bound%ROWTYPE);

  --ɾ�� MATERIAL_COLOR_IN_OUT_BOUND
  PROCEDURE p_delete_material_color_in_out_bound(p_mater_rec material_color_in_out_bound%ROWTYPE);

END pkg_material_color_in_out_bound;
/
CREATE OR REPLACE PACKAGE BODY mrp.pkg_material_color_in_out_bound IS
  --��ѯ MATERIAL_COLOR_IN_OUT_BOUND
  FUNCTION f_query_material_color_in_out_bound RETURN CLOB IS
    v_sql CLOB; 
  BEGIN
    v_sql := '
SELECT t.bound_num, --ɫ������ⵥ��
       t.ascription, --����������0����1���
       t.bound_type, --��������ͣ�1�������⣬2�̿����⣬3���ϳ��⣬10Ʒ�Ʊ�����⣬11��Ӧ���ֻ���⣬12��ʱ������⣬13��ӯ��⣬14��ʱ��תɫ��� 15 ��Ӧ��ɫ����� 16 ��Ӧ���ֻ�����
       t.mater_supplier_code, --���Ϲ�Ӧ�̱��
       t.material_sku, --����SKU
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
       t.whether_del, --�Ƿ�ɾ����0��1��
       t.whether_inner_mater --�Ƿ��ڲ����ϣ�0��1��
  FROM material_color_in_out_bound t
 WHERE 1 = 1
';
    RETURN v_sql;
  END f_query_material_color_in_out_bound;

  --���� MATERIAL_COLOR_IN_OUT_BOUND
  PROCEDURE p_insert_material_color_in_out_bound(p_mater_rec material_color_in_out_bound%ROWTYPE) IS
  BEGIN
  
    INSERT INTO material_color_in_out_bound
      (bound_num, ascription, bound_type, mater_supplier_code, material_sku,
       unit, num, stock_type, relate_num, relate_num_type, relate_skc,
       relate_purchase, company_id, create_id, create_time, update_id,
       update_time, whether_del, whether_inner_mater)
    VALUES
      (p_mater_rec.bound_num, p_mater_rec.ascription,
       p_mater_rec.bound_type, p_mater_rec.mater_supplier_code,
       p_mater_rec.material_sku, p_mater_rec.unit, p_mater_rec.num,
       p_mater_rec.stock_type, p_mater_rec.relate_num,
       p_mater_rec.relate_num_type, p_mater_rec.relate_skc,
       p_mater_rec.relate_purchase, p_mater_rec.company_id,
       p_mater_rec.create_id, p_mater_rec.create_time, p_mater_rec.update_id,
       p_mater_rec.update_time, p_mater_rec.whether_del,
       p_mater_rec.whether_inner_mater);
  END p_insert_material_color_in_out_bound;

  --�޸� MATERIAL_COLOR_IN_OUT_BOUND
  PROCEDURE p_update_material_color_in_out_bound(p_mater_rec material_color_in_out_bound%ROWTYPE) IS
  BEGIN
  
    UPDATE material_color_in_out_bound t
       SET t.ascription          = p_mater_rec.ascription, --����������0����1���
           t.bound_type          = p_mater_rec.bound_type, --��������ͣ�1�������⣬2�̿����⣬3���ϳ��⣬10Ʒ�Ʊ�����⣬11��Ӧ���ֻ���⣬12��ʱ������⣬13��ӯ��⣬14��ʱ��תɫ��� 15 ��Ӧ��ɫ����� 16 ��Ӧ���ֻ�����
           t.mater_supplier_code = p_mater_rec.mater_supplier_code, --���Ϲ�Ӧ�̱��
           t.material_sku        = p_mater_rec.material_sku, --����SKU
           t.unit                = p_mater_rec.unit, --��λ
           t.num                 = p_mater_rec.num, --����
           t.stock_type          = p_mater_rec.stock_type, --�ֿ����ͣ�1Ʒ�Ʋ֣�2��Ӧ�̲�
           t.relate_num          = p_mater_rec.relate_num, --��������
           t.relate_num_type     = p_mater_rec.relate_num_type, --�����������ͣ�1ɫ��������/2ɫ���̵㵥/3ɫ�����ϵ�/4���ϲɹ���/5�������ⵥ
           t.relate_skc          = p_mater_rec.relate_skc, --����SKC
           t.relate_purchase     = p_mater_rec.relate_purchase, --�����ɹ�����
           t.company_id          = p_mater_rec.company_id, --��ҵ����
           t.create_id           = p_mater_rec.create_id, --������
           t.create_time         = p_mater_rec.create_time, --����ʱ��
           t.update_id           = p_mater_rec.update_id, --������
           t.update_time         = p_mater_rec.update_time, --����ʱ��
           t.whether_del         = p_mater_rec.whether_del, --�Ƿ�ɾ����0��1��
           t.whether_inner_mater = p_mater_rec.whether_inner_mater --�Ƿ��ڲ����ϣ�0��1��
     WHERE t.bound_num = p_mater_rec.bound_num;
  END p_update_material_color_in_out_bound;

  --ɾ�� MATERIAL_COLOR_IN_OUT_BOUND
  PROCEDURE p_delete_material_color_in_out_bound(p_mater_rec material_color_in_out_bound%ROWTYPE) IS
  BEGIN
  
    DELETE FROM material_color_in_out_bound t
     WHERE t.bound_num = p_mater_rec.bound_num;
  END p_delete_material_color_in_out_bound;

END pkg_material_color_in_out_bound;
/
