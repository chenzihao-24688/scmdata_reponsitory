???prompt Importing table nbw.sys_look_up...
set feedback off
set define off
insert into nbw.sys_look_up (ELEMENT_ID, FIELD_NAME, LOOK_UP_SQL, DATA_TYPE, KEY_FIELD, RESULT_FIELD, BEFORE_FIELD, SEARCH_FLAG, MULTI_VALUE_FLAG, DISABLED_FIELD, GROUP_FIELD, VALUE_SEP, ICON, PORT_ID, PORT_SQL)
values ('look_a_product_118_5', 'DEDUCTION_METHOD_DESC', '
/*{DECLARE
  v_clob CLOB;
  v_anomaly_class varchar2(100);
BEGIN
  select t.anomaly_class into v_anomaly_class from scmdata.t_abnormal t where t.company_id = %default_company_id% and t.abnormal_id = :ABNORMAL_ID;
  IF v_anomaly_class IS NULL THEN
    NULL;
  ELSE
    IF v_anomaly_class = ''AC_OTHERS'' THEN
      v_clob := q''[SELECT a.group_dict_value deduction_method_pr,
           a.group_dict_name  deduction_method_desc
      FROM scmdata.sys_group_dict a
     WHERE a.group_dict_type = ''DEDUCTION_METHOD''
          AND a.group_dict_value <> ''METHOD_00''
       AND a.pause = 0]'';
    ELSE
      v_clob := q''[SELECT a.group_dict_value deduction_method_pr,
           a.group_dict_name  deduction_method_desc
      FROM scmdata.sys_group_dict a
     WHERE a.group_dict_type = ''DEDUCTION_METHOD''
          AND a.group_dict_value <> ''METHOD_02''
       AND a.pause = 0]'';
    END IF;
  END IF;
  @strresult := v_clob;
END;
}*/

SELECT a.group_dict_value deduction_method_pr,
       a.group_dict_name  deduction_method_desc
  FROM scmdata.sys_group_dict a
 WHERE a.group_dict_type = ''DEDUCTION_METHOD''
   --AND a.group_dict_value <> ''METHOD_02''
   AND a.pause = 0
ORDER BY a.group_dict_value', '1', 'DEDUCTION_METHOD_PR', 'DEDUCTION_METHOD_DESC', 'DEDUCTION_METHOD_PR', 0, 0, '0', null, null, null, null, null);

prompt Done.
