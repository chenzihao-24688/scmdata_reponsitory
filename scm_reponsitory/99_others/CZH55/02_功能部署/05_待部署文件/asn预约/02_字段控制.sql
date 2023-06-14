DECLARE
v_sql CLOB;
v_sql1 CLOB;
BEGIN
v_sql := 'SELECT i.Ord_Id Orderid,
       a.Asn_Id Asn_Ids,
       a.Goo_Id rela_goo_id,
       b.Specs style_number,
       j.Sup_Name ,
       g.Pcomedate Pcome_date_panda,
       g.time_interval,
       Nn.Deliverdate LATEST_DELIVERY_DATE,
       a.Orderamount Order_amount,
       a.Gotamount DELIVERY_AMOUNT_DR,
       a.Orderamount - a.Gotamount OWE_AMOUNT_PR,
       a.Pcomeamount,
       a.Pack_Specs_Send,
       A.product_date,
       A.limit_use_date,
       A.batchno,
       q.Rationame RATIONAME_00000,
       i.Send_By_Sup SEND_BY_SUP_BOOL,
       i.Isfirstordered,
       a.Urgency,
       a.Is_Qc_Required,
       b.Goo_Name,
       cate.bra_name,
       c.Cusgroupname,
       d.Categorygroup,
       e.Categories,
       f.Subcategory,
       b.season,
       a.Memo,
       Nvl(k.Username, o.Sup_Name) OPER_USER_MEMBER,
       g.createtime,
       --Nn.Inprice,
      -- a.Orderamount * Nn.Inprice Ordermoney,
       /*Case When T1.effective_Days > (
       Case When T2.limit_Use_Date Is Null Then Ceil(b.shelf_Life - (Trunc(Sysdate) - T2.product_date))
       Else Ceil(T2.limit_Use_Date - Trunc(Sysdate)) End) Then 1 Else 0 End ISPASS,*/
       a.Asn_Id || a.Goo_Id Keyid,
       g.Operatorid,
       va.asn_items_cnt
  FROM Asnorders a
 INNER JOIN Goods b
    ON a.Goo_Id = b.Goo_Id
    INNER join nsfdata.branch cate
  on cate.bra_id=b.Bra_Id
  INNER JOIN Pl_Dic_Cusgroups c
    ON b.Cusgroupno = c.Cusgroupno
  INNER JOIN Pl_Dic_Categorygroup d
    ON b.Categorygroupno = d.Categorygroupno
  INNER JOIN Pl_Dic_Category e
    ON b.Categoryno = e.Categoryno
  INNER JOIN Pl_Dic_Subcategory f
    ON b.Subcategoryno = f.Subcategoryno
 INNER JOIN Asnordered g
    ON a.Asn_Id = g.Asn_Id
 INNER JOIN Ordered i
    ON g.Ord_Id = i.Ord_Id
 INNER JOIN Orders Nn
    ON i.Ord_Id = Nn.Ord_Id
   AND a.Goo_Id = Nn.Goo_Id
--211203 BY 589 INNERjoin T2
  Left Join Goodsofinspect T2
    On T2.GOO_ID = B.GOO_ID
   And T2.SUP_ID = B.SUP_ID
   AND T2.BATCHNO = A.BATCHNO
--211203 BY 589 leftjoin T1
  Left Join Goods_Expand T1
    On B.goo_Id = T1.Goo_Id
  LEFT JOIN Supplier j
    ON i.Sup_Id = j.Sup_Id
  LEFT JOIN Users k
    ON g.Operatorid = k.Userid
  LEFT JOIN Supplier o
    ON g.Operatorid = o.Sup_Id
  Left Join (Select Distinct p.Ratioid, P.RATIONAME From Nsfdata.Sizeratio4shoes p) Q ON q.Ratioid = i.Ratioid
  LEFT JOIN (SELECT t.asn_id,COUNT(1) asn_items_cnt from Nsfdata.Asnordersitem t GROUP BY t.asn_id) va ON va.asn_id = a.asn_id
 WHERE g.Finishtime IS NULL
--AND i.Sho_Id = %Sho_Id%
--AND i.Bra_Id = %Bra_Id%
{declare
v_order_id varchar2(32):=:Ord_Id;
v_sql varchar2(100):='''';
begin
  if v_order_id is not null then 
    v_sql :='' and g.ORD_ID=:ord_id'';
  end if;
  @strresult  := v_sql;
end;
}
 and (%is_company_admin% = 1 or instr(
{declare v_class_data_privs clob;
begin
  v_class_data_privs := pkg_data_privs.parse_json(p_jsonstr => %data_privs_json_strs%,
                                                  p_key     => ''COL_2'');
  @strresult         := '''''''' || v_class_data_privs || '''''''';
end;
}, i.bra_id) > 0) AND i.Finishtime IS NULL
--Order By a.Asn_Id
order by Pcome_date_panda asc,Asn_Ids asc';

v_sql1 := q'[DECLARE
  p_i            INT;
  v_productdate  DATE := to_date(:product_date, 'yyyy-mm-dd');
  v_limitusedate DATE := to_date(:limit_use_date, 'yyyy-mm-dd');
BEGIN
  SELECT nvl(MAX(1), 0)
    INTO p_i
    FROM asnordered
   WHERE asn_id = :old_asn_ids
     AND operatorid = %inner_user_id%;

  IF p_i = 0 THEN
    raise_application_error(-20002, '不可修改操作员非本人的单据');
  END IF;

  UPDATE asnorders
     SET pack_specs_send = :pack_specs_send,
         batchno         = :batchno,
         product_date    = decode(:batchno, NULL, NULL, v_productdate),
         limit_use_date  = decode(:batchno, NULL, NULL, v_limitusedate),
         memo            = :memo,
         is_qc_required  = :is_qc_required,
         urgency         = :urgency,
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
UPDATE bw3.sys_item_list t SET t.select_sql = v_sql,t.update_sql = v_sql1,t.noshow_fields = 'KEYID,OPERATORID,ASN_ITEMS_CNT' WHERE t.item_id = 'a_asn_215'; 
END;
/
BEGIN
insert into bw3.sys_element (ELEMENT_ID, ELEMENT_TYPE, DATA_SOURCE, PAUSE, MESSAGE, IS_HIDE, MEMO, IS_ASYNC, IS_PER_EXE, ENABLE_STAND_PERMISSION)
values ('control_a_asn_215_1', 'control', 'oracle_scmdata', 0, null, null, null, null, null, null);

insert into bw3.sys_field_control (ELEMENT_ID, FROM_FIELD, CONTROL_EXPRESS, CONTROL_FIELDS, CONTROL_TYPE)
values ('control_a_asn_215_1', 'ASN_ITEMS_CNT', '''{{ASN_ITEMS_CNT}}''==0', 'PCOMEAMOUNT', 0);

insert into bw3.sys_item_element_rela (ITEM_ID, ELEMENT_ID, SEQ_NO, PAUSE, LEVEL_NO)
values ('a_asn_215', 'control_a_asn_215_1', 1, 0, null);

insert into bw3.sys_item_element_rela (ITEM_ID, ELEMENT_ID, SEQ_NO, PAUSE, LEVEL_NO)
values ('a_asn_215_sup', 'control_a_asn_215_1', 1, 0, null);
END;
/
