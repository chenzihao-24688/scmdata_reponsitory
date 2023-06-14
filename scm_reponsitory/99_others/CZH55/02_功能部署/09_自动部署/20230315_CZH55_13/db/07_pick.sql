DECLARE
v_sql CLOB;
BEGIN
  v_sql := q'[--CZH 重构逻辑
{
DECLARE
  v_sql             CLOB;
  v_methods         VARCHAR2(256) := 'GET;POST;PUT;DELETE';
  v_params          VARCHAR2(4000);
  v_is_show_element INT;
BEGIN
  --跳转携带参数
  --'{"COL_1": "PRODUCT_TYPE","COL_2": "00;01","COL_3": "","COL_4": "","COL_5": "","COL_6": "","COL_7": "","COL_8": "","COL_9": "","COL_10": "","COL_11": "YWZ","COL_21": "","COL_22": ""}'
  v_params := '"is_show_element"' || ':' || '"0"';
  v_params := v_params || ',' || '"item_id"' || ':' || '"a_coop_211"';
  v_params := v_params || ',' || '"item_name"' || ':' || '"查看申请详情"';
  v_params := '{' || v_params || '}';

  v_sql      := 'select ''' || :FACTORY_ASK_ID || '/' || v_methods || '?' ||
                v_params || ''' ASK_RECORD_ID from dual';
  ]'|| CHR(64) || q'[strresult := v_sql;
END;
}]';
UPDATE bw3.sys_associate t SET t.data_sql = v_sql WHERE t.element_id = 'associate_a_coop_221' ;
END;
/
