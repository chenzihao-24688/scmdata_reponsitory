BEGIN 
insert into bw3.sys_element (ELEMENT_ID, ELEMENT_TYPE, DATA_SOURCE, PAUSE, MESSAGE, IS_HIDE, MEMO, IS_ASYNC, IS_PER_EXE, ENABLE_STAND_PERMISSION)
values ('action_a_product_150_1', 'action', 'oracle_scmdata', 0, null, null, null, null, null, null);

insert into bw3.sys_element (ELEMENT_ID, ELEMENT_TYPE, DATA_SOURCE, PAUSE, MESSAGE, IS_HIDE, MEMO, IS_ASYNC, IS_PER_EXE, ENABLE_STAND_PERMISSION)
values ('action_a_product_217_1', 'action', 'oracle_scmdata', 0, null, null, null, null, null, null);

insert into bw3.sys_action (ELEMENT_ID, CAPTION, ICON_NAME, ACTION_TYPE, ACTION_SQL, SELECT_FIELDS, REFRESH_FLAG, MULTI_PAGE_FLAG, PRE_FLAG, FILTER_EXPRESS, UPDATE_FIELDS, PORT_ID, PORT_SQL, LOCK_SQL, SELECTION_FLAG, CALL_ID, OPERATE_MODE, PORT_TYPE, QUERY_FIELDS, SELECTION_METHOD)
values ('action_a_product_150_1', '批量复制进度', 'icon-daoru', 4, 'DECLARE
  v_company_id         VARCHAR2(32) := %default_company_id%;
  v_product_gress_code VARCHAR2(100) := @product_gress_code_pr@; --输入的生产订单
BEGIN
  --需复制的生产单
  FOR nd_rec IN (SELECT p.product_gress_code, p.company_id
                   FROM scmdata.t_production_progress p
                  WHERE p.company_id = v_company_id
                    AND p.product_gress_code IN (@selection)) LOOP
  
    scmdata.pkg_production_progress_a.p_batch_copy_progress(p_company_id           => nd_rec.company_id,
                                                            p_inproduct_gress_code => v_product_gress_code,
                                                            p_ndproduct_gress_code => nd_rec.product_gress_code,
                                                            p_item_id              => ''a_product_150'',
                                                            p_user_id              => :user_id);
  END LOOP;
END;', 'PRODUCT_GRESS_CODE_PR', 1, 1, null, null, null, null, null, null, 0, null, null, 1, null, 2);

insert into bw3.sys_action (ELEMENT_ID, CAPTION, ICON_NAME, ACTION_TYPE, ACTION_SQL, SELECT_FIELDS, REFRESH_FLAG, MULTI_PAGE_FLAG, PRE_FLAG, FILTER_EXPRESS, UPDATE_FIELDS, PORT_ID, PORT_SQL, LOCK_SQL, SELECTION_FLAG, CALL_ID, OPERATE_MODE, PORT_TYPE, QUERY_FIELDS, SELECTION_METHOD)
values ('action_a_product_217_1', '批量复制进度', 'icon-daoru', 4, 'DECLARE
  v_company_id         VARCHAR2(32);
  v_product_gress_code VARCHAR2(100) := @product_gress_code_pr@; --输入的生产订单
BEGIN
  --需复制的生产单
  FOR nd_rec IN (SELECT p.product_gress_code, p.company_id
                   FROM scmdata.t_production_progress p
                  WHERE p.product_gress_id IN (@selection@)) LOOP
  
    scmdata.pkg_production_progress_a.p_batch_copy_progress(p_company_id           => nd_rec.company_id,
                                                            p_inproduct_gress_code => v_product_gress_code,
                                                            p_ndproduct_gress_code => nd_rec.product_gress_code,
                                                            p_item_id              => ''a_product_217'',
                                                            p_user_id              => :user_id);
  END LOOP;
END;', 'PRODUCT_GRESS_ID', 1, 1, null, null, null, null, null, null, 0, null, null, 1, null, 2);

insert into bw3.sys_item_element_rela (ITEM_ID, ELEMENT_ID, SEQ_NO, PAUSE, LEVEL_NO)
values ('a_product_150', 'action_a_product_150_1', 1, 0, 0);

insert into bw3.sys_item_element_rela (ITEM_ID, ELEMENT_ID, SEQ_NO, PAUSE, LEVEL_NO)
values ('a_product_217', 'action_a_product_217_1', 1, 0, null);

END;
/
DECLARE
v_sql CLOB;
BEGIN
  v_sql := 'DECLARE
  v_company_id         VARCHAR2(32) := %default_company_id%;
  v_product_gress_code VARCHAR2(100) := @product_gress_code_pr@; --输入的生产订单
BEGIN
  --需复制的生产单
  FOR nd_rec IN (SELECT p.product_gress_code, p.company_id
                   FROM scmdata.t_production_progress p
                  WHERE p.company_id = v_company_id
                    AND p.product_gress_code IN (@selection)) LOOP
  
    scmdata.pkg_production_progress_a.p_batch_copy_progress(p_company_id           => nd_rec.company_id,
                                                            p_inproduct_gress_code => v_product_gress_code,
                                                            p_ndproduct_gress_code => nd_rec.product_gress_code,
                                                            p_item_id              => ''a_product_110'',
                                                            p_user_id              => :user_id);
  END LOOP;
END;';
  UPDATE bw3.sys_action t SET t.action_sql = v_sql WHERE t.element_id = 'action_a_product_110_6';
END;
/
DECLARE
v_sql CLOB;
BEGIN
  v_sql := 'DECLARE
  v_company_id         VARCHAR2(32);
  v_product_gress_code VARCHAR2(100) := @product_gress_code_pr@; --输入的生产订单
BEGIN

  --需复制的生产单
  FOR nd_rec IN (SELECT p.product_gress_code, p.company_id
                   FROM scmdata.t_production_progress p
                  WHERE p.product_gress_id IN (@selection@)) LOOP
  
    scmdata.pkg_production_progress_a.p_batch_copy_progress(p_company_id           => nd_rec.company_id,
                                                            p_inproduct_gress_code => v_product_gress_code,
                                                            p_ndproduct_gress_code => nd_rec.product_gress_code,
                                                            p_item_id              => ''a_product_210'',
                                                            p_user_id              => :user_id);
  END LOOP;
END;';
  UPDATE bw3.sys_action t SET t.action_sql = v_sql,t.select_fields = 'PRODUCT_GRESS_ID' WHERE t.element_id = 'action_a_product_210_1';
END;
/
DECLARE
v_sql CLOB;
BEGIN
  v_sql := 'DECLARE
  p_abn_rec scmdata.t_abnormal%ROWTYPE;
BEGIN
  FOR i IN (SELECT *
              FROM scmdata.t_abnormal abn
             WHERE abn.abnormal_id IN (@selection)) LOOP
    p_abn_rec.abnormal_id          := i.abnormal_id;
    p_abn_rec.company_id           := i.company_id;
    p_abn_rec.abnormal_code        := i.abnormal_code;
    p_abn_rec.order_id             := i.order_id;
    p_abn_rec.progress_status      := i.progress_status;
    p_abn_rec.goo_id               := i.goo_id;
    p_abn_rec.anomaly_class        := i.anomaly_class;
    p_abn_rec.problem_class        := i.problem_class;
    p_abn_rec.cause_class          := i.cause_class;
    p_abn_rec.detailed_reasons     := i.detailed_reasons;
    p_abn_rec.delay_date           := i.delay_date;
    p_abn_rec.delay_amount         := i.delay_amount;
    p_abn_rec.responsible_party    := i.responsible_party;
    p_abn_rec.responsible_dept     := i.responsible_dept;
    p_abn_rec.handle_opinions      := i.handle_opinions;
    p_abn_rec.quality_deduction    := i.quality_deduction;
    p_abn_rec.is_deduction         := i.is_deduction;
    p_abn_rec.deduction_unit_price := i.deduction_unit_price;
    p_abn_rec.file_id              := i.file_id;
    p_abn_rec.applicant_id         := i.applicant_id;
    p_abn_rec.applicant_date       := i.applicant_date;
    p_abn_rec.confirm_id           := :user_id;
    p_abn_rec.confirm_company_id   := %default_company_id%;
    p_abn_rec.confirm_date         := SYSDATE;
    p_abn_rec.create_id            := i.create_id;
    p_abn_rec.create_time          := i.create_time;
    p_abn_rec.origin               := i.origin;
    p_abn_rec.origin_id            := i.origin_id;
    p_abn_rec.memo                 := i.memo;
    p_abn_rec.update_id            := i.update_id;
    p_abn_rec.update_time          := i.update_time;
    p_abn_rec.deduction_method     := i.deduction_method;
    p_abn_rec.responsible_dept_sec := i.responsible_dept_sec;
    p_abn_rec.is_sup_responsible   := i.is_sup_responsible;
    p_abn_rec.cause_detailed       := i.cause_detailed;
    p_abn_rec.abnormal_range       := i.abnormal_range;

    scmdata.pkg_production_progress.confirm_abnormal(p_abn_rec => p_abn_rec);

  END LOOP;
END;';
UPDATE bw3.sys_action t SET t.action_sql = v_sql WHERE t.element_id = 'action_a_product_120_1';
END;
/
DECLARE
v_sql CLOB;
BEGIN
  v_sql := '{DECLARE
  v_class_data_privs CLOB;
  v_sql              CLOB;
BEGIN
  v_class_data_privs := pkg_data_privs.parse_json(p_jsonstr => %data_privs_json_strs%,
                                                  p_key     => ''COL_2'');
  v_sql              := q''[WITH supp AS
 (SELECT sp.company_id, sp.supplier_code, sp.supplier_company_name
    FROM scmdata.t_supplier_info sp),
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
       d.company_name customer,
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
       t.problem_desc problem_desc_pr,
       t.is_sup_responsible,
       t.responsible_dept first_dept_id,
       t.responsible_dept_sec,
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
       decode(oh.send_by_sup, 1, ''是'', ''否'') send_by_sup,
       oh.create_time create_time_po,
       oh.memo memo_po,
       a.group_dict_name category,
       b.group_dict_name cooperation_product_cate_sp,
       c.company_dict_name product_subclass_desc,
       oh.finish_time,
       t.update_company_id,
       ucu.company_user_name update_id_pr,
       t.update_time update_date_pr
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
    ON w.goo_id = cf.goo_id
   AND w.company_id = cf.company_id
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
  LEFT JOIN group_dict gd_d
    ON gd_d.group_dict_type = ''HANDLE_RESULT''
   AND gd_d.group_dict_value = t.handle_opinions
  LEFT JOIN scmdata.sys_company_user ucu
    ON ucu.company_id = t.update_company_id
   AND ucu.user_id = t.update_id
 WHERE ((%is_company_admin%) = 1 OR
       instr_priv(p_str1  => '']''||v_class_data_privs||q''['',
                   p_str2  => cf.category,
                   p_split => '';'') > 0)
 ORDER BY t.product_gress_code DESC, t.create_time DESC
]'';
  @strresult := v_sql;
END;}';
  UPDATE bw3.sys_item_list t SET t.select_sql = v_sql WHERE t.item_id = 'a_product_210';
END;
