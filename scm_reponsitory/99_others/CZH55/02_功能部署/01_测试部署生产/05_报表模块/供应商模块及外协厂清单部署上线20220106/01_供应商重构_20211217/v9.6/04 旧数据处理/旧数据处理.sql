--本厂 放入合作工厂中；
DECLARE
  v_fac_rec scmdata.t_coop_factory%ROWTYPE;
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
v_factory_name VARCHAR2(256);
v_fac_sup_info_id VARCHAR2(32);
BEGIN
  FOR i IN (SELECT a.company_id, c.supplier_info_id, c.shared_supplier_code
              FROM scmdata.t_supplier_info a
             INNER JOIN scmdata.t_coop_scope b
                ON a.supplier_info_id = b.supplier_info_id
               AND a.company_id = b.company_id
               AND b.sharing_type = '02'
             INNER JOIN scmdata.t_supplier_shared c
                ON b.coop_scope_id = c.coop_scope_id
               AND b.company_id = c.company_id
             WHERE a.company_id = 'b6cc680ad0f599cde0531164a8c0337f') LOOP
    v_fac_rec.coop_factory_id := scmdata.f_get_uuid();
    v_fac_rec.company_id      := i.company_id;
    v_fac_rec.factory_code    := i.shared_supplier_code;
    SELECT MAX(sp.supplier_company_name), MAX(sp.supplier_info_id)
      INTO v_factory_name, v_fac_sup_info_id
      FROM scmdata.t_supplier_info sp
     WHERE sp.supplier_code = i.shared_supplier_code
       AND sp.company_id = i.company_id;
    v_fac_rec.fac_sup_info_id  := v_fac_sup_info_id;
    v_fac_rec.factory_name     := v_factory_name; 
    v_fac_rec.factory_type     := '01'; --外协厂
    v_fac_rec.pause            := 0; --默认启用
    v_fac_rec.create_id        := 'ADMIN';
    v_fac_rec.create_time      := SYSDATE;
    v_fac_rec.update_id        := 'ADMIN';
    v_fac_rec.update_time      := SYSDATE;
    v_fac_rec.supplier_info_id := i.supplier_info_id;
    scmdata.pkg_supplier_info.p_insert_coop_factory(p_fac_rec => v_fac_rec);
  END LOOP;
END;
