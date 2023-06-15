create or replace package scmdata.pkg_delivery_send is

  -- Author  : SANFU
  -- Created : 2022/11/2 15:40:00
  -- Purpose : 送货单处理

  procedure p_dual_delivery_send_inf(p_delivery_send_inf scmdata.t_delivery_send_inf%rowtype);

end pkg_delivery_send;
/

create or replace package body scmdata.pkg_delivery_send is

  procedure p_dual_delivery_send_inf(p_delivery_send_inf scmdata.t_delivery_send_inf%rowtype) is
  
    p_delivery_record      scmdata.t_delivery_record%rowtype;
    p_delivery_record_item scmdata.t_delivery_record_item%rowtype;
    p_i                    number(1);
    p_sho_id               varchar2(32);
    p_supplier_code        varchar2(32);
    v_send_id              varchar2(32);
  begin
    --新增数据
    insert into scmdata.t_delivery_send_inf
      (delivery_send_inf_id,
       company_id,
       ord_ids,
       oper_user_id,
       asn_body,
       asnitem_body,
       create_time,
       dealt,
       asn_ids)
    values
      (p_delivery_send_inf.delivery_send_inf_id,
       p_delivery_send_inf.company_id,
       p_delivery_send_inf.ord_ids,
       p_delivery_send_inf.oper_user_id,
       p_delivery_send_inf.asn_body,
       p_delivery_send_inf.asnitem_body,
       p_delivery_send_inf.create_time,
       0,
       p_delivery_send_inf.asn_ids);
    --处理首表
    for x in (select c.*
                from scmdata.t_delivery_send_inf a,
                     json_table(a.asn_body,
                                '$[*]'
                                COLUMNS(ORDER_CODE varchar2(32) path
                                        '$[*].ORDERID',
                                        ASN_ID varchar2(32) path '$[*].ASN_ID',
                                        GOO_ID varchar2(32) path '$[*].GOO_ID',
                                        IS_FCL_OUT number(1) path
                                        '$[*].IS_FCL_OUT',
                                        IS_QC_REQUIRED number(1) path
                                        '$[*].IS_QC_REQUIRED',
                                        PREDICT_DELIVERY_AMOUNT number(18, 4) path
                                        '$[*].PCOMEAMOUNT',
                                        PREDICT_DELIVERY_DATE date path
                                        '$[*].PCOMEDATE',
                                        CREATE_TIME date path
                                        '$[*].FINIISHTIME',
                                        ASN_LIST varchar2(32) path
                                        '$[*].ASN_LIST',
                                        PACKCASES number(1) path
                                        '$[*].PACKCASES')) c
               where a.delivery_send_inf_id =
                     p_delivery_send_inf.delivery_send_inf_id) loop
      --根据asnList删除
      scmdata.pkg_inf_asn.p_exclude_useless_asn(p_asn_list => x.asn_list,
                                                p_ord_id   => x.ORDER_CODE);
      p_delivery_record.order_code              := x.order_code;
      p_delivery_record.asn_id                  := x.asn_id;
      p_delivery_record.goo_id                  := x.goo_id;
      p_delivery_record.is_fcl_out              := x.is_fcl_out;
      p_delivery_record.is_qc_required          := x.is_qc_required;
      p_delivery_record.predict_delivery_amount := x.predict_delivery_amount;
      p_delivery_record.predict_delivery_date   := x.predict_delivery_date;
      p_delivery_record.create_time             := x.create_time;
      p_delivery_record.packcases               := x.packcases;
      --处理delivery_record
      scmdata.pkg_inf_asn.p_dual_delivery_record_if(p_delivery_record => p_delivery_record);
    end loop;
    --处理色码表
  
    for x in (select c.*
                from scmdata.t_delivery_send_inf a,
                     json_table(a.asnitem_body,
                                '$[*]'
                                COLUMNS(ORD_ID varchar2(32) path
                                        '$[*].ORD_ID',
                                        
                                        asn_id varchar2(32) path '$[*].ASN_ID',
                                        GOO_ID varchar2(32) path '$[*].GOO_ID',
                                        BARCODE varchar2(32) path
                                        '$[*].BARCODE',
                                        PREDICT_DELIVERY_AMOUNT number(18, 4) path
                                        '$[*].PCOMEAMOUNT',
                                        PACKCASES number(1) path
                                        '$[*].PACKCASES')) c
               where a.delivery_send_inf_id =
                     p_delivery_send_inf.delivery_send_inf_id) loop
      p_delivery_record_item.Delivery_Record_Id      := x.asn_id;
      p_delivery_record_item.GOO_ID                  := x.GOO_ID;
      p_delivery_record_item.BARCODE                 := x.BARCODE;
      p_delivery_record_item.PREDICT_DELIVERY_AMOUNT := x.PREDICT_DELIVERY_AMOUNT;
      p_delivery_record_item.PACKCASES               := x.PACKCASES;
      scmdata.pkg_inf_asn.p_dual_delivery_record_item_if(p_delivery_record_item => p_delivery_record_item);
    end loop;
  
    select max(oe.sho_id), max(oe.supplier_code)
      into p_sho_id, p_supplier_code
      from scmdata.t_ordered oe
     where oe.order_code = p_delivery_send_inf.ord_ids
       and oe.company_id = p_delivery_send_inf.company_id;
  
    select max(1)
      into p_i
      from scmdata.t_sendordered a
     where a.asn_id = p_delivery_send_inf.asn_ids
       and a.order_code = p_delivery_send_inf.ord_ids
       and a.company_id = p_delivery_send_inf.company_id
       and a.supplier_code = p_supplier_code;
  
    if p_i = 0  then-- 0 说明存在送货单，直接不产生
      return;
    elsif p_i=1 then----1 更新成 0
      update scmdata.t_sendordered a
         set a.closed=0,a.finished=0
      where a.asn_id = p_delivery_send_inf.asn_ids
       and a.order_code = p_delivery_send_inf.ord_ids
       and a.company_id = p_delivery_send_inf.company_id
       and a.supplier_code = p_supplier_code;
    end if;
  
    v_send_id := scmdata.pkg_plat_comm.f_getkeycode(pi_table_name  => 'T_SENDORDERED',
                                                    pi_column_name => 'SEND_ID',
                                                    pi_company_id  => p_delivery_send_inf.company_id,
                                                    pi_pre         => p_sho_id || 'S' ||
                                                                      To_Char(Sysdate,
                                                                              'YYMMDD'),
                                                    pi_serail_num  => 6);
  
    --生成送货单
    insert into scmdata.t_sendordered
      (sendordered_id,
       company_id,
       supplier_code,
       asn_id,
       send_id,
       create_time,
       create_id,
       update_id,
       update_time,
       finish_time,
       finish_id,
       order_code,
       finished)
    values
      (scmdata.f_get_uuid(),
       p_delivery_send_inf.company_id,
       p_supplier_code,
       p_delivery_send_inf.asn_ids,
       v_send_id,
       sysdate,
       p_delivery_send_inf.oper_user_id,
       null,
       null,
       null,
       null,
       p_delivery_send_inf.ord_ids,
       0);
  
    insert into scmdata.t_sendorders
      (sendorders_id,
       company_id,
       order_code,
       send_id,
       asn_id,
       goo_id,
       rela_goo_id,
       goodids,
       pcome_amount,
       send_amount,
       memo,
       barcodeinprice,
       is_print,
       inprice)
      select scmdata.f_get_uuid_pe(),
             a.company_id,
             a.order_code,
             v_send_id,
             ef.asn_id,
             b.goo_id,
             ci.rela_goo_id,
             nvl(g.barcode, ci.rela_goo_id) goodids,
             sum(nvl(g.predict_delivery_amount, ef.predict_delivery_amount)),
             '',
             '',
             0 barcodeinprice,
             0,
             (Case
               When ci.category In ('07') Then
                b.order_price
               Else
                null
             End) As Inprice
        from scmdata.t_ordered a
       inner join scmdata.t_orders b
          on a.order_code = b.order_id
         and a.company_id = b.company_id
        left join scmdata.t_ordersitem i
          on i.order_id = b.order_id
         and b.goo_id = i.goo_id
       inner join scmdata.t_commodity_info ci
          on ci.company_id = b.company_id
         and ci.goo_id = b.goo_id
       inner join scmdata.t_delivery_record ef
          on ef.order_code = a.order_code
         and ef.company_id = a.company_id
        left join scmdata.t_delivery_record_item g
          on ef.delivery_record_id = g.delivery_record_id
         and ef.company_id = ef.company_id
         and g.goo_id = ef.goo_id
       where a.order_code = p_delivery_send_inf.ord_ids
         and a.company_id = p_delivery_send_inf.company_id
         and ef.asn_id = p_delivery_send_inf.asn_ids
         and not exists
       (select 1
                from scmdata.t_sendorders j
               where j.order_code = a.order_code
                 and j.company_id = a.company_id
                 and j.asn_id = ef.asn_id
                 and j.goo_id = b.goo_id
                 and nvl(g.barcode, ci.rela_goo_id) = j.goodids)
       Group By a.order_code,
             a.company_id,
                ef.Asn_Id,
                b.Goo_Id,
                ci.rela_goo_id,
                Nvl(g.Barcode, ci.rela_goo_id),
                (Case
                  When ci.category In ('07') Then
                   b.order_price
                  Else
                   null
                End);
  
    delete from scmdata.t_delivery_send_inf a
     where a.delivery_send_inf_id =
           p_delivery_send_inf.delivery_send_inf_id;
  
  end p_dual_delivery_send_inf;

end pkg_delivery_send;
/

