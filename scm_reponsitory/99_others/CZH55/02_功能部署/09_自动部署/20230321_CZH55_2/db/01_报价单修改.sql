DECLARE
v_sql CLOB;
BEGIN
v_sql := q'[{DECLARE
  v_sql                         CLOB;
  v_methods                     VARCHAR2(256) := 'GET';
  v_params                      VARCHAR2(4000);
  v_whether_add_color_quotation VARCHAR2(256);
  v_whether_sanfu_fabric        VARCHAR2(256);
  v_quotation_classification    VARCHAR2(256);
  v_quotation_class_code        VARCHAR2(256);
  v_quotation_status            VARCHAR2(256);
BEGIN
  SELECT MAX(qt.whether_add_color_quotation),
       MAX(qt.whether_sanfu_fabric),
       MAX(qt.quotation_classification),
       MAX(qt.quotation_status)
  INTO v_whether_add_color_quotation,
       v_whether_sanfu_fabric,
       v_quotation_classification,
       v_quotation_status
  FROM plm.quotation qt
 WHERE qt.quotation_id = :quotation_id;

  --报价单关联ITEM
  --通过condlist cond_a_quotation_111_5 控制页面显示

  --跳转携带参数
  --'{"COL_1": "PRODUCT_TYPE","COL_2": "00;01","COL_3": "","COL_4": "","COL_5": "","COL_6": "","COL_7": "","COL_8": "","COL_9": "","COL_10": "","COL_11": "YWZ","COL_21": "","COL_22": ""}'
  v_params := '"whether_add_color_quotation"' || ':' || '"' ||
              v_whether_add_color_quotation || '"';

  v_params := v_params || ',' || '"whether_sanfu_fabric"' || ':' || '"' ||
              v_whether_sanfu_fabric || '"';

  v_params := v_params || ',' || '"quotation_classification"' || ':' || '"' ||
              v_quotation_classification || '"';

  v_params := v_params ||','||'"is_element_show"'||':'||'" 0 "';

  v_params := v_params ||','||'"quotation_status"'||':'||'"' || v_quotation_status|| '"';

  v_params := '{' || v_params || '}';

  v_sql      := 'select ''' || :quotation_id || '/' || v_methods || '?' ||
                v_params || ''' QUOTATION_ID from dual';
  @strresult := v_sql;
END;}]';

UPDATE bw3.sys_associate t SET t.data_sql = v_sql WHERE t.element_id = 'associate_a_quotation_211';
END;
/
