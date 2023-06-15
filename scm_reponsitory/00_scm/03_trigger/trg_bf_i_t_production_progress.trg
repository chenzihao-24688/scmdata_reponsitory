create or replace trigger scmdata.trg_bf_i_t_production_progress
  before insert on t_production_progress
  for each row
declare
  -- local variables here
  p_commodity_info   scmdata.t_commodity_info%rowtype;
  p_i                int;
  judge              number(1);
  p_is_setting       varchar2(32);
  p_config_id        varchar2(32);
  p_scope            varchar2(32);
  p_is_product_order number(1);
begin

  --同步面检环节
  select max(a.check_link)
    into :new.check_link
    from scmdata.t_check_request a
   where a.goo_id = :new.goo_id
     and a.company_id = :new.company_id;

  select nvl(max(1), 0)
    into p_i
    from scmdata.t_fabric_evaluate a
   where a.goo_id = :new.goo_id
     and a.company_id = :new.company_id;

  --20220425只同步生产订单的待送检
  select nvl(max(a.is_product_order), 0)
    into p_is_product_order
    from scmdata.t_ordered a
   where a.order_code = :new.order_id
     and a.company_id = :new.company_id;

  if p_i = 1 then
    --同步色码是否待送检
  
    if p_is_product_order = 1 then
      for x in (select k.fabric_color_evaluate_id
                  from scmdata.t_ordersitem o
                 inner join scmdata.t_commodity_color_size ccs
                    on ccs.barcode = o.barcode
                   and o.company_id = ccs.company_id
                 inner join scmdata.t_fabric_color_evaluate k
                    on k.company_id = ccs.company_id
                   and k.colorname = ccs.colorname
                   and k.goo_id = o.goo_id
                 where o.order_id = :new.order_id
                   and o.company_id = :new.company_id
                   and k.evaluate_result is null) loop
        update scmdata.t_fabric_color_evaluate k
           set k.evaluate_result = 'FABRIC_EVELUATE_NOT_SEND'
         where k.fabric_color_evaluate_id = x.fabric_color_evaluate_id;
      end loop;
    end if;
    --同步面检评估结果（不包括印绣花）
    select case
             when evaluate_result = 0 then
              'FABRIC_EVELUATE_PASS'
             when evaluate_result > 0 then
              'FABRIC_EVELUATE_NO_PASS'
             when evaluate_result < -10000 then
              'FABRIC_EVELUATE_WAIT'
             else
              'FABRIC_EVELUATE_NOT_SEND'
           end evaluate_result
      into :new.fabric_check_extend_01
      from (select sum(case
                         when exists
                          (select 1
                                 from scmdata.t_check_request a
                                where a.goo_id = k.goo_id
                                  and a.company_id = k.company_id
                                  and instr(';' || a.color_list || ';',
                                            ';' || ltrim(rtrim(k.colorname)) || ';') > 0
                                  and a.create_time >
                                      nvl(k.evaluate_time,
                                          to_date('2000-01-01', 'yyyy-mm-dd'))) then
                          -15000
                         when k.evaluate_result = 'FABRIC_EVELUATE_NOT_SEND' then
                          -100
                         when k.evaluate_result = 'FABRIC_EVELUATE_NO_PASS' then
                          1
                         else
                          0
                       end) evaluate_result
              from scmdata.t_ordersitem o
             inner join scmdata.t_commodity_color_size ccs
                on ccs.barcode = o.barcode
               and o.company_id = ccs.company_id
             inner join scmdata.t_fabric_color_evaluate k
                on k.company_id = ccs.company_id
               and k.colorname = ccs.colorname
               and k.goo_id = o.goo_id
               and k.evaluate_type = 'ML'
             where o.order_id = :new.order_id
               and o.company_id = :new.company_id);
    --同步面检评估结果（包括印绣花）
    select case
             when evaluate_result = 0 then
              'FABRIC_EVELUATE_PASS'
             when evaluate_result > 0 then
              'FABRIC_EVELUATE_NO_PASS'
             when evaluate_result < -10000 then
              'FABRIC_EVELUATE_WAIT'
             else
              'FABRIC_EVELUATE_NOT_SEND'
           end evaluate_result
      into :new.fabric_check
      from (select sum(case
                         when exists
                          (select 1
                                 from scmdata.t_check_request a
                                where a.goo_id = k.goo_id
                                  and a.company_id = k.company_id
                                  and instr(';' || a.color_list || ';',
                                            ';' || ltrim(rtrim(k.colorname)) || ';') > 0
                                  and a.create_time >
                                      nvl(k.evaluate_time,
                                          to_date('2000-01-01', 'yyyy-mm-dd'))) then
                          -15000
                         when k.evaluate_result = 'FABRIC_EVELUATE_NOT_SEND' then
                          -100
                         when k.evaluate_result = 'FABRIC_EVELUATE_NO_PASS' then
                          1
                         else
                          0
                       end) evaluate_result
              from scmdata.t_ordersitem o
             inner join scmdata.t_commodity_color_size ccs
                on ccs.barcode = o.barcode
               and o.company_id = ccs.company_id
             inner join scmdata.t_fabric_color_evaluate k
                on k.company_id = ccs.company_id
               and k.colorname = ccs.colorname
               and k.goo_id = o.goo_id
            
             where o.order_id = :new.order_id
               and o.company_id = :new.company_id);
  
    scmdata.pkg_fabric_evaluate.p_update_evaluate_result(pi_goo_id          => :new.goo_id,
                                                         pi_company_id      => :new.company_id,
                                                         pi_except_progress => 1);
  elsif p_is_product_order = 1 then
    --没有评估的时候，根据配置决定是否显示送检，
    select *
      into p_commodity_info
      from t_commodity_info a
     where a.goo_id = :new.goo_id
       and a.company_id = :new.company_id;
    --制定面料不显示
    if p_commodity_info.is_set_fabric = 1 then
      return;
    end if;
    --现货供应商不显示 生产C00216，测试C00198,开发C03002
    if p_commodity_info.supplier_code = '开发C03002' and
       p_commodity_info.category in ('00', '01') then
      return;
    end if;
  
    select max(a.check_config_id),
           max(a.is_config),
           max(a.scope_application)
      into p_config_id, p_is_setting, p_scope
      from t_check_config a
     where a.check_type = 'INTERAL_TESTING'
       and company_id = p_commodity_info.company_id;
  
    if p_config_id is not null and p_is_setting is not null and
       p_is_setting = 1 then
      if p_scope = '全部' then
      
        --生成fabric_check
      
        scmdata.pkg_fabric_evaluate.p_insert_FABRIC_EVALUATE_GOO_ID(pi_goo_id          => :new.goo_id,
                                                                    pi_company_id      => :new.company_id,
                                                                    pi_except_progress => 1);
        :NEW.FABRIC_CHECK           := 'FABRIC_EVELUATE_NOT_SEND';
        :new.fabric_check_extend_01 := 'FABRIC_EVELUATE_NOT_SEND';
      elsif p_scope = '部分' then
        select max(1)
          into judge
          from scmdata.t_check_class_config c
         where c.check_config_id = p_config_id
           and pause = 0
           and c.industry_classification = p_commodity_info.category
           and c.production_category = p_commodity_info.product_cate
           and instr(';' || c.product_subclass || ';',
                     ';' || p_commodity_info.samll_category || ';') > 0;
        if judge = 1 then
          :NEW.FABRIC_CHECK           := 'FABRIC_EVELUATE_NOT_SEND';
          :new.fabric_check_extend_01 := 'FABRIC_EVELUATE_NOT_SEND';
        
          scmdata.pkg_fabric_evaluate.p_insert_FABRIC_EVALUATE_GOO_ID(pi_goo_id          => :new.goo_id,
                                                                      pi_company_id      => :new.company_id,
                                                                      pi_except_progress => 1);
        end if;
      end if;
    end if;
  end if;
end trg_bf_i_t_production_progress;
/

