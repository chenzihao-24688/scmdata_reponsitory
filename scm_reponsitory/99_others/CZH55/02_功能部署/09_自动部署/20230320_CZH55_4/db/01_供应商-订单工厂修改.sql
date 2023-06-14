DECLARE
v_sql CLOB;
BEGIN
  v_sql := 'DECLARE
  v_org_fac_code VARCHAR2(32);
BEGIN
  FOR i IN (SELECT a.order_id,
                   a.company_id,
                   a.order_code,
                   a.supplier_code,
                   ords.factory_code
              FROM scmdata.t_ordered a
             INNER JOIN (SELECT b.company_id, c.company_name, b.supplier_code
                          FROM scmdata.t_supplier_info b
                         INNER JOIN scmdata.sys_company c
                            ON b.company_id = c.company_id
                         WHERE b.supplier_company_id = %default_company_id%) d
                ON a.company_id = d.company_id
               AND a.supplier_code = d.supplier_code
             INNER JOIN scmdata.t_orders ords
                ON a.order_code = ords.order_id
               AND a.company_id = ords.company_id
             WHERE instr(:order_id, a.order_id) > 0) LOOP
  
    SELECT MAX(new_designate_factory)
      INTO v_org_fac_code
      FROM (SELECT t.new_designate_factory
              FROM scmdata.t_order_log t
             WHERE order_id = i.order_id
               AND company_id = i.company_id
             ORDER BY t.operate_time DESC)
     WHERE rownum = 1;
    UPDATE scmdata.t_ordered
       SET update_id         = %current_userid%,
           update_company_id = %default_company_id%,
           update_time       = SYSDATE
     WHERE regexp_count(order_id || '','', i.order_id || '','') > 0
       AND company_id = i.company_id;
  
    --zc314 begin
    --czh55 update IF语句
    IF scmdata.pkg_plat_comm.f_is_check_fields_eq(p_old_field => nvl(:factory_code,'' ''),
                                                  p_new_field => i.factory_code) = 0 THEN
    --end update czh55                                             
      --raw
      UPDATE scmdata.t_orders
         SET factory_code = :factory_code
       WHERE (order_id, company_id) IN
             (SELECT order_code, company_id
                FROM scmdata.t_ordered
               WHERE company_id = i.company_id
                 AND regexp_count(order_id || '','', i.order_id || '','') > 0);
    
      --入队new
      scmdata.pkg_capacity_inqueue.p_specify_ordfactory_inqueue(v_inp_ordid  => i.order_code,
                                                                v_inp_compid => i.company_id);
    END IF;
  
    --区域组，区域组长更新new
    scmdata.pkg_order_management.p_upd_ordareagroupandgroupleader(v_inp_ordid  => i.order_code,
                                                                  v_inp_compid => i.company_id);
  
    --Qc，Qc组长更新new
    scmdata.pkg_order_management.p_ordqcrela_iu_data(v_ordid  => i.order_code,
                                                     v_compid => i.company_id);
    --zc314 end
  
    UPDATE scmdata.t_production_progress
       SET factory_code = :factory_code
     WHERE (order_id, goo_id, company_id) IN
           (SELECT order_id, goo_id, company_id
              FROM scmdata.t_orders
             WHERE (order_id, company_id) IN
                   (SELECT order_id, company_id
                      FROM scmdata.t_ordered
                     WHERE company_id = i.company_id
                       AND regexp_count(order_id || '','', i.order_id || '','') > 0));
  
  END LOOP;
END;';
UPDATE bw3.sys_item_list t SET t.update_sql = v_sql WHERE t.item_id = 'a_order_201_0';
END;
/
