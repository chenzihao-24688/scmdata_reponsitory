DECLARE
  v_sql CLOB;
  v_update_sql CLOB;
  v_noshow_list CLOB;
BEGIN
  v_sql         := '{DECLARE
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
 WHERE oh.company_id = %default_company_id% AND ((%is_company_admin%) = 1 OR instr_priv(p_str1 => '''''' ||
                        v_class_data_privs ||
                        '''''', p_str2 => cf.category, p_split => '''';'''') > 0) ORDER BY t.product_gress_code DESC, t.create_time DESC'';

  @strresult := v_sql;
END;}';
  v_update_sql  := 'DECLARE
  v_is_sup_exemption NUMBER;
  v_first_dept_id    VARCHAR2(100);
  v_second_dept_id   VARCHAR2(100);
  v_is_quality       NUMBER;
  v_flag             NUMBER;

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
               ad.first_dept_id first_dept_name,
               ad.second_dept_id second_dept_name,
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
           
        SELECT COUNT(1) 
         INTO v_flag
        FROM (SELECT t.company_dept_id
          FROM scmdata.sys_company_dept t
         START WITH t.company_dept_id = v_first_dept_id
        CONNECT BY PRIOR t.company_dept_id = t.parent_id)
         WHERE company_dept_id = nvl(:responsible_dept_sec,v_second_dept_id);
           
        IF v_flag = 0 THEN
          raise_application_error(-20002,
                                  ''保存失败！责任部门(2级)必须为责任部门(1级)的下级部门，请检查！'');
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
           t.responsible_dept_sec = nvl(:responsible_dept_sec,v_second_dept_id),
           t.is_quality           = v_is_quality,
           t.update_company_id=%default_company_id%,
           t.update_id=:user_id,
           t.update_time=sysdate
     WHERE t.product_gress_id = :product_gress_id;
  END IF;

END;';
  v_noshow_list := 'product_gress_id,fabric_check,company_id,supplier_code_pr,factory_code_pr,order_id_pr,progress_status_pr,qc_check_pr,qa_check_pr,approve_edition,check_link,category_code,first_dept_id,responsible_dept_sec';

update bw3.sys_item_list t set t.select_sql = v_sql ,t.update_sql = v_update_sql,t.noshow_fields = v_noshow_list where t.item_id = 'a_product_110';
END;
/
DECLARE
  v_sql CLOB;
  v_noshow_list CLOB;
BEGIN
  v_sql         := '{DECLARE
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
       t.progress_status         progress_status_pr,
       t.product_gress_code      product_gress_code_pr,
       a.group_dict_name         progress_status_desc,
       t.order_id                order_id_pr,
       cf.rela_goo_id,
       cf.style_number           style_number_pr,
       cf.style_name             style_name_pr,
       t.supplier_code           supplier_code_pr,
       sp2.supplier_company_name supplier_company_name_pr,
       t.factory_code            factory_code_pr,
       sp1.supplier_company_name factory_company_name_pr,
       (select listagg(fu.company_user_name, '''';'''') within group(ORDER BY oh.deal_follower)
         from scmdata.sys_company_user fu where instr(oh.deal_follower, fu.user_id) > 0
       AND fu.company_id = oh.company_id) deal_follower,
       oh.delivery_date delivery_date_pr, --update by czh 20210527（1）生产进度表中的订单交期取下单列表的订单交期（即熊猫的交期日期）
       oh.finish_time_scm finish_time_scm_pr,
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
       t.goo_id goo_id_pr,
       decode(oh.send_by_sup, 1, ''''是'''', ''''否'''') send_by_sup,
       oh.create_time create_time_po,
       oh.memo memo_po,
       cf.category         category_code,
       c.group_dict_name CATEGORY,
       d.group_dict_name cooperation_product_cate_sp,
       e.company_dict_name product_subclass_desc,
       oh.finish_time,
       oh.finish_time_scm,
       su.nick_name finish_id_pr,
       decode(oh.finish_type,''''01'''',''''自动结束'''',''''手动结束'''') finish_type
  FROM scmdata.t_ordered oh
 INNER JOIN scmdata.t_orders od
    ON oh.company_id = od.company_id
   AND oh.order_code = od.order_id
   AND oh.order_status IN (''''OS01'''', ''''OS02'''') --待修改
 INNER JOIN t_production_progress t
    ON t.company_id = od.company_id
   AND t.order_id = od.order_id
   AND t.goo_id = od.goo_id
   AND t.progress_status = ''''01''''
 INNER JOIN group_dict a
    ON a.group_dict_type = ''''PROGRESS_TYPE''''
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
    ON c.group_dict_type = ''''PRODUCT_TYPE''''
   AND c.group_dict_value = cf.category
  LEFT JOIN group_dict d
    ON d.group_dict_type = c.group_dict_value
   AND d.group_dict_value = cf.product_cate
  LEFT JOIN scmdata.sys_company_dict e
    ON e.company_dict_type = d.group_dict_value
    AND e.company_dict_value = cf.samll_category
   AND e.company_id = %default_company_id%
  LEFT JOIN scmdata.sys_company_dept sd
  ON sd.company_id = t.company_id
   AND sd.company_dept_id = t.responsible_dept 
  LEFT JOIN group_dict gd_d
    on gd_d.group_dict_type = ''''HANDLE_RESULT''''
   AND gd_d.group_dict_value = t.handle_opinions
 WHERE oh.company_id = %default_company_id%
   AND ((%is_company_admin%) = 1 OR
       instr_priv(p_str1  => ''''''||v_class_data_privs||'''''' ,p_str2  => cf.category ,p_split => '''';'''') > 0)
 ORDER BY t.product_gress_code DESC, oh.finish_time_scm DESC'';
  @strresult := v_sql;
END;}';

  v_noshow_list := 'product_gress_id,fabric_check,product_gress_id,company_id,supplier_code_pr,factory_code_pr,order_id_pr,progress_status_pr,qc_check_pr,qa_check_pr,approve_edition,check_link,category_code,first_dept_id,responsible_dept_sec';

update bw3.sys_item_list t set t.select_sql = v_sql ,t.noshow_fields = v_noshow_list where t.item_id = 'a_product_116';
END;
/
begin
 insert into bw3.sys_element (ELEMENT_ID, ELEMENT_TYPE, DATA_SOURCE, PAUSE, MESSAGE, IS_HIDE, MEMO, IS_ASYNC, IS_PER_EXE, ENABLE_STAND_PERMISSION)
values ('look_a_product_110', 'lookup', 'oracle_scmdata', 0, null, null, null, null, null, null);
insert into bw3.sys_look_up (ELEMENT_ID, FIELD_NAME, LOOK_UP_SQL, DATA_TYPE, KEY_FIELD, RESULT_FIELD, BEFORE_FIELD, SEARCH_FLAG, MULTI_VALUE_FLAG, DISABLED_FIELD, GROUP_FIELD, VALUE_SEP, ICON, PORT_ID, PORT_SQL)
values ('look_a_product_110', 'SECOND_DEPT_ID_DESC', '{DECLARE
  v_sql CLOB;
  v_cate_code varchar2(32) := :category_code;
BEGIN
  IF v_cate_code IS NOT NULL THEN
    v_sql := q''[SELECT a.company_dept_id responsible_dept_sec,
         a.dept_name       second_dept_id_desc
    FROM scmdata.sys_company_dept a
   INNER JOIN scmdata.sys_company_dept_cate_map b
      ON a.company_dept_id = b.company_dept_id
     AND a.company_id = b.company_id
     AND b.cooperation_type = ''PRODUCT_TYPE''
     AND b.cooperation_classification = :category_code
   WHERE a.company_id = %default_company_id%
     AND a.pause = 0]'';
  ELSE
    v_sql := q''[SELECT a.company_dept_id responsible_dept_sec,
         a.dept_name       second_dept_id_desc
    FROM scmdata.sys_company_dept a
   WHERE a.company_id = %default_company_id%
     AND a.pause = 0]'';
  END IF;
  @strresult := v_sql;
END;}', '1', 'RESPONSIBLE_DEPT_SEC', 'SECOND_DEPT_ID_DESC', 'RESPONSIBLE_DEPT_SEC', 1, 0, null, null, null, null, null, null);
insert into bw3.sys_item_element_rela (ITEM_ID, ELEMENT_ID, SEQ_NO, PAUSE, LEVEL_NO)
values ('a_product_110', 'look_a_product_110', 1, 0, null);
insert into bw3.sys_item_element_rela (ITEM_ID, ELEMENT_ID, SEQ_NO, PAUSE, LEVEL_NO)
values ('a_product_116', 'look_a_product_110', 1, 0, null);
end;
/
begin
insert into bw3.sys_element (ELEMENT_ID, ELEMENT_TYPE, DATA_SOURCE, PAUSE, MESSAGE, IS_HIDE, MEMO, IS_ASYNC, IS_PER_EXE, ENABLE_STAND_PERMISSION)
values ('look_a_product_110_1', 'lookup', 'oracle_scmdata', 0, null, null, null, null, null, null);

insert into bw3.sys_look_up (ELEMENT_ID, FIELD_NAME, LOOK_UP_SQL, DATA_TYPE, KEY_FIELD, RESULT_FIELD, BEFORE_FIELD, SEARCH_FLAG, MULTI_VALUE_FLAG, DISABLED_FIELD, GROUP_FIELD, VALUE_SEP, ICON, PORT_ID, PORT_SQL)
values ('look_a_product_110_1', 'RESPONSIBLE_DEPT', 'SELECT a.company_dept_id FIRST_DEPT_ID,
       a.dept_name       RESPONSIBLE_DEPT
  FROM scmdata.sys_company_dept a
 WHERE a.company_id = %default_company_id%
   AND a.pause = 0', '1', 'FIRST_DEPT_ID', 'RESPONSIBLE_DEPT', 'FIRST_DEPT_ID', 1, 0, null, null, null, null, null, null);

insert into bw3.sys_item_element_rela (ITEM_ID, ELEMENT_ID, SEQ_NO, PAUSE, LEVEL_NO)
values ('a_product_110', 'look_a_product_110_1', 1, 0, null);

insert into bw3.sys_item_element_rela (ITEM_ID, ELEMENT_ID, SEQ_NO, PAUSE, LEVEL_NO)
values ('a_product_116', 'look_a_product_110_1', 1, 0, null);
end;
/
DECLARE
  v_sql CLOB;
BEGIN
  v_sql := q'[SELECT ad.problem_classification delay_problem_class_pr,
       ad.cause_classification   delay_cause_class_pr,
       ad.cause_detail           delay_cause_detailed_pr,
       ad.is_sup_exemption       is_sup_responsible,
       ad.first_dept_id,
       ad.second_dept_id         responsible_dept_sec
  FROM scmdata.t_commodity_info tc
 INNER JOIN scmdata.t_abnormal_range_config ar
    ON tc.company_id = ar.company_id
   AND tc.category = ar.industry_classification
   AND tc.product_cate = ar.production_category
   AND instr(';' || ar.product_subclass || ';',
             ';' || tc.samll_category || ';') > 0
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
   AND ad.anomaly_classification = 'AC_DATE']';
  UPDATE bw3.sys_pick_list t
     SET t.pick_sql = v_sql,t.other_fields = 'DELAY_PROBLEM_CLASS_PR,DELAY_CAUSE_CLASS_PR,DELAY_CAUSE_DETAILED_PR,IS_SUP_RESPONSIBLE,FIRST_DEPT_ID,RESPONSIBLE_DEPT_SEC'
   WHERE t.element_id = 'pick_a_product_110_1'; 
END;
