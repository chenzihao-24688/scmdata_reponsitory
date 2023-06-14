DECLARE
v_sql CLOB;
BEGIN
v_sql := '{DECLARE
  v_sql CLOB;
BEGIN
  v_sql      := q''[DECLARE
  p_quota_rec  plm.quotation%ROWTYPE;
  v_sup_id     VARCHAR2(32);
  v_company_id VARCHAR2(32) := ''b6cc680ad0f599cde0531164a8c0337f'';
BEGIN
  --未报价
  --主表
  p_quota_rec.quotation_id                := plm.pkg_plat_comm.f_get_keycode(v_table_name  => ''QUOTATION'',
                                                                             v_column_name => ''QUOTATION_ID'',
                                                                             v_pre         => ''BJ'' ||
                                                                                              to_char(SYSDATE,
                                                                                                      ''YYYYMMDD''),
                                                                             v_serail_num  => 3);
  p_quota_rec.quotation_status            := 0;
  p_quota_rec.item_no                     := :item_no;
  p_quota_rec.sanfu_article_no            := :sanfu_article_no;
  p_quota_rec.bag_paper_lattice_number    := :bag_paper_lattice_number;
  p_quota_rec.quotation_classification    := :quotation_classification;
  p_quota_rec.color                       := :color_qt;
  p_quota_rec.final_quotation             := :final_quotation;
  p_quota_rec.whether_add_color_quotation := 0;
  p_quota_rec.cooperation_mode            := ''ODM'';
  p_quota_rec.quotation_source            := ''供应商报价'';
  p_quota_rec.create_time                 := SYSDATE;
  p_quota_rec.create_id                   := :user_id;
  p_quota_rec.update_time                 := SYSDATE;
  p_quota_rec.update_id                   := :user_id;

  SELECT MAX(t.supplier_info_id)
    INTO v_sup_id
    FROM scmdata.t_supplier_info t
   WHERE t.company_id = v_company_id
     AND t.supplier_company_id = %default_company_id%;

  p_quota_rec.platform_unique_key := v_sup_id;

  --0.校验数据
  plm.pkg_quotation.p_check_quotation(p_company_id => v_company_id,
                                      p_quota_rec  => p_quota_rec);
  --1.生成报价单
  plm.pkg_quotation.p_insert_quotation(p_quota_rec => p_quota_rec);
  --2.耗材明细
  DECLARE
    p_consu_rec                    plm.consumables_consumption_detail%ROWTYPE;
    v_consumables_name_id          VARCHAR2(32);
    v_sup_code                     VARCHAR2(32);
    v_consumables_combination_no   VARCHAR2(256);
    v_consumables_combination_name VARCHAR2(256);
    v_consumables_total_amount     NUMBER;
    v_flag                         INT;
  BEGIN
    --通过报价分类校验耗材BOM库是否有耗材明细
    --有，则生成耗材明细
    v_flag := plm.pkg_quotation.f_check_is_exist_material_details(p_quotation_classification => :quotation_classification);

    IF v_flag > 0 THEN
      FOR consu_rec IN (SELECT cbd.consumable_name,
                               cbd.unit,
                               cbd.consumption,
                               cbd.suggest_purchase_unit_price,
                               cbd.suggest_purchase_price,
                               cbd.material_sku
                          FROM plm.relate_quotation_classification_mapping rq
                         INNER JOIN plm.consumable_bom cb
                            ON cb.consumable_combination_id = rq.thirdpart_id
                           AND cb.consumable_status = 1
                         INNER JOIN plm.consumable_bom_details cbd
                            ON cbd.consumable_combination_id = cb.consumable_combination_id
                         WHERE rq.quotation_classification_id = :quotation_classification
                           AND rq.relate_type = 1) LOOP
        v_consumables_name_id                        := plm.pkg_plat_comm.f_get_keycode(v_table_name  => ''CONSUMABLES_CONSUMPTION_DETAIL'',
                                                                                        v_column_name => ''CONSUMABLES_NAME_ID'',
                                                                                        v_pre         => p_quota_rec.quotation_id || ''HC'',
                                                                                        v_serail_num  => 2);
        p_consu_rec.consumables_name_id              := v_consumables_name_id;
        p_consu_rec.consumables_material_no          := :consumables_material_no;
        p_consu_rec.consumables_material_name        := consu_rec.consumable_name;
        p_consu_rec.consumables_material_source := CASE
                                                     WHEN consu_rec.material_sku IS NULL THEN
                                                      0
                                                     ELSE
                                                      1
                                                   END; --三福指定
        p_consu_rec.consumables_material_consumption := consu_rec.consumption;
        p_consu_rec.consumables_material_unit        := consu_rec.unit;
        p_consu_rec.suggested_purchase_unit_price    := consu_rec.suggest_purchase_unit_price;
        p_consu_rec.consumables_material_sku         := consu_rec.material_sku;

        plm.pkg_quotation.p_get_mrp_internal_sup_info(p_material_sku => consu_rec.material_sku,
                                                      po_sup_code    => v_sup_code);

        p_consu_rec.consumables_material_supplier_code := v_sup_code;
        p_consu_rec.suggested_purchase__price          := consu_rec.suggest_purchase_price;
        p_consu_rec.quotation_id                       := p_quota_rec.quotation_id;
        p_consu_rec.create_time                        := SYSDATE;
        p_consu_rec.create_id                          := :user_id;
        p_consu_rec.update_time                        := SYSDATE;
        p_consu_rec.update_id                          := :user_id;

        pkg_quotation.p_insert_consumables_consumption_detail(p_consu_rec => p_consu_rec);

      END LOOP;
      --更新报价单
      p_quota_rec.consumables_quotation_classification := :quotation_classification;

      SELECT MAX(cb.consumable_combination_id),
             MAX(cb.consumable_combination_name)
        INTO v_consumables_combination_no, v_consumables_combination_name
        FROM plm.relate_quotation_classification_mapping rq
       INNER JOIN plm.consumable_bom cb
          ON cb.consumable_combination_id = rq.thirdpart_id
       WHERE rq.quotation_classification_id = :quotation_classification;

      p_quota_rec.consumables_combination_no   := v_consumables_combination_no;
      p_quota_rec.consumables_combination_name := v_consumables_combination_name;

      SELECT SUM(cd.suggested_purchase__price)
        INTO v_consumables_total_amount
        FROM plm.consumables_consumption_detail cd
       WHERE cd.quotation_id = p_consu_rec.quotation_id;

      p_quota_rec.consumables_amount := v_consumables_total_amount;
      --p_quota_rec.consumables_quotation_remark = p_quota_rec.consumables_quotation_remark;

      p_quota_rec.update_time := SYSDATE;
      p_quota_rec.update_id   := :user_id;

      plm.pkg_quotation.p_update_quotation(p_quota_rec => p_quota_rec,
                                           p_type      => 1);
    ELSE
      NULL;
    END IF;
  END consumables_material;
  --3.包装及运费
  --判断报价分类是否是鞋子
  --是，则生成一条包装及运费
  --否，不做处理
  DECLARE
    v_quotation_class_val3 VARCHAR2(400);
    v_quotation_class_val4 VARCHAR2(400);
    v_shoe_packing_type    VARCHAR2(256);
    p_shoes_rec            plm.shoes_fee%ROWTYPE;
    v_shoe_craft_category  VARCHAR2(256);
    v_quotation_class_code VARCHAR2(256);
  BEGIN
    --获取报价分类二级
    v_quotation_class_code := plm.pkg_quotation.f_get_quotation_class_by_id(p_company_id               => v_company_id,
                                                                            p_quotation_classification => :quotation_classification,
                                                                            p_out_type                 => 2,
                                                                            p_is_name                  => 0);
    IF v_quotation_class_code IN
       (''PLM_READY_PRICE_CLASSIFICATION00010001'',
        ''PLM_READY_PRICE_CLASSIFICATION00010003'') THEN

      --鞋子工艺类别
      v_quotation_class_val3 := plm.pkg_quotation.f_get_quotation_class_by_id(p_company_id               => v_company_id,
                                                                              p_quotation_classification => :quotation_classification,
                                                                              p_out_type                 => 3,
                                                                              p_is_name                  => 1);
      IF v_quotation_class_val3 IN (''冷粘鞋'', ''硫化鞋'', ''注塑鞋'') THEN
        SELECT MAX(t.company_dict_id)
          INTO v_shoe_craft_category
          FROM scmdata.sys_company_dict t
         WHERE t.company_id = v_company_id
           AND t.company_dict_type = ''PLM_READY_SHOE_CATEGORY''
           AND t.company_dict_name = v_quotation_class_val3;
      ELSE
        NULL;
      END IF;
      --包装类型
      v_quotation_class_val4 := plm.pkg_quotation.f_get_quotation_class_by_id(p_company_id               => v_company_id,
                                                                              p_quotation_classification => :quotation_classification,
                                                                              p_out_type                 => 4,
                                                                              p_is_name                  => 0);
      IF v_quotation_class_val4 IN
         (''PLM_READY_PRICE_CLASSIFICATION0001000100010002'',
          ''PLM_READY_PRICE_CLASSIFICATION0001000100020008'',
          ''PLM_READY_PRICE_CLASSIFICATION0001000100030002'',
          ''PLM_READY_PRICE_CLASSIFICATION0001000300010002'',
          ''PLM_READY_PRICE_CLASSIFICATION0001000300020006'',
          ''PLM_READY_PRICE_CLASSIFICATION0001000300030002'') THEN
        v_shoe_packing_type := ''9025227ad3d745e5a2eb9e916c248094''; --蛋格
      ELSE
        v_shoe_packing_type := ''1def0fcc33ce4d3ba56848deb779c927''; --鞋盒
      END IF;

      p_shoes_rec.shoe_fee_id               := p_quota_rec.quotation_id;
      p_shoes_rec.shoe_craft_category       := v_shoe_craft_category;
      p_shoes_rec.shoe_packing_type         := v_shoe_packing_type;
      p_shoes_rec.shoe_packing_number       := NULL;
      p_shoes_rec.shoe_transportation_route := NULL;
      p_shoes_rec.shoe_box_material_name    := NULL;
      p_shoes_rec.shoe_box_specifications   := NULL;
      p_shoes_rec.update_time               := SYSDATE;
      p_shoes_rec.update_id                 := :user_id;
      p_shoes_rec.quotation_id              := p_quota_rec.quotation_id;
      p_shoes_rec.whether_del               := 0;
      p_shoes_rec.create_time               := SYSDATE;
      p_shoes_rec.create_id                 := :user_id;
      p_shoes_rec.is_update_field           := 0;
      plm.pkg_quotation.p_insert_shoes_fee(p_shoes_rec => p_shoes_rec);
    ELSE
      NULL;
    END IF;
  END shoes_fee;
  --4.附件
  /*DECLARE
    p_plm_f_rec plm.plm_file%ROWTYPE;
  BEGIN
    UPDATE quotation t
       SET t.style_picture = p_quota_rec.quotation_id,
           t.pattern_file  = p_quota_rec.quotation_id,
           t.marker_file   = p_quota_rec.quotation_id,
           t.update_time   = SYSDATE,
           t.update_id     = :user_id
     WHERE t.quotation_id = p_quota_rec.quotation_id;
    --款式图片
    p_plm_f_rec.file_id      := plm.pkg_plat_comm.f_get_uuid();
    p_plm_f_rec.thirdpart_id := p_quota_rec.quotation_id;
    p_plm_f_rec.file_name    := '' '';
    p_plm_f_rec.source_name  := '''';
    p_plm_f_rec.url          := '' '';
    p_plm_f_rec.bucket       := '''';
    p_plm_f_rec.upload_time  := SYSDATE;
    p_plm_f_rec.file_type    := 1;
    p_plm_f_rec.file_blob    := NULL;
    plm.pkg_quotation.p_insert_plm_file(p_plm_f_rec => p_plm_f_rec);
    --纸样文件
    p_plm_f_rec.file_id      := plm.pkg_plat_comm.f_get_uuid();
    p_plm_f_rec.thirdpart_id := p_quota_rec.quotation_id;
    p_plm_f_rec.file_name    := '' '';
    p_plm_f_rec.source_name  := '''';
    p_plm_f_rec.url          := '' '';
    p_plm_f_rec.bucket       := '''';
    p_plm_f_rec.upload_time  := SYSDATE;
    p_plm_f_rec.file_type    := 2;
    p_plm_f_rec.file_blob    := NULL;
    plm.pkg_quotation.p_insert_plm_file(p_plm_f_rec => p_plm_f_rec);
    --唛架文件
    p_plm_f_rec.file_id      := plm.pkg_plat_comm.f_get_uuid();
    p_plm_f_rec.thirdpart_id := p_quota_rec.quotation_id;
    p_plm_f_rec.file_name    := '' '';
    p_plm_f_rec.source_name  := :source_name;
    p_plm_f_rec.url          := '' '';
    p_plm_f_rec.bucket       := '''';
    p_plm_f_rec.upload_time  := SYSDATE;
    p_plm_f_rec.file_type    := 3;
    p_plm_f_rec.file_blob    := NULL;
    plm.pkg_quotation.p_insert_plm_file(p_plm_f_rec => p_plm_f_rec);
  END plm_file;*/
END;]'';
  @strresult := v_sql;
END;}';

UPDATE bw3.sys_item_list t SET t.insert_sql = v_sql WHERE t.item_id = 'a_quotation_110';
END;
/
DECLARE
v_sql CLOB;
BEGIN
v_sql := '{DECLARE
  v_quotation_id                VARCHAR2(32);
  v_rest_method                 VARCHAR2(256);
  v_params                      VARCHAR2(256);
  v_sql                         CLOB;
  v_whether_add_color_quotation VARCHAR2(1);
  v_quotation_classification    VARCHAR2(256);
  v_quotation_status            VARCHAR2(256);
BEGIN
  --获取asscoiate请求参数
  pkg_plat_comm.p_get_rest_val_method_params(p_character     => %ass_quotation_id%,
                                             po_pk_id        => v_quotation_id,
                                             po_rest_methods => v_rest_method,
                                             po_params       => v_params);

  IF instr('';'' || v_rest_method || '';'', '';'' || ''PUT'' || '';'') > 0 THEN

    v_whether_add_color_quotation := plm.pkg_plat_comm.parse_json(p_jsonstr => v_params,p_key   => ''whether_add_color_quotation'');

    v_quotation_status := plm.pkg_plat_comm.parse_json(p_jsonstr => v_params,p_key  => ''quotation_status'');

    v_quotation_classification := plm.pkg_plat_comm.parse_json(p_jsonstr => v_params,p_key  => ''quotation_classification'');

    v_sql := q''[DECLARE
    p_quota_rec plm.quotation%ROWTYPE;
    v_company_id           VARCHAR2(32) := ''b6cc680ad0f599cde0531164a8c0337f'';
  BEGIN
    --未报价
    --主表
    p_quota_rec.quotation_id                := :quotation_id;
    p_quota_rec.quotation_status            := ]'' || v_quotation_status || q''[;
    ]'' || (CASE
               WHEN v_whether_add_color_quotation = ''0'' THEN
                (CASE
                  WHEN v_quotation_status = 4 THEN
                   q''[
    p_quota_rec.color                       := :color_qt;
    p_quota_rec.consumables_quotation_remark := :consumables_quotation_remark;]''
                  ELSE
                   q''[
    p_quota_rec.color                       := :color_qt;
    p_quota_rec.item_no                     := :item_no;
    p_quota_rec.sanfu_article_no            := :sanfu_article_no;
    p_quota_rec.bag_paper_lattice_number    := :bag_paper_lattice_number;
    p_quota_rec.consumables_quotation_remark := :consumables_quotation_remark;
    --0.校验数据
    plm.pkg_quotation.p_check_bag_paper(p_company_id => v_company_id, p_quotation_class => '']'' || v_quotation_classification || q''['', p_bag_paper => :bag_paper_lattice_number);]''
                END)
               ELSE
                q''[ p_quota_rec.color                        := :color_qt;
                    p_quota_rec.consumables_quotation_remark := :consumables_quotation_remark;]''
             END) || q''[
    p_quota_rec.final_quotation             := :final_quotation;         
    p_quota_rec.whether_add_color_quotation := :whether_add_color_quotation;
    p_quota_rec.update_time                 := SYSDATE;
    p_quota_rec.update_id                   := :user_id;
    --1.更新报价单
    plm.pkg_quotation.p_update_quotation(p_quota_rec => p_quota_rec,p_type => 0);
  END;]'';
  ELSE
    v_sql := NULL;
  END IF;
  @strresult := v_sql;
END;}';
UPDATE bw3.sys_item_list t SET t.update_sql = v_sql WHERE t.item_id = 'a_quotation_111';
END;
/
BEGIN
insert into bw3.sys_field_list (FIELD_NAME, CAPTION, REQUIERED_FLAG, INPUT_HINT, VALID_CHARS, INVALID_CHARS, CHECK_EXPRESS, CHECK_MESSAGE, READ_ONLY_FLAG, NO_EDIT, NO_COPY, NO_SUM, NO_SORT, ALIGNMENT, MAX_LENGTH, MIN_LENGTH, DISPLAY_WIDTH, DISPLAY_FORMAT, EDIT_FORMT, DATA_TYPE, MAX_VALUE, MIN_VALUE, DEFAULT_VALUE, IME_CARE, IME_OPEN, VALUE_LISTS, VALUE_LIST_TYPE, HYPER_RES, MULTI_VALUE_FLAG, TRUE_EXPR, FALSE_EXPR, NAME_RULE_FLAG, NAME_RULE_ID, DATA_TYPE_FLAG, ALLOW_SCAN, VALUE_ENCRYPT, VALUE_SENSITIVE, OPERATOR_FLAG, VALUE_DISPLAY_STYLE, TO_ITEM_ID, VALUE_SENSITIVE_REPLACEMENT, STORE_SOURCE, ENABLE_STAND_PERMISSION)
values ('FINAL_QUOTATION', '最终报价', 0, null, null, null, '^([0]{1}|[1-9]{1,3}\d?)(\.\d{1,4})?$', '【最终报价】仅支持填写4位自然数，小数允许后4位', 0, 0, 0, null, 0, 0, null, null, null, null, null, '10', null, null, null, 0, 0, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);
END;
/
DECLARE
v_sql CLOB;
BEGIN
v_sql := '{DECLARE
 v_sql CLOB;
 --v_sku_info CLOB; --sku信息
 --v_supp_info CLOB; --供应商信息
 v_quotation_class_code VARCHAR2(128);  --报价分类
 v_flag NUMBER;
 v_quotation_classification VARCHAR2(128);
BEGIN



SELECT MAX(qt.quotation_classification)
    INTO v_quotation_classification
    FROM plm.quotation qt
   WHERE qt.quotation_id = :QUOTATION_ID;


  v_quotation_class_code := plm.pkg_quotation.f_get_quotation_class_by_id(p_company_id               => ''b6cc680ad0f599cde0531164a8c0337f'',
                                                                          p_quotation_classification => v_quotation_classification,
                                                                          p_out_type                 => 2,
                                                                          p_is_name                  => 0);
  --男鞋、女鞋
  IF v_quotation_class_code IN
     (''PLM_READY_PRICE_CLASSIFICATION00010001'',
      ''PLM_READY_PRICE_CLASSIFICATION00010003'') THEN V_FLAG :=1;
   ELSE
     V_FLAG:=0;
  END IF;



  v_sql :=q''[SELECT ]'' ||CASE V_FLAG WHEN 1 THEN q''[''QUOPR02'' ]'' ELSE q''[''QUOPR01'' ]'' END ||q''[ template_code,
       Z.QUOTATION_ID,
       Z.ITEM_NO,
       Z.COLOR,
       z.FINAL_QUOTATION, --czh add
       VA.QUOTATION_CLASSIFICATION_N QUO_CLASS,
       Z.SANFU_ARTICLE_NO SANFU_NO,
       Y.SUPPLIER_COMPANY_ABBREVIATION SUPP_NAME,
       (CASE Z.WHETHER_SANFU_FABRIC  WHEN 1 THEN  ''是'' ELSE ''否'' END) IS_SANFU_MA,
       (CASE Z.WHETHER_ADD_COLOR_QUOTATION WHEN 1 THEN ''是'' ELSE ''否''  END) IS_ADD_QUO,
       Z.CREATE_TIME,
       Z.RELATED_COLORED_QUOTATION RELA_QUO,
       Z.QUOTATION_SOURCE,
       Z.QUOTATION_TOTAL,
       Z.MATERIAL_AMOUNT,
       Z.CONSUMABLES_AMOUNT CONSUM_AMOUNT,
       Z.CRAFT_AMOUNT,
       Z.WORKING_PROCEDURE_AMOUNT WORKING_AMOUNT,
       Z.OTHER_AMOUNT
  FROM PLM.QUOTATION Z
 INNER JOIN SCMDATA.T_SUPPLIER_INFO Y
    ON Y.SUPPLIER_INFO_ID = Z.PLATFORM_UNIQUE_KEY
 INNER JOIN (SELECT v.quotation_classification_n1,
       v.quotation_classification_n2,
       v.quotation_classification_v2,
       v.quotation_classification quotation_classification,
       v.quotation_classification_n1 || ''/'' ||
       v.quotation_classification_n2 quotation_classification_n
  FROM (SELECT a.company_dict_name quotation_classification_n1,
               b.company_dict_value quotation_classification_v2,
               nvl2(d.company_dict_name,
                    b.company_dict_name || ''/'' || c.company_dict_name || ''/'' ||
                    d.company_dict_name,
                    nvl2(c.company_dict_name,
                         b.company_dict_name || ''/'' || c.company_dict_name,
                         b.company_dict_name)) quotation_classification_n2,
               nvl(d.company_dict_id,
                   nvl(c.company_dict_id, b.company_dict_id)) quotation_classification
          FROM scmdata.sys_company_dict a
          LEFT JOIN scmdata.sys_company_dict b
            ON b.company_dict_type = a.company_dict_value
           AND b.company_id = a.company_id
           AND a.pause = 0
           AND b.pause = 0
          LEFT JOIN scmdata.sys_company_dict c
            ON c.company_dict_type = b.company_dict_value
           AND c.company_id = b.company_id
           AND c.pause = 0
          LEFT JOIN scmdata.sys_company_dict d
            ON d.company_dict_type = c.company_dict_value
           AND d.company_id = c.company_id
           AND d.pause = 0
         WHERE a.company_dict_type = ''PLM_READY_PRICE_CLASSIFICATION''
             ) v) va
    ON va.quotation_classification = Z.quotation_classification
 WHERE Z.QUOTATION_ID = :QUOTATION_ID]'';
  @STRRESULT   := v_sql;

END;
}';
UPDATE bw3.sys_file_template t SET t.select_sql = v_sql WHERE t.element_id = 'word_a_quotation_210_1';
END;
/
