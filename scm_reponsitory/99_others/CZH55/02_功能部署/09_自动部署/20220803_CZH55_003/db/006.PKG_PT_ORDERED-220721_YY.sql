
  
BEGIN  
--权限
insert into scmdata.SYS_APP_PRIVILEGE (PRIV_ID, PRIV_NAME, PARENT_PRIV_ID, PAUSE, OBJ_TYPE, CTL_ID, ITEM_ID, CREATE_ID, CREATE_TIME, UPDATE_ID, UPDATE_TIME, COND_ID, APPLY_BELONG)
values ('P013030104', '编辑-跟单、延期问题', 'P0130301', 0, null, null, null, 'ADMIN', to_date('14-07-2022 15:25:46', 'dd-mm-yyyy hh24:mi:ss'), 'ADMIN', to_date('14-07-2022 15:25:46', 'dd-mm-yyyy hh24:mi:ss'), null, 1);

insert into scmdata.SYS_APP_PRIVILEGE (PRIV_ID, PRIV_NAME, PARENT_PRIV_ID, PAUSE, OBJ_TYPE, CTL_ID, ITEM_ID, CREATE_ID, CREATE_TIME, UPDATE_ID, UPDATE_TIME, COND_ID, APPLY_BELONG)
values ('P013030105', '编辑-qc', 'P0130301', 0, null, null, null, 'ADMIN', to_date('14-07-2022 15:27:11', 'dd-mm-yyyy hh24:mi:ss'), 'ADMIN', to_date('14-07-2022 15:27:11', 'dd-mm-yyyy hh24:mi:ss'), null, 1);
END;
/

  
--加跟单、qc下拉框

 BEGIN 
   DECLARE 
       V_CNT  NUMBER(1); 
      
   BEGIN 
       SELECT COUNT(*) INTO V_CNT FROM bw3.sys_ELEMENT where element_id in ('look_a_report_120_1','look_a_report_120_2')  and ELEMENT_ID = 'look_a_report_120_1';
       IF V_CNT=0 THEN   
           insert into bw3.sys_ELEMENT (is_hide,is_async,is_per_exe,memo,element_id,element_type,message,data_source,pause,enable_stand_permission)
           values (null,null,null,null,'look_a_report_120_1','lookup',null,null,0,1);
       ELSE 
           update bw3.sys_ELEMENT set (is_hide,is_async,is_per_exe,memo,element_id,element_type,message,data_source,pause,enable_stand_permission) = (select null,null,null,null,'look_a_report_120_1','lookup',null,null,0,1 from dual) where element_id in ('look_a_report_120_1','look_a_report_120_2')  and ELEMENT_ID = 'look_a_report_120_1';
       END IF;
   END;
END;
/

BEGIN 
   DECLARE 
       V_CNT  NUMBER(1); 
      
   BEGIN 
       SELECT COUNT(*) INTO V_CNT FROM bw3.sys_ELEMENT where element_id in ('look_a_report_120_1','look_a_report_120_2')  and ELEMENT_ID = 'look_a_report_120_2';
       IF V_CNT=0 THEN   
           insert into bw3.sys_ELEMENT (is_hide,is_async,is_per_exe,memo,element_id,element_type,message,data_source,pause,enable_stand_permission)
           values (null,null,null,null,'look_a_report_120_2','lookup',null,null,0,1);
       ELSE 
           update bw3.sys_ELEMENT set (is_hide,is_async,is_per_exe,memo,element_id,element_type,message,data_source,pause,enable_stand_permission) = (select null,null,null,null,'look_a_report_120_2','lookup',null,null,0,1 from dual) where element_id in ('look_a_report_120_1','look_a_report_120_2')  and ELEMENT_ID = 'look_a_report_120_2';
       END IF;
   END;
END;
/

BEGIN
insert into bw3.sys_look_up (ELEMENT_ID, FIELD_NAME, LOOK_UP_SQL, DATA_TYPE, KEY_FIELD, RESULT_FIELD, BEFORE_FIELD, SEARCH_FLAG, MULTI_VALUE_FLAG, DISABLED_FIELD, GROUP_FIELD, VALUE_SEP, ICON, PORT_ID, PORT_SQL)
values ('look_a_report_120_1', 'FLW_ORDER', '
 {
 DECLARE
 v_sql CLOB;
 v_cate VARCHAR2(256);

 BEGIN
   v_sql := ''SELECT p.user_id DEAL_FOLLOWER,p.company_user_name FLW_ORDER
               FROM scmdata.sys_company_user p where p.company_id = %default_company_id% '';

 IF :pt_ordered_id IS NOT NULL THEN
   SELECT t.category
     INTO v_cate
     FROM scmdata.pt_ordered t
    WHERE t.pt_ordered_id=:pt_ordered_id;
   v_sql := ''select distinct user_id DEAL_FOLLOWER,company_user_name FLW_ORDER from (
select a.user_id, a.company_user_name, d.dept_name,e1.cooperation_classification
  from scmdata.sys_company_user a
 inner join scmdata.sys_user b
    on a.user_id = b.user_id
 inner join scmdata.sys_company_user_dept c
    on a.user_id = c.user_id
   and a.company_id = c.company_id
 inner join scmdata.sys_company_dept d
    on c.company_dept_id = d.company_dept_id
   and c.company_id = d.company_id
   and d.pause = 0
   and d.dept_name like ''''%跟单组%''''
  left join scmdata.sys_company_dept_cate_map e1
    on d.company_id = e1.company_id
   and d.company_dept_id = e1.company_dept_id
   where e1.cooperation_classification is not null
     and a.pause = 0
     AND A.COMPANY_ID = %default_company_id%
   union all
 select a.user_id, a.company_user_name, d.dept_name,  fd.col_2 cooperation_classification
   from scmdata.sys_company_user a
  inner join scmdata.sys_user b
     on a.user_id = b.user_id
  inner join scmdata.sys_company_user_dept c
     on a.user_id = c.user_id
    and a.company_id = c.company_id
  inner join scmdata.sys_company_dept d
     on c.company_dept_id = d.company_dept_id
    and c.company_id = d.company_id
    and d.pause = 0
    and d.dept_name like ''''%跟单共享组%''''
   left join scmdata.sys_company_dept_cate_map e1
     on d.company_id = e1.company_id
    and d.company_dept_id = e1.company_dept_id
   left join scmdata.sys_company_data_priv_user_middle pm
     on pm.user_id = c.user_id
   left join scmdata.sys_company_data_priv_group e
     on e.company_id = pm.company_id
    and e.data_priv_group_id = pm.data_priv_group_id
   left join scmdata.sys_company_data_priv_middle f
     on f.data_priv_group_id = e.data_priv_group_id
   left join scmdata.sys_data_privs dp
     on dp.data_priv_id = f.data_priv_id
   left join scmdata.sys_data_priv_pick_fields fd
     on fd.data_priv_id = dp.data_priv_id
  where e1.cooperation_classification is null
    and a.pause = 0
    AND A.COMPANY_ID = %default_company_id%
    and e.data_priv_group_name not like ''''%仓库%'''')''|| '' where cooperation_classification  = '''''' ||V_cate||'''''''';
  END IF;

  '||CHR(64)||'strresult := v_sql;
 END;
 } ', '1', 'DEAL_FOLLOWER', 'FLW_ORDER', 'DEAL_FOLLOWER', 1, 1, null, null, ',', null, null, null);
END;
/


BEGIN
insert into bw3.sys_look_up (ELEMENT_ID, FIELD_NAME, LOOK_UP_SQL, DATA_TYPE, KEY_FIELD, RESULT_FIELD, BEFORE_FIELD, SEARCH_FLAG, MULTI_VALUE_FLAG, DISABLED_FIELD, GROUP_FIELD, VALUE_SEP, ICON, PORT_ID, PORT_SQL)
values ('look_a_report_120_2', 'QC', '{
 DECLARE
 v_sql CLOB;
 --v_cate VARCHAR2(256);

 BEGIN
   v_sql := ''SELECT p.user_id QC_ID,p.company_user_name QC
               FROM scmdata.sys_company_user p where p.company_id = %default_company_id% '';

 IF :pt_ordered_id IS NOT NULL THEN
   v_sql :=''SELECT a.user_id QC_id,a.company_user_name QC FROM scmdata.SYS_COMPANY_USER A
            INNER JOIN scmdata.SYS_COMPANY_JOB B ON A.JOB_ID=B.JOB_ID AND A.COMPANY_ID=B.COMPANY_ID
            WHERE (b.job_name =''''QC主管'''' or B.JOB_NAME=''''QC'''') and a.pause=0 and  a.company_id = %default_company_id% '';
  END IF;
  @strresult := v_sql;
 END;
 } ', '1', 'QC_ID', 'QC', 'QC_ID', 1, 1, null, null, ',', null, null, null);
END;
/

BEGIN 
   DECLARE 
       V_CNT  NUMBER(1); 
      
   BEGIN 
       SELECT COUNT(*) INTO V_CNT FROM bw3.sys_item_element_rela where item_id='a_report_120' and element_id in ('look_a_report_120_1','look_a_report_120_2')  and ELEMENT_ID = 'look_a_report_120_1';
       IF V_CNT=0 THEN   
           insert into bw3.sys_item_element_rela (seq_no,item_id,element_id,level_no,pause)
           values (2,'a_report_120','look_a_report_120_1',null,0);
       ELSE 
           update bw3.sys_item_element_rela set (seq_no,item_id,element_id,level_no,pause) = (select 2,'a_report_120','look_a_report_120_1',null,0 from dual) where item_id='a_report_120' and element_id in ('look_a_report_120_1','look_a_report_120_2')  and ELEMENT_ID = 'look_a_report_120_1';
       END IF;
   END;
END;
/

BEGIN 
   DECLARE 
       V_CNT  NUMBER(1); 
      
   BEGIN 
       SELECT COUNT(*) INTO V_CNT FROM bw3.sys_item_element_rela where item_id='a_report_120' and element_id in ('look_a_report_120_1','look_a_report_120_2')  and ELEMENT_ID = 'look_a_report_120_2';
       IF V_CNT=0 THEN   
           insert into bw3.sys_item_element_rela (seq_no,item_id,element_id,level_no,pause)
           values (1,'a_report_120','look_a_report_120_2',null,0);
       ELSE 
           update bw3.sys_item_element_rela set (seq_no,item_id,element_id,level_no,pause) = (select 1,'a_report_120','look_a_report_120_2',null,0 from dual) where item_id='a_report_120' and element_id in ('look_a_report_120_1','look_a_report_120_2')  and ELEMENT_ID = 'look_a_report_120_2';
       END IF;
   END;
END;
/
