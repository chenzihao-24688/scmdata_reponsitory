  --czh add
  --获取编码
  --规则：前缀+日期（yyyy-mm-dd）+流水号
  FUNCTION f_get_plat_code(p_table_name VARCHAR2,
                           p_pre        VARCHAR2,
                           p_rule_str   VARCHAR2 DEFAULT SYSDATE,
                           p_rule_type  VARCHAR2 DEFAULT 'SYSDATE',
                           p_serail_num VARCHAR2) RETURN VARCHAR2 IS
    v_table_name VARCHAR2(256) := upper(p_table_name);
    v_rule_str   VARCHAR2(256) := trunc(p_rule_str);
    v_plat_code  VARCHAR2(256);
    v_flag       INT;
    v_seq_num    INT;
  BEGIN
    SELECT COUNT(1)
      INTO v_flag
      FROM plm.t_plat_table_serail t
     WHERE t.table_name = v_table_name;
  
    IF v_flag > 0 THEN
      IF p_rule_type = 'SYSDATE' THEN      
        v_seq_num := NULL;
      END IF;
      UPDATE plm.t_plat_table_serail t
         SET t.seq_num = v_seq_num + 1
       WHERE t.table_name = v_table_name;
    ELSE
      INSERT plm.t_plat_table_serail
        (id, table_name, seq_num, create_id, create_time, update_id,
         update_time, memo)
      VALUES
        (scmdata.f_get_uuid(), v_table_name, 0, 'ADMIN', SYSDATE, 'ADMIN',
         SYSDATE, NULL);
    END IF;
  
    SELECT MAX(t.seq_num)
      INTO v_seq_num
      FROM plm.t_plat_table_serail t
     WHERE t.table_name = v_table_name;
  
    v_plat_code := p_pre || v_seq_num;
  
    RETURN v_plat_code;
  END f_get_plat_code;
