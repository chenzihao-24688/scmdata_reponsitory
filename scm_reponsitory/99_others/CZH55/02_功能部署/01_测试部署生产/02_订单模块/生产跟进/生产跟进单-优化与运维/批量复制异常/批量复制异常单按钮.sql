BEGIN
insert into bw3.sys_element (ELEMENT_ID, ELEMENT_TYPE, DATA_SOURCE, PAUSE, MESSAGE, IS_HIDE, MEMO, IS_ASYNC, IS_PER_EXE, ENABLE_STAND_PERMISSION)
values ('action_a_product_118_5', 'action', 'oracle_scmdata', 0, null, 0, null, null, null, null);

insert into bw3.sys_action (ELEMENT_ID, CAPTION, ICON_NAME, ACTION_TYPE, ACTION_SQL, SELECT_FIELDS, REFRESH_FLAG, MULTI_PAGE_FLAG, PRE_FLAG, FILTER_EXPRESS, UPDATE_FIELDS, PORT_ID, PORT_SQL, LOCK_SQL, SELECTION_FLAG, CALL_ID, OPERATE_MODE, PORT_TYPE, QUERY_FIELDS, SELECTION_METHOD)
values ('action_a_product_118_5', '批量复制异常单', 'icon-morencaidan', 4, 'DECLARE
  v_abn_code_cp VARCHAR2(32) := @abnormal_code_cp@;
  v_flag        NUMBER;
BEGIN
    SELECT COUNT(1)
      INTO v_flag
      FROM scmdata.t_abnormal t
     WHERE t.company_id = %default_company_id%
       AND t.create_id = :user_id
       AND t.abnormal_code = v_abn_code_cp;
    IF v_flag = 0 THEN
      raise_application_error(-20002,
                              ''提示：输入异常处理编码不存在/错误，请检查！！''); 
    ELSE
  SELECT COUNT(1)
    INTO v_flag
    FROM scmdata.t_abnormal a
   WHERE a.company_id = %default_company_id%
     AND a.create_id = :user_id
     AND a.abnormal_code IN (@selection)
     AND NOT EXISTS (SELECT 1
            FROM scmdata.t_abnormal b
           WHERE b.company_id = a.company_id
             AND b.create_id = a.create_id
             AND b.abnormal_code = v_abn_code_cp
             AND b.goo_id = a.goo_id
             AND b.anomaly_class = a.anomaly_class);
  IF v_flag > 0 THEN
    raise_application_error(-20002,
                            ''提示：所勾选异常单与被复制异常单的[货号+异常分类]相同时才可复制，请检查！！'');
  ELSE
    FOR abn_rec IN (SELECT t.*
                      FROM scmdata.t_abnormal t
                     WHERE t.company_id = %default_company_id%
                       AND t.create_id = :user_id
                       AND t.abnormal_code IN (@selection)) LOOP
    
      --批量复制异常单
      --1)v_abn_rec 勾选异常单
      --2)p_abnormal_code_cp 被复制异常单编码
      pkg_production_progress.batch_copy_abnormal(p_company_id       => %default_company_id%,
                                                  p_user_id          => :user_id,
                                                  v_abn_rec          => abn_rec, --勾选异常单
                                                  p_abnormal_code_cp => v_abn_code_cp);
    END LOOP;
  END IF;
 END IF;
END;', 'abnormal_code_pr', 1, 1, 0, null, null, null, null, null, 0, null, null, 1, null, 2);

insert into bw3.sys_item_element_rela (ITEM_ID, ELEMENT_ID, SEQ_NO, PAUSE, LEVEL_NO)
values ('a_product_118', 'action_a_product_118_5', 3, 0, null);

END;
