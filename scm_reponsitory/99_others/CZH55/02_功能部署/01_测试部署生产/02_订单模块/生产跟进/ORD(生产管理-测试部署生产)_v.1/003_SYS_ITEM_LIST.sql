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
  CV7 CLOB:=q'[WITH group_dict AS
 (SELECT gd.group_dict_value, gd.group_dict_type, gd.group_dict_name
    FROM scmdata.sys_group_dict gd),
company_dict AS
 (SELECT cd.company_dict_value,
         cd.company_dict_type,
         cd.company_dict_name,
         cd.pause
    FROM scmdata.sys_company_dict cd
   WHERE cd.company_id = %default_company_id%),
company_user AS
 (SELECT company_id, user_id, company_user_name
    FROM sys_company_user
   WHERE company_id = %default_company_id%)
SELECT tc.commodity_info_id,
       tc.company_id,
       tc.style_pic,
       tc.supplier_code supplier_code_gd,
       tc.style_name,
       (SELECT SUPPLIER_COMPANY_NAME
          FROM SCMDATA.T_SUPPLIER_INFO
         WHERE SUPPLIER_CODE = TC.SUPPLIER_CODE
           AND COMPANY_ID = %DEFAULT_COMPANY_ID%) SUP_NAME_GD,
       tc.style_number,
       tc.sup_style_number,
       tc.goo_id,
       tc.rela_goo_id,
       tc.goo_name,
       tc.category,
       tc.product_cate,
       tc.samll_category,
       (SELECT GROUP_DICT_NAME
          FROM group_dict
         WHERE GROUP_DICT_TYPE = 'PRODUCT_TYPE'
           AND GROUP_DICT_VALUE = TC.CATEGORY) CATEGORY_GD,
       (SELECT GROUP_DICT_NAME
          FROM group_dict
         WHERE GROUP_DICT_TYPE = TC.CATEGORY
           AND GROUP_DICT_VALUE = TC.PRODUCT_CATE) PRODUCT_CATE_GD,
       (SELECT COMPANY_DICT_NAME
          FROM company_dict
         WHERE COMPANY_DICT_TYPE = TC.PRODUCT_CATE
           AND COMPANY_DICT_VALUE = TC.SAMLL_CATEGORY) SMALL_CATEGORY_GD,
       tc.year,
       tc.season,
       -- gd3.group_dict_name year_gd,
       (SELECT GROUP_DICT_NAME
          FROM group_dict
         WHERE GROUP_DICT_TYPE = 'GD_SESON'
           AND GROUP_DICT_VALUE = TC.SEASON) SEASON_GD,
       tc.inprice,
       tc.price price_gd,
       tc.color_list,
       (SELECT listagg(a.company_dict_name, ';') within GROUP(ORDER BY 1)
          FROM (SELECT regexp_substr(tc.color_list, '[^;]+', 1, LEVEL) color
                  FROM dual
                CONNECT BY LEVEL <= regexp_count(tc.color_list, '[^;]+')) t
         INNER JOIN company_dict a
            ON a.company_dict_value = t.color
         INNER JOIN company_dict b
            ON b.company_dict_type = 'GD_COLOR_LIST'
           AND b.company_dict_value = a.company_dict_type
           AND b.pause = 0) color_list_gd, --颜色组  键值，拆分，组合转换
       tc.size_list,
       (SELECT listagg(a.company_dict_name, ';') within GROUP(ORDER BY 1)
          FROM (SELECT regexp_substr(tc.size_list, '[^;]+', 1, LEVEL) size_gd
                  FROM dual
                CONNECT BY LEVEL <= regexp_count(tc.size_list, '[^;]+')) t
         INNER JOIN company_dict a
            ON a.company_dict_value = t.size_gd
         INNER JOIN company_dict b
            ON b.company_dict_type = 'GD_SIZE_LIST'
           AND b.company_dict_value = a.company_dict_type
           AND b.pause = 0) size_list_gd, --尺码组 键值，拆分，组合转换
       -- tc.base_size,
       tc.EXECUTIVE_STD,
       -- e.company_dict_name base_size_desc,
              (select listagg(composname || ' ' || pk, chr(10)) within group(order by seq)
  from (select k.composname,
               listagg(loadrate * 100 || '%' || ' ' || k.goo_raw || ' ' || k.memo,
                       ' ') within group(order by sort asc) pk,
                       Case k.ComPosName WHEN '面料1'    then 1
                               WHEN '面料2'    THEN 2
                               WHEN '面料'     THEN 3
                               WHEN '里料1'    then 4
                               When '里料2'    then 5
                               WHEN '里料'     THEN 6
                               when '侧翼面料' THEN 7
                               when '侧翼里料' THEN 8
                               when '罩杯里料' THEN 9
                               WHEN '表层'     THEN 10
                               WHEN '基布'     THEN 11
                               When '填充物'   then 12
                               when '填充量'   then 13
                               when '鞋面材质' then 14
                               when '鞋底材质' then 15
                               WHEN '帽里填充物' THEN 16
                               else 99 end seq
          from scmdata.t_commodity_composition k
         where k.commodity_info_id=tc.commodity_info_id
         group by k.composname
)) ||chr(10)||
       (select max(memo)
          from scmdata.t_commodity_composition k
         where k.commodity_info_id = tc.commodity_info_id) COMPOSNAME_LONG,
       nvl((SELECT COMPANY_USER_NAME
             FROM COMPANY_USER
            WHERE COMPANY_ID = TC.COMPANY_ID
              AND USER_ID = TC.CREATE_ID),
           TC.CREATE_ID) CREATE_ID,
       tc.create_time,
       (SELECT COMPANY_USER_NAME
          FROM COMPANY_USER
         WHERE COMPANY_ID = TC.COMPANY_ID
           AND USER_ID = TC.UPDATE_ID) UPDATE_ID,
            tc.update_time
  FROM (SELECT *
          FROM SCMDATA.T_COMMODITY_INFO
         WHERE (COMPANY_ID = %DEFAULT_COMPANY_ID%)
           AND (GOO_ID = %ASS_GOO_ID%)) tc
/*LEFT JOIN company_dict e
ON tc.base_size = e.company_dict_value*/]';
  CV8 CLOB:=q'[]';
  CV9 CLOB:=q'[]';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_ITEM_LIST WHERE ITEM_ID = ''a_good_130''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_ITEM_LIST SET (AUTO_REFRESH,BACK_GROUND_ID,EDIT_EXPRESS,END_FIELD,EXECUTE_TIME,FOOTER,HEADER,HINT_TYPE,JUMP_EXPRESS,JUMP_FIELD,MAX_ROW_COUNT,MONITOR_ID,MULTI_PAGE_FLAG,NOADD_FIELDS,NOEDIT_FIELDS,NOMODIFY_FIELDS,NOSHOW_APP_FIELDS,NOSHOW_FIELDS,OPEN_MODE,OPERATION_TYPE,OUTPUT_PARAMETER,QUERY_COUNT,QUERY_FIELDS,QUERY_TYPE,RFID_FLAG,SCANNABLE_FIELD,SCANNABLE_LOCATION_LINE,SCANNABLE_TIME,SCANNABLE_TYPE,SUBNOSHOW_FIELDS,SUB_EDIT_STATE,SUB_TABLE_JUDGE_FIELD,UI_TMPL,DELETE_SQL,DETAIL_SQL,INSERT_SQL,LOCK_SQL,NEWID_SQL,OPRETION_HINT,SELECT_SQL,SUBSELECT_SQL,UPDATE_SQL) = (SELECT ,q''[]'',q''[]'',q''[]'',,q''[]'',q''[]'',,q''[]'',q''[]'',,q''[]'',1,q''[]'',q''[]'',q''[]'',q''[]'',q''[commodity_info_id,company_id,season,base_size]'',,q''[]'',q''[]'',,q''[]'',,,q''[]'',q''[]'',,,q''[]'',,q''[]'',q''[]'',:CV1,:CV2,:CV3,:CV4,:CV5,:CV6,:CV7,:CV8,:CV9 FROM DUAL) WHERE ITEM_ID = ''a_good_130''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3,CV4,CV5,CV6,CV7,CV8,CV9;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_ITEM_LIST (AUTO_REFRESH,BACK_GROUND_ID,EDIT_EXPRESS,END_FIELD,EXECUTE_TIME,FOOTER,HEADER,HINT_TYPE,ITEM_ID,JUMP_EXPRESS,JUMP_FIELD,MAX_ROW_COUNT,MONITOR_ID,MULTI_PAGE_FLAG,NOADD_FIELDS,NOEDIT_FIELDS,NOMODIFY_FIELDS,NOSHOW_APP_FIELDS,NOSHOW_FIELDS,OPEN_MODE,OPERATION_TYPE,OUTPUT_PARAMETER,QUERY_COUNT,QUERY_FIELDS,QUERY_TYPE,RFID_FLAG,SCANNABLE_FIELD,SCANNABLE_LOCATION_LINE,SCANNABLE_TIME,SCANNABLE_TYPE,SUBNOSHOW_FIELDS,SUB_EDIT_STATE,SUB_TABLE_JUDGE_FIELD,UI_TMPL,DELETE_SQL,DETAIL_SQL,INSERT_SQL,LOCK_SQL,NEWID_SQL,OPRETION_HINT,SELECT_SQL,SUBSELECT_SQL,UPDATE_SQL) SELECT ,q''[]'',q''[]'',q''[]'',,q''[]'',q''[]'',,''a_good_130'',q''[]'',q''[]'',,q''[]'',1,q''[]'',q''[]'',q''[]'',q''[]'',q''[commodity_info_id,company_id,season,base_size]'',,q''[]'',q''[]'',,q''[]'',,,q''[]'',q''[]'',,,q''[]'',,q''[]'',q''[]'',:CV1,:CV2,:CV3,:CV4,:CV5,:CV6,:CV7,:CV8,:CV9 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3,CV4,CV5,CV6,CV7,CV8,CV9;
     END IF;
  END;
END;
/

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
  CV7 CLOB:=q'[SELECT tcs.commodity_color_size_id,
       tcs.commodity_info_id,
       tcs.company_id,
       tcs.goo_id,
       tcs.barcode,
       tcs.color_code,
       tcs.colorname,
       tcs.sizecode,
       tcs.sizename
  FROM scmdata.t_commodity_color_size tcs
 WHERE tcs.commodity_info_id = :commodity_info_id
 ORDER BY tcs.color_code asc,tcs.sizecode asc]';
  CV8 CLOB:=q'[]';
  CV9 CLOB:=q'[]';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_ITEM_LIST WHERE ITEM_ID = ''a_good_130_1''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_ITEM_LIST SET (AUTO_REFRESH,BACK_GROUND_ID,EDIT_EXPRESS,END_FIELD,EXECUTE_TIME,FOOTER,HEADER,HINT_TYPE,JUMP_EXPRESS,JUMP_FIELD,MAX_ROW_COUNT,MONITOR_ID,MULTI_PAGE_FLAG,NOADD_FIELDS,NOEDIT_FIELDS,NOMODIFY_FIELDS,NOSHOW_APP_FIELDS,NOSHOW_FIELDS,OPEN_MODE,OPERATION_TYPE,OUTPUT_PARAMETER,QUERY_COUNT,QUERY_FIELDS,QUERY_TYPE,RFID_FLAG,SCANNABLE_FIELD,SCANNABLE_LOCATION_LINE,SCANNABLE_TIME,SCANNABLE_TYPE,SUBNOSHOW_FIELDS,SUB_EDIT_STATE,SUB_TABLE_JUDGE_FIELD,UI_TMPL,DELETE_SQL,DETAIL_SQL,INSERT_SQL,LOCK_SQL,NEWID_SQL,OPRETION_HINT,SELECT_SQL,SUBSELECT_SQL,UPDATE_SQL) = (SELECT ,q''[]'',q''[]'',q''[]'',,q''[]'',q''[]'',,q''[]'',q''[]'',,q''[]'',1,q''[]'',q''[]'',q''[]'',q''[]'',q''[commodity_color_size_id,commodity_info_id,company_id,goo_id,color_code,sizecode]'',,q''[]'',q''[]'',,q''[]'',,,q''[]'',q''[]'',,,q''[]'',,q''[]'',q''[]'',:CV1,:CV2,:CV3,:CV4,:CV5,:CV6,:CV7,:CV8,:CV9 FROM DUAL) WHERE ITEM_ID = ''a_good_130_1''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3,CV4,CV5,CV6,CV7,CV8,CV9;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_ITEM_LIST (AUTO_REFRESH,BACK_GROUND_ID,EDIT_EXPRESS,END_FIELD,EXECUTE_TIME,FOOTER,HEADER,HINT_TYPE,ITEM_ID,JUMP_EXPRESS,JUMP_FIELD,MAX_ROW_COUNT,MONITOR_ID,MULTI_PAGE_FLAG,NOADD_FIELDS,NOEDIT_FIELDS,NOMODIFY_FIELDS,NOSHOW_APP_FIELDS,NOSHOW_FIELDS,OPEN_MODE,OPERATION_TYPE,OUTPUT_PARAMETER,QUERY_COUNT,QUERY_FIELDS,QUERY_TYPE,RFID_FLAG,SCANNABLE_FIELD,SCANNABLE_LOCATION_LINE,SCANNABLE_TIME,SCANNABLE_TYPE,SUBNOSHOW_FIELDS,SUB_EDIT_STATE,SUB_TABLE_JUDGE_FIELD,UI_TMPL,DELETE_SQL,DETAIL_SQL,INSERT_SQL,LOCK_SQL,NEWID_SQL,OPRETION_HINT,SELECT_SQL,SUBSELECT_SQL,UPDATE_SQL) SELECT ,q''[]'',q''[]'',q''[]'',,q''[]'',q''[]'',,''a_good_130_1'',q''[]'',q''[]'',,q''[]'',1,q''[]'',q''[]'',q''[]'',q''[]'',q''[commodity_color_size_id,commodity_info_id,company_id,goo_id,color_code,sizecode]'',,q''[]'',q''[]'',,q''[]'',,,q''[]'',q''[]'',,,q''[]'',,q''[]'',q''[]'',:CV1,:CV2,:CV3,:CV4,:CV5,:CV6,:CV7,:CV8,:CV9 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3,CV4,CV5,CV6,CV7,CV8,CV9;
     END IF;
  END;
END;
/

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
  CV7 CLOB:=q'[SELECT t.commodity_file_id,
       t.commodity_info_id,
       t.company_id,
       t.file_type,
       t.file_id,
       t.create_id,
       t.create_time,
       t.remarks,
       t.goo_id
  FROM scmdata.t_commodity_file t
 WHERE t.commodity_info_id = :commodity_info_id
 order by t.create_time asc]';
  CV8 CLOB:=q'[]';
  CV9 CLOB:=q'[]';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_ITEM_LIST WHERE ITEM_ID = ''a_good_130_4''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_ITEM_LIST SET (AUTO_REFRESH,BACK_GROUND_ID,EDIT_EXPRESS,END_FIELD,EXECUTE_TIME,FOOTER,HEADER,HINT_TYPE,JUMP_EXPRESS,JUMP_FIELD,MAX_ROW_COUNT,MONITOR_ID,MULTI_PAGE_FLAG,NOADD_FIELDS,NOEDIT_FIELDS,NOMODIFY_FIELDS,NOSHOW_APP_FIELDS,NOSHOW_FIELDS,OPEN_MODE,OPERATION_TYPE,OUTPUT_PARAMETER,QUERY_COUNT,QUERY_FIELDS,QUERY_TYPE,RFID_FLAG,SCANNABLE_FIELD,SCANNABLE_LOCATION_LINE,SCANNABLE_TIME,SCANNABLE_TYPE,SUBNOSHOW_FIELDS,SUB_EDIT_STATE,SUB_TABLE_JUDGE_FIELD,UI_TMPL,DELETE_SQL,DETAIL_SQL,INSERT_SQL,LOCK_SQL,NEWID_SQL,OPRETION_HINT,SELECT_SQL,SUBSELECT_SQL,UPDATE_SQL) = (SELECT ,q''[]'',q''[]'',q''[]'',,q''[]'',q''[]'',,q''[]'',q''[]'',,q''[]'',1,q''[]'',q''[]'',q''[]'',q''[]'',q''[commodity_info_id,company_id,commodity_file_id,remarks,goo_id]'',,q''[]'',q''[]'',,q''[]'',,,q''[]'',q''[]'',,,q''[]'',,q''[]'',q''[]'',:CV1,:CV2,:CV3,:CV4,:CV5,:CV6,:CV7,:CV8,:CV9 FROM DUAL) WHERE ITEM_ID = ''a_good_130_4''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3,CV4,CV5,CV6,CV7,CV8,CV9;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_ITEM_LIST (AUTO_REFRESH,BACK_GROUND_ID,EDIT_EXPRESS,END_FIELD,EXECUTE_TIME,FOOTER,HEADER,HINT_TYPE,ITEM_ID,JUMP_EXPRESS,JUMP_FIELD,MAX_ROW_COUNT,MONITOR_ID,MULTI_PAGE_FLAG,NOADD_FIELDS,NOEDIT_FIELDS,NOMODIFY_FIELDS,NOSHOW_APP_FIELDS,NOSHOW_FIELDS,OPEN_MODE,OPERATION_TYPE,OUTPUT_PARAMETER,QUERY_COUNT,QUERY_FIELDS,QUERY_TYPE,RFID_FLAG,SCANNABLE_FIELD,SCANNABLE_LOCATION_LINE,SCANNABLE_TIME,SCANNABLE_TYPE,SUBNOSHOW_FIELDS,SUB_EDIT_STATE,SUB_TABLE_JUDGE_FIELD,UI_TMPL,DELETE_SQL,DETAIL_SQL,INSERT_SQL,LOCK_SQL,NEWID_SQL,OPRETION_HINT,SELECT_SQL,SUBSELECT_SQL,UPDATE_SQL) SELECT ,q''[]'',q''[]'',q''[]'',,q''[]'',q''[]'',,''a_good_130_4'',q''[]'',q''[]'',,q''[]'',1,q''[]'',q''[]'',q''[]'',q''[]'',q''[commodity_info_id,company_id,commodity_file_id,remarks,goo_id]'',,q''[]'',q''[]'',,q''[]'',,,q''[]'',q''[]'',,,q''[]'',,q''[]'',q''[]'',:CV1,:CV2,:CV3,:CV4,:CV5,:CV6,:CV7,:CV8,:CV9 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3,CV4,CV5,CV6,CV7,CV8,CV9;
     END IF;
  END;
END;
/

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
  CV7 CLOB:=q'[select a.commodity_composition_id,
       a.commodity_info_id,
       a.composname,
       a.goo_raw,
       a.loadrate,
       a.memo
  from scmdata.t_commodity_composition a
  where a.commodity_info_id=:commodity_info_id]';
  CV8 CLOB:=q'[]';
  CV9 CLOB:=q'[]';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_ITEM_LIST WHERE ITEM_ID = ''a_good_130_5''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_ITEM_LIST SET (AUTO_REFRESH,BACK_GROUND_ID,EDIT_EXPRESS,END_FIELD,EXECUTE_TIME,FOOTER,HEADER,HINT_TYPE,JUMP_EXPRESS,JUMP_FIELD,MAX_ROW_COUNT,MONITOR_ID,MULTI_PAGE_FLAG,NOADD_FIELDS,NOEDIT_FIELDS,NOMODIFY_FIELDS,NOSHOW_APP_FIELDS,NOSHOW_FIELDS,OPEN_MODE,OPERATION_TYPE,OUTPUT_PARAMETER,QUERY_COUNT,QUERY_FIELDS,QUERY_TYPE,RFID_FLAG,SCANNABLE_FIELD,SCANNABLE_LOCATION_LINE,SCANNABLE_TIME,SCANNABLE_TYPE,SUBNOSHOW_FIELDS,SUB_EDIT_STATE,SUB_TABLE_JUDGE_FIELD,UI_TMPL,DELETE_SQL,DETAIL_SQL,INSERT_SQL,LOCK_SQL,NEWID_SQL,OPRETION_HINT,SELECT_SQL,SUBSELECT_SQL,UPDATE_SQL) = (SELECT ,q''[]'',q''[]'',q''[]'',,q''[]'',q''[]'',,q''[]'',q''[]'',,q''[]'',1,q''[]'',q''[]'',q''[]'',q''[]'',q''[commodity_composition_id,commodity_info_id]'',,q''[]'',q''[]'',,q''[]'',,,q''[]'',q''[]'',,,q''[]'',,q''[]'',q''[]'',:CV1,:CV2,:CV3,:CV4,:CV5,:CV6,:CV7,:CV8,:CV9 FROM DUAL) WHERE ITEM_ID = ''a_good_130_5''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3,CV4,CV5,CV6,CV7,CV8,CV9;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_ITEM_LIST (AUTO_REFRESH,BACK_GROUND_ID,EDIT_EXPRESS,END_FIELD,EXECUTE_TIME,FOOTER,HEADER,HINT_TYPE,ITEM_ID,JUMP_EXPRESS,JUMP_FIELD,MAX_ROW_COUNT,MONITOR_ID,MULTI_PAGE_FLAG,NOADD_FIELDS,NOEDIT_FIELDS,NOMODIFY_FIELDS,NOSHOW_APP_FIELDS,NOSHOW_FIELDS,OPEN_MODE,OPERATION_TYPE,OUTPUT_PARAMETER,QUERY_COUNT,QUERY_FIELDS,QUERY_TYPE,RFID_FLAG,SCANNABLE_FIELD,SCANNABLE_LOCATION_LINE,SCANNABLE_TIME,SCANNABLE_TYPE,SUBNOSHOW_FIELDS,SUB_EDIT_STATE,SUB_TABLE_JUDGE_FIELD,UI_TMPL,DELETE_SQL,DETAIL_SQL,INSERT_SQL,LOCK_SQL,NEWID_SQL,OPRETION_HINT,SELECT_SQL,SUBSELECT_SQL,UPDATE_SQL) SELECT ,q''[]'',q''[]'',q''[]'',,q''[]'',q''[]'',,''a_good_130_5'',q''[]'',q''[]'',,q''[]'',1,q''[]'',q''[]'',q''[]'',q''[]'',q''[commodity_composition_id,commodity_info_id]'',,q''[]'',q''[]'',,q''[]'',,,q''[]'',q''[]'',,,q''[]'',,q''[]'',q''[]'',:CV1,:CV2,:CV3,:CV4,:CV5,:CV6,:CV7,:CV8,:CV9 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3,CV4,CV5,CV6,CV7,CV8,CV9;
     END IF;
  END;
END;
/

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
  CV7 CLOB:=q'[WITH supp AS
 (SELECT sp.company_id, sp.supplier_code, sp.supplier_company_name
    FROM scmdata.t_supplier_info sp),
group_dict AS
 (SELECT group_dict_type, group_dict_value, group_dict_name
    FROM scmdata.sys_group_dict)
SELECT t.product_gress_id,
       t.company_id,
       t.progress_status progress_status_pr,
       t.product_gress_code product_gress_code_pr,
       decode(t.progress_status,
              '02',
              (SELECT pno_status
                 FROM (SELECT pn.node_name ||
                              (SELECT a.group_dict_name
                                 FROM group_dict a
                                INNER JOIN group_dict b
                                   ON a.group_dict_type = b.group_dict_value
                                  AND b.group_dict_value = 'PROGRESS_NODE_TYPE'
                                WHERE a.group_dict_value = pn.progress_status) pno_status
                         FROM scmdata.t_production_node pn
                        WHERE pn.company_id = t.company_id
                          AND pn.product_gress_id = t.product_gress_id
                          AND pn.progress_status IS NOT NULL
                        ORDER BY pn.node_num DESC)
                WHERE rownum = 1),
              '00',
              (SELECT a.group_dict_name
                 FROM group_dict a
                WHERE a.group_dict_type = 'PROGRESS_TYPE'
                  AND a.group_dict_value = t.progress_status)) progress_status_desc,
       t.order_id order_id_pr,
       cf.rela_goo_id,
       cf.style_number style_number_pr,
       cf.style_name style_name_pr,
       t.supplier_code supplier_code_pr,
       sp2.supplier_company_name supplier_company_name_pr,
       t.factory_code factory_code_pr,
       sp1.supplier_company_name factory_company_name_pr,
       nvl(MAX(od.delivery_date) over(PARTITION BY od.order_id),
           od.delivery_date) delivery_date_pr, --最新计划交期,有值时取‘最新计划交期’，无则取‘计划交期’
       t.forecast_delivery_date forecast_delivery_date_pr,
       decode(sign(ceil(t.forecast_delivery_date - od.delivery_date)),
              -1,
              0,
              ceil(t.forecast_delivery_date - od.delivery_date)) forecast_delay_day_pr,
       t.latest_planned_delivery_date latest_planned_delivery_date_pr,
       t.actual_delivery_date actual_delivery_date_pr,
       t.actual_delay_day actual_delay_day_pr,
       t.order_amount order_amount_pr,
       t.delivery_amount delivery_amount_pr,
       decode(sign(t.order_amount - t.delivery_amount),
              -1,
              0,
              t.order_amount - t.delivery_amount) owe_amount_pr,
       nvl(t.order_full_rate,0) order_full_rate_pr,
       --t.order_status order_status_pr,
       t.delay_problem_class delay_problem_class_pr,
       t.delay_cause_class delay_cause_class_pr,
       t.delay_cause_detailed delay_cause_detailed_pr,
       t.problem_desc problem_desc_pr,
       t.is_sup_responsible,
       t.responsible_dept,
       t.responsible_dept_sec,
       t.approve_edition, --Edit by zc
       t.fabric_check fabric_check,
       t.qc_check qc_check_pr,
       t.qa_check qa_check_pr,
       decode(t.exception_handle_status,
              '01',
              '处理中',
              '02',
              '已处理',
              '无异常') exception_handle_status_pr,
       (SELECT gd.group_dict_name
          FROM group_dict gd
         WHERE gd.group_dict_type = 'HANDLE_RESULT'
           AND gd.group_dict_value = t.handle_opinions) handle_opinions_pr,
       t.goo_id goo_id_pr --这里goo_id是货号
  FROM scmdata.t_ordered oh
 INNER JOIN scmdata.t_orders od
    ON oh.company_id = od.company_id
   AND oh.order_code = od.order_id
   AND oh.order_status = 'OS01' --待修改
 INNER JOIN t_production_progress t
    ON t.company_id = od.company_id
   AND t.order_id = od.order_id
   AND t.goo_id = od.goo_id
   AND t.progress_status <> '01'
 INNER JOIN scmdata.t_commodity_info cf
    ON t.company_id = cf.company_id
   AND t.goo_id = cf.goo_id
  LEFT JOIN supp sp1
    ON t.company_id = sp1.company_id
   AND t.factory_code = sp1.supplier_code
 INNER JOIN supp sp2
    ON t.company_id = sp2.company_id
   AND t.supplier_code = sp2.supplier_code
 WHERE oh.company_id = %default_company_id%
 ORDER BY t.create_time DESC]';
  CV8 CLOB:=q'[]';
  CV9 CLOB:=q'[DECLARE
  v_is_sup_exemption NUMBER;
  v_first_dept_id    VARCHAR2(100);
  v_second_dept_id   VARCHAR2(100);
BEGIN
  SELECT ad.is_sup_exemption, (SELECT sd.dept_name
            FROM scmdata.sys_company_dept sd
           WHERE sd.company_id = ad.company_id
             AND sd.company_dept_id = ad.first_dept_id) first_dept_name,
         (SELECT sd.dept_name
            FROM scmdata.sys_company_dept sd
           WHERE sd.company_id = ad.company_id
             AND sd.company_dept_id = ad.second_dept_id) second_dept_name
    INTO v_is_sup_exemption, v_first_dept_id, v_second_dept_id
    FROM scmdata.t_commodity_info tc
   INNER JOIN scmdata.t_abnormal_range_config ar
      ON tc.company_id = ar.company_id
     AND tc.category = ar.industry_classification
     AND tc.product_cate = ar.production_category
     AND instr(';' || ar.product_subclass || ';',
               ';' || tc.samll_category || ';') > 0
     AND ar.pause = 0
   INNER JOIN scmdata.t_abnormal_dtl_config ad
      ON ar.company_id = ad.company_id
     AND ar.abnormal_config_id = ad.abnormal_config_id
     AND ad.pause = 0
   INNER JOIN scmdata.t_abnormal_config ab
      ON ab.company_id = ad.company_id
     AND ab.abnormal_config_id = ad.abnormal_config_id
     AND ab.pause = 0
   WHERE tc.company_id = :company_id
     AND tc.goo_id = :goo_id_pr
     AND ad.anomaly_classification = 'AC_DATE'
     AND ad.problem_classification = :delay_problem_class_pr
     AND ad.cause_classification = :delay_cause_class_pr
     AND ad.cause_detail = :delay_cause_detailed_pr;

     --增加校验逻辑：延期问题分类、延期原因分类、延期原因细分有值，则问题描述必填
    IF :delay_problem_class_pr IS NOT NULL AND :delay_cause_class_pr IS NOT NULL AND :delay_cause_detailed_pr IS NOT NULL THEN
       IF :problem_desc_pr IS NULL THEN
          raise_application_error(-20002,
                                    '提示：延期问题分类、延期原因分类、延期原因细分有值，则问题描述必填！');
       ELSE
          NULL;
       END IF;
    END IF;

  UPDATE scmdata.t_production_progress t
     SET t.delay_problem_class  = :delay_problem_class_pr,
         t.delay_cause_class    = :delay_cause_class_pr,
         t.delay_cause_detailed = :delay_cause_detailed_pr,
         t.problem_desc         = :problem_desc_pr,
         t.is_sup_responsible   = v_is_sup_exemption,
         t.responsible_dept     = v_first_dept_id,
         t.responsible_dept_sec = v_second_dept_id
   WHERE t.product_gress_id = :product_gress_id;

END;]';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_ITEM_LIST WHERE ITEM_ID = ''a_product_110''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_ITEM_LIST SET (AUTO_REFRESH,BACK_GROUND_ID,EDIT_EXPRESS,END_FIELD,EXECUTE_TIME,FOOTER,HEADER,HINT_TYPE,JUMP_EXPRESS,JUMP_FIELD,MAX_ROW_COUNT,MONITOR_ID,MULTI_PAGE_FLAG,NOADD_FIELDS,NOEDIT_FIELDS,NOMODIFY_FIELDS,NOSHOW_APP_FIELDS,NOSHOW_FIELDS,OPEN_MODE,OPERATION_TYPE,OUTPUT_PARAMETER,QUERY_COUNT,QUERY_FIELDS,QUERY_TYPE,RFID_FLAG,SCANNABLE_FIELD,SCANNABLE_LOCATION_LINE,SCANNABLE_TIME,SCANNABLE_TYPE,SUBNOSHOW_FIELDS,SUB_EDIT_STATE,SUB_TABLE_JUDGE_FIELD,UI_TMPL,DELETE_SQL,DETAIL_SQL,INSERT_SQL,LOCK_SQL,NEWID_SQL,OPRETION_HINT,SELECT_SQL,SUBSELECT_SQL,UPDATE_SQL) = (SELECT 1,q''[]'',q''[]'',q''[]'',,q''[]'',q''[]'',,q''[]'',q''[]'',,q''[]'',1,q''[]'',q''[]'',q''[]'',q''[]'',q''[fabric_check,product_gress_id,company_id,supplier_code_pr,factory_code_pr,order_id_pr,progress_status_pr,qc_check_pr,qa_check_pr,approve_edition,is_sup_responsible,responsible_dept,responsible_dept_sec]'',,q''[]'',q''[]'',,q''[product_gress_code_pr,rela_goo_id]'',13,,q''[]'',q''[]'',,,q''[]'',,q''[]'',q''[]'',:CV1,:CV2,:CV3,:CV4,:CV5,:CV6,:CV7,:CV8,:CV9 FROM DUAL) WHERE ITEM_ID = ''a_product_110''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3,CV4,CV5,CV6,CV7,CV8,CV9;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_ITEM_LIST (AUTO_REFRESH,BACK_GROUND_ID,EDIT_EXPRESS,END_FIELD,EXECUTE_TIME,FOOTER,HEADER,HINT_TYPE,ITEM_ID,JUMP_EXPRESS,JUMP_FIELD,MAX_ROW_COUNT,MONITOR_ID,MULTI_PAGE_FLAG,NOADD_FIELDS,NOEDIT_FIELDS,NOMODIFY_FIELDS,NOSHOW_APP_FIELDS,NOSHOW_FIELDS,OPEN_MODE,OPERATION_TYPE,OUTPUT_PARAMETER,QUERY_COUNT,QUERY_FIELDS,QUERY_TYPE,RFID_FLAG,SCANNABLE_FIELD,SCANNABLE_LOCATION_LINE,SCANNABLE_TIME,SCANNABLE_TYPE,SUBNOSHOW_FIELDS,SUB_EDIT_STATE,SUB_TABLE_JUDGE_FIELD,UI_TMPL,DELETE_SQL,DETAIL_SQL,INSERT_SQL,LOCK_SQL,NEWID_SQL,OPRETION_HINT,SELECT_SQL,SUBSELECT_SQL,UPDATE_SQL) SELECT 1,q''[]'',q''[]'',q''[]'',,q''[]'',q''[]'',,''a_product_110'',q''[]'',q''[]'',,q''[]'',1,q''[]'',q''[]'',q''[]'',q''[]'',q''[fabric_check,product_gress_id,company_id,supplier_code_pr,factory_code_pr,order_id_pr,progress_status_pr,qc_check_pr,qa_check_pr,approve_edition,is_sup_responsible,responsible_dept,responsible_dept_sec]'',,q''[]'',q''[]'',,q''[product_gress_code_pr,rela_goo_id]'',13,,q''[]'',q''[]'',,,q''[]'',,q''[]'',q''[]'',:CV1,:CV2,:CV3,:CV4,:CV5,:CV6,:CV7,:CV8,:CV9 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3,CV4,CV5,CV6,CV7,CV8,CV9;
     END IF;
  END;
END;
/

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
  CV7 CLOB:=q'[WITH group_dict AS
 (SELECT group_dict_type, group_dict_value, group_dict_name
    FROM scmdata.sys_group_dict),
company_user AS
 (SELECT company_id, user_id, company_user_name
    FROM sys_company_user
   WHERE company_id = %default_company_id%
     AND user_id = :user_id)
SELECT t.product_node_id,
       t.company_id,
       t.product_gress_id,
       pp.PROGRESS_STATUS PROGRESS_STATUS_PR,
       t.product_node_code,
       t.node_num,
       t.node_name node_name_pr,
       t.time_ratio time_ratio_pr,
       t.target_completion_time target_completion_time_pr,
       t.plan_completion_time plan_completion_time_pr,
       t.actual_completion_time actual_completion_time_pr,
       t.complete_amount complete_amount_pr,
       t.progress_status product_node_status_pr,
       (SELECT a.group_dict_name
          FROM group_dict a
         WHERE a.group_dict_type = 'PROGRESS_NODE_TYPE'
           AND a.group_dict_value = t.progress_status) product_node_status,
       t.progress_say progress_say_pr,
       t.operator,
       b.company_user_name update_id_pr,
       t.update_date update_date_pr
  FROM scmdata.t_production_progress pp
 INNER JOIN scmdata.t_production_node t
    ON pp.product_gress_id = t.product_gress_id
 LEFT JOIN company_user b
    ON b.company_id = t.company_id
    and b.user_id = t.update_id
 WHERE pp.company_id = %default_company_id%
   AND pp.product_gress_id = :product_gress_id
 ORDER BY t.node_num ASC]';
  CV8 CLOB:=q'[]';
  CV9 CLOB:=q'[DECLARE
  pno_rec scmdata.t_production_node%ROWTYPE;
BEGIN
  pno_rec.product_node_id        := :product_node_id;
  pno_rec.company_id             := :company_id;
  pno_rec.product_gress_id       := :product_gress_id;
  pno_rec.product_node_code      := :product_node_code;
  pno_rec.node_num               := :node_num;
  pno_rec.node_name              := :node_name_pr;
  pno_rec.plan_completion_time   := :plan_completion_time_pr;
  pno_rec.actual_completion_time := :actual_completion_time_pr;
  pno_rec.complete_amount        := :complete_amount_pr;
  pno_rec.progress_status        := :product_node_status_pr;
  pno_rec.progress_say           := :progress_say_pr;
  pno_rec.update_id              := :user_id;
  pno_rec.update_date            := SYSDATE;

 SELECT fc.logn_name
    INTO pno_rec.operator
    FROM scmdata.sys_company fc
   WHERE fc.company_id = %default_company_id%;

  scmdata.pkg_production_progress.update_production_node(pno_rec => pno_rec);

END;]';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_ITEM_LIST WHERE ITEM_ID = ''a_product_111''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_ITEM_LIST SET (AUTO_REFRESH,BACK_GROUND_ID,EDIT_EXPRESS,END_FIELD,EXECUTE_TIME,FOOTER,HEADER,HINT_TYPE,JUMP_EXPRESS,JUMP_FIELD,MAX_ROW_COUNT,MONITOR_ID,MULTI_PAGE_FLAG,NOADD_FIELDS,NOEDIT_FIELDS,NOMODIFY_FIELDS,NOSHOW_APP_FIELDS,NOSHOW_FIELDS,OPEN_MODE,OPERATION_TYPE,OUTPUT_PARAMETER,QUERY_COUNT,QUERY_FIELDS,QUERY_TYPE,RFID_FLAG,SCANNABLE_FIELD,SCANNABLE_LOCATION_LINE,SCANNABLE_TIME,SCANNABLE_TYPE,SUBNOSHOW_FIELDS,SUB_EDIT_STATE,SUB_TABLE_JUDGE_FIELD,UI_TMPL,DELETE_SQL,DETAIL_SQL,INSERT_SQL,LOCK_SQL,NEWID_SQL,OPRETION_HINT,SELECT_SQL,SUBSELECT_SQL,UPDATE_SQL) = (SELECT 4,q''[]'',q''[progress_status_pr != ''01'']'',q''[]'',,q''[]'',q''[]'',,q''[]'',q''[]'',,q''[]'',1,q''[]'',q''[]'',q''[]'',q''[]'',q''[product_node_id,company_id,product_gress_id,product_node_code,node_num,product_node_status,PROGRESS_STATUS_PR]'',,q''[]'',q''[]'',,q''[]'',0,,q''[]'',q''[]'',,,q''[]'',,q''[]'',q''[]'',:CV1,:CV2,:CV3,:CV4,:CV5,:CV6,:CV7,:CV8,:CV9 FROM DUAL) WHERE ITEM_ID = ''a_product_111''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3,CV4,CV5,CV6,CV7,CV8,CV9;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_ITEM_LIST (AUTO_REFRESH,BACK_GROUND_ID,EDIT_EXPRESS,END_FIELD,EXECUTE_TIME,FOOTER,HEADER,HINT_TYPE,ITEM_ID,JUMP_EXPRESS,JUMP_FIELD,MAX_ROW_COUNT,MONITOR_ID,MULTI_PAGE_FLAG,NOADD_FIELDS,NOEDIT_FIELDS,NOMODIFY_FIELDS,NOSHOW_APP_FIELDS,NOSHOW_FIELDS,OPEN_MODE,OPERATION_TYPE,OUTPUT_PARAMETER,QUERY_COUNT,QUERY_FIELDS,QUERY_TYPE,RFID_FLAG,SCANNABLE_FIELD,SCANNABLE_LOCATION_LINE,SCANNABLE_TIME,SCANNABLE_TYPE,SUBNOSHOW_FIELDS,SUB_EDIT_STATE,SUB_TABLE_JUDGE_FIELD,UI_TMPL,DELETE_SQL,DETAIL_SQL,INSERT_SQL,LOCK_SQL,NEWID_SQL,OPRETION_HINT,SELECT_SQL,SUBSELECT_SQL,UPDATE_SQL) SELECT 4,q''[]'',q''[progress_status_pr != ''01'']'',q''[]'',,q''[]'',q''[]'',,''a_product_111'',q''[]'',q''[]'',,q''[]'',1,q''[]'',q''[]'',q''[]'',q''[]'',q''[product_node_id,company_id,product_gress_id,product_node_code,node_num,product_node_status,PROGRESS_STATUS_PR]'',,q''[]'',q''[]'',,q''[]'',0,,q''[]'',q''[]'',,,q''[]'',,q''[]'',q''[]'',:CV1,:CV2,:CV3,:CV4,:CV5,:CV6,:CV7,:CV8,:CV9 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3,CV4,CV5,CV6,CV7,CV8,CV9;
     END IF;
  END;
END;
/

BEGIN
  DECLARE
    JUDGE_N NUMBER(4);
    EXE_SQL CLOB;
    VALS    CLOB;
  CV1 CLOB:=q'[DECLARE
  p_delivery_rec scmdata.t_delivery_record%rowtype;
  v_order_id             VARCHAR2(32);
  v_goo_id               VARCHAR2(32);

BEGIN


DELETE FROM t_delivery_record t
 WHERE t.company_id = %default_company_id%
   AND t.delivery_record_id = :delivery_record_id;

  SELECT pr.order_id, pr.goo_id
    INTO v_order_id, v_goo_id
    FROM scmdata.t_production_progress pr
   WHERE pr.product_gress_id = :product_gress_id;

  p_delivery_rec.company_id := %default_company_id%;
  p_delivery_rec.order_code := v_order_id;
  p_delivery_rec.goo_id     := v_goo_id;

  pkg_production_progress.sync_delivery_record(p_delivery_rec => p_delivery_rec);

END;]';
  CV2 CLOB:=q'[]';
  CV3 CLOB:=q'[DECLARE
  v_delivery_record_code VARCHAR2(32);
  v_ing_id               VARCHAR2(32);
  v_order_id             VARCHAR2(32);
  v_goo_id               VARCHAR2(32);
  p_delivery_rec         scmdata.t_delivery_record%ROWTYPE;
BEGIN
  v_delivery_record_code := pkg_plat_comm.f_getkeycode(pi_table_name  => 't_delivery_record',
                                                       pi_column_name => 'delivery_record_code',
                                                       pi_company_id  => %default_company_id%,
                                                       pi_pre         => 'DR',
                                                       pi_serail_num  => '6');

  v_ing_id := pkg_plat_comm.f_getkeycode(pi_table_name  => 't_delivery_record',
                                         pi_column_name => 'ing_id',
                                         pi_company_id  => %default_company_id%,
                                         pi_pre         => 'WMS',
                                         pi_serail_num  => '6');

  SELECT pr.order_id, pr.goo_id
    INTO v_order_id, v_goo_id
    FROM scmdata.t_production_progress pr
   WHERE pr.product_gress_id = :product_gress_id;

  INSERT INTO scmdata.t_delivery_record
    (delivery_record_id,
     company_id,
     delivery_record_code,
     order_code,
     ing_id,
     goo_id,
     delivery_price,
     delivery_amount,
     create_id,
     create_time,
     memo,
     delivery_date,
     accept_date,
     sorting_date,
     shipment_date,
     update_id,
     update_time,
     asn_id,
     predict_delivery_amount)
  VALUES
    (scmdata.f_get_uuid(),
     %default_company_id%,
     v_delivery_record_code,
     v_order_id,
     NULL,
     v_goo_id,
     nvl(:delivery_price, 0),
     :delivery_amount_kr,
     :user_id,
     SYSDATE,
     NULL,
     :delivery_time_pr,
     :accept_date,
     :sorting_date,
     :shipment_date,
     NULL,
     NULL,
     :asn_id,
     :predict_delivery_amount);

  p_delivery_rec.company_id := %default_company_id%;
  p_delivery_rec.order_code := v_order_id;
  p_delivery_rec.goo_id     := v_goo_id;

  pkg_production_progress.sync_delivery_record(p_delivery_rec => p_delivery_rec);

END;]';
  CV4 CLOB:=q'[]';
  CV5 CLOB:=q'[]';
  CV6 CLOB:=q'[]';
  CV7 CLOB:=q'[SELECT t.delivery_record_id,
       t.company_id,
       t.order_code         order_code_pr,
       t.goo_id             goo_id_pr,
       t.asn_id,
       t.predict_delivery_amount,
       t.delivery_amount         delivery_amount_kr,
       t.delivery_date           delivery_time_pr,
       t.accept_date,
       t.sorting_date,
       t.shipment_date,
       :progress_status_pr       progress_status_pr
  FROM t_delivery_record t
 WHERE t.company_id = %default_company_id%
   AND t.order_code = :order_id_pr
   AND t.goo_id = :goo_id_pr]';
  CV8 CLOB:=q'[]';
  CV9 CLOB:=q'[DECLARE
  p_delivery_rec scmdata.t_delivery_record%ROWTYPE;
  v_order_id     VARCHAR2(32);
  v_goo_id       VARCHAR2(32);

BEGIN

  SELECT pr.order_id, pr.goo_id
    INTO v_order_id, v_goo_id
    FROM scmdata.t_production_progress pr
   WHERE pr.product_gress_id = :product_gress_id;

  UPDATE t_delivery_record t
     SET t.delivery_amount = :delivery_amount_kr,
         t.delivery_date   = :delivery_time_pr,
         t.accept_date     = :accept_date,
         t.sorting_date    = :sorting_date,
         t.shipment_date   = :shipment_date
   WHERE t.company_id = %default_company_id%
     AND t.delivery_record_id = :delivery_record_id;

  p_delivery_rec.company_id := %default_company_id%;
  p_delivery_rec.order_code := v_order_id;
  p_delivery_rec.goo_id     := v_goo_id;

  pkg_production_progress.sync_delivery_record(p_delivery_rec => p_delivery_rec);

END;]';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_ITEM_LIST WHERE ITEM_ID = ''a_product_112''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_ITEM_LIST SET (AUTO_REFRESH,BACK_GROUND_ID,EDIT_EXPRESS,END_FIELD,EXECUTE_TIME,FOOTER,HEADER,HINT_TYPE,JUMP_EXPRESS,JUMP_FIELD,MAX_ROW_COUNT,MONITOR_ID,MULTI_PAGE_FLAG,NOADD_FIELDS,NOEDIT_FIELDS,NOMODIFY_FIELDS,NOSHOW_APP_FIELDS,NOSHOW_FIELDS,OPEN_MODE,OPERATION_TYPE,OUTPUT_PARAMETER,QUERY_COUNT,QUERY_FIELDS,QUERY_TYPE,RFID_FLAG,SCANNABLE_FIELD,SCANNABLE_LOCATION_LINE,SCANNABLE_TIME,SCANNABLE_TYPE,SUBNOSHOW_FIELDS,SUB_EDIT_STATE,SUB_TABLE_JUDGE_FIELD,UI_TMPL,DELETE_SQL,DETAIL_SQL,INSERT_SQL,LOCK_SQL,NEWID_SQL,OPRETION_HINT,SELECT_SQL,SUBSELECT_SQL,UPDATE_SQL) = (SELECT 4,q''[]'',q''[progress_status_pr != ''01'']'',q''[]'',,q''[]'',q''[]'',,q''[]'',q''[]'',,q''[]'',1,q''[]'',q''[]'',q''[]'',q''[]'',q''[delivery_record_id,company_id,order_code_pr,goo_id_pr,PROGRESS_STATUS_PR]'',,q''[]'',q''[]'',,q''[]'',0,,q''[]'',q''[]'',,,q''[]'',,q''[]'',q''[]'',:CV1,:CV2,:CV3,:CV4,:CV5,:CV6,:CV7,:CV8,:CV9 FROM DUAL) WHERE ITEM_ID = ''a_product_112''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3,CV4,CV5,CV6,CV7,CV8,CV9;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_ITEM_LIST (AUTO_REFRESH,BACK_GROUND_ID,EDIT_EXPRESS,END_FIELD,EXECUTE_TIME,FOOTER,HEADER,HINT_TYPE,ITEM_ID,JUMP_EXPRESS,JUMP_FIELD,MAX_ROW_COUNT,MONITOR_ID,MULTI_PAGE_FLAG,NOADD_FIELDS,NOEDIT_FIELDS,NOMODIFY_FIELDS,NOSHOW_APP_FIELDS,NOSHOW_FIELDS,OPEN_MODE,OPERATION_TYPE,OUTPUT_PARAMETER,QUERY_COUNT,QUERY_FIELDS,QUERY_TYPE,RFID_FLAG,SCANNABLE_FIELD,SCANNABLE_LOCATION_LINE,SCANNABLE_TIME,SCANNABLE_TYPE,SUBNOSHOW_FIELDS,SUB_EDIT_STATE,SUB_TABLE_JUDGE_FIELD,UI_TMPL,DELETE_SQL,DETAIL_SQL,INSERT_SQL,LOCK_SQL,NEWID_SQL,OPRETION_HINT,SELECT_SQL,SUBSELECT_SQL,UPDATE_SQL) SELECT 4,q''[]'',q''[progress_status_pr != ''01'']'',q''[]'',,q''[]'',q''[]'',,''a_product_112'',q''[]'',q''[]'',,q''[]'',1,q''[]'',q''[]'',q''[]'',q''[]'',q''[delivery_record_id,company_id,order_code_pr,goo_id_pr,PROGRESS_STATUS_PR]'',,q''[]'',q''[]'',,q''[]'',0,,q''[]'',q''[]'',,,q''[]'',,q''[]'',q''[]'',:CV1,:CV2,:CV3,:CV4,:CV5,:CV6,:CV7,:CV8,:CV9 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3,CV4,CV5,CV6,CV7,CV8,CV9;
     END IF;
  END;
END;
/

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
  CV7 CLOB:=q'[select t.delivery_record_item_id,
       t.goo_id,
       t.barcode,
       tcs.colorname,
       tcs.sizename,
       t.PREDICT_DELIVERY_AMOUNT,
       t.delivery_amount DELIVERY_AMOUNT_KR,
       t.accept_date,
       t.sorting_date,
       t.shipment_date
  from scmdata.t_delivery_record_item t
   INNER JOIN scmdata.t_commodity_color_size tcs
    ON tcs.goo_id = t.goo_id
   AND t.barcode = tcs.barcode
 where t.delivery_record_id = %ass_delivery_record_id%]';
  CV8 CLOB:=q'[]';
  CV9 CLOB:=q'[]';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_ITEM_LIST WHERE ITEM_ID = ''a_product_112_1''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_ITEM_LIST SET (AUTO_REFRESH,BACK_GROUND_ID,EDIT_EXPRESS,END_FIELD,EXECUTE_TIME,FOOTER,HEADER,HINT_TYPE,JUMP_EXPRESS,JUMP_FIELD,MAX_ROW_COUNT,MONITOR_ID,MULTI_PAGE_FLAG,NOADD_FIELDS,NOEDIT_FIELDS,NOMODIFY_FIELDS,NOSHOW_APP_FIELDS,NOSHOW_FIELDS,OPEN_MODE,OPERATION_TYPE,OUTPUT_PARAMETER,QUERY_COUNT,QUERY_FIELDS,QUERY_TYPE,RFID_FLAG,SCANNABLE_FIELD,SCANNABLE_LOCATION_LINE,SCANNABLE_TIME,SCANNABLE_TYPE,SUBNOSHOW_FIELDS,SUB_EDIT_STATE,SUB_TABLE_JUDGE_FIELD,UI_TMPL,DELETE_SQL,DETAIL_SQL,INSERT_SQL,LOCK_SQL,NEWID_SQL,OPRETION_HINT,SELECT_SQL,SUBSELECT_SQL,UPDATE_SQL) = (SELECT ,q''[]'',q''[]'',q''[]'',,q''[]'',q''[]'',,q''[]'',q''[]'',,q''[]'',1,q''[]'',q''[]'',q''[]'',q''[]'',q''[delivery_record_item_id,goo_id]'',,q''[]'',q''[]'',,q''[]'',,,q''[]'',q''[]'',,,q''[]'',,q''[]'',q''[]'',:CV1,:CV2,:CV3,:CV4,:CV5,:CV6,:CV7,:CV8,:CV9 FROM DUAL) WHERE ITEM_ID = ''a_product_112_1''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3,CV4,CV5,CV6,CV7,CV8,CV9;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_ITEM_LIST (AUTO_REFRESH,BACK_GROUND_ID,EDIT_EXPRESS,END_FIELD,EXECUTE_TIME,FOOTER,HEADER,HINT_TYPE,ITEM_ID,JUMP_EXPRESS,JUMP_FIELD,MAX_ROW_COUNT,MONITOR_ID,MULTI_PAGE_FLAG,NOADD_FIELDS,NOEDIT_FIELDS,NOMODIFY_FIELDS,NOSHOW_APP_FIELDS,NOSHOW_FIELDS,OPEN_MODE,OPERATION_TYPE,OUTPUT_PARAMETER,QUERY_COUNT,QUERY_FIELDS,QUERY_TYPE,RFID_FLAG,SCANNABLE_FIELD,SCANNABLE_LOCATION_LINE,SCANNABLE_TIME,SCANNABLE_TYPE,SUBNOSHOW_FIELDS,SUB_EDIT_STATE,SUB_TABLE_JUDGE_FIELD,UI_TMPL,DELETE_SQL,DETAIL_SQL,INSERT_SQL,LOCK_SQL,NEWID_SQL,OPRETION_HINT,SELECT_SQL,SUBSELECT_SQL,UPDATE_SQL) SELECT ,q''[]'',q''[]'',q''[]'',,q''[]'',q''[]'',,''a_product_112_1'',q''[]'',q''[]'',,q''[]'',1,q''[]'',q''[]'',q''[]'',q''[]'',q''[delivery_record_item_id,goo_id]'',,q''[]'',q''[]'',,q''[]'',,,q''[]'',q''[]'',,,q''[]'',,q''[]'',q''[]'',:CV1,:CV2,:CV3,:CV4,:CV5,:CV6,:CV7,:CV8,:CV9 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3,CV4,CV5,CV6,CV7,CV8,CV9;
     END IF;
  END;
END;
/

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
  CV7 CLOB:=q'[
--zwh73 2021311新需求
SELECT '面料检测' quality_testing_type,
       '产前' quality_testing_line,
       nvl(g.group_dict_name,'未评估') QUALITY_TESTING_RESULT,
       u.company_user_name quality_testing_user,
       tc.evaluate_time quality_testing_date,
       tc.goo_id log_id
  FROM scmdata.t_fabric_evaluate tc
 INNER JOIN t_production_progress pr
    ON tc.company_id = pr.company_id
   AND tc.goo_id = pr.goo_id
 INNER JOIN scmdata.sys_company_user u
    ON u.user_id = tc.evaluate_id
   AND u.company_id = tc.company_id
 left JOIN scmdata.sys_group_dict g
    ON g.group_dict_value = tc.evaluate_result
   AND g.group_dict_type = 'FABRIC_EVALUATE_RESULT_DICT'
 WHERE pr.company_id = %default_company_id%
   AND pr.product_gress_id = :product_gress_id
UNION
SELECT '大货批版' quality_testing_type,
       '产前' quality_testing_line,
       g.group_dict_name QUALITY_TESTING_RESULT,
       u.company_user_name quality_testing_user,
       ta.approve_time quality_testing_date,
       ta.approve_version_id log_id
  FROM scmdata.t_approve_version ta
 INNER JOIN t_production_progress pr
    ON ta.company_id = pr.company_id
   AND ta.goo_id = pr.goo_id
   AND ta.approve_status IN ('AS01', 'AS02')
 INNER JOIN scmdata.sys_company_user u
    ON u.user_id = ta.approve_user_id
   AND u.company_id = ta.company_id
 INNER JOIN scmdata.sys_group_dict g
    ON g.group_dict_value = ta.approve_result
   AND g.group_dict_type = 'APPROVE_STATUS'
 WHERE pr.company_id = %default_company_id%
   AND pr.product_gress_id = :product_gress_id



--czh修改
/*SELECT '面料检测' quality_testing_type,
       '产前' quality_testing_line,
       g.group_dict_name quality_testing_result_desc,
       NULL quality_testing_dual_result_desc,
       tc.check_report_file_id quality_testing_report_files,
       u.company_user_name quality_testing_user,
       tc.check_date quality_testing_date
  FROM scmdata.t_check_request tc
 INNER JOIN t_production_progress pr
    ON tc.company_id = pr.company_id
   AND tc.goo_id = pr.goo_id
 INNER JOIN scmdata.sys_company_user u
    ON u.user_id = tc.check_user_id
   AND u.company_id = tc.company_id
 INNER JOIN scmdata.sys_group_dict g
    ON g.group_dict_value = tc.check_result
   AND g.group_dict_type = 'FABRIC_RESULT_DICT'
 WHERE pr.company_id = %default_company_id%
   AND pr.product_gress_id = :product_gress_id
UNION
SELECT '大货批版' quality_testing_type,
       '产前' quality_testing_line,
       g.group_dict_name quality_testing_result_desc,
       NULL quality_testing_dual_result_desc,
       (SELECT listagg(z.file_id, ',') within GROUP(ORDER BY 1)
          FROM scmdata.t_approve_file z
         WHERE z.approve_version_id = ta.approve_version_id
           AND del_flag = 0) quality_testing_report_files,
       u.company_user_name quality_testing_user,
       ta.approve_time quality_testing_date
  FROM scmdata.t_approve_version ta
 INNER JOIN t_production_progress pr
    ON ta.company_id = pr.company_id
   AND ta.goo_id = pr.goo_id
   AND ta.approve_status IN ('AS01', 'AS02')
 INNER JOIN scmdata.sys_company_user u
    ON u.user_id = ta.approve_user_id
   AND u.company_id = ta.company_id
 INNER JOIN scmdata.sys_group_dict g
    ON g.group_dict_value = ta.approve_result
   AND g.group_dict_type = 'APPROVE_STATUS'
 WHERE pr.company_id = %default_company_id%
   AND pr.product_gress_id = :product_gress_id*/]';
  CV8 CLOB:=q'[]';
  CV9 CLOB:=q'[]';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_ITEM_LIST WHERE ITEM_ID = ''a_product_113''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_ITEM_LIST SET (AUTO_REFRESH,BACK_GROUND_ID,EDIT_EXPRESS,END_FIELD,EXECUTE_TIME,FOOTER,HEADER,HINT_TYPE,JUMP_EXPRESS,JUMP_FIELD,MAX_ROW_COUNT,MONITOR_ID,MULTI_PAGE_FLAG,NOADD_FIELDS,NOEDIT_FIELDS,NOMODIFY_FIELDS,NOSHOW_APP_FIELDS,NOSHOW_FIELDS,OPEN_MODE,OPERATION_TYPE,OUTPUT_PARAMETER,QUERY_COUNT,QUERY_FIELDS,QUERY_TYPE,RFID_FLAG,SCANNABLE_FIELD,SCANNABLE_LOCATION_LINE,SCANNABLE_TIME,SCANNABLE_TYPE,SUBNOSHOW_FIELDS,SUB_EDIT_STATE,SUB_TABLE_JUDGE_FIELD,UI_TMPL,DELETE_SQL,DETAIL_SQL,INSERT_SQL,LOCK_SQL,NEWID_SQL,OPRETION_HINT,SELECT_SQL,SUBSELECT_SQL,UPDATE_SQL) = (SELECT 1,q''[]'',q''[]'',q''[]'',,q''[]'',q''[]'',,q''[]'',q''[QUALITY_TESTING_RESULT_DESC]'',,q''[]'',0,q''[]'',q''[]'',q''[]'',q''[]'',q''[log_id]'',,q''[]'',q''[]'',,q''[]'',0,,q''[]'',q''[]'',,,q''[]'',,q''[]'',q''[]'',:CV1,:CV2,:CV3,:CV4,:CV5,:CV6,:CV7,:CV8,:CV9 FROM DUAL) WHERE ITEM_ID = ''a_product_113''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3,CV4,CV5,CV6,CV7,CV8,CV9;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_ITEM_LIST (AUTO_REFRESH,BACK_GROUND_ID,EDIT_EXPRESS,END_FIELD,EXECUTE_TIME,FOOTER,HEADER,HINT_TYPE,ITEM_ID,JUMP_EXPRESS,JUMP_FIELD,MAX_ROW_COUNT,MONITOR_ID,MULTI_PAGE_FLAG,NOADD_FIELDS,NOEDIT_FIELDS,NOMODIFY_FIELDS,NOSHOW_APP_FIELDS,NOSHOW_FIELDS,OPEN_MODE,OPERATION_TYPE,OUTPUT_PARAMETER,QUERY_COUNT,QUERY_FIELDS,QUERY_TYPE,RFID_FLAG,SCANNABLE_FIELD,SCANNABLE_LOCATION_LINE,SCANNABLE_TIME,SCANNABLE_TYPE,SUBNOSHOW_FIELDS,SUB_EDIT_STATE,SUB_TABLE_JUDGE_FIELD,UI_TMPL,DELETE_SQL,DETAIL_SQL,INSERT_SQL,LOCK_SQL,NEWID_SQL,OPRETION_HINT,SELECT_SQL,SUBSELECT_SQL,UPDATE_SQL) SELECT 1,q''[]'',q''[]'',q''[]'',,q''[]'',q''[]'',,''a_product_113'',q''[]'',q''[QUALITY_TESTING_RESULT_DESC]'',,q''[]'',0,q''[]'',q''[]'',q''[]'',q''[]'',q''[log_id]'',,q''[]'',q''[]'',,q''[]'',0,,q''[]'',q''[]'',,,q''[]'',,q''[]'',q''[]'',:CV1,:CV2,:CV3,:CV4,:CV5,:CV6,:CV7,:CV8,:CV9 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3,CV4,CV5,CV6,CV7,CV8,CV9;
     END IF;
  END;
END;
/

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
  CV7 CLOB:=q'[{declare
  v_sql varchar2(4000);
begin
  if :log_id like 'AP_VERSION%' then
    v_sql := 'SELECT
  (SELECT GROUP_DICT_NAME FROM SCMDATA.SYS_GROUP_DICT WHERE GROUP_DICT_VALUE=A.ASSESS_TYPE) ASSESS_TYPE_DESC,
  A.ASSESS_SAY,
  A.RISK_WARNING,
  (SELECT GROUP_DICT_NAME FROM SCMDATA.SYS_GROUP_DICT WHERE GROUP_DICT_VALUE=A.ASSESS_RESULT) ASSESS_RESULT,
  (SELECT COMPANY_DICT_NAME FROM SCMDATA.SYS_COMPANY_DICT WHERE COMPANY_DICT_VALUE = A.UNQUALIFIED_SAY AND COMPANY_ID=A.COMPANY_ID) UNQUALIFIED_SAY_DESC,
  (SELECT COMPANY_USER_NAME
     FROM SCMDATA.SYS_COMPANY_USER
    WHERE COMPANY_ID = %DEFAULT_COMPANY_ID%
   AND USER_ID = A.ASSESS_USER_ID)  ASSESS_USER,
  A.ASSESS_TIME
FROM SCMDATA.T_APPROVE_RISK_ASSESSMENT A
WHERE APPROVE_VERSION_ID=:LOG_ID
ORDER BY ASSESS_TYPE';
  else
    v_sql := 'select
       (SELECT GROUP_DICT_NAME FROM SCMDATA.SYS_GROUP_DICT WHERE GROUP_DICT_VALUE=A.check_status and group_dict_type=''FABRIC_STATUS_DICT'') check_status_desc,
       a.check_request_code,
      -- g.goo_id,
       g.rela_goo_id,
       g.style_number,
       a.color_list,
       (SELECT GROUP_DICT_NAME FROM SCMDATA.SYS_GROUP_DICT WHERE GROUP_DICT_VALUE=A.check_result and group_dict_type=''FABRIC_RESULT_DICT'') check_result_desc,
       a.check_company_name     FABRIC_CHECK_COMPANY_NAME,
       (SELECT GROUP_DICT_NAME FROM SCMDATA.SYS_GROUP_DICT WHERE GROUP_DICT_VALUE=A.check_type  and group_dict_type=''MATERIAL_TEST_TYPE'') check_type_desc,
       nvl(a.FABRIC_CHECK_USER_NAME,u.company_user_name)      FABRIC_CHECK_USER_NAME,
       a.check_date FABRIC_CHECK_DATE,
       nvl(si.supplier_company_name,SEND_CHECK_SUP_NAME) SEND_CHECK_SUP_NAME,
       a.send_check_date,
       a.check_report_file_id   FABRIC_CHECK_REPORT_FILE,
        (SELECT company_DICT_NAME FROM SCMDATA.SYS_company_DICT WHERE company_DICT_VALUE=A.unqualified_type and company_dict_type=''FABRIC_UNQUALIFY_TYPE_DICT'') unqualified_type_desc,
       a.memo
  from (select *
          from scmdata.t_check_request
         where company_id = %default_company_id%
           and goo_id = :log_Id) a
 inner join scmdata.t_commodity_info g
    on g.goo_id = a.goo_id
   and g.company_id = a.company_id
 inner join scmdata.sys_company_user u
    on u.user_id = a.check_user_id
   and u.company_id = a.company_id
  left join scmdata.t_supplier_info si
    on si.supplier_code = a.send_check_sup_id
   and si.company_id = a.company_id
 order by a.send_check_amount asc';
  end if;
  @StrResult:=v_sql;
end;
}]';
  CV8 CLOB:=q'[]';
  CV9 CLOB:=q'[]';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_ITEM_LIST WHERE ITEM_ID = ''a_product_113_1''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_ITEM_LIST SET (AUTO_REFRESH,BACK_GROUND_ID,EDIT_EXPRESS,END_FIELD,EXECUTE_TIME,FOOTER,HEADER,HINT_TYPE,JUMP_EXPRESS,JUMP_FIELD,MAX_ROW_COUNT,MONITOR_ID,MULTI_PAGE_FLAG,NOADD_FIELDS,NOEDIT_FIELDS,NOMODIFY_FIELDS,NOSHOW_APP_FIELDS,NOSHOW_FIELDS,OPEN_MODE,OPERATION_TYPE,OUTPUT_PARAMETER,QUERY_COUNT,QUERY_FIELDS,QUERY_TYPE,RFID_FLAG,SCANNABLE_FIELD,SCANNABLE_LOCATION_LINE,SCANNABLE_TIME,SCANNABLE_TYPE,SUBNOSHOW_FIELDS,SUB_EDIT_STATE,SUB_TABLE_JUDGE_FIELD,UI_TMPL,DELETE_SQL,DETAIL_SQL,INSERT_SQL,LOCK_SQL,NEWID_SQL,OPRETION_HINT,SELECT_SQL,SUBSELECT_SQL,UPDATE_SQL) = (SELECT ,q''[]'',q''[]'',q''[]'',,q''[]'',q''[]'',,q''[]'',q''[]'',,q''[]'',0,q''[]'',q''[]'',q''[]'',q''[]'',q''[RISK_WARNING]'',,q''[]'',q''[]'',,q''[]'',,,q''[]'',q''[]'',,,q''[]'',,q''[]'',q''[]'',:CV1,:CV2,:CV3,:CV4,:CV5,:CV6,:CV7,:CV8,:CV9 FROM DUAL) WHERE ITEM_ID = ''a_product_113_1''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3,CV4,CV5,CV6,CV7,CV8,CV9;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_ITEM_LIST (AUTO_REFRESH,BACK_GROUND_ID,EDIT_EXPRESS,END_FIELD,EXECUTE_TIME,FOOTER,HEADER,HINT_TYPE,ITEM_ID,JUMP_EXPRESS,JUMP_FIELD,MAX_ROW_COUNT,MONITOR_ID,MULTI_PAGE_FLAG,NOADD_FIELDS,NOEDIT_FIELDS,NOMODIFY_FIELDS,NOSHOW_APP_FIELDS,NOSHOW_FIELDS,OPEN_MODE,OPERATION_TYPE,OUTPUT_PARAMETER,QUERY_COUNT,QUERY_FIELDS,QUERY_TYPE,RFID_FLAG,SCANNABLE_FIELD,SCANNABLE_LOCATION_LINE,SCANNABLE_TIME,SCANNABLE_TYPE,SUBNOSHOW_FIELDS,SUB_EDIT_STATE,SUB_TABLE_JUDGE_FIELD,UI_TMPL,DELETE_SQL,DETAIL_SQL,INSERT_SQL,LOCK_SQL,NEWID_SQL,OPRETION_HINT,SELECT_SQL,SUBSELECT_SQL,UPDATE_SQL) SELECT ,q''[]'',q''[]'',q''[]'',,q''[]'',q''[]'',,''a_product_113_1'',q''[]'',q''[]'',,q''[]'',0,q''[]'',q''[]'',q''[]'',q''[]'',q''[RISK_WARNING]'',,q''[]'',q''[]'',,q''[]'',,,q''[]'',q''[]'',,,q''[]'',,q''[]'',q''[]'',:CV1,:CV2,:CV3,:CV4,:CV5,:CV6,:CV7,:CV8,:CV9 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3,CV4,CV5,CV6,CV7,CV8,CV9;
     END IF;
  END;
END;
/

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
  CV7 CLOB:=q'[WITH group_dict AS
 (SELECT gd.group_dict_name, gd.group_dict_type, gd.group_dict_value
    FROM scmdata.sys_group_dict gd)
SELECT b.group_dict_name anomaly_class_pr,
       t.problem_class problem_class_pr,
       t.cause_class cause_class_pr,
       a.group_dict_name handle_opinions_pr,
       t.confirm_date
  FROM t_abnormal t
 INNER JOIN scmdata.t_production_progress pr
    ON t.company_id = pr.company_id
   AND t.order_id = pr.order_id
   AND t.goo_id = pr.goo_id
  LEFT JOIN group_dict a
    ON a.group_dict_type = 'HANDLE_RESULT'
   AND a.group_dict_value = t.handle_opinions
  INNER JOIN group_dict b
    ON b.group_dict_type = 'ANOMALY_CLASSIFICATION_DICT'
   AND b.group_dict_value = t.anomaly_class
   AND pr.company_id = %default_company_id%
   AND pr.product_gress_id = :product_gress_id
   AND t.origin = 'MA']';
  CV8 CLOB:=q'[]';
  CV9 CLOB:=q'[]';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_ITEM_LIST WHERE ITEM_ID = ''a_product_114''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_ITEM_LIST SET (AUTO_REFRESH,BACK_GROUND_ID,EDIT_EXPRESS,END_FIELD,EXECUTE_TIME,FOOTER,HEADER,HINT_TYPE,JUMP_EXPRESS,JUMP_FIELD,MAX_ROW_COUNT,MONITOR_ID,MULTI_PAGE_FLAG,NOADD_FIELDS,NOEDIT_FIELDS,NOMODIFY_FIELDS,NOSHOW_APP_FIELDS,NOSHOW_FIELDS,OPEN_MODE,OPERATION_TYPE,OUTPUT_PARAMETER,QUERY_COUNT,QUERY_FIELDS,QUERY_TYPE,RFID_FLAG,SCANNABLE_FIELD,SCANNABLE_LOCATION_LINE,SCANNABLE_TIME,SCANNABLE_TYPE,SUBNOSHOW_FIELDS,SUB_EDIT_STATE,SUB_TABLE_JUDGE_FIELD,UI_TMPL,DELETE_SQL,DETAIL_SQL,INSERT_SQL,LOCK_SQL,NEWID_SQL,OPRETION_HINT,SELECT_SQL,SUBSELECT_SQL,UPDATE_SQL) = (SELECT 1,q''[]'',q''[]'',q''[]'',,q''[]'',q''[]'',,q''[]'',q''[]'',,q''[]'',1,q''[]'',q''[]'',q''[]'',q''[]'',q''[abnormal_id,company_id,abnormal_code,order_id,progress_status]'',,q''[]'',q''[]'',,q''[]'',0,,q''[]'',q''[]'',,,q''[]'',,q''[]'',q''[]'',:CV1,:CV2,:CV3,:CV4,:CV5,:CV6,:CV7,:CV8,:CV9 FROM DUAL) WHERE ITEM_ID = ''a_product_114''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3,CV4,CV5,CV6,CV7,CV8,CV9;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_ITEM_LIST (AUTO_REFRESH,BACK_GROUND_ID,EDIT_EXPRESS,END_FIELD,EXECUTE_TIME,FOOTER,HEADER,HINT_TYPE,ITEM_ID,JUMP_EXPRESS,JUMP_FIELD,MAX_ROW_COUNT,MONITOR_ID,MULTI_PAGE_FLAG,NOADD_FIELDS,NOEDIT_FIELDS,NOMODIFY_FIELDS,NOSHOW_APP_FIELDS,NOSHOW_FIELDS,OPEN_MODE,OPERATION_TYPE,OUTPUT_PARAMETER,QUERY_COUNT,QUERY_FIELDS,QUERY_TYPE,RFID_FLAG,SCANNABLE_FIELD,SCANNABLE_LOCATION_LINE,SCANNABLE_TIME,SCANNABLE_TYPE,SUBNOSHOW_FIELDS,SUB_EDIT_STATE,SUB_TABLE_JUDGE_FIELD,UI_TMPL,DELETE_SQL,DETAIL_SQL,INSERT_SQL,LOCK_SQL,NEWID_SQL,OPRETION_HINT,SELECT_SQL,SUBSELECT_SQL,UPDATE_SQL) SELECT 1,q''[]'',q''[]'',q''[]'',,q''[]'',q''[]'',,''a_product_114'',q''[]'',q''[]'',,q''[]'',1,q''[]'',q''[]'',q''[]'',q''[]'',q''[abnormal_id,company_id,abnormal_code,order_id,progress_status]'',,q''[]'',q''[]'',,q''[]'',0,,q''[]'',q''[]'',,,q''[]'',,q''[]'',q''[]'',:CV1,:CV2,:CV3,:CV4,:CV5,:CV6,:CV7,:CV8,:CV9 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3,CV4,CV5,CV6,CV7,CV8,CV9;
     END IF;
  END;
END;
/

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
  CV7 CLOB:=q'[SELECT od.ordersitem_id,
       od.barcode,
       tcs.colorname,
       tcs.sizename,
       od.order_amount,
       od.order_amount - od.got_amount owe_amount_pr,
       od.memo memo_pr
  FROM scmdata.t_ordersitem od
 INNER JOIN scmdata.t_commodity_info tc
    ON od.goo_id = tc.goo_id
 INNER JOIN scmdata.t_commodity_color_size tcs
    ON tc.commodity_info_id = tcs.commodity_info_id
   AND od.barcode = tcs.barcode
 WHERE od.company_id = %default_company_id%
   AND od.order_id = :order_id_pr
   AND od.goo_id = :goo_id_pr]';
  CV8 CLOB:=q'[]';
  CV9 CLOB:=q'[UPDATE t_ordersitem od
   SET od.memo = :memo_pr
 WHERE od.company_id = %default_company_id%
   AND od.order_id = :order_id_pr
   AND od.goo_id = :goo_id_pr
   AND od.ordersitem_id = :ordersitem_id]';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_ITEM_LIST WHERE ITEM_ID = ''a_product_115''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_ITEM_LIST SET (AUTO_REFRESH,BACK_GROUND_ID,EDIT_EXPRESS,END_FIELD,EXECUTE_TIME,FOOTER,HEADER,HINT_TYPE,JUMP_EXPRESS,JUMP_FIELD,MAX_ROW_COUNT,MONITOR_ID,MULTI_PAGE_FLAG,NOADD_FIELDS,NOEDIT_FIELDS,NOMODIFY_FIELDS,NOSHOW_APP_FIELDS,NOSHOW_FIELDS,OPEN_MODE,OPERATION_TYPE,OUTPUT_PARAMETER,QUERY_COUNT,QUERY_FIELDS,QUERY_TYPE,RFID_FLAG,SCANNABLE_FIELD,SCANNABLE_LOCATION_LINE,SCANNABLE_TIME,SCANNABLE_TYPE,SUBNOSHOW_FIELDS,SUB_EDIT_STATE,SUB_TABLE_JUDGE_FIELD,UI_TMPL,DELETE_SQL,DETAIL_SQL,INSERT_SQL,LOCK_SQL,NEWID_SQL,OPRETION_HINT,SELECT_SQL,SUBSELECT_SQL,UPDATE_SQL) = (SELECT 1,q''[]'',q''[]'',q''[]'',,q''[]'',q''[]'',,q''[]'',q''[]'',,q''[]'',1,q''[]'',q''[]'',q''[]'',q''[]'',q''[ordersitem_id]'',,q''[]'',q''[]'',,q''[]'',0,,q''[]'',q''[]'',,,q''[]'',,q''[]'',q''[]'',:CV1,:CV2,:CV3,:CV4,:CV5,:CV6,:CV7,:CV8,:CV9 FROM DUAL) WHERE ITEM_ID = ''a_product_115''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3,CV4,CV5,CV6,CV7,CV8,CV9;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_ITEM_LIST (AUTO_REFRESH,BACK_GROUND_ID,EDIT_EXPRESS,END_FIELD,EXECUTE_TIME,FOOTER,HEADER,HINT_TYPE,ITEM_ID,JUMP_EXPRESS,JUMP_FIELD,MAX_ROW_COUNT,MONITOR_ID,MULTI_PAGE_FLAG,NOADD_FIELDS,NOEDIT_FIELDS,NOMODIFY_FIELDS,NOSHOW_APP_FIELDS,NOSHOW_FIELDS,OPEN_MODE,OPERATION_TYPE,OUTPUT_PARAMETER,QUERY_COUNT,QUERY_FIELDS,QUERY_TYPE,RFID_FLAG,SCANNABLE_FIELD,SCANNABLE_LOCATION_LINE,SCANNABLE_TIME,SCANNABLE_TYPE,SUBNOSHOW_FIELDS,SUB_EDIT_STATE,SUB_TABLE_JUDGE_FIELD,UI_TMPL,DELETE_SQL,DETAIL_SQL,INSERT_SQL,LOCK_SQL,NEWID_SQL,OPRETION_HINT,SELECT_SQL,SUBSELECT_SQL,UPDATE_SQL) SELECT 1,q''[]'',q''[]'',q''[]'',,q''[]'',q''[]'',,''a_product_115'',q''[]'',q''[]'',,q''[]'',1,q''[]'',q''[]'',q''[]'',q''[]'',q''[ordersitem_id]'',,q''[]'',q''[]'',,q''[]'',0,,q''[]'',q''[]'',,,q''[]'',,q''[]'',q''[]'',:CV1,:CV2,:CV3,:CV4,:CV5,:CV6,:CV7,:CV8,:CV9 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3,CV4,CV5,CV6,CV7,CV8,CV9;
     END IF;
  END;
END;
/

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
  CV7 CLOB:=q'[WITH supp AS
 (SELECT sp.company_id, sp.supplier_code, sp.supplier_company_name
    FROM scmdata.t_supplier_info sp),
group_dict AS
 (SELECT group_dict_type, group_dict_value, group_dict_name FROM scmdata.sys_group_dict)
SELECT t.product_gress_id,
       t.company_id,
       t.progress_status progress_status_pr,
       t.product_gress_code product_gress_code_pr,
       a.group_dict_name progress_status_desc,
       t.order_id order_id_pr,
       cf.rela_goo_id,
       cf.style_number style_number_pr,
       cf.style_name style_name_pr,
       t.supplier_code supplier_code_pr,
       sp2.supplier_company_name supplier_company_name_pr,
       t.factory_code factory_code_pr,
       sp1.supplier_company_name factory_company_name_pr,
       od.delivery_date delivery_date_pr,
       oh.finish_time_scm finish_time_scm_pr,
       t.forecast_delivery_date forecast_delivery_date_pr,
       decode(sign(ceil(t.forecast_delivery_date - od.delivery_date)),-1,0,ceil(t.forecast_delivery_date - od.delivery_date)) forecast_delay_day_pr,
       t.latest_planned_delivery_date latest_planned_delivery_date_pr,
       t.actual_delivery_date actual_delivery_date_pr,
       t.actual_delay_day actual_delay_day_pr,
       t.order_amount order_amount_pr,
       t.delivery_amount delivery_amount_pr,
       decode(sign(t.order_amount - t.delivery_amount),-1,0,t.order_amount - t.delivery_amount) owe_amount_pr,
       nvl(t.order_full_rate,0) order_full_rate_pr,
       --t.order_status order_status_pr,
       t.delay_problem_class delay_problem_class_pr,
       t.delay_cause_class delay_cause_class_pr,
       t.delay_cause_detailed delay_cause_detailed_pr,
       t.problem_desc problem_desc_pr,
       t.approve_edition, --Edit by zc
       t.fabric_check fabric_check,
       t.qc_check qc_check_pr,
       t.qa_check qa_check_pr,
       decode(t.exception_handle_status,'01','处理中','02','已处理','无异常') exception_handle_status_pr,
       (SELECT gd.group_dict_name
          FROM scmdata.sys_group_dict gd
            WHERE gd.group_dict_type = 'HANDLE_RESULT'
           AND gd.group_dict_value = t.handle_opinions) handle_opinions_pr,
       t.goo_id goo_id_pr
  FROM scmdata.t_ordered oh
 INNER JOIN scmdata.t_orders od
    ON oh.company_id = od.company_id
   AND oh.order_code = od.order_id
   AND oh.order_status IN ('OS01','OS02') --待修改
 INNER JOIN t_production_progress t
    ON t.company_id = od.company_id
   AND t.order_id = od.order_id
   AND t.goo_id = od.goo_id
   AND t.progress_status = '01'
 INNER JOIN group_dict a
    ON a.group_dict_value = t.progress_status
 INNER JOIN group_dict b
    ON b.group_dict_value = a.group_dict_type
   AND b.group_dict_value = 'PROGRESS_TYPE'
 INNER JOIN scmdata.t_commodity_info cf
    ON t.company_id = cf.company_id
   AND t.goo_id = cf.goo_id
 LEFT JOIN supp sp1
    ON t.company_id = sp1.company_id
   AND t.factory_code = sp1.supplier_code
 INNER JOIN supp sp2
    ON t.company_id = sp2.company_id
   AND t.supplier_code = sp2.supplier_code
 WHERE oh.company_id = %default_company_id%
ORDER BY oh.finish_time_scm DESC]';
  CV8 CLOB:=q'[]';
  CV9 CLOB:=q'[]';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_ITEM_LIST WHERE ITEM_ID = ''a_product_116''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_ITEM_LIST SET (AUTO_REFRESH,BACK_GROUND_ID,EDIT_EXPRESS,END_FIELD,EXECUTE_TIME,FOOTER,HEADER,HINT_TYPE,JUMP_EXPRESS,JUMP_FIELD,MAX_ROW_COUNT,MONITOR_ID,MULTI_PAGE_FLAG,NOADD_FIELDS,NOEDIT_FIELDS,NOMODIFY_FIELDS,NOSHOW_APP_FIELDS,NOSHOW_FIELDS,OPEN_MODE,OPERATION_TYPE,OUTPUT_PARAMETER,QUERY_COUNT,QUERY_FIELDS,QUERY_TYPE,RFID_FLAG,SCANNABLE_FIELD,SCANNABLE_LOCATION_LINE,SCANNABLE_TIME,SCANNABLE_TYPE,SUBNOSHOW_FIELDS,SUB_EDIT_STATE,SUB_TABLE_JUDGE_FIELD,UI_TMPL,DELETE_SQL,DETAIL_SQL,INSERT_SQL,LOCK_SQL,NEWID_SQL,OPRETION_HINT,SELECT_SQL,SUBSELECT_SQL,UPDATE_SQL) = (SELECT 1,q''[]'',q''[]'',q''[]'',,q''[]'',q''[]'',,q''[]'',q''[]'',,q''[]'',1,q''[]'',q''[]'',q''[]'',q''[]'',q''[fabric_check,product_gress_id,company_id,supplier_code_pr,factory_code_pr,order_id_pr,progress_status_pr,qc_check_pr,qa_check_pr,approve_edition]'',,q''[]'',q''[]'',,q''[product_gress_code_pr,rela_goo_id]'',12,,q''[]'',q''[]'',,,q''[]'',,q''[]'',q''[]'',:CV1,:CV2,:CV3,:CV4,:CV5,:CV6,:CV7,:CV8,:CV9 FROM DUAL) WHERE ITEM_ID = ''a_product_116''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3,CV4,CV5,CV6,CV7,CV8,CV9;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_ITEM_LIST (AUTO_REFRESH,BACK_GROUND_ID,EDIT_EXPRESS,END_FIELD,EXECUTE_TIME,FOOTER,HEADER,HINT_TYPE,ITEM_ID,JUMP_EXPRESS,JUMP_FIELD,MAX_ROW_COUNT,MONITOR_ID,MULTI_PAGE_FLAG,NOADD_FIELDS,NOEDIT_FIELDS,NOMODIFY_FIELDS,NOSHOW_APP_FIELDS,NOSHOW_FIELDS,OPEN_MODE,OPERATION_TYPE,OUTPUT_PARAMETER,QUERY_COUNT,QUERY_FIELDS,QUERY_TYPE,RFID_FLAG,SCANNABLE_FIELD,SCANNABLE_LOCATION_LINE,SCANNABLE_TIME,SCANNABLE_TYPE,SUBNOSHOW_FIELDS,SUB_EDIT_STATE,SUB_TABLE_JUDGE_FIELD,UI_TMPL,DELETE_SQL,DETAIL_SQL,INSERT_SQL,LOCK_SQL,NEWID_SQL,OPRETION_HINT,SELECT_SQL,SUBSELECT_SQL,UPDATE_SQL) SELECT 1,q''[]'',q''[]'',q''[]'',,q''[]'',q''[]'',,''a_product_116'',q''[]'',q''[]'',,q''[]'',1,q''[]'',q''[]'',q''[]'',q''[]'',q''[fabric_check,product_gress_id,company_id,supplier_code_pr,factory_code_pr,order_id_pr,progress_status_pr,qc_check_pr,qa_check_pr,approve_edition]'',,q''[]'',q''[]'',,q''[product_gress_code_pr,rela_goo_id]'',12,,q''[]'',q''[]'',,,q''[]'',,q''[]'',q''[]'',:CV1,:CV2,:CV3,:CV4,:CV5,:CV6,:CV7,:CV8,:CV9 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3,CV4,CV5,CV6,CV7,CV8,CV9;
     END IF;
  END;
END;
/

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
  CV7 CLOB:=q'[WITH supp AS
 (SELECT sp.company_id, sp.supplier_code, sp.supplier_company_name
    FROM scmdata.t_supplier_info sp
   WHERE sp.company_id = %default_company_id%)
SELECT t.product_gress_id,
       t.company_id,
       t.product_gress_code product_gress_code_pr,
       t.progress_status progress_status_pr,
       t.order_id order_id_pr,
       t.goo_id goo_id_pr,
       cf.style_number style_number_pr,
       cf.style_name style_name_pr,
       t.supplier_code supplier_code_pr,
       sp1.supplier_company_name supplier_company_name_pr,
       t.factory_code factory_code_pr,
       sp2.supplier_company_name factory_company_name_pr,
       od.delivery_date delivery_date_pr,
       t.forecast_delivery_date forecast_delivery_date_pr,
       t.forecast_delivery_date - od.delivery_date forecast_delay_day_pr,
       t.latest_planned_delivery_date latest_planned_delivery_date_pr,
       t.actual_delivery_date actual_delivery_date_pr,
       t.actual_delivery_date - od.delivery_date actual_delay_day_pr,
       t.order_amount order_amount_pr,
       t.delivery_amount delivery_amount_pr,
       t.order_amount - t.delivery_amount owe_amount_pr,
       t.approve_edition approve_edition_pr,
       t.fabric_check fabric_check_pr,
       t.qc_check qc_check_pr,
       t.qa_check qa_check_pr,
       t.exception_handle_status exception_handle_status_pr,
       t.handle_opinions handle_opinions_pr
  FROM scmdata.t_ordered oh
 INNER JOIN scmdata.t_orders od
    ON oh.company_id = od.company_id
   AND oh.order_code = od.order_id
   AND oh.order_status = 'OS01' --待修改
 INNER JOIN t_production_progress t
    ON t.company_id = od.company_id
   AND t.order_id = od.order_id
 INNER JOIN scmdata.t_commodity_info cf
    ON t.company_id = cf.company_id
   AND t.goo_id = cf.rela_goo_id
 INNER JOIN supp sp1
    ON t.company_id = sp1.company_id
   AND t.factory_code = sp1.supplier_code
 INNER JOIN supp sp2
    ON t.company_id = sp2.company_id
   AND t.supplier_code = sp2.supplier_code
 WHERE oh.company_id = %default_company_id%
   AND t.product_gress_id <> %ass_product_gress_id%]';
  CV8 CLOB:=q'[]';
  CV9 CLOB:=q'[]';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_ITEM_LIST WHERE ITEM_ID = ''a_product_117''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_ITEM_LIST SET (AUTO_REFRESH,BACK_GROUND_ID,EDIT_EXPRESS,END_FIELD,EXECUTE_TIME,FOOTER,HEADER,HINT_TYPE,JUMP_EXPRESS,JUMP_FIELD,MAX_ROW_COUNT,MONITOR_ID,MULTI_PAGE_FLAG,NOADD_FIELDS,NOEDIT_FIELDS,NOMODIFY_FIELDS,NOSHOW_APP_FIELDS,NOSHOW_FIELDS,OPEN_MODE,OPERATION_TYPE,OUTPUT_PARAMETER,QUERY_COUNT,QUERY_FIELDS,QUERY_TYPE,RFID_FLAG,SCANNABLE_FIELD,SCANNABLE_LOCATION_LINE,SCANNABLE_TIME,SCANNABLE_TYPE,SUBNOSHOW_FIELDS,SUB_EDIT_STATE,SUB_TABLE_JUDGE_FIELD,UI_TMPL,DELETE_SQL,DETAIL_SQL,INSERT_SQL,LOCK_SQL,NEWID_SQL,OPRETION_HINT,SELECT_SQL,SUBSELECT_SQL,UPDATE_SQL) = (SELECT 1,q''[]'',q''[]'',q''[]'',,q''[]'',q''[]'',,q''[]'',q''[]'',,q''[]'',1,q''[]'',q''[]'',q''[]'',q''[]'',q''[product_gress_id,company_id,supplier_code_pr,factory_code_pr,order_id_pr]'',,q''[]'',q''[]'',,q''[]'',0,,q''[]'',q''[]'',,,q''[]'',,q''[]'',q''[]'',:CV1,:CV2,:CV3,:CV4,:CV5,:CV6,:CV7,:CV8,:CV9 FROM DUAL) WHERE ITEM_ID = ''a_product_117''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3,CV4,CV5,CV6,CV7,CV8,CV9;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_ITEM_LIST (AUTO_REFRESH,BACK_GROUND_ID,EDIT_EXPRESS,END_FIELD,EXECUTE_TIME,FOOTER,HEADER,HINT_TYPE,ITEM_ID,JUMP_EXPRESS,JUMP_FIELD,MAX_ROW_COUNT,MONITOR_ID,MULTI_PAGE_FLAG,NOADD_FIELDS,NOEDIT_FIELDS,NOMODIFY_FIELDS,NOSHOW_APP_FIELDS,NOSHOW_FIELDS,OPEN_MODE,OPERATION_TYPE,OUTPUT_PARAMETER,QUERY_COUNT,QUERY_FIELDS,QUERY_TYPE,RFID_FLAG,SCANNABLE_FIELD,SCANNABLE_LOCATION_LINE,SCANNABLE_TIME,SCANNABLE_TYPE,SUBNOSHOW_FIELDS,SUB_EDIT_STATE,SUB_TABLE_JUDGE_FIELD,UI_TMPL,DELETE_SQL,DETAIL_SQL,INSERT_SQL,LOCK_SQL,NEWID_SQL,OPRETION_HINT,SELECT_SQL,SUBSELECT_SQL,UPDATE_SQL) SELECT 1,q''[]'',q''[]'',q''[]'',,q''[]'',q''[]'',,''a_product_117'',q''[]'',q''[]'',,q''[]'',1,q''[]'',q''[]'',q''[]'',q''[]'',q''[product_gress_id,company_id,supplier_code_pr,factory_code_pr,order_id_pr]'',,q''[]'',q''[]'',,q''[]'',0,,q''[]'',q''[]'',,,q''[]'',,q''[]'',q''[]'',:CV1,:CV2,:CV3,:CV4,:CV5,:CV6,:CV7,:CV8,:CV9 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3,CV4,CV5,CV6,CV7,CV8,CV9;
     END IF;
  END;
END;
/

BEGIN
  DECLARE
    JUDGE_N NUMBER(4);
    EXE_SQL CLOB;
    VALS    CLOB;
  CV1 CLOB:=q'[DELETE FROM scmdata.t_abnormal abn
 WHERE abn.company_id = %default_company_id%
   AND abn.abnormal_id = :abnormal_id_pr]';
  CV2 CLOB:=q'[]';
  CV3 CLOB:=q'[DECLARE
  v_abnormal_code VARCHAR2(32);
  p_abn_rec       scmdata.t_abnormal%ROWTYPE;
BEGIN

  p_abn_rec.abnormal_id          := scmdata.f_get_uuid();
  p_abn_rec.company_id           := %default_company_id%;
  p_abn_rec.abnormal_code        := scmdata.pkg_plat_comm.f_getkeycode(pi_table_name  => 't_abnormal',
                                                                       pi_column_name => 'abnormal_code',
                                                                       pi_company_id  => %default_company_id%,
                                                                       pi_pre         => 'ABN',
                                                                       pi_serail_num  => '6');
  p_abn_rec.order_id             := :order_id_pr;
  p_abn_rec.progress_status      := '00';
  p_abn_rec.goo_id               := :goo_id_pr;
  p_abn_rec.anomaly_class        := nvl(:anomaly_class_pr, ' ');
  p_abn_rec.problem_class        := nvl(:delay_problem_class_pr, ' ');
  p_abn_rec.cause_class          := nvl(:delay_cause_class_pr, ' ');
  p_abn_rec.cause_detailed       := nvl(:delay_cause_detailed_pr, ' ');
  p_abn_rec.detailed_reasons     := nvl(:problem_desc_pr, ' ');
  p_abn_rec.is_sup_responsible   := :is_sup_responsible;
  p_abn_rec.responsible_dept_sec := :responsible_dept_sec;
  p_abn_rec.delay_date           := :delay_date;
  p_abn_rec.delay_amount         := :delay_amount_pr;
  p_abn_rec.responsible_party    := nvl(:responsible_party, ' ');
  p_abn_rec.responsible_dept     := nvl(:responsible_dept, ' ');
  p_abn_rec.handle_opinions      := :handle_opinions;
  p_abn_rec.quality_deduction    := nvl(:quality_deduction, 0);
  p_abn_rec.is_deduction         := nvl(:is_deduction, 0);
  p_abn_rec.deduction_method     := :deduction_method_pr;
  p_abn_rec.deduction_unit_price := :deduction_unit_price_pr;
  p_abn_rec.applicant_id         := :user_id;
  p_abn_rec.applicant_date       := SYSDATE;
  p_abn_rec.create_id            := :user_id;
  p_abn_rec.create_time          := SYSDATE;
  p_abn_rec.update_id            := :user_id;
  p_abn_rec.update_time          := SYSDATE;
  p_abn_rec.origin               := 'MA';
  p_abn_rec.memo                 := :memo_pr;

  scmdata.pkg_production_progress.handle_abnormal(p_abn_rec => p_abn_rec);

END;]';
  CV4 CLOB:=q'[]';
  CV5 CLOB:=q'[]';
  CV6 CLOB:=q'[]';
  CV7 CLOB:=q'[WITH supp AS
 (SELECT sp.company_id, sp.supplier_code, sp.supplier_company_name
    FROM scmdata.t_supplier_info sp
   WHERE sp.company_id = %default_company_id%),
group_dict AS
 (SELECT group_dict_type, group_dict_value, group_dict_name
    FROM scmdata.sys_group_dict)
SELECT t.product_gress_id,
       t.company_id,
       t.order_id order_id_pr,
       a.abnormal_id abnormal_id_pr,
       a.anomaly_class anomaly_class_pr,
       gd.group_dict_name anomaly_class_desc,
       t.product_gress_code product_gress_code_pr,
       cf.rela_goo_id,
       a.detailed_reasons detailed_reasons_pr, --问题描述
       a.delay_date delay_date_pr, --延期天数
       a.delay_amount delay_amount_pr, --延期数量
       a.handle_opinions handle_opinions_pr,
       a.is_deduction is_deduction_pr,
       a.deduction_method deduction_method_pr,
       a.deduction_unit_price deduction_unit_price_pr,
       a.file_id file_id_pr,
       a.problem_class problem_class_pr,
       a.cause_class cause_class_pr,
       a.cause_detailed cause_detailed_pr,
       a.is_sup_responsible,
       --a.responsible_party responsible_party_pr,
       a.responsible_dept responsible_dept_pr,
       a.responsible_dept_sec responsible_dept_sec_pr,
       a.memo memo_pr,
       a.progress_status abnormal_status_pr,
       decode(t.progress_status,
              '02',
              (SELECT pno_status
                 FROM (SELECT pn.node_name ||
                              (SELECT a.group_dict_name
                                 FROM group_dict a
                                INNER JOIN group_dict b
                                   ON a.group_dict_type = b.group_dict_value
                                  AND b.group_dict_value = 'PROGRESS_NODE_TYPE'
                                WHERE a.group_dict_value = pn.progress_status) pno_status
                         FROM scmdata.t_production_node pn
                        WHERE pn.company_id = t.company_id
                          AND pn.product_gress_id = t.product_gress_id
                          AND pn.progress_status IS NOT NULL
                        ORDER BY pn.node_num DESC)
                WHERE rownum = 1),
              '00',
              (SELECT a.group_dict_name
                 FROM group_dict a
                WHERE a.group_dict_type = 'PROGRESS_TYPE'
                  AND a.group_dict_value = t.progress_status)) progress_status_desc,
       t.supplier_code supplier_code_pr,
       sp2.supplier_company_name supplier_company_name_pr,
       t.goo_id goo_id_pr,
       cf.style_number style_number_pr,
       cf.style_name style_name_pr,
       t.order_amount order_amount_pr,
       od.delivery_date delivery_date_pr,
       t.latest_planned_delivery_date latest_planned_delivery_date_pr
  FROM scmdata.t_ordered oh
 INNER JOIN scmdata.t_orders od
    ON oh.company_id = od.company_id
   AND oh.order_code = od.order_id
   AND oh.order_status = 'OS01' --待修改
 INNER JOIN t_production_progress t
    ON t.company_id = od.company_id
   AND t.order_id = od.order_id
   AND t.goo_id = od.goo_id
 INNER JOIN scmdata.t_commodity_info cf
    ON t.company_id = cf.company_id
   AND t.goo_id = cf.goo_id
  LEFT JOIN supp sp1
    ON t.company_id = sp1.company_id
   AND t.factory_code = sp1.supplier_code
 INNER JOIN supp sp2
    ON t.company_id = sp2.company_id
   AND t.supplier_code = sp2.supplier_code
 INNER JOIN scmdata.t_abnormal a
    ON t.company_id = a.company_id
   AND t.order_id = a.order_id
   AND t.goo_id = a.goo_id
   AND a.progress_status = '00'
  LEFT JOIN scmdata.sys_group_dict gd
    ON gd.group_dict_type = 'ANOMALY_CLASSIFICATION_DICT'
   AND gd.group_dict_value = a.anomaly_class
 WHERE oh.company_id = %default_company_id%
   AND a.create_id = :user_id]';
  CV8 CLOB:=q'[]';
  CV9 CLOB:=q'[DECLARE
  v_abnormal_code VARCHAR2(32);
  v_anomaly_class VARCHAR2(32);
  p_abn_rec       scmdata.t_abnormal%ROWTYPE;
BEGIN

  p_abn_rec.abnormal_id   := :abnormal_id_pr;
  p_abn_rec.company_id    := %default_company_id%;
  p_abn_rec.abnormal_code := :abnormal_code_pr;
  p_abn_rec.order_id      := :order_id_pr;

  SELECT abn.anomaly_class
    INTO v_anomaly_class
    FROM scmdata.t_abnormal abn
   WHERE abn.abnormal_id = :abnormal_id_pr;

  p_abn_rec.anomaly_class := v_anomaly_class;

  IF v_anomaly_class = 'AC_DATE' THEN
    NULL;
  ELSIF v_anomaly_class = 'AC_QUALITY' THEN
    p_abn_rec.problem_class        := :problem_class_pr;
    p_abn_rec.cause_class          := :cause_class_pr;
    p_abn_rec.cause_detailed       := :cause_detailed_pr;
    p_abn_rec.detailed_reasons     := :detailed_reasons_pr;
    p_abn_rec.is_sup_responsible   := :is_sup_responsible;
    p_abn_rec.responsible_dept     := :responsible_dept_pr;
    p_abn_rec.responsible_dept_sec := :responsible_dept_sec_pr;
  END IF;

  p_abn_rec.delay_date           := :delay_date_pr;
  p_abn_rec.delay_amount         := :delay_amount_pr;
  p_abn_rec.responsible_party    := :responsible_party_pr;
  p_abn_rec.handle_opinions      := :handle_opinions_pr;
  p_abn_rec.is_deduction         := :is_deduction_pr;
  p_abn_rec.deduction_method     := :deduction_method_pr;
  p_abn_rec.deduction_unit_price := :deduction_unit_price_pr;
  p_abn_rec.file_id              := :file_id_pr;
  p_abn_rec.applicant_id         := :user_id;
  p_abn_rec.applicant_date       := SYSDATE;
  p_abn_rec.memo                 := :memo_pr;
  p_abn_rec.update_id            := :user_id;
  p_abn_rec.update_time          := SYSDATE;

  scmdata.pkg_production_progress.update_abnormal(p_abn_rec => p_abn_rec);

END;]';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_ITEM_LIST WHERE ITEM_ID = ''a_product_118''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_ITEM_LIST SET (AUTO_REFRESH,BACK_GROUND_ID,EDIT_EXPRESS,END_FIELD,EXECUTE_TIME,FOOTER,HEADER,HINT_TYPE,JUMP_EXPRESS,JUMP_FIELD,MAX_ROW_COUNT,MONITOR_ID,MULTI_PAGE_FLAG,NOADD_FIELDS,NOEDIT_FIELDS,NOMODIFY_FIELDS,NOSHOW_APP_FIELDS,NOSHOW_FIELDS,OPEN_MODE,OPERATION_TYPE,OUTPUT_PARAMETER,QUERY_COUNT,QUERY_FIELDS,QUERY_TYPE,RFID_FLAG,SCANNABLE_FIELD,SCANNABLE_LOCATION_LINE,SCANNABLE_TIME,SCANNABLE_TYPE,SUBNOSHOW_FIELDS,SUB_EDIT_STATE,SUB_TABLE_JUDGE_FIELD,UI_TMPL,DELETE_SQL,DETAIL_SQL,INSERT_SQL,LOCK_SQL,NEWID_SQL,OPRETION_HINT,SELECT_SQL,SUBSELECT_SQL,UPDATE_SQL) = (SELECT 1,q''[]'',q''[]'',q''[]'',,q''[]'',q''[]'',,q''[]'',q''[]'',,q''[]'',1,q''[]'',q''[]'',q''[]'',q''[]'',q''[product_gress_id,company_id,supplier_code_pr,factory_code_pr,order_id_pr,abnormal_id_pr,abnormal_status_pr,is_deduction_pr,handle_opinions_pr,anomaly_class_pr,responsible_party_pr,deduction_method_pr]'',,q''[]'',q''[]'',,q''[product_gress_code_pr]'',12,,q''[]'',q''[]'',,,q''[]'',,q''[]'',q''[]'',:CV1,:CV2,:CV3,:CV4,:CV5,:CV6,:CV7,:CV8,:CV9 FROM DUAL) WHERE ITEM_ID = ''a_product_118''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3,CV4,CV5,CV6,CV7,CV8,CV9;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_ITEM_LIST (AUTO_REFRESH,BACK_GROUND_ID,EDIT_EXPRESS,END_FIELD,EXECUTE_TIME,FOOTER,HEADER,HINT_TYPE,ITEM_ID,JUMP_EXPRESS,JUMP_FIELD,MAX_ROW_COUNT,MONITOR_ID,MULTI_PAGE_FLAG,NOADD_FIELDS,NOEDIT_FIELDS,NOMODIFY_FIELDS,NOSHOW_APP_FIELDS,NOSHOW_FIELDS,OPEN_MODE,OPERATION_TYPE,OUTPUT_PARAMETER,QUERY_COUNT,QUERY_FIELDS,QUERY_TYPE,RFID_FLAG,SCANNABLE_FIELD,SCANNABLE_LOCATION_LINE,SCANNABLE_TIME,SCANNABLE_TYPE,SUBNOSHOW_FIELDS,SUB_EDIT_STATE,SUB_TABLE_JUDGE_FIELD,UI_TMPL,DELETE_SQL,DETAIL_SQL,INSERT_SQL,LOCK_SQL,NEWID_SQL,OPRETION_HINT,SELECT_SQL,SUBSELECT_SQL,UPDATE_SQL) SELECT 1,q''[]'',q''[]'',q''[]'',,q''[]'',q''[]'',,''a_product_118'',q''[]'',q''[]'',,q''[]'',1,q''[]'',q''[]'',q''[]'',q''[]'',q''[product_gress_id,company_id,supplier_code_pr,factory_code_pr,order_id_pr,abnormal_id_pr,abnormal_status_pr,is_deduction_pr,handle_opinions_pr,anomaly_class_pr,responsible_party_pr,deduction_method_pr]'',,q''[]'',q''[]'',,q''[product_gress_code_pr]'',12,,q''[]'',q''[]'',,,q''[]'',,q''[]'',q''[]'',:CV1,:CV2,:CV3,:CV4,:CV5,:CV6,:CV7,:CV8,:CV9 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3,CV4,CV5,CV6,CV7,CV8,CV9;
     END IF;
  END;
END;
/

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
  CV7 CLOB:=q'[]';
  CV8 CLOB:=q'[]';
  CV9 CLOB:=q'[]';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_ITEM_LIST WHERE ITEM_ID = ''a_product_120''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_ITEM_LIST SET (AUTO_REFRESH,BACK_GROUND_ID,EDIT_EXPRESS,END_FIELD,EXECUTE_TIME,FOOTER,HEADER,HINT_TYPE,JUMP_EXPRESS,JUMP_FIELD,MAX_ROW_COUNT,MONITOR_ID,MULTI_PAGE_FLAG,NOADD_FIELDS,NOEDIT_FIELDS,NOMODIFY_FIELDS,NOSHOW_APP_FIELDS,NOSHOW_FIELDS,OPEN_MODE,OPERATION_TYPE,OUTPUT_PARAMETER,QUERY_COUNT,QUERY_FIELDS,QUERY_TYPE,RFID_FLAG,SCANNABLE_FIELD,SCANNABLE_LOCATION_LINE,SCANNABLE_TIME,SCANNABLE_TYPE,SUBNOSHOW_FIELDS,SUB_EDIT_STATE,SUB_TABLE_JUDGE_FIELD,UI_TMPL,DELETE_SQL,DETAIL_SQL,INSERT_SQL,LOCK_SQL,NEWID_SQL,OPRETION_HINT,SELECT_SQL,SUBSELECT_SQL,UPDATE_SQL) = (SELECT 1,q''[]'',q''[]'',q''[]'',,q''[]'',q''[]'',,q''[]'',q''[]'',,q''[]'',1,q''[]'',q''[]'',q''[]'',q''[]'',q''[]'',,q''[]'',q''[]'',,q''[]'',0,,q''[]'',q''[]'',,,q''[]'',,q''[]'',q''[]'',:CV1,:CV2,:CV3,:CV4,:CV5,:CV6,:CV7,:CV8,:CV9 FROM DUAL) WHERE ITEM_ID = ''a_product_120''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3,CV4,CV5,CV6,CV7,CV8,CV9;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_ITEM_LIST (AUTO_REFRESH,BACK_GROUND_ID,EDIT_EXPRESS,END_FIELD,EXECUTE_TIME,FOOTER,HEADER,HINT_TYPE,ITEM_ID,JUMP_EXPRESS,JUMP_FIELD,MAX_ROW_COUNT,MONITOR_ID,MULTI_PAGE_FLAG,NOADD_FIELDS,NOEDIT_FIELDS,NOMODIFY_FIELDS,NOSHOW_APP_FIELDS,NOSHOW_FIELDS,OPEN_MODE,OPERATION_TYPE,OUTPUT_PARAMETER,QUERY_COUNT,QUERY_FIELDS,QUERY_TYPE,RFID_FLAG,SCANNABLE_FIELD,SCANNABLE_LOCATION_LINE,SCANNABLE_TIME,SCANNABLE_TYPE,SUBNOSHOW_FIELDS,SUB_EDIT_STATE,SUB_TABLE_JUDGE_FIELD,UI_TMPL,DELETE_SQL,DETAIL_SQL,INSERT_SQL,LOCK_SQL,NEWID_SQL,OPRETION_HINT,SELECT_SQL,SUBSELECT_SQL,UPDATE_SQL) SELECT 1,q''[]'',q''[]'',q''[]'',,q''[]'',q''[]'',,''a_product_120'',q''[]'',q''[]'',,q''[]'',1,q''[]'',q''[]'',q''[]'',q''[]'',q''[]'',,q''[]'',q''[]'',,q''[]'',0,,q''[]'',q''[]'',,,q''[]'',,q''[]'',q''[]'',:CV1,:CV2,:CV3,:CV4,:CV5,:CV6,:CV7,:CV8,:CV9 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3,CV4,CV5,CV6,CV7,CV8,CV9;
     END IF;
  END;
END;
/

BEGIN
  DECLARE
    JUDGE_N NUMBER(4);
    EXE_SQL CLOB;
    VALS    CLOB;
  CV1 CLOB:=q'[DECLARE
  v_flag     NUMBER;
  v_abn_flag NUMBER;
  p_abn_rec  scmdata.t_abnormal%ROWTYPE;
BEGIN
  p_abn_rec.company_id := %default_company_id%;
  p_abn_rec.order_id   := :order_id_pr;
  p_abn_rec.goo_id     := :goo_id_pr;

  DELETE FROM scmdata.t_abnormal abn
   WHERE abn.company_id = %default_company_id%
     AND abn.abnormal_id = :abnormal_id;

  --1.校验待处理列表是否有异常单，有则处理中，
  --2.无则校验已处理列表是否有异常单，有则已处理，无则无异常
  SELECT COUNT(1)
    INTO v_flag
    FROM scmdata.t_abnormal t
   WHERE t.company_id = p_abn_rec.company_id
        AND t.order_id = p_abn_rec.order_id
     AND t.goo_id = p_abn_rec.goo_id
     AND t.progress_status = '01';

  IF v_flag > 0 THEN

    scmdata.pkg_production_progress.sync_abnormal(p_abn_rec => p_abn_rec,
                                                  p_status  => '01');
  ELSE

    SELECT COUNT(1)
      INTO v_abn_flag
      FROM scmdata.t_abnormal t
     WHERE t.company_id = p_abn_rec.company_id
        AND t.order_id = p_abn_rec.order_id
       AND t.goo_id = p_abn_rec.goo_id
       AND t.progress_status = '02';

    IF v_abn_flag > 0 THEN
      p_abn_rec.handle_opinions := :handle_opinions_pr;
      scmdata.pkg_production_progress.sync_abnormal(p_abn_rec => p_abn_rec,
                                                    p_status  => '02');
    ELSE
      p_abn_rec.handle_opinions := '';
      scmdata.pkg_production_progress.sync_abnormal(p_abn_rec => p_abn_rec,
                                                    p_status  => '00');
    END IF;

  END IF;
END;]';
  CV2 CLOB:=q'[]';
  CV3 CLOB:=q'[]';
  CV4 CLOB:=q'[]';
  CV5 CLOB:=q'[]';
  CV6 CLOB:=q'[]';
  CV7 CLOB:=q'[WITH supp AS
 (SELECT sp.company_id, sp.supplier_code, sp.supplier_company_name
    FROM scmdata.t_supplier_info sp),
group_dict AS
 (SELECT group_dict_type, group_dict_value, group_dict_name
    FROM scmdata.sys_group_dict),
su_user AS
 (SELECT su.company_id, su.user_id, su.company_user_name
    FROM scmdata.sys_company_user su)
SELECT t.product_gress_id,
       t.company_id,
       t.order_id order_id_pr,
       a.abnormal_id,
       a.anomaly_class anomaly_class_pr,
       gd.group_dict_name anomaly_class_desc,
       t.product_gress_code product_gress_code_pr,
       cf.rela_goo_id,
       a.detailed_reasons detailed_reasons_pr, --问题描述
       a.delay_date delay_date_pr, --延期天数
       a.delay_amount delay_amount_pr, --延期数量
       a.handle_opinions handle_opinions_pr,
       a.is_deduction is_deduction_pr,
       a.deduction_method deduction_method_pr,
       a.deduction_unit_price deduction_unit_price_pr,
       a.file_id file_id_pr,
       a.problem_class problem_class_pr,
       a.cause_class cause_class_pr,
       a.cause_detailed cause_detailed_pr,
       a.is_sup_responsible,
       --a.responsible_party responsible_party_pr,
       a.responsible_dept responsible_dept_pr,
       a.responsible_dept_sec responsible_dept_sec_pr,
       a.memo memo_pr,
       decode(t.progress_status,
              '02',
              (SELECT pno_status
                 FROM (SELECT pn.node_name ||
                              (SELECT a.group_dict_name
                                 FROM group_dict a
                                INNER JOIN group_dict b
                                   ON a.group_dict_type = b.group_dict_value
                                  AND b.group_dict_value = 'PROGRESS_NODE_TYPE'
                                WHERE a.group_dict_value = pn.progress_status) pno_status
                         FROM scmdata.t_production_node pn
                        WHERE pn.company_id = t.company_id
                          AND pn.product_gress_id = t.product_gress_id
                          AND pn.progress_status IS NOT NULL
                        ORDER BY pn.node_num DESC)
                WHERE rownum = 1),
              '00',
              (SELECT a.group_dict_name
                 FROM group_dict a
                WHERE a.group_dict_type = 'PROGRESS_TYPE'
                  AND a.group_dict_value = t.progress_status)) progress_status_desc,
       t.supplier_code supplier_code_pr,
       sp2.supplier_company_name supplier_company_name_pr,
       t.goo_id goo_id_pr,
       cf.style_number style_number_pr,
       cf.style_name style_name_pr,
       t.order_amount order_amount_pr,
       od.delivery_date delivery_date_pr,
       --t.delivery_amount delivery_amount_pr,
       t.latest_planned_delivery_date latest_planned_delivery_date_pr,
       sa.company_user_name create_id,
       a.create_time,
       sc.company_user_name update_id,
       a.update_time,
       sb.company_user_name confirm_id,
       a.confirm_date confirm_date
  FROM scmdata.t_ordered oh
 INNER JOIN scmdata.t_orders od
    ON oh.company_id = od.company_id
   AND oh.order_code = od.order_id
   AND oh.order_status = 'OS01'
 INNER JOIN t_production_progress t
    ON t.company_id = od.company_id
   AND t.order_id = od.order_id
   AND t.goo_id = od.goo_id
 INNER JOIN scmdata.t_commodity_info cf
    ON t.company_id = cf.company_id
   AND t.goo_id = cf.goo_id
/*LEFT JOIN supp sp1
 ON t.company_id = sp1.company_id
AND t.factory_code = sp1.supplier_code*/
 INNER JOIN supp sp2
    ON t.company_id = sp2.company_id
   AND t.supplier_code = sp2.supplier_code
 INNER JOIN scmdata.t_abnormal a
    ON t.company_id = a.company_id
   AND t.order_id = a.order_id
   AND t.goo_id = a.goo_id
   AND a.progress_status = '01'
   AND a.origin <> 'SC'
 INNER JOIN su_user sa
    ON a.company_id = sa.company_id
   AND a.create_id = sa.user_id
  LEFT JOIN su_user sb
    ON a.company_id = sb.company_id
   AND a.confirm_id = sb.user_id
  LEFT JOIN su_user sc
    ON a.company_id = sc.company_id
   AND a.update_id = sc.user_id
 INNER JOIN scmdata.sys_group_dict gd
    ON gd.group_dict_type = 'ANOMALY_CLASSIFICATION_DICT'
   AND gd.group_dict_value = a.anomaly_class
 WHERE oh.company_id = %default_company_id%
 ORDER BY a.create_time DESC]';
  CV8 CLOB:=q'[]';
  CV9 CLOB:=q'[DECLARE
  v_abnormal_code VARCHAR2(32);
  v_anomaly_class VARCHAR2(32);
  p_abn_rec       scmdata.t_abnormal%ROWTYPE;
BEGIN

  p_abn_rec.abnormal_id   := :abnormal_id;
  p_abn_rec.company_id    := %default_company_id%;
  p_abn_rec.abnormal_code := :abnormal_code_pr;
  p_abn_rec.order_id      := :order_id_pr;

  SELECT abn.anomaly_class
    INTO v_anomaly_class
    FROM scmdata.t_abnormal abn
   WHERE abn.abnormal_id = :abnormal_id;

  p_abn_rec.anomaly_class := v_anomaly_class;

  IF v_anomaly_class = 'AC_DATE' THEN
    NULL;
  ELSIF v_anomaly_class = 'AC_QUALITY' THEN
    p_abn_rec.problem_class        := :problem_class_pr;
    p_abn_rec.cause_class          := :cause_class_pr;
    p_abn_rec.cause_detailed       := :cause_detailed_pr;
    p_abn_rec.detailed_reasons     := :detailed_reasons_pr;
    p_abn_rec.is_sup_responsible   := :is_sup_responsible;
    p_abn_rec.responsible_dept     := :responsible_dept_pr;
    p_abn_rec.responsible_dept_sec := :responsible_dept_sec_pr;
  END IF;

  p_abn_rec.delay_date           := :delay_date_pr;
  p_abn_rec.delay_amount         := :delay_amount_pr;
  p_abn_rec.responsible_party    := :responsible_party_pr;
  p_abn_rec.handle_opinions      := :handle_opinions_pr;
  p_abn_rec.is_deduction         := :is_deduction_pr;
  p_abn_rec.deduction_method     := :deduction_method_pr;
  p_abn_rec.deduction_unit_price := :deduction_unit_price_pr;
  p_abn_rec.file_id              := :file_id_pr;
  p_abn_rec.applicant_id         := :user_id;
  p_abn_rec.applicant_date       := SYSDATE;
  p_abn_rec.memo                 := :memo_pr;
  p_abn_rec.update_id            := :user_id;
  p_abn_rec.update_time          := SYSDATE;

  scmdata.pkg_production_progress.update_abnormal(p_abn_rec => p_abn_rec);

END;


/*DECLARE
  v_abnormal_code VARCHAR2(32);
  p_abn_rec       scmdata.t_abnormal%ROWTYPE;
BEGIN

  p_abn_rec.abnormal_id          := :abnormal_id;
  p_abn_rec.company_id           := %default_company_id%;
  p_abn_rec.abnormal_code        := :abnormal_code_pr;
  p_abn_rec.order_id             := :order_id_pr;
  --p_abn_rec.goo_id             := :rela_goo_id;
  p_abn_rec.anomaly_class        := :anomaly_class_pr;
  p_abn_rec.problem_class        := :problem_class_pr;
  p_abn_rec.cause_class          := :cause_class_pr;
  p_abn_rec.detailed_reasons     := :detailed_reasons_pr;
  p_abn_rec.delay_date           := :delay_date_pr;
  p_abn_rec.delay_amount         := :delay_amount_pr;
  p_abn_rec.responsible_party    := :responsible_party_pr;
  p_abn_rec.responsible_dept     := :responsible_dept_pr;
  p_abn_rec.handle_opinions      := :handle_opinions_pr;
  p_abn_rec.is_deduction         := :is_deduction_pr;
  p_abn_rec.deduction_method     := :deduction_method_pr;
  p_abn_rec.deduction_unit_price := :deduction_unit_price_pr;
  p_abn_rec.file_id              := :file_id_pr;
  p_abn_rec.applicant_id         := :user_id;
  p_abn_rec.applicant_date       := sysdate;
  p_abn_rec.memo                 := :memo_pr;
  p_abn_rec.update_id            := :user_id;
  p_abn_rec.update_time          := SYSDATE;

  scmdata.pkg_production_progress.update_abnormal(p_abn_rec => p_abn_rec);

END;*/]';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_ITEM_LIST WHERE ITEM_ID = ''a_product_120_1''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_ITEM_LIST SET (AUTO_REFRESH,BACK_GROUND_ID,EDIT_EXPRESS,END_FIELD,EXECUTE_TIME,FOOTER,HEADER,HINT_TYPE,JUMP_EXPRESS,JUMP_FIELD,MAX_ROW_COUNT,MONITOR_ID,MULTI_PAGE_FLAG,NOADD_FIELDS,NOEDIT_FIELDS,NOMODIFY_FIELDS,NOSHOW_APP_FIELDS,NOSHOW_FIELDS,OPEN_MODE,OPERATION_TYPE,OUTPUT_PARAMETER,QUERY_COUNT,QUERY_FIELDS,QUERY_TYPE,RFID_FLAG,SCANNABLE_FIELD,SCANNABLE_LOCATION_LINE,SCANNABLE_TIME,SCANNABLE_TYPE,SUBNOSHOW_FIELDS,SUB_EDIT_STATE,SUB_TABLE_JUDGE_FIELD,UI_TMPL,DELETE_SQL,DETAIL_SQL,INSERT_SQL,LOCK_SQL,NEWID_SQL,OPRETION_HINT,SELECT_SQL,SUBSELECT_SQL,UPDATE_SQL) = (SELECT 1,q''[]'',q''[]'',q''[]'',,q''[]'',q''[]'',,q''[]'',q''[]'',,q''[]'',1,q''[]'',q''[]'',q''[]'',q''[]'',q''[abnormal_id,anomaly_class_pr,product_gress_id,company_id,supplier_code_pr,factory_code_pr,order_id_pr,abnormal_status_pr,handle_opinions_pr,is_deduction_pr,confirm_id,confirm_date,deduction_method_pr,responsible_party_pr]'',,q''[]'',q''[]'',,q''[product_gress_code_pr]'',12,,q''[]'',q''[]'',,,q''[]'',,q''[]'',q''[]'',:CV1,:CV2,:CV3,:CV4,:CV5,:CV6,:CV7,:CV8,:CV9 FROM DUAL) WHERE ITEM_ID = ''a_product_120_1''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3,CV4,CV5,CV6,CV7,CV8,CV9;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_ITEM_LIST (AUTO_REFRESH,BACK_GROUND_ID,EDIT_EXPRESS,END_FIELD,EXECUTE_TIME,FOOTER,HEADER,HINT_TYPE,ITEM_ID,JUMP_EXPRESS,JUMP_FIELD,MAX_ROW_COUNT,MONITOR_ID,MULTI_PAGE_FLAG,NOADD_FIELDS,NOEDIT_FIELDS,NOMODIFY_FIELDS,NOSHOW_APP_FIELDS,NOSHOW_FIELDS,OPEN_MODE,OPERATION_TYPE,OUTPUT_PARAMETER,QUERY_COUNT,QUERY_FIELDS,QUERY_TYPE,RFID_FLAG,SCANNABLE_FIELD,SCANNABLE_LOCATION_LINE,SCANNABLE_TIME,SCANNABLE_TYPE,SUBNOSHOW_FIELDS,SUB_EDIT_STATE,SUB_TABLE_JUDGE_FIELD,UI_TMPL,DELETE_SQL,DETAIL_SQL,INSERT_SQL,LOCK_SQL,NEWID_SQL,OPRETION_HINT,SELECT_SQL,SUBSELECT_SQL,UPDATE_SQL) SELECT 1,q''[]'',q''[]'',q''[]'',,q''[]'',q''[]'',,''a_product_120_1'',q''[]'',q''[]'',,q''[]'',1,q''[]'',q''[]'',q''[]'',q''[]'',q''[abnormal_id,anomaly_class_pr,product_gress_id,company_id,supplier_code_pr,factory_code_pr,order_id_pr,abnormal_status_pr,handle_opinions_pr,is_deduction_pr,confirm_id,confirm_date,deduction_method_pr,responsible_party_pr]'',,q''[]'',q''[]'',,q''[product_gress_code_pr]'',12,,q''[]'',q''[]'',,,q''[]'',,q''[]'',q''[]'',:CV1,:CV2,:CV3,:CV4,:CV5,:CV6,:CV7,:CV8,:CV9 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3,CV4,CV5,CV6,CV7,CV8,CV9;
     END IF;
  END;
END;
/

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
  CV7 CLOB:=q'[WITH supp AS
 (SELECT sp.company_id, sp.supplier_code, sp.supplier_company_name
    FROM scmdata.t_supplier_info sp),
group_dict AS
 (SELECT group_dict_type, group_dict_value, group_dict_name
    FROM scmdata.sys_group_dict),
su_user AS
 (SELECT su.company_id, su.user_id, su.company_user_name
    FROM scmdata.sys_company_user su)
SELECT t.product_gress_id,
       t.company_id,
       t.order_id order_id_pr,
       a.abnormal_id,
       a.anomaly_class anomaly_class_pr,
       gd.group_dict_name anomaly_class_desc,
       t.product_gress_code product_gress_code_pr,
       cf.rela_goo_id,
       a.detailed_reasons detailed_reasons_pr, --问题描述
       a.delay_date delay_date_pr, --延期天数
       a.delay_amount delay_amount_pr, --延期数量
       a.handle_opinions handle_opinions_pr,
       a.is_deduction is_deduction_pr,
       (SELECT b.group_dict_name
          FROM group_dict b
         WHERE b.group_dict_type = 'DEDUCTION_METHOD'
           AND b.group_dict_value = a.deduction_method) deduction_method_desc,
       a.deduction_unit_price deduction_unit_price_pr,
       a.file_id file_id_pr,
       a.problem_class problem_class_pr,
       a.cause_class cause_class_pr,
       a.cause_detailed cause_detailed_pr,
       a.is_sup_responsible,
       --a.responsible_party responsible_party_pr,
       a.responsible_dept responsible_dept_pr,
       a.responsible_dept_sec responsible_dept_sec_pr,
       a.memo memo_pr,
       decode(t.progress_status,
              '02',
              (SELECT pno_status
                 FROM (SELECT pn.node_name ||
                              (SELECT a.group_dict_name
                                 FROM group_dict a
                                INNER JOIN group_dict b
                                   ON a.group_dict_type = b.group_dict_value
                                  AND b.group_dict_value = 'PROGRESS_NODE_TYPE'
                                WHERE a.group_dict_value = pn.progress_status) pno_status
                         FROM scmdata.t_production_node pn
                        WHERE pn.company_id = t.company_id
                          AND pn.product_gress_id = t.product_gress_id
                          AND pn.progress_status IS NOT NULL
                        ORDER BY pn.node_num DESC)
                WHERE rownum = 1),
              (SELECT a.group_dict_name
                 FROM group_dict a
                WHERE a.group_dict_type = 'PROGRESS_TYPE'
                  AND a.group_dict_value = t.progress_status)) progress_status_desc,
       t.supplier_code supplier_code_pr,
       sp2.supplier_company_name supplier_company_name_pr,
       t.goo_id goo_id_pr,
       cf.style_number style_number_pr,
       cf.style_name style_name_pr,
       t.order_amount order_amount_pr,
       od.delivery_date delivery_date_pr,
       --t.delivery_amount delivery_amount_pr,
       t.latest_planned_delivery_date latest_planned_delivery_date_pr,
       sa.company_user_name create_id,
       a.create_time,
       sc.company_user_name update_id,
       a.update_time,
       sb.company_user_name confirm_id,
       a.confirm_date confirm_date
  FROM scmdata.t_ordered oh
 INNER JOIN scmdata.t_orders od
    ON oh.company_id = od.company_id
   AND oh.order_code = od.order_id
   AND oh.order_status IN ('OS01', 'OS02') --待修改
 INNER JOIN t_production_progress t
    ON t.company_id = od.company_id
   AND t.order_id = od.order_id
   AND t.goo_id = od.goo_id
 INNER JOIN scmdata.t_commodity_info cf
    ON t.company_id = cf.company_id
   AND t.goo_id = cf.goo_id
/*LEFT JOIN supp sp1
 ON t.company_id = sp1.company_id
AND t.factory_code = sp1.supplier_code*/
 INNER JOIN supp sp2
    ON t.company_id = sp2.company_id
   AND t.supplier_code = sp2.supplier_code
 INNER JOIN scmdata.t_abnormal a
    ON t.company_id = a.company_id
   AND t.order_id = a.order_id
   AND t.goo_id = a.goo_id
   AND a.progress_status = '02'
   AND a.origin <> 'SC'
 INNER JOIN su_user sa
    ON a.company_id = sa.company_id
   AND a.create_id = sa.user_id
 INNER JOIN su_user sb
    ON a.company_id = sb.company_id
   AND a.confirm_id = sb.user_id
  LEFT JOIN su_user sc
    ON a.company_id = sc.company_id
   AND a.update_id = sc.user_id
 INNER JOIN scmdata.sys_group_dict gd
    ON gd.group_dict_type = 'ANOMALY_CLASSIFICATION_DICT'
   AND gd.group_dict_value = a.anomaly_class
 WHERE oh.company_id = %default_company_id%
 ORDER BY a.confirm_date DESC]';
  CV8 CLOB:=q'[]';
  CV9 CLOB:=q'[]';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_ITEM_LIST WHERE ITEM_ID = ''a_product_120_2''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_ITEM_LIST SET (AUTO_REFRESH,BACK_GROUND_ID,EDIT_EXPRESS,END_FIELD,EXECUTE_TIME,FOOTER,HEADER,HINT_TYPE,JUMP_EXPRESS,JUMP_FIELD,MAX_ROW_COUNT,MONITOR_ID,MULTI_PAGE_FLAG,NOADD_FIELDS,NOEDIT_FIELDS,NOMODIFY_FIELDS,NOSHOW_APP_FIELDS,NOSHOW_FIELDS,OPEN_MODE,OPERATION_TYPE,OUTPUT_PARAMETER,QUERY_COUNT,QUERY_FIELDS,QUERY_TYPE,RFID_FLAG,SCANNABLE_FIELD,SCANNABLE_LOCATION_LINE,SCANNABLE_TIME,SCANNABLE_TYPE,SUBNOSHOW_FIELDS,SUB_EDIT_STATE,SUB_TABLE_JUDGE_FIELD,UI_TMPL,DELETE_SQL,DETAIL_SQL,INSERT_SQL,LOCK_SQL,NEWID_SQL,OPRETION_HINT,SELECT_SQL,SUBSELECT_SQL,UPDATE_SQL) = (SELECT 1,q''[]'',q''[]'',q''[]'',,q''[]'',q''[]'',,q''[]'',q''[]'',,q''[]'',1,q''[]'',q''[]'',q''[]'',q''[]'',q''[anomaly_class_pr,product_gress_id,company_id,supplier_code_pr,factory_code_pr,order_id_pr,abnormal_id,abnormal_status_pr,handle_opinions_pr,is_deduction_pr]'',,q''[]'',q''[]'',,q''[product_gress_code_pr]'',12,,q''[]'',q''[]'',,,q''[]'',,q''[]'',q''[]'',:CV1,:CV2,:CV3,:CV4,:CV5,:CV6,:CV7,:CV8,:CV9 FROM DUAL) WHERE ITEM_ID = ''a_product_120_2''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3,CV4,CV5,CV6,CV7,CV8,CV9;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_ITEM_LIST (AUTO_REFRESH,BACK_GROUND_ID,EDIT_EXPRESS,END_FIELD,EXECUTE_TIME,FOOTER,HEADER,HINT_TYPE,ITEM_ID,JUMP_EXPRESS,JUMP_FIELD,MAX_ROW_COUNT,MONITOR_ID,MULTI_PAGE_FLAG,NOADD_FIELDS,NOEDIT_FIELDS,NOMODIFY_FIELDS,NOSHOW_APP_FIELDS,NOSHOW_FIELDS,OPEN_MODE,OPERATION_TYPE,OUTPUT_PARAMETER,QUERY_COUNT,QUERY_FIELDS,QUERY_TYPE,RFID_FLAG,SCANNABLE_FIELD,SCANNABLE_LOCATION_LINE,SCANNABLE_TIME,SCANNABLE_TYPE,SUBNOSHOW_FIELDS,SUB_EDIT_STATE,SUB_TABLE_JUDGE_FIELD,UI_TMPL,DELETE_SQL,DETAIL_SQL,INSERT_SQL,LOCK_SQL,NEWID_SQL,OPRETION_HINT,SELECT_SQL,SUBSELECT_SQL,UPDATE_SQL) SELECT 1,q''[]'',q''[]'',q''[]'',,q''[]'',q''[]'',,''a_product_120_2'',q''[]'',q''[]'',,q''[]'',1,q''[]'',q''[]'',q''[]'',q''[]'',q''[anomaly_class_pr,product_gress_id,company_id,supplier_code_pr,factory_code_pr,order_id_pr,abnormal_id,abnormal_status_pr,handle_opinions_pr,is_deduction_pr]'',,q''[]'',q''[]'',,q''[product_gress_code_pr]'',12,,q''[]'',q''[]'',,,q''[]'',,q''[]'',q''[]'',:CV1,:CV2,:CV3,:CV4,:CV5,:CV6,:CV7,:CV8,:CV9 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3,CV4,CV5,CV6,CV7,CV8,CV9;
     END IF;
  END;
END;
/

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
  CV7 CLOB:=q'[]';
  CV8 CLOB:=q'[]';
  CV9 CLOB:=q'[]';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_ITEM_LIST WHERE ITEM_ID = ''a_product_130''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_ITEM_LIST SET (AUTO_REFRESH,BACK_GROUND_ID,EDIT_EXPRESS,END_FIELD,EXECUTE_TIME,FOOTER,HEADER,HINT_TYPE,JUMP_EXPRESS,JUMP_FIELD,MAX_ROW_COUNT,MONITOR_ID,MULTI_PAGE_FLAG,NOADD_FIELDS,NOEDIT_FIELDS,NOMODIFY_FIELDS,NOSHOW_APP_FIELDS,NOSHOW_FIELDS,OPEN_MODE,OPERATION_TYPE,OUTPUT_PARAMETER,QUERY_COUNT,QUERY_FIELDS,QUERY_TYPE,RFID_FLAG,SCANNABLE_FIELD,SCANNABLE_LOCATION_LINE,SCANNABLE_TIME,SCANNABLE_TYPE,SUBNOSHOW_FIELDS,SUB_EDIT_STATE,SUB_TABLE_JUDGE_FIELD,UI_TMPL,DELETE_SQL,DETAIL_SQL,INSERT_SQL,LOCK_SQL,NEWID_SQL,OPRETION_HINT,SELECT_SQL,SUBSELECT_SQL,UPDATE_SQL) = (SELECT 1,q''[]'',q''[]'',q''[]'',,q''[]'',q''[]'',,q''[]'',q''[]'',,q''[]'',1,q''[]'',q''[]'',q''[]'',q''[]'',q''[]'',,q''[]'',q''[]'',,q''[]'',0,,q''[]'',q''[]'',,,q''[]'',,q''[]'',q''[]'',:CV1,:CV2,:CV3,:CV4,:CV5,:CV6,:CV7,:CV8,:CV9 FROM DUAL) WHERE ITEM_ID = ''a_product_130''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3,CV4,CV5,CV6,CV7,CV8,CV9;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_ITEM_LIST (AUTO_REFRESH,BACK_GROUND_ID,EDIT_EXPRESS,END_FIELD,EXECUTE_TIME,FOOTER,HEADER,HINT_TYPE,ITEM_ID,JUMP_EXPRESS,JUMP_FIELD,MAX_ROW_COUNT,MONITOR_ID,MULTI_PAGE_FLAG,NOADD_FIELDS,NOEDIT_FIELDS,NOMODIFY_FIELDS,NOSHOW_APP_FIELDS,NOSHOW_FIELDS,OPEN_MODE,OPERATION_TYPE,OUTPUT_PARAMETER,QUERY_COUNT,QUERY_FIELDS,QUERY_TYPE,RFID_FLAG,SCANNABLE_FIELD,SCANNABLE_LOCATION_LINE,SCANNABLE_TIME,SCANNABLE_TYPE,SUBNOSHOW_FIELDS,SUB_EDIT_STATE,SUB_TABLE_JUDGE_FIELD,UI_TMPL,DELETE_SQL,DETAIL_SQL,INSERT_SQL,LOCK_SQL,NEWID_SQL,OPRETION_HINT,SELECT_SQL,SUBSELECT_SQL,UPDATE_SQL) SELECT 1,q''[]'',q''[]'',q''[]'',,q''[]'',q''[]'',,''a_product_130'',q''[]'',q''[]'',,q''[]'',1,q''[]'',q''[]'',q''[]'',q''[]'',q''[]'',,q''[]'',q''[]'',,q''[]'',0,,q''[]'',q''[]'',,,q''[]'',,q''[]'',q''[]'',:CV1,:CV2,:CV3,:CV4,:CV5,:CV6,:CV7,:CV8,:CV9 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3,CV4,CV5,CV6,CV7,CV8,CV9;
     END IF;
  END;
END;
/

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
  CV7 CLOB:=q'[SELECT DISTINCT po.order_id,
                po.company_id,
                po.approve_status,
                po.order_code,
                fc.supplier_company_name,
                listagg(DISTINCT tc.rela_goo_id, ';') within GROUP(ORDER BY pln.goo_id) over(PARTITION BY pln.order_id) rela_goo_id,
                SUM(pln.order_amount) over(PARTITION BY pln.order_id) order_amount,
                po.delivery_date,
                MAX(pln.delivery_date) over(PARTITION BY pln.order_id) latest_delivery_date,
                (SELECT MAX(dr.delivery_date)
                   FROM t_delivery_record dr
                  WHERE pr.company_id = dr.company_id
                    AND pr.order_id = dr.order_code
                    AND pr.goo_id = dr.goo_id) actual_delivery_date_dr,
                (SELECT SUM(dr.delivery_amount)
                   FROM t_delivery_record dr
                  WHERE pr.company_id = dr.company_id
                    AND pr.order_id = dr.order_code
                    AND pr.goo_id = dr.goo_id) delivery_amount_dr,
                MAX(pr.actual_delay_day) over(PARTITION BY pr.order_id) actual_delay_day,
                (SELECT SUM(abn.delay_amount)
                   FROM t_deduction td
                  INNER JOIN scmdata.t_abnormal abn
                     ON td.company_id = abn.company_id
                    AND td.abnormal_id = abn.abnormal_id
                    AND td.orgin = 'SC'
                  WHERE td.company_id = pr.company_id
                    AND td.order_id = pr.order_id) delivery_amount,
                (SELECT SUM(td.actual_discount_price)
                   FROM t_deduction td
                  WHERE td.company_id = pr.company_id
                    AND td.order_id = pr.order_id) actual_price,
                po.approve_id approve_id_po,
                po.approve_time approve_time_po,
                po.finish_time_scm,
                listagg(DISTINCT pln.goo_id, ';') within GROUP(ORDER BY pln.goo_id) over(PARTITION BY pln.order_id) goo_id
  FROM scmdata.t_ordered po
 INNER JOIN scmdata.t_orders pln
    ON po.company_id = pln.company_id
   AND po.order_code = pln.order_id
 INNER JOIN scmdata.t_production_progress pr
    ON pln.company_id = pr.company_id
   AND pln.order_id = pr.order_id
   AND pln.goo_id = pr.goo_id
 INNER JOIN scmdata.t_supplier_info fc
    ON po.company_id = fc.company_id
   AND po.supplier_code = fc.supplier_code
 INNER JOIN scmdata.t_commodity_info tc
    ON tc.company_id = pr.company_id
   AND tc.goo_id = pr.goo_id
 WHERE po.company_id = %default_company_id%
   AND po.approve_status = '00'
 ORDER BY po.finish_time_scm DESC]';
  CV8 CLOB:=q'[]';
  CV9 CLOB:=q'[]';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_ITEM_LIST WHERE ITEM_ID = ''a_product_130_1''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_ITEM_LIST SET (AUTO_REFRESH,BACK_GROUND_ID,EDIT_EXPRESS,END_FIELD,EXECUTE_TIME,FOOTER,HEADER,HINT_TYPE,JUMP_EXPRESS,JUMP_FIELD,MAX_ROW_COUNT,MONITOR_ID,MULTI_PAGE_FLAG,NOADD_FIELDS,NOEDIT_FIELDS,NOMODIFY_FIELDS,NOSHOW_APP_FIELDS,NOSHOW_FIELDS,OPEN_MODE,OPERATION_TYPE,OUTPUT_PARAMETER,QUERY_COUNT,QUERY_FIELDS,QUERY_TYPE,RFID_FLAG,SCANNABLE_FIELD,SCANNABLE_LOCATION_LINE,SCANNABLE_TIME,SCANNABLE_TYPE,SUBNOSHOW_FIELDS,SUB_EDIT_STATE,SUB_TABLE_JUDGE_FIELD,UI_TMPL,DELETE_SQL,DETAIL_SQL,INSERT_SQL,LOCK_SQL,NEWID_SQL,OPRETION_HINT,SELECT_SQL,SUBSELECT_SQL,UPDATE_SQL) = (SELECT 1,q''[]'',q''[]'',q''[]'',,q''[]'',q''[]'',,q''[]'',q''[]'',,q''[]'',1,q''[]'',q''[]'',q''[]'',q''[]'',q''[order_id,company_id,approve_status,approve_id_po,approve_time_po,finish_time_scm]'',,q''[]'',q''[]'',,q''[order_code]'',12,,q''[]'',q''[]'',,,q''[]'',,q''[]'',q''[]'',:CV1,:CV2,:CV3,:CV4,:CV5,:CV6,:CV7,:CV8,:CV9 FROM DUAL) WHERE ITEM_ID = ''a_product_130_1''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3,CV4,CV5,CV6,CV7,CV8,CV9;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_ITEM_LIST (AUTO_REFRESH,BACK_GROUND_ID,EDIT_EXPRESS,END_FIELD,EXECUTE_TIME,FOOTER,HEADER,HINT_TYPE,ITEM_ID,JUMP_EXPRESS,JUMP_FIELD,MAX_ROW_COUNT,MONITOR_ID,MULTI_PAGE_FLAG,NOADD_FIELDS,NOEDIT_FIELDS,NOMODIFY_FIELDS,NOSHOW_APP_FIELDS,NOSHOW_FIELDS,OPEN_MODE,OPERATION_TYPE,OUTPUT_PARAMETER,QUERY_COUNT,QUERY_FIELDS,QUERY_TYPE,RFID_FLAG,SCANNABLE_FIELD,SCANNABLE_LOCATION_LINE,SCANNABLE_TIME,SCANNABLE_TYPE,SUBNOSHOW_FIELDS,SUB_EDIT_STATE,SUB_TABLE_JUDGE_FIELD,UI_TMPL,DELETE_SQL,DETAIL_SQL,INSERT_SQL,LOCK_SQL,NEWID_SQL,OPRETION_HINT,SELECT_SQL,SUBSELECT_SQL,UPDATE_SQL) SELECT 1,q''[]'',q''[]'',q''[]'',,q''[]'',q''[]'',,''a_product_130_1'',q''[]'',q''[]'',,q''[]'',1,q''[]'',q''[]'',q''[]'',q''[]'',q''[order_id,company_id,approve_status,approve_id_po,approve_time_po,finish_time_scm]'',,q''[]'',q''[]'',,q''[order_code]'',12,,q''[]'',q''[]'',,,q''[]'',,q''[]'',q''[]'',:CV1,:CV2,:CV3,:CV4,:CV5,:CV6,:CV7,:CV8,:CV9 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3,CV4,CV5,CV6,CV7,CV8,CV9;
     END IF;
  END;
END;
/

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
  CV7 CLOB:=q'[SELECT DISTINCT po.order_id,
                po.company_id,
                po.approve_status,
                po.order_code,
                fc.supplier_company_name,
                --po.supplier_code,
                --po.order_type,
                listagg(DISTINCT tc.rela_goo_id, ';') within GROUP(ORDER BY pln.goo_id) over(PARTITION BY pln.order_id) rela_goo_id,
                SUM(pln.order_amount) over(PARTITION BY pln.order_id) order_amount,
                po.delivery_date,
                MAX(pln.delivery_date) over(PARTITION BY pln.order_id) latest_delivery_date,
                (SELECT MAX(dr.delivery_date)
                   FROM t_delivery_record dr
                  WHERE pr.company_id = dr.company_id
                    AND pr.order_id = dr.order_code
                    AND pr.goo_id = dr.goo_id) actual_delivery_date_dr,
                (SELECT SUM(dr.delivery_amount)
                   FROM t_delivery_record dr
                  WHERE pr.company_id = dr.company_id
                    AND pr.order_id = dr.order_code
                    AND pr.goo_id = dr.goo_id) delivery_amount_dr,
                MAX(pr.actual_delay_day) over(PARTITION BY pr.order_id) actual_delay_day,
                --SUM(pr.delivery_amount) over(PARTITION BY pr.order_id) delivery_amount,
                (SELECT SUM(abn.delay_amount)
                   FROM t_deduction td
                  INNER JOIN scmdata.t_abnormal abn
                     ON td.company_id = abn.company_id
                    AND td.abnormal_id = abn.abnormal_id
                    AND td.orgin = 'SC'
                  WHERE td.company_id = pr.company_id
                    AND td.order_id = pr.order_id) delivery_amount,
                (SELECT SUM(td.actual_discount_price)
                   FROM t_deduction td
                  WHERE td.company_id = pr.company_id
                    AND td.order_id = pr.order_id) actual_price,
                su.company_user_name approve_id_po,
                po.approve_time approve_time_po,
                listagg(DISTINCT pln.goo_id, ';') within GROUP(ORDER BY pln.goo_id) over(PARTITION BY pln.order_id) goo_id
  FROM scmdata.t_ordered po
 INNER JOIN scmdata.t_orders pln
    ON po.company_id = pln.company_id
   AND po.order_code = pln.order_id
 INNER JOIN scmdata.t_production_progress pr
    ON pln.company_id = pr.company_id
   AND pln.order_id = pr.order_id
   AND pln.goo_id = pr.goo_id
 INNER JOIN scmdata.t_supplier_info fc
    ON po.company_id = fc.company_id
   AND po.supplier_code = fc.supplier_code
 INNER JOIN scmdata.t_commodity_info tc
    ON tc.company_id = pr.company_id
   AND tc.goo_id = pr.goo_id
 INNER JOIN scmdata.sys_company_user su
    ON su.company_id = po.company_id
   AND su.user_id = po.approve_id
 WHERE po.company_id = %default_company_id%
   AND po.approve_status = '01'
 ORDER BY po.approve_time DESC]';
  CV8 CLOB:=q'[]';
  CV9 CLOB:=q'[]';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_ITEM_LIST WHERE ITEM_ID = ''a_product_130_2''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_ITEM_LIST SET (AUTO_REFRESH,BACK_GROUND_ID,EDIT_EXPRESS,END_FIELD,EXECUTE_TIME,FOOTER,HEADER,HINT_TYPE,JUMP_EXPRESS,JUMP_FIELD,MAX_ROW_COUNT,MONITOR_ID,MULTI_PAGE_FLAG,NOADD_FIELDS,NOEDIT_FIELDS,NOMODIFY_FIELDS,NOSHOW_APP_FIELDS,NOSHOW_FIELDS,OPEN_MODE,OPERATION_TYPE,OUTPUT_PARAMETER,QUERY_COUNT,QUERY_FIELDS,QUERY_TYPE,RFID_FLAG,SCANNABLE_FIELD,SCANNABLE_LOCATION_LINE,SCANNABLE_TIME,SCANNABLE_TYPE,SUBNOSHOW_FIELDS,SUB_EDIT_STATE,SUB_TABLE_JUDGE_FIELD,UI_TMPL,DELETE_SQL,DETAIL_SQL,INSERT_SQL,LOCK_SQL,NEWID_SQL,OPRETION_HINT,SELECT_SQL,SUBSELECT_SQL,UPDATE_SQL) = (SELECT 1,q''[]'',q''[]'',q''[]'',,q''[]'',q''[]'',,q''[]'',q''[]'',,q''[]'',1,q''[]'',q''[]'',q''[]'',q''[]'',q''[order_id,company_id,approve_status]'',,q''[]'',q''[]'',,q''[order_code]'',12,,q''[]'',q''[]'',,,q''[]'',,q''[]'',q''[]'',:CV1,:CV2,:CV3,:CV4,:CV5,:CV6,:CV7,:CV8,:CV9 FROM DUAL) WHERE ITEM_ID = ''a_product_130_2''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3,CV4,CV5,CV6,CV7,CV8,CV9;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_ITEM_LIST (AUTO_REFRESH,BACK_GROUND_ID,EDIT_EXPRESS,END_FIELD,EXECUTE_TIME,FOOTER,HEADER,HINT_TYPE,ITEM_ID,JUMP_EXPRESS,JUMP_FIELD,MAX_ROW_COUNT,MONITOR_ID,MULTI_PAGE_FLAG,NOADD_FIELDS,NOEDIT_FIELDS,NOMODIFY_FIELDS,NOSHOW_APP_FIELDS,NOSHOW_FIELDS,OPEN_MODE,OPERATION_TYPE,OUTPUT_PARAMETER,QUERY_COUNT,QUERY_FIELDS,QUERY_TYPE,RFID_FLAG,SCANNABLE_FIELD,SCANNABLE_LOCATION_LINE,SCANNABLE_TIME,SCANNABLE_TYPE,SUBNOSHOW_FIELDS,SUB_EDIT_STATE,SUB_TABLE_JUDGE_FIELD,UI_TMPL,DELETE_SQL,DETAIL_SQL,INSERT_SQL,LOCK_SQL,NEWID_SQL,OPRETION_HINT,SELECT_SQL,SUBSELECT_SQL,UPDATE_SQL) SELECT 1,q''[]'',q''[]'',q''[]'',,q''[]'',q''[]'',,''a_product_130_2'',q''[]'',q''[]'',,q''[]'',1,q''[]'',q''[]'',q''[]'',q''[]'',q''[order_id,company_id,approve_status]'',,q''[]'',q''[]'',,q''[order_code]'',12,,q''[]'',q''[]'',,,q''[]'',,q''[]'',q''[]'',:CV1,:CV2,:CV3,:CV4,:CV5,:CV6,:CV7,:CV8,:CV9 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3,CV4,CV5,CV6,CV7,CV8,CV9;
     END IF;
  END;
END;
/

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
  CV7 CLOB:=q'[WITH group_dict AS
 (SELECT t.group_dict_type, t.group_dict_value, t.group_dict_name
    FROM scmdata.sys_group_dict t)
SELECT td.deduction_id,
       --td.orgin,
       a.group_dict_name orgin,
       pr.product_gress_code,
       gd.group_dict_name anomaly_class,
       abn.detailed_reasons,
       abn.delay_date,
       nvl(abn.delay_amount, 0) delay_amount,
       (SELECT a.group_dict_name
          FROM group_dict a
         WHERE a.group_dict_type = 'DEDUCTION_METHOD'
           AND a.group_dict_value = abn.deduction_method) deduction_method_desc,
       td.discount_unit_price deduction_unit_price,
       decode(td.orgin,
              'SC',
              nvl((SELECT dc.deduction_ratio
                    FROM scmdata.t_commodity_info tc
                   INNER JOIN scmdata.t_deduction_range_config dr
                      ON tc.company_id = dr.company_id
                     AND tc.category = dr.industry_classification
                     AND tc.product_cate = dr.production_category
                     AND instr(';' || dr.product_subclass || ';',
                               ';' || tc.samll_category || ';') > 0
                     AND dr.pause = 0
                   INNER JOIN scmdata.t_deduction_dtl_config dc
                      ON dr.company_id = dc.company_id
                     AND dr.deduction_config_id = dc.deduction_config_id
                     AND dc.pause = 0
                   INNER JOIN scmdata.t_deduction_config td
                      ON td.company_id = dc.company_id
                     AND td.deduction_config_id = dc.deduction_config_id
                     AND td.pause = 0
                   WHERE tc.company_id = pr.company_id
                     AND tc.goo_id = pr.goo_id
                     AND (abn.delay_date >= dc.section_start AND
                         abn.delay_date < dc.section_end)),
                  0),
              0) deduction_ratio_pr,
       td.discount_price,
       td.adjust_price,
       td.adjust_reason,
       td.actual_discount_price,
       su.company_user_name adjust_person,
       td.update_time adjust_time,
       :approve_status approve_status
  FROM scmdata.t_deduction td
 INNER JOIN scmdata.t_production_progress pr
    ON td.company_id = pr.company_id
   AND td.order_id = pr.order_id
 INNER JOIN scmdata.t_abnormal abn
    ON pr.company_id = abn.company_id
   AND pr.order_id = abn.order_id
   AND pr.goo_id = abn.goo_id
   AND td.abnormal_id = abn.abnormal_id
 INNER JOIN group_dict gd
    ON gd.group_dict_type = 'ANOMALY_CLASSIFICATION_DICT'
   AND gd.group_dict_value = abn.anomaly_class
 INNER JOIN group_dict a
    ON a.group_dict_type = 'ORIGIN_TYPE'
   AND a.group_dict_value = td.orgin
  LEFT JOIN scmdata.sys_company_user su
    ON su.company_id = td.company_id
   AND su.user_id = td.update_id
 WHERE td.company_id = %default_company_id%
   AND td.order_id = :order_code

/*WITH group_dict AS
 (SELECT t.group_dict_type, t.group_dict_value, t.group_dict_name
    FROM scmdata.sys_group_dict t)
SELECT td.deduction_id,
       --td.orgin,
       a.group_dict_name        orgin,
       pr.product_gress_code,
       gd.group_dict_name       anomaly_class,
       abn.detailed_reasons,
       abn.delay_date,
       abn.delay_amount,
       abn.deduction_unit_price,
       td.discount_price,
       td.adjust_price,
       td.adjust_reason,
       td.actual_discount_price,
       su.company_user_name     adjust_person,
       td.update_time           adjust_time,
       :approve_status          approve_status
  FROM scmdata.t_deduction td
 INNER JOIN scmdata.t_production_progress pr
    ON td.company_id = pr.company_id
   AND td.order_id = pr.order_id
 INNER JOIN scmdata.t_abnormal abn
    ON pr.company_id = abn.company_id
   AND pr.order_id = abn.order_id
   AND pr.goo_id = abn.goo_id
   AND td.abnormal_id = abn.abnormal_id
 INNER JOIN group_dict gd
    ON gd.group_dict_type = 'ANOMALY_CLASSIFICATION_DICT'
   AND gd.group_dict_value = abn.anomaly_class
 INNER JOIN group_dict a
    ON a.group_dict_type = 'ORIGIN_TYPE'
   AND a.group_dict_value = td.orgin
 LEFT JOIN scmdata.sys_company_user su
    ON su.company_id = td.company_id
   AND su.user_id = td.update_id
 WHERE td.company_id = %default_company_id%
   AND td.order_id = :order_code*/]';
  CV8 CLOB:=q'[]';
  CV9 CLOB:=q'[UPDATE scmdata.t_deduction td
       SET td.adjust_price          = round(:adjust_price,2),
           td.adjust_reason         = :adjust_reason,
           td.update_id             = :user_id,
           td.update_time           = sysdate,
           td.actual_discount_price = decode(sign(:old_discount_price + :adjust_price),-1,0,round((:old_discount_price + :adjust_price),2))
     WHERE td.deduction_id = :deduction_id]';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_ITEM_LIST WHERE ITEM_ID = ''a_product_130_3''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_ITEM_LIST SET (AUTO_REFRESH,BACK_GROUND_ID,EDIT_EXPRESS,END_FIELD,EXECUTE_TIME,FOOTER,HEADER,HINT_TYPE,JUMP_EXPRESS,JUMP_FIELD,MAX_ROW_COUNT,MONITOR_ID,MULTI_PAGE_FLAG,NOADD_FIELDS,NOEDIT_FIELDS,NOMODIFY_FIELDS,NOSHOW_APP_FIELDS,NOSHOW_FIELDS,OPEN_MODE,OPERATION_TYPE,OUTPUT_PARAMETER,QUERY_COUNT,QUERY_FIELDS,QUERY_TYPE,RFID_FLAG,SCANNABLE_FIELD,SCANNABLE_LOCATION_LINE,SCANNABLE_TIME,SCANNABLE_TYPE,SUBNOSHOW_FIELDS,SUB_EDIT_STATE,SUB_TABLE_JUDGE_FIELD,UI_TMPL,DELETE_SQL,DETAIL_SQL,INSERT_SQL,LOCK_SQL,NEWID_SQL,OPRETION_HINT,SELECT_SQL,SUBSELECT_SQL,UPDATE_SQL) = (SELECT 4,q''[]'',q''[APPROVE_STATUS=''00'']'',q''[]'',,q''[]'',q''[]'',,q''[]'',q''[]'',,q''[]'',1,q''[]'',q''[]'',q''[]'',q''[]'',q''[deduction_id,approve_status]'',,q''[]'',q''[]'',,q''[]'',0,,q''[]'',q''[]'',,,q''[]'',,q''[]'',q''[]'',:CV1,:CV2,:CV3,:CV4,:CV5,:CV6,:CV7,:CV8,:CV9 FROM DUAL) WHERE ITEM_ID = ''a_product_130_3''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3,CV4,CV5,CV6,CV7,CV8,CV9;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_ITEM_LIST (AUTO_REFRESH,BACK_GROUND_ID,EDIT_EXPRESS,END_FIELD,EXECUTE_TIME,FOOTER,HEADER,HINT_TYPE,ITEM_ID,JUMP_EXPRESS,JUMP_FIELD,MAX_ROW_COUNT,MONITOR_ID,MULTI_PAGE_FLAG,NOADD_FIELDS,NOEDIT_FIELDS,NOMODIFY_FIELDS,NOSHOW_APP_FIELDS,NOSHOW_FIELDS,OPEN_MODE,OPERATION_TYPE,OUTPUT_PARAMETER,QUERY_COUNT,QUERY_FIELDS,QUERY_TYPE,RFID_FLAG,SCANNABLE_FIELD,SCANNABLE_LOCATION_LINE,SCANNABLE_TIME,SCANNABLE_TYPE,SUBNOSHOW_FIELDS,SUB_EDIT_STATE,SUB_TABLE_JUDGE_FIELD,UI_TMPL,DELETE_SQL,DETAIL_SQL,INSERT_SQL,LOCK_SQL,NEWID_SQL,OPRETION_HINT,SELECT_SQL,SUBSELECT_SQL,UPDATE_SQL) SELECT 4,q''[]'',q''[APPROVE_STATUS=''00'']'',q''[]'',,q''[]'',q''[]'',,''a_product_130_3'',q''[]'',q''[]'',,q''[]'',1,q''[]'',q''[]'',q''[]'',q''[]'',q''[deduction_id,approve_status]'',,q''[]'',q''[]'',,q''[]'',0,,q''[]'',q''[]'',,,q''[]'',,q''[]'',q''[]'',:CV1,:CV2,:CV3,:CV4,:CV5,:CV6,:CV7,:CV8,:CV9 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3,CV4,CV5,CV6,CV7,CV8,CV9;
     END IF;
  END;
END;
/

