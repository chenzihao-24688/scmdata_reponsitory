CREATE OR REPLACE PACKAGE mrp.pkg_supplier_grey_stock IS

  -- Author  : CZH55
  -- Created : 2023/4/25 17:39:55
  -- Purpose : ��Ʒ��Ӧ�������ֿ����ϸ-���������
  
  --��ѯ SUPPLIER_GREY_STOCK
  FUNCTION f_query_supplier_grey_stock RETURN CLOB;

  --��ѯ ͨ��ID SUPPLIER_GREY_STOCK
  FUNCTION f_query_supplier_grey_stock_by_id(p_color_cloth_stock_id VARCHAR2)
    RETURN CLOB;

  --���� SUPPLIER_GREY_STOCK
  PROCEDURE p_insert_supplier_grey_stock(p_suppl_rec supplier_grey_stock%ROWTYPE);

  --�޸� SUPPLIER_GREY_STOCK
  PROCEDURE p_update_supplier_grey_stock(p_suppl_rec supplier_grey_stock%ROWTYPE);

  --ɾ�� SUPPLIER_GREY_STOCK
  PROCEDURE p_delete_supplier_grey_stock(p_suppl_rec supplier_grey_stock%ROWTYPE);

  --ɾ�� ͨ��ID SUPPLIER_GREY_STOCK
  PROCEDURE p_delete_supplier_grey_stock_by_id(p_color_cloth_stock_id VARCHAR2);

  --У�� COLOR_CLOTH_STOCK_ID SUPPLIER_GREY_STOCK
  PROCEDURE p_check_color_cloth_stock_id(p_color_cloth_stock_id VARCHAR2);

  --У�� PRO_SUPPLIER_CODE SUPPLIER_GREY_STOCK
  PROCEDURE p_check_pro_supplier_code(p_pro_supplier_code VARCHAR2);

  --У�� MATER_SUPPLIER_CODE SUPPLIER_GREY_STOCK
  PROCEDURE p_check_mater_supplier_code(p_mater_supplier_code VARCHAR2);

  --У�� MATERIAL_SPU SUPPLIER_GREY_STOCK
  PROCEDURE p_check_material_spu(p_material_spu VARCHAR2);

  --У�� UNIT SUPPLIER_GREY_STOCK
  PROCEDURE p_check_unit(p_unit VARCHAR2);

  --У�� COMPANY_ID SUPPLIER_GREY_STOCK
  PROCEDURE p_check_company_id(p_company_id VARCHAR2);

  --У�� CREATE_ID SUPPLIER_GREY_STOCK
  PROCEDURE p_check_create_id(p_create_id VARCHAR2);

  --У�� CREATE_TIME SUPPLIER_GREY_STOCK
  PROCEDURE p_check_create_time(p_create_time DATE);
  --���� SUPPLIER_GREY_STOCK
  PROCEDURE p_invoke_supplier_grey_stock(p_suppl_rec supplier_grey_stock%ROWTYPE);

END pkg_supplier_grey_stock;
/
CREATE OR REPLACE PACKAGE BODY mrp.pkg_supplier_grey_stock IS
  --��ѯ SUPPLIER_GREY_STOCK
  FUNCTION f_query_supplier_grey_stock RETURN CLOB IS
    v_sql CLOB;
  
  BEGIN
    v_sql := '

SELECT T.COLOR_CLOTH_STOCK_ID, --��Ӧ�������������
T.PRO_SUPPLIER_CODE, --��Ʒ��Ӧ�̱��
T.MATER_SUPPLIER_CODE, --���Ϲ�Ӧ�̱��
T.MATERIAL_SPU, --����SPU
T.WHETHER_INNER_MATER, --�Ƿ��ڲ����ϣ�0��1��
T.UNIT, --��λ
T.TOTAL_STOCK, --�ܿ����
T.BRAND_STOCK, --Ʒ�Ʋֿ����
T.SUPPLIER_STOCK, --��Ӧ�ֿ̲����
T.COMPANY_ID, --��ҵ����
T.CREATE_ID, --������
T.CREATE_TIME, --����ʱ��
T.UPDATE_ID, --������
T.UPDATE_TIME, --����ʱ��
T.WHETHER_DEL --�Ƿ�ɾ����0��1��
 FROM SUPPLIER_GREY_STOCK T  WHERE 1 = 1
';
    RETURN v_sql;
  END f_query_supplier_grey_stock;
  --��ѯ ͨ��ID SUPPLIER_GREY_STOCK
  FUNCTION f_query_supplier_grey_stock_by_id(p_color_cloth_stock_id VARCHAR2)
    RETURN CLOB IS
    v_sql CLOB;
  
    v_color_cloth_stock_id VARCHAR2(32) := p_color_cloth_stock_id;
  BEGIN
    v_sql := '

SELECT T.COLOR_CLOTH_STOCK_ID, --��Ӧ�������������
T.PRO_SUPPLIER_CODE, --��Ʒ��Ӧ�̱��
T.MATER_SUPPLIER_CODE, --���Ϲ�Ӧ�̱��
T.MATERIAL_SPU, --����SPU
T.WHETHER_INNER_MATER, --�Ƿ��ڲ����ϣ�0��1��
T.UNIT, --��λ
T.TOTAL_STOCK, --�ܿ����
T.BRAND_STOCK, --Ʒ�Ʋֿ����
T.SUPPLIER_STOCK, --��Ӧ�ֿ̲����
T.COMPANY_ID, --��ҵ����
T.CREATE_ID, --������
T.CREATE_TIME, --����ʱ��
T.UPDATE_ID, --������
T.UPDATE_TIME, --����ʱ��
T.WHETHER_DEL --�Ƿ�ɾ����0��1��
 FROM SUPPLIER_GREY_STOCK T  WHERE T.COLOR_CLOTH_STOCK_ID = ''' ||
             v_color_cloth_stock_id || '''
';
    RETURN v_sql;
  END f_query_supplier_grey_stock_by_id;
  --���� SUPPLIER_GREY_STOCK
  PROCEDURE p_insert_supplier_grey_stock(p_suppl_rec supplier_grey_stock%ROWTYPE) IS
  BEGIN
  
    INSERT INTO supplier_grey_stock
      (color_cloth_stock_id, pro_supplier_code, mater_supplier_code,
       material_spu, whether_inner_mater, unit, total_stock, brand_stock,
       supplier_stock, company_id, create_id, create_time, update_id,
       update_time, whether_del)
    VALUES
      (p_suppl_rec.color_cloth_stock_id, p_suppl_rec.pro_supplier_code,
       p_suppl_rec.mater_supplier_code, p_suppl_rec.material_spu,
       p_suppl_rec.whether_inner_mater, p_suppl_rec.unit,
       p_suppl_rec.total_stock, p_suppl_rec.brand_stock,
       p_suppl_rec.supplier_stock, p_suppl_rec.company_id,
       p_suppl_rec.create_id, p_suppl_rec.create_time, p_suppl_rec.update_id,
       p_suppl_rec.update_time, p_suppl_rec.whether_del);
  END p_insert_supplier_grey_stock;

  --�޸� SUPPLIER_GREY_STOCK
  PROCEDURE p_update_supplier_grey_stock(p_suppl_rec supplier_grey_stock%ROWTYPE) IS
  BEGIN
  
    UPDATE supplier_grey_stock t
       SET t.pro_supplier_code   = p_suppl_rec.pro_supplier_code, --��Ʒ��Ӧ�̱��
           t.mater_supplier_code = p_suppl_rec.mater_supplier_code, --���Ϲ�Ӧ�̱��
           t.material_spu        = p_suppl_rec.material_spu, --����SPU
           t.whether_inner_mater = p_suppl_rec.whether_inner_mater, --�Ƿ��ڲ����ϣ�0��1��
           t.unit                = p_suppl_rec.unit, --��λ
           t.total_stock         = p_suppl_rec.total_stock, --�ܿ����
           t.brand_stock         = p_suppl_rec.brand_stock, --Ʒ�Ʋֿ����
           t.supplier_stock      = p_suppl_rec.supplier_stock, --��Ӧ�ֿ̲����
           t.company_id          = p_suppl_rec.company_id, --��ҵ����
           t.create_id           = p_suppl_rec.create_id, --������
           t.create_time         = p_suppl_rec.create_time, --����ʱ��
           t.update_id           = p_suppl_rec.update_id, --������
           t.update_time         = p_suppl_rec.update_time, --����ʱ��
           t.whether_del         = p_suppl_rec.whether_del --�Ƿ�ɾ����0��1��
     WHERE t.color_cloth_stock_id = p_suppl_rec.color_cloth_stock_id;
  END p_update_supplier_grey_stock;

  --ɾ�� SUPPLIER_GREY_STOCK
  PROCEDURE p_delete_supplier_grey_stock(p_suppl_rec supplier_grey_stock%ROWTYPE) IS
  BEGIN
  
    DELETE FROM supplier_grey_stock t WHERE 1 = 0;
  END p_delete_supplier_grey_stock;

  --ɾ�� ͨ��ID SUPPLIER_GREY_STOCK
  PROCEDURE p_delete_supplier_grey_stock_by_id(p_color_cloth_stock_id VARCHAR2) IS
  
    v_color_cloth_stock_id VARCHAR2(32) := p_color_cloth_stock_id;
  BEGIN
  
    DELETE FROM supplier_grey_stock t
     WHERE t.color_cloth_stock_id = v_color_cloth_stock_id;
  END p_delete_supplier_grey_stock_by_id;

  --У�� COLOR_CLOTH_STOCK_ID SUPPLIER_GREY_STOCK
  PROCEDURE p_check_color_cloth_stock_id(p_color_cloth_stock_id VARCHAR2) IS
  
  BEGIN
  
    IF p_color_cloth_stock_id IS NULL THEN
      raise_application_error(-20002,
                              '����Ӧ���������������������飡');
    END IF;
  END p_check_color_cloth_stock_id;

  --У�� PRO_SUPPLIER_CODE SUPPLIER_GREY_STOCK
  PROCEDURE p_check_pro_supplier_code(p_pro_supplier_code VARCHAR2) IS
  
  BEGIN
  
    IF p_pro_supplier_code IS NULL THEN
      raise_application_error(-20002, '����Ʒ��Ӧ�̱�š�������飡');
    END IF;
  END p_check_pro_supplier_code;

  --У�� MATER_SUPPLIER_CODE SUPPLIER_GREY_STOCK
  PROCEDURE p_check_mater_supplier_code(p_mater_supplier_code VARCHAR2) IS
  
  BEGIN
  
    IF p_mater_supplier_code IS NULL THEN
      raise_application_error(-20002, '�����Ϲ�Ӧ�̱�š�������飡');
    END IF;
  END p_check_mater_supplier_code;

  --У�� MATERIAL_SPU SUPPLIER_GREY_STOCK
  PROCEDURE p_check_material_spu(p_material_spu VARCHAR2) IS
  
  BEGIN
  
    IF p_material_spu IS NULL THEN
      raise_application_error(-20002, '������SPU��������飡');
    END IF;
  END p_check_material_spu;

  --У�� UNIT SUPPLIER_GREY_STOCK
  PROCEDURE p_check_unit(p_unit VARCHAR2) IS
  
  BEGIN
  
    IF p_unit IS NULL THEN
      raise_application_error(-20002, '����λ��������飡');
    END IF;
  END p_check_unit;

  --У�� COMPANY_ID SUPPLIER_GREY_STOCK
  PROCEDURE p_check_company_id(p_company_id VARCHAR2) IS
  
  BEGIN
  
    IF p_company_id IS NULL THEN
      raise_application_error(-20002, '����ҵ���롿������飡');
    END IF;
  END p_check_company_id;

  --У�� CREATE_ID SUPPLIER_GREY_STOCK
  PROCEDURE p_check_create_id(p_create_id VARCHAR2) IS
  
  BEGIN
  
    IF p_create_id IS NULL THEN
      raise_application_error(-20002, '�������ߡ�������飡');
    END IF;
  END p_check_create_id;

  --У�� CREATE_TIME SUPPLIER_GREY_STOCK
  PROCEDURE p_check_create_time(p_create_time DATE) IS
  
  BEGIN
  
    IF p_create_time IS NULL THEN
      raise_application_error(-20002, '������ʱ�䡿������飡');
    END IF;
  END p_check_create_time;
  --���� SUPPLIER_GREY_STOCK
  PROCEDURE p_invoke_supplier_grey_stock(p_suppl_rec supplier_grey_stock%ROWTYPE) IS
  BEGIN
  
    mrp.pkg_supplier_grey_stock.p_check_color_cloth_stock_id(p_color_cloth_stock_id => p_suppl_rec.color_cloth_stock_id);
    mrp.pkg_supplier_grey_stock.p_check_pro_supplier_code(p_pro_supplier_code => p_suppl_rec.pro_supplier_code);
    mrp.pkg_supplier_grey_stock.p_check_mater_supplier_code(p_mater_supplier_code => p_suppl_rec.mater_supplier_code);
    mrp.pkg_supplier_grey_stock.p_check_material_spu(p_material_spu => p_suppl_rec.material_spu);
    mrp.pkg_supplier_grey_stock.p_check_unit(p_unit => p_suppl_rec.unit);
    mrp.pkg_supplier_grey_stock.p_check_company_id(p_company_id => p_suppl_rec.company_id);
    mrp.pkg_supplier_grey_stock.p_check_create_id(p_create_id => p_suppl_rec.create_id);
    mrp.pkg_supplier_grey_stock.p_check_create_time(p_create_time => p_suppl_rec.create_time);
  END p_invoke_supplier_grey_stock;

END pkg_supplier_grey_stock;
/
