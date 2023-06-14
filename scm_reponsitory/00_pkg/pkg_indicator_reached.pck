create or replace package scmdata.pkg_indicator_reached is

/*--------------------------------------------------------------  
   生成供应链整体指标达成主表数据表
       用途：
          供应链整体指标达成主表——按月份更新数据表
       用于：
          供应链整体指标达成状况统计报表      
       更新规则：
           使用oracle数据库定时任务实现——每月更新上个月的数据
              在kpi定时任务后面更新（每个月5号）
      版本:
          2022-03-23 
---------------------------------------------------------------*/
    procedure p_indicator_reached_month;

/*-------------------------------------------------------------------------------------  
   生成供应链整体指标达成主表数据表
       用途：
          供应链整体指标达成主表——按季度更新数据表
       用于：
          供应链整体指标达成状况统计报表      
       更新规则：
           使用oracle数据库定时任务实现——每季更新上一个季度的数据
              在kpi定时任务后面更新（每季度更新一次——1月5号、4月5号、7月5号、10月5号）
      版本:
          2022-03-30 
----------------------------------------------------------------------------------------*/
  procedure p_indicator_reached_quarter;

/*-------------------------------------------------------------------  
   生成供应链整体指标达成主表数据表
       用途：
          供应链整体指标达成主表——按半年度更新数据表
       用于：
          供应链整体指标达成状况统计报表      
       更新规则：
           使用oracle数据库定时任务实现——每半年度更新上一个半年的数据
             在kpi定时任务后面更新（每半年度更新一次——1月5号、7月5号）
      版本:
          2022-03-30 
----------------------------------------------------------------------*/
  procedure p_indicator_reached_halfyear;

/*-------------------------------------------------------------  
   生成供应链整体指标达成主表数据表
       用途：
          供应链整体指标达成主表——按年度更新数据表
       用于：
          供应链整体指标达成状况统计报表      
       更新规则：
           使用oracle数据库定时任务实现——每年更新上一年的数据
           在kpi定时任务后面更新（每年更新一次——1月5号）
      版本:
          2022-03-30 
--------------------------------------------------------------*/
  procedure p_indicator_reached_year;

/*-------------------------------------------------------------------  
   生成供应链整体指标达成主表下钻页面数据表
       用途：
          供应链整体指标达成主表下钻页面显示SQL
       用于：
          供应链整体指标达成状况统计报表——下钻页面       
       入参：
          vc_dimension     ：统计维度 （分类、区域组）
          vc_timetype      ：查询时间类型 （月份、季度、半年度、年度）
          vc_time          ：统计时间 根据查询时间类型变化
          vc_name          ：指标名称（主表下钻时下传的参数）
          vc_id            ：company_id （公司id）
       返回：
          主表下钻页面时相关显示sql
      版本:
          2022-03-30 
-------------------------------------------------------------------------*/
  function f_return_indicator_report(vc_dimension varchar2,   
                                     vc_timetype  varchar2, 
                                     vc_time      varchar2, 
                                     vc_name      varchar2,
                                     vc_id        varchar)  return clob;

end pkg_indicator_reached;
/

create or replace package body scmdata.pkg_indicator_reached is

/*------------------------------------------------------------  
   生成供应链整体指标达成主表数据表
       用途：
          供应链整体指标达成主表——按月份更新数据表
       用于：
          供应链整体指标达成状况统计报表      
       更新规则：
           使用oracle数据库定时任务实现——每月更新上个月的数据
              在kpi定时任务后面更新（每个月5号）
      版本: 
          2022-03-30 
      修改:
      2022-05-13 因需求变更，新增订单满足率（原值）指标、调整页面
--------------------------------------------------------------*/
    procedure p_indicator_reached_month is
     begin
    merge into scmdata.t_indicator_reached_month tka
    using ( with order_kpi as(select company_id,year,month,tager_type,tager_value
            from (select kt.company_id, kt.year,kt.month, kt.sho_order_money ,kt.sho_order_original_money, 
                         kt.delivery_order_money,k.shop_rt_money,k.warehouse_rt_money
            from (select t.company_id,t.year,t.month, sum(t.sho_order_money) / sum(t.order_money) sho_order_money,
                         sum(t.delivery_order_money) / sum(t.delivery_money) delivery_order_money,
                         sum(t.sho_order_original_money) / sum(t.order_money) sho_order_original_money
                    from scmdata.t_kpiorder_month t
                   group by t.company_id,t.year,t.month) kt
            left join (select t.company_id, t.year,t.month, sum(t.shop_rt_money) / sum(t.ingood_money) shop_rt_money,
                              sum(t.warehouse_rt_money) / sum(t.ingood_money) warehouse_rt_money
                         from scmdata.t_kpireturn_cate_rate_month t
                        group by t.company_id,t.year,t.month) k
              on k.company_id = kt.company_id
             and k.year = kt.year
             and k.month = kt.month)
          unpivot (tager_value for tager_type in (sho_order_money as'订单满足率(绩效值)',delivery_order_money as'补货平均交期',
                                    sho_order_original_money as '订单满足率(原值)',shop_rt_money as'门店退货率',warehouse_rt_money as '仓库退货率')))
          select ot.year,ot.month,ot.company_id,ot.target_type,ot.indicator_name,
                 round(ot.target_values,4)target_values,
                 round(ot.actual_value,4)actual_value,      
                 round(ot.target_difference,4)target_difference,
                 (case when ot.achievement_rate > 1 then 1 
                       when ot.achievement_rate < 0  then 0 
                       else round(ot.achievement_rate,4) end) achievement_rate,
                 round(ot.lastyear_actual_value,4)lastyear_actual_value, 
                 round(ot.same_difference,4) same_difference
          from (select ok.year,lpad(ok.month, 2, 0) month, ok.company_id,g.target_type,ok.tager_type indicator_name,
                 (case when tvc.target_name <> '补货平均交期' then(tvc.target_value / 100) else tvc.target_value end) target_values,
                 ok.tager_value actual_value,
                 (ok.tager_value - (case when tvc.target_name <> '补货平均交期' then(tvc.target_value / 100) else tvc.target_value end)) target_difference,
                 (case when tvc.target_name like '订单满足率%' then ok.tager_value/(tvc.target_value/100) 
                       when tvc.target_name = '补货平均交期' then  2-(ok.tager_value/tvc.target_value)  
                       else 2 - ok.tager_value/(tvc.target_value / 100)  end)achievement_rate,
                  tb.tager_value  lastyear_actual_value,
                  ok.tager_value-tb.tager_value same_difference
            from order_kpi ok
           left join scmdata.t_target_value_config tvc
              on tvc.company_id = ok.company_id
             and tvc.ayear = ok.year
             and ok.tager_type = tvc.target_name
            left join (select c.group_dict_name target_name, b.group_dict_name target_type
                         from (select *
                                  from scmdata.sys_group_dict
                                 where group_dict_type = 'TARGET'
                                   and pause = 0) a
                        inner join scmdata.sys_group_dict b
                           on b.parent_id = a.group_dict_id
                        inner join scmdata.sys_group_dict c
                           on c.parent_id = b.group_dict_id) g
                on g.target_name = ok.tager_type
           left join (select k.year+1 year, k.month, t.target_type, t.target_name, k.tager_value
                        from order_kpi k
                       inner join scmdata.t_target_value_config t
                          on t.company_id = k.company_id
                         and t.ayear = k.year
                         and k.tager_type = t.target_name) tb
             on tb.year = ok.year
            and tb.month = ok.month
            and tb.target_name = tvc.target_name
          order by ok.year desc,ok.month desc ,g.target_type ) ot) tkb
    on (tka.company_id = tkb.company_id and tka.year = tkb.year and tka.month = tkb.month and tka.target_type = tkb.target_type and tka.indicator_name = tkb.indicator_name)
    when matched then
      update
         set tka.target_values          = tkb.target_values,
             tka.actual_value           = tkb.actual_value,
             tka.target_difference      = tkb.target_difference,
             tka.achievement_rate       = tkb.achievement_rate,
             tka.lastyear_actual_value  = tkb.lastyear_actual_value,
             tka.same_difference        = tkb.same_difference,
             tka.update_id              = 'ADMIN',
             tka.update_time            = sysdate
    when not matched then
        insert
          (tka.t_indicator_reached_month_id,
           tka.company_id,
           tka.year,
           tka.month,
           tka.target_type,
           tka.indicator_name,
           tka.target_values,
           tka.actual_value,
           tka.target_difference,
           tka.achievement_rate,
           tka.lastyear_actual_value,
           tka.same_difference,
           tka.update_id,
           tka.update_time,
           tka.create_id,
           tka.create_time)
        values
          (scmdata.f_get_uuid(),
           tkb.company_id,
           tkb.year,
           tkb.month,
           tkb.target_type,
           tkb.indicator_name,
           tkb.target_values,
           tkb.actual_value,
           tkb.target_difference,
           tkb.achievement_rate,
           tkb.lastyear_actual_value,
           tkb.same_difference,
           'ADMIN',
           sysdate,
           'ADMIN',
           sysdate);
    end p_indicator_reached_month;

/*-------------------------------------------------------------------  
   生成供应链整体指标达成主表数据表
       用途：
          供应链整体指标达成主表——按季度更新数据表
       用于：
          供应链整体指标达成状况统计报表      
       更新规则：
           使用oracle数据库定时任务实现——每季更新上一个季度的数据
              在kpi定时任务后面更新（1月5号、4月5号、7月5号、10月5号）
      版本: 
           2022-03-30 
      修改:
      2022-05-13 因需求变更，新增订单满足率（原值）指标、调整页面
----------------------------------------------------------------------*/
    procedure p_indicator_reached_quarter is
     begin
    merge into scmdata.t_indicator_reached_quarter tka
    using ( with order_kpi as(select company_id,year,quarter,tager_type,tager_value
            from (select kt.company_id, kt.year,kt.quarter, kt.sho_order_money ,kt.sho_order_original_money,
                         kt.delivery_order_money,k.shop_rt_money,k.warehouse_rt_money
            from (select t.company_id,t.year,t.quarter,
                         sum(t.sho_order_money) / sum(t.order_money) sho_order_money,
                         sum(t.delivery_order_money) / sum(t.delivery_money) delivery_order_money,
                         sum(t.sho_order_original_money) / sum(t.order_money) sho_order_original_money
                    from scmdata.t_kpiorder_quarter t
                   group by t.company_id,t.year,t.quarter) kt
            left join (select t.company_id, t.year,t.quarter,
                              sum(t.shop_rt_money) / sum(t.ingood_money) shop_rt_money,
                              sum(t.warehouse_rt_money) / sum(t.ingood_money) warehouse_rt_money
                         from scmdata.t_kpireturn_cate_rate_quarter t
                        group by t.company_id,t.year,t.quarter) k
              on k.company_id = kt.company_id
             and k.year = kt.year
             and k.quarter = kt.quarter)
          unpivot (tager_value for tager_type in (sho_order_money as'订单满足率(绩效值)',delivery_order_money as'补货平均交期',
            sho_order_original_money as '订单满足率(原值)',shop_rt_money as'门店退货率',warehouse_rt_money as '仓库退货率')))
          select ot.company_id,ot.year,ot.quarter,ot.target_type,ot.indicator_name,
                 round(ot.target_values,4) target_values,
                 round(ot.actual_value,4) actual_value,      
                 round(ot.target_difference,4) target_difference,
                 (case when ot.achievement_rate > 1 then 1 
                       when ot.achievement_rate < 0  then 0 
                       else round(ot.achievement_rate,4) end) achievement_rate,
                 round(ot.lastyear_actual_value,4)lastyear_actual_value, 
                 round(ot.same_difference,4) same_difference
          from (select ok.company_id,ok.year,ok.quarter,g.target_type,ok.tager_type indicator_name,
                       (case when tvc.target_name <> '补货平均交期' then(tvc.target_value / 100) else tvc.target_value end) target_values,
                       ok.tager_value actual_value,
                       (ok.tager_value - (case when tvc.target_name <> '补货平均交期' then(tvc.target_value / 100) else tvc.target_value end)) target_difference,
                       (case when tvc.target_name like '订单满足率%' then ok.tager_value/(tvc.target_value/100) 
                             when tvc.target_name = '补货平均交期' then  2-(ok.tager_value/tvc.target_value)  
                             else 2 - ok.tager_value/(tvc.target_value / 100)  end)achievement_rate,
                        tb.tager_value  lastyear_actual_value,
                        ok.tager_value-tb.tager_value same_difference
            from order_kpi ok
           left join scmdata.t_target_value_config tvc
              on tvc.company_id = ok.company_id
             and tvc.ayear = ok.year
             and ok.tager_type = tvc.target_name
            left join (select c.group_dict_name target_name, b.group_dict_name target_type
                         from (select *
                                  from scmdata.sys_group_dict
                                 where group_dict_type = 'TARGET'
                                   and pause = 0) a
                        inner join scmdata.sys_group_dict b
                           on b.parent_id = a.group_dict_id
                        inner join scmdata.sys_group_dict c
                           on c.parent_id = b.group_dict_id) g
                on g.target_name = ok.tager_type
           left join (select k.year+1 year, k.quarter, t.target_type, t.target_name, k.tager_value
                        from order_kpi k
                       inner join scmdata.t_target_value_config t
                          on t.company_id = k.company_id
                         and t.ayear = k.year
                         and k.tager_type = t.target_name) tb
             on tb.year = ok.year
            and tb.quarter = ok.quarter
            and tb.target_name = tvc.target_name
          order by ok.year desc,ok.quarter desc ,g.target_type )ot) tkb
    on (tka.company_id = tkb.company_id and tka.year = tkb.year and tka.quarter = tkb.quarter and tka.target_type = tkb.target_type and tka.indicator_name = tkb.indicator_name)
    when matched then
      update
         set tka.target_values          = tkb.target_values,
             tka.actual_value           = tkb.actual_value,
             tka.target_difference      = tkb.target_difference,
             tka.achievement_rate       = tkb.achievement_rate,
             tka.lastyear_actual_value  = tkb.lastyear_actual_value,
             tka.same_difference        = tkb.same_difference,
             tka.update_id              = 'ADMIN',
             tka.update_time            = sysdate
    when not matched then
        insert
          (tka.t_indicator_reached_quarter_id,
           tka.company_id,
           tka.year,
           tka.quarter,
           tka.target_type,
           tka.indicator_name,
           tka.target_values,
           tka.actual_value,
           tka.target_difference,
           tka.achievement_rate,
           tka.lastyear_actual_value,
           tka.same_difference,
           tka.update_id,
           tka.update_time,
           tka.create_id,
           tka.create_time)
        values
          (scmdata.f_get_uuid(),
           tkb.company_id,
           tkb.year,
           tkb.quarter,
           tkb.target_type,
           tkb.indicator_name,
           tkb.target_values,
           tkb.actual_value,
           tkb.target_difference,
           tkb.achievement_rate,
           tkb.lastyear_actual_value,
           tkb.same_difference,
           'ADMIN',
           sysdate,
           'ADMIN',
           sysdate);
    end p_indicator_reached_quarter;

/*------------------------------------------------------------------  
   生成供应链整体指标达成主表数据表
       用途：
          供应链整体指标达成主表——按半年度更新数据表
       用于：
          供应链整体指标达成状况统计报表      
       更新规则：
           使用oracle数据库定时任务实现——每半年度更新上一个半年的数据
             在kpi定时任务后面更新（1月5号、7月5号）
      版本:
          2022-03-30 
      修改:
      2022-05-13 因需求变更，新增订单满足率（原值）指标、调整页面
-----------------------------------------------------------------------*/
    procedure p_indicator_reached_halfyear is
     begin
    merge into scmdata.t_indicator_reached_halfyear tka
    using ( with order_kpi as(select company_id,year,is_halfyear,tager_type,tager_value
            from (select kt.company_id, kt.year,kt.is_halfyear, kt.sho_order_money ,kt.sho_order_original_money,
                         kt.delivery_order_money,k.shop_rt_money,k.warehouse_rt_money
            from (select t.company_id,t.year,t.is_halfyear,
                         sum(t.sho_order_money) / sum(t.order_money) sho_order_money,
                         sum(t.delivery_order_money) / sum(t.delivery_money) delivery_order_money,
                         sum(t.sho_order_original_money) / sum(t.order_money) sho_order_original_money
                    from scmdata.t_kpiorder_halfyear t
                   group by t.company_id,t.year,t.is_halfyear) kt
            left join (select t.company_id, t.year,t.halfyear ,
                              sum(t.shop_rt_money) / sum(t.ingood_money) shop_rt_money,
                              sum(t.warehouse_rt_money) / sum(t.ingood_money) warehouse_rt_money
                         from scmdata.t_kpireturn_cate_rate_halfyear t
                        group by t.company_id,t.year,t.halfyear) k
              on k.company_id = kt.company_id
             and k.year = kt.year
             and k.halfyear = kt.is_halfyear)
          unpivot (tager_value for tager_type in (sho_order_money as'订单满足率(绩效值)',delivery_order_money as'补货平均交期',
               sho_order_original_money as '订单满足率(原值)',shop_rt_money as'门店退货率',warehouse_rt_money as '仓库退货率')))
          select ot.company_id,ot.year,ot.halfyear,ot.target_type,ot.indicator_name,
                 round(ot.target_values,4) target_values,
                 round(ot.actual_value,4) actual_value,      
                 round(ot.target_difference,4) target_difference,
                 (case when ot.achievement_rate > 1 then 1 
                       when ot.achievement_rate < 0  then 0 
                       else round(ot.achievement_rate,4) end) achievement_rate,
                 round(ot.lastyear_actual_value,4) lastyear_actual_value, 
                 round(ot.same_difference,4)same_difference
          from (select ok.company_id,ok.year,ok.is_halfyear halfyear,g.target_type,ok.tager_type indicator_name,
                       (case when tvc.target_name <> '补货平均交期' then(tvc.target_value / 100) else tvc.target_value end) target_values,
                       ok.tager_value actual_value,
                       (ok.tager_value - (case when tvc.target_name <> '补货平均交期' then(tvc.target_value / 100) else tvc.target_value end)) target_difference,
                       (case when tvc.target_name like '订单满足率%' then ok.tager_value/(tvc.target_value/100) 
                             when tvc.target_name = '补货平均交期' then  2-(ok.tager_value/tvc.target_value)  
                             else 2 - ok.tager_value/(tvc.target_value / 100)  end)achievement_rate,
                        tb.tager_value  lastyear_actual_value,
                        ok.tager_value-tb.tager_value same_difference
            from order_kpi ok
            left join scmdata.t_target_value_config tvc
              on tvc.company_id = ok.company_id
             and tvc.ayear = ok.year
             and ok.tager_type = tvc.target_name
            left join (select c.group_dict_name target_name, b.group_dict_name target_type
                         from (select *
                                  from scmdata.sys_group_dict
                                 where group_dict_type = 'TARGET'
                                   and pause = 0) a
                        inner join scmdata.sys_group_dict b
                           on b.parent_id = a.group_dict_id
                        inner join scmdata.sys_group_dict c
                           on c.parent_id = b.group_dict_id) g
                on g.target_name = ok.tager_type
           left join (select k.year+1 year, k.is_halfyear, t.target_type, t.target_name, k.tager_value
                        from order_kpi k
                       inner join scmdata.t_target_value_config t
                          on t.company_id = k.company_id
                         and t.ayear = k.year
                         and k.tager_type = t.target_name) tb
             on tb.year = ok.year
            and tb.is_halfyear = ok.is_halfyear
            and tb.target_name = tvc.target_name
          order by ok.year desc,ok.is_halfyear desc ,g.target_type)ot) tkb
    on (tka.company_id = tkb.company_id and tka.year = tkb.year and tka.halfyear = tkb.halfyear and tka.target_type = tkb.target_type and tka.indicator_name = tkb.indicator_name)
    when matched then
      update
         set tka.target_values          = tkb.target_values,
             tka.actual_value           = tkb.actual_value,
             tka.target_difference      = tkb.target_difference,
             tka.achievement_rate       = tkb.achievement_rate,
             tka.lastyear_actual_value  = tkb.lastyear_actual_value,
             tka.same_difference        = tkb.same_difference,
             tka.update_id              = 'ADMIN',
             tka.update_time            = sysdate
    when not matched then
        insert
          (tka.t_indicator_reached_halfyear_id,
           tka.company_id,
           tka.year,
           tka.halfyear,
           tka.target_type,
           tka.indicator_name,
           tka.target_values,
           tka.actual_value,
           tka.target_difference,
           tka.achievement_rate,
           tka.lastyear_actual_value,
           tka.same_difference,
           tka.update_id,
           tka.update_time,
           tka.create_id,
           tka.create_time)
        values
          (scmdata.f_get_uuid(),
           tkb.company_id,
           tkb.year,
           tkb.halfyear,
           tkb.target_type,
           tkb.indicator_name,
           tkb.target_values,
           tkb.actual_value,
           tkb.target_difference,
           tkb.achievement_rate,
           tkb.lastyear_actual_value,
           tkb.same_difference,
           'ADMIN',
           sysdate,
           'ADMIN',
           sysdate);
    end p_indicator_reached_halfyear;

/*-------------------------------------------------  
   生成供应链整体指标达成主表数据表
       用途：
          供应链整体指标达成主表——按年度更新数据表
       用于：
          供应链整体指标达成状况统计报表      
       更新规则：
           使用oracle数据库定时任务实现——每年更新上一年的数据
           在kpi定时任务后面更新（每年的1月5号）
      版本:
          2022-03-30 
      修改:
      2022-05-13 因需求变更，新增订单满足率（原值）指标、调整页面
----------------------------------------------------*/
    procedure p_indicator_reached_year is
     begin
    merge into scmdata.t_indicator_reached_year tka
    using ( with order_kpi as(select company_id,year,tager_type,tager_value
            from (select kt.company_id, kt.year, kt.sho_order_money ,kt.sho_order_original_money,
                         kt.delivery_order_money,k.shop_rt_money,k.warehouse_rt_money
            from (select t.company_id,t.year,
                         sum(t.sho_order_money) / sum(t.order_money) sho_order_money,
                         sum(t.delivery_order_money) / sum(t.delivery_money) delivery_order_money,
                         sum(t.sho_order_original_money) / sum(t.order_money) sho_order_original_money
                    from scmdata.t_kpiorder_year t
                   group by t.company_id,t.year) kt
            left join (select t.company_id, t.year,
                              sum(t.shop_rt_money) / sum(t.ingood_money) shop_rt_money,
                              sum(t.warehouse_rt_money) / sum(t.ingood_money) warehouse_rt_money
                         from scmdata.t_kpireturn_cate_rate_year t
                        group by t.company_id,t.year) k
              on k.company_id = kt.company_id
             and k.year = kt.year)
          unpivot (tager_value for tager_type in (sho_order_money as'订单满足率(绩效值)',delivery_order_money as'补货平均交期',
                sho_order_original_money as '订单满足率(原值)',shop_rt_money as'门店退货率',warehouse_rt_money as '仓库退货率')))
          select ot.company_id,ot.year,ot.target_type,ot.indicator_name,
                 round(ot.target_values,4) target_values,
                 round(ot.actual_value,4) actual_value,      
                 round(ot.target_difference,4) target_difference,
                 (case when ot.achievement_rate > 1 then 1 
                       when ot.achievement_rate < 0  then 0 
                       else round(ot.achievement_rate,4) end) achievement_rate,
                 round(ot.lastyear_actual_value,4) lastyear_actual_value, 
                 round(ot.same_difference,4)same_difference
          from (select ok.year,ok.company_id,
                       g.target_type,ok.tager_type indicator_name,
                       (case when tvc.target_name <> '补货平均交期' then(tvc.target_value / 100) else tvc.target_value end) target_values,
                       ok.tager_value actual_value,
                       (ok.tager_value - (case when tvc.target_name <> '补货平均交期' then 
                                                   (tvc.target_value / 100) else tvc.target_value end)) target_difference,
                       (case when tvc.target_name like '订单满足率%' then ok.tager_value/(tvc.target_value/100) 
                             when tvc.target_name = '补货平均交期' then  2-(ok.tager_value/tvc.target_value)  
                             else 2 - ok.tager_value/(tvc.target_value / 100)  end)achievement_rate,
                        tb.tager_value  lastyear_actual_value,
                        ok.tager_value-tb.tager_value same_difference
            from order_kpi ok
           inner join scmdata.t_target_value_config tvc
              on tvc.company_id = ok.company_id
             and tvc.ayear = ok.year
             and ok.tager_type = tvc.target_name
            left join (select c.group_dict_name target_name, b.group_dict_name target_type
                         from (select *
                                  from scmdata.sys_group_dict
                                 where group_dict_type = 'TARGET'
                                   and pause = 0) a
                        inner join scmdata.sys_group_dict b
                           on b.parent_id = a.group_dict_id
                        inner join scmdata.sys_group_dict c
                           on c.parent_id = b.group_dict_id) g
                on g.target_name = ok.tager_type
           left join (select k.year+1 year, t.target_type, t.target_name, k.tager_value
                        from order_kpi k
                       inner join scmdata.t_target_value_config t
                          on t.company_id = k.company_id
                         and t.ayear = k.year
                         and k.tager_type = t.target_name) tb
             on tb.year = ok.year
            and tb.target_name = tvc.target_name
          order by ok.year desc,g.target_type)ot ) tkb
    on (tka.company_id = tkb.company_id and tka.year = tkb.year and tka.target_type = tkb.target_type and tka.indicator_name = tkb.indicator_name)
    when matched then
      update
         set tka.target_values          = tkb.target_values,
             tka.actual_value           = tkb.actual_value,
             tka.target_difference      = tkb.target_difference,
             tka.achievement_rate       = tkb.achievement_rate,
             tka.lastyear_actual_value  = tkb.lastyear_actual_value,
             tka.same_difference        = tkb.same_difference,
             tka.update_id              = 'ADMIN',
             tka.update_time            = sysdate
    when not matched then
        insert
          (tka.t_indicator_reached_year_id,
           tka.company_id,
           tka.year,
           tka.target_type,
           tka.indicator_name,
           tka.target_values,
           tka.actual_value,
           tka.target_difference,
           tka.achievement_rate,
           tka.lastyear_actual_value,
           tka.same_difference,
           tka.update_id,
           tka.update_time,
           tka.create_id,
           tka.create_time)
        values
          (scmdata.f_get_uuid(),
           tkb.company_id,
           tkb.year,
           tkb.target_type,
           tkb.indicator_name,
           tkb.target_values,
           tkb.actual_value,
           tkb.target_difference,
           tkb.achievement_rate,
           tkb.lastyear_actual_value,
           tkb.same_difference,
           'ADMIN',
           sysdate,
           'ADMIN',
           sysdate);
    end p_indicator_reached_year;

/*-------------------------------------------------------------------  
   生成供应链整体指标达成主表下钻页面数据表
       用途：
          供应链整体指标达成主表下钻页面显示SQL
       用于：
          供应链整体指标达成状况统计报表——下钻页面       
       入参：
          vc_dimension     ：统计维度 （分类、区域组）
          vc_timetype      ：查询时间类型 （月份、季度、半年度、年度）
          vc_time          ：统计时间 根据查询时间类型变化
          vc_name          ：指标名称（主表下钻时下传的参数）
          vc_id            ：company_id （公司id）
       返回：
          主表下钻页面时相关显示sql
      版本:
          2022-03-30 
      修改:
       2022-05-09 修改页面显示，补货平均交期的值
       2022-05-13 因需求变更，新增订单满足率（原值）指标、调整页面
       2022-09-06 因区域组改编码，修改页面区域组取值
-----------------------------------------------------------------------*/
 function f_return_indicator_report(  vc_dimension varchar2,  
                                      vc_timetype  varchar2,
                                      vc_time      varchar2, 
                                      vc_name      varchar2,  
                                      vc_id        varchar) return clob is
     vc_sql clob;
   begin
  if vc_timetype = '按月度统计' then
    if vc_dimension = '分类'  then
      if vc_name = '补货平均交期' then
    vc_sql := q'[select total_time,classifications, category_id ,target_values target1_values,actual_value actual1_value,
                        round(target_values,2) target_values,round(actual_value,2) actual_value,
                        round(target_difference,2) target_difference,achievement_rate,round(lastyear_actual_value,2) lastyear_actual_value,
                        round(same_difference,2) same_difference
         from (select (t.year || '年' || lpad(t.month,2,0)|| '月') total_time,'汇总' classifications,'0' category_id,
              (case when t.target_values is null then 0 else t.target_values end)target_values,t.actual_value,t.target_difference,t.achievement_rate,t.lastyear_actual_value,t.same_difference
         from scmdata.t_indicator_reached_month t
        where t.indicator_name = ']'||vc_name||''''||
       q'[ union all
       select k.total_time,k.category_name classifications,k.category category_id,
              tcb.target_value target_values,k.tager_value_kpi actual_value,
              (k.tager_value_kpi-tcb.target_value)target_difference,
               (case when 2-(k.tager_value_kpi/tcb.target_value) > 1 then 1
                     when 2-(k.tager_value_kpi/tcb.target_value) < 0 then 0
                     else 2-(k.tager_value_kpi/tcb.target_value) end)achievement_rate,
              k1.last_value_actual lastyear_actual_value,
              k.tager_value_kpi-k1.last_value_actual same_difference
         from (select company_id,total_time,year,month,category,category_name,tager_type,tager_value_kpi
                     from (select t.company_id, (t.year || '年' || lpad(t.month, 2, 0)|| '月') total_time,
                                  t.year,lpad(t.month, 2, 0)month,t.category_name,t.category,
                                  max(t.sho_order_money / t.order_money) sho_order_money,
                                  max(t.sho_order_original_money / t.order_money) sho_order_original_money,
                                  max(t.delivery_order_money / t.delivery_money) delivery_order_money,
                                  max(t1.shop_rt_money) / max(t1.ingood_money) shop_rt_money,
                                  max(t1.warehouse_rt_money) / max(t1.ingood_money) warehouse_rt_money
                            from scmdata.t_kpiorder_month t
                            left join scmdata.t_kpireturn_cate_rate_month t1
                              on t1.company_id = t.company_id
                             and t1.year = t.year
                             and t1.month = t.month
                             and t1.category = t.category
                             and t1.category_name = t.category_name
                           group by t.company_id,t.year,lpad(t.month, 2, 0),t.category,t.category_name)
      unpivot (tager_value_kpi for tager_type in (sho_order_money as'订单满足率(绩效值)',delivery_order_money as'补货平均交期',
             sho_order_original_money as '订单满足率(原值)',shop_rt_money as'门店退货率',warehouse_rt_money as '仓库退货率'))
        where tager_type = ']'|| vc_name || ''''|| q'[)k
         left join (select tc.company_id, tc.ayear,tc.target_name,tb.category,tb.target_value 
                      from scmdata.t_target_value_config tc 
                     inner join scmdata.t_target_value_branch_config tb
                        on tc.company_id = tb.company_id
                       and tc.target_id = tb.target_id)tcb
           on tcb.company_id = k.company_id
          and tcb.ayear = k.year
          and tcb.target_name = k.tager_type
          and tcb.category = k.category_name
         left join(select company_id,year,month,category_name,tager_type,last_value_actual
         from (select t.company_id, t.year+1 year, lpad(t.month, 2, 0) month,t.category_name,
                      max(t.sho_order_money / t.order_money) sho_order_money,
                      max(t.sho_order_original_money / t.order_money) sho_order_original_money,
                      max(t.delivery_order_money / t.delivery_money) delivery_order_money,
                      max(t1.shop_rt_money) / max(t1.ingood_money) shop_rt_money,
                      max(t1.warehouse_rt_money) / max(t1.ingood_money) warehouse_rt_money
                 from scmdata.t_kpiorder_month t
                 left join scmdata.t_kpireturn_cate_rate_month t1
                   on t1.company_id = t.company_id
                  and t1.year = t.year
                  and t1.month = t.month
                  and t1.category = t.category
                  and t1.category_name = t.category_name
                group by t.company_id,t.year+1, lpad(t.month, 2, 0),t.category_name)
          unpivot (last_value_actual for tager_type in (sho_order_money as'订单满足率(绩效值)',delivery_order_money as'补货平均交期',
                    sho_order_original_money as '订单满足率(原值)', shop_rt_money as'门店退货率',warehouse_rt_money as '仓库退货率'))
          where tager_type = ']'|| vc_name || ''''|| q'[)k1
             on k.company_id = k1.company_id
            and k.category_name = k1.category_name
            and k.year = k1.year
            and k.month = k1.month
          where k.tager_type=  ']'|| vc_name ||''''||
           q'[ and k.company_id = ']' || vc_id ||''''||
          q'[order by  total_time desc ,category_id )
             where total_time = ']' || vc_time ||'''';
      else
    vc_sql := q'[select total_time,classifications, category_id ,target_values target1_values,actual_value actual1_value,
       (case when target_values*100 >=1 then to_char(round(target_values*100,2),'fm9999.90') ||'%'
             when target_values*100 >=0 and target_values*100 < 1 then to_char(round(target_values*100,2),'0.00') || '%'end)  target_values,
       (case when actual_value*100 >=1 then to_char(round(actual_value*100,2),'fm9999.90') ||'%'
             when actual_value*100 >=0 and actual_value*100 < 1 then to_char(round(actual_value*100,2),'0.00') || '%'end)  actual_value,
       (case when target_difference*100  >=1 then to_char(round(target_difference*100,2),'fm9999.90')|| '%' 
             when target_difference*100  >=0 and target_difference*100 <1 then to_char(round(target_difference*100,2),'0.00')|| '%' 
             when target_difference*100  <0 and target_difference*100 >-1 then ('-0'||to_char(substr(round(target_difference*100,2),2,6),'fm9999.90')|| '%')
             when target_difference*100  <= -1 then to_char(round(target_difference*100,2),'fm9999.90')|| '%'  end)target_difference,
       achievement_rate,
       (case when lastyear_actual_value is null then ''
             when lastyear_actual_value >= 0.01 then to_char(round(lastyear_actual_value*100,2),'fm9999.90') ||'%'
             else to_char(round(lastyear_actual_value*100,2),'0.00') || '%' end) lastyear_actual_value,
       (case when same_difference is null then ' '
             when same_difference*100 >= 1 then to_char(round(same_difference*100,2),'fm9999.90') || '%'
             when same_difference*100 <1 and same_difference*100 >=0 then to_char(round(same_difference*100,2),'0.00') || '%'
             when same_difference*100 <0 and same_difference*100 >-1 then '-0'||to_char(substr(round(same_difference*100,2),2,6),'fm9999.90') || '%'
             when same_difference*100 <= -1 then to_char(round(same_difference*100,2),'fm9999.90') || '%' end) same_difference 
from (select (t.year || '年' || lpad(t.month,2,0)|| '月') total_time,'汇总' CLASSIFICATIONS,'0' category_id,
              (case when t.target_values is null then 0 else t.target_values end)target_values,t.actual_value,t.target_difference,t.achievement_rate,t.lastyear_actual_value,t.same_difference
         from scmdata.t_indicator_reached_month t
        where t.indicator_name = ']'||vc_name||''''||
       q'[ union all
       select k.total_time,k.category_name classifications,k.category category_id,(
              tcb.target_value/100)target_values,k.tager_value_kpi actual_value,
              (k.tager_value_kpi-(tcb.target_value/100))target_difference,
               (case when ]' || ''''||vc_name||''''|| q'[ like '订单满足率%' then 
                   (case when (k.tager_value_kpi/(tcb.target_value/100)) > 1 then 1
                         when (k.tager_value_kpi/(tcb.target_value/100)) < 0 then 0
                         else (k.tager_value_kpi/(tcb.target_value/100)) end)
                  else
                   (case when 2-(k.tager_value_kpi/(tcb.target_value/100)) > 1 then 1
                         when 2-(k.tager_value_kpi/(tcb.target_value/100)) < 0 then 0
                         else 2-(k.tager_value_kpi/(tcb.target_value/100)) end)
                end)achievement_rate, 
              k1.last_value_actual lastyear_actual_value,
              k.tager_value_kpi-k1.last_value_actual same_difference
         from (select company_id,total_time,year,month,category,category_name,tager_type,tager_value_kpi
                     from (select t.company_id, (t.year || '年' || lpad(t.month, 2, 0)|| '月') total_time,
                                  t.year,lpad(t.month, 2, 0)month,t.category_name,t.category,
                                  max(t.sho_order_money / t.order_money) sho_order_money,
                                  max(t.sho_order_original_money / t.order_money) sho_order_original_money,
                                  max(t.delivery_order_money / t.delivery_money) delivery_order_money,
                                  max(t1.shop_rt_money) / max(t1.ingood_money) shop_rt_money,
                                  max(t1.warehouse_rt_money) / max(t1.ingood_money) warehouse_rt_money
                            from scmdata.t_kpiorder_month t
                            left join scmdata.t_kpireturn_cate_rate_month t1
                              on t1.company_id = t.company_id
                             and t1.year = t.year
                             and t1.month = t.month
                             and t1.category = t.category
                             and t1.category_name = t.category_name
                           group by t.company_id,t.year,lpad(t.month, 2, 0),t.category,t.category_name)
      unpivot (tager_value_kpi for tager_type in (sho_order_money as '订单满足率(绩效值)',delivery_order_money as'补货平均交期',
               sho_order_original_money as '订单满足率(原值)', shop_rt_money as '门店退货率',warehouse_rt_money as '仓库退货率'))
        where tager_type = ']'|| vc_name || ''''||q'[)k
         left join (select tc.company_id, tc.ayear,tc.target_name,tb.category,tb.target_value 
                      from scmdata.t_target_value_config tc 
                     inner join scmdata.t_target_value_branch_config tb
                        on tc.company_id = tb.company_id
                       and tc.target_id = tb.target_id)tcb
           on tcb.company_id = k.company_id
          and tcb.ayear = k.year
          and tcb.target_name = k.tager_type
          and tcb.category = k.category_name
         left join(select company_id,year,month,category_name,tager_type,last_value_actual
         from (select t.company_id, t.year+1 year, lpad(t.month, 2, 0) month,t.category_name,
                      max(t.sho_order_money / t.order_money) sho_order_money,
                      max(t.sho_order_original_money / t.order_money) sho_order_original_money,
                      max(t.delivery_order_money / t.delivery_money) delivery_order_money,
                      max(t1.shop_rt_money) / max(t1.ingood_money) shop_rt_money,
                      max(t1.warehouse_rt_money) / max(t1.ingood_money) warehouse_rt_money
                 from scmdata.t_kpiorder_month t
                 left join scmdata.t_kpireturn_cate_rate_month t1
                   on t1.company_id = t.company_id
                  and t1.year = t.year
                  and t1.month = t.month
                  and t1.category = t.category
                  and t1.category_name = t.category_name
                group by t.company_id,t.year+1, lpad(t.month, 2, 0),t.category_name)
          unpivot (last_value_actual for tager_type in (sho_order_money as'订单满足率(绩效值)',delivery_order_money as'补货平均交期',
                      sho_order_original_money as '订单满足率(原值)', shop_rt_money as'门店退货率',warehouse_rt_money as '仓库退货率'))
          where tager_type = ']'|| vc_name || ''''|| q'[)k1
             on k.company_id = k1.company_id
            and k.category_name = k1.category_name
            and k.year = k1.year
            and k.month = k1.month
          where k.tager_type=  ']'|| vc_name ||''''||
           q'[ and k.company_id = ']' || vc_id ||''''||
          q'[order by  total_time desc ,category_id )
             where total_time = ']' || vc_time ||'''';
      end if;
    elsif vc_dimension = '区域组' then
        if vc_name = '补货平均交期' then
          vc_sql := q'[select total_time,area_group, groupname_id,target_values target1_values,actual_value actual1_value,
               round(target_values,2)  target_values,
               round(actual_value,2) actual_value,round(target_difference,2) target_difference,achievement_rate,
               round(lastyear_actual_value,2) lastyear_actual_value,round(same_difference,2) same_difference
         from (select (t.year || '年' || lpad(t.month,2,0)|| '月') total_time,'汇总' area_group,'0' groupname_id,
                      t.target_values,t.actual_value,t.target_difference,t.achievement_rate,t.lastyear_actual_value,t.same_difference
                 from scmdata.t_indicator_reached_month t
                where t.indicator_name = ']'|| vc_name || ''''||
               q'[ union all
               select k.total_time,k.group_name area_group,k.groupname groupname_id,tcb.target_value target_values,k.tager_value_kpi actual_value,
                      (k.tager_value_kpi-tcb.target_value)target_difference,
                      (case when 2-(k.tager_value_kpi/tcb.target_value) > 1 then 1
                            when 2-(k.tager_value_kpi/tcb.target_value) < 0 then 0
                            else 2-(k.tager_value_kpi/tcb.target_value) end)achievement_rate,
                      k1.last_value_actual lastyear_actual_value,
                      k.tager_value_kpi-k1.last_value_actual same_difference 
                 from (select company_id,total_time,year,month,groupname,tager_type,tager_value_kpi,group_name
                             from (select t.company_id, (t.year || '年' || lpad(t.month, 2, 0)|| '月') total_time,
                                          t.year,lpad(t.month, 2, 0)month,t.groupname,tr.group_name,
                                          max(t.sho_order_money / t.order_money) sho_order_money,
                                          max(t.delivery_order_money / t.delivery_money) delivery_order_money,
                                          max(t1.shop_rt_money) / max(t1.ingood_money) shop_rt_money,
                                          max(t1.warehouse_rt_money) / max(t1.ingood_money) warehouse_rt_money
                                    from scmdata.t_kpiorder_qu_month t
                                    left join scmdata.t_kpireturn_qy_rate_month t1
                                      on t1.company_id = t.company_id
                                     and t1.year = t.year
                                     and t1.month = t.month
                                     and t1.group_name  = t.groupname
                                   inner join (select distinct ts.group_name, ts.group_config_id
                                                 from scmdata.t_supplier_group_config ts) tr
                                      on tr.group_config_id = t.groupname
                                   group by t.company_id,t.year,lpad(t.month, 2, 0),t.groupname,tr.group_name)
              unpivot (tager_value_kpi for tager_type in (sho_order_money as'订单满足率',delivery_order_money as'补货平均交期',
                                                          shop_rt_money as'门店退货率',warehouse_rt_money as '仓库退货率'))
                where tager_type = ']'|| vc_name || ''''|| q'[)k
         left join (select tc.company_id, tc.ayear,tc.target_name,tb.group_config_id ,tb.target_value 
                      from scmdata.t_target_value_config tc 
                     inner join scmdata.t_target_value_area_config tb
                        on tc.company_id = tb.company_id
                       and tc.target_id = tb.target_id)tcb
           on tcb.company_id = k.company_id
          and tcb.ayear = k.year
          and tcb.target_name = k.tager_type
          and tcb.group_config_id = k.groupname
                 left join(select company_id,year,month,groupname,tager_type,last_value_actual
                 from (select t.company_id, t.year+1 year, lpad(t.month, 2, 0) month,t.groupname,
                              max(t.sho_order_money / t.order_money) sho_order_money,
                              max(t.delivery_order_money / t.delivery_money) delivery_order_money,
                              max(t1.shop_rt_money) / max(t1.ingood_money) shop_rt_money,
                              max(t1.warehouse_rt_money) / max(t1.ingood_money) warehouse_rt_money
                         from scmdata.t_kpiorder_qu_month t
                         left join scmdata.t_kpireturn_qy_rate_month t1
                           on t1.company_id = t.company_id
                          and t1.year = t.year
                          and t1.month = t.month
                          and t1.group_name = t.groupname
                        group by t.company_id,t.year+1, lpad(t.month, 2, 0),t.groupname)
                  unpivot (last_value_actual for tager_type in (sho_order_money as'订单满足率',delivery_order_money as'补货平均交期',
                                                                   shop_rt_money as'门店退货率',warehouse_rt_money as '仓库退货率'))
                  where tager_type = ']'|| vc_name || ''''|| q'[)k1
                     on k.company_id = k1.company_id
                    and k.groupname = k1.groupname
                    and k.year = k1.year
                    and k.month = k1.month
                  where k.tager_type=  ']'|| vc_name || ''''||
                   ' and k.company_id =' ||''''|| vc_id || ''''||
                 q'[ order by  total_time desc ,groupname_id )
                     where total_time = ']' ||vc_time|| '''';
        else
          vc_sql := q'[select total_time,area_group, groupname_id ,target_values target1_values,actual_value actual1_value,
       (case when target_values*100 >=1 then to_char(round(target_values*100,2),'fm9999.90') ||'%'
             when target_values*100 >=0 and target_values*100 < 1 then to_char(round(target_values*100,2),'0.00') || '%'end)  target_values,
       (case when actual_value*100 >=1 then to_char(round(actual_value*100,2),'fm9999.90') ||'%'
             when actual_value*100 >=0 and actual_value*100 < 1 then to_char(round(actual_value*100,2),'0.00') || '%'end)  actual_value,
       (case when target_difference*100  >=1 then to_char(round(target_difference*100,2),'fm9999.90')|| '%' 
             when target_difference*100  >0 and target_difference*100 <1 then to_char(round(target_difference*100,2),'0.00')|| '%' 
             when target_difference*100  <0 and target_difference*100 >-1 then ('-0'||to_char(substr(round(target_difference*100,2),2,6),'fm9999.90')|| '%')
             when target_difference*100  <= -1 then to_char(round(target_difference*100,2),'fm9999.90')|| '%'  end)target_difference,
       achievement_rate,
       (case when lastyear_actual_value is null then ''
             when lastyear_actual_value >= 0.01 then to_char(round(lastyear_actual_value*100,2),'fm9999.90') ||'%'
             else to_char(round(lastyear_actual_value*100,2),'0.00') || '%' end) lastyear_actual_value,
       (case when same_difference is null then ' '
             when same_difference*100 >= 1 then to_char(round(same_difference*100,2),'fm9999.90') || '%'
             when same_difference*100 <1 and same_difference*100 >0 then to_char(round(same_difference*100,2),'0.00') || '%'
             when same_difference*100 <0 and same_difference*100 >-1 then '-0'||to_char(substr(round(same_difference*100,2),2,6),'fm9999.90') || '%'
             when same_difference*100 <= -1 then to_char(round(same_difference*100,2),'fm9999.90') || '%' end) same_difference
 from (select (t.year || '年' || lpad(t.month,2,0)|| '月') total_time,'汇总' area_group,'0' groupname_id,
              (case when t.target_values is null then 0 else t.target_values end)target_values,t.actual_value,t.target_difference,t.achievement_rate,t.lastyear_actual_value,t.same_difference
         from scmdata.t_indicator_reached_month t
        where t.indicator_name = ']'|| vc_name || ''''||
       q'[ union all
       select k.total_time,k.group_name area_group,k.groupname groupname_id,(tcb.target_value/100)target_values,k.tager_value_kpi actual_value,
              (k.tager_value_kpi-(tcb.target_value/100))target_difference,
               (case when ]' || ''''||vc_name||''''|| q'[ like '订单满足率%' then 
                   (case when (k.tager_value_kpi/(tcb.target_value/100)) > 1 then 1
                         when (k.tager_value_kpi/(tcb.target_value/100)) < 0 then 0
                         else (k.tager_value_kpi/(tcb.target_value/100)) end)
                  else
                   (case when 2-(k.tager_value_kpi/(tcb.target_value/100)) > 1 then 1
                         when 2-(k.tager_value_kpi/(tcb.target_value/100)) < 0 then 0
                         else 2-(k.tager_value_kpi/(tcb.target_value/100)) end)
                end)achievement_rate, 
              k1.last_value_actual lastyear_actual_value,
              k.tager_value_kpi-k1.last_value_actual same_difference 
         from (select company_id,total_time,year,month,groupname,tager_type,tager_value_kpi,group_name
                     from (select t.company_id, (t.year || '年' || lpad(t.month, 2, 0)|| '月') total_time,
                                  t.year,lpad(t.month, 2, 0)month,t.groupname,tr.group_name,
                                  max(t.sho_order_money / t.order_money) sho_order_money,
                                  max(t.sho_order_original_money / t.order_money) sho_order_original_money,
                                  max(t.delivery_order_money / t.delivery_money) delivery_order_money,
                                  max(t1.shop_rt_money) / max(t1.ingood_money) shop_rt_money,
                                  max(t1.warehouse_rt_money) / max(t1.ingood_money) warehouse_rt_money
                            from scmdata.t_kpiorder_qu_month t
                            left join scmdata.t_kpireturn_qy_rate_month t1
                              on t1.company_id = t.company_id
                             and t1.year = t.year
                             and t1.month = t.month
                             and t1.group_name  = t.groupname
                           inner join (select distinct ts.group_name, ts.group_config_id
                                         from scmdata.t_supplier_group_config ts) tr
                              on tr.group_config_id = t.groupname
                           group by t.company_id,t.year,lpad(t.month, 2, 0),t.groupname,tr.group_name)
      unpivot (tager_value_kpi for tager_type in (sho_order_money as'订单满足率(绩效值)',delivery_order_money as'补货平均交期',
               sho_order_original_money as '订单满足率(原值)',shop_rt_money as'门店退货率',warehouse_rt_money as '仓库退货率'))
        where tager_type = ']'|| vc_name || ''''|| q'[)k
         left join (select tc.company_id, tc.ayear,tc.target_name,tb.group_config_id,tb.target_value 
                      from scmdata.t_target_value_config tc 
                     inner join scmdata.t_target_value_area_config tb
                        on tc.company_id = tb.company_id
                       and tc.target_id = tb.target_id)tcb
           on tcb.company_id = k.company_id
          and tcb.ayear = k.year
          and tcb.target_name = k.tager_type
          and tcb.group_config_id = k.groupname
         left join(select company_id,year,month,groupname,tager_type,last_value_actual
         from (select t.company_id, t.year+1 year, lpad(t.month, 2, 0) month,t.groupname,
                      max(t.sho_order_money / t.order_money) sho_order_money,
                      max(t.sho_order_original_money / t.order_money) sho_order_original_money,
                      max(t.delivery_order_money / t.delivery_money) delivery_order_money,
                      max(t1.shop_rt_money) / max(t1.ingood_money) shop_rt_money,
                      max(t1.warehouse_rt_money) / max(t1.ingood_money) warehouse_rt_money
                 from scmdata.t_kpiorder_qu_month t
                 left join scmdata.t_kpireturn_qy_rate_month t1
                   on t1.company_id = t.company_id
                  and t1.year = t.year
                  and t1.month = t.month
                  and t1.group_name = t.groupname
                group by t.company_id,t.year+1, lpad(t.month, 2, 0),t.groupname)
          unpivot (last_value_actual for tager_type in (sho_order_money as'订单满足率(绩效值)',delivery_order_money as'补货平均交期',
              sho_order_original_money as '订单满足率(原值)',shop_rt_money as'门店退货率',warehouse_rt_money as '仓库退货率'))
          where tager_type = ']'|| vc_name || ''''|| q'[)k1
             on k.company_id = k1.company_id
            and k.groupname = k1.groupname
            and k.year = k1.year
            and k.month = k1.month
          where k.tager_type=  ']'|| vc_name || ''''||
           ' and k.company_id =' ||''''|| vc_id || ''''||
         q'[ order by  total_time desc ,groupname_id )
             where total_time = ']' ||vc_time || '''';
        end if;
    end if;
  elsif vc_timetype = '按季度统计' then
    if vc_dimension = '分类'  then
      if vc_name = '补货平均交期' then
       vc_sql :=q'[ select total_time,classifications, category_id ,target_values target1_values,actual_value actual1_value,
                           round(target_values,2) target_values,
                           round(actual_value,2) actual_value,round(target_difference,2) target_difference,achievement_rate,
                           round(lastyear_actual_value,2) lastyear_actual_value,round(same_difference,2) same_difference 
 from (select (t.year || '年第' || t.quarter|| '季度') total_time,'汇总' CLASSIFICATIONS,'0' category_id,
              t.target_values,t.actual_value,t.target_difference,t.achievement_rate,t.lastyear_actual_value,t.same_difference
         from scmdata.t_indicator_reached_quarter t
        where t.indicator_name = ']'|| vc_name ||''''||
       q'[ union all
       select k.total_time,k.category_name classifications,k.category category_id,
              tcb.target_value  target_values,k.tager_value_kpi actual_value,
              (k.tager_value_kpi-tcb.target_value)target_difference,
              (case when 2-(k.tager_value_kpi/tcb.target_value) > 1 then 1
                    when 2-(k.tager_value_kpi/tcb.target_value) < 0 then 0
                    else 2-(k.tager_value_kpi/tcb.target_value) end)achievement_rate,
              k1.last_value_actual lastyear_actual_value,
              k.tager_value_kpi-k1.last_value_actual same_difference
         from (select company_id,total_time,year,quarter,category,category_name,tager_type,tager_value_kpi
                     from (select t.company_id, (t.year || '年第' || t.quarter|| '季度') total_time,
                                  t.year,t.quarter,t.category_name,t.category,
                                  max(t.sho_order_money / t.order_money) sho_order_money,
                                  max(t.delivery_order_money / t.delivery_money) delivery_order_money,
                                  max(t1.shop_rt_money) / max(t1.ingood_money) shop_rt_money,
                                  max(t1.warehouse_rt_money) / max(t1.ingood_money) warehouse_rt_money
                            from scmdata.t_kpiorder_quarter t
                            left join scmdata.t_kpireturn_cate_rate_quarter t1
                              on t1.company_id = t.company_id
                             and t1.year = t.year
                             and t1.quarter = t.quarter
                             and t1.category = t.category
                             and t1.category_name = t.category_name
                           group by t.company_id,t.year,(t.year || '年第' || t.quarter|| '季度'),t.quarter,t.category,t.category_name)
      unpivot (tager_value_kpi for tager_type in (sho_order_money as'订单满足率',delivery_order_money as'补货平均交期',
                                                  shop_rt_money as'门店退货率',warehouse_rt_money as '仓库退货率'))
        where tager_type = ']'|| vc_name ||''''|| q'[)k
         left join (select tc.company_id, tc.ayear,tc.target_name,tb.category,tb.target_value 
                      from scmdata.t_target_value_config tc 
                     inner join scmdata.t_target_value_branch_config tb
                        on tc.company_id = tb.company_id
                       and tc.target_id = tb.target_id)tcb
           on tcb.company_id = k.company_id
          and tcb.ayear = k.year
          and tcb.target_name = k.tager_type
          and tcb.category = k.category_name
         left join(select company_id,year,quarter,category_name,tager_type,last_value_actual
         from (select t.company_id, t.year+1 year, t.quarter,t.category_name,
                      max(t.sho_order_money / t.order_money) sho_order_money,
                      max(t.delivery_order_money / t.delivery_money) delivery_order_money,
                      max(t1.shop_rt_money) / max(t1.ingood_money) shop_rt_money,
                      max(t1.warehouse_rt_money) / max(t1.ingood_money) warehouse_rt_money
                 from scmdata.t_kpiorder_quarter t
                 left join scmdata.t_kpireturn_cate_rate_quarter t1
                   on t1.company_id = t.company_id
                  and t1.year = t.year
                  and t1.quarter = t.quarter
                  and t1.category = t.category
                  and t1.category_name = t.category_name
                group by t.company_id,t.year+1, t.quarter,t.category_name)
          unpivot (last_value_actual for tager_type in (sho_order_money as'订单满足率',delivery_order_money as'补货平均交期',
                                                        shop_rt_money as'门店退货率',warehouse_rt_money as '仓库退货率'))
          where tager_type = ']'|| vc_name ||''''|| q'[)k1
             on k.company_id = k1.company_id
            and k.category_name = k1.category_name
            and k.year = k1.year
            and k.quarter = k1.quarter
          where k.tager_type=  ']'|| vc_name ||''''|| 
            'and k.company_id = '||'''' || vc_id ||''''||
         q'[order by total_time desc ,category_id )
            where total_time = ']' || vc_time ||''''; 
      else
        vc_sql :=q'[ select  total_time,classifications, category_id ,target_values target1_values,actual_value actual1_value,
       (case when target_values*100 >=1 then to_char(round(target_values*100,2),'fm9999.90') ||'%'
             when target_values*100 >=0 and target_values*100 < 1 then to_char(round(target_values*100,2),'0.00') || '%'end)  target_values,
       (case when actual_value*100 >=1 then to_char(round(actual_value*100,2),'fm9999.90') ||'%'
             when actual_value*100 >=0 and actual_value*100 < 1 then to_char(round(actual_value*100,2),'0.00') || '%'end)  actual_value,
       (case when target_difference*100  >=1 then to_char(round(target_difference*100,2),'fm9999.90')|| '%' 
             when target_difference*100  >0 and target_difference*100 <1 then to_char(round(target_difference*100,2),'0.00')|| '%' 
             when target_difference*100  <0 and target_difference*100 >-1 then ('-0'||to_char(substr(round(target_difference*100,2),2,6),'fm9999.90')|| '%')
             when target_difference*100  <= -1 then to_char(round(target_difference*100,2),'fm9999.90')|| '%'  end)target_difference,
       achievement_rate,
       (case when lastyear_actual_value is null then ' '
             when lastyear_actual_value >= 0.01 then to_char(round(lastyear_actual_value*100,2),'fm9999.90') ||'%'
             else to_char(round(lastyear_actual_value*100,2),'0.00') || '%' end) lastyear_actual_value,
       (case when same_difference is null then ' '
             when same_difference*100 >= 1 then to_char(round(same_difference*100,2),'fm9999.90') || '%'
             when same_difference*100 <1 and same_difference*100 >0 then to_char(round(same_difference*100,2),'0.00') || '%'
             when same_difference*100 <0 and same_difference*100 >-1 then '-0'||to_char(substr(round(same_difference*100,2),2,6),'fm9999.90') || '%'
             when same_difference*100 <= -1 then to_char(round(same_difference*100,2),'fm9999.90') || '%' end) same_difference
 from (select (t.year || '年第' || t.quarter|| '季度') total_time,'汇总' CLASSIFICATIONS,'0' category_id,
             (case when t.target_values is null then 0 else t.target_values end)target_values,t.actual_value,t.target_difference,t.achievement_rate,t.lastyear_actual_value,t.same_difference
         from scmdata.t_indicator_reached_quarter t
        where t.indicator_name = ']'|| vc_name ||''''||
       q'[ union all
       select k.total_time,k.category_name classifications,k.category category_id,(
              tcb.target_value/100)target_values,k.tager_value_kpi actual_value,
              (k.tager_value_kpi-(tcb.target_value/100))target_difference,
               (case when ]' || ''''||vc_name||''''|| q'[ like '订单满足率%' then 
                   (case when (k.tager_value_kpi/(tcb.target_value/100)) > 1 then 1
                         when (k.tager_value_kpi/(tcb.target_value/100)) < 0 then 0
                         else (k.tager_value_kpi/(tcb.target_value/100)) end)
                  else
                   (case when 2-(k.tager_value_kpi/(tcb.target_value/100)) > 1 then 1
                         when 2-(k.tager_value_kpi/(tcb.target_value/100)) < 0 then 0
                         else 2-(k.tager_value_kpi/(tcb.target_value/100)) end)
                end)achievement_rate, 
              k1.last_value_actual lastyear_actual_value,
              k.tager_value_kpi-k1.last_value_actual same_difference
         from (select company_id,total_time,year,quarter,category,category_name,tager_type,tager_value_kpi
                     from (select t.company_id, (t.year || '年第' || t.quarter|| '季度') total_time,
                                  t.year,t.quarter,t.category_name,t.category,
                                  max(t.sho_order_money / t.order_money) sho_order_money,
                                  max(t.sho_order_original_money / t.order_money) sho_order_original_money,
                                  max(t.delivery_order_money / t.delivery_money) delivery_order_money,
                                  max(t1.shop_rt_money) / max(t1.ingood_money) shop_rt_money,
                                  max(t1.warehouse_rt_money) / max(t1.ingood_money) warehouse_rt_money
                            from scmdata.t_kpiorder_quarter t
                            left join scmdata.t_kpireturn_cate_rate_quarter t1
                              on t1.company_id = t.company_id
                             and t1.year = t.year
                             and t1.quarter = t.quarter
                             and t1.category = t.category
                             and t1.category_name = t.category_name
                           group by t.company_id,t.year,(t.year || '年第' || t.quarter|| '季度'),t.quarter,t.category,t.category_name)
      unpivot (tager_value_kpi for tager_type in (sho_order_money as'订单满足率(绩效值)',delivery_order_money as'补货平均交期',
              sho_order_original_money as '订单满足率(原值)',shop_rt_money as'门店退货率',warehouse_rt_money as '仓库退货率'))
        where tager_type = ']'|| vc_name ||''''|| q'[)k
         left join (select tc.company_id, tc.ayear,tc.target_name,tb.category,tb.target_value 
                      from scmdata.t_target_value_config tc 
                     inner join scmdata.t_target_value_branch_config tb
                        on tc.company_id = tb.company_id
                       and tc.target_id = tb.target_id)tcb
           on tcb.company_id = k.company_id
          and tcb.ayear = k.year
          and tcb.target_name = k.tager_type
          and tcb.category = k.category_name
         left join(select company_id,year,quarter,category_name,tager_type,last_value_actual
         from (select t.company_id, t.year+1 year, t.quarter,t.category_name,
                      max(t.sho_order_money / t.order_money) sho_order_money,
                      max(t.sho_order_original_money / t.order_money) sho_order_original_money,
                      max(t.delivery_order_money / t.delivery_money) delivery_order_money,
                      max(t1.shop_rt_money) / max(t1.ingood_money) shop_rt_money,
                      max(t1.warehouse_rt_money) / max(t1.ingood_money) warehouse_rt_money
                 from scmdata.t_kpiorder_quarter t
                 left join scmdata.t_kpireturn_cate_rate_quarter t1
                   on t1.company_id = t.company_id
                  and t1.year = t.year
                  and t1.quarter = t.quarter
                  and t1.category = t.category
                  and t1.category_name = t.category_name
                group by t.company_id,t.year+1, t.quarter,t.category_name)
          unpivot (last_value_actual for tager_type in (sho_order_money as'订单满足率(绩效值)',delivery_order_money as'补货平均交期',
                  sho_order_original_money as '订单满足率(原值)', shop_rt_money as'门店退货率',warehouse_rt_money as '仓库退货率'))
          where tager_type = ']'|| vc_name ||''''|| q'[)k1
             on k.company_id = k1.company_id
            and k.category_name = k1.category_name
            and k.year = k1.year
            and k.quarter = k1.quarter
          where k.tager_type=  ']'|| vc_name ||''''|| 
            'and k.company_id = '||'''' || vc_id ||''''||
         q'[order by total_time desc ,category_id )
            where total_time = ']' || vc_time ||''''; 
      end if;
    elsif vc_dimension = '区域组' then
        if vc_name = '补货平均交期' then
          vc_sql := q'[select total_time,area_group, groupname_id ,target_values target1_values,actual_value actual1_value,
       round(target_values,2)  target_values,
       round(actual_value,2) actual_value,round(target_difference,2) target_difference,achievement_rate,
       round(lastyear_actual_value,2) lastyear_actual_value,round(same_difference,2) same_difference 
from (select (t.year || '年第' || t.quarter|| '季度') total_time,'汇总' area_group,'0' groupname_id,
              t.target_values,t.actual_value,t.target_difference,t.achievement_rate,t.lastyear_actual_value,t.same_difference
         from scmdata.t_indicator_reached_quarter t
        where t.indicator_name = ']'||vc_name||''''||
       q'[ union all
       select k.total_time,k.group_name area_group,k.groupname groupname_id,
              tcb.target_value target_values,k.tager_value_kpi actual_value,
              (k.tager_value_kpi-tcb.target_value)target_difference,
              (case when 2-(k.tager_value_kpi/tcb.target_value) > 1 then 1
                    when 2-(k.tager_value_kpi/tcb.target_value) < 0 then 0
                    else 2-(k.tager_value_kpi/tcb.target_value) end)achievement_rate,
              k1.last_value_actual lastyear_actual_value,
              k.tager_value_kpi-k1.last_value_actual same_difference
         from (select company_id,total_time,year,quarter,groupname,tager_type,tager_value_kpi,group_name
                     from (select t.company_id, (t.year || '年第' || t.quarter|| '季度') total_time,
                                  t.year,t.quarter,t.groupname,tr.group_name,
                                  max(t.sho_order_money / t.order_money) sho_order_money,
                                  max(t.delivery_order_money / t.delivery_money) delivery_order_money,
                                  max(t1.shop_rt_money) / max(t1.ingood_money) shop_rt_money,
                                  max(t1.warehouse_rt_money) / max(t1.ingood_money) warehouse_rt_money
                            from scmdata.t_kpiorder_qu_quarter t
                            left join scmdata.t_kpireturn_qy_rate_quarter t1
                              on t1.company_id = t.company_id
                             and t1.year = t.year
                             and t1.quarter = t.quarter
                             and t1.group_name = t.groupname
                           inner join (select distinct ts.group_name, ts.group_config_id
                                         from scmdata.t_supplier_group_config ts) tr
                              on tr.group_config_id = t.groupname
                           group by t.company_id,t.year,(t.year || '年第' || t.quarter|| '季度'),t.quarter,t.groupname,tr.group_name)
      unpivot (tager_value_kpi for tager_type in (sho_order_money as'订单满足率',delivery_order_money as'补货平均交期',
                                                  shop_rt_money as'门店退货率',warehouse_rt_money as '仓库退货率'))
        where tager_type = ']'|| vc_name||''''||q'[)k
         left join (select tc.company_id, tc.ayear,tc.target_name,tb.group_config_id,tb.target_value 
                      from scmdata.t_target_value_config tc 
                     inner join scmdata.t_target_value_area_config tb
                        on tc.company_id = tb.company_id
                       and tc.target_id = tb.target_id)tcb
           on tcb.company_id = k.company_id
          and tcb.ayear = k.year
          and tcb.target_name = k.tager_type
          and tcb.group_config_id = k.groupname
         left join(select company_id,year,quarter,groupname,tager_type,last_value_actual
         from (select t.company_id, t.year+1 year, t.quarter,t.groupname ,
                      max(t.sho_order_money / t.order_money) sho_order_money,
                      max(t.delivery_order_money / t.delivery_money) delivery_order_money,
                      max(t1.shop_rt_money) / max(t1.ingood_money) shop_rt_money,
                      max(t1.warehouse_rt_money) / max(t1.ingood_money) warehouse_rt_money
                 from scmdata.t_kpiorder_qu_quarter t
                 left join scmdata.t_kpireturn_qy_rate_quarter t1
                   on t1.company_id = t.company_id
                  and t1.year = t.year
                  and t1.quarter = t.quarter
                  and t1.group_name  = t.groupname 
                group by t.company_id,t.year+1, t.quarter,t.groupname)
          unpivot (last_value_actual for tager_type in (sho_order_money as'订单满足率',delivery_order_money as'补货平均交期',
                                                        shop_rt_money as'门店退货率',warehouse_rt_money as '仓库退货率'))
          where tager_type = ']'|| vc_name||''''||q'[)k1
             on k.company_id = k1.company_id
            and k.groupname = k1.groupname
            and k.year = k1.year
            and k.quarter = k1.quarter
          where k.tager_type=  ']'|| vc_name||''''||
            'and k.company_id ='||''''|| vc_id ||''''||
          q'[order by  total_time desc ,groupname_id )
             where total_time = ']' ||vc_time|| '''';
        else
          vc_sql := q'[select total_time,area_group, groupname_id ,target_values target1_values,actual_value actual1_value,
       (case when target_values*100 >=1 then to_char(round(target_values*100,2),'fm9999.90') ||'%'
             when target_values*100 >0 and target_values*100 < 1 then to_char(round(target_values*100,2),'0.00') || '%'end)  target_values,
       (case when actual_value*100 >=1 then to_char(round(actual_value*100,2),'fm9999.90') ||'%'
             when actual_value*100 >=0 and actual_value*100 < 1 then to_char(round(actual_value*100,2),'0.00') || '%'end)  actual_value,
       (case when target_difference*100  >=1 then to_char(round(target_difference*100,2),'fm9999.90')|| '%' 
             when target_difference*100  >0 and target_difference*100 <1 then to_char(round(target_difference*100,2),'0.00')|| '%' 
             when target_difference*100  <0 and target_difference*100 >-1 then ('-0'||to_char(substr(round(target_difference*100,2),2,6),'fm9999.90')|| '%')
             when target_difference*100  <= -1 then to_char(round(target_difference*100,2),'fm9999.90')|| '%'  end)target_difference,
       achievement_rate,
       (case when lastyear_actual_value is null then ''
             when lastyear_actual_value >= 0.01 then to_char(round(lastyear_actual_value*100,2),'fm9999.90') ||'%'
             else to_char(round(lastyear_actual_value*100,2),'0.00') || '%' end) lastyear_actual_value,
       (case when same_difference is null then ' '
             when same_difference*100 >= 1 then to_char(round(same_difference*100,2),'fm9999.90') || '%'
             when same_difference*100 <1 and same_difference*100 >0 then to_char(round(same_difference*100,2),'0.00') || '%'
             when same_difference*100 <0 and same_difference*100 >-1 then '-0'||to_char(substr(round(same_difference*100,2),2,6),'fm9999.90') || '%'
             when same_difference*100 <= -1 then to_char(round(same_difference*100,2),'fm9999.90') || '%' end) same_difference 
from (select (t.year || '年第' || t.quarter|| '季度') total_time,'汇总' area_group,'0' groupname_id,
              t.target_values,t.actual_value,t.target_difference,t.achievement_rate,t.lastyear_actual_value,t.same_difference
         from scmdata.t_indicator_reached_quarter t
        where t.indicator_name = ']'||vc_name||''''||
       q'[ union all
       select k.total_time,k.group_name area_group,k.groupname category_id,(
              tcb.target_value/100)target_values,k.tager_value_kpi actual_value,
              (k.tager_value_kpi-(tcb.target_value/100))target_difference,
               (case when ]' || ''''||vc_name||''''|| q'[ like '订单满足率%' then 
                   (case when (k.tager_value_kpi/(tcb.target_value/100)) > 1 then 1
                         when (k.tager_value_kpi/(tcb.target_value/100)) < 0 then 0
                         else (k.tager_value_kpi/(tcb.target_value/100)) end)
                  else
                   (case when 2-(k.tager_value_kpi/(tcb.target_value/100)) > 1 then 1
                         when 2-(k.tager_value_kpi/(tcb.target_value/100)) < 0 then 0
                         else 2-(k.tager_value_kpi/(tcb.target_value/100)) end)
                end)achievement_rate, 
              k1.last_value_actual lastyear_actual_value,
              k.tager_value_kpi-k1.last_value_actual same_difference
         from (select company_id,total_time,year,quarter,groupname,tager_type,tager_value_kpi,group_name
                     from (select t.company_id, (t.year || '年第' || t.quarter|| '季度') total_time,
                                  t.year,t.quarter,t.groupname,tr.group_name,
                                  max(t.sho_order_money / t.order_money) sho_order_money,
                                  max(t.sho_order_original_money / t.order_money) sho_order_original_money,
                                  max(t.delivery_order_money / t.delivery_money) delivery_order_money,
                                  max(t1.shop_rt_money) / max(t1.ingood_money) shop_rt_money,
                                  max(t1.warehouse_rt_money) / max(t1.ingood_money) warehouse_rt_money
                            from scmdata.t_kpiorder_qu_quarter t
                            left join scmdata.t_kpireturn_qy_rate_quarter t1
                              on t1.company_id = t.company_id
                             and t1.year = t.year
                             and t1.quarter = t.quarter
                             and t1.group_name = t.groupname
                           inner join (select distinct ts.group_name, ts.group_config_id
                                         from scmdata.t_supplier_group_config ts) tr
                              on tr.group_config_id = t.groupname
                           group by t.company_id,t.year,(t.year || '年第' || t.quarter|| '季度'),t.quarter,t.groupname,tr.group_name)
      unpivot (tager_value_kpi for tager_type in (sho_order_money as'订单满足率(绩效值)',delivery_order_money as'补货平均交期',
                       sho_order_original_money as '订单满足率(原值)', shop_rt_money as'门店退货率',warehouse_rt_money as '仓库退货率'))
        where tager_type = ']'|| vc_name||''''||q'[)k
         left join (select tc.company_id, tc.ayear,tc.target_name,tb.group_config_id,tb.target_value 
                      from scmdata.t_target_value_config tc 
                     inner join scmdata.t_target_value_area_config tb
                        on tc.company_id = tb.company_id
                       and tc.target_id = tb.target_id)tcb
           on tcb.company_id = k.company_id
          and tcb.ayear = k.year
          and tcb.target_name = k.tager_type
          and tcb.group_config_id = k.groupname
         left join(select company_id,year,quarter,groupname,tager_type,last_value_actual
         from (select t.company_id, t.year+1 year, t.quarter,t.groupname ,
                      max(t.sho_order_money / t.order_money) sho_order_money,
                      max(t.sho_order_original_money / t.order_money) sho_order_original_money,
                      max(t.delivery_order_money / t.delivery_money) delivery_order_money,
                      max(t1.shop_rt_money) / max(t1.ingood_money) shop_rt_money,
                      max(t1.warehouse_rt_money) / max(t1.ingood_money) warehouse_rt_money
                 from scmdata.t_kpiorder_qu_quarter t
                 left join scmdata.t_kpireturn_qy_rate_quarter t1
                   on t1.company_id = t.company_id
                  and t1.year = t.year
                  and t1.quarter = t.quarter
                  and t1.group_name  = t.groupname 
                group by t.company_id,t.year+1, t.quarter,t.groupname)
          unpivot (last_value_actual for tager_type in (sho_order_money as'订单满足率(绩效值)',delivery_order_money as'补货平均交期',
                    sho_order_original_money as '订单满足率(原值)', shop_rt_money as'门店退货率',warehouse_rt_money as '仓库退货率'))
          where tager_type = ']'|| vc_name||''''||q'[)k1
             on k.company_id = k1.company_id
            and k.groupname = k1.groupname
            and k.year = k1.year
            and k.quarter = k1.quarter
          where k.tager_type=  ']'|| vc_name||''''||
            'and k.company_id ='||''''|| vc_id ||''''||
          q'[order by  total_time desc ,groupname_id )
             where total_time = ']' ||vc_time|| '''';
        end if;
    end if;
  elsif vc_timetype = '按半年度统计' then
    if vc_dimension = '分类'  then
      if vc_name = '补货平均交期' then
        vc_sql :=q'[select total_time,classifications, category_id ,target_values target1_values,actual_value actual1_value,
       round(target_values,2) target_values,
       round(actual_value,2) actual_value,round(target_difference,2) target_difference,achievement_rate,
       round(lastyear_actual_value,2) lastyear_actual_value,round(same_difference,2) same_difference 
from (select (t.year||'年'|| (case when t.halfyear = 1 then '上半年'
                             when t.halfyear = 2 then '下半年' end ))total_time,'汇总' classifications,'0' category_id,
              t.target_values,t.actual_value,t.target_difference,t.achievement_rate,t.lastyear_actual_value,t.same_difference
         from scmdata.t_indicator_reached_halfyear t
        where t.indicator_name = ']'|| vc_name ||''''||
       q'[ union all
       select k.total_time,k.category_name classifications,k.category category_id,tcb.target_value target_values,
              k.tager_value_kpi actual_value,(k.tager_value_kpi-tcb.target_value)target_difference,
              (case when 2-(k.tager_value_kpi/tcb.target_value) > 1 then 1
                    when 2-(k.tager_value_kpi/tcb.target_value) < 0 then 0
                    else 2-(k.tager_value_kpi/tcb.target_value) end)achievement_rate,
              k1.last_value_actual lastyear_actual_value,
              k.tager_value_kpi-k1.last_value_actual same_difference
         from (select company_id,total_time,year,is_halfyear,category,category_name,tager_type,tager_value_kpi
                     from (select t.company_id, (t.year||'年'|| (case when t.is_halfyear  = 1 then '上半年' when t.is_halfyear  = 2 then '下半年' end ))total_time,
                                  t.year,t.is_halfyear,t.category_name,t.category,
                                  max(t.sho_order_money / t.order_money) sho_order_money,
                                  max(t.delivery_order_money / t.delivery_money) delivery_order_money,
                                  max(t1.shop_rt_money) / max(t1.ingood_money) shop_rt_money,
                                  max(t1.warehouse_rt_money) / max(t1.ingood_money) warehouse_rt_money
                            from scmdata.t_kpiorder_halfyear t
                            left join scmdata.t_kpireturn_cate_rate_halfyear t1
                              on t1.company_id = t.company_id
                             and t1.year = t.year
                             and t1.halfyear  = t.is_halfyear
                             and t1.category = t.category
                             and t1.category_name = t.category_name
                           group by t.company_id,(t.year||'年'|| (case when t.is_halfyear  = 1 then '上半年' when t.is_halfyear  = 2 then '下半年' end )),
                                     t.year,t.is_halfyear,t.category,t.category_name)
      unpivot (tager_value_kpi for tager_type in (sho_order_money as'订单满足率',delivery_order_money as'补货平均交期',
                                                  shop_rt_money as'门店退货率',warehouse_rt_money as '仓库退货率'))
        where tager_type = ']'|| vc_name||'''' || q'[)k
         left join (select tc.company_id, tc.ayear,tc.target_name,tb.category,tb.target_value 
                      from scmdata.t_target_value_config tc 
                     inner join scmdata.t_target_value_branch_config tb
                        on tc.company_id = tb.company_id
                       and tc.target_id = tb.target_id)tcb
           on tcb.company_id = k.company_id
          and tcb.ayear = k.year
          and tcb.target_name = k.tager_type
          and tcb.category = k.category_name
         left join(select company_id,year,is_halfyear,category_name,tager_type,last_value_actual
         from (select t.company_id, t.year+1 year, t.is_halfyear,t.category_name,
                      max(t.sho_order_money / t.order_money) sho_order_money,
                      max(t.delivery_order_money / t.delivery_money) delivery_order_money,
                      max(t1.shop_rt_money) / max(t1.ingood_money) shop_rt_money,
                      max(t1.warehouse_rt_money) / max(t1.ingood_money) warehouse_rt_money
                 from scmdata.t_kpiorder_halfyear t
                 left join scmdata.t_kpireturn_cate_rate_halfyear t1
                   on t1.company_id = t.company_id
                  and t1.year = t.year
                  and t1.halfyear = t.is_halfyear
                  and t1.category = t.category
                  and t1.category_name = t.category_name
                group by t.company_id,t.year+1, t.is_halfyear,t.category_name)
          unpivot (last_value_actual for tager_type in (sho_order_money as'订单满足率',delivery_order_money as'补货平均交期',
                                                        shop_rt_money as'门店退货率',warehouse_rt_money as '仓库退货率'))
          where tager_type = ']' || vc_name ||''''|| q'[)k1
             on k.company_id = k1.company_id
            and k.category_name = k1.category_name
            and k.year = k1.year
            and k.is_halfyear = k1.is_halfyear
          where k.tager_type=  ']'|| vc_name||''''||
            'and k.company_id = '||''''|| vc_id ||''''||
         q'[order by  total_time desc ,category_id ) 
             where total_time = ]'|| vc_time; 
          else 
        vc_sql :=q'[select  total_time,classifications, category_id ,target_values target1_values,actual_value actual1_value,
       (case when target_values*100 >=1 then to_char(round(target_values*100,2),'fm9999.90') ||'%'
             when target_values*100 >=0 and target_values*100 < 1 then to_char(round(target_values*100,2),'0.00') || '%'end)  target_values,
       (case when actual_value*100 >=1 then to_char(round(actual_value*100,2),'fm9999.90') ||'%'
             when actual_value*100 >=0 and actual_value*100 < 1 then to_char(round(actual_value*100,2),'0.00') || '%'end)  actual_value,
       (case when target_difference*100  >=1 then to_char(round(target_difference*100,2),'fm9999.90')|| '%' 
             when target_difference*100  >0 and target_difference*100 <1 then to_char(round(target_difference*100,2),'0.00')|| '%' 
             when target_difference*100  <0 and target_difference*100 >-1 then ('-0'||to_char(substr(round(target_difference*100,2),2,6),'fm9999.90')|| '%')
             when target_difference*100  <= -1 then to_char(round(target_difference*100,2),'fm9999.90')|| '%'  end)target_difference,
       achievement_rate,
       (case when lastyear_actual_value is null then ''
             when lastyear_actual_value >= 0.01 then to_char(round(lastyear_actual_value*100,2),'fm9999.90') ||'%'
             else to_char(round(lastyear_actual_value*100,2),'0.00') || '%' end) lastyear_actual_value,
       (case when same_difference is null then ' '
             when same_difference*100 >= 1 then to_char(round(same_difference*100,2),'fm9999.90') || '%'
             when same_difference*100 <1 and same_difference*100 >0 then to_char(round(same_difference*100,2),'0.00') || '%'
             when same_difference*100 <0 and same_difference*100 >-1 then '-0'||to_char(substr(round(same_difference*100,2),2,6),'fm9999.90') || '%'
             when same_difference*100 <= -1 then to_char(round(same_difference*100,2),'fm9999.90') || '%' end) same_difference 
from (select (t.year||'年'|| (case when t.halfyear = 1 then '上半年'
                             when t.halfyear = 2 then '下半年' end ))total_time,'汇总' classifications,'0' category_id,
              t.target_values,t.actual_value,t.target_difference,t.achievement_rate,t.lastyear_actual_value,t.same_difference
         from scmdata.t_indicator_reached_halfyear t
        where t.indicator_name = ']'|| vc_name ||''''||
       q'[ union all
       select k.total_time,k.category_name classifications,k.category category_id,(tcb.target_value/100)target_values,
              k.tager_value_kpi actual_value,(k.tager_value_kpi-(tcb.target_value/100))target_difference,
               (case when ]' || ''''||vc_name||''''|| q'[ like '订单满足率%' then 
                   (case when (k.tager_value_kpi/(tcb.target_value/100)) > 1 then 1
                         when (k.tager_value_kpi/(tcb.target_value/100)) < 0 then 0
                         else (k.tager_value_kpi/(tcb.target_value/100)) end)
                  else
                   (case when 2-(k.tager_value_kpi/(tcb.target_value/100)) > 1 then 1
                         when 2-(k.tager_value_kpi/(tcb.target_value/100)) < 0 then 0
                         else 2-(k.tager_value_kpi/(tcb.target_value/100)) end)
                end)achievement_rate, 
              k1.last_value_actual lastyear_actual_value,
              k.tager_value_kpi-k1.last_value_actual same_difference
         from (select company_id,total_time,year,is_halfyear,category,category_name,tager_type,tager_value_kpi
                     from (select t.company_id, (t.year||'年'|| (case when t.is_halfyear  = 1 then '上半年' when t.is_halfyear  = 2 then '下半年' end ))total_time,
                                  t.year,t.is_halfyear,t.category_name,t.category,
                                  max(t.sho_order_money / t.order_money) sho_order_money,
                                  max(t.sho_order_original_money / t.order_money) sho_order_original_money,
                                  max(t.delivery_order_money / t.delivery_money) delivery_order_money,
                                  max(t1.shop_rt_money) / max(t1.ingood_money) shop_rt_money,
                                  max(t1.warehouse_rt_money) / max(t1.ingood_money) warehouse_rt_money
                            from scmdata.t_kpiorder_halfyear t
                            left join scmdata.t_kpireturn_cate_rate_halfyear t1
                              on t1.company_id = t.company_id
                             and t1.year = t.year
                             and t1.halfyear  = t.is_halfyear
                             and t1.category = t.category
                             and t1.category_name = t.category_name
                           group by t.company_id,(t.year||'年'|| (case when t.is_halfyear  = 1 then '上半年' when t.is_halfyear  = 2 then '下半年' end )),
                                     t.year,t.is_halfyear,t.category,t.category_name)
      unpivot (tager_value_kpi for tager_type in (sho_order_money as'订单满足率(绩效值)',delivery_order_money as'补货平均交期',
             sho_order_original_money as '订单满足率(原值)', shop_rt_money as'门店退货率',warehouse_rt_money as '仓库退货率'))
        where tager_type = ']'|| vc_name||'''' || q'[)k
         left join (select tc.company_id, tc.ayear,tc.target_name,tb.category,tb.target_value 
                      from scmdata.t_target_value_config tc 
                     inner join scmdata.t_target_value_branch_config tb
                        on tc.company_id = tb.company_id
                       and tc.target_id = tb.target_id)tcb
           on tcb.company_id = k.company_id
          and tcb.ayear = k.year
          and tcb.target_name = k.tager_type
          and tcb.category = k.category_name
         left join(select company_id,year,is_halfyear,category_name,tager_type,last_value_actual
         from (select t.company_id, t.year+1 year, t.is_halfyear,t.category_name,
                      max(t.sho_order_money / t.order_money) sho_order_money,
                      max(t.sho_order_original_money / t.order_money) sho_order_original_money,
                      max(t.delivery_order_money / t.delivery_money) delivery_order_money,
                      max(t1.shop_rt_money) / max(t1.ingood_money) shop_rt_money,
                      max(t1.warehouse_rt_money) / max(t1.ingood_money) warehouse_rt_money
                 from scmdata.t_kpiorder_halfyear t
                 left join scmdata.t_kpireturn_cate_rate_halfyear t1
                   on t1.company_id = t.company_id
                  and t1.year = t.year
                  and t1.halfyear = t.is_halfyear
                  and t1.category = t.category
                  and t1.category_name = t.category_name
                group by t.company_id,t.year+1, t.is_halfyear,t.category_name)
          unpivot (last_value_actual for tager_type in (sho_order_money as'订单满足率(绩效值)',delivery_order_money as'补货平均交期',
                sho_order_original_money as '订单满足率(原值)', shop_rt_money as'门店退货率',warehouse_rt_money as '仓库退货率'))
          where tager_type = ']' || vc_name ||''''|| q'[)k1
             on k.company_id = k1.company_id
            and k.category_name = k1.category_name
            and k.year = k1.year
            and k.is_halfyear = k1.is_halfyear
          where k.tager_type=  ']'|| vc_name||''''||
            'and k.company_id = '||''''|| vc_id ||''''||
         q'[order by  total_time desc ,category_id ) 
             where total_time = ']'|| vc_time ||'''';     
      end if;
    elsif vc_dimension = '区域组' then
        if vc_name = '补货平均交期' then
          vc_sql := q'[select total_time,area_group, groupname_id ,target_values target1_values,actual_value actual1_value,
       round(target_values,2)  target_values,
       round(actual_value,2) actual_value,round(target_difference,2) target_difference,achievement_rate,
       round(lastyear_actual_value,2) lastyear_actual_value,round(same_difference,2) same_difference 
from (select (t.year||'年'|| (case when t.halfyear = 1 then '上半年'
                             when t.halfyear = 2 then '下半年' end ))total_time,'汇总' area_group,'0' groupname_id,
              t.target_values,t.actual_value,t.target_difference,t.achievement_rate,t.lastyear_actual_value,t.same_difference
         from scmdata.t_indicator_reached_halfyear t
        where t.indicator_name = ']'||vc_name ||'''' ||
       q'[ union all
       select k.total_time,k.group_name area_group,k.groupname groupname_id,tcb.target_value target_values,
              k.tager_value_kpi actual_value,(k.tager_value_kpi-tcb.target_value)target_difference,
              (case when 2-(k.tager_value_kpi/tcb.target_value) > 1 then 1
                    when 2-(k.tager_value_kpi/tcb.target_value) < 0 then 0
                    else 2-(k.tager_value_kpi/tcb.target_value) end)achievement_rate,
              k1.last_value_actual lastyear_actual_value,
              k.tager_value_kpi-k1.last_value_actual same_difference
         from (select company_id,total_time,year,is_halfyear,groupname,tager_type,tager_value_kpi,group_name
                     from (select t.company_id, (t.year||'年'|| (case when t.is_halfyear  = 1 then '上半年' when t.is_halfyear  = 2 then '下半年' end ))total_time,
                                  t.year,t.is_halfyear,t.groupname,tr.group_name,
                                  max(t.sho_order_money / t.order_money) sho_order_money,
                                  max(t.delivery_order_money / t.delivery_money) delivery_order_money,
                                  max(t1.shop_rt_money) / max(t1.ingood_money) shop_rt_money,
                                  max(t1.warehouse_rt_money) / max(t1.ingood_money) warehouse_rt_money
                            from scmdata.t_kpiorder_qu_halfyear t
                            left join scmdata.t_kpireturn_qy_rate_halfyear t1
                              on t1.company_id = t.company_id
                             and t1.year = t.year
                             and t1.halfyear  = t.is_halfyear
                             and t1.group_name  = t.groupname 
                           inner join (select distinct ts.group_name, ts.group_config_id
                                         from scmdata.t_supplier_group_config ts) tr
                              on tr.group_config_id = t.groupname
                           group by t.company_id,(t.year||'年'|| (case when t.is_halfyear  = 1 then '上半年' when t.is_halfyear  = 2 then '下半年' end )),
                                     t.year,t.is_halfyear,t.groupname,tr.group_name )
      unpivot (tager_value_kpi for tager_type in (sho_order_money as'订单满足率',delivery_order_money as'补货平均交期',
                                                  shop_rt_money as'门店退货率',warehouse_rt_money as '仓库退货率'))
        where tager_type = ']'||vc_name ||'''' || q'[)k
         left join (select tc.company_id, tc.ayear,tc.target_name,tb.group_config_id,tb.target_value 
                      from scmdata.t_target_value_config tc 
                     inner join scmdata.t_target_value_area_config tb
                        on tc.company_id = tb.company_id
                       and tc.target_id = tb.target_id)tcb
           on tcb.company_id = k.company_id
          and tcb.ayear = k.year
          and tcb.target_name = k.tager_type
          and tcb.group_config_id = k.groupname
         left join(select company_id,year,is_halfyear,groupname ,tager_type,last_value_actual
         from (select t.company_id, t.year+1 year, t.is_halfyear,t.groupname ,
                      max(t.sho_order_money / t.order_money) sho_order_money,
                      max(t.delivery_order_money / t.delivery_money) delivery_order_money,
                      max(t1.shop_rt_money) / max(t1.ingood_money) shop_rt_money,
                      max(t1.warehouse_rt_money) / max(t1.ingood_money) warehouse_rt_money
                 from scmdata.t_kpiorder_qu_halfyear t
                 left join scmdata.t_kpireturn_qy_rate_halfyear t1
                   on t1.company_id = t.company_id
                  and t1.year = t.year
                  and t1.halfyear = t.is_halfyear
                  and t1.group_name  = t.groupname 
                group by t.company_id,t.year+1, t.is_halfyear,t.groupname )
          unpivot (last_value_actual for tager_type in (sho_order_money as'订单满足率',delivery_order_money as'补货平均交期',
                                                        shop_rt_money as'门店退货率',warehouse_rt_money as '仓库退货率'))
          where tager_type = ']'||vc_name ||'''' ||q'[)k1
             on k.company_id = k1.company_id
            and k.groupname  = k1.groupname 
            and k.year = k1.year
            and k.is_halfyear = k1.is_halfyear
          where k.tager_type=  ']'||vc_name ||'''' ||
           ' and k.company_id = '||'''' ||vc_id ||''''||
          q'[order by  total_time desc ,groupname_id )
             where total_time = ']' ||vc_time || '''';
        else
          vc_sql := q'[select total_time,area_group, groupname_id ,target_values target1_values,actual_value actual1_value,
       (case when target_values*100 >=1 then to_char(round(target_values*100,2),'fm9999.90') ||'%'
             when target_values*100 >=0 and target_values*100 < 1 then to_char(round(target_values*100,2),'0.00') || '%'end)  target_values,
       (case when actual_value*100 >=1 then to_char(round(actual_value*100,2),'fm9999.90') ||'%'
             when actual_value*100 >=0 and actual_value*100 < 1 then to_char(round(actual_value*100,2),'0.00') || '%'end)  actual_value,
       (case when target_difference*100  >=1 then to_char(round(target_difference*100,2),'fm9999.90')|| '%' 
             when target_difference*100  >0 and target_difference*100 <1 then to_char(round(target_difference*100,2),'0.00')|| '%' 
             when target_difference*100  <0 and target_difference*100 >-1 then ('-0'||to_char(substr(round(target_difference*100,2),2,6),'fm9999.90')|| '%')
             when target_difference*100  <= -1 then to_char(round(target_difference*100,2),'fm9999.90')|| '%'  end)target_difference,
       achievement_rate,
       (case when lastyear_actual_value is null then ''
             when lastyear_actual_value >= 0.01 then to_char(round(lastyear_actual_value*100,2),'fm9999.90') ||'%'
             else to_char(round(lastyear_actual_value*100,2),'0.00') || '%'  end) lastyear_actual_value,
       (case when same_difference is null then ' '
             when same_difference*100 >= 1 then to_char(round(same_difference*100,2),'fm9999.90') || '%'
             when same_difference*100 <1 and same_difference*100 >0 then to_char(round(same_difference*100,2),'0.00') || '%'
             when same_difference*100 <0 and same_difference*100 >-1 then '-0'||to_char(substr(round(same_difference*100,2),2,6),'fm9999.90') || '%'
             when same_difference*100 <= -1 then to_char(round(same_difference*100,2),'fm9999.90') || '%' end) same_difference 
from (select (t.year||'年'|| (case when t.halfyear = 1 then '上半年'
                             when t.halfyear = 2 then '下半年' end ))total_time,'汇总' area_group,'0' groupname_id,
              t.target_values,t.actual_value,t.target_difference,t.achievement_rate,t.lastyear_actual_value,t.same_difference
         from scmdata.t_indicator_reached_halfyear t
        where t.indicator_name = ']'||vc_name ||'''' ||
       q'[ union all
       select k.total_time,k.group_name area_group,k.groupname groupname_id,(tcb.target_value/100)target_values,
              k.tager_value_kpi actual_value,(k.tager_value_kpi-(tcb.target_value/100))target_difference,
               (case when ]' || ''''||vc_name||''''|| q'[ like '订单满足率%' then 
                   (case when (k.tager_value_kpi/(tcb.target_value/100)) > 1 then 1
                         when (k.tager_value_kpi/(tcb.target_value/100)) < 0 then 0
                         else (k.tager_value_kpi/(tcb.target_value/100)) end)
                  else
                   (case when 2-(k.tager_value_kpi/(tcb.target_value/100)) > 1 then 1
                         when 2-(k.tager_value_kpi/(tcb.target_value/100)) < 0 then 0
                         else 2-(k.tager_value_kpi/(tcb.target_value/100)) end)
                end)achievement_rate, 
              k1.last_value_actual lastyear_actual_value,
              k.tager_value_kpi-k1.last_value_actual same_difference
         from (select company_id,total_time,year,is_halfyear,groupname,tager_type,tager_value_kpi,group_name
                     from (select t.company_id, (t.year||'年'|| (case when t.is_halfyear  = 1 then '上半年' when t.is_halfyear  = 2 then '下半年' end ))total_time,
                                  t.year,t.is_halfyear,t.groupname,tr.group_name,
                                  max(t.sho_order_money / t.order_money) sho_order_money,
                                  max(t.sho_order_original_money / t.order_money) sho_order_original_money,
                                  max(t.delivery_order_money / t.delivery_money) delivery_order_money,
                                  max(t1.shop_rt_money) / max(t1.ingood_money) shop_rt_money,
                                  max(t1.warehouse_rt_money) / max(t1.ingood_money) warehouse_rt_money
                            from scmdata.t_kpiorder_qu_halfyear t
                            left join scmdata.t_kpireturn_qy_rate_halfyear t1
                              on t1.company_id = t.company_id
                             and t1.year = t.year
                             and t1.halfyear  = t.is_halfyear
                             and t1.group_name  = t.groupname 
                           inner join (select distinct ts.group_name, ts.group_config_id
                                         from scmdata.t_supplier_group_config ts) tr
                              on tr.group_config_id = t.groupname
                           group by t.company_id,(t.year||'年'|| (case when t.is_halfyear  = 1 then '上半年' when t.is_halfyear  = 2 then '下半年' end )),
                                     t.year,t.is_halfyear,t.groupname,tr.group_name )
      unpivot (tager_value_kpi for tager_type in (sho_order_money as'订单满足率(绩效值)',delivery_order_money as'补货平均交期',
                sho_order_original_money as '订单满足率(原值)', shop_rt_money as'门店退货率',warehouse_rt_money as '仓库退货率'))
        where tager_type = ']'||vc_name ||'''' || q'[)k
         left join (select tc.company_id, tc.ayear,tc.target_name,tb.group_config_id,tb.target_value 
                      from scmdata.t_target_value_config tc 
                     inner join scmdata.t_target_value_area_config tb
                        on tc.company_id = tb.company_id
                       and tc.target_id = tb.target_id)tcb
           on tcb.company_id = k.company_id
          and tcb.ayear = k.year
          and tcb.target_name = k.tager_type
          and tcb.group_config_id = k.groupname
         left join(select company_id,year,is_halfyear,groupname ,tager_type,last_value_actual
         from (select t.company_id, t.year+1 year, t.is_halfyear,t.groupname ,
                      max(t.sho_order_money / t.order_money) sho_order_money,
                      max(t.sho_order_original_money / t.order_money) sho_order_original_money,
                      max(t.delivery_order_money / t.delivery_money) delivery_order_money,
                      max(t1.shop_rt_money) / max(t1.ingood_money) shop_rt_money,
                      max(t1.warehouse_rt_money) / max(t1.ingood_money) warehouse_rt_money
                 from scmdata.t_kpiorder_qu_halfyear t
                 left join scmdata.t_kpireturn_qy_rate_halfyear t1
                   on t1.company_id = t.company_id
                  and t1.year = t.year
                  and t1.halfyear = t.is_halfyear
                  and t1.group_name  = t.groupname 
                group by t.company_id,t.year+1, t.is_halfyear,t.groupname )
          unpivot (last_value_actual for tager_type in (sho_order_money as'订单满足率(绩效值)',delivery_order_money as'补货平均交期',
              sho_order_original_money as '订单满足率(原值)', shop_rt_money as'门店退货率',warehouse_rt_money as '仓库退货率'))
          where tager_type = ']'||vc_name ||'''' ||q'[)k1
             on k.company_id = k1.company_id
            and k.groupname  = k1.groupname 
            and k.year = k1.year
            and k.is_halfyear = k1.is_halfyear
          where k.tager_type=  ']'||vc_name ||'''' ||
           ' and k.company_id = '||'''' ||vc_id ||''''||
          q'[order by  total_time desc ,groupname_id )
             where total_time = ']' ||vc_time || '''';
        end if;
    end if;
  elsif vc_timetype = '按年度统计' then
    if vc_dimension = '分类'  then
      if vc_name = '补货平均交期' then
        vc_sql :=q'[select total_time,classifications, category_id ,target_values target1_values,actual_value actual1_value,
       round(target_values,2) target_values,
       round(actual_value,2) actual_value,round(target_difference,2) target_difference,achievement_rate,
       round(lastyear_actual_value,2) lastyear_actual_value,round(same_difference,2) same_difference 
from (select (t.year||'年')total_time,'汇总' classifications,'0' category_id,
              t.target_values,t.actual_value,t.target_difference,t.achievement_rate,t.lastyear_actual_value,t.same_difference
         from scmdata.t_indicator_reached_year t
        where t.indicator_name = ']'|| vc_name ||''''||
       q'[union all
       select k.total_time,k.category_name classifications,k.category category_id,tcb.target_value target_values,
              k.tager_value_kpi actual_value,(k.tager_value_kpi-tcb.target_value)target_difference,
              (case when 2-(k.tager_value_kpi/tcb.target_value) > 1 then 1
                    when 2-(k.tager_value_kpi/tcb.target_value) < 0 then 0
                    else 2-(k.tager_value_kpi/tcb.target_value) end)achievement_rate,
              k1.last_value_actual lastyear_actual_value,
              k.tager_value_kpi-k1.last_value_actual same_difference
         from (select company_id,total_time,year,category,category_name,tager_type,tager_value_kpi
                     from (select t.company_id, (t.year||'年')total_time,
                                  t.year,t.category_name,t.category,
                                  max(t.sho_order_money / t.order_money) sho_order_money,
                                  max(t.delivery_order_money / t.delivery_money) delivery_order_money,
                                  max(t1.shop_rt_money) / max(t1.ingood_money) shop_rt_money,
                                  max(t1.warehouse_rt_money) / max(t1.ingood_money) warehouse_rt_money
                            from scmdata.t_kpiorder_year t
                            left join scmdata.t_kpireturn_cate_rate_year t1
                              on t1.company_id = t.company_id
                             and t1.year = t.year
                             and t1.category = t.category
                             and t1.category_name = t.category_name
                           group by t.company_id,(t.year||'年'),t.year,t.category,t.category_name)
      unpivot (tager_value_kpi for tager_type in (sho_order_money as'订单满足率',delivery_order_money as'补货平均交期',
                                                  shop_rt_money as'门店退货率',warehouse_rt_money as '仓库退货率'))
        where tager_type = ']'|| vc_name ||'''' ||q'[)k
         left join (select tc.company_id, tc.ayear,tc.target_name,tb.category,tb.target_value 
                      from scmdata.t_target_value_config tc 
                     inner join scmdata.t_target_value_branch_config tb
                        on tc.company_id = tb.company_id
                       and tc.target_id = tb.target_id)tcb
           on tcb.company_id = k.company_id
          and tcb.ayear = k.year
          and tcb.target_name = k.tager_type
          and tcb.category = k.category_name
         left join(select company_id,year,category_name,tager_type,last_value_actual
         from (select t.company_id, t.year+1 year,t.category_name,
                      max(t.sho_order_money / t.order_money) sho_order_money,
                      max(t.delivery_order_money / t.delivery_money) delivery_order_money,
                      max(t1.shop_rt_money) / max(t1.ingood_money) shop_rt_money,
                      max(t1.warehouse_rt_money) / max(t1.ingood_money) warehouse_rt_money
                 from scmdata.t_kpiorder_year t
                 left join scmdata.t_kpireturn_cate_rate_year t1
                   on t1.company_id = t.company_id
                  and t1.year = t.year
                  and t1.category = t.category
                  and t1.category_name = t.category_name
                group by t.company_id,t.year+1,t.category_name)
          unpivot (last_value_actual for tager_type in (sho_order_money as'订单满足率',delivery_order_money as'补货平均交期',
                                                        shop_rt_money as'门店退货率',warehouse_rt_money as '仓库退货率'))
          where tager_type =' ]'|| vc_name ||'''' || q'[)k1
             on k.company_id = k1.company_id
            and k.category_name = k1.category_name
            and k.year = k1.year
          where k.tager_type=  ']'|| vc_name ||''''||
           ' and k.company_id =' ||''''|| vc_id ||''''||
          q'[order by total_time desc ,category_id )
             where total_time = ']' || vc_time ||'''';  
          else 
        vc_sql :=q'[select total_time,classifications, category_id ,target_values target1_values,actual_value actual1_value,
       (case when target_values*100 >=1 then to_char(round(target_values*100,2),'fm9999.90') ||'%'
             when target_values*100 >=0 and target_values*100 < 1 then to_char(round(target_values*100,2),'0.00') || '%'end)  target_values,
       (case when actual_value*100 >=1 then to_char(round(actual_value*100,2),'fm9999.90') ||'%'
             when actual_value*100 >=0 and actual_value*100 < 1 then to_char(round(actual_value*100,2),'0.00') || '%'end)  actual_value,
       (case when target_difference*100  >=1 then to_char(round(target_difference*100,2),'fm9999.90')|| '%' 
             when target_difference*100  >0 and target_difference*100 <1 then to_char(round(target_difference*100,2),'0.00')|| '%' 
             when target_difference*100  <0 and target_difference*100 >-1 then ('-0'||to_char(substr(round(target_difference*100,2),2,6),'fm9999.90')|| '%')
             when target_difference*100  <= -1 then to_char(round(target_difference*100,2),'fm9999.90')|| '%'  end)target_difference,
       achievement_rate,
       (case when lastyear_actual_value is null then ''
             when lastyear_actual_value >= 0.01 then to_char(round(lastyear_actual_value*100,2),'fm9999.90') ||'%'
             else to_char(round(lastyear_actual_value*100,2),'0.00') || '%' end) lastyear_actual_value,
       (case when same_difference is null then ' '
             when same_difference*100 >= 1 then to_char(round(same_difference*100,2),'fm9999.90') || '%'
             when same_difference*100 <1 and same_difference*100 >0 then to_char(round(same_difference*100,2),'0.00') || '%'
             when same_difference*100 <0 and same_difference*100 >-1 then '-0'||to_char(substr(round(same_difference*100,2),2,6),'fm9999.90') || '%'
             when same_difference*100 <= -1 then to_char(round(same_difference*100,2),'fm9999.90') || '%' end) same_difference
 from (select (t.year||'年')total_time,'汇总' classifications,'0' category_id,
              t.target_values,t.actual_value,t.target_difference,t.achievement_rate,t.lastyear_actual_value,t.same_difference
         from scmdata.t_indicator_reached_year t
        where t.indicator_name = ']'|| vc_name ||''''||
       q'[union all
       select k.total_time,k.category_name classifications,k.category category_id,(tcb.target_value/100)target_values,
              k.tager_value_kpi actual_value,(k.tager_value_kpi-(tcb.target_value/100))target_difference,
               (case when ]' || ''''||vc_name||''''|| q'[ like '订单满足率%' then 
                   (case when (k.tager_value_kpi/(tcb.target_value/100)) > 1 then 1
                         when (k.tager_value_kpi/(tcb.target_value/100)) < 0 then 0
                         else (k.tager_value_kpi/(tcb.target_value/100)) end)
                  else
                   (case when 2-(k.tager_value_kpi/(tcb.target_value/100)) > 1 then 1
                         when 2-(k.tager_value_kpi/(tcb.target_value/100)) < 0 then 0
                         else 2-(k.tager_value_kpi/(tcb.target_value/100)) end)
                end)achievement_rate, 
              k1.last_value_actual lastyear_actual_value,
              k.tager_value_kpi-k1.last_value_actual same_difference
         from (select company_id,total_time,year,category,category_name,tager_type,tager_value_kpi
                     from (select t.company_id, (t.year||'年')total_time,
                                  t.year,t.category_name,t.category,
                                  max(t.sho_order_money / t.order_money) sho_order_money,
                                  max(t.sho_order_original_money / t.order_money) sho_order_original_money,
                                  max(t.delivery_order_money / t.delivery_money) delivery_order_money,
                                  max(t1.shop_rt_money) / max(t1.ingood_money) shop_rt_money,
                                  max(t1.warehouse_rt_money) / max(t1.ingood_money) warehouse_rt_money
                            from scmdata.t_kpiorder_year t
                            left join scmdata.t_kpireturn_cate_rate_year t1
                              on t1.company_id = t.company_id
                             and t1.year = t.year
                             and t1.category = t.category
                             and t1.category_name = t.category_name
                           group by t.company_id,(t.year||'年'),t.year,t.category,t.category_name)
      unpivot (tager_value_kpi for tager_type in (sho_order_money as'订单满足率(绩效值)',delivery_order_money as'补货平均交期',
          sho_order_original_money as '订单满足率(原值)',shop_rt_money as'门店退货率',warehouse_rt_money as '仓库退货率'))
        where tager_type = ']'|| vc_name ||'''' ||q'[)k
         left join (select tc.company_id, tc.ayear,tc.target_name,tb.category,tb.target_value 
                      from scmdata.t_target_value_config tc 
                     inner join scmdata.t_target_value_branch_config tb
                        on tc.company_id = tb.company_id
                       and tc.target_id = tb.target_id)tcb
           on tcb.company_id = k.company_id
          and tcb.ayear = k.year
          and tcb.target_name = k.tager_type
          and tcb.category = k.category_name
         left join(select company_id,year,category_name,tager_type,last_value_actual
         from (select t.company_id, t.year+1 year,t.category_name,
                      max(t.sho_order_money / t.order_money) sho_order_money,
                      max(t.sho_order_original_money / t.order_money) sho_order_original_money,
                      max(t.delivery_order_money / t.delivery_money) delivery_order_money,
                      max(t1.shop_rt_money) / max(t1.ingood_money) shop_rt_money,
                      max(t1.warehouse_rt_money) / max(t1.ingood_money) warehouse_rt_money
                 from scmdata.t_kpiorder_year t
                 left join scmdata.t_kpireturn_cate_rate_year t1
                   on t1.company_id = t.company_id
                  and t1.year = t.year
                  and t1.category = t.category
                  and t1.category_name = t.category_name
                group by t.company_id,t.year+1,t.category_name)
          unpivot (last_value_actual for tager_type in (sho_order_money as'订单满足率(绩效值)',delivery_order_money as'补货平均交期',
                sho_order_original_money as '订单满足率(原值)', shop_rt_money as'门店退货率',warehouse_rt_money as '仓库退货率'))
          where tager_type = ']'|| vc_name ||'''' || q'[)k1
             on k.company_id = k1.company_id
            and k.category_name = k1.category_name
            and k.year = k1.year
          where k.tager_type=  ']'|| vc_name ||''''||
           ' and k.company_id =' ||''''|| vc_id ||''''||
          q'[order by total_time desc ,category_id )
             where total_time = ']' || vc_time ||'''';
      end if;
    elsif vc_dimension = '区域组' then
        if vc_name = '补货平均交期' then
          vc_sql := q'[select total_time,area_group, groupname_id ,target_values target1_values,actual_value actual1_value,
       round(target_values,2)  target_values,
       round(actual_value,2) actual_value,round(target_difference,2) target_difference,achievement_rate,
       round(lastyear_actual_value,2) lastyear_actual_value,round(same_difference,2) same_difference 
from (select (t.year||'年')total_time,'汇总' area_group,'0' groupname_id,
              t.target_values,t.actual_value,t.target_difference,t.achievement_rate,t.lastyear_actual_value,t.same_difference
         from scmdata.t_indicator_reached_year t
        where t.indicator_name = ']'|| vc_name ||'''' || q'[
        union all
       select k.total_time,k.group_name area_group, k.groupname groupname_id,tcb.target_value target_values,
              k.tager_value_kpi actual_value,(k.tager_value_kpi-tcb.target_value)target_difference,
              (case when 2-(k.tager_value_kpi/tcb.target_value) > 1 then 1
                    when 2-(k.tager_value_kpi/tcb.target_value) < 0 then 0
                    else 2-(k.tager_value_kpi/tcb.target_value) end)achievement_rate,
              k1.last_value_actual lastyear_actual_value,
              k.tager_value_kpi-k1.last_value_actual same_difference
         from (select company_id,total_time,year,groupname,tager_type,tager_value_kpi,group_name
                     from (select t.company_id, (t.year||'年')total_time,  t.year,t.groupname,tr.group_name,
                                  max(t.sho_order_money / t.order_money) sho_order_money,
                                  max(t.delivery_order_money / t.delivery_money) delivery_order_money,
                                  max(t1.shop_rt_money) / max(t1.ingood_money) shop_rt_money,
                                  max(t1.warehouse_rt_money) / max(t1.ingood_money) warehouse_rt_money
                            from scmdata.t_kpiorder_qu_year t
                            left join scmdata.t_kpireturn_qy_rate_year t1
                              on t1.company_id = t.company_id
                             and t1.year = t.year
                             and t1.group_name = t.groupname
                           inner join (select distinct ts.group_name, ts.group_config_id
                                         from scmdata.t_supplier_group_config ts) tr
                              on tr.group_config_id = t.groupname
                           group by t.company_id,(t.year||'年'),t.year,t.groupname,tr.group_name)
      unpivot (tager_value_kpi for tager_type in (sho_order_money as'订单满足率',delivery_order_money as'补货平均交期',
                                                  shop_rt_money as'门店退货率',warehouse_rt_money as '仓库退货率'))
        where tager_type = ']'|| vc_name ||'''' || q'[)k
         left join (select tc.company_id, tc.ayear,tc.target_name,tb.group_config_id,tb.target_value 
                      from scmdata.t_target_value_config tc 
                     inner join scmdata.t_target_value_area_config tb
                        on tc.company_id = tb.company_id
                       and tc.target_id = tb.target_id)tcb
           on tcb.company_id = k.company_id
          and tcb.ayear = k.year
          and tcb.target_name = k.tager_type
          and tcb.group_config_id = k.groupname
         left join(select company_id,year,groupname,tager_type,last_value_actual
         from (select t.company_id, t.year+1 year,t.groupname,
                      max(t.sho_order_money / t.order_money) sho_order_money,
                      max(t.delivery_order_money / t.delivery_money) delivery_order_money,
                      max(t1.shop_rt_money) / max(t1.ingood_money) shop_rt_money,
                      max(t1.warehouse_rt_money) / max(t1.ingood_money) warehouse_rt_money
                 from scmdata.t_kpiorder_qu_year t
                 left join scmdata.t_kpireturn_qy_rate_year t1
                   on t1.company_id = t.company_id
                  and t1.year = t.year
                  and t1.group_name = t.groupname
                group by t.company_id,t.year+1,t.groupname)
          unpivot (last_value_actual for tager_type in (sho_order_money as'订单满足率',delivery_order_money as'补货平均交期',
                                                        shop_rt_money as'门店退货率',warehouse_rt_money as '仓库退货率'))
          where tager_type = ']'|| vc_name ||'''' || q'[)k1
             on k.company_id = k1.company_id
            and k.groupname = k1.groupname
            and k.year = k1.year
          where k.tager_type=  ']'|| vc_name ||'''' || 
           ' and k.company_id ='||''''|| vc_id ||''''||
          q'[order by  total_time desc ,groupname_id )
             where total_time = ']' || vc_time || '''';
        else
          vc_sql := q'[select total_time,area_group, groupname_id ,target_values target1_values,actual_value actual1_value,
       (case when target_values*100 >=1 then to_char(round(target_values*100,2),'fm9999.90') ||'%'
             when target_values*100 >=0 and target_values*100 < 1 then to_char(round(target_values*100,2),'0.00') || '%'end)  target_values,
       (case when actual_value*100 >=1 then to_char(round(actual_value*100,2),'fm9999.90') ||'%'
             when actual_value*100 >=0 and actual_value*100 < 1 then to_char(round(actual_value*100,2),'0.00') || '%'end)  actual_value,
       (case when target_difference*100  >=1 then to_char(round(target_difference*100,2),'fm9999.90')|| '%' 
             when target_difference*100  >0 and target_difference*100 <1 then to_char(round(target_difference*100,2),'0.00')|| '%' 
             when target_difference*100  <0 and target_difference*100 >-1 then ('-0'||to_char(substr(round(target_difference*100,2),2,6),'fm9999.90')|| '%')
             when target_difference*100  <= -1 then to_char(round(target_difference*100,2),'fm9999.90')|| '%'  end)target_difference,
       achievement_rate,
       (case when lastyear_actual_value is null then ''
             when lastyear_actual_value >= 0.01 then to_char(round(lastyear_actual_value*100,2),'fm9999.90') ||'%'
             else to_char(round(lastyear_actual_value*100,2),'0.00') || '%' end) lastyear_actual_value,
       (case when same_difference is null then ' '
             when same_difference*100 >= 1 then to_char(round(same_difference*100,2),'fm9999.90') || '%'
             when same_difference*100 <1 and same_difference*100 >0 then to_char(round(same_difference*100,2),'0.00') || '%'
             when same_difference*100 <0 and same_difference*100 >-1 then '-0'||to_char(substr(round(same_difference*100,2),2,6),'fm9999.90') || '%'
             when same_difference*100 <= -1 then to_char(round(same_difference*100,2),'fm9999.90') || '%' end) same_difference 
from (select (t.year||'年')total_time,'汇总' area_group,'0' groupname_id,
              t.target_values,t.actual_value,t.target_difference,t.achievement_rate,t.lastyear_actual_value,t.same_difference
         from scmdata.t_indicator_reached_year t
        where t.indicator_name = ']'|| vc_name ||'''' || q'[
        union all
       select k.total_time,k.group_name area_group, k.groupname groupname_id,(tcb.target_value/100)target_values,
              k.tager_value_kpi actual_value,(k.tager_value_kpi-(tcb.target_value/100))target_difference,
               (case when ]' || ''''||vc_name||''''|| q'[ like '订单满足率%' then 
                   (case when (k.tager_value_kpi/(tcb.target_value/100)) > 1 then 1
                         when (k.tager_value_kpi/(tcb.target_value/100)) < 0 then 0
                         else (k.tager_value_kpi/(tcb.target_value/100)) end)
                  else
                   (case when 2-(k.tager_value_kpi/(tcb.target_value/100)) > 1 then 1
                         when 2-(k.tager_value_kpi/(tcb.target_value/100)) < 0 then 0
                         else 2-(k.tager_value_kpi/(tcb.target_value/100)) end)
                end)achievement_rate, 
              k1.last_value_actual lastyear_actual_value,
              k.tager_value_kpi-k1.last_value_actual same_difference
         from (select company_id,total_time,year,groupname,tager_type,tager_value_kpi,group_name
                     from (select t.company_id, (t.year||'年')total_time,  t.year,t.groupname,tr.group_name,
                                  max(t.sho_order_money / t.order_money) sho_order_money,
                                  max(t.sho_order_original_money / t.order_money) sho_order_original_money,
                                  max(t.delivery_order_money / t.delivery_money) delivery_order_money,
                                  max(t1.shop_rt_money) / max(t1.ingood_money) shop_rt_money,
                                  max(t1.warehouse_rt_money) / max(t1.ingood_money) warehouse_rt_money
                            from scmdata.t_kpiorder_qu_year t
                            left join scmdata.t_kpireturn_qy_rate_year t1
                              on t1.company_id = t.company_id
                             and t1.year = t.year
                             and t1.group_name = t.groupname
                           inner join (select distinct ts.group_name, ts.group_config_id
                                         from scmdata.t_supplier_group_config ts) tr
                              on tr.group_config_id = t.groupname
                           group by t.company_id,(t.year||'年'),t.year,t.groupname,tr.group_name)
      unpivot (tager_value_kpi for tager_type in (sho_order_money as'订单满足率(绩效值)',delivery_order_money as'补货平均交期',
       sho_order_original_money as '订单满足率(原值)',shop_rt_money as'门店退货率',warehouse_rt_money as '仓库退货率'))
        where tager_type = ']'|| vc_name ||'''' || q'[)k
         left join (select tc.company_id, tc.ayear,tc.target_name,tb.group_config_id,tb.target_value 
                      from scmdata.t_target_value_config tc 
                     inner join scmdata.t_target_value_area_config tb
                        on tc.company_id = tb.company_id
                       and tc.target_id = tb.target_id)tcb
           on tcb.company_id = k.company_id
          and tcb.ayear = k.year
          and tcb.target_name = k.tager_type
          and tcb.group_config_id = k.groupname
         left join(select company_id,year,groupname,tager_type,last_value_actual
         from (select t.company_id, t.year+1 year,t.groupname,
                      max(t.sho_order_money / t.order_money) sho_order_money,
                      max(t.sho_order_original_money / t.order_money) sho_order_original_money,
                      max(t.delivery_order_money / t.delivery_money) delivery_order_money,
                      max(t1.shop_rt_money) / max(t1.ingood_money) shop_rt_money,
                      max(t1.warehouse_rt_money) / max(t1.ingood_money) warehouse_rt_money
                 from scmdata.t_kpiorder_qu_year t
                 left join scmdata.t_kpireturn_qy_rate_year t1
                   on t1.company_id = t.company_id
                  and t1.year = t.year
                  and t1.group_name = t.groupname
                group by t.company_id,t.year+1,t.groupname)
          unpivot (last_value_actual for tager_type in (sho_order_money as'订单满足率(绩效值)',delivery_order_money as'补货平均交期',
                  sho_order_original_money as '订单满足率(原值)', shop_rt_money as'门店退货率',warehouse_rt_money as '仓库退货率'))
          where tager_type = ']'|| vc_name ||'''' || q'[)k1
             on k.company_id = k1.company_id
            and k.groupname = k1.groupname
            and k.year = k1.year
          where k.tager_type=  ']'|| vc_name ||'''' || 
           ' and k.company_id ='||''''|| vc_id ||''''||
          q'[order by  total_time desc ,groupname_id )
             where total_time = ']' || vc_time || '''';
        end if;
    end if;
  end if;
     return vc_sql;
   end f_return_indicator_report;
end  pkg_indicator_reached;
/

