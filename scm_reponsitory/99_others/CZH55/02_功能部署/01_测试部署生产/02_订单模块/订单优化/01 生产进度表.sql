--1.下单生产进度表：从熊猫接入过来的订单变更延期原因开放可修改
declare
v_sql clob;
begin
  v_sql := 'DECLARE
  v_is_sup_exemption NUMBER;
  v_first_dept_id    VARCHAR2(100);
  v_second_dept_id   VARCHAR2(100);
  v_is_quality       NUMBER;
  v_flag             NUMBER;
  v_dept_name        varchar2(100);
BEGIN
  if (:old_delay_problem_class_pr is not null and
     :delay_problem_class_pr is null) or
     (:old_delay_problem_class_pr is null and
     :delay_problem_class_pr is not null) or
     (:old_responsible_dept_sec is  null and  :responsible_dept_sec is not null) or
     (:old_responsible_dept_sec is not null and  :responsible_dept_sec is null) or
     (:old_problem_desc_pr is not null and  :problem_desc_pr is null) or
     (:old_delay_problem_class_pr is not null and
     (:old_delay_problem_class_pr <> :delay_problem_class_pr or
     :old_delay_cause_class_pr <> :delay_cause_class_pr or
     :old_delay_cause_detailed_pr <> :delay_cause_detailed_pr or
     :old_problem_desc_pr <> :problem_desc_pr or
     :old_responsible_dept_sec <> :responsible_dept_sec)) then
 --20220414 zxp 下单生产进度表：从熊猫接入过来的订单变更延期原因开放可修改
   /*SELECT MAX(t.is_order_reamem_upd)
      INTO v_flag
      FROM scmdata.t_production_progress t
     WHERE t.product_gress_id = :product_gress_id;
    --新增 交期变更数据 "延期问题分类、延期原因分类、延期原因细分、问题描述"已对接熊猫,不可修改！
    IF v_flag = 1 THEN
      raise_application_error(-20002,
                              ''提示："延期问题分类、延期原因分类、延期原因细分、问题描述"交期变更数据已对接熊猫,不可修改！'');
    ELSE*/
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
          select t.dept_name
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
             WHERE company_dept_id =
                   nvl(:responsible_dept_sec, v_second_dept_id);

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
             t.update_time          = sysdate
       WHERE t.product_gress_id = :product_gress_id;
    end if;
  --end if;
  if (:old_product_gress_remarks is null and
     :product_gress_remarks is not null) or
     (:old_product_gress_remarks is not null and
     :product_gress_remarks is null) or
     :old_product_gress_remarks <> :product_gress_remarks then
    UPDATE scmdata.t_production_progress t
       SET t.product_gress_remarks = :product_gress_remarks
     WHERE t.product_gress_id = :product_gress_id;
    --记录操作日志
    insert into scmdata.t_production_progress_log
      (log_id,
       log_type,
       operate_company_id,
       operate_user_id,
       operate_time,
       product_gress_id,
       company_id,
       old_operate_remarks,
       new_operate_remarks)
    values
      (scmdata.f_Get_Uuid(),
       ''PRODUCT_GRESS_REMARKS'',
       %default_company_id%,
       :user_id,
       sysdate,
       :product_gress_id,
       %default_company_id%,
       :old_product_gress_remarks,
       :product_gress_remarks);
  end if;
END;';
update bw3.sys_item_list t set t.update_sql = v_sql where t.item_id  = 'a_product_110';
end;
/
--2.接单列表 隐藏字段
begin
update bw3.sys_item_list t set t.query_type = 13, t.noshow_fields = 'ORDER_ID,ORDERS_ID,COMPANY_ID,FACTORY_CODE,ORDER_STATUS,LOG_ID,COMPANY_ID,SINGLE_PRICE,CUSTOMER,ORDER_STATUS_DESC,GOO_ID,UPDATE_ID,UPDATE_TIME,FINISH_TIME_SCM' WHERE t.item_id = 'a_order_201_0';
 
update bw3.sys_item_list t set t.noshow_fields = 'ORDER_ID,ORDERS_ID,COMPANY_ID,FACTORY_CODE,ORDER_STATUS,SINGLE_PRICE,CUSTOMER,ORDER_STATUS_DESC,GOO_ID,UPDATE_ID,UPDATE_TIME,FINISH_TIME_SCM' WHERE t.item_id = 'a_order_201_1';
end;
/
--3.
begin
update bw3.sys_item_rela t set t.pause = 1 where  t.item_id in ('a_product_110','a_product_116') and t.relate_id = 'a_product_114' ;
update bw3.sys_item_rela t set t.pause = 1 where  t.item_id in ('a_product_110','a_product_116') and t.relate_id in 'a_product_119' ;
end;
