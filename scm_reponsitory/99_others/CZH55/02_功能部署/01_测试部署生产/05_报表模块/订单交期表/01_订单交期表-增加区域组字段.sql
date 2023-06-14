alter table scmdata.pt_ordered add group_name varchar2(256);
/
DECLARE
  v_sql CLOB;
BEGIN
  v_sql := 'WITH company_user AS
 (SELECT fu.company_id, fu.user_id, fu.company_user_name
    FROM scmdata.sys_company_user fu)
SELECT pt.year,
       pt.quarter,
       pt.month,
       pt.category_name,
       pt.supplier_code inside_supplier_code,
       pt.supplier_company_name,
       pt.factory_company_name factory_company_name,
       pt.product_gress_code,
       pt.goo_id rela_goo_id,
       pt.coop_product_cate_name,
       pt.product_subclass_name,
       pt.style_name,
       pt.style_number,
       (SELECT listagg(fu_a.company_user_name, '','')
          FROM company_user fu_a
         WHERE fu_a.company_id = pt.company_id
           AND instr('','' || pt.flw_order || '','', '','' || fu_a.user_id || '','') > 0) flw_order,
       (SELECT listagg(fu_c.company_user_name, '','')
          FROM company_user fu_c
         WHERE fu_c.company_id = pt.company_id
           AND instr('','' || pt.flw_order_manager || '','',
                     '','' || fu_c.user_id || '','') > 0) flw_order_manager,
       (SELECT listagg(fu_b.company_user_name, '','')
          FROM company_user fu_b
         WHERE fu_b.company_id = pt.company_id
           AND instr('','' || pt.qc || '','', '','' || fu_b.user_id || '','') > 0) qc,
       (SELECT listagg(fu_d.company_user_name, '','')
          FROM company_user fu_d
         WHERE fu_d.company_id = pt.company_id
           AND instr('','' || pt.qc_manager || '','', '','' || fu_d.user_id || '','') > 0) qc_manager,
       pt.group_name,
       fu_e.company_user_name area_gp_leader,
       decode(pt.is_twenty, 1, ''是'', 0, ''否'', '''') is_twenty,
       pt.delivery_status,
       decode(pt.is_quality, 1, ''是'', 0, ''否'', '''') is_quality,
       pt.actual_delay_days,
       pt.delay_section,
       pt.responsible_dept,
       pt.responsible_dept_sec,
       pt.delay_problem_class,
       pt.delay_cause_class,
       pt.delay_cause_detailed,
       pt.problem_desc,
       pt.purchase_price,
       pt.fixed_price,
       pt.order_amount,
       pt.est_arrival_amount,
       pt.delivery_amount pt_delivery_amount,
       pt.satisfy_amount,
       pt.order_money,
       pt.delivery_money,
       pt.satisfy_money,
       pt.delivery_date,
       pt.order_create_date,
       pt.arrival_date,
       pt.sort_date,
       decode(pt.is_first_order, 1, ''是'', 0, ''否'', '''') is_first_order,
       pt.remarks,
       pt.order_finish_time
  FROM scmdata.pt_ordered pt
 LEFT JOIN company_user fu_e
  ON fu_e.company_id = pt.company_id
  AND fu_e.user_id = pt.area_gp_leader
 WHERE pt.company_id = %default_company_id%
   AND ((%is_company_admin% = 1) OR
       instr_priv(p_str1  => pkg_data_privs.parse_json(p_jsonstr => %data_privs_json_strs%,p_key => ''COL_2''),
                   p_str2  => pt.category,
                   p_split => '';'') > 0)
 ORDER BY pt.year DESC, pt.month DESC';
  UPDATE bw3.sys_item_list t
     SET t.select_sql = v_sql
   WHERE t.item_id = 'a_report_120';
END;
/
--刷新历史数据
DECLARE p_company_id VARCHAR2(32) := 'b6cc680ad0f599cde0531164a8c0337f';
BEGIN
  FOR ptb IN (SELECT DISTINCT tc.category,
                              tc.product_cate,
                              sp_b.company_province,
                              sp_b.company_city,
                              po.company_id,
                              po.order_id
                FROM scmdata.t_ordered po
               INNER JOIN scmdata.t_orders pln
                  ON po.company_id = pln.company_id
                 AND po.order_code = pln.order_id
               INNER JOIN scmdata.t_production_progress pr
                  ON pln.company_id = pr.company_id
                 AND pln.order_id = pr.order_id
                 AND pln.goo_id = pr.goo_id
               INNER JOIN scmdata.t_commodity_info tc
                  ON pr.company_id = tc.company_id
                 AND pr.goo_id = tc.goo_id
                LEFT JOIN scmdata.t_supplier_info sp_b
                  ON sp_b.company_id = pr.company_id
                 AND sp_b.supplier_code = pr.factory_code
               WHERE po.company_id = p_company_id) LOOP
    UPDATE scmdata.pt_ordered pt
       SET pt.group_name = scmdata.pkg_kpipt_order.f_get_groupname(f_company_province => ptb.company_province,
                                                                   f_company_city     => ptb.company_city,
                                                                   f_category         => ptb.category,
                                                                   f_product_cate     => ptb.product_cate,
                                                                   f_compid           => ptb.company_id)
     WHERE pt.company_id = ptb.company_id
       AND pt.order_id = ptb.order_id;
  END LOOP;
END;

