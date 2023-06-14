--0.查看
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

--1.附件上传
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
       '陈子豪' || i,
       '1817254357' || i,
       'CZH' || i,
       '男装',
       '管理员',
       i,
       'a972dd1ffe3b3a10e0533c281cac8fd7');
    --decode((i%2), 0, '男装', 1, '女装', '男装'),
  --decode((i%2), 0, '管理员', 1, '拥有者', '拥有者'));
  END LOOP;
END;

--2.进行校验
DECLARE
  v_num         NUMBER := 0;
  v_role_num    NUMBER;
  v_err_num     NUMBER := 0;
  v_msg_id      NUMBER;
  v_msg         VARCHAR2(2000);
  v_import_flag VARCHAR2(100);
  role_name_tb  scmdata.role_name_tb_type;
  --临时表数据
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
  
    --1.校验手机号
    SELECT COUNT(1)
      INTO v_num
      FROM scmdata.sys_user su
     WHERE su.phone = data_rec.phone
       AND rownum = 1;
    IF v_num > 0 THEN
      v_msg     := '手机号:' || data_rec.phone || '已在平台注册，请更换手机号！！</br>';
      v_err_num := v_err_num + 1;
    END IF;
  
    SELECT COUNT(1)
      INTO v_num
      FROM scmdata.sys_company_user_temp t
     WHERE t.phone = data_rec.phone
       AND t.user_id <> data_rec.user_id
       AND rownum = 1;
    IF v_num > 0 THEN
      v_msg     := v_msg || '导入数据中，手机号:' || data_rec.phone ||
                   '重复，请更换手机号！！</br>';
      v_err_num := v_err_num + 1;
    END IF;
  
    IF length(data_rec.phone) <> 11 THEN
      v_msg     := v_msg || '导入数据中，手机号:' || data_rec.phone ||
                   '的位数应为11位！！</br>';
      v_err_num := v_err_num + 1;
    END IF;
  
    --2.校验内部员工号，平台，导入表 不能重复
    SELECT COUNT(1)
      INTO v_num
      FROM scmdata.sys_company_user a
     WHERE a.inner_user_id = data_rec.inner_emp_number
       AND a.company_id = data_rec.company_id
       AND rownum = 1;
    IF v_num > 0 THEN
      v_msg     := v_msg || '内部员工号:' || data_rec.inner_emp_number ||
                   '平台中已存在，请更换内部员工号！！</br>';
      v_err_num := v_err_num + 1;
    END IF;
  
    SELECT COUNT(1)
      INTO v_num
      FROM scmdata.sys_company_user_temp t
     WHERE t.inner_emp_number = data_rec.inner_emp_number
       AND t.user_id <> data_rec.user_id
       AND rownum = 1;
    IF v_num > 0 THEN
      v_msg     := v_msg || '导入数据中，内部员工号:' || data_rec.inner_emp_number ||
                   '重复，请更换内部员工号！！</br>';
      v_err_num := v_err_num + 1;
    END IF;
  
    --3.部门名称，看组织架构是否有
    SELECT COUNT(1)
      INTO v_num
      FROM scmdata.sys_company_dept t
     WHERE t.company_id = data_rec.company_id
       AND t.dept_name = data_rec.dept_name;
  
    IF v_num > 0 THEN
      NULL;
    ELSE
      v_msg     := v_msg || '导入数据中，部门名称:' || data_rec.dept_name ||
                   '在组织架构中不存在，请填写正确的部门名称！！</br>';
      v_err_num := v_err_num + 1;
    END IF;
  
    --4.角色名称(多个) 当前企业角色列表是否有    
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
        v_msg     := v_msg || '导入数据中，角色名称:' || role_name_tb(i) ||
                     '在角色列表中不存在，请填写正确的角色名称！！</br>';
        v_err_num := v_err_num + 1;
      END IF;
    END LOOP;
  
    --5.将校验信息插入到导入信息表
    v_msg_id := scmdata.sys_company_import_msg_s.nextval;
  
    UPDATE scmdata.sys_company_user_temp t
       SET t.err_msg_id = v_msg_id
     WHERE t.user_id = data_rec.user_id;
  
    IF v_err_num > 0 THEN
      v_import_flag := '校验错误：共' || v_err_num || '处错误。';
      INSERT INTO scmdata.sys_company_import_msg
      VALUES
        (v_msg_id, 'E', v_import_flag || v_msg, SYSDATE);
      --清空错误记录
      v_num     := 0;
      v_err_num := 0;
      v_msg     := NULL;
    ELSE
      v_import_flag := '校验成功';
      INSERT INTO scmdata.sys_company_import_msg
      VALUES
        (v_msg_id, 'Y', v_import_flag, SYSDATE);
    END IF;
  
  END LOOP;
END;

--3.提交
DECLARE
  v_user_id         VARCHAR2(32); --用户表主键
  v_company_user_id VARCHAR2(32); --企业用户主键
  v_role_id         VARCHAR2(100); --企业角色主键
  v_dept_id         VARCHAR2(100); --企业部门主键
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
     WHERE t.company_id = 'a972dd1ffe3b3a10e0533c281cac8fd7'; --当前默认企业
BEGIN
  FOR data_rec IN import_datas_cur LOOP
    IF data_rec.msg_type = 'E' OR data_rec.msg_type IS NULL THEN
      raise_application_error(-20002,
                              '数据是否都检验成功，请检查修改后提交');
    END IF;
  END LOOP;
  --将临时表数据正式导入到业务表中
  FOR data_rec IN import_datas_cur LOOP
    v_user_id := scmdata.f_get_uuid();
    --1.平台用户
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
    --创建平台角色关系  触发器  
  
    --企业账号
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
  
    --用户的企业 
  
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
  
    --创建员工角色关系
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
  
    --员工归属到对应部门
    IF v_dept_id IS NOT NULL THEN
      INSERT INTO scmdata.sys_company_user_dept
        (user_dept_id, company_id, user_id, company_dept_id)
      VALUES
        (scmdata.f_get_uuid(), data_rec.company_id, v_user_id, v_dept_id);
    END IF;
  
  END LOOP;

END;

