declare
v_sql clob;
begin
v_sql := '--CZH 重构
DECLARE
  judge       NUMBER(1);
  tmp         NUMBER(5);
  p_fa_rec    scmdata.t_factory_ask%ROWTYPE;
  ask_row     scmdata.t_ask_scope%ROWTYPE;
  p_ask_rec   scmdata.t_ask_record%ROWTYPE;
  p_scope_rec scmdata.t_ask_scope%ROWTYPE;
  fs_id       VARCHAR2(32);
  v_nick_name VARCHAR2(32);
  v_phone     VARCHAR2(32);
BEGIN
  --除 CA01/FA01/FA02 外，都不能点击，点击报错
  SELECT COUNT(1)
    INTO judge
    FROM (SELECT status_af_oper
            FROM (SELECT status_af_oper
                    FROM scmdata.t_factory_ask_oper_log
                   WHERE ask_record_id = :ask_record_id
                   ORDER BY oper_time DESC)
           WHERE rownum < 2)
   WHERE status_af_oper IN (''CA01'', ''FA01'', ''FA03'', ''FA21'', ''FA33'');

  IF judge = 0 THEN
    raise_application_error(-20002,
                            ''已有单据在流程中或该供应商已准入通过，请勿重复申请！'');
  ELSE
    --待验厂单据唯一判定
    SELECT COUNT(factory_ask_id)
      INTO judge
      FROM scmdata.t_factory_ask
     WHERE ask_record_id = :ask_record_id
       AND factrory_ask_flow_status = ''CA01'';

    IF judge = 0 THEN
      --是否处于可再次申请验厂的范围
      SELECT COUNT(factrory_ask_flow_status)
        INTO tmp
        FROM scmdata.t_factory_ask
       WHERE ask_record_id = :ask_record_id;

      SELECT COUNT(factrory_ask_flow_status)
        INTO judge
        FROM scmdata.t_factory_ask
       WHERE ask_record_id = :ask_record_id
         AND factrory_ask_flow_status IN (''FA03'', ''FA21'', ''FA33'');

      IF tmp = 0 OR judge > 0 THEN
        --流程中是否有单据判定
        SELECT COUNT(factrory_ask_flow_status)
          INTO judge
          FROM (SELECT *
                  FROM (SELECT factrory_ask_flow_status
                          FROM scmdata.t_factory_ask
                         WHERE ask_record_id = :ask_record_id
                         ORDER BY create_date DESC)
                 WHERE rownum < 3)
         WHERE factrory_ask_flow_status NOT IN
               (''CA01'', ''FA03'', ''FA21'', ''FA33'')
           AND rownum < 2;
        IF judge = 0 THEN

          fs_id := scmdata.f_getkeyid_plat(''CA'', ''seq_ca'');

          SELECT *
            INTO p_ask_rec
            FROM scmdata.t_ask_record t
           WHERE t.ask_record_id = :ask_record_id;
          --申请信息
          p_fa_rec.ask_date          := p_ask_rec.ask_date;
          p_fa_rec.is_urgent         := 0;
          p_fa_rec.cooperation_model := p_ask_rec.cooperation_model;
          p_fa_rec.COOPERATION_TYPE  := p_ask_rec.COOPERATION_TYPE;
          p_fa_rec.product_type      := ''00'';
          p_fa_rec.ask_say           := '' '';

          --供应商基本信息
          p_fa_rec.factory_ask_id        := fs_id;
          p_fa_rec.company_id            := %default_company_id%;
          p_fa_rec.company_name          := p_ask_rec.company_name;
          p_fa_rec.company_abbreviation  := p_ask_rec.company_abbreviation;
          p_fa_rec.social_credit_code    := p_ask_rec.social_credit_code;
          p_fa_rec.company_province      := p_ask_rec.company_province;
          p_fa_rec.company_city          := p_ask_rec.company_city;
          p_fa_rec.company_county        := p_ask_rec.company_county;
          p_fa_rec.company_address       := p_ask_rec.company_address;
          p_fa_rec.ask_address           := '' '';
          p_fa_rec.legal_representative  := p_ask_rec.legal_representative;
          p_fa_rec.company_contact_phone := p_ask_rec.company_contact_phone;

          SELECT nick_name, phone
            INTO v_nick_name, v_phone
            FROM scmdata.sys_user
           WHERE user_id = p_ask_rec.create_id;

          p_fa_rec.contact_name          := nvl(p_ask_rec.sapply_user,v_nick_name);
          p_fa_rec.contact_phone         := nvl(p_ask_rec.sapply_phone,v_phone);
          p_fa_rec.company_type          := p_ask_rec.company_type;
          p_fa_rec.brand_type            := p_ask_rec.brand_type;
          p_fa_rec.cooperation_brand     := p_ask_rec.cooperation_brand;
          --p_fa_rec.com_manufacturer      := :com_manufacturer;
          p_fa_rec.certificate_file := p_ask_rec.certificate_file;
          p_fa_rec.supplier_gate    := p_ask_rec.supplier_gate;
          p_fa_rec.supplier_office  := p_ask_rec.supplier_office;
          p_fa_rec.supplier_site    := p_ask_rec.supplier_site;
          p_fa_rec.supplier_product := p_ask_rec.supplier_product;
          p_fa_rec.ask_user_id      := %current_userid%;
          p_fa_rec.ask_date         := SYSDATE;
          p_fa_rec.create_id        := %current_userid%;
          p_fa_rec.create_date      := SYSDATE;
          p_fa_rec.update_id        := %current_userid%;
          p_fa_rec.update_date      := SYSDATE;
          --p_fa_rec.rela_supplier_id := :rela_supplier_id;
          p_fa_rec.memo                  := p_ask_rec.remarks;
          p_fa_rec.product_link             := p_ask_rec.product_link;
          p_fa_rec.origin                   := ''CA'';
          p_fa_rec.ask_user_dept_id         := %default_dept_id%;
          p_fa_rec.ask_company_id           := %default_company_id%;
          p_fa_rec.ask_record_id            := :ask_record_id;
          p_fa_rec.factrory_ask_flow_status := ''CA01'';
          p_fa_rec.ask_user_id              := %current_userid%;

          --新增验厂申请单（供应商）
          scmdata.pkg_ask_record_mange.p_insert_factory_ask(p_fa_rec => p_fa_rec);

          FOR ask_row IN (SELECT *
                            FROM scmdata.t_ask_scope
                           WHERE object_id = :ask_record_id) LOOP

            p_scope_rec.ask_scope_id               := scmdata.f_get_uuid();
            p_scope_rec.company_id                 := %default_company_id%;
            p_scope_rec.object_id                  := fs_id;
            p_scope_rec.object_type                := ''CA'';
            p_scope_rec.cooperation_type           := ask_row.cooperation_type;
            p_scope_rec.cooperation_classification := ask_row.cooperation_classification;
            p_scope_rec.cooperation_product_cate   := ask_row.cooperation_product_cate;
            p_scope_rec.cooperation_subcategory    := ask_row.cooperation_subcategory;
            p_scope_rec.be_company_id              := ask_row.be_company_id;
            p_scope_rec.update_time                := SYSDATE;
            p_scope_rec.update_id                  := %current_userid%;
            p_scope_rec.create_id                  := %current_userid%;
            p_scope_rec.create_time                := SYSDATE;
            p_scope_rec.remarks                    := NULL;
            p_scope_rec.pause                      := 0;

            scmdata.pkg_ask_record_mange.p_insert_ask_scope(p_scope_rec => p_scope_rec);
          END LOOP;

          UPDATE scmdata.t_ask_record
             SET coor_ask_flow_status = ''CA01''
           WHERE ask_record_id = %ass_ask_record_id%;
        END IF;
      END IF;
    END IF;
  END IF;
END;
--原代码
/*DECLARE
  JUDGE NUMBER(1);
  TMP   NUMBER(5);
  ASK_ROW SCMDATA.T_ASK_SCOPE%ROWTYPE;
  FS_ID VARCHAR2(32);
BEGIN
  --除 CA01/FA01/FA02 外，都不能点击，点击报错
  SELECT COUNT(1)
     INTO JUDGE
    FROM (SELECT STATUS_AF_OPER
            FROM (SELECT STATUS_AF_OPER
                    FROM SCMDATA.T_FACTORY_ASK_OPER_LOG
                   WHERE ASK_RECORD_ID = :ASK_RECORD_ID
                   ORDER BY OPER_TIME DESC)
           WHERE ROWNUM < 2)
   WHERE STATUS_AF_OPER IN (''CA01'', ''FA01'', ''FA03'', ''FA21'', ''FA33'');

  IF JUDGE = 0 THEN
    RAISE_APPLICATION_ERROR(-20002, ''已有单据在流程中或该供应商已准入通过，请勿重复申请！'');
  ELSE
    --待验厂单据唯一判定
    SELECT COUNT(FACTORY_ASK_ID)
       INTO JUDGE
      FROM SCMDATA.T_FACTORY_ASK
     WHERE ASK_RECORD_ID = :ASK_RECORD_ID
       AND FACTRORY_ASK_FLOW_STATUS = ''CA01'';

    IF JUDGE=0 THEN
      --是否处于可再次申请验厂的范围
      SELECT COUNT(FACTRORY_ASK_FLOW_STATUS)
         INTO TMP
        FROM SCMDATA.T_FACTORY_ASK
       WHERE ASK_RECORD_ID = :ASK_RECORD_ID;

      SELECT COUNT(FACTRORY_ASK_FLOW_STATUS)
        INTO JUDGE
        FROM SCMDATA.T_FACTORY_ASK
       WHERE ASK_RECORD_ID = :ASK_RECORD_ID
         AND FACTRORY_ASK_FLOW_STATUS IN (''FA03'', ''FA21'', ''FA33'');

      IF TMP=0 OR JUDGE > 0 THEN
        --流程中是否有单据判定
        SELECT COUNT(FACTRORY_ASK_FLOW_STATUS)
           INTO JUDGE
          FROM (SELECT *
                  FROM (SELECT FACTRORY_ASK_FLOW_STATUS
                          FROM SCMDATA.T_FACTORY_ASK
                         WHERE ASK_RECORD_ID = :ASK_RECORD_ID
                         ORDER BY CREATE_DATE DESC)
                 WHERE ROWNUM < 3)
          WHERE FACTRORY_ASK_FLOW_STATUS NOT IN
               (''CA01'', ''FA03'', ''FA21'', ''FA33'')
            AND ROWNUM < 2;
        IF JUDGE = 0 THEN
          FS_ID := SCMDATA.F_GETKEYID_PLAT(''CA'', ''seq_ca'');
          INSERT INTO SCMDATA.T_FACTORY_ASK
                 (FACTORY_ASK_ID, COMPANY_ID, ASK_DATE, ASK_USER_ID, COMPANY_CITY, COMPANY_PROVINCE, COMPANY_COUNTY,
                  ASK_ADDRESS, COMPANY_ADDRESS, CONTACT_NAME, CONTACT_PHONE, ASK_COMPANY_ID, COOPERATION_MODEL, ASK_SAY,
                  ORIGIN, CREATE_ID, CREATE_DATE, ASK_RECORD_ID, ASK_USER_DEPT_ID, FACTRORY_ASK_FLOW_STATUS,COOPERATION_TYPE,
                  COOPERATION_COMPANY_ID, COMPANY_NAME, SOCIAL_CREDIT_CODE)
          SELECT  FS_ID FACTORY_ASK_ID, %DEFAULT_COMPANY_ID%, TRUNC(SYSDATE), %CURRENT_USERID%, T.COMPANY_CITY,
                  T.COMPANY_PROVINCE, T.COMPANY_COUNTY, '' '', T.COMPANY_ADDRESS, NVL(SAPPLY_USER,(SELECT NICK_NAME FROM SCMDATA.SYS_USER WHERE USER_ID=T.CREATE_ID)),
                  NVL(SAPPLY_PHONE,(SELECT PHONE FROM SCMDATA.SYS_USER WHERE USER_ID=T.CREATE_ID)),
                  %DEFAULT_COMPANY_ID%,T.COOPERATION_MODEL, '' '', ''CA'',
                  %CURRENT_USERID%, SYSDATE, :ASK_RECORD_ID, %DEFAULT_DEPT_ID%, ''CA01'',
                  T.COOPERATION_TYPE,T.COMPANY_ID, T.COMPANY_NAME, T.SOCIAL_CREDIT_CODE
            FROM  SCMDATA.T_ASK_RECORD T
           WHERE T.ASK_RECORD_ID=:ASK_RECORD_ID;

          FOR ASK_ROW IN (SELECT * FROM SCMDATA.T_ASK_SCOPE WHERE OBJECT_ID=:ASK_RECORD_ID) LOOP
              INSERT INTO SCMDATA.T_ASK_SCOPE
                (ASK_SCOPE_ID, COMPANY_ID, OBJECT_ID, OBJECT_TYPE, COOPERATION_TYPE, COOPERATION_CLASSIFICATION,
                 COOPERATION_PRODUCT_CATE, COOPERATION_SUBCATEGORY, BE_COMPANY_ID, UPDATE_TIME, UPDATE_ID,
                 CREATE_ID, CREATE_TIME, REMARKS, PAUSE)
              VALUES
                (SCMDATA.F_GET_UUID(), %DEFAULT_COMPANY_ID%, FS_ID, ''CA'', ASK_ROW.COOPERATION_TYPE, ASK_ROW.COOPERATION_CLASSIFICATION,
                 ASK_ROW.COOPERATION_PRODUCT_CATE, ASK_ROW.COOPERATION_SUBCATEGORY, ASK_ROW.BE_COMPANY_ID, SYSDATE, %CURRENT_USERID%,
                 %CURRENT_USERID%, SYSDATE, NULL, 0);
          END LOOP;

          UPDATE SCMDATA.T_ASK_RECORD SET COOR_ASK_FLOW_STATUS = ''CA01''
           WHERE ASK_RECORD_ID = %ASS_ASK_RECORD_ID%;
        END IF;
      END IF;
    END IF;
  END IF;
END;*/';
update bw3.sys_cond_list t set t.cond_sql = v_sql where t.cond_id = 'cond_a_coop_150_3' ;
end;
