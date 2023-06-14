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
  CURSOR supp_data IS
    SELECT *
      FROM scmdata.t_supplier_info sp
     WHERE sp.update_date >= sp.create_date
       AND sp.publish_date IS NULL
       AND sp.company_id = ''b6cc680ad0f599cde0531164a8c0337f'' 
       AND sp.status = 1;

  CURSOR supp_data_sc IS
    SELECT *
      FROM scmdata.t_supplier_info sp
     WHERE sp.update_date > sp.publish_date
       AND sp.publish_date > sp.create_date
       AND sp.publish_date IS NOT NULL
       AND sp.company_id = ''b6cc680ad0f599cde0531164a8c0337f'' 
       AND sp.status = 1;
BEGIN
  --sp.create_date =< sp.update_date  and sp.publish_date IS NULL
  --sp.create_date < publish_date < sp.update_date  and sp.publish_date IS NOT NULL

IF :PUBLISH_FLAG IS NOT NULL AND  :PUBLISH_FLAG = ''Y'' THEN
  FOR supp_rec IN supp_data LOOP
    UPDATE scmdata.t_supplier_info t
       SET t.publish_id = :PUBLISH_ID,
           t.publish_date = to_date(:PUBLISH_TIME, ''yyyy-mm-dd hh24:mi:ss'')
     WHERE t.supplier_info_id = supp_rec.supplier_info_id;
  END LOOP;

  FOR supp_rec IN supp_data_sc LOOP
    UPDATE scmdata.t_supplier_info t
       SET t.publish_id = :PUBLISH_ID,
           t.publish_date = to_date(:PUBLISH_TIME, ''yyyy-mm-dd hh24:mi:ss'')
     WHERE t.supplier_info_id = supp_rec.supplier_info_id;
  END LOOP;
END IF;

  v_sql := ''SELECT sp.supplier_code,
       sp.pause,
       decode(sp.pause, 0, ''''����'''', 1, ''''ͣ��'''') coop_status,
       sp.inside_supplier_code,
       sp.supplier_company_name,
       sp.legal_representative,
       sp.company_contact_person,
       sp.company_contact_phone,
       sp.company_address,
       sp.company_type,
       sp.cooperation_model cooperation_model_sp,
       sp.company_province,
       sp.company_city,
       sp.company_county,
       sp.social_credit_code,
       sp.remarks,
       sp.create_supp_date supp_date,
       a.inner_user_id create_id,
       sp.create_date insert_time,
       b.inner_user_id update_id,
       sp.update_date update_time,
       sp.publish_id,
       sp.publish_date publish_time,
       sp.publish_date send_time
  FROM scmdata.t_supplier_info sp
 LEFT JOIN sys_company_user a
    ON a.company_id = sp.company_id
   AND a.user_id = sp.create_id
 LEFT JOIN sys_company_user b
    ON b.company_id = sp.company_id
   AND b.user_id = sp.update_id
 WHERE sp.company_id = ''''b6cc680ad0f599cde0531164a8c0337f'''' 
   AND sp.status = 1
   AND EXISTS (SELECT 1
          FROM scmdata.t_coop_scope t
         WHERE t.supplier_info_id = sp.supplier_info_id)
 ORDER BY sp.create_date DESC, sp.supplier_code ASC'';
  --dbms_output.put_line(v_sql);
  @strresult := v_sql;
END;
}';
  CV8 CLOB:=q'[]';
  CV9 CLOB:=q'[]';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_ITEM_LIST WHERE ITEM_ID = ''a_supp_140''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_ITEM_LIST SET (AUTO_REFRESH,BACK_GROUND_ID,EDIT_EXPRESS,END_FIELD,EXECUTE_TIME,FOOTER,HEADER,HINT_TYPE,JUMP_EXPRESS,JUMP_FIELD,MAX_ROW_COUNT,MONITOR_ID,MULTI_PAGE_FLAG,NOADD_FIELDS,NOEDIT_FIELDS,NOMODIFY_FIELDS,NOSHOW_APP_FIELDS,NOSHOW_FIELDS,OPEN_MODE,OPERATION_TYPE,OUTPUT_PARAMETER,QUERY_COUNT,QUERY_FIELDS,QUERY_TYPE,RFID_FLAG,SCANNABLE_FIELD,SCANNABLE_LOCATION_LINE,SCANNABLE_TIME,SCANNABLE_TYPE,SUBNOSHOW_FIELDS,SUB_EDIT_STATE,SUB_TABLE_JUDGE_FIELD,UI_TMPL,DELETE_SQL,DETAIL_SQL,INSERT_SQL,LOCK_SQL,NEWID_SQL,OPRETION_HINT,SELECT_SQL,SUBSELECT_SQL,UPDATE_SQL) = (SELECT 1,q''[]'',q''[]'',q''[]'',,q''[]'',q''[]'',,q''[]'',q''[]'',,q''[]'',1,q''[]'',q''[]'',q''[]'',q''[]'',q''[send_time]'',,q''[]'',q''[]'',,q''[]'',13,,q''[]'',q''[]'',,,q''[]'',,q''[]'',q''[]'',:CV1,:CV2,:CV3,:CV4,:CV5,:CV6,:CV7,:CV8,:CV9 FROM DUAL) WHERE ITEM_ID = ''a_supp_140''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3,CV4,CV5,CV6,CV7,CV8,CV9;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_ITEM_LIST (AUTO_REFRESH,BACK_GROUND_ID,EDIT_EXPRESS,END_FIELD,EXECUTE_TIME,FOOTER,HEADER,HINT_TYPE,ITEM_ID,JUMP_EXPRESS,JUMP_FIELD,MAX_ROW_COUNT,MONITOR_ID,MULTI_PAGE_FLAG,NOADD_FIELDS,NOEDIT_FIELDS,NOMODIFY_FIELDS,NOSHOW_APP_FIELDS,NOSHOW_FIELDS,OPEN_MODE,OPERATION_TYPE,OUTPUT_PARAMETER,QUERY_COUNT,QUERY_FIELDS,QUERY_TYPE,RFID_FLAG,SCANNABLE_FIELD,SCANNABLE_LOCATION_LINE,SCANNABLE_TIME,SCANNABLE_TYPE,SUBNOSHOW_FIELDS,SUB_EDIT_STATE,SUB_TABLE_JUDGE_FIELD,UI_TMPL,DELETE_SQL,DETAIL_SQL,INSERT_SQL,LOCK_SQL,NEWID_SQL,OPRETION_HINT,SELECT_SQL,SUBSELECT_SQL,UPDATE_SQL) SELECT 1,q''[]'',q''[]'',q''[]'',,q''[]'',q''[]'',,''a_supp_140'',q''[]'',q''[]'',,q''[]'',1,q''[]'',q''[]'',q''[]'',q''[]'',q''[send_time]'',,q''[]'',q''[]'',,q''[]'',13,,q''[]'',q''[]'',,,q''[]'',,q''[]'',q''[]'',:CV1,:CV2,:CV3,:CV4,:CV5,:CV6,:CV7,:CV8,:CV9 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3,CV4,CV5,CV6,CV7,CV8,CV9;
     END IF;
  END;
END;
/

