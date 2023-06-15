CREATE OR REPLACE PACKAGE SCMDATA.PKG_XXL_JOB IS

  /*=================================================================================

    【正常使用】根据执行器参数停止 XXL_JOB 任务

    入参：
      V_EXEPARAM  :  执行器参数

    版本:
      2022-03-26: 根据执行器参数停止 XXL_JOB 任务

  =================================================================================*/
  PROCEDURE P_STOP_XXLJOB_BY_EXEPARAM_AT(V_EXEPARAM  IN VARCHAR2);
  
  
  /*=================================================================================

    【正常使用】根据执行器参数启动 XXL_JOB 任务

    入参：
      V_EXEPARAM  :  执行器参数

    版本:
      2022-03-26: 根据执行器参数启动 XXL_JOB 任务

  =================================================================================*/
  PROCEDURE P_START_XXLJOB_BY_EXEPARAM_AT(V_EXEPARAM  IN VARCHAR2);
  
END PKG_XXL_JOB;
/

CREATE OR REPLACE PACKAGE BODY SCMDATA.PKG_XXL_JOB IS

  /*=================================================================================

    【正常使用】根据执行器参数停止 XXL_JOB 任务

    入参：
      V_EXEPARAM  :  执行器参数

    版本:
      2022-03-26: 根据执行器参数停止 XXL_JOB 任务

  =================================================================================*/
  PROCEDURE P_STOP_XXLJOB_BY_EXEPARAM_AT(V_EXEPARAM  IN VARCHAR2) IS
    PRAGMA AUTONOMOUS_TRANSACTION;
    V_EXESQL  VARCHAR2(512);
  BEGIN
    V_EXESQL := 'UPDATE NBW.XXL_JOB_INFO SET TRIGGER_STATUS = 0 WHERE EXECUTOR_PARAM = :A';
    EXECUTE IMMEDIATE V_EXESQL USING V_EXEPARAM;
    
    COMMIT;
  END P_STOP_XXLJOB_BY_EXEPARAM_AT;
  
  /*=================================================================================

    【正常使用】根据执行器参数启动 XXL_JOB 任务

    入参：
      V_EXEPARAM  :  执行器参数

    版本:
      2022-03-26: 根据执行器参数启动 XXL_JOB 任务

  =================================================================================*/
  PROCEDURE P_START_XXLJOB_BY_EXEPARAM_AT(V_EXEPARAM  IN VARCHAR2) IS
    PRAGMA AUTONOMOUS_TRANSACTION;
    V_EXESQL  VARCHAR2(512);
  BEGIN
    V_EXESQL := 'UPDATE NBW.XXL_JOB_INFO SET TRIGGER_STATUS = 1 WHERE EXECUTOR_PARAM = :A';
    EXECUTE IMMEDIATE V_EXESQL USING V_EXEPARAM;
    
    COMMIT;
  END P_START_XXLJOB_BY_EXEPARAM_AT;

END PKG_XXL_JOB;
/

