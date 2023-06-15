prompt PL/SQL Developer Export User Objects for user SCMDATA@ORCL_SCMTEST
prompt Created by SANFU on 2023年6月15日
set define off
spool 20230614_table.log

prompt
prompt Creating function F_ENCODE_BASE64
prompt =================================
prompt
@@f_encode_base64.fnc
prompt
prompt Creating function F_GETKEYID_PLAT
prompt =================================
prompt
@@f_getkeyid_plat.fnc
prompt
prompt Creating function INSTR_PRIV
prompt ============================
prompt
@@instr_priv.fnc
prompt
prompt Creating function F_GET_GROUPNAME
prompt =================================
prompt
@@f_get_groupname.fnc
prompt
prompt Creating function F_GET_UUID
prompt ============================
prompt
@@f_get_uuid.fnc
prompt
prompt Creating function F_GET_UUID_PE
prompt ===============================
prompt
@@f_get_uuid_pe.fnc
prompt
prompt Creating function F_SENTENCE_APPEND_RC
prompt ======================================
prompt
@@f_sentence_append_rc.fnc
prompt
prompt Creating function F_USER_LIST_FROM_IN_TO_WECOM
prompt ==============================================
prompt
@@f_user_list_from_in_to_wecom.fnc
prompt
prompt Creating function PARSE_JSON
prompt ============================
prompt
@@parse_json.fnc
prompt
prompt Creating function TEST1
prompt =======================
prompt
@@test1.fnc

prompt Done
spool off
set define on
