DECLARE
  v_sql CLOB;
BEGIN
  v_sql := q'[SELECT *
  FROM plm.v_plm_quotation_class va
    WHERE va.company_id = 'b6cc680ad0f599cde0531164a8c0337f']';

  UPDATE bw3.sys_pick_list t
     SET t.pick_sql     = v_sql
   WHERE t.element_id = 'pick_a_quotation_110';
END;
/
