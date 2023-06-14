
BEGIN 
   DECLARE 
       V_CNT  NUMBER(1); 
      select_sql_VAL CLOB :='SELECT X.CAPTION_SQL APPLY_NAME_PR,
       NVL(Y.RENSHU, 0) PAGE_OPEN_PERS,
       NVL(Y.CISHU, 0) PAGE_OPEN_TIMES,
       NVL(Y.PINJUN, 0) AVG_PAGE_OPEN,
       NVL(Z.RENSHU2, 0) OPER_TIMES_PERS,
       NVL(Z.CISHU, 0) OPER_TIMES,
       NVL(Z.PINJUN2, 0) AVG_OPER_TIMES
  FROM (SELECT X.CAPTION_SQL
          FROM BW3.SYS_TREE_LIST R
         INNER JOIN BW3.SYS_ITEM X
            ON X.ITEM_ID = R.ITEM_ID
         WHERE R.PARENT_ID = ''menuroot''
           AND R.PAUSE = 0
           AND R.SEQ_NO BETWEEN 3 AND 50
         ORDER BY SEQ_NO) X
  LEFT JOIN (SELECT B.APPLY_ROOT_NAME,
                    COUNT(USER_ID) RENSHU,
                    SUM(MM) CISHU,
                    ROUND(SUM(MM) / COUNT(USER_ID)) PINJUN
               FROM (SELECT A.APPLY_ROOT_NAME, A.USER_ID, COUNT(1) MM
                       FROM SCMDATA.SYS_GROUP_OPER_LOG_DW A
                      WHERE (A.OPT_TYPE = ''301''
                         OR A.OPT_TYPE = ''404'')
                        AND A.WHEN_DAY BETWEEN
                            @DATE_START_PR@ AND
                            @DATE_END_PR@
                       AND EXISTS( SELECT 1 FROM SCMDATA.SYS_USER B WHERE B.USER_ID=A.USER_ID AND B.PAUSE=0)
                      GROUP BY A.APPLY_ROOT_NAME, A.USER_ID) B
              GROUP BY B.APPLY_ROOT_NAME) Y
    ON Y.APPLY_ROOT_NAME = X.CAPTION_SQL
  left JOIN (SELECT B.APPLY_ROOT_NAME,
                    COUNT(USER_ID) RENSHU2,
                    SUM(CISHU) CISHU,
                    ROUND(SUM(CISHU) / COUNT(USER_ID)) PINJUN2
               FROM (SELECT A.APPLY_ROOT_NAME, A.USER_ID, COUNT(1) CISHU
                       FROM SCMDATA.SYS_GROUP_OPER_LOG_DW A
                      WHERE (A.OPT_TYPE = ''302''
                         OR A.OPT_TYPE = ''303''
                         OR A.OPT_TYPE = ''401'')
                        AND A.WHEN_DAY BETWEEN
                            @DATE_START_PR@ AND
                            @DATE_END_PR@
                       AND EXISTS( SELECT 1 FROM SCMDATA.SYS_USER B WHERE B.USER_ID=A.USER_ID AND B.PAUSE=0)
                      GROUP BY A.APPLY_ROOT_NAME, A.USER_ID) B
              GROUP BY APPLY_ROOT_NAME) Z
    ON Z.APPLY_ROOT_NAME = Y.APPLY_ROOT_NAME';
   BEGIN 
       SELECT COUNT(*) INTO V_CNT FROM bw3.SYS_ITEM_LIST where item_id='g_620';
       IF V_CNT=0 THEN   
           insert into bw3.SYS_ITEM_LIST (output_parameter,auto_refresh,page_sizes,monitor_id,operation_type,footer,query_count,delete_sql,hint_type,jump_express,end_field,open_mode,insert_sql,multi_page_flag,newid_sql,opretion_hint,query_fields,execute_time,sub_edit_state,ui_tmpl,select_sql,scannable_time,jump_field,noshow_app_fields,detail_sql,noadd_fields,noedit_fields,subselect_sql,nomodify_fields,operate_type,item_id,back_ground_id,noshow_fields,lock_sql,query_type,edit_express,sub_table_judge_field,subnoshow_fields,rfid_flag,scannable_type,update_sql,header,scannable_location_line,scannable_field,max_row_count)
           values (null,3,null,null,null,null,null,null,0,null,'1',0,null,0,null,null,'APPLY_NAME_PR',0,0,null,select_sql_VAL,null,null,null,null,null,null,null,null,0,'g_620',null,null,null,13,null,null,null,0,null,null,null,null,null,0);
       ELSE 
           update bw3.SYS_ITEM_LIST set (output_parameter,auto_refresh,page_sizes,monitor_id,operation_type,footer,query_count,delete_sql,hint_type,jump_express,end_field,open_mode,insert_sql,multi_page_flag,newid_sql,opretion_hint,query_fields,execute_time,sub_edit_state,ui_tmpl,select_sql,scannable_time,jump_field,noshow_app_fields,detail_sql,noadd_fields,noedit_fields,subselect_sql,nomodify_fields,operate_type,item_id,back_ground_id,noshow_fields,lock_sql,query_type,edit_express,sub_table_judge_field,subnoshow_fields,rfid_flag,scannable_type,update_sql,header,scannable_location_line,scannable_field,max_row_count) = (select null,3,null,null,null,null,null,null,0,null,'1',0,null,0,null,null,'APPLY_NAME_PR',0,0,null,select_sql_VAL,null,null,null,null,null,null,null,null,0,'g_620',null,null,null,13,null,null,null,0,null,null,null,null,null,0 from dual) where item_id='g_620';
       END IF;
   END;
END;
/





BEGIN 
   DECLARE 
       V_CNT  NUMBER(1); 
      select_sql_VAL CLOB :='SELECT U.USER_ID, --操作用户
       U.NICK_NAME         OPER_USER_PR,
       U.USER_ACCOUNT, --账号
       U_INFO.COMPANY_NAME USER_LOGN_NAME, --企业
       U_INFO.DEPT_NAME    DEPT_NAME_PR, --部门
       U_INFO.JOB_NAME, --岗位
       (case when b.caption_sql like ''%select%''
         then Regexp_replace(b.caption_sql,''[A-Za-z0-9_ =:\|'''']'','''')
           else b.caption_sql  end)  OPER_ITEM_CAPTION,
       A.APPLY_ROOT_NAME,
       A.LAST_MENU_NAME,
       A.OPER_TIME

  FROM SCMDATA.SYS_GROUP_OPER_LOG_DW A
 INNER JOIN SCMDATA.SYS_USER U
    ON U.USER_ID = A.USER_ID
 INNER JOIN (SELECT CU.USER_ID,
                    LISTAGG(DISTINCT C.COMPANY_NAME, '';'') COMPANY_NAME,
                    LISTAGG(DISTINCT CD.DEPT_NAME, '';'') DEPT_NAME,
                    MAX(J.JOB_NAME) JOB_NAME
               FROM SCMDATA.SYS_COMPANY_USER CU
              INNER JOIN SCMDATA.SYS_COMPANY C
                 ON C.COMPANY_ID = CU.COMPANY_ID
               LEFT JOIN SCMDATA.SYS_COMPANY_JOB J
                 ON CU.JOB_ID = J.JOB_ID
               LEFT JOIN SCMDATA.SYS_COMPANY_USER_DEPT CUD
                 ON CUD.USER_ID = CU.USER_ID
                AND CUD.COMPANY_ID = CU.COMPANY_ID
               LEFT JOIN SCMDATA.SYS_COMPANY_DEPT CD
                 ON CD.COMPANY_DEPT_ID = CUD.COMPANY_DEPT_ID
              GROUP BY CU.USER_ID) U_INFO
    ON U_INFO.USER_ID = A.USER_ID
 INNER JOIN BW3.SYS_ITEM B
    ON A.ITEM_ID = B.ITEM_ID
 WHERE A.APPLY_ROOT_NAME = :APPLY_NAME_PR
   AND A.OPT_TYPE IN( ''301'', ''404'')
   AND A.WHEN_DAY BETWEEN @DATE_START_PR@ AND @DATE_END_PR@
   AND U.PAUSE=0
 ORDER BY A.OPER_TIME DESC';
   BEGIN 
       SELECT COUNT(*) INTO V_CNT FROM bw3.SYS_ITEM_LIST where item_id='g_621_1';
       IF V_CNT=0 THEN   
           insert into bw3.SYS_ITEM_LIST (output_parameter,auto_refresh,page_sizes,monitor_id,operation_type,footer,query_count,delete_sql,hint_type,jump_express,end_field,open_mode,insert_sql,multi_page_flag,newid_sql,opretion_hint,query_fields,execute_time,sub_edit_state,ui_tmpl,select_sql,scannable_time,jump_field,noshow_app_fields,detail_sql,noadd_fields,noedit_fields,subselect_sql,nomodify_fields,operate_type,item_id,back_ground_id,noshow_fields,lock_sql,query_type,edit_express,sub_table_judge_field,subnoshow_fields,rfid_flag,scannable_type,update_sql,header,scannable_location_line,scannable_field,max_row_count)
           values (null,3,null,null,null,null,null,null,null,null,null,null,null,1,null,null,'OPER_USER_PR,USER_ACCOUNT,USER_LOGN_NAME,DEPT_NAME_PR,OPER_ITEM_CAPTION',null,null,null,select_sql_VAL,null,null,null,null,null,null,null,null,0,'g_621_1',null,'USER_ID',null,13,null,null,null,null,null,null,null,null,null,null);
       ELSE 
           update bw3.SYS_ITEM_LIST set (output_parameter,auto_refresh,page_sizes,monitor_id,operation_type,footer,query_count,delete_sql,hint_type,jump_express,end_field,open_mode,insert_sql,multi_page_flag,newid_sql,opretion_hint,query_fields,execute_time,sub_edit_state,ui_tmpl,select_sql,scannable_time,jump_field,noshow_app_fields,detail_sql,noadd_fields,noedit_fields,subselect_sql,nomodify_fields,operate_type,item_id,back_ground_id,noshow_fields,lock_sql,query_type,edit_express,sub_table_judge_field,subnoshow_fields,rfid_flag,scannable_type,update_sql,header,scannable_location_line,scannable_field,max_row_count) = (select null,3,null,null,null,null,null,null,null,null,null,null,null,1,null,null,'OPER_USER_PR,USER_ACCOUNT,USER_LOGN_NAME,DEPT_NAME_PR,OPER_ITEM_CAPTION',null,null,null,select_sql_VAL,null,null,null,null,null,null,null,null,0,'g_621_1',null,'USER_ID',null,13,null,null,null,null,null,null,null,null,null,null from dual) where item_id='g_621_1';
       END IF;
   END;
END;
/





BEGIN 
   DECLARE 
       V_CNT  NUMBER(1); 
      select_sql_VAL CLOB :='SELECT U.USER_ID,
       U.NICK_NAME OPER_USER_PR,
       U.USER_ACCOUNT,
       U_INFO.COMPANY_NAME USER_LOGN_NAME,
       U_INFO.DEPT_NAME DEPT_NAME_PR,
       U_INFO.JOB_NAME, --岗位
       (CASE
         WHEN A.OPT_TYPE = ''401'' THEN
          SA.CAPTION
         WHEN A.OPT_TYPE = ''302'' THEN
          ''查询''
         WHEN A.OPT_TYPE = ''303'' THEN
          ''数据新增/修改/删除''
       END) OPER_FUNCTION,
       (case when i.caption_sql like ''%select%''
         then Regexp_replace(i.caption_sql,''[A-Za-z0-9_ =:\|'''']'','''')
           else i.caption_sql  end)  OPER_ITEM_CAPTION,
       A.APPLY_ROOT_NAME,
       A.LAST_MENU_NAME,
       A.OPER_TIME
  FROM SCMDATA.SYS_GROUP_OPER_LOG_DW A
 INNER JOIN SCMDATA.SYS_USER U
    ON U.USER_ID = A.USER_ID
 INNER JOIN (SELECT CU.USER_ID,
                    LISTAGG(DISTINCT C.COMPANY_NAME, '';'') COMPANY_NAME,
                    LISTAGG(DISTINCT CD.DEPT_NAME, '';'') DEPT_NAME,
                    MAX(J.JOB_NAME) JOB_NAME
               FROM SCMDATA.SYS_COMPANY_USER CU
              INNER JOIN SCMDATA.SYS_COMPANY C
                 ON C.COMPANY_ID = CU.COMPANY_ID
               LEFT JOIN SCMDATA.SYS_COMPANY_JOB J
                 ON CU.JOB_ID = J.JOB_ID
               LEFT JOIN SCMDATA.SYS_COMPANY_USER_DEPT CUD
                 ON CUD.USER_ID = CU.USER_ID
                AND CUD.COMPANY_ID = CU.COMPANY_ID
               LEFT JOIN SCMDATA.SYS_COMPANY_DEPT CD
                 ON CD.COMPANY_DEPT_ID = CUD.COMPANY_DEPT_ID
              GROUP BY CU.USER_ID) U_INFO
    ON U_INFO.USER_ID = A.USER_ID
 LEFT JOIN BW3.SYS_ACTION SA
    ON SA.ELEMENT_ID = A.ELEMENT_ID
 INNER JOIN BW3.SYS_ITEM I
    ON I.ITEM_ID = A.ITEM_ID
 WHERE A.APPLY_ROOT_NAME = :APPLY_NAME_PR
   AND A.WHEN_DAY BETWEEN @DATE_START_PR@ AND @DATE_END_PR@
   AND A.OPT_TYPE IN (''303'', ''302'', ''401'')
 ORDER BY A.OPER_TIME DESC';
   BEGIN 
       SELECT COUNT(*) INTO V_CNT FROM bw3.SYS_ITEM_LIST where item_id='g_621_2';
       IF V_CNT=0 THEN   
           insert into bw3.SYS_ITEM_LIST (output_parameter,auto_refresh,page_sizes,monitor_id,operation_type,footer,query_count,delete_sql,hint_type,jump_express,end_field,open_mode,insert_sql,multi_page_flag,newid_sql,opretion_hint,query_fields,execute_time,sub_edit_state,ui_tmpl,select_sql,scannable_time,jump_field,noshow_app_fields,detail_sql,noadd_fields,noedit_fields,subselect_sql,nomodify_fields,operate_type,item_id,back_ground_id,noshow_fields,lock_sql,query_type,edit_express,sub_table_judge_field,subnoshow_fields,rfid_flag,scannable_type,update_sql,header,scannable_location_line,scannable_field,max_row_count)
           values (null,3,null,null,null,null,null,null,null,null,null,null,null,1,null,null,'OPER_USER_PR,USER_ACCOUNT,USER_LOGN_NAME,DEPT_NAME_PR,OPER_ITEM_CAPTION',null,null,null,select_sql_VAL,null,null,null,null,null,null,null,null,0,'g_621_2',null,'USER_ID',null,13,null,null,null,null,null,null,null,null,null,null);
       ELSE 
           update bw3.SYS_ITEM_LIST set (output_parameter,auto_refresh,page_sizes,monitor_id,operation_type,footer,query_count,delete_sql,hint_type,jump_express,end_field,open_mode,insert_sql,multi_page_flag,newid_sql,opretion_hint,query_fields,execute_time,sub_edit_state,ui_tmpl,select_sql,scannable_time,jump_field,noshow_app_fields,detail_sql,noadd_fields,noedit_fields,subselect_sql,nomodify_fields,operate_type,item_id,back_ground_id,noshow_fields,lock_sql,query_type,edit_express,sub_table_judge_field,subnoshow_fields,rfid_flag,scannable_type,update_sql,header,scannable_location_line,scannable_field,max_row_count) = (select null,3,null,null,null,null,null,null,null,null,null,null,null,1,null,null,'OPER_USER_PR,USER_ACCOUNT,USER_LOGN_NAME,DEPT_NAME_PR,OPER_ITEM_CAPTION',null,null,null,select_sql_VAL,null,null,null,null,null,null,null,null,0,'g_621_2',null,'USER_ID',null,13,null,null,null,null,null,null,null,null,null,null from dual) where item_id='g_621_2';
       END IF;
   END;
END;
/
