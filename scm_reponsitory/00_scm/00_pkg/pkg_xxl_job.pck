CREATE OR REPLACE PACKAGE SCMDATA.pkg_xxl_job IS

  /*=================================================================================
  
    【正常使用】根据执行器参数停止 XXL_JOB 任务
  
    入参：
      v_exeparam  :  执行器参数
  
    版本:
      2022-03-26: 根据执行器参数停止 XXL_JOB 任务
  
  =================================================================================*/
  PROCEDURE p_stop_xxljob_by_exeparam_at(v_exeparam IN VARCHAR2);

  /*=================================================================================
  
    【正常使用】根据执行器参数启动 XXL_JOB 任务
  
    入参：
      v_exeparam  :  执行器参数
  
    版本:
      2022-03-26: 根据执行器参数启动 XXL_JOB 任务
  
  =================================================================================*/
  PROCEDURE p_start_xxljob_by_exeparam_at(v_exeparam IN VARCHAR2);

END pkg_xxl_job;
/

CREATE OR REPLACE PACKAGE BODY SCMDATA.pkg_xxl_job IS

  /*=================================================================================
  
    【正常使用】根据执行器参数停止 XXL_JOB 任务
  
    入参：
      v_exeparam  :  执行器参数
  
    版本:
      2022-03-26: 根据执行器参数停止 XXL_JOB 任务
  
  =================================================================================*/
  PROCEDURE p_stop_xxljob_by_exeparam_at(v_exeparam IN VARCHAR2) IS
    PRAGMA AUTONOMOUS_TRANSACTION;
    v_exesql VARCHAR2(512);
  BEGIN
    v_exesql := 'UPDATE bw3.xxl_job_info SET trigger_status = 0 WHERE executor_param = :a';
    EXECUTE IMMEDIATE v_exesql
      USING v_exeparam;
  
    COMMIT;
  END p_stop_xxljob_by_exeparam_at;

  /*=================================================================================
  
    【正常使用】根据执行器参数启动 XXL_JOB 任务
  
    入参：
      v_exeparam  :  执行器参数
  
    版本:
      2022-03-26: 根据执行器参数启动 XXL_JOB 任务
  
  =================================================================================*/
  PROCEDURE p_start_xxljob_by_exeparam_at(v_exeparam IN VARCHAR2) IS
    PRAGMA AUTONOMOUS_TRANSACTION;
    v_exesql VARCHAR2(512);
  BEGIN
    v_exesql := 'UPDATE bw3.xxl_job_info SET trigger_status = 1 WHERE executor_param = :a';
    EXECUTE IMMEDIATE v_exesql
      USING v_exeparam;
  
    COMMIT;
  END p_start_xxljob_by_exeparam_at;

END pkg_xxl_job;
/

