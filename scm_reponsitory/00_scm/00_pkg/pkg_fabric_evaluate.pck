create or replace package scmdata.PKG_FABRIC_EVALUATE is

  -- Author  : zwh73
  -- Created : 2020/12/21 13:52:38
  -- Purpose : 面料检测相关

  --面料检测新增
  PROCEDURE p_insert_FABRIC_EVALUATE(pi_commodity_info_id in varchar2,
                                     pi_user_id           in varchar2);

  --印绣花同步
  procedure p_sync_yxh_by_approve(pi_approve_version_id in varchar2);

  --根据货号新增
  PROCEDURE p_insert_FABRIC_EVALUATE_GOO_ID(pi_goo_id          in varchar2,
                                            pi_company_id      varchar2,
                                            pi_except_progress number default 0);

  procedure p_update_evaluate_result(pi_goo_id          in varchar2,
                                     pi_company_id      in varchar2,
                                     pi_except_progress number default 0);

  procedure p_update_last_check_link(pi_goo_id     in varchar2,
                                     pi_company_id in varchar2);

  procedure p_update_last_check_result(pi_goo_id     in varchar2,
                                       pi_company_id in varchar2);

  procedure p_generate_yxh_evaluate_when_insert(pi_goo_id           in varchar2,
                                                pi_company_id       in varchar2,
                                                pi_check_request_id in varchar2);
end PKG_FABRIC_EVALUATE;
/

create or replace package body scmdata.PKG_FABRIC_EVALUATE is

  PROCEDURE p_insert_FABRIC_EVALUATE(pi_commodity_info_id in varchar2,
                                     pi_user_id           in varchar2) is
    p_commodity_info scmdata.t_commodity_info%rowtype;
    SUBCATE_STR      VARCHAR2(1000);
    judge            number(1);
    p_is_setting     varchar2(32);
    p_config_id      varchar2(32);
    p_scope          varchar2(32);
    p_has_app        int;
  begin
    --商品档案
    select *
      into p_commodity_info
      from t_commodity_info a
     where a.commodity_info_id = pi_commodity_info_id;
  
    p_has_app := scmdata.pkg_plat_comm.f_company_has_app(pi_company_id => p_commodity_info.company_id,
                                                         PI_APPLY_ID   => 'apply_9');
  
    if p_has_app = 0 then
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
        insert into scmdata.t_fabric_evaluate
          (fabric_evaluate_id,
           evaluate_id,
           evaluate_result,
           evaluate_time,
           create_id,
           create_time,
           collect_time,
           memo,
           goo_id,
           update_id,
           update_time,
           check_type,
           company_id)
        values
          (f_get_uuid(),
           null,
           null,
           null,
           nvl(pi_user_id, p_commodity_info.create_id),
           p_commodity_info.create_time,
           sysdate,
           null,
           p_commodity_info.goo_id,
           null,
           null,
           'INTERAL_TESTING',
           p_commodity_info.company_id);
        return;
      elsif p_scope = '部分' then
      
        select LISTAGG(b.product_subclass, ';')
          into SUBCATE_STR
          from scmdata.t_check_class_config b
         where p_config_id = b.check_config_id
           and pause = 0;
        select count(1)
          into judge
          from dual
         where instr(';' || SUBCATE_STR || ';',
                     ';' || p_commodity_info.samll_category || ';') > 0;
        if judge = 1 then
          insert into scmdata.t_fabric_evaluate
            (fabric_evaluate_id,
             evaluate_id,
             evaluate_result,
             evaluate_time,
             create_id,
             create_time,
             collect_time,
             memo,
             goo_id,
             update_id,
             update_time,
             check_type,
             company_id)
          values
            (f_get_uuid(),
             null,
             null,
             null,
             nvl(pi_user_id, p_commodity_info.create_id),
             p_commodity_info.create_time,
             sysdate,
             null,
             p_commodity_info.goo_id,
             null,
             null,
             'INTERAL_TESTING',
             p_commodity_info.company_id);
          return;
        end if;
      end if;
    end if;
  
    select max(a.check_config_id),
           max(a.is_config),
           max(a.scope_application)
      into p_config_id, p_is_setting, p_scope
      from t_check_config a
     where a.check_type = 'THIRD_PARTY_TESTING'
       and company_id = p_commodity_info.company_id;
  
    if p_config_id is not null and p_is_setting is not null and
       p_is_setting = 1 then
      if p_scope = '全部' then
        insert into scmdata.t_fabric_evaluate
          (fabric_evaluate_id,
           evaluate_id,
           evaluate_result,
           evaluate_time,
           create_id,
           create_time,
           collect_time,
           memo,
           goo_id,
           update_id,
           update_time,
           check_type,
           company_id)
        values
          (f_get_uuid(),
           null,
           null,
           null,
           nvl(pi_user_id, p_commodity_info.create_id),
           p_commodity_info.create_time,
           sysdate,
           null,
           p_commodity_info.goo_id,
           null,
           null,
           'THIRD_PARTY_TESTING',
           p_commodity_info.company_id);
        return;
      elsif p_scope = '部分' then
      
        select LISTAGG(b.product_subclass, ';')
          into SUBCATE_STR
          from scmdata.t_check_class_config b
         where p_config_id = b.check_config_id
           and pause = 0;
        select count(1)
          into judge
          from dual
         where instr(';' || SUBCATE_STR || ';',
                     ';' || p_commodity_info.samll_category || ';') > 0;
        if judge = 1 then
          insert into scmdata.t_fabric_evaluate
            (fabric_evaluate_id,
             evaluate_id,
             evaluate_result,
             evaluate_time,
             create_id,
             create_time,
             collect_time,
             memo,
             goo_id,
             update_id,
             update_time,
             check_type,
             company_id)
          values
            (f_get_uuid(),
             null,
             null,
             null,
             nvl(pi_user_id, p_commodity_info.create_id),
             p_commodity_info.create_time,
             sysdate,
             null,
             p_commodity_info.goo_id,
             null,
             null,
             'THIRD_PARTY_TESTING',
             p_commodity_info.company_id);
          return;
        end if;
      end if;
    end if;
  
    select max(a.check_config_id),
           max(a.is_config),
           max(a.scope_application)
      into p_config_id, p_is_setting, p_scope
      from t_check_config a
     where a.check_type = 'SELF_TESTING'
       and company_id = p_commodity_info.company_id;
  
    if p_config_id is not null and p_is_setting is not null and
       p_is_setting = 1 then
      if p_scope = '全部' then
        insert into scmdata.t_fabric_evaluate
          (fabric_evaluate_id,
           evaluate_id,
           evaluate_result,
           evaluate_time,
           create_id,
           create_time,
           collect_time,
           memo,
           goo_id,
           update_id,
           update_time,
           check_type,
           company_id)
        values
          (f_get_uuid(),
           null,
           null,
           null,
           nvl(pi_user_id, p_commodity_info.create_id),
           p_commodity_info.create_time,
           sysdate,
           null,
           p_commodity_info.goo_id,
           null,
           null,
           'SELF_TESTING',
           p_commodity_info.company_id);
        return;
      elsif p_scope = '部分' then
      
        select LISTAGG(b.supplier_info_id, ';')
          into SUBCATE_STR
          from scmdata.t_check_supp_config b
         where p_config_id = b.check_config_id
           and pause = 0;
      
        select count(1)
          into judge
          from dual
         where instr(';' || SUBCATE_STR || ';',
                     ';' ||
                     (select supplier_info_id
                        from t_supplier_info
                       where company_id = p_commodity_info.company_id
                         and supplier_code = p_commodity_info.supplier_code) || ';') > 0;
        if judge = 1 then
          insert into scmdata.t_fabric_evaluate
            (fabric_evaluate_id,
             evaluate_id,
             evaluate_result,
             evaluate_time,
             create_id,
             create_time,
             collect_time,
             memo,
             goo_id,
             update_id,
             update_time,
             check_type,
             company_id)
          values
            (f_get_uuid(),
             null,
             'FABRIC_EVELUATE_WAIT',
             null,
             nvl(pi_user_id, p_commodity_info.create_id),
             p_commodity_info.create_time,
             sysdate,
             null,
             p_commodity_info.goo_id,
             null,
             null,
             'SELF_TESTING',
             p_commodity_info.company_id);
          return;
        end if;
      end if;
    end if;
  end p_insert_FABRIC_EVALUATE;

  --印绣花同步
  procedure p_sync_yxh_by_approve(pi_approve_version_id in varchar2) is
    p_flag               number(1);
    P_fabric_evaluate_id scmdata.t_fabric_evaluate.fabric_evaluate_id%type;
    p_approve_version    scmdata.t_approve_version%rowtype;
  begin
  
    select *
      into p_approve_version
      from scmdata.t_approve_version a
     where a.approve_version_id = pi_approve_version_id;
  
    --如果已经同步，不重复生成
    select nvl(max(1), 0)
      into p_flag
      from scmdata.t_commodity_info a
     where a.goo_id = p_approve_version.goo_id
       and a.company_id = p_approve_version.company_id
       and a.need_yxh_check = 1;
    if p_flag = 1 then
      return;
    end if;
    --检查批版印绣花是否有对应数据
  
    select nvl(max(1), 0)
      into p_flag
      from scmdata.t_approve_risk_assessment a
     where a.approve_version_id = pi_approve_version_id
       and a.assess_type = 'EVAL12'
       and a.assess_result in ('EVRT01', 'EVRT02', 'EVRT03');
  
    if p_flag = 1 then
      update scmdata.t_commodity_info a
         set a.need_yxh_check = 1
       where a.goo_id = p_approve_version.goo_id
         and a.company_id = p_approve_version.company_id;
    
      select max(a.fabric_evaluate_id)
        into P_fabric_evaluate_id
        from scmdata.t_fabric_evaluate a
       where a.company_id = p_approve_version.company_id
         and a.goo_id = p_approve_version.goo_id;
      if P_fabric_evaluate_id is not null then
        merge into scmdata.t_fabric_color_evaluate a
        using (select distinct co.colorname, co.goo_id, co.company_id
                 from scmdata.t_commodity_color_size co
                where co.goo_id = p_approve_version.goo_id
                  and co.company_id = p_approve_version.company_id) b
        on (a.goo_id = b.goo_id and a.company_id = b.company_id and a.colorname = b.colorname and a.evaluate_type = 'YXH')
        when not matched then
          insert
            (a.fabric_color_evaluate_id,
             a.evaluate_id,
             a.evaluate_result,
             a.evaluate_time,
             a.create_id,
             a.create_time,
             a.memo,
             a.goo_id,
             a.colorname,
             a.update_id,
             a.update_time,
             a.company_id,
             a.risk_level,
             a.evaluate_times,
             a.evaluate_type)
          values
            (f_get_uuid(),
             p_fabric_evaluate_id,
             null,
             null,
             'ADMIN',
             sysdate,
             null,
             b.goo_id,
             b.colorname,
             'ADMIN',
             sysdate,
             b.company_id,
             null,
             0,
             'YXH');
      
        update scmdata.t_fabric_color_evaluate k
           set k.evaluate_result = 'FABRIC_EVELUATE_NOT_SEND'
         where k.fabric_color_evaluate_id in
               (select k.fabric_color_evaluate_id
                  from scmdata.t_ordersitem o
                 inner join scmdata.t_ordered oe
                    on oe.order_code = o.order_id
                   and o.company_id = oe.company_id
                 inner join scmdata.t_commodity_color_size ccs
                    on ccs.barcode = o.barcode
                   and o.company_id = ccs.company_id
                 inner join scmdata.t_fabric_color_evaluate k
                    on k.company_id = ccs.company_id
                   and k.colorname = ccs.colorname
                   and k.goo_id = o.goo_id
                 where o.goo_id = p_approve_version.goo_id
                   and o.company_id = p_approve_version.company_id
                   and oe.is_product_order = 1
                   and k.evaluate_type = 'YXH'
                   and k.evaluate_result is null);
        scmdata.pkg_fabric_evaluate.p_update_evaluate_result(pi_goo_id     => p_approve_version.goo_id,
                                                             pi_company_id => p_approve_version.company_id);
      end if;
    end if;
  
  end p_sync_yxh_by_approve;

  --根据货号新增
  PROCEDURE p_insert_FABRIC_EVALUATE_GOO_ID(pi_goo_id          in varchar2,
                                            pi_company_id      varchar2,
                                            pi_except_progress number default 0) is
    p_commodity_info     scmdata.t_commodity_info%rowtype;
    P_fabric_evaluate_id scmdata.t_fabric_evaluate.fabric_evaluate_id%type;
  begin
    --是否已增加过
    select max(a.fabric_evaluate_id)
      into P_fabric_evaluate_id
      from scmdata.t_fabric_evaluate a
     where a.company_id = pi_company_id
       and a.goo_id = pi_goo_id;
    if P_fabric_evaluate_id is not null then
      return;
    end if;
    select *
      into p_commodity_info
      from scmdata.t_commodity_info a
     where a.company_id = pi_company_id
       and a.goo_id = pi_goo_id;
    insert into scmdata.t_fabric_evaluate
      (fabric_evaluate_id,
       evaluate_id,
       evaluate_result,
       evaluate_time,
       create_id,
       create_time,
       collect_time,
       memo,
       goo_id,
       update_id,
       update_time,
       check_type,
       company_id)
    values
      (f_get_uuid(),
       null,
       'FABRIC_EVELUATE_WAIT',
       null,
       p_commodity_info.create_id,
       sysdate,
       sysdate,
       null,
       p_commodity_info.goo_id,
       null,
       null,
       'INTERAL_TESTING',
       p_commodity_info.company_id);
    /*update scmdata.t_production_progress t
       set t.fabric_check = 'FABRIC_EVELUATE_WAIT'
     where t.company_id = p_commodity_info.company_id
       and t.goo_id = p_commodity_info.goo_id;
    update scmdata.t_qc_goo_collect t
       set t.fabric_check = 'FABRIC_EVELUATE_WAIT'
     where t.company_id = p_commodity_info.company_id
       and t.goo_id = p_commodity_info.goo_id;*/
    merge into scmdata.t_fabric_color_evaluate a
    using (select distinct co.colorname, co.goo_id, co.company_id
             from scmdata.t_commodity_color_size co
            where co.goo_id = p_commodity_info.goo_id
              and co.company_id = p_commodity_info.company_id) b
    on (a.goo_id = b.goo_id and a.company_id = b.company_id and a.colorname = b.colorname and a.evaluate_type = 'ML')
    when not matched then
      insert
        (a.fabric_color_evaluate_id,
         a.evaluate_id,
         a.evaluate_result,
         a.evaluate_time,
         a.create_id,
         a.create_time,
         a.memo,
         a.goo_id,
         a.colorname,
         a.update_id,
         a.update_time,
         a.company_id,
         a.risk_level,
         a.evaluate_times)
      values
        (f_get_uuid(),
         null,
         null,
         null,
         'ADMIN',
         sysdate,
         null,
         b.goo_id,
         b.colorname,
         'ADMIN',
         sysdate,
         b.company_id,
         null,
         0);
    if p_commodity_info.need_yxh_check = 1 then
      merge into scmdata.t_fabric_color_evaluate a
      using (select distinct co.colorname, co.goo_id, co.company_id
               from scmdata.t_commodity_color_size co
              where co.goo_id = p_commodity_info.goo_id
                and co.company_id = p_commodity_info.company_id) b
      on (a.goo_id = b.goo_id and a.company_id = b.company_id and a.colorname = b.colorname and a.evaluate_type = 'YXH')
      when not matched then
        insert
          (a.fabric_color_evaluate_id,
           a.evaluate_id,
           a.evaluate_result,
           a.evaluate_time,
           a.create_id,
           a.create_time,
           a.memo,
           a.goo_id,
           a.colorname,
           a.update_id,
           a.update_time,
           a.company_id,
           a.risk_level,
           a.evaluate_times,
           a.evaluate_type)
        values
          (f_get_uuid(),
           p_fabric_evaluate_id,
           null,
           null,
           'ADMIN',
           sysdate,
           null,
           b.goo_id,
           b.colorname,
           'ADMIN',
           sysdate,
           b.company_id,
           null,
           0,
           'YXH');
    end if;
  
    --待送检重刷（印绣花部分）
    update scmdata.t_fabric_color_evaluate k
       set k.evaluate_result = 'FABRIC_EVELUATE_NOT_SEND'
     where k.fabric_color_evaluate_id in
           (select k.fabric_color_evaluate_id
              from scmdata.t_ordersitem o
             inner join scmdata.t_ordered oe
                on oe.order_code = o.order_id
               and o.company_id = oe.company_id
             inner join scmdata.t_commodity_color_size ccs
                on ccs.barcode = o.barcode
               and o.company_id = ccs.company_id
             inner join scmdata.t_fabric_color_evaluate k
                on k.company_id = ccs.company_id
               and k.colorname = ccs.colorname
               and k.goo_id = o.goo_id
             where o.goo_id = pi_goo_id
               and o.company_id = pi_company_id
               and k.evaluate_type = 'YXH'
               and oe.is_product_order = 1
               and k.evaluate_result is null);
    --待送检重刷
    update scmdata.t_fabric_color_evaluate k
       set k.evaluate_result = 'FABRIC_EVELUATE_NOT_SEND'
     where k.fabric_color_evaluate_id in
           (select k.fabric_color_evaluate_id
              from scmdata.t_ordersitem o
             inner join scmdata.t_ordered oe
                on oe.order_code = o.order_id
               and o.company_id = oe.company_id
             inner join scmdata.t_commodity_color_size ccs
                on ccs.barcode = o.barcode
               and o.company_id = ccs.company_id
             inner join scmdata.t_fabric_color_evaluate k
                on k.company_id = ccs.company_id
               and k.colorname = ccs.colorname
               and k.goo_id = o.goo_id
             where o.goo_id = pi_goo_id
               and o.company_id = pi_company_id
               and oe.order_type not in ('PP', 'WP')
               and k.evaluate_type = 'ML'
               and oe.is_product_order = 1
               and (k.evaluate_result is null or
                   k.evaluate_result = 'FABRIC_EVELUATE_NO_SEND'));
    --不送检重刷
    update scmdata.t_fabric_color_evaluate k
       set k.evaluate_result = 'FABRIC_EVELUATE_NO_SEND'
     where k.fabric_color_evaluate_id in
           (select k.fabric_color_evaluate_id
              from scmdata.t_ordersitem o
             inner join scmdata.t_ordered oe
                on oe.order_code = o.order_id
               and o.company_id = oe.company_id
             inner join scmdata.t_commodity_color_size ccs
                on ccs.barcode = o.barcode
               and o.company_id = ccs.company_id
             inner join scmdata.t_fabric_color_evaluate k
                on k.company_id = ccs.company_id
               and k.colorname = ccs.colorname
               and k.goo_id = o.goo_id
             where o.goo_id = pi_goo_id
               and o.company_id = pi_company_id
               and oe.order_type in ('PP', 'WP')
               and k.evaluate_type = 'ML'
               and oe.is_product_order = 1
               and k.evaluate_result is null);
    if pi_except_progress = 0 then
      scmdata.pkg_fabric_evaluate.p_update_evaluate_result(pi_goo_id     => p_commodity_info.goo_id,
                                                           pi_company_id => p_commodity_info.company_id);
    else
      scmdata.pkg_fabric_evaluate.p_update_evaluate_result(pi_goo_id          => p_commodity_info.goo_id,
                                                           pi_company_id      => p_commodity_info.company_id,
                                                           pi_except_progress => 1);
    end if;
  end p_insert_FABRIC_EVALUATE_GOO_ID;

  procedure p_update_evaluate_result(pi_goo_id          in varchar2,
                                     pi_company_id      in varchar2,
                                     pi_except_progress number default 0) is
    --p_evaluate_result    varchar2(32);
    p_ml_evaluate_result varchar2(32);
    p_risk_level         varchar2(32);
    p_CONTROL_MEASURES   varchar2(128);
    p_num_to_be_audit    number(18);
  begin
    --若货号中存在存在未审核的补充审核
    update scmdata.t_fabric_color_evaluate k
       set k.evaluate_result = 'FABRIC_EVELUATE_WAIT'
     where exists
     (select 1
              from scmdata.t_check_request a
             where a.goo_id = k.goo_id
               and a.company_id = k.company_id
               and instr(';' || a.color_list || ';',
                         ';' || ltrim(rtrim(k.colorname)) || ';') > 0
               and ((k.evaluate_type = 'ML' and a.check_link <> 'LINK_05') or
                   (k.evaluate_type = 'YXH' and a.check_link = 'LINK_05'))
               and a.create_time >
                   nvl(k.evaluate_time, to_date('2000-01-01', 'yyyy-mm-dd')))
       and (k.evaluate_result is null or
           k.evaluate_result in
           ('FABRIC_EVELUATE_NOT_SEND', 'FABRIC_EVELUATE_NO_SEND'))
       and k.goo_id = pi_goo_id
       and k.company_id = pi_company_id;
    --删去待审核
    update scmdata.t_fabric_color_evaluate k
       set k.evaluate_result = null
     where not exists
     (select 1
              from scmdata.t_check_request a
             where a.goo_id = k.goo_id
               and a.company_id = k.company_id
               and instr(';' || a.color_list || ';',
                         ';' || ltrim(rtrim(k.colorname)) || ';') > 0
               and ((k.evaluate_type = 'ML' and a.check_link <> 'LINK_05') or
                   (k.evaluate_type = 'YXH' and a.check_link = 'LINK_05'))
               and a.create_time >
                   nvl(k.evaluate_time, to_date('2000-01-01', 'yyyy-mm-dd')))
       and k.evaluate_result = 'FABRIC_EVELUATE_WAIT'
       and k.goo_id = pi_goo_id
       and k.company_id = pi_company_id;
    --待送检重刷（印绣花部分）
    update scmdata.t_fabric_color_evaluate k
       set k.evaluate_result = 'FABRIC_EVELUATE_NOT_SEND'
     where k.fabric_color_evaluate_id in
           (select k.fabric_color_evaluate_id
              from scmdata.t_ordersitem o
             inner join scmdata.t_ordered oe
                on oe.order_code = o.order_id
               and o.company_id = oe.company_id
             inner join scmdata.t_commodity_color_size ccs
                on ccs.barcode = o.barcode
               and o.company_id = ccs.company_id
             inner join scmdata.t_fabric_color_evaluate k
                on k.company_id = ccs.company_id
               and k.colorname = ccs.colorname
               and k.goo_id = o.goo_id
             where o.goo_id = pi_goo_id
               and o.company_id = pi_company_id
               and k.evaluate_type = 'YXH'
               and oe.is_product_order = 1
               and k.evaluate_result is null);
    --待送检重刷
    update scmdata.t_fabric_color_evaluate k
       set k.evaluate_result = 'FABRIC_EVELUATE_NOT_SEND'
     where k.fabric_color_evaluate_id in
           (select k.fabric_color_evaluate_id
              from scmdata.t_ordersitem o
             inner join scmdata.t_ordered oe
                on oe.order_code = o.order_id
               and o.company_id = oe.company_id
             inner join scmdata.t_commodity_color_size ccs
                on ccs.barcode = o.barcode
               and o.company_id = ccs.company_id
             inner join scmdata.t_fabric_color_evaluate k
                on k.company_id = ccs.company_id
               and k.colorname = ccs.colorname
               and k.goo_id = o.goo_id
             where o.goo_id = pi_goo_id
               and o.company_id = pi_company_id
               and oe.order_type not in ('PP', 'WP')
               and k.evaluate_type = 'ML'
               and oe.is_product_order = 1
               and (k.evaluate_result is null or
                   k.evaluate_result = 'FABRIC_EVELUATE_NO_SEND'));
    --不送检重刷
    update scmdata.t_fabric_color_evaluate k
       set k.evaluate_result = 'FABRIC_EVELUATE_NO_SEND'
     where k.fabric_color_evaluate_id in
           (select k.fabric_color_evaluate_id
              from scmdata.t_ordersitem o
             inner join scmdata.t_ordered oe
                on oe.order_code = o.order_id
               and o.company_id = oe.company_id
             inner join scmdata.t_commodity_color_size ccs
                on ccs.barcode = o.barcode
               and o.company_id = ccs.company_id
             inner join scmdata.t_fabric_color_evaluate k
                on k.company_id = ccs.company_id
               and k.colorname = ccs.colorname
               and k.goo_id = o.goo_id
             where o.goo_id = pi_goo_id
               and o.company_id = pi_company_id
               and oe.order_type in ('PP', 'WP')
               and k.evaluate_type = 'ML'
               and oe.is_product_order = 1
               and k.evaluate_result is null);
    /*--货号结果
    select case
             when evaluate_result = 0 then
              'FABRIC_EVELUATE_PASS'
             when evaluate_result > 0 then
              'FABRIC_EVELUATE_NO_PASS'
             when evaluate_result < -10000 then
              'FABRIC_EVELUATE_WAIT'
             else
              'FABRIC_EVELUATE_NOT_SEND'
           end evaluate_result,
           case
             when evaluate_result < 0 then
              null
             else
              risk_level
           end risk_level,
           
           control_measures,
           num_to_be_audit
      into p_evaluate_result,
           p_risk_level,
           p_CONTROL_MEASURES,
           p_num_to_be_audit
      from (select sum(case
                         when exists
                          (select 1
                                 from scmdata.t_check_request a
                                where a.goo_id = k.goo_id
                                  and a.company_id = k.company_id
                                  and instr(';' || a.color_list || ';',
                                            ';' || k.colorname || ';') > 0
                                  and ((k.evaluate_type = 'ML' and
                                      a.check_link <> 'LINK_05') or
                                      (k.evaluate_type = 'YXH' and
                                      a.check_link = 'LINK_05'))
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
                       end) evaluate_result,
                   sum(case
                         when exists
                          (select 1
                                 from scmdata.t_check_request a
                                where a.goo_id = k.goo_id
                                  and a.company_id = k.company_id
                                  and instr(';' || a.color_list || ';',
                                            ';' || k.colorname || ';') > 0
                                  and ((k.evaluate_type = 'ML' and
                                      a.check_link <> 'LINK_05') or
                                      (k.evaluate_type = 'YXH' and
                                      a.check_link = 'LINK_05'))
                                  and a.create_time >
                                      nvl(k.evaluate_time,
                                          to_date('2000-01-01', 'yyyy-mm-dd'))) then
                          1
                         else
                          0
                       end) num_to_be_audit,
                   max(k.risk_level) risk_level,
                   listagg(k.control_measures, ';') control_measures
              from scmdata.t_fabric_color_evaluate k
             where k.goo_id = pi_goo_id
               and k.company_id = pi_company_id
               and k.evaluate_result is not null);
    if p_CONTROL_MEASURES is not null then
      select listagg(distinct y, ';') within group(order by 1)
        into p_CONTROL_MEASURES
        from (SELECT REGEXP_SUBSTR(p_CONTROL_MEASURES,
                                   '[^;]+',
                                   1,
                                   LEVEL,
                                   'i') y
                FROM dual
              CONNECT BY LEVEL <=
                         LENGTH(p_CONTROL_MEASURES) -
                         LENGTH(REGEXP_REPLACE(p_CONTROL_MEASURES, ';', '')) + 1);
    end if;
    --货号结果
    update scmdata.t_fabric_evaluate a
       set a.evaluate_result  = p_evaluate_result,
           a.risk_level       = p_risk_level,
           a.CONTROL_MEASURES = p_CONTROL_MEASURES,
           a.num_to_be_audit  = p_num_to_be_audit
     where a.goo_id = pi_goo_id
       and a.company_id = pi_company_id;*/
  
    --货号仅面料结果
    select case
             when evaluate_result = 0 then
              'FABRIC_EVELUATE_NO_SEND'
             when evaluate_result > 0 then
              'FABRIC_EVELUATE_PASS'
             when evaluate_result < -14900 and evaluate_result > -1490000 then
              'FABRIC_EVELUATE_NOT_SEND'
             when evaluate_result < -1490000 then
              'FABRIC_EVELUATE_WAIT'
             else
              'FABRIC_EVELUATE_NO_PASS'
           end evaluate_result,
           case
             when evaluate_result <= -14900 then
              null
             else
              risk_level
           end risk_level,
           /* case
             when evaluate_result < 0 then
              null
             else
              control_measures
           end control_measures,*/
           control_measures,
           num_to_be_audit
      into p_ml_evaluate_result,
           p_risk_level,
           p_CONTROL_MEASURES,
           p_num_to_be_audit
      from (select sum(case
                         when exists
                          (select 1
                                 from scmdata.t_check_request a
                                where a.goo_id = k.goo_id
                                  and a.company_id = k.company_id
                                  and instr(';' || a.color_list || ';',
                                            ';' || k.colorname || ';') > 0
                                  and ((k.evaluate_type = 'ML' and
                                      a.check_link <> 'LINK_05') or
                                      (k.evaluate_type = 'YXH' and
                                      a.check_link = 'LINK_05'))
                                  and a.create_time >
                                      nvl(k.evaluate_time,
                                          to_date('2000-01-01', 'yyyy-mm-dd'))) then
                          -1500000
                         when k.evaluate_result = 'FABRIC_EVELUATE_NOT_SEND' then
                          -15000
                         when k.evaluate_result = 'FABRIC_EVELUATE_NO_PASS' then
                          -100
                         when k.evaluate_result = 'FABRIC_EVELUATE_PASS' then
                          1
                         else
                          0
                       end) evaluate_result,
                   sum(case
                         when exists
                          (select 1
                                 from scmdata.t_check_request a
                                where a.goo_id = k.goo_id
                                  and a.company_id = k.company_id
                                  and instr(';' || a.color_list || ';',
                                            ';' || k.colorname || ';') > 0
                                  and ((k.evaluate_type = 'ML' and
                                      a.check_link <> 'LINK_05') or
                                      (k.evaluate_type = 'YXH' and
                                      a.check_link = 'LINK_05'))
                                  and a.create_time >
                                      nvl(k.evaluate_time,
                                          to_date('2000-01-01', 'yyyy-mm-dd'))) then
                          1
                         else
                          0
                       end) num_to_be_audit,
                   max(k.risk_level) risk_level,
                   listagg(k.control_measures, ';') control_measures
              from scmdata.t_fabric_color_evaluate k
             where k.goo_id = pi_goo_id
               and k.company_id = pi_company_id
               and k.evaluate_result is not null
               and k.evaluate_type = 'ML');
    update scmdata.t_fabric_evaluate a
       set a.evaluate_result  = p_ml_evaluate_result,
           a.risk_level       = p_risk_level,
           a.CONTROL_MEASURES = p_CONTROL_MEASURES,
           a.num_to_be_audit  = p_num_to_be_audit
     where a.goo_id = pi_goo_id
       and a.company_id = pi_company_id;
    update scmdata.t_qc_goo_collect t
       set t.fabric_check = p_ml_evaluate_result
     where t.company_id = pi_company_id
       and t.goo_id = pi_goo_id;
    --订单级结果
    if pi_except_progress = 0 then
    
      update scmdata.t_production_progress t
         set t.fabric_check_extend_01 =
             (select case
                       when evaluate_result = 0 then
                        'FABRIC_EVELUATE_NO_SEND'
                       when evaluate_result > 0 then
                        'FABRIC_EVELUATE_PASS'
                       when evaluate_result < -14900 and
                            evaluate_result > -1490000 then
                        'FABRIC_EVELUATE_NOT_SEND'
                       when evaluate_result < -1490000 then
                        'FABRIC_EVELUATE_WAIT'
                       else
                        'FABRIC_EVELUATE_NO_PASS'
                     end evaluate_result
                from (select sum(case
                                   when exists
                                    (select 1
                                           from scmdata.t_check_request a
                                          where a.goo_id = k.goo_id
                                            and a.company_id = k.company_id
                                            and instr(';' || a.color_list || ';',
                                                      ';' ||
                                                      ltrim(rtrim(k.colorname)) || ';') > 0
                                            and ((k.evaluate_type = 'ML' and
                                                a.check_link <> 'LINK_05') or
                                                (k.evaluate_type = 'YXH' and
                                                a.check_link = 'LINK_05'))
                                            and a.create_time >
                                                nvl(k.evaluate_time,
                                                    to_date('2000-01-01',
                                                            'yyyy-mm-dd'))) then
                                    -1500000
                                   when k.evaluate_result =
                                        'FABRIC_EVELUATE_NOT_SEND' then
                                    -15000
                                   when k.evaluate_result =
                                        'FABRIC_EVELUATE_NO_PASS' then
                                    -100
                                   when k.evaluate_result = 'FABRIC_EVELUATE_PASS' then
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
                       where o.order_id = t.order_id
                         and o.company_id = t.company_id)),
             t.fabric_check          =
             (select case
                       when evaluate_result = 0 then
                        'FABRIC_EVELUATE_NO_SEND'
                       when evaluate_result > 0 then
                        'FABRIC_EVELUATE_PASS'
                       when evaluate_result < -14900 and
                            evaluate_result > -1490000 then
                        'FABRIC_EVELUATE_NOT_SEND'
                       when evaluate_result < -1490000 then
                        'FABRIC_EVELUATE_WAIT'
                       else
                        'FABRIC_EVELUATE_NO_PASS'
                     end evaluate_result
                from (select sum(case
                                   when exists
                                    (select 1
                                           from scmdata.t_check_request a
                                          where a.goo_id = k.goo_id
                                            and a.company_id = k.company_id
                                            and instr(';' || a.color_list || ';',
                                                      ';' ||
                                                      ltrim(rtrim(k.colorname)) || ';') > 0
                                            and ((k.evaluate_type = 'ML' and
                                                a.check_link <> 'LINK_05') or
                                                (k.evaluate_type = 'YXH' and
                                                a.check_link = 'LINK_05'))
                                            and a.create_time >
                                                nvl(k.evaluate_time,
                                                    to_date('2000-01-01',
                                                            'yyyy-mm-dd'))) then
                                    -1500000
                                   when k.evaluate_result =
                                        'FABRIC_EVELUATE_NOT_SEND' then
                                    -15000
                                   when k.evaluate_result =
                                        'FABRIC_EVELUATE_NO_PASS' then
                                    -100
                                   when k.evaluate_result = 'FABRIC_EVELUATE_PASS' then
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
                       where o.order_id = t.order_id
                         and o.company_id = t.company_id))
       where t.company_id = pi_company_id
         and t.goo_id = pi_goo_id;
    end if;
    --修正内容
    scmdata.pkg_fabric_evaluate.p_update_last_check_link(pi_goo_id     => pi_goo_id,
                                                         pi_company_id => pi_company_id);
  end p_update_evaluate_result;

  procedure p_update_last_check_link(pi_goo_id     in varchar2,
                                     pi_company_id in varchar2) is
    p_i          number(1);
    p_check_link varchar2(32);
  begin
    select nvl(max(1), 0),
           max(check_link) KEEP(DENSE_RANK FIRST ORDER BY cd.company_dict_sort desc)
      into p_i, p_check_link
      from scmdata.t_check_request a
     inner join scmdata.sys_company_dict cd
        on cd.company_dict_value = a.check_link
       and cd.company_id = a.company_id
       and cd.company_dict_type = 'FABRIC_LINK_DICT'
     where a.company_id = pi_company_id
       and a.goo_id = pi_goo_id
       and a.evaluate_times = 0;
    if p_i = 0 then
      select max(check_link) KEEP(DENSE_RANK FIRST ORDER BY cd.company_dict_sort desc)
        into p_check_link
        from scmdata.t_check_request a
       inner join scmdata.sys_company_dict cd
          on cd.company_dict_value = a.check_link
         and cd.company_id = a.company_id
         and cd.company_dict_type = 'FABRIC_LINK_DICT'
       where a.company_id = pi_company_id
         and a.goo_id = pi_goo_id;
    end if;
    update scmdata.t_production_progress t
       set t.check_link = p_check_link
     where t.goo_id = pi_goo_id
       and t.company_id = pi_company_id;
    update scmdata.t_fabric_evaluate t
       set t.check_link = p_check_link
     where t.goo_id = pi_goo_id
       and t.company_id = pi_company_id;
  end p_update_last_check_link;

  procedure p_update_last_check_result(pi_goo_id     in varchar2,
                                       pi_company_id in varchar2) is
    p_check_result varchar2(32);
  begin
    select max(check_result)
      into p_check_result
      from (select check_result
              from scmdata.t_check_request a
             where a.company_id = pi_company_id
               and a.goo_id = pi_goo_id
             order by a.check_date desc, a.create_time desc)
     where rownum = 1;
  
    update scmdata.t_fabric_evaluate t
       set t.check_result = p_check_result
     where t.goo_id = pi_goo_id
       and t.company_id = pi_company_id;
  end p_update_last_check_result;

  procedure p_generate_yxh_evaluate_when_insert(pi_goo_id           in varchar2,
                                                pi_company_id       in varchar2,
                                                pi_check_request_id in varchar2) is
    p_flag            number(1);
    p_approve_version varchar2(32);
  begin
    select nvl(max(1), 0)
      into p_flag
      from scmdata.t_check_request a
     where a.check_request_id = pi_check_request_id
       and a.company_id = pi_company_id
       and a.goo_id = pi_goo_id
       and a.check_link = 'LINK_05';
  
    if p_flag = 1 then
      select max(a.approve_version_id)
        into p_approve_version
        from scmdata.t_approve_version av
       inner join scmdata.t_approve_risk_assessment a
          on a.approve_version_id = av.approve_version_id
         and a.assess_type = 'EVAL12'
         and a.assess_result in ('EVRT01', 'EVRT02', 'EVRT03')
       where av.goo_id = pi_goo_id
         and av.company_id = pi_company_id;
    
      if p_approve_version is not null then
        p_sync_yxh_by_approve(pi_approve_version_id => p_approve_version);
      
      end if;
    end if;
  
  end p_generate_yxh_evaluate_when_insert;
end PKG_FABRIC_EVALUATE;
/

