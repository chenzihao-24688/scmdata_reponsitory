CREATE OR REPLACE PACKAGE scmdata.pkg_plat_comm IS

  -- Author  : HX87
  -- Created : 2020/7/9 9:30:05
  -- Purpose : ƽ̨��������

  -- �ж��û�Ȩ�ޣ�
  /*
   pi_user_id: sys_user���user_id
   pi_security_id: Ȩ�ޱ�ţ����Ȩ���ж��м��� ','���Ÿ��� ���磺 23,24,25
   pi_company_id: ��ҵ���,�ж��û�+��ҵ�µ�Ȩ��
   pi_type: Ȩ������ G��ƽ̨Ȩ���ж�   
                     C:��ҵȨ���ж�
  */
  FUNCTION f_userhasaction(pi_user_id     IN VARCHAR2,
                           pi_company_id  IN VARCHAR2,
                           pi_security_id IN VARCHAR2,
                           pi_type        IN VARCHAR2) RETURN INT;
  /*
   ���ܣ�ƽ̨Ȩ���ж�
   pi_user_id: sys_user���user_id
   pi_security_id: Ȩ�ޱ�ţ����Ȩ���ж��м��� ','���Ÿ��� ���磺 23,24,25
  */
  FUNCTION f_hasaction_group(pi_user_id     IN VARCHAR2,
                             pi_security_id IN VARCHAR2) RETURN INT;
  /*
   ���ܣ���ҵȨ���ж�
   pi_user_id: sys_user���user_id
   pi_company_id: ��ҵ���,�ж��û�+��ҵ�µ�Ȩ��
   pi_security_id: Ȩ�ޱ�ţ����Ȩ���ж��м��� ','���Ÿ��� ���磺 23,24,25
  */
  FUNCTION f_hasaction_company(pi_user_id     IN VARCHAR2,
                               pi_company_id  IN VARCHAR2,
                               pi_security_id IN VARCHAR2) RETURN INT;
  /*
   ���ܣ�Ӧ�ù���Ȩ���ж�
   pi_user_id: sys_user���user_id
   pi_company_id: ��ҵ���,�ж��û�+��ҵ�µ�Ȩ��
   pi_priv_id: Ȩ�ޱ��
  */
  FUNCTION f_hasaction_application(pi_user_id    IN VARCHAR2,
                                   pi_company_id IN VARCHAR2,
                                   pi_priv_id    IN VARCHAR2) RETURN INT;

  /*
   ���ܣ�Ӧ�ÿɼ����ж�
   pi_user_id: sys_user���user_id
   pi_company_id: ��ҵ���,�ж��û�+��ҵ�µ�Ȩ��
   PI_APPLY_ID: Ӧ�ñ��(P001\P002...)
  */
  FUNCTION f_userhasaction_app_see(pi_userid     VARCHAR2,
                                   pi_company_id VARCHAR2,
                                   pi_apply_id   VARCHAR2) RETURN NUMBER;
  /*
   ���ܣ������ں�����ҵ��ŵı�������Ϊ�����֣������ͻ��޲����ĳ���
   PI_TABLE_NAME: ����
   PI_COLUMN_NAME �ֶ���
   pi_company_id: ��ҵ���,�ж��û�+��ҵ�µ�Ȩ��
  */
  FUNCTION f_getkeyid_number(pi_table_name  VARCHAR2,
                             pi_column_name VARCHAR2,
                             pi_company_id  VARCHAR2) RETURN VARCHAR2;

  /*============================================*
  * Author   : CZH
  * Created  : 2020-09-12 16:57:42
  * ALERTER  : 
  * ALERTER_TIME  : 
  * Purpose  : ������̨���е���Ϊƽ̨ͳһ��������Ψһ�룬�Ҳ��ɸ��ġ�
  * Obj_Name    : P_GETKEYCODE
  * Arg_Number  : 3
  * pi_pre : ǰ׺
  * pi_seqname : ������
  * pi_seqnum : �������ֵ��������ݿ����Ѵ������У�����Ҫ��д��ֵ�����������д��
  *============================================*/
  FUNCTION f_getkeyid_plat(pi_pre     VARCHAR2,
                           pi_seqname VARCHAR2,
                           pi_seqnum  NUMBER DEFAULT NULL) RETURN VARCHAR2;

  /*============================================*
  * Author   : CZH
  * Created  : 2020-09-12 16:57:42
  * ALERTER  : 
  * ALERTER_TIME  : 
  * Purpose  : �����ں�����ҵ��ŵı����磺��ȡ��ͬ��ҵ�Ĺ�Ӧ�̱��� �������ǰ׺ + ��ˮ��
  * Obj_Name    : F_GETKEYCODE
  * Arg_Number  : 5
  * PI_TABLE_NAME : ����
  * PI_COLUMN_NAME : ����
  * PI_COMPANY_ID : ��˾���
  * PI_PRE : ǰ׺
  * PI_SERAIL_NUM :  ��ˮ�ų���
  *============================================*/

  FUNCTION f_getkeycode(pi_table_name  VARCHAR2, --����
                        pi_column_name VARCHAR2, --����
                        pi_company_id  VARCHAR2, --��˾���
                        pi_pre         VARCHAR2, --ǰ׺
                        pi_serail_num  NUMBER) RETURN VARCHAR2;

  /*============================================*
  * Author   : HX87
  * Created  : 2020-11-26 20:57:42
  * ALERTER  : 
  * ALERTER_TIME  : 
  * Purpose  : ����Ӧ��Ȩ�ޱ�ţ��̻���
  * Obj_Name    : F_GETNEWSYS_APP_PRIV_ID
  * Arg_Number  : 1
  * PI_PARENT_PRIV_ID : ��ID
  *============================================*/
  FUNCTION f_getnewsys_app_priv_id(pi_parent_priv_id VARCHAR2)
    RETURN VARCHAR2;

  /*
  ������Ϣʱ���ã�����ƴ����Ϣjson
  */
  FUNCTION f_get_msg_text_msg(pi_msg_content VARCHAR2,
                              pi_msg_type    VARCHAR2,
                              pi_object_id   VARCHAR2) RETURN VARCHAR2;

  /*============================================*
  * Author   : zwh73
  * Created  : 2020-08-14 14:01:53
  * Purpose  : ����ϵͳ��Ϣ
  * Obj_Name    : P_SYS_MSG
  * Arg_Number  : 7
  * PI_MSG_CONTENT :��Ϣ����
  * PI_MSG_TITLE :��Ϣ���⣬����Ĭ�ϡ��ޱ��⡮
  * PI_TARGET_USER :��ȡ�û���Ϊ��ʱΪȺ������Ϊ�����ǵ���
                    ע���ò��������ԡ�HX87,CMS3'����'HX87'����ʽ������У��ܾ�����ʽ���������
  * PI_SENDER_NAME :���������ƣ�����������д������Ĭ�ϡ�system��
  * PI_APP_ID :appid��������Ĭ�ϡ�scm��
  * PI_MSG_TYPE :  ��Ϣ���ͣ�S��System������ϵͳ��Ϣ����ɫ����ͼ�ꡢû�С�����������ť��
                             T��Todo������hint��Ϣ����ɫ����ͼ�ꡢ�С�����������ť��
                             ע������У��ܾ��������������������
  * PI_OBJECT_ID :����hint��Ϣʱ��Ҫ��Ϊ��������ť��ת����node_id
  *============================================*/

  PROCEDURE p_sys_msg(pi_msg_content IN VARCHAR2,
                      pi_msg_title   IN VARCHAR2,
                      pi_target_user IN VARCHAR2,
                      pi_sender_name IN VARCHAR2,
                      pi_app_id      IN VARCHAR2,
                      pi_msg_type    IN VARCHAR2,
                      pi_object_id   IN VARCHAR2);
  ----�û��ֻ�ע��
  PROCEDURE p_user_register(pi_moblie       IN VARCHAR2,
                            pi_uuid         IN VARCHAR2,
                            pi_devicesystem IN VARCHAR2);
  --��ҵ�Ƿ���Ӧ��
  FUNCTION f_company_has_app(pi_company_id IN VARCHAR2,
                             pi_apply_id   IN VARCHAR2) RETURN NUMBER;
  --czh add ͨ����ͣ
  PROCEDURE p_pause(p_table       IN VARCHAR2,
                    p_pause_field IN VARCHAR2 DEFAULT 'pause',
                    p_where       IN VARCHAR2,
                    p_user_id     IN VARCHAR2 DEFAULT 'ADMIN',
                    p_status      IN VARCHAR2);

  --czh add ��ɫת����ʨƽ̨��ɫֵ  ʮ��������ɫ�� =��תBGR��ɫֵ=> תʮ����  
  --p_rgb  ʮ��������ɫ��
  --return תbgr  תʮ���Ƶ���ʨƽ̨��ɫֵ
  FUNCTION f_rgb_to_bgr_val(p_rgb VARCHAR2) RETURN NUMBER;
  --czh add ��΢��Ϣ��������
  FUNCTION send_wx_msg(p_company_id VARCHAR2,
                       p_msgtype    VARCHAR2 DEFAULT 'text',
                       p_msg_title  VARCHAR2,
                       p_msg_body   CLOB,
                       p_sender     CLOB,
                       p_val_step   VARCHAR2 DEFAULT ';',
                       p_bot_key    VARCHAR2,
                       p_robot_type VARCHAR2) RETURN CLOB;
  --czh add ��ȡƽ̨�ֵ����ҵ�ֵ�ֵ
  FUNCTION f_get_platorcompany_dict(p_type            VARCHAR2,
                                    p_value           VARCHAR2,
                                    p_company_id      VARCHAR2 DEFAULT NULL,
                                    p_is_company_dict INT) RETURN VARCHAR2;
  --czh add ��ȡԱ������
  FUNCTION f_get_username(p_user_id         VARCHAR2,
                          p_company_id      VARCHAR2 DEFAULT NULL,
                          p_is_company_user INT DEFAULT 0,
                          p_is_mutival      INT DEFAULT 0,
                          p_spilt           VARCHAR2 DEFAULT ';')
    RETURN VARCHAR2;
  --czh add ��ȡ��Ӧ������                      
  FUNCTION f_get_sup_name(p_company_id    VARCHAR2,
                          p_sup_code      VARCHAR2,
                          p_is_inner_code INT DEFAULT 0,
                          p_is_short_name INT DEFAULT 0) RETURN VARCHAR2;
  --czh add ��ȡ����
  FUNCTION f_get_company_deptname(p_company_id VARCHAR2,
                                  p_dept_id    VARCHAR2) RETURN VARCHAR2;
  --czh add ��ѯƽ̨������־
  FUNCTION f_query_t_plat_log(p_apply_pk_id      VARCHAR2,
                              p_dict_type        VARCHAR2,
                              p_is_flhide_fileds INT DEFAULT 0) RETURN CLOB;

  --czh add ���ݷָ�����֣���ȡ�ָ���ǰ���ַ���
  FUNCTION f_get_val_by_delimit(p_character VARCHAR2,
                                p_separate  CHAR,
                                p_is_pre    INT DEFAULT 1) RETURN VARCHAR2;
  --czh add  asscoate data_sql
  --��ȡpkid��rest������POST;DELETE;PUT;GET��,��̬����
  --sup123/ALL;GET;POST;PUT;DELETE?PARAM1&PARAM2
  PROCEDURE p_get_rest_val_method_params(p_character     VARCHAR2,
                                         po_pk_id        OUT VARCHAR2,
                                         po_rest_methods OUT VARCHAR2,
                                         po_params       OUT VARCHAR2);
  --asscoate data_sql
  --��ȡpkid��rest������POST;DELETE;PUT;GET��,��̬����
  --sup123/ALL;GET;POST;PUT;DELETE?PARAM1&PARAM2
  FUNCTION f_get_rest_val_method_params(p_character VARCHAR2,
                                        p_rtn_type  INT) RETURN VARCHAR2;
  --czh add ���ݷָ�����ȡ�ַ���֮��Ľ���
  FUNCTION f_get_varchar_intersect(p_str1     VARCHAR2,
                                   p_str2     VARCHAR2,
                                   p_separate VARCHAR2) RETURN VARCHAR2;
  --ͨ�����ͻ�ȡlookup sql
  FUNCTION f_get_lookup_sql_by_type(p_group_dict_type VARCHAR2,
                                    p_field_value     VARCHAR2,
                                    p_field_desc      VARCHAR2,
                                    p_company_id      VARCHAR2 DEFAULT NULL,
                                    p_is_company_dict INT DEFAULT 0,
                                    p_where_sql       VARCHAR2 DEFAULT NULL)
    RETURN CLOB;

  -- �����Ͳ�ѯpick��ͬʱ�ÿ������ֶ�
  FUNCTION f_get_picksql_by_type(p_group_dict_type   VARCHAR2,
                                 p_dict_value        VARCHAR2,
                                 p_dict_desc         VARCHAR2,
                                 p_is_set_other_fd   INT DEFAULT 0,
                                 p_is_company_dict   INT DEFAULT 0,
                                 p_company_id        VARCHAR2 DEFAULT NULL,
                                 p_setnull_fdvalue_1 VARCHAR2 DEFAULT 'fdvalue_1',
                                 p_setnull_fddesc_1  VARCHAR2 DEFAULT 'fddesc_1',
                                 p_setnull_fdvalue_2 VARCHAR2 DEFAULT 'fdvalue_2',
                                 p_setnull_fddesc_2  VARCHAR2 DEFAULT 'fddesc_2',
                                 p_setnull_fdvalue_3 VARCHAR2 DEFAULT 'fdvalue_3',
                                 p_setnull_fddesc_3  VARCHAR2 DEFAULT 'fddesc_3',
                                 p_setnull_fdvalue_4 VARCHAR2 DEFAULT 'fdvalue_4',
                                 p_setnull_fddesc_4  VARCHAR2 DEFAULT 'fddesc_4',
                                 p_setnull_fdvalue_5 VARCHAR2 DEFAULT 'fdvalue_5',
                                 p_setnull_fddesc_5  VARCHAR2 DEFAULT 'fddesc_5')
    RETURN CLOB;

  --����json
  FUNCTION f_parse_json(p_jsonstr VARCHAR2, p_key VARCHAR2) RETURN CLOB;

END pkg_plat_comm;
/
CREATE OR REPLACE PACKAGE BODY scmdata.pkg_plat_comm IS

  -- Function and procedure implementations
  FUNCTION f_userhasaction(pi_user_id     IN VARCHAR2,
                           pi_company_id  IN VARCHAR2,
                           pi_security_id IN VARCHAR2,
                           pi_type        IN VARCHAR2) RETURN INT IS
    p_result INT;
  BEGIN
    --�ж��û���ƽ̨�Ƿ񱻽���
    SELECT COUNT(*)
      INTO p_result
      FROM sys_user
     WHERE user_id = pi_user_id
       AND pause = 0;
    IF p_result > 0 THEN
      IF pi_type = 'G' THEN
        --�ж��Ƿ���ƽ̨����Ȩ��
        p_result := pkg_plat_comm.f_hasaction_group(pi_user_id,
                                                    pi_security_id);
      
      ELSIF pi_type = 'C' THEN
        --�ж��Ƿ�����ҵ����Ȩ��
        --�ж���ҵ�Ƿ���ҵ����
        SELECT MAX(1)
          INTO p_result
          FROM sys_company_user
         WHERE user_id = pi_user_id
           AND pause = 0;
      
        IF p_result > 0 THEN
          p_result := pkg_plat_comm.f_hasaction_company(pi_user_id,
                                                        pi_company_id,
                                                        pi_security_id);
        ELSE
          p_result := 0;
        END IF;
      
      ELSE
        --�������ͣ�ʶ�𲻵���������Ȩ��
        p_result := 0;
      END IF;
    
    END IF;
  
    IF p_result > 1 THEN
      p_result := 1;
    END IF;
    RETURN p_result;
  END;
  FUNCTION f_hasaction_group(pi_user_id     IN VARCHAR2,
                             pi_security_id IN VARCHAR2) RETURN INT IS
    p_result INT;
  BEGIN
    SELECT COUNT(*)
      INTO p_result
      FROM sys_group_user_role
     WHERE user_id = pi_user_id
       AND group_role_id IN
           (SELECT group_role_id
              FROM sys_group_role_security
             WHERE instr(',0,' || REPLACE(pi_security_id, ' ', '') || ',',
                         ',' || to_char(group_security_id) || ',') > 0);
    IF p_result > 1 THEN
      p_result := 1;
    END IF;
    RETURN p_result;
    RETURN p_result;
  END;
  FUNCTION f_hasaction_company(pi_user_id     IN VARCHAR2,
                               pi_company_id  IN VARCHAR2,
                               pi_security_id IN VARCHAR2) RETURN INT IS
    p_result INT;
  BEGIN
  
    IF pi_company_id IS NULL OR pi_security_id IS NULL OR
       pi_user_id IS NULL THEN
      p_result := 0;
      RETURN p_result;
    END IF;
  
    SELECT COUNT(*)
      INTO p_result
      FROM scmdata.sys_company_user_role
     WHERE user_id = pi_user_id
       AND company_id = pi_company_id
       AND company_role_id IN
           (SELECT company_role_id
              FROM scmdata.sys_company_role_security
             WHERE instr(',0,' || REPLACE(pi_security_id, ' ', '') || ',',
                         ',' || to_char(company_security_id) || ',') > 0
               AND company_id = pi_company_id);
    IF p_result > 1 THEN
      p_result := 1;
    END IF;
    RETURN p_result;
  END;

  /*
   ���ܣ�Ӧ�ù���Ȩ���ж�
   pi_user_id: sys_user���user_id
   pi_company_id: ��ҵ���,�ж��û�+��ҵ�µ�Ȩ��
   pi_priv_id: Ȩ�ޱ��
  */
  FUNCTION f_hasaction_application(pi_user_id    IN VARCHAR2,
                                   pi_company_id IN VARCHAR2,
                                   pi_priv_id    IN VARCHAR2) RETURN INT IS
    v_result       NUMBER(5);
    v_apply_belong NUMBER(5);
    v_company_role VARCHAR2(20);
  BEGIN
  
    IF pi_company_id IS NULL OR pi_priv_id IS NULL OR pi_user_id IS NULL THEN
      v_result := 0;
      RETURN v_result;
    END IF;
  
    -- -1.��֤��ҵƽ̨��ɫ�ǲɹ������ǹ�Ӧ�����Լ���Ӧ�Ĺ����Ƿ�����չʾ 2021-11-22
    SELECT MAX(a.apply_belong)
      INTO v_apply_belong
      FROM sys_app_privilege a
     WHERE a.priv_id = pi_priv_id;
  
    SELECT MAX(a.company_role)
      INTO v_company_role
      FROM sys_company a
     WHERE a.company_id = pi_company_id;
  
    /*0��������ҵ������;1.ֻ�вɹ���;2.ֻ�й�Ӧ��;3.�ɹ���%��Ӧ�̣�4.����*/
    IF v_company_role = 'supp' AND v_apply_belong NOT IN (0, 2, 3) OR
       v_company_role = 'need' AND v_apply_belong NOT IN (0, 1, 3) THEN
      v_result := 0;
      RETURN v_result;
    ELSE
      NULL;
    END IF;
    --0 �ж��Ƿ���ҵ��������Ա  ,��������Աӵ������Ȩ��
    /*  select max(1) into v_result 
     from sys_company_user_role a 
    inner join sys_company_role b on a.company_role_id=b.company_role_id
    where a.user_id=pi_user_id and b.company_role_name='��������Ա'
      and a.company_id=pi_company_id;
    if v_result =1 then return v_result; end if;*/
    /*SELECT MAX(1)
     INTO v_result
     FROM sys_company_security a
    INNER JOIN sys_company_role_security b
       ON a.company_security_id = b.company_security_id
      AND b.company_id = pi_company_id
    INNER JOIN sys_company_user_role c
       ON b.company_role_id = c.company_role_id
      AND b.company_id = c.company_id
    INNER JOIN sys_company_role d
       ON c.company_role_id = d.company_role_id
      AND c.company_role_id = d.company_role_id
    WHERE c.user_id = pi_user_id
      AND c.company_id = pi_company_id
      AND (a.company_security_id = '70' OR d.company_role_name = '��������Ա');*/
    SELECT MAX(1)
      INTO v_result
      FROM (SELECT company_role_id, company_id
              FROM scmdata.sys_company_user_role
             WHERE user_id = pi_user_id
               AND company_id = pi_company_id) a
     INNER JOIN scmdata.sys_company_role_security b
        ON a.company_role_id = b.company_role_id
       AND a.company_id = b.company_id
     INNER JOIN scmdata.sys_company_security c
        ON b.company_security_id = c.company_security_id
       AND b.company_id = c.company_security_id
     INNER JOIN scmdata.sys_company_role d
        ON a.company_role_id = d.company_role_id
       AND a.company_id = d.company_id
     WHERE (c.company_security_id = '70' OR d.company_role_name = '��������Ա');
  
    IF v_result = 1 THEN
      RETURN v_result;
    END IF;
  
    --1.�ж���ҵ�Ƿ�������Ȩ�޹�ϵ��û����Ĭ�� Ϊ��Ȩ��
  
    SELECT COUNT(1)
      INTO v_result
      FROM sys_app_user_role_group_ra a
     INNER JOIN sys_app_role_group_ra b
        ON a.role_group_id = b.role_group_id
       AND a.company_id = b.company_id
     INNER JOIN sys_app_role_priv_ra c
        ON b.role_id = c.role_id
       AND b.company_id = c.company_id
     WHERE a.company_id = pi_company_id
       AND a.pause = 0
       AND b.pause = 0
       AND c.pause = 0
       AND c.priv_id IN
           (SELECT priv_id
              FROM sys_app_privilege t
             WHERE t.pause = 0
             START WITH t.priv_id = pi_priv_id
            CONNECT BY PRIOR t.priv_id = t.parent_priv_id);
    IF v_result > 0 THEN
      --2.�������ù�ϵ��������ԱȨ���ж�
      SELECT COUNT(*)
        INTO v_result
        FROM sys_app_user_role_group_ra a
       INNER JOIN sys_app_role_group_ra b
          ON a.role_group_id = b.role_group_id
         AND a.company_id = b.company_id
       INNER JOIN sys_app_role_priv_ra c
          ON b.role_id = c.role_id
         AND b.company_id = c.company_id
       WHERE a.user_id = pi_user_id
         AND a.company_id = pi_company_id
         AND a.pause = 0
         AND b.pause = 0
         AND c.pause = 0
         AND c.priv_id IN
             (SELECT priv_id
                FROM sys_app_privilege t
               WHERE t.pause = 0
               START WITH t.priv_id = pi_priv_id
              CONNECT BY PRIOR t.priv_id = t.parent_priv_id);
    ELSE
      --û����Ĭ�� Ϊ��Ȩ��
      v_result := 1;
    END IF;
    IF v_result > 0 THEN
      v_result := 1;
    ELSE
      v_result := 0;
    END IF;
  
    RETURN v_result;
  END;

  FUNCTION f_userhasaction_app_see(pi_userid     VARCHAR2,
                                   pi_company_id VARCHAR2,
                                   pi_apply_id   VARCHAR2) RETURN NUMBER IS
    v_i               INT;
    v_result          INT;
    v_expired_time    DATE;
    v_pause           INT;
    v_now             DATE;
    v_company_dept_id sys_company_dept.company_dept_id%TYPE;
    v_company_role    VARCHAR2(50);
    v_apply_belong    INT;
  BEGIN
    v_now := SYSDATE;
  
    IF pi_company_id IS NULL OR pi_apply_id IS NULL OR pi_userid IS NULL THEN
      v_result := 0;
      RETURN v_result;
    END IF;
  
    /* �ɹ���: need ; ��Ӧ��:supp */
    SELECT MAX(a.company_role)
      INTO v_company_role
      FROM sys_company a
     WHERE a.company_id = pi_company_id
       AND a.pause = 0;
  
    SELECT MAX(a.apply_belong)
      INTO v_apply_belong
      FROM sys_group_apply a
     WHERE a.apply_id = pi_apply_id;
    /*0��������ҵ������;1.ֻ�вɹ���;2.ֻ�й�Ӧ��;3.�ɹ���%��Ӧ�̣�4.����*/
    IF v_company_role = 'supp' AND v_apply_belong NOT IN (0, 2, 3) OR
       v_company_role = 'need' AND v_apply_belong NOT IN (0, 1, 3) THEN
      v_result := 0;
      RETURN v_result;
    ELSE
      NULL;
    END IF;
  
    -- 0 �ж��û���ҵ�Ƿ����
    SELECT MAX(a.pause)
      INTO v_pause
      FROM sys_company_user a
     WHERE a.user_id = pi_userid
       AND a.company_id = pi_company_id;
  
    IF v_pause = 1 OR v_pause = 2 OR v_pause IS NULL THEN
      v_result := 0;
      RETURN v_result;
    END IF;
  
    --0.��ȡ����
    SELECT MAX(a.visible_to_all), MAX(a.expired_time), MAX(a.pause)
      INTO v_i, v_expired_time, v_pause
      FROM sys_company_apply a
     WHERE a.company_id = pi_company_id
       AND a.apply_id = pi_apply_id;
  
    --1.�ж���ҵ��Ӧ�ö���״̬�������Ƿ�ȫԱ�ɼ�
    IF v_i = 1 AND v_expired_time >= v_now AND v_pause = 0 THEN
      v_result := 1;
    
      --2.�ж�Ӧ���Ƿ���û��߹���
    ELSIF v_expired_time < v_now OR v_pause = 1 THEN
    
      v_result := 0;
    
      --3.Ӧ����������£���ȫԱ�ɼ������
    ELSIF v_i = 0 AND v_expired_time >= v_now AND v_pause = 0 THEN
      SELECT MAX(t.company_dept_id)
        INTO v_company_dept_id
        FROM sys_company_user_dept t
       WHERE t.company_id = pi_company_id
         AND t.user_id = pi_userid;
    
      --�ж����õĲ��ſɼ�����Ա�ɼ��Ƿ�����
      SELECT MAX(1)
        INTO v_result
        FROM sys_company_apply_see a
       WHERE a.company_id = pi_company_id
         AND a.apply_id = pi_apply_id
         AND (a.apply_see_type = '1' AND EXISTS
              (SELECT t.company_dept_id
                 FROM sys_company_dept t
                WHERE t.company_id = a.company_id
                  AND t.company_dept_id = a.data_id
                  AND t.pause = 0
                START WITH t.company_dept_id = v_company_dept_id
               CONNECT BY PRIOR t.parent_id = t.company_dept_id) OR
              a.apply_see_type = '2' AND EXISTS
              (SELECT 1
                 FROM sys_company_user n
                WHERE n.company_id = a.company_id
                  AND n.user_id = a.data_id
                  AND n.pause = 0));
    
    END IF;
  
    IF v_result IS NULL THEN
      v_result := 0;
    END IF;
  
    RETURN v_result;
  
  END f_userhasaction_app_see;
  /*
    �����ں�����ҵ��ŵı�������Ϊ�����֣������ͻ��޲����ĳ���
  */
  FUNCTION f_getkeyid_number(pi_table_name  VARCHAR2,
                             pi_column_name VARCHAR2,
                             pi_company_id  VARCHAR2) RETURN VARCHAR2 IS
    p_length INT;
    p_id     NUMBER(38);
    p_sql    VARCHAR2(4000);
    --p_result VARCHAR2(50);
  BEGIN
    SELECT MAX(decode(data_type, 'NUMBER', data_precision, data_length))
      INTO p_length
      FROM user_tab_columns
     WHERE table_name = upper(pi_table_name)
       AND column_name = upper(pi_column_name);
  
    p_sql := 'select max(' || pi_column_name || ') from ' || pi_table_name ||
             ' where company_id=''' || pi_company_id ||
             '''and regexp_like(' || pi_column_name ||
             ' ,''^[0-9]+[0-9]$'') ';
    EXECUTE IMMEDIATE p_sql
      INTO p_id;
    IF length(p_id) > p_length THEN
      RETURN NULL;
    END IF;
  
    RETURN to_char(nvl(p_id, 0) + 1);
  
  EXCEPTION
    WHEN OTHERS THEN
      dbms_output.put_line(p_sql);
      raise_application_error(-20002, SQLERRM);
      RETURN NULL;
  END;
  /*============================================*
  * Author   : CZH
  * Created  : 2020-09-12 16:57:42
  * ALERTER  : 
  * ALERTER_TIME  : 
  * Purpose  : ������̨���е���Ϊƽ̨ͳһ��������Ψһ�룬�Ҳ��ɸ��ġ�
  * Obj_Name    : P_GETKEYCODE
  * Arg_Number  : 3
  * pi_pre : ǰ׺
  * pi_seqname : ������
  * pi_seqnum : �������ֵ��������ݿ����Ѵ������У�����Ҫ��д��ֵ�����������д��
  *============================================*/
  FUNCTION f_getkeyid_plat(pi_pre     VARCHAR2,
                           pi_seqname VARCHAR2,
                           pi_seqnum  NUMBER DEFAULT NULL) RETURN VARCHAR2 IS
  
    p_pre               VARCHAR2(20) := upper(pi_pre); --ǰ׺ ��̬
    p_seqname           VARCHAR2(100) := pi_seqname; --�������� ��̬  seq_plat_code
    p_seqnum            NUMBER := pi_seqnum; --����λ�� 0~99 ���ֵ
    v_max_value         NUMBER;
    v_code              VARCHAR2(1000); --���ɱ���
    v_date              VARCHAR2(30); --������
    v_seconds           NUMBER; --ʱ����ת��=����
    v_current_timestamp VARCHAR2(30); --ʱ�����ȡ����
    v_seqno             VARCHAR2(100); --����
    v_flag              NUMBER;
  BEGIN
    /*
    ���ݱ��룺ƽ̨��Ψһ��ƽ̨���е���Ϊƽ̨ͳһ��������Ψһ�룬�Ҳ��ɸ��ġ�
    ���ɹ��򣺵�������ǰ2λ��д��ĸ���磺HZ��+������6λ���磺200921��+ʱ����5λ����ʱ����ת��Ϊ����㣩+����3λ+2λ���У�����00~99��
    */
    /*    RETURN scmdata.f_getkeyid_plat(pi_pre     => pi_pre,
    pi_seqname => pi_seqname,
    pi_seqnum  => pi_seqnum);*/
  
    --1.������6λ
    SELECT substr(to_char(SYSDATE, 'YYYYMMDD'), 3, 8)
      INTO v_date
      FROM dual;
    --2.ʱ����5λ
    SELECT to_number(substr(to_char(SYSDATE, 'HH24:MI:SS'), 0, 2)) * 60 * 60 +
           
           to_number(substr(to_char(SYSDATE, 'HH24:MI:SS'), 4, 2)) * 60 +
           
           to_number(substr(to_char(SYSDATE, 'HH24:MI:SS'), 7, 2))
      INTO v_seconds
      FROM dual;
    --3.����3λ
    SELECT to_char(current_timestamp, 'ff3')
      INTO v_current_timestamp
      FROM dual;
    --У�����������Ƿ�Ϊ��
    IF p_seqname IS NULL THEN
      raise_application_error(-20002, '����д��������');
    END IF;
    --�жϴ������Ƿ����
    SELECT COUNT(1)
      INTO v_flag
      FROM all_sequences a
     WHERE a.sequence_name = upper(p_seqname);
  
    IF v_flag > 0 THEN
      --4.�������� 
      EXECUTE IMMEDIATE 'SELECT scmdata.' || p_seqname ||
                        '.nextval FROM dual'
        INTO v_seqno;
    ELSE
      --����������
      --У���������ֵ�Ƿ�Ϊ��
      IF p_seqnum IS NULL THEN
        raise_application_error(-20002, '����д�������ֵ');
      END IF;
    
      EXECUTE IMMEDIATE 'create sequence scmdata.' || p_seqname ||
                        ' minvalue 0 maxvalue ' || p_seqnum ||
                        ' start with 0 increment by 1 cache 2 cycle';
    
      EXECUTE IMMEDIATE 'SELECT scmdata.' || p_seqname ||
                        '.nextval FROM dual'
        INTO v_seqno;
    END IF;
    --��ȡ�������ֵλ��
    SELECT length(a.max_value)
      INTO v_max_value
      FROM all_sequences a
     WHERE a.sequence_name = upper(p_seqname)
       AND a.sequence_owner = 'SCMDATA';
  
    v_seqno := lpad(v_seqno, v_max_value, '0');
  
    --���ɱ��
    SELECT p_pre || v_date || v_seconds || v_current_timestamp || v_seqno
      INTO v_code
      FROM dual;
  
    RETURN v_code;
  
  END f_getkeyid_plat;

  /*============================================*
  * Author   : CZH
  * Created  : 2020-09-12 16:57:42
  * ALERTER  : 
  * ALERTER_TIME  : 
  * Purpose  : �����ں�����ҵ��ŵı����磺��ȡ��ͬ��ҵ�Ĺ�Ӧ�̱��� �������ǰ׺ + ��ˮ��
  * Obj_Name    : F_GETKEYCODE
  * Arg_Number  : 5
  * PI_TABLE_NAME : ����
  * PI_COLUMN_NAME : ����
  * PI_COMPANY_ID : ��˾���
  * PI_PRE : ǰ׺
  * PI_SERAIL_NUM :  ��ˮ�ų���
  *============================================*/

  FUNCTION f_getkeycode(pi_table_name  VARCHAR2, --����
                        pi_column_name VARCHAR2, --����
                        pi_company_id  VARCHAR2, --��˾���
                        pi_pre         VARCHAR2, --ǰ׺
                        pi_serail_num  NUMBER) RETURN VARCHAR2 IS
    --��ˮ�ų���
    /*    pi_table_name  VARCHAR2(250) := 't_supplier_info'; 
    pi_column_name VARCHAR2(250) := 'supplier_code'; 
    pi_company_id  VARCHAR2(250) := 'a972dd1ffe3b3a10e0533c281cac8fd7'; 
    pi_pre         VARCHAR2(250) := 'C'; 
    pi_serail_num  NUMBER := 5;*/
    p_length INT;
    p_id     NUMBER(38);
    p_sql    VARCHAR2(4000);
    p_result VARCHAR2(50);
  BEGIN
    SELECT MAX(decode(data_type, 'NUMBER', data_precision, data_length))
      INTO p_length
      FROM user_tab_columns
     WHERE table_name = upper(pi_table_name)
       AND column_name = upper(pi_column_name);
  
    --dbms_output.put_line(p_length);
  
    p_sql := 'SELECT nvl(MAX(v.tcode), 0)
  FROM (SELECT DISTINCT MAX(to_number(substr(' ||
             pi_column_name || ',
                                             nvl(length(''' ||
             pi_pre ||
             '''), 0) + 1,
                                             length(''' ||
             pi_column_name || ''')))) over(PARTITION BY substr(' ||
             pi_column_name || ', 0, nvl(length(''' || pi_pre ||
             '''), 0))) tcode
          FROM ' || pi_table_name || ' 
         WHERE company_id = ''' || pi_company_id || '''
           AND ' || pi_column_name || ' IS NOT NULL
           AND substr(' || pi_column_name ||
             ', 0, nvl(length(''' || pi_pre || '''), 0)) = ''' || pi_pre || '''
           AND regexp_like(substr(' || pi_column_name || ',
                                  nvl(length(''' || pi_pre ||
             '''), 0) + 1,
                                  length(''' || pi_column_name ||
             ''')),' || '''^[0-9]+[0-9]$''' || ')) v';
  
    --dbms_output.put_line(p_sql);
  
    EXECUTE IMMEDIATE p_sql
      INTO p_id;
  
    IF (length(pi_pre) +
       length(lpad(to_char(p_id + 1), pi_serail_num, '0'))) > p_length THEN
      dbms_output.put_line('�����ֶ��L��');
      raise_application_error(-20002, SQLERRM);
    END IF;
  
    p_result := pi_pre || lpad(to_char(p_id + 1), pi_serail_num, '0');
  
    /*dbms_output.put_line(pi_pre ||
    lpad(to_char(p_id + 1), pi_serail_num, '0'));*/
  
    RETURN p_result;
    /*dbms_output.put_line(pi_pre ||
    lpad(to_char(p_id + 1), pi_serail_num, '0'));*/
  
  EXCEPTION
    WHEN OTHERS THEN
      --dbms_output.put_line(p_sql);
      raise_application_error(-20002, SQLERRM);
      RETURN NULL;
  END f_getkeycode;

  FUNCTION f_getnewsys_app_priv_id(pi_parent_priv_id VARCHAR2)
    RETURN VARCHAR2 IS
    v_priv_id VARCHAR2(32);
    v_suffix  VARCHAR2(32);
    v_number  NUMBER(32);
    v_flag    NUMBER(1);
  BEGIN
  
    IF pi_parent_priv_id = '0' THEN
    
      SELECT MAX(to_number(substr(a.priv_id, 2, 32)))
        INTO v_number
        FROM sys_app_privilege a
       WHERE a.parent_priv_id = 'root';
    
      IF v_number IS NOT NULL THEN
        v_number := v_number + 1;
      ELSE
        v_number := 0;
      END IF;
      v_priv_id := 'P' || lpad(v_number, 3, '0');
    
    ELSE
      SELECT MAX(to_number(substr(a.priv_id, length(a.priv_id) - 1, 2)))
        INTO v_number
        FROM sys_app_privilege a
       WHERE a.parent_priv_id = pi_parent_priv_id;
      --dbms_output.put_line(v_number);
      IF v_number IS NOT NULL THEN
        IF v_number = 99 THEN
          raise_application_error(-20002,
                                  '����Ѵﵽ99���޷����Զ�����,��Ҫ����Ա�������');
        END IF;
        v_suffix := lpad(v_number + 1, 2, '0');
        --zwh73 20220927  begin
        SELECT nvl(MAX(1), 0)
          INTO v_flag
          FROM scmdata.sys_app_privilege a
         WHERE a.priv_id = pi_parent_priv_id || v_suffix;
        IF v_flag = 1 THEN
          SELECT MAX(to_number(substr(a.priv_id, length(a.priv_id) - 1, 2)))
            INTO v_number
            FROM sys_app_privilege a
           WHERE a.priv_id LIKE pi_parent_priv_id || '%';
          IF v_number = 99 THEN
            raise_application_error(-20002,
                                    '����Ѵﵽ99���޷����Զ�����,��Ҫ����Ա�������');
          END IF;
          v_suffix := lpad(v_number + 1, 2, '0');
        
        END IF;
        --dbms_output.put_line(v_suffix);
        --zwh73 20220927  end 
      ELSE
        v_suffix := to_char(v_number) || '01';
      END IF;
      v_priv_id := pi_parent_priv_id || v_suffix;
    END IF;
  
    RETURN v_priv_id;
  
  END;

  /*
  ������Ϣʱ���ã�����ƴ����Ϣjson
  */
  FUNCTION f_get_msg_text_msg(pi_msg_content VARCHAR2,
                              pi_msg_type    VARCHAR2,
                              pi_object_id   VARCHAR2) RETURN VARCHAR2 IS
    p_text_json_result VARCHAR2(500);
  
  BEGIN
    p_text_json_result := pi_msg_type;
    IF pi_object_id IS NULL THEN
      p_text_json_result := '{"Text":"' || pi_msg_content || '"}';
    ELSE
      p_text_json_result := '{"Text":"' || pi_msg_content ||
                            '","FlReqAddr":{"needGps":0,"dataAddr":"' ||
                            '/ui/node/' || pi_object_id ||
                            '?origin=hint","varType":0,"varList":null,"isAsync":false,"reqType":"get","timeOut":null,"addrType":0}}';
    END IF;
    RETURN p_text_json_result;
  END f_get_msg_text_msg;

  /*============================================*
  * Author   : zwh73
  * Created  : 2020-08-14 14:01:53
  * Purpose  : ����ϵͳ��Ϣ
  * Obj_Name    : P_SYS_MSG
  * Arg_Number  : 7
  * PI_MSG_CONTENT :��Ϣ����
  * PI_MSG_TITLE :��Ϣ���⣬����Ĭ�ϡ��ޱ��⡮
  * PI_TARGET_USER :��ȡ�û���Ϊ��ʱΪȺ������Ϊ�����ǵ���
                    ע���ò��������ԡ�HX87,CMS3'����'HX87'����ʽ������У��ܾ�����ʽ���������
  * PI_SENDER_NAME :���������ƣ�����������д������Ĭ�ϡ�system��
  * PI_APP_ID :appid��������Ĭ�ϡ�scm��
  * PI_MSG_TYPE :  ��Ϣ���ͣ�S��System������ϵͳ��Ϣ����ɫ����ͼ�ꡢû�С�����������ť��
                             T��Todo������hint��Ϣ����ɫ����ͼ�ꡢ�С�����������ť��
                             ע������У��ܾ��������������������
  * PI_OBJECT_ID :����hint��Ϣʱ��Ҫ��Ϊ��������ť��ת����node_id
  *============================================*/
  PROCEDURE p_sys_msg(pi_msg_content IN VARCHAR2,
                      pi_msg_title   IN VARCHAR2,
                      pi_target_user IN VARCHAR2,
                      pi_sender_name IN VARCHAR2,
                      pi_app_id      IN VARCHAR2,
                      pi_msg_type    IN VARCHAR2,
                      pi_object_id   IN VARCHAR2) IS
    p_send_type   VARCHAR2(1);
    p_msg_content VARCHAR2(500);
    p_obj_type    VARCHAR2(20);
    p_i           NUMBER(1);
  BEGIN
    IF pi_target_user IS NULL THEN
      p_send_type := '0';
    ELSE
      p_send_type := '1';
      --��֤target_name�����밴'HX87,CMS3'����ʽ����
      SELECT nvl(MAX(1), 0)
        INTO p_i
        FROM dual
       WHERE regexp_like(pi_target_user, '^([a-zA-Z0-9]+[,]?)+$');
      IF p_i = 0 THEN
        raise_application_error(-20002,
                                '������Ϣʧ�ܣ������ռ��˴�������ϵ����Ա');
      END IF;
    END IF;
    IF pi_msg_type = 'S' THEN
      p_msg_content := scmdata.pkg_plat_comm.f_get_msg_text_msg(pi_msg_content,
                                                                pi_msg_type,
                                                                NULL);
      p_obj_type    := 'system';
    ELSIF pi_msg_type = 'T' THEN
      p_obj_type := 'hint';
      IF pi_object_id IS NOT NULL THEN
        p_msg_content := scmdata.pkg_plat_comm.f_get_msg_text_msg(pi_msg_content,
                                                                  pi_msg_type,
                                                                  pi_object_id);
      ELSE
        p_msg_content := scmdata.pkg_plat_comm.f_get_msg_text_msg(pi_msg_content,
                                                                  pi_msg_type,
                                                                  NULL);
      END IF;
    ELSE
      raise_application_error(-20002,
                              '������Ϣʧ�ܣ���֧�ֵ���Ϣ���ͣ�����ϵ����Ա');
    END IF;
    INSERT INTO nbw.msg_info
      (msg_id, send_type, message_info, receivers, urgent, send_state,
       object_id, object_type, msg_desc, app_id, title, sender)
    VALUES
      (f_get_uuid(), p_send_type, p_msg_content, upper(pi_target_user), '0',
       NULL, NULL, p_obj_type, nvl(pi_msg_title, '�ޱ���'),
       nvl(pi_app_id, 'scm'), nvl(pi_msg_title, '�ޱ���'),
       nvl(pi_sender_name, 'system'));
  END;
  --�û��ֻ�ע��
  PROCEDURE p_user_register(pi_moblie       IN VARCHAR2,
                            pi_uuid         IN VARCHAR2,
                            pi_devicesystem IN VARCHAR2) IS
    p_num NUMBER(1);
  BEGIN
  
    SELECT COUNT(1)
      INTO p_num
      FROM scmdata.sys_user su
     WHERE su.phone = pi_moblie;
    IF p_num > 0 THEN
      raise_application_error(-20002,
                              '.�ֻ���:[' || pi_moblie || ']����ƽ̨ע�ᣬ������ֻ��ţ�');
    END IF;
  
    INSERT INTO scmdata.sys_user
      (user_id, avatar, user_account, password, nick_name, pause, user_type,
       create_time, phone, id_status, update_time)
    VALUES
      (f_get_uuid(), NULL, pi_moblie,
       'f3d799fcc6ddbfcffd93ddf8fb88f39cadd55e', pi_moblie, 0, 'user',
       SYSDATE, pi_moblie, 0, SYSDATE);
  END;

  --��ҵ�Ƿ���Ӧ��
  FUNCTION f_company_has_app(pi_company_id IN VARCHAR2,
                             pi_apply_id   IN VARCHAR2) RETURN NUMBER IS
    p_i INT;
  BEGIN
    SELECT nvl(MAX(1), 0)
      INTO p_i
      FROM scmdata.sys_company_apply
     WHERE company_id = pi_company_id
       AND expired_time > SYSDATE
       AND pause = 0
       AND apply_id = pi_apply_id;
    RETURN p_i;
  END;

  /*============================================*
  * Author   : CZH
  * Created  : 2022-05-18 16:12:06
  * ALERTER  : 
  * ALERTER_TIME  : 
  * Purpose  : ͨ����ͣ
  * Obj_Name    : P_PAUSE
  * Arg_Number  : 5
  * < IN PARAMS >  
  * P_TABLE : ��
  * P_PAUSE_FIELD : ��ͣ�ֶ���
  * P_WHERE : ����
  * P_USER_ID : �޸���
  * P_STATUS : ��ͣ״̬
  *============================================*/

  PROCEDURE p_pause(p_table       IN VARCHAR2,
                    p_pause_field IN VARCHAR2 DEFAULT 'pause',
                    p_where       IN VARCHAR2,
                    p_user_id     IN VARCHAR2 DEFAULT 'ADMIN',
                    p_status      IN VARCHAR2) IS
    v_status  NUMBER;
    pause_exp EXCEPTION;
  BEGIN
    EXECUTE IMMEDIATE 'SELECT ' || p_pause_field || ' FROM scmdata.' ||
                      p_table || p_where
      INTO v_status;
  
    IF p_status <> nvl(v_status, 0) THEN
      --dbms_output.put_line(SYSDATE);
      EXECUTE IMMEDIATE 'UPDATE scmdata.' || p_table || ' SET ' ||
                        p_pause_field || ' = ' || p_status ||
                        q'[, update_id = ']' || p_user_id ||
                        q'[',update_time = SYSDATE ]' || p_where;
    ELSE
      --�����ظ�����ʾ��Ϣ 
      RAISE pause_exp;
    END IF;
  EXCEPTION
    WHEN pause_exp THEN
      sys_raise_app_error_pkg.is_running_error(p_err_msg          => '�����ظ���������',
                                               p_is_running_error => 'F');
    WHEN OTHERS THEN
      sys_raise_app_error_pkg.is_running_error(p_is_running_error => 'T',
                                               p_is_log           => 1);
  END p_pause;

  /*============================================*
  * Author   : CZH
  * Created  : 2022-05-18 09:39:23
  * ALERTER  : 
  * ALERTER_TIME  : 
  * Purpose  : ��ɫת����ʨƽ̨��ɫֵ  ʮ������RGB��ɫ�� =��תʮ������BGR��ɫ��=> תʮ����  
  * Obj_Name    : F_RGB_TO_BGR_VAL
  * Arg_Number  : 1
  * < IN PARAMS >  
  * P_RGB : ʮ��������ɫ��
  * < OUT PARAMS > 
  * REURN NUMBER: ��ʨƽ̨��ɫֵ
  *============================================*/

  FUNCTION f_rgb_to_bgr_val(p_rgb VARCHAR2) RETURN NUMBER IS
    v_rgb VARCHAR2(6) := p_rgb;
    v_r   VARCHAR2(2);
    v_g   VARCHAR2(2);
    v_b   VARCHAR2(2);
    v_bgr NUMBER;
  BEGIN
    v_r   := substr(v_rgb, 1, 2);
    v_g   := substr(v_rgb, 3, 2);
    v_b   := substr(v_rgb, 5, 2);
    v_bgr := to_number(v_b || v_g || v_r, 'xxxxxx');
    RETURN v_bgr;
  END f_rgb_to_bgr_val;

  /*============================================*
  * Author   : CZH
  * Created  : 2022-05-18 09:40:10
  * ALERTER  : 
  * ALERTER_TIME  : 
  * Purpose  :  ��΢��Ϣ��������
  * Obj_Name    : SEND_WX_MSG
  * Arg_Number  : 8
  * < IN PARAMS >  
  * P_COMPANY_ID : ��ҵID
  * P_MSGTYPE : ��Ϣ���� Ĭ�� text
  * P_MSG_TITLE : ��Ϣͷ
  * P_MSG_BODY : ��Ϣ��
  * P_SENDER : ������
  * P_VAL_STEP : �ָ���
  * P_BOT_KEY : ������KEY
  * P_ROBOT_TYPE : ����������
  * < OUT PARAMS >  
  * RETURN CLOB : ������Ϣƴ��sql
  *============================================*/

  FUNCTION send_wx_msg(p_company_id VARCHAR2,
                       p_msgtype    VARCHAR2 DEFAULT 'text',
                       p_msg_title  VARCHAR2,
                       p_msg_body   CLOB,
                       p_sender     CLOB,
                       p_val_step   VARCHAR2 DEFAULT ';',
                       p_bot_key    VARCHAR2,
                       p_robot_type VARCHAR2) RETURN CLOB IS
    v_wx_sql CLOB;
    --v_msgtype        VARCHAR2(48);
    v_msg            CLOB;
    v_sender         CLOB;
    v_default_sender CLOB;
    v_content_type   VARCHAR(32);
  BEGIN
    --v_msgtype := p_msgtype; 
    --��ȡĬ�Ͻ�����
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
  
    --���� v_msgtype ��д��Ϣ�� Ŀǰ����text
  
    v_msg := '���⣺' || p_msg_title || chr(13) || '���ݣ�' || p_msg_body ||
             chr(13) || '�����ˣ�' || v_sender || chr(13) || '����ʱ�䣺' ||
             to_char(SYSDATE, 'yyyy-mm-dd hh:mi:ss');
  
    v_wx_sql := 'select ''' || p_msgtype || ''' MSGTYPE,
                        ''' || v_msg || ''' ' ||
                v_content_type || ' ,
                        ''' || p_bot_key ||
                ''' key 
                from dual';
  
    RETURN v_wx_sql;
  
  END send_wx_msg;

  /*============================================*
  * Author   : CZH
  * Created  : 2022-05-18 09:51:56
  * ALERTER  : 
  * ALERTER_TIME  : 
  * Purpose  : ��ȡƽ̨�ֵ����ҵ�ֵ�ֵ
  * Obj_Name    : F_GET_PLATORCOMPANY_DICT
  * Arg_Number  : 4
  * < IN PARAMS >  
  * P_TYPE : �ֵ�����
  * P_VALUE : �ֵ����
  * P_COMPANY_ID : ��ҵID ѡ��
  * P_IS_COMPANY_DICT : �Ƿ���ҵ�ֵ�
  * < OUT PARAMS >
  * RETURN VARCHAR2 : �ֵ�ֵ
  *============================================*/

  FUNCTION f_get_platorcompany_dict(p_type            VARCHAR2,
                                    p_value           VARCHAR2,
                                    p_company_id      VARCHAR2 DEFAULT NULL,
                                    p_is_company_dict INT) RETURN VARCHAR2 IS
    v_name VARCHAR2(1000);
  BEGIN
    IF p_is_company_dict = 0 THEN
      SELECT MAX(t.group_dict_name)
        INTO v_name
        FROM scmdata.sys_group_dict t
       WHERE t.group_dict_type = p_type
         AND t.group_dict_value = p_value
         AND t.pause = 0;
    ELSIF p_is_company_dict = 1 THEN
      IF p_company_id IS NULL THEN
        raise_application_error(-20002,
                                '����p_is_company_dictΪ1ʱ��p_company_id������飡');
      END IF;
      SELECT MAX(t.company_dict_name)
        INTO v_name
        FROM scmdata.sys_company_dict t
       WHERE t.company_dict_type = p_type
         AND t.company_dict_value = p_value
         AND t.company_id = p_company_id;
    ELSE
      NULL;
    END IF;
    RETURN v_name;
  END f_get_platorcompany_dict;

  /*============================================*
  * Author   : CZH
  * Created  : 2022-05-25 11:48:31
  * ALERTER  : 
  * ALERTER_TIME  : 
  * Purpose  :  ��ȡԱ������
  * Obj_Name    : F_GET_USERNAME
  * Arg_Number  : 4
  * < IN PARAMS >  
  * P_USER_ID : Ա��ID
  * P_COMPANY_ID : ��ҵID ��ѡ�Ĭ��Ϊ��
  * P_IS_COMPANY_USER : �Ƿ���ҵԱ����ѡ� Ĭ��Ϊ 0
  *                     0����1����  
  * P_IS_MUTIVAL : �Ƿ񷵻ض�ֵ ��ѡ� Ĭ��Ϊ0 
  *               0����1���� 
  * < OUT PARAMS > 
  * RETURN VARCHAR2 : Ա������
  *============================================*/

  FUNCTION f_get_username(p_user_id         VARCHAR2,
                          p_company_id      VARCHAR2 DEFAULT NULL,
                          p_is_company_user INT DEFAULT 0,
                          p_is_mutival      INT DEFAULT 0,
                          p_spilt           VARCHAR2 DEFAULT ';')
    RETURN VARCHAR2 IS
    v_name VARCHAR2(256);
  BEGIN
    IF p_is_company_user = 0 THEN
      IF p_is_mutival = 0 THEN
        SELECT MAX(nvl(u.nick_name, nvl(u.username, u.user_account)))
          INTO v_name
          FROM scmdata.sys_user u
         WHERE u.user_id = p_user_id;
      ELSE
        SELECT listagg(nvl(u.nick_name, nvl(u.username, u.user_account)),
                       p_spilt)
          INTO v_name
          FROM scmdata.sys_user u
         WHERE instr(p_user_id, u.user_id) > 0;
      END IF;
    ELSIF p_is_company_user = 1 THEN
      IF p_company_id IS NULL THEN
        raise_application_error(-20002,
                                '����p_is_company_userΪ1ʱ��p_company_id������飡');
      ELSE
        IF p_is_mutival = 0 THEN
          SELECT MAX(nvl(u.nick_name, nvl(u.company_user_name, u.phone)))
            INTO v_name
            FROM scmdata.sys_company_user u
           WHERE u.user_id = p_user_id
             AND u.company_id = p_company_id;
        ELSE
          SELECT listagg(nvl(u.nick_name, nvl(u.company_user_name, u.phone)),
                         p_spilt)
            INTO v_name
            FROM scmdata.sys_company_user u
           WHERE instr(p_user_id, u.user_id) > 0
             AND u.company_id = p_company_id;
        END IF;
      END IF;
    ELSE
      NULL;
    END IF;
    RETURN v_name;
  END f_get_username;
  /*============================================*
  * Author   : CZH
  * Created  : 2022-05-25 14:32:11
  * ALERTER  : 
  * ALERTER_TIME  : 
  * Purpose  : ��ȡ��Ӧ������
  * Obj_Name    : F_GET_SUP_NAME
  * Arg_Number  : 4
  * < IN PARAMS >  
  * P_COMPANY_ID : ��ҵID
  * P_SUP_CODE : ��Ӧ�̱���/�ڲ�����
  * P_IS_INNER_CODE : �Ƿ�ʹ���ڲ����룬Ĭ��Ϊ0 ��ʹ�õ������
  *                   0����  1����
  * P_IS_SHORT_NAME : �Ƿ񷵻ؼ�� ��Ĭ��Ϊ0 ������ȫ��
  *                 0���� 1����
  * < OUT PARAMS >  
  * RETURN VARCHAR2: ��Ӧ������
  *============================================*/

  FUNCTION f_get_sup_name(p_company_id    VARCHAR2,
                          p_sup_code      VARCHAR2,
                          p_is_inner_code INT DEFAULT 0,
                          p_is_short_name INT DEFAULT 0) RETURN VARCHAR2 IS
    v_sup_name VARCHAR2(256);
  BEGIN
    IF p_is_inner_code = 0 THEN
      SELECT decode(p_is_short_name,
                    0,
                    MAX(t.supplier_company_name),
                    MAX(t.supplier_company_abbreviation))
        INTO v_sup_name
        FROM scmdata.t_supplier_info t
       WHERE t.company_id = p_company_id
         AND t.supplier_code = p_sup_code;
    ELSIF p_is_inner_code = 1 THEN
      SELECT decode(p_is_short_name,
                    0,
                    MAX(t.supplier_company_name),
                    MAX(t.supplier_company_abbreviation))
        INTO v_sup_name
        FROM scmdata.t_supplier_info t
       WHERE t.company_id = p_company_id
         AND t.inside_supplier_code = p_sup_code;
    ELSE
      NULL;
    END IF;
    RETURN v_sup_name;
  END f_get_sup_name;

  /*============================================*
  * Author   : CZH
  * Created  : 2022-05-25 14:35:21
  * ALERTER  : 
  * ALERTER_TIME  : 
  * Purpose  : ��ȡ����
  * Obj_Name    : F_GET_COMPANY_DEPTNAME
  * Arg_Number  : 2
  * < IN PARAMS >  
  * P_COMPANY_ID : ��ҵID
  * P_DEPT_ID : ����ID
  * < OUT PARAMS > 
  * RETURN VARCHAR2 : ��������
  *============================================*/

  FUNCTION f_get_company_deptname(p_company_id VARCHAR2,
                                  p_dept_id    VARCHAR2) RETURN VARCHAR2 IS
    v_dept_name VARCHAR2(256);
  BEGIN
    SELECT MAX(t.dept_name)
      INTO v_dept_name
      FROM scmdata.sys_company_dept t
     WHERE t.pause = 0
       AND t.company_dept_id = p_dept_id
       AND t.company_id = p_company_id;
    RETURN v_dept_name;
  END f_get_company_deptname;

  /*============================================*
  * Author   : CZH
  * Created  : 16-5�� -22
  * ALERTER  :
  * ALERTER_TIME  :
  * Purpose  : ��ѯƽ̨������־
  * Obj_Name    : F_QUERY_T_PROGRESS_LOG
  *============================================*/

  FUNCTION f_query_t_plat_log(p_apply_pk_id      VARCHAR2,
                              p_dict_type        VARCHAR2,
                              p_is_flhide_fileds INT DEFAULT 0) RETURN CLOB IS
    v_sql CLOB;
  BEGIN
    v_sql := 'SELECT a.group_dict_name log_type,
           decode(' || p_is_flhide_fileds ||
             ',1,nvl(t.log_msg_f,t.log_msg),0,t.log_msg,t.log_msg) log_msg,
           nvl(su.nick_name,
           nvl(su.username,
               nvl(u.nick_name, nvl(u.company_user_name, su.user_account)))) operator_name,
           fu.logn_name operator,
           t.update_time operate_time
      FROM t_plat_log t 
      LEFT JOIN scmdata.sys_group_dict a
        ON a.group_dict_type = ''' || p_dict_type || '''
       AND a.group_dict_value = t.log_type
      LEFT JOIN scmdata.sys_user su on upper(su.user_id) = upper(t.operater)
      LEFT JOIN scmdata.sys_company_user u 
        ON u.user_id = t.operater
       AND u.company_id = t.operate_company_id
      LEFT JOIN scmdata.sys_company fu
        ON fu.company_id = nvl(t.operate_company_id,''b6cc680ad0f599cde0531164a8c0337f'')
     WHERE t.apply_pk_id = ''' || p_apply_pk_id || '''
     ORDER BY t.update_time DESC';
  
    RETURN v_sql;
  END f_query_t_plat_log;

  /*============================================*
  * Author   : CZH
  * Created  : 16-5�� -22
  * ALERTER  :
  * ALERTER_TIME  :
  * Purpose  : ���ݷָ�����֣���ȡ�ָ���ǰ���ַ���
  * Obj_Name    : F_GET_VAL_BY_DELIMIT
  *============================================*/
  FUNCTION f_get_val_by_delimit(p_character VARCHAR2,
                                p_separate  CHAR,
                                p_is_pre    INT DEFAULT 1) RETURN VARCHAR2 IS
    v_val VARCHAR2(4000);
  BEGIN
    IF p_is_pre = 1 THEN
      v_val := substr(p_character,
                      1,
                      instr(p_character, p_separate, -1) - 1);
    ELSIF p_is_pre = 0 THEN
      v_val := substr(p_character, instr(p_character, p_separate, -1) + 1);
    ELSE
      v_val := NULL;
    END IF;
    RETURN v_val;
  END f_get_val_by_delimit;

  /*============================================*
  * Author   : CZH
  * Created  : 16-5�� -22
  * ALERTER  :
  * ALERTER_TIME  :
  * Purpose  :   asscoate data_sql
  * ��ȡpkid��rest������POST;DELETE;PUT;GET��,��̬����
  * sup123/ALL;GET;POST;PUT;DELETE?PARAM1&PARAM2
  * Obj_Name    : P_GET_REST_VAL_METHOD_PARAMS
  *============================================*/
  PROCEDURE p_get_rest_val_method_params(p_character     VARCHAR2,
                                         po_pk_id        OUT VARCHAR2,
                                         po_rest_methods OUT VARCHAR2,
                                         po_params       OUT VARCHAR2) IS
    vo_pkid    VARCHAR2(256);
    vo_methods VARCHAR2(256);
    vo_params  VARCHAR2(256);
  BEGIN
    IF instr(p_character, '/') > 0 THEN
      vo_pkid := f_get_val_by_delimit(p_character => p_character,
                                      p_separate  => '/',
                                      p_is_pre    => 1);
    
      IF instr(p_character, '?') > 0 THEN
        vo_methods := f_get_val_by_delimit(p_character => p_character,
                                           p_separate  => '/',
                                           p_is_pre    => 0);
        vo_methods := f_get_val_by_delimit(p_character => vo_methods,
                                           p_separate  => '?',
                                           p_is_pre    => 1);
      
        vo_params := f_get_val_by_delimit(p_character => p_character,
                                          p_separate  => '?',
                                          p_is_pre    => 0);
      ELSE
        vo_methods := f_get_val_by_delimit(p_character => p_character,
                                           p_separate  => '/',
                                           p_is_pre    => 0);
        vo_params  := NULL;
      END IF;
    ELSE
      vo_pkid    := NULL;
      vo_methods := NULL;
      vo_params  := NULL;
    END IF;
  
    po_pk_id        := vo_pkid;
    po_rest_methods := vo_methods;
    po_params       := vo_params;
  
  END p_get_rest_val_method_params;

  /*============================================*
  * Author   : CZH
  * Created  : 16-5�� -22
  * ALERTER  :
  * ALERTER_TIME  :
  * Purpose  :  asscoate data_sql
  * ��ȡpkid��rest������POST;DELETE;PUT;GET��,��̬����
  * sup123/ALL;GET;POST;PUT;DELETE?PARAM1&PARAM2
  * p_rtn_type:1������  2������  3.����
  * Obj_Name    : F_GET_REST_VAL_METHOD_PARAMS
  *============================================*/
  FUNCTION f_get_rest_val_method_params(p_character VARCHAR2,
                                        p_rtn_type  INT) RETURN VARCHAR2 IS
    vo_pkid    VARCHAR2(256);
    vo_methods VARCHAR2(256);
    vo_params  VARCHAR2(256);
  BEGIN
    IF p_rtn_type = 1 THEN
      IF instr(p_character, '/') > 0 THEN
        vo_pkid := f_get_val_by_delimit(p_character => p_character,
                                        p_separate  => '/',
                                        p_is_pre    => 1);
      ELSE
        vo_pkid := NULL;
      END IF;
      RETURN vo_pkid;
    ELSIF p_rtn_type = 2 THEN
      IF instr(p_character, '/') > 0 THEN
        vo_methods := f_get_val_by_delimit(p_character => p_character,
                                           p_separate  => '/',
                                           p_is_pre    => 0);
      
        IF instr(vo_methods, '?') > 0 THEN
          vo_methods := f_get_val_by_delimit(p_character => vo_methods,
                                             p_separate  => '?',
                                             p_is_pre    => 1);
        END IF;
      ELSE
        vo_methods := NULL;
      END IF;
      RETURN vo_methods;
    ELSIF p_rtn_type = 3 THEN
      IF instr(p_character, '?') > 0 THEN
        vo_params := f_get_val_by_delimit(p_character => p_character,
                                          p_separate  => '?',
                                          p_is_pre    => 0);
      ELSE
        vo_params := NULL;
      END IF;
      RETURN vo_params;
    ELSE
      RETURN NULL;
    END IF;
  END f_get_rest_val_method_params;

  /*============================================*
  * Author   : CZH
  * Created  : 16-5�� -22
  * ALERTER  :
  * ALERTER_TIME  :
  * Purpose  :  ���ݷָ�����ȡ�ַ���֮��Ľ���
  * Obj_Name : F_GET_VARCHAR_INTERSECT
  *============================================*/
  FUNCTION f_get_varchar_intersect(p_str1     VARCHAR2,
                                   p_str2     VARCHAR2,
                                   p_separate VARCHAR2) RETURN VARCHAR2 IS
    v_in_char VARCHAR2(4000);
    v_sql     CLOB;
  BEGIN
    v_sql := q'[SELECT listagg(distinct ID,']' || p_separate ||
             q'[') within group(order by id asc)  
    FROM (SELECT regexp_substr(id, '[^]' || p_separate ||
             q'[]+', 1, rownum) id
            FROM (SELECT :char1 id FROM dual)
          CONNECT BY rownum <= length(regexp_replace(id, '[^]' ||
             p_separate || q'[]+')) + 1
          INTERSECT -- ȡ����
          SELECT regexp_substr(id, '[^]' || p_separate ||
             q'[]+', 1, rownum) id
            FROM (SELECT :char2 id FROM dual)
          CONNECT BY rownum <= length(regexp_replace(id, '[^]' ||
             p_separate || q'[]+')) + 1)]';
    dbms_output.put_line(v_sql);
    EXECUTE IMMEDIATE v_sql
      INTO v_in_char
      USING p_str1, p_str2;
    RETURN v_in_char;
  END f_get_varchar_intersect;

  /*============================================*
  * Author   : CZH
  * Created  : 16-5�� -22
  * ALERTER  :
  * ALERTER_TIME  :
  * Purpose  :  ͨ�����ͻ�ȡlookup sql
  * Obj_Name : F_GET_LOOKUP_SQL_BY_TYPE
  *============================================*/
  FUNCTION f_get_lookup_sql_by_type(p_group_dict_type VARCHAR2,
                                    p_field_value     VARCHAR2,
                                    p_field_desc      VARCHAR2,
                                    p_company_id      VARCHAR2 DEFAULT NULL,
                                    p_is_company_dict INT DEFAULT 0,
                                    p_where_sql       VARCHAR2 DEFAULT NULL)
    RETURN CLOB IS
    v_sql CLOB;
  BEGIN
    IF p_is_company_dict = 0 THEN
      v_sql := q'[SELECT t.group_dict_value ]' || p_field_value ||
               q'[, t.group_dict_name ]' || p_field_desc || q'[
      FROM scmdata.sys_group_dict t
     WHERE t.group_dict_type = ']' || p_group_dict_type || q'['
       AND t.pause = 0]';
    ELSIF p_is_company_dict = 1 THEN
      IF p_company_id IS NULL THEN
        raise_application_error(-20002,
                                '����p_is_company_dictΪ1ʱ��p_company_id������飡');
      END IF;
    
      v_sql := q'[SELECT t.company_dict_value ]' || p_field_value ||
               q'[,t.company_dict_name ]' || p_field_desc || q'[
        FROM scmdata.sys_company_dict t
       WHERE t.company_dict_type = ']' || p_group_dict_type || q'['
         AND t.pause = 0
         AND t.company_id = ']' || p_company_id || q'[']';
    END IF;
    IF p_where_sql IS NOT NULL THEN
      v_sql := 'SELECT * FROM (' || v_sql || ') ' || p_where_sql;
    ELSE
      NULL;
    END IF;
    RETURN v_sql;
  END f_get_lookup_sql_by_type;

  /*============================================*
  * Author   : CZH
  * Created  : 16-5�� -22
  * ALERTER  :
  * ALERTER_TIME  :
  * Purpose  :  �����Ͳ�ѯpick��ͬʱ�ÿ������ֶ�
  * Obj_Name : F_GET_PICKSQL_BY_TYPE
  *============================================*/
  FUNCTION f_get_picksql_by_type(p_group_dict_type   VARCHAR2,
                                 p_dict_value        VARCHAR2,
                                 p_dict_desc         VARCHAR2,
                                 p_is_set_other_fd   INT DEFAULT 0,
                                 p_is_company_dict   INT DEFAULT 0,
                                 p_company_id        VARCHAR2 DEFAULT NULL,
                                 p_setnull_fdvalue_1 VARCHAR2 DEFAULT 'fdvalue_1',
                                 p_setnull_fddesc_1  VARCHAR2 DEFAULT 'fddesc_1',
                                 p_setnull_fdvalue_2 VARCHAR2 DEFAULT 'fdvalue_2',
                                 p_setnull_fddesc_2  VARCHAR2 DEFAULT 'fddesc_2',
                                 p_setnull_fdvalue_3 VARCHAR2 DEFAULT 'fdvalue_3',
                                 p_setnull_fddesc_3  VARCHAR2 DEFAULT 'fddesc_3',
                                 p_setnull_fdvalue_4 VARCHAR2 DEFAULT 'fdvalue_4',
                                 p_setnull_fddesc_4  VARCHAR2 DEFAULT 'fddesc_4',
                                 p_setnull_fdvalue_5 VARCHAR2 DEFAULT 'fdvalue_5',
                                 p_setnull_fddesc_5  VARCHAR2 DEFAULT 'fddesc_5')
    RETURN CLOB IS
    v_sql CLOB;
  BEGIN
    IF p_is_company_dict = 0 THEN
      v_sql := q'[SELECT t.group_dict_value ]' || p_dict_value || q'[,
           t.group_dict_name  ]' || p_dict_desc || (CASE
                 WHEN p_is_set_other_fd = 1 THEN
                  q'[,
           NULL               ]' || p_setnull_fdvalue_1 || q'[,
           NULL               ]' || p_setnull_fddesc_1 || q'[,
           NULL               ]' || p_setnull_fdvalue_2 || q'[,
           NULL               ]' || p_setnull_fddesc_2 || q'[,
           NULL               ]' || p_setnull_fdvalue_3 || q'[,
           NULL               ]' || p_setnull_fddesc_3 || q'[,
           NULL               ]' || p_setnull_fdvalue_4 || q'[,
           NULL               ]' || p_setnull_fddesc_4 || q'[,
           NULL               ]' || p_setnull_fdvalue_5 || q'[,
           NULL               ]' || p_setnull_fddesc_5
               END) || q'[
      FROM scmdata.sys_group_dict t
     WHERE t.group_dict_type = ']' || p_group_dict_type || q'['
       AND t.pause = 0]';
    ELSE
      v_sql := q'[SELECT t.company_dict_value ]' || p_dict_value ||
               q'[,t.company_dict_name ]' || p_dict_desc || (CASE
                 WHEN p_is_set_other_fd = 1 THEN
                  q'[,
           NULL               ]' || p_setnull_fdvalue_1 || q'[,
           NULL               ]' || p_setnull_fddesc_1 || q'[,
           NULL               ]' || p_setnull_fdvalue_2 || q'[,
           NULL               ]' || p_setnull_fddesc_2 || q'[,
           NULL               ]' || p_setnull_fdvalue_3 || q'[,
           NULL               ]' || p_setnull_fddesc_3 || q'[,
           NULL               ]' || p_setnull_fdvalue_4 || q'[,
           NULL               ]' || p_setnull_fddesc_4 || q'[,
           NULL               ]' || p_setnull_fdvalue_5 || q'[,
           NULL               ]' || p_setnull_fddesc_5
               END) || q'[
        FROM scmdata.sys_company_dict t
       WHERE t.company_dict_type = ']' || p_group_dict_type || q'['
         AND t.pause = 0
         AND t.company_id = ']' || p_company_id || q'[']';
    END IF;
    RETURN v_sql;
  END f_get_picksql_by_type;

  /*============================================*
  * Author   : CZH
  * Created  : 16-5�� -22
  * ALERTER  :
  * ALERTER_TIME  :
  * Purpose  :  ����JSON�ַ��� 
  * p_jsonstr json�ַ���
  * p_key ��
  * ����p_key��Ӧ��ֵ
  * '{"COL_1": "PRODUCT_TYPE","COL_2": "00;01","COL_3": "","COL_4": "","COL_5": "","COL_6": "","COL_7": "","COL_8": "","COL_9": "","COL_10": "","COL_11": "YWZ","COL_21": "","COL_22": ""}'  
  * Obj_Name : F_PARSE_JSON
  *============================================*/
  FUNCTION f_parse_json(p_jsonstr VARCHAR2, p_key VARCHAR2) RETURN CLOB IS
    rtnval    VARCHAR2(50);
    i         NUMBER(2);
    jsonkey   VARCHAR2(50);
    jsonvalue VARCHAR2(50);
    json      VARCHAR2(1000);
  BEGIN
    IF p_jsonstr IS NOT NULL THEN
      json := REPLACE(p_jsonstr, '{', '');
      json := REPLACE(json, '}', '');
      json := REPLACE(json, '"', '');
    
      /*SELECT column_value VALUE
      FROM sf_get_arguments_pkg.get_strarray(av_str   => json, --Ҫ�ָ���ַ���
                                             av_split => ',' --�ָ�����
                                             )*/
    
      FOR temprow IN (SELECT str_value
                        FROM (SELECT regexp_substr(json,
                                                   '[^' || ',' || ']+',
                                                   1,
                                                   LEVEL,
                                                   'i') AS str_value
                                FROM dual
                              CONNECT BY LEVEL <=
                                         length(json) -
                                         length(regexp_replace(json, ',', '')) + 1)
                       WHERE instr(str_value, p_key) > 0) LOOP
      
        IF temprow.str_value IS NOT NULL THEN
          IF instr(temprow.str_value, p_key) > 0 THEN
            i         := 0;
            jsonkey   := '';
            jsonvalue := '';
            FOR tem2 IN (SELECT regexp_substr(temprow.str_value,
                                              '[^' || ':' || ']+',
                                              1,
                                              LEVEL,
                                              'i') AS VALUE
                           FROM dual
                         CONNECT BY LEVEL <=
                                    length(temprow.str_value) -
                                    length(regexp_replace(temprow.str_value,
                                                          ':',
                                                          '')) + 1) LOOP
              IF i = 0 THEN
                jsonkey := tem2.value;
              END IF;
              IF i = 1 THEN
                jsonvalue := tem2.value;
                IF (jsonkey = p_key) THEN
                  rtnval := TRIM(jsonvalue);
                  EXIT;
                END IF;
              END IF;
            
              IF i = 0 THEN
                i := i + 1;
              ELSE
                i := 0;
              END IF;
            
            END LOOP;
            EXIT;
          ELSE
            CONTINUE;
          END IF;
        END IF;
      END LOOP;
    END IF;
  
    RETURN rtnval;
  END f_parse_json;

END pkg_plat_comm;
/
