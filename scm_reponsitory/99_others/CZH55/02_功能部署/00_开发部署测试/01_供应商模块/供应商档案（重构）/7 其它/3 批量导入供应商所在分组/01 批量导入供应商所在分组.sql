BEGIN
  FOR i IN (SELECT t.company_id, t.supplier_info_id
              FROM scmdata.t_supplier_info t
             WHERE t.company_id = 'a972dd1ffe3b3a10e0533c281cac8fd7') LOOP
    pkg_supplier_info.update_group_name(p_company_id       => i.company_id,
                                        p_supplier_info_id => i.supplier_info_id);
  END LOOP;
END;

/*UPDATE scmdata.t_supplier_info t
   SET t.area_group_leader = NULL, t.group_name = NULL
 WHERE t.company_id = 'a972dd1ffe3b3a10e0533c281cac8fd7'*/
