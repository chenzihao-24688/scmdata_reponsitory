CREATE OR REPLACE PACKAGE SCMDATA.PKG_RETURN_PLAN IS

  PROCEDURE CHECK_IMPORTDATAS_SORT_EFFICIENCY(P_SORT_EFFICIENCY_CONFIG_TEMP_ID IN VARCHAR2);

  PROCEDURE P_WAREHOUSE_DEAL_SORT;

  PROCEDURE P_LOGISTICS_SORT_CAPACITY;

  PROCEDURE P_CAPACITY(v_capacity_id            in varchar2,
                       v_sort_difference_amount in number,
                       v_average_efficiency     in number,
                       v_capacity_id_p          out varchar2);
END pkg_return_plan;
/

CREATE OR REPLACE PACKAGE BODY SCMDATA.PKG_RETURN_PLAN IS
  --导入分拣效率校验
  PROCEDURE CHECK_IMPORTDATAS_SORT_EFFICIENCY(p_sort_efficiency_config_temp_id IN VARCHAR2) IS
    p_sort_efficiency_config_temp scmdata.t_sort_efficiency_config_temp%ROWTYPE;
    p_i                           INT;
    p_msg                         VARCHAR2(3000);
    p_desc                        VARCHAR2(1000);
    p_warehouse                   varchar2(128);
    p_category                    VARCHAR2(128);
    p_product_cate                VARCHAR2(128);
    p_samll_category              VARCHAR2(128);

  begin
    p_i := 0;
    SELECT t.*
      INTO p_sort_efficiency_config_temp
      FROM scmdata.t_sort_efficiency_config_temp t
     WHERE sort_efficiency_config_temp_id  = p_sort_efficiency_config_temp_id;
--校验易碎非易碎
  if p_sort_efficiency_config_temp.is_fragile = '易碎'  then
    update scmdata.t_sort_efficiency_config_temp t
       set t.is_fragile = '1'
     where t.sort_efficiency_config_temp_id = p_sort_efficiency_config_temp_id;
  elsif p_sort_efficiency_config_temp.is_fragile = '非易碎'  then
    update scmdata.t_sort_efficiency_config_temp t
       set t.is_fragile = '0'
     where t.sort_efficiency_config_temp_id = p_sort_efficiency_config_temp_id;
  elsif p_sort_efficiency_config_temp.is_fragile = '0' or p_sort_efficiency_config_temp.is_fragile = '1' then
      p_desc := '';
  elsif p_sort_efficiency_config_temp.is_fragile is null then
      p_desc := '';
  else
        p_i   := p_i + 1;
        p_msg := p_msg || p_i || '.易碎非易碎字段不符合,';
  end if;   
--校验仓库
  if p_sort_efficiency_config_temp.warehouse_id is null then
        p_i   := p_i + 1;
        p_msg := p_msg || p_i || '.仓库为空,';
  else
    select max(t.group_dict_value)
      into p_warehouse
      from scmdata.sys_group_dict t
     where t.group_dict_type = 'COMPANY_STORE_TYPE'
       and t.group_dict_value = p_sort_efficiency_config_temp.warehouse_id
       and t.group_dict_value <> 'GDZ'
       and t.pause = 0;
    if p_warehouse is null then
      SELECT MAX(a.group_dict_value)
        INTO p_category
        FROM scmdata.sys_group_dict a
       WHERE a.group_dict_name = p_sort_efficiency_config_temp.warehouse_id
         AND a.group_dict_type = 'COMPANY_STORE_TYPE'
         and a.group_dict_value <> 'GDZ'
         AND pause = 0;
      IF p_warehouse IS NULL THEN
        p_i   := p_i + 1;
        p_msg := p_msg || p_i || '.仓库不存在,';
      else
        update scmdata.t_sort_efficiency_config_temp t
           set t.warehouse_id = p_warehouse
         where t.sort_efficiency_config_temp_id = p_sort_efficiency_config_temp_id;
      END IF;
    else
      update scmdata.t_sort_efficiency_config_temp t
         set t.warehouse_id = p_warehouse
       where t.sort_efficiency_config_temp_id = p_sort_efficiency_config_temp_id;
    end if;
end if;
    --校验分类id
  if p_sort_efficiency_config_temp.category is null then
        p_i   := p_i + 1;
        p_msg := p_msg || p_i || '.分类为空,';
  else
    SELECT MAX(a.group_dict_value)
      INTO p_category
      FROM scmdata.sys_group_dict a
     WHERE a.group_dict_value = p_sort_efficiency_config_temp.category
       AND a.group_dict_type = 'PRODUCT_TYPE'
       AND pause = 0;
    if p_category is null then
      --检验分类名称
      SELECT MAX(a.group_dict_value)
        INTO p_category
        FROM scmdata.sys_group_dict a
       WHERE a.group_dict_name = p_sort_efficiency_config_temp.category
         AND a.group_dict_type = 'PRODUCT_TYPE'
         AND pause = 0;
      IF p_category IS NULL THEN
        p_i   := p_i + 1;
        p_msg := p_msg || p_i || '.分类不存在,';
      else
        update scmdata.t_sort_efficiency_config_temp t
           set t.category = p_category
         where t.sort_efficiency_config_temp_id = p_sort_efficiency_config_temp_id;
      END IF;
    else
      update scmdata.t_sort_efficiency_config_temp t
         set t.category = p_category
       where t.sort_efficiency_config_temp_id = p_sort_efficiency_config_temp_id;
    end if;
end if;
    --检测生产类别
  if p_sort_efficiency_config_temp.product_cate is null then
        p_i   := p_i + 1;
        p_msg := p_msg || p_i || '.生产类别为空,';
  else
    SELECT MAX(a.group_dict_value)
      INTO p_product_cate
      FROM scmdata.sys_group_dict a
     WHERE a.group_dict_value = p_sort_efficiency_config_temp.product_cate
       AND a.group_dict_type = p_category
       AND pause = 0;
    IF p_product_cate IS NULL THEN
      SELECT MAX(a.group_dict_value)
        INTO p_product_cate
        FROM scmdata.sys_group_dict a
       WHERE a.group_dict_name = p_sort_efficiency_config_temp.product_cate
         AND a.group_dict_type = p_category
         AND pause = 0;
      IF p_product_cate IS NULL THEN
        p_i   := p_i + 1;
        p_msg := p_msg || p_i || '.生产类别不存在,';
      else
        update scmdata.t_sort_efficiency_config_temp t
           set t.product_cate = p_product_cate
         where t.sort_efficiency_config_temp_id = p_sort_efficiency_config_temp_id;
      END IF;
    else
      update scmdata.t_sort_efficiency_config_temp t
         set t.product_cate = p_product_cate
       where t.sort_efficiency_config_temp_id = p_sort_efficiency_config_temp_id;
    end if;
end if;
    --检验子类
  if p_sort_efficiency_config_temp.product_cate is null then
        p_i   := p_i + 1;
        p_msg := p_msg || p_i || '.产品子类为空,';
  else
    SELECT MAX(a.company_dict_value)
      INTO p_samll_category
      FROM scmdata.sys_company_dict a
     WHERE a.company_dict_value = p_sort_efficiency_config_temp.samll_category
       AND a.company_dict_type = p_product_cate
       AND a.company_id = p_sort_efficiency_config_temp.company_id
       AND pause = 0;
    IF p_samll_category IS NULL THEN
      SELECT MAX(a.company_dict_value)
        INTO p_samll_category
        FROM scmdata.sys_company_dict a
       WHERE a.company_dict_name = p_sort_efficiency_config_temp.samll_category
         AND a.company_dict_type = p_product_cate
         AND a.company_id = p_sort_efficiency_config_temp.company_id
         AND pause = 0;
      IF p_samll_category IS NULL THEN
        p_i   := p_i + 1;
        p_msg := p_msg || p_i || '.产品子类不存在,';
      else
        update scmdata.t_sort_efficiency_config_temp t
           set t.samll_category = p_samll_category
         where t.sort_efficiency_config_temp_id = p_sort_efficiency_config_temp_id;
      END IF;
    else
      update scmdata.t_sort_efficiency_config_temp t
         set t.samll_category = p_samll_category
       where t.sort_efficiency_config_temp_id = p_sort_efficiency_config_temp_id;
    end if;
end if;
--校验分拣效率
  if p_sort_efficiency_config_temp.sort_efficiency is null then
      p_i   := p_i + 1;
      p_msg := p_msg || p_i || '.分拣效率为空,';
  else
   IF p_sort_efficiency_config_temp.sort_efficiency > 0 AND MOD(p_sort_efficiency_config_temp.sort_efficiency,1)=0 THEN
       p_desc :='';
    ELSE
      p_i   := p_i + 1;
      p_msg := p_msg || p_i || '.分拣效率必须为正整数,';
    END IF;
  end if;
/*--判断仓库+分类+生产类别+产品子类不可重复
  select count(*)
    into v_count
    from scmdata.t_sort_efficiency_config_temp t
   where t.category = p_sort_efficiency_config_temp.category
     and t.product_cate = p_sort_efficiency_config_temp.product_cate
     and t.samll_category = p_sort_efficiency_config_temp.samll_category
     and t.warehouse_id = p_sort_efficiency_config_temp.warehouse_id;
  if v_count > 0 then
      p_i   := p_i + 1;
      p_msg := p_msg || p_i || '仓库+分类+生产类别+产品子类不可重复，请检查!';
  end if;*/
  IF p_msg IS NOT NULL THEN
      UPDATE scmdata.t_sort_efficiency_config_temp t
         SET t.msg_type = 'E',t.error_msg = p_msg
       where t.sort_efficiency_config_temp_id = p_sort_efficiency_config_temp_id;
    ELSE
      UPDATE scmdata.t_sort_efficiency_config_temp t
         SET t.msg_type = 'N', t.error_msg = NULL
       where t.sort_efficiency_config_temp_id = p_sort_efficiency_config_temp_id;
   END IF;
  end CHECK_IMPORTDATAS_SORT_EFFICIENCY;


 PROCEDURE P_WAREHOUSE_DEAL_SORT is
  v_count number;
  v1_count number;
begin
delete scmdata.t_warehouse_deal_sort where total_date >= trunc(sysdate);
delete scmdata.t_return_paln_logistics where total_date >= trunc(sysdate);
  begin
    MERGE INTO scmdata.t_warehouse_deal_sort tka
    USING (select company_id, trunc(sysdate) total_date, rela_goo_id,category, product_cate,
       samll_category, sho_id warehouse_id,sum(unsorted_amount) unsorted_amount
  from (select t.company_id, t.order_code, t.asn_id, tc.rela_goo_id, t1.sho_id,t1.rationame, tc.category, tc.product_cate,
               tc.samll_category, to_char(t.delivery_origin_time, 'yyyy-mm-dd') delivery_date,
               t.delivery_origin_amount, t.predict_delivery_amount, t.delivery_amount,
               (case when t.delivery_origin_time is not null then
                  (case when t.delivery_origin_amount is null then
                     t.predict_delivery_amount - t.delivery_amount else
                     t.delivery_origin_amount - t.delivery_amount end) end) unsorted_amount
          from (select td.company_id, td.order_code,td.rationame, td.sho_id,ts.is_qc_required, td.isfirstordered is_first_order
                  from scmdata.t_ordered td
                 inner join scmdata.t_orders ts
                    on ts.order_id = td.order_code
                   and ts.company_id = td.company_id
                 where td.is_product_order = '1'
                   and td.finish_time is null
                   and (td.send_by_sup = '0' or td.send_by_sup is null)) t1
         inner join scmdata.t_delivery_record t
            on t1.company_id = t.company_id
           and t1.order_code = t.order_code
         inner join scmdata.t_commodity_info tc
            on tc.company_id = t.company_id
           and tc.goo_id = t.goo_id
         where t.delivery_origin_time is not null
           and not exists
               (select 1 from scmdata.t_straight_list tr where tr.rela_goo_id = tc.rela_goo_id or t1.rationame is not null)
           and (t.end_acc_time is null or (t.delivery_amount > 0 or t.delivery_amount is null))
           and t.company_id = 'b6cc680ad0f599cde0531164a8c0337f' /*%default_company_id%*/
           and to_char(t.delivery_origin_time, 'yyyy') >= '2022')
 where unsorted_amount > 0
 group by company_id, category, product_cate, samll_category, sho_id, rela_goo_id ) tkb
    ON (tkb.company_id = tka.company_id and tkb.total_date = tka.total_date  and tkb.warehouse_id = tka.warehouse_id
        and tka.rela_goo_id = tkb.rela_goo_id and tka.category = tkb.category and tka.product_cate = tkb.product_cate and tka.samll_category = tkb.samll_category)
    WHEN MATCHED THEN
      UPDATE
         SET tka.unsorted_amount                = tkb.unsorted_amount,
             tka.update_id                      = 'ADMIN',
             tka.update_time                    = sysdate
    WHEN NOT MATCHED THEN
      INSERT
        (tka.warehouse_deal_sort_id,
         tka.company_id,
         tka.total_date,
         tka.warehouse_id,
         tka.rela_goo_id,
         tka.category,
         tka.product_cate,
         tka.samll_category,
         tka.unsorted_amount,
         tka.remarks,
         tka.create_id,
         tka.create_time,
         tka.update_id,
         tka.update_time)
      VALUES
        (scmdata.f_get_uuid(),
         tkb.company_id,
         tkb.total_date,
         tkb.warehouse_id,
         tkb.rela_goo_id,
         tkb.category,
         tkb.product_cate,
         tkb.samll_category,
         tkb.unsorted_amount,
         ' ',
         'ADMIN',
         sysdate,
         'ADMIN',
         sysdate);
end;
  begin
    merge into scmdata.t_return_paln_logistics tka
    using (select company_id,delivery_date total_date,sho_id warehouse_id,rela_goo_id,category,product_cate, samll_category,
                  sum(predict_delivery_amount) predict_delivery_amount
             from scmdata.t_order_return_plan
            where finish_time_panda is null
              and company_id = 'b6cc680ad0f599cde0531164a8c0337f'
              and sho_id in('GZZ','YWZ')
            group by company_id,delivery_date,sho_id,rela_goo_id,category,product_cate,samll_category ) tkb
    on (tkb.company_id = tka.company_id and tkb.total_date = tka.total_date  and tkb.warehouse_id = tka.warehouse_id
         and tka.rela_goo_id = tkb.rela_goo_id and tka.category = tkb.category 
         and tka.product_cate = tkb.product_cate and tka.samll_category = tkb.samll_category)
    when matched then
      update
         set tka.total_predict_amount = tkb.predict_delivery_amount,
             tka.update_id            = 'ADMIN',
             tka.update_time          = sysdate
    when not matched then
      insert
        (tka.return_paln_logistics_id  ,
         tka.company_id,
         tka.total_date,
         tka.warehouse_id,
         tka.rela_goo_id,
         tka.category,
         tka.product_cate,
         tka.samll_category,
         tka.total_predict_amount,
         tka.remarks,
         tka.create_id,
         tka.create_time,
         tka.update_id,
         tka.update_time)
      values
        (scmdata.f_get_uuid(),
         tkb.company_id,
         tkb.total_date,
         tkb.warehouse_id,
         tkb.rela_goo_id,
         tkb.category,
         tkb.product_cate,
         tkb.samll_category,
         tkb.predict_delivery_amount,
         ' ',
         'ADMIN',
         sysdate,
         'ADMIN',
         sysdate);
end;

begin
  select count(*)
    into v_count
    from scmdata.t_warehouse_deal_sort tw
   where tw.total_date = trunc(sysdate)
     and tw.warehouse_id = 'GZZ';
  if v_count > 0 then
    select count(*)
      into v1_count
      from scmdata.t_return_paln_logistics tw
     where tw.total_date = trunc(sysdate)
       and tw.warehouse_id = 'GZZ';
     if v1_count = 0 then
       insert into scmdata.t_return_paln_logistics
          ( return_paln_logistics_id,  company_id,  total_date,  warehouse_id,  total_predict_amount, create_id, create_time)
        values
          (scmdata.f_get_uuid(),'b6cc680ad0f599cde0531164a8c0337f', trunc(sysdate),'GZZ','0', 'ADMIN',sysdate);
     end if;
  end if;
    select count(*)
      into v_count
      from scmdata.t_warehouse_deal_sort tw
     where tw.total_date = trunc(sysdate)
       and tw.warehouse_id = 'YWZ';
  if v_count > 0 then
      select count(*)
        into v1_count
        from scmdata.t_return_paln_logistics tw
       where tw.total_date = trunc(sysdate)
         and tw.warehouse_id = 'YWZ'; 
       if v1_count = 0 then
         insert into scmdata.t_return_paln_logistics
            ( return_paln_logistics_id,  company_id,  total_date,  warehouse_id,  total_predict_amount, create_id, create_time)
          values
            (scmdata.f_get_uuid(),'b6cc680ad0f599cde0531164a8c0337f', trunc(sysdate),'YWZ','0', 'ADMIN',sysdate);
       end if;
  end if;
end;

--直发预计到货量
 begin
    merge into scmdata.t_return_paln_logistics tka
    using ( select t.company_id, t.delivery_date total_date,t.sho_id warehouse_id, t.category,
            t.rela_goo_id, t.product_cate, t.samll_category,sum(t.predict_delivery_amount) predict_delivery_amount
  from scmdata.t_order_return_plan t
 where t.finish_time_panda is null
   and (exists
        (select 1 from scmdata.t_straight_list ts where ts.rela_goo_id = t.rela_goo_id) or t.rationame is not null)
   and t.company_id = 'b6cc680ad0f599cde0531164a8c0337f'
 group by t.company_id, t.delivery_date, t.sho_id,t.rela_goo_id, t.category, t.product_cate, t.samll_category ) tkb
    on (tkb.company_id = tka.company_id and tkb.total_date = tka.total_date  and tkb.warehouse_id = tka.warehouse_id
        and tka.rela_goo_id = tkb.rela_goo_id and tka.category = tkb.category 
        and tka.product_cate = tkb.product_cate and tka.samll_category = tkb.samll_category)
    when matched then
      update
         set tka.straight_amount = tkb.predict_delivery_amount,
             tka.update_id       = 'ADMIN',
             tka.update_time     = sysdate;
 end;

---待分拣预计到货量
 begin
    merge into scmdata.t_return_paln_logistics tka
    using ( select t.return_paln_logistics_id, t.total_predict_amount, t.straight_amount,
                   t.total_predict_amount - nvl(t.straight_amount,0) sum1
              from scmdata.t_return_paln_logistics t) tkb
    on (tkb.return_paln_logistics_id  = tka.return_paln_logistics_id  )
    when matched then
      update
         set tka.predict_sort_amount = tkb.sum1,
             tka.update_id           = 'ADMIN',
             tka.update_time         = sysdate;
 end;

---物流预计表更新
  begin
    delete scmdata.t_logistics_sort_capacity t where t.total_date >= trunc(sysdate);
    scmdata.pkg_return_plan.P_LOGISTICS_SORT_CAPACITY;
  end;

end P_WAREHOUSE_DEAL_SORT;

PROCEDURE P_LOGISTICS_SORT_CAPACITY is
  p_capacity_id            varchar2(32);
  p_predict_sort_amount    number;
  p_sort_difference_amount number;
  p_average_efficiency     number;
  p_capacity_id_p          varchar2(32);
  v_count                  number;
  v_count1                 number;
--预计到货总量/直发预计到仓量/待分拣总量
  begin
    merge into scmdata.t_logistics_sort_capacity tka
    using ( select company_id,
                   total_date,
                   warehouse_id,
                   sum(total_predict_amount) total_predict_amount,
                   sum(nvl(straight_amount, 0)) straight_amount,
                   sum(predict_sort_amount) predict_sort_amount
              from scmdata.t_return_paln_logistics
             where total_date >= trunc(sysdate)
             group by company_id, total_date, warehouse_id ) tkb
    on (tkb.company_id = tka.company_id and tkb.total_date = tka.total_date  and tkb.warehouse_id = tka.warehouse_id )
    when matched then
      update
         set tka.total_predict_amount = tkb.total_predict_amount,
             tka.straight_amount      = tkb.straight_amount,
             tka.predict_sort_amount  = tkb.predict_sort_amount,
             tka.update_id            = 'ADMIN',
             tka.update_time          = sysdate
    when not matched then
      insert
        (tka.logistics_sort_capacity_id ,
         tka.company_id,
         tka.total_date,
         tka.warehouse_id,
         tka.total_predict_amount,
         tka.straight_amount,
         tka.predict_sort_amount,
         tka.remarks,
         tka.create_id,
         tka.create_time,
         tka.update_id,
         tka.update_time)
      values
        (scmdata.f_get_uuid(),
         tkb.company_id,
         tkb.total_date,
         tkb.warehouse_id,
         tkb.total_predict_amount,
         tkb.straight_amount,
         tkb.predict_sort_amount,
         ' ',
         'ADMIN',
         sysdate,
         'ADMIN',
         sysdate);
---父id赋值
 begin
  for i in (select distinct warehouse_id
              from scmdata.t_logistics_sort_capacity) loop
    merge into scmdata.t_logistics_sort_capacity tka
    using (select t.logistics_sort_capacity_id,
                 t.total_date,
                 t.warehouse_id,
                 LAG(logistics_sort_capacity_id,1) over (order by total_date,warehouse_id) number1
            from scmdata.t_logistics_sort_capacity t
           where t.warehouse_id = i.warehouse_id
          order by t.total_date ) tkb
    on (tkb.logistics_sort_capacity_id = tka.logistics_sort_capacity_id )
    when matched then
      update
         set tka.parent_id   = tkb.number1,
             tka.update_id   = 'ADMIN',
             tka.update_time = sysdate;
  end loop;
 end;

---累计已到仓未分拣
 begin
    merge into scmdata.t_logistics_sort_capacity tka
    using (select t.company_id, t.total_date, t.warehouse_id,sum(t.unsorted_amount)unsorted_amount
             from scmdata.t_warehouse_deal_sort t
            where t.total_date = trunc(sysdate)
            group by t.company_id, t.total_date, t.warehouse_id ) tkb
    on (tkb.company_id = tka.company_id and tkb.total_date = tka.total_date  and tkb.warehouse_id = tka.warehouse_id)
    when matched then
      update
         set tka.total_delivery_sort_amount = tkb.unsorted_amount,
             tka.update_id                  = 'ADMIN',
             tka.update_time                = sysdate;
 end;

---仓库分拣产能(今天)
 begin
    merge into scmdata.t_logistics_sort_capacity tka
    using ( with effi as(
select t2.company_id,t2.total_date,t2.warehouse_id, sum(t2.sum1) total_time, sum(t2.sum2) / sum(t2.sum1) efficiency
  from (select t1.company_id,t1.total_date, t1.warehouse_id, t1.category, t1.product_cate, t1.samll_category,
               ts.sort_efficiency, t1.sum2, t1.sum2 / ts.sort_efficiency sum1
          from (select t.company_id,t.total_date,t.warehouse_id,t.category, t.product_cate, t.samll_category,
                       sum(t.predict_sort_amount), sum(t.unsorted_amount),
                       sum(t.predict_sort_amount) +sum( t.unsorted_amount) sum2
                  from (select tl.company_id,tl.total_date,tl.warehouse_id,tl.category,tl.product_cate,tl.samll_category, 
                               sum(tl.predict_sort_amount)predict_sort_amount,0 unsorted_amount
                          from scmdata.t_return_paln_logistics tl
                          where tl.total_date = trunc(sysdate)
                         group by tl.company_id,tl.total_date,tl.warehouse_id,tl.category,tl.product_cate,tl.samll_category
                         union 
                        select tw.company_id,tw.total_date,tw.warehouse_id,tw.category,tw.product_cate,tw.samll_category,
                               0 predict_sort_amount,sum(tw.unsorted_amount) unsorted_amount
                          from scmdata.t_warehouse_deal_sort tw
                         where tw.total_date = trunc(sysdate) 
                         group by tw.company_id,tw.total_date,tw.warehouse_id,tw.category,tw.product_cate,tw.samll_category)t
                         group by t.company_id,t.total_date,t.warehouse_id,t.category,t.product_cate,t.samll_category)t1
         inner join scmdata.t_sort_efficiency_config ts
            on ts.category = t1.category
           and ts.product_cate = t1.product_cate
           and ts.samll_category = t1.samll_category
           and ts.warehouse_id = t1.warehouse_id) t2
 group by t2.company_id,t2.total_date, t2.warehouse_id)
select company_id,total_date, warehouse_id, formal_worker, temporary_worker, work_hours, efficiency Average_efficiency,
       ((formal_worker * work_hours ) + (temporary_worker *efficiency_work * work_hours)) * efficiency  sort_capacity
  from (select ef.total_date, ef.warehouse_id, ef.total_time, ef.efficiency,ef.company_id,
               (case when tw1.work_hours is null then tw2.work_hours else tw1.work_hours end) work_hours,
               (case when tw1.formal_worker is null then tw2.formal_worker else tw1.formal_worker end) formal_worker,
               (case when tw1.temporary_worker is null then tw2.temporary_worker else tw1.temporary_worker end) temporary_worker,
               (case when tw1.efficiency_work is null then tw2.efficiency_work else tw1.efficiency_work end)/100 efficiency_work
          from effi ef
          left join scmdata.t_warehouse_worker tw1
            on tw1.warehouse_id = ef.warehouse_id
           and tw1.work_date = ef.total_date
          left join scmdata.t_warehouse_person_config tw2
            on tw2.warehouse_id = ef.warehouse_id) t3  ) tkb
    on (tkb.company_id = tka.company_id and tkb.total_date = tka.total_date  and tkb.warehouse_id = tka.warehouse_id)
    when matched then
      update
         set tka.warehouse_sort_amount = tkb.sort_capacity,
             tka.average_efficiency    = tkb.average_efficiency,
             tka.update_id             = 'ADMIN',
             tka.update_time           = sysdate;
 end;

--待分拣总量、分拣回货差异(今天)
 begin
    merge into scmdata.t_logistics_sort_capacity tka
    using (select t.logistics_sort_capacity_id,
                   t.total_date,
                   t.warehouse_id,
                   t.total_delivery_sort_amount,
                   t.predict_sort_amount,
                   nvl(t.total_delivery_sort_amount,0) + nvl(t.predict_sort_amount,0) sum1,
                   t.warehouse_sort_amount - (nvl(t.total_delivery_sort_amount, 0) + nvl(t.predict_sort_amount, 0))sum2
              from scmdata.t_logistics_sort_capacity t
            where t.total_date = trunc(sysdate) ) tkb
    on (tkb.logistics_sort_capacity_id = tka.logistics_sort_capacity_id and tkb.total_date = tka.total_date  and tkb.warehouse_id = tka.warehouse_id)
    when matched then
      update
         set tka.total_sort_amount             = tkb.sum1,
             tka.sort_return_difference_amount = tkb.sum2,
             tka.update_id                     = 'ADMIN',
             tka.update_time                   = sysdate;
 end;
  
/*日期信息更新*/
begin
  merge into scmdata.t_logistics_sort_capacity tka
  using (select company_id,year,month,week,week1||'/'||week2 yearmonth,logistics_sort_capacity_id,yearweek
  from (select z.year,z.month,z.week,z.yearweek,z.total_date,z.logistics_sort_capacity_id,z.company_id,
              max(case when d.weekord = '1' then to_char(dd_date,'yyyy-mm-dd') end) week1,
              max(case when d.weekord = '7' then to_char(dd_date,'yyyy-mm-dd') end) week2
   from (select distinct t.total_date,td.year,td.month,substr(td.yearweek,5,2) week,td.yearweek,td.weekord,t.logistics_sort_capacity_id ,t.company_id
           from scmdata.t_logistics_sort_capacity t 
          inner join scmdata.t_day_dim td
             on td.dd_date = t.total_date ) z
   left join scmdata.t_day_dim d
     on z.yearweek = d.yearweek
    and d.weekord in ('1', '7')
  group by z.yearweek,z.week,z.month,z.year,z.total_date,z.logistics_sort_capacity_id,z.yearweek,z.company_id ) ) tkb
  on (tkb.company_id = tka.company_id and tkb.logistics_sort_capacity_id = tka.logistics_sort_capacity_id )
  when matched then
    update
       set tka.year      = tkb.year,
           tka.month     = tkb.month,
           tka.yearweek  = tkb.yearweek,
           tka.week      = tkb.week,
           tka.yearmonth = tkb.yearmonth;
end;
/*循环更新表数据*/
begin
  for i in (select distinct warehouse_id
              from scmdata.t_logistics_sort_capacity) loop
    select max(t.logistics_sort_capacity_id),
           max(t.predict_sort_amount),
           max(case when t.sort_return_difference_amount >= 0 then 0 else abs(t.sort_return_difference_amount) end),
           max(t.average_efficiency)
      into p_capacity_id,
           p_predict_sort_amount,
           p_sort_difference_amount,
           p_average_efficiency
      from scmdata.t_logistics_sort_capacity t
     where t.warehouse_id = i.warehouse_id
       and t.total_date = trunc(sysdate);
    select count(*)
      into v_count
      from scmdata.t_logistics_sort_capacity t
     where t.warehouse_id = i.warehouse_id
       and t.total_date > trunc(sysdate);
    v_count1 := 0;
    loop
      scmdata.pkg_return_plan.P_CAPACITY(v_capacity_id            => p_capacity_id,
                                         --v_predict_sort_amount    => p_predict_sort_amount,
                                         v_sort_difference_amount => p_sort_difference_amount,
                                         v_average_efficiency     => p_average_efficiency,
                                         v_capacity_id_p          => p_capacity_id_p);
      select max(t.logistics_sort_capacity_id),
             max(t.predict_sort_amount),
             max(case when t.sort_return_difference_amount >= 0 then 0 else abs(t.sort_return_difference_amount) end),
             max(t.average_efficiency)
        into p_capacity_id,
             p_predict_sort_amount,
             p_sort_difference_amount,
             p_average_efficiency
        from scmdata.t_logistics_sort_capacity t
       where t.logistics_sort_capacity_id = p_capacity_id_p;
      v_count1 := v_count1 + 1;
      exit when v_count1 > v_count;
    end loop;
  end loop;
end;

 end P_LOGISTICS_SORT_CAPACITY;

 PROCEDURE P_CAPACITY( v_capacity_id in varchar2,
                       v_sort_difference_amount in number,
                       v_average_efficiency in number,
                       v_capacity_id_p out varchar2) is 
  p_capacity_id_p              varchar2(32);
  v_total_date                 varchar2(128);
  v_warehouse_id               varchar2(32);
  v_t                          number;
  v_t1                         number;
  v_t2                         number;
  v_efficiency                 number;
  v_work_hours                 number;
  v_formal_worker              number;
  v_temporary_worker           number;
  v_efficiency_work            number;
  v_sort_capacity              number;
  v_difference                 number;
  v_total_delivery             number;
  v_sort_amount                number;
  p_predict_sort_amount          number;
  num1                         number;
begin
/* 本次更新信息id*/
  select max(t.logistics_sort_capacity_id),
         max(to_char(t.total_date,'yyyy-mm-dd')),max(t.predict_sort_amount),
         max(t.warehouse_id)
    into p_capacity_id_p, v_total_date,p_predict_sort_amount, v_warehouse_id
    from scmdata.t_logistics_sort_capacity t
   where t.parent_id = v_capacity_id;
  /*累计已到仓待分拣*/
  v_total_delivery := v_sort_difference_amount;
  /*待分拣总量*/
  v_sort_amount := v_sort_difference_amount + p_predict_sort_amount;
  /*仓库产能计算*/
  /*1).累计已到仓未分拣_用时*/
 if v_average_efficiency = 0 then
   v_t := 0;
 else
   v_t := v_sort_difference_amount / v_average_efficiency;
 end if;
  /*2).待分拣预计到货量_用时*/
 select count(*)
  into num1
  from scmdata.t_return_paln_logistics t
  inner join scmdata.t_sort_efficiency_config ts
    on ts.category = t.category
   and ts.product_cate = t.product_cate
   and ts.samll_category = t.samll_category
   and ts.warehouse_id = t.warehouse_id
 where to_char(t.total_date, 'yyyy-mm-dd') = v_total_date
   and t.warehouse_id = v_warehouse_id;
if num1 > 0 then
  select nvl(sum(t2.sum1),0) total_time
    into v_t1
    from (select t.total_date, t.warehouse_id, t.category, t.product_cate, t.samll_category,
                ts.sort_efficiency, t.predict_sort_amount , t.predict_sort_amount / ts.sort_efficiency sum1
           from (select tl.company_id,tl.total_date,tl.warehouse_id,tl.category,tl.product_cate,tl.samll_category, 
                        sum(tl.predict_sort_amount)predict_sort_amount
                   from scmdata.t_return_paln_logistics tl
                  group by tl.company_id,tl.total_date,tl.warehouse_id,tl.category,tl.product_cate,tl.samll_category) t
          inner join scmdata.t_sort_efficiency_config ts
             on ts.category = t.category
            and ts.product_cate = t.product_cate
            and ts.samll_category = t.samll_category
            and ts.warehouse_id = t.warehouse_id) t2
  where to_char(t2.total_date,'yyyy-mm-dd') = v_total_date
    and t2.warehouse_id = v_warehouse_id
  group by to_char(t2.total_date,'yyyy-mm-dd'), t2.warehouse_id;
else
 v_t1 := '0';
end if;
  /*3).总用时*/
  v_t2 := v_t + v_t1;
  /*4).平均效率*/
  if v_t2 = 0 then
  v_efficiency := 0;
  else
  v_efficiency := v_sort_amount / v_t2;
  end if;
  /*5).分拣产能*/
     select max(case when tw1.work_hours is null then tw2.work_hours else tw1.work_hours end) work_hours,
            max(case when tw1.formal_worker is null then tw2.formal_worker else tw1.formal_worker end) formal_worker,
            max(case when tw1.temporary_worker is null then tw2.temporary_worker else tw1.temporary_worker end) temporary_worker,
            max(case when tw1.efficiency_work is null then tw2.efficiency_work else tw1.efficiency_work end)/100 efficiency_work
       into v_work_hours,v_formal_worker,v_temporary_worker,v_efficiency_work
       from scmdata.t_warehouse_person_config tw2 
       left join scmdata.t_warehouse_worker tw1
         on tw2.warehouse_person_config_id = tw1.warehouse_person_config_id
        and to_char(tw1.work_date ,'yyyy-mm-dd') = v_total_date
      where tw2.warehouse_id = v_warehouse_id;
  v_sort_capacity := ((v_formal_worker * v_work_hours) +
                     (v_temporary_worker * v_efficiency_work *
                     v_work_hours)) * v_efficiency;
  /*分拣回货差异*/
  v_difference := v_sort_capacity - v_sort_amount;
  /*更新数据*/
  update scmdata.t_logistics_sort_capacity t
     set t.total_delivery_sort_amount    = v_total_delivery,
         t.total_sort_amount             = v_sort_amount,
         t.warehouse_sort_amount         = v_sort_capacity,
         t.sort_return_difference_amount = v_difference,
         t.average_efficiency            = v_efficiency,
         t.update_id                     = 'ADMIN',
         t.update_time                   = sysdate
   where t.logistics_sort_capacity_id = p_capacity_id_p;
   v_capacity_id_p := p_capacity_id_p;
end P_CAPACITY; 


end pkg_return_plan;
/

