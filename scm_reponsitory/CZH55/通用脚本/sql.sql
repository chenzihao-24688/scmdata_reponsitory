SELECT a.sub_ord_id,
       d.tb_ord_id,
       (CASE
         WHEN f.wx_shareid IS NOT NULL THEN
          '��'
         ELSE
          '��'
       END) is_wx_share,
       b.username operator,
       d.cus_memo,
       d.cusservicememo,
       a.deal_id,
       (CASE
         WHEN a.finishtime IS NOT NULL AND a.deal_id IS NULL THEN
          '��'
         ELSE
          '��'
       END) all_lack,
       a.rem_id,
       a.courier_name,
       a.logisticcorpno,
       a.logisticno,
       a.logprice,
       a.logpricetime,
       e.mallname,
       a.createtime,
       d.consignee,
       d.mobile mobile1,
       d.telephone,
       d.postcode,
       d.province,
       d.city,
       d.county,
       d.address,
       nvl(c.username, 'SYSTEM') creator,
       a.finishtime,
       a.memo,
       a.ord_id,
       a.logisticstatus,
       to_char(substr(REPLACE(REPLACE(REPLACE(a.logisticdetail, '##', ' '),
                                      '**',
                                      chr(13) || chr(10)),
                              'null',
                              ''),
                      1,
                      2000)) logisticdetail,
       a.logistic_updatetime,
       '��' change_flag
  FROM net_order_shops a
 INNER JOIN net_order d
    ON a.ord_id = d.ord_id
 INNER JOIN net_orders f
    ON a.ord_id = f.ord_id
 INNER JOIN net_dic_mall e
    ON d.mallid = e.mallid
  LEFT JOIN users b
    ON a.operatorid = b.userid
  LEFT JOIN users c
    ON nvl(a.createrid, ' ') = c.userid
 WHERE (a.sho_id = '31593' OR
       (a.sho_id = 'GZW' AND '31593' IN ('31593', '34019')) OR
       (a.sho_id = '9930' AND '31593' = '70397'))
   AND (a.finishtime IS NOT NULL)
   AND (d.sendtype IN (2))
   AND (a.finishtime > = add_months(SYSDATE, -2))
UNION
SELECT a.sub_ord_id,
       d.tb_ord_id,
       '��' is_wx_share,
       b.username operator,
       d.cus_memo,
       d.cusservicememo,
       a.deal_id,
       (CASE
         WHEN a.finishtime IS NOT NULL AND a.deal_id IS NULL THEN
          '��'
         ELSE
          '��'
       END) all_lack,
       a.rem_id,
       a.courier_name,
       a.logisticcorpno,
       a.logisticno,
       a.logprice,
       a.logpricetime,
       e.mallname,
       a.createtime,
       d.consignee,
       d.mobile mobile1,
       d.telephone,
       d.postcode,
       d.province,
       d.city,
       d.county,
       d.address,
       nvl(c.username, 'SYSTEM') creator,
       a.finishtime,
       a.memo,
       a.ord_id,
       a.logisticstatus,
       to_char(substr(REPLACE(REPLACE(REPLACE(a.logisticdetail, '##', ' '),
                                      '**',
                                      chr(13) || chr(10)),
                              'null',
                              ''),
                      1,
                      2000)) logisticdetail,
       a.logistic_updatetime,
       '��' change_flag
  FROM net_change_shops a
 INNER JOIN net_change d
    ON a.ord_id = d.ord_id
 INNER JOIN net_changes f
    ON a.ord_id = f.ord_id
 INNER JOIN net_dic_mall e
    ON d.mallid = e.mallid
  LEFT JOIN users b
    ON a.operatorid = b.userid
  LEFT JOIN users c
    ON nvl(a.createrid, ' ') = c.userid
 WHERE (a.sho_id = '31593' OR
       (a.sho_id = 'GZW' AND '31593' IN ('31593', '34019')) OR
       (a.sho_id = '9930' AND '31593' = '70397'))
   AND (a.finishtime IS NOT NULL)
   AND (d.sendtype IN (2))
   AND (a.finishtime > = add_months(SYSDATE, -2))
   AND (NOT EXISTS (SELECT 1
                      FROM net_refund
                     WHERE return_ord_id = d.ord_id
                       AND in_orderstatusid NOT IN (24, 25)
                       AND is_changereturn = 1));
