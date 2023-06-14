BEGIN
DELETE from plm.examine_price t WHERE t.examine_price_id = 'HJ20230612002' AND t.relate_quotation_id = 'BJ20230612002';

DELETE FROM mrp.fabric_depart_examine_price_job t WHERE t.examine_price_id = 'HJ20230612002';

DELETE FROM plm.material_detail_examine_price t WHERE t.examine_price_id = 'HJ20230612002';

DELETE FROM mrp.fabric_material_detail_examine_price t WHERE t.examine_price_id = 'HJ20230612002';

DELETE FROM mrp.recommend_material_result t WHERE t.examine_price_id = 'HJ20230612002';

DELETE FROM mrp.fabric_material_detail_recommend_price_comparison t WHERE t.examine_price_id = 'HJ20230612002';

DELETE FROM mrp.fabric_material_detail_recommend_shop_around t WHERE t.examine_price_id = 'HJ20230612002';

DELETE FROM plm.special_craft_examine_price t WHERE t.examine_price_id = 'HJ20230612002';
END;
/
