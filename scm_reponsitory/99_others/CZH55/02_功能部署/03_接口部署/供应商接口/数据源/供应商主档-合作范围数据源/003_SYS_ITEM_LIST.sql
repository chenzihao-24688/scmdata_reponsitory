BEGIN
  DECLARE
    JUDGE_N NUMBER(4);
    EXE_SQL CLOB;
    VALS    CLOB;
  CV1 CLOB:=q'[]';
  CV2 CLOB:=q'[]';
  CV3 CLOB:=q'[]';
  CV4 CLOB:=q'[]';
  CV5 CLOB:=q'[]';
  CV6 CLOB:=q'[]';
  CV7 CLOB:='{DECLARE
  v_sql       VARCHAR2(4000);

  CURSOR coop_data IS
    SELECT t.*
      FROM scmdata.t_coop_scope t
     INNER JOIN scmdata.t_supplier_info sp
        ON t.company_id = sp.company_id
       AND t.supplier_info_id = sp.supplier_info_id
       and sp.status = 1
       AND t.update_time >= t.create_time
       AND t.publish_date IS NULL
       AND sp.company_id = ''b6cc680ad0f599cde0531164a8c0337f'';--%default_company_id%;

  CURSOR coop_data_sc IS
    SELECT t.*
      FROM scmdata.t_coop_scope t
     INNER JOIN scmdata.t_supplier_info sp
        ON t.company_id = sp.company_id
       AND t.supplier_info_id = sp.supplier_info_id
       AND sp.status = 1
       AND t.update_time > t.publish_date
       AND t.publish_date > t.create_time
       AND t.publish_date IS NOT NULL
       AND sp.company_id = ''b6cc680ad0f599cde0531164a8c0337f''; --%default_company_id%;
BEGIN
  --sp.create_date =< sp.update_date  and sp.publish_date IS NULL
  --sp.create_date < publish_date < sp.update_date  and sp.publish_date IS NOT NULL

IF :PUBLISH_FLAG IS NOT NULL AND  :PUBLISH_FLAG = ''Y'' THEN
  FOR coop_rec IN coop_data LOOP
    UPDATE scmdata.t_coop_scope t
       SET t.publish_id = :PUBLISH_ID,
           t.publish_date = to_date(:PUBLISH_TIME, ''yyyy-mm-dd hh24:mi:ss'')--:PUBLISH_TIME --sysdate --:PUBLISH_TIME
     WHERE t.supplier_info_id = coop_rec.supplier_info_id;
  END LOOP;

  FOR coop_rec IN coop_data_sc LOOP
    UPDATE scmdata.t_coop_scope t
       SET t.publish_id = :PUBLISH_ID,
           t.publish_date = to_date(:PUBLISH_TIME, ''yyyy-mm-dd hh24:mi:ss'') --:PUBLISH_TIME --sysdate --:PUBLISH_TIME
     WHERE t.supplier_info_id = coop_rec.supplier_info_id;
  END LOOP;
END IF;

  v_sql := ''SELECT sp.supplier_code,
       sp.supplier_company_name,
       t.coop_scope_id,
       t.pause,
       decode(t.pause, 0, ''''Õý³£'''', 1, ''''Í£ÓÃ'''') coop_status,
       t.coop_classification coop_classification_num,
       a.group_dict_name cooperation_classification_sp,
       t.coop_product_cate coop_product_cate_num,
       b.group_dict_name cooperation_product_cate_sp,
       f.inner_user_id create_id,
       t.create_time,
       g.inner_user_id update_id,
       t.update_time,
       t.publish_id,
       t.publish_date
  FROM scmdata.t_coop_scope t
 INNER JOIN scmdata.t_supplier_info sp
    ON t.company_id = sp.company_id
   AND t.supplier_info_id = sp.supplier_info_id
   AND sp.status = 1
 INNER JOIN scmdata.sys_group_dict a
    ON t.coop_classification = a.group_dict_value
   AND a.group_dict_type = ''''PRODUCT_TYPE''''
 INNER JOIN scmdata.sys_group_dict b
    ON b.group_dict_type = a.group_dict_value
   AND t.coop_product_cate = b.group_dict_value
   AND sp.company_id = ''''b6cc680ad0f599cde0531164a8c0337f'''' --%default_company_id%
 LEFT JOIN sys_company_user f
    ON f.company_id = t.company_id
   AND f.user_id = t.create_id
 LEFT JOIN sys_company_user g
    ON g.company_id = t.company_id
   AND g.user_id = t.update_id
 WHERE t.company_id = ''''b6cc680ad0f599cde0531164a8c0337f'''' --%default_company_id%
 ORDER BY t.create_time DESC, sp.supplier_code ASC'';
  --dbms_output.put_line(v_sql);
  @strresult := v_sql;
END;
}';
  CV8 CLOB:=q'[]';
  CV9 CLOB:=q'[]';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_ITEM_LIST WHERE ITEM_ID = ''a_supp_141''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_ITEM_LIST SET (AUTO_REFRESH,BACK_GROUND_ID,EDIT_EXPRESS,END_FIELD,EXECUTE_TIME,FOOTER,HEADER,HINT_TYPE,JUMP_EXPRESS,JUMP_FIELD,MAX_ROW_COUNT,MONITOR_ID,MULTI_PAGE_FLAG,NOADD_FIELDS,NOEDIT_FIELDS,NOMODIFY_FIELDS,NOSHOW_APP_FIELDS,NOSHOW_FIELDS,OPEN_MODE,OPERATION_TYPE,OUTPUT_PARAMETER,QUERY_COUNT,QUERY_FIELDS,QUERY_TYPE,RFID_FLAG,SCANNABLE_FIELD,SCANNABLE_LOCATION_LINE,SCANNABLE_TIME,SCANNABLE_TYPE,SUBNOSHOW_FIELDS,SUB_EDIT_STATE,SUB_TABLE_JUDGE_FIELD,UI_TMPL,DELETE_SQL,DETAIL_SQL,INSERT_SQL,LOCK_SQL,NEWID_SQL,OPRETION_HINT,SELECT_SQL,SUBSELECT_SQL,UPDATE_SQL) = (SELECT 1,q''[]'',q''[]'',q''[]'',,q''[]'',q''[]'',,q''[]'',q''[]'',,q''[]'',1,q''[]'',q''[]'',q''[]'',q''[]'',q''[]'',,q''[]'',q''[]'',,q''[]'',13,,q''[]'',q''[]'',,,q''[]'',,q''[]'',q''[]'',:CV1,:CV2,:CV3,:CV4,:CV5,:CV6,:CV7,:CV8,:CV9 FROM DUAL) WHERE ITEM_ID = ''a_supp_141''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3,CV4,CV5,CV6,CV7,CV8,CV9;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_ITEM_LIST (AUTO_REFRESH,BACK_GROUND_ID,EDIT_EXPRESS,END_FIELD,EXECUTE_TIME,FOOTER,HEADER,HINT_TYPE,ITEM_ID,JUMP_EXPRESS,JUMP_FIELD,MAX_ROW_COUNT,MONITOR_ID,MULTI_PAGE_FLAG,NOADD_FIELDS,NOEDIT_FIELDS,NOMODIFY_FIELDS,NOSHOW_APP_FIELDS,NOSHOW_FIELDS,OPEN_MODE,OPERATION_TYPE,OUTPUT_PARAMETER,QUERY_COUNT,QUERY_FIELDS,QUERY_TYPE,RFID_FLAG,SCANNABLE_FIELD,SCANNABLE_LOCATION_LINE,SCANNABLE_TIME,SCANNABLE_TYPE,SUBNOSHOW_FIELDS,SUB_EDIT_STATE,SUB_TABLE_JUDGE_FIELD,UI_TMPL,DELETE_SQL,DETAIL_SQL,INSERT_SQL,LOCK_SQL,NEWID_SQL,OPRETION_HINT,SELECT_SQL,SUBSELECT_SQL,UPDATE_SQL) SELECT 1,q''[]'',q''[]'',q''[]'',,q''[]'',q''[]'',,''a_supp_141'',q''[]'',q''[]'',,q''[]'',1,q''[]'',q''[]'',q''[]'',q''[]'',q''[]'',,q''[]'',q''[]'',,q''[]'',13,,q''[]'',q''[]'',,,q''[]'',,q''[]'',q''[]'',:CV1,:CV2,:CV3,:CV4,:CV5,:CV6,:CV7,:CV8,:CV9 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3,CV4,CV5,CV6,CV7,CV8,CV9;
     END IF;
  END;
END;
/

