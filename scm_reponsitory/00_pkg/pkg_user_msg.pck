create or replace package scmdata.PKG_USER_MSG is

  -- Author  : SANFU
  -- Created : 2020/7/30 16:47:48
  -- Purpose : 发送消息（暂用）

  FUNCTION f_get_msg_text_msg(pi_msg_content varchar2,
                              pi_msg_type    varchar2,
                              pi_object_id     varchar2) return varchar2;

  /*============================================*
  * Author   : zwh73
  * Created  : 2020-08-14 14:01:53
  * Purpose  : 发送系统消息
  * Obj_Name    : P_SYS_MSG
  * Arg_Number  : 7
  * PI_MSG_CONTENT :信息内容
  * PI_MSG_TITLE :信息标题
  * PI_TARGET_USER :获取用户
  * PI_SENDER_NAME :发送人名称
  * PI_APP_ID :appid
  * PI_MSG_TYPE :  消息类型：S发送系统消息（蓝色警钟图标、没有‘立即处理’按钮
                             T发送hint消息（黄色待办图标、有‘立即处理’按钮
  * PI_NODE_ID :发送hint消息时需要，立即处理按钮跳转到的node_id
  *============================================*/

  PROCEDURE P_sys_msg(pi_msg_content in varchar2,
                      pi_msg_title   in varchar2,
                      pi_target_user in varchar2,
                      pi_sender_name in varchar2,
                      pi_app_id      in varchar2,
                      pi_msg_type    in varchar2,
                      pi_object_id     in varchar2);

end PKG_USER_MSG;
/

create or replace package body scmdata.PKG_USER_MSG is

  FUNCTION f_get_msg_text_msg(pi_msg_content varchar2,
                              pi_msg_type    varchar2,
                              pi_object_id   varchar2) return varchar2 is
    p_text_json_result varchar2(500);
  
  begin
    p_text_json_result := pi_msg_type;
    if pi_object_id is null then
      p_text_json_result := '{"Text":"' || pi_msg_content || '"}';
    else
      p_text_json_result := '{"Text":"' || pi_msg_content ||
                            '","FlReqAddr":{"needGps":0,"dataAddr":"' ||
                            '/ui/node/' || pi_object_id ||
                            '?origin=hint","varType":0,"varList":null,"isAsync":false,"reqType":"get","timeOut":null,"addrType":0}}';
    end if;
    return p_text_json_result;
  end f_get_msg_text_msg;

  --S发送系统消息（蓝色警钟图标、没有‘立即处理’按钮
  --T发送hint消息（黄色待办图标、有‘立即处理’按钮
  Procedure P_sys_msg(pi_msg_content in varchar2,
                      pi_msg_title   in varchar2,
                      pi_target_user in varchar2,
                      pi_sender_name in varchar2,
                      pi_app_id      in varchar2,
                      pi_msg_type    in varchar2,
                      pi_object_id   in varchar2) is
    p_send_type   varchar2(1);
    p_msg_content varchar2(500);
    p_obj_type    varchar2(20);
    p_i           number(1);
  begin
    if pi_target_user is null then
      p_send_type := '0';
    else
      p_send_type := '1';
      --验证target_name，必须按'HX87,CMS3'的形式输入
      select nvl(max(1), 0)
        into p_i
        from dual
       where regexp_like(pi_target_user, '^([a-zA-Z0-9]+[,]?)+$');
      if p_i = 0 then
        raise_application_error(-20002,
                                '发送消息失败，配置收件人错误，请联系管理员');
      end if;
    end if;
    if pi_msg_type = 'S' then
      p_msg_content := scmdata.PKG_USER_MSG.f_get_msg_text_msg(pi_msg_content,
                                                               pi_msg_type,
                                                               null);
      p_obj_type    := 'system';
    elsif pi_msg_type = 'T' then
      p_obj_type := 'hint';
      if pi_object_id is not null then
        p_msg_content := scmdata.PKG_USER_MSG.f_get_msg_text_msg(pi_msg_content,
                                                                 pi_msg_type,
                                                                 pi_object_id);
      else
        p_msg_content := scmdata.PKG_USER_MSG.f_get_msg_text_msg(pi_msg_content,
                                                                 pi_msg_type,
                                                                 null);
      end if;
    else
      raise_application_error(-20002,
                              '发送消息失败，不支持的消息类型，请联系管理员');
    end if;
    INSERT INTO nbw.msg_info
      (MSG_ID,
       SEND_TYPE,
       MESSAGE_INFO,
       RECEIVERS,
       URGENT,
       SEND_STATE,
       OBJECT_ID,
       OBJECT_TYPE,
       MSG_DESC,
       APP_ID,
       TITLE,
       SENDER)
    VALUES
      (f_get_uuid(),
       p_send_type,
       p_msg_content,
       pi_target_user,
       '0',
       NULL,
       NULL,
       p_obj_type,
       nvl(pi_msg_title, '无标题'),
       nvl(pi_app_id, 'scm'),
       nvl(pi_msg_title, '无标题'),
       nvl(pi_sender_name, '收件人'));
  end;

end PKG_USER_MSG;
/

