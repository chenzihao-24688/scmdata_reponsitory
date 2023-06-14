DECLARE
  v_str1 VARCHAR2(2000) := 'PRODUCT_TYPE,00;01';
  --合作类型
  v_str3 VARCHAR2(2000) := 'PRODUCT_TYPE';
  --合作分部
  v_str4 VARCHAR2(2000) := '00;01';
  --权限字段
  v_str2       VARCHAR2(2000) := 'PRODUCT_TYPE,00;01,,,,,,,,';
  v_coop_type  VARCHAR2(32);
  v_coop_class VARCHAR2(32);
  v_count      NUMBER := 0;
  v_count1     NUMBER := 0;

BEGIN
  --获取某个权限字段
  v_coop_type := scmdata.pkg_data_privs.get_strarraystrofindex(v_str2,
                                                               ',',
                                                               0);

  v_coop_class := scmdata.pkg_data_privs.get_strarraystrofindex(v_str2,
                                                                ',',
                                                                1);
  --权限比较
  v_count := scmdata.pkg_data_privs.instr_priv(p_str1  => v_str3,
                                               p_str2  => v_coop_type,
                                               p_split => '');

  dbms_output.put_line(v_count);

  v_count1 := scmdata.pkg_data_privs.instr_priv(p_str1  => v_str4,
                                                p_str2  => v_coop_class,
                                                p_split => '');

  dbms_output.put_line(v_count1);
END;
