BEGIN
insert into bw3.sys_param_list (PARAM_NAME, DATA_SOURCE, CAPTION, DEFAULT_SQL, VALUE_SQL, REQUIRED_FLAG, HOTKEY, DISPLAY_WIDTH, READ_ONLY_FLAG, MIN_VALUE, MAX_VALUE, VALUE_STEP, MAX_LENGTH, EDIT_MASK, HINT_TEXT, PARAM_TYPE, DATA_TYPE, SEPARATOR, IS_MULTI)
values ('QC', 'oracle_scmdata', 'QC', null, 'SELECT a.user_id qc_id, a.company_user_name qc
  FROM scmdata.sys_company_user a
 INNER JOIN scmdata.sys_company_job b
    ON a.job_id = b.job_id
   AND a.company_id = b.company_id
 WHERE (b.job_name = ''QC主管'' OR b.job_name = ''QC'')
   AND a.pause = 0
   AND a.company_id = %default_company_id%', 0, null, null, 0, null, null, null, null, null, null, null, null, ',', 1);
END;
/
DECLARE
v_sql CLOB;
BEGIN
 v_sql := '
 --dyy153 220715 修改分岗位编辑字段  
 --czh 20220919 修改更新逻辑
{DECLARE
  V_UPD_SQL CLOB;
BEGIN
  --V_UPD_SQL := SCMDATA.PKG_PT_ORDERED.F_UPD_PTORDERED(V_USERID => %CURRENT_USERID%,V_COMPID => %DEFAULT_COMPANY_ID%);
  V_UPD_SQL := SCMDATA.PKG_PT_ORDERED.F_UPD_PTORDERED();
  @STRRESULT := V_UPD_SQL;
END;
}';
 UPDATE bw3.sys_item_list t SET t.update_sql = v_sql WHERE t.item_id = 'a_report_120';
END;
/
BEGIN
insert into bw3.sys_element (ELEMENT_ID, ELEMENT_TYPE, DATA_SOURCE, PAUSE, MESSAGE, IS_HIDE, MEMO, IS_ASYNC, IS_PER_EXE, ENABLE_STAND_PERMISSION)
values ('action_a_report_120_1', 'action', 'oracle_scmdata', 0, null, 0, null, null, null, null);

insert into bw3.sys_element (ELEMENT_ID, ELEMENT_TYPE, DATA_SOURCE, PAUSE, MESSAGE, IS_HIDE, MEMO, IS_ASYNC, IS_PER_EXE, ENABLE_STAND_PERMISSION)
values ('action_a_report_120_2', 'action', 'oracle_scmdata', 0, null, 0, null, null, null, null);

insert into bw3.sys_action (ELEMENT_ID, CAPTION, ICON_NAME, ACTION_TYPE, ACTION_SQL, SELECT_FIELDS, REFRESH_FLAG, MULTI_PAGE_FLAG, PRE_FLAG, FILTER_EXPRESS, UPDATE_FIELDS, PORT_ID, PORT_SQL, LOCK_SQL, SELECTION_FLAG, CALL_ID, OPERATE_MODE, PORT_TYPE, QUERY_FIELDS, SELECTION_METHOD)
values ('action_a_report_120_1', '指定跟单员', 'icon-morencaidan', 4, 'DECLARE
  v_df       VARCHAR2(256) := @deal_follower@;
  v_flw_mana VARCHAR2(256);
BEGIN
  --校验订单是否已封存/已结束
  FOR i IN (SELECT t.pt_ordered_id,
                   t.company_id,
                   t.goo_id,
                   t.delay_problem_class,
                   t.delay_cause_class,
                   t.delay_cause_detailed,
                   t.problem_desc,
                   t.responsible_dept_sec
              FROM scmdata.pt_ordered t
             WHERE order_id IN (%selection%)
               AND company_id = %default_company_id%) LOOP
    scmdata.pkg_pt_ordered.p_check_orders(p_pt_ordered_id => i.pt_ordered_id);
  END LOOP;
  --获取跟单主管
  IF v_df IS NOT NULL THEN
    v_flw_mana := scmdata.pkg_db_job.f_get_manager(p_company_id     => %default_company_id%,
                                                   p_user_id        => v_df,
                                                   p_company_job_id => ''1001005003005002'');
  END IF;
  --更新跟单、跟单主管
  UPDATE scmdata.pt_ordered t
     SET t.flw_order         = v_df,
         t.flw_order_manager = v_flw_mana,
         t.update_id         = %current_userid%,
         t.update_time       = SYSDATE
   WHERE order_id IN (%selection%)
     AND company_id = %default_company_id%;
END;
', 'ORDER_ID', 1, 1, 0, null, null, null, null, null, 0, null, null, 1, null, 2);

insert into bw3.sys_action (ELEMENT_ID, CAPTION, ICON_NAME, ACTION_TYPE, ACTION_SQL, SELECT_FIELDS, REFRESH_FLAG, MULTI_PAGE_FLAG, PRE_FLAG, FILTER_EXPRESS, UPDATE_FIELDS, PORT_ID, PORT_SQL, LOCK_SQL, SELECTION_FLAG, CALL_ID, OPERATE_MODE, PORT_TYPE, QUERY_FIELDS, SELECTION_METHOD)
values ('action_a_report_120_2', '指定QC', 'icon-morencaidan', 4, 'DECLARE
  v_qc      VARCHAR2(256) := @qc@;
  v_qc_mana VARCHAR2(256);
BEGIN
  --校验订单是否已封存/已结束
  FOR i IN (SELECT t.pt_ordered_id,
                   t.company_id,
                   t.goo_id,
                   t.delay_problem_class,
                   t.delay_cause_class,
                   t.delay_cause_detailed,
                   t.problem_desc,
                   t.responsible_dept_sec
              FROM scmdata.pt_ordered t
             WHERE order_id IN (%selection%)
               AND company_id = %default_company_id%) LOOP
    scmdata.pkg_pt_ordered.p_check_orders(p_pt_ordered_id => i.pt_ordered_id , p_type => 0);
  END LOOP;
  --获取QC主管
  IF v_qc IS NOT NULL THEN
    v_qc_mana := scmdata.pkg_db_job.f_get_manager_byconfig(p_company_id => %default_company_id%,
                                                           p_user_id    => v_qc);
  END IF;
  --更新QC、QC主管
  UPDATE scmdata.pt_ordered t
     SET t.qc          = v_qc,
         t.qc_manager  = v_qc_mana,
         t.updated_qc  = 1,
         t.update_id   = %current_userid%,
         t.update_time = SYSDATE
   WHERE order_id IN (%selection%)
     AND company_id = %default_company_id%;
END;', 'ORDER_ID', 1, 1, 0, null, null, null, null, null, 0, null, null, 1, null, 2);

insert into bw3.sys_item_element_rela (ITEM_ID, ELEMENT_ID, SEQ_NO, PAUSE, LEVEL_NO)
values ('a_report_120', 'action_a_report_120_1', 1, 0, null);

insert into bw3.sys_item_element_rela (ITEM_ID, ELEMENT_ID, SEQ_NO, PAUSE, LEVEL_NO)
values ('a_report_120', 'action_a_report_120_2', 2, 0, null);

END;
/
DECLARE
v_sql CLOB;
BEGIN
v_sql := '{
declare
  v_c number(2);
  v_cate varchar2(32);
  v_sql clob;
begin
  select count(distinct (select group_dict_name
                  from scmdata.sys_group_dict
                 where group_dict_value = x.category
                   and group_dict_type = ''PRODUCT_TYPE'')) category
    into v_c
    from scmdata.t_ordered t
   inner join scmdata.t_orders y
      on t.order_code = y.order_id
     and t.company_id = y.company_id
   inner join scmdata.t_commodity_info x
      on x.goo_id = y.goo_id
     and x.company_id = y.company_id
   where t.order_id in (@selection)
     and t.company_id = %default_company_id%;
  if v_c = 1 then
   select distinct x.category
    into v_cate
     from scmdata.t_ordered t
    inner join scmdata.t_orders y
       on t.order_code = y.order_id
      and t.company_id = y.company_id
    inner join scmdata.t_commodity_info x
       on x.goo_id = y.goo_id
      and x.company_id = y.company_id
    where t.order_id in (@selection)
      and t.company_id = %default_company_id%;
   v_sql := ''select distinct user_id DEAL_FOLLOWER,company_user_name DEAL_FOLLOWER_DESC from (
select a.user_id, a.company_user_name, d.dept_name,u.cooperation_classification
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
   and d.dept_name like ''''%跟单%''''
  left join scmdata.sys_company_user_cate_map u
    on u.company_id = d.company_id
   and u.user_id = a.user_id
   where a.pause = 0 )''|| '' where cooperation_classification  = '''''' ||V_cate||'''''''';
  elsif v_c > 1 then
   select listagg(distinct x.category,'';'')category
     into v_cate
     from scmdata.t_ordered t
    inner join scmdata.t_orders y
       on t.order_code = y.order_id
      and t.company_id = y.company_id
    inner join scmdata.t_commodity_info x
       on x.goo_id = y.goo_id
      and x.company_id = y.company_id
   where t.order_id in (@selection)
     and t.company_id = %default_company_id%;
v_sql := ''select distinct a.user_id DEAL_FOLLOWER, a.company_user_name DEAL_FOLLOWER_DESC
  from scmdata.sys_company_user a
 inner join scmdata.sys_user b
    on a.user_id = b.user_id
   and a.pause = 0
 inner join scmdata.sys_company_user_dept c
    on a.user_id = c.user_id
   and a.company_id = c.company_id
 inner join scmdata.sys_company_dept d
    on c.company_dept_id = d.company_dept_id
   and c.company_id = d.company_id
   and d.pause = 0
   and d.dept_name like ''''%跟单共享组%''''
  left join scmdata.sys_company_user_cate_map e1
    on d.company_id = e1.company_id
   and a.user_id = e1.user_id
 where not exists
 (select 1
          from (SELECT regexp_substr(''||''''''''|| v_cate ||''''''''||'',  ''''[^'''' || '''';'''' || '''']+'''', 1,  LEVEL, ''''i'''') AS str FROM dual
                CONNECT BY LEVEL <=
                           length(''||''''''''|| v_cate ||''''''''||'') -
                           length(regexp_replace(''||''''''''|| v_cate ||''''''''||'', '''';'''', '''''''')) + 1) base
         where base.str not in
               (select pm.cooperation_classification
                  from scmdata.sys_company_user_cate_map pm
                 where pm.user_id= c.user_id ))'';
   else
     v_sql := ''select null DEAL_FOLLOWER,null DEAL_FOLLOWER_DESC from dual'';
  end if;
  @strresult := v_sql;
end;
}';
UPDATE bw3.sys_param_list t SET t.value_sql = v_sql WHERE t.param_name = 'DEAL_FOLLOWER';
END;
/
