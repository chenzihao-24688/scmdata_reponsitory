CREATE OR REPLACE PACKAGE sf_import_company_users_pkg IS

  -- Author  : SANFU
  -- Created : 2020/8/25 15:03:32
  -- Purpose : ��������Ա��
  --�ָ�
  FUNCTION get_strarraylength(av_str   VARCHAR2, --Ҫ�ָ���ַ���
                              av_split VARCHAR2 --�ָ�����
                              ) RETURN NUMBER;
  --��ȡ
  FUNCTION get_strarraystrofindex(av_str   VARCHAR2, --Ҫ�ָ���ַ���
                                  av_split VARCHAR2, --�ָ�����
                                  av_index NUMBER --ȡ�ڼ���Ԫ��
                                  ) RETURN VARCHAR2;
  --��ȡ�ַ�����
  FUNCTION get_strarray(av_str   VARCHAR2, --Ҫ�ָ���ַ���
                        av_split VARCHAR2 --�ָ�����
                        ) RETURN role_name_tb_type;

  --У��������������
  PROCEDURE check_importdatas(p_company_id           IN VARCHAR2,
                              p_user_id              IN VARCHAR2,
                              p_company_user_temp_id IN VARCHAR2);

  --��յ�����Ϣ��
  PROCEDURE delete_sys_company_import_msg(p_company_id IN VARCHAR2,
                                          p_user_id    IN VARCHAR2);

  --�����ʱ��������Ϣ�������
  PROCEDURE delete_sys_company_user_temp(p_company_id IN VARCHAR2,
                                         p_user_id    IN VARCHAR2);
  --�ύ��ʱ����ҵ���
  PROCEDURE submit_sys_company_user_temp(p_company_id IN VARCHAR2,
                                         p_user_id    IN VARCHAR2);
END sf_import_company_users_pkg;
/
CREATE OR REPLACE PACKAGE BODY sf_import_company_users_pkg IS

  /*============================================*
  * Author   : SANFU
  * Created  : 2020-08-25 15:25:46
  * ALERTER  : 
  * ALERTER_TIME  : 
  * Purpose  : �ָ�
  * Obj_Name    : GET_STRARRAYLENGTH
  * Arg_Number  : 2
  * AV_STR : Ҫ�ָ���ַ���
  * AV_SPLIT :�ָ�����
  *============================================*/

  FUNCTION get_strarraylength(av_str   VARCHAR2, --Ҫ�ָ���ַ���
                              av_split VARCHAR2 --�ָ�����
                              ) RETURN NUMBER IS
    lv_str    VARCHAR2(1000);
    lv_length NUMBER;
  BEGIN
    lv_str    := ltrim(rtrim(av_str));
    lv_length := 0;
    WHILE instr(lv_str, av_split) <> 0 LOOP
      lv_length := lv_length + 1;
      lv_str    := substr(lv_str,
                          instr(lv_str, av_split) + length(av_split),
                          length(lv_str));
    END LOOP;
    lv_length := lv_length + 1;
    RETURN lv_length;
  END get_strarraylength;

  /*============================================*
  * Author   : SANFU
  * Created  : 2020-08-25 15:38:52
  * ALERTER  : 
  * ALERTER_TIME  : 
  * Purpose  : ��ȡ
  * Obj_Name    : GET_STRARRAYSTROFINDEX
  * Arg_Number  : 3
  * AV_STR :Ҫ�ָ���ַ���
  * AV_SPLIT :�ָ�����
  * AV_INDEX :ȡ�ڼ���Ԫ��
  *============================================*/

  FUNCTION get_strarraystrofindex(av_str   VARCHAR2, --Ҫ�ָ���ַ���
                                  av_split VARCHAR2, --�ָ�����
                                  av_index NUMBER --ȡ�ڼ���Ԫ��
                                  ) RETURN VARCHAR2 IS
    lv_str        VARCHAR2(1024);
    lv_strofindex VARCHAR2(1024);
    lv_length     NUMBER;
  BEGIN
    lv_str    := ltrim(rtrim(av_str));
    lv_str    := concat(lv_str, av_split);
    lv_length := av_index;
    IF lv_length = 0 THEN
      lv_strofindex := substr(lv_str,
                              1,
                              instr(lv_str, av_split) - length(av_split));
    ELSE
      lv_length     := av_index + 1;
      lv_strofindex := substr(lv_str,
                              instr(lv_str, av_split, 1, av_index) +
                              length(av_split),
                              instr(lv_str, av_split, 1, lv_length) -
                              instr(lv_str, av_split, 1, av_index) -
                              length(av_split));
    END IF;
    RETURN lv_strofindex;
  END get_strarraystrofindex;

  /*============================================*
  * Author   : SANFU
  * Created  : 2020-08-25 17:34:59
  * ALERTER  : 
  * ALERTER_TIME  : 
  * Purpose  :  ��ȡ�ַ�����
  * Obj_Name    : GET_STRARRAY
  * Arg_Number  : 2
  * AV_STR : Ҫ�ָ���ַ���
  * AV_SPLIT : �ָ�����
  *============================================*/

  FUNCTION get_strarray(av_str   VARCHAR2, --Ҫ�ָ���ַ���
                        av_split VARCHAR2 --�ָ�����
                        ) RETURN role_name_tb_type IS
  
    v_av_str   VARCHAR2(100) := av_str; --Ҫ�и���ַ���
    v_av_split VARCHAR2(100) := av_split; --�ָ��
    v_length   NUMBER;
    --TYPE role_name_tb_type is table of varchar2(128);
    role_name_tb role_name_tb_type := role_name_tb_type();
  
  BEGIN
    v_length := scmdata.sf_import_company_users_pkg.get_strarraylength(v_av_str,
                                                                       v_av_split);
  
    FOR i IN 0 .. (v_length - 1) LOOP
      --��չ����
      role_name_tb.extend;
      SELECT scmdata.sf_import_company_users_pkg.get_strarraystrofindex(v_av_str,
                                                                        v_av_split,
                                                                        i)
        INTO role_name_tb(role_name_tb.count)
        FROM dual;
    
    END LOOP;
    /*    for i in 0 .. (v_length - 1) loop
      dbms_output.put_line(role_name_tb(i));
    
    end loop;*/
    RETURN role_name_tb;
  END get_strarray;

  /*============================================*
  * Author   : SANFU
  * Created  : 2020-08-25 17:34:59
  * ALERTER  : 
  * ALERTER_TIME  : 
  * Purpose  :  У��������������
  * Obj_Name    : GET_STRARRAY
  * Arg_Number  : 1
  * p_company_id : ��ǰĬ����ҵid
  *============================================*/
  PROCEDURE check_importdatas(p_company_id           IN VARCHAR2,
                              p_user_id              IN VARCHAR2,
                              p_company_user_temp_id IN VARCHAR2) IS
    v_num         NUMBER := 0;
    v_role_num    NUMBER;
    v_err_num     NUMBER := 0;
    v_msg_id      NUMBER;
    v_msg         VARCHAR2(2000);
    v_import_flag VARCHAR2(100);
    role_name_tb  scmdata.role_name_tb_type;
    --��ʱ������
    data_rec scmdata.sys_company_user_temp%ROWTYPE;
    /*    CURSOR temp_data_cur IS
    SELECT user_id,
           user_name,
           phone,
           inner_emp_number,
           dept_name,
           group_role_name,
           err_msg_id,
           company_id,
           company_user_temp_id
      FROM scmdata.sys_company_user_temp
     WHERE company_id = p_company_id
       AND user_id = p_user_id;*/
  
  BEGIN
    SELECT *
      INTO data_rec
      FROM scmdata.sys_company_user_temp
     WHERE company_id = p_company_id
       AND user_id = p_user_id
       AND company_user_temp_id = p_company_user_temp_id;
    --FOR data_rec IN temp_data_cur LOOP
  
    IF data_rec.user_name IS NULL THEN
      v_err_num := v_err_num + 1;
      v_msg     := v_err_num || '.�û�������Ϊ�գ�';
    END IF;
  
    IF data_rec.phone IS NULL THEN
      v_err_num := v_err_num + 1;
      v_msg     := v_msg || v_err_num || '.�ֻ��Ų���Ϊ�գ�';
    
    END IF;
  
    IF data_rec.dept_name IS NULL THEN
      v_err_num := v_err_num + 1;
      v_msg     := v_msg || v_err_num || '.�������Ʋ���Ϊ�գ�';
    
    END IF;
  
    IF data_rec.group_role_name IS NULL THEN
      v_err_num := v_err_num + 1;
      v_msg     := v_msg || v_err_num || '.��ɫ���Ʋ���Ϊ�գ�';
    
    END IF;
  
    --1.У���ֻ���
    /* SELECT COUNT(1)
      INTO v_num
      FROM scmdata.sys_user su
     WHERE su.phone = data_rec.phone
       AND rownum = 1;
    
    IF v_num > 0 THEN
      v_err_num := v_err_num + 1;
      v_msg     := v_msg || v_err_num || '.�ֻ���:[' || data_rec.phone ||
                   ']����ƽ̨ע�ᣬ������ֻ��ţ�';
    
    END IF;*/
  
    --1.У���ֻ��� У�����ҵ�Ƿ��Ѵ��ڸ��˺�
    SELECT COUNT(1)
      INTO v_num
      FROM scmdata.sys_company_user fc
     WHERE fc.company_id = data_rec.company_id
       AND fc.phone = data_rec.phone
       AND rownum = 1;
  
    IF v_num > 0 THEN
      v_err_num := v_err_num + 1;
      v_msg     := v_msg || v_err_num || '.��ǰ�ֻ���:[' || data_rec.phone ||
                   ']�Ѽ�����ҵ�������ظ����룡��';
    END IF;
  
    SELECT COUNT(1)
      INTO v_num
      FROM scmdata.sys_company_user_temp t
     WHERE t.phone = data_rec.phone
       AND t.user_id = data_rec.user_id
       AND t.company_user_temp_id <> data_rec.company_user_temp_id
       AND rownum = 1;
    IF v_num > 0 THEN
      v_err_num := v_err_num + 1;
      v_msg     := v_msg || v_err_num || '.���������У��ֻ���:[' || data_rec.phone ||
                   ']�ظ���������ֻ��ţ�';
    END IF;
  
    IF length(data_rec.phone) <> 11 THEN
      v_err_num := v_err_num + 1;
      v_msg     := v_msg || v_err_num || '.���������У��ֻ���:[' || data_rec.phone ||
                   ']��λ��ӦΪ11λ��';
    
    END IF;
  
    --2.У���ڲ�Ա���ţ�ƽ̨������� �����ظ�
    IF data_rec.inner_emp_number IS NULL THEN
      NULL;
    ELSE
      SELECT COUNT(1)
        INTO v_num
        FROM scmdata.sys_company_user a
       WHERE a.inner_user_id = data_rec.inner_emp_number
         AND a.company_id = data_rec.company_id
         AND rownum = 1;
      IF v_num > 0 THEN
        v_err_num := v_err_num + 1;
        v_msg     := v_msg || v_err_num || '.�ڲ�Ա����:[' ||
                     data_rec.inner_emp_number || ']ƽ̨���Ѵ��ڣ�������ڲ�Ա���ţ�';
      
      END IF;
    
      SELECT COUNT(1)
        INTO v_num
        FROM scmdata.sys_company_user_temp t
       WHERE t.inner_emp_number = data_rec.inner_emp_number
         AND t.user_id = data_rec.user_id
         AND t.company_user_temp_id <> data_rec.company_user_temp_id
         AND rownum = 1;
      IF v_num > 0 THEN
        v_err_num := v_err_num + 1;
        v_msg     := v_msg || v_err_num || '.���������У��ڲ�Ա����:[' ||
                     data_rec.inner_emp_number || ']�ظ���������ڲ�Ա���ţ�';
      
      END IF;
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
      v_err_num := v_err_num + 1;
      v_msg     := v_msg || v_err_num || '.���������У���������:[' ||
                   data_rec.dept_name || ']����֯�ܹ��в����ڣ�����д��ȷ�Ĳ������ƣ�';
    
    END IF;
  
    --4.��ɫ����(���) ��ǰ��ҵ��ɫ�б��Ƿ���  
    --��ȡ�ַ�����  
    role_name_tb := scmdata.sf_import_company_users_pkg.get_strarray(data_rec.group_role_name,
                                                                     ';');
    FOR i IN 1 .. role_name_tb.count LOOP
      SELECT COUNT(1)
        INTO v_role_num
        FROM scmdata.sys_company_role t
       WHERE t.company_id = data_rec.company_id
         AND t.company_role_name = role_name_tb(i);
      IF v_role_num > 0 THEN
        --���������н�ɫ���Ʋ���Ϊ��������Ա��ɫ
        IF role_name_tb(i) = '��������Ա' THEN
          v_err_num := v_err_num + 1;
          v_msg     := v_msg || v_err_num || '.���������У���ɫ���Ʋ���Ϊ��������Ա��';
        ELSE
          NULL;
        END IF;
      ELSE
        v_err_num := v_err_num + 1;
        v_msg     := v_msg || v_err_num || '.���������У���ɫ����:[' ||
                     role_name_tb(i) || ']�ڽ�ɫ�б��в����ڣ�����д��ȷ�Ľ�ɫ���ƣ�';
      
      END IF;
    
    END LOOP;
  
    --5.��У����Ϣ���뵽������Ϣ��
    v_msg_id := scmdata.sys_company_import_msg_s.nextval;
  
    UPDATE scmdata.sys_company_user_temp t
       SET t.err_msg_id = v_msg_id
     WHERE t.company_id = data_rec.company_id
       AND t.user_id = data_rec.user_id
       AND t.company_user_temp_id = p_company_user_temp_id;
  
    IF v_err_num > 0 THEN
      v_import_flag := 'У����󣺹�' || v_err_num || '������';
      INSERT INTO scmdata.sys_company_import_msg
      VALUES
        (v_msg_id,
         'E',
         v_import_flag || v_msg,
         SYSDATE,
         data_rec.company_id,
         p_user_id);
      --��մ����¼
      /*      v_num     := 0;
      v_err_num := 0;
      v_msg     := NULL;*/
    ELSE
      v_import_flag := 'У��ɹ�';
      INSERT INTO scmdata.sys_company_import_msg
      VALUES
        (v_msg_id,
         'Y',
         v_import_flag,
         SYSDATE,
         data_rec.company_id,
         p_user_id);
    END IF;
    -- END LOOP;
  
  END check_importdatas;

  /*============================================*
  * Author   : SANFU
  * Created  : 2020-08-25 17:34:59
  * ALERTER  : 
  * ALERTER_TIME  : 
  * Purpose  :  ��յ�����Ϣ�������
  * Obj_Name    : delete_sys_company_import_msg
  * Arg_Number  : 1
  * p_company_id : ��ǰĬ����ҵid
  *============================================*/

  PROCEDURE delete_sys_company_import_msg(p_company_id IN VARCHAR2,
                                          p_user_id    IN VARCHAR2) IS
  
  BEGIN
    --��յ�����Ϣ�������
    DELETE FROM scmdata.sys_company_import_msg m
     WHERE m.company_id = p_company_id
       AND m.user_id = p_user_id;
  
    UPDATE scmdata.sys_company_user_temp t
       SET t.err_msg_id = NULL
     WHERE t.company_id = p_company_id
       AND t.user_id = p_user_id;
  
  END delete_sys_company_import_msg;

  /*============================================*
  * Author   : SANFU
  * Created  : 2020-08-25 17:34:59
  * ALERTER  : 
  * ALERTER_TIME  : 
  * Purpose  :  �����ʱ��������Ϣ�������
  * Obj_Name    : delete_sys_company_user_temp
  * Arg_Number  : 1
  * p_company_id : ��ǰĬ����ҵid
  *============================================*/
  PROCEDURE delete_sys_company_user_temp(p_company_id IN VARCHAR2,
                                         p_user_id    IN VARCHAR2) IS
  
  BEGIN
    --�����ʱ��������Ϣ�������
    DELETE FROM scmdata.sys_company_import_msg m
     WHERE m.company_id = p_company_id
       AND m.user_id = p_user_id;
  
    DELETE FROM scmdata.sys_company_user_temp t
     WHERE t.company_id = p_company_id
       AND t.user_id = p_user_id;
  END delete_sys_company_user_temp;

  /*============================================*
  * Author   : SANFU
  * Created  : 2020-08-25 17:34:59
  * ALERTER  : 
  * ALERTER_TIME  : 
  * Purpose  :  �ύ��ʱ����ҵ���
  * Obj_Name    : submit_sys_company_user_temp
  * Arg_Number  : 1
  * p_company_id : ��ǰĬ����ҵid
  *============================================*/
  PROCEDURE submit_sys_company_user_temp(p_company_id IN VARCHAR2,
                                         p_user_id    IN VARCHAR2) IS
    v_user_id         VARCHAR2(32); --�û�������
    v_company_user_id VARCHAR2(32); --��ҵ�û�����
    v_huser_id        VARCHAR2(32); --�Ѵ��ڵ��û�������
    v_role_id         VARCHAR2(100); --��ҵ��ɫ����
    v_dept_id         VARCHAR2(100); --��ҵ��������
    v_default         NUMBER;
    v_sort            NUMBER;
    v_company_name    VARCHAR2(100);
    CURSOR import_datas_cur IS
      SELECT t.user_id,
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
       WHERE t.company_id = p_company_id
         AND t.user_id = p_user_id; --��ǰĬ����ҵ
  BEGIN
    /*    FOR data_rec IN import_datas_cur LOOP
      IF data_rec.msg_type = 'E' OR data_rec.msg_type IS NULL THEN
        raise_application_error(-20002,
                                '���������Ƿ��Ѽ���ɹ����޸���ȷ�����ύ!');
      END IF;
    END LOOP;*/
    --����ʱ��������ʽ���뵽ҵ�����
    FOR data_rec IN import_datas_cur LOOP
      --�ж������Ƿ�У��ɹ�
      IF data_rec.msg_type = 'E' OR data_rec.msg_type IS NULL THEN
        raise_application_error(-20002,
                                '���������Ƿ��Ѽ���ɹ����޸���ȷ�����ύ!');
      END IF;
    
      --zwh73ƽ̨�����û���������
      --czh У��ƽ̨�Ƿ������û�
      SELECT MAX(user_id)
        INTO v_huser_id
        FROM sys_user
       WHERE phone = data_rec.phone;
      --czh У��ƽ̨�Ƿ������û�������������ƽ̨�û�����������ҵ�˺�
      IF v_huser_id IS NULL THEN
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
           NULL,
           data_rec.phone,
           'f3d799fcc6ddbfcffd93ddf8fb88f39cadd55e',
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
      ELSE
        --czh У��ƽ̨�Ƿ������û�������ֱ��������ҵ�˺�
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
           v_huser_id,
           1,
           (SELECT u.nick_name FROM sys_user u WHERE u.user_id = v_huser_id), --czh update
           data_rec.user_name,
           data_rec.phone,
           0,
           'admin', --%currentusername%,
           SYSDATE,
           SYSDATE,
           data_rec.inner_emp_number);
      END IF;
    
      --�û�����ҵ 
    
      SELECT MAX(is_default), MAX(sort)
        INTO v_default, v_sort
        FROM scmdata.sys_user_company a
       WHERE a.user_id = nvl(v_huser_id, v_user_id);
    
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
         nvl(v_huser_id, v_user_id),
         data_rec.company_id,
         v_company_name,
         decode(v_default, NULL, 1, 0, 1, 1, 0),
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
          (scmdata.f_get_uuid(),
           data_rec.company_id,
           nvl(v_huser_id, v_user_id),
           v_role_id);
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
          (scmdata.f_get_uuid(),
           data_rec.company_id,
           nvl(v_huser_id, v_user_id),
           v_dept_id);
      
        --czh add ����Ȩ��
        pkg_data_privs.authorize_emp(p_company_id => data_rec.company_id,
                                     p_dept_id    => v_dept_id,
                                     p_user_id    => nvl(v_huser_id, v_user_id));
      
      END IF;
    
    END LOOP;
    --��������ʱ�������Լ�������Ϣ�������
    delete_sys_company_user_temp(p_company_id, p_user_id);
  END;

END sf_import_company_users_pkg;
/
