prompt Importing table nbw.sys_item_list...
set feedback off
set define off

insert into nbw.sys_item_list (ITEM_ID, QUERY_TYPE, QUERY_FIELDS, QUERY_COUNT, EDIT_EXPRESS, NEWID_SQL, SELECT_SQL, DETAIL_SQL, SUBSELECT_SQL, INSERT_SQL, UPDATE_SQL, DELETE_SQL, NOSHOW_FIELDS, NOADD_FIELDS, NOMODIFY_FIELDS, NOEDIT_FIELDS, SUBNOSHOW_FIELDS, UI_TMPL, MULTI_PAGE_FLAG, OUTPUT_PARAMETER, LOCK_SQL, MONITOR_ID, END_FIELD, EXECUTE_TIME, SCANNABLE_FIELD, SCANNABLE_TYPE, AUTO_REFRESH, RFID_FLAG, SCANNABLE_TIME, MAX_ROW_COUNT, NOSHOW_APP_FIELDS, SCANNABLE_LOCATION_LINE, SUB_TABLE_JUDGE_FIELD, BACK_GROUND_ID, OPRETION_HINT, SUB_EDIT_STATE, HINT_TYPE, HEADER, FOOTER, JUMP_FIELD, JUMP_EXPRESS, OPEN_MODE, OPERATION_TYPE, OPERATE_TYPE, PAGE_SIZES)
values ('a_order_101_0', 3, 'ORDER_CODE,RELA_GOO_ID,SUPPLIER,STYLE_NUMBER', null, null, null, '{DECLARE
  V_EXESQL   CLOB;
BEGIN
  V_EXESQL := SCMDATA.PKG_ORDER_MANAGEMENT.F_GET_UNFINISHEDORDER_SELSQL(V_ISCOMPADMIN => %IS_COMPANY_ADMIN%,
                                                                        V_PIRVSTR     => %DATA_PRIVS_JSON_STRS%,
                                                                        V_ISPRODORDER => ''1'',
                                                                        V_ORDSTATUS   => ''''''OS00'''',''''OS01'''''',
                                                                        V_COMPID      => %DEFAULT_COMPANY_ID%);
                                                                        
  @StrResult := V_EXESQL;
END;}', null, null, null, 'DECLARE
  V_MEMO         VARCHAR2(512);
  V_FACTORY_CODE VARCHAR2(32);
  V_ORDER_STATUS VARCHAR2(32);
BEGIN
  FOR I IN (SELECT A.ORDER_ID, A.MEMO, B.FACTORY_CODE, A.ORDER_STATUS
              FROM (SELECT ORDER_ID, ORDER_CODE, COMPANY_ID, MEMO, ORDER_STATUS
                      FROM SCMDATA.T_ORDERED
                     WHERE REGEXP_COUNT(:ORDER_ID || '','', ORDER_ID || '','') > 0) A
             INNER JOIN SCMDATA.T_ORDERS B
                ON A.ORDER_CODE = B.ORDER_ID
               AND A.COMPANY_ID = B.COMPANY_ID) LOOP
    IF :MEMO <> NVL(I.MEMO,'' '') THEN
      UPDATE SCMDATA.T_ORDERED
         SET MEMO        = :MEMO,
             UPDATE_ID   = %CURRENT_USERID%,
             UPDATE_TIME = SYSDATE
       WHERE REGEXP_COUNT(ORDER_ID || '','', I.ORDER_ID || '','') > 0
         AND COMPANY_ID = %DEFAULT_COMPANY_ID%;
    END IF;

    IF :FACTORY_CODE <> NVL(I.FACTORY_CODE,'' '') THEN
      IF I.ORDER_STATUS = ''OS02'' THEN
        RAISE_APPLICATION_ERROR(-20002, ''所选订单存在已完成订单，已完成订单不可指定工厂，请检查！'');
      END IF;

     --czh add 日志记录 begin
    /* pkg_supp_order_coor.p_insert_order_log(p_company_id            => %default_company_id%,
                                            p_order_id              => i.order_id,
                                            p_log_type              => ''修改信息-指定工厂'',
                                            p_old_designate_factory => i.factory_code,
                                            p_new_designate_factory => :factory_code,
                                            p_operator              => ''NEED'',
                                            p_operate_person        => :user_id);*/
    --end
      UPDATE SCMDATA.T_ORDERED
         SET UPDATE_ID = %CURRENT_USERID%, UPDATE_TIME = SYSDATE , update_company_id = %default_company_id%
       WHERE REGEXP_COUNT(ORDER_ID || '','', I.ORDER_ID || '','') > 0
         AND COMPANY_ID = %DEFAULT_COMPANY_ID%;

      UPDATE SCMDATA.T_ORDERS
         SET FACTORY_CODE = :FACTORY_CODE
       WHERE (ORDER_ID, COMPANY_ID) IN
             (SELECT ORDER_CODE, COMPANY_ID
                FROM SCMDATA.T_ORDERED
               WHERE COMPANY_ID = %DEFAULT_COMPANY_ID%
                 AND REGEXP_COUNT(ORDER_ID || '','', I.ORDER_ID || '','') > 0);

      UPDATE SCMDATA.T_PRODUCTION_PROGRESS
         SET FACTORY_CODE = :FACTORY_CODE
       WHERE (ORDER_ID,GOO_ID,COMPANY_ID) IN
             (SELECT ORDER_ID,GOO_ID,COMPANY_ID
                FROM SCMDATA.T_ORDERS
               WHERE (ORDER_ID,COMPANY_ID) IN
                     (SELECT ORDER_ID,COMPANY_ID
                        FROM SCMDATA.T_ORDERED
                       WHERE COMPANY_ID = %DEFAULT_COMPANY_ID%
                         AND REGEXP_COUNT(ORDER_ID || '','', I.ORDER_ID || '','') > 0));


    END IF;
  END LOOP;
END; ', null, 'ORDER_ID,ORDERS_ID,COMPANY_ID,FACTORY_CODE,ORDER_STATUS,FINISH_TIME_SCM,GOO_ID', null, null, 'MEMO', null, null, 1, null, null, null, '1', 0, null, null, 1, 0, null, 0, null, null, null, null, null, 0, 0, null, null, null, null, 0, null, 0, '20,30,50,100,200,500');

insert into nbw.sys_item_list (ITEM_ID, QUERY_TYPE, QUERY_FIELDS, QUERY_COUNT, EDIT_EXPRESS, NEWID_SQL, SELECT_SQL, DETAIL_SQL, SUBSELECT_SQL, INSERT_SQL, UPDATE_SQL, DELETE_SQL, NOSHOW_FIELDS, NOADD_FIELDS, NOMODIFY_FIELDS, NOEDIT_FIELDS, SUBNOSHOW_FIELDS, UI_TMPL, MULTI_PAGE_FLAG, OUTPUT_PARAMETER, LOCK_SQL, MONITOR_ID, END_FIELD, EXECUTE_TIME, SCANNABLE_FIELD, SCANNABLE_TYPE, AUTO_REFRESH, RFID_FLAG, SCANNABLE_TIME, MAX_ROW_COUNT, NOSHOW_APP_FIELDS, SCANNABLE_LOCATION_LINE, SUB_TABLE_JUDGE_FIELD, BACK_GROUND_ID, OPRETION_HINT, SUB_EDIT_STATE, HINT_TYPE, HEADER, FOOTER, JUMP_FIELD, JUMP_EXPRESS, OPEN_MODE, OPERATION_TYPE, OPERATE_TYPE, PAGE_SIZES)
values ('a_product_110', 3, 'PRODUCT_GRESS_CODE_PR,RELA_GOO_ID,SUPPLIER_COMPANY_NAME_PR,STYLE_NUMBER_PR', null, null, null, '{DECLARE
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
         sp.group_name,
         dv.vill
    FROM scmdata.t_supplier_info sp
  LEFT JOIN scmdata.dic_province p
    ON p.provinceid = sp.company_province
  LEFT JOIN scmdata.dic_city c
    ON c.cityno = sp.company_city
  LEFT JOIN scmdata.dic_county dc
    ON dc.countyid = sp.company_county
  LEFT JOIN scmdata.dic_village dv
    ON dv.villid = sp.company_vill),
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
       sp1.vill COMPANY_VILL_DESC,
       sp1.group_name,
       cf.category category_code,
       a.group_dict_name category,
       b.group_dict_name cooperation_product_cate_sp,
       c.company_dict_name product_subclass_desc,
       gd_e.group_dict_name season,
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
  LEFT JOIN group_dict gd_e
    ON gd_e.group_dict_type = ''GD_SESON''
   AND gd_e.group_dict_value = cf.season
 WHERE oh.company_id = %default_company_id%
   AND ((%is_company_admin%) = 1 OR
       instr_priv(p_str1  => '']'' ||
                        v_class_data_privs || q''['',
                   p_str2  => cf.category,
                   p_split => '';'') > 0)
 ORDER BY t.product_gress_code DESC, t.create_time DESC
]'';

  @strresult := v_sql;
END;}', null, null, null, 'DECLARE
  v_is_sup_exemption     NUMBER;
  v_first_dept_id        VARCHAR2(100);
  v_second_dept_id       VARCHAR2(100);
  v_is_quality           NUMBER;
  v_dept_name            VARCHAR2(100);
  v_progress_update_date DATE;
  vo_forecast_date       DATE;
  vo_forecast_days       INT;
BEGIN
  --获取进度更新日期
  --判断是否编辑过生产进度状态/当前环节完成比例/生产进度说明
  IF (((:old_progress_status_pr IS NULL AND :progress_status_pr IS NULL) OR
     (:old_progress_status_pr = ''00'' AND :progress_status_pr = ''00'')) AND
     (:old_curlink_complet_ratio IS NULL AND
     :curlink_complet_ratio IS NULL) AND (:old_product_gress_remarks IS NULL AND
     :product_gress_remarks IS NULL)) OR
     ((:old_progress_status_pr IS NOT NULL AND
     :progress_status_pr IS NOT NULL AND
     :old_progress_status_pr = :progress_status_pr) AND
     (:old_curlink_complet_ratio IS NOT NULL AND
     :curlink_complet_ratio IS NOT NULL AND
     :old_curlink_complet_ratio = :curlink_complet_ratio) AND
     (:old_product_gress_remarks IS NOT NULL AND
     :product_gress_remarks IS NOT NULL AND
     :old_product_gress_remarks = :product_gress_remarks)) THEN
    IF ((:old_progress_update_date IS NULL AND
       :progress_update_date IS NULL) OR
       (:old_progress_update_date IS NOT NULL AND
       :progress_update_date IS NOT NULL AND
       :old_progress_update_date = :progress_update_date)) THEN
      v_progress_update_date := :progress_update_date;
    ELSE
      v_progress_update_date := :progress_update_date;
    END IF;
  ELSE
    IF ((:old_progress_update_date IS NULL AND
       :progress_update_date IS NULL) OR
       (:old_progress_update_date IS NOT NULL AND
       :progress_update_date IS NOT NULL AND
       :old_progress_update_date = :progress_update_date)) THEN
      v_progress_update_date := SYSDATE;
    ELSE
      v_progress_update_date := :progress_update_date;
    END IF;
  END IF;
  --预测交期
  scmdata.pkg_production_progress_a.p_forecast_delivery_date(p_progress_id          => :product_gress_id,
                                                             p_company_id           => %default_company_id%,
                                                             p_progress_status      => :progress_status_pr,
                                                             p_progress_update_date => v_progress_update_date,
                                                             p_plan_date            => :plan_delivery_date,
                                                             p_delivery_date        => :delivery_date_pr,
                                                             p_curlink_complet_prom => round(:curlink_complet_ratio,
                                                                                             2),
                                                             po_forecast_date       => vo_forecast_date,
                                                             po_forecast_days       => vo_forecast_days);
  --保存校验                                                          
  scmdata.pkg_production_progress_a.p_check_updprogress(p_item_id               => ''a_product_110'',
                                                        p_company_id            => %default_company_id%,
                                                        p_goo_id                => :goo_id_pr,
                                                        p_delay_problem_class   => :delay_problem_class_pr,
                                                        p_delay_cause_class     => :delay_cause_class_pr,
                                                        p_delay_cause_detailed  => :delay_cause_detailed_pr,
                                                        p_problem_desc          => :problem_desc_pr,
                                                        p_responsible_dept_sec  => :responsible_dept_sec,
                                                        p_progress_status       => :progress_status_pr,
                                                        p_curlink_complet_ratio => :curlink_complet_ratio,
                                                        p_order_rise_status     => :order_rise_status,
                                                        p_progress_update_date  => v_progress_update_date,
                                                        po_is_sup_exemption     => v_is_sup_exemption,
                                                        po_first_dept_id        => v_first_dept_id,
                                                        po_second_dept_id       => v_second_dept_id,
                                                        po_is_quality           => v_is_quality,
                                                        po_dept_name            => v_dept_name);                                                           

  UPDATE scmdata.t_production_progress t
     SET t.delay_problem_class    = :delay_problem_class_pr,
         t.delay_cause_class      = :delay_cause_class_pr,
         t.delay_cause_detailed   = :delay_cause_detailed_pr,
         t.problem_desc           = :problem_desc_pr,
         t.is_sup_responsible     = v_is_sup_exemption,
         t.responsible_dept       = v_first_dept_id,
         t.responsible_dept_sec   = nvl(:responsible_dept_sec,
                                        v_second_dept_id),
         t.is_quality             = v_is_quality,
         t.update_company_id      = %default_company_id%,
         t.update_id              = :user_id,
         t.update_time            = SYSDATE,
         t.progress_status        = :progress_status_pr,
         t.product_gress_remarks  = :product_gress_remarks,
         t.curlink_complet_ratio  = round(:curlink_complet_ratio, 2),
         t.progress_update_date   = v_progress_update_date,
         t.order_rise_status      = :order_rise_status,
         t.plan_delivery_date     = :plan_delivery_date,
         t.forecast_delivery_date = vo_forecast_date,
         t.forecast_delay_day     = vo_forecast_days
   WHERE t.product_gress_id = :product_gress_id;
   
   UPDATE scmdata.t_ordered t SET t.delivery_date = :delivery_date_pr WHERE t.company_id = %default_company_id% AND t.order_code = :order_id_pr;

END;', null, 'PRODUCT_GRESS_ID,FABRIC_CHECK,COMPANY_ID,SUPPLIER_CODE_PR,FACTORY_CODE_PR,ORDER_ID_PR,QC_CHECK_PR,QA_CHECK_PR,APPROVE_EDITION,CHECK_LINK,CATEGORY_CODE,FIRST_DEPT_ID,RESPONSIBLE_DEPT_SEC,GOO_ID_PR,PROGRESS_STATUS_PR,ORDER_RISE_STATUS,UPDATE_COMPANY_ID,UPDATE_ID_PR,UPDATE_DATE_PR,GROUP_NAME,GOO_ID_PR,GOO_ID', null, null, null, null, null, 1, null, null, null, '1', 0, null, null, 1, 0, null, 0, null, null, null, null, null, 0, 0, null, null, null, null, 0, null, 0, '20,30,50,100,200,500');

insert into nbw.sys_item_list (ITEM_ID, QUERY_TYPE, QUERY_FIELDS, QUERY_COUNT, EDIT_EXPRESS, NEWID_SQL, SELECT_SQL, DETAIL_SQL, SUBSELECT_SQL, INSERT_SQL, UPDATE_SQL, DELETE_SQL, NOSHOW_FIELDS, NOADD_FIELDS, NOMODIFY_FIELDS, NOEDIT_FIELDS, SUBNOSHOW_FIELDS, UI_TMPL, MULTI_PAGE_FLAG, OUTPUT_PARAMETER, LOCK_SQL, MONITOR_ID, END_FIELD, EXECUTE_TIME, SCANNABLE_FIELD, SCANNABLE_TYPE, AUTO_REFRESH, RFID_FLAG, SCANNABLE_TIME, MAX_ROW_COUNT, NOSHOW_APP_FIELDS, SCANNABLE_LOCATION_LINE, SUB_TABLE_JUDGE_FIELD, BACK_GROUND_ID, OPRETION_HINT, SUB_EDIT_STATE, HINT_TYPE, HEADER, FOOTER, JUMP_FIELD, JUMP_EXPRESS, OPEN_MODE, OPERATION_TYPE, OPERATE_TYPE, PAGE_SIZES)
values ('a_product_118', 12, 'product_gress_code_pr,rela_goo_id,supplier_company_name_pr,style_number_pr', null, null, null, 'WITH supp AS
 (SELECT sp.company_id, sp.supplier_code, sp.supplier_company_name
    FROM scmdata.t_supplier_info sp
   WHERE sp.company_id = %default_company_id%),
group_dict AS
 (SELECT group_dict_type, group_dict_value, group_dict_name
    FROM scmdata.sys_group_dict),
su_user AS
 (SELECT su.company_id, su.user_id, su.company_user_name, su.job_id
    FROM scmdata.sys_company_user su),
range_dict AS
 (SELECT a.group_dict_value abn_range, a.group_dict_name abn_range_desc
    FROM scmdata.sys_group_dict a
   WHERE a.group_dict_type = ''ABN_RANGE''
     AND a.pause = 0),
color_dict AS
 (SELECT tcs.color_code abn_range,
         tcs.colorname  abn_range_desc,
         od.order_id,
         od.goo_id
    FROM scmdata.t_ordersitem od
   INNER JOIN scmdata.t_commodity_info tc
      ON od.goo_id = tc.goo_id
   INNER JOIN scmdata.t_commodity_color_size tcs
      ON tc.commodity_info_id = tcs.commodity_info_id
     AND od.barcode = tcs.barcode
   WHERE od.company_id = %default_company_id%
   GROUP BY od.goo_id, od.order_id, tcs.color_code, tcs.colorname)
SELECT DISTINCT *
  FROM (SELECT t.product_gress_id,
               t.company_id,
               t.order_id order_id_pr,
               a.abnormal_id abnormal_id_pr,
               a.abnormal_code abnormal_code_pr,
               a.anomaly_class anomaly_class_pr,
               gd.group_dict_name anomaly_class_desc,
               t.product_gress_code product_gress_code_pr,
               cf.rela_goo_id,
               a.detailed_reasons detailed_reasons_pr, --问题描述
               a.delay_date delay_date_pr, --延期天数
               a.abnormal_range abn_range,
               listagg(nvl(rd.abn_range_desc, ld.abn_range_desc), '' '') over(PARTITION BY a.abnormal_code) abn_range_desc,
               a.delay_amount delay_amount_pr, --延期数量
               a.handle_opinions handle_opinions_pr,
               a.is_deduction is_deduction_pr,
               a.deduction_method deduction_method_pr,
               a.deduction_unit_price deduction_unit_price_pr,
               a.file_id file_id_pr,
               a.problem_class problem_class_pr,
               a.cause_class cause_class_pr,
               a.cause_detailed cause_detailed_pr,
               a.is_sup_responsible,
               /*原代码
               a.responsible_dept responsible_dept_pr,
               a.responsible_dept_sec responsible_dept_sec_pr,*/
               ---LSL167修改 20220716
               a.responsible_dept first_dept_id,
               (SELECT sd.dept_name
                  FROM scmdata.sys_company_dept sd
                 WHERE sd.company_id = a.company_id
                   AND sd.company_dept_id = a.responsible_dept) responsible_dept_pr,
               a.responsible_dept_sec second_dept_id,
               (SELECT sd.dept_name
                  FROM scmdata.sys_company_dept sd
                 WHERE sd.company_id = a.company_id
                   AND sd.company_dept_id = a.responsible_dept_sec) responsible_dept_sec_pr,
               ---end
               a.memo memo_pr,
               a.progress_status abnormal_status_pr,
               t.progress_status progress_status_pr,
               t.supplier_code supplier_code_pr,
               sp2.supplier_company_name supplier_company_name_pr,
               t.goo_id goo_id_pr,
               cf.style_number style_number_pr,
               cf.style_name style_name_pr,
               t.order_amount order_amount_pr,
               oh.delivery_date delivery_date_pr,
               t.latest_planned_delivery_date latest_planned_delivery_date_pr,
               a.check_link,
               a.check_num,
               a.checker,
               a.abnormal_orgin,
               a.origin,
               (CASE
                 WHEN sjb.company_job_id IN
                      (''1001005003005002001'', ''1001005003005002'') THEN
                  1
                 ELSE
                  0
               END) is_edit_abn_orgin
          FROM scmdata.t_ordered oh
         INNER JOIN scmdata.t_orders od
            ON oh.company_id = od.company_id
           AND oh.order_code = od.order_id
           AND oh.order_status = ''OS01'' --待修改
         INNER JOIN t_production_progress t
            ON t.company_id = od.company_id
           AND t.order_id = od.order_id
           AND t.goo_id = od.goo_id
         INNER JOIN scmdata.t_commodity_info cf
            ON t.company_id = cf.company_id
           AND t.goo_id = cf.goo_id
          LEFT JOIN supp sp1
            ON t.company_id = sp1.company_id
           AND t.factory_code = sp1.supplier_code
         INNER JOIN supp sp2
            ON t.company_id = sp2.company_id
           AND t.supplier_code = sp2.supplier_code
         INNER JOIN scmdata.t_abnormal a
            ON t.company_id = a.company_id
           AND t.order_id = a.order_id
           AND t.goo_id = a.goo_id
           AND a.progress_status = ''00''
         INNER JOIN su_user sa
            ON a.company_id = sa.company_id
           AND a.create_id = sa.user_id
          LEFT JOIN scmdata.sys_company_job sjb
            ON sjb.job_id = sa.job_id
           AND sjb.company_id = sa.company_id
          LEFT JOIN group_dict gd
            ON gd.group_dict_type = ''ANOMALY_CLASSIFICATION_DICT''
           AND gd.group_dict_value = a.anomaly_class
          LEFT JOIN range_dict rd
            ON (CASE
                 WHEN a.abnormal_range = ''00'' THEN
                  '' 00 ''
                 WHEN a.abnormal_range = ''01'' THEN
                  '' 01 ''
                 ELSE
                  '' 02 ''
               END) = '' '' || rd.abn_range || '' ''
          LEFT JOIN color_dict ld
            ON (instr('' '' || a.abnormal_range || '' '',
                      '' '' || ld.abn_range || '' '') > 0 AND
               ld.order_id = a.order_id AND ld.goo_id = a.goo_id)
         WHERE oh.company_id = %default_company_id%
           AND a.create_id = :user_id
           AND ((%is_company_admin% = 1) OR
               instr_priv(p_str1  => @subsql@,
                           p_str2  => cf.category,
                           p_split => '';'') > 0)
         ORDER BY a.create_time DESC)', null, '{declare
v_class_data_privs clob;
begin
 v_class_data_privs := pkg_data_privs.parse_json(p_jsonstr => %data_privs_json_strs%,p_key => ''COL_2'');
 @strresult :=''(SELECT * FROM (SELECT '' || '''''''' || v_class_data_privs || '''''''' || '' FROM dual))'';
end;}', 'DECLARE
  v_abnormal_code VARCHAR2(32);
  p_abn_rec       scmdata.t_abnormal%ROWTYPE;
  v_order_amount  NUMBER;
  v_abn_origin    VARCHAR2(32);
BEGIN

  p_abn_rec.abnormal_id          := scmdata.f_get_uuid();
  p_abn_rec.company_id           := %default_company_id%;
  p_abn_rec.abnormal_code        := scmdata.pkg_plat_comm.f_getkeycode(pi_table_name  => ''t_abnormal'',
                                                                       pi_column_name => ''abnormal_code'',
                                                                       pi_company_id  => %default_company_id%,
                                                                       pi_pre         => ''ABN'',
                                                                       pi_serail_num  => ''6'');
  p_abn_rec.order_id             := :order_id_pr;
  p_abn_rec.progress_status      := ''00'';
  p_abn_rec.goo_id               := :goo_id_pr;
  p_abn_rec.anomaly_class        := nvl(:anomaly_class_pr, '' '');
  p_abn_rec.problem_class        := nvl(:delay_problem_class_pr, '' '');
  p_abn_rec.cause_class          := nvl(:delay_cause_class_pr, '' '');
  p_abn_rec.cause_detailed       := nvl(:delay_cause_detailed_pr, '' '');
  p_abn_rec.detailed_reasons     := nvl(:problem_desc_pr, '' '');
  p_abn_rec.is_sup_responsible   := :is_sup_responsible;
  p_abn_rec.responsible_dept_sec := :responsible_dept_sec;
  p_abn_rec.delay_date           := :delay_date;
  p_abn_rec.abnormal_range       := ''00'';

  SELECT nvl(MAX(t.order_amount), 0)
    INTO v_order_amount
    FROM scmdata.t_production_progress t
   WHERE t.goo_id = :goo_id_pr
     AND t.order_id = :order_id_pr
     AND t.company_id = %default_company_id%;

  p_abn_rec.delay_amount         := v_order_amount;
  p_abn_rec.responsible_party    := nvl(:responsible_party, '' '');
  p_abn_rec.responsible_dept     := nvl(:responsible_dept, '' '');
  p_abn_rec.handle_opinions      := :handle_opinions;
  p_abn_rec.quality_deduction    := nvl(:quality_deduction, 0);
  p_abn_rec.is_deduction         := nvl(:is_deduction, 0);
  p_abn_rec.deduction_method     := :deduction_method_pr;
  p_abn_rec.deduction_unit_price := :deduction_unit_price_pr;
  p_abn_rec.applicant_id         := :user_id;
  p_abn_rec.applicant_date       := SYSDATE;
  p_abn_rec.create_id            := :user_id;
  p_abn_rec.create_time          := SYSDATE;
  p_abn_rec.update_id            := :user_id;
  p_abn_rec.update_time          := SYSDATE;
  --p_abn_rec.origin               := ''MA'';
  p_abn_rec.memo := :memo_pr;
  --20220708 781 异常处理相关优化
  p_abn_rec.origin     := ''MA'';
  p_abn_rec.origin_id  := p_abn_rec.abnormal_id; --来源ID
  p_abn_rec.orgin_type := ''ABN''; --来源类型
  --异常来源  获取员工对应的三级部门ID
  IF :anomaly_class_pr = ''AC_DATE'' THEN
    p_abn_rec.abnormal_orgin := NULL;
    p_abn_rec.checker        := NULL; --查货人 待做
    p_abn_rec.check_link     := NULL; --查货环节
    p_abn_rec.check_num      := NULL;
  ELSE
    v_abn_origin             := scmdata.pkg_production_progress.f_get_user_third_dept_id(p_user_id    => :user_id,
                                                                                         p_company_id => %default_company_id%);
    p_abn_rec.abnormal_orgin := v_abn_origin;
    p_abn_rec.checker        := NULL; --查货人
    p_abn_rec.check_link := CASE
                              WHEN v_abn_origin IN
                                   (''ed7ff3c7135a236ae0533c281caccd8d'', ''14'') THEN
                               ''QC_FINAL_CHECK''
                              WHEN v_abn_origin = ''16'' THEN
                               ''AC''
                              ELSE
                               NULL
                            END; --查货环节
    p_abn_rec.check_num := CASE
                             WHEN v_abn_origin IN (''ed7ff3c7135a236ae0533c281caccd8d'',
                                                   ''14'',
                                                   ''16'') THEN
                              1
                             ELSE
                              NULL
                           END;
  END IF;
  --提交异常单
  scmdata.pkg_production_progress.handle_abnormal(p_abn_rec => p_abn_rec);
END;', 'DECLARE
  v_abnormal_code VARCHAR2(32);
  v_anomaly_class VARCHAR2(32);
  p_abn_rec       scmdata.t_abnormal%ROWTYPE;
  v_order_amount  NUMBER;
BEGIN

  p_abn_rec.abnormal_id   := :abnormal_id_pr;
  p_abn_rec.company_id    := %default_company_id%;
  p_abn_rec.abnormal_code := :abnormal_code_pr;
  p_abn_rec.order_id      := :order_id_pr;

  SELECT MAX(abn.anomaly_class)
    INTO v_anomaly_class
    FROM scmdata.t_abnormal abn
   WHERE abn.abnormal_id = :abnormal_id_pr;

  p_abn_rec.anomaly_class := v_anomaly_class;

  IF v_anomaly_class = ''AC_DATE'' THEN
    NULL;
  ELSIF v_anomaly_class IN (''AC_QUALITY'', ''AC_OTHERS'') THEN
    p_abn_rec.problem_class      := :problem_class_pr;
    p_abn_rec.cause_class        := :cause_class_pr;
    p_abn_rec.cause_detailed     := :cause_detailed_pr;
    p_abn_rec.detailed_reasons   := :detailed_reasons_pr;
    p_abn_rec.is_sup_responsible := :is_sup_responsible;
    /*原代码
        p_abn_rec.responsible_dept     := :responsible_dept_pr;
        p_abn_rec.responsible_dept_sec := :responsible_dept_sec_pr;
    */
    ---lsl167 20220728 修改
    p_abn_rec.responsible_dept     := :first_dept_id;
    p_abn_rec.responsible_dept_sec := :second_dept_id;
    ---end
  ELSE
    NULL;
  END IF;

  p_abn_rec.delay_date     := :delay_date_pr;
  p_abn_rec.abnormal_range := :abn_range;

  IF '' '' || :abn_range || '' '' = '' 00 '' THEN
    SELECT nvl(MAX(t.order_amount), 0)
      INTO v_order_amount
      FROM scmdata.t_production_progress t
     WHERE t.goo_id = :goo_id_pr
       AND t.order_id = :order_id_pr
       AND t.company_id = %default_company_id%;
  
    IF :delay_amount_pr IS NULL OR instr(:delay_amount_pr, '' '') > 0 OR
       :delay_amount_pr = v_order_amount THEN
      NULL;
    ELSE
      raise_application_error(-20002,
                              ''保存失败！异常范围选择全部时，无需填写异常数量！'');
    END IF;
    p_abn_rec.delay_amount := v_order_amount;
  ELSIF '' '' || :abn_range || '' '' = '' 01 '' THEN
    p_abn_rec.delay_amount := :delay_amount_pr;
  ELSE
    SELECT SUM(CASE
                 WHEN instr('' '' || :abn_range || '' '',
                            '' '' || tcs.color_code || '' '') > 0 THEN
                  od.order_amount
                 ELSE
                  0
               END) order_amount
      INTO v_order_amount
      FROM scmdata.t_ordersitem od
     INNER JOIN scmdata.t_commodity_info tc
        ON od.goo_id = tc.goo_id
     INNER JOIN scmdata.t_commodity_color_size tcs
        ON tc.commodity_info_id = tcs.commodity_info_id
       AND od.barcode = tcs.barcode
     WHERE od.goo_id = :goo_id_pr
       AND od.order_id = :order_id_pr
       AND od.company_id = %default_company_id%;
    IF :delay_amount_pr IS NULL OR instr(:delay_amount_pr, '' '') > 0 OR
       :delay_amount_pr = v_order_amount THEN
      NULL;
    ELSE
      raise_application_error(-20002,
                              ''保存失败！异常范围选择订单颜色时，无需填写异常数量！'');
    END IF;
    p_abn_rec.delay_amount := v_order_amount;
  END IF;

  p_abn_rec.responsible_party    := :responsible_party_pr;
  p_abn_rec.handle_opinions      := :handle_opinions_pr;
  p_abn_rec.is_deduction         := :is_deduction_pr;
  p_abn_rec.deduction_method     := :deduction_method_pr;
  p_abn_rec.deduction_unit_price := :deduction_unit_price_pr;
  p_abn_rec.file_id              := :file_id_pr;
  p_abn_rec.applicant_id         := :user_id;
  p_abn_rec.applicant_date       := SYSDATE;
  p_abn_rec.memo                 := :memo_pr;
  p_abn_rec.update_id            := :user_id;
  p_abn_rec.update_time          := SYSDATE;

  --20220708 781 异常处理相关优化
  --异常来源  获取员工对应的三级部门ID
  p_abn_rec.abnormal_orgin := :abnormal_orgin;
  p_abn_rec.checker    := :checker; --查货人
  p_abn_rec.check_link := :check_link; --查货环节
  p_abn_rec.check_num  := :check_num;
  scmdata.pkg_production_progress.update_abnormal(p_abn_rec => p_abn_rec);

END;', 'BEGIN
scmdata.pkg_production_progress_a.p_delete_abormal(p_company_id => %default_company_id%,p_abnormal_id => :abnormal_id_pr);
END;', 'PRODUCT_GRESS_ID,COMPANY_ID,SUPPLIER_CODE_PR,FACTORY_CODE_PR,ORDER_ID_PR,ABNORMAL_ID_PR,ABNORMAL_STATUS_PR,IS_DEDUCTION_PR,HANDLE_OPINIONS_PR,ANOMALY_CLASS_PR,RESPONSIBLE_PARTY_PR,DEDUCTION_METHOD_PR,ABN_RANGE,PROGRESS_STATUS_PR,FIRST_DEPT_ID,SECOND_DEPT_ID,GOO_ID_PR,GOO_ID,ORIGIN,ABNORMAL_ORGIN,IS_EDIT_ABN_ORGIN,ORIGIN_DESC,CHECKER,CHECK_LINK', null, null, 'GOO_ID_PR', null, null, 1, null, null, null, null, null, null, null, 1, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, 0, '20,30,50,100,200,500');

insert into nbw.sys_item_list (ITEM_ID, QUERY_TYPE, QUERY_FIELDS, QUERY_COUNT, EDIT_EXPRESS, NEWID_SQL, SELECT_SQL, DETAIL_SQL, SUBSELECT_SQL, INSERT_SQL, UPDATE_SQL, DELETE_SQL, NOSHOW_FIELDS, NOADD_FIELDS, NOMODIFY_FIELDS, NOEDIT_FIELDS, SUBNOSHOW_FIELDS, UI_TMPL, MULTI_PAGE_FLAG, OUTPUT_PARAMETER, LOCK_SQL, MONITOR_ID, END_FIELD, EXECUTE_TIME, SCANNABLE_FIELD, SCANNABLE_TYPE, AUTO_REFRESH, RFID_FLAG, SCANNABLE_TIME, MAX_ROW_COUNT, NOSHOW_APP_FIELDS, SCANNABLE_LOCATION_LINE, SUB_TABLE_JUDGE_FIELD, BACK_GROUND_ID, OPRETION_HINT, SUB_EDIT_STATE, HINT_TYPE, HEADER, FOOTER, JUMP_FIELD, JUMP_EXPRESS, OPEN_MODE, OPERATION_TYPE, OPERATE_TYPE, PAGE_SIZES)
values ('a_product_120', 0, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, 1, null, null, null, null, null, null, null, 1, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, 0, '20,30,50,100,200,500');

insert into nbw.sys_item_list (ITEM_ID, QUERY_TYPE, QUERY_FIELDS, QUERY_COUNT, EDIT_EXPRESS, NEWID_SQL, SELECT_SQL, DETAIL_SQL, SUBSELECT_SQL, INSERT_SQL, UPDATE_SQL, DELETE_SQL, NOSHOW_FIELDS, NOADD_FIELDS, NOMODIFY_FIELDS, NOEDIT_FIELDS, SUBNOSHOW_FIELDS, UI_TMPL, MULTI_PAGE_FLAG, OUTPUT_PARAMETER, LOCK_SQL, MONITOR_ID, END_FIELD, EXECUTE_TIME, SCANNABLE_FIELD, SCANNABLE_TYPE, AUTO_REFRESH, RFID_FLAG, SCANNABLE_TIME, MAX_ROW_COUNT, NOSHOW_APP_FIELDS, SCANNABLE_LOCATION_LINE, SUB_TABLE_JUDGE_FIELD, BACK_GROUND_ID, OPRETION_HINT, SUB_EDIT_STATE, HINT_TYPE, HEADER, FOOTER, JUMP_FIELD, JUMP_EXPRESS, OPEN_MODE, OPERATION_TYPE, OPERATE_TYPE, PAGE_SIZES)
values ('a_product_120_1', 13, 'product_gress_code_pr,rela_goo_id,supplier_company_name_pr,style_number_pr', null, null, null, 'WITH supp AS
 (SELECT sp.company_id, sp.supplier_code, sp.supplier_company_name
    FROM scmdata.t_supplier_info sp),
group_dict AS
 (SELECT group_dict_type, group_dict_value, group_dict_name
    FROM scmdata.sys_group_dict),
su_user AS
 (SELECT su.company_id, su.user_id, su.company_user_name, su.job_id
    FROM scmdata.sys_company_user su),
range_dict AS
 (SELECT ga.group_dict_value abn_range, ga.group_dict_name abn_range_desc
    FROM scmdata.sys_group_dict ga
   WHERE ga.group_dict_type = ''ABN_RANGE''
     AND ga.pause = 0),
color_dict AS
 (SELECT tcs.color_code abn_range,
         tcs.colorname  abn_range_desc,
         od.order_id,
         od.goo_id
    FROM scmdata.t_ordersitem od
   INNER JOIN scmdata.t_commodity_info tc
      ON od.goo_id = tc.goo_id
   INNER JOIN scmdata.t_commodity_color_size tcs
      ON tc.commodity_info_id = tcs.commodity_info_id
     AND od.barcode = tcs.barcode
   WHERE od.company_id = %default_company_id%
   GROUP BY od.goo_id, od.order_id, tcs.color_code, tcs.colorname)
SELECT DISTINCT *
  FROM (SELECT t.product_gress_id,
               t.company_id,
               t.order_id order_id_pr,
               a.abnormal_id,
               a.abnormal_code abnormal_code_pr,
               a.anomaly_class anomaly_class_pr,
               gd.group_dict_name anomaly_class_desc,
               t.product_gress_code product_gress_code_pr,
               cf.rela_goo_id,
               a.detailed_reasons detailed_reasons_pr, --问题描述
               a.delay_date delay_date_pr, --延期天数
               a.abnormal_range abn_range,
               listagg(nvl(rd.abn_range_desc, ld.abn_range_desc), '' '') over(PARTITION BY a.abnormal_code) abn_range_desc,
               a.delay_amount delay_amount_pr, --延期数量
               a.handle_opinions handle_opinions_pr,
               a.is_deduction is_deduction_pr,
               a.deduction_method deduction_method_pr,
               a.deduction_unit_price deduction_unit_price_pr,
               a.file_id file_id_pr,
               a.problem_class problem_class_pr,
               a.cause_class cause_class_pr,
               a.cause_detailed cause_detailed_pr,
               a.is_sup_responsible,
               /*原代码
               a.responsible_dept responsible_dept_pr,
               a.responsible_dept_sec responsible_dept_sec_pr,*/
               ---LSL167修改 20220728
               a.responsible_dept first_dept_id,
               (SELECT sd.dept_name
                  FROM scmdata.sys_company_dept sd
                 WHERE sd.company_id = a.company_id
                   AND sd.company_dept_id = a.responsible_dept) responsible_dept_pr,
               a.responsible_dept_sec second_dept_id,
               (SELECT sd.dept_name
                  FROM scmdata.sys_company_dept sd
                 WHERE sd.company_id = a.company_id
                   AND sd.company_dept_id = a.responsible_dept_sec) responsible_dept_sec_pr,
               ---end
               a.memo memo_pr,
               t.progress_status progress_status_pr,
               t.supplier_code supplier_code_pr,
               sp2.supplier_company_name supplier_company_name_pr,
               t.goo_id goo_id_pr,
               cf.style_number style_number_pr,
               cf.style_name style_name_pr,
               t.order_amount order_amount_pr,
               oh.delivery_date delivery_date_pr,
               t.latest_planned_delivery_date latest_planned_delivery_date_pr,
               (CASE
                 WHEN a.orgin_type = ''QA'' THEN
                  qa.qa_report_id
                 WHEN a.orgin_type = ''QC'' THEN
                  qc.qc_check_code
                 ELSE
                  NULL
               END) quality_control_log_id,
               --''查看报告'' quality_control_report,
               a.check_link,
               a.check_num,
               a.checker,
               a.abnormal_orgin,
               a.origin,
               (CASE
                 WHEN sjb.company_job_id IN
                      (''1001005003005002001'', ''1001005003005002'') THEN
                  1
                 ELSE
                  0
               END) is_edit_abn_orgin,
               sa.company_user_name create_id,
               a.create_time,
               sc.company_user_name update_id,
               a.update_time,
               sb.company_user_name confirm_id,
               a.confirm_date confirm_date,
               gd_c.group_dict_name cooperation_classification
          FROM scmdata.t_ordered oh
         INNER JOIN scmdata.t_orders od
            ON oh.company_id = od.company_id
           AND oh.order_code = od.order_id
           AND oh.order_status = ''OS01''
         INNER JOIN t_production_progress t
            ON t.company_id = od.company_id
           AND t.order_id = od.order_id
           AND t.goo_id = od.goo_id
         INNER JOIN scmdata.t_commodity_info cf
            ON t.company_id = cf.company_id
           AND t.goo_id = cf.goo_id
          LEFT JOIN group_dict gd_c
            ON gd_c.group_dict_type = ''PRODUCT_TYPE''
           AND gd_c.group_dict_value = cf.category
         INNER JOIN supp sp2
            ON t.company_id = sp2.company_id
           AND t.supplier_code = sp2.supplier_code
         INNER JOIN scmdata.t_abnormal a
            ON t.company_id = a.company_id
           AND t.order_id = a.order_id
           AND t.goo_id = a.goo_id
           AND a.progress_status = ''01''
           AND a.orgin_type <> ''TD''
         INNER JOIN su_user sa
            ON a.company_id = sa.company_id
           AND a.create_id = sa.user_id
          LEFT JOIN scmdata.sys_company_job sjb
            ON sjb.job_id = sa.job_id
           AND sjb.company_id = sa.company_id
          LEFT JOIN su_user sb
            ON a.company_id = sb.company_id
           AND a.confirm_id = sb.user_id
          LEFT JOIN su_user sc
            ON a.company_id = sc.company_id
           AND a.update_id = sc.user_id
         INNER JOIN scmdata.sys_group_dict gd
            ON gd.group_dict_type = ''ANOMALY_CLASSIFICATION_DICT''
           AND gd.group_dict_value = a.anomaly_class
          LEFT JOIN range_dict rd
            ON (CASE
                 WHEN a.abnormal_range = ''00'' THEN
                  '' 00 ''
                 WHEN a.abnormal_range = ''01'' THEN
                  '' 01 ''
                 ELSE
                  '' 02 ''
               END) = '' '' || rd.abn_range || '' ''
          LEFT JOIN color_dict ld
            ON (instr('' '' || a.abnormal_range || '' '',
                      '' '' || ld.abn_range || '' '') > 0 AND
               ld.order_id = a.order_id AND ld.goo_id = a.goo_id)
          LEFT JOIN scmdata.t_qc_check qc
            ON qc.qc_check_id = a.origin_id
          LEFT JOIN scmdata.t_qa_report qa
            ON qa.qa_report_id = a.origin_id
         WHERE oh.company_id = %default_company_id%
           AND ((%is_company_admin% = 1) OR
               instr_priv(p_str1  => @subsql@,
                           p_str2  => cf.category,
                           p_split => '';'') > 0)
         ORDER BY a.create_time DESC)', null, '{declare
v_class_data_privs clob;
begin
 v_class_data_privs := pkg_data_privs.parse_json(p_jsonstr => %data_privs_json_strs%,p_key => ''COL_2'');
 @strresult :=''(SELECT * FROM (SELECT '' || '''''''' || v_class_data_privs || '''''''' || '' FROM dual))'';
end;}', null, 'DECLARE
  v_abnormal_code VARCHAR2(32);
  v_anomaly_class VARCHAR2(32);
  p_abn_rec       scmdata.t_abnormal%ROWTYPE;
  v_flag          NUMBER;
  v_order_amount  NUMBER;
BEGIN

  p_abn_rec.abnormal_id   := :abnormal_id;
  p_abn_rec.company_id    := %default_company_id%;
  p_abn_rec.abnormal_code := :abnormal_code_pr;
  p_abn_rec.order_id      := :order_id_pr;

  SELECT MAX(abn.anomaly_class)
    INTO v_anomaly_class
    FROM scmdata.t_abnormal abn
   WHERE abn.abnormal_id = :abnormal_id;

  p_abn_rec.anomaly_class := v_anomaly_class;

  IF v_anomaly_class = ''AC_DATE'' THEN
    NULL;
  ELSIF v_anomaly_class IN (''AC_QUALITY'', ''AC_OTHERS'') THEN
    p_abn_rec.problem_class        := :problem_class_pr;
    p_abn_rec.cause_class          := :cause_class_pr;
    p_abn_rec.cause_detailed       := :cause_detailed_pr;
    p_abn_rec.detailed_reasons     := :detailed_reasons_pr;
    p_abn_rec.is_sup_responsible   := :is_sup_responsible;
    p_abn_rec.responsible_dept     := :first_dept_id;
    p_abn_rec.responsible_dept_sec := :second_dept_id;
  ELSE
    NULL;
  END IF;

  p_abn_rec.delay_date     := :delay_date_pr;
  p_abn_rec.abnormal_range := :abn_range;

  IF '' '' || :abn_range || '' ''= '' 00 '' THEN

    SELECT nvl(MAX(t.order_amount), 0)
      INTO v_order_amount
      FROM scmdata.t_production_progress t
     WHERE t.goo_id = :goo_id_pr
       AND t.order_id = :order_id_pr
       AND t.company_id = %default_company_id%;

    IF :delay_amount_pr IS NULL OR instr(:delay_amount_pr, '' '') > 0 OR
       :delay_amount_pr = v_order_amount THEN
      NULL;
    ELSE
      raise_application_error(-20002,
                              ''保存失败！异常范围选择全部时，无需填写异常数量！'');
    END IF;
    p_abn_rec.delay_amount := v_order_amount;
  ELSIF '' '' || :abn_range || '' '' = '' 01 ''  THEN
    p_abn_rec.delay_amount := :delay_amount_pr;
  ELSE
    SELECT SUM(CASE
                 WHEN instr('' '' || :abn_range || '' '',
                            '' '' || tcs.color_code || '' '') > 0 THEN
                  od.order_amount
                 ELSE
                  0
               END) order_amount
      INTO v_order_amount
      FROM scmdata.t_ordersitem od
     INNER JOIN scmdata.t_commodity_info tc
        ON od.goo_id = tc.goo_id
     INNER JOIN scmdata.t_commodity_color_size tcs
        ON tc.commodity_info_id = tcs.commodity_info_id
       AND od.barcode = tcs.barcode
     WHERE od.goo_id = :goo_id_pr
       AND od.order_id = :order_id_pr
       AND od.company_id = %default_company_id%;
    IF :delay_amount_pr IS NULL OR instr(:delay_amount_pr, '' '') > 0 OR
       :delay_amount_pr = v_order_amount THEN
      NULL;
    ELSE
      raise_application_error(-20002,
                              ''保存失败！异常范围选择订单颜色时，无需填写异常数量！'');
    END IF;
    p_abn_rec.delay_amount := v_order_amount;
  END IF;
  p_abn_rec.responsible_party    := :responsible_party_pr;
  p_abn_rec.handle_opinions      := :handle_opinions_pr;
  p_abn_rec.is_deduction         := :is_deduction_pr;
  p_abn_rec.deduction_method     := :deduction_method_pr;
  p_abn_rec.deduction_unit_price := :deduction_unit_price_pr;
  p_abn_rec.file_id              := :file_id_pr;
  p_abn_rec.applicant_id         := :user_id;
  p_abn_rec.applicant_date       := SYSDATE;
  p_abn_rec.memo                 := :memo_pr;
  p_abn_rec.update_id            := :user_id;
  p_abn_rec.update_time          := SYSDATE;
  
  --20220708 781 异常处理相关优化
  --异常来源  获取员工对应的三级部门ID
  p_abn_rec.abnormal_orgin := :abnormal_orgin;
  p_abn_rec.checker    := :checker; --查货人
  p_abn_rec.check_link := :check_link; --查货环节
  p_abn_rec.check_num  := :check_num;
  
  scmdata.pkg_production_progress.update_abnormal(p_abn_rec => p_abn_rec);

END;', 'DECLARE
  v_flag     NUMBER;
  v_abn_flag NUMBER;
  p_abn_rec  scmdata.t_abnormal%ROWTYPE;
BEGIN
  p_abn_rec.company_id := %default_company_id%;
  p_abn_rec.order_id   := :order_id_pr;
  p_abn_rec.goo_id     := :goo_id_pr;
  --删除校验
  scmdata.pkg_production_progress_a.p_check_abnormal_by_delete(p_company_id  => %default_company_id%,
                                                               p_user_id     => :user_id,
                                                               p_abnormal_id => :abnormal_id);
  --删除异常单                                                            
  scmdata.pkg_production_progress_a.p_delete_abormal(p_company_id  => %default_company_id%,
                                                     p_abnormal_id => :abnormal_id);
  --同步生产进度，异常状态
  --1.校验待处理列表是否有异常单，有则处理中，
  --2.无则校验已处理列表是否有异常单，有则已处理，无则无异常
  SELECT COUNT(1)
    INTO v_flag
    FROM scmdata.t_abnormal t
   WHERE t.company_id = p_abn_rec.company_id
        AND t.order_id = p_abn_rec.order_id
     AND t.goo_id = p_abn_rec.goo_id
     AND t.progress_status = ''01'';

  IF v_flag > 0 THEN
  
    scmdata.pkg_production_progress.sync_abnormal(p_abn_rec => p_abn_rec,
                                                  p_status  => ''01'');
  ELSE
  
    SELECT COUNT(1)
      INTO v_abn_flag
      FROM scmdata.t_abnormal t
     WHERE t.company_id = p_abn_rec.company_id
        AND t.order_id = p_abn_rec.order_id
       AND t.goo_id = p_abn_rec.goo_id
       AND t.progress_status = ''02'';
       
    IF v_abn_flag > 0 THEN
      p_abn_rec.handle_opinions := :handle_opinions_pr;
      scmdata.pkg_production_progress.sync_abnormal(p_abn_rec => p_abn_rec,
                                                    p_status  => ''02'');
    ELSE
      p_abn_rec.handle_opinions := '''';
      scmdata.pkg_production_progress.sync_abnormal(p_abn_rec => p_abn_rec,
                                                    p_status  => ''00'');
    END IF;
  
  END IF;
END;', 'ABNORMAL_ID,ANOMALY_CLASS_PR,PRODUCT_GRESS_ID,COMPANY_ID,SUPPLIER_CODE_PR,FACTORY_CODE_PR,ORDER_ID_PR,ABNORMAL_STATUS_PR,HANDLE_OPINIONS_PR,IS_DEDUCTION_PR,CONFIRM_ID,CONFIRM_DATE,DEDUCTION_METHOD_PR,RESPONSIBLE_PARTY_PR,ABN_RANGE,PROGRESS_STATUS_PR,FIRST_DEPT_ID,SECOND_DEPT_ID,GOO_ID_PR,GOO_ID,ORIGIN,ABNORMAL_ORGIN,IS_EDIT_ABN_ORGIN,CHECKER,CHECK_LINK,QUALITY_CONTROL_LOG_ID', null, null, 'GOO_ID_PR', null, null, 1, null, null, null, null, null, null, null, 1, null, null, null, null, null, null, null, null, null, null, null, null, 'VIEW_REPORT', null, null, null, 0, '20,30,50,100,200,500');

insert into nbw.sys_item_list (ITEM_ID, QUERY_TYPE, QUERY_FIELDS, QUERY_COUNT, EDIT_EXPRESS, NEWID_SQL, SELECT_SQL, DETAIL_SQL, SUBSELECT_SQL, INSERT_SQL, UPDATE_SQL, DELETE_SQL, NOSHOW_FIELDS, NOADD_FIELDS, NOMODIFY_FIELDS, NOEDIT_FIELDS, SUBNOSHOW_FIELDS, UI_TMPL, MULTI_PAGE_FLAG, OUTPUT_PARAMETER, LOCK_SQL, MONITOR_ID, END_FIELD, EXECUTE_TIME, SCANNABLE_FIELD, SCANNABLE_TYPE, AUTO_REFRESH, RFID_FLAG, SCANNABLE_TIME, MAX_ROW_COUNT, NOSHOW_APP_FIELDS, SCANNABLE_LOCATION_LINE, SUB_TABLE_JUDGE_FIELD, BACK_GROUND_ID, OPRETION_HINT, SUB_EDIT_STATE, HINT_TYPE, HEADER, FOOTER, JUMP_FIELD, JUMP_EXPRESS, OPEN_MODE, OPERATION_TYPE, OPERATE_TYPE, PAGE_SIZES)
values ('a_product_120_2', 13, 'product_gress_code_pr,rela_goo_id,supplier_company_name_pr,style_number_pr', null, null, null, 'WITH supp AS
 (SELECT sp.company_id, sp.supplier_code, sp.supplier_company_name
    FROM scmdata.t_supplier_info sp),
group_dict AS
 (SELECT group_dict_type, group_dict_value, group_dict_name
    FROM scmdata.sys_group_dict),
su_user AS
 (SELECT su.company_id, su.user_id, su.company_user_name
    FROM scmdata.sys_company_user su),
range_dict AS
 (SELECT ga.group_dict_value abn_range, ga.group_dict_name abn_range_desc
    FROM scmdata.sys_group_dict ga
   WHERE ga.group_dict_type = ''ABN_RANGE''
     AND ga.pause = 0),
color_dict AS
 (SELECT tcs.color_code abn_range,
         tcs.colorname  abn_range_desc,
         od.order_id,
         od.goo_id
    FROM scmdata.t_ordersitem od
   INNER JOIN scmdata.t_commodity_info tc
      ON od.goo_id = tc.goo_id
   INNER JOIN scmdata.t_commodity_color_size tcs
      ON tc.commodity_info_id = tcs.commodity_info_id
     AND od.barcode = tcs.barcode
   WHERE od.company_id = %default_company_id%
   GROUP BY od.goo_id, od.order_id, tcs.color_code, tcs.colorname)
SELECT DISTINCT *
  FROM (SELECT t.product_gress_id,
               t.company_id,
               t.order_id order_id_pr,
               a.abnormal_id,
               a.anomaly_class anomaly_class_pr,
               gd.group_dict_name anomaly_class_desc,
               t.product_gress_code product_gress_code_pr,
               cf.rela_goo_id,
               a.detailed_reasons detailed_reasons_pr, --问题描述
               a.delay_date delay_date_pr, --延期天数
               a.abnormal_range abn_range,
               listagg(nvl(rd.abn_range_desc, ld.abn_range_desc), '' '') over(PARTITION BY a.abnormal_code) abn_range_desc,
               a.delay_amount delay_amount_pr, --延期数量
               a.delivery_amount delivery_amount_pr,
               a.handle_opinions handle_opinions_pr,
               a.is_deduction is_deduction_pr,
               gd_c.group_dict_name deduction_method_desc,
               a.deduction_unit_price deduction_unit_price_pr,
               a.file_id file_id_pr,
               a.problem_class problem_class_pr,
               a.cause_class cause_class_pr,
               a.cause_detailed cause_detailed_pr,
               a.is_sup_responsible,
               /*原代码
               a.responsible_dept responsible_dept_pr,
               a.responsible_dept_sec responsible_dept_sec_pr,*/
               ---LSL167修改 20220728
               a.responsible_dept first_dept_id,
               (SELECT sd.dept_name
                  FROM scmdata.sys_company_dept sd
                 WHERE sd.company_id = a.company_id
                   AND sd.company_dept_id = a.responsible_dept) responsible_dept_pr,
               a.responsible_dept_sec second_dept_id,
               (SELECT sd.dept_name
                  FROM scmdata.sys_company_dept sd
                 WHERE sd.company_id = a.company_id
                   AND sd.company_dept_id = a.responsible_dept_sec) responsible_dept_sec_pr,
               ---end
               a.memo                         memo_pr,
               t.progress_status              progress_status_pr,
               t.supplier_code                supplier_code_pr,
               sp2.supplier_company_name      supplier_company_name_pr,
               t.goo_id                       goo_id_pr,
               cf.style_number                style_number_pr,
               cf.style_name                  style_name_pr,
               t.order_amount                 order_amount_pr,
               oh.delivery_date               delivery_date_pr,
               t.latest_planned_delivery_date latest_planned_delivery_date_pr,
               (CASE
                 WHEN a.orgin_type = ''QA'' THEN
                  qa.qa_report_id
                 WHEN a.orgin_type = ''QC'' THEN
                  qc.qc_check_code
                 ELSE
                  NULL
               END) quality_control_log_id,
               --''查看报告'' QUALITY_CONTROL_REPORT,
               a.check_link,
               a.check_num,
               a.checker,
               a.abnormal_orgin,
               a.origin,
               sa.company_user_name           create_id,
               a.create_time,
               sc.company_user_name           update_id,
               a.update_time,
               sb.company_user_name           confirm_id,
               a.confirm_date                 confirm_date,
               gd_d.group_dict_name           cooperation_classification
          FROM scmdata.t_ordered oh
         INNER JOIN scmdata.t_orders od
            ON oh.company_id = od.company_id
           AND oh.order_code = od.order_id
           AND oh.order_status IN (''OS01'', ''OS02'') --待修改
         INNER JOIN t_production_progress t
            ON t.company_id = od.company_id
           AND t.order_id = od.order_id
           AND t.goo_id = od.goo_id
         INNER JOIN scmdata.t_commodity_info cf
            ON t.company_id = cf.company_id
           AND t.goo_id = cf.goo_id
         INNER JOIN supp sp2
            ON t.company_id = sp2.company_id
           AND t.supplier_code = sp2.supplier_code
         INNER JOIN scmdata.t_abnormal a
            ON t.company_id = a.company_id
           AND t.order_id = a.order_id
           AND t.goo_id = a.goo_id
           AND a.progress_status = ''02''
           AND a.orgin_type <> ''TD''
         INNER JOIN su_user sa
            ON a.company_id = sa.company_id
           AND a.create_id = sa.user_id
         INNER JOIN su_user sb
            ON a.company_id = sb.company_id
           AND a.confirm_id = sb.user_id
          LEFT JOIN su_user sc
            ON a.company_id = sc.company_id
           AND a.update_id = sc.user_id
         INNER JOIN scmdata.sys_group_dict gd
            ON gd.group_dict_type = ''ANOMALY_CLASSIFICATION_DICT''
           AND gd.group_dict_value = a.anomaly_class
          LEFT JOIN group_dict gd_c
            ON gd_c.group_dict_type = ''DEDUCTION_METHOD''
           AND gd_c.group_dict_value = a.deduction_method
          LEFT JOIN group_dict gd_d
            ON gd_d.group_dict_type = ''PRODUCT_TYPE''
           AND gd_d.group_dict_value = cf.category
          LEFT JOIN range_dict rd
            ON (CASE
                 WHEN a.abnormal_range = ''00'' THEN
                  '' 00 ''
                 WHEN a.abnormal_range = ''01'' THEN
                  '' 01 ''
                 ELSE
                  '' 02 ''
               END) = '' '' || rd.abn_range || '' ''
          LEFT JOIN color_dict ld
            ON (instr('' '' || a.abnormal_range || '' '',
                      '' '' || ld.abn_range || '' '') > 0 AND
               ld.order_id = a.order_id AND ld.goo_id = a.goo_id)
          LEFT JOIN scmdata.t_qc_check qc
            ON qc.qc_check_id = a.origin_id
          LEFT JOIN scmdata.t_qa_report qa
            ON qa.qa_report_id = a.origin_id
         WHERE oh.company_id = %default_company_id%
           AND ((%is_company_admin% = 1) OR
               instr_priv(p_str1  => @subsql@,
                           p_str2  => cf.category,
                           p_split => '';'') > 0)
         ORDER BY a.confirm_date DESC)', null, '{declare
v_class_data_privs clob;
begin
 v_class_data_privs := pkg_data_privs.parse_json(p_jsonstr => %data_privs_json_strs%,p_key => ''COL_2'');
 @strresult :=''(SELECT * FROM (SELECT '' || '''''''' || v_class_data_privs || '''''''' || '' FROM dual))'';
end;}', null, null, null, 'ANOMALY_CLASS_PR,PRODUCT_GRESS_ID,COMPANY_ID,SUPPLIER_CODE_PR,FACTORY_CODE_PR,ORDER_ID_PR,ABNORMAL_ID,ABNORMAL_STATUS_PR,HANDLE_OPINIONS_PR,IS_DEDUCTION_PR,ABN_RANGE,PROGRESS_STATUS_PR,FIRST_DEPT_ID,SECOND_DEPT_ID,GOO_ID_PR,GOO_ID,ORIGIN,ABNORMAL_ORGIN,IS_EDIT_ABN_ORGIN,CHECKER,CHECK_LINK,QUALITY_CONTROL_LOG_ID', null, null, null, null, null, 1, null, null, null, null, null, null, null, 1, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, 0, '20,30,50,100,200,500');

prompt Done.
