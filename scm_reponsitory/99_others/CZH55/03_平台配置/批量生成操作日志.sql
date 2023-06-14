DECLARE
  v_sql          CLOB;
  v_str          VARCHAR2(4000) := 'management_expense,development_fee,euipment_depreciation,rent_and_utilities,processing_profit,freight,design_fee';
  v_company_id   VARCHAR2(32) := 'v_company_id';
  v_apply_module VARCHAR2(32) := 'a_quotation_111_6';
  v_base_table   VARCHAR2(32) := 'quotation';
  v_apply_pk_id  VARCHAR2(32) := 'v_quotation_id';
  v_action_type  VARCHAR2(32) := 'UPDATE';
  v_log_type     VARCHAR2(32) := '06';
  v_field_desc   VARCHAR2(256);
  v_field_type   VARCHAR2(256) := 'VARCHAR';
  v_old_code     VARCHAR2(256);
  v_new_code     VARCHAR2(256);
  v_memo         VARCHAR2(256) := '02';
  v_user_id      VARCHAR2(256) := 'v_update_id';
  v_cnt          INT := 0;
BEGIN

  FOR i IN (SELECT regexp_substr(v_str, '[^' || ',' || ']+', 1, LEVEL, 'i') AS str_value
              FROM dual
            CONNECT BY LEVEL <= length(v_str) -
                       length(regexp_replace(v_str, ',', '')) + 1) LOOP
   v_cnt := v_cnt + 1;                    
  SELECT MAX(t.caption) INTO v_field_desc from nbw.sys_field_list t WHERE t.field_name = UPPER(i.str_value);
  
  v_sql := q'[
  --]'||v_field_desc||q'[
  IF scmdata.pkg_plat_log.f_is_check_fields_eq(:old.]'||i.str_value||q'[, :new.]'||i.str_value||q'[) = 0 THEN
      scmdata.pkg_plat_log.p_record_plat_log(p_company_id         => ]'||v_company_id||q'[,
                                             p_apply_module       => ']'||v_apply_module||q'[',
                                             p_base_table         => ']'||v_base_table||q'[',
                                             p_apply_pk_id        => ]'||v_apply_pk_id||q'[,
                                             p_action_type        => ']'||v_action_type||q'[',
                                             p_log_id             => vo_log_id,
                                             p_log_type           => ']'||v_log_type||q'[',
                                             p_field_desc         => ']'||v_field_desc||q'[',
                                             p_operate_field      => ']'||i.str_value||q'[',
                                             p_field_type         => ']'||v_field_type||q'[',
                                             p_old_code           => ']'||v_old_code||q'[',
                                             p_new_code           => ']'||v_new_code||q'[',
                                             p_old_value          => :old.]'||i.str_value||q'[,
                                             p_new_value          => :new.]'||i.str_value||q'[,
                                             p_memo               => ']'||v_memo||q'[',
                                             p_memo_desc          => :old.]'||i.str_value||q'[,
                                             p_user_id            => ]'||v_user_id||q'[,
                                             p_operate_company_id => v_sup_company_id,
                                             p_seq_no             => ]'||v_cnt||q'[,
                                             po_log_id            => vo_log_id);
    
    END IF;]';
    dbms_output.put_line(v_sql);
  END LOOP;
  --拼接日志明细 
 v_sql := q'[
 --拼接日志明细 
 IF vo_log_id IS NOT NULL THEN
    scmdata.pkg_plat_log.p_update_plat_logmsg(p_company_id        => ]'||v_company_id||q'[,
                                              p_log_id            => vo_log_id,
                                              p_is_logsmsg        => 1,
                                              p_is_splice_fields  => 0,
                                              p_is_show_memo_desc => 1,
                                              p_type              => 1);
  END IF;]';
  dbms_output.put_line(v_sql);
END;
