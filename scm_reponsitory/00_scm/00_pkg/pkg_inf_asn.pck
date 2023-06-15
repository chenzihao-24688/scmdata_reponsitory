create or replace package scmdata.pkg_inf_asn is

  -- Author  : zwh73
  -- Created : 2021/7/8 17:34:20
  -- Purpose : asn接口管控

  procedure p_delete_by_asn(p_asn_id varchar2, p_company_id varchar2);

  procedure p_dual_asnordered_if(p_asnordered scmdata.t_asnordered%rowtype);

  procedure p_dual_asnorders_if(p_asnorders scmdata.t_asnorders%rowtype);

  procedure p_dual_asnordersitem_if(p_asnordersitem scmdata.t_asnordersitem%rowtype);

  procedure p_dual_asnorderpacks_if(p_asnorderpacks scmdata.t_asnorderpacks%rowtype);

  procedure p_dual_delivery_record_if(p_delivery_record scmdata.t_delivery_record%rowtype);

  procedure p_dual_delivery_record_item_if(p_delivery_record_item scmdata.t_delivery_record_item%rowtype);

  procedure p_sync_asn_by_delivery_record(p_delivery_record scmdata.t_delivery_record%rowtype);

  procedure p_sync_asn_by_delivery_record_item(p_delivery_record_item scmdata.t_delivery_record_item%rowtype,
                                               p_asn_id               varchar2);

  procedure p_sync_delivery_record_by_asnorder(p_asn_id     varchar2,
                                               p_company_id varchar2);

  procedure p_sync_delivery_record_by_asnorder_inf(p_asn_id     varchar2,
                                                   p_company_id varchar2);

  procedure p_sync_delivery_record_item_by_asnordersitem(p_asn_id     varchar2,
                                                         p_goo_id     varchar2,
                                                         p_company_id varchar2,
                                                         p_barcode    varchar2,
                                                         po_error_flg out number);
  procedure p_asn_inf_history_dual(p_dual_time date default sysdate);

  procedure p_create_asn_by_delivery(p_dual_time date default sysdate);

  procedure p_exclude_useless_asn(p_asn_list varchar2, p_ord_id varchar2);
  --2023-6-2 by hx 需要删除的asn数据处理，走定时调度，每3分钟执行一次
  procedure p_cmx_asnordered_delet(pi_company_id varchar2);

end pkg_inf_asn;
/

create or replace package body scmdata.pkg_inf_asn is

  procedure p_delete_by_asn(p_asn_id varchar2, p_company_id varchar2) is
  begin
    delete from scmdata.t_asnordered a
     where a.company_id = p_company_id
       and a.asn_id = p_asn_id;
    delete from scmdata.t_asnorders a
     where a.company_id = p_company_id
       and a.asn_id = p_asn_id;
    delete from scmdata.t_asnordersitem a
     where a.company_id = p_company_id
       and a.asn_id = p_asn_id;

    delete from scmdata.t_asnordered_inf a
     where a.company_id = p_company_id
       and a.asn_id = p_asn_id;
    delete from scmdata.t_asnorders_inf a
     where a.company_id = p_company_id
       and a.asn_id = p_asn_id;
    delete from scmdata.t_asnordersitem_inf a
     where a.company_id = p_company_id
       and a.asn_id = p_asn_id;

    delete from scmdata.t_delivery_record_item a
     where a.delivery_record_id in
           (select delivery_record_id
              from scmdata.t_delivery_record b
             where b.asn_id = p_asn_id
               and b.company_id = p_company_id);
    delete from scmdata.t_delivery_record a
     where a.asn_id = p_asn_id
       and a.company_id = p_company_id;
  end p_delete_by_asn;

  procedure p_dual_asnordered_if(p_asnordered scmdata.t_asnordered%rowtype) is
    p_flag       number(1);
    p_company_id varchar2(32);
    p_i          number(1);
    --p_order_flag number(1);
    p_asn_state varchar2(32);
    p_has_itf   number(1);
    p_old_order varchar2(32);
  begin
    --ASN_MAIN
    --基本判断
    select max(company_id)
      into p_company_id
      from scmdata.t_interface a
     where a.interface_id = 'ASN_MAIN';
    --如果有接口表不更新
    select nvl(max(1), 0)
      into p_has_itf
      from scmdata.t_asnordered_itf a
     where a.asn_id = p_asnordered.asn_id
       and a.company_id = p_company_id;
    /*if p_has_itf = 1 and p_asnordered.end_acc_time is null then
      return;
    elsif p_has_itf = 1 and p_asnordered.end_acc_time is not null then
      update scmdata.t_asnordered a
         set a.end_acc_time = p_asnordered.end_acc_time
       where a.asn_id = p_asnordered.asn_id
         and a.company_id = p_company_id;
      scmdata.pkg_inf_asn.p_sync_delivery_record_by_asnorder(p_asn_id     => p_asnordered.asn_id,
                                                             p_company_id => p_company_id);
      return;
    end if;*/
    --订单有无
    select nvl(max(1), 0)
      into p_i
      from scmdata.t_ordered a
     where a.order_code = p_asnordered.order_id
       and a.company_id = p_company_id;

    --排除finishtime为空且不和要求
    if p_asnordered.create_time is null and p_asnordered.scan_time is null and
       p_asnordered.end_acc_time is null then
      p_i := 2;
    end if;
    if p_i = 1 then
      select nvl(max(1), 0), max(a.order_id)
        into p_flag, p_old_order
        from scmdata.t_asnordered a
       where a.asn_id = p_asnordered.asn_id
         and a.company_id = p_company_id;

      if p_flag = 1 and p_old_order <> p_asnordered.order_id then
        p_delete_by_asn(p_asnordered.asn_id, p_company_id);
        p_flag := 0;
      end if;

      if p_has_itf <> 1 or (p_has_itf = 1 and p_flag = 0) then

        if p_flag = 0 then
          p_asn_state := 'IN';
          insert into scmdata.t_asnordered
            (asn_id,
             company_id,
             dc_company_id,
             status,
             order_id,
             supplier_code,
             pcome_date,
             changetimes,
             scan_time,
             memo,
             create_id,
             create_time,
             update_id,
             update_time,
             pcome_interval,
             end_acc_time)
          values
            (p_asnordered.asn_id,
             p_company_id,
             p_company_id,
             p_asn_state,
             p_asnordered.order_id,
             (select max(w.supplier_code)
                from scmdata.t_ordered w
               where w.order_code = p_asnordered.order_id
                 and w.company_id = p_company_id),
             p_asnordered.pcome_date,
             p_asnordered.changetimes,
             p_asnordered.scan_time,
             p_asnordered.memo,
             nvl(p_asnordered.create_id, 'ADMIN'),
             nvl(p_asnordered.create_time, sysdate),
             nvl(p_asnordered.update_id, 'ADMIN'),
             nvl(p_asnordered.update_time, sysdate),
             p_asnordered.pcome_interval,
             p_asnordered.end_acc_time);
        else
          update scmdata.t_asnordered a
             set a.pcome_date     = p_asnordered.pcome_date,
                 a.pcome_interval = p_asnordered.pcome_interval,
                 a.scan_time      = nvl(p_asnordered.scan_time, a.scan_time),
                 a.changetimes    = p_asnordered.changetimes,
                 a.memo           = p_asnordered.memo,
                 a.end_acc_time   = p_asnordered.end_acc_time,
                 a.order_id       = p_asnordered.order_id
           where a.asn_id = p_asnordered.asn_id
             and a.company_id = p_company_id;
        end if;
        scmdata.pkg_inf_asn.p_sync_delivery_record_by_asnorder(p_asn_id     => p_asnordered.asn_id,
                                                               p_company_id => p_company_id);
        if p_has_itf = 1 then
          update scmdata.t_asnordered_itf a
             set a.port_status = 'SP'
           where a.asn_id = p_asnordered.asn_id
             and a.company_id = p_company_id;
        end if;

      else
        --走接口
        select nvl(max(1), 0), max(a.order_id)
          into p_flag, p_old_order
          from scmdata.t_asnordered_inf a
         where a.asn_id = p_asnordered.asn_id
           and a.receive_type = 'Y'
           and a.company_id = p_company_id;

        if p_flag = 1 and p_old_order <> p_asnordered.order_id then
          p_delete_by_asn(p_asnordered.asn_id, p_company_id);
          p_flag := 0;
        end if;

        if p_flag = 0 then
          p_asn_state := 'IN';
          insert into scmdata.t_asnordered_inf
            (asn_id,
             company_id,
             dc_company_id,
             status,
             order_id,
             supplier_code,
             pcome_date,
             changetimes,
             scan_time,
             memo,
             create_id,
             create_time,
             update_id,
             update_time,
             pcome_interval,
             end_acc_time,
             receive_time,
             receive_type,
             receive_msg,
             operation_flag,
             operation_type)
          values
            (p_asnordered.asn_id,
             p_company_id,
             p_company_id,
             p_asn_state,
             p_asnordered.order_id,
             (select max(w.supplier_code)
                from scmdata.t_ordered w
               where w.order_code = p_asnordered.order_id
                 and w.company_id = p_company_id),
             p_asnordered.pcome_date,
             p_asnordered.changetimes,
             p_asnordered.scan_time,
             p_asnordered.memo,
             nvl(p_asnordered.create_id, 'ADMIN'),
             nvl(p_asnordered.create_time, sysdate),
             nvl(p_asnordered.update_id, 'ADMIN'),
             nvl(p_asnordered.update_time, sysdate),
             p_asnordered.pcome_interval,
             p_asnordered.end_acc_time,
             sysdate,
             'Y',
             'qa接口冲突回避',
             1,
             'IU');
        else
          update scmdata.t_asnordered_inf a
             set a.pcome_date     = p_asnordered.pcome_date,
                 a.pcome_interval = p_asnordered.pcome_interval,
                 a.scan_time      = nvl(p_asnordered.scan_time, a.scan_time),
                 a.changetimes    = p_asnordered.changetimes,
                 a.memo           = p_asnordered.memo,
                 a.end_acc_time   = p_asnordered.end_acc_time,
                 a.order_id       = p_asnordered.order_id,
                 a.receive_time   = sysdate,
                 a.operation_flag = 1,
                 a.operation_type = 'IU'
           where a.asn_id = p_asnordered.asn_id
             and a.receive_type = 'Y'
             and a.company_id = p_company_id;
        end if;
        scmdata.pkg_inf_asn.p_sync_delivery_record_by_asnorder_inf(p_asn_id     => p_asnordered.asn_id,
                                                                   p_company_id => p_company_id);
      end if;

    else
      --进入接口表
      merge into scmdata.t_asnordered_inf a
      using (select p_asnordered.asn_id         asn_id,
                    p_company_id                company_id,
                    p_company_id                dc_company_id,
                    p_asnordered.status         status,
                    p_asnordered.order_id       order_id,
                    p_asnordered.supplier_code  supplier_code,
                    p_asnordered.pcome_date     pcome_date,
                    p_asnordered.changetimes    changetimes,
                    p_asnordered.scan_time      scan_time,
                    p_asnordered.memo           memo,
                    p_asnordered.create_id      create_id,
                    p_asnordered.create_time    create_time,
                    p_asnordered.update_id      update_id,
                    p_asnordered.update_time    update_time,
                    p_asnordered.pcome_interval pcome_interval,
                    p_asnordered.end_acc_time   end_acc_time
               from dual) b
      on (a.asn_id = b.asn_id and a.company_id = b.company_id)
      when matched then
        update
           set a.pcome_date     = b.pcome_date,
               a.scan_time      = nvl(b.scan_time, a.scan_time),
               a.memo           = b.memo,
               a.pcome_interval = b.pcome_interval,
               a.end_acc_time   = b.end_acc_time,
               a.receive_time   = sysdate,
               a.operation_flag = 0,
               a.operation_type = 'IU'
      when not matched then
        insert
          (a.asn_id,
           a.company_id,
           a.dc_company_id,
           a.status,
           a.order_id,
           a.supplier_code,
           a.pcome_date,
           a.changetimes,
           a.scan_time,
           a.memo,
           a.create_id,
           a.create_time,
           a.update_id,
           a.update_time,
           a.pcome_interval,
           a.receive_time,
           a.receive_type,
           a.receive_msg,
           a.operation_flag,
           a.operation_type,
           a.end_acc_time)
        values
          (b.asn_id,
           b.company_id,
           b.dc_company_id,
           b.status,
           b.order_id,
           b.supplier_code,
           b.pcome_date,
           b.changetimes,
           b.scan_time,
           b.memo,
           b.create_id,
           b.create_time,
           b.update_id,
           b.update_time,
           b.pcome_interval,
           sysdate,
           'R',
           '订单不存在',
           0,
           'IU',
           b.end_acc_time);

    end if;
  end p_dual_asnordered_if;

  procedure p_dual_asnorders_if(p_asnorders scmdata.t_asnorders%rowtype) is
    p_company_id varchar2(32);
    p_flag       varchar2(32);
    v_goo_id     varchar2(32);
    p_has_itf    number(1);
  begin
    select max(company_id)
      into p_company_id
      from scmdata.t_interface a
     where a.interface_id = 'ASN_MAIN';

    --检查商品
    select max(goo_id)
      into v_goo_id
      from scmdata.t_commodity_info a
     where a.rela_goo_id = p_asnorders.goo_id
       and a.company_id = p_company_id;
    --如果有接口表不更新
    select nvl(max(1), 0)
      into p_has_itf
      from scmdata.t_asnorders_itf a
     where a.asn_id = p_asnorders.asn_id
       and a.goo_id = p_asnorders.goo_id
       and a.company_id = p_company_id;
    /* if p_has_itf = 1 and p_asnorders.sorting_time is null then
      return;
    elsif p_has_itf = 1 and p_asnorders.sorting_time is not null and
          v_goo_id is not null then
      update scmdata.t_asnorders a
         set a.sorting_time = p_asnorders.sorting_time
       where a.asn_id = p_asnorders.asn_id
         and a.goo_id = p_asnorders.goo_id
         and a.company_id = p_company_id;
      scmdata.pkg_inf_asn.p_sync_delivery_record_by_asnorder(p_asn_id     => p_asnorders.asn_id,
                                                             p_company_id => p_company_id);
    end if;*/
    if v_goo_id is not null then
      select nvl(max(1), 0)
        into p_flag
        from scmdata.t_asnorders a
       where a.asn_id = p_asnorders.asn_id
         and a.goo_id = v_goo_id
         and a.company_id = p_company_id;
      if p_has_itf <> 1 or (p_has_itf = 1 and p_flag = 0) then

        if p_flag = 0 then
          insert into scmdata.t_asnorders
            (asn_id,
             company_id,
             dc_company_id,
             goo_id,
             order_amount,
             pcome_amount,
             asngot_amount,
             got_amount,
             memo,
             receive_time,
             create_id,
             create_time,
             update_id,
             update_time,
             is_fcl_out,
             is_qc_required,
             sorting_time,
             asn_documents_status,
             packcases)
          values
            (p_asnorders.asn_id,
             p_company_id,
             p_company_id,
             v_goo_id,
             p_asnorders.order_amount,
             p_asnorders.pcome_amount,
             p_asnorders.asngot_amount,
             p_asnorders.got_amount,
             p_asnorders.memo,
             p_asnorders.receive_time,
             'ADMIN',
             sysdate,
             'ADMIN',
             sysdate,
             p_asnorders.is_fcl_out,
             p_asnorders.is_qc_required,
             p_asnorders.sorting_time,
             p_asnorders.asn_documents_status,
             p_asnorders.packcases);
        else
          update scmdata.t_asnorders a
             set a.order_amount         = p_asnorders.order_amount,
                 a.asngot_amount        = p_asnorders.asngot_amount,
                 a.pcome_amount         = p_asnorders.pcome_amount,
                 a.got_amount           = p_asnorders.got_amount,
                 a.memo                 = p_asnorders.memo,
                 a.receive_time         = p_asnorders.receive_time,
                 a.is_fcl_out           = p_asnorders.is_fcl_out,
                 a.is_qc_required       = p_asnorders.is_qc_required,
                 a.sorting_time         = nvl(p_asnorders.sorting_time,
                                              a.sorting_time),
                 a.asn_documents_status = p_asnorders.asn_documents_status,
                 a.update_id            = 'ADMIN',
                 a.update_time          = sysdate,
                 a.packcases            = p_asnorders.packcases
           where a.asn_id = p_asnorders.asn_id
             and a.goo_id = v_goo_id
             and a.company_id = p_company_id;
        end if;
        scmdata.pkg_inf_asn.p_sync_delivery_record_by_asnorder(p_asn_id     => p_asnorders.asn_id,
                                                               p_company_id => p_company_id);

        if p_has_itf = 1 then
          update scmdata.t_asnorders_itf a
             set a.port_status = 'SP'
           where a.asn_id = p_asnorders.asn_id
             and a.goo_id = v_goo_id
             and a.company_id = p_company_id;
        end if;
      else
        --走接口表
        select nvl(max(1), 0)
          into p_flag
          from scmdata.t_asnorders_inf a
         where a.asn_id = p_asnorders.asn_id
           and a.goo_id = v_goo_id
           and a.receive_type = 'Y'
           and a.company_id = p_company_id;
        if p_flag = 0 then
          insert into scmdata.t_asnorders_inf
            (asn_id,
             company_id,
             dc_company_id,
             goo_id,
             order_amount,
             pcome_amount,
             asngot_amount,
             got_amount,
             memo,
             receive_time,
             create_id,
             create_time,
             update_id,
             update_time,
             is_fcl_out,
             is_qc_required,
             sorting_time,
             receive_if_time,
             receive_type,
             receive_msg,
             operation_flag,
             operation_type,
             asn_documents_status,
             packcases)
          values
            (p_asnorders.asn_id,
             p_company_id,
             p_company_id,
             v_goo_id,
             p_asnorders.order_amount,
             p_asnorders.pcome_amount,
             p_asnorders.asngot_amount,
             p_asnorders.got_amount,
             p_asnorders.memo,
             p_asnorders.receive_time,
             'ADMIN',
             sysdate,
             'ADMIN',
             sysdate,
             p_asnorders.is_fcl_out,
             p_asnorders.is_qc_required,
             p_asnorders.sorting_time,
             sysdate,
             'Y',
             'qc接口冲突回避',
             1,
             'IU',
             p_asnorders.asn_documents_status,
             p_asnorders.packcases);
        else
          update scmdata.t_asnorders_inf a
             set a.order_amount         = p_asnorders.order_amount,
                 a.asngot_amount        = p_asnorders.asngot_amount,
                 a.pcome_amount         = p_asnorders.pcome_amount,
                 a.got_amount           = p_asnorders.got_amount,
                 a.memo                 = p_asnorders.memo,
                 a.receive_time         = p_asnorders.receive_time,
                 a.is_fcl_out           = p_asnorders.is_fcl_out,
                 a.is_qc_required       = p_asnorders.is_qc_required,
                 a.sorting_time         = nvl(p_asnorders.sorting_time,
                                              a.sorting_time),
                 a.update_id            = 'ADMIN',
                 a.update_time          = sysdate,
                 a.receive_if_time      = sysdate,
                 a.operation_flag       = 1,
                 a.packcases            = p_asnorders.packcases,
                 a.asn_documents_status = p_asnorders.asn_documents_status
           where a.asn_id = p_asnorders.asn_id
             and a.goo_id = v_goo_id
             and a.receive_type = 'Y'
             and a.company_id = p_company_id;
        end if;
        scmdata.pkg_inf_asn.p_sync_delivery_record_by_asnorder_inf(p_asn_id     => p_asnorders.asn_id,
                                                                   p_company_id => p_company_id);
      end if;
    else
      --进入接口表
      merge into scmdata.t_asnorders_inf a
      using (select p_asnorders.asn_id               asn_id,
                    p_company_id                     company_id,
                    p_company_id                     dc_company_id,
                    p_asnorders.goo_id               goo_id,
                    p_asnorders.order_amount         order_amount,
                    p_asnorders.pcome_amount         pcome_amount,
                    p_asnorders.asngot_amount        asngot_amount,
                    p_asnorders.got_amount           got_amount,
                    p_asnorders.memo                 memo,
                    p_asnorders.receive_time         receive_time,
                    p_asnorders.create_id            create_id,
                    p_asnorders.create_time          create_time,
                    p_asnorders.update_id            update_id,
                    p_asnorders.update_time          update_time,
                    p_asnorders.is_qc_required       is_qc_required,
                    p_asnorders.is_fcl_out           is_fcl_out,
                    p_asnorders.sorting_time         sorting_time,
                    p_asnorders.asn_documents_status asn_documents_status,
                    p_asnorders.packcases            packcases
               from dual) b
      on (a.asn_id = b.asn_id and a.goo_id = b.goo_id and a.company_id = b.company_id)
      when matched then
        update
           set a.order_amount         = b.order_amount,
               a.asngot_amount        = b.asngot_amount,
               a.got_amount           = b.got_amount,
               a.memo                 = b.memo,
               a.receive_time         = b.receive_time,
               a.is_fcl_out           = b.is_fcl_out,
               a.is_qc_required       = b.is_qc_required,
               a.sorting_time         = nvl(b.sorting_time, a.sorting_time),
               a.receive_if_time      = sysdate,
               a.asn_documents_status = b.asn_documents_status,
               a.packcases            = b.packcases,
               a.operation_flag       = 0
      when not matched then
        insert
          (a.asn_id,
           a.company_id,
           a.dc_company_id,
           a.goo_id,
           a.order_amount,
           a.pcome_amount,
           a.asngot_amount,
           a.got_amount,
           a.memo,
           a.receive_time,
           a.create_id,
           a.create_time,
           a.update_id,
           a.update_time,
           a.receive_if_time,
           a.receive_type,
           a.receive_msg,
           a.operation_flag,
           a.operation_type,
           a.is_fcl_out,
           a.is_qc_required,
           a.sorting_time,
           a.asn_documents_status,
           a.packcases)
        values
          (b.asn_id,
           b.company_id,
           b.dc_company_id,
           b.goo_id,
           b.order_amount,
           b.pcome_amount,
           b.asngot_amount,
           b.got_amount,
           b.memo,
           b.receive_time,
           b.create_id,
           b.create_time,
           b.update_id,
           b.update_time,
           sysdate,
           'R',
           '货号未接入',
           0,
           'IU',
           b.is_fcl_out,
           b.is_qc_required,
           b.sorting_time,
           b.asn_documents_status,
           b.packcases);

    end if;

  end p_dual_asnorders_if;

  procedure p_dual_asnordersitem_if(p_asnordersitem scmdata.t_asnordersitem%rowtype) is
    p_company_id varchar2(32);
    p_flag       number(1);
    v_goo_id     varchar2(32);
    p_error_flag number(1);
    p_has_itf    number(1);
  begin
    select max(company_id)
      into p_company_id
      from scmdata.t_interface a
     where a.interface_id = 'ASN_MAIN';
    select nvl(max(1), 0)
      into p_has_itf
      from scmdata.t_asnordersitem_itf a
     where a.asn_id = p_asnordersitem.asn_id
       and a.barcode = p_asnordersitem.barcode
       and a.company_id = p_company_id;
    /*if p_has_itf = 1 then
      return;
    end if;*/

    select max(goo_id)
      into v_goo_id
      from scmdata.t_commodity_info a
     where a.rela_goo_id = p_asnordersitem.goo_id
       and a.company_id = p_company_id;
    if v_goo_id is not null then
      select nvl(max(1), 0)
        into p_flag
        from scmdata.t_asnordersitem a
       where a.asn_id = p_asnordersitem.asn_id
         and a.company_id = p_company_id
         and a.goo_id = v_goo_id
         and a.barcode = p_asnordersitem.barcode;
      if p_has_itf = 1 and p_flag = 1 then
        return;
      end if;
      if p_flag = 0 then
        insert into scmdata.t_asnordersitem
          (asn_id,
           company_id,
           dc_company_id,
           goo_id,
           barcode,
           order_amount,
           pcome_amount,
           asngot_amount,
           got_amount,
           memo,
           create_id,
           create_time,
           update_id,
           update_time,
           packcases)
        values
          (p_asnordersitem.asn_id,
           p_company_id,
           p_company_id,
           v_goo_id,
           p_asnordersitem.barcode,
           p_asnordersitem.order_amount,
           p_asnordersitem.pcome_amount,
           p_asnordersitem.asngot_amount,
           p_asnordersitem.got_amount,
           p_asnordersitem.memo,
           'ADMIN',
           sysdate,
           'ADMIN',
           sysdate,
           p_asnordersitem.packcases);
      else
        update scmdata.t_asnordersitem a
           set a.order_amount  = p_asnordersitem.order_amount,
               a.pcome_amount  = p_asnordersitem.pcome_amount,
               a.asngot_amount = p_asnordersitem.asngot_amount,
               a.got_amount    = p_asnordersitem.got_amount,
               a.memo          = p_asnordersitem.memo,
               a.update_id     = 'ADMIN',
               a.update_time   = sysdate,
               a.packcases     = p_asnordersitem.packcases
         where a.asn_id = p_asnordersitem.asn_id
           and a.company_id = p_company_id
           and a.goo_id = v_goo_id
           and a.barcode = p_asnordersitem.barcode;
      end if;
      scmdata.pkg_inf_asn.p_sync_delivery_record_item_by_asnordersitem(p_asn_id     => p_asnordersitem.asn_id,
                                                                       p_goo_id     => v_goo_id,
                                                                       p_company_id => p_company_id,
                                                                       p_barcode    => p_asnordersitem.barcode,
                                                                       po_error_flg => p_error_flag);

      if p_has_itf = 1 then
        update scmdata.t_asnordersitem_itf a
           set a.port_status = 'SP'
         where a.asn_id = p_asnordersitem.asn_id
           and a.barcode = p_asnordersitem.barcode
           and a.company_id = p_company_id;
      end if;
    end if;

    if p_error_flag = 1 or v_goo_id is null then
      --进入接口表
      merge into scmdata.t_asnordersitem_inf a
      using (select p_asnordersitem.asn_id        asn_id,
                    p_company_id                  company_id,
                    p_company_id                  dc_company_id,
                    p_asnordersitem.goo_id        goo_id,
                    p_asnordersitem.barcode       barcode,
                    p_asnordersitem.order_amount  order_amount,
                    p_asnordersitem.pcome_amount  pcome_amount,
                    p_asnordersitem.asngot_amount asngot_amount,
                    p_asnordersitem.got_amount    got_amount,
                    p_asnordersitem.memo          memo,
                    p_asnordersitem.create_id     create_id,
                    p_asnordersitem.create_time   create_time,
                    p_asnordersitem.update_id     update_id,
                    p_asnordersitem.update_time   update_time,
                    p_asnordersitem.packcases     packcases
               from dual) b
      on (a.asn_id = b.asn_id and a.goo_id = b.goo_id and a.company_id = b.company_id and a.barcode = b.barcode)
      when matched then
        update
           set a.order_amount    = b.order_amount,
               a.pcome_amount    = b.pcome_amount,
               a.asngot_amount   = b.asngot_amount,
               a.got_amount      = b.got_amount,
               a.memo            = b.memo,
               a.update_time     = sysdate,
               a.update_id       = 'ADMIN',
               a.receive_if_time = sysdate,
               a.operation_flag  = 0,
               a.packcases       = b.packcases
      when not matched then
        insert
          (a.asn_id,
           a.company_id,
           a.dc_company_id,
           a.goo_id,
           a.barcode,
           a.order_amount,
           a.pcome_amount,
           a.asngot_amount,
           a.got_amount,
           a.memo,
           a.create_id,
           a.create_time,
           a.update_id,
           a.update_time,
           a.receive_if_time,
           a.receive_type,
           a.receive_msg,
           a.operation_flag,
           a.operation_type,
           a.packcases)
        values
          (b.asn_id,
           b.company_id,
           b.dc_company_id,
           b.goo_id,
           b.barcode,
           b.order_amount,
           b.pcome_amount,
           b.asngot_amount,
           b.got_amount,
           b.memo,
           b.create_id,
           b.create_time,
           b.update_id,
           b.update_time,
           sysdate,
           'R',
           '商品未导入',
           0,
           'IU',
           b.packcases);
    end if;

  end p_dual_asnordersitem_if;

  procedure p_dual_asnorderpacks_if(p_asnorderpacks scmdata.t_asnorderpacks%rowtype) is
    p_company_id varchar2(32);
    v_goo_id     varchar2(32);
    p_flag       number(1);
  begin
    select max(company_id)
      into p_company_id
      from scmdata.t_interface a
     where a.interface_id = 'ASN_MAIN';
    select max(goo_id)
      into v_goo_id
      from scmdata.t_commodity_info a
     where a.rela_goo_id = p_asnorderpacks.goo_id
       and a.company_id = p_company_id;
    if v_goo_id is null then
      select nvl(max(1), 0)
        into p_flag
        from scmdata.t_asnorderpacks_inf a
       where a.asn_id = p_asnorderpacks.asn_id
         and a.company_id = p_company_id
         and a.pack_barcode = p_asnorderpacks.pack_barcode
         and a.goodsid = p_asnorderpacks.goodsid;
      if p_flag = 0 then
        insert into scmdata.t_asnorderpacks_inf
          (asn_id,
           company_id,
           dc_company_id,
           operator_id,
           goo_id,
           barcode,
           pack_no,
           pack_barcode,
           packno,
           packcount,
           packamount,
           skupack_no,
           skupack_count,
           sku_number,
           ratioid,
           pack_specs_send,
           memo,
           create_id,
           create_time,
           update_id,
           update_time,
           goodsid,
           receive_time,
           receive_type,
           receive_msg,
           operation_flag,
           operation_type)
        values
          (p_asnorderpacks.asn_id,
           p_company_id,
           p_company_id,
           p_asnorderpacks.operator_id,
           p_asnorderpacks.goo_id,
           p_asnorderpacks.barcode,
           p_asnorderpacks.pack_no,
           p_asnorderpacks.pack_barcode,
           p_asnorderpacks.pack_no,
           p_asnorderpacks.packcount,
           p_asnorderpacks.packamount,
           p_asnorderpacks.skupack_no,
           p_asnorderpacks.skupack_count,
           p_asnorderpacks.sku_number,
           p_asnorderpacks.ratioid,
           p_asnorderpacks.pack_specs_send,
           p_asnorderpacks.memo,
           p_asnorderpacks.create_id,
           p_asnorderpacks.create_time,
           p_asnorderpacks.update_id,
           p_asnorderpacks.update_time,
           p_asnorderpacks.goodsid,
           sysdate,
           'R',
           '货号错误',
           0,
           'I');
      end if;
    else
      select nvl(max(1), 0)
        into p_flag
        from scmdata.t_asnorderpacks a
       where a.asn_id = p_asnorderpacks.asn_id
         and a.company_id = p_company_id
         and a.pack_barcode = p_asnorderpacks.pack_barcode
         and a.goodsid = p_asnorderpacks.goodsid;
      if p_flag = 0 then
        insert into scmdata.t_asnorderpacks
          (asn_id,
           company_id,
           dc_company_id,
           operator_id,
           goo_id,
           barcode,
           pack_no,
           pack_barcode,
           packno,
           packcount,
           packamount,
           skupack_no,
           skupack_count,
           sku_number,
           ratioid,
           pack_specs_send,
           memo,
           create_id,
           create_time,
           update_id,
           update_time,
           goodsid)
        values
          (p_asnorderpacks.asn_id,
           p_company_id,
           p_company_id,
           p_asnorderpacks.operator_id,
           v_goo_id,
           p_asnorderpacks.barcode,
           p_asnorderpacks.pack_no,
           p_asnorderpacks.pack_barcode,
           p_asnorderpacks.pack_no,
           p_asnorderpacks.packcount,
           p_asnorderpacks.packamount,
           p_asnorderpacks.skupack_no,
           p_asnorderpacks.skupack_count,
           p_asnorderpacks.sku_number,
           p_asnorderpacks.ratioid,
           p_asnorderpacks.pack_specs_send,
           p_asnorderpacks.memo,
           p_asnorderpacks.create_id,
           p_asnorderpacks.create_time,
           p_asnorderpacks.update_id,
           p_asnorderpacks.update_time,
           p_asnorderpacks.goodsid);
      end if;
    end if;
  end p_dual_asnorderpacks_if;

  procedure p_dual_delivery_record_if(p_delivery_record scmdata.t_delivery_record%rowtype) is
    v_delivery_record_code VARCHAR2(32);
    v_goo_id               VARCHAR2(32);
    p_delivery_rec         scmdata.t_delivery_record%ROWTYPE;
    p_id                   varchar2(32);
    p_company_id           varchar2(32);
    p_send_by_sup          number(1);
    p_finish_time          date;
    p_has_itf              number(1);
    p_old_order            varchar2(32);
  begin
    select max(company_id)
      into p_company_id
      from scmdata.t_interface a
     where a.interface_id = 'DELIVERY_RECORD';

    select nvl(max(1), 0)
      into p_has_itf
      from scmdata.t_asnordered_itf a
     where a.asn_id = p_delivery_record.asn_id
       and a.company_id = p_company_id;
    --如果有接口表不更新
    --asnordered
    select nvl(max(1), 0)
      into p_has_itf
      from scmdata.t_asnordered_itf a
     where a.asn_id = p_delivery_record.asn_id
       and a.company_id = p_company_id;
    /* if p_has_itf = 1 and p_delivery_record.end_acc_time is null then
      return;
    end if;*/
    --asnorders
    select nvl(max(1), p_has_itf)
      into p_has_itf
      from scmdata.t_asnorders_itf a
     where a.asn_id = p_delivery_record.asn_id
       and a.goo_id = p_delivery_record.goo_id
       and a.company_id = p_company_id;
    /*  if p_has_itf = 1 and p_delivery_record.sorting_date is null then
      return;
    end if;*/

    v_delivery_record_code := pkg_plat_comm.f_getkeyid_plat(pi_pre     => 'DR',
                                                            pi_seqname => 'SEQ_T_DELIVERY_RECORD',
                                                            pi_seqnum  => 99);
    --货号
    select max(goo_id)
      into v_goo_id
      from scmdata.t_commodity_info a
     where a.rela_goo_id = p_delivery_record.goo_id
       and a.company_id = p_company_id;
    if v_goo_id is null then
      return;
    end if;

    --判断是否存在
    select max(delivery_record_id), max(a.order_code)
      into p_id, p_old_order
      from scmdata.t_delivery_record a
     where a.asn_id = p_delivery_record.asn_id
       and a.company_id = p_company_id;
    if p_delivery_record.create_time is null and
       p_delivery_record.delivery_origin_time is null then
      return;
    end if;

    if p_id is not null and p_old_order <> p_delivery_record.order_code then
      p_delete_by_asn(p_asn_id     => p_delivery_record.asn_id,
                      p_company_id => p_company_id);
      p_id := null;
    end if;

    if p_id is null then
      --判断是否是供应商代发且已结束，
      select max(send_by_sup), max(finish_time)
        into p_send_by_sup, p_finish_time
        from scmdata.t_ordered a
       where a.order_code = p_delivery_record.order_code
         and a.company_id = p_company_id;

      p_id := scmdata.f_get_uuid();
      insert into scmdata.t_delivery_record
        (delivery_record_id,
         company_id,
         delivery_record_code,
         order_code,
         ing_id,
         goo_id,
         delivery_price,
         delivery_amount,
         create_id,
         create_time,
         memo,
         delivery_date,
         delivery_origin_time,
         accept_date,
         sorting_date,
         shipment_date,
         update_id,
         update_time,
         asn_id,
         PREDICT_DELIVERY_AMOUNT,
         DELIVERY_ORIGIN_AMOUNT,
         pick_time,
         is_fcl_out,
         is_qc_required,
         predict_delivery_date,
         end_acc_time,
         asn_documents_status,
         packcases)
      values
        (p_id,
         p_company_id,
         v_delivery_record_code,
         p_delivery_record.order_code,
         null,
         v_goo_id,
         0,
         p_delivery_record.delivery_amount,
         'ADMIN',
         sysdate,
         null,
         decode(p_send_by_sup,
                1,
                p_delivery_record.sorting_date,
                p_delivery_record.delivery_date),
         decode(p_send_by_sup,
                1,
                p_delivery_record.sorting_date,
                p_delivery_record.delivery_date),
         p_delivery_record.accept_date,
         p_delivery_record.sorting_date,
         p_delivery_record.shipment_date,
         null,
         null,
         p_delivery_record.asn_id,
         p_delivery_record.predict_delivery_amount,
         p_delivery_record.DELIVERY_ORIGIN_AMOUNT,
         p_delivery_record.pick_time,
         p_delivery_record.is_fcl_out,
         p_delivery_record.is_qc_required,
         p_delivery_record.predict_delivery_date,
         p_delivery_record.end_acc_time,
         p_delivery_record.asn_documents_status,
         p_delivery_record.packcases);

      insert into scmdata.t_delivery_record_ctl
        (ctl_id,
         inf_id,
         company_id,
         order_code,
         ing_id,
         goo_id,
         delivery_price,
         delivery_amount,
         delivery_date,
         create_id,
         return_type,
         return_msg,
         itf_type,
         sender,
         receiver,
         receive_time)
      values
        (f_get_uuid(),
         p_delivery_record.asn_id,
         p_company_id,
         p_delivery_record.order_code,
         null,
         p_delivery_record.goo_id,
         0,
         p_delivery_record.DELIVERY_ORIGIN_AMOUNT,
         p_delivery_record.delivery_date,
         'ADMIN',
         'Y',
         '收货单' || p_delivery_record.asn_id || '导入成功',
         'DELIVERY_RECORD',
         '181',
         'scm',
         sysdate);
      --pkg_production_progress.sync_delivery_record(p_delivery_rec => p_delivery_rec);
      update scmdata.t_orders a
         set a.got_amount = nvl((select sum(k.delivery_amount)
                                  from scmdata.t_delivery_record k
                                 where k.order_code =
                                       p_delivery_record.order_code
                                   and k.company_id = p_company_id
                                   and k.goo_id = v_goo_id),
                                0)
       where a.order_id = p_delivery_record.order_code
         and a.company_id = p_company_id
         and a.goo_id = v_goo_id;

      --20221103 补充同步至条码生成表
      merge into scmdata.t_delivery_record_barcode a
      using (select p_delivery_record.asn_id asn_id from dual) b
      on (b.asn_id = a.asn_id)
      when not matched then
        insert
          (a.delivery_record_barcode_id,
           a.asn_id,
           a.create_id,
           a.create_time,
           a.generated,
           a.generate_time,
           a.barcode_file_id,
           a.pause)
        values
          (scmdata.f_get_uuid(),
           b.asn_id,
           'ADMIN',
           sysdate,
           0,
           null,
           null,
           0);
    else
      select max(a.send_by_sup)
        into p_send_by_sup
        from scmdata.t_ordered a
       where a.order_code = p_delivery_record.order_code
         and a.company_id = p_company_id;
      --因熊猫改造，对cmx_asnreport_wms中获取的数据是
      update t_delivery_record a
         set a.accept_date             = p_delivery_record.accept_date,
             a.delivery_amount         = nvl(p_delivery_record.delivery_amount,
                                             a.delivery_amount),
             a.delivery_origin_amount  = nvl(p_delivery_record.delivery_origin_amount,
                                             a.delivery_origin_amount),
             a.packcases               = p_delivery_record.packcases,
             a.end_acc_time            = nvl(p_delivery_record.end_acc_time,
                                             a.end_acc_time),
             a.delivery_date = case
                                 when p_send_by_sup = 1 then
                                  nvl(p_delivery_record.sorting_date,
                                      a.delivery_date)

                                 else
                                  nvl(p_delivery_record.delivery_date,
                                      a.delivery_date)
                               end,
             a.delivery_origin_time = case
                                        when p_send_by_sup = 1 then
                                         nvl(p_delivery_record.sorting_date,
                                             a.delivery_origin_time)

                                        else
                                         nvl(p_delivery_record.delivery_date,
                                             a.delivery_origin_time)
                                      end,
             a.shipment_date           = nvl(p_delivery_record.shipment_date,
                                             a.shipment_date),
             a.sorting_date            = nvl(p_delivery_record.sorting_date,
                                             a.sorting_date),
             a.pick_time               = nvl(p_delivery_record.pick_time,
                                             a.pick_time),
             a.is_fcl_out              = p_delivery_record.is_fcl_out,
             a.is_qc_required          = p_delivery_record.is_qc_required,
             a.PREDICT_DELIVERY_AMOUNT = nvl(p_delivery_record.predict_delivery_amount,
                                             a.PREDICT_DELIVERY_AMOUNT),
             a.predict_delivery_date   = p_delivery_record.predict_delivery_date,
             a.order_code              = p_delivery_record.order_code,
             a.asn_documents_status    = p_delivery_record.asn_documents_status
       where a.delivery_record_id = p_id;

      update scmdata.t_orders a
         set a.got_amount = nvl((select sum(k.delivery_amount)
                                  from scmdata.t_delivery_record k
                                 where k.order_code =
                                       p_delivery_record.order_code
                                   and k.company_id = p_company_id
                                   and k.goo_id = v_goo_id),
                                0)
       where a.order_id = p_delivery_record.order_code
         and a.company_id = p_company_id
         and a.goo_id = v_goo_id;

    end if;
    select *
      into p_delivery_rec
      from scmdata.t_delivery_record a
     where a.delivery_record_id = p_id;

    pkg_production_progress.sync_delivery_record(p_delivery_rec => p_delivery_rec);
    if p_has_itf <> 1 then
      scmdata.pkg_inf_asn.p_sync_asn_by_delivery_record(p_delivery_record => p_delivery_rec);
    end if;
  exception
    when Dup_val_on_index then
      rollback;
      return;
  end p_dual_delivery_record_if;

  procedure p_dual_delivery_record_item_if(p_delivery_record_item scmdata.t_delivery_record_item%rowtype) is
    v_delivery_record_id       VARCHAR2(32);
    v_goo_id                   VARCHAR2(32);
    p_id                       varchar2(32);
    p_company_id               varchar2(32);
    p_order_code               varchar2(32);
    p_delivery_record_item_dex scmdata.t_delivery_record_item%rowtype;
    p_receive_time             varchar2(32);
    p_has_itf                  number(1);
  BEGIN
    select max(company_id)
      into p_company_id
      from scmdata.t_interface a
     where a.interface_id = 'DELIVERY_RECORD';
    select nvl(max(1), 0)
      into p_has_itf
      from scmdata.t_asnordersitem_itf a
     where a.asn_id = p_delivery_record_item.delivery_record_id
       and a.barcode = p_delivery_record_item.barcode
       and a.company_id = p_company_id;
    /*  if p_has_itf = 1 then
      return;
    end if;*/
    --货号
    select max(goo_id)
      into v_goo_id
      from scmdata.t_commodity_info a
     where a.rela_goo_id = p_delivery_record_item.goo_id
       and a.company_id = p_company_id;
    --
    select max(delivery_record_id), max(order_code), max(a.accept_date)
      into v_delivery_record_id, p_order_code, p_receive_time
      from scmdata.t_delivery_record a
     where a.asn_id = p_delivery_record_item.delivery_record_id
       and a.company_id = p_company_id;
    if v_delivery_record_id is null then
      return;
    end if;
    --判断是否存在
    select max(a.delivery_record_item_id)
      into p_id
      from scmdata.t_delivery_record_item a
     where a.delivery_record_id = v_delivery_record_id
       and a.barcode = p_delivery_record_item.barcode;
    if p_id is null then
      p_id := f_get_uuid();
      insert into scmdata.t_delivery_record_item
        (delivery_record_item_id,
         company_id,
         goo_id,
         delivery_record_id,
         barcode,
         delivery_amount,
         create_time,
         create_id,
         accept_date,
         sorting_date,
         shipment_date,
         PREDICT_DELIVERY_AMOUNT,
         DELIVERY_ORIGIN_AMOUNT,
         packcases)
      values
        (p_id,
         p_company_id,
         v_goo_id,
         v_delivery_record_id,
         p_delivery_record_item.barcode,
         p_delivery_record_item.delivery_amount,
         sysdate,
         'ADMIN',
         nvl(p_delivery_record_item.accept_date, p_receive_time),
         p_delivery_record_item.sorting_date,
         p_delivery_record_item.shipment_date,
         p_delivery_record_item.predict_delivery_amount,
         p_delivery_record_item.delivery_origin_amount,
         p_delivery_record_item.packcases);
    else
      update scmdata.t_delivery_record_item a
         set a.delivery_amount         = nvl(p_delivery_record_item.delivery_amount,
                                             a.delivery_amount),
             a.DELIVERY_ORIGIN_AMOUNT  = nvl(p_delivery_record_item.delivery_origin_amount,
                                             a.delivery_origin_amount),
             a.accept_date             = nvl(p_delivery_record_item.accept_date,
                                             p_receive_time),
             a.sorting_date            = nvl(p_delivery_record_item.sorting_date,
                                             a.sorting_date),
             a.shipment_date           = nvl(p_delivery_record_item.shipment_date,
                                             a.shipment_date),
             a.PREDICT_DELIVERY_AMOUNT = p_delivery_record_item.predict_delivery_amount,
             a.packcases               = p_delivery_record_item.packcases
       where a.delivery_record_item_id = p_id;
    end if;
    select *
      into p_delivery_record_item_dex
      from scmdata.t_delivery_record_item a
     where a.delivery_record_item_id = p_id;
    if v_delivery_record_id is null then
      scmdata.pkg_inf_asn.p_sync_asn_by_delivery_record_item(p_delivery_record_item => p_delivery_record_item_dex,
                                                             p_asn_id               => p_delivery_record_item.delivery_record_id);
    end if;
    update scmdata.t_ordersitem a
       set a.got_amount = nvl((select sum(ki.delivery_amount)
                                from scmdata.t_delivery_record k
                               inner join scmdata.t_delivery_record_item ki
                                  on k.delivery_record_id =
                                     ki.delivery_record_id
                               where k.order_code = p_order_code
                                 and k.company_id = p_company_id
                                 and k.goo_id = v_goo_id
                                 and ki.barcode =
                                     p_delivery_record_item.barcode),
                              0)
     where a.order_id = p_order_code
       and a.company_id = p_company_id
       and a.goo_id = v_goo_id
       and a.barcode = p_delivery_record_item.barcode;

  END p_dual_delivery_record_item_if;

  --同步asn的信息
  procedure p_sync_asn_by_delivery_record(p_delivery_record scmdata.t_delivery_record%rowtype) is
  begin
    update scmdata.t_asnordered a
       set a.end_acc_time = p_delivery_record.end_acc_time,
           a.order_id     = p_delivery_record.order_code
     where a.asn_id = p_delivery_record.asn_id
       and a.company_id = p_delivery_record.company_id;
    if sql%rowcount = 0 then
      --不存在时同步
      insert into scmdata.t_asnordered
        (asn_id,
         company_id,
         dc_company_id,
         status,
         order_id,
         supplier_code,
         pcome_date,
         changetimes,
         scan_time,
         memo,
         create_id,
         create_time,
         update_id,
         update_time,
         pcome_interval,
         end_acc_time)
      values
        (p_delivery_record.asn_id,
         p_delivery_record.company_id,
         p_delivery_record.company_id,
         'IN',
         p_delivery_record.order_code,
         (select o.supplier_code
            from scmdata.t_ordered o
           where o.order_code = p_delivery_record.order_code
             and o.company_id = p_delivery_record.company_id),
         p_delivery_record.predict_delivery_date,
         null,
         p_delivery_record.delivery_origin_time,
         p_delivery_record.memo,
         'ADMIN',
         p_delivery_record.create_time,
         'ADMIN',
         sysdate,
         null,
         p_delivery_record.end_acc_time);
    end if;
    update scmdata.t_asnorders a
       set a.pick_time    = nvl(p_delivery_record.pick_time, a.pick_time),
           a.shiment_time = nvl(p_delivery_record.shipment_date,
                                a.shiment_time),
           a.receive_time = p_delivery_record.accept_date,
           a.sorting_time = nvl(p_delivery_record.sorting_date,
                                a.sorting_time),

           a.asn_documents_status = p_delivery_record.asn_documents_status,
           a.packcases            = p_delivery_record.packcases
     where a.asn_id = p_delivery_record.asn_id
       and a.company_id = p_delivery_record.company_id
       and a.goo_id = p_delivery_record.goo_id;
    if sql%rowcount = 0 then
      insert into scmdata.t_asnorders
        (asn_id,
         company_id,
         dc_company_id,
         goo_id,
         order_amount,
         pcome_amount,
         asngot_amount,
         got_amount,
         memo,
         create_id,
         create_time,
         update_id,
         update_time,
         ret_amount,
         pick_time,
         shiment_time,
         receive_time,
         warehouse_pos,
         is_fcl_out,
         is_qc_required,
         sorting_time,
         asn_documents_status,
         packcases)
      values
        (p_delivery_record.asn_id,
         p_delivery_record.company_id,
         p_delivery_record.company_id,
         p_delivery_record.goo_id,
         (select nvl(max(o.order_amount), 0)
            from scmdata.t_orders o
           where o.order_id = p_delivery_record.order_code
             and o.company_id = p_delivery_record.company_id),
         p_delivery_record.predict_delivery_amount,
         p_delivery_record.delivery_amount,
         p_delivery_record.delivery_origin_amount,
         p_delivery_record.memo,
         p_delivery_record.create_id,
         p_delivery_record.create_time,
         p_delivery_record.update_id,
         p_delivery_record.update_time,
         null,
         p_delivery_record.pick_time,
         p_delivery_record.shipment_date,
         p_delivery_record.accept_date,
         null,
         p_delivery_record.is_fcl_out,
         p_delivery_record.is_qc_required,
         p_delivery_record.sorting_date,
         p_delivery_record.asn_documents_status,
         p_delivery_record.packcases);
    end if;

  end p_sync_asn_by_delivery_record;

  --同步asnitem信息
  procedure p_sync_asn_by_delivery_record_item(p_delivery_record_item scmdata.t_delivery_record_item%rowtype,
                                               p_asn_id               varchar2) is
  begin
    update scmdata.t_asnordersitem a
       set a.pick_time     = p_delivery_record_item.sorting_date,
           a.shipment_time = p_delivery_record_item.shipment_date,
           a.receive_time  = p_delivery_record_item.accept_date
     where a.asn_id = p_asn_id
       and a.barcode = p_delivery_record_item.barcode
       and a.company_id = p_delivery_record_item.company_id;
    if sql%rowcount = 0 then
      insert into scmdata.t_asnordersitem
        (asn_id,
         company_id,
         dc_company_id,
         goo_id,
         barcode,
         order_amount,
         pcome_amount,
         asngot_amount,
         got_amount,
         shipment_time,
         receive_time,
         memo,
         create_id,
         create_time,
         update_id,
         update_time)
      values
        (p_asn_id,
         p_delivery_record_item.company_id,
         p_delivery_record_item.company_id,
         p_delivery_record_item.goo_id,
         p_delivery_record_item.barcode,
         (select nvl(max(osi.order_amount), 0)
            from scmdata.t_delivery_record d
           inner join scmdata.t_ordersitem osi
              on osi.order_id = d.order_code
             and osi.company_id = d.company_id
             and osi.barcode = p_delivery_record_item.barcode
           where p_delivery_record_item.delivery_record_id =
                 d.delivery_record_id),
         p_delivery_record_item.predict_delivery_amount,
         p_delivery_record_item.delivery_amount,
         p_delivery_record_item.delivery_origin_amount,
         p_delivery_record_item.shipment_date,
         p_delivery_record_item.accept_date,
         null,
         'ADMIN',
         sysdate,
         'ADMIN',
         sysdate);
    end if;
  end p_sync_asn_by_delivery_record_item;

  --根据asn编号同步生产进度，如果orders和ordered没到齐放弃同步
  procedure p_sync_delivery_record_by_asnorder(p_asn_id     varchar2,
                                               p_company_id varchar2) is
    p_delivery_record_id   varchar2(32);
    v_delivery_record_code varchar2(32);
    p_delivery_rec         scmdata.t_delivery_record%rowtype;
    p_send_by_sup          number(1);
    p_finish_time          date;
    --p_has_itf              number(1);
  begin
    --如果有接口表不更新
    /* select nvl(max(1), 0)
      into p_has_itf
      from scmdata.t_asnordered_itf a
     where a.asn_id = p_asn_id
       and a.company_id = p_company_id;
    select nvl(max(1), p_has_itf)
      into p_has_itf
      from scmdata.t_asnorders_itf a
     where a.asn_id = p_asn_id
       and a.company_id = p_company_id;
    if p_has_itf = 1 then
      return;
    end if;*/
    for x in (select b.goo_id,
                     a.order_id,
                     a.create_time,
                     a.create_id,
                     a.memo,
                     a.scan_time,
                     b.receive_time,
                     b.pick_time,
                     b.shiment_time,
                     a.asn_id,
                     b.pcome_amount,
                     b.asngot_amount        got_amount,
                     b.got_amount           asngot_amount,
                     a.end_acc_time,
                     b.is_fcl_out,
                     b.is_qc_required,
                     o.send_by_sup,
                     b.sorting_time,
                     a.pcome_date,
                     b.asn_documents_status,
                     b.packcases
                from scmdata.t_asnordered a
               inner join scmdata.t_asnorders b
                  on a.asn_id = b.asn_id
                 and a.company_id = b.company_id
               inner join scmdata.t_ordered o
                  on o.order_code = a.order_id
                 and a.company_id = o.company_id
               where a.company_id = p_company_id
                 and a.asn_id = p_asn_id) loop
      select max(delivery_record_id)
        into p_delivery_record_id
        from scmdata.t_delivery_record a
       where a.asn_id = p_asn_id
         and a.goo_id = x.goo_id
         and a.company_id = p_company_id;
      if p_delivery_record_id is null then
        select max(send_by_sup), max(finish_time)
          into p_send_by_sup, p_finish_time
          from scmdata.t_ordered a
         where a.order_code = x.order_id
           and a.company_id = p_company_id;

        p_delivery_record_id   := scmdata.f_get_uuid();
        v_delivery_record_code := pkg_plat_comm.f_getkeyid_plat(pi_pre     => 'DR',
                                                                pi_seqname => 'SEQ_T_DELIVERY_RECORD',
                                                                pi_seqnum  => 99);
        insert into scmdata.t_delivery_record
          (delivery_record_id,
           company_id,
           delivery_record_code,
           order_code,
           ing_id,
           goo_id,
           delivery_price,
           create_id,
           create_time,
           memo,
           delivery_date,
           accept_date,
           sorting_date,
           shipment_date,
           update_id,
           update_time,
           asn_id,
           predict_delivery_amount,
           delivery_origin_time,
           delivery_origin_amount,
           delivery_amount,
           end_acc_time,
           is_fcl_out,
           is_qc_required,
           predict_delivery_date,
           asn_documents_status,
           packcases)
        values
          (p_delivery_record_id,
           p_company_id,
           v_delivery_record_code,
           x.order_id,
           null,
           x.goo_id,
           0,
           x.create_id,
           x.create_time,
           x.memo,
           decode(p_send_by_sup, 1, x.sorting_time, x.scan_time),
           x.receive_time,
           x.sorting_time,
           x.shiment_time,
           x.create_id,
           x.create_time,
           x.asn_id,
           x.pcome_amount,
           decode(p_send_by_sup, 1, x.sorting_time, x.scan_time),
           x.asngot_amount,
           x.got_amount,
           x.end_acc_time,
           x.is_fcl_out,
           x.is_qc_required,
           x.pcome_date,
           x.asn_documents_status,
           x.packcases);

        --20221103 补充同步至条码生成表
        merge into scmdata.t_delivery_record_barcode a
        using (select x.asn_id asn_id from dual) b
        on (b.asn_id = a.asn_id)
        when not matched then
          insert
            (a.delivery_record_barcode_id,
             a.asn_id,
             a.create_id,
             a.create_time,
             a.generated,
             a.generate_time,
             a.barcode_file_id,
             a.pause)
          values
            (scmdata.f_get_uuid(),
             b.asn_id,
             'ADMIN',
             sysdate,
             0,
             null,
             null,
             0);
      else
        update scmdata.t_delivery_record a
           set a.memo                    = x.memo,
               a.delivery_date = case
                                   when x.send_by_sup = 1 then
                                    nvl(x.sorting_time, a.delivery_date)
                                   else
                                    nvl(x.scan_time, a.delivery_date)
                                 end,
               a.accept_date             = nvl(x.receive_time, a.accept_date),
               a.sorting_date            = nvl(x.sorting_time,
                                               a.sorting_date),
               a.shipment_date           = nvl(x.shiment_time,
                                               a.shipment_date),
               a.update_id               = 'ADMIN',
               a.update_time             = sysdate,
               a.predict_delivery_amount = x.pcome_amount,
               a.delivery_origin_time = case
                                          when x.send_by_sup = 1 then
                                           nvl(x.sorting_time,
                                               a.delivery_origin_time)
                                          else
                                           nvl(x.scan_time,
                                               a.delivery_origin_time)
                                        end,
               a.delivery_origin_amount  = x.asngot_amount,
               a.end_acc_time            = x.end_acc_time,
               a.is_fcl_out              = x.is_fcl_out,
               a.is_qc_required          = x.is_qc_required,
               a.predict_delivery_date   = x.pcome_date,
               a.delivery_amount         = x.got_amount,
               a.order_code              = x.order_id,
               a.asn_documents_status    = x.asn_documents_status,
               a.packcases               = x.packcases
         where a.asn_id = x.asn_id
           and a.company_id = p_company_id
           and a.goo_id = x.goo_id;
      end if;
      select *
        into p_delivery_rec
        from scmdata.t_delivery_record a
       where a.delivery_record_id = p_delivery_record_id;
      pkg_production_progress.sync_delivery_record(p_delivery_rec => p_delivery_rec);
    end loop;
  exception
    when Dup_val_on_index then
      rollback;
      return;
  end p_sync_delivery_record_by_asnorder;

  procedure p_sync_delivery_record_by_asnorder_inf(p_asn_id     varchar2,
                                                   p_company_id varchar2) is
    p_delivery_record_id   varchar2(32);
    v_delivery_record_code varchar2(32);
    p_delivery_rec         scmdata.t_delivery_record%rowtype;
  begin
    for x in (select b.goo_id,
                     a.order_id,
                     a.create_time,
                     a.create_id,
                     a.memo,
                     a.scan_time,
                     b.receive_time,
                     b.pick_time,
                     b.shiment_time,
                     a.asn_id,
                     b.pcome_amount,
                     b.asngot_amount        got_amount,
                     b.got_amount           asngot_amount,
                     a.end_acc_time,
                     b.is_fcl_out,
                     b.is_qc_required,
                     o.send_by_sup,
                     b.sorting_time,
                     a.pcome_date,
                     b.asn_documents_status,
                     b.packcases
                from scmdata.t_asnordered_inf a
               inner join scmdata.t_asnorders_inf b
                  on a.asn_id = b.asn_id
                 and a.company_id = b.company_id
                 and b.receive_type = 'Y'
               inner join scmdata.t_ordered o
                  on o.order_code = a.order_id
                 and a.company_id = o.company_id
               where a.company_id = p_company_id
                 and a.receive_type = 'Y'
                 and a.asn_id = p_asn_id) loop
      select max(delivery_record_id)
        into p_delivery_record_id
        from scmdata.t_delivery_record a
       where a.asn_id = p_asn_id
         and a.goo_id = x.goo_id
         and a.company_id = p_company_id;
      if p_delivery_record_id is null then
        p_delivery_record_id   := scmdata.f_get_uuid();
        v_delivery_record_code := pkg_plat_comm.f_getkeyid_plat(pi_pre     => 'DR',
                                                                pi_seqname => 'SEQ_T_DELIVERY_RECORD',
                                                                pi_seqnum  => 99);
        insert into scmdata.t_delivery_record
          (delivery_record_id,
           company_id,
           delivery_record_code,
           order_code,
           ing_id,
           goo_id,
           delivery_price,
           create_id,
           create_time,
           memo,
           delivery_date,
           accept_date,
           sorting_date,
           shipment_date,
           update_id,
           update_time,
           asn_id,
           predict_delivery_amount,
           delivery_origin_time,
           delivery_origin_amount,
           delivery_amount,
           end_acc_time,
           is_fcl_out,
           is_qc_required,
           predict_delivery_date,
           asn_documents_status,
           packcases)
        values
          (p_delivery_record_id,
           p_company_id,
           v_delivery_record_code,
           x.order_id,
           null,
           x.goo_id,
           0,
           x.create_id,
           x.create_time,
           x.memo,
           x.scan_time,
           x.receive_time,
           x.sorting_time,
           x.shiment_time,
           x.create_id,
           x.create_time,
           x.asn_id,
           x.pcome_amount,
           x.scan_time,
           x.asngot_amount,
           x.got_amount,
           x.end_acc_time,
           x.is_fcl_out,
           x.is_qc_required,
           x.pcome_date,
           x.asn_documents_status,
           x.packcases);
      else
        update scmdata.t_delivery_record a
           set a.memo                    = x.memo,
               a.delivery_date = case
                                   when x.send_by_sup = 1 then
                                    nvl(x.sorting_time, a.delivery_date)
                                   else
                                    nvl(x.scan_time, a.delivery_date)
                                 end,
               a.accept_date             = nvl(x.receive_time, a.accept_date),
               a.sorting_date            = nvl(x.sorting_time,
                                               a.sorting_date),
               a.shipment_date           = nvl(x.shiment_time,
                                               a.shipment_date),
               a.update_id               = 'ADMIN',
               a.update_time             = sysdate,
               a.predict_delivery_amount = x.pcome_amount,
               a.delivery_origin_time = case
                                          when x.send_by_sup = 1 then
                                           nvl(x.sorting_time,
                                               a.delivery_origin_time)
                                          else
                                           nvl(x.scan_time,
                                               a.delivery_origin_time)
                                        end,
               a.delivery_origin_amount  = x.asngot_amount,
               a.end_acc_time            = x.end_acc_time,
               a.is_fcl_out              = x.is_fcl_out,
               a.is_qc_required          = x.is_qc_required,
               a.predict_delivery_date   = x.pcome_date,
               a.delivery_amount         = x.got_amount,
               a.order_code              = x.order_id,
               a.asn_documents_status    = x.asn_documents_status,
               a.packcases               = x.packcases
         where a.asn_id = x.asn_id
           and a.company_id = p_company_id
           and a.goo_id = x.goo_id;
      end if;
      select *
        into p_delivery_rec
        from scmdata.t_delivery_record a
       where a.delivery_record_id = p_delivery_record_id;
      pkg_production_progress.sync_delivery_record(p_delivery_rec => p_delivery_rec);
    end loop;
  exception
    when Dup_val_on_index then
      rollback;
      return;
  end p_sync_delivery_record_by_asnorder_inf;
  --根据asn编号同步生产进度，如果orders和ordered，ordersitem没到齐放弃同步
  procedure p_sync_delivery_record_item_by_asnordersitem(p_asn_id     varchar2,
                                                         p_goo_id     varchar2,
                                                         p_company_id varchar2,
                                                         p_barcode    varchar2,
                                                         po_error_flg out number) is
    p_delivery_record_item_id varchar2(32);
    p_delivery_record_id      varchar2(32);
  begin
    --判断主表是否已经进来
    select max(a.delivery_record_id)
      into p_delivery_record_id
      from scmdata.t_delivery_record a
     where a.asn_id = p_asn_id
       and a.goo_id = p_goo_id
       and a.company_id = p_company_id;
    if p_delivery_record_id is null then
      po_error_flg := 1;
    else
      for x in (select c.asn_id,
                       c.company_id,
                       c.dc_company_id,
                       c.goo_id,
                       c.barcode,
                       c.order_amount,
                       c.pcome_amount,
                       c.asngot_amount got_amount,
                       c.got_amount    asngot_amount,
                       c.pick_time,
                       c.shipment_time,
                       c.receive_time,
                       c.warehouse_pos,
                       c.memo,
                       c.create_id,
                       c.create_time,
                       c.update_id,
                       c.update_time,
                       c.packcases
                  from scmdata.t_asnordersitem c
                 where c.company_id = p_company_id
                   and c.goo_id = p_goo_id
                   and c.barcode = p_barcode
                   and c.asn_id = p_asn_id) loop
        select max(delivery_record_item_id)
          into p_delivery_record_item_id
          from scmdata.t_delivery_record_item a
         where a.company_id = p_company_id
           and a.goo_id = p_goo_id
           and a.delivery_record_id = p_delivery_record_id
           and a.barcode = p_barcode;
        if p_delivery_record_item_id is null then
          p_delivery_record_item_id := f_get_uuid();
          insert into scmdata.t_delivery_record_item
            (delivery_record_item_id,
             company_id,
             goo_id,
             delivery_record_id,
             barcode,
             delivery_amount,
             create_time,
             create_id,
             predict_delivery_amount,
             delivery_origin_amount,
             packcases)
          values
            (p_delivery_record_item_id,
             p_company_id,
             p_goo_id,
             p_delivery_record_id,
             p_barcode,
             x.got_amount,
             sysdate,
             'ADMIN',
             x.pcome_amount,
             x.asngot_amount,
             x.packcases);
        else
          update scmdata.t_delivery_record_item a
             set a.delivery_amount         = x.got_amount,
                 a.predict_delivery_amount = x.pcome_amount,
                 a.delivery_origin_amount  = x.asngot_amount,
                 a.packcases               = x.packcases
           where a.company_id = p_company_id
             and a.goo_id = p_goo_id
             and a.delivery_record_id = p_delivery_record_id
             and a.barcode = p_barcode;
        end if;

        update scmdata.t_ordersitem a
           set a.got_amount = nvl((select sum(ki.delivery_amount)
                                    from scmdata.t_delivery_record k
                                   inner join scmdata.t_delivery_record_item ki
                                      on k.delivery_record_id =
                                         ki.delivery_record_id
                                   where k.order_code =
                                         (select order_code
                                            from scmdata.t_delivery_record
                                           where delivery_record_id =
                                                 p_delivery_record_id)
                                     and k.company_id = p_company_id
                                     and k.goo_id = p_goo_id
                                     and ki.barcode = p_barcode),
                                  0)
         where a.company_id = p_company_id
           and a.goo_id = p_goo_id
           and a.order_id =
               (select order_code
                  from scmdata.t_delivery_record
                 where delivery_record_id = p_delivery_record_id)
           and a.barcode = p_barcode;
      end loop;

      po_error_flg := 0;
    end if;
  end p_sync_delivery_record_item_by_asnordersitem;

  procedure p_asn_inf_history_dual(p_dual_time date default sysdate) is
  begin
    --处理asnordered的接口
    --for循环，直接关联ordered
    merge into scmdata.t_asnordered ak
    using (select a.asn_id,
                  a.company_id,
                  a.dc_company_id,
                  (select nvl2(max(1), 'NC', 'CD')
                     FROM SCMDATA.t_Qa_Config B
                    where ci.COMPANY_ID = B.COMPANY_ID
                      AND ci.CATEGORY = B.classification
                      and ci.PRODUCT_CATE = B.product_cate
                      AND INSTR(B.subcategory || ';', ci.SAMLL_CATEGORY) > 0
                      AND B.PAUSE = 0) status,
                  a.order_id,
                  o.supplier_code,
                  a.pcome_date,
                  a.changetimes,
                  a.scan_time,
                  a.memo,
                  a.create_id,
                  a.create_time,
                  a.update_id,
                  a.update_time,
                  a.pcome_interval,
                  a.receive_time,
                  a.receive_type,
                  a.receive_msg,
                  a.operation_flag,
                  a.operation_type
             from scmdata.t_asnordered_inf a
            inner join scmdata.t_ordered o
               on o.order_code = a.order_id
              and o.company_id = a.company_id
            inner join scmdata.t_orders oe
               on oe.order_id = a.order_id
              and a.company_id = oe.company_id
            inner join scmdata.t_commodity_info ci
               on ci.goo_id = oe.goo_id
              and ci.company_id = oe.company_id
            where a.operation_flag = 0) bk
    on (ak.asn_id = bk.asn_id and ak.company_id = bk.company_id)
    when matched then
      update
         set ak.pcome_date     = bk.pcome_date,
             ak.pcome_interval = bk.pcome_interval,
             ak.scan_time      = bk.scan_time,
             ak.memo           = bk.memo
    when not matched then
      insert
        (ak.asn_id,
         ak.company_id,
         ak.dc_company_id,
         ak.status,
         ak.order_id,
         ak.supplier_code,
         ak.pcome_date,
         ak.changetimes,
         ak.scan_time,
         ak.memo,
         ak.create_id,
         ak.create_time,
         ak.update_id,
         ak.update_time,
         ak.pcome_interval)
      values
        (bk.asn_id,
         bk.company_id,
         bk.dc_company_id,
         bk.status,
         bk.order_id,
         bk.supplier_code,
         bk.pcome_date,
         bk.changetimes,
         bk.scan_time,
         bk.memo,
         'ADMIN',
         sysdate,
         'ADMIN',
         sysdate,
         bk.pcome_interval);
    update scmdata.t_asnordered_inf a
       set a.operation_flag = 1
     where exists (select 1
              from scmdata.t_ordered o
             where o.order_code = a.order_id
               and a.company_id = o.company_id)
       and a.operation_flag = 0;
    --处理asnorders的接口
    --for循环，直接关联commodity
    merge into scmdata.t_asnorders ak
    using (select a.asn_id,
                  a.company_id,
                  a.dc_company_id,
                  c.goo_id,
                  a.order_amount,
                  a.pcome_amount,
                  a.asngot_amount,
                  a.got_amount,
                  a.memo,
                  a.create_id,
                  a.create_time,
                  a.update_id,
                  a.update_time,
                  a.pick_time,
                  a.shiment_time,
                  a.receive_time,
                  a.warehouse_pos,
                  a.receive_if_time,
                  a.receive_type,
                  a.receive_msg,
                  a.operation_flag,
                  a.operation_type
             from scmdata.t_asnorders_inf a
            inner join scmdata.t_commodity_info c
               on a.goo_id = c.rela_goo_id
              and a.company_id = c.company_id
            where a.operation_flag = 0) bk
    on (ak.asn_id = bk.asn_id and ak.company_id = bk.company_id and ak.goo_id = bk.goo_id)
    when matched then
      update
         set ak.order_amount  = bk.order_amount,
             ak.asngot_amount = bk.asngot_amount,
             ak.got_amount    = bk.got_amount,
             ak.memo          = bk.memo,
             ak.update_id     = 'ADMIN',
             ak.update_time   = sysdate
    when not matched then
      insert
        (ak.asn_id,
         ak.company_id,
         ak.dc_company_id,
         ak.goo_id,
         ak.order_amount,
         ak.pcome_amount,
         ak.asngot_amount,
         ak.got_amount,
         ak.memo,
         ak.create_id,
         ak.create_time,
         ak.update_id,
         ak.update_time)
      values
        (bk.asn_id,
         bk.company_id,
         bk.dc_company_id,
         bk.goo_id,
         bk.order_amount,
         bk.pcome_amount,
         bk.asngot_amount,
         bk.got_amount,
         bk.memo,
         'ADMIN',
         sysdate,
         'ADMIN',
         sysdate);

    update scmdata.t_asnorders_inf a
       set a.operation_flag = 1
     where exists (select 1
              from scmdata.t_commodity_info c
             where a.goo_id = c.rela_goo_id
               and a.company_id = c.company_id)
       and a.operation_flag = 0;
    --处理asnordersitem的接口
    --for循环，直接关联commodity
    merge into scmdata.t_asnordersitem ak
    using (select a.asn_id,
                  a.company_id,
                  a.dc_company_id,
                  c.goo_id,
                  a.barcode,
                  a.order_amount,
                  a.pcome_amount,
                  a.asngot_amount,
                  a.got_amount,
                  a.pick_time,
                  a.shipment_time,
                  a.receive_time,
                  a.warehouse_pos,
                  a.memo,
                  a.create_id,
                  a.create_time,
                  a.update_id,
                  a.update_time,
                  a.receive_if_time,
                  a.receive_type,
                  a.receive_msg,
                  a.operation_flag,
                  a.operation_type
             from scmdata.t_asnordersitem_inf a
            inner join scmdata.t_commodity_info c
               on a.goo_id = c.rela_goo_id
              and a.company_id = c.company_id
            where a.operation_flag = 0) bk
    on (ak.asn_id = bk.asn_id and ak.company_id = bk.company_id and ak.goo_id = bk.goo_id and ak.barcode = bk.barcode)
    when matched then
      update
         set ak.order_amount  = bk.order_amount,
             ak.pcome_amount  = bk.pcome_amount,
             ak.asngot_amount = bk.asngot_amount,
             ak.got_amount    = bk.got_amount,
             ak.memo          = bk.memo
    when not matched then
      insert
        (ak.asn_id,
         ak.company_id,
         ak.dc_company_id,
         ak.goo_id,
         ak.barcode,
         ak.order_amount,
         ak.pcome_amount,
         ak.asngot_amount,
         ak.got_amount,
         ak.memo,
         ak.create_id,
         ak.create_time,
         ak.update_id,
         ak.update_time)
      values
        (bk.asn_id,
         bk.company_id,
         bk.dc_company_id,
         bk.goo_id,
         bk.barcode,
         bk.order_amount,
         bk.pcome_amount,
         bk.asngot_amount,
         bk.got_amount,
         bk.memo,
         'ADMIN',
         sysdate,
         'ADMIN',
         sysdate);
    update scmdata.t_asnordersitem_inf a
       set a.operation_flag = 1
     where exists (select 1
              from scmdata.t_commodity_info c
             where a.goo_id = c.rela_goo_id
               and a.company_id = c.company_id)
       and a.operation_flag = 0;
    --处理asnorderpacks的接口
    --for循环，直接关联commodity
    merge into scmdata.t_asnorderpacks ak
    using (select a.asn_id,
                  a.company_id,
                  a.dc_company_id,
                  a.operator_id,
                  c.goo_id,
                  a.barcode,
                  a.pack_no,
                  a.pack_barcode,
                  a.packno,
                  a.packcount,
                  a.packamount,
                  a.skupack_no,
                  a.skupack_count,
                  a.sku_number,
                  a.ratioid,
                  a.pack_specs_send,
                  a.memo,
                  a.create_id,
                  a.create_time,
                  a.update_id,
                  a.update_time,
                  a.goodsid,
                  a.receive_time,
                  a.receive_type,
                  a.receive_msg,
                  a.operation_flag,
                  a.operation_type
             from scmdata.t_asnorderpacks_inf a
            inner join scmdata.t_commodity_info c
               on a.goo_id = c.rela_goo_id
              and a.company_id = c.company_id
            where a.operation_flag = 0) bk
    on (ak.asn_id = bk.asn_id and ak.company_id = bk.company_id and ak.pack_barcode = bk.pack_barcode and ak.goodsid = bk.goodsid)
    when matched then
      update
         set ak.operator_id     = bk.operator_id,
             ak.pack_no         = bk.pack_no,
             ak.packno          = bk.packno,
             ak.packcount       = bk.packcount,
             ak.packamount      = bk.packamount,
             ak.skupack_no      = bk.skupack_no,
             ak.skupack_count   = bk.skupack_count,
             ak.sku_number      = bk.sku_number,
             ak.ratioid         = bk.ratioid,
             ak.pack_specs_send = bk.pack_specs_send,
             ak.memo            = bk.memo,
             ak.update_id       = 'ADMIN',
             ak.update_time     = sysdate
    when not matched then
      insert
        (ak.asn_id,
         ak.company_id,
         ak.dc_company_id,
         ak.operator_id,
         ak.goo_id,
         ak.barcode,
         ak.pack_no,
         ak.pack_barcode,
         ak.packno,
         ak.packcount,
         ak.packamount,
         ak.skupack_no,
         ak.skupack_count,
         ak.sku_number,
         ak.ratioid,
         ak.pack_specs_send,
         ak.memo,
         ak.create_id,
         ak.create_time,
         ak.update_id,
         ak.update_time,
         ak.goodsid)
      values
        (bk.asn_id,
         bk.company_id,
         bk.dc_company_id,
         bk.operator_id,
         bk.goo_id,
         bk.barcode,
         bk.pack_no,
         bk.pack_barcode,
         bk.packno,
         bk.packcount,
         bk.packamount,
         bk.skupack_no,
         bk.skupack_count,
         bk.sku_number,
         bk.ratioid,
         bk.pack_specs_send,
         bk.memo,
         'ADMIN',
         sysdate,
         'ADMIN',
         sysdate,
         bk.goodsid);
    update scmdata.t_asnorderpacks_inf a
       set a.operation_flag = 1
     where exists (select 1
              from scmdata.t_commodity_info c
             where a.goo_id = c.rela_goo_id
               and a.company_id = c.company_id)
       and a.operation_flag = 0;
  end;

  procedure p_create_asn_by_delivery(p_dual_time date default sysdate) is
    temp_row rowid;
  begin
    for x in (select * from scmdata.t_delivery_record) loop
      --主表
      select max(rowid)
        into temp_row
        from scmdata.t_asnordered a
       where a.asn_id = x.asn_id
         and a.company_id = x.company_id;
      if temp_row is null then
        insert into scmdata.t_asnordered
          (asn_id,
           company_id,
           dc_company_id,
           status,
           order_id,
           supplier_code,
           pcome_date,
           changetimes,
           scan_time,
           memo,
           create_id,
           create_time,
           update_id,
           update_time,
           pcome_interval)
        values
          (x.asn_id,
           x.company_id,
           x.company_id,
           'CD',
           x.order_code,
           (select supplier_code
              from scmdata.t_ordered o
             where o.order_code = x.order_code
               and o.company_id = x.company_id),
           null,
           null,
           x.delivery_origin_time,
           x.memo,
           x.create_id,
           x.create_time,
           x.update_id,
           x.update_time,
           null);
      else
        update scmdata.t_asnordered a
           set a.scan_time = x.delivery_origin_time
         where a.rowid = temp_row;
      end if;
      select max(rowid)
        into temp_row
        from scmdata.t_asnorders a
       where a.asn_id = x.asn_id
         and a.company_id = x.company_id
         and a.goo_id = x.goo_id;
      if temp_row is null then
        insert into scmdata.t_asnorders
          (asn_id,
           company_id,
           dc_company_id,
           goo_id,
           order_amount,
           pcome_amount,
           asngot_amount,
           got_amount,
           memo,
           create_id,
           create_time,
           update_id,
           update_time,
           pick_time,
           shiment_time,
           receive_time,
           warehouse_pos)
        values
          (x.asn_id,
           x.company_id,
           x.company_id,
           x.goo_id,
           (select nvl(max(order_amount), 0)
              from scmdata.t_orders o
             where o.order_id = x.order_code
               and o.company_id = x.company_id),
           nvl(x.predict_delivery_amount, 0),
           nvl(x.delivery_origin_amount, 0),
           nvl(x.delivery_amount, 0),
           x.memo,
           x.create_id,
           x.create_time,
           x.update_id,
           x.update_time,
           x.sorting_date,
           x.shipment_date,
           x.accept_date,
           null);
      else
        update scmdata.t_asnorders a
           set a.pcome_amount  = nvl(x.predict_delivery_amount, 0),
               a.asngot_amount = nvl(x.delivery_origin_amount, 0),
               a.got_amount    = nvl(x.delivery_amount, 0),
               a.pick_time     = x.sorting_date,
               a.shiment_time  = x.shipment_date,
               a.order_amount =
               (select nvl(max(order_amount), 0)
                  from scmdata.t_orders o
                 where o.order_id = x.order_code
                   and o.company_id = x.company_id),
               a.receive_time  = x.accept_date
         where a.rowid = temp_row;
      end if;
      for k in (select *
                  from scmdata.t_delivery_record_item c
                 where c.delivery_record_id = x.delivery_record_id) loop
        select max(rowid)
          into temp_row
          from scmdata.t_asnordersitem a
         where a.asn_id = x.asn_id
           and a.company_id = x.company_id
           and a.barcode = k.barcode;
        if temp_row is null then
          insert into scmdata.t_asnordersitem
            (asn_id,
             company_id,
             dc_company_id,
             goo_id,
             barcode,
             order_amount,
             pcome_amount,
             asngot_amount,
             got_amount,
             pick_time,
             shipment_time,
             receive_time,
             warehouse_pos,
             memo,
             create_id,
             create_time,
             update_id,
             update_time)
          values
            (x.asn_id,
             x.company_id,
             x.company_id,
             x.goo_id,
             k.barcode,
             (select nvl(max(order_amount), 0)
                from scmdata.t_ordersitem o
               where o.order_id = x.order_code
                 and o.goo_id = x.goo_id
                 and o.company_id = x.company_id
                 and o.barcode = k.barcode),
             nvl(k.predict_delivery_amount, 0),
             nvl(k.delivery_origin_amount, 0),
             nvl(k.delivery_amount, 0),
             k.sorting_date,
             k.shipment_date,
             x.accept_date,
             null,
             null,
             k.create_id,
             x.create_time,
             'ADMIN',
             sysdate);
        else
          update scmdata.t_asnordersitem a
             set a.pcome_amount  = nvl(k.predict_delivery_amount, 0),
                 a.asngot_amount = nvl(k.delivery_origin_amount, 0),
                 a.got_amount    = nvl(k.delivery_amount, 0),
                 a.shipment_time = k.shipment_date,
                 a.receive_time  = k.accept_date,
                 a.pick_time     = k.sorting_date,
                 a.order_amount =
                 (select nvl(max(order_amount), 0)
                    from scmdata.t_ordersitem o
                   where o.order_id = x.order_code
                     and o.goo_id = x.goo_id
                     and o.company_id = x.company_id
                     and o.barcode = k.barcode)
           where a.asn_id = x.asn_id
             and a.company_id = x.company_id
             and a.goo_id = x.goo_id
             and a.barcode = k.barcode;

        end if;
      end loop;
    end loop;
  end p_create_asn_by_delivery;

  procedure p_exclude_useless_asn(p_asn_list varchar2, p_ord_id varchar2) is
    p_company_id varchar2(32);
  begin
    select max(company_id)
      into p_company_id
      from scmdata.t_interface a
     where a.interface_id = 'ASN_MAIN';
    for x in (select *
                from scmdata.t_delivery_record a
               where a.order_code = p_ord_id
                 and a.company_id = p_company_id
                 and a.delivery_origin_time is null
                 and a.accept_date is null
                 and a.delivery_amount = 0
                 and a.end_acc_time is null
                 and not
                      instr(';' || p_asn_list || ';', ';' || a.asn_id || ';') > 0) loop

      delete from scmdata.t_asnordered a
       where a.company_id = p_company_id
         and a.asn_id = x.asn_id;
      delete from scmdata.t_asnorders a
       where a.company_id = p_company_id
         and a.asn_id = x.asn_id;
      delete from scmdata.t_asnordersitem a
       where a.company_id = p_company_id
         and a.asn_id = x.asn_id;

      delete from scmdata.t_asnordered_inf a
       where a.company_id = p_company_id
         and a.asn_id = x.asn_id;
      delete from scmdata.t_asnorders_inf a
       where a.company_id = p_company_id
         and a.asn_id = x.asn_id;
      delete from scmdata.t_asnordersitem_inf a
       where a.company_id = p_company_id
         and a.asn_id = x.asn_id;

      delete from scmdata.t_delivery_record_item a
       where a.delivery_record_id = x.delivery_record_id;
      delete from scmdata.t_delivery_record a
       where a.delivery_record_id = x.delivery_record_id;

      delete from scmdata.t_sendordered a
       where a.asn_id = x.asn_id
         and a.order_code = x.order_code
         and a.company_id = p_company_id;

      delete from scmdata.t_sendorders a
       where a.asn_id = x.asn_id
         and a.order_code = x.order_code
         and a.company_id = p_company_id;
    end loop;
  end p_exclude_useless_asn;

 --2023-6-2 by hx 需要删除的asn数据处理，走定时调度，每3分钟执行一次
procedure p_cmx_asnordered_delet(pi_company_id varchar2) is
  v_i int;
  v_process_time date;
  v_err_msg varchar2(300);
begin
  --根据批次号，先进先处理原则处理
   for item in(select  distinct a.batch_id from cmx_asnordered_if_scm a 
               where a.batch_status='R'
                 and a.process_time is null
                 order by a.batch_id asc
               )
               
   loop
      v_process_time :=sysdate;
      for asn in(
                 select a.asn_id,a.ord_id
                   from cmx_asnordered_if_scm a
                  where a.batch_id=batch_id and a.batch_status='R'
                 )
      loop
        BEGIN
         --1.删除ASN数据
         p_delete_by_asn(asn.asn_id, pi_company_id);
         
         --删除送货单数据
         select max(1) into v_i
           from scmdata.t_sendordered a 
          where a.asn_id=asn.asn_id and a.order_code=asn.ord_id and a.company_id=pi_company_id;
         
         if v_i =1 then
         
          delete from scmdata.t_sendordered a 
           where a.asn_id=asn.asn_id and a.order_code=asn.ord_id and a.company_id=pi_company_id;
          
          delete from scmdata.t_sendordered_attachment t
           where exists(
                        select 1 
                          from scmdata.t_sendordered a
                         where a.asn_id=asn.asn_id and a.order_code=asn.ord_id
                           and a.company_id=pi_company_id
                           and t.send_id=a.send_id and t.company_id=a.company_id
                 );
                 
          delete from scmdata.t_sendordered a 
           where a.asn_id=asn.asn_id and a.order_code=asn.ord_id and a.company_id=pi_company_id;
         end if;
       
      --2.打上标志位
      update  cmx_asnordered_if_scm a
         set a.process_time=v_process_time,a.batch_status='S'
       where a.batch_id=item.batch_id and a.asn_id=asn.asn_id;
      
       
       EXCEPTION WHEN OTHERS THEN
         v_err_msg:=Rtrim(Substrb(Sqlerrm || ':' ||To_Char(Sqlcode), 1, 255));
         update  cmx_asnordered_if_scm a
         set a.process_time=v_process_time,
             a.batch_status='F',
             A.ERROR_MSG=v_err_msg
       where a.batch_id=item.batch_id and a.asn_id=asn.asn_id;
       
       END;
       
      end loop;
      --放到一个批次循环完提交
       commit;
   end loop;

end;
end pkg_inf_asn;
/

