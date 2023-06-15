CREATE OR REPLACE PACKAGE SCMDATA.PKG_REPORT IS

  procedure p_supplier_trial_order_report;

---旧版，作废
  procedure p_supplier_trial_send_wx ;

/*触发器触发
场景一、QC、跟单未维护场景
    1.v_type = 1 首次试单供应商到期
      v_type = 2 试单供应商到期3天后
    2.v_type2 = 301 试单未结束tab页
      v_type2 = 302 继续试单tab页  */
  procedure p_supplier_trial_first_send_wx1(v_supplier varchar2,v_id varchar2,v_type number,v_type2 number);

/*触发器触发
场景二、QC、跟单完成维护推送信息跟供管场景
    1.v_type = 1 首次试单供应商到期
      v_type = 2 试单供应商到期3天后
    2.v_type2 = 301 试单未结束tab页
      v_type2 = 302 继续试单tab页 */
  procedure p_supplier_trial_send_wx1(v_supplier varchar2,v_id varchar2,v_type number,v_type2 number);

/*触发器触发
场景三、审核结束触发*/
  procedure p_supplier_trial_send_wx2(v_supplier varchar2,v_id varchar2,v_type varchar2);
END PKG_REPORT;
/

CREATE OR REPLACE PACKAGE BODY SCMDATA.PKG_REPORT IS

/*
  试单供应商报表
   每5分钟刷新数据-数据库job定时跑
   版本：2022-2-22
         2022-3-11 因需求变更、优化
         2022-6-23 因需求变更，优化
         2022-6-28 修改跟单员、跟单主管取值，修正试一单、试二单的结束时间的获取
                   拆分鞋包跟单主管
                    1）若生产类别=男鞋/女鞋/鞋类其他，跟单主管=唐惠迪
                    2）若生产类别≠男鞋/女鞋/鞋类其他，跟单主管=朱晓华
         2022-10-09 修正外协厂试一单供应商获取试单时间
         2022-10-10 合并发送消息
*/
  procedure p_supplier_trial_order_report is
    /*再次流入数据时，清空相关的内容*/
    begin
      merge into scmdata.t_supplier_trial_order_report tka
      using (select t.supplier_info_id, t.company_id, t.supplier_code,ts.flag
               from (select t1.supplier_info_id, --供应商主键
                            t1.company_id, --公司id
                            t1.supplier_code --供应商编码
                       from scmdata.t_supplier_info t1
                      where t1.supplier_code is not null
                        and t1.pause = '2') t
              inner join scmdata.t_supplier_trial_order_report ts
                 on ts.supplier_info_id = t.supplier_info_id
                and ts.company_id = t.company_id
                and ts.supplier_code = t.supplier_code
                and ts.review is not null) tkb
      on (tka.company_id = tkb.company_id and tka.supplier_info_id = tkb.supplier_info_id and tka.supplier_code = tkb.supplier_code)
      when matched then
        update
           set tka.follower_leader_suggest = '',
               tka.follower_review_time    = '',
               tka.qc_leader_suggest       = '',
               tka.qc_review_time          = '',
               tka.review                  = '',
               tka.review_time             = '',
               tka.trialorder_type         = '',
               tka.trial_results           = '',
               tka.send_time               = '',
               tka.send_number             = '',
               tka.if_trial_order          = '否',
               tka.flag                    = tkb.flag+1,
               tka.start_trial_order_date  = sysdate,
               tka.trial_order_end_date    = '',
               tka.update_id               = 'ADMIN',
               tka.update_time             = sysdate;

---正常数据流入（当供应商为试单状态->流入试单供应商报表）
  begin
    merge into scmdata.t_supplier_trial_order_report tka
    using (select t.supplier_info_id,
                  t.company_id,
                  t.supplier_code, --供应商编码
                  t.supplier_company_abbreviation, --供应商简称
                  t.supplier_company_name, --供应商全称
                  t.supplier_info_origin, --来源
                  t.admit_result trialorder_type, --准入结果
                  t.create_date admittance_date, --准入日期
                  fr.check_date, --验厂日期
                  t.product_type, --生产类型
                  t.cooperation_model, --合作模式
                  t.pause statu, --合作状态
                  tst.trial_results, --试单结果
                  tst.review ,--审核结果
                  tst.flag, --标志状态
                  (select t1.supplier_company_abbreviation
                     from scmdata.t_supplier_info t1
                    where t1.supplier_info_id = fa.rela_supplier_id
                      and t1.company_id = fa.company_id) factory_name, --关联供应商
                  p.province || c.city || dc.county location_area, --所在区域
                  (select (select s1.company_user_name
                             from scmdata.sys_company_user s1
                            where s1.user_id = tq.area_group_leader
                              and s1.company_id = tq.company_id) area_group_leader
                     from scmdata.t_supplier_group_config tq
                    where tq.pause = '1' and tq.group_name = t.group_name) area_group_leader, --区域组长
                  (case when t.cooperation_model = 'OF' then k1_of.send_order_date else k1.send_order_date end) send_order_date, --试单开始时间
                  (case
                    when t.admit_result = '1' then
                     (case when t.cooperation_model = 'OF' then k1_of.end_date else k1.end_date end)
                    when t.admit_result = '2' then
                     (case when t.cooperation_model = 'OF' then k2_of.end_date else k2.end_date end)
                    when t.admit_result = '3' then
                     (case when t.cooperation_model = 'OF' then k1_of.send_order_date + 30 else k1.send_order_date + 30 end)
                    when t.admit_result = '4' then
                     (case when t.cooperation_model = 'OF' then k1_of.send_order_date + 60 else k1.send_order_date + 60 end)
                    when t.admit_result = '5' then
                     (case when t.cooperation_model = 'OF' then k1_of.send_order_date + 90 else k1.send_order_date + 90 end)
                  end) trial_order_end_date, --试单结束时间
                  fell.follower_leader, --跟单主管
                  fell.classification, --分类ID
                  (select listagg(distinct g.group_dict_name, ';') within group(order by g.group_dict_value)
                     from scmdata.sys_group_dict g, scmdata.t_coop_scope sa
                    where sa.company_id = t.company_id
                      and sa.supplier_info_id = t.supplier_info_id
                      and sa.pause = '0'
                      and g.group_dict_type = t.cooperation_type
                      and g.group_dict_value = sa.coop_classification
                      and g.pause = '0') cooperation_classification_sp --合作分类
             from (select t1.supplier_info_id, --供应商主键
                          t1.company_id, --公司id
                          t1.supplier_code, --供应商编码
                          t1.inside_supplier_code,
                          t1.supplier_company_abbreviation, --供应商简称
                          t1.supplier_company_name, --供应商全称
                          t1.supplier_info_origin_id, --来源ID
                          t1.supplier_info_origin, --来源
                          t1.group_name, --所在区域
                          t1.admit_result, --准入结果
                          t1.product_type, --生产类型
                          t1.cooperation_model, --合作模式
                          t1.create_date, --验厂日期
                          t1.company_province, --公司省
                          t1.company_city, --公司市
                          t1.company_county, --公司区
                          t1.cooperation_type,
                          t1.pause --合作状态
                     from scmdata.t_supplier_info t1
                    where t1.supplier_code is not null
                      and t1.pause = '2') t
             left join scmdata.t_factory_ask fa
               on t.supplier_info_origin_id = fa.factory_ask_id
             left join scmdata.t_factory_report fr
               on fa.factory_ask_id = fr.factory_ask_id
             left join scmdata.dic_province p
               on p.provinceid = nvl(t.company_province, fa.company_province)
             left join scmdata.dic_city c
               on c.cityno = nvl(t.company_city, fa.company_city)
             left join scmdata.dic_county dc
               on dc.countyid = nvl(t.company_county, fa.company_county)
             left join (select k.company_id, k.supplier_code, k.send_order_date,  w1.end_date
                          from (select w.company_id, w.supplier_code, min(w.send_order_date) send_order_date
                                  from scmdata.t_ordered w
                                 group by w.company_id, w.supplier_code) k
                         inner join (select w.company_id, w.supplier_code, w.send_order_date,  w.finish_time end_date,
                                            row_number() over(partition by  w.company_id,w.supplier_code order by w.send_order_date, w.finish_time) num1
                                       from scmdata.t_ordered w) w1
                            on w1.company_id = k.company_id
                           and w1.supplier_code = k.supplier_code
                           and w1.send_order_date = k.send_order_date
                           and w1.num1 = 1) k1
               on k1.company_id = t.company_id
              and k1.supplier_code = t.supplier_code
             left join (select k.company_id, k.factory_code, k.send_order_date, w1.end_date
                          from (select w.company_id,od.factory_code, min(w.send_order_date) send_order_date
                                  from scmdata.t_ordered w
                                 inner join scmdata.t_orders od
                                    on w.company_id = od.company_id
                                   and w.order_code = od.order_id
                                 group by w.company_id, od.factory_code) k
                         inner join (select w.company_id, od.factory_code, w.send_order_date,w.finish_time end_date,
                                            row_number() over(partition by w.company_id, od.factory_code order by w.send_order_date, w.finish_time) num1
                                       from scmdata.t_ordered w
                                      inner join scmdata.t_orders od
                                         on w.company_id = od.company_id
                                        and w.order_code = od.order_id) w1
                            on w1.company_id = k.company_id
                           and w1.factory_code = k.factory_code
                           and w1.send_order_date = k.send_order_date
                           and w1.num1 = 1) k1_of
               on k1_of.company_id = t.company_id
              and k1_of.factory_code = t.supplier_code
             left join (select wz.company_id, wz.supplier_code, wz.end_date
                          from (select w.company_id, w.supplier_code, w.finish_time end_date,
                                       row_number() over(partition by w.company_id, w.supplier_code order by w.send_order_date,w.finish_time asc) num1
                                  from scmdata.t_ordered w) wz
                         where wz.num1 = '2') k2
               on k2.company_id = t.company_id
              and k2.supplier_code = t.supplier_code
             left join ( select w1.company_id, w1.factory_code, w1.end_date
                           from (select oh.company_id, od.factory_code, oh.finish_time end_date,
                                        row_number() over(partition by od.company_id, od.factory_code order by oh.send_order_date,oh.finish_time asc) num1
                                   from scmdata.t_ordered oh
                                  inner join scmdata.t_orders od
                                     on oh.company_id = od.company_id
                                    and oh.order_code = od.order_id) w1
                          where w1.num1 = '2') k2_of
               on k2_of.company_id = t.company_id
              and k2_of.factory_code = t.supplier_code
             left join (select supplier_info_id, supplier_code, company_id,
                              listagg(distinct coop_classification, ';') within group(order by coop_classification) classification,
                              listagg(distinct user_id, ';') within group(order by company_user_name) follower_leader
                         from (select t.supplier_info_id, t.supplier_code, t.company_id, sa.coop_classification, e.company_user_name, e.user_id
                                 from scmdata.t_supplier_info t
                                inner join scmdata.t_coop_scope sa
                                   on sa.company_id = t.company_id
                                  and sa.supplier_info_id = t.supplier_info_id
                                  and sa.pause = '0'
                                 left join (select a.company_user_name,a.user_id, a.company_id, c.dept_name,e1.cooperation_classification,d.job_name
                                             from scmdata.sys_company_user a
                                             left join scmdata.sys_company_user_dept b
                                               on a.user_id = b.user_id
                                              and a.company_id = b.company_id
                                             left join scmdata.sys_company_dept c
                                               on b.company_dept_id = c.company_dept_id
                                             left join scmdata.sys_company_dept_cate_map e1
                                               on c.company_id = e1.company_id
                                              and c.company_dept_id = e1.company_dept_id
                                             left join scmdata.sys_company_job d
                                               on a.job_id = d.job_id
                                              and a.company_id = d.company_id
                                            where a.pause = '0'
                                              and d.job_name = '跟单主管'
                                              and c.dept_name <> '跟单共享组'
                                              and e1.cooperation_classification is not null) e
                                   on sa.company_id = e.company_id
                                  and sa.coop_classification = e.cooperation_classification
                                where t.supplier_code is not null
                                  and t.pause = '2')
                        group by supplier_info_id, supplier_code, company_id) fell
               on fell.company_id = t.company_id
              and fell.supplier_info_id = t.supplier_info_id
             left join scmdata.t_supplier_trial_order_report tst
               on tst.supplier_info_id = t.supplier_info_id
              and tst.company_id = t.company_id) tkb
    on (tka.company_id = tkb.company_id and tka.supplier_info_id = tkb.supplier_info_id and tka.supplier_code = tkb.supplier_code)
    when matched then
      update
--更新首次试单的试单开始时间和结束时间
         set tka.start_trial_order_date       = (case when tkb.trial_results is null and tka.start_trial_order_date is null
                                                      then tkb.send_order_date else tka.start_trial_order_date end),
             tka.trial_order_end_date         = (case when tkb.trial_results is null and tka.trial_order_end_date is null and tkb.flag = 0
                                                      then tkb.trial_order_end_date else tka.trial_order_end_date end),
             tka.supplier_company_abbreviation = tkb.supplier_company_abbreviation,
             tka.supplier_company_name         = tkb.supplier_company_name,
             tka.cooperation_model             = tkb.cooperation_model,
             tka.factory_name                  = tkb.factory_name,
             tka.location_area                 = tkb.location_area,
             tka.product_type                  = tkb.product_type,
             tka.classification                = tkb.classification,
             tka.cooperation_classification_sp = tkb.cooperation_classification_sp,
             tka.follower_leader               = tkb.follower_leader,
             tka.statu                         = tkb.statu,
             tka.update_id                     = 'ADMIN',
             tka.update_time                   = sysdate
    when not matched then
       insert
         (tka.order_report_id,
          tka.company_id,
          tka.supplier_info_id,
          tka.supplier_info_origin,
          tka.if_trial_order,
          tka.trial_order_end_date,
          tka.statu,
          tka.supplier_code,
          tka.supplier_company_abbreviation,
          tka.supplier_company_name,
          tka.cooperation_model,
          tka.factory_name,
          tka.location_area,
          tka.product_type,
          tka.classification,
          tka.cooperation_classification_sp,
          tka.trialorder_type,
          tka.start_trial_order_date,
          tka.follower_leader,
          tka.area_group_leader,
          tka.check_date,
          tka.admittance_date,
          tka.flag,
          tka.memo,
          tka.send_number,
          tka.create_id,
          tka.create_time)
       values
         (scmdata.f_get_uuid(),
          tkb.company_id,
          tkb.supplier_info_id,
          tkb.supplier_info_origin,
          (case when tkb.trial_order_end_date <= sysdate then '是' else '否' end),
          tkb.trial_order_end_date,
          tkb.statu,
          tkb.supplier_code,
          tkb.supplier_company_abbreviation,
          tkb.supplier_company_name,
          tkb.cooperation_model,
          tkb.factory_name,
          tkb.location_area,
          tkb.product_type,
          tkb.classification,
          tkb.cooperation_classification_sp,
          tkb.trialorder_type,
          tkb.send_order_date,
          tkb.follower_leader,
          tkb.area_group_leader,
          tkb.check_date,
          tkb.admittance_date,
          '0',
          ' ',
          '0',
          'ADMIN',
          sysdate);
    end;
    /*更新在试单过程中的QC主管、跟单字段*/
    begin
      merge into scmdata.t_supplier_trial_order_report tka
      using (select t.company_id, t.supplier_info_id, listagg(distinct fu_d.user_id, ';') qc_manager,
                    listagg(distinct fu_a.user_id, ';') flw_order
               from scmdata.t_supplier_trial_order_report t
               left join scmdata.pt_ordered pt
                 on pt.company_id = t.company_id
                and pt.factory_code = t.supplier_code
               left join scmdata.sys_company_user fu_d
                 on fu_d.company_id = pt.company_id
                and instr(',' || pt.qc_manager || ',', ',' || fu_d.user_id || ',') > 0
               left join scmdata.sys_company_user fu_a
                 on fu_a.company_id = pt.company_id
                and instr(',' || pt.flw_order  || ',', ',' || fu_a.user_id || ',') > 0
              where t.start_trial_order_date is not null
                and pt.order_create_date >= t.start_trial_order_date
                and pt.order_create_date <= t.trial_order_end_date
              group by t.supplier_code, t.company_id, t.supplier_info_id) tkb
      on (tka.company_id = tkb.company_id and tka.supplier_info_id = tkb.supplier_info_id)
      when matched then
        update
           set tka.follower    = tkb.flw_order,
               tka.qc_leader   = tkb.qc_manager,
               tka.update_id   = 'ADMIN',
               tka.update_time = sysdate;
    end;

      /*更新再次流入数据时试单未结束tab页的试单结束时间*/
 begin
      merge into scmdata.t_supplier_trial_order_report tka
      using (select t.supplier_info_id,
                    t.company_id,
                    t.supplier_code, --供应商编码
                    (case when tst.trialorder_type = '1' then
                       (case when t.cooperation_model = 'OF' then k1_of.end_date else k1.end_date end)
                      when tst.trialorder_type = '2' then
                       (case when t.cooperation_model = 'OF' then k2_of.end_date else k2.end_date end)
                      when tst.trialorder_type = '3' then
                             tst.send_order_date + 30
                      when tst.trialorder_type = '4' then
                             tst.send_order_date + 60
                      when tst.trialorder_type = '5' then
                             tst.send_order_date + 90
                      end) trial_order_end_date --试单结束时间
               from (select t1.supplier_info_id, --供应商主键
                            t1.company_id, --公司id
                            t1.supplier_code, --供应商编码
                            t1.inside_supplier_code,
                            t1.cooperation_type,
                            t1.admit_result,
                            t1.cooperation_model,
                            t1.pause --合作状态
                       from scmdata.t_supplier_info t1
                      where t1.supplier_code is not null
                        and t1.pause = '2') t
               left join (select w.company_id,  w.supplier_code, min(w.finish_time) end_date
                           from scmdata.t_ordered w
                          inner join scmdata.t_supplier_trial_order_report tst
                             on tst.supplier_code = w.supplier_code
                            and tst.company_id = w.company_id
                            and tst.trial_results = '2'
                            and w.send_order_date >= tst.start_trial_order_date
                          group by w.company_id, w.supplier_code) k1
                 on k1.company_id = t.company_id
                and k1.supplier_code = t.supplier_code
               left join (select t.company_id, t.factory_code, min(oh.finish_time) end_date
                           from scmdata.t_ordered oh
                          inner join scmdata.t_orders od
                             on oh.company_id = od.company_id
                            and oh.order_code = od.order_id
                          inner join scmdata.t_production_progress t
                             on t.company_id = od.company_id
                            and t.order_id = od.order_id
                            and t.goo_id = od.goo_id
                          inner join scmdata.t_supplier_trial_order_report tst
                             on tst.supplier_code = t.factory_code
                            and tst.company_id = t.company_id
                            and tst.trial_results = '2'
                            and oh.send_order_date >= tst.start_trial_order_date
                          group by t.company_id, t.factory_code) k1_of
                 on k1_of.company_id = t.company_id
                and k1_of.factory_code = t.supplier_code
               left join (select wz.company_id, wz.supplier_code, wz.end_date
                           from (select w.company_id, w.supplier_code, w.finish_time end_date,
                                        row_number() over(partition by w.company_id, w.supplier_code order by finish_time asc) num1
                                   from scmdata.t_ordered w
                                  inner join scmdata.t_supplier_trial_order_report tst
                                     on tst.supplier_code = w.supplier_code
                                    and tst.company_id = w.company_id
                                    and tst.trial_results = '2'
                                    and w.send_order_date >= tst.start_trial_order_date ) wz
                          where wz.num1 = 2) k2
                 on k2.company_id = t.company_id
                and k2.supplier_code = t.supplier_code
               left join (select w1.company_id, w1.factory_code, w1.end_date
                           from (select oh.company_id,od.factory_code, oh.finish_time end_date,
                                        row_number() over(partition by od.company_id, od.factory_code order by oh.finish_time asc) num1
                                   from scmdata.t_ordered oh
                                  inner join scmdata.t_orders od
                                     on oh.company_id = od.company_id
                                    and oh.order_code = od.order_id
                                  inner join scmdata.t_supplier_trial_order_report tst
                                     on tst.supplier_code = od.factory_code
                                    and tst.company_id = od.company_id
                                    and tst.trial_results = '2'
                                    and oh.send_order_date >= tst.start_trial_order_date ) w1
                          where w1.num1 = 2) k2_of
                 on k2_of.company_id = t.company_id
                and k2_of.factory_code = t.supplier_code
              inner join scmdata.t_supplier_trial_order_report tst
                 on tst.supplier_info_id = t.supplier_info_id
                and tst.company_id = t.company_id
                and tst.flag <> 0
                and tst.statu = '2'
                and tst.trial_results is null) tkb
      on (tka.company_id = tkb.company_id and tka.supplier_info_id = tkb.supplier_info_id and tka.supplier_code = tkb.supplier_code)
      when matched then
        update
           set tka.trial_order_end_date    = tkb.trial_order_end_date,
               tka.update_id               = 'ADMIN',
               tka.update_time             = sysdate;
    end;

    /*更新再继续试单时的试单结束时间*/
    begin
      merge into scmdata.t_supplier_trial_order_report tka
      using (select t.supplier_info_id,
                    t.company_id,
                    t.supplier_code, --供应商编码
                    (case when tst.trialorder_type = '1' then
                       (case when t.cooperation_model = 'OF' then k1_of.end_date else k1.end_date end)
                      when tst.trialorder_type = '2' then
                       (case when t.cooperation_model = 'OF' then k2_of.end_date else k2.end_date end)
                      when tst.trialorder_type = '3' then
                             tst.send_order_date + 30
                      when tst.trialorder_type = '4' then
                             tst.send_order_date + 60
                      when tst.trialorder_type = '5' then
                             tst.send_order_date + 90
                      end) trial_order_end_date --试单结束时间
               from (select t1.supplier_info_id, --供应商主键
                            t1.company_id, --公司id
                            t1.supplier_code, --供应商编码
                            t1.inside_supplier_code,
                            t1.cooperation_type,
                            t1.admit_result,
                            t1.cooperation_model,
                            t1.pause --合作状态
                       from scmdata.t_supplier_info t1
                      where t1.supplier_code is not null
                        and t1.pause = '2') t
               left join (select w.company_id,  w.supplier_code, min(w.finish_time) end_date
                           from scmdata.t_ordered w
                          inner join scmdata.t_supplier_trial_order_report tst
                             on tst.supplier_code = w.supplier_code
                            and tst.company_id = w.company_id
                            and tst.trial_results = '2'
                            and w.send_order_date >= tst.send_order_date
                          group by w.company_id, w.supplier_code) k1
                 on k1.company_id = t.company_id
                and k1.supplier_code = t.supplier_code
               left join (select t.company_id, t.factory_code, min(oh.finish_time) end_date
                           from scmdata.t_ordered oh
                          inner join scmdata.t_orders od
                             on oh.company_id = od.company_id
                            and oh.order_code = od.order_id
                          inner join scmdata.t_production_progress t
                             on t.company_id = od.company_id
                            and t.order_id = od.order_id
                            and t.goo_id = od.goo_id
                          inner join scmdata.t_supplier_trial_order_report tst
                             on tst.supplier_code = t.factory_code
                            and tst.company_id = t.company_id
                            and tst.trial_results = '2'
                            and oh.send_order_date >= tst.send_order_date
                          group by t.company_id, t.factory_code) k1_of
                 on k1_of.company_id = t.company_id
                and k1_of.factory_code = t.supplier_code
               left join (select wz.company_id, wz.supplier_code, wz.end_date
                           from (select w.company_id, w.supplier_code, w.finish_time end_date,
                                        row_number() over(partition by w.company_id, w.supplier_code order by finish_time asc) num1
                                   from scmdata.t_ordered w
                                  inner join scmdata.t_supplier_trial_order_report tst
                                     on tst.supplier_code = w.supplier_code
                                    and tst.company_id = w.company_id
                                    and tst.trial_results = '2'
                                    and w.send_order_date >= tst.send_order_date) wz
                          where wz.num1 = 2) k2
                 on k2.company_id = t.company_id
                and k2.supplier_code = t.supplier_code
               left join (select w1.company_id, w1.factory_code, w1.end_date
                           from (select oh.company_id,od.factory_code, oh.finish_time end_date,
                                        row_number() over(partition by od.company_id, od.factory_code order by oh.finish_time asc) num1
                                   from scmdata.t_ordered oh
                                  inner join scmdata.t_orders od
                                     on oh.company_id = od.company_id
                                    and oh.order_code = od.order_id
                                  inner join scmdata.t_supplier_trial_order_report tst
                                     on tst.supplier_code = od.factory_code
                                    and tst.company_id = od.company_id
                                    and tst.trial_results = '2'
                                    and oh.send_order_date >= tst.send_order_date) w1
                          where w1.num1 = 2) k2_of
                 on k2_of.company_id = t.company_id
                and k2_of.factory_code = t.supplier_code
              inner join scmdata.t_supplier_trial_order_report tst
                 on tst.supplier_info_id = t.supplier_info_id
                and tst.company_id = t.company_id
                and tst.trial_results = '2'
                and tst.statu = '2') tkb
      on (tka.company_id = tkb.company_id and tka.supplier_info_id = tkb.supplier_info_id and tka.supplier_code = tkb.supplier_code)
      when matched then
        update
           set tka.end_date       = tkb.trial_order_end_date,
             /*  tka.if_trial_order =(case when tka.end_date >= sysdate then '是'else '否' end),*/
               tka.update_id      = 'ADMIN',
               tka.update_time    = sysdate;
    end;
/*更新是否到期字段*/
begin
   update scmdata.t_supplier_trial_order_report t
      set t.if_trial_order = (case when t.trial_order_end_date <= sysdate then '是' else '否' end)
    where t.statu = '2'
      and t.trial_results is null;
   update scmdata.t_supplier_trial_order_report t
      set t.if_trial_order = (case when t.end_date <= sysdate then '是' else '否' end)
    where t.statu = '2'
      and t.trial_results = '2';
end;

/*触发第二次消息推送*/
 begin
   merge into scmdata.t_supplier_trial_order_report tka
   using (select t.company_id,
                 t.send_number,
                 t.supplier_code,
                 t.order_report_id,
                 t.supplier_company_name
            from scmdata.t_supplier_trial_order_report t
           where t.send_time <= sysdate
             and t.send_time >= sysdate - 5/ (24 * 60)) tkb
   on (tka.company_id = tkb.company_id and tka.supplier_code = tkb.supplier_code and tka.order_report_id = tkb.order_report_id)
   when matched then
     update
        set tka.send_number = tkb.send_number + 1,
            tka.update_id   = 'ADMIN',
            tka.update_time = sysdate;
 end;

/*2022-06-27 新优化、把合作分类是鞋包的跟单主管拆分
1）若生产类别=男鞋/女鞋/鞋类其他，跟单主管=唐惠迪
2）若生产类别≠男鞋/女鞋/鞋类其他，跟单主管=朱晓华*/
/*20230506  需求变更，鞋包跟着组织架构走*/
 begin
   merge into scmdata.t_supplier_trial_order_report tka
   using (select tb.order_report_id, tb.supplier_code, tb.company_id,
       listagg(distinct user_id, ';') within group(order by user_id) follower_leader
  from (select ta.order_report_id, ta.supplier_code, ta.company_id, ta.classification, sa.coop_product_cate, e.user_id
              /* (case
                 when ta.classification = '08' then
                  (case when sa.coop_product_cate = '111' or sa.coop_product_cate = '113' or sa.coop_product_cate = '114' then
                        'c61e7606e8109240e0531164a8c0e03e'
                        when sa.coop_product_cate <> '111' and sa.coop_product_cate <> '113' and sa.coop_product_cate <> '114' then
                        'b54e6b59656b0544e0533c281cac9880'
                    else 'c61e7606e8109240e0531164a8c0e03e;b54e6b59656b0544e0533c281cac9880'  end)
                 else
                  e.user_id
               end) user_id*/
          from (select t.supplier_code, t.supplier_info_id,t.order_report_id,t.company_id,
                       regexp_substr(t.classification, '[^;]+', 1, level) classification
                  from scmdata.t_supplier_trial_order_report t
                 where instr(t.classification, '08') > 0
                connect by prior t.order_report_id = t.order_report_id
                       and level <=
                           length(t.classification) -
                           length(regexp_replace(t.classification, ';', '')) + 1
                       and prior dbms_random.value is not null) ta
         inner join scmdata.t_coop_scope sa
            on sa.company_id = ta.company_id
           and sa.supplier_info_id = ta.supplier_info_id
           and sa.coop_classification = ta.classification
           and sa.pause = '0'
          left join (select a.company_user_name,a.user_id,a.company_id, c.dept_name,e1.cooperation_classification,d.job_name
                      from scmdata.sys_company_user a
                      left join scmdata.sys_company_user_dept b
                        on a.user_id = b.user_id
                       and a.company_id = b.company_id
                      left join scmdata.sys_company_dept c
                        on b.company_dept_id = c.company_dept_id
                      left join scmdata.sys_company_dept_cate_map e1
                        on c.company_id = e1.company_id
                       and c.company_dept_id = e1.company_dept_id
                      left join scmdata.sys_company_job d
                        on a.job_id = d.job_id
                       and a.company_id = d.company_id
                     where a.pause = '0'
                       and d.job_name = '跟单主管'
                       and c.dept_name <> '跟单共享组'
                       and e1.cooperation_classification is not null) e
            on e.company_id = ta.company_id
           and e.cooperation_classification = ta.classification) tb
 group by tb.order_report_id, tb.supplier_code, tb.company_id) tkb
   on (tka.company_id = tkb.company_id and tka.supplier_code = tkb.supplier_code and tka.order_report_id = tkb.order_report_id)
   when matched then
     update
        set tka.follower_leader = tkb.follower_leader,
            tka.update_id   = 'ADMIN',
            tka.update_time = sysdate;
 end;

/*2022-07-05 新优化、供应商“合作分类”含‘淘品’的，根据供应商合作范围中‘启用’的生产类别判断获取：
1）若生产类别=首饰/发饰，跟单主管=庄志聪
2）若生产类别≠首饰/发饰，跟单主管=易茂春*/
 begin
   merge into scmdata.t_supplier_trial_order_report tka
   using (select tb.order_report_id, tb.supplier_code, tb.company_id,
       listagg(distinct user_id, ';') within group(order by user_id) follower_leader
  from (select ta.order_report_id, ta.supplier_code, ta.company_id, ta.classification, sa.coop_product_cate,
               (case
                 when ta.classification = '07' then
                  (case when sa.coop_product_cate = '0707' or sa.coop_product_cate = '0703'  then
                        'c4c905015ddc5134e0531164a8c0b0db'
                        when sa.coop_product_cate <> '0707' and sa.coop_product_cate <> '0703'  then
                        'c6a7c675c9993c96e0531164a8c03c39'
                    else 'c4c905015ddc5134e0531164a8c0b0db;c6a7c675c9993c96e0531164a8c03c39'  end)
                 else
                  e.user_id
               end) user_id
          from (select t.supplier_code, t.supplier_info_id,t.order_report_id,t.company_id,
                       regexp_substr(t.classification, '[^;]+', 1, level) classification
                  from scmdata.t_supplier_trial_order_report t
                 where instr(t.classification, '07') > 0
                connect by prior t.order_report_id = t.order_report_id
                       and level <=
                           length(t.classification) -
                           length(regexp_replace(t.classification, ';', '')) + 1
                       and prior dbms_random.value is not null) ta
         inner join scmdata.t_coop_scope sa
            on sa.company_id = ta.company_id
           and sa.supplier_info_id = ta.supplier_info_id
           and sa.coop_classification = ta.classification
           and sa.pause = '0'
          left join (select a.company_user_name,a.user_id,a.company_id, c.dept_name,e1.cooperation_classification,d.job_name
                      from scmdata.sys_company_user a
                      left join scmdata.sys_company_user_dept b
                        on a.user_id = b.user_id
                       and a.company_id = b.company_id
                      left join scmdata.sys_company_dept c
                        on b.company_dept_id = c.company_dept_id
                      left join scmdata.sys_company_dept_cate_map e1
                        on c.company_id = e1.company_id
                       and c.company_dept_id = e1.company_dept_id
                      left join scmdata.sys_company_job d
                        on a.job_id = d.job_id
                       and a.company_id = d.company_id
                     where a.pause = '0'
                       and d.job_name = '跟单主管'
                       and c.dept_name <> '跟单共享组'
                       and e1.cooperation_classification is not null) e
            on e.company_id = ta.company_id
           and e.cooperation_classification = ta.classification) tb
 group by tb.order_report_id, tb.supplier_code, tb.company_id) tkb
   on (tka.company_id = tkb.company_id and tka.supplier_code = tkb.supplier_code and tka.order_report_id = tkb.order_report_id)
   when matched then
     update
        set tka.follower_leader = tkb.follower_leader,
            tka.update_id   = 'ADMIN',
            tka.update_time = sysdate;
 end;
 end p_supplier_trial_order_report;

---旧版，作废
/*定时每天9点推送信息到个人企微*/
  procedure p_supplier_trial_send_wx is
    v_content       clob;
    v_user_id       varchar2(128);
    ---v_supplier_name varchar2(2000);
    v_company_id    varchar2(32);
  begin
    /*QC、跟单未维护场景*/
    /*1.试单未结束tab页*/
    --(1)首次试单供应商到期
    ----发送对象：评估专员
    for i in (select t.supplier_company_abbreviation, t.company_id
                from scmdata.t_supplier_trial_order_report t
               where t.trial_order_end_date =
                     to_date(to_char(sysdate, 'yyyy-mm-dd'), 'yyyy-mm-dd')
                 and t.statu = '2'
                 and t.trial_results is null) loop
      for ie in (select distinct cu.user_id
                   from scmdata.sys_company_user cu
                  where cu.inner_user_id in ('JML26', 'TQQ53')) loop
        v_content    := '您好!' || i.supplier_company_abbreviation ||
                        '试单到期了，请您及时跟进跟单主管/QC主管的建议。';
        v_user_id    := ie.user_id;
        v_company_id := i.company_id;
        scmdata.pkg_send_wx_msg.p_send_com_person_wx_msg(p_company_id => v_company_id,
                                                         p_user_id    => v_user_id,
                                                         p_content    => v_content);
      end loop;
      --(1)首次试单供应商到期
      ----发送对象：跟单主管
      for i in (select t.supplier_company_abbreviation,
                       t.company_id,
                       regexp_substr(t.follower_leader, '[^;]+', 1, level) follower_leader
                  from scmdata.t_supplier_trial_order_report t
                 where t.trial_order_end_date =
                       to_date(to_char(sysdate, 'yyyy-mm-dd'), 'yyyy-mm-dd')
                   and t.statu = '2'
                   and t.trial_results is null
                connect by prior t.order_report_id = t.order_report_id
                       and level <=
                           length(t.follower_leader) -
                           length(regexp_replace(t.follower_leader, ';', '')) + 1
                       and prior dbms_random.value is not null) loop
        v_content    := '您好!' || i.supplier_company_abbreviation ||
                        '试单到期了，请您前往【供应商试单跟进表】试单未结束tab页中及时给予试单建议。';
        v_user_id    := i.follower_leader;
        v_company_id := i.company_id;
        scmdata.pkg_send_wx_msg.p_send_com_person_wx_msg(p_company_id => v_company_id,
                                                         p_user_id    => v_user_id,
                                                         p_content    => v_content);
      end loop;
      --(1)首次试单供应商到期
      ---发送对象：QC主管
      for i in (select t.supplier_company_abbreviation,
                       t.company_id,
                       regexp_substr(t.qc_leader, '[^;]+', 1, level) qc_leader
                  from scmdata.t_supplier_trial_order_report t
                 where t.trial_order_end_date =
                       to_date(to_char(sysdate, 'yyyy-mm-dd'), 'yyyy-mm-dd')
                   and t.statu = '2'
                   and t.trial_results is null
                connect by prior t.order_report_id = t.order_report_id
                       and level <=
                           length(t.qc_leader) -
                           length(regexp_replace(t.qc_leader, ';', '')) + 1
                       and prior dbms_random.value is not null) loop
        v_content    := '您好!' || i.supplier_company_abbreviation ||
                        '试单到期了，请您前往【供应商试单跟进表】试单未结束tab页中及时给予试单建议。';
        v_user_id    := i.qc_leader;
        v_company_id := i.company_id;
        scmdata.pkg_send_wx_msg.p_send_com_person_wx_msg(p_company_id => v_company_id,
                                                         p_user_id    => v_user_id,
                                                         p_content    => v_content);
      end loop;
    end loop;

    --(2)试单供应商到期3天
    ----发送对象：评估专员
    for i in (select t.supplier_company_abbreviation, t.company_id
                from scmdata.t_supplier_trial_order_report t
               where to_date(to_char(sysdate, 'yyyy-mm-dd'), 'yyyy-mm-dd') -
                     t.trial_order_end_date = 3
                 and t.statu = '2'
                 and t.trial_results is null
                 and (t.follower_leader_suggest is null or
                      t.qc_leader_suggest is null)) loop
      for ie in (select distinct cu.user_id
                   from scmdata.sys_company_user cu
                  where cu.inner_user_id in ('JML26', 'TQQ53')) loop
        v_content    := '您好!' || i.supplier_company_abbreviation ||
                        '试单已到期3天，请您及时跟进跟单主管/QC主管的建议。';
        v_user_id    := ie.user_id;
        v_company_id := i.company_id;
        scmdata.pkg_send_wx_msg.p_send_com_person_wx_msg(p_company_id => v_company_id,
                                                         p_user_id    => v_user_id,
                                                         p_content    => v_content);
      end loop;
    end loop;
    --(2)试单供应商到期3天
    ----发送对象：跟单主管
    for i in (select t.supplier_company_abbreviation,
                     t.company_id,
                     regexp_substr(t.follower_leader, '[^;]+', 1, level) follower_leader
                from scmdata.t_supplier_trial_order_report t
               where to_date(to_char(sysdate, 'yyyy-mm-dd'), 'yyyy-mm-dd') -
                     t.trial_order_end_date = 3
                 and t.statu = 2
                 and t.trial_results is null
                 and t.follower_leader_suggest is null
              connect by prior t.order_report_id = t.order_report_id
                     and level <=
                         length(t.follower_leader) -
                         length(regexp_replace(t.follower_leader, ';', '')) + 1
                     and prior dbms_random.value is not null) loop
      v_content    := '您好!' || i.supplier_company_abbreviation ||
                      '试单已到期3天，请您前往【供应商试单跟进表】试单未结束tab页中及时给予试单建议。';
      v_user_id    := i.follower_leader;
      v_company_id := i.company_id;
      scmdata.pkg_send_wx_msg.p_send_com_person_wx_msg(p_company_id => v_company_id,
                                                       p_user_id    => v_user_id,
                                                       p_content    => v_content);
    end loop;
    --(2)试单供应商到期3天
    ----发送对象：QC主管
    for i in (select t.supplier_company_abbreviation,
                     t.company_id,
                     regexp_substr(t.qc_leader, '[^;]+', 1, level) qc_leader
                from scmdata.t_supplier_trial_order_report t
               where to_date(to_char(sysdate, 'yyyy-mm-dd'), 'yyyy-mm-dd') -
                     t.trial_order_end_date = 3
                 and t.statu = 2
                 and t.trial_results is null
                 and t.qc_leader_suggest is null
              connect by prior t.order_report_id = t.order_report_id
                     and level <=
                         length(t.qc_leader) -
                         length(regexp_replace(t.qc_leader, ';', '')) + 1
                     and prior dbms_random.value is not null) loop
      v_content    := '您好!' || i.supplier_company_abbreviation ||
                      '试单已到期3天，请您前往【供应商试单跟进表】试单未结束tab页中及时给予试单建议。';
      v_user_id    := i.qc_leader;
      v_company_id := i.company_id;
      scmdata.pkg_send_wx_msg.p_send_com_person_wx_msg(p_company_id => v_company_id,
                                                       p_user_id    => v_user_id,
                                                       p_content    => v_content);
    end loop;
    /*2.继续试单tab页*/
    --(1)首次试单供应商到期
    ----发送对象：评估专员
    for i in (select t.supplier_company_abbreviation, t.company_id
                from scmdata.t_supplier_trial_order_report t
               where to_date(to_char(t.end_date, 'yyyy-mm-dd'), 'yyyy-mm-dd') =
                     to_date(to_char(sysdate, 'yyyy-mm-dd'), 'yyyy-mm-dd')
                 and t.statu = 2
                 and t.trial_results = 2) loop
      for ie in (select distinct cu.user_id
                   from scmdata.sys_company_user cu
                  where cu.inner_user_id in ('JML26', 'TQQ53')) loop
        v_content    := '您好!' || i.supplier_company_abbreviation ||
                        '试单到期了，请您及时跟进跟单主管/QC主管的建议。';
        v_user_id    := ie.user_id;
        v_company_id := i.company_id;
        scmdata.pkg_send_wx_msg.p_send_com_person_wx_msg(p_company_id => v_company_id,
                                                         p_user_id    => v_user_id,
                                                         p_content    => v_content);
      end loop;
    end loop;
    --(1)首次试单供应商到期
    ----发送对象：跟单主管
    for i in (select t.supplier_company_abbreviation,
                     t.company_id,
                     regexp_substr(t.follower_leader, '[^;]+', 1, level) follower_leader
                from scmdata.t_supplier_trial_order_report t
               where to_date(to_char(t.end_date, 'yyyy-mm-dd'), 'yyyy-mm-dd') =
                     to_date(to_char(sysdate, 'yyyy-mm-dd'), 'yyyy-mm-dd')
                 and t.statu = 2
                 and t.trial_results = 2
              connect by prior t.order_report_id = t.order_report_id
                     and level <=
                         length(t.follower_leader) -
                         length(regexp_replace(t.follower_leader, ';', '')) + 1
                     and prior dbms_random.value is not null) loop
      v_content    := '您好!' || i.supplier_company_abbreviation ||
                      '试单到期了，请您前往【供应商试单跟进表】继续试单tab页中及时给予试单建议。';
      v_user_id    := i.follower_leader;
      v_company_id := i.company_id;
      scmdata.pkg_send_wx_msg.p_send_com_person_wx_msg(p_company_id => v_company_id,
                                                       p_user_id    => v_user_id,
                                                       p_content    => v_content);
    end loop;
    --(1)首次试单供应商到期
    ----发送对象：QC主管
    for i in (select t.supplier_company_abbreviation,
                     t.company_id,
                     regexp_substr(t.qc_leader, '[^;]+', 1, level) qc_leader
                from scmdata.t_supplier_trial_order_report t
               where to_date(to_char(t.end_date, 'yyyy-mm-dd'), 'yyyy-mm-dd') =
                     to_date(to_char(sysdate, 'yyyy-mm-dd'), 'yyyy-mm-dd')
                 and t.statu = 2
                 and t.trial_results = 2
              connect by prior t.order_report_id = t.order_report_id
                     and level <=
                         length(t.qc_leader) -
                         length(regexp_replace(t.qc_leader, ';', '')) + 1
                     and prior dbms_random.value is not null) loop
      v_content    := '您好!' || i.supplier_company_abbreviation ||
                      '试单到期了，请您前往【供应商试单跟进表】继续试单tab页中及时给予试单建议。';
      v_user_id    := i.qc_leader;
      v_company_id := i.company_id;
      scmdata.pkg_send_wx_msg.p_send_com_person_wx_msg(p_company_id => v_company_id,
                                                       p_user_id    => v_user_id,
                                                       p_content    => v_content);
    end loop;
    --(2)试单供应商到期3天
    ----发送对象：评估专员
    for i in (select t.supplier_company_abbreviation, t.company_id
                from scmdata.t_supplier_trial_order_report t
               where to_date(to_char(sysdate, 'yyyy-mm-dd'), 'yyyy-mm-dd') -
                     to_date(to_char(t.end_date, 'yyyy-mm-dd'), 'yyyy-mm-dd') = 3
                 and t.statu = 2
                 and t.trial_results = 2
                 and (t.follower_leader_suggest is null or
                      t.qc_leader_suggest is null)) loop
      for ie in (select distinct cu.user_id
                   from scmdata.sys_company_user cu
                  where cu.inner_user_id in ('JML26', 'TQQ53')) loop
        v_content    := '您好!' || i.supplier_company_abbreviation ||
                        '试单已到期3天，请您及时跟进跟单主管/QC主管的建议。';
        v_user_id    := ie.user_id;
        v_company_id := i.company_id;
        scmdata.pkg_send_wx_msg.p_send_com_person_wx_msg(p_company_id => v_company_id,
                                                         p_user_id    => v_user_id,
                                                         p_content    => v_content);
      end loop;
    end loop;
    --(2)试单供应商到期3天
    ----发送对象：跟单主管
    for i in (select t.supplier_company_abbreviation,
                     t.company_id,
                     regexp_substr(t.follower_leader, '[^;]+', 1, level) follower_leader
                from scmdata.t_supplier_trial_order_report t
               where to_date(to_char(sysdate, 'yyyy-mm-dd'), 'yyyy-mm-dd') -
                     to_date(to_char(t.end_date, 'yyyy-mm-dd'), 'yyyy-mm-dd') = 3
                 and t.statu = 2
                 and t.trial_results = 2
                 and t.follower_leader_suggest is null
              connect by prior t.order_report_id = t.order_report_id
                     and level <=
                         length(t.follower_leader) -
                         length(regexp_replace(t.follower_leader, ';', '')) + 1
                     and prior dbms_random.value is not null) loop
      v_content    := '您好!' || i.supplier_company_abbreviation ||
                      '试单已到期3天，请您前往【供应商试单跟进表】继续试单tab页中及时给予试单建议。';
      v_user_id    := i.follower_leader;
      v_company_id := i.company_id;
      scmdata.pkg_send_wx_msg.p_send_com_person_wx_msg(p_company_id => v_company_id,
                                                       p_user_id    => v_user_id,
                                                       p_content    => v_content);
    end loop;
    --(2)试单供应商到期3天
    -----发送对象：QC主管
    for i in (select t.supplier_company_abbreviation,
                     t.company_id,
                     regexp_substr(t.qc_leader, '[^;]+', 1, level) qc_leader
                from scmdata.t_supplier_trial_order_report t
               where to_date(to_char(sysdate, 'yyyy-mm-dd'), 'yyyy-mm-dd') -
                     to_date(to_char(t.end_date, 'yyyy-mm-dd'), 'yyyy-mm-dd') = 3
                 and t.statu = 2
                 and t.trial_results is null
                 and t.qc_leader_suggest is null
              connect by prior t.order_report_id = t.order_report_id
                     and level <=
                         length(t.qc_leader) -
                         length(regexp_replace(t.qc_leader, ';', '')) + 1
                     and prior dbms_random.value is not null) loop
      v_content    := '您好!' || i.supplier_company_abbreviation ||
                      '试单已到期3天，请您前往【供应商试单跟进表】继续试单tab页中及时给予试单建议。';
      v_user_id    := i.qc_leader;
      v_company_id := i.company_id;
      scmdata.pkg_send_wx_msg.p_send_com_person_wx_msg(p_company_id => v_company_id,
                                                       p_user_id    => v_user_id,
                                                       p_content    => v_content);
    end loop;

    /* 当QC、跟单维护完的场景*/
    --试单未结束tab页
    --(1)首次推送给供应商管理部经理
    ----发送对象：评估专员
    for i in (select t.supplier_company_abbreviation, t.company_id
                from scmdata.t_supplier_trial_order_report t
               where t.trial_order_end_date =
                     to_date(to_char(sysdate, 'yyyy-mm-dd'), 'yyyy-mm-dd')
                 and t.statu = 2
                 and t.trial_results is null
                 and t.follower_review_time is not null
                 and t.qc_review_time is not null) loop
      for ie in (select distinct cu.user_id
                   from scmdata.sys_company_user cu
                  where cu.inner_user_id in ('JML26', 'TQQ53')) loop
        v_content    := '您好!' || i.supplier_company_abbreviation ||
                        '待试单审核，请您及时跟进审核情况。';
        v_user_id    := ie.user_id;
        v_company_id := i.company_id;
        scmdata.pkg_send_wx_msg.p_send_com_person_wx_msg(p_company_id => v_company_id,
                                                         p_user_id    => v_user_id,
                                                         p_content    => v_content);
      end loop;
    end loop;
    --(1)首次推送给供应商管理部经理
    ----发送对象：供应商管理部经理
    for i in (select t.supplier_company_abbreviation, t.company_id
                from scmdata.t_supplier_trial_order_report t
               where t.trial_order_end_date =
                     to_date(to_char(sysdate, 'yyyy-mm-dd'), 'yyyy-mm-dd')
                 and t.statu = 2
                 and t.trial_results is null
                 and t.follower_review_time is not null
                 and t.qc_review_time is not null) loop
      select distinct cu.user_id
        into v_user_id
        from scmdata.sys_company_user cu
       where cu.inner_user_id = 'LHB19';
      v_content    := '您好!' || i.supplier_company_abbreviation ||
                      '待试单审核，请您前往【供应商试单跟进表】试单未结束tab页中及时审核。';
      v_company_id := i.company_id;
      scmdata.pkg_send_wx_msg.p_send_com_person_wx_msg(p_company_id => v_company_id,
                                                       p_user_id    => v_user_id,
                                                       p_content    => v_content);
    end loop;
    --(2)首次推送给供应商管理部经理3天后
    ----发送对象：评估专员
    for i in (select t.supplier_company_abbreviation, t.company_id
                from scmdata.t_supplier_trial_order_report t
               where to_date(to_char(sysdate, 'yyyy-mm-dd'), 'yyyy-mm-dd') -
                     t.trial_order_end_date = 3
                 and t.statu = 2
                 and t.trial_results is null
                 and t.follower_review_time is not null
                 and t.qc_review_time is not null) loop
      for ie in (select distinct cu.user_id
                   from scmdata.sys_company_user cu
                  where cu.inner_user_id in ('JML26', 'TQQ53')) loop
        v_content    := '您好!' || i.supplier_company_abbreviation ||
                        '待试单审核（跟单主管和QC主管已给予试单建议后第3天），请您及时跟进审核情况。';
        v_user_id    := ie.user_id;
        v_company_id := i.company_id;
        scmdata.pkg_send_wx_msg.p_send_com_person_wx_msg(p_company_id => v_company_id,
                                                         p_user_id    => v_user_id,
                                                         p_content    => v_content);
      end loop;
    end loop;
    --(2)首次推送给供应商管理部经理3天后
    ----发送对象：供应商管理部经理
    for i in (select t.supplier_company_abbreviation, t.company_id
                from scmdata.t_supplier_trial_order_report t
               where to_date(to_char(sysdate, 'yyyy-mm-dd'), 'yyyy-mm-dd') -
                     t.trial_order_end_date = 3
                 and t.statu = 2
                 and t.trial_results is null
                 and t.follower_review_time is not null
                 and t.qc_review_time is not null) loop
      select distinct cu.user_id
        into v_user_id
        from scmdata.sys_company_user cu
       where cu.inner_user_id = 'LHB19';
      v_content    := '您好!' || i.supplier_company_abbreviation ||
                      '待试单审核，请您前往【供应商试单跟进表】试单未结束tab页中及时审核。';
      v_company_id := i.company_id;
      scmdata.pkg_send_wx_msg.p_send_com_person_wx_msg(p_company_id => v_company_id,
                                                       p_user_id    => v_user_id,
                                                       p_content    => v_content);
    end loop;

    --继续试单tab页
    --(1)首次推送给供应商管理部经理
    ----发送对象：评估专员
    for i in (select t.supplier_company_abbreviation, t.company_id
                from scmdata.t_supplier_trial_order_report t
               where to_date(to_char(t.end_date, 'yyyy-mm-dd'), 'yyyy-mm-dd') =
                     to_date(to_char(sysdate, 'yyyy-mm-dd'), 'yyyy-mm-dd')
                 and t.statu = 2
                 and t.trial_results = 2
                 and t.follower_review_time is not null
                 and t.qc_review_time is not null) loop
      for ie in (select distinct cu.user_id
                   from scmdata.sys_company_user cu
                  where cu.inner_user_id in ('JML26', 'TQQ53')) loop
        v_content    := '您好!' || i.supplier_company_abbreviation ||
                        '待试单审核，请您及时跟进审核情况。';
        v_user_id    := ie.user_id;
        v_company_id := i.company_id;
        scmdata.pkg_send_wx_msg.p_send_com_person_wx_msg(p_company_id => v_company_id,
                                                         p_user_id    => v_user_id,
                                                         p_content    => v_content);
      end loop;
    end loop;
    --(1)首次推送给供应商管理部经理
    ----发送对象：供应商管理部经理
    for i in (select t.supplier_company_abbreviation, t.company_id
                from scmdata.t_supplier_trial_order_report t
               where to_date(to_char(t.end_date, 'yyyy-mm-dd'), 'yyyy-mm-dd') =
                     to_date(to_char(sysdate, 'yyyy-mm-dd'), 'yyyy-mm-dd')
                 and t.statu = 2
                 and t.trial_results = 2
                 and t.follower_review_time is not null
                 and t.qc_review_time is not null) loop
      select distinct cu.user_id
        into v_user_id
        from scmdata.sys_company_user cu
       where cu.inner_user_id = 'LHB19';
      v_content    := '您好!' || i.supplier_company_abbreviation ||
                      '待试单审核，请您前往【供应商试单跟进表】继续试单tab页中及时审核。';
      v_company_id := i.company_id;
      scmdata.pkg_send_wx_msg.p_send_com_person_wx_msg(p_company_id => v_company_id,
                                                       p_user_id    => v_user_id,
                                                       p_content    => v_content);
    end loop;

    --(2)首次推送给供应商管理部经理3天后
    ----发送对象：评估专员
    for i in (select t.supplier_company_abbreviation, t.company_id
                from scmdata.t_supplier_trial_order_report t
               where to_date(to_char(sysdate, 'yyyy-mm-dd'), 'yyyy-mm-dd') -
                     to_date(to_char(t.end_date, 'yyyy-mm-dd'), 'yyyy-mm-dd') = 3
                 and t.statu = 2
                 and t.trial_results = 2
                 and t.follower_review_time is not null
                 and t.qc_review_time is not null) loop
      for ie in (select distinct cu.user_id
                   from scmdata.sys_company_user cu
                  where cu.inner_user_id in ('JML26', 'TQQ53')) loop
        v_content    := '您好!' || i.supplier_company_abbreviation ||
                        '待试单审核（跟单主管和QC主管已给予试单建议后第3天），请您及时跟进审核情况。';
        v_user_id    := ie.user_id;
        v_company_id := i.company_id;
        scmdata.pkg_send_wx_msg.p_send_com_person_wx_msg(p_company_id => v_company_id,
                                                         p_user_id    => v_user_id,
                                                         p_content    => v_content);
      end loop;
    end loop;
    --(2)首次推送给供应商管理部经理3天后
    ----发送对象：供应商管理部经理
    for i in (select t.supplier_company_abbreviation, t.company_id
                from scmdata.t_supplier_trial_order_report t
               where to_date(to_char(sysdate, 'yyyy-mm-dd'), 'yyyy-mm-dd') -
                     to_date(to_char(t.end_date, 'yyyy-mm-dd'), 'yyyy-mm-dd') = 3
                 and t.statu = 2
                 and t.trial_results = 2
                 and t.follower_review_time is not null
                 and t.qc_review_time is not null) loop
      select distinct cu.user_id
        into v_user_id
        from scmdata.sys_company_user cu
       where cu.inner_user_id = 'LHB19';
      v_content    := '您好!' || i.supplier_company_abbreviation ||
                      '待试单审核，请您前往【供应商试单跟进表】继续试单tab页中及时审核。';
      v_company_id := i.company_id;
      scmdata.pkg_send_wx_msg.p_send_com_person_wx_msg(p_company_id => v_company_id,
                                                       p_user_id    => v_user_id,
                                                       p_content    => v_content);
    end loop;
  end p_supplier_trial_send_wx;

/*场景一、QC、跟单未维护场景
    1.v_type = 1 首次试单供应商到期
      v_type = 2 试单供应商到期3天后
    2.v_type2 = 301 试单未结束tab页
      v_type2 = 302 继续试单tab页  */
procedure p_supplier_trial_first_send_wx1(v_supplier varchar2,v_id varchar2,v_type number,v_type2 number) is
  --v_content    clob;
  v_user_id    varchar2(128);
  v_company_id varchar2(32);
  p_supplier   varchar2(128);
begin
/*v_type = 1 首次试单供应商到期*/
if v_type = 1 then
/*v_type2 = 301 试单未结束tab页*/
   if v_type2 = '301' then
   ----发送对象：评估专员
    for ie in (select distinct cu.user_id
                 from scmdata.sys_company_user cu
                where cu.inner_user_id in ('JML26', 'TQQ53')) loop
      /*v_content    := '<SCM系统消息>您好!' || v_supplier ||
                      '试单到期了，请您及时跟进跟单主管/QC主管的建议。';*/
      v_user_id    := ie.user_id;
      v_company_id := v_id;
      scmdata.pkg_send_wx_msg.p_cache_wecom_msg_pattern(p_company_id     => v_company_id,
                                                        p_param          => v_supplier,
                                                        p_target_user_id => v_user_id,
                                                        p_pattern_code   => 'ASSESSOR_01_MSG');
     /* scmdata.pkg_send_wx_msg.p_send_com_person_wx_msg(p_company_id => v_company_id,
                                                       p_user_id    => v_user_id,
                                                       p_content    => v_content);*/
    end loop;
    ----发送对象：跟单主管
    for i in (select t.supplier_company_abbreviation,
                     t.company_id,
                     regexp_substr(t.follower_leader, '[^;]+', 1, level) follower_leader
                from scmdata.t_supplier_trial_order_report t
               where t.supplier_company_abbreviation = v_supplier
                 and t.company_id = v_id
              connect by prior t.order_report_id = t.order_report_id
                     and level <=
                         length(t.follower_leader) -
                         length(regexp_replace(t.follower_leader, ';', '')) + 1
                     and prior dbms_random.value is not null) loop
   if i.follower_leader is not null then
      /*v_content    := '<SCM系统消息>您好!' || v_supplier ||
                      '试单到期了，请您前往【供应商试单跟进表】试单未结束tab页中及时给予试单建议。';*/
      v_user_id    := i.follower_leader;
      v_company_id := v_id;
      scmdata.pkg_send_wx_msg.p_cache_wecom_msg_pattern(p_company_id     => v_company_id,
                                                        p_param          => v_supplier,
                                                        p_target_user_id => v_user_id,
                                                        p_pattern_code   => 'QC_FOLLOWER_01_MSG');
      /*scmdata.pkg_send_wx_msg.p_send_com_person_wx_msg(p_company_id => v_company_id,
                                                       p_user_id    => v_user_id,
                                                       p_content    => v_content);*/
   end if;
    end loop;
    ---发送对象：QC主管
    for i in (select t.supplier_company_abbreviation,
                     t.company_id,
                     regexp_substr(t.qc_leader, '[^;]+', 1, level) qc_leader
                from scmdata.t_supplier_trial_order_report t
               where t.supplier_company_abbreviation = v_supplier
                 and t.company_id = v_id
              connect by prior t.order_report_id = t.order_report_id
                     and level <=
                         length(t.qc_leader) -
                         length(regexp_replace(t.qc_leader, ';', '')) + 1
                     and prior dbms_random.value is not null) loop
     if i.qc_leader is not null then
      /*v_content    := '<SCM系统消息>您好!' || v_supplier ||
                      '试单到期了，请您前往【供应商试单跟进表】试单未结束tab页中及时给予试单建议。';*/
      v_user_id    := i.qc_leader;
      v_company_id := v_id;
      scmdata.pkg_send_wx_msg.p_cache_wecom_msg_pattern(p_company_id     => v_company_id,
                                                        p_param          => v_supplier,
                                                        p_target_user_id => v_user_id,
                                                        p_pattern_code   => 'QC_FOLLOWER_01_MSG');
      /*scmdata.pkg_send_wx_msg.p_send_com_person_wx_msg(p_company_id => v_company_id,
                                                       p_user_id    => v_user_id,
                                                       p_content    => v_content);*/
     end if;
  end loop;
/*v_type2 = 302 继续试单tab页*/
   elsif v_type2 = '302' then
 ----发送对象：评估专员
      for ie in (select distinct cu.user_id
                     from scmdata.sys_company_user cu
                    where cu.inner_user_id in ('JML26', 'TQQ53')) loop
        /*  v_content    := '<SCM系统消息>您好!' || v_supplier ||
                          '试单到期了，请您及时跟进跟单主管/QC主管的建议。';*/
          v_user_id    := ie.user_id;
          v_company_id := v_id;
          scmdata.pkg_send_wx_msg.p_cache_wecom_msg_pattern(p_company_id     => v_company_id,
                                                            p_param          => v_supplier,
                                                            p_target_user_id => v_user_id,
                                                            p_pattern_code   => 'ASSESSOR_01_MSG');
/*          scmdata.pkg_send_wx_msg.p_send_com_person_wx_msg(p_company_id => v_company_id,
                                                           p_user_id    => v_user_id,
                                                           p_content    => v_content);*/
      end loop;
  ----发送对象：跟单主管
      for i in (select t.supplier_company_abbreviation,
                       t.company_id,
                       regexp_substr(t.follower_leader, '[^;]+', 1, level) follower_leader
                  from scmdata.t_supplier_trial_order_report t
                 where t.supplier_company_abbreviation = v_supplier
                   and t.company_id = v_id
                connect by prior t.order_report_id = t.order_report_id
                       and level <=
                           length(t.follower_leader) -
                           length(regexp_replace(t.follower_leader, ';', '')) + 1
                       and prior dbms_random.value is not null) loop
   if i.follower_leader is not null then
        /*v_content    := '<SCM系统消息>您好!' || v_supplier ||
                        '试单到期了，请您前往【供应商试单跟进表】继续试单tab页中及时给予试单建议。';*/
        v_user_id    := i.follower_leader;
        v_company_id := v_id;
        scmdata.pkg_send_wx_msg.p_cache_wecom_msg_pattern(p_company_id     => v_company_id,
                                                          p_param          => v_supplier,
                                                          p_target_user_id => v_user_id,
                                                          p_pattern_code   => 'QC_FOLLOWER_WX_01_MSG');
        /*scmdata.pkg_send_wx_msg.p_send_com_person_wx_msg(p_company_id => v_company_id,
                                                         p_user_id    => v_user_id,
                                                         p_content    => v_content);*/
   end if;
      end loop;
  ----发送对象：QC主管
      for i in (select t.supplier_company_abbreviation,
                       t.company_id,
                       regexp_substr(t.qc_leader, '[^;]+', 1, level) qc_leader
                  from scmdata.t_supplier_trial_order_report t
                 where t.supplier_company_abbreviation = v_supplier
                   and t.company_id = v_id
                connect by prior t.order_report_id = t.order_report_id
                       and level <=
                           length(t.qc_leader) -
                           length(regexp_replace(t.qc_leader, ';', '')) + 1
                       and prior dbms_random.value is not null) loop
   if i.qc_leader is not null then
        /*v_content    := '<SCM系统消息>您好!' || v_supplier ||
                        '试单到期了，请您前往【供应商试单跟进表】继续试单tab页中及时给予试单建议。';*/
        v_user_id    := i.qc_leader;
        v_company_id := v_id;
        scmdata.pkg_send_wx_msg.p_cache_wecom_msg_pattern(p_company_id     => v_company_id,
                                                          p_param          => v_supplier,
                                                          p_target_user_id => v_user_id,
                                                          p_pattern_code   => 'QC_FOLLOWER_WX_01_MSG');
        /*scmdata.pkg_send_wx_msg.p_send_com_person_wx_msg(p_company_id => v_company_id,
                                                         p_user_id    => v_user_id,
                                                         p_content    => v_content);*/
   end if;
      end loop;
   end if;

/*v_type = 2 试单供应商到期3天后*/
elsif v_type = 2 then
/*v_type2 = 301 试单未结束tab页*/
   if v_type2 = '301' then
   ----发送对象：评估专员

    for ie in (select distinct cu.user_id
                 from scmdata.sys_company_user cu
                where cu.inner_user_id in ('JML26', 'TQQ53')) loop
       select max(t.supplier_company_abbreviation)
         into p_supplier
         from t_supplier_trial_order_report t
        where t.supplier_company_abbreviation = v_supplier
          and (t.follower_leader_suggest is null or t.qc_leader_suggest is null);
   if p_supplier is not null then
      /*v_content    := '<SCM系统消息>您好!' || p_supplier ||
                      '试单已到期3天，请您及时跟进跟单主管/QC主管的建议。';*/
      v_user_id    := ie.user_id;
      v_company_id := v_id;
      scmdata.pkg_send_wx_msg.p_cache_wecom_msg_pattern(p_company_id     => v_company_id,
                                                        p_param          => p_supplier,
                                                        p_target_user_id => v_user_id,
                                                        p_pattern_code   => 'ASSESSOR_02_MSG');
      /*scmdata.pkg_send_wx_msg.p_send_com_person_wx_msg(p_company_id => v_company_id,
                                                       p_user_id    => v_user_id,
                                                       p_content    => v_content);*/
  end if;
    end loop;
    ----发送对象：跟单主管

    for i in (select t.supplier_company_abbreviation,
                     t.company_id,
                     regexp_substr(t.follower_leader, '[^;]+', 1, level) follower_leader
                from scmdata.t_supplier_trial_order_report t
               where t.supplier_company_abbreviation = v_supplier
                 and t.company_id = v_id
              connect by prior t.order_report_id = t.order_report_id
                     and level <=
                         length(t.follower_leader) -
                         length(regexp_replace(t.follower_leader, ';', '')) + 1
                     and prior dbms_random.value is not null) loop
     if i.follower_leader is not null then
       select max(t.supplier_company_abbreviation)
         into p_supplier
         from t_supplier_trial_order_report t
        where t.supplier_company_abbreviation = v_supplier
          and t.follower_leader_suggest is null ;
       if p_supplier is not null then
          /*v_content    := '<SCM系统消息>您好!' || p_supplier ||
                          '试单已到期3天，请您前往【供应商试单跟进表】试单未结束tab页中及时给予试单建议。';*/
          v_user_id    := i.follower_leader;
          v_company_id := v_id;
          scmdata.pkg_send_wx_msg.p_cache_wecom_msg_pattern(p_company_id     => v_company_id,
                                                            p_param          => p_supplier,
                                                            p_target_user_id => v_user_id,
                                                            p_pattern_code   => 'QC_FOLLOWER_02_MSG');
        /*  scmdata.pkg_send_wx_msg.p_send_com_person_wx_msg(p_company_id => v_company_id,
                                                           p_user_id    => v_user_id,
                                                           p_content    => v_content);*/
        end if;
    end if;
    end loop;
    ---发送对象：QC主管
    for i in (select t.supplier_company_abbreviation,
                     t.company_id,
                     regexp_substr(t.qc_leader, '[^;]+', 1, level) qc_leader
                from scmdata.t_supplier_trial_order_report t
               where t.supplier_company_abbreviation = v_supplier
                 and t.company_id = v_id
              connect by prior t.order_report_id = t.order_report_id
                     and level <=
                         length(t.qc_leader) -
                         length(regexp_replace(t.qc_leader, ';', '')) + 1
                     and prior dbms_random.value is not null) loop
     if i.qc_leader is not null then
       select max(t.supplier_company_abbreviation)
         into p_supplier
         from t_supplier_trial_order_report t
        where t.supplier_company_abbreviation = v_supplier
          and t.qc_leader_suggest is null ;
         if p_supplier is not null then
            /*v_content    := '<SCM系统消息>您好!' || p_supplier ||
                            '试单已到期3天，请您前往【供应商试单跟进表】试单未结束tab页中及时给予试单建议。';*/
            v_user_id    := i.qc_leader;
            v_company_id := v_id;
            scmdata.pkg_send_wx_msg.p_cache_wecom_msg_pattern(p_company_id     => v_company_id,
                                                              p_param          => p_supplier,
                                                              p_target_user_id => v_user_id,
                                                              p_pattern_code   => 'QC_FOLLOWER_02_MSG');
            /*scmdata.pkg_send_wx_msg.p_send_com_person_wx_msg(p_company_id => v_company_id,
                                                             p_user_id    => v_user_id,
                                                             p_content    => v_content);*/
          end if;
    end if;
  end loop;

/*v_type2 = 302 继续试单tab页*/
   elsif v_type2 = '302' then
   ----发送对象：评估专员
    for ie in (select distinct cu.user_id
                 from scmdata.sys_company_user cu
                where cu.inner_user_id in ('JML26', 'TQQ53')) loop
       select max(t.supplier_company_abbreviation)
         into p_supplier
         from t_supplier_trial_order_report t
        where t.supplier_company_abbreviation = v_supplier
          and (t.follower_leader_suggest is null or t.qc_leader_suggest is null);
       if p_supplier is not null then
        /*v_content    := '<SCM系统消息>您好!' || p_supplier ||
                        '试单已到期3天，请您及时跟进跟单主管/QC主管的建议。';*/
        v_user_id    := ie.user_id;
        v_company_id := v_id;
        scmdata.pkg_send_wx_msg.p_cache_wecom_msg_pattern(p_company_id     => v_company_id,
                                                          p_param          => p_supplier,
                                                          p_target_user_id => v_user_id,
                                                          p_pattern_code   => 'ASSESSOR_02_MSG');
        /*scmdata.pkg_send_wx_msg.p_send_com_person_wx_msg(p_company_id => v_company_id,
                                                         p_user_id    => v_user_id,
                                                         p_content    => v_content);*/
       end if;
    end loop;
    ----发送对象：跟单主管
    for i in (select t.supplier_company_abbreviation,
                     t.company_id,
                     regexp_substr(t.follower_leader, '[^;]+', 1, level) follower_leader
                from scmdata.t_supplier_trial_order_report t
               where t.supplier_company_abbreviation = v_supplier
                 and t.company_id = v_id
              connect by prior t.order_report_id = t.order_report_id
                     and level <=
                         length(t.follower_leader) -
                         length(regexp_replace(t.follower_leader, ';', '')) + 1
                     and prior dbms_random.value is not null) loop
     if i.follower_leader is not null then
       select max(t.supplier_company_abbreviation)
         into p_supplier
         from t_supplier_trial_order_report t
        where t.supplier_company_abbreviation = v_supplier
          and t.follower_leader_suggest is null ;
         if p_supplier is not null then
            /*v_content    := '<SCM系统消息>您好!' || p_supplier ||
                            '试单已到期3天，请您前往【供应商试单跟进表】继续试单tab页中及时给予试单建议。';*/
            v_user_id    := i.follower_leader;
            v_company_id := v_id;
            scmdata.pkg_send_wx_msg.p_cache_wecom_msg_pattern(p_company_id     => v_company_id,
                                                              p_param          => p_supplier,
                                                              p_target_user_id => v_user_id,
                                                              p_pattern_code   => 'QC_FOLLOWER_WX_02_MSG');
            /*scmdata.pkg_send_wx_msg.p_send_com_person_wx_msg(p_company_id => v_company_id,
                                                             p_user_id    => v_user_id,
                                                             p_content    => v_content);*/
          end if;
    end if;
    end loop;
    ---发送对象：QC主管
    for i in (select t.supplier_company_abbreviation,
                     t.company_id,
                     regexp_substr(t.qc_leader, '[^;]+', 1, level) qc_leader
                from scmdata.t_supplier_trial_order_report t
               where t.supplier_company_abbreviation = v_supplier
                 and t.company_id = v_id
              connect by prior t.order_report_id = t.order_report_id
                     and level <=
                         length(t.qc_leader) -
                         length(regexp_replace(t.qc_leader, ';', '')) + 1
                     and prior dbms_random.value is not null) loop
     if i.qc_leader is not null then
       select max(t.supplier_company_abbreviation)
         into p_supplier
         from t_supplier_trial_order_report t
        where t.supplier_company_abbreviation = v_supplier
          and t.qc_leader_suggest is null ;
         if p_supplier is not null then
            /*v_content    := '<SCM系统消息>您好!' || p_supplier ||
                            '试单已到期3天，请您前往【供应商试单跟进表】继续试单tab页中及时给予试单建议。';*/
            v_user_id    := i.qc_leader;
            v_company_id := v_id;
            scmdata.pkg_send_wx_msg.p_cache_wecom_msg_pattern(p_company_id     => v_company_id,
                                                              p_param          => p_supplier,
                                                              p_target_user_id => v_user_id,
                                                              p_pattern_code   => 'QC_FOLLOWER_WX_02_MSG');
            /*scmdata.pkg_send_wx_msg.p_send_com_person_wx_msg(p_company_id => v_company_id,
                                                             p_user_id    => v_user_id,
                                                             p_content    => v_content);*/
         end if;
   end if;
  end loop;
   end if;

end if;
end p_supplier_trial_first_send_wx1;

/*场景二、QC、跟单完成维护推送信息跟供管场景
    1.v_type = 1 首次试单供应商到期
      v_type = 2 试单供应商到期3天后
    2.v_type2 = 301 试单未结束tab页
      v_type2 = 302 继续试单tab页 */
procedure p_supplier_trial_send_wx1(v_supplier varchar2,v_id varchar2,v_type number,v_type2 number) is
  ---v_content    clob;
  v_user_id    varchar2(128);
  v_company_id varchar2(32);
begin
/*v_type = 1 首次试单供应商到期*/
if v_type = 1 then
/*v_type2 = 301 试单未结束tab页*/
    if v_type2 = '301' then
  ----发送对象：评估专员
        for ie in (select distinct cu.user_id
                     from scmdata.sys_company_user cu
                    where cu.inner_user_id in ('JML26', 'TQQ53')) loop
          /*v_content    := '<SCM系统消息>您好!' || v_supplier ||
                          '待试单审核，请您及时跟进审核情况。';*/
          v_user_id    := ie.user_id;
          v_company_id := v_id;
          scmdata.pkg_send_wx_msg.p_cache_wecom_msg_pattern(p_company_id     => v_company_id,
                                                            p_param          => v_supplier,
                                                            p_target_user_id => v_user_id,
                                                            p_pattern_code   => 'ASSESSOR_03_MSG');
          /*scmdata.pkg_send_wx_msg.p_send_com_person_wx_msg(p_company_id => v_company_id,
                                                           p_user_id    => v_user_id,
                                                           p_content    => v_content);*/
        end loop;
  ----发送对象：供应商管理部经理
          select distinct cu.user_id
            into v_user_id
            from scmdata.sys_company_user cu
           where cu.inner_user_id = 'LHB19';
          /*v_content    := '<SCM系统消息>您好!' || v_supplier ||
                          '待试单审核，请您前往【供应商试单跟进表】试单未结束tab页中及时审核。';*/
          v_company_id := v_id;
          scmdata.pkg_send_wx_msg.p_cache_wecom_msg_pattern(p_company_id     => v_company_id,
                                                            p_param          => v_supplier,
                                                            p_target_user_id => v_user_id,
                                                            p_pattern_code   => 'MANAGER_01_MSG');
          /*scmdata.pkg_send_wx_msg.p_send_com_person_wx_msg(p_company_id => v_company_id,
                                                           p_user_id    => v_user_id,
                                                           p_content    => v_content);*/
/*v_type2 = 302 继续试单tab页*/
      elsif v_type2 = '302' then
  ----发送对象：评估专员
        for ie in (select distinct cu.user_id
                     from scmdata.sys_company_user cu
                    where cu.inner_user_id in ('JML26', 'TQQ53')) loop
          /*v_content    := '<SCM系统消息>您好!' || v_supplier ||
                          '待试单审核，请您及时跟进审核情况。';*/
          v_user_id    := ie.user_id;
          v_company_id := v_id;
          scmdata.pkg_send_wx_msg.p_cache_wecom_msg_pattern(p_company_id     => v_company_id,
                                                            p_param          => v_supplier,
                                                            p_target_user_id => v_user_id,
                                                            p_pattern_code   => 'ASSESSOR_03_MSG');
         /* scmdata.pkg_send_wx_msg.p_send_com_person_wx_msg(p_company_id => v_company_id,
                                                           p_user_id    => v_user_id,
                                                           p_content    => v_content);*/
        end loop;
  ----发送对象：供应商管理部经理
          select distinct cu.user_id
            into v_user_id
            from scmdata.sys_company_user cu
           where cu.inner_user_id = 'LHB19';
          /*v_content    := '<SCM系统消息>您好!' || v_supplier ||
                          '待试单审核，请您前往【供应商试单跟进表】继续试单tab页中及时审核。';*/
          v_company_id := v_id;
          scmdata.pkg_send_wx_msg.p_cache_wecom_msg_pattern(p_company_id     => v_company_id,
                                                            p_param          => v_supplier,
                                                            p_target_user_id => v_user_id,
                                                            p_pattern_code   => 'MANAGER_WX_01_MSG');
         /* scmdata.pkg_send_wx_msg.p_send_com_person_wx_msg(p_company_id => v_company_id,
                                                           p_user_id    => v_user_id,
                                                           p_content    => v_content);*/
    end if;

/*v_type = 2 试单供应商到期3天后*/
  elsif v_type = 2 then
/*v_type2 = 301 试单未结束tab页*/
    if v_type2 = '301' then
  ----发送对象：评估专员
        for ie in (select distinct cu.user_id
                     from scmdata.sys_company_user cu
                    where cu.inner_user_id in ('JML26', 'TQQ53')) loop
          /*v_content    := '<SCM系统消息>您好!' || v_supplier ||
                          '待试单审核（跟单主管和QC主管已给予试单建议后第3天），请您及时跟进审核情况。';*/
          v_user_id    := ie.user_id;
          v_company_id := v_id;
          scmdata.pkg_send_wx_msg.p_cache_wecom_msg_pattern(p_company_id     => v_company_id,
                                                            p_param          => v_supplier,
                                                            p_target_user_id => v_user_id,
                                                            p_pattern_code   => 'ASSESSOR_04_MSG');
/*          scmdata.pkg_send_wx_msg.p_send_com_person_wx_msg(p_company_id => v_company_id,
                                                           p_user_id    => v_user_id,
                                                           p_content    => v_content);*/
        end loop;
  ----发送对象：供应商管理部经理
          select distinct cu.user_id
            into v_user_id
            from scmdata.sys_company_user cu
           where cu.inner_user_id = 'LHB19';
          /*v_content    := '<SCM系统消息>您好!' || v_supplier ||
                          '待试单审核，请您前往【供应商试单跟进表】试单未结束tab页中及时审核。';*/
          v_company_id := v_id;
          scmdata.pkg_send_wx_msg.p_cache_wecom_msg_pattern(p_company_id     => v_company_id,
                                                            p_param          => v_supplier,
                                                            p_target_user_id => v_user_id,
                                                            p_pattern_code   => 'MANAGER_02_MSG');
          /*scmdata.pkg_send_wx_msg.p_send_com_person_wx_msg(p_company_id => v_company_id,
                                                           p_user_id    => v_user_id,
                                                           p_content    => v_content);*/
/*v_type2 = 302 继续试单tab页*/
      elsif v_type2 = '302' then
  ----发送对象：评估专员
        for ie in (select distinct cu.user_id
                     from scmdata.sys_company_user cu
                    where cu.inner_user_id in ('JML26', 'TQQ53')) loop
          /*v_content    := '<SCM系统消息>您好!' || v_supplier ||
                          '待试单审核（跟单主管和QC主管已给予试单建议后第3天），请您及时跟进审核情况。';*/
          v_user_id    := ie.user_id;
          v_company_id := v_id;
          scmdata.pkg_send_wx_msg.p_cache_wecom_msg_pattern(p_company_id     => v_company_id,
                                                            p_param          => v_supplier,
                                                            p_target_user_id => v_user_id,
                                                            p_pattern_code   => 'ASSESSOR_04_MSG');
         /* scmdata.pkg_send_wx_msg.p_send_com_person_wx_msg(p_company_id => v_company_id,
                                                           p_user_id    => v_user_id,
                                                           p_content    => v_content);*/
        end loop;
  ----发送对象：供应商管理部经理
          select distinct cu.user_id
            into v_user_id
            from scmdata.sys_company_user cu
           where cu.inner_user_id = 'LHB19';
          /*v_content    := '<SCM系统消息>您好!' || v_supplier ||
                          '待试单审核，请您前往【供应商试单跟进表】继续试单tab页中及时审核。';*/
          v_company_id := v_id;
          scmdata.pkg_send_wx_msg.p_cache_wecom_msg_pattern(p_company_id     => v_company_id,
                                                            p_param          => v_supplier,
                                                            p_target_user_id => v_user_id,
                                                            p_pattern_code   => 'MANAGER_WX_02_MSG');
          /*scmdata.pkg_send_wx_msg.p_send_com_person_wx_msg(p_company_id => v_company_id,
                                                           p_user_id    => v_user_id,
                                                           p_content    => v_content);*/
    end if;
end if;

end p_supplier_trial_send_wx1;

/*触发器触发
场景三、审核结束触发*/
procedure p_supplier_trial_send_wx2(v_supplier varchar2,
                                    v_id       varchar2,
                                    v_type     varchar2) is
  v_user_id    varchar2(128);
  v_company_id varchar2(32);
begin
  if v_type = '2' then
    ----发送对象：评估专员
    for ie in (select distinct cu.user_id
                 from scmdata.sys_company_user cu
                where cu.inner_user_id in ('JML26', 'TQQ53')) loop
      v_user_id    := ie.user_id;
      v_company_id := v_id;
      scmdata.pkg_send_wx_msg.p_cache_wecom_msg_pattern(p_company_id     => v_company_id,
                                                        p_param          => v_supplier,
                                                        p_target_user_id => v_user_id,
                                                        p_pattern_code   => 'REVIEW_1_MSG');
    end loop;
    ----发送对象：跟单主管
    for i in (select t.supplier_company_abbreviation,
                     t.company_id,
                     regexp_substr(t.follower_leader, '[^;]+', 1, level) follower_leader
                from scmdata.t_supplier_trial_order_report t
               where t.supplier_company_abbreviation = v_supplier
                 and t.company_id = v_id
              connect by prior t.order_report_id = t.order_report_id
                     and level <=
                         length(t.follower_leader) -
                         length(regexp_replace(t.follower_leader, ';', '')) + 1
                     and prior dbms_random.value is not null) loop
      if i.follower_leader is not null then
        v_user_id    := i.follower_leader;
        v_company_id := v_id;
        scmdata.pkg_send_wx_msg.p_cache_wecom_msg_pattern(p_company_id     => v_company_id,
                                                          p_param          => v_supplier,
                                                          p_target_user_id => v_user_id,
                                                          p_pattern_code   => 'REVIEW_1_MSG');
      end if;
    end loop;
  elsif v_type = '1' then
    ----发送对象：评估专员
    for ie in (select distinct cu.user_id
                 from scmdata.sys_company_user cu
                where cu.inner_user_id in ('JML26', 'TQQ53')) loop
      v_user_id    := ie.user_id;
      v_company_id := v_id;
      scmdata.pkg_send_wx_msg.p_cache_wecom_msg_pattern(p_company_id     => v_company_id,
                                                        p_param          => v_supplier,
                                                        p_target_user_id => v_user_id,
                                                        p_pattern_code   => 'REVIEW_2_MSG');
    end loop;
    ----发送对象：跟单主管
    for i in (select t.supplier_company_abbreviation,
                     t.company_id,
                     regexp_substr(t.follower_leader, '[^;]+', 1, level) follower_leader
                from scmdata.t_supplier_trial_order_report t
               where t.supplier_company_abbreviation = v_supplier
                 and t.company_id = v_id
              connect by prior t.order_report_id = t.order_report_id
                     and level <=
                         length(t.follower_leader) -
                         length(regexp_replace(t.follower_leader, ';', '')) + 1
                     and prior dbms_random.value is not null) loop
      if i.follower_leader is not null then
        v_user_id    := i.follower_leader;
        v_company_id := v_id;
        scmdata.pkg_send_wx_msg.p_cache_wecom_msg_pattern(p_company_id     => v_company_id,
                                                          p_param          => v_supplier,
                                                          p_target_user_id => v_user_id,
                                                          p_pattern_code   => 'REVIEW_2_MSG');
      end if;
    end loop;
  elsif v_type = '0' then
    ----发送对象：评估专员
    for ie in (select distinct cu.user_id
                 from scmdata.sys_company_user cu
                where cu.inner_user_id in ('JML26', 'TQQ53')) loop
      v_user_id    := ie.user_id;
      v_company_id := v_id;
      scmdata.pkg_send_wx_msg.p_cache_wecom_msg_pattern(p_company_id     => v_company_id,
                                                        p_param          => v_supplier,
                                                        p_target_user_id => v_user_id,
                                                        p_pattern_code   => 'REVIEW_3_MSG');
    end loop;
    ----发送对象：跟单主管
    for i in (select t.supplier_company_abbreviation,
                     t.company_id,
                     regexp_substr(t.follower_leader, '[^;]+', 1, level) follower_leader
                from scmdata.t_supplier_trial_order_report t
               where t.supplier_company_abbreviation = v_supplier
                 and t.company_id = v_id
              connect by prior t.order_report_id = t.order_report_id
                     and level <=
                         length(t.follower_leader) -
                         length(regexp_replace(t.follower_leader, ';', '')) + 1
                     and prior dbms_random.value is not null) loop
      if i.follower_leader is not null then
        v_user_id    := i.follower_leader;
        v_company_id := v_id;
        scmdata.pkg_send_wx_msg.p_cache_wecom_msg_pattern(p_company_id     => v_company_id,
                                                          p_param          => v_supplier,
                                                          p_target_user_id => v_user_id,
                                                          p_pattern_code   => 'REVIEW_3_MSG');
      end if;
    end loop;
  end if;
end p_supplier_trial_send_wx2;


END PKG_REPORT;
/

