CREATE OR REPLACE PACKAGE SCMDATA.pkg_send_wx_msg IS

  PROCEDURE p_send_wx_msg(p_company_id VARCHAR2,
                          p_robot_type VARCHAR2,
                          p_msgtype    VARCHAR2 DEFAULT 'text',
                          p_val_step   VARCHAR2 DEFAULT ';',
                          p_msg_title  VARCHAR2,
                          p_sender     CLOB);

  --新增消息至消息池  czh add
  PROCEDURE p_send_com_wx_msg(p_wx_rec scmdata.sys_company_wecom_msg%ROWTYPE);
  function f_1(vc_user_id varchar2, vc_id varchar) return clob;

  procedure p_send_com_person_wx_msg(p_company_id varchar2,
                                     p_user_id    varchar2,
                                     p_content    varchar2,
                                     p_sender     varchar2 default 'ADMIN');

  /*
    缓存模板消息参数
    p_company_id：企业id
    p_param：参数
    p_target_user_id：发送对象用户id，单个id
    p_target_robot_code：发送对象机器人id，单个id
    p_pattern_code：消息模板编号
  */
  procedure p_cache_wecom_msg_pattern(p_company_id        varchar2,
                                      p_param             varchar2,
                                      p_target_user_id    varchar2,
                                      p_target_robot_code varchar2 default null,
                                      p_pattern_code      varchar2);

  procedure p_send_wecom_msg_pattern(p_time date);

  procedure p_hint_wecom_msg_pattern(p_time date);

  procedure p_platform_person_wx_msg_push(v_company_id   varchar2, /*公司id*/
                                          v_supplier     varchar2, /*公司全称*/
                                          v_pattern_code varchar2, /*模板编码*/
                                          v_user_id      varchar2, /*发送用户id*/
                                          v_type         number /*v_type:0不获取个人消息推送模板 人员,v_type:1 获取个人消息推送模板人员*/);

END pkg_send_wx_msg;
/
CREATE OR REPLACE PACKAGE BODY SCMDATA.pkg_send_wx_msg IS

  PROCEDURE p_send_wx_msg(p_company_id VARCHAR2,
                          p_robot_type VARCHAR2,
                          p_msgtype    VARCHAR2 DEFAULT 'text',
                          p_val_step   VARCHAR2 DEFAULT ';',
                          p_msg_title  VARCHAR2,
                          p_sender     CLOB) IS
    errormsg         CLOB;
    v_msg            VARCHAR2(1000);
    s_content        CLOB;
    s_create_time    DATE;
    s_sum            NUMBER;
    v_sender         CLOB;
    v_default_sender CLOB;
  BEGIN
    --获取默认接收人
    SELECT MAX(t.default_target_in_id)
      INTO v_default_sender
      FROM scmdata.sys_company_wecom_config t
     WHERE company_id = p_company_id
       AND robot_type = p_robot_type
       AND NOT EXISTS
     (SELECT 1
              FROM dual
             WHERE instr(p_sender, t.default_target_in_id) > 0);

    IF v_default_sender IS NULL THEN
      v_sender := nvl(p_sender, '');
    ELSE
      v_sender := v_default_sender || CASE
                    WHEN p_sender IS NOT NULL THEN
                     ';' || p_sender
                    ELSE
                     ''
                  END;
    END IF;
    IF p_msgtype = 'markdown' THEN
      v_sender := scmdata.f_user_list_from_in_to_wecom(pi_user_list => v_sender,
                                                       value_step   => p_val_step);
    ELSE
      v_sender := p_sender;
    END IF;
    --发送消息内容
    errormsg := substr(SQLERRM, 1, 200);
    v_msg    := p_msg_title || chr(13) || '出错信息：' || chr(13) || errormsg;

    SELECT COUNT(*)
      INTO s_sum
      FROM scmdata.sys_company_wecom_msg s
     WHERE s.robot_type = p_robot_type
       AND s.company_id = p_company_id
       AND s.content = v_msg;
    IF s_sum > 0 THEN
      SELECT s.create_time
        INTO s_create_time
        FROM scmdata.sys_company_wecom_msg s
       WHERE s.robot_type = p_robot_type
         AND s.company_id = p_company_id
         AND s.content = v_msg;

      IF s_create_time < SYSDATE - 1 THEN
        DELETE scmdata.sys_company_wecom_msg s
         WHERE s.robot_type = p_robot_type
           AND s.company_id = p_company_id
           AND s.content = v_msg;
      END IF;
      COMMIT;
    END IF;
    SELECT COUNT(*)
      INTO s_sum
      FROM scmdata.sys_company_wecom_msg s
     WHERE s.robot_type = p_robot_type
       AND s.company_id = p_company_id;

    IF s_sum > 0 THEN

      SELECT content
        INTO s_content
        FROM (SELECT *
                FROM scmdata.sys_company_wecom_msg s
               WHERE s.robot_type = p_robot_type
                 AND s.company_id = p_company_id
               ORDER BY create_time DESC)
       WHERE rownum = 1;
      IF v_msg <> s_content THEN
        INSERT INTO scmdata.sys_company_wecom_msg
          (company_wecom_msg_id,
           robot_type,
           company_id,
           status,
           create_time,
           create_id,
           msgtype,
           content,
           mentioned_list,
           mentioned_mobile_list)
        VALUES
          (scmdata.f_get_uuid(),
           p_robot_type,
           p_company_id,
           2,
           SYSDATE,
           'ADMIN',
           p_msgtype,
           v_msg,
           v_sender,
           NULL);
      END IF;
    ELSE
      INSERT INTO scmdata.sys_company_wecom_msg
        (company_wecom_msg_id,
         robot_type,
         company_id,
         status,
         create_time,
         create_id,
         msgtype,
         content,
         mentioned_list,
         mentioned_mobile_list)
      VALUES
        (scmdata.f_get_uuid(),
         p_robot_type,
         p_company_id,
         2,
         SYSDATE,
         'ADMIN',
         p_msgtype,
         v_msg,
         v_sender,
         NULL);
    END IF;
  END p_send_wx_msg;
  --新增消息至消息池  czh add
  PROCEDURE p_send_com_wx_msg(p_wx_rec scmdata.sys_company_wecom_msg%ROWTYPE) IS
  BEGIN
    INSERT INTO sys_company_wecom_msg
      (company_wecom_msg_id,
       robot_type,
       company_id,
       status,
       create_time,
       create_id,
       msgtype,
       content,
       mentioned_list,
       mentioned_mobile_list)
    VALUES
      (p_wx_rec.company_wecom_msg_id,
       p_wx_rec.robot_type,
       p_wx_rec.company_id,
       p_wx_rec.status,
       p_wx_rec.create_time,
       p_wx_rec.create_id,
       p_wx_rec.msgtype,
       p_wx_rec.content,
       p_wx_rec.mentioned_list,
       p_wx_rec.mentioned_mobile_list);

  END p_send_com_wx_msg;

  function f_1(vc_user_id varchar2, vc_id varchar) return clob is
    v_num  number;
    v_num2 number;
    vc_sql clob;
  begin
    select pkg_plat_comm.f_hasaction_application(vc_user_id,
                                                 vc_id,
                                                 'P01001')
      into v_num
      from dual;
    select pkg_plat_comm.f_hasaction_application(vc_user_id,
                                                 vc_id,
                                                 'P01001')
      into v_num2
      from dual;
    if v_num = 1 and v_num2 = 0 then
      vc_sql := q'[declare
begin
  update scmdata.t_target_value_config
     set target_value = :target_value,
         update_id    = :vc_user_id,
         update_time  = sysdate
   where target_id = :target_id
     and company_id = ]' || '''' || vc_id || '''' || '
end';
    elsif v_num = 0 and v_num2 = 1 then
      vc_sql := q'[ update scmdata.t_target_value_config
     set
         target_name  = :target_name,
         target_value = :target_value,
         update_id    = ]' || '''' || vc_user_id || '''' || q'[,
         update_time  = sysdate
   where target_id =  :target_id
     and company_id = ]' || '''' || vc_id || '''';
    end if;

    return vc_sql;
  end f_1;

  procedure p_send_com_person_wx_msg(p_company_id varchar2,
                                     p_user_id    varchar2,
                                     p_content    varchar2,
                                     p_sender     varchar2 default 'ADMIN') is
    v_target_user_inside_code varchar2(32);
  begin

    select max(cu.inner_user_id)
      into v_target_user_inside_code
      from scmdata.sys_company_user cu
     where cu.company_id = p_company_id
       and cu.user_id = p_user_id;
    if v_target_user_inside_code is null and p_user_id not in ('ZWH73') then
      return;
    end if;
    insert into scmdata.sys_company_wecom_person_msg
      (company_wecom_person_msg_id,
       company_id,
       status,
       create_time,
       create_id,
       interface_type,
       content,
       target_user_id,
       target_user_inside_code)
    values
      (scmdata.f_get_uuid(),
       p_company_id,
       2,
       sysdate,
       p_sender,
       'SANFU_BPM',
       p_content,
       p_user_id,
       nvl(v_target_user_inside_code,p_user_id));
    /*insert into scmdata.sys_company_wecom_msg
      (company_wecom_msg_id,
       robot_type,
       company_id,
       status,
       create_time,
       create_id,
       msgtype,
       content,
       mentioned_list,
       mentioned_mobile_list)
    values
      (scmdata.f_get_uuid(),
       'ANALOG_PERSON_MSG',
       p_company_id,
       2,
       sysdate,
       'ADMIN',
       'text',
       '内容：' || p_content || '
发送对象：' || v_target_user_inside_code,
       null,
       null);*/

  end p_send_com_person_wx_msg;

  procedure p_cache_wecom_msg_pattern(p_company_id        varchar2,
                                      p_param             varchar2,
                                      p_target_user_id    varchar2,
                                      p_target_robot_code varchar2 default null,
                                      p_pattern_code      varchar2) is
  begin
    insert into scmdata.sys_group_wecom_msg_cache
      (sys_group_wecom_msg_cache_id,
       company_id,
       status,
       create_time,
       create_id,
       param,
       target_user_id,
       target_user_inside_code,
       target_robot_code,
       wecom_msg_pattern_code)
    values
      (scmdata.f_get_uuid(),
       p_company_id,
       2,
       sysdate,
       'ADMIN',
       p_param,
       p_target_user_id,
       null,
       p_target_robot_code,
       p_pattern_code);

  end p_cache_wecom_msg_pattern;

  procedure p_send_wecom_msg_pattern(p_time date) is
    p_content     varchar2(1000);
    p_param_count int;
    p_user_targe  varchar2(32);
  begin
    for x in (select *
                from scmdata.sys_group_wecom_msg_pattern a
               where a.pause = 0) loop
      p_param_count := regexp_count(x.param_name_list, ';') + 1;
      if p_param_count > 1 then
        --暂不开发
        continue;
      end if;
      --发送个人缓存消息
      for w in (select b.target_user_id,
                       b.company_id,
                       listagg(distinct b.param, ';') param,
                       count(distinct b.param) param_sum
                  from scmdata.sys_group_wecom_msg_cache b
                 where b.status <> -1
                   and b.target_user_id is not null
                   and b.target_robot_code is null
                   and b.wecom_msg_pattern_code =
                       x.sys_group_wecom_msg_pattern_code
                 group by b.target_user_id, b.company_id) loop
        p_content := null;
        /*to_do
        补充量词和描述词
        */
        if x.quantifier is not null then
          p_content := p_content || w.param_sum || x.quantifier;
          if x.descriptors is not null then
            p_content := p_content || x.descriptors;
          end if;

          if x.complex_limit is not null and w.param_sum > x.complex_limit then
            p_content := regexp_substr(w.param, '[^;]+;[^;]+;[^;]+') || '等' ||
                         p_content;
          else
            p_content := w.param || p_content;
          end if;
        end if;

        p_send_com_person_wx_msg(p_company_id => w.company_id,
                                 p_user_id    => w.target_user_id,
                                 p_content    => replace(x.msg_pattern,
                                                         '{{' ||
                                                         x.param_name_list || '}}',
                                                         p_content));

      end loop;
      --to发送机器人缓存消息
      for w in (select b.target_user_id,
                       b.target_robot_code,
                       b.company_id,
                       listagg(distinct b.param, ';') param,
                       count(distinct b.param) param_sum
                  from scmdata.sys_group_wecom_msg_cache b
                 where b.status <> -1
                   and b.target_robot_code is not null
                   and b.wecom_msg_pattern_code =
                       x.sys_group_wecom_msg_pattern_code
                 group by b.target_robot_code,
                          b.target_user_id,
                          b.company_id) loop
        /*to_do
        补充量词和描述词
        */
        p_content := null;
        if x.quantifier is not null then
          p_content := p_content || w.param_sum || x.quantifier;
          if x.descriptors is not null then
            p_content := p_content || x.descriptors;
          end if;

          if x.complex_limit is not null and w.param_sum > x.complex_limit then
            p_content := regexp_substr(w.param, '[^;]+;[^;]+;[^;]+') || '等' ||
                         p_content;
          else
            p_content := w.param || p_content;
          end if;
        end if;

        select scmdata.F_USER_LIST_FROM_IN_TO_WECOM(a.inner_user_id, ';')
          into p_user_targe
          from scmdata.sys_company_user a
         where a.user_id = w.target_user_id
           and a.company_id = w.company_id;
        insert into scmdata.sys_company_wecom_msg
          (company_wecom_msg_id,
           robot_type,
           company_id,
           status,
           create_time,
           create_id,
           msgtype,
           content,
           mentioned_list,
           mentioned_mobile_list)
        values
          (scmdata.f_get_uuid(),
           w.target_robot_code,
           w.company_id,
           2,
           sysdate,
           'ADMIN',
           'TEXT',
           replace(x.msg_pattern,
                   '{{' || x.param_name_list || '}}',
                   p_content) || p_user_targe,
           --todo 转化用户账号
           null,
           null);
      end loop;
    end loop;

    update scmdata.sys_group_wecom_msg_cache b
       set b.status = -1
     where b.status = 2;
  end p_send_wecom_msg_pattern;

  procedure p_hint_wecom_msg_pattern(p_time date) is
    p_content varchar2(1000);
    TYPE ref_cursor_type IS REF CURSOR;
    rc ref_cursor_type;
    --type param_list is table of varchar2(100);
    --pl            param_list := param_list();
    p_user_id     varchar2(32);
    p_company_id  varchar2(32);
    p_param       varchar2(100);
    p_robot_code  varchar2(32);
    v_sql         varchar(1000);
    p_param_count int;
  begin
    --走个人消息
    for x in (select *
                from scmdata.sys_group_wecom_msg_pattern a
               where a.pause = 0
                 and a.hint_sql is not null) loop
      p_param_count := regexp_count(x.param_name_list, ';') + 1;
      if p_param_count > 1 then
        --暂不开发
        continue;
      end if;
      v_sql := 'select user_id,robot_id,company_id,param from (' ||
               x.hint_sql || ')';
      open rc for v_sql;
      loop
        fetch rc
          into p_user_id, p_robot_code, p_company_id, p_param;
        exit when rc%notfound;
        p_cache_wecom_msg_pattern(p_company_id        => p_company_id,
                                  p_param             => p_param,
                                  p_target_user_id    => p_user_id,
                                  p_target_robot_code => p_robot_code,
                                  p_pattern_code      => x.sys_group_wecom_msg_pattern_code);
      end loop;
      close rc;
      /*SELECT REGEXP_SUBSTR(x.param_name_list, '[^;]+', 1, LEVEL, 'i') y
        Bulk Collect
        into pl
        FROM dual
      CONNECT BY LEVEL <=
                 LENGTH(REGEXP_REPLACE(x.param_name_list, ';', '')) + 1;
      select listagg(distinct y, ',') within group(order by yd)
        into pl_v
        from (SELECT REGEXP_SUBSTR(x.param_name_list, '[^;]+', 1, LEVEL, 'i') ||
                     ' as col_' || LEVEL + 2 y,
                     LEVEL + 2 yd
                FROM dual
              CONNECT BY LEVEL <=
                         LENGTH(x.param_name_list) -
                         LENGTH(REGEXP_REPLACE(x.param_name_list, ';', '')) + 1
                 LENGTH(x.param_name_list) -);
      v_sql := 'select user_ids col_1,robot_id col_2,' || pl_v || ' from (' ||
               x.hint_sql || ')';
      open rc for v_sql;
      loop
      fetch rc
        into val_list;
      exit when rc%notfound;*/
    --拼接字符串串
    end loop;
  end p_hint_wecom_msg_pattern;

/*对象：平台个人企微消息推送
  lsl 20230308 add*/
  procedure p_platform_person_wx_msg_push(v_company_id   varchar2, /*公司id*/
                                          v_supplier     varchar2, /*公司全称*/
                                          v_pattern_code varchar2, /*模板编码*/
                                          v_user_id      varchar2, /* 发送用户user_id——多个用户用;隔开 */
                                          v_type         number /*v_type:0不获取个人消息推送模板 人员,v_type:1 获取个人消息推送模板人员*/) is
    p_user_id varchar2(320);
    vt_user_id varchar2(32);
  begin
    ---v_type:0 不获取个人消息推送模板配置表
    if v_type = 0 then
      ---发送v_user_id用户id
      for i in (select regexp_substr(v_user_id, '[^;]+', 1, level, 'i') user_id
                  from dual
                connect by level <= length(v_user_id) - length(regexp_replace(v_user_id, ';', '')) + 1) loop
        scmdata.pkg_send_wx_msg.p_cache_wecom_msg_pattern(p_company_id     => v_company_id,
                                                          p_param          => v_supplier,
                                                          p_target_user_id => i.user_id,
                                                          p_pattern_code   => v_pattern_code);
      end loop;
    
      ---v_type:1 获取个人消息推送模板配置表
    elsif v_type = 1 then
    
      select t.target_user_id
        into p_user_id
        from scmdata.sys_group_wecom_msg_pattern a
       inner join scmdata.sys_company_person_wecom_msg t
          on a.sys_group_wecom_msg_pattern_id = t.sys_group_wecom_msg_pattern_id
         and a.sys_group_wecom_msg_pattern_code = v_pattern_code
       inner join scmdata.sys_group_apply sg
          on sg.apply_id = a.apply_id
         and sg.apply_status = '0'
         and sg.system_id = 'SCM'
       where t.pause = 0
         and exists (select 1 from scmdata.sys_company_apply_buylog where apply_id = a.apply_id and t.company_id = t.company_id)
         and t.company_id = v_company_id;
    
      ---判断传参进来的v_user_id用户id是否为空
      if v_user_id is null then
        --发送个人推送消息模板对应人员  
        for i in (select regexp_substr(p_user_id, '[^;]+', 1, level, 'i') user_id
                    from dual
                  connect by level <= length(p_user_id) - length(regexp_replace(p_user_id, ';', '')) + 1) loop

         select max(cu.user_id)
           into vt_user_id
           from scmdata.sys_company_user cu
          where cu.company_id = v_company_id
           and cu.inner_user_id = i.user_id;

          scmdata.pkg_send_wx_msg.p_cache_wecom_msg_pattern(p_company_id     => v_company_id,
                                                            p_param          => v_supplier,
                                                            p_target_user_id => vt_user_id,
                                                            p_pattern_code   => v_pattern_code);
        end loop;
      else
        ---发送v_user_id用户id
        for i in (select regexp_substr(v_user_id, '[^;]+', 1, level, 'i') user_id
                    from dual
                  connect by level <= length(v_user_id) - length(regexp_replace(v_user_id, ';', '')) + 1) loop
        
          scmdata.pkg_send_wx_msg.p_cache_wecom_msg_pattern(p_company_id     => v_company_id,
                                                            p_param          => v_supplier,
                                                            p_target_user_id => i.user_id,
                                                            p_pattern_code   => v_pattern_code);
        end loop;
        --发送个人推送消息模板对应人员  
        for i in (select regexp_substr(p_user_id, '[^;]+', 1, level, 'i') user_id
                    from dual
                  connect by level <= length(p_user_id) - length(regexp_replace(p_user_id, ';', '')) + 1) loop
         select max(cu.user_id)
           into vt_user_id
           from scmdata.sys_company_user cu
          where cu.company_id = v_company_id
           and cu.inner_user_id = i.user_id;
          scmdata.pkg_send_wx_msg.p_cache_wecom_msg_pattern(p_company_id     => v_company_id,
                                                            p_param          => v_supplier,
                                                            p_target_user_id => vt_user_id,
                                                            p_pattern_code   => v_pattern_code);
        end loop;
      end if;
    end if;
  end p_platform_person_wx_msg_push;

END pkg_send_wx_msg;
/
