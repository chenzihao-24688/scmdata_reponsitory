DECLARE
  --czh add data privs
  data_privs_arrs scmdata.pkg_data_privs.data_privs_tab := scmdata.pkg_data_privs.data_privs_tab();
  v_dflag         NUMBER;
  --�ֲ�Ȩ��ȫ�ֱ���
  coop_data_class_item_id VARCHAR(2000);
  coop_data_class_privs   VARCHAR(2000);
  coop_type_priv          VARCHAR2(256);
  coop_class_priv         VARCHAR2(256);
  --�ֿ�
  store_item_id VARCHAR(2000);
  store_privs   VARCHAR(2000);
  store_priv    VARCHAR2(256);
  p_sql         CLOB;
  lvalue        VARCHAR2(32) := 'a972dd1ffe3b3a10e0533c281cac8fd7';
  luser_id      VARCHAR2(32) := 'CZH';
BEGIN
  v_dflag := scmdata.pkg_data_privs.check_is_data_privs(p_company_id => lvalue,
                                                        p_user_id    => luser_id);
  IF v_dflag > 0 THEN
    data_privs_arrs := scmdata.pkg_data_privs.get_privs_var(p_company_id => lvalue,
                                                            p_user_id    => luser_id);
    --�ֲ�
    scmdata.pkg_data_privs.get_golbal_data_privs(p_level_type    => 'CLASS_TYPE',
                                                 data_privs_arrs => data_privs_arrs,
                                                 po_item_id      => coop_data_class_item_id,
                                                 po_col          => coop_data_class_privs);
    --�ֿ�
    scmdata.pkg_data_privs.get_golbal_data_privs(p_level_type    => 'COMPANY_STORE_TYPE',
                                                 data_privs_arrs => data_privs_arrs,
                                                 po_item_id      => store_item_id,
                                                 po_col          => store_privs);
  
    --��ȡ�ֲ�Ȩ���ֶ�
    coop_type_priv  := scmdata.pkg_data_privs.get_strarraystrofindex(coop_data_class_privs,
                                                                     ',',
                                                                     0);
    coop_class_priv := scmdata.pkg_data_privs.get_strarraystrofindex(coop_data_class_privs,
                                                                     ',',
                                                                     1);
    --��ȡ�ֿ�Ȩ���ֶ�
    store_priv := scmdata.pkg_data_privs.get_strarraystrofindex(store_privs,
                                                                ',',
                                                                7);
  
    p_sql := p_sql || 'union all' || chr(13) || chr(10) ||
             'select ''coop_data_class_item_id'',''������������Ȩ��ITEM_ID'',''' ||
             coop_data_class_item_id || ''' from dual' || chr(13) ||
             chr(10);
    p_sql := p_sql || 'union all' || chr(13) || chr(10) ||
             'select ''coop_type_priv'',''��������'',''' || coop_type_priv ||
             ''' from dual' || chr(13) || chr(10);
    p_sql := p_sql || 'union all' || chr(13) || chr(10) ||
             'select ''coop_class_priv'',''��������'',''' || coop_class_priv ||
             ''' from dual' || chr(13) || chr(10);
  
    p_sql := p_sql || 'union all' || chr(13) || chr(10) ||
             'select ''store_item_id'',''�ֿ�����Ȩ��ITEM_ID'',''' ||
             store_item_id || ''' from dual' || chr(13) || chr(10);
    p_sql := p_sql || 'union all' || chr(13) || chr(10) ||
             'select ''store_priv'',''�ֿ�����Ȩ��'',''' || store_priv ||
             ''' from dual' || chr(13) || chr(10);
  ELSE
    NULL;
  END IF;
  dbms_output.put_line(p_sql);
END;
