DECLARE
v_sql CLOB;
BEGIN
  v_sql := '{
DECLARE
  v_cate           VARCHAR2(128);
  v_procate        VARCHAR2(256);
  v_subcate        VARCHAR2(512);
  v_sql            CLOB;
  v_ask_record_id  VARCHAR2(32);
  v_factory_ask_id VARCHAR2(32);
BEGIN
  --获取asscoiate请求参数
  v_ask_record_id := pkg_plat_comm.f_get_rest_val_method_params(p_character => %ass_ask_record_id%,
                                                                p_rtn_type  => 1);

  SELECT MAX(t.factory_ask_id)
    INTO v_factory_ask_id
    FROM scmdata.t_factory_ask t
   WHERE t.ask_record_id = v_ask_record_id
     AND t.company_id = %default_company_id%
   ORDER BY t.create_date DESC;

  v_factory_ask_id := nvl(v_factory_ask_id, :factory_ask_id);

  IF v_factory_ask_id IS NULL THEN
    v_sql := ''SELECT SUPPLIER_INFO_ID      AR_RELA_SUPPLIER_ID_N,
       SUPPLIER_COMPANY_NAME RELA_SUPPLIER_ID_DESC
  FROM SCMDATA.T_SUPPLIER_INFO
 WHERE COMPANY_ID =%DEFAULT_COMPANY_ID%
   AND STATUS = 1'';

  ELSIF v_factory_ask_id IS NOT NULL AND :ar_cooperation_model_y = ''OF'' THEN
    SELECT listagg(cooperation_classification, '';'') within GROUP(ORDER BY 1),
           listagg(a.cooperation_product_cate, '';'') within GROUP(ORDER BY 1),
           listagg(a.cooperation_subcategory, '';'') within GROUP(ORDER BY 1)
      INTO v_cate, v_procate, v_subcate
      FROM scmdata.t_ask_scope a
     WHERE a.object_id IN (SELECT T.ASK_RECORD_ID
         FROM SCMDATA.T_FACTORY_ASK T
        WHERE T.FACTORY_ASK_ID = v_factory_ask_id) 
       AND a.company_id = %default_company_id%;

    v_sql := q''[SELECT DISTINCT A.SUPPLIER_INFO_ID      AR_RELA_SUPPLIER_ID_N,
       A.SUPPLIER_COMPANY_NAME RELA_SUPPLIER_ID_DESC
  FROM SCMDATA.T_SUPPLIER_INFO A
  INNER JOIN SCMDATA.T_COOP_SCOPE B ON A.SUPPLIER_INFO_ID=B.SUPPLIER_INFO_ID AND A.COMPANY_ID=B.COMPANY_ID
 WHERE A.COMPANY_ID = %default_company_id%
   AND A.pause <> 1
   AND A.STATUS = 1
   AND B.PAUSE = 0
   AND A.COOPERATION_MODEL <> ''OF''
   AND INSTR('';''||'']'' || v_cate || q''[''||'';'','';''||B.COOP_CLASSIFICATION||'';'')>0
   AND SCMDATA.INSTR_PRIV('']'' || v_procate ||
             q''['', B.COOP_PRODUCT_CATE) >0
   AND SCMDATA.INSTR_PRIV('']'' || v_subcate ||
             q''['',B.COOP_SUBCATEGORY) >0 ]'';
  END IF;
  @strresult := v_sql;
END;
}';
UPDATE bw3.sys_look_up t SET t.look_up_sql = v_sql WHERE t.element_id = 'lookup_a_coop_150_3_0'; 
END;
/
