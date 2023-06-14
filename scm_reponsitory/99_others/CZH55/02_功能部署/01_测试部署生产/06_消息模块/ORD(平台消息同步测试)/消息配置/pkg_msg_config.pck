CREATE OR REPLACE PACKAGE pkg_msg_config AUTHID CURRENT_USER IS

  -- Author  : SANFU
  -- Created : 2021/3/17 16:41:57
  -- Purpose : ��Ϣ����
  /*
  ������Ϣʱ���ã�����ƴ��json
  */
  FUNCTION get_msg_text_msg(p_msg_content VARCHAR2,
                            p_msg_type    VARCHAR2,
                            p_object_id   VARCHAR2) RETURN VARCHAR2;
  --У�� msg_info
  PROCEDURE check_plag_msg(p_msg_content  IN VARCHAR2,
                           p_target_user  IN VARCHAR2,
                           p_msg_type     IN VARCHAR2,
                           p_object_id    IN VARCHAR2,
                           po_send_type   OUT VARCHAR2,
                           po_msg_content OUT VARCHAR2,
                           po_obj_type    OUT VARCHAR2);
  --ƽ̨��Ϣ���� MSG_INFO
  PROCEDURE config_plag_msg(p_msg_id      IN VARCHAR2,
                            p_urgent      IN VARCHAR2,
                            p_msg_title   IN VARCHAR2,
                            p_msg_content IN VARCHAR2,
                            p_target_user IN VARCHAR2,
                            p_sender_name IN VARCHAR2,
                            p_msg_type    IN VARCHAR2,
                            p_object_id   IN VARCHAR2);

  PROCEDURE insert_sys_group_msg_config(p_group_msg_id   VARCHAR2,
                                        p_group_msg_name VARCHAR2,
                                        p_config_id      VARCHAR2,
                                        p_config_type    VARCHAR2,
                                        p_apply_id       VARCHAR2,
                                        p_user_id        VARCHAR2,
                                        p_memo           VARCHAR2);

  PROCEDURE insert_sys_company_msg_config(p_company_msg_id VARCHAR2,
                                          p_group_msg_id   VARCHAR2,
                                          p_company_id     VARCHAR2,
                                          p_user_id        VARCHAR2,
                                          p_alter_id       VARCHAR2,
                                          p_memo           VARCHAR2);

  PROCEDURE delete_sys_company_msg_config(p_company_msg_id VARCHAR2);

  PROCEDURE update_sys_hint(p_hint_id        VARCHAR2,
                            p_node_id        VARCHAR2, --�ڵ���� 
                            p_caption        VARCHAR2, --���� 
                            p_text_sql       CLOB, --�����Ѵ�������ʾ���ı���Ϣ 
                            p_btn_caption    VARCHAR2, --��ť���� 
                            p_btn_exec_sql   CLOB, --���¸ð�ť��ִ�еĶ����� 
                            p_btn_enable_sql CLOB, --�ð�ť�ܷ�ʹ�ã����ز����͡�����������ֶ����ڶ����Ѵ��ڵ��°�ť�Ŀ��ƣ�ʹ�����Ѵ����п���ִ��һЩ�������������硰�Ƿ�������ѡ� 
                            p_wrap_flag      NUMBER DEFAULT 1, --0����ʾ���Զ�����;1����ʾ����ʾ�������Զ����� 
                            p_hint_flag      NUMBER DEFAULT 3); --����һλΪ1����¼ʱ�������ѣ����ڶ�λΪ1����ʱ����,ʱ��Ϊ5����  )

  PROCEDURE config_sys_hint(p_hint_id        VARCHAR2,
                            p_node_id        VARCHAR2,
                            p_caption        VARCHAR2,
                            p_text_sql       CLOB,
                            p_data_sql       CLOB,
                            p_btn_caption    VARCHAR2,
                            p_btn_exec_sql   CLOB,
                            p_btn_enable_sql CLOB,
                            p_wrap_flag      NUMBER DEFAULT 1,
                            p_hint_flag      NUMBER DEFAULT 3,
                            p_pause          NUMBER DEFAULT 0, --ƽ̨����ʱ��Ĭ��Ϊ1
                            p_data_source    VARCHAR2);

  --֪���ˣ��Ƿ������������...
  PROCEDURE config_handle_btn(p_company_id VARCHAR2,
                              p_user_id    VARCHAR2,
                              p_hint_id    VARCHAR2,
                              p_type       VARCHAR2);

  PROCEDURE send_msg(p_company_id  VARCHAR2,
                     p_user_id     VARCHAR2,
                     p_msg_title   VARCHAR2,
                     p_msg_content CLOB,
                     p_node_id     VARCHAR2 DEFAULT NULL,
                     p_type        VARCHAR2);

  --ͬ��������Ϣ������ҵ 0 �򵥸���ҵ 1
  PROCEDURE send_msg_to_company(p_company_id     VARCHAR2,
                                p_apply_name     VARCHAR2,
                                p_group_msg_name VARCHAR2,
                                p_status         NUMBER,
                                p_send_status    NUMBER);

  PROCEDURE pause_msg_config(p_group_msg_id VARCHAR2, p_status NUMBER);

  --��ͣ��ҵ��Ϣ����
  PROCEDURE pause_company_msg_config(p_group_msg_id VARCHAR2,
                                     p_company_id   VARCHAR2,
                                     p_status       NUMBER);

  --����sys_cond_list
  PROCEDURE config_sys_cond_list(p_cond_id         VARCHAR2, --����id 
                                 p_cond_sql        CLOB, --����sql 
                                 p_cond_type       NUMBER, --1��������ȷ��������ȡ������ť���ڣ����ݰ�ťѡ�����������ʾ��Ϣ�����û�ѡ��0��������ȷ������ť���ڣ���ִ�иò�������������Ч������ʾ����
                                 p_show_text       CLOB, --һ����ֱ��Щ��ʾ�ͱ�������ݡ����Ҫͨ��sql��䷵�ر������ݣ������û�������������
                                 p_data_source     VARCHAR2, --����Դ 
                                 p_cond_field_name VARCHAR2, --���������ֶ� 
                                 p_memo            VARCHAR2);

  --����sys_cond_rela----condtion������Ӧ��action
  PROCEDURE config_sys_cond_rela(p_cond_id  VARCHAR2, --����id 
                                 p_obj_type NUMBER, --0:  node_id��11: item list������12: item listɾ�� ��13. item list�޸ģ�14: item list �鿴��15: item  detail ����sql��16: item checkvalue (�������޸�)��21: label_list ��ǩ��ӡ��41: hint ��50��key step��51: ��ݷ�ʽ��55: �̵㰴ť��91: action��92: handle��93: �̵���飻95: associate��97����ͬģ�� 
                                 p_ctl_id   VARCHAR2, --����id 
                                 p_ctl_type NUMBER, --0:  condition  ��1:  ǰ��  ��2:  ���� ��3:  checkvalue��4: item�����������ݰ�ŦȨ�ޣ�5:item��������ģ�尴ŦȨ�ޣ�6:item�����ϴ����ݰ�ŦȨ�� 
                                 p_seq_no   NUMBER, --��� 
                                 p_pause    NUMBER, --�Ƿ���� 
                                 p_item_id  VARCHAR2);

  FUNCTION check_company_person(p_company_id VARCHAR2,
                                p_user_id    VARCHAR2,
                                p_type       VARCHAR2) RETURN NUMBER;

  --У�����ҵ����Ա
  FUNCTION check_admin(p_company_id VARCHAR2, p_user_id VARCHAR2)
    RETURN NUMBER;

  --��ȡ����ҵ����Ա
  FUNCTION get_company_admin(p_company_id VARCHAR2) RETURN VARCHAR2;

  FUNCTION check_person(p_company_id   VARCHAR2,
                        p_user_id      VARCHAR2,
                        p_group_msg_id VARCHAR2) RETURN NUMBER;

  PROCEDURE config_jurisdiction( --����sys_cond_list
                                p_cond_id         VARCHAR2, --����id 
                                p_cond_sql        CLOB, --����sql 
                                p_cond_type       NUMBER, --1��������ȷ��������ȡ������ť���ڣ����ݰ�ťѡ�����������ʾ��Ϣ�����û�ѡ��0��������ȷ������ť���ڣ���ִ�иò�������������Ч������ʾ����
                                p_show_text       CLOB, --һ����ֱ��Щ��ʾ�ͱ�������ݡ����Ҫͨ��sql��䷵�ر������ݣ������û�������������
                                p_data_source     VARCHAR2, --����Դ 
                                p_cond_field_name VARCHAR2, --���������ֶ� 
                                p_memo            VARCHAR2,
                                --����sys_cond_rela
                                p_obj_type NUMBER, --0:  node_id��11: item list������12: item listɾ�� ��13. item list�޸ģ�14: item list �鿴��15: item  detail ����sql��16: item checkvalue (�������޸�)��21: label_list ��ǩ��ӡ��41: hint ��50��key step��51: ��ݷ�ʽ��55: �̵㰴ť��91: action��92: handle��93: �̵���飻95: associate��97����ͬģ�� 
                                p_ctl_id   VARCHAR2, --����id 
                                p_ctl_type NUMBER, --0:  condition  ��1:  ǰ��  ��2:  ���� ��3:  checkvalue��4: item�����������ݰ�ŦȨ�ޣ�5:item��������ģ�尴ŦȨ�ޣ�6:item�����ϴ����ݰ�ŦȨ�� 
                                p_seq_no   NUMBER, --��� 
                                p_pause    NUMBER, --�Ƿ���� 
                                p_item_id  VARCHAR2 --������Ŀidʱ��ֻ�������Ŀid������ 
                                );

  --�������� ��������-��Ϣ����
  PROCEDURE config_t_factory_ask_msg(p_company_id        VARCHAR2,
                                     p_factory_ask_id    VARCHAR2,
                                     p_flow_node_name_af VARCHAR2,
                                     p_oper_code_desc    VARCHAR2,
                                     p_oper_code         VARCHAR2,
                                     p_status_af         VARCHAR2,
                                     p_type              VARCHAR2,
                                     po_target_company   OUT VARCHAR2,
                                     po_target_user      OUT VARCHAR2,
                                     po_msg              OUT VARCHAR2);

END pkg_msg_config;
/
CREATE OR REPLACE PACKAGE BODY pkg_msg_config IS
  c_app_id CONSTANT VARCHAR2(10) := 'scm';

  /*
  ������Ϣʱ���ã�����ƴ��json
  */
  FUNCTION get_msg_text_msg(p_msg_content VARCHAR2,
                            p_msg_type    VARCHAR2,
                            p_object_id   VARCHAR2) RETURN VARCHAR2 IS
    p_text_json_result VARCHAR2(500);
  
  BEGIN
    p_text_json_result := p_msg_type;
    IF p_object_id IS NULL THEN
      p_text_json_result := '{"Text":"' || p_msg_content || '"}';
    ELSE
      p_text_json_result := '{"Text":"' || p_msg_content ||
                            '","FlReqAddr":{"needGps":0,"dataAddr":"' ||
                            '/ui/node/' || p_object_id ||
                            '?origin=hint","varType":0,"varList":null,"isAsync":false,"reqType":"get","timeOut":null,"addrType":0}}';
    END IF;
    RETURN p_text_json_result;
  END get_msg_text_msg;

  --У�� msg_info
  PROCEDURE check_plag_msg(p_msg_content  IN VARCHAR2,
                           p_target_user  IN VARCHAR2,
                           p_msg_type     IN VARCHAR2,
                           p_object_id    IN VARCHAR2,
                           po_send_type   OUT VARCHAR2,
                           po_msg_content OUT VARCHAR2,
                           po_obj_type    OUT VARCHAR2) IS
    p_i NUMBER(1);
  BEGIN
    IF p_target_user IS NULL THEN
      po_send_type := '0';
    ELSE
      po_send_type := '1';
      --��֤target_name�����밴'HX87,CMS3'����ʽ����
      SELECT nvl(MAX(1), 0)
        INTO p_i
        FROM dual
       WHERE regexp_like(p_target_user, '^([a-zA-Z0-9]+[,]?)+$');
      IF p_i = 0 THEN
        raise_application_error(-20002,
                                '��Ϣ����ʧ�ܣ��ռ��������ʽ�����밴xxx,xxx����ʽ����');
      END IF;
    END IF;
  
    IF p_msg_type = 'SYSTEM' THEN
      po_obj_type    := 'SYSTEM';
      po_msg_content := get_msg_text_msg(p_msg_content, p_msg_type, NULL);
    
    ELSIF p_msg_type = 'SYSTEM_HINT' THEN
      po_obj_type := 'hint';
      IF p_object_id IS NOT NULL THEN
        po_msg_content := get_msg_text_msg(p_msg_content,
                                           p_msg_type,
                                           p_object_id);
      ELSE
        po_msg_content := get_msg_text_msg(p_msg_content, p_msg_type, NULL);
      END IF;
    ELSE
      raise_application_error(-20002,
                              '��Ϣ����ʧ�ܣ���֧�ֵ���Ϣ���ͣ�����ϵ����Ա');
    END IF;
  END check_plag_msg;
  /*============================================*
  * Author   : chenzh
  * Created  : 2021 3.17
  * Purpose  : ƽ̨��Ϣ���� MSG_INFO
  * Obj_Name    : config_plag_msg
  * Arg_Number  : 7
  * P_MSG_CONTENT :��Ϣ����
  * P_MSG_TITLE :��Ϣ���⣬����Ĭ�ϡ��ޱ��⡮
  * P_TARGET_USER :��ȡ�û���Ϊ��ʱΪȺ������Ϊ�����ǵ���
                    ע���ò��������ԡ�HX87,CMS3'����'HX87'����ʽ������У��ܾ�����ʽ���������
  * P_SENDER_NAME :���������ƣ�����������д������Ĭ�ϡ�system��
  * P_APP_ID :appid��������Ĭ�ϡ�scm��
  * P_MSG_TYPE :  ��Ϣ���ͣ�S��System������ϵͳ��Ϣ����ɫ����ͼ�ꡢû�С�����������ť��
                             T��Todo������hint��Ϣ����ɫ����ͼ�ꡢ�С�����������ť��
                             ע������У��ܾ��������������������
  * P_OBJECT_ID :����hint��Ϣʱ��Ҫ��Ϊ��������ť��ת����node_id
  *============================================*/
  PROCEDURE config_plag_msg(p_msg_id      IN VARCHAR2,
                            p_urgent      IN VARCHAR2,
                            p_msg_title   IN VARCHAR2,
                            p_msg_content IN VARCHAR2,
                            p_target_user IN VARCHAR2,
                            p_sender_name IN VARCHAR2,
                            p_msg_type    IN VARCHAR2,
                            p_object_id   IN VARCHAR2) IS
    po_send_type   VARCHAR2(1);
    po_msg_content VARCHAR2(500);
    po_obj_type    VARCHAR2(20);
  BEGIN
    --У�� msg_info
    check_plag_msg(p_msg_content  => p_msg_content,
                   p_target_user  => p_target_user,
                   p_msg_type     => p_msg_type,
                   p_object_id    => p_object_id,
                   po_send_type   => po_send_type,
                   po_msg_content => po_msg_content,
                   po_obj_type    => po_obj_type);
  
    INSERT INTO bw3.msg_info
      (msg_id,
       send_type,
       message_info,
       receivers,
       urgent,
       send_state,
       object_id,
       object_type,
       msg_desc,
       app_id,
       title,
       sender)
    VALUES
      (p_msg_id,
       po_send_type,
       po_msg_content,
       upper(p_target_user),
       decode(p_urgent, '��', 0, '��', 1, 1),
       NULL,
       NULL,
       po_obj_type,
       nvl(p_msg_title, '�ޱ���'),
       c_app_id,
       nvl(p_msg_title, '�ޱ���'),
       nvl(p_sender_name, 'SYSTEM'));
  
  END config_plag_msg;
  --����ƽ̨��Ϣ����
  PROCEDURE insert_sys_group_msg_config(p_group_msg_id   VARCHAR2,
                                        p_group_msg_name VARCHAR2,
                                        p_config_id      VARCHAR2,
                                        p_config_type    VARCHAR2,
                                        p_apply_id       VARCHAR2,
                                        p_user_id        VARCHAR2,
                                        p_memo           VARCHAR2) IS
  BEGIN
    INSERT INTO scmdata.sys_group_msg_config
      (group_msg_id,
       group_msg_name,
       apply_id,
       pause,
       create_time,
       create_id,
       update_time,
       update_id,
       config_id,
       config_type,
       memo)
    VALUES
      (p_group_msg_id,
       p_group_msg_name,
       p_apply_id,
       0,
       SYSDATE,
       p_user_id,
       SYSDATE,
       p_user_id,
       p_config_id,
       p_config_type,
       p_memo);
  
  END insert_sys_group_msg_config;
  --������ҵ��Ϣ����
  PROCEDURE insert_sys_company_msg_config(p_company_msg_id VARCHAR2,
                                          p_group_msg_id   VARCHAR2,
                                          p_company_id     VARCHAR2,
                                          p_user_id        VARCHAR2,
                                          p_alter_id       VARCHAR2,
                                          p_memo           VARCHAR2) IS
  BEGIN
    INSERT INTO scmdata.sys_company_msg_config
      (company_msg_id,
       group_msg_id,
       company_id,
       user_id,
       pause,
       create_time,
       create_id,
       update_time,
       update_id,
       memo)
    VALUES
      (p_company_msg_id,
       p_group_msg_id,
       p_company_id,
       p_user_id,
       0,
       SYSDATE,
       p_alter_id,
       SYSDATE,
       p_alter_id,
       p_memo);
  
  END insert_sys_company_msg_config;
  --ɾ����ҵ��Ϣ����
  PROCEDURE delete_sys_company_msg_config(p_company_msg_id VARCHAR2) IS
  BEGIN
  
    DELETE FROM scmdata.sys_company_msg_config ms
     WHERE ms.company_msg_id = p_company_msg_id;
  
  END delete_sys_company_msg_config;
  --�޸�sys_hint
  PROCEDURE update_sys_hint(p_hint_id        VARCHAR2,
                            p_node_id        VARCHAR2, --�ڵ���� 
                            p_caption        VARCHAR2, --���� 
                            p_text_sql       CLOB, --�����Ѵ�������ʾ���ı���Ϣ 
                            p_btn_caption    VARCHAR2, --��ť���� 
                            p_btn_exec_sql   CLOB, --���¸ð�ť��ִ�еĶ����� 
                            p_btn_enable_sql CLOB, --�ð�ť�ܷ�ʹ�ã����ز����͡�����������ֶ����ڶ����Ѵ��ڵ��°�ť�Ŀ��ƣ�ʹ�����Ѵ����п���ִ��һЩ�������������硰�Ƿ�������ѡ� 
                            p_wrap_flag      NUMBER DEFAULT 1, --0����ʾ���Զ�����;1����ʾ����ʾ�������Զ����� 
                            p_hint_flag      NUMBER DEFAULT 3 --����һλΪ1����¼ʱ�������ѣ����ڶ�λΪ1����ʱ����,ʱ��Ϊ5���� 
                            ) IS
  BEGIN
  
    UPDATE bw3.sys_hint t
       SET t.node_id        = p_node_id,
           t.caption        = p_caption,
           t.text_sql       = p_text_sql,
           t.btn_caption    = p_btn_caption,
           t.btn_exec_sql   = p_btn_exec_sql,
           t.btn_enable_sql = p_btn_enable_sql,
           t.wrap_flag      = p_wrap_flag,
           t.hint_flag      = p_hint_flag
     WHERE t.hint_id = p_hint_id;
  
  END update_sys_hint;

  --֪���ˣ��Ƿ������������... δʹ��
  PROCEDURE config_handle_btn(p_company_id VARCHAR2,
                              p_user_id    VARCHAR2,
                              p_hint_id    VARCHAR2,
                              p_type       VARCHAR2) IS
    v_group_msg_id VARCHAR2(100);
    v_flag         NUMBER;
  
  BEGIN
    SELECT gm.group_msg_id
      INTO v_group_msg_id
      FROM scmdata.sys_group_msg_config gm
     WHERE gm.config_id = p_hint_id;
  
    SELECT COUNT(1)
      INTO v_flag
      FROM scmdata.sys_company_msg_config mc
     WHERE mc.company_id = p_company_id
       AND mc.user_id = p_user_id
       AND mc.group_msg_id = v_group_msg_id;
  
    IF v_flag > 0 THEN
      --֪����
      IF p_type = '01' THEN
        UPDATE scmdata.sys_company_msg_config mc
           SET mc.pause = 1, mc.tomorrow_flag = 0
         WHERE mc.company_id = p_company_id
           AND mc.user_id = p_user_id
           AND mc.group_msg_id = v_group_msg_id;
        --�Ƿ������������
      ELSIF p_type = '02' THEN
        UPDATE scmdata.sys_company_msg_config mc
           SET mc.pause = 0, mc.tomorrow_flag = 1
         WHERE mc.company_id = p_company_id
           AND mc.user_id = p_user_id
           AND mc.group_msg_id = v_group_msg_id;
      END IF;
    
    END IF;
  
  END config_handle_btn;

  --ƽ̨������Ϣ
  PROCEDURE config_sys_hint(p_hint_id        VARCHAR2,
                            p_node_id        VARCHAR2, --�ڵ���� 
                            p_caption        VARCHAR2, --���� 
                            p_text_sql       CLOB, --�����Ѵ�������ʾ���ı���Ϣ 
                            p_data_sql       CLOB, --δʹ�� 
                            p_btn_caption    VARCHAR2, --��ť���� 
                            p_btn_exec_sql   CLOB, --���¸ð�ť��ִ�еĶ����� 
                            p_btn_enable_sql CLOB, --�ð�ť�ܷ�ʹ�ã����ز����͡�����������ֶ����ڶ����Ѵ��ڵ��°�ť�Ŀ��ƣ�ʹ�����Ѵ����п���ִ��һЩ�������������硰�Ƿ�������ѡ� 
                            p_wrap_flag      NUMBER DEFAULT 1, --0����ʾ���Զ�����;1����ʾ����ʾ�������Զ����� 
                            p_hint_flag      NUMBER DEFAULT 3, --����һλΪ1����¼ʱ�������ѣ����ڶ�λΪ1����ʱ����,ʱ��Ϊ5���� 
                            p_pause          NUMBER DEFAULT 0, --ƽ̨����ʱ��Ĭ��Ϊ1 0 ����;1 ���� 
                            p_data_source    VARCHAR2) IS
  BEGIN
    INSERT INTO bw3.sys_hint
      (hint_id,
       node_id,
       caption,
       text_sql,
       data_sql,
       btn_caption,
       btn_exec_sql,
       btn_enable_sql,
       wrap_flag,
       hint_flag,
       pause,
       data_source,
       app_id)
    VALUES
      (p_hint_id,
       p_node_id,
       p_caption,
       p_text_sql,
       p_data_sql,
       p_btn_caption,
       p_btn_exec_sql,
       p_btn_enable_sql,
       p_wrap_flag,
       p_hint_flag,
       p_pause,
       p_data_source,
       c_app_id);
  END;
  --ϵͳ�Զ�������Ϣ(hint)
  PROCEDURE send_msg(p_company_id  VARCHAR2,
                     p_user_id     VARCHAR2,
                     p_msg_title   VARCHAR2,
                     p_msg_content CLOB,
                     p_node_id     VARCHAR2 DEFAULT NULL,
                     p_type        VARCHAR2) IS
  
    v_msg_content  CLOB := p_msg_content;
    v_hint_id      VARCHAR2(32);
    v_cond_sql     CLOB;
    v_group_msg_id VARCHAR2(32);
    v_flag         NUMBER;
  
  BEGIN
  
    SELECT COUNT(1)
      INTO v_flag
      FROM scmdata.sys_company_msg_config mc
     WHERE mc.company_id = p_company_id
       AND mc.memo = p_type;
  
    v_group_msg_id := scmdata.f_get_uuid();
  
    IF v_flag > 0 THEN
    
      SELECT DISTINCT gm.config_id
        INTO v_hint_id
        FROM scmdata.sys_group_msg_config gm
       INNER JOIN scmdata.sys_company_msg_config mc
          ON gm.group_msg_id = mc.group_msg_id
       WHERE mc.company_id = p_company_id
         AND mc.memo = p_type;
    
      pkg_msg_config.insert_sys_group_msg_config(p_group_msg_id   => v_group_msg_id,
                                                 p_group_msg_name => 'ϵͳ����(��ť)',
                                                 p_config_id      => v_hint_id,
                                                 p_config_type    => 'SYS_HINT',
                                                 p_apply_id       => '',
                                                 p_user_id        => 'ADMIN',
                                                 p_memo           => '');
    
      IF instr(p_user_id, ',') > 0 THEN
        FOR i IN (SELECT regexp_substr(p_user_id, '[^,]+', 1, LEVEL, 'i') user_id
                    FROM dual
                  CONNECT BY LEVEL <=
                             length(p_user_id) -
                             length(regexp_replace(p_user_id, ',', '')) + 1) LOOP
        
          pkg_msg_config.insert_sys_company_msg_config(p_company_msg_id => scmdata.f_get_uuid(),
                                                       p_group_msg_id   => v_group_msg_id,
                                                       p_company_id     => p_company_id,
                                                       p_user_id        => i.user_id,
                                                       p_alter_id       => i.user_id,
                                                       p_memo           => p_type);
        
        END LOOP;
      
      ELSE
        pkg_msg_config.insert_sys_company_msg_config(p_company_msg_id => scmdata.f_get_uuid(),
                                                     p_group_msg_id   => v_group_msg_id,
                                                     p_company_id     => p_company_id,
                                                     p_user_id        => p_user_id,
                                                     p_alter_id       => p_user_id,
                                                     p_memo           => p_type);
      END IF;
    ELSE
    
      v_hint_id := f_getkeyid_plat(pi_pre     => 'sys_hint_',
                                   pi_seqname => 'SEQ_SYS_HINT',
                                   pi_seqnum  => 2);
    
      /* v_msg_content := 'select ' || '''' || v_msg_content || '''' ||
      ' from dual';*/
    
      pkg_msg_config.insert_sys_group_msg_config(p_group_msg_id   => v_group_msg_id,
                                                 p_group_msg_name => 'ϵͳ����(��ť)',
                                                 p_config_id      => v_hint_id,
                                                 p_config_type    => 'SYS_HINT',
                                                 p_apply_id       => '',
                                                 p_user_id        => 'ADMIN',
                                                 p_memo           => '');
    
      pkg_msg_config.insert_sys_company_msg_config(p_company_msg_id => scmdata.f_get_uuid(),
                                                   p_group_msg_id   => v_group_msg_id,
                                                   p_company_id     => p_company_id,
                                                   p_user_id        => p_user_id,
                                                   p_alter_id       => p_user_id,
                                                   p_memo           => p_type);
    
      --����hint
      pkg_msg_config.config_sys_hint(p_hint_id        => v_hint_id,
                                     p_node_id        => p_node_id,
                                     p_caption        => p_msg_title,
                                     p_text_sql       => v_msg_content,
                                     p_data_sql       => '',
                                     p_btn_caption    => '֪����',
                                     p_btn_exec_sql   => '',
                                     p_btn_enable_sql => 'select 1 from dual',
                                     p_wrap_flag      => 1,
                                     p_hint_flag      => 3,
                                     p_pause          => 0,
                                     p_data_source    => 'oracle_scmdata');
    
      v_cond_sql := q'[SELECT MAX(1) FROM dual WHERE pkg_msg_config.check_company_person(p_company_id   => %default_company_id%,p_user_id      => %user_id%]' ||
                    q'[,p_type => ]' || q'[']' || p_type || q'[']' ||
                    q'[) = 1]';
    
      pkg_msg_config.config_jurisdiction(p_cond_id         => 'cond_' ||
                                                              v_hint_id,
                                         p_cond_sql        => v_cond_sql,
                                         p_cond_type       => '',
                                         p_show_text       => '',
                                         p_data_source     => 'oracle_scmdata',
                                         p_cond_field_name => '',
                                         p_memo            => '',
                                         p_obj_type        => 41,
                                         p_ctl_id          => v_hint_id,
                                         p_ctl_type        => 0,
                                         p_seq_no          => 0,
                                         p_pause           => 0,
                                         p_item_id         => '');
    END IF;
  END send_msg;

  --ͬ��������Ϣ������ҵ 0 �򵥸���ҵ 1
  PROCEDURE send_msg_to_company(p_company_id     VARCHAR2,
                                p_apply_name     VARCHAR2,
                                p_group_msg_name VARCHAR2,
                                p_status         NUMBER,
                                p_send_status    NUMBER) IS
    v_hint_id     VARCHAR2(32);
    v_cond_sql    CLOB;
    v_msg_content CLOB;
  BEGIN
    v_hint_id := f_getkeyid_plat(pi_pre     => 'sys_hint_',
                                 pi_seqname => 'SEQ_SYS_HINT',
                                 pi_seqnum  => 2);
  
    --p_send_status 0 Ⱥ��������ҵ    1 ������ҵ                       
    IF p_send_status = 0 THEN
    
      IF p_status = 0 THEN
        v_msg_content := 'Ӧ�����ƣ�' || p_apply_name || ',��Ϣ���' ||
                         p_group_msg_name || ',������,��֪Ϥ��';
      ELSIF p_status = 1 THEN
        v_msg_content := 'Ӧ�����ƣ�' || p_apply_name || ',��Ϣ���' ||
                         p_group_msg_name || ',��ͣ��,��֪Ϥ��';
      END IF;
    
      v_cond_sql := q'[SELECT MAX(1)
    FROM dual
   WHERE pkg_msg_config.check_admin(p_company_id   => %default_company_id%,
                                     p_user_id      => %user_id%) = 1]';
    ELSIF p_send_status = 1 THEN
    
      IF p_status = 0 THEN
        v_msg_content := '��ǰ��ҵ,Ӧ�����ƣ�' || p_apply_name || ',��Ϣ���' ||
                         p_group_msg_name || ',������,��֪Ϥ��';
      ELSIF p_status = 1 THEN
        v_msg_content := '��ǰ��ҵ,Ӧ�����ƣ�' || p_apply_name || ',��Ϣ���' ||
                         p_group_msg_name || ',��ͣ��,��֪Ϥ��';
      END IF;
    
      v_cond_sql := q'[SELECT MAX(1) FROM dual WHERE pkg_msg_config.check_admin(p_company_id   => ']' ||
                    p_company_id || q'[',p_user_id      => %user_id%) = 1]';
    END IF;
  
    v_msg_content := 'select ' || '''' || v_msg_content || '''' ||
                     ' from dual';
  
    pkg_msg_config.insert_sys_group_msg_config(p_group_msg_id   => scmdata.f_get_uuid(),
                                               p_group_msg_name => 'ϵͳ����',
                                               p_config_id      => v_hint_id,
                                               p_config_type    => 'SYS_HINT',
                                               p_apply_id       => '',
                                               p_user_id        => 'ADMIN',
                                               p_memo           => '');
    --����hint
    pkg_msg_config.config_sys_hint(p_hint_id        => v_hint_id,
                                   p_node_id        => '',
                                   p_caption        => 'ϵͳ����',
                                   p_text_sql       => v_msg_content,
                                   p_data_sql       => '',
                                   p_btn_caption    => '֪����',
                                   p_btn_exec_sql   => '',
                                   p_btn_enable_sql => 'select 1 from dual',
                                   p_wrap_flag      => 1,
                                   p_hint_flag      => 3,
                                   p_pause          => 0,
                                   p_data_source    => 'oracle_scmdata');
  
    pkg_msg_config.config_jurisdiction(p_cond_id         => 'cond_' ||
                                                            v_hint_id,
                                       p_cond_sql        => v_cond_sql,
                                       p_cond_type       => '',
                                       p_show_text       => '',
                                       p_data_source     => 'oracle_scmdata',
                                       p_cond_field_name => '',
                                       p_memo            => '',
                                       p_obj_type        => 41,
                                       p_ctl_id          => v_hint_id,
                                       p_ctl_type        => 0,
                                       p_seq_no          => 0,
                                       p_pause           => 0,
                                       p_item_id         => '');
  
  END send_msg_to_company;

  --��ͣƽ̨��Ϣ����
  PROCEDURE pause_msg_config(p_group_msg_id VARCHAR2, p_status NUMBER) IS
    v_status         NUMBER;
    v_group_msg_name VARCHAR2(256);
    v_apply_name     VARCHAR2(256);
    x_err_msg        VARCHAR2(256);
    v_hint           VARCHAR2(256);
    msg_exp EXCEPTION;
  BEGIN
    SELECT gm.pause, gm.config_id, gm.group_msg_name, ga.apply_name
      INTO v_status, v_hint, v_group_msg_name, v_apply_name
      FROM scmdata.sys_group_msg_config gm
     INNER JOIN scmdata.sys_group_apply ga
        ON gm.apply_id = ga.apply_id
     WHERE gm.group_msg_id = p_group_msg_id;
  
    --1.��ͣ��Ϣ����
    IF p_status <> v_status THEN
      UPDATE scmdata.sys_group_msg_config gm
         SET gm.pause = p_status
       WHERE gm.group_msg_id = p_group_msg_id;
    
      UPDATE scmdata.sys_company_msg_config mc
         SET mc.pause = p_status
       WHERE mc.group_msg_id = p_group_msg_id;
    
      UPDATE bw3.sys_hint t
         SET t.pause = p_status
       WHERE t.hint_id = v_hint;
    
      UPDATE bw3.sys_cond_rela sr
         SET sr.pause = p_status
       WHERE sr.cond_id = 'cond_' || v_hint;
    
      --2.ͬ��������Ϣ������ҵ����Ա  
      send_msg_to_company(p_company_id     => NULL,
                          p_apply_name     => v_apply_name,
                          p_group_msg_name => v_group_msg_name,
                          p_status         => p_status,
                          p_send_status    => 0);
    ELSE
      --�����ظ�����ʾ��Ϣ
      RAISE msg_exp;
    END IF;
  
  EXCEPTION
    WHEN msg_exp THEN
      x_err_msg := '�����ظ���������';
      sys_raise_app_error_pkg.is_running_error(p_err_msg          => x_err_msg,
                                               p_is_running_error => 'F');
    WHEN OTHERS THEN
      sys_raise_app_error_pkg.is_running_error(p_err_msg          => x_err_msg,
                                               p_is_running_error => 'T');
  END pause_msg_config;

  --��ͣ��ҵ��Ϣ����
  PROCEDURE pause_company_msg_config(p_group_msg_id VARCHAR2,
                                     p_company_id   VARCHAR2,
                                     p_status       NUMBER) IS
    v_pause          NUMBER;
    v_group_msg_name VARCHAR2(256);
    v_apply_name     VARCHAR2(256);
    x_err_msg        VARCHAR2(256);
    msg_exp EXCEPTION;
  BEGIN
    SELECT sign(SUM(decode(mc.pause, 1, 1, 0)) / COUNT(mc.pause)) v_pause
      INTO v_pause
      FROM scmdata.sys_company_msg_config mc
     WHERE mc.group_msg_id = p_group_msg_id
       AND mc.company_id = p_company_id;
  
    --1.��ͣ��Ϣ����
    IF v_pause <> p_status THEN
      UPDATE scmdata.sys_company_msg_config mc
         SET mc.pause = p_status
       WHERE mc.group_msg_id = p_group_msg_id
         AND mc.company_id = p_company_id;
    
      SELECT DISTINCT ga.apply_name, gm.group_msg_name
        INTO v_apply_name, v_group_msg_name
        FROM scmdata.sys_group_apply ga
       INNER JOIN scmdata.sys_company_apply ca
          ON ca.apply_id = ga.apply_id
         AND ca.pause = 0
         AND ga.pause = 0
       INNER JOIN scmdata.sys_group_msg_config gm
          ON gm.apply_id = ca.apply_id
         AND gm.pause = 0
       INNER JOIN scmdata.sys_company_msg_config mc
          ON mc.group_msg_id = gm.group_msg_id
         AND mc.company_id = ca.company_id
       WHERE ca.company_id = p_company_id
         AND mc.group_msg_id = p_group_msg_id;
    
      --2.ͬ��������Ϣ����ǰ��ҵ����Ա  
      send_msg_to_company(p_company_id     => p_company_id,
                          p_apply_name     => v_apply_name,
                          p_group_msg_name => v_group_msg_name,
                          p_status         => p_status,
                          p_send_status    => 1);
    ELSE
      --�����ظ�����ʾ��Ϣ
      RAISE msg_exp;
    END IF;
  
  EXCEPTION
    WHEN msg_exp THEN
      x_err_msg := '�����ظ���������';
      sys_raise_app_error_pkg.is_running_error(p_err_msg          => x_err_msg,
                                               p_is_running_error => 'F');
    WHEN OTHERS THEN
      sys_raise_app_error_pkg.is_running_error(p_err_msg          => x_err_msg,
                                               p_is_running_error => 'T');
    
  END pause_company_msg_config;

  --����sys_cond_list
  PROCEDURE config_sys_cond_list(p_cond_id         VARCHAR2, --����id 
                                 p_cond_sql        CLOB, --����sql 
                                 p_cond_type       NUMBER, --1��������ȷ��������ȡ������ť���ڣ����ݰ�ťѡ�����������ʾ��Ϣ�����û�ѡ��0��������ȷ������ť���ڣ���ִ�иò�������������Ч������ʾ����
                                 p_show_text       CLOB, --һ����ֱ��Щ��ʾ�ͱ�������ݡ����Ҫͨ��sql��䷵�ر������ݣ������û�������������
                                 p_data_source     VARCHAR2, --����Դ 
                                 p_cond_field_name VARCHAR2, --���������ֶ� 
                                 p_memo            VARCHAR2) IS
  BEGIN
    INSERT INTO bw3.sys_cond_list
      (cond_id,
       cond_sql,
       cond_type,
       show_text,
       data_source,
       cond_field_name,
       memo)
    VALUES
      (p_cond_id,
       p_cond_sql,
       p_cond_type,
       p_show_text,
       p_data_source,
       p_cond_field_name,
       p_memo);
  END config_sys_cond_list;

  --����sys_cond_rela----condtion������Ӧ��action
  PROCEDURE config_sys_cond_rela(p_cond_id  VARCHAR2, --����id 
                                 p_obj_type NUMBER, --0:  node_id��11: item list������12: item listɾ�� ��13. item list�޸ģ�14: item list �鿴��15: item  detail ����sql��16: item checkvalue (�������޸�)��21: label_list ��ǩ��ӡ��41: hint ��50��key step��51: ��ݷ�ʽ��55: �̵㰴ť��91: action��92: handle��93: �̵���飻95: associate��97����ͬģ�� 
                                 p_ctl_id   VARCHAR2, --����id 
                                 p_ctl_type NUMBER, --0:  condition  ��1:  ǰ��  ��2:  ���� ��3:  checkvalue��4: item�����������ݰ�ŦȨ�ޣ�5:item��������ģ�尴ŦȨ�ޣ�6:item�����ϴ����ݰ�ŦȨ�� 
                                 p_seq_no   NUMBER, --��� 
                                 p_pause    NUMBER, --�Ƿ���� 
                                 p_item_id  VARCHAR2) IS --������Ŀidʱ��ֻ�������Ŀid������ 
  BEGIN
    INSERT INTO bw3.sys_cond_rela
      (cond_id, obj_type, ctl_id, ctl_type, seq_no, pause, item_id)
    VALUES
      (p_cond_id,
       p_obj_type,
       p_ctl_id,
       p_ctl_type,
       p_seq_no,
       p_pause,
       p_item_id);
  END config_sys_cond_rela;

  --ϵͳ�������ã��Զ�����ʱ����
  FUNCTION check_company_person(p_company_id VARCHAR2,
                                p_user_id    VARCHAR2,
                                p_type       VARCHAR2) RETURN NUMBER IS
    v_result NUMBER;
  BEGIN
    IF p_user_id IS NULL THEN
      v_result := check_admin(p_company_id => p_company_id,
                              p_user_id    => p_user_id);
    ELSE
      SELECT COUNT(1)
        INTO v_result
        FROM scmdata.sys_company_msg_config mc
       WHERE mc.company_id = p_company_id
         AND mc.user_id = p_user_id
         AND mc.memo = p_type
         AND mc.pause = 0
      /*AND mc.tomorrow_flag = 0*/
      ;
    END IF;
  
    IF v_result > 0 THEN
      RETURN 1;
    ELSE
      RETURN 0;
    END IF;
  
  END check_company_person;

  --У�����ҵ����Ա
  FUNCTION check_admin(p_company_id VARCHAR2, p_user_id VARCHAR2)
    RETURN NUMBER IS
    v_result NUMBER;
  BEGIN
    SELECT COUNT(1)
      INTO v_result
      FROM scmdata.sys_user su
     INNER JOIN scmdata.sys_user_company uc
        ON su.user_id = uc.user_id
     INNER JOIN scmdata.sys_company fc
        ON uc.company_id = fc.company_id
     INNER JOIN scmdata.sys_company_user cu
        ON uc.company_id = cu.company_id
       AND uc.user_id = cu.user_id
     INNER JOIN scmdata.sys_company_user_role ur
        ON cu.company_id = ur.company_id
       AND cu.user_id = ur.user_id
     INNER JOIN scmdata.sys_company_role cr
        ON ur.company_id = cr.company_id
       AND ur.company_role_id = cr.company_role_id
       AND cr.company_role_name = '����Ա'
     WHERE uc.company_id = p_company_id
       AND uc.user_id = p_user_id;
  
    IF v_result > 0 THEN
      RETURN 1;
    ELSE
      RETURN 0;
    END IF;
  
  END check_admin;

  --��ȡ����ҵ����Ա
  FUNCTION get_company_admin(p_company_id VARCHAR2) RETURN VARCHAR2 IS
    v_result VARCHAR2(4000);
  BEGIN
    SELECT listagg(su.user_account, ',') within GROUP(ORDER BY 1) target_user
      INTO v_result
      FROM scmdata.sys_user su
     INNER JOIN scmdata.sys_user_company uc
        ON su.user_id = uc.user_id
     INNER JOIN scmdata.sys_company fc
        ON uc.company_id = fc.company_id
     INNER JOIN scmdata.sys_company_user cu
        ON uc.company_id = cu.company_id
       AND uc.user_id = cu.user_id
     INNER JOIN scmdata.sys_company_user_role ur
        ON cu.company_id = ur.company_id
       AND cu.user_id = ur.user_id
     INNER JOIN scmdata.sys_company_role cr
        ON ur.company_id = cr.company_id
       AND ur.company_role_id = cr.company_role_id
       AND cr.company_role_name = '����Ա'
     WHERE uc.company_id = p_company_id;
    RETURN v_result;
  
  END get_company_admin;

  --��ҵ��Ϣ����Ȩ��
  FUNCTION check_person(p_company_id   VARCHAR2,
                        p_user_id      VARCHAR2,
                        p_group_msg_id VARCHAR2) RETURN NUMBER IS
    v_result NUMBER;
  BEGIN
    SELECT COUNT(1)
      INTO v_result
      FROM scmdata.sys_company_msg_config mc
     WHERE mc.company_id = p_company_id
       AND mc.user_id = p_user_id
       AND mc.group_msg_id = p_group_msg_id
       AND mc.pause = 0
       AND mc.tomorrow_flag = 0;
  
    IF v_result > 0 THEN
      RETURN 1;
    ELSE
      RETURN 0;
    END IF;
  
  END check_person;

  PROCEDURE config_jurisdiction( --����sys_cond_list
                                p_cond_id         VARCHAR2, --����id 
                                p_cond_sql        CLOB, --����sql 
                                p_cond_type       NUMBER, --1��������ȷ��������ȡ������ť���ڣ����ݰ�ťѡ�����������ʾ��Ϣ�����û�ѡ��0��������ȷ������ť���ڣ���ִ�иò�������������Ч������ʾ����
                                p_show_text       CLOB, --һ����ֱ��Щ��ʾ�ͱ�������ݡ����Ҫͨ��sql��䷵�ر������ݣ������û�������������
                                p_data_source     VARCHAR2, --����Դ 
                                p_cond_field_name VARCHAR2, --���������ֶ� 
                                p_memo            VARCHAR2,
                                --����sys_cond_rela
                                p_obj_type NUMBER, --0:  node_id��11: item list������12: item listɾ�� ��13. item list�޸ģ�14: item list �鿴��15: item  detail ����sql��16: item checkvalue (�������޸�)��21: label_list ��ǩ��ӡ��41: hint ��50��key step��51: ��ݷ�ʽ��55: �̵㰴ť��91: action��92: handle��93: �̵���飻95: associate��97����ͬģ�� 
                                p_ctl_id   VARCHAR2, --����id 
                                p_ctl_type NUMBER, --0:  condition  ��1:  ǰ��  ��2:  ���� ��3:  checkvalue��4: item�����������ݰ�ŦȨ�ޣ�5:item��������ģ�尴ŦȨ�ޣ�6:item�����ϴ����ݰ�ŦȨ�� 
                                p_seq_no   NUMBER, --��� 
                                p_pause    NUMBER, --�Ƿ���� 
                                p_item_id  VARCHAR2 --������Ŀidʱ��ֻ�������Ŀid������ 
                                ) IS
  BEGIN
    --1.����sys_cond_list
    config_sys_cond_list(p_cond_id         => p_cond_id,
                         p_cond_sql        => p_cond_sql,
                         p_cond_type       => p_cond_type,
                         p_show_text       => p_show_text,
                         p_data_source     => p_data_source,
                         p_cond_field_name => p_cond_field_name,
                         p_memo            => p_memo);
    --2.����sys_cond_rela
    config_sys_cond_rela(p_cond_id  => p_cond_id,
                         p_obj_type => p_obj_type,
                         p_ctl_id   => p_ctl_id,
                         p_ctl_type => p_ctl_type,
                         p_seq_no   => p_seq_no,
                         p_pause    => p_pause,
                         p_item_id  => p_item_id);
  
  END config_jurisdiction;

  --�������� ��������-��Ϣ���� �����ֶ�����֪ͨ��Ա
  PROCEDURE config_t_factory_ask_msg(p_company_id        VARCHAR2,
                                     p_factory_ask_id    VARCHAR2,
                                     p_flow_node_name_af VARCHAR2,
                                     p_oper_code_desc    VARCHAR2,
                                     p_oper_code         VARCHAR2,
                                     p_status_af         VARCHAR2,
                                     p_type              VARCHAR2,
                                     po_target_company   OUT VARCHAR2,
                                     po_target_user      OUT VARCHAR2,
                                     po_msg              OUT VARCHAR2) IS
  BEGIN
    SELECT v.company_id, v.oper_user_id
      INTO po_target_company, po_target_user
      FROM (SELECT fa.factory_ask_id,
                   a.oper_user_company_id company_id,
                   a.oper_user_id oper_user_id,
                   a.oper_code,
                   goper.group_dict_name oper_code_desc,
                   a.status_af_oper,
                   substr(gs.group_dict_name,
                          0,
                          instr(gs.group_dict_name, '+') - 1) flow_node_name_af
              FROM scmdata.t_factory_ask fa
             INNER JOIN scmdata.t_factory_ask_oper_log a
                ON fa.factory_ask_id = a.factory_ask_id
             INNER JOIN sys_group_dict goper
                ON goper.group_dict_value = upper(a.oper_code)
               AND goper.group_dict_type = 'DICT_FLOW_STATUS'
             INNER JOIN sys_group_dict gs
                ON gs.group_dict_value = a.status_af_oper
               AND gs.group_dict_type = 'FACTORY_ASK_FLOW'
             WHERE fa.company_id = p_company_id
               AND fa.factory_ask_id = p_factory_ask_id
             ORDER BY a.oper_time DESC) v
     WHERE rownum = 1
       AND oper_code = p_oper_code
       AND status_af_oper = p_status_af
       AND oper_code_desc = p_oper_code_desc
       AND flow_node_name_af = p_flow_node_name_af;
  
    po_msg := q'[SELECT '����' || COUNT(1) ||]';
  
    IF p_type = 'FAC_APPLY_R' THEN
      --1. �鳧���벵��֪ͨ,ϵͳ�Զ�֪ͨ�鳧������
      po_msg := po_msg ||
                q'['���鳧���뵥��[��������]=>[�鳧����]=>[���������]ʱ�����أ��뼰ʱǰ��[��������]=>[�鳧����]=>[���������Ӧ���嵥]ҳ����д���!']';
    ELSIF p_type = 'FAC_AGREE_S' THEN
      --2. ׼���������֪ͨ��ͨ��/��ͨ������ϵͳ�Զ�֪ͨ�鳧�����ˣ���������֪ͨ��Ա��  ����X����׼�������账���뼰ʱ����лл��
      po_msg := po_msg ||
                q'['����׼�������账���뼰ʱǰ��[��������]=>[׼������]=>[����������]ҳ����д���!']';
    ELSIF p_type = 'FAC_AGREE_F' THEN
      po_msg := po_msg ||
                q'['���鳧���벻ͨ�����뼰ʱǰ��[��������]=>[�鳧����]=>[���������Ӧ���嵥]ҳ����д���!']';
    ELSIF p_type = 'SUP_RE_APPLY' THEN
      --3.׼�벵��֪ͨ������������鳧,ϵͳ�Զ�֪ͨ�鳧��Ա����������֪ͨ��Ա����������������鳧����ϵͳ�Զ�֪ͨ�鳧���������ˣ���������֪ͨ��Ա����
      po_msg := po_msg ||
                q'['���鳧���뵥��׼�����ʱ�����أ���ǰ��[��������]=>[�鳧����]=>[���������]ҳ����д���!']';
    ELSIF p_type = 'SUP_RE_REPORT' THEN
      po_msg := po_msg || q'['���鳧���浥��׼�����ʱ�����أ���ǰ��[�鳧����]=>[���鳧]ҳ����д���!']';
    ELSIF p_type = 'REPLACE_FAC_R' THEN
      --4.���鳧����֪ͨ��ϵͳ�Զ�֪ͨ�鳧���������� ����X���鳧�����أ��뼰ʱ����лл��
      po_msg := po_msg || q'['���鳧���뵥���鳧ʱ�����أ���ǰ��[�鳧����]=>[���������]ҳ����д���!']';
    END IF;
  
    po_msg := po_msg || q'[ FROM (SELECT fa.factory_ask_id,
                   a.oper_user_company_id,
                   a.oper_user_id,
                   a.oper_code,
                   goper.group_dict_name oper_code_desc,
                   a.status_af_oper,
                   substr(gs.group_dict_name,
                          0,
                          instr(gs.group_dict_name, '+') - 1) flow_node_name_af
              FROM scmdata.t_factory_ask fa
             INNER JOIN scmdata.t_factory_ask_oper_log a
                ON fa.factory_ask_id = a.factory_ask_id
             INNER JOIN sys_group_dict goper
                ON goper.group_dict_value = upper(a.oper_code)
               AND goper.group_dict_type = 'DICT_FLOW_STATUS'
             INNER JOIN sys_group_dict gs
                ON gs.group_dict_value = a.status_af_oper
               AND gs.group_dict_type = 'FACTORY_ASK_FLOW'
             WHERE fa.company_id = %default_company_id%
               AND fa.ask_user_id = %user_id%
             ORDER BY a.oper_time DESC) v
     WHERE rownum = 1
       AND oper_code = ']' || p_oper_code || q'['
       AND status_af_oper = ']' || p_status_af || q'['
        AND flow_node_name_af = ']' || p_flow_node_name_af ||
              q'[']' || q'[ AND oper_code_desc = ']' || p_oper_code_desc ||
              q'[']';
  
  END config_t_factory_ask_msg;

END pkg_msg_config;
/
