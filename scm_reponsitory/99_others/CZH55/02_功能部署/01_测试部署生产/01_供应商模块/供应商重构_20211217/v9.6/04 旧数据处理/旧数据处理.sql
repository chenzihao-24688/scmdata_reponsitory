--alter table scmdata.t_coop_factory modify factory_code null;
--/
DELETE FROM scmdata.t_coop_factory WHERE 1 = 1;
/
--本厂 放入合作工厂中；
DECLARE v_fac_rec scmdata.t_coop_factory%ROWTYPE;
BEGIN
  FOR i IN (SELECT a.company_id,
                   a.supplier_info_id,
                   a.supplier_code,
                   a.supplier_company_name
              FROM scmdata.t_supplier_info a
             WHERE a.company_id = 'b6cc680ad0f599cde0531164a8c0337f'
               AND a.status = 1) LOOP
    v_fac_rec.coop_factory_id  := scmdata.f_get_uuid();
    v_fac_rec.company_id       := i.company_id;
    v_fac_rec.factory_code     := i.supplier_code;
    v_fac_rec.fac_sup_info_id  := i.supplier_info_id;
    v_fac_rec.factory_name     := i.supplier_company_name;
    v_fac_rec.factory_type     := '00'; --本厂
    v_fac_rec.pause            := 0; --默认启用
    v_fac_rec.create_id        := 'ADMIN';
    v_fac_rec.create_time      := SYSDATE;
    v_fac_rec.update_id        := 'ADMIN';
    v_fac_rec.update_time      := SYSDATE;
    v_fac_rec.supplier_info_id := i.supplier_info_id;
    scmdata.pkg_supplier_info.p_insert_coop_factory(p_fac_rec => v_fac_rec);
  END LOOP;
END;
/
--取合作范围-“指定”供应商对应的外协厂放入合作工厂中；
DECLARE v_fac_rec scmdata.t_coop_factory%ROWTYPE;
BEGIN
  FOR i IN (SELECT DISTINCT a.company_id,
                            a.supplier_company_name fac_name,
                            a.supplier_code         fac_code,
                            a.supplier_info_id      fac_id,
                            d.supplier_code         sup_code,
                            d.supplier_info_id      sup_id
              FROM scmdata.t_supplier_info a
             INNER JOIN scmdata.t_coop_scope b
                ON a.supplier_info_id = b.supplier_info_id
               AND a.company_id = b.company_id
               AND b.sharing_type = '02'
             INNER JOIN scmdata.t_supplier_shared c
                ON b.coop_scope_id = c.coop_scope_id
               AND b.company_id = c.company_id
             INNER JOIN scmdata.t_supplier_info d
                ON c.company_id = d.company_id
               AND c.shared_supplier_code = d.supplier_code
             WHERE a.company_id = 'b6cc680ad0f599cde0531164a8c0337f') LOOP
  
    v_fac_rec.coop_factory_id  := scmdata.f_get_uuid();
    v_fac_rec.company_id       := i.company_id;
    v_fac_rec.supplier_info_id := i.sup_id;
    v_fac_rec.fac_sup_info_id  := i.fac_id;
    v_fac_rec.factory_code     := i.fac_code;
    v_fac_rec.factory_name     := i.fac_name;
    v_fac_rec.factory_type     := '01'; --外协厂
    v_fac_rec.pause            := 0; --默认启用
    v_fac_rec.create_id        := 'ADMIN';
    v_fac_rec.create_time      := SYSDATE;
    v_fac_rec.update_id        := 'ADMIN';
    v_fac_rec.update_time      := SYSDATE;
  
    scmdata.pkg_supplier_info.p_insert_coop_factory(p_fac_rec => v_fac_rec);
  
  END LOOP;
END;
