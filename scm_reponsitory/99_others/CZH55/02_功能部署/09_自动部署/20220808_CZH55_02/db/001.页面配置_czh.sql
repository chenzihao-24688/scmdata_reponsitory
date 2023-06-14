DECLARE
  v_sql CLOB;
  v_noshow_fields VARCHAR2(1000);
  p_item_id       VARCHAR2(256);
BEGIN
  p_item_id := 'a_product_110';
  v_sql := '{DECLARE
  v_class_data_privs CLOB;
  v_sql              CLOB;
BEGIN
  v_class_data_privs := pkg_data_privs.parse_json(p_jsonstr => %data_privs_json_strs%,
                                                  p_key     => ''COL_2'');
  v_sql              := q''[WITH supp AS
 (SELECT sp.company_id, 
         sp.supplier_code,
         sp.supplier_company_name,
         province || city || county location_area,
         sp.group_name
    FROM scmdata.t_supplier_info sp
  LEFT JOIN scmdata.dic_province p
    ON p.provinceid = sp.company_province
  LEFT JOIN scmdata.dic_city c
    ON c.cityno = sp.company_city
  LEFT JOIN scmdata.dic_county dc
    ON dc.countyid = sp.company_county),
group_dict AS
 (SELECT group_dict_type, group_dict_value, group_dict_name
    FROM scmdata.sys_group_dict)
SELECT t.product_gress_id,
       t.company_id,
       t.product_gress_code product_gress_code_pr,
       t.progress_status progress_status_pr,
       t.curlink_complet_ratio,
       t.product_gress_remarks,
       t.progress_update_date,
       t.order_rise_status,
       t.order_id order_id_pr,
       cf.rela_goo_id,
       cf.style_number style_number_pr,
       cf.style_name style_name_pr,
       t.supplier_code supplier_code_pr,
       sp2.supplier_company_name supplier_company_name_pr,
       t.factory_code factory_code_pr,
       sp1.supplier_company_name factory_company_name_pr,
       (SELECT listagg(fu.company_user_name, '';'') within GROUP(ORDER BY oh.deal_follower)
          FROM scmdata.sys_company_user fu
         WHERE instr(oh.deal_follower, fu.user_id) > 0
           AND fu.company_id = oh.company_id) deal_follower,
       oh.delivery_date delivery_date_pr, --update by czh 20210527（1）生产进度表中的订单交期取下单列表的订单交期（即熊猫的交期日期）
       t.forecast_delivery_date forecast_delivery_date_pr,
       ceil(t.forecast_delivery_date - oh.delivery_date) forecast_delay_day_pr,
       MAX(od.delivery_date) over(PARTITION BY od.order_id) latest_planned_delivery_date_pr, --update by czh 20210527（2）生产进度表中的”最新计划完成日期“字段名更改为“最新计划交期”，取下单列表中的最新计划交期（即熊猫的新交货日期）
       t.plan_delivery_date,
       t.actual_delivery_date actual_delivery_date_pr,
       t.actual_delay_day actual_delay_day_pr,
       t.order_amount order_amount_pr,
       t.delivery_amount delivery_amount_pr,
       decode(sign(t.order_amount - t.delivery_amount),
              -1,
              0,
              t.order_amount - t.delivery_amount) owe_amount_pr,
       t.delay_problem_class delay_problem_class_pr,
       t.delay_cause_class delay_cause_class_pr,
       t.delay_cause_detailed delay_cause_detailed_pr,
       t.is_sup_responsible,
       t.responsible_dept first_dept_id,
       sd.dept_name responsible_dept,
       t.responsible_dept_sec,
       t.problem_desc problem_desc_pr,
       t.approve_edition, --Edit by zc
       cf.is_set_fabric,
       t.fabric_check fabric_check,
       t.check_link,
       t.qc_check qc_check_pr,
       t.qa_check qa_check_pr,
       decode(t.exception_handle_status,
              ''01'',
              ''处理中'',
              ''02'',
              ''已处理'',
              ''无异常'') exception_handle_status_pr,
       gd_d.group_dict_name handle_opinions_pr,
       w.picture,
       t.goo_id goo_id_pr, --这里goo_id是货号
       t.goo_id,
       --20220720 增加是否首单 修改人：lsl167
       (case when oh.isfirstordered  = 1 then ''是'' when oh.isfirstordered = 0 then ''否'' end) IS_FIRST_ORDER,
       --end
       decode(oh.send_by_sup, 1, ''是'', ''否'') send_by_sup,
       oh.create_time create_time_po,
       oh.memo memo_po,
       sp1.location_area,       
       sp1.group_name,
       cf.category category_code,
       a.group_dict_name category,
       b.group_dict_name cooperation_product_cate_sp,
       c.company_dict_name product_subclass_desc,
       oh.finish_time,
       t.update_company_id,
       ucu.company_user_name update_id_pr,
       t.update_time update_date_pr,
       CASE
         WHEN (t.actual_delay_day > 0 OR
              (t.actual_delay_day = 0 AND
              trunc(SYSDATE) - trunc(oh.delivery_date) > 0 AND
              (t.delivery_amount / t.order_amount) <= CASE
                WHEN cf.category = ''07'' THEN
                 0.86
                WHEN cf.category = ''06'' THEN
                 0.92
                ELSE
                 0.80
              END)) AND t.delay_problem_class IS NULL THEN
          10090495
         ELSE
          NULL
       END gridbackcolor
  FROM scmdata.t_ordered oh
 INNER JOIN scmdata.t_orders od
    ON oh.company_id = od.company_id
   AND oh.order_code = od.order_id
   AND oh.order_status = ''OS01'' --待修改
   AND oh.is_product_order = 1
 INNER JOIN t_production_progress t
    ON t.company_id = od.company_id
   AND t.order_id = od.order_id
   AND t.goo_id = od.goo_id
   AND t.progress_status <> ''01''
 INNER JOIN scmdata.t_commodity_info cf
    ON t.company_id = cf.company_id
   AND t.goo_id = cf.goo_id
  LEFT JOIN scmdata.t_commodity_picture w
    ON cf.goo_id = w.goo_id
   AND cf.company_id = w.company_id
  LEFT JOIN supp sp1
    ON t.company_id = sp1.company_id
   AND t.factory_code = sp1.supplier_code
 INNER JOIN supp sp2
    ON t.company_id = sp2.company_id
   AND t.supplier_code = sp2.supplier_code
  LEFT JOIN group_dict a
    ON a.group_dict_type = ''PRODUCT_TYPE''
   AND a.group_dict_value = cf.category
  LEFT JOIN group_dict b
    ON b.group_dict_type = a.group_dict_value
   AND b.group_dict_value = cf.product_cate
  LEFT JOIN scmdata.sys_company_dict c
    ON c.company_dict_type = b.group_dict_value
   AND c.company_dict_value = cf.samll_category
   AND c.company_id = %default_company_id%
  LEFT JOIN scmdata.sys_company_dept sd
    ON sd.company_id = t.company_id
   AND sd.company_dept_id = t.responsible_dept
  LEFT JOIN group_dict gd_d
    ON gd_d.group_dict_type = ''HANDLE_RESULT''
   AND gd_d.group_dict_value = t.handle_opinions
  LEFT JOIN scmdata.sys_company_user ucu
    ON ucu.company_id = t.update_company_id
   AND ucu.user_id = t.update_id
 WHERE oh.company_id = %default_company_id%
   AND ((%is_company_admin%) = 1 OR
       instr_priv(p_str1  => '']'' ||
                        v_class_data_privs || q''['',
                   p_str2  => cf.category,
                   p_split => '';'') > 0)
 ORDER BY t.product_gress_code DESC, t.create_time DESC
]'';

  @strresult := v_sql;
END;}';
  v_noshow_fields := 'PRODUCT_GRESS_ID,FABRIC_CHECK,COMPANY_ID,SUPPLIER_CODE_PR,FACTORY_CODE_PR,ORDER_ID_PR,QC_CHECK_PR,QA_CHECK_PR,APPROVE_EDITION,CHECK_LINK,CATEGORY_CODE,FIRST_DEPT_ID,RESPONSIBLE_DEPT_SEC,GOO_ID_PR,PROGRESS_STATUS_PR,ORDER_RISE_STATUS,UPDATE_COMPANY_ID,UPDATE_ID_PR,UPDATE_DATE_PR,GROUP_NAME';
  
  UPDATE bw3.sys_item_list t
     SET t.select_sql = v_sql, t.noshow_fields = v_noshow_fields
   WHERE t.item_id = p_item_id;
END;
/
DECLARE
  v_sql CLOB;
  v_noshow_fields VARCHAR2(1000);
  p_item_id       VARCHAR2(256);
BEGIN
  p_item_id := 'a_product_116';
  v_sql := '{DECLARE
  v_class_data_privs CLOB;
  v_sql              CLOB;
BEGIN
  v_class_data_privs := pkg_data_privs.parse_json(p_jsonstr => %data_privs_json_strs%,
                                                  p_key     => ''COL_2'');
  v_sql              := q''[WITH supp AS
 (SELECT sp.company_id, 
         sp.supplier_code,
         sp.supplier_company_name,
         province || city || county location_area,
         sp.group_name
    FROM scmdata.t_supplier_info sp
  LEFT JOIN scmdata.dic_province p
    ON p.provinceid = sp.company_province
  LEFT JOIN scmdata.dic_city c
    ON c.cityno = sp.company_city
  LEFT JOIN scmdata.dic_county dc
    ON dc.countyid = sp.company_county),
group_dict AS
 (SELECT group_dict_type, group_dict_value, group_dict_name
    FROM scmdata.sys_group_dict)
SELECT t.product_gress_id,
       t.company_id,
       t.product_gress_code product_gress_code_pr,
       t.progress_status progress_status_pr,
       a.group_dict_name progress_status_desc,
       t.curlink_complet_ratio,
       t.product_gress_remarks,
       t.progress_update_date,
       t.order_rise_status,
       t.order_id order_id_pr,
       cf.rela_goo_id,
       cf.style_number style_number_pr,
       cf.style_name style_name_pr,
       t.supplier_code supplier_code_pr,
       sp2.supplier_company_name supplier_company_name_pr,
       t.factory_code factory_code_pr,
       sp1.supplier_company_name factory_company_name_pr,
       (SELECT listagg(fu.company_user_name, '';'') within GROUP(ORDER BY oh.deal_follower)
          FROM scmdata.sys_company_user fu
         WHERE instr(oh.deal_follower, fu.user_id) > 0
           AND fu.company_id = oh.company_id) deal_follower,
       oh.delivery_date delivery_date_pr, --update by czh 20210527（1）生产进度表中的订单交期取下单列表的订单交期（即熊猫的交期日期）
       oh.finish_time_scm finish_time_scm_pr,
       t.forecast_delivery_date forecast_delivery_date_pr,
       ceil(t.forecast_delivery_date - oh.delivery_date) forecast_delay_day_pr,
       MAX(od.delivery_date) over(PARTITION BY od.order_id) latest_planned_delivery_date_pr, --update by czh 20210527（2）生产进度表中的”最新计划完成日期“字段名更改为“最新计划交期”，取下单列表中的最新计划交期（即熊猫的新交货日期）
       t.plan_delivery_date,
       t.actual_delivery_date actual_delivery_date_pr,
       t.actual_delay_day actual_delay_day_pr,
       t.order_amount order_amount_pr,
       t.delivery_amount delivery_amount_pr,
       decode(sign(t.order_amount - t.delivery_amount),
              -1,
              0,
              t.order_amount - t.delivery_amount) owe_amount_pr,
       t.delay_problem_class delay_problem_class_pr,
       t.delay_cause_class delay_cause_class_pr,
       t.delay_cause_detailed delay_cause_detailed_pr,
       t.is_sup_responsible,
       t.responsible_dept first_dept_id,
       t.responsible_dept_sec,
       t.problem_desc problem_desc_pr,
       t.approve_edition, --Edit by zc
       cf.is_set_fabric,
       t.fabric_check fabric_check,
       t.check_link,
       t.qc_check qc_check_pr,
       t.qa_check qa_check_pr,
       decode(t.exception_handle_status,
              ''01'',
              ''处理中'',
              ''02'',
              ''已处理'',
              ''无异常'') exception_handle_status_pr,
       gd_d.group_dict_name handle_opinions_pr,
       w.picture,
       t.goo_id goo_id_pr,
       t.goo_id,
       --20220720 增加是否首单 修改人：lsl167
       (case when oh.isfirstordered  = 1 then ''是'' when oh.isfirstordered = 0 then ''否'' end) IS_FIRST_ORDER,
       --end
       decode(oh.send_by_sup, 1, ''是'', ''否'') send_by_sup,
       decode(oh.is_product_order, 1, ''是'', ''否'') is_product_order,
       oh.create_time create_time_po,
       oh.memo memo_po,
       oh.area_locatioin LOCATION_AREA,       
       oh.area_group_id GROUP_NAME,    
       cf.category category_code,
       c.group_dict_name category,
       d.group_dict_name cooperation_product_cate_sp,
       e.company_dict_name product_subclass_desc,
       oh.finish_time,
       oh.finish_time_scm,
       su.nick_name finish_id_pr,
       decode(oh.finish_type, ''01'', ''自动结束'', ''手动结束'') finish_type,
       t.update_company_id,
       ucu.company_user_name update_id_pr,
       t.update_time update_date_pr
  FROM scmdata.t_ordered oh
 INNER JOIN scmdata.t_orders od
    ON oh.company_id = od.company_id
   AND oh.order_code = od.order_id
   AND oh.order_status IN (''OS01'', ''OS02'') --待修改
 INNER JOIN t_production_progress t
    ON t.company_id = od.company_id
   AND t.order_id = od.order_id
   AND t.goo_id = od.goo_id
   AND t.progress_status = ''01''
 INNER JOIN group_dict a
    ON a.group_dict_type = ''PROGRESS_TYPE''
   AND a.group_dict_value = t.progress_status
 INNER JOIN scmdata.t_commodity_info cf
    ON t.company_id = cf.company_id
   AND t.goo_id = cf.goo_id
  LEFT JOIN scmdata.t_commodity_picture w
    ON cf.goo_id = w.goo_id
   AND cf.company_id = w.company_id
  LEFT JOIN supp sp1
    ON t.company_id = sp1.company_id
   AND t.factory_code = sp1.supplier_code
 INNER JOIN supp sp2
    ON t.company_id = sp2.company_id
   AND t.supplier_code = sp2.supplier_code
  LEFT JOIN scmdata.sys_user su
    ON su.user_id = oh.finish_id
  LEFT JOIN group_dict c
    ON c.group_dict_type = ''PRODUCT_TYPE''
   AND c.group_dict_value = cf.category
  LEFT JOIN group_dict d
    ON d.group_dict_type = c.group_dict_value
   AND d.group_dict_value = cf.product_cate
  LEFT JOIN scmdata.sys_company_dict e
    ON e.company_dict_type = d.group_dict_value
   AND e.company_dict_value = cf.samll_category
   AND e.company_id = %default_company_id%
  LEFT JOIN group_dict gd_d
    ON gd_d.group_dict_type = ''HANDLE_RESULT''
   AND gd_d.group_dict_value = t.handle_opinions
  LEFT JOIN scmdata.sys_company_user ucu
    ON ucu.company_id = t.update_company_id
   AND ucu.user_id = t.update_id
 WHERE oh.company_id = %default_company_id%
   AND ((%is_company_admin%) = 1 OR
       instr_priv(p_str1  => '']'' ||
                        v_class_data_privs || q''['',
                   p_str2  => cf.category,
                   p_split => '';'') > 0)
 ORDER BY t.product_gress_code DESC, oh.finish_time_scm DESC
]'';
  @strresult         := v_sql;
END;
}';
  v_noshow_fields := 'PRODUCT_GRESS_ID,FABRIC_CHECK,COMPANY_ID,SUPPLIER_CODE_PR,FACTORY_CODE_PR,ORDER_ID_PR,PROGRESS_STATUS_PR,QC_CHECK_PR,QA_CHECK_PR,APPROVE_EDITION,IS_SUP_RESPONSIBLE,FIRST_DEPT_ID,RESPONSIBLE_DEPT_SEC,CHECK_LINK,CATEGORY_CODE,GOO_ID_PR,ORDER_RISE_STATUS,UPDATE_COMPANY_ID,UPDATE_ID_PR,UPDATE_DATE_PR,GROUP_NAME';
  
  UPDATE bw3.sys_item_list t
     SET t.select_sql = v_sql, t.noshow_fields = v_noshow_fields
   WHERE t.item_id = p_item_id;
END;
/
DECLARE
  v_sql CLOB;
  v_noshow_fields VARCHAR2(1000);
  p_item_id       VARCHAR2(256);
BEGIN
  p_item_id := 'a_product_150';
  v_sql := '{DECLARE
  v_class_data_privs CLOB;
  v_sql              CLOB;
BEGIN
  v_class_data_privs := pkg_data_privs.parse_json(p_jsonstr => %data_privs_json_strs%,
                                                  p_key     => ''COL_2'');
  v_sql              := q''[WITH supp AS
 (SELECT sp.company_id, 
         sp.supplier_code,
         sp.supplier_company_name,
         province || city || county location_area,
         sp.group_name
    FROM scmdata.t_supplier_info sp
  LEFT JOIN scmdata.dic_province p
    ON p.provinceid = sp.company_province
  LEFT JOIN scmdata.dic_city c
    ON c.cityno = sp.company_city
  LEFT JOIN scmdata.dic_county dc
    ON dc.countyid = sp.company_county),
group_dict AS
 (SELECT group_dict_type, group_dict_value, group_dict_name
    FROM scmdata.sys_group_dict)
SELECT t.product_gress_id,
       t.company_id,
       t.product_gress_code product_gress_code_pr,
       t.order_rise_status,
       t.order_id order_id_pr,
       cf.rela_goo_id,
       cf.style_number style_number_pr,
       cf.style_name style_name_pr,
       t.supplier_code supplier_code_pr,
       sp2.supplier_company_name supplier_company_name_pr,
       t.factory_code factory_code_pr,
       sp1.supplier_company_name factory_company_name_pr,
       (SELECT listagg(fu.company_user_name, '';'') within GROUP(ORDER BY oh.deal_follower)
          FROM scmdata.sys_company_user fu
         WHERE instr(oh.deal_follower, fu.user_id) > 0
           AND fu.company_id = oh.company_id) deal_follower,
       oh.delivery_date delivery_date_pr, --update by czh 20210527（1）生产进度表中的订单交期取下单列表的订单交期（即熊猫的交期日期）
       MAX(od.delivery_date) over(PARTITION BY od.order_id) latest_planned_delivery_date_pr, --update by czh 20210527（2）生产进度表中的”最新计划完成日期“字段名更改为“最新计划交期”，取下单列表中的最新计划交期（即熊猫的新交货日期）
       t.plan_delivery_date,
       t.forecast_delivery_date forecast_delivery_date_pr,
       ceil(t.forecast_delivery_date - oh.delivery_date) forecast_delay_day_pr,
       t.actual_delivery_date actual_delivery_date_pr,
       t.actual_delay_day actual_delay_day_pr,
       t.order_amount order_amount_pr,
       t.delivery_amount delivery_amount_pr,
       decode(sign(t.order_amount - t.delivery_amount),
              -1,
              0,
              t.order_amount - t.delivery_amount) owe_amount_pr,
       t.delay_problem_class delay_problem_class_pr,
       t.delay_cause_class delay_cause_class_pr,
       t.delay_cause_detailed delay_cause_detailed_pr,
       t.is_sup_responsible,
       t.responsible_dept first_dept_id,
       sd.dept_name responsible_dept,
       t.responsible_dept_sec,
       t.problem_desc problem_desc_pr,
       t.approve_edition, --Edit by zc
       cf.is_set_fabric,
       t.fabric_check fabric_check,
       t.check_link,
       t.qc_check qc_check_pr,
       t.qa_check qa_check_pr,
       decode(t.exception_handle_status,
              ''01'',
              ''处理中'',
              ''02'',
              ''已处理'',
              ''无异常'') exception_handle_status_pr,
       gd_d.group_dict_name handle_opinions_pr,
       w.picture,
       t.goo_id goo_id_pr, --这里goo_id是货号
       t.goo_id,
       --20220720 增加是否首单 修改人：lsl167
       (case when oh.isfirstordered  = 1 then ''是'' when oh.isfirstordered = 0 then ''否'' end) IS_FIRST_ORDER,
       --end
       decode(oh.send_by_sup, 1, ''是'', ''否'') send_by_sup,
       oh.create_time create_time_po,
       oh.memo memo_po,
       sp1.location_area,       
       sp1.group_name,      
       cf.category category_code,
       a.group_dict_name category,
       b.group_dict_name cooperation_product_cate_sp,
       c.company_dict_name product_subclass_desc,
       oh.finish_time,
       t.update_company_id,
       ucu.company_user_name update_id_pr,
       t.update_time update_date_pr,
       CASE
         WHEN (t.actual_delay_day > 0 OR
              (t.actual_delay_day = 0 AND
              trunc(SYSDATE) - trunc(oh.delivery_date) > 0 AND
              (t.delivery_amount / t.order_amount) <= CASE
                WHEN cf.category = ''07'' THEN
                 0.86
                WHEN cf.category = ''06'' THEN
                 0.92
                ELSE
                 0.80
              END)) AND t.delay_problem_class IS NULL THEN
          10090495
         ELSE
          NULL
       END gridbackcolor
  FROM scmdata.t_ordered oh
 INNER JOIN scmdata.t_orders od
    ON oh.company_id = od.company_id
   AND oh.order_code = od.order_id
   AND oh.order_status = ''OS01'' --待修改
   AND oh.is_product_order = 0
 INNER JOIN t_production_progress t
    ON t.company_id = od.company_id
   AND t.order_id = od.order_id
   AND t.goo_id = od.goo_id
   AND t.progress_status <> ''01''
 INNER JOIN scmdata.t_commodity_info cf
    ON t.company_id = cf.company_id
   AND t.goo_id = cf.goo_id
  LEFT JOIN scmdata.t_commodity_picture w
    ON cf.goo_id = w.goo_id
   AND cf.company_id = w.company_id
  LEFT JOIN supp sp1
    ON t.company_id = sp1.company_id
   AND t.factory_code = sp1.supplier_code
 INNER JOIN supp sp2
    ON t.company_id = sp2.company_id
   AND t.supplier_code = sp2.supplier_code
  LEFT JOIN group_dict a
    ON a.group_dict_type = ''PRODUCT_TYPE''
   AND a.group_dict_value = cf.category
  LEFT JOIN group_dict b
    ON b.group_dict_type = a.group_dict_value
   AND b.group_dict_value = cf.product_cate
  LEFT JOIN scmdata.sys_company_dict c
    ON c.company_dict_type = b.group_dict_value
   AND c.company_dict_value = cf.samll_category
   AND c.company_id = %default_company_id%
  LEFT JOIN scmdata.sys_company_dept sd
    ON sd.company_id = t.company_id
   AND sd.company_dept_id = t.responsible_dept
  LEFT JOIN group_dict gd_d
    ON gd_d.group_dict_type = ''HANDLE_RESULT''
   AND gd_d.group_dict_value = t.handle_opinions
  LEFT JOIN scmdata.sys_company_user ucu
    ON ucu.company_id = t.update_company_id
   AND ucu.user_id = t.update_id
 WHERE oh.company_id = %default_company_id%
   AND ((%is_company_admin%) = 1 OR
       instr_priv(p_str1  => '']'' ||
                        v_class_data_privs ||
                        q''['',
                   p_str2  => cf.category,
                   p_split => '';'') > 0)
 ORDER BY t.product_gress_code DESC, t.create_time DESC
]'';

  @strresult := v_sql;
END;}';
  v_noshow_fields := 'PRODUCT_GRESS_ID,FABRIC_CHECK,COMPANY_ID,SUPPLIER_CODE_PR,FACTORY_CODE_PR,ORDER_ID_PR,PROGRESS_STATUS_PR,QC_CHECK_PR,QA_CHECK_PR,APPROVE_EDITION,CHECK_LINK,CATEGORY_CODE,FIRST_DEPT_ID,RESPONSIBLE_DEPT_SEC,PRODUCT_GRESS_REMARKS,PROGRESS_STATUS_DESC,IS_SET_FABRIC,FABRIC_CHECK_PR,LAST_CHECK_LINK_DESC,QC_CHECK_PR,QA_CHECK_PR,EXCEPTION_HANDLE_STATUS_PR,HANDLE_OPINIONS_PR,GOO_ID_PR,ORDER_RISE_STATUS,UPDATE_COMPANY_ID,UPDATE_ID_PR,UPDATE_DATE_PR,GROUP_NAME';
  
  UPDATE bw3.sys_item_list t
     SET t.select_sql = v_sql, t.noshow_fields = v_noshow_fields
   WHERE t.item_id = p_item_id;
END;
/
DECLARE
  v_sql CLOB;
  v_sql2 CLOB;
  v_noshow_fields VARCHAR2(1000);
  p_item_id       VARCHAR2(256);
BEGIN
  p_item_id := 'a_report_120';
  v_sql := 'WITH company_user AS
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
           AND fu_b.COMPANY_ID = %DEFAULT_COMPANY_ID%
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
       pt.goo_id_pr
  FROM scmdata.pt_ordered pt
 LEFT JOIN company_user fu_e
  ON fu_e.company_id = pt.company_id
  AND fu_e.user_id = pt.area_gp_leader
  /*LEFT JOIN scmdata.sys_company_dept sd
    ON sd.company_id = pt.company_id
   AND sd.company_dept_id = pt.responsible_dept*/
 WHERE pt.company_id = %default_company_id%
   AND ((%is_company_admin% = 1) OR
       instr_priv(p_str1  => pkg_data_privs.parse_json(p_jsonstr => %data_privs_json_strs%,p_key => ''COL_2''),
                   p_str2  => pt.category,
                   p_split => '';'') > 0)
 ORDER BY pt.year DESC, pt.month DESC';
 
  v_sql2 := '--dyy153 220715 修改分岗位编辑字段
{DECLARE
  V_UPD_SQL CLOB;
BEGIN
  V_UPD_SQL := SCMDATA.PKG_PT_ORDERED.F_UPD_PTORDERED(V_USERID => %CURRENT_USERID%,
                                                 V_COMPID => %DEFAULT_COMPANY_ID%);

  @STRRESULT := V_UPD_SQL;
END;
}


/*DECLARE
  v_is_sup_exemption  NUMBER;
  v_first_dept_id     VARCHAR2(100);
  v_second_dept_id    VARCHAR2(100);
  v_is_quality        NUMBER;
  v_flag              NUMBER;
  v_order_finish_time date;
  v_delivery_date     date;
 v_dept_name varchar2(100);
BEGIN

  SELECT t.order_finish_time, t.delivery_date
    INTO v_order_finish_time, v_delivery_date
    FROM scmdata.pt_ordered t
   WHERE t.pt_ordered_id = :pt_ordered_id;
  if to_char(v_delivery_date, ''yyyy-mm'') <>
     nvl(scmdata.pkg_db_job.f_get_month(trunc(sysdate,''mm'')),to_char(sysdate,''yyyy-mm'')) then
    raise_application_error(-20002, ''保存失败！数据已封存，不可修改。'');
  end if;
  IF v_order_finish_time is null then
    raise_application_error(-20002,
                            ''保存失败！订单未结束不可修改，请到生产进度表修改。'');
  end if;
  --增加校验逻辑：延期问题分类、延期原因分类、延期原因细分有值，则问题描述必填
  IF :delay_problem_class_pr IS NOT NULL AND
     :delay_cause_class_pr IS NOT NULL AND
     :delay_cause_detailed_pr IS NOT NULL THEN
    IF :problem_desc_pr IS NULL THEN
      raise_application_error(-20002,
                              ''提示：延期问题分类、延期原因分类、延期原因细分有值，则问题描述必填！'');
      ELSIF :responsible_dept_sec is null then
           raise_application_error(-20002,
                                  ''保存失败！延期原因已填写，责任部门(2)级不能为空，请检查。'');
        ELSE
      SELECT max(ad.is_sup_exemption),
             max(ad.first_dept_id),
             max(ad.second_dept_id),
             max(ad.is_quality_problem)
        INTO v_is_sup_exemption,
             v_first_dept_id,
             v_second_dept_id,
             v_is_quality
        FROM scmdata.t_commodity_info tc
       INNER JOIN scmdata.t_abnormal_range_config ar
          ON tc.company_id = ar.company_id
         AND tc.category = ar.industry_classification
         AND tc.product_cate = ar.production_category
         AND instr('';'' || ar.product_subclass || '';'',
                   '';'' || tc.samll_category || '';'') > 0
         AND ar.pause = 0
       INNER JOIN scmdata.t_abnormal_dtl_config ad
          ON ar.company_id = ad.company_id
         AND ar.abnormal_config_id = ad.abnormal_config_id
         AND ad.pause = 0
       INNER JOIN scmdata.t_abnormal_config ab
          ON ab.company_id = ad.company_id
         AND ab.abnormal_config_id = ad.abnormal_config_id
         AND ab.pause = 0
       WHERE tc.company_id = :company_id
         AND tc.goo_id = :goo_id_pr
         AND ad.anomaly_classification = ''AC_DATE''
         AND ad.problem_classification = :delay_problem_class_pr
         AND ad.cause_classification = :delay_cause_class_pr
         AND ad.cause_detail = :delay_cause_detailed_pr;
      select max(t.dept_name)
          into v_dept_name
          from scmdata.sys_company_dept t
         where t.company_dept_id =
               nvl(:responsible_dept_sec, v_second_dept_id);
        if v_dept_name <> ''无'' then
      SELECT COUNT(1)
        INTO v_flag
        FROM (SELECT t.company_dept_id
                FROM scmdata.sys_company_dept t
               START WITH t.company_dept_id = v_first_dept_id
              CONNECT BY PRIOR t.company_dept_id = t.parent_id)
       WHERE company_dept_id = nvl(:responsible_dept_sec, v_second_dept_id);

      IF v_flag = 0 THEN
        raise_application_error(-20002,
                                ''保存失败！责任部门(2级)必须为责任部门(1级)的下级部门，请检查！'');

       END IF;
          else
          null;
        end if;
    END IF;
  ELSE
    IF :responsible_dept_sec IS NOT NULL THEN
      raise_application_error(-20002,
                              ''保存失败！责任部门(2级)不为空时,延期问题分类、延期原因分类、延期原因细分必填！'');
    ELSE
      NULL;
    END IF;
  END IF;

  UPDATE scmdata.pt_ordered t
     SET t.delay_problem_class  = :delay_problem_class_pr,
         t.delay_cause_class    = :delay_cause_class_pr,
         t.delay_cause_detailed = :delay_cause_detailed_pr,
         t.problem_desc         = :problem_desc_pr,
         t.is_sup_duty          = v_is_sup_exemption,
         t.responsible_dept     = v_first_dept_id,
         t.responsible_dept_sec = nvl(:responsible_dept_sec,
                                      v_second_dept_id),
         t.is_quality           = v_is_quality,
         t.updated              = 1,
         t.update_id            = :user_id,
         t.update_time          = sysdate
   WHERE t.pt_ordered_id = :pt_ordered_id;

END;*/';
  v_noshow_fields := 'goo_id_pr,company_id,pt_ordered_id,company_id,order_id,first_dept_id,responsible_dept_sec,deal_follower,qc_id,GROUP_NAME';
  
  UPDATE bw3.sys_item_list t
     SET t.select_sql = v_sql, t.update_sql = v_sql2, t.noshow_fields = v_noshow_fields
   WHERE t.item_id = p_item_id;
END;
/

