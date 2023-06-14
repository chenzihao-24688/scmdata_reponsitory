???prompt Importing table bw3.sys_item_list...
set feedback off
set define off
insert into bw3.sys_item_list (ITEM_ID, QUERY_TYPE, QUERY_FIELDS, QUERY_COUNT, EDIT_EXPRESS, NEWID_SQL, SELECT_SQL, DETAIL_SQL, SUBSELECT_SQL, INSERT_SQL, UPDATE_SQL, DELETE_SQL, NOSHOW_FIELDS, NOADD_FIELDS, NOMODIFY_FIELDS, NOEDIT_FIELDS, SUBNOSHOW_FIELDS, UI_TMPL, MULTI_PAGE_FLAG, OUTPUT_PARAMETER, LOCK_SQL, MONITOR_ID, END_FIELD, EXECUTE_TIME, SCANNABLE_FIELD, SCANNABLE_TYPE, AUTO_REFRESH, RFID_FLAG, SCANNABLE_TIME, MAX_ROW_COUNT, NOSHOW_APP_FIELDS, SCANNABLE_LOCATION_LINE, SUB_TABLE_JUDGE_FIELD, BACK_GROUND_ID, OPRETION_HINT, SUB_EDIT_STATE, HINT_TYPE, HEADER, FOOTER, JUMP_FIELD, JUMP_EXPRESS, OPEN_MODE, OPERATION_TYPE, OPERATE_TYPE, PAGE_SIZES)
values ('a_product_110', 3, 'product_gress_code_pr,rela_goo_id,supplier_company_name_pr,style_number_pr', null, null, null, '{DECLARE
  v_class_data_privs CLOB;
  v_sql              CLOB;
BEGIN
  v_class_data_privs := pkg_data_privs.parse_json(p_jsonstr => %data_privs_json_strs%,
                                                  p_key     => ''COL_2'');
  v_sql              := ''WITH supp AS
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
              ''''02'''',
              pno.pno_status,
              ''''00'''',
              gd_b.group_dict_name) progress_status_desc,
       t.order_id order_id_pr,
       cf.rela_goo_id,
       cf.style_number style_number_pr,
       cf.style_name style_name_pr,
       t.supplier_code supplier_code_pr,
       sp2.supplier_company_name supplier_company_name_pr,
       t.factory_code factory_code_pr,
       sp1.supplier_company_name factory_company_name_pr,
       (select listagg(fu.company_user_name, '''';'''') within group(ORDER BY oh.deal_follower)
         from scmdata.sys_company_user fu where instr(oh.deal_follower, fu.user_id) > 0
       AND fu.company_id = oh.company_id) deal_follower,
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
       t.delay_problem_class delay_problem_class_pr,
       t.delay_cause_class delay_cause_class_pr,
       t.delay_cause_detailed delay_cause_detailed_pr,
       t.is_sup_responsible,
       t.responsible_dept first_dept_id,
       sd.dept_name responsible_dept,
       t.responsible_dept_sec,
       t.problem_desc problem_desc_pr,
       t.approve_edition, --Edit by zc
       cf.IS_SET_FABRIC,
       t.fabric_check fabric_check,
       t.CHECK_LINK,
       t.qc_check qc_check_pr,
       t.qa_check qa_check_pr,
       decode(t.exception_handle_status,
              ''''01'''',
              ''''处理中'''',
              ''''02'''',
              ''''已处理'''',
              ''''无异常'''') exception_handle_status_pr,
       gd_d.group_dict_name handle_opinions_pr,
       w.picture,
       t.goo_id goo_id_pr, --这里goo_id是货号
       decode(oh.send_by_sup, 1, ''''是'''', ''''否'''') send_by_sup,
       oh.create_time create_time_po,
       oh.memo             memo_po,
       cf.category         category_code,
       a.group_dict_name   CATEGORY,
       b.group_dict_name   cooperation_product_cate_sp,
       c.company_dict_name product_subclass_desc,
       oh.finish_time,
       t.update_company_id,
       ucu.company_user_name UPDATE_ID_PR,
       t.update_time UPDATE_DATE_PR,

       CASE
         WHEN (t.actual_delay_day > 0 OR
              (t.actual_delay_day = 0 AND
              trunc(SYSDATE) - trunc(oh.delivery_date) > 0 AND
              (t.delivery_amount / t.order_amount) <= CASE
                WHEN cf.category = ''''07'''' THEN
                 0.86
                WHEN cf.category = ''''06'''' THEN
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
   AND oh.order_status = ''''OS01'''' --待修改
 INNER JOIN t_production_progress t
    ON t.company_id = od.company_id
   AND t.order_id = od.order_id
   AND t.goo_id = od.goo_id
   AND t.progress_status <> ''''01''''
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
    ON a.group_dict_type = ''''PRODUCT_TYPE''''
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
  LEFT JOIN (SELECT pno_status, product_gress_id
               FROM (SELECT row_number() over(partition by pn.product_gress_id order by pn.node_num desc) rn,
                            pn.node_name || gd_a.group_dict_name pno_status,
                            pn.product_gress_id
                       FROM scmdata.t_production_node pn
                      INNER JOIN group_dict gd_a
                         ON gd_a.group_dict_type = ''''PROGRESS_NODE_TYPE''''
                        AND gd_a.group_dict_value = pn.progress_status
                      WHERE pn.company_id = %default_company_id%
                        AND pn.progress_status IS NOT NULL)
              WHERE rn = 1) pno
    ON pno.product_gress_id = t.product_gress_id
  LEFT JOIN group_dict gd_b
    ON gd_b.group_dict_type = ''''PROGRESS_TYPE''''
   AND gd_b.group_dict_value = t.progress_status
  LEFT JOIN group_dict gd_d
    ON gd_d.group_dict_type = ''''HANDLE_RESULT''''
   AND gd_d.group_dict_value = t.handle_opinions
  left join scmdata.sys_company_user ucu
  on ucu.company_id=t.update_company_id
  and ucu.user_id=t.update_id
 WHERE oh.company_id = %default_company_id% AND ((%is_company_admin%) = 1 OR instr_priv(p_str1 => '''''' ||
                        v_class_data_privs ||
                        '''''', p_str2 => cf.category, p_split => '''';'''') > 0) ORDER BY t.product_gress_code DESC, t.create_time DESC'';

  @strresult := v_sql;
END;}', null, null, null, 'DECLARE
  v_is_sup_exemption NUMBER;
  v_first_dept_id    VARCHAR2(100);
  v_second_dept_id   VARCHAR2(100);
  v_is_quality       NUMBER;
  v_flag             NUMBER;
  v_dept_name        VARCHAR2(32);
BEGIN

  SELECT MAX(t.is_order_reamem_upd)
    INTO v_flag
    FROM scmdata.t_production_progress t
   WHERE t.product_gress_id = :product_gress_id;

  --新增 交期变更数据 "延期问题分类、延期原因分类、延期原因细分、问题描述"已对接熊猫,不可修改！
  IF v_flag = 1 THEN
    raise_application_error(-20002,
                            ''提示："延期问题分类、延期原因分类、延期原因细分、问题描述"交期变更数据已对接熊猫,不可修改！'');
  ELSE
    --增加校验逻辑：延期问题分类、延期原因分类、延期原因细分有值，则问题描述必填
    IF :delay_problem_class_pr IS NOT NULL AND
       :delay_cause_class_pr IS NOT NULL AND
       :delay_cause_detailed_pr IS NOT NULL THEN
      IF :problem_desc_pr IS NULL THEN
        raise_application_error(-20002,
                                ''提示：延期问题分类、延期原因分类、延期原因细分有值，则问题描述必填！'');
      ELSE
        SELECT ad.is_sup_exemption,
               ad.first_dept_id      first_dept_name,
               ad.second_dept_id     second_dept_name,
               ad.is_quality_problem
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
      
        SELECT t.dept_name
          INTO v_dept_name
          FROM scmdata.sys_company_dept t
         WHERE t.company_dept_id =
               nvl(:responsible_dept_sec, v_second_dept_id);
      
        IF v_dept_name <> ''无'' THEN
          SELECT COUNT(1)
            INTO v_flag
            FROM (SELECT t.company_dept_id
                    FROM scmdata.sys_company_dept t
                   START WITH t.company_dept_id = v_first_dept_id
                  CONNECT BY PRIOR t.company_dept_id = t.parent_id)
           WHERE company_dept_id =
                 nvl(:responsible_dept_sec, v_second_dept_id);
        
          IF v_flag = 0 THEN
            raise_application_error(-20002,
                                    ''保存失败！责任部门(2级)必须为责任部门(1级)的下级部门，请检查！'');
          END IF;
        ELSE
          NULL;
        END IF;
      END IF;
    ELSE
      IF :responsible_dept_sec IS NOT NULL THEN
        raise_application_error(-20002,
                                ''保存失败！责任部门(2级)不为空时,延期问题分类、延期原因分类、延期原因细分必填！'');
      ELSE
        NULL;
      END IF;
    END IF;
  
    UPDATE scmdata.t_production_progress t
       SET t.delay_problem_class  = :delay_problem_class_pr,
           t.delay_cause_class    = :delay_cause_class_pr,
           t.delay_cause_detailed = :delay_cause_detailed_pr,
           t.problem_desc         = :problem_desc_pr,
           t.is_sup_responsible   = v_is_sup_exemption,
           t.responsible_dept     = v_first_dept_id,
           t.responsible_dept_sec = nvl(:responsible_dept_sec,
                                        v_second_dept_id),
           t.is_quality           = v_is_quality,
           t.update_company_id    = %default_company_id%,
           t.update_id            = :user_id,
           t.update_time          = SYSDATE
     WHERE t.product_gress_id = :product_gress_id;
  END IF;
END;', null, 'product_gress_id,fabric_check,company_id,supplier_code_pr,factory_code_pr,order_id_pr,progress_status_pr,qc_check_pr,qa_check_pr,approve_edition,check_link,category_code,first_dept_id,responsible_dept_sec', null, null, null, null, null, 1, null, null, null, null, null, null, null, 1, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, 0, '20,30,50,100,200,500');

prompt Done.
