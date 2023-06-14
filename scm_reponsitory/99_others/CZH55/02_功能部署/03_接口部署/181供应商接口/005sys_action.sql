prompt Importing table bwptest1.sys_action...
set feedback off
set define off
insert into bwptest1.sys_action (ELEMENT_ID, CAPTION, ICON_NAME, ACTION_TYPE, ACTION_SQL, SELECT_FIELDS, REFRESH_FLAG, MULTI_PAGE_FLAG, PRE_FLAG, FILTER_EXPRESS, UPDATE_FIELDS, PORT_ID, PORT_SQL, LOCK_SQL, SELECTION_FLAG, CALL_ID, OPERATE_MODE, PORT_TYPE, QUERY_FIELDS, SELECTION_METHOD)
values ('action_itf_a_supp_141', '供应商档案-合作范围接口导入', null, 8, 'SELECT '''' supplier_code,
       '''' supplier_company_name,
       '''' coop_scope_id,
       '''' coop_classification_num,
       '''' cooperation_classification_sp,
       '''' coop_product_cate_num,
       '''' cooperation_product_cate_sp,
       '''' pause,
       '''' coop_status,
       '''' create_id,
       '''' create_time,
       '''' update_id,
       '''' update_time,
       --181 =》 scm
       ''181'' publish_id,
       to_char(sysdate,''yyyy-mm-dd hh24:mi:ss'') publish_time,
       ''Y'' publish_flag
  FROM dual    ', null, 1, 1, null, null, null, 'method_itf_a_supp_141', 'DECLARE
  v_itf_id   VARCHAR2(100);
  v_ctl_id   VARCHAR2(100);
  v_itf_flag NUMBER;
  itf_rec    t_supplier_coop_itf%ROWTYPE;
  v_status   VARCHAR2(100);

BEGIN

  SELECT COUNT(1)
    INTO v_itf_flag
    FROM t_supplier_coop_itf t
   WHERE t.supplier_code = :supplier_code
     AND t.coop_scope_id = :coop_scope_id;

  --判断接口表是否已经存在scm传过来的数据
  IF v_itf_flag > 0 THEN
    --接口中最新一条数据
    SELECT *
      INTO itf_rec
      FROM t_supplier_coop_itf t
     WHERE t.supplier_code = :supplier_code
       AND t.coop_scope_id = :coop_scope_id
       AND t.update_time =
           (SELECT MAX(itf.update_time)
              FROM t_supplier_coop_itf itf
             WHERE itf.supplier_code = t.supplier_code
               AND itf.coop_scope_id = t.coop_scope_id);
    --scm更新数据的更新时间与接口表最新一条数据作比较
    IF to_date(:update_time, ''yyyy-mm-dd hh24:mi:ss'') > itf_rec.create_time AND
       to_date(:update_time, ''yyyy-mm-dd hh24:mi:ss'') >
       itf_rec.publish_time THEN
      v_status := ''U'';
      v_itf_id := sys_guid();
      -- 1.记录接口表信息
      INSERT INTO t_supplier_coop_itf
        (itf_id,
         supplier_code,
         sup_name,
         coop_classification_num,
         cooperation_classification_sp,
         coop_product_cate_num,
         cooperation_product_cate_sp,
         data_status,
         create_id,
         create_time,
         update_id,
         update_time,
         publish_id,
         publish_time,
         fetch_flag,
         fetch_time,
         coop_scope_id,
         pause)
      VALUES
        (v_itf_id,
         :supplier_code,
         :supplier_company_name,
         :coop_classification_num,
         :cooperation_classification_sp,
         :coop_product_cate_num,
         :cooperation_product_cate_sp,
         v_status,
         :create_id,
         to_date(:create_time, ''yyyy-mm-dd hh24:mi:ss''),
         :update_id,
         to_date(:update_time, ''yyyy-mm-dd hh24:mi:ss''),
         ''SCM'',
         SYSDATE,
         1,
         SYSDATE,
         :coop_scope_id,
         :pause);
      --2.记录接口表信息到监控表
    
      v_ctl_id := sys_guid();
    
      INSERT INTO t_supplier_coop_ctl
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
         ''供应商档案-合作范围接口导入'',
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
    INSERT INTO t_supplier_coop_itf
      (itf_id,
       supplier_code,
       sup_name,
       coop_classification_num,
       cooperation_classification_sp,
       coop_product_cate_num,
       cooperation_product_cate_sp,
       data_status,
       create_id,
       create_time,
       update_id,
       update_time,
       publish_id,
       publish_time,
       fetch_flag,
       fetch_time,
       coop_scope_id,
       pause)
    VALUES
      (v_itf_id,
       :supplier_code,
       :supplier_company_name, --两种情况：存在/不存在回传编号
       :coop_classification_num,
       :cooperation_classification_sp,
       :coop_product_cate_num,
       :cooperation_product_cate_sp,
       v_status,
       :create_id,
       to_date(:create_time, ''yyyy-mm-dd hh24:mi:ss''),
       :update_id,
       to_date(:update_time, ''yyyy-mm-dd hh24:mi:ss''),
       ''SCM'',
       SYSDATE,
       1,
       SYSDATE,
       :coop_scope_id,
       :pause);
    --2.记录接口表信息到监控表
  
    v_ctl_id := sys_guid();
  
    INSERT INTO t_supplier_coop_ctl
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
       ''供应商档案-合作范围接口导入'',
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

END;                                                                                                                                                                                                                                                                                                                                                                        ', null, 0, null, null, 1, null, null);

insert into bwptest1.sys_action (ELEMENT_ID, CAPTION, ICON_NAME, ACTION_TYPE, ACTION_SQL, SELECT_FIELDS, REFRESH_FLAG, MULTI_PAGE_FLAG, PRE_FLAG, FILTER_EXPRESS, UPDATE_FIELDS, PORT_ID, PORT_SQL, LOCK_SQL, SELECTION_FLAG, CALL_ID, OPERATE_MODE, PORT_TYPE, QUERY_FIELDS, SELECTION_METHOD)
values ('action_itf_a_supp_140', '供应商主档接口导入', null, 8, '--SCM =》181
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
  FROM DUAL                 ', null, 1, 1, null, null, null, 'method_itf_a_supp_140', 'DECLARE
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
         memo)
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
         :remarks);
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
       memo)
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
       :remarks);
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

END;                                                                                                                                                                                                                                                                                                                                                                                                                                                                     ', null, 0, null, null, 1, null, null);

prompt Done.
