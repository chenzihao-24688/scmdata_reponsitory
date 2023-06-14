BEGIN
  DECLARE
    JUDGE_N NUMBER(4);
    EXE_SQL CLOB;
    VALS    CLOB;
  CV1 CLOB:=q'[]';
  CV2 CLOB:=q'[]';
  CV3 CLOB:=q'[--czh 重构逻辑
{DECLARE
  v_sql CLOB;
BEGIN
  v_sql      := pkg_supplier_info.f_insert_coop_factory_list(p_item_id => 'a_supp_151_7');
  @strresult := v_sql;
END;}]';
  CV4 CLOB:=q'[]';
  CV5 CLOB:=q'[]';
  CV6 CLOB:=q'[]';
  CV7 CLOB:=q'[--czh 重构逻辑
{DECLARE
  v_sql CLOB;
BEGIN
  v_sql      := pkg_supplier_info.f_query_coop_factory_list(p_item_id => 'a_supp_151_7');
  @strresult := v_sql;
END;}
--原逻辑
/*WITH dic AS
 (SELECT group_dict_value,
         group_dict_name,
         group_dict_type,
         group_dict_id,
         parent_id
    FROM scmdata.sys_group_dict)
SELECT sp.supplier_company_name,
       '本厂' cooperation_name,
       sp.pause COOP_STATE,
       sp.product_type,
       sp.product_link,
       sp.product_line,
       (SELECT listagg(b.group_dict_name, ';') within GROUP(ORDER BY b.group_dict_value)
          FROM dic t
          LEFT JOIN dic b
            ON t.group_dict_type = 'COOPERATION_BRAND'
           AND t.group_dict_id = b.parent_id
           AND instr(';' || sp.brand_type || ';',
                     ';' || t.group_dict_value || ';') > 0
           AND instr(';' || sp.cooperation_brand || ';',
                     ';' || b.group_dict_value || ';') > 0) cooperation_brand_desc
  FROM scmdata.t_supplier_info sp
 WHERE sp.company_id = %default_company_id%
   AND sp.supplier_info_id = :supplier_info_id
UNION ALL
SELECT DISTINCT sp_a.supplier_company_name,
                '外协厂' cooperation_name,
                sp_a.pause COOP_STATE,
                sp_a.product_type,
                sp_a.product_link,
                sp_a.product_line,
                (SELECT listagg(b.group_dict_name, ';') within GROUP(ORDER BY b.group_dict_value)
                   FROM dic t
                   LEFT JOIN dic b
                     ON t.group_dict_type = 'COOPERATION_BRAND'
                    AND t.group_dict_id = b.parent_id
                    AND instr(';' || sp_a.brand_type || ';',
                              ';' || t.group_dict_value || ';') > 0
                    AND instr(';' || sp_a.cooperation_brand || ';',
                              ';' || b.group_dict_value || ';') > 0) cooperation_brand_desc
  FROM scmdata.t_supplier_info sp_a
  LEFT JOIN scmdata.t_supplier_shared ts_a
    ON sp_a.supplier_info_id = ts_a.supplier_info_id
 WHERE sp_a.company_id = ts_a.company_id AND
 ts_a.company_id = %default_company_id% AND
 ts_a.shared_supplier_code =
 (SELECT t.supplier_code
    FROM scmdata.t_supplier_info t
   WHERE t.supplier_info_id = :supplier_info_id)*/]';
  CV8 CLOB:=q'[]';
  CV9 CLOB:=q'[]';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_ITEM_LIST WHERE ITEM_ID = ''a_supp_151_7''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_ITEM_LIST SET (AUTO_REFRESH,BACK_GROUND_ID,EDIT_EXPRESS,END_FIELD,EXECUTE_TIME,FOOTER,HEADER,HINT_TYPE,JUMP_EXPRESS,JUMP_FIELD,MAX_ROW_COUNT,MONITOR_ID,MULTI_PAGE_FLAG,NOADD_FIELDS,NOEDIT_FIELDS,NOMODIFY_FIELDS,NOSHOW_APP_FIELDS,NOSHOW_FIELDS,OPEN_MODE,OPERATE_TYPE,OPERATION_TYPE,OUTPUT_PARAMETER,PAGE_SIZES,QUERY_COUNT,QUERY_FIELDS,QUERY_TYPE,RFID_FLAG,SCANNABLE_FIELD,SCANNABLE_LOCATION_LINE,SCANNABLE_TIME,SCANNABLE_TYPE,SUBNOSHOW_FIELDS,SUB_EDIT_STATE,SUB_TABLE_JUDGE_FIELD,UI_TMPL,DELETE_SQL,DETAIL_SQL,INSERT_SQL,LOCK_SQL,NEWID_SQL,OPRETION_HINT,SELECT_SQL,SUBSELECT_SQL,UPDATE_SQL) = (SELECT 1,q''[]'',q''[]'',q''[]'',,q''[]'',q''[]'',,q''[]'',q''[]'',,q''[]'',1,q''[]'',q''[inside_supplier_code,coop_factory_type,coop_status]'',q''[]'',q''[]'',q''[coop_factory_id,supplier_info_id,company_id,coop_factory_type,coop_status,FAC_SUP_INFO_ID]'',,0,q''[]'',q''[]'',q''[]'',,q''[]'',0,,q''[]'',q''[]'',,,q''[]'',,q''[]'',q''[]'',:CV1,:CV2,:CV3,:CV4,:CV5,:CV6,:CV7,:CV8,:CV9 FROM DUAL) WHERE ITEM_ID = ''a_supp_151_7''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3,CV4,CV5,CV6,CV7,CV8,CV9;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_ITEM_LIST (AUTO_REFRESH,BACK_GROUND_ID,EDIT_EXPRESS,END_FIELD,EXECUTE_TIME,FOOTER,HEADER,HINT_TYPE,ITEM_ID,JUMP_EXPRESS,JUMP_FIELD,MAX_ROW_COUNT,MONITOR_ID,MULTI_PAGE_FLAG,NOADD_FIELDS,NOEDIT_FIELDS,NOMODIFY_FIELDS,NOSHOW_APP_FIELDS,NOSHOW_FIELDS,OPEN_MODE,OPERATE_TYPE,OPERATION_TYPE,OUTPUT_PARAMETER,PAGE_SIZES,QUERY_COUNT,QUERY_FIELDS,QUERY_TYPE,RFID_FLAG,SCANNABLE_FIELD,SCANNABLE_LOCATION_LINE,SCANNABLE_TIME,SCANNABLE_TYPE,SUBNOSHOW_FIELDS,SUB_EDIT_STATE,SUB_TABLE_JUDGE_FIELD,UI_TMPL,DELETE_SQL,DETAIL_SQL,INSERT_SQL,LOCK_SQL,NEWID_SQL,OPRETION_HINT,SELECT_SQL,SUBSELECT_SQL,UPDATE_SQL) SELECT 1,q''[]'',q''[]'',q''[]'',,q''[]'',q''[]'',,''a_supp_151_7'',q''[]'',q''[]'',,q''[]'',1,q''[]'',q''[inside_supplier_code,coop_factory_type,coop_status]'',q''[]'',q''[]'',q''[coop_factory_id,supplier_info_id,company_id,coop_factory_type,coop_status,FAC_SUP_INFO_ID]'',,0,q''[]'',q''[]'',q''[]'',,q''[]'',0,,q''[]'',q''[]'',,,q''[]'',,q''[]'',q''[]'',:CV1,:CV2,:CV3,:CV4,:CV5,:CV6,:CV7,:CV8,:CV9 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3,CV4,CV5,CV6,CV7,CV8,CV9;
     END IF;
  END;
END;
/

