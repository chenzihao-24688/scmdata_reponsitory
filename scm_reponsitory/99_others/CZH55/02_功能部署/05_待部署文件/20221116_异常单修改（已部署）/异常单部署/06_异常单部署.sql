DECLARE
v_select_sql CLOB;
v_insert_sql CLOB;
v_update_sql CLOB;
v_delete_sql CLOB;
BEGIN
  v_select_sql := 'WITH supp AS
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
         ORDER BY a.create_time DESC)';
         
v_insert_sql := 'DECLARE
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
                                   (''ed7ff3c7135a236ae0533c281caccd8d'', ''b550778b4f2d36b4e0533c281caca074'') THEN --供应商/生产管理部
                               ''QC_FINAL_CHECK''
                              WHEN v_abn_origin = ''b550778b4f3f36b4e0533c281caca074'' THEN --生产技术部
                               ''AC''
                              ELSE
                               NULL
                            END; --查货环节
    p_abn_rec.check_num := CASE
                             WHEN v_abn_origin IN (''ed7ff3c7135a236ae0533c281caccd8d'',
                                                   ''b550778b4f2d36b4e0533c281caca074'',
                                                   ''b550778b4f3f36b4e0533c281caca074'') THEN --供应商/生产管理部、生产技术部
                              1
                             ELSE
                              NULL
                           END;
  END IF;
  --提交异常单
  scmdata.pkg_production_progress.handle_abnormal(p_abn_rec => p_abn_rec);
END;';

v_update_sql := 'DECLARE
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
  IF :abnormal_orgin NOT IN
       (''ed7ff3c7135a236ae0533c281caccd8d'',
        ''b550778b4f2d36b4e0533c281caca074'') THEN
       p_abn_rec.checker := NULL;
  ELSE
      p_abn_rec.checker    := :checker; --查货人
  END IF;
  
  IF :abnormal_orgin NOT IN
       (''ed7ff3c7135a236ae0533c281caccd8d'',
        ''b550778b4f2d36b4e0533c281caca074'',
        ''b550778b4f3f36b4e0533c281caca074'') THEN
      p_abn_rec.check_link := NULL;
      p_abn_rec.check_num  := NULL;
  ELSE
     p_abn_rec.check_link := :check_link; --查货环节
     p_abn_rec.check_num  := :check_num;   
  END IF;
  scmdata.pkg_production_progress_a.p_check_abnormal_by_update(p_abn_rec => p_abn_rec);
  scmdata.pkg_production_progress.update_abnormal(p_abn_rec => p_abn_rec);

END;';
  v_delete_sql := q'[
BEGIN
scmdata.pkg_production_progress_a.p_check_abnormal_by_delete(p_company_id => %default_company_id%,p_user_id => :user_id,p_abnormal_id => :abnormal_id_pr);
scmdata.pkg_production_progress_a.p_delete_abormal(p_company_id => %default_company_id%,p_abnormal_id => :abnormal_id_pr);
END;]';   
UPDATE bw3.sys_item_list t SET t.select_sql = v_select_sql,t.insert_sql = v_insert_sql,t.update_sql = v_update_sql,t.delete_sql = v_delete_sql,t.noshow_fields = 'PRODUCT_GRESS_ID,COMPANY_ID,SUPPLIER_CODE_PR,FACTORY_CODE_PR,ORDER_ID_PR,ABNORMAL_ID_PR,ABNORMAL_STATUS_PR,IS_DEDUCTION_PR,HANDLE_OPINIONS_PR,ANOMALY_CLASS_PR,RESPONSIBLE_PARTY_PR,DEDUCTION_METHOD_PR,ABN_RANGE,PROGRESS_STATUS_PR,FIRST_DEPT_ID,SECOND_DEPT_ID,GOO_ID_PR,GOO_ID,ORIGIN,ABNORMAL_ORGIN,IS_EDIT_ABN_ORGIN,ORIGIN_DESC,CHECKER,CHECK_LINK' WHERE t.item_id = 'a_product_118';
END;
/
DECLARE
v_select_sql CLOB;
v_insert_sql CLOB;
v_update_sql CLOB;
v_delete_sql CLOB;
BEGIN
v_select_sql := 'WITH supp AS
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
         ORDER BY a.create_time DESC)';

v_update_sql := 'DECLARE
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
  IF :abnormal_orgin NOT IN
       (''ed7ff3c7135a236ae0533c281caccd8d'',
        ''b550778b4f2d36b4e0533c281caca074'') THEN
       p_abn_rec.checker := NULL;
  ELSE
      p_abn_rec.checker    := :checker; --查货人
  END IF;
  
  IF :abnormal_orgin NOT IN
       (''ed7ff3c7135a236ae0533c281caccd8d'',
        ''b550778b4f2d36b4e0533c281caca074'',
        ''b550778b4f3f36b4e0533c281caca074'') THEN
      p_abn_rec.check_link := NULL;
      p_abn_rec.check_num  := NULL;
  ELSE
     p_abn_rec.check_link := :check_link; --查货环节
     p_abn_rec.check_num  := :check_num;   
  END IF;
  
  scmdata.pkg_production_progress_a.p_check_abnormal_by_update(p_abn_rec => p_abn_rec);
  scmdata.pkg_production_progress.update_abnormal(p_abn_rec => p_abn_rec);

END;';
  v_delete_sql := q'[
DECLARE
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
     AND t.progress_status = '01';

  IF v_flag > 0 THEN
  
    scmdata.pkg_production_progress.sync_abnormal(p_abn_rec => p_abn_rec,
                                                  p_status  => '01');
  ELSE
  
    SELECT COUNT(1)
      INTO v_abn_flag
      FROM scmdata.t_abnormal t
     WHERE t.company_id = p_abn_rec.company_id
        AND t.order_id = p_abn_rec.order_id
       AND t.goo_id = p_abn_rec.goo_id
       AND t.progress_status = '02';
       
    IF v_abn_flag > 0 THEN
      p_abn_rec.handle_opinions := :handle_opinions_pr;
      scmdata.pkg_production_progress.sync_abnormal(p_abn_rec => p_abn_rec,
                                                    p_status  => '02');
    ELSE
      p_abn_rec.handle_opinions := '';
      scmdata.pkg_production_progress.sync_abnormal(p_abn_rec => p_abn_rec,
                                                    p_status  => '00');
    END IF;
  
  END IF;
END;]';
UPDATE bw3.sys_item_list t SET t.select_sql = v_select_sql,t.update_sql = v_update_sql,t.delete_sql = v_delete_sql,t.noshow_fields = 'ABNORMAL_ID,ANOMALY_CLASS_PR,PRODUCT_GRESS_ID,COMPANY_ID,SUPPLIER_CODE_PR,FACTORY_CODE_PR,ORDER_ID_PR,ABNORMAL_STATUS_PR,HANDLE_OPINIONS_PR,IS_DEDUCTION_PR,CONFIRM_ID,CONFIRM_DATE,DEDUCTION_METHOD_PR,RESPONSIBLE_PARTY_PR,ABN_RANGE,PROGRESS_STATUS_PR,FIRST_DEPT_ID,SECOND_DEPT_ID,GOO_ID_PR,GOO_ID,ORIGIN,ABNORMAL_ORGIN,IS_EDIT_ABN_ORGIN,CHECKER,CHECK_LINK,QUALITY_CONTROL_LOG_ID' WHERE t.item_id = 'a_product_120_1';
END;
/
DECLARE
v_select_sql CLOB;
v_insert_sql CLOB;
v_update_sql CLOB;
BEGIN
v_select_sql := 'WITH supp AS
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
         ORDER BY a.confirm_date DESC)';
    
UPDATE bw3.sys_item_list t SET t.select_sql = v_select_sql,t.insert_sql = v_insert_sql,t.noshow_fields = 'ANOMALY_CLASS_PR,PRODUCT_GRESS_ID,COMPANY_ID,SUPPLIER_CODE_PR,FACTORY_CODE_PR,ORDER_ID_PR,ABNORMAL_ID,ABNORMAL_STATUS_PR,HANDLE_OPINIONS_PR,IS_DEDUCTION_PR,ABN_RANGE,PROGRESS_STATUS_PR,FIRST_DEPT_ID,SECOND_DEPT_ID,GOO_ID_PR,GOO_ID,ORIGIN,ABNORMAL_ORGIN,IS_EDIT_ABN_ORGIN,CHECKER,CHECK_LINK,QUALITY_CONTROL_LOG_ID' WHERE t.item_id = 'a_product_120_2';
END;
/
BEGIN
insert into bw3.sys_element (ELEMENT_ID, ELEMENT_TYPE, DATA_SOURCE, PAUSE, MESSAGE, IS_HIDE, MEMO, IS_ASYNC, IS_PER_EXE)
values ('look_a_product_118_1', 'lookup', 'oracle_scmdata', 0, null, 0, null, null, NULL);

insert into bw3.sys_element (ELEMENT_ID, ELEMENT_TYPE, DATA_SOURCE, PAUSE, MESSAGE, IS_HIDE, MEMO, IS_ASYNC, IS_PER_EXE)
values ('look_a_product_118_2', 'lookup', 'oracle_scmdata', 0, null, 0, null, null, NULL);

insert into bw3.sys_element (ELEMENT_ID, ELEMENT_TYPE, DATA_SOURCE, PAUSE, MESSAGE, IS_HIDE, MEMO, IS_ASYNC, IS_PER_EXE)
values ('look_a_product_120_1', 'lookup', 'oracle_scmdata', 0, null, 0, null, null, NULL);

insert into bw3.sys_element (ELEMENT_ID, ELEMENT_TYPE, DATA_SOURCE, PAUSE, MESSAGE, IS_HIDE, MEMO, IS_ASYNC, IS_PER_EXE)
values ('look_a_product_120_1_1', 'lookup', 'oracle_scmdata', 0, null, 0, null, null, NULL);

END;
/
DECLARE
v_sql1 CLOB;
v_sql2 CLOB;
v_sql3 CLOB;
v_sql4 CLOB;
BEGIN
  v_sql1 := '{
DECLARE
  v_sql CLOB;
BEGIN
  v_sql := scmdata.pkg_production_progress_a.f_get_checker_look_sql(p_data_source => ''SC'',
                                                                    p_company_id  => %default_company_id%);
  IF :origin = ''MA'' THEN
    v_sql := scmdata.pkg_production_progress_a.f_get_checker_look_sql(p_data_source => ''MA'',
                                                                      p_company_id  => %default_company_id%);
  END IF;
  @strresult := v_sql;
END;
}';
insert into bw3.sys_look_up (ELEMENT_ID, FIELD_NAME, LOOK_UP_SQL, DATA_TYPE, KEY_FIELD, RESULT_FIELD, BEFORE_FIELD, SEARCH_FLAG, MULTI_VALUE_FLAG, DISABLED_FIELD, GROUP_FIELD, VALUE_SEP, ICON, PORT_ID, PORT_SQL)
values ('look_a_product_118_1', 'CHECKER_DESC',v_sql1 , '1', 'CHECKER', 'CHECKER_DESC', 'CHECKER', 0, 1, '0', null, ';', null, null, null);

v_sql2 := '{
DECLARE
  v_sql1 CLOB;
  v_sql2 CLOB;
  v_sql  CLOB;
BEGIN
  v_sql1 := scmdata.pkg_plat_comm.f_get_lookup_sql_by_type(p_group_dict_type => ''QC_CHECK_NODE_DICT'',
                                                           p_field_value     => ''CHECK_LINK'',
                                                           p_field_desc      => ''CHECK_GD_LINK_DESC'');
  v_sql2 := scmdata.pkg_plat_comm.f_get_lookup_sql_by_type(p_group_dict_type => ''QA_CHECKTYPE'',
                                                           p_field_value     => ''CHECK_LINK'',
                                                           p_field_desc      => ''CHECK_GD_LINK_DESC'');

  v_sql := v_sql1 || '' UNION ALL '' || v_sql2;
  IF :abnormal_orgin IN (''ed7ff3c7135a236ae0533c281caccd8d'', ''b550778b4f2d36b4e0533c281caca074'') THEN
    v_sql := v_sql1;
  ELSIF :abnormal_orgin IN (''b550778b4f3f36b4e0533c281caca074'') THEN
    v_sql := v_sql2;
  ELSE
    NULL;
  END IF;
  @strresult := v_sql;
END;
}';
insert into bw3.sys_look_up (ELEMENT_ID, FIELD_NAME, LOOK_UP_SQL, DATA_TYPE, KEY_FIELD, RESULT_FIELD, BEFORE_FIELD, SEARCH_FLAG, MULTI_VALUE_FLAG, DISABLED_FIELD, GROUP_FIELD, VALUE_SEP, ICON, PORT_ID, PORT_SQL)
values ('look_a_product_118_2', 'CHECK_GD_LINK_DESC', v_sql2, '1', 'CHECK_LINK', 'CHECK_GD_LINK_DESC', 'CHECK_LINK', 0, 0, '0', null, null, null, null, null);

v_sql3 := '{
DECLARE
  v_sql CLOB;
BEGIN
  v_sql      := scmdata.pkg_production_progress_a.f_get_abn_source_look_sql(p_company_id => %default_company_id%);
  @strresult := v_sql;
END;
}';
insert into bw3.sys_look_up (ELEMENT_ID, FIELD_NAME, LOOK_UP_SQL, DATA_TYPE, KEY_FIELD, RESULT_FIELD, BEFORE_FIELD, SEARCH_FLAG, MULTI_VALUE_FLAG, DISABLED_FIELD, GROUP_FIELD, VALUE_SEP, ICON, PORT_ID, PORT_SQL)
values ('look_a_product_120_1', 'ABN_ORGIN_DESC',v_sql3 , '1', 'ABNORMAL_ORGIN', 'ABN_ORGIN_DESC', 'ABNORMAL_ORGIN', 0, 0, '0', null, null, null, null, null);

v_sql4 := '{
DECLARE
  v_sql CLOB;
BEGIN
  v_sql      := scmdata.pkg_production_progress_a.f_get_data_source_look_sql();
  @strresult := v_sql;
END;
}';
insert into bw3.sys_look_up (ELEMENT_ID, FIELD_NAME, LOOK_UP_SQL, DATA_TYPE, KEY_FIELD, RESULT_FIELD, BEFORE_FIELD, SEARCH_FLAG, MULTI_VALUE_FLAG, DISABLED_FIELD, GROUP_FIELD, VALUE_SEP, ICON, PORT_ID, PORT_SQL)
values ('look_a_product_120_1_1', 'ORIGIN_DESC', v_sql4, '1', 'ORIGIN', 'ORIGIN_DESC', 'ORIGIN', 0, 0, '0', null, null, null, null, null);
END;
/
DECLARE
v_sql CLOB;
BEGIN
  v_sql := 'DECLARE
  v_abn_code_cp    VARCHAR2(32) := @abnormal_code_cp@;
  v_flag           NUMBER;
  v_abn_range      VARCHAR2(4000);
  v_order_id       VARCHAR2(4000);
  v_order_amount   NUMBER;
  v_color_code     VARCHAR2(4000);
  v_interset_color VARCHAR2(4000);
BEGIN
  SELECT COUNT(1)
    INTO v_flag
    FROM scmdata.t_abnormal t
   WHERE t.company_id = %default_company_id%
     AND t.create_id = :user_id
     AND t.abnormal_code = v_abn_code_cp;
  IF v_flag = 0 THEN
    raise_application_error(-20002,
                            ''提示：输入异常处理编码不存在/错误，请检查！！'');
  ELSE
    SELECT COUNT(1)
      INTO v_flag
      FROM scmdata.t_abnormal a
     WHERE a.company_id = %default_company_id%
       AND a.create_id = :user_id
       AND a.abnormal_code IN (@selection)
       AND NOT EXISTS
     (SELECT 1
              FROM scmdata.t_abnormal b
             WHERE b.company_id = a.company_id
               AND b.create_id = a.create_id
               AND b.abnormal_code = v_abn_code_cp
               AND b.goo_id = a.goo_id
               AND b.anomaly_class = a.anomaly_class);
  
    IF v_flag > 0 THEN
      raise_application_error(-20002,
                              ''提示：所勾选异常单与被复制异常单的[货号+异常分类]相同时才可复制，请检查！！'');
    ELSE
    
      SELECT MAX(b.abnormal_range)
        INTO v_abn_range
        FROM scmdata.t_abnormal b
       WHERE b.company_id = %default_company_id%
         AND b.create_id = :user_id
         AND b.abnormal_code = v_abn_code_cp;
    
      IF v_abn_range NOT IN (''00'', ''01'') THEN
        SELECT listagg(a.order_id, ''、'')
          INTO v_order_id
          FROM scmdata.t_abnormal a
          LEFT JOIN (SELECT od.goo_id,
                            od.order_id,
                            listagg(tcs.color_code, '' '') color_code
                       FROM scmdata.t_ordersitem od
                      INNER JOIN scmdata.t_commodity_info tc
                         ON od.goo_id = tc.goo_id
                      INNER JOIN scmdata.t_commodity_color_size tcs
                         ON tc.commodity_info_id = tcs.commodity_info_id
                        AND od.barcode = tcs.barcode
                      WHERE od.company_id = %default_company_id%
                      GROUP BY od.goo_id, od.order_id) v
            ON v.goo_id = a.goo_id
           AND v.order_id = a.order_id
         WHERE a.company_id = %default_company_id%
           AND a.create_id = :user_id
           AND a.abnormal_code IN (@selection)
           AND scmdata.instr_priv(p_str1  => '' '' || v_abn_range || '' '',
                                  p_str2  => '' '' || v.color_code || '' '',
                                  p_split => '' '') = 0;
        IF v_order_id IS NOT NULL THEN
          raise_application_error(-20002,
                                  ''复制失败！所选订单('' || v_order_id ||
                                  '') 与被复制订单”异常范围“的颜色不一致，请检查！！'');
        END IF;
      END IF;
      --满足校验逻辑，则进行异常单复制
      FOR abn_rec IN (SELECT t.*
                        FROM scmdata.t_abnormal t
                       WHERE t.company_id = %default_company_id%
                         AND t.create_id = :user_id
                         AND t.abnormal_code IN (@selection)) LOOP
        --判断被复制异常单的异常范围，数量取值按以下逻辑赋值
        --全部 则复制订单数量
        --指定数量 则为空，提交时校验必填
        --颜色  勾选异常单订单颜色与被复制异常单订单颜色的交集，并获取对应颜色的订单数量
        IF '' '' || v_abn_range || '' '' = '' 00 '' THEN
          SELECT nvl(MAX(t.order_amount), 0)
            INTO v_order_amount
            FROM scmdata.t_production_progress t
           WHERE t.goo_id = abn_rec.goo_id
             AND t.order_id = abn_rec.order_id
             AND t.company_id = %default_company_id%;
          abn_rec.abnormal_range := v_abn_range;
          abn_rec.delay_amount := v_order_amount;
        ELSIF '' '' || v_abn_range || '' '' = '' 01 '' THEN
          abn_rec.abnormal_range := v_abn_range;
          abn_rec.delay_amount := NULL;
        ELSE
          SELECT listagg(DISTINCT tcs.color_code, '' '') within GROUP(ORDER BY tcs.color_code ASC) color_code
            INTO v_color_code
            FROM scmdata.t_ordersitem od
           INNER JOIN scmdata.t_commodity_info tc
              ON od.goo_id = tc.goo_id
           INNER JOIN scmdata.t_commodity_color_size tcs
              ON tc.commodity_info_id = tcs.commodity_info_id
             AND od.barcode = tcs.barcode
           WHERE od.company_id = %default_company_id%
             AND od.goo_id = abn_rec.goo_id
             AND od.order_id = abn_rec.order_id
           GROUP BY od.goo_id, od.order_id;
          --获取勾选异常单订单颜色与被复制异常单订单颜色的交集
          v_interset_color := scmdata.pkg_plat_comm.f_get_varchar_intersect(p_str1     => v_abn_range,
                                                                            p_str2     => v_color_code,
                                                                            p_separate => '' '');
          --通过颜色交集 获取对应颜色的订单数量
          SELECT SUM(CASE
                       WHEN scmdata.instr_priv(p_str1  => '' '' || tcs.color_code || '' '',
                                               p_str2  => '' '' || v_interset_color || '' '',
                                               p_split => '' '') > 0 THEN
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
           WHERE od.goo_id = abn_rec.goo_id
             AND od.order_id = abn_rec.order_id
             AND od.company_id = %default_company_id%;
          --范围、数量赋值
          abn_rec.abnormal_range := v_interset_color;
          abn_rec.delay_amount   := v_order_amount;
        END IF;

        --批量复制异常单
        --1)v_abn_rec 勾选异常单
        --2)p_abnormal_code_cp 被复制异常单编码
        pkg_production_progress.batch_copy_abnormal(p_company_id       => %default_company_id%,
                                                    p_user_id          => :user_id,
                                                    v_abn_rec          => abn_rec, --勾选异常单
                                                    p_abnormal_code_cp => v_abn_code_cp);
      END LOOP;
    END IF;
  END IF;
END;';
UPDATE bw3.sys_action t SET t.action_sql = v_sql WHERE t.element_id  = 'action_a_product_118_5';
END;
/
BEGIN

insert into bw3.sys_item_element_rela (ITEM_ID, ELEMENT_ID, SEQ_NO, PAUSE, LEVEL_NO)
values ('a_product_120_1', 'look_a_product_118_1', 2, 0, null);

insert into bw3.sys_item_element_rela (ITEM_ID, ELEMENT_ID, SEQ_NO, PAUSE, LEVEL_NO)
values ('a_product_120_2', 'look_a_product_118_1', 2, 0, null);

insert into bw3.sys_item_element_rela (ITEM_ID, ELEMENT_ID, SEQ_NO, PAUSE, LEVEL_NO)
values ('a_product_118', 'look_a_product_118_1', 2, 0, null);

insert into bw3.sys_item_element_rela (ITEM_ID, ELEMENT_ID, SEQ_NO, PAUSE, LEVEL_NO)
values ('a_product_118', 'look_a_product_118_2', 3, 0, null);

insert into bw3.sys_item_element_rela (ITEM_ID, ELEMENT_ID, SEQ_NO, PAUSE, LEVEL_NO)
values ('a_product_120_1', 'look_a_product_118_2', 3, 0, null);

insert into bw3.sys_item_element_rela (ITEM_ID, ELEMENT_ID, SEQ_NO, PAUSE, LEVEL_NO)
values ('a_product_120_2', 'look_a_product_118_2', 3, 0, null);

insert into bw3.sys_item_element_rela (ITEM_ID, ELEMENT_ID, SEQ_NO, PAUSE, LEVEL_NO)
values ('a_product_120_1', 'look_a_product_120_1', 1, 0, null);

insert into bw3.sys_item_element_rela (ITEM_ID, ELEMENT_ID, SEQ_NO, PAUSE, LEVEL_NO)
values ('a_product_118', 'look_a_product_120_1', 1, 0, null);

insert into bw3.sys_item_element_rela (ITEM_ID, ELEMENT_ID, SEQ_NO, PAUSE, LEVEL_NO)
values ('a_product_120_2', 'look_a_product_120_1', 1, 0, null);

insert into bw3.sys_item_element_rela (ITEM_ID, ELEMENT_ID, SEQ_NO, PAUSE, LEVEL_NO)
values ('a_product_120_1', 'look_a_product_120_1_1', 2, 0, null);

insert into bw3.sys_item_element_rela (ITEM_ID, ELEMENT_ID, SEQ_NO, PAUSE, LEVEL_NO)
values ('a_product_118', 'look_a_product_120_1_1', 2, 0, null);

insert into bw3.sys_item_element_rela (ITEM_ID, ELEMENT_ID, SEQ_NO, PAUSE, LEVEL_NO)
values ('a_product_120_2', 'look_a_product_120_1_1', 2, 0, null);
END;
/
BEGIN
insert into bw3.sys_element (ELEMENT_ID, ELEMENT_TYPE, DATA_SOURCE, PAUSE, MESSAGE, IS_HIDE, MEMO, IS_ASYNC, IS_PER_EXE)
values ('control_a_product_118', 'control', 'oracle_scmdata', 0, null, null, null, null, NULL);

insert into bw3.sys_element (ELEMENT_ID, ELEMENT_TYPE, DATA_SOURCE, PAUSE, MESSAGE, IS_HIDE, MEMO, IS_ASYNC, IS_PER_EXE)
values ('control_a_product_118_1', 'control', 'oracle_scmdata', 0, null, null, null, null, NULL);

insert into bw3.sys_element (ELEMENT_ID, ELEMENT_TYPE, DATA_SOURCE, PAUSE, MESSAGE, IS_HIDE, MEMO, IS_ASYNC, IS_PER_EXE)
values ('control_a_product_118_2', 'control', 'oracle_scmdata', 0, null, null, null, null, NULL);

insert into bw3.sys_element (ELEMENT_ID, ELEMENT_TYPE, DATA_SOURCE, PAUSE, MESSAGE, IS_HIDE, MEMO, IS_ASYNC, IS_PER_EXE)
values ('control_a_product_120_1', 'control', 'oracle_scmdata', 0, null, null, null, null, NULL);

insert into bw3.sys_element (ELEMENT_ID, ELEMENT_TYPE, DATA_SOURCE, PAUSE, MESSAGE, IS_HIDE, MEMO, IS_ASYNC, IS_PER_EXE)
values ('control_a_product_120_2', 'control', 'oracle_scmdata', 0, null, null, null, null, NULL);

insert into bw3.sys_field_control (ELEMENT_ID, FROM_FIELD, CONTROL_EXPRESS, CONTROL_FIELDS, CONTROL_TYPE)
values ('control_a_product_118', 'ANOMALY_CLASS_PR', '''{{ANOMALY_CLASS_PR}}''!=''AC_DATE''', 'CHECK_LINK,CHECK_NUM,CHECKER,CHECKER_DESC,ABNORMAL_ORGIN,ABN_ORGIN_DESC,CHECK_GD_LINK_DESC', 0);

insert into bw3.sys_field_control (ELEMENT_ID, FROM_FIELD, CONTROL_EXPRESS, CONTROL_FIELDS, CONTROL_TYPE)
values ('control_a_product_118_1', 'ABNORMAL_ORGIN', '''{{ORIGIN}}''==''MA''&''{{ANOMALY_CLASS_PR}}''!=''AC_DATE''&(''{{ABNORMAL_ORGIN}}''==''ed7ff3c7135a236ae0533c281caccd8d''||''{{ABNORMAL_ORGIN}}''==''b550778b4f2d36b4e0533c281caca074'')', 'CHECKER,CHECKER_DESC', 0);

insert into bw3.sys_field_control (ELEMENT_ID, FROM_FIELD, CONTROL_EXPRESS, CONTROL_FIELDS, CONTROL_TYPE)
values ('control_a_product_118_2', 'ABNORMAL_ORGIN', '''{{ORIGIN}}''==''MA''&''{{ANOMALY_CLASS_PR}}''!=''AC_DATE''&(''{{ABNORMAL_ORGIN}}''==''ed7ff3c7135a236ae0533c281caccd8d''||''{{ABNORMAL_ORGIN}}''==''b550778b4f2d36b4e0533c281caca074''||''{{ABNORMAL_ORGIN}}''==''b550778b4f3f36b4e0533c281caca074'')', 'CHECK_LINK,CHECK_NUM,CHECK_GD_LINK_DESC', 0);

insert into bw3.sys_field_control (ELEMENT_ID, FROM_FIELD, CONTROL_EXPRESS, CONTROL_FIELDS, CONTROL_TYPE)
values ('control_a_product_120_2', 'ORIGIN', '''{{ORIGIN}}''==''SC''', 'associate_a_product_120_1', 2);

insert into bw3.sys_field_control (ELEMENT_ID, FROM_FIELD, CONTROL_EXPRESS, CONTROL_FIELDS, CONTROL_TYPE)
values ('control_a_product_120_1', 'IS_EDIT_ABN_ORGIN', '''{{ORIGIN}}''==''MA''&''{{ANOMALY_CLASS_PR}}''!=''AC_DATE''&''{{IS_EDIT_ABN_ORGIN}}''==''1''', 'ABNORMAL_ORGIN,ABN_ORGIN_DESC', 0);

insert into bw3.sys_item_element_rela (ITEM_ID, ELEMENT_ID, SEQ_NO, PAUSE, LEVEL_NO)
values ('a_product_120_1', 'control_a_product_118', 1, 1, null);

insert into bw3.sys_item_element_rela (ITEM_ID, ELEMENT_ID, SEQ_NO, PAUSE, LEVEL_NO)
values ('a_product_118', 'control_a_product_118', 1, 1, null);

insert into bw3.sys_item_element_rela (ITEM_ID, ELEMENT_ID, SEQ_NO, PAUSE, LEVEL_NO)
values ('a_product_120_1', 'control_a_product_118_1', 2, 0, null);

insert into bw3.sys_item_element_rela (ITEM_ID, ELEMENT_ID, SEQ_NO, PAUSE, LEVEL_NO)
values ('a_product_118', 'control_a_product_118_1', 2, 0, null);

insert into bw3.sys_item_element_rela (ITEM_ID, ELEMENT_ID, SEQ_NO, PAUSE, LEVEL_NO)
values ('a_product_120_1', 'control_a_product_118_2', 3, 0, null);

insert into bw3.sys_item_element_rela (ITEM_ID, ELEMENT_ID, SEQ_NO, PAUSE, LEVEL_NO)
values ('a_product_118', 'control_a_product_118_2', 3, 0, null);

insert into bw3.sys_item_element_rela (ITEM_ID, ELEMENT_ID, SEQ_NO, PAUSE, LEVEL_NO)
values ('a_product_120_1', 'control_a_product_120_1', 1, 0, null);

insert into bw3.sys_item_element_rela (ITEM_ID, ELEMENT_ID, SEQ_NO, PAUSE, LEVEL_NO)
values ('a_product_118', 'control_a_product_120_1', 2, 0, null);

insert into bw3.sys_item_element_rela (ITEM_ID, ELEMENT_ID, SEQ_NO, PAUSE, LEVEL_NO)
values ('a_product_120_2', 'control_a_product_120_2', 3, 0, null);

insert into bw3.sys_item_element_rela (ITEM_ID, ELEMENT_ID, SEQ_NO, PAUSE, LEVEL_NO)
values ('a_product_120_1', 'control_a_product_120_2', 2, 0, null);
END;
/
BEGIN

insert into bw3.sys_element (ELEMENT_ID, ELEMENT_TYPE, DATA_SOURCE, PAUSE, MESSAGE, IS_HIDE, MEMO, IS_ASYNC, IS_PER_EXE)
values ('associate_a_product_120_1', 'associate', 'oracle_scmdata', 0, null, 0, null, null, NULL);

insert into bw3.sys_associate (NODE_ID, ELEMENT_ID, FIELD_NAME, ASSOCIATE_TYPE, CAPTION, ICON_NAME, DATA_TYPE, DATA_SQL, OPEN_TYPE)
values ('node_a_qcqa_152_1', 'associate_a_product_120_1', 'QUALITY_CONTROL_LOG_ID', 6, '查看报告', null, 2, null, null);

insert into bw3.sys_item_element_rela (ITEM_ID, ELEMENT_ID, SEQ_NO, PAUSE, LEVEL_NO)
values ('a_product_120_1', 'associate_a_product_120_1', 1, 0, null);

insert into bw3.sys_item_element_rela (ITEM_ID, ELEMENT_ID, SEQ_NO, PAUSE, LEVEL_NO)
values ('a_product_120_2', 'associate_a_product_120_1', 1, 0, null);

insert into bw3.sys_item_element_rela (ITEM_ID, ELEMENT_ID, SEQ_NO, PAUSE, LEVEL_NO)
values ('a_product_120_1', 'associate_a_qcqa_152_1', 1, 1, null);

insert into bw3.sys_item_element_rela (ITEM_ID, ELEMENT_ID, SEQ_NO, PAUSE, LEVEL_NO)
values ('a_product_120_2', 'associate_a_qcqa_152_1', 1, 1, null);

insert into bw3.sys_element_hint (ITEM_ID, ELEMENT_ID, MESSAGE, PAUSE, LINK_NAME, JUDGE_FIELD, HINT_TYPE)
values ('a_product_120_1', 'associate_a_qcqa_152_1', null, 1, 'QUALITY_CONTROL_REPORT', null, null);

insert into bw3.sys_element_hint (ITEM_ID, ELEMENT_ID, MESSAGE, PAUSE, LINK_NAME, JUDGE_FIELD, HINT_TYPE)
values ('a_product_120_2', 'associate_a_qcqa_152_1', null, 1, 'QUALITY_CONTROL_REPORT', null, null);

END;
/
