CREATE OR REPLACE PACKAGE mrp.pkg_material_color_cloth_stock IS
  --��ѯ MATERIAL_COLOR_CLOTH_STOCK
  FUNCTION f_query_material_color_cloth_stock RETURN CLOB;

  --���� MATERIAL_COLOR_CLOTH_STOCK
  PROCEDURE p_insert_material_color_cloth_stock(p_mater_rec material_color_cloth_stock%ROWTYPE);

  --�޸� MATERIAL_COLOR_CLOTH_STOCK
  PROCEDURE p_update_material_color_cloth_stock(p_mater_rec material_color_cloth_stock%ROWTYPE);

  --ɾ�� MATERIAL_COLOR_CLOTH_STOCK
  PROCEDURE p_delete_material_color_cloth_stock(p_mater_rec material_color_cloth_stock%ROWTYPE);

END pkg_material_color_cloth_stock;
/
CREATE OR REPLACE PACKAGE BODY mrp.pkg_material_color_cloth_stock IS
  --��ѯ MATERIAL_COLOR_CLOTH_STOCK
  FUNCTION f_query_material_color_cloth_stock RETURN CLOB IS
    v_sql CLOB; 
  BEGIN
    v_sql := '
SELECT t.color_cloth_stock_id, --��Ӧ��ɫ���������
       t.mater_supplier_code, --���Ϲ�Ӧ�̱��
       t.material_sku, --����SKU
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
  FROM material_color_cloth_stock t
 WHERE 1 = 1
';
    RETURN v_sql;
  END f_query_material_color_cloth_stock;

  --���� MATERIAL_COLOR_CLOTH_STOCK
  PROCEDURE p_insert_material_color_cloth_stock(p_mater_rec material_color_cloth_stock%ROWTYPE) IS
  BEGIN
  
    INSERT INTO material_color_cloth_stock
      (color_cloth_stock_id, mater_supplier_code, material_sku, unit,
       total_stock, brand_stock, supplier_stock, company_id, create_id,
       create_time, update_id, update_time, whether_del)
    VALUES
      (p_mater_rec.color_cloth_stock_id, p_mater_rec.mater_supplier_code,
       p_mater_rec.material_sku, p_mater_rec.unit, p_mater_rec.total_stock,
       p_mater_rec.brand_stock, p_mater_rec.supplier_stock,
       p_mater_rec.company_id, p_mater_rec.create_id,
       p_mater_rec.create_time, p_mater_rec.update_id,
       p_mater_rec.update_time, p_mater_rec.whether_del);
  END p_insert_material_color_cloth_stock;

  --�޸� MATERIAL_COLOR_CLOTH_STOCK
  PROCEDURE p_update_material_color_cloth_stock(p_mater_rec material_color_cloth_stock%ROWTYPE) IS
  BEGIN  
    UPDATE material_color_cloth_stock t
       SET t.mater_supplier_code = p_mater_rec.mater_supplier_code, --���Ϲ�Ӧ�̱��
           t.material_sku        = p_mater_rec.material_sku, --����SKU
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
  END p_update_material_color_cloth_stock;

  --ɾ�� MATERIAL_COLOR_CLOTH_STOCK
  PROCEDURE p_delete_material_color_cloth_stock(p_mater_rec material_color_cloth_stock%ROWTYPE) IS
  BEGIN  
    DELETE FROM material_color_cloth_stock t WHERE 1 = 0;
  END p_delete_material_color_cloth_stock;

END pkg_material_color_cloth_stock;
/
