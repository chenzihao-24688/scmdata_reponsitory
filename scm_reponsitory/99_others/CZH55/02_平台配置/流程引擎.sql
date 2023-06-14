--------------------------------流程引擎--------------------------------
BEGIN
  DECLARE
    V_CNT NUMBER(1);
  BEGIN
    SELECT COUNT(*) INTO V_CNT FROM sys_item where item_id = 'flow_menu';
    IF V_CNT = 0 THEN
      insert into sys_item
        (ITEM_ID,
         ITEM_TYPE,
         CAPTION_SQL,
         DATA_SOURCE,
         BASE_TABLE,
         KEY_FIELD,
         NAME_FIELD,
         SETTING_ID,
         REPORT_TITLE,
         SUB_SCRIPTS,
         PAUSE,
         LINK_FIELD,
         HELP_ID,
         TAG_ID,
         CONFIG_PARAMS,
         TIME_OUT,
         OFFLINE_FLAG,
         PANEL_ID,
         INIT_SHOW)
      values
        ('flow_menu',
         'menu',
         '流程引擎',
         '',
         '',
         '',
         '',
         '',
         '',
         '',
         0,
         '',
         '',
         '',
         '',
         null,
         null,
         '',
         null);
    END IF;
  END;
END;

BEGIN
  DECLARE
    V_CNT NUMBER(1);
  BEGIN
    SELECT COUNT(*)
      INTO V_CNT
      FROM sys_tree_list
     where node_id = 'node_flow_menu';
    IF V_CNT = 0 THEN
      insert into sys_tree_list
        (NODE_ID,
         TREE_ID,
         ITEM_ID,
         PARENT_ID,
         VAR_ID,
         APP_ID,
         ICON_NAME,
         IS_END,
         STAND_PRIV_FLAG,
         SEQ_NO,
         PAUSE,
         TERMINAL_FLAG,
         CAPTION_EXPLAIN,
         COMPETENCE_FLAG,
         NODE_TYPE,
         IS_AUTHORIZE)
      values
        ('node_flow_menu',
         'flow_tree',
         'flow_menu',
         'menuroot',
         '',
         'app_sanfu_retail',
         'blue iconfont icon--wenjianjia',
         0,
         null,
         0,
         0,
         null,
         '流程引擎',
         null,
         1,
         1);
    END IF;
  END;
END;

--------------------------------流程类型管理--------------------------------
BEGIN
  DECLARE
    V_CNT NUMBER(1);
  BEGIN
    SELECT COUNT(*)
      INTO V_CNT
      FROM sys_item
     where item_id = 'flow_type_manage';
    IF V_CNT = 0 THEN
      insert into sys_item
        (ITEM_ID,
         ITEM_TYPE,
         CAPTION_SQL,
         DATA_SOURCE,
         BASE_TABLE,
         KEY_FIELD,
         NAME_FIELD,
         SETTING_ID,
         REPORT_TITLE,
         SUB_SCRIPTS,
         PAUSE,
         LINK_FIELD,
         HELP_ID,
         TAG_ID,
         CONFIG_PARAMS,
         TIME_OUT,
         OFFLINE_FLAG,
         PANEL_ID,
         INIT_SHOW)
      values
        ('flow_type_manage',
         'list',
         '流程类型管理',
         '',
         '',
         'process_type_id',
         '',
         '',
         '',
         '',
         0,
         '',
         '',
         '',
         '',
         null,
         null,
         '',
         null);
    END IF;
  END;
END;

BEGIN
  DECLARE
    V_CNT NUMBER;
  BEGIN
    SELECT COUNT(*)
      INTO V_CNT
      FROM sys_item_list
     where ITEM_ID = 'flow_type_manage';
    IF V_CNT = 0 THEN
      BEGIN
        DECLARE
          P_BLOB0 clob;
          P_BLOB1 clob;
          P_BLOB2 clob;
          P_BLOB3 clob;
        BEGIN
          P_BLOB0 := 'select t1.process_type_id,
       t1.process_type_code,
       t1.process_type_name,
       t1.create_time,
       t2.username create_user,
       t1.app_id
  from wf_process_type t1, nsfdata.users t2
 where t1.create_user = t2.userid
   and t1.app_id = :app_id
   and t1.pause = 0
 order by t1.create_time desc
';
          P_BLOB1 := 'insert into wf_process_type
  (process_type_id,
   process_type_name,
   process_type_code,
   create_time,
   create_user,
   app_id,
   pause)
values
  (process_type_id.nextval,
   :process_type_name,
   :process_type_code,
   sysdate,
   %currentuserid%,
   :app_id,
   0)
';
          P_BLOB2 := 'update wf_process_type
   set process_type_code = :process_type_code,
       process_type_name = :process_type_name
 where process_type_id = :process_type_id
';
          P_BLOB3 := 'delete from wf_process_type where process_type_id = :process_type_id
';
          INSERT INTO sys_item_list
            (ITEM_ID,
             QUERY_TYPE,
             QUERY_FIELDS,
             QUERY_COUNT,
             EDIT_EXPRESS,
             NEWID_SQL,
             SELECT_SQL,
             DETAIL_SQL,
             SUBSELECT_SQL,
             INSERT_SQL,
             UPDATE_SQL,
             DELETE_SQL,
             NOSHOW_FIELDS,
             NOADD_FIELDS,
             NOMODIFY_FIELDS,
             NOEDIT_FIELDS,
             SUBNOSHOW_FIELDS,
             UI_TMPL,
             MULTI_PAGE_FLAG,
             OUTPUT_PARAMETER,
             LOCK_SQL,
             MONITOR_ID,
             END_FIELD,
             EXECUTE_TIME,
             SHOW_CHECKBOX,
             SCANNABLE_FIELD,
             AUTO_REFRESH,
             SUB_TABLE_JUDGE_FIELD,
             BACK_GROUND_ID,
             OPERATION_TYPE,
             OPRETION_HINT,
             SUB_EDIT_STATE,
             HINT_TYPE,
             SCANNABLE_LOCATION_LINE,
             NOSHOW_APP_FIELDS,
             MAX_ROW_COUNT,
             SCANNABLE_TIME,
             RFID_FLAG,
             SCANNABLE_TYPE,
             HEADER,
             FOOTER,
             JUMP_FIELD,
             JUMP_EXPRESS)
          VALUES
            ('flow_type_manage',
             '3',
             null,
             null,
             null,
             null,
             P_BLOB0,
             null,
             null,
             P_BLOB1,
             P_BLOB2,
             P_BLOB3,
             'process_type_id,app_id',
             null,
             null,
             null,
             null,
             null,
             '1',
             null,
             null,
             null,
             null,
             null,
             '0',
             null,
             null,
             null,
             null,
             null,
             null,
             null,
             null,
             null,
             null,
             null,
             null,
             null,
             null,
             null,
             null,
             null,
             null);
        END;
      END;
    END IF;
  END;
END;

BEGIN
  DECLARE
    V_CNT NUMBER;
  BEGIN
    SELECT COUNT(*)
      INTO V_CNT
      FROM sys_tree_list
     where NODE_ID = 'node_flow_type_manage';
    IF V_CNT = 0 THEN
      BEGIN
        INSERT INTO sys_tree_list
          (NODE_ID,
           TREE_ID,
           ITEM_ID,
           PARENT_ID,
           VAR_ID,
           APP_ID,
           ICON_NAME,
           IS_END,
           STAND_PRIV_FLAG,
           SEQ_NO,
           PAUSE,
           TERMINAL_FLAG,
           CAPTION_EXPLAIN,
           COMPETENCE_FLAG,
           NODE_TYPE,
           IS_AUTHORIZE)
        VALUES
          ('node_flow_type_manage',
           'flow_tree',
           'flow_type_manage',
           'flow_menu',
           null,
           'app_sanfu_retail',
           'blue iconfont icon--wenjianjia',
           '0',
           null,
           '1',
           '0',
           null,
           '流程类型管理',
           null,
           '1',
           '1');
      END;
    END IF;
  END;
END;

--字段(流程类型编号:PROCESS_TYPE_CODE)
BEGIN
  DECLARE
    V_CNT NUMBER;
  BEGIN
    SELECT COUNT(*)
      INTO V_CNT
      FROM sys_field_list
     where FIELD_NAME = 'PROCESS_TYPE_CODE';
    IF V_CNT = 0 THEN
      BEGIN
        INSERT INTO sys_field_list
          (FIELD_NAME,
           CAPTION,
           REQUIERED_FLAG,
           INPUT_HINT,
           VALID_CHARS,
           INVALID_CHARS,
           CHECK_EXPRESS,
           CHECK_MESSAGE,
           READ_ONLY_FLAG,
           NO_EDIT,
           NO_COPY,
           NO_SUM,
           NO_SORT,
           ALIGNMENT,
           MAX_LENGTH,
           MIN_LENGTH,
           DISPLAY_WIDTH,
           DISPLAY_FORMAT,
           EDIT_FORMT,
           DATA_TYPE,
           MAX_VALUE,
           MIN_VALUE,
           DEFAULT_VALUE,
           IME_CARE,
           IME_OPEN,
           VALUE_LISTS,
           VALUE_LIST_TYPE,
           HYPER_RES,
           MULTI_VALUE_FLAG,
           TRUE_EXPR,
           FALSE_EXPR,
           NAME_RULE_FLAG,
           NAME_RULE_ID,
           DATA_TYPE_FLAG,
           ALLOW_SCAN,
           VALUE_ENCRYPT,
           VALUE_SENSITIVE,
           OPERATOR_FLAG)
        VALUES
          ('PROCESS_TYPE_CODE',
           '流程类型编号',
           '0',
           null,
           null,
           null,
           null,
           null,
           '0',
           '0',
           '0',
           '0',
           '0',
           '0',
           null,
           null,
           null,
           null,
           null,
           null,
           null,
           null,
           null,
           '0',
           '0',
           null,
           null,
           null,
           null,
           null,
           null,
           null,
           null,
           null,
           null,
           null,
           null,
           null);
      END;
    END IF;
  END;
END;

--checkValue
BEGIN
  DECLARE
    V_CNT NUMBER;
  BEGIN
    SELECT COUNT(*)
      INTO V_CNT
      FROM sys_cond_list
     where COND_ID = 'cond_flow_type_insert';
    IF V_CNT = 0 THEN
      BEGIN
        DECLARE
          P_BLOB0 clob;
          P_BLOB1 clob;
        BEGIN
          P_BLOB0 := 'select case
         when count(1) = 0 then
          1
         else
          0
       end flag
  from wf_process_type t
 where t.process_type_code = :process_type_code
   and t.app_id = :app_id';
          P_BLOB1 := '流程类型编号不能重复!          
';
          INSERT INTO sys_cond_list
            (COND_ID,
             COND_SQL,
             COND_TYPE,
             SHOW_TEXT,
             DATA_SOURCE,
             COND_FIELD_NAME)
          VALUES
            ('cond_flow_type_insert',
             P_BLOB0,
             '0',
             P_BLOB1,
             null,
             'process_type_code');
        END;
      END;
    END IF;
  END;
END;

BEGIN
  DECLARE
    V_CNT NUMBER;
  BEGIN
    SELECT COUNT(*)
      INTO V_CNT
      FROM sys_cond_list
     where COND_ID = 'cond_flow_type_update';
    IF V_CNT = 0 THEN
      BEGIN
        DECLARE
          P_BLOB0 clob;
          P_BLOB1 clob;
        BEGIN
          P_BLOB0 := 'select case
         when t.process_type_code is null or
              t.process_type_id = :process_type_id then
          1
         else
          0
       end flag
  from wf_process_type t
 where t.process_type_code = :process_type_code
   and t.app_id = :app_id
';
          P_BLOB1 := '流程类型编号不能重复!                    
';
          INSERT INTO sys_cond_list
            (COND_ID,
             COND_SQL,
             COND_TYPE,
             SHOW_TEXT,
             DATA_SOURCE,
             COND_FIELD_NAME)
          VALUES
            ('cond_flow_type_update',
             P_BLOB0,
             '0',
             P_BLOB1,
             null,
             'process_type_code');
        END;
      END;
    END IF;
  END;
END;

BEGIN
  DECLARE
    V_CNT NUMBER;
  BEGIN
    SELECT COUNT(*)
      INTO V_CNT
      FROM sys_cond_rela
     where COND_ID = 'cond_flow_type_update'
       and OBJ_TYPE = '13'
       and CTL_ID = 'flow_type_manage'
       and CTL_TYPE = '3'
       and ITEM_ID is null;
    IF V_CNT = 0 THEN
      BEGIN
        INSERT INTO sys_cond_rela
          (COND_ID, OBJ_TYPE, CTL_ID, CTL_TYPE, SEQ_NO, PAUSE, ITEM_ID)
        VALUES
          ('cond_flow_type_update',
           '13',
           'flow_type_manage',
           '3',
           '2',
           '0',
           null);
      END;
    END IF;
  END;
END;

BEGIN
  DECLARE
    V_CNT NUMBER;
  BEGIN
    SELECT COUNT(*)
      INTO V_CNT
      FROM sys_cond_rela
     where COND_ID = 'cond_flow_type_insert'
       and OBJ_TYPE = '11'
       and CTL_ID = 'flow_type_manage'
       and CTL_TYPE = '3'
       and ITEM_ID is null;
    IF V_CNT = 0 THEN
      BEGIN
        INSERT INTO sys_cond_rela
          (COND_ID, OBJ_TYPE, CTL_ID, CTL_TYPE, SEQ_NO, PAUSE, ITEM_ID)
        VALUES
          ('cond_flow_type_insert',
           '11',
           'flow_type_manage',
           '3',
           '1',
           '0',
           null);
      END;
    END IF;
  END;
END;

--子表(流程设计)
BEGIN
  DECLARE
    V_CNT NUMBER;
  BEGIN
    SELECT COUNT(*)
      INTO V_CNT
      FROM sys_item
     where ITEM_ID = 'flow_process';
    IF V_CNT = 0 THEN
      BEGIN
        INSERT INTO sys_item
          (ITEM_ID,
           ITEM_TYPE,
           CAPTION_SQL,
           DATA_SOURCE,
           BASE_TABLE,
           KEY_FIELD,
           NAME_FIELD,
           SETTING_ID,
           REPORT_TITLE,
           SUB_SCRIPTS,
           PAUSE,
           LINK_FIELD,
           HELP_ID,
           TAG_ID,
           CONFIG_PARAMS,
           TIME_OUT,
           OFFLINE_FLAG,
           PANEL_ID,
           INIT_SHOW)
        VALUES
          ('flow_process',
           'list',
           '流程设计',
           null,
           null,
           null,
           null,
           null,
           null,
           null,
           '0',
           null,
           null,
           null,
           null,
           null,
           null,
           null,
           null);
      END;
    END IF;
  END;
END;

BEGIN
  DECLARE
    V_CNT NUMBER;
  BEGIN
    SELECT COUNT(*)
      INTO V_CNT
      FROM sys_item_list
     where ITEM_ID = 'flow_process';
    IF V_CNT = 0 THEN
      BEGIN
        DECLARE
          P_BLOB0 clob;
          P_BLOB1 clob;
          P_BLOB2 clob;
          P_BLOB3 clob;
        BEGIN
          P_BLOB0 := '
select t.process_id, t.process_type_id, t.process_name, t.process_state
  from wf_process t
 where t.process_type_id = :process_type_id
   and t.pause = 0
';
          P_BLOB1 := 'declare
  v_process_type_id    varchar2(32) := :process_type_id; --流程类型ID
  v_process_name       varchar2(32) := :process_name; --流程名称
  v_user               varchar2(32) := %currentuserid%; --当前用户
  v_process_id         varchar2(32); --流程ID
  v_process_version_id varchar2(32); --流程版本ID

begin

  select ''process_'' || process_id.nextval into v_process_id from dual; --流程ID
  select ''process_version_'' || process_version_id.nextval
    into v_process_version_id
    from dual; --流程版本ID

  insert into wf_process --新增流程
    (process_id, process_type_id, process_name, process_state, pause)
  values
    (v_process_id, v_process_type_id, v_process_name, 2, 0);

  insert into wf_process_version --新增流程版本
    (process_version_id,
     process_id,
     process_version,
     process_version_state,
     create_time,
     create_user)
  values
    (v_process_version_id, v_process_id, 1.0, 2, sysdate, v_user);
  commit;
exception
  when others then
    rollback;
end;                                                                                                      
';
          P_BLOB2 := 'update wf_process
   set process_name = :process_name
 where process_id = :process_id
';
          P_BLOB3 := 'update wf_process set pause = 1 where process_id = :process_id
';
          INSERT INTO sys_item_list
            (ITEM_ID,
             QUERY_TYPE,
             QUERY_FIELDS,
             QUERY_COUNT,
             EDIT_EXPRESS,
             NEWID_SQL,
             SELECT_SQL,
             DETAIL_SQL,
             SUBSELECT_SQL,
             INSERT_SQL,
             UPDATE_SQL,
             DELETE_SQL,
             NOSHOW_FIELDS,
             NOADD_FIELDS,
             NOMODIFY_FIELDS,
             NOEDIT_FIELDS,
             SUBNOSHOW_FIELDS,
             UI_TMPL,
             MULTI_PAGE_FLAG,
             OUTPUT_PARAMETER,
             LOCK_SQL,
             MONITOR_ID,
             END_FIELD,
             EXECUTE_TIME,
             SHOW_CHECKBOX,
             SCANNABLE_FIELD,
             AUTO_REFRESH,
             SUB_TABLE_JUDGE_FIELD,
             BACK_GROUND_ID,
             OPERATION_TYPE,
             OPRETION_HINT,
             SUB_EDIT_STATE,
             HINT_TYPE,
             SCANNABLE_LOCATION_LINE,
             NOSHOW_APP_FIELDS,
             MAX_ROW_COUNT,
             SCANNABLE_TIME,
             RFID_FLAG,
             SCANNABLE_TYPE,
             HEADER,
             FOOTER,
             JUMP_FIELD,
             JUMP_EXPRESS)
          VALUES
            ('flow_process',
             '3',
             null,
             null,
             null,
             null,
             P_BLOB0,
             null,
             null,
             P_BLOB1,
             P_BLOB2,
             P_BLOB3,
             'process_version_id,process_state,process_type_id',
             null,
             null,
             null,
             null,
             null,
             '1',
             null,
             null,
             null,
             null,
             null,
             '0',
             null,
             null,
             null,
             null,
             null,
             null,
             null,
             null,
             null,
             null,
             null,
             null,
             null,
             null,
             null,
             null,
             null,
             null);
        END;
      END;
    END IF;
  END;
END;

--lookup(状态:PROCESS_STATE_NAME)
BEGIN
  DECLARE
    V_CNT NUMBER;
  BEGIN
    SELECT COUNT(*)
      INTO V_CNT
      FROM sys_field_list
     where FIELD_NAME = 'PROCESS_STATE_NAME';
    IF V_CNT = 0 THEN
      BEGIN
        INSERT INTO sys_field_list
          (FIELD_NAME,
           CAPTION,
           REQUIERED_FLAG,
           INPUT_HINT,
           VALID_CHARS,
           INVALID_CHARS,
           CHECK_EXPRESS,
           CHECK_MESSAGE,
           READ_ONLY_FLAG,
           NO_EDIT,
           NO_COPY,
           NO_SUM,
           NO_SORT,
           ALIGNMENT,
           MAX_LENGTH,
           MIN_LENGTH,
           DISPLAY_WIDTH,
           DISPLAY_FORMAT,
           EDIT_FORMT,
           DATA_TYPE,
           MAX_VALUE,
           MIN_VALUE,
           DEFAULT_VALUE,
           IME_CARE,
           IME_OPEN,
           VALUE_LISTS,
           VALUE_LIST_TYPE,
           HYPER_RES,
           MULTI_VALUE_FLAG,
           TRUE_EXPR,
           FALSE_EXPR,
           NAME_RULE_FLAG,
           NAME_RULE_ID,
           DATA_TYPE_FLAG,
           ALLOW_SCAN,
           VALUE_ENCRYPT,
           VALUE_SENSITIVE,
           OPERATOR_FLAG)
        VALUES
          ('PROCESS_STATE_NAME',
           '状态',
           '0',
           null,
           null,
           null,
           null,
           null,
           '0',
           '0',
           '0',
           '0',
           '0',
           '0',
           null,
           null,
           null,
           null,
           null,
           null,
           null,
           null,
           null,
           '0',
           '0',
           null,
           null,
           null,
           null,
           null,
           null,
           null,
           null,
           null,
           null,
           null,
           null,
           null);
      END;
    END IF;
  END;
END;

BEGIN
  DECLARE
    V_CNT NUMBER;
  BEGIN
    SELECT COUNT(*)
      INTO V_CNT
      FROM sys_element
     where ELEMENT_ID = 'lookup_process_state_name';
    IF V_CNT = 0 THEN
      BEGIN
        INSERT INTO sys_element
          (ELEMENT_ID, ELEMENT_TYPE, DATA_SOURCE, PAUSE, MESSAGE, IS_HIDE)
        VALUES
          ('lookup_process_state_name', 'lookup', null, '0', null, null);
      END;
    END IF;
  END;
END;

BEGIN
  DECLARE
    V_CNT NUMBER;
  BEGIN
    SELECT COUNT(*)
      INTO V_CNT
      FROM sys_look_up
     where ELEMENT_ID = 'lookup_process_state_name';
    IF V_CNT = 0 THEN
      BEGIN
        DECLARE
          P_BLOB0 clob;
        BEGIN
          P_BLOB0 := 'select 0 PROCESS_STATE, ''未启用'' PROCESS_STATE_NAME from dual
union all
select 1 PROCESS_STATE, ''运行中'' PROCESS_STATE_NAME from dual
union all
select 2 PROCESS_STATE, ''设计中'' PROCESS_STATE_NAME from dual
union all
select 3 PROCESS_STATE, ''归档'' PROCESS_STATE_NAME from dual           
';
          INSERT INTO sys_look_up
            (ELEMENT_ID,
             FIELD_NAME,
             LOOK_UP_SQL,
             DATA_TYPE,
             KEY_FIELD,
             RESULT_FIELD,
             BEFORE_FIELD)
          VALUES
            ('lookup_process_state_name',
             'PROCESS_STATE_NAME',
             P_BLOB0,
             '1',
             'PROCESS_STATE',
             'PROCESS_STATE_NAME',
             'PROCESS_STATE');
        END;
      END;
    END IF;
  END;
END;

BEGIN
  DECLARE
    V_CNT NUMBER;
  BEGIN
    SELECT COUNT(*)
      INTO V_CNT
      FROM sys_item_element_rela
     where ITEM_ID = 'flow_process'
       and ELEMENT_ID = 'lookup_process_state_name';
    IF V_CNT = 0 THEN
      BEGIN
        INSERT INTO sys_item_element_rela
          (ITEM_ID, ELEMENT_ID, SEQ_NO, PAUSE, LEVEL_NO)
        VALUES
          ('flow_process', 'lookup_process_state_name', '1', '0', null);
      END;
    END IF;
  END;
END;

--主从
BEGIN
  DECLARE
    V_CNT NUMBER;
  BEGIN
    SELECT COUNT(*)
      INTO V_CNT
      FROM sys_item_rela
     where ITEM_ID = 'flow_type_manage'
       and RELATE_ID = 'flow_process';
    IF V_CNT = 0 THEN
      BEGIN
        INSERT INTO sys_item_rela
          (ITEM_ID, RELATE_ID, RELATE_TYPE, SEQ_NO, PAUSE)
        VALUES
          ('flow_type_manage', 'flow_process', 'S', '1', '0');
      END;
    END IF;
  END;
END;

--------------------------------流程管理--------------------------------
BEGIN
  DECLARE
    V_CNT NUMBER;
  BEGIN
    SELECT COUNT(*)
      INTO V_CNT
      FROM sys_item
     where ITEM_ID = 'flow_process_manage';
    IF V_CNT = 0 THEN
      BEGIN
        INSERT INTO sys_item
          (ITEM_ID,
           ITEM_TYPE,
           CAPTION_SQL,
           DATA_SOURCE,
           BASE_TABLE,
           KEY_FIELD,
           NAME_FIELD,
           SETTING_ID,
           REPORT_TITLE,
           SUB_SCRIPTS,
           PAUSE,
           LINK_FIELD,
           HELP_ID,
           TAG_ID,
           CONFIG_PARAMS,
           TIME_OUT,
           OFFLINE_FLAG,
           PANEL_ID,
           INIT_SHOW)
        VALUES
          ('flow_process_manage',
           'list',
           '流程管理',
           null,
           null,
           'process_id',
           null,
           null,
           null,
           null,
           '0',
           null,
           null,
           null,
           null,
           null,
           null,
           null,
           null);
      END;
    END IF;
  END;
END;

BEGIN
  DECLARE
    V_CNT NUMBER;
  BEGIN
    SELECT COUNT(*)
      INTO V_CNT
      FROM sys_item_list
     where ITEM_ID = 'flow_process_manage';
    IF V_CNT = 0 THEN
      BEGIN
        DECLARE
          P_BLOB0 clob;
        BEGIN
          P_BLOB0 := 'select t1.process_id,
       t1.process_name,
       t2.process_type_name,
       t1.process_state
  from wf_process t1, wf_process_type t2
 where t1.process_type_id = t2.process_type_id
   and t2.app_id = :app_id
   and t1.pause = 0
';
          INSERT INTO sys_item_list
            (ITEM_ID,
             QUERY_TYPE,
             QUERY_FIELDS,
             QUERY_COUNT,
             EDIT_EXPRESS,
             NEWID_SQL,
             SELECT_SQL,
             DETAIL_SQL,
             SUBSELECT_SQL,
             INSERT_SQL,
             UPDATE_SQL,
             DELETE_SQL,
             NOSHOW_FIELDS,
             NOADD_FIELDS,
             NOMODIFY_FIELDS,
             NOEDIT_FIELDS,
             SUBNOSHOW_FIELDS,
             UI_TMPL,
             MULTI_PAGE_FLAG,
             OUTPUT_PARAMETER,
             LOCK_SQL,
             MONITOR_ID,
             END_FIELD,
             EXECUTE_TIME,
             SHOW_CHECKBOX,
             SCANNABLE_FIELD,
             AUTO_REFRESH,
             SUB_TABLE_JUDGE_FIELD,
             BACK_GROUND_ID,
             OPERATION_TYPE,
             OPRETION_HINT,
             SUB_EDIT_STATE,
             HINT_TYPE,
             SCANNABLE_LOCATION_LINE,
             NOSHOW_APP_FIELDS,
             MAX_ROW_COUNT,
             SCANNABLE_TIME,
             RFID_FLAG,
             SCANNABLE_TYPE,
             HEADER,
             FOOTER,
             JUMP_FIELD,
             JUMP_EXPRESS)
          VALUES
            ('flow_process_manage',
             '3',
             null,
             null,
             null,
             null,
             P_BLOB0,
             null,
             null,
             null,
             null,
             null,
             'process_state',
             null,
             null,
             null,
             null,
             null,
             '1',
             null,
             null,
             null,
             null,
             null,
             '0',
             null,
             null,
             null,
             null,
             null,
             null,
             null,
             null,
             null,
             null,
             null,
             null,
             null,
             null,
             null,
             null,
             null,
             null);
        END;
      END;
    END IF;
  END;
END;

BEGIN
  DECLARE
    V_CNT NUMBER;
  BEGIN
    SELECT COUNT(*)
      INTO V_CNT
      FROM sys_tree_list
     where NODE_ID = 'node_flow_process_manage';
    IF V_CNT = 0 THEN
      BEGIN
        INSERT INTO sys_tree_list
          (NODE_ID,
           TREE_ID,
           ITEM_ID,
           PARENT_ID,
           VAR_ID,
           APP_ID,
           ICON_NAME,
           IS_END,
           STAND_PRIV_FLAG,
           SEQ_NO,
           PAUSE,
           TERMINAL_FLAG,
           CAPTION_EXPLAIN,
           COMPETENCE_FLAG,
           NODE_TYPE,
           IS_AUTHORIZE)
        VALUES
          ('node_flow_process_manage',
           'flow_tree',
           'flow_process_manage',
           'flow_menu',
           null,
           'app_sanfu_retail',
           'blue iconfont icon--wenjianjia',
           '0',
           null,
           '2',
           '0',
           null,
           '流程管理',
           null,
           '1',
           '1');
      END;
    END IF;
  END;
END;

--action(启动:action_process_start、暂停:action_process_suspend、归档:action_process_file、发布新版本:action_new_version、流程设计:action_flow_design)
BEGIN
  DECLARE
    V_CNT NUMBER;
  BEGIN
    SELECT COUNT(*)
      INTO V_CNT
      FROM sys_element
     where ELEMENT_ID = 'action_flow_design';
    IF V_CNT = 0 THEN
      BEGIN
        INSERT INTO sys_element
          (ELEMENT_ID, ELEMENT_TYPE, DATA_SOURCE, PAUSE, MESSAGE, IS_HIDE)
        VALUES
          ('action_flow_design', 'flow', null, '0', null, null);
      END;
    END IF;
  END;
END;

BEGIN
  DECLARE
    V_CNT NUMBER;
  BEGIN
    SELECT COUNT(*)
      INTO V_CNT
      FROM sys_element
     where ELEMENT_ID = 'action_new_version';
    IF V_CNT = 0 THEN
      BEGIN
        INSERT INTO sys_element
          (ELEMENT_ID, ELEMENT_TYPE, DATA_SOURCE, PAUSE, MESSAGE, IS_HIDE)
        VALUES
          ('action_new_version', 'action', null, '0', null, null);
      END;
    END IF;
  END;
END;

BEGIN
  DECLARE
    V_CNT NUMBER;
  BEGIN
    SELECT COUNT(*)
      INTO V_CNT
      FROM sys_element
     where ELEMENT_ID = 'action_process_file';
    IF V_CNT = 0 THEN
      BEGIN
        INSERT INTO sys_element
          (ELEMENT_ID, ELEMENT_TYPE, DATA_SOURCE, PAUSE, MESSAGE, IS_HIDE)
        VALUES
          ('action_process_file', 'action', null, '0', null, null);
      END;
    END IF;
  END;
END;

BEGIN
  DECLARE
    V_CNT NUMBER;
  BEGIN
    SELECT COUNT(*)
      INTO V_CNT
      FROM sys_element
     where ELEMENT_ID = 'action_process_start';
    IF V_CNT = 0 THEN
      BEGIN
        INSERT INTO sys_element
          (ELEMENT_ID, ELEMENT_TYPE, DATA_SOURCE, PAUSE, MESSAGE, IS_HIDE)
        VALUES
          ('action_process_start', 'action', null, '0', null, null);
      END;
    END IF;
  END;
END;

BEGIN
  DECLARE
    V_CNT NUMBER;
  BEGIN
    SELECT COUNT(*)
      INTO V_CNT
      FROM sys_element
     where ELEMENT_ID = 'action_process_suspend';
    IF V_CNT = 0 THEN
      BEGIN
        INSERT INTO sys_element
          (ELEMENT_ID, ELEMENT_TYPE, DATA_SOURCE, PAUSE, MESSAGE, IS_HIDE)
        VALUES
          ('action_process_suspend', 'action', null, '0', null, null);
      END;
    END IF;
  END;
END;

BEGIN
  DECLARE
    V_CNT NUMBER;
  BEGIN
    SELECT COUNT(*)
      INTO V_CNT
      FROM sys_action
     where ELEMENT_ID = 'action_new_version';
    IF V_CNT = 0 THEN
      BEGIN
        DECLARE
          P_BLOB0 clob;
        BEGIN
          P_BLOB0 := 'declare
  v_process_id         varchar2(32) := :process_id; --流程ID
  v_process_version_id varchar2(32); --流程版本
begin

  select process_version_id --获取新版本
    into v_process_version_id
    from (select row_number() over(partition by process_id order by process_version desc) rn,
                 wf_process_version.*
            from wf_process_version
           where process_id = v_process_id)
   where rn = 1;

  update wf_process set process_state = 1 where process_id = v_process_id; --更新流程状态

  update wf_process_version --启动新版本
     set process_version_state = 1, update_time = sysdate
   where process_version_id = v_process_version_id;

  update wf_process_version --其余版本归档
     set process_version_state = 3, update_time = sysdate
   where process_id = v_process_id
     and process_version_id != v_process_version_id;
  commit;
exception
  when others then
    rollback;
end;                            
';
          INSERT INTO sys_action
            (ELEMENT_ID,
             CAPTION,
             ICON_NAME,
             ACTION_TYPE,
             ACTION_SQL,
             SELECT_FIELDS,
             REFRESH_FLAG,
             MULTI_PAGE_FLAG,
             PRE_FLAG,
             FILTER_EXPRESS,
             UPDATE_FIELDS,
             PORT_ID,
             PORT_SQL,
             LOCK_SQL,
             SELECTION_FLAG,
             CALL_ID,
             OPERATE_MODE,
             PORT_TYPE)
          VALUES
            ('action_new_version',
             '发布新版本',
             'EXPRDATA',
             '4',
             P_BLOB0,
             null,
             '1',
             '1',
             '0',
             null,
             null,
             null,
             null,
             null,
             '0',
             null,
             null,
             '1');
        END;
      END;
    END IF;
  END;
END;

BEGIN
  DECLARE
    V_CNT NUMBER;
  BEGIN
    SELECT COUNT(*)
      INTO V_CNT
      FROM sys_action
     where ELEMENT_ID = 'action_process_file';
    IF V_CNT = 0 THEN
      BEGIN
        DECLARE
          P_BLOB0 clob;
        BEGIN
          P_BLOB0 := 'declare
  v_process_id varchar2(32) := :process_id; --流程ID
begin
  update wf_process set process_state = 3 where process_id = v_process_id; --更新流程状态

  update wf_process_version --更新版本状态
     set process_version_state = 3, update_time = sysdate
   where process_id = v_process_id;
  commit;
exception
  when others then
    rollback;
end;              
';
          INSERT INTO sys_action
            (ELEMENT_ID,
             CAPTION,
             ICON_NAME,
             ACTION_TYPE,
             ACTION_SQL,
             SELECT_FIELDS,
             REFRESH_FLAG,
             MULTI_PAGE_FLAG,
             PRE_FLAG,
             FILTER_EXPRESS,
             UPDATE_FIELDS,
             PORT_ID,
             PORT_SQL,
             LOCK_SQL,
             SELECTION_FLAG,
             CALL_ID,
             OPERATE_MODE,
             PORT_TYPE)
          VALUES
            ('action_process_file',
             '归档',
             'EXPRDATA',
             '4',
             P_BLOB0,
             null,
             '1',
             '1',
             '0',
             null,
             null,
             null,
             null,
             null,
             '0',
             null,
             null,
             '1');
        END;
      END;
    END IF;
  END;
END;

BEGIN
  DECLARE
    V_CNT NUMBER;
  BEGIN
    SELECT COUNT(*)
      INTO V_CNT
      FROM sys_action
     where ELEMENT_ID = 'action_process_start';
    IF V_CNT = 0 THEN
      BEGIN
        DECLARE
          P_BLOB0 clob;
        BEGIN
          P_BLOB0 := 'declare
  v_process_id         varchar2(32) := :process_id; --流程ID
  v_process_version_id varchar2(32); --流程版本
  v_count              number(1);
begin

  select count(1)
    into v_count
    from wf_process_version
   where process_id = v_process_id
     and process_version_state = 0;

  if v_count = 0 then
    select process_version_id --获取新版本
      into v_process_version_id
      from (select row_number() over(partition by process_id order by process_version desc) rn,
                   wf_process_version.*
              from wf_process_version
             where process_id = v_process_id)
     where rn = 1;
  else
    select process_version_id --获取暂停版本
      into v_process_version_id
      from wf_process_version
     where process_id = v_process_id
       and process_version_state = 0;
  end if;

  update wf_process set process_state = 1 where process_id = v_process_id; --更新流程状态

  update wf_process_version --更新版本状态
     set process_version_state = 1, update_time = sysdate
   where process_version_id = v_process_version_id;
  commit;
exception
  when others then
    rollback;
end;                                        
';
          INSERT INTO sys_action
            (ELEMENT_ID,
             CAPTION,
             ICON_NAME,
             ACTION_TYPE,
             ACTION_SQL,
             SELECT_FIELDS,
             REFRESH_FLAG,
             MULTI_PAGE_FLAG,
             PRE_FLAG,
             FILTER_EXPRESS,
             UPDATE_FIELDS,
             PORT_ID,
             PORT_SQL,
             LOCK_SQL,
             SELECTION_FLAG,
             CALL_ID,
             OPERATE_MODE,
             PORT_TYPE)
          VALUES
            ('action_process_start',
             '启动',
             'EXPRDATA',
             '4',
             P_BLOB0,
             null,
             '1',
             '1',
             '0',
             null,
             null,
             null,
             null,
             null,
             '0',
             null,
             null,
             '1');
        END;
      END;
    END IF;
  END;
END;

BEGIN
  DECLARE
    V_CNT NUMBER;
  BEGIN
    SELECT COUNT(*)
      INTO V_CNT
      FROM sys_action
     where ELEMENT_ID = 'action_process_suspend';
    IF V_CNT = 0 THEN
      BEGIN
        DECLARE
          P_BLOB0 clob;
        BEGIN
          P_BLOB0 := 'declare
  v_process_id         varchar2(32) := :process_id; --流程ID
  v_process_version_id varchar2(32); --流程版本
begin

  select process_version_id --获取运行版本
    into v_process_version_id
    from wf_process_version
   where process_id = v_process_id
     and process_version_state = 1;

  update wf_process set process_state = 0 where process_id = v_process_id; --更新流程状态

  update wf_process_version --更新版本状态
     set process_version_state = 0, update_time = sysdate
   where process_version_id = v_process_version_id;
  commit;
exception
  when others then
    rollback;
end;                        
';
          INSERT INTO sys_action
            (ELEMENT_ID,
             CAPTION,
             ICON_NAME,
             ACTION_TYPE,
             ACTION_SQL,
             SELECT_FIELDS,
             REFRESH_FLAG,
             MULTI_PAGE_FLAG,
             PRE_FLAG,
             FILTER_EXPRESS,
             UPDATE_FIELDS,
             PORT_ID,
             PORT_SQL,
             LOCK_SQL,
             SELECTION_FLAG,
             CALL_ID,
             OPERATE_MODE,
             PORT_TYPE)
          VALUES
            ('action_process_suspend',
             '暂停',
             'EXPRDATA',
             '4',
             P_BLOB0,
             null,
             '1',
             '1',
             '0',
             null,
             null,
             null,
             null,
             null,
             '0',
             null,
             null,
             '1');
        END;
      END;
    END IF;
  END;
END;

BEGIN
  DECLARE
    V_CNT NUMBER;
  BEGIN
    SELECT COUNT(*)
      INTO V_CNT
      FROM sys_flow_action
     where ELEMENT_ID = 'action_flow_design';
    IF V_CNT = 0 THEN
      BEGIN
        INSERT INTO sys_flow_action
          (ELEMENT_ID,
           METHOD,
           KEY_ID_FIELD,
           CAPTION,
           REFRESH_FLAG,
           OPEN_TYPE,
           ACTION_SQL,
           OPER_TYPE,
           MULTISELECT,
           PROCESS_ID)
        VALUES
          ('action_flow_design',
           'flow_design',
           'process_id',
           '流程设计',
           '0',
           'flow-design',
           null,
           '0',
           '1',
           null);
      END;
    END IF;
  END;
END;

BEGIN
  DECLARE
    V_CNT NUMBER;
  BEGIN
    SELECT COUNT(*)
      INTO V_CNT
      FROM sys_item_element_rela
     where ITEM_ID = 'flow_process_manage'
       and ELEMENT_ID = 'action_flow_design';
    IF V_CNT = 0 THEN
      BEGIN
        INSERT INTO sys_item_element_rela
          (ITEM_ID, ELEMENT_ID, SEQ_NO, PAUSE, LEVEL_NO)
        VALUES
          ('flow_process_manage', 'action_flow_design', '6', '0', null);
      END;
    END IF;
  END;
END;

BEGIN
  DECLARE
    V_CNT NUMBER;
  BEGIN
    SELECT COUNT(*)
      INTO V_CNT
      FROM sys_item_element_rela
     where ITEM_ID = 'flow_process_manage'
       and ELEMENT_ID = 'action_new_version';
    IF V_CNT = 0 THEN
      BEGIN
        INSERT INTO sys_item_element_rela
          (ITEM_ID, ELEMENT_ID, SEQ_NO, PAUSE, LEVEL_NO)
        VALUES
          ('flow_process_manage', 'action_new_version', '5', '0', null);
      END;
    END IF;
  END;
END;

BEGIN
  DECLARE
    V_CNT NUMBER;
  BEGIN
    SELECT COUNT(*)
      INTO V_CNT
      FROM sys_item_element_rela
     where ITEM_ID = 'flow_process_manage'
       and ELEMENT_ID = 'action_process_file';
    IF V_CNT = 0 THEN
      BEGIN
        INSERT INTO sys_item_element_rela
          (ITEM_ID, ELEMENT_ID, SEQ_NO, PAUSE, LEVEL_NO)
        VALUES
          ('flow_process_manage', 'action_process_file', '4', '0', null);
      END;
    END IF;
  END;
END;

BEGIN
  DECLARE
    V_CNT NUMBER;
  BEGIN
    SELECT COUNT(*)
      INTO V_CNT
      FROM sys_item_element_rela
     where ITEM_ID = 'flow_process_manage'
       and ELEMENT_ID = 'action_process_start';
    IF V_CNT = 0 THEN
      BEGIN
        INSERT INTO sys_item_element_rela
          (ITEM_ID, ELEMENT_ID, SEQ_NO, PAUSE, LEVEL_NO)
        VALUES
          ('flow_process_manage', 'action_process_start', '2', '0', null);
      END;
    END IF;
  END;
END;

BEGIN
  DECLARE
    V_CNT NUMBER;
  BEGIN
    SELECT COUNT(*)
      INTO V_CNT
      FROM sys_item_element_rela
     where ITEM_ID = 'flow_process_manage'
       and ELEMENT_ID = 'action_process_suspend';
    IF V_CNT = 0 THEN
      BEGIN
        INSERT INTO sys_item_element_rela
          (ITEM_ID, ELEMENT_ID, SEQ_NO, PAUSE, LEVEL_NO)
        VALUES
          ('flow_process_manage', 'action_process_suspend', '3', '0', null);
      END;
    END IF;
  END;
END;

BEGIN
  DECLARE
    V_CNT NUMBER;
  BEGIN
    SELECT COUNT(*)
      INTO V_CNT
      FROM sys_item_element_rela
     where ITEM_ID = 'flow_process_manage'
       and ELEMENT_ID = 'lookup_process_state_name';
    IF V_CNT = 0 THEN
      BEGIN
        INSERT INTO sys_item_element_rela
          (ITEM_ID, ELEMENT_ID, SEQ_NO, PAUSE, LEVEL_NO)
        VALUES
          ('flow_process_manage',
           'lookup_process_state_name',
           '1',
           '0',
           null);
      END;
    END IF;
  END;
END;

--checkvalue
BEGIN
  DECLARE
    V_CNT NUMBER;
  BEGIN
    SELECT COUNT(*)
      INTO V_CNT
      FROM sys_cond_list
     where COND_ID = 'action_new_version_1';
    IF V_CNT = 0 THEN
      BEGIN
        DECLARE
          P_BLOB0 clob;
          P_BLOB1 clob;
        BEGIN
          P_BLOB0 := 'select case
         when count(1) > 0 then
          0
         else
          1
       end flag
  from wf_process_version
 where process_id = :process_id
   and process_version_state = 2
';
          P_BLOB1 := '未存在新版本，发布失败！            
';
          INSERT INTO sys_cond_list
            (COND_ID,
             COND_SQL,
             COND_TYPE,
             SHOW_TEXT,
             DATA_SOURCE,
             COND_FIELD_NAME)
          VALUES
            ('action_new_version_1', P_BLOB0, '0', P_BLOB1, null, null);
        END;
      END;
    END IF;
  END;
END;

BEGIN
  DECLARE
    V_CNT NUMBER;
  BEGIN
    SELECT COUNT(*)
      INTO V_CNT
      FROM sys_cond_list
     where COND_ID = 'action_process_start_1';
    IF V_CNT = 0 THEN
      BEGIN
        DECLARE
          P_BLOB0 clob;
          P_BLOB1 clob;
        BEGIN
          P_BLOB0 := 'select count(1) flag
  from wf_process_version
 where process_id = :process_id
   and process_version_state = 1
';
          P_BLOB1 := '已存在运行中的流程版本，请勿重复启动！                   
';
          INSERT INTO sys_cond_list
            (COND_ID,
             COND_SQL,
             COND_TYPE,
             SHOW_TEXT,
             DATA_SOURCE,
             COND_FIELD_NAME)
          VALUES
            ('action_process_start_1', P_BLOB0, '0', P_BLOB1, null, null);
        END;
      END;
    END IF;
  END;
END;

BEGIN
  DECLARE
    V_CNT NUMBER;
  BEGIN
    SELECT COUNT(*)
      INTO V_CNT
      FROM sys_cond_list
     where COND_ID = 'action_process_start_2';
    IF V_CNT = 0 THEN
      BEGIN
        DECLARE
          P_BLOB0 clob;
          P_BLOB1 clob;
        BEGIN
          P_BLOB0 := 'select case
         when count(1) < 1 then
          1
         else
          0
       end flag
  from wf_process_version
 where process_id = :process_id
   and process_version_state in (0, 2)
';
          P_BLOB1 := '未存在可运行的流程版本，启动失败！                 
';
          INSERT INTO sys_cond_list
            (COND_ID,
             COND_SQL,
             COND_TYPE,
             SHOW_TEXT,
             DATA_SOURCE,
             COND_FIELD_NAME)
          VALUES
            ('action_process_start_2', P_BLOB0, '0', P_BLOB1, null, null);
        END;
      END;
    END IF;
  END;
END;

BEGIN
  DECLARE
    V_CNT NUMBER;
  BEGIN
    SELECT COUNT(*)
      INTO V_CNT
      FROM sys_cond_list
     where COND_ID = 'action_process_suspend_1';
    IF V_CNT = 0 THEN
      BEGIN
        DECLARE
          P_BLOB0 clob;
          P_BLOB1 clob;
        BEGIN
          P_BLOB0 := 'select case
         when count(1) > 0 then
          0
         else
          1
       end flag
  from wf_process_version
 where process_id = :process_id
   and process_version_state = 1
';
          P_BLOB1 := '未存在运行的流程，暂停失败！              
';
          INSERT INTO sys_cond_list
            (COND_ID,
             COND_SQL,
             COND_TYPE,
             SHOW_TEXT,
             DATA_SOURCE,
             COND_FIELD_NAME)
          VALUES
            ('action_process_suspend_1', P_BLOB0, '0', P_BLOB1, null, null);
        END;
      END;
    END IF;
  END;
END;

BEGIN
  DECLARE
    V_CNT NUMBER;
  BEGIN
    SELECT COUNT(*)
      INTO V_CNT
      FROM sys_cond_rela
     where COND_ID = 'action_process_suspend_1'
       and OBJ_TYPE = '91'
       and CTL_ID = 'action_process_suspend'
       and CTL_TYPE = '1'
       and ITEM_ID is null;
    IF V_CNT = 0 THEN
      BEGIN
        INSERT INTO sys_cond_rela
          (COND_ID, OBJ_TYPE, CTL_ID, CTL_TYPE, SEQ_NO, PAUSE, ITEM_ID)
        VALUES
          ('action_process_suspend_1',
           '91',
           'action_process_suspend',
           '1',
           '1',
           '0',
           null);
      END;
    END IF;
  END;
END;

BEGIN
  DECLARE
    V_CNT NUMBER;
  BEGIN
    SELECT COUNT(*)
      INTO V_CNT
      FROM sys_cond_rela
     where COND_ID = 'action_process_start_1'
       and OBJ_TYPE = '91'
       and CTL_ID = 'action_process_start'
       and CTL_TYPE = '1'
       and ITEM_ID is null;
    IF V_CNT = 0 THEN
      BEGIN
        INSERT INTO sys_cond_rela
          (COND_ID, OBJ_TYPE, CTL_ID, CTL_TYPE, SEQ_NO, PAUSE, ITEM_ID)
        VALUES
          ('action_process_start_1',
           '91',
           'action_process_start',
           '1',
           '1',
           '0',
           null);
      END;
    END IF;
  END;
END;

BEGIN
  DECLARE
    V_CNT NUMBER;
  BEGIN
    SELECT COUNT(*)
      INTO V_CNT
      FROM sys_cond_rela
     where COND_ID = 'action_process_start_2'
       and OBJ_TYPE = '91'
       and CTL_ID = 'action_process_start'
       and CTL_TYPE = '1'
       and ITEM_ID is null;
    IF V_CNT = 0 THEN
      BEGIN
        INSERT INTO sys_cond_rela
          (COND_ID, OBJ_TYPE, CTL_ID, CTL_TYPE, SEQ_NO, PAUSE, ITEM_ID)
        VALUES
          ('action_process_start_2',
           '91',
           'action_process_start',
           '1',
           '2',
           '0',
           null);
      END;
    END IF;
  END;
END;

BEGIN
  DECLARE
    V_CNT NUMBER;
  BEGIN
    SELECT COUNT(*)
      INTO V_CNT
      FROM sys_cond_rela
     where COND_ID = 'action_new_version_1'
       and OBJ_TYPE = '91'
       and CTL_ID = 'action_new_version'
       and CTL_TYPE = '1'
       and ITEM_ID is null;
    IF V_CNT = 0 THEN
      BEGIN
        INSERT INTO sys_cond_rela
          (COND_ID, OBJ_TYPE, CTL_ID, CTL_TYPE, SEQ_NO, PAUSE, ITEM_ID)
        VALUES
          ('action_new_version_1',
           '91',
           'action_new_version',
           '1',
           '1',
           '0',
           null);
      END;
    END IF;
  END;
END;

--子表(流程版本)
BEGIN
  DECLARE
    V_CNT NUMBER;
  BEGIN
    SELECT COUNT(*)
      INTO V_CNT
      FROM sys_item
     where ITEM_ID = 'flow_process_version';
    IF V_CNT = 0 THEN
      BEGIN
        INSERT INTO sys_item
          (ITEM_ID,
           ITEM_TYPE,
           CAPTION_SQL,
           DATA_SOURCE,
           BASE_TABLE,
           KEY_FIELD,
           NAME_FIELD,
           SETTING_ID,
           REPORT_TITLE,
           SUB_SCRIPTS,
           PAUSE,
           LINK_FIELD,
           HELP_ID,
           TAG_ID,
           CONFIG_PARAMS,
           TIME_OUT,
           OFFLINE_FLAG,
           PANEL_ID,
           INIT_SHOW)
        VALUES
          ('flow_process_version',
           'list',
           '流程版本',
           null,
           null,
           null,
           null,
           null,
           null,
           null,
           '0',
           null,
           null,
           null,
           null,
           null,
           null,
           null,
           null);
      END;
    END IF;
  END;
END;

BEGIN
  DECLARE
    V_CNT NUMBER;
  BEGIN
    SELECT COUNT(*)
      INTO V_CNT
      FROM sys_item_list
     where ITEM_ID = 'flow_process_version';
    IF V_CNT = 0 THEN
      BEGIN
        DECLARE
          P_BLOB0 clob;
        BEGIN
          P_BLOB0 := 'select t1.process_version_id,
       t1.process_id,
       ''V'' || t1.process_version process_version,
       t1.create_time,
       t1.update_time,
       t2.username create_user,
       t1.process_version_state process_state
  from wf_process_version t1
 inner join nsfdata.users t2 on t1.create_user = t2.userid
 where t1.process_id = :process_id
 order by t1.create_time desc
';
          INSERT INTO sys_item_list
            (ITEM_ID,
             QUERY_TYPE,
             QUERY_FIELDS,
             QUERY_COUNT,
             EDIT_EXPRESS,
             NEWID_SQL,
             SELECT_SQL,
             DETAIL_SQL,
             SUBSELECT_SQL,
             INSERT_SQL,
             UPDATE_SQL,
             DELETE_SQL,
             NOSHOW_FIELDS,
             NOADD_FIELDS,
             NOMODIFY_FIELDS,
             NOEDIT_FIELDS,
             SUBNOSHOW_FIELDS,
             UI_TMPL,
             MULTI_PAGE_FLAG,
             OUTPUT_PARAMETER,
             LOCK_SQL,
             MONITOR_ID,
             END_FIELD,
             EXECUTE_TIME,
             SHOW_CHECKBOX,
             SCANNABLE_FIELD,
             AUTO_REFRESH,
             SUB_TABLE_JUDGE_FIELD,
             BACK_GROUND_ID,
             OPERATION_TYPE,
             OPRETION_HINT,
             SUB_EDIT_STATE,
             HINT_TYPE,
             SCANNABLE_LOCATION_LINE,
             NOSHOW_APP_FIELDS,
             MAX_ROW_COUNT,
             SCANNABLE_TIME,
             RFID_FLAG,
             SCANNABLE_TYPE,
             HEADER,
             FOOTER,
             JUMP_FIELD,
             JUMP_EXPRESS)
          VALUES
            ('flow_process_version',
             '3',
             null,
             null,
             null,
             null,
             P_BLOB0,
             null,
             null,
             null,
             null,
             null,
             'process_version_id,process_id,process_state',
             null,
             null,
             null,
             null,
             null,
             '1',
             null,
             null,
             null,
             null,
             null,
             '0',
             null,
             null,
             null,
             null,
             null,
             null,
             null,
             null,
             null,
             null,
             null,
             null,
             null,
             null,
             null,
             null,
             null,
             null);
        END;
      END;
    END IF;
  END;
END;

--action(流程设计版本:action_flow_version_design)
BEGIN
  DECLARE
    V_CNT NUMBER;
  BEGIN
    SELECT COUNT(*)
      INTO V_CNT
      FROM sys_element
     where ELEMENT_ID = 'action_flow_version_design';
    IF V_CNT = 0 THEN
      BEGIN
        INSERT INTO sys_element
          (ELEMENT_ID, ELEMENT_TYPE, DATA_SOURCE, PAUSE, MESSAGE, IS_HIDE)
        VALUES
          ('action_flow_version_design', 'flow', null, '0', null, null);
      END;
    END IF;
  END;
END;

BEGIN
  DECLARE
    V_CNT NUMBER;
  BEGIN
    SELECT COUNT(*)
      INTO V_CNT
      FROM sys_flow_action
     where ELEMENT_ID = 'action_flow_version_design';
    IF V_CNT = 0 THEN
      BEGIN
        INSERT INTO sys_flow_action
          (ELEMENT_ID,
           METHOD,
           KEY_ID_FIELD,
           CAPTION,
           REFRESH_FLAG,
           OPEN_TYPE,
           ACTION_SQL,
           OPER_TYPE,
           MULTISELECT,
           PROCESS_ID)
        VALUES
          ('action_flow_version_design',
           'flow_design',
           'process_version_id',
           '流程设计版本',
           '0',
           'flow-design',
           null,
           '0',
           '1',
           null);
      END;
    END IF;
  END;
END;

BEGIN
  DECLARE
    V_CNT NUMBER;
  BEGIN
    SELECT COUNT(*)
      INTO V_CNT
      FROM sys_item_element_rela
     where ITEM_ID = 'flow_process_version'
       and ELEMENT_ID = 'action_flow_version_design';
    IF V_CNT = 0 THEN
      BEGIN
        INSERT INTO sys_item_element_rela
          (ITEM_ID, ELEMENT_ID, SEQ_NO, PAUSE, LEVEL_NO)
        VALUES
          ('flow_process_version',
           'action_flow_version_design',
           '2',
           '0',
           null);
      END;
    END IF;
  END;
END;

BEGIN
  DECLARE
    V_CNT NUMBER;
  BEGIN
    SELECT COUNT(*)
      INTO V_CNT
      FROM sys_item_element_rela
     where ITEM_ID = 'flow_process_version'
       and ELEMENT_ID = 'lookup_process_state_name';
    IF V_CNT = 0 THEN
      BEGIN
        INSERT INTO sys_item_element_rela
          (ITEM_ID, ELEMENT_ID, SEQ_NO, PAUSE, LEVEL_NO)
        VALUES
          ('flow_process_version',
           'lookup_process_state_name',
           '1',
           '0',
           null);
      END;
    END IF;
  END;
END;

--主从
BEGIN
  DECLARE
    V_CNT NUMBER;
  BEGIN
    SELECT COUNT(*)
      INTO V_CNT
      FROM sys_item_rela
     where ITEM_ID = 'flow_process_manage'
       and RELATE_ID = 'flow_process_version';
    IF V_CNT = 0 THEN
      BEGIN
        INSERT INTO sys_item_rela
          (ITEM_ID, RELATE_ID, RELATE_TYPE, SEQ_NO, PAUSE)
        VALUES
          ('flow_process_manage', 'flow_process_version', 'S', '1', '0');
      END;
    END IF;
  END;
END;

--------------------------------流程设计（参与者）--------------------------------
--设置参与者节点
BEGIN
  DECLARE
    V_CNT NUMBER;
  BEGIN
    SELECT COUNT(*)
      INTO V_CNT
      FROM sys_config
     where SET_NAME = 'assignee_node'
       and APP_ID = 'app_sanfu_retail';
    IF V_CNT = 0 THEN
      BEGIN
        INSERT INTO sys_config
          (SET_NAME, SET_VALUE, APP_ID)
        VALUES
          ('assignee_node', 'node_flow_process_design', 'app_sanfu_retail');
      END;
    END IF;
  END;
END;

--参与者(主表)
BEGIN
  DECLARE
    V_CNT NUMBER;
  BEGIN
    SELECT COUNT(*)
      INTO V_CNT
      FROM sys_item
     where ITEM_ID = 'flow_process_design';
    IF V_CNT = 0 THEN
      BEGIN
        INSERT INTO sys_item
          (ITEM_ID,
           ITEM_TYPE,
           CAPTION_SQL,
           DATA_SOURCE,
           BASE_TABLE,
           KEY_FIELD,
           NAME_FIELD,
           SETTING_ID,
           REPORT_TITLE,
           SUB_SCRIPTS,
           PAUSE,
           LINK_FIELD,
           HELP_ID,
           TAG_ID,
           CONFIG_PARAMS,
           TIME_OUT,
           OFFLINE_FLAG,
           PANEL_ID,
           INIT_SHOW)
        VALUES
          ('flow_process_design',
           'list',
           '参与者',
           null,
           null,
           null,
           null,
           null,
           null,
           null,
           '0',
           null,
           null,
           null,
           null,
           null,
           null,
           null,
           null);
      END;
    END IF;
  END;
END;

BEGIN
  DECLARE
    V_CNT NUMBER;
  BEGIN
    SELECT COUNT(*)
      INTO V_CNT
      FROM sys_item_list
     where ITEM_ID = 'flow_process_design';
    IF V_CNT = 0 THEN
      BEGIN
        INSERT INTO sys_item_list
          (ITEM_ID,
           QUERY_TYPE,
           QUERY_FIELDS,
           QUERY_COUNT,
           EDIT_EXPRESS,
           NEWID_SQL,
           SELECT_SQL,
           DETAIL_SQL,
           SUBSELECT_SQL,
           INSERT_SQL,
           UPDATE_SQL,
           DELETE_SQL,
           NOSHOW_FIELDS,
           NOADD_FIELDS,
           NOMODIFY_FIELDS,
           NOEDIT_FIELDS,
           SUBNOSHOW_FIELDS,
           UI_TMPL,
           MULTI_PAGE_FLAG,
           OUTPUT_PARAMETER,
           LOCK_SQL,
           MONITOR_ID,
           END_FIELD,
           EXECUTE_TIME,
           SHOW_CHECKBOX,
           SCANNABLE_FIELD,
           AUTO_REFRESH,
           SUB_TABLE_JUDGE_FIELD,
           BACK_GROUND_ID,
           OPERATION_TYPE,
           OPRETION_HINT,
           SUB_EDIT_STATE,
           HINT_TYPE,
           SCANNABLE_LOCATION_LINE,
           NOSHOW_APP_FIELDS,
           MAX_ROW_COUNT,
           SCANNABLE_TIME,
           RFID_FLAG,
           SCANNABLE_TYPE,
           HEADER,
           FOOTER,
           JUMP_FIELD,
           JUMP_EXPRESS)
        VALUES
          ('flow_process_design',
           null,
           null,
           null,
           null,
           null,
           null,
           null,
           null,
           null,
           null,
           null,
           null,
           null,
           null,
           null,
           null,
           null,
           '1',
           null,
           null,
           null,
           null,
           null,
           '0',
           null,
           null,
           null,
           null,
           null,
           null,
           null,
           null,
           null,
           null,
           null,
           null,
           null,
           null,
           null,
           null,
           null,
           null);
      END;
    END IF;
  END;
END;

BEGIN
  DECLARE
    V_CNT NUMBER;
  BEGIN
    SELECT COUNT(*)
      INTO V_CNT
      FROM sys_tree_list
     where NODE_ID = 'node_flow_process_design';
    IF V_CNT = 0 THEN
      BEGIN
        INSERT INTO sys_tree_list
          (NODE_ID,
           TREE_ID,
           ITEM_ID,
           PARENT_ID,
           VAR_ID,
           APP_ID,
           ICON_NAME,
           IS_END,
           STAND_PRIV_FLAG,
           SEQ_NO,
           PAUSE,
           TERMINAL_FLAG,
           CAPTION_EXPLAIN,
           COMPETENCE_FLAG,
           NODE_TYPE,
           IS_AUTHORIZE)
        VALUES
          ('node_flow_process_design',
           'flow_tree',
           'flow_process_design',
           null,
           null,
           'app_sanfu_retail',
           'blue iconfont icon--wenjianjia',
           '0',
           null,
           '1',
           '0',
           null,
           '流程设计',
           null,
           '1',
           '1');
      END;
    END IF;
  END;
END;

--子表(用户)
BEGIN
  DECLARE
    V_CNT NUMBER;
  BEGIN
    SELECT COUNT(*)
      INTO V_CNT
      FROM sys_item
     where ITEM_ID = 'assignee_user';
    IF V_CNT = 0 THEN
      BEGIN
        INSERT INTO sys_item
          (ITEM_ID,
           ITEM_TYPE,
           CAPTION_SQL,
           DATA_SOURCE,
           BASE_TABLE,
           KEY_FIELD,
           NAME_FIELD,
           SETTING_ID,
           REPORT_TITLE,
           SUB_SCRIPTS,
           PAUSE,
           LINK_FIELD,
           HELP_ID,
           TAG_ID,
           CONFIG_PARAMS,
           TIME_OUT,
           OFFLINE_FLAG,
           PANEL_ID,
           INIT_SHOW)
        VALUES
          ('assignee_user',
           'list',
           '用户',
           null,
           null,
           null,
           null,
           null,
           null,
           null,
           '0',
           null,
           null,
           null,
           null,
           null,
           null,
           null,
           null);
      END;
    END IF;
  END;
END;

BEGIN
  DECLARE
    V_CNT NUMBER;
  BEGIN
    SELECT COUNT(*)
      INTO V_CNT
      FROM sys_item_list
     where ITEM_ID = 'assignee_user';
    IF V_CNT = 0 THEN
      BEGIN
        INSERT INTO sys_item_list
          (ITEM_ID,
           QUERY_TYPE,
           QUERY_FIELDS,
           QUERY_COUNT,
           EDIT_EXPRESS,
           NEWID_SQL,
           SELECT_SQL,
           DETAIL_SQL,
           SUBSELECT_SQL,
           INSERT_SQL,
           UPDATE_SQL,
           DELETE_SQL,
           NOSHOW_FIELDS,
           NOADD_FIELDS,
           NOMODIFY_FIELDS,
           NOEDIT_FIELDS,
           SUBNOSHOW_FIELDS,
           UI_TMPL,
           MULTI_PAGE_FLAG,
           OUTPUT_PARAMETER,
           LOCK_SQL,
           MONITOR_ID,
           END_FIELD,
           EXECUTE_TIME,
           SHOW_CHECKBOX,
           SCANNABLE_FIELD,
           AUTO_REFRESH,
           SUB_TABLE_JUDGE_FIELD,
           BACK_GROUND_ID,
           OPERATION_TYPE,
           OPRETION_HINT,
           SUB_EDIT_STATE,
           HINT_TYPE,
           SCANNABLE_LOCATION_LINE,
           NOSHOW_APP_FIELDS,
           MAX_ROW_COUNT,
           SCANNABLE_TIME,
           RFID_FLAG,
           SCANNABLE_TYPE,
           HEADER,
           FOOTER,
           JUMP_FIELD,
           JUMP_EXPRESS)
        VALUES
          ('assignee_user',
           null,
           null,
           null,
           null,
           null,
           null,
           null,
           null,
           null,
           null,
           null,
           null,
           null,
           null,
           null,
           null,
           null,
           '1',
           null,
           null,
           null,
           null,
           null,
           '0',
           null,
           null,
           null,
           null,
           null,
           null,
           null,
           null,
           null,
           null,
           null,
           null,
           null,
           null,
           null,
           null,
           null,
           null);
      END;
    END IF;
  END;
END;

--pickup(用户)
BEGIN
  DECLARE
    V_CNT NUMBER;
  BEGIN
    SELECT COUNT(*)
      INTO V_CNT
      FROM sys_element
     where ELEMENT_ID = 'pick_assignee_user';
    IF V_CNT = 0 THEN
      BEGIN
        INSERT INTO sys_element
          (ELEMENT_ID, ELEMENT_TYPE, DATA_SOURCE, PAUSE, MESSAGE, IS_HIDE)
        VALUES
          ('pick_assignee_user', 'pick', 'oracle_nsfdata', '0', null, null);
      END;
    END IF;
  END;
END;

BEGIN
  DECLARE
    V_CNT NUMBER;
  BEGIN
    SELECT COUNT(*)
      INTO V_CNT
      FROM sys_pick_list
     where ELEMENT_ID = 'pick_assignee_user';
    IF V_CNT = 0 THEN
      BEGIN
        INSERT INTO sys_pick_list
          (ELEMENT_ID,
           FIELD_NAME,
           CAPTION,
           PICK_SQL,
           FROM_FIELD,
           QUERY_FIELDS,
           OTHER_FIELDS,
           TREE_FIELDS,
           LEVEL_FIELD,
           IMAGE_NAMES,
           TREE_ID,
           SEPERATOR,
           MULTI_VALUE_FLAG,
           RECURSION_FLAG,
           CUSTOM_QUERY,
           NAME_LIST_SQL)
        VALUES
          ('pick_assignee_user',
           'assignee',
           '用户',
           null,
           'USERID',
           'userid,username,mobile',
           null,
           'are_name,sho_name,username',
           'Are_ID,Sho_ID',
           'GROUPS,GROUPS,EMPLOYEE',
           'USER',
           ',',
           '2',
           null,
           '0',
           null);
      END;
    END IF;
  END;
END;

BEGIN
  DECLARE
    V_CNT NUMBER;
  BEGIN
    SELECT COUNT(*)
      INTO V_CNT
      FROM sys_item_element_rela
     where ITEM_ID = 'assignee_user'
       and ELEMENT_ID = 'pick_assignee_user';
    IF V_CNT = 0 THEN
      BEGIN
        INSERT INTO sys_item_element_rela
          (ITEM_ID, ELEMENT_ID, SEQ_NO, PAUSE, LEVEL_NO)
        VALUES
          ('assignee_user', 'pick_assignee_user', '1', '0', null);
      END;
    END IF;
  END;
END;

--子表(用户组)
BEGIN
  DECLARE
    V_CNT NUMBER;
  BEGIN
    SELECT COUNT(*)
      INTO V_CNT
      FROM sys_item
     where ITEM_ID = 'assignee_user_group';
    IF V_CNT = 0 THEN
      BEGIN
        INSERT INTO sys_item
          (ITEM_ID,
           ITEM_TYPE,
           CAPTION_SQL,
           DATA_SOURCE,
           BASE_TABLE,
           KEY_FIELD,
           NAME_FIELD,
           SETTING_ID,
           REPORT_TITLE,
           SUB_SCRIPTS,
           PAUSE,
           LINK_FIELD,
           HELP_ID,
           TAG_ID,
           CONFIG_PARAMS,
           TIME_OUT,
           OFFLINE_FLAG,
           PANEL_ID,
           INIT_SHOW)
        VALUES
          ('assignee_user_group',
           'list',
           '用户组',
           null,
           null,
           null,
           null,
           null,
           null,
           null,
           '0',
           null,
           null,
           null,
           null,
           null,
           null,
           null,
           null);
      END;
    END IF;
  END;
END;

BEGIN
  DECLARE
    V_CNT NUMBER;
  BEGIN
    SELECT COUNT(*)
      INTO V_CNT
      FROM sys_item_list
     where ITEM_ID = 'assignee_user_group';
    IF V_CNT = 0 THEN
      BEGIN
        INSERT INTO sys_item_list
          (ITEM_ID,
           QUERY_TYPE,
           QUERY_FIELDS,
           QUERY_COUNT,
           EDIT_EXPRESS,
           NEWID_SQL,
           SELECT_SQL,
           DETAIL_SQL,
           SUBSELECT_SQL,
           INSERT_SQL,
           UPDATE_SQL,
           DELETE_SQL,
           NOSHOW_FIELDS,
           NOADD_FIELDS,
           NOMODIFY_FIELDS,
           NOEDIT_FIELDS,
           SUBNOSHOW_FIELDS,
           UI_TMPL,
           MULTI_PAGE_FLAG,
           OUTPUT_PARAMETER,
           LOCK_SQL,
           MONITOR_ID,
           END_FIELD,
           EXECUTE_TIME,
           SHOW_CHECKBOX,
           SCANNABLE_FIELD,
           AUTO_REFRESH,
           SUB_TABLE_JUDGE_FIELD,
           BACK_GROUND_ID,
           OPERATION_TYPE,
           OPRETION_HINT,
           SUB_EDIT_STATE,
           HINT_TYPE,
           SCANNABLE_LOCATION_LINE,
           NOSHOW_APP_FIELDS,
           MAX_ROW_COUNT,
           SCANNABLE_TIME,
           RFID_FLAG,
           SCANNABLE_TYPE,
           HEADER,
           FOOTER,
           JUMP_FIELD,
           JUMP_EXPRESS)
        VALUES
          ('assignee_user_group',
           null,
           null,
           null,
           null,
           null,
           null,
           null,
           null,
           null,
           null,
           null,
           null,
           null,
           null,
           null,
           null,
           null,
           '1',
           null,
           null,
           null,
           null,
           null,
           '0',
           null,
           null,
           null,
           null,
           null,
           null,
           null,
           null,
           null,
           null,
           null,
           null,
           null,
           null,
           null,
           null,
           null,
           null);
      END;
    END IF;
  END;
END;

--pickup(用户组)
BEGIN
  DECLARE
    V_CNT NUMBER;
  BEGIN
    SELECT COUNT(*)
      INTO V_CNT
      FROM sys_element
     where ELEMENT_ID = 'pick_assignee_user_group';
    IF V_CNT = 0 THEN
      BEGIN
        INSERT INTO sys_element
          (ELEMENT_ID, ELEMENT_TYPE, DATA_SOURCE, PAUSE, MESSAGE, IS_HIDE)
        VALUES
          ('pick_assignee_user_group', 'pick', null, '0', null, null);
      END;
    END IF;
  END;
END;

BEGIN
  DECLARE
    V_CNT NUMBER;
  BEGIN
    SELECT COUNT(*)
      INTO V_CNT
      FROM sys_pick_list
     where ELEMENT_ID = 'pick_assignee_user_group';
    IF V_CNT = 0 THEN
      BEGIN
        DECLARE
          P_BLOB0 clob;
        BEGIN
          P_BLOB0 := 'select ''_'' || group_id group_id, group_name
  from rm_group
 where app_id = ''app_sanfu_retail''
   and pause = 0
';
          INSERT INTO sys_pick_list
            (ELEMENT_ID,
             FIELD_NAME,
             CAPTION,
             PICK_SQL,
             FROM_FIELD,
             QUERY_FIELDS,
             OTHER_FIELDS,
             TREE_FIELDS,
             LEVEL_FIELD,
             IMAGE_NAMES,
             TREE_ID,
             SEPERATOR,
             MULTI_VALUE_FLAG,
             RECURSION_FLAG,
             CUSTOM_QUERY,
             NAME_LIST_SQL)
          VALUES
            ('pick_assignee_user_group',
             'assignee',
             '用户组',
             P_BLOB0,
             'group_id',
             null,
             null,
             null,
             null,
             null,
             null,
             null,
             null,
             null,
             '0',
             null);
        END;
      END;
    END IF;
  END;
END;

BEGIN
  DECLARE
    V_CNT NUMBER;
  BEGIN
    SELECT COUNT(*)
      INTO V_CNT
      FROM sys_item_element_rela
     where ITEM_ID = 'assignee_user_group'
       and ELEMENT_ID = 'pick_assignee_user_group';
    IF V_CNT = 0 THEN
      BEGIN
        INSERT INTO sys_item_element_rela
          (ITEM_ID, ELEMENT_ID, SEQ_NO, PAUSE, LEVEL_NO)
        VALUES
          ('assignee_user_group',
           'pick_assignee_user_group',
           '1',
           '0',
           null);
      END;
    END IF;
  END;
END;

--子表(用户脚本)
BEGIN
  DECLARE
    V_CNT NUMBER;
  BEGIN
    SELECT COUNT(*)
      INTO V_CNT
      FROM sys_item
     where ITEM_ID = 'assignee_user_script';
    IF V_CNT = 0 THEN
      BEGIN
        INSERT INTO sys_item
          (ITEM_ID,
           ITEM_TYPE,
           CAPTION_SQL,
           DATA_SOURCE,
           BASE_TABLE,
           KEY_FIELD,
           NAME_FIELD,
           SETTING_ID,
           REPORT_TITLE,
           SUB_SCRIPTS,
           PAUSE,
           LINK_FIELD,
           HELP_ID,
           TAG_ID,
           CONFIG_PARAMS,
           TIME_OUT,
           OFFLINE_FLAG,
           PANEL_ID,
           INIT_SHOW)
        VALUES
          ('assignee_user_script',
           'list',
           '脚本',
           null,
           null,
           null,
           null,
           null,
           null,
           null,
           '0',
           null,
           null,
           null,
           null,
           null,
           null,
           null,
           null);
      END;
    END IF;
  END;
END;

BEGIN
  DECLARE
    V_CNT NUMBER;
  BEGIN
    SELECT COUNT(*)
      INTO V_CNT
      FROM sys_item_list
     where ITEM_ID = 'assignee_user_script';
    IF V_CNT = 0 THEN
      BEGIN
        INSERT INTO sys_item_list
          (ITEM_ID,
           QUERY_TYPE,
           QUERY_FIELDS,
           QUERY_COUNT,
           EDIT_EXPRESS,
           NEWID_SQL,
           SELECT_SQL,
           DETAIL_SQL,
           SUBSELECT_SQL,
           INSERT_SQL,
           UPDATE_SQL,
           DELETE_SQL,
           NOSHOW_FIELDS,
           NOADD_FIELDS,
           NOMODIFY_FIELDS,
           NOEDIT_FIELDS,
           SUBNOSHOW_FIELDS,
           UI_TMPL,
           MULTI_PAGE_FLAG,
           OUTPUT_PARAMETER,
           LOCK_SQL,
           MONITOR_ID,
           END_FIELD,
           EXECUTE_TIME,
           SHOW_CHECKBOX,
           SCANNABLE_FIELD,
           AUTO_REFRESH,
           SUB_TABLE_JUDGE_FIELD,
           BACK_GROUND_ID,
           OPERATION_TYPE,
           OPRETION_HINT,
           SUB_EDIT_STATE,
           HINT_TYPE,
           SCANNABLE_LOCATION_LINE,
           NOSHOW_APP_FIELDS,
           MAX_ROW_COUNT,
           SCANNABLE_TIME,
           RFID_FLAG,
           SCANNABLE_TYPE,
           HEADER,
           FOOTER,
           JUMP_FIELD,
           JUMP_EXPRESS)
        VALUES
          ('assignee_user_script',
           null,
           null,
           null,
           null,
           null,
           null,
           null,
           null,
           null,
           null,
           null,
           null,
           null,
           null,
           null,
           null,
           null,
           '1',
           null,
           null,
           null,
           null,
           null,
           '0',
           null,
           null,
           null,
           null,
           null,
           null,
           null,
           null,
           null,
           null,
           null,
           null,
           null,
           null,
           null,
           null,
           null,
           null);
      END;
    END IF;
  END;
END;

--pickup(用户脚本)
BEGIN
  DECLARE
    V_CNT NUMBER;
  BEGIN
    SELECT COUNT(*)
      INTO V_CNT
      FROM sys_element
     where ELEMENT_ID = 'pick_assignee_user_script';
    IF V_CNT = 0 THEN
      BEGIN
        INSERT INTO sys_element
          (ELEMENT_ID, ELEMENT_TYPE, DATA_SOURCE, PAUSE, MESSAGE, IS_HIDE)
        VALUES
          ('pick_assignee_user_script', 'pick', null, '0', null, null);
      END;
    END IF;
  END;
END;

BEGIN
  DECLARE
    V_CNT NUMBER;
  BEGIN
    SELECT COUNT(*)
      INTO V_CNT
      FROM sys_pick_list
     where ELEMENT_ID = 'pick_assignee_user_script';
    IF V_CNT = 0 THEN
      BEGIN
        DECLARE
          P_BLOB0 clob;
        BEGIN
          P_BLOB0 := 'select ''#'' || sql_name sql_name, memo
  from sys_sql_config
 where app_id = ''app_sanfu_retail''
   and pause = 0
';
          INSERT INTO sys_pick_list
            (ELEMENT_ID,
             FIELD_NAME,
             CAPTION,
             PICK_SQL,
             FROM_FIELD,
             QUERY_FIELDS,
             OTHER_FIELDS,
             TREE_FIELDS,
             LEVEL_FIELD,
             IMAGE_NAMES,
             TREE_ID,
             SEPERATOR,
             MULTI_VALUE_FLAG,
             RECURSION_FLAG,
             CUSTOM_QUERY,
             NAME_LIST_SQL)
          VALUES
            ('pick_assignee_user_script',
             'assignee',
             '用户脚本',
             P_BLOB0,
             'sql_name',
             null,
             null,
             null,
             null,
             null,
             null,
             null,
             null,
             null,
             '0',
             null);
        END;
      END;
    END IF;
  END;
END;

BEGIN
  DECLARE
    V_CNT NUMBER;
  BEGIN
    SELECT COUNT(*)
      INTO V_CNT
      FROM sys_item_element_rela
     where ITEM_ID = 'assignee_user_script'
       and ELEMENT_ID = 'pick_assignee_user_script';
    IF V_CNT = 0 THEN
      BEGIN
        INSERT INTO sys_item_element_rela
          (ITEM_ID, ELEMENT_ID, SEQ_NO, PAUSE, LEVEL_NO)
        VALUES
          ('assignee_user_script',
           'pick_assignee_user_script',
           '1',
           '0',
           null);
      END;
    END IF;
  END;
END;

--主从
BEGIN
  DECLARE
    V_CNT NUMBER;
  BEGIN
    SELECT COUNT(*)
      INTO V_CNT
      FROM sys_item_rela
     where ITEM_ID = 'flow_process_design'
       and RELATE_ID = 'assignee_user';
    IF V_CNT = 0 THEN
      BEGIN
        INSERT INTO sys_item_rela
          (ITEM_ID, RELATE_ID, RELATE_TYPE, SEQ_NO, PAUSE)
        VALUES
          ('flow_process_design', 'assignee_user', 'S', '1', '0');
      END;
    END IF;
  END;
END;

BEGIN
  DECLARE
    V_CNT NUMBER;
  BEGIN
    SELECT COUNT(*)
      INTO V_CNT
      FROM sys_item_rela
     where ITEM_ID = 'flow_process_design'
       and RELATE_ID = 'assignee_user_group';
    IF V_CNT = 0 THEN
      BEGIN
        INSERT INTO sys_item_rela
          (ITEM_ID, RELATE_ID, RELATE_TYPE, SEQ_NO, PAUSE)
        VALUES
          ('flow_process_design', 'assignee_user_group', 'S', '2', '0');
      END;
    END IF;
  END;
END;

BEGIN
  DECLARE
    V_CNT NUMBER;
  BEGIN
    SELECT COUNT(*)
      INTO V_CNT
      FROM sys_item_rela
     where ITEM_ID = 'flow_process_design'
       and RELATE_ID = 'assignee_user_script';
    IF V_CNT = 0 THEN
      BEGIN
        INSERT INTO sys_item_rela
          (ITEM_ID, RELATE_ID, RELATE_TYPE, SEQ_NO, PAUSE)
        VALUES
          ('flow_process_design', 'assignee_user_script', 'S', '3', '0');
      END;
    END IF;
  END;
END;
