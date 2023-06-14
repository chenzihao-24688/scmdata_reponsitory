BEGIN
UPDATE bw3.sys_item_list t SET t.query_type = 3 WHERE t.item_id IN ('a_product_150');
END;
/

