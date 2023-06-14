select rowid, t.* from nsfdata.apply_form t;
select rowid, t.* from nsfdata.form_oper_log t;
select rowid, t.* from nsfdata.users t;
select rowid, t.* from nsfdata.depart t;
select rowid, t.* from nsfdata.form_type t;
select rowid, t.* from nsfdata.flowitem t;
select rowid, t.* from nsfdata.status t;
--0.表单按钮
select e.element_id, e.element_type, e.data_source, a.*
  from bwptest1.sys_element e, bwptest1.sys_flow_action a
 where e.element_id = a.element_id
   and e.element_id = '9530fd32979f4d3c93ad7ebe69c71656'
   and e.pause = 0;
--1.工作流实例
select *
  from bwptest1.wf_instance
 where business_key = 'cc_apply_id'
   and business_value = 'CCD2020-08-0500'
    or instance_id = 'CCD2020-08-0500'
   and pause = 0;
--2.工作流版本
select *
  from bwptest1.wf_process_version
 where process_version_id = 'process_version_65';
--3.工作流实例节点
select distinct a.*
  from bwptest1.wf_instance_node a, bwptest1.wf_instance_node b
 where a.instance_id = b.instance_id
   and a.instance_id = '1ada3e96b7184ef4bf9e53c06fdc590a'
   and a.parent_node_id = b.node_id
   and b.parent_node_id is null
   and a.node_type = 1
   and b.node_type = 0
 order by a.version desc;
--4.操作者
select t2.*
  from bwptest1.wf_task t1, bwptest1.wf_task_user t2
 where t1.node_code = '893b7334a22f426898f63afe55fd3563'
   and t1.task_id = t2.task_id
   and t2.task_user_type != 1
   and t2.task_operator = 'CMS3';
--5.关联任务表单
select t1.*
  from bwptest1.wf_task t1, bwptest1.wf_task_user t2
 where t1.task_id = t2.task_id
   and t1.node_code = '893b7334a22f426898f63afe55fd3563'
   and t2.task_operator = 'CMS3';
   
--6.流程管理类型
select * from bwptest1.wf_process_type;
select * from bwptest1.wf_process;

--我的待审批，已审批
with approval_tb as
 (select t.apply_form_id
    FROM nsfdata.APPLY_FORM T
    LEFT JOIN nsfdata.FORM_TYPE
      ON T.FORM_TYPE_ID = FORM_TYPE.FORM_TYPE_ID
    LEFT JOIN (SELECT A.BUSINESS_VALUE, B.OPER_USER
                FROM bwptest1.WF_INSTANCE A
                JOIN bwptest1.WF_INSTANCE_OPER B
                  ON A.INSTANCE_ID = B.INSTANCE_ID
               GROUP BY A.BUSINESS_VALUE, B.OPER_USER) T2
      ON T.APPLY_FORM_ID = T2.BUSINESS_VALUE
   WHERE UPPER(T2.OPER_USER) = 'CMS3'),
apply_tb as
 (select t.cc_apply_id,
         t2.apply_form_id,
         t.userid,
         t3.username,
         t.dep_id,
         t4.dep_name,
         t.form_type_id,
         t.cc_dep,
         t.cc_person,
         t.cc_item,
         T.CC_PLACE,
         t.start_time,
         t.end_time,
         t.report_date,
         T2.FLOW_ID,
         T2.FLOW_NODE_ID,
         T7.FLOW_NODE_NAME,
         T2.STATUS_ID,
         T6.STATUS_NAME,
         t.memo
    FROM nsfdata.cc_apply_FORM t
    LEFT JOIN nsfdata.APPLY_FORM T2
      ON t.CC_APPLY_ID = T2.APPLY_FORM_ID
    LEFT JOIN nsfdata.USERS T3
      ON t.USERID = T3.USERID
    LEFT JOIN nsfdata.Depart T4
      ON t.DEP_ID = T4.DEP_ID
    LEFT JOIN nsfdata.FORM_TYPE T5
      ON t.FORM_TYPE_ID = T5.FORM_TYPE_ID
    LEFT JOIN nsfdata.STATUS T6
      ON T2.STATUS_ID = T6.STATUS_ID
    LEFT JOIN nsfdata.FLOWITEM T7
      ON T2.FLOW_NODE_ID = T7.FLOW_NODE_ID
   WHERE T.USERID = 'CMS3'
   ORDER BY t2.apply_form_id DESC)
select apply_tb.*
  from approval_tb, apply_tb
 where approval_tb.apply_form_id = apply_tb.cc_apply_id;

--带决策的审批流
--提交
declare
  v_start        varchar2(32) := 'start';
  v_apply        varchar2(32) := 'cc_apply';
  v_approveDept1 varchar2(32) := 'dept_approval';
  v_approveDept2 varchar2(32) := 'zg_approval';
  v_end          varchar2(32) := 'end';
  v_apply_id     varchar2(1000) := :cc_apply_id;
  v_current_node varchar2(32) := :current_node;
  v_next_node    varchar2(32) := :next_node;
  v_userid       varchar2(32) := :userid;
  v_flow_node_id varchar2(32);
  v_status_id    varchar2(32) := '01'; --:status_id;
  p_userid       varchar2(20) := %currentuserid%;
  v_num          number;
begin
  --主管审批
  if v_current_node = v_apply and v_next_node = v_approveDept1 then
    update apply_form
       set flow_node_id = 'A031002', status_id = '01'
     where apply_form_id = v_apply_id;
    v_flow_node_id := 'A031002';
  end if;
  --分支
  --部门经理审批
  if v_current_node = v_apply and v_next_node = v_approveDept2 then
    update apply_form  
       set flow_node_id = 'A031007', status_id = '01'
     where apply_form_id = v_apply_id;
    v_flow_node_id := 'A031007';
  end if;

  select nvl(max(log_id) + 1, 1) into v_num from nsfdata.form_oper_log;
  insert into nsfdata.form_oper_log
    (log_id,
     apply_form_id,
     form_type_id,
     userid,
     flow_node_id,
     status_id,
     operation_desc,
     handing_personnel,
     update_time)
  values
    (v_num,
     v_apply_id,
     'CC',
     v_userid,
     v_flow_node_id,
     v_status_id,
     '提交成功',
     p_userid,
     sysdate);
end;
--同意
declare
  v_start        varchar2(32) := 'start';
  v_apply        varchar2(32) := 'cc_apply';
  v_approveDept1 varchar2(32) := 'dept_approval';
  v_approveDept2 varchar2(32) := 'zg_approval';
  v_end          varchar2(32) := 'end';
  v_apply_id     varchar2(1000) := :cc_apply_id;
  v_current_node varchar2(32) := :current_node;
  v_next_node    varchar2(32) := :next_node;
  v_userid       varchar2(32) := :userid;
  v_flow_node_id varchar2(32);
  v_status_id    varchar2(32) := '06'; --:status_id;
  p_userid       varchar2(20) := %currentuserid%;
  v_num          number;
begin
  --主管审批
  if v_current_node = v_approveDept2 and v_next_node = v_approveDept1 then
    update apply_form t
       set t.flow_node_id = 'A031007', t.status_id = v_status_id
     where t.apply_form_id = v_apply_id;
    v_flow_node_id := 'A031007';
  end if;

  if v_current_node = v_approveDept1 and v_next_node = v_end then
    update apply_form
       set flow_node_id = 'A031002', status_id = v_status_id
     where apply_form_id = v_apply_id;
    v_flow_node_id := 'A031002';
  end if;

  select nvl(max(log_id) + 1, 1) into v_num from nsfdata.form_oper_log;
  insert into nsfdata.form_oper_log
    (log_id,
     apply_form_id,
     form_type_id,
     userid,
     flow_node_id,
     status_id,
     operation_desc,
     handing_personnel,
     update_time)
  values
    (v_num,
     v_apply_id,
     'CC',
     v_userid,
     nvl(v_flow_node_id, 'A031001'),
     v_status_id,
     '审批通过',
     p_userid,
     sysdate);
end;


--撤回审批
declare
  v_start        varchar2(32) := 'start';
  v_apply        varchar2(32) := 'cc_apply';
  v_approveDept1 varchar2(32) := 'dept_approval';
  v_approveDept2 varchar2(32) := 'zg_approval';
  v_end          varchar2(32) := 'end';
  v_apply_id     varchar2(1000) := :cc_apply_id;
  v_current_node varchar2(32) := :current_node;
  v_next_node    varchar2(32) := :next_node;
  v_userid       varchar2(32) := :userid;
  v_flow_node_id varchar2(32);
  v_status_id    varchar2(32) := '00'; --:status_id;
  p_userid       varchar2(20) := %currentuserid%;
  v_num          number;
begin
  
  if v_current_node = v_apply and v_next_node = v_start then
    update apply_form t
       set t.flow_node_id = 'A031001', t.status_id = v_status_id
     where t.apply_form_id = v_apply_id;
    v_flow_node_id := 'A031001';
  end if;


  select nvl(max(log_id) + 1, 1) into v_num from nsfdata.form_oper_log;
  insert into nsfdata.form_oper_log
    (log_id,
     apply_form_id,
     form_type_id,
     userid,
     flow_node_id,
     status_id,
     operation_desc,
     handing_personnel,
     update_time)
  values
    (v_num,
     v_apply_id,
     'CC',
     v_userid,
     nvl(v_flow_node_id, 'A031001'),
     v_status_id,
     '撤销审批',
     p_userid,
     sysdate);
end;

--退回

declare
  v_start        varchar2(32) := 'start';
  v_apply        varchar2(32) := 'cc_apply';
  v_approveDept1 varchar2(32) := 'dept_approval';
  v_approveDept2 varchar2(32) := 'zg_approval';
  v_end          varchar2(32) := 'end';
  v_apply_id     varchar2(1000) := :cc_apply_id;
  v_current_node varchar2(32) := :current_node;
  v_next_node    varchar2(32) := :next_node;
  v_userid       varchar2(32) := :userid;
  v_flow_node_id varchar2(32);
  v_status_id    varchar2(32) := '07'; --:status_id;
  p_userid       varchar2(20) := %currentuserid%;
  v_num          number;
  v_refuse_reason varchar2(1000) := @REFUSE_REASON@;
begin

  if v_current_node = v_approveDept2 and v_next_node = v_start then
    update apply_form
       set flow_node_id = 'A031007', status_id = v_status_id
     where apply_form_id = v_apply_id;
    v_flow_node_id := 'A031007';
  end if;

  if v_current_node = v_approveDept1 and v_next_node = v_start then
    update apply_form
       set flow_node_id = 'A031002', status_id = v_status_id
     where apply_form_id = v_apply_id;
    v_flow_node_id := 'A031002';
  end if;

  select nvl(max(log_id) + 1, 1) into v_num from nsfdata.form_oper_log;
  insert into nsfdata.form_oper_log
    (log_id,
     apply_form_id,
     form_type_id,
     userid,
     flow_node_id,
     status_id,
     operation_desc,
     handing_personnel,
     refuse_reason,
     update_time)
  values
    (v_num,
     v_apply_id,
     'CC',
     v_userid,
     v_flow_node_id,
     v_status_id,
     '审批拒绝',
     p_userid,
     v_refuse_reason,
     sysdate);
end;

--审批记录
select fo.apply_form_id,
       (select ft.form_type_name
          from nsfdata.form_type ft
         where ft.form_type_id = fo.form_type_id) form_type_name,
       (select u.username from users u where u.userid = fo.userid) username,
       fl.flow_node_id,
       fl.flow_node_name,
       (select st.status_name
          from nsfdata.status st
         where st.status_id = fo.status_id) status_name,
       fo.refuse_reason,
       (select u.username from users u where u.userid = fo.handing_personnel) handing_personnel
  from nsfdata.form_oper_log fo, nsfdata.flowitem fl
 where fl.flow_node_id = fo.flow_node_id
--and fo.apply_form_id = 'CCD_AC2D48937C8501E5E053B5281CAC6E96';
