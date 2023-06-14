BEGIN
  DECLARE
    JUDGE_N NUMBER(4);
    EXE_SQL CLOB;
    VALS    CLOB;
  CV1 CLOB:=q'^^';
  CV2 CLOB:=q'^^';
  CV3 CLOB:=q'^^';
  CV4 CLOB:=q'^^';
  CV5 CLOB:=q'^^';
  CV6 CLOB:=q'^^';
  CV7 CLOB:=q'^select a.company_id,a.logo,a.company_name,a.logn_name,a.tips,
       a.is_open,a.attributor_id,nvl(c.COMPANY_USER_NAME,b.username) attributor,a.create_time,a.area,a.address,
       a.product,a.rival,a.licence_type,a.licence_num
  from scmdata.sys_company a
 left join sys_user b on a.attributor_id=b.user_id
 left join sys_company_user c on b.user_id=c.user_id and a.company_id=c.company_id
 where a.company_id=%ASS_COMPANY_ID%^';
  CV8 CLOB:=q'^^';
  CV9 CLOB:=q'^^';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_ITEM_LIST WHERE ITEM_ID = ''a_coop_103_1''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_ITEM_LIST SET (AUTO_REFRESH,BACK_GROUND_ID,EDIT_EXPRESS,END_FIELD,EXECUTE_TIME,FOOTER,HEADER,HINT_TYPE,JUMP_EXPRESS,JUMP_FIELD,MAX_ROW_COUNT,MONITOR_ID,MULTI_PAGE_FLAG,NOADD_FIELDS,NOEDIT_FIELDS,NOMODIFY_FIELDS,NOSHOW_APP_FIELDS,NOSHOW_FIELDS,OPEN_MODE,OPERATE_TYPE,OPERATION_TYPE,OUTPUT_PARAMETER,PAGE_SIZES,QUERY_COUNT,QUERY_FIELDS,QUERY_TYPE,RFID_FLAG,SCANNABLE_FIELD,SCANNABLE_LOCATION_LINE,SCANNABLE_TIME,SCANNABLE_TYPE,SUBNOSHOW_FIELDS,SUB_EDIT_STATE,SUB_TABLE_JUDGE_FIELD,UI_TMPL,DELETE_SQL,DETAIL_SQL,INSERT_SQL,LOCK_SQL,NEWID_SQL,OPRETION_HINT,SELECT_SQL,SUBSELECT_SQL,UPDATE_SQL) = (SELECT ,q''[]'',q''[]'',q''[]'',,q''[]'',q''[]'',,q''[]'',q''[]'',,q''[]'',1,q''[]'',q''[]'',q''[]'',q''[]'',q''[]'',,0,q''[]'',q''[]'',q''[20,30,50,100,200,500]'',,q''[]'',,,q''[]'',q''[]'',,,q''[]'',,q''[]'',q''[]'',:CV1,:CV2,:CV3,:CV4,:CV5,:CV6,:CV7,:CV8,:CV9 FROM DUAL) WHERE ITEM_ID = ''a_coop_103_1''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3,CV4,CV5,CV6,CV7,CV8,CV9;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_ITEM_LIST (AUTO_REFRESH,BACK_GROUND_ID,EDIT_EXPRESS,END_FIELD,EXECUTE_TIME,FOOTER,HEADER,HINT_TYPE,ITEM_ID,JUMP_EXPRESS,JUMP_FIELD,MAX_ROW_COUNT,MONITOR_ID,MULTI_PAGE_FLAG,NOADD_FIELDS,NOEDIT_FIELDS,NOMODIFY_FIELDS,NOSHOW_APP_FIELDS,NOSHOW_FIELDS,OPEN_MODE,OPERATE_TYPE,OPERATION_TYPE,OUTPUT_PARAMETER,PAGE_SIZES,QUERY_COUNT,QUERY_FIELDS,QUERY_TYPE,RFID_FLAG,SCANNABLE_FIELD,SCANNABLE_LOCATION_LINE,SCANNABLE_TIME,SCANNABLE_TYPE,SUBNOSHOW_FIELDS,SUB_EDIT_STATE,SUB_TABLE_JUDGE_FIELD,UI_TMPL,DELETE_SQL,DETAIL_SQL,INSERT_SQL,LOCK_SQL,NEWID_SQL,OPRETION_HINT,SELECT_SQL,SUBSELECT_SQL,UPDATE_SQL) SELECT ,q''[]'',q''[]'',q''[]'',,q''[]'',q''[]'',,''a_coop_103_1'',q''[]'',q''[]'',,q''[]'',1,q''[]'',q''[]'',q''[]'',q''[]'',q''[]'',,0,q''[]'',q''[]'',q''[20,30,50,100,200,500]'',,q''[]'',,,q''[]'',q''[]'',,,q''[]'',,q''[]'',q''[]'',:CV1,:CV2,:CV3,:CV4,:CV5,:CV6,:CV7,:CV8,:CV9 FROM DUAL';
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
  CV1 CLOB:=q'^^';
  CV2 CLOB:=q'^^';
  CV3 CLOB:=q'^^';
  CV4 CLOB:=q'^^';
  CV5 CLOB:=q'^^';
  CV6 CLOB:=q'^^';
  CV7 CLOB:=q'^--czh 代码封装
{
DECLARE
  v_sql           CLOB;
BEGIN
  v_sql      := scmdata.pkg_ask_record_mange.f_query_flow_status_logger(p_ask_record_id => NULL,p_ask_fac_id => :factory_ask_id);
  ^'|| CHR(64) ||q'^strresult := v_sql;
END;
}^';
  CV8 CLOB:=q'^^';
  CV9 CLOB:=q'^^';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_ITEM_LIST WHERE ITEM_ID = ''a_coop_106''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_ITEM_LIST SET (AUTO_REFRESH,BACK_GROUND_ID,EDIT_EXPRESS,END_FIELD,EXECUTE_TIME,FOOTER,HEADER,HINT_TYPE,JUMP_EXPRESS,JUMP_FIELD,MAX_ROW_COUNT,MONITOR_ID,MULTI_PAGE_FLAG,NOADD_FIELDS,NOEDIT_FIELDS,NOMODIFY_FIELDS,NOSHOW_APP_FIELDS,NOSHOW_FIELDS,OPEN_MODE,OPERATE_TYPE,OPERATION_TYPE,OUTPUT_PARAMETER,PAGE_SIZES,QUERY_COUNT,QUERY_FIELDS,QUERY_TYPE,RFID_FLAG,SCANNABLE_FIELD,SCANNABLE_LOCATION_LINE,SCANNABLE_TIME,SCANNABLE_TYPE,SUBNOSHOW_FIELDS,SUB_EDIT_STATE,SUB_TABLE_JUDGE_FIELD,UI_TMPL,DELETE_SQL,DETAIL_SQL,INSERT_SQL,LOCK_SQL,NEWID_SQL,OPRETION_HINT,SELECT_SQL,SUBSELECT_SQL,UPDATE_SQL) = (SELECT ,q''[]'',q''[]'',q''[]'',,q''[]'',q''[]'',,q''[]'',q''[]'',,q''[]'',1,q''[]'',q''[]'',q''[]'',q''[]'',q''[ask_record_id,log_id,factory_ask_id]'',,0,q''[]'',q''[]'',q''[20,30,50,100,200,500]'',,q''[]'',,,q''[]'',q''[]'',,,q''[]'',,q''[]'',q''[]'',:CV1,:CV2,:CV3,:CV4,:CV5,:CV6,:CV7,:CV8,:CV9 FROM DUAL) WHERE ITEM_ID = ''a_coop_106''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3,CV4,CV5,CV6,CV7,CV8,CV9;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_ITEM_LIST (AUTO_REFRESH,BACK_GROUND_ID,EDIT_EXPRESS,END_FIELD,EXECUTE_TIME,FOOTER,HEADER,HINT_TYPE,ITEM_ID,JUMP_EXPRESS,JUMP_FIELD,MAX_ROW_COUNT,MONITOR_ID,MULTI_PAGE_FLAG,NOADD_FIELDS,NOEDIT_FIELDS,NOMODIFY_FIELDS,NOSHOW_APP_FIELDS,NOSHOW_FIELDS,OPEN_MODE,OPERATE_TYPE,OPERATION_TYPE,OUTPUT_PARAMETER,PAGE_SIZES,QUERY_COUNT,QUERY_FIELDS,QUERY_TYPE,RFID_FLAG,SCANNABLE_FIELD,SCANNABLE_LOCATION_LINE,SCANNABLE_TIME,SCANNABLE_TYPE,SUBNOSHOW_FIELDS,SUB_EDIT_STATE,SUB_TABLE_JUDGE_FIELD,UI_TMPL,DELETE_SQL,DETAIL_SQL,INSERT_SQL,LOCK_SQL,NEWID_SQL,OPRETION_HINT,SELECT_SQL,SUBSELECT_SQL,UPDATE_SQL) SELECT ,q''[]'',q''[]'',q''[]'',,q''[]'',q''[]'',,''a_coop_106'',q''[]'',q''[]'',,q''[]'',1,q''[]'',q''[]'',q''[]'',q''[]'',q''[ask_record_id,log_id,factory_ask_id]'',,0,q''[]'',q''[]'',q''[20,30,50,100,200,500]'',,q''[]'',,,q''[]'',q''[]'',,,q''[]'',,q''[]'',q''[]'',:CV1,:CV2,:CV3,:CV4,:CV5,:CV6,:CV7,:CV8,:CV9 FROM DUAL';
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
  CV1 CLOB:=q'^^';
  CV2 CLOB:=q'^^';
  CV3 CLOB:=q'^--czh 重构逻辑
DECLARE
  p_ar_rec         scmdata.t_ask_record%ROWTYPE;
  v_logn_name      VARCHAR2(32);
  v_lice_num       VARCHAR2(32);
  v_be_company_id  VARCHAR2(32);
  v_supp_type_code VARCHAR2(32);
BEGIN
  SELECT MAX(logn_name), MAX(licence_num)
    INTO v_logn_name, v_lice_num
    FROM sys_company
   WHERE company_id = %default_company_id%;

  SELECT MAX(company_id), MAX(supplier_type_code)
    INTO v_be_company_id, v_supp_type_code
    FROM t_supplier_type
   WHERE supplier_type_id = :supplier_type_id;

  p_ar_rec.ask_record_id              := :ask_record_id;
  p_ar_rec.company_id                 := %default_company_id%;
  p_ar_rec.be_company_id              := v_be_company_id;
  p_ar_rec.company_name               := :ask_company_name;
  p_ar_rec.ask_user_id                := :user_id;
  p_ar_rec.company_address            := :company_address;
  p_ar_rec.cooperation_type           := v_supp_type_code;
  --p_ar_rec.cooperation_classification := :cooperation_classification;
  --p_ar_rec.cooperation_subcategory    := :cooperation_subcategory;
  p_ar_rec.cooperation_model          := :cooperation_model;
  p_ar_rec.ask_say                    := :ask_say;
  p_ar_rec.ask_date                   := :ask_date;
  p_ar_rec.certificate_file           := :certificate_file;
  p_ar_rec.other_file                 := :other_file;
  p_ar_rec.create_id                  := :user_id;
  p_ar_rec.create_date                := SYSDATE;
  p_ar_rec.update_id                  := :user_id;
  p_ar_rec.update_date                := SYSDATE;
  p_ar_rec.company_province           := :company_province;
  p_ar_rec.company_city               := :company_city;
  p_ar_rec.company_county             := :company_county;
  p_ar_rec.company_abbreviation       := :company_abbreviation;
  p_ar_rec.legal_representative       := :legal_representative;
  p_ar_rec.company_contact_phone      := :company_contact_phone;
  p_ar_rec.company_type               := :company_type;
  p_ar_rec.brand_type                 := :brand_type;
  p_ar_rec.cooperation_brand          := :cooperation_brand;
  p_ar_rec.product_link               := :product_link;
  p_ar_rec.coor_ask_flow_status       := 'CA00';
  p_ar_rec.company_name               := v_logn_name;
  p_ar_rec.social_credit_code         := v_lice_num;
  p_ar_rec.supplier_gate              := :supplier_gate;
  p_ar_rec.supplier_office            := :supplier_office;
  p_ar_rec.supplier_site              := :supplier_site;
  p_ar_rec.supplier_product           := :supplier_product;
  p_ar_rec.sapply_user                := :ask_user_name;
  p_ar_rec.sapply_phone               := :ask_user_phone;

  /*p_ar_rec.production_mode       := :production_mode;
  p_ar_rec.remarks               := :remarks;
  p_ar_rec.collection            := :collection;
  p_ar_rec.origin                := :origin;
  p_ar_rec.cooperation_statement := :cooperation_statement;
  p_ar_rec.sapply_user           := :sapply_user;
  p_ar_rec.sapply_phone          := :sapply_phone;*/

  scmdata.pkg_ask_record_mange.p_check_data_by_save(p_ar_rec => p_ar_rec,p_type   => 0);

  scmdata.pkg_ask_record_mange.p_insert_t_ask_record(p_ar_rec => p_ar_rec);

END;



--原有逻辑
/*declare
  p_id   varchar2(32);
  p_desc varchar2(256);
begin
  p_desc := :PCC;
  p_id   := :ask_record_id;
  insert into t_ask_record
    (ask_record_id,
     company_name,
     social_credit_code,
     ask_user_id,
     company_id,
     be_company_id,
     company_address,
     cooperation_type,
     cooperation_classification,
     cooperation_subcategory,
     cooperation_model,
     ask_say,
     certificate_file,
     other_file,
     create_id,
     create_date,
     update_id,
     update_date,
     company_province,
     company_city,
     company_county,
     company_abbreviation,
     legal_representative,
     company_contact_phone,
     company_type,
     COOPERATION_BRAND,
     product_link,
     coor_ask_flow_status)
  values
    (p_id,
     (select logn_name
        from sys_company
       where company_id = %default_company_id%),
     (select licence_num
        from sys_company
       where company_id = %default_company_id%),
     :user_id,
     %default_company_id%,
     (select company_id
        from t_supplier_type
       where supplier_type_id = :supplier_type_id),
     :company_address,
     (select supplier_type_code
        from t_supplier_type
       where supplier_type_id = :supplier_type_id),
     :cooperation_classification,
     :cooperation_subcategory,
     :cooperation_model,
     :ask_say,
     :CERTIFICATE_FILE,
     :other_file,
     :user_id,
     sysdate,
     :user_id,
     sysdate,
     :company_province,
     :company_city,
     :company_county,
     :company_abbreviation,
     :legal_representative,
     :company_contact_phone,
     :company_type_desc,
     :COOPERATION_BRAND_DESC,
     :product_link,
     'CA00');
end;*/^';
  CV4 CLOB:=q'^^';
  CV5 CLOB:=q'^select pkg_plat_comm.f_getkeyid_plat(pi_pre     => 'HZ',
                                       pi_seqname => 'SEQ_T_ASK_RECORD',
                                       pi_seqnum  => 99) ask_record_id from dual^';
  CV6 CLOB:=q'^^';
  CV7 CLOB:=q'^--czh 重构代码
{DECLARE
  v_sql CLOB;
BEGIN
  v_sql      := pkg_ask_record_mange.f_query_coop_fp_supplier(p_type => 0);
  ^'|| CHR(64) ||q'^strresult := v_sql;
END;}

--原有逻辑
/*select a.ask_record_id,
       a.company_id,
       a.be_company_id,
       a.company_name ASK_COMPANY_NAME,
       a.company_abbreviation,
       a.ask_date,
       a.ask_user_id,
       a.social_credit_code,
      (select company_user_name from sys_company_user where user_id =a.ask_user_id and company_id= nvl(a.company_id,a.be_company_id)) ask_user_name,
       a.company_province,
       a.company_city,
       a.company_county,
       dp.province || dc.city || dco.county PCC,
       u.phone ask_user_phone,
       a.company_address,
       a.cooperation_type,
       ga.group_dict_name cooperation_type_desc,
       a.cooperation_model,
       a.ask_say,
       a.certificate_file,
       a.other_file,
       a.legal_representative,
       a.company_contact_phone,
       a.company_type,
       a.COOPERATION_BRAND,
       a.product_link
  from t_ask_record a
 inner join sys_user u
    on a.ask_user_id = u.user_id
 inner join sys_group_dict ga
    on a.cooperation_type = ga.group_dict_value
   and ga.group_dict_type = 'COOPERATION_TYPE'
  left join dic_province dp
    on a.company_province = to_char(dp.provinceid)
  left join dic_city dc
    on a.company_city = to_char(dc.cityno)
  left join dic_county dco
    on a.company_county = to_char(dco.countyid)
 where a.company_id = %default_company_id%
   and a.COOR_ASK_FLOW_STATUS in ('CA00')
   and be_company_id =
       (select company_id
          from t_supplier_type
         where supplier_type_id = :supplier_type_id)
 order by create_date desc*/^';
  CV8 CLOB:=q'^^';
  CV9 CLOB:=q'^--czh 重构逻辑
DECLARE
  p_ar_rec scmdata.t_ask_record%ROWTYPE;
BEGIN
  p_ar_rec.ask_record_id              := :ask_record_id;
  p_ar_rec.be_company_id              := :be_company_id;
  p_ar_rec.company_name               := :ask_company_name;
  p_ar_rec.company_address            := :company_address;
  p_ar_rec.cooperation_type           := :cooperation_type;
  --p_ar_rec.cooperation_classification := :cooperation_classification;
  --p_ar_rec.cooperation_subcategory    := :cooperation_subcategory;
  p_ar_rec.cooperation_model          := :cooperation_model;
  p_ar_rec.ask_say                    := :ask_say;
  p_ar_rec.ask_date                   := :ask_date;
  p_ar_rec.certificate_file           := :certificate_file;
  p_ar_rec.other_file                 := :other_file;
  p_ar_rec.update_id                  := :user_id;
  p_ar_rec.update_date                := SYSDATE;
  p_ar_rec.company_province           := :company_province;
  p_ar_rec.company_city               := :company_city;
  p_ar_rec.company_county             := :company_county;
  p_ar_rec.company_abbreviation       := :company_abbreviation;
  p_ar_rec.legal_representative       := :legal_representative;
  p_ar_rec.company_contact_phone      := :company_contact_phone;
  p_ar_rec.company_type               := :company_type;
  p_ar_rec.brand_type                 := :brand_type;
  p_ar_rec.cooperation_brand          := :cooperation_brand;
  p_ar_rec.product_link               := :product_link;
  p_ar_rec.supplier_gate              := :supplier_gate;
  p_ar_rec.supplier_office            := :supplier_office;
  p_ar_rec.supplier_site              := :supplier_site;
  p_ar_rec.supplier_product           := :supplier_product;
  p_ar_rec.sapply_user                := :ask_user_name;
  p_ar_rec.sapply_phone               := :ask_user_phone;

  /*  p_ar_rec.ask_user_id := :user_id;
  p_ar_rec.company_name               := v_logn_name;
  p_ar_rec.social_credit_code         := v_lice_num;;*/

  scmdata.pkg_ask_record_mange.p_check_data_by_save(p_ar_rec => p_ar_rec,p_type   => 0);

  scmdata.pkg_ask_record_mange.p_update_t_ask_record(p_ar_rec => p_ar_rec);

END;

--原有逻辑
/*declare
p_status varchar2(32);
  p_desc varchar2(256);
begin
  p_desc:=:PCC;
  select a.coor_ask_flow_status into p_status from t_ask_record a where a.ask_record_id=:ask_record_id;
  if p_status = 'CA01' then
    raise_application_error(-20002, '已提交的申请不能重新修改');
  end if;

  update  t_ask_record set company_address=:company_address,
                    cooperation_type=:cooperation_type,
                    cooperation_classification=:cooperation_classification,
                    cooperation_subcategory=:cooperation_subcategory,
                    cooperation_model=:cooperation_model,
                    ask_say=:ask_say,
                    certificate_file=:certificate_file,
                    other_file=:other_file,
                    update_id=:user_id,
                    update_date=sysdate,
                    company_province=:company_province,company_city=:company_city,company_county=:company_county,
                    company_abbreviation =:company_abbreviation,company_contact_phone = :company_contact_phone,
                    legal_representative = :legal_representative,
                    company_type = :company_type_desc,COOPERATION_BRAND = :COOPERATION_BRAND_DESC,
                    product_link = :product_link
                    where       ask_record_id=:ask_record_id;
end;*/^';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_ITEM_LIST WHERE ITEM_ID = ''a_coop_121''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_ITEM_LIST SET (AUTO_REFRESH,BACK_GROUND_ID,EDIT_EXPRESS,END_FIELD,EXECUTE_TIME,FOOTER,HEADER,HINT_TYPE,JUMP_EXPRESS,JUMP_FIELD,MAX_ROW_COUNT,MONITOR_ID,MULTI_PAGE_FLAG,NOADD_FIELDS,NOEDIT_FIELDS,NOMODIFY_FIELDS,NOSHOW_APP_FIELDS,NOSHOW_FIELDS,OPEN_MODE,OPERATE_TYPE,OPERATION_TYPE,OUTPUT_PARAMETER,PAGE_SIZES,QUERY_COUNT,QUERY_FIELDS,QUERY_TYPE,RFID_FLAG,SCANNABLE_FIELD,SCANNABLE_LOCATION_LINE,SCANNABLE_TIME,SCANNABLE_TYPE,SUBNOSHOW_FIELDS,SUB_EDIT_STATE,SUB_TABLE_JUDGE_FIELD,UI_TMPL,DELETE_SQL,DETAIL_SQL,INSERT_SQL,LOCK_SQL,NEWID_SQL,OPRETION_HINT,SELECT_SQL,SUBSELECT_SQL,UPDATE_SQL) = (SELECT 3,q''[]'',q''[]'',q''[]'',,q''[为了增加双方的合作机会，建议您上传更多的真实资料：如公司简介、营业执照照片、产品照片等资料。]'',q''[]'',,q''[]'',q''[]'',,q''[]'',1,q''[]'',q''[]'',q''[]'',q''[]'',q''[cooperation_model,production_mode,brand_type]'',,0,q''[]'',q''[]'',q''[20,30,50,100,200,500]'',,q''[]'',0,,q''[]'',q''[]'',,,q''[]'',,q''[]'',q''[]'',:CV1,:CV2,:CV3,:CV4,:CV5,:CV6,:CV7,:CV8,:CV9 FROM DUAL) WHERE ITEM_ID = ''a_coop_121''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3,CV4,CV5,CV6,CV7,CV8,CV9;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_ITEM_LIST (AUTO_REFRESH,BACK_GROUND_ID,EDIT_EXPRESS,END_FIELD,EXECUTE_TIME,FOOTER,HEADER,HINT_TYPE,ITEM_ID,JUMP_EXPRESS,JUMP_FIELD,MAX_ROW_COUNT,MONITOR_ID,MULTI_PAGE_FLAG,NOADD_FIELDS,NOEDIT_FIELDS,NOMODIFY_FIELDS,NOSHOW_APP_FIELDS,NOSHOW_FIELDS,OPEN_MODE,OPERATE_TYPE,OPERATION_TYPE,OUTPUT_PARAMETER,PAGE_SIZES,QUERY_COUNT,QUERY_FIELDS,QUERY_TYPE,RFID_FLAG,SCANNABLE_FIELD,SCANNABLE_LOCATION_LINE,SCANNABLE_TIME,SCANNABLE_TYPE,SUBNOSHOW_FIELDS,SUB_EDIT_STATE,SUB_TABLE_JUDGE_FIELD,UI_TMPL,DELETE_SQL,DETAIL_SQL,INSERT_SQL,LOCK_SQL,NEWID_SQL,OPRETION_HINT,SELECT_SQL,SUBSELECT_SQL,UPDATE_SQL) SELECT 3,q''[]'',q''[]'',q''[]'',,q''[为了增加双方的合作机会，建议您上传更多的真实资料：如公司简介、营业执照照片、产品照片等资料。]'',q''[]'',,''a_coop_121'',q''[]'',q''[]'',,q''[]'',1,q''[]'',q''[]'',q''[]'',q''[]'',q''[cooperation_model,production_mode,brand_type]'',,0,q''[]'',q''[]'',q''[20,30,50,100,200,500]'',,q''[]'',0,,q''[]'',q''[]'',,,q''[]'',,q''[]'',q''[]'',:CV1,:CV2,:CV3,:CV4,:CV5,:CV6,:CV7,:CV8,:CV9 FROM DUAL';
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
  CV1 CLOB:=q'^^';
  CV2 CLOB:=q'^^';
  CV3 CLOB:=q'^^';
  CV4 CLOB:=q'^^';
  CV5 CLOB:=q'^^';
  CV6 CLOB:=q'^^';
  CV7 CLOB:=q'^select ask_record_id,
       ask_company_name,
       be_company_id,
       be_ask_company_name,
       case
         when flow_status in ('FA01','FA02', 'FA03', 'FA11') then
          'CA01'
         else
          flow_status
       end flow_status,
       substr(fals.group_dict_name, 0, instr(fals.group_dict_name, '+') - 1) FLOW_NODE_NAME,
       substr(fals.group_dict_name,
              instr(fals.group_dict_name, '+') + 1,
              length(fals.group_dict_name)) FLOW_NODE_STATUS_DESC,
       back_reason,
       ask_user_name,
       ask_date
  from (select a.ask_record_id,
               b.logn_name ask_company_name,
               a.be_company_id,

               c.logn_name be_ask_company_name,
               nvl(fa.factrory_ask_flow_status, a.coor_ask_flow_status) flow_status,
               (select remarks
                  from (select remarks
                          from t_factory_ask_oper_log
                         where ask_record_id = a.ask_record_id
                           and (fa.factrory_ask_flow_status is null or
                               fa.factrory_ask_flow_status not in
                               ('FA22', 'FA32'))
                         order by oper_time desc)
                 where rownum <= 1) back_reason,
                (select company_user_name from sys_company_user where user_id =a.ask_user_id and company_id= a.company_id) ask_user_name,
               a.ask_date
          from T_ASK_RECORD a
          left join sys_company b
            on a.company_id = b.company_id
          left join sys_company c
            on a.be_company_id = c.company_id

          left join t_factory_ask fa
            on fa.factory_ask_id =
               (select factory_ask_id
                  from t_factory_ask
                 where update_date = (select max(update_date)
                                        from t_factory_ask
                                       where ask_record_id = a.ask_record_id
                                         and factrory_ask_flow_status not in
                                             ('FA01', 'CA01')))
         where COOR_ASK_FLOW_STATUS is not null
           and a.company_id = %default_company_id%) ttt
  left join sys_group_dict fals
    on ttt.flow_status = fals.group_dict_value
   and fals.group_dict_type = 'FACTORY_ASK_FLOW'^';
  CV8 CLOB:=q'^^';
  CV9 CLOB:=q'^/*declare
begin

  update  t_ask_record set company_address=:company_address,
                    cooperation_type=:cooperation_type,
                    cooperation_classification=:cooperation_classification,
                    cooperation_subcategory=:cooperation_subcategory,
                    cooperation_model=:cooperation_model,
                    production_mode=:production_mode,
                    ask_say=:ask_say,
                    certificate_file=:certificate_file,
                    other_file=:other_file,
                    update_id=:update_id,
                    update_date=:update_date
                    where       ask_record_id=:ask_record_id;
end;*/^';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_ITEM_LIST WHERE ITEM_ID = ''a_coop_130''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_ITEM_LIST SET (AUTO_REFRESH,BACK_GROUND_ID,EDIT_EXPRESS,END_FIELD,EXECUTE_TIME,FOOTER,HEADER,HINT_TYPE,JUMP_EXPRESS,JUMP_FIELD,MAX_ROW_COUNT,MONITOR_ID,MULTI_PAGE_FLAG,NOADD_FIELDS,NOEDIT_FIELDS,NOMODIFY_FIELDS,NOSHOW_APP_FIELDS,NOSHOW_FIELDS,OPEN_MODE,OPERATE_TYPE,OPERATION_TYPE,OUTPUT_PARAMETER,PAGE_SIZES,QUERY_COUNT,QUERY_FIELDS,QUERY_TYPE,RFID_FLAG,SCANNABLE_FIELD,SCANNABLE_LOCATION_LINE,SCANNABLE_TIME,SCANNABLE_TYPE,SUBNOSHOW_FIELDS,SUB_EDIT_STATE,SUB_TABLE_JUDGE_FIELD,UI_TMPL,DELETE_SQL,DETAIL_SQL,INSERT_SQL,LOCK_SQL,NEWID_SQL,OPRETION_HINT,SELECT_SQL,SUBSELECT_SQL,UPDATE_SQL) = (SELECT ,q''[]'',q''[]'',q''[]'',,q''[]'',q''[]'',,q''[]'',q''[]'',,q''[]'',1,q''[]'',q''[]'',q''[]'',q''[]'',q''[flow_status,ask_company_name,be_company_id]'',,0,q''[]'',q''[]'',q''[20,30,50,100,200,500]'',,q''[ask_record_id,be_ask_company_name]'',12,,q''[]'',q''[]'',,,q''[]'',,q''[]'',q''[]'',:CV1,:CV2,:CV3,:CV4,:CV5,:CV6,:CV7,:CV8,:CV9 FROM DUAL) WHERE ITEM_ID = ''a_coop_130''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3,CV4,CV5,CV6,CV7,CV8,CV9;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_ITEM_LIST (AUTO_REFRESH,BACK_GROUND_ID,EDIT_EXPRESS,END_FIELD,EXECUTE_TIME,FOOTER,HEADER,HINT_TYPE,ITEM_ID,JUMP_EXPRESS,JUMP_FIELD,MAX_ROW_COUNT,MONITOR_ID,MULTI_PAGE_FLAG,NOADD_FIELDS,NOEDIT_FIELDS,NOMODIFY_FIELDS,NOSHOW_APP_FIELDS,NOSHOW_FIELDS,OPEN_MODE,OPERATE_TYPE,OPERATION_TYPE,OUTPUT_PARAMETER,PAGE_SIZES,QUERY_COUNT,QUERY_FIELDS,QUERY_TYPE,RFID_FLAG,SCANNABLE_FIELD,SCANNABLE_LOCATION_LINE,SCANNABLE_TIME,SCANNABLE_TYPE,SUBNOSHOW_FIELDS,SUB_EDIT_STATE,SUB_TABLE_JUDGE_FIELD,UI_TMPL,DELETE_SQL,DETAIL_SQL,INSERT_SQL,LOCK_SQL,NEWID_SQL,OPRETION_HINT,SELECT_SQL,SUBSELECT_SQL,UPDATE_SQL) SELECT ,q''[]'',q''[]'',q''[]'',,q''[]'',q''[]'',,''a_coop_130'',q''[]'',q''[]'',,q''[]'',1,q''[]'',q''[]'',q''[]'',q''[]'',q''[flow_status,ask_company_name,be_company_id]'',,0,q''[]'',q''[]'',q''[20,30,50,100,200,500]'',,q''[ask_record_id,be_ask_company_name]'',12,,q''[]'',q''[]'',,,q''[]'',,q''[]'',q''[]'',:CV1,:CV2,:CV3,:CV4,:CV5,:CV6,:CV7,:CV8,:CV9 FROM DUAL';
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
  CV1 CLOB:=q'^^';
  CV2 CLOB:=q'^^';
  CV3 CLOB:=q'^^';
  CV4 CLOB:=q'^^';
  CV5 CLOB:=q'^^';
  CV6 CLOB:=q'^^';
  CV7 CLOB:=q'^--czh 代码封装
{
DECLARE
  v_sql           CLOB;
BEGIN
  v_sql      := scmdata.pkg_ask_record_mange.f_query_flow_status_logger(p_ask_record_id => :ask_record_id,p_ask_fac_id => NULL);
  ^'|| CHR(64) ||q'^strresult := v_sql;
END;
}^';
  CV8 CLOB:=q'^^';
  CV9 CLOB:=q'^^';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_ITEM_LIST WHERE ITEM_ID = ''a_coop_133_1''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_ITEM_LIST SET (AUTO_REFRESH,BACK_GROUND_ID,EDIT_EXPRESS,END_FIELD,EXECUTE_TIME,FOOTER,HEADER,HINT_TYPE,JUMP_EXPRESS,JUMP_FIELD,MAX_ROW_COUNT,MONITOR_ID,MULTI_PAGE_FLAG,NOADD_FIELDS,NOEDIT_FIELDS,NOMODIFY_FIELDS,NOSHOW_APP_FIELDS,NOSHOW_FIELDS,OPEN_MODE,OPERATE_TYPE,OPERATION_TYPE,OUTPUT_PARAMETER,PAGE_SIZES,QUERY_COUNT,QUERY_FIELDS,QUERY_TYPE,RFID_FLAG,SCANNABLE_FIELD,SCANNABLE_LOCATION_LINE,SCANNABLE_TIME,SCANNABLE_TYPE,SUBNOSHOW_FIELDS,SUB_EDIT_STATE,SUB_TABLE_JUDGE_FIELD,UI_TMPL,DELETE_SQL,DETAIL_SQL,INSERT_SQL,LOCK_SQL,NEWID_SQL,OPRETION_HINT,SELECT_SQL,SUBSELECT_SQL,UPDATE_SQL) = (SELECT ,q''[]'',q''[]'',q''[]'',,q''[]'',q''[]'',,q''[]'',q''[]'',,q''[]'',1,q''[]'',q''[]'',q''[]'',q''[]'',q''[ask_record_id,log_id,status_bf_oper,flow_node_status_desc_bf,flow_node_name_af,flow_node_status_desc_af]'',,0,q''[]'',q''[]'',q''[20,30,50,100,200,500]'',,q''[]'',0,,q''[]'',q''[]'',,,q''[]'',,q''[]'',q''[]'',:CV1,:CV2,:CV3,:CV4,:CV5,:CV6,:CV7,:CV8,:CV9 FROM DUAL) WHERE ITEM_ID = ''a_coop_133_1''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3,CV4,CV5,CV6,CV7,CV8,CV9;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_ITEM_LIST (AUTO_REFRESH,BACK_GROUND_ID,EDIT_EXPRESS,END_FIELD,EXECUTE_TIME,FOOTER,HEADER,HINT_TYPE,ITEM_ID,JUMP_EXPRESS,JUMP_FIELD,MAX_ROW_COUNT,MONITOR_ID,MULTI_PAGE_FLAG,NOADD_FIELDS,NOEDIT_FIELDS,NOMODIFY_FIELDS,NOSHOW_APP_FIELDS,NOSHOW_FIELDS,OPEN_MODE,OPERATE_TYPE,OPERATION_TYPE,OUTPUT_PARAMETER,PAGE_SIZES,QUERY_COUNT,QUERY_FIELDS,QUERY_TYPE,RFID_FLAG,SCANNABLE_FIELD,SCANNABLE_LOCATION_LINE,SCANNABLE_TIME,SCANNABLE_TYPE,SUBNOSHOW_FIELDS,SUB_EDIT_STATE,SUB_TABLE_JUDGE_FIELD,UI_TMPL,DELETE_SQL,DETAIL_SQL,INSERT_SQL,LOCK_SQL,NEWID_SQL,OPRETION_HINT,SELECT_SQL,SUBSELECT_SQL,UPDATE_SQL) SELECT ,q''[]'',q''[]'',q''[]'',,q''[]'',q''[]'',,''a_coop_133_1'',q''[]'',q''[]'',,q''[]'',1,q''[]'',q''[]'',q''[]'',q''[]'',q''[ask_record_id,log_id,status_bf_oper,flow_node_status_desc_bf,flow_node_name_af,flow_node_status_desc_af]'',,0,q''[]'',q''[]'',q''[20,30,50,100,200,500]'',,q''[]'',0,,q''[]'',q''[]'',,,q''[]'',,q''[]'',q''[]'',:CV1,:CV2,:CV3,:CV4,:CV5,:CV6,:CV7,:CV8,:CV9 FROM DUAL';
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
  CV1 CLOB:=q'^^';
  CV2 CLOB:=q'^^';
  CV3 CLOB:=q'^^';
  CV4 CLOB:=q'^^';
  CV5 CLOB:=q'^^';
  CV6 CLOB:=q'^^';
  CV7 CLOB:=q'^--czh 20221102 v9.10
{DECLARE
  v_sql        CLOB;
  v_data_privs VARCHAR2(2000);
BEGIN
  v_data_privs := scmdata.pkg_data_privs.parse_json(p_jsonstr => %data_privs_json_strs%,
                                                    p_key     => 'COL_2');
  v_sql        := scmdata.pkg_ask_record_mange.f_query_coop_supp_list(p_data_privs => v_data_privs);
  ^'|| CHR(64) ||q'^strresult   := v_sql;
END;}^';
  CV8 CLOB:=q'^^';
  CV9 CLOB:=q'^^';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_ITEM_LIST WHERE ITEM_ID = ''a_coop_150''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_ITEM_LIST SET (AUTO_REFRESH,BACK_GROUND_ID,EDIT_EXPRESS,END_FIELD,EXECUTE_TIME,FOOTER,HEADER,HINT_TYPE,JUMP_EXPRESS,JUMP_FIELD,MAX_ROW_COUNT,MONITOR_ID,MULTI_PAGE_FLAG,NOADD_FIELDS,NOEDIT_FIELDS,NOMODIFY_FIELDS,NOSHOW_APP_FIELDS,NOSHOW_FIELDS,OPEN_MODE,OPERATE_TYPE,OPERATION_TYPE,OUTPUT_PARAMETER,PAGE_SIZES,QUERY_COUNT,QUERY_FIELDS,QUERY_TYPE,RFID_FLAG,SCANNABLE_FIELD,SCANNABLE_LOCATION_LINE,SCANNABLE_TIME,SCANNABLE_TYPE,SUBNOSHOW_FIELDS,SUB_EDIT_STATE,SUB_TABLE_JUDGE_FIELD,UI_TMPL,DELETE_SQL,DETAIL_SQL,INSERT_SQL,LOCK_SQL,NEWID_SQL,OPRETION_HINT,SELECT_SQL,SUBSELECT_SQL,UPDATE_SQL) = (SELECT ,q''[]'',q''[]'',q''[]'',,q''[]'',q''[]'',,q''[]'',q''[]'',,q''[]'',1,q''[]'',q''[]'',q''[]'',q''[]'',q''[ASK_RECORD_ID,COOR_ASK_FLOW_STATUS,COOPERATION_TYPE,COOPERATION_CLASSIFICATION,COOPERATION_SUBCATEGORY,COOPERATION_MODEL,PRODUCTION_MODE,BE_COMPANY_ID,ASK_USER_ID,COMPANY_ID,FACTORY_ASK_ID,COOPERATION_PRODUCT_CATE,status_af_oper]'',,0,q''[]'',q''[]'',q''[20,30,50,100,200,500]'',,q''[AR_COMPANY_NAME_N,AR_COMPANY_ABBREVIATION_N]'',13,,q''[]'',q''[]'',,,q''[]'',,q''[]'',q''[]'',:CV1,:CV2,:CV3,:CV4,:CV5,:CV6,:CV7,:CV8,:CV9 FROM DUAL) WHERE ITEM_ID = ''a_coop_150''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3,CV4,CV5,CV6,CV7,CV8,CV9;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_ITEM_LIST (AUTO_REFRESH,BACK_GROUND_ID,EDIT_EXPRESS,END_FIELD,EXECUTE_TIME,FOOTER,HEADER,HINT_TYPE,ITEM_ID,JUMP_EXPRESS,JUMP_FIELD,MAX_ROW_COUNT,MONITOR_ID,MULTI_PAGE_FLAG,NOADD_FIELDS,NOEDIT_FIELDS,NOMODIFY_FIELDS,NOSHOW_APP_FIELDS,NOSHOW_FIELDS,OPEN_MODE,OPERATE_TYPE,OPERATION_TYPE,OUTPUT_PARAMETER,PAGE_SIZES,QUERY_COUNT,QUERY_FIELDS,QUERY_TYPE,RFID_FLAG,SCANNABLE_FIELD,SCANNABLE_LOCATION_LINE,SCANNABLE_TIME,SCANNABLE_TYPE,SUBNOSHOW_FIELDS,SUB_EDIT_STATE,SUB_TABLE_JUDGE_FIELD,UI_TMPL,DELETE_SQL,DETAIL_SQL,INSERT_SQL,LOCK_SQL,NEWID_SQL,OPRETION_HINT,SELECT_SQL,SUBSELECT_SQL,UPDATE_SQL) SELECT ,q''[]'',q''[]'',q''[]'',,q''[]'',q''[]'',,''a_coop_150'',q''[]'',q''[]'',,q''[]'',1,q''[]'',q''[]'',q''[]'',q''[]'',q''[ASK_RECORD_ID,COOR_ASK_FLOW_STATUS,COOPERATION_TYPE,COOPERATION_CLASSIFICATION,COOPERATION_SUBCATEGORY,COOPERATION_MODEL,PRODUCTION_MODE,BE_COMPANY_ID,ASK_USER_ID,COMPANY_ID,FACTORY_ASK_ID,COOPERATION_PRODUCT_CATE,status_af_oper]'',,0,q''[]'',q''[]'',q''[20,30,50,100,200,500]'',,q''[AR_COMPANY_NAME_N,AR_COMPANY_ABBREVIATION_N]'',13,,q''[]'',q''[]'',,,q''[]'',,q''[]'',q''[]'',:CV1,:CV2,:CV3,:CV4,:CV5,:CV6,:CV7,:CV8,:CV9 FROM DUAL';
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
  CV1 CLOB:=q'^^';
  CV2 CLOB:=q'^^';
  CV3 CLOB:=q'^^';
  CV4 CLOB:=q'^^';
  CV5 CLOB:=q'^^';
  CV6 CLOB:=q'^^';
  CV7 CLOB:=q'^select a.company_id,a.logo,a.company_name,a.logn_name,a.tips,
       a.is_open,a.attributor_id,nvl(c.COMPANY_USER_NAME,b.username) attributor,a.create_time,dp.province || dci.city || dc.county area,a.address,
       a.product,a.rival,a.licence_type,a.licence_num
  from (select * from scmdata.sys_company WHERE LOGN_NAME=%ASS_ASK_COMPANY_NAME%) a
 left join sys_user b on a.attributor_id=b.user_id
 left join sys_company_user c on b.user_id=c.user_id and a.company_id=c.company_id
   left join scmdata.dic_province dp
    on dp.provinceid = a.company_province
  left join scmdata.dic_county dc
    on a.company_county = dc.countyid
  left join scmdata.dic_city dci
    on dci.cityno = a.company_city^';
  CV8 CLOB:=q'^^';
  CV9 CLOB:=q'^^';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_ITEM_LIST WHERE ITEM_ID = ''a_coop_150_0''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_ITEM_LIST SET (AUTO_REFRESH,BACK_GROUND_ID,EDIT_EXPRESS,END_FIELD,EXECUTE_TIME,FOOTER,HEADER,HINT_TYPE,JUMP_EXPRESS,JUMP_FIELD,MAX_ROW_COUNT,MONITOR_ID,MULTI_PAGE_FLAG,NOADD_FIELDS,NOEDIT_FIELDS,NOMODIFY_FIELDS,NOSHOW_APP_FIELDS,NOSHOW_FIELDS,OPEN_MODE,OPERATE_TYPE,OPERATION_TYPE,OUTPUT_PARAMETER,PAGE_SIZES,QUERY_COUNT,QUERY_FIELDS,QUERY_TYPE,RFID_FLAG,SCANNABLE_FIELD,SCANNABLE_LOCATION_LINE,SCANNABLE_TIME,SCANNABLE_TYPE,SUBNOSHOW_FIELDS,SUB_EDIT_STATE,SUB_TABLE_JUDGE_FIELD,UI_TMPL,DELETE_SQL,DETAIL_SQL,INSERT_SQL,LOCK_SQL,NEWID_SQL,OPRETION_HINT,SELECT_SQL,SUBSELECT_SQL,UPDATE_SQL) = (SELECT ,q''[]'',q''[]'',q''[]'',,q''[]'',q''[]'',,q''[]'',q''[]'',,q''[]'',0,q''[]'',q''[]'',q''[]'',q''[]'',q''[COMPANY_ID]'',,0,q''[]'',q''[]'',q''[]'',,q''[]'',0,,q''[]'',q''[]'',,,q''[]'',,q''[]'',q''[]'',:CV1,:CV2,:CV3,:CV4,:CV5,:CV6,:CV7,:CV8,:CV9 FROM DUAL) WHERE ITEM_ID = ''a_coop_150_0''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3,CV4,CV5,CV6,CV7,CV8,CV9;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_ITEM_LIST (AUTO_REFRESH,BACK_GROUND_ID,EDIT_EXPRESS,END_FIELD,EXECUTE_TIME,FOOTER,HEADER,HINT_TYPE,ITEM_ID,JUMP_EXPRESS,JUMP_FIELD,MAX_ROW_COUNT,MONITOR_ID,MULTI_PAGE_FLAG,NOADD_FIELDS,NOEDIT_FIELDS,NOMODIFY_FIELDS,NOSHOW_APP_FIELDS,NOSHOW_FIELDS,OPEN_MODE,OPERATE_TYPE,OPERATION_TYPE,OUTPUT_PARAMETER,PAGE_SIZES,QUERY_COUNT,QUERY_FIELDS,QUERY_TYPE,RFID_FLAG,SCANNABLE_FIELD,SCANNABLE_LOCATION_LINE,SCANNABLE_TIME,SCANNABLE_TYPE,SUBNOSHOW_FIELDS,SUB_EDIT_STATE,SUB_TABLE_JUDGE_FIELD,UI_TMPL,DELETE_SQL,DETAIL_SQL,INSERT_SQL,LOCK_SQL,NEWID_SQL,OPRETION_HINT,SELECT_SQL,SUBSELECT_SQL,UPDATE_SQL) SELECT ,q''[]'',q''[]'',q''[]'',,q''[]'',q''[]'',,''a_coop_150_0'',q''[]'',q''[]'',,q''[]'',0,q''[]'',q''[]'',q''[]'',q''[]'',q''[COMPANY_ID]'',,0,q''[]'',q''[]'',q''[]'',,q''[]'',0,,q''[]'',q''[]'',,,q''[]'',,q''[]'',q''[]'',:CV1,:CV2,:CV3,:CV4,:CV5,:CV6,:CV7,:CV8,:CV9 FROM DUAL';
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
  CV1 CLOB:=q'^^';
  CV2 CLOB:=q'^^';
  CV3 CLOB:=q'^^';
  CV4 CLOB:=q'^^';
  CV5 CLOB:=q'^SELECT SCMDATA.F_GETKEYID_PLAT('CA', 'seq_ca') FACTORY_ASK_ID FROM DUAL^';
  CV6 CLOB:=q'^^';
  CV7 CLOB:=q'^--czh 20221103 v9.10
{
DECLARE
  v_sql           CLOB;
  v_object_id VARCHAR2(32);
  v_rest_method   VARCHAR2(256);
  v_params        VARCHAR2(2000);
  v_item_id       VARCHAR(256);
BEGIN
  --获取asscoiate请求参数
  pkg_plat_comm.p_get_rest_val_method_params(p_character     => %ass_ask_record_id%,
                                             po_pk_id        => v_object_id,
                                             po_rest_methods => v_rest_method,
                                             po_params       => v_params);
  v_rest_method := nvl(v_rest_method, 'GET');
  IF instr(';' || v_rest_method || ';', ';' || 'GET' || ';') > 0 THEN
    v_item_id := plm.pkg_plat_comm.parse_json(p_jsonstr => v_params,
                                              p_key     => 'item_id');
    v_item_id := NVL(v_item_id,(CASE
             WHEN :factory_ask_id IS NULL THEN
              'a_coop_150_3'
             ELSE
              'a_coop_211'
           END));
    v_sql      := pkg_ask_record_mange.f_query_factory_ask(p_item_id => v_item_id,p_object_id => nvl(v_object_id,:factory_ask_id));
  ELSE
    v_sql := NULL;
  END IF;
  ^'|| CHR(64) ||q'^strresult := v_sql;
END;
}^';
  CV8 CLOB:=q'^^';
  CV9 CLOB:=q'^--czh 20221103 v9.10
{
DECLARE
  v_sql            CLOB;
  v_ask_record_id  VARCHAR2(32);
  v_factory_ask_id VARCHAR2(32);
  v_rest_method    VARCHAR2(256);
  v_params         VARCHAR2(2000);
  v_item_id        VARCHAR(256);
BEGIN
  --获取asscoiate请求参数
  pkg_plat_comm.p_get_rest_val_method_params(p_character     => %ass_ask_record_id%,
                                             po_pk_id        => v_ask_record_id,
                                             po_rest_methods => v_rest_method,
                                             po_params       => v_params);
  IF instr(';' || v_rest_method || ';', ';' || 'PUT' || ';') > 0 THEN

    SELECT MAX(t.factory_ask_id)
      INTO v_factory_ask_id
      FROM scmdata.t_factory_ask t
     WHERE t.ask_record_id = v_ask_record_id
       AND t.company_id = %default_company_id%;

    v_sql := q'[DECLARE
    p_fa_rec         scmdata.t_factory_ask%ROWTYPE;
    v_factory_ask_id VARCHAR2(32) := ']' || v_factory_ask_id || q'[';
  BEGIN
    p_fa_rec.factory_ask_id := v_factory_ask_id;
    p_fa_rec.company_id := :company_id;
    --申请信息
    p_fa_rec.ask_user_id       := :fa_check_person_y;
    p_fa_rec.ask_user_dept_id  := :fa_check_dept_name_y;
    p_fa_rec.is_urgent         := :fa_is_urgent_n;
    p_fa_rec.cooperation_model := :ar_cooperation_model_y;
    p_fa_rec.product_type      := :ar_product_type_y;
    p_fa_rec.pay_term          := :ar_pay_term_n;
    p_fa_rec.ask_say           := :fa_ask_say_y;
    --基本信息
    p_fa_rec.company_name          := :ar_company_name_y;
    p_fa_rec.company_abbreviation  := :ar_company_abbreviation_y;
    p_fa_rec.company_province      := :company_province;
    p_fa_rec.company_city          := :company_city;
    p_fa_rec.company_county        := :company_county;
    p_fa_rec.company_vill          := :ar_company_vill_y;
    p_fa_rec.company_address       := :ar_company_address_y;
    p_fa_rec.company_regist_date   := :ar_company_regist_date_y;
    p_fa_rec.legal_representative  := :ar_legal_representative_n;
    p_fa_rec.company_contact_phone := :ar_company_contact_phone_n;
    p_fa_rec.contact_name          := :ar_sapply_user_y;
    p_fa_rec.contact_phone         := :ar_sapply_phone_y;
    p_fa_rec.company_type          := :ar_company_type_y;
    p_fa_rec.brand_type            := :brand_type;
    p_fa_rec.cooperation_brand     := :cooperation_brand;
    p_fa_rec.product_link          := :ar_product_link_n;
    p_fa_rec.rela_supplier_id      := :ar_rela_supplier_id_n;
    p_fa_rec.is_our_factory        := :ar_is_our_factory_y;
    p_fa_rec.factory_name          := :ar_factory_name_y;
    p_fa_rec.factory_province      := :factory_province;
    p_fa_rec.factory_city          := :factory_city;
    p_fa_rec.factory_county        := :factory_county;
    p_fa_rec.factory_vill          := :ar_factory_vill_y;
    p_fa_rec.ask_address           := :ar_factroy_details_address_y;
    p_fa_rec.factroy_area          := :ar_factroy_area_y;
    p_fa_rec.remarks               := :ar_remarks_n;
    --生产信息
    p_fa_rec.product_line       := :ar_product_line_n;
    p_fa_rec.product_line_num   := :ar_product_line_num_n;
    p_fa_rec.quality_step       := :ar_quality_step_n;
    p_fa_rec.work_hours_day     := :ar_work_hours_day_y;
    p_fa_rec.machine_num        := :ar_machine_num_y;
    p_fa_rec.product_efficiency := :ar_product_efficiency_y;
    p_fa_rec.fabric_check_cap   := :ar_fabric_check_cap_n;
    --附件资料
    p_fa_rec.certificate_file  := :ar_certificate_file_y;
    p_fa_rec.supplier_gate     := :ar_supplier_gate_n;
    p_fa_rec.supplier_office   := :ar_supplier_office_n;
    p_fa_rec.supplier_site     := :ar_supplier_site_n;
    p_fa_rec.supplier_product  := :ar_supplier_product_n;
    p_fa_rec.ask_files         := :ar_other_information_n;
    --其他
    p_fa_rec.update_id   := :user_id;
    p_fa_rec.update_date := SYSDATE;

    scmdata.pkg_ask_record_mange.p_save_factory_ask(p_fa_rec => p_fa_rec);
  END;]';
  ELSE
    v_sql := NULL;
  END IF;
  ^'|| CHR(64) ||q'^strresult := v_sql;
END;
}^';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_ITEM_LIST WHERE ITEM_ID = ''a_coop_150_3''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_ITEM_LIST SET (AUTO_REFRESH,BACK_GROUND_ID,EDIT_EXPRESS,END_FIELD,EXECUTE_TIME,FOOTER,HEADER,HINT_TYPE,JUMP_EXPRESS,JUMP_FIELD,MAX_ROW_COUNT,MONITOR_ID,MULTI_PAGE_FLAG,NOADD_FIELDS,NOEDIT_FIELDS,NOMODIFY_FIELDS,NOSHOW_APP_FIELDS,NOSHOW_FIELDS,OPEN_MODE,OPERATE_TYPE,OPERATION_TYPE,OUTPUT_PARAMETER,PAGE_SIZES,QUERY_COUNT,QUERY_FIELDS,QUERY_TYPE,RFID_FLAG,SCANNABLE_FIELD,SCANNABLE_LOCATION_LINE,SCANNABLE_TIME,SCANNABLE_TYPE,SUBNOSHOW_FIELDS,SUB_EDIT_STATE,SUB_TABLE_JUDGE_FIELD,UI_TMPL,DELETE_SQL,DETAIL_SQL,INSERT_SQL,LOCK_SQL,NEWID_SQL,OPRETION_HINT,SELECT_SQL,SUBSELECT_SQL,UPDATE_SQL) = (SELECT 4,q''[]'',q''[]'',q''[]'',,q''[]'',q''[]'',,q''[]'',q''[]'',,q''[]'',1,q''[]'',q''[]'',q''[]'',q''[]'',q''[ASK_RECORD_ID,AR_PRODUCT_LINK_N,AR_COMPANY_TYPE_Y,AR_COMPANY_VILL_Y,AR_COOPERATION_TYPE_Y,AR_COOPERATION_MODEL_Y,AR_FACTORY_VILL_Y,AR_PAY_TERM_N,AR_PRODUCT_TYPE_Y,AR_IS_OUR_FACTORY_Y,AR_PRODUCT_LINE_N,AR_QUALITY_STEP_N,AR_PATTERN_CAP_Y,AR_FABRIC_PURCHASE_CAP_Y,AR_FABRIC_CHECK_CAP_N,FA_CHECK_PERSON_Y,FA_CHECK_DEPT_NAME_Y,FA_IS_URGENT_N,AR_RELA_SUPPLIER_ID_N]'',,0,q''[]'',q''[]'',q''[20,30,50,100,200,500]'',,q''[]'',0,,q''[]'',q''[]'',,,q''[]'',,q''[]'',q''[]'',:CV1,:CV2,:CV3,:CV4,:CV5,:CV6,:CV7,:CV8,:CV9 FROM DUAL) WHERE ITEM_ID = ''a_coop_150_3''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3,CV4,CV5,CV6,CV7,CV8,CV9;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_ITEM_LIST (AUTO_REFRESH,BACK_GROUND_ID,EDIT_EXPRESS,END_FIELD,EXECUTE_TIME,FOOTER,HEADER,HINT_TYPE,ITEM_ID,JUMP_EXPRESS,JUMP_FIELD,MAX_ROW_COUNT,MONITOR_ID,MULTI_PAGE_FLAG,NOADD_FIELDS,NOEDIT_FIELDS,NOMODIFY_FIELDS,NOSHOW_APP_FIELDS,NOSHOW_FIELDS,OPEN_MODE,OPERATE_TYPE,OPERATION_TYPE,OUTPUT_PARAMETER,PAGE_SIZES,QUERY_COUNT,QUERY_FIELDS,QUERY_TYPE,RFID_FLAG,SCANNABLE_FIELD,SCANNABLE_LOCATION_LINE,SCANNABLE_TIME,SCANNABLE_TYPE,SUBNOSHOW_FIELDS,SUB_EDIT_STATE,SUB_TABLE_JUDGE_FIELD,UI_TMPL,DELETE_SQL,DETAIL_SQL,INSERT_SQL,LOCK_SQL,NEWID_SQL,OPRETION_HINT,SELECT_SQL,SUBSELECT_SQL,UPDATE_SQL) SELECT 4,q''[]'',q''[]'',q''[]'',,q''[]'',q''[]'',,''a_coop_150_3'',q''[]'',q''[]'',,q''[]'',1,q''[]'',q''[]'',q''[]'',q''[]'',q''[ASK_RECORD_ID,AR_PRODUCT_LINK_N,AR_COMPANY_TYPE_Y,AR_COMPANY_VILL_Y,AR_COOPERATION_TYPE_Y,AR_COOPERATION_MODEL_Y,AR_FACTORY_VILL_Y,AR_PAY_TERM_N,AR_PRODUCT_TYPE_Y,AR_IS_OUR_FACTORY_Y,AR_PRODUCT_LINE_N,AR_QUALITY_STEP_N,AR_PATTERN_CAP_Y,AR_FABRIC_PURCHASE_CAP_Y,AR_FABRIC_CHECK_CAP_N,FA_CHECK_PERSON_Y,FA_CHECK_DEPT_NAME_Y,FA_IS_URGENT_N,AR_RELA_SUPPLIER_ID_N]'',,0,q''[]'',q''[]'',q''[20,30,50,100,200,500]'',,q''[]'',0,,q''[]'',q''[]'',,,q''[]'',,q''[]'',q''[]'',:CV1,:CV2,:CV3,:CV4,:CV5,:CV6,:CV7,:CV8,:CV9 FROM DUAL';
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
  CV1 CLOB:=q'^^';
  CV2 CLOB:=q'^^';
  CV3 CLOB:=q'^^';
  CV4 CLOB:=q'^^';
  CV5 CLOB:=q'^^';
  CV6 CLOB:=q'^^';
  CV7 CLOB:=q'^--czh 20221103 v9.10
{DECLARE
  v_sql         CLOB;
  v_ask_record_id VARCHAR2(32);
  v_rest_method   VARCHAR2(256);
  v_params        VARCHAR2(2000);
BEGIN
  --获取asscoiate请求参数
  pkg_plat_comm.p_get_rest_val_method_params(p_character     => %ass_ask_record_id%,
                                             po_pk_id        => v_ask_record_id,
                                             po_rest_methods => v_rest_method,
                                             po_params       => v_params);
  v_rest_method := nvl(v_rest_method, 'GET');
  IF instr(';' || v_rest_method || ';', ';' || 'GET' || ';') > 0 THEN
    v_sql := pkg_ask_record_mange_a.f_query_t_person_config_fa(p_factory_ask_id => :factory_ask_id);
  ELSE
    v_sql := NULL;
  END IF;
  ^'|| CHR(64) ||q'^strresult := v_sql;
END;}^';
  CV8 CLOB:=q'^^';
  CV9 CLOB:=q'^{
DECLARE
  v_sql           CLOB;
  v_ask_record_id VARCHAR2(32);
  v_rest_method   VARCHAR2(256);
  v_params        VARCHAR2(2000);
BEGIN
  --获取asscoiate请求参数
  pkg_plat_comm.p_get_rest_val_method_params(p_character     => %ass_ask_record_id%,
                                             po_pk_id        => v_ask_record_id,
                                             po_rest_methods => v_rest_method,
                                             po_params       => v_params);
  v_rest_method := nvl(v_rest_method, 'PUT');
  IF :factory_ask_id IS NULL AND instr(';' || v_rest_method || ';', ';' || 'PUT' || ';') > 0 THEN
    v_sql := q'[
    DECLARE
      v_t_per_rec t_person_config_fa%ROWTYPE;
    BEGIN
      v_t_per_rec.person_config_id := :person_config_id;
      v_t_per_rec.person_num       := :ar_person_num_n;
      v_t_per_rec.remarks          := :ar_remarks_n;
      v_t_per_rec.update_id        := :user_id;
      v_t_per_rec.update_time      := SYSDATE;
      --更新人员配置
      scmdata.pkg_ask_record_mange_a.p_update_t_person_config_fa(p_t_per_rec => v_t_per_rec);
      --同步主表生产相关信息
      scmdata.pkg_ask_record_mange_a.p_generate_ask_record_product_info(p_company_id  => %default_company_id%,p_factory_ask_id => :factory_ask_id);
    END;
    ]';
  ELSE
    v_sql := NULL;
  END IF;
  ^'|| CHR(64) ||q'^strresult := v_sql;
END;
}^';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_ITEM_LIST WHERE ITEM_ID = ''a_coop_150_3_1''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_ITEM_LIST SET (AUTO_REFRESH,BACK_GROUND_ID,EDIT_EXPRESS,END_FIELD,EXECUTE_TIME,FOOTER,HEADER,HINT_TYPE,JUMP_EXPRESS,JUMP_FIELD,MAX_ROW_COUNT,MONITOR_ID,MULTI_PAGE_FLAG,NOADD_FIELDS,NOEDIT_FIELDS,NOMODIFY_FIELDS,NOSHOW_APP_FIELDS,NOSHOW_FIELDS,OPEN_MODE,OPERATE_TYPE,OPERATION_TYPE,OUTPUT_PARAMETER,PAGE_SIZES,QUERY_COUNT,QUERY_FIELDS,QUERY_TYPE,RFID_FLAG,SCANNABLE_FIELD,SCANNABLE_LOCATION_LINE,SCANNABLE_TIME,SCANNABLE_TYPE,SUBNOSHOW_FIELDS,SUB_EDIT_STATE,SUB_TABLE_JUDGE_FIELD,UI_TMPL,DELETE_SQL,DETAIL_SQL,INSERT_SQL,LOCK_SQL,NEWID_SQL,OPRETION_HINT,SELECT_SQL,SUBSELECT_SQL,UPDATE_SQL) = (SELECT 4,q''[]'',q''[]'',q''[]'',,q''[]'',q''[]'',,q''[]'',q''[]'',,q''[]'',1,q''[]'',q''[]'',q''[]'',q''[]'',q''[PERSON_CONFIG_ID,COMPANY_ID,AR_PERSON_ROLE_N,AR_DEPARTMENT_N,AR_PERSON_JOB_N,AR_APPLY_CATE_N
]'',,0,q''[]'',q''[]'',q''[20,30,50,100,200,500]'',,q''[]'',0,,q''[]'',q''[]'',,,q''[]'',,q''[]'',q''[]'',:CV1,:CV2,:CV3,:CV4,:CV5,:CV6,:CV7,:CV8,:CV9 FROM DUAL) WHERE ITEM_ID = ''a_coop_150_3_1''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3,CV4,CV5,CV6,CV7,CV8,CV9;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_ITEM_LIST (AUTO_REFRESH,BACK_GROUND_ID,EDIT_EXPRESS,END_FIELD,EXECUTE_TIME,FOOTER,HEADER,HINT_TYPE,ITEM_ID,JUMP_EXPRESS,JUMP_FIELD,MAX_ROW_COUNT,MONITOR_ID,MULTI_PAGE_FLAG,NOADD_FIELDS,NOEDIT_FIELDS,NOMODIFY_FIELDS,NOSHOW_APP_FIELDS,NOSHOW_FIELDS,OPEN_MODE,OPERATE_TYPE,OPERATION_TYPE,OUTPUT_PARAMETER,PAGE_SIZES,QUERY_COUNT,QUERY_FIELDS,QUERY_TYPE,RFID_FLAG,SCANNABLE_FIELD,SCANNABLE_LOCATION_LINE,SCANNABLE_TIME,SCANNABLE_TYPE,SUBNOSHOW_FIELDS,SUB_EDIT_STATE,SUB_TABLE_JUDGE_FIELD,UI_TMPL,DELETE_SQL,DETAIL_SQL,INSERT_SQL,LOCK_SQL,NEWID_SQL,OPRETION_HINT,SELECT_SQL,SUBSELECT_SQL,UPDATE_SQL) SELECT 4,q''[]'',q''[]'',q''[]'',,q''[]'',q''[]'',,''a_coop_150_3_1'',q''[]'',q''[]'',,q''[]'',1,q''[]'',q''[]'',q''[]'',q''[]'',q''[PERSON_CONFIG_ID,COMPANY_ID,AR_PERSON_ROLE_N,AR_DEPARTMENT_N,AR_PERSON_JOB_N,AR_APPLY_CATE_N
]'',,0,q''[]'',q''[]'',q''[20,30,50,100,200,500]'',,q''[]'',0,,q''[]'',q''[]'',,,q''[]'',,q''[]'',q''[]'',:CV1,:CV2,:CV3,:CV4,:CV5,:CV6,:CV7,:CV8,:CV9 FROM DUAL';
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
  CV1 CLOB:=q'^--czh 20221103 v9.10
{
DECLARE
  v_sql         CLOB;
  v_ask_record_id VARCHAR2(32);
  v_rest_method   VARCHAR2(256);
  v_params        VARCHAR2(2000);
BEGIN
  --获取asscoiate请求参数
  pkg_plat_comm.p_get_rest_val_method_params(p_character     => %ass_ask_record_id%,
                                             po_pk_id        => v_ask_record_id,
                                             po_rest_methods => v_rest_method,
                                             po_params       => v_params);
  v_rest_method := nvl(v_rest_method, 'DELETE');
  IF :factory_ask_id IS NULL AND instr(';' || v_rest_method || ';', ';' || 'DELETE' || ';') > 0 THEN
    v_sql := q'[
DECLARE
  v_t_mac_rec t_machine_equipment_fa%ROWTYPE;
  v_seqno     INT;
BEGIN
  v_t_mac_rec.machine_equipment_id  := :machine_equipment_id;
  v_t_mac_rec.orgin                 := :orgin_val;
  pkg_ask_record_mange_a.p_delete_t_machine_equipment_fa(p_t_mac_rec => v_t_mac_rec);
END;
]';
  ELSE
    v_sql := NULL;
  END IF;
  ^'|| CHR(64) ||q'^strresult := v_sql;
END;
}^';
  CV2 CLOB:=q'^^';
  CV3 CLOB:=q'^--czh 20221103 v9.10
{
DECLARE
  v_sql         CLOB;
  v_ask_record_id VARCHAR2(32);
  v_rest_method   VARCHAR2(256);
  v_params        VARCHAR2(2000);
BEGIN
  --获取asscoiate请求参数
  pkg_plat_comm.p_get_rest_val_method_params(p_character     => %ass_ask_record_id%,
                                             po_pk_id        => v_ask_record_id,
                                             po_rest_methods => v_rest_method,
                                             po_params       => v_params);
  v_rest_method := nvl(v_rest_method, 'POST');
  IF :factory_ask_id IS NULL AND instr(';' || v_rest_method || ';', ';' || 'POST' || ';') > 0 THEN
    v_sql := q'[
DECLARE
  v_t_mac_rec t_machine_equipment_fa%ROWTYPE;
  v_seqno     INT;
BEGIN
  v_t_mac_rec.machine_equipment_id  := scmdata.f_get_uuid();
  v_t_mac_rec.company_id            := %default_company_id%;
  v_t_mac_rec.equipment_category_id := :ar_equipment_cate_n;
  v_t_mac_rec.equipment_name        := :ar_equipment_name_y;
  v_t_mac_rec.machine_num           := :ar_machine_num_n;

  SELECT nvl(MAX(t.seqno), 0) + 1
    INTO v_seqno
    FROM scmdata.t_machine_equipment_fa t
   WHERE t.factory_ask_id  = :factory_ask_id
     AND t.company_id = %default_company_id%;

  v_t_mac_rec.seqno         := v_seqno;
  v_t_mac_rec.orgin         := 'MA';
  v_t_mac_rec.pause         := 0;
  v_t_mac_rec.remarks       := :remarks;
  v_t_mac_rec.update_id     := :user_id;
  v_t_mac_rec.update_time   := SYSDATE;
  v_t_mac_rec.create_id     := :user_id;
  v_t_mac_rec.create_time   := SYSDATE;
  v_t_mac_rec.factory_ask_id := :factory_ask_id;

  pkg_ask_record_mange_a.p_insert_t_machine_equipment_fa(p_t_mac_rec => v_t_mac_rec);
END;
]';
  ELSE
    v_sql := NULL;
  END IF;
  ^'|| CHR(64) ||q'^strresult := v_sql;
END;
}^';
  CV4 CLOB:=q'^^';
  CV5 CLOB:=q'^^';
  CV6 CLOB:=q'^^';
  CV7 CLOB:=q'^--czh 20221103 v9.10
{DECLARE
  v_sql         CLOB;
  v_ask_record_id VARCHAR2(32);
  v_rest_method   VARCHAR2(256);
  v_params        VARCHAR2(2000);
BEGIN
  --获取asscoiate请求参数
  pkg_plat_comm.p_get_rest_val_method_params(p_character     => %ass_ask_record_id%,
                                             po_pk_id        => v_ask_record_id,
                                             po_rest_methods => v_rest_method,
                                             po_params       => v_params);
  v_rest_method := nvl(v_rest_method, 'GET');
  IF instr(';' || v_rest_method || ';', ';' || 'GET' || ';') > 0 THEN
    v_sql := pkg_ask_record_mange_a.f_query_t_machine_equipment_fa(p_factory_ask_id => :factory_ask_id);
  ELSE
    v_sql := NULL;
  END IF;
  ^'|| CHR(64) ||q'^strresult := v_sql;
END;}^';
  CV8 CLOB:=q'^^';
  CV9 CLOB:=q'^--czh 20221103 v9.10
{
DECLARE
  v_sql         CLOB;
  v_ask_record_id VARCHAR2(32);
  v_rest_method   VARCHAR2(256);
  v_params        VARCHAR2(2000);
BEGIN
  --获取asscoiate请求参数
  pkg_plat_comm.p_get_rest_val_method_params(p_character     => %ass_ask_record_id%,
                                             po_pk_id        => v_ask_record_id,
                                             po_rest_methods => v_rest_method,
                                             po_params       => v_params);
  v_rest_method := nvl(v_rest_method, 'PUT');
  IF :factory_ask_id IS NULL AND instr(';' || v_rest_method || ';', ';' || 'PUT' || ';') > 0 THEN
    v_sql := q'[
DECLARE
  v_t_mac_rec t_machine_equipment_fa%ROWTYPE;
  v_seqno     INT;
BEGIN
  v_t_mac_rec.machine_equipment_id  := :machine_equipment_id;
  v_t_mac_rec.equipment_category_id := :ar_equipment_cate_n;
  v_t_mac_rec.equipment_name        := :ar_equipment_name_y;
  v_t_mac_rec.machine_num   := :ar_machine_num_n;
  v_t_mac_rec.remarks       := :remarks;
  v_t_mac_rec.update_id     := :user_id;
  v_t_mac_rec.update_time   := SYSDATE;

  pkg_ask_record_mange_a.p_update_t_machine_equipment_fa(p_t_mac_rec => v_t_mac_rec);
END;
]';
  ELSE
    v_sql := NULL;
  END IF;
  ^'|| CHR(64) ||q'^strresult := v_sql;
END;
}^';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_ITEM_LIST WHERE ITEM_ID = ''a_coop_150_3_2''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_ITEM_LIST SET (AUTO_REFRESH,BACK_GROUND_ID,EDIT_EXPRESS,END_FIELD,EXECUTE_TIME,FOOTER,HEADER,HINT_TYPE,JUMP_EXPRESS,JUMP_FIELD,MAX_ROW_COUNT,MONITOR_ID,MULTI_PAGE_FLAG,NOADD_FIELDS,NOEDIT_FIELDS,NOMODIFY_FIELDS,NOSHOW_APP_FIELDS,NOSHOW_FIELDS,OPEN_MODE,OPERATE_TYPE,OPERATION_TYPE,OUTPUT_PARAMETER,PAGE_SIZES,QUERY_COUNT,QUERY_FIELDS,QUERY_TYPE,RFID_FLAG,SCANNABLE_FIELD,SCANNABLE_LOCATION_LINE,SCANNABLE_TIME,SCANNABLE_TYPE,SUBNOSHOW_FIELDS,SUB_EDIT_STATE,SUB_TABLE_JUDGE_FIELD,UI_TMPL,DELETE_SQL,DETAIL_SQL,INSERT_SQL,LOCK_SQL,NEWID_SQL,OPRETION_HINT,SELECT_SQL,SUBSELECT_SQL,UPDATE_SQL) = (SELECT 4,q''[]'',q''[]'',q''[]'',,q''[]'',q''[]'',,q''[]'',q''[]'',,q''[]'',1,q''[]'',q''[]'',q''[]'',q''[]'',q''[MACHINE_EQUIPMENT_ID,COMPANY_ID,AR_EQUIPMENT_CATE_N,ORGIN_VAL]'',,0,q''[]'',q''[]'',q''[20,30,50,100,200,500]'',,q''[]'',0,,q''[]'',q''[]'',,,q''[]'',,q''[]'',q''[]'',:CV1,:CV2,:CV3,:CV4,:CV5,:CV6,:CV7,:CV8,:CV9 FROM DUAL) WHERE ITEM_ID = ''a_coop_150_3_2''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3,CV4,CV5,CV6,CV7,CV8,CV9;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_ITEM_LIST (AUTO_REFRESH,BACK_GROUND_ID,EDIT_EXPRESS,END_FIELD,EXECUTE_TIME,FOOTER,HEADER,HINT_TYPE,ITEM_ID,JUMP_EXPRESS,JUMP_FIELD,MAX_ROW_COUNT,MONITOR_ID,MULTI_PAGE_FLAG,NOADD_FIELDS,NOEDIT_FIELDS,NOMODIFY_FIELDS,NOSHOW_APP_FIELDS,NOSHOW_FIELDS,OPEN_MODE,OPERATE_TYPE,OPERATION_TYPE,OUTPUT_PARAMETER,PAGE_SIZES,QUERY_COUNT,QUERY_FIELDS,QUERY_TYPE,RFID_FLAG,SCANNABLE_FIELD,SCANNABLE_LOCATION_LINE,SCANNABLE_TIME,SCANNABLE_TYPE,SUBNOSHOW_FIELDS,SUB_EDIT_STATE,SUB_TABLE_JUDGE_FIELD,UI_TMPL,DELETE_SQL,DETAIL_SQL,INSERT_SQL,LOCK_SQL,NEWID_SQL,OPRETION_HINT,SELECT_SQL,SUBSELECT_SQL,UPDATE_SQL) SELECT 4,q''[]'',q''[]'',q''[]'',,q''[]'',q''[]'',,''a_coop_150_3_2'',q''[]'',q''[]'',,q''[]'',1,q''[]'',q''[]'',q''[]'',q''[]'',q''[MACHINE_EQUIPMENT_ID,COMPANY_ID,AR_EQUIPMENT_CATE_N,ORGIN_VAL]'',,0,q''[]'',q''[]'',q''[20,30,50,100,200,500]'',,q''[]'',0,,q''[]'',q''[]'',,,q''[]'',,q''[]'',q''[]'',:CV1,:CV2,:CV3,:CV4,:CV5,:CV6,:CV7,:CV8,:CV9 FROM DUAL';
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
  CV1 CLOB:=q'^--czh add
{
DECLARE
  v_sql           CLOB;
  v_ask_record_id VARCHAR2(32);
  v_rest_method   VARCHAR2(256);
  v_params        VARCHAR2(2000);
BEGIN
  --获取asscoiate请求参数
  pkg_plat_comm.p_get_rest_val_method_params(p_character     => %ass_ask_record_id%,
                                             po_pk_id        => v_ask_record_id,
                                             po_rest_methods => v_rest_method,
                                             po_params       => v_params);
  v_rest_method := nvl(v_rest_method, 'DELETE');
  IF instr(';' || v_rest_method || ';', ';' || 'DELETE' || ';') > 0 THEN
    --v_ask_record_id := nvl(v_ask_record_id, :ask_record_id);
    v_sql           := 'CALL scmdata.pkg_ask_record_mange.p_delete_t_ask_record(p_ask_record_id => nvl(''' || v_ask_record_id || ''', :ask_record_id))';
  ELSE
    NULL;
  END IF;
  ^'|| CHR(64) ||q'^strresult := v_sql;
END;
}^';
  CV2 CLOB:=q'^^';
  CV3 CLOB:=q'^--czh 20221103 v9.10
{DECLARE
  v_sql         CLOB;
  v_ask_record_id   VARCHAR2(32);
  v_rest_method     VARCHAR2(256);
  v_params          VARCHAR2(2000);
BEGIN
  --获取asscoiate请求参数
  pkg_plat_comm.p_get_rest_val_method_params(p_character     => %ass_ask_record_id%,
                                             po_pk_id        => v_ask_record_id,
                                             po_rest_methods => v_rest_method,
                                             po_params       => v_params);
  v_rest_method := nvl(v_rest_method, 'POST');
  IF instr(';' || v_rest_method || ';', ';' || 'POST' || ';') > 0 THEN
  --v_ask_record_id := nvl(v_ask_record_id, :ask_record_id);
  v_sql :=  q'[
DECLARE
  v_company_id  VARCHAR2(32);
  p_ar_rec scmdata.t_ask_record%ROWTYPE;
  v_ask_record_id    VARCHAR2(32) := nvl(']' || v_ask_record_id || q'[', :ask_record_id);
BEGIN
    SELECT MAX(company_id)
      INTO v_company_id
      FROM scmdata.sys_company
     WHERE licence_num = :ar_social_credit_code_y;

    p_ar_rec.ask_record_id := v_ask_record_id;
    p_ar_rec.company_id    := nvl(v_company_id, '');
    p_ar_rec.be_company_id := %default_company_id%;
    --基本信息
    p_ar_rec.company_name            := :ar_company_name_y;
    p_ar_rec.company_abbreviation    := :ar_company_abbreviation_y;
    p_ar_rec.social_credit_code      := :ar_social_credit_code_y;
    p_ar_rec.company_province        := :company_province;
    p_ar_rec.company_city            := :company_city;
    p_ar_rec.company_county          := :company_county;
    p_ar_rec.company_vill            := :ar_company_vill_y;
    p_ar_rec.company_address         := :ar_company_address_y;
    p_ar_rec.company_regist_date     := :ar_company_regist_date_y;
    p_ar_rec.pay_term                := :ar_pay_term_n;
    p_ar_rec.legal_representative    := :ar_legal_representative_n;
    p_ar_rec.company_contact_phone   := :ar_company_contact_phone_n;
    p_ar_rec.sapply_user             := :ar_sapply_user_y;
    p_ar_rec.sapply_phone            := :ar_sapply_phone_y;
    p_ar_rec.company_type            := :ar_company_type_y;
    p_ar_rec.brand_type              := :brand_type;
    p_ar_rec.cooperation_brand       := :cooperation_brand;
    p_ar_rec.cooperation_type        := :ar_cooperation_type_y;
    p_ar_rec.cooperation_model       := :ar_cooperation_model_y;
    p_ar_rec.product_type            := :ar_product_type_y;
    p_ar_rec.product_link            := :ar_product_link_n;
    p_ar_rec.rela_supplier_id        := :ar_rela_supplier_id_n;
    p_ar_rec.is_our_factory          := :ar_is_our_factory_y;
    p_ar_rec.factory_name            := :ar_factory_name_y;
    p_ar_rec.factory_province        := :factory_province;
    p_ar_rec.factory_city            := :factory_city;
    p_ar_rec.factory_county          := :factory_county;
    p_ar_rec.factory_vill            := :ar_factory_vill_y;
    p_ar_rec.factroy_details_address := :ar_factroy_details_address_y;
    p_ar_rec.factroy_area            := :ar_factroy_area_y;
    p_ar_rec.ask_say                 := :ar_ask_say_n;
    p_ar_rec.remarks                 := :ar_remarks_n;
    --生产信息
    p_ar_rec.product_line        := :ar_product_line_n;
    p_ar_rec.product_line_num    := :ar_product_line_num_n;
    p_ar_rec.quality_step        := :ar_quality_step_n;
    p_ar_rec.work_hours_day      := :ar_work_hours_day_y;
    p_ar_rec.worker_total_num    := :ar_worker_total_num_y;
    p_ar_rec.worker_num          := :ar_worker_num_y;
    p_ar_rec.machine_num         := :ar_machine_num_y;
    p_ar_rec.form_num            := :ar_form_num_y;
    p_ar_rec.product_efficiency  := :ar_product_efficiency_y;
    p_ar_rec.pattern_cap         := :ar_pattern_cap_y;
    p_ar_rec.fabric_purchase_cap := :ar_fabric_purchase_cap_y;
    p_ar_rec.fabric_check_cap    := :ar_fabric_check_cap_n;
    --附件资料
    p_ar_rec.certificate_file  := :ar_certificate_file_y;
    p_ar_rec.supplier_gate     := :ar_supplier_gate_n;
    p_ar_rec.supplier_office   := :ar_supplier_office_n;
    p_ar_rec.supplier_site     := :ar_supplier_site_n;
    p_ar_rec.supplier_product  := :ar_supplier_product_n;
    p_ar_rec.other_information := :ar_other_information_n;
    --其它
    p_ar_rec.coor_ask_flow_status := 'CA00';
    p_ar_rec.origin               := 'MA';
    p_ar_rec.create_id            := :user_id;
    p_ar_rec.create_date          := SYSDATE;
    p_ar_rec.update_id            := :user_id;
    p_ar_rec.update_date          := SYSDATE;
    --废弃字段
    p_ar_rec.ask_date              := SYSDATE;
    p_ar_rec.ask_user_id           := :user_id;
    p_ar_rec.other_file            := NULL;
    p_ar_rec.cooperation_statement := NULL;
    p_ar_rec.collection            := 0;
    --1.新增校验
    scmdata.pkg_ask_record_mange.p_check_data_by_save(p_ar_rec => p_ar_rec,p_type => 1);
    --2.新增意向供应商
    scmdata.pkg_ask_record_mange.p_insert_t_ask_record(p_ar_rec => p_ar_rec);
    --3.新增意向供应商时，同步生成人员、机器配置
    scmdata.pkg_ask_record_mange.p_generate_person_machine_config(p_company_id    => %default_company_id%,
                                                                  p_user_id       => :user_id,
                                                                  p_ask_record_id => v_ask_record_id);
END;]';
  ELSE
    v_sql := NULL;
  END IF;
  ^'|| CHR(64) ||q'^strresult := v_sql;
END;}^';
  CV4 CLOB:=q'^^';
  CV5 CLOB:=q'^SELECT SCMDATA.F_GETKEYID_PLAT('HZ', 'SEQ_T_ASK_RECORD', 99) ASK_RECORD_ID FROM DUAL^';
  CV6 CLOB:=q'^^';
  CV7 CLOB:=q'^--czh 20221103 v9.10
{
DECLARE
  v_sql           CLOB;
  v_ask_record_id VARCHAR2(32);
  v_rest_method   VARCHAR2(256);
  v_params        VARCHAR2(2000);
  v_item_id       VARCHAR(256);
BEGIN
  --获取asscoiate请求参数
  pkg_plat_comm.p_get_rest_val_method_params(p_character     => %ass_ask_record_id%,
                                             po_pk_id        => v_ask_record_id,
                                             po_rest_methods => v_rest_method,
                                             po_params       => v_params);
  v_rest_method := nvl(v_rest_method, 'GET');
  IF instr(';' || v_rest_method || ';', ';' || 'GET' || ';') > 0 THEN
    v_item_id := plm.pkg_plat_comm.parse_json(p_jsonstr => v_params,
                                              p_key     => 'item_id');
    v_item_id := NVL(v_item_id,'a_coop_151');
    v_sql := pkg_ask_record_mange.f_query_coop_fp_supplier(p_item_id => v_item_id,p_ask_record_id => v_ask_record_id);
  ELSE
    v_sql := NULL;
  END IF;
  ^'|| CHR(64) ||q'^strresult := v_sql;
END;
}

/*{DECLARE
  v_sql         CLOB;
  v_rest_method VARCHAR2(256) := 'GET';
BEGIN
  IF instr(';' || v_rest_method || ';', ';' || 'GET' || ';') > 0 THEN
    v_sql := pkg_ask_record_mange.f_query_coop_fp_supplier(p_type => 2);
  ELSE
    v_sql := NULL;
  END IF;
  ^'|| CHR(64) ||q'^strresult := v_sql;
END;}*/^';
  CV8 CLOB:=q'^^';
  CV9 CLOB:=q'^--czh 20221103 v9.10
{DECLARE
  v_sql         CLOB;
  v_ask_record_id   VARCHAR2(32);
  v_rest_method     VARCHAR2(256);
  v_params          VARCHAR2(2000);
BEGIN
  --获取asscoiate请求参数
  pkg_plat_comm.p_get_rest_val_method_params(p_character     => %ass_ask_record_id%,
                                             po_pk_id        => v_ask_record_id,
                                             po_rest_methods => v_rest_method,
                                             po_params       => v_params);
  v_rest_method := nvl(v_rest_method, 'PUT');
  IF instr(';' || v_rest_method || ';', ';' || 'PUT' || ';') > 0 THEN
  --v_ask_record_id := nvl(v_ask_record_id, :ask_record_id);
  v_sql :=  q'[
DECLARE
  p_ar_rec scmdata.t_ask_record%ROWTYPE;
BEGIN
    p_ar_rec.ask_record_id := nvl(']' || v_ask_record_id || q'[', :ask_record_id);
    p_ar_rec.company_id    := :company_id;
    p_ar_rec.be_company_id := %default_company_id%;
    --基本信息
    p_ar_rec.company_name            := :ar_company_name_y;
    p_ar_rec.company_abbreviation    := :ar_company_abbreviation_y;
    p_ar_rec.social_credit_code      := :ar_social_credit_code_y;
    p_ar_rec.company_province        := :company_province;
    p_ar_rec.company_city            := :company_city;
    p_ar_rec.company_county          := :company_county;
    p_ar_rec.company_vill            := :ar_company_vill_y;
    p_ar_rec.company_address         := :ar_company_address_y;
    p_ar_rec.company_regist_date     := :ar_company_regist_date_y;
    p_ar_rec.pay_term                := :ar_pay_term_n;
    p_ar_rec.legal_representative    := :ar_legal_representative_n;
    p_ar_rec.company_contact_phone   := :ar_company_contact_phone_n;
    p_ar_rec.sapply_user             := :ar_sapply_user_y;
    p_ar_rec.sapply_phone            := :ar_sapply_phone_y;
    p_ar_rec.company_type            := :ar_company_type_y;
    p_ar_rec.brand_type              := :brand_type;
    p_ar_rec.cooperation_brand       := :cooperation_brand;
    p_ar_rec.cooperation_type        := :ar_cooperation_type_y;
    p_ar_rec.cooperation_model       := :ar_cooperation_model_y;
    p_ar_rec.product_type            := :ar_product_type_y;
    p_ar_rec.product_link            := :ar_product_link_n;
    p_ar_rec.rela_supplier_id        := :ar_rela_supplier_id_n;
    p_ar_rec.is_our_factory          := :ar_is_our_factory_y;
    p_ar_rec.factory_name            := :ar_factory_name_y;
    p_ar_rec.factory_province        := :factory_province;
    p_ar_rec.factory_city            := :factory_city;
    p_ar_rec.factory_county          := :factory_county;
    p_ar_rec.factory_vill            := :ar_factory_vill_y;
    p_ar_rec.factroy_details_address := :ar_factroy_details_address_y;
    p_ar_rec.factroy_area            := :ar_factroy_area_y;
    p_ar_rec.ask_say                 := :ar_ask_say_n;
    p_ar_rec.remarks                 := :ar_remarks_n;
    --生产信息
    p_ar_rec.product_line        := :ar_product_line_n;
    p_ar_rec.product_line_num    := :ar_product_line_num_n;
    p_ar_rec.quality_step        := :ar_quality_step_n;
    p_ar_rec.work_hours_day      := :ar_work_hours_day_y;
    p_ar_rec.worker_total_num    := :ar_worker_total_num_y;
    p_ar_rec.worker_num          := :ar_worker_num_y;
    p_ar_rec.machine_num         := :ar_machine_num_y;
    p_ar_rec.form_num            := :ar_form_num_y;
    p_ar_rec.product_efficiency  := :ar_product_efficiency_y;
    p_ar_rec.pattern_cap         := :ar_pattern_cap_y;
    p_ar_rec.fabric_purchase_cap := :ar_fabric_purchase_cap_y;
    p_ar_rec.fabric_check_cap    := :ar_fabric_check_cap_n;
    --附件资料
    p_ar_rec.certificate_file  := :ar_certificate_file_y;
    p_ar_rec.supplier_gate     := :ar_supplier_gate_n;
    p_ar_rec.supplier_office   := :ar_supplier_office_n;
    p_ar_rec.supplier_site     := :ar_supplier_site_n;
    p_ar_rec.supplier_product  := :ar_supplier_product_n;
    p_ar_rec.other_information := :ar_other_information_n;
    --其它
    p_ar_rec.update_id            := :user_id;
    p_ar_rec.update_date          := SYSDATE;

    --1.修改校验
    scmdata.pkg_ask_record_mange.p_check_data_by_save(p_ar_rec => p_ar_rec,p_type => 1);
    --2.修改意向供应商
    scmdata.pkg_ask_record_mange.p_update_t_ask_record(p_ar_rec => p_ar_rec);
END;]';
  ELSE
    v_sql := NULL;
  END IF;
  ^'|| CHR(64) ||q'^strresult := v_sql;
END;}^';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_ITEM_LIST WHERE ITEM_ID = ''a_coop_151''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_ITEM_LIST SET (AUTO_REFRESH,BACK_GROUND_ID,EDIT_EXPRESS,END_FIELD,EXECUTE_TIME,FOOTER,HEADER,HINT_TYPE,JUMP_EXPRESS,JUMP_FIELD,MAX_ROW_COUNT,MONITOR_ID,MULTI_PAGE_FLAG,NOADD_FIELDS,NOEDIT_FIELDS,NOMODIFY_FIELDS,NOSHOW_APP_FIELDS,NOSHOW_FIELDS,OPEN_MODE,OPERATE_TYPE,OPERATION_TYPE,OUTPUT_PARAMETER,PAGE_SIZES,QUERY_COUNT,QUERY_FIELDS,QUERY_TYPE,RFID_FLAG,SCANNABLE_FIELD,SCANNABLE_LOCATION_LINE,SCANNABLE_TIME,SCANNABLE_TYPE,SUBNOSHOW_FIELDS,SUB_EDIT_STATE,SUB_TABLE_JUDGE_FIELD,UI_TMPL,DELETE_SQL,DETAIL_SQL,INSERT_SQL,LOCK_SQL,NEWID_SQL,OPRETION_HINT,SELECT_SQL,SUBSELECT_SQL,UPDATE_SQL) = (SELECT 4,q''[]'',q''[]'',q''[]'',,q''[]'',q''[]'',,q''[]'',q''[]'',,q''[]'',2,q''[]'',q''[AR_WORKER_TOTAL_NUM_Y,AR_WORKER_NUM_Y,AR_FORM_NUM_Y,AR_PATTERN_CAP_DESC_Y,AR_FABRIC_PUR_CAP_DESC_Y,AR_COOPERATION_TYPE_Y]'',q''[]'',q''[]'',q''[ASK_RECORD_ID,AR_PRODUCT_LINK_N,AR_COMPANY_TYPE_Y,AR_COMPANY_VILL_Y,AR_COOPERATION_TYPE_Y,AR_COOPERATION_MODEL_Y,AR_FACTORY_VILL_Y,AR_PAY_TERM_N,AR_PRODUCT_TYPE_Y,AR_IS_OUR_FACTORY_Y,AR_PRODUCT_LINE_N,AR_QUALITY_STEP_N,AR_PATTERN_CAP_Y,AR_FABRIC_PURCHASE_CAP_Y,AR_FABRIC_CHECK_CAP_N]'',,0,q''[]'',q''[]'',q''[]'',,q''[]'',0,,q''[]'',q''[]'',,,q''[]'',,q''[]'',q''[]'',:CV1,:CV2,:CV3,:CV4,:CV5,:CV6,:CV7,:CV8,:CV9 FROM DUAL) WHERE ITEM_ID = ''a_coop_151''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3,CV4,CV5,CV6,CV7,CV8,CV9;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_ITEM_LIST (AUTO_REFRESH,BACK_GROUND_ID,EDIT_EXPRESS,END_FIELD,EXECUTE_TIME,FOOTER,HEADER,HINT_TYPE,ITEM_ID,JUMP_EXPRESS,JUMP_FIELD,MAX_ROW_COUNT,MONITOR_ID,MULTI_PAGE_FLAG,NOADD_FIELDS,NOEDIT_FIELDS,NOMODIFY_FIELDS,NOSHOW_APP_FIELDS,NOSHOW_FIELDS,OPEN_MODE,OPERATE_TYPE,OPERATION_TYPE,OUTPUT_PARAMETER,PAGE_SIZES,QUERY_COUNT,QUERY_FIELDS,QUERY_TYPE,RFID_FLAG,SCANNABLE_FIELD,SCANNABLE_LOCATION_LINE,SCANNABLE_TIME,SCANNABLE_TYPE,SUBNOSHOW_FIELDS,SUB_EDIT_STATE,SUB_TABLE_JUDGE_FIELD,UI_TMPL,DELETE_SQL,DETAIL_SQL,INSERT_SQL,LOCK_SQL,NEWID_SQL,OPRETION_HINT,SELECT_SQL,SUBSELECT_SQL,UPDATE_SQL) SELECT 4,q''[]'',q''[]'',q''[]'',,q''[]'',q''[]'',,''a_coop_151'',q''[]'',q''[]'',,q''[]'',2,q''[]'',q''[AR_WORKER_TOTAL_NUM_Y,AR_WORKER_NUM_Y,AR_FORM_NUM_Y,AR_PATTERN_CAP_DESC_Y,AR_FABRIC_PUR_CAP_DESC_Y,AR_COOPERATION_TYPE_Y]'',q''[]'',q''[]'',q''[ASK_RECORD_ID,AR_PRODUCT_LINK_N,AR_COMPANY_TYPE_Y,AR_COMPANY_VILL_Y,AR_COOPERATION_TYPE_Y,AR_COOPERATION_MODEL_Y,AR_FACTORY_VILL_Y,AR_PAY_TERM_N,AR_PRODUCT_TYPE_Y,AR_IS_OUR_FACTORY_Y,AR_PRODUCT_LINE_N,AR_QUALITY_STEP_N,AR_PATTERN_CAP_Y,AR_FABRIC_PURCHASE_CAP_Y,AR_FABRIC_CHECK_CAP_N]'',,0,q''[]'',q''[]'',q''[]'',,q''[]'',0,,q''[]'',q''[]'',,,q''[]'',,q''[]'',q''[]'',:CV1,:CV2,:CV3,:CV4,:CV5,:CV6,:CV7,:CV8,:CV9 FROM DUAL';
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
  CV1 CLOB:=q'^^';
  CV2 CLOB:=q'^^';
  CV3 CLOB:=q'^^';
  CV4 CLOB:=q'^^';
  CV5 CLOB:=q'^^';
  CV6 CLOB:=q'^^';
  CV7 CLOB:=q'^--czh 20221103 v9.10
{DECLARE
  v_sql         CLOB;
  v_ask_record_id VARCHAR2(32);
  v_rest_method   VARCHAR2(256);
  v_params        VARCHAR2(2000);
BEGIN
  --获取asscoiate请求参数
  pkg_plat_comm.p_get_rest_val_method_params(p_character     => %ass_ask_record_id%,
                                             po_pk_id        => v_ask_record_id,
                                             po_rest_methods => v_rest_method,
                                             po_params       => v_params);
  v_rest_method := nvl(v_rest_method, 'GET');
  IF instr(';' || v_rest_method || ';', ';' || 'GET' || ';') > 0 THEN
    v_ask_record_id := nvl(v_ask_record_id,:ask_record_id);
    v_sql := pkg_ask_record_mange.f_query_t_person_config_hz(p_ask_record_id => v_ask_record_id);
  ELSE
    v_sql := NULL;
  END IF;
  ^'|| CHR(64) ||q'^strresult := v_sql;
END;}^';
  CV8 CLOB:=q'^^';
  CV9 CLOB:=q'^{
DECLARE
  v_sql           CLOB;
  v_ask_record_id VARCHAR2(32);
  v_rest_method   VARCHAR2(256);
  v_params        VARCHAR2(2000);
BEGIN
  --获取asscoiate请求参数
  pkg_plat_comm.p_get_rest_val_method_params(p_character     => %ass_ask_record_id%,
                                             po_pk_id        => v_ask_record_id,
                                             po_rest_methods => v_rest_method,
                                             po_params       => v_params);
  v_rest_method := nvl(v_rest_method, 'PUT');
  IF instr(';' || v_rest_method || ';', ';' || 'PUT' || ';') > 0 THEN
    v_sql := q'[
    DECLARE
      v_t_per_rec t_person_config_hz%ROWTYPE;
      v_ask_record_id VARCHAR2(32) := nvl(']'|| v_ask_record_id || q'[',:ask_record_id);
    BEGIN
      v_t_per_rec.person_config_id := :person_config_id;
      v_t_per_rec.person_num       := :ar_person_num_n;
      v_t_per_rec.remarks          := :ar_remarks_n;
      v_t_per_rec.update_id        := :user_id;
      v_t_per_rec.update_time      := SYSDATE;
      --更新人员配置
      scmdata.pkg_ask_record_mange.p_update_t_person_config_hz(p_t_per_rec => v_t_per_rec);
      --同步主表生产相关信息
      scmdata.pkg_ask_record_mange.p_generate_ask_record_product_info(p_company_id  => %default_company_id%,p_ask_record_id => v_ask_record_id);
    END;
    ]';
  ELSE
    v_sql := NULL;
  END IF;
  ^'|| CHR(64) ||q'^strresult := v_sql;
END;
}^';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_ITEM_LIST WHERE ITEM_ID = ''a_coop_151_1''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_ITEM_LIST SET (AUTO_REFRESH,BACK_GROUND_ID,EDIT_EXPRESS,END_FIELD,EXECUTE_TIME,FOOTER,HEADER,HINT_TYPE,JUMP_EXPRESS,JUMP_FIELD,MAX_ROW_COUNT,MONITOR_ID,MULTI_PAGE_FLAG,NOADD_FIELDS,NOEDIT_FIELDS,NOMODIFY_FIELDS,NOSHOW_APP_FIELDS,NOSHOW_FIELDS,OPEN_MODE,OPERATE_TYPE,OPERATION_TYPE,OUTPUT_PARAMETER,PAGE_SIZES,QUERY_COUNT,QUERY_FIELDS,QUERY_TYPE,RFID_FLAG,SCANNABLE_FIELD,SCANNABLE_LOCATION_LINE,SCANNABLE_TIME,SCANNABLE_TYPE,SUBNOSHOW_FIELDS,SUB_EDIT_STATE,SUB_TABLE_JUDGE_FIELD,UI_TMPL,DELETE_SQL,DETAIL_SQL,INSERT_SQL,LOCK_SQL,NEWID_SQL,OPRETION_HINT,SELECT_SQL,SUBSELECT_SQL,UPDATE_SQL) = (SELECT 4,q''[]'',q''[]'',q''[]'',,q''[]'',q''[]'',,q''[]'',q''[]'',,q''[]'',1,q''[]'',q''[]'',q''[]'',q''[]'',q''[PERSON_CONFIG_ID,COMPANY_ID,AR_PERSON_ROLE_N,AR_DEPARTMENT_N,AR_PERSON_JOB_N,AR_APPLY_CATE_N
]'',,0,q''[]'',q''[]'',q''[20,30,50,100,200,500]'',,q''[]'',0,,q''[]'',q''[]'',,,q''[]'',,q''[]'',q''[]'',:CV1,:CV2,:CV3,:CV4,:CV5,:CV6,:CV7,:CV8,:CV9 FROM DUAL) WHERE ITEM_ID = ''a_coop_151_1''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3,CV4,CV5,CV6,CV7,CV8,CV9;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_ITEM_LIST (AUTO_REFRESH,BACK_GROUND_ID,EDIT_EXPRESS,END_FIELD,EXECUTE_TIME,FOOTER,HEADER,HINT_TYPE,ITEM_ID,JUMP_EXPRESS,JUMP_FIELD,MAX_ROW_COUNT,MONITOR_ID,MULTI_PAGE_FLAG,NOADD_FIELDS,NOEDIT_FIELDS,NOMODIFY_FIELDS,NOSHOW_APP_FIELDS,NOSHOW_FIELDS,OPEN_MODE,OPERATE_TYPE,OPERATION_TYPE,OUTPUT_PARAMETER,PAGE_SIZES,QUERY_COUNT,QUERY_FIELDS,QUERY_TYPE,RFID_FLAG,SCANNABLE_FIELD,SCANNABLE_LOCATION_LINE,SCANNABLE_TIME,SCANNABLE_TYPE,SUBNOSHOW_FIELDS,SUB_EDIT_STATE,SUB_TABLE_JUDGE_FIELD,UI_TMPL,DELETE_SQL,DETAIL_SQL,INSERT_SQL,LOCK_SQL,NEWID_SQL,OPRETION_HINT,SELECT_SQL,SUBSELECT_SQL,UPDATE_SQL) SELECT 4,q''[]'',q''[]'',q''[]'',,q''[]'',q''[]'',,''a_coop_151_1'',q''[]'',q''[]'',,q''[]'',1,q''[]'',q''[]'',q''[]'',q''[]'',q''[PERSON_CONFIG_ID,COMPANY_ID,AR_PERSON_ROLE_N,AR_DEPARTMENT_N,AR_PERSON_JOB_N,AR_APPLY_CATE_N
]'',,0,q''[]'',q''[]'',q''[20,30,50,100,200,500]'',,q''[]'',0,,q''[]'',q''[]'',,,q''[]'',,q''[]'',q''[]'',:CV1,:CV2,:CV3,:CV4,:CV5,:CV6,:CV7,:CV8,:CV9 FROM DUAL';
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
  CV1 CLOB:=q'^--czh 20221103 v9.10
{
DECLARE
  v_sql         CLOB;
  v_ask_record_id VARCHAR2(32);
  v_rest_method   VARCHAR2(256);
  v_params        VARCHAR2(2000);
BEGIN
  --获取asscoiate请求参数
  pkg_plat_comm.p_get_rest_val_method_params(p_character     => %ass_ask_record_id%,
                                             po_pk_id        => v_ask_record_id,
                                             po_rest_methods => v_rest_method,
                                             po_params       => v_params);
  v_rest_method := nvl(v_rest_method, 'DELETE');
  IF instr(';' || v_rest_method || ';', ';' || 'DELETE' || ';') > 0 THEN
    v_sql := q'[
DECLARE
  v_t_mac_rec t_machine_equipment_hz%ROWTYPE;
  v_seqno     INT;
BEGIN
  v_t_mac_rec.machine_equipment_id  := :machine_equipment_id;
  v_t_mac_rec.orgin                 := :orgin_val;
  pkg_ask_record_mange.p_delete_t_machine_equipment_hz(p_t_mac_rec => v_t_mac_rec);
END;
]';
  ELSE
    v_sql := NULL;
  END IF;
  ^'|| CHR(64) ||q'^strresult := v_sql;
END;
}^';
  CV2 CLOB:=q'^^';
  CV3 CLOB:=q'^--czh 20221103 v9.10
{
DECLARE
  v_sql         CLOB;
  v_ask_record_id VARCHAR2(32);
  v_rest_method   VARCHAR2(256);
  v_params        VARCHAR2(2000);
BEGIN
  --获取asscoiate请求参数
  pkg_plat_comm.p_get_rest_val_method_params(p_character     => %ass_ask_record_id%,
                                             po_pk_id        => v_ask_record_id,
                                             po_rest_methods => v_rest_method,
                                             po_params       => v_params);
  v_rest_method := nvl(v_rest_method, 'POST');
  IF instr(';' || v_rest_method || ';', ';' || 'POST' || ';') > 0 THEN
    v_sql := q'[
DECLARE
  v_t_mac_rec t_machine_equipment_hz%ROWTYPE;
  v_ask_record_id VARCHAR2(32) := nvl(']' || v_ask_record_id || q'[',:ask_record_id);
  v_seqno     INT;
BEGIN
  v_t_mac_rec.machine_equipment_id  := scmdata.f_get_uuid();
  v_t_mac_rec.company_id            := %default_company_id%;
  v_t_mac_rec.equipment_category_id := :ar_equipment_cate_n;
  v_t_mac_rec.equipment_name        := :ar_equipment_name_y;
  v_t_mac_rec.machine_num           := :ar_machine_num_n;

  SELECT nvl(MAX(t.seqno), 0) + 1
    INTO v_seqno
    FROM scmdata.t_machine_equipment_hz t
   WHERE t.ask_record_id = v_ask_record_id
     AND t.company_id = %default_company_id%;

  v_t_mac_rec.seqno         := v_seqno;
  v_t_mac_rec.orgin         := 'MA';
  v_t_mac_rec.pause         := 0;
  v_t_mac_rec.remarks       := :remarks;
  v_t_mac_rec.update_id     := :user_id;
  v_t_mac_rec.update_time   := SYSDATE;
  v_t_mac_rec.create_id     := :user_id;
  v_t_mac_rec.create_time   := SYSDATE;
  v_t_mac_rec.ask_record_id := v_ask_record_id;

  pkg_ask_record_mange.p_insert_t_machine_equipment_hz(p_t_mac_rec => v_t_mac_rec);
END;
]';
  ELSE
    v_sql := NULL;
  END IF;
  ^'|| CHR(64) ||q'^strresult := v_sql;
END;
}^';
  CV4 CLOB:=q'^^';
  CV5 CLOB:=q'^^';
  CV6 CLOB:=q'^^';
  CV7 CLOB:=q'^--czh 20221103 v9.10
{DECLARE
  v_sql         CLOB;
  v_ask_record_id VARCHAR2(32);
  v_rest_method   VARCHAR2(256);
  v_params        VARCHAR2(2000);
BEGIN
  --获取asscoiate请求参数
  pkg_plat_comm.p_get_rest_val_method_params(p_character     => %ass_ask_record_id%,
                                             po_pk_id        => v_ask_record_id,
                                             po_rest_methods => v_rest_method,
                                             po_params       => v_params);
  v_rest_method := nvl(v_rest_method, 'GET');
  IF instr(';' || v_rest_method || ';', ';' || 'GET' || ';') > 0 THEN
    v_ask_record_id := nvl(v_ask_record_id,:ask_record_id);
    v_sql := pkg_ask_record_mange.f_query_t_machine_equipment_hz(p_ask_record_id => v_ask_record_id);
  ELSE
    v_sql := NULL;
  END IF;
  ^'|| CHR(64) ||q'^strresult := v_sql;
END;}^';
  CV8 CLOB:=q'^^';
  CV9 CLOB:=q'^--czh 20221103 v9.10
{
DECLARE
  v_sql         CLOB;
  v_ask_record_id VARCHAR2(32);
  v_rest_method   VARCHAR2(256);
  v_params        VARCHAR2(2000);
BEGIN
  --获取asscoiate请求参数
  pkg_plat_comm.p_get_rest_val_method_params(p_character     => %ass_ask_record_id%,
                                             po_pk_id        => v_ask_record_id,
                                             po_rest_methods => v_rest_method,
                                             po_params       => v_params);
  v_rest_method := nvl(v_rest_method, 'PUT');
  IF instr(';' || v_rest_method || ';', ';' || 'PUT' || ';') > 0 THEN
    v_sql := q'[
DECLARE
  v_t_mac_rec t_machine_equipment_hz%ROWTYPE;
  v_seqno     INT;
BEGIN
  v_t_mac_rec.machine_equipment_id  := :machine_equipment_id;
  v_t_mac_rec.equipment_category_id := :ar_equipment_cate_n;
  v_t_mac_rec.equipment_name        := :ar_equipment_name_y;
  v_t_mac_rec.machine_num   := :ar_machine_num_n;
  v_t_mac_rec.remarks       := :remarks;
  v_t_mac_rec.update_id     := :user_id;
  v_t_mac_rec.update_time   := SYSDATE;

  pkg_ask_record_mange.p_update_t_machine_equipment_hz(p_t_mac_rec => v_t_mac_rec);
END;
]';
  ELSE
    v_sql := NULL;
  END IF;
  ^'|| CHR(64) ||q'^strresult := v_sql;
END;
}^';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_ITEM_LIST WHERE ITEM_ID = ''a_coop_151_2''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_ITEM_LIST SET (AUTO_REFRESH,BACK_GROUND_ID,EDIT_EXPRESS,END_FIELD,EXECUTE_TIME,FOOTER,HEADER,HINT_TYPE,JUMP_EXPRESS,JUMP_FIELD,MAX_ROW_COUNT,MONITOR_ID,MULTI_PAGE_FLAG,NOADD_FIELDS,NOEDIT_FIELDS,NOMODIFY_FIELDS,NOSHOW_APP_FIELDS,NOSHOW_FIELDS,OPEN_MODE,OPERATE_TYPE,OPERATION_TYPE,OUTPUT_PARAMETER,PAGE_SIZES,QUERY_COUNT,QUERY_FIELDS,QUERY_TYPE,RFID_FLAG,SCANNABLE_FIELD,SCANNABLE_LOCATION_LINE,SCANNABLE_TIME,SCANNABLE_TYPE,SUBNOSHOW_FIELDS,SUB_EDIT_STATE,SUB_TABLE_JUDGE_FIELD,UI_TMPL,DELETE_SQL,DETAIL_SQL,INSERT_SQL,LOCK_SQL,NEWID_SQL,OPRETION_HINT,SELECT_SQL,SUBSELECT_SQL,UPDATE_SQL) = (SELECT 4,q''[]'',q''[]'',q''[]'',,q''[]'',q''[]'',,q''[]'',q''[]'',,q''[]'',1,q''[]'',q''[]'',q''[]'',q''[]'',q''[MACHINE_EQUIPMENT_ID,COMPANY_ID,AR_EQUIPMENT_CATE_N,ORGIN_VAL]'',,0,q''[]'',q''[]'',q''[20,30,50,100,200,500]'',,q''[]'',0,,q''[]'',q''[]'',,,q''[]'',,q''[]'',q''[]'',:CV1,:CV2,:CV3,:CV4,:CV5,:CV6,:CV7,:CV8,:CV9 FROM DUAL) WHERE ITEM_ID = ''a_coop_151_2''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3,CV4,CV5,CV6,CV7,CV8,CV9;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_ITEM_LIST (AUTO_REFRESH,BACK_GROUND_ID,EDIT_EXPRESS,END_FIELD,EXECUTE_TIME,FOOTER,HEADER,HINT_TYPE,ITEM_ID,JUMP_EXPRESS,JUMP_FIELD,MAX_ROW_COUNT,MONITOR_ID,MULTI_PAGE_FLAG,NOADD_FIELDS,NOEDIT_FIELDS,NOMODIFY_FIELDS,NOSHOW_APP_FIELDS,NOSHOW_FIELDS,OPEN_MODE,OPERATE_TYPE,OPERATION_TYPE,OUTPUT_PARAMETER,PAGE_SIZES,QUERY_COUNT,QUERY_FIELDS,QUERY_TYPE,RFID_FLAG,SCANNABLE_FIELD,SCANNABLE_LOCATION_LINE,SCANNABLE_TIME,SCANNABLE_TYPE,SUBNOSHOW_FIELDS,SUB_EDIT_STATE,SUB_TABLE_JUDGE_FIELD,UI_TMPL,DELETE_SQL,DETAIL_SQL,INSERT_SQL,LOCK_SQL,NEWID_SQL,OPRETION_HINT,SELECT_SQL,SUBSELECT_SQL,UPDATE_SQL) SELECT 4,q''[]'',q''[]'',q''[]'',,q''[]'',q''[]'',,''a_coop_151_2'',q''[]'',q''[]'',,q''[]'',1,q''[]'',q''[]'',q''[]'',q''[]'',q''[MACHINE_EQUIPMENT_ID,COMPANY_ID,AR_EQUIPMENT_CATE_N,ORGIN_VAL]'',,0,q''[]'',q''[]'',q''[20,30,50,100,200,500]'',,q''[]'',0,,q''[]'',q''[]'',,,q''[]'',,q''[]'',q''[]'',:CV1,:CV2,:CV3,:CV4,:CV5,:CV6,:CV7,:CV8,:CV9 FROM DUAL';
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
  CV1 CLOB:=q'^--czh 20221103 v9.10
{DECLARE
  v_sql         CLOB;
  v_ask_record_id VARCHAR2(32);
  v_rest_method   VARCHAR2(256);
  v_params        VARCHAR2(2000);
BEGIN
  --获取asscoiate请求参数
  pkg_plat_comm.p_get_rest_val_method_params(p_character     => %ass_ask_record_id%,
                                             po_pk_id        => v_ask_record_id,
                                             po_rest_methods => v_rest_method,
                                             po_params       => v_params);
  v_rest_method := nvl(v_rest_method, 'DELETE');
  IF instr(';' || v_rest_method || ';', ';' || 'DELETE' || ';') > 0 THEN
    v_sql := q'[DECLARE
  v_t_ask_rec scmdata.t_ask_scope%ROWTYPE;
BEGIN
  v_t_ask_rec.ask_scope_id := :ask_scope_id;
  scmdata.pkg_ask_record_mange.p_delete_t_ask_scope(p_t_ask_rec => v_t_ask_rec);
END;]';
  ELSE
    v_sql := NULL;
  END IF;
  ^'|| CHR(64) ||q'^strresult := v_sql;
END;}
^';
  CV2 CLOB:=q'^^';
  CV3 CLOB:=q'^--czh 20221103 v9.10
{DECLARE
  v_sql         CLOB;
  v_ask_record_id VARCHAR2(32);
  v_rest_method   VARCHAR2(256);
  v_params        VARCHAR2(2000);
BEGIN
  --获取asscoiate请求参数
  pkg_plat_comm.p_get_rest_val_method_params(p_character     => %ass_ask_record_id%,
                                             po_pk_id        => v_ask_record_id,
                                             po_rest_methods => v_rest_method,
                                             po_params       => v_params);
  v_rest_method := nvl(v_rest_method, 'POST');
  IF instr(';' || v_rest_method || ';', ';' || 'POST' || ';') > 0 THEN
    --v_ask_record_id := nvl(v_ask_record_id,:ask_record_id);
    v_sql := q'[DECLARE
  v_t_ask_rec scmdata.t_ask_scope%ROWTYPE;
  v_ask_record_id VARCHAR2(32) := nvl(']'|| v_ask_record_id || q'[',:ask_record_id);
BEGIN
  scmdata.pkg_ask_record_mange.check_repeat_scope(pi_ask_scope_id               => ' ',
                                                  pi_object_id                  => v_ask_record_id,
                                                  pi_object_type                => 'HZ',
                                                  pi_cooperation_classification => :cooperation_classification,
                                                  pi_cooperation_product_cate   => :cooperation_product_cate,
                                                  pi_cooperation_type           => :cooperation_type);

  v_t_ask_rec.ask_scope_id               := scmdata.f_get_uuid();
  v_t_ask_rec.company_id                 := %default_company_id%;
  v_t_ask_rec.object_id                  := v_ask_record_id;
  v_t_ask_rec.object_type                := 'HZ';
  v_t_ask_rec.cooperation_type           := :cooperation_type;
  v_t_ask_rec.cooperation_classification := :cooperation_classification;
  v_t_ask_rec.cooperation_product_cate   := :cooperation_product_cate;
  v_t_ask_rec.cooperation_subcategory    := :cooperation_subcategory;
  v_t_ask_rec.be_company_id              := %default_company_id%;
  v_t_ask_rec.update_time                := SYSDATE;
  v_t_ask_rec.update_id                  := :user_id;
  v_t_ask_rec.create_id                  := :user_id;
  v_t_ask_rec.create_time                := SYSDATE;
  v_t_ask_rec.remarks                    := NULL;
  v_t_ask_rec.pause                      := 0;

  scmdata.pkg_ask_record_mange.p_insert_t_ask_scope(p_t_ask_rec => v_t_ask_rec);
END;]';
  ELSE
    v_sql := NULL;
  END IF;
  ^'|| CHR(64) ||q'^strresult := v_sql;
END;}^';
  CV4 CLOB:=q'^^';
  CV5 CLOB:=q'^^';
  CV6 CLOB:=q'^^';
  CV7 CLOB:=q'^--czh 20221103 v9.10
{DECLARE
  v_sql         CLOB;
  v_ask_record_id VARCHAR2(32);
  v_rest_method   VARCHAR2(256);
  v_params        VARCHAR2(2000);
BEGIN
  --获取asscoiate请求参数
  pkg_plat_comm.p_get_rest_val_method_params(p_character     => %ass_ask_record_id%,
                                             po_pk_id        => v_ask_record_id,
                                             po_rest_methods => v_rest_method,
                                             po_params       => v_params);
  v_rest_method := nvl(v_rest_method, 'GET');
  IF instr(';' || v_rest_method || ';', ';' || 'GET' || ';') > 0 THEN
    v_ask_record_id := nvl(v_ask_record_id,:ask_record_id);
    v_sql := pkg_ask_record_mange.f_query_t_ask_scope(p_object_id => v_ask_record_id);
  ELSE
    v_sql := NULL;
  END IF;
  ^'|| CHR(64) ||q'^strresult := v_sql;
END;}^';
  CV8 CLOB:=q'^^';
  CV9 CLOB:=q'^--czh 20221103 v9.10
{DECLARE
  v_sql         CLOB;
  v_ask_record_id VARCHAR2(32);
  v_rest_method   VARCHAR2(256);
  v_params        VARCHAR2(2000);
BEGIN
  --获取asscoiate请求参数
  pkg_plat_comm.p_get_rest_val_method_params(p_character     => %ass_ask_record_id%,
                                             po_pk_id        => v_ask_record_id,
                                             po_rest_methods => v_rest_method,
                                             po_params       => v_params);
  v_rest_method := nvl(v_rest_method, 'PUT');
  IF instr(';' || v_rest_method || ';', ';' || 'PUT' || ';') > 0 THEN
    --v_ask_record_id := nvl(v_ask_record_id,:ask_record_id);
    v_sql := q'[DECLARE
  v_t_ask_rec     scmdata.t_ask_scope%ROWTYPE;
  v_ask_record_id VARCHAR2(32) := nvl(']'|| v_ask_record_id || q'[',:ask_record_id);
BEGIN
  scmdata.pkg_ask_record_mange.check_repeat_scope(pi_ask_scope_id               => :ask_scope_id,
                                                  pi_object_id                  => v_ask_record_id,
                                                  pi_object_type                => 'HZ',
                                                  pi_cooperation_classification => :cooperation_classification,
                                                  pi_cooperation_product_cate   => :cooperation_product_cate,
                                                  pi_cooperation_type           => :cooperation_type);

  v_t_ask_rec.ask_scope_id               := :ask_scope_id;
  v_t_ask_rec.cooperation_classification := :cooperation_classification;
  v_t_ask_rec.cooperation_product_cate   := :cooperation_product_cate;
  v_t_ask_rec.cooperation_subcategory    := :cooperation_subcategory;
  v_t_ask_rec.update_time                := SYSDATE;
  v_t_ask_rec.update_id                  := :user_id;

  scmdata.pkg_ask_record_mange.p_update_t_ask_scope(p_t_ask_rec => v_t_ask_rec);
END;]';
  ELSE
    v_sql := NULL;
  END IF;
  ^'|| CHR(64) ||q'^strresult := v_sql;
END;}^';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_ITEM_LIST WHERE ITEM_ID = ''a_coop_159''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_ITEM_LIST SET (AUTO_REFRESH,BACK_GROUND_ID,EDIT_EXPRESS,END_FIELD,EXECUTE_TIME,FOOTER,HEADER,HINT_TYPE,JUMP_EXPRESS,JUMP_FIELD,MAX_ROW_COUNT,MONITOR_ID,MULTI_PAGE_FLAG,NOADD_FIELDS,NOEDIT_FIELDS,NOMODIFY_FIELDS,NOSHOW_APP_FIELDS,NOSHOW_FIELDS,OPEN_MODE,OPERATE_TYPE,OPERATION_TYPE,OUTPUT_PARAMETER,PAGE_SIZES,QUERY_COUNT,QUERY_FIELDS,QUERY_TYPE,RFID_FLAG,SCANNABLE_FIELD,SCANNABLE_LOCATION_LINE,SCANNABLE_TIME,SCANNABLE_TYPE,SUBNOSHOW_FIELDS,SUB_EDIT_STATE,SUB_TABLE_JUDGE_FIELD,UI_TMPL,DELETE_SQL,DETAIL_SQL,INSERT_SQL,LOCK_SQL,NEWID_SQL,OPRETION_HINT,SELECT_SQL,SUBSELECT_SQL,UPDATE_SQL) = (SELECT 1,q''[]'',q''[]'',q''[]'',,q''[]'',q''[]'',,q''[]'',q''[]'',,q''[]'',2,q''[]'',q''[]'',q''[]'',q''[]'',q''[ASK_SCOPE_ID,COOPERATION_CLASSIFICATION,COOPERATION_PRODUCT_CATE,COOPERATION_SUBCATEGORY,OBJECT_ID,OBJECT_TYPE,COMPANY_ID,COOPERATION_TYPE]'',,0,q''[]'',q''[]'',q''[]'',,q''[]'',0,,q''[]'',q''[]'',,,q''[]'',,q''[]'',q''[]'',:CV1,:CV2,:CV3,:CV4,:CV5,:CV6,:CV7,:CV8,:CV9 FROM DUAL) WHERE ITEM_ID = ''a_coop_159''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3,CV4,CV5,CV6,CV7,CV8,CV9;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_ITEM_LIST (AUTO_REFRESH,BACK_GROUND_ID,EDIT_EXPRESS,END_FIELD,EXECUTE_TIME,FOOTER,HEADER,HINT_TYPE,ITEM_ID,JUMP_EXPRESS,JUMP_FIELD,MAX_ROW_COUNT,MONITOR_ID,MULTI_PAGE_FLAG,NOADD_FIELDS,NOEDIT_FIELDS,NOMODIFY_FIELDS,NOSHOW_APP_FIELDS,NOSHOW_FIELDS,OPEN_MODE,OPERATE_TYPE,OPERATION_TYPE,OUTPUT_PARAMETER,PAGE_SIZES,QUERY_COUNT,QUERY_FIELDS,QUERY_TYPE,RFID_FLAG,SCANNABLE_FIELD,SCANNABLE_LOCATION_LINE,SCANNABLE_TIME,SCANNABLE_TYPE,SUBNOSHOW_FIELDS,SUB_EDIT_STATE,SUB_TABLE_JUDGE_FIELD,UI_TMPL,DELETE_SQL,DETAIL_SQL,INSERT_SQL,LOCK_SQL,NEWID_SQL,OPRETION_HINT,SELECT_SQL,SUBSELECT_SQL,UPDATE_SQL) SELECT 1,q''[]'',q''[]'',q''[]'',,q''[]'',q''[]'',,''a_coop_159'',q''[]'',q''[]'',,q''[]'',2,q''[]'',q''[]'',q''[]'',q''[]'',q''[ASK_SCOPE_ID,COOPERATION_CLASSIFICATION,COOPERATION_PRODUCT_CATE,COOPERATION_SUBCATEGORY,OBJECT_ID,OBJECT_TYPE,COMPANY_ID,COOPERATION_TYPE]'',,0,q''[]'',q''[]'',q''[]'',,q''[]'',0,,q''[]'',q''[]'',,,q''[]'',,q''[]'',q''[]'',:CV1,:CV2,:CV3,:CV4,:CV5,:CV6,:CV7,:CV8,:CV9 FROM DUAL';
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
  CV1 CLOB:=q'^--czh 20221103 v9.10
{DECLARE
  v_sql         CLOB;
  v_ask_record_id VARCHAR2(32);
  v_rest_method   VARCHAR2(256);
  v_params        VARCHAR2(2000);
BEGIN
  --获取asscoiate请求参数
  pkg_plat_comm.p_get_rest_val_method_params(p_character     => %ass_ask_record_id%,
                                             po_pk_id        => v_ask_record_id,
                                             po_rest_methods => v_rest_method,
                                             po_params       => v_params);
  v_rest_method := nvl(v_rest_method, 'DELETE');
  IF :factory_ask_id IS NULL AND instr(';' || v_rest_method || ';', ';' || 'DELETE' || ';') > 0 THEN
    v_sql := q'[DECLARE
  v_t_ask_rec scmdata.t_ask_scope%ROWTYPE;
BEGIN
  v_t_ask_rec.ask_scope_id := :ask_scope_id;
  scmdata.pkg_ask_record_mange.p_delete_t_ask_scope(p_t_ask_rec => v_t_ask_rec);
END;]';
  ELSE
    v_sql := NULL;
  END IF;
  ^'|| CHR(64) ||q'^strresult := v_sql;
END;}^';
  CV2 CLOB:=q'^^';
  CV3 CLOB:=q'^--czh 20221103 v9.10
{DECLARE
  v_sql         CLOB;
  v_ask_record_id VARCHAR2(32);
  v_rest_method   VARCHAR2(256);
  v_params        VARCHAR2(2000);
BEGIN
  --获取asscoiate请求参数
  pkg_plat_comm.p_get_rest_val_method_params(p_character     => %ass_ask_record_id%,
                                             po_pk_id        => v_ask_record_id,
                                             po_rest_methods => v_rest_method,
                                             po_params       => v_params);
  v_rest_method := nvl(v_rest_method, 'POST');
  IF :factory_ask_id IS NULL AND instr(';' || v_rest_method || ';', ';' || 'POST' || ';') > 0 THEN
    --v_ask_record_id := nvl(v_ask_record_id,:ask_record_id);
    v_sql := q'[DECLARE
  v_t_ask_rec scmdata.t_ask_scope%ROWTYPE;
  v_ask_record_id VARCHAR2(32) := nvl(']'|| v_ask_record_id || q'[',:ask_record_id);
BEGIN
  scmdata.pkg_ask_record_mange.check_repeat_scope(pi_ask_scope_id               => ' ',
                                                  pi_object_id                  => v_ask_record_id,
                                                  pi_object_type                => 'CA',
                                                  pi_cooperation_classification => :cooperation_classification,
                                                  pi_cooperation_product_cate   => :cooperation_product_cate,
                                                  pi_cooperation_type           => :cooperation_type);

  v_t_ask_rec.ask_scope_id               := scmdata.f_get_uuid();
  v_t_ask_rec.company_id                 := %default_company_id%;
  v_t_ask_rec.object_id                  := v_ask_record_id;
  v_t_ask_rec.object_type                := 'CA';
  v_t_ask_rec.cooperation_type           := :cooperation_type;
  v_t_ask_rec.cooperation_classification := :cooperation_classification;
  v_t_ask_rec.cooperation_product_cate   := :cooperation_product_cate;
  v_t_ask_rec.cooperation_subcategory    := :cooperation_subcategory;
  v_t_ask_rec.be_company_id              := %default_company_id%;
  v_t_ask_rec.update_time                := SYSDATE;
  v_t_ask_rec.update_id                  := :user_id;
  v_t_ask_rec.create_id                  := :user_id;
  v_t_ask_rec.create_time                := SYSDATE;
  v_t_ask_rec.remarks                    := NULL;
  v_t_ask_rec.pause                      := 0;

  scmdata.pkg_ask_record_mange.p_insert_t_ask_scope(p_t_ask_rec => v_t_ask_rec);
END;]';
  ELSE
    v_sql := NULL;
  END IF;
  ^'|| CHR(64) ||q'^strresult := v_sql;
END;}^';
  CV4 CLOB:=q'^^';
  CV5 CLOB:=q'^^';
  CV6 CLOB:=q'^^';
  CV7 CLOB:=q'^--czh 20221103 v9.10
{DECLARE
  v_sql         CLOB;
  v_object_id VARCHAR2(32);
  v_rest_method   VARCHAR2(256);
  v_params        VARCHAR2(2000);
BEGIN
  --获取asscoiate请求参数
  pkg_plat_comm.p_get_rest_val_method_params(p_character     => %ass_ask_record_id%,
                                             po_pk_id        => v_object_id,
                                             po_rest_methods => v_rest_method,
                                             po_params       => v_params);
  v_rest_method := nvl(v_rest_method, 'GET');
  IF instr(';' || v_rest_method || ';', ';' || 'GET' || ';') > 0 THEN
    v_sql := pkg_ask_record_mange.f_query_t_ask_scope(p_object_id => :factory_ask_id);
  ELSE
    v_sql := NULL;
  END IF;
  ^'|| CHR(64) ||q'^strresult := v_sql;
END;}^';
  CV8 CLOB:=q'^^';
  CV9 CLOB:=q'^--czh 20221103 v9.10
{DECLARE
  v_sql         CLOB;
  v_ask_record_id VARCHAR2(32);
  v_rest_method   VARCHAR2(256);
  v_params        VARCHAR2(2000);
BEGIN
  --获取asscoiate请求参数
  pkg_plat_comm.p_get_rest_val_method_params(p_character     => %ass_ask_record_id%,
                                             po_pk_id        => v_ask_record_id,
                                             po_rest_methods => v_rest_method,
                                             po_params       => v_params);
  v_rest_method := nvl(v_rest_method, 'PUT');
  IF :factory_ask_id IS NULL AND instr(';' || v_rest_method || ';', ';' || 'PUT' || ';') > 0 THEN
    --v_ask_record_id := nvl(v_ask_record_id,:ask_record_id);
    v_sql := q'[DECLARE
  v_t_ask_rec     scmdata.t_ask_scope%ROWTYPE;
  v_ask_record_id VARCHAR2(32) := nvl(']'|| v_ask_record_id || q'[',:ask_record_id);
BEGIN
  scmdata.pkg_ask_record_mange.check_repeat_scope(pi_ask_scope_id               => :ask_scope_id,
                                                  pi_object_id                  => v_ask_record_id,
                                                  pi_object_type                => 'CA',
                                                  pi_cooperation_classification => :cooperation_classification,
                                                  pi_cooperation_product_cate   => :cooperation_product_cate,
                                                  pi_cooperation_type           => :cooperation_type);

  v_t_ask_rec.ask_scope_id               := :ask_scope_id;
  v_t_ask_rec.cooperation_classification := :cooperation_classification;
  v_t_ask_rec.cooperation_product_cate   := :cooperation_product_cate;
  v_t_ask_rec.cooperation_subcategory    := :cooperation_subcategory;
  v_t_ask_rec.update_time                := SYSDATE;
  v_t_ask_rec.update_id                  := :user_id;

  scmdata.pkg_ask_record_mange.p_update_t_ask_scope(p_t_ask_rec => v_t_ask_rec);
END;]';
  ELSE
    v_sql := NULL;
  END IF;
  ^'|| CHR(64) ||q'^strresult := v_sql;
END;}^';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_ITEM_LIST WHERE ITEM_ID = ''a_coop_159_1''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_ITEM_LIST SET (AUTO_REFRESH,BACK_GROUND_ID,EDIT_EXPRESS,END_FIELD,EXECUTE_TIME,FOOTER,HEADER,HINT_TYPE,JUMP_EXPRESS,JUMP_FIELD,MAX_ROW_COUNT,MONITOR_ID,MULTI_PAGE_FLAG,NOADD_FIELDS,NOEDIT_FIELDS,NOMODIFY_FIELDS,NOSHOW_APP_FIELDS,NOSHOW_FIELDS,OPEN_MODE,OPERATE_TYPE,OPERATION_TYPE,OUTPUT_PARAMETER,PAGE_SIZES,QUERY_COUNT,QUERY_FIELDS,QUERY_TYPE,RFID_FLAG,SCANNABLE_FIELD,SCANNABLE_LOCATION_LINE,SCANNABLE_TIME,SCANNABLE_TYPE,SUBNOSHOW_FIELDS,SUB_EDIT_STATE,SUB_TABLE_JUDGE_FIELD,UI_TMPL,DELETE_SQL,DETAIL_SQL,INSERT_SQL,LOCK_SQL,NEWID_SQL,OPRETION_HINT,SELECT_SQL,SUBSELECT_SQL,UPDATE_SQL) = (SELECT 1,q''[]'',q''[]'',q''[]'',,q''[]'',q''[]'',,q''[]'',q''[]'',,q''[]'',0,q''[]'',q''[]'',q''[]'',q''[]'',q''[ASK_SCOPE_ID,COOPERATION_CLASSIFICATION,COOPERATION_PRODUCT_CATE,COOPERATION_SUBCATEGORY,OBJECT_ID,OBJECT_TYPE,COMPANY_ID,COOPERATION_TYPE]'',,0,q''[]'',q''[]'',q''[]'',,q''[]'',0,,q''[]'',q''[]'',,,q''[]'',,q''[]'',q''[]'',:CV1,:CV2,:CV3,:CV4,:CV5,:CV6,:CV7,:CV8,:CV9 FROM DUAL) WHERE ITEM_ID = ''a_coop_159_1''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3,CV4,CV5,CV6,CV7,CV8,CV9;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_ITEM_LIST (AUTO_REFRESH,BACK_GROUND_ID,EDIT_EXPRESS,END_FIELD,EXECUTE_TIME,FOOTER,HEADER,HINT_TYPE,ITEM_ID,JUMP_EXPRESS,JUMP_FIELD,MAX_ROW_COUNT,MONITOR_ID,MULTI_PAGE_FLAG,NOADD_FIELDS,NOEDIT_FIELDS,NOMODIFY_FIELDS,NOSHOW_APP_FIELDS,NOSHOW_FIELDS,OPEN_MODE,OPERATE_TYPE,OPERATION_TYPE,OUTPUT_PARAMETER,PAGE_SIZES,QUERY_COUNT,QUERY_FIELDS,QUERY_TYPE,RFID_FLAG,SCANNABLE_FIELD,SCANNABLE_LOCATION_LINE,SCANNABLE_TIME,SCANNABLE_TYPE,SUBNOSHOW_FIELDS,SUB_EDIT_STATE,SUB_TABLE_JUDGE_FIELD,UI_TMPL,DELETE_SQL,DETAIL_SQL,INSERT_SQL,LOCK_SQL,NEWID_SQL,OPRETION_HINT,SELECT_SQL,SUBSELECT_SQL,UPDATE_SQL) SELECT 1,q''[]'',q''[]'',q''[]'',,q''[]'',q''[]'',,''a_coop_159_1'',q''[]'',q''[]'',,q''[]'',0,q''[]'',q''[]'',q''[]'',q''[]'',q''[ASK_SCOPE_ID,COOPERATION_CLASSIFICATION,COOPERATION_PRODUCT_CATE,COOPERATION_SUBCATEGORY,OBJECT_ID,OBJECT_TYPE,COMPANY_ID,COOPERATION_TYPE]'',,0,q''[]'',q''[]'',q''[]'',,q''[]'',0,,q''[]'',q''[]'',,,q''[]'',,q''[]'',q''[]'',:CV1,:CV2,:CV3,:CV4,:CV5,:CV6,:CV7,:CV8,:CV9 FROM DUAL';
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
  CV1 CLOB:=q'^^';
  CV2 CLOB:=q'^^';
  CV3 CLOB:=q'^^';
  CV4 CLOB:=q'^^';
  CV5 CLOB:=q'^^';
  CV6 CLOB:=q'^^';
  CV7 CLOB:=q'^--czh 重构代码
{DECLARE
  v_sql CLOB;
BEGIN
  v_sql      := pkg_ask_record_mange.f_query_my_ask_rec();
  ^'|| CHR(64) ||q'^strresult := v_sql;
END;}
--原逻辑
/*
WITH DIC AS
 (SELECT GROUP_DICT_VALUE, GROUP_DICT_NAME, GROUP_DICT_TYPE
    FROM SCMDATA.SYS_GROUP_DICT)
SELECT TFA.FACTORY_ASK_ID,
       TFA.FACTRORY_ASK_FLOW_STATUS,
       SUBSTR(STATUS, 1, INSTR(STATUS, '+')-1) FLOW_NODE_NAME,
       SUBSTR(STATUS, INSTR(STATUS, '+') + 1, LENGTH(STATUS)) FLOW_NODE_STATUS_DESC,
       TFA.COMPANY_NAME ASK_COMPANY_NAME,
       (SELECT LISTAGG(B.GROUP_DICT_NAME, ';')
          FROM (SELECT DISTINCT COOPERATION_CLASSIFICATION TMP
                  FROM SCMDATA.T_ASK_SCOPE
                 WHERE OBJECT_ID = TFA.FACTORY_ASK_ID) A
         INNER JOIN DIC B
            ON A.TMP = B.GROUP_DICT_VALUE
           AND B.GROUP_DICT_TYPE = 'PRODUCT_TYPE') COOPERATION_CLASSIFICATION_DESC,
       TFA.COOPERATION_MODEL,
       (SELECT GROUP_DICT_NAME
          FROM DIC
         WHERE GROUP_DICT_VALUE = TFA.COOPERATION_MODEL
           AND GROUP_DICT_TYPE = 'SUPPLY_TYPE') COOPERATION_MODEL_DESC,
       TFA.FACTORY_NAME,
       TFA.ASK_ADDRESS,
       (SELECT DEPT_NAME
          FROM SCMDATA.SYS_COMPANY_DEPT
         WHERE COMPANY_DEPT_ID =
           (SELECT COMPANY_DEPT_ID FROM SCMDATA.SYS_COMPANY_USER_DEPT
             WHERE USER_ID = %CURRENT_USERID%
               AND COMPANY_ID = %DEFAULT_COMPANY_ID%)) CHECK_DEPT_NAME,
       (SELECT COMPANY_USER_NAME
          FROM SCMDATA.SYS_COMPANY_USER
         WHERE COMPANY_ID=TFA.COMPANY_ID
           AND USER_ID= TFA.ASK_USER_ID) CHECK_APPLY_USERNAME,
       TFA.ASK_DATE FACTORY_ASK_DATE,
       (SELECT GROUP_DICT_NAME
          FROM DIC
         WHERE GROUP_DICT_VALUE = TFA.COOPERATION_TYPE
           AND GROUP_DICT_TYPE = 'COOPERATION_TYPE') COOPERATION_TYPE_DESC,
       TFA.FACTORY_ASK_TYPE CHECK_METHOD,
       CASE
         WHEN FACTORY_ASK_TYPE = 0 THEN
          '不验厂'
         WHEN FACTORY_ASK_TYPE = 1 THEN
          '内部验厂'
         WHEN FACTORY_ASK_TYPE = 2 THEN
          '第三方验厂'
       END CHECK_METHOD_SP,
       (SELECT LOGN_NAME
          FROM SCMDATA.SYS_COMPANY
         WHERE COMPANY_ID = TFA.ASK_COMPANY_ID) CHECK_COMPANY_NAME
  FROM (SELECT FACTORY_ASK_ID,FACTRORY_ASK_FLOW_STATUS,ASK_DATE,FACTORY_ASK_TYPE,
               COOPERATION_COMPANY_ID,ASK_COMPANY_ID,ASK_USER_ID,ASK_ADDRESS,
               COOPERATION_TYPE,COOPERATION_MODEL,COMPANY_NAME,COMPANY_ADDRESS,
               COMPANY_ID,FACTORY_NAME,CREATE_DATE,
               (SELECT GROUP_DICT_NAME
                  FROM DIC
                 WHERE GROUP_DICT_VALUE = FACTRORY_ASK_FLOW_STATUS
                   AND GROUP_DICT_TYPE = 'FACTORY_ASK_FLOW') STATUS
          FROM SCMDATA.T_FACTORY_ASK
         WHERE COMPANY_ID = %DEFAULT_COMPANY_ID%
           AND ASK_USER_ID = %CURRENT_USERID%
           AND FACTRORY_ASK_FLOW_STATUS <> 'CA01'
         ORDER BY CREATE_DATE DESC) TFA
  LEFT JOIN SCMDATA.SYS_USER SU
    ON TFA.ASK_USER_ID = SU.USER_ID*/^';
  CV8 CLOB:=q'^^';
  CV9 CLOB:=q'^^';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_ITEM_LIST WHERE ITEM_ID = ''a_coop_210''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_ITEM_LIST SET (AUTO_REFRESH,BACK_GROUND_ID,EDIT_EXPRESS,END_FIELD,EXECUTE_TIME,FOOTER,HEADER,HINT_TYPE,JUMP_EXPRESS,JUMP_FIELD,MAX_ROW_COUNT,MONITOR_ID,MULTI_PAGE_FLAG,NOADD_FIELDS,NOEDIT_FIELDS,NOMODIFY_FIELDS,NOSHOW_APP_FIELDS,NOSHOW_FIELDS,OPEN_MODE,OPERATE_TYPE,OPERATION_TYPE,OUTPUT_PARAMETER,PAGE_SIZES,QUERY_COUNT,QUERY_FIELDS,QUERY_TYPE,RFID_FLAG,SCANNABLE_FIELD,SCANNABLE_LOCATION_LINE,SCANNABLE_TIME,SCANNABLE_TYPE,SUBNOSHOW_FIELDS,SUB_EDIT_STATE,SUB_TABLE_JUDGE_FIELD,UI_TMPL,DELETE_SQL,DETAIL_SQL,INSERT_SQL,LOCK_SQL,NEWID_SQL,OPRETION_HINT,SELECT_SQL,SUBSELECT_SQL,UPDATE_SQL) = (SELECT ,q''[]'',q''[]'',q''[]'',,q''[]'',q''[]'',,q''[]'',q''[]'',,q''[]'',1,q''[]'',q''[]'',q''[]'',q''[]'',q''[ASK_RECORD_ID,FACTORY_ASK_ID,FACTRORY_ASK_FLOW_STATUS,COOPERATION_CLASSIFICATION,COOPERATION_SUBCATEGORY,COOPERATION_METHOD,COOPERATION_MODEL,ASK_COMPANY_ID,COMPANY_ID,ASK_USER_ID,FACTORY_ASK_TYPE,CHECK_METHOD,COOPERATION_TYPE]'',,0,q''[]'',q''[]'',q''[20,30,50,100,200,500]'',,q''[AR_COMPANY_NAME_N,AR_COMPANY_ABBREVIATION_N]'',,,q''[]'',q''[]'',,,q''[]'',,q''[]'',q''[]'',:CV1,:CV2,:CV3,:CV4,:CV5,:CV6,:CV7,:CV8,:CV9 FROM DUAL) WHERE ITEM_ID = ''a_coop_210''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3,CV4,CV5,CV6,CV7,CV8,CV9;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_ITEM_LIST (AUTO_REFRESH,BACK_GROUND_ID,EDIT_EXPRESS,END_FIELD,EXECUTE_TIME,FOOTER,HEADER,HINT_TYPE,ITEM_ID,JUMP_EXPRESS,JUMP_FIELD,MAX_ROW_COUNT,MONITOR_ID,MULTI_PAGE_FLAG,NOADD_FIELDS,NOEDIT_FIELDS,NOMODIFY_FIELDS,NOSHOW_APP_FIELDS,NOSHOW_FIELDS,OPEN_MODE,OPERATE_TYPE,OPERATION_TYPE,OUTPUT_PARAMETER,PAGE_SIZES,QUERY_COUNT,QUERY_FIELDS,QUERY_TYPE,RFID_FLAG,SCANNABLE_FIELD,SCANNABLE_LOCATION_LINE,SCANNABLE_TIME,SCANNABLE_TYPE,SUBNOSHOW_FIELDS,SUB_EDIT_STATE,SUB_TABLE_JUDGE_FIELD,UI_TMPL,DELETE_SQL,DETAIL_SQL,INSERT_SQL,LOCK_SQL,NEWID_SQL,OPRETION_HINT,SELECT_SQL,SUBSELECT_SQL,UPDATE_SQL) SELECT ,q''[]'',q''[]'',q''[]'',,q''[]'',q''[]'',,''a_coop_210'',q''[]'',q''[]'',,q''[]'',1,q''[]'',q''[]'',q''[]'',q''[]'',q''[ASK_RECORD_ID,FACTORY_ASK_ID,FACTRORY_ASK_FLOW_STATUS,COOPERATION_CLASSIFICATION,COOPERATION_SUBCATEGORY,COOPERATION_METHOD,COOPERATION_MODEL,ASK_COMPANY_ID,COMPANY_ID,ASK_USER_ID,FACTORY_ASK_TYPE,CHECK_METHOD,COOPERATION_TYPE]'',,0,q''[]'',q''[]'',q''[20,30,50,100,200,500]'',,q''[AR_COMPANY_NAME_N,AR_COMPANY_ABBREVIATION_N]'',,,q''[]'',q''[]'',,,q''[]'',,q''[]'',q''[]'',:CV1,:CV2,:CV3,:CV4,:CV5,:CV6,:CV7,:CV8,:CV9 FROM DUAL';
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
  CV1 CLOB:=q'^^';
  CV2 CLOB:=q'^^';
  CV3 CLOB:=q'^^';
  CV4 CLOB:=q'^^';
  CV5 CLOB:=q'^^';
  CV6 CLOB:=q'^^';
  CV7 CLOB:=q'^--czh 重构代码
{DECLARE
  v_sql CLOB;
BEGIN
  v_sql      := pkg_ask_record_mange.f_query_uncheck_ask_rec();
  ^'|| CHR(64) ||q'^strresult := v_sql;
END;}^';
  CV8 CLOB:=q'^^';
  CV9 CLOB:=q'^^';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_ITEM_LIST WHERE ITEM_ID = ''a_coop_220''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_ITEM_LIST SET (AUTO_REFRESH,BACK_GROUND_ID,EDIT_EXPRESS,END_FIELD,EXECUTE_TIME,FOOTER,HEADER,HINT_TYPE,JUMP_EXPRESS,JUMP_FIELD,MAX_ROW_COUNT,MONITOR_ID,MULTI_PAGE_FLAG,NOADD_FIELDS,NOEDIT_FIELDS,NOMODIFY_FIELDS,NOSHOW_APP_FIELDS,NOSHOW_FIELDS,OPEN_MODE,OPERATE_TYPE,OPERATION_TYPE,OUTPUT_PARAMETER,PAGE_SIZES,QUERY_COUNT,QUERY_FIELDS,QUERY_TYPE,RFID_FLAG,SCANNABLE_FIELD,SCANNABLE_LOCATION_LINE,SCANNABLE_TIME,SCANNABLE_TYPE,SUBNOSHOW_FIELDS,SUB_EDIT_STATE,SUB_TABLE_JUDGE_FIELD,UI_TMPL,DELETE_SQL,DETAIL_SQL,INSERT_SQL,LOCK_SQL,NEWID_SQL,OPRETION_HINT,SELECT_SQL,SUBSELECT_SQL,UPDATE_SQL) = (SELECT ,q''[]'',q''[]'',q''[]'',,q''[]'',q''[]'',,q''[]'',q''[]'',,q''[]'',1,q''[]'',q''[]'',q''[]'',q''[]'',q''[company_id,factory_ask_id,cooperation_model,production_mode,factrory_ask_flow_status,factory_ask_type]'',,0,q''[]'',q''[]'',q''[20,30,50,100,200,500]'',,q''[AR_COMPANY_NAME_N,AR_COMPANY_ABBREVIATION_N]'',12,,q''[]'',q''[]'',,,q''[]'',,q''[]'',q''[]'',:CV1,:CV2,:CV3,:CV4,:CV5,:CV6,:CV7,:CV8,:CV9 FROM DUAL) WHERE ITEM_ID = ''a_coop_220''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3,CV4,CV5,CV6,CV7,CV8,CV9;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_ITEM_LIST (AUTO_REFRESH,BACK_GROUND_ID,EDIT_EXPRESS,END_FIELD,EXECUTE_TIME,FOOTER,HEADER,HINT_TYPE,ITEM_ID,JUMP_EXPRESS,JUMP_FIELD,MAX_ROW_COUNT,MONITOR_ID,MULTI_PAGE_FLAG,NOADD_FIELDS,NOEDIT_FIELDS,NOMODIFY_FIELDS,NOSHOW_APP_FIELDS,NOSHOW_FIELDS,OPEN_MODE,OPERATE_TYPE,OPERATION_TYPE,OUTPUT_PARAMETER,PAGE_SIZES,QUERY_COUNT,QUERY_FIELDS,QUERY_TYPE,RFID_FLAG,SCANNABLE_FIELD,SCANNABLE_LOCATION_LINE,SCANNABLE_TIME,SCANNABLE_TYPE,SUBNOSHOW_FIELDS,SUB_EDIT_STATE,SUB_TABLE_JUDGE_FIELD,UI_TMPL,DELETE_SQL,DETAIL_SQL,INSERT_SQL,LOCK_SQL,NEWID_SQL,OPRETION_HINT,SELECT_SQL,SUBSELECT_SQL,UPDATE_SQL) SELECT ,q''[]'',q''[]'',q''[]'',,q''[]'',q''[]'',,''a_coop_220'',q''[]'',q''[]'',,q''[]'',1,q''[]'',q''[]'',q''[]'',q''[]'',q''[company_id,factory_ask_id,cooperation_model,production_mode,factrory_ask_flow_status,factory_ask_type]'',,0,q''[]'',q''[]'',q''[20,30,50,100,200,500]'',,q''[AR_COMPANY_NAME_N,AR_COMPANY_ABBREVIATION_N]'',12,,q''[]'',q''[]'',,,q''[]'',,q''[]'',q''[]'',:CV1,:CV2,:CV3,:CV4,:CV5,:CV6,:CV7,:CV8,:CV9 FROM DUAL';
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
  CV1 CLOB:=q'^^';
  CV2 CLOB:=q'^^';
  CV3 CLOB:=q'^^';
  CV4 CLOB:=q'^^';
  CV5 CLOB:=q'^^';
  CV6 CLOB:=q'^^';
  CV7 CLOB:=q'^--czh 重构代码
{DECLARE
  v_sql CLOB;
BEGIN
  v_sql      := pkg_ask_record_mange.f_query_checked_ask_rec();
  ^'|| CHR(64) ||q'^strresult := v_sql;
END;}^';
  CV8 CLOB:=q'^^';
  CV9 CLOB:=q'^^';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_ITEM_LIST WHERE ITEM_ID = ''a_coop_230''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_ITEM_LIST SET (AUTO_REFRESH,BACK_GROUND_ID,EDIT_EXPRESS,END_FIELD,EXECUTE_TIME,FOOTER,HEADER,HINT_TYPE,JUMP_EXPRESS,JUMP_FIELD,MAX_ROW_COUNT,MONITOR_ID,MULTI_PAGE_FLAG,NOADD_FIELDS,NOEDIT_FIELDS,NOMODIFY_FIELDS,NOSHOW_APP_FIELDS,NOSHOW_FIELDS,OPEN_MODE,OPERATE_TYPE,OPERATION_TYPE,OUTPUT_PARAMETER,PAGE_SIZES,QUERY_COUNT,QUERY_FIELDS,QUERY_TYPE,RFID_FLAG,SCANNABLE_FIELD,SCANNABLE_LOCATION_LINE,SCANNABLE_TIME,SCANNABLE_TYPE,SUBNOSHOW_FIELDS,SUB_EDIT_STATE,SUB_TABLE_JUDGE_FIELD,UI_TMPL,DELETE_SQL,DETAIL_SQL,INSERT_SQL,LOCK_SQL,NEWID_SQL,OPRETION_HINT,SELECT_SQL,SUBSELECT_SQL,UPDATE_SQL) = (SELECT ,q''[]'',q''[]'',q''[]'',,q''[]'',q''[]'',,q''[]'',q''[]'',,q''[]'',1,q''[]'',q''[]'',q''[]'',q''[]'',q''[company_id,factory_ask_id,cooperation_model,production_mode,factrory_ask_flow_status,factory_ask_type]'',,0,q''[]'',q''[]'',q''[20,30,50,100,200,500]'',,q''[AR_COMPANY_NAME_N,AR_COMPANY_ABBREVIATION_N]'',12,,q''[]'',q''[]'',,,q''[]'',,q''[]'',q''[]'',:CV1,:CV2,:CV3,:CV4,:CV5,:CV6,:CV7,:CV8,:CV9 FROM DUAL) WHERE ITEM_ID = ''a_coop_230''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3,CV4,CV5,CV6,CV7,CV8,CV9;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_ITEM_LIST (AUTO_REFRESH,BACK_GROUND_ID,EDIT_EXPRESS,END_FIELD,EXECUTE_TIME,FOOTER,HEADER,HINT_TYPE,ITEM_ID,JUMP_EXPRESS,JUMP_FIELD,MAX_ROW_COUNT,MONITOR_ID,MULTI_PAGE_FLAG,NOADD_FIELDS,NOEDIT_FIELDS,NOMODIFY_FIELDS,NOSHOW_APP_FIELDS,NOSHOW_FIELDS,OPEN_MODE,OPERATE_TYPE,OPERATION_TYPE,OUTPUT_PARAMETER,PAGE_SIZES,QUERY_COUNT,QUERY_FIELDS,QUERY_TYPE,RFID_FLAG,SCANNABLE_FIELD,SCANNABLE_LOCATION_LINE,SCANNABLE_TIME,SCANNABLE_TYPE,SUBNOSHOW_FIELDS,SUB_EDIT_STATE,SUB_TABLE_JUDGE_FIELD,UI_TMPL,DELETE_SQL,DETAIL_SQL,INSERT_SQL,LOCK_SQL,NEWID_SQL,OPRETION_HINT,SELECT_SQL,SUBSELECT_SQL,UPDATE_SQL) SELECT ,q''[]'',q''[]'',q''[]'',,q''[]'',q''[]'',,''a_coop_230'',q''[]'',q''[]'',,q''[]'',1,q''[]'',q''[]'',q''[]'',q''[]'',q''[company_id,factory_ask_id,cooperation_model,production_mode,factrory_ask_flow_status,factory_ask_type]'',,0,q''[]'',q''[]'',q''[20,30,50,100,200,500]'',,q''[AR_COMPANY_NAME_N,AR_COMPANY_ABBREVIATION_N]'',12,,q''[]'',q''[]'',,,q''[]'',,q''[]'',q''[]'',:CV1,:CV2,:CV3,:CV4,:CV5,:CV6,:CV7,:CV8,:CV9 FROM DUAL';
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
  CV1 CLOB:=q'^^';
  CV2 CLOB:=q'^^';
  CV3 CLOB:=q'^^';
  CV4 CLOB:=q'^^';
  CV5 CLOB:=q'^^';
  CV6 CLOB:=q'^^';
  CV7 CLOB:=q'^--基本信息
SELECT sp.supplier_info_id,
       sp.company_id,
       sp.supplier_info_origin_id,
       sp.supplier_code,
       sp.inside_supplier_code,
       sp.supplier_company_name,
       sp.supplier_company_abbreviation,
       sp.legal_representative,
       sp.company_create_date,
       sp.regist_address,
       sp.certificate_validity_start,
       sp.certificate_validity_end,
       sp.regist_price,
       sp.social_credit_code,
       sp.company_type,
       sp.company_person,
       sp.company_contact_person,
       sp.company_contact_phone,
       nvl(sp.company_address,
           (SELECT fc.address
              FROM scmdata.sys_company fc
             WHERE fc.company_id = sp.supplier_company_id)) company_address,
       sp.taxpayer,
       sp.company_say,
       sp.certificate_file up_certificate_file,
       sp.organization_file,
       sp.sharing_type sharing_type,
       --财务信息
       sp.public_accounts,
       sp.public_payment,
       sp.public_bank,
       sp.public_id,
       sp.public_phone,
       sp.personal_account,
       sp.personal_payment,
       sp.personal_bank,
       sp.personal_idcard,
       sp.personal_phone,
       sp.pay_type,
       sp.settlement_type,
       sp.reconciliation_user,
       sp.reconciliation_phone,
       --合同管理
       sp.contract_start_date,
       sp.contract_stop_date,
       sp.contract_file,
       --能力评估
       sp.cooperation_method,
       sp.cooperation_model,
       sp.cooperation_type,
       sp.production_mode /*,
       sp.cooperation_classification cooperation_classification_sp,
       sp.cooperation_subcategory cooperation_subcategory_sp */
  FROM scmdata.t_supplier_info sp
 WHERE sp.supplier_info_id = %ass_supplier_info_id%
   AND sp.company_id = %default_company_id%^';
  CV8 CLOB:=q'^^';
  CV9 CLOB:=q'^DECLARE
  p_sp_data            scmdata.t_supplier_info%ROWTYPE;
  p_default_company_id VARCHAR2(1000) := %default_company_id%;
  p_status             VARCHAR2(20) := 'OLD';
BEGIN

SELECT :supplier_info_id,
       :supplier_company_name,
       :supplier_company_abbreviation,
       :social_credit_code,
       :company_contact_person,
       :company_contact_phone,
       :up_certificate_file,
       :contract_start_date,
       :contract_stop_date,
       :contract_file,
       :cooperation_type,
       :cooperation_model,
       :regist_price,
       :public_id,
       :personal_idcard,
       :public_phone,
       :personal_phone,
       :cooperation_type,
       :cooperation_model,
       :reconciliation_phone,
       :sharing_type
  INTO p_sp_data.supplier_info_id,
       p_sp_data.supplier_company_name,
       p_sp_data.supplier_company_abbreviation,
       p_sp_data.social_credit_code,
       p_sp_data.company_contact_person,
       p_sp_data.company_contact_phone,
       p_sp_data.certificate_file,
       p_sp_data.contract_start_date,
       p_sp_data.contract_stop_date,
       p_sp_data.contract_file,
       p_sp_data.cooperation_type,
       p_sp_data.cooperation_model,
       p_sp_data.regist_price,
       p_sp_data.public_id,
       p_sp_data.personal_idcard,
       p_sp_data.public_phone,
       p_sp_data.personal_phone,
       p_sp_data.cooperation_type,
       p_sp_data.cooperation_model,
       p_sp_data.reconciliation_phone,
       p_sp_data.sharing_type
  FROM dual;

  --更新=》保存，校验数据
  scmdata.sf_supplier_info_pkg.check_save_t_supplier_info(p_sp_data            => p_sp_data,
                                                          p_default_company_id => p_default_company_id,
                                                          p_status             => p_status);

  --2.修改数据
  UPDATE scmdata.t_supplier_info sp
     SET sp.inside_supplier_code = :inside_supplier_code,
         -- sp.supplier_company_name         = :supplier_company_name,
         -- sp.supplier_company_abbreviation = :supplier_company_abbreviation,
         sp.legal_representative       = :legal_representative,
         sp.company_create_date        = :company_create_date,
         sp.regist_address             = :regist_address,
         sp.company_address            = :company_address,
         sp.certificate_validity_start = :certificate_validity_start,
         sp.certificate_validity_end   = :certificate_validity_end,
         sp.regist_price               = :regist_price,
         sp.social_credit_code         = :social_credit_code,
         sp.company_type               = :company_type,
         sp.company_person             = :company_person,
         sp.company_contact_person     = :company_contact_person,
         sp.company_contact_phone      = :company_contact_phone,
         sp.taxpayer                   = :taxpayer,
         sp.company_say                = :company_say,
         sp.certificate_file           = :up_certificate_file,
         sp.organization_file          = :organization_file,
         sp.sharing_type               = :sharing_type,
         --财务信息
         sp.public_accounts      = :public_accounts,
         sp.public_payment       = :public_payment,
         sp.public_bank          = :public_bank,
         sp.public_id            = :public_id,
         sp.public_phone         = :public_phone,
         sp.personal_account     = :personal_account,
         sp.personal_payment     = :personal_payment,
         sp.personal_bank        = :personal_bank,
         sp.personal_idcard      = :personal_idcard,
         sp.personal_phone       = :personal_phone,
         sp.pay_type             = :pay_type,
         sp.settlement_type      = :settlement_type,
         sp.reconciliation_user  = :reconciliation_user,
         sp.reconciliation_phone = :reconciliation_phone,
         --合同管理
         sp.contract_start_date = :contract_start_date,
         sp.contract_stop_date  = :contract_stop_date,
         sp.contract_file       = :contract_file,
         --能力评估
         sp.cooperation_method = :cooperation_method,
         sp.cooperation_model  = :cooperation_model,
         sp.cooperation_type   = :cooperation_type,
         sp.production_mode    = :production_mode
   WHERE sp.supplier_info_id = :supplier_info_id;

END;^';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_ITEM_LIST WHERE ITEM_ID = ''a_supp_111''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_ITEM_LIST SET (AUTO_REFRESH,BACK_GROUND_ID,EDIT_EXPRESS,END_FIELD,EXECUTE_TIME,FOOTER,HEADER,HINT_TYPE,JUMP_EXPRESS,JUMP_FIELD,MAX_ROW_COUNT,MONITOR_ID,MULTI_PAGE_FLAG,NOADD_FIELDS,NOEDIT_FIELDS,NOMODIFY_FIELDS,NOSHOW_APP_FIELDS,NOSHOW_FIELDS,OPEN_MODE,OPERATE_TYPE,OPERATION_TYPE,OUTPUT_PARAMETER,PAGE_SIZES,QUERY_COUNT,QUERY_FIELDS,QUERY_TYPE,RFID_FLAG,SCANNABLE_FIELD,SCANNABLE_LOCATION_LINE,SCANNABLE_TIME,SCANNABLE_TYPE,SUBNOSHOW_FIELDS,SUB_EDIT_STATE,SUB_TABLE_JUDGE_FIELD,UI_TMPL,DELETE_SQL,DETAIL_SQL,INSERT_SQL,LOCK_SQL,NEWID_SQL,OPRETION_HINT,SELECT_SQL,SUBSELECT_SQL,UPDATE_SQL) = (SELECT 1,q''[]'',q''[]'',q''[]'',,q''[]'',q''[]'',,q''[]'',q''[]'',,q''[]'',1,q''[]'',q''[]'',q''[]'',q''[]'',q''[supplier_info_id,company_id,supplier_info_origin_id,company_type,taxpayer,cooperation_classification,cooperation_subcategory,cooperation_method,cooperation_model,cooperation_type,production_mode,cooperation_method_sp,production_mode_sp,pay_type,settlement_type,sharing_type]'',,0,q''[]'',q''[]'',q''[20,30,50,100,200,500]'',,q''[]'',0,,q''[]'',q''[]'',,,q''[]'',,q''[]'',q''[00]'',:CV1,:CV2,:CV3,:CV4,:CV5,:CV6,:CV7,:CV8,:CV9 FROM DUAL) WHERE ITEM_ID = ''a_supp_111''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3,CV4,CV5,CV6,CV7,CV8,CV9;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_ITEM_LIST (AUTO_REFRESH,BACK_GROUND_ID,EDIT_EXPRESS,END_FIELD,EXECUTE_TIME,FOOTER,HEADER,HINT_TYPE,ITEM_ID,JUMP_EXPRESS,JUMP_FIELD,MAX_ROW_COUNT,MONITOR_ID,MULTI_PAGE_FLAG,NOADD_FIELDS,NOEDIT_FIELDS,NOMODIFY_FIELDS,NOSHOW_APP_FIELDS,NOSHOW_FIELDS,OPEN_MODE,OPERATE_TYPE,OPERATION_TYPE,OUTPUT_PARAMETER,PAGE_SIZES,QUERY_COUNT,QUERY_FIELDS,QUERY_TYPE,RFID_FLAG,SCANNABLE_FIELD,SCANNABLE_LOCATION_LINE,SCANNABLE_TIME,SCANNABLE_TYPE,SUBNOSHOW_FIELDS,SUB_EDIT_STATE,SUB_TABLE_JUDGE_FIELD,UI_TMPL,DELETE_SQL,DETAIL_SQL,INSERT_SQL,LOCK_SQL,NEWID_SQL,OPRETION_HINT,SELECT_SQL,SUBSELECT_SQL,UPDATE_SQL) SELECT 1,q''[]'',q''[]'',q''[]'',,q''[]'',q''[]'',,''a_supp_111'',q''[]'',q''[]'',,q''[]'',1,q''[]'',q''[]'',q''[]'',q''[]'',q''[supplier_info_id,company_id,supplier_info_origin_id,company_type,taxpayer,cooperation_classification,cooperation_subcategory,cooperation_method,cooperation_model,cooperation_type,production_mode,cooperation_method_sp,production_mode_sp,pay_type,settlement_type,sharing_type]'',,0,q''[]'',q''[]'',q''[20,30,50,100,200,500]'',,q''[]'',0,,q''[]'',q''[]'',,,q''[]'',,q''[]'',q''[00]'',:CV1,:CV2,:CV3,:CV4,:CV5,:CV6,:CV7,:CV8,:CV9 FROM DUAL';
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
  CV1 CLOB:=q'^^';
  CV2 CLOB:=q'^^';
  CV3 CLOB:=q'^^';
  CV4 CLOB:=q'^^';
  CV5 CLOB:=q'^^';
  CV6 CLOB:=q'^^';
  CV7 CLOB:=q'^SELECT a.company_id,
       a.logo,
       a.company_name,
       a.logn_name,
       a.tips,
       --a.is_open,
       a.attributor_id,
       nvl(c.company_user_name, b.username) attributor,
       --a.create_time,
       dp.province || dci.city || dc.county area,
       a.address,
       a.product,
       a.rival,
       a.licence_type,
       a.licence_num
  FROM scmdata.t_supplier_info sp
 INNER JOIN scmdata.sys_company a
    ON sp.supplier_company_id = a.company_id
  LEFT JOIN sys_user b
    ON a.attributor_id = b.user_id
  LEFT JOIN sys_company_user c
    ON b.user_id = c.user_id
   AND a.company_id = c.company_id
    left join scmdata.dic_province dp
    on dp.provinceid = a.company_province
  left join scmdata.dic_county dc
    on a.company_county = dc.countyid
  left join scmdata.dic_city dci
    on dci.cityno = a.company_city
 WHERE sp.supplier_info_id = %ass_supplier_info_id%^';
  CV8 CLOB:=q'^^';
  CV9 CLOB:=q'^^';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_ITEM_LIST WHERE ITEM_ID = ''a_supp_111_5''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_ITEM_LIST SET (AUTO_REFRESH,BACK_GROUND_ID,EDIT_EXPRESS,END_FIELD,EXECUTE_TIME,FOOTER,HEADER,HINT_TYPE,JUMP_EXPRESS,JUMP_FIELD,MAX_ROW_COUNT,MONITOR_ID,MULTI_PAGE_FLAG,NOADD_FIELDS,NOEDIT_FIELDS,NOMODIFY_FIELDS,NOSHOW_APP_FIELDS,NOSHOW_FIELDS,OPEN_MODE,OPERATE_TYPE,OPERATION_TYPE,OUTPUT_PARAMETER,PAGE_SIZES,QUERY_COUNT,QUERY_FIELDS,QUERY_TYPE,RFID_FLAG,SCANNABLE_FIELD,SCANNABLE_LOCATION_LINE,SCANNABLE_TIME,SCANNABLE_TYPE,SUBNOSHOW_FIELDS,SUB_EDIT_STATE,SUB_TABLE_JUDGE_FIELD,UI_TMPL,DELETE_SQL,DETAIL_SQL,INSERT_SQL,LOCK_SQL,NEWID_SQL,OPRETION_HINT,SELECT_SQL,SUBSELECT_SQL,UPDATE_SQL) = (SELECT ,q''[]'',q''[]'',q''[]'',,q''[]'',q''[]'',,q''[]'',q''[]'',,q''[]'',1,q''[]'',q''[]'',q''[]'',q''[]'',q''[company_id]'',,0,q''[]'',q''[]'',q''[20,30,50,100,200,500]'',,q''[]'',0,,q''[]'',q''[]'',,,q''[]'',,q''[]'',q''[]'',:CV1,:CV2,:CV3,:CV4,:CV5,:CV6,:CV7,:CV8,:CV9 FROM DUAL) WHERE ITEM_ID = ''a_supp_111_5''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3,CV4,CV5,CV6,CV7,CV8,CV9;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_ITEM_LIST (AUTO_REFRESH,BACK_GROUND_ID,EDIT_EXPRESS,END_FIELD,EXECUTE_TIME,FOOTER,HEADER,HINT_TYPE,ITEM_ID,JUMP_EXPRESS,JUMP_FIELD,MAX_ROW_COUNT,MONITOR_ID,MULTI_PAGE_FLAG,NOADD_FIELDS,NOEDIT_FIELDS,NOMODIFY_FIELDS,NOSHOW_APP_FIELDS,NOSHOW_FIELDS,OPEN_MODE,OPERATE_TYPE,OPERATION_TYPE,OUTPUT_PARAMETER,PAGE_SIZES,QUERY_COUNT,QUERY_FIELDS,QUERY_TYPE,RFID_FLAG,SCANNABLE_FIELD,SCANNABLE_LOCATION_LINE,SCANNABLE_TIME,SCANNABLE_TYPE,SUBNOSHOW_FIELDS,SUB_EDIT_STATE,SUB_TABLE_JUDGE_FIELD,UI_TMPL,DELETE_SQL,DETAIL_SQL,INSERT_SQL,LOCK_SQL,NEWID_SQL,OPRETION_HINT,SELECT_SQL,SUBSELECT_SQL,UPDATE_SQL) SELECT ,q''[]'',q''[]'',q''[]'',,q''[]'',q''[]'',,''a_supp_111_5'',q''[]'',q''[]'',,q''[]'',1,q''[]'',q''[]'',q''[]'',q''[]'',q''[company_id]'',,0,q''[]'',q''[]'',q''[20,30,50,100,200,500]'',,q''[]'',0,,q''[]'',q''[]'',,,q''[]'',,q''[]'',q''[]'',:CV1,:CV2,:CV3,:CV4,:CV5,:CV6,:CV7,:CV8,:CV9 FROM DUAL';
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
  CV1 CLOB:=q'^^';
  CV2 CLOB:=q'^^';
  CV3 CLOB:=q'^^';
  CV4 CLOB:=q'^^';
  CV5 CLOB:=q'^^';
  CV6 CLOB:=q'^^';
  CV7 CLOB:=q'^--修改后的查询代码
SELECT v.supplier_info_id,
       v.company_id,
       v.supplier_info_origin,
       v.status,
       v.pause,
       v.regist_status,
       v.bind_status,
       v.supplier_code,
       v.inside_supplier_code,
       v.supplier_company_id,
       v.supplier_company_name,
       v.supplier_company_abbreviation,
       v.cooperation_type_sp,
       nvl(v.cooperation_classification_sp, f.group_dict_name) cooperation_classification_sp, --合作分类：不验厂取申请单的数据，验厂取报告以及能力评估明细表
       nvl(v.cooperation_subcategory_sp, g.group_dict_name) cooperation_subcategory_sp, --合作子类：不验厂取申请单的数据，验厂取报告以及能力评估明细表
       v.cooperation_method_sp,
       v.cooperation_model_sp,
       v.production_mode_sp,
       v.ask_date,
       v.check_date,
       v.create_supp_date,
       v.social_credit_code,
       v.regist_address,
       v.legal_representative,
       v.company_create_date,
       v.regist_price,
       v.company_contact_person,
       v.company_contact_phone
  FROM (SELECT e.group_dict_name supplier_info_origin,
               sp.status,
               sp.pause,
               nvl2(sp.supplier_company_id,'已注册','未注册') regist_status,
               sp.bind_status,
               sp.supplier_code,
               sp.inside_supplier_code,
               sp.supplier_company_name,
               sp.supplier_company_abbreviation,
               ar.ask_date,
               fr.check_date,
               sp.create_supp_date,
               sp.social_credit_code,
               sp.regist_address,
               sp.legal_representative,
               sp.company_create_date,
               sp.regist_price,
               a.group_dict_name cooperation_type_sp,
               (SELECT listagg(DISTINCT t.group_dict_name, ';') within GROUP(ORDER BY 1)
                  FROM scmdata.sys_group_dict     t,
                       scmdata.t_supplier_ability sa
                 WHERE sp.supplier_info_id = sa.supplier_info_id
                   AND t.group_dict_type = sp.cooperation_type
                   AND t.group_dict_value = sa.cooperation_classification
                   AND t.pause = 0) cooperation_classification_sp,
               (SELECT listagg(DISTINCT t.group_dict_name, ';') within GROUP(ORDER BY 1)
                  FROM scmdata.sys_group_dict     t,
                       scmdata.t_supplier_ability sa
                 WHERE sp.supplier_info_id = sa.supplier_info_id
                   AND t.group_dict_type = sa.cooperation_classification
                   AND t.group_dict_value = sa.cooperation_subcategory
                   AND t.pause = 0) cooperation_subcategory_sp,
               b.group_dict_name cooperation_method_sp,
               c.group_dict_name cooperation_model_sp,
               d.group_dict_name production_mode_sp,
               sp.company_contact_person,
               sp.company_contact_phone,
               sp.create_date,
               sp.supplier_info_origin_id,
               sp.cooperation_type,
               sp.supplier_info_id,
               sp.supplier_company_id,
               sp.company_id
          FROM scmdata.t_supplier_info sp
          LEFT JOIN scmdata.t_factory_ask fa
            ON sp.supplier_info_origin_id = fa.factory_ask_id
          LEFT JOIN scmdata.t_factory_report fr
            ON fa.factory_ask_id = fr.factory_ask_id
          LEFT JOIN scmdata.t_ask_record ar
            ON fa.ask_record_id = ar.ask_record_id
          LEFT JOIN scmdata.sys_group_dict a
            ON a.group_dict_type = 'COOPERATION_TYPE'
           AND sp.cooperation_type = a.group_dict_value
          LEFT JOIN scmdata.sys_group_dict b
            ON b.group_dict_type = 'COOP_METHOD'
           AND b.group_dict_value = sp.cooperation_method
          LEFT JOIN scmdata.sys_group_dict c
            ON c.group_dict_type = 'SUPPLY_TYPE'
           AND c.group_dict_value = sp.cooperation_model
          LEFT JOIN scmdata.sys_group_dict d
            ON d.group_dict_type = 'CPMODE_TYPE'
           AND d.group_dict_value = sp.production_mode
          LEFT JOIN scmdata.sys_group_dict e
            ON e.group_dict_type = 'ORIGIN_TYPE'
           AND e.group_dict_value = sp.supplier_info_origin
          LEFT JOIN scmdata.sys_company fc
            ON sp.social_credit_code = fc.licence_num
         WHERE sp.company_id = %default_company_id%
           AND sp.status = 1) v
  LEFT JOIN scmdata.t_factory_ask fa
    ON fa.factory_ask_id = v.supplier_info_origin_id
  LEFT JOIN scmdata.sys_group_dict f
    ON f.group_dict_type = v.cooperation_type
   AND f.group_dict_value = fa.cooperation_classification
  LEFT JOIN scmdata.sys_group_dict g
    ON g.group_dict_type = fa.cooperation_classification
   AND g.group_dict_value = fa.cooperation_subcategory
 ORDER BY v.create_date DESC^';
  CV8 CLOB:=q'^^';
  CV9 CLOB:=q'^^';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_ITEM_LIST WHERE ITEM_ID = ''a_supp_120''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_ITEM_LIST SET (AUTO_REFRESH,BACK_GROUND_ID,EDIT_EXPRESS,END_FIELD,EXECUTE_TIME,FOOTER,HEADER,HINT_TYPE,JUMP_EXPRESS,JUMP_FIELD,MAX_ROW_COUNT,MONITOR_ID,MULTI_PAGE_FLAG,NOADD_FIELDS,NOEDIT_FIELDS,NOMODIFY_FIELDS,NOSHOW_APP_FIELDS,NOSHOW_FIELDS,OPEN_MODE,OPERATE_TYPE,OPERATION_TYPE,OUTPUT_PARAMETER,PAGE_SIZES,QUERY_COUNT,QUERY_FIELDS,QUERY_TYPE,RFID_FLAG,SCANNABLE_FIELD,SCANNABLE_LOCATION_LINE,SCANNABLE_TIME,SCANNABLE_TYPE,SUBNOSHOW_FIELDS,SUB_EDIT_STATE,SUB_TABLE_JUDGE_FIELD,UI_TMPL,DELETE_SQL,DETAIL_SQL,INSERT_SQL,LOCK_SQL,NEWID_SQL,OPRETION_HINT,SELECT_SQL,SUBSELECT_SQL,UPDATE_SQL) = (SELECT 1,q''[]'',q''[]'',q''[]'',,q''[]'',q''[]'',,q''[]'',q''[]'',,q''[]'',1,q''[]'',q''[]'',q''[]'',q''[]'',q''[supplier_info_id,company_id,supplier_company_id,supplier_info_origin_id,status,pause,cooperation_method_sp,production_mode_sp,sp_status_desc,bind_status]'',,0,q''[]'',q''[]'',q''[20,30,50,100,200,500]'',,q''[supplier_company_name,supplier_company_abbreviation]'',12,,q''[]'',q''[]'',,,q''[]'',,q''[]'',q''[]'',:CV1,:CV2,:CV3,:CV4,:CV5,:CV6,:CV7,:CV8,:CV9 FROM DUAL) WHERE ITEM_ID = ''a_supp_120''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3,CV4,CV5,CV6,CV7,CV8,CV9;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_ITEM_LIST (AUTO_REFRESH,BACK_GROUND_ID,EDIT_EXPRESS,END_FIELD,EXECUTE_TIME,FOOTER,HEADER,HINT_TYPE,ITEM_ID,JUMP_EXPRESS,JUMP_FIELD,MAX_ROW_COUNT,MONITOR_ID,MULTI_PAGE_FLAG,NOADD_FIELDS,NOEDIT_FIELDS,NOMODIFY_FIELDS,NOSHOW_APP_FIELDS,NOSHOW_FIELDS,OPEN_MODE,OPERATE_TYPE,OPERATION_TYPE,OUTPUT_PARAMETER,PAGE_SIZES,QUERY_COUNT,QUERY_FIELDS,QUERY_TYPE,RFID_FLAG,SCANNABLE_FIELD,SCANNABLE_LOCATION_LINE,SCANNABLE_TIME,SCANNABLE_TYPE,SUBNOSHOW_FIELDS,SUB_EDIT_STATE,SUB_TABLE_JUDGE_FIELD,UI_TMPL,DELETE_SQL,DETAIL_SQL,INSERT_SQL,LOCK_SQL,NEWID_SQL,OPRETION_HINT,SELECT_SQL,SUBSELECT_SQL,UPDATE_SQL) SELECT 1,q''[]'',q''[]'',q''[]'',,q''[]'',q''[]'',,''a_supp_120'',q''[]'',q''[]'',,q''[]'',1,q''[]'',q''[]'',q''[]'',q''[]'',q''[supplier_info_id,company_id,supplier_company_id,supplier_info_origin_id,status,pause,cooperation_method_sp,production_mode_sp,sp_status_desc,bind_status]'',,0,q''[]'',q''[]'',q''[20,30,50,100,200,500]'',,q''[supplier_company_name,supplier_company_abbreviation]'',12,,q''[]'',q''[]'',,,q''[]'',,q''[]'',q''[]'',:CV1,:CV2,:CV3,:CV4,:CV5,:CV6,:CV7,:CV8,:CV9 FROM DUAL';
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
  CV1 CLOB:=q'^^';
  CV2 CLOB:=q'^^';
  CV3 CLOB:=q'^{
DECLARE
  v_sup_id      VARCHAR2(32);
  v_rest_method VARCHAR2(256);
  v_params      VARCHAR2(256);
  v_sql         CLOB;
BEGIN
  --获取asscoiate请求参数
  pkg_plat_comm.p_get_rest_val_method_params(p_character     => :supplier_info_id,
                                             po_pk_id        => v_sup_id,
                                             po_rest_methods => v_rest_method,
                                             po_params       => v_params);

  IF v_rest_method IS NULL OR instr(';' || v_rest_method || ';', ';' || 'POST' || ';') > 0 THEN
    v_sql := q'[--不考虑供应商是否已经在平台注册
DECLARE
  v_t_sup_rec scmdata.t_supplier_info%ROWTYPE;
  v_supply_id VARCHAR2(32);
  v_supp_company_id VARCHAR2(32);
BEGIN

  v_supply_id                         := :supplier_info_id;
  v_t_sup_rec.supplier_info_id        := v_supply_id;
  v_t_sup_rec.company_id              := %default_company_id%;
  v_t_sup_rec.supplier_info_origin    := 'MA';
  v_t_sup_rec.supplier_info_origin_id := NULL;
  v_t_sup_rec.status                  := 0;
  --基本信息
  v_t_sup_rec.supplier_company_name         := :sp_sup_company_name_y; --公司名称
  v_t_sup_rec.supplier_company_abbreviation := :sp_sup_company_abb_y; --公司简称
  v_t_sup_rec.social_credit_code            := :sp_social_credit_code_y; --统一社会信用代码
  --v_t_sup_rec.supplier_code                 := :sp_supplier_code_n; --供应商编号
  v_t_sup_rec.inside_supplier_code  := :sp_inside_supplier_code_n; --内部供应商编号
  v_t_sup_rec.company_regist_date   := :sp_company_regist_date_y; --公司注册日期
  v_t_sup_rec.company_province      := :company_province; --公司省
  v_t_sup_rec.company_city          := :company_city; --公司市
  v_t_sup_rec.company_county        := :company_county; --公司区
  v_t_sup_rec.company_vill          := :ar_company_vill_y; --公司乡镇
  v_t_sup_rec.company_address       := :sp_company_address_y; --公司地址
  v_t_sup_rec.group_name            := :sp_group_name_n; --分组名称（v9.9版 存值改为分组ID）
  v_t_sup_rec.legal_representative  := :sp_legal_represent_n; --法定代表人
  v_t_sup_rec.company_contact_phone := :sp_company_contact_phone_n; --公司联系电话
  v_t_sup_rec.fa_contact_name       := :sp_contact_name_y; --业务联系人
  v_t_sup_rec.fa_contact_phone      := :sp_contact_phone_y; --业务联系人手机
  v_t_sup_rec.company_type          := :sp_company_type_y; --公司类型
  v_t_sup_rec.is_our_factory        := :ar_is_our_factory_y; --是否本厂
  v_t_sup_rec.factroy_area          := :sp_factroy_area_y; --工厂面积（m2）
  v_t_sup_rec.remarks               := :sp_remarks_n; --备注

  --生产信息
  v_t_sup_rec.product_type      := :sp_product_type_y; --生产类型
  v_t_sup_rec.brand_type        := :sp_brand_type_n; --合作品牌/客户 类型
  v_t_sup_rec.cooperation_brand := :cooperation_brand; --合作品牌/客户
  v_t_sup_rec.product_link      := :sp_product_link_n; --生产环节

  v_t_sup_rec.product_line        := :sp_product_line_n; --生产线类型
  v_t_sup_rec.product_line_num    := :sp_product_line_num_n; --生产线数量
  v_t_sup_rec.quality_step        := :sp_quality_step_y; --质量等级
  v_t_sup_rec.work_hours_day      := :sp_work_hours_day_y; --上班时数/天
  v_t_sup_rec.worker_total_num    := :sp_worker_total_num_y; --总人数
  v_t_sup_rec.worker_num          := :sp_worker_num_y; --车位人数
  v_t_sup_rec.machine_num         := :sp_machine_num_y; --织机台数
  v_t_sup_rec.form_num            := :sp_form_num_y; --成型人数_鞋类
  v_t_sup_rec.product_efficiency  := :sp_product_efficiency_y; --产能效率
  v_t_sup_rec.pattern_cap         := :sp_pattern_cap_y; --打版能力
  v_t_sup_rec.fabric_purchase_cap := :sp_fabric_purchase_cap_y; --面料采购能力
  v_t_sup_rec.fabric_check_cap    := :sp_fabric_check_cap_y; --面料检测能力

  --合作信息
  v_t_sup_rec.pause := :sp_coop_state_y; --状态：0 启用 1 停用 2 试单

  SELECT MAX(fc.company_id)
    INTO v_supp_company_id
    FROM scmdata.sys_company fc
   WHERE fc.company_id = %default_company_id%
     AND fc.licence_num = :sp_social_credit_code_y;

  v_t_sup_rec.supplier_company_id := v_supp_company_id; --供应商在平台的企业id
  v_t_sup_rec.cooperation_type    := :sp_cooperation_type_y; --合作类型
  v_t_sup_rec.cooperation_model   := :sp_cooperation_model_y; --合作模式
  v_t_sup_rec.coop_position       := :sp_coop_position_n; --合作定位
  v_t_sup_rec.pay_term            := :ar_pay_term_n; --付款条件

  --附件资料
  v_t_sup_rec.certificate_file  := :sp_certificate_file_y; --上传营业执照
  v_t_sup_rec.supplier_gate     := :sp_supplier_gate_n; --公司大门附件地址
  v_t_sup_rec.supplier_office   := :sp_supplier_office_n; --公司办公室附件地址
  v_t_sup_rec.supplier_site     := :sp_supplier_site_n; --生产现场附件地址
  v_t_sup_rec.supplier_product  := :sp_supplier_product_n; --产品图片附件地址
  v_t_sup_rec.other_information := :sp_other_information_n; --其他资料

  --其它
  v_t_sup_rec.create_id   := :user_id;
  v_t_sup_rec.create_date := SYSDATE;
  v_t_sup_rec.update_id   := :user_id; --修改人ID
  v_t_sup_rec.update_date := SYSDATE; --修改时间

  --1.新增 => 保存，校验数据
  scmdata.pkg_supplier_info.p_check_save_t_supplier_info(p_sp_data => v_t_sup_rec);
  --2.插入数据
  scmdata.pkg_supplier_info.p_insert_supplier_info(p_sp_data => v_t_sup_rec);
  --3.同步人员机器配置
  scmdata.pkg_supplier_info_a.p_generate_person_machine_config(p_company_id => %default_company_id%,p_user_id => :user_id,p_sup_id => v_supply_id);
END;
]';
  ELSE
    v_sql := NULL;
  END IF;
  ^'|| CHR(64) ||q'^strresult := v_sql;
END;
}^';
  CV4 CLOB:=q'^^';
  CV5 CLOB:=q'^SELECT scmdata.pkg_plat_comm.f_getkeyid_plat('GY', 'seq_plat_code', 99) AS supplier_info_id FROM dual^';
  CV6 CLOB:=q'^^';
  CV7 CLOB:=q'^{
DECLARE
  v_sup_id         VARCHAR2(32);
  v_rest_method    VARCHAR2(256);
  v_params         VARCHAR2(256);
  v_sql            CLOB;
  v_is_delay_query INT DEFAULT 0;
BEGIN
  --获取asscoiate请求参数
  pkg_plat_comm.p_get_rest_val_method_params(p_character     => NVL(%ass_supplier_info_id%,:supplier_info_id),
                                             po_pk_id        => v_sup_id,
                                             po_rest_methods => v_rest_method,
                                             po_params       => v_params);

  IF v_rest_method IS NULL OR
     instr(';' || v_rest_method || ';', ';' || 'GET' || ';') > 0 THEN
    IF v_rest_method IS NULL THEN
      v_is_delay_query := 1;
    END IF;
    v_sql := scmdata.pkg_supplier_info_a.f_query_supp_info(p_company_id     => %default_company_id%,
                                                           p_supp_id        => v_sup_id,
                                                           p_is_delay_query => v_is_delay_query);
  ELSE
    v_sql := NULL;
  END IF;
  ^'|| CHR(64) ||q'^strresult := v_sql;
END;
}^';
  CV8 CLOB:=q'^^';
  CV9 CLOB:=q'^--update sql by czh55 2023-01-10 02:54:52
{
DECLARE
  v_pk_id       VARCHAR2(32);
  v_rest_method VARCHAR2(256);
  v_params      VARCHAR2(256);
  v_sql         CLOB;
BEGIN
  --获取asscoiate请求参数
  pkg_plat_comm.p_get_rest_val_method_params(p_character     => NVL(%supplier_info_id%,:supplier_info_id),
                                             po_pk_id        => v_pk_id,
                                             po_rest_methods => v_rest_method,
                                             po_params       => v_params);

  IF v_rest_method IS NULL OR instr(';' || v_rest_method || ';', ';' || 'PUT' || ';') > 0 THEN
    v_sql := q'[
    DECLARE
      v_t_sup_rec       scmdata.t_supplier_info%ROWTYPE;
      v_supp_company_id VARCHAR2(32);
      v_supp_id         VARCHAR2(32) := ']' || v_pk_id || q'['; --主键
    BEGIN
      v_t_sup_rec.supplier_info_id := v_supp_id; --主键
      v_t_sup_rec.company_id       := %default_company_id%; --公司编码
      --基本信息
      v_t_sup_rec.supplier_company_name         := :sp_sup_company_name_y; --公司名称
      v_t_sup_rec.supplier_company_abbreviation := :sp_sup_company_abb_y; --公司简称
      v_t_sup_rec.social_credit_code            := :sp_social_credit_code_y; --统一社会信用代码
      --v_t_sup_rec.supplier_code                 := :sp_supplier_code_n; --供应商编号
      v_t_sup_rec.inside_supplier_code  := :sp_inside_supplier_code_n; --内部供应商编号
      v_t_sup_rec.company_regist_date   := :sp_company_regist_date_y; --公司注册日期
      v_t_sup_rec.company_province      := :company_province; --公司省
      v_t_sup_rec.company_city          := :company_city; --公司市
      v_t_sup_rec.company_county        := :company_county; --公司区
      v_t_sup_rec.company_vill          := :ar_company_vill_y; --公司乡镇
      v_t_sup_rec.company_address       := :sp_company_address_y; --公司地址
      v_t_sup_rec.group_name            := :sp_group_name_n; --分组名称（v9.9版 存值改为分组ID）
      v_t_sup_rec.legal_representative  := :sp_legal_represent_n; --法定代表人
      v_t_sup_rec.company_contact_phone := :sp_company_contact_phone_n; --公司联系电话
      v_t_sup_rec.fa_contact_name       := :sp_contact_name_y; --业务联系人
      v_t_sup_rec.fa_contact_phone      := :sp_contact_phone_y; --业务联系人手机
      v_t_sup_rec.company_type          := :sp_company_type_y; --公司类型
      v_t_sup_rec.is_our_factory        := :ar_is_our_factory_y; --是否本厂
      v_t_sup_rec.factroy_area          := :sp_factroy_area_y; --工厂面积（m2）
      v_t_sup_rec.remarks               := :sp_remarks_n; --备注

      --生产信息
      v_t_sup_rec.product_type      := :sp_product_type_y; --生产类型
      v_t_sup_rec.brand_type        := :sp_brand_type_n; --合作品牌/客户 类型
      v_t_sup_rec.cooperation_brand := :cooperation_brand; --合作品牌/客户
      v_t_sup_rec.product_link      := :sp_product_link_n; --生产环节

      v_t_sup_rec.product_line        := :sp_product_line_n; --生产线类型
      v_t_sup_rec.product_line_num    := :sp_product_line_num_n; --生产线数量
      v_t_sup_rec.quality_step        := :sp_quality_step_y; --质量等级
      v_t_sup_rec.work_hours_day      := :sp_work_hours_day_y; --上班时数/天
      v_t_sup_rec.worker_total_num    := :sp_worker_total_num_y; --总人数
      v_t_sup_rec.worker_num          := :sp_worker_num_y; --车位人数
      v_t_sup_rec.machine_num         := :sp_machine_num_y; --织机台数
      v_t_sup_rec.form_num            := :sp_form_num_y; --成型人数_鞋类
      v_t_sup_rec.product_efficiency  := :sp_product_efficiency_y; --产能效率
      v_t_sup_rec.pattern_cap         := :sp_pattern_cap_y; --打版能力
      v_t_sup_rec.fabric_purchase_cap := :sp_fabric_purchase_cap_y; --面料采购能力
      v_t_sup_rec.fabric_check_cap    := :sp_fabric_check_cap_y; --面料检测能力

      --合作信息
      v_t_sup_rec.pause := :sp_coop_state_y; --状态：0 启用 1 停用 2 试单

      SELECT MAX(fc.company_id)
        INTO v_supp_company_id
        FROM scmdata.sys_company fc
       WHERE fc.company_id = %default_company_id%
         AND fc.licence_num = :sp_social_credit_code_y;

      v_t_sup_rec.supplier_company_id := v_supp_company_id; --供应商在平台的企业id
      v_t_sup_rec.cooperation_type    := :sp_cooperation_type_y; --合作类型
      v_t_sup_rec.cooperation_model   := :sp_cooperation_model_y; --合作模式
      v_t_sup_rec.coop_position       := :sp_coop_position_n; --合作定位
      v_t_sup_rec.pay_term            := :ar_pay_term_n; --付款条件

      --附件资料
      v_t_sup_rec.certificate_file  := :sp_certificate_file_y; --上传营业执照
      v_t_sup_rec.supplier_gate     := :sp_supplier_gate_n; --公司大门附件地址
      v_t_sup_rec.supplier_office   := :sp_supplier_office_n; --公司办公室附件地址
      v_t_sup_rec.supplier_site     := :sp_supplier_site_n; --生产现场附件地址
      v_t_sup_rec.supplier_product  := :sp_supplier_product_n; --产品图片附件地址
      v_t_sup_rec.other_information := :sp_other_information_n; --其他资料

      --其它
      v_t_sup_rec.update_id   := :user_id; --修改人ID
      v_t_sup_rec.update_date := SYSDATE; --修改时间

      --修改 t_supplier_info
      --1.更新=》保存，校验数据
      pkg_supplier_info.p_update_supplier_info(p_sp_data => v_t_sup_rec);
      --2.更新所在区域
      pkg_supplier_info.p_update_group_name(p_company_id       => %default_company_id%,
                                            p_supplier_info_id => v_supp_id,
                                            p_is_by_pick       => 1,
                                            p_province         => :company_province,
                                            p_city             => :company_city);
    END update_supp_info;]';
  ELSE
    v_sql := NULL;
  END IF;
  ^'|| CHR(64) ||q'^strresult := v_sql;
END;
}^';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_ITEM_LIST WHERE ITEM_ID = ''a_supp_151''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_ITEM_LIST SET (AUTO_REFRESH,BACK_GROUND_ID,EDIT_EXPRESS,END_FIELD,EXECUTE_TIME,FOOTER,HEADER,HINT_TYPE,JUMP_EXPRESS,JUMP_FIELD,MAX_ROW_COUNT,MONITOR_ID,MULTI_PAGE_FLAG,NOADD_FIELDS,NOEDIT_FIELDS,NOMODIFY_FIELDS,NOSHOW_APP_FIELDS,NOSHOW_FIELDS,OPEN_MODE,OPERATE_TYPE,OPERATION_TYPE,OUTPUT_PARAMETER,PAGE_SIZES,QUERY_COUNT,QUERY_FIELDS,QUERY_TYPE,RFID_FLAG,SCANNABLE_FIELD,SCANNABLE_LOCATION_LINE,SCANNABLE_TIME,SCANNABLE_TYPE,SUBNOSHOW_FIELDS,SUB_EDIT_STATE,SUB_TABLE_JUDGE_FIELD,UI_TMPL,DELETE_SQL,DETAIL_SQL,INSERT_SQL,LOCK_SQL,NEWID_SQL,OPRETION_HINT,SELECT_SQL,SUBSELECT_SQL,UPDATE_SQL) = (SELECT 1,q''[]'',q''[]'',q''[]'',,q''[]'',q''[]'',,q''[]'',q''[]'',,q''[]'',1,q''[]'',q''[sp_group_name_n,sp_worker_total_num_y,sp_worker_num_y,sp_form_num_y,sp_pattern_cap_y,sp_fabric_purchase_cap_y]'',q''[]'',q''[]'',q''[SUPPLIER_INFO_ID,COMPANY_ID,SUPPLIER_INFO_ORIGIN_ID,TAXPAYER,COOPERATION_CLASSIFICATION,COOPERATION_SUBCATEGORY,COOPERATION_METHOD,COOPERATION_MODEL,COOPERATION_TYPE,PRODUCTION_MODE,COOPERATION_METHOD_SP,PRODUCTION_MODE_SP,PAY_TYPE,SETTLEMENT_TYPE,SHARING_TYPE,PROVINCE,CITY,COUNTY,COMPANY_VILL,COOPSTATE,BRAND_TYPE,PATTERN_CAP,FABRIC_PURCHASE_CAP,FABRIC_CHECK_CAP,COST_STEP,FA_BRAND_TYPE,GROUP_NAME,OMPANY_TYPE_Y,SP_PRODUCT_TYPE_Y,SP_PRODUCT_LINK_N,SP_PRODUCT_LINE_N,SP_QUALITY_STEP_N,SP_COMPANY_TYPE_Y,cooperation_brand,sp_cooperation_type_y,sp_cooperation_model_y,sp_quality_step_y,sp_pattern_cap_y,sp_fabric_check_cap_y,AR_COMPANY_VILL_Y,sp_fabric_purchase_cap_y,ar_pay_term_n,AR_IS_OUR_FACTORY_Y,sp_coop_state_y,SP_COOP_POSITION_N]'',,0,q''[]'',q''[]'',q''[20,30,50,100,200,500]'',,q''[]'',0,,q''[]'',q''[]'',,,q''[]'',,q''[]'',q''[00]'',:CV1,:CV2,:CV3,:CV4,:CV5,:CV6,:CV7,:CV8,:CV9 FROM DUAL) WHERE ITEM_ID = ''a_supp_151''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3,CV4,CV5,CV6,CV7,CV8,CV9;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_ITEM_LIST (AUTO_REFRESH,BACK_GROUND_ID,EDIT_EXPRESS,END_FIELD,EXECUTE_TIME,FOOTER,HEADER,HINT_TYPE,ITEM_ID,JUMP_EXPRESS,JUMP_FIELD,MAX_ROW_COUNT,MONITOR_ID,MULTI_PAGE_FLAG,NOADD_FIELDS,NOEDIT_FIELDS,NOMODIFY_FIELDS,NOSHOW_APP_FIELDS,NOSHOW_FIELDS,OPEN_MODE,OPERATE_TYPE,OPERATION_TYPE,OUTPUT_PARAMETER,PAGE_SIZES,QUERY_COUNT,QUERY_FIELDS,QUERY_TYPE,RFID_FLAG,SCANNABLE_FIELD,SCANNABLE_LOCATION_LINE,SCANNABLE_TIME,SCANNABLE_TYPE,SUBNOSHOW_FIELDS,SUB_EDIT_STATE,SUB_TABLE_JUDGE_FIELD,UI_TMPL,DELETE_SQL,DETAIL_SQL,INSERT_SQL,LOCK_SQL,NEWID_SQL,OPRETION_HINT,SELECT_SQL,SUBSELECT_SQL,UPDATE_SQL) SELECT 1,q''[]'',q''[]'',q''[]'',,q''[]'',q''[]'',,''a_supp_151'',q''[]'',q''[]'',,q''[]'',1,q''[]'',q''[sp_group_name_n,sp_worker_total_num_y,sp_worker_num_y,sp_form_num_y,sp_pattern_cap_y,sp_fabric_purchase_cap_y]'',q''[]'',q''[]'',q''[SUPPLIER_INFO_ID,COMPANY_ID,SUPPLIER_INFO_ORIGIN_ID,TAXPAYER,COOPERATION_CLASSIFICATION,COOPERATION_SUBCATEGORY,COOPERATION_METHOD,COOPERATION_MODEL,COOPERATION_TYPE,PRODUCTION_MODE,COOPERATION_METHOD_SP,PRODUCTION_MODE_SP,PAY_TYPE,SETTLEMENT_TYPE,SHARING_TYPE,PROVINCE,CITY,COUNTY,COMPANY_VILL,COOPSTATE,BRAND_TYPE,PATTERN_CAP,FABRIC_PURCHASE_CAP,FABRIC_CHECK_CAP,COST_STEP,FA_BRAND_TYPE,GROUP_NAME,OMPANY_TYPE_Y,SP_PRODUCT_TYPE_Y,SP_PRODUCT_LINK_N,SP_PRODUCT_LINE_N,SP_QUALITY_STEP_N,SP_COMPANY_TYPE_Y,cooperation_brand,sp_cooperation_type_y,sp_cooperation_model_y,sp_quality_step_y,sp_pattern_cap_y,sp_fabric_check_cap_y,AR_COMPANY_VILL_Y,sp_fabric_purchase_cap_y,ar_pay_term_n,AR_IS_OUR_FACTORY_Y,sp_coop_state_y,SP_COOP_POSITION_N]'',,0,q''[]'',q''[]'',q''[20,30,50,100,200,500]'',,q''[]'',0,,q''[]'',q''[]'',,,q''[]'',,q''[]'',q''[00]'',:CV1,:CV2,:CV3,:CV4,:CV5,:CV6,:CV7,:CV8,:CV9 FROM DUAL';
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
  CV1 CLOB:=q'^DELETE FROM scmdata.t_contract_info_temp A
WHERE A.COMPANY_ID = %default_company_id%
AND A.USER_ID =  %user_id%
AND A.TEMP_ID = :TEMP_ID^';
  CV2 CLOB:=q'^^';
  CV3 CLOB:=q'^DECLARE
  v_temp_id VARCHAR2(100);

BEGIN
  v_temp_id := f_getkeyid_plat('', 'SEQ_CA', '');
  INSERT INTO scmdata.t_contract_info_temp
    (supplier_info_id,
     inside_supplier_code,
     supplier_company_name,
     company_id,
     contract_start_date,
     contract_stop_date,
     contract_sign_date,
     contract_file,
     contract_type,
     contract_num,
     user_id,
     temp_id)
  VALUES
    (:supplier_info_id,
     :inside_supplier_code_sp,
     :supplier_company_name,
     :default_company_id,
     :contract_start_date,
     :contract_stop_date,
     :contract_sign_date,
     :contract_file,
     :contract_type,
     :contract_num,
     :user_id,
     v_temp_id);
  pkg_supplier_info.check_import_constract(p_temp_id => v_temp_id);
END;^';
  CV4 CLOB:=q'^^';
  CV5 CLOB:=q'^SELECT CONTRACT_START_DATE,
       CONTRACT_STOP_DATE,
       CONTRACT_SIGN_DATE,
       CONTRACT_FILE,
       CONTRACT_TYPE,
       CONTRACT_NUM
  FROM T_CONTRACT_INFO_TEMP
 WHERE COMPANY_ID = %DEFAULT_COMPANY_ID%
   AND USER_ID = %USER_ID%^';
  CV6 CLOB:=q'^^';
  CV7 CLOB:=q'^SELECT inside_supplier_code inside_supplier_code_sp,
       supplier_company_name,
       user_id,
       --USER_NAME,
       company_id,
       temp_id,
       contract_start_date,
       contract_stop_date,
       contract_sign_date,
       contract_file,
       contract_type,
       contract_num,
       msg
  FROM t_contract_info_temp
 WHERE company_id = %default_company_id%
   AND user_id = :user_id^';
  CV8 CLOB:=q'^^';
  CV9 CLOB:=q'^declare
begin
UPDATE scmdata.t_contract_info_temp a
   SET a.inside_supplier_code  = :inside_supplier_code_sp,
       a.supplier_company_name = :supplier_company_name,
       a.contract_start_date   = :contract_start_date,
       a.contract_stop_date    = :contract_stop_date,
       a.contract_sign_date    = :contract_sign_date,
       a.contract_file         = :contract_file,
       a.contract_type         = :contract_type,
       a.contract_num          = :contract_num
 WHERE a.company_id = %default_company_id%
   AND a.user_id = %user_id%
   AND a.temp_id = :temp_id;
pkg_supplier_info.check_import_constract(p_temp_id => :temp_id);
end;^';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_ITEM_LIST WHERE ITEM_ID = ''a_supp_151_6''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_ITEM_LIST SET (AUTO_REFRESH,BACK_GROUND_ID,EDIT_EXPRESS,END_FIELD,EXECUTE_TIME,FOOTER,HEADER,HINT_TYPE,JUMP_EXPRESS,JUMP_FIELD,MAX_ROW_COUNT,MONITOR_ID,MULTI_PAGE_FLAG,NOADD_FIELDS,NOEDIT_FIELDS,NOMODIFY_FIELDS,NOSHOW_APP_FIELDS,NOSHOW_FIELDS,OPEN_MODE,OPERATE_TYPE,OPERATION_TYPE,OUTPUT_PARAMETER,PAGE_SIZES,QUERY_COUNT,QUERY_FIELDS,QUERY_TYPE,RFID_FLAG,SCANNABLE_FIELD,SCANNABLE_LOCATION_LINE,SCANNABLE_TIME,SCANNABLE_TYPE,SUBNOSHOW_FIELDS,SUB_EDIT_STATE,SUB_TABLE_JUDGE_FIELD,UI_TMPL,DELETE_SQL,DETAIL_SQL,INSERT_SQL,LOCK_SQL,NEWID_SQL,OPRETION_HINT,SELECT_SQL,SUBSELECT_SQL,UPDATE_SQL) = (SELECT 1,q''[]'',q''[]'',q''[]'',,q''[]'',q''[]'',,q''[]'',q''[]'',,q''[]'',1,q''[]'',q''[]'',q''[]'',q''[]'',q''[USER_ID,COMPANY_ID,TEMP_ID,CONTRACT_TYPE]'',,0,q''[]'',q''[]'',q''[20,30,50,100,200,500]'',,q''[]'',0,,q''[]'',q''[]'',,,q''[]'',,q''[]'',q''[]'',:CV1,:CV2,:CV3,:CV4,:CV5,:CV6,:CV7,:CV8,:CV9 FROM DUAL) WHERE ITEM_ID = ''a_supp_151_6''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3,CV4,CV5,CV6,CV7,CV8,CV9;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_ITEM_LIST (AUTO_REFRESH,BACK_GROUND_ID,EDIT_EXPRESS,END_FIELD,EXECUTE_TIME,FOOTER,HEADER,HINT_TYPE,ITEM_ID,JUMP_EXPRESS,JUMP_FIELD,MAX_ROW_COUNT,MONITOR_ID,MULTI_PAGE_FLAG,NOADD_FIELDS,NOEDIT_FIELDS,NOMODIFY_FIELDS,NOSHOW_APP_FIELDS,NOSHOW_FIELDS,OPEN_MODE,OPERATE_TYPE,OPERATION_TYPE,OUTPUT_PARAMETER,PAGE_SIZES,QUERY_COUNT,QUERY_FIELDS,QUERY_TYPE,RFID_FLAG,SCANNABLE_FIELD,SCANNABLE_LOCATION_LINE,SCANNABLE_TIME,SCANNABLE_TYPE,SUBNOSHOW_FIELDS,SUB_EDIT_STATE,SUB_TABLE_JUDGE_FIELD,UI_TMPL,DELETE_SQL,DETAIL_SQL,INSERT_SQL,LOCK_SQL,NEWID_SQL,OPRETION_HINT,SELECT_SQL,SUBSELECT_SQL,UPDATE_SQL) SELECT 1,q''[]'',q''[]'',q''[]'',,q''[]'',q''[]'',,''a_supp_151_6'',q''[]'',q''[]'',,q''[]'',1,q''[]'',q''[]'',q''[]'',q''[]'',q''[USER_ID,COMPANY_ID,TEMP_ID,CONTRACT_TYPE]'',,0,q''[]'',q''[]'',q''[20,30,50,100,200,500]'',,q''[]'',0,,q''[]'',q''[]'',,,q''[]'',,q''[]'',q''[]'',:CV1,:CV2,:CV3,:CV4,:CV5,:CV6,:CV7,:CV8,:CV9 FROM DUAL';
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
  CV1 CLOB:=q'^^';
  CV2 CLOB:=q'^^';
  CV3 CLOB:=q'^^';
  CV4 CLOB:=q'^^';
  CV5 CLOB:=q'^select pkg_data_privs.parse_json(p_jsonstr => %data_privs_json_strs%,p_key => 'COL_2') class_data_privs from dual^';
  CV6 CLOB:=q'^^';
  CV7 CLOB:=q'^--czh 重构代码
{DECLARE
  v_sql CLOB;
BEGIN
  v_sql      := pkg_supplier_info.f_query_filed_supp_info();
  ^'|| CHR(64) ||q'^strresult := v_sql;
END;}^';
  CV8 CLOB:=q'^{declare
v_class_data_privs clob;
begin
 v_class_data_privs := pkg_data_privs.parse_json(p_jsonstr => %data_privs_json_strs%,p_key => 'COL_2');
 ^'|| CHR(64) ||q'^strresult :='(SELECT * FROM (SELECT ' || '''' || v_class_data_privs || '''' || ' FROM dual))';
end;}^';
  CV9 CLOB:=q'^BEGIN
  --1.更新=》保存，校验数据

  IF :group_name IS NULL THEN
   raise_application_error(-20002, '所在分组不可为空!');
  END IF;

  UPDATE scmdata.t_supplier_info t
     SET t.group_name = :group_name,
         t.GROUP_NAME_ORIGIN = 'MA',
         t.update_id = :user_id,
         t.update_date = sysdate
   WHERE t.supplier_info_id = :supplier_info_id
     AND t.company_id = :company_id;
END;^';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_ITEM_LIST WHERE ITEM_ID = ''a_supp_160''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_ITEM_LIST SET (AUTO_REFRESH,BACK_GROUND_ID,EDIT_EXPRESS,END_FIELD,EXECUTE_TIME,FOOTER,HEADER,HINT_TYPE,JUMP_EXPRESS,JUMP_FIELD,MAX_ROW_COUNT,MONITOR_ID,MULTI_PAGE_FLAG,NOADD_FIELDS,NOEDIT_FIELDS,NOMODIFY_FIELDS,NOSHOW_APP_FIELDS,NOSHOW_FIELDS,OPEN_MODE,OPERATE_TYPE,OPERATION_TYPE,OUTPUT_PARAMETER,PAGE_SIZES,QUERY_COUNT,QUERY_FIELDS,QUERY_TYPE,RFID_FLAG,SCANNABLE_FIELD,SCANNABLE_LOCATION_LINE,SCANNABLE_TIME,SCANNABLE_TYPE,SUBNOSHOW_FIELDS,SUB_EDIT_STATE,SUB_TABLE_JUDGE_FIELD,UI_TMPL,DELETE_SQL,DETAIL_SQL,INSERT_SQL,LOCK_SQL,NEWID_SQL,OPRETION_HINT,SELECT_SQL,SUBSELECT_SQL,UPDATE_SQL) = (SELECT 1,q''[]'',q''[]'',q''[]'',,q''[]'',q''[]'',,q''[]'',q''[]'',,q''[]'',1,q''[]'',q''[]'',q''[]'',q''[]'',q''[supplier_info_id,company_id,supplier_company_id,supplier_info_origin_id,status,pause,cooperation_method_sp,production_mode_sp,sp_status_desc,bind_status,factory_ask_id,coop_status,GROUP_NAME]'',,0,q''[]'',q''[]'',q''[20,30,50,100,200,500]'',,q''[supplier_company_name,supplier_company_abbreviation]'',12,,q''[]'',q''[]'',,,q''[]'',,q''[]'',q''[]'',:CV1,:CV2,:CV3,:CV4,:CV5,:CV6,:CV7,:CV8,:CV9 FROM DUAL) WHERE ITEM_ID = ''a_supp_160''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3,CV4,CV5,CV6,CV7,CV8,CV9;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_ITEM_LIST (AUTO_REFRESH,BACK_GROUND_ID,EDIT_EXPRESS,END_FIELD,EXECUTE_TIME,FOOTER,HEADER,HINT_TYPE,ITEM_ID,JUMP_EXPRESS,JUMP_FIELD,MAX_ROW_COUNT,MONITOR_ID,MULTI_PAGE_FLAG,NOADD_FIELDS,NOEDIT_FIELDS,NOMODIFY_FIELDS,NOSHOW_APP_FIELDS,NOSHOW_FIELDS,OPEN_MODE,OPERATE_TYPE,OPERATION_TYPE,OUTPUT_PARAMETER,PAGE_SIZES,QUERY_COUNT,QUERY_FIELDS,QUERY_TYPE,RFID_FLAG,SCANNABLE_FIELD,SCANNABLE_LOCATION_LINE,SCANNABLE_TIME,SCANNABLE_TYPE,SUBNOSHOW_FIELDS,SUB_EDIT_STATE,SUB_TABLE_JUDGE_FIELD,UI_TMPL,DELETE_SQL,DETAIL_SQL,INSERT_SQL,LOCK_SQL,NEWID_SQL,OPRETION_HINT,SELECT_SQL,SUBSELECT_SQL,UPDATE_SQL) SELECT 1,q''[]'',q''[]'',q''[]'',,q''[]'',q''[]'',,''a_supp_160'',q''[]'',q''[]'',,q''[]'',1,q''[]'',q''[]'',q''[]'',q''[]'',q''[supplier_info_id,company_id,supplier_company_id,supplier_info_origin_id,status,pause,cooperation_method_sp,production_mode_sp,sp_status_desc,bind_status,factory_ask_id,coop_status,GROUP_NAME]'',,0,q''[]'',q''[]'',q''[20,30,50,100,200,500]'',,q''[supplier_company_name,supplier_company_abbreviation]'',12,,q''[]'',q''[]'',,,q''[]'',,q''[]'',q''[]'',:CV1,:CV2,:CV3,:CV4,:CV5,:CV6,:CV7,:CV8,:CV9 FROM DUAL';
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
  CV1 CLOB:=q'^^';
  CV2 CLOB:=q'^^';
  CV3 CLOB:=q'^DECLARE
v_supp_rec scmdata.t_supplier_info_temp%ROWTYPE;
BEGIN
  v_supp_rec.supplier_temp_id       := scmdata.f_get_uuid();
  v_supp_rec.company_id             := %default_company_id%;
  v_supp_rec.user_id                := :user_id;
  v_supp_rec.inside_supplier_code   := :inside_supplier_code_sp;
  v_supp_rec.supplier_company_name  := :supplier_company_name;
  v_supp_rec.cooperation_type       := :cooperation_type_sp;
  v_supp_rec.company_city           := :company_city_sp;
  v_supp_rec.company_province       := :company_province_sp;
  v_supp_rec.company_county         := :company_county_sp;
  v_supp_rec.company_address        := :company_address_sp;
  v_supp_rec.social_credit_code     := :social_credit_code_tp;
  v_supp_rec.legal_representative   := :legal_representative;
  v_supp_rec.company_contact_person := :company_contact_person;
  v_supp_rec.company_contact_phone  := :company_contact_phone_tp;
  v_supp_rec.cooperation_type_code  := :cooperation_type_code;
  v_supp_rec.company_city_code      := :company_city_code;
  v_supp_rec.company_province_code  := :company_province_code;
  v_supp_rec.company_county_code    := :company_county_code;
  v_supp_rec.cooperation_model_code := :cooperation_model_code;
  v_supp_rec.cooperation_model      := :cooperation_model_sp;
  v_supp_rec.memo:=:memo;
  scmdata.pkg_supplier_info.insert_supplier_info_temp(p_supp_rec => v_supp_rec);
END;^';
  CV4 CLOB:=q'^^';
  CV5 CLOB:=q'^^';
  CV6 CLOB:=q'^^';
  CV7 CLOB:=q'^SELECT t.supplier_temp_id,
       t.company_id,
       t.user_id,
       t.inside_supplier_code inside_supplier_code_sp,
       t.supplier_company_name,
       t.cooperation_type_code,
       t.cooperation_type cooperation_type_sp,
       t.cooperation_model_code,
       t.cooperation_model cooperation_model_sp,
       t.company_province_code,
       t.company_province company_province_sp,
       t.company_city_code,
       t.company_city company_city_sp,
       t.company_county_code,
       t.company_county company_county_sp,
       t.company_address company_address_sp,
       t.social_credit_code social_credit_code_tp,
       t.legal_representative,
       t.company_contact_person,
       t.company_contact_phone company_contact_phone_tp,
       t.memo,
       t.err_msg_id,
       m.msg
  FROM scmdata.t_supplier_info_temp t
  LEFT JOIN scmdata.t_supplier_info_import_msg m
    ON t.err_msg_id = m.msg_id
 WHERE t.company_id = %default_company_id%
   AND t.user_id = :user_id
   ORDER BY t.inside_supplier_code asc^';
  CV8 CLOB:=q'^^';
  CV9 CLOB:=q'^DECLARE
v_supp_rec scmdata.t_supplier_info_temp%ROWTYPE;
BEGIN
  v_supp_rec.supplier_temp_id       := :supplier_temp_id;
  v_supp_rec.company_id             := %default_company_id%;
  v_supp_rec.user_id                := :user_id;
  v_supp_rec.inside_supplier_code   := :inside_supplier_code_sp;
  v_supp_rec.supplier_company_name  := :supplier_company_name;
  v_supp_rec.cooperation_type       := :cooperation_type_sp;
  v_supp_rec.company_city           := :company_city_sp;
  v_supp_rec.company_province       := :company_province_sp;
  v_supp_rec.company_county         := :company_county_sp;
  v_supp_rec.company_address        := :company_address_sp;
  v_supp_rec.social_credit_code     := :social_credit_code_tp;
  v_supp_rec.legal_representative   := :legal_representative;
  v_supp_rec.company_contact_person := :company_contact_person;
  v_supp_rec.company_contact_phone  := :company_contact_phone_tp;
  v_supp_rec.cooperation_type_code  := :cooperation_type_code;
  v_supp_rec.company_city_code      := :company_city_code;
  v_supp_rec.company_province_code  := :company_province_code;
  v_supp_rec.company_county_code    := :company_county_code;
  v_supp_rec.cooperation_model_code := :cooperation_model_code;
  v_supp_rec.cooperation_model      := :cooperation_model_sp;
v_supp_rec.memo:=:memo;
  scmdata.pkg_supplier_info.update_supplier_info_temp(p_supp_rec => v_supp_rec);
END;^';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_ITEM_LIST WHERE ITEM_ID = ''a_supp_160_1''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_ITEM_LIST SET (AUTO_REFRESH,BACK_GROUND_ID,EDIT_EXPRESS,END_FIELD,EXECUTE_TIME,FOOTER,HEADER,HINT_TYPE,JUMP_EXPRESS,JUMP_FIELD,MAX_ROW_COUNT,MONITOR_ID,MULTI_PAGE_FLAG,NOADD_FIELDS,NOEDIT_FIELDS,NOMODIFY_FIELDS,NOSHOW_APP_FIELDS,NOSHOW_FIELDS,OPEN_MODE,OPERATE_TYPE,OPERATION_TYPE,OUTPUT_PARAMETER,PAGE_SIZES,QUERY_COUNT,QUERY_FIELDS,QUERY_TYPE,RFID_FLAG,SCANNABLE_FIELD,SCANNABLE_LOCATION_LINE,SCANNABLE_TIME,SCANNABLE_TYPE,SUBNOSHOW_FIELDS,SUB_EDIT_STATE,SUB_TABLE_JUDGE_FIELD,UI_TMPL,DELETE_SQL,DETAIL_SQL,INSERT_SQL,LOCK_SQL,NEWID_SQL,OPRETION_HINT,SELECT_SQL,SUBSELECT_SQL,UPDATE_SQL) = (SELECT 1,q''[]'',q''[]'',q''[]'',,q''[]'',q''[]'',,q''[]'',q''[]'',,q''[]'',1,q''[]'',q''[]'',q''[]'',q''[]'',q''[supplier_temp_id,company_id,user_id,err_msg_id]'',,0,q''[]'',q''[]'',q''[20,30,50,100,200,500]'',,q''[]'',12,,q''[]'',q''[]'',,,q''[]'',,q''[]'',q''[]'',:CV1,:CV2,:CV3,:CV4,:CV5,:CV6,:CV7,:CV8,:CV9 FROM DUAL) WHERE ITEM_ID = ''a_supp_160_1''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3,CV4,CV5,CV6,CV7,CV8,CV9;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_ITEM_LIST (AUTO_REFRESH,BACK_GROUND_ID,EDIT_EXPRESS,END_FIELD,EXECUTE_TIME,FOOTER,HEADER,HINT_TYPE,ITEM_ID,JUMP_EXPRESS,JUMP_FIELD,MAX_ROW_COUNT,MONITOR_ID,MULTI_PAGE_FLAG,NOADD_FIELDS,NOEDIT_FIELDS,NOMODIFY_FIELDS,NOSHOW_APP_FIELDS,NOSHOW_FIELDS,OPEN_MODE,OPERATE_TYPE,OPERATION_TYPE,OUTPUT_PARAMETER,PAGE_SIZES,QUERY_COUNT,QUERY_FIELDS,QUERY_TYPE,RFID_FLAG,SCANNABLE_FIELD,SCANNABLE_LOCATION_LINE,SCANNABLE_TIME,SCANNABLE_TYPE,SUBNOSHOW_FIELDS,SUB_EDIT_STATE,SUB_TABLE_JUDGE_FIELD,UI_TMPL,DELETE_SQL,DETAIL_SQL,INSERT_SQL,LOCK_SQL,NEWID_SQL,OPRETION_HINT,SELECT_SQL,SUBSELECT_SQL,UPDATE_SQL) SELECT 1,q''[]'',q''[]'',q''[]'',,q''[]'',q''[]'',,''a_supp_160_1'',q''[]'',q''[]'',,q''[]'',1,q''[]'',q''[]'',q''[]'',q''[]'',q''[supplier_temp_id,company_id,user_id,err_msg_id]'',,0,q''[]'',q''[]'',q''[20,30,50,100,200,500]'',,q''[]'',12,,q''[]'',q''[]'',,,q''[]'',,q''[]'',q''[]'',:CV1,:CV2,:CV3,:CV4,:CV5,:CV6,:CV7,:CV8,:CV9 FROM DUAL';
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
  CV1 CLOB:=q'^delete from t_coop_scope_temp where coop_scope_temp_id = :coop_scope_temp_id^';
  CV2 CLOB:=q'^^';
  CV3 CLOB:=q'^declare
  p_id varchar2(32);
begin
  p_id := f_get_uuid();
  insert into t_coop_scope_temp
    (coop_scope_temp_id,
     company_id,
     supplier_company_name,
     coop_classification,
     coop_product_cate,
     coop_subcategory,
     msg_type,
     msg,
     coop_classification_desc,
     coop_product_cate_desc,
     coop_subcategory_desc,
     inside_supplier_code,
     create_id, sharing_type,
         sharing_type_desc,
         sharing_sup_code,
         sharing_sup_code_desc)
  values
    (p_id,
     %default_company_id%,
     :supplier_company_name,
     :COOP_CLASSIFICATION_NUM,
     :COOP_PRODUCT_CATE_NUM,
     :COOP_SUBCATEGORY_NUM,
     null,
     null,
     :coop_classification_desc,
     :coop_product_cate_desc,
     :COOP_SUBCATEGORY,
     :inside_supplier_code_sp,
     %user_id%,:sharing_type,
         :sharing_type_desc,
         :sharing_sup_code,
         :sharing_sup_code_desc);
  pkg_supplier_info.check_importdatas_coop_scope(p_coop_scope_temp_id => p_id);
end;^';
  CV4 CLOB:=q'^^';
  CV5 CLOB:=q'^^';
  CV6 CLOB:=q'^^';
  CV7 CLOB:=q'^select a.coop_scope_temp_id,
       a.inside_supplier_code inside_supplier_code_sp,
       a.supplier_company_name,
       a.coop_classification      COOP_CLASSIFICATION_NUM,
       a.coop_classification_desc,
       a.coop_product_cate        COOP_PRODUCT_CATE_NUM,
       a.coop_product_cate_desc,
       a.coop_subcategory         COOP_SUBCATEGORY_NUM,
       a.coop_subcategory_desc COOP_SUBCATEGORY,
       a.sharing_type,
         a.sharing_type_desc,
         a.sharing_sup_code,
         a.sharing_sup_code_desc,
         nvl(a.msg,'校验成功!')                      MSG
  from scmdata.t_coop_scope_temp a
  where a.company_id=%default_company_id%
  and a.create_id=:user_id^';
  CV8 CLOB:=q'^^';
  CV9 CLOB:=q'^declare
begin
 update scmdata.t_coop_scope_temp a
    set a.inside_supplier_code     = :inside_supplier_code_sp,
        a.supplier_company_name    = :supplier_company_name,
        a.coop_classification      = :COOP_CLASSIFICATION_NUM,
        a.coop_classification_desc = :coop_classification_desc,
        a.coop_product_cate        = :COOP_PRODUCT_CATE_NUM,
        a.coop_product_cate_desc   = :coop_product_cate_desc,
        a.coop_subcategory         = :COOP_SUBCATEGORY_NUM,
        a.coop_subcategory_desc    = :COOP_SUBCATEGORY,
        a.sharing_type= :sharing_type,
         a.sharing_type_desc= :sharing_type_desc,
         a.sharing_sup_code= :sharing_sup_code,
         a.sharing_sup_code_desc= :sharing_sup_code_desc
  where a.coop_scope_temp_id = :coop_scope_temp_id;
  pkg_supplier_info.check_importdatas_coop_scope(p_coop_scope_temp_id => :coop_scope_temp_id);
end;^';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_ITEM_LIST WHERE ITEM_ID = ''a_supp_170''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_ITEM_LIST SET (AUTO_REFRESH,BACK_GROUND_ID,EDIT_EXPRESS,END_FIELD,EXECUTE_TIME,FOOTER,HEADER,HINT_TYPE,JUMP_EXPRESS,JUMP_FIELD,MAX_ROW_COUNT,MONITOR_ID,MULTI_PAGE_FLAG,NOADD_FIELDS,NOEDIT_FIELDS,NOMODIFY_FIELDS,NOSHOW_APP_FIELDS,NOSHOW_FIELDS,OPEN_MODE,OPERATE_TYPE,OPERATION_TYPE,OUTPUT_PARAMETER,PAGE_SIZES,QUERY_COUNT,QUERY_FIELDS,QUERY_TYPE,RFID_FLAG,SCANNABLE_FIELD,SCANNABLE_LOCATION_LINE,SCANNABLE_TIME,SCANNABLE_TYPE,SUBNOSHOW_FIELDS,SUB_EDIT_STATE,SUB_TABLE_JUDGE_FIELD,UI_TMPL,DELETE_SQL,DETAIL_SQL,INSERT_SQL,LOCK_SQL,NEWID_SQL,OPRETION_HINT,SELECT_SQL,SUBSELECT_SQL,UPDATE_SQL) = (SELECT 1,q''[]'',q''[]'',q''[]'',,q''[]'',q''[]'',,q''[]'',q''[]'',,q''[]'',1,q''[]'',q''[]'',q''[]'',q''[]'',q''[COOP_SUBCATEGORY_NUM,COOP_PRODUCT_CATE_NUM,COOP_CLASSIFICATION_NUM,coop_scope_temp_id]'',,0,q''[]'',q''[]'',q''[20,30,50,100,200,500]'',,q''[]'',,,q''[]'',q''[]'',,,q''[]'',,q''[]'',q''[]'',:CV1,:CV2,:CV3,:CV4,:CV5,:CV6,:CV7,:CV8,:CV9 FROM DUAL) WHERE ITEM_ID = ''a_supp_170''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3,CV4,CV5,CV6,CV7,CV8,CV9;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_ITEM_LIST (AUTO_REFRESH,BACK_GROUND_ID,EDIT_EXPRESS,END_FIELD,EXECUTE_TIME,FOOTER,HEADER,HINT_TYPE,ITEM_ID,JUMP_EXPRESS,JUMP_FIELD,MAX_ROW_COUNT,MONITOR_ID,MULTI_PAGE_FLAG,NOADD_FIELDS,NOEDIT_FIELDS,NOMODIFY_FIELDS,NOSHOW_APP_FIELDS,NOSHOW_FIELDS,OPEN_MODE,OPERATE_TYPE,OPERATION_TYPE,OUTPUT_PARAMETER,PAGE_SIZES,QUERY_COUNT,QUERY_FIELDS,QUERY_TYPE,RFID_FLAG,SCANNABLE_FIELD,SCANNABLE_LOCATION_LINE,SCANNABLE_TIME,SCANNABLE_TYPE,SUBNOSHOW_FIELDS,SUB_EDIT_STATE,SUB_TABLE_JUDGE_FIELD,UI_TMPL,DELETE_SQL,DETAIL_SQL,INSERT_SQL,LOCK_SQL,NEWID_SQL,OPRETION_HINT,SELECT_SQL,SUBSELECT_SQL,UPDATE_SQL) SELECT 1,q''[]'',q''[]'',q''[]'',,q''[]'',q''[]'',,''a_supp_170'',q''[]'',q''[]'',,q''[]'',1,q''[]'',q''[]'',q''[]'',q''[]'',q''[COOP_SUBCATEGORY_NUM,COOP_PRODUCT_CATE_NUM,COOP_CLASSIFICATION_NUM,coop_scope_temp_id]'',,0,q''[]'',q''[]'',q''[20,30,50,100,200,500]'',,q''[]'',,,q''[]'',q''[]'',,,q''[]'',,q''[]'',q''[]'',:CV1,:CV2,:CV3,:CV4,:CV5,:CV6,:CV7,:CV8,:CV9 FROM DUAL';
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
  CV1 CLOB:=q'^^';
  CV2 CLOB:=q'^^';
  CV3 CLOB:=q'^^';
  CV4 CLOB:=q'^^';
  CV5 CLOB:=q'^^';
  CV6 CLOB:=q'^^';
  CV7 CLOB:=q'^WITH DIC AS
 (SELECT GROUP_DICT_NAME, GROUP_DICT_VALUE, GROUP_DICT_TYPE
    FROM SCMDATA.SYS_GROUP_DICT)
SELECT (CASE
         WHEN TAR.COLLECTION = 1 THEN
          '收藏'
       END) COLLECTION,
       TAR.COOR_ASK_FLOW_STATUS,
       TAR.CREATE_DATE COOP_APPLY_DATE,
       TAR.COMPANY_NAME ASK_COMPANY_NAME,
       (SELECT LISTAGG(Y.GROUP_DICT_NAME, ';')
          FROM (SELECT DISTINCT COOPERATION_CLASSIFICATION TMP
                  FROM SCMDATA.T_ASK_SCOPE
                 WHERE OBJECT_ID = TAR.ASK_RECORD_ID
                   AND COMPANY_ID = DECODE(TAR.ORIGIN,
                                           'MA',
                                           TAR.BE_COMPANY_ID,
                                           TAR.COMPANY_ID)) Z
         INNER JOIN DIC Y
            ON Z.TMP = Y.GROUP_DICT_VALUE
           AND Y.GROUP_DICT_TYPE = 'PRODUCT_TYPE') COOPERATION_CLASSIFICATION_DESC,
       TAR.COOPERATION_MODEL,
       (SELECT GROUP_DICT_NAME
          FROM DIC
         WHERE TAR.COOPERATION_MODEL = GROUP_DICT_VALUE
           AND GROUP_DICT_TYPE = 'SUPPLY_TYPE') COOPERATION_MODEL_DESC,
       SUBSTR(STATUS, 1, INSTR(STATUS, '+') - 1) FLOW_NODE_NAME,
       SUBSTR(STATUS, INSTR(STATUS, '+') + 1, LENGTH(STATUS)) FLOW_NODE_STATUS_DESC,
       SAPPLY_USER,
       SAPPLY_PHONE,
       (SELECT LISTAGG(W.GROUP_DICT_NAME, ';')
          FROM (SELECT DISTINCT COOPERATION_TYPE TMP
                  FROM SCMDATA.T_ASK_SCOPE
                 WHERE OBJECT_ID = TAR.ASK_RECORD_ID) X
         INNER JOIN DIC W
            ON X.TMP = W.GROUP_DICT_VALUE
           AND W.GROUP_DICT_TYPE = 'COOPERATION_TYPE') COOPERATION_TYPE_DESC,
       TAR.COMPANY_ADDRESS,
       (SELECT COMPANY_USER_NAME
          FROM SCMDATA.SYS_COMPANY_USER
         WHERE COMPANY_ID =
               DECODE(TAR.ORIGIN, 'MA', TAR.BE_COMPANY_ID, TAR.COMPANY_ID)
           AND USER_ID = TAR.CREATE_ID) CREATOR,
       TAR.CREATE_DATE CREATE_TIME,
       TAR.ASK_RECORD_ID,
       TAR.ASK_USER_ID,
       TAR.COMPANY_ID,
       TAR.ASK_SAY, --合作申请说明
       CERTIFICATE_FILE, --营业执照
       case
         when status like '%待审核%' then
          'icon-renliziyuanxinxiguanlixitong (81)'
         when status like '%不通过%' then
          'icon-renliziyuanxinxiguanlixitong (24)'
         else
          'icon-feiyongshezhi2'
       end status_desc
  FROM (SELECT A.*,
               (SELECT GROUP_DICT_NAME
                  FROM DIC
                 WHERE GROUP_DICT_TYPE = 'FACTORY_ASK_FLOW'
                   AND GROUP_DICT_VALUE =
                       NVL((SELECT STATUS_AF_OPER
                             FROM (SELECT STATUS_AF_OPER
                                     FROM SCMDATA.T_FACTORY_ASK_OPER_LOG
                                    WHERE ASK_RECORD_ID = A.ASK_RECORD_ID
                                    ORDER BY OPER_TIME DESC)
                            WHERE ROWNUM < 2),
                           A.COOR_ASK_FLOW_STATUS)) STATUS
          FROM SCMDATA.T_ASK_RECORD A
         WHERE BE_COMPANY_ID = %DEFAULT_COMPANY_ID%) TAR
 order by TAR.CREATE_DATE desc^';
  CV8 CLOB:=q'^^';
  CV9 CLOB:=q'^^';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_ITEM_LIST WHERE ITEM_ID = ''test_fl_new_list''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_ITEM_LIST SET (AUTO_REFRESH,BACK_GROUND_ID,EDIT_EXPRESS,END_FIELD,EXECUTE_TIME,FOOTER,HEADER,HINT_TYPE,JUMP_EXPRESS,JUMP_FIELD,MAX_ROW_COUNT,MONITOR_ID,MULTI_PAGE_FLAG,NOADD_FIELDS,NOEDIT_FIELDS,NOMODIFY_FIELDS,NOSHOW_APP_FIELDS,NOSHOW_FIELDS,OPEN_MODE,OPERATE_TYPE,OPERATION_TYPE,OUTPUT_PARAMETER,PAGE_SIZES,QUERY_COUNT,QUERY_FIELDS,QUERY_TYPE,RFID_FLAG,SCANNABLE_FIELD,SCANNABLE_LOCATION_LINE,SCANNABLE_TIME,SCANNABLE_TYPE,SUBNOSHOW_FIELDS,SUB_EDIT_STATE,SUB_TABLE_JUDGE_FIELD,UI_TMPL,DELETE_SQL,DETAIL_SQL,INSERT_SQL,LOCK_SQL,NEWID_SQL,OPRETION_HINT,SELECT_SQL,SUBSELECT_SQL,UPDATE_SQL) = (SELECT ,q''[]'',q''[]'',q''[]'',,q''[]'',q''[]'',,q''[]'',q''[]'',,q''[]'',1,q''[]'',q''[]'',q''[]'',q''[]'',q''[ASK_RECORD_ID,COOR_ASK_FLOW_STATUS,COOPERATION_TYPE,COOPERATION_CLASSIFICATION,COOPERATION_SUBCATEGORY,COOPERATION_MODEL,PRODUCTION_MODE,BE_COMPANY_ID,ASK_USER_ID,COMPANY_ID,FACTORY_ASK_ID,COOPERATION_PRODUCT_CATE]'',,0,q''[]'',q''[]'',q''[20,30,50,100,200,500]'',,q''[ASK_COMPANY_NAME]'',13,,q''[]'',q''[]'',,,q''[]'',,q''[]'',q''[]'',:CV1,:CV2,:CV3,:CV4,:CV5,:CV6,:CV7,:CV8,:CV9 FROM DUAL) WHERE ITEM_ID = ''test_fl_new_list''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3,CV4,CV5,CV6,CV7,CV8,CV9;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_ITEM_LIST (AUTO_REFRESH,BACK_GROUND_ID,EDIT_EXPRESS,END_FIELD,EXECUTE_TIME,FOOTER,HEADER,HINT_TYPE,ITEM_ID,JUMP_EXPRESS,JUMP_FIELD,MAX_ROW_COUNT,MONITOR_ID,MULTI_PAGE_FLAG,NOADD_FIELDS,NOEDIT_FIELDS,NOMODIFY_FIELDS,NOSHOW_APP_FIELDS,NOSHOW_FIELDS,OPEN_MODE,OPERATE_TYPE,OPERATION_TYPE,OUTPUT_PARAMETER,PAGE_SIZES,QUERY_COUNT,QUERY_FIELDS,QUERY_TYPE,RFID_FLAG,SCANNABLE_FIELD,SCANNABLE_LOCATION_LINE,SCANNABLE_TIME,SCANNABLE_TYPE,SUBNOSHOW_FIELDS,SUB_EDIT_STATE,SUB_TABLE_JUDGE_FIELD,UI_TMPL,DELETE_SQL,DETAIL_SQL,INSERT_SQL,LOCK_SQL,NEWID_SQL,OPRETION_HINT,SELECT_SQL,SUBSELECT_SQL,UPDATE_SQL) SELECT ,q''[]'',q''[]'',q''[]'',,q''[]'',q''[]'',,''test_fl_new_list'',q''[]'',q''[]'',,q''[]'',1,q''[]'',q''[]'',q''[]'',q''[]'',q''[ASK_RECORD_ID,COOR_ASK_FLOW_STATUS,COOPERATION_TYPE,COOPERATION_CLASSIFICATION,COOPERATION_SUBCATEGORY,COOPERATION_MODEL,PRODUCTION_MODE,BE_COMPANY_ID,ASK_USER_ID,COMPANY_ID,FACTORY_ASK_ID,COOPERATION_PRODUCT_CATE]'',,0,q''[]'',q''[]'',q''[20,30,50,100,200,500]'',,q''[ASK_COMPANY_NAME]'',13,,q''[]'',q''[]'',,,q''[]'',,q''[]'',q''[]'',:CV1,:CV2,:CV3,:CV4,:CV5,:CV6,:CV7,:CV8,:CV9 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3,CV4,CV5,CV6,CV7,CV8,CV9;
     END IF;
  END;
END;
/

