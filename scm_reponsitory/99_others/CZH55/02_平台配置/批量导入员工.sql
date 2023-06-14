--0.�鿴
SELECT user_id,
       user_name,
       phone,
       inner_emp_number,
       dept_name,
       group_role_name,
       err_msg_id,
       m.msg_type,
       m.msg,
       t.company_id
  FROM scmdata.sys_company_user_temp t
  LEFT JOIN scmdata.sys_company_import_msg m
    ON t.err_msg_id = m.msg_id;

--1.�����ϴ�
DECLARE
BEGIN
  FOR i IN 1 .. 9 LOOP
    INSERT INTO scmdata.sys_company_user_temp
      (user_id,
       user_name,
       phone,
       inner_emp_number,
       dept_name,
       group_role_name,
       line_num,
       company_id)
    VALUES
      (scmdata.f_get_uuid(),
       '���Ӻ�' || i,
       '1817254357' || i,
       'CZH' || i,
       '��װ',
       '����Ա',
       i,
       'a972dd1ffe3b3a10e0533c281cac8fd7');
    --decode((i%2), 0, '��װ', 1, 'Ůװ', '��װ'),
  --decode((i%2), 0, '����Ա', 1, 'ӵ����', 'ӵ����'));
  END LOOP;
END;

--2.����У��
DECLARE
  v_num         NUMBER := 0;
  v_role_num    NUMBER;
  v_err_num     NUMBER := 0;
  v_msg_id      NUMBER;
  v_msg         VARCHAR2(2000);
  v_import_flag VARCHAR2(100);
  role_name_tb  scmdata.role_name_tb_type;
  --��ʱ������
  CURSOR temp_data_cur IS
    SELECT user_id,
           user_name,
           phone,
           inner_emp_number,
           dept_name,
           group_role_name,
           err_msg_id,
           company_id
      FROM scmdata.sys_company_user_temp;
BEGIN
  FOR data_rec IN temp_data_cur LOOP
  
    --1.У���ֻ���
    SELECT COUNT(1)
      INTO v_num
      FROM scmdata.sys_user su
     WHERE su.phone = data_rec.phone
       AND rownum = 1;
    IF v_num > 0 THEN
      v_msg     := '�ֻ���:' || data_rec.phone || '����ƽ̨ע�ᣬ������ֻ��ţ���</br>';
      v_err_num := v_err_num + 1;
    END IF;
  
    SELECT COUNT(1)
      INTO v_num
      FROM scmdata.sys_company_user_temp t
     WHERE t.phone = data_rec.phone
       AND t.user_id <> data_rec.user_id
       AND rownum = 1;
    IF v_num > 0 THEN
      v_msg     := v_msg || '���������У��ֻ���:' || data_rec.phone ||
                   '�ظ���������ֻ��ţ���</br>';
      v_err_num := v_err_num + 1;
    END IF;
  
    IF length(data_rec.phone) <> 11 THEN
      v_msg     := v_msg || '���������У��ֻ���:' || data_rec.phone ||
                   '��λ��ӦΪ11λ����</br>';
      v_err_num := v_err_num + 1;
    END IF;
  
    --2.У���ڲ�Ա���ţ�ƽ̨������� �����ظ�
    SELECT COUNT(1)
      INTO v_num
      FROM scmdata.sys_company_user a
     WHERE a.inner_user_id = data_rec.inner_emp_number
       AND a.company_id = data_rec.company_id
       AND rownum = 1;
    IF v_num > 0 THEN
      v_msg     := v_msg || '�ڲ�Ա����:' || data_rec.inner_emp_number ||
                   'ƽ̨���Ѵ��ڣ�������ڲ�Ա���ţ���</br>';
      v_err_num := v_err_num + 1;
    END IF;
  
    SELECT COUNT(1)
      INTO v_num
      FROM scmdata.sys_company_user_temp t
     WHERE t.inner_emp_number = data_rec.inner_emp_number
       AND t.user_id <> data_rec.user_id
       AND rownum = 1;
    IF v_num > 0 THEN
      v_msg     := v_msg || '���������У��ڲ�Ա����:' || data_rec.inner_emp_number ||
                   '�ظ���������ڲ�Ա���ţ���</br>';
      v_err_num := v_err_num + 1;
    END IF;
  
    --3.�������ƣ�����֯�ܹ��Ƿ���
    SELECT COUNT(1)
      INTO v_num
      FROM scmdata.sys_company_dept t
     WHERE t.company_id = data_rec.company_id
       AND t.dept_name = data_rec.dept_name;
  
    IF v_num > 0 THEN
      NULL;
    ELSE
      v_msg     := v_msg || '���������У���������:' || data_rec.dept_name ||
                   '����֯�ܹ��в����ڣ�����д��ȷ�Ĳ������ƣ���</br>';
      v_err_num := v_err_num + 1;
    END IF;
  
    --4.��ɫ����(���) ��ǰ��ҵ��ɫ�б��Ƿ���    
    role_name_tb := scmdata.sf_import_company_users_pkg.get_strarray(data_rec.group_role_name,
                                                                     ';');
    FOR i IN 1 .. role_name_tb.count LOOP
      SELECT COUNT(1)
        INTO v_role_num
        FROM scmdata.sys_company_role t
       WHERE t.company_id = data_rec.company_id
         AND t.company_role_name = role_name_tb(i);
      IF v_role_num > 0 THEN
        NULL;
      ELSE
        v_msg     := v_msg || '���������У���ɫ����:' || role_name_tb(i) ||
                     '�ڽ�ɫ�б��в����ڣ�����д��ȷ�Ľ�ɫ���ƣ���</br>';
        v_err_num := v_err_num + 1;
      END IF;
    END LOOP;
  
    --5.��У����Ϣ���뵽������Ϣ��
    v_msg_id := scmdata.sys_company_import_msg_s.nextval;
  
    UPDATE scmdata.sys_company_user_temp t
       SET t.err_msg_id = v_msg_id
     WHERE t.user_id = data_rec.user_id;
  
    IF v_err_num > 0 THEN
      v_import_flag := 'У����󣺹�' || v_err_num || '������';
      INSERT INTO scmdata.sys_company_import_msg
      VALUES
        (v_msg_id, 'E', v_import_flag || v_msg, SYSDATE);
      --��մ����¼
      v_num     := 0;
      v_err_num := 0;
      v_msg     := NULL;
    ELSE
      v_import_flag := 'У��ɹ�';
      INSERT INTO scmdata.sys_company_import_msg
      VALUES
        (v_msg_id, 'Y', v_import_flag, SYSDATE);
    END IF;
  
  END LOOP;
END;

--3.�ύ
DECLARE
  v_user_id         VARCHAR2(32); --�û�������
  v_company_user_id VARCHAR2(32); --��ҵ�û�����
  v_role_id         VARCHAR2(100); --��ҵ��ɫ����
  v_dept_id         VARCHAR2(100); --��ҵ��������
  v_default         NUMBER;
  v_sort            NUMBER;
  v_company_name    VARCHAR2(100);
  CURSOR import_datas_cur IS
    SELECT user_id,
           user_name,
           phone,
           inner_emp_number,
           dept_name,
           group_role_name,
           err_msg_id,
           m.msg_type,
           m.msg,
           t.company_id
      FROM scmdata.sys_company_user_temp t
      LEFT JOIN scmdata.sys_company_import_msg m
        ON t.err_msg_id = m.msg_id
     WHERE t.company_id = 'a972dd1ffe3b3a10e0533c281cac8fd7'; --��ǰĬ����ҵ
BEGIN
  FOR data_rec IN import_datas_cur LOOP
    IF data_rec.msg_type = 'E' OR data_rec.msg_type IS NULL THEN
      raise_application_error(-20002,
                              '�����Ƿ񶼼���ɹ��������޸ĺ��ύ');
    END IF;
  END LOOP;
  --����ʱ��������ʽ���뵽ҵ�����
  FOR data_rec IN import_datas_cur LOOP
    v_user_id := scmdata.f_get_uuid();
    --1.ƽ̨�û�
    INSERT INTO scmdata.sys_user
      (user_id,
       avatar,
       user_account,
       password,
       nick_name,
       pause,
       user_type,
       create_time,
       phone,
       id_status,
       update_time)
    VALUES
      (v_user_id,
       '9c60117acee46132c530655a5f774e32',
       data_rec.phone,
       '3a1e503f0e1314063758153030155837061cc2',
       data_rec.user_name,
       0,
       'user',
       SYSDATE,
       data_rec.phone,
       0,
       SYSDATE);
    --����ƽ̨��ɫ��ϵ  ������  
  
    --��ҵ�˺�
    v_company_user_id := scmdata.f_get_uuid();
    INSERT INTO scmdata.sys_company_user
      (company_user_id,
       company_id,
       user_id,
       sort,
       nick_name,
       company_user_name,
       phone,
       pause,
       update_id,
       update_time,
       create_time,
       inner_user_id)
    VALUES
      (v_company_user_id,
       data_rec.company_id,
       v_user_id,
       1,
       data_rec.user_name,
       data_rec.user_name,
       data_rec.phone,
       0,
       'admin', --%currentusername%,
       SYSDATE,
       SYSDATE,
       data_rec.inner_emp_number);
  
    --�û�����ҵ 
  
    SELECT MAX(is_default), MAX(sort)
      INTO v_default, v_sort
      FROM scmdata.sys_user_company a
     WHERE a.user_id = v_user_id;
  
    SELECT MAX(a.company_name)
      INTO v_company_name
      FROM scmdata.sys_company a
     WHERE a.company_id = data_rec.company_id;
  
    INSERT INTO scmdata.sys_user_company
      (user_company_id,
       user_id,
       company_id,
       company_alias,
       is_default,
       sort,
       join_time,
       pause)
    VALUES
      (scmdata.f_get_uuid(),
       v_user_id,
       data_rec.company_id,
       v_company_name,
       nvl(v_default, 0),
       nvl(v_sort + 1, 1),
       SYSDATE,
       0);
  
    --����Ա����ɫ��ϵ
    SELECT t.company_role_id
      INTO v_role_id
      FROM scmdata.sys_company_role t
     WHERE t.company_id = data_rec.company_id
       AND t.company_role_name = data_rec.group_role_name;
  
    IF v_role_id IS NOT NULL THEN
      INSERT INTO scmdata.sys_company_user_role
        (company_user_role_id, company_id, user_id, company_role_id)
      VALUES
        (scmdata.f_get_uuid(), data_rec.company_id, v_user_id, v_role_id);
    END IF;
  
    SELECT t.company_dept_id
      INTO v_dept_id
      FROM scmdata.sys_company_dept t
     WHERE t.company_id = data_rec.company_id
       AND t.dept_name = data_rec.dept_name;
  
    --Ա����������Ӧ����
    IF v_dept_id IS NOT NULL THEN
      INSERT INTO scmdata.sys_company_user_dept
        (user_dept_id, company_id, user_id, company_dept_id)
      VALUES
        (scmdata.f_get_uuid(), data_rec.company_id, v_user_id, v_dept_id);
    END IF;
  
  END LOOP;

END;

