CREATE OR REPLACE PACKAGE SCMDATA.PKG_RETURN_TSET IS

  /*============================================*
  * Author   : DYY153
  * Created  : 2021-10-27 15:35:23
  * ALERTER  :
  * ALERTER_TIME  :2022-04-06
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

  FUNCTION F_GET_GENDAN(PI_GOO_ID IN VARCHAR2, PI_COMPANY_ID IN VARCHAR2)
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

  FUNCTION F_GET_QCGROUP(V_PROVICEID IN VARCHAR2,
                         V_CITYID    IN VARCHAR2,
                         V_CATE    IN VARCHAR2,
                         V_PROCATE IN VARCHAR2,
                         V_SUBCATE IN VARCHAR2,
                         V_COMID   IN VARCHAR2) RETURN VARCHAR2;

  PROCEDURE P_INS_RETURNMANA(V_REC SCMDATA.T_RETURN_MANAGEMENT%ROWTYPE);


  FUNCTION F_UPD_RETURNMANA(V_USERID IN VARCHAR2,
                       V_COMPID IN VARCHAR2) RETURN CLOB;

END PKG_RETURN_TEST;
/

