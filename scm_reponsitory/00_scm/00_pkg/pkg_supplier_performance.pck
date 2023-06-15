create or replace package scmdata.pkg_supplier_performance is
  /*----------------------------------------------------------------  
     生成供应商绩效盘点报表数据表
         用途：
            供应商绩效盘点表（供应商维度）——按月份更新数据表
         用于：
            供应商绩效盘点报表——供应商tab页      
         更新规则：
             使用oracle数据库定时任务实现——每月更新上个月的数据
         入参（t_type 只能传入 0 或者 1 ）：
              t_type := 0 更新全部历史数据
              t_type := 1 只更新上月数据    
        上线版本:
            2022-03-23 
     2022-04-08 因数据有问题，修改订单满足率、前20%订单满足率分子的取数全部来源于底层订单交期表
  -------------------------------------------------------------------*/
  procedure p_supplier_performance_month(t_type number);

  /*-------------------------------------------------------------------  
     生成供应商绩效盘点报表数据表
         用途：
            供应商绩效盘点表（供应商维度）——按季度更新数据表
         用于：
            供应商绩效盘点报表——供应商tab页      
         更新规则：
             使用oracle数据库定时任务实现——每季度更新上个季度的数据
         入参（t_type 只能传入 0 或者 1 ）：
              t_type := 0 更新全部历史数据
              t_type := 1 只更新上个季度的数据                 
        版本:
            2022-03-24 
     2022-04-08 因数据有问题，修改订单满足率、前20%订单满足率分子的取数全部来源于底层订单交期表
  ----------------------------------------------------------------------*/
  procedure p_supplier_performance_quarter(t_type number);

  /*----------------------------------------------------------------------  
     生成供应商绩效盘点报表数据表
         用途：
            供应商绩效盘点表（供应商维度）——按半年度更新数据表
         用于：
            供应商绩效盘点报表——供应商tab页      
         更新规则：
             使用oracle数据库定时任务实现——每个半年度更新上个半年度的数据
          入参（t_type 只能传入 0 或者 1 ）：
              t_type := 0 更新全部历史数据
              t_type := 1 只更新上一个半年度的数据                
        版本:
            2022-03-24 
     2022-04-08 因数据有问题，修改订单满足率、前20%订单满足率分子的取数全部来源于底层订单交期表
  ------------------------------------------------------------------------*/
  procedure p_supplier_performance_halfyear(t_type number);

  /*------------------------------------------------------------------------  
     生成供应商绩效盘点报表数据表
         用途：
            供应商绩效盘点表（供应商维度）——按年度更新数据表
         用于：
            供应商绩效盘点报表——供应商tab页      
         更新规则：
             使用oracle数据库定时任务实现——每个年只更新上个年的数据
         入参（t_type 只能传入 0 或者 1 ）：
              t_type := 0 更新全部历史数据
              t_type := 1 只更新上一年的数据                 
        版本:
            2022-03-24
     2022-04-08 因数据有问题，修改订单满足率、前20%订单满足率分子的取数全部来源于底层订单交期表
  ------------------------------------------------------------------------*/
  procedure p_supplier_performance_year(t_type number);

  /*---------------------------------------------------------------  
     生成供应商绩效盘点报表数据表
         用途：
            供应商绩效盘点表（生成工厂维度）——按月份更新数据表
         用于：
            供应商绩效盘点报表——生成工厂tab页      
         更新规则：
             使用oracle数据库定时任务实现——每月更新上个月的数据
         入参（t_type 只能传入 0 或者 1 ）：
              t_type := 0 更新全部历史数据
              t_type := 1 只更新上月数据                 
        版本:
            2022-03-24 
     2022-04-08 因数据有问题，修改订单满足率、前20%订单满足率分子的取数全部来源于底层订单交期表
  ----------------------------------------------------------------*/
  procedure p_factory_performance_month(t_type number);

  /*---------------------------------------------------------------------  
     生成供应商绩效盘点报表数据表
         用途：
            供应商绩效盘点表（生成工厂维度）——按季度更新数据表
         用于：
            供应商绩效盘点报表——生成工厂tab页      
         更新规则：
             使用oracle数据库定时任务实现——每季度更新上个季度的数据
          入参（t_type 只能传入 0 或者 1 ）：
              t_type := 0 更新全部历史数据
              t_type := 1 只更新上季度数据                
        版本:
            2022-03-24 
     2022-04-08 因数据有问题，修改订单满足率、前20%订单满足率分子的取数全部来源于底层订单交期表
  -----------------------------------------------------------------------*/
  procedure p_factory_performance_quarter(t_type number);

  /*---------------------------------------------------------------------  
     生成供应商绩效盘点报表数据表
         用途：
            供应商绩效盘点表（生成工厂维度）——按半年度更新数据表
         用于：
            供应商绩效盘点报表——生成工厂tab页      
         更新规则：
             使用oracle数据库定时任务实现——每半年度只更新上个半年度的数据
          入参（t_type 只能传入 0 或者 1 ）：
              t_type := 0 更新全部历史数据
              t_type := 1 只更新上半年度的数据                
        版本:
            2022-03-24 
     2022-04-08 因数据有问题，修改订单满足率、前20%订单满足率分子的取数全部来源于底层订单交期表
  -------------------------------------------------------------------------*/
  procedure p_factory_performance_halfyear(t_type number);

  /*----------------------------------------------------------------------  
     生成供应商绩效盘点报表数据表
         用途：
            供应商绩效盘点表（生成工厂维度）——按年度更新数据表
         用于：
            供应商绩效盘点报表——生成工厂tab页      
         更新规则：
             使用oracle数据库定时任务实现——每年度只更新上个年度的数据
          入参（t_type 只能传入 0 或者 1 ）：
              t_type := 0 更新全部历史数据
              t_type := 1 只更新上一年的数据                
        版本:
            2022-03-24 
     2022-04-08 因数据有问题，修改订单满足率、前20%订单满足率分子的取数全部来源于底层订单交期表
  ------------------------------------------------------------------------*/
  procedure p_factory_performance_year(t_type number);
end pkg_supplier_performance;
/

create or replace package body scmdata.pkg_supplier_performance is

  /*-------------------------------------------------------------  
     生成供应商绩效盘点报表数据表
         用途：
            供应商绩效盘点表（供应商维度）——按月份更新数据表
         用于：
            供应商绩效盘点报表——供应商tab页      
         更新规则：
             使用oracle数据库定时任务实现——每月更新上个月的数据
         入参（t_type 只能传入 0 或者 1 ）：
              t_type := 0 更新全部历史数据
              t_type := 1 只更新上月数据    
        版本:
            2022-03-24 
     2022-04-08 因数据有问题，修改订单满足率、前20%订单满足率分子的取数全部来源于底层订单交期表
     2022-04-11 因底层订单交期表更改了责任部门，订单满足率、前20%订单满足率分子的责任部门全部修改
     2022-05-19 因需求变更，（1）统计维度由供应商修改为供应商+分类，
                            （2）修改了订单满足率、补货平均交期、延货金额、延货数量取值范围，
                            （3）新增异常金额、异常数量
  ---------------------------------------------------------------*/
  procedure p_supplier_performance_month(t_type number) is
    v_sql clob;
    v_z1  clob;
    v_z2  clob;
    v_w1  clob;
    v_w2  clob;
    /*只更新或者新增下单数量、下单金额字段*/
  begin
    v_z1 := q'[ merge into scmdata.t_supplier_performance_month tka
      using (select pt.company_id, to_char(pt.order_create_date, 'yyyy') year, to_char(pt.order_create_date, 'mm') month,
       pt.category, pt.category_name, t.supplier_code, pt.supplier_company_name supplier_name,
       sum(pt.order_amount) order_amount, sum(pt.order_money) order_money
      from scmdata.pt_ordered pt
     inner join scmdata.t_supplier_info t
        on t.company_id = pt.company_id
       and t.inside_supplier_code = pt.supplier_code ]';
    /*更新历史数据*/
    v_w1 := q'[ where (to_char(pt.order_create_date, 'yyyy') || to_char(pt.order_create_date, 'mm')) < to_char(sysdate,'yyyymm') ]';
    /*只更新上个月的数据*/
    v_w2 := q'[ where (to_char(pt.order_create_date, 'yyyy') || to_char(pt.order_create_date, 'mm')) = to_char(add_months(sysdate,-1),'yyyymm') ]';
    v_z2 := q'[ group by pt.company_id,to_char(pt.order_create_date, 'yyyy'),to_char(pt.order_create_date, 'mm'), 
                        pt.category,pt.category_name,t.supplier_code,pt.supplier_company_name) tkb
          on (tka.company_id = tkb.company_id and tka.year = tkb.year and tka.month = tkb.month 
              and tka.supplier_code = tkb.supplier_code and tka.category = tkb.category)
          when matched then
            update
               set tka.order_amount  = tkb.order_amount,
                   tka.order_money   = tkb.order_money,
                   tka.supplier_name = tkb.supplier_name,
                   tka.update_id     = 'ADMIN',
                   tka.update_time   = sysdate
          when not matched then
            insert
              (tka.t_sp_month_id,
               tka.company_id,
               tka.year,
               tka.month,
               tka.supplier_code,
               tka.supplier_name,
               tka.category,
               tka.category_name,
               tka.order_amount,
               tka.order_money,
               tka.create_id,
               tka.create_time)
            values
              (scmdata.f_get_uuid(),
               tkb.company_id,
               tkb.year,
               tkb.month,
               tkb.supplier_code,
               tkb.supplier_name,
               tkb.category,
               tkb.category_name,
               tkb.order_amount,
               tkb.order_money,
               'ADMIN',
               sysdate)]';
    if t_type = 0 then
      v_sql := v_z1 || v_w1 || v_z2;
    elsif t_type = 1 then
      v_sql := v_z1 || v_w2 || v_z2;
    end if;
    execute immediate v_sql;
  
    /*只更新或者新增交货数量、交货金额字段*/
    begin
      v_z1 := q'[ merge into scmdata.t_supplier_performance_month tka1
      using (select k.company_id,k.supplier_code,k.supplier_name,k.year,k.month,k.category,k.category_name,
                    sum(delivery_amount) delivery_amount,sum(k.delivery_money) delivery_money
               from (select oh.company_id, sp2.supplier_code,sp2.supplier_company_name supplier_name,to_char(tdr.delivery_date, 'yyyy') year,
                            to_char(tdr.delivery_date, 'mm') month,pt.category,pt.category_name, tdr.delivery_amount,(pt.fixed_price * tdr.delivery_amount) delivery_money
                       from scmdata.t_ordered oh
                      inner join scmdata.t_orders od
                         on oh.company_id = od.company_id
                        and oh.order_code = od.order_id
                      inner join scmdata.t_production_progress t
                         on t.company_id = od.company_id
                        and t.order_id = od.order_id
                        and t.goo_id = od.goo_id
                      inner join scmdata.t_commodity_info cf
                         on t.company_id = cf.company_id
                        and t.goo_id = cf.goo_id
                      inner join scmdata.t_supplier_info sp2
                         on t.company_id = sp2.company_id
                        and t.supplier_code = sp2.supplier_code
                      inner join scmdata.t_delivery_record tdr
                         on tdr.company_id = oh.company_id
                        and tdr.order_code = oh.order_code
                        and tdr.goo_id = cf.goo_id
                      inner join scmdata.pt_ordered pt
                         on pt.product_gress_code = tdr.order_code
                        and pt.company_id = tdr.company_id
                        and pt.supplier_company_name = sp2.supplier_company_name) k ]';
      v_w1 := q'[  where (k.year || k.month) < to_char(sysdate,'yyyymm') ]';
      v_w2 := q'[  where (k.year || k.month) = to_char(add_months(sysdate,-1),'yyyymm') ]';
      v_z2 := q'[  group by k.company_id,k.supplier_code, k.supplier_name,k.year,k.month,k.category,k.category_name) tkb1
          on (tka1.company_id = tkb1.company_id and tka1.year = tkb1.year and tka1.month = tkb1.month 
              and tka1.supplier_code = tkb1.supplier_code and tka1.category = tkb1.category)
          when matched then
            update
               set tka1.delivery_amount = tkb1.delivery_amount,
                   tka1.delivery_money  = tkb1.delivery_money,
                   tka1.supplier_name   = tkb1.supplier_name,
                   tka1.update_id       = 'ADMIN',
                   tka1.update_time     = sysdate
          when not matched then
            insert
              (tka1.t_sp_month_id,
               tka1.company_id,
               tka1.supplier_code,
               tka1.supplier_name,
               tka1.category,
               tka1.category_name,
               tka1.year,
               tka1.month,
               tka1.delivery_amount,
               tka1.delivery_money,
               tka1.create_id,
               tka1.create_time)
            values
              (scmdata.f_get_uuid(),
               tkb1.company_id,
               tkb1.supplier_code,
               tkb1.supplier_name,
               tkb1.category,
               tkb1.category_name,
               tkb1.year,
               tkb1.month,
               tkb1.delivery_amount,
               tkb1.delivery_money,
               'ADMIN',
               sysdate)]';
      if t_type = 0 then
        v_sql := v_z1 || v_w1 || v_z2;
      elsif t_type = 1 then
        v_sql := v_z1 || v_w2 || v_z2;
      end if;
      execute immediate v_sql;
    end;
    /*只更新或者新增订单满足率字段*/
    begin
      v_z1 := q'[ merge into scmdata.t_supplier_performance_month tka
        using (select t1.company_id,t1.supplier_company_name supplier_name,t1.supplier_code,t1.category,t1.category_name,
            t1.year,lpad(t1.month, 2, 0) month, t1.order_money,t2.sho_order_money
               from (select pt.company_id, pt.supplier_company_name,t.supplier_code,pt.category,
                            pt.category_name, pt.year,pt.month,sum(pt.order_money) order_money
                       from scmdata.pt_ordered pt
                      inner join scmdata.t_supplier_info t
                         on t.company_id = pt.company_id
                        and t.inside_supplier_code = pt.supplier_code 
                      group by pt.company_id, pt.supplier_company_name, pt.year, pt.month,t.supplier_code,pt.category,pt.category_name) t1
               left join (select tp.company_id, tp.supplier_company_name,tp.supplier_code,tp.category,tp.category_name,tp.year,tp.month, sum(tp.sum_money) sho_order_money
                           from (select t3.company_id,t3.supplier_company_name,t.supplier_code,t3.category,t3.category_name,t3.year,t3.month,t3.satisfy_money sum_money
                                   from scmdata.pt_ordered t3
                                  inner join scmdata.t_supplier_info t
                                     on t.company_id = t3.company_id
                                    and t.inside_supplier_code = t3.supplier_code 
                                   union all
                                 select t3a.company_id, t3a.supplier_company_name,t.supplier_code, t3a.category,t3a.category_name,t3a.year,t3a.month,
                                        (t3a.order_money  - t3a.satisfy_money ) sum_money
                                   from scmdata.pt_ordered t3a
                                  inner join scmdata.t_supplier_info t
                                     on t.company_id = t3a.company_id
                                    and t.inside_supplier_code = t3a.supplier_code 
                                  inner join scmdata.sys_company_dept a
                                     on a.company_id = t3a.company_id
                                    and a.company_dept_id = t3a.responsible_dept
                                    and a.pause = 0
                                  where (a.dept_name like '%物流部%'or a.dept_name like '%品类部%'
                             or a.dept_name like '%事业部%' or a.dept_name = '无')) tp
                          group by tp.company_id, tp.supplier_company_name,tp.supplier_code,tp.year,tp.month,tp.category,tp.category_name) t2
                 on t2.company_id = t1.company_id
                and t2.supplier_code = t1.supplier_code
                and t2.category = t1.category
                and t2.year = t1.year
                and t2.month = t1.month ]';
      v_w1 := q'[ where (t1.year || lpad(t1.month, 2, 0)) < to_char(sysdate,'yyyymm')) tkb ]';
      v_w2 := q'[ where (t1.year || lpad(t1.month, 2, 0)) = to_char(add_months(sysdate,-1),'yyyymm')) tkb ]';
      v_z2 := q'[ on (tka.company_id = tkb.company_id and tka.year = tkb.year and tka.month = tkb.month 
                 and tka.supplier_code = tkb.supplier_code and tka.category = tkb.category)
      when matched then
        update
           set tka.fillrate_order_money     = tkb.order_money,
               tka.fillrate_sho_order_money = tkb.sho_order_money,
               tka.supplier_name            = tkb.supplier_name,
               tka.update_id                = 'ADMIN',
               tka.update_time              = sysdate
      when not matched then
        insert
          (tka.t_sp_month_id,
           tka.company_id,
           tka.year,
           tka.month,
           tka.supplier_code,
           tka.supplier_name,
           tka.category,
           tka.category_name,
           tka.fillrate_order_money,
           tka.fillrate_sho_order_money,
           tka.create_id,
           tka.create_time)
        values
          (scmdata.f_get_uuid(),
           tkb.company_id,
           tkb.year,
           tkb.month,
           tkb.supplier_code,
           tkb.supplier_name,
           tkb.category,
           tkb.category_name,
           tkb.order_money,
           tkb.sho_order_money,
           'ADMIN',
           sysdate)]';
      if t_type = 0 then
        v_sql := v_z1 || v_w1 || v_z2;
      elsif t_type = 1 then
        v_sql := v_z1 || v_w2 || v_z2;
      end if;
      execute immediate v_sql;
    end;
  
    /*只更新或者新增补货平均交期字段*/
    begin
      v_z1 := q'[ merge into scmdata.t_supplier_performance_month tka
      using (select t1.company_id, t1.year, t1.month, t1.supplier_name,t1.supplier_code,
       t1.category,t1.category_name, sum(t1.sum1_money) delivery_money,sum(t1.sum1_date*t1.sum1_money) delivery_order_money
              from (select t5.company_id,t5.supplier_company_name supplier_name,tor.supplier_code,
                          to_char(tba.delivery_origin_time,'yyyy')year, to_char(tba.delivery_origin_time,'mm')month,t5.category, t5.category_name,
                     (to_date(to_char(tba.delivery_origin_time , 'yyyy/mm/dd'), 'yyyy/mm/dd') -
                     to_date(to_char(t5.order_create_date, 'yyyy/mm/dd'), 'yyyy/mm/dd')) sum1_date,
                     (t5.fixed_price * tba.delivery_amount) sum1_money
                from scmdata.pt_ordered t5
                inner join scmdata.t_delivery_record tba
                  on t5.product_gress_code = tba.order_code
                 and t5.company_id = tba.company_id
                inner join scmdata.t_ordered tor
                   on tor.company_id = tba.company_id
                  and tor.order_code = tba.order_code
                inner join scmdata.t_commodity_info tb
                  on t5.goo_id = tb.rela_goo_id
                 and tb.goo_id = tba.goo_id
                 and t5.company_id = tb.company_id
               where t5.is_first_order = 0
                 and tor.is_product_order = 1)t1  ]';
      v_w1 := q'[ where (t1.year || lpad(t1.month, 2, 0)) < to_char(sysdate,'yyyymm') ]';
      v_w2 := q'[ where (t1.year || lpad(t1.month, 2, 0)) = to_char(add_months(sysdate,-1),'yyyymm') ]';
      v_z2 := q'[ group by t1.company_id, t1.year, t1.month, t1.supplier_name,t1.supplier_code,t1.category, t1.category_name) tkb
      on (tka.company_id = tkb.company_id and tka.year = tkb.year and tka.month = tkb.month 
              and tka.supplier_code = tkb.supplier_code and tka.category = tkb.category)
      when matched then
        update
           set tka.average_delivery_money       = tkb.delivery_money,
               tka.average_delivery_order_money = tkb.delivery_order_money,
               tka.supplier_name                = tkb.supplier_name,
               tka.update_id                    = 'ADMIN',
               tka.update_time                  = sysdate
      when not matched then
        insert
          (tka.t_sp_month_id,
           tka.company_id,
           tka.year,
           tka.month,
           tka.supplier_code,
           tka.supplier_name,
           tka.category,
           tka.category_name,
           tka.average_delivery_money,
           tka.average_delivery_order_money,
           tka.create_id,
           tka.create_time)
        values
          (scmdata.f_get_uuid(),
           tkb.company_id,
           tkb.year,
           tkb.month,
           tkb.supplier_code,
           tkb.supplier_name,
           tkb.category,
           tkb.category_name,
           tkb.delivery_money,
           tkb.delivery_order_money,
           'ADMIN',
           sysdate)]';
      if t_type = 0 then
        v_sql := v_z1 || v_w1 || v_z2;
      elsif t_type = 1 then
        v_sql := v_z1 || v_w2 || v_z2;
      end if;
      execute immediate v_sql;
    end;
  
    /*只更新或者新增延期数量、延期金额字段*/
    begin
      v_z1 := q'[  merge into scmdata.t_supplier_performance_month tka
      using (select t2.company_id,t2.supplier_code,t2.supplier_company_name supplier_name, t2.year, t2.month,t2.category,t2.category_name,
                    sum(t2.delivery_amount) delay_amount,sum(t2.delivery_money) delay_money
               from (select oh.company_id,sp2.supplier_code,sp2.supplier_company_name, to_char(od.delivery_date, 'yyyy') year, pt.category,pt.category_name,
                            to_char(od.delivery_date, 'mm') month, tdr.delivery_amount,(pt.fixed_price * tdr.delivery_amount) delivery_money
                       from scmdata.t_ordered oh
                      inner join scmdata.t_orders od
                         on oh.company_id = od.company_id
                        and oh.order_code = od.order_id
                      inner join scmdata.t_production_progress t
                         on t.company_id = od.company_id
                        and t.order_id = od.order_id
                        and t.goo_id = od.goo_id
                      inner join scmdata.t_commodity_info cf
                         on t.company_id = cf.company_id
                        and t.goo_id = cf.goo_id
                      inner join scmdata.t_supplier_info sp2
                         on t.company_id = sp2.company_id
                        and t.supplier_code = sp2.supplier_code
                      inner join scmdata.t_delivery_record tdr
                         on tdr.company_id = oh.company_id
                        and tdr.order_code = oh.order_code
                        and tdr.goo_id = cf.goo_id
                      inner join scmdata.pt_ordered pt
                         on pt.product_gress_code = tdr.order_code
                        and pt.company_id = tdr.company_id
                        and pt.supplier_company_name = sp2.supplier_company_name
                      inner join scmdata.sys_company_dept a
                         on a.company_id = t.company_id
                        and a.company_dept_id =t.responsible_dept
                      where tdr.delivery_date > od.delivery_date
                        and a.dept_name = '供应链管理部') t2 ]';
      v_w1 := q'[ where (t2.year || lpad(t2.month, 2, 0)) < to_char(sysdate,'yyyymm') ]';
      v_w2 := q'[ where (t2.year || lpad(t2.month, 2, 0)) = to_char(add_months(sysdate,-1),'yyyymm') ]';
      v_z2 := q'[ group by t2.company_id, t2.supplier_code, t2.supplier_company_name,t2.category,t2.category_name,t2.year, t2.month) tkb
      on (tka.company_id = tkb.company_id and tka.year = tkb.year and tka.month = tkb.month 
              and tka.supplier_code = tkb.supplier_code and tka.category = tkb.category)
      when matched then
        update
           set tka.delay_amount  = tkb.delay_amount,
               tka.delay_money   = tkb.delay_money,
               tka.supplier_name = tkb.supplier_name,
               tka.update_id     = 'ADMIN',
               tka.update_time   = sysdate
      when not matched then
        insert
          (tka.t_sp_month_id,
           tka.company_id,
           tka.year,
           tka.month,
           tka.supplier_code,
           tka.supplier_name,
           tka.category,
           tka.category_name,
           tka.delay_amount,
           tka.delay_money,
           tka.create_id,
           tka.create_time)
        values
          (scmdata.f_get_uuid(),
           tkb.company_id,
           tkb.year,
           tkb.month,
           tkb.supplier_code,
           tkb.supplier_name,
           tkb.category,
           tkb.category_name,
           tkb.delay_amount,
           tkb.delay_money,
           'ADMIN',
           sysdate)]';
      if t_type = 0 then
        v_sql := v_z1 || v_w1 || v_z2;
      elsif t_type = 1 then
        v_sql := v_z1 || v_w2 || v_z2;
      end if;
      execute immediate v_sql;
    end;
  
    /*只更新或者新增批版通过率字段*/
    begin
      v_z1 := q'[  merge into scmdata.t_supplier_performance_month tka
      using (select t2.company_id, t2.year, t2.month,t2.supplier_code, t2.supplier_name,t2.category,gd.group_dict_name category_name, t2.sum_approver,t1.sum_np_approver
               from (select to_char(tav.approve_time, 'yyyy') year,to_char(tav.approve_time, 'mm') month, tav.company_id,
                            t.supplier_company_name supplier_name,tav.supplier_code,count(1) sum_approver,tci.category
                       from scmdata.t_approve_version tav
                      inner join scmdata.t_commodity_info tci
                         on tav.company_id = tci.company_id
                        and tav.goo_id = tci.goo_id
                      inner join scmdata.t_supplier_info t
                         on t.supplier_code = tav.supplier_code
                        and t.company_id = tav.company_id 
                      where tav.approve_result <> 'AS00'
                      group by to_char(tav.approve_time, 'yyyy'),to_char(tav.approve_time, 'mm'), 
                                t.supplier_company_name ,tci.category,tav.company_id, tav.supplier_code) t2
               left join (select to_char(t.approve_time, 'yyyy') year, to_char(t.approve_time, 'mm') month, t.supplier_code, 
                                 ta.supplier_company_name supplier_name, tci.category,t.company_id, count(1) sum_np_approver
                           from scmdata.t_approve_version t
                          inner join scmdata.t_commodity_info tci
                             on t.company_id = tci.company_id
                            and t.goo_id = tci.goo_id
                          inner join scmdata.t_supplier_info ta
                             on t.supplier_code = ta.supplier_code
                            and t.company_id = ta.company_id 
                          where t.approve_result = 'AS03'
                          group by to_char(t.approve_time, 'yyyy'), to_char(t.approve_time, 'mm'),
                                   ta.supplier_company_name,tci.category,t.supplier_code,t.company_id) t1
                 on t1.year = t2.year
                and t1.month = t2.month
                and t1.supplier_code = t2.supplier_code
                and t1.company_id = t2.company_id
                and t1.category = t2.category 
     inner join scmdata.sys_group_dict gd
        on gd.group_dict_type = 'PRODUCT_TYPE'
       and gd.group_dict_value = t2.category  ]';
      v_w1 := q'[ where (t1.year || lpad(t1.month, 2, 0)) < to_char(sysdate,'yyyymm')) tkb ]';
      v_w2 := q'[ where (t1.year || lpad(t1.month, 2, 0)) = to_char(add_months(sysdate,-1),'yyyymm')) tkb ]';
      v_z2 := q'[  on (tka.company_id = tkb.company_id and tka.year = tkb.year and tka.month = tkb.month 
                  and tka.supplier_code = tkb.supplier_code and tka.category = tkb.category )
          when matched then
            update
               set tka.batch_amount      = tkb.sum_approver,
                   tka.batch_pass_amount = tkb.sum_np_approver,
                   tka.supplier_name     = tkb.supplier_name,
                   tka.update_id         = 'ADMIN',
                   tka.update_time       = sysdate
          when not matched then
            insert
              (tka.t_sp_month_id,
               tka.company_id,
               tka.year,
               tka.month,
               tka.supplier_code,
               tka.supplier_name,
               tka.category,
               tka.category_name,
               tka.batch_amount,
               tka.batch_pass_amount,
               tka.create_id,
               tka.create_time)
            values
              (scmdata.f_get_uuid(),
               tkb.company_id,
               tkb.year,
               tkb.month,
               tkb.supplier_code,
               tkb.supplier_name,
               tkb.category,
               tkb.category_name,
               tkb.sum_approver,
               tkb.sum_np_approver,
               'ADMIN',
               sysdate)]';
      if t_type = 0 then
        v_sql := v_z1 || v_w1 || v_z2;
      elsif t_type = 1 then
        v_sql := v_z1 || v_w2 || v_z2;
      end if;
      execute immediate v_sql;
    end;
  
    /*只更新或者新增面料检测合格率字段*/
    begin
      v_z1 := q'[ merge into scmdata.t_supplier_performance_month tka
         using (select m1.company_id, m1.year, m1.month, m1.supplier_code, m1.supplier_name,
       m1.category, gd.group_dict_name category_name, m1.check_number, m2.check_np_number
  from (select t.company_id, g.supplier_code,st.supplier_company_name supplier_name, to_char(t.check_date, 'yyyy') year,
               to_char(t.check_date, 'mm') month,g.category, count(1) check_number
          from scmdata.t_check_request t
         inner join scmdata.t_commodity_info g
            on g.goo_id = t.goo_id
           and g.company_id = t.company_id
         inner join scmdata.t_supplier_info st
            on st.supplier_code = g.supplier_code
           and st.company_id = t.company_id
         where t.company_id = 'b6cc680ad0f599cde0531164a8c0337f'
         group by t.company_id, to_char(t.check_date, 'yyyy'), to_char(t.check_date, 'mm'),
                  g.category,g.supplier_code, st.supplier_company_name) m1
  left join (select t.company_id, g.category, to_char(t.check_date, 'yyyy') year,to_char(t.check_date, 'mm') month,
                    g.supplier_code, si.supplier_company_name supplier_name, count(1) check_np_number
               from scmdata.t_check_request t
              inner join scmdata.t_commodity_info g
                 on g.goo_id = t.goo_id
                and g.company_id = t.company_id
              inner join scmdata.t_supplier_info si
                 on si.supplier_code = g.supplier_code
                and si.company_id = t.company_id
              where t.check_result = 'FABRIC_PASS'
              group by t.company_id, to_char(t.check_date, 'yyyy'), to_char(t.check_date, 'mm'), g.category,g.supplier_code, si.supplier_company_name) m2
    on m2.year = m1.year
   and m2.month = m1.month
   and m2.category = m1.category
   and m2.company_id = m1.company_id
   and m2.supplier_code = m1.supplier_code
 inner join scmdata.sys_group_dict gd
    on gd.group_dict_type = 'PRODUCT_TYPE'
   and gd.group_dict_value = m1.category]';
      v_w1 := q'[ where (m1.year || lpad(m1.month, 2, 0)) < to_char(sysdate,'yyyymm')) tkb ]';
      v_w2 := q'[ where (m1.year || lpad(m1.month, 2, 0)) = to_char(add_months(sysdate,-1),'yyyymm')) tkb ]';
      v_z2 := q'[ on (tka.company_id = tkb.company_id and tka.year = tkb.year and tka.month = tkb.month 
              and tka.supplier_code = tkb.supplier_code and tka.category = tkb.category and tka.category_name = tkb.category_name )
              when matched then
                update
                   set tka.fabric_amount      = tkb.check_number,
                       tka.fabric_pass_amount = tkb.check_np_number,
                       tka.supplier_name      = tkb.supplier_name,
                       tka.update_id          = 'ADMIN',
                       tka.update_time        = sysdate
              when not matched then
                insert
                  (tka.t_sp_month_id,
                   tka.company_id,
                   tka.year,
                   tka.month,
                   tka.supplier_code,
                   tka.supplier_name,
                   tka.category,
                   tka.category_name,
                   tka.fabric_amount,
                   tka.fabric_pass_amount,
                   tka.create_id,
                   tka.create_time)
                values
                  (scmdata.f_get_uuid(),
                   tkb.company_id,
                   tkb.year,
                   tkb.month,
                   tkb.supplier_code,
                   tkb.supplier_name,
                   tkb.category,
                   tkb.category_name,
                   tkb.check_number,
                   tkb.check_np_number,
                   'ADMIN',
                   sysdate)]';
      if t_type = 0 then
        v_sql := v_z1 || v_w1 || v_z2;
      elsif t_type = 1 then
        v_sql := v_z1 || v_w2 || v_z2;
      end if;
      execute immediate v_sql;
    end;
  
    /*QC模块*/
    /*只更新或者新增首查字段*/
    begin
      v_z1 := q'[ merge into scmdata.t_supplier_performance_month tka
      using (select base.supplier supplier_name, base.company_id, to_char(base.finish_time, 'yyyy') year, to_char(base.finish_time, 'mm') month, 
                    base.supplier_code,base.category,base.category_name,sum(base.order_money) qc_number,
                    sum(case when base.last_qc_result = 'NORMAL_IS_QUALIFIED' then base.order_money
                           end) qualified_number
               from (select k.order_id,k.company_id, k.supplier, k.supplier_code,k.category,k.category_name,min(k.finish_time) finish_time, k.qc_check_node, k.last_qc_result,k.order_money 
                       from (select o.order_id,o.company_id, si.supplier_company_name supplier, qc.finish_time, g.qc_check_node,pt.order_money ,
                                     oe.supplier_code,pt.category,pt.category_name,
                                     first_value(qc.qc_result) over(partition by o.order_id, g.qc_check_node order by nvl(qc.finish_time, timestamp'2000-01-01 00:00:00')) LAST_QC_RESULT
                               from scmdata.t_orders o
                              inner join (select a.group_dict_value qc_check_node from scmdata.sys_group_dict a
                                           where a.group_dict_type = 'QC_CHECK_NODE_DICT' and a.pause = 0) g
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
                                and exists
                              (select 1  from scmdata.t_qc_check_rela_order a
                                      where a.orders_id = o.orders_id and a.qc_check_id = qc.qc_check_id)
                              inner join scmdata.t_commodity_info ci
                                 on o.goo_id = ci.goo_id
                                and ci.company_id = o.company_id
                              inner join scmdata.t_supplier_info si
                                 on si.supplier_code = oe.supplier_code
                                and si.company_id = oe.company_id
                              where g.qc_check_node = 'QC_FIRST_CHECK'
                                and qc.finish_time is not null) k
                      group by k.order_id,k.supplier,k.supplier_code,k.category,k.category_name, k.company_id,k.qc_check_node, k.last_qc_result,k.order_money) base ]';
      v_w1 := q'[ where (to_char(base.finish_time, 'yyyy') || to_char(base.finish_time, 'mm')) < to_char(sysdate,'yyyymm') ]';
      v_w2 := q'[ where (to_char(base.finish_time, 'yyyy') || to_char(base.finish_time, 'mm')) = to_char(add_months(sysdate,-1),'yyyymm') ]';
      v_z2 := q'[ group by base.supplier,base.supplier_code,base.category,base.category_name,
                           base.company_id, to_char(base.finish_time, 'yyyy'), to_char(base.finish_time, 'mm')) tkb
      on (tka.company_id = tkb.company_id and tka.year = tkb.year and tka.month = tkb.month 
              and tka.supplier_code = tkb.supplier_code and tka.category = tkb.category)
      when matched then
        update
           set tka.qc_firstcheck_ordermoney      = tkb.qc_number,
               tka.qc_firstcheck_pass_ordermoney = tkb.qualified_number,
               tka.supplier_name                 = tkb.supplier_name,
               tka.update_id                     = 'ADMIN',
               tka.update_time                   = sysdate
      when not matched then
        insert
          (tka.t_sp_month_id,
           tka.company_id,
           tka.year,
           tka.month,
           tka.supplier_code,
           tka.supplier_name,
           tka.category,
           tka.category_name,
           tka.qc_firstcheck_ordermoney,
           tka.qc_firstcheck_pass_ordermoney,
           tka.create_id,
           tka.create_time)
        values
          (scmdata.f_get_uuid(),
           tkb.company_id,
           tkb.year,
           tkb.month,
           tkb.supplier_code,
           tkb.supplier_name,
           tkb.category,
           tkb.category_name,
           tkb.qc_number,
           tkb.qualified_number,
           'ADMIN',
           sysdate)]';
      if t_type = 0 then
        v_sql := v_z1 || v_w1 || v_z2;
      elsif t_type = 1 then
        v_sql := v_z1 || v_w2 || v_z2;
      end if;
      execute immediate v_sql;
    end;
    /*QC模块*/
    /*只更新或者新增中查字段*/
    begin
      v_z1 := q'[ merge into scmdata.t_supplier_performance_month tka
      using (select base.supplier supplier_name,base.company_id, to_char(base.finish_time, 'yyyy') year, to_char(base.finish_time, 'mm') month,
                    base.supplier_code,base.category,base.category_name,sum(base.order_money) qc_number,
                    sum(case when base.last_qc_result = 'NORMAL_IS_QUALIFIED' then base.order_money end) qualified_number
               from (select k.order_id,k.company_id, k.supplier,k.supplier_code,k.category,k.category_name, min(k.finish_time) finish_time, k.qc_check_node, k.last_qc_result,k.order_money 
                       from (select o.order_id,o.company_id, si.supplier_company_name supplier, qc.finish_time, g.qc_check_node,pt.order_money ,oe.supplier_code,pt.category,pt.category_name,
                                     first_value(qc.qc_result) over(partition by o.order_id, g.qc_check_node order by nvl(qc.finish_time, timestamp'2000-01-01 00:00:00')) LAST_QC_RESULT
                               from scmdata.t_orders o
                              inner join (select a.group_dict_value qc_check_node from scmdata.sys_group_dict a
                                           where a.group_dict_type = 'QC_CHECK_NODE_DICT' and a.pause = 0) g
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
                                and exists
                              (select 1 from scmdata.t_qc_check_rela_order a
                                      where a.orders_id = o.orders_id and a.qc_check_id = qc.qc_check_id)
                              inner join scmdata.t_commodity_info ci
                                 on o.goo_id = ci.goo_id
                                and ci.company_id = o.company_id
                              inner join scmdata.t_supplier_info si
                                 on si.supplier_code = oe.supplier_code
                                and si.company_id = oe.company_id
                              where g.qc_check_node = 'QC_MIDDLE_CHECK'
                                and qc.finish_time is not null) k
                      group by k.order_id, k.supplier,k.supplier_code,k.category,k.category_name, k.company_id, k.qc_check_node, k.last_qc_result,k.order_money) base ]';
      v_w1 := q'[ where (to_char(base.finish_time, 'yyyy') || to_char(base.finish_time, 'mm')) < to_char(sysdate,'yyyymm') ]';
      v_w2 := q'[ where (to_char(base.finish_time, 'yyyy') || to_char(base.finish_time, 'mm')) = to_char(add_months(sysdate,-1),'yyyymm') ]';
      v_z2 := q'[ group by base.supplier,base.supplier_code,base.category,base.category_name, base.company_id,to_char(base.finish_time, 'yyyy'), to_char(base.finish_time, 'mm')) tkb
      on (tka.company_id = tkb.company_id and tka.year = tkb.year and tka.month = tkb.month 
              and tka.supplier_code = tkb.supplier_code and tka.category = tkb.category)
      when matched then
        update
           set tka.qc_middlecheck_ordermoney      = tkb.qc_number,
               tka.qc_middlecheck_pass_ordermoney = tkb.qualified_number,
               tka.supplier_name                  = tkb.supplier_name,
               tka.update_id                      = 'ADMIN',
               tka.update_time                    = sysdate
      when not matched then
        insert
          (tka.t_sp_month_id,
           tka.company_id,
           tka.year,
           tka.month,
           tka.supplier_code,
           tka.supplier_name,
           tka.category,
           tka.category_name,
           tka.qc_middlecheck_ordermoney,
           tka.qc_middlecheck_pass_ordermoney,
           tka.create_id,
           tka.create_time)
        values
          (scmdata.f_get_uuid(),
           tkb.company_id,
           tkb.year,
           tkb.month,
           tkb.supplier_code,
           tkb.supplier_name,
           tkb.category,
           tkb.category_name,
           tkb.qc_number,
           tkb.qualified_number,
           'ADMIN',
           sysdate)]';
      if t_type = 0 then
        v_sql := v_z1 || v_w1 || v_z2;
      elsif t_type = 1 then
        v_sql := v_z1 || v_w2 || v_z2;
      end if;
      execute immediate v_sql;
    end;
    /*QC模块*/
    /*只更新或者新增尾查字段*/
    begin
      v_z1 := q'[ merge into scmdata.t_supplier_performance_month tka
      using (select base.supplier supplier_name, base.company_id, to_char(base.finish_time, 'yyyy') year,  to_char(base.finish_time, 'mm') month,
                    base.supplier_code,base.category,base.category_name,sum(base.order_money) qc_number,
                    sum(case when base.last_qc_result = 'NORMAL_IS_QUALIFIED' then base.order_money end) qualified_number
               from (select k.order_id, k.company_id,k.supplier,k.supplier_code,k.category,k.category_name, min(k.finish_time) finish_time, k.qc_check_node, k.last_qc_result,k.order_money 
                       from (select o.order_id,o.company_id, si.supplier_company_name supplier, qc.finish_time, g.qc_check_node,pt.order_money ,oe.supplier_code,pt.category,pt.category_name,
                                     first_value(qc.qc_result) over(partition by o.order_id, g.qc_check_node order by nvl(qc.finish_time, timestamp'2000-01-01 00:00:00')) LAST_QC_RESULT
                               from scmdata.t_orders o
                              inner join (select a.group_dict_value qc_check_node from scmdata.sys_group_dict a
                                           where a.group_dict_type = 'QC_CHECK_NODE_DICT' and a.pause = 0) g
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
                                and exists
                              (select 1 from scmdata.t_qc_check_rela_order a
                                      where a.orders_id = o.orders_id and a.qc_check_id = qc.qc_check_id)
                              inner join scmdata.t_commodity_info ci
                                 on o.goo_id = ci.goo_id
                                and ci.company_id = o.company_id
                              inner join scmdata.t_supplier_info si
                                 on si.supplier_code = oe.supplier_code
                                and si.company_id = oe.company_id
                              where g.qc_check_node = 'QC_FINAL_CHECK'
                                and qc.finish_time is not null) k
                      group by k.order_id, k.supplier,k.supplier_code,k.category,k.category_name, k.company_id, k.qc_check_node, k.last_qc_result,k.order_money) base ]';
      v_w1 := q'[ where (to_char(base.finish_time, 'yyyy') || to_char(base.finish_time, 'mm')) < to_char(sysdate,'yyyymm') ]';
      v_w2 := q'[ where (to_char(base.finish_time, 'yyyy') || to_char(base.finish_time, 'mm')) = to_char(add_months(sysdate,-1),'yyyymm') ]';
      v_z2 := q'[ group by base.supplier,base.supplier_code,base.category,base.category_name, base.company_id,to_char(base.finish_time, 'yyyy'), to_char(base.finish_time, 'mm')) tkb
      on (tka.company_id = tkb.company_id and tka.year = tkb.year and tka.month = tkb.month 
              and tka.supplier_code = tkb.supplier_code and tka.category = tkb.category)
      when matched then
        update
           set tka.qc_finalcheck_ordermoney      = tkb.qc_number,
               tka.qc_finalcheck_pass_ordermoney = tkb.qualified_number,
               tka.supplier_name                 = tkb.supplier_name,
               tka.update_id                     = 'ADMIN',
               tka.update_time                   = sysdate
      when not matched then
        insert
          (tka.t_sp_month_id,
           tka.company_id,
           tka.year,
           tka.month,
           tka.supplier_code,
           tka.supplier_name,
           tka.category,
           tka.category_name,
           tka.qc_finalcheck_ordermoney,
           tka.qc_finalcheck_pass_ordermoney,
           tka.create_id,
           tka.create_time)
        values
          (scmdata.f_get_uuid(),
           tkb.company_id,
           tkb.year,
           tkb.month,
           tkb.supplier_code,
           tkb.supplier_name,
           tkb.category,
           tkb.category_name,
           tkb.qc_number,
           tkb.qualified_number,
           'ADMIN',
           sysdate)]';
      if t_type = 0 then
        v_sql := v_z1 || v_w1 || v_z2;
      elsif t_type = 1 then
        v_sql := v_z1 || v_w2 || v_z2;
      end if;
      execute immediate v_sql;
    end;

    /*只更新或者新增QA查货字段*/
    begin
      v_z1 := q'[ merge into scmdata.t_supplier_performance_month tka
      using (select k.company_id, k.year,k.month,k.qasupplier supplier_name,k.supplier_code,k.category,k.category_name,
           sum(k.pcomesum_amount) pcomesum_amount, sum(k2.pcomesum_amount) np_amount
               from (select distinct to_char(a.check_date, 'yyyy') year, to_char(a.check_date, 'mm') month, a.qa_report_id, a.pcomesum_amount,a.company_id,
                                     td.supplier_code,t.supplier_company_name qasupplier,tc.category,gd.group_dict_name category_name
                       from scmdata.t_qa_report a
                      inner join scmdata.t_qa_scope z
                         on a.qa_report_id = z.qa_report_id
                        and a.company_id = z.company_id
                      inner join scmdata.t_ordered td
                         on td.company_id = z.company_id
                        and td.order_code = z.order_id
                      inner join scmdata.t_commodity_info tc
                         on tc.company_id = z.company_id
                        and tc.goo_id = z.goo_id
                      inner join scmdata.sys_group_dict gd
                         on gd.group_dict_type = 'PRODUCT_TYPE'
                        and gd.group_dict_value = tc.category
                      inner join scmdata.t_supplier_info t
                         on t.company_id = z.company_id
                        and t.supplier_code = td.supplier_code
                      where a.status in ('N_ACF', 'R_ACF')) k
               left join (select distinct to_char(a.check_date, 'yyyy') year, to_char(a.check_date, 'mm') month, a.qa_report_id,
                                         a.pcomesum_amount, a.check_result, a.company_id,
                                         td.supplier_code,t.supplier_company_name qasupplier,tc.category,gd.group_dict_name category_name
                           from scmdata.t_qa_report a
                          inner join scmdata.t_qa_scope z
                             on a.qa_report_id = z.qa_report_id
                            and a.company_id = z.company_id
                          inner join scmdata.t_ordered td
                             on td.company_id = z.company_id
                            and td.order_code = z.order_id
                          inner join scmdata.t_commodity_info tc
                             on tc.company_id = z.company_id
                            and tc.goo_id = z.goo_id
                          inner join scmdata.sys_group_dict gd
                             on gd.group_dict_type = 'PRODUCT_TYPE'
                            and gd.group_dict_value = tc.category
                          inner join scmdata.t_supplier_info t
                             on t.company_id = z.company_id
                            and t.supplier_code = td.supplier_code
                          where a.status in ('N_ACF', 'R_ACF')
                            and a.check_result = 'QU') k2
                 on k2.qa_report_id = k.qa_report_id
                and k2.year = k.year
                and k2.month = k.month
                and k2.company_id = k.company_id
                and k2.supplier_code = k.supplier_code
                and k2.category = k.category  ]';
      v_w1 := q'[  where (k.year || k.month) < to_char(sysdate,'yyyymm') ]';
      v_w2 := q'[  where (k.year || k.month) = to_char(add_months(sysdate,-1),'yyyymm') ]';
      v_z2 := q'[  group by k.year, k.month, k.company_id, k.supplier_code,k.category,k.category_name,k.qasupplier) tkb
      on (tka.company_id = tkb.company_id and tka.year = tkb.year and tka.month = tkb.month 
              and tka.supplier_code = tkb.supplier_code and tka.category = tkb.category)
      when matched then
        update
           set tka.qa_check_amount      = tkb.pcomesum_amount,
               tka.qa_check_pass_amount = tkb.np_amount,
               tka.supplier_name        = tkb.supplier_name,
               tka.update_id            = 'ADMIN',
               tka.update_time          = sysdate
      when not matched then
        insert
          (tka.t_sp_month_id,
           tka.company_id,
           tka.year,
           tka.month,
           tka.supplier_code,
           tka.supplier_name,
           tka.category,
           tka.category_name,
           tka.qa_check_amount,
           tka.qa_check_pass_amount,
           tka.create_id,
           tka.create_time)
        values
          (scmdata.f_get_uuid(),
           tkb.company_id,
           tkb.year,
           tkb.month,
           tkb.supplier_code,
           tkb.supplier_name,
           tkb.category,
           tkb.category_name,
           tkb.pcomesum_amount,
           tkb.np_amount,
           'ADMIN',
           sysdate)]';
      if t_type = 0 then
        v_sql := v_z1 || v_w1 || v_z2;
      elsif t_type = 1 then
        v_sql := v_z1 || v_w2 || v_z2;
      end if;
      execute immediate v_sql;
    end;

    /*只更新或者新增异常金额、异常数量字段*/
    begin
      v_z1 := q'[ merge into scmdata.t_supplier_performance_month tka
      using ( select k.year,k.month,k.supplier_name,k.supplier_code,k.company_id,k.category,k.category_name,
       sum(k.delay_amount)quality_deviant_amount ,sum(k.delay_amount*k.price)quality_deviant_money 
  from (select to_char(a.confirm_date, 'yyyy') year,
               to_char(a.confirm_date, 'mm') month,
               a.company_id,
               a.delay_amount, --延期数量
               cf.price,
               sp2.supplier_code,
               sp2.supplier_company_name supplier_name,
               cf.category,
               gd_d.group_dict_name category_name
          from scmdata.t_ordered oh
         inner join scmdata.t_orders od
            on oh.company_id = od.company_id
           and oh.order_code = od.order_id
           and oh.order_status in ('OS01', 'OS02')
         inner join t_production_progress t
            on t.company_id = od.company_id
           and t.order_id = od.order_id
           and t.goo_id = od.goo_id
         inner join scmdata.t_commodity_info cf
            on t.company_id = cf.company_id
           and t.goo_id = cf.goo_id
         inner join scmdata.t_supplier_info sp2
            on t.company_id = sp2.company_id
           and t.supplier_code = sp2.supplier_code
         inner join scmdata.t_abnormal a
            on t.company_id = a.company_id
           and t.order_id = a.order_id
           and t.goo_id = a.goo_id
           and a.progress_status = '02'
           and a.origin <> 'SC'
         inner join scmdata.sys_company_user sb
            on a.company_id = sb.company_id
           and a.confirm_id = sb.user_id
         inner join scmdata.sys_group_dict gd_d
            on gd_d.group_dict_type = 'PRODUCT_TYPE'
           and gd_d.group_dict_value = cf.category
         where oh.company_id = 'a972dd1ffe3b3a10e0533c281cac8fd7'
           and a.anomaly_class = 'AC_QUALITY')k ]';
      v_w1 := q'[  where (k.year || k.month) < to_char(sysdate,'yyyymm') ]';
      v_w2 := q'[  where (k.year || k.month) = to_char(add_months(sysdate,-1),'yyyymm') ]';
      v_z2 := q'[  group by k.year,k.month,k.supplier_name,k.supplier_code,k.company_id, k.category,k.category_name) tkb
      on (tka.company_id = tkb.company_id and tka.year = tkb.year and tka.month = tkb.month 
              and tka.supplier_code = tkb.supplier_code and tka.category = tkb.category)
      when matched then
        update
           set tka.quality_deviant_amount = tkb.quality_deviant_amount,
               tka.quality_deviant_money  = tkb.quality_deviant_money,
               tka.supplier_name          = tkb.supplier_name,
               tka.update_id              = 'ADMIN',
               tka.update_time            = sysdate
      when not matched then
        insert
          (tka.t_sp_month_id,
           tka.company_id,
           tka.year,
           tka.month,
           tka.supplier_code,
           tka.supplier_name,
           tka.category,
           tka.category_name,
           tka.quality_deviant_amount,
           tka.quality_deviant_money,
           tka.create_id,
           tka.create_time)
        values
          (scmdata.f_get_uuid(),
           tkb.company_id,
           tkb.year,
           tkb.month,
           tkb.supplier_code,
           tkb.supplier_name,
           tkb.category,
           tkb.category_name,
           tkb.quality_deviant_amount,
           tkb.quality_deviant_money,
           'ADMIN',
           sysdate)]';
      if t_type = 0 then
        v_sql := v_z1 || v_w1 || v_z2;
      elsif t_type = 1 then
        v_sql := v_z1 || v_w2 || v_z2;
      end if;
      execute immediate v_sql;
    end;

  end p_supplier_performance_month;

  /*------------------------------------------------------------------  
     生成供应商绩效盘点报表数据表
         用途：
            供应商绩效盘点表（供应商维度）——按季度更新数据表
         用于：
            供应商绩效盘点报表——供应商tab页      
         更新规则：
             使用oracle数据库定时任务实现——每季度更新上个季度的数据
         入参（t_type 只能传入 0 或者 1 ）：
              t_type := 0 更新全部历史数据
              t_type := 1 只更新上个季度的数据                 
        版本:
            2022-03-24 
     2022-04-08 因数据有问题，修改订单满足率、前20%订单满足率分子的取数全部来源于底层订单交期表
     2022-04-11 因底层订单交期表更改了责任部门，订单满足率、前20%订单满足率分子的责任部门全部修改
     2022-05-19 因需求变更，（1）统计维度由供应商修改为供应商+分类，
                            （2）修改了订单满足率、补货平均交期、延货金额、延货数量取值范围，
                            （3）新增异常金额、异常数量
  -------------------------------------------------------------------*/
  procedure p_supplier_performance_quarter(t_type number) is
    v_sql clob;
    v_z1  clob;
    v_z2  clob;
    v_w1  clob;
    v_w2  clob;
    /*只更新或者新增下单数量、下单金额字段*/
  begin
    v_z1 := q'[ merge into scmdata.t_supplier_performance_quarter tka
    using (select pt.company_id,to_char(pt.order_create_date, 'yyyy') year,to_char(pt.order_create_date, 'Q') quarter,
                  pt.category,pt.category_name,t.supplier_code,
                  pt.supplier_company_name supplier_name, sum(pt.order_amount) order_amount, sum(pt.order_money) order_money
             from scmdata.pt_ordered pt 
            inner join scmdata.t_supplier_info t
               on t.company_id = pt.company_id
              and t.inside_supplier_code = pt.supplier_code ]';
    /*更新全部历史数据*/
    v_w1 := q'[ where (to_char(pt.order_create_date, 'yyyy') || to_char(pt.order_create_date, 'Q')) <= (to_char(add_months(sysdate,-3),'yyyy')||to_char(add_months(sysdate,-3),'q'))]';
    /*只更新上个季度的数据*/
    v_w2 := q'[ where (to_char(pt.order_create_date, 'yyyy') || to_char(pt.order_create_date, 'Q')) = (to_char(add_months(sysdate,-3),'yyyy')||to_char(add_months(sysdate,-3),'q'))]';
    v_z2 := q'[ group by pt.company_id, to_char(pt.order_create_date, 'yyyy'), to_char(pt.order_create_date, 'Q'),
                         pt.category,pt.category_name,t.supplier_code,pt.supplier_company_name) tkb
        on (tka.company_id = tkb.company_id and tka.year = tkb.year and tka.quarter = tkb.quarter 
              and tka.supplier_code = tkb.supplier_code and tka.category = tkb.category)
        when matched then
          update
             set tka.order_amount  = tkb.order_amount,
                 tka.order_money   = tkb.order_money,
                 tka.supplier_name = tkb.supplier_name,
                 tka.update_id     = 'ADMIN',
                 tka.update_time   = sysdate
        when not matched then
          insert
            (tka.t_sp_quarter_id,
             tka.company_id,
             tka.year,
             tka.quarter,
             tka.supplier_code,
             tka.supplier_name,
             tka.category,
             tka.category_name,
             tka.order_amount,
             tka.order_money,
             tka.create_id,
             tka.create_time)
          values
            (scmdata.f_get_uuid(),
             tkb.company_id,
             tkb.year,
             tkb.quarter,
             tkb.supplier_code,
             tkb.supplier_name,
             tkb.category,
             tkb.category_name,
             tkb.order_amount,
             tkb.order_money,
             'ADMIN',
             sysdate)]';
    if t_type = 0 then
      v_sql := v_z1 || v_w1 || v_z2;
    elsif t_type = 1 then
      v_sql := v_z1 || v_w2 || v_z2;
    end if;
    execute immediate v_sql;
  
    /*只更新或者新增交货数量、交货金额字段*/
    begin
      v_z1 := q'[  merge into scmdata.t_supplier_performance_quarter tka1
      using (select k.company_id,k.supplier_code, k.supplier_name, k.year, k.quarter,k.category,k.category_name,
                    sum(delivery_amount) delivery_amount, sum(k.delivery_money) delivery_money
               from (select oh.company_id, sp2.supplier_code,sp2.supplier_company_name supplier_name,pt.category,pt.category_name,
                            to_char(tdr.delivery_date, 'yyyy') year, to_char(tdr.delivery_date, 'Q') quarter,
                            tdr.delivery_amount,(pt.fixed_price * tdr.delivery_amount) delivery_money
                       from scmdata.t_ordered oh
                      inner join scmdata.t_orders od
                         on oh.company_id = od.company_id
                        and oh.order_code = od.order_id
                      inner join scmdata.t_production_progress t
                         on t.company_id = od.company_id
                        and t.order_id = od.order_id
                        and t.goo_id = od.goo_id
                      inner join scmdata.t_commodity_info cf
                         on t.company_id = cf.company_id
                        and t.goo_id = cf.goo_id
                      inner join scmdata.t_supplier_info sp2
                         on t.company_id = sp2.company_id
                        and t.supplier_code = sp2.supplier_code
                      inner join scmdata.t_delivery_record tdr
                         on tdr.company_id = oh.company_id
                        and tdr.order_code = oh.order_code
                        and tdr.goo_id = cf.goo_id
                      inner join scmdata.pt_ordered pt
                         on pt.product_gress_code = tdr.order_code
                        and pt.company_id = tdr.company_id
                        and pt.supplier_company_name = sp2.supplier_company_name) k ]';
      v_w1 := q'[ where (k.year || k.quarter) <= (to_char(add_months(sysdate,-3),'yyyy')||to_char(add_months(sysdate,-3),'q'))]';
      v_w2 := q'[ where (k.year || k.quarter) = (to_char(add_months(sysdate,-3),'yyyy')||to_char(add_months(sysdate,-3),'q'))]';
      v_z2 := q'[ group by k.company_id, k.supplier_code, k.supplier_name, k.category,k.category_name,k.year, k.quarter) tkb1
      on (tka1.company_id = tkb1.company_id and tka1.year = tkb1.year and tka1.quarter = tkb1.quarter 
            and tka1.supplier_code = tkb1.supplier_code and tka1.category = tkb1.category)
      when matched then
        update
           set tka1.delivery_amount = tkb1.delivery_amount,
               tka1.delivery_money  = tkb1.delivery_money,
               tka1.supplier_name   = tkb1.supplier_name,
               tka1.update_id       = 'ADMIN',
               tka1.update_time     = sysdate
      when not matched then
        insert
          (tka1.t_sp_quarter_id,
           tka1.company_id,
           tka1.year,
           tka1.quarter,
           tka1.supplier_code,
           tka1.supplier_name,
           tka1.category,
           tka1.category_name,
           tka1.delivery_amount,
           tka1.delivery_money,
           tka1.create_id,
           tka1.create_time)
        values
          (scmdata.f_get_uuid(),
           tkb1.company_id,
           tkb1.year,
           tkb1.quarter,
           tkb1.supplier_code,
           tkb1.supplier_name,
           tkb1.category,
           tkb1.category_name,
           tkb1.delivery_amount,
           tkb1.delivery_money,
           'ADMIN',
           sysdate)]';
      if t_type = 0 then
        v_sql := v_z1 || v_w1 || v_z2;
      elsif t_type = 1 then
        v_sql := v_z1 || v_w2 || v_z2;
      end if;
      execute immediate v_sql;
    end;
  
    /*只更新或者新增订单满足率字段*/
    begin
      v_z1 := q'[  merge into scmdata.t_supplier_performance_quarter tka
      using ( select t1.company_id,t1.supplier_company_name supplier_name,t1.supplier_code,t1.category,t1.category_name,
            t1.year,t1.quarter, t1.order_money,t2.sho_order_money
               from (select pt.company_id, pt.supplier_company_name,t.supplier_code,pt.category,
                            pt.category_name, pt.year,pt.quarter,sum(pt.order_money) order_money
                       from scmdata.pt_ordered pt
                      inner join scmdata.t_supplier_info t
                         on t.company_id = pt.company_id
                        and t.inside_supplier_code = pt.supplier_code 
                      group by pt.company_id, pt.supplier_company_name, pt.year, pt.quarter,t.supplier_code,pt.category,pt.category_name) t1
               left join (select tp.company_id, tp.supplier_company_name,tp.supplier_code,tp.category,tp.category_name,tp.year,tp.quarter, sum(tp.sum_money) sho_order_money
                           from (select t3.company_id,t3.supplier_company_name,t.supplier_code,t3.category,t3.category_name,t3.year,t3.quarter,t3.satisfy_money sum_money
                                   from scmdata.pt_ordered t3
                                  inner join scmdata.t_supplier_info t
                                     on t.company_id = t3.company_id
                                    and t.inside_supplier_code = t3.supplier_code 
                                   union all
                                 select t3a.company_id, t3a.supplier_company_name,t.supplier_code, t3a.category,t3a.category_name,t3a.year,t3a.quarter,
                                        (t3a.order_money  - t3a.satisfy_money ) sum_money
                                   from scmdata.pt_ordered t3a
                                  inner join scmdata.t_supplier_info t
                                     on t.company_id = t3a.company_id
                                    and t.inside_supplier_code = t3a.supplier_code 
                                  inner join scmdata.sys_company_dept a
                                     on a.company_id = t3a.company_id
                                    and a.company_dept_id = t3a.responsible_dept
                                    and a.pause = 0
                                  where (a.dept_name like '%物流部%'or a.dept_name like '%品类部%'
                             or a.dept_name like '%事业部%' or a.dept_name = '无')) tp
                          group by tp.company_id, tp.supplier_company_name,tp.supplier_code,tp.year,tp.quarter,tp.category,tp.category_name) t2
                 on t2.company_id = t1.company_id
                and t2.supplier_code = t1.supplier_code
                and t2.category = t1.category
                and t2.year = t1.year
                and t2.quarter = t1.quarter]';
      v_w1 := q'[ where (t1.year || t1.quarter) <= (to_char(add_months(sysdate,-3),'yyyy')||to_char(add_months(sysdate,-3),'q'))) tkb ]';
      v_w2 := q'[ where (t1.year || t1.quarter) = (to_char(add_months(sysdate,-3),'yyyy')||to_char(add_months(sysdate,-3),'q'))) tkb ]';
      v_z2 := q'[ on (tka.company_id = tkb.company_id and tka.year = tkb.year and tka.quarter = tkb.quarter 
                       and tka.supplier_code = tkb.supplier_code and tka.category = tkb.category)
      when matched then
         update
            set tka.fillrate_order_money     = tkb.order_money,
                tka.fillrate_sho_order_money = tkb.sho_order_money,
                tka.supplier_name            = tkb.supplier_name,
                tka.update_id                = 'ADMIN',
                tka.update_time              = sysdate
      when not matched then
        insert
          (tka.t_sp_quarter_id,
           tka.company_id,
           tka.year,
           tka.quarter,
           tka.supplier_code,
           tka.supplier_name,
           tka.category,
           tka.category_name,
           tka.fillrate_order_money,
           tka.fillrate_sho_order_money,
           tka.create_id,
           tka.create_time)
        values
          (scmdata.f_get_uuid(),
           tkb.company_id,
           tkb.year,
           tkb.quarter,
           tkb.supplier_code,
           tkb.supplier_name,
           tkb.category,
           tkb.category_name,
           tkb.order_money,
           tkb.sho_order_money,
           'ADMIN',
           sysdate)]';
      if t_type = 0 then
        v_sql := v_z1 || v_w1 || v_z2;
      elsif t_type = 1 then
        v_sql := v_z1 || v_w2 || v_z2;
      end if;
      execute immediate v_sql;
    end;
  
    /*只更新或者新增补货平均交期字段*/
    begin
      v_z1 := q'[  merge into scmdata.t_supplier_performance_quarter tka
      using (select t1.company_id, t1.year, t1.quarter, t1.supplier_name,t1.supplier_code,
       t1.category,t1.category_name, sum(t1.sum1_money) delivery_money,sum(t1.sum1_date*t1.sum1_money) delivery_order_money
              from (select t5.company_id,t5.supplier_company_name supplier_name,tor.supplier_code,
                          to_char(tba.delivery_origin_time,'yyyy')year, to_char(tba.delivery_origin_time,'Q')quarter,t5.category, t5.category_name,
                     (to_date(to_char(tba.delivery_origin_time , 'yyyy/mm/dd'), 'yyyy/mm/dd') -
                     to_date(to_char(t5.order_create_date, 'yyyy/mm/dd'), 'yyyy/mm/dd')) sum1_date,
                     (t5.fixed_price * tba.delivery_amount) sum1_money
                from scmdata.pt_ordered t5
                inner join scmdata.t_delivery_record tba
                  on t5.product_gress_code = tba.order_code
                 and t5.company_id = tba.company_id
                inner join scmdata.t_ordered tor
                   on tor.company_id = tba.company_id
                  and tor.order_code = tba.order_code
                inner join scmdata.t_commodity_info tb
                  on t5.goo_id = tb.rela_goo_id
                 and tb.goo_id = tba.goo_id
                 and t5.company_id = tb.company_id
               where t5.is_first_order = 0
                 and tor.is_product_order = 1)t1 ]';
      v_w1 := q'[ where (t1.year || t1.quarter) <= (to_char(add_months(sysdate,-3),'yyyy')||to_char(add_months(sysdate,-3),'q')) ]';
      v_w2 := q'[ where (t1.year || t1.quarter) = (to_char(add_months(sysdate,-3),'yyyy')||to_char(add_months(sysdate,-3),'q')) ]';
      v_z2 := q'[ group by t1.company_id, t1.year,t1.quarter, t1.supplier_name,t1.supplier_code,t1.category, t1.category_name) tkb
      on (tka.company_id = tkb.company_id and tka.year = tkb.year and tka.quarter = tkb.quarter 
           and tka.supplier_code = tkb.supplier_code and tka.category = tkb.category )
      when matched then
        update
           set tka.average_delivery_money       = tkb.delivery_money,
               tka.average_delivery_order_money = tkb.delivery_order_money,
               tka.supplier_name                = tkb.supplier_name,
               tka.update_id                    = 'ADMIN',
               tka.update_time                  = sysdate
      when not matched then
        insert
          (tka.t_sp_quarter_id,
           tka.company_id,
           tka.year,
           tka.quarter,
           tka.supplier_code,
           tka.supplier_name,
           tka.category,
           tka.category_name,
           tka.average_delivery_money,
           tka.average_delivery_order_money,
           tka.create_id,
           tka.create_time)
        values
          (scmdata.f_get_uuid(),
           tkb.company_id,
           tkb.year,
           tkb.quarter,
           tkb.supplier_code,
           tkb.supplier_name,
           tkb.category,
           tkb.category_name,
           tkb.delivery_money,
           tkb.delivery_order_money,
           'ADMIN',
           sysdate)]';
      if t_type = 0 then
        v_sql := v_z1 || v_w1 || v_z2;
      elsif t_type = 1 then
        v_sql := v_z1 || v_w2 || v_z2;
      end if;
      execute immediate v_sql;
    end;
  
    /*只更新或者新增延期数量、延期金额字段*/
    begin
      v_z1 := q'[ merge into scmdata.t_supplier_performance_quarter tka
      using (select t2.company_id, t2.supplier_code,t2.supplier_company_name supplier_name,t2.year,t2.quarter,
                    t2.category,t2.category_name,sum(t2.delivery_amount) delay_amount,sum(t2.delivery_money) delay_money
               from (select oh.company_id, sp2.supplier_code, sp2.supplier_company_name,pt.category,pt.category_name,
                            to_char(od.delivery_date, 'yyyy') year, to_char(od.delivery_date, 'Q') quarter,
                            tdr.delivery_amount,(pt.fixed_price * tdr.delivery_amount) delivery_money
                       from scmdata.t_ordered oh
                      inner join scmdata.t_orders od
                         on oh.company_id = od.company_id
                        and oh.order_code = od.order_id
                      inner join scmdata.t_production_progress t
                         on t.company_id = od.company_id
                        and t.order_id = od.order_id
                        and t.goo_id = od.goo_id
                      inner join scmdata.t_commodity_info cf
                         on t.company_id = cf.company_id
                        and t.goo_id = cf.goo_id
                      inner join scmdata.t_supplier_info sp2
                         on t.company_id = sp2.company_id
                        and t.supplier_code = sp2.supplier_code
                      inner join scmdata.t_delivery_record tdr
                         on tdr.company_id = oh.company_id
                        and tdr.order_code = oh.order_code
                        and tdr.goo_id = cf.goo_id
                      inner join scmdata.pt_ordered pt
                         on pt.product_gress_code = tdr.order_code
                        and pt.company_id = tdr.company_id
                        and pt.supplier_company_name =
                            sp2.supplier_company_name
                      inner join scmdata.sys_company_dept a
                         on a.company_id = t.company_id
                        and a.company_dept_id =t.responsible_dept
                      where tdr.delivery_date > od.delivery_date
                        and a.dept_name = '供应链管理部' ) t2]';
      v_w1 := q'[ where (t2.year || t2.quarter) <= (to_char(add_months(sysdate,-3),'yyyy')||to_char(add_months(sysdate,-3),'q')) ]';
      v_w2 := q'[ where (t2.year || t2.quarter) = (to_char(add_months(sysdate,-3),'yyyy')||to_char(add_months(sysdate,-3),'q')) ]';
      v_z2 := q'[ group by t2.company_id, t2.supplier_code, t2.supplier_company_name,t2.category,t2.category_name,t2.year, t2.quarter) tkb
      on (tka.company_id = tkb.company_id and tka.year = tkb.year and tka.quarter = tkb.quarter
              and tka.supplier_code = tkb.supplier_code and tka.category = tkb.category)
      when matched then
        update
           set tka.delay_amount  = tkb.delay_amount,
               tka.delay_money   = tkb.delay_money,
               tka.supplier_name = tkb.supplier_name,
               tka.update_id     = 'ADMIN',
               tka.update_time   = sysdate
      when not matched then
        insert
          (tka.t_sp_quarter_id,
           tka.company_id,
           tka.year,
           tka.quarter,
           tka.supplier_code,
           tka.supplier_name,
           tka.category,
           tka.category_name,
           tka.delay_amount,
           tka.delay_money,
           tka.create_id,
           tka.create_time)
        values
          (scmdata.f_get_uuid(),
           tkb.company_id,
           tkb.year,
           tkb.quarter,
           tkb.supplier_code,
           tkb.supplier_name,
           tkb.category,
           tkb.category_name,
           tkb.delay_amount,
           tkb.delay_money,
           'ADMIN',
           sysdate)]';
      if t_type = 0 then
        v_sql := v_z1 || v_w1 || v_z2;
      elsif t_type = 1 then
        v_sql := v_z1 || v_w2 || v_z2;
      end if;
      execute immediate v_sql;
    end;
  
    /*只更新或者新增批版通过率字段*/
    begin
      v_z1 := q'[ merge into scmdata.t_supplier_performance_quarter tka
      using (select t2.company_id, t2.year, t2.quarter,t2.supplier_code, t2.supplier_name,t2.category,gd.group_dict_name category_name, t2.sum_approver,t1.sum_np_approver
               from (select to_char(tav.approve_time, 'yyyy') year,to_char(tav.approve_time, 'Q') quarter, tav.company_id,
                            t.supplier_company_name supplier_name,tav.supplier_code,count(1) sum_approver,tci.category
                       from scmdata.t_approve_version tav
                      inner join scmdata.t_commodity_info tci
                         on tav.company_id = tci.company_id
                        and tav.goo_id = tci.goo_id
                      inner join scmdata.t_supplier_info t
                         on t.supplier_code = tav.supplier_code
                        and t.company_id = tav.company_id 
                      where tav.approve_result <> 'AS00'
                      group by to_char(tav.approve_time, 'yyyy'),to_char(tav.approve_time, 'Q'), 
                                t.supplier_company_name ,tci.category,tav.company_id, tav.supplier_code) t2
               left join (select to_char(t.approve_time, 'yyyy') year, to_char(t.approve_time, 'Q') quarter, t.supplier_code, 
                                 ta.supplier_company_name supplier_name, tci.category,t.company_id, count(1) sum_np_approver
                           from scmdata.t_approve_version t
                          inner join scmdata.t_commodity_info tci
                             on t.company_id = tci.company_id
                            and t.goo_id = tci.goo_id
                          inner join scmdata.t_supplier_info ta
                             on t.supplier_code = ta.supplier_code
                            and t.company_id = ta.company_id 
                          where t.approve_result = 'AS03'
                          group by to_char(t.approve_time, 'yyyy'), to_char(t.approve_time, 'Q'),
                                   ta.supplier_company_name,tci.category,t.supplier_code,t.company_id) t1
                 on t1.year = t2.year
                and t1.quarter = t2.quarter
                and t1.supplier_code = t2.supplier_code
                and t1.company_id = t2.company_id
                and t1.category = t2.category
     inner join scmdata.sys_group_dict gd
        on gd.group_dict_type = 'PRODUCT_TYPE'
       and gd.group_dict_value = t2.category ]';
      v_w1 := q'[ where (t1.year || t1.quarter) <= (to_char(add_months(sysdate,-3),'yyyy')||to_char(add_months(sysdate,-3),'q'))) tkb ]';
      v_w2 := q'[ where (t1.year || t1.quarter) = (to_char(add_months(sysdate,-3),'yyyy')||to_char(add_months(sysdate,-3),'q'))) tkb ]';
      v_z2 := q'[ on (tka.company_id = tkb.company_id and tka.year = tkb.year and tka.quarter = tkb.quarter
                  and tka.supplier_code = tkb.supplier_code and tka.category = tkb.category)
      when matched then
        update
           set tka.batch_amount      = tkb.sum_approver,
               tka.batch_pass_amount = tkb.sum_np_approver,
               tka.supplier_name     = tkb.supplier_name,
               tka.update_id         = 'ADMIN',
               tka.update_time       = sysdate
      when not matched then
        insert
          (tka.t_sp_quarter_id,
           tka.company_id,
           tka.year,
           tka.quarter,
           tka.supplier_code,
           tka.supplier_name,
           tka.category,
           tka.category_name,
           tka.batch_amount,
           tka.batch_pass_amount,
           tka.create_id,
           tka.create_time)
        values
          (scmdata.f_get_uuid(),
           tkb.company_id,
           tkb.year,
           tkb.quarter,
           tkb.supplier_code,
           tkb.supplier_name,
           tkb.category,
           tkb.category_name,
           tkb.sum_approver,
           tkb.sum_np_approver,
           'ADMIN',
           sysdate)]';
      if t_type = 0 then
        v_sql := v_z1 || v_w1 || v_z2;
      elsif t_type = 1 then
        v_sql := v_z1 || v_w2 || v_z2;
      end if;
      execute immediate v_sql;
    end;
  
    /*只更新或者新增面料检测合格率字段*/
    begin
      v_z1 := q'[  merge into scmdata.t_supplier_performance_quarter tka
      using (select m1.company_id, m1.year, m1.quarter, m1.supplier_code, m1.supplier_name,
       m1.category, gd.group_dict_name category_name, m1.check_number, m2.check_np_number
  from (select t.company_id, g.supplier_code,st.supplier_company_name supplier_name, to_char(t.check_date, 'yyyy') year,
               to_char(t.check_date, 'Q') quarter,g.category, count(1) check_number
          from scmdata.t_check_request t
         inner join scmdata.t_commodity_info g
            on g.goo_id = t.goo_id
           and g.company_id = t.company_id
         inner join scmdata.t_supplier_info st
            on st.supplier_code = g.supplier_code
           and st.company_id = t.company_id
         where t.company_id = 'b6cc680ad0f599cde0531164a8c0337f'
         group by t.company_id, to_char(t.check_date, 'yyyy'), to_char(t.check_date, 'Q'),
                  g.category,g.supplier_code, st.supplier_company_name) m1
  left join (select t.company_id, g.category, to_char(t.check_date, 'yyyy') year,to_char(t.check_date, 'Q') quarter,
                    g.supplier_code, si.supplier_company_name supplier_name, count(1) check_np_number
               from scmdata.t_check_request t
              inner join scmdata.t_commodity_info g
                 on g.goo_id = t.goo_id
                and g.company_id = t.company_id
              inner join scmdata.t_supplier_info si
                 on si.supplier_code = g.supplier_code
                and si.company_id = t.company_id
              where t.check_result = 'FABRIC_PASS'
              group by t.company_id, to_char(t.check_date, 'yyyy'), to_char(t.check_date, 'Q'), g.category,g.supplier_code, si.supplier_company_name) m2
    on m2.year = m1.year
   and m2.quarter = m1.quarter
   and m2.category = m1.category
   and m2.company_id = m1.company_id
   and m2.supplier_code = m1.supplier_code
 inner join scmdata.sys_group_dict gd
    on gd.group_dict_type = 'PRODUCT_TYPE'
   and gd.group_dict_value = m1.category ]';
      v_w1 := q'[  where (m1.year || m1.quarter) <= (to_char(add_months(sysdate,-3),'yyyy')||to_char(add_months(sysdate,-3),'q'))) tkb ]';
      v_w2 := q'[  where (m1.year || m1.quarter) = (to_char(add_months(sysdate,-3),'yyyy')||to_char(add_months(sysdate,-3),'q'))) tkb ]';
      v_z2 := q'[ on (tka.company_id = tkb.company_id and tka.year = tkb.year and tka.quarter = tkb.quarter
              and tka.supplier_code = tkb.supplier_code and tka.category = tkb.category)
      when matched then
        update
           set tka.fabric_amount      = tkb.check_number,
               tka.fabric_pass_amount = tkb.check_np_number,
               tka.supplier_name      = tkb.supplier_name,
               tka.update_id          = 'ADMIN',
               tka.update_time        = sysdate
      when not matched then
        insert
          (tka.t_sp_quarter_id,
           tka.company_id,
           tka.year,
           tka.quarter,
           tka.supplier_code,
           tka.supplier_name,
           tka.category,
           tka.category_name,
           tka.fabric_amount,
           tka.fabric_pass_amount,
           tka.create_id,
           tka.create_time)
        values
          (scmdata.f_get_uuid(),
           tkb.company_id,
           tkb.year,
           tkb.quarter,
           tkb.supplier_code,
           tkb.supplier_name,
           tkb.category,
           tkb.category_name,
           tkb.check_number,
           tkb.check_np_number,
           'ADMIN',
           sysdate)]';
      if t_type = 0 then
        v_sql := v_z1 || v_w1 || v_z2;
      elsif t_type = 1 then
        v_sql := v_z1 || v_w2 || v_z2;
      end if;
      execute immediate v_sql;
    end;
  
    /*QC模块*/
    /*只更新或者新增首查字段*/
    begin
      v_z1 := q'[ merge into scmdata.t_supplier_performance_quarter tka
      using (select base.supplier supplier_name, base.company_id, to_char(base.finish_time, 'yyyy') year, to_char(base.finish_time, 'Q') quarter,
                    base.supplier_code,base.category,base.category_name,sum(base.order_money) qc_number,
                    sum(case when base.last_qc_result = 'NORMAL_IS_QUALIFIED' then base.order_money end) qualified_number
               from (select k.order_id,k.company_id, k.supplier,k.supplier_code,k.category,k.category_name, min(k.finish_time) finish_time, k.qc_check_node, k.last_qc_result,k.order_money 
                       from (select o.order_id,o.company_id, si.supplier_company_name supplier, qc.finish_time, g.qc_check_node,pt.order_money ,oe.supplier_code,pt.category,pt.category_name,
                                     first_value(qc.qc_result) over(partition by o.order_id, g.qc_check_node order by nvl(qc.finish_time, timestamp'2000-01-01 00:00:00')) LAST_QC_RESULT
                               from scmdata.t_orders o
                              inner join (select a.group_dict_value qc_check_node from scmdata.sys_group_dict a
                                           where a.group_dict_type = 'QC_CHECK_NODE_DICT' and a.pause = 0) g
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
                                and exists
                              (select 1 from scmdata.t_qc_check_rela_order a where a.orders_id = o.orders_id and a.qc_check_id = qc.qc_check_id)
                              inner join scmdata.t_commodity_info ci
                                 on o.goo_id = ci.goo_id
                                and ci.company_id = o.company_id
                              inner join scmdata.t_supplier_info si
                                 on si.supplier_code = oe.supplier_code
                                and si.company_id = oe.company_id
                              where g.qc_check_node = 'QC_FIRST_CHECK'
                                and qc.finish_time is not null) k
                      group by k.order_id, k.supplier,k.supplier_code,k.category,k.category_name, k.company_id,k.qc_check_node, k.last_qc_result,k.order_money) base ]';
      v_w1 := q'[ where (to_char(base.finish_time, 'yyyy') || to_char(base.finish_time, 'Q')) <=
                          (to_char(add_months(sysdate,-3),'yyyy')||to_char(add_months(sysdate,-3),'q')) ]';
      v_w2 := q'[ where (to_char(base.finish_time, 'yyyy') || to_char(base.finish_time, 'Q')) =
                          (to_char(add_months(sysdate,-3),'yyyy')||to_char(add_months(sysdate,-3),'q')) ]';
      v_z2 := q'[ group by base.supplier,base.supplier_code,base.category,base.category_name,base.company_id, to_char(base.finish_time, 'yyyy'), to_char(base.finish_time, 'Q')) tkb
      on (tka.company_id = tkb.company_id and tka.year = tkb.year and tka.quarter = tkb.quarter 
              and tka.supplier_code = tkb.supplier_code and tka.category = tkb.category)
      when matched then
        update
           set tka.qc_firstcheck_ordermoney      = tkb.qc_number,
               tka.qc_firstcheck_pass_ordermoney = tkb.qualified_number,
               tka.supplier_name                 = tkb.supplier_name,
               tka.update_id                     = 'ADMIN',
               tka.update_time                   = sysdate
      when not matched then
        insert
          (tka.t_sp_quarter_id,
           tka.company_id,
           tka.year,
           tka.quarter,
           tka.supplier_code,
           tka.supplier_name,
           tka.category,
           tka.category_name,
           tka.qc_firstcheck_ordermoney,
           tka.qc_firstcheck_pass_ordermoney,
           tka.create_id,
           tka.create_time)
        values
          (scmdata.f_get_uuid(),
           tkb.company_id,
           tkb.year,
           tkb.quarter,
           tkb.supplier_code,
           tkb.supplier_name,
           tkb.category,
           tkb.category_name,
           tkb.qc_number,
           tkb.qualified_number,
           'ADMIN',
           sysdate)]';
      if t_type = 0 then
        v_sql := v_z1 || v_w1 || v_z2;
      elsif t_type = 1 then
        v_sql := v_z1 || v_w2 || v_z2;
      end if;
      execute immediate v_sql;
    end;
    /*QC模块*/
    /*只更新或者新增中查字段*/
    begin
      v_z1 := q'[  merge into scmdata.t_supplier_performance_quarter tka
      using (select base.supplier supplier_name, base.company_id, to_char(base.finish_time, 'yyyy') year,
                    to_char(base.finish_time, 'Q') quarter,base.supplier_code,base.category,base.category_name,
                    sum(base.order_money) qc_number,
                    sum(case when base.last_qc_result = 'NORMAL_IS_QUALIFIED' then base.order_money end) qualified_number
               from (select k.order_id,k.company_id, k.supplier, k.supplier_code,k.category,k.category_name,min(k.finish_time) finish_time, k.qc_check_node, k.last_qc_result,k.order_money 
                       from (select o.order_id,o.company_id, si.supplier_company_name supplier, qc.finish_time, g.qc_check_node,pt.order_money ,oe.supplier_code,pt.category,pt.category_name,
                                     first_value(qc.qc_result) over(partition by o.order_id, g.qc_check_node order by nvl(qc.finish_time, timestamp'2000-01-01 00:00:00')) LAST_QC_RESULT
                               from scmdata.t_orders o
                              inner join (select a.group_dict_value qc_check_node from scmdata.sys_group_dict a
                                           where a.group_dict_type = 'QC_CHECK_NODE_DICT' and a.pause = 0) g
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
                                and exists
                              (select 1 from scmdata.t_qc_check_rela_order a
                                      where a.orders_id = o.orders_id and a.qc_check_id = qc.qc_check_id)
                              inner join scmdata.t_commodity_info ci
                                 on o.goo_id = ci.goo_id
                                and ci.company_id = o.company_id
                              inner join scmdata.t_supplier_info si
                                 on si.supplier_code = oe.supplier_code
                                and si.company_id = oe.company_id
                              where g.qc_check_node = 'QC_MIDDLE_CHECK'
                                and qc.finish_time is not null) k
                      group by k.order_id, k.supplier,k.supplier_code,k.category,k.category_name, k.company_id, k.qc_check_node, k.last_qc_result,k.order_money) base ]';
      v_w1 := q'[ where (to_char(base.finish_time, 'yyyy') || to_char(base.finish_time, 'Q')) <=
                          (to_char(add_months(sysdate,-3),'yyyy')||to_char(add_months(sysdate,-3),'q')) ]';
      v_w2 := q'[ where (to_char(base.finish_time, 'yyyy') || to_char(base.finish_time, 'Q')) =
                          (to_char(add_months(sysdate,-3),'yyyy')||to_char(add_months(sysdate,-3),'q')) ]';
      v_z2 := q'[ group by base.supplier, base.supplier_code,base.category,base.category_name, base.company_id, to_char(base.finish_time, 'yyyy'), to_char(base.finish_time, 'Q')) tkb
      on (tka.company_id = tkb.company_id and tka.year = tkb.year and tka.quarter = tkb.quarter 
              and tka.supplier_code = tkb.supplier_code and tka.category = tkb.category)
      when matched then
        update
           set tka.qc_middlecheck_ordermoney      = tkb.qc_number,
               tka.qc_middlecheck_pass_ordermoney = tkb.qualified_number,
               tka.supplier_name                  = tkb.supplier_name,
               tka.update_id                      = 'ADMIN',
               tka.update_time                    = sysdate
      when not matched then
        insert
          (tka.t_sp_quarter_id,
           tka.company_id,
           tka.year,
           tka.quarter,
           tka.supplier_code,
           tka.supplier_name,
           tka.category,
           tka.category_name,
           tka.qc_middlecheck_ordermoney,
           tka.qc_middlecheck_pass_ordermoney,
           tka.create_id,
           tka.create_time)
        values
          (scmdata.f_get_uuid(),
           tkb.company_id,
           tkb.year,
           tkb.quarter,
           tkb.supplier_code,
           tkb.supplier_name,
           tkb.category,
           tkb.category_name,
           tkb.qc_number,
           tkb.qualified_number,
           'ADMIN',
           sysdate)]';
      if t_type = 0 then
        v_sql := v_z1 || v_w1 || v_z2;
      elsif t_type = 1 then
        v_sql := v_z1 || v_w2 || v_z2;
      end if;
      execute immediate v_sql;
    end;
    /*QC模块*/
    /*只更新或者新增尾查字段*/
    begin
      v_z1 := q'[ merge into scmdata.t_supplier_performance_quarter tka
      using (select base.supplier supplier_name, base.company_id, to_char(base.finish_time, 'yyyy') year,
                    to_char(base.finish_time, 'Q') quarter, base.supplier_code,base.category,base.category_name,
                    sum(base.order_money) qc_number,
                    sum(case when base.last_qc_result = 'NORMAL_IS_QUALIFIED' then base.order_money end) qualified_number
               from (select k.order_id,k.company_id, k.supplier, k.supplier_code,k.category,k.category_name,min(k.finish_time) finish_time, k.qc_check_node, k.last_qc_result,k.order_money 
                       from (select o.order_id,o.company_id, si.supplier_company_name supplier, qc.finish_time, g.qc_check_node,pt.order_money ,oe.supplier_code,pt.category,pt.category_name,
                                     first_value(qc.qc_result) over(partition by o.order_id, g.qc_check_node order by nvl(qc.finish_time, timestamp'2000-01-01 00:00:00')) LAST_QC_RESULT
                               from scmdata.t_orders o
                              inner join (select a.group_dict_value qc_check_node from scmdata.sys_group_dict a
                                           where a.group_dict_type = 'QC_CHECK_NODE_DICT' and a.pause = 0) g
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
                                and exists
                              (select 1 from scmdata.t_qc_check_rela_order a
                                      where a.orders_id = o.orders_id and a.qc_check_id = qc.qc_check_id)
                              inner join scmdata.t_commodity_info ci
                                 on o.goo_id = ci.goo_id
                                and ci.company_id = o.company_id
                              inner join scmdata.t_supplier_info si
                                 on si.supplier_code = oe.supplier_code
                                and si.company_id = oe.company_id
                              where g.qc_check_node = 'QC_FINAL_CHECK'
                                and qc.finish_time is not null) k
                      group by k.order_id, k.supplier,k.supplier_code,k.category,k.category_name, k.company_id, k.qc_check_node, k.last_qc_result,k.order_money) base ]';
      v_w1 := q'[ where (to_char(base.finish_time, 'yyyy') || to_char(base.finish_time, 'Q')) <=
                          (to_char(add_months(sysdate,-3),'yyyy')||to_char(add_months(sysdate,-3),'q')) ]';
      v_w2 := q'[ where (to_char(base.finish_time, 'yyyy') || to_char(base.finish_time, 'Q')) =
                          (to_char(add_months(sysdate,-3),'yyyy')||to_char(add_months(sysdate,-3),'q')) ]';
      v_z2 := q'[ group by base.supplier,base.supplier_code,base.category,base.category_name, base.company_id, to_char(base.finish_time, 'yyyy'), to_char(base.finish_time, 'Q')) tkb
      on (tka.company_id = tkb.company_id and tka.year = tkb.year and tka.quarter = tkb.quarter 
              and tka.supplier_code = tkb.supplier_code and tka.category = tkb.category)
      when matched then
        update
           set tka.qc_finalcheck_ordermoney      = tkb.qc_number,
               tka.qc_finalcheck_pass_ordermoney = tkb.qualified_number,
               tka.supplier_name                 = tkb.supplier_name,
               tka.update_id                     = 'ADMIN',
               tka.update_time                   = sysdate
      when not matched then
        insert
          (tka.t_sp_quarter_id,
           tka.company_id,
           tka.year,
           tka.quarter,
           tka.supplier_code,
           tka.supplier_name,
           tka.category,
           tka.category_name,
           tka.qc_finalcheck_ordermoney,
           tka.qc_finalcheck_pass_ordermoney,
           tka.create_id,
           tka.create_time)
        values
          (scmdata.f_get_uuid(),
           tkb.company_id,
           tkb.year,
           tkb.quarter,
           tkb.supplier_code,
           tkb.supplier_name,
           tkb.category,
           tkb.category_name,
           tkb.qc_number,
           tkb.qualified_number,
           'ADMIN',
           sysdate)]';
      if t_type = 0 then
        v_sql := v_z1 || v_w1 || v_z2;
      elsif t_type = 1 then
        v_sql := v_z1 || v_w2 || v_z2;
      end if;
      execute immediate v_sql;
    end;
    /*只更新或者新增QA查货字段*/
    begin
      v_z1 := q'[ merge into scmdata.t_supplier_performance_quarter tka
      using (select k.company_id, k.year,k.quarter,k.qasupplier supplier_name,k.supplier_code,k.category,k.category_name,
           sum(k.pcomesum_amount) pcomesum_amount, sum(k2.pcomesum_amount) np_amount
               from (select distinct to_char(a.check_date, 'yyyy') year, to_char(a.check_date, 'Q') quarter, a.qa_report_id, a.pcomesum_amount,a.company_id,
                                     td.supplier_code,t.supplier_company_name qasupplier,tc.category,gd.group_dict_name category_name
                       from scmdata.t_qa_report a
                      inner join scmdata.t_qa_scope z
                         on a.qa_report_id = z.qa_report_id
                        and a.company_id = z.company_id
                      inner join scmdata.t_ordered td
                         on td.company_id = z.company_id
                        and td.order_code = z.order_id
                      inner join scmdata.t_commodity_info tc
                         on tc.company_id = z.company_id
                        and tc.goo_id = z.goo_id
                      inner join scmdata.sys_group_dict gd
                         on gd.group_dict_type = 'PRODUCT_TYPE'
                        and gd.group_dict_value = tc.category
                      inner join scmdata.t_supplier_info t
                         on t.company_id = z.company_id
                        and t.supplier_code = td.supplier_code
                      where a.status in ('N_ACF', 'R_ACF')) k
               left join (select distinct to_char(a.check_date, 'yyyy') year, to_char(a.check_date, 'Q')quarter, a.qa_report_id,
                                         a.pcomesum_amount, a.check_result, a.company_id,
                                         td.supplier_code,t.supplier_company_name qasupplier,tc.category,gd.group_dict_name category_name
                           from scmdata.t_qa_report a
                          inner join scmdata.t_qa_scope z
                             on a.qa_report_id = z.qa_report_id
                            and a.company_id = z.company_id
                          inner join scmdata.t_ordered td
                             on td.company_id = z.company_id
                            and td.order_code = z.order_id
                          inner join scmdata.t_commodity_info tc
                             on tc.company_id = z.company_id
                            and tc.goo_id = z.goo_id
                          inner join scmdata.sys_group_dict gd
                             on gd.group_dict_type = 'PRODUCT_TYPE'
                            and gd.group_dict_value = tc.category
                          inner join scmdata.t_supplier_info t
                             on t.company_id = z.company_id
                            and t.supplier_code = td.supplier_code
                          where a.status in ('N_ACF', 'R_ACF')
                            and a.check_result = 'QU') k2
                 on k2.qa_report_id = k.qa_report_id
                and k2.year = k.year
                and k2.quarter = k.quarter
                and k2.company_id = k.company_id
                and k2.supplier_code = k.supplier_code
                and k2.category = k.category  ]';
      v_w1 := q'[ where (k.year || k.quarter) <= (to_char(add_months(sysdate,-3),'yyyy')||to_char(add_months(sysdate,-3),'q')) ]';
      v_w2 := q'[ where (k.year || k.quarter) = (to_char(add_months(sysdate,-3),'yyyy')||to_char(add_months(sysdate,-3),'q')) ]';
      v_z2 := q'[ group by k.year, k.quarter, k.company_id, k.supplier_code,k.category,k.category_name,k.qasupplier  ) tkb
      on (tka.company_id = tkb.company_id and tka.year = tkb.year and tka.quarter = tkb.quarter 
              and tka.supplier_code = tkb.supplier_code and tka.category = tkb.category)
      when matched then
        update
           set tka.qa_check_amount      = tkb.pcomesum_amount,
               tka.qa_check_pass_amount = tkb.np_amount,
               tka.supplier_name        = tkb.supplier_name,
               tka.update_id            = 'ADMIN',
               tka.update_time          = sysdate
      when not matched then
        insert
          (tka.t_sp_quarter_id,
           tka.company_id,
           tka.year,
           tka.quarter,
           tka.supplier_code,
           tka.supplier_name,
           tka.category,
           tka.category_name,
           tka.qa_check_amount,
           tka.qa_check_pass_amount,
           tka.create_id,
           tka.create_time)
        values
          (scmdata.f_get_uuid(),
           tkb.company_id,
           tkb.year,
           tkb.quarter,
           tkb.supplier_code,
           tkb.supplier_name,
           tkb.category,
           tkb.category_name,
           tkb.pcomesum_amount,
           tkb.np_amount,
           'ADMIN',
           sysdate)]';
      if t_type = 0 then
        v_sql := v_z1 || v_w1 || v_z2;
      elsif t_type = 1 then
        v_sql := v_z1 || v_w2 || v_z2;
      end if;
      execute immediate v_sql;
    end;
    /*只更新或者新增异常金额、异常数量字段*/
    begin
      v_z1 := q'[ merge into scmdata.t_supplier_performance_quarter tka
      using ( select k.year,k.quarter,k.supplier_name,k.supplier_code,k.company_id,k.category,k.category_name,
       sum(k.delay_amount)quality_deviant_amount ,sum(k.delay_amount*k.price)quality_deviant_money 
  from (select to_char(a.confirm_date, 'yyyy') year,
               to_char(a.confirm_date, 'Q')quarter ,
               a.company_id,
               a.delay_amount, --延期数量
               cf.price,
               oh.supplier_code,
               sp2.supplier_company_name supplier_name,
               cf.category,
               gd_d.group_dict_name category_name
          from scmdata.t_ordered oh
         inner join scmdata.t_orders od
            on oh.company_id = od.company_id
           and oh.order_code = od.order_id
           and oh.order_status in ('OS01', 'OS02')
         inner join t_production_progress t
            on t.company_id = od.company_id
           and t.order_id = od.order_id
           and t.goo_id = od.goo_id
         inner join scmdata.t_commodity_info cf
            on t.company_id = cf.company_id
           and t.goo_id = cf.goo_id
         inner join scmdata.t_supplier_info sp2
            on oh.company_id = sp2.company_id
           and oh.supplier_code = sp2.supplier_code
         inner join scmdata.t_abnormal a
            on t.company_id = a.company_id
           and t.order_id = a.order_id
           and t.goo_id = a.goo_id
           and a.progress_status = '02'
           and a.origin <> 'SC'
         inner join scmdata.sys_company_user sb
            on a.company_id = sb.company_id
           and a.confirm_id = sb.user_id
         inner join scmdata.sys_group_dict gd_d
            on gd_d.group_dict_type = 'PRODUCT_TYPE'
           and gd_d.group_dict_value = cf.category
         where oh.company_id = 'a972dd1ffe3b3a10e0533c281cac8fd7'
           and a.anomaly_class = 'AC_QUALITY')k ]';
      v_w1 := q'[ where (k.year || k.quarter) <= 
                    (to_char(add_months(sysdate,-3),'yyyy')||to_char(add_months(sysdate,-3),'q')) ]';
      v_w2 := q'[ where (k.year || k.quarter) = 
                    (to_char(add_months(sysdate,-3),'yyyy')||to_char(add_months(sysdate,-3),'q')) ]';
      v_z2 := q'[  group by k.year,k.quarter,k.supplier_name,k.supplier_code,k.company_id, k.category,k.category_name) tkb
      on (tka.company_id = tkb.company_id and tka.year = tkb.year and tka.quarter = tkb.quarter 
              and tka.supplier_code = tkb.supplier_code and tka.category = tkb.category)
      when matched then
        update
           set tka.quality_deviant_amount = tkb.quality_deviant_amount,
               tka.quality_deviant_money  = tkb.quality_deviant_money,
               tka.supplier_name          = tkb.supplier_name,
               tka.update_id              = 'ADMIN',
               tka.update_time            = sysdate
      when not matched then
        insert
          (tka.t_sp_quarter_id,
           tka.company_id,
           tka.year,
           tka.quarter,
           tka.supplier_code,
           tka.supplier_name,
           tka.category,
           tka.category_name,
           tka.quality_deviant_amount,
           tka.quality_deviant_money,
           tka.create_id,
           tka.create_time)
        values
          (scmdata.f_get_uuid(),
           tkb.company_id,
           tkb.year,
           tkb.quarter,
           tkb.supplier_code,
           tkb.supplier_name,
           tkb.category,
           tkb.category_name,
           tkb.quality_deviant_amount,
           tkb.quality_deviant_money,
           'ADMIN',
           sysdate)]';
      if t_type = 0 then
        v_sql := v_z1 || v_w1 || v_z2;
      elsif t_type = 1 then
        v_sql := v_z1 || v_w2 || v_z2;
      end if;
      execute immediate v_sql;
    end;

  end p_supplier_performance_quarter;

  /*--------------------------------------------------------------------  
     生成供应商绩效盘点报表数据表
         用途：
            供应商绩效盘点表（供应商维度）——按半年度更新数据表
         用于：
            供应商绩效盘点报表——供应商tab页      
         更新规则：
             使用oracle数据库定时任务实现——每个半年度更新上个半年度的数据
          入参（t_type 只能传入 0 或者 1 ）：
              t_type := 0 更新全部历史数据
              t_type := 1 只更新上一个半年度的数据                
        版本:
            2022-03-24 
     2022-04-08 因数据有问题，修改订单满足率、前20%订单满足率分子的取数全部来源于底层订单交期表
     2022-04-11 因底层订单交期表更改了责任部门，订单满足率、前20%订单满足率分子的责任部门全部修改
     2022-05-19 因需求变更，（1）统计维度由供应商修改为供应商+分类，
                            （2）修改了订单满足率、补货平均交期、延货金额、延货数量取值范围，
                            （3）新增异常金额、异常数量
  -----------------------------------------------------------------------*/
  procedure p_supplier_performance_halfyear(t_type number) is
    v_sql clob;
    v_z1  clob;
    v_z2  clob;
    v_w1  clob;
    v_w2  clob;
    /*只更新或者新增下单数量、下单金额*/
  begin
    v_z1 := q'[ merge into scmdata.t_supplier_performance_halfyear tka
    using (select pt.company_id,to_char(pt.order_create_date, 'yyyy') year,decode(to_char(pt.order_create_date, 'Q'),1,1,2,1,3,2,4,2) halfyear, 
                  pt.supplier_company_name supplier_name,pt.category,pt.category_name,t.supplier_code,
               sum(pt.order_amount) order_amount,sum(pt.order_money) order_money
          from scmdata.pt_ordered pt 
          inner join scmdata.t_supplier_info t
            on t.company_id = pt.company_id
           and t.inside_supplier_code = pt.supplier_code]';
    /*更新全部历史数据*/
    v_w1 := q'[ where (to_char(pt.order_create_date, 'yyyy') || decode(to_char(pt.order_create_date, 'Q'),1,1,2,1,3,2,4,2)) <= pkg_kpipt_order.f_yearmonth ]';
    /*只更新上一个半年度的数据*/
    v_w2 := q'[ where (to_char(pt.order_create_date, 'yyyy') || decode(to_char(pt.order_create_date, 'Q'),1,1,2,1,3,2,4,2)) = pkg_kpipt_order.f_yearmonth ]';
    v_z2 := q'[ group by pt.company_id, to_char(pt.order_create_date, 'yyyy'), decode(to_char(pt.order_create_date, 'Q'),1,1,2,1,3,2,4,2), 
                          pt.category,pt.category_name,t.supplier_code,pt.supplier_company_name) tkb
    on (tka.company_id = tkb.company_id and tka.year = tkb.year and tka.halfyear = tkb.halfyear 
         and tka.supplier_code = tkb.supplier_code and tka.category = tkb.category)
    when matched then
      update
         set tka.order_amount  = tkb.order_amount,
             tka.order_money   = tkb.order_money,
             tka.supplier_name = tkb.supplier_name,
             tka.update_id     = 'ADMIN',
             tka.update_time   = sysdate
    when not matched then
      insert
        (tka.t_sp_halfyear_id,
         tka.company_id,
         tka.year,
         tka.halfyear,
         tka.supplier_code,
         tka.supplier_name,
         tka.category,
         tka.category_name,
         tka.order_amount,
         tka.order_money,
         tka.create_id,
         tka.create_time)
      values
        (scmdata.f_get_uuid(),
         tkb.company_id,
         tkb.year,
         tkb.halfyear,
         tkb.supplier_code,
         tkb.supplier_name,
         tkb.category,
         tkb.category_name,
         tkb.order_amount,
         tkb.order_money,
         'ADMIN',
         sysdate)]';
    if t_type = 0 then
      v_sql := v_z1 || v_w1 || v_z2;
    elsif t_type = 1 then
      v_sql := v_z1 || v_w2 || v_z2;
    end if;
    execute immediate v_sql;
  
    /*只更新或者新增交货数量、交货金额*/
    begin
      v_z1 := q'[  merge into scmdata.t_supplier_performance_halfyear tka1
      using (select k.company_id,k.supplier_code, k.supplier_name, k.year,decode(k.quarter,1,1,2,1,3,2,4,2) halfyear,
                    k.category,k.category_name,sum(delivery_amount) delivery_amount, sum(k.delivery_money) delivery_money
               from (select oh.company_id, sp2.supplier_code,sp2.supplier_company_name supplier_name,pt.category,pt.category_name,
                            to_char(tdr.delivery_date, 'yyyy') year, to_char(tdr.delivery_date, 'Q') quarter,
                            tdr.delivery_amount,(pt.fixed_price * tdr.delivery_amount) delivery_money
                       from scmdata.t_ordered oh
                      inner join scmdata.t_orders od
                         on oh.company_id = od.company_id
                        and oh.order_code = od.order_id
                      inner join scmdata.t_production_progress t
                         on t.company_id = od.company_id
                        and t.order_id = od.order_id
                        and t.goo_id = od.goo_id
                      inner join scmdata.t_commodity_info cf
                         on t.company_id = cf.company_id
                        and t.goo_id = cf.goo_id
                      inner join scmdata.t_supplier_info sp2
                         on t.company_id = sp2.company_id
                        and t.supplier_code = sp2.supplier_code
                      inner join scmdata.t_delivery_record tdr
                         on tdr.company_id = oh.company_id
                        and tdr.order_code = oh.order_code
                        and tdr.goo_id = cf.goo_id
                      inner join scmdata.pt_ordered pt
                         on pt.product_gress_code = tdr.order_code
                        and pt.company_id = tdr.company_id
                        and pt.supplier_company_name =sp2.supplier_company_name) k ]';
      v_w1 := q'[  where (k.year || decode(k.quarter,1,1,2,1,3,2,4,2)) <= pkg_kpipt_order.f_yearmonth ]';
      v_w2 := q'[  where (k.year || decode(k.quarter,1,1,2,1,3,2,4,2)) = pkg_kpipt_order.f_yearmonth ]';
      v_z2 := q'[  group by k.company_id, k.supplier_code, k.supplier_name,k.category,k.category_name, k.year, decode(k.quarter,1,1,2,1,3,2,4,2)) tkb1
      on (tka1.company_id = tkb1.company_id and tka1.year = tkb1.year and tka1.halfyear = tkb1.halfyear 
           and tka1.supplier_code = tkb1.supplier_code and tka1.category = tkb1.category)
      when matched then
        update
           set tka1.delivery_amount = tkb1.delivery_amount,
               tka1.delivery_money  = tkb1.delivery_money,
               tka1.supplier_name   = tkb1.supplier_name,
               tka1.update_id       = 'ADMIN',
               tka1.update_time     = sysdate
      when not matched then
        insert
          (tka1.t_sp_halfyear_id,
           tka1.company_id,
           tka1.year,
           tka1.halfyear,
           tka1.supplier_code,
           tka1.supplier_name,
           tka1.category,
           tka1.category_name,
           tka1.delivery_amount,
           tka1.delivery_money,
           tka1.create_id,
           tka1.create_time)
        values
          (scmdata.f_get_uuid(),
           tkb1.company_id,
           tkb1.year,
           tkb1.halfyear,
           tkb1.supplier_code,
           tkb1.supplier_name,
           tkb1.category,
           tkb1.category_name,
           tkb1.delivery_amount,
           tkb1.delivery_money,
           'ADMIN',
           sysdate)]';
      if t_type = 0 then
        v_sql := v_z1 || v_w1 || v_z2;
      elsif t_type = 1 then
        v_sql := v_z1 || v_w2 || v_z2;
      end if;
      execute immediate v_sql;
    end;
    /*只更新或者新增订单满足率*/
    begin
      v_z1 := q'[   merge into scmdata.t_supplier_performance_halfyear tka
      using ( select t1.company_id,t1.supplier_company_name supplier_name,t1.supplier_code,t1.category,t1.category_name,
            t1.year,t1.halfyear, t1.order_money,t2.sho_order_money
               from (select pt.company_id, pt.supplier_company_name,t.supplier_code,pt.category,
                            pt.category_name, pt.year,decode(pt.quarter,1,1,2,1,3,2,4,2) halfyear,sum(pt.order_money) order_money
                       from scmdata.pt_ordered pt
                      inner join scmdata.t_supplier_info t
                         on t.company_id = pt.company_id
                        and t.inside_supplier_code = pt.supplier_code 
                      group by pt.company_id, pt.supplier_company_name, pt.year, decode(pt.quarter,1,1,2,1,3,2,4,2) ,t.supplier_code,pt.category,pt.category_name) t1
               left join (select tp.company_id, tp.supplier_company_name,tp.supplier_code,tp.category,tp.category_name,
                                 tp.year,tp.halfyear, sum(tp.sum_money) sho_order_money
                           from (select t3.company_id,t3.supplier_company_name,t.supplier_code,t3.category,t3.category_name,t3.year,
                                        decode(t3.quarter,1,1,2,1,3,2,4,2) halfyear,t3.satisfy_money sum_money
                                   from scmdata.pt_ordered t3
                                  inner join scmdata.t_supplier_info t
                                     on t.company_id = t3.company_id
                                    and t.inside_supplier_code = t3.supplier_code 
                                   union all
                                 select t3a.company_id, t3a.supplier_company_name,t.supplier_code, t3a.category,
                                        t3a.category_name,t3a.year,decode(t3a.quarter,1,1,2,1,3,2,4,2) halfyear,
                                        (t3a.order_money  - t3a.satisfy_money ) sum_money
                                   from scmdata.pt_ordered t3a
                                  inner join scmdata.t_supplier_info t
                                     on t.company_id = t3a.company_id
                                    and t.inside_supplier_code = t3a.supplier_code 
                                  inner join scmdata.sys_company_dept a
                                     on a.company_id = t3a.company_id
                                    and a.company_dept_id = t3a.responsible_dept
                                    and a.pause = 0
                                  where (a.dept_name like '%物流部%'or a.dept_name like '%品类部%'
                             or a.dept_name like '%事业部%' or a.dept_name = '无')) tp
                          group by tp.company_id, tp.supplier_company_name,tp.supplier_code,tp.year,tp.halfyear,tp.category,tp.category_name) t2
                 on t2.company_id = t1.company_id
                and t2.supplier_code = t1.supplier_code
                and t2.category = t1.category
                and t2.year = t1.year
                and t2.halfyear = t1.halfyear ]';
      v_w1 := q'[ where (t1.year || t1.halfyear) <= pkg_kpipt_order.f_yearmonth ) tkb ]';
      v_w2 := q'[ where (t1.year || t1.halfyear) = pkg_kpipt_order.f_yearmonth ) tkb ]';
      v_z2 := q'[  on (tka.company_id = tkb.company_id and tka.year = tkb.year and tka.halfyear = tkb.halfyear 
                       and tka.supplier_code = tkb.supplier_code and tka.category = tkb.category)
      when matched then
        update
           set tka.fillrate_order_money     = tkb.order_money,
               tka.fillrate_sho_order_money = tkb.sho_order_money,
               tka.supplier_name            = tkb.supplier_name,
               tka.update_id                = 'ADMIN',
               tka.update_time              = sysdate
      when not matched then
        insert
          (tka.t_sp_halfyear_id,
           tka.company_id,
           tka.year,
           tka.halfyear,
           tka.supplier_code,
           tka.supplier_name,
           tka.category,
           tka.category_name,
           tka.fillrate_order_money,
           tka.fillrate_sho_order_money,
           tka.create_id,
           tka.create_time)
        values
          (scmdata.f_get_uuid(),
           tkb.company_id,
           tkb.year,
           tkb.halfyear,
           tkb.supplier_code,
           tkb.supplier_name,
           tkb.category,
           tkb.category_name,
           tkb.order_money,
           tkb.sho_order_money,
           'ADMIN',
           sysdate)]';
      if t_type = 0 then
        v_sql := v_z1 || v_w1 || v_z2;
      elsif t_type = 1 then
        v_sql := v_z1 || v_w2 || v_z2;
      end if;
      execute immediate v_sql;
    end;
  
    /*只更新或者新增补货平均交期*/
    begin
      v_z1 := q'[  merge into scmdata.t_supplier_performance_halfyear tka
      using (select t1.company_id, t1.year,t1.halfyear, t1.supplier_name,t1.supplier_code,
       t1.category,t1.category_name, sum(t1.sum1_money) delivery_money,sum(t1.sum1_date*t1.sum1_money) delivery_order_money
              from (select t5.company_id,t5.supplier_company_name supplier_name,tor.supplier_code,
                           to_char(tba.delivery_origin_time,'yyyy')year, 
                           decode(to_char(tba.delivery_origin_time,'Q'),1,1,2,1,3,2,4,2) halfyear,t5.category, t5.category_name,
                     (to_date(to_char(tba.delivery_origin_time , 'yyyy/mm/dd'), 'yyyy/mm/dd') -
                     to_date(to_char(t5.order_create_date, 'yyyy/mm/dd'), 'yyyy/mm/dd')) sum1_date,
                     (t5.fixed_price * tba.delivery_amount) sum1_money
                from scmdata.pt_ordered t5
                inner join scmdata.t_delivery_record tba
                  on t5.product_gress_code = tba.order_code
                 and t5.company_id = tba.company_id
                inner join scmdata.t_ordered tor
                   on tor.company_id = tba.company_id
                  and tor.order_code = tba.order_code
                inner join scmdata.t_commodity_info tb
                  on t5.goo_id = tb.rela_goo_id
                 and tb.goo_id = tba.goo_id
                 and t5.company_id = tb.company_id
               where t5.is_first_order = 0
                 and tor.is_product_order = 1)t1 ]';
      v_w1 := q'[  where (t1.year || t1.halfyear) <= pkg_kpipt_order.f_yearmonth ]';
      v_w2 := q'[  where (t1.year || t1.halfyear) = pkg_kpipt_order.f_yearmonth ]';
      v_z2 := q'[  group by t1.company_id, t1.year,t1.halfyear, 
                         t1.supplier_name,t1.supplier_code,t1.category, t1.category_name) tkb
      on (tka.company_id = tkb.company_id and tka.year = tkb.year and tka.halfyear = tkb.halfyear 
              and tka.supplier_code = tkb.supplier_code and tka.category = tkb.category)
      when matched then
        update
           set tka.average_delivery_money       = tkb.delivery_money,
               tka.average_delivery_order_money = tkb.delivery_order_money,
               tka.supplier_name                = tkb.supplier_name,
               tka.update_id                    = 'ADMIN',
               tka.update_time                  = sysdate
      when not matched then
        insert
          (tka.t_sp_halfyear_id,
           tka.company_id,
           tka.year,
           tka.halfyear,
           tka.supplier_code,
           tka.supplier_name,
           tka.category,
           tka.category_name,
           tka.average_delivery_money,
           tka.average_delivery_order_money,
           tka.create_id,
           tka.create_time)
        values
          (scmdata.f_get_uuid(),
           tkb.company_id,
           tkb.year,
           tkb.halfyear,
           tkb.supplier_code,
           tkb.supplier_name,
           tkb.category,
           tkb.category_name,
           tkb.delivery_money,
           tkb.delivery_order_money,
           'ADMIN',
           sysdate)]';
      if t_type = 0 then
        v_sql := v_z1 || v_w1 || v_z2;
      elsif t_type = 1 then
        v_sql := v_z1 || v_w2 || v_z2;
      end if;
      execute immediate v_sql;
    end;
  
    /*只更新或者新增延期数量、延期金额*/
    begin
      v_z1 := q'[   merge into scmdata.t_supplier_performance_halfyear tka
      using (select t2.company_id, t2.supplier_code,t2.supplier_company_name supplier_name,t2.year,decode(t2.quarter,1,1,2,1,3,2,4,2)halfyear,
                    t2.category,t2.category_name,sum(t2.delivery_amount) delay_amount,sum(t2.delivery_money) delay_money
               from (select oh.company_id, sp2.supplier_code, sp2.supplier_company_name,pt.category,pt.category_name,
                            to_char(od.delivery_date, 'yyyy') year, to_char(od.delivery_date, 'Q') quarter,
                            tdr.delivery_amount,(pt.fixed_price * tdr.delivery_amount) delivery_money
                       from scmdata.t_ordered oh
                      inner join scmdata.t_orders od
                         on oh.company_id = od.company_id
                        and oh.order_code = od.order_id
                      inner join scmdata.t_production_progress t
                         on t.company_id = od.company_id
                        and t.order_id = od.order_id
                        and t.goo_id = od.goo_id
                      inner join scmdata.t_commodity_info cf
                         on t.company_id = cf.company_id
                        and t.goo_id = cf.goo_id
                      inner join scmdata.t_supplier_info sp2
                         on t.company_id = sp2.company_id
                        and t.supplier_code = sp2.supplier_code
                      inner join scmdata.t_delivery_record tdr
                         on tdr.company_id = oh.company_id
                        and tdr.order_code = oh.order_code
                        and tdr.goo_id = cf.goo_id
                      inner join scmdata.pt_ordered pt
                         on pt.product_gress_code = tdr.order_code
                        and pt.company_id = tdr.company_id
                        and pt.supplier_company_name = sp2.supplier_company_name
                      inner join scmdata.sys_company_dept a
                         on a.company_id = t.company_id
                        and a.company_dept_id =t.responsible_dept
                      where tdr.delivery_date > od.delivery_date
                        and a.dept_name = '供应链管理部') t2]';
      v_w1 := q'[   where (t2.year || decode(t2.quarter,1,1,2,1,3,2,4,2)) <= pkg_kpipt_order.f_yearmonth ]';
      v_w2 := q'[   where (t2.year || decode(t2.quarter,1,1,2,1,3,2,4,2)) = pkg_kpipt_order.f_yearmonth ]';
      v_z2 := q'[   group by t2.company_id, t2.supplier_code, t2.supplier_company_name,t2.category,t2.category_name,
                             t2.year, decode(t2.quarter,1,1,2,1,3,2,4,2)) tkb
      on (tka.company_id = tkb.company_id and tka.year = tkb.year and tka.halfyear = tkb.halfyear 
              and tka.supplier_code = tkb.supplier_code and tka.category = tkb.category)
      when matched then
        update
           set tka.delay_amount  = tkb.delay_amount,
               tka.delay_money   = tkb.delay_money,
               tka.supplier_name = tkb.supplier_name,
               tka.update_id     = 'ADMIN',
               tka.update_time   = sysdate
      when not matched then
        insert
          (tka.t_sp_halfyear_id,
           tka.company_id,
           tka.year,
           tka.halfyear,
           tka.supplier_code,
           tka.supplier_name,
           tka.category,
           tka.category_name,
           tka.delay_amount,
           tka.delay_money,
           tka.create_id,
           tka.create_time)
        values
          (scmdata.f_get_uuid(),
           tkb.company_id,
           tkb.year,
           tkb.halfyear,
           tkb.supplier_code,
           tkb.supplier_name,
           tkb.category,
           tkb.category_name,
           tkb.delay_amount,
           tkb.delay_money,
           'ADMIN',
           sysdate)]';
      if t_type = 0 then
        v_sql := v_z1 || v_w1 || v_z2;
      elsif t_type = 1 then
        v_sql := v_z1 || v_w2 || v_z2;
      end if;
      execute immediate v_sql;
    end;
  
    /*只更新或者新增批版通过率*/
    begin
      v_z1 := q'[    merge into scmdata.t_supplier_performance_halfyear tka
      using (select t2.company_id, t2.year, t2.halfyear,t2.supplier_code, t2.supplier_name,t2.category,gd.group_dict_name category_name, t2.sum_approver,t1.sum_np_approver
               from (select to_char(tav.approve_time, 'yyyy') year, decode(to_char(tav.approve_time, 'Q') ,1,1,2,1,3,2,4,2) halfyear, 
                            tav.company_id,t.supplier_company_name supplier_name,tav.supplier_code,count(1) sum_approver,tci.category
                       from scmdata.t_approve_version tav
                      inner join scmdata.t_commodity_info tci
                         on tav.company_id = tci.company_id
                        and tav.goo_id = tci.goo_id
                      inner join scmdata.t_supplier_info t
                         on t.supplier_code = tav.supplier_code
                        and t.company_id = tav.company_id 
                      where tav.approve_result <> 'AS00'
                      group by to_char(tav.approve_time, 'yyyy'),decode(to_char(tav.approve_time, 'Q') ,1,1,2,1,3,2,4,2), 
                                t.supplier_company_name ,tci.category,tav.company_id, tav.supplier_code) t2
               left join (select to_char(t.approve_time, 'yyyy') year, decode(to_char(t.approve_time, 'Q') ,1,1,2,1,3,2,4,2) halfyear,
                                 t.supplier_code, ta.supplier_company_name supplier_name, tci.category,t.company_id, count(1) sum_np_approver
                           from scmdata.t_approve_version t
                          inner join scmdata.t_commodity_info tci
                             on t.company_id = tci.company_id
                            and t.goo_id = tci.goo_id
                          inner join scmdata.t_supplier_info ta
                             on t.supplier_code = ta.supplier_code
                            and t.company_id = ta.company_id 
                          where t.approve_result = 'AS03'
                          group by to_char(t.approve_time, 'yyyy'), decode(to_char(t.approve_time, 'Q') ,1,1,2,1,3,2,4,2),
                                   ta.supplier_company_name,tci.category,t.supplier_code,t.company_id) t1
                 on t1.year = t2.year
                and t1.halfyear = t2.halfyear
                and t1.supplier_code = t2.supplier_code
                and t1.company_id = t2.company_id
                and t1.category = t2.category 
     inner join scmdata.sys_group_dict gd
        on gd.group_dict_type = 'PRODUCT_TYPE'
       and gd.group_dict_value = t2.category]';
      v_w1 := q'[  where (t1.year || t1.halfyear) <= pkg_kpipt_order.f_yearmonth ) tkb]';
      v_w2 := q'[  where (t1.year || t1.halfyear) = pkg_kpipt_order.f_yearmonth ) tkb]';
      v_z2 := q'[  on (tka.company_id = tkb.company_id and tka.year = tkb.year and tka.halfyear = tkb.halfyear 
                  and tka.supplier_code = tkb.supplier_code and tka.category = tkb.category)
      when matched then
        update
           set tka.batch_amount      = tkb.sum_approver,
               tka.batch_pass_amount = tkb.sum_np_approver,
               tka.supplier_name     = tkb.supplier_name,
               tka.update_id         = 'ADMIN',
               tka.update_time       = sysdate
      when not matched then
        insert
          (tka.t_sp_halfyear_id,
           tka.company_id,
           tka.year,
           tka.halfyear,
           tka.supplier_code,
           tka.supplier_name,
           tka.category,
           tka.category_name,
           tka.batch_amount,
           tka.batch_pass_amount,
           tka.create_id,
           tka.create_time)
        values
          (scmdata.f_get_uuid(),
           tkb.company_id,
           tkb.year,
           tkb.halfyear,
           tkb.supplier_code,
           tkb.supplier_name,
           tkb.category,
           tkb.category_name,
           tkb.sum_approver,
           tkb.sum_np_approver,
           'ADMIN',
           sysdate)]';
      if t_type = 0 then
        v_sql := v_z1 || v_w1 || v_z2;
      elsif t_type = 1 then
        v_sql := v_z1 || v_w2 || v_z2;
      end if;
      execute immediate v_sql;
    end;
  
    /*只更新或者新增面料检测合格率*/
    begin
      v_z1 := q'[   merge into scmdata.t_supplier_performance_halfyear tka
      using (select m1.company_id, m1.year, m1.halfyear, m1.supplier_code, m1.supplier_name,
       m1.category, gd.group_dict_name category_name, m1.check_number, m2.check_np_number
  from (select t.company_id, g.supplier_code,st.supplier_company_name supplier_name, to_char(t.check_date, 'yyyy') year,
               decode(to_char(t.check_date, 'Q') ,1,1,2,1,3,2,4,2) halfyear,g.category, count(1) check_number
          from scmdata.t_check_request t
         inner join scmdata.t_commodity_info g
            on g.goo_id = t.goo_id
           and g.company_id = t.company_id
         inner join scmdata.t_supplier_info st
            on st.supplier_code = g.supplier_code
           and st.company_id = t.company_id
         group by t.company_id, to_char(t.check_date, 'yyyy'), decode(to_char(t.check_date, 'Q') ,1,1,2,1,3,2,4,2),
                  g.category,g.supplier_code, st.supplier_company_name) m1
  left join (select t.company_id, g.category, to_char(t.check_date, 'yyyy') year,decode(to_char(t.check_date, 'Q') ,1,1,2,1,3,2,4,2) halfyear,
                    g.supplier_code, si.supplier_company_name supplier_name, count(1) check_np_number
               from scmdata.t_check_request t
              inner join scmdata.t_commodity_info g
                 on g.goo_id = t.goo_id
                and g.company_id = t.company_id
              inner join scmdata.t_supplier_info si
                 on si.supplier_code = g.supplier_code
                and si.company_id = t.company_id
              where t.check_result = 'FABRIC_PASS'
              group by t.company_id, to_char(t.check_date, 'yyyy'), decode(to_char(t.check_date, 'Q') ,1,1,2,1,3,2,4,2), g.category,g.supplier_code, si.supplier_company_name) m2
    on m2.year = m1.year
   and m2.halfyear = m1.halfyear
   and m2.category = m1.category
   and m2.company_id = m1.company_id
   and m2.supplier_code = m1.supplier_code
 inner join scmdata.sys_group_dict gd
    on gd.group_dict_type = 'PRODUCT_TYPE'
   and gd.group_dict_value = m1.category ]';
      v_w1 := q'[  where (m1.year || m1.halfyear) <= pkg_kpipt_order.f_yearmonth) tkb]';
      v_w2 := q'[  where (m1.year || m1.halfyear) = pkg_kpipt_order.f_yearmonth) tkb]';
      v_z2 := q'[  on (tka.company_id = tkb.company_id and tka.year = tkb.year and tka.halfyear = tkb.halfyear
              and tka.supplier_code = tkb.supplier_code and tka.category = tkb.category)
      when matched then
        update
           set tka.fabric_amount      = tkb.check_number,
               tka.fabric_pass_amount = tkb.check_np_number,
               tka.supplier_name      = tkb.supplier_name,
               tka.update_id          = 'ADMIN',
               tka.update_time        = sysdate
      when not matched then
        insert
          (tka.t_sp_halfyear_id,
           tka.company_id,
           tka.year,
           tka.halfyear,
           tka.supplier_code,
           tka.supplier_name,
           tka.category,
           tka.category_name,
           tka.fabric_amount,
           tka.fabric_pass_amount,
           tka.create_id,
           tka.create_time)
        values
          (scmdata.f_get_uuid(),
           tkb.company_id,
           tkb.year,
           tkb.halfyear,
           tkb.supplier_code,
           tkb.supplier_name,
           tkb.category,
           tkb.category_name,
           tkb.check_number,
           tkb.check_np_number,
           'ADMIN',
           sysdate)]';
      if t_type = 0 then
        v_sql := v_z1 || v_w1 || v_z2;
      elsif t_type = 1 then
        v_sql := v_z1 || v_w2 || v_z2;
      end if;
      execute immediate v_sql;
    end;
  
    /*QC模块*/
    /*只更新或者新增首查*/
    begin
      v_z1 := q'[ merge into scmdata.t_supplier_performance_halfyear tka
      using (select base.supplier supplier_name, base.company_id, to_char(base.finish_time, 'yyyy') year,decode(to_char(base.finish_time, 'Q'),1,1,2,1,3,2,4,2)halfyear,
                    base.supplier_code,base.category,base.category_name,sum(base.order_money) qc_number,
                    sum(case when base.last_qc_result = 'NORMAL_IS_QUALIFIED' then base.order_money end) qualified_number
               from (select k.order_id,k.company_id, k.supplier,k.supplier_code,k.category,k.category_name, min(k.finish_time) finish_time, k.qc_check_node, k.last_qc_result,k.order_money 
                       from (select o.order_id,o.company_id, si.supplier_company_name supplier, qc.finish_time, g.qc_check_node,pt.order_money ,oe.supplier_code,pt.category,pt.category_name,
                                     first_value(qc.qc_result) over(partition by o.order_id, g.qc_check_node order by nvl(qc.finish_time, timestamp'2000-01-01 00:00:00')) LAST_QC_RESULT
                               from scmdata.t_orders o
                              inner join (select a.group_dict_value qc_check_node from scmdata.sys_group_dict a
                                           where a.group_dict_type = 'QC_CHECK_NODE_DICT' and a.pause = 0) g
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
                                and exists
                              (select 1 from scmdata.t_qc_check_rela_order a where a.orders_id = o.orders_id and a.qc_check_id = qc.qc_check_id)
                              inner join scmdata.t_commodity_info ci
                                 on o.goo_id = ci.goo_id
                                and ci.company_id = o.company_id
                              inner join scmdata.t_supplier_info si
                                 on si.supplier_code = oe.supplier_code
                                and si.company_id = oe.company_id
                              where g.qc_check_node = 'QC_FIRST_CHECK'
                                and qc.finish_time is not null) k
                      group by k.order_id, k.supplier,k.supplier_code,k.category,k.category_name, k.company_id,k.qc_check_node, k.last_qc_result,k.order_money) base ]';
      v_w1 := q'[  where (to_char(base.finish_time, 'yyyy') || decode(to_char(base.finish_time, 'Q'),1,1,2,1,3,2,4,2)) <= pkg_kpipt_order.f_yearmonth]';
      v_w2 := q'[  where (to_char(base.finish_time, 'yyyy') || decode(to_char(base.finish_time, 'Q'),1,1,2,1,3,2,4,2)) = pkg_kpipt_order.f_yearmonth]';
      v_z2 := q'[  group by base.supplier,base.supplier_code,base.category,base.category_name,base.company_id, to_char(base.finish_time, 'yyyy'), decode(to_char(base.finish_time, 'Q'),1,1,2,1,3,2,4,2)) tkb
      on (tka.company_id = tkb.company_id and tka.year = tkb.year and tka.halfyear = tkb.halfyear 
              and tka.supplier_code = tkb.supplier_code and tka.category = tkb.category)
      when matched then
        update
           set tka.qc_firstcheck_ordermoney      = tkb.qc_number,
               tka.qc_firstcheck_pass_ordermoney = tkb.qualified_number,
               tka.supplier_name                 = tkb.supplier_name,
               tka.update_id                     = 'ADMIN',
               tka.update_time                   = sysdate
      when not matched then
        insert
          (tka.t_sp_halfyear_id,
           tka.company_id,
           tka.year,
           tka.halfyear,
           tka.supplier_code,
           tka.supplier_name,
           tka.category,
           tka.category_name,
           tka.qc_firstcheck_ordermoney,
           tka.qc_firstcheck_pass_ordermoney,
           tka.create_id,
           tka.create_time)
        values
          (scmdata.f_get_uuid(),
           tkb.company_id,
           tkb.year,
           tkb.halfyear,
           tkb.supplier_code,
           tkb.supplier_name,
           tkb.category,
           tkb.category_name,
           tkb.qc_number,
           tkb.qualified_number,
           'ADMIN',
           sysdate)]';
      if t_type = 0 then
        v_sql := v_z1 || v_w1 || v_z2;
      elsif t_type = 1 then
        v_sql := v_z1 || v_w2 || v_z2;
      end if;
      execute immediate v_sql;
    end;
    /*QC模块*/
    /*只更新或者新增中查*/
    begin
      v_z1 := q'[   merge into scmdata.t_supplier_performance_halfyear tka
      using (select base.supplier supplier_name, base.company_id, to_char(base.finish_time, 'yyyy') year,
                    decode(to_char(base.finish_time, 'Q'),1,1,2,1,3,2,4,2) halfyear, 
                    base.supplier_code,base.category,base.category_name,sum(base.order_money) qc_number,
                    sum(case when base.last_qc_result = 'NORMAL_IS_QUALIFIED' then base.order_money end) qualified_number
               from (select k.order_id,k.company_id, k.supplier,k.supplier_code,k.category,k.category_name, min(k.finish_time) finish_time, k.qc_check_node, k.last_qc_result,k.order_money 
                       from (select o.order_id,o.company_id, si.supplier_company_name supplier, qc.finish_time, g.qc_check_node,pt.order_money ,oe.supplier_code,pt.category,pt.category_name,
                                     first_value(qc.qc_result) over(partition by o.order_id, g.qc_check_node order by nvl(qc.finish_time, timestamp'2000-01-01 00:00:00')) LAST_QC_RESULT
                               from scmdata.t_orders o
                              inner join (select a.group_dict_value qc_check_node from scmdata.sys_group_dict a
                                           where a.group_dict_type = 'QC_CHECK_NODE_DICT' and a.pause = 0) g
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
                                and exists
                              (select 1 from scmdata.t_qc_check_rela_order a
                                      where a.orders_id = o.orders_id and a.qc_check_id = qc.qc_check_id)
                              inner join scmdata.t_commodity_info ci
                                 on o.goo_id = ci.goo_id
                                and ci.company_id = o.company_id
                              inner join scmdata.t_supplier_info si
                                 on si.supplier_code = oe.supplier_code
                                and si.company_id = oe.company_id
                              where g.qc_check_node = 'QC_MIDDLE_CHECK'
                                and qc.finish_time is not null) k
                      group by k.order_id, k.supplier,k.supplier_code,k.category,k.category_name, k.company_id, k.qc_check_node, k.last_qc_result,k.order_money) base ]';
      v_w1 := q'[  where (to_char(base.finish_time, 'yyyy') || decode(to_char(base.finish_time, 'Q'),1,1,2,1,3,2,4,2)) <= pkg_kpipt_order.f_yearmonth]';
      v_w2 := q'[  where (to_char(base.finish_time, 'yyyy') || decode(to_char(base.finish_time, 'Q'),1,1,2,1,3,2,4,2)) = pkg_kpipt_order.f_yearmonth]';
      v_z2 := q'[  group by base.supplier,base.supplier_code,base.category,base.category_name,  base.company_id, to_char(base.finish_time, 'yyyy'), decode(to_char(base.finish_time, 'Q'),1,1,2,1,3,2,4,2)) tkb
      on (tka.company_id = tkb.company_id and tka.year = tkb.year and tka.halfyear = tkb.halfyear
              and tka.supplier_code = tkb.supplier_code and tka.category = tkb.category)
      when matched then
        update
           set tka.qc_middlecheck_ordermoney      = tkb.qc_number,
               tka.qc_middlecheck_pass_ordermoney = tkb.qualified_number,
               tka.supplier_name                  = tkb.supplier_name,
               tka.update_id                      = 'ADMIN',
               tka.update_time                    = sysdate
      when not matched then
        insert
          (tka.t_sp_halfyear_id,
           tka.company_id,
           tka.year,
           tka.halfyear,
           tka.supplier_code,
           tka.supplier_name,
           tka.category,
           tka.category_name,
           tka.qc_middlecheck_ordermoney,
           tka.qc_middlecheck_pass_ordermoney,
           tka.create_id,
           tka.create_time)
        values
          (scmdata.f_get_uuid(),
           tkb.company_id,
           tkb.year,
           tkb.halfyear,
           tkb.supplier_code,
           tkb.supplier_name,
           tkb.category,
           tkb.category_name,
           tkb.qc_number,
           tkb.qualified_number,
           'ADMIN',
           sysdate)]';
      if t_type = 0 then
        v_sql := v_z1 || v_w1 || v_z2;
      elsif t_type = 1 then
        v_sql := v_z1 || v_w2 || v_z2;
      end if;
      execute immediate v_sql;
    end;
    /*QC模块*/
    /*只更新或者新增尾查*/
    begin
      v_z1 := q'[  merge into scmdata.t_supplier_performance_halfyear tka
      using (select base.supplier supplier_name, base.company_id, to_char(base.finish_time, 'yyyy') year,
                    decode(to_char(base.finish_time, 'Q'),1,1,2,1,3,2,4,2) halfyear,
                    base.supplier_code,base.category,base.category_name,sum(base.order_money) qc_number,
                    sum(case when base.last_qc_result = 'NORMAL_IS_QUALIFIED' then base.order_money end) qualified_number
               from (select k.order_id,k.company_id, k.supplier,k.supplier_code,k.category,k.category_name, min(k.finish_time) finish_time, k.qc_check_node, k.last_qc_result,k.order_money 
                       from (select o.order_id,o.company_id, si.supplier_company_name supplier, qc.finish_time, g.qc_check_node,pt.order_money ,oe.supplier_code,pt.category,pt.category_name,
                                     first_value(qc.qc_result) over(partition by o.order_id, g.qc_check_node order by nvl(qc.finish_time, timestamp'2000-01-01 00:00:00')) LAST_QC_RESULT
                               from scmdata.t_orders o
                              inner join (select a.group_dict_value qc_check_node from scmdata.sys_group_dict a
                                           where a.group_dict_type = 'QC_CHECK_NODE_DICT' and a.pause = 0) g
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
                                and exists
                              (select 1 from scmdata.t_qc_check_rela_order a
                                      where a.orders_id = o.orders_id and a.qc_check_id = qc.qc_check_id)
                              inner join scmdata.t_commodity_info ci
                                 on o.goo_id = ci.goo_id
                                and ci.company_id = o.company_id
                              inner join scmdata.t_supplier_info si
                                 on si.supplier_code = oe.supplier_code
                                and si.company_id = oe.company_id
                              where g.qc_check_node = 'QC_FINAL_CHECK'
                                and qc.finish_time is not null) k
                      group by k.order_id, k.supplier, k.supplier_code,k.category,k.category_name,k.company_id, k.qc_check_node, k.last_qc_result,k.order_money) base ]';
      v_w1 := q'[  where (to_char(base.finish_time, 'yyyy') || decode(to_char(base.finish_time, 'Q'),1,1,2,1,3,2,4,2)) <= pkg_kpipt_order.f_yearmonth]';
      v_w2 := q'[  where (to_char(base.finish_time, 'yyyy') || decode(to_char(base.finish_time, 'Q'),1,1,2,1,3,2,4,2)) = pkg_kpipt_order.f_yearmonth]';
      v_z2 := q'[  group by base.supplier,base.supplier_code,base.category,base.category_name, base.company_id, to_char(base.finish_time, 'yyyy'), decode(to_char(base.finish_time, 'Q'),1,1,2,1,3,2,4,2) ) tkb
      on (tka.company_id = tkb.company_id and tka.year = tkb.year and tka.halfyear = tkb.halfyear 
              and tka.supplier_code = tkb.supplier_code and tka.category = tkb.category)
      when matched then
        update
           set tka.qc_finalcheck_ordermoney      = tkb.qc_number,
               tka.qc_finalcheck_pass_ordermoney = tkb.qualified_number,
               tka.supplier_name                 = tkb.supplier_name,
               tka.update_id                     = 'ADMIN',
               tka.update_time                   = sysdate
      when not matched then
        insert
          (tka.t_sp_halfyear_id,
           tka.company_id,
           tka.year,
           tka.halfyear,
           tka.supplier_code,
           tka.supplier_name,
           tka.category,
           tka.category_name,
           tka.qc_finalcheck_ordermoney,
           tka.qc_finalcheck_pass_ordermoney,
           tka.create_id,
           tka.create_time)
        values
          (scmdata.f_get_uuid(),
           tkb.company_id,
           tkb.year,
           tkb.halfyear,
           tkb.supplier_code,
           tkb.supplier_name,
           tkb.category,
           tkb.category_name,
           tkb.qc_number,
           tkb.qualified_number,
           'ADMIN',
           sysdate)]';
      if t_type = 0 then
        v_sql := v_z1 || v_w1 || v_z2;
      elsif t_type = 1 then
        v_sql := v_z1 || v_w2 || v_z2;
      end if;
      execute immediate v_sql;
    end;
    /*只更新或者新增QA查货字段*/
    begin
      v_z1 := q'[   merge into scmdata.t_supplier_performance_halfyear tka
      using (select k.company_id, k.year,k.halfyear,k.qasupplier supplier_name,k.supplier_code,k.category,k.category_name,
           sum(k.pcomesum_amount) pcomesum_amount, sum(k2.pcomesum_amount) np_amount
               from (select distinct to_char(a.check_date, 'yyyy') year, decode( to_char(a.check_date, 'Q'),1,1,2,1,3,2,4,2)halfyear, a.qa_report_id, a.pcomesum_amount,a.company_id,
                                     td.supplier_code,t.supplier_company_name qasupplier,tc.category,gd.group_dict_name category_name
                       from scmdata.t_qa_report a
                      inner join scmdata.t_qa_scope z
                         on a.qa_report_id = z.qa_report_id
                        and a.company_id = z.company_id
                      inner join scmdata.t_ordered td
                         on td.company_id = z.company_id
                        and td.order_code = z.order_id
                      inner join scmdata.t_commodity_info tc
                         on tc.company_id = z.company_id
                        and tc.goo_id = z.goo_id
                      inner join scmdata.sys_group_dict gd
                         on gd.group_dict_type = 'PRODUCT_TYPE'
                        and gd.group_dict_value = tc.category
                      inner join scmdata.t_supplier_info t
                         on t.company_id = z.company_id
                        and t.supplier_code = td.supplier_code
                      where a.status in ('N_ACF', 'R_ACF')) k
               left join (select distinct to_char(a.check_date, 'yyyy') year, decode( to_char(a.check_date, 'Q'),1,1,2,1,3,2,4,2)halfyear, a.qa_report_id,
                                         a.pcomesum_amount, a.check_result, a.company_id,
                                         td.supplier_code,t.supplier_company_name qasupplier,tc.category,gd.group_dict_name category_name
                           from scmdata.t_qa_report a
                          inner join scmdata.t_qa_scope z
                             on a.qa_report_id = z.qa_report_id
                            and a.company_id = z.company_id
                          inner join scmdata.t_ordered td
                             on td.company_id = z.company_id
                            and td.order_code = z.order_id
                          inner join scmdata.t_commodity_info tc
                             on tc.company_id = z.company_id
                            and tc.goo_id = z.goo_id
                          inner join scmdata.sys_group_dict gd
                             on gd.group_dict_type = 'PRODUCT_TYPE'
                            and gd.group_dict_value = tc.category
                          inner join scmdata.t_supplier_info t
                             on t.company_id = z.company_id
                            and t.supplier_code = td.supplier_code
                          where a.status in ('N_ACF', 'R_ACF')
                            and a.check_result = 'QU') k2
                 on k2.qa_report_id = k.qa_report_id
                and k2.year = k.year
                and k2.halfyear = k.halfyear
                and k2.company_id = k.company_id
                and k2.supplier_code = k.supplier_code
                and k2.category = k.category  ]';
      v_w1 := q'[ where (k.year || k.halfyear) <= pkg_kpipt_order.f_yearmonth]';
      v_w2 := q'[ where (k.year || k.halfyear) = pkg_kpipt_order.f_yearmonth]';
      v_z2 := q'[  group by k.year, k.halfyear, k.company_id, k.supplier_code,k.category,k.category_name,k.qasupplier ) tkb
      on (tka.company_id = tkb.company_id and tka.year = tkb.year and tka.halfyear = tkb.halfyear 
              and tka.supplier_code = tkb.supplier_code and tka.category = tkb.category)
      when matched then
        update
           set tka.qa_check_amount      = tkb.pcomesum_amount,
               tka.qa_check_pass_amount = tkb.np_amount,
               tka.supplier_name        = tkb.supplier_name,
               tka.update_id            = 'ADMIN',
               tka.update_time          = sysdate
      when not matched then
        insert
          (tka.t_sp_halfyear_id,
           tka.company_id,
           tka.year,
           tka.halfyear,
           tka.supplier_code,
           tka.supplier_name,
           tka.category,
           tka.category_name,
           tka.qa_check_amount,
           tka.qa_check_pass_amount,
           tka.create_id,
           tka.create_time)
        values
          (scmdata.f_get_uuid(),
           tkb.company_id,
           tkb.year,
           tkb.halfyear,
           tkb.supplier_code,
           tkb.supplier_name,
           tkb.category,
           tkb.category_name,
           tkb.pcomesum_amount,
           tkb.np_amount,
           'ADMIN',
           sysdate)]';
      if t_type = 0 then
        v_sql := v_z1 || v_w1 || v_z2;
      elsif t_type = 1 then
        v_sql := v_z1 || v_w2 || v_z2;
      end if;
      execute immediate v_sql;
    end;

    /*只更新或者新增异常金额、异常数量字段*/
    begin
      v_z1 := q'[ merge into scmdata.t_supplier_performance_halfyear tka
      using ( select k.year,k.halfyear,k.supplier_name,k.supplier_code,k.company_id,k.category,k.category_name,
       sum(k.delay_amount)quality_deviant_amount ,sum(k.delay_amount*k.price)quality_deviant_money 
  from (select to_char(a.confirm_date, 'yyyy') year,
               decode(to_char(a.confirm_date, 'Q') ,1,1,2,1,3,2,4,2) halfyear ,
               a.company_id,
               a.delay_amount, --延期数量
               cf.price,
               oh.supplier_code,
               sp2.supplier_company_name supplier_name,
               cf.category,
               gd_d.group_dict_name category_name
          from scmdata.t_ordered oh
         inner join scmdata.t_orders od
            on oh.company_id = od.company_id
           and oh.order_code = od.order_id
           and oh.order_status in ('OS01', 'OS02')
         inner join t_production_progress t
            on t.company_id = od.company_id
           and t.order_id = od.order_id
           and t.goo_id = od.goo_id
         inner join scmdata.t_commodity_info cf
            on t.company_id = cf.company_id
           and t.goo_id = cf.goo_id
         inner join scmdata.t_supplier_info sp2
            on oh.company_id = sp2.company_id
           and oh.supplier_code = sp2.supplier_code
         inner join scmdata.t_abnormal a
            on t.company_id = a.company_id
           and t.order_id = a.order_id
           and t.goo_id = a.goo_id
           and a.progress_status = '02'
           and a.origin <> 'SC'
         inner join scmdata.sys_company_user sb
            on a.company_id = sb.company_id
           and a.confirm_id = sb.user_id
         inner join scmdata.sys_group_dict gd_d
            on gd_d.group_dict_type = 'PRODUCT_TYPE'
           and gd_d.group_dict_value = cf.category
         where oh.company_id = 'a972dd1ffe3b3a10e0533c281cac8fd7'
           and a.anomaly_class = 'AC_QUALITY')k  ]';
      v_w1 := q'[ where (k.year || k.halfyear) <= pkg_kpipt_order.f_yearmonth  ]';
      v_w2 := q'[ where (k.year || k.halfyear) = pkg_kpipt_order.f_yearmonth  ]';
      v_z2 := q'[  group by k.year,k.halfyear,k.supplier_name,k.supplier_code,k.company_id, k.category,k.category_name ) tkb
      on (tka.company_id = tkb.company_id and tka.year = tkb.year and tka.halfyear = tkb.halfyear
              and tka.supplier_code = tkb.supplier_code and tka.category = tkb.category)
      when matched then
        update
           set tka.quality_deviant_amount = tkb.quality_deviant_amount,
               tka.quality_deviant_money  = tkb.quality_deviant_money,
               tka.supplier_name          = tkb.supplier_name,
               tka.update_id              = 'ADMIN',
               tka.update_time            = sysdate
      when not matched then
        insert
          (tka.t_sp_halfyear_id,
           tka.company_id,
           tka.year,
           tka.halfyear,
           tka.supplier_code,
           tka.supplier_name,
           tka.category,
           tka.category_name,
           tka.quality_deviant_amount,
           tka.quality_deviant_money,
           tka.create_id,
           tka.create_time)
        values
          (scmdata.f_get_uuid(),
           tkb.company_id,
           tkb.year,
           tkb.halfyear,
           tkb.supplier_code,
           tkb.supplier_name,
           tkb.category,
           tkb.category_name,
           tkb.quality_deviant_amount,
           tkb.quality_deviant_money,
           'ADMIN',
           sysdate)]';
      if t_type = 0 then
        v_sql := v_z1 || v_w1 || v_z2;
      elsif t_type = 1 then
        v_sql := v_z1 || v_w2 || v_z2;
      end if;
      execute immediate v_sql;
    end;

  end p_supplier_performance_halfyear;

  /*----------------------------------------------------------------  
     生成供应商绩效盘点报表数据表
         用途：
            供应商绩效盘点表（供应商维度）——按年度更新数据表
         用于：
            供应商绩效盘点报表——供应商tab页      
         更新规则：
             使用oracle数据库定时任务实现——每个年只更新上个年的数据
         入参（t_type 只能传入 0 或者 1 ）：
              t_type := 0 更新全部历史数据
              t_type := 1 只更新上一年的数据                 
        版本:
            2022-03-24 
     2022-04-08 因数据有问题，修改订单满足率、前20%订单满足率分子的取数全部来源于底层订单交期表
     2022-04-11 因底层订单交期表更改了责任部门，订单满足率、前20%订单满足率分子的责任部门全部修改
     2022-05-19 因需求变更，（1）统计维度由供应商修改为供应商+分类，
                            （2）修改了订单满足率、补货平均交期、延货金额、延货数量取值范围，
                            （3）新增异常金额、异常数量
  -------------------------------------------------------------------*/
  procedure p_supplier_performance_year(t_type number) is
    v_sql clob;
    v_z1  clob;
    v_z2  clob;
    v_w1  clob;
    v_w2  clob;
    /*只更新或者新增下单数量、下单金额字段*/
  begin
    v_z1 := q'[  merge into scmdata.t_supplier_performance_year tka
    using (select pt.company_id,to_char(pt.order_create_date, 'yyyy') year, pt.supplier_company_name supplier_name,
               pt.category,pt.category_name,t.supplier_code, 
               sum(pt.order_amount) order_amount,sum(pt.order_money) order_money
          from scmdata.pt_ordered pt 
inner join scmdata.t_supplier_info t
  on t.company_id = pt.company_id
 and t.inside_supplier_code = pt.supplier_code ]';
    /*更新全部历史数据*/
    v_w1 := q'[  where to_char(pt.order_create_date, 'yyyy')  < to_char(sysdate,'yyyy')]';
    /*只更新上一年数据*/
    v_w2 := q'[  where to_char(pt.order_create_date, 'yyyy')  =  to_char(sysdate,'yyyy')-1]';
    v_z2 := q'[  group by pt.company_id, to_char(pt.order_create_date, 'yyyy'), 
                          pt.category,pt.category_name,t.supplier_code, pt.supplier_company_name) tkb
    on (tka.company_id = tkb.company_id and tka.year = tkb.year  
         and tka.supplier_code = tkb.supplier_code and tka.category = tkb.category)
    when matched then
      update
         set tka.order_amount  = tkb.order_amount,
             tka.order_money   = tkb.order_money,
             tka.supplier_name = tkb.supplier_name,
             tka.update_id     = 'ADMIN',
             tka.update_time   = sysdate
    when not matched then
      insert
        (tka.t_sp_year_id,
         tka.company_id,
         tka.year,
         tka.supplier_code,
         tka.supplier_name,
         tka.category,
         tka.category_name,
         tka.order_amount,
         tka.order_money,
         tka.create_id,
         tka.create_time)
      values
        (scmdata.f_get_uuid(),
         tkb.company_id,
         tkb.year,
         tkb.supplier_code,
         tkb.supplier_name,
         tkb.category,
         tkb.category_name,
         tkb.order_amount,
         tkb.order_money,
         'ADMIN',
         sysdate)]';
    if t_type = 0 then
      v_sql := v_z1 || v_w1 || v_z2;
    elsif t_type = 1 then
      v_sql := v_z1 || v_w2 || v_z2;
    end if;
    execute immediate v_sql;
  
    /*只更新或者新增交货数量、交货金额字段*/
    begin
      v_z1 := q'[ merge into scmdata.t_supplier_performance_year tka1
      using (select k.company_id,k.supplier_code, k.supplier_name, k.year,k.category,k.category_name,
                    sum(delivery_amount) delivery_amount, sum(k.delivery_money) delivery_money
               from (select oh.company_id, sp2.supplier_code,sp2.supplier_company_name supplier_name,
                            to_char(tdr.delivery_date, 'yyyy') year, pt.category,pt.category_name,
                            tdr.delivery_amount,(pt.fixed_price * tdr.delivery_amount) delivery_money
                       from scmdata.t_ordered oh
                      inner join scmdata.t_orders od
                         on oh.company_id = od.company_id
                        and oh.order_code = od.order_id
                      inner join scmdata.t_production_progress t
                         on t.company_id = od.company_id
                        and t.order_id = od.order_id
                        and t.goo_id = od.goo_id
                      inner join scmdata.t_commodity_info cf
                         on t.company_id = cf.company_id
                        and t.goo_id = cf.goo_id
                      inner join scmdata.t_supplier_info sp2
                         on t.company_id = sp2.company_id
                        and t.supplier_code = sp2.supplier_code
                      inner join scmdata.t_delivery_record tdr
                         on tdr.company_id = oh.company_id
                        and tdr.order_code = oh.order_code
                        and tdr.goo_id = cf.goo_id
                      inner join scmdata.pt_ordered pt
                         on pt.product_gress_code = tdr.order_code
                        and pt.company_id = tdr.company_id
                        and pt.supplier_company_name = sp2.supplier_company_name) k]';
      v_w1 := q'[  where k.year < to_char(sysdate,'yyyy')]';
      v_w2 := q'[  where k.year = to_char(sysdate,'yyyy') -1]';
      v_z2 := q'[  group by k.company_id, k.supplier_code, k.supplier_name, k.category,k.category_name,k.year) tkb1
      on (tka1.company_id = tkb1.company_id and tka1.year = tkb1.year  
          and tka1.supplier_code = tkb1.supplier_code and tka1.category = tkb1.category)
      when matched then
        update
           set tka1.delivery_amount = tkb1.delivery_amount,
               tka1.delivery_money  = tkb1.delivery_money,
               tka1.supplier_name   = tkb1.supplier_name,
               tka1.update_id       = 'ADMIN',
               tka1.update_time     = sysdate
      when not matched then
        insert
          (tka1.t_sp_year_id,
           tka1.company_id,
           tka1.year,
           tka1.supplier_code,
           tka1.supplier_name,
           tka1.category,
           tka1.category_name,
           tka1.delivery_amount,
           tka1.delivery_money,
           tka1.create_id,
           tka1.create_time)
        values
          (scmdata.f_get_uuid(),
           tkb1.company_id,
           tkb1.year,
           tkb1.supplier_code,
           tkb1.supplier_name,
           tkb1.category,
           tkb1.category_name,
           tkb1.delivery_amount,
           tkb1.delivery_money,
           'ADMIN',
           sysdate)]';
      if t_type = 0 then
        v_sql := v_z1 || v_w1 || v_z2;
      elsif t_type = 1 then
        v_sql := v_z1 || v_w2 || v_z2;
      end if;
      execute immediate v_sql;
    end;
    /*只更新或者新增订单满足率字段*/
    begin
      v_z1 := q'[ merge into scmdata.t_supplier_performance_year tka
      using ( select t1.company_id,t1.supplier_company_name supplier_name,t1.supplier_code,t1.category,t1.category_name,
            t1.year, t1.order_money,t2.sho_order_money
               from (select pt.company_id, pt.supplier_company_name,t.supplier_code,pt.category,
                            pt.category_name, pt.year,sum(pt.order_money) order_money
                       from scmdata.pt_ordered pt
                      inner join scmdata.t_supplier_info t
                         on t.company_id = pt.company_id
                        and t.inside_supplier_code = pt.supplier_code 
                      group by pt.company_id, pt.supplier_company_name, pt.year,t.supplier_code,pt.category,pt.category_name) t1
               left join (select tp.company_id, tp.supplier_company_name,tp.supplier_code,tp.category,tp.category_name,
                                 tp.year, sum(tp.sum_money) sho_order_money
                           from (select t3.company_id,t3.supplier_company_name,t.supplier_code,t3.category,t3.category_name,t3.year,
                                        t3.satisfy_money sum_money
                                   from scmdata.pt_ordered t3
                                  inner join scmdata.t_supplier_info t
                                     on t.company_id = t3.company_id
                                    and t.inside_supplier_code = t3.supplier_code 
                                   union all
                                 select t3a.company_id, t3a.supplier_company_name,t.supplier_code, t3a.category,
                                        t3a.category_name,t3a.year,
                                        (t3a.order_money  - t3a.satisfy_money ) sum_money
                                   from scmdata.pt_ordered t3a
                                  inner join scmdata.t_supplier_info t
                                     on t.company_id = t3a.company_id
                                    and t.inside_supplier_code = t3a.supplier_code 
                                  inner join scmdata.sys_company_dept a
                                     on a.company_id = t3a.company_id
                                    and a.company_dept_id = t3a.responsible_dept
                                    and a.pause = 0
                                  where (a.dept_name like '%物流部%'or a.dept_name like '%品类部%'
                             or a.dept_name like '%事业部%' or a.dept_name = '无')) tp
                          group by tp.company_id, tp.supplier_company_name,tp.supplier_code,tp.year,tp.category,tp.category_name) t2
                 on t2.company_id = t1.company_id
                and t2.supplier_code = t1.supplier_code
                and t2.category = t1.category
                and t2.year = t1.year]';
      v_w1 := q'[ where t1.year < to_char(sysdate,'yyyy')) tkb]';
      v_w2 := q'[ where t1.year = to_char(sysdate,'yyyy')-1) tkb]';
      v_z2 := q'[ on (tka.company_id = tkb.company_id and tka.year = tkb.year 
                  and tka.supplier_code = tkb.supplier_code and tka.category = tkb.category)
      when matched then
        update
           set tka.fillrate_order_money     = tkb.order_money,
               tka.fillrate_sho_order_money = tkb.sho_order_money,
               tka.supplier_name            = tkb.supplier_name,
               tka.update_id                = 'ADMIN',
               tka.update_time              = sysdate
      when not matched then
        insert
          (tka.t_sp_year_id,
           tka.company_id,
           tka.year,
           tka.supplier_code,
           tka.supplier_name,
           tka.category,
           tka.category_name,
           tka.fillrate_order_money,
           tka.fillrate_sho_order_money,
           tka.create_id,
           tka.create_time)
        values
          (scmdata.f_get_uuid(),
           tkb.company_id,
           tkb.year,
           tkb.supplier_code,
           tkb.supplier_name,
           tkb.category,
           tkb.category_name,
           tkb.order_money,
           tkb.sho_order_money,
           'ADMIN',
           sysdate)]';
      if t_type = 0 then
        v_sql := v_z1 || v_w1 || v_z2;
      elsif t_type = 1 then
        v_sql := v_z1 || v_w2 || v_z2;
      end if;
      execute immediate v_sql;
    end;
  
    /*只更新或者新增补货平均交期字段*/
    begin
      v_z1 := q'[ merge into scmdata.t_supplier_performance_year tka
      using (select t1.company_id, t1.year, t1.supplier_name,t1.supplier_code,
       t1.category,t1.category_name, sum(t1.sum1_money) delivery_money,sum(t1.sum1_date*t1.sum1_money) delivery_order_money
              from (select t5.company_id,t5.supplier_company_name supplier_name,tor.supplier_code,
                           to_char(tba.delivery_origin_time,'yyyy')year, t5.category, t5.category_name,
                     (to_date(to_char(tba.delivery_origin_time , 'yyyy/mm/dd'), 'yyyy/mm/dd') -
                     to_date(to_char(t5.order_create_date, 'yyyy/mm/dd'), 'yyyy/mm/dd')) sum1_date,
                     (t5.fixed_price * tba.delivery_amount) sum1_money
                from scmdata.pt_ordered t5
                inner join scmdata.t_delivery_record tba
                  on t5.product_gress_code = tba.order_code
                 and t5.company_id = tba.company_id
                inner join scmdata.t_ordered tor
                   on tor.company_id = tba.company_id
                  and tor.order_code = tba.order_code
                inner join scmdata.t_commodity_info tb
                  on t5.goo_id = tb.rela_goo_id
                 and tb.goo_id = tba.goo_id
                 and t5.company_id = tb.company_id
               where t5.is_first_order = 0
                 and tor.is_product_order = 1)t1 ]';
      v_w1 := q'[  where t1.year  < to_char(sysdate,'yyyy') ]';
      v_w2 := q'[  where t1.year  = to_char(sysdate,'yyyy')-1 ]';
      v_z2 := q'[  group by t1.company_id, t1.year, t1.supplier_name,t1.supplier_code,t1.category, t1.category_name) tkb
      on (tka.company_id = tkb.company_id and tka.year = tkb.year  
              and tka.supplier_code = tkb.supplier_code and tka.category = tkb.category)
      when matched then
        update
           set tka.average_delivery_money       = tkb.delivery_money,
               tka.average_delivery_order_money = tkb.delivery_order_money,
               tka.supplier_name                = tkb.supplier_name,
               tka.update_id                    = 'ADMIN',
               tka.update_time                  = sysdate
      when not matched then
        insert
          (tka.t_sp_year_id,
           tka.company_id,
           tka.year,
           tka.supplier_code,
           tka.supplier_name,
           tka.category,
           tka.category_name,
           tka.average_delivery_money,
           tka.average_delivery_order_money,
           tka.create_id,
           tka.create_time)
        values
          (scmdata.f_get_uuid(),
           tkb.company_id,
           tkb.year,
           tkb.supplier_code,
           tkb.supplier_name,
           tkb.category,
           tkb.category_name,
           tkb.delivery_money,
           tkb.delivery_order_money,
           'ADMIN',
           sysdate)]';
      if t_type = 0 then
        v_sql := v_z1 || v_w1 || v_z2;
      elsif t_type = 1 then
        v_sql := v_z1 || v_w2 || v_z2;
      end if;
      execute immediate v_sql;
    end;
    /*只更新或者新增延期数量、延期金额字段*/
    begin
      v_z1 := q'[ merge into scmdata.t_supplier_performance_year tka
      using (select t2.company_id, t2.supplier_code,t2.supplier_company_name supplier_name,t2.year,
                    t2.category,t2.category_name,sum(t2.delivery_amount) delay_amount,sum(t2.delivery_money) delay_money
               from (select oh.company_id, sp2.supplier_code, sp2.supplier_company_name, to_char(od.delivery_date, 'yyyy') year,
                            pt.category,pt.category_name,tdr.delivery_amount,(pt.fixed_price * tdr.delivery_amount) delivery_money
                       from scmdata.t_ordered oh
                      inner join scmdata.t_orders od
                         on oh.company_id = od.company_id
                        and oh.order_code = od.order_id
                      inner join scmdata.t_production_progress t
                         on t.company_id = od.company_id
                        and t.order_id = od.order_id
                        and t.goo_id = od.goo_id
                      inner join scmdata.t_commodity_info cf
                         on t.company_id = cf.company_id
                        and t.goo_id = cf.goo_id
                      inner join scmdata.t_supplier_info sp2
                         on t.company_id = sp2.company_id
                        and t.supplier_code = sp2.supplier_code
                      inner join scmdata.t_delivery_record tdr
                         on tdr.company_id = oh.company_id
                        and tdr.order_code = oh.order_code
                        and tdr.goo_id = cf.goo_id
                      inner join scmdata.pt_ordered pt
                         on pt.product_gress_code = tdr.order_code
                        and pt.company_id = tdr.company_id
                        and pt.supplier_company_name =
                            sp2.supplier_company_name
                      inner join scmdata.sys_company_dept a
                         on a.company_id = t.company_id
                        and a.company_dept_id = t.responsible_dept
                      where tdr.delivery_date > od.delivery_date
                        and a.dept_name = '供应链管理部') t2  ]';
      v_w1 := q'[   where t2.year < to_char(sysdate,'yyyy') ]';
      v_w2 := q'[   where t2.year = to_char(sysdate,'yyyy')-1 ]';
      v_z2 := q'[   group by t2.company_id, t2.supplier_code, t2.supplier_company_name,t2.category,t2.category_name,t2.year) tkb
      on (tka.company_id = tkb.company_id and tka.year = tkb.year 
              and tka.supplier_code = tkb.supplier_code and tka.category = tkb.category)
      when matched then
        update
           set tka.delay_amount  = tkb.delay_amount,
               tka.delay_money   = tkb.delay_money,
               tka.supplier_name = tkb.supplier_name,
               tka.update_id     = 'ADMIN',
               tka.update_time   = sysdate
      when not matched then
        insert
          (tka.t_sp_year_id,
           tka.company_id,
           tka.year,
           tka.supplier_code,
           tka.supplier_name,
           tka.category,
           tka.category_name,
           tka.delay_amount,
           tka.delay_money,
           tka.create_id,
           tka.create_time)
        values
          (scmdata.f_get_uuid(),
           tkb.company_id,
           tkb.year,
           tkb.supplier_code,
           tkb.supplier_name,
           tkb.category,
           tkb.category_name,
           tkb.delay_amount,
           tkb.delay_money,
           'ADMIN',
           sysdate)]';
      if t_type = 0 then
        v_sql := v_z1 || v_w1 || v_z2;
      elsif t_type = 1 then
        v_sql := v_z1 || v_w2 || v_z2;
      end if;
      execute immediate v_sql;
    end;
  
    /*只更新或者新增批版通过率字段*/
    begin
      v_z1 := q'[ merge into scmdata.t_supplier_performance_year tka
      using (select t2.company_id, t2.year, t2.supplier_code, t2.supplier_name,t2.category, gd.group_dict_name category_name,t2.sum_approver,t1.sum_np_approver
               from (select to_char(tav.approve_time, 'yyyy') year, 
                            tav.company_id,t.supplier_company_name supplier_name,tav.supplier_code,count(1) sum_approver,tci.category
                       from scmdata.t_approve_version tav
                      inner join scmdata.t_commodity_info tci
                         on tav.company_id = tci.company_id
                        and tav.goo_id = tci.goo_id
                      inner join scmdata.t_supplier_info t
                         on t.supplier_code = tav.supplier_code
                        and t.company_id = tav.company_id 
                      where tav.approve_result <> 'AS00'
                      group by to_char(tav.approve_time, 'yyyy'),
                                t.supplier_company_name ,tci.category,tav.company_id, tav.supplier_code) t2
               left join (select to_char(t.approve_time, 'yyyy') year, 
                                 t.supplier_code, ta.supplier_company_name supplier_name, tci.category,t.company_id, count(1) sum_np_approver
                           from scmdata.t_approve_version t
                          inner join scmdata.t_commodity_info tci
                             on t.company_id = tci.company_id
                            and t.goo_id = tci.goo_id
                          inner join scmdata.t_supplier_info ta
                             on t.supplier_code = ta.supplier_code
                            and t.company_id = ta.company_id 
                          where t.approve_result = 'AS03'
                          group by to_char(t.approve_time, 'yyyy'),
                                   ta.supplier_company_name,tci.category,t.supplier_code,t.company_id) t1
                 on t1.year = t2.year
                and t1.supplier_code = t2.supplier_code
                and t1.company_id = t2.company_id
                and t1.category = t2.category
     inner join scmdata.sys_group_dict gd
        on gd.group_dict_type = 'PRODUCT_TYPE'
       and gd.group_dict_value = t2.category ]';
      v_w1 := q'[ where t1.year < to_char(sysdate,'yyyy') ) tkb]';
      v_w2 := q'[ where t1.year = to_char(sysdate,'yyyy')-1 ) tkb]';
      v_z2 := q'[ on (tka.company_id = tkb.company_id and tka.year = tkb.year 
              and tka.supplier_code = tkb.supplier_code and tka.category = tkb.category )
      when matched then
        update
           set tka.batch_amount      = tkb.sum_approver,
               tka.batch_pass_amount = tkb.sum_np_approver,
               tka.supplier_name     = tkb.supplier_name,
               tka.update_id         = 'ADMIN',
               tka.update_time       = sysdate
      when not matched then
        insert
          (tka.t_sp_year_id,
           tka.company_id,
           tka.year,
           tka.supplier_code,
           tka.supplier_name,
           tka.category,
           tka.category_name,
           tka.batch_amount,
           tka.batch_pass_amount,
           tka.create_id,
           tka.create_time)
        values
          (scmdata.f_get_uuid(),
           tkb.company_id,
           tkb.year,
           tkb.supplier_code,
           tkb.supplier_name,
           tkb.category,
           tkb.category_name,
           tkb.sum_approver,
           tkb.sum_np_approver,
           'ADMIN',
           sysdate)]';
      if t_type = 0 then
        v_sql := v_z1 || v_w1 || v_z2;
      elsif t_type = 1 then
        v_sql := v_z1 || v_w2 || v_z2;
      end if;
      execute immediate v_sql;
    end;
  
    /*只更新或者新增面料检测合格率字段*/
    begin
      v_z1 := q'[ merge into scmdata.t_supplier_performance_year tka
      using (select m1.company_id, m1.year, m1.supplier_code, m1.supplier_name,
       m1.category, gd.group_dict_name category_name, m1.check_number, m2.check_np_number
  from (select t.company_id, g.supplier_code,st.supplier_company_name supplier_name, to_char(t.check_date, 'yyyy') year,
               g.category, count(1) check_number
          from scmdata.t_check_request t
         inner join scmdata.t_commodity_info g
            on g.goo_id = t.goo_id
           and g.company_id = t.company_id
         inner join scmdata.t_supplier_info st
            on st.supplier_code = g.supplier_code
           and st.company_id = t.company_id
         group by t.company_id, to_char(t.check_date, 'yyyy'), 
                  g.category,g.supplier_code, st.supplier_company_name) m1
  left join (select t.company_id, g.category, to_char(t.check_date, 'yyyy') year,
                    g.supplier_code, si.supplier_company_name supplier_name, count(1) check_np_number
               from scmdata.t_check_request t
              inner join scmdata.t_commodity_info g
                 on g.goo_id = t.goo_id
                and g.company_id = t.company_id
              inner join scmdata.t_supplier_info si
                 on si.supplier_code = g.supplier_code
                and si.company_id = t.company_id
              where t.check_result = 'FABRIC_PASS'
              group by t.company_id, to_char(t.check_date, 'yyyy'),g.category,g.supplier_code, si.supplier_company_name) m2
    on m2.year = m1.year
   and m2.category = m1.category
   and m2.company_id = m1.company_id
   and m2.supplier_code = m1.supplier_code
 inner join scmdata.sys_group_dict gd
    on gd.group_dict_type = 'PRODUCT_TYPE'
   and gd.group_dict_value = m1.category  ]';
      v_w1 := q'[    where m1.year  < to_char(sysdate,'yyyy') ) tkb]';
      v_w2 := q'[    where m1.year  = to_char(sysdate,'yyyy')-1 ) tkb]';
      v_z2 := q'[  on (tka.company_id = tkb.company_id and tka.year = tkb.year  
              and tka.supplier_code = tkb.supplier_code and tka.category = tkb.category)
      when matched then
        update
           set tka.fabric_amount      = tkb.check_number,
               tka.fabric_pass_amount = tkb.check_np_number,
               tka.supplier_name      = tkb.supplier_name,
               tka.update_id          = 'ADMIN',
               tka.update_time        = sysdate
      when not matched then
        insert
          (tka.t_sp_year_id,
           tka.company_id,
           tka.year,
           tka.supplier_code,
           tka.supplier_name,
           tka.category,
           tka.category_name,
           tka.fabric_amount,
           tka.fabric_pass_amount,
           tka.create_id,
           tka.create_time)
        values
          (scmdata.f_get_uuid(),
           tkb.company_id,
           tkb.year,
           tkb.supplier_code,
           tkb.supplier_name,
           tkb.category,
           tkb.category_name,
           tkb.check_number,
           tkb.check_np_number,
           'ADMIN',
           sysdate)]';
      if t_type = 0 then
        v_sql := v_z1 || v_w1 || v_z2;
      elsif t_type = 1 then
        v_sql := v_z1 || v_w2 || v_z2;
      end if;
      execute immediate v_sql;
    end;
  
    /*QC模块*/
    /*只更新或者新增首查字段*/
    begin
      v_z1 := q'[ merge into scmdata.t_supplier_performance_year tka
      using (select base.supplier supplier_name, base.company_id, to_char(base.finish_time, 'yyyy') year,
                    base.supplier_code,base.category,base.category_name,sum(base.order_money) qc_number,
                    sum(case when base.last_qc_result = 'NORMAL_IS_QUALIFIED' then base.order_money end) qualified_number
               from (select k.order_id,k.company_id, k.supplier,k.supplier_code,k.category,k.category_name, min(k.finish_time) finish_time, k.qc_check_node, k.last_qc_result,k.order_money 
                       from (select o.order_id,o.company_id, si.supplier_company_name supplier, qc.finish_time, g.qc_check_node,pt.order_money ,oe.supplier_code,pt.category,pt.category_name,
                                     first_value(qc.qc_result) over(partition by o.order_id, g.qc_check_node order by nvl(qc.finish_time, timestamp'2000-01-01 00:00:00')) LAST_QC_RESULT
                               from scmdata.t_orders o
                              inner join (select a.group_dict_value qc_check_node from scmdata.sys_group_dict a
                                           where a.group_dict_type = 'QC_CHECK_NODE_DICT' and a.pause = 0) g
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
                                and exists
                              (select 1 from scmdata.t_qc_check_rela_order a where a.orders_id = o.orders_id and a.qc_check_id = qc.qc_check_id)
                              inner join scmdata.t_commodity_info ci
                                 on o.goo_id = ci.goo_id
                                and ci.company_id = o.company_id
                              inner join scmdata.t_supplier_info si
                                 on si.supplier_code = oe.supplier_code
                                and si.company_id = oe.company_id
                              where g.qc_check_node = 'QC_FIRST_CHECK'
                                and qc.finish_time is not null) k
                      group by k.order_id, k.supplier,k.supplier_code,k.category,k.category_name, k.company_id,k.qc_check_node, k.last_qc_result,k.order_money) base]';
      v_w1 := q'[   where to_char(base.finish_time, 'yyyy') < to_char(sysdate,'yyyy') ]';
      v_w2 := q'[   where to_char(base.finish_time, 'yyyy') = to_char(sysdate,'yyyy')-1 ]';
      v_z2 := q'[   group by base.supplier,base.supplier_code,base.category,base.category_name,base.company_id, to_char(base.finish_time, 'yyyy')) tkb
      on (tka.company_id = tkb.company_id and tka.year = tkb.year  
              and tka.supplier_code = tkb.supplier_code and tka.category = tkb.category)
      when matched then
        update
           set tka.qc_firstcheck_ordermoney      = tkb.qc_number,
               tka.qc_firstcheck_pass_ordermoney = tkb.qualified_number,
               tka.supplier_name                 = tkb.supplier_name,
               tka.update_id                     = 'ADMIN',
               tka.update_time                   = sysdate
      when not matched then
        insert
          (tka.t_sp_year_id,
           tka.company_id,
           tka.year,
           tka.supplier_code,
           tka.supplier_name,
           tka.category,
           tka.category_name,
           tka.qc_firstcheck_ordermoney,
           tka.qc_firstcheck_pass_ordermoney,
           tka.create_id,
           tka.create_time)
        values
          (scmdata.f_get_uuid(),
           tkb.company_id,
           tkb.year,
           tkb.supplier_code,
           tkb.supplier_name,
           tkb.category,
           tkb.category_name,
           tkb.qc_number,
           tkb.qualified_number,
           'ADMIN',
           sysdate)]';
      if t_type = 0 then
        v_sql := v_z1 || v_w1 || v_z2;
      elsif t_type = 1 then
        v_sql := v_z1 || v_w2 || v_z2;
      end if;
      execute immediate v_sql;
    end;
    /*QC模块*/
    /*只更新或者新增中查字段*/
    begin
      v_z1 := q'[ merge into scmdata.t_supplier_performance_year tka
      using (select base.supplier supplier_name, base.company_id, to_char(base.finish_time, 'yyyy') year,
                    base.supplier_code,base.category,base.category_name,sum(base.order_money) qc_number,
                    sum(case when base.last_qc_result = 'NORMAL_IS_QUALIFIED' then base.order_money end) qualified_number
               from (select k.order_id,k.company_id, k.supplier,k.supplier_code,k.category,k.category_name, min(k.finish_time) finish_time, k.qc_check_node, k.last_qc_result,k.order_money 
                       from (select o.order_id,o.company_id, si.supplier_company_name supplier, qc.finish_time, g.qc_check_node,pt.order_money ,oe.supplier_code,pt.category,pt.category_name,
                                     first_value(qc.qc_result) over(partition by o.order_id, g.qc_check_node order by nvl(qc.finish_time, timestamp'2000-01-01 00:00:00')) LAST_QC_RESULT
                               from scmdata.t_orders o
                              inner join (select a.group_dict_value qc_check_node from scmdata.sys_group_dict a
                                           where a.group_dict_type = 'QC_CHECK_NODE_DICT' and a.pause = 0) g
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
                                and exists
                              (select 1 from scmdata.t_qc_check_rela_order a  where a.orders_id = o.orders_id and a.qc_check_id = qc.qc_check_id)
                              inner join scmdata.t_commodity_info ci
                                 on o.goo_id = ci.goo_id
                                and ci.company_id = o.company_id
                              inner join scmdata.t_supplier_info si
                                 on si.supplier_code = oe.supplier_code
                                and si.company_id = oe.company_id
                              where g.qc_check_node = 'QC_MIDDLE_CHECK'
                                and qc.finish_time is not null) k
                      group by k.order_id, k.supplier,k.supplier_code,k.category,k.category_name, k.company_id, k.qc_check_node, k.last_qc_result,k.order_money) base]';
      v_w1 := q'[    where to_char(base.finish_time, 'yyyy') < to_char(sysdate,'yyyy')]';
      v_w2 := q'[    where to_char(base.finish_time, 'yyyy') = to_char(sysdate,'yyyy')-1]';
      v_z2 := q'[    group by base.supplier,base.supplier_code,base.category,base.category_name,  base.company_id, to_char(base.finish_time, 'yyyy')) tkb
      on (tka.company_id = tkb.company_id and tka.year = tkb.year 
              and tka.supplier_code = tkb.supplier_code and tka.category = tkb.category)
      when matched then
        update
           set tka.qc_middlecheck_ordermoney      = tkb.qc_number,
               tka.qc_middlecheck_pass_ordermoney = tkb.qualified_number,
               tka.supplier_name                  = tkb.supplier_name,
               tka.update_id                      = 'ADMIN',
               tka.update_time                    = sysdate
      when not matched then
        insert
          (tka.t_sp_year_id,
           tka.company_id,
           tka.year,
           tka.supplier_code,
           tka.supplier_name,
           tka.category,
           tka.category_name,
           tka.qc_middlecheck_ordermoney,
           tka.qc_middlecheck_pass_ordermoney,
           tka.create_id,
           tka.create_time)
        values
          (scmdata.f_get_uuid(),
           tkb.company_id,
           tkb.year,
           tkb.supplier_code,
           tkb.supplier_name,
           tkb.category,
           tkb.category_name,
           tkb.qc_number,
           tkb.qualified_number,
           'ADMIN',
           sysdate)]';
      if t_type = 0 then
        v_sql := v_z1 || v_w1 || v_z2;
      elsif t_type = 1 then
        v_sql := v_z1 || v_w2 || v_z2;
      end if;
      execute immediate v_sql;
    end;
    /*QC模块*/
    /*只更新或者新增尾查字段*/
    begin
      v_z1 := q'[ merge into scmdata.t_supplier_performance_year tka
      using (select base.supplier supplier_name, base.company_id, to_char(base.finish_time, 'yyyy') year, 
                    base.supplier_code,base.category,base.category_name,sum(base.order_money) qc_number,
                    sum(case when base.last_qc_result = 'NORMAL_IS_QUALIFIED' then base.order_money end) qualified_number
               from (select k.order_id, k.supplier,k.supplier_code,k.category,k.category_name,k.company_id, min(k.finish_time) finish_time, k.qc_check_node, k.last_qc_result,k.order_money 
                       from (select o.order_id,o.company_id, si.supplier_company_name supplier, qc.finish_time, g.qc_check_node,pt.order_money ,oe.supplier_code,pt.category,pt.category_name,
                                     first_value(qc.qc_result) over(partition by o.order_id, g.qc_check_node order by nvl(qc.finish_time, timestamp'2000-01-01 00:00:00')) LAST_QC_RESULT
                               from scmdata.t_orders o
                              inner join (select a.group_dict_value qc_check_node from scmdata.sys_group_dict a
                                           where a.group_dict_type = 'QC_CHECK_NODE_DICT' and a.pause = 0) g
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
                                and exists
                              (select 1 from scmdata.t_qc_check_rela_order a where a.orders_id = o.orders_id and a.qc_check_id = qc.qc_check_id)
                              inner join scmdata.t_commodity_info ci
                                 on o.goo_id = ci.goo_id
                                and ci.company_id = o.company_id
                              inner join scmdata.t_supplier_info si
                                 on si.supplier_code = oe.supplier_code
                                and si.company_id = oe.company_id
                              where g.qc_check_node = 'QC_FINAL_CHECK'
                                and qc.finish_time is not null) k
                      group by k.order_id, k.supplier,k.supplier_code,k.category,k.category_name, k.company_id, k.qc_check_node, k.last_qc_result,k.order_money) base]';
      v_w1 := q'[   where to_char(base.finish_time, 'yyyy') < to_char(sysdate,'yyyy')]';
      v_w2 := q'[   where to_char(base.finish_time, 'yyyy') = to_char(sysdate,'yyyy')-1]';
      v_z2 := q'[   group by base.supplier,base.supplier_code,base.category,base.category_name, base.company_id, to_char(base.finish_time, 'yyyy') ) tkb
      on (tka.company_id = tkb.company_id and tka.year = tkb.year  
              and tka.supplier_code = tkb.supplier_code and tka.category = tkb.category)
      when matched then
        update
           set tka.qc_finalcheck_ordermoney      = tkb.qc_number,
               tka.qc_finalcheck_pass_ordermoney = tkb.qualified_number,
               tka.supplier_name                 = tkb.supplier_name,
               tka.update_id                     = 'ADMIN',
               tka.update_time                   = sysdate
      when not matched then
        insert
          (tka.t_sp_year_id,
           tka.company_id,
           tka.year,
           tka.supplier_code,
           tka.supplier_name,
           tka.category,
           tka.category_name,
           tka.qc_finalcheck_ordermoney,
           tka.qc_finalcheck_pass_ordermoney,
           tka.create_id,
           tka.create_time)
        values
          (scmdata.f_get_uuid(),
           tkb.company_id,
           tkb.year,
           tkb.supplier_code,
           tkb.supplier_name,
           tkb.category,
           tkb.category_name,
           tkb.qc_number,
           tkb.qualified_number,
           'ADMIN',
           sysdate)]';
      if t_type = 0 then
        v_sql := v_z1 || v_w1 || v_z2;
      elsif t_type = 1 then
        v_sql := v_z1 || v_w2 || v_z2;
      end if;
      execute immediate v_sql;
    end;
    /*只更新或者新增QA查货字段*/
    begin
      v_z1 := q'[ merge into scmdata.t_supplier_performance_year tka
      using (select k.company_id, k.year,k.qasupplier supplier_name,k.supplier_code,k.category,k.category_name,
           sum(k.pcomesum_amount) pcomesum_amount, sum(k2.pcomesum_amount) np_amount
               from (select distinct to_char(a.check_date, 'yyyy') year,  a.qa_report_id, a.pcomesum_amount,a.company_id,
                                     td.supplier_code,t.supplier_company_name qasupplier,tc.category,gd.group_dict_name category_name
                       from scmdata.t_qa_report a
                      inner join scmdata.t_qa_scope z
                         on a.qa_report_id = z.qa_report_id
                        and a.company_id = z.company_id
                      inner join scmdata.t_ordered td
                         on td.company_id = z.company_id
                        and td.order_code = z.order_id
                      inner join scmdata.t_commodity_info tc
                         on tc.company_id = z.company_id
                        and tc.goo_id = z.goo_id
                      inner join scmdata.sys_group_dict gd
                         on gd.group_dict_type = 'PRODUCT_TYPE'
                        and gd.group_dict_value = tc.category
                      inner join scmdata.t_supplier_info t
                         on t.company_id = z.company_id
                        and t.supplier_code = td.supplier_code
                      where a.status in ('N_ACF', 'R_ACF')) k
               left join (select distinct to_char(a.check_date, 'yyyy') year,a.qa_report_id,
                                         a.pcomesum_amount, a.check_result, a.company_id,
                                         td.supplier_code,t.supplier_company_name qasupplier,tc.category,gd.group_dict_name category_name
                           from scmdata.t_qa_report a
                          inner join scmdata.t_qa_scope z
                             on a.qa_report_id = z.qa_report_id
                            and a.company_id = z.company_id
                          inner join scmdata.t_ordered td
                             on td.company_id = z.company_id
                            and td.order_code = z.order_id
                          inner join scmdata.t_commodity_info tc
                             on tc.company_id = z.company_id
                            and tc.goo_id = z.goo_id
                          inner join scmdata.sys_group_dict gd
                             on gd.group_dict_type = 'PRODUCT_TYPE'
                            and gd.group_dict_value = tc.category
                          inner join scmdata.t_supplier_info t
                             on t.company_id = z.company_id
                            and t.supplier_code = td.supplier_code
                          where a.status in ('N_ACF', 'R_ACF')
                            and a.check_result = 'QU') k2
                 on k2.qa_report_id = k.qa_report_id
                and k2.year = k.year
                and k2.company_id = k.company_id
                and k2.supplier_code = k.supplier_code
                and k2.category = k.category   ]';
      v_w1 := q'[   where k.year < to_char(sysdate,'yyyy')]';
      v_w2 := q'[   where k.year = to_char(sysdate,'yyyy')-1]';
      v_z2 := q'[   group by k.year,  k.company_id, k.supplier_code,k.category,k.category_name,k.qasupplier  ) tkb
      on (tka.company_id = tkb.company_id and tka.year = tkb.year  
              and tka.supplier_code = tkb.supplier_code and tka.category = tkb.category)
      when matched then
        update
           set tka.qa_check_amount      = tkb.pcomesum_amount,
               tka.qa_check_pass_amount = tkb.np_amount,
               tka.supplier_name        = tkb.supplier_name,
               tka.update_id            = 'ADMIN',
               tka.update_time          = sysdate
      when not matched then
        insert
          (tka.t_sp_year_id,
           tka.company_id,
           tka.year,
           tka.supplier_code,
           tka.supplier_name,
           tka.category,
           tka.category_name,
           tka.qa_check_amount,
           tka.qa_check_pass_amount,
           tka.create_id,
           tka.create_time)
        values
          (scmdata.f_get_uuid(),
           tkb.company_id,
           tkb.year,
           tkb.supplier_code,
           tkb.supplier_name,
           tkb.category,
           tkb.category_name,
           tkb.pcomesum_amount,
           tkb.np_amount,
           'ADMIN',
           sysdate)]';
      if t_type = 0 then
        v_sql := v_z1 || v_w1 || v_z2;
      elsif t_type = 1 then
        v_sql := v_z1 || v_w2 || v_z2;
      end if;
      execute immediate v_sql;
    end;

    /*只更新或者新增异常金额、异常数量字段*/
    begin
      v_z1 := q'[ merge into scmdata.t_supplier_performance_year tka
      using ( select k.year,k.supplier_name,k.supplier_code,k.company_id,k.category,k.category_name,
       sum(k.delay_amount)quality_deviant_amount ,sum(k.delay_amount*k.price)quality_deviant_money 
  from (select to_char(a.confirm_date, 'yyyy') year,
               a.company_id,
               a.delay_amount, --延期数量
               cf.price,
               sp2.supplier_code,
               sp2.supplier_company_name supplier_name,
               cf.category,
               gd_d.group_dict_name category_name
          from scmdata.t_ordered oh
         inner join scmdata.t_orders od
            on oh.company_id = od.company_id
           and oh.order_code = od.order_id
           and oh.order_status in ('OS01', 'OS02')
         inner join t_production_progress t
            on t.company_id = od.company_id
           and t.order_id = od.order_id
           and t.goo_id = od.goo_id
         inner join scmdata.t_commodity_info cf
            on t.company_id = cf.company_id
           and t.goo_id = cf.goo_id
         inner join scmdata.t_supplier_info sp2
            on t.company_id = sp2.company_id
           and t.supplier_code = sp2.supplier_code
         inner join scmdata.t_abnormal a
            on t.company_id = a.company_id
           and t.order_id = a.order_id
           and t.goo_id = a.goo_id
           and a.progress_status = '02'
           and a.origin <> 'SC'
         inner join scmdata.sys_company_user sb
            on a.company_id = sb.company_id
           and a.confirm_id = sb.user_id
         inner join scmdata.sys_group_dict gd_d
            on gd_d.group_dict_type = 'PRODUCT_TYPE'
           and gd_d.group_dict_value = cf.category
         where oh.company_id = 'a972dd1ffe3b3a10e0533c281cac8fd7'
           and a.anomaly_class = 'AC_QUALITY')k  ]';
      /*更新全部历史数据*/
      v_w1 := q'[  where k.year < to_char(sysdate,'yyyy')  ]';
      /*只更新上一年数据*/
      v_w2 := q'[  where k.year = to_char(sysdate,'yyyy')-1  ]';

      v_z2 := q'[  group by k.year,k.supplier_name,k.supplier_code,k.company_id, k.category,k.category_name) tkb
      on (tka.company_id = tkb.company_id and tka.year = tkb.year
              and tka.supplier_code = tkb.supplier_code and tka.category = tkb.category)
      when matched then
        update
           set tka.quality_deviant_amount = tkb.quality_deviant_amount,
               tka.quality_deviant_money  = tkb.quality_deviant_money,
               tka.supplier_name          = tkb.supplier_name,
               tka.update_id              = 'ADMIN',
               tka.update_time            = sysdate
      when not matched then
        insert
          (tka.t_sp_year_id,
           tka.company_id,
           tka.year,
           tka.supplier_code,
           tka.supplier_name,
           tka.category,
           tka.category_name,
           tka.quality_deviant_amount,
           tka.quality_deviant_money,
           tka.create_id,
           tka.create_time)
        values
          (scmdata.f_get_uuid(),
           tkb.company_id,
           tkb.year,
           tkb.supplier_code,
           tkb.supplier_name,
           tkb.category,
           tkb.category_name,
           tkb.quality_deviant_amount,
           tkb.quality_deviant_money,
           'ADMIN',
           sysdate)]';
      if t_type = 0 then
        v_sql := v_z1 || v_w1 || v_z2;
      elsif t_type = 1 then
        v_sql := v_z1 || v_w2 || v_z2;
      end if;
      execute immediate v_sql;
    end;

  end p_supplier_performance_year;

  /*------------------------------------------------------------  
     生成工厂效盘点报表数据表
         用途：
            供应商绩效盘点表（生成工厂维度）——按月份更新数据表
         用于：
            供应商绩效盘点报表——生成工厂tab页      
         更新规则：
             使用oracle数据库定时任务实现——每月更新上个月的数据
         入参（t_type 只能传入 0 或者 1 ）：
              t_type := 0 更新全部历史数据
              t_type := 1 只更新上月数据                 
        版本:
            2022-03-24
     2022-04-08 因数据有问题，修改订单满足率、前20%订单满足率分子的取数全部来源于底层订单交期表
     2022-04-11 因底层订单交期表更改了责任部门，订单满足率、前20%订单满足率分子的责任部门全部修改
     2022-05-19 因需求变更，（1）统计维度由供应商修改为生产工厂+分类，
                            （2）修改了订单满足率、补货平均交期、延货金额、延货数量取值范围，
                            （3）新增异常金额、异常数量
  --------------------------------------------------------------*/
  procedure p_factory_performance_month(t_type number) is
    v_sql clob;
    v_z1  clob;
    v_z2  clob;
    v_w1  clob;
    v_w2  clob;
    /*只更新或者新增下单数量、下单金额字段*/
  begin
    v_z1 := q'[  merge into scmdata.t_factory_performance_month tka
    using (select pt.company_id,to_char(pt.order_create_date, 'yyyy') year,to_char(pt.order_create_date, 'mm') month,
                  pt.category,pt.category_name,pt.factory_code,
                  pt.factory_company_name factory_name,sum(pt.order_amount) order_amount,sum(pt.order_money) order_money
  from scmdata.pt_ordered pt
  inner join scmdata.t_supplier_info t 
     on t.company_id = pt.company_id 
    and t.supplier_code = pt.factory_code ]';
    /*更新全部历史数据*/
    v_w1 := q'[  where (to_char(pt.order_create_date, 'yyyy') || to_char(pt.order_create_date, 'mm')) < to_char(sysdate,'yyyymm') ]';
    /*只更新上个月的数据*/
    v_w2 := q'[  where (to_char(pt.order_create_date, 'yyyy') || to_char(pt.order_create_date, 'mm')) = to_char(add_months(sysdate,-1),'yyyymm') ]';
    v_z2 := q'[  group by pt.company_id, to_char(pt.order_create_date, 'yyyy'),to_char(pt.order_create_date, 'mm'), 
                          pt.category,pt.category_name,pt.factory_code, pt.factory_company_name) tkb
    on (tka.company_id = tkb.company_id and tka.year = tkb.year and tka.month = tkb.month
           and tka.factory_code = tkb.factory_code  and tka.category = tkb.category  )
    when matched then
      update
         set tka.order_amount = tkb.order_amount,
             tka.order_money  = tkb.order_money,
             tka.factory_name = tkb.factory_name,
             tka.update_id    = 'ADMIN',
             tka.update_time  = sysdate
    when not matched then
      insert
        (tka.t_fa_month_id,
         tka.company_id,
         tka.year,
         tka.month,
         tka.factory_code,
         tka.factory_name,
         tka.category,
         tka.category_name,
         tka.order_amount,
         tka.order_money,
         tka.create_id,
         tka.create_time)
      values
        (scmdata.f_get_uuid(),
         tkb.company_id,
         tkb.year,
         tkb.month,
         tkb.factory_code,
         tkb.factory_name,
         tkb.category,
         tkb.category_name,
         tkb.order_amount,
         tkb.order_money,
         'ADMIN',
         sysdate)]';
    if t_type = 0 then
      v_sql := v_z1 || v_w1 || v_z2;
    elsif t_type = 1 then
      v_sql := v_z1 || v_w2 || v_z2;
    end if;
    execute immediate v_sql;
  
    /*只更新或者新增交货数量、交货金额字段*/
    begin
      v_z1 := q'[ merge into scmdata.t_factory_performance_month tka1
      using (select k.company_id,k.supplier_company_name factory_name,k.factory_code,k.category,k.category_name,k.year,k.month,sum(delivery_amount)delivery_amount,sum(k.delivery_money)delivery_money
  from (select oh.company_id, sp2.supplier_company_name, to_char(tdr.delivery_date, 'yyyy') year,to_char(tdr.delivery_date, 'mm') month,
               pt.factory_code,pt.category,pt.category_name,tdr.delivery_amount,(pt.fixed_price * tdr.delivery_amount) delivery_money
          from scmdata.t_ordered oh
         inner join scmdata.t_orders od
            on oh.company_id = od.company_id
           and oh.order_code = od.order_id
         inner join scmdata.t_production_progress t
            on t.company_id = od.company_id
           and t.order_id = od.order_id
           and t.goo_id = od.goo_id
         inner join scmdata.t_commodity_info cf
            on t.company_id = cf.company_id
           and t.goo_id = cf.goo_id
         inner join scmdata.t_supplier_info sp2
            on t.company_id = sp2.company_id
           and t.factory_code = sp2.supplier_code
         inner join scmdata.t_delivery_record tdr
            on tdr.company_id = oh.company_id
           and tdr.order_code = oh.order_code
           and tdr.goo_id = cf.goo_id
         inner join scmdata.pt_ordered pt
            on pt.product_gress_code = tdr.order_code
           and pt.company_id = tdr.company_id
           and pt.factory_company_name= sp2.supplier_company_name) k ]';
      v_w1 := q'[  where ( k.year || k.month) < to_char(sysdate,'yyyymm')  ]';
      v_w2 := q'[  where ( k.year || k.month) = to_char(add_months(sysdate,-1),'yyyymm')  ]';
      v_z2 := q'[  group by k.company_id,k.supplier_company_name,k.factory_code,k.category,k.category_name,k.year,k.month) tkb1
      on (tka1.company_id = tkb1.company_id and tka1.year = tkb1.year and tka1.month = tkb1.month 
           and tka1.factory_code = tkb1.factory_code  and tka1.category = tkb1.category )
      when matched then
        update
           set tka1.delivery_amount = tkb1.delivery_amount,
               tka1.delivery_money  = tkb1.delivery_money,
               tka1.factory_name    = tkb1.factory_name,
               tka1.update_id       = 'ADMIN',
               tka1.update_time     = sysdate
      when not matched then
        insert
          (tka1.t_fa_month_id,
           tka1.company_id,
           tka1.year,
           tka1.month,
           tka1.factory_code,
           tka1.factory_name,
           tka1.category,
           tka1.category_name,
           tka1.delivery_amount,
           tka1.delivery_money,
           tka1.create_id,
           tka1.create_time)
        values
          (scmdata.f_get_uuid(),
           tkb1.company_id,
           tkb1.year,
           tkb1.month,
           tkb1.factory_code,
           tkb1.factory_name,
           tkb1.category,
           tkb1.category_name,
           tkb1.delivery_amount,
           tkb1.delivery_money,
           'ADMIN',
           sysdate) ]';
      if t_type = 0 then
        v_sql := v_z1 || v_w1 || v_z2;
      elsif t_type = 1 then
        v_sql := v_z1 || v_w2 || v_z2;
      end if;
      execute immediate v_sql;
    end;
  
    /*只更新或者新增订单满足率字段*/
    begin
      v_z1 := q'[ merge into scmdata.t_factory_performance_month tka
      using ( select t1.company_id,t1.factory_company_name factory_name,t1.factory_code,t1.category,t1.category_name,
            t1.year,lpad(t1.month, 2, 0) month, t1.order_money,t2.sho_order_money
               from (select pt.company_id, pt.factory_company_name,pt.factory_code,pt.category,
                            pt.category_name, pt.year,pt.month,sum(pt.order_money) order_money
                       from scmdata.pt_ordered pt
                      inner join scmdata.t_supplier_info t
                         on t.company_id = pt.company_id
                        and t.supplier_code = pt.factory_code
                      group by pt.company_id, pt.factory_company_name, pt.year, pt.month,pt.factory_code,pt.category,pt.category_name) t1
               left join (select tp.company_id, tp.factory_company_name,tp.factory_code,tp.category,tp.category_name,tp.year,tp.month, sum(tp.sum_money) sho_order_money
                           from (select t3.company_id,t3.factory_company_name,t3.factory_code,t3.category,t3.category_name,t3.year,t3.month,t3.satisfy_money sum_money
                                   from scmdata.pt_ordered t3
                                  inner join scmdata.t_supplier_info t
                                     on t.company_id = t3.company_id
                                    and t.inside_supplier_code = t3.supplier_code 
                                   union all
                                 select t3a.company_id, t3a.factory_company_name,t3a.factory_code, t3a.category,t3a.category_name,t3a.year,t3a.month,
                                        (t3a.order_money  - t3a.satisfy_money ) sum_money
                                   from scmdata.pt_ordered t3a
                                  inner join scmdata.sys_company_dept a
                                     on a.company_id = t3a.company_id
                                    and a.company_dept_id = t3a.responsible_dept
                                    and a.pause = 0
                                  where (a.dept_name like '%物流部%'or a.dept_name like '%品类部%'
                             or a.dept_name like '%事业部%' or a.dept_name = '无')) tp
                          group by tp.company_id, tp.factory_company_name,tp.factory_code,tp.year,tp.month,tp.category,tp.category_name) t2
                 on t2.company_id = t1.company_id
                and t2.factory_code = t1.factory_code
                and t2.category = t1.category
                and t2.year = t1.year
                and t2.month = t1.month]';
      v_w1 := q'[  where (t1.year || lpad(t1.month, 2, 0)) < to_char(sysdate,'yyyymm')) tkb  ]';
      v_w2 := q'[  where (t1.year || lpad(t1.month, 2, 0)) = to_char(add_months(sysdate,-1),'yyyymm')) tkb  ]';
      v_z2 := q'[  on (tka.company_id = tkb.company_id and tka.year = tkb.year and tka.month = tkb.month 
                   and tka.factory_code = tkb.factory_code  and tka.category = tkb.category )
      when matched then
        update
           set tka.fillrate_order_money     = tkb.order_money,
               tka.fillrate_sho_order_money = tkb.sho_order_money,
               tka.factory_name             = tkb.factory_name,
               tka.update_id                = 'ADMIN',
               tka.update_time              = sysdate
      when not matched then
        insert
          (tka.t_fa_month_id,
           tka.company_id,
           tka.year,
           tka.month,
           tka.factory_code,
           tka.factory_name,
           tka.category,
           tka.category_name,
           tka.fillrate_order_money,
           tka.fillrate_sho_order_money,
           tka.create_id,
           tka.create_time)
        values
          (scmdata.f_get_uuid(),
           tkb.company_id,
           tkb.year,
           tkb.month,
           tkb.factory_code,
           tkb.factory_name,
           tkb.category,
           tkb.category_name,
           tkb.order_money,
           tkb.sho_order_money,
           'ADMIN',
           sysdate) ]';
      if t_type = 0 then
        v_sql := v_z1 || v_w1 || v_z2;
      elsif t_type = 1 then
        v_sql := v_z1 || v_w2 || v_z2;
      end if;
      execute immediate v_sql;
    end;
  
    /*只更新或者新增补货平均交期字段*/
    begin
      v_z1 := q'[ merge into scmdata.t_factory_performance_month tka
      using (select t1.company_id, t1.year, t1.month, t1.factory_name,t1.factory_code,
       t1.category,t1.category_name, sum(t1.sum1_money) delivery_money,sum(t1.sum1_date*t1.sum1_money) delivery_order_money
              from (select t5.company_id,t5.factory_company_name factory_name,t5.factory_code,
                          to_char(tba.delivery_origin_time,'yyyy')year, to_char(tba.delivery_origin_time,'mm')month,t5.category, t5.category_name,
                     (to_date(to_char(tba.delivery_origin_time , 'yyyy/mm/dd'), 'yyyy/mm/dd') -
                     to_date(to_char(t5.order_create_date, 'yyyy/mm/dd'), 'yyyy/mm/dd')) sum1_date,
                     (t5.fixed_price * tba.delivery_amount) sum1_money
                from scmdata.pt_ordered t5
                inner join scmdata.t_delivery_record tba
                  on t5.product_gress_code = tba.order_code
                 and t5.company_id = tba.company_id
                inner join scmdata.t_ordered tor
                   on tor.company_id = tba.company_id
                  and tor.order_code = tba.order_code
                inner join scmdata.t_commodity_info tb
                  on t5.goo_id = tb.rela_goo_id
                 and tb.goo_id = tba.goo_id
                 and t5.company_id = tb.company_id
               where t5.is_first_order = 0
                 and tor.is_product_order = 1)t1 ]';
      v_w1 := q'[  where ( t1.year || lpad(t1.month, 2, 0)) < to_char(sysdate,'yyyymm')  ]';
      v_w2 := q'[  where ( t1.year || lpad(t1.month, 2, 0)) = to_char(add_months(sysdate,-1),'yyyymm')  ]';
      v_z2 := q'[  group by t1.company_id, t1.year, t1.month, t1.factory_name,t1.factory_code,t1.category, t1.category_name) tkb
      on (tka.company_id = tkb.company_id and tka.year = tkb.year and tka.month = tkb.month 
           and tka.factory_code = tkb.factory_code  and tka.category = tkb.category )
      when matched then
        update
           set tka.average_delivery_money       = tkb.delivery_money,
               tka.average_delivery_order_money = tkb.delivery_order_money,
               tka.factory_name                 = tkb.factory_name,
               tka.update_id                    = 'ADMIN',
               tka.update_time                  = sysdate
      when not matched then
        insert
          (tka.t_fa_month_id,
           tka.company_id,
           tka.year,
           tka.month,
           tka.factory_code,
           tka.factory_name,
           tka.category,
           tka.category_name,
           tka.average_delivery_money,
           tka.average_delivery_order_money,
           tka.create_id,
           tka.create_time)
        values
          (scmdata.f_get_uuid(),
           tkb.company_id,
           tkb.year,
           tkb.month,
           tkb.factory_code,
           tkb.factory_name,
           tkb.category,
           tkb.category_name,
           tkb.delivery_money,
           tkb.delivery_order_money,
           'ADMIN',
           sysdate) ]';
      if t_type = 0 then
        v_sql := v_z1 || v_w1 || v_z2;
      elsif t_type = 1 then
        v_sql := v_z1 || v_w2 || v_z2;
      end if;
      execute immediate v_sql;
    end;
  
    /*只更新或者新增延期数量、延期金额字段*/
    begin
      v_z1 := q'[ merge into scmdata.t_factory_performance_month tka
      using (  select t2.company_id,t2.supplier_company_name factory_name,t2.factory_code,t2.year,t2.month,t2.category,t2.category_name,
        sum(t2.delivery_amount)delay_amount,sum(t2.delivery_money)delay_money
  from (select oh.company_id,sp2.supplier_company_name,t.factory_code,
               to_char(od.delivery_date, 'yyyy') year,to_char(od.delivery_date, 'mm') month,
               tdr.delivery_amount,pt.category,pt.category_name,
               (pt.fixed_price * tdr.delivery_amount) delivery_money
          from scmdata.t_ordered oh
         inner join scmdata.t_orders od
            on oh.company_id = od.company_id
           and oh.order_code = od.order_id
         inner join scmdata.t_production_progress t
            on t.company_id = od.company_id
           and t.order_id = od.order_id
           and t.goo_id = od.goo_id
         inner join scmdata.t_commodity_info cf
            on t.company_id = cf.company_id
           and t.goo_id = cf.goo_id
         inner join scmdata.t_supplier_info sp2
            on t.company_id = sp2.company_id
           and t.factory_code  = sp2.supplier_code
         inner join scmdata.t_delivery_record tdr
            on tdr.company_id = oh.company_id
           and tdr.order_code = oh.order_code
           and tdr.goo_id = cf.goo_id
          inner join scmdata.pt_ordered pt
            on pt.product_gress_code = tdr.order_code
           and pt.company_id = tdr.company_id
           and pt.factory_company_name  = sp2.supplier_company_name 
         inner join scmdata.sys_company_dept a
            on a.company_id = t.company_id
           and a.company_dept_id =t.responsible_dept
         where tdr.delivery_date > od.delivery_date
           and a.dept_name = '供应链管理部') t2  ]';
      v_w1 := q'[  where ( t2.year || lpad(t2.month, 2, 0)) < to_char(sysdate,'yyyymm') ]';
      v_w2 := q'[  where ( t2.year || lpad(t2.month, 2, 0)) = to_char(add_months(sysdate,-1),'yyyymm') ]';
      v_z2 := q'[ group by t2.company_id,t2.supplier_company_name,t2.factory_code,t2.category,t2.category_name,t2.year,t2.month ) tkb
      on ( tka.company_id = tkb.company_id and tka.year = tkb.year and tka.month = tkb.month
           and tka.factory_code = tkb.factory_code  and tka.category = tkb.category )
      when matched then
        update
           set tka.delay_amount = tkb.delay_amount,
               tka.delay_money  = tkb.delay_money,
               tka.factory_name = tkb.factory_name,
               tka.update_id    = 'ADMIN',
               tka.update_time  = sysdate
      when not matched then
        insert
          (tka.t_fa_month_id,
           tka.company_id,
           tka.year,
           tka.month,
           tka.factory_code,
           tka.factory_name,
           tka.category,
           tka.category_name,
           tka.delay_amount,
           tka.delay_money,
           tka.create_id,
           tka.create_time)
        values
          (scmdata.f_get_uuid(),
           tkb.company_id,
           tkb.year,
           tkb.month,
           tkb.factory_code,
           tkb.factory_name,
           tkb.category,
           tkb.category_name,
           tkb.delay_amount,
           tkb.delay_money,
           'ADMIN',
           sysdate) ]';
      if t_type = 0 then
        v_sql := v_z1 || v_w1 || v_z2;
      elsif t_type = 1 then
        v_sql := v_z1 || v_w2 || v_z2;
      end if;
      execute immediate v_sql;
    end;
    /*QC模块*/
    /*只更新或者新增首查字段*/
    begin
      v_z1 := q'[  merge into scmdata.t_factory_performance_month tka
      using ( select base.supplier factory_name,base.company_id, to_char(base.finish_time, 'yyyy')year, to_char(base.finish_time, 'mm') month,
      base.factory_code,base.category,base.category_name,sum(base.order_money) qc_number,
      sum(case when base.last_qc_result = 'NORMAL_IS_QUALIFIED' then base.order_money end) qualified_number
  from (select k.order_id,k.company_id, k.supplier, min(k.finish_time) finish_time,k.factory_code,k.category,k.category_name,
               k.qc_check_node,k.last_qc_result,k.order_money 
          from (select o.order_id, o.company_id,si.supplier_company_name supplier, qc.finish_time, g.qc_check_node,pt.order_money ,
                       o.factory_code,pt.category,pt.category_name,
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
                   and exists (select 1 from scmdata.t_qc_check_rela_order a where a.orders_id = o.orders_id and a.qc_check_id = qc.qc_check_id)
                 inner join scmdata.t_commodity_info ci
                    on o.goo_id = ci.goo_id
                   and ci.company_id = o.company_id
                 inner join scmdata.t_supplier_info si
                    on si.supplier_code = o.factory_code
                   and si.company_id = oe.company_id
                 where g.qc_check_node = 'QC_FIRST_CHECK'
                   and qc.finish_time is not null) k
         group by k.order_id, k.company_id,k.supplier,k.factory_code,k.category,k.category_name,
                  k.qc_check_node, k.last_qc_result,k.order_money) base ]';
      v_w1 := q'[  where (to_char(base.finish_time, 'yyyy') || to_char(base.finish_time, 'mm')) < to_char(sysdate,'yyyymm') ]';
      v_w2 := q'[  where (to_char(base.finish_time, 'yyyy') || to_char(base.finish_time, 'mm')) = to_char(add_months(sysdate,-1),'yyyymm') ]';
      v_z2 := q'[  group by base.supplier,base.company_id,base.factory_code,base.category,base.category_name,
                   to_char(base.finish_time, 'yyyy'), to_char(base.finish_time, 'mm') ) tkb
      on (tka.company_id = tkb.company_id and tka.year = tkb.year and tka.month = tkb.month 
           and tka.factory_code = tkb.factory_code  and tka.category = tkb.category )
      when matched then
        update
           set tka.qc_firstcheck_ordermoney      = tkb.qc_number,
               tka.qc_firstcheck_pass_ordermoney = tkb.qualified_number,
               tka.factory_name                  = tkb.factory_name,
               tka.update_id                     = 'ADMIN',
               tka.update_time                   = sysdate
      when not matched then
        insert
          (tka.t_fa_month_id,
           tka.company_id,
           tka.year,
           tka.month,
           tka.factory_code,
           tka.factory_name,
           tka.category,
           tka.category_name,
           tka.qc_firstcheck_ordermoney,
           tka.qc_firstcheck_pass_ordermoney,
           tka.create_id,
           tka.create_time)
        values
          (scmdata.f_get_uuid(),
           tkb.company_id,
           tkb.year,
           tkb.month,
           tkb.factory_code,
           tkb.factory_name,
           tkb.category,
           tkb.category_name,
           tkb.qc_number,
           tkb.qualified_number,
           'ADMIN',
           sysdate) ]';
      if t_type = 0 then
        v_sql := v_z1 || v_w1 || v_z2;
      elsif t_type = 1 then
        v_sql := v_z1 || v_w2 || v_z2;
      end if;
      execute immediate v_sql;
    end;
    /*QC模块*/
    /*只更新或者新增中查字段*/
    begin
      v_z1 := q'[ merge into scmdata.t_factory_performance_month tka
      using (select base.supplier factory_name,base.company_id, to_char(base.finish_time, 'yyyy')year, to_char(base.finish_time, 'mm') month,
      base.factory_code,base.category,base.category_name,sum(base.order_money) qc_number,
      sum(case when base.last_qc_result = 'NORMAL_IS_QUALIFIED' then base.order_money end) qualified_number
  from (select k.order_id,k.company_id, k.supplier, min(k.finish_time) finish_time,k.factory_code,k.category,k.category_name,
               k.qc_check_node,k.last_qc_result,k.order_money 
          from (select o.order_id, o.company_id,si.supplier_company_name supplier, qc.finish_time, g.qc_check_node,pt.order_money ,
                       o.factory_code,pt.category,pt.category_name,
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
                   and exists (select 1 from scmdata.t_qc_check_rela_order a where a.orders_id = o.orders_id and a.qc_check_id = qc.qc_check_id)
                 inner join scmdata.t_commodity_info ci
                    on o.goo_id = ci.goo_id
                   and ci.company_id = o.company_id
                 inner join scmdata.t_supplier_info si
                    on si.supplier_code = o.factory_code
                   and si.company_id = oe.company_id
                 where g.qc_check_node = 'QC_MIDDLE_CHECK'
                   and qc.finish_time is not null) k
         group by k.order_id, k.company_id,k.supplier,k.factory_code,k.category,k.category_name,
                  k.qc_check_node, k.last_qc_result,k.order_money) base  ]';
      v_w1 := q'[   where (to_char(base.finish_time, 'yyyy') || to_char(base.finish_time, 'mm')) < to_char(sysdate,'yyyymm') ]';
      v_w2 := q'[   where (to_char(base.finish_time, 'yyyy') || to_char(base.finish_time, 'mm')) = to_char(add_months(sysdate,-1),'yyyymm') ]';
      v_z2 := q'[   group by base.supplier,base.company_id,base.factory_code,base.category,base.category_name,
         to_char(base.finish_time, 'yyyy'), to_char(base.finish_time, 'mm') ) tkb
      on (tka.company_id = tkb.company_id and tka.year = tkb.year and tka.month = tkb.month 
           and tka.factory_code = tkb.factory_code  and tka.category = tkb.category )
      when matched then
        update
           set tka.qc_middlecheck_ordermoney      = tkb.qc_number,
               tka.qc_middlecheck_pass_ordermoney = tkb.qualified_number,
               tka.factory_name                   = tkb.factory_name,
               tka.update_id                      = 'ADMIN',
               tka.update_time                    = sysdate
      when not matched then
        insert
          (tka.t_fa_month_id,
           tka.company_id,
           tka.year,
           tka.month,
           tka.factory_code,
           tka.factory_name,
           tka.category,
           tka.category_name,
           tka.qc_middlecheck_ordermoney,
           tka.qc_middlecheck_pass_ordermoney,
           tka.create_id,
           tka.create_time)
        values
          (scmdata.f_get_uuid(),
           tkb.company_id,
           tkb.year,
           tkb.month,
           tkb.factory_code,
           tkb.factory_name,
           tkb.category,
           tkb.category_name,
           tkb.qc_number,
           tkb.qualified_number,
           'ADMIN',
           sysdate) ]';
      if t_type = 0 then
        v_sql := v_z1 || v_w1 || v_z2;
      elsif t_type = 1 then
        v_sql := v_z1 || v_w2 || v_z2;
      end if;
      execute immediate v_sql;
    end;
    /*QC模块*/
    /*只更新或者新增尾查字段*/
    begin
      v_z1 := q'[ merge into scmdata.t_factory_performance_month tka
      using ( select base.supplier factory_name,base.company_id, to_char(base.finish_time, 'yyyy')year, to_char(base.finish_time, 'mm') month,
      base.factory_code,base.category,base.category_name,sum(base.order_money) qc_number,
      sum(case when base.last_qc_result = 'NORMAL_IS_QUALIFIED' then base.order_money end) qualified_number
  from (select k.order_id,k.company_id, k.supplier, min(k.finish_time) finish_time,k.factory_code,k.category,k.category_name,
               k.qc_check_node,k.last_qc_result,k.order_money 
          from (select o.order_id, o.company_id,si.supplier_company_name supplier, qc.finish_time, g.qc_check_node,pt.order_money ,
                       o.factory_code,pt.category,pt.category_name,
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
                   and exists (select 1 from scmdata.t_qc_check_rela_order a where a.orders_id = o.orders_id and a.qc_check_id = qc.qc_check_id)
                 inner join scmdata.t_commodity_info ci
                    on o.goo_id = ci.goo_id
                   and ci.company_id = o.company_id
                 inner join scmdata.t_supplier_info si
                    on si.supplier_code = o.factory_code
                   and si.company_id = oe.company_id
                 where g.qc_check_node = 'QC_FINAL_CHECK'
                   and qc.finish_time is not null) k
         group by k.order_id, k.company_id,k.supplier,k.factory_code,k.category,k.category_name,
                  k.qc_check_node, k.last_qc_result,k.order_money) base ]';
      v_w1 := q'[  where (to_char(base.finish_time, 'yyyy') || to_char(base.finish_time, 'mm')) < to_char(sysdate,'yyyymm') ]';
      v_w2 := q'[  where (to_char(base.finish_time, 'yyyy') || to_char(base.finish_time, 'mm')) = to_char(add_months(sysdate,-1),'yyyymm') ]';
      v_z2 := q'[  group by base.supplier,base.company_id,base.factory_code,base.category,base.category_name,
         to_char(base.finish_time, 'yyyy'), to_char(base.finish_time, 'mm') ) tkb
      on (tka.company_id = tkb.company_id and tka.year = tkb.year and tka.month = tkb.month 
           and tka.factory_code = tkb.factory_code  and tka.category = tkb.category )
      when matched then
        update
           set tka.qc_finalcheck_ordermoney      = tkb.qc_number,
               tka.qc_finalcheck_pass_ordermoney = tkb.qualified_number,
               tka.factory_name                  = tkb.factory_name,
               tka.update_id                     = 'ADMIN',
               tka.update_time                   = sysdate
      when not matched then
        insert
          (tka.t_fa_month_id,
           tka.company_id,
           tka.year,
           tka.month,
           tka.factory_code,
           tka.factory_name,
           tka.category,
           tka.category_name,
           tka.qc_finalcheck_ordermoney,
           tka.qc_finalcheck_pass_ordermoney,
           tka.create_id,
           tka.create_time)
        values
          (scmdata.f_get_uuid(),
           tkb.company_id,
           tkb.year,
           tkb.month,
           tkb.factory_code,
           tkb.factory_name,
           tkb.category,
           tkb.category_name,
           tkb.qc_number,
           tkb.qualified_number,
           'ADMIN',
           sysdate) ]';
      if t_type = 0 then
        v_sql := v_z1 || v_w1 || v_z2;
      elsif t_type = 1 then
        v_sql := v_z1 || v_w2 || v_z2;
      end if;
      execute immediate v_sql;
    end;
    /*只更新或者新增QA查货字段*/
    begin
      v_z1 := q'[ merge into scmdata.t_factory_performance_month tka
      using ( select kt.year, kt.month, kt.qafactory factory_name,kt.factory_code,kt.category,kt.category_name,
       kt.company_id,kt.pcome_amount, k3.np_amount
  from (select k1.year,k1.month, k1.qafactory,k1.company_id,k1.factory_code,k1.category,k1.category_name,
               sum(k1.pcome_amount) pcome_amount
          from (select to_char(a.check_date, 'yyyy') year, to_char(a.check_date, 'mm') month,
                       a.qa_report_id,z.company_id, z.order_id,z.pcome_amount,
                       td.factory_code,t.supplier_company_name qafactory,tc.category,gd.group_dict_name category_name
                  from scmdata.t_qa_report a
                 inner join scmdata.t_qa_scope z
                    on a.qa_report_id = z.qa_report_id
                   and a.company_id = z.company_id
                inner join scmdata.t_orders td
                   on td.company_id = z.company_id
                  and td.order_id = z.order_id
                inner join scmdata.t_commodity_info tc
                   on tc.company_id = z.company_id
                  and tc.goo_id = z.goo_id
                inner join scmdata.sys_group_dict gd
                   on gd.group_dict_type = 'PRODUCT_TYPE'
                  and gd.group_dict_value = tc.category
                inner join scmdata.t_supplier_info t
                   on t.company_id = z.company_id
                  and t.supplier_code = td.factory_code
                 where a.status in ('N_ACF', 'R_ACF')) k1
         group by k1.year, k1.month, k1.qafactory,k1.factory_code,k1.category,k1.category_name,k1.company_id) kt
  left join (select k2.year,k2.month, k2.qafactory,k2.factory_code,k2.category,k2.category_name,k2.company_id,sum(k2.pcome_amount) np_amount
               from (select to_char(a.check_date, 'yyyy') year, to_char(a.check_date, 'mm') month, a.qa_report_id, z.company_id,z.order_id,z.pcome_amount,
                            td.factory_code,t.supplier_company_name qafactory,tc.category,gd.group_dict_name category_name                            
                       from scmdata.t_qa_report a
                      inner join scmdata.t_qa_scope z
                         on a.qa_report_id = z.qa_report_id
                        and a.company_id = z.company_id
                      inner join scmdata.t_orders td
                         on td.company_id = z.company_id
                        and td.order_id = z.order_id
                      inner join scmdata.t_commodity_info tc
                         on tc.company_id = z.company_id
                        and tc.goo_id = z.goo_id
                      inner join scmdata.sys_group_dict gd
                         on gd.group_dict_type = 'PRODUCT_TYPE'
                        and gd.group_dict_value = tc.category
                      inner join scmdata.t_supplier_info t
                         on t.company_id = z.company_id
                        and t.supplier_code = td.factory_code
                      where a.status in ('N_ACF', 'R_ACF')
                        and a.check_result = 'QU') k2
              group by k2.year, k2.month, k2.qafactory,k2.factory_code,k2.category,k2.category_name,k2.company_id) k3
    on kt.year = k3.year
   and kt.month = k3.month
   and kt.factory_code = k3.factory_code
   and kt.category = k3.category
   and kt.company_id = k3.company_id  ]';
      v_w1 := q'[   where (kt.year || kt.month) < to_char(sysdate,'yyyymm')) tkb ]';
      v_w2 := q'[   where (kt.year || kt.month) = to_char(add_months(sysdate,-1),'yyyymm')) tkb ]';
      v_z2 := q'[   on (tka.company_id = tkb.company_id and tka.year = tkb.year and tka.month = tkb.month 
           and tka.factory_code = tkb.factory_code  and tka.category = tkb.category )
      when matched then
        update
           set tka.qa_check_amount      = tkb.pcome_amount,
               tka.qa_check_pass_amount = tkb.np_amount,
               tka.factory_name         = tkb.factory_name,
               tka.update_id            = 'ADMIN',
               tka.update_time          = sysdate
      when not matched then
        insert
          (tka.t_fa_month_id,
           tka.company_id,
           tka.year,
           tka.month,
           tka.factory_code,
           tka.factory_name,
           tka.category,
           tka.category_name,
           tka.qa_check_amount,
           tka.qa_check_pass_amount,
           tka.create_id,
           tka.create_time)
        values
          (scmdata.f_get_uuid(),
           tkb.company_id,
           tkb.year,
           tkb.month,
           tkb.factory_code,
           tkb.factory_name,
           tkb.category,
           tkb.category_name,
           tkb.pcome_amount,
           tkb.np_amount,
           'ADMIN',
           sysdate)]';
      if t_type = 0 then
        v_sql := v_z1 || v_w1 || v_z2;
      elsif t_type = 1 then
        v_sql := v_z1 || v_w2 || v_z2;
      end if;
      execute immediate v_sql;
    end;


    /*只更新或者新增异常金额、异常数量字段*/
    begin
      v_z1 := q'[ merge into scmdata.t_factory_performance_month tka
      using ( select k.year,k.month,k.factory_name,k.factory_code,k.company_id,k.category,k.category_name,
       sum(k.delay_amount)quality_deviant_amount ,sum(k.delay_amount*k.price)quality_deviant_money 
  from (select to_char(a.confirm_date, 'yyyy') year,
               to_char(a.confirm_date, 'mm') month,
               a.company_id,
               a.delay_amount, --延期数量
               cf.price,
               od.factory_code,
               sp2.supplier_company_name factory_name,
               cf.category,
               gd_d.group_dict_name category_name
          from scmdata.t_ordered oh
         inner join scmdata.t_orders od
            on oh.company_id = od.company_id
           and oh.order_code = od.order_id
           and oh.order_status in ('OS01', 'OS02')
         inner join t_production_progress t
            on t.company_id = od.company_id
           and t.order_id = od.order_id
           and t.goo_id = od.goo_id
         inner join scmdata.t_commodity_info cf
            on t.company_id = cf.company_id
           and t.goo_id = cf.goo_id
         inner join scmdata.t_supplier_info sp2
            on od.company_id = sp2.company_id
           and od.factory_code = sp2.supplier_code
         inner join scmdata.t_abnormal a
            on t.company_id = a.company_id
           and t.order_id = a.order_id
           and t.goo_id = a.goo_id
           and a.progress_status = '02'
           and a.origin <> 'SC'
         inner join scmdata.sys_company_user sb
            on a.company_id = sb.company_id
           and a.confirm_id = sb.user_id
         inner join scmdata.sys_group_dict gd_d
            on gd_d.group_dict_type = 'PRODUCT_TYPE'
           and gd_d.group_dict_value = cf.category
         where oh.company_id = 'a972dd1ffe3b3a10e0533c281cac8fd7'
           and a.anomaly_class = 'AC_QUALITY')k   ]';
      v_w1 := q'[  where (k.year || k.month) < to_char(sysdate,'yyyymm') ]';
      v_w2 := q'[  where (k.year || k.month) = to_char(add_months(sysdate,-1),'yyyymm') ]';
      v_z2 := q'[  group by k.year,k.month,k.factory_name,k.factory_code,k.company_id, k.category,k.category_name) tkb
      on (tka.company_id = tkb.company_id and tka.year = tkb.year and tka.month = tkb.month 
              and tka.factory_code = tkb.factory_code and tka.category = tkb.category)
      when matched then
        update
           set tka.quality_deviant_amount = tkb.quality_deviant_amount,
               tka.quality_deviant_money  = tkb.quality_deviant_money,
               tka.factory_name           = tkb.factory_name,
               tka.update_id              = 'ADMIN',
               tka.update_time            = sysdate
      when not matched then
        insert
          (tka.t_fa_month_id,
           tka.company_id,
           tka.year,
           tka.month,
           tka.factory_code,
           tka.factory_name,
           tka.category,
           tka.category_name,
           tka.quality_deviant_amount,
           tka.quality_deviant_money,
           tka.create_id,
           tka.create_time)
        values
          (scmdata.f_get_uuid(),
           tkb.company_id,
           tkb.year,
           tkb.month,
           tkb.factory_code,
           tkb.factory_name,
           tkb.category,
           tkb.category_name,
           tkb.quality_deviant_amount,
           tkb.quality_deviant_money,
           'ADMIN',
           sysdate)]';
      if t_type = 0 then
        v_sql := v_z1 || v_w1 || v_z2;
      elsif t_type = 1 then
        v_sql := v_z1 || v_w2 || v_z2;
      end if;
      execute immediate v_sql;
    end;

  end p_factory_performance_month;

  /*---------------------------------------------------------------  
     生成工厂绩效盘点报表数据表
         用途：
            供应商绩效盘点表（生成工厂维度）——按季度更新数据表
         用于：
            供应商绩效盘点报表——生成工厂tab页      
         更新规则：
             使用oracle数据库定时任务实现——每季度更新上个季度的数据
          入参（t_type 只能传入 0 或者 1 ）：
              t_type := 0 更新全部历史数据
              t_type := 1 只更新上季度数据                
        版本:
            2022-03-24 
     2022-04-08 因数据有问题，修改订单满足率、前20%订单满足率分子的取数全部来源于底层订单交期表
     2022-04-11 因底层订单交期表更改了责任部门，订单满足率、前20%订单满足率分子的责任部门全部修改
     2022-05-19 因需求变更，（1）统计维度由供应商修改为生产工厂+分类，
                            （2）修改了订单满足率、补货平均交期、延货金额、延货数量取值范围，
                            （3）新增异常金额、异常数量
  ------------------------------------------------------------------*/
  procedure p_factory_performance_quarter(t_type number) is
    v_sql clob;
    v_z1  clob;
    v_z2  clob;
    v_w1  clob;
    v_w2  clob;
    /*只更新或者新增下单数量、下单金额字段*/
  begin
    v_z1 := q'[  merge into scmdata.t_factory_performance_quarter tka
    using (select pt.company_id,to_char(pt.order_create_date, 'yyyy') year,to_char(pt.order_create_date, 'Q') quarter,
                  pt.category,pt.category_name,pt.factory_code,pt.factory_company_name factory_name,
                  sum(pt.order_amount) order_amount,sum(pt.order_money) order_money
  from scmdata.pt_ordered pt 
  inner join scmdata.t_supplier_info t 
     on t.company_id = pt.company_id 
    and t.supplier_code = pt.factory_code ]';
    /*更新全部历史数据*/
    v_w1 := q'[ where (to_char(pt.order_create_date, 'yyyy') || to_char(pt.order_create_date, 'Q')) <= 
                      (to_char(add_months(sysdate,-3),'yyyy')||to_char(add_months(sysdate,-3),'q')) ]';
    /*只更新上一个季度的数据*/
    v_w2 := q'[ where (to_char(pt.order_create_date, 'yyyy') || to_char(pt.order_create_date, 'Q')) = 
                      (to_char(add_months(sysdate,-3),'yyyy')||to_char(add_months(sysdate,-3),'q')) ]';
    v_z2 := q'[ group by pt.company_id, to_char(pt.order_create_date, 'yyyy'),to_char(pt.order_create_date, 'Q'), 
                         pt.category,pt.category_name,pt.factory_code,pt.factory_company_name) tkb
    on (tka.company_id = tkb.company_id and tka.year = tkb.year and tka.quarter = tkb.quarter 
           and tka.factory_code = tkb.factory_code  and tka.category = tkb.category )
    when matched then
      update
         set tka.order_amount = tkb.order_amount,
             tka.order_money  = tkb.order_money,
             tka.factory_name = tkb.factory_name,
             tka.update_id    = 'ADMIN',
             tka.update_time  = sysdate
    when not matched then
      insert
        (tka.t_fa_quarter_id,
         tka.company_id,
         tka.year,
         tka.quarter,
         tka.factory_code,
         tka.factory_name,
         tka.category,
         tka.category_name,
         tka.order_amount,
         tka.order_money,
         tka.create_id,
         tka.create_time)
      values
        (scmdata.f_get_uuid(),
         tkb.company_id,
         tkb.year,
         tkb.quarter,
         tkb.factory_code,
         tkb.factory_name,
         tkb.category,
         tkb.category_name,
         tkb.order_amount,
         tkb.order_money,
         'ADMIN',
         sysdate)]';
    if t_type = 0 then
      v_sql := v_z1 || v_w1 || v_z2;
    elsif t_type = 1 then
      v_sql := v_z1 || v_w2 || v_z2;
    end if;
    execute immediate v_sql;
  
    /*只更新或者新增交货数量、交货金额字段*/
    begin
      v_z1 := q'[  merge into scmdata.t_factory_performance_quarter tka1
      using (select k.company_id,k.supplier_company_name factory_name,k.factory_code,k.category,k.category_name,
             k.year,k.quarter,sum(delivery_amount)delivery_amount,sum(k.delivery_money)delivery_money
  from (select oh.company_id, sp2.supplier_company_name, to_char(tdr.delivery_date, 'yyyy') year,to_char(tdr.delivery_date, 'Q') quarter,
               pt.factory_code,pt.category,pt.category_name,tdr.delivery_amount,(pt.fixed_price * tdr.delivery_amount) delivery_money
          from scmdata.t_ordered oh
         inner join scmdata.t_orders od
            on oh.company_id = od.company_id
           and oh.order_code = od.order_id
         inner join scmdata.t_production_progress t
            on t.company_id = od.company_id
           and t.order_id = od.order_id
           and t.goo_id = od.goo_id
         inner join scmdata.t_commodity_info cf
            on t.company_id = cf.company_id
           and t.goo_id = cf.goo_id
         inner join scmdata.t_supplier_info sp2
            on t.company_id = sp2.company_id
           and t.factory_code = sp2.supplier_code
         inner join scmdata.t_delivery_record tdr
            on tdr.company_id = oh.company_id
           and tdr.order_code = oh.order_code
           and tdr.goo_id = cf.goo_id
         inner join scmdata.pt_ordered pt
            on pt.product_gress_code = tdr.order_code
           and pt.company_id = tdr.company_id
           and pt.factory_company_name= sp2.supplier_company_name) k ]';
      v_w1 := q'[  where (k.year || k.quarter) <= 
                     (to_char(add_months(sysdate,-3),'yyyy')||to_char(add_months(sysdate,-3),'q')) ]';
      v_w2 := q'[  where (k.year || k.quarter) = 
                     (to_char(add_months(sysdate,-3),'yyyy')||to_char(add_months(sysdate,-3),'q')) ]';
      v_z2 := q'[  group by k.company_id,k.supplier_company_name,k.factory_code,k.category,k.category_name,k.year,k.quarter) tkb1
      on (tka1.company_id = tkb1.company_id and tka1.year = tkb1.year and tka1.quarter = tkb1.quarter 
           and tka1.factory_code = tkb1.factory_code  and tka1.category = tkb1.category  )
      when matched then
        update
           set tka1.delivery_amount = tkb1.delivery_amount,
               tka1.delivery_money  = tkb1.delivery_money,
               tka1.factory_name    = tkb1.factory_name,
               tka1.update_id       = 'ADMIN',
               tka1.update_time     = sysdate
      when not matched then
        insert
          (tka1.t_fa_quarter_id,
           tka1.company_id,
           tka1.year,
           tka1.quarter,
           tka1.factory_code,
           tka1.factory_name,
           tka1.category,
           tka1.category_name,
           tka1.delivery_amount,
           tka1.delivery_money,
           tka1.create_id,
           tka1.create_time)
        values
          (scmdata.f_get_uuid(),
           tkb1.company_id,
           tkb1.year,
           tkb1.quarter,
           tkb1.factory_code,
           tkb1.factory_name,
           tkb1.category,
           tkb1.category_name,
           tkb1.delivery_amount,
           tkb1.delivery_money,
           'ADMIN',
           sysdate)]';
      if t_type = 0 then
        v_sql := v_z1 || v_w1 || v_z2;
      elsif t_type = 1 then
        v_sql := v_z1 || v_w2 || v_z2;
      end if;
      execute immediate v_sql;
    end;
    /*只更新或者新增订单满足率字段*/
    begin
      v_z1 := q'[  merge into scmdata.t_factory_performance_quarter tka
      using ( select t1.company_id,t1.factory_company_name factory_name,t1.factory_code,t1.category,t1.category_name,
            t1.year,t1.quarter, t1.order_money,t2.sho_order_money
               from (select pt.company_id, pt.factory_company_name,pt.factory_code,pt.category,
                            pt.category_name, pt.year,pt.quarter,sum(pt.order_money) order_money
                       from scmdata.pt_ordered pt
                      inner join scmdata.t_supplier_info t
                         on t.company_id = pt.company_id
                        and t.supplier_code = pt.factory_code
                      group by pt.company_id, pt.factory_company_name, pt.year, pt.quarter,pt.factory_code,pt.category,pt.category_name) t1
               left join (select tp.company_id, tp.factory_company_name,tp.factory_code,tp.category,tp.category_name,tp.year,tp.quarter, sum(tp.sum_money) sho_order_money
                           from (select t3.company_id,t3.factory_company_name,t3.factory_code,t3.category,t3.category_name,t3.year,t3.quarter,t3.satisfy_money sum_money
                                   from scmdata.pt_ordered t3
                                  inner join scmdata.t_supplier_info t
                                     on t.company_id = t3.company_id
                                    and t.inside_supplier_code = t3.supplier_code 
                                   union all
                                 select t3a.company_id, t3a.factory_company_name,t3a.factory_code, t3a.category,t3a.category_name,t3a.year,t3a.quarter,
                                        (t3a.order_money  - t3a.satisfy_money ) sum_money
                                   from scmdata.pt_ordered t3a
                                  inner join scmdata.sys_company_dept a
                                     on a.company_id = t3a.company_id
                                    and a.company_dept_id = t3a.responsible_dept
                                    and a.pause = 0
                                  where (a.dept_name like '%物流部%'or a.dept_name like '%品类部%'
                             or a.dept_name like '%事业部%' or a.dept_name = '无')) tp
                          group by tp.company_id, tp.factory_company_name,tp.factory_code,tp.year,tp.quarter,tp.category,tp.category_name) t2
                 on t2.company_id = t1.company_id
                and t2.factory_code = t1.factory_code
                and t2.category = t1.category
                and t2.year = t1.year
                and t2.quarter = t1.quarter  ]';
      v_w1 := q'[ where (t1.year || t1.quarter) <= 
                    (to_char(add_months(sysdate,-3),'yyyy')||to_char(add_months(sysdate,-3),'q'))) tkb ]';
      v_w2 := q'[ where (t1.year || t1.quarter) = 
                    (to_char(add_months(sysdate,-3),'yyyy')||to_char(add_months(sysdate,-3),'q'))) tkb ]';
      v_z2 := q'[ on (tka.company_id = tkb.company_id and tka.year = tkb.year and tka.quarter = tkb.quarter 
           and tka.factory_code = tkb.factory_code  and tka.category = tkb.category )
      when matched then
        update
           set tka.fillrate_order_money     = tkb.order_money,
               tka.fillrate_sho_order_money = tkb.sho_order_money,
               tka.factory_name             = tkb.factory_name,
               tka.update_id                = 'ADMIN',
               tka.update_time              = sysdate
      when not matched then
        insert
          (tka.t_fa_quarter_id,
           tka.company_id,
           tka.year,
           tka.quarter,
           tka.factory_code,
           tka.factory_name,
           tka.category,
           tka.category_name,
           tka.fillrate_order_money,
           tka.fillrate_sho_order_money,
           tka.create_id,
           tka.create_time)
        values
          (scmdata.f_get_uuid(),
           tkb.company_id,
           tkb.year,
           tkb.quarter,
           tkb.factory_code,
           tkb.factory_name,
           tkb.category,
           tkb.category_name,
           tkb.order_money,
           tkb.sho_order_money,
           'ADMIN',
           sysdate) ]';
      if t_type = 0 then
        v_sql := v_z1 || v_w1 || v_z2;
      elsif t_type = 1 then
        v_sql := v_z1 || v_w2 || v_z2;
      end if;
      execute immediate v_sql;
    end;
  
    /*只更新或者新增补货平均交期字段*/
    begin
      v_z1 := q'[  merge into scmdata.t_factory_performance_quarter tka
      using (select t1.company_id, t1.year, t1.quarter, t1.factory_name,t1.factory_code,
       t1.category,t1.category_name, sum(t1.sum1_money) delivery_money,sum(t1.sum1_date*t1.sum1_money) delivery_order_money
              from (select t5.company_id,t5.factory_company_name factory_name,t5.factory_code,
                          to_char(tba.delivery_origin_time,'yyyy')year, to_char(tba.delivery_origin_time,'Q')quarter,t5.category, t5.category_name,
                     (to_date(to_char(tba.delivery_origin_time , 'yyyy/mm/dd'), 'yyyy/mm/dd') -
                     to_date(to_char(t5.order_create_date, 'yyyy/mm/dd'), 'yyyy/mm/dd')) sum1_date,
                     (t5.fixed_price * tba.delivery_amount) sum1_money
                from scmdata.pt_ordered t5
                inner join scmdata.t_delivery_record tba
                  on t5.product_gress_code = tba.order_code
                 and t5.company_id = tba.company_id
                inner join scmdata.t_ordered tor
                   on tor.company_id = tba.company_id
                  and tor.order_code = tba.order_code
                inner join scmdata.t_commodity_info tb
                  on t5.goo_id = tb.rela_goo_id
                 and tb.goo_id = tba.goo_id
                 and t5.company_id = tb.company_id
               where t5.is_first_order = 0
                 and tor.is_product_order = 1)t1 ]';
      v_w1 := q'[ where (t1.year || t1.quarter) <= 
                    (to_char(add_months(sysdate,-3),'yyyy')||to_char(add_months(sysdate,-3),'q')) ]';
      v_w2 := q'[ where (t1.year || t1.quarter) = 
                    (to_char(add_months(sysdate,-3),'yyyy')||to_char(add_months(sysdate,-3),'q')) ]';
      v_z2 := q'[ group by t1.company_id, t1.year,t1.quarter, t1.factory_name,t1.factory_code,t1.category, t1.category_name ) tkb
      on (tka.company_id = tkb.company_id and tka.year = tkb.year and tka.quarter = tkb.quarter
           and tka.factory_code = tkb.factory_code  and tka.category = tkb.category  )
      when matched then
        update
           set tka.average_delivery_money       = tkb.delivery_money,
               tka.average_delivery_order_money = tkb.delivery_order_money,
               tka.factory_name                 = tkb.factory_name,
               tka.update_id                    = 'ADMIN',
               tka.update_time                  = sysdate
      when not matched then
        insert
          (tka.t_fa_quarter_id,
           tka.company_id,
           tka.year,
           tka.quarter,
           tka.factory_code,
           tka.factory_name,
           tka.category,
           tka.category_name,
           tka.average_delivery_money,
           tka.average_delivery_order_money,
           tka.create_id,
           tka.create_time)
        values
          (scmdata.f_get_uuid(),
           tkb.company_id,
           tkb.year,
           tkb.quarter,
           tkb.factory_code,
           tkb.factory_name,
           tkb.category,
           tkb.category_name,
           tkb.delivery_money,
           tkb.delivery_order_money,
           'ADMIN',
           sysdate) ]';
      if t_type = 0 then
        v_sql := v_z1 || v_w1 || v_z2;
      elsif t_type = 1 then
        v_sql := v_z1 || v_w2 || v_z2;
      end if;
      execute immediate v_sql;
    end;
  
    /*只更新或者新增延期数量、延期金额字段*/
    begin
      v_z1 := q'[  merge into scmdata.t_factory_performance_quarter tka
      using (  select t2.company_id,t2.supplier_company_name factory_name,t2.factory_code,t2.year,t2.quarter,t2.category,t2.category_name,
        sum(t2.delivery_amount)delay_amount,sum(t2.delivery_money)delay_money
  from (select oh.company_id,sp2.supplier_company_name,t.factory_code,
               to_char(od.delivery_date, 'yyyy') year,to_char(od.delivery_date, 'Q') quarter,
               tdr.delivery_amount,pt.category,pt.category_name,
               (pt.fixed_price * tdr.delivery_amount) delivery_money
          from scmdata.t_ordered oh
         inner join scmdata.t_orders od
            on oh.company_id = od.company_id
           and oh.order_code = od.order_id
         inner join scmdata.t_production_progress t
            on t.company_id = od.company_id
           and t.order_id = od.order_id
           and t.goo_id = od.goo_id
         inner join scmdata.t_commodity_info cf
            on t.company_id = cf.company_id
           and t.goo_id = cf.goo_id
         inner join scmdata.t_supplier_info sp2
            on t.company_id = sp2.company_id
           and t.factory_code  = sp2.supplier_code
         inner join scmdata.t_delivery_record tdr
            on tdr.company_id = oh.company_id
           and tdr.order_code = oh.order_code
           and tdr.goo_id = cf.goo_id
          inner join scmdata.pt_ordered pt
            on pt.product_gress_code = tdr.order_code
           and pt.company_id = tdr.company_id
           and pt.factory_company_name  = sp2.supplier_company_name 
         inner join scmdata.sys_company_dept a
            on a.company_id = t.company_id
           and a.company_dept_id =t.responsible_dept
         where tdr.delivery_date > od.delivery_date
           and a.dept_name = '供应链管理部') t2  ]';
      v_w1 := q'[ where (t2.year || t2.quarter) <= 
                    (to_char(add_months(sysdate,-3),'yyyy')||to_char(add_months(sysdate,-3),'q')) ]';
      v_w2 := q'[ where (t2.year || t2.quarter) = 
                    (to_char(add_months(sysdate,-3),'yyyy')||to_char(add_months(sysdate,-3),'q')) ]';
      v_z2 := q'[ group by t2.company_id,t2.supplier_company_name,t2.factory_code,t2.category,t2.category_name,t2.year,t2.quarter  ) tkb
      on (tka.company_id = tkb.company_id and tka.year = tkb.year and tka.quarter = tkb.quarter
           and tka.factory_code = tkb.factory_code  and tka.category = tkb.category )
      when matched then
        update
           set tka.delay_amount = tkb.delay_amount,
               tka.delay_money  = tkb.delay_money,
               tka.factory_name = tkb.factory_name,
               tka.update_id    = 'ADMIN',
               tka.update_time  = sysdate
      when not matched then
          insert
            (tka.t_fa_quarter_id,
             tka.company_id,
             tka.year,
             tka.quarter,
             tka.factory_code,
             tka.factory_name,
             tka.category,
             tka.category_name,
             tka.delay_amount,
             tka.delay_money,
             tka.create_id,
             tka.create_time)
          values
            (scmdata.f_get_uuid(),
             tkb.company_id,
             tkb.year,
             tkb.quarter,
             tkb.factory_code,
             tkb.factory_name,
             tkb.category,
             tkb.category_name,
             tkb.delay_amount,
             tkb.delay_money,
             'ADMIN',
             sysdate) ]';
      if t_type = 0 then
        v_sql := v_z1 || v_w1 || v_z2;
      elsif t_type = 1 then
        v_sql := v_z1 || v_w2 || v_z2;
      end if;
      execute immediate v_sql;
    end;
    /*QC模块*/
    /*只更新或者新增首查字段*/
    begin
      v_z1 := q'[  merge into scmdata.t_factory_performance_quarter tka
      using ( select base.supplier factory_name,base.company_id, to_char(base.finish_time, 'yyyy')year, to_char(base.finish_time, 'Q') quarter,
       base.factory_code,base.category,base.category_name,sum(base.order_money) qc_number,
       sum(case when base.last_qc_result = 'NORMAL_IS_QUALIFIED' then base.order_money end) qualified_number
  from (select k.order_id,k.company_id, k.supplier, min(k.finish_time) finish_time,k.factory_code,k.category,k.category_name,
               k.qc_check_node,k.last_qc_result,k.order_money 
          from (select o.order_id, o.company_id,si.supplier_company_name supplier, qc.finish_time, g.qc_check_node,pt.order_money ,
                       o.factory_code,pt.category,pt.category_name,
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
                   and exists (select 1 from scmdata.t_qc_check_rela_order a where a.orders_id = o.orders_id and a.qc_check_id = qc.qc_check_id)
                 inner join scmdata.t_commodity_info ci
                    on o.goo_id = ci.goo_id
                   and ci.company_id = o.company_id
                 inner join scmdata.t_supplier_info si
                    on si.supplier_code = o.factory_code
                   and si.company_id = oe.company_id
                 where g.qc_check_node = 'QC_FIRST_CHECK'
                   and qc.finish_time is not null) k
         group by k.order_id, k.company_id,k.supplier,k.factory_code,k.category,k.category_name,
                  k.qc_check_node, k.last_qc_result,k.order_money) base ]';
      v_w1 := q'[ where (to_char(base.finish_time, 'yyyy') || to_char(base.finish_time, 'Q')) <= 
                    (to_char(add_months(sysdate,-3),'yyyy')||to_char(add_months(sysdate,-3),'q')) ]';
      v_w2 := q'[ where (to_char(base.finish_time, 'yyyy') || to_char(base.finish_time, 'Q')) = 
                    (to_char(add_months(sysdate,-3),'yyyy')||to_char(add_months(sysdate,-3),'q')) ]';
      v_z2 := q'[ group by base.supplier,base.company_id,base.factory_code,base.category,base.category_name,
                 to_char(base.finish_time, 'yyyy'), to_char(base.finish_time, 'Q')) tkb
      on (tka.company_id = tkb.company_id and tka.year = tkb.year and tka.quarter = tkb.quarter 
           and tka.factory_code = tkb.factory_code  and tka.category = tkb.category )
      when matched then
        update
           set tka.qc_firstcheck_ordermoney      = tkb.qc_number,
               tka.qc_firstcheck_pass_ordermoney = tkb.qualified_number,
               tka.factory_name                  = tkb.factory_name,
               tka.update_id                     = 'ADMIN',
               tka.update_time                   = sysdate
      when not matched then
        insert
          (tka.t_fa_quarter_id,
           tka.company_id,
           tka.year,
           tka.quarter,
           tka.factory_code,
           tka.factory_name,
           tka.category,
           tka.category_name,
           tka.qc_firstcheck_ordermoney,
           tka.qc_firstcheck_pass_ordermoney,
           tka.create_id,
           tka.create_time)
        values
          (scmdata.f_get_uuid(),
           tkb.company_id,
           tkb.year,
           tkb.quarter,
           tkb.factory_code,
           tkb.factory_name,
           tkb.category,
           tkb.category_name,
           tkb.qc_number,
           tkb.qualified_number,
           'ADMIN',
           sysdate)]';
      if t_type = 0 then
        v_sql := v_z1 || v_w1 || v_z2;
      elsif t_type = 1 then
        v_sql := v_z1 || v_w2 || v_z2;
      end if;
      execute immediate v_sql;
    end;
    /*QC模块*/
    /*只更新或者新增中查字段*/
    begin
      v_z1 := q'[  merge into scmdata.t_factory_performance_quarter tka
      using ( select base.supplier factory_name,base.company_id, to_char(base.finish_time, 'yyyy')year, to_char(base.finish_time, 'Q') quarter,
       base.factory_code,base.category,base.category_name,sum(base.order_money) qc_number,
       sum(case when base.last_qc_result = 'NORMAL_IS_QUALIFIED' then base.order_money end) qualified_number
  from (select k.order_id,k.company_id, k.supplier, min(k.finish_time) finish_time,k.factory_code,k.category,k.category_name,
               k.qc_check_node,k.last_qc_result,k.order_money 
          from (select o.order_id, o.company_id,si.supplier_company_name supplier, qc.finish_time, g.qc_check_node,pt.order_money ,
                       o.factory_code,pt.category,pt.category_name,
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
                   and exists (select 1 from scmdata.t_qc_check_rela_order a where a.orders_id = o.orders_id and a.qc_check_id = qc.qc_check_id)
                 inner join scmdata.t_commodity_info ci
                    on o.goo_id = ci.goo_id
                   and ci.company_id = o.company_id
                 inner join scmdata.t_supplier_info si
                    on si.supplier_code = o.factory_code
                   and si.company_id = oe.company_id
                 where g.qc_check_node = 'QC_MIDDLE_CHECK'
                   and qc.finish_time is not null) k
         group by k.order_id, k.company_id,k.supplier,k.factory_code,k.category,k.category_name,
                  k.qc_check_node, k.last_qc_result,k.order_money) base  ]';
      v_w1 := q'[ where (to_char(base.finish_time, 'yyyy') || to_char(base.finish_time, 'Q')) <= 
                    (to_char(add_months(sysdate,-3),'yyyy')||to_char(add_months(sysdate,-3),'q')) ]';
      v_w2 := q'[ where (to_char(base.finish_time, 'yyyy') || to_char(base.finish_time, 'Q')) = 
                    (to_char(add_months(sysdate,-3),'yyyy')||to_char(add_months(sysdate,-3),'q')) ]';
      v_z2 := q'[group by base.supplier,base.company_id,base.factory_code,base.category,base.category_name,
                        to_char(base.finish_time, 'yyyy'), to_char(base.finish_time, 'Q') ) tkb
      on (tka.company_id = tkb.company_id and tka.year = tkb.year and tka.quarter = tkb.quarter 
           and tka.factory_code = tkb.factory_code  and tka.category = tkb.category )
      when matched then
        update
           set tka.qc_middlecheck_ordermoney      = tkb.qc_number,
               tka.qc_middlecheck_pass_ordermoney = tkb.qualified_number,
               tka.factory_name                   = tkb.factory_name,
               tka.update_id                      = 'ADMIN',
               tka.update_time                    = sysdate
      when not matched then
        insert
          (tka.t_fa_quarter_id,
           tka.company_id,
           tka.year,
           tka.quarter,
           tka.factory_code,
           tka.factory_name,
           tka.category,
           tka.category_name,
           tka.qc_middlecheck_ordermoney,
           tka.qc_middlecheck_pass_ordermoney,
           tka.create_id,
           tka.create_time)
        values
          (scmdata.f_get_uuid(),
           tkb.company_id,
           tkb.year,
           tkb.quarter,
           tkb.factory_code,
           tkb.factory_name,
           tkb.category,
           tkb.category_name,
           tkb.qc_number,
           tkb.qualified_number,
           'ADMIN',
           sysdate)]';
      if t_type = 0 then
        v_sql := v_z1 || v_w1 || v_z2;
      elsif t_type = 1 then
        v_sql := v_z1 || v_w2 || v_z2;
      end if;
      execute immediate v_sql;
    end;
    /*QC模块*/
    /*只更新或者新增尾查字段*/
    begin
      v_z1 := q'[  merge into scmdata.t_factory_performance_quarter tka
      using ( select base.supplier factory_name,base.company_id, to_char(base.finish_time, 'yyyy')year, to_char(base.finish_time, 'Q') quarter,
       base.factory_code,base.category,base.category_name,sum(base.order_money) qc_number,
       sum(case when base.last_qc_result = 'NORMAL_IS_QUALIFIED' then base.order_money end) qualified_number
  from (select k.order_id,k.company_id, k.supplier, min(k.finish_time) finish_time,k.factory_code,k.category,k.category_name,
               k.qc_check_node,k.last_qc_result,k.order_money 
          from (select o.order_id, o.company_id,si.supplier_company_name supplier, qc.finish_time, g.qc_check_node,pt.order_money ,
                       o.factory_code,pt.category,pt.category_name,
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
                   and exists (select 1 from scmdata.t_qc_check_rela_order a where a.orders_id = o.orders_id and a.qc_check_id = qc.qc_check_id)
                 inner join scmdata.t_commodity_info ci
                    on o.goo_id = ci.goo_id
                   and ci.company_id = o.company_id
                 inner join scmdata.t_supplier_info si
                    on si.supplier_code = o.factory_code
                   and si.company_id = oe.company_id
                 where g.qc_check_node = 'QC_FINAL_CHECK'
                   and qc.finish_time is not null) k
         group by k.order_id, k.company_id,k.supplier,k.factory_code,k.category,k.category_name,
                  k.qc_check_node, k.last_qc_result,k.order_money) base ]';
      v_w1 := q'[ where (to_char(base.finish_time, 'yyyy') || to_char(base.finish_time, 'Q')) <= 
                    (to_char(add_months(sysdate,-3),'yyyy')||to_char(add_months(sysdate,-3),'q')) ]';
      v_w2 := q'[ where (to_char(base.finish_time, 'yyyy') || to_char(base.finish_time, 'Q')) = 
                    (to_char(add_months(sysdate,-3),'yyyy')||to_char(add_months(sysdate,-3),'q')) ]';
      v_z2 := q'[group by base.supplier,base.company_id,base.factory_code,base.category,base.category_name,
                          to_char(base.finish_time, 'yyyy'), to_char(base.finish_time, 'Q') ) tkb
      on (tka.company_id = tkb.company_id and tka.year = tkb.year and tka.quarter = tkb.quarter 
           and tka.factory_code = tkb.factory_code  and tka.category = tkb.category )
      when matched then
        update
           set tka.qc_finalcheck_ordermoney      = tkb.qc_number,
               tka.qc_finalcheck_pass_ordermoney = tkb.qualified_number,
               tka.factory_name                  = tkb.factory_name,
               tka.update_id                     = 'ADMIN',
               tka.update_time                   = sysdate
      when not matched then
        insert
          (tka.t_fa_quarter_id,
           tka.company_id,
           tka.year,
           tka.quarter,
           tka.factory_code,
           tka.factory_name,
           tka.category,
           tka.category_name,
           tka.qc_finalcheck_ordermoney,
           tka.qc_finalcheck_pass_ordermoney,
           tka.create_id,
           tka.create_time)
        values
          (scmdata.f_get_uuid(),
           tkb.company_id,
           tkb.year,
           tkb.quarter,
           tkb.factory_code,
           tkb.factory_name,
           tkb.category,
           tkb.category_name,
           tkb.qc_number,
           tkb.qualified_number,
           'ADMIN',
           sysdate)]';
      if t_type = 0 then
        v_sql := v_z1 || v_w1 || v_z2;
      elsif t_type = 1 then
        v_sql := v_z1 || v_w2 || v_z2;
      end if;
      execute immediate v_sql;
    end;
    /*只更新或者新增QA查货字段*/
    begin
      v_z1 := q'[  merge into scmdata.t_factory_performance_quarter tka
      using ( select kt.year, kt.quarter, kt.qafactory factory_name,kt.factory_code,kt.category,kt.category_name,
       kt.company_id,kt.pcome_amount, k3.np_amount
  from (select k1.year,k1.quarter, k1.qafactory,k1.company_id,k1.factory_code,k1.category,k1.category_name,
               sum(k1.pcome_amount) pcome_amount
          from (select to_char(a.check_date, 'yyyy') year, to_char(a.check_date, 'Q') quarter,
                       a.qa_report_id,z.company_id, z.order_id,z.pcome_amount,
                       td.factory_code,t.supplier_company_name qafactory,tc.category,gd.group_dict_name category_name
                  from scmdata.t_qa_report a
                 inner join scmdata.t_qa_scope z
                    on a.qa_report_id = z.qa_report_id
                   and a.company_id = z.company_id
                inner join scmdata.t_orders td
                   on td.company_id = z.company_id
                  and td.order_id = z.order_id
                inner join scmdata.t_commodity_info tc
                   on tc.company_id = z.company_id
                  and tc.goo_id = z.goo_id
                inner join scmdata.sys_group_dict gd
                   on gd.group_dict_type = 'PRODUCT_TYPE'
                  and gd.group_dict_value = tc.category
                inner join scmdata.t_supplier_info t
                   on t.company_id = z.company_id
                  and t.supplier_code = td.factory_code
                 where a.status in ('N_ACF', 'R_ACF')) k1
         group by k1.year, k1.quarter, k1.qafactory,k1.factory_code,k1.category,k1.category_name,k1.company_id) kt
  left join (select k2.year,k2.quarter, k2.qafactory,k2.factory_code,k2.category,k2.category_name,k2.company_id,sum(k2.pcome_amount) np_amount
               from (select to_char(a.check_date, 'yyyy') year, to_char(a.check_date, 'Q') quarter, a.qa_report_id, z.company_id,z.order_id,z.pcome_amount,
                            td.factory_code,t.supplier_company_name qafactory,tc.category,gd.group_dict_name category_name                            
                       from scmdata.t_qa_report a
                      inner join scmdata.t_qa_scope z
                         on a.qa_report_id = z.qa_report_id
                        and a.company_id = z.company_id
                      inner join scmdata.t_orders td
                         on td.company_id = z.company_id
                        and td.order_id = z.order_id
                      inner join scmdata.t_commodity_info tc
                         on tc.company_id = z.company_id
                        and tc.goo_id = z.goo_id
                      inner join scmdata.sys_group_dict gd
                         on gd.group_dict_type = 'PRODUCT_TYPE'
                        and gd.group_dict_value = tc.category
                      inner join scmdata.t_supplier_info t
                         on t.company_id = z.company_id
                        and t.supplier_code = td.factory_code
                      where a.status in ('N_ACF', 'R_ACF')
                        and a.check_result = 'QU') k2
              group by k2.year, k2.quarter, k2.qafactory,k2.factory_code,k2.category,k2.category_name,k2.company_id) k3
    on kt.year = k3.year
   and kt.quarter = k3.quarter
   and kt.factory_code = k3.factory_code
   and kt.category = k3.category
   and kt.company_id = k3.company_id  ]';
      v_w1 := q'[ where (kt.year || kt.quarter) <= 
                    (to_char(add_months(sysdate,-3),'yyyy')||to_char(add_months(sysdate,-3),'q'))) tkb ]';
      v_w2 := q'[ where (kt.year || kt.quarter) = 
                    (to_char(add_months(sysdate,-3),'yyyy')||to_char(add_months(sysdate,-3),'q'))) tkb ]';
      v_z2 := q'[ on (tka.company_id = tkb.company_id and tka.year = tkb.year and tka.quarter = tkb.quarter
           and tka.factory_code = tkb.factory_code  and tka.category = tkb.category )
            when matched then
             update
                set tka.qa_check_amount      = tkb.pcome_amount,
                    tka.qa_check_pass_amount = tkb.np_amount,
                    tka.factory_name         = tkb.factory_name,
                    tka.update_id            = 'ADMIN',
                    tka.update_time          = sysdate
            when not matched then
             insert
               (tka.t_fa_quarter_id,
                tka.company_id,
                tka.year,
                tka.quarter,
                tka.factory_code,
                tka.factory_name,
                tka.category,
                tka.category_name,
                tka.qa_check_amount,
                tka.qa_check_pass_amount,
                tka.create_id,
                tka.create_time)
             values
               (scmdata.f_get_uuid(),
                tkb.company_id,
                tkb.year,
                tkb.quarter,
                tkb.factory_code,
                tkb.factory_name,
                tkb.category,
                tkb.category_name,
                tkb.pcome_amount,
                tkb.np_amount,
                'ADMIN',
                sysdate) ]';
      if t_type = 0 then
        v_sql := v_z1 || v_w1 || v_z2;
      elsif t_type = 1 then
        v_sql := v_z1 || v_w2 || v_z2;
      end if;
      execute immediate v_sql;
    end;

    /*只更新或者新增异常金额、异常数量字段*/
    begin
      v_z1 := q'[ merge into scmdata.t_factory_performance_quarter tka
      using ( select k.year,k.quarter,k.factory_name,k.factory_code,k.company_id,k.category,k.category_name,
       sum(k.delay_amount)quality_deviant_amount ,sum(k.delay_amount*k.price)quality_deviant_money 
  from (select to_char(a.confirm_date, 'yyyy') year,
               to_char(a.confirm_date, 'Q') quarter,
               a.company_id,
               a.delay_amount, --延期数量
               cf.price,
               od.factory_code,
               sp2.supplier_company_name factory_name,
               cf.category,
               gd_d.group_dict_name category_name
          from scmdata.t_ordered oh
         inner join scmdata.t_orders od
            on oh.company_id = od.company_id
           and oh.order_code = od.order_id
           and oh.order_status in ('OS01', 'OS02')
         inner join t_production_progress t
            on t.company_id = od.company_id
           and t.order_id = od.order_id
           and t.goo_id = od.goo_id
         inner join scmdata.t_commodity_info cf
            on t.company_id = cf.company_id
           and t.goo_id = cf.goo_id
         inner join scmdata.t_supplier_info sp2
            on od.company_id = sp2.company_id
           and od.factory_code = sp2.supplier_code
         inner join scmdata.t_abnormal a
            on t.company_id = a.company_id
           and t.order_id = a.order_id
           and t.goo_id = a.goo_id
           and a.progress_status = '02'
           and a.origin <> 'SC'
         inner join scmdata.sys_company_user sb
            on a.company_id = sb.company_id
           and a.confirm_id = sb.user_id
         inner join scmdata.sys_group_dict gd_d
            on gd_d.group_dict_type = 'PRODUCT_TYPE'
           and gd_d.group_dict_value = cf.category
         where oh.company_id = 'a972dd1ffe3b3a10e0533c281cac8fd7'
           and a.anomaly_class = 'AC_QUALITY')k  ]';
      v_w1 := q'[ where (k.year || k.quarter) <= 
                    (to_char(add_months(sysdate,-3),'yyyy')||to_char(add_months(sysdate,-3),'q')) ]';
      v_w2 := q'[ where (k.year || k.quarter) = 
                    (to_char(add_months(sysdate,-3),'yyyy')||to_char(add_months(sysdate,-3),'q')) ]';
      v_z2 := q'[  group by k.year,k.quarter,k.factory_name,k.factory_code,k.company_id, k.category,k.category_name) tkb
      on (tka.company_id = tkb.company_id and tka.year = tkb.year and tka.quarter = tkb.quarter
              and tka.factory_code = tkb.factory_code and tka.category = tkb.category)
      when matched then
        update
           set tka.quality_deviant_amount = tkb.quality_deviant_amount,
               tka.quality_deviant_money  = tkb.quality_deviant_money,
               tka.factory_name           = tkb.factory_name,
               tka.update_id              = 'ADMIN',
               tka.update_time            = sysdate
      when not matched then
        insert
          (tka.t_fa_quarter_id,
           tka.company_id,
           tka.year,
           tka.quarter,
           tka.factory_code,
           tka.factory_name,
           tka.category,
           tka.category_name,
           tka.quality_deviant_amount,
           tka.quality_deviant_money,
           tka.create_id,
           tka.create_time)
        values
          (scmdata.f_get_uuid(),
           tkb.company_id,
           tkb.year,
           tkb.quarter,
           tkb.factory_code,
           tkb.factory_name,
           tkb.category,
           tkb.category_name,
           tkb.quality_deviant_amount,
           tkb.quality_deviant_money,
           'ADMIN',
           sysdate)]';
      if t_type = 0 then
        v_sql := v_z1 || v_w1 || v_z2;
      elsif t_type = 1 then
        v_sql := v_z1 || v_w2 || v_z2;
      end if;
      execute immediate v_sql;
    end;

  end p_factory_performance_quarter;

  /*---------------------------------------------------------------------  
     生成工厂绩效盘点报表数据表
         用途：
            供应商绩效盘点表（生成工厂维度）——按半年度更新数据表
         用于：
            供应商绩效盘点报表——生成工厂tab页      
         更新规则：
             使用oracle数据库定时任务实现——每半年度只更新上个半年度的数据
          入参（t_type 只能传入 0 或者 1 ）：
              t_type := 0 更新全部历史数据
              t_type := 1 只更新上半年度的数据                
        版本:
            2022-03-24 
     2022-04-08 因数据有问题，修改订单满足率、前20%订单满足率分子的取数全部来源于底层订单交期表
     2022-04-11 因底层订单交期表更改了责任部门，订单满足率、前20%订单满足率分子的责任部门全部修改
     2022-05-19 因需求变更，（1）统计维度由供应商修改为生产工厂+分类，
                            （2）修改了订单满足率、补货平均交期、延货金额、延货数量取值范围，
                            （3）新增异常金额、异常数量
  ------------------------------------------------------------------------*/
  procedure p_factory_performance_halfyear(t_type number) is
    v_sql clob;
    v_z1  clob;
    v_z2  clob;
    v_w1  clob;
    v_w2  clob;
    /*只更新或者新增下单数量、下单金额字段*/
  begin
    v_z1 := q'[ merge into scmdata.t_factory_performance_halfyear tka
    using (select pt.company_id,to_char(pt.order_create_date, 'yyyy') year,decode(to_char(pt.order_create_date, 'Q'),1,1,2,1,3,2,4,2) halfyear,
                  pt.category,pt.category_name,pt.factory_code,pt.factory_company_name factory_name,
                  sum(pt.order_amount) order_amount,sum(pt.order_money) order_money
  from scmdata.pt_ordered pt
  inner join scmdata.t_supplier_info t 
     on t.company_id = pt.company_id 
    and t.supplier_code = pt.factory_code  ]';
    /*更新全部历史数据*/
    v_w1 := q'[ where (to_char(pt.order_create_date, 'yyyy') || decode(to_char(pt.order_create_date, 'Q'),1,1,2,1,3,2,4,2)) 
                      <= pkg_kpipt_order.f_yearmonth ]';
    /*只更新上一个半年度数据*/
    v_w2 := q'[ where (to_char(pt.order_create_date, 'yyyy') || decode(to_char(pt.order_create_date, 'Q'),1,1,2,1,3,2,4,2)) 
                      = pkg_kpipt_order.f_yearmonth ]';
    v_z2 := q'[ group by pt.company_id, to_char(pt.order_create_date, 'yyyy'),decode(to_char(pt.order_create_date, 'Q'),1,1,2,1,3,2,4,2),
                         pt.category,pt.category_name,pt.factory_code, pt.factory_company_name) tkb
    on (tka.company_id = tkb.company_id and tka.year = tkb.year and tka.halfyear = tkb.halfyear 
           and tka.factory_code = tkb.factory_code  and tka.category = tkb.category )
    when matched then
      update
         set tka.order_amount = tkb.order_amount,
             tka.order_money  = tkb.order_money,
             tka.factory_name = tkb.factory_name,
             tka.update_id    = 'ADMIN',
             tka.update_time  = sysdate
    when not matched then
      insert
        (tka.t_fa_halfyear_id,
         tka.company_id,
         tka.year,
         tka.halfyear,
         tka.factory_code,
         tka.factory_name,
         tka.category,
         tka.category_name,
         tka.order_amount,
         tka.order_money,
         tka.create_id,
         tka.create_time)
      values
        (scmdata.f_get_uuid(),
         tkb.company_id,
         tkb.year,
         tkb.halfyear,
         tkb.factory_code,
         tkb.factory_name,
         tkb.category,
         tkb.category_name,
         tkb.order_amount,
         tkb.order_money,
         'ADMIN',
         sysdate)]';
    if t_type = 0 then
      v_sql := v_z1 || v_w1 || v_z2;
    elsif t_type = 1 then
      v_sql := v_z1 || v_w2 || v_z2;
    end if;
    execute immediate v_sql;
  
    /*只更新或者新增交货数量、交货金额字段*/
    begin
      v_z1 := q'[ merge into scmdata.t_factory_performance_halfyear tka1
      using (select k.company_id,k.supplier_company_name factory_name,k.factory_code,k.category,k.category_name,
                    k.year,decode(k.quarter,1,1,2,1,3,2,4,2) halfyear,sum(delivery_amount)delivery_amount,sum(k.delivery_money)delivery_money
  from (select oh.company_id, sp2.supplier_company_name, to_char(tdr.delivery_date, 'yyyy') year,to_char(tdr.delivery_date, 'Q') quarter,
               pt.factory_code,pt.category,pt.category_name,tdr.delivery_amount,(pt.fixed_price * tdr.delivery_amount) delivery_money
          from scmdata.t_ordered oh
         inner join scmdata.t_orders od
            on oh.company_id = od.company_id
           and oh.order_code = od.order_id
         inner join scmdata.t_production_progress t
            on t.company_id = od.company_id
           and t.order_id = od.order_id
           and t.goo_id = od.goo_id
         inner join scmdata.t_commodity_info cf
            on t.company_id = cf.company_id
           and t.goo_id = cf.goo_id
         inner join scmdata.t_supplier_info sp2
            on t.company_id = sp2.company_id
           and t.factory_code = sp2.supplier_code
         inner join scmdata.t_delivery_record tdr
            on tdr.company_id = oh.company_id
           and tdr.order_code = oh.order_code
           and tdr.goo_id = cf.goo_id
         inner join scmdata.pt_ordered pt
            on pt.product_gress_code = tdr.order_code
           and pt.company_id = tdr.company_id
           and pt.factory_company_name = sp2.supplier_company_name) k ]';
      v_w1 := q'[ where (k.year || decode(k.quarter,1,1,2,1,3,2,4,2)) <= pkg_kpipt_order.f_yearmonth ]';
      v_w2 := q'[ where (k.year || decode(k.quarter,1,1,2,1,3,2,4,2)) = pkg_kpipt_order.f_yearmonth ]';
      v_z2 := q'[  group by k.company_id,k.supplier_company_name,k.factory_code,k.category,k.category_name,
                            k.year,decode(k.quarter,1,1,2,1,3,2,4,2) ) tkb1
      on (tka1.company_id = tkb1.company_id and tka1.year = tkb1.year and tka1.halfyear = tkb1.halfyear 
           and tka1.factory_code = tkb1.factory_code  and tka1.category = tkb1.category )
      when matched then
         update
            set tka1.delivery_amount = tkb1.delivery_amount,
                tka1.delivery_money  = tkb1.delivery_money,
                tka1.factory_name    = tkb1.factory_name,
                tka1.update_id       = 'ADMIN',
                tka1.update_time     = sysdate
      when not matched then
        insert
          (tka1.t_fa_halfyear_id,
           tka1.company_id,
           tka1.year,
           tka1.halfyear,
           tka1.factory_code,
           tka1.factory_name,
           tka1.category,
           tka1.category_name,
           tka1.delivery_amount,
           tka1.delivery_money,
           tka1.create_id,
           tka1.create_time)
        values
          (scmdata.f_get_uuid(),
           tkb1.company_id,
           tkb1.year,
           tkb1.halfyear,
           tkb1.factory_code,
           tkb1.factory_name,
           tkb1.category,
           tkb1.category_name,
           tkb1.delivery_amount,
           tkb1.delivery_money,
           'ADMIN',
           sysdate)]';
      if t_type = 0 then
        v_sql := v_z1 || v_w1 || v_z2;
      elsif t_type = 1 then
        v_sql := v_z1 || v_w2 || v_z2;
      end if;
      execute immediate v_sql;
    end;
    /*只更新或者新增订单满足率字段*/
    begin
      v_z1 := q'[ merge into scmdata.t_factory_performance_halfyear tka
      using ( select t1.company_id,t1.factory_company_name factory_name,t1.factory_code,t1.category,t1.category_name,
            t1.year,t1.halfyear, t1.order_money,t2.sho_order_money
               from (select pt.company_id, pt.factory_company_name,pt.factory_code,pt.category,
                            pt.category_name, pt.year,decode(pt.quarter,1,1,2,1,3,2,4,2) halfyear,sum(pt.order_money) order_money
                       from scmdata.pt_ordered pt
                      inner join scmdata.t_supplier_info t
                         on t.company_id = pt.company_id
                        and t.supplier_code = pt.factory_code
                      group by pt.company_id, pt.factory_company_name, pt.year, decode(pt.quarter,1,1,2,1,3,2,4,2),pt.factory_code,pt.category,pt.category_name) t1
               left join (select tp.company_id, tp.factory_company_name,tp.factory_code,tp.category,tp.category_name,tp.year,tp.halfyear, sum(tp.sum_money) sho_order_money
                           from (select t3.company_id,t3.factory_company_name,t3.factory_code,t3.category,t3.category_name,
                                        t3.year,decode(t3.quarter,1,1,2,1,3,2,4,2) halfyear,t3.satisfy_money sum_money
                                   from scmdata.pt_ordered t3
                                  inner join scmdata.t_supplier_info t
                                     on t.company_id = t3.company_id
                                    and t.inside_supplier_code = t3.supplier_code 
                                   union all
                                 select t3a.company_id, t3a.factory_company_name,t3a.factory_code, t3a.category,t3a.category_name,
                                        t3a.year,decode(t3a.quarter,1,1,2,1,3,2,4,2) halfyear,
                                        (t3a.order_money  - t3a.satisfy_money ) sum_money
                                   from scmdata.pt_ordered t3a
                                  inner join scmdata.sys_company_dept a
                                     on a.company_id = t3a.company_id
                                    and a.company_dept_id = t3a.responsible_dept
                                    and a.pause = 0
                                  where (a.dept_name like '%物流部%'or a.dept_name like '%品类部%'
                             or a.dept_name like '%事业部%' or a.dept_name = '无')) tp
                          group by tp.company_id, tp.factory_company_name,tp.factory_code,tp.year,tp.halfyear,tp.category,tp.category_name) t2
                 on t2.company_id = t1.company_id
                and t2.factory_code = t1.factory_code
                and t2.category = t1.category
                and t2.year = t1.year
                and t2.halfyear = t1.halfyear  ]';
      v_w1 := q'[  where (t1.year || t1.halfyear ) <= pkg_kpipt_order.f_yearmonth ) tkb ]';
      v_w2 := q'[  where (t1.year || t1.halfyear ) = pkg_kpipt_order.f_yearmonth ) tkb ]';
      v_z2 := q'[ on (tka.company_id = tkb.company_id and tka.year = tkb.year and tka.halfyear = tkb.halfyear 
           and tka.factory_code = tkb.factory_code  and tka.category = tkb.category )
      when matched then
        update
           set tka.fillrate_order_money     = tkb.order_money,
               tka.fillrate_sho_order_money = tkb.sho_order_money,
               tka.factory_name             = tkb.factory_name,
               tka.update_id                = 'ADMIN',
               tka.update_time              = sysdate
      when not matched then
        insert
          (tka.t_fa_halfyear_id,
           tka.company_id,
           tka.year,
           tka.halfyear,
           tka.factory_code,
           tka.factory_name,
           tka.category,
           tka.category_name,
           tka.fillrate_order_money,
           tka.fillrate_sho_order_money,
           tka.create_id,
           tka.create_time)
        values
          (scmdata.f_get_uuid(),
           tkb.company_id,
           tkb.year,
           tkb.halfyear,
           tkb.factory_code,
           tkb.factory_name,
           tkb.category,
           tkb.category_name,
           tkb.order_money,
           tkb.sho_order_money,
           'ADMIN',
           sysdate) ]';
      if t_type = 0 then
        v_sql := v_z1 || v_w1 || v_z2;
      elsif t_type = 1 then
        v_sql := v_z1 || v_w2 || v_z2;
      end if;
      execute immediate v_sql;
    end;
  
    /*只更新或者新增补货平均交期字段*/
    begin
      v_z1 := q'[ merge into scmdata.t_factory_performance_halfyear tka
      using (select t1.company_id, t1.year, t1.halfyear, t1.factory_name,t1.factory_code,
       t1.category,t1.category_name, sum(t1.sum1_money) delivery_money,sum(t1.sum1_date*t1.sum1_money) delivery_order_money
              from (select t5.company_id,t5.factory_company_name factory_name,t5.factory_code,
                          to_char(tba.delivery_origin_time,'yyyy')year, decode(to_char(tba.delivery_origin_time,'Q'),1,1,2,1,3,2,4,2)halfyear,t5.category, t5.category_name,
                     (to_date(to_char(tba.delivery_origin_time , 'yyyy/mm/dd'), 'yyyy/mm/dd') -
                     to_date(to_char(t5.order_create_date, 'yyyy/mm/dd'), 'yyyy/mm/dd')) sum1_date,
                     (t5.fixed_price * tba.delivery_amount) sum1_money
                from scmdata.pt_ordered t5
                inner join scmdata.t_delivery_record tba
                  on t5.product_gress_code = tba.order_code
                 and t5.company_id = tba.company_id
                inner join scmdata.t_ordered tor
                   on tor.company_id = tba.company_id
                  and tor.order_code = tba.order_code
                inner join scmdata.t_commodity_info tb
                  on t5.goo_id = tb.rela_goo_id
                 and tb.goo_id = tba.goo_id
                 and t5.company_id = tb.company_id
               where t5.is_first_order = 0
                 and tor.is_product_order = 1)t1 ]';
      v_w1 := q'[ where (t1.year ||halfyear ) <= pkg_kpipt_order.f_yearmonth  ]';
      v_w2 := q'[ where (t1.year ||halfyear ) = pkg_kpipt_order.f_yearmonth  ]';
      v_z2 := q'[ group by t1.company_id, t1.year,t1.halfyear,t1.factory_name,t1.factory_code,t1.category, t1.category_name ) tkb
      on (tka.company_id = tkb.company_id and tka.year = tkb.year and tka.halfyear = tkb.halfyear 
           and tka.factory_code = tkb.factory_code  and tka.category = tkb.category )
      when matched then
        update
           set tka.average_delivery_money       = tkb.delivery_money,
               tka.average_delivery_order_money = tkb.delivery_order_money,
               tka.factory_name                 = tkb.factory_name,
               tka.update_id                    = 'ADMIN',
               tka.update_time                  = sysdate
      when not matched then
        insert
          (tka.t_fa_halfyear_id,
           tka.company_id,
           tka.year,
           tka.halfyear,
           tka.factory_code,
           tka.factory_name,
           tka.category,
           tka.category_name,
           tka.average_delivery_money,
           tka.average_delivery_order_money,
           tka.create_id,
           tka.create_time)
        values
          (scmdata.f_get_uuid(),
           tkb.company_id,
           tkb.year,
           tkb.halfyear,
           tkb.factory_code,
           tkb.factory_name,
           tkb.category,
           tkb.category_name,
           tkb.delivery_money,
           tkb.delivery_order_money,
           'ADMIN',
           sysdate) ]';
      if t_type = 0 then
        v_sql := v_z1 || v_w1 || v_z2;
      elsif t_type = 1 then
        v_sql := v_z1 || v_w2 || v_z2;
      end if;
      execute immediate v_sql;
    end;
  
    /*只更新延期数量、延期金额字段*/
    begin
      v_z1 := q'[ merge into scmdata.t_factory_performance_halfyear tka
      using (  select t2.company_id,t2.supplier_company_name factory_name,t2.factory_code,t2.year,t2.halfyear,t2.category,t2.category_name,
        sum(t2.delivery_amount)delay_amount,sum(t2.delivery_money)delay_money
  from (select oh.company_id,sp2.supplier_company_name,t.factory_code,
               to_char(od.delivery_date, 'yyyy') year,decode(to_char(od.delivery_date, 'Q'),1,1,2,1,3,2,4,2)halfyear, 
               tdr.delivery_amount,pt.category,pt.category_name,
               (pt.fixed_price * tdr.delivery_amount) delivery_money
          from scmdata.t_ordered oh
         inner join scmdata.t_orders od
            on oh.company_id = od.company_id
           and oh.order_code = od.order_id
         inner join scmdata.t_production_progress t
            on t.company_id = od.company_id
           and t.order_id = od.order_id
           and t.goo_id = od.goo_id
         inner join scmdata.t_commodity_info cf
            on t.company_id = cf.company_id
           and t.goo_id = cf.goo_id
         inner join scmdata.t_supplier_info sp2
            on t.company_id = sp2.company_id
           and t.factory_code  = sp2.supplier_code
         inner join scmdata.t_delivery_record tdr
            on tdr.company_id = oh.company_id
           and tdr.order_code = oh.order_code
           and tdr.goo_id = cf.goo_id
          inner join scmdata.pt_ordered pt
            on pt.product_gress_code = tdr.order_code
           and pt.company_id = tdr.company_id
           and pt.factory_company_name  = sp2.supplier_company_name 
         inner join scmdata.sys_company_dept a
            on a.company_id = t.company_id
           and a.company_dept_id =t.responsible_dept
         where tdr.delivery_date > od.delivery_date
           and a.dept_name = '供应链管理部') t2  ]';
      v_w1 := q'[ where (t2.year ||halfyear ) <= pkg_kpipt_order.f_yearmonth ]';
      v_w2 := q'[ where (t2.year ||halfyear ) = pkg_kpipt_order.f_yearmonth ]';
      v_z2 := q'[ group by t2.company_id,t2.supplier_company_name,t2.factory_code,t2.category,t2.category_name,t2.year,t2.halfyear  ) tkb
      on (tka.company_id = tkb.company_id and tka.year = tkb.year and tka.halfyear = tkb.halfyear 
           and tka.factory_code = tkb.factory_code  and tka.category = tkb.category )
      when matched then
          update
             set tka.delay_amount = tkb.delay_amount,
                 tka.delay_money  = tkb.delay_money,
                 tka.factory_name = tkb.factory_name,
                 tka.update_id    = 'ADMIN',
                 tka.update_time  = sysdate
      when not matched then
          insert
            (tka.t_fa_halfyear_id,
             tka.company_id,
             tka.year,
             tka.halfyear,
             tka.factory_code,
             tka.factory_name,
             tka.category,
             tka.category_name,
             tka.delay_amount,
             tka.delay_money,
             tka.create_id,
             tka.create_time)
          values
            (scmdata.f_get_uuid(),
             tkb.company_id,
             tkb.year,
             tkb.halfyear,
             tkb.factory_code,
             tkb.factory_name,
             tkb.category,
             tkb.category_name,
             tkb.delay_amount,
             tkb.delay_money,
             'ADMIN',
             sysdate) ]';
      if t_type = 0 then
        v_sql := v_z1 || v_w1 || v_z2;
      elsif t_type = 1 then
        v_sql := v_z1 || v_w2 || v_z2;
      end if;
      execute immediate v_sql;
    end;
    /*QC模块*/
    /*只更新或者新增首查字段*/
    begin
      v_z1 := q'[ merge into scmdata.t_factory_performance_halfyear tka
      using ( select base.supplier factory_name,base.company_id, to_char(base.finish_time, 'yyyy')year, decode(to_char(base.finish_time, 'Q'),1,1,2,1,3,2,4,2) halfyear,
       base.factory_code,base.category,base.category_name,sum(base.order_money) qc_number,
       sum(case when base.last_qc_result = 'NORMAL_IS_QUALIFIED' then base.order_money end) qualified_number
  from (select k.order_id,k.company_id, k.supplier, min(k.finish_time) finish_time,k.factory_code,k.category,k.category_name,
               k.qc_check_node,k.last_qc_result,k.order_money 
          from (select o.order_id, o.company_id,si.supplier_company_name supplier, qc.finish_time, g.qc_check_node,pt.order_money ,
                       o.factory_code,pt.category,pt.category_name,
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
                   and exists (select 1 from scmdata.t_qc_check_rela_order a where a.orders_id = o.orders_id and a.qc_check_id = qc.qc_check_id)
                 inner join scmdata.t_commodity_info ci
                    on o.goo_id = ci.goo_id
                   and ci.company_id = o.company_id
                 inner join scmdata.t_supplier_info si
                    on si.supplier_code = o.factory_code
                   and si.company_id = oe.company_id
                 where g.qc_check_node = 'QC_FIRST_CHECK'
                   and qc.finish_time is not null) k
         group by k.order_id, k.company_id,k.supplier,k.factory_code,k.category,k.category_name,
                  k.qc_check_node, k.last_qc_result,k.order_money) base  ]';
      v_w1 := q'[ where (to_char(base.finish_time, 'yyyy') || decode(to_char(base.finish_time, 'Q'),1,1,2,1,3,2,4,2)) 
                      <= pkg_kpipt_order.f_yearmonth ]';
      v_w2 := q'[ where (to_char(base.finish_time, 'yyyy') || decode(to_char(base.finish_time, 'Q'),1,1,2,1,3,2,4,2)) 
                      = pkg_kpipt_order.f_yearmonth ]';
      v_z2 := q'[ group by base.supplier,base.company_id,base.factory_code,base.category,base.category_name,
         to_char(base.finish_time, 'yyyy'), decode(to_char(base.finish_time, 'Q'),1,1,2,1,3,2,4,2)) tkb
      on (tka.company_id = tkb.company_id and tka.year = tkb.year and tka.halfyear = tkb.halfyear 
           and tka.factory_code = tkb.factory_code  and tka.category = tkb.category )
      when matched then
        update
           set tka.qc_firstcheck_ordermoney      = tkb.qc_number,
               tka.qc_firstcheck_pass_ordermoney = tkb.qualified_number,
               tka.factory_name                  = tkb.factory_name,
               tka.update_id                     = 'ADMIN',
               tka.update_time                   = sysdate
      when not matched then
        insert
          (tka.t_fa_halfyear_id,
           tka.company_id,
           tka.year,
           tka.halfyear,
           tka.factory_code,
           tka.factory_name,
           tka.category,
           tka.category_name,
           tka.qc_firstcheck_ordermoney,
           tka.qc_firstcheck_pass_ordermoney,
           tka.create_id,
           tka.create_time)
        values
          (scmdata.f_get_uuid(),
           tkb.company_id,
           tkb.year,
           tkb.halfyear,
           tkb.factory_code,
           tkb.factory_name,
           tkb.category,
           tkb.category_name,
           tkb.qc_number,
           tkb.qualified_number,
           'ADMIN',
           sysdate)]';
      if t_type = 0 then
        v_sql := v_z1 || v_w1 || v_z2;
      elsif t_type = 1 then
        v_sql := v_z1 || v_w2 || v_z2;
      end if;
      execute immediate v_sql;
    end;
    /*QC模块*/
    /*只更新或者新增中查字段*/
    begin
      v_z1 := q'[ merge into scmdata.t_factory_performance_halfyear tka
      using ( select base.supplier factory_name,base.company_id, to_char(base.finish_time, 'yyyy')year, decode(to_char(base.finish_time, 'Q'),1,1,2,1,3,2,4,2) halfyear,
       base.factory_code,base.category,base.category_name,sum(base.order_money) qc_number,
       sum(case when base.last_qc_result = 'NORMAL_IS_QUALIFIED' then base.order_money end) qualified_number
  from (select k.order_id,k.company_id, k.supplier, min(k.finish_time) finish_time,k.factory_code,k.category,k.category_name,
               k.qc_check_node,k.last_qc_result,k.order_money 
          from (select o.order_id, o.company_id,si.supplier_company_name supplier, qc.finish_time, g.qc_check_node,pt.order_money ,
                       o.factory_code,pt.category,pt.category_name,
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
                   and exists (select 1 from scmdata.t_qc_check_rela_order a where a.orders_id = o.orders_id and a.qc_check_id = qc.qc_check_id)
                 inner join scmdata.t_commodity_info ci
                    on o.goo_id = ci.goo_id
                   and ci.company_id = o.company_id
                 inner join scmdata.t_supplier_info si
                    on si.supplier_code = o.factory_code
                   and si.company_id = oe.company_id
                 where g.qc_check_node = 'QC_MIDDLE_CHECK'
                   and qc.finish_time is not null) k
         group by k.order_id, k.company_id,k.supplier,k.factory_code,k.category,k.category_name,
                  k.qc_check_node, k.last_qc_result,k.order_money) base ]';
      v_w1 := q'[ where (to_char(base.finish_time, 'yyyy') || decode(to_char(base.finish_time, 'Q'),1,1,2,1,3,2,4,2)) 
                      <= pkg_kpipt_order.f_yearmonth ]';
      v_w2 := q'[ where (to_char(base.finish_time, 'yyyy') || decode(to_char(base.finish_time, 'Q'),1,1,2,1,3,2,4,2)) 
                      = pkg_kpipt_order.f_yearmonth ]';
      v_z2 := q'[ group by base.supplier,base.company_id,base.factory_code,base.category,base.category_name,
         to_char(base.finish_time, 'yyyy'), decode(to_char(base.finish_time, 'Q'),1,1,2,1,3,2,4,2) ) tkb
      on (tka.company_id = tkb.company_id and tka.year = tkb.year and tka.halfyear = tkb.halfyear 
           and tka.factory_code = tkb.factory_code  and tka.category = tkb.category )
      when matched then
        update
           set tka.qc_middlecheck_ordermoney      = tkb.qc_number,
               tka.qc_middlecheck_pass_ordermoney = tkb.qualified_number,
               tka.factory_name                   = tkb.factory_name,
               tka.update_id                      = 'ADMIN',
               tka.update_time                    = sysdate
      when not matched then
        insert
          (tka.t_fa_halfyear_id,
           tka.company_id,
           tka.year,
           tka.halfyear,
           tka.factory_code,
           tka.factory_name,
           tka.category,
           tka.category_name,
           tka.qc_middlecheck_ordermoney,
           tka.qc_middlecheck_pass_ordermoney,
           tka.create_id,
           tka.create_time)
        values
          (scmdata.f_get_uuid(),
           tkb.company_id,
           tkb.year,
           tkb.halfyear,
           tkb.factory_code,
           tkb.factory_name,
           tkb.category,
           tkb.category_name,
           tkb.qc_number,
           tkb.qualified_number,
           'ADMIN',
           sysdate)]';
      if t_type = 0 then
        v_sql := v_z1 || v_w1 || v_z2;
      elsif t_type = 1 then
        v_sql := v_z1 || v_w2 || v_z2;
      end if;
      execute immediate v_sql;
    end;
    /*QC模块*/
    /*只更新或者新增尾查字段*/
    begin
      v_z1 := q'[ merge into scmdata.t_factory_performance_halfyear tka
      using ( select base.supplier factory_name,base.company_id, to_char(base.finish_time, 'yyyy')year, decode(to_char(base.finish_time, 'Q'),1,1,2,1,3,2,4,2) halfyear,
       base.factory_code,base.category,base.category_name,sum(base.order_money) qc_number,
       sum(case when base.last_qc_result = 'NORMAL_IS_QUALIFIED' then base.order_money end) qualified_number
  from (select k.order_id,k.company_id, k.supplier, min(k.finish_time) finish_time,k.factory_code,k.category,k.category_name,
               k.qc_check_node,k.last_qc_result,k.order_money 
          from (select o.order_id, o.company_id,si.supplier_company_name supplier, qc.finish_time, g.qc_check_node,pt.order_money ,
                       o.factory_code,pt.category,pt.category_name,
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
                   and exists (select 1 from scmdata.t_qc_check_rela_order a where a.orders_id = o.orders_id and a.qc_check_id = qc.qc_check_id)
                 inner join scmdata.t_commodity_info ci
                    on o.goo_id = ci.goo_id
                   and ci.company_id = o.company_id
                 inner join scmdata.t_supplier_info si
                    on si.supplier_code = o.factory_code
                   and si.company_id = oe.company_id
                 where g.qc_check_node = 'QC_FINAL_CHECK'
                   and qc.finish_time is not null) k
         group by k.order_id, k.company_id,k.supplier,k.factory_code,k.category,k.category_name,
                  k.qc_check_node, k.last_qc_result,k.order_money) base  ]';
      v_w1 := q'[ where (to_char(base.finish_time, 'yyyy') || decode(to_char(base.finish_time, 'Q'),1,1,2,1,3,2,4,2)) 
                      <= pkg_kpipt_order.f_yearmonth ]';
      v_w2 := q'[ where (to_char(base.finish_time, 'yyyy') || decode(to_char(base.finish_time, 'Q'),1,1,2,1,3,2,4,2)) 
                      = pkg_kpipt_order.f_yearmonth ]';
      v_z2 := q'[ group by base.supplier,base.company_id,base.factory_code,base.category,base.category_name,
         to_char(base.finish_time, 'yyyy'), decode(to_char(base.finish_time, 'Q'),1,1,2,1,3,2,4,2) ) tkb
      on (tka.company_id = tkb.company_id and tka.year = tkb.year and tka.halfyear = tkb.halfyear 
           and tka.factory_code = tkb.factory_code  and tka.category = tkb.category )
      when matched then
        update
           set tka.qc_finalcheck_ordermoney      = tkb.qc_number,
               tka.qc_finalcheck_pass_ordermoney = tkb.qualified_number,
               tka.factory_name                  = tkb.factory_name,
               tka.update_id                     = 'ADMIN',
               tka.update_time                   = sysdate
      when not matched then
        insert
          (tka.t_fa_halfyear_id,
           tka.company_id,
           tka.year,
           tka.halfyear,
           tka.factory_code,
           tka.factory_name,
           tka.category,
           tka.category_name,
           tka.qc_finalcheck_ordermoney,
           tka.qc_finalcheck_pass_ordermoney,
           tka.create_id,
           tka.create_time)
        values
          (scmdata.f_get_uuid(),
           tkb.company_id,
           tkb.year,
           tkb.halfyear,
           tkb.factory_code,
           tkb.factory_name,
           tkb.category,
           tkb.category_name,
           tkb.qc_number,
           tkb.qualified_number,
           'ADMIN',
           sysdate)]';
      if t_type = 0 then
        v_sql := v_z1 || v_w1 || v_z2;
      elsif t_type = 1 then
        v_sql := v_z1 || v_w2 || v_z2;
      end if;
      execute immediate v_sql;
    end;

    /*只更新或者新增QA查货字段*/
    begin
      v_z1 := q'[ merge into scmdata.t_factory_performance_halfyear tka
      using (  select kt.year, kt.halfyear, kt.qafactory factory_name,kt.factory_code,kt.category,kt.category_name,
       kt.company_id,kt.pcome_amount, k3.np_amount
  from (select k1.year,k1.halfyear, k1.qafactory,k1.company_id,k1.factory_code,k1.category,k1.category_name,
               sum(k1.pcome_amount) pcome_amount
          from (select to_char(a.check_date, 'yyyy') year, decode(to_char(a.check_date, 'Q') ,1,1,2,1,3,2,4,2) halfyear,
                       a.qa_report_id,z.company_id, z.order_id,z.pcome_amount,
                       td.factory_code,t.supplier_company_name qafactory,tc.category,gd.group_dict_name category_name
                  from scmdata.t_qa_report a
                 inner join scmdata.t_qa_scope z
                    on a.qa_report_id = z.qa_report_id
                   and a.company_id = z.company_id
                inner join scmdata.t_orders td
                   on td.company_id = z.company_id
                  and td.order_id = z.order_id
                inner join scmdata.t_commodity_info tc
                   on tc.company_id = z.company_id
                  and tc.goo_id = z.goo_id
                inner join scmdata.sys_group_dict gd
                   on gd.group_dict_type = 'PRODUCT_TYPE'
                  and gd.group_dict_value = tc.category
                inner join scmdata.t_supplier_info t
                   on t.company_id = z.company_id
                  and t.supplier_code = td.factory_code
                 where a.status in ('N_ACF', 'R_ACF')) k1
         group by k1.year, k1.halfyear, k1.qafactory,k1.factory_code,k1.category,k1.category_name,k1.company_id) kt
  left join (select k2.year,k2.halfyear, k2.qafactory,k2.factory_code,k2.category,k2.category_name,k2.company_id,sum(k2.pcome_amount) np_amount
               from (select to_char(a.check_date, 'yyyy') year, decode(to_char(a.check_date, 'Q') ,1,1,2,1,3,2,4,2) halfyear, a.qa_report_id, z.company_id,z.order_id,z.pcome_amount,
                            td.factory_code,t.supplier_company_name qafactory,tc.category,gd.group_dict_name category_name                            
                       from scmdata.t_qa_report a
                      inner join scmdata.t_qa_scope z
                         on a.qa_report_id = z.qa_report_id
                        and a.company_id = z.company_id
                      inner join scmdata.t_orders td
                         on td.company_id = z.company_id
                        and td.order_id = z.order_id
                      inner join scmdata.t_commodity_info tc
                         on tc.company_id = z.company_id
                        and tc.goo_id = z.goo_id
                      inner join scmdata.sys_group_dict gd
                         on gd.group_dict_type = 'PRODUCT_TYPE'
                        and gd.group_dict_value = tc.category
                      inner join scmdata.t_supplier_info t
                         on t.company_id = z.company_id
                        and t.supplier_code = td.factory_code
                      where a.status in ('N_ACF', 'R_ACF')
                        and a.check_result = 'QU') k2
              group by k2.year, k2.halfyear, k2.qafactory,k2.factory_code,k2.category,k2.category_name,k2.company_id) k3
    on kt.year = k3.year
   and kt.halfyear = k3.halfyear
   and kt.factory_code = k3.factory_code
   and kt.category = k3.category
   and kt.company_id = k3.company_id  ]';
      v_w1 := q'[ where (kt.year || kt.halfyear) <= pkg_kpipt_order.f_yearmonth ) tkb ]';
      v_w2 := q'[ where (kt.year || kt.halfyear) = pkg_kpipt_order.f_yearmonth ) tkb ]';
      v_z2 := q'[ on (tka.company_id = tkb.company_id and tka.year = tkb.year and tka.halfyear = tkb.halfyear 
           and tka.factory_code = tkb.factory_code  and tka.category = tkb.category )
      when matched then
        update
           set tka.qa_check_amount      = tkb.pcome_amount,
               tka.qa_check_pass_amount = tkb.np_amount,
               tka.factory_name         = tkb.factory_name,
               tka.update_id            = 'ADMIN',
               tka.update_time          = sysdate
      when not matched then
        insert
          (tka.t_fa_halfyear_id,
           tka.company_id,
           tka.year,
           tka.halfyear,
           tka.factory_code,
           tka.factory_name,
           tka.category,
           tka.category_name,
           tka.qa_check_amount,
           tka.qa_check_pass_amount,
           tka.create_id,
           tka.create_time)
        values
          (scmdata.f_get_uuid(),
           tkb.company_id,
           tkb.year,
           tkb.halfyear,
           tkb.factory_code,
           tkb.factory_name,
           tkb.category,
           tkb.category_name,
           tkb.pcome_amount,
           tkb.np_amount,
           'ADMIN',
           sysdate) ]';
      if t_type = 0 then
        v_sql := v_z1 || v_w1 || v_z2;
      elsif t_type = 1 then
        v_sql := v_z1 || v_w2 || v_z2;
      end if;
      execute immediate v_sql;
    end;

    /*只更新或者新增异常金额、异常数量字段*/
    begin
      v_z1 := q'[ merge into scmdata.t_factory_performance_halfyear tka
      using ( select k.year,k.halfyear,k.factory_name,k.factory_code,k.company_id,k.category,k.category_name,
       sum(k.delay_amount)quality_deviant_amount ,sum(k.delay_amount*k.price)quality_deviant_money 
  from (select to_char(a.confirm_date, 'yyyy') year,
                decode(to_char(a.confirm_date, 'Q') ,1,1,2,1,3,2,4,2) halfyear ,
               a.company_id,
               a.delay_amount, --延期数量
               cf.price,
               od.factory_code,
               sp2.supplier_company_name factory_name,
               cf.category,
               gd_d.group_dict_name category_name
          from scmdata.t_ordered oh
         inner join scmdata.t_orders od
            on oh.company_id = od.company_id
           and oh.order_code = od.order_id
           and oh.order_status in ('OS01', 'OS02')
         inner join t_production_progress t
            on t.company_id = od.company_id
           and t.order_id = od.order_id
           and t.goo_id = od.goo_id
         inner join scmdata.t_commodity_info cf
            on t.company_id = cf.company_id
           and t.goo_id = cf.goo_id
         inner join scmdata.t_supplier_info sp2
            on od.company_id = sp2.company_id
           and od.factory_code = sp2.supplier_code
         inner join scmdata.t_abnormal a
            on t.company_id = a.company_id
           and t.order_id = a.order_id
           and t.goo_id = a.goo_id
           and a.progress_status = '02'
           and a.origin <> 'SC'
         inner join scmdata.sys_company_user sb
            on a.company_id = sb.company_id
           and a.confirm_id = sb.user_id
         inner join scmdata.sys_group_dict gd_d
            on gd_d.group_dict_type = 'PRODUCT_TYPE'
           and gd_d.group_dict_value = cf.category
         where oh.company_id = 'a972dd1ffe3b3a10e0533c281cac8fd7'
           and a.anomaly_class = 'AC_QUALITY')k ]';
      v_w1 := q'[ where (k.year || k.halfyear) <= pkg_kpipt_order.f_yearmonth  ]';
      v_w2 := q'[ where (k.year || k.halfyear) = pkg_kpipt_order.f_yearmonth  ]';
      v_z2 := q'[  group by k.year,k.halfyear,k.factory_name,k.factory_code,k.company_id, k.category,k.category_name) tkb
      on (tka.company_id = tkb.company_id and tka.year = tkb.year and tka.halfyear = tkb.halfyear
              and tka.factory_code = tkb.factory_code and tka.category = tkb.category)
      when matched then
        update
           set tka.quality_deviant_amount = tkb.quality_deviant_amount,
               tka.quality_deviant_money  = tkb.quality_deviant_money,
               tka.factory_name           = tkb.factory_name,
               tka.update_id              = 'ADMIN',
               tka.update_time            = sysdate
      when not matched then
        insert
          (tka.t_fa_halfyear_id,
           tka.company_id,
           tka.year,
           tka.halfyear,
           tka.factory_code,
           tka.factory_name,
           tka.category,
           tka.category_name,
           tka.quality_deviant_amount,
           tka.quality_deviant_money,
           tka.create_id,
           tka.create_time)
        values
          (scmdata.f_get_uuid(),
           tkb.company_id,
           tkb.year,
           tkb.halfyear,
           tkb.factory_code,
           tkb.factory_name,
           tkb.category,
           tkb.category_name,
           tkb.quality_deviant_amount,
           tkb.quality_deviant_money,
           'ADMIN',
           sysdate)]';
      if t_type = 0 then
        v_sql := v_z1 || v_w1 || v_z2;
      elsif t_type = 1 then
        v_sql := v_z1 || v_w2 || v_z2;
      end if;
      execute immediate v_sql;
    end;

  end p_factory_performance_halfyear;

  /*-----------------------------------------------------------------  
     生成工厂绩效盘点报表数据表
         用途：
            供应商绩效盘点表（生成工厂维度）——按年度更新数据表
         用于：
            供应商绩效盘点报表——生成工厂tab页      
         更新规则：
             使用oracle数据库定时任务实现——每年度只更新上个年度的数据
          入参（t_type 只能传入 0 或者 1 ）：
              t_type := 0 更新全部历史数据
              t_type := 1 只更新上一年的数据                
        版本:
            2022-03-24 
     2022-04-08 因数据有问题，修改订单满足率、前20%订单满足率分子的取数全部来源于底层订单交期表
     2022-04-11 因底层订单交期表更改了责任部门，订单满足率、前20%订单满足率分子的责任部门全部修改
     2022-05-19 因需求变更，（1）统计维度由供应商修改为生产工厂+分类，
                            （2）修改了订单满足率、补货平均交期、延货金额、延货数量取值范围，
                            （3）新增异常金额、异常数量
  -------------------------------------------------------------------*/
  procedure p_factory_performance_year(t_type number) is
    v_sql clob;
    v_z1  clob;
    v_z2  clob;
    v_w1  clob;
    v_w2  clob;
    /*只更新或者新增下单数量、下单金额字段*/
  begin
    v_z1 := q'[ merge into scmdata.t_factory_performance_year tka
    using (select pt.company_id,to_char(pt.order_create_date, 'yyyy') year,
                  pt.category,pt.category_name,pt.factory_code, pt.factory_company_name factory_name,
                  sum(pt.order_amount) order_amount,sum(pt.order_money) order_money
  from scmdata.pt_ordered pt 
  inner join scmdata.t_supplier_info t 
     on t.company_id = pt.company_id 
    and t.supplier_code = pt.factory_code ]';
    v_w1 := q'[ where to_char(pt.order_create_date, 'yyyy') < to_char(sysdate,'yyyy') ]';
    v_w2 := q'[ where to_char(pt.order_create_date, 'yyyy') = to_char(sysdate,'yyyy')-1 ]';
    v_z2 := q'[ group by pt.company_id, to_char(pt.order_create_date, 'yyyy'), 
                         pt.category,pt.category_name,pt.factory_code,pt.factory_company_name) tkb
      on (tka.company_id = tkb.company_id and tka.year = tkb.year  
           and tka.factory_code = tkb.factory_code  and tka.category = tkb.category )
      when matched then
        update
           set tka.order_amount = tkb.order_amount,
               tka.order_money  = tkb.order_money,
               tka.factory_name = tkb.factory_name,
               tka.update_id    = 'ADMIN',
               tka.update_time  = sysdate
      when not matched then
        insert
          (tka.t_fa_year_id,
           tka.company_id,
           tka.year,
           tka.factory_code,
           tka.factory_name,
           tka.category,
           tka.category_name,
           tka.order_amount,
           tka.order_money,
           tka.create_id,
           tka.create_time)
        values
          (scmdata.f_get_uuid(),
           tkb.company_id,
           tkb.year,
           tkb.factory_code,
           tkb.factory_name,
           tkb.category,
           tkb.category_name,
           tkb.order_amount,
           tkb.order_money,
           'ADMIN',
           sysdate)]';
  
    if t_type = 0 then
      v_sql := v_z1 || v_w1 || v_z2;
    elsif t_type = 1 then
      v_sql := v_z1 || v_w2 || v_z2;
    end if;
    execute immediate v_sql;
    /*只更新或者新增交货数量、交货金额字段*/
    begin
      v_z1 := q'[ merge into scmdata.t_factory_performance_year tka1
      using (select k.company_id,k.supplier_company_name factory_name,k.factory_code,k.category,k.category_name,
                    k.year,sum(delivery_amount)delivery_amount,sum(k.delivery_money)delivery_money
  from (select oh.company_id, sp2.supplier_company_name, to_char(tdr.delivery_date, 'yyyy') year,
               pt.factory_code,pt.category,pt.category_name,tdr.delivery_amount,(pt.fixed_price * tdr.delivery_amount) delivery_money
          from scmdata.t_ordered oh
         inner join scmdata.t_orders od
            on oh.company_id = od.company_id
           and oh.order_code = od.order_id
         inner join scmdata.t_production_progress t
            on t.company_id = od.company_id
           and t.order_id = od.order_id
           and t.goo_id = od.goo_id
         inner join scmdata.t_commodity_info cf
            on t.company_id = cf.company_id
           and t.goo_id = cf.goo_id
         inner join scmdata.t_supplier_info sp2
            on t.company_id = sp2.company_id
           and t.factory_code = sp2.supplier_code
         inner join scmdata.t_delivery_record tdr
            on tdr.company_id = oh.company_id
           and tdr.order_code = oh.order_code
           and tdr.goo_id = cf.goo_id
         inner join scmdata.pt_ordered pt
            on pt.product_gress_code = tdr.order_code
           and pt.company_id = tdr.company_id
           and pt.factory_company_name= sp2.supplier_company_name) k ]';
      v_w1 := q'[ where k.year < to_char(sysdate,'yyyy')]';
      v_w2 := q'[ where k.year = to_char(sysdate,'yyyy')-1]';
      v_z2 := q'[ group by k.company_id,k.supplier_company_name,k.factory_code,k.category,k.category_name,k.year ) tkb1
          on (tka1.company_id = tkb1.company_id and tka1.year = tkb1.year 
           and tka1.factory_code = tkb1.factory_code  and tka1.category = tkb1.category )
          when matched then
            update
               set tka1.delivery_amount = tkb1.delivery_amount,
                   tka1.delivery_money  = tkb1.delivery_money,
                   tka1.factory_name    = tkb1.factory_name,
                   tka1.update_id       = 'ADMIN',
                   tka1.update_time     = sysdate
          when not matched then
           insert
             (tka1.t_fa_year_id,
              tka1.company_id,
              tka1.year,
              tka1.factory_code,
              tka1.factory_name,
              tka1.category,
              tka1.category_name,
              tka1.delivery_amount,
              tka1.delivery_money,
              tka1.create_id,
              tka1.create_time)
           values
             (scmdata.f_get_uuid(),
              tkb1.company_id,
              tkb1.year,
              tkb1.factory_code,
              tkb1.factory_name,
              tkb1.category,
              tkb1.category_name,
              tkb1.delivery_amount,
              tkb1.delivery_money,
              'ADMIN',
              sysdate) ]';
      if t_type = 0 then
        v_sql := v_z1 || v_w1 || v_z2;
      elsif t_type = 1 then
        v_sql := v_z1 || v_w2 || v_z2;
      end if;
      execute immediate v_sql;
    end;
    /*只更新或者新增订单满足率字段*/
    begin
      v_z1 := q'[  merge into scmdata.t_factory_performance_year tka
      using ( select t1.company_id,t1.factory_company_name factory_name,t1.factory_code,t1.category,t1.category_name,
            t1.year, t1.order_money,t2.sho_order_money
               from (select pt.company_id, pt.factory_company_name,pt.factory_code,pt.category,
                            pt.category_name, pt.year,sum(pt.order_money) order_money
                       from scmdata.pt_ordered pt
                      inner join scmdata.t_supplier_info t
                         on t.company_id = pt.company_id
                        and t.supplier_code = pt.factory_code
                      group by pt.company_id, pt.factory_company_name, pt.year,pt.factory_code,pt.category,pt.category_name) t1
               left join (select tp.company_id, tp.factory_company_name,tp.factory_code,tp.category,tp.category_name,
                                 tp.year,sum(tp.sum_money) sho_order_money
                           from (select t3.company_id,t3.factory_company_name,t3.factory_code,t3.category,t3.category_name,
                                        t3.year,t3.satisfy_money sum_money
                                   from scmdata.pt_ordered t3
                                  inner join scmdata.t_supplier_info t
                                     on t.company_id = t3.company_id
                                    and t.inside_supplier_code = t3.supplier_code 
                                   union all
                                 select t3a.company_id, t3a.factory_company_name,t3a.factory_code, t3a.category,t3a.category_name,
                                        t3a.year,(t3a.order_money  - t3a.satisfy_money ) sum_money
                                   from scmdata.pt_ordered t3a
                                  inner join scmdata.sys_company_dept a
                                     on a.company_id = t3a.company_id
                                    and a.company_dept_id = t3a.responsible_dept
                                    and a.pause = 0
                                  where (a.dept_name like '%物流部%'or a.dept_name like '%品类部%'
                             or a.dept_name like '%事业部%' or a.dept_name = '无')) tp
                          group by tp.company_id, tp.factory_company_name,tp.factory_code,tp.year,tp.category,tp.category_name) t2
                 on t2.company_id = t1.company_id
                and t2.factory_code = t1.factory_code
                and t2.category = t1.category
                and t2.year = t1.year ]';
      v_w1 := q'[ where t1.year < to_char(sysdate,'yyyy')) tkb]';
      v_w2 := q'[ where t1.year = to_char(sysdate,'yyyy')-1 ) tkb]';
      v_z2 := q'[  on (tka.company_id = tkb.company_id and tka.year = tkb.year 
           and tka.factory_code = tkb.factory_code  and tka.category = tkb.category )
          when matched then
            update
               set tka.fillrate_order_money     = tkb.order_money,
                   tka.fillrate_sho_order_money = tkb.sho_order_money,
                   tka.factory_name             = tkb.factory_name,
                   tka.update_id                = 'ADMIN',
                   tka.update_time              = sysdate
          when not matched then
             insert
               (tka.t_fa_year_id,
                tka.company_id,
                tka.year,
                tka.factory_code,
                tka.factory_name,
                tka.category,
                tka.category_name,
                tka.fillrate_order_money,
                tka.fillrate_sho_order_money,
                tka.create_id,
                tka.create_time)
             values
               (scmdata.f_get_uuid(),
                tkb.company_id,
                tkb.year,
                tkb.factory_code,
                tkb.factory_name,
                tkb.category,
                tkb.category_name,
                tkb.order_money,
                tkb.sho_order_money,
                'ADMIN',
                sysdate) ]';
      if t_type = 0 then
        v_sql := v_z1 || v_w1 || v_z2;
      elsif t_type = 1 then
        v_sql := v_z1 || v_w2 || v_z2;
      end if;
      execute immediate v_sql;
    end;
  
    /*只更新或者新增补货平均交期字段*/
    begin
      v_z1 := q'[ merge into scmdata.t_factory_performance_year tka
      using (select t1.company_id, t1.year, t1.factory_name,t1.factory_code,
       t1.category,t1.category_name, sum(t1.sum1_money) delivery_money,sum(t1.sum1_date*t1.sum1_money) delivery_order_money
              from (select t5.company_id,t5.factory_company_name factory_name,t5.factory_code,
                          to_char(tba.delivery_origin_time,'yyyy')year, t5.category, t5.category_name,
                     (to_date(to_char(tba.delivery_origin_time , 'yyyy/mm/dd'), 'yyyy/mm/dd') -
                     to_date(to_char(t5.order_create_date, 'yyyy/mm/dd'), 'yyyy/mm/dd')) sum1_date,
                     (t5.fixed_price * tba.delivery_amount) sum1_money
                from scmdata.pt_ordered t5
                inner join scmdata.t_delivery_record tba
                  on t5.product_gress_code = tba.order_code
                 and t5.company_id = tba.company_id
                inner join scmdata.t_ordered tor
                   on tor.company_id = tba.company_id
                  and tor.order_code = tba.order_code
                inner join scmdata.t_commodity_info tb
                  on t5.goo_id = tb.rela_goo_id
                 and tb.goo_id = tba.goo_id
                 and t5.company_id = tb.company_id
               where t5.is_first_order = 0
                 and tor.is_product_order = 1)t1  ]';
      v_w1 := q'[ where t1.year < to_char(sysdate,'yyyy')]';
      v_w2 := q'[ where t1.year = to_char(sysdate,'yyyy')-1 ]';
      v_z2 := q'[ group by t1.company_id, t1.year, t1.factory_name,t1.factory_code,t1.category, t1.category_name ) tkb
          on (tka.company_id = tkb.company_id and tka.year = tkb.year 
           and tka.factory_code = tkb.factory_code  and tka.category = tkb.category )
          when matched then
            update
               set tka.average_delivery_money       = tkb.delivery_money,
                   tka.average_delivery_order_money = tkb.delivery_order_money,
                   tka.factory_name                 = tkb.factory_name,
                   tka.update_id                    = 'ADMIN',
                   tka.update_time                  = sysdate
          when not matched then
             insert
               (tka.t_fa_year_id,
                tka.company_id,
                tka.year,
                tka.factory_code,
                tka.factory_name,
                tka.category,
                tka.category_name,
                tka.average_delivery_money,
                tka.average_delivery_order_money,
                tka.create_id,
                tka.create_time)
             values
               (scmdata.f_get_uuid(),
                tkb.company_id,
                tkb.year,
                tkb.factory_code,
                tkb.factory_name,
                tkb.category,
                tkb.category_name,
                tkb.delivery_money,
                tkb.delivery_order_money,
                'ADMIN',
                sysdate) ]';
      if t_type = 0 then
        v_sql := v_z1 || v_w1 || v_z2;
      elsif t_type = 1 then
        v_sql := v_z1 || v_w2 || v_z2;
      end if;
      execute immediate v_sql;
    end;
  
    /*只更新或者新增延期数量、延期金额字段*/
    begin
      v_z1 := q'[ merge into scmdata.t_factory_performance_year tka
      using (  select t2.company_id,t2.supplier_company_name factory_name,t2.factory_code,t2.year,t2.category,t2.category_name,
        sum(t2.delivery_amount)delay_amount,sum(t2.delivery_money)delay_money
  from (select oh.company_id,sp2.supplier_company_name,t.factory_code,
               to_char(od.delivery_date, 'yyyy') year,
               tdr.delivery_amount,pt.category,pt.category_name,
               (pt.fixed_price * tdr.delivery_amount) delivery_money
          from scmdata.t_ordered oh
         inner join scmdata.t_orders od
            on oh.company_id = od.company_id
           and oh.order_code = od.order_id
         inner join scmdata.t_production_progress t
            on t.company_id = od.company_id
           and t.order_id = od.order_id
           and t.goo_id = od.goo_id
         inner join scmdata.t_commodity_info cf
            on t.company_id = cf.company_id
           and t.goo_id = cf.goo_id
         inner join scmdata.t_supplier_info sp2
            on t.company_id = sp2.company_id
           and t.factory_code  = sp2.supplier_code
         inner join scmdata.t_delivery_record tdr
            on tdr.company_id = oh.company_id
           and tdr.order_code = oh.order_code
           and tdr.goo_id = cf.goo_id
          inner join scmdata.pt_ordered pt
            on pt.product_gress_code = tdr.order_code
           and pt.company_id = tdr.company_id
           and pt.factory_company_name  = sp2.supplier_company_name 
         inner join scmdata.sys_company_dept a
            on a.company_id = t.company_id
           and a.company_dept_id =t.responsible_dept
         where tdr.delivery_date > od.delivery_date
           and a.dept_name = '供应链管理部') t2   ]';
      v_w1 := q'[ where t2.year < to_char(sysdate,'yyyy')]';
      v_w2 := q'[ where t2.year = to_char(sysdate,'yyyy')-1]';
      v_z2 := q'[ group by t2.company_id,t2.supplier_company_name,t2.factory_code,t2.category,t2.category_name,t2.year ) tkb
          on (tka.company_id = tkb.company_id and tka.year = tkb.year  
           and tka.factory_code = tkb.factory_code  and tka.category = tkb.category )
          when matched then
            update
               set tka.delay_amount = tkb.delay_amount,
                   tka.delay_money  = tkb.delay_money,
                   tka.factory_name = tkb.factory_name,
                   tka.update_id    = 'ADMIN',
                   tka.update_time  = sysdate
          when not matched then
             insert
               (tka.t_fa_year_id,
                tka.company_id,
                tka.year,
                tka.factory_code,
                tka.factory_name,
                tka.category,
                tka.category_name,
                tka.delay_amount,
                tka.delay_money,
                tka.create_id,
                tka.create_time)
             values
               (scmdata.f_get_uuid(),
                tkb.company_id,
                tkb.year,
                tkb.factory_code,
                tkb.factory_name,
                tkb.category,
                tkb.category_name,
                tkb.delay_amount,
                tkb.delay_money,
                'ADMIN',
                sysdate) ]';
      if t_type = 0 then
        v_sql := v_z1 || v_w1 || v_z2;
      elsif t_type = 1 then
        v_sql := v_z1 || v_w2 || v_z2;
      end if;
      execute immediate v_sql;
    end;
    /*QC模块*/
    /*只更新或者新增qc首查字段*/
    begin
      v_z1 := q'[ merge into scmdata.t_factory_performance_year tka
      using ( select base.supplier factory_name,base.company_id, to_char(base.finish_time, 'yyyy')year, 
       base.factory_code,base.category,base.category_name,sum(base.order_money) qc_number,
       sum(case when base.last_qc_result = 'NORMAL_IS_QUALIFIED' then base.order_money end) qualified_number
  from (select k.order_id,k.company_id, k.supplier, min(k.finish_time) finish_time,k.factory_code,k.category,k.category_name,
               k.qc_check_node,k.last_qc_result,k.order_money 
          from (select o.order_id, o.company_id,si.supplier_company_name supplier, qc.finish_time, g.qc_check_node,pt.order_money ,
                       o.factory_code,pt.category,pt.category_name,
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
                   and exists (select 1 from scmdata.t_qc_check_rela_order a where a.orders_id = o.orders_id and a.qc_check_id = qc.qc_check_id)
                 inner join scmdata.t_commodity_info ci
                    on o.goo_id = ci.goo_id
                   and ci.company_id = o.company_id
                 inner join scmdata.t_supplier_info si
                    on si.supplier_code = o.factory_code
                   and si.company_id = oe.company_id
                 where g.qc_check_node = 'QC_FIRST_CHECK'
                   and qc.finish_time is not null) k
         group by k.order_id, k.company_id,k.supplier,k.factory_code,k.category,k.category_name,
                  k.qc_check_node, k.last_qc_result,k.order_money) base  ]';
      v_w1 := q'[  where to_char(base.finish_time, 'yyyy') < to_char(sysdate,'yyyy')]';
      v_w2 := q'[  where to_char(base.finish_time, 'yyyy') = to_char(sysdate,'yyyy')-1 ]';
      v_z2 := q'[ group by base.supplier,base.company_id,base.factory_code,base.category,base.category_name,
         to_char(base.finish_time, 'yyyy') ) tkb
      on (tka.company_id = tkb.company_id and tka.year = tkb.year 
           and tka.factory_code = tkb.factory_code  and tka.category = tkb.category )
      when matched then
        update
           set tka.qc_firstcheck_ordermoney      = tkb.qc_number,
               tka.qc_firstcheck_pass_ordermoney = tkb.qualified_number,
               tka.factory_name                  = tkb.factory_name,
               tka.update_id                     = 'ADMIN',
               tka.update_time                   = sysdate
      when not matched then
        insert
          (tka.t_fa_year_id,
           tka.company_id,
           tka.year,
           tka.factory_code,
           tka.factory_name,
           tka.category,
           tka.category_name,
           tka.qc_firstcheck_ordermoney,
           tka.qc_firstcheck_pass_ordermoney,
           tka.create_id,
           tka.create_time)
        values
          (scmdata.f_get_uuid(),
           tkb.company_id,
           tkb.year,
           tkb.factory_code,
           tkb.factory_name,
           tkb.category,
           tkb.category_name,
           tkb.qc_number,
           tkb.qualified_number,
           'ADMIN',
           sysdate)]';
      if t_type = 0 then
        v_sql := v_z1 || v_w1 || v_z2;
      elsif t_type = 1 then
        v_sql := v_z1 || v_w2 || v_z2;
      end if;
      execute immediate v_sql;
    end;
    /*QC模块*/
    /*只更新或者新增qc中查字段*/
    begin
      v_z1 := q'[ merge into scmdata.t_factory_performance_year tka
      using ( select base.supplier factory_name,base.company_id, to_char(base.finish_time, 'yyyy')year, 
       base.factory_code,base.category,base.category_name,sum(base.order_money) qc_number,
       sum(case when base.last_qc_result = 'NORMAL_IS_QUALIFIED' then base.order_money end) qualified_number
  from (select k.order_id,k.company_id, k.supplier, min(k.finish_time) finish_time,k.factory_code,k.category,k.category_name,
               k.qc_check_node,k.last_qc_result,k.order_money 
          from (select o.order_id, o.company_id,si.supplier_company_name supplier, qc.finish_time, g.qc_check_node,pt.order_money ,
                       o.factory_code,pt.category,pt.category_name,
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
                   and exists (select 1 from scmdata.t_qc_check_rela_order a where a.orders_id = o.orders_id and a.qc_check_id = qc.qc_check_id)
                 inner join scmdata.t_commodity_info ci
                    on o.goo_id = ci.goo_id
                   and ci.company_id = o.company_id
                 inner join scmdata.t_supplier_info si
                    on si.supplier_code = o.factory_code
                   and si.company_id = oe.company_id
                 where g.qc_check_node = 'QC_MIDDLE_CHECK'
                   and qc.finish_time is not null) k
         group by k.order_id, k.company_id,k.supplier,k.factory_code,k.category,k.category_name,
                  k.qc_check_node, k.last_qc_result,k.order_money) base  ]';
      v_w1 := q'[  where to_char(base.finish_time, 'yyyy') < to_char(sysdate,'yyyy')]';
      v_w2 := q'[  where to_char(base.finish_time, 'yyyy') = to_char(sysdate,'yyyy')-1 ]';
      v_z2 := q'[  group by base.supplier,base.company_id,base.factory_code,base.category,base.category_name,
         to_char(base.finish_time, 'yyyy') ) tkb
      on (tka.company_id = tkb.company_id and tka.year = tkb.year  
           and tka.factory_code = tkb.factory_code  and tka.category = tkb.category )
      when matched then
        update
           set tka.qc_middlecheck_ordermoney      = tkb.qc_number,
               tka.qc_middlecheck_pass_ordermoney = tkb.qualified_number,
               tka.factory_name                   = tkb.factory_name,
               tka.update_id                      = 'ADMIN',
               tka.update_time                    = sysdate
      when not matched then
        insert
          (tka.t_fa_year_id,
           tka.company_id,
           tka.year,
           tka.factory_code,
           tka.factory_name,
           tka.category,
           tka.category_name,
           tka.qc_middlecheck_ordermoney,
           tka.qc_middlecheck_pass_ordermoney,
           tka.create_id,
           tka.create_time)
        values
          (scmdata.f_get_uuid(),
           tkb.company_id,
           tkb.year,
           tkb.factory_code,
           tkb.factory_name,
           tkb.category,
           tkb.category_name,
           tkb.qc_number,
           tkb.qualified_number,
           'ADMIN',
           sysdate)]';
      if t_type = 0 then
        v_sql := v_z1 || v_w1 || v_z2;
      elsif t_type = 1 then
        v_sql := v_z1 || v_w2 || v_z2;
      end if;
      execute immediate v_sql;
    end;
    /*QC模块*/
    /*只更新或者新增qc尾查字段*/
    begin
      v_z1 := q'[ merge into scmdata.t_factory_performance_year tka
      using ( select base.supplier factory_name,base.company_id, to_char(base.finish_time, 'yyyy')year, 
       base.factory_code,base.category,base.category_name,sum(base.order_money) qc_number,
       sum(case when base.last_qc_result = 'NORMAL_IS_QUALIFIED' then base.order_money end) qualified_number
  from (select k.order_id,k.company_id, k.supplier, min(k.finish_time) finish_time,k.factory_code,k.category,k.category_name,
               k.qc_check_node,k.last_qc_result,k.order_money 
          from (select o.order_id, o.company_id,si.supplier_company_name supplier, qc.finish_time, g.qc_check_node,pt.order_money ,
                       o.factory_code,pt.category,pt.category_name,
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
                   and exists (select 1 from scmdata.t_qc_check_rela_order a where a.orders_id = o.orders_id and a.qc_check_id = qc.qc_check_id)
                 inner join scmdata.t_commodity_info ci
                    on o.goo_id = ci.goo_id
                   and ci.company_id = o.company_id
                 inner join scmdata.t_supplier_info si
                    on si.supplier_code = o.factory_code
                   and si.company_id = oe.company_id
                 where g.qc_check_node = 'QC_FINAL_CHECK'
                   and qc.finish_time is not null) k
         group by k.order_id, k.company_id,k.supplier,k.factory_code,k.category,k.category_name,
                  k.qc_check_node, k.last_qc_result,k.order_money) base  ]';
      v_w1 := q'[  where to_char(base.finish_time, 'yyyy') < to_char(sysdate,'yyyy')]';
      v_w2 := q'[  where to_char(base.finish_time, 'yyyy') = to_char(sysdate,'yyyy')-1 ]';
      v_z2 := q'[  group by base.supplier,base.company_id,base.factory_code,base.category,base.category_name,
         to_char(base.finish_time, 'yyyy') ) tkb
      on (tka.company_id = tkb.company_id and tka.year = tkb.year 
           and tka.factory_code = tkb.factory_code  and tka.category = tkb.category )
      when matched then
        update
           set tka.qc_finalcheck_ordermoney      = tkb.qc_number,
               tka.qc_finalcheck_pass_ordermoney = tkb.qualified_number,
               tka.factory_name                  = tkb.factory_name,
               tka.update_id                     = 'ADMIN',
               tka.update_time                   = sysdate
      when not matched then
        insert
          (tka.t_fa_year_id,
           tka.company_id,
           tka.year,
           tka.factory_code,
           tka.factory_name,
           tka.category,
           tka.category_name,
           tka.qc_finalcheck_ordermoney,
           tka.qc_finalcheck_pass_ordermoney,
           tka.create_id,
           tka.create_time)
        values
          (scmdata.f_get_uuid(),
           tkb.company_id,
           tkb.year,
           tkb.factory_code,
           tkb.factory_name,
           tkb.category,
           tkb.category_name,
           tkb.qc_number,
           tkb.qualified_number,
           'ADMIN',
           sysdate)]';
      if t_type = 0 then
        v_sql := v_z1 || v_w1 || v_z2;
      elsif t_type = 1 then
        v_sql := v_z1 || v_w2 || v_z2;
      end if;
      execute immediate v_sql;
    end;
    /*只更新或者新增QA查货字段*/
    begin
      v_z1 := q'[  merge into scmdata.t_factory_performance_year tka
      using (  select kt.year, kt.qafactory factory_name,kt.factory_code,kt.category,kt.category_name,
       kt.company_id,kt.pcome_amount, k3.np_amount
  from (select k1.year, k1.qafactory,k1.company_id,k1.factory_code,k1.category,k1.category_name,
               sum(k1.pcome_amount) pcome_amount
          from (select to_char(a.check_date, 'yyyy') year, 
                       a.qa_report_id,z.company_id, z.order_id,z.pcome_amount,
                       td.factory_code,t.supplier_company_name qafactory,tc.category,gd.group_dict_name category_name
                  from scmdata.t_qa_report a
                 inner join scmdata.t_qa_scope z
                    on a.qa_report_id = z.qa_report_id
                   and a.company_id = z.company_id
                inner join scmdata.t_orders td
                   on td.company_id = z.company_id
                  and td.order_id = z.order_id
                inner join scmdata.t_commodity_info tc
                   on tc.company_id = z.company_id
                  and tc.goo_id = z.goo_id
                inner join scmdata.sys_group_dict gd
                   on gd.group_dict_type = 'PRODUCT_TYPE'
                  and gd.group_dict_value = tc.category
                inner join scmdata.t_supplier_info t
                   on t.company_id = z.company_id
                  and t.supplier_code = td.factory_code
                 where a.status in ('N_ACF', 'R_ACF')) k1
         group by k1.year,  k1.qafactory,k1.factory_code,k1.category,k1.category_name,k1.company_id) kt
  left join (select k2.year, k2.qafactory,k2.factory_code,k2.category,k2.category_name,k2.company_id,sum(k2.pcome_amount) np_amount
               from (select to_char(a.check_date, 'yyyy') year,  a.qa_report_id, z.company_id,z.order_id,z.pcome_amount,
                            td.factory_code,t.supplier_company_name qafactory,tc.category,gd.group_dict_name category_name                            
                       from scmdata.t_qa_report a
                      inner join scmdata.t_qa_scope z
                         on a.qa_report_id = z.qa_report_id
                        and a.company_id = z.company_id
                      inner join scmdata.t_orders td
                         on td.company_id = z.company_id
                        and td.order_id = z.order_id
                      inner join scmdata.t_commodity_info tc
                         on tc.company_id = z.company_id
                        and tc.goo_id = z.goo_id
                      inner join scmdata.sys_group_dict gd
                         on gd.group_dict_type = 'PRODUCT_TYPE'
                        and gd.group_dict_value = tc.category
                      inner join scmdata.t_supplier_info t
                         on t.company_id = z.company_id
                        and t.supplier_code = td.factory_code
                      where a.status in ('N_ACF', 'R_ACF')
                        and a.check_result = 'QU') k2
              group by k2.year,  k2.qafactory,k2.factory_code,k2.category,k2.category_name,k2.company_id) k3
    on kt.year = k3.year
   and kt.factory_code = k3.factory_code
   and kt.category = k3.category
   and kt.company_id = k3.company_id  ]';
      /*更新全部历史数据*/
      v_w1 := q'[  where kt.year < to_char(sysdate,'yyyy')) tkb]';
      /*只更新上一年数据*/
      v_w2 := q'[  where kt.year = to_char(sysdate,'yyyy')-1) tkb]';
      v_z2 := q'[  on (tka.company_id = tkb.company_id and tka.year = tkb.year 
           and tka.factory_code = tkb.factory_code  and tka.category = tkb.category )
          when matched then
            update
               set tka.qa_check_amount      = tkb.pcome_amount,
                   tka.qa_check_pass_amount = tkb.np_amount,
                   tka.factory_name         = tkb.factory_name,
                   tka.update_id            = 'ADMIN',
                   tka.update_time          = sysdate
          when not matched then
             insert
               (tka.t_fa_year_id,
                tka.company_id,
                tka.year,
                tka.factory_code,
                tka.factory_name,
                tka.category,
                tka.category_name,
                tka.qa_check_amount,
                tka.qa_check_pass_amount,
                tka.create_id,
                tka.create_time)
             values
               (scmdata.f_get_uuid(),
                tkb.company_id,
                tkb.year,
                tkb.factory_code,
                tkb.factory_name,
                tkb.category,
                tkb.category_name,
                tkb.pcome_amount,
                tkb.np_amount,
                'ADMIN',
                sysdate) ]';
      if t_type = 0 then
        v_sql := v_z1 || v_w1 || v_z2;
      elsif t_type = 1 then
        v_sql := v_z1 || v_w2 || v_z2;
      end if;
      execute immediate v_sql;
    end;
    /*只更新或者新增异常金额、异常数量字段*/
    begin
      v_z1 := q'[ merge into scmdata.t_factory_performance_year tka
      using ( select k.year,k.factory_name,k.factory_code,k.company_id,k.category,k.category_name,
       sum(k.delay_amount)quality_deviant_amount ,sum(k.delay_amount*k.price)quality_deviant_money 
  from (select to_char(a.confirm_date, 'yyyy') year,
               a.company_id,
               a.delay_amount, --延期数量
               cf.price,
               od.factory_code,
               sp2.supplier_company_name factory_name,
               cf.category,
               gd_d.group_dict_name category_name
          from scmdata.t_ordered oh
         inner join scmdata.t_orders od
            on oh.company_id = od.company_id
           and oh.order_code = od.order_id
           and oh.order_status in ('OS01', 'OS02')
         inner join t_production_progress t
            on t.company_id = od.company_id
           and t.order_id = od.order_id
           and t.goo_id = od.goo_id
         inner join scmdata.t_commodity_info cf
            on t.company_id = cf.company_id
           and t.goo_id = cf.goo_id
         inner join scmdata.t_supplier_info sp2
            on od.company_id = sp2.company_id
           and od.factory_code = sp2.supplier_code
         inner join scmdata.t_abnormal a
            on t.company_id = a.company_id
           and t.order_id = a.order_id
           and t.goo_id = a.goo_id
           and a.progress_status = '02'
           and a.origin <> 'SC'
         inner join scmdata.sys_company_user sb
            on a.company_id = sb.company_id
           and a.confirm_id = sb.user_id
         inner join scmdata.sys_group_dict gd_d
            on gd_d.group_dict_type = 'PRODUCT_TYPE'
           and gd_d.group_dict_value = cf.category
         where oh.company_id = 'a972dd1ffe3b3a10e0533c281cac8fd7'
           and a.anomaly_class = 'AC_QUALITY')k  ]';
      /*更新全部历史数据*/
      v_w1 := q'[  where k.year < to_char(sysdate,'yyyy')  ]';
      /*只更新上一年数据*/
      v_w2 := q'[  where k.year = to_char(sysdate,'yyyy')-1  ]';

      v_z2 := q'[  group by k.year,k.factory_name,k.factory_code,k.company_id, k.category,k.category_name) tkb
      on (tka.company_id = tkb.company_id and tka.year = tkb.year 
              and tka.factory_code = tkb.factory_code and tka.category = tkb.category)
      when matched then
        update
           set tka.quality_deviant_amount = tkb.quality_deviant_amount,
               tka.quality_deviant_money  = tkb.quality_deviant_money,
               tka.factory_name           = tkb.factory_name,
               tka.update_id              = 'ADMIN',
               tka.update_time            = sysdate
      when not matched then
        insert
          (tka.t_fa_year_id,
           tka.company_id,
           tka.year,
           tka.factory_code,
           tka.factory_name,
           tka.category,
           tka.category_name,
           tka.quality_deviant_amount,
           tka.quality_deviant_money,
           tka.create_id,
           tka.create_time)
        values
          (scmdata.f_get_uuid(),
           tkb.company_id,
           tkb.year,
           tkb.factory_code,
           tkb.factory_name,
           tkb.category,
           tkb.category_name,
           tkb.quality_deviant_amount,
           tkb.quality_deviant_money,
           'ADMIN',
           sysdate)]';
      if t_type = 0 then
        v_sql := v_z1 || v_w1 || v_z2;
      elsif t_type = 1 then
        v_sql := v_z1 || v_w2 || v_z2;
      end if;
      execute immediate v_sql;
    end;

  end p_factory_performance_year;
end pkg_supplier_performance;
/

