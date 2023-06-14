DECLARE
v_sql CLOB;
BEGIN
  v_sql := q'[  SELECT --t.quotation_special_craft_detail_id,
       --t.related_colored_detail_id,
       --t.quotation_special_craft_detail_no,
       sp.process_name craft_classification_desc,
       --t.craft_classification,
       t.craft_unit_price,
       t.craft_consumption,
       --t.washing_percent,
       t.craft_price,
       t.craft_factory_name,
       t.craft_quotation_remark
  FROM plm.special_craft_quotation t
  LEFT JOIN plm.special_process sp
    ON sp.process_id = t.craft_classification
 WHERE t.quotation_id =:quotation_id
 ORDER BY t.create_time DESC]';
UPDATE bw3.sys_item t SET t.caption_sql = '常规辅料' WHERE t.item_id = 'a_quotation_111_2'; 
UPDATE bw3.sys_field_list t SET t.caption = '常规辅料金额' WHERE t.field_name IN ('CONSUMABLES_AMOUNT','CONSUM_AMOUNT');
UPDATE bw3.sys_field_list t SET t.requiered_flag = 0 WHERE t.field_name = 'DESIGN_FEE';  
UPDATE bw3.sys_item_list t SET t.noshow_fields = 'QUOTATION_SPECIAL_CRAFT_DETAIL_ID,RELATED_COLORED_DETAIL_ID,QUOTATION_SPECIAL_CRAFT_DETAIL_NO,CRAFT_CLASSIFICATION,PROCESS_NAME_PT,WASHING_PERCENT' WHERE t.item_id = 'a_quotation_111_3'; 
UPDATE bw3.sys_file_template_table t SET t.form_sql = v_sql , t.table_colwidths = '3000,3000,3000,3000,3000,8500' WHERE t.element_id = 'word_a_quotation_210_1' AND t.table_name = 'SPECIAL_CRAFT_INFO';
END;
/
