declare
  p_delivery_record scmdata.t_delivery_record%rowtype;
begin
  for x in (select * from scmdata.t_ordered a where a.send_by_sup = 1) loop
    --刷进度表到仓时间
    for asn in (select *
                  from scmdata.t_delivery_record w
                 where w.order_code = x.order_code
                   and x.company_id = x.company_id
                   and w.sorting_date is not null) loop
      update scmdata.t_delivery_record w
         set w.delivery_origin_time = w.sorting_date,
             w.delivery_date        = w.sorting_date
       where w.asn_id = asn.asn_id
         and w.company_id = asn.company_id;
      select *
        into p_delivery_record
        from scmdata.t_delivery_record w
       where w.delivery_record_id = asn.delivery_record_id;
      scmdata.pkg_production_progress.sync_delivery_record(p_delivery_rec => p_delivery_record);
    end loop;
    --如果已结束，刷交期表  
    if x.finish_time_scm is not null then
      update scmdata.pt_ordered a
         set a.arrival_date  =
             (select max(d.delivery_date)
                from scmdata.t_delivery_record d
               where d.order_code = a.product_gress_code
                 and d.company_id = a.company_id),
             a.satisfy_amount =
             (select SUM(CASE
                           WHEN trunc(d.delivery_date) - trunc(pg.delivery_date) <= 0 THEN
                            d.delivery_amount
                           ELSE
                            0
                         END)
                from scmdata.t_delivery_record d
               inner join scmdata.t_ordered pg
                  on pg.company_id = d.company_id
                 and pg.order_code = d.order_code
               where d.order_code = a.product_gress_code
                 and d.company_id = a.company_id),
             a.satisfy_money =
             (select SUM(CASE
                           WHEN trunc(d.delivery_date) - trunc(pg.delivery_date) <= 0 THEN
                            d.delivery_amount
                           ELSE
                            0
                         END)
                from scmdata.t_delivery_record d
               inner join scmdata.t_ordered pg
                  on pg.company_id = d.company_id
                 and pg.order_code = d.order_code
               where d.order_code = a.product_gress_code
                 and d.company_id = a.company_id) *
             (select price
                from scmdata.t_commodity_info tc
               where tc.rela_goo_id = a.goo_id
                 and tc.company_id = a.company_id)
       where a.product_gress_code = x.order_code
         and a.company_id = x.company_id;
    end if;
  end loop;
end;

