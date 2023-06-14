DECLARE
v_sql CLOB;
BEGIN
  v_sql := '{
DECLARE
  v_quotation_id                VARCHAR2(32);
  v_rest_method                 VARCHAR2(256);
  v_params                      VARCHAR2(4000);
  v_whether_add_color_quotation VARCHAR2(256);
  v_quotation_classification    VARCHAR2(256);
  v_quotation_status            VARCHAR2(256);
  v_sql                         CLOB;
  v_flag                        INT;
BEGIN
  --��ȡasscoiate�������
  pkg_plat_comm.p_get_rest_val_method_params(p_character     => %ass_quotation_id%,
                                             po_pk_id        => v_quotation_id,
                                             po_rest_methods => v_rest_method,
                                             po_params       => v_params);

  IF instr('';'' || v_rest_method || '';'', '';'' || ''POST'' || '';'') > 0 THEN
    v_whether_add_color_quotation := plm.pkg_plat_comm.parse_json(p_jsonstr => v_params,
                                                                  p_key     => ''whether_add_color_quotation'');

    v_quotation_status := plm.pkg_plat_comm.parse_json(p_jsonstr => v_params,
                                                       p_key     => ''quotation_status'');
    --�Ƿ��ɫ����Ϊ��ʱ����������
    IF v_whether_add_color_quotation = 1 THEN
      v_sql := NULL;
    ELSE
      --���۵�״̬�Ƿ����Ѵ�أ�����򲻿�����
      IF v_quotation_status = 4 THEN
        v_sql := NULL;
      ELSE
        v_quotation_classification := plm.pkg_plat_comm.parse_json(p_jsonstr => v_params,
                                                                   p_key     => ''quotation_classification'');
        --ͨ�����۷���У��Ĳ�BOM���Ƿ��кĲ���ϸ
        --v_flag := plm.pkg_quotation.f_check_is_exist_material_details(p_quotation_classification => v_quotation_classification);
        SELECT (CASE
                 WHEN t.consumables_combination_no IS NOT NULL THEN
                  1
                 ELSE
                  0
               END) vflag
          INTO v_flag
          FROM plm.quotation t
         WHERE t.quotation_id = v_quotation_id;

        --���ݷ���ֵ��ȷ���Ƿ������
        IF v_flag > 0 THEN
          --�������۵�ʱ�Զ�����Ĳ�BOM������
          v_sql := NULL;
        ELSE
          v_sql                 := q''[
DECLARE
  p_consu_rec plm.consumables_consumption_detail%ROWTYPE;
BEGIN
  p_consu_rec.consumables_name_id                := plm.pkg_plat_comm.f_get_keycode(v_table_name  => ''CONSUMABLES_CONSUMPTION_DETAIL'',
                                                                                    v_column_name => ''CONSUMABLES_NAME_ID'',
                                                                                    v_pre         => '']'' || v_quotation_id ||q''['' || ''HC'',
                                                                                    v_serail_num  => 2);
  p_consu_rec.consumables_material_name          := :consumables_material_name;
  p_consu_rec.consumables_material_consumption   := :consumables_material_consumption;
  p_consu_rec.consumables_material_unit          := :consumables_material_unit;
  p_consu_rec.suggested_purchase_unit_price      := :suggested_purchase_unit_price;
  p_consu_rec.consumables_material_sku           := :consumables_material_sku;
  p_consu_rec.consumables_material_supplier_code := :consumables_material_supplier_code;
  p_consu_rec.suggested_purchase__price          := :consumables_material_consumption * :suggested_purchase_unit_price;
  p_consu_rec.quotation_id                       := '']'' ||
                                   v_quotation_id ||
                                   q''['';
  p_consu_rec.consumables_material_source        := 0; --���вɹ�
  p_consu_rec.whether_del                        := 0;
  p_consu_rec.create_time                        := SYSDATE;
  p_consu_rec.create_id                          := :user_id;
  p_consu_rec.update_time                        := SYSDATE;
  p_consu_rec.update_id                          := :user_id;
  --0.У��
  plm.pkg_quotation.p_check_consumables_consumption_detail(p_consu_rec => p_consu_rec,p_type => 1);
  --1.�����Ĳ�������ϸ
   plm.pkg_quotation.p_insert_consumables_consumption_detail(p_consu_rec => p_consu_rec);
  --2.�޸ı��۵�-�ĲĽ��
   plm.pkg_quotation.p_cal_consumables_detail_total_amount(p_quotation_id => '']'' || v_quotation_id || q''['');
END;
]'';
        END IF;
      END IF;
    END IF;
  ELSE
    v_sql := NULL;
  END IF;
  '|| CHR(64) || 'strresult := v_sql;
END;
}';

UPDATE bw3.sys_item_list t SET t.insert_sql = v_sql WHERE t.item_id = 'a_quotation_111_2';
END;
/
