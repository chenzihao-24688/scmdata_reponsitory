--”≈ªØ∫Û
WITH group_dict AS
 (SELECT * FROM scmdata.sys_group_dict),
company_dict AS
 (SELECT * FROM scmdata.sys_company_dict t),
company_user AS
 (SELECT company_id, user_id, company_user_name FROM sys_company_user)
SELECT tc.commodity_info_id,
       tc.company_id,
       gd.group_dict_name       origin,
       tc.rela_goo_id,
       tc.goo_id,
       tc.sup_style_number,
       tc.style_number,
       tc.style_name,
       gd1.group_dict_name      category_gd,
       gd2.group_dict_name      product_cate_gd,
       cd.company_dict_name     small_category_gd,
       tc.supplier_code         supplier_code_gd,
       sp.supplier_company_name sup_name_gd,
       tc.goo_name,
       tc.year,
       tc.season,
       --gd3.group_dict_name      year_gd,
       gd4.group_dict_name season_gd,
       tc.inprice,
       tc.price price_gd,
       tc.create_time,
       nvl((SELECT a.company_user_name
             FROM company_user a
            WHERE a.company_id = tc.company_id
              AND a.user_id = tc.create_id),
           tc.create_id) create_id,
       tc.update_time,
       nvl((SELECT b.company_user_name
             FROM company_user b
            WHERE b.company_id = tc.company_id
              AND b.user_id = tc.update_id),
           tc.create_id) update_id
  FROM scmdata.t_commodity_info tc
 INNER JOIN scmdata.t_supplier_info sp
    ON tc.supplier_code = sp.supplier_code
   AND tc.company_id = sp.company_id
 INNER JOIN group_dict gd
    ON gd.group_dict_type = 'ORIGIN_TYPE'
   AND tc.origin = gd.group_dict_value
 INNER JOIN group_dict gd1
    ON gd1.group_dict_type = 'PRODUCT_TYPE'
   AND gd1.group_dict_value = tc.category
 INNER JOIN group_dict gd2
    ON gd2.group_dict_type = gd1.group_dict_value
   AND gd2.group_dict_value = tc.product_cate
 INNER JOIN company_dict cd
    ON cd.company_dict_type = gd2.group_dict_value
   AND cd.company_dict_value = tc.samll_category
   AND cd.company_id = 'a972dd1ffe3b3a10e0533c281cac8fd7'
/* INNER JOIN group_dict gd3
 ON gd3.group_dict_type = 'GD_YEAR'
AND gd3.group_dict_value = tc.year*/
 INNER JOIN group_dict gd4
    ON gd4.group_dict_type = 'GD_SESON'
   AND gd4.group_dict_value = tc.season
 WHERE tc.company_id = 'a972dd1ffe3b3a10e0533c281cac8fd7'
   AND tc.pause = 0
 ORDER BY tc.create_time DESC;
SYS_COMPANY_DICT
