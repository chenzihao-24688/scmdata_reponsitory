CREATE OR REPLACE PACKAGE SCMDATA.pkg_queue IS

  /*=================================================================================
  
    修改执行器状态
  
    用途:
      用于修改执行器执行队列Id和状态
  
    入参:
      V_QUEUEEXEID    :  执行器Id
      V_COMPID        :  企业Id
      V_QUEEXESTATUS  :  队列执行器修改状态
  
    版本:
      2021-12-31 : 修改执行器执行队列Id和状态
  
  =================================================================================*/
  PROCEDURE p_change_queue_executor_status
  (
    v_queueexeid   IN VARCHAR2,
    v_compid       IN VARCHAR2,
    v_queexestatus IN VARCHAR2
  );

  /*=================================================================================
  
    修改执行器执行队列Id和状态（自治事务）
  
    用途:
      用于将执行器状态为特定值
  
    入参:
      V_QUEUEEXEID    :  执行器Id
      V_COMPID        :  企业Id
      V_QUEEXESTATUS  :  队列执行器修改状态
  
    版本:
      2021-12-31 : 用于将执行器状态为特定值
  
  =================================================================================*/
  PROCEDURE p_change_queue_executor_status_at
  (
    v_queueexeid   IN VARCHAR2,
    v_compid       IN VARCHAR2,
    v_queexestatus IN VARCHAR2
  );

  /*=================================================================================
  
    修改队列中所有状态值
  
    用途:
      用于将执行器和队列分别更新各自状态为不同值
  
    入参:
      V_QUEUEEXEID    :  执行器Id
      V_QUEUEID       :  队列Id
      V_COMPID        :  企业Id
      V_QUESTATUS     :  队列修改状态
      V_QUEEXESTATUS  :  队列执行器修改状态
  
    版本:
      2021-12-31 : 用于将执行器和队列分别更新各自状态为不同值
  
  =================================================================================*/
  PROCEDURE p_change_all_queue_status
  (
    v_queueexeid   IN VARCHAR2,
    v_queueid      IN VARCHAR2 DEFAULT NULL,
    v_compid       IN VARCHAR2,
    v_questatus    IN VARCHAR2,
    v_queexestatus IN VARCHAR2
  );

  /*=================================================================================
  
    生成队列执行器日志表记录
  
    用途:
      用于生成队列执行器日志表记录
  
    入参:
      V_QUEUEEXEID   :  队列执行器Id
      V_QUEUEID      :  队列Id
      V_QUEEXERST    :  队列执行结果
      V_EXEINFO      :  执行信息
      V_COMPID       :  企业Id
  
    版本:
      2022-01-13 : 生成队列执行器日志表记录
  
  =================================================================================*/
  PROCEDURE p_gen_queue_executor_log_rec
  (
    v_queueexeid IN VARCHAR2,
    v_queueid    IN VARCHAR2,
    v_queexerst  IN VARCHAR2,
    v_exeinfo    IN VARCHAR2,
    v_compid     IN VARCHAR2
  );

  /*=================================================================================
  
    【正常使用】队列状态修改（自治事务）
  
    用途:
      用于队列状态修改
  
    入参:
      V_QUEUEID    :  执行器Id
      V_COMPID     :  企业Id
      V_STATUS     :  状态
  
    版本:
      2022-06-07 : 用于将队列状态修改
  
  =================================================================================*/
  PROCEDURE p_cg_queue_status_at
  (
    v_queueid IN VARCHAR2,
    v_compid  IN VARCHAR2,
    v_status  IN VARCHAR2
  );

  /*=================================================================================
  
    执行核
  
    用途:
      用于将处于执行器中的队列
  
    入参:
      V_QUEUEEXEID :  执行器Id
      V_COMPID     :  企业Id
  
    版本:
      2021-12-31 : 用于调度器将队列中未执行且与在执行任务中不冲突的任务，
                   置入状态为等待的调度器
  
  =================================================================================*/
  PROCEDURE p_queue_executor_core
  (
    v_queueexeid IN VARCHAR2,
    v_compid     IN VARCHAR2
  );

  /*=================================================================================
  
    执行核调用
  
    用途:
      用于将处于执行器中的队列
  
    入参:
      V_QUEUEEXEID :  执行器Id
      V_COMPID     :  企业Id
  
    版本:
      2021-12-31 : 用于调度器将队列中未执行且与在执行任务中不冲突的任务，
                   置入状态为等待的调度器
  
  =================================================================================*/
  PROCEDURE p_queexecore_invoke
  (
    v_queueexeid IN VARCHAR2,
    v_compid     IN VARCHAR2
  );

  /*=================================================================================
  
    调度核
  
    用途:
      用于调度执行器中执行 queue_id
  
    入参:
      V_COMPID     :  企业Id
  
    版本:
      2022-05-14 : 调度执行器中执行 queue_id
  
  =================================================================================*/
  PROCEDURE p_dispatch_core(v_compid IN VARCHAR2);

  /*=================================================================================
  
    队列合并核
  
    用途:
      用于合并待执行的队列
  
    版本:
      2022-08-25 : 队列合并核
  
  =================================================================================*/
  PROCEDURE p_combinequeue_core;

  /*=================================================================================
  
    获取字段转换
  
    用途:
      用于获取字段转换
  
    入参:
      V_TAB         :  表名
      V_CKFIELDS    :  检验字段
      V_SEPSYMBOL   :  分隔符
      V_OPERMETHOD  :  操作方法
      V_MFTYPE      :  映射类型
  
    版本:
      2022-03-08 : 获取字段转换
  
  =================================================================================*/
  FUNCTION f_trans_fields
  (
    v_tab        IN VARCHAR2,
    v_ckfields   IN VARCHAR2,
    v_sepsymbol  IN VARCHAR2,
    v_opermethod IN VARCHAR2,
    v_mftype     IN VARCHAR2
  ) RETURN VARCHAR2;

  /*===================================================================================
  
    生成【通用值新增】字段解析sql
  
    用途:
      生成【通用值新增】字段解析sql
  
    用于:
      队列值变更表记录
  
    入参:
      V_TAB         :  表名
      V_CKFIELDS    :  校验字段，多值用逗号隔开
      V_CONDS       :  条件字段，用于确认该修改是在哪一行
  
    版本:
      2022-01-12 : 生成【通用值新增】字段解析sql
      2022-02-11 : 增加 OPERATE_ID, OPERATE_TIME 对 CREATE_ID, CREATE_TIME 的转化，
                   增加 OPERATE_TIME 转换为 “YYYY-MM-DD HH24-MI-SS” 格式字符串类型
  
  ===================================================================================*/
  FUNCTION f_get_inscolandval_sql
  (
    v_viewtab  IN VARCHAR2,
    v_ckfields IN VARCHAR2,
    v_conds    IN VARCHAR2
  ) RETURN CLOB;

  /*===================================================================================
  
    生成【通用值修改】字段解析sql
  
    用途:
      生成【通用值修改】字段解析sql
  
    用于:
      队列值变更表记录
  
    入参:
      V_TAB         :  表名
      V_UNQFIELDS   :  唯一列字段，多值用逗号隔开
      V_CKFIELDS    :  校验字段，多值用逗号隔开
      V_CONDS       :  条件字段，用于确认该修改是在哪一行
      V_PRESECOND   :  秒数，用于定位 x 秒之前未修改的数据
  
    版本:
      2022-01-12 : 生成【通用值修改】字段解析sql
      2022-01-17 : 增加未出队导致的 View 层表自身修改问题
      2022-02-11 : 增加 OPERATE_ID, OPERATE_TIME 对 UPDATE_ID, UPDATE_TIME 的转化，
                   增加 OPERATE_TIME 转换为 “YYYY-MM-DD HH24-MI-SS” 格式字符串类型
  
  ===================================================================================*/
  FUNCTION f_get_updcolandval_sql
  (
    v_tab       IN VARCHAR2,
    v_viewtab   IN VARCHAR2 DEFAULT NULL,
    v_unqfields IN VARCHAR2,
    v_ckfields  IN VARCHAR2,
    v_conds     IN VARCHAR2,
    v_presecond IN NUMBER DEFAULT NULL
  ) RETURN CLOB;

  /*===================================================================================
  
    生成【通用值删除】字段解析sql
  
    用途:
      生成【通用值删除】字段解析sql
  
    用于:
      队列值变更表记录
  
    入参:
      V_TAB         :  表名
      V_CKFIELDS    :  校验字段，多值用逗号隔开
      V_CONDS       :  条件字段，用于确认该修改是在哪一行
  
    版本:
      2022-01-12 : 生成【通用值删除】字段解析sql
  
  ===================================================================================*/
  FUNCTION f_get_delcolandval_sql
  (
    v_tab      IN VARCHAR2,
    v_ckfields IN VARCHAR2,
    v_conds    IN VARCHAR2
  ) RETURN CLOB;

  /*===================================================================================
  
    生成通用值变更解析sql
  
    用途:
      生成通用值变更解析sql
  
    用于:
      队列值变更表记录
  
    入参:
      V_TAB         :  表名
      V_VIEWTAB     :  显示表表名
      V_UNQFIELDS   :  唯一列字段，多值用逗号隔开
      V_CKFIELDS    :  校验字段，多值用逗号隔开
      V_CONDS       :  条件字段，用于确认该修改是在哪一行
      V_METHOD      :  操作方式 INS-新增 UPD-修改 DEL-删除
      V_PRESECOND   :  秒数，用于定位 x 秒之前未修改的数据
  
    版本:
      2022-01-12 : 生成通用值变更解析sql
  
  ===================================================================================*/
  FUNCTION f_get_cgcolandval_sql
  (
    v_tab       IN VARCHAR2,
    v_viewtab   IN VARCHAR2 DEFAULT NULL,
    v_unqfields IN VARCHAR2,
    v_ckfields  IN VARCHAR2,
    v_conds     IN VARCHAR2,
    v_method    IN VARCHAR2,
    v_presecond IN NUMBER
  ) RETURN CLOB;

  /*===================================================================================
  
    队列值变更新增核
  
    用途:
      调用生成一条队列值变更记录
  
    入参:
      V_QUEUEID   :  队列Id
      V_COMPID    :  企业Id
      V_VCTAB     :  值变更表
      V_VCCOL     :  值变更列，单值
      V_VCCOND    :  值变更条件
      V_RAWVAL    :  变更前值
      V_CURVAL    :  变更后值
      V_METHOD    :  变更方式
  
    版本:
      2022-01-12 : 队列值变更新增核
  
  ===================================================================================*/
  PROCEDURE p_gen_valuechange_rec
  (
    v_queueid IN VARCHAR2,
    v_compid  IN VARCHAR2,
    v_vctab   IN VARCHAR2,
    v_vccol   IN VARCHAR2,
    v_vccond  IN VARCHAR2,
    v_rawval  IN VARCHAR2,
    v_curval  IN VARCHAR2,
    v_method  IN VARCHAR2
  );

  /*===================================================================================
  
    生成队列值变更表记录
  
    用途:
      生成队列值变更表记录
  
    用于:
      记录入队前值变更信息
  
    入参:
      V_QUEUEID     :  队列Id
      V_COMPID      :  企业Id
      V_TAB         :  表名
      V_UNQFIELDS   :  唯一列字段，多值用逗号隔开
      V_CKFIELDS    :  校验字段，多值用逗号隔开
      V_CONDS       :  条件字段，用于确认该修改是在哪一行
      V_METHOD      :  值变更方式
  
    版本:
      2022-01-12 : 生成队列值变更表记录
      2022-01-15 : 加入 ViewTab 字段
  
  ===================================================================================*/
  PROCEDURE p_gen_queuevc_info
  (
    v_queueid   IN VARCHAR2,
    v_compid    IN VARCHAR2,
    v_tab       IN VARCHAR2,
    v_viewtab   IN VARCHAR2 DEFAULT NULL,
    v_unqfields IN VARCHAR2,
    v_ckfields  IN VARCHAR2,
    v_conds     IN VARCHAR2,
    v_method    IN VARCHAR2
  );

  /*=================================================================================
  
    获取基础队列执行器状态
  
    说明：
      获取基础队列队列执行器状态
  
    版本：
      2022-06-30 : ORDERED 订单接口重构
  
  =================================================================================*/
  FUNCTION f_get_basicqueue_executor_status RETURN VARCHAR2;

  /*=================================================================================
  
    新增进入基础队列
  
    说明：
      新增进入基础队列
  
    入参：
      V_EXELOGIC  :  执行逻辑
  
    版本：
      2022-06-30 : ORDERED 订单接口重构
  
  =================================================================================*/
  PROCEDURE p_ins_basic_queue(v_exelogic IN CLOB);

  /*=================================================================================
  
    单个顺序执行基础队列内执行逻辑
  
    说明：
      单个顺序执行基础队列内执行逻辑
  
    入参：
      V_ID        :  基础队列Id
      V_LOGIC     :  执行逻辑
      V_QESTATUS  :  队列执行器状态
  
    版本：
      2022-06-30 : ORDERED 订单接口重构
  
  =================================================================================*/
  PROCEDURE p_exe_basic_queue_one_by_one
  (
    v_id       IN VARCHAR2,
    v_logic    IN VARCHAR2,
    v_qestatus IN VARCHAR2
  );

  /*=================================================================================
  
    基础队列执行逻辑
  
    说明：
      基础队列执行逻辑
  
    版本：
      2022-06-30 : ORDERED 订单接口重构
  
  =================================================================================*/
  PROCEDURE p_basic_queue_exe;

  /*=================================================================================
    
    执行器状态更新（自治事务）
    
    入参:
      v_inp_queueexeid  :  执行器Id
      v_compid          :  企业id
      v_inp_status      :  状态
    
    版本:
      2022-12-29 : 执行器状态更新（自治事务）
    
  =================================================================================*/
  PROCEDURE p_upd_queueexecutorstatus_at
  (
    v_inp_queueexeid IN VARCHAR2,
    v_inp_compid     IN VARCHAR2,
    v_inp_status     IN VARCHAR2
  );

  /*=================================================================================
    
    执行器状态与队列Id更新（自治事务）
    
    入参:
      v_inp_queueexeid  :  执行器Id
      v_compid          :  企业id
      v_inp_status      :  状态
      v_inp_queueid     :  队列Id
    
    版本:
      2022-12-29 : 执行器状态与队列Id更新（自治事务）
    
  =================================================================================*/
  PROCEDURE p_upd_queueexecutorstatusandqueueid_at
  (
    v_inp_queueexeid IN VARCHAR2,
    v_inp_compid     IN VARCHAR2,
    v_inp_status     IN VARCHAR2,
    v_inp_queueid    IN VARCHAR2
  );

  /*=============================================================================
  
     过程名:
       【产能】启停xxl_job特定执行参数任务
  
     入参:
       v_inp_triggerstatus  :  触发器状态 0-停用 1-启用
       v_inp_executorparam  :  执行参数
  
     版本:
       2022-12-16_zc314 : 启停xxl_job特定执行参数任务
  
  ==============================================================================*/
  PROCEDURE p_capc_updxxlinfotriggerstatus
  (
    v_inp_triggerstatus IN NUMBER,
    v_inp_executorparam IN VARCHAR2
  );

  /*=============================================================================
  
     过程名:
       【产能】启停xxl_job特定执行参数任务(自治事务)
  
     入参:
       v_inp_triggerstatus  :  触发器状态 0-停用 1-启用
       v_inp_executorparam  :  执行参数
  
     版本:
       2022-12-16_zc314 : 启停xxl_job特定执行参数任务(自治事务)
  
  ==============================================================================*/
  PROCEDURE p_capc_updxxlinfotriggerstatus_at
  (
    v_inp_triggerstatus IN NUMBER,
    v_inp_executorparam IN VARCHAR2
  );

  /*===================================================================================
  
    函数名:
      获取最早未执行的队列Id
  
    用于:
      队列值变更表记录
  
    入参:
      v_inp_iswprecalc  :  是否为周产能重算 0-否 1-是
      v_inp_compid      :  企业Id
    返回值:
      Varchar2 类型，队列Id
  
    版本:
      2022-12-17 : 获取最早未执行的队列Id
  
  ===================================================================================*/
  FUNCTION f_get_earliestqueueid
  (
    v_inp_iswprecalc IN NUMBER,
    v_inp_compid     IN VARCHAR2
  ) RETURN VARCHAR2;

  /*=================================================================================
  
    过程名:
      【产能】产能调度逻辑（新）
  
    入参:
      v_inp_dispatcher      :  调度器 element_id
      v_inp_executor        :  执行器 element_id
      v_inp_queueexeid      :  队列执行器Id
      v_inp_compid          :  企业id
      v_inp_iswkplanrecalc  :  执行状态是否为周产能重算
                                   0-非周产能重算
                                   1-周产能重算
  
    版本:
      2022-12-16 : 产能调度逻辑（新）
  
  =================================================================================*/
  PROCEDURE p_capc_dispatchlogic
  (
    v_inp_dispatcher IN VARCHAR2,
    v_inp_executor   IN VARCHAR2,
    v_inp_compid     IN VARCHAR2,
    v_inp_iswprecalc IN NUMBER
  );

  /*=================================================================================
  
    执行核心逻辑（自治事务）
  
    入参:
      v_queueid  :  队列id
      v_compid   :  企业id
  
    版本:
      2022-12-16 : 执行核心逻辑（自治事务）
  
  =================================================================================*/
  PROCEDURE p_capc_queueexecutecore_at
  (
    v_queueid IN VARCHAR2,
    v_compid  IN VARCHAR2
  );

  /*=================================================================================
  
    执行器逻辑
  
    入参:
      v_inp_dispatcher  :  调度器 element_id
      v_inp_executor    :  执行器 element_id
      v_inp_queueexeid  :  执行器Id
      v_compid          :  企业id
  
    版本:
      2022-12-16 : 执行器逻辑
  
  =================================================================================*/
  PROCEDURE p_capc_executorlogic
  (
    v_inp_dispatcher IN VARCHAR2,
    v_inp_executor   IN VARCHAR2,
    v_inp_queueexeid IN VARCHAR2,
    v_inp_compid     IN VARCHAR2,
    v_inp_iswprecalc IN NUMBER
  );

  /*=================================================================================
  
    执行核心逻辑（新）
  
    入参:
      v_queueid  :  队列id
      v_compid   :  企业id
  
    版本:
      2022-12-16 : 执行核心逻辑（新）
  
  =================================================================================*/
  PROCEDURE p_capc_queueexecutecore_new
  (
    v_queueid IN VARCHAR2,
    v_compid  IN VARCHAR2
  );

  /*=================================================================================
  
    执行器逻辑（新）
  
    入参:
      v_inp_dispatcher      :  调度器 element_id
      v_inp_executor        :  执行器 element_id
      v_compid              :  企业id
      v_inp_iswkplanrecalc  :  执行状态是否为周产能重算
                                     0-非周产能重算
                                     1-周产能重算
  
    版本:
      2022-12-30 : 执行器逻辑（新）
  
  =================================================================================*/
  PROCEDURE p_capc_executorlogic_new
  (
    v_inp_dispatcher IN VARCHAR2,
    v_inp_executor   IN VARCHAR2,
    v_inp_compid     IN VARCHAR2,
    v_inp_iswprecalc IN NUMBER
  );

END pkg_queue;
/

CREATE OR REPLACE PACKAGE BODY SCMDATA.pkg_queue IS

  /*=================================================================================
  
    修改执行器状态
  
    用途:
      用于修改执行器执行队列Id和状态
  
    入参:
      V_QUEUEEXEID    :  执行器Id
      V_COMPID        :  企业Id
      V_QUEEXESTATUS  :  队列执行器修改状态
  
    版本:
      2021-12-31 : 修改执行器执行队列Id和状态
  
  =================================================================================*/
  PROCEDURE p_change_queue_executor_status
  (
    v_queueexeid   IN VARCHAR2,
    v_compid       IN VARCHAR2,
    v_queexestatus IN VARCHAR2
  ) IS
  
  BEGIN
    IF v_queexestatus = 'P' THEN
      UPDATE scmdata.t_queue_executor
         SET execute_status   = v_queexestatus,
             lastexecute_time = SYSDATE,
             queue_id         = NULL
       WHERE queueexe_id = v_queueexeid
         AND company_id = v_compid;
    ELSE
      UPDATE scmdata.t_queue_executor
         SET execute_status   = v_queexestatus,
             lastexecute_time = SYSDATE
       WHERE queueexe_id = v_queueexeid
         AND company_id = v_compid;
    END IF;
  END p_change_queue_executor_status;

  /*=================================================================================
  
    修改执行器执行队列Id和状态（自治事务）
  
    用途:
      用于将执行器状态为特定值
  
    入参:
      V_QUEUEEXEID    :  执行器Id
      V_COMPID        :  企业Id
      V_QUEEXESTATUS  :  队列执行器修改状态
  
    版本:
      2021-12-31 : 用于将执行器状态为特定值
  
  =================================================================================*/
  PROCEDURE p_change_queue_executor_status_at
  (
    v_queueexeid   IN VARCHAR2,
    v_compid       IN VARCHAR2,
    v_queexestatus IN VARCHAR2
  ) IS
    PRAGMA AUTONOMOUS_TRANSACTION;
  BEGIN
    p_change_queue_executor_status(v_queueexeid   => v_queueexeid,
                                   v_compid       => v_compid,
                                   v_queexestatus => v_queexestatus);
    COMMIT;
  END p_change_queue_executor_status_at;

  /*=================================================================================
  
    修改队列中所有状态值
  
    用途:
      用于将执行器和队列分别更新各自状态为不同值
  
    入参:
      V_QUEUEEXEID    :  执行器Id
      V_QUEUEID       :  队列Id
      V_COMPID        :  企业Id
      V_QUESTATUS     :  队列修改状态
      V_QUEEXESTATUS  :  队列执行器修改状态
  
    版本:
      2021-12-31 : 用于将执行器和队列分别更新各自状态为不同值
  
  =================================================================================*/
  PROCEDURE p_change_all_queue_status
  (
    v_queueexeid   IN VARCHAR2,
    v_queueid      IN VARCHAR2 DEFAULT NULL,
    v_compid       IN VARCHAR2,
    v_questatus    IN VARCHAR2,
    v_queexestatus IN VARCHAR2
  ) IS
  
  BEGIN
    IF v_queueid IS NOT NULL THEN
      UPDATE scmdata.t_queue
         SET queue_status = v_questatus
       WHERE queue_id = v_queueid
         AND company_id = v_compid;
    END IF;
  
    p_change_queue_executor_status(v_queueexeid   => v_queueexeid,
                                   v_compid       => v_compid,
                                   v_queexestatus => v_queexestatus);
  END p_change_all_queue_status;

  /*=================================================================================
  
    生成队列执行器日志表记录
  
    用途:
      用于生成队列执行器日志表记录
  
    入参:
      V_QUEUEEXEID   :  队列执行器Id
      V_QUEUEID      :  队列Id
      V_QUEEXERST    :  队列执行结果
      V_EXEINFO      :  执行信息
      V_COMPID       :  企业Id
  
    版本:
      2022-01-13 : 生成队列执行器日志表记录
  
  =================================================================================*/
  PROCEDURE p_gen_queue_executor_log_rec
  (
    v_queueexeid IN VARCHAR2,
    v_queueid    IN VARCHAR2,
    v_queexerst  IN VARCHAR2,
    v_exeinfo    IN VARCHAR2,
    v_compid     IN VARCHAR2
  ) IS
  
  BEGIN
    INSERT INTO scmdata.t_queue_executor_log
      (queueexelog_id, company_id, queueexe_id, queue_id, queueexe_result, queueexe_time, execute_info)
    VALUES
      (scmdata.f_get_uuid(), v_compid, v_queueexeid, v_queueid, v_queexerst, SYSDATE, v_exeinfo);
  END p_gen_queue_executor_log_rec;

  /*=================================================================================
  
    【正常使用】队列状态修改（自治事务）
  
    用途:
      用于队列状态修改
  
    入参:
      V_QUEUEID    :  执行器Id
      V_COMPID     :  企业Id
      V_STATUS     :  状态
  
    版本:
      2022-06-07 : 用于将队列状态修改
  
  =================================================================================*/
  PROCEDURE p_cg_queue_status_at
  (
    v_queueid IN VARCHAR2,
    v_compid  IN VARCHAR2,
    v_status  IN VARCHAR2
  ) IS
    PRAGMA AUTONOMOUS_TRANSACTION;
  BEGIN
    UPDATE scmdata.t_queue
       SET queue_status = v_status
     WHERE queue_id = v_queueid
       AND company_id = v_compid;
  
    COMMIT;
  END p_cg_queue_status_at;

  /*=================================================================================
  
    执行核
  
    用途:
      用于将处于执行器中的队列
  
    入参:
      V_QUEUEEXEID :  执行器Id
      V_COMPID     :  企业Id
  
    版本:
      2021-12-31 : 用于调度器将队列中未执行且与在执行任务中不冲突的任务，
                   置入状态为等待的调度器
  
  =================================================================================*/
  PROCEDURE p_queue_executor_core
  (
    v_queueexeid IN VARCHAR2,
    v_compid     IN VARCHAR2
  ) IS
    v_queueid     VARCHAR2(32);
    v_corelogic   VARCHAR2(1024);
    v_loglogicbef VARCHAR2(512);
    v_loglogicaft VARCHAR2(512);
    v_exesql      CLOB;
    v_stage       VARCHAR2(64);
    v_starttime   DATE;
    v_endtime     DATE;
  BEGIN
    SELECT MAX(queue_id)
      INTO v_queueid
      FROM scmdata.t_queue_executor
     WHERE queueexe_id = v_queueexeid
       AND company_id = v_compid;
  
    p_cg_queue_status_at(v_queueid => v_queueid,
                         v_compid  => v_compid,
                         v_status  => 'RN');
  
    scmdata.pkg_variable.p_ins_or_upd_variable_with_chaid_at(v_objid   => 'SCM_QUEEXE_REC',
                                                             v_compid  => v_compid,
                                                             v_varname => 'QUEEXE_STARTTIME',
                                                             v_vartype => 'DATE',
                                                             v_date    => SYSDATE,
                                                             v_chaid   => v_queueid);
  
    SELECT MAX(core_logic),
           MAX(log_logic_before),
           MAX(log_logic_after)
      INTO v_corelogic,
           v_loglogicbef,
           v_loglogicaft
      FROM scmdata.t_queue_cfg
     WHERE queue_type IN (SELECT queue_type
                            FROM scmdata.t_queue
                           WHERE queue_id = v_queueid
                             AND company_id = v_compid);
  
    IF v_corelogic IS NOT NULL THEN
      p_change_queue_executor_status_at(v_queueexeid   => v_queueexeid,
                                        v_compid       => v_compid,
                                        v_queexestatus => 'R');
      v_stage  := '执行逻辑阶段: ';
      v_exesql := 'DECLARE V_QUEUEID  VARCHAR2(32):=''' || v_queueid ||
                  '''; V_COMPID  VARCHAR2(32):=''' || v_compid || '''; ' ||
                  'BEGIN ' || v_loglogicbef || ' ' || v_corelogic || ' ' ||
                  v_loglogicaft || ' END;';
    
      EXECUTE IMMEDIATE v_exesql;
    
      v_stage := '日志记录阶段: ';
      p_gen_queue_executor_log_rec(v_queueexeid => v_queueexeid,
                                   v_queueid    => v_queueid,
                                   v_queexerst  => 'SS',
                                   v_exeinfo    => '队列：' || v_queueid ||
                                                   '执行成功',
                                   v_compid     => v_compid);
    
      v_stage := '更新队列状态阶段: ';
      p_change_all_queue_status(v_queueexeid   => v_queueexeid,
                                v_queueid      => v_queueid,
                                v_compid       => v_compid,
                                v_questatus    => 'SS',
                                v_queexestatus => 'P');
    END IF;
  
    scmdata.pkg_variable.p_ins_or_upd_variable_with_chaid_at(v_objid   => 'SCM_QUEEXE_REC',
                                                             v_compid  => v_compid,
                                                             v_varname => 'QUEEXE_ENDTIME',
                                                             v_vartype => 'DATE',
                                                             v_date    => SYSDATE,
                                                             v_chaid   => v_queueid);
  
    v_starttime := scmdata.pkg_variable.f_get_date_with_chaid(v_objid   => 'SCM_QUEEXE_REC',
                                                              v_compid  => v_compid,
                                                              v_varname => 'QUEEXE_STARTTIME',
                                                              v_chaid   => v_queueid);
  
    v_endtime := scmdata.pkg_variable.f_get_date_with_chaid(v_objid   => 'SCM_QUEEXE_REC',
                                                            v_compid  => v_compid,
                                                            v_varname => 'QUEEXE_ENDTIME',
                                                            v_chaid   => v_queueid);
  
    UPDATE scmdata.t_queue
       SET queueexe_time = v_starttime,
           outqueue_time = v_endtime
     WHERE queue_id = v_queueid
       AND company_id = v_compid;
  EXCEPTION
    WHEN OTHERS THEN
      p_change_all_queue_status(v_queueexeid   => v_queueexeid,
                                v_queueid      => v_queueid,
                                v_compid       => v_compid,
                                v_questatus    => 'ER',
                                v_queexestatus => 'P');
    
      p_gen_queue_executor_log_rec(v_queueexeid => v_queueexeid,
                                   v_queueid    => v_queueid,
                                   v_queexerst  => 'ER',
                                   v_exeinfo    => '队列：' || v_queueid ||
                                                   v_stage ||
                                                   dbms_utility.format_error_stack,
                                   v_compid     => v_compid);
  END p_queue_executor_core;

  /*=================================================================================
  
    执行核调用
  
    用途:
      用于将处于执行器中的队列
  
    入参:
      V_QUEUEEXEID :  执行器Id
      V_COMPID     :  企业Id
  
    版本:
      2021-12-31 : 用于调度器将队列中未执行且与在执行任务中不冲突的任务，
                   置入状态为等待的调度器
  
  =================================================================================*/
  PROCEDURE p_queexecore_invoke
  (
    v_queueexeid IN VARCHAR2,
    v_compid     IN VARCHAR2
  ) IS
    v_jugnum NUMBER(1);
  BEGIN
    SELECT COUNT(1)
      INTO v_jugnum
      FROM scmdata.t_queue_executor qe
     WHERE queueexe_id = v_queueexeid
       AND execute_status = 'P'
       AND queue_id IS NOT NULL
       AND company_id = v_compid
       AND EXISTS (SELECT 1
              FROM scmdata.t_queue
             WHERE queue_id = qe.queue_id
               AND company_id = qe.company_id
               AND queue_status = 'PR')
       AND rownum = 1;
  
    IF v_jugnum > 0 THEN
      scmdata.pkg_queue.p_queue_executor_core(v_queueexeid => v_queueexeid,
                                              v_compid     => v_compid);
    END IF;
  
    COMMIT;
  END p_queexecore_invoke;

  /*=================================================================================
  
    队列合并核
  
    用途:
      用于合并待执行的队列
  
    版本:
      2022-08-25 : 队列合并核
  
  =================================================================================*/
  PROCEDURE p_combinequeue_core IS
    v_insnum  NUMBER(8);
    v_updnum  NUMBER(8);
    v_delnum  NUMBER(8);
    v_jugnum  NUMBER(1);
    v_queueid VARCHAR2(32);
    v_compid  VARCHAR2(32);
  BEGIN
    FOR i IN (SELECT vc_tab,
                     vc_cond,
                     company_id
                FROM (SELECT qvc.vc_tab,
                             qvc.vc_cond,
                             qvc.company_id,
                             COUNT(DISTINCT qvc.queue_id) qcn
                        FROM scmdata.t_queue_valchange qvc
                       WHERE EXISTS
                       (SELECT 1
                                FROM scmdata.t_queue
                               WHERE queue_status = 'PR'
                                 AND queue_id = qvc.queue_id
                                 AND company_id = qvc.company_id)
                       GROUP BY vc_tab,
                                vc_cond,
                                company_id)
               WHERE qcn > 1) LOOP
      SELECT COUNT(DISTINCT CASE
                     WHEN vc_method = 'INS' THEN
                      queue_id
                     ELSE
                      NULL
                   END),
             COUNT(DISTINCT CASE
                     WHEN vc_method = 'UPD' THEN
                      queue_id
                     ELSE
                      NULL
                   END),
             COUNT(DISTINCT CASE
                     WHEN vc_method = 'DEL' THEN
                      queue_id
                     ELSE
                      NULL
                   END)
        INTO v_insnum,
             v_updnum,
             v_delnum
        FROM scmdata.t_queue_valchange tmp
       WHERE vc_tab = i.vc_tab
         AND vc_cond = i.vc_cond
         AND EXISTS (SELECT 1
                FROM scmdata.t_queue
               WHERE queue_status = 'PR'
                 AND queue_id = tmp.queue_id
                 AND company_id = tmp.company_id);
      IF v_delnum > 0
         AND (v_insnum > 0 OR v_updnum > 0) THEN
        UPDATE scmdata.t_queue tab1
           SET queue_status = 'NR'
         WHERE EXISTS (SELECT 1
                  FROM scmdata.t_queue_valchange
                 WHERE queue_id = tab1.queue_id
                   AND company_id = tab1.company_id
                   AND vc_tab = i.vc_tab
                   AND vc_cond = i.vc_cond
                   AND vc_method IN ('INS', 'UPD'));
      ELSIF v_insnum > 0
            AND v_updnum > 0 THEN
        SELECT MAX(queue_id),
               MAX(company_id)
          INTO v_queueid,
               v_compid
          FROM scmdata.t_queue_valchange tmp1
         WHERE vc_tab = i.vc_tab
           AND vc_cond = i.vc_cond
           AND vc_method = 'INS'
           AND EXISTS (SELECT 1
                  FROM scmdata.t_queue
                 WHERE queue_id = tmp1.queue_id
                   AND company_id = tmp1.company_id
                   AND queue_status = 'PR');
      
        FOR l IN (SELECT b.vc_tab,
                         b.vc_col,
                         b.vc_rawval,
                         b.vc_curval
                    FROM scmdata.t_queue a
                    LEFT JOIN scmdata.t_queue_valchange b
                      ON a.queue_id = b.queue_id
                     AND a.company_id = b.company_id
                   WHERE a.queue_status = 'PR'
                     AND b.vc_tab = i.vc_tab
                     AND b.vc_cond = i.vc_cond
                     AND b.vc_method = 'UPD'
                   ORDER BY a.create_time) LOOP
          SELECT nvl(MAX(1), 0)
            INTO v_jugnum
            FROM scmdata.t_queue_valchange
           WHERE queue_id = v_queueid
             AND company_id = v_compid;
        
          IF v_jugnum = 0 THEN
            INSERT INTO scmdata.t_queue_valchange
              (valchange_id, company_id, queue_id, vc_tab, vc_col, vc_cond, vc_rawval, vc_curval, vc_method)
            VALUES
              (scmdata.f_get_uuid(), v_compid, v_queueid, l.vc_tab, l.vc_col, i.vc_cond, l.vc_rawval, l.vc_curval, 'INS');
          ELSE
            UPDATE scmdata.t_queue_valchange
               SET vc_rawval = l.vc_rawval,
                   vc_curval = l.vc_curval
             WHERE queue_id = v_queueid
               AND vc_col = l.vc_col
               AND company_id = v_compid;
          END IF;
        END LOOP;
      
        UPDATE scmdata.t_queue tab2
           SET queue_status = 'NR'
         WHERE EXISTS (SELECT 1
                  FROM scmdata.t_queue_valchange
                 WHERE queue_id = tab2.queue_id
                   AND company_id = tab2.company_id
                   AND vc_tab = i.vc_tab
                   AND vc_cond = i.vc_cond
                   AND vc_method = 'UPD');
      
      ELSIF v_updnum > 1 THEN
        SELECT MAX(queue_id),
               MAX(company_id)
          INTO v_queueid,
               v_compid
          FROM (SELECT a.queue_id,
                       a.company_id
                  FROM scmdata.t_queue a
                 INNER JOIN scmdata.t_queue_valchange b
                    ON a.queue_id = b.queue_id
                 WHERE b.vc_tab = i.vc_tab
                   AND b.vc_cond = i.vc_cond
                 ORDER BY a.create_time
                 FETCH FIRST 1 rows ONLY);
      
        FOR l IN (SELECT a.queue_id,
                         a.company_id,
                         b.vc_col,
                         b.vc_rawval,
                         b.vc_curval
                    FROM scmdata.t_queue a
                   INNER JOIN scmdata.t_queue_valchange b
                      ON a.queue_id = b.queue_id
                   WHERE a.queue_id <> v_queueid
                     AND a.company_id = v_compid
                     AND b.vc_tab = i.vc_tab
                     AND b.vc_cond = i.vc_cond
                   ORDER BY a.create_time) LOOP
          SELECT nvl(MAX(1), 0)
            INTO v_jugnum
            FROM scmdata.t_queue_valchange
           WHERE queue_id = v_queueid
             AND company_id = v_compid
             AND vc_col = l.vc_col;
        
          IF v_jugnum = 1 THEN
            UPDATE scmdata.t_queue_valchange
               SET vc_curval = l.vc_curval
             WHERE queue_id = v_queueid
               AND company_id = v_compid
               AND vc_col = l.vc_col;
          ELSE
            INSERT INTO scmdata.t_queue_valchange
              (valchange_id, company_id, queue_id, vc_tab, vc_col, vc_cond, vc_rawval, vc_curval, vc_method)
            VALUES
              (scmdata.f_get_uuid(), v_compid, v_queueid, i.vc_tab, l.vc_col, i.vc_cond, l.vc_rawval, l.vc_curval, 'UPD');
          END IF;
        
          UPDATE scmdata.t_queue
             SET queue_status = 'NR'
           WHERE queue_id = l.queue_id
             AND company_id = l.company_id;
        END LOOP;
      END IF;
    END LOOP;
  END p_combinequeue_core;

  /*=================================================================================
  
    调度核
  
    用途:
      用于调度执行器中执行 queue_id
  
    入参:
      V_COMPID     :  企业Id
  
    版本:
      2022-05-14 : 调度执行器中执行 queue_id
      2022-06-20 : 增加 scmdata.t_queue.is_iflrowsgened 校验
  
  =================================================================================*/
  PROCEDURE p_dispatch_core(v_compid IN VARCHAR2) IS
    v_status VARCHAR2(8);
    v_exnum  NUMBER(4);
    v_quenum NUMBER(4);
    v_jugnum NUMBER(1);
  BEGIN
    --合并多余队列
    p_combinequeue_core;
  
    --校验执行器状态，如果为待执行，执行后续步骤并修改调度器状态为运行中
    SELECT MAX(var_varchar)
      INTO v_status
      FROM scmdata.t_variable
     WHERE obj_id = 'SCM_QUEUE_SCHEDULER'
       AND var_name = 'STATUS'
       AND company_id = v_compid;
  
    --如果没有，新增该变量，变量值为 P
    IF v_status IS NULL
       OR v_status = 'P' THEN
      scmdata.pkg_variable.p_ins_or_upd_variable_at(v_objid   => 'SCM_QUEUE_SCHEDULER',
                                                    v_compid  => v_compid,
                                                    v_varname => 'STATUS',
                                                    v_vartype => 'VARCHAR',
                                                    v_varchar => 'R');
    
      --获取未分配状态执行器数量
      SELECT COUNT(1)
        INTO v_exnum
        FROM scmdata.t_queue_executor
       WHERE queue_id IS NULL
         AND company_id = v_compid;
    
      --获取准备状态的 queue 数量
      SELECT COUNT(1)
        INTO v_quenum
        FROM scmdata.t_queue tmpq
       WHERE queue_status = 'PR'
         AND is_iflrowsgened = 0
         AND company_id = v_compid
         AND NOT EXISTS (SELECT 1
                FROM scmdata.t_queue_executor
               WHERE queue_id = tmpq.queue_id
                 AND company_id = tmpq.company_id);
    
      --校验，当未分配状态执行器数量大于0且准备状态的 queue 数量大于0时执行后续步骤
      IF v_exnum > 0
         AND v_quenum > 0 THEN
        --隐式游标获取未分配状态执行器数量并对改执行器置入 queue_id
        --|（不管状态的原因是: 最终执行不论是否正确 executor 的 queue_id 会被清空）
        <<queexeloop>>
        FOR i IN (SELECT queueexe_id,
                         company_id
                    FROM scmdata.t_queue_executor
                   WHERE queue_id IS NULL
                     AND company_id = v_compid) LOOP
          IF v_exnum = 0 THEN
            EXIT queexeloop;
          END IF;
          --校验当前 queue_id 是否与执行器中已存在的 queue_id 冲突，不冲突，置入，冲突则继续step5
          <<queueloop>>
          FOR l IN (SELECT queue_id,
                           company_id
                      FROM scmdata.t_queue
                     WHERE queue_status = 'PR'
                       AND is_iflrowsgened = 0
                       AND company_id = v_compid
                     ORDER BY create_time) LOOP
            SELECT COUNT(1)
              INTO v_jugnum
              FROM (SELECT ir_tab,
                           ir_colname1,
                           ir_colvalue1,
                           ir_colname2,
                           ir_colvalue2,
                           ir_colname3,
                           ir_colvalue3,
                           ir_colname4,
                           ir_colvalue4,
                           ir_colname5,
                           ir_colvalue5,
                           ir_colname6,
                           ir_colvalue6
                      FROM scmdata.t_queue_iflrows qi
                     WHERE queue_id = l.queue_id
                       AND company_id = l.company_id) a,
                   (SELECT ir_tab,
                           ir_colname1,
                           ir_colvalue1,
                           ir_colname2,
                           ir_colvalue2,
                           ir_colname3,
                           ir_colvalue3,
                           ir_colname4,
                           ir_colvalue4,
                           ir_colname5,
                           ir_colvalue5,
                           ir_colname6,
                           ir_colvalue6
                      FROM scmdata.t_queue_executor exe
                     INNER JOIN scmdata.t_queue_iflrows ifl
                        ON exe.queue_id = ifl.queue_id
                       AND exe.company_id = ifl.company_id
                     WHERE exe.queue_id IS NOT NULL) b
             WHERE a.ir_tab = b.ir_tab
               AND a.ir_colname1 = b.ir_colname1
               AND (nvl(a.ir_colvalue1, b.ir_colvalue1) = b.ir_colvalue1 OR
                   a.ir_colvalue1 = nvl(b.ir_colvalue1, a.ir_colvalue1) OR
                   nvl(a.ir_colvalue1, ' ') = nvl(b.ir_colvalue1, ' '))
               AND a.ir_colname2 = b.ir_colname2
               AND (nvl(a.ir_colvalue2, b.ir_colvalue2) = b.ir_colvalue2 OR
                   a.ir_colvalue2 = nvl(b.ir_colvalue2, a.ir_colvalue2) OR
                   nvl(a.ir_colvalue2, ' ') = nvl(b.ir_colvalue2, ' '))
               AND a.ir_colname3 = b.ir_colname3
               AND (nvl(a.ir_colvalue3, b.ir_colvalue3) = b.ir_colvalue3 OR
                   a.ir_colvalue3 = nvl(b.ir_colvalue3, a.ir_colvalue3) OR
                   nvl(a.ir_colvalue3, ' ') = nvl(b.ir_colvalue3, ' '))
               AND a.ir_colname4 = b.ir_colname4
               AND (nvl(a.ir_colvalue4, b.ir_colvalue4) = b.ir_colvalue4 OR
                   a.ir_colvalue4 = nvl(b.ir_colvalue4, a.ir_colvalue4) OR
                   nvl(a.ir_colvalue4, ' ') = nvl(b.ir_colvalue4, ' '))
               AND a.ir_colname5 = b.ir_colname5
               AND (nvl(a.ir_colvalue5, b.ir_colvalue5) = b.ir_colvalue5 OR
                   a.ir_colvalue5 = nvl(b.ir_colvalue5, a.ir_colvalue5) OR
                   nvl(a.ir_colvalue5, ' ') = nvl(b.ir_colvalue5, ' '))
               AND a.ir_colname6 = b.ir_colname6
               AND (nvl(a.ir_colvalue6, b.ir_colvalue6) = b.ir_colvalue6 OR
                   a.ir_colvalue6 = nvl(b.ir_colvalue6, a.ir_colvalue6) OR
                   nvl(a.ir_colvalue6, ' ') = nvl(b.ir_colvalue6, ' '))
               AND rownum = 1;
          
            IF v_jugnum = 0 THEN
              UPDATE scmdata.t_queue_executor
                 SET queue_id = l.queue_id
               WHERE queueexe_id = i.queueexe_id
                 AND company_id = i.company_id;
            
              v_quenum := v_quenum - 1;
            END IF;
          
            IF v_quenum = 0 THEN
              EXIT queexeloop;
            END IF;
          END LOOP queueloop;
          v_exnum := v_exnum - 1;
        END LOOP queexeloop;
      END IF;
    
      --修改调度器状态为待执行
      scmdata.pkg_variable.p_ins_or_upd_variable_at(v_objid   => 'SCM_QUEUE_SCHEDULER',
                                                    v_compid  => v_compid,
                                                    v_varname => 'STATUS',
                                                    v_vartype => 'VARCHAR',
                                                    v_varchar => 'P');
    END IF;
  EXCEPTION
    WHEN OTHERS THEN
      --修改调度器状态为待执行
      scmdata.pkg_variable.p_ins_or_upd_variable_at(v_objid   => 'SCM_QUEUE_SCHEDULER',
                                                    v_compid  => v_compid,
                                                    v_varname => 'STATUS',
                                                    v_vartype => 'VARCHAR',
                                                    v_varchar => 'P');
  END p_dispatch_core;

  /*=================================================================================
  
    获取字段转换
  
    用途:
      用于获取字段转换
  
    入参:
      V_TAB         :  表名
      V_CKFIELDS    :  检验字段
      V_SEPSYMBOL   :  分隔符
      V_OPERMETHOD  :  操作方法
      V_MFTYPE      :  映射类型
  
    版本:
      2022-03-08 : 获取字段转换
  
  =================================================================================*/
  FUNCTION f_trans_fields
  (
    v_tab        IN VARCHAR2,
    v_ckfields   IN VARCHAR2,
    v_sepsymbol  IN VARCHAR2,
    v_opermethod IN VARCHAR2,
    v_mftype     IN VARCHAR2
  ) RETURN VARCHAR2 IS
    v_transcol  VARCHAR2(256);
    v_retfields VARCHAR2(2048);
  BEGIN
    FOR i IN (SELECT regexp_substr(v_ckfields,
                                   '[^' || v_sepsymbol || ']+',
                                   1,
                                   LEVEL) col
                FROM dual
              CONNECT BY LEVEL <=
                         regexp_count(v_ckfields, '\' || v_sepsymbol) + 1) LOOP
      SELECT MAX(vc_mapcol)
        INTO v_transcol
        FROM scmdata.t_queue_vcmapping
       WHERE vc_tab = v_tab
         AND vc_col = i.col
         AND oper_method = v_opermethod
         AND mapfield_type = v_mftype;
    
      IF v_transcol IS NULL THEN
        v_transcol := i.col;
      END IF;
    
      v_retfields := v_retfields || v_sepsymbol || v_transcol;
    END LOOP;
  
    RETURN ltrim(v_retfields, v_sepsymbol);
  END f_trans_fields;

  /*===================================================================================
  
    生成【通用值新增】字段解析sql
  
    用途:
      生成【通用值新增】字段解析sql
  
    用于:
      队列值变更表记录
  
    入参:
      V_TAB         :  表名
      V_CKFIELDS    :  校验字段，多值用逗号隔开
      V_CONDS       :  条件字段，用于确认该修改是在哪一行
  
    版本:
      2022-01-12 : 生成【通用值新增】字段解析sql
      2022-02-11 : 增加 OPERATE_ID, OPERATE_TIME 对 CREATE_ID, CREATE_TIME 的转化，
                   增加 OPERATE_TIME 转换为 “YYYY-MM-DD HH24-MI-SS” 格式字符串类型
  
  ===================================================================================*/
  FUNCTION f_get_inscolandval_sql
  (
    v_viewtab  IN VARCHAR2,
    v_ckfields IN VARCHAR2,
    v_conds    IN VARCHAR2
  ) RETURN CLOB IS
    v_withpart VARCHAR2(512);
    v_seppart  VARCHAR2(4000);
    v_transcol VARCHAR2(256);
    v_transval VARCHAR2(256);
    v_retsql   VARCHAR2(4000);
  BEGIN
    v_withpart := 'WITH TMP AS (SELECT * FROM ' || v_viewtab || ' WHERE ' ||
                  v_conds || ') ';
  
    FOR j IN (SELECT regexp_substr(v_ckfields, '[^,]+', 1, LEVEL) col
                FROM dual
              CONNECT BY LEVEL <= regexp_count(v_ckfields, '\,') + 1) LOOP
      SELECT MAX(CASE
                   WHEN mapfield_type = 'COL' THEN
                    vc_mapcol
                 END),
             MAX(CASE
                   WHEN mapfield_type = 'VAL' THEN
                    vc_mapcol
                 END)
        INTO v_transcol,
             v_transval
        FROM scmdata.t_queue_vcmapping
       WHERE vc_tab = v_viewtab
         AND vc_col = j.col
         AND oper_method = 'INS';
    
      IF v_transcol IS NULL THEN
        v_transcol := j.col;
      END IF;
    
      IF v_transval IS NULL THEN
        v_transval := j.col;
      END IF;
    
      IF v_seppart IS NULL THEN
        v_seppart := 'SELECT ''' || v_transcol ||
                     ''' COL_NAME, '''' COL_RAWVAL, TO_CHAR(' || v_transval ||
                     ') COL_CURVAL FROM TMP ';
      ELSE
        v_seppart := v_seppart || ' UNION ALL SELECT ''' || v_transcol ||
                     ''' COL_NAME, '''' COL_RAWVAL, TO_CHAR(' || v_transval ||
                     ') COL_CURVAL FROM TMP ';
      END IF;
    END LOOP;
  
    v_retsql := v_withpart ||
                'SELECT COL_NAME, COL_RAWVAL, COL_CURVAL FROM (' ||
                v_seppart || ') WHERE COL_CURVAL IS NOT NULL';
  
    RETURN v_retsql;
  END f_get_inscolandval_sql;

  /*===================================================================================
  
    生成【通用值修改】字段解析sql
  
    用途:
      生成【通用值修改】字段解析sql
  
    用于:
      队列值变更表记录
  
    入参:
      V_TAB         :  表名
      V_UNQFIELDS   :  唯一列字段，多值用逗号隔开
      V_CKFIELDS    :  校验字段，多值用逗号隔开
      V_CONDS       :  条件字段，用于确认该修改是在哪一行
      V_PRESECOND   :  秒数，用于定位 x 秒之前未修改的数据
  
    版本:
      2022-01-12 : 生成【通用值修改】字段解析sql
      2022-01-17 : 增加未出队导致的 View 层表自身修改问题
      2022-02-11 : 增加 OPERATE_ID, OPERATE_TIME 对 UPDATE_ID, UPDATE_TIME 的转化，
                   增加 OPERATE_TIME 转换为 “YYYY-MM-DD HH24-MI-SS” 格式字符串类型
  
  ===================================================================================*/
  FUNCTION f_get_updcolandval_sql
  (
    v_tab       IN VARCHAR2,
    v_viewtab   IN VARCHAR2 DEFAULT NULL,
    v_unqfields IN VARCHAR2,
    v_ckfields  IN VARCHAR2,
    v_conds     IN VARCHAR2,
    v_presecond IN NUMBER DEFAULT NULL
  ) RETURN CLOB IS
    v_cnt         NUMBER(4) := 1;
    v_aliasbtsf   VARCHAR2(4000);
    v_unqcond     VARCHAR2(4000);
    v_jugnum      NUMBER(1);
    v_exesql      CLOB;
    v_repeatsql   CLOB;
    v_retsql      CLOB;
    v_ckfieldsraw VARCHAR2(1024);
    v_ckfieldsdif VARCHAR2(1024);
  BEGIN
    --增加判断，考虑到未出队导致的 View 层自身修改问题
    IF v_viewtab IS NOT NULL THEN
      v_exesql := 'SELECT COUNT(1) FROM ' || v_viewtab ||
                  ' AS OF TIMESTAMP SYSDATE-' || v_presecond ||
                  '/(24*60*60) WHERE ' || v_conds || ' AND ROWNUM = 1';
      EXECUTE IMMEDIATE v_exesql
        INTO v_jugnum;
    END IF;
  
    FOR i IN (SELECT regexp_substr(v_unqfields, '[^,]+', 1, LEVEL) col
                FROM dual
              CONNECT BY LEVEL <= regexp_count(v_unqfields, '\,') + 1) LOOP
      IF v_unqcond IS NULL THEN
        v_unqcond := 'A.' || i.col || '=' || 'B.' || i.col;
      ELSE
        v_unqcond := v_unqcond || ' AND A.' || i.col || '=' || 'B.' ||
                     i.col;
      END IF;
    END LOOP;
  
    FOR j IN (SELECT regexp_substr(v_ckfields, '[^,]+', 1, LEVEL) col
                FROM dual
              CONNECT BY LEVEL <= regexp_count(v_ckfields, '\,') + 1) LOOP
      IF v_aliasbtsf IS NULL THEN
        v_aliasbtsf := 'TO_CHAR(A.' || j.col || ') A' || v_cnt || 'VAL, ' ||
                       'TO_CHAR(B.' || j.col || ') B' || v_cnt || 'VAL';
      ELSE
        v_aliasbtsf := v_aliasbtsf || ', TO_CHAR(A.' || j.col || ') A' ||
                       v_cnt || 'VAL, ' || 'TO_CHAR(B.' || j.col || ') B' ||
                       v_cnt || 'VAL';
      END IF;
    
      IF v_repeatsql IS NULL THEN
        v_repeatsql := 'SELECT CASE WHEN NVL(TO_CHAR(A' || v_cnt ||
                       'VAL), '' '') <> NVL(TO_CHAR(B' || v_cnt ||
                       'VAL), '' '') THEN ''' || j.col ||
                       ''' END COL_NAME,' || 'TO_CHAR(A' || v_cnt ||
                       'VAL) COL_RAWVAL, TO_CHAR(B' || v_cnt ||
                       'VAL) COL_CURVAL FROM TMP';
      ELSE
        v_repeatsql := v_repeatsql || ' UNION ALL SELECT CASE WHEN NVL(A' ||
                       v_cnt || 'VAL, '' '') <> NVL(B' || v_cnt ||
                       'VAL, '' '') THEN ''' || j.col || ''' END COL_NAME,' ||
                       'TO_CHAR(A' || v_cnt || 'VAL) COL_RAWVAL, TO_CHAR(B' ||
                       v_cnt || 'VAL) COL_CURVAL FROM TMP';
      END IF;
      v_cnt := v_cnt + 1;
    END LOOP;
  
    v_ckfieldsraw := f_trans_fields(v_tab        => v_tab,
                                    v_ckfields   => v_ckfields,
                                    v_sepsymbol  => ',',
                                    v_opermethod => 'UPD',
                                    v_mftype     => 'VAL');
    v_ckfieldsdif := v_ckfields;
  
    IF v_viewtab IS NULL THEN
      v_retsql := 'WITH TMP AS (SELECT ' || v_aliasbtsf || ' FROM (SELECT ' ||
                  v_unqfields || ',' || v_ckfieldsraw || ' FROM ' || v_tab ||
                  ' AS OF TIMESTAMP SYSDATE-' || v_presecond ||
                  '/(24*60*60) WHERE ' || v_conds || ') A, (SELECT ' ||
                  v_unqfields || ',' || v_ckfieldsraw || ' FROM ' || v_tab ||
                  ' WHERE ' || v_conds || ') B WHERE ' || v_unqcond ||
                  ') SELECT COL_NAME,COL_RAWVAL,COL_CURVAL FROM (' ||
                  v_repeatsql || ') WHERE COL_NAME IS NOT NULL';
    ELSE
      v_ckfieldsdif := f_trans_fields(v_tab        => v_viewtab,
                                      v_ckfields   => v_ckfields,
                                      v_sepsymbol  => ',',
                                      v_opermethod => 'UPD',
                                      v_mftype     => 'VAL');
    
      --增加 View 层自身修改问题
      IF v_jugnum = 0 THEN
        v_retsql := 'WITH TMP AS (SELECT ' || v_aliasbtsf ||
                    ' FROM (SELECT ' || v_unqfields || ',' || v_ckfieldsraw ||
                    ' FROM ' || v_tab || '  WHERE ' || v_conds ||
                    ') A, (SELECT ' || v_unqfields || ',' || v_ckfieldsdif ||
                    ' FROM ' || v_viewtab || ' WHERE ' || v_conds ||
                    ') B WHERE ' || v_unqcond || ') ';
        v_retsql := v_retsql ||
                    'SELECT COL_NAME,COL_RAWVAL,COL_CURVAL FROM (' ||
                    v_repeatsql || ') WHERE COL_NAME IS NOT NULL';
      ELSE
        v_retsql := 'WITH TMP AS (SELECT ' || v_aliasbtsf ||
                    ' FROM (SELECT ' || v_unqfields || ',' || v_ckfieldsdif ||
                    ' FROM ' || v_viewtab || ' AS OF TIMESTAMP SYSDATE-' ||
                    v_presecond || '/(24*60*60) WHERE ' || v_conds ||
                    ') A, (SELECT ' || v_unqfields || ',' || v_ckfieldsdif ||
                    ' FROM ' || v_viewtab || ' WHERE ' || v_conds ||
                    ') B WHERE ' || v_unqcond ||
                    ') SELECT COL_NAME,COL_RAWVAL,COL_CURVAL FROM (' ||
                    v_repeatsql || ') WHERE COL_NAME IS NOT NULL';
      END IF;
    END IF;
    RETURN v_retsql;
  END f_get_updcolandval_sql;

  /*===================================================================================
  
    生成【通用值删除】字段解析sql
  
    用途:
      生成【通用值删除】字段解析sql
  
    用于:
      队列值变更表记录
  
    入参:
      V_TAB         :  表名
      V_CKFIELDS    :  校验字段，多值用逗号隔开
      V_CONDS       :  条件字段，用于确认该修改是在哪一行
  
    版本:
      2022-01-12 : 生成【通用值删除】字段解析sql
  
  ===================================================================================*/
  FUNCTION f_get_delcolandval_sql
  (
    v_tab      IN VARCHAR2,
    v_ckfields IN VARCHAR2,
    v_conds    IN VARCHAR2
  ) RETURN CLOB IS
    v_withpart VARCHAR2(1024);
    v_tmpval   VARCHAR2(128);
    v_seppart  VARCHAR2(2048);
    v_retsql   VARCHAR2(4000);
  BEGIN
    v_withpart := 'WITH TMP AS (SELECT * FROM ' || v_tab || ' WHERE ' ||
                  v_conds || ') ';
  
    FOR j IN (SELECT regexp_substr(v_ckfields, '[^,]+', 1, LEVEL) col
                FROM dual
              CONNECT BY LEVEL <= regexp_count(v_ckfields, '\,') + 1) LOOP
      SELECT MAX(vc_mapcol)
        INTO v_tmpval
        FROM scmdata.t_queue_vcmapping
       WHERE vc_tab = v_tab
         AND vc_col = j.col
         AND oper_method = 'DEL';
    
      IF v_tmpval IS NULL THEN
        v_tmpval := j.col;
      END IF;
    
      IF v_seppart IS NULL THEN
        v_seppart := 'SELECT ''' || j.col || ''' COL_NAME, TO_CHAR(' ||
                     v_tmpval || ') COL_RAWVAL, '''' COL_CURVAL FROM TMP ';
      ELSE
        v_seppart := v_seppart || ' UNION ALL SELECT ''' || j.col ||
                     ''' COL_NAME, TO_CHAR(' || v_tmpval ||
                     ') COL_RAWVAL, '''' COL_CURVAL FROM TMP ';
      END IF;
    END LOOP;
  
    v_retsql := v_withpart ||
                'SELECT COL_NAME, COL_RAWVAL, COL_CURVAL FROM (' ||
                v_seppart || ') WHERE COL_RAWVAL IS NOT NULL';
  
    RETURN v_retsql;
  END f_get_delcolandval_sql;

  /*===================================================================================
  
    生成通用值变更解析sql
  
    用途:
      生成通用值变更解析sql
  
    用于:
      队列值变更表记录
  
    入参:
      V_TAB         :  表名
      V_VIEWTAB     :  显示表表名
      V_UNQFIELDS   :  唯一列字段，多值用逗号隔开
      V_CKFIELDS    :  校验字段，多值用逗号隔开
      V_CONDS       :  条件字段，用于确认该修改是在哪一行
      V_METHOD      :  操作方式 INS-新增 UPD-修改 DEL-删除
      V_PRESECOND   :  秒数，用于定位 x 秒之前未修改的数据
  
    版本:
      2022-01-12 : 生成通用值变更解析sql
  
  ===================================================================================*/
  FUNCTION f_get_cgcolandval_sql
  (
    v_tab       IN VARCHAR2,
    v_viewtab   IN VARCHAR2 DEFAULT NULL,
    v_unqfields IN VARCHAR2,
    v_ckfields  IN VARCHAR2,
    v_conds     IN VARCHAR2,
    v_method    IN VARCHAR2,
    v_presecond IN NUMBER
  ) RETURN CLOB IS
    v_jugnum NUMBER(4);
    v_deltab VARCHAR2(128);
    v_exesql VARCHAR2(2048);
    v_retsql CLOB;
  BEGIN
    IF v_method = 'INS' THEN
      -- 新增解析
      v_retsql := f_get_inscolandval_sql(v_viewtab  => nvl(v_viewtab, v_tab),
                                         v_ckfields => v_ckfields,
                                         v_conds    => v_conds);
    
    ELSIF v_method = 'UPD' THEN
      -- 修改解析
      v_retsql := f_get_updcolandval_sql(v_tab       => v_tab,
                                         v_viewtab   => v_viewtab,
                                         v_unqfields => v_unqfields,
                                         v_ckfields  => v_ckfields,
                                         v_conds     => v_conds,
                                         v_presecond => v_presecond);
    
    ELSIF v_method = 'DEL' THEN
      -- 删除解析
      v_exesql := 'SELECT COUNT(1) FROM ' || v_tab || ' WHERE ' || v_conds;
      EXECUTE IMMEDIATE v_exesql
        INTO v_jugnum;
    
      IF v_jugnum > 0 THEN
        v_deltab := v_tab;
      ELSE
        v_deltab := v_viewtab;
      END IF;
      v_retsql := f_get_delcolandval_sql(v_tab      => v_deltab,
                                         v_ckfields => v_ckfields,
                                         v_conds    => v_conds);
    END IF;
  
    RETURN v_retsql;
  END f_get_cgcolandval_sql;

  /*===================================================================================
  
    队列值变更新增核
  
    用途:
      调用生成一条队列值变更记录
  
    入参:
      V_QUEUEID   :  队列Id
      V_COMPID    :  企业Id
      V_VCTAB     :  值变更表
      V_VCCOL     :  值变更列，单值
      V_VCCOND    :  值变更条件
      V_RAWVAL    :  变更前值
      V_CURVAL    :  变更后值
      V_METHOD    :  变更方式
  
    版本:
      2022-01-12 : 队列值变更新增核
  
  ===================================================================================*/
  PROCEDURE p_gen_valuechange_rec
  (
    v_queueid IN VARCHAR2,
    v_compid  IN VARCHAR2,
    v_vctab   IN VARCHAR2,
    v_vccol   IN VARCHAR2,
    v_vccond  IN VARCHAR2,
    v_rawval  IN VARCHAR2,
    v_curval  IN VARCHAR2,
    v_method  IN VARCHAR2
  ) IS
  
  BEGIN
    INSERT INTO scmdata.t_queue_valchange
      (valchange_id, company_id, queue_id, vc_tab, vc_col, vc_cond, vc_rawval, vc_curval, vc_method)
    VALUES
      (scmdata.f_get_uuid(), v_compid, v_queueid, v_vctab, v_vccol, v_vccond, v_rawval, v_curval, v_method);
  END p_gen_valuechange_rec;

  /*===================================================================================
  
    生成队列值变更表记录
  
    用途:
      生成队列值变更表记录
  
    用于:
      记录入队前值变更信息
  
    入参:
      V_QUEUEID     :  队列Id
      V_COMPID      :  企业Id
      V_TAB         :  表名
      V_UNQFIELDS   :  唯一列字段，多值用逗号隔开
      V_CKFIELDS    :  校验字段，多值用逗号隔开
      V_CONDS       :  条件字段，用于确认该修改是在哪一行
      V_METHOD      :  值变更方式
  
    版本:
      2022-01-12 : 生成队列值变更表记录
      2022-01-15 : 加入 ViewTab 字段
  
  ===================================================================================*/
  PROCEDURE p_gen_queuevc_info
  (
    v_queueid   IN VARCHAR2,
    v_compid    IN VARCHAR2,
    v_tab       IN VARCHAR2,
    v_viewtab   IN VARCHAR2 DEFAULT NULL,
    v_unqfields IN VARCHAR2,
    v_ckfields  IN VARCHAR2,
    v_conds     IN VARCHAR2,
    v_method    IN VARCHAR2
  ) IS
    TYPE rctype IS REF CURSOR;
    rc          rctype;
    v_exesql    CLOB;
    rc_vccol    VARCHAR2(256);
    rc_vcrawval VARCHAR2(3072);
    rc_vccurval VARCHAR2(3072);
  BEGIN
    v_exesql := f_get_cgcolandval_sql(v_tab       => v_tab,
                                      v_viewtab   => v_viewtab,
                                      v_unqfields => v_unqfields,
                                      v_ckfields  => v_ckfields,
                                      v_conds     => v_conds,
                                      v_method    => v_method,
                                      v_presecond => 1);
  
    /*scmdata.p_print_clob_into_console(v_clob => v_exesql);*/
  
    OPEN rc FOR v_exesql;
    LOOP
      FETCH rc
        INTO rc_vccol,
             rc_vcrawval,
             rc_vccurval;
      EXIT WHEN rc%NOTFOUND;
    
      p_gen_valuechange_rec(v_queueid => v_queueid,
                            v_compid  => v_compid,
                            v_vctab   => v_tab,
                            v_vccol   => rc_vccol,
                            v_vccond  => v_conds,
                            v_rawval  => rc_vcrawval,
                            v_curval  => rc_vccurval,
                            v_method  => v_method);
    END LOOP;
    CLOSE rc;
  END p_gen_queuevc_info;

  /*=================================================================================
  
    获取基础队列执行器状态
  
    说明：
      获取基础队列队列执行器状态
  
    版本：
      2022-06-30 : ORDERED 订单接口重构
  
  =================================================================================*/
  FUNCTION f_get_basicqueue_executor_status RETURN VARCHAR2 IS
    v_status VARCHAR2(4);
  BEGIN
    v_status := scmdata.pkg_variable.f_get_varchar(v_objid   => 'SYS',
                                                   v_compid  => 'b6cc680ad0f599cde0531164a8c0337f',
                                                   v_varname => 'BQEXE_STATUS');
  
    IF v_status IS NULL THEN
      v_status := 'P';
    
      scmdata.pkg_variable.p_ins_or_upd_variable_at(v_objid   => 'SYS',
                                                    v_compid  => 'b6cc680ad0f599cde0531164a8c0337f',
                                                    v_varname => 'BQEXE_STATUS',
                                                    v_vartype => 'VARCHAR',
                                                    v_varchar => 'P');
    END IF;
  
    RETURN v_status;
  END f_get_basicqueue_executor_status;

  /*=================================================================================
  
    新增进入基础队列
  
    说明：
      新增进入基础队列
  
    入参：
      V_EXELOGIC  :  执行逻辑
  
    版本：
      2022-06-30 : ORDERED 订单接口重构
  
  =================================================================================*/
  PROCEDURE p_ins_basic_queue(v_exelogic IN CLOB) IS
  
  BEGIN
    INSERT INTO scmdata.t_basic_queue
      (bq_id, status, gen_time, exe_logic)
    VALUES
      (scmdata.f_get_uuid(), 'EP', SYSDATE, v_exelogic);
  END p_ins_basic_queue;

  /*=================================================================================
  
    单个顺序执行基础队列内执行逻辑
  
    说明：
      单个顺序执行基础队列内执行逻辑
  
    入参：
      V_ID        :  基础队列Id
      V_LOGIC     :  执行逻辑
      V_QESTATUS  :  队列执行器状态
  
    版本：
      2022-06-30 : ORDERED 订单接口重构
  
  =================================================================================*/
  PROCEDURE p_exe_basic_queue_one_by_one
  (
    v_id       IN VARCHAR2,
    v_logic    IN VARCHAR2,
    v_qestatus IN VARCHAR2
  ) IS
    v_tmpid    VARCHAR2(32);
    v_tmplogic VARCHAR2(4000);
  BEGIN
    IF v_id IS NOT NULL
       AND v_logic IS NOT NULL
       AND v_qestatus = 'P' THEN
      EXECUTE IMMEDIATE v_logic;
    
      UPDATE scmdata.t_basic_queue
         SET status   = 'ES',
             exe_info = to_char(SYSDATE, 'YYYY-MM-DD HH24-MI-SS') ||
                        ' EXECUTE SUCCEED'
       WHERE bq_id = v_id;
    
      SELECT MAX(bq_id),
             MAX(exe_logic)
        INTO v_tmpid,
             v_tmplogic
        FROM (SELECT bq_id,
                     exe_logic,
                     gen_time
                FROM scmdata.t_basic_queue
               WHERE status = 'EP'
               ORDER BY gen_time
               FETCH FIRST 1 rows ONLY);
    
      p_exe_basic_queue_one_by_one(v_id       => v_tmpid,
                                   v_logic    => v_tmplogic,
                                   v_qestatus => v_qestatus);
    
    ELSIF v_id IS NOT NULL
          AND v_logic IS NULL
          AND v_qestatus = 'P' THEN
      UPDATE scmdata.t_basic_queue
         SET status   = 'EE',
             exe_info = '执行逻辑缺失'
       WHERE bq_id = v_id;
    
      SELECT MAX(bq_id),
             MAX(exe_logic)
        INTO v_tmpid,
             v_tmplogic
        FROM (SELECT bq_id,
                     exe_logic,
                     gen_time
                FROM scmdata.t_basic_queue
               WHERE status = 'EP'
               ORDER BY gen_time
               FETCH FIRST 1 rows ONLY);
    
      p_exe_basic_queue_one_by_one(v_id       => v_tmpid,
                                   v_logic    => v_tmplogic,
                                   v_qestatus => v_qestatus);
    END IF;
  
    COMMIT;
  EXCEPTION
    WHEN OTHERS THEN
      UPDATE scmdata.t_basic_queue
         SET status   = 'EE',
             exe_info = to_char(SYSDATE, 'YYYY-MM-DD HH24-MI-SS') || chr(10) ||
                        'FORMAT_ERROR_BACKTRACE:' ||
                        substr(dbms_utility.format_error_backtrace, 1, 256) ||
                        chr(10) || 'FORMAT_ERROR_STACK:' ||
                        substr(dbms_utility.format_error_stack, 1, 256) ||
                        chr(10) || 'FORMAT_CALL_STACK:' ||
                        substr(dbms_utility.format_call_stack, 1, 256)
       WHERE bq_id = v_id;
    
      COMMIT;
    
      SELECT MAX(bq_id),
             MAX(exe_logic)
        INTO v_tmpid,
             v_tmplogic
        FROM (SELECT bq_id,
                     exe_logic,
                     gen_time
                FROM scmdata.t_basic_queue
               WHERE status = 'EP'
               ORDER BY gen_time
               FETCH FIRST 1 rows ONLY);
    
      p_exe_basic_queue_one_by_one(v_id       => v_tmpid,
                                   v_logic    => v_tmplogic,
                                   v_qestatus => v_qestatus);
  END p_exe_basic_queue_one_by_one;

  /*=================================================================================
  
    基础队列执行逻辑
  
    说明：
      基础队列执行逻辑
  
    版本：
      2022-06-30 : ORDERED 订单接口重构
  
  =================================================================================*/
  PROCEDURE p_basic_queue_exe IS
    v_tmpid    VARCHAR2(32);
    v_tmplogic CLOB;
    v_status   VARCHAR2(4);
  BEGIN
    SELECT MAX(bq_id),
           MAX(exe_logic)
      INTO v_tmpid,
           v_tmplogic
      FROM (SELECT bq_id,
                   exe_logic,
                   gen_time
              FROM scmdata.t_basic_queue
             WHERE status = 'EP'
             ORDER BY gen_time
             FETCH FIRST 1 rows ONLY);
  
    v_status := scmdata.pkg_queue.f_get_basicqueue_executor_status;
  
    IF v_status = 'P' THEN
      scmdata.pkg_variable.p_ins_or_upd_variable_at(v_objid   => 'SYS',
                                                    v_compid  => 'b6cc680ad0f599cde0531164a8c0337f',
                                                    v_varname => 'BQEXE_STATUS',
                                                    v_vartype => 'VARCHAR',
                                                    v_varchar => 'R');
    
      scmdata.pkg_queue.p_exe_basic_queue_one_by_one(v_id       => v_tmpid,
                                                     v_logic    => v_tmplogic,
                                                     v_qestatus => v_status);
    
      scmdata.pkg_variable.p_ins_or_upd_variable_at(v_objid   => 'SYS',
                                                    v_compid  => 'b6cc680ad0f599cde0531164a8c0337f',
                                                    v_varname => 'BQEXE_STATUS',
                                                    v_vartype => 'VARCHAR',
                                                    v_varchar => 'P');
    END IF;
  END p_basic_queue_exe;

  /*=================================================================================
    
    执行器状态更新（自治事务）
    
    入参:
      v_inp_queueexeid  :  执行器Id
      v_compid          :  企业id
      v_inp_status      :  状态
    
    版本:
      2022-12-29 : 执行器状态更新（自治事务）
    
  =================================================================================*/
  PROCEDURE p_upd_queueexecutorstatus_at
  (
    v_inp_queueexeid IN VARCHAR2,
    v_inp_compid     IN VARCHAR2,
    v_inp_status     IN VARCHAR2
  ) IS
    PRAGMA AUTONOMOUS_TRANSACTION;
  BEGIN
    UPDATE scmdata.t_queue_executor
       SET execute_status = v_inp_status
     WHERE queueexe_id = v_inp_queueexeid
       AND company_id = v_inp_compid;
  
    COMMIT;
  END p_upd_queueexecutorstatus_at;

  /*=================================================================================
    
    执行器状态与队列Id更新（自治事务）
    
    入参:
      v_inp_queueexeid  :  执行器Id
      v_compid          :  企业id
      v_inp_status      :  状态
      v_inp_queueid     :  队列Id
    
    版本:
      2022-12-29 : 执行器状态与队列Id更新（自治事务）
    
  =================================================================================*/
  PROCEDURE p_upd_queueexecutorstatusandqueueid_at
  (
    v_inp_queueexeid IN VARCHAR2,
    v_inp_compid     IN VARCHAR2,
    v_inp_status     IN VARCHAR2,
    v_inp_queueid    IN VARCHAR2
  ) IS
    PRAGMA AUTONOMOUS_TRANSACTION;
  BEGIN
    UPDATE scmdata.t_queue_executor
       SET execute_status = v_inp_status,
           queue_id       = v_inp_queueid
     WHERE queueexe_id = v_inp_queueexeid
       AND company_id = v_inp_compid;
  
    COMMIT;
  END p_upd_queueexecutorstatusandqueueid_at;

  /*=============================================================================
  
     过程名:
       【产能】启停xxl_job特定执行参数任务
  
     入参:
       v_inp_triggerstatus  :  触发器状态 0-停用 1-启用
       v_inp_executorparam  :  执行参数
  
     版本:
       2022-12-16_zc314 : 启停xxl_job特定执行参数任务
  
  ==============================================================================*/
  PROCEDURE p_capc_updxxlinfotriggerstatus
  (
    v_inp_triggerstatus IN NUMBER,
    v_inp_executorparam IN VARCHAR2
  ) IS
  
    v_jugnum        NUMBER(1);
    v_triggerstatus NUMBER(1);
  BEGIN
    SELECT nvl(MAX(1), 0),
           MAX(trigger_status)
      INTO v_jugnum,
           v_triggerstatus
      FROM bw3.xxl_job_info
     WHERE executor_param = v_inp_executorparam;
  
    IF v_jugnum IS NOT NULL
       AND v_triggerstatus <> v_inp_triggerstatus THEN
      UPDATE bw3.xxl_job_info
         SET trigger_status = v_inp_triggerstatus
       WHERE executor_param = v_inp_executorparam;
    END IF;
  END p_capc_updxxlinfotriggerstatus;

  /*=============================================================================
  
     过程名:
       【产能】启停xxl_job特定执行参数任务(自治事务)
  
     入参:
       v_inp_triggerstatus  :  触发器状态 0-停用 1-启用
       v_inp_executorparam  :  执行参数
  
     版本:
       2022-12-16_zc314 : 启停xxl_job特定执行参数任务(自治事务)
  
  ==============================================================================*/
  PROCEDURE p_capc_updxxlinfotriggerstatus_at
  (
    v_inp_triggerstatus IN NUMBER,
    v_inp_executorparam IN VARCHAR2
  ) IS
    PRAGMA AUTONOMOUS_TRANSACTION;
    v_jugnum        NUMBER(1);
    v_triggerstatus NUMBER(1);
  BEGIN
    SELECT nvl(MAX(1), 0),
           MAX(trigger_status)
      INTO v_jugnum,
           v_triggerstatus
      FROM bw3.xxl_job_info
     WHERE executor_param = v_inp_executorparam;
  
    IF v_jugnum IS NOT NULL
       AND v_triggerstatus <> v_inp_triggerstatus THEN
      UPDATE bw3.xxl_job_info
         SET trigger_status = v_inp_triggerstatus
       WHERE executor_param = v_inp_executorparam;
    END IF;
  
    COMMIT;
  END p_capc_updxxlinfotriggerstatus_at;

  /*===================================================================================
  
    函数名:
      获取最早未执行的队列Id
  
    用于:
      队列值变更表记录
  
    入参:
      v_inp_iswprecalc  :  是否为周产能重算 0-否 1-是
      v_inp_compid      :  企业Id
    返回值:
      Varchar2 类型，队列Id
  
    版本:
      2022-12-17 : 获取最早未执行的队列Id
  
  ===================================================================================*/
  FUNCTION f_get_earliestqueueid
  (
    v_inp_iswprecalc IN NUMBER,
    v_inp_compid     IN VARCHAR2
  ) RETURN VARCHAR2 IS
    v_queueid VARCHAR2(32);
  BEGIN
    --是否存在还未执行的队列
    IF v_inp_iswprecalc = 0 THEN
      SELECT MAX(queue_id)
        INTO v_queueid
        FROM (SELECT queue_id,
                     company_id
                FROM scmdata.t_queue que
               WHERE que.queue_status IN ('PR' /*, 'ER'*/)
                 AND que.is_iflrowsgened = 0
                 AND que.queue_type <> 'SCM_CAPCWKPLAN_RECALC'
                 AND que.company_id = v_inp_compid
               ORDER BY create_time
               FETCH FIRST 1 rows ONLY);
    ELSIF v_inp_iswprecalc = 1 THEN
      SELECT MAX(queue_id)
        INTO v_queueid
        FROM (SELECT queue_id,
                     company_id
                FROM scmdata.t_queue que
               WHERE que.queue_status IN ('PR' /*, 'ER'*/)
                 AND que.is_iflrowsgened = 0
                 AND que.queue_type = 'SCM_CAPCWKPLAN_RECALC'
                 AND que.company_id = v_inp_compid
               ORDER BY create_time
               FETCH FIRST 1 rows ONLY);
    END IF;
  
    --返回队列Id
    RETURN v_queueid;
  END f_get_earliestqueueid;

  /*=================================================================================
  
    过程名:
      【产能】产能调度逻辑（新）
  
    入参:
      v_inp_dispatcher      :  调度器 element_id
      v_inp_executor        :  执行器 element_id
      v_inp_queueexeid      :  队列执行器Id
      v_inp_compid          :  企业id
      v_inp_iswkplanrecalc  :  执行状态是否为周产能重算
                                   0-非周产能重算
                                   1-周产能重算
  
    版本:
      2022-12-16 : 产能调度逻辑（新）
  
  =================================================================================*/
  PROCEDURE p_capc_dispatchlogic
  (
    v_inp_dispatcher IN VARCHAR2,
    v_inp_executor   IN VARCHAR2,
    v_inp_compid     IN VARCHAR2,
    v_inp_iswprecalc IN NUMBER
  ) IS
    v_queueid         VARCHAR2(32);
    v_oppositequeueid VARCHAR2(32);
    v_oppositenum     NUMBER(1);
  BEGIN
    --0、1互换
    IF v_inp_iswprecalc = 1 THEN
      v_oppositenum := 0;
    END IF;
  
    --合并多余队列
    p_combinequeue_core;
  
    --获取最早未执行队列Id
    v_queueid := f_get_earliestqueueid(v_inp_iswprecalc => v_inp_iswprecalc,
                                       v_inp_compid     => v_inp_compid);
  
    --获取最早未执行队列Id
    v_oppositequeueid := f_get_earliestqueueid(v_inp_iswprecalc => v_oppositenum,
                                               v_inp_compid     => v_inp_compid);
  
    IF v_oppositequeueid IS NULL THEN
      IF v_queueid IS NULL THEN
        --关闭执行器
        p_capc_updxxlinfotriggerstatus_at(v_inp_triggerstatus => 0,
                                          v_inp_executorparam => v_inp_executor);
      
        --开启调度器
        p_capc_updxxlinfotriggerstatus_at(v_inp_triggerstatus => 1,
                                          v_inp_executorparam => v_inp_dispatcher);
      ELSE
        --开启执行器
        p_capc_updxxlinfotriggerstatus_at(v_inp_triggerstatus => 1,
                                          v_inp_executorparam => v_inp_executor);
      
        --关闭调度器
        p_capc_updxxlinfotriggerstatus_at(v_inp_triggerstatus => 0,
                                          v_inp_executorparam => v_inp_dispatcher);
      END IF;
    END IF;
  
  END p_capc_dispatchlogic;

  /*=================================================================================
  
    执行核心逻辑（自治事务）
  
    入参:
      v_queueid  :  队列id
      v_compid   :  企业id
  
    版本:
      2022-12-16 : 执行核心逻辑（自治事务）
  
  =================================================================================*/
  PROCEDURE p_capc_queueexecutecore_at
  (
    v_queueid IN VARCHAR2,
    v_compid  IN VARCHAR2
  ) IS
    PRAGMA AUTONOMOUS_TRANSACTION;
    v_corelogic   VARCHAR2(1024);
    v_loglogicbef VARCHAR2(512);
    v_loglogicaft VARCHAR2(512);
    v_exesql      CLOB;
    v_starttime   DATE;
    v_endtime     DATE;
  BEGIN
    scmdata.pkg_variable.p_ins_or_upd_variable_with_chaid_at(v_objid   => 'SCM_QUEEXE_REC',
                                                             v_compid  => v_compid,
                                                             v_varname => 'QUEEXE_STARTTIME',
                                                             v_vartype => 'DATE',
                                                             v_date    => SYSDATE,
                                                             v_chaid   => v_queueid);
  
    SELECT MAX(core_logic),
           MAX(log_logic_before),
           MAX(log_logic_after)
      INTO v_corelogic,
           v_loglogicbef,
           v_loglogicaft
      FROM scmdata.t_queue_cfg
     WHERE queue_type IN (SELECT queue_type
                            FROM scmdata.t_queue
                           WHERE queue_id = v_queueid
                             AND company_id = v_compid);
  
    IF v_corelogic IS NOT NULL THEN
      v_exesql := 'DECLARE V_QUEUEID  VARCHAR2(32):=''' || v_queueid ||
                  '''; V_COMPID  VARCHAR2(32):=''' || v_compid || '''; ' ||
                  'BEGIN ' || v_loglogicbef || ' ' || v_corelogic || ' ' ||
                  v_loglogicaft || ' END;';
    
      EXECUTE IMMEDIATE v_exesql;
    
      UPDATE scmdata.t_queue
         SET queue_status = 'SS'
       WHERE queue_id = v_queueid
         AND company_id = v_compid;
    END IF;
  
    scmdata.pkg_variable.p_ins_or_upd_variable_with_chaid_at(v_objid   => 'SCM_QUEEXE_REC',
                                                             v_compid  => v_compid,
                                                             v_varname => 'QUEEXE_ENDTIME',
                                                             v_vartype => 'DATE',
                                                             v_date    => SYSDATE,
                                                             v_chaid   => v_queueid);
  
    v_starttime := scmdata.pkg_variable.f_get_date_with_chaid(v_objid   => 'SCM_QUEEXE_REC',
                                                              v_compid  => v_compid,
                                                              v_varname => 'QUEEXE_STARTTIME',
                                                              v_chaid   => v_queueid);
  
    v_endtime := scmdata.pkg_variable.f_get_date_with_chaid(v_objid   => 'SCM_QUEEXE_REC',
                                                            v_compid  => v_compid,
                                                            v_varname => 'QUEEXE_ENDTIME',
                                                            v_chaid   => v_queueid);
  
    UPDATE scmdata.t_queue
       SET queueexe_time = v_starttime,
           outqueue_time = v_endtime
     WHERE queue_id = v_queueid
       AND company_id = v_compid;
  
    COMMIT;
  EXCEPTION
    WHEN OTHERS THEN
      UPDATE scmdata.t_queue
         SET queue_status  = 'ER',
             queueexe_time = v_starttime,
             outqueue_time = v_endtime
       WHERE queue_id = v_queueid
         AND company_id = v_compid;
    
      COMMIT;
  END p_capc_queueexecutecore_at;

  /*=================================================================================
  
    执行器逻辑
  
    入参:
      v_inp_dispatcher  :  调度器 element_id
      v_inp_executor    :  执行器 element_id
      v_inp_queueexeid  :  执行器Id
      v_compid          :  企业id
  
    版本:
      2022-12-16 : 执行器逻辑
  
  =================================================================================*/
  PROCEDURE p_capc_executorlogic
  (
    v_inp_dispatcher IN VARCHAR2,
    v_inp_executor   IN VARCHAR2,
    v_inp_queueexeid IN VARCHAR2,
    v_inp_compid     IN VARCHAR2,
    v_inp_iswprecalc IN NUMBER
  ) IS
    v_queueid      VARCHAR2(32);
    v_exestatus    VARCHAR2(8);
    v_outqueuetime DATE;
    v_iscontinue   NUMBER(1) := 1;
  BEGIN
    --关闭执行器
    p_capc_updxxlinfotriggerstatus_at(v_inp_triggerstatus => 0,
                                      v_inp_executorparam => v_inp_executor);
  
    --获取执行器状态
    SELECT MAX(execute_status)
      INTO v_exestatus
      FROM scmdata.t_queue_executor
     WHERE queueexe_id = v_inp_queueexeid
       AND company_id = v_inp_compid;
  
    IF v_exestatus = 'P' THEN
      --获取最早未执行队列Id
      v_queueid := f_get_earliestqueueid(v_inp_iswprecalc => v_inp_iswprecalc,
                                         v_inp_compid     => v_inp_compid);
    
      IF v_queueid IS NOT NULL THEN
        --置入执行器
        p_upd_queueexecutorstatusandqueueid_at(v_inp_queueexeid => v_inp_queueexeid,
                                               v_inp_compid     => v_inp_compid,
                                               v_inp_status     => 'PR',
                                               v_inp_queueid    => v_queueid);
        /*UPDATE scmdata.t_queue_executor
          SET queue_id = v_queueid, execute_status = 'PR'
        WHERE queueexe_id = v_inp_queueexeid
          AND company_id = v_inp_compid;*/
      ELSE
        --是否继续
        v_iscontinue := 0;
      
        --关闭执行器
        p_capc_updxxlinfotriggerstatus_at(v_inp_triggerstatus => 0,
                                          v_inp_executorparam => v_inp_executor);
      
        --开启调度器
        p_capc_updxxlinfotriggerstatus_at(v_inp_triggerstatus => 1,
                                          v_inp_executorparam => v_inp_dispatcher);
      END IF;
    ELSIF v_exestatus = 'PR' THEN
      --变更执行器状态为“进行中”
      p_upd_queueexecutorstatus_at(v_inp_queueexeid => v_inp_queueexeid,
                                   v_inp_compid     => v_inp_compid,
                                   v_inp_status     => 'R');
      /*UPDATE scmdata.t_queue_executor
        SET execute_status = 'R'
      WHERE queueexe_id = v_inp_queueexeid
        AND company_id = v_inp_compid;*/
    
      --获取队列Id
      SELECT MAX(queue_id)
        INTO v_queueid
        FROM scmdata.t_queue_executor
       WHERE queueexe_id = v_inp_queueexeid
         AND company_id = v_inp_compid;
    
      --执行执行器逻辑
      BEGIN
        p_capc_queueexecutecore_at(v_queueid => v_queueid,
                                   v_compid  => v_inp_compid);
      EXCEPTION
        WHEN OTHERS THEN
          p_upd_queueexecutorstatus_at(v_inp_queueexeid => v_inp_queueexeid,
                                       v_inp_compid     => v_inp_compid,
                                       v_inp_status     => 'P');
          /*UPDATE scmdata.t_queue_executor
            SET execute_status = 'PR'
          WHERE queueexe_id = v_inp_queueexeid
            AND company_id = v_inp_compid;*/
        
          --开启执行器
          p_capc_updxxlinfotriggerstatus_at(v_inp_triggerstatus => 1,
                                            v_inp_executorparam => v_inp_executor);
      END;
    
      --变更执行器状态为“等待”
      p_upd_queueexecutorstatusandqueueid_at(v_inp_queueexeid => v_inp_queueexeid,
                                             v_inp_compid     => v_inp_compid,
                                             v_inp_status     => 'P',
                                             v_inp_queueid    => NULL);
      /*UPDATE scmdata.t_queue_executor
        SET execute_status = 'P', queue_id = NULL
      WHERE queueexe_id = v_inp_queueexeid
        AND company_id = v_inp_compid;*/
    ELSIF v_exestatus = 'R' THEN
      SELECT MAX(outqueue_time)
        INTO v_outqueuetime
        FROM scmdata.t_queue que
       WHERE EXISTS (SELECT 1
                FROM scmdata.t_queue_executor
               WHERE queueexe_id = v_inp_queueexeid
                 AND company_id = v_inp_compid
                 AND queue_id = que.queue_id
                 AND company_id = que.company_id);
    
      IF v_outqueuetime IS NOT NULL THEN
        p_upd_queueexecutorstatus_at(v_inp_queueexeid => v_inp_queueexeid,
                                     v_inp_compid     => v_inp_compid,
                                     v_inp_status     => 'P');
        /*UPDATE scmdata.t_queue_executor
          SET execute_status = 'P'
        WHERE queueexe_id = v_inp_queueexeid
          AND company_id = v_inp_compid;*/
      END IF;
    END IF;
  
    --COMMIT;
  
    IF v_iscontinue = 1 THEN
      --递归调用
      p_capc_executorlogic(v_inp_dispatcher => v_inp_dispatcher,
                           v_inp_executor   => v_inp_executor,
                           v_inp_queueexeid => v_inp_queueexeid,
                           v_inp_compid     => v_inp_compid,
                           v_inp_iswprecalc => v_inp_iswprecalc);
    END IF;
  END p_capc_executorlogic;

  /*=================================================================================
  
    执行核心逻辑（新）
  
    入参:
      v_queueid  :  队列id
      v_compid   :  企业id
  
    版本:
      2022-12-16 : 执行核心逻辑（新）
  
  =================================================================================*/
  PROCEDURE p_capc_queueexecutecore_new
  (
    v_queueid IN VARCHAR2,
    v_compid  IN VARCHAR2
  ) IS
    v_corelogic   VARCHAR2(1024);
    v_loglogicbef VARCHAR2(512);
    v_loglogicaft VARCHAR2(512);
    v_exesql      CLOB;
    v_starttime   DATE;
    v_endtime     DATE;
  BEGIN
    v_starttime := SYSDATE;
  
    SELECT MAX(core_logic),
           MAX(log_logic_before),
           MAX(log_logic_after)
      INTO v_corelogic,
           v_loglogicbef,
           v_loglogicaft
      FROM scmdata.t_queue_cfg
     WHERE queue_type IN (SELECT queue_type
                            FROM scmdata.t_queue
                           WHERE queue_id = v_queueid
                             AND company_id = v_compid);
  
    IF v_corelogic IS NOT NULL THEN
      v_exesql := 'DECLARE V_QUEUEID  VARCHAR2(32):=''' || v_queueid ||
                  '''; V_COMPID  VARCHAR2(32):=''' || v_compid || '''; ' ||
                  'BEGIN ' || v_loglogicbef || ' ' || v_corelogic || ' ' ||
                  v_loglogicaft || ' END;';
    
      EXECUTE IMMEDIATE v_exesql;
    
      UPDATE scmdata.t_queue
         SET queue_status = 'SS'
       WHERE queue_id = v_queueid
         AND company_id = v_compid;
    END IF;
  
    v_endtime := SYSDATE;
  
    UPDATE scmdata.t_queue
       SET queueexe_time = v_starttime,
           outqueue_time = v_endtime
     WHERE queue_id = v_queueid
       AND company_id = v_compid;
  
  EXCEPTION
    WHEN OTHERS THEN
      UPDATE scmdata.t_queue
         SET queue_status  = 'ER',
             queueexe_time = v_starttime,
             outqueue_time = v_endtime
       WHERE queue_id = v_queueid
         AND company_id = v_compid;
    
      p_gen_queue_executor_log_rec(v_queueexeid => 'Scm_prod',
                                   v_queueid    => v_queueid,
                                   v_queexerst  => 'SS',
                                   v_exeinfo    => '队列：' || v_queueid ||
                                                   '执行失败' || chr(10) ||
                                                   substr(SQLERRM, 1, 1024),
                                   v_compid     => v_compid);
  END p_capc_queueexecutecore_new;

  /*=================================================================================
  
    执行器逻辑（新）
  
    入参:
      v_inp_dispatcher      :  调度器 element_id
      v_inp_executor        :  执行器 element_id
      v_compid              :  企业id
      v_inp_iswkplanrecalc  :  执行状态是否为周产能重算
                                     0-非周产能重算
                                     1-周产能重算
  
    版本:
      2022-12-30 : 执行器逻辑（新）
  
  =================================================================================*/
  PROCEDURE p_capc_executorlogic_new
  (
    v_inp_dispatcher IN VARCHAR2,
    v_inp_executor   IN VARCHAR2,
    v_inp_compid     IN VARCHAR2,
    v_inp_iswprecalc IN NUMBER
  ) IS
    v_queueid    VARCHAR2(32);
    v_iscontinue NUMBER(1) := 1;
  BEGIN
    --关闭执行器
    p_capc_updxxlinfotriggerstatus_at(v_inp_triggerstatus => 0,
                                      v_inp_executorparam => v_inp_executor);
  
    --获取最早未执行队列Id
    v_queueid := f_get_earliestqueueid(v_inp_iswprecalc => v_inp_iswprecalc,
                                       v_inp_compid     => v_inp_compid);
  
    IF v_queueid IS NULL THEN
      --是否继续
      v_iscontinue := 0;
    
      --关闭执行器
      p_capc_updxxlinfotriggerstatus_at(v_inp_triggerstatus => 0,
                                        v_inp_executorparam => v_inp_executor);
    
      --开启调度器
      p_capc_updxxlinfotriggerstatus_at(v_inp_triggerstatus => 1,
                                        v_inp_executorparam => v_inp_dispatcher);
    ELSE
      BEGIN
        --执行执行器逻辑
        p_capc_queueexecutecore_new(v_queueid => v_queueid,
                                    v_compid  => v_inp_compid);
      
        --更改队列状态          
        UPDATE scmdata.t_queue
           SET queue_status = 'SS'
         WHERE queue_id = v_queueid
           AND company_id = v_inp_compid;
      EXCEPTION
        WHEN OTHERS THEN
          --更改队列状态 
          UPDATE scmdata.t_queue
             SET queue_status = 'ER'
           WHERE queue_id = v_queueid
             AND company_id = v_inp_compid;
      END;
    END IF;
  
    --递归调用
    IF v_iscontinue = 1 THEN
      p_capc_executorlogic_new(v_inp_dispatcher => v_inp_dispatcher,
                               v_inp_executor   => v_inp_executor,
                               v_inp_compid     => v_inp_compid,
                               v_inp_iswprecalc => v_inp_iswprecalc);
    END IF;
  END p_capc_executorlogic_new;

END pkg_queue;
/

