create or replace procedure scmdata.P_T_KPIORDER_QU_HALFYEAR(t_type number,p_type number) IS
   V_Q_SQL clob;
   V_U_SQL clob;
   V_W_SQL clob;
   V_W1_SQL clob;
   V_U1_SQL clob;
   V_U2_SQL clob;
   V_U3_SQL clob;
   V_U4_SQL clob;
   V_U5_SQL clob;
   V_IN_SQL clob;
   V_SQL clob;
BEGIN
  V_Q_SQL := q'[
  MERGE INTO scmdata.t_kpiorder_qu_halfyear tka
  USING (
      with kpi_order as
     (select t.company_id,t.year,decode(t.quarter,1,1,2,1,3,2,4,2)halfyear,t.group_name,sum(t.order_money) order_money
        from scmdata.pt_ordered t
       group by t.company_id, t.year,decode(t.quarter,1,1,2,1,3,2,4,2),t.group_name)
    select k.company_id, k.year,k.halfyear,k.group_name, k.order_money,z.sho_order_money,d.sho_order_money_desc, y.delivery_money,
           qa.delivery_order_money,qw.delivery_order_money_desc,x.qua_order_money, qx.order_20_money, qy.delivery_20_money
      from kpi_order k
      left join (select t1.company_id, t1.year,decode(t1.quarter,1,1,2,1,3,2,4,2)halfyear,t1.group_name, sum(t1.order_money) qua_order_money
                   from scmdata.pt_ordered t1
                  where t1.responsible_dept = '供应链管理部'
                    and t1.is_quality = 1
                  group by t1.company_id, t1.year, decode(t1.quarter,1,1,2,1,3,2,4,2),t1.group_name) x
        on k.company_id = x.company_id
       and k.year = x.year
       and k.halfyear = x.halfyear
       and k.group_name = x.group_name
      left join (select t2.company_id, t2.year,decode(t2.quarter,1,1,2,1,3,2,4,2)halfyear, t2.group_name, sum(t2.order_money) delivery_money
                   from scmdata.pt_ordered t2
                  where t2.is_first_order = '0'
                  group by t2.company_id, t2.year,decode(t2.quarter,1,1,2,1,3,2,4,2), t2.group_name) y
        on k.company_id = y.company_id
       and k.year = y.year
       and k.halfyear = y.halfyear
       and k.group_name = y.group_name
      left join (select tp.company_id, tp.year,tp.halfyear, tp.group_name,sum(tp.sum_money) sho_order_money
                  from (select t3.company_id, t3.year,decode(t3.quarter,1,1,2,1,3,2,4,2)halfyear, t3.group_name,(t3.fixed_price * ta.delivery_amount) sum_money
                          from scmdata.pt_ordered t3
                          left join scmdata.t_delivery_record ta
                            on t3.product_gress_code = ta.order_code
                           and t3.company_id = ta.company_id
                          left join scmdata.t_commodity_info tb
                            on t3.goo_id = tb.rela_goo_id
                           and tb.goo_id = ta.goo_id
                           and t3.company_id = tb.company_id
                         where(to_date(to_char(ta.delivery_date, 'yyyy/mm/dd'), 'yyyy/mm/dd')) <= (to_date(to_char(t3.delivery_date, 'yyyy/mm/dd'), 'yyyy/mm/dd'))
                        union all
                        select t3a.company_id,t3a.year,decode(t3a.quarter,1,1,2,1,3,2,4,2)halfyear,t3a.group_name, (t3a.fixed_price * ta4.delivery_amount) sum_money
                          from scmdata.pt_ordered t3a
                          left join scmdata.t_delivery_record ta4
                            on t3a.product_gress_code = ta4.order_code
                           and t3a.company_id = ta4.company_id
                          left join scmdata.t_commodity_info tb
                            on t3a.goo_id = tb.rela_goo_id
                           and tb.goo_id = ta4.goo_id
                           and t3a.company_id = tb.company_id
                         where (to_date(to_char(ta4.delivery_date, 'yyyy/mm/dd'), 'yyyy/mm/dd')) > (to_date(to_char(t3a.delivery_date, 'yyyy/mm/dd'), 'yyyy/mm/dd'))
                           and (t3a.responsible_dept is not null and t3a.responsible_dept <> '供应链管理部')) tp
                          group by tp.company_id, tp.year,tp.halfyear, tp.group_name)z
        on k.company_id = z.company_id
       and k.year = z.year
       and k.halfyear = z.halfyear
       and k.group_name = z.group_name
      left join (select tp.company_id, tp.year,tp.halfyear, tp.group_name,sum(tp.sum_money) sho_order_money_desc
                  from (select t3b.company_id, t3b.year,decode(t3b.quarter,1,1,2,1,3,2,4,2)halfyear, t3b.group_name,(t3b.fixed_price * ta3.delivery_amount) sum_money
                          from scmdata.pt_ordered t3b
                          left join scmdata.t_delivery_record ta3
                            on t3b.product_gress_code = ta3.order_code
                           and t3b.company_id = ta3.company_id
                          left join scmdata.t_commodity_info tb
                            on t3b.goo_id = tb.rela_goo_id
                           and tb.goo_id = ta3.goo_id
                           and t3b.company_id = tb.company_id
                         where (to_date(to_char(ta3.delivery_date, 'yyyy/mm/dd'), 'yyyy/mm/dd')) <= (to_date(to_char(t3b.delivery_date, 'yyyy/mm/dd'), 'yyyy/mm/dd'))
                           and t3b.is_twenty = 1
                        union all
                        select t3c.company_id,t3c.year,decode(t3c.quarter,1,1,2,1,3,2,4,2)halfyear,t3c.group_name, (t3c.fixed_price * ta2.delivery_amount) sum_money
                          from scmdata.pt_ordered t3c
                          left join scmdata.t_delivery_record ta2
                            on t3c.product_gress_code = ta2.order_code
                           and t3c.company_id = ta2.company_id
                          left join scmdata.t_commodity_info tb
                            on t3c.goo_id = tb.rela_goo_id
                           and tb.goo_id = ta2.goo_id
                           and t3c.company_id = tb.company_id
                         where (to_date(to_char(ta2.delivery_date, 'yyyy/mm/dd'), 'yyyy/mm/dd')) >(to_date(to_char(t3c.delivery_date, 'yyyy/mm/dd'), 'yyyy/mm/dd'))
                           and t3c.is_twenty = 1
                           and (t3c.responsible_dept is not null and t3c.responsible_dept <> '供应链管理部')) tp
                          group by tp.company_id, tp.year,tp.halfyear, tp.group_name)d
        on k.company_id = d.company_id
       and k.year = d.year
       and k.halfyear = d.halfyear
       and k.group_name = d.group_name
      left join (select ta0.company_id, ta0.year,ta0.halfyear, ta0.group_name,sum(ta0.sum1_date*ta0.sum1_money) delivery_order_money
              from (select t5.company_id, t5.year,decode(t5.quarter,1,1,2,1,3,2,4,2)halfyear, t5.group_name,
                     (to_date(to_char(tba.delivery_date, 'yyyy/mm/dd'), 'yyyy/mm/dd') -
                     to_date(to_char(t5.order_create_date, 'yyyy/mm/dd'), 'yyyy/mm/dd')) sum1_date,
                     (t5.fixed_price * tba.delivery_amount) sum1_money
                from scmdata.pt_ordered t5
                left join scmdata.t_delivery_record tba
                  on t5.product_gress_code = tba.order_code
                 and t5.company_id = tba.company_id
                left join scmdata.t_commodity_info tb
                  on t5.goo_id = tb.rela_goo_id
                 and tb.goo_id = tba.goo_id
                 and t5.company_id = tb.company_id
               where t5.is_first_order = 0)ta0
              group by ta0.company_id, ta0.year, ta0.halfyear, ta0.group_name) qa
        on k.company_id = qa.company_id
       and k.year = qa.year
       and k.halfyear = qa.halfyear
       and k.group_name = qa.group_name
      left join (select t6.company_id, t6.year,t6.halfyear,t6.group_name,sum(t6.sum2_date*t6.sum2_money) delivery_order_money_desc
                from (select t5a.company_id, t5a.year,decode(t5a.quarter,1,1,2,1,3,2,4,2)halfyear, t5a.group_name,
                       (to_date(to_char(tab.delivery_date, 'yyyy/mm/dd'), 'yyyy/mm/dd') -
                       to_date(to_char(t5a.order_create_date, 'yyyy/mm/dd'), 'yyyy/mm/dd')) sum2_date,
                       (t5a.fixed_price * tab.delivery_amount) sum2_money
                  from scmdata.pt_ordered t5a
                  left join scmdata.t_delivery_record tab
                    on t5a.product_gress_code = tab.order_code
                   and t5a.company_id = tab.company_id
                  left join scmdata.t_commodity_info tb
                    on t5a.goo_id = tb.rela_goo_id
                   and tb.goo_id = tab.goo_id
                   and t5a.company_id = tb.company_id
                 where t5a.is_first_order = 0
                   and t5a.is_twenty = 1 )t6
                group by t6.company_id, t6.year,t6.halfyear,t6.group_name) qw
        on k.company_id = qw.company_id
       and k.year = qw.year
       and k.halfyear = qw.halfyear
       and k.group_name = qw.group_name
      left join (select t.company_id,t.year,decode(t.quarter,1,1,2,1,3,2,4,2) halfyear, t.group_name,sum(t.order_money) order_20_money
                   from scmdata.pt_ordered t
                  where t.is_twenty =1
                  group by t.company_id, t.year, decode(t.quarter,1,1,2,1,3,2,4,2), t.group_name)qx  
        on k.company_id = qx.company_id
       and k.year = qx.year
       and k.halfyear = qx.halfyear
       and k.group_name = qx.group_name
      left join (select t2.company_id, t2.year,decode(t2.quarter,1,1,2,1,3,2,4,2) halfyear, t2.group_name, sum(t2.order_money) delivery_20_money
                     from scmdata.pt_ordered t2
                    where t2.is_first_order = '0' and t2.is_twenty = 1 
                    group by t2.company_id, t2.year,decode(t2.quarter,1,1,2,1,3,2,4,2), t2.group_name) qy
        on k.company_id = qy.company_id
       and k.year = qy.year
       and k.halfyear = qy.halfyear
       and k.group_name = qy.group_name]';

    V_W_SQL := q'[
     where (k.year || k.halfyear) <= pkg_kpipt_order.f_yearmonth ) tkb
      ON (tka.company_id = tkb.company_id and tka.year = tkb.year and tka.is_halfyear = tkb.halfyear and tka.groupname = tkb.group_name)
     WHEN MATCHED THEN]';

    V_W1_SQL := q'[
     where (k.year || k.halfyear) = pkg_kpipt_order.f_yearmonth ) tkb
      ON (tka.company_id = tkb.company_id and tka.year = tkb.year and tka.is_halfyear = tkb.halfyear and tka.groupname = tkb.group_name)
     WHEN MATCHED THEN]';

    V_U_SQL := q'[  UPDATE   
         SET tka.order_money               = tkb.order_money,
             tka.sho_order_money           = tkb.sho_order_money,
             tka.sho_order_20_money        = tkb.sho_order_money_desc,
             tka.delivery_money            = tkb.delivery_money,
             tka.delivery_order_money      = tkb.delivery_order_money,
             tka.delivery_order_20_money   = tkb.delivery_order_money_desc,
             tka.qua_order_money           = tkb.qua_order_money,
             tka.delivery_20_money         = tkb.delivery_20_money,
             tka.order_20_money            = tkb.order_20_money,
             tka.memo                      = '',
             tka.update_id                 = 'ADMIN',
             tka.update_time               = sysdate]';
    V_U1_SQL := q'[  UPDATE   
         SET tka.order_money               = tkb.order_money,
             tka.sho_order_money           = tkb.sho_order_money,
             tka.update_id                 = 'ADMIN',
             tka.update_time               = sysdate]';
    V_U2_SQL := q'[  UPDATE   
         SET tka.order_20_money            = tkb.order_20_money, 
             tka.sho_order_20_money        = tkb.sho_order_money_desc,
             tka.update_id                 = 'ADMIN',
             tka.update_time               = sysdate]';
     V_U3_SQL := q'[  UPDATE   
         SET tka.delivery_money            = tkb.delivery_money,
             tka.delivery_order_money      = tkb.delivery_order_money,
             tka.update_id                 = 'ADMIN',
             tka.update_time               = sysdate]';
     V_U4_SQL := q'[  UPDATE   
         SET tka.delivery_20_money         = tkb.delivery_20_money,
             tka.delivery_order_20_money   = tkb.delivery_order_money_desc,
             tka.update_id                 = 'ADMIN',
             tka.update_time               = sysdate]';
     V_U5_SQL := q'[  UPDATE   
         SET tka.order_money               = tkb.order_money,
             tka.qua_order_money           = tkb.qua_order_money,
             tka.update_id                 = 'ADMIN',
             tka.update_time               = sysdate]';

  V_IN_SQL := q'[
    WHEN NOT MATCHED THEN
      INSERT
        (tka.company_id,
         tka.year,
         tka.is_halfyear,
         tka.groupname,
         tka.order_money,
         tka.sho_order_money,
         tka.sho_order_20_money,
         tka.delivery_money,
         tka.delivery_order_money,
         tka.delivery_order_20_money,
         tka.qua_order_money,
         tka.delivery_20_money,
         tka.order_20_money,
         tka.memo,
         tka.create_id,
         tka.create_time,
         tka.update_id,
         tka.update_time)
      VALUES
        (tkb.company_id,
         tkb.year,
         tkb.halfyear,
         tkb.group_name,
         tkb.order_money,
         tkb.sho_order_money,
         tkb.sho_order_money_desc,
         tkb.delivery_money,
         tkb.delivery_order_money,
         tkb.delivery_order_money_desc,
         tkb.qua_order_money,
         tkb.delivery_20_money,
         tkb.order_20_money,
         '',
         'ADMIN',
         sysdate,
         'ADMIN',
         sysdate)]';
 /*   t_type = 0 更新全部指标
       p_type = 0 更新全部历史数据   p_type = 1  只更新上一个月的数据 */
   if t_type = 0 then
        if p_type = 0 then
            V_SQL := V_Q_SQL || V_W_SQL || V_U_SQL || V_IN_SQL;
         elsif p_type = 1 then
            V_SQL := V_Q_SQL || V_W1_SQL || V_U_SQL || V_IN_SQL;
         end if;
   end if;
 /*   t_type = 1 只更新到仓满足率指标  当指标只做更新不做插入
       p_type = 0 更新全部历史数据   p_type = 1  只更新上一个月的数据 */
     if t_type = 1 then
        if  p_type = 0 then
            V_SQL := V_Q_SQL || V_W_SQL || V_U1_SQL;
         elsif p_type = 1 then
            V_SQL := V_Q_SQL || V_W1_SQL || V_U1_SQL;
        end if;
     end if;
 /*   t_type = 2 只更新到前20%仓满足率指标  当指标只做更新不做插入
       p_type = 0 更新全部历史数据   p_type = 1  只更新上一个月的数据 */
     if t_type = 2 then
        if  p_type = 0 then
            V_SQL := V_Q_SQL || V_W_SQL || V_U2_SQL;
         elsif p_type = 1 then
            V_SQL := V_Q_SQL || V_W1_SQL || V_U2_SQL;
        end if;
     end if;
 /*   t_type = 3 只更新到仓补货平均交期指标  当指标只做更新不做插入
       p_type = 0 更新全部历史数据   p_type = 1  只更新上一个月的数据 */
     if t_type = 3 then
        if  p_type = 0 then
            V_SQL := V_Q_SQL || V_W_SQL || V_U3_SQL;
         elsif p_type = 1 then
            V_SQL := V_Q_SQL || V_W1_SQL || V_U3_SQL;
        end if;
     end if;
 /*   t_type = 4 只更新前20%到仓补货平均交期指标  当指标只做更新不做插入
       p_type = 0 更新全部历史数据   p_type = 1  只更新上一个月的数据 */
     if t_type = 4 then
        if  p_type = 0 then
            V_SQL := V_Q_SQL || V_W_SQL || V_U4_SQL;
         elsif p_type = 1 then
            V_SQL := V_Q_SQL || V_W1_SQL || V_U4_SQL;
        end if;
     end if;
 /*   t_type = 5 只更新前20%到仓补货平均交期指标  当指标只做更新不做插入
       p_type = 0 更新全部历史数据   p_type = 1  只更新上一个月的数据 */
     if t_type = 5 then
        if  p_type = 0 then
            V_SQL := V_Q_SQL || V_W_SQL || V_U5_SQL;
         elsif p_type = 1 then
            V_SQL := V_Q_SQL || V_W1_SQL || V_U5_SQL;
        end if;
     end if;
  execute immediate V_SQL;
END P_T_KPIORDER_QU_HALFYEAR;
/

