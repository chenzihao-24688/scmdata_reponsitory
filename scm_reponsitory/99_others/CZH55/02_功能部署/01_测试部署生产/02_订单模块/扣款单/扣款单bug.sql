DECLARE
  v_sql CLOB;
BEGIN
  v_sql := q'[
DECLARE
BEGIN
  IF :adjust_price IS NOT NULL THEN
    IF :adjust_reason IS NULL THEN
      raise_application_error(-20002, '调整金额有值时，调整理由不能为空');
    ELSE
      UPDATE scmdata.t_deduction td
         SET td.adjust_price          = round(:adjust_price, 2),
             td.adjust_reason         = :adjust_reason,
             td.update_id             = :user_id,
             td.update_time           = SYSDATE,
             td.actual_discount_price = decode(sign(:old_discount_price +
                                                    :adjust_price),
                                               -1,
                                               0,
                                               round((:old_discount_price +
                                                     :adjust_price),
                                                     2))
       WHERE td.deduction_id = :deduction_id;
    END IF;
  ELSE
    UPDATE scmdata.t_deduction td
       SET td.adjust_price  = NULL,
           td.adjust_reason = :adjust_reason,
           td.update_id     = :user_id,
           td.update_time   = SYSDATE,
           td.actual_discount_price = decode(sign(:old_discount_price +
                                                    nvl(:adjust_price,0)),
                                               -1,
                                               0,
                                               round((:old_discount_price +
                                                     nvl(:adjust_price,0)),
                                                     2))
     WHERE td.deduction_id = :deduction_id; 
  END IF;
END;
]';
  UPDATE bw3.sys_item_list t
     SET t.update_sql = v_sql
   WHERE t.item_id = 'a_product_130_3';
END;
