--区域组长批量更新导入
BEGIN
  FOR i IN (SELECT t.company_id, t.supplier_info_id
              FROM scmdata.t_supplier_info t
             WHERE t.company_id = 'b6cc680ad0f599cde0531164a8c0337f') LOOP
    pkg_supplier_info.update_group_name(p_company_id       => i.company_id,
                                        p_supplier_info_id => i.supplier_info_id);
  END LOOP;
END;
