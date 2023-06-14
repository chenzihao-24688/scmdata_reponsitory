DECLARE
v_sql CLOB;
BEGIN
  v_sql := '{DECLARE
  v_asn_id asnordered.asn_id%TYPE;
  v_goo_id goods.goo_id%TYPE;
  p_asn_id asnordered.asn_id%TYPE;
  v_ord_id ordered.ord_id%TYPE;
  v_has_file  INT;
  p_sql    CLOB;
  p_i      NUMBER(1);
  p_a      NUMBER(1);
BEGIN
  SELECT nvl(MAX(1), 0)
    INTO p_i
    FROM asnordered a
   INNER JOIN asnorders b
      ON a.asn_id = b.asn_id
   WHERE b.asn_id || b.goo_id IN (@selection);

  IF p_i = 0 THEN
    p_sql := ''select 1 from dual'';
  ELSE
    SELECT MAX(1)
      INTO p_a
      FROM asnordered d
     INNER JOIN asnorders b
        ON d.asn_id = b.asn_id
     INNER JOIN ordered a
        ON d.ord_id = a.ord_id
     WHERE b.asn_id || b.goo_id IN (@selection)
       AND NOT EXISTS (SELECT 1
              FROM cmx_scm_order_subscribe w
             WHERE a.ord_id = w.ord_id);
    IF p_a = 1 THEN
      raise_application_error(-20002,
                              ''该订单暂未同步至scm，请稍等10分钟或检查供应商是否已在scm建档'');
    END IF;

    SELECT MAX(a.asn_id)
      INTO v_asn_id
      FROM asnordered a
     INNER JOIN asnorders b
        ON a.asn_id = b.asn_id
       AND b.asn_id || b.goo_id IN (@selection)
     WHERE ((SYSDATE >= trunc(SYSDATE) + 17 / 24 AND
           trunc(a.pcomedate) <= trunc(SYSDATE) + 1) OR
           (trunc(a.pcomedate) <= trunc(SYSDATE)));

    IF v_asn_id IS NOT NULL THEN
      raise_application_error(-20001,
                              ''每天下午5点后，ASN单据号['' || v_asn_id ||
                              '']的预约时间即[预计到货日期]只能为后天或以后！'');
    END IF;

    SELECT MAX(a.asn_id), MAX(a.goo_id)
      INTO v_asn_id, v_goo_id
      FROM asnorders a
     INNER JOIN (SELECT b.asn_id,
                        b.goo_id,
                        SUM(nvl(b.pcomeamount, 0)) pcomeamount
                   FROM asnordersitem b
                  WHERE EXISTS
                  (SELECT 1
                           FROM asnorders cc
                          WHERE cc.asn_id = b.asn_id
                            AND cc.asn_id || cc.goo_id IN (@selection))
                  GROUP BY b.asn_id, b.goo_id) bb
        ON a.goo_id = bb.goo_id
       AND a.asn_id = bb.asn_id
     WHERE EXISTS (SELECT 1
              FROM asnorders cc
             WHERE cc.asn_id = a.asn_id
               AND cc.asn_id || cc.goo_id IN (@selection))
       AND nvl(a.pcomeamount, 0) - bb.pcomeamount <> 0;
    IF v_goo_id IS NOT NULL THEN
      raise_application_error(-20001,
                              ''ASN单据号['' || v_asn_id || '']中货号['' || v_goo_id ||
                              '']的预计到货量字段在货号明细与色码明细的汇总值不相符'');
    END IF;

    FOR item1 IN (SELECT DISTINCT b.asn_id
                    FROM asnorders cc
                   INNER JOIN asnordered b
                      ON cc.asn_id = b.asn_id
                   INNER JOIN ordered d
                      ON b.ord_id = d.ord_id
                   WHERE cc.asn_id || cc.goo_id IN (@selection)
                     AND d.ratioid IS NOT NULL
                     AND d.po_type = ''PP'') LOOP
      checkratioid(item1.asn_id);
    END LOOP;

    UPDATE asnordered a
       SET a.finishtime = SYSDATE,
           a.inserttime = SYSDATE
     WHERE EXISTS (SELECT 1
              FROM asnorders cc
             WHERE cc.asn_id = a.asn_id
               AND cc.asn_id || cc.goo_id IN (@selection));

    UPDATE asnordered a
       SET a.audittime = SYSDATE,
           a.auditorid = %inner_user_id%
     WHERE EXISTS (SELECT 1
              FROM asnorders cc
             WHERE cc.asn_id = a.asn_id
               AND cc.asn_id || cc.goo_id IN (@selection));
    FOR item IN (SELECT DISTINCT a.asn_id
                   FROM asnorders a
                  WHERE a.asn_id || a.goo_id IN (@selection)) LOOP
      pautoassignasn(item.asn_id);
    END LOOP;

    p_sql := ''SELECT ao.ord_id ord_ids,
       ao.asn_id asn_ids,
       :user_id oper_user_id,
       (SELECT json_arrayagg(json_object(key ''''ORDERID'''' VALUE orderid,
                                         key ''''ASN_ID'''' VALUE asn_id,
                                         key ''''GOO_ID'''' VALUE goo_id,
                                         key ''''IS_FCL_OUT'''' VALUE is_fcl_out,
                                         key ''''IS_QC_REQUIRED'''' VALUE
                                         is_qc_required,
                                         key ''''PCOMEAMOUNT'''' VALUE pcomeamount,
                                         key ''''PCOMEDATE'''' VALUE pcomedate,
                                         key ''''FINIISHTIME'''' VALUE finishtime,
                                         key ''''ASN_LIST'''' VALUE asn_list,
                                         key ''''PACKCASES'''' VALUE packcases)
                             RETURNING CLOB)
          FROM (SELECT dd.ord_id orderid,
                       dd.asn_id,
                       ee.goo_id,
                       ee.is_fcl_out,
                       ee.is_qc_required,
                       round(ee.pcomeamount) pcomeamount,
                       dd.pcomedate,
                       dd.finishtime,
                       (SELECT listagg(e.asn_id, '''';'''') within GROUP(ORDER BY asn_id)
                          FROM nsfdata.asnordered e
                         WHERE e.ord_id = dd.ord_id
                           AND e.finishtime IS NOT NULL) asn_list,
                       nvl(e.packcount,0) packcases
                  FROM nsfdata.asnordered dd
                 INNER JOIN ordered i
                    ON dd.ord_id = i.ord_id
                 INNER JOIN nsfdata.asnorders ee
                    ON dd.asn_id = ee.asn_id
                  LEFT JOIN (SELECT  max(a.packcount) packcount,
                                            a.asn_id,
                                            a.goo_id
                              FROM nsfdata.asnorderpacks a
                              group by asn_id,goo_id) e
                    ON ee.asn_id = e.asn_id
                   AND ee.goo_id = e.goo_Id
                 WHERE EXISTS (SELECT 1
                          FROM nsfdata.cmx_scm_order_subscribe
                         WHERE ord_id = dd.ord_id)
                   AND dd.finishtime IS NOT NULL
                   AND dd.asn_id = ao.asn_id)) asn_body,
       (SELECT json_arrayagg(json_object(key ''''ORD_ID'''' VALUE ord_id,
                                         key ''''ASN_ID'''' VALUE asn_id,
                                         key ''''GOO_ID'''' VALUE goo_id,
                                         key ''''BARCODE'''' VALUE barcode,
                                         key ''''PCOMEAMOUNT'''' VALUE pcomeamount,
                                         key ''''PACKCASES'''' VALUE packcases)
                             RETURNING CLOB)
          FROM (SELECT ae.ord_id,
                       ae.asn_id,
                       ai.goo_id,
                       ai.barcode,
                       nvl(round(ai.pcomeamount),
                           round(nvl(ai.pcomeamount, 0))) pcomeamount,
                       e.skupackcount packcases
                  FROM nsfdata.asnordered ae
                 INNER JOIN nsfdata.asnordersitem ai
                    ON ai.asn_id = ae.asn_id
                  LEFT JOIN (SELECT asn_id,
                                   goodsid,
                                   MAX(skupackcount) skupackcount
                              FROM asnorderpacks
                             GROUP BY asn_id, goodsid) e
                    ON ai.asn_id = e.asn_id
                   AND ai.barcode = e.goodsid
                 WHERE EXISTS (SELECT 1
                          FROM nsfdata.cmx_scm_order_subscribe
                         WHERE ord_id = ae.ord_id)
                   AND ae.finishtime IS NOT NULL
                   AND ae.asn_id = ao.asn_id
                   AND ai.pcomeamount > 0)) asnitem_body
  FROM nsfdata.asnordered ao
 INNER JOIN nsfdata.asnorders aos
    ON ao.asn_id = aos.asn_id
 WHERE ao.asn_id || aos.goo_id IN (@selection)
   AND ao.finishtime IS NOT NULL'';
  END IF;
  @strresult := p_sql;
END;}';
UPDATE bw3.sys_action t SET t.action_sql = v_sql
 WHERE t.element_id IN ('action_a_asn_408_inf');
END;
/
