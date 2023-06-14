BEGIN 
   DECLARE 
       V_CNT  NUMBER(1); 
      
   BEGIN 
       SELECT COUNT(*) INTO V_CNT FROM SYS_ITEM where item_id='a_report_abn_100';
       IF V_CNT=0 THEN   
           insert into SYS_ITEM (panel_id,badge_sql,link_field,item_type,memo,enable_stand_permission,base_table,tag_id,name_field,config_params,offline_flag,help_id,report_title,caption_sql,item_id,sub_scripts,fix_caption,data_source,setting_id,pause,badge_flag,time_out,init_show,key_field,show_rowid)
           values (null,null,null,'manylist',null,null,null,null,null,null,null,null,null,'异常处理分析','a_report_abn_100',null,null,'oracle_scmdata',null,0,null,null,null,null,null);
       ELSE 
           update SYS_ITEM set (panel_id,badge_sql,link_field,item_type,memo,enable_stand_permission,base_table,tag_id,name_field,config_params,offline_flag,help_id,report_title,caption_sql,item_id,sub_scripts,fix_caption,data_source,setting_id,pause,badge_flag,time_out,init_show,key_field,show_rowid) = (select null,null,null,'manylist',null,null,null,null,null,null,null,null,null,'异常处理分析','a_report_abn_100',null,null,'oracle_scmdata',null,0,null,null,null,null,null from dual) where item_id='a_report_abn_100';
       END IF;
   END;
END;
/


BEGIN 
   DECLARE 
       V_CNT  NUMBER(1); 
      
   BEGIN 
       SELECT COUNT(*) INTO V_CNT FROM SYS_ITEM where item_id='a_report_abn_101';
       IF V_CNT=0 THEN   
           insert into SYS_ITEM (panel_id,badge_sql,link_field,item_type,memo,enable_stand_permission,base_table,tag_id,name_field,config_params,offline_flag,help_id,report_title,caption_sql,item_id,sub_scripts,fix_caption,data_source,setting_id,pause,badge_flag,time_out,init_show,key_field,show_rowid)
           values (null,null,null,'list',null,null,null,null,null,null,null,null,null,'异常细分','a_report_abn_101',null,null,'oracle_scmdata',null,0,null,null,null,null,null);
       ELSE 
           update SYS_ITEM set (panel_id,badge_sql,link_field,item_type,memo,enable_stand_permission,base_table,tag_id,name_field,config_params,offline_flag,help_id,report_title,caption_sql,item_id,sub_scripts,fix_caption,data_source,setting_id,pause,badge_flag,time_out,init_show,key_field,show_rowid) = (select null,null,null,'list',null,null,null,null,null,null,null,null,null,'异常细分','a_report_abn_101',null,null,'oracle_scmdata',null,0,null,null,null,null,null from dual) where item_id='a_report_abn_101';
       END IF;
   END;
END;
/

BEGIN 
   DECLARE 
       V_CNT  NUMBER(1); 
      select_sql_VAL CLOB :='{DECLARE
  v_sql CLOB;
  v_class_data_privs CLOB;
BEGIN
  v_class_data_privs := pkg_data_privs.parse_json(p_jsonstr => %data_privs_json_strs%,p_key     => ''COL_2'');
  v_sql := scmdata.pkg_report_analy.f_get_abn_cause_ma(p_start_date  => @abn_begin_time@,
                                                    p_end_date    => @abn_end_time@,
                                                    p_cate        => @abn_category_a@,
                                                    p_fileds_type => @abn_fileds_type@,
                                                    p_fileds      => @abn_fileds_type_a@,
                                                    p_company_id  => %default_company_id%,
                                                    p_class_data_privs => v_class_data_privs);

  @strresult := v_sql;
END;}
/*
--分部tab a_report_abn_101
{--分部tab a_report_abn_101
DECLARE
  --筛选日期
  v_cate          VARCHAR2(32) := @abn_category_a@;
  v_fileds_type   VARCHAR2(32) := @abn_fileds_type@;
  v_fileds        VARCHAR2(32) := @abn_fileds_type_a@;
  v_where         CLOB;
  v_query_where   CLOB;
  v_query_filed   CLOB;
  v_query_filed_a CLOB;
  v_start_date    DATE := @abn_begin_time@;
  v_end_date      DATE := @abn_end_time@;
  v_company_id    VARCHAR2(32) := %default_company_id%;
  v_sql           CLOB;
  v_cnt_sql       CLOB;
  v_flag          NUMBER;
  v_sum_abn_price NUMBER;
BEGIN

  v_cnt_sql := q''[SELECT COUNT(*), nvl(SUM(nvl(t.delay_amount, pr.order_amount) * tc.price),0)  
    FROM scmdata.t_abnormal t
   INNER JOIN scmdata.t_commodity_info tc
      ON t.goo_id = tc.goo_id
     AND t.company_id = tc.company_id
   INNER JOIN scmdata.t_production_progress pr
      ON t.goo_id = pr.goo_id
     AND t.order_id = pr.order_id
     AND t.company_id = pr.company_id
   WHERE t.company_id = '']'' || v_company_id || q''[''
     AND t.progress_status = ''02''
     AND t.anomaly_class IN (''AC_QUALITY'', ''AC_OTHERS'') ]'' || CASE
                 WHEN v_cate = ''1'' THEN
                  '' AND 1 = 1 ''
                 ELSE
                  '' AND tc.category = '''''' || v_cate || ''''''''
               END || ''
     AND trunc(t.confirm_date) BETWEEN '''''' || v_start_date ||
               '''''' AND '''''' || v_end_date || '''''''';

  EXECUTE IMMEDIATE v_cnt_sql
    INTO v_flag, v_sum_abn_price;
  --分部
  v_where := CASE
               WHEN v_cate = ''1'' THEN
                '' AND 1 = 1''
               ELSE
                q''[ AND tc.category = '']'' || v_cate || q''['' ]''
             END;

  --展示维度 
  --筛选字段
  CASE
    WHEN v_fileds_type = ''00'' THEN
      v_query_where := '' AND 1 = 1 '';
      v_query_filed := NULL;
    WHEN v_fileds_type = ''01'' THEN
      v_query_where   := CASE
                           WHEN v_fileds IS NULL THEN
                            '' AND 1 = 1 ''
                           ELSE
                            '' AND tc.samll_category = '''''' || v_fileds || '''''' ''
                         END;
      v_query_filed   := '' product_subclass_name, '';
      v_query_filed_a := '' null product_subclass_name, '';
    WHEN v_fileds_type = ''02'' THEN
      v_query_where   := CASE
                           WHEN v_fileds IS NULL THEN
                            '' AND 1 = 1 ''
                           ELSE
                            '' AND pr.supplier_code = '''''' || v_fileds || '''''' ''
                         END;
      v_query_filed   := '' supplier_code,supplier_company_name, '';
      v_query_filed_a := '' null supplier_code,null supplier_company_name, '';
    ELSE
      NULL;
  END CASE;

  v_where := v_where || v_query_where;

  v_sql := q''[WITH abn_tab AS
 (SELECT DISTINCT t.anomaly_class,
         tc.category,
         t.problem_class,
         t.cause_class,
         sum(nvl(t.delay_amount,pr.order_amount) * tc.price)over(PARTITION BY t.anomaly_class, tc.category, t.problem_class, t.cause_class) abn_price,
         sum(nvl(t.delay_amount,pr.order_amount) * tc.price)over(PARTITION BY t.anomaly_class, tc.category, t.problem_class, t.cause_class) / ]'' ||
           v_sum_abn_price || q''[ abn_price_proportion,
         SUM(CASE
               WHEN t.handle_opinions = ''00'' THEN
                nvl(t.delay_amount, pr.order_amount) * tc.price
               ELSE
                0
             END) over(PARTITION BY t.anomaly_class, tc.category, t.problem_class, t.cause_class) kkreceipt,
         SUM(CASE
               WHEN t.handle_opinions = ''01'' THEN
                nvl(t.delay_amount, pr.order_amount) * tc.price
               ELSE
                0
             END) over(PARTITION BY t.anomaly_class, tc.category, t.problem_class, t.cause_class) rbreceipt,
         SUM(CASE
               WHEN t.handle_opinions = ''02'' THEN
                nvl(t.delay_amount, pr.order_amount) * tc.price
               ELSE
                0
             END) over(PARTITION BY t.anomaly_class, tc.category, t.problem_class, t.cause_class) qxorders,
         SUM(CASE
               WHEN t.handle_opinions = ''03'' THEN
                nvl(t.delay_amount, pr.order_amount) * tc.price
               ELSE
                0
             END) over(PARTITION BY t.anomaly_class, tc.category, t.problem_class, t.cause_class) dxreceipt,
         SUM(CASE
               WHEN t.handle_opinions = ''04'' THEN
                nvl(t.delay_amount, pr.order_amount) * tc.price
               ELSE
                0
             END) over(PARTITION BY t.anomaly_class, tc.category, t.problem_class, t.cause_class) jsreceipt,
         SUM(CASE
               WHEN t.handle_opinions = ''05'' THEN
                nvl(t.delay_amount, pr.order_amount) * tc.price
               ELSE
                0
             END) over(PARTITION BY t.anomaly_class, tc.category, t.problem_class, t.cause_class) fgreceipt,
         SUM(CASE
               WHEN t.handle_opinions = ''06'' THEN
                nvl(t.delay_amount, pr.order_amount) * tc.price
               ELSE
                0
             END) over(PARTITION BY t.anomaly_class, tc.category, t.problem_class, t.cause_class) jlreceipt,
         SUM(CASE
               WHEN t.handle_opinions = ''07'' THEN
                nvl(t.delay_amount, pr.order_amount) * tc.price
               ELSE
                0
             END) over(PARTITION BY t.anomaly_class, tc.category, t.problem_class, t.cause_class) jgreceipt,
         SUM(CASE
               WHEN t.handle_opinions = ''08'' THEN
                nvl(t.delay_amount, pr.order_amount) * tc.price
               ELSE
                0
             END) over(PARTITION BY t.anomaly_class, tc.category, t.problem_class, t.cause_class) yzjgreceipt,
         SUM(CASE
               WHEN t.handle_opinions = ''09'' THEN
                nvl(t.delay_amount, pr.order_amount) * tc.price
               ELSE
                0
             END) over(PARTITION BY t.anomaly_class, tc.category, t.problem_class, t.cause_class) dbreceipt,
         tc.goo_id,
         a.group_dict_name   cate_name,
         tc.samll_category,
         c.company_dict_name product_subclass_name,
         pr.supplier_code,
         sp.supplier_company_name 
    FROM scmdata.t_abnormal t
   INNER JOIN scmdata.t_commodity_info tc
      ON t.goo_id = tc.goo_id
     AND t.company_id = tc.company_id
  LEFT JOIN scmdata.sys_group_dict a
    ON a.group_dict_type = ''PRODUCT_TYPE''
   AND a.group_dict_value = tc.category
  LEFT JOIN scmdata.sys_group_dict b
    ON b.group_dict_type = a.group_dict_value
   AND b.group_dict_value = tc.product_cate
  LEFT JOIN scmdata.sys_company_dict c
    ON c.company_dict_type = b.group_dict_value
   AND c.company_dict_value = tc.samll_category
   AND c.company_id = tc.company_id
   INNER JOIN scmdata.t_production_progress pr 
      ON t.goo_id = pr.goo_id 
     AND t.order_id = pr.order_id
     AND t.company_id = pr.company_id
   LEFT JOIN scmdata.t_supplier_info sp 
    ON pr.supplier_code = sp.supplier_code
    AND pr.company_id = sp.company_id
   WHERE t.company_id = '']'' || v_company_id || q''[''
     AND t.progress_status = ''02''
     AND t.anomaly_class IN (''AC_QUALITY'',''AC_OTHERS'') 
     ]'' || v_where || ''
     AND trunc(t.confirm_date) BETWEEN '''''' || v_start_date ||
           '''''' AND '''''' || v_end_date || '''''''' || q''[)
SELECT anomaly_class,
       cate_name category_name,]'' || v_query_filed || q''[
       problem_class,
       cause_class,
       abn_price abn_money,
       abn_price_proportion abn_sum_propotion,
       kkreceipt,
       rbreceipt,
       qxorders,
       dxreceipt,
       jsreceipt,
       fgreceipt,
       jlreceipt,
       jgreceipt,
       yzjgreceipt,
       dbreceipt
  FROM abn_tab ]'' || CASE
             WHEN v_flag > 0 THEN
              q''[
UNION ALL
SELECT ''合计'' anomaly_class,
       '''' category_name,]'' || v_query_filed_a || q''[
       '''' problem_class,
       '''' cause_class,
       SUM(abn_price) abn_money,
       CASE
         WHEN SUM(abn_price_proportion) > 100 THEN
           100
        ELSE
           SUM(abn_price_proportion)
       END abn_sum_propotion,
       SUM(kkreceipt) kkreceipt,
       SUM(rbreceipt) rbreceipt,
       SUM(qxorders) qxorders,
       SUM(dxreceipt) dxreceipt,
       SUM(jsreceipt) jsreceipt,
       SUM(fgreceipt) fgreceipt,
       SUM(jlreceipt) jlreceipt,
       SUM(jgreceipt) jgreceipt,
       SUM(yzjgreceipt) yzjgreceipt,
       SUM(dbreceipt) dbreceipt
  FROM abn_tab
 ]''
             ELSE
              ''''
           END;
  @strresult := v_sql;
  --dbms_output.put_line(v_sql);
END;
}*/';
   BEGIN 
       SELECT COUNT(*) INTO V_CNT FROM SYS_ITEM_LIST where item_id='a_report_abn_101';
       IF V_CNT=0 THEN   
           insert into SYS_ITEM_LIST (output_parameter,auto_refresh,page_sizes,monitor_id,operation_type,footer,query_count,delete_sql,hint_type,jump_express,end_field,open_mode,insert_sql,multi_page_flag,newid_sql,opretion_hint,query_fields,execute_time,sub_edit_state,ui_tmpl,select_sql,scannable_time,jump_field,noshow_app_fields,detail_sql,noadd_fields,noedit_fields,subselect_sql,nomodify_fields,operate_type,item_id,back_ground_id,noshow_fields,lock_sql,query_type,edit_express,sub_table_judge_field,subnoshow_fields,rfid_flag,scannable_type,update_sql,header,scannable_location_line,scannable_field,max_row_count)
           values (null,null,'20,30,50,100,200,500',null,null,null,null,null,null,null,null,null,null,1,null,null,null,null,null,null,select_sql_VAL,null,null,null,null,null,null,null,null,0,'a_report_abn_101',null,null,null,13,null,null,null,null,null,null,null,null,null,null);
       ELSE 
           update SYS_ITEM_LIST set (output_parameter,auto_refresh,page_sizes,monitor_id,operation_type,footer,query_count,delete_sql,hint_type,jump_express,end_field,open_mode,insert_sql,multi_page_flag,newid_sql,opretion_hint,query_fields,execute_time,sub_edit_state,ui_tmpl,select_sql,scannable_time,jump_field,noshow_app_fields,detail_sql,noadd_fields,noedit_fields,subselect_sql,nomodify_fields,operate_type,item_id,back_ground_id,noshow_fields,lock_sql,query_type,edit_express,sub_table_judge_field,subnoshow_fields,rfid_flag,scannable_type,update_sql,header,scannable_location_line,scannable_field,max_row_count) = (select null,null,'20,30,50,100,200,500',null,null,null,null,null,null,null,null,null,null,1,null,null,null,null,null,null,select_sql_VAL,null,null,null,null,null,null,null,null,0,'a_report_abn_101',null,null,null,13,null,null,null,null,null,null,null,null,null,null from dual) where item_id='a_report_abn_101';
       END IF;
   END;
END;
/

BEGIN 
   DECLARE 
       V_CNT  NUMBER(1); 
      column_fields_VAL CLOB :=q'[handle_opinions_name]';row_fields_VAL CLOB :=q'[anomaly_class_name,category_name,product_subclass_name,problem_class,cause_class,abn_sum_propotion,abn_money]';value_fields_VAL CLOB :=q'[abn_money]';
   BEGIN 
       SELECT COUNT(*) INTO V_CNT FROM SYS_PIVOT_LIST where pivot_id='p_a_report_abn_101';
       IF V_CNT=0 THEN   
           insert into SYS_PIVOT_LIST (pivot_id,memo,column_fields,tag,row_fields,value_fields)
           values ('p_a_report_abn_101',null,column_fields_VAL,null,row_fields_VAL,value_fields_VAL);
       ELSE 
           update SYS_PIVOT_LIST set (pivot_id,memo,column_fields,tag,row_fields,value_fields) = (select 'p_a_report_abn_101',null,column_fields_VAL,null,row_fields_VAL,value_fields_VAL from dual) where pivot_id='p_a_report_abn_101';
       END IF;
   END;
END;
/

BEGIN 
   DECLARE 
       V_CNT  NUMBER(1); 
      
   BEGIN 
       SELECT COUNT(*) INTO V_CNT FROM sys_item_rela where item_id='a_report_abn_101'and relate_id = 'p_a_report_abn_101';
       IF V_CNT=0 THEN   
           insert into sys_item_rela (seq_no,item_id,relate_id,pause,relate_type)
           values (1,'a_report_abn_101','p_a_report_abn_101',1,'P');
       ELSE 
           update sys_item_rela set (seq_no,item_id,relate_id,pause,relate_type) = (select 1,'a_report_abn_101','p_a_report_abn_101',1,'P' from dual) where item_id='a_report_abn_101'and relate_id = 'p_a_report_abn_101';
       END IF;
   END;
END;
/

BEGIN 
   DECLARE 
       V_CNT  NUMBER(1); 
      
   BEGIN 
       SELECT COUNT(*) INTO V_CNT FROM SYS_ITEM where item_id='a_report_abn_102';
       IF V_CNT=0 THEN   
           insert into SYS_ITEM (panel_id,badge_sql,link_field,item_type,memo,enable_stand_permission,base_table,tag_id,name_field,config_params,offline_flag,help_id,report_title,caption_sql,item_id,sub_scripts,fix_caption,data_source,setting_id,pause,badge_flag,time_out,init_show,key_field,show_rowid)
           values (null,null,null,'list',null,null,null,null,null,null,null,null,null,'异常分布','a_report_abn_102',null,null,'oracle_scmdata',null,0,null,null,null,null,null);
       ELSE 
           update SYS_ITEM set (panel_id,badge_sql,link_field,item_type,memo,enable_stand_permission,base_table,tag_id,name_field,config_params,offline_flag,help_id,report_title,caption_sql,item_id,sub_scripts,fix_caption,data_source,setting_id,pause,badge_flag,time_out,init_show,key_field,show_rowid) = (select null,null,null,'list',null,null,null,null,null,null,null,null,null,'异常分布','a_report_abn_102',null,null,'oracle_scmdata',null,0,null,null,null,null,null from dual) where item_id='a_report_abn_102';
       END IF;
   END;
END;
/

BEGIN 
   DECLARE 
       V_CNT  NUMBER(1); 
      select_sql_VAL CLOB :='{
DECLARE
  v_sql CLOB;
  v_class_data_privs CLOB;
BEGIN
  v_class_data_privs := pkg_data_privs.parse_json(p_jsonstr => %data_privs_json_strs%,p_key     => ''COL_2'');
  v_sql := scmdata.pkg_report_analy.f_get_abn_distribut(p_begin_date  => @abn_begin_time@,
                                                    p_end_date    => @abn_end_time@,
                                                    p_cate        => @ABN_CATEGORY_A@,
                                                    p_fileds_type => @ABN_FILEDS_TYPE_B@,
                                                    p_company_id  => %default_company_id%,
                                                    p_class_data_privs => v_class_data_privs);

  @strresult := v_sql;
END;
}
/*
{DECLARE
  --筛选日期
  v_cate          VARCHAR2(32) := @abn_category@;
  v_fileds        VARCHAR2(32) := @ABN_FILEDS_TYPE@;
  v_start_date    DATE := @abn_begin_time@;
  v_end_date      DATE := @abn_end_time@;
  v_sql           CLOB;
  v_cnt_sql       CLOB;
  v_flag          NUMBER;
  v_sum_abn_price NUMBER;
  v_company_id    VARCHAR2(32) := %default_company_id%;
BEGIN

  v_cnt_sql := q''[SELECT COUNT(*), nvl(SUM(nvl(t.delay_amount, pr.order_amount) * tc.price),0)  
    FROM scmdata.t_abnormal t
   INNER JOIN scmdata.t_commodity_info tc
      ON t.goo_id = tc.goo_id
     AND t.company_id = tc.company_id
   INNER JOIN scmdata.t_production_progress pr
      ON t.goo_id = pr.goo_id
     AND t.order_id = pr.order_id
     AND t.company_id = pr.company_id
   INNER JOIN (SELECT gd.supplier_code,
       gd.company_id,
       trunc(gd.create_time) create_time,
       gs.goo_id,
       gs.amount
  FROM scmdata.t_ingood gd
 INNER JOIN scmdata.t_ingoods gs
    ON gd.ing_id = gs.ing_id
   AND gd.company_id = gs.company_id
 WHERE gd.company_id = '']'' || v_company_id || q''['')v ON ]'' || CASE
                 WHEN v_fileds = ''00'' THEN
                  '' v.goo_id = tc.goo_id AND v.company_id = tc.company_id''
                 WHEN v_fileds = ''01'' THEN
                  '' v.supplier_code = pr.supplier_code AND v.company_id = pr.company_id ''
                 WHEN v_fileds = ''02'' THEN
                  ''''
                 ELSE
                  ''''
               END || q''[
   WHERE t.company_id = '']'' || v_company_id || q''[''
     AND t.progress_status = ''02''
     AND t.anomaly_class IN (''AC_QUALITY'', ''AC_OTHERS'') ]'' || CASE
                 WHEN v_cate = ''1'' THEN
                  '' AND 1 = 1 ''
                 ELSE
                  '' AND tc.category = '''''' || v_cate || ''''''''
               END || ''
     AND trunc(t.confirm_date) BETWEEN '''''' || v_start_date ||
               '''''' AND '''''' || v_end_date || '''''''';

  EXECUTE IMMEDIATE v_cnt_sql
    INTO v_flag, v_sum_abn_price;

  v_sql := q''[WITH abn_tab AS
 (SELECT t.anomaly_class,
         tc.category, ]'' || CASE
             WHEN v_fileds = ''00'' THEN
              ''tc.samll_category,''
             ELSE
              ''pr.supplier_code,
               sp.supplier_company_name,''
           END ||
           q''[       
         (nvl(t.delay_amount,pr.order_amount) * tc.price) / ]'' ||
           v_sum_abn_price || q''[ * 100 abn_price_proportion,  
         nvl(t.delay_amount,pr.order_amount) * tc.price abn_price,  
         sum(v.amount*tc.price) over (partition by v.create_time) amt_price,    
         count(*) over (partition by t.goo_id)  abn_cnt,
         count(*) over (partition by pr.product_gress_code) abn_order_cnt,
         pr.product_gress_code
    FROM scmdata.t_abnormal t
   INNER JOIN scmdata.t_commodity_info tc
      ON t.goo_id = tc.goo_id
     AND t.company_id = tc.company_id
   INNER JOIN scmdata.t_production_progress pr 
      ON t.goo_id = pr.goo_id 
     AND t.order_id = pr.order_id
     AND t.company_id = pr.company_id
   INNER JOIN scmdata.t_supplier_info sp 
      ON pr.supplier_code = sp.supplier_code
     AND pr.company_id = sp.company_id
   INNER JOIN (SELECT gd.supplier_code,
       gd.company_id,
       trunc(gd.create_time) create_time,
       gs.goo_id,
       gs.amount
  FROM scmdata.t_ingood gd
 INNER JOIN scmdata.t_ingoods gs
    ON gd.ing_id = gs.ing_id
   AND gd.company_id = gs.company_id
 WHERE gd.company_id = '']'' || v_company_id || q''['')v ON ]'' || CASE
             WHEN v_fileds = ''00'' THEN
              '' v.goo_id = tc.goo_id AND v.company_id = tc.company_id''
             WHEN v_fileds = ''01'' THEN
              '' v.supplier_code = sp.supplier_code AND v.company_id = sp.company_id ''
             WHEN v_fileds = ''02'' THEN
              ''''
             ELSE
              ''''
           END || q''[ WHERE
           t.company_id = '']'' || v_company_id || q''[''
     AND t.progress_status = ''02''
     AND t.anomaly_class IN (''AC_QUALITY'',''AC_OTHERS'') 
     ]'' || CASE
             WHEN v_cate = ''1'' THEN
              '' AND 1 = 1''
             ELSE
              q''[ AND tc.category = '']'' || v_cate || q''['' ]''
           END || ''
     AND trunc(t.confirm_date) BETWEEN '''''' || v_start_date ||
           '''''' AND '''''' || v_end_date || '''''''' || q''[)
SELECT anomaly_class,
       category,]'' || CASE
             WHEN v_fileds = ''00'' THEN
              ''samll_category,''
             ELSE
              ''supplier_code,
               supplier_company_name,''
           END || q''[      
       to_char(round(abn_price_proportion,2),''fm990.00'') || ''%'' abn_sum_propotion,
       abn_price abn_money,
       amt_price,  
       to_char(round(abn_price*100/amt_price,2),''fm990.00'') || ''%'' abn_money_propotion,
       abn_cnt,
       abn_order_cnt,
       sum(case when abn_order_cnt > 2 then 1 else 0 end) over (partition by product_gress_code)  two_abn_order_cnt,
       to_char(round(sum(case when abn_order_cnt > 2 then 1 else 0 end) over (partition by product_gress_code)*100 /abn_order_cnt,2),''fm990.00'') || ''%'' two_abn_proportion
  FROM abn_tab ]'' || CASE
             WHEN v_flag > 0 THEN
              q''[
UNION ALL
SELECT ''合计'' anomaly_class, '''' category,]'' || CASE
                WHEN v_fileds = ''00'' THEN
                 '' '''''''' samll_category,''
                ELSE
                 '' '''''''' supplier_code,
               '''''''' supplier_company_name,''
              END || q''[ 
        to_char(CASE
         WHEN SUM(round(abn_price_proportion, 2)) > 100 THEN
           100
        ELSE
           round(SUM(abn_price_proportion), 2)
       END ,''fm990.00'')|| ''%'' abn_sum_propotion,
       sum(abn_price) abn_money,
       sum(amt_price) amt_price,
       to_char(round(sum(abn_price)*100/sum(amt_price),2),''fm990.00'') || ''%'' abn_money_propotion,
       sum(abn_cnt) abn_cnt,
       sum(abn_order_cnt) abn_order_cnt,
       sum(two_abn_order_cnt) two_abn_order_cnt,
       to_char(round(sum(two_abn_order_cnt)*100/sum(abn_order_cnt),2),''fm990.00'') || ''%'' two_abn_proportion 
FROM (SELECT abn_price,
       round(abn_price_proportion,2) abn_price_proportion,
       amt_price,  
       round(abn_price*100/amt_price,2) abn_proportion,
       abn_cnt,
       abn_order_cnt,
       sum(case when abn_order_cnt > 2 then 1 else 0 end) over (partition by product_gress_code) two_abn_order_cnt
  FROM abn_tab )]''
             ELSE
              ''''
           END;
  @strresult := v_sql;
  --dbms_output.put_line(v_sql);
END;}*/';
   BEGIN 
       SELECT COUNT(*) INTO V_CNT FROM SYS_ITEM_LIST where item_id='a_report_abn_102';
       IF V_CNT=0 THEN   
           insert into SYS_ITEM_LIST (output_parameter,auto_refresh,page_sizes,monitor_id,operation_type,footer,query_count,delete_sql,hint_type,jump_express,end_field,open_mode,insert_sql,multi_page_flag,newid_sql,opretion_hint,query_fields,execute_time,sub_edit_state,ui_tmpl,select_sql,scannable_time,jump_field,noshow_app_fields,detail_sql,noadd_fields,noedit_fields,subselect_sql,nomodify_fields,operate_type,item_id,back_ground_id,noshow_fields,lock_sql,query_type,edit_express,sub_table_judge_field,subnoshow_fields,rfid_flag,scannable_type,update_sql,header,scannable_location_line,scannable_field,max_row_count)
           values (null,null,'20,30,50,100,200,500',null,null,null,null,null,null,null,null,null,null,1,null,null,null,null,null,null,select_sql_VAL,null,null,null,null,null,null,null,null,0,'a_report_abn_102',null,null,null,13,null,null,null,null,null,null,null,null,null,null);
       ELSE 
           update SYS_ITEM_LIST set (output_parameter,auto_refresh,page_sizes,monitor_id,operation_type,footer,query_count,delete_sql,hint_type,jump_express,end_field,open_mode,insert_sql,multi_page_flag,newid_sql,opretion_hint,query_fields,execute_time,sub_edit_state,ui_tmpl,select_sql,scannable_time,jump_field,noshow_app_fields,detail_sql,noadd_fields,noedit_fields,subselect_sql,nomodify_fields,operate_type,item_id,back_ground_id,noshow_fields,lock_sql,query_type,edit_express,sub_table_judge_field,subnoshow_fields,rfid_flag,scannable_type,update_sql,header,scannable_location_line,scannable_field,max_row_count) = (select null,null,'20,30,50,100,200,500',null,null,null,null,null,null,null,null,null,null,1,null,null,null,null,null,null,select_sql_VAL,null,null,null,null,null,null,null,null,0,'a_report_abn_102',null,null,null,13,null,null,null,null,null,null,null,null,null,null from dual) where item_id='a_report_abn_102';
       END IF;
   END;
END;
/

BEGIN 
   DECLARE 
       V_CNT  NUMBER(1); 
      
   BEGIN 
       SELECT COUNT(*) INTO V_CNT FROM SYS_ITEM where item_id='a_report_abn_103';
       IF V_CNT=0 THEN   
           insert into SYS_ITEM (panel_id,badge_sql,link_field,item_type,memo,enable_stand_permission,base_table,tag_id,name_field,config_params,offline_flag,help_id,report_title,caption_sql,item_id,sub_scripts,fix_caption,data_source,setting_id,pause,badge_flag,time_out,init_show,key_field,show_rowid)
           values (null,null,null,'list',null,null,null,null,null,null,null,null,null,'异常细分','a_report_abn_103',null,null,'oracle_scmdata',null,0,null,null,null,null,null);
       ELSE 
           update SYS_ITEM set (panel_id,badge_sql,link_field,item_type,memo,enable_stand_permission,base_table,tag_id,name_field,config_params,offline_flag,help_id,report_title,caption_sql,item_id,sub_scripts,fix_caption,data_source,setting_id,pause,badge_flag,time_out,init_show,key_field,show_rowid) = (select null,null,null,'list',null,null,null,null,null,null,null,null,null,'异常细分','a_report_abn_103',null,null,'oracle_scmdata',null,0,null,null,null,null,null from dual) where item_id='a_report_abn_103';
       END IF;
   END;
END;
/

BEGIN 
   DECLARE 
       V_CNT  NUMBER(1); 
      select_sql_VAL CLOB :='--异常细分
{DECLARE
  --筛选日期
  v_cate          VARCHAR2(32) := @abn_category@;
  v_fileds        VARCHAR2(32) := @ABN_FILEDS_TYPE@;
  v_fileds_a      VARCHAR2(32) := @ABN_FILEDS_TYPE_A@;
  v_start_date    DATE := @abn_begin_time@;
  v_end_date      DATE := @abn_end_time@;
  v_sql           CLOB;
  v_cnt_sql       CLOB;
  v_flag          NUMBER;
  v_sum_abn_price NUMBER;
  v_company_id    VARCHAR2(32) := %default_company_id%;
BEGIN

  v_cnt_sql := q''[SELECT COUNT(*), nvl(SUM(nvl(t.delay_amount, pr.order_amount) * tc.price),0)  
    FROM scmdata.t_abnormal t
   INNER JOIN scmdata.t_commodity_info tc
      ON t.goo_id = tc.goo_id
     AND t.company_id = tc.company_id
   INNER JOIN scmdata.t_production_progress pr
      ON t.goo_id = pr.goo_id
     AND t.order_id = pr.order_id
     AND t.company_id = pr.company_id
   WHERE t.company_id = '']'' || v_company_id || q''[''
     AND t.progress_status = ''02''
     AND t.anomaly_class IN (''AC_QUALITY'', ''AC_OTHERS'') ]'' || CASE
                 WHEN v_cate = ''1'' THEN
                  '' AND 1 = 1 ''
                 ELSE
                  '' AND tc.category = '''''' || v_cate || ''''''''
               END || ''
     AND trunc(t.confirm_date) BETWEEN '''''' || v_start_date ||
               '''''' AND '''''' || v_end_date || '''''''';

  EXECUTE IMMEDIATE v_cnt_sql
    INTO v_flag, v_sum_abn_price;

  v_sql := q''[WITH abn_tab AS
 (SELECT t.anomaly_class,
         tc.category,
         tc.samll_category,
         t.problem_class,
         t.cause_class,         
         (nvl(t.delay_amount,pr.order_amount) * tc.price) / ]'' ||
           v_sum_abn_price || q''[ * 100 abn_price_proportion,
         nvl(t.delay_amount,pr.order_amount) * tc.price abn_price
     FROM scmdata.t_abnormal t
   INNER JOIN scmdata.t_commodity_info tc
      ON t.goo_id = tc.goo_id
     AND t.company_id = tc.company_id
   INNER JOIN scmdata.t_production_progress pr 
      ON t.goo_id = pr.goo_id 
     AND t.order_id = pr.order_id
     AND t.company_id = pr.company_id
   WHERE t.company_id = '']'' || v_company_id || q''[''
     AND t.progress_status = ''02''
     AND t.anomaly_class IN (''AC_QUALITY'',''AC_OTHERS'') 
     ]'' || CASE
             WHEN v_cate = ''1'' THEN
              '' AND 1 = 1''
             ELSE
              q''[ AND tc.category = '']'' || v_cate || q''['' ]''
           END || ''
     AND trunc(t.confirm_date) BETWEEN '''''' || v_start_date ||
           '''''' AND '''''' || v_end_date || '''''''' || q''[)
SELECT anomaly_class,
       category,
       samll_category,
       problem_class,
       cause_class,       
       to_char(round(abn_price_proportion,2),''fm990.00'') || ''%'' abn_price_proportion,
       abn_price
  FROM abn_tab ]'' || CASE
             WHEN v_flag > 0 THEN
              q''[
UNION ALL
SELECT ''合计'' anomaly_class,
       '''' category,
       '''' samll_category,
       '''' problem_class,
       '''' cause_class,      
       CASE
         WHEN SUM(round(abn_price_proportion, 2)) > 100 THEN
           100
        ELSE
           SUM(round(abn_price_proportion, 2))
       END || ''%'' abn_price_proportion,
       SUM(abn_price) abn_price
  FROM abn_tab
 ]''
             ELSE
              ''''
           END;
  @strresult := v_sql;
  --dbms_output.put_line(v_sql);
END;}';
   BEGIN 
       SELECT COUNT(*) INTO V_CNT FROM SYS_ITEM_LIST where item_id='a_report_abn_103';
       IF V_CNT=0 THEN   
           insert into SYS_ITEM_LIST (output_parameter,auto_refresh,page_sizes,monitor_id,operation_type,footer,query_count,delete_sql,hint_type,jump_express,end_field,open_mode,insert_sql,multi_page_flag,newid_sql,opretion_hint,query_fields,execute_time,sub_edit_state,ui_tmpl,select_sql,scannable_time,jump_field,noshow_app_fields,detail_sql,noadd_fields,noedit_fields,subselect_sql,nomodify_fields,operate_type,item_id,back_ground_id,noshow_fields,lock_sql,query_type,edit_express,sub_table_judge_field,subnoshow_fields,rfid_flag,scannable_type,update_sql,header,scannable_location_line,scannable_field,max_row_count)
           values (null,null,'20,30,50,100,200,500',null,null,null,null,null,null,null,null,null,null,1,null,null,null,null,null,null,select_sql_VAL,null,null,null,null,null,null,null,null,0,'a_report_abn_103',null,null,null,2,null,null,null,null,null,null,null,null,null,null);
       ELSE 
           update SYS_ITEM_LIST set (output_parameter,auto_refresh,page_sizes,monitor_id,operation_type,footer,query_count,delete_sql,hint_type,jump_express,end_field,open_mode,insert_sql,multi_page_flag,newid_sql,opretion_hint,query_fields,execute_time,sub_edit_state,ui_tmpl,select_sql,scannable_time,jump_field,noshow_app_fields,detail_sql,noadd_fields,noedit_fields,subselect_sql,nomodify_fields,operate_type,item_id,back_ground_id,noshow_fields,lock_sql,query_type,edit_express,sub_table_judge_field,subnoshow_fields,rfid_flag,scannable_type,update_sql,header,scannable_location_line,scannable_field,max_row_count) = (select null,null,'20,30,50,100,200,500',null,null,null,null,null,null,null,null,null,null,1,null,null,null,null,null,null,select_sql_VAL,null,null,null,null,null,null,null,null,0,'a_report_abn_103',null,null,null,2,null,null,null,null,null,null,null,null,null,null from dual) where item_id='a_report_abn_103';
       END IF;
   END;
END;
/

BEGIN 
   DECLARE 
       V_CNT  NUMBER(1); 
      
   BEGIN 
       SELECT COUNT(*) INTO V_CNT FROM SYS_ITEM where item_id='a_report_quality_100';
       IF V_CNT=0 THEN   
           insert into SYS_ITEM (panel_id,badge_sql,link_field,item_type,memo,enable_stand_permission,base_table,tag_id,name_field,config_params,offline_flag,help_id,report_title,caption_sql,item_id,sub_scripts,fix_caption,data_source,setting_id,pause,badge_flag,time_out,init_show,key_field,show_rowid)
           values (null,null,null,'menu',null,null,null,null,null,null,null,null,null,'质量','a_report_quality_100',null,null,null,null,0,null,null,null,null,null);
       ELSE 
           update SYS_ITEM set (panel_id,badge_sql,link_field,item_type,memo,enable_stand_permission,base_table,tag_id,name_field,config_params,offline_flag,help_id,report_title,caption_sql,item_id,sub_scripts,fix_caption,data_source,setting_id,pause,badge_flag,time_out,init_show,key_field,show_rowid) = (select null,null,null,'menu',null,null,null,null,null,null,null,null,null,'质量','a_report_quality_100',null,null,null,null,0,null,null,null,null,null from dual) where item_id='a_report_quality_100';
       END IF;
   END;
END;
/


BEGIN 
   DECLARE 
       V_CNT  NUMBER(1); 
      
   BEGIN 
       SELECT COUNT(*) INTO V_CNT FROM sys_web_union where item_id='a_report_abn_100' and union_item_id = 'a_report_abn_102';
       IF V_CNT=0 THEN   
           insert into sys_web_union (union_item_id,seqno,item_id,pause)
           values ('a_report_abn_102',1,'a_report_abn_100',0);
       ELSE 
           update sys_web_union set (union_item_id,seqno,item_id,pause) = (select 'a_report_abn_102',1,'a_report_abn_100',0 from dual) where item_id='a_report_abn_100' and union_item_id = 'a_report_abn_102';
       END IF;
   END;
END;
/

BEGIN 
   DECLARE 
       V_CNT  NUMBER(1); 
      
   BEGIN 
       SELECT COUNT(*) INTO V_CNT FROM sys_web_union where item_id='a_report_abn_100' and union_item_id = 'a_report_abn_101';
       IF V_CNT=0 THEN   
           insert into sys_web_union (union_item_id,seqno,item_id,pause)
           values ('a_report_abn_101',2,'a_report_abn_100',0);
       ELSE 
           update sys_web_union set (union_item_id,seqno,item_id,pause) = (select 'a_report_abn_101',2,'a_report_abn_100',0 from dual) where item_id='a_report_abn_100' and union_item_id = 'a_report_abn_101';
       END IF;
   END;
END;
/

BEGIN 
   DECLARE 
       V_CNT  NUMBER(1); 
      
   BEGIN 
       SELECT COUNT(*) INTO V_CNT FROM sys_web_union where item_id='a_report_abn_100' and union_item_id = 'a_report_abn_103';
       IF V_CNT=0 THEN   
           insert into sys_web_union (union_item_id,seqno,item_id,pause)
           values ('a_report_abn_103',3,'a_report_abn_100',1);
       ELSE 
           update sys_web_union set (union_item_id,seqno,item_id,pause) = (select 'a_report_abn_103',3,'a_report_abn_100',1 from dual) where item_id='a_report_abn_100' and union_item_id = 'a_report_abn_103';
       END IF;
   END;
END;
/

BEGIN 
   DECLARE 
       V_CNT  NUMBER(1); 
      
   BEGIN 
       SELECT COUNT(*) INTO V_CNT FROM SYS_TREE_LIST where node_id='node_a_report_quality_100';
       IF V_CNT=0 THEN   
           insert into SYS_TREE_LIST (seq_no,tree_id,item_id,is_end,icon_name,pause,enable_stand_permission,node_type,competence_flag,parent_id,caption_explain,terminal_flag,is_authorize,var_id,app_id,node_id,stand_priv_flag)
           values (0,'tree_a_report','a_report_quality_100',null,null,0,0,1,null,'a_report_100',null,0,1,null,'scm','node_a_report_quality_100',null);
       ELSE 
           update SYS_TREE_LIST set (seq_no,tree_id,item_id,is_end,icon_name,pause,enable_stand_permission,node_type,competence_flag,parent_id,caption_explain,terminal_flag,is_authorize,var_id,app_id,node_id,stand_priv_flag) = (select 0,'tree_a_report','a_report_quality_100',null,null,0,0,1,null,'a_report_100',null,0,1,null,'scm','node_a_report_quality_100',null from dual) where node_id='node_a_report_quality_100';
       END IF;
   END;
END;
/

BEGIN 
   DECLARE 
       V_CNT  NUMBER(1); 
      
   BEGIN 
       SELECT COUNT(*) INTO V_CNT FROM SYS_TREE_LIST where node_id='node_a_report_abn_100';
       IF V_CNT=0 THEN   
           insert into SYS_TREE_LIST (seq_no,tree_id,item_id,is_end,icon_name,pause,enable_stand_permission,node_type,competence_flag,parent_id,caption_explain,terminal_flag,is_authorize,var_id,app_id,node_id,stand_priv_flag)
           values (3,'tree_a_report','a_report_abn_100',1,'icon-renliziyuanxinxiguanlixitong (175)',0,null,1,null,'a_report_quality_100',null,null,1,null,'scm','node_a_report_abn_100',null);
       ELSE 
           update SYS_TREE_LIST set (seq_no,tree_id,item_id,is_end,icon_name,pause,enable_stand_permission,node_type,competence_flag,parent_id,caption_explain,terminal_flag,is_authorize,var_id,app_id,node_id,stand_priv_flag) = (select 3,'tree_a_report','a_report_abn_100',1,'icon-renliziyuanxinxiguanlixitong (175)',0,null,1,null,'a_report_quality_100',null,null,1,null,'scm','node_a_report_abn_100',null from dual) where node_id='node_a_report_abn_100';
       END IF;
   END;
END;
/

