CREATE OR REPLACE PACKAGE mrp.pkg_supplier_color_cloth_stock IS

  -- Author  : CZH55
  -- Created : 2023/4/25 17:39:55
  -- Purpose : ��Ʒ��Ӧ��ɫ���ֿ�����-���������

  --��ѯ SUPPLIER_COLOR_CLOTH_STOCK
  FUNCTION f_query_supplier_color_cloth_stock RETURN CLOB;

  --���� SUPPLIER_COLOR_CLOTH_STOCK
  PROCEDURE p_insert_supplier_color_cloth_stock(p_suppl_rec supplier_color_cloth_stock%ROWTYPE);

  --�޸� SUPPLIER_COLOR_CLOTH_STOCK
  PROCEDURE p_update_supplier_color_cloth_stock(p_suppl_rec supplier_color_cloth_stock%ROWTYPE);

  --ɾ�� SUPPLIER_COLOR_CLOTH_STOCK
  PROCEDURE p_delete_supplier_color_cloth_stock(p_suppl_rec supplier_color_cloth_stock%ROWTYPE);

END pkg_supplier_color_cloth_stock;
/
CREATE OR REPLACE PACKAGE BODY mrp.pkg_supplier_color_cloth_stock IS
  --��ѯ SUPPLIER_COLOR_CLOTH_STOCK
  FUNCTION f_query_supplier_color_cloth_stock RETURN CLOB IS
    v_sql CLOB;
  
  BEGIN
    v_sql := '
SELECT t.color_cloth_stock_id, --��Ӧ��ɫ���������
       t.pro_supplier_code, --��Ʒ��Ӧ�̱��
       t.mater_supplier_code, --���Ϲ�Ӧ�̱��
       t.material_sku, --����SKU
       t.whether_inner_mater, --�Ƿ��ڲ����ϣ�0��1��
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
  FROM supplier_color_cloth_stock t
 WHERE 1 = 1
';
    RETURN v_sql;
  END f_query_supplier_color_cloth_stock;

  --���� SUPPLIER_COLOR_CLOTH_STOCK
  PROCEDURE p_insert_supplier_color_cloth_stock(p_suppl_rec supplier_color_cloth_stock%ROWTYPE) IS
  BEGIN
  
    INSERT INTO supplier_color_cloth_stock
      (color_cloth_stock_id, pro_supplier_code, mater_supplier_code,
       material_sku, whether_inner_mater, unit, total_stock, brand_stock,
       supplier_stock, company_id, create_id, create_time, update_id,
       update_time, whether_del)
    VALUES
      (p_suppl_rec.color_cloth_stock_id, p_suppl_rec.pro_supplier_code,
       p_suppl_rec.mater_supplier_code, p_suppl_rec.material_sku,
       p_suppl_rec.whether_inner_mater, p_suppl_rec.unit,
       p_suppl_rec.total_stock, p_suppl_rec.brand_stock,
       p_suppl_rec.supplier_stock, p_suppl_rec.company_id,
       p_suppl_rec.create_id, p_suppl_rec.create_time, p_suppl_rec.update_id,
       p_suppl_rec.update_time, p_suppl_rec.whether_del);
  END p_insert_supplier_color_cloth_stock;

  --�޸� SUPPLIER_COLOR_CLOTH_STOCK
  PROCEDURE p_update_supplier_color_cloth_stock(p_suppl_rec supplier_color_cloth_stock%ROWTYPE) IS
  BEGIN
  
    UPDATE supplier_color_cloth_stock t
       SET t.pro_supplier_code   = p_suppl_rec.pro_supplier_code, --��Ʒ��Ӧ�̱��
           t.mater_supplier_code = p_suppl_rec.mater_supplier_code, --���Ϲ�Ӧ�̱��
           t.material_sku        = p_suppl_rec.material_sku, --����SKU
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
  END p_update_supplier_color_cloth_stock;

  --ɾ�� SUPPLIER_COLOR_CLOTH_STOCK
  PROCEDURE p_delete_supplier_color_cloth_stock(p_suppl_rec supplier_color_cloth_stock%ROWTYPE) IS
  BEGIN
  
    DELETE FROM supplier_color_cloth_stock t
     WHERE t.color_cloth_stock_id = p_suppl_rec.color_cloth_stock_id;
  END p_delete_supplier_color_cloth_stock;

END pkg_supplier_color_cloth_stock;
/
