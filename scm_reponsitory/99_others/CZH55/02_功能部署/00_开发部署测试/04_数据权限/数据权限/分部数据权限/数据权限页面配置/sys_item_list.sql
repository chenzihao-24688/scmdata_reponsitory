declare
begin
 delete from bw3.sys_item_list t where t.item_id = 'c_2055';
 
insert into bw3.sys_item_list (ITEM_ID, QUERY_TYPE, QUERY_FIELDS, QUERY_COUNT, EDIT_EXPRESS, NEWID_SQL, SELECT_SQL, DETAIL_SQL, SUBSELECT_SQL, INSERT_SQL, UPDATE_SQL, DELETE_SQL, NOSHOW_FIELDS, NOADD_FIELDS, NOMODIFY_FIELDS, NOEDIT_FIELDS, SUBNOSHOW_FIELDS, UI_TMPL, MULTI_PAGE_FLAG, OUTPUT_PARAMETER, LOCK_SQL, MONITOR_ID, END_FIELD, EXECUTE_TIME, SCANNABLE_FIELD, SCANNABLE_TYPE, AUTO_REFRESH, RFID_FLAG, SCANNABLE_TIME, MAX_ROW_COUNT, NOSHOW_APP_FIELDS, SCANNABLE_LOCATION_LINE, SUB_TABLE_JUDGE_FIELD, BACK_GROUND_ID, OPRETION_HINT, SUB_EDIT_STATE, HINT_TYPE, HEADER, FOOTER, JUMP_FIELD, JUMP_EXPRESS, OPEN_MODE, OPERATION_TYPE)
values ('c_2055', 12, 'company_user_name,nick_name,phone,inner_user_id', null, null, null, ' 
select  a.company_user_id,a.company_id,a.user_id,a.company_user_name,a.nick_name,
        a.sex,a.phone,a.email,a.inner_user_id,b.company_dept_id,c.dept_name
  from sys_company_user a
 left join sys_company_user_dept b on a.user_id=b.user_id and a.company_id=b.company_id
 left join sys_company_dept c on b.COMPANY_DEPT_ID=c.company_dept_id
 where a.company_id=:company_id and a.pause=0 
   and b.company_dept_id=:company_dept_id 
 ', null, null, null, ' update sys_company_user a
    set a.company_user_name =:company_user_name,
        a.sex =:sex,
        a.email =:email,
        a.inner_user_id =:inner_user_id
  where a.company_id=:company_id and company_user_id=:old_company_user_id', null, 'user_id,company_user_id,company_id,company_dept_id,PARENT_IDS', null, null, null, null, null, 1, null, null, null, null, null, null, null, 1, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into bw3.sys_item_list (ITEM_ID, QUERY_TYPE, QUERY_FIELDS, QUERY_COUNT, EDIT_EXPRESS, NEWID_SQL, SELECT_SQL, DETAIL_SQL, SUBSELECT_SQL, INSERT_SQL, UPDATE_SQL, DELETE_SQL, NOSHOW_FIELDS, NOADD_FIELDS, NOMODIFY_FIELDS, NOEDIT_FIELDS, SUBNOSHOW_FIELDS, UI_TMPL, MULTI_PAGE_FLAG, OUTPUT_PARAMETER, LOCK_SQL, MONITOR_ID, END_FIELD, EXECUTE_TIME, SCANNABLE_FIELD, SCANNABLE_TYPE, AUTO_REFRESH, RFID_FLAG, SCANNABLE_TIME, MAX_ROW_COUNT, NOSHOW_APP_FIELDS, SCANNABLE_LOCATION_LINE, SUB_TABLE_JUDGE_FIELD, BACK_GROUND_ID, OPRETION_HINT, SUB_EDIT_STATE, HINT_TYPE, HEADER, FOOTER, JUMP_FIELD, JUMP_EXPRESS, OPEN_MODE, OPERATION_TYPE)
values ('c_2075', 0, null, null, null, null, 'SELECT t.company_dept_id,
       t.company_id,
       t.dept_name,
       t.tips,
       t.parent_id,
       t.parent_ids,
       t.tree_level,
       t.is_leaf,
       t.sort,
       t.pause,
       t.create_id,
       t.create_time,
       t.update_id,
       t.update_time,
       t.remarks
  FROM scmdata.sys_company_dept t
 WHERE t.company_id = %default_company_id%
   AND t.company_dept_id = :company_dept_id', null, null, null, null, null, 'company_dept_id,company_id,parent_id,parent_ids,tree_level,is_leaf,sort,remarks', null, null, null, null, null, 1, null, null, null, null, null, null, null, 1, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into bw3.sys_item_list (ITEM_ID, QUERY_TYPE, QUERY_FIELDS, QUERY_COUNT, EDIT_EXPRESS, NEWID_SQL, SELECT_SQL, DETAIL_SQL, SUBSELECT_SQL, INSERT_SQL, UPDATE_SQL, DELETE_SQL, NOSHOW_FIELDS, NOADD_FIELDS, NOMODIFY_FIELDS, NOEDIT_FIELDS, SUBNOSHOW_FIELDS, UI_TMPL, MULTI_PAGE_FLAG, OUTPUT_PARAMETER, LOCK_SQL, MONITOR_ID, END_FIELD, EXECUTE_TIME, SCANNABLE_FIELD, SCANNABLE_TYPE, AUTO_REFRESH, RFID_FLAG, SCANNABLE_TIME, MAX_ROW_COUNT, NOSHOW_APP_FIELDS, SCANNABLE_LOCATION_LINE, SUB_TABLE_JUDGE_FIELD, BACK_GROUND_ID, OPRETION_HINT, SUB_EDIT_STATE, HINT_TYPE, HEADER, FOOTER, JUMP_FIELD, JUMP_EXPRESS, OPEN_MODE, OPERATION_TYPE)
values ('c_2076', 12, null, null, null, null, 'SELECT a.dept_data_priv_id,
       a.dept_data_priv_code,
       a.company_id,
       a.cooperation_type,
       a.cooperation_classification,
       t1.group_dict_name           coop_type_desc,
       t2.group_dict_name           coop_classification_desc,
       a.pause,
       b.company_user_name          creator,
       a.create_time,
       c.company_user_name          updator,
       a.update_time
  FROM sys_company_dept_data_priv a
  LEFT JOIN sys_company_user b
    ON a.create_id = b.user_id
   AND a.company_id = b.company_id
  LEFT JOIN sys_company_user c
    ON a.update_id = c.user_id
   AND a.company_id = c.company_id
  LEFT JOIN sys_group_dict t1
    ON a.cooperation_type = t1.group_dict_value
   AND t1.group_dict_type = ''COOPERATION_TYPE''
  LEFT JOIN sys_group_dict t2
    ON a.cooperation_classification = t2.group_dict_value
   AND t2.group_dict_type = a.cooperation_type
 WHERE a.company_id = %default_company_id%
   AND a.company_dept_id = :company_dept_id', null, null, 'DECLARE
BEGIN
  INSERT INTO sys_company_dept_data_priv
    (dept_data_priv_id,
     dept_data_priv_code,
     company_id,
     company_dept_id,
     cooperation_type,
     cooperation_classification,
     pause,
     create_id,
     create_time,
     update_id,
     update_time)
  VALUES
    (f_get_uuid(),
     pkg_plat_comm.f_getkeycode(''SYS_COMPANY_DEPT_DATA_PRIV'',
                                ''DEPT_DATA_PRIV_CODE'',
                                %default_company_id%,
                                ''DDPV'',
                                8),
     :company_id,
     :company_dept_id,
     :cooperation_type,
     :cooperation_classification,
     :pause,
     :user_id,
     SYSDATE,
     :user_id,
     SYSDATE);

  FOR user_rec IN (SELECT t.user_id, t.company_id
                     FROM scmdata.sys_company_dept dt
                    INNER JOIN scmdata.sys_company_user_dept t
                       ON dt.company_id = t.company_id
                      AND dt.company_dept_id = t.company_dept_id
                    WHERE dt.company_id = :company_id
                      AND dt.company_dept_id = :company_dept_id) LOOP
  
    INSERT INTO sys_company_data_priv
      (data_priv_id,
       data_priv_code,
       user_id,
       company_id,
       cooperation_type,
       cooperation_classification,
       cooperation_product_cate,
       create_id,
       update_id)
    VALUES
      (f_get_uuid(),
       pkg_plat_comm.f_getkeycode(''SYS_COMPANY_DATA_PRIV'',
                                  ''DATA_PRIV_CODE'',
                                  %default_company_id%,
                                  ''DPV'',
                                  8),
       user_rec.user_id,
       user_rec.company_id,
       :cooperation_type,
       :cooperation_classification,
       NULL,
       %current_userid%,
       %current_userid%);
  END LOOP;

END;', null, 'DECLARE
BEGIN
  FOR user_rec IN (SELECT t.user_id,
                          t.company_id,
                          dp.cooperation_type,
                          dp.cooperation_classification
                     FROM scmdata.sys_company_dept dt
                    INNER JOIN scmdata.sys_company_user_dept t
                       ON dt.company_id = t.company_id
                      AND dt.company_dept_id = t.company_dept_id
                    INNER JOIN scmdata.sys_company_dept_data_priv dp
                       ON dt.company_id = dp.company_id
                      AND dt.company_dept_id = dp.company_dept_id
                    WHERE dt.company_id = %default_company_id%
                      AND dt.company_dept_id = :company_dept_id
                      AND dp.cooperation_type = :cooperation_type
                      AND dp.cooperation_classification = :cooperation_classification) LOOP
  
    DELETE FROM sys_company_data_priv dp1
     WHERE dp1.company_id = user_rec.company_id
       AND dp1.user_id = user_rec.user_id
       AND dp1.cooperation_type = user_rec.cooperation_type
       AND dp1.cooperation_classification =
           user_rec.cooperation_classification;
  
  END LOOP;

  DELETE FROM scmdata.sys_company_dept_data_priv dp
   WHERE dp.dept_data_priv_id = :dept_data_priv_id;
END;', 'dept_data_priv_id,dept_data_priv_code,company_id,cooperation_type,cooperation_classification,pause', null, null, null, null, null, 1, null, null, null, null, null, null, null, 1, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

end;
