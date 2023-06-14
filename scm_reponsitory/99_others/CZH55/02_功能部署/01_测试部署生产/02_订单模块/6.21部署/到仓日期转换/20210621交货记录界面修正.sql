declare
p_select_sql clob:='SELECT t.delivery_record_id,
       t.company_id,
       t.order_code         order_code_pr,
       t.goo_id             goo_id_pr,     
       t.asn_id,
       t.predict_delivery_amount,
       t.delivery_origin_amount,
       t.delivery_amount         delivery_amount_kr,
       
       t.DELIVERY_ORIGIN_TIME,
       t.delivery_date           delivery_time_pr,
       t.accept_date,
       t.sorting_date,
       t.shipment_date,
       :progress_status_pr       progress_status_pr
  FROM t_delivery_record t
 WHERE t.company_id = %default_company_id%
   AND t.order_code = :order_id_pr
   AND t.goo_id = :goo_id_pr';
begin
  update bw3.sys_item_list a set a.select_sql=p_select_sql where a.item_id='a_product_112';
end;
/
begin
  update bw3.sys_field_list a set a.caption ='到仓确认时间',a.display_format='yyyy-MM-dd' where a.field_name='DELIVERY_TIME_PR';
end;
/
begin
insert into bw3.sys_field_list (FIELD_NAME, CAPTION, REQUIERED_FLAG, INPUT_HINT, VALID_CHARS, INVALID_CHARS, CHECK_EXPRESS, CHECK_MESSAGE, READ_ONLY_FLAG, NO_EDIT, NO_COPY, NO_SUM, NO_SORT, ALIGNMENT, MAX_LENGTH, MIN_LENGTH, DISPLAY_WIDTH, DISPLAY_FORMAT, EDIT_FORMT, DATA_TYPE, MAX_VALUE, MIN_VALUE, DEFAULT_VALUE, IME_CARE, IME_OPEN, VALUE_LISTS, VALUE_LIST_TYPE, HYPER_RES, MULTI_VALUE_FLAG, TRUE_EXPR, FALSE_EXPR, NAME_RULE_FLAG, NAME_RULE_ID, DATA_TYPE_FLAG, ALLOW_SCAN, VALUE_ENCRYPT, VALUE_SENSITIVE, OPERATOR_FLAG, VALUE_DISPLAY_STYLE, TO_ITEM_ID, VALUE_SENSITIVE_REPLACEMENT)
values ('DELIVERY_ORIGIN_TIME', '到仓时间', 1, null, null, null, null, null, 0, 0, 0, null, 0, 0, null, null, null, 'yyyy-MM-dd HH:mm:ss', null, '12', null, null, null, 0, 0, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);
end;
/
