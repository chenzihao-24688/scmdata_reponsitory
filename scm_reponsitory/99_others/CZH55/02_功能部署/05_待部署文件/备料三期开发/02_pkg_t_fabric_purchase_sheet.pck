CREATE OR REPLACE PACKAGE mrp.pkg_t_fabric_purchase_sheet IS

  -- Author  : CZH55
  -- Created : 2023/4/25 17:39:55
  -- Purpose : ���ϲɹ�������-���������

  --��ѯ T_FABRIC_PURCHASE_SHEET
  FUNCTION f_query_t_fabric_purchase_sheet(p_order_num VARCHAR2) RETURN CLOB;

  --���� T_FABRIC_PURCHASE_SHEET
  PROCEDURE p_insert_t_fabric_purchase_sheet(p_t_fab_rec t_fabric_purchase_sheet%ROWTYPE);

  --�޸� T_FABRIC_PURCHASE_SHEET
  PROCEDURE p_update_t_fabric_purchase_sheet(p_t_fab_rec t_fabric_purchase_sheet%ROWTYPE);

  --ɾ�� T_FABRIC_PURCHASE_SHEET
  PROCEDURE p_delete_t_fabric_purchase_sheet(p_t_fab_rec t_fabric_purchase_sheet%ROWTYPE);

END pkg_t_fabric_purchase_sheet;
/
CREATE OR REPLACE PACKAGE BODY mrp.pkg_t_fabric_purchase_sheet IS
  --��ѯ T_FABRIC_PURCHASE_SHEET
  FUNCTION f_query_t_fabric_purchase_sheet(p_order_num VARCHAR2) RETURN CLOB IS
    v_sql CLOB;
  BEGIN
    v_sql := q'[
SELECT *
  FROM (SELECT tc.colorname bl_colorname_n, --��ɫ
               gd.group_dict_name bl_status_n, --�ɹ�״̬(���µ�:s00/���ӵ�:s01/������:s02/���ջ�:s03/���ջ�:s04/��ȡ��:s05) 
               t.goods_skc bl_relate_skc_n, --����SKC              
               t.supplier_material_name bl_sup_material_name_n, --��Ӧ����������                
               t.material_sku bl_material_sku_n, --����sku                
               sa.supplier_name bl_mater_supplier_name_n, --���Ϲ�Ӧ��             
               t.supplier_color bl_supplier_color_n, --��Ӧ����ɫ 
               t.supplier_shades bl_supplier_shades_n, --��Ӧ��ɫ�� 
               '���ϲɹ���' bl_type_n,
               t.fabric_id bl_relate_code_n --���ϲɹ����� 
          FROM mrp.t_fabric_purchase_sheet t
          LEFT JOIN scmdata.t_commodity_color tc
            ON tc.commodity_color_code = t.goods_skc
           AND tc.company_id = t.company_id
          LEFT JOIN scmdata.sys_group_dict gd
            ON gd.group_dict_type = 'PURCHASE_STATUS'
           AND gd.group_dict_value = t.fabric_status
          LEFT JOIN mrp.mrp_determine_supplier_archives sa
            ON sa.supplier_code = t.mater_supplier_code
           AND sa.company_id = t.company_id
         WHERE t.purchase_order_num = ']' || p_order_num || q'['
         ORDER BY t.goods_skc ASC) va
]';
    RETURN v_sql;
  END f_query_t_fabric_purchase_sheet;

  --���� T_FABRIC_PURCHASE_SHEET
  PROCEDURE p_insert_t_fabric_purchase_sheet(p_t_fab_rec t_fabric_purchase_sheet%ROWTYPE) IS
  BEGIN
  
    INSERT INTO t_fabric_purchase_sheet
      (fabric_purchase_sheet_id, company_id, fabric_id, fabric_status,
       fabric_source, pro_supplier_code, material_sku, mater_supplier_code,
       whether_inner_mater, unit, purchase_skc_order_amount,
       suggest_pick_amount, actual_pick_amount, already_deliver_amount,
       not_deliver_amount, delivery_amount, purchase_order_num, goods_skc,
       bulk_cargo_bom_id, material_detail_id, material_spu, features,
       material_name, ingredients, practical_door_with, gram_weight,
       material_specifications, color_picture, material_color,
       preferred_net_price_of_large_good,
       preferred_per_meter_price_of_large_good, benchmark_price,
       sku_abutment_code, supplier_material_name, color_card_picture,
       supplier_color, supplier_shades, optimization, disparity,
       supplier_large_good_quote, supplier_large_good_net_price, create_id,
       create_time, order_id, order_time, receive_order_id,
       receive_order_time, send_order_id, send_order_time, cancel_id,
       cancel_time, cancel_cause, remarks, update_id, update_time, group_key)
    VALUES
      (p_t_fab_rec.fabric_purchase_sheet_id, p_t_fab_rec.company_id,
       p_t_fab_rec.fabric_id, p_t_fab_rec.fabric_status,
       p_t_fab_rec.fabric_source, p_t_fab_rec.pro_supplier_code,
       p_t_fab_rec.material_sku, p_t_fab_rec.mater_supplier_code,
       p_t_fab_rec.whether_inner_mater, p_t_fab_rec.unit,
       p_t_fab_rec.purchase_skc_order_amount,
       p_t_fab_rec.suggest_pick_amount, p_t_fab_rec.actual_pick_amount,
       p_t_fab_rec.already_deliver_amount, p_t_fab_rec.not_deliver_amount,
       p_t_fab_rec.delivery_amount, p_t_fab_rec.purchase_order_num,
       p_t_fab_rec.goods_skc, p_t_fab_rec.bulk_cargo_bom_id,
       p_t_fab_rec.material_detail_id, p_t_fab_rec.material_spu,
       p_t_fab_rec.features, p_t_fab_rec.material_name,
       p_t_fab_rec.ingredients, p_t_fab_rec.practical_door_with,
       p_t_fab_rec.gram_weight, p_t_fab_rec.material_specifications,
       p_t_fab_rec.color_picture, p_t_fab_rec.material_color,
       p_t_fab_rec.preferred_net_price_of_large_good,
       p_t_fab_rec.preferred_per_meter_price_of_large_good,
       p_t_fab_rec.benchmark_price, p_t_fab_rec.sku_abutment_code,
       p_t_fab_rec.supplier_material_name, p_t_fab_rec.color_card_picture,
       p_t_fab_rec.supplier_color, p_t_fab_rec.supplier_shades,
       p_t_fab_rec.optimization, p_t_fab_rec.disparity,
       p_t_fab_rec.supplier_large_good_quote,
       p_t_fab_rec.supplier_large_good_net_price, p_t_fab_rec.create_id,
       p_t_fab_rec.create_time, p_t_fab_rec.order_id, p_t_fab_rec.order_time,
       p_t_fab_rec.receive_order_id, p_t_fab_rec.receive_order_time,
       p_t_fab_rec.send_order_id, p_t_fab_rec.send_order_time,
       p_t_fab_rec.cancel_id, p_t_fab_rec.cancel_time,
       p_t_fab_rec.cancel_cause, p_t_fab_rec.remarks, p_t_fab_rec.update_id,
       p_t_fab_rec.update_time, p_t_fab_rec.group_key);
  END p_insert_t_fabric_purchase_sheet;

  --�޸� T_FABRIC_PURCHASE_SHEET
  PROCEDURE p_update_t_fabric_purchase_sheet(p_t_fab_rec t_fabric_purchase_sheet%ROWTYPE) IS
  BEGIN
  
    UPDATE t_fabric_purchase_sheet t
       SET t.company_id                              = p_t_fab_rec.company_id, --��ҵID
           t.fabric_id                               = p_t_fab_rec.fabric_id, --���ϲɹ�����
           t.fabric_status                           = p_t_fab_rec.fabric_status, --�ɹ�״̬(���µ�:S00/���ӵ�:S01/������:S02/���ջ�:S03/���ջ�:S04/��ȡ��:S05)
           t.fabric_source                           = p_t_fab_rec.fabric_source, --�ɹ�����Դ(Ʒ�Ʋɹ���:0/��Ӧ���Բ�:1/�����̷���:2)
           t.pro_supplier_code                       = p_t_fab_rec.pro_supplier_code, --��Ʒ��Ӧ�̱��
           t.material_sku                            = p_t_fab_rec.material_sku, --����SKU
           t.mater_supplier_code                     = p_t_fab_rec.mater_supplier_code, --���Ϲ�Ӧ�̱��
           t.whether_inner_mater                     = p_t_fab_rec.whether_inner_mater, --�Ƿ��ڲ�����,0��1��
           t.unit                                    = p_t_fab_rec.unit, --��λ
           t.purchase_skc_order_amount               = p_t_fab_rec.purchase_skc_order_amount, --�ɹ�SKC������
           t.suggest_pick_amount                     = p_t_fab_rec.suggest_pick_amount, --����ɹ���
           t.actual_pick_amount                      = p_t_fab_rec.actual_pick_amount, --ʵ�ʲɹ���
           t.already_deliver_amount                  = p_t_fab_rec.already_deliver_amount, --�ѷ�����
           t.not_deliver_amount                      = p_t_fab_rec.not_deliver_amount, --δ������
           t.delivery_amount                         = p_t_fab_rec.delivery_amount, --���ջ���
           t.purchase_order_num                      = p_t_fab_rec.purchase_order_num, --�ɹ��������
           t.goods_skc                               = p_t_fab_rec.goods_skc, --��ɫSKC
           t.bulk_cargo_bom_id                       = p_t_fab_rec.bulk_cargo_bom_id, --���BOMID
           t.material_detail_id                      = p_t_fab_rec.material_detail_id, --���BOM������ϸ
           t.material_spu                            = p_t_fab_rec.material_spu, --����SPU
           t.features                                = p_t_fab_rec.features, --����ͼ
           t.material_name                           = p_t_fab_rec.material_name, --��������
           t.ingredients                             = p_t_fab_rec.ingredients, --���ϳɷ�
           t.practical_door_with                     = p_t_fab_rec.practical_door_with, --ʵ���ŷ�
           t.gram_weight                             = p_t_fab_rec.gram_weight, --����
           t.material_specifications                 = p_t_fab_rec.material_specifications, --���Ϲ��
           t.color_picture                           = p_t_fab_rec.color_picture, --��ɫͼ
           t.material_color                          = p_t_fab_rec.material_color, --������ɫ
           t.preferred_net_price_of_large_good       = p_t_fab_rec.preferred_net_price_of_large_good, --��ѡ�������
           t.preferred_per_meter_price_of_large_good = p_t_fab_rec.preferred_per_meter_price_of_large_good, --��ѡ����׼�
           t.benchmark_price                         = p_t_fab_rec.benchmark_price, --��׼��
           t.sku_abutment_code                       = p_t_fab_rec.sku_abutment_code, --��Ӧ������SKU�Խ���
           t.supplier_material_name                  = p_t_fab_rec.supplier_material_name, --��Ӧ����������
           t.color_card_picture                      = p_t_fab_rec.color_card_picture, --ɫ��ͼ
           t.supplier_color                          = p_t_fab_rec.supplier_color, --��Ӧ����ɫ
           t.supplier_shades                         = p_t_fab_rec.supplier_shades, --��Ӧ��ɫ��
           t.optimization                            = p_t_fab_rec.optimization, --�Ƿ���ѡ
           t.disparity                               = p_t_fab_rec.disparity, --�ղ�
           t.supplier_large_good_quote               = p_t_fab_rec.supplier_large_good_quote, --��Ӧ�̴������
           t.supplier_large_good_net_price           = p_t_fab_rec.supplier_large_good_net_price, --��Ӧ�̴������
           t.create_id                               = p_t_fab_rec.create_id, --����ID
           t.create_time                             = p_t_fab_rec.create_time, --����ʱ��
           t.order_id                                = p_t_fab_rec.order_id, --�µ���ID
           t.order_time                              = p_t_fab_rec.order_time, --�µ�ʱ��
           t.receive_order_id                        = p_t_fab_rec.receive_order_id, --�ӵ���ID
           t.receive_order_time                      = p_t_fab_rec.receive_order_time, --�ӵ�ʱ��
           t.send_order_id                           = p_t_fab_rec.send_order_id, --������ID
           t.send_order_time                         = p_t_fab_rec.send_order_time, --������ʱ��
           t.cancel_id                               = p_t_fab_rec.cancel_id, --ȡ����ID
           t.cancel_time                             = p_t_fab_rec.cancel_time, --ȡ����ʱ��
           t.cancel_cause                            = p_t_fab_rec.cancel_cause, --ȡ����ԭ��
           t.remarks                                 = p_t_fab_rec.remarks, --��ע
           t.update_id                               = p_t_fab_rec.update_id, --����ID
           t.update_time                             = p_t_fab_rec.update_time, --����ʱ��
           t.group_key                               = p_t_fab_rec.group_key --
     WHERE t.fabric_purchase_sheet_id =
           p_t_fab_rec.fabric_purchase_sheet_id;
  END p_update_t_fabric_purchase_sheet;

  --ɾ�� T_FABRIC_PURCHASE_SHEET
  PROCEDURE p_delete_t_fabric_purchase_sheet(p_t_fab_rec t_fabric_purchase_sheet%ROWTYPE) IS
  BEGIN
    DELETE FROM t_fabric_purchase_sheet t
     WHERE t.fabric_purchase_sheet_id =
           p_t_fab_rec.fabric_purchase_sheet_id;
  END p_delete_t_fabric_purchase_sheet;

END pkg_t_fabric_purchase_sheet;
/
