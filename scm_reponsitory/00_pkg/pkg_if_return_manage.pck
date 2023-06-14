create or replace package scmdata.PKG_IF_RETURN_MANAGE is

  -- Author  : HX87
  -- Created : 2021/9/25 14:28:42
  -- Purpose : 门店退货接口处理包
  

  -- Public function and procedure declarations
  --function <FunctionName>(<Parameter> <Datatype>) return <Datatype>;
  function Validata_RETURN_MANAGE(pi_company_id in varchar2,
                                  PI_EXG_ID     IN VARCHAR2,
                                  PI_GOO_ID     IN VARCHAR2,
                                  PI_SUP_ID     IN VARCHAR2,
                                  pi_mod_type   IN VARCHAR2,
                                  pio_error_message in out varchar2) RETURN BOOLEAN;
  PROCEDURE SYNC_SCMDATA_TABLE(pi_company_id in varchar2,pio_error_message in out varchar2);
end PKG_IF_RETURN_MANAGE;
/

CREATE OR REPLACE PACKAGE BODY SCMDATA.PKG_IF_RETURN_MANAGE IS

  FUNCTION VALIDATA_RETURN_MANAGE(PI_COMPANY_ID     IN VARCHAR2,
                                  PI_EXG_ID         IN VARCHAR2,
                                  PI_GOO_ID         IN VARCHAR2,
                                  PI_SUP_ID         IN VARCHAR2,
                                  PI_MOD_TYPE       IN VARCHAR2,
                                  PIO_ERROR_MESSAGE IN OUT VARCHAR2)
    RETURN BOOLEAN IS
    V_I                 INT;
    V_STR_ERROR_MESSAGE VARCHAR2(2000);
  BEGIN
    --1.通用校验
    IF PI_MOD_TYPE NOT IN ('I', 'U', 'D') THEN
      V_STR_ERROR_MESSAGE := '变更类型[' || PI_MOD_TYPE || '] 不在[I,U,D]列表内';
    END IF;
    IF PI_GOO_ID IS NULL OR PI_SUP_ID IS NULL THEN
      V_STR_ERROR_MESSAGE := '传入的货号货供应商号为空，无法插入数据';
    END IF;
    --2.模块专属校验
  
    SELECT MAX(1)
      INTO V_I
      FROM T_RETURN_MANAGEMENT A
     WHERE A.EXG_ID = PI_EXG_ID
       AND A.COMPANY_ID = PI_COMPANY_ID;
    IF V_I = 1 AND PI_MOD_TYPE = 'I' THEN
      V_STR_ERROR_MESSAGE := '已存在数据，单据号[' || PI_EXG_ID || ']，无法插入重复数据';
    END IF;
  
    IF V_STR_ERROR_MESSAGE IS NOT NULL THEN
      PIO_ERROR_MESSAGE := V_STR_ERROR_MESSAGE;
      RETURN FALSE;
    END IF;
    RETURN TRUE;
  END;

  PROCEDURE SYNC_SCMDATA_TABLE(PI_COMPANY_ID     IN VARCHAR2,
                               PIO_ERROR_MESSAGE IN OUT VARCHAR2) IS
  BEGIN
    IF PIO_ERROR_MESSAGE IS NULL THEN 
    INSERT INTO T_RETURN_MANAGEMENT
      (RM_ID,
       YEAR,
       QUARTER,
       MONTH,
       EXG_ID,
       COMPANY_ID,
       SHO_ID,
       SUPPLIER_CODE,
       ORIGIN,
       CREATE_TIME,
       FINISH_TIME,
       EXTRACT_TIME,
       SENDGOODS_TIME,
       SENDGOODSWAY,
       MEMO,
       ISMATERIAL,
       GOO_ID,
       RELA_GOO_ID,
       EXAMOUNT,
       GOTAMOUNT,
       RM_TYPE,
       FIRST_DEPT_ID,
       SECOND_DEPT_ID,
       MERCHER_ID,
       MERCHER_DIRECTOR_ID,
       QC_ID,
       QC_DIRECTOR_ID,
       QA_ID,
       PROBLEM_CLASS_ID,
       CAUSE_CLASS_ID,
       CAUSE_DETAIL_ID,
       PROBLEM_DEC)
      SELECT F_GET_UUID(),
             TO_NUMBER(TO_CHAR(A.FINISH_TIME, 'yyyy')) YEAR,
             TO_NUMBER(TO_CHAR(A.FINISH_TIME, 'q')) QUARTER,
             TO_NUMBER(TO_CHAR(A.FINISH_TIME, 'mm')),
             A.EXG_ID,
             A.COMPANY_ID,
             A.SHO_ID,
             B.SUPPLIER_CODE,
             ORIGIN,
             A.CREATE_TIME,
             A.FINISH_TIME,
             A.EXTRACT_TIME,
             A.SENDGOODS_TIME,
             A.SENDGOODSWAY,
             A.MEMO,
             A.ISMATERIAL,
             C.GOO_ID,
             C.RELA_GOO_ID,
             A.EXAMOUNT,
             A.GOTAMOUNT,
             NULL RM_TYPE,
             NULL FIRST_DEPT_ID,
             NULL SECOND_DEPT_ID,
             NULL MERCHER,
             NULL MERCHER_DIRECTOR,
             NULL QC,
             NULL QC_DIRECTOR,
             NULL QA,
             NULL PROBLEM_CLASS_ID,
             NULL CAUSE_CLASS_ID,
             NULL CAUSE_DETAIL_ID,
             NULL PROBLEM_DEC
        FROM SCM_INTERFACE.CMX_RETURN_MANAGEMENT_INT A
       INNER JOIN T_SUPPLIER_INFO B
          ON A.SUP_ID = B.INSIDE_SUPPLIER_CODE
         AND A.COMPANY_ID = B.COMPANY_ID
       INNER JOIN T_COMMODITY_INFO C
          ON A.GOO_ID = C.RELA_GOO_ID
       WHERE A.STATUS = 'R';
    END IF;
  END;
END PKG_IF_RETURN_MANAGE;
/

