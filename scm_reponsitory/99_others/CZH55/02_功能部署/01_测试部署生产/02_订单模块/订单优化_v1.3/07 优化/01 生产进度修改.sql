DECLARE
  v_sql CLOB;
BEGIN
  v_sql := '{DECLARE
  v_sql   CLOB;
  v_cate  VARCHAR2(2000);
  v_pcate VARCHAR2(2000);
  v_scate VARCHAR2(2000);
BEGIN
  v_sql := q''[SELECT a.group_dict_value progress_status_pr,
                     a.group_dict_name  progress_status_desc
               FROM scmdata.sys_group_dict a
              WHERE a.group_dict_type = ''PROGRESS_TYPE''
               AND a.group_dict_value in( ''00'',''01'')
              UNION ALL
             SELECT pv.progress_value progress_status_pr,
                    pv.progress_name  progress_status_desc
              FROM v_product_progress_status pv
            WHERE pv.company_id = %default_company_id%]'';

  IF :product_gress_id IS NOT NULL THEN
    SELECT MAX(a.category), MAX(a.product_cate), MAX(a.samll_category)
      INTO v_cate, v_pcate, v_scate
      FROM scmdata.t_production_progress t
     INNER JOIN scmdata.t_commodity_info a
        ON a.goo_id = t.goo_id
       AND a.company_id = t.company_id
     WHERE t.product_gress_id = :product_gress_id;

    v_sql := q''[SELECT a.progress_node_name PROGRESS_STATUS_PR, a.progress_node_desc PROGRESS_STATUS_DESC
    FROM scmdata.t_progress_range_config t
   INNER JOIN scmdata.t_progress_node_config a
      ON a.progress_config_id = t.progress_config_id
     AND a.company_id = t.company_id
     AND a.pause = 0
     AND t.pause = 0
   WHERE t.industry_classification = '']'' || v_cate || q''[''
     AND t.production_category = '']'' || v_pcate || q''[''
     AND instr('';'' || t.product_subclass || '';'' , '';'' || '']'' || v_scate ||
             q''['' || '';'') > 0
     AND t.company_id = %default_company_id%
   ORDER BY a.progress_node_num ASC]'';
  END IF;
  @strresult := v_sql;
END;
}';
  UPDATE bw3.sys_look_up t
     SET t.look_up_sql = v_sql
   WHERE t.element_id = 'look_a_product_110_10';
END;
/ 
DECLARE v_sql CLOB;
BEGIN
  v_sql := '{DECLARE
  v_sql             CLOB;
  v_cate            VARCHAR2(2000);
  v_pcate           VARCHAR2(2000);
  v_scate           VARCHAR2(2000);
  v_need_company_id VARCHAR2(32);
BEGIN
  SELECT DISTINCT oh.company_id
    INTO v_need_company_id
    FROM scmdata.t_ordered oh
   INNER JOIN (SELECT c.company_id, c.company_name, b.supplier_code
                 FROM scmdata.t_supplier_info b
                INNER JOIN scmdata.sys_company c
                   ON b.company_id = c.company_id
                WHERE b.supplier_company_id = %default_company_id%) d
      ON oh.company_id = d.company_id
     AND oh.supplier_code = d.supplier_code;
  v_sql := q''[SELECT a.group_dict_value progress_status_pr,
                     a.group_dict_name  progress_status_desc
               FROM scmdata.sys_group_dict a
              WHERE a.group_dict_type = ''PROGRESS_TYPE''
               AND a.group_dict_value in( ''00'',''01'')
              UNION ALL
             SELECT pv.progress_value progress_status_pr,
                    pv.progress_name  progress_status_desc
              FROM v_product_progress_status pv
            WHERE pv.company_id = '']'' || v_need_company_id || q''['']'';
            
  /* v_sql := q''[SELECT b.company_dict_name category,c.company_dict_value PROGRESS_STATUS_PR,
       c.company_dict_name  PROGRESS_STATUS_DESC
  FROM scmdata.sys_group_dict a
 INNER JOIN scmdata.sys_company_dict b
    ON b.company_dict_type = a.group_dict_value
    AND a.pause = 0
    AND b.pause = 0
 INNER JOIN scmdata.sys_company_dict c
    ON c.company_dict_type = b.company_dict_value
   AND c.company_id = b.company_id
   AND c.pause = 0
 WHERE a.group_dict_type = ''PROGRESS_TYPE''
   AND a.group_dict_value = ''02''
   AND b.company_id = '']'' || v_need_company_id || q''[''
  ORDER BY c.company_dict_value asc]'';*/

  IF :product_gress_id IS NOT NULL THEN
    SELECT MAX(a.category), MAX(a.product_cate), MAX(a.samll_category)
      INTO v_cate, v_pcate, v_scate
      FROM scmdata.t_production_progress t
     INNER JOIN scmdata.t_commodity_info a
        ON a.goo_id = t.goo_id
       AND a.company_id = t.company_id
     WHERE t.product_gress_id = :product_gress_id;

    v_sql := q''[SELECT a.progress_node_name PROGRESS_STATUS_PR, a.progress_node_desc PROGRESS_STATUS_DESC
    FROM scmdata.t_progress_range_config t
   INNER JOIN scmdata.t_progress_node_config a
      ON a.progress_config_id = t.progress_config_id
     AND a.company_id = t.company_id
     AND a.pause = 0
     AND t.pause = 0
   WHERE t.industry_classification = '']'' || v_cate || q''[''
     AND t.production_category = '']'' || v_pcate || q''[''
     AND instr('';'' || t.product_subclass || '';'' , '';'' || '']'' || v_scate ||
             q''['' || '';'') > 0
     AND t.company_id = '']'' || v_need_company_id || q''[''
   ORDER BY a.progress_node_name ASC]'';
  END IF;
  @strresult := v_sql;
END;}';
  UPDATE bw3.sys_look_up t
     SET t.look_up_sql = v_sql
   WHERE t.element_id = 'look_a_product_210_10';
END;
