/*SELECT * FROM t_supplier_info_ctl;
SELECT * FROM scmdata.t_supplier_base_itf;
SELECT *
  FROM scmdata.t_supplier_info t
 WHERE t.supplier_info_origin = 'II';*/


DECLARE
  v_company_id    VARCHAR2(200) := 'a972dd1ffe3b3a10e0533c281cac8fd7';
  v_table_name    VARCHAR2(100) := 't_supplier_info';
  v_column_name   VARCHAR2(100) := 'supplier_code';
  v_serail_num    NUMBER := 5; --流水号长度
  v_supplier_code VARCHAR2(100);
  c_product_type  VARCHAR2(100) := 'C';
BEGIN
  FOR v_rec IN (SELECT supplier_info_id
                  FROM scmdata.t_supplier_info t
                 WHERE t.supplier_info_origin = 'II') LOOP
  
    v_supplier_code := scmdata.pkg_plat_comm.f_getkeycode(pi_table_name  => v_table_name,
                                                          pi_column_name => v_column_name,
                                                          pi_company_id  => v_company_id,
                                                          pi_pre         => c_product_type,
                                                          pi_serail_num  => v_serail_num);
  
    UPDATE scmdata.t_supplier_info sp
       SET sp.supplier_code    = v_supplier_code,
           sp.status           = 1,
           sp.bind_status      = decode(sp.supplier_info_origin,
                                        'AA',
                                        1,
                                        'MA',
                                        0,
                                        'QC',
                                        0,
                                        0),
           sp.create_supp_date = SYSDATE,
           sp.update_id        = 'czh',
           sp.update_date      = SYSDATE
     WHERE sp.supplier_info_id = v_rec.supplier_info_id;
  
  END LOOP;
END;
