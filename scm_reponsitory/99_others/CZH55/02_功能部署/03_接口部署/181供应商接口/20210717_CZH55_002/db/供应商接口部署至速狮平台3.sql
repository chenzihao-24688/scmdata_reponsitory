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
