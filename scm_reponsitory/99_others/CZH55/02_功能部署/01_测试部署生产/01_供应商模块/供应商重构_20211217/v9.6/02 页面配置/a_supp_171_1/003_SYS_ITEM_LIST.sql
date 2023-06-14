BEGIN
  DECLARE
    JUDGE_N NUMBER(4);
    EXE_SQL CLOB;
    VALS    CLOB;
  CV1 CLOB:=q'[DECLARE
BEGIN
pkg_supplier_info.delete_supplier_shared(p_supplier_shared_id => :supplier_shared_id);
--3.新增日志操作
scmdata.pkg_supplier_info.insert_oper_log(:supplier_info_id,'修改档案-删除指定供应商','',%user_id%,%default_company_id%,SYSDATE);
END;]';
  CV2 CLOB:=q'[]';
  CV3 CLOB:=q'[DECLARE
 v_scope_rec scmdata.t_coop_scope%ROWTYPE;
BEGIN
  SELECT *
    INTO v_scope_rec
    FROM scmdata.t_coop_scope t
   WHERE t.coop_scope_id = :coop_scope_id;

  pkg_supplier_info.insert_supplier_shared(scope_rec => v_scope_rec,p_supplier_code => :supplier_code);

  --3.新增日志操作
  scmdata.pkg_supplier_info.insert_oper_log(v_scope_rec.supplier_info_id,
                                            '修改档案-新增指定供应商',
                                            '',
                                            %user_id%,
                                            %default_company_id%,
                                            SYSDATE);
END;]';
  CV4 CLOB:=q'[]';
  CV5 CLOB:=q'[select %ass_coop_scope_id% coop_scope_id from dual]';
  CV6 CLOB:=q'[]';
  CV7 CLOB:=q'[{
DECLARE
  v_flag VARCHAR2(100);
  v_sql  VARCHAR2(1000);
BEGIN
  SELECT max(t.sharing_type)
    INTO v_flag
    FROM scmdata.t_coop_scope t
   WHERE t.coop_scope_id = :coop_scope_id;
  IF v_flag = '00' OR v_flag = '01' THEN
    raise_application_error(-20002, '是否作为外协厂设置为‘否或是’，则无需操作‘指定供应商’按钮！！');
    RETURN;
  ELSE
  v_sql := 'SELECT tf.supplier_code,
       tf.inside_supplier_code,
       tf.supplier_company_name,
       tf.social_credit_code,
       ts.supplier_shared_id,
       tf.supplier_info_id,
       tf.company_id
  FROM scmdata.t_supplier_info tf
 INNER JOIN scmdata.t_supplier_shared ts
    ON tf.supplier_code = ts.shared_supplier_code
    AND tf.company_id = %default_company_id%
 INNER JOIN scmdata.t_coop_scope t
    ON ts.company_id = t.company_id
   AND ts.supplier_info_id = t.supplier_info_id
   AND ts.coop_scope_id = t.coop_scope_id
   AND t.coop_scope_id = :coop_scope_id';
  END IF;
  @strresult := v_sql;
END;
}]';
  CV8 CLOB:=q'[]';
  CV9 CLOB:=q'[]';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_ITEM_LIST WHERE ITEM_ID = ''a_supp_151_4''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_ITEM_LIST SET (AUTO_REFRESH,BACK_GROUND_ID,EDIT_EXPRESS,END_FIELD,EXECUTE_TIME,FOOTER,HEADER,HINT_TYPE,JUMP_EXPRESS,JUMP_FIELD,MAX_ROW_COUNT,MONITOR_ID,MULTI_PAGE_FLAG,NOADD_FIELDS,NOEDIT_FIELDS,NOMODIFY_FIELDS,NOSHOW_APP_FIELDS,NOSHOW_FIELDS,OPEN_MODE,OPERATE_TYPE,OPERATION_TYPE,OUTPUT_PARAMETER,PAGE_SIZES,QUERY_COUNT,QUERY_FIELDS,QUERY_TYPE,RFID_FLAG,SCANNABLE_FIELD,SCANNABLE_LOCATION_LINE,SCANNABLE_TIME,SCANNABLE_TYPE,SUBNOSHOW_FIELDS,SUB_EDIT_STATE,SUB_TABLE_JUDGE_FIELD,UI_TMPL,DELETE_SQL,DETAIL_SQL,INSERT_SQL,LOCK_SQL,NEWID_SQL,OPRETION_HINT,SELECT_SQL,SUBSELECT_SQL,UPDATE_SQL) = (SELECT 1,q''[]'',q''[]'',q''[]'',,q''[]'',q''[]'',,q''[]'',q''[]'',,q''[]'',3,q''[]'',q''[]'',q''[]'',q''[]'',q''[supplier_shared_id,supplier_info_id,company_id]'',,0,q''[]'',q''[]'',q''[]'',,q''[]'',0,,q''[]'',q''[]'',,,q''[]'',,q''[]'',q''[]'',:CV1,:CV2,:CV3,:CV4,:CV5,:CV6,:CV7,:CV8,:CV9 FROM DUAL) WHERE ITEM_ID = ''a_supp_151_4''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3,CV4,CV5,CV6,CV7,CV8,CV9;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_ITEM_LIST (AUTO_REFRESH,BACK_GROUND_ID,EDIT_EXPRESS,END_FIELD,EXECUTE_TIME,FOOTER,HEADER,HINT_TYPE,ITEM_ID,JUMP_EXPRESS,JUMP_FIELD,MAX_ROW_COUNT,MONITOR_ID,MULTI_PAGE_FLAG,NOADD_FIELDS,NOEDIT_FIELDS,NOMODIFY_FIELDS,NOSHOW_APP_FIELDS,NOSHOW_FIELDS,OPEN_MODE,OPERATE_TYPE,OPERATION_TYPE,OUTPUT_PARAMETER,PAGE_SIZES,QUERY_COUNT,QUERY_FIELDS,QUERY_TYPE,RFID_FLAG,SCANNABLE_FIELD,SCANNABLE_LOCATION_LINE,SCANNABLE_TIME,SCANNABLE_TYPE,SUBNOSHOW_FIELDS,SUB_EDIT_STATE,SUB_TABLE_JUDGE_FIELD,UI_TMPL,DELETE_SQL,DETAIL_SQL,INSERT_SQL,LOCK_SQL,NEWID_SQL,OPRETION_HINT,SELECT_SQL,SUBSELECT_SQL,UPDATE_SQL) SELECT 1,q''[]'',q''[]'',q''[]'',,q''[]'',q''[]'',,''a_supp_151_4'',q''[]'',q''[]'',,q''[]'',3,q''[]'',q''[]'',q''[]'',q''[]'',q''[supplier_shared_id,supplier_info_id,company_id]'',,0,q''[]'',q''[]'',q''[]'',,q''[]'',0,,q''[]'',q''[]'',,,q''[]'',,q''[]'',q''[]'',:CV1,:CV2,:CV3,:CV4,:CV5,:CV6,:CV7,:CV8,:CV9 FROM DUAL';
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
  CV1 CLOB:=q'[--czh 重构逻辑
{DECLARE
  v_sql CLOB;
BEGIN
  v_sql      := pkg_supplier_info.f_delete_sup_coop_list(p_item_id => 'a_supp_171_1');
  @strresult := v_sql;
END;}
--原逻辑
/*DECLARE
  p_cp_data scmdata.t_coop_scope%ROWTYPE;
BEGIN

  p_cp_data.coop_scope_id       := :coop_scope_id;
  p_cp_data.supplier_info_id    := :supplier_info_id;
  p_cp_data.company_id          := %default_company_id%;

  scmdata.pkg_supplier_info.delete_coop_scope(p_cp_data => p_cp_data);
  --更新所在分组，区域组长
  pkg_supplier_info.update_group_name(p_company_id  => %default_company_id%,p_supplier_info_id => :supplier_info_id);

END;*/

/*DECLARE
BEGIN
DELETE FROM scmdata.t_supplier_shared t WHERE t.coop_scope_id = :coop_scope_id;

DELETE FROM t_coop_scope t WHERE t.coop_scope_id = :coop_scope_id;
END;*/]';
  CV2 CLOB:=q'[]';
  CV3 CLOB:=q'[--czh 重构逻辑
{DECLARE
  v_sql CLOB;
BEGIN
  v_sql      := pkg_supplier_info.f_insert_sup_coop_list(p_item_id => 'a_supp_171_1');
  @strresult := v_sql;
END;}
--原逻辑
/*DECLARE
  p_cp_data scmdata.t_coop_scope%ROWTYPE;
BEGIN

  p_cp_data.coop_scope_id       := scmdata.f_get_uuid();
  p_cp_data.supplier_info_id    := :supplier_info_id;
  p_cp_data.company_id          := %default_company_id%;
  p_cp_data.coop_classification := :coop_classification;
  p_cp_data.coop_product_cate   := :coop_product_cate;
  p_cp_data.coop_subcategory    := :coop_subcategory;
  p_cp_data.create_id           := %user_id%;
  p_cp_data.create_time         := SYSDATE;
  p_cp_data.update_id           := %user_id%;
  p_cp_data.update_time         := SYSDATE;
  p_cp_data.remarks             := '';
  p_cp_data.pause               := 0;
  p_cp_data.sharing_type        := :sharing_type;
  p_cp_data.publish_id          := '';
  p_cp_data.publish_date        := '';

  IF p_cp_data.coop_product_cate IS NULL THEN RAISE_APPLICATION_ERROR(-20002, '生产类别不能为空，请填写');
  ELSIF p_cp_data.coop_subcategory IS NULL THEN RAISE_APPLICATION_ERROR(-20002, '合作产品子类不能为空，请填写');
  ELSE
  scmdata.pkg_supplier_info.insert_coop_scope(p_cp_data => p_cp_data);
  END IF;
  --更新所在分组，区域组长
  pkg_supplier_info.update_group_name(p_company_id  => %default_company_id%,p_supplier_info_id => :supplier_info_id);

END;
*/
/*INSERT INTO t_coop_scope
  (coop_scope_id,
   supplier_info_id,
   company_id,
   --coop_mode,
   coop_classification,
   coop_product_cate,
   coop_subcategory,
   create_id,
   create_time,
   update_id,
   update_time,
   sharing_type)
VALUES
  (scmdata.f_get_uuid(),
   :supplier_info_id,
   %default_company_id%,
   --:coop_mode,
   :coop_classification,
   :coop_product_cate,
   :coop_subcategory,
   %user_id%,
   sysdate,
   %user_id%,
   sysdate,
   :sharing_type)*/]';
  CV4 CLOB:=q'[]';
  CV5 CLOB:=q'[]';
  CV6 CLOB:=q'[]';
  CV7 CLOB:=q'[--czh 重构逻辑
{DECLARE
  v_sql CLOB;
BEGIN
  v_sql      := pkg_supplier_info.f_query_sup_coop_list(p_item_id => 'a_supp_171_1');
  @strresult := v_sql;
END;}
--原逻辑
/*SELECT sp.coop_state,
       tc.coop_scope_id,
       tc.coop_classification,
       a.group_dict_name      coop_classification_desc,
       tc.coop_product_cate,
       b.group_dict_name      coop_product_cate_desc,
       tc.coop_subcategory,
       --c.company_dict_name coop_subcategory_desc,
       (SELECT listagg(c.company_dict_name, ';')
          FROM scmdata.sys_company_dict c
         WHERE c.company_id  = %default_company_id%
         AND c.company_dict_type = b.group_dict_value
           AND instr(';' || tc.coop_subcategory || ';',
                     ';' || c.company_dict_value || ';') > 0) coop_subcategory_desc,
       --tc.coop_mode,
       tc.sharing_type,
       (SELECT listagg(fc.supplier_company_name, ';')
          FROM scmdata.t_supplier_shared ts, scmdata.t_supplier_info fc
         WHERE ts.supplier_info_id = tc.supplier_info_id
                   AND ts.coop_scope_id = tc.coop_scope_id
                   AND fc.supplier_code = ts.shared_supplier_code
                   and fc.company_id = tc.company_id) company_list
  FROM scmdata.t_coop_scope tc
 INNER JOIN scmdata.sys_group_dict a
    ON tc.coop_classification = a.group_dict_value
   AND a.group_dict_type = 'PRODUCT_TYPE'
 INNER JOIN scmdata.sys_group_dict b
    ON b.group_dict_type = a.group_dict_value
   AND tc.coop_product_cate = b.group_dict_value
 LEFT JOIN scmdata.t_supplier_info sp
    ON tc.supplier_info_id = sp.supplier_info_id
WHERE tc.supplier_info_id = :supplier_info_id
   AND tc.company_id = %default_company_id%*/

/*SELECT sp.coop_state,
       tc.coop_scope_id,
       tc.coop_classification,
       a.group_dict_name      coop_classification_desc,
       tc.coop_product_cate,
       b.group_dict_name      PRODUCT_CATE_GD,
       tc.coop_subcategory,
       --c.company_dict_name coop_subcategory_desc,
       (SELECT listagg(c.company_dict_name, ';')
          FROM scmdata.sys_company_dict c
         WHERE c.company_id  = %default_company_id%
         AND c.company_dict_type = b.group_dict_value
           AND instr(';' || tc.coop_subcategory || ';',
                     ';' || c.company_dict_value || ';') > 0) SMALL_CATEGORY_GD,
       --tc.coop_mode,
       tc.sharing_type,
       (SELECT listagg(fc.supplier_company_name, ';')
          FROM scmdata.t_supplier_shared ts, scmdata.t_supplier_info fc
         WHERE ts.supplier_info_id = tc.supplier_info_id
                   AND ts.coop_scope_id = tc.coop_scope_id
                   AND fc.supplier_code = ts.shared_supplier_code
                   and fc.company_id = tc.company_id) company_list
  FROM scmdata.t_coop_scope tc
 INNER JOIN scmdata.sys_group_dict a
    ON tc.coop_classification = a.group_dict_value
   AND a.group_dict_type = 'PRODUCT_TYPE'
 INNER JOIN scmdata.sys_group_dict b
    ON b.group_dict_type = a.group_dict_value
   AND tc.coop_product_cate = b.group_dict_value
 LEFT JOIN scmdata.t_supplier_info sp
    ON tc.supplier_info_id = sp.supplier_info_id
WHERE tc.supplier_info_id = :supplier_info_id
   AND tc.company_id = %default_company_id%*/]';
  CV8 CLOB:=q'[]';
  CV9 CLOB:=q'[--czh 重构逻辑
{DECLARE
  v_sql CLOB;
BEGIN
  v_sql      := pkg_supplier_info.f_update_sup_coop_list(p_item_id => 'a_supp_171_1');
  @strresult := v_sql;
END;}
--原逻辑
/*DECLARE
  p_cp_data scmdata.t_coop_scope%ROWTYPE;
BEGIN

  p_cp_data.coop_scope_id       := :coop_scope_id;
  p_cp_data.supplier_info_id    := :supplier_info_id;
  p_cp_data.company_id          := %default_company_id%;
  p_cp_data.coop_classification := :coop_classification;
  p_cp_data.coop_product_cate   := :coop_product_cate;
  p_cp_data.coop_subcategory    := :coop_subcategory;
  p_cp_data.update_id           := %user_id%;
  p_cp_data.update_time         := SYSDATE;
  p_cp_data.sharing_type        := :sharing_type;

  IF p_cp_data.coop_product_cate IS NULL THEN RAISE_APPLICATION_ERROR(-20002, '生产类别不能为空，请填写');
  ELSIF p_cp_data.coop_subcategory IS NULL THEN RAISE_APPLICATION_ERROR(-20002, '合作产品子类不能为空，请填写');
  ELSE
  scmdata.pkg_supplier_info.update_coop_scope(p_cp_data => p_cp_data);
  END IF;
  --更新所在分组，区域组长
  pkg_supplier_info.update_group_name(p_company_id  => %default_company_id%,p_supplier_info_id => :supplier_info_id);

END;*/

/*UPDATE t_coop_scope t
   SET --t.coop_mode           = :coop_mode,
       t.coop_classification = :coop_classification,
       t.coop_product_cate   = :coop_product_cate,
       t.coop_subcategory    = :coop_subcategory,
       t.update_id           = %user_id%,
       t.update_time         = SYSDATE,
       t.sharing_type        = :sharing_type
 WHERE t.company_id = %default_company_id%
   AND t.supplier_info_id = :supplier_info_id
   AND t.coop_scope_id = :coop_scope_id*/]';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_ITEM_LIST WHERE ITEM_ID = ''a_supp_171_1''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_ITEM_LIST SET (AUTO_REFRESH,BACK_GROUND_ID,EDIT_EXPRESS,END_FIELD,EXECUTE_TIME,FOOTER,HEADER,HINT_TYPE,JUMP_EXPRESS,JUMP_FIELD,MAX_ROW_COUNT,MONITOR_ID,MULTI_PAGE_FLAG,NOADD_FIELDS,NOEDIT_FIELDS,NOMODIFY_FIELDS,NOSHOW_APP_FIELDS,NOSHOW_FIELDS,OPEN_MODE,OPERATE_TYPE,OPERATION_TYPE,OUTPUT_PARAMETER,PAGE_SIZES,QUERY_COUNT,QUERY_FIELDS,QUERY_TYPE,RFID_FLAG,SCANNABLE_FIELD,SCANNABLE_LOCATION_LINE,SCANNABLE_TIME,SCANNABLE_TYPE,SUBNOSHOW_FIELDS,SUB_EDIT_STATE,SUB_TABLE_JUDGE_FIELD,UI_TMPL,DELETE_SQL,DETAIL_SQL,INSERT_SQL,LOCK_SQL,NEWID_SQL,OPRETION_HINT,SELECT_SQL,SUBSELECT_SQL,UPDATE_SQL) = (SELECT 1,q''[]'',q''[]'',q''[]'',,q''[]'',q''[]'',,q''[]'',q''[]'',,q''[]'',1,q''[]'',q''[]'',q''[]'',q''[]'',q''[coop_scope_id,sharing_type,coop_classification,coop_product_cate,coop_subcategory,coop_mode,coop_state]'',,0,q''[]'',q''[]'',q''[]'',,q''[]'',0,,q''[]'',q''[]'',,,q''[]'',,q''[]'',q''[]'',:CV1,:CV2,:CV3,:CV4,:CV5,:CV6,:CV7,:CV8,:CV9 FROM DUAL) WHERE ITEM_ID = ''a_supp_171_1''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3,CV4,CV5,CV6,CV7,CV8,CV9;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_ITEM_LIST (AUTO_REFRESH,BACK_GROUND_ID,EDIT_EXPRESS,END_FIELD,EXECUTE_TIME,FOOTER,HEADER,HINT_TYPE,ITEM_ID,JUMP_EXPRESS,JUMP_FIELD,MAX_ROW_COUNT,MONITOR_ID,MULTI_PAGE_FLAG,NOADD_FIELDS,NOEDIT_FIELDS,NOMODIFY_FIELDS,NOSHOW_APP_FIELDS,NOSHOW_FIELDS,OPEN_MODE,OPERATE_TYPE,OPERATION_TYPE,OUTPUT_PARAMETER,PAGE_SIZES,QUERY_COUNT,QUERY_FIELDS,QUERY_TYPE,RFID_FLAG,SCANNABLE_FIELD,SCANNABLE_LOCATION_LINE,SCANNABLE_TIME,SCANNABLE_TYPE,SUBNOSHOW_FIELDS,SUB_EDIT_STATE,SUB_TABLE_JUDGE_FIELD,UI_TMPL,DELETE_SQL,DETAIL_SQL,INSERT_SQL,LOCK_SQL,NEWID_SQL,OPRETION_HINT,SELECT_SQL,SUBSELECT_SQL,UPDATE_SQL) SELECT 1,q''[]'',q''[]'',q''[]'',,q''[]'',q''[]'',,''a_supp_171_1'',q''[]'',q''[]'',,q''[]'',1,q''[]'',q''[]'',q''[]'',q''[]'',q''[coop_scope_id,sharing_type,coop_classification,coop_product_cate,coop_subcategory,coop_mode,coop_state]'',,0,q''[]'',q''[]'',q''[]'',,q''[]'',0,,q''[]'',q''[]'',,,q''[]'',,q''[]'',q''[]'',:CV1,:CV2,:CV3,:CV4,:CV5,:CV6,:CV7,:CV8,:CV9 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3,CV4,CV5,CV6,CV7,CV8,CV9;
     END IF;
  END;
END;
/

