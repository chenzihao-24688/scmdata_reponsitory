﻿CREATE OR REPLACE PACKAGE SCMDATA.PKG_RETURN_TEST IS

  /*============================================*
  * Author   : DYY153
  * Created  : 2021-10-27 15:35:23
  * ALERTER  :
  * ALERTER_TIME  :
  * Purpose  : 退货管理相关处理包
  *============================================*/

  --审核时必填项校验
  FUNCTION F_CHECK_RETURN_NESINFO(V_RM_ID       IN VARCHAR2,
                                  V_EXG_ID      IN VARCHAR2,
                                  V_RELA_GOO_ID IN VARCHAR2,
                                  V_COMPANY_ID  IN VARCHAR2,
                                  V_ERRINFO     IN CLOB) RETURN CLOB;

  --审核时校验所在分组、区域组长
  FUNCTION F_CHECK_AREA(V_RM_ID       IN VARCHAR2,
                        V_COMPANY_ID  IN VARCHAR2,
                        V_RELA_GOO_ID IN VARCHAR2,
                        V_ERRINFO     IN CLOB) RETURN CLOB;

  --审核时校验结束时间
  FUNCTION F_CHECK_RETURN_FINISHTIME(V_RM_ID       IN VARCHAR2,
                                     V_EXG_ID      IN VARCHAR2,
                                     V_RELA_GOO_ID IN VARCHAR2,
                                     V_COMPANY_ID  IN VARCHAR2,
                                     V_ERRINFO     IN CLOB) RETURN CLOB;

  --审核时校验批量问题
  FUNCTION F_CHECK_RETURN_RMTYPE_CAUSE(V_RM_ID       IN VARCHAR2,
                                       V_EXG_ID      IN VARCHAR2,
                                       V_RELA_GOO_ID IN VARCHAR2,
                                       V_COMPANY_ID  IN VARCHAR2,
                                       V_ERRINFO     IN CLOB) RETURN CLOB;

  /*=============================================================================
    校验接口表数据
      用途：
            校验接口的货号和供应商编号是否已存在于scm档案中
            不符合条件的数据记录到t_variable中，并更新接口表状态
            接口数据状态（PORT_STATUS）字段，通过则更新接口状态为'SP'
            不通过则更新为'CE'
  ===============================================================================*/

  PROCEDURE P_CHECK_EXGINFO(V_TAB       IN VARCHAR2,
                            V_EXGID     IN VARCHAR2,
                            V_GOOID     IN VARCHAR2 DEFAULT NULL,
                            V_SUPCODE   IN VARCHAR2 DEFAULT NULL,
                            V_COMPANYID IN VARCHAR2,
                            V_EOBJID    IN VARCHAR2,
                            V_SUCSTATUS IN VARCHAR2 DEFAULT NULL);

  /*=============================================================================
  接入熊猫的数据到接口表 cmx_return_management_int
        用途：将熊猫换货明细（EXCHANGEGOOD、EXCHANGEGOODS、RETURN_MOVEADS及退货原因）有结束时间的数据接入到接口表cmx_return_management_int
  ============================================================================*/

  PROCEDURE P_RETURN_MANAGEMENT_IT(V_EXG_ID          IN VARCHAR2,
                                   V_SHO_ID          IN VARCHAR2,
                                   V_SUP_ID          IN VARCHAR2,
                                   V_COMPANYID       IN VARCHAR2,
                                   V_CREATETIME      IN DATE,
                                   V_EXTRACTTIME     IN DATE,
                                   V_SENDGOODSTIME   IN DATE,
                                   V_SENDGOODSWAY    IN VARCHAR2,
                                   V_MEMO            IN VARCHAR2,
                                   V_INT_ID          IN VARCHAR2,
                                   V_ISMATERIAL      IN NUMBER,
                                   V_BUYERID         IN VARCHAR2, --跟单员员工号
                                   V_GOO_ID          IN VARCHAR2,
                                   V_EXAMOUNT        IN NUMBER,
                                   V_GOTAMOUNT       IN NUMBER,
                                   V_FINISHTIME      IN DATE,
                                   V_RETURNCAUSENAME IN VARCHAR2,
                                   V_CAUSE_DESC      IN VARCHAR2,
                                   V_QUESTION_DESC   IN VARCHAR2);

  ----获取分部的跟单主管
  /*==========================================================================
      用途：分部-部门映射表未上线前用于获取分部对应的跟单主管

      入参：
          PI_GOO_ID    ： SCM货号
          PI_COMPANY_ID： 企业id

      返回值： 跟单主管的user_id
  ==============================================================================*/
  FUNCTION F_GET_DEAL_FOLLOWER_DIRE(PI_GOO_ID     IN VARCHAR2,
                                    PI_COMPANY_ID IN VARCHAR2)
    RETURN VARCHAR2;

  /*============================================================================
   用途：用于获取货号对应供应商同分类的指定跟单员

   入参：
        PI_GOO_ID  :scm货号
        PI_COMPANY_ID: 企业id

   返回值：跟单的user_id

  =============================================================================*/

  FUNCTION F_GET_GENDAN(PI_GOO_ID IN VARCHAR2,PI_SUP_ID IN VARCHAR2 DEFAULT NULL, PI_COMPANY_ID IN VARCHAR2)
    RETURN VARCHAR2;

  /*==============================================================================
   接口表数据同步到业务表
     用途：将cmx_return_management_int待同步数据，进行校验
           如果不存在，新增到t_return_management
           如果存在，更新到t_return_management
  ===============================================================================*/

  PROCEDURE P_RETURN_MANAGE_SYNC;

  /*================================================================================
  未处理记录的定时审核action
    用途：每月4号凌晨00：00 自动审核上月未审核且符合条件的记录
          审核完成后数据流转到已处理页面

  ================================================================================*/
  PROCEDURE P_RM_CHECK_AUTO;

  /*================================================================================

  接入时校验未通过的数据，商品档案/供应商档案在scm建档后再次校验，
  通过则更新scmdata.cmx_return_management_int.port_status 状态为'SP'待同步
  入参：
        pi_comid 企业id
  ==============================================================================*/
  PROCEDURE P_UPDATE_PORTSTATUS(/*PI_TAB IN VARCHAR2,*/ PI_COMID IN VARCHAR2);

  /*===============================================================================
    已同步scmdata.t_return_management后，若SUP_GROUP_NAME,AREA_GROUP_LEADER字段为空
    根据scmdata.t_supplier_info更新所在分组和区域组长字段

  =================================================================================*/
  PROCEDURE P_UPDATE_GROUPNAME;

  /*=================================================================================

   根据供应商省市+货号分类、类别在所在分组配置表匹配出所在分组配置表id
   入参：
          F_COMPANY_PROVINCE  供应商的省份编码,
          F_COMPANY_CITY     供应商的城市编码,
          F_CATEGORY         分类,
          F_PRODUCT_CATE     生产类别,
          F_COMPID           企业id

  ===================================================================================*/

  FUNCTION F_GET_GROUPNAME(F_COMPANY_PROVINCE IN VARCHAR2,
                         F_COMPANY_CITY     IN VARCHAR2,
                         F_CATEGORY         IN VARCHAR2,
                         F_PRODUCT_CATE     IN VARCHAR2,
                         F_SUBCATE          IN VARCHAR2,
                         F_COMPID           IN VARCHAR2) RETURN VARCHAR2;

END PKG_RETURN_TEST;
/

CREATE OR REPLACE PACKAGE BODY SCMDATA.PKG_RETURN_TEST IS

  --审核时必填项校验
  FUNCTION F_CHECK_RETURN_NESINFO(V_RM_ID       IN VARCHAR2,
                                  V_EXG_ID      IN VARCHAR2,
                                  V_RELA_GOO_ID IN VARCHAR2,
                                  V_COMPANY_ID  IN VARCHAR2,
                                  V_ERRINFO     IN CLOB) RETURN CLOB IS
    JUDGE1        NUMBER(2);
    V_RET_ERRINFO CLOB := V_ERRINFO;
  BEGIN
    SELECT COUNT(1)
      INTO JUDGE1
      FROM SCMDATA.T_RETURN_MANAGEMENT A
     WHERE A.EXG_ID = V_EXG_ID
       AND A.RELA_GOO_ID = V_RELA_GOO_ID
       AND A.COMPANY_ID = V_COMPANY_ID
       AND RM_ID = V_RM_ID
       AND A.CAUSE_DETAIL_ID IS NOT NULL
       AND A.FIRST_DEPT_ID IS NOT NULL
       AND A.SECOND_DEPT_ID IS NOT NULL
      --AND A.FINISH_TIME IS NOT NULL
       AND A.MERCHER_ID IS NOT NULL
       AND A.RM_TYPE IS NOT NULL
       AND A.EXAMOUNT IS NOT NULL
       AND ROWNUM = 1;
    IF JUDGE1 = 0 THEN
      V_RET_ERRINFO := V_ERRINFO || ' ' || V_RELA_GOO_ID;
    END IF;
    V_RET_ERRINFO := TRIM(V_RET_ERRINFO);
    V_RET_ERRINFO := REPLACE(V_RET_ERRINFO, ' ', ',');
    RETURN V_RET_ERRINFO;
  END F_CHECK_RETURN_NESINFO;

  --审核时校验所在分组、区域组长
  FUNCTION F_CHECK_AREA(V_RM_ID       IN VARCHAR2,
                        V_COMPANY_ID  IN VARCHAR2,
                        V_RELA_GOO_ID IN VARCHAR2,
                        V_ERRINFO     IN CLOB) RETURN CLOB IS
    V_JUDGE1      NUMBER(2);
    V_RET_ERRINFO CLOB := V_ERRINFO;
  BEGIN
    SELECT COUNT(1)
      INTO V_JUDGE1
      FROM SCMDATA.T_RETURN_MANAGEMENT B
     WHERE B.RM_ID = V_RM_ID
       AND B.COMPANY_ID = V_COMPANY_ID
       AND B.SUP_GROUP_NAME IS NOT NULL
       AND B.AREA_GROUP_LEADER IS NOT NULL
       AND ROWNUM = 1;
    IF V_JUDGE1 = 0 THEN
      V_RET_ERRINFO := V_ERRINFO || ' ' || V_RELA_GOO_ID;
    END IF;
    V_RET_ERRINFO := TRIM(V_RET_ERRINFO);
    V_RET_ERRINFO := REPLACE(V_RET_ERRINFO, ' ', ',');
    RETURN V_RET_ERRINFO;
  END F_CHECK_AREA;

  --审核时校验结束时间
  FUNCTION F_CHECK_RETURN_FINISHTIME(V_RM_ID       IN VARCHAR2,
                                     V_EXG_ID      IN VARCHAR2,
                                     V_RELA_GOO_ID IN VARCHAR2,
                                     V_COMPANY_ID  IN VARCHAR2,
                                     V_ERRINFO     IN CLOB) RETURN CLOB IS
    JUDGE2        NUMBER(2);
    V_RET_ERRINFO CLOB := V_ERRINFO;
  BEGIN
    SELECT COUNT(1)
      INTO JUDGE2
      FROM SCMDATA.T_RETURN_MANAGEMENT
     WHERE EXG_ID = V_EXG_ID
       AND RELA_GOO_ID = V_RELA_GOO_ID
       AND COMPANY_ID = V_COMPANY_ID
       AND RM_ID = V_RM_ID
       AND FINISH_TIME IS NOT NULL
       AND ROWNUM = 1;
    IF JUDGE2 = 0 THEN
      V_RET_ERRINFO := V_ERRINFO || ' ' || V_RELA_GOO_ID;
    END IF;
    V_RET_ERRINFO := TRIM(V_RET_ERRINFO);
    V_RET_ERRINFO := REPLACE(V_RET_ERRINFO, ' ', ',');
    RETURN V_RET_ERRINFO;
  END F_CHECK_RETURN_FINISHTIME;

  --审核时校验批量问题
  FUNCTION F_CHECK_RETURN_RMTYPE_CAUSE(V_RM_ID       IN VARCHAR2,
                                       V_EXG_ID      IN VARCHAR2,
                                       V_RELA_GOO_ID IN VARCHAR2,
                                       V_COMPANY_ID  IN VARCHAR2,
                                       V_ERRINFO     IN CLOB) RETURN CLOB IS
    JUDGE3        VARCHAR(128);
    JUDGE4        VARCHAR(128);
    V_RET_ERRINFO CLOB := V_ERRINFO;
  BEGIN
    SELECT MAX(A.RM_TYPE), MAX(B.CAUSE_DETAIL)
      INTO JUDGE3, JUDGE4
      FROM SCMDATA.T_RETURN_MANAGEMENT A
     INNER JOIN SCMDATA.T_ABNORMAL_DTL_CONFIG B
        ON A.CAUSE_DETAIL_ID = B.ABNORMAL_DTL_CONFIG_ID
       AND A.COMPANY_ID = B.COMPANY_ID
     WHERE A.EXG_ID = V_EXG_ID
       AND A.RM_ID = V_RM_ID
       AND A.RELA_GOO_ID = V_RELA_GOO_ID
       AND A.COMPANY_ID = V_COMPANY_ID;
    IF JUDGE3 = '批量' AND JUDGE4 = '其他零星问题' THEN
      V_RET_ERRINFO := V_ERRINFO || ' ' || V_RELA_GOO_ID;
    END IF;
    V_RET_ERRINFO := TRIM(V_RET_ERRINFO);
    V_RET_ERRINFO := REPLACE(V_RET_ERRINFO, ' ', ',');
    RETURN V_RET_ERRINFO;
  END F_CHECK_RETURN_RMTYPE_CAUSE;

  --------校验接口表数据
  PROCEDURE P_CHECK_EXGINFO(V_TAB       IN VARCHAR2,
                            V_EXGID     IN VARCHAR2,
                            V_GOOID     IN VARCHAR2 DEFAULT NULL,
                            V_SUPCODE   IN VARCHAR2 DEFAULT NULL,
                            V_COMPANYID IN VARCHAR2,
                            V_EOBJID    IN VARCHAR2,
                            V_SUCSTATUS IN VARCHAR2 DEFAULT NULL) IS
    V_GOODID   VARCHAR2(512);
    V_SUPPCODE VARCHAR2(512);
    V_ERRINFO  CLOB;
    V_EXESQL   CLOB;
  BEGIN
    --商品是否存在scm档案校验
    IF V_GOOID IS NOT NULL THEN
      V_GOODID := SCMDATA.PKG_INTERFACE_LOG.F_CHECK_RELAGOOD_COMMODITY_EXIST(V_INRELAGOOID => V_GOOID,
                                                                             V_INCOMPID    => V_COMPANYID);
    END IF;

    --供应商是否存在scm档案校验
    IF V_SUPCODE IS NOT NULL THEN
      V_SUPPCODE := SCMDATA.PKG_INTERFACE_LOG.F_CHECK_ISDSUPCODE_EXIST(V_INISDSUPCODE => V_SUPCODE,
                                                                       V_INCOMPID     => V_COMPANYID);
    END IF;

    IF V_GOODID = 0 AND V_SUPPCODE = 0 THEN
      V_ERRINFO := '错误表:' || V_TAB || CHR(10) || '错误时间:' ||
                   TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24-MI-SS') || CHR(10) ||
                   '错误唯一列:EXG_ID' || CHR(10) || '错误唯一值:' || V_EXGID || '-' ||
                   V_GOOID || '-' || V_SUPCODE || CHR(10) ||
                   '该内部信息在商品档案、供应商档案未找到！';

    INSERT INTO SCMDATA.T_COMMODITY_INFO_CTL
        (CTL_ID,
         ITF_ID,
         ITF_TYPE,
         BATCH_ID,
         BATCH_NUM,
         BATCH_TIME,
         SENDER,
         RECEIVER,
         SEND_TIME,
         RECEIVE_TIME,
         RETURN_TYPE,
         RETURN_MSG,
         CREATE_ID,
         CREATE_TIME,
         UPDATE_ID,
         UPDATE_TIME,
         REMARKS,
         COMPANY_ID)
      VALUES
        (SCMDATA.F_GET_UUID(),
         V_GOOID,
         'GOOD_MAIN',
         NULL,
         NULL,
         SYSDATE,
         'mdm',
         'scm',
         SYSDATE,
         SYSDATE,
         'W',
         '商品货号: ' || V_GOOID || '指定重新导入',
         'ADMIN',
         SYSDATE,
         'ADMIN',
         SYSDATE,
         NULL,
         'b6cc680ad0f599cde0531164a8c0337f');

    ELSIF V_GOODID = 0 THEN
      V_ERRINFO := '错误表:' || V_TAB || CHR(10) || '错误时间:' ||
                   TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24-MI-SS') || CHR(10) ||
                   '错误唯一列:EXG_ID' || CHR(10) || '错误唯一值:' || V_EXGID || '-' ||
                   V_GOOID || CHR(10) || '该内部信息在商品档案未找到！';

   INSERT INTO SCMDATA.T_COMMODITY_INFO_CTL
        (CTL_ID,
         ITF_ID,
         ITF_TYPE,
         BATCH_ID,
         BATCH_NUM,
         BATCH_TIME,
         SENDER,
         RECEIVER,
         SEND_TIME,
         RECEIVE_TIME,
         RETURN_TYPE,
         RETURN_MSG,
         CREATE_ID,
         CREATE_TIME,
         UPDATE_ID,
         UPDATE_TIME,
         REMARKS,
         COMPANY_ID)
      VALUES
        (SCMDATA.F_GET_UUID(),
         V_GOOID,
         'GOOD_MAIN',
         NULL,
         NULL,
         SYSDATE,
         'mdm',
         'scm',
         SYSDATE,
         SYSDATE,
         'W',
         '商品货号: ' || V_GOOID || '指定重新导入',
         'ADMIN',
         SYSDATE,
         'ADMIN',
         SYSDATE,
         NULL,
         'b6cc680ad0f599cde0531164a8c0337f');


    ELSIF V_SUPPCODE = 0 THEN
      V_ERRINFO := '错误表:' || V_TAB || CHR(10) || '错误时间:' ||
                   TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24-MI-SS') || CHR(10) ||
                   '错误唯一列:EXG_ID' || CHR(10) || '错误唯一值:' || V_EXGID || '-' ||
                   V_SUPCODE || CHR(10) || '该内部信息在供应商档案未找到！';
    END IF;

    IF INSTR(V_ERRINFO, '错误') > 0 THEN
      SCMDATA.PKG_INTERFACE_LOG.P_UPDATE_INTERFACE_VARIABLE(V_EOBJID  => V_EOBJID,
                                                            V_COMPID  => V_COMPANYID,
                                                            V_UNQVAL  => V_EXGID,
                                                            V_ERRINFO => V_ERRINFO,
                                                            V_MODE    => 'CE');




      V_EXESQL := 'UPDATE ' || V_TAB || ' SET PORT_ELEMENT = ''' ||
                  V_EOBJID ||
                  ''', PORT_STATUS = ''CE'', PORT_TIME = SYSDATE WHERE EXG_ID = :A AND COMPANY_ID = :B AND GOO_ID = :C';
    ELSE
      SCMDATA.PKG_VARIABLE.P_SET_VARIABLE_INCREMENT(V_OBJID   => V_EOBJID,
                                                    V_COMPID  => V_COMPANYID,
                                                    V_VARNAME => 'SSNUM');
      IF V_SUCSTATUS IS NOT NULL THEN
        V_EXESQL := 'UPDATE ' || V_TAB || ' SET PORT_ELEMENT = ''' ||
                    V_EOBJID || ''', PORT_STATUS = ''' || V_SUCSTATUS ||
                    ''', PORT_TIME = SYSDATE WHERE EXG_ID = :A AND COMPANY_ID = :B AND GOO_ID = :C';
      ELSE
        V_EXESQL := 'UPDATE ' || V_TAB || ' SET PORT_ELEMENT = ''' ||
                    V_EOBJID ||
                    ''', PORT_TIME = SYSDATE WHERE EXG_ID = :A AND COMPANY_ID = :B AND GOO_ID = :C';
      END IF;
    END IF;
    EXECUTE IMMEDIATE V_EXESQL
      USING V_EXGID, V_COMPANYID, V_GOOID;
  END P_CHECK_EXGINFO;

  ----scm接口
  PROCEDURE P_RETURN_MANAGEMENT_IT(V_EXG_ID          IN VARCHAR2,
                                   V_SHO_ID          IN VARCHAR2,
                                   V_SUP_ID          IN VARCHAR2,
                                   V_COMPANYID       IN VARCHAR2,
                                   V_CREATETIME      IN DATE,
                                   V_EXTRACTTIME     IN DATE,
                                   V_SENDGOODSTIME   IN DATE,
                                   V_SENDGOODSWAY    IN VARCHAR2,
                                   V_MEMO            IN VARCHAR2,
                                   V_INT_ID          IN VARCHAR2,
                                   V_ISMATERIAL      IN NUMBER,
                                   V_BUYERID         IN VARCHAR2, --跟单员员工号
                                   V_GOO_ID          IN VARCHAR2,
                                   V_EXAMOUNT        IN NUMBER,
                                   V_GOTAMOUNT       IN NUMBER,
                                   V_FINISHTIME      IN DATE,
                                   V_RETURNCAUSENAME IN VARCHAR2,
                                   V_CAUSE_DESC      IN VARCHAR2,
                                   V_QUESTION_DESC   IN VARCHAR2)

    ----校验接口表是否存在该数据
   IS
    V_JUDGE1  NUMBER(1);
    V_EXESQL  VARCHAR2(3000);
    V_UNQVALS VARCHAR2(3000);
  BEGIN
    SCMDATA.PKG_INTERFACE_LOG.P_INSERT_INFO_AND_INIT_VARIABLE(V_EOBJID => 'scm_return_management_ITF',
                                                              V_COMPID => V_COMPANYID,
                                                              V_MINUTE => 1);
    IF V_EXG_ID IS NOT NULL /*AND V_FINISHTIME IS NOT NULL*/ THEN
      SELECT COUNT(1)
        INTO V_JUDGE1
        FROM SCMDATA.CMX_RETURN_MANAGEMENT_INT
       WHERE EXG_ID = V_EXG_ID
         AND GOO_ID = V_GOO_ID
         AND ROWNUM = 1;
      IF V_JUDGE1 = 0 THEN
        INSERT INTO SCMDATA.CMX_RETURN_MANAGEMENT_INT
          (EXG_ID,
           COMPANY_ID,
           SHO_ID,
           SUP_ID,
           CREATE_TIME,
           FINISH_TIME,
           EXTRACT_TIME,
           SENDGOODS_TIME,
           SENDGOODSWAY,
           MEMO,
           INT_ID,
           ISMATERIAL,
           MERCHER,
           GOO_ID,
           EXAMOUNT,
           GOTAMOUNT,
           PROBLEM_CLASS_ID,
           CAUSE_CLASS_ID,
           CAUSE_DETAIL_ID,
           MOD_TYPE,
           STATUS,
           PORT_TIME)
        VALUES
          (V_EXG_ID,
           V_COMPANYID,
           V_SHO_ID,
           V_SUP_ID,
           V_CREATETIME,
           V_FINISHTIME,
           V_EXTRACTTIME,
           V_SENDGOODSTIME,
           V_SENDGOODSWAY,
           V_MEMO,
           V_INT_ID,
           V_ISMATERIAL,
           V_BUYERID,
           V_GOO_ID,
           V_EXAMOUNT,
           V_GOTAMOUNT,
           V_QUESTION_DESC,
           V_CAUSE_DESC,
           V_RETURNCAUSENAME,
           'I',
           'R',
           SYSDATE);


        SCMDATA.PKG_RETURN_TEST.P_CHECK_EXGINFO(V_TAB       => 'CMX_RETURN_MANAGEMENT_INT',
                                                      V_EXGID     => V_EXG_ID,
                                                      V_GOOID     => V_GOO_ID,
                                                      V_SUPCODE   => V_SUP_ID,
                                                      V_COMPANYID => V_COMPANYID,
                                                      V_EOBJID    => 'scm_return_management_ITF',
                                                      V_SUCSTATUS => 'SP');
        ELSE UPDATE  SCMDATA.CMX_RETURN_MANAGEMENT_INT
                SET finish_time = V_FINISHTIME,
                    SHO_ID      =V_SHO_ID,
                    SUP_ID      =V_SUP_ID,
                    EXTRACT_TIME = V_EXTRACTTIME,
                    SENDGOODS_TIME = V_SENDGOODSTIME,
                    SENDGOODSWAY   = V_SENDGOODSWAY,
                    MEMO           = V_MEMO,
                    INT_ID         =V_INT_ID,
                    ISMATERIAL     =V_ISMATERIAL,
                    MERCHER        =V_BUYERID,
                    GOO_ID         =V_GOO_ID,
                    EXAMOUNT       = V_EXAMOUNT,
                    GOTAMOUNT      =V_GOTAMOUNT,
                    PROBLEM_CLASS_ID =V_QUESTION_DESC,
                    CAUSE_CLASS_ID =V_CAUSE_DESC,
                    CAUSE_DETAIL_ID =V_RETURNCAUSENAME,
                    MOD_TYPE        ='U',
                    port_status = 'SP',
                    PORT_TIME=SYSDATE
              WHERE exg_id = V_EXG_ID AND goo_id = V_GOO_ID;
      END IF;
    END IF;
  EXCEPTION
    WHEN OTHERS THEN
      V_EXESQL  := 'INSERT INTO SCMDATA.CMX_RETURN_MANAGEMENT_INT' ||
                   '(EXG_ID,SUP_ID,GOO_ID,PORT_ELEMENT,PORT_TIME,PORT_STATUS)' ||
                   'VALUES(''' || V_EXG_ID || ''',''' || V_SUP_ID ||
                   ''',''' || V_GOO_ID || ''',''SYS'',SYSDATE,''NC'')';
      V_UNQVALS := '门店退货信息通知' || CHR(13) || '换货单号：' || V_EXG_ID || CHR(13) ||
                   '货号：' || V_GOO_ID || CHR(13) || '接入失败时间：' ||
                   TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24-MI-SS');
      SCMDATA.PKG_INTERFACE_LOG.P_ITF_RUNTIME_ERROR_LOGIC(V_EOBJID  => 'scm_return_management_ITF',
                                                          V_COMPID  => V_COMPANYID,
                                                          V_TAB     => 'CMX_RETURN_MANAGEMENT_INT',
                                                          V_ERRSQL  => V_EXESQL,
                                                          V_UNQCOLS => 'EXG_ID' || ',' ||
                                                                       'GOO_ID',
                                                          V_UNQVALS => V_UNQVALS,
                                                          V_ST      => DBMS_UTILITY.FORMAT_ERROR_STACK);
      --企微机器人通知错误信息
      SCMDATA.PKG_SEND_WX_MSG.P_SEND_WX_MSG(P_COMPANY_ID => V_COMPANYID,
                                            P_ROBOT_TYPE => 'RETURN_MANA_MSG',
                                            P_MSGTYPE    => 'text',
                                            P_VAL_STEP   => ';',
                                            P_MSG_TITLE  => V_UNQVALS,
                                            P_SENDER     => 'DYY153');

  END P_RETURN_MANAGEMENT_IT;

  ----- 获取分部主管（未有部门-分部映射）

  FUNCTION F_GET_DEAL_FOLLOWER_DIRE(PI_GOO_ID IN VARCHAR2,
                                    --PI_GENDANYUAN IN VARCHAR2,
                                    PI_COMPANY_ID IN VARCHAR2)
    RETURN VARCHAR2 IS
    V__DEAL_DIRECOTR VARCHAR2(128);
    V_CATEGORY_NAME  VARCHAR2(128);
  BEGIN
    SELECT MAX(GROUP_DICT_NAME)
      INTO V_CATEGORY_NAME
      FROM SCMDATA.T_COMMODITY_INFO A
     INNER JOIN SCMDATA.SYS_GROUP_DICT B
        ON DECODE(A.CATEGORY, '06', '07', A.CATEGORY) = B.GROUP_DICT_VALUE
     WHERE B.GROUP_DICT_TYPE = 'PRODUCT_TYPE'
       AND A.GOO_ID = PI_GOO_ID
       AND A.COMPANY_ID = PI_COMPANY_ID;

    --所有的跟单主管及其部门名字
    SELECT MAX(A.USER_ID)
      INTO V__DEAL_DIRECOTR
      FROM SCMDATA.SYS_COMPANY_USER A
     INNER JOIN SCMDATA.SYS_COMPANY_USER_DEPT B
        ON A.USER_ID = B.USER_ID
       AND A.COMPANY_ID = B.COMPANY_ID
     INNER JOIN SCMDATA.SYS_COMPANY_DEPT C
        ON B.COMPANY_DEPT_ID = C.COMPANY_DEPT_ID
       AND B.COMPANY_ID = C.COMPANY_ID
       AND INSTR(C.DEPT_NAME, V_CATEGORY_NAME) > 0
     INNER JOIN SCMDATA.SYS_COMPANY_JOB D
        ON A.JOB_ID = D.JOB_ID
       AND A.COMPANY_ID = D.COMPANY_ID
       AND D.JOB_NAME = '跟单主管';

    RETURN V__DEAL_DIRECOTR;

  END F_GET_DEAL_FOLLOWER_DIRE;

  --获取对应货号分部的供应商指定跟单员
  FUNCTION F_GET_GENDAN(PI_GOO_ID IN VARCHAR2, 
                        PI_SUP_ID IN VARCHAR2 DEFAULT NULL,
                        PI_COMPANY_ID IN VARCHAR2)
    RETURN VARCHAR2 IS

    V_GENDAN   VARCHAR2(256);
    V_CATEGORY VARCHAR2(32);
    V_FENBU    VARCHAR2(32);
    VO_GENDAN  VARCHAR2(256);
  BEGIN
    ---商品的分类及供应商的跟单员
    SELECT MAX(A.CATEGORY), MAX(B.GENDAN_PERID)
      INTO V_CATEGORY, V_GENDAN
      FROM SCMDATA.T_COMMODITY_INFO A
     INNER JOIN SCMDATA.T_SUPPLIER_INFO B
        ON A.SUPPLIER_CODE = B.SUPPLIER_CODE
       AND A.GOO_ID = PI_GOO_ID
       AND A.COMPANY_ID = B.COMPANY_ID
       AND A.COMPANY_ID = PI_COMPANY_ID;
     IF PI_SUP_ID IS NOT NULL THEN 
       SELECT C.GENDAN_PERID
        INTO V_GENDAN
        FROM SCMDATA.T_SUPPLIER_INFO C
        WHERE C.SUPPLIER_CODE=PI_SUP_ID
          AND C.COMPANY_ID=PI_COMPANY_ID;  
      END IF;    
       
    IF V_GENDAN IS NULL THEN
      VO_GENDAN := '';
    ELSE
      ---拆分供应商跟单
      FOR I IN (SELECT REGEXP_SUBSTR(V_GENDAN, '[^,]+', 1, ROWNUM) GENDANYUAN
                  FROM DUAL
                CONNECT BY ROWNUM <= LENGTH(V_GENDAN) -
                           LENGTH(REPLACE(V_GENDAN, ',', '')) + 1) LOOP

        SELECT MAX(B.COOPERATION_CLASSIFICATION)
          INTO V_FENBU
          FROM SCMDATA.SYS_COMPANY_USER_DEPT A
         INNER JOIN SCMDATA.SYS_COMPANY_DEPT_CATE_MAP B
            ON A.COMPANY_DEPT_ID = B.COMPANY_DEPT_ID
           AND A.USER_ID = I.GENDANYUAN
           AND A.COMPANY_ID = B.COMPANY_ID
           AND B.PAUSE = 0
           AND A.COMPANY_ID = PI_COMPANY_ID;

        IF V_FENBU = V_CATEGORY THEN
          VO_GENDAN := I.GENDANYUAN || ' ' || VO_GENDAN;
        END IF;
      END LOOP;
    END IF;
    VO_GENDAN := TRIM(VO_GENDAN);
    VO_GENDAN := REPLACE(VO_GENDAN, ' ', ',');
    RETURN VO_GENDAN;
  END F_GET_GENDAN;

  ------接口表数据同步到t_return_management

  PROCEDURE P_RETURN_MANAGE_SYNC IS
    V_COMPID               VARCHAR2(32);
    V_EXG_ID               VARCHAR2(32);
    V_GOOID                VARCHAR2(32);
    V_RELAGOOID            VARCHAR2(32);
    V_SUPPID               VARCHAR2(32);
    V_GROUP_NAME           VARCHAR2(128); --分组名称
    V_AREA_LEADER          VARCHAR2(128); --分组组长
    V_JUDNUM               NUMBER(1);
    V_MERCHER2             VARCHAR2(256);
    V_DEAL_FOLLOWR_DIRCTOR VARCHAR2(256);
    V_QC_ID                VARCHAR2(256);
    V_QC_DIRECTOR_ID       VARCHAR2(256);
    V_PROVINID             VARCHAR2(148); --公司省份
    V_CITYID               VARCHAR2(148); --公司市
    V_CATEGORY             VARCHAR2(32); --分类
    V_PRODUCTCATE          VARCHAR2(32); --生产类别
    V_SUBCATE              VARCHAR2(32);
    V_AREAID               VARCHAR2(32); --分组id
    V_QA_ID                VARCHAR2(512);
    V_RM_CAUSE_DETAIL_ID   VARCHAR2(32);
    V_FIRST_DEPT_ID        VARCHAR2(32);
    V_SECOND_DEPT_ID       VARCHAR2(256);
    V_UNQVALS              CLOB;
  BEGIN
    FOR I IN (SELECT EXG_ID,
                     COMPANY_ID,
                     SHO_ID,
                     SUP_ID,
                     CREATE_TIME,
                     FINISH_TIME,
                     EXTRACT_TIME,
                     SENDGOODS_TIME,
                     SENDGOODSWAY,
                     MEMO,
                     ISMATERIAL,
                     MERCHER,
                     GOO_ID,
                     EXAMOUNT,
                     GOTAMOUNT,
                     RM_TYPE,
                     PROBLEM_CLASS_ID,
                     CAUSE_CLASS_ID,
                     CAUSE_DETAIL_ID,
                     PROBLEM_DEC,
                     MOD_TYPE,
                     INT_ID
                FROM (SELECT *
                        FROM SCMDATA.CMX_RETURN_MANAGEMENT_INT
                       WHERE PORT_STATUS = 'SP'
                         AND ROWNUM <= 300)) LOOP
      V_COMPID    := I.COMPANY_ID;
      V_EXG_ID    := I.EXG_ID;
      V_RELAGOOID := I.GOO_ID;

      ----供应商编号转为scm供应商档案编号
      SELECT MAX(SUPPLIER_CODE), MAX(COMPANY_PROVINCE), MAX(COMPANY_CITY)
        INTO V_SUPPID, V_PROVINID, V_CITYID
        FROM SCMDATA.T_SUPPLIER_INFO
       WHERE COMPANY_ID = I.COMPANY_ID
         AND INSIDE_SUPPLIER_CODE = I.SUP_ID;

      SELECT MAX(GOO_ID)
        INTO V_GOOID
        FROM SCMDATA.T_COMMODITY_INFO
       WHERE COMPANY_ID = I.COMPANY_ID
         AND RELA_GOO_ID = I.GOO_ID; ----商品档案的货号

      --供应商指定跟单
      ----货号对应供应商同分类的指定跟单
      V_MERCHER2 := F_GET_GENDAN(PI_GOO_ID     => V_GOOID,
                                 PI_COMPANY_ID => I.COMPANY_ID);

      ----商品的分类,类别
      SELECT MAX(CATEGORY), MAX(PRODUCT_CATE), MAX(SAMLL_CATEGORY)
        INTO V_CATEGORY, V_PRODUCTCATE,V_SUBCATE
        FROM SCMDATA.T_COMMODITY_INFO
       WHERE RELA_GOO_ID = I.GOO_ID
         AND COMPANY_ID = I.COMPANY_ID;

      V_AREAID := F_GET_GROUPNAME(F_COMPANY_PROVINCE => V_PROVINID,
                                  F_COMPANY_CITY     => V_CITYID,
                                  F_CATEGORY         => V_CATEGORY,
                                  F_PRODUCT_CATE     => V_PRODUCTCATE,
                                  F_COMPID           => I.COMPANY_ID,
                                  F_SUBCATE          => V_SUBCATE);

      SELECT MAX(GROUP_NAME), MAX(AREA_GROUP_LEADER)
        INTO V_GROUP_NAME, V_AREA_LEADER
        FROM SCMDATA.T_SUPPLIER_GROUP_CONFIG T
       WHERE T.GROUP_CONFIG_ID = V_AREAID
         AND T.PAUSE = 1;

      ---分部的跟单主管
      IF V_CATEGORY = '06' THEN
        V_CATEGORY := '07'; ---美妆和淘品同一跟单主管
      END IF;
      SELECT MAX(A.USER_ID)
        INTO V_DEAL_FOLLOWR_DIRCTOR
        FROM SCMDATA.SYS_COMPANY_USER A
       INNER JOIN SCMDATA.SYS_COMPANY_USER_DEPT B
          ON A.USER_ID = B.USER_ID
       INNER JOIN SCMDATA.SYS_COMPANY_JOB C
          ON A.JOB_ID = C.JOB_ID
         AND C.JOB_NAME = '跟单主管'
       INNER JOIN SCMDATA.SYS_COMPANY_DEPT_CATE_MAP D
          ON B.COMPANY_DEPT_ID = D.COMPANY_DEPT_ID
         AND A.COMPANY_ID = D.COMPANY_ID
         AND D.COOPERATION_CLASSIFICATION = V_CATEGORY
         AND A.COMPANY_ID = I.COMPANY_ID;

      ------ QC
      SELECT LISTAGG(DISTINCT Q.FINISH_QC_ID, ',') WITHIN GROUP(ORDER BY 1)
        INTO V_QC_ID
        FROM SCMDATA.T_QC_CHECK Q
       WHERE GOO_ID = V_GOOID
         AND Q.QC_CHECK_NODE = 'QC_FINAL_CHECK'
         AND COMPANY_ID = I.COMPANY_ID;
      IF V_QC_ID IS NOT NULL THEN
        -----QC主管
        V_QC_DIRECTOR_ID := SCMDATA.PKG_DB_JOB.F_GET_MANAGER(P_COMPANY_ID     => I.COMPANY_ID,
                                                             P_USER_ID        => V_QC_ID,
                                                             P_COMPANY_JOB_ID => '1001005003005001');
      ELSIF V_QC_ID IS NULL THEN
        V_QC_ID          := '';
        V_QC_DIRECTOR_ID := '';
      END IF;

      ----货号的QA
      SELECT LISTAGG(DISTINCT CHECKERS, ',') WITHIN GROUP(ORDER BY 1)
        INTO V_QA_ID
        FROM SCMDATA.T_QA_REPORT
       WHERE GOO_ID = V_GOOID
         AND COMPANY_ID = I.COMPANY_ID;
      IF V_QA_ID IS NULL THEN
        V_QA_ID := '';
      END IF;

      ----原因分类
      IF I.INT_ID IS NOT NULL THEN
        SELECT MAX(A.ABNORMAL_DTL_CONFIG_ID), MAX(A.FIRST_DEPT_ID),/*MAX(A.RM_SECOND_DUTY_DEPT_ID)*/ max(A.SECOND_DEPT_ID)
    INTO V_RM_CAUSE_DETAIL_ID, V_FIRST_DEPT_ID, V_SECOND_DEPT_ID
    FROM (SELECT Z.ABNORMAL_DTL_CONFIG_ID,
                 Z.ANOMALY_CLASSIFICATION,
                 Z.PROBLEM_CLASSIFICATION,
                 Z.CAUSE_CLASSIFICATION,
                 Z.CAUSE_DETAIL,
                 Z.IS_SUP_EXEMPTION,
                 Z.FIRST_DEPT_ID,
                 Z.CREATE_TIME,
                 --NVL(Z.RM_SECOND_DUTY_DEPT_ID,Z.SECOND_DEPT_ID) RM_SECOND_DUTY_DEPT_ID,
                 Z.SECOND_DEPT_ID,
                 B.INDUSTRY_CLASSIFICATION,
                 B.PRODUCTION_CATEGORY,
                 B.PRODUCT_SUBCLASS,
                 C.COMPANY_ID
            FROM SCMDATA.T_ABNORMAL_DTL_CONFIG Z
           INNER JOIN SCMDATA.T_ABNORMAL_RANGE_CONFIG B
              ON Z.ABNORMAL_CONFIG_ID = B.ABNORMAL_CONFIG_ID
             AND Z.COMPANY_ID = B.COMPANY_ID
           INNER JOIN SCMDATA.T_ABNORMAL_CONFIG C
              ON C.ABNORMAL_CONFIG_ID = Z.ABNORMAL_CONFIG_ID
             AND Z.COMPANY_ID = C.COMPANY_ID
           WHERE C.PAUSE = 0
             AND B.PAUSE = 0
             AND Z.PAUSE = 0
             AND Z.ANOMALY_CLASSIFICATION = 'AC_QUALITY') A
   WHERE A.COMPANY_ID = I.COMPANY_ID
     AND INSTR(';' || A.PRODUCT_SUBCLASS || ';', ';' || V_SUBCATE || ';') > 0
     AND A.PRODUCTION_CATEGORY = V_PRODUCTCATE
     AND A.INDUSTRY_CLASSIFICATION = V_CATEGORY
     AND A.PROBLEM_CLASSIFICATION = I.PROBLEM_CLASS_ID
     AND A.CAUSE_CLASSIFICATION = I.CAUSE_CLASS_ID
     AND A.CAUSE_DETAIL = I.CAUSE_DETAIL_ID;

        /*SELECT MAX(A.ABNORMAL_DTL_CONFIG_ID),
               MAX(A.FIRST_DEPT_ID),
               MAX(A.RM_SECOND_DUTY_DEPT_ID)
          INTO V_RM_CAUSE_DETAIL_ID, V_FIRST_DEPT_ID, V_SECOND_DEPT_ID
          FROM SCMDATA.T_ABNORMAL_DTL_CONFIG A
         WHERE A.PROBLEM_CLASSIFICATION = I.PROBLEM_CLASS_ID
           AND A.CAUSE_CLASSIFICATION = I.CAUSE_CLASS_ID
           AND A.CAUSE_DETAIL = I.CAUSE_DETAIL_ID
           AND A.ANOMALY_CLASSIFICATION = 'AC_QUALITY'
           AND A.PAUSE = 0
           AND A.COMPANY_ID = I.COMPANY_ID;*/
      ELSIF I.INT_ID IS NULL THEN

        SELECT MAX(A.ABNORMAL_DTL_CONFIG_ID), MAX(A.FIRST_DEPT_ID), /*MAX(A.RM_SECOND_DUTY_DEPT_ID)*/ max(A.SECOND_DEPT_ID)
    INTO V_RM_CAUSE_DETAIL_ID, V_FIRST_DEPT_ID, V_SECOND_DEPT_ID
    FROM (SELECT Z.ABNORMAL_DTL_CONFIG_ID,
                 Z.ANOMALY_CLASSIFICATION,
                 Z.PROBLEM_CLASSIFICATION,
                 Z.CAUSE_CLASSIFICATION,
                 Z.CAUSE_DETAIL,
                 Z.IS_SUP_EXEMPTION,
                 Z.FIRST_DEPT_ID,
                 Z.CREATE_TIME,
                 --NVL(Z.RM_SECOND_DUTY_DEPT_ID,Z.SECOND_DEPT_ID) RM_SECOND_DUTY_DEPT_ID,
                 Z.SECOND_DEPT_ID,
                 B.INDUSTRY_CLASSIFICATION,
                 B.PRODUCTION_CATEGORY,
                 B.PRODUCT_SUBCLASS,
                 C.COMPANY_ID
            FROM SCMDATA.T_ABNORMAL_DTL_CONFIG Z
           INNER JOIN SCMDATA.T_ABNORMAL_RANGE_CONFIG B
              ON Z.ABNORMAL_CONFIG_ID = B.ABNORMAL_CONFIG_ID
             AND Z.COMPANY_ID = B.COMPANY_ID
           INNER JOIN SCMDATA.T_ABNORMAL_CONFIG C
              ON C.ABNORMAL_CONFIG_ID = Z.ABNORMAL_CONFIG_ID
             AND Z.COMPANY_ID = C.COMPANY_ID
           WHERE C.PAUSE = 0
             AND B.PAUSE = 0
             AND Z.PAUSE = 0
             AND Z.ANOMALY_CLASSIFICATION = 'AC_QUALITY') A
   WHERE A.COMPANY_ID = I.COMPANY_ID
     AND INSTR(';' || A.PRODUCT_SUBCLASS || ';', ';' || V_SUBCATE || ';') > 0
     AND A.PRODUCTION_CATEGORY = V_PRODUCTCATE
     AND A.INDUSTRY_CLASSIFICATION = V_CATEGORY
     AND A.CAUSE_DETAIL = '其他零星问题';
        /*SELECT MAX(A.ABNORMAL_DTL_CONFIG_ID),
               MAX(A.FIRST_DEPT_ID),
               MAX(A.RM_SECOND_DUTY_DEPT_ID)
          INTO V_RM_CAUSE_DETAIL_ID, V_FIRST_DEPT_ID, V_SECOND_DEPT_ID
          FROM SCMDATA.T_ABNORMAL_DTL_CONFIG A
         WHERE A.ANOMALY_CLASSIFICATION = 'AC_QUALITY'
           AND A.PAUSE = 0
           AND A.CAUSE_DETAIL = '其他零星问题'
           AND A.COMPANY_ID = I.COMPANY_ID;*/
      END IF;
      IF I.INT_ID IS NOT NULL THEN
        I.RM_TYPE := '批量';
      ELSIF I.INT_ID IS NULL THEN
        I.RM_TYPE := '零星';
      END IF;
      SELECT COUNT(1)
        INTO V_JUDNUM
        FROM SCMDATA.T_RETURN_MANAGEMENT
       WHERE EXG_ID = V_EXG_ID
         AND RELA_GOO_ID = I.GOO_ID
         AND COMPANY_ID = I.COMPANY_ID
         AND ROWNUM = 1;
      --取创建时间的年季月 22.3.22
      IF V_JUDNUM = 0 THEN
        INSERT INTO SCMDATA.T_RETURN_MANAGEMENT
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
           PROBLEM_DEC,
           INT_ID,
           FIRST_DEPT_ID,
           SECOND_DEPT_ID,
           MERCHER_ID,
           MERCHER_DIRECTOR_ID,
           QC_ID,
           QC_DIRECTOR_ID,
           QA_ID,
           CAUSE_DETAIL_ID,
           SUP_GROUP_NAME,
           AREA_GROUP_LEADER)
        VALUES
          (SCMDATA.F_GET_UUID,
           TO_NUMBER(TO_CHAR(I.CREATE_TIME, 'yyyy')),
           TO_NUMBER(TO_CHAR(I.CREATE_TIME, 'q')),
           TO_NUMBER(TO_CHAR(I.CREATE_TIME, 'mm')),
           V_EXG_ID,
           I.COMPANY_ID,
           I.SHO_ID,
           V_SUPPID,
           'EXGTABLE', /*数据来源*/
           I.CREATE_TIME,
           I.FINISH_TIME,
           I.EXTRACT_TIME,
           I.SENDGOODS_TIME,
           I.SENDGOODSWAY,
           I.MEMO,
           I.ISMATERIAL,
           V_GOOID,
           I.GOO_ID,
           I.EXAMOUNT,
           I.GOTAMOUNT,
           I.RM_TYPE,
           I.PROBLEM_DEC,
           I.INT_ID,
           V_FIRST_DEPT_ID,
           V_SECOND_DEPT_ID,
           V_MERCHER2,
           V_DEAL_FOLLOWR_DIRCTOR,
           V_QC_ID,
           V_QC_DIRECTOR_ID,
           V_QA_ID,
           V_RM_CAUSE_DETAIL_ID,
           V_GROUP_NAME,
           V_AREA_LEADER);
      ELSIF V_JUDNUM <> 0 THEN
         UPDATE SCMDATA.T_RETURN_MANAGEMENT T
           SET T.FINISH_TIME         = I.FINISH_TIME,
               T.SHO_ID         =I.SHO_ID,
               T.SUPPLIER_CODE  = V_SUPPID,
               T.EXTRACT_TIME = I.EXTRACT_TIME,
               T.SENDGOODS_TIME =I.SENDGOODS_TIME,
               T.SENDGOODSWAY  = I.SENDGOODSWAY,
               T.MEMO   = I.MEMO,
               T.ISMATERIAL = I.ISMATERIAL,
               T.GOO_ID =V_GOOID,
               T.RELA_GOO_ID = I.GOO_ID,
               T.EXAMOUNT = I.EXAMOUNT,
               T.GOTAMOUNT=I.GOTAMOUNT,
               T.RM_TYPE =I.RM_TYPE,
               T.FIRST_DEPT_ID =V_FIRST_DEPT_ID,
               T.SECOND_DEPT_ID = V_SECOND_DEPT_ID,
               T.MERCHER_ID  = V_MERCHER2,
               T.MERCHER_DIRECTOR_ID = V_DEAL_FOLLOWR_DIRCTOR,
               T.QC_ID =V_QC_ID,
               T.QC_DIRECTOR_ID =V_QC_DIRECTOR_ID,
               T.QA_ID =V_QA_ID,
               T.CAUSE_DETAIL_ID =V_RM_CAUSE_DETAIL_ID,
               T.SUP_GROUP_NAME =V_GROUP_NAME,
               T.AREA_GROUP_LEADER =V_AREA_LEADER
         WHERE T.EXG_ID = I.EXG_ID
           AND T.RELA_GOO_ID = I.GOO_ID;
      END IF;

      UPDATE SCMDATA.CMX_RETURN_MANAGEMENT_INT T
         SET PORT_STATUS = 'SS', PORT_TIME = SYSDATE
       WHERE T.EXG_ID = I.EXG_ID
         AND GOO_ID = I.GOO_ID;
    END LOOP;
  EXCEPTION
    WHEN OTHERS THEN
      UPDATE SCMDATA.CMX_RETURN_MANAGEMENT_INT
         SET PORT_STATUS = 'SE', PORT_TIME = SYSDATE
       WHERE EXG_ID = V_EXG_ID
         AND GOO_ID = V_RELAGOOID;
      V_UNQVALS := '门店退货消息通知' || CHR(13) || '换货单号：' || V_EXG_ID || CHR(13) ||
                   '货号：' || V_RELAGOOID || CHR(13) || '同步错误时间：' ||
                   TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24-MI-SS');

      ----企微机器人通知错误信息
      SCMDATA.PKG_SEND_WX_MSG.P_SEND_WX_MSG(P_COMPANY_ID => V_COMPID,
                                            P_ROBOT_TYPE => 'RETURN_MANA_MSG',
                                            P_MSGTYPE    => 'text',
                                            P_VAL_STEP   => ';',
                                            P_MSG_TITLE  => V_UNQVALS,
                                            P_SENDER     => 'DYY153');
  END P_RETURN_MANAGE_SYNC;

  ----定时自动审核
  PROCEDURE P_RM_CHECK_AUTO IS
    V_DATE_M1  NUMBER(10); --上月月份
    V_ERRINFO1 NUMBER(2);
    --V_ERRINFO2 NUMBER(2);
    V_ERRINFO3 NUMBER(2);
    JUDGE3     VARCHAR(128);
    JUDGE4     VARCHAR(128);
  BEGIN
    SELECT TO_CHAR(ADD_MONTHS(SYSDATE, -1), 'yyyymm')
      INTO V_DATE_M1
      FROM DUAL; --上月月份

    FOR V IN (SELECT T.RM_ID, T.EXG_ID, T.RELA_GOO_ID, T.COMPANY_ID
                FROM SCMDATA.T_RETURN_MANAGEMENT T
               WHERE TO_NUMBER(TO_CHAR(T.FINISH_TIME, 'yyyymm')) = V_DATE_M1
                 AND T.AUDIT_TIME IS NULL) LOOP
      V_ERRINFO1 := NULL;
      --V_ERRINFO2 := NULL;
      V_ERRINFO3 := NULL;
      JUDGE3     := NULL;
      JUDGE4     := NULL;
      SELECT COUNT(1)
        INTO V_ERRINFO1
        FROM SCMDATA.T_RETURN_MANAGEMENT A
       WHERE A.EXG_ID = V.EXG_ID
         AND A.RELA_GOO_ID = V.RELA_GOO_ID
         AND A.COMPANY_ID = V.COMPANY_ID
         AND RM_ID = V.RM_ID
         AND A.CAUSE_DETAIL_ID IS NOT NULL
         AND A.FIRST_DEPT_ID IS NOT NULL
         AND A.SECOND_DEPT_ID IS NOT NULL
         --AND A.FINISH_TIME IS NOT NULL
         AND A.MERCHER_ID IS NOT NULL
         AND A.RM_TYPE IS NOT NULL
         AND A.EXAMOUNT IS NOT NULL
         AND A.SUP_GROUP_NAME IS NOT NULL
         AND A.AREA_GROUP_LEADER IS NOT NULL
         AND ROWNUM = 1;

     /* SELECT COUNT(1)
        INTO V_ERRINFO2
        FROM SCMDATA.T_RETURN_MANAGEMENT
       WHERE EXG_ID = V.EXG_ID
         AND RELA_GOO_ID = V.RELA_GOO_ID
         AND COMPANY_ID = V.COMPANY_ID
         AND RM_ID = V.RM_ID
         AND FINISH_TIME IS NOT NULL
         AND ROWNUM = 1;*/                --去掉完成时间的校验22.3.22

      SELECT MAX(A.RM_TYPE), MAX(B.CAUSE_DETAIL)
        INTO JUDGE3, JUDGE4
        FROM SCMDATA.T_RETURN_MANAGEMENT A
       INNER JOIN SCMDATA.T_ABNORMAL_DTL_CONFIG B
          ON A.CAUSE_DETAIL_ID = B.ABNORMAL_DTL_CONFIG_ID
         AND A.COMPANY_ID = B.COMPANY_ID
       WHERE A.EXG_ID = V.EXG_ID
         AND A.RM_ID = V.RM_ID
         AND A.RELA_GOO_ID = V.RELA_GOO_ID
         AND A.COMPANY_ID = V.COMPANY_ID;
      IF JUDGE3 = '批量' AND JUDGE4 = '其他零星问题' THEN
        V_ERRINFO3 := 0;
      ELSE
        V_ERRINFO3 := 1;
      END IF;

      IF V_ERRINFO1 <> 0 AND /*V_ERRINFO2 <> 0 AND*/ V_ERRINFO3 <> 0 THEN
        UPDATE SCMDATA.T_RETURN_MANAGEMENT A
           SET A.AUDIT_TIME = SYSDATE, A.AUDIT_ID = 'system audited'
         WHERE A.RM_ID = V.RM_ID
           AND TO_NUMBER(TO_CHAR(A.FINISH_TIME, 'yyyymm')) = V_DATE_M1
           AND A.AUDIT_TIME IS NULL;
      END IF;

    END LOOP;

  END P_RM_CHECK_AUTO;

  --再次校验已校验失败的货号，更新状态
  PROCEDURE P_UPDATE_PORTSTATUS(/*PI_TAB IN VARCHAR2,*/ PI_COMID IN VARCHAR2) IS
    V_JUD_GOO NUMBER;
    V_JUD_SUP NUMBER;
    /*V_ERRINFO CLOB;*/
  BEGIN
    FOR I IN (SELECT T.EXG_ID, T.SUP_ID, T.GOO_ID
                FROM SCMDATA.CMX_RETURN_MANAGEMENT_INT T
               WHERE (T.PORT_STATUS <> 'SP' or T.PORT_STATUS <> 'SS')
                 AND ROWNUM <= 300) LOOP
      V_JUD_GOO := SCMDATA.PKG_INTERFACE_LOG.F_CHECK_RELAGOOD_COMMODITY_EXIST(V_INRELAGOOID => I.GOO_ID,
                                                                              V_INCOMPID    => PI_COMID);
      V_JUD_SUP := SCMDATA.PKG_INTERFACE_LOG.F_CHECK_ISDSUPCODE_EXIST(V_INISDSUPCODE => I.SUP_ID,
                                                                      V_INCOMPID     => PI_COMID);
      IF V_JUD_GOO = 1 AND V_JUD_SUP = 1 THEN
        UPDATE SCMDATA.CMX_RETURN_MANAGEMENT_INT T
           SET T.PORT_STATUS = 'SP',
               T.PORT_TIME   = SYSDATE,
               T.MOD_TYPE    = 'U'
         WHERE T.EXG_ID = I.EXG_ID
           AND T.SUP_ID = I.SUP_ID
           AND T.GOO_ID = I.GOO_ID;


      END IF;
    END LOOP;
  END P_UPDATE_PORTSTATUS;

  PROCEDURE P_UPDATE_GROUPNAME IS
    V_PROVINID    VARCHAR2(148); --公司省份
    V_CITYID      VARCHAR2(148); --公司市
    V_CATEGORY    VARCHAR2(32); --分类
    V_PRODUCTCATE VARCHAR2(32); --生产类别
    V_SUBCATE     VARCHAR2(32);
    V_AREAID      VARCHAR2(32); --分组id
    V_GROUP_NAME  VARCHAR2(128); --分组名称
    V_AREA_LEADER VARCHAR2(128); --分组组长
  BEGIN
    FOR I IN (SELECT T.SUPPLIER_CODE, T.GOO_ID, T.COMPANY_ID, T.RM_ID
                FROM SCMDATA.T_RETURN_MANAGEMENT T
               WHERE T.SUP_GROUP_NAME IS NULL
                 AND T.AREA_GROUP_LEADER IS NULL
                 AND ROWNUM <= 300) LOOP

      --获取货号对应的分类
      SELECT MAX(B.CATEGORY), MAX(B.PRODUCT_CATE),MAX(B.SAMLL_CATEGORY)
        INTO V_CATEGORY, V_PRODUCTCATE,V_SUBCATE
        FROM SCMDATA.T_COMMODITY_INFO B
       WHERE B.GOO_ID = I.GOO_ID
         AND B.COMPANY_ID = I.COMPANY_ID;

      --获取供应商的省市
      SELECT MAX(A.COMPANY_PROVINCE), MAX(A.COMPANY_CITY)
        INTO V_PROVINID, V_CITYID
        FROM SCMDATA.T_SUPPLIER_INFO A
       WHERE A.SUPPLIER_CODE = I.SUPPLIER_CODE
         AND A.COMPANY_ID = I.COMPANY_ID;
      --获取area_id
      V_AREAID := F_GET_GROUPNAME(F_COMPANY_PROVINCE => V_PROVINID,
                                  F_COMPANY_CITY     => V_CITYID,
                                  F_CATEGORY         => V_CATEGORY,
                                  F_PRODUCT_CATE     => V_PRODUCTCATE,
                                  F_COMPID           => I.COMPANY_ID,
                                  F_SUBCATE          => V_SUBCATE );

      SELECT MAX(GROUP_NAME), MAX(AREA_GROUP_LEADER)
        INTO V_GROUP_NAME, V_AREA_LEADER
        FROM SCMDATA.T_SUPPLIER_GROUP_CONFIG T
       WHERE T.GROUP_CONFIG_ID = V_AREAID
         AND T.PAUSE = 1;

      IF V_GROUP_NAME IS NOT NULL AND V_AREA_LEADER IS NOT NULL THEN
        UPDATE SCMDATA.T_RETURN_MANAGEMENT C
           SET C.SUP_GROUP_NAME    = V_GROUP_NAME,
               C.AREA_GROUP_LEADER = V_AREA_LEADER
         WHERE C.RM_ID = I.RM_ID;
      END IF;
      COMMIT;
    END LOOP;
  END P_UPDATE_GROUPNAME;

FUNCTION F_GET_GROUPNAME(F_COMPANY_PROVINCE IN VARCHAR2,
                         F_COMPANY_CITY     IN VARCHAR2,
                         F_CATEGORY         IN VARCHAR2,
                         F_PRODUCT_CATE     IN VARCHAR2,
                         F_SUBCATE          IN VARCHAR2,
                         F_COMPID           IN VARCHAR2) RETURN VARCHAR2 IS
  T_P      CLOB;
  GROUP_ID VARCHAR2(2000);
  V_C      VARCHAR2(18) := NULL;
BEGIN
  IF F_COMPANY_PROVINCE IS NOT NULL AND F_COMPANY_CITY IS NOT NULL THEN

    SELECT LISTAGG(T.GROUP_AREA_CONFIG_ID, ';') WITHIN GROUP(ORDER BY T.PAUSE)
      INTO T_P
      FROM SCMDATA.T_SUPPLIER_GROUP_AREA_CONFIG T
     WHERE T.PAUSE = 1
       AND SCMDATA.INSTR_PRIV(T.PROVINCE_ID, F_COMPANY_PROVINCE) > 0
       AND SCMDATA.INSTR_PRIV(T.CITY_ID, F_COMPANY_CITY) > 0
       AND T.COMPANY_ID = F_COMPID;
    SELECT T.GROUP_CONFIG_ID
      INTO GROUP_ID
      FROM SCMDATA.T_SUPPLIER_GROUP_CATEGORY_CONFIG T
     INNER JOIN SCMDATA.T_SUPPLIER_GROUP_SUBCATE_CONFIG C
        ON T.GROUP_CATEGORY_CONFIG_ID=C.GROUP_CATEGORY_CONFIG_ID AND T.COMPANY_ID=C.COMPANY_ID
     WHERE T.PAUSE = 1
       AND C.PAUSE=1
       AND SCMDATA.INSTR_PRIV(T.AREA_CONFIG_ID, T_P) > 0
       AND T.COOPERATION_CLASSIFICATION = F_CATEGORY
       AND SCMDATA.INSTR_PRIV(T.COOPERATION_PRODUCT_CATE, F_PRODUCT_CATE) > 0
       AND SCMDATA.INSTR_PRIV(C.SUBCATEGORY,F_SUBCATE)>0
       AND T.COMPANY_ID = F_COMPID;
    RETURN GROUP_ID;
  ELSE
    RETURN NULL;
  END IF;
EXCEPTION
  WHEN NO_DATA_FOUND THEN
    RETURN V_C;
END F_GET_GROUPNAME;

END PKG_RETURN_TEST;
/

