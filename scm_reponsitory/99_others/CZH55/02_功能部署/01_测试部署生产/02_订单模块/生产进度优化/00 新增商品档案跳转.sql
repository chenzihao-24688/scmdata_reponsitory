begin
update bw3.sys_item_list t set t.noshow_fields = 'PRODUCT_GRESS_ID,FABRIC_CHECK,COMPANY_ID,SUPPLIER_CODE_PR,FACTORY_CODE_PR,ORDER_ID_PR,PROGRESS_STATUS_PR,QC_CHECK_PR,QA_CHECK_PR,APPROVE_EDITION,IS_SUP_RESPONSIBLE,RESPONSIBLE_DEPT,RESPONSIBLE_DEPT_SEC,CHECK_LINK,CUSTOMER,GOO_ID_PR'  where t.item_id = 'a_product_210'; 
update bw3.sys_item_list t set t.noshow_fields = 'PRODUCT_GRESS_ID,FABRIC_CHECK,COMPANY_ID,SUPPLIER_CODE_PR,FACTORY_CODE_PR,ORDER_ID_PR,PROGRESS_STATUS_PR,QC_CHECK_PR,QA_CHECK_PR,APPROVE_EDITION,CHECK_LINK,PROGRESS_STATUS_DESC,IS_SET_FABRIC,FABRIC_CHECK_PR,LAST_CHECK_LINK_DESC,QC_CHECK_PR,QA_CHECK_PR,EXCEPTION_HANDLE_STATUS_PR,HANDLE_OPINIONS_PR,CUSTOMER,GOO_ID_PR' where t.item_id = 'a_product_217'; 
update bw3.sys_item_list t set t.noshow_fields = 'PRODUCT_GRESS_ID,FABRIC_CHECK,PRODUCT_GRESS_ID,COMPANY_ID,SUPPLIER_CODE_PR,FACTORY_CODE_PR,ORDER_ID_PR,PROGRESS_STATUS_PR,QC_CHECK_PR,QA_CHECK_PR,APPROVE_EDITION,CHECK_LINK,CUSTOMER,GOO_ID_PR' where t.item_id = 'a_product_216';    

update bw3.sys_item_list t set t.noshow_fields = 'PRODUCT_GRESS_ID,FABRIC_CHECK,COMPANY_ID,SUPPLIER_CODE_PR,FACTORY_CODE_PR,ORDER_ID_PR,PROGRESS_STATUS_PR,QC_CHECK_PR,QA_CHECK_PR,APPROVE_EDITION,CHECK_LINK,CATEGORY_CODE,FIRST_DEPT_ID,RESPONSIBLE_DEPT_SEC,GOO_ID_PR'  where t.item_id = 'a_product_110'; 
update bw3.sys_item_list t set t.noshow_fields = 'PRODUCT_GRESS_ID,FABRIC_CHECK,COMPANY_ID,SUPPLIER_CODE_PR,FACTORY_CODE_PR,ORDER_ID_PR,PROGRESS_STATUS_PR,QC_CHECK_PR,QA_CHECK_PR,APPROVE_EDITION,CHECK_LINK,CATEGORY_CODE,FIRST_DEPT_ID,RESPONSIBLE_DEPT_SEC,PRODUCT_GRESS_REMARKS,PROGRESS_STATUS_DESC,IS_SET_FABRIC,FABRIC_CHECK_PR,LAST_CHECK_LINK_DESC,QC_CHECK_PR,QA_CHECK_PR,EXCEPTION_HANDLE_STATUS_PR,HANDLE_OPINIONS_PR,GOO_ID_PR' where t.item_id = 'a_product_150'; 
update bw3.sys_item_list t set t.noshow_fields = 'PRODUCT_GRESS_ID,FABRIC_CHECK,COMPANY_ID,SUPPLIER_CODE_PR,FACTORY_CODE_PR,ORDER_ID_PR,PROGRESS_STATUS_PR,QC_CHECK_PR,QA_CHECK_PR,APPROVE_EDITION,IS_SUP_RESPONSIBLE,RESPONSIBLE_DEPT,RESPONSIBLE_DEPT_SEC,CHECK_LINK,CATEGORY_CODE,GOO_ID_PR' where t.item_id = 'a_product_116';    

/*insert into bw3.sys_item_element_rela (ITEM_ID, ELEMENT_ID, SEQ_NO, PAUSE, LEVEL_NO)
values ('a_product_116', 'associate_a_product_101', 1, 0, 0);

insert into bw3.sys_item_element_rela (ITEM_ID, ELEMENT_ID, SEQ_NO, PAUSE, LEVEL_NO)
values ('a_product_110', 'associate_a_product_101', 2, 0, 0);*/


update bw3.sys_associate t set t.field_name = 'RELA_GOO_ID' , t.associate_type = 6,t.data_sql = null where t.element_id = 'associate_a_product_101' ;

insert into bw3.sys_item_element_rela (ITEM_ID, ELEMENT_ID, SEQ_NO, PAUSE, LEVEL_NO)
values ('a_product_150', 'associate_a_product_101', 1, 0, 0);

/*insert into bw3.sys_element_hint (ITEM_ID, ELEMENT_ID, MESSAGE, PAUSE, LINK_NAME, JUDGE_FIELD, HINT_TYPE)
values ('a_product_110', 'associate_a_product_101', null, 0, 'RELA_GOO_ID', null, null);

insert into bw3.sys_element_hint (ITEM_ID, ELEMENT_ID, MESSAGE, PAUSE, LINK_NAME, JUDGE_FIELD, HINT_TYPE)
values ('a_product_116', 'associate_a_product_101', null, 0, 'RELA_GOO_ID', null, null);
*/
update bw3.sys_element_hint t set t.link_name = 'RELA_GOO_ID' where t.item_id = 'a_product_110' and t.element_id = 'associate_a_product_101';
update bw3.sys_element_hint t set t.link_name = 'RELA_GOO_ID' where t.item_id = 'a_product_116' and t.element_id = 'associate_a_product_101';

insert into bw3.sys_element_hint (ITEM_ID, ELEMENT_ID, MESSAGE, PAUSE, LINK_NAME, JUDGE_FIELD, HINT_TYPE)
values ('a_product_150', 'associate_a_product_101', null, 0, 'RELA_GOO_ID', null, null);

insert into bw3.sys_item_element_rela (ITEM_ID, ELEMENT_ID, SEQ_NO, PAUSE, LEVEL_NO)
values ('a_order_201_0', 'asso_a_good_201_1', 6, 0, null);

insert into bw3.sys_item_element_rela (ITEM_ID, ELEMENT_ID, SEQ_NO, PAUSE, LEVEL_NO)
values ('a_order_201_4', 'asso_a_good_201_1', 6, 0, null);

insert into bw3.sys_item_element_rela (ITEM_ID, ELEMENT_ID, SEQ_NO, PAUSE, LEVEL_NO)
values ('a_order_201_1', 'asso_a_good_201_1', 6, 0, null);

insert into bw3.sys_item_element_rela (ITEM_ID, ELEMENT_ID, SEQ_NO, PAUSE, LEVEL_NO)
values ('a_product_210', 'asso_a_good_201_1', 6, 0, null);

insert into bw3.sys_item_element_rela (ITEM_ID, ELEMENT_ID, SEQ_NO, PAUSE, LEVEL_NO)
values ('a_product_217', 'asso_a_good_201_1', 6, 0, null);

insert into bw3.sys_item_element_rela (ITEM_ID, ELEMENT_ID, SEQ_NO, PAUSE, LEVEL_NO)
values ('a_product_216', 'asso_a_good_201_1', 6, 0, null);

insert into bw3.sys_element_hint (ITEM_ID, ELEMENT_ID, MESSAGE, PAUSE, LINK_NAME, JUDGE_FIELD, HINT_TYPE)
values ('a_order_201_0', 'asso_a_good_201_1', null, 0, 'RELA_GOO_ID', null, null);

insert into bw3.sys_element_hint (ITEM_ID, ELEMENT_ID, MESSAGE, PAUSE, LINK_NAME, JUDGE_FIELD, HINT_TYPE)
values ('a_order_201_4', 'asso_a_good_201_1', null, 0, 'RELA_GOO_ID', null, null);

insert into bw3.sys_element_hint (ITEM_ID, ELEMENT_ID, MESSAGE, PAUSE, LINK_NAME, JUDGE_FIELD, HINT_TYPE)
values ('a_order_201_1', 'asso_a_good_201_1', null, 0, 'RELA_GOO_ID', null, null);

insert into bw3.sys_element_hint (ITEM_ID, ELEMENT_ID, MESSAGE, PAUSE, LINK_NAME, JUDGE_FIELD, HINT_TYPE)
values ('a_product_210', 'asso_a_good_201_1', null, 0, 'RELA_GOO_ID', null, null);

insert into bw3.sys_element_hint (ITEM_ID, ELEMENT_ID, MESSAGE, PAUSE, LINK_NAME, JUDGE_FIELD, HINT_TYPE)
values ('a_product_217', 'asso_a_good_201_1', null, 0, 'RELA_GOO_ID', null, null);

insert into bw3.sys_element_hint (ITEM_ID, ELEMENT_ID, MESSAGE, PAUSE, LINK_NAME, JUDGE_FIELD, HINT_TYPE)
values ('a_product_216', 'asso_a_good_201_1', null, 0, 'RELA_GOO_ID', null, null);

end;
/
declare
v_sql clob;
begin
v_sql := 'WITH group_dict AS
 (SELECT gd.group_dict_value, gd.group_dict_type, gd.group_dict_name
    FROM scmdata.sys_group_dict gd),
company_dict AS
 (SELECT cd.company_dict_value,
         cd.company_dict_type,
         cd.company_dict_name,
         cd.pause
    FROM scmdata.sys_company_dict cd
   WHERE cd.company_id = %default_company_id%),
company_user AS
 (SELECT company_id, user_id, company_user_name
    FROM sys_company_user
   WHERE company_id = %default_company_id%)
SELECT tc.commodity_info_id,
       tc.company_id,
       cp.blog_file_name,
       cp.picture,
       cp.blog_file_id,
       tc.supplier_code supplier_code_gd,
       tc.style_name,
       (SELECT supplier_company_name
          FROM scmdata.t_supplier_info
         WHERE supplier_code = tc.supplier_code
           AND company_id = %default_company_id%) sup_name_gd,
       tc.style_number,
       tc.sup_style_number,
       tc.goo_id,
       tc.rela_goo_id,
       tc.goo_name,
       tc.category,
       tc.product_cate,
       tc.samll_category,
       (SELECT group_dict_name
          FROM group_dict
         WHERE group_dict_type = ''PRODUCT_TYPE''
           AND group_dict_value = tc.category) category_gd,
       (SELECT group_dict_name
          FROM group_dict
         WHERE group_dict_type = tc.category
           AND group_dict_value = tc.product_cate) product_cate_gd,
       (SELECT company_dict_name
          FROM company_dict
         WHERE company_dict_type = tc.product_cate
           AND company_dict_value = tc.samll_category) small_category_gd,
       tc.year,
       tc.season,
       -- gd3.group_dict_name year_gd,
       (SELECT group_dict_name
          FROM group_dict
         WHERE group_dict_type = ''GD_SESON''
           AND group_dict_value = tc.season) season_gd,
       tc.inprice,
       tc.price price_gd,
       tc.color_list,
       (SELECT listagg(a.company_dict_name, '';'') within GROUP(ORDER BY 1)
          FROM (SELECT regexp_substr(tc.color_list, ''[^;]+'', 1, LEVEL) color
                  FROM dual
                CONNECT BY LEVEL <= regexp_count(tc.color_list, ''[^;]+'')) t
         INNER JOIN company_dict a
            ON a.company_dict_value = t.color
         INNER JOIN company_dict b
            ON b.company_dict_type = ''GD_COLOR_LIST''
           AND b.company_dict_value = a.company_dict_type
           AND b.pause = 0) color_list_gd, --颜色组  键值，拆分，组合转换
       tc.size_list,
       (SELECT listagg(a.company_dict_name, '';'') within GROUP(ORDER BY 1)
          FROM (SELECT regexp_substr(tc.size_list, ''[^;]+'', 1, LEVEL) size_gd
                  FROM dual
                CONNECT BY LEVEL <= regexp_count(tc.size_list, ''[^;]+'')) t
         INNER JOIN company_dict a
            ON a.company_dict_value = t.size_gd
         INNER JOIN company_dict b
            ON b.company_dict_type = ''GD_SIZE_LIST''
           AND b.company_dict_value = a.company_dict_type
           AND b.pause = 0) size_list_gd, --尺码组 键值，拆分，组合转换
       -- tc.base_size,
       tc.executive_std,
       -- e.company_dict_name base_size_desc,
       (SELECT listagg(composname || '' '' || pk, chr(10)) within GROUP(ORDER BY seq)
          FROM (SELECT k.composname,
                       listagg(loadrate * 100 || ''%'' || '' '' || k.goo_raw || '' '' ||
                               k.memo,
                               '' '') within GROUP(ORDER BY sort ASC) pk,
                       CASE k.composname
                         WHEN ''面料1'' THEN
                          1
                         WHEN ''面料2'' THEN
                          2
                         WHEN ''面料'' THEN
                          3
                         WHEN ''里料1'' THEN
                          4
                         WHEN ''里料2'' THEN
                          5
                         WHEN ''里料'' THEN
                          6
                         WHEN ''侧翼面料'' THEN
                          7
                         WHEN ''侧翼里料'' THEN
                          8
                         WHEN ''罩杯里料'' THEN
                          9
                         WHEN ''表层'' THEN
                          10
                         WHEN ''基布'' THEN
                          11
                         WHEN ''填充物'' THEN
                          12
                         WHEN ''填充量'' THEN
                          13
                         WHEN ''鞋面材质'' THEN
                          14
                         WHEN ''鞋底材质'' THEN
                          15
                         WHEN ''帽里填充物'' THEN
                          16
                         ELSE
                          99
                       END seq
                  FROM scmdata.t_commodity_composition k
                 WHERE k.commodity_info_id = tc.commodity_info_id
                 GROUP BY k.composname)) || chr(10) ||
       (SELECT MAX(memo)
          FROM scmdata.t_commodity_composition k
         WHERE k.commodity_info_id = tc.commodity_info_id) composname_long,
       tc.is_set_fabric,
       nvl((SELECT company_user_name
             FROM company_user
            WHERE company_id = tc.company_id
              AND user_id = tc.create_id),
           tc.create_id) create_id,
       tc.create_time,
       (SELECT company_user_name
          FROM company_user
         WHERE company_id = tc.company_id
           AND user_id = tc.update_id) update_id,
       tc.update_time
  FROM (SELECT *
          FROM scmdata.t_commodity_info
         WHERE (company_id = %default_company_id%)
           AND (rela_goo_id = :rela_goo_id)) tc
  LEFT JOIN scmdata.t_commodity_picture cp
    ON cp.goo_id = tc.goo_id
   AND cp.company_id = tc.company_id
   AND cp.seqno = 1';
update bw3.sys_item_list t set t.select_sql = v_sql where t.item_id = 'a_good_130'; 
end;
/
declare
v_sql clob;
v_sql1 clob;
begin
  v_sql := '{DECLARE
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
       d.company_name customer,
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
       t.problem_desc problem_desc_pr,
       t.approve_edition, --Edit by zc
       cf.is_set_fabric,
       t.fabric_check fabric_check,
       t.check_link,
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
       t.goo_id, --这里goo_id是货号
       decode(oh.send_by_sup, 1, ''''是'''', ''''否'''') send_by_sup,
       oh.create_time create_time_po,
       oh.memo memo_po,
       a.group_dict_name category,
       b.group_dict_name cooperation_product_cate_sp,
       c.company_dict_name product_subclass_desc,
       oh.finish_time,
       t.update_company_id,
       ucu.company_user_name UPDATE_ID_PR,
       t.update_time UPDATE_DATE_PR
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
  AND oh.order_status = ''''OS01''''
 AND oh.is_product_order = 1
 INNER JOIN t_production_progress t
    ON t.company_id = od.company_id
   AND t.order_id = od.order_id
   AND t.goo_id = od.goo_id
   AND t.progress_status <> ''''01''''
 INNER JOIN scmdata.t_commodity_info cf
    ON t.company_id = cf.company_id
   AND t.goo_id = cf.goo_id
   --AND (''''1'''' = nvl(@GOO_ID_PR@,1) OR cf.rela_goo_id = @GOO_ID_PR@)
  LEFT JOIN SCMDATA.T_COMMODITY_PICTURE W
    ON W.GOO_ID = CF.GOO_ID AND W.COMPANY_ID = CF.COMPANY_ID
  LEFT JOIN supp sp1
    ON t.company_id = sp1.company_id
   AND t.factory_code = sp1.supplier_code
  LEFT JOIN group_dict a
    ON a.group_dict_type = ''''PRODUCT_TYPE''''
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
                         ON gd_a.group_dict_type = ''''PROGRESS_NODE_TYPE''''
                        AND gd_a.group_dict_value = pn.progress_status
                      WHERE pn.progress_status IS NOT NULL)
              WHERE rn = 1) pno
    ON pno.product_gress_id = t.product_gress_id
   AND pno.company_id = t.company_id
  LEFT JOIN group_dict gd_b
    ON gd_b.group_dict_type = ''''PROGRESS_TYPE''''
   AND gd_b.group_dict_value = t.progress_status
  LEFT JOIN group_dict gd_d
    ON gd_d.group_dict_type = ''''HANDLE_RESULT''''
   AND gd_d.group_dict_value = t.handle_opinions
  left join scmdata.sys_company_user ucu
  on ucu.company_id=t.update_company_id
  and ucu.user_id=t.update_id
 WHERE  ((%is_company_admin%) = 1 OR
       instr_priv(p_str1  => ''''''||v_class_data_privs||'''''' ,p_str2  => cf.category ,p_split => '''';'''') > 0)
 ORDER BY t.product_gress_code DESC, t.create_time DESC'';
  @strresult := v_sql;
END;}';
v_sql1 := 'DECLARE
  v_is_sup_exemption NUMBER;
  v_first_dept_id    VARCHAR2(100);
  v_second_dept_id   VARCHAR2(100);
  v_is_quality       NUMBER;
  v_flag             NUMBER;

BEGIN
  if :update_company_id is not null and :update_company_id<>%default_company_id% then
     raise_application_error(-20002,
                            ''保存失败！延期原因已确定不可修改，如需修改请联系客户跟单。'');
  end if;
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
         WHERE tc.company_id = :old_company_id
           AND tc.goo_id = :old_goo_id
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
           t.responsible_dept_sec = v_second_dept_id,
           t.is_quality           = v_is_quality,
           t.update_company_id=%default_company_id%,
           t.update_id=:user_id,
           t.update_time=sysdate
     WHERE t.product_gress_id = :product_gress_id;
  END IF;

END;';
update bw3.sys_item_list t set t.select_sql = v_sql ,t.update_sql = v_sql1 where t.item_id = 'a_product_210';
end;
/
declare
v_sql clob;
begin
  v_sql := '{DECLARE
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
       a.group_dict_name progress_status_desc,
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
       t.delay_problem_class delay_problem_class_pr,
       t.delay_cause_class delay_cause_class_pr,
       t.delay_cause_detailed delay_cause_detailed_pr,
       t.problem_desc problem_desc_pr,
       t.approve_edition,
       cf.is_set_fabric,
       t.fabric_check fabric_check,
       t.check_link,
       t.qc_check qc_check_pr,
       t.qa_check qa_check_pr,
       decode(t.exception_handle_status,
              ''''01'''',
              ''''处理中'''',
              ''''02'''',
              ''''已处理'''',
              ''''无异常'''') exception_handle_status_pr,
       gd.group_dict_name handle_opinions_pr,
       w.picture,
       t.goo_id,
       oh.create_time create_time_po,
       oh.memo memo_po,
       c.group_dict_name category,
       d.group_dict_name cooperation_product_cate_sp,
       e.company_dict_name product_subclass_desc,
       oh.finish_time,
       t.update_company_id,
       ucu.company_user_name UPDATE_ID_PR,
       t.update_time UPDATE_DATE_PR
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
   AND oh.order_status IN (''''OS01'''', ''''OS02'''')
 INNER JOIN t_production_progress t
    ON t.company_id = od.company_id
   AND t.order_id = od.order_id
   AND t.goo_id = od.goo_id
   AND t.progress_status = ''''01''''
 INNER JOIN scmdata.t_commodity_info cf
    ON t.company_id = cf.company_id
   AND t.goo_id = cf.goo_id
  --AND (''''1'''' = nvl(@GOO_ID_PR@,1) OR cf.rela_goo_id = @GOO_ID_PR@)
  LEFT JOIN SCMDATA.T_COMMODITY_PICTURE W
    ON w.goo_id = cf.goo_id and w.company_id = cf.company_id
 INNER JOIN group_dict a
    ON a.group_dict_value = t.progress_status
 INNER JOIN group_dict b
    ON b.group_dict_value = a.group_dict_type
   AND b.group_dict_value = ''''PROGRESS_TYPE''''
 LEFT JOIN supp sp1
    ON t.company_id = sp1.company_id
   AND t.factory_code = sp1.supplier_code
 INNER JOIN supp sp2
    ON t.company_id = sp2.company_id
   AND t.supplier_code = sp2.supplier_code
  LEFT JOIN group_dict c
    ON c.group_dict_type = ''''PRODUCT_TYPE''''
   AND c.group_dict_value = cf.category
  LEFT JOIN group_dict d
    ON d.group_dict_type = c.group_dict_value
   AND d.group_dict_value = cf.product_cate
  LEFT JOIN scmdata.sys_company_dict e
    ON e.company_dict_type = d.group_dict_value
   AND e.company_dict_value = cf.samll_category
   AND e.company_id = cf.company_id
  LEFT JOIN group_dict gd
    ON gd.group_dict_type = ''''HANDLE_RESULT''''
   AND gd.group_dict_value = t.handle_opinions
  left join scmdata.sys_company_user ucu
  on ucu.company_id=t.update_company_id
  and ucu.user_id=t.update_id
 WHERE ((%is_company_admin%) = 1 OR
       instr_priv(p_str1  => ''''''||v_class_data_privs||'''''' ,p_str2  => cf.category ,p_split => '''';'''') > 0)
  ORDER BY t.product_gress_code DESC, oh.finish_time_scm DESC'';
  @strresult := v_sql;
END;}';
update bw3.sys_item_list t set t.select_sql = v_sql  where t.item_id = 'a_product_216';
end;
/
declare
v_sql clob;
v_sql1 clob;
begin
  v_sql := '{DECLARE
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
       d.company_name customer,
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
       t.problem_desc problem_desc_pr,
       t.approve_edition, --Edit by zc
       cf.is_set_fabric,
       t.fabric_check fabric_check,
       t.check_link,
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
       t.goo_id, --这里goo_id是货号
       decode(oh.send_by_sup, 1, ''''是'''', ''''否'''') send_by_sup,
       oh.create_time create_time_po,
       oh.memo memo_po,
       a.group_dict_name category,
       b.group_dict_name cooperation_product_cate_sp,
       c.company_dict_name product_subclass_desc,
       oh.finish_time,
       t.update_company_id,
       ucu.company_user_name UPDATE_ID_PR,
       t.update_time UPDATE_DATE_PR
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
  AND oh.order_status = ''''OS01''''
 AND oh.is_product_order = 0
 INNER JOIN t_production_progress t
    ON t.company_id = od.company_id
   AND t.order_id = od.order_id
   AND t.goo_id = od.goo_id
   AND t.progress_status <> ''''01''''
 INNER JOIN scmdata.t_commodity_info cf
    ON t.company_id = cf.company_id
   AND t.goo_id = cf.goo_id
   --AND (''''1'''' = nvl(@GOO_ID_PR@,1) OR cf.rela_goo_id = @GOO_ID_PR@)
  LEFT JOIN SCMDATA.T_COMMODITY_PICTURE W
    ON W.GOO_ID = CF.GOO_ID AND W.COMPANY_ID = CF.COMPANY_ID
  LEFT JOIN supp sp1
    ON t.company_id = sp1.company_id
   AND t.factory_code = sp1.supplier_code
  LEFT JOIN group_dict a
    ON a.group_dict_type = ''''PRODUCT_TYPE''''
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
                         ON gd_a.group_dict_type = ''''PROGRESS_NODE_TYPE''''
                        AND gd_a.group_dict_value = pn.progress_status
                      WHERE pn.progress_status IS NOT NULL)
              WHERE rn = 1) pno
    ON pno.product_gress_id = t.product_gress_id
   AND pno.company_id = t.company_id
  LEFT JOIN group_dict gd_b
    ON gd_b.group_dict_type = ''''PROGRESS_TYPE''''
   AND gd_b.group_dict_value = t.progress_status
  LEFT JOIN group_dict gd_d
    ON gd_d.group_dict_type = ''''HANDLE_RESULT''''
   AND gd_d.group_dict_value = t.handle_opinions
  left join scmdata.sys_company_user ucu
  on ucu.company_id=t.update_company_id
  and ucu.user_id=t.update_id
 WHERE  ((%is_company_admin%) = 1 OR
       instr_priv(p_str1  => ''''''||v_class_data_privs||'''''' ,p_str2  => cf.category ,p_split => '''';'''') > 0)
 ORDER BY t.product_gress_code DESC, t.create_time DESC'';
  @strresult := v_sql;
END;}';
v_sql1 := 'DECLARE
  v_is_sup_exemption NUMBER;
  v_first_dept_id    VARCHAR2(100);
  v_second_dept_id   VARCHAR2(100);
  v_is_quality       NUMBER;
  v_flag             NUMBER;

BEGIN
  if :update_company_id is not null and :update_company_id<>%default_company_id% then
     raise_application_error(-20002,
                            ''保存失败！延期原因已确定不可修改，如需修改请联系客户跟单。'');
  end if;
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
         WHERE tc.company_id = :old_company_id
           AND tc.goo_id = :old_goo_id
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
           t.responsible_dept_sec = v_second_dept_id,
           t.is_quality           = v_is_quality,
           t.update_company_id=%default_company_id%,
           t.update_id=:user_id,
           t.update_time=sysdate
     WHERE t.product_gress_id = :product_gress_id;
  END IF;

END;';
update bw3.sys_item_list t set t.select_sql = v_sql,t.update_sql = v_sql1  where t.item_id = 'a_product_217';
end;


