CREATE OR REPLACE PACKAGE scmdata.pkg_user_my_company IS

  -- Author  : ZWH73
  -- Created : 2020/7/4 16:07:29
  -- Purpose : �������Ĺ���

  /*
  �˳���ҵ
  --pi_user_id��sys_user��user_id
  --pi_company_id : sys_company ��company_id
  */
  PROCEDURE p_user_left_company(pi_user_id    IN VARCHAR2,
                                pi_company_id IN VARCHAR2,
                                po_result     OUT NUMBER,
                                po_msg        OUT VARCHAR2);

  /*============================================*
  * Author   : ZWH73
  * Created  : 2020-07-22 15:25:55
  * Purpose  : ע����ҵ
  * Obj_Name    : P_REGISTER_COMPANY
  * Arg_Number  : 7
  * PI_USER_ID :sys_user��user_id
  * PI_LOGO :��˾logo
  * PI_NAME :��˾���
  * PI_LOGN_NAME :��˾ȫ��
  * PI_LICENCE_NUM :��˾ͳһ������ô���
  * PI_TIPS :��˾���
  *============================================*/
  PROCEDURE p_register_company(pi_user_id      IN VARCHAR2,
                               pi_logo         IN VARCHAR,
                               pi_name         IN VARCHAR2,
                               pi_logn_name    IN VARCHAR2,
                               pi_licence_num  IN VARCHAR2,
                               pi_tips         IN VARCHAR2,
                               po_result       OUT NUMBER,
                               po_msg          OUT VARCHAR2,
                               pi_company_role IN VARCHAR2 DEFAULT 'supp');

  /*
  ���������ҵ
  --pi_user_id��sys_user��user_id
  --pi_company_id : sys_company ��company_id
  --pi_join_say:���������
  */
  PROCEDURE p_user_company_join(pi_user_id    IN VARCHAR2,
                                pi_company_id IN VARCHAR2,
                                pi_join_say   IN VARCHAR2,
                                po_result     OUT NUMBER,
                                po_msg        OUT VARCHAR2);

  /*
  --�ж��Ƿ������
  --pi_user_id��sys_user��user_id
  --pi_company_id : sys_company ��company_id
  */
  FUNCTION f_has_user_join_company(pi_user_id    VARCHAR2,
                                   pi_company_id VARCHAR2) RETURN NUMBER;

  /*
  --У����ҵ���Ƿ���ϱ�׼
  --pi_licence_num����������ͳһ���ô���
  ���Ϸ���1�������Ϸ���0
  */
  FUNCTION f_check_licence_num(pi_licence_num VARCHAR2) RETURN NUMBER;

END pkg_user_my_company;
/
CREATE OR REPLACE PACKAGE BODY scmdata.pkg_user_my_company IS

  --�˳���ҵ
  PROCEDURE p_user_left_company(pi_user_id    IN VARCHAR2,
                                pi_company_id IN VARCHAR2,
                                po_result     OUT NUMBER,
                                po_msg        OUT VARCHAR2) IS
    p_i INT;
  BEGIN
    --����Ƿ�����©����ҵ��ϵ
    --ӵ���߲��˳���ҵ
    SELECT nvl(MAX(1), 0)
      INTO p_i
      FROM sys_company
     WHERE company_id = pi_company_id
       AND attributor_id = pi_user_id;
    IF p_i = 1 THEN
      po_result := -2;
      po_msg    := '���Ǹ���ҵ�������ߣ�����ת����ҵ���˳�';
    END IF;
    --��sys_company_user��Ӧ�ֶ���Ϊͣ��
    UPDATE sys_company_user
       SET pause = 1, update_id = pi_user_id, update_time = SYSDATE
     WHERE user_id = pi_user_id
       AND company_id = pi_company_id;
    IF SQL%ROWCOUNT <> 1 THEN
      po_result := -1;
      po_msg    := '�޸�������Ϣʧ�ܣ�����ϵ����Ա';
      RETURN;
    END IF;
  END p_user_left_company;
  --У����ҵ���Ƿ���ϱ�׼
  FUNCTION f_check_licence_num(pi_licence_num VARCHAR2) RETURN NUMBER IS
    p_i INT;
  BEGIN
    p_i := 0;
    SELECT nvl(MAX(1), 0)
      INTO p_i
      FROM dual
     WHERE regexp_like(pi_licence_num, '^[0-9a-zA-Z]{18}$');
    --'^([0-9A-HJ-NPQRTUWXY]{2}\d{6}[0-9A-HJ-NPQRTUWXY]{10}|[1-9]\d{14})$');
    RETURN p_i;
  END f_check_licence_num;

  --�ж��Ƿ������
  FUNCTION f_has_user_join_company(pi_user_id    VARCHAR2,
                                   pi_company_id VARCHAR2) RETURN NUMBER IS
    p_i  INT;
    p_ti INT;
  BEGIN
    p_i := 0;
    SELECT nvl(MAX(1), 0)
      INTO p_i
      FROM sys_user_company_join a
     WHERE a.company_id = pi_company_id
       AND a.user_id = pi_user_id;
    IF p_i = 1 THEN
      SELECT nvl(MAX(1), 0)
        INTO p_ti
        FROM sys_user_company_join a
       WHERE a.company_id = pi_company_id
         AND a.user_id = pi_user_id
         AND a.join_status IN ('0', '1');
      IF p_ti = 1 THEN
        p_i := -1;
      END IF;
    END IF;
    RETURN p_i;
  END f_has_user_join_company;

  --���������ҵ
  PROCEDURE p_user_company_join(pi_user_id    IN VARCHAR2,
                                pi_company_id IN VARCHAR2,
                                pi_join_say   IN VARCHAR2,
                                po_result     OUT NUMBER,
                                po_msg        OUT VARCHAR2) IS
    p_i INT;
  BEGIN
    p_i := f_has_user_join_company(pi_user_id, pi_company_id);
    IF p_i = -1 THEN
      po_result := -1;
      po_msg    := '�����������л��Ѽ������ҵ���޷���������!��';
      RETURN;
    ELSIF p_i = 1 THEN
      UPDATE sys_user_company_join
         SET join_say    = pi_join_say,
             join_time   = SYSDATE,
             join_status = '0',
             reply_id    = NULL,
             reply_say   = NULL,
             reply_time  = NULL
       WHERE company_id = pi_company_id
         AND user_id = pi_user_id;
      IF SQL%ROWCOUNT <> 1 THEN
        po_result := -1;
        po_msg    := '�޸�������Ϣʧ�ܣ�����ϵ����Ա';
        RETURN;
      END IF;
    ELSE
      INSERT INTO sys_user_company_join
        (join_id, join_say, user_id, company_id, join_time, join_status)
      VALUES
        (f_get_uuid, pi_join_say, pi_user_id, pi_company_id, SYSDATE, '0');
      IF SQL%ROWCOUNT <> 1 THEN
        po_result := -1;
        po_msg    := '����������Ϣʧ�ܣ�����ϵ����Ա';
        RETURN;
      END IF;
    END IF;
  END p_user_company_join;

  --ע����ҵ
  PROCEDURE p_register_company(pi_user_id      IN VARCHAR2,
                               pi_logo         IN VARCHAR,
                               pi_name         IN VARCHAR2,
                               pi_logn_name    IN VARCHAR2,
                               pi_licence_num  IN VARCHAR2,
                               pi_tips         IN VARCHAR2,
                               po_result       OUT NUMBER,
                               po_msg          OUT VARCHAR2,
                               pi_company_role IN VARCHAR2 DEFAULT 'supp') IS
    p_id      VARCHAR2(32);
    p_role_id VARCHAR2(50);
    p_user    sys_user%ROWTYPE;
  BEGIN
    po_result := 0;
    p_id      := f_get_uuid();
  
    IF pkg_check_data_comm.f_check_logn_name(pi_logn_name) = 0 THEN
      po_result := -1;
      po_msg    := '�����й���½��ط��棬��ҵȫ��Ӧֻ�������ĺ����ţ�';
      RETURN;
    END IF;
  
    IF f_check_licence_num(pi_licence_num) = 0 THEN
      po_result := -1;
      po_msg    := '������18λ��ȷ�����ͳһ���ô��룡';
      RETURN;
    END IF;
  
    --����sys_company
    INSERT INTO sys_company
      (company_id, company_name, pause, logo, tips, licence_num, logn_name,
       is_open, attributor_id, create_time, update_id, update_time,
       id_status, company_role) --������ҵƽ̨��ɫ 2021-11-20 by: hx
    VALUES
      (p_id, pi_name, 0, pi_logo, pi_tips, pi_licence_num, pi_logn_name, 1,
       pi_user_id, SYSDATE, pi_user_id, SYSDATE, '0', pi_company_role); --add by hx87 2023-2-22 ����mrp��Ӧ������
    IF SQL%ROWCOUNT <> 1 THEN
      po_result := -1;
      po_msg    := '������ҵ��Ϣʧ�ܣ�����ϵ����Ա';
      RETURN;
    END IF;
    --����sys_user_company
    INSERT INTO sys_user_company
      (company_id, user_id, user_company_id, is_default, company_alias,
       sort, pause, join_time)
    VALUES
      (p_id, pi_user_id, f_get_uuid(), 0, pi_name, 1, 0, SYSDATE);
    IF SQL%ROWCOUNT <> 1 THEN
      po_result := -1;
      po_msg    := '������ҵ���û�ʧ�ܣ�����ϵ����Ա';
      RETURN;
    END IF;
    --����sys_company_user
    SELECT * INTO p_user FROM sys_user WHERE user_id = pi_user_id;
    INSERT INTO sys_company_user
      (company_user_id, company_id, user_id, sort, nick_name,
       company_user_name, sex, pause, email, phone, update_id, update_time,
       nationality, id_card, education, profession, LANGUAGE, birth_place,
       household_type, marriage, residence_address, living_address,
       emergency_name, emergency_contact, emergency_phone, self_evaluation)
    VALUES
      (f_get_uuid(), p_id, pi_user_id, 1, p_user.nick_name,
       nvl(p_user.username, p_user.nick_name), p_user.sex, 0, p_user.email,
       p_user.phone, pi_user_id, SYSDATE, p_user.nationality, p_user.id_card,
       p_user.education, p_user.profession, p_user.language,
       p_user.birth_place, p_user.household_type, p_user.marriage,
       p_user.residence_address, p_user.living_address,
       p_user.emergency_name, p_user.emergency_contact,
       p_user.emergency_phone, p_user.self_evaluation);
    IF SQL%ROWCOUNT <> 1 THEN
      po_result := -1;
      po_msg    := '������ҵ�û�ʧ�ܣ�����ϵ����Ա';
      RETURN;
    END IF;
    --��ȡ���������ɵ���ҵӵ����id
    SELECT MAX(company_role_id)
      INTO p_role_id
      FROM sys_company_role
     WHERE company_id = p_id
       AND company_role_name = '��������Ա';
    --����ҵӵ����Ȩ�����Ӹ����û�
    INSERT INTO sys_company_user_role
      (company_user_role_id, company_id, user_id, company_role_id)
    VALUES
      (f_get_uuid(), p_id, pi_user_id, p_role_id);
    IF SQL%ROWCOUNT <> 1 THEN
      po_result := -1;
      po_msg    := '�����û�Ȩ��ʧ�ܣ�����ϵ����Ա';
      RETURN;
    END IF;
    --������Ӧ�̵���������ͳһ���ô�����ͬ�Ĺ�˾
    IF pi_company_role = 'supp' THEN
      UPDATE t_supplier_info
         SET supplier_company_id = p_id, bind_status = 1
       WHERE social_credit_code = pi_licence_num;
    END IF;
    --�Զ���Ӧ�ð���ֵ����Ӧ�� 2021-11-22 hx87
    /* pi_type = 1 ��������������������Ӧ��*/
    pkg_company_manage.p_app_buy_for_supp(pi_user_id,
                                          p_id,
                                          1,
                                          po_result,
                                          po_msg,
                                          'supp');
  EXCEPTION
    WHEN dup_val_on_index THEN
      BEGIN
        po_result := -1;
        po_msg    := 'ȫ�ƻ�ͳһ���ô����ѱ�ע�ᣡ';
        RETURN;
      END;
    
  END p_register_company;

END pkg_user_my_company;
/
