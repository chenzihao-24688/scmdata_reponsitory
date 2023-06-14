DECLARE
 v_sql CLOB;
BEGIN
  v_sql:='SELECT  t.consumables_material_name,
        e.material_source_desc,
        t.consumables_material_consumption,
        t.consumables_material_unit,
        t.suggested_purchase_unit_price,
        t.suggested_purchase__price,
        t.consumables_material_sku,
        b.supplier_abbreviation,
        d.material_specifications
FROM plm.CONSUMABLES_CONSUMPTION_DETAIL t
LEFT JOIN mrp.mrp_internal_supplier_material a ON material_sku = t.consumables_material_sku
LEFT JOIN mrp.mrp_determine_supplier_archives b ON a.supplier_code = b.supplier_code
LEFT JOIN mrp.mrp_internal_material_sku c ON c.material_sku = t.consumables_material_sku
LEFT JOIN mrp.mrp_internal_material_spu d ON d.material_spu = c.material_spu
LEFT JOIN (select 1 consumables_material_source,''三福指定'' material_source_desc from dual
union all
select 0 consumables_material_source,''自行采购'' material_source_desc from dual) e ON t.consumables_material_source=e.consumables_material_source
WHERE quotation_id =:quotation_id ';
  UPDATE bw3.sys_file_template_table t SET t.form_sql=v_sql WHERE t.element_id='word_a_quotation_210_1' AND t.table_name='CONSUM_MATERIAL_INFO';
END;
/
