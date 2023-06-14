CREATE OR REPLACE PACKAGE mrp.pkg_color_prepare_product_order IS
  -- Author  : CZH55
  -- Created : 2023/4/25 17:39:55
  -- Purpose : ��Ʒ�����Ϲ�Ӧ��ɫ��/��������������-���������

  --��ѯ COLOR_PREPARE_PRODUCT_ORDER
  FUNCTION f_query_color_prepare_product_order RETURN CLOB;

  --���� COLOR_PREPARE_PRODUCT_ORDER
  PROCEDURE p_insert_color_prepare_product_order(p_color_rec color_prepare_product_order%ROWTYPE);

  --�޸� COLOR_PREPARE_PRODUCT_ORDER
  PROCEDURE p_update_color_prepare_product_order(p_color_rec color_prepare_product_order%ROWTYPE);

  --ɾ�� ͨ��ID COLOR_PREPARE_PRODUCT_ORDER
  PROCEDURE p_delete_color_prepare_product_order_by_id(p_product_order_id VARCHAR2);

  --У�� product_status  COLOR_PREPARE_PRODUCT_ORDER
  PROCEDURE p_check_product_status(p_product_order_id VARCHAR2,
                                   p_product_status   INT);

  --У�� cur_finished_num  COLOR_PREPARE_PRODUCT_ORDER
  PROCEDURE p_check_cur_finished_num(p_cur_finished_num VARCHAR2);

  --У�� is_finished_preorder  COLOR_PREPARE_PRODUCT_ORDER
  PROCEDURE p_check_is_finished_preorder(p_is_finished_preorder NUMBER);

  --���װ����3% У��
  PROCEDURE p_check_more_less_clause(p_cur_finished_num     NUMBER,
                                     p_finished_num         NUMBER,
                                     p_order_num            NUMBER,
                                     p_rate                 NUMBER,
                                     p_is_finished_preorder NUMBER);

END pkg_color_prepare_product_order;
/
CREATE OR REPLACE PACKAGE BODY mrp.pkg_color_prepare_product_order IS
  --��ѯ COLOR_PREPARE_PRODUCT_ORDER
  FUNCTION f_query_color_prepare_product_order RETURN CLOB IS
    v_sql CLOB;
  BEGIN
    v_sql := '
SELECT t.product_order_id, --ɫ����������
       t.product_status, --������״̬��1�����У�2����ɣ�3��ȡ��
       t.prepare_object, --���϶���
       t.material_sku, --����SKU
       t.pro_supplier_code, --��Ʒ��Ӧ�̱��
       t.mater_supplier_code, --���Ϲ�Ӧ�̱��
       t.whether_inner_mater, --�Ƿ��ڲ����ϣ�0��1��
       t.material_name, --��������
       t.material_color, --������ɫ
       t.unit, --��λ
       t.supplier_material_name, --��Ӧ����������
       t.supplier_color, --��Ӧ����ɫ
       t.supplier_shades, --��Ӧ��ɫ��
       t.practical_door_with, --ʵ���ŷ�
       t.gram_weight, --����
       t.material_specifications, --���Ϲ��
       t.features, --����ͼ��ͼƬID����һ��
       t.ingredients, --���ϳɷݣ��ɷ�ID��ҳ������ʾ
       t.plan_product_quantity, --�ƻ���������
       t.contain_color_prepare_num, --��ɫ�����ϵ���
       t.actual_finish_num, --ʵ���������
       t.receive_id, --�ӵ���
       t.receive_time, --�ӵ�����
       t.finish_id, --�������
       t.finish_num, --���������
       t.finish_time, --���������
       t.batch_finish_num, --��������ۼ�����
       t.batch_finish_percent, --��������ۼưٷֱ�
       t.complete_num, --���������
       t.relate_skc, --����SKC
       t.cancel_id, --ȡ����
       t.cancel_time, --ȡ������
       t.cancel_reason, --ȡ��ԭ��
       t.company_id, --��ҵ����
       t.create_id, --������
       t.create_time, --����ʱ��
       t.update_id, --������
       t.update_time, --����ʱ��
       t.whether_del --�Ƿ�ɾ����0��1��
  FROM color_prepare_product_order t
 WHERE 1 = 1';
    RETURN v_sql;
  END f_query_color_prepare_product_order;

  --���� COLOR_PREPARE_PRODUCT_ORDER
  PROCEDURE p_insert_color_prepare_product_order(p_color_rec color_prepare_product_order%ROWTYPE) IS
  BEGIN
  
    INSERT INTO color_prepare_product_order
      (product_order_id, product_status, prepare_object, material_sku,
       pro_supplier_code, mater_supplier_code, whether_inner_mater,
       material_name, material_color, unit, supplier_material_name,
       supplier_color, supplier_shades, practical_door_with, gram_weight,
       material_specifications, features, ingredients, plan_product_quantity,
       contain_color_prepare_num, actual_finish_num, receive_id,
       receive_time, finish_id, finish_num, finish_time, batch_finish_num,
       batch_finish_percent, complete_num, relate_skc, cancel_id,
       cancel_time, cancel_reason, company_id, create_id, create_time,
       update_id, update_time, whether_del)
    VALUES
      (p_color_rec.product_order_id, p_color_rec.product_status,
       p_color_rec.prepare_object, p_color_rec.material_sku,
       p_color_rec.pro_supplier_code, p_color_rec.mater_supplier_code,
       p_color_rec.whether_inner_mater, p_color_rec.material_name,
       p_color_rec.material_color, p_color_rec.unit,
       p_color_rec.supplier_material_name, p_color_rec.supplier_color,
       p_color_rec.supplier_shades, p_color_rec.practical_door_with,
       p_color_rec.gram_weight, p_color_rec.material_specifications,
       p_color_rec.features, p_color_rec.ingredients,
       p_color_rec.plan_product_quantity,
       p_color_rec.contain_color_prepare_num, p_color_rec.actual_finish_num,
       p_color_rec.receive_id, p_color_rec.receive_time,
       p_color_rec.finish_id, p_color_rec.finish_num,
       p_color_rec.finish_time, p_color_rec.batch_finish_num,
       p_color_rec.batch_finish_percent, p_color_rec.complete_num,
       p_color_rec.relate_skc, p_color_rec.cancel_id,
       p_color_rec.cancel_time, p_color_rec.cancel_reason,
       p_color_rec.company_id, p_color_rec.create_id,
       p_color_rec.create_time, p_color_rec.update_id,
       p_color_rec.update_time, p_color_rec.whether_del);
  END p_insert_color_prepare_product_order;

  --�޸� COLOR_PREPARE_PRODUCT_ORDER
  PROCEDURE p_update_color_prepare_product_order(p_color_rec color_prepare_product_order%ROWTYPE) IS
  BEGIN
  
    UPDATE color_prepare_product_order t
       SET t.product_status            = p_color_rec.product_status, --������״̬��1�����У�2����ɣ�3��ȡ��
           t.prepare_object            = p_color_rec.prepare_object, --���϶���
           t.material_sku              = p_color_rec.material_sku, --����SKU
           t.pro_supplier_code         = p_color_rec.pro_supplier_code, --��Ʒ��Ӧ�̱��
           t.mater_supplier_code       = p_color_rec.mater_supplier_code, --���Ϲ�Ӧ�̱��
           t.whether_inner_mater       = p_color_rec.whether_inner_mater, --�Ƿ��ڲ����ϣ�0��1��
           t.material_name             = p_color_rec.material_name, --��������
           t.material_color            = p_color_rec.material_color, --������ɫ
           t.unit                      = p_color_rec.unit, --��λ
           t.supplier_material_name    = p_color_rec.supplier_material_name, --��Ӧ����������
           t.supplier_color            = p_color_rec.supplier_color, --��Ӧ����ɫ
           t.supplier_shades           = p_color_rec.supplier_shades, --��Ӧ��ɫ��
           t.practical_door_with       = p_color_rec.practical_door_with, --ʵ���ŷ�
           t.gram_weight               = p_color_rec.gram_weight, --����
           t.material_specifications   = p_color_rec.material_specifications, --���Ϲ��
           t.features                  = p_color_rec.features, --����ͼ��ͼƬID����һ��
           t.ingredients               = p_color_rec.ingredients, --���ϳɷݣ��ɷ�ID��ҳ������ʾ
           t.plan_product_quantity     = p_color_rec.plan_product_quantity, --�ƻ���������
           t.contain_color_prepare_num = p_color_rec.contain_color_prepare_num, --��ɫ�����ϵ���
           t.actual_finish_num         = p_color_rec.actual_finish_num, --ʵ���������
           t.receive_id                = p_color_rec.receive_id, --�ӵ���
           t.receive_time              = p_color_rec.receive_time, --�ӵ�����
           t.finish_id                 = p_color_rec.finish_id, --�������
           t.finish_num                = p_color_rec.finish_num, --���������
           t.finish_time               = p_color_rec.finish_time, --���������
           t.batch_finish_num          = p_color_rec.batch_finish_num, --��������ۼ�����
           t.batch_finish_percent      = p_color_rec.batch_finish_percent, --��������ۼưٷֱ�
           t.complete_num              = p_color_rec.complete_num, --���������
           t.relate_skc                = p_color_rec.relate_skc, --����SKC
           t.cancel_id                 = p_color_rec.cancel_id, --ȡ����
           t.cancel_time               = p_color_rec.cancel_time, --ȡ������
           t.cancel_reason             = p_color_rec.cancel_reason, --ȡ��ԭ��
           t.company_id                = p_color_rec.company_id, --��ҵ����
           t.create_id                 = p_color_rec.create_id, --������
           t.create_time               = p_color_rec.create_time, --����ʱ��
           t.update_id                 = p_color_rec.update_id, --������
           t.update_time               = p_color_rec.update_time, --����ʱ��
           t.whether_del               = p_color_rec.whether_del --�Ƿ�ɾ����0��1��
     WHERE t.product_order_id = p_color_rec.product_order_id;
  END p_update_color_prepare_product_order;

  --ɾ�� ͨ��ID COLOR_PREPARE_PRODUCT_ORDER
  PROCEDURE p_delete_color_prepare_product_order_by_id(p_product_order_id VARCHAR2) IS
    v_product_order_id VARCHAR2(32) := p_product_order_id;
  BEGIN
    DELETE FROM color_prepare_product_order t
     WHERE t.product_order_id = v_product_order_id;
  END p_delete_color_prepare_product_order_by_id;

  --У�� product_status  COLOR_PREPARE_PRODUCT_ORDER
  PROCEDURE p_check_product_status(p_product_order_id VARCHAR2,
                                   p_product_status   INT) IS
    v_product_status INT;
  BEGIN
    SELECT nvl(MAX(t.product_status), -1)
      INTO v_product_status
      FROM mrp.color_prepare_product_order t
     WHERE t.product_order_id = p_product_order_id;
  
    IF v_product_status <> p_product_status THEN
      raise_application_error(-20002,
                              'ֻ�ɶԡ�' ||
                              (CASE WHEN p_product_status = 1 THEN '������' ELSE NULL END) ||
                              '��״̬�Ķ������в��������飡');
    END IF;
  END p_check_product_status;

  --У�� cur_finished_num  COLOR_PREPARE_PRODUCT_ORDER
  PROCEDURE p_check_cur_finished_num(p_cur_finished_num VARCHAR2) IS
  BEGIN
    --У���Ƿ�Ϊ��
    mrp.pkg_check_data_comm.p_check_str_is_null(p_str      => p_cur_finished_num,
                                                p_str_desc => '�����������');
    --������ʽУ��
    mrp.pkg_check_data_comm.p_check_number(p_num         => p_cur_finished_num,
                                           p_integer_num => 9,
                                           p_decimal_num => 2,
                                           p_desc        => '�����������');
  
  END p_check_cur_finished_num;

  --У�� is_finished_preorder  COLOR_PREPARE_PRODUCT_ORDER
  PROCEDURE p_check_is_finished_preorder(p_is_finished_preorder NUMBER) IS
  BEGIN
    --У���Ƿ�Ϊ��
    mrp.pkg_check_data_comm.p_check_str_is_null(p_str      => p_is_finished_preorder,
                                                p_str_desc => '�Ƿ���ɱ��ϵ�');
  END p_check_is_finished_preorder;

  --���װ����3% У��
  PROCEDURE p_check_more_less_clause(p_cur_finished_num     NUMBER,
                                     p_finished_num         NUMBER,
                                     p_order_num            NUMBER,
                                     p_rate                 NUMBER,
                                     p_is_finished_preorder NUMBER) IS
  
  BEGIN
    --�������������+ ��������������� ����������*��1-3%�������Ƿ���ɱ��ϵ���ѡ�С��񡱣����������������+ ��������������� ����������*��1-3%��ʱ�����Ƿ���ɱ��ϵ�������Ϊ����
    IF (p_cur_finished_num + p_finished_num) - p_order_num * (1 - p_rate) >= 0 AND
       p_is_finished_preorder = 0 THEN
      raise_application_error(-20002, 
                              '�����������+ ��������������� ����������*��1-3%��ʱ�����Ƿ���ɱ��ϵ�������Ϊ����');
    END IF;
  
    --�����������+ ��������������� ����������*��1+3%������������������������ɳ��������װ��Ҫ��
    IF (p_cur_finished_num + p_finished_num) - p_order_num * (1 + p_rate) > 0 THEN
      raise_application_error(-20002, '����������������ɳ��������װ��Ҫ��');
    END IF;
  END p_check_more_less_clause;

END pkg_color_prepare_product_order;
/
