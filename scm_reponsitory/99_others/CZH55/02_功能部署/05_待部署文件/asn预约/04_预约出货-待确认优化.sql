DECLARE
v_sql CLOB;
BEGIN
v_sql := q'[Select 
       --a.Sup_Id,
       --d.Sup_Name,
       --a.Goo_Id rela_goo_id,
       --b.Goo_Name,
       --f.Subcategory,
       a.Goodsid,
       a.Barcode,
       --b.Specs style_number,
       c.Colorname,
       T4.Supbarcode,
       a.Batchno,
       --a.Validdate,
       --a.Recordname,
       (case when a.attachname is not null then 'ÊÇ' else '·ñ' end) has_file,
       a.Product_Date,
       a.Limit_Use_Date
  From Goodsofinspect a
 Inner Join Goods b On a.Goo_Id = b.Goo_Id
  Left Join Articles c On a.Barcode = c.Barcode
 Inner Join Supplier d On a.Sup_Id = d.Sup_Id
 --Inner Join Users e On e.Userid = a.Operatorid
 Inner Join Pl_Dic_Subcategory f On f.Subcategoryno = b.Subcategoryno
  Left Join Sup_Barcode T4 On Nvl(c.Barcode, b.Goo_Id) = T4.Goodsid
Where (a.Limit_Use_Date >= Trunc(Sysdate) Or A.limit_Use_Date Is Null)
 /*AND Exists (Select 1
          From Asnorders T1
         Inner Join Asnordered T2
            On T1.Asn_Id = T2.Asn_Id
         Inner Join Ordered T3
            On T3.Ord_Id = T2.Ord_Id
         Where T1.Goo_Id = a.Goo_Id
           And T3.Sup_Id = a.Sup_Id
           And T1.Asn_Id || T1.Goo_Id = :KEYID)*/
 and a.goo_id=:rela_goo_id]';
UPDATE bw3.sys_pick_list t SET t.query_fields = 'BARCODE,COLORNAME,SUPBARCODE,BATCHNO',t.pick_sql = v_sql WHERE t.element_id = 'pick_a_asn_215';
END;
/
DECLARE
v_sql CLOB;
BEGIN
v_sql := q'[SELECT  a.goo_id rela_goo_id, a.barcode,c.colorname,t4.supbarcode,a.batchno,
       a.limit_use_date,a.product_date, case when a.attachname is not null then 'ÊÇ' else '·ñ' end has_file
  FROM goodsofinspect a
 INNER JOIN goods b ON a.goo_id = b.goo_id
  LEFT JOIN articles c ON a.barcode = c.barcode
 INNER JOIN supplier d ON a.sup_id = d.sup_id
 INNER JOIN pl_dic_subcategory f ON f.subcategoryno = b.subcategoryno
  LEFT JOIN sup_barcode t4 ON nvl(c.barcode, b.goo_id) = t4.goodsid
 WHERE EXISTS(SELECT 1
                FROM asnorders t1
               INNER JOIN asnordered t2 ON t1.asn_id = t2.asn_id
               INNER JOIN ordered t3 ON t3.ord_id = t2.ord_id
               WHERE t1.goo_id = a.goo_id AND t3.sup_id = a.sup_id AND t1.asn_id = %asn_id%
             )
   AND (a.limit_use_date >= trunc(SYSDATE) OR a.limit_use_date IS NULL)
   AND a.goo_id = :rela_goo_id
   AND a.barcode = :barcode]';
UPDATE bw3.sys_pick_list t SET t.query_fields = 'BARCODE,COLORNAME,SUPBARCODE,BATCHNO',t.pick_sql = v_sql WHERE t.element_id = 'pick_a_asn_m215';
END;
/
