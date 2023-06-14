DECLARE
  v_sql      CLOB;
  v_port_sql CLOB;
BEGIN
  v_sql := '--SCM =》181
SELECT '''' SUPPLIER_CODE,
       '''' SUPPLIER_COMPANY_NAME,
       '''' LEGAL_REPRESENTATIVE,
       '''' COMPANY_CONTACT_PERSON,
       '''' COMPANY_CONTACT_PHONE,
       '''' COMPANY_ADDRESS,
       '''' COMPANY_TYPE,
       '''' COOPERATION_MODEL_SP,
       '''' COMPANY_PROVINCE,
       '''' COMPANY_CITY,
       '''' COMPANY_COUNTY,
       '''' SOCIAL_CREDIT_CODE,
       '''' SUPP_DATE,
       '''' REMARKS,
       '''' CREATE_ID,
       '''' INSERT_TIME,
       '''' UPDATE_ID,
       '''' UPDATE_TIME,
       '''' PAUSE,
       '''' COOP_STATUS,
       --181 =》 SCM
       ''SCM'' PUBLISH_ID,
       to_char(sysdate, ''yyyy-mm-dd hh24:mi:ss'') PUBLISH_TIME,--sysdate PUBLISH_TIME,
       ''Y'' PUBLISH_FLAG
  FROM DUAL                 ';
  
  v_port_sql :='DECLARE
  v_itf_id   VARCHAR2(100);
  v_ctl_id   VARCHAR2(100);
  v_itf_flag NUMBER;
  itf_rec    t_supplier_base_itf%ROWTYPE;
  v_status   VARCHAR2(100);
BEGIN
  SELECT COUNT(1)
    INTO v_itf_flag
    FROM t_supplier_base_itf t
   WHERE t.supplier_code = :supplier_code;

  --判断接口表是否已经存在scm传过来的数据
  IF v_itf_flag > 0 THEN

    SELECT *
      INTO itf_rec
      FROM t_supplier_base_itf t
     WHERE t.supplier_code = :supplier_code
       AND t.update_time =
           (SELECT MAX(itf.update_time)
              FROM t_supplier_base_itf itf
             WHERE itf.supplier_code = t.supplier_code);

    IF to_date(:update_time, ''yyyy-mm-dd hh24:mi:ss'') > itf_rec.create_time AND
       to_date(:update_time, ''yyyy-mm-dd hh24:mi:ss'') >
       itf_rec.publish_time THEN
      v_status := ''U'';
      v_itf_id := sys_guid();
      -- 1.记录接口表信息
      INSERT INTO t_supplier_base_itf
        (itf_id,
         supplier_code,
         sup_id_base,
         sup_name,
         legalperson,
         linkman,
         phonenumber,
         address,
         --sup_type,
         --sup_type_name,
         --sup_status,
         countyid,
         provinceid,
         cityno,
         tax_id,
         cooperation_model,
         create_id,
         create_time,
         update_id,
         update_time,
         publish_id,
         publish_time,
         data_status,
         fetch_flag,
         pause,
         supp_date,
         memo,
         company_type)
      VALUES
        (v_itf_id,
         :supplier_code,
         itf_rec.sup_id_base, --两种情况：存在/不存在回传编号
         :supplier_company_name,
         :legal_representative,
         :company_contact_person,
         :company_contact_phone,
         :company_address,
         --'''',
         --'''',
         --'''',
         :company_county,
         :company_province,
         :company_city,
         :social_credit_code,
         :cooperation_model_sp,
         :create_id,
         to_date(:insert_time, ''yyyy-mm-dd hh24:mi:ss''),
         :update_id,
         to_date(:update_time, ''yyyy-mm-dd hh24:mi:ss''),
         ''SCM'',
         SYSDATE,
         v_status,
         0,
         :pause,
         to_date(:supp_date, ''yyyy-mm-dd hh24:mi:ss''),
         :remarks,
         :company_type);
      --2.记录接口表信息到监控表

      v_ctl_id := sys_guid();

      INSERT INTO t_supplier_info_ctl
        (ctl_id,
         itf_id,
         itf_type,
         batch_id,
         batch_num,
         batch_time,
         sender,
         receiver,
         send_time,
         receive_time,
         return_type,
         return_msg)
      VALUES
        (v_ctl_id,
         v_itf_id,
         ''供应商接口导入'',
         '''',
         '''',
         '''',
         ''SCM'',
         ''181'',
         to_date(:send_time, ''yyyy-mm-dd hh24:mi:ss''),
         SYSDATE,
         ''Y'', --根据校验数据确定,待确定
         ''数据校验成功'' --根据校验数据确定,待确定
         );
    END IF;
  ELSE
    v_status := ''I'';
    v_itf_id := sys_guid();
    -- 1.记录接口表信息
    INSERT INTO t_supplier_base_itf
      (itf_id,
       supplier_code,
       sup_id_base,
       sup_name,
       legalperson,
       linkman,
       phonenumber,
       address,
       --sup_type,
       --sup_type_name,
       --sup_status,
       countyid,
       provinceid,
       cityno,
       tax_id,
       cooperation_model,
       create_id,
       create_time,
       update_id,
       update_time,
       publish_id,
       publish_time,
       data_status,
       fetch_flag,
       pause,
       supp_date,
       memo,
       company_type)
    VALUES
      (v_itf_id,
       :supplier_code,
       itf_rec.sup_id_base, --两种情况：存在/不存在回传编号
       :supplier_company_name,
       :legal_representative,
       :company_contact_person,
       :company_contact_phone,
       :company_address,
       --'''',
       --'''',
       --'''',
       :company_county,
       :company_province,
       :company_city,
       :social_credit_code,
       :cooperation_model_sp,
       :create_id,
       to_date(:insert_time, ''yyyy-mm-dd hh24:mi:ss''),
       :update_id,
       to_date(:update_time, ''yyyy-mm-dd hh24:mi:ss''),
       ''SCM'',
       SYSDATE,
       v_status,
       0,
       :pause,
       to_date(:supp_date, ''yyyy-mm-dd hh24:mi:ss''),
       :remarks,
       :company_type);
    --2.记录接口表信息到监控表

    v_ctl_id := sys_guid();

    INSERT INTO t_supplier_info_ctl
      (ctl_id,
       itf_id,
       itf_type,
       batch_id,
       batch_num,
       batch_time,
       sender,
       receiver,
       send_time,
       receive_time,
       return_type,
       return_msg)
    VALUES
      (v_ctl_id,
       v_itf_id,
       ''供应商接口导入'',
       '''',
       '''',
       '''',
       ''SCM'',
       ''181'',
       to_date(:send_time, ''yyyy-mm-dd hh24:mi:ss''),
       SYSDATE,
       ''Y'', --根据校验数据确定,待确定
       ''数据校验成功'' --根据校验数据确定,待确定
       );
  END IF;

END;';
  UPDATE bw3.sys_action t
     SET t.action_sql = v_sql, t.port_sql = v_port_sql
   WHERE t.element_id = 'action_itf_a_supp_140';
END;
