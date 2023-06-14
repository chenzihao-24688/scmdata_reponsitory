--生成商品档案数据
DECLARE
  v_good_id VARCHAR2(100);
BEGIN
  -- SELECT * FROM scmdata.t_commodity_info;

  FOR i IN (SELECT t.company_id, t.supplier_code
              FROM scmdata.t_supplier_info t
             WHERE t.supplier_code IS NOT NULL
               AND t.company_id = 'a972dd1ffe3b3a10e0533c281cac8fd7') LOOP
  
    v_good_id := scmdata.pkg_plat_comm.f_getkeycode('t_commodity_info',
                                                    'goo_id',
                                                    i.company_id,
                                                    pi_pre            => '20',
                                                    pi_serail_num     => 6);
  
    dbms_output.put_line(v_good_id);
    INSERT INTO t_commodity_info
      (sup_style_number,
       commodity_info_id,
       company_id,
       origin,
       style_pic,
       supplier_code,
       goo_id,
       rela_goo_id,
       style_name,
       style_number,
       category,
       samll_category,
       YEAR,
       season,
       base_size,
       inprice,
       price,
       color_list,
       size_list,
       create_id,
       create_time,
       update_id,
       update_time,
       remarks)
    VALUES
      ('款式编号' || i.supplier_code,
       scmdata.f_get_uuid(),
       i.company_id,
       '新增',
       'a1a14e9d2dfd5fa9b1f59a6f48e3eeb1',
       i.supplier_code,
       v_good_id,
       v_good_id,
       'style_name' || i.supplier_code,
       'style_number' || i.supplier_code,
       'category' || i.supplier_code,
       'samll_category' || i.supplier_code,
       'YEAR' || i.supplier_code,
       'season' || i.supplier_code,
       'base_size' || i.supplier_code,
       123,
       1231,
       'color_list' || i.supplier_code,
       'size_list' || i.supplier_code,
       'create_id' || i.supplier_code,
       SYSDATE,
       'update_id' || i.supplier_code,
       SYSDATE,
       '');
  
  END LOOP;
END;
