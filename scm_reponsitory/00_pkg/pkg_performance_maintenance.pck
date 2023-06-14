﻿create or replace package scmdata.pkg_performance_maintenance is
  procedure p_performance_maintenance_quarter;

  function f_performance_401_update_sql(vc_user_id varchar2,
                                        vc_id      varchar2) return clob;

  function f_performance_401_select_sql(maintenance_progress varchar2,
                                        commit_status        varchar2,
                                        order_status         varchar2,
                                        classifications      varchar2)
    return clob;

  procedure p_performance_maintenance_year;

  function f_performance_402_select_sql(maintenance_progress varchar2,
                                        commit_status        varchar2,
                                        order_status         varchar2,
                                        classifications      varchar2)
    return clob;

  function f_performance_402_update_sql(vc_user_id varchar2,
                                        vc_id      varchar2) return clob;

  procedure p_performance_report_quarter;
  procedure p_performance_401_action_sql;
  procedure p_performance_report_year;
  procedure p_performance_402_action_sql;
  function f_performance_401_1_select_sql(year_q          varchar2,
                                          quarter         varchar2,
                                          order_status    varchar2,
                                          classifications varchar2)
    return clob;
  function f_performance_402_1_select_sql(year_y          varchar2,
                                          order_status    varchar2,
                                          classifications varchar2)
    return clob;
  procedure p_performance_301_action_sql;
  procedure p_performance_301_1_action_sql;
  procedure p_performance_302_action_sql;
  procedure p_performance_302_1_action_sql;
end pkg_performance_maintenance;
/

create or replace package body scmdata.pkg_performance_maintenance is

   procedure p_performance_maintenance_quarter is
     v1_year number;
     v1_quarter number;
     v2_year number;
     v2_quarter number;
/*更新供应商全称、简称*/
    begin
    merge into scmdata.t_performance_maintenance_quarter tka
    using ( select distinct t.supplier_info_id,
                            t.company_id,
                            t.supplier_code,
                            t.supplier_company_abbreviation factory_abbreviation,
                            t.supplier_company_name         factory_name,
                            tc.coop_classification          category_id,
                            g.group_dict_name               category
              from scmdata.t_supplier_info t
             inner join scmdata.t_coop_scope tc
                on tc.company_id = t.company_id
               and tc.supplier_info_id = t.supplier_info_id
               and tc.pause = 0
             inner join scmdata.sys_group_dict g
                on g.group_dict_type = t.cooperation_type
               AND g.group_dict_value = tc.coop_classification
               AND g.pause = 0
             where t.status = 1
               and t.supplier_info_origin <> 'II'
               and tc.coop_classification <> '07'
               and tc.coop_classification <> '06') tkb
    on (tka.company_id = tkb.company_id and tka.supplier_code = tkb.supplier_code 
        and tka.supplier_info_id = tkb.supplier_info_id  and tka.category = tkb.category)
    when matched then
        update
           set tka.factory_name         = tkb.factory_name,
               tka.factory_abbreviation = tkb.factory_abbreviation;
/*新增绩效考核维护列表季度表数据*/
    begin
    merge into scmdata.t_performance_maintenance_quarter tka
    using ( select distinct t.supplier_info_id,
                            t.company_id,
                            t.supplier_code,
                            t.supplier_company_abbreviation factory_abbreviation,
                            t.supplier_company_name         factory_name,
                            tc.coop_classification          category_id,
                            g.group_dict_name               category
              from scmdata.t_supplier_info t
             inner join scmdata.t_coop_scope tc
                on tc.company_id = t.company_id
               and tc.supplier_info_id = t.supplier_info_id
               and tc.pause = 0
             inner join scmdata.sys_group_dict g
                on g.group_dict_type = t.cooperation_type
               AND g.group_dict_value = tc.coop_classification
               AND g.pause = 0
             where t.status = 1
               and t.supplier_info_origin <> 'II'
               and tc.coop_classification <> '07'
               and tc.coop_classification <> '06') tkb
    on (tka.company_id = tkb.company_id and tka.supplier_info_id = tkb.supplier_info_id 
         and tka.supplier_code = tkb.supplier_code and tka.category = tkb.category
        and tka.factory_name = tkb.factory_name)
    when not matched then
        insert
          (tka.t_performance_maintenance_quarter_id,
           tka.company_id,
           tka.supplier_info_id,
           tka.supplier_code,
           tka.factory_abbreviation,
           tka.factory_name,
           tka.commit_status,
           tka.category_id,
           tka.category,
           tka.major_quality_problem,
           tka.integrity,
           tka.finance,
           tka.create_id,
           tka.create_time)
        values
          (scmdata.f_get_uuid(),
           tkb.company_id,
           tkb.supplier_info_id,
           tkb.supplier_code,
           tkb.factory_abbreviation,
           tkb.factory_name,
           '未提交',
           tkb.category_id,
           tkb.category,
           '0',
           '0',
           '0',
           'ADMIN',
           sysdate);
  end;
/*供应商如果停用分类，就删除改条记录*/
  begin
   delete scmdata.t_performance_maintenance_quarter tp
    where (tp.supplier_info_id, tp.company_id, tp.factory_name, tp.category) not in
          (select distinct t.supplier_info_id,
                           t.company_id,
                           t.supplier_company_name factory_name,
                           g.group_dict_name       category
             from scmdata.t_supplier_info t
            inner join scmdata.t_coop_scope tc
               on tc.company_id = t.company_id
              and tc.supplier_info_id = t.supplier_info_id
              and tc.pause = 0
            inner join scmdata.sys_group_dict g
               on g.group_dict_type = t.cooperation_type
              AND g.group_dict_value = tc.coop_classification
              AND g.pause = 0
            where t.status = 1
              and t.supplier_info_origin <> 'II'
              and tc.coop_classification <> '07'
              and tc.coop_classification <> '06');
   end;
/*插入年、季度  如果历史数据表没如何记录就取最早的创建时间，否则取历史数据表的最新年度、季度+1*/
   begin
    select to_char(min(t1.create_time), 'yyyy'),to_char(min(t1.create_time), 'Q')
      into v1_year,v1_quarter
      from scmdata.t_performance_maintenance_quarter t1;
    select t1.year, max(t2.quarter)quarter
      into v2_year,v2_quarter
      from (select max(year) year
              from scmdata.t_history_performance_maintenance_quarter) t1
      left join scmdata.t_history_performance_maintenance_quarter t2
        on t1.year = t2.year
     group by t1.year;

      if v2_year is null and v2_quarter is null then
         update scmdata.t_performance_maintenance_quarter t set t.year = v1_year,t.quarter = v1_quarter;
        elsif v2_quarter = '4' then
             v1_year := v2_year + 1;
             v1_quarter := 1;
         update scmdata.t_performance_maintenance_quarter t set t.year = v1_year,t.quarter = v1_quarter;
         else 
             v1_year := v2_year;
             v1_quarter := v2_quarter +1;
         update scmdata.t_performance_maintenance_quarter t set t.year = v1_year,t.quarter = v1_quarter;           
      end if;   
   end;
/*更新其它字段*/
    begin 
    merge into scmdata.t_performance_maintenance_quarter tka
    using ( select z.company_id, z.supplier_info_id, z.year, z.quarter,z.factory_name, z.category,z.t_performance_maintenance_quarter_id,
       (case when pt1.order_status is not null then pt1.order_status else '未下单' end) order_status,
       (case when pt1.order_status is null then '-' 
             when pt1.order_status = '已下单' and ( z.priority_order is null  or z.production_progress_feedback is null or z.response_speed_and_attitude is null
                  or z.check_cooperation_degree is null or z.quality_problem is null or z.major_quality_problem is null or z.integrity is null or z.finance is null) then '未完成'
             else '已完成' end )maintenance_progress,
       pt1.order_money, dl.delivery_money
  from scmdata.t_performance_maintenance_quarter  z
/*  left join (select distinct to_char(tor.send_order_date, 'yyyy') year,to_char(tor.send_order_date, 'Q') quarter,tor.company_id,
                             (select supplier_company_name
                                from scmdata.t_supplier_info
                               where company_id = tor.company_id
                                 and supplier_code = y.factory_code) product_factory,
                             (select group_dict_name
                                from scmdata.sys_group_dict
                               where group_dict_value = x.category
                                 and group_dict_type = 'PRODUCT_TYPE') category,
                             '已下单' order_status
               from scmdata.t_ordered tor
              inner join scmdata.t_orders y
                 on tor.order_code = y.order_id
                and tor.company_id = y.company_id
              inner join scmdata.t_commodity_info x
                 on x.goo_id = y.goo_id
                and x.company_id = y.company_id) ord
    on ord.year = z.year
   and ord.quarter = z.quarter
   and ord.company_id = z.company_id
   and z.factory_name = ord.product_factory
   and z.category = ord.category*/
  left join (select to_char(pt.order_create_date, 'yyyy') year,to_char(pt.order_create_date, 'Q') quarter,pt.category_name,
                    pt.company_id,pt.factory_company_name,sum(pt.order_money) order_money,'已下单' order_status
               from scmdata.pt_ordered pt
              group by to_char(pt.order_create_date, 'yyyy'),to_char(pt.order_create_date, 'Q'),
                       pt.company_id,pt.category_name,pt.factory_company_name) pt1
    on pt1.company_id = z.company_id
   and pt1.year = z.year
   and pt1.quarter = z.quarter
   and pt1.category_name = z.category
   and pt1.factory_company_name = z.factory_name
  left join (select z1.company_id, z1.factory_company_name,z1.category_name,z1.year, z1.quarter,sum(z1.sum_money) delivery_money
               from (select t3c.company_id,t3c.factory_company_name,t3c.category_name,to_char(ta2.delivery_date, 'yyyy') year,
                            to_char(ta2.delivery_date, 'Q') quarter,(t3c.fixed_price * ta2.delivery_amount) sum_money
                       from scmdata.pt_ordered t3c
                      inner join scmdata.t_delivery_record ta2
                         on t3c.product_gress_code = ta2.order_code
                        and t3c.company_id = ta2.company_id
                       left join scmdata.t_commodity_info tb
                         on t3c.goo_id = tb.rela_goo_id
                        and tb.goo_id = ta2.goo_id
                        and t3c.company_id = tb.company_id) z1
              group by z1.company_id,z1.factory_company_name, z1.category_name,z1.year,z1.quarter) dl
    on dl.company_id = z.company_id
   and dl.year = z.year
   and dl.quarter = z.quarter
   and dl.category_name = z.category
   and dl.factory_company_name = z.factory_name ) tkb
    on (tka.company_id = tkb.company_id and tka.supplier_info_id = tkb.supplier_info_id  and tka.category = tkb.category
        and tka.factory_name = tkb.factory_name and tka.t_performance_maintenance_quarter_id = tkb.t_performance_maintenance_quarter_id)
    when matched then
        update
           set tka.order_status             = tkb.order_status,
               tka.order_money              = tkb.order_money,
               tka.delivery_money           = tkb.delivery_money,
               tka.maintenance_progress     = tkb.maintenance_progress;
  end;
   end p_performance_maintenance_quarter;


 function f_performance_401_update_sql(vc_user_id      varchar2,
                                       vc_id           varchar2) return clob is
   v_num1  number;
   v_num2  number;
   v_num3  number;
   vc_sql  clob;
 begin
/*跟单*/
 select pkg_plat_comm.f_hasaction_application(vc_user_id,vc_id,'P0010503')
   into v_num1
   from dual ;
/*QC*/
 select pkg_plat_comm.f_hasaction_application(vc_user_id,vc_id,'P0010504')
   into v_num2
   from dual ;
/*供管*/
 select pkg_plat_comm.f_hasaction_application(vc_user_id,vc_id,'P0010505')
   into v_num3
   from dual ;

     if v_num1 = 1 and v_num2=0 and  v_num3=0 then
 vc_sql := q'[declare
          v_1 number;v_2 number;v_3 number;v_4 number;v_5 number;v_6 varchar2(4);v_7 varchar2(4);v_8 varchar2(4);
begin
  update scmdata.t_performance_maintenance_quarter t
     set t.priority_order               = :priority_order,
         t.production_progress_feedback = :production_progress_feedback,
         t.response_speed_and_attitude  = :response_speed_and_attitude,
         t.commit_status                = '未提交',
         update_time                    = sysdate,
         update_id                      = ']'||vc_user_id ||''''||
  q'[ where t.t_performance_maintenance_quarter_id = :t_performance_maintenance_quarter_id
     and company_id = ']'||vc_id||''''||q'[;
               select max(t.priority_order),
                      max(t.production_progress_feedback),
                      max(t.response_speed_and_attitude),
                      max(t.check_cooperation_degree),
                      max(t.quality_problem),
                      max(t.major_quality_problem),
                      max(t.integrity),
                      max(t.finance)
                 into v_1, v_2, v_3, v_4, v_5, v_6, v_7, v_8
                 from scmdata.t_performance_maintenance_quarter t
                where t.t_performance_maintenance_quarter_id = :t_performance_maintenance_quarter_id;
            if v_1 is not null and v_2 is not null and v_3 is not null and v_4 is not null and v_5 is not null then
                 update scmdata.t_performance_maintenance_quarter t
                    set t.overall_assessment_score =
                        (t.priority_order * 0.2) + (t.production_progress_feedback * 0.2) +
                        (t.response_speed_and_attitude * 0.2) +
                        (t.check_cooperation_degree * 0.2) + (t.quality_problem * 0.2)
                  where t.t_performance_maintenance_quarter_id = :t_performance_maintenance_quarter_id;
            end if;
            if v_1 is not null and v_2 is not null and v_3 is not null  and v_4 is not null 
              and v_5 is not null and v_6 is not null and v_7 is not null and v_8 is not null then
                 update scmdata.t_performance_maintenance_quarter t
                    set t.maintenance_progress = '已完成'
                  where t.t_performance_maintenance_quarter_id = :t_performance_maintenance_quarter_id;
            end if;
end;]';
     elsif v_num1=0 and v_num2=1 and v_num3=0 then
         vc_sql := q'[declare
          v_1 number;v_2 number;v_3 number;v_4 number;v_5 number;v_6 varchar2(4);v_7 varchar2(4);v_8 varchar2(4);
              begin
                update scmdata.t_performance_maintenance_quarter t
                   set t.check_cooperation_degree = :check_cooperation_degree,
                       t.quality_problem          = :quality_problem,
                       t.commit_status            = '未提交',
                       update_time                = sysdate,
                       update_id                  = ']'||vc_user_id ||''''||
                q'[ where t.t_performance_maintenance_quarter_id = :t_performance_maintenance_quarter_id
                   and company_id = ']'||vc_id||''''||q'[;
               select max(t.priority_order),
                      max(t.production_progress_feedback),
                      max(t.response_speed_and_attitude),
                      max(t.check_cooperation_degree),
                      max(t.quality_problem),
                      max(t.major_quality_problem),
                      max(t.integrity),
                      max(t.finance)
                 into v_1, v_2, v_3, v_4, v_5, v_6, v_7, v_8
                 from scmdata.t_performance_maintenance_quarter t
                where t.t_performance_maintenance_quarter_id = :t_performance_maintenance_quarter_id;
            if v_1 is not null and v_2 is not null and v_3 is not null and v_4 is not null and v_5 is not null then
                 update scmdata.t_performance_maintenance_quarter t
                    set t.overall_assessment_score =
                        (t.priority_order * 0.2) + (t.production_progress_feedback * 0.2) +
                        (t.response_speed_and_attitude * 0.2) +
                        (t.check_cooperation_degree * 0.2) + (t.quality_problem * 0.2)
                  where t.t_performance_maintenance_quarter_id = :t_performance_maintenance_quarter_id;
            end if;
            if v_1 is not null and v_2 is not null and v_3 is not null  and v_4 is not null 
              and v_5 is not null and v_6 is not null and v_7 is not null and v_8 is not null then
                 update scmdata.t_performance_maintenance_quarter t
                    set t.maintenance_progress = '已完成'
                  where t.t_performance_maintenance_quarter_id = :t_performance_maintenance_quarter_id;
            end if;
              end;]';
    elsif v_num1=1 and v_num2=1 and v_num3=0 then
     vc_sql := q'[declare
          v_1 number;v_2 number;v_3 number;v_4 number;v_5 number;v_6 varchar2(4);v_7 varchar2(4);v_8 varchar2(4);
        begin
          update scmdata.t_performance_maintenance_quarter t
             set t.priority_order               = :priority_order,
                 t.production_progress_feedback = :production_progress_feedback,
                 t.response_speed_and_attitude  = :response_speed_and_attitude,
                 t.check_cooperation_degree     = :check_cooperation_degree,
                 t.quality_problem              = :quality_problem,
                 t.commit_status                = '未提交',
                 update_time                    = sysdate,
                 update_id                      = ']'||vc_user_id ||''''||
          q'[ where t.t_performance_maintenance_quarter_id = :t_performance_maintenance_quarter_id
             and company_id = ']'||vc_id||''''|| q'[;
               select max(t.priority_order),
                      max(t.production_progress_feedback),
                      max(t.response_speed_and_attitude),
                      max(t.check_cooperation_degree),
                      max(t.quality_problem),
                      max(t.major_quality_problem),
                      max(t.integrity),
                      max(t.finance)
                 into v_1, v_2, v_3, v_4, v_5, v_6, v_7, v_8
                 from scmdata.t_performance_maintenance_quarter t
                where t.t_performance_maintenance_quarter_id = :t_performance_maintenance_quarter_id;
            if v_1 is not null and v_2 is not null and v_3 is not null and v_4 is not null and v_5 is not null then
                 update scmdata.t_performance_maintenance_quarter t
                    set t.overall_assessment_score =
                        (t.priority_order * 0.2) + (t.production_progress_feedback * 0.2) +
                        (t.response_speed_and_attitude * 0.2) +
                        (t.check_cooperation_degree * 0.2) + (t.quality_problem * 0.2)
                  where t.t_performance_maintenance_quarter_id = :t_performance_maintenance_quarter_id;
            end if;
            if v_1 is not null and v_2 is not null and v_3 is not null  and v_4 is not null 
              and v_5 is not null and v_6 is not null and v_7 is not null and v_8 is not null then
                 update scmdata.t_performance_maintenance_quarter t
                    set t.maintenance_progress = '已完成'
                  where t.t_performance_maintenance_quarter_id = :t_performance_maintenance_quarter_id;
            end if;
        end;]';
    elsif v_num3=1 then
     vc_sql := q'[declare
          v_1 number;v_2 number;v_3 number;v_4 number;v_5 number;v_6 varchar2(4);v_7 varchar2(4);v_8 varchar2(4);
        begin
         update scmdata.t_performance_maintenance_quarter t
            set t.priority_order               = :priority_order,
                t.production_progress_feedback = :production_progress_feedback,
                t.response_speed_and_attitude  = :response_speed_and_attitude,
                t.check_cooperation_degree     = :check_cooperation_degree,
                t.quality_problem              = :quality_problem,
                t.major_quality_problem        = :major_quality_problem,
                t.integrity                    = :integrity,
                t.finance                      = :finance,
                t.commit_status                = '未提交',
                update_time                    = sysdate,
                update_id                      = ']'||vc_user_id ||''''||
          q'[ where t.t_performance_maintenance_quarter_id = :t_performance_maintenance_quarter_id
             and company_id = ']'||vc_id||''''|| q'[;
               select max(t.priority_order),
                      max(t.production_progress_feedback),
                      max(t.response_speed_and_attitude),
                      max(t.check_cooperation_degree),
                      max(t.quality_problem),
                      max(t.major_quality_problem),
                      max(t.integrity),
                      max(t.finance)
                 into v_1, v_2, v_3, v_4, v_5, v_6, v_7, v_8
                 from scmdata.t_performance_maintenance_quarter t
                where t.t_performance_maintenance_quarter_id = :t_performance_maintenance_quarter_id;
            if v_1 is not null and v_2 is not null and v_3 is not null and v_4 is not null and v_5 is not null then
                 update scmdata.t_performance_maintenance_quarter t
                    set t.overall_assessment_score =
                        (t.priority_order * 0.2) + (t.production_progress_feedback * 0.2) +
                        (t.response_speed_and_attitude * 0.2) +
                        (t.check_cooperation_degree * 0.2) + (t.quality_problem * 0.2)
                  where t.t_performance_maintenance_quarter_id = :t_performance_maintenance_quarter_id;
            end if;
            if v_1 is not null and v_2 is not null and v_3 is not null  and v_4 is not null 
              and v_5 is not null and v_6 is not null and v_7 is not null and v_8 is not null then
                 update scmdata.t_performance_maintenance_quarter t
                    set t.maintenance_progress = '已完成'
                  where t.t_performance_maintenance_quarter_id = :t_performance_maintenance_quarter_id;
            end if;
        end;]';
     end if;
    return vc_sql;
 end f_performance_401_update_sql;

function f_performance_401_select_sql(maintenance_progress varchar2,
                                      commit_status        varchar2,
                                      order_status         varchar2,
                                      classifications      varchar2) return clob is
  v1_sql clob := q'[select *
  from (select t.t_performance_maintenance_quarter_id,
               t.commit_status,
               t.maintenance_progress,
               (t.year || '年') year_pm,
               ('第' || t.quarter || '季度') quarter,
               t.category_id,
               t.category classifications,
               t.factory_abbreviation production_supplier,
               t.order_status,
               t.order_money orders_money,
               t.delivery_money order_delivery_money,
               t.overall_assessment_score,
               t.priority_order,
               t.production_progress_feedback,
               t.response_speed_and_attitude,
               t.check_cooperation_degree,
               t.quality_problem,
               t.major_quality_problem,
               t.integrity,
               t.finance,
               st.company_user_name newest_update_id,
               t.update_time newest_update_time,
               st1.company_user_name commit_id,
               t.commit_time
          from scmdata.t_performance_maintenance_quarter t
          left join scmdata.sys_company_user st
            on st.company_id = t.company_id
           and st.user_id = t.update_id
          left join scmdata.sys_company_user st1
            on st1.company_id = t.company_id
           and st1.user_id = t.commit_id
         where t.company_id = %default_company_id%
    and (%is_company_admin% = 1 or instr_priv(p_str1 => {declare v_class_data_privs clob;
          begin
            v_class_data_privs := pkg_data_privs.parse_json(p_jsonstr => %data_privs_json_strs%,
                                                            p_key     => 'COL_2');
            @strresult         := '''' || v_class_data_privs || '''';
          end;
          }, p_str2 => t.category_id, p_split => ';') > 0)
         order by t.year desc, t.quarter desc, t.order_money desc nulls last) 
]';
  vc_sql clob;
begin
    if   maintenance_progress = '全部' and commit_status = '全部'and order_status = '全部' and classifications =  '全部' then
   vc_sql :=  v1_sql;  
    elsif maintenance_progress <> '全部' and commit_status <> '全部'and order_status <> '全部' and classifications <>  '全部' then
   vc_sql :=  v1_sql || 'where maintenance_progress = ' ||''''|| maintenance_progress ||''''||'
 and commit_status = ' ||''''|| commit_status||''''||'
 and order_status = ' || ''''|| order_status ||''''||'
 and classifications ='||''''|| classifications||'''' ;
    elsif maintenance_progress =  '全部' and commit_status <> '全部'and order_status <> '全部' and classifications <>  '全部' then
   vc_sql :=  v1_sql || 'where  commit_status = ' ||''''|| commit_status||''''||'
 and order_status = ' || ''''|| order_status ||''''||'
 and classifications ='||''''|| classifications||'''' ;
    elsif maintenance_progress <> '全部' and commit_status = '全部'and order_status <> '全部' and classifications <>  '全部' then
   vc_sql :=  v1_sql || 'where maintenance_progress = ' ||''''|| maintenance_progress ||''''||'
 and order_status = ' || ''''|| order_status ||''''||'
 and classifications ='||''''|| classifications||'''' ;
    elsif maintenance_progress <> '全部' and commit_status <> '全部'and order_status = '全部' and classifications <>  '全部' then
   vc_sql :=  v1_sql || 'where maintenance_progress = ' ||''''|| maintenance_progress ||''''||'
 and commit_status = ' ||''''|| commit_status||''''||'
 and classifications ='||''''|| classifications||'''' ;
    elsif maintenance_progress <> '全部' and commit_status <> '全部'and order_status <> '全部' and classifications =  '全部' then
   vc_sql :=  v1_sql || 'where maintenance_progress = ' ||''''|| maintenance_progress ||''''||'
 and commit_status = ' ||''''|| commit_status||''''||'
 and order_status = ' || ''''|| order_status ||'''' ;
    elsif maintenance_progress = '全部' and commit_status = '全部'and order_status <> '全部' and classifications <>  '全部' then
   vc_sql :=  v1_sql || 'where  order_status = ' || ''''|| order_status ||''''||'
 and classifications ='||''''|| classifications||'''' ;
    elsif maintenance_progress = '全部' and commit_status <> '全部'and order_status = '全部' and classifications<>  '全部' then
   vc_sql :=  v1_sql || 'where  commit_status = ' ||''''|| commit_status||''''||'
 and classifications ='||''''|| classifications||'''' ;
    elsif maintenance_progress = '全部' and commit_status <> '全部'and order_status <> '全部' and classifications =  '全部' then
   vc_sql :=  v1_sql || 'where  commit_status = ' ||''''|| commit_status||''''||'
 and order_status = ' || ''''|| order_status ||'''' ;
    elsif maintenance_progress <> '全部' and commit_status = '全部'and order_status = '全部' and classifications <>  '全部' then
   vc_sql :=  v1_sql || 'where maintenance_progress = ' ||''''|| maintenance_progress ||''''||'
 and classifications ='||''''|| classifications||'''' ;
    elsif maintenance_progress <> '全部' and commit_status = '全部'and order_status <> '全部' and classifications =  '全部' then
   vc_sql :=  v1_sql || 'where maintenance_progress = ' ||''''|| maintenance_progress ||''''||'
 and order_status = ' || ''''|| order_status ||'''';
    elsif maintenance_progress <> '全部' and commit_status <> '全部'and order_status = '全部' and classifications =  '全部' then
   vc_sql :=  v1_sql || 'where maintenance_progress = ' ||''''|| maintenance_progress ||''''||'
 and commit_status = ' ||''''|| commit_status||'''' ;
    elsif maintenance_progress = '全部' and commit_status = '全部'and order_status = '全部' and classifications <>  '全部' then
   vc_sql :=  v1_sql || 'where  classifications ='||''''|| classifications||'''' ;
    elsif maintenance_progress = '全部' and commit_status <> '全部'and order_status = '全部' and classifications = '全部' then
   vc_sql :=  v1_sql || 'where commit_status = ' ||''''|| commit_status||'''';
    elsif maintenance_progress = '全部' and commit_status = '全部'and order_status <> '全部' and classifications =  '全部' then
   vc_sql :=  v1_sql || 'where order_status = ' || ''''|| order_status ||'''' ;
    elsif maintenance_progress <> '全部' and commit_status = '全部'and order_status = '全部' and classifications =  '全部' then
   vc_sql :=  v1_sql || 'where maintenance_progress = ' ||''''|| maintenance_progress ||'''' ;
    end if ;
  return vc_sql;
end f_performance_401_select_sql;

   procedure p_performance_maintenance_year is
     v1_year number;
     v2_year number;
/*更新供应商全称、简称*/
    begin
    merge into scmdata.t_performance_maintenance_year tka
    using ( select distinct t.supplier_info_id,
                            t.company_id,
                            t.supplier_code,
                            t.supplier_company_abbreviation factory_abbreviation,
                            t.supplier_company_name         factory_name,
                            tc.coop_classification          category_id,
                            g.group_dict_name               category
              from scmdata.t_supplier_info t
             inner join scmdata.t_coop_scope tc
                on tc.company_id = t.company_id
               and tc.supplier_info_id = t.supplier_info_id
               and tc.pause = 0
             inner join scmdata.sys_group_dict g
                on g.group_dict_type = t.cooperation_type
               AND g.group_dict_value = tc.coop_classification
               AND g.pause = 0
             where t.status = 1
               and t.supplier_info_origin <> 'II'
               and tc.coop_classification <> '07'
               and tc.coop_classification <> '06') tkb
    on (tka.company_id = tkb.company_id and tka.supplier_info_id = tkb.supplier_info_id  
       and tka.category = tkb.category and tka.supplier_code = tkb.supplier_code )
    when matched then
        update
           set tka.factory_name         = tkb.factory_name,
               tka.factory_abbreviation = tkb.factory_abbreviation;
/*新增绩效考核维护列表季度表数据*/
    begin
    merge into scmdata.t_performance_maintenance_year tka
    using ( select distinct t.supplier_info_id,
                            t.company_id,
                            t.supplier_code,
                            t.supplier_company_abbreviation factory_abbreviation,
                            t.supplier_company_name         factory_name,
                            tc.coop_classification          category_id,
                            g.group_dict_name               category
              from scmdata.t_supplier_info t
             inner join scmdata.t_coop_scope tc
                on tc.company_id = t.company_id
               and tc.supplier_info_id = t.supplier_info_id
               and tc.pause = 0
             inner join scmdata.sys_group_dict g
                on g.group_dict_type = t.cooperation_type
               AND g.group_dict_value = tc.coop_classification
               AND g.pause = 0
             where t.status = 1
               and t.supplier_info_origin <> 'II'
               and tc.coop_classification <> '07'
               and tc.coop_classification <> '06') tkb
    on (tka.company_id = tkb.company_id and tka.supplier_info_id = tkb.supplier_info_id  and tka.category = tkb.category
        and tka.factory_name = tkb.factory_name and tka.supplier_code = tkb.supplier_code )
    when not matched then
        insert
          (tka.t_performance_maintenance_year_id,
           tka.company_id,
           tka.supplier_info_id,
           tka.supplier_code,
           tka.factory_abbreviation,
           tka.factory_name,
           tka.commit_status,
           tka.category_id,
           tka.category,
           tka.major_quality_problem,
           tka.integrity,
           tka.finance,
           tka.create_id,
           tka.create_time)
        values
          (scmdata.f_get_uuid(),
           tkb.company_id,
           tkb.supplier_info_id,
           tkb.supplier_code,
           tkb.factory_abbreviation,
           tkb.factory_name,
           '未提交',
           tkb.category_id,
           tkb.category,
           '0',
           '0',
           '0',
           'ADMIN',
           sysdate);
  end;
/*供应商如果停用分类，就删除改条记录*/
  begin
   delete scmdata.t_performance_maintenance_year tp
    where (tp.supplier_info_id, tp.company_id, tp.factory_name, tp.category) not in
          (select distinct t.supplier_info_id,
                           t.company_id,
                           t.supplier_company_name factory_name,
                           g.group_dict_name       category
             from scmdata.t_supplier_info t
            inner join scmdata.t_coop_scope tc
               on tc.company_id = t.company_id
              and tc.supplier_info_id = t.supplier_info_id
              and tc.pause = 0
            inner join scmdata.sys_group_dict g
               on g.group_dict_type = t.cooperation_type
              AND g.group_dict_value = tc.coop_classification
              AND g.pause = 0
            where t.status = 1
              and t.supplier_info_origin <> 'II'
              and tc.coop_classification <> '07'
              and tc.coop_classification <> '06');
   end;

/*插入年度  如果历史数据表没如何记录就取最早的创建时间，否则取历史数据表的最新年度+1*/
   begin
    select to_char(min(t1.create_time), 'yyyy')year
      into v1_year
      from scmdata.t_performance_maintenance_year t1;
    select max(year)year
      into v2_year
      from scmdata.t_history_performance_maintenance_year;

      if v2_year is null then
         update scmdata.t_performance_maintenance_year t set t.year = v1_year;
         else 
             v1_year := v2_year + 1;
         update scmdata.t_performance_maintenance_year t set t.year = v1_year;           
      end if; 
  
   end;

/*更新其它字段*/
    begin 
    merge into scmdata.t_performance_maintenance_year tka
    using ( select z.company_id, z.supplier_info_id, z.year, z.factory_name, z.category,z.t_performance_maintenance_year_id,
       (case when pt1.order_status is not null then pt1.order_status else '未下单' end) order_status,
       (case when pt1.order_status is null then '-' 
             when pt1.order_status = '已下单' and ( z.priority_order is null  or z.production_progress_feedback is null or z.response_speed_and_attitude is null
                  or z.check_cooperation_degree is null or z.quality_problem is null or z.major_quality_problem is null or z.integrity is null or z.finance is null) then '未完成'
             else '已完成' end )maintenance_progress,
       pt1.order_money, dl.delivery_money
  from scmdata.t_performance_maintenance_year  z
/*  left join (select distinct to_char(tor.send_order_date, 'yyyy') year,tor.company_id,
                             (select supplier_company_name from scmdata.t_supplier_info
                               where company_id = tor.company_id and supplier_code = y.factory_code) product_factory,
                             (select group_dict_name from scmdata.sys_group_dict
                               where group_dict_value = x.category and group_dict_type = 'PRODUCT_TYPE') category,
                             '已下单' order_status
               from scmdata.t_ordered tor
              inner join scmdata.t_orders y
                 on tor.order_code = y.order_id
                and tor.company_id = y.company_id
              inner join scmdata.t_commodity_info x
                 on x.goo_id = y.goo_id
                and x.company_id = y.company_id) ord
    on ord.year = z.year
   and ord.company_id = z.company_id
   and z.factory_name = ord.product_factory
   and z.category = ord.category*/
  left join (select to_char(pt.order_create_date, 'yyyy') year,pt.category_name,
                    pt.company_id,pt.factory_company_name,sum(pt.order_money) order_money,'已下单' order_status
               from scmdata.pt_ordered pt
              group by to_char(pt.order_create_date, 'yyyy'), pt.company_id,pt.category_name,pt.factory_company_name) pt1
    on pt1.company_id = z.company_id
   and pt1.year = z.year
   and pt1.category_name = z.category
   and pt1.factory_company_name = z.factory_name
  left join (select z1.company_id, z1.factory_company_name,z1.category_name,z1.year, sum(z1.sum_money) delivery_money
               from (select t3c.company_id,t3c.factory_company_name,t3c.category_name,to_char(ta2.delivery_date, 'yyyy') year,
                           (t3c.fixed_price * ta2.delivery_amount) sum_money
                       from scmdata.pt_ordered t3c
                      inner join scmdata.t_delivery_record ta2
                         on t3c.product_gress_code = ta2.order_code
                        and t3c.company_id = ta2.company_id
                       left join scmdata.t_commodity_info tb
                         on t3c.goo_id = tb.rela_goo_id
                        and tb.goo_id = ta2.goo_id
                        and t3c.company_id = tb.company_id) z1
              group by z1.company_id,z1.factory_company_name,z1.category_name,z1.year) dl
    on dl.company_id = z.company_id
   and dl.year = z.year
   and dl.category_name = z.category
   and dl.factory_company_name = z.factory_name ) tkb
    on (tka.company_id = tkb.company_id and tka.supplier_info_id = tkb.supplier_info_id  and tka.category = tkb.category
        and tka.factory_name = tkb.factory_name and tka.t_performance_maintenance_year_id = tkb.t_performance_maintenance_year_id)
    when matched then
        update
           set tka.order_status             = tkb.order_status,
               tka.order_money              = tkb.order_money,
               tka.delivery_money           = tkb.delivery_money,
               tka.maintenance_progress     = tkb.maintenance_progress;
  end;
   end p_performance_maintenance_year;

function f_performance_402_select_sql(maintenance_progress varchar2,
                                      commit_status        varchar2,
                                      order_status         varchar2,
                                      classifications      varchar2) return clob is
  v1_sql clob := q'[select *
  from (select t.t_performance_maintenance_year_id,
               t.commit_status,
               t.maintenance_progress,
               (t.year || '年') year_pm,
               t.category_id,
               t.category classifications,
               t.factory_abbreviation production_supplier,
               t.order_status,
               t.order_money orders_money,
               t.delivery_money order_delivery_money,
               t.overall_assessment_score,
               t.priority_order,
               t.production_progress_feedback,
               t.response_speed_and_attitude,
               t.check_cooperation_degree,
               t.quality_problem,
               t.major_quality_problem,
               t.integrity,
               t.finance,
               st.company_user_name newest_update_id,
               t.update_time newest_update_time,
               st1.company_user_name commit_id,
               t.commit_time
          from scmdata.t_performance_maintenance_year t
          left join scmdata.sys_company_user st
            on st.company_id = t.company_id
           and st.user_id = t.update_id
          left join scmdata.sys_company_user st1
            on st1.company_id = t.company_id
           and st1.user_id = t.commit_id
         where t.company_id = %default_company_id%
    and (%is_company_admin% = 1 or instr_priv(p_str1 => {declare v_class_data_privs clob;
          begin
            v_class_data_privs := pkg_data_privs.parse_json(p_jsonstr => %data_privs_json_strs%,
                                                            p_key     => 'COL_2');
            @strresult         := '''' || v_class_data_privs || '''';
          end;
          }, p_str2 => t.category_id, p_split => ';') > 0)
         order by t.year desc, t.order_money desc nulls last) 
]';
  vc_sql clob;
begin
    if   maintenance_progress = '全部' and commit_status = '全部'and order_status = '全部' and classifications =  '全部' then
   vc_sql :=  v1_sql;  
    elsif maintenance_progress <> '全部' and commit_status <> '全部'and order_status <> '全部' and classifications <>  '全部' then
   vc_sql :=  v1_sql || 'where maintenance_progress = ' ||''''|| maintenance_progress ||''''||'
 and commit_status = ' ||''''|| commit_status||''''||'
 and order_status = ' || ''''|| order_status ||''''||'
 and classifications ='||''''|| classifications||'''' ;
    elsif maintenance_progress =  '全部' and commit_status <> '全部'and order_status <> '全部' and classifications <>  '全部' then
   vc_sql :=  v1_sql || 'where  commit_status = ' ||''''|| commit_status||''''||'
 and order_status = ' || ''''|| order_status ||''''||'
 and classifications ='||''''|| classifications||'''' ;
    elsif maintenance_progress <> '全部' and commit_status = '全部'and order_status <> '全部' and classifications <>  '全部' then
   vc_sql :=  v1_sql || 'where maintenance_progress = ' ||''''|| maintenance_progress ||''''||'
 and order_status = ' || ''''|| order_status ||''''||'
 and classifications ='||''''|| classifications||'''' ;
    elsif maintenance_progress <> '全部' and commit_status <> '全部'and order_status = '全部' and classifications <>  '全部' then
   vc_sql :=  v1_sql || 'where maintenance_progress = ' ||''''|| maintenance_progress ||''''||'
 and commit_status = ' ||''''|| commit_status||''''||'
 and classifications ='||''''|| classifications||'''' ;
    elsif maintenance_progress <> '全部' and commit_status <> '全部'and order_status <> '全部' and classifications =  '全部' then
   vc_sql :=  v1_sql || 'where maintenance_progress = ' ||''''|| maintenance_progress ||''''||'
 and commit_status = ' ||''''|| commit_status||''''||'
 and order_status = ' || ''''|| order_status ||'''' ;
    elsif maintenance_progress = '全部' and commit_status = '全部'and order_status <> '全部' and classifications <>  '全部' then
   vc_sql :=  v1_sql || 'where  order_status = ' || ''''|| order_status ||''''||'
 and classifications ='||''''|| classifications||'''' ;
    elsif maintenance_progress = '全部' and commit_status <> '全部'and order_status = '全部' and classifications<>  '全部' then
   vc_sql :=  v1_sql || 'where  commit_status = ' ||''''|| commit_status||''''||'
 and classifications ='||''''|| classifications||'''' ;
    elsif maintenance_progress = '全部' and commit_status <> '全部'and order_status <> '全部' and classifications =  '全部' then
   vc_sql :=  v1_sql || 'where  commit_status = ' ||''''|| commit_status||''''||'
 and order_status = ' || ''''|| order_status ||'''' ;
    elsif maintenance_progress <> '全部' and commit_status = '全部'and order_status = '全部' and classifications <>  '全部' then
   vc_sql :=  v1_sql || 'where maintenance_progress = ' ||''''|| maintenance_progress ||''''||'
 and classifications ='||''''|| classifications||'''' ;
    elsif maintenance_progress <> '全部' and commit_status = '全部'and order_status <> '全部' and classifications =  '全部' then
   vc_sql :=  v1_sql || 'where maintenance_progress = ' ||''''|| maintenance_progress ||''''||'
 and order_status = ' || ''''|| order_status ||'''';
    elsif maintenance_progress <> '全部' and commit_status <> '全部'and order_status = '全部' and classifications =  '全部' then
   vc_sql :=  v1_sql || 'where maintenance_progress = ' ||''''|| maintenance_progress ||''''||'
 and commit_status = ' ||''''|| commit_status||'''' ;
    elsif maintenance_progress = '全部' and commit_status = '全部'and order_status = '全部' and classifications <>  '全部' then
   vc_sql :=  v1_sql || 'where  classifications ='||''''|| classifications||'''' ;
    elsif maintenance_progress = '全部' and commit_status <> '全部'and order_status = '全部' and classifications = '全部' then
   vc_sql :=  v1_sql || 'where commit_status = ' ||''''|| commit_status||'''';
    elsif maintenance_progress = '全部' and commit_status = '全部'and order_status <> '全部' and classifications =  '全部' then
   vc_sql :=  v1_sql || 'where order_status = ' || ''''|| order_status ||'''' ;
    elsif maintenance_progress <> '全部' and commit_status = '全部'and order_status = '全部' and classifications =  '全部' then
   vc_sql :=  v1_sql || 'where maintenance_progress = ' ||''''|| maintenance_progress ||'''' ;
    end if ;
  return vc_sql;
end f_performance_402_select_sql;

 function f_performance_402_update_sql(vc_user_id      varchar2,
                                      vc_id           varchar2) return clob is
   v_num1  number;
   v_num2  number;
   v_num3  number;
   vc_sql  clob;
 begin
/*跟单*/
 select pkg_plat_comm.f_hasaction_application(vc_user_id,vc_id,'P0010503')
   into v_num1
   from dual ;
/*QC*/
 select pkg_plat_comm.f_hasaction_application(vc_user_id,vc_id,'P0010504')
   into v_num2
   from dual ;
/*供管*/
 select pkg_plat_comm.f_hasaction_application(vc_user_id,vc_id,'P0010505')
   into v_num3
   from dual ;

     if v_num1 = 1 and v_num2=0 and  v_num3=0 then
 vc_sql := q'[declare
          v_1 number;v_2 number;v_3 number;v_4 number;v_5 number;v_6 varchar2(4);v_7 varchar2(4);v_8 varchar2(4);
begin
  update scmdata.t_performance_maintenance_year t
     set t.priority_order               = :priority_order,
         t.production_progress_feedback = :production_progress_feedback,
         t.response_speed_and_attitude  = :response_speed_and_attitude,
         t.commit_status                = '未提交',
         update_time                    = sysdate,
         update_id                      = ']'||vc_user_id ||''''||
  q'[ where t.t_performance_maintenance_year_id = :t_performance_maintenance_year_id
     and company_id = ']'||vc_id||''''||q'[;
               select max(t.priority_order),
                      max(t.production_progress_feedback),
                      max(t.response_speed_and_attitude),
                      max(t.check_cooperation_degree),
                      max(t.quality_problem),
                      max(t.major_quality_problem),
                      max(t.integrity),
                      max(t.finance)
                 into v_1, v_2, v_3, v_4, v_5, v_6, v_7, v_8
                 from scmdata.t_performance_maintenance_year t
                where t.t_performance_maintenance_year_id = :t_performance_maintenance_year_id;
            if v_1 is not null and v_2 is not null and v_3 is not null and v_4 is not null and v_5 is not null then
                 update scmdata.t_performance_maintenance_year t
                    set t.overall_assessment_score =
                        (t.priority_order * 0.2) + (t.production_progress_feedback * 0.2) +
                        (t.response_speed_and_attitude * 0.2) +
                        (t.check_cooperation_degree * 0.2) + (t.quality_problem * 0.2)
                  where t.t_performance_maintenance_year_id = :t_performance_maintenance_year_id;
            end if;
            if v_1 is not null and v_2 is not null and v_3 is not null  and v_4 is not null 
              and v_5 is not null and v_6 is not null and v_7 is not null and v_8 is not null then
                 update scmdata.t_performance_maintenance_year t
                    set t.maintenance_progress = '已完成'
                  where t.t_performance_maintenance_year_id = :t_performance_maintenance_year_id;
            end if;
end;]';
     elsif v_num1=0 and v_num2=1 and v_num3=0 then
         vc_sql := q'[declare
          v_1 number;v_2 number;v_3 number;v_4 number;v_5 number;v_6 varchar2(4);v_7 varchar2(4);v_8 varchar2(4);
              begin
                update scmdata.t_performance_maintenance_year t
                   set t.check_cooperation_degree = :check_cooperation_degree,
                       t.quality_problem          = :quality_problem,
                       t.commit_status            = '未提交',
                       update_time                = sysdate,
                       update_id                  = ']'||vc_user_id ||''''||
                q'[ where t.t_performance_maintenance_year_id = :t_performance_maintenance_year_id
                   and company_id = ']'||vc_id||''''||q'[;
               select max(t.priority_order),
                      max(t.production_progress_feedback),
                      max(t.response_speed_and_attitude),
                      max(t.check_cooperation_degree),
                      max(t.quality_problem),
                      max(t.major_quality_problem),
                      max(t.integrity),
                      max(t.finance)
                 into v_1, v_2, v_3, v_4, v_5, v_6, v_7, v_8
                 from scmdata.t_performance_maintenance_year t
                where t.t_performance_maintenance_year_id = :t_performance_maintenance_year_id;
            if v_1 is not null and v_2 is not null and v_3 is not null and v_4 is not null and v_5 is not null then
                 update scmdata.t_performance_maintenance_year t
                    set t.overall_assessment_score =
                        (t.priority_order * 0.2) + (t.production_progress_feedback * 0.2) +
                        (t.response_speed_and_attitude * 0.2) +
                        (t.check_cooperation_degree * 0.2) + (t.quality_problem * 0.2)
                  where t.t_performance_maintenance_year_id = :t_performance_maintenance_year_id;
            end if;
            if v_1 is not null and v_2 is not null and v_3 is not null  and v_4 is not null 
              and v_5 is not null and v_6 is not null and v_7 is not null and v_8 is not null then
                 update scmdata.t_performance_maintenance_year t
                    set t.maintenance_progress = '已完成'
                  where t.t_performance_maintenance_year_id = :t_performance_maintenance_year_id;
            end if;
              end;]';
    elsif v_num1=1 and v_num2=1 and v_num3=0 then
     vc_sql := q'[declare
          v_1 number;v_2 number;v_3 number;v_4 number;v_5 number;v_6 varchar2(4);v_7 varchar2(4);v_8 varchar2(4);
        begin
          update scmdata.t_performance_maintenance_year t
             set t.priority_order               = :priority_order,
                 t.production_progress_feedback = :production_progress_feedback,
                 t.response_speed_and_attitude  = :response_speed_and_attitude,
                 t.check_cooperation_degree     = :check_cooperation_degree,
                 t.quality_problem              = :quality_problem,
                 t.commit_status                = '未提交',
                 update_time                    = sysdate,
                 update_id                      = ']'||vc_user_id ||''''||
          q'[ where t.t_performance_maintenance_year_id = :t_performance_maintenance_year_id
             and company_id = ']'||vc_id||''''|| q'[;
               select max(t.priority_order),
                      max(t.production_progress_feedback),
                      max(t.response_speed_and_attitude),
                      max(t.check_cooperation_degree),
                      max(t.quality_problem),
                      max(t.major_quality_problem),
                      max(t.integrity),
                      max(t.finance)
                 into v_1, v_2, v_3, v_4, v_5, v_6, v_7, v_8
                 from scmdata.t_performance_maintenance_year t
                where t.t_performance_maintenance_year_id = :t_performance_maintenance_year_id;
            if v_1 is not null and v_2 is not null and v_3 is not null and v_4 is not null and v_5 is not null then
                 update scmdata.t_performance_maintenance_year t
                    set t.overall_assessment_score =
                        (t.priority_order * 0.2) + (t.production_progress_feedback * 0.2) +
                        (t.response_speed_and_attitude * 0.2) +
                        (t.check_cooperation_degree * 0.2) + (t.quality_problem * 0.2)
                  where t.t_performance_maintenance_year_id = :t_performance_maintenance_year_id;
            end if;
            if v_1 is not null and v_2 is not null and v_3 is not null  and v_4 is not null 
              and v_5 is not null and v_6 is not null and v_7 is not null and v_8 is not null then
                 update scmdata.t_performance_maintenance_year t
                    set t.maintenance_progress = '已完成'
                  where t.t_performance_maintenance_year_id = :t_performance_maintenance_year_id;
            end if;
        end;]';
    elsif v_num3=1 then
     vc_sql := q'[declare
          v_1 number;v_2 number;v_3 number;v_4 number;v_5 number;v_6 varchar2(4);v_7 varchar2(4);v_8 varchar2(4);
        begin
         update scmdata.t_performance_maintenance_year t
            set t.priority_order               = :priority_order,
                t.production_progress_feedback = :production_progress_feedback,
                t.response_speed_and_attitude  = :response_speed_and_attitude,
                t.check_cooperation_degree     = :check_cooperation_degree,
                t.quality_problem              = :quality_problem,
                t.major_quality_problem        = :major_quality_problem,
                t.integrity                    = :integrity,
                t.finance                      = :finance,
                t.commit_status                = '未提交',
                update_time                    = sysdate,
                update_id                      = ']'||vc_user_id ||''''||
          q'[ where t.t_performance_maintenance_year_id = :t_performance_maintenance_year_id
             and company_id = ']'||vc_id||''''|| q'[;
               select max(t.priority_order),
                      max(t.production_progress_feedback),
                      max(t.response_speed_and_attitude),
                      max(t.check_cooperation_degree),
                      max(t.quality_problem),
                      max(t.major_quality_problem),
                      max(t.integrity),
                      max(t.finance)
                 into v_1, v_2, v_3, v_4, v_5, v_6, v_7, v_8
                 from scmdata.t_performance_maintenance_year t
                where t.t_performance_maintenance_year_id = :t_performance_maintenance_year_id;
            if v_1 is not null and v_2 is not null and v_3 is not null and v_4 is not null and v_5 is not null then
                 update scmdata.t_performance_maintenance_year t
                    set t.overall_assessment_score =
                        (t.priority_order * 0.2) + (t.production_progress_feedback * 0.2) +
                        (t.response_speed_and_attitude * 0.2) +
                        (t.check_cooperation_degree * 0.2) + (t.quality_problem * 0.2)
                  where t.t_performance_maintenance_year_id = :t_performance_maintenance_year_id;
            end if;
            if v_1 is not null and v_2 is not null and v_3 is not null  and v_4 is not null 
              and v_5 is not null and v_6 is not null and v_7 is not null and v_8 is not null then
                 update scmdata.t_performance_maintenance_year t
                    set t.maintenance_progress = '已完成'
                  where t.t_performance_maintenance_year_id = :t_performance_maintenance_year_id;
            end if;
        end;]';
     end if;
    return vc_sql;
 end f_performance_402_update_sql;

   procedure p_performance_report_quarter is
   begin
    merge into scmdata.t_performance_evaluation_report_quarter tka
    using (select t.t_performance_maintenance_quarter_id,t.company_id,t.year, t.quarter, t.supplier_code, t.category, t.category_id, t.factory_name, t.factory_abbreviation, pt1.order_money, pt2.delivery_money,
       (case when od.sho_order_money <> 0 then od.sho_order_money/od.order_money end )order_actualvalue, 
       t.overall_assessment_score, 
       t.major_quality_problem,
       t.integrity,t.finance
  from t_performance_maintenance_quarter t
 inner join (select to_char(pt.order_create_date, 'yyyy') year,to_char(pt.order_create_date, 'Q') quarter,pt.factory_code,pt.category_name,
                    pt.company_id,pt.factory_company_name,sum(pt.order_money) order_money
               from scmdata.pt_ordered pt
              where pt.factory_code is not null
              group by to_char(pt.order_create_date, 'yyyy'),to_char(pt.order_create_date, 'Q'),
                       pt.company_id,pt.category_name,pt.factory_code,pt.factory_company_name) pt1
    on pt1.company_id = t.company_id
   and pt1.year = t.year
   and pt1.quarter = t.quarter
   and pt1.factory_code = t.supplier_code
   and pt1.category_name = t.category
   and pt1.factory_company_name = t.factory_name
  left join (select z1.company_id, z1.factory_company_name,z1.factory_code,z1.category_name,z1.year, z1.quarter,sum(z1.sum_money) delivery_money
               from (select t3c.company_id,t3c.factory_company_name,t3c.factory_code,t3c.category_name,to_char(ta2.delivery_date, 'yyyy') year,
                            to_char(ta2.delivery_date, 'Q') quarter,(t3c.fixed_price * ta2.delivery_amount) sum_money
                       from scmdata.pt_ordered t3c
                      inner join scmdata.t_delivery_record ta2
                         on t3c.product_gress_code = ta2.order_code
                        and t3c.company_id = ta2.company_id
                       left join scmdata.t_commodity_info tb
                         on t3c.goo_id = tb.rela_goo_id
                        and tb.goo_id = ta2.goo_id
                        and t3c.company_id = tb.company_id
                       where t3c.factory_code is not null) z1
              group by z1.company_id,z1.factory_company_name, z1.factory_code,z1.category_name,z1.year,z1.quarter)pt2
    on pt2.company_id = t.company_id
   and pt2.year = t.year
   and pt2.quarter = t.quarter
   and pt2.factory_code = t.supplier_code
   and pt2.category_name = t.category
   and pt2.factory_company_name = t.factory_name
  left join (select k.company_id, k.year,k.quarter,k.category_name,k.factory_code,k.order_money,z.sho_order_money
               from (select t.company_id, t.year,t.quarter,t.category_name,t.factory_code,sum(t.order_money) order_money
                       from scmdata.pt_ordered t
                      where t.factory_code is not null
                      group by t.company_id,t.year,t.quarter,t.category_name,t.factory_code) k
                       left join (select tp.company_id,tp.factory_code, tp.year,tp.quarter,tp.category, tp.category_name,sum(tp.sum_money) sho_order_money
                                    from (select t3.company_id,t3.factory_code, t3.year,t3.quarter, t3.category,t3.category_name,t3.satisfy_money sum_money
                                            from scmdata.pt_ordered t3
                                           where t3.factory_code is not null
                                           union all
                                          select t3a.company_id,t3a.factory_code,t3a.year,t3a.quarter,t3a.category, t3a.category_name, (t3a.order_money  - t3a.satisfy_money) sum_money
                                            from scmdata.pt_ordered t3a
                                           inner join scmdata.sys_company_dept a
                                              on a.company_id = t3a.company_id
                                             and a.company_dept_id = t3a.responsible_dept
                                             and a.pause = 0
                                           where (a.dept_name like '%物流部%'or a.dept_name like '%品类部%'
                                                or a.dept_name like '%事业部%' or a.dept_name = '无')
                                             and t3a.factory_code is not null) tp
                                            group by tp.company_id, tp.factory_code,tp.year,tp.quarter,tp.category, tp.category_name)z
                        on k.company_id = z.company_id
                       and k.year = z.year
                       and k.quarter = z.quarter
                       and k.factory_code = z.factory_code 
                       and k.category_name = z.category_name ) od
    on od.company_id = t.company_id
   and od.year = t.year
   and od.quarter = t.quarter
   and od.factory_code = t.supplier_code
   and od.category_name = t.category
 where t.commit_status = '已提交') tkb
    on (tka.t_performance_maintenance_quarter_id = tkb.t_performance_maintenance_quarter_id 
         and tka.company_id = tkb.company_id 
         and tka.supplier_code = tkb.supplier_code and tka.category = tkb.category
         and tka.factory_name = tkb.factory_name
         and tka.year = tkb.year and tka.quarter = tkb.quarter)
    when not matched then
        insert
          (tka.t_performance_evaluation_report_quarter_id,
           tka.t_performance_maintenance_quarter_id,
           tka.company_id,
           tka.year,
           tka.quarter,
           tka.supplier_code,
           tka.factory_abbreviation,
           tka.factory_name,
           tka.category_id,
           tka.category,
           tka.status,
           tka.order_money,
           tka.delivery_money,
           tka.order_actualvalue,
           tka.order_score,
           tka.overall_assessment_actualvalue,
           tka.overall_assessment_score,
           tka.major_quality_problem,
           tka.integrity,
           tka.finance,
           tka.create_id,
           tka.create_time)
        values
          (scmdata.f_get_uuid(),
           tkb.t_performance_maintenance_quarter_id,
           tkb.company_id,
           tkb.year,
           tkb.quarter,
           tkb.supplier_code,
           tkb.factory_abbreviation,
           tkb.factory_name,
           tkb.category_id,
           tkb.category,
           '待确认',
           tkb.order_money,
           tkb.delivery_money,
           tkb.order_actualvalue,
           (case when tkb.order_actualvalue is not null then tkb.order_actualvalue * 0.35 end),
           tkb.overall_assessment_score,
           (case when tkb.overall_assessment_score is not null then ((tkb.overall_assessment_score*10) * 0.2) end) ,
           tkb.major_quality_problem,
           tkb.integrity,
           tkb.finance,
           'ADMIN',
           sysdate); 

    begin
    merge into scmdata.t_performance_evaluation_report_quarter tka 
    using ( select y.factory_name,y.category_name,y.factory_code,y.company_id, y.year, y.quarter,(case when nvl(y.qualified_number,0)=0 then 0 else y.qualified_number/y.qc_number end)finalcheck_actualvalue
from(select base.supplier factory_name,base.category_name,base.factory_code,base.company_id, to_char(base.finish_time, 'yyyy')year, to_char(base.finish_time, 'Q') quarter,
      sum(base.order_money) qc_number,
      sum(case when base.last_qc_result = 'NORMAL_IS_QUALIFIED' then base.order_money end) qualified_number
  from (select k.order_id,k.factory_code,k.company_id, k.supplier, min(k.finish_time) finish_time, k.qc_check_node,k.last_qc_result,k.order_money ,k.category_name
          from (select o.order_id,o.factory_code, o.company_id,si.supplier_company_name supplier, qc.finish_time, g.qc_check_node,pt.order_money ,pt.category_name,
                       first_value(qc.qc_result) over(partition by o.order_id, g.qc_check_node order by nvl(qc.finish_time, timestamp'2000-01-01 00:00:00')) LAST_QC_RESULT
                  from scmdata.t_orders o
                 inner join (select a.group_dict_value qc_check_node
                              from scmdata.sys_group_dict a
                             where a.group_dict_type = 'QC_CHECK_NODE_DICT'
                               and a.pause = 0) g
                    on 1 = 1
                 inner join scmdata.t_ordered oe
                    on o.order_id = oe.order_code
                   and o.company_id = oe.company_id
                 inner join scmdata.pt_ordered pt
                    on pt.company_id = o.company_id
                   and pt.product_gress_code = o.order_id
                 left join scmdata.t_qc_check qc
                    on qc.finish_time is not null
                   and qc.qc_check_node = g.qc_check_node
                   and qc.pause = 0
                   and exists (select 1 from scmdata.t_qc_check_rela_order a 
                                where a.orders_id = o.orders_id and a.qc_check_id = qc.qc_check_id)
                 inner join scmdata.t_commodity_info ci
                    on o.goo_id = ci.goo_id
                   and ci.company_id = o.company_id
                 inner join scmdata.t_supplier_info si
                    on si.supplier_code = o.factory_code
                   and si.company_id = oe.company_id
                 where g.qc_check_node = 'QC_FINAL_CHECK'
                   and qc.finish_time is not null) k
         group by k.order_id,k.factory_code, k.company_id,k.supplier, k.qc_check_node, k.last_qc_result,k.order_money,k.category_name) base
group by base.supplier,base.factory_code,base.company_id, base.category_name,to_char(base.finish_time, 'yyyy'), to_char(base.finish_time, 'Q') ) y) tkb
      on ( tka.company_id = tkb.company_id and tka.supplier_code = tkb.factory_code
         and tka.category = tkb.category_name and tka.factory_name = tkb.factory_name
         and tka.year = tkb.year and tka.quarter = tkb.quarter)
    when matched then
        update
           set tka.finalcheck_actualvalue = tkb.finalcheck_actualvalue,
               tka.finalcheck_score       = (case when tkb.finalcheck_actualvalue is not null then tkb.finalcheck_actualvalue * 0.2 end),
               tka.update_id              = 'ADMIN',
               tka.update_time            = sysdate;
  end;
   end p_performance_report_quarter;

   procedure p_performance_401_action_sql is

   begin
    merge into scmdata.t_performance_evaluation_report_quarter tka 
    using ( select t.t_performance_maintenance_quarter_id,t.company_id,t.year, t.quarter, t.supplier_code, t.category, t.category_id,
                   t.factory_name, t.factory_abbreviation,t.overall_assessment_score,((t.overall_assessment_score*10) * 0.2)overall_score,
                   t.major_quality_problem, t.integrity,t.finance
              from t_performance_maintenance_quarter t
             where t.commit_status = '已提交'
               and exists (select t.t_performance_maintenance_quarter_id from scmdata.t_performance_evaluation_report_quarter t)) tkb
      on ( tka.company_id = tkb.company_id and tka.t_performance_maintenance_quarter_id = tkb.t_performance_maintenance_quarter_id
         and tka.supplier_code = tkb.supplier_code and tka.year = tkb.year and tka.quarter = tkb.quarter)
    when matched then
        update
           set tka.category                       = tkb.category,
               tka.category_id                    = tkb.category_id,
               tka.factory_name                   = tkb.factory_name,
               tka.factory_abbreviation           = tkb.factory_abbreviation,
               tka.overall_assessment_actualvalue = tkb.overall_assessment_score,
               tka.overall_assessment_score       = tkb.overall_score,
               tka.major_quality_problem          = tkb.major_quality_problem,
               tka.integrity                      = tkb.integrity,
               tka.finance                        = tkb.finance,
               tka.update_id                      = 'ADMIN',
               tka.update_time                    = sysdate;

  begin
    merge into scmdata.t_performance_evaluation_report_quarter tka
    using (select t.t_performance_maintenance_quarter_id,t.company_id,t.year, t.quarter, t.supplier_code, t.category, t.category_id, 
                  t.factory_name, t.factory_abbreviation, pt1.order_money, pt2.delivery_money,
       (case when od.sho_order_money <> 0 then od.sho_order_money/od.order_money end )order_actualvalue, 
       t.overall_assessment_score, 
       t.major_quality_problem,
       t.integrity,t.finance
  from t_performance_maintenance_quarter t
 inner join (select to_char(pt.order_create_date, 'yyyy') year,to_char(pt.order_create_date, 'Q') quarter,pt.factory_code,pt.category_name,
                    pt.company_id,pt.factory_company_name,sum(pt.order_money) order_money
               from scmdata.pt_ordered pt
              where pt.factory_code is not null
              group by to_char(pt.order_create_date, 'yyyy'),to_char(pt.order_create_date, 'Q'),
                       pt.company_id,pt.category_name,pt.factory_code,pt.factory_company_name) pt1
    on pt1.company_id = t.company_id
   and pt1.year = t.year
   and pt1.quarter = t.quarter
   and pt1.factory_code = t.supplier_code
   and pt1.category_name = t.category
   and pt1.factory_company_name = t.factory_name
  left join (select z1.company_id, z1.factory_company_name,z1.factory_code,z1.category_name,z1.year, z1.quarter,sum(z1.sum_money) delivery_money
               from (select t3c.company_id,t3c.factory_company_name,t3c.factory_code,t3c.category_name,to_char(ta2.delivery_date, 'yyyy') year,
                            to_char(ta2.delivery_date, 'Q') quarter,(t3c.fixed_price * ta2.delivery_amount) sum_money
                       from scmdata.pt_ordered t3c
                      inner join scmdata.t_delivery_record ta2
                         on t3c.product_gress_code = ta2.order_code
                        and t3c.company_id = ta2.company_id
                       left join scmdata.t_commodity_info tb
                         on t3c.goo_id = tb.rela_goo_id
                        and tb.goo_id = ta2.goo_id
                        and t3c.company_id = tb.company_id
                       where t3c.factory_code is not null) z1
              group by z1.company_id,z1.factory_company_name, z1.factory_code,z1.category_name,z1.year,z1.quarter)pt2
    on pt2.company_id = t.company_id
   and pt2.year = t.year
   and pt2.quarter = t.quarter
   and pt2.factory_code = t.supplier_code
   and pt2.category_name = t.category
   and pt2.factory_company_name = t.factory_name
  left join (select k.company_id, k.year,k.quarter,k.category_name,k.factory_code,k.order_money,z.sho_order_money
               from (select t.company_id, t.year,t.quarter,t.category_name,t.factory_code,sum(t.order_money) order_money
                       from scmdata.pt_ordered t
                      where t.factory_code is not null
                      group by t.company_id,t.year,t.quarter,t.category_name,t.factory_code) k
                       left join (select tp.company_id,tp.factory_code, tp.year,tp.quarter,tp.category, tp.category_name,sum(tp.sum_money) sho_order_money
                                    from (select t3.company_id,t3.factory_code, t3.year,t3.quarter, t3.category,t3.category_name,t3.satisfy_money sum_money
                                            from scmdata.pt_ordered t3
                                           where t3.factory_code is not null
                                           union all
                                          select t3a.company_id,t3a.factory_code,t3a.year,t3a.quarter,t3a.category, t3a.category_name, (t3a.order_money  - t3a.satisfy_money) sum_money
                                            from scmdata.pt_ordered t3a
                                           inner join scmdata.sys_company_dept a
                                              on a.company_id = t3a.company_id
                                             and a.company_dept_id = t3a.responsible_dept
                                             and a.pause = 0
                                           where (a.dept_name like '%物流部%'or a.dept_name like '%品类部%'
                                               or a.dept_name like '%事业部%' or a.dept_name = '无')
                                             and t3a.factory_code is not null) tp
                                            group by tp.company_id, tp.factory_code,tp.year,tp.quarter,tp.category, tp.category_name)z
                        on k.company_id = z.company_id
                       and k.year = z.year
                       and k.quarter = z.quarter
                       and k.factory_code = z.factory_code 
                       and k.category_name = z.category_name ) od
    on od.company_id = t.company_id
   and od.year = t.year
   and od.quarter = t.quarter
   and od.factory_code = t.supplier_code
   and od.category_name = t.category
 where t.commit_status = '已提交'
   and not exists (select t.t_performance_maintenance_quarter_id from scmdata.t_performance_evaluation_report_quarter t)) tkb
    on (tka.t_performance_maintenance_quarter_id = tkb.t_performance_maintenance_quarter_id 
         and tka.company_id = tkb.company_id 
         and tka.supplier_code = tkb.supplier_code and tka.category = tkb.category
         and tka.factory_name = tkb.factory_name
         and tka.year = tkb.year and tka.quarter = tkb.quarter)
    when not matched then
        insert
          (tka.t_performance_evaluation_report_quarter_id,
           tka.t_performance_maintenance_quarter_id,
           tka.company_id,
           tka.year,
           tka.quarter,
           tka.supplier_code,
           tka.factory_abbreviation,
           tka.factory_name,
           tka.category_id,
           tka.category,
           tka.status,
           tka.order_money,
           tka.delivery_money,
           tka.order_actualvalue,
           tka.order_score,
           tka.overall_assessment_actualvalue,
           tka.overall_assessment_score,
           tka.major_quality_problem,
           tka.integrity,
           tka.finance,
           tka.create_id,
           tka.create_time)
        values
          (scmdata.f_get_uuid(),
           tkb.t_performance_maintenance_quarter_id,
           tkb.company_id,
           tkb.year,
           tkb.quarter,
           tkb.supplier_code,
           tkb.factory_abbreviation,
           tkb.factory_name,
           tkb.category_id,
           tkb.category,
           '待确认',
           tkb.order_money,
           tkb.delivery_money,
           tkb.order_actualvalue,
           (case when tkb.order_actualvalue <>0  then  (tkb.order_actualvalue * 0.35) end),
           tkb.overall_assessment_score,
           (case when tkb.overall_assessment_score <> 0 then  ((tkb.overall_assessment_score*10) * 0.2) end) ,
           tkb.major_quality_problem,
           tkb.integrity,
           tkb.finance,
           'ADMIN',
           sysdate); 
  end;

    begin
    merge into scmdata.t_performance_evaluation_report_quarter tka 
    using ( select y.factory_name,y.category_name,y.factory_code,y.company_id, y.year, y.quarter,(case when y.qualified_number <> 0 then  y.qualified_number/y.qc_number end)finalcheck_actualvalue
from(select base.supplier factory_name,base.category_name,base.factory_code,base.company_id, to_char(base.finish_time, 'yyyy')year, to_char(base.finish_time, 'Q') quarter,
      sum(base.order_money) qc_number,
      sum(case when base.last_qc_result = 'NORMAL_IS_QUALIFIED' then base.order_money end) qualified_number
  from (select k.order_id,k.factory_code,k.company_id, k.supplier, min(k.finish_time) finish_time, k.qc_check_node,k.last_qc_result,k.order_money ,k.category_name
          from (select o.order_id,o.factory_code, o.company_id,si.supplier_company_name supplier, qc.finish_time, g.qc_check_node,pt.order_money ,pt.category_name,
                       first_value(qc.qc_result) over(partition by o.order_id, g.qc_check_node order by nvl(qc.finish_time, timestamp'2000-01-01 00:00:00')) LAST_QC_RESULT
                  from scmdata.t_orders o
                 inner join (select a.group_dict_value qc_check_node
                              from scmdata.sys_group_dict a
                             where a.group_dict_type = 'QC_CHECK_NODE_DICT'
                               and a.pause = 0) g
                    on 1 = 1
                 inner join scmdata.t_ordered oe
                    on o.order_id = oe.order_code
                   and o.company_id = oe.company_id
                 inner join scmdata.pt_ordered pt
                    on pt.company_id = o.company_id
                   and pt.product_gress_code = o.order_id
                 left join scmdata.t_qc_check qc
                    on qc.finish_time is not null
                   and qc.qc_check_node = g.qc_check_node
                   and qc.pause = 0
                   and exists (select 1 from scmdata.t_qc_check_rela_order a 
                                where a.orders_id = o.orders_id and a.qc_check_id = qc.qc_check_id)
                 inner join scmdata.t_commodity_info ci
                    on o.goo_id = ci.goo_id
                   and ci.company_id = o.company_id
                 inner join scmdata.t_supplier_info si
                    on si.supplier_code = o.factory_code
                   and si.company_id = oe.company_id
                 where g.qc_check_node = 'QC_FINAL_CHECK'
                   and qc.finish_time is not null) k
         group by k.order_id,k.factory_code, k.company_id,k.supplier, k.qc_check_node, k.last_qc_result,k.order_money,k.category_name) base
group by base.supplier,base.factory_code,base.company_id, base.category_name,to_char(base.finish_time, 'yyyy'), to_char(base.finish_time, 'Q') ) y) tkb
      on ( tka.company_id = tkb.company_id and tka.supplier_code = tkb.factory_code
         and tka.category = tkb.category_name and tka.factory_name = tkb.factory_name
         and tka.year = tkb.year and tka.quarter = tkb.quarter)
    when matched then
        update
           set tka.finalcheck_actualvalue = tkb.finalcheck_actualvalue,
               tka.finalcheck_score       = (case when tkb.finalcheck_actualvalue is not null then  tkb.finalcheck_actualvalue * 0.2 end),
               tka.update_id              = 'ADMIN',
               tka.update_time            = sysdate;
  end;
   end p_performance_401_action_sql;

   procedure p_performance_report_year is
   begin
    merge into scmdata.t_performance_evaluation_report_year tka
    using (select t.t_performance_maintenance_year_id,t.company_id,t.year, t.supplier_code, t.category, t.category_id,
          t.factory_name, t.factory_abbreviation, pt1.order_money, pt2.delivery_money,
       (case when od.sho_order_money <> 0 then  od.sho_order_money/od.order_money end )order_actualvalue, 
       t.overall_assessment_score, 
       t.major_quality_problem,
       t.integrity,t.finance
  from t_performance_maintenance_year t
 inner join (select to_char(pt.order_create_date, 'yyyy') year,pt.factory_code,pt.category_name,
                    pt.company_id,pt.factory_company_name,sum(pt.order_money) order_money
               from scmdata.pt_ordered pt
              where pt.factory_code is not null
              group by to_char(pt.order_create_date, 'yyyy'),
                       pt.company_id,pt.category_name,pt.factory_code,pt.factory_company_name) pt1
    on pt1.company_id = t.company_id
   and pt1.year = t.year
   and pt1.factory_code = t.supplier_code
   and pt1.category_name = t.category
   and pt1.factory_company_name = t.factory_name
  left join (select z1.company_id, z1.factory_company_name,z1.factory_code,z1.category_name,z1.year, sum(z1.sum_money) delivery_money
               from (select t3c.company_id,t3c.factory_company_name,t3c.factory_code,t3c.category_name,to_char(ta2.delivery_date, 'yyyy') year,
                           (t3c.fixed_price * ta2.delivery_amount) sum_money
                       from scmdata.pt_ordered t3c
                      inner join scmdata.t_delivery_record ta2
                         on t3c.product_gress_code = ta2.order_code
                        and t3c.company_id = ta2.company_id
                       left join scmdata.t_commodity_info tb
                         on t3c.goo_id = tb.rela_goo_id
                        and tb.goo_id = ta2.goo_id
                        and t3c.company_id = tb.company_id
                       where t3c.factory_code is not null) z1
              group by z1.company_id,z1.factory_company_name, z1.factory_code,z1.category_name,z1.year)pt2
    on pt2.company_id = t.company_id
   and pt2.year = t.year
   and pt2.factory_code = t.supplier_code
   and pt2.category_name = t.category
   and pt2.factory_company_name = t.factory_name
  left join (select k.company_id, k.year,k.category_name,k.factory_code,k.order_money,z.sho_order_money
               from (select t.company_id, t.year,t.category_name,t.factory_code,sum(t.order_money) order_money
                       from scmdata.pt_ordered t
                      where t.factory_code is not null
                      group by t.company_id,t.year,t.category_name,t.factory_code) k
                       left join (select tp.company_id,tp.factory_code, tp.year,tp.category, tp.category_name,sum(tp.sum_money) sho_order_money
                                    from (select t3.company_id,t3.factory_code, t3.year, t3.category,t3.category_name,t3.satisfy_money sum_money
                                            from scmdata.pt_ordered t3
                                           where t3.factory_code is not null
                                           union all
                                          select t3a.company_id,t3a.factory_code,t3a.year,t3a.category, t3a.category_name, (t3a.order_money  - t3a.satisfy_money) sum_money
                                            from scmdata.pt_ordered t3a
                                           inner join scmdata.sys_company_dept a
                                              on a.company_id = t3a.company_id
                                             and a.company_dept_id = t3a.responsible_dept
                                             and a.pause = 0
                                           where (a.dept_name like '%物流部%'or a.dept_name like '%品类部%'
                                                or a.dept_name like '%事业部%' or a.dept_name = '无') 
                                             and t3a.factory_code is not null) tp
                                            group by tp.company_id, tp.factory_code,tp.year,tp.category, tp.category_name)z
                        on k.company_id = z.company_id
                       and k.year = z.year
                       and k.factory_code = z.factory_code 
                       and k.category_name = z.category_name ) od
    on od.company_id = t.company_id
   and od.year = t.year
   and od.factory_code = t.supplier_code
   and od.category_name = t.category
 where t.commit_status = '已提交') tkb
    on (tka.t_performance_maintenance_year_id = tkb.t_performance_maintenance_year_id 
         and tka.company_id = tkb.company_id 
         and tka.supplier_code = tkb.supplier_code and tka.category = tkb.category
         and tka.factory_name = tkb.factory_name
         and tka.year = tkb.year)
    when not matched then
        insert
          (tka.t_performance_evaluation_report_year_id,
           tka.t_performance_maintenance_year_id,
           tka.company_id,
           tka.year,
           tka.supplier_code,
           tka.factory_abbreviation,
           tka.factory_name,
           tka.category_id,
           tka.category,
           tka.status,
           tka.order_money,
           tka.delivery_money,
           tka.order_actualvalue,
           tka.order_score,
           tka.overall_assessment_actualvalue,
           tka.overall_assessment_score,
           tka.major_quality_problem,
           tka.integrity,
           tka.finance,
           tka.create_id,
           tka.create_time)
        values
          (scmdata.f_get_uuid(),
           tkb.t_performance_maintenance_year_id,
           tkb.company_id,
           tkb.year,
           tkb.supplier_code,
           tkb.factory_abbreviation,
           tkb.factory_name,
           tkb.category_id,
           tkb.category,
           '待确认',
           tkb.order_money,
           tkb.delivery_money,
           tkb.order_actualvalue,
           (case when tkb.order_actualvalue is not null then tkb.order_actualvalue * 0.35 end),
           tkb.overall_assessment_score,
           (case when tkb.overall_assessment_score is not null then ((tkb.overall_assessment_score*10) * 0.2) end) ,
           tkb.major_quality_problem,
           tkb.integrity,
           tkb.finance,
           'ADMIN',
           sysdate); 

    begin
    merge into scmdata.t_performance_evaluation_report_year tka 
    using ( select y.factory_name,y.category_name,y.factory_code,y.company_id, y.year, (case when nvl(y.qualified_number,0)=0 then 0 else y.qualified_number/y.qc_number end)finalcheck_actualvalue
from(select base.supplier factory_name,base.category_name,base.factory_code,base.company_id, to_char(base.finish_time, 'yyyy')year, 
      sum(base.order_money) qc_number,
      sum(case when base.last_qc_result = 'NORMAL_IS_QUALIFIED' then base.order_money end) qualified_number
  from (select k.order_id,k.factory_code,k.company_id, k.supplier, min(k.finish_time) finish_time, k.qc_check_node,k.last_qc_result,k.order_money ,k.category_name
          from (select o.order_id,o.factory_code, o.company_id,si.supplier_company_name supplier, qc.finish_time, g.qc_check_node,pt.order_money ,pt.category_name,
                       first_value(qc.qc_result) over(partition by o.order_id, g.qc_check_node order by nvl(qc.finish_time, timestamp'2000-01-01 00:00:00')) LAST_QC_RESULT
                  from scmdata.t_orders o
                 inner join (select a.group_dict_value qc_check_node
                              from scmdata.sys_group_dict a
                             where a.group_dict_type = 'QC_CHECK_NODE_DICT'
                               and a.pause = 0) g
                    on 1 = 1
                 inner join scmdata.t_ordered oe
                    on o.order_id = oe.order_code
                   and o.company_id = oe.company_id
                 inner join scmdata.pt_ordered pt
                    on pt.company_id = o.company_id
                   and pt.product_gress_code = o.order_id
                 left join scmdata.t_qc_check qc
                    on qc.finish_time is not null
                   and qc.qc_check_node = g.qc_check_node
                   and qc.pause = 0
                   and exists (select 1 from scmdata.t_qc_check_rela_order a 
                                where a.orders_id = o.orders_id and a.qc_check_id = qc.qc_check_id)
                 inner join scmdata.t_commodity_info ci
                    on o.goo_id = ci.goo_id
                   and ci.company_id = o.company_id
                 inner join scmdata.t_supplier_info si
                    on si.supplier_code = o.factory_code
                   and si.company_id = oe.company_id
                 where g.qc_check_node = 'QC_FINAL_CHECK'
                   and qc.finish_time is not null) k
         group by k.order_id,k.factory_code, k.company_id,k.supplier, k.qc_check_node, k.last_qc_result,k.order_money,k.category_name) base
group by base.supplier,base.factory_code,base.company_id, base.category_name,to_char(base.finish_time, 'yyyy') ) y) tkb
      on ( tka.company_id = tkb.company_id and tka.supplier_code = tkb.factory_code
         and tka.category = tkb.category_name and tka.factory_name = tkb.factory_name
         and tka.year = tkb.year)
    when matched then
        update
           set tka.finalcheck_actualvalue = tkb.finalcheck_actualvalue,
               tka.finalcheck_score       = (case when tkb.finalcheck_actualvalue is null then 0
                                             else tkb.finalcheck_actualvalue * 0.2 end),
               tka.update_id              = 'ADMIN',
               tka.update_time            = sysdate;
  end;
   end p_performance_report_year;

   procedure p_performance_402_action_sql is
   begin
    merge into scmdata.t_performance_evaluation_report_year tka 
    using ( select t.t_performance_maintenance_year_id,t.company_id,t.year,t.supplier_code, t.category, t.category_id,
                   t.factory_name, t.factory_abbreviation,t.overall_assessment_score,(t.overall_assessment_score * 0.2)overall_score,
                   t.major_quality_problem, t.integrity,t.finance
              from scmdata.t_performance_maintenance_year t
             where t.commit_status = '已提交'
               and exists (select t.t_performance_maintenance_year_id from scmdata.t_performance_evaluation_report_year t)) tkb
      on ( tka.company_id = tkb.company_id and tka.t_performance_maintenance_year_id = tkb.t_performance_maintenance_year_id
         and tka.supplier_code = tkb.supplier_code and tka.year = tkb.year )
    when matched then
        update
           set tka.category                       = tkb.category,
               tka.category_id                    = tkb.category_id,
               tka.factory_name                   = tkb.factory_name,
               tka.factory_abbreviation           = tkb.factory_abbreviation,
               tka.overall_assessment_actualvalue = tkb.overall_assessment_score,
               tka.overall_assessment_score       = tkb.overall_score,
               tka.major_quality_problem          = tkb.major_quality_problem,
               tka.integrity                      = tkb.integrity,
               tka.finance                        = tkb.finance,
               tka.update_id                      = 'ADMIN',
               tka.update_time                    = sysdate;

  begin
    merge into scmdata.t_performance_evaluation_report_year tka
    using (select t.t_performance_maintenance_year_id,t.company_id,t.year, t.supplier_code, t.category, t.category_id, 
                  t.factory_name, t.factory_abbreviation, pt1.order_money, pt2.delivery_money,
       (case when od.sho_order_money <> 0 then  od.sho_order_money/od.order_money end )order_actualvalue, 
       t.overall_assessment_score, 
       t.major_quality_problem,
       t.integrity,t.finance
  from scmdata.t_performance_maintenance_year t
 inner join (select to_char(pt.order_create_date, 'yyyy') year,pt.factory_code,pt.category_name,
                    pt.company_id,pt.factory_company_name,sum(pt.order_money) order_money
               from scmdata.pt_ordered pt
              where pt.factory_code is not null
              group by to_char(pt.order_create_date, 'yyyy'),
                       pt.company_id,pt.category_name,pt.factory_code,pt.factory_company_name) pt1
    on pt1.company_id = t.company_id
   and pt1.year = t.year
   and pt1.factory_code = t.supplier_code
   and pt1.category_name = t.category
   and pt1.factory_company_name = t.factory_name
  left join (select z1.company_id, z1.factory_company_name,z1.factory_code,z1.category_name,z1.year, sum(z1.sum_money) delivery_money
               from (select t3c.company_id,t3c.factory_company_name,t3c.factory_code,t3c.category_name,to_char(ta2.delivery_date, 'yyyy') year,
                            (t3c.fixed_price * ta2.delivery_amount) sum_money
                       from scmdata.pt_ordered t3c
                      inner join scmdata.t_delivery_record ta2
                         on t3c.product_gress_code = ta2.order_code
                        and t3c.company_id = ta2.company_id
                       left join scmdata.t_commodity_info tb
                         on t3c.goo_id = tb.rela_goo_id
                        and tb.goo_id = ta2.goo_id
                        and t3c.company_id = tb.company_id
                       where t3c.factory_code is not null) z1
              group by z1.company_id,z1.factory_company_name, z1.factory_code,z1.category_name,z1.year)pt2
    on pt2.company_id = t.company_id
   and pt2.year = t.year
   and pt2.factory_code = t.supplier_code
   and pt2.category_name = t.category
   and pt2.factory_company_name = t.factory_name
  left join (select k.company_id, k.year,k.category_name,k.factory_code,k.order_money,z.sho_order_money
               from (select t.company_id, t.year,t.category_name,t.factory_code,sum(t.order_money) order_money
                       from scmdata.pt_ordered t
                      where t.factory_code is not null
                      group by t.company_id,t.year,t.category_name,t.factory_code) k
                       left join (select tp.company_id,tp.factory_code, tp.year,tp.category, tp.category_name,sum(tp.sum_money) sho_order_money
                                    from (select t3.company_id,t3.factory_code, t3.year, t3.category,t3.category_name,t3.satisfy_money sum_money
                                            from scmdata.pt_ordered t3
                                           where t3.factory_code is not null
                                           union all
                                          select t3a.company_id,t3a.factory_code,t3a.year,t3a.category, t3a.category_name, (t3a.order_money  - t3a.satisfy_money) sum_money
                                            from scmdata.pt_ordered t3a
                                           inner join scmdata.sys_company_dept a
                                              on a.company_id = t3a.company_id
                                             and a.company_dept_id = t3a.responsible_dept
                                             and a.pause = 0
                                           where (a.dept_name like '%物流部%'or a.dept_name like '%品类部%'
                                                or a.dept_name like '%事业部%' or a.dept_name = '无') 
                                             and t3a.factory_code is not null) tp
                                            group by tp.company_id, tp.factory_code,tp.year,tp.category, tp.category_name)z
                        on k.company_id = z.company_id
                       and k.year = z.year
                       and k.factory_code = z.factory_code 
                       and k.category_name = z.category_name ) od
    on od.company_id = t.company_id
   and od.year = t.year
   and od.factory_code = t.supplier_code
   and od.category_name = t.category
 where t.commit_status = '已提交'
   and not exists (select t.t_performance_maintenance_year_id from scmdata.t_performance_evaluation_report_year t)) tkb
    on (tka.t_performance_maintenance_year_id = tkb.t_performance_maintenance_year_id 
         and tka.company_id = tkb.company_id 
         and tka.supplier_code = tkb.supplier_code and tka.category = tkb.category
         and tka.factory_name = tkb.factory_name and tka.year = tkb.year )
    when not matched then
        insert
          (tka.t_performance_evaluation_report_year_id,
           tka.t_performance_maintenance_year_id,
           tka.company_id,
           tka.year,
           tka.supplier_code,
           tka.factory_abbreviation,
           tka.factory_name,
           tka.category_id,
           tka.category,
           tka.status,
           tka.order_money,
           tka.delivery_money,
           tka.order_actualvalue,
           tka.order_score,
           tka.overall_assessment_actualvalue,
           tka.overall_assessment_score,
           tka.major_quality_problem,
           tka.integrity,
           tka.finance,
           tka.create_id,
           tka.create_time)
        values
          (scmdata.f_get_uuid(),
           tkb.t_performance_maintenance_year_id,
           tkb.company_id,
           tkb.year,
           tkb.supplier_code,
           tkb.factory_abbreviation,
           tkb.factory_name,
           tkb.category_id,
           tkb.category,
           '待确认',
           tkb.order_money,
           tkb.delivery_money,
           tkb.order_actualvalue,
           (case when tkb.order_actualvalue <>0  then  (tkb.order_actualvalue * 0.35) end),
           tkb.overall_assessment_score,
           (case when tkb.overall_assessment_score <>0 then  ((tkb.overall_assessment_score*10) * 0.2) end) ,
           tkb.major_quality_problem,
           tkb.integrity,
           tkb.finance,
           'ADMIN',
           sysdate); 
  end;

    begin
    merge into scmdata.t_performance_evaluation_report_year tka 
    using ( select y.factory_name,y.category_name,y.factory_code,y.company_id, y.year,
           (case when y.qualified_number <> 0 then  y.qualified_number/y.qc_number end)finalcheck_actualvalue
from(select base.supplier factory_name,base.category_name,base.factory_code,base.company_id, to_char(base.finish_time, 'yyyy')year, 
      sum(base.order_money) qc_number,
      sum(case when base.last_qc_result = 'NORMAL_IS_QUALIFIED' then base.order_money end) qualified_number
  from (select k.order_id,k.factory_code,k.company_id, k.supplier, min(k.finish_time) finish_time, k.qc_check_node,k.last_qc_result,k.order_money ,k.category_name
          from (select o.order_id,o.factory_code, o.company_id,si.supplier_company_name supplier, qc.finish_time, g.qc_check_node,pt.order_money ,pt.category_name,
                       first_value(qc.qc_result) over(partition by o.order_id, g.qc_check_node order by nvl(qc.finish_time, timestamp'2000-01-01 00:00:00')) LAST_QC_RESULT
                  from scmdata.t_orders o
                 inner join (select a.group_dict_value qc_check_node
                              from scmdata.sys_group_dict a
                             where a.group_dict_type = 'QC_CHECK_NODE_DICT'
                               and a.pause = 0) g
                    on 1 = 1
                 inner join scmdata.t_ordered oe
                    on o.order_id = oe.order_code
                   and o.company_id = oe.company_id
                 inner join scmdata.pt_ordered pt
                    on pt.company_id = o.company_id
                   and pt.product_gress_code = o.order_id
                 left join scmdata.t_qc_check qc
                    on qc.finish_time is not null
                   and qc.qc_check_node = g.qc_check_node
                   and qc.pause = 0
                   and exists (select 1 from scmdata.t_qc_check_rela_order a 
                                where a.orders_id = o.orders_id and a.qc_check_id = qc.qc_check_id)
                 inner join scmdata.t_commodity_info ci
                    on o.goo_id = ci.goo_id
                   and ci.company_id = o.company_id
                 inner join scmdata.t_supplier_info si
                    on si.supplier_code = o.factory_code
                   and si.company_id = oe.company_id
                 where g.qc_check_node = 'QC_FINAL_CHECK'
                   and qc.finish_time is not null) k
         group by k.order_id,k.factory_code, k.company_id,k.supplier, k.qc_check_node, k.last_qc_result,k.order_money,k.category_name) base
group by base.supplier,base.factory_code,base.company_id, base.category_name,to_char(base.finish_time, 'yyyy') ) y) tkb
      on ( tka.company_id = tkb.company_id and tka.supplier_code = tkb.factory_code
         and tka.category = tkb.category_name and tka.factory_name = tkb.factory_name
         and tka.year = tkb.year )
    when matched then
        update
           set tka.finalcheck_actualvalue = tkb.finalcheck_actualvalue,
               tka.finalcheck_score       = (case when tkb.finalcheck_actualvalue is not null then  tkb.finalcheck_actualvalue * 0.2 end),
               tka.update_id              = 'ADMIN',
               tka.update_time            = sysdate;
  end;
   end p_performance_402_action_sql;

function f_performance_401_1_select_sql(year_q          varchar2,
                                        quarter         varchar2,
                                        order_status    varchar2,
                                        classifications varchar2) return clob is
  v1_sql clob := q'[select *
  from (select t.t_history_performance_maintenance_quarter_id,
               (t.year || '年') year_pm,
               ('第' || t.quarter || '季度') QUARTER,
               t.category_id,
               t.category classifications,
               t.factory_abbreviation production_supplier,
               t.order_status,
               t.order_money orders_money,
               t.delivery_money order_delivery_money,
               t.overall_assessment_score,
               t.priority_order,
               t.production_progress_feedback,
               t.response_speed_and_attitude,
               t.check_cooperation_degree,
               t.quality_problem,
               t.major_quality_problem,
               t.integrity,
               t.finance,
               st1.company_user_name commit_id,
               t.commit_time
          from scmdata.t_history_performance_maintenance_quarter t
          left join scmdata.sys_company_user st1
            on st1.company_id = t.company_id
           and st1.user_id = t.commit_id
         where t.company_id = %default_company_id% 
           and (%is_company_admin% = 1 or instr_priv(p_str1 => {declare v_class_data_privs clob;
          begin
          v_class_data_privs := pkg_data_privs.parse_json(p_jsonstr => %data_privs_json_strs%,
                                                          p_key     => 'COL_2');
          @strresult         := '''' || v_class_data_privs || '''';
          end;
          }, p_str2 => t.category_id, p_split => ';') > 0) 
         order by t.year desc, t.quarter desc, t.order_money desc nulls last) 
]';
  vc_sql clob;
begin
    if   year_q = '全部' and quarter = '全部'and order_status = '全部' and classifications =  '全部' then
   vc_sql :=  v1_sql;  
    elsif year_q <> '全部' and quarter <> '全部'and order_status <> '全部' and classifications <>  '全部' then
   vc_sql :=  v1_sql || 'where year_pm = ' ||''''|| year_q ||''''||'
 and quarter = ' ||''''|| quarter||''''||'
 and order_status = ' || ''''|| order_status ||''''||'
 and classifications ='||''''|| classifications||'''' ;
    elsif year_q =  '全部' and quarter <> '全部'and order_status <> '全部' and classifications <>  '全部' then
   vc_sql :=  v1_sql || 'where  quarter = ' ||''''|| quarter||''''||'
 and order_status = ' || ''''|| order_status ||''''||'
 and classifications ='||''''|| classifications||'''' ;
    elsif year_q <> '全部' and quarter = '全部'and order_status <> '全部' and classifications <>  '全部' then
   vc_sql :=  v1_sql || 'where year_pm = ' ||''''|| year_q ||''''||'
 and order_status = ' || ''''|| order_status ||''''||'
 and classifications ='||''''|| classifications||'''' ;
    elsif year_q <> '全部' and quarter <> '全部'and order_status = '全部' and classifications <>  '全部' then
   vc_sql :=  v1_sql || 'where year_pm = ' ||''''|| year_q ||''''||'
 and quarter = ' ||''''|| quarter||''''||'
 and classifications ='||''''|| classifications||'''' ;
    elsif year_q <> '全部' and quarter <> '全部'and order_status <> '全部' and classifications =  '全部' then
   vc_sql :=  v1_sql || 'where year_pm = ' ||''''|| year_q ||''''||'
 and quarter = ' ||''''|| quarter||''''||'
 and order_status = ' || ''''|| order_status ||'''' ;
    elsif year_q = '全部' and quarter = '全部'and order_status <> '全部' and classifications <>  '全部' then
   vc_sql :=  v1_sql || 'where  order_status = ' || ''''|| order_status ||''''||'
 and classifications ='||''''|| classifications||'''' ;
    elsif year_q = '全部' and quarter <> '全部'and order_status = '全部' and classifications<>  '全部' then
   vc_sql :=  v1_sql || 'where  quarter = ' ||''''|| quarter||''''||'
 and classifications ='||''''|| classifications||'''' ;
    elsif year_q = '全部' and quarter <> '全部'and order_status <> '全部' and classifications =  '全部' then
   vc_sql :=  v1_sql || 'where  quarter = ' ||''''|| quarter||''''||'
 and order_status = ' || ''''|| order_status ||'''' ;
    elsif year_q <> '全部' and quarter = '全部'and order_status = '全部' and classifications <>  '全部' then
   vc_sql :=  v1_sql || 'where year_pm = ' ||''''|| year_q ||''''||'
 and classifications ='||''''|| classifications||'''' ;
    elsif year_q <> '全部' and quarter = '全部'and order_status <> '全部' and classifications =  '全部' then
   vc_sql :=  v1_sql || 'where year_pm = ' ||''''|| year_q ||''''||'
 and order_status = ' || ''''|| order_status ||'''';
    elsif year_q <> '全部' and quarter <> '全部'and order_status = '全部' and classifications =  '全部' then
   vc_sql :=  v1_sql || 'where year_pm = ' ||''''|| year_q ||''''||'
 and quarter = ' ||''''|| quarter||'''' ;
    elsif year_q = '全部' and quarter = '全部'and order_status = '全部' and classifications <>  '全部' then
   vc_sql :=  v1_sql || 'where  classifications ='||''''|| classifications||'''' ;
    elsif year_q = '全部' and quarter <> '全部'and order_status = '全部' and classifications = '全部' then
   vc_sql :=  v1_sql || 'where quarter = ' ||''''|| quarter||'''';
    elsif year_q = '全部' and quarter = '全部'and order_status <> '全部' and classifications =  '全部' then
   vc_sql :=  v1_sql || 'where order_status = ' || ''''|| order_status ||'''' ;
    elsif year_q <> '全部' and quarter = '全部'and order_status = '全部' and classifications =  '全部' then
   vc_sql :=  v1_sql || 'where year_pm = ' ||''''|| year_q ||'''' ;
    end if ;
  return vc_sql;
end f_performance_401_1_select_sql;

function f_performance_402_1_select_sql(year_y          varchar2,
                                        order_status    varchar2,
                                        classifications varchar2) return clob is
  v1_sql clob := q'[select *
  from (select t.t_history_performance_maintenance_year_id,
               (t.year || '年') year_pm,
               t.category_id,
               t.category classifications,
               t.factory_abbreviation production_supplier,
               t.order_status,
               t.order_money orders_money,
               t.delivery_money order_delivery_money,
               t.overall_assessment_score,
               t.priority_order,
               t.production_progress_feedback,
               t.response_speed_and_attitude,
               t.check_cooperation_degree,
               t.quality_problem,
               t.major_quality_problem,
               t.integrity,
               t.finance,
               st1.company_user_name commit_id,
               t.commit_time
          from scmdata.t_history_performance_maintenance_year t
          left join scmdata.sys_company_user st1
            on st1.company_id = t.company_id
           and st1.user_id = t.commit_id
         where t.company_id = %default_company_id% 
           and (%is_company_admin% = 1 or instr_priv(p_str1 => {declare v_class_data_privs clob;
          begin
          v_class_data_privs := pkg_data_privs.parse_json(p_jsonstr => %data_privs_json_strs%,
                                                          p_key     => 'COL_2');
          @strresult         := '''' || v_class_data_privs || '''';
          end;
          }, p_str2 => t.category_id, p_split => ';') > 0) 
         order by t.year desc, t.order_money desc nulls last) 
]';
  vc_sql clob;
begin
    if   year_y = '全部' and  order_status = '全部' and classifications =  '全部' then
   vc_sql :=  v1_sql;  
    elsif year_y <> '全部'  and order_status <> '全部' and classifications <> '全部' then 
   vc_sql :=  v1_sql || 'where year_pm = ' ||''''|| year_y ||''''||'
 and order_status = ' || ''''|| order_status ||''''||'
 and classifications ='||''''|| classifications||'''' ;
    elsif year_y =  '全部'and order_status <> '全部' and classifications <> '全部' then 
   vc_sql :=  v1_sql || 'where  order_status = ' || ''''|| order_status ||''''||'
 and classifications ='||''''|| classifications||'''' ;
    elsif year_y <> '全部' and order_status = '全部' and classifications <> '全部' then 
   vc_sql :=  v1_sql || 'where year_pm = ' ||''''|| year_y ||''''||'
 and classifications ='||''''|| classifications||'''' ;
    elsif year_y <> '全部' and order_status <> '全部' and classifications = '全部' then 
   vc_sql :=  v1_sql || 'where year_pm = ' ||''''|| year_y ||''''||'
 and order_status = ' || ''''|| order_status ||'''' ;
    elsif year_y = '全部' and order_status = '全部' and classifications<> '全部' then 
   vc_sql :=  v1_sql || 'where  classifications ='||''''|| classifications||'''' ; 
    elsif year_y = '全部' and order_status <> '全部' and classifications = '全部' then 
   vc_sql :=  v1_sql || 'where  order_status = ' || ''''|| order_status ||'''' ;
    elsif year_y <> '全部' and order_status = '全部' and classifications = '全部' then  
   vc_sql :=  v1_sql || 'where year_pm = ' ||''''|| year_y ||'''' ;
    end if ;
  return vc_sql;
end f_performance_402_1_select_sql;

   procedure p_performance_301_action_sql is
  begin
    merge into scmdata.t_history_performance_maintenance_quarter tka
    using (select t.t_performance_maintenance_quarter_id,
       t.company_id,
       t.commit_status,
       t.maintenance_progress,
       t.year,
       t.quarter,
       t.category,
       t.category_id,
       t.supplier_info_id,
       t.supplier_code,
       t.factory_name,
       t.factory_abbreviation,
       t.order_status,
       t.order_money,
       t.delivery_money,
       t.overall_assessment_score,
       t.priority_order,
       t.production_progress_feedback,
       t.response_speed_and_attitude,
       t.check_cooperation_degree,
       t.quality_problem,
       t.major_quality_problem,
       t.integrity,
       t.finance,
       t.commit_id,
       t.commit_time
  from scmdata.t_performance_maintenance_quarter t) tkb
    on (tka.t_performance_maintenance_quarter_id = tkb.t_performance_maintenance_quarter_id 
        and tka.company_id  = tkb.company_id and tka.supplier_info_id = tkb.supplier_info_id 
        and tka.category = tkb.category)
    when not matched then
        insert
          (tka.t_history_performance_maintenance_quarter_id ,
           tka.t_performance_maintenance_quarter_id,
           tka.company_id,
           tka.year,
           tka.quarter,
           tka.supplier_info_id, 
           tka.supplier_code,
           tka.factory_abbreviation,
           tka.factory_name,
           tka.category_id,
           tka.category,
           tka.commit_status,
           tka.maintenance_progress ,
           tka.order_status,
           tka.order_money,
           tka.delivery_money,
           tka.overall_assessment_score ,
           tka.priority_order ,
           tka.production_progress_feedback ,
           tka.response_speed_and_attitude ,
           tka.check_cooperation_degree ,
           tka.quality_problem ,
           tka.major_quality_problem ,
           tka.integrity,
           tka.finance,
           tka.commit_id ,
           tka.commit_time, 
           tka.create_id,
           tka.create_time)
        values
          (scmdata.f_get_uuid(),
           tkb.t_performance_maintenance_quarter_id,
           tkb.company_id,
           tkb.year,
           tkb.quarter,
           tkb.supplier_info_id, 
           tkb.supplier_code,
           tkb.factory_abbreviation,
           tkb.factory_name,
           tkb.category_id,
           tkb.category,
           tkb.commit_status,
           tkb.maintenance_progress ,
           tkb.order_status,
           tkb.order_money,
           tkb.delivery_money,
           tkb.overall_assessment_score ,
           tkb.priority_order ,
           tkb.production_progress_feedback ,
           tkb.response_speed_and_attitude ,
           tkb.check_cooperation_degree ,
           tkb.quality_problem ,
           tkb.major_quality_problem ,
           tkb.integrity,
           tkb.finance,
           tkb.commit_id ,
           tkb.commit_time, 
           'ADMIN',
           sysdate); 
   end p_performance_301_action_sql;

   procedure p_performance_301_1_action_sql is
  begin
    merge into scmdata.t_performance_maintenance_quarter tka
    using (select t.supplier_info_id,
       t.category,
       t.category_id,
       t.company_id ,
       t.supplier_code,
       t.factory_name,
       t.factory_abbreviation,
       t.overall_assessment_score,
       t.priority_order,
       t.production_progress_feedback,
       t.response_speed_and_attitude,
       t.check_cooperation_degree,
       t.quality_problem,
       t.major_quality_problem,
       t.integrity,
       t.finance
  from scmdata.t_history_performance_maintenance_quarter t
 inner join (select t2.year, max(t1.quarter) quarter
                                 from scmdata.t_history_performance_maintenance_quarter t1
                                inner join (select max(t.year) year
                                             from scmdata.t_history_performance_maintenance_quarter t) t2
                                   on t2.year = t1.year
                                group by t2.year) t3
    on t3.year = t.year
   and t3.quarter = t.quarter ) tkb
    on (tka.supplier_code = tkb.supplier_code and tka.company_id = tkb.company_id 
        and tka.category_id  = tka.category_id  and tka.supplier_info_id = tkb.supplier_info_id  and tka.category = tkb.category)
    when matched then
      update
         set tka.overall_assessment_score     = tkb.overall_assessment_score,
             tka.priority_order               = tkb.priority_order,
             tka.production_progress_feedback = tkb.production_progress_feedback,
             tka.response_speed_and_attitude  = tkb.response_speed_and_attitude,
             tka.check_cooperation_degree     = tkb.check_cooperation_degree,
             tka.quality_problem              = tkb.quality_problem,
             tka.major_quality_problem        = tkb.major_quality_problem,
             tka.integrity                    = tkb.integrity,
             tka.finance                      = tkb.finance;
   end p_performance_301_1_action_sql;

   procedure p_performance_302_action_sql is
  begin
    merge into scmdata.t_history_performance_maintenance_year tka
    using (select t.t_performance_maintenance_year_id,
       t.company_id,
       t.commit_status,
       t.maintenance_progress,
       t.year,
       t.category,
       t.category_id,
       t.supplier_info_id,
       t.supplier_code,
       t.factory_name,
       t.factory_abbreviation,
       t.order_status,
       t.order_money,
       t.delivery_money,
       t.overall_assessment_score,
       t.priority_order,
       t.production_progress_feedback,
       t.response_speed_and_attitude,
       t.check_cooperation_degree,
       t.quality_problem,
       t.major_quality_problem,
       t.integrity,
       t.finance,
       t.commit_id,
       t.commit_time
  from scmdata.t_performance_maintenance_year t) tkb
    on (tka.t_performance_maintenance_year_id = tkb.t_performance_maintenance_year_id 
        and tka.company_id  = tkb.company_id and tka.supplier_info_id = tkb.supplier_info_id 
        and tka.category = tkb.category)
    when not matched then
        insert
          (tka.t_history_performance_maintenance_year_id ,
           tka.t_performance_maintenance_year_id,
           tka.company_id,
           tka.year,
           tka.supplier_info_id, 
           tka.supplier_code,
           tka.factory_abbreviation,
           tka.factory_name,
           tka.category_id,
           tka.category,
           tka.commit_status,
           tka.maintenance_progress ,
           tka.order_status,
           tka.order_money,
           tka.delivery_money,
           tka.overall_assessment_score ,
           tka.priority_order ,
           tka.production_progress_feedback ,
           tka.response_speed_and_attitude ,
           tka.check_cooperation_degree ,
           tka.quality_problem ,
           tka.major_quality_problem ,
           tka.integrity,
           tka.finance,
           tka.commit_id ,
           tka.commit_time, 
           tka.create_id,
           tka.create_time)
        values
          (scmdata.f_get_uuid(),
           tkb.t_performance_maintenance_year_id,
           tkb.company_id,
           tkb.year,
           tkb.supplier_info_id, 
           tkb.supplier_code,
           tkb.factory_abbreviation,
           tkb.factory_name,
           tkb.category_id,
           tkb.category,
           tkb.commit_status,
           tkb.maintenance_progress ,
           tkb.order_status,
           tkb.order_money,
           tkb.delivery_money,
           tkb.overall_assessment_score ,
           tkb.priority_order ,
           tkb.production_progress_feedback ,
           tkb.response_speed_and_attitude ,
           tkb.check_cooperation_degree ,
           tkb.quality_problem ,
           tkb.major_quality_problem ,
           tkb.integrity,
           tkb.finance,
           tkb.commit_id ,
           tkb.commit_time, 
           'ADMIN',
           sysdate); 
   end p_performance_302_action_sql;

   procedure p_performance_302_1_action_sql is
  begin
    merge into scmdata.t_performance_maintenance_year tka
    using (select t.category,t.supplier_info_id ,
       t.category_id,
       t.company_id ,
       t.supplier_code,
       t.factory_name,
       t.factory_abbreviation,
       t.overall_assessment_score,
       t.priority_order,
       t.production_progress_feedback,
       t.response_speed_and_attitude,
       t.check_cooperation_degree,
       t.quality_problem,
       t.major_quality_problem,
       t.integrity,
       t.finance
  from scmdata.t_history_performance_maintenance_year t
 where t.year = (select max(t.year) year from scmdata.t_history_performance_maintenance_quarter t))tkb 
    on (tka.supplier_code = tkb.supplier_code and tka.company_id = tkb.company_id  and tka.category_id  = tka.category_id 
         and tka.supplier_info_id = tkb.supplier_info_id  and tka.category = tkb.category)
    when matched then
      update
         set tka.overall_assessment_score     = tkb.overall_assessment_score,
             tka.priority_order               = tkb.priority_order,
             tka.production_progress_feedback = tkb.production_progress_feedback,
             tka.response_speed_and_attitude  = tkb.response_speed_and_attitude,
             tka.check_cooperation_degree     = tkb.check_cooperation_degree,
             tka.quality_problem              = tkb.quality_problem,
             tka.major_quality_problem        = tkb.major_quality_problem,
             tka.integrity                    = tkb.integrity,
             tka.finance                      = tkb.finance;
   end p_performance_302_1_action_sql;
end pkg_performance_maintenance;
/

