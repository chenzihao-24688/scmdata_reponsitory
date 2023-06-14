create or replace package scmdata.pkg_a_qcqa is

  -- Author  : SANFU
  -- Created : 2021/4/7 14:34:54
  -- Purpose : qcqa应用的管理工具

  function f_validate_qc_report(v_qc_check scmdata.t_qc_check%rowtype)
    return varchar2;

  function f_validate_pre_meeting(v_qc_check scmdata.t_qc_check%rowtype)
    return varchar2;

  procedure p_insert_qc_collect(p_goo_id         in varchar2,
                                p_supplier_code  in varchar2,
                                p_company_id     in varchar2,
                                po_qc_collect_id out varchar2);

  procedure p_qc_collect_recalcu(v_qc_collect_id varchar2,
                                 p_qc_check_node varchar2);

  procedure p_submit_qc(p_qc_check_id varchar2, p_user_id varchar2);

  procedure p_create_goo_collect(p_goo_id        varchar2,
                                 p_supplier_code varchar2,
                                 p_company_id    varchar2,
                                 p_order_code    varchar2 default 'ORDER');

  procedure p_dual_orders(p_dual_time varchar2);

end pkg_a_qcqa;
/
create or replace package body scmdata.pkg_a_qcqa is

  function f_validate_qc_report(v_qc_check scmdata.t_qc_check%rowtype)
    return varchar2 is
    v_qc_check_report    scmdata.t_qc_check_report%rowtype;
    p_null_fields        varchar2(500);
    p_null_fields_result varchar2(500) := '';
  begin
    select *
      into v_qc_check_report
      from scmdata.t_qc_check_report a
     where a.qc_check_id = v_qc_check.qc_check_id;
    --面辅料
    p_null_fields := '';
    if v_qc_check_report.sampler_result is null then
      p_null_fields := p_null_fields || '样衣核对检测结果；';
    elsif v_qc_check_report.sampler_unq is null and
          v_qc_check_report.sampler_result = 'NORMAL_NOT_FIT' then
      p_null_fields := p_null_fields || '样衣核对不合格描述；';
    end if;
  
    if v_qc_check_report.fabrib_result is null then
      p_null_fields := p_null_fields || '面辅料查验检测结果；';
    elsif v_qc_check_report.fabrib_unq is null and
          v_qc_check_report.fabrib_result = 'NORMAL_NOT_QUALIFIED' then
      p_null_fields := p_null_fields || '面辅料查验不合格描述；';
    end if;
  
    if v_qc_check_report.craft_result is null then
      p_null_fields := p_null_fields || '工艺查验检测结果；';
    elsif v_qc_check_report.craft_unq is null and
          v_qc_check_report.craft_result = 'NORMAL_NOT_QUALIFIED' then
      p_null_fields := p_null_fields || '工艺查验不合格描述；';
    end if;
  
    if v_qc_check_report.type_size_result is null then
      p_null_fields := p_null_fields || '版型尺寸检测结果；';
    elsif v_qc_check_report.type_size_unq is null and
          v_qc_check_report.type_size_result = 'NORMAL_NOT_QUALIFIED' then
      p_null_fields := p_null_fields || '版型尺寸不合格描述；';
    end if;
  
    if v_qc_check.qc_result is null then
      p_null_fields := p_null_fields || '查货结果;';
    elsif v_qc_check.qc_result = 'NORMAL_NOT_QUALIFIED' then
      if v_qc_check.qc_unq_say is null then
        p_null_fields := p_null_fields || '查货结果不合格描述；';
      end if;
      if v_qc_check.qc_unq_advice is null then
        p_null_fields := p_null_fields || '查货结果不合格处理意见；';
      end if;
    end if;
  
    if p_null_fields is not null then
      p_null_fields_result := p_null_fields_result || '【QC查货项】' ||
                              p_null_fields || '未填写； ';
    end if;
    p_null_fields := '';
  
    /*    if v_qc_check.ts_check_num  is null then
      p_null_fields := p_null_fields || '抽查件数；';
    end if;*/
    if v_qc_check.ts_product_num is null then
      p_null_fields := p_null_fields || '成品件数；';
    end if;
  
    if v_qc_check.qc_file_id is null then
      p_null_fields := p_null_fields || '附件；';
    end if;
    if v_qc_check.qc_check_node is null then
      p_null_fields := p_null_fields || '查货环节；';
    end if;
    if p_null_fields is not null then
      p_null_fields_result := p_null_fields_result || '【QC查货信息】' ||
                              p_null_fields || '未填写； ';
    end if;
    return p_null_fields_result;
  end f_validate_qc_report;

  function f_validate_pre_meeting(v_qc_check scmdata.t_qc_check%rowtype)
    return varchar2 is
    p_null_fields_result varchar2(500) := '';
  begin
    if v_qc_check.factory_code is null then
      p_null_fields_result := p_null_fields_result || '生产工厂、';
    end if;
    if v_qc_check.pre_meeting_record is null then
      p_null_fields_result := p_null_fields_result || '产前会记录、';
    end if;
    if v_qc_check.pre_meeting_time is null then
      p_null_fields_result := p_null_fields_result || '产前会日期、';
    end if;
    if v_qc_check.is_fabric_back is null then
      p_null_fields_result := p_null_fields_result || '主料是否到厂、';
    elsif v_qc_check.is_fabric_back = 0 and
          v_qc_check.fabric_back_date is null then
      p_null_fields_result := p_null_fields_result || '主料到厂日期、';
    end if;
    if v_qc_check.is_sub_fabric_back is null then
      p_null_fields_result := p_null_fields_result || '辅料是否到厂、';
    end if;
    if v_qc_check.is_capacity_match is null then
      p_null_fields_result := p_null_fields_result || '产能是否匹配、';
    elsif v_qc_check.is_capacity_match = 0 and
          v_qc_check.capacity_unq_say is null then
      p_null_fields_result := p_null_fields_result || '产能问题说明、';
    end if; --HIGN_RISK_LEVEL
    if v_qc_check.delay_risk_level is null then
      p_null_fields_result := p_null_fields_result || '延期风险、';
    elsif v_qc_check.delay_risk_level = 'HIGN_RISK_LEVEL' and
          v_qc_check.delay_risk_say is null then
      p_null_fields_result := p_null_fields_result || '延期风险说明、';
    end if;
    if p_null_fields_result is not null then
      p_null_fields_result := p_null_fields_result || '为必填,';
    end if;
    return p_null_fields_result;
  end f_validate_pre_meeting;

  function f_validate_wash_test(v_qc_check scmdata.t_qc_check%rowtype)
    return varchar2 is
    p_qc_check_wash      scmdata.t_qc_check_wash%rowtype;
    p_null_fields_result varchar2(500) := '';
  begin
    select *
      into p_qc_check_wash
      from scmdata.t_qc_check_wash a
     where a.qc_check_id = v_qc_check.qc_check_id;
    if v_qc_check.factory_code is null then
      p_null_fields_result := p_null_fields_result || '生产工厂、';
    end if;
  
    if p_qc_check_wash.wash_test_log is null then
      p_null_fields_result := p_null_fields_result || '洗水测试记录、';
    end if;
    if v_qc_check.qc_result is null then
      p_null_fields_result := p_null_fields_result || '洗水测试结果、';
    elsif v_qc_check.qc_result = 'NORMAL_NOT_QUALIFIED' then
    
      if v_qc_check.qc_unq_say is null then
        p_null_fields_result := p_null_fields_result || '洗水测试结果不合格描述、';
      end if;
      if v_qc_check.qc_unq_advice is null then
        p_null_fields_result := p_null_fields_result || '查货结果不合格处理意见、';
      end if;
    end if;
    if p_qc_check_wash.wash_test_date is null then
      p_null_fields_result := p_null_fields_result || '洗水测试日期、';
    end if;
    if p_qc_check_wash.wash_float is null then
      p_null_fields_result := p_null_fields_result || '水洗浮色、';
    elsif p_qc_check_wash.wash_float = 'NORMAL_NOT_QUALIFIED' and
          p_qc_check_wash.wash_float_unq is null then
      p_null_fields_result := p_null_fields_result || '水洗浮色不合格描述、';
    end if;
    if p_qc_check_wash.dyed_stain is null then
      p_null_fields_result := p_null_fields_result || '布染沾色、';
    elsif p_qc_check_wash.dyed_stain = 'NORMAL_NOT_QUALIFIED' and
          p_qc_check_wash.dyed_stain_unq is null then
      p_null_fields_result := p_null_fields_result || '布染沾色不合格描述、';
    end if;
    if p_qc_check_wash.cloth_shrinkage is null then
      p_null_fields_result := p_null_fields_result || '成衣缩率、';
    elsif p_qc_check_wash.cloth_shrinkage = 'NORMAL_NOT_QUALIFIED' and
          p_qc_check_wash.cloth_shrinkage_unq is null then
      p_null_fields_result := p_null_fields_result || '成衣缩率不合格描述、';
    end if;
    if p_qc_check_wash.appearance_af is null then
      p_null_fields_result := p_null_fields_result || '洗后外观、';
    elsif p_qc_check_wash.appearance_af = 'NORMAL_NOT_QUALIFIED' and
          p_qc_check_wash.appearance_af_unq is null then
      p_null_fields_result := p_null_fields_result || '洗后外观不合格描述、';
    end if;
  
    if p_null_fields_result is not null then
      p_null_fields_result := p_null_fields_result || '为必填,';
    end if;
    return p_null_fields_result;
  end f_validate_wash_test;

  procedure p_insert_qc_collect(p_goo_id         in varchar2,
                                p_supplier_code  in varchar2,
                                p_company_id     in varchar2,
                                po_qc_collect_id out varchar2) is
    p_goo_collect_id varchar2(32);
  begin
    p_goo_collect_id := f_get_uuid();
    insert into scmdata.t_qc_goo_collect
      (qc_goo_collect_id,
       goo_id,
       company_id,
       update_id,
       update_time,
       pre_meeting_record,
       supplier_code,
       memo,
       create_time)
    values
      (p_goo_collect_id,
       p_goo_id,
       p_company_id,
       null,
       null,
       null,
       p_supplier_code,
       null,
       sysdate);
    update scmdata.t_qc_goo_collect a
       set a.approve_result =
           (select v.approve_result
              from scmdata.t_approve_version v
             where v.goo_id = p_goo_id
               and v.company_id = p_company_id
               and v.approve_result <> 'AS00'
               and v.approve_number =
                   (select max(approve_number)
                      from scmdata.t_approve_version
                     where goo_id = p_goo_id
                       and company_id = p_company_id
                       and approve_result <> 'AS00'))
     where a.qc_goo_collect_id = p_goo_collect_id;
    update scmdata.t_qc_goo_collect a
       set a.fabric_check =
           (select e.evaluate_result
              from scmdata.t_fabric_evaluate e
             where e.goo_id = p_goo_id
               and e.company_id = p_company_id)
     where a.qc_goo_collect_id = p_goo_collect_id;
  
    update scmdata.t_qc_goo_collect a
       set a.order_count =
           (select count(*)
              from scmdata.t_orders o
             inner join scmdata.t_ordered od
                on od.order_code = o.order_id
               and o.company_id = od.company_id
             where o.goo_id = a.goo_id
               and od.supplier_code = a.supplier_code
               and o.company_id = a.company_id)
     where a.qc_goo_collect_id = p_goo_collect_id;
    po_qc_collect_id := p_goo_collect_id;
  end p_insert_qc_collect;

  procedure p_qc_collect_recalcu(v_qc_collect_id varchar2,
                                 p_qc_check_node varchar2) as
    v_qc_collect scmdata.t_qc_goo_collect%rowtype;
  begin
    select *
      into v_qc_collect
      from scmdata.t_qc_goo_collect a
     where a.qc_goo_collect_id = v_qc_collect_id;
  
    if p_qc_check_node = 'QC_PRE_MEETING' then
      update scmdata.t_qc_goo_collect a
         set a.pre_meeting_time =
             (select max(qc.pre_meeting_time)
                from scmdata.t_qc_check qc
               where qc.qc_check_node = 'QC_PRE_MEETING'
                 and qc.goo_id = v_qc_collect.goo_id
                 and qc.pause = 0
                 and qc.company_id = v_qc_collect.company_id
                 and qc.finish_time is not null
                 and qc.supplier_code = v_qc_collect.supplier_code)
       where a.qc_goo_collect_id = v_qc_collect.qc_goo_collect_id;
    elsif p_qc_check_node = 'QC_WASH_TESTING' then
      update scmdata.t_qc_goo_collect a
         set a.wash_test_result =
             (select max(w.qc_result)
                from (select qc.*
                        from scmdata.t_qc_check qc
                       where qc.qc_check_node = 'QC_WASH_TESTING'
                         and qc.goo_id = v_qc_collect.goo_id
                         and qc.pause = 0
                         and qc.company_id = v_qc_collect.company_id
                         and qc.supplier_code = v_qc_collect.supplier_code
                         and qc.finish_time is not null
                       order by qc.finish_time desc) w
               where rownum = 1)
       where a.qc_goo_collect_id = v_qc_collect.qc_goo_collect_id;
    elsif p_qc_check_node = 'QC_FIRST_CHECK' then
      update scmdata.t_qc_goo_collect a
         set a.first_check_result =
             (select max(a.qc_result)
                from scmdata.t_qc_check a
               where a.qc_check_node = p_qc_check_node
                 and a.supplier_code = v_qc_collect.supplier_code
                 and a.goo_id = v_qc_collect.goo_id
                 and a.pause = 0
                 and a.company_id = v_qc_collect.company_id
                 and a.finish_time is not null
                 and a.qc_check_num =
                     (select max(qc.qc_check_num)
                        from scmdata.t_qc_check qc
                       where qc.qc_check_node = p_qc_check_node
                         and qc.supplier_code = v_qc_collect.supplier_code
                         and qc.pause = 0
                         and qc.goo_id = v_qc_collect.goo_id
                         and qc.company_id = v_qc_collect.company_id
                         and a.finish_time is not null)),
             a.first_check_sum   =
             (select count(distinct qo.orders_id)
                from scmdata.t_qc_check_rela_order qo
               inner join scmdata.t_qc_check qc
                  on qc.qc_check_id = qo.qc_check_id
               where qc.goo_id = v_qc_collect.goo_id
                 and qc.company_id = v_qc_collect.company_id
                 and qc.pause = 0
                 and qc.supplier_code = v_qc_collect.supplier_code
                 and qc.qc_check_node = 'QC_FIRST_CHECK'
                 and qc.finish_time is not null)
       where a.qc_goo_collect_id = v_qc_collect.qc_goo_collect_id;
    
    elsif p_qc_check_node = 'QC_MIDDLE_CHECK' then
      update scmdata.t_qc_goo_collect a
         set a.middle_check_result =
             (select max(a.qc_result)
                from scmdata.t_qc_check a
               where a.qc_check_node = p_qc_check_node
                 and a.supplier_code = v_qc_collect.supplier_code
                 and a.goo_id = v_qc_collect.goo_id
                 and a.company_id = v_qc_collect.company_id
                 and a.pause = 0
                 and a.finish_time is not null
                 and a.qc_check_num =
                     (select max(qc.qc_check_num)
                        from scmdata.t_qc_check qc
                       where qc.qc_check_node = p_qc_check_node
                         and qc.supplier_code = v_qc_collect.supplier_code
                         and qc.pause = 0
                         and qc.goo_id = v_qc_collect.goo_id
                         and qc.company_id = v_qc_collect.company_id
                         and a.finish_time is not null)),
             a.middle_check_sum   =
             (select count(distinct qo.orders_id)
                from scmdata.t_qc_check_rela_order qo
               inner join scmdata.t_qc_check qc
                  on qc.qc_check_id = qo.qc_check_id
               where qc.goo_id = v_qc_collect.goo_id
                 and qc.company_id = v_qc_collect.company_id
                 and qc.pause = 0
                 and qc.supplier_code = v_qc_collect.supplier_code
                 and qc.qc_check_node = 'QC_MIDDLE_CHECK'
                 and qc.finish_time is not null)
       where a.qc_goo_collect_id = v_qc_collect.qc_goo_collect_id;
    elsif p_qc_check_node = 'QC_FINAL_CHECK' then
      update scmdata.t_qc_goo_collect a
         set a.final_check_result =
             (select max(a.qc_result)
                from scmdata.t_qc_check a
               where a.qc_check_node = p_qc_check_node
                 and a.supplier_code = v_qc_collect.supplier_code
                 and a.goo_id = v_qc_collect.goo_id
                 and a.pause = 0
                 and a.company_id = v_qc_collect.company_id
                 and a.finish_time is not null
                 and a.qc_check_num =
                     (select max(qc.qc_check_num)
                        from scmdata.t_qc_check qc
                       where qc.qc_check_node = p_qc_check_node
                         and qc.supplier_code = v_qc_collect.supplier_code
                         and qc.goo_id = v_qc_collect.goo_id
                         and qc.pause = 0
                         and qc.company_id = v_qc_collect.company_id
                         and a.finish_time is not null)),
             a.final_check_sum   =
             (select count(distinct qo.orders_id)
                from scmdata.t_qc_check_rela_order qo
               inner join scmdata.t_qc_check qc
                  on qc.qc_check_id = qo.qc_check_id
               where qc.goo_id = v_qc_collect.goo_id
                 and qc.company_id = v_qc_collect.company_id
                 and qc.pause = 0
                 and qc.supplier_code = v_qc_collect.supplier_code
                 and qc.qc_check_node = 'QC_FINAL_CHECK'
                 and qc.finish_time is not null)
       where a.qc_goo_collect_id = v_qc_collect.qc_goo_collect_id;
    end if;
  end p_qc_collect_recalcu;

  procedure p_submit_qc(p_qc_check_id varchar2, p_user_id varchar2) as
    v_qc_check scmdata.t_qc_check%rowtype;
    --p_wash_detail        scmdata.t_qc_check_wash%rowtype;
    p_null_fields_result varchar2(500) := '';
    p_flag               number(1);
    p_max_sup            varchar2(32);
    p_mim_sup            varchar2(32);
    p_goo_collect_id     varchar2(32);
    p_abn_rec            scmdata.t_abnormal%ROWTYPE;
    v_order_amount       number;
    v_abnormal_config_id varchar2(32);
  begin
    select nvl(max(1), 0), max(oe.supplier_code), min(oe.supplier_code)
      into p_flag, p_max_sup, p_mim_sup
      from scmdata.t_qc_check_rela_order a
     inner join scmdata.t_orders o
        on a.orders_id = o.orders_id
     inner join scmdata.t_ordered oe
        on oe.order_code = o.order_id
       and o.company_id = a.company_id
     where a.qc_check_id = p_qc_check_id;
  
    if p_flag = 0 then
      raise_application_error(-20002,
                              '提交失败！该查货报告应至少添加1条查货订单，请使用【修改查货订单】添加查货订单');
    end if;
    if p_max_sup <> p_mim_sup then
      raise_application_error(-20002,
                              '提交失败！查货订单需为同一供应商，请先修改查货订单。');
    end if;
    select *
      into v_qc_check
      from scmdata.t_qc_check a
     where a.qc_check_id = p_qc_check_id;
    if v_qc_check.qc_check_node = 'QC_PRE_MEETING' then
      p_null_fields_result := f_validate_pre_meeting(v_qc_check);
    elsif v_qc_check.qc_check_node = 'QC_WASH_TESTING' then
      p_null_fields_result := f_validate_wash_test(v_qc_check);
    else
      p_null_fields_result := f_validate_qc_report(v_qc_check);
    end if;
    if p_null_fields_result is not null then
      raise_application_error(-20002, p_null_fields_result || '请检查');
    end if;
    update scmdata.t_qc_check a
       set a.finish_time  = sysdate,
           a.finish_qc_id = p_user_id,
           a.update_id    = p_user_id,
           a.update_time  = sysdate,
           a.qc_check_num =
           (select to_char(count(*) + 1)
              from t_qc_check
             where goo_id = a.goo_id
               and supplier_code = a.supplier_code
               and qc_check_node = a.qc_check_node
               and finish_time is not null)
     where a.qc_check_id = p_qc_check_id;
  
    select max(a.qc_goo_collect_id)
      into p_goo_collect_id
      from scmdata.t_qc_goo_collect a
     where a.supplier_code = v_qc_check.supplier_code
       and a.company_id = v_qc_check.company_id
       and a.goo_id = v_qc_check.goo_id;
    if p_goo_collect_id is null then
      scmdata.pkg_a_qcqa.p_insert_qc_collect(p_goo_id         => v_qc_check.goo_id,
                                             p_supplier_code  => v_qc_check.supplier_code,
                                             p_company_id     => v_qc_check.company_id,
                                             po_qc_collect_id => p_goo_collect_id);
      /* scmdata.pkg_a_qcqa.p_qc_collect_recalcu(v_qc_collect_id => p_goo_collect_id,
                                              p_qc_check_node => 'QC_PRE_MEETING');
      scmdata.pkg_a_qcqa.p_qc_collect_recalcu(v_qc_collect_id => p_goo_collect_id,
                                              p_qc_check_node => 'QC_FIRST_CHECK');
      scmdata.pkg_a_qcqa.p_qc_collect_recalcu(v_qc_collect_id => p_goo_collect_id,
                                              p_qc_check_node => 'QC_MIDDLE_CHECK');
      scmdata.pkg_a_qcqa.p_qc_collect_recalcu(v_qc_collect_id => p_goo_collect_id,
                                              p_qc_check_node => 'QC_WASH_TESTING');
      scmdata.pkg_a_qcqa.p_qc_collect_recalcu(v_qc_collect_id => p_goo_collect_id,
                                              p_qc_check_node => 'QC_FINAL_CHECK');*/
      scmdata.pkg_a_qcqa.p_qc_collect_recalcu(v_qc_collect_id => p_goo_collect_id,
                                              p_qc_check_node => v_qc_check.qc_check_node);
    else
    
      --集合修正
      if v_qc_check.qc_check_node = 'QC_PRE_MEETING' then
        update scmdata.t_qc_goo_collect a
           set a.pre_meeting_time = v_qc_check.pre_meeting_time
         where a.qc_goo_collect_id = p_goo_collect_id;
      elsif v_qc_check.qc_check_node = 'QC_WASH_TESTING' then
        update scmdata.t_qc_goo_collect a
           set a.wash_test_result = v_qc_check.qc_result
         where a.qc_goo_collect_id = p_goo_collect_id;
      elsif v_qc_check.qc_check_node = 'QC_FIRST_CHECK' then
        update scmdata.t_qc_goo_collect a
           set a.first_check_result = v_qc_check.qc_result,
               a.first_check_sum   =
               (select count(distinct qo.orders_id)
                  from scmdata.t_qc_check_rela_order qo
                 inner join scmdata.t_qc_check qc
                    on qc.qc_check_id = qo.qc_check_id
                 where qc.goo_id = v_qc_check.goo_id
                   and qc.company_id = v_qc_check.company_id
                   and qc.pause = 0
                   and qc.supplier_code = v_qc_check.supplier_code
                   and qc.qc_check_node = 'QC_FIRST_CHECK'
                   and qc.finish_time is not null)
         where a.qc_goo_collect_id = p_goo_collect_id;
      
      elsif v_qc_check.qc_check_node = 'QC_MIDDLE_CHECK' then
        update scmdata.t_qc_goo_collect a
           set a.middle_check_result = v_qc_check.qc_result,
               a.middle_check_sum   =
               (select count(distinct qo.orders_id)
                  from scmdata.t_qc_check_rela_order qo
                 inner join scmdata.t_qc_check qc
                    on qc.qc_check_id = qo.qc_check_id
                 where qc.goo_id = v_qc_check.goo_id
                   and qc.company_id = v_qc_check.company_id
                   and qc.pause = 0
                   and qc.supplier_code = v_qc_check.supplier_code
                   and qc.qc_check_node = 'QC_MIDDLE_CHECK'
                   and qc.finish_time is not null)
         where a.qc_goo_collect_id = p_goo_collect_id;
      
      elsif v_qc_check.qc_check_node = 'QC_FINAL_CHECK' then
        update scmdata.t_qc_goo_collect a
           set a.final_check_result = v_qc_check.qc_result,
               a.final_check_sum   =
               (select count(distinct qo.orders_id)
                  from scmdata.t_qc_check_rela_order qo
                 inner join scmdata.t_qc_check qc
                    on qc.qc_check_id = qo.qc_check_id
                 where qc.goo_id = v_qc_check.goo_id
                   and qc.company_id = v_qc_check.company_id
                   and qc.pause = 0
                   and qc.supplier_code = v_qc_check.supplier_code
                   and qc.qc_check_node = 'QC_FINAL_CHECK'
                   and qc.finish_time is not null)
         where a.qc_goo_collect_id = p_goo_collect_id;
      end if;
    end if;
  
    --qc关联订单数据表
    for x in (select os.order_id, os.company_id
                from scmdata.t_qc_check_rela_order qo
               inner join scmdata.t_orders os
                  on os.orders_id = qo.orders_id
               where qo.qc_check_id = v_qc_check.qc_check_id) loop
      scmdata.pkg_order_management.P_ORDQCRELA_IU_DATA(V_ORDID  => x.order_id,
                                                       V_COMPID => x.company_id);
    end loop;
  
    --生成异常单
    if v_qc_check.qc_check_node in
       ('QC_FIRST_CHECK',
        'QC_MIDDLE_CHECK',
        'QC_FINAL_CHECK',
        'QC_WASH_TESTING') and
       v_qc_check.qc_result = 'NORMAL_NOT_QUALIFIED' and
       v_qc_check.qc_unq_advice = 'UNAD_02' then
    
      p_abn_rec.company_id           := v_qc_check.company_id;
      p_abn_rec.progress_status      := '01';
      p_abn_rec.goo_id               := v_qc_check.goo_id;
      p_abn_rec.anomaly_class        := 'AC_QUALITY';
      p_abn_rec.problem_class        := ' ';
      p_abn_rec.cause_class          := ' ';
      p_abn_rec.cause_detailed       := ' ';
      p_abn_rec.detailed_reasons     := v_qc_check.qc_unq_say;
      p_abn_rec.is_sup_responsible   := null;
      p_abn_rec.responsible_dept_sec := null;
      p_abn_rec.delay_date           := null;
      p_abn_rec.delay_amount         := null;
      p_abn_rec.responsible_party    := null;
      p_abn_rec.responsible_dept     := ' ';
      p_abn_rec.handle_opinions      := null;
      p_abn_rec.quality_deduction    := 0;
      p_abn_rec.is_deduction         := 0;
      p_abn_rec.deduction_method     := null;
      p_abn_rec.deduction_unit_price := null;
      p_abn_rec.applicant_id         := p_user_id;
      p_abn_rec.applicant_date       := SYSDATE;
      p_abn_rec.create_id            := p_user_id;
      p_abn_rec.create_time          := SYSDATE;
      p_abn_rec.update_id            := p_user_id;
      p_abn_rec.update_time          := SYSDATE;
      p_abn_rec.origin_id             :=p_qc_check_id;
      p_abn_rec.origin               := 'MA';
      p_abn_rec.memo                 := null;
      for x in (select os.order_id
                  from scmdata.t_qc_check_rela_order qo
                 inner join scmdata.t_orders os
                    on os.orders_id = qo.orders_id
                 where qo.qc_check_id = v_qc_check.qc_check_id) loop
        p_abn_rec.abnormal_id   := scmdata.f_get_uuid();
        p_abn_rec.abnormal_code := scmdata.pkg_plat_comm.f_getkeycode(pi_table_name  => 't_abnormal',
                                                                      pi_column_name => 'abnormal_code',
                                                                      pi_company_id  => v_qc_check.company_id,
                                                                      pi_pre         => 'ABN',
                                                                      pi_serail_num  => '6');
        p_abn_rec.order_id      := x.order_id;
        /* p_abn_rec.abnormal_range := '00';
        SELECT nvl(MAX(t.order_amount), 0)
          INTO v_order_amount
          FROM scmdata.t_production_progress t
         WHERE t.goo_id = p_abn_rec.goo_id
           AND t.order_id = x.order_id
           AND t.company_id = p_abn_rec.company_id;
        p_abn_rec.delay_amount := v_order_amount;*/
        scmdata.pkg_production_progress.handle_abnormal(p_abn_rec => p_abn_rec);
        scmdata.pkg_production_progress.sync_abnormal(p_abn_rec => p_abn_rec,
                                                      p_status  => '01');
      end loop;
    end if;
    --二次尾查 生成扣款单
    if v_qc_check.qc_check_node = 'QC_FINAL_CHECK' and
       v_qc_check.second_final_check = 1 then
    
      p_abn_rec.company_id       := v_qc_check.company_id;
      p_abn_rec.progress_status  := '01';
      p_abn_rec.goo_id           := v_qc_check.goo_id;
      p_abn_rec.anomaly_class    := 'AC_OTHERS';
      p_abn_rec.problem_class    := '其他问题';
      p_abn_rec.cause_class      := '违反合作协议';
      p_abn_rec.cause_detailed   := '二次尾查';
      p_abn_rec.detailed_reasons := '多次尾查';
    
      --duiying
      v_abnormal_config_id := scmdata.pkg_production_progress.check_abnormal_config(p_company_id => v_qc_check.company_id,
                                                                                    p_goo_id     => v_qc_check.goo_id);
      --根据v_abnormal_config_id获取
      select max(a.is_sup_exemption),
             nvl(max(a.first_dept_id), ' '),
             max(a.second_dept_id)
        into p_abn_rec.is_sup_responsible,
             p_abn_rec.responsible_dept,
             p_abn_rec.responsible_dept_sec
        from scmdata.t_abnormal_dtl_config a
       where a.abnormal_config_id = v_abnormal_config_id
         and a.anomaly_classification = 'AC_OTHERS'
         and a.problem_classification = '其他问题'
         and a.cause_classification = '违反合作协议'
         and a.cause_detail = '二次尾查';
      p_abn_rec.delay_date   := null;
      p_abn_rec.delay_amount := null;
    
      p_abn_rec.responsible_party    := null;
      p_abn_rec.handle_opinions      := '01';
      p_abn_rec.quality_deduction    := 0;
      p_abn_rec.is_deduction         := 1;
      p_abn_rec.deduction_method     := 'METHOD_01';
      p_abn_rec.deduction_unit_price := 500;
      p_abn_rec.applicant_id         := p_user_id;
      p_abn_rec.applicant_date       := SYSDATE;
      p_abn_rec.create_id            := p_user_id;
      p_abn_rec.create_time          := SYSDATE;
      p_abn_rec.update_id            := p_user_id;
      p_abn_rec.update_time          := SYSDATE;
      p_abn_rec.origin_id             :=p_qc_check_id;
      p_abn_rec.origin               := 'MA';
      p_abn_rec.memo                 := null;
      for x in (select order_id
                  from (select os.order_id,
                               rank() over(order by nvl(os.order_amount, 0) desc) rank_temp
                          from scmdata.t_qc_check_rela_order qo
                         inner join scmdata.t_orders os
                            on os.orders_id = qo.orders_id
                         where qo.qc_check_id = v_qc_check.qc_check_id)
                 where rank_temp = 1
                   and rownum = 1) loop
        p_abn_rec.abnormal_id    := scmdata.f_get_uuid();
        p_abn_rec.abnormal_code  := scmdata.pkg_plat_comm.f_getkeycode(pi_table_name  => 't_abnormal',
                                                                       pi_column_name => 'abnormal_code',
                                                                       pi_company_id  => v_qc_check.company_id,
                                                                       pi_pre         => 'ABN',
                                                                       pi_serail_num  => '6');
        p_abn_rec.order_id       := x.order_id;
        p_abn_rec.abnormal_range := '00';
        SELECT nvl(MAX(t.order_amount), 0)
          INTO v_order_amount
          FROM scmdata.t_production_progress t
         WHERE t.goo_id = p_abn_rec.goo_id
           AND t.order_id = x.order_id
           AND t.company_id = p_abn_rec.company_id;
        p_abn_rec.delay_amount := v_order_amount;
        scmdata.pkg_production_progress.handle_abnormal(p_abn_rec => p_abn_rec);
        scmdata.pkg_production_progress.sync_abnormal(p_abn_rec => p_abn_rec,
                                                      p_status  => '01');
      end loop;
    
    end if;
  end p_submit_qc;

  procedure p_create_goo_collect(p_goo_id        varchar2,
                                 p_supplier_code varchar2,
                                 p_company_id    varchar2,
                                 p_order_code    varchar2 default 'ORDER') is
    p_flag   number(1);
    p_id     varchar2(32);
    judge    number(1);
    p_is_pro number(1);
    -- SUBCATE_STR varchar2(2000);
  begin
    if p_order_code <> 'ORDER' then
      select max(oe.is_product_order)
        into p_is_pro
        from scmdata.t_ordered oe
       where oe.order_code = p_order_code
         and oe.company_id = p_company_id;
    
      if p_is_pro = 0 then
        return;
      end if;
    end if;
  
    select nvl(max(1), 0), max(a.qc_goo_collect_id)
      into p_flag, p_id
      from scmdata.t_qc_goo_collect a
     where a.goo_id = p_goo_id
       and a.supplier_code = p_supplier_code
       and a.company_id = p_company_id;
    if p_flag = 0 then
      p_id := f_get_uuid();
      SELECT COUNT(1)
        INTO JUDGE
        FROM (SELECT COMPANY_ID, CATEGORY, PRODUCT_CATE, SAMLL_CATEGORY
                FROM SCMDATA.T_COMMODITY_INFO
               WHERE COMPANY_ID = p_company_id
                 AND GOO_ID = p_goo_id) A
       INNER JOIN SCMDATA.t_Qc_Config B
          ON A.COMPANY_ID = B.COMPANY_ID
         AND A.CATEGORY = B.INDUSTRY_CLASSIFICATION
         AND A.PRODUCT_CATE = B.PRODUCTION_CATEGORY
         AND INSTR(B.PRODUCT_SUBCLASS || ';', A.SAMLL_CATEGORY) > 0
         AND B.PAUSE = 0;
      if judge = 0 then
        return;
      end if;
      insert into scmdata.t_qc_goo_collect
        (qc_goo_collect_id,
         goo_id,
         company_id,
         update_id,
         update_time,
         pre_meeting_record,
         supplier_code,
         memo,
         create_time)
      values
        (p_id,
         p_goo_id,
         p_company_id,
         null,
         null,
         null,
         p_supplier_code,
         null,
         sysdate);
    
      update scmdata.t_qc_goo_collect a
         set a.approve_result =
             (select v.approve_result
                from scmdata.t_approve_version v
               where v.goo_id = p_goo_id
                 and v.company_id = p_company_id
                 and v.approve_result <> 'AS00'
                 and v.approve_number =
                     (select max(approve_number)
                        from scmdata.t_approve_version
                       where goo_id = p_goo_id
                         and company_id = p_company_id
                         and approve_result <> 'AS00'))
       where a.qc_goo_collect_id = p_id;
      update scmdata.t_qc_goo_collect a
         set a.fabric_check =
             (select e.evaluate_result
                from scmdata.t_fabric_evaluate e
               where e.goo_id = p_goo_id
                 and e.company_id = p_company_id)
       where a.qc_goo_collect_id = p_id;
    end if;
    update scmdata.t_qc_goo_collect a
       set a.order_count =
           (select count(*)
              from scmdata.t_orders o
             inner join scmdata.t_ordered od
                on od.order_code = o.order_id
               and o.company_id = od.company_id
             where o.goo_id = a.goo_id
               and od.supplier_code = a.supplier_code
               and o.company_id = a.company_id),
           a.is_hide    =
           (select nvl(max(0), 1)
              from scmdata.t_orders o
             inner join scmdata.t_ordered od
                on od.order_code = o.order_id
               and o.company_id = od.company_id
             where o.goo_id = a.goo_id
               and od.supplier_code = a.supplier_code
               and o.company_id = a.company_id
               and od.finish_time_scm is null)
     where a.qc_goo_collect_id = p_id;
  
    for v_qc_check in (select qc.goo_id,
                              qc.supplier_code,
                              qc.qc_check_node,
                              qc.company_id,
                              qc.qc_check_id
                         from scmdata.t_qc_check_rela_order qo
                        inner join scmdata.t_orders a
                           on qo.orders_id = a.orders_id
                        inner join scmdata.t_qc_check qc
                           on qo.qc_check_id = qc.qc_check_id
                        where a.order_id = p_order_code
                          and a.company_id = p_company_id
                          and qc.pause = 0
                          and finish_time is not null) loop
      if v_qc_check.supplier_code <> p_supplier_code then
        update scmdata.t_qc_check a
           set a.pause = 1
         where a.qc_check_id = v_qc_check.qc_check_id;
      
      end if;
      --集合修正
      scmdata.pkg_a_qcqa.p_qc_collect_recalcu(v_qc_collect_id => p_id,
                                              p_qc_check_node => v_qc_check.qc_check_node);
    end loop;
  end p_create_goo_collect;
  procedure p_dual_orders(p_dual_time varchar2) is
  begin
    update scmdata.t_qc_goo_collect a
       set a.is_hide =
           (select nvl(max(0), 1)
              from scmdata.t_orders o
             inner join scmdata.t_ordered od
                on od.order_code = o.order_id
               and o.company_id = od.company_id
             where o.goo_id = a.goo_id
               and od.supplier_code = a.supplier_code
               and o.company_id = a.company_id
               and od.finish_time_scm is null)
     where a.is_hide = 0;
  end p_dual_orders;

end pkg_a_qcqa;
/
