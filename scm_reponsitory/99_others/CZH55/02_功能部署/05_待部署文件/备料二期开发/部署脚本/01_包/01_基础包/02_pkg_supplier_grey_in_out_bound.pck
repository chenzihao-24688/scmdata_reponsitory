CREATE OR REPLACE PACKAGE mrp.pkg_supplier_grey_in_out_bound IS
  -- Author  : CZH55
  -- Created : 2023/4/25 17:39:55
  -- Purpose : ��Ʒ��Ӧ����������ⵥ-���������
  
  --��ѯ SUPPLIER_GREY_IN_OUT_BOUND
  FUNCTION f_query_supplier_grey_in_out_bound RETURN CLOB;

  --��ѯ ͨ��ID SUPPLIER_GREY_IN_OUT_BOUND
  FUNCTION f_query_supplier_grey_in_out_bound_by_id(p_bound_num VARCHAR2)
    RETURN CLOB;

  --���� SUPPLIER_GREY_IN_OUT_BOUND
  PROCEDURE p_insert_supplier_grey_in_out_bound(p_suppl_rec supplier_grey_in_out_bound%ROWTYPE);

  --�޸� SUPPLIER_GREY_IN_OUT_BOUND
  PROCEDURE p_update_supplier_grey_in_out_bound(p_suppl_rec supplier_grey_in_out_bound%ROWTYPE);

  --ɾ�� SUPPLIER_GREY_IN_OUT_BOUND
  PROCEDURE p_delete_supplier_grey_in_out_bound(p_suppl_rec supplier_grey_in_out_bound%ROWTYPE);

  --ɾ�� ͨ��ID SUPPLIER_GREY_IN_OUT_BOUND
  PROCEDURE p_delete_supplier_grey_in_out_bound_by_id(p_bound_num VARCHAR2);

  --У�� BOUND_NUM SUPPLIER_GREY_IN_OUT_BOUND
  PROCEDURE p_check_bound_num(p_bound_num VARCHAR2);

  --У�� PRO_SUPPLIER_CODE SUPPLIER_GREY_IN_OUT_BOUND
  PROCEDURE p_check_pro_supplier_code(p_pro_supplier_code VARCHAR2);

  --У�� MATER_SUPPLIER_CODE SUPPLIER_GREY_IN_OUT_BOUND
  PROCEDURE p_check_mater_supplier_code(p_mater_supplier_code VARCHAR2);

  --У�� MATERIAL_SPU SUPPLIER_GREY_IN_OUT_BOUND
  PROCEDURE p_check_material_spu(p_material_spu VARCHAR2);

  --У�� UNIT SUPPLIER_GREY_IN_OUT_BOUND
  PROCEDURE p_check_unit(p_unit VARCHAR2);

  --У�� COMPANY_ID SUPPLIER_GREY_IN_OUT_BOUND
  PROCEDURE p_check_company_id(p_company_id VARCHAR2);

  --У�� CREATE_ID SUPPLIER_GREY_IN_OUT_BOUND
  PROCEDURE p_check_create_id(p_create_id VARCHAR2);

  --У�� CREATE_TIME SUPPLIER_GREY_IN_OUT_BOUND
  PROCEDURE p_check_create_time(p_create_time DATE);
  --���� SUPPLIER_GREY_IN_OUT_BOUND
  PROCEDURE p_invoke_supplier_grey_in_out_bound(p_suppl_rec supplier_grey_in_out_bound%ROWTYPE);

END pkg_supplier_grey_in_out_bound;
/
CREATE OR REPLACE PACKAGE BODY mrp.pkg_supplier_grey_in_out_bound IS
  --��ѯ SUPPLIER_GREY_IN_OUT_BOUND
  FUNCTION f_query_supplier_grey_in_out_bound RETURN CLOB IS
    v_sql CLOB;
  
  BEGIN
    v_sql := '

SELECT T.BOUND_NUM, --��������ⵥ��
T.ASCRIPTION, --����������0����1���
T.BOUND_TYPE, --������������ͣ�1ɫ�����ϳ���/ 2�̿�����/ 3��ʱ��תɫ����/ 11Ʒ�Ʊ������/ 12��Ӧ���ֻ����/ 13��ӯ���/ 14��ʱ�������/15 ��Ӧ��ɫ�����
T.PRO_SUPPLIER_CODE, --��Ʒ��Ӧ�̱��
T.MATER_SUPPLIER_CODE, --���Ϲ�Ӧ�̱��
T.MATERIAL_SPU, --����SPU
T.WHETHER_INNER_MATER, --�Ƿ��ڲ����ϣ�0��1��
T.UNIT, --��λ
T.NUM, --����
T.STOCK_TYPE, --�ֿ����ͣ�1Ʒ�Ʋ֣�2��Ӧ�̲�
T.RELATE_NUM, --��������
T.RELATE_NUM_TYPE, --�����������ͣ�1ɫ��������/ 2�����̵㵥/ 3ɫ�����ϵ�/ 4����������/5���ϲɹ���/6ɫ����ⵥ
T.RELATE_SKC, --����SKC
T.COMPANY_ID, --��ҵ����
T.CREATE_ID, --������
T.CREATE_TIME, --����ʱ��
T.UPDATE_ID, --������
T.UPDATE_TIME, --����ʱ��
T.WHETHER_DEL, --�Ƿ�ɾ����0��1��
T.RELATE_PURCHASE_ORDER_NUM --�����ɹ�����
 FROM SUPPLIER_GREY_IN_OUT_BOUND T  WHERE 1 = 1
';
    RETURN v_sql;
  END f_query_supplier_grey_in_out_bound;
  --��ѯ ͨ��ID SUPPLIER_GREY_IN_OUT_BOUND
  FUNCTION f_query_supplier_grey_in_out_bound_by_id(p_bound_num VARCHAR2)
    RETURN CLOB IS
    v_sql CLOB;
  
    v_bound_num VARCHAR2(32) := p_bound_num;
  BEGIN
    v_sql := '

SELECT T.BOUND_NUM, --��������ⵥ��
T.ASCRIPTION, --����������0����1���
T.BOUND_TYPE, --������������ͣ�1ɫ�����ϳ���/ 2�̿�����/ 3��ʱ��תɫ����/ 11Ʒ�Ʊ������/ 12��Ӧ���ֻ����/ 13��ӯ���/ 14��ʱ�������/15 ��Ӧ��ɫ�����
T.PRO_SUPPLIER_CODE, --��Ʒ��Ӧ�̱��
T.MATER_SUPPLIER_CODE, --���Ϲ�Ӧ�̱��
T.MATERIAL_SPU, --����SPU
T.WHETHER_INNER_MATER, --�Ƿ��ڲ����ϣ�0��1��
T.UNIT, --��λ
T.NUM, --����
T.STOCK_TYPE, --�ֿ����ͣ�1Ʒ�Ʋ֣�2��Ӧ�̲�
T.RELATE_NUM, --��������
T.RELATE_NUM_TYPE, --�����������ͣ�1ɫ��������/ 2�����̵㵥/ 3ɫ�����ϵ�/ 4����������/5���ϲɹ���/6ɫ����ⵥ
T.RELATE_SKC, --����SKC
T.COMPANY_ID, --��ҵ����
T.CREATE_ID, --������
T.CREATE_TIME, --����ʱ��
T.UPDATE_ID, --������
T.UPDATE_TIME, --����ʱ��
T.WHETHER_DEL, --�Ƿ�ɾ����0��1��
T.RELATE_PURCHASE_ORDER_NUM --�����ɹ�����
 FROM SUPPLIER_GREY_IN_OUT_BOUND T  WHERE T.BOUND_NUM = ''' ||
             v_bound_num || '''
';
    RETURN v_sql;
  END f_query_supplier_grey_in_out_bound_by_id;
  --���� SUPPLIER_GREY_IN_OUT_BOUND
  PROCEDURE p_insert_supplier_grey_in_out_bound(p_suppl_rec supplier_grey_in_out_bound%ROWTYPE) IS
  BEGIN
  
    INSERT INTO supplier_grey_in_out_bound
      (bound_num, ascription, bound_type, pro_supplier_code,
       mater_supplier_code, material_spu, whether_inner_mater, unit, num,
       stock_type, relate_num, relate_num_type, relate_skc, company_id,
       create_id, create_time, update_id, update_time, whether_del,
       relate_purchase_order_num)
    VALUES
      (p_suppl_rec.bound_num, p_suppl_rec.ascription,
       p_suppl_rec.bound_type, p_suppl_rec.pro_supplier_code,
       p_suppl_rec.mater_supplier_code, p_suppl_rec.material_spu,
       p_suppl_rec.whether_inner_mater, p_suppl_rec.unit, p_suppl_rec.num,
       p_suppl_rec.stock_type, p_suppl_rec.relate_num,
       p_suppl_rec.relate_num_type, p_suppl_rec.relate_skc,
       p_suppl_rec.company_id, p_suppl_rec.create_id,
       p_suppl_rec.create_time, p_suppl_rec.update_id,
       p_suppl_rec.update_time, p_suppl_rec.whether_del,
       p_suppl_rec.relate_purchase_order_num);
  END p_insert_supplier_grey_in_out_bound;

  --�޸� SUPPLIER_GREY_IN_OUT_BOUND
  PROCEDURE p_update_supplier_grey_in_out_bound(p_suppl_rec supplier_grey_in_out_bound%ROWTYPE) IS
  BEGIN
  
    UPDATE supplier_grey_in_out_bound t
       SET t.ascription                = p_suppl_rec.ascription, --����������0����1���
           t.bound_type                = p_suppl_rec.bound_type, --������������ͣ�1ɫ�����ϳ���/ 2�̿�����/ 3��ʱ��תɫ����/ 11Ʒ�Ʊ������/ 12��Ӧ���ֻ����/ 13��ӯ���/ 14��ʱ�������/15 ��Ӧ��ɫ�����
           t.pro_supplier_code         = p_suppl_rec.pro_supplier_code, --��Ʒ��Ӧ�̱��
           t.mater_supplier_code       = p_suppl_rec.mater_supplier_code, --���Ϲ�Ӧ�̱��
           t.material_spu              = p_suppl_rec.material_spu, --����SPU
           t.whether_inner_mater       = p_suppl_rec.whether_inner_mater, --�Ƿ��ڲ����ϣ�0��1��
           t.unit                      = p_suppl_rec.unit, --��λ
           t.num                       = p_suppl_rec.num, --����
           t.stock_type                = p_suppl_rec.stock_type, --�ֿ����ͣ�1Ʒ�Ʋ֣�2��Ӧ�̲�
           t.relate_num                = p_suppl_rec.relate_num, --��������
           t.relate_num_type           = p_suppl_rec.relate_num_type, --�����������ͣ�1ɫ��������/ 2�����̵㵥/ 3ɫ�����ϵ�/ 4����������/5���ϲɹ���/6ɫ����ⵥ
           t.relate_skc                = p_suppl_rec.relate_skc, --����SKC
           t.company_id                = p_suppl_rec.company_id, --��ҵ����
           t.create_id                 = p_suppl_rec.create_id, --������
           t.create_time               = p_suppl_rec.create_time, --����ʱ��
           t.update_id                 = p_suppl_rec.update_id, --������
           t.update_time               = p_suppl_rec.update_time, --����ʱ��
           t.whether_del               = p_suppl_rec.whether_del, --�Ƿ�ɾ����0��1��
           t.relate_purchase_order_num = p_suppl_rec.relate_purchase_order_num --�����ɹ�����
     WHERE t.bound_num = p_suppl_rec.bound_num;
  END p_update_supplier_grey_in_out_bound;

  --ɾ�� SUPPLIER_GREY_IN_OUT_BOUND
  PROCEDURE p_delete_supplier_grey_in_out_bound(p_suppl_rec supplier_grey_in_out_bound%ROWTYPE) IS
  BEGIN
  
    DELETE FROM supplier_grey_in_out_bound t WHERE 1 = 0;
  END p_delete_supplier_grey_in_out_bound;

  --ɾ�� ͨ��ID SUPPLIER_GREY_IN_OUT_BOUND
  PROCEDURE p_delete_supplier_grey_in_out_bound_by_id(p_bound_num VARCHAR2) IS
  
    v_bound_num VARCHAR2(32) := p_bound_num;
  BEGIN
  
    DELETE FROM supplier_grey_in_out_bound t
     WHERE t.bound_num = v_bound_num;
  END p_delete_supplier_grey_in_out_bound_by_id;

  --У�� BOUND_NUM SUPPLIER_GREY_IN_OUT_BOUND
  PROCEDURE p_check_bound_num(p_bound_num VARCHAR2) IS
  
  BEGIN
  
    IF p_bound_num IS NULL THEN
      raise_application_error(-20002, '����������ⵥ�š�������飡');
    END IF;
  END p_check_bound_num;

  --У�� PRO_SUPPLIER_CODE SUPPLIER_GREY_IN_OUT_BOUND
  PROCEDURE p_check_pro_supplier_code(p_pro_supplier_code VARCHAR2) IS
  
  BEGIN
  
    IF p_pro_supplier_code IS NULL THEN
      raise_application_error(-20002, '����Ʒ��Ӧ�̱�š�������飡');
    END IF;
  END p_check_pro_supplier_code;

  --У�� MATER_SUPPLIER_CODE SUPPLIER_GREY_IN_OUT_BOUND
  PROCEDURE p_check_mater_supplier_code(p_mater_supplier_code VARCHAR2) IS
  
  BEGIN
  
    IF p_mater_supplier_code IS NULL THEN
      raise_application_error(-20002, '�����Ϲ�Ӧ�̱�š�������飡');
    END IF;
  END p_check_mater_supplier_code;

  --У�� MATERIAL_SPU SUPPLIER_GREY_IN_OUT_BOUND
  PROCEDURE p_check_material_spu(p_material_spu VARCHAR2) IS
  
  BEGIN
  
    IF p_material_spu IS NULL THEN
      raise_application_error(-20002, '������SPU��������飡');
    END IF;
  END p_check_material_spu;

  --У�� UNIT SUPPLIER_GREY_IN_OUT_BOUND
  PROCEDURE p_check_unit(p_unit VARCHAR2) IS
  
  BEGIN
  
    IF p_unit IS NULL THEN
      raise_application_error(-20002, '����λ��������飡');
    END IF;
  END p_check_unit;

  --У�� COMPANY_ID SUPPLIER_GREY_IN_OUT_BOUND
  PROCEDURE p_check_company_id(p_company_id VARCHAR2) IS
  
  BEGIN
  
    IF p_company_id IS NULL THEN
      raise_application_error(-20002, '����ҵ���롿������飡');
    END IF;
  END p_check_company_id;

  --У�� CREATE_ID SUPPLIER_GREY_IN_OUT_BOUND
  PROCEDURE p_check_create_id(p_create_id VARCHAR2) IS
  
  BEGIN
  
    IF p_create_id IS NULL THEN
      raise_application_error(-20002, '�������ߡ�������飡');
    END IF;
  END p_check_create_id;

  --У�� CREATE_TIME SUPPLIER_GREY_IN_OUT_BOUND
  PROCEDURE p_check_create_time(p_create_time DATE) IS
  
  BEGIN
  
    IF p_create_time IS NULL THEN
      raise_application_error(-20002, '������ʱ�䡿������飡');
    END IF;
  END p_check_create_time;
  --���� SUPPLIER_GREY_IN_OUT_BOUND
  PROCEDURE p_invoke_supplier_grey_in_out_bound(p_suppl_rec supplier_grey_in_out_bound%ROWTYPE) IS
  BEGIN
  
    mrp.pkg_supplier_grey_in_out_bound.p_check_bound_num(p_bound_num => p_suppl_rec.bound_num);
    mrp.pkg_supplier_grey_in_out_bound.p_check_pro_supplier_code(p_pro_supplier_code => p_suppl_rec.pro_supplier_code);
    mrp.pkg_supplier_grey_in_out_bound.p_check_mater_supplier_code(p_mater_supplier_code => p_suppl_rec.mater_supplier_code);
    mrp.pkg_supplier_grey_in_out_bound.p_check_material_spu(p_material_spu => p_suppl_rec.material_spu);
    mrp.pkg_supplier_grey_in_out_bound.p_check_unit(p_unit => p_suppl_rec.unit);
    mrp.pkg_supplier_grey_in_out_bound.p_check_company_id(p_company_id => p_suppl_rec.company_id);
    mrp.pkg_supplier_grey_in_out_bound.p_check_create_id(p_create_id => p_suppl_rec.create_id);
    mrp.pkg_supplier_grey_in_out_bound.p_check_create_time(p_create_time => p_suppl_rec.create_time);
  END p_invoke_supplier_grey_in_out_bound;

END pkg_supplier_grey_in_out_bound;
/
