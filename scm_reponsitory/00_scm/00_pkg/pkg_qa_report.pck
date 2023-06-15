CREATE OR REPLACE PACKAGE SCMDATA.PKG_QA_REPORT IS
  PROCEDURE P_T_QA_WAREHOUSE_INSPECT_FAILED(p_start_date date ,p_end_date date);
  PROCEDURE P_T_QA_INSPECT_FAILED_FLW_QC;
  PROCEDURE P_T_QA_INGOOD(p_start_date date ,p_end_date date);
  --获取数据权限sql
  FUNCTION F_GET_DATAPRIVS_SQL(p_class_data_privs VARCHAR2,
                               p_pre              VARCHAR2 DEFAULT 't')
    RETURN CLOB;
  FUNCTION F_KPI_180_SELECTSQL(KPI_TIMETYPE       VARCHAR2,
                               KPI_TIME           VARCHAR2,
                               KPI_DIMENSION      VARCHAR2,
                               KPI_GROUP          VARCHAR2,
                               KPI_CATEGORY       VARCHAR2,
                               P_CLASS_DATA_PRIVS CLOB,
                               COMPANY_ID         VARCHAR2) RETURN CLOB;
  FUNCTION F_KPI_181_CAPTIONSQL(V_STRING VARCHAR2, V_ID VARCHAR2) RETURN CLOB;
  FUNCTION F_KPI_181_SELECTSQL(V_TIME       VARCHAR2,
                               V_DIMENSION  VARCHAR2,
                               V_SORT       VARCHAR2,
                               V_GROUP      VARCHAR2,
                               V_CATEGORY   VARCHAR2,
                               V_COMPANY_ID VARCHAR2) RETURN CLOB;
  FUNCTION F_KPI_182_SELECTSQL(V_TIME       VARCHAR2,
                               V_DIMENSION  VARCHAR2,
                               V_SORT       VARCHAR2,
                               V_GROUP      VARCHAR2,
                               V_CATEGORY   VARCHAR2,
                               V_COMPANY_ID VARCHAR2) RETURN CLOB;
END PKG_QA_REPORT;
/

CREATE OR REPLACE PACKAGE BODY SCMDATA.PKG_QA_REPORT IS
  PROCEDURE P_T_QA_WAREHOUSE_INSPECT_FAILED(p_start_date date,
                                            p_end_date   date) IS
    v_cur_mon  varchar2(32);
    v_seal_day int;
  BEGIN
    v_seal_day := to_number(scmdata.pkg_db_job.f_get_seal_date(p_rtn_type => 0));
    --当月月初至当月5号 同步上月订单
    v_cur_mon := scmdata.pkg_db_job.f_get_month(p_begin_date => p_start_date,
                                                p_seal_day   => v_seal_day);
    MERGE INTO scmdata.t_qa_warehouse_inspect_failed tka
    USING (select *
             from (SELECT rep.company_id,
                          goo.category category_id,
                          goo.rela_goo_id,
                          goo.style_number,
                          goo.style_name,
                          reprela.supplier_code,
                          sup.inside_supplier_code,
                          kt.qualdecrease_amount,
                          kt.if_batch_sporadic,
                          NVL(probclass.cause_detail,
                              rep.problem_classification) problem_classification, --问题分类
                          rep.problem_descriptions, --问题描述
                          rep.review_comments, --审核意见
                          rep.memo, --备注
                          kt.skuprocessing_result,
                          (case
                            when tq.pause = '0' then
                             1
                            else
                             0
                          end) is_need_qc_quality,
                          goo.product_cate,
                          goo.samll_category,
                          goo.price,
                          (SELECT MAX(qualfinish_time)
                             FROM scmdata.t_qa_report_skudim
                            WHERE qa_report_id = rep.qa_report_id
                              AND company_id = rep.company_id) qualfinishtime,
                          rep.qa_report_id,
                          kt.order_id,
                          kt.asn_id
                     from scmdata.t_qa_report rep
                    inner join scmdata.t_qa_report_relainfodim reprela
                       on rep.qa_report_id = reprela.qa_report_id
                      and rep.company_id = reprela.company_id
                    inner join (select kt1.qa_report_id,
                                      kt1.company_id,
                                      kt1.asn_id,
                                      kt1.order_id,
                                      sum(kt1.qualdecrease_amount) qualdecrease_amount,
                                      listagg(distinct kt1.if_batch_sporadic,
                                              ';') if_batch_sporadic,
                                      listagg(distinct
                                              kt1.skuprocessing_result,
                                              ';') skuprocessing_result
                                 from (select repsku.qa_report_id,
                                              repsku.company_id,
                                              repsku.asn_id,
                                              asned.order_id,
                                              listagg(distinct
                                                      rest.group_dict_name,
                                                      ';') skuprocessing_result,
                                              sum(repsku.qualdecrease_amount) qualdecrease_amount,
                                              '零星' if_batch_sporadic
                                         from scmdata.t_qa_report_skudim repsku
                                        inner join scmdata.t_asnordered asned
                                           on repsku.asn_id = asned.asn_id
                                          and repsku.company_id =
                                              asned.company_id
                                         LEFT JOIN scmdata.sys_group_dict rest
                                           ON rest.group_dict_type =
                                              'QA_PROCESSRESULT'
                                          AND repsku.skuprocessing_result =
                                              rest.group_dict_value
                                        where repsku.status = 'AF'
                                          and repsku.skucheck_result = 'PS'
                                          and repsku.qualdecrease_amount > 0
                                        group by repsku.qa_report_id,
                                                 repsku.company_id,
                                                 asned.order_id,
                                                 repsku.asn_id
                                       union
                                       select qa_report_id,
                                              company_id,
                                              asn_id,
                                              order_id,
                                              listagg(distinct group_dict_name,
                                                      ';') skuprocessing_result,
                                              sum(qualdecrease_amount) qualdecrease_amount,
                                              if_batch_sporadic
                                         from (select repsku.qa_report_id,
                                                      repsku.company_id,
                                                      repsku.asn_id,
                                                      asned.order_id,
                                                      rest.group_dict_name,
                                                      tdr.asn_documents_status,
                                                      (case
                                                        when tdr.asn_documents_status in
                                                             ('已关闭') then
                                                         (case when tas.got_amount > 0 then tas.got_amount else repsku.unqual_amount end)
                                                        else
                                                         repsku.unqual_amount
                                                      end) qualdecrease_amount,
                                                      '批量' if_batch_sporadic
                                                 from scmdata.t_qa_report_skudim repsku
                                                inner join scmdata.t_asnordered asned
                                                   on repsku.asn_id =
                                                      asned.asn_id
                                                  and repsku.company_id =
                                                      asned.company_id
                                                 left join scmdata.t_delivery_record tdr
                                                   on tdr.company_id = asned.company_id
                                                  and tdr.asn_id =repsku.asn_id
                                                 left join scmdata.t_asnordersitem tas
                                                   on tas.asn_id = repsku.asn_id
                                                  and tas.company_id = repsku.company_id
                                                  and tas.barcode = repsku.barcode
                                                 LEFT JOIN scmdata.sys_group_dict rest
                                                   ON rest.group_dict_type =
                                                      'QA_PROCESSRESULT'
                                                  AND repsku.skuprocessing_result =
                                                      rest.group_dict_value
                                                where repsku.status = 'AF'
                                                  and repsku.skucheck_result = 'NP'
                                                  and repsku.skuprocessing_result in
                                                      ('DSR', 'AWR', 'WD'))
                                        group by qa_report_id,
                                                 company_id,
                                                 order_id,
                                                 asn_id,
                                                 if_batch_sporadic) kt1
                                group by kt1.qa_report_id,
                                         kt1.company_id,
                                         kt1.asn_id,
                                         kt1.order_id) kt
                       on kt.qa_report_id = rep.qa_report_id
                      and kt.company_id = rep.company_id
                     LEFT JOIN scmdata.t_commodity_info goo
                       ON reprela.goo_id = goo.goo_id
                      AND reprela.company_id = goo.company_id
                     left join scmdata.t_qc_config tq
                       on tq.company_id = goo.company_id
                      and tq.industry_classification = goo.category
                      and tq.production_category = goo.product_cate
                      and instr(tq.product_subclass, goo.samll_category) > 0
                      and tq.pause = '0'
                     LEFT JOIN scmdata.t_supplier_info sup
                       ON reprela.supplier_code = sup.supplier_code
                      AND reprela.company_id = sup.company_id
                     LEFT JOIN scmdata.t_abnormal_dtl_config probclass
                       ON rep.problem_classification =
                          probclass.abnormal_dtl_config_id
                      AND rep.company_id = probclass.company_id
                    WHERE rep.status = 'AF'
                      and rep.check_type = 'AC'
                      AND rep.company_id = 'b6cc680ad0f599cde0531164a8c0337f')
            where (trunc(qualfinishtime) between p_start_date and p_end_date)
               or to_char(qualfinishtime, 'yyyy-mm') = v_cur_mon) tkb
    ON (tkb.company_id = tka.company_id and tkb.asn_id = tka.asn_id and tka.order_id = tkb.order_id and tka.qa_report_id = tkb.qa_report_id)
    when matched then
      update
         set tka.qualfinishtime         = tkb.qualfinishtime,
             tka.rela_goo_id            = tkb.rela_goo_id,
             tka.style_number           = tkb.style_number,
             tka.style_name             = tkb.style_name,
             tka.category_id            = tkb.category_id,
             tka.product_cate           = tkb.product_cate,
             tka.samll_category         = tkb.samll_category,
             tka.price                  = tkb.price,
             tka.supplier_code          = tkb.supplier_code,
             tka.inside_supplier_code   = tkb.inside_supplier_code,
             tka.qualdecrease_amount    = tkb.qualdecrease_amount,
             tka.if_batch_sporadic      = tkb.if_batch_sporadic,
             tka.problem_classification = tkb.problem_classification,
             tka.problem_descriptions   = tkb.problem_descriptions,
             tka.review_comments        = tkb.review_comments,
             tka.memo                   = tkb.memo,
             tka.skuprocessing_result   = tkb.skuprocessing_result,
             tka.is_need_qc_quality     = tkb.is_need_qc_quality,
             tka.update_id              = 'ADMIN',
             tka.update_time            = sysdate
 
    WHEN NOT MATCHED THEN
      INSERT
        (tka.qa_warehouse_inspect_failed_id,
         tka.company_id,
         tka.qualfinishtime,
         tka.rela_goo_id,
         tka.style_number,
         tka.style_name,
         tka.category_id,
         tka.product_cate,
         tka.samll_category,
         tka.price,
         tka.supplier_code,
         tka.inside_supplier_code,
         tka.qualdecrease_amount,
         tka.if_batch_sporadic,
         tka.problem_classification,
         tka.problem_descriptions,
         tka.review_comments,
         tka.memo,
         tka.skuprocessing_result,
         tka.is_need_qc_quality,
         tka.qa_report_id,
         tka.order_id,
         tka.asn_id,
         tka.create_id,
         tka.create_time,
         tka.update_id,
         tka.update_time)
      VALUES
        (scmdata.f_get_uuid(),
         tkb.company_id,
         tkb.qualfinishtime,
         tkb.rela_goo_id,
         tkb.style_number,
         tkb.style_name,
         tkb.category_id,
         tkb.product_cate,
         tkb.samll_category,
         tkb.price,
         tkb.supplier_code,
         tkb.inside_supplier_code,
         tkb.qualdecrease_amount,
         tkb.if_batch_sporadic,
         tkb.problem_classification,
         tkb.problem_descriptions,
         tkb.review_comments,
         tkb.memo,
         tkb.skuprocessing_result,
         tkb.is_need_qc_quality,
         tkb.qa_report_id,
         tkb.order_id,
         tkb.asn_id,
         'ADMIN',
         sysdate,
         'ADMIN',
         sysdate);
    ---更新时间
    begin
      merge into scmdata.t_qa_warehouse_inspect_failed tka
      using (select t.qa_warehouse_inspect_failed_id,
                    t.qualfinishtime,
                    t.price,
                    t.qualdecrease_amount,
                    (t.price * t.qualdecrease_amount) qualdecrease_money,
                    to_char(t.qualfinishtime, 'yyyy') year,
                    to_char(t.qualfinishtime, 'mm') month,
                    to_char(t.qualfinishtime, 'Q') quarter,
                    decode(to_char(t.qualfinishtime, 'Q'),
                           '1',
                           '1',
                           '2',
                           '1',
                           '3',
                           '2',
                           '4',
                           '2') halfyear
               from scmdata.t_qa_warehouse_inspect_failed t) tkb
      on (tkb.qa_warehouse_inspect_failed_id = tka.qa_warehouse_inspect_failed_id)
      when matched then
        update
           set tka.year               = tkb.year,
               tka.month              = tkb.month,
               tka.quarter            = tkb.quarter,
               tka.halfyear           = tkb.halfyear,
               tka.qualdecrease_money = tkb.qualdecrease_money,
               tka.update_id          = 'ADMIN',
               tka.update_time        = sysdate;
    end;
  
begin
  for i in (select tq.qa_warehouse_inspect_failed_id,
                   tq.company_id,
                   tr.sho_id,
                   p.flw_order,
                   p.flw_order_manager,
                   p.qc,
                   p.qc_manager,
                   p.group_name,
                   p.factory_code
              from scmdata.pt_ordered p
             inner join (select t.company_id, t.order_code, t.sho_id
                          from scmdata.t_ordered t) tr
                on tr.company_id = p.company_id
               and tr.order_code = p.product_gress_code
             inner join scmdata.t_qa_warehouse_inspect_failed tq
                on tq.company_id = p.company_id
               and tq.order_id = p.product_gress_code
             where p.qc is not null) loop
    update scmdata.t_qa_warehouse_inspect_failed t
       set t.factory_code      = i.factory_code,
           t.sho_id            = i.sho_id,
           t.flw_order         = i.flw_order,
           t.flw_order_manager = i.flw_order_manager,
           t.qc                = i.qc,
           t.qc_manager        = i.qc_manager,
           t.group_name        = i.group_name
     where t.qa_warehouse_inspect_failed_id =
           i.qa_warehouse_inspect_failed_id
       and t.company_id = i.company_id;
  end loop;
end;

    ---更新跟单、跟单主管、QC、QC主管维度表
    begin
      delete scmdata.t_qa_warehouse_inspect_failed where qc is null;
      delete scmdata.t_qa_inspect_failed_flw_qc where trunc(qualfinishtime) > p_start_date;
      scmdata.PKG_QA_REPORT.P_T_QA_INSPECT_FAILED_FLW_QC;
    end;
  
  END P_T_QA_WAREHOUSE_INSPECT_FAILED;

  PROCEDURE P_T_QA_INSPECT_FAILED_FLW_QC IS
  BEGIN
    ---跟单
    merge into scmdata.t_qa_inspect_failed_flw_qc tka
    using (select qa_warehouse_inspect_failed_id,
                  company_id,
                  statistical_dimension,
                  (case
                    when sort_dimension is null then
                     '1'
                    else
                     sort_dimension
                  end) sort_dimension,
                  price,
                  sum1 qualdecrease_amount,
                  sum1 * price qualdecrease_money
             from (select t.qa_warehouse_inspect_failed_id,
                          t.company_id,
                          t.qualdecrease_amount,
                          t.price,
                          '06' statistical_dimension,
                          (t.qualdecrease_amount /
                          count(t.qa_warehouse_inspect_failed_id)
                           over(partition by t.qa_warehouse_inspect_failed_id)) sum1,
                          regexp_substr(t.flw_order, '[^,]+', 1, level) sort_dimension
                     from scmdata.t_qa_warehouse_inspect_failed t
                   connect by prior t.qa_warehouse_inspect_failed_id =
                               t.qa_warehouse_inspect_failed_id
                          and level <=
                              length(t.flw_order) -
                              length(regexp_replace(t.flw_order, ',', '')) + 1
                          and prior dbms_random.value is not null)) tkb
    on (tkb.qa_warehouse_inspect_failed_id = tka.qa_warehouse_inspect_failed_id and tka.company_id = tkb.company_id and tka.statistical_dimension = tkb.statistical_dimension and tka.sort_dimension = tkb.sort_dimension)
    when matched then
      update
         set tka.price               = tkb.price,
             tka.qualdecrease_amount = tkb.qualdecrease_amount,
             tka.qualdecrease_money  = tkb.qualdecrease_money,
             tka.update_id           = 'ADMIN',
             tka.update_time         = sysdate
    WHEN NOT MATCHED THEN
      INSERT
        (tka.qa_inspect_failed_flw_qc_id,
         tka.qa_warehouse_inspect_failed_id,
         tka.company_id,
         tka.statistical_dimension,
         tka.sort_dimension,
         tka.price,
         tka.qualdecrease_amount,
         tka.qualdecrease_money,
         tka.memo,
         tka.create_id,
         tka.create_time,
         tka.update_id,
         tka.update_time)
      VALUES
        (scmdata.f_get_uuid(),
         tkb.qa_warehouse_inspect_failed_id,
         tkb.company_id,
         tkb.statistical_dimension,
         tkb.sort_dimension,
         tkb.price,
         tkb.qualdecrease_amount,
         tkb.qualdecrease_money,
         '',
         'ADMIN',
         sysdate,
         'ADMIN',
         sysdate);
  
    ---跟单主管
    begin
      merge into scmdata.t_qa_inspect_failed_flw_qc tka
      using (select qa_warehouse_inspect_failed_id,
                    company_id,
                    statistical_dimension,
                    (case
                      when sort_dimension is null then
                       '1'
                      else
                       sort_dimension
                    end) sort_dimension,
                    price,
                    sum1 qualdecrease_amount,
                    sum1 * price qualdecrease_money
               from (select t.qa_warehouse_inspect_failed_id,
                            t.company_id,
                            t.qualdecrease_amount,
                            t.price,
                            '07' statistical_dimension,
                            (t.qualdecrease_amount /
                            count(t.qa_warehouse_inspect_failed_id)
                             over(partition by
                                  t.qa_warehouse_inspect_failed_id)) sum1,
                            regexp_substr(t.flw_order_manager,
                                          '[^,]+',
                                          1,
                                          level) sort_dimension
                       from scmdata.t_qa_warehouse_inspect_failed t
                     connect by prior t.qa_warehouse_inspect_failed_id =
                                 t.qa_warehouse_inspect_failed_id
                            and level <=
                                length(t.flw_order_manager) -
                                length(regexp_replace(t.flw_order_manager,
                                                      ',',
                                                      '')) + 1
                            and prior dbms_random.value is not null)) tkb
      on (tkb.qa_warehouse_inspect_failed_id = tka.qa_warehouse_inspect_failed_id and tka.company_id = tkb.company_id and tka.statistical_dimension = tkb.statistical_dimension and tka.sort_dimension = tkb.sort_dimension)
      when matched then
        update
           set tka.price               = tkb.price,
               tka.qualdecrease_amount = tkb.qualdecrease_amount,
               tka.qualdecrease_money  = tkb.qualdecrease_money,
               tka.update_id           = 'ADMIN',
               tka.update_time         = sysdate
      WHEN NOT MATCHED THEN
        INSERT
          (tka.qa_inspect_failed_flw_qc_id,
           tka.qa_warehouse_inspect_failed_id,
           tka.company_id,
           tka.statistical_dimension,
           tka.sort_dimension,
           tka.price,
           tka.qualdecrease_amount,
           tka.qualdecrease_money,
           tka.memo,
           tka.create_id,
           tka.create_time,
           tka.update_id,
           tka.update_time)
        VALUES
          (scmdata.f_get_uuid(),
           tkb.qa_warehouse_inspect_failed_id,
           tkb.company_id,
           tkb.statistical_dimension,
           tkb.sort_dimension,
           tkb.price,
           tkb.qualdecrease_amount,
           tkb.qualdecrease_money,
           '',
           'ADMIN',
           sysdate,
           'ADMIN',
           sysdate);
    end;
  
    ---QC
    begin
      merge into scmdata.t_qa_inspect_failed_flw_qc tka
      using (select qa_warehouse_inspect_failed_id,
                    company_id,
                    statistical_dimension,
                    (case
                      when sort_dimension is null then
                       '1'
                      else
                       sort_dimension
                    end) sort_dimension,
                    price,
                    sum1 qualdecrease_amount,
                    sum1 * price qualdecrease_money
               from (select t.qa_warehouse_inspect_failed_id,
                            t.company_id,
                            t.qualdecrease_amount,
                            t.price,
                            '08' statistical_dimension,
                            (t.qualdecrease_amount /
                            count(t.qa_warehouse_inspect_failed_id)
                             over(partition by
                                  t.qa_warehouse_inspect_failed_id)) sum1,
                            regexp_substr(t.qc, '[^,]+', 1, level) sort_dimension
                       from scmdata.t_qa_warehouse_inspect_failed t
                     connect by prior t.qa_warehouse_inspect_failed_id =
                                 t.qa_warehouse_inspect_failed_id
                            and level <=
                                length(t.qc) -
                                length(regexp_replace(t.qc, ',', '')) + 1
                            and prior dbms_random.value is not null)) tkb
      on (tkb.qa_warehouse_inspect_failed_id = tka.qa_warehouse_inspect_failed_id and tka.company_id = tkb.company_id and tka.statistical_dimension = tkb.statistical_dimension and tka.sort_dimension = tkb.sort_dimension)
      when matched then
        update
           set tka.price               = tkb.price,
               tka.qualdecrease_amount = tkb.qualdecrease_amount,
               tka.qualdecrease_money  = tkb.qualdecrease_money,
               tka.update_id           = 'ADMIN',
               tka.update_time         = sysdate
      WHEN NOT MATCHED THEN
        INSERT
          (tka.qa_inspect_failed_flw_qc_id,
           tka.qa_warehouse_inspect_failed_id,
           tka.company_id,
           tka.statistical_dimension,
           tka.sort_dimension,
           tka.price,
           tka.qualdecrease_amount,
           tka.qualdecrease_money,
           tka.memo,
           tka.create_id,
           tka.create_time,
           tka.update_id,
           tka.update_time)
        VALUES
          (scmdata.f_get_uuid(),
           tkb.qa_warehouse_inspect_failed_id,
           tkb.company_id,
           tkb.statistical_dimension,
           tkb.sort_dimension,
           tkb.price,
           tkb.qualdecrease_amount,
           tkb.qualdecrease_money,
           '',
           'ADMIN',
           sysdate,
           'ADMIN',
           sysdate);
    end;
  
    ---QC主管
    begin
      merge into scmdata.t_qa_inspect_failed_flw_qc tka
      using (select qa_warehouse_inspect_failed_id,
                    company_id,
                    statistical_dimension,
                    (case
                      when sort_dimension is null then
                       '1'
                      else
                       sort_dimension
                    end) sort_dimension,
                    price,
                    sum1 qualdecrease_amount,
                    sum1 * price qualdecrease_money
               from (select t.qa_warehouse_inspect_failed_id,
                            t.company_id,
                            t.qualdecrease_amount,
                            t.price,
                            '09' statistical_dimension,
                            (t.qualdecrease_amount /
                            count(t.qa_warehouse_inspect_failed_id)
                             over(partition by
                                  t.qa_warehouse_inspect_failed_id)) sum1,
                            regexp_substr(t.qc_manager, '[^,]+', 1, level) sort_dimension
                       from scmdata.t_qa_warehouse_inspect_failed t
                     connect by prior t.qa_warehouse_inspect_failed_id =
                                 t.qa_warehouse_inspect_failed_id
                            and level <=
                                length(t.qc_manager) -
                                length(regexp_replace(t.qc_manager, ',', '')) + 1
                            and prior dbms_random.value is not null)) tkb
      on (tkb.qa_warehouse_inspect_failed_id = tka.qa_warehouse_inspect_failed_id and tka.company_id = tkb.company_id and tka.statistical_dimension = tkb.statistical_dimension and tka.sort_dimension = tkb.sort_dimension)
      when matched then
        update
           set tka.price               = tkb.price,
               tka.qualdecrease_amount = tkb.qualdecrease_amount,
               tka.qualdecrease_money  = tkb.qualdecrease_money,
               tka.update_id           = 'ADMIN',
               tka.update_time         = sysdate
      WHEN NOT MATCHED THEN
        INSERT
          (tka.qa_inspect_failed_flw_qc_id,
           tka.qa_warehouse_inspect_failed_id,
           tka.company_id,
           tka.statistical_dimension,
           tka.sort_dimension,
           tka.price,
           tka.qualdecrease_amount,
           tka.qualdecrease_money,
           tka.memo,
           tka.create_id,
           tka.create_time,
           tka.update_id,
           tka.update_time)
        VALUES
          (scmdata.f_get_uuid(),
           tkb.qa_warehouse_inspect_failed_id,
           tkb.company_id,
           tkb.statistical_dimension,
           tkb.sort_dimension,
           tkb.price,
           tkb.qualdecrease_amount,
           tkb.qualdecrease_money,
           '',
           'ADMIN',
           sysdate,
           'ADMIN',
           sysdate);
    end;
    ---更新时间
    begin
      merge into scmdata.t_qa_inspect_failed_flw_qc tka
      using (select t.qa_warehouse_inspect_failed_id,
                    tq.qa_inspect_failed_flw_qc_id,
                    t.qualfinishtime,
                    t.year,
                    t.month,
                    t.quarter,
                    t.halfyear,
                    t.category_id,
                    t.group_name
               from scmdata.t_qa_warehouse_inspect_failed t
              inner join scmdata.t_qa_inspect_failed_flw_qc tq
                 on tq.qa_warehouse_inspect_failed_id =
                    t.qa_warehouse_inspect_failed_id
                and tq.company_id = t.company_id) tkb
      on (tka.qa_inspect_failed_flw_qc_id = tkb.qa_inspect_failed_flw_qc_id and tka.qa_warehouse_inspect_failed_id = tka.qa_warehouse_inspect_failed_id)
      when matched then
        update
           set tka.year           = tkb.year,
               tka.month          = tkb.month,
               tka.quarter        = tkb.quarter,
               tka.halfyear       = tkb.halfyear,
               tka.category_id    = tkb.category_id,
               tka.group_name     = tkb.group_name,
               tka.qualfinishtime = tkb.qualfinishtime,
               tka.update_id      = 'ADMIN',
               tka.update_time    = sysdate;
    end;
  
  END P_T_QA_INSPECT_FAILED_FLW_QC;

  PROCEDURE P_T_QA_INGOOD(p_start_date date, p_end_date date) IS
  
    v_sql      clob;
    v_sql_w    clob;
    v_sql_q    clob := q'[
 on (tka.company_id = tkb.company_id and tka.purchase_time = tkb.create_time 
    and tka.statistical_dimension = tkb.statistical_dimension and tka.sort_dimension = tkb.sort_dimension
    and tka.category_id = tkb.category_id  and tka.group_id = tkb.group_id )
    when matched then
      update
         set tka.purchase_money = tkb.purchase_money,
             tka.update_id      = 'ADMIN',
             tka.update_time    = sysdate
    WHEN NOT MATCHED THEN
      INSERT
        (tka.qa_ingood_id,
         tka.company_id,
         tka.purchase_time,tka.category_id,tka.group_id,
         tka.statistical_dimension,
         tka.sort_dimension,
         tka.purchase_money,
         tka.memo,
         tka.create_id,
         tka.create_time,
         tka.update_id,
         tka.update_time)
      VALUES
        (scmdata.f_get_uuid(),
         tkb.company_id,
         tkb.create_time,tkb.category_id,tkb.group_id,
         tkb.statistical_dimension,
         tkb.sort_dimension,
         tkb.purchase_money,
         '',
         'ADMIN',
         sysdate,
         'ADMIN',
         sysdate) ]';
    v_seal_day int := to_number(scmdata.pkg_db_job.f_get_seal_date(p_rtn_type => 0));
    --当月月初至当月5号 同步上月订单
    v_cur_mon varchar2(32) := scmdata.pkg_db_job.f_get_month(p_begin_date => p_start_date,
                                                             p_seal_day   => v_seal_day);
  BEGIN
    ---区域组00
    v_sql_w := q'[   merge into scmdata.t_qa_ingood tka
    using (select pt.company_id,
                  p1.create_time,pt.category category_id,(case when pt.group_name is null then '1' else pt.group_name end) group_id ,
                  '00' statistical_dimension,
                  (case when pt.group_name is null then '1' else pt.group_name end) sort_dimension,
                  sum(goo.price * p1.amount) purchase_money
             from scmdata.pt_ordered pt
            inner join (select t.document_no, t.company_id, trunc(t.create_time) create_time, sum(tl.amount) amount, tl.goo_id
                         from scmdata.t_ingood t
                        inner join (select ti.ing_id, ti.company_id, ti.goo_id, ti.amount
                                     from scmdata.t_ingoods ti where ti.amount > 0) tl
                           on tl.ing_id = t.ing_id
                          and tl.company_id = t.company_id
                        where to_char(t.create_time, 'yyyy') >= 2022
                        group by t.document_no, t.company_id, trunc(t.create_time), tl.goo_id) p1
               on p1.document_no = pt.product_gress_code
              and p1.company_id = pt.company_id
             left join scmdata.t_commodity_info goo
               on p1.goo_id = goo.goo_id
              and p1.company_id = goo.company_id
            where pt.qc is not null
              and (p1.create_time between to_date(']' ||
               to_char(p_start_date, 'yyyy-mm-dd') ||
               q'[','yyyy-mm-dd') and  to_date(']' ||
               to_char(p_end_date, 'yyyy-mm-dd') ||
               q'[' ,'yyyy-mm-dd') )
               or to_char(p1.create_time,'yyyy-mm') = ']' ||
               v_cur_mon ||
               q'[' 
            group by pt.company_id, p1.create_time, pt.group_name,pt.category) tkb ]';
    v_sql   := v_sql_w || v_sql_q;
    dbms_output.put_line(v_sql);
    execute immediate v_sql;
    ---分类01
    begin
      v_sql_w := q'[   merge into scmdata.t_qa_ingood tka
      using (select pt.company_id,
                    p1.create_time,pt.category category_id,(case when pt.group_name is null then '1' else pt.group_name end) group_id ,
                    '01' statistical_dimension,
                    (case  when pt.category is null then '1' else pt.category end) sort_dimension,
                    sum(goo.price * p1.amount) purchase_money
               from scmdata.pt_ordered pt
              inner join (select t.document_no, t.company_id, trunc(t.create_time) create_time, sum(tl.amount) amount, tl.goo_id
                           from scmdata.t_ingood t
                          inner join (select ti.ing_id, ti.company_id, ti.goo_id, ti.amount
                                       from scmdata.t_ingoods ti where ti.amount > 0) tl
                             on tl.ing_id = t.ing_id
                            and tl.company_id = t.company_id
                          where to_char(t.create_time, 'yyyy') >= 2022
                          group by t.document_no, t.company_id, trunc(t.create_time), tl.goo_id) p1
                 on p1.document_no = pt.product_gress_code
                and p1.company_id = pt.company_id
               left join scmdata.t_commodity_info goo
                 on p1.goo_id = goo.goo_id
                and p1.company_id = goo.company_id
              where pt.qc is not null
              and (p1.create_time between to_date(']' ||
                 to_char(p_start_date, 'yyyy-mm-dd') ||
                 q'[','yyyy-mm-dd') and  to_date(']' ||
                 to_char(p_end_date, 'yyyy-mm-dd') ||
                 q'[' ,'yyyy-mm-dd') )
               or to_char(p1.create_time,'yyyy-mm') = ']' ||
                 v_cur_mon ||
                 q'[' 
              group by pt.company_id, p1.create_time, pt.category,pt.group_name) tkb  ]';
      v_sql   := v_sql_w || v_sql_q;
      execute immediate v_sql;
    end;
    ---款式名称02
    begin
      v_sql_w := q'[      merge into scmdata.t_qa_ingood tka
      using (select pt.company_id,
                    p1.create_time,pt.category category_id,(case when pt.group_name is null then '1' else pt.group_name end) group_id ,
                    '02' statistical_dimension,
                    (case when pt.style_name is null then '1' else pt.style_name end) sort_dimension,
                    sum(goo.price * p1.amount) purchase_money
               from scmdata.pt_ordered pt
              inner join (select t.document_no, t.company_id, trunc(t.create_time) create_time, sum(tl.amount) amount,tl.goo_id
                           from scmdata.t_ingood t
                          inner join (select ti.ing_id, ti.company_id,ti.goo_id, ti.amount
                                       from scmdata.t_ingoods ti where ti.amount > 0) tl
                             on tl.ing_id = t.ing_id
                            and tl.company_id = t.company_id
                          where to_char(t.create_time, 'yyyy') >= 2022
                          group by t.document_no, t.company_id, trunc(t.create_time),tl.goo_id) p1
                 on p1.document_no = pt.product_gress_code
                and p1.company_id = pt.company_id
               left join scmdata.t_commodity_info goo
                 on p1.goo_id = goo.goo_id
                and p1.company_id = goo.company_id
              where pt.qc is not null
              and (p1.create_time between to_date(']' ||
                 to_char(p_start_date, 'yyyy-mm-dd') ||
                 q'[','yyyy-mm-dd') and  to_date(']' ||
                 to_char(p_end_date, 'yyyy-mm-dd') ||
                 q'[' ,'yyyy-mm-dd') )
               or to_char(p1.create_time,'yyyy-mm') = ']' ||
                 v_cur_mon ||
                 q'[' 
              group by pt.company_id, p1.create_time, pt.style_name,pt.group_name,pt.category) tkb  ]';
    
      v_sql := v_sql_w || v_sql_q;
      execute immediate v_sql;
    end;
    ---产品子类03
    begin
      v_sql_w := q'[      merge into scmdata.t_qa_ingood tka
      using (select pt.company_id, p1.create_time,pt.category category_id,(case when pt.group_name is null then '1' else pt.group_name end) group_id ,
                    '03' statistical_dimension,
                    (case when pt.samll_category is null then '1' else pt.samll_category end) sort_dimension,
                    sum(goo.price * p1.amount) purchase_money
               from scmdata.pt_ordered pt
              inner join (select t.document_no, t.company_id, trunc(t.create_time) create_time,sum(tl.amount) amount, tl.goo_id
                           from scmdata.t_ingood t
                          inner join (select ti.ing_id, ti.company_id, ti.goo_id, ti.amount
                                       from scmdata.t_ingoods ti where ti.amount > 0) tl
                             on tl.ing_id = t.ing_id
                            and tl.company_id = t.company_id
                          where to_char(t.create_time, 'yyyy') >= 2022
                          group by t.document_no, t.company_id, trunc(t.create_time), tl.goo_id) p1
                 on p1.document_no = pt.product_gress_code
                and p1.company_id = pt.company_id
               left join scmdata.t_commodity_info goo
                 on p1.goo_id = goo.goo_id
                and p1.company_id = goo.company_id
              where pt.qc is not null
              and (p1.create_time between to_date(']' ||
                 to_char(p_start_date, 'yyyy-mm-dd') ||
                 q'[','yyyy-mm-dd') and  to_date(']' ||
                 to_char(p_end_date, 'yyyy-mm-dd') ||
                 q'[' ,'yyyy-mm-dd') )
               or to_char(p1.create_time,'yyyy-mm') = ']' ||
                 v_cur_mon ||
                 q'[' 
              group by pt.company_id, p1.create_time, pt.samll_category,pt.group_name,pt.category) tkb ]';
    
      v_sql := v_sql_w || v_sql_q;
      execute immediate v_sql;
    end;
  
    ---供应商04
    begin
      v_sql_w := q'[    merge into scmdata.t_qa_ingood tka
      using (select pt.company_id,
                    p1.create_time,pt.category category_id,(case when pt.group_name is null then '1' else pt.group_name end) group_id ,
                    '04' statistical_dimension,
                    (case when pt.supplier_code is null then '1' else pt.supplier_code end) sort_dimension,
                    sum(goo.price * p1.amount) purchase_money
               from scmdata.pt_ordered pt
              inner join (select t.document_no, t.company_id, trunc(t.create_time) create_time,sum(tl.amount) amount, tl.goo_id
                           from scmdata.t_ingood t
                          inner join (select ti.ing_id, ti.company_id, ti.goo_id, ti.amount
                                       from scmdata.t_ingoods ti where ti.amount > 0) tl
                             on tl.ing_id = t.ing_id
                            and tl.company_id = t.company_id
                          where to_char(t.create_time, 'yyyy') >= 2022
                          group by t.document_no, t.company_id, trunc(t.create_time), tl.goo_id) p1
                 on p1.document_no = pt.product_gress_code
                and p1.company_id = pt.company_id
               left join scmdata.t_commodity_info goo
                 on p1.goo_id = goo.goo_id
                and p1.company_id = goo.company_id
              where pt.qc is not null
              and (p1.create_time between to_date(']' ||
                 to_char(p_start_date, 'yyyy-mm-dd') ||
                 q'[','yyyy-mm-dd') and  to_date(']' ||
                 to_char(p_end_date, 'yyyy-mm-dd') ||
                 q'[' ,'yyyy-mm-dd') )
               or to_char(p1.create_time,'yyyy-mm') = ']' ||
                 v_cur_mon ||
                 q'[' 
              group by pt.company_id, p1.create_time, pt.supplier_code,pt.group_name,pt.category) tkb  ]';
    
      v_sql := v_sql_w || v_sql_q;
      execute immediate v_sql;
    end;
    ---生产工厂05
    begin
      v_sql_w := q'[       merge into scmdata.t_qa_ingood tka
      using (select pt.company_id,
                    p1.create_time,pt.category category_id,(case when pt.group_name is null then '1' else pt.group_name end) group_id ,
                    '05' statistical_dimension,
                    (case when pt.factory_code is null then '1' else pt.factory_code end) sort_dimension,
                    sum(goo.price * p1.amount) purchase_money
               from scmdata.pt_ordered pt
              inner join (select t.document_no, t.company_id, trunc(t.create_time) create_time,sum(tl.amount) amount, tl.goo_id
                           from scmdata.t_ingood t
                          inner join (select ti.ing_id, ti.company_id, ti.goo_id, ti.amount
                                       from scmdata.t_ingoods ti where ti.amount > 0) tl
                             on tl.ing_id = t.ing_id
                            and tl.company_id = t.company_id
                          where to_char(t.create_time, 'yyyy') >= 2022
                          group by t.document_no, t.company_id, trunc(t.create_time), tl.goo_id) p1
                 on p1.document_no = pt.product_gress_code
                and p1.company_id = pt.company_id
               left join scmdata.t_commodity_info goo
                 on p1.goo_id = goo.goo_id
                and p1.company_id = goo.company_id
              where pt.qc is not null
              and (p1.create_time between to_date(']' ||
                 to_char(p_start_date, 'yyyy-mm-dd') ||
                 q'[','yyyy-mm-dd') and  to_date(']' ||
                 to_char(p_end_date, 'yyyy-mm-dd') ||
                 q'[' ,'yyyy-mm-dd') )
               or to_char(p1.create_time,'yyyy-mm') = ']' ||
                 v_cur_mon ||
                 q'[' 
              group by pt.company_id, p1.create_time, pt.factory_code,pt.group_name,pt.category) tkb  ]';
    
      v_sql := v_sql_w || v_sql_q;
      execute immediate v_sql;
    end;
  
    ---跟单06
    begin
      v_sql_w := q'[     merge into scmdata.t_qa_ingood tka
      using (select company_id, create_time,category_id,group_id, statistical_dimension,
                    (case when flw_order is null then '1' else flw_order  end) sort_dimension,
                    sum(price * sum1) purchase_money
               from (select  pt.company_id, pt.product_gress_code,
                            p1.create_time,pt.category category_id,(case when pt.group_name is null then '1' else pt.group_name end) group_id ,
                            '06' statistical_dimension,  goo.price, p1.amount,
                            flw_order,
                            (p1.amount / count(p1.document_no) over(partition by p1.document_no, p1.create_time)) sum1
                       from (select pt_ordered_id,
                             product_gress_code,
                             company_id,
                             category,
                             group_name,
                             regexp_substr(flw_order, '[^,]+', 1, level) flw_order
                        from scmdata.pt_ordered
                       where qc is not null
                      connect by prior pt_ordered_id = pt_ordered_id
                             and level <=
                                 length(flw_order) - length(regexp_replace(flw_order, ',', '')) + 1
                             and prior dbms_random.value is not null) pt
                      inner join (select t.document_no, t.company_id, trunc(t.create_time) create_time, sum(tl.amount) amount, tl.goo_id
                                   from scmdata.t_ingood t
                                  inner join (select ti.ing_id, ti.company_id, ti.goo_id, ti.amount
                                               from scmdata.t_ingoods ti where ti.amount > 0) tl
                                     on tl.ing_id = t.ing_id
                                    and tl.company_id = t.company_id
                                  where to_char(t.create_time, 'yyyy') >= 2022
                                  group by t.document_no, t.company_id,trunc(t.create_time), tl.goo_id) p1
                         on p1.document_no = pt.product_gress_code
                        and p1.company_id = pt.company_id
                       left join scmdata.t_commodity_info goo
                         on p1.goo_id = goo.goo_id
                        and p1.company_id = goo.company_id )
              where (create_time between to_date(']' ||
                 to_char(p_start_date, 'yyyy-mm-dd') ||
                 q'[','yyyy-mm-dd') and  to_date(']' ||
                 to_char(p_end_date, 'yyyy-mm-dd') ||
                 q'[' ,'yyyy-mm-dd'))
               or to_char(create_time,'yyyy-mm') = ']' ||
                 v_cur_mon ||
                 q'[' 
              group by company_id, create_time,statistical_dimension, flw_order,category_id,group_id) tkb  ]';
    
      v_sql := v_sql_w || v_sql_q;
      execute immediate v_sql;
    end;
    ---跟单主管07
    begin
      v_sql_w := q'[      merge into scmdata.t_qa_ingood tka
      using (select company_id,create_time,category_id,group_id, statistical_dimension,
                    (case when flw_order_manager is null then '1' else flw_order_manager end) sort_dimension,
                    sum(price * sum1) purchase_money
               from (select pt.company_id,pt.category category_id,(case when pt.group_name is null then '1' else pt.group_name end) group_id ,
                            pt.product_gress_code,
                            p1.create_time,
                            '07' statistical_dimension,
                            goo.price,
                            p1.amount,
                            flw_order_manager,
                            (p1.amount / count(p1.document_no) over(partition by p1.document_no, p1.create_time)) sum1
                       from (select pt_ordered_id,
                                     product_gress_code,
                                     company_id,
                                     category,
                                     group_name,
                                     regexp_substr(flw_order_manager, '[^,]+', 1, level) flw_order_manager
                                from scmdata.pt_ordered
                               where qc is not null
                              connect by prior pt_ordered_id = pt_ordered_id
                                     and level <=
                                         length(flw_order_manager) - length(regexp_replace(flw_order_manager, ',', '')) + 1
                                     and prior dbms_random.value is not null) pt
                      inner join (select t.document_no, t.company_id, trunc(t.create_time) create_time, sum(tl.amount) amount, tl.goo_id
                                   from scmdata.t_ingood t
                                  inner join (select ti.ing_id, ti.company_id, ti.goo_id, ti.amount
                                               from scmdata.t_ingoods ti where ti.amount > 0) tl
                                     on tl.ing_id = t.ing_id
                                    and tl.company_id = t.company_id
                                  where to_char(t.create_time, 'yyyy') >= 2022
                                  group by t.document_no, t.company_id,trunc(t.create_time), tl.goo_id) p1
                         on p1.document_no = pt.product_gress_code
                        and p1.company_id = pt.company_id
                       left join scmdata.t_commodity_info goo
                         on p1.goo_id = goo.goo_id
                        and p1.company_id = goo.company_id )
              where (create_time between to_date(']' ||
                 to_char(p_start_date, 'yyyy-mm-dd') ||
                 q'[','yyyy-mm-dd') and  to_date(']' ||
                 to_char(p_end_date, 'yyyy-mm-dd') ||
                 q'[' ,'yyyy-mm-dd'))
               or to_char(create_time,'yyyy-mm') = ']' ||
                 v_cur_mon ||
                 q'[' 
              group by company_id,  create_time, statistical_dimension, flw_order_manager,category_id,group_id) tkb ]';
    
      v_sql := v_sql_w || v_sql_q;
      execute immediate v_sql;
    end;
  
    ---QC08
    begin
      v_sql_w := q'[     merge into scmdata.t_qa_ingood tka
      using (select company_id, create_time,category_id,group_id, statistical_dimension, qc sort_dimension,
                    sum(price * sum1) purchase_money
               from (select pt.company_id,pt.category category_id,(case when pt.group_name is null then '1' else pt.group_name end) group_id ,
                            pt.product_gress_code,
                            p1.create_time,
                            '08' statistical_dimension,
                            goo.price,
                            p1.amount,
                            qc,
                            (p1.amount / count(p1.document_no) over(partition by p1.document_no, p1.create_time)) sum1
                       from ( select pt_ordered_id,
                                     product_gress_code,
                                     company_id,
                                     category,
                                     group_name,
                                     regexp_substr(qc, '[^,]+', 1, level) qc
                                from scmdata.pt_ordered
                               where qc is not null
                              connect by prior pt_ordered_id = pt_ordered_id
                                     and level <=
                                         length(qc) - length(regexp_replace(qc, ',', '')) + 1
                                     and prior dbms_random.value is not null ) pt
                      inner join (select t.document_no, t.company_id, trunc(t.create_time) create_time, sum(tl.amount) amount, tl.goo_id
                                   from scmdata.t_ingood t
                                  inner join (select ti.ing_id, ti.company_id, ti.goo_id, ti.amount
                                               from scmdata.t_ingoods ti where ti.amount > 0) tl
                                     on tl.ing_id = t.ing_id
                                    and tl.company_id = t.company_id
                                  where to_char(t.create_time, 'yyyy') >= 2022
                                  group by t.document_no, t.company_id,trunc(t.create_time), tl.goo_id) p1
                         on p1.document_no = pt.product_gress_code
                        and p1.company_id = pt.company_id
                       left join scmdata.t_commodity_info goo
                         on p1.goo_id = goo.goo_id
                        and p1.company_id = goo.company_id
                       left join scmdata.t_commodity_info goo
                         on p1.goo_id = goo.goo_id
                        and p1.company_id = goo.company_id )
              where (create_time between to_date(']' ||
                 to_char(p_start_date, 'yyyy-mm-dd') ||
                 q'[','yyyy-mm-dd') and  to_date(']' ||
                 to_char(p_end_date, 'yyyy-mm-dd') ||
                 q'[' ,'yyyy-mm-dd'))
               or to_char(create_time,'yyyy-mm') = ']' ||
                 v_cur_mon ||
                 q'[' 
              group by company_id, create_time, statistical_dimension, qc,category_id,group_id) tkb  ]';
    
      v_sql := v_sql_w || v_sql_q;
      execute immediate v_sql;
    end;
    ---QC主管09
    begin
      v_sql_w := q'[    merge into scmdata.t_qa_ingood tka
      using (select company_id,create_time,category_id,group_id, statistical_dimension,
                    (case when qc_manager is null then '1' else qc_manager end) sort_dimension,
                    sum(price * sum1) purchase_money
               from (select pt.company_id,pt.category category_id,(case when pt.group_name is null then '1' else pt.group_name end) group_id ,
                            pt.product_gress_code,
                            p1.create_time,
                            '09' statistical_dimension,
                            goo.price,
                            p1.amount,
                            qc_manager,
                            (p1.amount / count(p1.document_no) over(partition by p1.document_no, p1.create_time)) sum1
                       from (select pt_ordered_id,
                                     product_gress_code,
                                     company_id,
                                     category,
                                     group_name,
                                     regexp_substr(qc_manager, '[^,]+', 1, level) qc_manager
                                from scmdata.pt_ordered
                               where qc is not null
                              connect by prior pt_ordered_id = pt_ordered_id
                                     and level <=
                                         length(qc_manager) - length(regexp_replace(qc_manager, ',', '')) + 1
                                     and prior dbms_random.value is not null) pt
                      inner join (select t.document_no, t.company_id, trunc(t.create_time) create_time, sum(tl.amount) amount, tl.goo_id
                                   from scmdata.t_ingood t
                                  inner join (select ti.ing_id, ti.company_id, ti.goo_id, ti.amount
                                               from scmdata.t_ingoods ti where ti.amount > 0) tl
                                     on tl.ing_id = t.ing_id
                                    and tl.company_id = t.company_id
                                  where to_char(t.create_time, 'yyyy') >= 2022
                                  group by t.document_no, t.company_id,trunc(t.create_time), tl.goo_id) p1
                         on p1.document_no = pt.product_gress_code
                        and p1.company_id = pt.company_id
                       left join scmdata.t_commodity_info goo
                         on p1.goo_id = goo.goo_id
                        and p1.company_id = goo.company_id )
              where (create_time between to_date(']' ||
                 to_char(p_start_date, 'yyyy-mm-dd') ||
                 q'[','yyyy-mm-dd') and  to_date(']' ||
                 to_char(p_end_date, 'yyyy-mm-dd') ||
                 q'[' ,'yyyy-mm-dd'))
               or to_char(create_time,'yyyy-mm') = ']' ||
                 v_cur_mon ||
                 q'[' 
              group by company_id,
                       create_time,
                       statistical_dimension,
                       qc_manager,category_id,group_id) tkb  ]';
    
      v_sql := v_sql_w || v_sql_q;
      execute immediate v_sql;
    end;
  
    begin
      for ei in (select t.qa_ingood_id,
                        to_char(t.purchase_time, 'yyyy') year,
                        to_char(t.purchase_time, 'mm') month,
                        to_char(t.purchase_time, 'Q') quarter,
                        decode(to_char(t.purchase_time, 'Q'),
                               1,
                               1,
                               2,
                               1,
                               3,
                               2,
                               4,
                               2) halfyear
                   from scmdata.t_qa_ingood t) loop
        update scmdata.t_qa_ingood t1
           set t1.year     = ei.year,
               t1.month    = ei.month,
               t1.quarter  = ei.quarter,
               t1.halfyear = ei.halfyear
         where t1.qa_ingood_id = ei.qa_ingood_id;
      end loop;
    end;
  
  END P_T_QA_INGOOD;

  --获取数据权限sql
  FUNCTION F_GET_DATAPRIVS_SQL(p_class_data_privs VARCHAR2,
                               p_pre              VARCHAR2 DEFAULT 't')
    RETURN CLOB IS
  BEGIN
    RETURN q'[ AND ((%is_company_admin%) = 1 OR instr_priv(p_str1 => ']' || p_class_data_privs || q'[', p_str2 => ]' || p_pre || q'[.category_id, p_split => ';') > 0) ]';
  END F_GET_DATAPRIVS_SQL;

  FUNCTION F_KPI_180_SELECTSQL(KPI_TIMETYPE       VARCHAR2,
                               KPI_TIME           VARCHAR2,
                               KPI_DIMENSION      VARCHAR2,
                               KPI_GROUP          VARCHAR2,
                               KPI_CATEGORY       VARCHAR2,
                               P_CLASS_DATA_PRIVS CLOB,
                               COMPANY_ID         VARCHAR2) RETURN CLOB IS
    v1_sql  clob;
    v2_sql  clob;
    v3_sql  clob;
    vc1_sql clob;
    vc_sql2 clob;
    --v_b_s   varchar2(1000);
    --v_b_g1  varchar2(1000);
    v_b1_g1  varchar2(1000);
    --v_b_g2  varchar2(1000);
    v_c_k   varchar(4000);
    ---v_c_g        varchar(4000);
    v_z          varchar2(1280);
    v_c          varchar2(1280);
    v_c1         varchar2(1280);
    v_c_where    varchar2(1280);
    v_c_w        varchar2(1280);
    v_c_i        varchar2(1280);
    v_c_i1       varchar2(1280);
    v1_b         varchar2(1280);
    v1_a         varchar2(1280);
    v2_b         varchar2(1280);
    v3_b         varchar2(1280);
    v_h1         varchar2(4000);
    v_h2         varchar2(4000);
    v_h3         varchar2(4000);
    v_c_group    varchar2(1280);
    v_c_sql      clob;
    v_dimension  varchar2(3200);
    v1_dimension varchar2(1000);
    v2_dimension varchar2(1000);
    v_group      varchar2(3200);
    v1_where     varchar2(1000);
    v_sort       varchar2(128) := ' ';
    k_time       varchar2(128) := kpi_time;
    v_sql        clob;
  BEGIN
    ---汇总字段条件
    if K_TIME = '本月' then
      K_TIME := to_char(sysdate, 'yyyy-mm');
    end if;
    ---汇总主键
    v1_dimension := '{"COL_1":' || K_TIME || ',"COL_2":' || KPI_GROUP ||
                    ',"COL_3":' || KPI_CATEGORY || ' ,"COL_4":' ||
                    KPI_DIMENSION || ' }';
    ---拼接主键
    v2_dimension := '''{"COL_1":' || K_TIME || ',"COL_2":' || KPI_GROUP ||
                    ',"COL_3":' || KPI_CATEGORY || ' ,"COL_4":' ||
                    KPI_DIMENSION || ' ,"COL_5":''' ||
                    '|| td.sort_dimension' || '||'' }''';
  
    --统计维度
    if kpi_dimension = '00' THEN
      --统计维度：区域组
      v_c_where := ' and t.statistical_dimension = ''00'' ';
      v_c_i     := ' and tp.group_id = td.sort_dimension ';
      v_c_k     := ''; ---'(case when ts.group_name is null then ''1'' else ts.group_name end) group_name,t.group_id,';
      -- v_c_g        := '';---' ts.group_name,t.group_id,';
      --v_b_g1 := ' ,tp.group_name ';
      v_b1_g1 := ' ,tq.group_name ';
      --v_b_g2 := ' and tq1.group_name = tq.group_name ';
      if kpi_category = '1' then
        v_dimension := ' td.group_name area_group ,''全部'' category_name,' ||
                       v2_dimension || ' pid ,';
        v_group     := ' group by td.total_time,td.group_name,td.group_id,' ||
                       v2_dimension;
      else
        v_dimension := ' td.group_name area_group,td.category_name,' ||
                       v2_dimension || ' pid ,';
        v_group     := ' group by td.total_time,td.group_name, td.category_name,' ||
                       v2_dimension;
      end if;
      if kpi_group = '1' and kpi_category = '1' then
        v_c_i1 := ' ';
      elsif  kpi_group = '1' and kpi_category <> '1' then
        v_c_i1 := ' and tp.category_id = td.category_id ';
      elsif  kpi_group <> '1' and kpi_category = '1' then
        v_c_i1 := ' and tp.group_id = td.sort_dimension ';
      elsif  kpi_group <> '1' and kpi_category <> '1' then
        v_c_i1 := ' and tp.group_id = td.sort_dimension
                    and tp.category_id = td.category_id ';
      end if;
    elsif kpi_dimension = '01' THEN
      --统计维度：分类
      v_c_where := ' and t.statistical_dimension = ''01'' ';
      v_c_i     := ' and tp.category_id = td.sort_dimension ';
      v_c_k     := '  '; ---' c.group_dict_name category_name, t.category_id,';
      --v_c_g        := '  ';---' c.group_dict_name ,t.category_id, ';
      --v_b_g1 := ' ,tp.category_id ';
      v_b1_g1 := ' ,tq.category_id ';
      --v_b_g2 := ' and tq1.category_id = tq.category_id ';
      if kpi_group = '1' then
        v_dimension := ' ''全部'' area_group  , td.category_name,' ||
                       v2_dimension || ' pid ,';
        v_group     := ' group by td.total_time , td.category_name,td.category_id,' ||
                       v2_dimension;
      else
        v_dimension := ' td.group_name area_group,td.category_name,' ||
                       v2_dimension || ' pid ,';
        v_group     := ' group by td.total_time,td.group_name,td.category_name,td.category_id,' ||
                       v2_dimension;
      end if;
      if kpi_group = '1' and kpi_category = '1' then
        v_c_i1 := ' ';
      elsif  kpi_group = '1' and kpi_category <> '1' then
        v_c_i1 := ' and tp.category_id = td.sort_dimension ';
      elsif  kpi_group <> '1' and kpi_category = '1' then
        v_c_i1 := ' and tp.group_id = td.group_id ';
      elsif  kpi_group <> '1' and kpi_category <> '1' then
        v_c_i1 := ' and tp.group_id = td.group_id
                    and tp.category_id = td.sort_dimension ';
      end if;
    elsif kpi_dimension = '02' THEN
      --统计维度：款式名称
      if kpi_group = '1' and kpi_category = '1' then
        v_c_i1 := ' and tp.style_name = td.sort_dimension ';
      elsif kpi_group = '1' and kpi_category <> '1' then
        v_c_i1 := ' and tp.style_name = td.sort_dimension 
                    and tp.category_id = td.category_id ';
      elsif kpi_group <> '1' and kpi_category = '1' then
        v_c_i1 := ' and tp.style_name = td.sort_dimension 
                    and tp.group_id = td.group_id ';
      elsif kpi_group <> '1' and kpi_category <> '1' then
        v_c_i1 := ' and tp.style_name = td.sort_dimension 
                    and tp.group_id = td.group_id 
                    and tp.category_id = td.category_id ';
      end if;
      v_c_where := ' and t.statistical_dimension = ''02'' ';
      v_c_i     := ' and tp.style_name = td.sort_dimension ';
      v_sort    := ' '' ''style_names, ';
      -- v_c_k        := ' t.sort_dimension style_name, ';
      v_c_k := ' ,style_name ';
      ---v_c_g        := '';
      --v_b_g1 := ' ,tp.style_name ';
      v_b1_g1 := ' ,tq.style_name ';
      --v_b_g2 := ' and tq1.style_name = tq.style_name ';
      if kpi_category = '1' and kpi_group = '1' then
        v_dimension := ' ''全部'' area_group ,''全部'' category_name,td.style_name style_names,' ||
                       v2_dimension || ' pid ,';
        v_group     := ' group by td.total_time,td.style_name,' ||
                       v2_dimension;
      elsif kpi_category = '1' and kpi_group <> '1' then
        v_dimension := ' td.group_name area_group ,''全部'' category_name,td.style_name style_names,' ||
                       v2_dimension || ' pid ,';
        v_group     := ' group by td.total_time,td.group_name ,td.style_name,' ||
                       v2_dimension;
      elsif kpi_category <> '1' and kpi_group = '1' then
        v_dimension := '''全部'' area_group ,td.category_name,td.style_name style_names,' ||
                       v2_dimension || ' pid ,';
        v_group     := ' group by td.total_time ,td.category_name,td.style_name,' ||
                       v2_dimension;
      else
        v_dimension := ' td.group_name area_group,td.category_name,td.style_name style_names,' ||
                       v2_dimension || ' pid ,';
        v_group     := ' group by td.total_time,td.group_name ,td.category_name,td.style_name,' ||
                       v2_dimension;
      end if;
    elsif kpi_dimension = '03' THEN
      --统计维度：产品子类
      if kpi_group = '1' and kpi_category = '1' then
        v_c_i1 := ' and tp.samll_category = td.sort_dimension ';
      elsif kpi_group = '1' and kpi_category <> '1' then
        v_c_i1 := ' and tp.samll_category = td.sort_dimension 
                    and tp.category_id = td.category_id ';
      elsif kpi_group <> '1' and kpi_category = '1' then
        v_c_i1 := ' and tp.samll_category = td.sort_dimension
                    and tp.group_id = td.group_id ';
      elsif kpi_group <> '1' and kpi_category <> '1' then
        v_c_i1 := ' and tp.samll_category = td.sort_dimension
                    and tp.group_id = td.group_id 
                    and tp.category_id = td.category_id ';
      end if;
      v_c_where := ' and t.statistical_dimension = ''03'' ';
      v_c_i     := ' and tp.samll_category = td.sort_dimension ';
      v_sort    := ''' '' procate_desc,'' ''samll_category_name,'' ''small_category_gd, ';
      -- v_c_k        := 't.sort_dimension small_category_gd, samll.cate_category cate_category_name,  samll.samll_category samll_category_name,';
      v_c_k := ',small_category_gd, cate_category_name, samll_category_name ';
      -- v_c_g        := ' samll.cate_category,samll.samll_category, ';
      --v_b_g1 := ', tp.samll_category ';
      v_b1_g1 := ' ,tq.samll_category ';
      --v_b_g2 := ' and tq1.samll_category = tq.samll_category ';
      if kpi_category = '1' and kpi_group = '1' then
        v_dimension := ' ''全部'' area_group ,''全部'' category_name,cate_category_name procate_desc, samll_category_name,samll_category small_category_gd,' ||
                       v2_dimension || ' pid ,';
        v_group     := ' group by total_time,cate_category_name,samll_category,samll_category_name,' ||
                       v2_dimension;
      elsif kpi_category = '1' and kpi_group <> '1' then
        v_dimension := 'td.group_name area_group ,''全部'' category_name,cate_category_name procate_desc, samll_category_name,samll_category small_category_gd,' ||
                       v2_dimension || ' pid ,';
        v_group     := ' group by total_time,td.group_name ,cate_category_name,samll_category,samll_category_name,' ||
                       v2_dimension;
      elsif kpi_category <> '1' and kpi_group = '1' then
        v_dimension := '''全部'' area_group ,category_name,cate_category_name procate_desc,  samll_category_name,samll_category small_category_gd,' ||
                       v2_dimension || ' pid ,';
        v_group     := ' group by total_time ,category_name,cate_category_name,samll_category,samll_category_name,' ||
                       v2_dimension;
      else
        v_dimension := 'td.group_name area_group ,category_name,cate_category_name procate_desc, samll_category_name,samll_category small_category_gd,' ||
                       v2_dimension || ' pid ,';
        v_group     := ' group by total_time,td.group_name ,category_name,cate_category_name,samll_category_name,samll_category,' ||
                       v2_dimension;
      end if;
    elsif kpi_dimension = '04' THEN
      --统计维度：供应商

      if kpi_group = '1' and kpi_category = '1' then
        v_c_i1 := ' and tp.inside_supplier_code = td.sort_dimension ';
      elsif kpi_group = '1' and kpi_category <> '1' then
        v_c_i1 := ' and tp.inside_supplier_code = td.sort_dimension 
                    and tp.category_id = td.category_id ';
      elsif kpi_group <> '1' and kpi_category = '1' then
        v_c_i1 := ' and tp.inside_supplier_code = td.sort_dimension
                    and tp.group_id = td.group_id ';
      elsif kpi_group <> '1' and kpi_category <> '1' then
        v_c_i1 := ' and tp.inside_supplier_code = td.sort_dimension
                    and tp.group_id = td.group_id 
                    and tp.category_id = td.category_id ';
      end if;
      v_c_where := ' and t.statistical_dimension = ''04'' ';
      v_c_i     := ' and tp.inside_supplier_code = td.sort_dimension ';
      v_sort    := ''' ''supplier_code, '' ''supplier, ';
      ---v_c_k        := ' tsup.supplier_code,  tsup.supplier_company_name supplier,';
      v_c_k := ' ,supplier_code, supplier ';
      /*      v_c_g        := ' tsup.supplier_code,tsup.supplier_company_name, ';*/
      --v_b_g1 := ' ,tp.inside_supplier_code ';
      v_b1_g1 := ' ,tq.inside_supplier_code ';
      --v_b_g2 := ' and tq1.inside_supplier_code = tq.inside_supplier_code ';
      if kpi_category = '1' and kpi_group = '1' then
        v_dimension := ' ''全部'' area_group ,''全部'' category_name, td.supplier_code,supplier,' ||
                       v2_dimension || ' pid ,';
        v_group     := ' group by total_time,td.supplier_code,supplier,' ||
                       v2_dimension;
      elsif kpi_category = '1' and kpi_group <> '1' then
        v_dimension := 'group_name area_group ,''全部'' category_name, td.supplier_code, supplier,' ||
                       v2_dimension || ' pid ,';
        v_group     := ' group by total_time,group_name ,td.supplier_code,supplier,' ||
                       v2_dimension;
      elsif kpi_category <> '1' and kpi_group = '1' then
        v_dimension := '''全部'' area_group ,category_name, td.supplier_code, supplier,' ||
                       v2_dimension || ' pid ,';
        v_group     := ' group by total_time ,category_name,td.supplier_code,supplier,' ||
                       v2_dimension;
      else
        v_dimension := 'group_name area_group ,category_name,td. supplier_code,supplier,' ||
                       v2_dimension || ' pid ,';
        v_group     := ' group by total_time,group_name ,category_name,td.supplier_code,supplier,' ||
                       v2_dimension;
      end if;
    elsif kpi_dimension = '05' THEN
      --统计维度：生产工厂

      if kpi_group = '1' and kpi_category = '1' then
        v_c_i1 := ' and tp.factory_code = td.sort_dimension ';
      elsif kpi_group = '1' and kpi_category <> '1' then
        v_c_i1 := ' and tp.factory_code = td.sort_dimension 
                    and tp.category_id = td.category_id ';
      elsif kpi_group <> '1' and kpi_category = '1' then
        v_c_i1 := ' and tp.factory_code = td.sort_dimension
                    and tp.group_id = td.group_id ';
      elsif kpi_group <> '1' and kpi_category <> '1' then
        v_c_i1 := ' and tp.factory_code = td.sort_dimension
                    and tp.group_id = td.group_id 
                    and tp.category_id = td.category_id ';
      end if;

      v_c_where := ' and t.statistical_dimension = ''05'' ';
      v_c_i     := ' and tp.factory_code = td.sort_dimension ';
      v_sort    := ''' ''supplier_code, '' ''factory_company_name, ';
      --v_c_k        := 'tfac.supplier_code factory_code,  tfac.supplier_company_name factory_company_name, ';
      v_c_k := ' ,factory_code, factory_company_name  ';
      --v_c_g        := ' tfac.supplier_code,tfac.supplier_company_name, ';
      --v_b_g1 := ', tp.factory_code ';
      v_b1_g1 := ' ,tq.factory_code ';
      --v_b_g2 := ' and tq1.factory_code = tq.factory_code ';
      if kpi_category = '1' and kpi_group = '1' then
        v_dimension := ' ''全部'' area_group ,''全部'' category_name, td.factory_code supplier_code,factory_company_name,' ||
                       v2_dimension || ' pid ,';
        v_group     := ' group by total_time,td.factory_code,factory_company_name,' ||
                       v2_dimension;
      elsif kpi_category = '1' and kpi_group <> '1' then
        v_dimension := 'group_name area_group ,''全部'' category_name,td.factory_code supplier_code, factory_company_name,' ||
                       v2_dimension || ' pid ,';
        v_group     := ' group by total_time,group_name ,factory_company_name,td.factory_code,' ||
                       v2_dimension;
      elsif kpi_category <> '1' and kpi_group = '1' then
        v_dimension := '''全部'' area_group ,category_name,td.factory_code supplier_code, factory_company_name,' ||
                       v2_dimension || ' pid ,';
        v_group     := ' group by total_time ,category_name,td.factory_code,factory_company_name,' ||
                       v2_dimension;
      else
        v_dimension := 'group_name area_group ,category_name, td.factory_code supplier_code,factory_company_name,' ||
                       v2_dimension || ' pid ,';
        v_group     := ' group by total_time,group_name ,category_name,td.factory_code,factory_company_name,' ||
                       v2_dimension;
      end if;
    elsif kpi_dimension = '06' THEN
      --统计维度：跟单
      if kpi_group = '1' or kpi_category = '1' then
        v_c_i1 := ' and tp.statistical_dimension = ''06'' ';
      else
        v_c_i1 := ' and tp.statistical_dimension = ''06'' and tp.sort_dimension = td.sort_dimension ';
      end if;
    
      v_c_where := ' and t.statistical_dimension = ''06'' ';
      v_c_i     := ' and tp.statistical_dimension = ''06'' and tp.sort_dimension = td.sort_dimension ';
      v_sort    := ''' ''flw_order, ';
      --v_c_k        := 't.sort_dimension flw_id,  f1.company_user_name flw_order, ';
      v_c_k := ' ,flw_id,   flw_order ';
      --v_c_g        := '  f1.company_user_name, ';
      --v_b_g1 := '  ';
      --v_b_g2 := ' and tq1.factory_code = tq.factory_code ';
      if kpi_category = '1' and kpi_group = '1' then
        v_dimension := ' ''全部'' area_group ,''全部'' category_name, flw_order,' ||
                       v2_dimension || ' pid ,';
        v_group     := ' group by td.total_time,td.flw_order,td.statistical_dimension,td.sort_dimension,' ||
                       v2_dimension;
      elsif kpi_category = '1' and kpi_group <> '1' then
        v_dimension := 'group_name area_group ,''全部'' category_name,flw_order,' ||
                       v2_dimension || ' pid ,';
        v_group     := ' group by td.total_time,td.group_name ,td.flw_order,td.statistical_dimension,td.sort_dimension,' ||
                       v2_dimension;
      elsif kpi_category <> '1' and kpi_group = '1' then
        v_dimension := '''全部'' area_group ,category_name,flw_order,' ||
                       v2_dimension || ' pid ,';
        v_group     := ' group by td.total_time,td.category_name,td.flw_order,td.statistical_dimension,td.sort_dimension,' ||
                       v2_dimension;
      else
        v_dimension := 'group_name area_group ,category_name, flw_order,' ||
                       v2_dimension || ' pid ,';
        v_group     := ' group by td.total_time,td.group_name ,td.category_name,td.flw_order,td.statistical_dimension,td.sort_dimension,' ||
                       v2_dimension;
      end if;
    elsif kpi_dimension = '07' THEN
      --统计维度：跟单主管
      if kpi_group = '1' or kpi_category = '1' then
        v_c_i1 := ' and tp.statistical_dimension = ''07'' ';
      else
        v_c_i1 := ' and tp.statistical_dimension = ''07'' and tp.sort_dimension = td.sort_dimension ';
      end if;
    
      v_c_where := ' and t.statistical_dimension = ''07'' ';
      v_c_i     := ' and tp.statistical_dimension = ''07'' and tp.sort_dimension = td.sort_dimension ';
      v_sort    := ''' ''flw_leader, ';
      --v_c_k        := 't.sort_dimension flw_leader_id,  f2.company_user_name flw_leader, ';
      v_c_k := ' ,flw_leader_id,   flw_leader ';
      -- v_c_g        := '  f2.company_user_name, ';
      if kpi_category = '1' and kpi_group = '1' then
        v_dimension := ' ''全部'' area_group ,''全部'' category_name, flw_leader,' ||
                       v2_dimension || ' pid ,';
        v_group     := ' group by td.total_time,td.flw_leader,td.statistical_dimension,td.sort_dimension,' ||
                       v2_dimension;
      elsif kpi_category = '1' and kpi_group <> '1' then
        v_dimension := 'group_name area_group ,''全部'' category_name,flw_leader,' ||
                       v2_dimension || ' pid ,';
        v_group     := ' group by td.total_time,td.group_name ,td.flw_leader,td.statistical_dimension,td.sort_dimension,' ||
                       v2_dimension;
      elsif kpi_category <> '1' and kpi_group = '1' then
        v_dimension := '''全部'' area_group ,category_name,flw_leader,' ||
                       v2_dimension || ' pid ,';
        v_group     := ' group by td.total_time,td.category_name,td.flw_leader,td.statistical_dimension,td.sort_dimension,' ||
                       v2_dimension;
      else
        v_dimension := 'group_name area_group ,category_name, flw_leader,' ||
                       v2_dimension || ' pid ,';
        v_group     := ' group by td.total_time,td.group_name ,td.category_name,td.flw_leader,td.statistical_dimension,td.sort_dimension,' ||
                       v2_dimension;
      end if;
    elsif kpi_dimension = '08' THEN
      --统计维度：QC
      if kpi_group = '1' or kpi_category = '1' then
        v_c_i1 := ' and tp.statistical_dimension = ''08'' ';
      else
        v_c_i1 := ' and tp.statistical_dimension = ''08'' and tp.sort_dimension = td.sort_dimension ';
      end if;
    
      v_c_where := ' and t.statistical_dimension = ''08'' ';
      v_c_i     := ' and tp.statistical_dimension = ''08'' and tp.sort_dimension = td.sort_dimension ';
      v_sort    := ''' ''qc, ';
      --v_c_k        := 't.sort_dimension qc_id,  q.company_user_name qc, ';
      v_c_k := ' ,qc_id, qc ';
      --v_c_g        := '  q.company_user_name, ';
      if kpi_category = '1' and kpi_group = '1' then
        v_dimension := ' ''全部'' area_group ,''全部'' category_name, qc,' ||
                       v2_dimension || ' pid ,';
        v_group     := ' group by td.total_time,td.qc,td.statistical_dimension,td.sort_dimension,' ||
                       v2_dimension;
      elsif kpi_category = '1' and kpi_group <> '1' then
        v_dimension := 'group_name area_group ,''全部'' category_name,qc,' ||
                       v2_dimension || ' pid ,';
        v_group     := ' group by td.total_time,td.group_name ,td.qc,td.statistical_dimension,td.sort_dimension,' ||
                       v2_dimension;
      elsif kpi_category <> '1' and kpi_group = '1' then
        v_dimension := '''全部'' area_group ,category_name,qc,' ||
                       v2_dimension || ' pid ,';
        v_group     := ' group by td.total_time,td.category_name,td.qc,td.statistical_dimension,td.sort_dimension,' ||
                       v2_dimension;
      else
        v_dimension := 'group_name area_group ,category_name, qc,' ||
                       v2_dimension || ' pid ,';
        v_group     := ' group by td.total_time,td.group_name ,td.category_name,qc,td.statistical_dimension,td.sort_dimension,' ||
                       v2_dimension;
      end if;
    elsif kpi_dimension = '09' THEN
      --统计维度：qc主管
      if kpi_group = '1' or kpi_category = '1' then
        v_c_i1 := ' and tp.statistical_dimension = ''09'' ';
      else
        v_c_i1 := ' and tp.statistical_dimension = ''09'' and tp.sort_dimension = td.sort_dimension ';
      end if;
    
      v_c_where := ' and t.statistical_dimension = ''09'' ';
      v_c_i     := ' and tp.statistical_dimension = ''09'' and tp.sort_dimension = td.sort_dimension ';
      v_sort    := ''' ''qc_leader, ';
      -- v_c_k        := 't.sort_dimension qc_leader_id,  q2.company_user_name qc_leader, ';
      v_c_k := ' ,qc_leader_id, qc_leader ';
      -- v_c_g        := '  q2.company_user_name, ';
      if kpi_category = '1' and kpi_group = '1' then
        v_dimension := ' ''全部'' area_group ,''全部'' category_name, qc_leader,' ||
                       v2_dimension || ' pid ,';
        v_group     := ' group by td.total_time,td.qc_leader,td.statistical_dimension,td.sort_dimension,' ||
                       v2_dimension;
      elsif kpi_category = '1' and kpi_group <> '1' then
        v_dimension := 'group_name area_group ,''全部'' category_name,qc_leader,' ||
                       v2_dimension || ' pid ,';
        v_group     := ' group by td.total_time,td.group_name ,td.qc_leader,td.statistical_dimension,td.sort_dimension,' ||
                       v2_dimension;
      elsif kpi_category <> '1' and kpi_group = '1' then
        v_dimension := '''全部'' area_group ,category_name,qc_leader,' ||
                       v2_dimension || ' pid ,';
        v_group     := ' group by td.total_time,td.category_name,td.qc_leader,td.statistical_dimension,td.sort_dimension,' ||
                       v2_dimension;
      else
        v_dimension := 'group_name area_group ,category_name, qc_leader,' ||
                       v2_dimension || ' pid ,';
        v_group     := ' group by td.total_time,td.group_name ,td.category_name,td.qc_leader,td.statistical_dimension,td.sort_dimension,' ||
                       v2_dimension;
      end if;
    end if;
  
    v1_where := ' where td.company_id = ''' || COMPANY_ID || ''' ' ||
                scmdata.pkg_qa_report.F_GET_DATAPRIVS_SQL(p_class_data_privs => P_CLASS_DATA_PRIVS,
                                                          p_pre              => 'td');
    --过滤条件：分部
    CASE
      WHEN KPI_CATEGORY = '1' THEN
        v1_where := v1_where || ' AND 1 = 1 ';
        v1_b     := ' and  1 = 1 ';
        v1_a     := ' and  1 = 1 ';      
      ELSE
        v1_where := v1_where || ' AND td.category_id = ''' || KPI_CATEGORY ||
                    ''' ';
        v1_b     := ' and  t.category_id  =  ''' || KPI_CATEGORY || ''' ';
        v1_a     := ' and  tq.category_id  =  ''' || KPI_CATEGORY || ''' ';     
    END CASE;
    --过滤条件：区域组
    CASE
      WHEN KPI_GROUP = '1' THEN
        v1_where := v1_where || ' AND 1 = 1 ';
        v1_b     := v1_b || ' and  1 = 1 ';
        v1_a     := v1_a || ' and  1 = 1 ';
      ELSE
        v1_where := v1_where || ' AND td.group_id = ''' || KPI_GROUP ||
                    ''' ';
        v1_b     := v1_b || ' and  t.group_id  =  ''' || KPI_GROUP || ''' ';
        v1_a     := v1_a || ' and  tq.group_name  =  ''' || KPI_GROUP ||''' ';
    END CASE;

       if KPI_GROUP <> '1' and KPI_CATEGORY <> '1' then 
          v2_b := ',tq.group_name,tq.category_id';
        elsif KPI_GROUP <> '1' and KPI_CATEGORY = '1' then
          v2_b := ',tq.group_name';
        elsif KPI_GROUP = '1' and KPI_CATEGORY <> '1' then 
          v2_b := ',tq.category_id';
       end if;      

     if kpi_dimension  in ('06','07','08','09') then
       if KPI_GROUP <> '1' and KPI_CATEGORY <> '1' then 
       v3_b := ' where tq.statistical_dimension =''' || kpi_dimension || '''
                   and tq.category_id = ''' || KPI_CATEGORY || '''
                   and tq.group_name = ''' || KPI_GROUP || '''  ';
        elsif KPI_GROUP <> '1' and KPI_CATEGORY = '1' then
       v3_b := ' where tq.statistical_dimension =''' || kpi_dimension || '''
                   and tq.group_name = ''' || KPI_GROUP || '''  ';
        elsif KPI_GROUP = '1' and KPI_CATEGORY <> '1' then 
       v3_b := ' where tq.statistical_dimension =''' || kpi_dimension || '''
                   and tq.category_id = ''' || KPI_CATEGORY || ''' ';
        elsif  KPI_GROUP = '1' and KPI_CATEGORY = '1' then 
       v3_b := ' where tq.statistical_dimension =''' || kpi_dimension || '''';
       end if;        
     end if;

    ---汇总字段条件
    if K_TIME = '本月' then
      K_TIME := to_char(sysdate, 'yyyy-mm');
    end if;
    --时间维度
    IF KPI_TIMETYPE = '本月' then
      v_z      := q'[ to_char(t.purchase_time,'yyyy-mm') total_time2 , to_char(t.purchase_time,'yyyy-mm') total_time, ]';
      v1_where := v1_where ||
                  ' and td.year || ''-'' || lpad(td.month,2,0) = ''' ||
                  K_TIME || '''';
      --v_b_s    := q'[ on tq1.year = tq.year  and  tq1.month = tq.month ]';
      --v_b_g     := q'[  ]';
      --v_c       := q'[ to_char(t.purchase_time,'yyyy')year, to_char(t.purchase_time,'mm')month , ]';
      v_c       := q'[ tq.year, tq.month  ]';
      v_c1       := q'[ t1.year, t1.month  ]';
      v_c_group := q'[ group by  t.year, t.month ,  to_char(t.purchase_time,'yyyy-mm'),]';
      v_c_w     := '  and tp.year = td.year  and tp.month = td.month  ';
    elsif KPI_TIMETYPE = '月度' then
      v_z      := q'[ t.year || '年' || lpad(t.month, 2, 0) ||'月'  total_time ,]';
      v1_where := v1_where ||
                  ' and td.year || ''年'' || lpad(td.month,2,0) || ''月'' = ''' ||
                  kpi_time || '''';
      --v_b_s    := q'[ on tq1.year = tq.year  and  tq1.month = tq.month ]';
      --v_c       := q'[ to_char(t.purchase_time,'yyyy')year, to_char(t.purchase_time,'mm') month, ]';
      v_c       := q'[ tq.year, tq.month ]';
      v_c1       := q'[ t1.year, t1.month ]';
      v_c_group := q'[ group by  t.year, t.month , ]';
      v_c_w     := '  and tp.year = td.year  and tp.month = td.month  ';
    elsif KPI_TIMETYPE = '季度' then
      v_z      := q'[ t.year || '年第' || t.quarter ||'季度'  total_time ,]';
      v1_where := v1_where || ' and td.total_time = ''' || kpi_time || '''';
      --v_b_s    := q'[ on tq1.year = tq.year  and  tq1.quarter = tq.quarter ]';
      -- v_c       := q'[ to_char(t.purchase_time,'yyyy')year , to_char(t.purchase_time,'Q')quarter , ]';
      v_c       := q'[ tq.year , tq.quarter  ]';
      v_c1       := q'[ t1.year, t1.quarter ]';
      v_c_group := q'[ group by  t.year, t.quarter , ]';
      v_c_w     := '    and tp.year = td.year  and tp.quarter = td.quarter  ';
    elsif KPI_TIMETYPE = '半年度' then
      v_z      := q'[ t.year || '年' || decode(t.halfyear,1,'上',2,'下') ||'半年'  total_time ,]';
      v1_where := v1_where || ' and td.total_time = ''' || kpi_time || '''';
     -- v_b_s    := q'[ on tq1.year = tq.year  and  tq1.halfyear = tq.halfyear ]';
      ---v_c       := q'[ to_char(t.purchase_time,'yyyy')year,decode(to_char(t.purchase_time,'Q'),1,1,2,1,3,2,4,2) halfyear, ]';
      v_c       := q'[ tq.year, tq.halfyear ]';
      v_c1       := q'[ t1.year, t1.halfyear ]';
      v_c_group := q'[ group by  t.year, decode(t.halfyear,1,'上',2,'下'),t.halfyear , ]';
      v_c_w     := '  and tp.year = td.year  and tp.halfyear = td.halfyear  ';
    
    elsif KPI_TIMETYPE = '年度' then
      v_z      := q'[ t.year || '年'  total_time ,]';
      v1_where := v1_where || ' and td.year || ''年'' = ''' || kpi_time || '''';
     -- v_b_s    := q'[ on tq1.year = tq.year  ]';
      --v_c       := q'[ to_char(t.purchase_time,'yyyy') year, ]';
      v_c       := q'[ tq.year ]';
      v_c1       := q'[ t1.year ]';
      v_c_group := q'[ group by  t.year,]';
      v_c_w     := '  and tp.year = td.year ';
    
    end if;
    ----汇总1 分子
    v_h1 := q'[ 
left join ( select tq.company_id,
       tq.year,
       tq.month,
       tq.quarter,
       tq.halfyear,
       tq.category_id,
       tq.group_name group_id,
       tq.style_name,
       tq.product_cate,
       tq.samll_category,
       tq.supplier_code,tq.inside_supplier_code ,
       tq.factory_code,
       --tq1.qualdecrease_money 
       sum(tq.qualdecrease_money) over ( partition by ]'|| v_c ||v2_b || q'[ )qualdecrease_money
  from scmdata.t_qa_warehouse_inspect_failed tq
  where tq.qc is not null ]'|| v1_a ||q'[
) tp 
    on td.company_id = tp.company_id ]' || v_c_w || v_c_i1;
  
    ---非跟单、跟单主管、qc、qc主管 
    v1_sql := q'[ 
left join ( select tq.company_id,
       tq.year,
       tq.month,
       tq.quarter,
       tq.halfyear,
       tq.category_id,
       (case when tq.group_name is null then '1' else tq.group_name end) group_id,
       tq.style_name,
       tq.product_cate,
       tq.samll_category,
       tq.supplier_code,tq.inside_supplier_code ,
       tq.factory_code,
       sum(tq.qualdecrease_money) over ( partition by ]'|| v_c||v_b1_g1 ||v2_b || q'[ ) qualdecrease_money
  from scmdata.t_qa_warehouse_inspect_failed tq
  where tq.qc is not null ]'|| v1_a ||q'[
) tp 
    on td.company_id = tp.company_id ]' || v_c_w || v_c_i;
  
    --汇总  分子  跟单、跟单主管、qc、qc主管 
    v3_sql := q'[ 
left join (select tq.company_id,
       tq.year,
       tq.month,
       tq.quarter,
       tq.halfyear,
       tq.category_id,
       tq.group_name group_id,
       tq.statistical_dimension,
       tq.sort_dimension,
       sum(tq.qualdecrease_money) over ( partition by ]'|| v_c ||v2_b || q'[ ,tq.statistical_dimension) qualdecrease_money
  from scmdata.t_qa_inspect_failed_flw_qc tq  ]'|| v3_b || q'[
 ) tp 
    on td.company_id = tp.company_id ]' || v_c_w || v_c_i1;
  
    --跟单、跟单主管、qc、qc主管 
    v2_sql := q'[ 
left join (select tq.company_id,
       tq.year,
       tq.month,
       tq.quarter,
       tq.halfyear,
       tq.category_id,
       (case when tq.group_name is null then '1' else tq.group_name end) group_id,
       tq.statistical_dimension,
       tq.sort_dimension,
       sum(tq.qualdecrease_money) over ( partition by ]'|| v_c ||v2_b || q'[ ,tq.statistical_dimension,tq.sort_dimension) qualdecrease_money
  from scmdata.t_qa_inspect_failed_flw_qc tq  ]'|| v3_b || q'[
 ) tp 
    on td.company_id = tp.company_id ]' || v_c_w || v_c_i;
  
    v_c_sql := ' select distinct t1.company_id,t1.total_time, t1.category_id,t1.category_name,t1.group_id,t1.group_name,' || v_c1 ||
               v_c_k ||
               ' ,t1.statistical_dimension,t1.sort_dimension,t2.purchase_money from  ( select t.company_id, ' || v_z ||
               q'[ t.year,
               t.month,
               t.quarter,
               t.halfyear, 
               t.sort_dimension style_name,
               t.sort_dimension small_category_gd,
               samll.cate_category cate_category_name,
               samll.samll_category samll_category_name,
               tsup.supplier_code,
               tsup.supplier_company_name supplier,
               tfac.supplier_code factory_code,
               tfac.supplier_company_name factory_company_name,
               t.sort_dimension flw_id,
               f1.company_user_name flw_order,
               t.sort_dimension flw_leader_id,
               f2.company_user_name flw_leader,
               t.sort_dimension qc_id,
               q.company_user_name qc,
               t.sort_dimension qc_leader_id,
               q2.company_user_name qc_leader,
               c.group_dict_name category_name,
               t.category_id,
               ts.group_name,
               t.group_id,
               t.statistical_dimension,
               t.sort_dimension,
               t.purchase_money
        from scmdata.t_qa_ingood t
        left join scmdata.sys_group_dict c
          on c.group_dict_type = 'PRODUCT_TYPE'
         and c.group_dict_value = t.category_id 
        left join scmdata.t_supplier_group_config ts
          on ts.group_config_id = t.group_id 
        left join (select distinct c.group_dict_value,
                                  c1.group_dict_name    cate_category,
                                  cd.company_dict_value,
                                  cd.company_dict_name  samll_category
                    from scmdata.sys_group_dict c
                   inner join scmdata.sys_group_dict c1
                      on c1.group_dict_type = c.group_dict_value
                   inner join scmdata.sys_company_dict cd
                      on cd.company_dict_type = c1.group_dict_value
                     and cd.company_id = ']' || COMPANY_ID || q'['
                   where c.group_dict_type = 'PRODUCT_TYPE') samll
          on samll.company_dict_value = t.sort_dimension
         and t.statistical_dimension = '03'
        left join scmdata.t_supplier_info tsup
          on tsup.company_id = t.company_id
         and tsup.inside_supplier_code = t.sort_dimension
         and t.statistical_dimension = '04'
        left join scmdata.t_supplier_info tfac
          on tfac.company_id = t.company_id
         and tfac.supplier_code = t.sort_dimension
         and t.statistical_dimension = '05'
        left join scmdata.sys_company_user f1
          on f1.company_id = t.company_id
         and f1.user_id = t.sort_dimension
         and t.statistical_dimension = '06'
        left join scmdata.sys_company_user f2
          on f2.company_id = t.company_id
         and f2.user_id = t.sort_dimension
         and t.statistical_dimension = '07'
        left join scmdata.sys_company_user q
          on q.company_id = t.company_id
         and q.user_id = t.sort_dimension
         and t.statistical_dimension = '08'
        left join scmdata.sys_company_user q2 
          on q2.company_id = t.company_id
         and q2.user_id = t.sort_dimension
         and t.statistical_dimension = '09'
       where t.company_id = ']' || COMPANY_ID || '''' ||
               v_c_where;
  
    v_h2 := ' )t1  inner join (select ' || v_z || q'[
                    t.statistical_dimension,
                    t.sort_dimension,
                    sum(purchase_money) purchase_money
               from scmdata.t_qa_ingood t  where t.company_id = ']' ||
            COMPANY_ID || '''' || v1_b || v_c_where || v_c_group || q'[
                       statistical_dimension, sort_dimension) t2
    on t1.total_time = t2.total_time
   and t1.sort_dimension = t2.sort_dimension
   and t1.statistical_dimension = t2.statistical_dimension ) td ]';
    ---汇总 分母
    v_h3 := ' )t1  inner join (select ' || v_z || q'[
                    t.statistical_dimension,
                    sum(purchase_money) purchase_money
               from scmdata.t_qa_ingood t  where t.company_id = ']' ||
            COMPANY_ID || '''' || v1_b || v_c_where || v_c_group || q'[
                       statistical_dimension) t2
    on t1.total_time = t2.total_time
   and t1.statistical_dimension = t2.statistical_dimension ) td ]';
  
    v_group := v_group || ' , td.sort_dimension  
order by td.sort_dimension )';
  
    ---判断是否为跟单、跟单主管、qc、qc主管维度
    if kpi_dimension in ('06', '07', '08', '09') then
      vc1_sql := 'select total_time,' || v_dimension ||
                 ' (case when max(nvl(qualdecrease_money, 0)) = 0 then 0 else  max(nvl(qualdecrease_money, 0))/ max(nvl(purchase_money, 0)) end) purchase_rate from (' ||
                 v_c_sql || v_h2 || v2_sql || v1_where || v_group;
      ---汇总语句
      vc_sql2 := q'[select '汇总' total_time,
     ' ' area_group,
     ' ' category_name,]' || v_sort || '''' || v1_dimension ||
                 ''' pid, ' ||
                 q'[ (case when max(nvl(qualdecrease_money, 0)) = 0 then 0 else  max(nvl(qualdecrease_money, 0))/ max(nvl(purchase_money, 0)) end) purchase_rate from ( ]' ||
                 v_c_sql || v_h3 || v3_sql || v1_where;
    else
      vc1_sql := 'select total_time,' || v_dimension ||
                 ' (case when max(nvl(qualdecrease_money, 0)) = 0 then 0 else  max(nvl(qualdecrease_money, 0))/ max(nvl(purchase_money, 0)) end) purchase_rate from (' ||
                 v_c_sql || v_h2 || v1_sql || v1_where || v_group;
      ---汇总语句
      vc_sql2 := q'[select '汇总' total_time,
     ' ' area_group,
     ' ' category_name,]' || v_sort || '''' || v1_dimension ||
                 ''' pid, ' ||
                 q'[ (case when max(nvl(qualdecrease_money, 0)) = 0 then 0 else  max(nvl(qualdecrease_money, 0))/ max(nvl(purchase_money, 0)) end) purchase_rate from ( ]' ||
                 v_c_sql || v_h3 || v_h1 || v1_where;
    end if;
    v_sql := vc_sql2 || ' union all select * from ( ' || vc1_sql;
  
    RETURN v_sql;
  
  END F_KPI_180_SELECTSQL;

  FUNCTION F_KPI_181_CAPTIONSQL(V_STRING VARCHAR2, V_ID VARCHAR2) RETURN CLOB IS
    v_group     varchar2(64);
    v1_group    varchar2(64);
    v_category  varchar2(32);
    v1_category varchar2(32);
    v_dimension varchar2(32);
    v_sort      varchar2(128);
    v1_sort     varchar2(128);
    v_sql       clob; --返回值
  begin
    v_group     := scmdata.parse_json(v_string, 'COL_2');
    v_category  := scmdata.parse_json(v_string, 'COL_3');
    v_dimension := scmdata.parse_json(v_string, 'COL_4');
    v_sort      := scmdata.parse_json(v_string, 'COL_5');
    if v_sort is null then
      if v_category = '1' then
        v1_category := '全部';
      else
        select max(t.group_dict_name)
          into v1_category
          from scmdata.sys_group_dict t
         where t.group_dict_type = 'PRODUCT_TYPE'
           and t.group_dict_value = v_category;
      end if;
      if v_group = '1' then
        v1_group := '全部';
      else
        select max(ts.group_name)
          into v1_group
          from scmdata.t_supplier_group_config ts
         where ts.group_config_id = v_group;
      end if;
    else
      if v_dimension = '01' then
        if v_group = '1' then
          v1_group := '全部';
        else
          select max(ts.group_name)
            into v1_group
            from scmdata.t_supplier_group_config ts
           where ts.group_config_id = v_group;
        end if;
        if v_sort = '1' then
          v1_category := '全部';
        else
          select max(t.group_dict_name)
            into v1_category
            from scmdata.sys_group_dict t
           where t.group_dict_type = 'PRODUCT_TYPE'
             and t.group_dict_value = v_sort;
        end if;
      elsif v_dimension = '00' then
        if v_category = '1' then
          v1_category := '全部';
        else
          select max(t.group_dict_name)
            into v1_category
            from scmdata.sys_group_dict t
           where t.group_dict_type = 'PRODUCT_TYPE'
             and t.group_dict_value = v_category;
        end if;
        if v_sort = '1' then
          v1_group := '全部';
        else
          select max(ts.group_name)
            into v1_group
            from scmdata.t_supplier_group_config ts
           where ts.group_config_id = v_sort;
        end if;
      elsif v_dimension not in ('00', '01') then
        if v_category = '1' then
          v1_category := '全部';
        else
          select max(t.group_dict_name)
            into v1_category
            from scmdata.sys_group_dict t
           where t.group_dict_type = 'PRODUCT_TYPE'
             and t.group_dict_value = v_category;
        end if;
        if v_group = '1' then
          v1_group := '全部';
        else
          select max(ts.group_name)
            into v1_group
            from scmdata.t_supplier_group_config ts
           where ts.group_config_id = v_group;
        end if;
      end if;
    end if;
    if v_dimension = '02' then
      --统计维度：款式名称
      v1_sort := v_sort;
    elsif v_dimension = '03' then
      --统计维度：产品子类
      select max(cd.company_dict_name) samll_category
        into v1_sort
        from scmdata.sys_group_dict c
       inner join scmdata.sys_group_dict c1
          on c1.group_dict_type = c.group_dict_value
       inner join scmdata.sys_company_dict cd
          on cd.company_dict_type = c1.group_dict_value
         and cd.company_id = v_id
       where c.group_dict_type = 'PRODUCT_TYPE'
         and cd.company_dict_value = v_sort;
    elsif v_dimension = '04' then
      --统计维度：供应商
      select max(t.supplier_company_abbreviation)
        into v1_sort
        from scmdata.t_supplier_info t
       where t.inside_supplier_code = v_sort
         and t.company_id = v_id;
    elsif v_dimension = '05' then
      --统计维度：生产工厂
      select max(t.supplier_company_abbreviation)
        into v1_sort
        from scmdata.t_supplier_info t
       where t.supplier_code = v_sort
         and t.company_id = v_id;
    elsif v_dimension in ('06', '07', '08', '09') then
      --统计维度：跟单/QC/QC主管
      select max(f.company_user_name)
        into v1_sort
        from scmdata.sys_company_user f
       where f.user_id = v_sort
         and f.company_id = v_id;
    end if;
    if v_sort is null then
      if v_group = '1' and v_category = '1' then
        v_sql := 'select ''' || ' 仓检不合格率趋势图'' from dual';
      elsif v_group = '1' and v_category <> '1' then
        v_sql := 'select ''' || v1_category || ' 仓检不合格率趋势图'' from dual';
      elsif v_group <> '1' and v_category = '1' then
        v_sql := 'select ''' || v1_group || ' 仓检不合格率趋势图'' from dual';
      elsif v_group <> '1' and v_category <> '1' then
        v_sql := 'select ''' || v1_group || ',' || v1_category ||
                 ' 仓检不合格率趋势图'' from dual';
      end if;
    elsif v1_sort is null and v_dimension = '06' then
      if v_group = '1' and v_category = '1' then
        v_sql := 'select ''' || ' 跟单为空 仓检不合格率趋势图'' from dual';
      elsif v_group = '1' and v_category <> '1' then
        v_sql := 'select ''' || v1_category ||
                 ' 跟单为空 仓检不合格率趋势图'' from dual';
      elsif v_group <> '1' and v_category = '1' then
        v_sql := 'select ''' || v1_group || ' 跟单为空 仓检不合格率趋势图'' from dual';
      elsif v_group <> '1' and v_category <> '1' then
        v_sql := 'select ''' || v1_group || ',' || v1_category ||
                 ' 跟单为空 仓检不合格率趋势图'' from dual';
      end if;
    elsif v1_sort is null and v_dimension = '07' then
      if v_group = '1' and v_category = '1' then
        v_sql := 'select ''' || ' 跟单主管为空 仓检不合格率趋势图'' from dual';
      elsif v_group = '1' and v_category <> '1' then
        v_sql := 'select ''' || v1_category ||
                 ' 跟单主管为空 仓检不合格率趋势图'' from dual';
      elsif v_group <> '1' and v_category = '1' then
        v_sql := 'select ''' || v1_group || ' 跟单主管为空 仓检不合格率趋势图'' from dual';
      elsif v_group <> '1' and v_category <> '1' then
        v_sql := 'select ''' || v1_group || ',' || v1_category ||
                 ' 跟单主管为空 仓检不合格率趋势图'' from dual';
      end if;
    elsif v1_sort is null and v_dimension = '08' then
      if v_group = '1' and v_category = '1' then
        v_sql := 'select ''' || ' QC为空 仓检不合格率趋势图'' from dual';
      elsif v_group = '1' and v_category <> '1' then
        v_sql := 'select ''' || v1_category ||
                 ' QC为空 仓检不合格率趋势图'' from dual';
      elsif v_group <> '1' and v_category = '1' then
        v_sql := 'select ''' || v1_group || ' QC为空 仓检不合格率趋势图'' from dual';
      elsif v_group <> '1' and v_category <> '1' then
        v_sql := 'select ''' || v1_group || ',' || v1_category ||
                 ' QC为空 仓检不合格率趋势图'' from dual';
      end if;
    elsif v1_sort is null and v_dimension = '09' then
      if v_group = '1' and v_category = '1' then
        v_sql := 'select ''' || ' QC主管为空 仓检不合格率趋势图'' from dual';
      elsif v_group = '1' and v_category <> '1' then
        v_sql := 'select ''' || v1_category ||
                 ' QC主管为空 仓检不合格率趋势图'' from dual';
      elsif v_group <> '1' and v_category = '1' then
        v_sql := 'select ''' || v1_group || ' QC主管为空 仓检不合格率趋势图'' from dual';
      elsif v_group <> '1' and v_category <> '1' then
        v_sql := 'select ''' || v1_group || ',' || v1_category ||
                 ' QC主管为空 仓检不合格率趋势图'' from dual';
      end if;
    elsif v_dimension = '01' then
      if v_group = '1' then
        v_sql := 'select ''' || v1_category || ' 仓检不合格率趋势图'' from dual';
      else
        v_sql := 'select ''' || v1_group || ',' || v1_category ||
                 ' 仓检不合格率趋势图'' from dual';
      end if;
    elsif v_dimension = '00' then
      if v_category = '1' then
        v_sql := 'select ''' || v1_group || ' 仓检不合格率趋势图'' from dual';
      else
        v_sql := 'select ''' || v1_group || ',' || v1_category ||
                 ' 仓检不合格率趋势图'' from dual';
      end if;
    else
      if v_group = '1' and v_category = '1' then
        v_sql := 'select ''' || v1_sort || ' 仓检不合格率趋势图'' from dual';
      elsif v_group = '1' and v_category <> '1' then
        v_sql := 'select ''' || v1_category || ',' || v1_sort ||
                 ' 仓检不合格率趋势图'' from dual';
      elsif v_group <> '1' and v_category = '1' then
        v_sql := 'select ''' || v1_group || ',' || v1_sort ||
                 ' 仓检不合格率趋势图'' from dual';
      elsif v_group <> '1' and v_category <> '1' then
        v_sql := 'select ''' || v1_group || ',' || v1_category || ',' ||
                 v1_sort || ' 仓检不合格率趋势图'' from dual';
      end if;
    end if;
    return v_sql;
  end f_kpi_181_captionsql;

  FUNCTION F_KPI_181_SELECTSQL(V_TIME       VARCHAR2,
                               V_DIMENSION  VARCHAR2,
                               V_SORT       VARCHAR2,
                               V_GROUP      VARCHAR2,
                               V_CATEGORY   VARCHAR2,
                               V_COMPANY_ID VARCHAR2) RETURN CLOB IS
    vc1_sql    CLOB;
    v_c_sql    CLOB;
    v1_sql     CLOB;
    v2_sql     CLOB;
    v_c_sql_a  CLOB;
    v1_sql_a   CLOB;
    v2_sql_a   CLOB;
    V_WHERE    CLOB;
    V1_TIME    VARCHAR2(128);
    V_S        VARCHAR2(1280);
    V_S1       VARCHAR2(1280);
    V_S2       VARCHAR2(1280);
    V_S3       VARCHAR2(1280);
    --V_S4       VARCHAR2(1280);
    --v1_b       VARCHAR2(1280);
    v2_b       VARCHAR2(1280);
    v3_b       VARCHAR2(1280);
    v4_b      VARCHAR2(1280);
    v_b_g1     VARCHAR2(1280);
    v1_a    VARCHAR2(1280);
    --v_b_g2     VARCHAR2(1280);
    V_C        CLOB;
    V_MAX_DATE VARCHAR2(32);
    V_MIN_DATE VARCHAR2(32);
    v_c_where  VARCHAR2(1000);
    v_c_i      VARCHAR2(1280);
    v_c_i1     VARCHAR2(1280);
    v_c_group  varchar2(1280);
    v_c_w      VARCHAR2(128);
  BEGIN
    V_WHERE := ' where td.company_id = ''' || V_COMPANY_ID || '''';
    --过滤条件：分部
    CASE
      WHEN V_CATEGORY = '1' THEN
        V_WHERE := V_WHERE || ' and 1 = 1 ';
        v1_a    := ' and 1 = 1 ';
        v2_b    := ' and 1 = 1 ';
      ELSE
        V_WHERE := V_WHERE || ' and td.category_id = ''' || V_CATEGORY ||
                   ''' ';
        v1_a    := ' and tq.category_id  =  ''' || V_CATEGORY || ''' ';
        v2_b    := ' and category_id  =  ''' || V_CATEGORY || ''' ';
    END CASE;
    --过滤条件：区域组
    CASE
      WHEN V_GROUP = '1' THEN
        V_WHERE := V_WHERE || ' and 1 = 1 ';
       v1_a   := v1_a || ' and 1 = 1 ';
        v2_b    := v2_b || ' and 1 = 1 ';
      ELSE
        V_WHERE := V_WHERE || ' and td.group_id = ''' || V_GROUP || ''' ';
        v1_a    := v1_a || ' and tq.group_name  =  ''' || V_GROUP || ''' ';
        v2_b    := v2_b || ' and group_id  =  ''' || V_GROUP || ''' ';
    END CASE;
  
    --统计维度
    if V_DIMENSION = '00' THEN
      --统计维度：区域组
      v_c_where := ' and t.statistical_dimension = ''00'' ';
      v_c_i     := ' and tp.group_id = td.sort_dimension ';
      IF V_SORT IS NULL THEN
        V_WHERE := V_WHERE;
        --v1_b    := v1_b || ' and 1  =  1 ';
      ELSE
        V_WHERE := V_WHERE || ' and td.group_id = ''' || V_SORT || '''';
        --v1_b    := v1_b || ' and group_name  =  ''' || V_SORT || ''' ';
        --  v_c_where := v_c_where || ' and t.sort_dimension = ''' || V_SORT || '''';
        v_b_g1 := ' ,tq.group_name ';
        --v_b_g2 := ' and tq1.group_name = tq.group_name ';
      END IF;
      if v_group = '1' and v_category = '1' then
        v_c_i1 := ' ';
      elsif  v_group = '1' and v_category <> '1' then
        v_c_i1 := ' and tp.category_id = td.category_id ';
      elsif  v_group <> '1' and v_category = '1' then
        v_c_i1 := ' and tp.group_id = td.sort_dimension ';
      elsif  v_group <> '1' and v_category <> '1' then
        v_c_i1 := ' and tp.group_id = td.sort_dimension
                    and tp.category_id = td.category_id ';
      end if;
    elsif V_DIMENSION = '01' THEN
      --统计维度：分类
      v_c_where := ' and t.statistical_dimension = ''01'' ';
      v_c_i     := ' and tp.category_id = td.sort_dimension ';
      IF V_SORT IS NULL THEN
        V_WHERE := V_WHERE;
       -- v1_b    := v1_b || ' and 1  =  1 ';
      ELSE
        V_WHERE := V_WHERE || ' and td.category_id = ''' || V_SORT || '''';
        -- v_c_where := v_c_where || ' and t.sort_dimension = ''' || V_SORT || '''';
       -- v1_b   := v1_b || ' and category_id  =  ''' || V_SORT || ''' ';
        v_b_g1 := ' ,tq.category_id ';
        --v_b_g2 := ' and tq1.category_id = tq.category_id ';
      END IF;
      if v_group = '1' and v_category = '1' then
        v_c_i1 := ' ';
      elsif  v_group = '1' and v_category <> '1' then
        v_c_i1 := ' and tp.category_id = td.sort_dimension ';
      elsif  v_group <> '1' and v_category = '1' then
        v_c_i1 := ' and tp.group_id = td.group_id ';
      elsif  v_group <> '1' and v_category <> '1' then
        v_c_i1 := ' and tp.group_id = td.group_id
                    and tp.category_id = td.sort_dimension ';
      end if;

    elsif V_DIMENSION = '02' THEN
      --统计维度：款式名称
      v_c_where := ' and t.statistical_dimension = ''02'' ';
      v_c_i     := ' and tp.style_name = td.sort_dimension ';
      IF V_SORT IS NULL THEN
        V_WHERE := V_WHERE;
        --v1_b    := v1_b || ' and 1  =  1 ';
      ELSE
        V_WHERE := V_WHERE || ' and td.sort_dimension = ''' || V_SORT || '''';
        --  v_c_where := v_c_where || ' and t.sort_dimension = ''' || V_SORT || '''';
        v_b_g1 := ' ,tq.style_name ';
        --v_b_g2 := ' and tq1.style_name = tq.style_name ';
      END IF;
      if v_group = '1' and v_category = '1' then
        v_c_i1 := ' and tp.style_name = td.sort_dimension  ';
      elsif  v_group = '1' and v_category <> '1' then
        v_c_i1 := ' and tp.category_id = td.category_id 
                    and tp.style_name =  td.sort_dimension ';
      elsif  v_group <> '1' and v_category = '1' then
        v_c_i1 := ' and tp.group_id = td.group_id 
                    and tp.style_name =  td.sort_dimension';
      elsif  v_group <> '1' and v_category <> '1' then
        v_c_i1 := ' and tp.group_id = td.group_id
                    and tp.category_id = td.category_id 
                    and tp.style_name =  td.sort_dimension';
      end if;

    elsif V_DIMENSION = '03' THEN
      --统计维度：产品子类
      v_c_where := ' and t.statistical_dimension = ''03'' ';
      v_c_i     := ' and tp.samll_category = td.sort_dimension ';
      IF V_SORT IS NULL THEN
        V_WHERE := V_WHERE;
        --v1_b    := v1_b || ' and 1  =  1 ';
      ELSE
        V_WHERE := V_WHERE || ' and td.sort_dimension = ''' || V_SORT || '''';
        --  v_c_where := v_c_where || ' and t.sort_dimension = ''' || V_SORT || '''';
        v_b_g1 := ' ,tq.samll_category ';
        --v_b_g2 := ' and tq1.samll_category = tq.samll_category ';
      END IF;
      if v_group = '1' or v_category = '1' then
        v_c_i1 := ' ';
      else
        v_c_i1 := ' and tp.samll_category = td.sort_dimension ';
      end if;
      if v_group = '1' and v_category = '1' then
        v_c_i1 := ' and tp.samll_category = td.sort_dimension  ';
      elsif  v_group = '1' and v_category <> '1' then
        v_c_i1 := ' and tp.category_id = td.category_id 
                    and tp.samll_category = td.sort_dimension ';
      elsif  v_group <> '1' and v_category = '1' then
        v_c_i1 := ' and tp.group_id = td.group_id 
                    and tp.samll_category = td.sort_dimension ';
      elsif  v_group <> '1' and v_category <> '1' then
        v_c_i1 := ' and tp.group_id = td.group_id
                    and tp.category_id = td.category_id 
                    and tp.samll_category = td.sort_dimension ';
      end if;
    elsif V_DIMENSION = '04' THEN
      --统计维度：供应商
      v_c_where := ' and t.statistical_dimension = ''04'' ';
      v_c_i     := ' and tp.inside_supplier_code = td.sort_dimension ';
      IF V_SORT IS NULL THEN
        V_WHERE := V_WHERE;
        --v1_b    := v1_b || ' and 1  =  1 ';
      ELSE
        V_WHERE := V_WHERE || ' and td.sort_dimension = ''' || V_SORT || '''';
        --  v_c_where := v_c_where || ' and t.sort_dimension = ''' || V_SORT || '''';
        v_b_g1 := ' ,tq.inside_supplier_code ';
        ---v_b_g2 := ' and tq1.inside_supplier_code = tq.inside_supplier_code ';
      END IF;

      if v_group = '1' and v_category = '1' then
        v_c_i1 := ' and tp.inside_supplier_code = td.sort_dimension  ';
      elsif  v_group = '1' and v_category <> '1' then
        v_c_i1 := ' and tp.category_id = td.category_id 
                    and tp.inside_supplier_code = td.sort_dimension ';
      elsif  v_group <> '1' and v_category = '1' then
        v_c_i1 := ' and tp.group_id = td.group_id 
                    and tp.inside_supplier_code = td.sort_dimension ';
      elsif  v_group <> '1' and v_category <> '1' then
        v_c_i1 := ' and tp.group_id = td.group_id
                    and tp.category_id = td.category_id 
                    and tp.inside_supplier_code = td.sort_dimension ';
      end if;
    elsif V_DIMENSION = '05' THEN
      --统计维度：生产工厂
      v_c_where := ' and t.statistical_dimension = ''05'' ';
      v_c_i     := ' and tp.factory_code = td.sort_dimension ';
      IF V_SORT IS NULL THEN
        V_WHERE := V_WHERE;
       -- v1_b    := v1_b || ' and 1  =  1 ';
      ELSE
        V_WHERE := V_WHERE || ' and td.sort_dimension = ''' || V_SORT || '''';
        -- v_c_where := v_c_where || ' and t.sort_dimension = ''' || V_SORT || '''';
        v_b_g1 := ' ,tq.factory_code ';
       -- v_b_g2 := ' and tq1.factory_code = tq.factory_code ';
      END IF;
      if v_group = '1' and v_category = '1' then
        v_c_i1 := ' and tp.factory_code = td.sort_dimension  ';
      elsif  v_group = '1' and v_category <> '1' then
        v_c_i1 := ' and tp.category_id = td.category_id 
                    and tp.factory_code = td.sort_dimension ';
      elsif  v_group <> '1' and v_category = '1' then
        v_c_i1 := ' and tp.group_id = td.group_id 
                    and tp.factory_code = td.sort_dimension ';
      elsif  v_group <> '1' and v_category <> '1' then
        v_c_i1 := ' and tp.group_id = td.group_id
                    and tp.category_id = td.category_id 
                    and tp.factory_code = td.sort_dimension ';
      end if;

    elsif V_DIMENSION = '06' THEN
      --统计维度：跟单
      v_c_i := ' and tp.sort_dimension = td.sort_dimension ';
      IF V_SORT IS NULL THEN
        V_WHERE := V_WHERE;
       -- v1_b    := v1_b || ' and 1  =  1 ';
      ELSE
        V_WHERE := V_WHERE || ' and td.statistical_dimension = ''' ||
                   V_DIMENSION || ''' and td.sort_dimension = ''' || V_SORT || '''';
        ---  v_c_where := v_c_where || ' and t.sort_dimension = ''' || V_SORT || '''';
      
      END IF;
      if v_group = '1' or v_category = '1' then
        v_c_i1 := ' ';
      else
        v_c_i1 := ' and tp.statistical_dimension = ''06''  ';
      end if;
    elsif V_DIMENSION = '07' THEN
      --统计维度：跟单主管
      v_c_where := ' and t.statistical_dimension = ''07'' ';
      v_c_i     := ' and tp.sort_dimension = td.sort_dimension ';
      IF V_SORT IS NULL THEN
        V_WHERE := V_WHERE;
        --v1_b    := v1_b || ' and 1  =  1 ';
      ELSE
        V_WHERE := V_WHERE || ' and td.statistical_dimension = ''' ||
                   V_DIMENSION || ''' and td.sort_dimension = ''' || V_SORT || '''';
        --  v_c_where := v_c_where || ' and t.sort_dimension = ''' || V_SORT || '''';
      END IF;
      if v_group = '1' or v_category = '1' then
        v_c_i1 := ' ';
      else
        v_c_i1 := ' and tp.statistical_dimension = ''07''  ';
      end if;
    elsif V_DIMENSION = '08' THEN
      --统计维度：QC
      v_c_where := ' and t.statistical_dimension = ''08'' ';
      v_c_i     := ' and tp.sort_dimension = td.sort_dimension ';
      IF V_SORT IS NULL THEN
        V_WHERE := V_WHERE;
       -- v1_b    := v1_b || ' and 1  =  1 ';
      ELSE
        V_WHERE := V_WHERE || ' and td.statistical_dimension = ''' ||
                   V_DIMENSION || ''' and td.sort_dimension = ''' || V_SORT || '''';
        --  v_c_where := v_c_where || ' and t.sort_dimension = ''' || V_SORT || '''';
      END IF;
      if v_group = '1' or v_category = '1' then
        v_c_i1 := ' ';
      else
        v_c_i1 := ' and tp.statistical_dimension = ''08''  ';
      end if;
    elsif V_DIMENSION = '09' THEN
      --统计维度：qc主管
      v_c_where := ' and t.statistical_dimension = ''09'' ';
      v_c_i     := ' and tp.sort_dimension = td.sort_dimension ';
      IF V_SORT IS NULL THEN
        V_WHERE := V_WHERE;
       -- v1_b    := v1_b || ' and 1  =  1 ';
      ELSE
        V_WHERE := V_WHERE || ' and td.statistical_dimension = ''' ||
                   V_DIMENSION || ''' and td.sort_dimension = ''' || V_SORT || '''';
        --   v_c_where := v_c_where || ' and t.sort_dimension = ''' || V_SORT || '''';
      END IF;
      if v_group = '1' or v_category = '1' then
        v_c_i1 := ' ';
      else
        v_c_i1 := ' and tp.statistical_dimension = ''09''  ';
      end if;
    end if;

       if v_dimension  in ('06','07','08','09') then
       if V_GROUP <> '1' and V_CATEGORY <> '1' then 
       v4_b := ' where tq.statistical_dimension =''' || v_dimension || '''
                   and tq.category_id = ''' || V_CATEGORY || '''
                   and tq.group_name = ''' || V_GROUP || '''  ';
        elsif V_GROUP <> '1' and V_CATEGORY = '1' then
       v4_b := ' where tq.statistical_dimension =''' || v_dimension || '''
                   and tq.group_name = ''' || V_GROUP || '''  ';
        elsif V_GROUP = '1' and V_CATEGORY <> '1' then 
       v4_b := ' where tq.statistical_dimension =''' || v_dimension || '''
                   and tq.category_id = ''' || V_CATEGORY || ''' ';
        elsif  V_GROUP = '1' and V_CATEGORY = '1' then 
       v4_b := ' where tq.statistical_dimension =''' || v_dimension || '''';
       end if;        
     end if;

    --时间维度
    IF SUBSTR(V_TIME, 5, 1) = '-' THEN
      V1_TIME := TO_CHAR(SYSDATE, 'yyyy') || '年' || TO_CHAR(SYSDATE, 'mm') || '月';
      V_C     := SCMDATA.PKG_KPIPT_ORDER.F_KPI_MONTH(TOTAL_TIME => V1_TIME);
      --V_MAX_DATE := SCMDATA.PARSE_JSON(V_C, 'COL_1');
      V_MIN_DATE := SCMDATA.PARSE_JSON(V_C, 'COL_2');
      v_where    := v_where ||
                    q'[ and td.year || lpad(td.month, 2, 0) > ']' ||
                    v_min_date ||
                    q'[' and td.year || lpad(td.month, 2, 0) <= to_char(sysdate, 'yyyymm')]';
      V_S        := ' t.year || ''年'' || lpad(t.month, 2, 0) || ''月'' total_time,';
      v_c_w      := '  and tp.year = td.year  and tp.month = td.month  ';
      v_s1       := q'[ t.year, t.month, ]';
      v_s2       := ' t.year || ''年'' || lpad(t.month, 2, 0) || ''月'' ';
      v_s3       := ' tq.year, tq.month ';
      --v_s4       := ' on tq1.year = tq.year  and tq1.month = tq.month ';
      v_c_group  := q'[ group by  t.year, t.month,  ]';
    ELSE
      IF SUBSTR(V_TIME, -1) = '月' THEN
        V_C       := SCMDATA.PKG_KPIPT_ORDER.F_KPI_MONTH(TOTAL_TIME => V_TIME);
        V_S       := ' t.year||lpad(t.month, 2, 0) total_date,(t.year || ''年'' || lpad(t.month, 2, 0)|| ''月'') total_time,';
        v_c_w     := '  and tp.year = td.year  and tp.month = td.month  ';
        v_s1      := q'[ t.year, t.month, ]';
        v_s2      := ' t.year || ''年'' || lpad(t.month, 2, 0)|| ''月'' ';
        v_s3      := ' tq.year, tq.month ';
        --v_s4      := ' on tq1.year = tq.year  and tq1.month = tq.month ';
        v_c_group := q'[ group by  t.year, t.month , ]';
      ELSIF SUBSTR(V_TIME, -2) = '季度' THEN
        V_C       := SCMDATA.PKG_KPIPT_ORDER.F_KPI_QUARTER(TOTAL_TIME => V_TIME);
        V_S       := ' t.year|| t.quarter total_date,(t.year || ''年第'' || t.quarter || ''季度'') total_time,';
        v_c_w     := '    and tp.year = td.year  and tp.quarter = td.quarter  ';
        v_s1      := q'[ t.year , t.quarter , ]';
        v_s2      := ' t.year || ''年第'' || t.quarter || ''季度'' ';
        v_s3      := ' tq.year, tq.quarter ';
        --v_s4      := ' on tq1.year = tq.year  and tq1.quarter = tq.quarter ';
        v_c_group := q'[ group by  t.year, t.quarter , ]';
      ELSIF SUBSTR(V_TIME, -2) = '半年' THEN
        V_C       := SCMDATA.PKG_KPIPT_ORDER.F_KPI_HALFYEAR(TOTAL_TIME => V_TIME);
        V_S       := ' t.year||t.halfyear total_date,(t.year || ''年'' ||  decode(t.halfyear,1,''上'',2,''下'') || ''半年'') total_time,';
        v_c_w     := '  and tp.year = td.year  and tp.halfyear = td.halfyear  ';
        v_s1      := q'[ t.year,t.halfyear, ]';
        v_s2      := ' t.year || ''年'' ||  decode(t.halfyear,1,''上'',2,''下'') || ''半年'' ';
        v_s3      := ' tq.year, tq.halfyear ';
        --v_s4      := ' on tq1.year = tq.year  and tq1.halfyear = tq.halfyear ';
        v_c_group := q'[ group by  t.year, t.halfyear , ]';
      ELSIF LENGTH(V_TIME) = '5' THEN
        V_C       := SCMDATA.PKG_KPIPT_ORDER.F_KPI_YEAR(TOTAL_TIME => V_TIME);
        V_S       := ' t.year total_date,(t.year || ''年'') total_time,';
        v_c_w     := '  and tp.year = td.year ';
        v_s1      := q'[ t.year, ]';
        v_s2      := ' t.year || ''年'' ';
        v_s3      := ' tq.year ';
        --v_s4      := ' on tq1.year = tq.year ';
        v_c_group := q'[ group by  t.year,]';
      END IF;
      V_MAX_DATE := SCMDATA.PARSE_JSON(V_C, 'COL_1');
      V_MIN_DATE := SCMDATA.PARSE_JSON(V_C, 'COL_2');
      v_where    := v_where || ' and total_date >= ''' || v_min_date ||
                    ''' and total_date <= ''' || v_max_date || ''' ';
    END IF;

        if V_GROUP <> '1' and V_CATEGORY <> '1' then 
          v3_b := ' ,tq.group_name,tq.category_id';
        elsif V_GROUP <> '1' and V_CATEGORY = '1' then
          v3_b := ' ,tq.group_name';
        elsif V_GROUP = '1' and V_CATEGORY <> '1' then 
          v3_b := ' ,tq.category_id';
       end if; 
    ---汇总 非跟单、跟单主管、qc、qc主管 
    v1_sql := q'[
left join ( select tq.company_id,
       tq.year,
       tq.month,
       tq.quarter,
       tq.halfyear,
       tq.category_id,
       tq.group_name group_id,
       tq.style_name,
       tq.product_cate,
       tq.samll_category,tq.inside_supplier_code ,
       tq.supplier_code,
       tq.factory_code,
       sum(tq.qualdecrease_money) over ( partition by ]'|| v_s3 ||v3_b || q'[ )qualdecrease_money
  from scmdata.t_qa_warehouse_inspect_failed tq
 where tq.qc is not null  ]'|| v1_a ||q'[ ) tp
  on td.company_id = tp.company_id  ]' || v_c_w || v_c_i1;
  
    ---  非汇总  非跟单、跟单主管、qc、qc主管 
    v1_sql_a := q'[
left join ( select tq.company_id,
       tq.year,
       tq.month,
       tq.quarter,
       tq.halfyear,
       tq.category_id,
       (case when tq.group_name is null then '1' else tq.group_name end) group_id,
       tq.style_name,
       tq.product_cate,
       tq.samll_category,tq.inside_supplier_code ,
       tq.supplier_code,
       tq.factory_code,
       sum(tq.qualdecrease_money) over ( partition by ]'|| v_s3 ||v3_b ||v_b_g1|| q'[ )qualdecrease_money
  from scmdata.t_qa_warehouse_inspect_failed tq
  where 1 = 1  ]'|| v1_a ||q'[ ) tp
  on td.company_id = tp.company_id  ]' || v_c_w || v_c_i;
  
    --汇总 跟单、跟单主管、qc、qc主管 
    v2_sql := q'[ left join ( select tq.company_id,
       trunc(tq.qualfinishtime) qualfinishtime,
       tq.year,
       tq.month,
       tq.quarter,
       tq.halfyear,
       tq.category_id,
       tq.group_name group_id,
       tq.statistical_dimension,
       tq.sort_dimension,
       sum(tq.qualdecrease_money) over ( partition by ]'|| v_s3 ||v3_b || q'[ )qualdecrease_money
  from scmdata.t_qa_inspect_failed_flw_qc tq  ]' || v4_b ||q'[) tp
  on td.company_id = tp.company_id ]' || v_c_w || v_c_i1;
  
    --非汇总 跟单、跟单主管、qc、qc主管 
    v2_sql_a := q'[ left join ( select tq.company_id,
       trunc(tq.qualfinishtime) qualfinishtime,
       tq.year,
       tq.month,
       tq.quarter,
       tq.halfyear,
       tq.category_id,
       (case when tq.group_name is null then '1' else tq.group_name end) group_id,
       tq.statistical_dimension,
       tq.sort_dimension,
       sum(tq.qualdecrease_money) over ( partition by ]'|| v_s3 ||v3_b || q'[,tq.sort_dimension  )qualdecrease_money
  from scmdata.t_qa_inspect_failed_flw_qc tq  ]' || v4_b ||q'[) tp
  on td.company_id = tp.company_id  ]' || v_c_w || v_c_i;
     --汇总  
    v_c_sql := ' select t.company_id, ' || V_S1 || V_S ||
               q'[ t.statistical_dimension,t.group_id ,t.category_id, t.sort_dimension, t2.purchase_money
         from scmdata.t_qa_ingood t
        inner join (select t.company_id, ]' || V_S1 || V_S || q'[
                          t.statistical_dimension,
                          sum(purchase_money) purchase_money
                     from scmdata.t_qa_ingood t 
                    where t.company_id = ']' || V_COMPANY_ID || '''' ||
               v_c_where || v2_b || v_c_group || ' t.company_id,t.statistical_dimension ) t2  
           on ' || v_s2 || q'[ = t2.total_time
          and t.statistical_dimension = t2.statistical_dimension
       where t.company_id = ']' || V_COMPANY_ID || '''' ||
               v_c_where || ' ) td ';
    --非汇总   
    v_c_sql_a := ' select t.company_id, ' || V_S1 || V_S ||
                 q'[ t.statistical_dimension,t.group_id ,t.category_id, t.sort_dimension, t2.purchase_money
         from scmdata.t_qa_ingood t
        inner join (select t.company_id, ]' || V_S1 || V_S || q'[
                          t.statistical_dimension,t.sort_dimension,
                          sum(purchase_money) purchase_money
                     from scmdata.t_qa_ingood t 
                    where t.company_id = ']' ||
                 V_COMPANY_ID || '''' || v_c_where || v2_b || v_c_group ||
                 ' t.company_id,t.sort_dimension,t.statistical_dimension ) t2  
           on ' || v_s2 || q'[ = t2.total_time
          and t.statistical_dimension = t2.statistical_dimension
          and t.sort_dimension = t2.sort_dimension
       where t.company_id = ']' || V_COMPANY_ID || '''' ||
                 v_c_where || ' ) td ';
  
    ---判断是否为跟单、跟单主管、qc、qc主管维度
    if V_DIMENSION in ('06', '07', '08', '09') then
      if v_sort is null then
        vc1_sql := 'select total_time, (case when max(nvl(qualdecrease_money, 0)) = 0 then 0 else (max(nvl(qualdecrease_money, 0))/ max(nvl(purchase_money, 0)))*100 end) purchase_rate from (' ||
                   v_c_sql || v2_sql || v_where || ' group by total_time';
      else
        vc1_sql := 'select total_time, (case when max(nvl(qualdecrease_money, 0)) = 0 then 0 else (max(nvl(qualdecrease_money, 0))/ max(nvl(purchase_money, 0)))*100 end) purchase_rate from (' ||
                   v_c_sql_a || v2_sql_a || v_where ||
                   ' group by total_time';
      end if;
    
    else
      if v_sort is null then
        vc1_sql := 'select total_time,(case when max(nvl(qualdecrease_money, 0)) = 0 then 0 else (max(nvl(qualdecrease_money, 0))/ max(nvl(purchase_money, 0)))*100  end) purchase_rate from (' ||
                   v_c_sql || v1_sql || v_where || ' group by total_time';
      else
        vc1_sql := 'select total_time,(case when max(nvl(qualdecrease_money, 0)) = 0 then 0 else (max(nvl(qualdecrease_money, 0))/ max(nvl(purchase_money, 0)))*100  end) purchase_rate from (' ||
                   v_c_sql_a || v1_sql_a || v_where ||
                   ' group by total_time';
      end if;
    end if;
  
    RETURN vc1_sql;
  
  END F_KPI_181_SELECTSQL;

  FUNCTION F_KPI_182_SELECTSQL(V_TIME       VARCHAR2,
                               V_DIMENSION  VARCHAR2,
                               V_SORT       VARCHAR2,
                               V_GROUP      VARCHAR2,
                               V_CATEGORY   VARCHAR2,
                               V_COMPANY_ID VARCHAR2) RETURN CLOB IS
    V_SQL   CLOB;
    V_WHERE CLOB;
  BEGIN
    V_WHERE := ' where tq.company_id = ''' || V_COMPANY_ID || '''';
    --统计维度
    if V_SORT is null then
      if V_DIMENSION in ('00', '01') THEN
        --统计维度：分类
        --过滤条件：分类
        case
          when V_CATEGORY = '1' then
            V_WHERE := V_WHERE || ' and 1 = 1 ';
          else
            V_WHERE := V_WHERE || ' and tq.category_id = ''' || V_CATEGORY ||
                       ''' ';
        end case;
        --过滤条件：区域组
        case
          when V_GROUP = '1' then
            V_WHERE := V_WHERE || ' and 1 = 1 ';
          else
            V_WHERE := V_WHERE || ' and tq.group_name = ''' || V_GROUP ||
                       ''' ';
        end case;
      else
        V_WHERE := V_WHERE;
      end if;
    else
      if V_DIMENSION = '00' THEN
        --统计维度：区域组
        --过滤条件：分类
        case
          when V_CATEGORY = '1' then
            V_WHERE := V_WHERE || ' and 1 = 1 ';
          else
            V_WHERE := V_WHERE || ' and tq.category_id = ''' || V_CATEGORY ||
                       ''' ';
        end case;
        --过滤条件：区域组
     if V_SORT = '1' then 
        V_WHERE := V_WHERE || ' and tq.group_name is null  ';
     else
        V_WHERE := V_WHERE || ' and tq.group_name = ''' || V_SORT || ''' ';
     end if;

      elsif V_DIMENSION = '01' THEN
        --统计维度：分类
        --过滤条件：分类
        V_WHERE := V_WHERE || ' and tq.category_id = ''' || V_SORT || ''' ';
        --过滤条件：区域组
        case
          when V_GROUP = '1' then
            V_WHERE := V_WHERE || ' and 1 = 1 ';
          else
            V_WHERE := V_WHERE || ' and tq.group_name = ''' || V_GROUP ||
                       ''' ';
        end case;
      elsif V_DIMENSION = '02' THEN
        --统计维度：款式名称
        V_WHERE := V_WHERE || ' and tq.style_name = ''' || V_SORT || '''';
      elsif V_DIMENSION = '03' THEN
        --统计维度：产品子类
        V_WHERE := V_WHERE || ' and tq.samll_category = ''' || V_SORT || '''';
      elsif V_DIMENSION = '04' THEN
        --统计维度：供应商
        V_WHERE := V_WHERE || ' and tq.inside_supplier_code = ''' || V_SORT || '''';
      elsif V_DIMENSION = '05' THEN
        --统计维度：生产工厂
        V_WHERE := V_WHERE || ' and tq.factory_code = ''' || V_SORT || '''';
      elsif V_DIMENSION = '06' THEN
        --统计维度：跟单
        if V_SORT = '1' then
          V_WHERE := V_WHERE || ' and tq.flw_order is null ';
        else
          V_WHERE := V_WHERE || ' and tq.flw_order like ''%' || V_SORT ||
                     '%''';
        end if;
      elsif V_DIMENSION = '07' THEN
        --统计维度：跟单主管
        if V_SORT = '1' then
          V_WHERE := V_WHERE || ' and tq.flw_order_manager is null ';
        else
          V_WHERE := V_WHERE || ' and tq.flw_order_manager like ''%' ||
                     V_SORT || '%''';
        end if;
      elsif V_DIMENSION = '08' THEN
        --统计维度：QC
        if V_SORT = '1' then
          V_WHERE := V_WHERE || ' and tq.qc is null ';
        else
          V_WHERE := V_WHERE || ' and tq.qc like ''%' || V_SORT || '%''';
        end if;
      elsif V_DIMENSION = '09' THEN
        --统计维度：QC主管
        if V_SORT = '1' then
          V_WHERE := V_WHERE || ' and tq.qc_manager is null ';
        else
          V_WHERE := V_WHERE || ' and tq.qc_manager like ''%' || V_SORT ||
                     '%''';
        end if;
      end if;
    end if;
  
    if V_DIMENSION not in ('00', '01') then
      --过滤条件：分类
      case
        when V_CATEGORY = '1' then
          V_WHERE := V_WHERE || ' and 1 = 1 ';
        else
          V_WHERE := V_WHERE || ' and tq.category_id = ''' || V_CATEGORY ||
                     ''' ';
      end case;
      --过滤条件：区域组
      case
        when V_GROUP = '1' then
          V_WHERE := V_WHERE || ' and 1 = 1 ';
        else
          V_WHERE := V_WHERE || ' and tq.group_name = ''' || V_GROUP ||
                     ''' ';
      end case;
    end if;
  
    --时间维度
    if substr(V_TIME, 5, 1) = '-' then
      V_WHERE := V_WHERE ||
                 ' and (tq.year || ''-'' || lpad(tq.month, 2, 0)) = ''' ||
                 V_TIME || '''';
    elsif substr(V_TIME, -1) = '月' then
      V_WHERE := V_WHERE ||
                 ' and (tq.year || ''年'' || lpad(tq.month, 2, 0) || ''月'') = ''' ||
                 V_TIME || '''';
    elsif substr(V_TIME, -2) = '季度' then
      V_WHERE := V_WHERE ||
                 ' and (tq.year || ''年第'' || tq.quarter || ''季度'') = ''' ||
                 V_TIME || '''';
    elsif substr(V_TIME, -2) = '半年' then
      V_WHERE := V_WHERE ||
                 ' and (tq.year || ''年'' || decode(tq.halfyear ,1,''上'',2,''上'') || ''半年'') = ''' ||
                 V_TIME || '''';
    elsif length(V_TIME) = '5' then
      V_WHERE := V_WHERE || ' and (tq.year || ''年'' ) = ''' || V_TIME || '''';
    end if;
  
    V_SQL := q'[ WITH company_user AS
   (SELECT fu.company_id, fu.user_id, fu.company_user_name
      FROM scmdata.sys_company_user fu)
  select tq.qa_warehouse_inspect_failed_id,
         tq.company_id,
         tq.year,
         tq.quarter,
         tq.month,
         sh.group_dict_name warehouse,
         tq.category_id,
         sg.group_dict_name category_name,
         tq.rela_goo_id,tq.style_number,
         tq.style_name,
         tq.inside_supplier_code,
         t_sup.supplier_company_abbreviation SUPPLIER,
         t_fac.supplier_company_abbreviation FACTORY_COMPANY_NAME_PR,
         tq.qualdecrease_amount UNQUALAMOUNT_01000,
         tq.if_batch_sporadic,
         tq.problem_classification,
         tq.problem_descriptions PROBLEMDESCRIPTION_01800,
         tq.review_comments REVIEWCOMMENTS_00000,
         tq.memo,
         tq.skuprocessing_result PROCESSRESULT_00000,
         '查看' REPDETAIL_00000,
         tsg.group_name,
         (SELECT listagg(fu_a.company_user_name, ',')
            FROM company_user fu_a
           WHERE fu_a.company_id = tq.company_id
             AND instr(',' || tq.flw_order || ',', ',' || fu_a.user_id || ',') > 0) flw_order,
         (SELECT listagg(fu_c.company_user_name, ',')
            FROM company_user fu_c
           WHERE fu_c.company_id = tq.company_id
             AND instr(',' || tq.flw_order_manager || ',',
                       ',' || fu_c.user_id || ',') > 0) flw_order_manager,
         (SELECT listagg(fu_b.company_user_name, ',')
            FROM company_user fu_b
           WHERE fu_b.company_id = tq.company_id
             AND fu_b.company_id = 'b6cc680ad0f599cde0531164a8c0337f'
             AND instr(',' || tq.qc || ',', ',' || fu_b.user_id || ',') > 0) qc,
         (SELECT listagg(fu_d.company_user_name, ',')
            FROM company_user fu_d
           WHERE fu_d.company_id = tq.company_id
             AND instr(',' || tq.qc_manager || ',', ',' || fu_d.user_id || ',') > 0) qc_manager,
         (case
           when tq.is_need_qc_quality = 1 then
            '是'
           when tq.is_need_qc_quality = 0 then
            '否'
         end) is_need_qc_quality,
         sg1.group_dict_name procate_desc,
         sc1.company_dict_name samll_category,
         tq.price in_price,
         tq.qualfinishtime QUALFINISHTIME_01200,
         tq.qa_report_id qareportid_00000,
         tq.order_id ORDERID_00000,
         tq.asn_id
    from scmdata.t_qa_warehouse_inspect_failed tq
    left join scmdata.sys_group_dict sh
      on sh.group_dict_type = 'COMPANY_STORE_TYPE'
     and sh.group_dict_value = tq.sho_id
   inner join scmdata.sys_group_dict sg
      on sg.group_dict_type = 'PRODUCT_TYPE'
     and sg.group_dict_value = tq.category_id
    left join scmdata.t_supplier_info t_sup
      on t_sup.company_id = tq.company_id
     and t_sup.supplier_code = tq.supplier_code
    left join scmdata.t_supplier_info t_fac
      on t_fac.company_id = tq.company_id
     and t_fac.supplier_code = tq.factory_code
    left join scmdata.t_supplier_group_config tsg
      on tsg.group_config_id = tq.group_name
    left join scmdata.sys_group_dict sg1
      on sg1.group_dict_value = tq.product_cate
    left join scmdata.sys_company_dict sc1
      on sc1.company_id = 'b6cc680ad0f599cde0531164a8c0337f'
     and sc1.company_dict_value = tq.samll_category ]' ||
             V_WHERE || ' order by tq.qualfinishtime desc ';
    RETURN V_SQL;
  
  END F_KPI_182_SELECTSQL;
END PKG_QA_REPORT;
/

