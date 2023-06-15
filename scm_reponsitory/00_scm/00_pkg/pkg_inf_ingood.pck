create or replace package scmdata.pkg_inf_ingood is

  -- Author  : SANFU
  -- Created : 2021/12/3 16:34:31
  -- Purpose : 进货明细接口获取

  procedure dual_ingood_inf(p_ingood scmdata.t_ingood%rowtype);

  procedure dual_ingoods_inf(p_ingoods scmdata.t_ingoods%rowtype);

  procedure dual_ingoodsitem_inf(p_ingoodsitem scmdata.t_ingoodsitem%rowtype);

end pkg_inf_ingood;
/

create or replace package body scmdata.pkg_inf_ingood is

  procedure dual_ingood_inf(p_ingood scmdata.t_ingood%rowtype) is
    p_supplier_code varchar2(32);
    p_company_id    varchar2(32);
  begin
    select max(company_id)
      into p_company_id
      from scmdata.t_interface a
     where a.interface_id = 'ASN_MAIN';
    select max(a.supplier_code)
      into p_supplier_code
      from scmdata.t_supplier_info a
     where a.inside_supplier_code = p_ingood.supplier_code
       and a.company_id = p_company_id;
  
    if p_supplier_code is null then
      merge into scm_interface.cmx_ingood_inf a
      using (select p_ingood.ing_id        ing_id,
                    p_company_id           company_id,
                    p_ingood.sho_id        sho_id,
                    p_ingood.supplier_code supplier_code,
                    p_ingood.operator_id   operator_id,
                    p_ingood.create_time   create_time,
                    p_ingood.finish_time   finish_time,
                    p_ingood.assessor_id   assessor_id,
                    p_ingood.operator      operator,
                    p_ingood.checkout_time checkout_time,
                    p_ingood.is_ready      is_ready,
                    p_ingood.accept_id     accept_id,
                    p_ingood.int_id        int_id,
                    p_ingood.consignee_id  consignee_id,
                    p_ingood.audittime     audittime,
                    p_ingood.auditor_id    auditor_id,
                    p_ingood.status        status,
                    p_ingood.dprepaymoney  dprepaymoney,
                    p_ingood.duemoney      duemoney,
                    p_ingood.is_payout     is_payout,
                    p_ingood.update_time   update_time,
                    p_ingood.ingood_type   ingood_type,
                    p_ingood.memo          memo,
                    p_ingood.DOCUMENT_NO   DOCUMENT_NO
               from dual) b
      on (a.ing_id = b.ing_id and a.company_id = b.company_id)
      when not matched then
        insert
          (a.ing_id,
           a.company_id,
           a.sho_id,
           a.supplier_code,
           a.operator_id,
           a.create_time,
           a.finish_time,
           a.assessor_id,
           a.operator,
           a.checkout_time,
           a.is_ready,
           a.accept_id,
           a.int_id,
           a.consignee_id,
           a.audittime,
           a.auditor_id,
           a.status,
           a.dprepaymoney,
           a.duemoney,
           a.is_payout,
           a.update_time,
           a.ingood_type,
           a.memo,
           a.DOCUMENT_NO,
           a.recieve_time,
           a.operation_falg,
           a.recieve_type,
           a.operation_type)
        values
          (b.ing_id,
           b.company_id,
           b.sho_id,
           b.supplier_code,
           b.operator_id,
           b.create_time,
           b.finish_time,
           b.assessor_id,
           b.operator,
           b.checkout_time,
           b.is_ready,
           b.accept_id,
           b.int_id,
           b.consignee_id,
           b.audittime,
           b.auditor_id,
           b.status,
           b.dprepaymoney,
           b.duemoney,
           b.is_payout,
           b.update_time,
           b.ingood_type,
           b.memo,
           b.DOCUMENT_NO,
           sysdate,
           0,
           'R_SUP',
           'IU')
      when matched then
        update
           set a.sho_id         = b.sho_id,
               a.supplier_code  = b.supplier_code,
               a.operator_id    = b.operator_id,
               a.create_time    = b.create_time,
               a.finish_time    = b.finish_time,
               a.assessor_id    = b.assessor_id,
               a.operator       = b.operator,
               a.checkout_time  = b.checkout_time,
               a.is_ready       = b.is_ready,
               a.accept_id      = b.accept_id,
               a.int_id         = b.int_id,
               a.consignee_id   = b.consignee_id,
               a.audittime      = b.audittime,
               a.auditor_id     = b.auditor_id,
               a.status         = b.status,
               a.dprepaymoney   = b.dprepaymoney,
               a.duemoney       = b.duemoney,
               a.is_payout      = b.is_payout,
               a.update_time    = b.update_time,
               a.ingood_type    = b.ingood_type,
               a.memo           = b.memo,
               a.DOCUMENT_NO    = b.DOCUMENT_NO,
               a.recieve_time   = sysdate,
               a.operation_falg = 0,
               a.recieve_type   = 'R_SUP',
               a.operation_type = 'IU';
      return;
    end if;
    merge into scmdata.t_ingood a
    using (select p_ingood.ing_id        ing_id,
                  p_company_id           company_id,
                  p_ingood.sho_id        sho_id,
                  p_supplier_code        supplier_code,
                  p_ingood.operator_id   operator_id,
                  p_ingood.create_time   create_time,
                  p_ingood.finish_time   finish_time,
                  p_ingood.assessor_id   assessor_id,
                  p_ingood.operator      operator,
                  p_ingood.checkout_time checkout_time,
                  p_ingood.is_ready      is_ready,
                  p_ingood.accept_id     accept_id,
                  p_ingood.int_id        int_id,
                  p_ingood.consignee_id  consignee_id,
                  p_ingood.audittime     audittime,
                  p_ingood.auditor_id    auditor_id,
                  p_ingood.status        status,
                  p_ingood.dprepaymoney  dprepaymoney,
                  p_ingood.duemoney      duemoney,
                  p_ingood.is_payout     is_payout,
                  p_ingood.update_time   update_time,
                  p_ingood.ingood_type   ingood_type,
                  p_ingood.memo          memo,
                  p_ingood.DOCUMENT_NO   DOCUMENT_NO
             from dual) b
    on (a.ing_id = b.ing_id and a.company_id = b.company_id)
    when not matched then
      insert
        (a.ing_id,
         a.company_id,
         a.sho_id,
         a.supplier_code,
         a.operator_id,
         a.create_time,
         a.finish_time,
         a.assessor_id,
         a.operator,
         a.checkout_time,
         a.is_ready,
         a.accept_id,
         a.int_id,
         a.consignee_id,
         a.audittime,
         a.auditor_id,
         a.status,
         a.dprepaymoney,
         a.duemoney,
         a.is_payout,
         a.update_time,
         a.ingood_type,
         a.memo,
         a.DOCUMENT_NO)
      values
        (b.ing_id,
         b.company_id,
         b.sho_id,
         b.supplier_code,
         b.operator_id,
         b.create_time,
         b.finish_time,
         b.assessor_id,
         b.operator,
         b.checkout_time,
         b.is_ready,
         b.accept_id,
         b.int_id,
         b.consignee_id,
         b.audittime,
         b.auditor_id,
         b.status,
         b.dprepaymoney,
         b.duemoney,
         b.is_payout,
         b.update_time,
         b.ingood_type,
         b.memo,
         b.DOCUMENT_NO)
    when matched then
      update
         set a.sho_id        = b.sho_id,
             a.supplier_code = b.supplier_code,
             a.operator_id   = b.operator_id,
             a.create_time   = b.create_time,
             a.finish_time   = b.finish_time,
             a.assessor_id   = b.assessor_id,
             a.operator      = b.operator,
             a.checkout_time = b.checkout_time,
             a.is_ready      = b.is_ready,
             a.accept_id     = b.accept_id,
             a.int_id        = b.int_id,
             a.consignee_id  = b.consignee_id,
             a.audittime     = b.audittime,
             a.auditor_id    = b.auditor_id,
             a.status        = b.status,
             a.dprepaymoney  = b.dprepaymoney,
             a.duemoney      = b.duemoney,
             a.is_payout     = b.is_payout,
             a.update_time   = b.update_time,
             a.ingood_type   = b.ingood_type,
             a.memo          = b.memo,
             a.DOCUMENT_NO   = b.DOCUMENT_NO;
  
  end dual_ingood_inf;

  procedure dual_ingoods_inf(p_ingoods scmdata.t_ingoods%rowtype) is
    p_goo_id     varchar2(32);
    p_company_id varchar2(32);
  begin
    select max(company_id)
      into p_company_id
      from scmdata.t_interface a
     where a.interface_id = 'ASN_MAIN';
    select max(a.goo_id)
      into p_goo_id
      from scmdata.t_commodity_info a
     where a.rela_goo_id = p_ingoods.goo_id
       and a.company_id = p_company_id;
    if p_goo_id is null then
      merge into scm_interface.cmx_ingoods_inf a
      using (select p_ingoods.ing_id            ing_id,
                    p_company_id                company_id,
                    p_ingoods.goo_id            goo_id,
                    p_ingoods.inprice           inprice,
                    p_ingoods.amount            amount,
                    p_ingoods.create_time       create_time,
                    p_ingoods.old_inprice       old_inprice,
                    p_ingoods.memo              memo,
                    p_ingoods.whole_sale_amount whole_sale_amount,
                    p_ingoods.invoice_amount    invoice_amount,
                    p_ingoods.pt_pay_time       pt_pay_time,
                    p_ingoods.gz_pay_time       gz_pay_time,
                    null                        update_time
               from dual) b
      on (a.ing_id = b.ing_id and a.company_id = b.company_id and a.goo_id = b.goo_id)
      when not matched then
        insert
          (a.ing_id,
           a.company_id,
           a.goo_id,
           a.inprice,
           a.amount,
           a.create_time,
           a.old_inprice,
           a.memo,
           a.whole_sale_amount,
           a.invoice_amount,
           a.pt_pay_time,
           a.gz_pay_time,
           a.update_time,
           a.recieve_time,
           a.operation_falg,
           a.recieve_type,
           a.operation_type)
        values
          (b.ing_id,
           b.company_id,
           b.goo_id,
           b.inprice,
           b.amount,
           b.create_time,
           b.old_inprice,
           b.memo,
           b.whole_sale_amount,
           b.invoice_amount,
           b.pt_pay_time,
           b.gz_pay_time,
           null,
           sysdate,
           0,
           'R_SUP',
           'IU')
      when matched then
        update
           set a.inprice           = b.inprice,
               a.amount            = b.amount,
               a.create_time       = b.create_time,
               a.old_inprice       = b.old_inprice,
               a.memo              = b.memo,
               a.whole_sale_amount = b.whole_sale_amount,
               a.invoice_amount    = b.invoice_amount,
               a.pt_pay_time       = b.pt_pay_time,
               a.gz_pay_time       = b.gz_pay_time,
               a.update_time       = b.update_time,
               a.recieve_time      = sysdate,
               a.operation_falg    = 0,
               a.recieve_type      = 'R_SUP',
               a.operation_type    = 'IU';
      return;
    
    end if;
    merge into scmdata.t_ingoods a
    using (select p_ingoods.ing_id            ing_id,
                  p_company_id                company_id,
                  p_goo_id                    goo_id,
                  p_ingoods.inprice           inprice,
                  p_ingoods.amount            amount,
                  p_ingoods.create_time       create_time,
                  p_ingoods.old_inprice       old_inprice,
                  p_ingoods.memo              memo,
                  p_ingoods.whole_sale_amount whole_sale_amount,
                  p_ingoods.invoice_amount    invoice_amount,
                  p_ingoods.pt_pay_time       pt_pay_time,
                  p_ingoods.gz_pay_time       gz_pay_time,
                  null                        update_time
             from dual) b
    on (a.ing_id = b.ing_id and a.company_id = b.company_id and a.goo_id = b.goo_id)
    when not matched then
      insert
        (a.ing_id,
         a.company_id,
         a.goo_id,
         a.inprice,
         a.amount,
         a.create_time,
         a.old_inprice,
         a.memo,
         a.whole_sale_amount,
         a.invoice_amount,
         a.pt_pay_time,
         a.gz_pay_time,
         a.update_time)
      values
        (b.ing_id,
         b.company_id,
         b.goo_id,
         b.inprice,
         b.amount,
         b.create_time,
         b.old_inprice,
         b.memo,
         b.whole_sale_amount,
         b.invoice_amount,
         b.pt_pay_time,
         b.gz_pay_time,
         null)
    when matched then
      update
         set a.inprice           = b.inprice,
             a.amount            = b.amount,
             a.create_time       = b.create_time,
             a.old_inprice       = b.old_inprice,
             a.memo              = b.memo,
             a.whole_sale_amount = b.whole_sale_amount,
             a.invoice_amount    = b.invoice_amount,
             a.pt_pay_time       = b.pt_pay_time,
             a.gz_pay_time       = b.gz_pay_time,
             a.update_time       = b.update_time;
  
  end dual_ingoods_inf;

  procedure dual_ingoodsitem_inf(p_ingoodsitem scmdata.t_ingoodsitem%rowtype) is
    p_goo_id     varchar2(32);
    p_company_id varchar2(32);
  begin
    select max(company_id)
      into p_company_id
      from scmdata.t_interface a
     where a.interface_id = 'ASN_MAIN';
    select max(a.goo_id)
      into p_goo_id
      from scmdata.t_commodity_info a
     where a.rela_goo_id = p_ingoodsitem.goo_id
       and a.company_id = p_company_id;
    if p_goo_id is null then
      merge into scm_interface.cmx_ingoodsitem_inf a
      using (select p_ingoodsitem.ing_id            ing_id,
                    p_company_id                    company_id,
                    p_ingoodsitem.goo_id            goo_id,
                    p_ingoodsitem.barcode           barcode,
                    p_ingoodsitem.amount            amount,
                    p_ingoodsitem.memo              memo,
                    p_ingoodsitem.whole_sale_amount whole_sale_amount,
                    p_ingoodsitem.invoice_amount    invoice_amount
               from dual) b
      on (a.ing_id = b.ing_id and a.company_id = b.company_id and a.goo_id = b.goo_id and a.barcode = b.barcode)
      when not matched then
        insert
          (a.ing_id,
           a.company_id,
           a.goo_id,
           a.barcode,
           a.amount,
           a.memo,
           a.whole_sale_amount,
           a.invoice_amount,
           a.recieve_time,
           a.operation_falg,
           a.recieve_type,
           a.operation_type)
        values
          (b.ing_id,
           b.company_id,
           b.goo_id,
           b.barcode,
           b.amount,
           b.memo,
           b.whole_sale_amount,
           b.invoice_amount,
           sysdate,
           0,
           'R_SUP',
           'IU')
      when matched then
        update
           set a.amount            = b.amount,
               a.memo              = b.memo,
               a.whole_sale_amount = b.whole_sale_amount,
               a.invoice_amount    = b.invoice_amount,
               a.recieve_time      = sysdate,
               a.operation_falg    = 0,
               a.recieve_type      = 'R_SUP',
               a.operation_type    = 'IU';
               return;
    end if;
    merge into scmdata.t_ingoodsitem a
    using (select p_ingoodsitem.ing_id            ing_id,
                  p_company_id                    company_id,
                  p_goo_id                        goo_id,
                  p_ingoodsitem.barcode           barcode,
                  p_ingoodsitem.amount            amount,
                  p_ingoodsitem.memo              memo,
                  p_ingoodsitem.whole_sale_amount whole_sale_amount,
                  p_ingoodsitem.invoice_amount    invoice_amount
             from dual) b
    on (a.ing_id = b.ing_id and a.company_id = b.company_id and a.goo_id = b.goo_id and a.barcode = b.barcode)
    when not matched then
      insert
        (a.ing_id,
         a.company_id,
         a.goo_id,
         a.barcode,
         a.amount,
         a.memo,
         a.whole_sale_amount,
         a.invoice_amount)
      values
        (b.ing_id,
         b.company_id,
         b.goo_id,
         b.barcode,
         b.amount,
         b.memo,
         b.whole_sale_amount,
         b.invoice_amount)
    when matched then
      update
         set a.amount            = b.amount,
             a.memo              = b.memo,
             a.whole_sale_amount = b.whole_sale_amount,
             a.invoice_amount    = b.invoice_amount;
  end dual_ingoodsitem_inf;

end pkg_inf_ingood;
/

