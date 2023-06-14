DECLARE
v_sql CLOB;
BEGIN
v_sql := q'[{
DECLARE
  v_sql1 CLOB;
  v_sql2 CLOB;
  v_sql  CLOB;
BEGIN
  v_sql1 := scmdata.pkg_plat_comm.f_get_lookup_sql_by_type(p_group_dict_type => 'QC_CHECK_NODE_DICT',
                                                           p_field_value     => 'CHECK_LINK',
                                                           p_field_desc      => 'CHECK_GD_LINK_DESC');
  v_sql2 := scmdata.pkg_plat_comm.f_get_lookup_sql_by_type(p_group_dict_type => 'QA_CHECKTYPE',
                                                           p_field_value     => 'CHECK_LINK',
                                                           p_field_desc      => 'CHECK_GD_LINK_DESC');

  v_sql := 'SELECT * FROM (' || v_sql1 || ') UNION ALL SELECT * FROM (' || v_sql2 || ')';
  IF :abnormal_orgin IN ('ed7ff3c7135a236ae0533c281caccd8d', 'b550778b4f2d36b4e0533c281caca074') THEN
    v_sql := v_sql1;
  ELSIF :abnormal_orgin IN ('b550778b4f3f36b4e0533c281caca074') THEN
    v_sql := v_sql2;
  ELSE
    NULL;
  END IF;
  ]'|| CHR(64) || q'[strresult := v_sql;
END;
}]';
UPDATE bw3.sys_look_up t SET t.look_up_sql = v_sql WHERE t.element_id = 'look_a_product_118_2' ;
END;
/

