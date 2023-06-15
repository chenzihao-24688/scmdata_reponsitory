CREATE OR REPLACE PACKAGE SCMDATA.pkg_sfcomm_msg IS

  /*=============================================================================
  
     包：
       pkg_sfcomm_msg(三福通用个人消息包)
  
     过程名:
       新增消息
  
     入参:
       v_inp_cpmsg_id         :  三福通用消息表Id
       v_inp_company_id       :  企业Id
       v_inp_receiver_emp_no  :  接收者内部员工号
       v_inp_msg_text         :  消息内容
       v_inp_create_id        :  创建人Id
       v_inp_create_time      :  创建时间
       v_inp_invoke_object    :  调用对象
  
     版本:
       2023-05-17_ZC314 : 新增消息
  
  ==============================================================================*/
  PROCEDURE p_tabapi_ins_sfcomm_msg
  (
    v_inp_cpmsg_id        IN scmdata.t_sfcommon_personal_msg.cpmsg_id%TYPE,
    v_inp_company_id      IN scmdata.t_sfcommon_personal_msg.company_id%TYPE,
    v_inp_receiver_emp_no IN scmdata.t_sfcommon_personal_msg.receiver_emp_no%TYPE,
    v_inp_msg_text        IN scmdata.t_sfcommon_personal_msg.msg_text%TYPE,
    v_inp_create_id       IN scmdata.t_sfcommon_personal_msg.create_id%TYPE,
    v_inp_create_time     IN scmdata.t_sfcommon_personal_msg.create_time%TYPE,
    v_inp_invoke_object   IN VARCHAR2
  );

  /*=============================================================================
  
     包：
       pkg_sfcomm_msg(三福通用个人消息包)
  
     过程名:
       消息状态修改
  
     入参:
       v_inp_cpmsg_id         :  三福通用消息表Id
       v_inp_company_id       :  企业Id
       v_inp_status           :  消息状态 PR-准备 SS-成功 ER-失败
       v_inp_update_id        :  创建人Id
       v_inp_update_time      :  创建时间
       v_inp_invoke_object    :  调用对象
  
     版本:
       2023-05-17_ZC314 : 消息状态修改
  
  ==============================================================================*/
  PROCEDURE p_tabapi_upd_sfcomm_msg_status
  (
    v_inp_cpmsg_id      IN scmdata.t_sfcommon_personal_msg.cpmsg_id%TYPE DEFAULT NULL,
    v_inp_company_id    IN scmdata.t_sfcommon_personal_msg.company_id%TYPE DEFAULT NULL,
    v_inp_status        IN scmdata.t_sfcommon_personal_msg.status%TYPE DEFAULT NULL,
    v_inp_update_id     IN scmdata.t_sfcommon_personal_msg.update_id%TYPE DEFAULT NULL,
    v_inp_update_time   IN scmdata.t_sfcommon_personal_msg.update_time%TYPE DEFAULT NULL,
    v_inp_invoke_object IN VARCHAR2
  );

  /*=============================================================================
  
     包：
       pkg_sfcomm_msg(三福通用个人消息包)
  
     函数名:
       是否存在消息未被发送
  
     入参:
       v_inp_cpmsg_id  :  消息Id
  
     返回值:
       Number 类型：0-没有消息未被发送 
                    1-还有消息未被发送
  
     版本:
       2023-05-17_ZC314 : 获取最早创建的消息, 消息Id, 企业Id
  
  ==============================================================================*/
  FUNCTION f_has_msg_not_send(v_inp_cpmsg_id IN VARCHAR2 DEFAULT NULL)
    RETURN NUMBER;

  /*=============================================================================
  
     包：
       pkg_sfcomm_msg(三福通用个人消息包)
  
     过程名:
       获取最早创建的消息, 消息Id, 企业Id
  
     入参:
       v_iop_cpmsg_id    :  消息Id
       v_iop_company_id  :  企业Id
       v_iop_send_msg    :  发送内容
  
     版本:
       2023-05-17_ZC314 : 获取最早创建的消息, 消息Id, 企业Id
  
  ==============================================================================*/
  PROCEDURE p_get_earliest_create_msg
  (
    v_iop_cpmsg_id   IN OUT VARCHAR2,
    v_iop_company_id IN OUT VARCHAR2,
    v_iop_send_msg   IN OUT VARCHAR2
  );

  /*=============================================================================
    
     包：
       pkg_sfcomm_msg(三福通用个人消息包)
      
     函数名:
       获取xxl_job特定执行参数任务启停状态
      
     入参:
       v_inp_executorparam  :  执行参数
      
     版本:
       2023-05-17_zc314 : 获取xxl_job特定执行参数任务启停状态
    
  ==============================================================================*/
  FUNCTION f_get_execute_param_trigger_status(v_inp_executorparam IN VARCHAR2)
    RETURN NUMBER;

  /*=============================================================================
    
     包：
       pkg_sfcomm_msg(三福通用个人消息包)
    
     过程名:
       启停xxl_job特定执行参数任务
    
     入参:
       v_inp_triggerstatus  :  触发器状态 0-停用 1-启用
       v_inp_executorparam  :  执行参数
       v_inp_invokeobj      :  调用对象
    
     版本:
       2023-05-17_zc314 : 启停xxl_job特定执行参数任务
    
  ==============================================================================*/
  PROCEDURE p_msg_updxxlinfotriggerstatus
  (
    v_inp_triggerstatus IN VARCHAR2,
    v_inp_executorparam IN VARCHAR2,
    v_inp_invokeobj     IN VARCHAR2
  );

  /*=============================================================================
  
     包：
       pkg_sfcomm_msg(三福通用个人消息包)
  
     过程名:
       获取最早创建的消息, 消息Id, 企业Id
  
     入参:
       v_inp_executorparam  :  执行器element_id
  
     版本:
       2023-05-17_ZC314 : 获取最早创建的消息, 消息Id, 企业Id
  
  ==============================================================================*/
  PROCEDURE p_sfcomm_msg_listener_logic(v_inp_executorparam IN VARCHAR2);

  /*=============================================================================
  
     包：
       pkg_sfcomm_msg(三福通用个人消息包)
  
     函数名:
       消息执行器逻辑
  
     入参:
       v_inp_executorparam   :  执行器element_id
       v_inp_current_userid  :  当前操作人Id
  
     版本:
       2023-05-17_ZC314 : 获取最早创建的消息, 消息Id, 企业Id
  
  ==============================================================================*/
  FUNCTION f_sfcomm_msg_executor_logic
  (
    v_inp_executorparam  IN VARCHAR2,
    v_inp_current_userid IN VARCHAR2
  ) RETURN VARCHAR2;

END pkg_sfcomm_msg;
/

CREATE OR REPLACE PACKAGE BODY SCMDATA.pkg_sfcomm_msg IS

  /*=============================================================================
  
     包：
       pkg_sfcomm_msg(三福通用个人消息包)
  
     过程名:
       新增消息
  
     入参:
       v_inp_cpmsg_id         :  三福通用消息表Id
       v_inp_company_id       :  企业Id
       v_inp_receiver_emp_no  :  接收者内部员工号
       v_inp_msg_text         :  消息内容
       v_inp_create_id        :  创建人Id
       v_inp_create_time      :  创建时间
       v_inp_invoke_object    :  调用对象
  
     版本:
       2023-05-17_ZC314 : 新增消息
  
  ==============================================================================*/
  PROCEDURE p_tabapi_ins_sfcomm_msg
  (
    v_inp_cpmsg_id        IN scmdata.t_sfcommon_personal_msg.cpmsg_id%TYPE,
    v_inp_company_id      IN scmdata.t_sfcommon_personal_msg.company_id%TYPE,
    v_inp_receiver_emp_no IN scmdata.t_sfcommon_personal_msg.receiver_emp_no%TYPE,
    v_inp_msg_text        IN scmdata.t_sfcommon_personal_msg.msg_text%TYPE,
    v_inp_create_id       IN scmdata.t_sfcommon_personal_msg.create_id%TYPE,
    v_inp_create_time     IN scmdata.t_sfcommon_personal_msg.create_time%TYPE,
    v_inp_invoke_object   IN VARCHAR2
  ) IS
    priv_exception        EXCEPTION;
    v_sql                 CLOB;
    v_error_info          CLOB;
    v_sql_errm            VARCHAR2(512);
    v_allow_invoke_object CLOB := '';
    v_self_description    VARCHAR2(1024) := '';
  BEGIN
    --访问控制
    IF instr(v_allow_invoke_object, v_inp_invoke_object) = 0 THEN
      v_sql_errm := '拒绝访问：调用方-' || v_inp_invoke_object || ' 被调用方-' ||
                    v_self_description;
      RAISE priv_exception;
    END IF;
  
    --执行 Sql 赋值
    v_sql := 'INSERT INTO scmdata.t_sfcommon_personal_msg
  (cpmsg_id, company_id, status, receiver_emp_no, msg_text, create_id, create_time)
VALUES
  (:v_inp_cpmsg_id, :v_inp_company_id, ''PR'', :v_inp_receiver_emp_no, :v_inp_msg_text, :v_inp_create_id, :v_inp_create_time)';
    --执行 Sql
    EXECUTE IMMEDIATE v_sql
      USING v_inp_cpmsg_id, v_inp_company_id, v_inp_receiver_emp_no, v_inp_msg_text, v_inp_create_id, v_inp_create_time;
  EXCEPTION
    WHEN priv_exception THEN
      --抛出报错
      raise_application_error(-20002, v_sql_errm);
    WHEN OTHERS THEN
      --错误信息赋值
      v_sql_errm   := substr(dbms_utility.format_error_stack, 1, 512);
      v_error_info := 'Error Object:' || v_self_description || chr(10) ||
                      'Error Info: ' || v_sql_errm || chr(10) ||
                      'Execute sql: ' || v_sql || chr(10) || 'Params: ' ||
                      chr(10) || 'v_inp_cpmsg_id: ' || v_inp_cpmsg_id ||
                      chr(10) || 'v_inp_company_id: ' || v_inp_company_id ||
                      chr(10) || 'v_inp_receiver_emp_no: ' ||
                      v_inp_receiver_emp_no || chr(10) ||
                      'v_inp_msg_text: ' || v_inp_msg_text || chr(10) ||
                      'v_inp_create_id: ' || v_inp_create_id || chr(10) ||
                      'v_inp_create_time: ' ||
                      to_char(v_inp_create_time, 'yyyyy-mm-dd hh24-mi-ss');
    
      --新增进入错误信息表
      scmdata.pkg_qa_ee.p_ins_errrecord_at(v_inp_errprogram     => v_self_description,
                                           v_inp_causeerruserid => v_inp_create_id,
                                           v_inp_erroccurtime   => SYSDATE,
                                           v_inp_errinfo        => v_error_info,
                                           v_inp_compid         => v_inp_company_id);
    
      --抛出报错
      raise_application_error(-20002, v_sql_errm);
  END p_tabapi_ins_sfcomm_msg;

  /*=============================================================================
  
     包：
       pkg_sfcomm_msg(三福通用个人消息包)
  
     过程名:
       消息状态修改
  
     入参:
       v_inp_cpmsg_id         :  三福通用消息表Id
       v_inp_company_id       :  企业Id
       v_inp_status           :  消息状态 PR-准备 SS-成功 ER-失败
       v_inp_update_id        :  创建人Id
       v_inp_update_time      :  创建时间
       v_inp_invoke_object    :  调用对象
  
     版本:
       2023-05-17_ZC314 : 消息状态修改
  
  ==============================================================================*/
  PROCEDURE p_tabapi_upd_sfcomm_msg_status
  (
    v_inp_cpmsg_id      IN scmdata.t_sfcommon_personal_msg.cpmsg_id%TYPE DEFAULT NULL,
    v_inp_company_id    IN scmdata.t_sfcommon_personal_msg.company_id%TYPE DEFAULT NULL,
    v_inp_status        IN scmdata.t_sfcommon_personal_msg.status%TYPE DEFAULT NULL,
    v_inp_update_id     IN scmdata.t_sfcommon_personal_msg.update_id%TYPE DEFAULT NULL,
    v_inp_update_time   IN scmdata.t_sfcommon_personal_msg.update_time%TYPE DEFAULT NULL,
    v_inp_invoke_object IN VARCHAR2
  ) IS
    priv_exception        EXCEPTION;
    v_sql                 CLOB;
    v_error_info          CLOB;
    v_sql_errm            VARCHAR2(512);
    v_allow_invoke_object CLOB := '';
    v_self_description    VARCHAR2(1024) := '';
  BEGIN
    --访问控制
    IF instr(v_allow_invoke_object, v_inp_invoke_object) = 0 THEN
      v_sql_errm := '拒绝访问：调用方-' || v_inp_invoke_object || ' 被调用方-' ||
                    v_self_description;
      RAISE priv_exception;
    END IF;
  
    --执行 Sql 赋值
    v_sql := 'UPDATE scmdata.t_sfcommon_personal_msg
   SET status      = :v_inp_status,
       update_id   = :v_inp_update_id,
       update_time = :v_inp_update_time
 WHERE cpmsg_id = :v_inp_cpmsg_id
   AND company_id = :v_inp_company_id';
    --执行 Sql
    EXECUTE IMMEDIATE v_sql
      USING v_inp_status, v_inp_update_id, v_inp_update_time, v_inp_cpmsg_id, v_inp_company_id;
  EXCEPTION
    WHEN priv_exception THEN
      --抛出报错
      raise_application_error(-20002, v_sql_errm);
    WHEN OTHERS THEN
      --错误信息赋值
      v_sql_errm   := substr(dbms_utility.format_error_stack, 1, 512);
      v_error_info := 'Error Object:' || v_self_description || chr(10) ||
                      'Error Info: ' || v_sql_errm || chr(10) ||
                      'Execute sql:' || v_sql || chr(10) || 'Params: ' ||
                      chr(10) || 'v_inp_status: ' || v_inp_status ||
                      chr(10) || 'v_inp_update_id: ' || v_inp_update_id ||
                      chr(10) || 'v_inp_update_time: ' ||
                      to_char(v_inp_update_time, 'yyyyy-mm-dd hh24-mi-ss') ||
                      chr(10) || 'v_inp_cpmsg_id: ' || v_inp_cpmsg_id ||
                      chr(10) || 'v_inp_company_id: ' || v_inp_company_id;
    
      --新增进入错误信息表
      scmdata.pkg_qa_ee.p_ins_errrecord_at(v_inp_errprogram     => v_self_description,
                                           v_inp_causeerruserid => v_inp_update_id,
                                           v_inp_erroccurtime   => SYSDATE,
                                           v_inp_errinfo        => v_error_info,
                                           v_inp_compid         => v_inp_company_id);
    
      --抛出报错
      raise_application_error(-20002, v_sql_errm);
  END p_tabapi_upd_sfcomm_msg_status;

  /*=============================================================================
  
     包：
       pkg_sfcomm_msg(三福通用个人消息包)
  
     函数名:
       是否存在消息未被发送
  
     返回值:
       Number 类型：0-没有消息未被发送 
                    1-还有消息未被发送
  
     版本:
       2023-05-17_ZC314 : 获取最早创建的消息, 消息Id, 企业Id
  
  ==============================================================================*/
  FUNCTION f_has_msg_not_send(v_inp_cpmsg_id IN VARCHAR2 DEFAULT NULL)
    RETURN NUMBER IS
    v_jugnum NUMBER(1);
  BEGIN
    IF v_inp_cpmsg_id IS NULL THEN
      SELECT decode(nvl(MAX(1), 0), 0, 1, 0)
        INTO v_jugnum
        FROM scmdata.t_sfcommon_personal_msg
       WHERE status = 'PR'
         AND rownum = 1;
    ELSE
      SELECT decode(nvl(MAX(1), 0), 0, 1, 0)
        INTO v_jugnum
        FROM scmdata.t_sfcommon_personal_msg
       WHERE status = 'PR'
         AND cpmsg_id <> v_inp_cpmsg_id
         AND rownum = 1;
    END IF;
  
    RETURN v_jugnum;
  END f_has_msg_not_send;

  /*=============================================================================
  
     包：
       pkg_sfcomm_msg(三福通用个人消息包)
  
     过程名:
       获取最早创建的消息, 消息Id, 企业Id
  
     入参:
       v_iop_cpmsg_id    :  消息Id
       v_iop_company_id  :  企业Id
       v_iop_send_msg    :  发送内容
  
     版本:
       2023-05-17_ZC314 : 获取最早创建的消息, 消息Id, 企业Id
  
  ==============================================================================*/
  PROCEDURE p_get_earliest_create_msg
  (
    v_iop_cpmsg_id   IN OUT VARCHAR2,
    v_iop_company_id IN OUT VARCHAR2,
    v_iop_send_msg   IN OUT VARCHAR2
  ) IS
    v_receiver VARCHAR2(32);
    v_msg      VARCHAR2(4000);
  BEGIN
    v_iop_cpmsg_id   := NULL;
    v_iop_company_id := NULL;
    v_iop_send_msg   := NULL;
  
    SELECT MAX(cpmsg_id),
           MAX(company_id),
           MAX(receiver_emp_no),
           MAX(msg_text)
      INTO v_iop_cpmsg_id,
           v_iop_company_id,
           v_receiver,
           v_msg
      FROM (SELECT cpmsg_id,
                   company_id,
                   receiver_emp_no,
                   msg_text
              FROM scmdata.t_sfcommon_personal_msg
             WHERE status = 'PR'
             ORDER BY create_time
             FETCH FIRST 1 rows ONLY);
  
    IF v_receiver IS NOT NULL
       AND v_msg IS NOT NULL THEN
      v_iop_send_msg := 'select to_clob(''{"portBody":[{"TEXT": "' || v_msg ||
                        '","EMP_NO": "' || v_receiver ||
                        '"}]}'') as requestjson from dual';
    
    END IF;
  END p_get_earliest_create_msg;

  /*=============================================================================
    
     包：
       pkg_sfcomm_msg(三福通用个人消息包)
      
     函数名:
       获取xxl_job特定执行参数任务启停状态
      
     入参:
       v_inp_executorparam  :  执行参数
      
     版本:
       2023-05-17_zc314 : 获取xxl_job特定执行参数任务启停状态
    
  ==============================================================================*/
  FUNCTION f_get_execute_param_trigger_status(v_inp_executorparam IN VARCHAR2)
    RETURN NUMBER IS
    v_trigger_status NUMBER(1);
  BEGIN
    SELECT MAX(trigger_status)
      INTO v_trigger_status
      FROM bw3.xxl_job_info
     WHERE executor_param = v_inp_executorparam;
  
    RETURN v_trigger_status;
  END f_get_execute_param_trigger_status;

  /*=============================================================================
    
     包：
       pkg_sfcomm_msg(三福通用个人消息包)
    
     过程名:
       启停xxl_job特定执行参数任务
    
     入参:
       v_inp_triggerstatus  :  触发器状态 0-停用 1-启用
       v_inp_executorparam  :  执行参数
       v_inp_invokeobj      :  调用对象
    
     版本:
       2023-05-17_zc314 : 启停xxl_job特定执行参数任务
    
  ==============================================================================*/
  PROCEDURE p_msg_updxxlinfotriggerstatus
  (
    v_inp_triggerstatus IN VARCHAR2,
    v_inp_executorparam IN VARCHAR2,
    v_inp_invokeobj     IN VARCHAR2
  ) IS
    priv_exception    EXCEPTION;
    v_compid          VARCHAR2(32) := 'b6cc680ad0f599cde0531164a8c0337f';
    v_sql             CLOB;
    v_errinfo         CLOB;
    v_sqlerrm         VARCHAR2(512);
    v_allowinvokeobj  CLOB := 'scmdata.pkg_sfcomm_msg.p_sfcomm_msg_listener_logic;scmdata.pkg_sfcomm_msg.p_sfcomm_msg_executor_logic';
    v_selfdescription VARCHAR2(1024) := 'scmdata.pkg_sfcomm_msg.p_msg_updxxlinfotriggerstatus';
  BEGIN
    --访问控制
    IF instr(v_allowinvokeobj, v_inp_invokeobj) = 0 THEN
      v_sqlerrm := '拒绝访问：调用方-' || v_inp_invokeobj || ' 被调用方-' ||
                   v_selfdescription;
      RAISE priv_exception;
    END IF;
  
    --构建执行sql
    v_sql := 'UPDATE bw3.xxl_job_info
   SET trigger_status = :v_inp_triggerstatus
 WHERE executor_param = :v_inp_executorparam';
  
    --执行sql
    EXECUTE IMMEDIATE v_sql
      USING v_inp_triggerstatus, v_inp_executorparam;
  EXCEPTION
    WHEN priv_exception THEN
      --抛出报错
      raise_application_error(-20002, v_sqlerrm);
    WHEN OTHERS THEN
      --错误信息赋值
      v_sqlerrm := substr(dbms_utility.format_error_stack, 1, 1024);
      v_errinfo := 'Error Object:' || v_selfdescription || chr(10) ||
                   'Error Info: ' || v_sqlerrm || chr(10) || 'Execute_sql:' ||
                   v_sql || chr(10) || 'Params: ' || chr(10) ||
                   'v_inp_triggerstatus: ' ||
                   to_number(v_inp_triggerstatus) || chr(10) ||
                   'v_inp_executorparam: ' || v_inp_executorparam;
    
      --新增进入错误信息表
      scmdata.pkg_qa_ee.p_ins_errrecord_at(v_inp_errprogram     => v_selfdescription,
                                           v_inp_causeerruserid => v_inp_invokeobj,
                                           v_inp_erroccurtime   => SYSDATE,
                                           v_inp_errinfo        => v_errinfo,
                                           v_inp_compid         => v_compid);
    
      --抛出报错
      raise_application_error(-20002, v_sqlerrm);
  END p_msg_updxxlinfotriggerstatus;

  /*=============================================================================
  
     包：
       pkg_sfcomm_msg(三福通用个人消息包)
  
     过程名:
       获取最早创建的消息, 消息Id, 企业Id
  
     入参:
       v_inp_executorparam  :  执行器element_id
  
     版本:
       2023-05-17_ZC314 : 获取最早创建的消息, 消息Id, 企业Id
  
  ==============================================================================*/
  PROCEDURE p_sfcomm_msg_listener_logic(v_inp_executorparam IN VARCHAR2) IS
    v_jugnum           NUMBER(1);
    v_trigger_status   NUMBER(1);
    v_self_description VARCHAR2(1024) := 'scmdata.pkg_sfcomm_msg.p_sfcomm_msg_listener_logic';
  BEGIN
    v_jugnum := f_has_msg_not_send;
  
    IF v_jugnum = 1 THEN
      v_trigger_status := f_get_execute_param_trigger_status(v_inp_executorparam => v_inp_executorparam);
    
      IF v_trigger_status = 0 THEN
        p_msg_updxxlinfotriggerstatus(v_inp_triggerstatus => 1,
                                      v_inp_executorparam => v_inp_executorparam,
                                      v_inp_invokeobj     => v_self_description);
      END IF;
    END IF;
  END p_sfcomm_msg_listener_logic;

  /*=============================================================================
  
     包：
       pkg_sfcomm_msg(三福通用个人消息包)
  
     函数名:
       消息执行器逻辑
  
     入参:
       v_inp_executorparam   :  执行器element_id
       v_inp_current_userid  :  当前操作人Id
  
     版本:
       2023-05-17_ZC314 : 获取最早创建的消息, 消息Id, 企业Id
  
  ==============================================================================*/
  FUNCTION f_sfcomm_msg_executor_logic
  (
    v_inp_executorparam  IN VARCHAR2,
    v_inp_current_userid IN VARCHAR2
  ) RETURN VARCHAR2 IS
    v_cpmsg_id         VARCHAR2(32);
    v_company_id       VARCHAR2(32);
    v_send_msg         VARCHAR2(4000);
    v_jugnum           NUMBER(1);
    v_trigger_status   NUMBER(1);
    v_self_description VARCHAR2(1024) := 'scmdata.pkg_sfcomm_msg.p_sfcomm_msg_listener_logic';
  BEGIN
    --获取最早创建消息
    p_get_earliest_create_msg(v_iop_cpmsg_id   => v_cpmsg_id,
                              v_iop_company_id => v_company_id,
                              v_iop_send_msg   => v_send_msg);
  
    --消息表Id和企业Id不为空
    IF v_cpmsg_id IS NOT NULL
       AND v_company_id IS NOT NULL THEN
      --消息为空
      IF v_send_msg IS NULL THEN
        --更新状态
        p_tabapi_upd_sfcomm_msg_status(v_inp_cpmsg_id      => v_cpmsg_id,
                                       v_inp_company_id    => v_company_id,
                                       v_inp_status        => 'NS',
                                       v_inp_update_id     => v_inp_current_userid,
                                       v_inp_update_time   => SYSDATE,
                                       v_inp_invoke_object => v_self_description);
      
      ELSE
        --更新状态
        p_tabapi_upd_sfcomm_msg_status(v_inp_cpmsg_id      => v_cpmsg_id,
                                       v_inp_company_id    => v_company_id,
                                       v_inp_status        => 'SS',
                                       v_inp_update_id     => v_inp_current_userid,
                                       v_inp_update_time   => SYSDATE,
                                       v_inp_invoke_object => v_self_description);
      END IF;
    
      --判断是否还存在消息未发送
      v_jugnum := f_has_msg_not_send(v_inp_cpmsg_id => v_cpmsg_id);
    
      --不存在消息未发送
      IF v_jugnum = 0 THEN
        --执行器状态获取
        v_trigger_status := f_get_execute_param_trigger_status(v_inp_executorparam => v_inp_executorparam);
      
        --执行器状态为启动中
        IF v_trigger_status = 1 THEN
          --停止执行器
          p_msg_updxxlinfotriggerstatus(v_inp_triggerstatus => 0,
                                        v_inp_executorparam => v_inp_executorparam,
                                        v_inp_invokeobj     => v_self_description);
        END IF;
      END IF;
    END IF;
  
    --返回消息
    RETURN v_send_msg;
  END f_sfcomm_msg_executor_logic;

END pkg_sfcomm_msg;
/

