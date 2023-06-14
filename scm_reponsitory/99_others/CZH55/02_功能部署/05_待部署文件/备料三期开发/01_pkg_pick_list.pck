CREATE OR REPLACE PACKAGE mrp.pkg_pick_list IS

  -- Author  : CZH55
  -- Created : 2023/4/25 17:39:55
  -- Purpose : ���ϵ�����-���������

  --��ѯ PICK_LIST
  FUNCTION f_query_pick_list(p_order_num VARCHAR2) RETURN CLOB;

  --���� PICK_LIST
  PROCEDURE p_insert_pick_list(p_pick_rec pick_list%ROWTYPE);

  --�޸� PICK_LIST
  PROCEDURE p_update_pick_list(p_pick_rec pick_list%ROWTYPE);

  --ɾ�� PICK_LIST
  PROCEDURE p_delete_pick_list(p_pick_rec pick_list%ROWTYPE);

END pkg_pick_list;
/
CREATE OR REPLACE PACKAGE BODY mrp.pkg_pick_list IS
  --��ѯ PICK_LIST
  FUNCTION f_query_pick_list(p_order_num VARCHAR2) RETURN CLOB IS
    v_sql                 CLOB;
  BEGIN
    v_sql := q'[
SELECT *
  FROM (SELECT tc.colorname bl_colorname_n, --��ɫ
               gd.group_dict_name bl_status_n, --����״̬��0����ɣ�1����ɣ�2��ȡ��
               t.relate_skc bl_relate_skc_n, --����SKC
               bm.supplier_material_name bl_sup_material_name_n, --��Ӧ���������� 
               t.material_sku bl_material_sku_n, --����sku 
               nvl(sa.supplier_name,sb.supplier_name) bl_mater_supplier_name_n, --���Ϲ�Ӧ��
               bm.supplier_color bl_supplier_color_n, --��Ӧ����ɫ 
               bm.supplier_shades bl_supplier_shades_n, --��Ӧ��ɫ�� 
               '���ϵ�' bl_type_n,
               t.pick_lict_code bl_relate_code_n --���ϵ���
          FROM mrp.pick_list t
          LEFT JOIN scmdata.t_commodity_color tc
            ON tc.commodity_color_code = t.relate_skc
          LEFT JOIN mrp.bulk_cargo_bom_material_detail bm
            ON bm.relate_develop_bom_material_detail_id =
               t.material_detail_id
           AND bm.bulk_cargo_bom_id = t.bulk_cargo_bom_id
          LEFT JOIN scmdata.sys_group_dict gd
            ON gd.group_dict_type = 'PICK_STATUS'
           AND gd.group_dict_value = t.pick_status
          LEFT JOIN mrp.mrp_determine_supplier_archives sa
            ON sa.supplier_code = t.mater_supplier_code
           AND sa.company_id = t.company_id            
          LEFT JOIN mrp.mrp_temporary_supplier_archives sb
            ON sb.supplier_code = t.mater_supplier_code
         WHERE t.relate_product_order_num = ']' || p_order_num || q'['
         ORDER BY t.relate_skc ASC) va
]';
    RETURN v_sql;
  END f_query_pick_list;

  --���� PICK_LIST
  PROCEDURE p_insert_pick_list(p_pick_rec pick_list%ROWTYPE) IS
  BEGIN
    INSERT INTO pick_list
      (pick_lict_code, pick_status, pick_source, pro_supplier_code,
       mater_supplier_code, material_sku, whether_inner_mater, unit,
       purchase_skc_order_num, suggest_pick_num, pick_num, pick_percent,
       unpick_num, relate_product_order_num, relate_skc, bulk_cargo_bom_id,
       material_detail_id, company_id, create_id, create_time, update_id,
       update_time, whether_del, pick_id, pick_time, cancel_id, cancel_time,
       cancel_reason)
    VALUES
      (p_pick_rec.pick_lict_code, p_pick_rec.pick_status,
       p_pick_rec.pick_source, p_pick_rec.pro_supplier_code,
       p_pick_rec.mater_supplier_code, p_pick_rec.material_sku,
       p_pick_rec.whether_inner_mater, p_pick_rec.unit,
       p_pick_rec.purchase_skc_order_num, p_pick_rec.suggest_pick_num,
       p_pick_rec.pick_num, p_pick_rec.pick_percent, p_pick_rec.unpick_num,
       p_pick_rec.relate_product_order_num, p_pick_rec.relate_skc,
       p_pick_rec.bulk_cargo_bom_id, p_pick_rec.material_detail_id,
       p_pick_rec.company_id, p_pick_rec.create_id, p_pick_rec.create_time,
       p_pick_rec.update_id, p_pick_rec.update_time, p_pick_rec.whether_del,
       p_pick_rec.pick_id, p_pick_rec.pick_time, p_pick_rec.cancel_id,
       p_pick_rec.cancel_time, p_pick_rec.cancel_reason);
  END p_insert_pick_list;

  --�޸� PICK_LIST
  PROCEDURE p_update_pick_list(p_pick_rec pick_list%ROWTYPE) IS
  BEGIN
    UPDATE pick_list t
       SET t.pick_status              = p_pick_rec.pick_status, --����״̬��0����ɣ�1����ɣ�2��ȡ��
           t.pick_source              = p_pick_rec.pick_source, --���ϵ���Դ
           t.pro_supplier_code        = p_pick_rec.pro_supplier_code, --��Ʒ��Ӧ�̱��
           t.mater_supplier_code      = p_pick_rec.mater_supplier_code, --���Ϲ�Ӧ�̱��
           t.material_sku             = p_pick_rec.material_sku, --����SKU
           t.whether_inner_mater      = p_pick_rec.whether_inner_mater, --�Ƿ��ڲ����ϣ�0��1��
           t.unit                     = p_pick_rec.unit, --��λ
           t.purchase_skc_order_num   = p_pick_rec.purchase_skc_order_num, --�ɹ�SKC������
           t.suggest_pick_num         = p_pick_rec.suggest_pick_num, --����������
           t.pick_num                 = p_pick_rec.pick_num, --��������
           t.pick_percent             = p_pick_rec.pick_percent, --�����ϰٷֱ�
           t.unpick_num               = p_pick_rec.unpick_num, --δ������
           t.relate_product_order_num = p_pick_rec.relate_product_order_num, --���������������
           t.relate_skc               = p_pick_rec.relate_skc, --����SKC
           t.bulk_cargo_bom_id        = p_pick_rec.bulk_cargo_bom_id, --�������BOMID
           t.material_detail_id       = p_pick_rec.material_detail_id, --�������BOM������ϸID
           t.company_id               = p_pick_rec.company_id, --��ҵ����
           t.create_id                = p_pick_rec.create_id, --������
           t.create_time              = p_pick_rec.create_time, --����ʱ��
           t.update_id                = p_pick_rec.update_id, --������
           t.update_time              = p_pick_rec.update_time, --����ʱ��
           t.whether_del              = p_pick_rec.whether_del, --�Ƿ�ɾ����0��1��
           t.pick_id                  = p_pick_rec.pick_id, --������
           t.pick_time                = p_pick_rec.pick_time, --����ʱ��
           t.cancel_id                = p_pick_rec.cancel_id, --ȡ����
           t.cancel_time              = p_pick_rec.cancel_time, --ȡ������
           t.cancel_reason            = p_pick_rec.cancel_reason --ȡ��ԭ��
     WHERE t.pick_lict_code = p_pick_rec.pick_lict_code;
  END p_update_pick_list;

  --ɾ�� PICK_LIST
  PROCEDURE p_delete_pick_list(p_pick_rec pick_list%ROWTYPE) IS
  BEGIN
    DELETE FROM pick_list t
     WHERE t.pick_lict_code = p_pick_rec.pick_lict_code;
  END p_delete_pick_list;

END pkg_pick_list;
/
