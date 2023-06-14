CREATE OR REPLACE PACKAGE sf_import_company_users_pkg IS

  -- Author  : SANFU
  -- Created : 2020/8/25 15:03:32
  -- Purpose : 批量导入员工
  --分割
  FUNCTION get_strarraylength(av_str   VARCHAR2, --要分割的字符串
                              av_split VARCHAR2 --分隔符号
                              ) RETURN NUMBER;
  --提取
  FUNCTION get_strarraystrofindex(av_str   VARCHAR2, --要分割的字符串
                                  av_split VARCHAR2, --分隔符号
                                  av_index NUMBER --取第几个元素
                                  ) RETURN VARCHAR2;
  --提取字符数组
  FUNCTION get_strarray(av_str   VARCHAR2, --要分割的字符串
                        av_split VARCHAR2 --分隔符号
                        ) RETURN role_name_tb_type;

  --校验批量导入数据
  PROCEDURE check_importdatas(p_company_id           IN VARCHAR2,
                              p_user_id              IN VARCHAR2,
                              p_company_user_temp_id IN VARCHAR2);

  --清空导入信息表
  PROCEDURE delete_sys_company_import_msg(p_company_id IN VARCHAR2,
                                          p_user_id    IN VARCHAR2);

  --清空临时表，导入信息表的数据
  PROCEDURE delete_sys_company_user_temp(p_company_id IN VARCHAR2,
                                         p_user_id    IN VARCHAR2);
  --提交临时表至业务表
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
  * Purpose  : 分割
  * Obj_Name    : GET_STRARRAYLENGTH
  * Arg_Number  : 2
  * AV_STR : 要分割的字符串
  * AV_SPLIT :分隔符号
  *============================================*/

  FUNCTION get_strarraylength(av_str   VARCHAR2, --要分割的字符串
                              av_split VARCHAR2 --分隔符号
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
  * Purpose  : 提取
  * Obj_Name    : GET_STRARRAYSTROFINDEX
  * Arg_Number  : 3
  * AV_STR :要分割的字符串
  * AV_SPLIT :分隔符号
  * AV_INDEX :取第几个元素
  *============================================*/

  FUNCTION get_strarraystrofindex(av_str   VARCHAR2, --要分割的字符串
                                  av_split VARCHAR2, --分隔符号
                                  av_index NUMBER --取第几个元素
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
  * Purpose  :  获取字符数组
  * Obj_Name    : GET_STRARRAY
  * Arg_Number  : 2
  * AV_STR : 要分割的字符串
  * AV_SPLIT : 分隔符号
  *============================================*/

  FUNCTION get_strarray(av_str   VARCHAR2, --要分割的字符串
                        av_split VARCHAR2 --分隔符号
                        ) RETURN role_name_tb_type IS
  
    v_av_str   VARCHAR2(100) := av_str; --要切割的字符串
    v_av_split VARCHAR2(100) := av_split; --分割符
    v_length   NUMBER;
    --TYPE role_name_tb_type is table of varchar2(128);
    role_name_tb role_name_tb_type := role_name_tb_type();
  
  BEGIN
    v_length := scmdata.sf_import_company_users_pkg.get_strarraylength(v_av_str,
                                                                       v_av_split);
  
    FOR i IN 0 .. (v_length - 1) LOOP
      --扩展数组
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
  * Purpose  :  校验批量导入数据
  * Obj_Name    : GET_STRARRAY
  * Arg_Number  : 1
  * p_company_id : 当前默认企业id
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
    --临时表数据
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
      v_msg     := v_err_num || '.用户名不能为空！';
    END IF;
  
    IF data_rec.phone IS NULL THEN
      v_err_num := v_err_num + 1;
      v_msg     := v_msg || v_err_num || '.手机号不能为空！';
    
    END IF;
  
    IF data_rec.dept_name IS NULL THEN
      v_err_num := v_err_num + 1;
      v_msg     := v_msg || v_err_num || '.部门名称不能为空！';
    
    END IF;
  
    IF data_rec.group_role_name IS NULL THEN
      v_err_num := v_err_num + 1;
      v_msg     := v_msg || v_err_num || '.角色名称不能为空！';
    
    END IF;
  
    --1.校验手机号
    /* SELECT COUNT(1)
      INTO v_num
      FROM scmdata.sys_user su
     WHERE su.phone = data_rec.phone
       AND rownum = 1;
    
    IF v_num > 0 THEN
      v_err_num := v_err_num + 1;
      v_msg     := v_msg || v_err_num || '.手机号:[' || data_rec.phone ||
                   ']已在平台注册，请更换手机号！';
    
    END IF;*/
  
    --1.校验手机号 校验该企业是否已存在该账号
    SELECT COUNT(1)
      INTO v_num
      FROM scmdata.sys_company_user fc
     WHERE fc.company_id = data_rec.company_id
       AND fc.phone = data_rec.phone
       AND rownum = 1;
  
    IF v_num > 0 THEN
      v_err_num := v_err_num + 1;
      v_msg     := v_msg || v_err_num || '.当前手机号:[' || data_rec.phone ||
                   ']已加入企业，不可重复加入！！';
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
      v_msg     := v_msg || v_err_num || '.导入数据中，手机号:[' || data_rec.phone ||
                   ']重复，请更换手机号！';
    END IF;
  
    IF length(data_rec.phone) <> 11 THEN
      v_err_num := v_err_num + 1;
      v_msg     := v_msg || v_err_num || '.导入数据中，手机号:[' || data_rec.phone ||
                   ']的位数应为11位！';
    
    END IF;
  
    --2.校验内部员工号，平台，导入表 不能重复
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
        v_msg     := v_msg || v_err_num || '.内部员工号:[' ||
                     data_rec.inner_emp_number || ']平台中已存在，请更换内部员工号！';
      
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
        v_msg     := v_msg || v_err_num || '.导入数据中，内部员工号:[' ||
                     data_rec.inner_emp_number || ']重复，请更换内部员工号！';
      
      END IF;
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
      v_err_num := v_err_num + 1;
      v_msg     := v_msg || v_err_num || '.导入数据中，部门名称:[' ||
                   data_rec.dept_name || ']在组织架构中不存在，请填写正确的部门名称！';
    
    END IF;
  
    --4.角色名称(多个) 当前企业角色列表是否有  
    --获取字符数组  
    role_name_tb := scmdata.sf_import_company_users_pkg.get_strarray(data_rec.group_role_name,
                                                                     ';');
    FOR i IN 1 .. role_name_tb.count LOOP
      SELECT COUNT(1)
        INTO v_role_num
        FROM scmdata.sys_company_role t
       WHERE t.company_id = data_rec.company_id
         AND t.company_role_name = role_name_tb(i);
      IF v_role_num > 0 THEN
        --导入数据中角色名称不能为超级管理员角色
        IF role_name_tb(i) = '超级管理员' THEN
          v_err_num := v_err_num + 1;
          v_msg     := v_msg || v_err_num || '.导入数据中，角色名称不能为超级管理员！';
        ELSE
          NULL;
        END IF;
      ELSE
        v_err_num := v_err_num + 1;
        v_msg     := v_msg || v_err_num || '.导入数据中，角色名称:[' ||
                     role_name_tb(i) || ']在角色列表中不存在，请填写正确的角色名称！';
      
      END IF;
    
    END LOOP;
  
    --5.将校验信息插入到导入信息表
    v_msg_id := scmdata.sys_company_import_msg_s.nextval;
  
    UPDATE scmdata.sys_company_user_temp t
       SET t.err_msg_id = v_msg_id
     WHERE t.company_id = data_rec.company_id
       AND t.user_id = data_rec.user_id
       AND t.company_user_temp_id = p_company_user_temp_id;
  
    IF v_err_num > 0 THEN
      v_import_flag := '校验错误：共' || v_err_num || '处错误。';
      INSERT INTO scmdata.sys_company_import_msg
      VALUES
        (v_msg_id,
         'E',
         v_import_flag || v_msg,
         SYSDATE,
         data_rec.company_id,
         p_user_id);
      --清空错误记录
      /*      v_num     := 0;
      v_err_num := 0;
      v_msg     := NULL;*/
    ELSE
      v_import_flag := '校验成功';
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
  * Purpose  :  清空导入信息表的数据
  * Obj_Name    : delete_sys_company_import_msg
  * Arg_Number  : 1
  * p_company_id : 当前默认企业id
  *============================================*/

  PROCEDURE delete_sys_company_import_msg(p_company_id IN VARCHAR2,
                                          p_user_id    IN VARCHAR2) IS
  
  BEGIN
    --清空导入信息表的数据
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
  * Purpose  :  清空临时表，导入信息表的数据
  * Obj_Name    : delete_sys_company_user_temp
  * Arg_Number  : 1
  * p_company_id : 当前默认企业id
  *============================================*/
  PROCEDURE delete_sys_company_user_temp(p_company_id IN VARCHAR2,
                                         p_user_id    IN VARCHAR2) IS
  
  BEGIN
    --清空临时表，导入信息表的数据
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
  * Purpose  :  提交临时表至业务表
  * Obj_Name    : submit_sys_company_user_temp
  * Arg_Number  : 1
  * p_company_id : 当前默认企业id
  *============================================*/
  PROCEDURE submit_sys_company_user_temp(p_company_id IN VARCHAR2,
                                         p_user_id    IN VARCHAR2) IS
    v_user_id         VARCHAR2(32); --用户表主键
    v_company_user_id VARCHAR2(32); --企业用户主键
    v_huser_id        VARCHAR2(32); --已存在的用户表主键
    v_role_id         VARCHAR2(100); --企业角色主键
    v_dept_id         VARCHAR2(100); --企业部门主键
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
         AND t.user_id = p_user_id; --当前默认企业
  BEGIN
    /*    FOR data_rec IN import_datas_cur LOOP
      IF data_rec.msg_type = 'E' OR data_rec.msg_type IS NULL THEN
        raise_application_error(-20002,
                                '请检查数据是否都已检验成功，修改正确后再提交!');
      END IF;
    END LOOP;*/
    --将临时表数据正式导入到业务表中
    FOR data_rec IN import_datas_cur LOOP
      --判断数据是否都校验成功
      IF data_rec.msg_type = 'E' OR data_rec.msg_type IS NULL THEN
        raise_application_error(-20002,
                                '请检查数据是否都已检验成功，修改正确后再提交!');
      END IF;
    
      --zwh73平台已有用户，不插入
      --czh 校验平台是否已有用户
      SELECT MAX(user_id)
        INTO v_huser_id
        FROM sys_user
       WHERE phone = data_rec.phone;
      --czh 校验平台是否已有用户，无则先生成平台用户，再生成企业账号
      IF v_huser_id IS NULL THEN
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
      ELSE
        --czh 校验平台是否已有用户，有则直接生成企业账号
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
    
      --用户的企业 
    
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
    
      --员工归属到对应部门
      IF v_dept_id IS NOT NULL THEN
        INSERT INTO scmdata.sys_company_user_dept
          (user_dept_id, company_id, user_id, company_dept_id)
        VALUES
          (scmdata.f_get_uuid(),
           data_rec.company_id,
           nvl(v_huser_id, v_user_id),
           v_dept_id);
      
        --czh add 数据权限
        pkg_data_privs.authorize_emp(p_company_id => data_rec.company_id,
                                     p_dept_id    => v_dept_id,
                                     p_user_id    => nvl(v_huser_id, v_user_id));
      
      END IF;
    
    END LOOP;
    --最后清空临时表数据以及导入信息表的数据
    delete_sys_company_user_temp(p_company_id, p_user_id);
  END;

END sf_import_company_users_pkg;
/
