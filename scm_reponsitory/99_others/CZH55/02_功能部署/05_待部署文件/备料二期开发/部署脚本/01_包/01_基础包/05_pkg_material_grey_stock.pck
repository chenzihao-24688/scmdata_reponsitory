CREATE OR REPLACE PACKAGE mrp.pkg_material_grey_stock IS
  -- Author  : CZH55
  -- Created : 2023/4/25 17:39:55
  -- Purpose : ���Ϲ�Ӧ�������ֿ��-���������

  --��ѯ MATERIAL_GREY_STOCK
  FUNCTION f_query_material_grey_stock RETURN CLOB;

  --��ѯ ͨ��ID MATERIAL_GREY_STOCK
  FUNCTION f_query_material_grey_stock_by_id(p_color_cloth_stock_id VARCHAR2)
    RETURN CLOB;

  --���� MATERIAL_GREY_STOCK
  PROCEDURE p_insert_material_grey_stock(p_mater_rec material_grey_stock%ROWTYPE);

  --�޸� MATERIAL_GREY_STOCK
  PROCEDURE p_update_material_grey_stock(p_mater_rec material_grey_stock%ROWTYPE);

  --ɾ�� MATERIAL_GREY_STOCK
  PROCEDURE p_delete_material_grey_stock(p_mater_rec material_grey_stock%ROWTYPE);

  --ɾ�� ͨ��ID MATERIAL_GREY_STOCK
  PROCEDURE p_delete_material_grey_stock_by_id(p_color_cloth_stock_id VARCHAR2);

  --У�� CREATE_TIME MATERIAL_GREY_STOCK
  PROCEDURE p_check_create_time(p_create_time DATE);

  --У�� COLOR_CLOTH_STOCK_ID MATERIAL_GREY_STOCK
  PROCEDURE p_check_color_cloth_stock_id(p_color_cloth_stock_id VARCHAR2);

  --У�� MATER_SUPPLIER_CODE MATERIAL_GREY_STOCK
  PROCEDURE p_check_mater_supplier_code(p_mater_supplier_code VARCHAR2);

  --У�� MATERIAL_SPU MATERIAL_GREY_STOCK
  PROCEDURE p_check_material_spu(p_material_spu VARCHAR2);

  --У�� UNIT MATERIAL_GREY_STOCK
  PROCEDURE p_check_unit(p_unit VARCHAR2);

  --У�� COMPANY_ID MATERIAL_GREY_STOCK
  PROCEDURE p_check_company_id(p_company_id VARCHAR2);

  --У�� CREATE_ID MATERIAL_GREY_STOCK
  PROCEDURE p_check_create_id(p_create_id VARCHAR2);
  --���� MATERIAL_GREY_STOCK
  PROCEDURE p_invoke_material_grey_stock(p_mater_rec material_grey_stock%ROWTYPE);

END pkg_material_grey_stock;
/
CREATE OR REPLACE PACKAGE BODY mrp.pkg_material_grey_stock IS
  --��ѯ MATERIAL_GREY_STOCK
  FUNCTION f_query_material_grey_stock RETURN CLOB IS
    v_sql CLOB;
  
  BEGIN
    v_sql := '
SELECT t.color_cloth_stock_id, --��Ӧ�������������
       t.mater_supplier_code, --���Ϲ�Ӧ�̱��
       t.material_spu, --����SPU
       t.unit, --��λ
       t.total_stock, --�ܿ����
       t.brand_stock, --Ʒ�Ʋֿ����
       t.supplier_stock, --��Ӧ�ֿ̲����
       t.company_id, --��ҵ����
       t.create_id, --������
       t.create_time, --����ʱ��
       t.update_id, --������
       t.update_time, --����ʱ��
       t.whether_del --�Ƿ�ɾ����0��1��
  FROM material_grey_stock t
 WHERE 1 = 1
';
    RETURN v_sql;
  END f_query_material_grey_stock;
  --��ѯ ͨ��ID MATERIAL_GREY_STOCK
  FUNCTION f_query_material_grey_stock_by_id(p_color_cloth_stock_id VARCHAR2)
    RETURN CLOB IS
    v_sql CLOB;
  
    v_color_cloth_stock_id VARCHAR2(32) := p_color_cloth_stock_id;
  BEGIN
    v_sql := '
SELECT t.color_cloth_stock_id, --��Ӧ�������������
       t.mater_supplier_code, --���Ϲ�Ӧ�̱��
       t.material_spu, --����SPU
       t.unit, --��λ
       t.total_stock, --�ܿ����
       t.brand_stock, --Ʒ�Ʋֿ����
       t.supplier_stock, --��Ӧ�ֿ̲����
       t.company_id, --��ҵ����
       t.create_id, --������
       t.create_time, --����ʱ��
       t.update_id, --������
       t.update_time, --����ʱ��
       t.whether_del --�Ƿ�ɾ����0��1��
  FROM material_grey_stock t
 WHERE t.color_cloth_stock_id = ''' || v_color_cloth_stock_id || '''
';
    RETURN v_sql;
  END f_query_material_grey_stock_by_id;
  --���� MATERIAL_GREY_STOCK
  PROCEDURE p_insert_material_grey_stock(p_mater_rec material_grey_stock%ROWTYPE) IS
  BEGIN
  
    INSERT INTO material_grey_stock
      (color_cloth_stock_id, mater_supplier_code, material_spu, unit,
       total_stock, brand_stock, supplier_stock, company_id, create_id,
       create_time, update_id, update_time, whether_del)
    VALUES
      (p_mater_rec.color_cloth_stock_id, p_mater_rec.mater_supplier_code,
       p_mater_rec.material_spu, p_mater_rec.unit, p_mater_rec.total_stock,
       p_mater_rec.brand_stock, p_mater_rec.supplier_stock,
       p_mater_rec.company_id, p_mater_rec.create_id,
       p_mater_rec.create_time, p_mater_rec.update_id,
       p_mater_rec.update_time, p_mater_rec.whether_del);
  END p_insert_material_grey_stock;

  --�޸� MATERIAL_GREY_STOCK
  PROCEDURE p_update_material_grey_stock(p_mater_rec material_grey_stock%ROWTYPE) IS
  BEGIN
  
    UPDATE material_grey_stock t
       SET t.mater_supplier_code = p_mater_rec.mater_supplier_code, --���Ϲ�Ӧ�̱��
           t.material_spu        = p_mater_rec.material_spu, --����SPU
           t.unit                = p_mater_rec.unit, --��λ
           t.total_stock         = p_mater_rec.total_stock, --�ܿ����
           t.brand_stock         = p_mater_rec.brand_stock, --Ʒ�Ʋֿ����
           t.supplier_stock      = p_mater_rec.supplier_stock, --��Ӧ�ֿ̲����
           t.company_id          = p_mater_rec.company_id, --��ҵ����
           t.create_id           = p_mater_rec.create_id, --������
           t.create_time         = p_mater_rec.create_time, --����ʱ��
           t.update_id           = p_mater_rec.update_id, --������
           t.update_time         = p_mater_rec.update_time, --����ʱ��
           t.whether_del         = p_mater_rec.whether_del --�Ƿ�ɾ����0��1��
     WHERE t.color_cloth_stock_id = p_mater_rec.color_cloth_stock_id;
  END p_update_material_grey_stock;

  --ɾ�� MATERIAL_GREY_STOCK
  PROCEDURE p_delete_material_grey_stock(p_mater_rec material_grey_stock%ROWTYPE) IS
  BEGIN
  
    DELETE FROM material_grey_stock t WHERE 1 = 0;
  END p_delete_material_grey_stock;

  --ɾ�� ͨ��ID MATERIAL_GREY_STOCK
  PROCEDURE p_delete_material_grey_stock_by_id(p_color_cloth_stock_id VARCHAR2) IS
  
    v_color_cloth_stock_id VARCHAR2(32) := p_color_cloth_stock_id;
  BEGIN
  
    DELETE FROM material_grey_stock t
     WHERE t.color_cloth_stock_id = v_color_cloth_stock_id;
  END p_delete_material_grey_stock_by_id;

  --У�� CREATE_TIME MATERIAL_GREY_STOCK
  PROCEDURE p_check_create_time(p_create_time DATE) IS
  
  BEGIN
  
    IF p_create_time IS NULL THEN
      raise_application_error(-20002, '������ʱ�䡿������飡');
    END IF;
  END p_check_create_time;

  --У�� COLOR_CLOTH_STOCK_ID MATERIAL_GREY_STOCK
  PROCEDURE p_check_color_cloth_stock_id(p_color_cloth_stock_id VARCHAR2) IS
  
  BEGIN
  
    IF p_color_cloth_stock_id IS NULL THEN
      raise_application_error(-20002,
                              '����Ӧ���������������������飡');
    END IF;
  END p_check_color_cloth_stock_id;

  --У�� MATER_SUPPLIER_CODE MATERIAL_GREY_STOCK
  PROCEDURE p_check_mater_supplier_code(p_mater_supplier_code VARCHAR2) IS
  
  BEGIN
  
    IF p_mater_supplier_code IS NULL THEN
      raise_application_error(-20002, '�����Ϲ�Ӧ�̱�š�������飡');
    END IF;
  END p_check_mater_supplier_code;

  --У�� MATERIAL_SPU MATERIAL_GREY_STOCK
  PROCEDURE p_check_material_spu(p_material_spu VARCHAR2) IS
  
  BEGIN
  
    IF p_material_spu IS NULL THEN
      raise_application_error(-20002, '������SPU��������飡');
    END IF;
  END p_check_material_spu;

  --У�� UNIT MATERIAL_GREY_STOCK
  PROCEDURE p_check_unit(p_unit VARCHAR2) IS
  
  BEGIN
  
    IF p_unit IS NULL THEN
      raise_application_error(-20002, '����λ��������飡');
    END IF;
  END p_check_unit;

  --У�� COMPANY_ID MATERIAL_GREY_STOCK
  PROCEDURE p_check_company_id(p_company_id VARCHAR2) IS
  
  BEGIN
  
    IF p_company_id IS NULL THEN
      raise_application_error(-20002, '����ҵ���롿������飡');
    END IF;
  END p_check_company_id;

  --У�� CREATE_ID MATERIAL_GREY_STOCK
  PROCEDURE p_check_create_id(p_create_id VARCHAR2) IS
  
  BEGIN
  
    IF p_create_id IS NULL THEN
      raise_application_error(-20002, '�������ߡ�������飡');
    END IF;
  END p_check_create_id;
  --���� MATERIAL_GREY_STOCK
  PROCEDURE p_invoke_material_grey_stock(p_mater_rec material_grey_stock%ROWTYPE) IS
  BEGIN
  
    mrp.pkg_material_grey_stock.p_check_create_time(p_create_time => p_mater_rec.create_time);
    mrp.pkg_material_grey_stock.p_check_color_cloth_stock_id(p_color_cloth_stock_id => p_mater_rec.color_cloth_stock_id);
    mrp.pkg_material_grey_stock.p_check_mater_supplier_code(p_mater_supplier_code => p_mater_rec.mater_supplier_code);
    mrp.pkg_material_grey_stock.p_check_material_spu(p_material_spu => p_mater_rec.material_spu);
    mrp.pkg_material_grey_stock.p_check_unit(p_unit => p_mater_rec.unit);
    mrp.pkg_material_grey_stock.p_check_company_id(p_company_id => p_mater_rec.company_id);
    mrp.pkg_material_grey_stock.p_check_create_id(p_create_id => p_mater_rec.create_id);
  END p_invoke_material_grey_stock;

END pkg_material_grey_stock;
/
