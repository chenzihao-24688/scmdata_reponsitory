DECLARE
  v_sql CLOB;
BEGIN
  v_sql := q'[
DECLARE
  v_unitprice NUMBER := @unitprice@;
BEGIN
  IF v_unitprice IS NULL THEN
    raise_application_error(-20002, '单价必填，请检查！');
  ELSE
    UPDATE scmdata.t_sendorders a
       SET a.inprice = v_unitprice
     WHERE a.asn_id || '-' || a.goodids IN (@selection);
  END IF;
END;]';
 UPDATE bw3.sys_action t SET t.action_sql = v_sql WHERE t.element_id = 'action_a_asn_extend_02'; 
END;
/
DECLARE
  v_sql CLOB;
BEGIN
  v_sql := q'[
DECLARE
  v_order_cnt   INT;
  v_order_codes VARCHAR(2000);
BEGIN
  SELECT listagg(DISTINCT t.order_code, ';'),
         COUNT(DISTINCT t.order_code) order_cnt
    INTO v_order_codes, v_order_cnt
    FROM scmdata.t_sendordered a
   INNER JOIN scmdata.t_ordered t
      ON t.order_code = a.order_code
     AND t.company_id = a.company_id
     AND t.order_status <> 'OS02'
   WHERE a.send_id IN (@selection@);

  --判断订单是否结束
  IF v_order_cnt > 0 THEN
    raise_application_error(-20002,
                            '不可手动关闭送货单！存在' || v_order_cnt || '张订单【' ||
                            v_order_codes || '】未结束');
  ELSE
    UPDATE scmdata.t_sendordered a
       SET a.closed = 1
     WHERE a.send_id IN (@selection@);
  END IF;
END;]';
 UPDATE bw3.sys_action t SET t.action_sql = v_sql WHERE t.element_id = 'action_a_asn_extend_03_sup'; 
END;
/
DECLARE
v_sql CLOB;
v_sql1 CLOB;
BEGIN
v_sql := 'SELECT i.ord_id orderid,
       a.asn_id asn_ids,
       a.goo_id rela_goo_id,
       b.specs  style_number,
       -- j.Sup_Name ,
       g.pcomedate pcome_date_panda,
       g.time_interval,
       nn.deliverdate latest_delivery_date,
       a.orderamount order_amount,
       a.gotamount delivery_amount_dr,
       a.orderamount - a.gotamount owe_amount_pr,
       a.pcomeamount,
       a.pack_specs_send,
       a.product_date,
       a.limit_use_date,
       a.batchno,
       q.rationame rationame_00000,
       i.send_by_sup send_by_sup_bool,
       i.isfirstordered,
       a.urgency,
       --a.Is_Qc_Required,      
       b.goo_name,
       cate.bra_name,
       c.cusgroupname,
       d.categorygroup,
       e.categories,
       f.subcategory,
       b.season,
       a.memo,
       nvl(k.username, o.sup_name) oper_user_member,
       g.createtime,
       --Nn.Inprice,
       -- a.Orderamount * Nn.Inprice Ordermoney,       
       /*Case When T1.effective_Days > (
       Case When T2.limit_Use_Date Is Null Then Ceil(b.shelf_Life - (Trunc(Sysdate) - T2.product_date))
       Else Ceil(T2.limit_Use_Date - Trunc(Sysdate)) End) Then 1 Else 0 End ISPASS,*/
       a.asn_id || a.goo_id keyid,
       o.sup_id_base oper_sup_id_base,
       g.operatorid,
       va.asn_items_cnt
  FROM asnorders a
 INNER JOIN goods b
    ON a.goo_id = b.goo_id
 INNER JOIN nsfdata.branch cate
    ON cate.bra_id = b.bra_id
 INNER JOIN pl_dic_cusgroups c
    ON b.cusgroupno = c.cusgroupno
 INNER JOIN pl_dic_categorygroup d
    ON b.categorygroupno = d.categorygroupno
 INNER JOIN pl_dic_category e
    ON b.categoryno = e.categoryno
 INNER JOIN pl_dic_subcategory f
    ON b.subcategoryno = f.subcategoryno
 INNER JOIN asnordered g
    ON a.asn_id = g.asn_id
 INNER JOIN ordered i
    ON g.ord_id = i.ord_id
 INNER JOIN orders nn
    ON i.ord_id = nn.ord_id
   AND a.goo_id = nn.goo_id
--211203 BY 589 INNERjoin T2
  LEFT JOIN goodsofinspect t2
    ON t2.goo_id = b.goo_id
   AND t2.sup_id = b.sup_id
   AND t2.batchno = a.batchno
--211203 BY 589 leftjoin T1
  LEFT JOIN goods_expand t1
    ON b.goo_id = t1.goo_id
  LEFT JOIN supplier j
    ON i.sup_id = j.sup_id
  LEFT JOIN users k
    ON g.operatorid = k.userid
  LEFT JOIN supplier o
    ON g.operatorid = o.sup_id
  LEFT JOIN (SELECT DISTINCT p.ratioid, p.rationame
               FROM nsfdata.sizeratio4shoes p) q
    ON q.ratioid = i.ratioid
  LEFT JOIN (SELECT t.asn_id, COUNT(1) asn_items_cnt
               FROM nsfdata.asnordersitem t
              GROUP BY t.asn_id) va
    ON va.asn_id = a.asn_id
 WHERE g.finishtime IS NULL
      --AND i.Sho_Id = %Sho_Id%
      --AND i.Bra_Id = %Bra_Id%
   AND i.finishtime IS NULL
   AND j.sup_id_base = %sup_id_base% {declare v_order_id VARCHAR2(32) := :ord_id;
v_sql VARCHAR2(100) := '''';
BEGIN
  IF v_order_id IS NOT NULL THEN
    v_sql := '' and g.ORD_ID=:ord_id'';
  END IF;
  @strresult := v_sql;
END;
}
--Order By a.Asn_Id
ORDER BY pcome_date_panda ASC, asn_ids ASC';

v_sql1 :=q'[DECLARE
  p_i            NUMBER(1);
  v_productdate  DATE := to_date(:product_date, 'yyyy-mm-dd');
  v_limitusedate DATE := to_date(:limit_use_date, 'yyyy-mm-dd');
BEGIN
  SELECT nvl(MAX(1), 0)
    INTO p_i
    FROM asnordered a
   INNER JOIN supplier b
      ON a.operatorid = b.sup_id
   WHERE asn_id = :old_asn_ids
     AND b.sup_id_base = %sup_id_base%;

  IF p_i = 0 THEN
    raise_application_error(-20002, '不可修改操作员非本人的单据');
  END IF;

  UPDATE asnorders
     SET pack_specs_send = :pack_specs_send,
         batchno         = :batchno,
         product_date    = decode(:batchno, NULL, NULL, v_productdate),
         limit_use_date  = decode(:batchno, NULL, NULL, v_limitusedate),
         memo            = :memo,
         pcomeamount     = :Pcomeamount
   WHERE asn_id = :old_asn_ids
     AND goo_id = :old_rela_goo_id;

  UPDATE asnordered a
     SET a.pcomedate = :pcome_date_panda
   WHERE EXISTS (SELECT 1
            FROM asnorders b
           WHERE b.asn_id = :old_asn_ids
             AND b.goo_id = :old_rela_goo_id
             AND a.asn_id = b.asn_id);
END;]';
UPDATE bw3.sys_item_list t SET t.select_sql = v_sql,t.update_sql = v_sql1,t.noshow_fields = 'KEYID,OPERATORID,OPER_SUP_ID_BASE,ASN_ITEMS_CNT' WHERE t.item_id = 'a_asn_215_sup'; 
END;
/
DECLARE
v_sql CLOB;
BEGIN
  v_sql := '{
DECLARE
  v_sql  CLOB;
  v_flag INT;
BEGIN
  SELECT CASE
           WHEN MAX(q.rationame) IS NULL THEN
            1
           ELSE
            0
         END
    INTO v_flag
    FROM asnordered ad
   INNER JOIN ordered t
      ON ad.ord_id = t.ord_id
    LEFT JOIN (SELECT DISTINCT p.ratioid, p.rationame
                 FROM nsfdata.sizeratio4shoes p) q
      ON q.ratioid = t.ratioid
   WHERE ad.asn_id = %asn_id%;
     
  v_sql := q''[
SELECT ]''|| (CASE WHEN v_flag = 1 THEN NULL ELSE '' DISTINCT '' END) || q''[
       v.orderid,
       v.asn_ids,
       ]''|| (CASE WHEN v_flag = 1 THEN ''v.tail_box,'' ELSE NULL END) || q''[
       v.pack_no,
       v.pack_barcode,
       v.pack_specs_send_pr,
       --a.Ratioid,
       v.rationame_00000,
       v.rela_goo_id,
       ]''|| (CASE WHEN v_flag = 1 THEN ''v.barcode,'' ELSE NULL END) || q''[
       --v.goodsid,
       v.style_number,
       v.bra_name,
       v.cusgroupname,
       v.categorygroup,
       v.categories,
       v.subcategory,
       v.colorname,
       ]''|| (CASE WHEN v_flag = 1 THEN ''v.sizename,'' ELSE NULL END) || q''[
       ]''|| (CASE WHEN v_flag = 1 THEN ''v.packamount_pr,'' ELSE NULL END) || q''[
       v.createtime,
       v.update_time,
       v.operatorid,
       v.memo
  FROM (SELECT ad.ord_id orderid,
               a.asn_id asn_ids,
               CASE
                 WHEN a.packamount < a.pack_specs_send AND a.ratioid IS NULL THEN
                  ''是''
                 WHEN a.ratioid IS NOT NULL THEN
                  NULL
                 ELSE
                  ''否''
               END tail_box,
               a.pack_no,
               a.pack_barcode,
               a.pack_specs_send pack_specs_send_pr,
               --a.Ratioid,
               q.rationame     rationame_00000,
               a.goo_id        rela_goo_id,
               a.barcode,
               a.goodsid,
               d.specs         style_number,
               cate.bra_name,
               j.cusgroupname,
               k.categorygroup,
               e.categories,
               f.subcategory,
               b.colorname,
               b.sizename,
               a.packamount    packamount_pr,
               a.createtime,
               a.updatetime    update_time,
               c.username      operatorid,
               a.memo
          FROM asnorderpacks a
         INNER JOIN goods d
            ON a.goo_id = d.goo_id
          LEFT JOIN nsfdata.branch cate
            ON cate.bra_id = d.bra_id
         INNER JOIN pl_dic_category e
            ON d.categoryno = e.categoryno
         INNER JOIN pl_dic_subcategory f
            ON f.subcategoryno = d.subcategoryno
         INNER JOIN pl_dic_cusgroups j
            ON j.cusgroupno = d.cusgroupno
         INNER JOIN pl_dic_categorygroup k
            ON k.categorygroupno = d.categorygroupno
         INNER JOIN asnordered ad
            ON a.asn_id = ad.asn_id
         INNER JOIN ordered t
            ON ad.ord_id = t.ord_id
          LEFT JOIN articles b
            ON a.barcode = b.barcode
          LEFT JOIN users c
            ON a.operatorid = c.userid
          LEFT JOIN (SELECT DISTINCT p.ratioid, p.rationame
                      FROM nsfdata.sizeratio4shoes p) q
            ON q.ratioid = t.ratioid
         WHERE a.asn_id = %asn_id%
           AND nvl(t.sample_ord, 0) = 0
        UNION ALL
        SELECT ad.ord_id,
               a.asn_id asn_ids,
               ''是'' tail_box,
               a.pack_no,
               a.pack_barcode,
               a.pack_specs_send pack_specs_send_pr,
               --a.Ratioid,
               q.rationame     rationame_00000,
               a.goo_id        rela_goo_id,
               a.barcode,
               a.goodsid,
               d.specs         style_name,
               cate.bra_name,
               j.cusgroupname,
               k.categorygroup,
               e.categories,
               f.subcategory,
               b.colorname,
               b.sizename,
               a.packamount    packamount_pr,
               a.createtime,
               a.updatetime    update_time,
               c.username      operatorid,
               a.memo
          FROM asnorderpacks a
         INNER JOIN goods d
            ON a.goo_id = d.goo_id
          LEFT JOIN nsfdata.branch cate
            ON cate.bra_id = d.bra_id
         INNER JOIN pl_dic_category e
            ON d.categoryno = e.categoryno
         INNER JOIN pl_dic_subcategory f
            ON f.subcategoryno = d.subcategoryno
         INNER JOIN pl_dic_cusgroups j
            ON j.cusgroupno = d.cusgroupno
         INNER JOIN pl_dic_categorygroup k
            ON k.categorygroupno = d.categorygroupno
         INNER JOIN asnordered ad
            ON a.asn_id = ad.asn_id
         INNER JOIN ordered t
            ON ad.ord_id = t.ord_id
          LEFT JOIN articles b
            ON a.barcode = b.barcode
          LEFT JOIN users c
            ON a.operatorid = c.userid
          LEFT JOIN (SELECT DISTINCT p.ratioid, p.rationame
                      FROM nsfdata.sizeratio4shoes p) q
            ON q.ratioid = t.ratioid
         WHERE a.asn_id = %asn_id%
           AND a.packamount < a.pack_specs_send
           AND a.ratioid IS NULL
           AND nvl(t.sample_ord, 0) = 0
        UNION ALL
        SELECT ad.ord_id orderid,
               a.asn_id asn_ids,
               ''否'' tail_box,
               a.pack_no,
               a.pack_barcode,
               a.pack_specs_send pack_specs_send_pr,
               --a.Ratioid,
               q.rationame rationame_00000,
               a.goo_id rela_goo_id,
               NULL barcode,
               NULL goodsid,
               d.specs style_name,
               cate.bra_name,
               j.cusgroupname,
               k.categorygroup,
               e.categories,
               f.subcategory,
               NULL colorname,
               NULL sizename,
               SUM(a.packamount) packamount_pr,
               a.createtime,
               a.updatetime update_time,
               c.username operatorid,
               a.memo
          FROM asnorderpacks a
         INNER JOIN goods d
            ON a.goo_id = d.goo_id
          LEFT JOIN nsfdata.branch cate
            ON cate.bra_id = d.bra_id
         INNER JOIN pl_dic_category e
            ON d.categoryno = e.categoryno
         INNER JOIN pl_dic_subcategory f
            ON f.subcategoryno = d.subcategoryno
         INNER JOIN pl_dic_cusgroups j
            ON j.cusgroupno = d.cusgroupno
         INNER JOIN pl_dic_categorygroup k
            ON k.categorygroupno = d.categorygroupno
         INNER JOIN asnordered ad
            ON a.asn_id = ad.asn_id
         INNER JOIN ordered t
            ON ad.ord_id = t.ord_id
          LEFT JOIN users c
            ON a.operatorid = c.userid
          LEFT JOIN (SELECT DISTINCT p.ratioid, p.rationame
                      FROM nsfdata.sizeratio4shoes p) q
            ON q.ratioid = t.ratioid
         WHERE a.asn_id = %asn_id%
           AND t.sample_ord = 1
         GROUP BY ad.ord_id,
                  a.asn_id,
                  a.pack_no,
                  a.pack_barcode,
                  a.pack_specs_send,
                  --a.Ratioid,
                  q.rationame,
                  a.goo_id,
                  d.specs,
                  cate.bra_name,
                  j.cusgroupname,
                  k.categorygroup,
                  e.categories,
                  f.subcategory,
                  a.createtime,
                  a.updatetime,
                  c.username,
                  a.memo
         ORDER BY pack_barcode ASC) v]'';
 @strresult := v_sql;
END;
}';
UPDATE bw3.sys_item_list t SET t.select_sql = v_sql WHERE t.item_id = 'a_asn_224';
END;
/
DECLARE
v_sql CLOB;
BEGIN
  v_sql := '{
DECLARE
  v_sql  CLOB;
  v_flag INT;
BEGIN
  SELECT CASE
           WHEN MAX(q.rationame) IS NULL THEN
            1
           ELSE
            0
         END
    INTO v_flag
    FROM asnordered ad
   INNER JOIN ordered t
      ON ad.ord_id = t.ord_id
    LEFT JOIN (SELECT DISTINCT p.ratioid, p.rationame
                 FROM nsfdata.sizeratio4shoes p) q
      ON q.ratioid = t.ratioid
   WHERE ad.asn_id = %asn_id%;
   
  v_sql := q''[
SELECT ]''|| (CASE WHEN v_flag = 1 THEN NULL ELSE '' DISTINCT '' END) || q''[
       v.orderid,
       v.asn_ids,
       ]''|| (CASE WHEN v_flag = 1 THEN ''v.tail_box,'' ELSE NULL END) || q''[
       v.pack_no,
       v.pack_barcode,
       v.pack_specs_send_pr,
       --a.Ratioid,
       v.rationame_00000,
       v.rela_goo_id,
       ]''|| (CASE WHEN v_flag = 1 THEN ''v.barcode,'' ELSE NULL END) || q''[
       --v.goodsid,
       v.style_number,
       v.bra_name,
       v.cusgroupname,
       v.categorygroup,
       v.categories,
       v.subcategory,
       v.colorname,
       ]''|| (CASE WHEN v_flag = 1 THEN ''v.sizename,'' ELSE NULL END) || q''[
       ]''|| (CASE WHEN v_flag = 1 THEN ''v.packamount_pr,'' ELSE NULL END) || q''[
       v.createtime,
       v.update_time,
       v.operatorid,
       v.memo
  FROM (SELECT ad.ord_id orderid,
       a.asn_id asn_ids,
       CASE
         WHEN a.packamount < a.pack_specs_send AND a.ratioid IS NULL THEN
          ''是''
         WHEN a.ratioid IS NOT NULL THEN
          NULL
         ELSE
          ''否''
       END tail_box,
       a.pack_no,
       a.pack_barcode,
       a.pack_specs_send pack_specs_send_pr,
       --a.Ratioid,
       q.rationame     rationame_00000,
       a.goo_id        rela_goo_id,
       a.barcode,
       a.goodsid,
       d.specs         style_number,
       cate.bra_name,
       j.cusgroupname,
       k.categorygroup,
       e.categories,
       f.subcategory,
       b.colorname,
       b.sizename,
       a.packamount    packamount_pr,
       a.createtime,
       a.updatetime    update_time,
       c.username      operatorid,
       a.memo
  FROM asnorderpacks a
 INNER JOIN goods d
    ON a.goo_id = d.goo_id
  LEFT JOIN nsfdata.branch cate
    ON cate.bra_id = d.bra_id
 INNER JOIN pl_dic_category e
    ON d.categoryno = e.categoryno
 INNER JOIN pl_dic_subcategory f
    ON f.subcategoryno = d.subcategoryno
 INNER JOIN pl_dic_cusgroups j
    ON j.cusgroupno = d.cusgroupno
 INNER JOIN pl_dic_categorygroup k
    ON k.categorygroupno = d.categorygroupno
 INNER JOIN asnordered ad
    ON a.asn_id = ad.asn_id
 INNER JOIN ordered t
    ON ad.ord_id = t.ord_id
  LEFT JOIN articles b
    ON a.barcode = b.barcode
  LEFT JOIN users c
    ON a.operatorid = c.userid
  LEFT JOIN (SELECT DISTINCT p.ratioid, p.rationame
               FROM nsfdata.sizeratio4shoes p) q
    ON q.ratioid = t.ratioid
 WHERE a.asn_id = %asn_id%
   AND nvl(t.sample_ord, 0) = 0
UNION ALL
SELECT ad.ord_id,
       a.asn_id asn_ids,
       ''是'' tail_box,
       a.pack_no,
       a.pack_barcode,
       a.pack_specs_send pack_specs_send_pr,
       --a.Ratioid,
       q.rationame     rationame_00000,
       a.goo_id        rela_goo_id,
       a.barcode,
       a.goodsid,
       d.specs         style_name,
       cate.bra_name,
       j.cusgroupname,
       k.categorygroup,
       e.categories,
       f.subcategory,
       b.colorname,
       b.sizename,
       a.packamount    packamount_pr,
       a.createtime,
       a.updatetime    update_time,
       c.username      operatorid,
       a.memo
  FROM asnorderpacks a
 INNER JOIN goods d
    ON a.goo_id = d.goo_id
  LEFT JOIN nsfdata.branch cate
    ON cate.bra_id = d.bra_id
 INNER JOIN pl_dic_category e
    ON d.categoryno = e.categoryno
 INNER JOIN pl_dic_subcategory f
    ON f.subcategoryno = d.subcategoryno
 INNER JOIN pl_dic_cusgroups j
    ON j.cusgroupno = d.cusgroupno
 INNER JOIN pl_dic_categorygroup k
    ON k.categorygroupno = d.categorygroupno
 INNER JOIN asnordered ad
    ON a.asn_id = ad.asn_id
 INNER JOIN ordered t
    ON ad.ord_id = t.ord_id
  LEFT JOIN articles b
    ON a.barcode = b.barcode
  LEFT JOIN users c
    ON a.operatorid = c.userid
  LEFT JOIN (SELECT DISTINCT p.ratioid, p.rationame
               FROM nsfdata.sizeratio4shoes p) q
    ON q.ratioid = t.ratioid
 WHERE a.asn_id = %asn_id%
   AND a.packamount < a.pack_specs_send
   AND a.ratioid IS NULL
   AND nvl(t.sample_ord, 0) = 0
UNION ALL
SELECT ad.ord_id orderid,
       a.asn_id asn_ids,
       ''否'' tail_box,
       a.pack_no,
       a.pack_barcode,
       a.pack_specs_send pack_specs_send_pr,
       --a.Ratioid,
       q.rationame rationame_00000,
       a.goo_id rela_goo_id,
       NULL barcode,
       NULL goodsid,
       d.specs style_name,
       cate.bra_name,
       j.cusgroupname,
       k.categorygroup,
       e.categories,
       f.subcategory,
       NULL colorname,
       NULL sizename,
       SUM(a.packamount) packamount_pr,
       a.createtime,
       a.updatetime update_time,
       c.username operatorid,
       a.memo
  FROM asnorderpacks a
 INNER JOIN goods d
    ON a.goo_id = d.goo_id
  LEFT JOIN nsfdata.branch cate
    ON cate.bra_id = d.bra_id
 INNER JOIN pl_dic_category e
    ON d.categoryno = e.categoryno
 INNER JOIN pl_dic_subcategory f
    ON f.subcategoryno = d.subcategoryno
 INNER JOIN pl_dic_cusgroups j
    ON j.cusgroupno = d.cusgroupno
 INNER JOIN pl_dic_categorygroup k
    ON k.categorygroupno = d.categorygroupno
 INNER JOIN asnordered ad
    ON a.asn_id = ad.asn_id
 INNER JOIN ordered t
    ON ad.ord_id = t.ord_id
  LEFT JOIN users c
    ON a.operatorid = c.userid
  LEFT JOIN (SELECT DISTINCT p.ratioid, p.rationame
               FROM nsfdata.sizeratio4shoes p) q
    ON q.ratioid = t.ratioid
 WHERE a.asn_id = %asn_id%
   AND t.sample_ord = 1
 GROUP BY ad.ord_id,
          a.asn_id,
          a.pack_no,
          a.pack_barcode,
          a.pack_specs_send,
          --a.Ratioid,
          q.rationame,
          a.goo_id,
          d.specs,
          cate.bra_name,
          j.cusgroupname,
          k.categorygroup,
          e.categories,
          f.subcategory,
          a.createtime,
          a.updatetime,
          c.username,
          a.memo
 ORDER BY pack_barcode ASC) v]'';
 @strresult := v_sql;
END;
}';
UPDATE bw3.sys_item_list t SET t.select_sql = v_sql WHERE t.item_id = 'a_asn_224_sup';
END;
/
