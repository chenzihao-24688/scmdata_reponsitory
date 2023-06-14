DECLARE
v_sql CLOB;
BEGIN
v_sql := q'[{
DECLARE
  v_sql             CLOB;
  v_ask_record_id   VARCHAR2(32);
  v_rest_method     VARCHAR2(256);
  v_params          VARCHAR2(2000);
  v_is_show_element VARCHAR2(32);
BEGIN
  --获取asscoiate请求参数
  pkg_plat_comm.p_get_rest_val_method_params(p_character     => %ass_ask_record_id%,
                                             po_pk_id        => v_ask_record_id,
                                             po_rest_methods => v_rest_method,
                                             po_params       => v_params);
  v_is_show_element := plm.pkg_plat_comm.parse_json(p_jsonstr => v_params,
                                                    p_key     => 'is_show_element');
  v_is_show_element := nvl(v_is_show_element, 1);
  IF v_is_show_element = 1 THEN
    v_sql := 'select max(1) from dual';
  ELSE
    v_sql := 'select max(0) from dual';
  END IF;
  ]'||CHR(64)||q'[strresult        := v_sql;
END;
}]';

UPDATE bw3.sys_cond_list t SET t.cond_sql = v_sql WHERE t.cond_id = 'cond_a_coop_151'; 
END;
/
BEGIN
 UPDATE bw3.sys_field_list t SET t.alignment = 3 WHERE t.field_name = 'FA_COMPANY_NAME';
END;
/
