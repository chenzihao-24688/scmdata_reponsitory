BEGIN
  DECLARE
    JUDGE_N NUMBER(4);
    EXE_SQL CLOB;
    VALS    CLOB;
  CV1 CLOB:=q'[BEGIN
  scmdata.pkg_a_config_lib.p_delete_supp_group_category(p_group_config_id => :group_config_id,
                                                        p_company_id      => %default_company_id%,
                                                        p_gc_config_id    => :group_category_config_id);
END;]';
  CV2 CLOB:=q'[]';
  CV3 CLOB:=q'[DECLARE
  p_gc_rec scmdata.t_supplier_group_category_config%ROWTYPE;
BEGIN
  p_gc_rec.group_category_config_id   := scmdata.f_get_uuid();
  p_gc_rec.company_id                 := %default_company_id%;
  p_gc_rec.group_config_id            := :group_config_id;
  p_gc_rec.cooperation_classification := :cooperation_classification;
  p_gc_rec.cooperation_product_cate   := :cooperation_product_cate;
  p_gc_rec.area_name                  := :group_area;
  p_gc_rec.area_config_id             := :area_config_id;
  p_gc_rec.pause                      := 1;
  --p_gc_rec.remarks              := :remarks;
  p_gc_rec.create_id                  := :user_id;
  p_gc_rec.create_time                := SYSDATE;
  p_gc_rec.update_id                  := :user_id;
  p_gc_rec.update_time                := SYSDATE;
  --校验品类、区域配置
  scmdata.pkg_a_config_lib.p_check_cate_area_config(p_gc_rec => p_gc_rec);
  --新增
  scmdata.pkg_a_config_lib.p_insert_supp_group_category(p_gc_rec => p_gc_rec);
END;]';
  CV4 CLOB:=q'[]';
  CV5 CLOB:=q'[]';
  CV6 CLOB:=q'[]';
  CV7 CLOB:=q'[{DECLARE
  v_sql CLOB;
BEGIN
  v_sql      := pkg_a_config_lib.f_query_supp_group_category(p_company_id => %default_company_id%,p_group_config_id => :GROUP_CONFIG_ID);
  @strresult := v_sql;
END;}]';
  CV8 CLOB:=q'[]';
  CV9 CLOB:=q'[DECLARE
  p_gc_rec scmdata.t_supplier_group_category_config%ROWTYPE;
BEGIN
  p_gc_rec.group_category_config_id   := :group_category_config_id;
  p_gc_rec.company_id                 := %default_company_id%;
  p_gc_rec.group_config_id            := :group_config_id;
  p_gc_rec.cooperation_classification := :cooperation_classification;
  p_gc_rec.cooperation_product_cate   := :cooperation_product_cate;
  p_gc_rec.area_name                  := :group_area;
  p_gc_rec.area_config_id             := :area_config_id;
  p_gc_rec.update_id                  := :user_id;
  p_gc_rec.update_time                := SYSDATE;
  --校验品类、区域配置
  scmdata.pkg_a_config_lib.p_check_cate_area_config(p_gc_rec => p_gc_rec);
  --修改
  scmdata.pkg_a_config_lib.p_update_supp_group_category(p_gc_rec => p_gc_rec);
END;]';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_ITEM_LIST WHERE ITEM_ID = ''a_coop_161''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_ITEM_LIST SET (AUTO_REFRESH,BACK_GROUND_ID,EDIT_EXPRESS,END_FIELD,EXECUTE_TIME,FOOTER,HEADER,HINT_TYPE,JUMP_EXPRESS,JUMP_FIELD,MAX_ROW_COUNT,MONITOR_ID,MULTI_PAGE_FLAG,NOADD_FIELDS,NOEDIT_FIELDS,NOMODIFY_FIELDS,NOSHOW_APP_FIELDS,NOSHOW_FIELDS,OPEN_MODE,OPERATE_TYPE,OPERATION_TYPE,OUTPUT_PARAMETER,PAGE_SIZES,QUERY_COUNT,QUERY_FIELDS,QUERY_TYPE,RFID_FLAG,SCANNABLE_FIELD,SCANNABLE_LOCATION_LINE,SCANNABLE_TIME,SCANNABLE_TYPE,SUBNOSHOW_FIELDS,SUB_EDIT_STATE,SUB_TABLE_JUDGE_FIELD,UI_TMPL,DELETE_SQL,DETAIL_SQL,INSERT_SQL,LOCK_SQL,NEWID_SQL,OPRETION_HINT,SELECT_SQL,SUBSELECT_SQL,UPDATE_SQL) = (SELECT 3,q''[]'',q''[]'',q''[]'',,q''[]'',q''[]'',,q''[]'',q''[]'',,q''[]'',1,q''[]'',q''[]'',q''[]'',q''[]'',q''[group_category_config_id,company_id,group_config_id,pause,remarks,cooperation_classification,cooperation_product_cate,province_id,city_id,area_config_id]'',,0,q''[]'',q''[]'',q''[]'',,q''[]'',,,q''[]'',q''[]'',,,q''[]'',,q''[]'',q''[]'',:CV1,:CV2,:CV3,:CV4,:CV5,:CV6,:CV7,:CV8,:CV9 FROM DUAL) WHERE ITEM_ID = ''a_coop_161''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3,CV4,CV5,CV6,CV7,CV8,CV9;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_ITEM_LIST (AUTO_REFRESH,BACK_GROUND_ID,EDIT_EXPRESS,END_FIELD,EXECUTE_TIME,FOOTER,HEADER,HINT_TYPE,ITEM_ID,JUMP_EXPRESS,JUMP_FIELD,MAX_ROW_COUNT,MONITOR_ID,MULTI_PAGE_FLAG,NOADD_FIELDS,NOEDIT_FIELDS,NOMODIFY_FIELDS,NOSHOW_APP_FIELDS,NOSHOW_FIELDS,OPEN_MODE,OPERATE_TYPE,OPERATION_TYPE,OUTPUT_PARAMETER,PAGE_SIZES,QUERY_COUNT,QUERY_FIELDS,QUERY_TYPE,RFID_FLAG,SCANNABLE_FIELD,SCANNABLE_LOCATION_LINE,SCANNABLE_TIME,SCANNABLE_TYPE,SUBNOSHOW_FIELDS,SUB_EDIT_STATE,SUB_TABLE_JUDGE_FIELD,UI_TMPL,DELETE_SQL,DETAIL_SQL,INSERT_SQL,LOCK_SQL,NEWID_SQL,OPRETION_HINT,SELECT_SQL,SUBSELECT_SQL,UPDATE_SQL) SELECT 3,q''[]'',q''[]'',q''[]'',,q''[]'',q''[]'',,''a_coop_161'',q''[]'',q''[]'',,q''[]'',1,q''[]'',q''[]'',q''[]'',q''[]'',q''[group_category_config_id,company_id,group_config_id,pause,remarks,cooperation_classification,cooperation_product_cate,province_id,city_id,area_config_id]'',,0,q''[]'',q''[]'',q''[]'',,q''[]'',,,q''[]'',q''[]'',,,q''[]'',,q''[]'',q''[]'',:CV1,:CV2,:CV3,:CV4,:CV5,:CV6,:CV7,:CV8,:CV9 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3,CV4,CV5,CV6,CV7,CV8,CV9;
     END IF;
  END;
END;
/

BEGIN
  DECLARE
    JUDGE_N NUMBER(4);
    EXE_SQL CLOB;
    VALS    CLOB;
  CV1 CLOB:=q'[BEGIN
  scmdata.pkg_a_config_lib.p_delete_supp_group_area(p_company_id      => %default_company_id%,
                                                    p_gc_config_id    => :group_area_config_id);
END;]';
  CV2 CLOB:=q'[]';
  CV3 CLOB:=q'[DECLARE
  p_gc_rec scmdata.t_supplier_group_area_config%ROWTYPE;
BEGIN
  p_gc_rec.group_area_config_id := scmdata.f_get_uuid();
  p_gc_rec.company_id           := %default_company_id%;
  p_gc_rec.is_nationwide        := :is_nationwide;
  p_gc_rec.is_province_allcity  := substr(:is_province_allcity,0,1);
  p_gc_rec.area_name            := :area_name;
  p_gc_rec.province_id          := :province_id;
  p_gc_rec.city_id              := :city_id;
  p_gc_rec.group_area           := :group_area;
  --p_gc_rec.pause                := :pause;
  --p_gc_rec.remarks              := :remarks;
  p_gc_rec.create_id   := :user_id;
  p_gc_rec.create_time := SYSDATE;
  p_gc_rec.update_id   := :user_id;
  p_gc_rec.update_time := SYSDATE;

  scmdata.pkg_a_config_lib.p_insert_supp_group_area(p_gc_rec => p_gc_rec);
END;]';
  CV4 CLOB:=q'[]';
  CV5 CLOB:=q'[]';
  CV6 CLOB:=q'[]';
  CV7 CLOB:=q'[{DECLARE
  v_sql CLOB;
BEGIN
  v_sql      := pkg_a_config_lib.f_query_supp_group_area(p_company_id => %default_company_id%);
  @strresult := v_sql;
END;}]';
  CV8 CLOB:=q'[]';
  CV9 CLOB:=q'[DECLARE
  p_gc_rec scmdata.t_supplier_group_area_config%ROWTYPE;
BEGIN
  p_gc_rec.group_area_config_id := :group_area_config_id;
  p_gc_rec.company_id           := %default_company_id%;
  p_gc_rec.area_name           := :area_name;
  p_gc_rec.is_nationwide        := :is_nationwide;
  p_gc_rec.is_province_allcity := substr(:is_province_allcity,0,1);
  p_gc_rec.group_area := :group_area;
  p_gc_rec.province_id         := :province_id;
  p_gc_rec.city_id             := :city_id;
  p_gc_rec.pause                := :pause;
  --p_gc_rec.remarks              := :remarks;
  p_gc_rec.update_id   := :user_id;
  p_gc_rec.update_time := SYSDATE;

  scmdata.pkg_a_config_lib.p_update_supp_group_area(p_gc_rec => p_gc_rec);
END;]';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_ITEM_LIST WHERE ITEM_ID = ''a_coop_162''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_ITEM_LIST SET (AUTO_REFRESH,BACK_GROUND_ID,EDIT_EXPRESS,END_FIELD,EXECUTE_TIME,FOOTER,HEADER,HINT_TYPE,JUMP_EXPRESS,JUMP_FIELD,MAX_ROW_COUNT,MONITOR_ID,MULTI_PAGE_FLAG,NOADD_FIELDS,NOEDIT_FIELDS,NOMODIFY_FIELDS,NOSHOW_APP_FIELDS,NOSHOW_FIELDS,OPEN_MODE,OPERATE_TYPE,OPERATION_TYPE,OUTPUT_PARAMETER,PAGE_SIZES,QUERY_COUNT,QUERY_FIELDS,QUERY_TYPE,RFID_FLAG,SCANNABLE_FIELD,SCANNABLE_LOCATION_LINE,SCANNABLE_TIME,SCANNABLE_TYPE,SUBNOSHOW_FIELDS,SUB_EDIT_STATE,SUB_TABLE_JUDGE_FIELD,UI_TMPL,DELETE_SQL,DETAIL_SQL,INSERT_SQL,LOCK_SQL,NEWID_SQL,OPRETION_HINT,SELECT_SQL,SUBSELECT_SQL,UPDATE_SQL) = (SELECT 3,q''[]'',q''[]'',q''[]'',,q''[]'',q''[]'',,q''[]'',q''[]'',,q''[]'',1,q''[]'',q''[]'',q''[]'',q''[]'',q''[group_area_config_id,company_id,group_config_id,pause,remarks,province_id,city_id]'',,0,q''[]'',q''[]'',q''[]'',,q''[]'',,,q''[]'',q''[]'',,,q''[]'',,q''[]'',q''[]'',:CV1,:CV2,:CV3,:CV4,:CV5,:CV6,:CV7,:CV8,:CV9 FROM DUAL) WHERE ITEM_ID = ''a_coop_162''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3,CV4,CV5,CV6,CV7,CV8,CV9;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_ITEM_LIST (AUTO_REFRESH,BACK_GROUND_ID,EDIT_EXPRESS,END_FIELD,EXECUTE_TIME,FOOTER,HEADER,HINT_TYPE,ITEM_ID,JUMP_EXPRESS,JUMP_FIELD,MAX_ROW_COUNT,MONITOR_ID,MULTI_PAGE_FLAG,NOADD_FIELDS,NOEDIT_FIELDS,NOMODIFY_FIELDS,NOSHOW_APP_FIELDS,NOSHOW_FIELDS,OPEN_MODE,OPERATE_TYPE,OPERATION_TYPE,OUTPUT_PARAMETER,PAGE_SIZES,QUERY_COUNT,QUERY_FIELDS,QUERY_TYPE,RFID_FLAG,SCANNABLE_FIELD,SCANNABLE_LOCATION_LINE,SCANNABLE_TIME,SCANNABLE_TYPE,SUBNOSHOW_FIELDS,SUB_EDIT_STATE,SUB_TABLE_JUDGE_FIELD,UI_TMPL,DELETE_SQL,DETAIL_SQL,INSERT_SQL,LOCK_SQL,NEWID_SQL,OPRETION_HINT,SELECT_SQL,SUBSELECT_SQL,UPDATE_SQL) SELECT 3,q''[]'',q''[]'',q''[]'',,q''[]'',q''[]'',,''a_coop_162'',q''[]'',q''[]'',,q''[]'',1,q''[]'',q''[]'',q''[]'',q''[]'',q''[group_area_config_id,company_id,group_config_id,pause,remarks,province_id,city_id]'',,0,q''[]'',q''[]'',q''[]'',,q''[]'',,,q''[]'',q''[]'',,,q''[]'',,q''[]'',q''[]'',:CV1,:CV2,:CV3,:CV4,:CV5,:CV6,:CV7,:CV8,:CV9 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3,CV4,CV5,CV6,CV7,CV8,CV9;
     END IF;
  END;
END;
/

BEGIN
  DECLARE
    JUDGE_N NUMBER(4);
    EXE_SQL CLOB;
    VALS    CLOB;
  CV1 CLOB:=q'[call  pkg_a_config_lib.p_delete_supplier_group_config(p_group_config_id => :group_config_id,p_company_id  => %default_company_id%)]';
  CV2 CLOB:=q'[]';
  CV3 CLOB:=q'[DECLARE
  p_gc_rec scmdata.t_supplier_group_config%ROWTYPE;
BEGIN
  p_gc_rec.group_config_id   := scmdata.f_get_uuid();
  p_gc_rec.group_name        := :group_name;
  p_gc_rec.area_group_leader := :area_group_leader;
  p_gc_rec.effective_time    := :effective_time;
  p_gc_rec.end_time          := :end_time_gp;
  p_gc_rec.remarks           := :remarks;
  p_gc_rec.create_id         := :user_id;
  p_gc_rec.create_time       := SYSDATE;
  p_gc_rec.update_id         := :user_id;
  p_gc_rec.update_time       := SYSDATE;
  p_gc_rec.company_id        := %default_company_id%;
  pkg_a_config_lib.p_insert_supplier_group_config(p_gc_rec => p_gc_rec);
END;]';
  CV4 CLOB:=q'[]';
  CV5 CLOB:=q'[]';
  CV6 CLOB:=q'[]';
  CV7 CLOB:=q'[{DECLARE
  v_sql CLOB;
BEGIN
  v_sql      := pkg_a_config_lib.f_query_supplier_group_config(p_company_id => %default_company_id%);
  @strresult := v_sql;
END;}]';
  CV8 CLOB:=q'[]';
  CV9 CLOB:=q'[DECLARE
  p_gc_rec scmdata.t_supplier_group_config%ROWTYPE;
BEGIN
  p_gc_rec.group_config_id   := :group_config_id;
  p_gc_rec.group_name        := :group_name;
  p_gc_rec.area_group_leader := :area_group_leader;
  p_gc_rec.effective_time    := :effective_time;
  p_gc_rec.end_time          := :end_time_gp;
  p_gc_rec.remarks           := :remarks;
  p_gc_rec.update_id         := :user_id;
  p_gc_rec.update_time       := SYSDATE;
  p_gc_rec.company_id        := %default_company_id%;
  pkg_a_config_lib.p_update_supplier_group_config(p_gc_rec => p_gc_rec);
END;]';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_ITEM_LIST WHERE ITEM_ID = ''a_coop_163''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_ITEM_LIST SET (AUTO_REFRESH,BACK_GROUND_ID,EDIT_EXPRESS,END_FIELD,EXECUTE_TIME,FOOTER,HEADER,HINT_TYPE,JUMP_EXPRESS,JUMP_FIELD,MAX_ROW_COUNT,MONITOR_ID,MULTI_PAGE_FLAG,NOADD_FIELDS,NOEDIT_FIELDS,NOMODIFY_FIELDS,NOSHOW_APP_FIELDS,NOSHOW_FIELDS,OPEN_MODE,OPERATE_TYPE,OPERATION_TYPE,OUTPUT_PARAMETER,PAGE_SIZES,QUERY_COUNT,QUERY_FIELDS,QUERY_TYPE,RFID_FLAG,SCANNABLE_FIELD,SCANNABLE_LOCATION_LINE,SCANNABLE_TIME,SCANNABLE_TYPE,SUBNOSHOW_FIELDS,SUB_EDIT_STATE,SUB_TABLE_JUDGE_FIELD,UI_TMPL,DELETE_SQL,DETAIL_SQL,INSERT_SQL,LOCK_SQL,NEWID_SQL,OPRETION_HINT,SELECT_SQL,SUBSELECT_SQL,UPDATE_SQL) = (SELECT 3,q''[]'',q''[]'',q''[]'',,q''[]'',q''[]'',,q''[]'',q''[]'',,q''[]'',1,q''[]'',q''[]'',q''[]'',q''[]'',q''[group_config_id,company_id]'',,0,q''[]'',q''[]'',q''[]'',,q''[group_name]'',,,q''[]'',q''[]'',,,q''[]'',,q''[]'',q''[]'',:CV1,:CV2,:CV3,:CV4,:CV5,:CV6,:CV7,:CV8,:CV9 FROM DUAL) WHERE ITEM_ID = ''a_coop_163''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3,CV4,CV5,CV6,CV7,CV8,CV9;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_ITEM_LIST (AUTO_REFRESH,BACK_GROUND_ID,EDIT_EXPRESS,END_FIELD,EXECUTE_TIME,FOOTER,HEADER,HINT_TYPE,ITEM_ID,JUMP_EXPRESS,JUMP_FIELD,MAX_ROW_COUNT,MONITOR_ID,MULTI_PAGE_FLAG,NOADD_FIELDS,NOEDIT_FIELDS,NOMODIFY_FIELDS,NOSHOW_APP_FIELDS,NOSHOW_FIELDS,OPEN_MODE,OPERATE_TYPE,OPERATION_TYPE,OUTPUT_PARAMETER,PAGE_SIZES,QUERY_COUNT,QUERY_FIELDS,QUERY_TYPE,RFID_FLAG,SCANNABLE_FIELD,SCANNABLE_LOCATION_LINE,SCANNABLE_TIME,SCANNABLE_TYPE,SUBNOSHOW_FIELDS,SUB_EDIT_STATE,SUB_TABLE_JUDGE_FIELD,UI_TMPL,DELETE_SQL,DETAIL_SQL,INSERT_SQL,LOCK_SQL,NEWID_SQL,OPRETION_HINT,SELECT_SQL,SUBSELECT_SQL,UPDATE_SQL) SELECT 3,q''[]'',q''[]'',q''[]'',,q''[]'',q''[]'',,''a_coop_163'',q''[]'',q''[]'',,q''[]'',1,q''[]'',q''[]'',q''[]'',q''[]'',q''[group_config_id,company_id]'',,0,q''[]'',q''[]'',q''[]'',,q''[group_name]'',,,q''[]'',q''[]'',,,q''[]'',,q''[]'',q''[]'',:CV1,:CV2,:CV3,:CV4,:CV5,:CV6,:CV7,:CV8,:CV9 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3,CV4,CV5,CV6,CV7,CV8,CV9;
     END IF;
  END;
END;
/

