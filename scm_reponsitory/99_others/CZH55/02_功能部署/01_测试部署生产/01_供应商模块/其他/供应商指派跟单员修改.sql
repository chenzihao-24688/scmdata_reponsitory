DECLARE
v_sql CLOB;
BEGIN
  v_sql := '{DECLARE
  v_query_sql CLOB;
  v_flag      NUMBER;
BEGIN
  SELECT COUNT(DISTINCT coop_classification) INTO v_flag
  FROM (SELECT listagg(DISTINCT sa.coop_classification, '';'') within GROUP(ORDER BY sa.coop_classification) coop_classification
          FROM scmdata.t_supplier_info sp
          LEFT JOIN scmdata.t_coop_scope sa
            ON sa.company_id = sp.company_id
           AND sa.supplier_info_id = sp.supplier_info_id
           AND sa.pause = 0
         WHERE sp.supplier_info_id IN (@selection)
         GROUP BY sp.supplier_info_id);
  IF v_flag > 1 THEN
  raise_application_error(-20002,
                                ''所选供应商的合作分类不一致,指派跟单员失败！'');
  ELSE
     @strresult := '''';                                                         
  END IF;
END;}';

UPDATE bw3.sys_param_list t SET t.default_sql = v_sql WHERE t.param_name = 'FLW_ORDER' ;

END;
