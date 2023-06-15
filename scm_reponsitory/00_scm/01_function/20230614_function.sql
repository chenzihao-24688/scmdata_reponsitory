prompt PL/SQL Developer Export User Objects for user SCMDATA@DEV_SCM
prompt Created by SANFU on 2023年6月14日
set define off
spool 20230614_function.log

prompt
prompt Creating function CZH_TEST
prompt ==========================
prompt
@@czh_test.fnc
prompt
prompt Creating function F1
prompt ====================
prompt
@@f1.fnc
prompt
prompt Creating function F_CHECK_HX_TEST
prompt =================================
prompt
@@f_check_hx_test.fnc
prompt
prompt Creating function F_CHECK_SOIALNUM
prompt ==================================
prompt
@@f_check_soialnum.fnc
prompt
prompt Creating function F_FORM_URL_ENCODE
prompt ===================================
prompt
@@f_form_url_encode.fnc
prompt
prompt Creating function F_GETKEYID_PLAT
prompt =================================
prompt
@@f_getkeyid_plat.fnc
prompt
prompt Creating function F_GET_COLS
prompt ============================
prompt
@@f_get_cols.fnc
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
prompt Creating function F_LONG_TO_CHAR_WITHOUT_ROWID
prompt ==============================================
prompt
@@f_long_to_char_without_rowid.fnc
prompt
prompt Creating function F_NEXTSTARTTIME
prompt =================================
prompt
@@f_nextstarttime.fnc
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
prompt Creating function RETURN
prompt ========================
prompt
@@return.fnc
prompt
prompt Creating function UDF_WEEKOFYEAR
prompt ================================
prompt
@@udf_weekofyear.fnc

prompt Done
spool off
set define on
