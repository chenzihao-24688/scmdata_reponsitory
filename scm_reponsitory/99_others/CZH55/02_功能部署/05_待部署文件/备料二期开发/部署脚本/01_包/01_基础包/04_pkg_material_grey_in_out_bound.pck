CREATE OR REPLACE PACKAGE mrp.pkg_material_grey_in_out_bound IS
  -- Author  : CZH55
  -- Created : 2023/4/25 17:39:55
  -- Purpose : ���Ϲ�Ӧ����������ⵥ-���������

  --��ѯ MATERIAL_GREY_IN_OUT_BOUND
  FUNCTION f_query_material_grey_in_out_bound RETURN CLOB;

  --��ѯ ͨ��ID MATERIAL_GREY_IN_OUT_BOUND
  FUNCTION f_query_material_grey_in_out_bound_by_id(p_bound_num VARCHAR2)
    RETURN CLOB;

  --���� MATERIAL_GREY_IN_OUT_BOUND
  PROCEDURE p_insert_material_grey_in_out_bound(p_mater_rec material_grey_in_out_bound%ROWTYPE);

  --�޸� MATERIAL_GREY_IN_OUT_BOUND
  PROCEDURE p_update_material_grey_in_out_bound(p_mater_rec material_grey_in_out_bound%ROWTYPE);

  --ɾ�� MATERIAL_GREY_IN_OUT_BOUND
  PROCEDURE p_delete_material_grey_in_out_bound(p_mater_rec material_grey_in_out_bound%ROWTYPE);

  --ɾ�� ͨ��ID MATERIAL_GREY_IN_OUT_BOUND
  PROCEDURE p_delete_material_grey_in_out_bound_by_id(p_bound_num VARCHAR2);

  --У�� BOUND_NUM MATERIAL_GREY_IN_OUT_BOUND
  PROCEDURE p_check_bound_num(p_bound_num VARCHAR2);

  --У�� MATERIAL_SPU MATERIAL_GREY_IN_OUT_BOUND
  PROCEDURE p_check_material_spu(p_material_spu VARCHAR2);

  --У�� CREATE_ID MATERIAL_GREY_IN_OUT_BOUND
  PROCEDURE p_check_create_id(p_create_id VARCHAR2);

  --У�� CREATE_TIME MATERIAL_GREY_IN_OUT_BOUND
  PROCEDURE p_check_create_time(p_create_time DATE);
  --���� MATERIAL_GREY_IN_OUT_BOUND
  PROCEDURE p_invoke_material_grey_in_out_bound(p_mater_rec material_grey_in_out_bound%ROWTYPE);

END pkg_material_grey_in_out_bound;
/
CREATE OR REPLACE PACKAGE BODY mrp.pkg_material_grey_in_out_bound IS
  --��ѯ MATERIAL_GREY_IN_OUT_BOUND
  FUNCTION f_query_material_grey_in_out_bound RETURN CLOB IS
    v_sql CLOB;
  
  BEGIN
    v_sql := '
SELECT t.bound_num, --��������ⵥ��
       t.ascription, --����������0����1���
       t.bound_type, --��������ͣ�1ɫ�����ϳ���/ 2�̿�����/ 3��ʱ��תɫ����/ 4�������ϳ���/ 11Ʒ�Ʊ������/ 12��Ӧ���ֻ����/ 13��ӯ���/ 14��ʱ�������
       t.mater_supplier_code, --���Ϲ�Ӧ�̱��
       t.material_spu, --����SPU
       t.unit, --��λ
       t.num, --����
       t.stock_type, --�ֿ����ͣ�1Ʒ�Ʋ֣�2��Ӧ�̲�
       t.relate_num, --��������
       t.relate_num_type, --�����������ͣ�1ɫ��������/ 2�����̵㵥/ 3ɫ�����ϵ�/ 4����������/5���ϲɹ���/6ɫ����ⵥ
       t.relate_skc, --����SKC
       t.company_id, --��ҵ����
       t.create_id, --������
       t.create_time, --����ʱ�䣬���ʱ��
       t.update_id, --������
       t.update_time, --����ʱ��
       t.whether_del, --�Ƿ�ɾ����0��1��
       t.relate_purchase_order_num --�����ɹ�����
  FROM material_grey_in_out_bound t
 WHERE 1 = 1
';
    RETURN v_sql;
  END f_query_material_grey_in_out_bound;
  --��ѯ ͨ��ID MATERIAL_GREY_IN_OUT_BOUND
  FUNCTION f_query_material_grey_in_out_bound_by_id(p_bound_num VARCHAR2)
    RETURN CLOB IS
    v_sql CLOB;
  
    v_bound_num VARCHAR2(32) := p_bound_num;
  BEGIN
    v_sql := '
SELECT t.bound_num, --��������ⵥ��
       t.ascription, --����������0����1���
       t.bound_type, --��������ͣ�1ɫ�����ϳ���/ 2�̿�����/ 3��ʱ��תɫ����/ 4�������ϳ���/ 11Ʒ�Ʊ������/ 12��Ӧ���ֻ����/ 13��ӯ���/ 14��ʱ�������
       t.mater_supplier_code, --���Ϲ�Ӧ�̱��
       t.material_spu, --����SPU
       t.unit, --��λ
       t.num, --����
       t.stock_type, --�ֿ����ͣ�1Ʒ�Ʋ֣�2��Ӧ�̲�
       t.relate_num, --��������
       t.relate_num_type, --�����������ͣ�1ɫ��������/ 2�����̵㵥/ 3ɫ�����ϵ�/ 4����������/5���ϲɹ���/6ɫ����ⵥ
       t.relate_skc, --����SKC
       t.company_id, --��ҵ����
       t.create_id, --������
       t.create_time, --����ʱ�䣬���ʱ��
       t.update_id, --������
       t.update_time, --����ʱ��
       t.whether_del, --�Ƿ�ɾ����0��1��
       t.relate_purchase_order_num --�����ɹ�����
  FROM material_grey_in_out_bound t
 WHERE t.bound_num = ''' || v_bound_num || '''
';
    RETURN v_sql;
  END f_query_material_grey_in_out_bound_by_id;
  --���� MATERIAL_GREY_IN_OUT_BOUND
  PROCEDURE p_insert_material_grey_in_out_bound(p_mater_rec material_grey_in_out_bound%ROWTYPE) IS
  BEGIN
  
    INSERT INTO material_grey_in_out_bound
      (bound_num, ascription, bound_type, mater_supplier_code, material_spu,
       unit, num, stock_type, relate_num, relate_num_type, relate_skc,
       company_id, create_id, create_time, update_id, update_time,
       whether_del, relate_purchase_order_num)
    VALUES
      (p_mater_rec.bound_num, p_mater_rec.ascription,
       p_mater_rec.bound_type, p_mater_rec.mater_supplier_code,
       p_mater_rec.material_spu, p_mater_rec.unit, p_mater_rec.num,
       p_mater_rec.stock_type, p_mater_rec.relate_num,
       p_mater_rec.relate_num_type, p_mater_rec.relate_skc,
       p_mater_rec.company_id, p_mater_rec.create_id,
       p_mater_rec.create_time, p_mater_rec.update_id,
       p_mater_rec.update_time, p_mater_rec.whether_del,
       p_mater_rec.relate_purchase_order_num);
  END p_insert_material_grey_in_out_bound;

  --�޸� MATERIAL_GREY_IN_OUT_BOUND
  PROCEDURE p_update_material_grey_in_out_bound(p_mater_rec material_grey_in_out_bound%ROWTYPE) IS
  BEGIN
  
    UPDATE material_grey_in_out_bound t
       SET t.ascription                = p_mater_rec.ascription, --����������0����1���
           t.bound_type                = p_mater_rec.bound_type, --��������ͣ�1ɫ�����ϳ���/ 2�̿�����/ 3��ʱ��תɫ����/ 4�������ϳ���/ 11Ʒ�Ʊ������/ 12��Ӧ���ֻ����/ 13��ӯ���/ 14��ʱ�������
           t.mater_supplier_code       = p_mater_rec.mater_supplier_code, --���Ϲ�Ӧ�̱��
           t.material_spu              = p_mater_rec.material_spu, --����SPU
           t.unit                      = p_mater_rec.unit, --��λ
           t.num                       = p_mater_rec.num, --����
           t.stock_type                = p_mater_rec.stock_type, --�ֿ����ͣ�1Ʒ�Ʋ֣�2��Ӧ�̲�
           t.relate_num                = p_mater_rec.relate_num, --��������
           t.relate_num_type           = p_mater_rec.relate_num_type, --�����������ͣ�1ɫ��������/ 2�����̵㵥/ 3ɫ�����ϵ�/ 4����������/5���ϲɹ���/6ɫ����ⵥ
           t.relate_skc                = p_mater_rec.relate_skc, --����SKC
           t.company_id                = p_mater_rec.company_id, --��ҵ����
           t.create_id                 = p_mater_rec.create_id, --������
           t.create_time               = p_mater_rec.create_time, --����ʱ�䣬���ʱ��
           t.update_id                 = p_mater_rec.update_id, --������
           t.update_time               = p_mater_rec.update_time, --����ʱ��
           t.whether_del               = p_mater_rec.whether_del, --�Ƿ�ɾ����0��1��
           t.relate_purchase_order_num = p_mater_rec.relate_purchase_order_num --�����ɹ�����
     WHERE t.bound_num = p_mater_rec.bound_num;
  END p_update_material_grey_in_out_bound;

  --ɾ�� MATERIAL_GREY_IN_OUT_BOUND
  PROCEDURE p_delete_material_grey_in_out_bound(p_mater_rec material_grey_in_out_bound%ROWTYPE) IS 
  BEGIN
  
    DELETE FROM material_grey_in_out_bound t WHERE 1 = 0;
  END p_delete_material_grey_in_out_bound;

  --ɾ�� ͨ��ID MATERIAL_GREY_IN_OUT_BOUND
  PROCEDURE p_delete_material_grey_in_out_bound_by_id(p_bound_num VARCHAR2) IS
  
    v_bound_num VARCHAR2(32) := p_bound_num;
  BEGIN
  
    DELETE FROM material_grey_in_out_bound t
     WHERE t.bound_num = v_bound_num;
  END p_delete_material_grey_in_out_bound_by_id;

  --У�� BOUND_NUM MATERIAL_GREY_IN_OUT_BOUND
  PROCEDURE p_check_bound_num(p_bound_num VARCHAR2) IS
  
  BEGIN
  
    IF p_bound_num IS NULL THEN
      raise_application_error(-20002, '����������ⵥ�š�������飡');
    END IF;
  END p_check_bound_num;

  --У�� MATERIAL_SPU MATERIAL_GREY_IN_OUT_BOUND
  PROCEDURE p_check_material_spu(p_material_spu VARCHAR2) IS
  
  BEGIN
  
    IF p_material_spu IS NULL THEN
      raise_application_error(-20002, '������SPU��������飡');
    END IF;
  END p_check_material_spu;

  --У�� CREATE_ID MATERIAL_GREY_IN_OUT_BOUND
  PROCEDURE p_check_create_id(p_create_id VARCHAR2) IS
  
  BEGIN
  
    IF p_create_id IS NULL THEN
      raise_application_error(-20002, '�������ߡ�������飡');
    END IF;
  END p_check_create_id;

  --У�� CREATE_TIME MATERIAL_GREY_IN_OUT_BOUND
  PROCEDURE p_check_create_time(p_create_time DATE) IS
  
  BEGIN
  
    IF p_create_time IS NULL THEN
      raise_application_error(-20002,
                              '������ʱ�䣬���ʱ�䡿������飡');
    END IF;
  END p_check_create_time;
  --���� MATERIAL_GREY_IN_OUT_BOUND
  PROCEDURE p_invoke_material_grey_in_out_bound(p_mater_rec material_grey_in_out_bound%ROWTYPE) IS
  BEGIN
  
    mrp.pkg_material_grey_in_out_bound.p_check_bound_num(p_bound_num => p_mater_rec.bound_num);
    mrp.pkg_material_grey_in_out_bound.p_check_material_spu(p_material_spu => p_mater_rec.material_spu);
    mrp.pkg_material_grey_in_out_bound.p_check_create_id(p_create_id => p_mater_rec.create_id);
    mrp.pkg_material_grey_in_out_bound.p_check_create_time(p_create_time => p_mater_rec.create_time);
  END p_invoke_material_grey_in_out_bound;

END pkg_material_grey_in_out_bound;
/
