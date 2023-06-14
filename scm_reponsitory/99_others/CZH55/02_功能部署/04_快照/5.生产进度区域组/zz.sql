???prompt Importing table bw3.sys_item_list...
set feedback off
set define off
insert into bw3.sys_item_list (ITEM_ID, QUERY_TYPE, QUERY_FIELDS, QUERY_COUNT, EDIT_EXPRESS, NEWID_SQL, SELECT_SQL, DETAIL_SQL, SUBSELECT_SQL, INSERT_SQL, UPDATE_SQL, DELETE_SQL, NOSHOW_FIELDS, NOADD_FIELDS, NOMODIFY_FIELDS, NOEDIT_FIELDS, SUBNOSHOW_FIELDS, UI_TMPL, MULTI_PAGE_FLAG, OUTPUT_PARAMETER, LOCK_SQL, MONITOR_ID, END_FIELD, EXECUTE_TIME, SCANNABLE_FIELD, SCANNABLE_TYPE, AUTO_REFRESH, RFID_FLAG, SCANNABLE_TIME, MAX_ROW_COUNT, NOSHOW_APP_FIELDS, SCANNABLE_LOCATION_LINE, SUB_TABLE_JUDGE_FIELD, BACK_GROUND_ID, OPRETION_HINT, SUB_EDIT_STATE, HINT_TYPE, HEADER, FOOTER, JUMP_FIELD, JUMP_EXPRESS, OPEN_MODE, OPERATION_TYPE, OPERATE_TYPE, PAGE_SIZES)
values ('a_report_120', 3, 'product_gress_code,rela_goo_id,supplier_company_name', null, null, null, 'WITH company_user AS
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
 ORDER BY pt.year DESC, pt.month DESC', null, '{declare
v_class_data_privs clob;
begin
 v_class_data_privs := pkg_data_privs.parse_json(p_jsonstr => %data_privs_json_strs%,p_key => ''COL_2'');
 @strresult :=''(SELECT * FROM (SELECT '' || '''''''' || v_class_data_privs || '''''''' || '' FROM dual))'';
end;}', null, '--dyy153 220715 修改分岗位编辑字段
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

END;*/', null, 'goo_id_pr,company_id,pt_ordered_id,company_id,order_id,first_dept_id,responsible_dept_sec,deal_follower,qc_id,GROUP_NAME', null, null, null, null, null, 1, null, null, null, null, null, null, null, 1, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, 0, '20,30,50,100,200,500');

prompt Done.
