---刷t_abnormal表系统创建异常分类为交期异常的历史数据
declare
  v_count number := 0;
begin
  for i in (select t.abnormal_id,
                   t.company_id,
                   pr.delay_problem_class,
                   pr.delay_cause_class,
                   pr.delay_cause_detailed,
                   pr.responsible_dept,
                   pr.responsible_dept_sec
              from (select *
                      from scmdata.t_abnormal ta
                     where ta.origin = 'SC'
                       and ta.anomaly_class = 'AC_DATE') t
             inner join scmdata.t_production_progress pr
                on pr.company_id = t.company_id
               and pr.order_id = t.order_id
               and pr.goo_id = t.goo_id) loop
    update scmdata.t_abnormal tab
       set tab.responsible_dept = (case
                                    when i.responsible_dept is not null then
                                     i.responsible_dept
                                    else
                                     tab.responsible_dept
                                  end),
           tab.responsible_dept_sec = (case
                                        when i.responsible_dept_sec is not null then
                                         i.responsible_dept_sec
                                        else
                                         tab.responsible_dept_sec
                                      end),
           tab.problem_class = (case
                                 when i.delay_problem_class is not null then
                                  i.delay_problem_class
                                 else
                                  tab.problem_class
                               end),
           tab.cause_class = (case
                               when i.delay_cause_class is not null then
                                i.delay_cause_class
                               else
                                tab.cause_class
                             end),
           tab.cause_detailed = (case
                                  when i.delay_cause_detailed is not null then
                                   i.delay_cause_detailed
                                  else
                                   tab.cause_detailed
                                end)
     where tab.abnormal_id = i.abnormal_id
       and tab.company_id = i.company_id;
    v_count := v_count + 1;
    if v_count = 2000 then
      commit;
      v_count := 0;
    end if;
  end loop;
end;
/

---刷t_deduction表系统创建异常分类为交期异常的历史数据
declare
  v_count number := 0;
begin
  for i in (select td.company_id,
                   td.deduction_id,
                   td.adjust_price,
                   ta.responsible_dept
              from scmdata.t_deduction td
             inner join scmdata.t_abnormal ta
                on ta.company_id = td.company_id
               and ta.abnormal_id = td.abnormal_id
               and ta.origin = 'SC'
               and ta.anomaly_class = 'AC_DATE'
             where td.adjust_price is not null
               and td.adjust_price <> 0
               and td.update_id = 'ADMIN') loop
    update scmdata.t_deduction te
       set te.adjust_type = (case
                              when i.responsible_dept = 'b550778b4efc36b4e0533c281caca074' /*女装品类部*/
                                   or i.responsible_dept ='b550778b4f1736b4e0533c281caca074' /*淘品品类部*/
                                   or i.responsible_dept ='b550778b4ef436b4e0533c281caca074' /*男装品类部*/
                                   or i.responsible_dept = 'b550778b4f0536b4e0533c281caca074' /*美妆品类部*/
                                   or i.responsible_dept ='b550778b4f1036b4e0533c281caca074' /*鞋包品类部*/
                                   or i.responsible_dept = 'b550778b4f2236b4e0533c281caca074' /*内衣事业部*/
                               then
                               '00'
                              when i.responsible_dept = 'b550778b4f4936b4e0533c281caca074' then
                               '01' /*物流部*/
                              when i.responsible_dept = 'b550778b4f2b36b4e0533c281caca074' then
                               '02' /*供应链管理部部*/
                              when i.responsible_dept = 'DP2203084052507152' then
                               '03' /*无*/
                              when i.responsible_dept = 'b550778b4f5936b4e0533c281caca074' then
                               '06' /*商品中心财务部*/
                              else te.adjust_type
                            end)
     where te.deduction_id = i.deduction_id
       and te.company_id = i.company_id;
    v_count := v_count + 1;
    if v_count = 2000 then
      commit;
      v_count := 0;
    end if;
  end loop;
end;
/
