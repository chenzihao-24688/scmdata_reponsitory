DECLARE
v_sql1 CLOB;
v_sql2 CLOB;
BEGIN
  v_sql1 := 'SELECT ''1'' VALUE,''全部'' NAME FROM DUAL';
  v_sql2 := 'SELECT ''1'' VALUE,''全部'' NAME
  FROM DUAL
UNION ALL
SELECT a.group_config_id VALUE, a.group_name NAME
  FROM scmdata.t_supplier_group_config a
 WHERE a.group_config_id IN (SELECT t.group_name
                               FROM scmdata.pt_ordered t
                              WHERE t.company_id = %default_company_id%
                                AND t.group_name IS NOT NULL
                              GROUP BY t.group_name)';
  UPDATE bw3.sys_param_list t SET t.default_sql = v_sql1,t.value_sql = v_sql2 WHERE t.param_name = 'ABN_GROUP';
END;
/
