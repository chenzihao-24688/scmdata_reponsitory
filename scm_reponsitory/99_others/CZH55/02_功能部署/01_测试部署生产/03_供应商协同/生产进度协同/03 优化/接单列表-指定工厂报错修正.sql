declare
v_sql clob;
begin
  v_sql := 'DECLARE
  v_org_fac_code VARCHAR2(32);
BEGIN
  FOR i IN (SELECT a.order_id, a.company_id,a.supplier_code
              FROM scmdata.t_ordered a
             INNER JOIN (SELECT b.company_id, c.company_name, b.supplier_code
                          FROM scmdata.t_supplier_info b
                         INNER JOIN scmdata.sys_company c
                            ON b.company_id = c.company_id
                         WHERE b.supplier_company_id = %default_company_id%) d
                ON a.company_id = d.company_id
               AND a.supplier_code = d.supplier_code
             WHERE instr(:order_id, a.order_id) > 0) LOOP

    SELECT MAX(new_designate_factory)
      INTO v_org_fac_code
      FROM (SELECT t.new_designate_factory
              FROM scmdata.t_order_log t
             WHERE order_id = i.order_id
               AND company_id = i.company_id
             ORDER BY t.operate_time DESC)
     WHERE rownum = 1;

    --czh add 日志记录 begin
    pkg_supp_order_coor.p_insert_order_log(p_company_id            => i.company_id,
                                           p_order_id              => i.order_id,
                                           p_log_type              => ''修改信息-指定工厂'',
                                           p_old_designate_factory => NVL(v_org_fac_code,i.supplier_code),
                                           p_new_designate_factory => :factory_code,
                                           p_operator              => ''SUPP'',
                                           p_operate_person        => :user_id);
    --end

    UPDATE scmdata.t_orders
       SET factory_code = :factory_code
     WHERE (order_id, company_id) IN
           (SELECT order_code, company_id
              FROM scmdata.t_ordered
             WHERE company_id = i.company_id
               AND regexp_count(order_id || '','', i.order_id || '','') > 0);

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

    UPDATE scmdata.t_ordered
       SET update_id = %current_userid%, update_time = SYSDATE
     WHERE regexp_count(order_id || '','', i.order_id || '','') > 0
       AND company_id = i.company_id;

  END LOOP;
END;';
  update bw3.sys_item_list t set t.update_sql = v_sql where t.item_id = 'a_order_201_0';
end;
