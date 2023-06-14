DECLARE
v_sql CLOB;
BEGIN
  v_sql := '{DECLARE
  v_sql        CLOB;
  v_data_privs VARCHAR2(2000);
BEGIN
  v_data_privs := pkg_data_privs.parse_json(p_jsonstr => %data_privs_json_strs%,
                                            p_key     => ''COL_2'');
  v_sql        := q''[WITH company_user AS
 (SELECT fu.company_id, fu.user_id, fu.company_user_name
    FROM scmdata.sys_company_user fu)
SELECT pt.pt_ordered_id,
       pt.year,
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
       gd_e.group_dict_name season,
       pt.style_name,
       pt.style_number,
       pt.flw_order deal_follower,
       (SELECT listagg(fu_a.company_user_name, '','')
          FROM company_user fu_a
         WHERE fu_a.company_id = pt.company_id
           AND instr('','' || pt.flw_order || '','', '','' || fu_a.user_id || '','') > 0) flw_order,
       (SELECT listagg(fu_c.company_user_name, '','')
          FROM company_user fu_c
         WHERE fu_c.company_id = pt.company_id
           AND instr('','' || pt.flw_order_manager || '','',
                     '','' || fu_c.user_id || '','') > 0) flw_order_manager,
       pt.qc qc_id,
       (SELECT listagg(fu_b.company_user_name, '','')
          FROM company_user fu_b
         WHERE fu_b.company_id = pt.company_id
           AND fu_b.company_id = %default_company_id%
           AND instr('','' || pt.qc || '','', '','' || fu_b.user_id || '','') > 0) qc,
       (SELECT listagg(fu_d.company_user_name, '','')
          FROM company_user fu_d
         WHERE fu_d.company_id = pt.company_id
           AND instr('','' || pt.qc_manager || '','', '','' || fu_d.user_id || '','') > 0) qc_manager,
       pt.area_locatioin location_area,
       pt.group_name,
       fu_e.company_user_name area_gp_leader,
       decode(pt.is_twenty, 1, ''是'', 0, ''否'', '''') is_twenty,
       pt.delivery_status,
       decode(pt.is_quality, 1, ''是'', 0, ''否'', '''') is_quality,
       pt.actual_delay_days,
       pt.delay_section,
       decode(pt.is_sup_duty, 1, ''是'', 0, ''否'', '''') is_sup_duty,
       pt.responsible_dept first_dept_id,
       --sd.dept_name responsible_dept,
       pt.responsible_dept_sec,
       pt.delay_problem_class delay_problem_class_pr,
       pt.delay_cause_class delay_cause_class_pr,
       pt.delay_cause_detailed delay_cause_detailed_pr,
       pt.problem_desc problem_desc_pr,
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
       pt.latest_planned_delivery_date latest_planned_delivery_date_pr,
       pt.order_create_date,
       pt.arrival_date,
       pt.sort_date,
       decode(pt.is_first_order, 1, ''是'', 0, ''否'', '''') is_first_order,
       decode(pt.is_product_order, 1, ''是'', 0, ''否'', '''') is_product_order,
       pt.remarks,
       pt.order_finish_time,
       pt.company_id,
       pt.goo_id_pr,
       pt.order_id
  FROM scmdata.pt_ordered pt
  LEFT JOIN company_user fu_e
    ON fu_e.company_id = pt.company_id
   AND fu_e.user_id = pt.area_gp_leader
  LEFT JOIN scmdata.sys_group_dict gd_e
    ON gd_e.group_dict_type = ''GD_SESON''
   AND gd_e.group_dict_value = pt.season
/*LEFT JOIN scmdata.sys_company_dept sd
 ON sd.company_id = pt.company_id
AND sd.company_dept_id = pt.responsible_dept*/
 WHERE pt.company_id = %default_company_id%
   AND ((%is_company_admin% = 1) OR
       instr_priv(p_str1  => '']'' || v_data_privs || q''['',
                   p_str2  => pt.category,
                   p_split => '';'') > 0)
 ORDER BY pt.year DESC, pt.month DESC]'';
  @strresult   := v_sql;
END;}';
UPDATE bw3.sys_item_list t SET t.select_sql = v_sql WHERE t.item_id = 'a_report_120'; 
END;
/
