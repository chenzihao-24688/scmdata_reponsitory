CREATE OR REPLACE PACKAGE mrp.pkg_color_prepare_batch_finish_order IS
  --��ѯ COLOR_PREPARE_BATCH_FINISH_ORDER
  FUNCTION f_query_color_prepare_batch_finish_order RETURN CLOB;

  --���� COLOR_PREPARE_BATCH_FINISH_ORDER
  PROCEDURE p_insert_color_prepare_batch_finish_order(p_color_rec color_prepare_batch_finish_order%ROWTYPE);

  --�޸� COLOR_PREPARE_BATCH_FINISH_ORDER
  PROCEDURE p_update_color_prepare_batch_finish_order(p_color_rec color_prepare_batch_finish_order%ROWTYPE);

  --ɾ�� COLOR_PREPARE_BATCH_FINISH_ORDER
  PROCEDURE p_delete_color_prepare_batch_finish_order(p_color_rec color_prepare_batch_finish_order%ROWTYPE);

END pkg_color_prepare_batch_finish_order;
/
CREATE OR REPLACE PACKAGE BODY mrp.pkg_color_prepare_batch_finish_order IS
  --��ѯ COLOR_PREPARE_BATCH_FINISH_ORDER
  FUNCTION f_query_color_prepare_batch_finish_order RETURN CLOB IS
    v_sql CLOB;
  
  BEGIN
    v_sql := '
SELECT t.prepare_batch_finish_id, --ɫ��������ɵ���
       t.product_order_id, --ɫ����������
       t.batch_finish_time, --�������ʱ��
       t.unit, --��λ
       t.batch_finish_num, --�����������
       t.batch_finish_percent, --������ɰٷֱ�
       t.batch_finish_id, --���������
       t.create_id, --������
       t.create_time, --����ʱ��
       t.update_id, --������
       t.update_time, --����ʱ��
       t.whether_del --�Ƿ�ɾ����0��1��
  FROM color_prepare_batch_finish_order t
 WHERE 1 = 1
';
    RETURN v_sql;
  END f_query_color_prepare_batch_finish_order;

  --���� COLOR_PREPARE_BATCH_FINISH_ORDER
  PROCEDURE p_insert_color_prepare_batch_finish_order(p_color_rec color_prepare_batch_finish_order%ROWTYPE) IS
  BEGIN
  
    INSERT INTO color_prepare_batch_finish_order
      (prepare_batch_finish_id, product_order_id, batch_finish_time, unit,
       batch_finish_num, batch_finish_percent, batch_finish_id, create_id,
       create_time, update_id, update_time, whether_del)
    VALUES
      (p_color_rec.prepare_batch_finish_id, p_color_rec.product_order_id,
       p_color_rec.batch_finish_time, p_color_rec.unit,
       p_color_rec.batch_finish_num, p_color_rec.batch_finish_percent,
       p_color_rec.batch_finish_id, p_color_rec.create_id,
       p_color_rec.create_time, p_color_rec.update_id,
       p_color_rec.update_time, p_color_rec.whether_del);
  END p_insert_color_prepare_batch_finish_order;

  --�޸� COLOR_PREPARE_BATCH_FINISH_ORDER
  PROCEDURE p_update_color_prepare_batch_finish_order(p_color_rec color_prepare_batch_finish_order%ROWTYPE) IS
  BEGIN
  
    UPDATE color_prepare_batch_finish_order t
       SET t.product_order_id     = p_color_rec.product_order_id, --ɫ����������
           t.batch_finish_time    = p_color_rec.batch_finish_time, --�������ʱ��
           t.unit                 = p_color_rec.unit, --��λ
           t.batch_finish_num     = p_color_rec.batch_finish_num, --�����������
           t.batch_finish_percent = p_color_rec.batch_finish_percent, --������ɰٷֱ�
           t.batch_finish_id      = p_color_rec.batch_finish_id, --���������
           t.create_id            = p_color_rec.create_id, --������
           t.create_time          = p_color_rec.create_time, --����ʱ��
           t.update_id            = p_color_rec.update_id, --������
           t.update_time          = p_color_rec.update_time, --����ʱ��
           t.whether_del          = p_color_rec.whether_del --�Ƿ�ɾ����0��1��
     WHERE t.prepare_batch_finish_id = p_color_rec.prepare_batch_finish_id;
  END p_update_color_prepare_batch_finish_order;

  --ɾ�� COLOR_PREPARE_BATCH_FINISH_ORDER
  PROCEDURE p_delete_color_prepare_batch_finish_order(p_color_rec color_prepare_batch_finish_order%ROWTYPE) IS
  BEGIN 
    DELETE FROM color_prepare_batch_finish_order t WHERE 1 = 0;
  END p_delete_color_prepare_batch_finish_order;

END pkg_color_prepare_batch_finish_order;
/
