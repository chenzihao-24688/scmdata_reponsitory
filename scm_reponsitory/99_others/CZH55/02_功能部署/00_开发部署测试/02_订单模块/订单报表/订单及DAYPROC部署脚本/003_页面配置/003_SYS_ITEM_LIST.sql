BEGIN
  DECLARE
    JUDGE_N NUMBER(4);
    EXE_SQL CLOB;
    VALS    CLOB;
  CV1 CLOB:=q'[]';
  CV2 CLOB:=q'[]';
  CV3 CLOB:=q'[]';
  CV4 CLOB:=q'[]';
  CV5 CLOB:=q'[]';
  CV6 CLOB:=q'[]';
  CV7 CLOB:=q'[WITH company_user AS
 (SELECT fu.company_id, fu.user_id, fu.company_user_name
    FROM scmdata.sys_company_user fu)
SELECT pt.year,
       pt.quarter,
       pt.month,
       pt.category_name,
       pt.supplier_code inside_supplier_code,
       pt.supplier_company_name,
       pt.factory_company_name factory_company_name,
       pt.product_gress_code,
       pt.goo_id rela_goo_id,
       pt.coop_product_cate_name,
       pt.product_subclass_name,
       pt.style_name,
       pt.style_number,
       (SELECT listagg(fu_a.company_user_name, ',')
          FROM company_user fu_a
            WHERE fu_a.company_id = pt.company_id
           AND instr(',' || pt.flw_order || ',', ',' || fu_a.user_id || ',') > 0) flw_order,
       pt.flw_order_manager,
       (SELECT listagg(fu_b.company_user_name, ',')
          FROM company_user fu_b
         WHERE fu_b.company_id = pt.company_id
           AND instr(',' || pt.qc || ',', ',' || fu_b.user_id || ',') > 0) qc,
       pt.qc_manager,
       pt.area_gp_leader,
       decode(pt.is_twenty, 1, '是', 0, '否', '') is_twenty,
       pt.delivery_status,
       decode(pt.is_quality, 1, '是', 0, '否', '') is_quality,
       pt.actual_delay_days,
       pt.delay_section,
       pt.responsible_dept,
       pt.responsible_dept_sec,
       pt.delay_problem_class,
       pt.delay_cause_class,
       pt.delay_cause_detailed,
       pt.problem_desc,
       pt.purchase_price,
       pt.fixed_price,
       pt.order_amount,
       pt.est_arrival_amount,
       pt.delivery_amount pt_delivery_amount,
       pt.satisfy_amount,
       pt.order_money,
       pt.delivery_money,
       pt.satisfy_money,
       pt.delivery_date,
       pt.order_create_date,
       pt.arrival_date,
       pt.sort_date,
       decode(pt.is_first_order, 1, '是', 0, '否', '') is_first_order,
       pt.remarks,
       pt.order_finish_time
  FROM scmdata.pt_ordered pt
 WHERE pt.company_id = %default_company_id%]';
  CV8 CLOB:=q'[]';
  CV9 CLOB:=q'[]';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_ITEM_LIST WHERE ITEM_ID = ''a_report_120''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_ITEM_LIST SET (AUTO_REFRESH,BACK_GROUND_ID,EDIT_EXPRESS,END_FIELD,EXECUTE_TIME,FOOTER,HEADER,HINT_TYPE,JUMP_EXPRESS,JUMP_FIELD,MAX_ROW_COUNT,MONITOR_ID,MULTI_PAGE_FLAG,NOADD_FIELDS,NOEDIT_FIELDS,NOMODIFY_FIELDS,NOSHOW_APP_FIELDS,NOSHOW_FIELDS,OPEN_MODE,OPERATE_TYPE,OPERATION_TYPE,OUTPUT_PARAMETER,PAGE_SIZES,QUERY_COUNT,QUERY_FIELDS,QUERY_TYPE,RFID_FLAG,SCANNABLE_FIELD,SCANNABLE_LOCATION_LINE,SCANNABLE_TIME,SCANNABLE_TYPE,SUBNOSHOW_FIELDS,SUB_EDIT_STATE,SUB_TABLE_JUDGE_FIELD,UI_TMPL,DELETE_SQL,DETAIL_SQL,INSERT_SQL,LOCK_SQL,NEWID_SQL,OPRETION_HINT,SELECT_SQL,SUBSELECT_SQL,UPDATE_SQL) = (SELECT ,q''^^'',q''^^'',q''^^'',,q''^^'',q''^^'',,q''^^'',q''^^'',,q''^^'',1,q''^^'',q''^^'',q''^^'',q''^^'',q''^pt_ordered_id,company_id,order_id^'',,0,q''^^'',q''^^'',q''^^'',,q''^^'',13,,q''^^'',q''^^'',,,q''^^'',,q''^^'',q''^^'',:CV1,:CV2,:CV3,:CV4,:CV5,:CV6,:CV7,:CV8,:CV9 FROM DUAL) WHERE ITEM_ID = ''a_report_120''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3,CV4,CV5,CV6,CV7,CV8,CV9;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_ITEM_LIST (AUTO_REFRESH,BACK_GROUND_ID,EDIT_EXPRESS,END_FIELD,EXECUTE_TIME,FOOTER,HEADER,HINT_TYPE,ITEM_ID,JUMP_EXPRESS,JUMP_FIELD,MAX_ROW_COUNT,MONITOR_ID,MULTI_PAGE_FLAG,NOADD_FIELDS,NOEDIT_FIELDS,NOMODIFY_FIELDS,NOSHOW_APP_FIELDS,NOSHOW_FIELDS,OPEN_MODE,OPERATE_TYPE,OPERATION_TYPE,OUTPUT_PARAMETER,PAGE_SIZES,QUERY_COUNT,QUERY_FIELDS,QUERY_TYPE,RFID_FLAG,SCANNABLE_FIELD,SCANNABLE_LOCATION_LINE,SCANNABLE_TIME,SCANNABLE_TYPE,SUBNOSHOW_FIELDS,SUB_EDIT_STATE,SUB_TABLE_JUDGE_FIELD,UI_TMPL,DELETE_SQL,DETAIL_SQL,INSERT_SQL,LOCK_SQL,NEWID_SQL,OPRETION_HINT,SELECT_SQL,SUBSELECT_SQL,UPDATE_SQL) SELECT ,q''^^'',q''^^'',q''^^'',,q''^^'',q''^^'',,''a_report_120'',q''^^'',q''^^'',,q''^^'',1,q''^^'',q''^^'',q''^^'',q''^^'',q''^pt_ordered_id,company_id,order_id^'',,0,q''^^'',q''^^'',q''^^'',,q''^^'',13,,q''^^'',q''^^'',,,q''^^'',,q''^^'',q''^^'',:CV1,:CV2,:CV3,:CV4,:CV5,:CV6,:CV7,:CV8,:CV9 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3,CV4,CV5,CV6,CV7,CV8,CV9;
     END IF;
  END;
END;
/

