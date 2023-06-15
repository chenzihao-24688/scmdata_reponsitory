create or replace package scmdata.pkg_flow_manage is

  -- Author  : zwh73
  -- Created : 2020/8/31 9:06:46
  -- Purpose : 流程控制

  PROCEDURE P_form_status_log(pi_from_tablename       in varchar2,
                              pi_log_tablename        in varchar2,
                              pi_from_id              in varchar2,
                              pi_status_af_oper       in varchar2,
                              pi_oper_user_id         in varchar2,
                              pi_oper_user_company_id in varchar2,
                              pi_oper_code            in varchar2,
                              pi_remarks              in varchar2);

  /*============================================*
  * Author   : SANFU
  * Created  : 2020-09-01 10:22:46
  * ALERTER  : 
  * ALERTER_TIME  : 
  * Purpose  : 
  * Obj_Name    : P_FORM_MANGE
  * Arg_Number  : 11
  * PI_FORM_ID : 表单id
  * PI_CURRENT_NODE :当前流程节点，请直接填:current_node
  * PI_NEXT_NODE :算出的下一个流程节点，请直接填:next_node
  * PI_OPER :操作submit提交\aggre同意\disagree不同意\back驳回\cancel撤回\nullify作废
  * PI_STATUS_DESC :状态desc，可根据需求填写，如果不填则根据操作字典填写
  * PI_PROCESS_ID :流程id
  * PI_OPERATOR_ACCOUNT : 操作者账号，请填:user_account
  * PI_REMARKS :备注
  * PI_AUDIT_COMMENT :审核意见
  * PO_MSG :错误信息
  * PO_RESULT :过程操作结果
  *============================================*/

  PROCEDURE P_form_mange(pi_form_id          in varchar2,
                         pi_current_node     in varchar2,
                         pi_next_node        in varchar2,
                         pi_oper             in varchar2,
                         pi_status_desc      in varchar2,
                         pi_process_id       in varchar2,
                         pi_operator_account in varchar2,
                         pi_remarks          in varchar2,
                         pi_audit_comment    in varchar2,
                         po_msg              out varchar2,
                         po_result           out number);

end pkg_flow_manage;
/

create or replace package body scmdata.pkg_flow_manage is

  --log表的名称
  --原表单的名称
  --操作后表单状态
  --表单id
  --操作者id
  --操作者公司id
  --备注
  --操作
  PROCEDURE P_form_status_log(pi_from_tablename       in varchar2,
                              pi_log_tablename        in varchar2,
                              pi_from_id              in varchar2,
                              pi_status_af_oper       in varchar2,
                              pi_oper_user_id         in varchar2,
                              pi_oper_user_company_id in varchar2,
                              pi_oper_code            in varchar2,
                              pi_remarks              in varchar2) is
    p_sql            varchar2(500);
    p_value_sql      varchar2(500);
    p_temp_data_id   varchar2(32);
    p_from_key_name  varchar2(32);
    p_log_tablename  varchar2(50);
    p_from_tablename varchar2(50);
  begin
    p_log_tablename  := upper(pi_log_tablename);
    p_from_tablename := upper(pi_from_tablename);
    --获取主键
    select a.column_name
      into p_from_key_name
      from user_cons_columns a, user_constraints b
     where a.constraint_name = b.constraint_name
       and b.CONSTRAINT_TYPE = 'P'
       and a.table_name = p_from_tablename;
    --记录
    p_sql       := 'insert into ' || p_log_tablename ||
                   '(log_id,status_af_oper,oper_user_id,oper_user_company_id,oper_code,remarks,oper_time,' ||
                   p_from_key_name;
    p_value_sql := 'values(''' || f_get_uuid() || ''',''' ||
                   pi_status_af_oper || ''',''' || pi_oper_user_id ||
                   ''',''' || pi_oper_user_company_id || ''',''' ||
                   upper(pi_oper_code) || ''',''' || pi_remarks ||
                   ''',sysdate,''' || pi_from_id||'''';
    for p_l_x in (select a.column_name
                    from user_cons_columns a, user_constraints b
                   where a.constraint_name = b.constraint_name
                     and b.CONSTRAINT_TYPE = 'R'
                     and a.table_name = p_from_tablename
                  InterSect
                  select c.column_name
                    from user_tab_columns c
                   where c.table_name = p_log_tablename) loop
      p_sql := p_sql || ',' || p_l_x.column_name;
      EXECUTE IMMEDIATE 'select ' || p_l_x.column_name || ' from ' ||
                        p_from_tablename || ' where ' || p_from_key_name ||
                        '=:1'
        into p_temp_data_id
        using pi_from_id;
      p_value_sql := p_value_sql || ',''' || p_temp_data_id || '''';
    end loop;
    p_sql       := p_sql || ') ';
    p_value_sql := p_value_sql || ')';
    --dbms_output.put_line(p_sql || p_value_sql);
    EXECUTE IMMEDIATE p_sql || p_value_sql;
  end;

  --submit\aggre\back\cancel\nullify
  PROCEDURE P_form_mange(pi_form_id          in varchar2,
                         pi_current_node     in varchar2,
                         pi_next_node        in varchar2,
                         pi_oper             in varchar2,
                         pi_status_desc      in varchar2,
                         pi_process_id       in varchar2,
                         pi_operator_account in varchar2,
                         pi_remarks          in varchar2,
                         pi_audit_comment    in varchar2,
                         po_msg              out varchar2,
                         po_result           out number) is
    p_status_desc varchar2(48);
    p_oper        varchar(48) := upper(pi_oper);
  begin
    po_result := 0;
    if pi_status_desc is not null then
      p_status_desc := pi_status_desc;
    else
      --字典名暂定 DICT_FLOW_STATUS
      select group_dict_name
        into p_status_desc
        from sys_group_dict
       where group_dict_value = p_oper
         and group_dict_value = 'DICT_FLOW_STATUS';
    end if;
    --插入或更新t_apply_form
    if p_oper = 'SUBMIT' then
      insert into t_apply_form
        (apply_form_id,
         FLOW_STATUS,
         status_desc,
         create_user_id,
         flow_node_code,
         process_id,
         start_time,
         remarks,
         last_audit_comment)
      values
        (pi_form_id,
         p_oper,
         p_status_desc,
         pi_operator_account,
         pi_next_node,
         pi_process_id,
         sysdate,
         pi_remarks,
         pi_audit_comment);
      if sql%rowcount <> 1 then
        po_result := -1;
        po_msg    := '新增申请单信息出错，请联系管理员！';
        return;
      end if;
    else
      update t_apply_form
         set FLOW_STATUS    = p_oper,
             status_desc    = p_status_desc,
             flow_node_code = pi_current_node
       where apply_form_id = pi_form_id;
      if sql%rowcount <> 1 then
        po_result := -2;
        po_msg    := '更新申请单信息出错，请联系管理员！';
        return;
      end if;
    end if;
    if pi_next_node = 'end' then
      update t_apply_form
         set end_time = sysdate
       where apply_form_id = pi_form_id;
      if sql%rowcount <> 1 then
        po_result := -2;
        po_msg    := '更新申请单信息出错，请联系管理员！';
        return;
      end if;
    end if;
  
    if pi_audit_comment is not null then
      update t_apply_form
         set last_audit_comment = pi_audit_comment
       where apply_form_id = pi_form_id;
      if sql%rowcount <> 1 then
        po_result := -2;
        po_msg    := '更新申请单信息出错，请联系管理员！';
        return;
      end if;
    end if;
  
    --插入oper记录
    insert into t_apply_form_oper_log
      (log_id,
       apply_form_id,
       oper_user_id,
       process_id,
       oper_node_code,
       operation_code,
       handle_time)
    values
      (f_get_uuid(),
       pi_form_id,
       pi_operator_account,
       pi_process_id,
       pi_current_node,
       p_oper,
       sysdate);
    if sql%rowcount <> 1 then
      po_result := -3;
      po_msg    := '新增操作记录出错，请联系管理员！';
      return;
    end if;
  end;

end pkg_flow_manage;
/

