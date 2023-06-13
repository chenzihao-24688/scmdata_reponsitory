DECLARE
  v_year   VARCHAR2(10) := substr(to_char(SYSDATE, 'yyyy'), 3, 2);
  v_goo_id VARCHAR2(100);
BEGIN
  FOR i IN 1 .. 2 LOOP
    v_goo_id := scmdata.pkg_plat_comm.f_getkeycode(pi_table_name  => 't_commodity_info', --表名
                                                   pi_column_name => 'goo_id', --列名
                                                   pi_company_id  => 'a972dd1ffe3b3a10e0533c281cac8fd7', --公司编号
                                                   pi_pre         => v_year, --前缀
                                                   pi_serail_num  => 6);
    --dbms_output.put_line(v_goo_id);
    --商品档案
    INSERT INTO scmdata.t_commodity_info
      (commodity_info_id,
       company_id,
       origin,
       style_pic,
       supplier_code,
       rela_goo_id,
       goo_id,
       sup_style_number,
       style_number, --需校验企业级唯一
       category,
       samll_category,
       style_name,
       YEAR,
       season,
       base_size,
       inprice,
       price,
       create_time,
       create_id,
       update_time,
       update_id)
    VALUES
      (scmdata.f_get_uuid(),
       'a972dd1ffe3b3a10e0533c281cac8fd7',
       '新增',
       'aaa',
       'C0000' || i,
       'A00'||i,--熊猫过来的关联货号
       v_goo_id,
       '供应商款号' || i,
       '款号' || i,
       '男装' || i,
       '针织' || i,
       'T恤' || i,
       v_year,
       '夏' || i,
       i * 13,
       i * 14,
       '50' + i,
       SYSDATE,
       'czh',
       SYSDATE,
       'czh');
  END LOOP;

END;
/*SELECT tc.commodity_info_id,
       tc.company_id,
       tc.style_pic,
       tc.supplier_code,
       tc.style_name,
       --sp.supplier_company_abbreviation,
       tc.style_number,
       tc.sup_style_number,
       tc.goo_id,
       tc.rela_goo_id,
       tc.category,
       tc.samll_category,
       tc.year,
       tc.season,
       tc.inprice,
       tc.price,
       tc.color_list,
       tc.size_list,
       tc.base_size,
       tc.create_id,
       tc.create_time,
       tc.update_id,
       tc.update_time
  FROM scmdata.t_commodity_info tc
 INNER JOIN scmdata.t_supplier_info sp
    ON tc.supplier_code = sp.supplier_code
   AND tc.company_id = sp.company_id*/

