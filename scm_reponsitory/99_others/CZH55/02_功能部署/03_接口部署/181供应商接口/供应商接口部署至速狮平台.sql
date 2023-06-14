declare
v_sql_01 clob;
v_sql_02 clob;
v_sql_03 clob;
v_sql_04 clob;
v_sql_05 clob;
v_sql_06 clob;
begin
insert into bw3.sys_element (ELEMENT_ID, ELEMENT_TYPE, DATA_SOURCE, PAUSE, MESSAGE, IS_HIDE, IS_ASYNC, IS_PER_EXE, ENABLE_STAND_PERMISSION)
values ('action_itf_a_supp_140', 'action', 'oracle_mdmdata', 0, null, null, null, null, null);

insert into bw3.sys_element (ELEMENT_ID, ELEMENT_TYPE, DATA_SOURCE, PAUSE, MESSAGE, IS_HIDE, IS_ASYNC, IS_PER_EXE, ENABLE_STAND_PERMISSION)
values ('action_itf_a_supp_141', 'action', 'oracle_mdmdata', 0, null, null, null, null, null);

v_sql_01 := 'SELECT '''' supplier_code,
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
  FROM dual ';
  
v_sql_02  := 'DECLARE
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

END;';
  
insert into bw3.sys_action (ELEMENT_ID, CAPTION, ICON_NAME, ACTION_TYPE, ACTION_SQL, SELECT_FIELDS, REFRESH_FLAG, MULTI_PAGE_FLAG, PRE_FLAG, FILTER_EXPRESS, UPDATE_FIELDS, PORT_ID, PORT_SQL, LOCK_SQL, SELECTION_FLAG, CALL_ID, OPERATE_MODE, PORT_TYPE, QUERY_FIELDS, SELECTION_METHOD)
values ('action_itf_a_supp_141', '供应商档案-合作范围接口导入', null, 8,v_sql_01 , null, 1, 1, null, null, null, 'method_itf_a_supp_141',v_sql_02 , null, 0, null, null, 1, null, null);

v_sql_03 := '--SCM =》181
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

v_sql_04 := 'DECLARE
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

END; ';

insert into bw3.sys_action (ELEMENT_ID, CAPTION, ICON_NAME, ACTION_TYPE, ACTION_SQL, SELECT_FIELDS, REFRESH_FLAG, MULTI_PAGE_FLAG, PRE_FLAG, FILTER_EXPRESS, UPDATE_FIELDS, PORT_ID, PORT_SQL, LOCK_SQL, SELECTION_FLAG, CALL_ID, OPERATE_MODE, PORT_TYPE, QUERY_FIELDS, SELECTION_METHOD)
values ('action_itf_a_supp_140', '供应商主档接口导入', null, 8, v_sql_03 , null, 1, 1, null, null, null, 'method_itf_a_supp_140', v_sql_04 , null, 0, null, null, 1, null, null);

end;
/
begin
insert into bw3.sys_open_info (OPEN_ID, APP_KEY, APP_SECRET, GLOBAL_SQL)
values ('open_scm_supp_code', 'scm_supp_code_key', 'scm_supp_code_secret', null);

insert into bw3.sys_open_interface (OPEN_ID, MODULE_NAME, OPER_TYPE, ITEM_ID, REQ_SQL, TB_ID)
values ('open_scm_supp_code', 'mdm_supp_select', 3, 'itf_a_supp_140', null, 12);

insert into bw3.sys_method (METHOD_ID, PORT_TYPE, DETAIL)
values ('method_itf_a_supp_140', 'http', '供应商接口导入');

insert into bw3.sys_method (METHOD_ID, PORT_TYPE, DETAIL)
values ('method_itf_a_supp_141', 'http', '供应商档案-合作范围接口导入');

insert into bw3.sys_port_http (PORT_NAME, URL, ACTION_TAG, APP_KEY, APP_SECRET, TOKEN_SQL, PORT_TYPE)
values ('port_itf_a_supp_140', 'http://172.28.6.85:9090/lion/scm/api/v1 ', 0, 'a_supp_140_key', 'a_supp_140_secret', null, 43);

insert into bw3.sys_port_http (PORT_NAME, URL, ACTION_TAG, APP_KEY, APP_SECRET, TOKEN_SQL, PORT_TYPE)
values ('port_itf_a_supp_141', 'http://172.28.6.85:9090/lion/scm/api/v1 ', 0, 'a_supp_scope_key', 'a_supp_scope_secret', null, 43);

insert into bw3.sys_port_method (METHOD_ID, PORT_NAME, METHOD_NAME, REQ_PARAM, RESP_PARAM, FIXED_PARAM, ERR_PARAM, METHOD_TYPE, PARAM_FORMAT, SUCCESS_PARAM)
values ('method_itf_a_supp_141', 'port_itf_a_supp_141', 'get_supp_scope_data', null, null, '{"servicePath":"/open/view/a_supp_scope"}', null, 'post', 'json', null);

insert into bw3.sys_port_method (METHOD_ID, PORT_NAME, METHOD_NAME, REQ_PARAM, RESP_PARAM, FIXED_PARAM, ERR_PARAM, METHOD_TYPE, PARAM_FORMAT, SUCCESS_PARAM)
values ('method_itf_a_supp_140', 'port_itf_a_supp_140', 'get_supp_data', null, null, '{"servicePath":"/open/view/supp_140"}', null, 'post', 'json', null);

insert into bw3.sys_port_map (PORT_NAME, FIELD_NAME, PATH_NAME, AS_ARRAY, DEFAULT_VALUE, SEQNO, METHOD_ID, IS_REQUIRE, TYPE)
values ('port_itf_a_supp_140', 'publish_time', 'publish_time', 0, null, 7, 'method_itf_a_supp_140', 0, 'req_path');

insert into bw3.sys_port_map (PORT_NAME, FIELD_NAME, PATH_NAME, AS_ARRAY, DEFAULT_VALUE, SEQNO, METHOD_ID, IS_REQUIRE, TYPE)
values ('port_itf_a_supp_140', 'publish_id', 'publish_id', 0, null, 7, 'method_itf_a_supp_140', 0, 'req_path');

insert into bw3.sys_port_map (PORT_NAME, FIELD_NAME, PATH_NAME, AS_ARRAY, DEFAULT_VALUE, SEQNO, METHOD_ID, IS_REQUIRE, TYPE)
values ('port_itf_a_supp_140', 'publish_flag', 'publish_flag', 0, null, 6, 'method_itf_a_supp_140', 0, 'req_path');

insert into bw3.sys_port_map (PORT_NAME, FIELD_NAME, PATH_NAME, AS_ARRAY, DEFAULT_VALUE, SEQNO, METHOD_ID, IS_REQUIRE, TYPE)
values ('port_itf_a_supp_140', 'type', 'type', 0, null, 5, 'method_itf_a_supp_140', 0, 'resp');

insert into bw3.sys_port_map (PORT_NAME, FIELD_NAME, PATH_NAME, AS_ARRAY, DEFAULT_VALUE, SEQNO, METHOD_ID, IS_REQUIRE, TYPE)
values ('port_itf_a_supp_140', 'msg', 'msg', 0, null, 2, 'method_itf_a_supp_140', 0, 'resp');

insert into bw3.sys_port_map (PORT_NAME, FIELD_NAME, PATH_NAME, AS_ARRAY, DEFAULT_VALUE, SEQNO, METHOD_ID, IS_REQUIRE, TYPE)
values ('port_itf_a_supp_140', 'errCode', 'errCode', 0, null, 4, 'method_itf_a_supp_140', 0, 'resp');

insert into bw3.sys_port_map (PORT_NAME, FIELD_NAME, PATH_NAME, AS_ARRAY, DEFAULT_VALUE, SEQNO, METHOD_ID, IS_REQUIRE, TYPE)
values ('port_itf_a_supp_140', 'data', 'data', 0, null, 3, 'method_itf_a_supp_140', 0, 'resp');

insert into bw3.sys_port_map (PORT_NAME, FIELD_NAME, PATH_NAME, AS_ARRAY, DEFAULT_VALUE, SEQNO, METHOD_ID, IS_REQUIRE, TYPE)
values ('port_itf_a_supp_140', 'code', 'code', 0, null, 1, 'method_itf_a_supp_140', 0, 'resp');

insert into bw3.sys_port_map (PORT_NAME, FIELD_NAME, PATH_NAME, AS_ARRAY, DEFAULT_VALUE, SEQNO, METHOD_ID, IS_REQUIRE, TYPE)
values ('port_itf_a_supp_141', 'type', 'type', 0, null, 5, 'method_itf_a_supp_141', 0, 'resp');

insert into bw3.sys_port_map (PORT_NAME, FIELD_NAME, PATH_NAME, AS_ARRAY, DEFAULT_VALUE, SEQNO, METHOD_ID, IS_REQUIRE, TYPE)
values ('port_itf_a_supp_141', 'publish_time', 'publish_time', 0, null, 6, 'method_itf_a_supp_141', 0, 'req_path');

insert into bw3.sys_port_map (PORT_NAME, FIELD_NAME, PATH_NAME, AS_ARRAY, DEFAULT_VALUE, SEQNO, METHOD_ID, IS_REQUIRE, TYPE)
values ('port_itf_a_supp_141', 'publish_id', 'publish_id', 0, null, 7, 'method_itf_a_supp_141', 0, 'req_path');

insert into bw3.sys_port_map (PORT_NAME, FIELD_NAME, PATH_NAME, AS_ARRAY, DEFAULT_VALUE, SEQNO, METHOD_ID, IS_REQUIRE, TYPE)
values ('port_itf_a_supp_141', 'publish_flag', 'publish_flag', 0, null, 6, 'method_itf_a_supp_141', 0, 'req_path');

insert into bw3.sys_port_map (PORT_NAME, FIELD_NAME, PATH_NAME, AS_ARRAY, DEFAULT_VALUE, SEQNO, METHOD_ID, IS_REQUIRE, TYPE)
values ('port_itf_a_supp_141', 'msg', 'msg', 0, null, 2, 'method_itf_a_supp_141', 0, 'resp');

insert into bw3.sys_port_map (PORT_NAME, FIELD_NAME, PATH_NAME, AS_ARRAY, DEFAULT_VALUE, SEQNO, METHOD_ID, IS_REQUIRE, TYPE)
values ('port_itf_a_supp_141', 'errCode', 'errCode', 0, null, 4, 'method_itf_a_supp_141', 0, 'resp');

insert into bw3.sys_port_map (PORT_NAME, FIELD_NAME, PATH_NAME, AS_ARRAY, DEFAULT_VALUE, SEQNO, METHOD_ID, IS_REQUIRE, TYPE)
values ('port_itf_a_supp_141', 'data', 'data', 0, null, 3, 'method_itf_a_supp_141', 0, 'resp');

insert into bw3.sys_port_map (PORT_NAME, FIELD_NAME, PATH_NAME, AS_ARRAY, DEFAULT_VALUE, SEQNO, METHOD_ID, IS_REQUIRE, TYPE)
values ('port_itf_a_supp_141', 'code', 'code', 0, null, 1, 'method_itf_a_supp_141', 0, 'resp');

insert into bw3.sys_port_map (PORT_NAME, FIELD_NAME, PATH_NAME, AS_ARRAY, DEFAULT_VALUE, SEQNO, METHOD_ID, IS_REQUIRE, TYPE)
values ('port_itf_a_supp_140', 'company_id', 'company_id', 0, null, 8, 'method_itf_a_supp_140', 0, 'req_path');

insert into bw3.sys_port_submap (FIELD_NAME, CONVERT_NAME, DEFAULT_VALUE, PARENT_FIELD_NAME, SEQNO, IS_REQUIRE)
values ('COMPANY_CONTACT_PHONE', 'COMPANY_CONTACT_PHONE', null, 'data', 100, 0);

insert into bw3.sys_port_submap (FIELD_NAME, CONVERT_NAME, DEFAULT_VALUE, PARENT_FIELD_NAME, SEQNO, IS_REQUIRE)
values ('COMPANY_ADDRESS', 'COMPANY_ADDRESS', null, 'data', 100, 0);

insert into bw3.sys_port_submap (FIELD_NAME, CONVERT_NAME, DEFAULT_VALUE, PARENT_FIELD_NAME, SEQNO, IS_REQUIRE)
values ('LEGAL_REPRESENTATIVE', 'LEGAL_REPRESENTATIVE', null, 'data', 100, 0);

insert into bw3.sys_port_submap (FIELD_NAME, CONVERT_NAME, DEFAULT_VALUE, PARENT_FIELD_NAME, SEQNO, IS_REQUIRE)
values ('COMPANY_CONTACT_PERSON', 'COMPANY_CONTACT_PERSON', null, 'data', 100, 0);

insert into bw3.sys_port_submap (FIELD_NAME, CONVERT_NAME, DEFAULT_VALUE, PARENT_FIELD_NAME, SEQNO, IS_REQUIRE)
values ('COMPANY_TYPE', 'COMPANY_TYPE', null, 'data', 100, 0);

insert into bw3.sys_port_submap (FIELD_NAME, CONVERT_NAME, DEFAULT_VALUE, PARENT_FIELD_NAME, SEQNO, IS_REQUIRE)
values ('COMPANY_COUNTY', 'COMPANY_COUNTY', null, 'data', 100, 0);

insert into bw3.sys_port_submap (FIELD_NAME, CONVERT_NAME, DEFAULT_VALUE, PARENT_FIELD_NAME, SEQNO, IS_REQUIRE)
values ('SOCIAL_CREDIT_CODE', 'SOCIAL_CREDIT_CODE', null, 'data', 100, 0);

insert into bw3.sys_port_submap (FIELD_NAME, CONVERT_NAME, DEFAULT_VALUE, PARENT_FIELD_NAME, SEQNO, IS_REQUIRE)
values ('COMPANY_PROVINCE', 'COMPANY_PROVINCE', null, 'data', 100, 0);

insert into bw3.sys_port_submap (FIELD_NAME, CONVERT_NAME, DEFAULT_VALUE, PARENT_FIELD_NAME, SEQNO, IS_REQUIRE)
values ('COMPANY_CITY', 'COMPANY_CITY', null, 'data', 100, 0);

insert into bw3.sys_port_submap (FIELD_NAME, CONVERT_NAME, DEFAULT_VALUE, PARENT_FIELD_NAME, SEQNO, IS_REQUIRE)
values ('INSIDE_SUPPLIER_CODE', 'INSIDE_SUPPLIER_CODE', null, 'data', 100, 0);

insert into bw3.sys_port_submap (FIELD_NAME, CONVERT_NAME, DEFAULT_VALUE, PARENT_FIELD_NAME, SEQNO, IS_REQUIRE)
values ('SUPPLIER_CODE', 'SUPPLIER_CODE', null, 'data', 100, 0);

insert into bw3.sys_port_submap (FIELD_NAME, CONVERT_NAME, DEFAULT_VALUE, PARENT_FIELD_NAME, SEQNO, IS_REQUIRE)
values ('SUPPLIER_COMPANY_NAME', 'SUPPLIER_COMPANY_NAME', null, 'data', 100, 0);

insert into bw3.sys_port_submap (FIELD_NAME, CONVERT_NAME, DEFAULT_VALUE, PARENT_FIELD_NAME, SEQNO, IS_REQUIRE)
values ('PUBLISH_ID', 'PUBLISH_ID', null, 'data', 100, 0);

insert into bw3.sys_port_submap (FIELD_NAME, CONVERT_NAME, DEFAULT_VALUE, PARENT_FIELD_NAME, SEQNO, IS_REQUIRE)
values ('SEND_TIME', 'SEND_TIME', null, 'data', 100, 0);

insert into bw3.sys_port_submap (FIELD_NAME, CONVERT_NAME, DEFAULT_VALUE, PARENT_FIELD_NAME, SEQNO, IS_REQUIRE)
values ('PUBLISH_TIME', 'PUBLISH_TIME', null, 'data', 100, 0);

insert into bw3.sys_port_submap (FIELD_NAME, CONVERT_NAME, DEFAULT_VALUE, PARENT_FIELD_NAME, SEQNO, IS_REQUIRE)
values ('UPDATE_TIME', 'UPDATE_TIME', null, 'data', 100, 0);

insert into bw3.sys_port_submap (FIELD_NAME, CONVERT_NAME, DEFAULT_VALUE, PARENT_FIELD_NAME, SEQNO, IS_REQUIRE)
values ('UPDATE_ID', 'UPDATE_ID', null, 'data', 100, 0);

insert into bw3.sys_port_submap (FIELD_NAME, CONVERT_NAME, DEFAULT_VALUE, PARENT_FIELD_NAME, SEQNO, IS_REQUIRE)
values ('INSERT_TIME', 'INSERT_TIME', null, 'data', 100, 0);

insert into bw3.sys_port_submap (FIELD_NAME, CONVERT_NAME, DEFAULT_VALUE, PARENT_FIELD_NAME, SEQNO, IS_REQUIRE)
values ('CREATE_ID', 'CREATE_ID', null, 'data', 100, 0);

insert into bw3.sys_port_submap (FIELD_NAME, CONVERT_NAME, DEFAULT_VALUE, PARENT_FIELD_NAME, SEQNO, IS_REQUIRE)
values ('SEND_ID', 'SEND_ID', null, 'data', 100, 0);

insert into bw3.sys_port_submap (FIELD_NAME, CONVERT_NAME, DEFAULT_VALUE, PARENT_FIELD_NAME, SEQNO, IS_REQUIRE)
values ('PUBLISH_FLAG', 'PUBLISH_FLAG', null, 'data', 100, 0);

insert into bw3.sys_port_submap (FIELD_NAME, CONVERT_NAME, DEFAULT_VALUE, PARENT_FIELD_NAME, SEQNO, IS_REQUIRE)
values ('COOPERATION_MODEL_SP', 'COOPERATION_MODEL_SP', null, 'data', 100, 0);

insert into bw3.sys_port_submap (FIELD_NAME, CONVERT_NAME, DEFAULT_VALUE, PARENT_FIELD_NAME, SEQNO, IS_REQUIRE)
values ('REMARKS', 'REMARKS', null, 'data', 100, 0);

insert into bw3.sys_port_submap (FIELD_NAME, CONVERT_NAME, DEFAULT_VALUE, PARENT_FIELD_NAME, SEQNO, IS_REQUIRE)
values ('SUPP_DATE', 'SUPP_DATE', null, 'data', 100, 0);

insert into bw3.sys_port_submap (FIELD_NAME, CONVERT_NAME, DEFAULT_VALUE, PARENT_FIELD_NAME, SEQNO, IS_REQUIRE)
values ('COOPERATION_PRODUCT_CATE_SP', 'COOPERATION_PRODUCT_CATE_SP', null, 'data', 100, 0);

insert into bw3.sys_port_submap (FIELD_NAME, CONVERT_NAME, DEFAULT_VALUE, PARENT_FIELD_NAME, SEQNO, IS_REQUIRE)
values ('COOPERATION_CLASSIFICATION_SP', 'COOPERATION_CLASSIFICATION_SP', null, 'data', 100, 0);

insert into bw3.sys_port_submap (FIELD_NAME, CONVERT_NAME, DEFAULT_VALUE, PARENT_FIELD_NAME, SEQNO, IS_REQUIRE)
values ('COOP_PRODUCT_CATE_NUM', 'COOP_PRODUCT_CATE_NUM', null, 'data', 100, 0);

insert into bw3.sys_port_submap (FIELD_NAME, CONVERT_NAME, DEFAULT_VALUE, PARENT_FIELD_NAME, SEQNO, IS_REQUIRE)
values ('COOPERATION_CLASSIFICATION_SP', 'COOPERATION_CLASSIFICATION_SP', null, 'data', 100, 0);

insert into bw3.sys_port_submap (FIELD_NAME, CONVERT_NAME, DEFAULT_VALUE, PARENT_FIELD_NAME, SEQNO, IS_REQUIRE)
values ('SUP_NAME', 'SUP_NAME', null, 'data', 100, 0);

insert into bw3.sys_port_submap (FIELD_NAME, CONVERT_NAME, DEFAULT_VALUE, PARENT_FIELD_NAME, SEQNO, IS_REQUIRE)
values ('COOP_CLASSIFICATION_NUM', 'COOP_CLASSIFICATION_NUM', null, 'data', 100, 0);

insert into bw3.sys_port_submap (FIELD_NAME, CONVERT_NAME, DEFAULT_VALUE, PARENT_FIELD_NAME, SEQNO, IS_REQUIRE)
values ('COOP_SCOPE_ID', 'COOP_SCOPE_ID', null, 'data', 100, 0);

insert into bw3.sys_port_submap (FIELD_NAME, CONVERT_NAME, DEFAULT_VALUE, PARENT_FIELD_NAME, SEQNO, IS_REQUIRE)
values ('PAUSE', 'PAUSE', null, 'data', 100, 0);

insert into bw3.sys_port_submap (FIELD_NAME, CONVERT_NAME, DEFAULT_VALUE, PARENT_FIELD_NAME, SEQNO, IS_REQUIRE)
values ('COOP_STATUS', 'COOP_STATUS', null, 'data', 100, 0);

insert into bw3.sys_port_submap (FIELD_NAME, CONVERT_NAME, DEFAULT_VALUE, PARENT_FIELD_NAME, SEQNO, IS_REQUIRE)
values ('CREATE_TIME', 'CREATE_TIME', null, 'data', 100, 0);

insert into bw3.sys_port_submap (FIELD_NAME, CONVERT_NAME, DEFAULT_VALUE, PARENT_FIELD_NAME, SEQNO, IS_REQUIRE)
values ('SUPPLIER_INFO_ID', 'SUPPLIER_INFO_ID', null, 'data', 100, 0);

insert into bw3.sys_port_submap (FIELD_NAME, CONVERT_NAME, DEFAULT_VALUE, PARENT_FIELD_NAME, SEQNO, IS_REQUIRE)
values ('SUPPLIER_COMPANY_ID', 'SUPPLIER_COMPANY_ID', null, 'data', 100, 0);

insert into bw3.sys_port_submap (FIELD_NAME, CONVERT_NAME, DEFAULT_VALUE, PARENT_FIELD_NAME, SEQNO, IS_REQUIRE)
values ('COOPERATION_MODEL', 'COOPERATION_MODEL', null, 'data', 100, 0);

insert into bw3.sys_port_submap (FIELD_NAME, CONVERT_NAME, DEFAULT_VALUE, PARENT_FIELD_NAME, SEQNO, IS_REQUIRE)
values ('COMPANY_ID', 'COMPANY_ID', null, 'data', 100, 0);
end;
/
begin
insert into bw3.xxl_job_info (ID, APP_ID, JOB_GROUP, JOB_CRON, JOB_DESC, ADD_TIME, UPDATE_TIME, AUTHOR, ALARM_EMAIL, EXECUTOR_ROUTE_STRATEGY, EXECUTOR_HANDLER, EXECUTOR_PARAM, EXECUTOR_BLOCK_STRATEGY, EXECUTOR_TIMEOUT, EXECUTOR_FAIL_RETRY_COUNT, GLUE_TYPE, GLUE_SOURCE, GLUE_REMARK, GLUE_UPDATETIME, CHILD_JOBID, TRIGGER_STATUS, TRIGGER_LAST_TIME, TRIGGER_NEXT_TIME)
values (520, 'app_sanfu_retail', 1, '0 0/5  * * * ?', '供应商档案接口导入', to_date('26-10-2020', 'dd-mm-yyyy'), to_date('14-07-2021 11:58:56', 'dd-mm-yyyy hh24:mi:ss'), 'HX87', null, 'ROUND', 'actionJobHandler', 'action_itf_a_supp_140', 'SERIAL_EXECUTION', 0, 0, 'BEAN', null, null, to_date('26-10-2020', 'dd-mm-yyyy'), null, 1, 1626508500000, 1626508800000);

insert into bw3.xxl_job_info (ID, APP_ID, JOB_GROUP, JOB_CRON, JOB_DESC, ADD_TIME, UPDATE_TIME, AUTHOR, ALARM_EMAIL, EXECUTOR_ROUTE_STRATEGY, EXECUTOR_HANDLER, EXECUTOR_PARAM, EXECUTOR_BLOCK_STRATEGY, EXECUTOR_TIMEOUT, EXECUTOR_FAIL_RETRY_COUNT, GLUE_TYPE, GLUE_SOURCE, GLUE_REMARK, GLUE_UPDATETIME, CHILD_JOBID, TRIGGER_STATUS, TRIGGER_LAST_TIME, TRIGGER_NEXT_TIME)
values (521, 'app_sanfu_retail', 1, '0 0/5  * * * ?', '供应商档案-合作范围接口导入', to_date('26-10-2020', 'dd-mm-yyyy'), to_date('14-07-2021 11:59:00', 'dd-mm-yyyy hh24:mi:ss'), 'HX87', null, 'ROUND', 'actionJobHandler', 'action_itf_a_supp_141', 'SERIAL_EXECUTION', 0, 0, 'BEAN', null, null, to_date('26-10-2020', 'dd-mm-yyyy'), null, 1, 1626508500000, 1626508800000);  
end;
/
