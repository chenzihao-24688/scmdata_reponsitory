CREATE OR REPLACE PACKAGE SCMDATA.pkg_delivery_send IS

  -- Author  : SANFU
  -- Created : 2022/11/2 15:40:00
  -- Purpose : 送货单处理

  PROCEDURE p_dual_delivery_send_inf(p_delivery_send_inf scmdata.t_delivery_send_inf%ROWTYPE);

  /*=================================================================================
  
    包：
      pkg_delivery_send (交货记录发送包)
  
    过程名:
      【交货记录】新增 / 修改交货记录回传订单记录
  
    入参:
      v_inp_ordid   :  订单号
      v_inp_compid  :  企业Id
  
     版本:
       2023-04-11: 新增 / 修改交货记录回传订单记录
  
  =================================================================================*/
  PROCEDURE p_delivrec_iou_deliverytransordrec(v_inp_ordid  IN VARCHAR2,
                                               v_inp_compid IN VARCHAR2);

END pkg_delivery_send;
/

CREATE OR REPLACE PACKAGE BODY SCMDATA.pkg_delivery_send IS

  PROCEDURE p_dual_delivery_send_inf(p_delivery_send_inf scmdata.t_delivery_send_inf%ROWTYPE) IS
  
    p_delivery_record      scmdata.t_delivery_record%ROWTYPE;
    p_delivery_record_item scmdata.t_delivery_record_item%ROWTYPE;
    p_i                    NUMBER(1);
    p_sho_id               VARCHAR2(32);
    p_supplier_code        VARCHAR2(32);
    v_send_id              VARCHAR2(32);
  BEGIN
    --新增数据
    INSERT INTO scmdata.t_delivery_send_inf
      (delivery_send_inf_id,
       company_id,
       ord_ids,
       oper_user_id,
       asn_body,
       asnitem_body,
       create_time,
       dealt,
       asn_ids)
    VALUES
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
    FOR x IN (SELECT c.*
                FROM scmdata.t_delivery_send_inf a,
                     json_table(a.asn_body,
                                '$[*]'
                                columns(order_code VARCHAR2(32) path
                                        '$[*].ORDERID',
                                        asn_id VARCHAR2(32) path '$[*].ASN_ID',
                                        goo_id VARCHAR2(32) path '$[*].GOO_ID',
                                        is_fcl_out NUMBER(1) path
                                        '$[*].IS_FCL_OUT',
                                        is_qc_required NUMBER(1) path
                                        '$[*].IS_QC_REQUIRED',
                                        predict_delivery_amount NUMBER(18, 4) path
                                        '$[*].PCOMEAMOUNT',
                                        predict_delivery_date DATE path
                                        '$[*].PCOMEDATE',
                                        create_time DATE path
                                        '$[*].FINIISHTIME',
                                        asn_list VARCHAR2(32) path
                                        '$[*].ASN_LIST',
                                        packcases NUMBER(18) path
                                        '$[*].PACKCASES')) c
               WHERE a.delivery_send_inf_id =
                     p_delivery_send_inf.delivery_send_inf_id) LOOP
      --根据asnList删除
      scmdata.pkg_inf_asn.p_exclude_useless_asn(p_asn_list => x.asn_list,
                                                p_ord_id   => x.order_code);
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
    END LOOP;
    --处理色码表
  
    FOR x IN (SELECT DISTINCT c.*
                FROM scmdata.t_delivery_send_inf a,
                     json_table(a.asnitem_body,
                                '$[*]'
                                columns(ord_id VARCHAR2(32) path
                                        '$[*].ORD_ID',
                                        
                                        asn_id VARCHAR2(32) path '$[*].ASN_ID',
                                        goo_id VARCHAR2(32) path '$[*].GOO_ID',
                                        barcode VARCHAR2(32) path
                                        '$[*].BARCODE',
                                        predict_delivery_amount NUMBER(18, 4) path
                                        '$[*].PCOMEAMOUNT',
                                        packcases NUMBER(18) path
                                        '$[*].PACKCASES')) c
               WHERE a.delivery_send_inf_id =
                     p_delivery_send_inf.delivery_send_inf_id) LOOP
      p_delivery_record_item.delivery_record_id      := x.asn_id;
      p_delivery_record_item.goo_id                  := x.goo_id;
      p_delivery_record_item.barcode                 := x.barcode;
      p_delivery_record_item.predict_delivery_amount := x.predict_delivery_amount;
      p_delivery_record_item.packcases               := x.packcases;
      scmdata.pkg_inf_asn.p_dual_delivery_record_item_if(p_delivery_record_item => p_delivery_record_item);
    END LOOP;
  
    SELECT MAX(oe.sho_id), MAX(oe.supplier_code)
      INTO p_sho_id, p_supplier_code
      FROM scmdata.t_ordered oe
     WHERE oe.order_code = p_delivery_send_inf.ord_ids
       AND oe.company_id = p_delivery_send_inf.company_id;
  
    SELECT MAX(1)
      INTO p_i
      FROM scmdata.t_sendordered a
     WHERE a.asn_id = p_delivery_send_inf.asn_ids
       AND a.order_code = p_delivery_send_inf.ord_ids
       AND a.company_id = p_delivery_send_inf.company_id
       AND a.supplier_code = p_supplier_code;
  
    IF p_i = 0 THEN
      -- 0 说明存在送货单，直接不产生
      RETURN;
    ELSIF p_i = 1 THEN
      ----1 更新成 0
      UPDATE scmdata.t_sendordered a
         SET a.closed   = 0,
             a.finished = 0
       WHERE a.asn_id = p_delivery_send_inf.asn_ids
         AND a.order_code = p_delivery_send_inf.ord_ids
         AND a.company_id = p_delivery_send_inf.company_id
         AND a.supplier_code = p_supplier_code;
    END IF;
  
    v_send_id := scmdata.pkg_plat_comm.f_getkeycode(pi_table_name  => 'T_SENDORDERED',
                                                    pi_column_name => 'SEND_ID',
                                                    pi_company_id  => p_delivery_send_inf.company_id,
                                                    pi_pre         => p_sho_id || 'S' ||
                                                                      to_char(SYSDATE,
                                                                              'YYMMDD'),
                                                    pi_serail_num  => 5);
  
    --生成送货单
    INSERT INTO scmdata.t_sendordered
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
    VALUES
      (scmdata.f_get_uuid(),
       p_delivery_send_inf.company_id,
       p_supplier_code,
       p_delivery_send_inf.asn_ids,
       v_send_id,
       SYSDATE,
       p_delivery_send_inf.oper_user_id,
       NULL,
       NULL,
       NULL,
       NULL,
       p_delivery_send_inf.ord_ids,
       0);
  
    INSERT INTO scmdata.t_sendorders
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
      SELECT scmdata.f_get_uuid_pe(),
             a.company_id,
             a.order_code,
             v_send_id,
             ef.asn_id,
             b.goo_id,
             ci.rela_goo_id,
             nvl(g.barcode, ci.rela_goo_id) goodids,
             SUM(nvl(g.predict_delivery_amount, ef.predict_delivery_amount)),
             '',
             '',
             0 barcodeinprice,
             0,
             NULL
        FROM scmdata.t_ordered a
       INNER JOIN scmdata.t_orders b
          ON a.order_code = b.order_id
         AND a.company_id = b.company_id
        LEFT JOIN scmdata.t_ordersitem i
          ON i.order_id = b.order_id
         AND b.goo_id = i.goo_id
       INNER JOIN scmdata.t_commodity_info ci
          ON ci.company_id = b.company_id
         AND ci.goo_id = b.goo_id
       INNER JOIN scmdata.t_delivery_record ef
          ON ef.order_code = a.order_code
         AND ef.company_id = a.company_id
        LEFT JOIN scmdata.t_delivery_record_item g
          ON ef.delivery_record_id = g.delivery_record_id
         AND ef.company_id = ef.company_id
         AND g.goo_id = ef.goo_id
       WHERE a.order_code = p_delivery_send_inf.ord_ids
         AND a.company_id = p_delivery_send_inf.company_id
         AND ef.asn_id = p_delivery_send_inf.asn_ids
         AND NOT EXISTS
       (SELECT 1
                FROM scmdata.t_sendorders j
               WHERE j.order_code = a.order_code
                 AND j.company_id = a.company_id
                 AND j.asn_id = ef.asn_id
                 AND j.goo_id = b.goo_id
                 AND nvl(g.barcode, ci.rela_goo_id) = j.goodids)
       GROUP BY a.order_code,
                a.company_id,
                ef.asn_id,
                b.goo_id,
                ci.rela_goo_id,
                nvl(g.barcode, ci.rela_goo_id),
                (CASE
                  WHEN ci.category IN ('07') THEN
                   b.order_price
                  ELSE
                   NULL
                END);
  
    DELETE FROM scmdata.t_delivery_send_inf a
     WHERE a.delivery_send_inf_id =
           p_delivery_send_inf.delivery_send_inf_id;
  
  END p_dual_delivery_send_inf;

  /*=================================================================================
  
    包：
      pkg_delivery_send (交货记录发送包)
  
    过程名:
      【交货记录】新增 / 修改交货记录回传订单记录
  
    入参:
      v_inp_ordid   :  订单号
      v_inp_compid  :  企业Id
  
     版本:
       2023-04-11: 新增 / 修改交货记录回传订单记录
  
  =================================================================================*/
  PROCEDURE p_delivrec_iou_deliverytransordrec(v_inp_ordid  IN VARCHAR2,
                                               v_inp_compid IN VARCHAR2) IS
    v_jugnum NUMBER(1);
    v_status VARCHAR2(8);
  BEGIN
    SELECT nvl(MAX(1), 0), MAX(status)
      INTO v_jugnum, v_status
      FROM scmdata.t_delivery_trans_ord_rec
     WHERE order_id = v_inp_ordid
       AND company_id = v_inp_compid
       AND rownum = 1;
  
    IF v_jugnum = 0 THEN
      INSERT INTO scmdata.t_delivery_trans_ord_rec
        (rec_id,
         company_id,
         order_id,
         status,
         lastupd_time)
      VALUES
        (scmdata.f_get_uuid(),
         v_inp_compid,
         v_inp_ordid,
         'TS',
         SYSDATE);
    ELSE
      IF v_status <> 'TS' THEN
        UPDATE scmdata.t_delivery_trans_ord_rec
           SET status       = 'TS',
               lastupd_time = SYSDATE
         WHERE order_id = v_inp_ordid
           AND company_id = v_inp_compid;
      END IF;
    END IF;
  EXCEPTION
    WHEN OTHERS THEN
      NULL;
  END p_delivrec_iou_deliverytransordrec;

END pkg_delivery_send;
/

