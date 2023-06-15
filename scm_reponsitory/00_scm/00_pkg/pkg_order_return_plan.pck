CREATE OR REPLACE PACKAGE SCMDATA.PKG_ORDER_RETURN_PLAN IS

  PROCEDURE P_ORDER_RETURN_PLAN;

end PKG_ORDER_RETURN_PLAN;
/

CREATE OR REPLACE PACKAGE BODY SCMDATA.PKG_ORDER_RETURN_PLAN IS
/*
   回货计划汇总表数据表
    版本：2022-09-22
   修改：20220929 版本迭代  增加订单修改信息
         20221128 新增清空表
         20221130 修改asn过滤逻辑
         20221202 修改"生产订单编号"有asn但是还存在未预约的数量过滤条件
         20230107 修改"生产订单编号"有asn但是还存在未预约的数量的逻辑
*/
  PROCEDURE P_ORDER_RETURN_PLAN is
  begin
     delete scmdata.t_order_return_plan ;
  begin
    MERGE INTO scmdata.t_order_return_plan tka
    USING ( with order_k as
 (select x.company_id,t.product_gress_code,y.order_code, x.order_id, x.goo_id,t.order_amount,
         t.plan_delivery_date, x.delivery_date,y.finish_time,y.finish_time_scm
    from scmdata.t_orders x
   inner join scmdata.t_ordered y
      on x.order_id = y.order_code
     and x.company_id = y.company_id
   inner join scmdata.t_production_progress t
      on t.company_id = x.company_id
     and t.order_id = x.order_id
     and t.goo_id = x.goo_id
   where (y.send_by_sup = '0' or y.send_by_sup is null)
     and y.is_product_order = '1'
     and y.finish_time is null
     and y.finish_time_scm is null)
select t.company_id,t.product_gress_code order_code,to_char(t.predict_delivery_date,'yyyy') year,to_char(t.predict_delivery_date,'mm') month,
       t.predict_delivery_date delivery_date,sum(t.predict_delivery_amount)predict_delivery_amount,
       a.inprice * sum(t.predict_delivery_amount)/10 predict_delivery_inprice_money,
       a.price * sum(t.predict_delivery_amount)/10 predict_delivery_price_money,t.finish_time,t.finish_time_scm,t.asn_id
 from(
--没有预约asn
select x.company_id,x.goo_id,x.product_gress_code,
       (case when x.plan_delivery_date is null then
              max(x.delivery_date) over(partition by x.order_id) else x.plan_delivery_date end) predict_delivery_date,
       x.order_amount predict_delivery_amount,x.finish_time,x.finish_time_scm,'1' asn_id
  from order_k x
 where not exists (select 1 from scmdata.t_delivery_record t where t.order_code = x.order_code and x.company_id = t.company_id)
union all
--有预约asn
select x.company_id,x.goo_id,x.product_gress_code, b.predict_delivery_date, b.predict_delivery_amount,x.finish_time,x.finish_time_scm,b.asn_id
  from order_k x
 inner join scmdata.t_delivery_record b
    on x.goo_id = b.goo_id
   and x.order_id = b.order_code
   and x.company_id = b.company_id
 where b.delivery_date is null
   and (b.end_acc_time is null or (b.delivery_amount > 0 or b.delivery_amount is null))
union all
--"生产订单编号"有asn但是还存在未预约的数量
 select x1.company_id,x1.goo_id, x1.order_code, x1.delivery_date,
        (case when max(x1.order_amount) - sum(x1.delivery_amount) < 0 then 0 else  max(x1.order_amount) - sum(x1.delivery_amount) end )owe_amount,
        x1.finish_time,x1.finish_time_scm,'1' asn_id
   from (select b.company_id,x.goo_id, b.order_code, x.order_amount,
                max(x.delivery_date) over(partition by x.order_id) latest_plan_delivery_date,
                (case when x.plan_delivery_date is null then max(x.delivery_date) over(partition by x.order_id) else x.plan_delivery_date end)delivery_date,
                (case when b.delivery_date is not null then
                    (case when b.delivery_origin_amount is null then  b.predict_delivery_amount else b.delivery_origin_amount end)
                 else b.predict_delivery_amount end) delivery_amount,x.finish_time,x.finish_time_scm
           from order_k x
          inner join scmdata.t_delivery_record b
             on x.goo_id = b.goo_id
            and x.order_id = b.order_code
            and x.company_id = b.company_id
          where (b.delivery_amount > 0 or b.delivery_amount is null) ) x1
  group by x1.company_id,x1.goo_id,x1.order_code,x1.delivery_date,x1.finish_time,x1.finish_time_scm)t
 inner join scmdata.t_commodity_info a
    on a.goo_id = t.goo_id
   and a.company_id = t.company_id
 where to_char(t.predict_delivery_date,'yyyy') >= '2022'
 group by  t.company_id,t.product_gress_code,t.predict_delivery_date,t.goo_id,a.inprice,a.price,t.finish_time,t.finish_time_scm ,t.asn_id) tkb
    ON (tkb.company_id = tka.company_id and tkb.order_code = tka.order_code  and tkb.asn_id = tka.asn_id )
    WHEN MATCHED THEN
      UPDATE
         SET tka.year                           = tkb.year,
             tka.month                          = tkb.month,
             tka.delivery_date                  = tkb.delivery_date,
             tka.predict_delivery_amount        = tkb.predict_delivery_amount,
             tka.predict_delivery_inprice_money = tkb.predict_delivery_inprice_money,
             tka.predict_delivery_price_money   = tkb.predict_delivery_price_money,
             tka.finish_time_panda              = tkb.finish_time,
             tka.finish_time_scm                = tkb.finish_time_scm,
             tka.memo                           = '',
             tka.update_id                      = 'ADMIN',
             tka.update_time                    = sysdate
    WHEN NOT MATCHED THEN
      INSERT
        (tka.t_order_return_plan_id,
         tka.company_id,
         tka.year,
         tka.month,
         tka.order_code,
         tka.delivery_date,
         tka.predict_delivery_amount,
         tka.predict_delivery_inprice_money,
         tka.predict_delivery_price_money,
         tka.finish_time_panda,
         tka.finish_time_scm,
         tka.asn_id,
         tka.memo,
         tka.create_id,
         tka.create_time,
         tka.update_id,
         tka.update_time)
      VALUES
        (scmdata.f_get_uuid(),
         tkb.company_id,
         tkb.year,
         tkb.month,
         tkb.order_code,
         tkb.delivery_date,
         tkb.predict_delivery_amount,
         tkb.predict_delivery_inprice_money,
         tkb.predict_delivery_price_money,
         tkb.finish_time,
         tkb.finish_time_scm,
         tkb.asn_id,
         ' ',
         'ADMIN',
         sysdate,
         'ADMIN',
         sysdate);
end;
---更新已完成未交货数量
  begin
  MERGE INTO scmdata.t_order_return_plan tka
  USING ( with order_k as
 (select x.company_id,t.product_gress_code,y.order_code,x.order_id,x.goo_id,t.order_amount,y.finish_time,y.finish_time_scm,
         t.plan_delivery_date,x.delivery_date,a.inprice,a.price, a1.progress_node_num,a1.progress_node_name,
         a1.progress_node_desc,t.progress_status,t.curlink_complet_ratio,a.category, a.product_cate, a.samll_category
    from scmdata.t_orders x
   inner join scmdata.t_ordered y
      on x.order_id = y.order_code
     and x.company_id = y.company_id
   inner join scmdata.t_production_progress t
      on t.company_id = x.company_id
     and t.order_id = x.order_id
     and t.goo_id = x.goo_id
   inner join scmdata.t_commodity_info a
      on a.goo_id = t.goo_id
     and a.company_id = t.company_id
   inner join scmdata.t_progress_range_config tp
      on tp.industry_classification = a.category
     and tp.production_category = a.product_cate
     and instr(';' || tp.product_subclass || ';',  ';' || a.samll_category || ';') > 0
   inner join scmdata.t_progress_node_config a1
      on a1.progress_config_id = tp.progress_config_id
     and a1.company_id = tp.company_id
     and a1.pause = 0
     and tp.pause = 0
   where (y.send_by_sup = '0' or y.send_by_sup is null)
     and y.is_product_order = '1'
     and y.finish_time is null
     and y.finish_time_scm is null)
select t3.company_id,t3.product_gress_code order_code,to_char(t3.predict_delivery_date,'yyyy') year,to_char(t3.predict_delivery_date,'mm') month,
       t3.predict_delivery_date delivery_date,
       sum(t3.predict_delivery_amount)completed_amount,sum(t3.inprice_money)completed_inprice_money,
       sum(t3.price_money)completed_price_money,t3.finish_time,t3.finish_time_scm,t3.asn_id
 from (select t1.company_id,t1.product_gress_code,t1.predict_delivery_date,
       sum(t1.predict_delivery_amount)predict_delivery_amount,
       t1.inprice * sum(t1.predict_delivery_amount)/10 inprice_money,--预计到仓进价金额
       t1.price * sum(t1.predict_delivery_amount)/10 price_money, --预计到仓定价金额
       t1.finish_time,t1.finish_time_scm,t1.asn_id
from (
--有预约asn
select x.company_id, x.product_gress_code, b.predict_delivery_date, b.predict_delivery_amount,
       x.inprice,x.price,x.finish_time,x.finish_time_scm,b.asn_id
  from order_k x
 inner join scmdata.t_delivery_record b
    on x.goo_id = b.goo_id
   and x.order_id = b.order_code
   and x.company_id = b.company_id
 where b.delivery_date is null
   and (b.end_acc_time is null or (b.delivery_amount > 0 or b.delivery_amount is null))
   and x.progress_node_name = x.progress_status
   and x.progress_node_desc = '交货'
union all
--没有预约
select k.company_id, k.product_gress_code,
       (case when k.plan_delivery_date is null then max(k.delivery_date) over(partition by k.order_id) else k.plan_delivery_date end) predict_delivery_date,
       k.order_amount,k.inprice,k.price,k.finish_time,k.finish_time_scm,'1' asn_id
  from order_k k
 where not exists (select 1 from scmdata.t_delivery_record t where t.order_code = k.order_code and k.company_id = t.company_id)
   and k.progress_node_name = k.progress_status
   and k.progress_node_desc = '交货'
union all
--"生产订单编号"有asn但是还存在未预约的数量
 select x1.company_id, x1.order_code, x1.delivery_date,
        (case when max(x1.order_amount) - sum(x1.delivery_amount) < 0 then 0 else  max(x1.order_amount) - sum(x1.delivery_amount) end )owe_amount,
        x1.inprice,x1.price,x1.finish_time,x1.finish_time_scm,'1' asn_id
   from (select b.company_id, b.order_code,  b.asn_id, k1.plan_delivery_date,k1.inprice,k1.price,
                (case when k1.plan_delivery_date is null then max(k1.delivery_date) over(partition by k1.order_id) else k1.plan_delivery_date end)delivery_date,
                k1.order_amount,
                (case when b.delivery_date is not null then
                    (case when b.delivery_origin_amount is null then  b.predict_delivery_amount else b.delivery_origin_amount end)
                 else b.predict_delivery_amount end) delivery_amount,k1.finish_time,k1.finish_time_scm
           from order_k k1
          inner join scmdata.t_delivery_record b
             on k1.goo_id = b.goo_id
            and k1.order_id = b.order_code
            and k1.company_id = b.company_id
          where k1.progress_node_name = k1.progress_status
            and (b.delivery_amount > 0 or b.delivery_amount is null)
            and k1.progress_node_desc = '交货') x1
  group by x1.company_id, x1.order_code, x1.delivery_date,x1.inprice,x1.price,x1.finish_time,x1.finish_time_scm)t1
  group by t1.company_id,t1.product_gress_code,t1.predict_delivery_date,t1.inprice,t1.price,t1.finish_time,t1.finish_time_scm,t1.asn_id
  union all
 select t2.company_id,t2.product_gress_code,t2.predict_delivery_date,sum(t2.undone_amount) undone_amount,
       (t2.inprice*sum(t2.undone_amount))/10 inprice_money,--预计到仓进价金额
       (sum(t2.undone_amount)*price)/10 price_money, --预计到仓定价金额
       t2.finish_time,t2.finish_time_scm,t2.asn_id
from (select x1.company_id,x1.product_gress_code,
       (case when x1.plan_delivery_date is null then x1.latest_plan_delivery_date else x1.plan_delivery_date end)predict_delivery_date,
        x1.undone_amount,x1.inprice,x1.price ,x1.finish_time,x1.finish_time_scm ,'1' asn_id
  from (select k.product_gress_code,k.company_id, k.order_amount,k.plan_delivery_date,
               floor((k.curlink_complet_ratio * k.order_amount) / 100) undone_amount,
               max(k.delivery_date) over(partition by k.order_id) latest_plan_delivery_date,
               k.progress_node_num + 1 num1, k.category, k.product_cate, k.samll_category,k.inprice,k.price,k.finish_time,k.finish_time_scm
          from order_k k
         where not exists (select 1 from scmdata.t_delivery_record t  where t.order_code = k.order_code and k.company_id = t.company_id)
           and k.progress_node_name = k.progress_status
           and k.progress_node_desc <> '交货') x1
 inner join scmdata.t_progress_range_config t
    on t.industry_classification = x1.category
   and t.production_category = x1.product_cate
   and instr(';' || t.product_subclass || ';', ';' || x1.samll_category || ';') > 0
 inner join scmdata.t_progress_node_config a
    on a.progress_config_id = t.progress_config_id
   and a.company_id = t.company_id
   and a.pause = 0
   and t.pause = 0
 where x1.num1 = a.progress_node_num
   and a.progress_node_desc = '交货'
union all
select x1.company_id,x1.product_gress_code,x1.predict_delivery_date, x1.undone_asn_amount,
       x1.inprice,x1.price,x1.finish_time,x1.finish_time_scm,x1.asn_id
  from (select k.product_gress_code,k.company_id,  b.predict_delivery_date, b.predict_delivery_amount,
               floor((k.curlink_complet_ratio * b.predict_delivery_amount)/100) undone_asn_amount,k.finish_time,k.finish_time_scm,
               k.progress_node_num + 1 num1,k.inprice,k.price,k.category, k.product_cate, k.samll_category,b.asn_id
          from order_k k
         inner join scmdata.t_delivery_record b
            on k.goo_id = b.goo_id
           and k.order_id = b.order_code
           and k.company_id = b.company_id
         where b.delivery_date is null
           and (b.end_acc_time is null or (b.delivery_amount > 0 or b.delivery_amount is null))
           and k.progress_node_name = k.progress_status
           and k.progress_node_desc <> '交货') x1
 inner join scmdata.t_progress_range_config t
    on t.industry_classification = x1.category
   and t.production_category = x1.product_cate
   and instr(';' || t.product_subclass || ';', ';' || x1.samll_category || ';') > 0
 inner join scmdata.t_progress_node_config a
    on a.progress_config_id = t.progress_config_id
   and a.company_id = t.company_id
   and a.pause = 0
   and t.pause = 0
 where x1.num1 = a.progress_node_num
   and a.progress_node_desc = '交货'
union all
 select x1.company_id, x1.order_code, x1.delivery_date,
        (case when max(x1.order_amount) - sum(x1.delivery_amount) < 0 then 0 else max(x1.order_amount) - sum(x1.delivery_amount) end)owe_amount,
        x1.inprice,x1.price,x1.finish_time,x1.finish_time_scm,'1' asn_id
   from (select k.company_id,b.order_code,
               floor((k.curlink_complet_ratio * b.predict_delivery_amount)/100) undone_asn_amount,
               k.progress_node_num + 1 num1,k.inprice,k.price,
                (case when k.plan_delivery_date is null then max(k.delivery_date) over(partition by k.order_id) else k.plan_delivery_date end)delivery_date,
               k.order_amount,k.finish_time,k.finish_time_scm,
                (case when b.delivery_date is not null then
                    (case when b.delivery_origin_amount is null then  b.predict_delivery_amount else b.delivery_origin_amount end)
                 else b.predict_delivery_amount end) delivery_amount,
               k.category, k.product_cate, k.samll_category
          from order_k k
         inner join scmdata.t_delivery_record b
            on k.goo_id = b.goo_id
           and k.order_id = b.order_code
           and k.company_id = b.company_id
         where (b.delivery_amount > 0 or b.delivery_amount is null)
           and k.progress_node_name = k.progress_status
           and k.progress_node_desc <> '交货') x1
 inner join scmdata.t_progress_range_config t
    on t.industry_classification = x1.category
   and t.production_category = x1.product_cate
   and instr(';' || t.product_subclass || ';', ';' || x1.samll_category || ';') > 0
 inner join scmdata.t_progress_node_config a
    on a.progress_config_id = t.progress_config_id
   and a.company_id = t.company_id
   and a.pause = 0
   and t.pause = 0
 where x1.num1 = a.progress_node_num
   and a.progress_node_desc = '交货'
 group by x1.company_id,x1.order_code,x1.delivery_date,x1.inprice,x1.price,x1.finish_time,x1.finish_time_scm )t2
 group by t2.company_id,t2.product_gress_code,t2.predict_delivery_date,t2.inprice,t2.price,t2.finish_time,t2.finish_time_scm,t2.asn_id)t3
 where to_char(t3.predict_delivery_date,'yyyy') >= '2022'
 group by t3.company_id,t3.product_gress_code,t3.predict_delivery_date,t3.finish_time,t3.finish_time_scm,t3.asn_id  ) tkb
on ( tkb.company_id = tka.company_id and tkb.order_code = tka.order_code and tkb.asn_id = tka.asn_id )
when matched then
      update
         set tka.year                    = tkb.year,
             tka.month                   = tkb.month,
             tka.delivery_date           = tkb.delivery_date,
             tka.completed_amount        = tkb.completed_amount,
             tka.completed_inprice_money = tkb.completed_inprice_money,
             tka.completed_price_money   = tkb.completed_price_money,
             tka.finish_time_panda       = tkb.finish_time,
             tka.finish_time_scm         = tkb.finish_time_scm,
             tka.memo                    = '',
             tka.update_id               = 'ADMIN',
             tka.update_time             = sysdate;
  end;

--更新未完成数量
begin
  merge into scmdata.t_order_return_plan tka
  using (select t.t_order_return_plan_id,
       t.company_id,
       t.order_code,
       trunc(t.delivery_date) delivery_date,
       td.yearweek,
       (t.predict_delivery_amount - nvl(t.completed_amount, '0')) undone_amount,
       ((t.predict_delivery_amount - nvl(t.completed_amount, '0')) *
       tc.inprice) / 10 undone_inprice_money,
       ((t.predict_delivery_amount - nvl(t.completed_amount, '0')) *
       tc.price) / 10 undone_price_money
  from scmdata.t_order_return_plan t
 inner join scmdata.t_orders td
    on td.company_id = t.company_id
   and td.order_id = t.order_code
 inner join scmdata.t_commodity_info tc
    on tc.company_id = t.company_id
   and tc.goo_id = td.goo_id
 inner join scmdata.t_day_dim td
    on td.year = t.year
   and td.month = t.month
   and lpad(td.day, 2, 0) = to_char(t.delivery_date, 'dd')) tkb
  on (tkb.company_id = tka.company_id and tkb.t_order_return_plan_id = tka.t_order_return_plan_id and tkb.order_code = tka.order_code)
  when matched then
    update
       set tka.yearweek             = tkb.yearweek,
           tka.delivery_date        = tkb.delivery_date,
           tka.undone_amount        = tkb.undone_amount,
           tka.undone_inprice_money = tkb.undone_inprice_money,
           tka.undone_price_money   = tkb.undone_price_money;
end;

--更新周次
begin
  merge into scmdata.t_order_return_plan tka
  using (select company_id,week,week1||'/'||week2 yearmonth,t_order_return_plan_id,yearweek
  from (select z.year,z.week,z.yearweek,z.delivery_date,z.t_order_return_plan_id,z.company_id,
              max(case when weekord = '1' then to_char(dd_date,'yyyy-mm-dd') end) week1,
              max(case when weekord = '7' then to_char(dd_date,'yyyy-mm-dd') end) week2
   from (select distinct substr(t.yearweek,5,2) week, t.yearweek,t.year,t.delivery_date,t.t_order_return_plan_id,t.company_id
           from scmdata.t_order_return_plan t
          inner join scmdata.t_day_dim td
             on td.year = t.year
            and td.yearweek = t.yearweek
          where t.finish_time_panda is null) z
   left join scmdata.t_day_dim d
     on z.yearweek = d.yearweek
    and d.weekord in ('1', '7')
  group by z.yearweek,z.week,z.year,z.delivery_date,z.t_order_return_plan_id,z.yearweek,z.company_id) ) tkb
  on (tkb.company_id = tka.company_id and tkb.t_order_return_plan_id = tka.t_order_return_plan_id and tka.yearweek = tkb.yearweek)
  when matched then
    update
       set tka.week             = tkb.week,
           tka.yearmonth        = tkb.yearmonth;
end;

--更新订单信息
begin
  merge into scmdata.t_order_return_plan tka
  using ( WITH supp AS
 (SELECT sp.company_id,
         sp.supplier_code,
         p.provinceid,
         c.cityno,
         dc.countyid,
         v.villid,
         sp.group_name
    FROM scmdata.t_supplier_info sp
   inner JOIN scmdata.dic_province p
      ON p.provinceid = sp.company_province
   inner JOIN scmdata.dic_city c
      ON c.cityno = sp.company_city
   inner JOIN scmdata.dic_county dc
      ON dc.countyid = sp.company_county
   inner join scmdata.dic_village v
      on v.villid = sp.company_vill)
select x.company_id,
       t.product_gress_code,
       (select progress_status_desc
          from (SELECT a.group_dict_value progress_status_pr,
                       a.group_dict_name  progress_status_desc
                  FROM scmdata.sys_group_dict a
                 WHERE a.group_dict_type = 'PROGRESS_TYPE'
                   AND a.group_dict_value in ('00', '01')
                UNION ALL
                SELECT pv.progress_value progress_status_pr,
                       pv.progress_name  progress_status_desc
                  FROM v_product_progress_status pv
                 WHERE pv.company_id = 'b6cc680ad0f599cde0531164a8c0337f')
         where progress_status_pr = t.progress_status) progress_status_pr,
       t.curlink_complet_ratio,
       y.delivery_date order_date,
       MAX(x.delivery_date) over(PARTITION BY x.order_id) latest_planned_delivery_date_pr,
       t.plan_delivery_date,
       t.order_amount,
       cf.rela_goo_id,
       cf.style_number ,cf.style_name,
       t.factory_code,y.finish_time,y.finish_time_scm,
       t.supplier_code,
       cf.category ,
       cf.product_cate,
       cf.samll_category,
       (SELECT LISTAGG(COMPANY_USER_NAME, ',')
          FROM SCMDATA.SYS_COMPANY_USER
         WHERE INSTR(',' || y.DEAL_FOLLOWER || ',', ',' || USER_ID || ',') > 0
           AND COMPANY_ID = y.COMPANY_ID) deal_follower,
       y.create_time order_create_time,
       sp1.provinceid,
       sp1.cityno,
       sp1.countyid,
       sp1.villid,
       (select distinct ts.group_name
          from scmdata.t_supplier_group_config ts
         where ts.group_config_id = sp1.group_name) group_name,
       y.sho_id,
       y.isfirstordered,
       cf.season,
       cf.is_breakable,
       x.is_qc_required,
       y.rationame
  from scmdata.t_orders x
 inner join scmdata.t_ordered y
    on x.order_id = y.order_code
   and x.company_id = y.company_id
 inner join scmdata.t_production_progress t
    on t.company_id = x.company_id
   and t.order_id = x.order_id
   and t.goo_id = x.goo_id
 INNER JOIN scmdata.t_commodity_info cf
    ON t.company_id = cf.company_id
   AND t.goo_id = cf.goo_id
  LEFT JOIN supp sp1
    ON t.company_id = sp1.company_id
   AND t.factory_code = sp1.supplier_code
 where exists (select 1 from scmdata.t_order_return_plan tp where tp.order_code = t.product_gress_code) ) tkb
  on (tkb.company_id = tka.company_id and tkb.product_gress_code = tka.order_code )
  when matched then
        update
           set tka.progress_status_pr              = tkb.progress_status_pr,
               tka.curlink_complet_ratio           = tkb.curlink_complet_ratio,
               tka.order_date                      = tkb.order_date,
               tka.latest_planned_delivery_date_pr = tkb.latest_planned_delivery_date_pr,
               tka.plan_delivery_date              = tkb.plan_delivery_date,
               tka.order_amount                    = tkb.order_amount,
               tka.rela_goo_id                     = tkb.rela_goo_id,
               tka.style_name                      = tkb.style_name,
               tka.style_number                    = tkb.style_number,
               tka.category                        = tkb.category,
               tka.samll_category                  = tkb.samll_category,
               tka.product_cate                    = tkb.product_cate,
               tka.deal_follower                   = tkb.deal_follower,
               tka.order_create_time               = tkb.order_create_time,
               tka.supplier_code                   = tkb.supplier_code,
               tka.factory_code                    = tkb.factory_code,
               tka.provinceid                      = tkb.provinceid,
               tka.cityno                          = tkb.cityno,
               tka.countyid                        = tkb.countyid,
               tka.villid                          = tkb.villid,
               tka.group_name                      = tkb.group_name,
               tka.sho_id                          = tkb.sho_id,
               tka.is_first_order                  = tkb.isfirstordered,
               tka.season                          = tkb.season,
               tka.is_breakable                    = tkb.is_breakable,
               tka.is_qc_required                  = tkb.is_qc_required,
               tka.finish_time_scm                 = tkb.finish_time,
               tka.finish_time_panda               = tkb.finish_time_scm,
               tka.rationame                       = tkb.rationame;
end;

/*--查找asn被撤销的单号和asn
begin
  for i in (select t.order_code, t.asn_id, t.t_order_return_plan_id
              from scmdata.t_order_return_plan t
             where t.asn_id <> '1'
               and not exists (select 1
                      from scmdata.t_delivery_record td
                     where td.order_code = t.order_code
                       and td.asn_id = t.asn_id)) loop
    delete scmdata.t_order_return_plan tp
     where tp.order_code = i.order_code
       and tp.asn_id = i.asn_id
       and tp.t_order_return_plan_id = i.t_order_return_plan_id;
  end loop;
end;

begin
  for i in (select t.order_code, t.asn_id, t.t_order_return_plan_id
              from scmdata.t_order_return_plan t
             where t.asn_id <> '1'
               and t.finish_time_panda is null
               and exists (select 1
                      from scmdata.t_delivery_record td
                     where td.order_code = t.order_code
                       and td.asn_id = t.asn_id
                       and td.end_acc_time is not null)) loop
    delete scmdata.t_order_return_plan tp
     where tp.order_code = i.order_code
       and tp.asn_id = i.asn_id
       and tp.t_order_return_plan_id = i.t_order_return_plan_id;
  end loop;
end;*/

 end P_ORDER_RETURN_PLAN;
end PKG_ORDER_RETURN_PLAN;
/

