begin

insert into bw3.sys_item (ITEM_ID, ITEM_TYPE, CAPTION_SQL, DATA_SOURCE, BASE_TABLE, KEY_FIELD, NAME_FIELD, SETTING_ID, REPORT_TITLE, SUB_SCRIPTS, PAUSE, LINK_FIELD, HELP_ID, TAG_ID, CONFIG_PARAMS, TIME_OUT, OFFLINE_FLAG, PANEL_ID, INIT_SHOW, BADGE_SQL, BADGE_FLAG, SHOW_ROWID, ENABLE_STAND_PERMISSION)
values ('itf_a_supp_140', 'list', '供应商档案数据源', 'oracle_mdmdata', 't_supplier_base_itf', 'itf_id', null, null, null, null, 0, null, null, null, null, null, null, null, null, null, null, null, null);


insert into bw3.sys_item_list (ITEM_ID, QUERY_TYPE, QUERY_FIELDS, QUERY_COUNT, EDIT_EXPRESS, NEWID_SQL, SELECT_SQL, DETAIL_SQL, SUBSELECT_SQL, INSERT_SQL, UPDATE_SQL, DELETE_SQL, NOSHOW_FIELDS, NOADD_FIELDS, NOMODIFY_FIELDS, NOEDIT_FIELDS, SUBNOSHOW_FIELDS, UI_TMPL, MULTI_PAGE_FLAG, OUTPUT_PARAMETER, LOCK_SQL, MONITOR_ID, END_FIELD, EXECUTE_TIME, SCANNABLE_FIELD, SCANNABLE_TYPE, AUTO_REFRESH, RFID_FLAG, SCANNABLE_TIME, MAX_ROW_COUNT, NOSHOW_APP_FIELDS, SCANNABLE_LOCATION_LINE, SUB_TABLE_JUDGE_FIELD, BACK_GROUND_ID, OPRETION_HINT, SUB_EDIT_STATE, HINT_TYPE, HEADER, FOOTER, JUMP_FIELD, JUMP_EXPRESS, OPEN_MODE, OPERATION_TYPE, OPERATE_TYPE, PAGE_SIZES)
values ('itf_a_supp_140', 13, 'sup_id_base,supplier_code,sup_name', null, null, null, '{DECLARE
  v_sender      VARCHAR2(100) := :send_flag;
  v_fetch_flag  NUMBER := :fet_flag;
  v_flag        NUMBER;--是否存在数据
  v_sup_id_base NUMBER;--是否存在回传编号
  v_sql         VARCHAR2(4000);
BEGIN
  -- raise_application_error(-20002,''send_flag=''||:send_flag);

  IF v_sender IS NULL THEN
    v_sql := q''[SELECT t.itf_id,
       decode(t.data_status,''I'',''新增'',''U'',''更新'','''') data_status,
       decode(t.pause,0,''正常'',''1'',''停用'','''') pause_desc,
       decode(t.fetch_flag,0,''否'',1,''是'','''') fetch_flag, 
       t.sup_id_base,
       t.supplier_code,
       t.sup_name,
       t.tax_id,
       t.legalperson,
       t.linkman,
       t.phonenumber,
       t.address,
       t.cooperation_model,
       --t.sup_type,      
       --t.sup_type_name,
       --t.sup_status,
       t.provinceid,       
       t.cityno,
       t.countyid,
       t.supp_date,
       t.memo,
       t.create_id,
       t.create_time create_date_itf,
       t.update_id,
       t.update_time,
       t.publish_id,
       t.publish_time
  FROM mdmdata.t_supplier_base_itf t
   ORDER BY t.publish_time desc,t.update_time desc,t.supplier_code asc]'';
  END IF;
  IF v_sender = ''scm'' THEN
    IF v_fetch_flag = 1 THEN
      SELECT count(*),COUNT(t.sup_id_base)
        INTO v_flag,v_sup_id_base
        FROM mdmdata.t_supplier_base_itf t;
      IF v_flag = 0 THEN
        raise_application_error(-20002, ''MDM无数据'');
      ELSIF v_sup_id_base = 0 THEN
        raise_application_error(-20002, ''MDM暂无回传供应商编号'');
      ELSE
        UPDATE mdmdata.t_supplier_base_itf t
           SET t.fetch_flag = v_fetch_flag
         WHERE t.sup_id_base IS NOT NULL
           AND t.fetch_flag = 0;
      END IF;
    
    END IF;
    v_sql := q''[SELECT t.itf_id,
       t.data_status,
       t.fetch_flag,
       t.supplier_code,
       t.sup_id_base,
       t.sup_name,
       t.tax_id,
       t.legalperson,
       t.linkman,
       t.phonenumber,
       t.address,
       t.cooperation_model,
       --t.sup_type,      
       --t.sup_type_name,
       --t.sup_status,
       t.provinceid,       
       t.cityno,
       t.countyid,
       t.supp_date,
       t.memo,
       t.create_id,
       t.create_time create_date_itf,
       t.update_id,
       t.update_time,
       ''181'' publish_id,
       sysdate publish_time,
       sysdate send_time
  FROM mdmdata.t_supplier_base_itf t where t.sup_id_base is not null and t.fetch_flag = 1
  ORDER BY t.publish_time desc,t.update_time desc,t.supplier_code asc]'';
  END IF;
  @strresult := v_sql;
END;
}', null, null, null, null, null, 'itf_id', null, null, null, null, null, 1, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, 0, null);

end;
/