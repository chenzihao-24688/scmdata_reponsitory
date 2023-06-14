CREATE OR REPLACE PROCEDURE SCMDATA.p_send_wx_msg(p_company_id VARCHAR2,
                                          p_robot_key  VARCHAR2,
                                          p_robot_type VARCHAR2,
                                          p_msgtype    VARCHAR2 DEFAULT 'text',
                                          p_val_step   VARCHAR2 DEFAULT ';',
                                          p_msg_title  VARCHAR2,
                                          p_msg_body   CLOB,
                                          p_sender     CLOB) IS
  v_wx_sql         CLOB;
  v_msgtype        VARCHAR2(48);
  v_msg            CLOB;
  v_sender         CLOB;
  v_default_sender CLOB;
  v_content_type   VARCHAR(32);
BEGIN
 v_msgtype := p_msgtype;
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
    v_sender := scmdata.f_user_list_from_in_to_wecom(pi_user_list => v_sender,
                                                     value_step   => p_val_step);
    v_content_type := CASE
                        WHEN p_msgtype = 'markdown' THEN
                         'markdown_content'
                        ELSE
                         'CONTENT'
                      END;
     v_msg := '标题：' || p_msg_title || chr(13) || '内容：' || p_msg_body ||
             chr(13) || '接收人：' || v_sender || chr(13) || '创建时间：' ||
             to_char(SYSDATE, 'yyyy-mm-dd hh:mi:ss');

    v_wx_sql := 'select ''' || v_msgtype || ''' MSGTYPE,
                        ''' || v_msg || ''' ' ||
                v_content_type || ' ,
                        ''' || p_robot_key ||
                ''' key
                from dual';

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
       p_robot_type,
       p_company_id,
       2,
       sysdate,
       'ADMIN',
       p_msgtype,
       v_wx_sql,
       v_sender,
       null);
END;
/

