insert into bw3.sys_item_element_rela (ITEM_ID, ELEMENT_ID, SEQ_NO, PAUSE, LEVEL_NO)
values ('a_qcqa_131_2', 'look_a_product_110_10', 1, 0, null);

insert into bw3.sys_item_element_rela (ITEM_ID, ELEMENT_ID, SEQ_NO, PAUSE, LEVEL_NO)
values ('a_qcqa_231_2', 'look_a_product_210_10', 1, 0, null);


insert into bw3.sys_item_element_rela (ITEM_ID, ELEMENT_ID, SEQ_NO, PAUSE, LEVEL_NO)
values ('a_report_list_610', 'look_a_product_110_10', 1, 0, null);

insert into bw3.sys_item_element_rela (ITEM_ID, ELEMENT_ID, SEQ_NO, PAUSE, LEVEL_NO)
values ('a_report_list_620', 'look_a_product_110_10', 1, 0, null);

insert into bw3.sys_item_element_rela (ITEM_ID, ELEMENT_ID, SEQ_NO, PAUSE, LEVEL_NO)
values ('a_report_list_630', 'look_a_product_110_10', 1, 0, null);

insert into bw3.sys_item_element_rela (ITEM_ID, ELEMENT_ID, SEQ_NO, PAUSE, LEVEL_NO)
values ('a_report_list_640', 'look_a_product_110_10', 1, 0, null);

insert into bw3.sys_item_element_rela (ITEM_ID, ELEMENT_ID, SEQ_NO, PAUSE, LEVEL_NO)
values ('a_report_list_650', 'look_a_product_110_10', 1, 0, null);

insert into bw3.sys_item_element_rela (ITEM_ID, ELEMENT_ID, SEQ_NO, PAUSE, LEVEL_NO)
values ('a_report_list_660', 'look_a_product_110_10', 1, 0, null);

insert into bw3.sys_item_element_rela (ITEM_ID, ELEMENT_ID, SEQ_NO, PAUSE, LEVEL_NO)
values ('a_qc_list_100', 'look_a_product_110_10', 1, 0, null);

insert into bw3.sys_item_element_rela (ITEM_ID, ELEMENT_ID, SEQ_NO, PAUSE, LEVEL_NO)
values ('a_qc_list_200', 'look_a_product_110_10', 1, 0, null);

insert into bw3.sys_item_element_rela (ITEM_ID, ELEMENT_ID, SEQ_NO, PAUSE, LEVEL_NO)
values ('a_qc_list_300', 'look_a_product_110_10', 1, 0, null);


declare
p_select_sql clob:='with temp as
 (select *
    from (select qc.qc_check_id,
                 qc.qc_check_code,
                 qo.orders_id,
                 qc.qc_check_node,
                 qc.qc_check_num,
                 qc.qc_result,
                 g.group_dict_name qc_result_desc,
                 qc.finish_time,
                 qc.finish_qc_id,
                 qc.qc_file_id,
                 qc.pre_meeting_record,
                 qc.pre_meeting_time,
                 u.company_user_name finish_qc,
                 rank() over(partition by qo.orders_id, qc.qc_check_node order by nvl(qc.finish_time, timestamp''2000-01-01 00:00:00'') desc) RANK_TMP
            from scmdata.t_qc_check qc
           inner join scmdata.t_qc_check_rela_order qo
              on qc.qc_check_id = qo.qc_check_id
           inner join scmdata.sys_company_user u
              on u.user_id = qc.finish_qc_id
             and u.company_id = qc.company_id
            left join scmdata.sys_group_dict g
              on g.group_dict_value = qc.qc_result
             and g.group_dict_type = ''NORMAL_QUALIFIED''
           where qc.finish_time is not null
             and qc.pause = 0)
   where RANK_TMP = 1)
select qgc.rela_goo_id,
       oe.order_code,
       --是否开始QC查货
       case
         when nvl(ta.qc_check_num, 0) + nvl(tb.qc_check_num, 0) +
              nvl(tc.qc_check_num, 0) + nvl(td.qc_check_num, 0) +
              nvl(te.qc_check_num, 0) = 0 then
          0
         else
          1
       end IS_QC_BEGINED,
       p.progress_status progress_status_pr,
       os.goo_id,
       qgc.style_number,
       qgc.style_name,
       --oe.supplier_code,
       si.inside_supplier_code,
       si.supplier_company_abbreviation supplier,
       --os.factory_code,
       fi.inside_supplier_code          INSIDE_FACTORY_CODE,
       fi.supplier_company_abbreviation PRODUCT_FACTORY,
       ga.group_dict_name               category,
       gb.group_dict_name               product_cate,
       cc.company_dict_name             samll_category,
       oe.create_time                   ORDER_DATE,
       oe.delivery_date,
       os.order_amount,
       oe.finish_time,
       td.qc_check_num                  pre_meeting_num,
       --td.pre_meeting_record pre_meeting_record_n,
       td.qc_check_code pre_meeting_code,
       nvl2(td.qc_check_code, ''查看'', null) PRE_MEETING_REPORT,
       td.pre_meeting_time pre_meeting_date_n,
       td.finish_qc pre_meeting_SUBMITOR,
       te.qc_check_code WASH_TEST_code,
       te.qc_check_num WASH_TEST_NUM,
       te.qc_result_desc WASH_TEST_RESULT_DESC_N,
       qcw.wash_test_date WASH_TEST_DATE_N,
       --qcw.wash_test_log              WASH_TEST_LOG_N,
       nvl2(te.qc_check_code, ''查看'', null) WASH_TEST_REPORT,
       te.finish_qc WASH_TEST_SUBMITOR,
       ta.qc_check_code FIRST_QC_CHECK_code,
       ta.qc_check_num FIRST_QC_CHECK_NUM,
       ta.qc_result_desc FIRST_QC_CHECK_result_DESC,
       ta.finish_time FIRST_QC_CHECK_finish_DATE,
       --ta.qc_file_id                  FIRST_QC_CHECK_file,
       nvl2(ta.qc_check_code, ''查看'', null) FIRST_QC_CHECK_FILE,
       ta.finish_qc FIRST_QC_CHECK_SUBMITOR,
       tb.qc_check_code MIDDLE_QC_CHECK_code,
       tb.qc_check_num MIDDLE_QC_CHECK_NUM,
       tb.qc_result_desc MIDDLE_QC_CHECK_result_DESC,
       tb.finish_time MIDDLE_QC_CHECK_finish_DATE,
       --tb.qc_file_id                  MIDDLE_QC_CHECK_file,
       nvl2(tb.qc_check_code, ''查看'', null) MIDDLE_QC_CHECK_FILE,
       tb.finish_qc MIDDLE_QC_CHECK_SUBMITOR,
       tc.qc_check_num FINAL_QC_CHECK_NUM,
       tc.qc_check_code FINAL_QC_CHECK_code,
       tc.qc_result_desc FINAL_QC_CHECK_result_DESC,
       tc.finish_time FINAL_QC_CHECK_finish_DATE,
       --tc.qc_file_id                  FINAL_QC_CHECK_file,
       nvl2(tc.qc_check_code, ''查看'', null) FINAL_QC_CHECK_FILE,
       tc.finish_qc FINAL_QC_CHECK_SUBMITOR
  from (select qt.goo_id,
               qt.company_id,
               ci.category,
               ci.product_cate,
               ci.samll_category,
               ci.style_name,
               ci.style_number,
               ci.rela_goo_id
          from (select distinct goo_id, company_id
                  from scmdata.t_qc_goo_collect
                 where company_id = %default_company_id%) qt
         inner join scmdata.t_commodity_info ci
            on ci.goo_id = qt.goo_id
           and ci.company_id = qt.company_id';
p_cate varchar2(100) :=' where ci.category = ''00''';
p_sql_least clob:=') qgc
 inner join scmdata.sys_group_dict ga
    on ga.group_dict_value = qgc.category
   and ga.group_dict_type = ''PRODUCT_TYPE''
 inner join scmdata.sys_group_dict gb
    on gb.group_dict_value = qgc.product_cate
   and gb.group_dict_type = qgc.category
 inner join scmdata.sys_company_dict cc
    on cc.company_dict_value = qgc.samll_category
   and cc.company_dict_type = qgc.product_cate
   and cc.company_id = qgc.company_id
 inner join scmdata.t_orders os
    on os.goo_id = qgc.goo_id
   and os.company_id = qgc.company_id
 inner join scmdata.t_ordered oe
    on oe.order_code = os.order_id
   and oe.company_id = os.company_id
 inner join scmdata.t_supplier_info si
    on si.supplier_code = oe.supplier_code
   and si.company_id = oe.company_id
 inner join scmdata.t_supplier_info fi
    on fi.supplier_code = os.factory_code
   and fi.company_id = os.company_id
  inner join scmdata.t_production_progress p
    on p.order_id = os.order_id
   and p.company_id = os.company_id
  left join temp ta
    on ta.orders_id = os.orders_id
   and ta.qc_check_node = ''QC_FIRST_CHECK''
  left join temp tb
    on tb.orders_id = os.orders_id
   and tb.qc_check_node = ''QC_MIDDLE_CHECK''
  left join temp tc
    on tc.orders_id = os.orders_id
   and tc.qc_check_node = ''QC_FINAL_CHECK''
  left join temp td
    on td.orders_id = os.orders_id
   and td.qc_check_node = ''QC_PRE_MEETING''
  left join temp te
    on te.orders_id = os.orders_id
   and te.qc_check_node = ''QC_WASH_TESTING''
  left join scmdata.t_qc_check_wash qcw
    on qcw.qc_check_id = te.qc_check_id
 order by oe.delivery_date asc';
begin
  update bw3.sys_item_list a set a.select_sql=p_select_sql ||replace(p_cate,'00','00')||p_sql_least where a.item_id='a_report_list_610';
  update bw3.sys_item_list a set a.select_sql=p_select_sql ||replace(p_cate,'00','01')||p_sql_least where a.item_id='a_report_list_620';
  update bw3.sys_item_list a set a.select_sql=p_select_sql ||replace(p_cate,'00','03')||p_sql_least where a.item_id='a_report_list_630';
  update bw3.sys_item_list a set a.select_sql=p_select_sql ||replace(p_cate,'00','08')||p_sql_least where a.item_id='a_report_list_640';
  update bw3.sys_item_list a set a.select_sql=p_select_sql ||replace(p_cate,'00','06')||p_sql_least where a.item_id='a_report_list_650';
  update bw3.sys_item_list a set a.select_sql=p_select_sql ||replace(p_cate,'00','07')||p_sql_least where a.item_id='a_report_list_660';

update bw3.sys_item_list a set 
  a.noshow_fields='progress_status_pr,style_name,inside_supplier_code,INSIDE_FACTORY_CODE,goo_id,pre_meeting_code,WASH_TEST_CODE,FIRST_QC_CHECK_CODE,MIDDLE_QC_CHECK_CODE,FINAL_QC_CHECK_CODE' where a.item_id in ('a_report_list_610','a_report_list_620','','a_report_list_630','a_report_list_640','a_report_list_650','a_report_list_660');

end;
/

declare
p_select_sql clob:='select ci.RELA_GOO_ID,
       os.order_id        order_code,
       gg.group_dict_name qc_check_node_pr,
       --''待公司批复'' qc_unq_advice_desc,
       base.qc_unq_say,
       base.QC_FINISH_DATE,
       u.company_user_name QC_CHECK_USER,
       --base.qc_check_code,
       --oe.supplier_code,
       --si.inside_supplier_code,
       si.supplier_company_abbreviation supplier,
       --os.factory_code,
       --fi.inside_supplier_code          INSIDE_FACTORY_CODE,
       fi.supplier_company_abbreviation PRODUCT_FACTORY,
       ci.style_number                  STYLE_NUMBER_PR,
       ci.style_name                    STYLE_NAME_PR,
       ga.group_dict_name               CLASSIFICATIONS,
       gb.group_dict_name               product_cate,
       cc.company_dict_name             samll_category,
       oe.create_time                   SEND_ORDER_DATE,
       oe.delivery_date,
       os.delivery_date                 LATEST_DELIVERY_DATE,
       t.progress_status                progress_status_pr,
       os.order_amount,
       oe.deal_follower,
       base.qc_check_code
  from (select *
          from (select qc.qc_check_id,
                       qc.qc_check_code,
                       qo.orders_id,
                       qc.qc_unq_advice,
                       qc.qc_unq_say,
                       qc.qc_check_node,
                       qc.qc_check_num,
                       qc.qc_result,
                       qc.finish_time,
                       qc.finish_qc_id,
                       qc.company_id,
                       --qc.qc_file_id,
                       qc.finish_time QC_FINISH_DATE,
                       rank() over(partition by qo.orders_id,qc.qc_check_node order by nvl(qc.finish_time, timestamp''2000-01-01 00:00:00'') desc) RANK_TMP
                  from scmdata.t_qc_check qc
                 inner join scmdata.t_qc_check_rela_order qo
                    on qc.qc_check_id = qo.qc_check_id
                 where qc.finish_time is not null
                   and qc.pause = 0)
         where RANK_TMP = 1
           and qc_result = ''NORMAL_NOT_QUALIFIED''';
p_cate varchar2(100) :=' and qc_unq_advice = ''UNAD_02''';
p_sql_least clob:=') base
 inner join scmdata.t_orders os
    on os.orders_id = base.orders_id
 inner join scmdata.t_ordered oe
    on oe.order_code = os.order_id
   and oe.company_id = os.company_id
 inner join scmdata.t_supplier_info si
    on si.supplier_code = oe.supplier_code
   and si.company_id = oe.company_id
 inner join scmdata.t_supplier_info fi
    on fi.supplier_code = os.factory_code
   and fi.company_id = os.company_id
 inner join scmdata.t_commodity_info ci
    on ci.goo_id = os.goo_id
   and ci.company_id = os.company_id
 inner join scmdata.sys_group_dict ga
    on ga.group_dict_value = ci.category
   and ga.group_dict_type = ''PRODUCT_TYPE''
 inner join scmdata.sys_group_dict gb
    on gb.group_dict_value = ci.product_cate
   and gb.group_dict_type = ci.category
 inner join scmdata.sys_company_dict cc
    on cc.company_dict_value = ci.samll_category
   and cc.company_dict_type = ci.product_cate
   and cc.company_id = ci.company_id
 inner join scmdata.sys_group_dict gg
    on gg.group_dict_value = base.qc_check_node
   and gg.group_dict_type = ''QC_CHECK_NODE_DICT''
 inner join scmdata.sys_company_user u
    on u.user_id = base.finish_qc_id
   and u.company_id = base.company_id
 INNER JOIN t_production_progress t
    ON t.company_id = os.company_id
   AND t.order_id = os.order_id
   AND t.goo_id = os.goo_id
 where ci.category = @DEFAULT_CATEGORY@
   and qc_check_node = @QC_CHECK_NODE_LI@
   and oe.order_status <> ''OS02''
 order by base.finish_time asc';
begin
    update bw3.sys_item_list a set a.select_sql=p_select_sql ||replace(p_cate,'UNAD_02','UNAD_02')||p_sql_least where a.item_id='a_qc_list_100';
   update bw3.sys_item_list a set a.select_sql=p_select_sql ||replace(p_cate,'UNAD_02','UNAD_01')||p_sql_least where a.item_id='a_qc_list_200';
  update bw3.sys_item_list a set a.select_sql=p_select_sql ||replace(p_cate,'UNAD_02','UNAD_00')||p_sql_least where a.item_id='a_qc_list_300';
  
update bw3.sys_item_list a set 
  a.noshow_fields='progress_status_pr' where a.item_id in ('a_qc_list_100','a_qc_list_200','','a_qc_list_300');

end;
/


declare
p_select_sql clob:= 'with top as
 (select goo_id, supplier_code
    from scmdata.t_qc_goo_collect a
   where a.qc_goo_collect_id = :qc_goo_collect_id),
group_dict AS
 (SELECT group_dict_type, group_dict_value, group_dict_name
    FROM scmdata.sys_group_dict)
select order_code,
       (select group_dict_name
          from scmdata.sys_group_dict
         where group_dict_type = ''ORDER_STATUS''
           and group_dict_value =
               (select oe.order_status
                  from scmdata.t_ordered oe
                 where oe.order_code = w.order_code
                   and oe.company_id = %default_company_id%)) order_status_desc,
       
       (SELECT t.progress_status
          from scmdata.t_production_progress t
         where t.order_id = w.order_code
           and t.company_id = %default_company_id%) progress_status_pr,
       delivery_date,
       (select max(delivery_date)
          from scmdata.t_orders
         where order_id = w.order_code
           and company_id = %default_company_id%) LATEST_DELIVERY_DATE,
       supplier,
       PRODUCT_FACTORY,
       
       max(case
             when qc_check_node = ''QC_FIRST_CHECK'' then
              LAST_QC_RESULT
             else
              null
           end) FIRST_LAST_QC_RESULT,
       sum(case
             when qc_check_node = ''QC_FIRST_CHECK'' then
              QC_CHECK_NUM
             else
              0
           end) FIRST_QC_CHECK_NUM,
       
       max(case
             when qc_check_node = ''QC_MIDDLE_CHECK'' then
              LAST_QC_RESULT
             else
              null
           end) MIDDLE_LAST_QC_RESULT,
       sum(case
             when qc_check_node = ''QC_MIDDLE_CHECK'' then
              QC_CHECK_NUM
             else
              0
           end) MIDDLE_QC_CHECK_NUM,
       
       max(case
             when qc_check_node = ''QC_FINAL_CHECK'' then
              LAST_QC_RESULT
             else
              null
           end) FINAL_LAST_QC_RESULT,
       sum(case
             when qc_check_node = ''QC_FINAL_CHECK'' then
              QC_CHECK_NUM
             else
              0
           end) FINAL_QC_CHECK_NUM
  from (select t.order_code,
               t.supplier,
               t.PRODUCT_FACTORY,
               t.delivery_date,
               t.qc_check_node,
               max(t.QC_CHECK_NUM) QC_CHECK_NUM,
               max(t.LAST_QC_RESULT) LAST_QC_RESULT
          from (select o.order_id               order_code,
                       si.supplier_company_name supplier,
                       fa.supplier_company_name PRODUCT_FACTORY,
                       oe.delivery_date,
                       g.qc_check_node,
                       /*count(distinct qc.qc_check_id) over(partition by o.order_id, g.qc_check_node) QC_CHECK_NUM*/
                       qc.qc_check_num,
                       first_value(qc.qc_result) over(partition by o.order_id, g.qc_check_node order by nvl(qc.finish_time, timestamp''2000-01-01 00:00:00'') desc) LAST_QC_RESULT
                  from scmdata.t_orders o
                 inner join (select a.group_dict_value qc_check_node
                              from scmdata.sys_group_dict a
                             where a.group_dict_type = ''QC_CHECK_NODE_DICT''
                               and a.pause = 0) g
                    on 1 = 1
                 inner join scmdata.t_ordered oe
                    on o.order_id = oe.order_code
                   and o.company_id = oe.company_id
                  left join scmdata.t_qc_check qc
                    on qc.finish_time is not null
                   and qc.qc_check_node = g.qc_check_node
                   and qc.pause = 0
                   and exists
                 (select 1
                          from scmdata.t_qc_check_rela_order a
                         where a.orders_id = o.orders_id
                           and a.qc_check_id = qc.qc_check_id)
                 inner join scmdata.t_commodity_info ci
                    on o.goo_id = ci.goo_id
                   and ci.company_id = o.company_id
                 inner join scmdata.t_supplier_info si
                    on si.supplier_code = oe.supplier_code
                   and si.company_id = oe.company_id
                  left join scmdata.t_supplier_info fa
                    on fa.supplier_code = o.factory_code
                   and fa.company_id = ci.company_id
                 where o.goo_id = (select goo_id from top)
                   and oe.supplier_code = (select supplier_code from top)
                   and o.company_id = %default_company_id%) t
         group by t.order_code,
                  t.supplier,
                  t.PRODUCT_FACTORY,
                  t.delivery_date,
                  t.qc_check_node) w
 group by order_code, supplier, PRODUCT_FACTORY, delivery_date
 order by w.order_code asc';
begin
  update bw3.sys_item_list a set a.select_sql=p_select_sql,a.noshow_fields='progress_status_pr,qc_check_node,LAST_QC_RESULT,FIRST_LAST_QC_RESULT,MIDDLE_LAST_QC_RESULT,FINAL_LAST_QC_RESULT' where a.item_id='a_qcqa_131_2';
end;
/


declare
p_select_sql clob:='with top as
 (select goo_id, supplier_code
    from scmdata.t_qc_goo_collect a
   where a.qc_goo_collect_id = :qc_goo_collect_id),
group_dict AS
 (SELECT group_dict_type, group_dict_value, group_dict_name
    FROM scmdata.sys_group_dict)
select order_code,
       (select group_dict_name
          from scmdata.sys_group_dict
         where group_dict_type = ''ORDER_STATUS''
           and group_dict_value =
               (select oe.order_status
                  from scmdata.t_ordered oe
                 where oe.order_code = w.order_code
                   and oe.company_id = w.company_id)) order_status_desc,
       
       (select t.progress_status
          from scmdata.t_production_progress t
         where t.order_id = w.order_code
           and t.company_id = w.company_id) progress_status_pr,
       delivery_date,
       (select max(delivery_date)
          from scmdata.t_orders
         where order_id = w.order_code
           and company_id = w.company_id) LATEST_DELIVERY_DATE,
       --supplier,
       c.logn_name     kehu,
       PRODUCT_FACTORY,
       
       max(case
             when qc_check_node = ''QC_FIRST_CHECK'' then
              LAST_QC_RESULT
             else
              null
           end) FIRST_LAST_QC_RESULT,
       sum(case
             when qc_check_node = ''QC_FIRST_CHECK'' then
              QC_CHECK_NUM
             else
              0
           end) FIRST_QC_CHECK_NUM,
       
       max(case
             when qc_check_node = ''QC_MIDDLE_CHECK'' then
              LAST_QC_RESULT
             else
              null
           end) MIDDLE_LAST_QC_RESULT,
       sum(case
             when qc_check_node = ''QC_MIDDLE_CHECK'' then
              QC_CHECK_NUM
             else
              0
           end) MIDDLE_QC_CHECK_NUM,
       
       max(case
             when qc_check_node = ''QC_FINAL_CHECK'' then
              LAST_QC_RESULT
             else
              null
           end) FINAL_LAST_QC_RESULT,
       sum(case
             when qc_check_node = ''QC_FINAL_CHECK'' then
              QC_CHECK_NUM
             else
              0
           end) FINAL_QC_CHECK_NUM
  from (select t.order_code,
               t.supplier,
               t.PRODUCT_FACTORY,
               t.delivery_date,
               t.qc_check_node,
               max(t.QC_CHECK_NUM) QC_CHECK_NUM,
               max(t.LAST_QC_RESULT) LAST_QC_RESULT,
               t.company_id
          from (select o.order_id               order_code,
                       si.supplier_company_name supplier,
                       fa.supplier_company_name PRODUCT_FACTORY,
                       oe.delivery_date,
                       g.qc_check_node,
                       /*count(distinct qc.qc_check_id) over(partition by o.order_id, g.qc_check_node) QC_CHECK_NUM*/
                       qc.qc_check_num,
                       o.company_id,
                       first_value(qc.qc_result) over(partition by o.order_id, g.qc_check_node order by nvl(qc.finish_time, timestamp''2000-01-01 00:00:00'') desc) LAST_QC_RESULT
                  from scmdata.t_orders o
                 inner join (select a.group_dict_value qc_check_node
                              from scmdata.sys_group_dict a
                             where a.group_dict_type = ''QC_CHECK_NODE_DICT''
                               and a.pause = 0) g
                    on 1 = 1
                 inner join scmdata.t_ordered oe
                    on o.order_id = oe.order_code
                   and o.company_id = oe.company_id
                  left join scmdata.t_qc_check qc
                    on qc.finish_time is not null
                   and qc.qc_check_node = g.qc_check_node
                   and qc.pause = 0
                   and exists
                 (select 1
                          from scmdata.t_qc_check_rela_order a
                         where a.orders_id = o.orders_id
                           and a.qc_check_id = qc.qc_check_id)
                 inner join scmdata.t_commodity_info ci
                    on o.goo_id = ci.goo_id
                   and ci.company_id = o.company_id
                 inner join scmdata.t_supplier_info si
                    on si.supplier_code = oe.supplier_code
                   and si.company_id = oe.company_id
                  left join scmdata.t_supplier_info fa
                    on fa.supplier_code = o.factory_code
                   and fa.company_id = ci.company_id
                 where o.goo_id = (select goo_id from top)
                   and oe.supplier_code = (select supplier_code from top)
                   and si.supplier_company_id = %default_company_id%) t
         group by t.order_code,
                  t.supplier,
                  t.PRODUCT_FACTORY,
                  t.delivery_date,
                  t.qc_check_node,
                  t.company_id) w
 inner join scmdata.sys_company c
    on w.company_id = c.company_id
 group by w.order_code,
          w.delivery_date,
          w.PRODUCT_FACTORY,
          c.logn_name,
          w.company_id
 order by w.order_code asc';
begin
  update bw3.sys_item_list a set a.select_sql=p_select_sql,a.noshow_fields='progress_status_pr,qc_check_node,LAST_QC_RESULT,FIRST_LAST_QC_RESULT,MIDDLE_LAST_QC_RESULT,FINAL_LAST_QC_RESULT' where a.item_id='a_qcqa_231_2';
end;
/
