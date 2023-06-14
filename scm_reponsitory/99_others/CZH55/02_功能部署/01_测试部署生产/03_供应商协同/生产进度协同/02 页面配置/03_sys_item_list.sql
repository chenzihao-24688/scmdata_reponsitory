declare
v_sql1 clob;
begin
  v_sql1 := 'WITH supp AS
 (SELECT sp.company_id, sp.supplier_code, sp.supplier_company_name
    FROM scmdata.t_supplier_info sp),
group_dict AS
 (SELECT group_dict_type, group_dict_value, group_dict_name
    FROM scmdata.sys_group_dict)
SELECT t.product_gress_id, 
       t.company_id,
       t.progress_status progress_status_pr,
       t.product_gress_code product_gress_code_pr,
       decode(t.progress_status,
              ''02'',
              pno.pno_status,
              ''00'',
              gd_b.group_dict_name) progress_status_desc,      
       t.order_id order_id_pr,
       cf.rela_goo_id,
       cf.style_number style_number_pr,
       cf.style_name style_name_pr,
       t.supplier_code supplier_code_pr,
       d.company_name customer,
       t.factory_code factory_code_pr,
       sp1.supplier_company_name factory_company_name_pr,
       listagg(cu.nick_name, '';'') over(PARTITION BY oh.order_id) deal_follower,
       oh.delivery_date delivery_date_pr, --update by czh 20210527（1）生产进度表中的订单交期取下单列表的订单交期（即熊猫的交期日期）
       t.forecast_delivery_date forecast_delivery_date_pr,
       decode(sign(ceil(t.forecast_delivery_date - oh.delivery_date)),
              -1,
              0,
              ceil(t.forecast_delivery_date - oh.delivery_date)) forecast_delay_day_pr,
       MAX(od.delivery_date) over(PARTITION BY od.order_id) latest_planned_delivery_date_pr, --update by czh 20210527（2）生产进度表中的”最新计划完成日期“字段名更改为“最新计划交期”，取下单列表中的最新计划交期（即熊猫的新交货日期）
       t.actual_delivery_date actual_delivery_date_pr,
       t.actual_delay_day actual_delay_day_pr,
       t.order_amount order_amount_pr,
       t.delivery_amount delivery_amount_pr,
       decode(sign(t.order_amount - t.delivery_amount),
              -1,
              0,
              t.order_amount - t.delivery_amount) owe_amount_pr,
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
       t.goo_id goo_id_pr, --这里goo_id是货号
       decode(oh.send_by_sup, 1, ''是'', ''否'') send_by_sup,
       oh.create_time create_time_po,
       oh.memo memo_po,
       a.group_dict_name category,
       b.group_dict_name cooperation_product_cate_sp,
       c.company_dict_name product_subclass_desc,
       oh.finish_time
  FROM scmdata.t_ordered oh
 INNER JOIN (SELECT c.company_id, c.company_name, b.supplier_code
               FROM scmdata.t_supplier_info b
              INNER JOIN scmdata.sys_company c
                 ON b.company_id = c.company_id
              WHERE b.supplier_company_id = %default_company_id%) d
    ON oh.company_id = d.company_id
   AND oh.supplier_code = d.supplier_code
 INNER JOIN scmdata.t_orders od
    ON oh.company_id = od.company_id
   AND oh.order_code = od.order_id
  AND oh.order_status = ''OS01''
 INNER JOIN t_production_progress t
    ON t.company_id = od.company_id
   AND t.order_id = od.order_id
   AND t.goo_id = od.goo_id 
   AND t.progress_status <> ''01''
 INNER JOIN scmdata.t_commodity_info cf
    ON t.company_id = cf.company_id
   AND t.goo_id = cf.goo_id 
   --AND (''1'' = nvl(@GOO_ID_PR@,1) OR cf.rela_goo_id = @GOO_ID_PR@)
  LEFT JOIN supp sp1
    ON t.company_id = sp1.company_id
   AND t.factory_code = sp1.supplier_code
  LEFT JOIN group_dict a
    ON a.group_dict_type = ''PRODUCT_TYPE''
   AND a.group_dict_value = cf.category
  LEFT JOIN group_dict b
    ON b.group_dict_type = a.group_dict_value
   AND b.group_dict_value = cf.product_cate
  LEFT JOIN scmdata.sys_company_dict c
    ON c.company_dict_type = b.group_dict_value
   AND c.company_dict_value = cf.samll_category
   AND c.company_id = cf.company_id
  LEFT JOIN (SELECT pno_status, product_gress_id, company_id
               FROM (SELECT row_number() over(PARTITION BY pn.product_gress_id ORDER BY pn.node_num DESC) rn,
                            pn.node_name || gd_a.group_dict_name pno_status,
                            pn.product_gress_id,
                            pn.company_id
                       FROM scmdata.t_production_node pn
                      INNER JOIN group_dict gd_a
                         ON gd_a.group_dict_type = ''PROGRESS_NODE_TYPE''
                        AND gd_a.group_dict_value = pn.progress_status
                      WHERE pn.progress_status IS NOT NULL)
              WHERE rn = 1) pno
    ON pno.product_gress_id = t.product_gress_id
   AND pno.company_id = t.company_id
  LEFT JOIN group_dict gd_b
    ON gd_b.group_dict_type = ''PROGRESS_TYPE''
   AND gd_b.group_dict_value = t.progress_status
  LEFT JOIN group_dict gd_d
    ON gd_d.group_dict_type = ''HANDLE_RESULT''
   AND gd_d.group_dict_value = t.handle_opinions
  LEFT JOIN sys_company_user cu
    ON oh.company_id = cu.company_id
   AND instr(oh.deal_follower, cu.user_id) > 0
 WHERE ((%is_company_admin%) = 1 OR
       instr_priv(p_str1  => @subsql@,
                   p_str2  => cf.category,
                   p_split => '';'') > 0)       
 ORDER BY t.product_gress_code DESC, t.create_time DESC';

insert into bw3.sys_item_list (ITEM_ID, QUERY_TYPE, QUERY_FIELDS, QUERY_COUNT, EDIT_EXPRESS, NEWID_SQL, SELECT_SQL, DETAIL_SQL, SUBSELECT_SQL, INSERT_SQL, UPDATE_SQL, DELETE_SQL, NOSHOW_FIELDS, NOADD_FIELDS, NOMODIFY_FIELDS, NOEDIT_FIELDS, SUBNOSHOW_FIELDS, UI_TMPL, MULTI_PAGE_FLAG, OUTPUT_PARAMETER, LOCK_SQL, MONITOR_ID, END_FIELD, EXECUTE_TIME, SCANNABLE_FIELD, SCANNABLE_TYPE, AUTO_REFRESH, RFID_FLAG, SCANNABLE_TIME, MAX_ROW_COUNT, NOSHOW_APP_FIELDS, SCANNABLE_LOCATION_LINE, SUB_TABLE_JUDGE_FIELD, BACK_GROUND_ID, OPRETION_HINT, SUB_EDIT_STATE, HINT_TYPE, HEADER, FOOTER, JUMP_FIELD, JUMP_EXPRESS, OPEN_MODE, OPERATION_TYPE, OPERATE_TYPE, PAGE_SIZES)
values ('a_product_210', 13, 'product_gress_code_pr,rela_goo_id,customer,style_number_pr', null, null, null, v_sql1, null, '{declare
v_class_data_privs clob;
begin
 v_class_data_privs := pkg_data_privs.parse_json(p_jsonstr => %data_privs_json_strs%,p_key => ''COL_2'');
 @strresult :=''(SELECT * FROM (SELECT '' || '''''''' || v_class_data_privs || '''''''' || '' FROM dual))'';
end;}', null, null, null, 'product_gress_id,fabric_check,company_id,supplier_code_pr,factory_code_pr,order_id_pr,progress_status_pr,qc_check_pr,qa_check_pr,approve_edition,is_sup_responsible,responsible_dept,responsible_dept_sec,check_link', null, null, null, null, null, 1, null, null, null, null, null, null, null, 1, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, 0, '20,30,50,100,200,500');

end;
/
declare
v_sql clob;
begin
  v_sql := 'DECLARE
  pno_rec scmdata.t_production_node%ROWTYPE;
BEGIN
  pno_rec.product_node_id        := :product_node_id;
  pno_rec.company_id             := :company_id;
  pno_rec.product_gress_id       := :product_gress_id;
  pno_rec.product_node_code      := :product_node_code;
  pno_rec.node_num               := :node_num;
  pno_rec.node_name              := :node_name_pr;
  pno_rec.plan_start_time        := :plan_start_time_pr;
  pno_rec.actual_start_time      := :actual_start_time_pr;
  pno_rec.plan_completion_time   := :plan_completion_time_pr;
  pno_rec.actual_completion_time := :actual_completion_time_pr;
  pno_rec.complete_amount        := :complete_amount_pr;
  pno_rec.progress_status        := :product_node_status_pr;
  pno_rec.progress_say           := :progress_say_pr;
  pno_rec.update_id              := :user_id;
  pno_rec.update_date            := SYSDATE;

  SELECT fc.logn_name
    INTO pno_rec.operator
    FROM scmdata.sys_company fc
   WHERE fc.company_id = %default_company_id%;

  scmdata.pkg_production_progress.update_production_node(pno_rec => pno_rec);

END;';
insert into bw3.sys_item_list (ITEM_ID, QUERY_TYPE, QUERY_FIELDS, QUERY_COUNT, EDIT_EXPRESS, NEWID_SQL, SELECT_SQL, DETAIL_SQL, SUBSELECT_SQL, INSERT_SQL, UPDATE_SQL, DELETE_SQL, NOSHOW_FIELDS, NOADD_FIELDS, NOMODIFY_FIELDS, NOEDIT_FIELDS, SUBNOSHOW_FIELDS, UI_TMPL, MULTI_PAGE_FLAG, OUTPUT_PARAMETER, LOCK_SQL, MONITOR_ID, END_FIELD, EXECUTE_TIME, SCANNABLE_FIELD, SCANNABLE_TYPE, AUTO_REFRESH, RFID_FLAG, SCANNABLE_TIME, MAX_ROW_COUNT, NOSHOW_APP_FIELDS, SCANNABLE_LOCATION_LINE, SUB_TABLE_JUDGE_FIELD, BACK_GROUND_ID, OPRETION_HINT, SUB_EDIT_STATE, HINT_TYPE, HEADER, FOOTER, JUMP_FIELD, JUMP_EXPRESS, OPEN_MODE, OPERATION_TYPE, OPERATE_TYPE, PAGE_SIZES)
values ('a_product_211', 2, 'NODE_NAME_PR', null, 'PROGRESS_STATUS_PR!=''01''', null, '--czh add 20211209_v0
{DECLARE
  v_sql CLOB;
BEGIN
  v_sql      := pkg_supp_order_coor.f_query_progress_node_list(p_item_id => ''a_product_211''); 
  @strresult := v_sql;
END;}', null, null, null, v_sql, null, 'product_node_id,company_id,product_gress_id,product_node_code,node_num,product_node_status,PROGRESS_STATUS_PR', null, null, null, null, null, 1, null, null, null, null, null, null, null, 4, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, 0, '20,30,50,100,200,500');
end;
/
declare
begin
insert into bw3.sys_item_list (ITEM_ID, QUERY_TYPE, QUERY_FIELDS, QUERY_COUNT, EDIT_EXPRESS, NEWID_SQL, SELECT_SQL, DETAIL_SQL, SUBSELECT_SQL, INSERT_SQL, UPDATE_SQL, DELETE_SQL, NOSHOW_FIELDS, NOADD_FIELDS, NOMODIFY_FIELDS, NOEDIT_FIELDS, SUBNOSHOW_FIELDS, UI_TMPL, MULTI_PAGE_FLAG, OUTPUT_PARAMETER, LOCK_SQL, MONITOR_ID, END_FIELD, EXECUTE_TIME, SCANNABLE_FIELD, SCANNABLE_TYPE, AUTO_REFRESH, RFID_FLAG, SCANNABLE_TIME, MAX_ROW_COUNT, NOSHOW_APP_FIELDS, SCANNABLE_LOCATION_LINE, SUB_TABLE_JUDGE_FIELD, BACK_GROUND_ID, OPRETION_HINT, SUB_EDIT_STATE, HINT_TYPE, HEADER, FOOTER, JUMP_FIELD, JUMP_EXPRESS, OPEN_MODE, OPERATION_TYPE, OPERATE_TYPE, PAGE_SIZES)
values ('a_product_213', 0, null, null, null, null, 'SELECT t.node_tmp_id,
       t.company_id,
       t.order_company_id,
       t.node_name,
       t.plan_completion_time   plan_completion_time_pr,
       t.actual_completion_time actual_completion_time_pr,
       t.complete_amount        complete_amount_pr,
       t.progress_status        progress_status_pr,
       t.progress_say           progress_say_pr,
       t.product_gress_code     product_gress_code_pr,
       t.operator,
       t.update_id,
       t.update_date,
       t.create_id,
       t.create_time
  FROM scmdata.t_node_tmp t
 WHERE t.company_id = %default_company_id%
   AND t.create_id = :user_id
 ORDER BY t.node_num ASC', null, null, null, 'UPDATE scmdata.t_node_tmp t
   SET t.plan_completion_time   = :plan_completion_time_pr,
       t.actual_completion_time = :actual_completion_time_pr,
       t.complete_amount        = :complete_amount_pr,
       t.progress_status        = :progress_status_pr,
       t.progress_say           = :progress_say_pr,
       t.update_id              = :user_id,
       t.update_date            = SYSDATE,
       t.memo                   = ''''
 WHERE t.company_id = %default_company_id%
   AND t.create_id = :user_id
   AND t.node_tmp_id = :node_tmp_id', null, 'node_tmp_id,company_id,order_company_id', null, null, null, null, null, 1, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, 0, '20,30,50,100,200,500');
end;
/
declare
v_sql clob;
begin
  v_sql := 'WITH supp AS
 (SELECT sp.company_id, sp.supplier_code, sp.supplier_company_name
    FROM scmdata.t_supplier_info sp),
group_dict AS
 (SELECT group_dict_type, group_dict_value, group_dict_name
    FROM scmdata.sys_group_dict)
SELECT t.product_gress_id,
       t.company_id,
       t.progress_status progress_status_pr,
       t.product_gress_code product_gress_code_pr,
       a.group_dict_name progress_status_desc,
       t.order_id order_id_pr,
       cf.rela_goo_id,
       cf.style_number style_number_pr,
       cf.style_name style_name_pr,
       t.supplier_code supplier_code_pr,
       sp2.supplier_company_name supplier_company_name_pr,
       t.factory_code factory_code_pr,
       sp1.supplier_company_name factory_company_name_pr,
       oh.delivery_date delivery_date_pr,
       oh.finish_time_scm finish_time_scm_pr,
       t.forecast_delivery_date forecast_delivery_date_pr,
       decode(sign(ceil(t.forecast_delivery_date - oh.delivery_date)),
              -1,
              0,
              ceil(t.forecast_delivery_date - oh.delivery_date)) forecast_delay_day_pr,
       MAX(od.delivery_date) over(PARTITION BY od.order_id) latest_planned_delivery_date_pr,
       t.actual_delivery_date actual_delivery_date_pr,
       t.actual_delay_day actual_delay_day_pr,
       t.order_amount order_amount_pr,
       t.delivery_amount delivery_amount_pr,
       decode(sign(t.order_amount - t.delivery_amount),
              -1,
              0,
              t.order_amount - t.delivery_amount) owe_amount_pr,
       t.approve_edition,
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
       gd.group_dict_name handle_opinions_pr,
       t.goo_id goo_id_pr,
       oh.create_time create_time_po,
       oh.memo memo_po,
       c.group_dict_name category,
       d.group_dict_name cooperation_product_cate_sp,
       e.company_dict_name product_subclass_desc,
       oh.finish_time
  FROM scmdata.t_ordered oh
 INNER JOIN (SELECT c.company_id, c.company_name, b.supplier_code
               FROM scmdata.t_supplier_info b
              INNER JOIN scmdata.sys_company c
                 ON b.company_id = c.company_id
              WHERE b.supplier_company_id = %default_company_id%) d
    ON oh.company_id = d.company_id
   AND oh.supplier_code = d.supplier_code
 INNER JOIN scmdata.t_orders od
    ON oh.company_id = od.company_id
   AND oh.order_code = od.order_id
   AND oh.order_status IN (''OS01'', ''OS02'')
 INNER JOIN t_production_progress t
    ON t.company_id = od.company_id
   AND t.order_id = od.order_id
   AND t.goo_id = od.goo_id
   AND t.progress_status = ''01''
 INNER JOIN scmdata.t_commodity_info cf
    ON t.company_id = cf.company_id
   AND t.goo_id = cf.goo_id
  --AND (''1'' = nvl(@GOO_ID_PR@,1) OR cf.rela_goo_id = @GOO_ID_PR@)
 INNER JOIN group_dict a
    ON a.group_dict_value = t.progress_status
 INNER JOIN group_dict b
    ON b.group_dict_value = a.group_dict_type
   AND b.group_dict_value = ''PROGRESS_TYPE''
 LEFT JOIN supp sp1
    ON t.company_id = sp1.company_id
   AND t.factory_code = sp1.supplier_code
 INNER JOIN supp sp2
    ON t.company_id = sp2.company_id
   AND t.supplier_code = sp2.supplier_code
  LEFT JOIN group_dict c
    ON c.group_dict_type = ''PRODUCT_TYPE''
   AND c.group_dict_value = cf.category
  LEFT JOIN group_dict d
    ON d.group_dict_type = c.group_dict_value
   AND d.group_dict_value = cf.product_cate
  LEFT JOIN scmdata.sys_company_dict e
    ON e.company_dict_type = d.group_dict_value
   AND e.company_dict_value = cf.samll_category
   AND e.company_id = cf.company_id
  LEFT JOIN group_dict gd
    ON gd.group_dict_type = ''HANDLE_RESULT''
   AND gd.group_dict_value = t.handle_opinions
 WHERE ((%is_company_admin%) = 1 OR
       instr(%coop_class_priv%, cf.category) > 0)
 ORDER BY t.product_gress_code DESC, oh.finish_time_scm DESC';
insert into bw3.sys_item_list (ITEM_ID, QUERY_TYPE, QUERY_FIELDS, QUERY_COUNT, EDIT_EXPRESS, NEWID_SQL, SELECT_SQL, DETAIL_SQL, SUBSELECT_SQL, INSERT_SQL, UPDATE_SQL, DELETE_SQL, NOSHOW_FIELDS, NOADD_FIELDS, NOMODIFY_FIELDS, NOEDIT_FIELDS, SUBNOSHOW_FIELDS, UI_TMPL, MULTI_PAGE_FLAG, OUTPUT_PARAMETER, LOCK_SQL, MONITOR_ID, END_FIELD, EXECUTE_TIME, SCANNABLE_FIELD, SCANNABLE_TYPE, AUTO_REFRESH, RFID_FLAG, SCANNABLE_TIME, MAX_ROW_COUNT, NOSHOW_APP_FIELDS, SCANNABLE_LOCATION_LINE, SUB_TABLE_JUDGE_FIELD, BACK_GROUND_ID, OPRETION_HINT, SUB_EDIT_STATE, HINT_TYPE, HEADER, FOOTER, JUMP_FIELD, JUMP_EXPRESS, OPEN_MODE, OPERATION_TYPE, OPERATE_TYPE, PAGE_SIZES)
values ('a_product_216', 13, 'product_gress_code_pr,rela_goo_id,customer,style_number_pr', null, null, null, v_sql, null, '{declare
v_class_data_privs clob;
begin
 v_class_data_privs := pkg_data_privs.parse_json(p_jsonstr => %data_privs_json_strs%,p_key => ''COL_2'');
 @strresult :=''(SELECT * FROM (SELECT '' || '''''''' || v_class_data_privs || '''''''' || '' FROM dual))'';
end;}', null, null, null, 'product_gress_id,fabric_check,product_gress_id,company_id,supplier_code_pr,factory_code_pr,order_id_pr,progress_status_pr,qc_check_pr,qa_check_pr,approve_edition,check_link', null, null, null, null, null, 1, null, null, null, null, null, null, null, 1, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, 0, '20,30,50,100,200,500');
end;
