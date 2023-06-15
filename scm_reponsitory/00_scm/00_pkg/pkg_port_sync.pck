CREATE OR REPLACE PACKAGE SCMDATA.pkg_port_sync IS

  /*=================================================================================
  
    获取批次接口必要信息
  
    说明：
       在插入到批次接口-数据中间表时必须
  
    入参：
       CONFIG_ID : 配置ID SCMDATA.T_PBT_CONFIG.CONFIG_ID
       USER_ID   : 当前执行人USER_ID
  
    返回值：
       ''CFG12312312412'' CONFIG_ID,
       ''edasd1231r125asd'' USER_ID,
       ''2021-08-01 12-10-10'' OPER_TIME
  
    版本：
       2021-01-01: 完成获取必要信息
  
  =================================================================================*/
  FUNCTION f_get_nes_infomation(config_id IN VARCHAR2,
                                user_id   IN VARCHAR2) RETURN VARCHAR2;

  /*=================================================================================
  
    更新订单scm创建时间
  
    入参:
      V_ORDID   :  订单Id
      V_COMPID  :  企业Id
  
    版本：
       2022-09-27: 更新订单scm创建时间
  
  =================================================================================*/
  PROCEDURE p_upd_ordercretimescm(v_ordid  IN VARCHAR2,
                                  v_compid IN VARCHAR2);

  /*=================================================================================
  
    构建批次接口action_sql
  
    说明：
      用于将批次接口-配置的select_sql整合为批次接口的action_sql
  
    入参：
      SELECT_SQL : 用于传输到被调用方动态执行，SCMDATA.T_PBT_CONFIG.SELECT_SQL
      CONFIG_ID  : 略，SCMDATA.T_PBT_CONFG.CONFIG_ID
      USER_ID   : 当前执行人USER_ID
  
    返回值：
      'SELECT '''' 变量名...,
              ''XXXXXXXXXX'' EXECUTE_SQL,
              ''easfasfa2asd31asd42312'' CONFIG_ID,
              ''MS_ORDERED'' ORIGIN,
              ''easfsczxb1221asdas1121'' OPER_USERID,
              ''2021-07-08 12-42-23'' OPER_TIME
         FROM DUAL
  
     版本：
       2021-01-01: 完成构建批次接口action_sql，只要速狮接口底层不做大改，
                   即可继续沿用
  
  =================================================================================*/
  FUNCTION f_build_batch_acsql(select_sql IN VARCHAR2,
                               config_id  IN VARCHAR2,
                               user_id    IN VARCHAR2) RETURN CLOB;

  /*=================================================================================
  
    订单接口数据检查
  
    说明：
      用于订单接口数据进入接口表前检查
  
    入参：
      v_relagooid      :  货号
      v_insidesupcode  :  内部供应商编号
      v_compid         :  企业Id
    
    入出参:
      v_errcode        :  错误编码
      v_errmsg         :  错误信息
  
     版本：
       2022-06-30 : 订单接口重构
       2023-03-15 : 订单生产工厂接口需求变更，
                    当订单供应商生产工厂存在本厂时赋值为订单供应商，否则赋值为空
  
  =================================================================================*/
  PROCEDURE p_orditf_check(v_relagooid     IN VARCHAR2,
                           v_insidesupcode IN VARCHAR2,
                           v_compid        IN VARCHAR2,
                           v_errcode       IN OUT VARCHAR2,
                           v_errmsg        IN OUT VARCHAR2);

  /*=================================================================================
  
    获取跟单员
  
    说明：
      获取跟单员
  
    入参:
      V_OPERATORID  :  订单操作员
      V_SUPIDBASE   :  供应商编码
      V_GOOID       :  货号
      V_COMPID      :  企业Id
  
    版本：
      2022-06-30 : 订单接口重构
  
  =================================================================================*/
  FUNCTION f_get_dealfollower(v_operatorid IN VARCHAR2,
                              v_supidbase  IN VARCHAR2,
                              v_gooid      IN VARCHAR2,
                              v_compid     IN VARCHAR2) RETURN VARCHAR2;

  /*=================================================================================
  
    ORDERED 接口数据插入 SCMDATA.T_ORDERED_ITF 表
  
    说明：
      用于获取主数据 NSFDATA.ORDERED 数据，并将数据直接插入
      SCMDATA.T_ORDERED_ITF 表，校验不通过记录错误信息不同步
  
    入参：
      V_INORDID          :  订单号
      V_INPOTYPE         :  订单类型
      V_INGOOID          :  货号，货号不存在于系统则单据不进入系统
      V_INDELIVERDATE    :  订单交期
      V_INSUPIDBASE      :  供应商编号，供应商编号不存在于系统则单据不进入系统
      V_INOPERATORID     :  操作人Id
      V_INCREATETIME     :  创建时间
      V_INFINISHTIME     :  结束时间
      V_INMEMO           :  备注
      V_INISFIRSTORDERED :  是否首单
      V_INSHOID          :  仓库Id
      V_INSENDBYSUP      :  供应商代发
      V_INRATIONAME      :  配码比名称
      V_INCOMPID         :  数据归属企业Id
  
     版本：
       2022-06-30 : 订单接口重构
  
  =================================================================================*/
  PROCEDURE p_ordered_itf_insert(v_inordid          IN VARCHAR2,
                                 v_inpotype         IN VARCHAR2,
                                 v_ingooid          IN VARCHAR2,
                                 v_indeliverdate    IN VARCHAR2,
                                 v_insupidbase      IN VARCHAR2,
                                 v_inoperatorid     IN VARCHAR2,
                                 v_increatetime     IN VARCHAR2,
                                 v_infinishtime     IN VARCHAR2,
                                 v_inmemo           IN VARCHAR2,
                                 v_inisfirstordered IN NUMBER,
                                 v_inisprodctorder  IN NUMBER,
                                 v_inshoid          IN VARCHAR2,
                                 v_insendbysup      IN NUMBER,
                                 v_inmerchandiserid IN VARCHAR2,
                                 v_inrationame      IN VARCHAR2,
                                 v_incompid         IN VARCHAR2);

  /*=================================================================================
  
    ORDERS 接口数据插入 SCMDATA.T_ORDERS_ITF 表
  
    说明：
      用于获取主数据 NSFDATA.ORDERS 数据，并将数据直接插入
      SCMDATA.T_ORDERS_ITF 表，校验不通过则记录错误信息
  
    入参：
      V_INORDID          :  订单号
      V_INGOOID          :  货号，货号不存在于系统则单据不进入系统
      V_INORDERAMOUNT    :  订货量
      V_INGOTAMOUNT      :  到货量
      V_INDELIVERDATE    :  订单交期
      V_ININPRICE        :  订单单价
      V_INPDSUPID        :  供应商编号，供应商编号不存在于系统则单据不进入系统
      V_INMEMO           :  备注
      V_INCOMPID         :  数据归属企业Id
  
     版本：
       2022-06-30 : 订单接口重构
  
  =================================================================================*/
  PROCEDURE p_orders_itf_insert(v_inordid        IN VARCHAR2,
                                v_ingooid        IN VARCHAR2,
                                v_inorderamount  IN NUMBER,
                                v_ingotamount    IN NUMBER,
                                v_indeliverdate  IN VARCHAR2,
                                v_ininprice      IN NUMBER,
                                v_inisqcrequired IN NUMBER,
                                v_inpdsupid      IN VARCHAR2,
                                v_inmemo         IN VARCHAR2,
                                v_incompid       IN VARCHAR2);

  /*=================================================================================
  
    ORDERSITEM 接口数据插入 SCMDATA.T_ORDERSITEM 表
  
    说明：
      用于获取主数据 NSFDATA.ORDERSITEM 数据，并将数据直接插入
      SCMDATA.T_ORDERSITEM 表，校验不通过则插入日志表：SCMDATA.T_ORDER_INTERFACE_ERR
  
    入参：
      V_INORDID          :  订单号
      V_INGOOID          :  货号，货号不存在于系统则单据不进入系统
      V_INPDSUPID        :  供应商编号，供应商编号不存在于系统则单据不进入系统
      V_INBARCODE        :  条码
      V_INORDERAMOUNT    :  订货量
      V_INGOTAMOUNT      :  到货量
      V_INMEMO           :  备注
      V_INCOMPID         :  数据归属企业Id
  
     版本：
       2021-10-15之前: 完成订货量，到货量，备注接入
  
  =================================================================================*/
  PROCEDURE p_ordersitem_itf_insert(v_inordid       IN VARCHAR2,
                                    v_ingooid       IN VARCHAR2,
                                    v_insupidbase   IN VARCHAR2,
                                    v_inbarcode     IN VARCHAR2,
                                    v_inorderamount IN NUMBER,
                                    v_ingotamount   IN NUMBER,
                                    v_inmemo        IN VARCHAR2,
                                    v_incompid      IN VARCHAR2);

  /*=================================================================================
  
    获取供应商编码
  
    说明：
      用于获取供应商编码
  
    入参：
      V_ISDSUPCODE   :  内部供应商编码
      V_COMPID       :  企业Id
  
    版本：
      2022-06-30 : ORDERED 订单接口重构
  
  =================================================================================*/
  FUNCTION f_get_supcode(v_isdsupcode IN VARCHAR2,
                         v_compid     IN VARCHAR2) RETURN VARCHAR2;

  /*=================================================================================
  
    获取商品档案编号
  
    说明：
      用于获取商品档案编号
  
    入参：
      V_RELAGOOID   :  货号
      V_COMPID      :  企业Id
  
    版本：
      2022-06-30 : ORDERED 订单接口重构
  
  =================================================================================*/
  FUNCTION f_get_gooid(v_relagooid IN VARCHAR2,
                       v_compid    IN VARCHAR2) RETURN VARCHAR2;

  /*=================================================================================
  
    ORDERED 订单接口数据同步
  
    说明：
      ORDERED 订单接口数据同步
  
    版本：
      2022-06-30 : ORDERED 订单接口重构
  
  =================================================================================*/
  PROCEDURE p_ordered_itf_sync;

  /*=================================================================================
  
    ORDERS 订单接口数据同步
  
    说明：
      ORDERS 订单接口数据同步
  
    版本：
      2022-06-30 : ORDERED 订单接口重构
      2023-03-15 : 订单生产工厂接口需求变更，
                   当订单供应商生产工厂存在本厂时赋值为订单供应商，否则赋值为空
  
  =================================================================================*/
  PROCEDURE p_orders_itf_sync;

  /*=================================================================================
  
    ORDERSITEM 订单接口数据同步
  
    说明：
      ORDERSITEM 订单接口数据同步
  
    版本：
      2022-06-30 : ORDERED 订单接口重构
  
  =================================================================================*/
  PROCEDURE p_ordersitem_itf_sync;

  /*=================================================================================
  
    订单接入未接入货号重传逻辑
  
    说明：
      订单接入未接入货号重传逻辑
  
    入参：
      V_GOOID  :  货号
  
    版本：
      2022-06-30 : ORDERED 订单接口重构
  
  =================================================================================*/
  PROCEDURE p_gen_retrans_gooinfo(v_gooid IN VARCHAR2);

  /*=================================================================================
  
    获取 V_MINDEC 分钟内缺失的供应商编号
  
    说明：
      用于获取 V_MINDEC 分钟内缺失的供应商编号
  
    入参：
      V_MINDEC  :  分钟数
  
    版本：
      2022-06-30 : ORDERED 订单接口重构
  
  =================================================================================*/
  FUNCTION f_get_missed_supcodes(v_mindec IN NUMBER) RETURN CLOB;

  /*=================================================================================
  
    获取 V_MINDEC 分钟内缺失的供应商编号并置入消息池提醒对应的人
  
    说明：
      用于 获取 V_MINDEC 分钟内缺失的供应商编号并置入消息池提醒对应的人
  
    入参：
      V_MINDEC  :  分钟数
  
    版本：
      2022-06-30 : ORDERED 订单接口重构
  
  =================================================================================*/
  PROCEDURE p_gen_supmissmsg_into_msgpool(v_mindec IN NUMBER);

  /*=================================================================================
  
    按模式获取更新后数据的：
      接口状态，错误码，错误信息（PORT_STATUS; ERR_CODE; ERR_MSG）
  
    说明：
      用于按模式获取更新后数据的:
        接口状态，错误码，错误信息（PORT_STATUS; ERR_CODE; ERR_MSG）
  
    入参：
      V_ORDID     :  订单Id
      V_COMPID    :  企业Id
      V_MODE      :  模式
      V_PTSTATUS  :  接口状态
      V_ERRCODE   :  错误码
      V_ERRMSG    :  错误信息
  
    版本：
      2022-06-30 : ORDERED 订单接口重构
  
  =================================================================================*/
  PROCEDURE p_get_right_psecem(v_ordid    IN VARCHAR2,
                               v_compid   IN VARCHAR2,
                               v_mode     IN VARCHAR2,
                               v_ptstatus IN OUT VARCHAR2,
                               v_errcode  IN OUT VARCHAR2,
                               v_errmsg   IN OUT VARCHAR2);

  /*=================================================================================
  
    刷新供应商缺失订单数据（一天一次）
  
    说明：
      用于刷新供应商缺失订单数据（一天一次）
  
    版本：
      2022-06-30 : ORDERED 订单接口重构
  
  =================================================================================*/
  PROCEDURE p_upd_orditf_psecem(v_ordid    IN VARCHAR2,
                                v_compid   IN VARCHAR2,
                                v_ptstatus IN VARCHAR2,
                                v_errcode  IN VARCHAR2,
                                v_errmsg   IN CLOB);

  /*=================================================================================
  
    刷新供应商缺失订单数据（一天一次）
  
    说明：
      用于刷新供应商缺失订单数据（一天一次）
  
    版本：
      2022-06-30 : ORDERED 订单接口重构
      2022-09-05 : 重构，由供应商更新带动错误数据同步变更为
                   错误数据反查供应商档案，从而完成更新
  
  =================================================================================*/
  PROCEDURE p_refresh_supmiss_itfdata;

  /*=================================================================================
  
    刷新商品档案缺失订单数据（一天一次）
  
    说明：
      用于商品档案缺失订单数据（一天一次）
  
    版本：
      2022-06-30 : ORDERED 订单接口重构
      2022-09-05 : 重构，由商品档案更新带动错误数据同步变更为
                   错误数据反查商品档案，从而完成更新
  
  =================================================================================*/
  PROCEDURE p_refresh_goomiss_itfdata;

  /*=================================================================================
  
    ORDERCHANGE 接口数据插入 SCMDATA.T_ORDERCHANGE 表
  
    说明：
      用于获取主数据 NSFDATA.ORDERCHANGE 数据，并将数据直接插入
      SCMDATA.T_ORDERCHANGE 表，校验不通过则插入日志表：SCMDATA.T_ORDER_INTERFACE_ERR
  
    入参：
      V_INPCNO           :  变更单号
      V_INCHANGETYPE     :  变更类型代号
      V_INORDID          :  订单号
      V_INOLDNEEDDATE    :  旧交货日期
      V_INNEWNEEDDATE    :  新交货日期
      V_INOLDINPRICE     :  旧单价
      V_INNEWINPRICE     :  新单价
      V_INOLDSUPPLIER    :  旧供应商，供应商编码不存在于系统则单据不进入系统
      V_INNEWSUPPLIER    :  新供应商，供应商编码不存在于系统则单据不进入系统
      V_INOLDLOC         :  旧收货仓库
      V_INNEWLOC         :  新收货仓库
      V_INOLDSENDBYSUP   :  旧供应商代发
      V_INNEWSENDBYSUP   :  新供应商代发
      V_INREASON         :  变更原因
      V_INMEMO           :  备注
      V_INBARCODE        :  条码
      V_INAPPROVEDBY     :  批准人
      V_INAPPROVEDATE    :  批准日期
      V_INBRAID          :  分部
      V_INGOOID          :  货号，货号不存在于系统则单据不进入系统
      V_INCOMPID         :  数据归属企业Id
  
     版本：
       2021-10-15之前: 仓库变更接入
       2021-10-18: 当交期变更的变更原因，备注接入后，修改生产跟进表：
                   延期问题分类、延期问题原因、延期问题细分、问题描述字段
  
  =================================================================================*/
  PROCEDURE p_orderchange_insert_execute(v_inpcno         IN NUMBER,
                                         v_inchangetype   IN VARCHAR2,
                                         v_inordid        IN VARCHAR2,
                                         v_inoldneeddate  IN VARCHAR2,
                                         v_innewneeddate  IN VARCHAR2,
                                         v_inoldinprice   IN NUMBER,
                                         v_innewinprice   IN NUMBER,
                                         v_inoldsupplier  IN VARCHAR2,
                                         v_innewsupplier  IN VARCHAR2,
                                         v_inoldloc       IN VARCHAR2,
                                         v_innewloc       IN VARCHAR2,
                                         v_inoldsendbysup IN NUMBER,
                                         v_innewsendbysup IN NUMBER,
                                         v_inapprovedby   IN VARCHAR2,
                                         v_inapprovedate  IN VARCHAR2,
                                         v_inmemo         IN VARCHAR2,
                                         v_inreason       IN VARCHAR2,
                                         v_inbraid        IN VARCHAR2,
                                         v_ingooid        IN VARCHAR2,
                                         v_incompid       IN VARCHAR2);

  /*=================================================================================
  
    变更原因插入到 PRODUCTION_PROGRESS 表
  
    说明：
      用于获取主数据 NSFDATA.ORDERCHANGE 数据，并将数据直接插入
      SCMDATA.T_ORDERCHANGE 表，校验不通过则插入日志表：SCMDATA.T_ORDER_INTERFACE_ERR
  
    入参：
      V_ORDERID  :  订单号
      V_COMPID   :  企业Id
      V_GOOID    :  货号
      V_CGREASON :  修改原因
      V_PRODESC  :  问题描述
  
     版本：
       2021-10-15之前: 仓库变更接入
       2021-10-18: 当交期变更的变更原因，备注接入后，修改生产跟进表：
                   延期问题分类、延期问题原因、延期问题细分、问题描述字段，
                   供应商是否免责、责任部门1级、责任部门2级、是否质量问题
                   字段更新
  
  =================================================================================*/
  PROCEDURE p_change_reason_insert(v_orderid  IN VARCHAR2,
                                   v_compid   IN VARCHAR2,
                                   v_gooid    IN VARCHAR2,
                                   v_cgreason IN VARCHAR2,
                                   v_prodesc  IN VARCHAR2);

  /*=================================================================================
  
    订单结束时间进入接口表
  
    说明：
      用于获取主数据 NSFDATA.ORDERED 数据的结束时间数据，并将数据直接插入
      SCM_INTERFACE.T_ORD_FINISHTIME_ITF 表，如果存在则更新 FINISH_TIME 字段，
      如果不存在则新增记录
  
    入参：
      V_ORDID   :  订单
      V_COMPID  :  企业Id
      V_FTIME   :  结束时间，格式 YYYY-MM-DD HH24-MI-SS
  
     版本：
       2022-06-08: 订单结束时间进入接口表
  
  =================================================================================*/
  PROCEDURE p_iu_ord_finishtime_itf(v_ordid  IN VARCHAR2,
                                    v_compid IN VARCHAR2,
                                    v_ftime  IN VARCHAR2);

  /*=================================================================================
  
    订单结束时间同步
  
    说明：
      用于将 SCM_INTERFACE.T_ORD_FINISHTIME_ITF 结束时间同步到 SCMDATA.T_ORDERED
  
     版本：
       2022-06-08: 订单结束时间同步
  
  =================================================================================*/
  PROCEDURE p_ord_finishtime_sync;

  /*=================================================================================
  
    通过订单追加Qa报告关联维度表仓库字段
  
    入参：
      v_inp_ordid   :  订单号
      v_inp_compid  :  企业Id
  
     版本：
       2023-02-22_zc314 : 通过订单追加Qa报告关联维度表仓库字段
  
  =================================================================================*/
  PROCEDURE p_append_qareprela_shoid_by_ordid(v_inp_ordid  IN VARCHAR2,
                                              v_inp_compid IN VARCHAR2);

  /*=================================================================================
  
    ORDERCHANGE 单价变更逻辑
  
    说明：
      用于修改 SCMDATA.T_ORDERS.ORDER_PRICE 为新值
  
    入参：
      V_ORDERID   :  订单
      V_COMPID    :  企业Id
      V_GOOID     :  商品档案编号
      V_OLDPRICE  :  旧单价
      V_NEWPRICE  :  新单价
  
    返回值:
      1 正常，2 异常
  
     版本：
       2021-10-15: 已完成基本单价变更
  
  =================================================================================*/
  FUNCTION f_orderchange_pr_sync(v_orderid  IN VARCHAR2,
                                 v_compid   IN VARCHAR2,
                                 v_gooid    IN VARCHAR2,
                                 v_oldprice IN NUMBER,
                                 v_newprice IN NUMBER) RETURN NUMBER;

  /*=================================================================================
  
    ORDERCHANGE 交期变更逻辑
  
    说明：
      用于修改 SCMDATA.T_ORDERS.DELIVERY_DATE 为新值
  
    入参：
      V_ORDERID   :  订单
      V_COMPID    :  企业Id
      V_GOOID     :  商品档案编号
      V_OLDPRICE  :  旧单价
      V_NEWPRICE  :  新单价
  
    返回值:
      1 正常，2 异常
  
     版本：
       2021-10-15: 已完成基本交期变更逻辑
  
  =================================================================================*/
  FUNCTION f_orderchange_dt_sync(v_orderid  IN VARCHAR2,
                                 v_compid   IN VARCHAR2,
                                 v_gooid    IN VARCHAR2,
                                 v_olddate  IN DATE,
                                 v_newdate  IN DATE,
                                 v_cgreason IN VARCHAR2 DEFAULT NULL,
                                 v_prodesc  IN VARCHAR2 DEFAULT NULL)
    RETURN NUMBER;

  /*=================================================================================
  
    ORDERCHANGE 供应商变更逻辑
  
    说明：
      用于修改 SCMDATA.T_ORDERS.DELIVERY_DATE 为新值，
      同时修改 SCMDATA.T_PRODUCTION_PROGRESS.SUPPLIER_CODE
               SCMDATA.T_PRODUCTION_PROGRESS.FACTORY_CODE 为新值
  
    入参：
      V_ORDERID   :  订单
      V_COMPID    :  企业Id
      V_OLDSUP    :  旧供应商
      V_NEWSUP    :  新供应商
  
    返回值:
      1 正常，2 异常
  
     版本：
       2021-10-15: 已完成基本供应商变更逻辑
  
  =================================================================================*/
  FUNCTION f_orderchange_sc_sync(v_orderid IN VARCHAR2,
                                 v_compid  IN VARCHAR2,
                                 v_oldsup  IN VARCHAR2,
                                 v_newsup  IN VARCHAR2) RETURN NUMBER;

  /*=================================================================================
  
    ORDERCHANGE 仓库变更逻辑
  
    说明：
      用于修改 SCMDATA.T_ORDERED.SHO_ID 为新值
  
    入参：
      V_ORDERID   :  订单
      V_COMPID    :  企业Id
      V_OLDLOC    :  旧仓库
      V_NEWLOC    :  新仓库
  
    返回值:
      1 正常，2 异常
  
     版本：
       2021-10-15: 已完成基本仓库变更逻辑
  
  =================================================================================*/
  FUNCTION f_orderchange_wh_sync(v_orderid IN VARCHAR2,
                                 v_compid  IN VARCHAR2,
                                 v_oldloc  IN VARCHAR2,
                                 v_newloc  IN VARCHAR2) RETURN NUMBER;

  /*=================================================================================
  
    ORDERCHANGE 供应商代发变更逻辑
  
    说明：
      用于修改 SCMDATA.T_ORDERED.SEND_BY_SUP 为新值
  
    入参：
      V_ORDERID   :  订单
      V_COMPID    :  企业Id
      V_OLDSBS    :  旧是否代发值
      V_NEWSBS    :  新是否代发值
  
    返回值:
      1 正常，2 异常
  
     版本：
       2021-10-15: 已完成基本供应商代发变更逻辑
  
  =================================================================================*/
  FUNCTION f_orderchange_sd_sync(v_orderid IN VARCHAR2,
                                 v_compid  IN VARCHAR2,
                                 v_oldsbs  IN VARCHAR2,
                                 v_newsbs  IN VARCHAR2) RETURN NUMBER;

  /*=================================================================================
  
    ORDERCHANGE 数据同步
  
    说明：
      用于将 SCMDATA.T_ORDERCHANGE 中的数据同步到对应表的对应字段
  
     版本：
       2021-10-15: 已完成供应商代发变更，供应商变更，单价变更，交期变更，
                   仓库变更逻辑
  
  =================================================================================*/
  PROCEDURE p_orderchange_sync;

  /*=================================================================================================================
  
    判断是否存在于 SCMDATA.T_CMX_RCA 中
  
    用途:
      判断是否存在于 SCMDATA.T_CMX_RCA 中
  
    入参:
      V_ORDID     : 订单号
      V_GOOID     : 货号
      V_OLDPRICE  : 旧单价
      V_NEWPRICE  : 新单价
      V_AUDITTIME : 审核时间
      V_COMPID    : 企业Id
  
    返回值:
      NUMBER类型，0-不存在 1-存在
  
    版本:
      2021-11-17 : 判断是否存在于 SCMDATA.T_CMX_RCA 中
  
  ==================================================================================================================*/
  FUNCTION f_check_cmx_rca_exists(v_ordid     IN VARCHAR2,
                                  v_gooid     IN VARCHAR2,
                                  v_oldprice  IN NUMBER,
                                  v_newprice  IN NUMBER,
                                  v_audittime IN DATE,
                                  v_compid    IN VARCHAR2) RETURN NUMBER;

  /*=================================================================================================================
  
    SCMDATA.T_CMX_RCA 内校验
  
    用途:
      用于校验商品档案是否存在该货号
  
    入参:
      V_ORDID  : 订单号
      V_GOOID  : 货号
      V_COMPID : 企业Id
  
    版本:
      2021-11-17 : 判断是否存在于 SCMDATA.T_CMX_RCA 中
  
  ==================================================================================================================*/
  PROCEDURE p_check_cmxrca_info(v_ordid  IN VARCHAR2,
                                v_gooid  IN VARCHAR2,
                                v_compid IN VARCHAR2,
                                v_eobjid IN VARCHAR2);

  /*================================================================================
  
    提单后成本变更接口
  
    用途:
      用于接收提单后成本变更数据到 SCMDATA.T_CMX_RCA 表
  
    入参:
      V_ORDID      :  订单号
      V_SHOID      :  仓库Id
      V_GOOID      :  货号
      V_OLDPRICE   :  旧价格
      V_NEWPIRCE   :  新价格
      V_OPERATORID :  操作人Id
      V_CREATETIME :  创建时间
      V_FINISHTIME :  结束时间
      V_AUDITORID  :  审核人Id
      V_AUDITTIME  :  审核时间
      V_MEMO       :  备注
      V_RCAID      :  RCA_ID
      V_BRAID      :  分部Id
      V_INGIDT     :  ING_ID_T
      V_INGIDJ     :  ING_ID_J
      V_EOBJID     :  执行对象Id
      V_COMPID     :  企业Id
      V_MINUTE     :  间隔分钟（记录到 SCMDATA.T_INTERFACE_LOG)
  
    版本:
      2021-11-17 : 用于接收提单后成本变更数据到 SCMDATA.T_CMX_RCA 表
  
  ================================================================================*/
  PROCEDURE p_insert_rca_itf(v_ordid      IN VARCHAR2,
                             v_shoid      IN VARCHAR2,
                             v_gooid      IN VARCHAR2,
                             v_oldprice   IN NUMBER,
                             v_newpirce   IN NUMBER,
                             v_operatorid IN VARCHAR2,
                             v_createtime IN VARCHAR2,
                             v_finishtime IN VARCHAR2,
                             v_auditorid  IN VARCHAR2,
                             v_audittime  IN VARCHAR2,
                             v_memo       IN VARCHAR2,
                             v_rcaid      IN VARCHAR2,
                             v_braid      IN VARCHAR2,
                             v_ingidt     IN VARCHAR2,
                             v_ingidj     IN VARCHAR2,
                             v_eobjid     IN VARCHAR2,
                             v_compid     IN VARCHAR2,
                             v_minute     IN NUMBER);

  /*=================================================================================================================
  
    SCMDATA.T_CMX_RCA 数据同步
  
    用途:
      用于将 SCMDATA.T_CMX_RCA 内数据同步到 SCMDATA.T_ORDERS
  
    版本:
      2021-11-17 : 用于将 SCMDATA.T_CMX_RCA 内数据同步到 SCMDATA.T_ORDERS，每次300条
  
  ==================================================================================================================*/
  PROCEDURE p_cmxrca_sync;

  /*=================================================================================
  
    获取 ORDERED / ORDERS / ORDERSITEM 数量
  
    入参：
      V_ORDID        :  订单号
      V_COMPID       :  企业Id
      V_EDNUM        :  ordered 数据条数
      V_ORDSNUM      :  orders 数据条数
      V_ORDSITEMNUM  :  ordersitem 数据条数
  
     版本：
       2022-04-15 : 获取 ORDERED / ORDERS / ORDERSITEM 数量
  
  =================================================================================*/
  PROCEDURE p_get_order_num(v_ordid   IN VARCHAR2,
                            v_compid  IN VARCHAR2,
                            v_ednum   IN OUT NUMBER,
                            v_snum    IN OUT NUMBER,
                            v_itemnum IN OUT NUMBER);

  /*=================================================================================
  
    获取 供应商、商品档案 判断
  
    入参：
      V_SUPCODE   :  供应商编码
      V_GOOID     :  货号编码
      V_COMPID    :  企业Id
      V_ISSUPEX   :  供应商是否存在 0-存在 1-不存在
      V_ISGOOEX   :  商品档案是否存在 0-存在 1-不存在
  
     版本：
       2022-04-15 : 获取 ORDERS / ORDERSITEM 数量
  
  =================================================================================*/
  PROCEDURE p_check_sup_goo_ex(v_supcode IN VARCHAR2,
                               v_gooid   IN VARCHAR2,
                               v_compid  IN VARCHAR2,
                               v_issupex IN OUT NUMBER,
                               v_isgooex IN OUT NUMBER);

  /*=================================================================================
  
    校验 ordered 是否已经接入
  
    入参：
      V_ORDID   :  订单号
      V_COMPID  :  企业Id
      V_PDEDNUM :  熊猫 ordered 数据条数
  
     版本：
       2022-04-15 : 校验 ordered 是否已经接入
  
  =================================================================================*/
  FUNCTION f_check_orded_altrans(v_ordid   IN VARCHAR2,
                                 v_compid  IN VARCHAR2,
                                 v_pdednum IN NUMBER) RETURN NUMBER;

  /*=================================================================================
  
    校验 orders 是否已经接入
  
    入参：
      V_ORDID   :  订单号
      V_COMPID  :  企业Id
      V_PDSNUM  :  熊猫 orders 数据条数
  
     版本：
       2022-04-15 : 校验 orders 是否已经接入
  
  =================================================================================*/
  FUNCTION f_check_ords_altrans(v_ordid  IN VARCHAR2,
                                v_compid IN VARCHAR2,
                                v_pdsnum IN NUMBER) RETURN NUMBER;

  /*=================================================================================
  
    校验 ordersitem 是否已经接入
  
    入参：
      V_ORDID     :  订单号
      V_COMPID    :  企业Id
      V_PDITEMNUM :  熊猫 ordersitem 数据条数
  
     版本：
       2022-04-15 : 校验 ordersitem 是否已经接入
  
  =================================================================================*/
  FUNCTION f_check_ordsitem_altrans(v_ordid     IN VARCHAR2,
                                    v_compid    IN VARCHAR2,
                                    v_pditemnum IN NUMBER) RETURN NUMBER;

  /*=================================================================================
  
    更新 T_ORDER_LEAK ordered 是否接入字段
  
    入参：
      V_ORDID   :  订单号
      V_COMPID  :  企业Id
  
     版本：
       2022-04-15 : 更新 T_ORDER_LEAK ordered 是否接入字段
  
  =================================================================================*/
  PROCEDURE p_update_ordleak_isordedget(v_ordid  IN VARCHAR2,
                                        v_compid IN VARCHAR2);

  /*=================================================================================
  
    更新 T_ORDER_LEAK orders 是否接入字段
  
    入参：
      V_ORDID   :  订单号
      V_COMPID  :  企业Id
  
     版本：
       2022-04-15 : 更新 T_ORDER_LEAK orders 是否接入字段
  
  =================================================================================*/
  PROCEDURE p_update_ordleak_isordsget(v_ordid  IN VARCHAR2,
                                       v_compid IN VARCHAR2);

  /*=================================================================================
  
    更新 T_ORDER_LEAK ordersitem 是否接入字段
  
    入参：
      V_ORDID   :  订单号
      V_COMPID  :  企业Id
  
     版本：
       2022-04-15 : 更新 T_ORDER_LEAK ordersitem 是否接入字段
  
  =================================================================================*/
  PROCEDURE p_update_ordleak_isordsitemget(v_ordid  IN VARCHAR2,
                                           v_compid IN VARCHAR2);

  /*=================================================================================
  
    获取 ORDER_LEAK 数据状态
  
    入参：
      V_ISSUPEX       :  供应商档案是否存在
      V_ISGOOEX       :  商品档案是否存在
      V_ISEDGET       :  ordered是否接入
      V_ISSGET        :  orders是否接入
      V_ISITEMGET     :  ordersitem是否接入
  
     版本：
       2022-04-15 : 获取 ORDER_LEAK 数据状态
  
  =================================================================================*/
  FUNCTION f_get_orderleak_status(v_issupex   IN NUMBER,
                                  v_isgooex   IN NUMBER,
                                  v_isedget   IN NUMBER,
                                  v_issget    IN NUMBER,
                                  v_isitemget IN NUMBER) RETURN VARCHAR2;

  /*=================================================================================
  
    订单漏接信息接入
  
    入参：
      V_ORDID         :  订单号
      V_SUPIDBASE     :  供应商编码
      V_GOOID         :  内部货号
      V_CREATETIME    :  订单创建时间
      V_ORDEDNUM      :  熊猫ordered数据条数
      V_ORDSNUM       :  熊猫orders数据条数
      V_ORDSITEMNUM   :  熊猫ordersitem数据条数
      V_COMPID        :  企业Id
  
     版本：
       2022-04-15 : 订单漏接信息接入
  
  =================================================================================*/
  PROCEDURE p_order_leak_insert(v_ordid       IN VARCHAR2,
                                v_supidbase   IN VARCHAR2,
                                v_gooid       IN VARCHAR2,
                                v_createtime  IN VARCHAR2,
                                v_ordednum    IN VARCHAR2,
                                v_ordsnum     IN VARCHAR2,
                                v_ordsitemnum IN VARCHAR2,
                                v_compid      IN VARCHAR2);

END pkg_port_sync;
/

CREATE OR REPLACE PACKAGE BODY SCMDATA.pkg_port_sync IS

  /*=================================================================================
  
    获取批次接口必要信息
  
    说明：
       在插入到批次接口-数据中间表时必须
  
    入参：
       CONFIG_ID : 配置ID SCMDATA.T_PBT_CONFIG.CONFIG_ID
       USER_ID   : 当前执行人USER_ID
  
    返回值：
       ''CFG12312312412'' CONFIG_ID,
       ''edasd1231r125asd'' USER_ID,
       ''2021-08-01 12-10-10'' OPER_TIME
  
    版本：
       2021-01-01: 完成获取必要信息
  
  =================================================================================*/
  FUNCTION f_get_nes_infomation(config_id IN VARCHAR2, user_id IN VARCHAR2)
    RETURN VARCHAR2 IS
    nes_info VARCHAR2(512);
  BEGIN
    nes_info := '''''' || config_id || ''''' CONFIG_ID, ' || '''''' ||
                user_id || ''''' OPER_USERID, ' || '''''' ||
                to_char(SYSDATE, 'yyyy-MM-dd HH24-mi-ss') ||
                ''''' OPER_TIME ';
    RETURN nes_info;
  END f_get_nes_infomation;

  /*=================================================================================
  
    更新订单scm创建时间
  
    入参:
      V_ORDID   :  订单Id
      V_COMPID  :  企业Id
  
    版本：
       2022-09-27: 更新订单scm创建时间
  
  =================================================================================*/
  PROCEDURE p_upd_ordercretimescm(v_ordid  IN VARCHAR2,
                                  v_compid IN VARCHAR2) IS
    v_jugnum NUMBER(1);
  BEGIN
    SELECT sign(oedj + osj + osij)
      INTO v_jugnum
      FROM (SELECT MAX(CASE
                         WHEN oed.port_status IN ('SP', 'ER') THEN
                          1
                         ELSE
                          0
                       END) oedj,
                   MAX(CASE
                         WHEN os.port_status IN ('SP', 'ER') THEN
                          1
                         ELSE
                          0
                       END) osj,
                   MAX(CASE
                         WHEN osi.port_status IN ('SP', 'ER') THEN
                          1
                         ELSE
                          0
                       END) osij
              FROM scm_interface.t_ordered_itf oed
             INNER JOIN scm_interface.t_orders_itf os
                ON oed.order_id = os.order_id
               AND oed.company_id = os.company_id
              LEFT JOIN scm_interface.t_ordersitem_itf osi
                ON oed.order_id = osi.order_id
               AND oed.company_id = osi.company_id
             WHERE oed.order_id = v_ordid
               AND oed.company_id = v_compid);
  
    IF v_jugnum = 0 THEN
      UPDATE scmdata.t_ordered
         SET create_time_scm = SYSDATE
       WHERE order_code = v_ordid
         AND company_id = v_compid;
    END IF;
  END p_upd_ordercretimescm;

  /*=================================================================================
  
    构建批次接口action_sql
  
    说明：
      用于将批次接口-配置的select_sql整合为批次接口的action_sql
  
    入参：
      SELECT_SQL : 用于传输到被调用方动态执行，SCMDATA.T_PBT_CONFIG.SELECT_SQL
      CONFIG_ID  : 略，SCMDATA.T_PBT_CONFG.CONFIG_ID
      USER_ID   : 当前执行人USER_ID
  
    返回值：
      'SELECT '''' 变量名...,
              ''XXXXXXXXXX'' EXECUTE_SQL,
              ''easfasfa2asd31asd42312'' CONFIG_ID,
              ''MS_ORDERED'' ORIGIN,
              ''easfsczxb1221asdas1121'' OPER_USERID,
              ''2021-07-08 12-42-23'' OPER_TIME
         FROM DUAL
  
     版本：
       2021-01-01: 完成构建批次接口action_sql，只要速狮接口底层不做大改，
                   即可继续沿用
  
  =================================================================================*/
  FUNCTION f_build_batch_acsql(select_sql IN VARCHAR2,
                               config_id  IN VARCHAR2,
                               user_id    IN VARCHAR2) RETURN CLOB IS
    frep_str VARCHAR2(512);
    ret_clob CLOB;
  BEGIN
    frep_str := scmdata.pkg_port_sync.f_get_nes_infomation(config_id => config_id,
                                                           user_id   => user_id);
    ret_clob := 'SELECT '''' COL_01,
        '''' COL_02,
        '''' COL_03,
        '''' COL_04,
        '''' COL_05,
        '''' COL_06,
        '''' COL_07,
        '''' COL_08,
        '''' COL_09,
        '''' COL_10,
        '''' COL_11,
        '''' COL_12,
        '''' COL_13,
        '''' COL_14,
        '''' COL_15,
        ''' || REPLACE(select_sql, 'REP_STR', frep_str) ||
                ''' EXECUTE_SQL,
        '''' CONFIG_ID,
        '''' ORIGIN,
        '''' OPER_USERID,
        '''' OPER_TIME
     FROM DUAL';
    RETURN ret_clob;
  END f_build_batch_acsql;

  /*=================================================================================
  
    订单接口数据检查
  
    说明：
      用于订单接口数据进入接口表前检查
  
    入参：
      v_relagooid      :  货号
      v_insidesupcode  :  内部供应商编号
      v_compid         :  企业Id
    
    入出参:
      v_errcode        :  错误编码
      v_errmsg         :  错误信息
  
     版本：
       2022-06-30 : 订单接口重构
       2023-03-15 : 订单生产工厂接口需求变更，
                    当订单供应商生产工厂存在本厂时赋值为订单供应商，否则赋值为空
  
  =================================================================================*/
  PROCEDURE p_orditf_check(v_relagooid     IN VARCHAR2,
                           v_insidesupcode IN VARCHAR2,
                           v_compid        IN VARCHAR2,
                           v_errcode       IN OUT VARCHAR2,
                           v_errmsg        IN OUT VARCHAR2) IS
    v_goojugnum NUMBER(1);
    v_supjugnum NUMBER(1);
  BEGIN
    --数据初始化
    v_errcode := '';
    v_errmsg  := '';
  
    --货号校验
    SELECT COUNT(1)
      INTO v_goojugnum
      FROM scmdata.t_commodity_info
     WHERE rela_goo_id = v_relagooid
       AND company_id = v_compid
       AND rownum = 1;
  
    --供应商校验
    SELECT COUNT(1)
      INTO v_supjugnum
      FROM scmdata.t_supplier_info
     WHERE inside_supplier_code = v_insidesupcode
       AND company_id = v_compid
       AND rownum = 1;
  
    --赋值逻辑
    IF v_goojugnum = 0 AND v_supjugnum > 0 THEN
      v_errcode := 'GM';
      v_errmsg  := '货号缺失:' || v_relagooid || ' ';
    
      --商品档案重传
      p_gen_retrans_gooinfo(v_gooid => v_relagooid);
    
    ELSIF v_goojugnum > 0 AND v_supjugnum = 0 THEN
      v_errcode := 'SM';
      v_errmsg  := '供应商缺失:' || v_insidesupcode || ' ';
    
    ELSIF v_goojugnum = 0 AND v_supjugnum = 0 THEN
      v_errcode := 'GSM';
      v_errmsg  := '货号缺失:' || v_relagooid || ' 供应商缺失:' || v_insidesupcode || ' ';
    
      --商品档案重传
      p_gen_retrans_gooinfo(v_gooid => v_relagooid);
    
    END IF;
  END p_orditf_check;

  /*=================================================================================
  
    获取跟单员
  
    说明：
      获取跟单员
  
    入参:
      V_OPERATORID  :  订单操作员
      V_SUPIDBASE   :  供应商编码
      V_GOOID       :  货号
      V_COMPID      :  企业Id
  
    版本：
      2022-06-30 : 订单接口重构
  
  =================================================================================*/
  FUNCTION f_get_dealfollower(v_operatorid IN VARCHAR2,
                              v_supidbase  IN VARCHAR2,
                              v_gooid      IN VARCHAR2,
                              v_compid     IN VARCHAR2) RETURN VARCHAR2 IS
    v_operid       VARCHAR2(32);
    v_cate         VARCHAR2(32);
    v_dealfollower VARCHAR2(128);
  BEGIN
    SELECT MAX(user_id)
      INTO v_operid
      FROM scmdata.sys_company_user
     WHERE lower(inner_user_id) = lower(v_operatorid)
       AND company_id = v_compid;
  
    SELECT MAX(category)
      INTO v_cate
      FROM scmdata.t_commodity_info
     WHERE rela_goo_id = v_gooid
       AND company_id = v_compid;
  
    IF v_operid IS NULL THEN
      v_operid := nvl(v_operatorid, 'ORDERED_ITF');
    END IF;
  
    SELECT MAX(gendan_perid)
      INTO v_dealfollower
      FROM scmdata.t_supplier_info
     WHERE inside_supplier_code = v_supidbase
       AND pause IN (0, 2)
       AND company_id = v_compid;
  
    SELECT listagg(a.user_id, ',')
      INTO v_dealfollower
      FROM scmdata.sys_company_user a
     INNER JOIN scmdata.sys_company_user_cate_map b
        ON a.user_id = b.user_id
       AND a.company_id = b.company_id
       AND b.pause = 0
     WHERE instr(v_dealfollower, a.user_id) > 0
       AND b.cooperation_classification = v_cate
       AND a.company_id = v_compid;
  
    IF v_dealfollower IS NULL THEN
      v_dealfollower := v_operid;
    END IF;
  
    RETURN v_dealfollower;
  END f_get_dealfollower;

  /*=================================================================================
  
    ORDERED 接口数据插入 SCMDATA.T_ORDERED_ITF 表
  
    说明：
      用于获取主数据 NSFDATA.ORDERED 数据，并将数据直接插入
      SCMDATA.T_ORDERED_ITF 表，校验不通过记录错误信息不同步
  
    入参：
      V_INORDID          :  订单号
      V_INPOTYPE         :  订单类型
      V_INGOOID          :  货号，货号不存在于系统则单据不进入系统
      V_INDELIVERDATE    :  订单交期
      V_INSUPIDBASE      :  供应商编号，供应商编号不存在于系统则单据不进入系统
      V_INOPERATORID     :  操作人Id
      V_INCREATETIME     :  创建时间
      V_INFINISHTIME     :  结束时间
      V_INMEMO           :  备注
      V_INISFIRSTORDERED :  是否首单
      V_INSHOID          :  仓库Id
      V_INSENDBYSUP      :  供应商代发
      V_INRATIONAME      :  配码比名称
      V_INCOMPID         :  数据归属企业Id
  
     版本：
       2022-06-30 : 订单接口重构
  
  =================================================================================*/
  PROCEDURE p_ordered_itf_insert(v_inordid          IN VARCHAR2,
                                 v_inpotype         IN VARCHAR2,
                                 v_ingooid          IN VARCHAR2,
                                 v_indeliverdate    IN VARCHAR2,
                                 v_insupidbase      IN VARCHAR2,
                                 v_inoperatorid     IN VARCHAR2,
                                 v_increatetime     IN VARCHAR2,
                                 v_infinishtime     IN VARCHAR2,
                                 v_inmemo           IN VARCHAR2,
                                 v_inisfirstordered IN NUMBER,
                                 v_inisprodctorder  IN NUMBER,
                                 v_inshoid          IN VARCHAR2,
                                 v_insendbysup      IN NUMBER,
                                 v_inmerchandiserid IN VARCHAR2,
                                 v_inrationame      IN VARCHAR2,
                                 v_incompid         IN VARCHAR2) IS
    v_jugnum     NUMBER(1);
    v_portstatus VARCHAR2(4);
    v_errcode    VARCHAR2(16);
    v_errmsg     CLOB;
  BEGIN
    IF v_inordid IS NOT NULL THEN
      --唯一校验
      SELECT COUNT(1)
        INTO v_jugnum
        FROM scm_interface.t_ordered_itf
       WHERE order_id = v_inordid
         AND company_id = v_incompid
         AND rownum = 1;
    
      --获取错误编码及错误信息
      p_orditf_check(v_relagooid     => v_ingooid,
                     v_insidesupcode => v_insupidbase,
                     v_compid        => v_incompid,
                     v_errcode       => v_errcode,
                     v_errmsg        => v_errmsg);
    
      --数据状态赋值
      IF v_errcode IS NOT NULL THEN
        v_portstatus := 'ER';
      ELSE
        v_portstatus := 'SP';
      END IF;
    
      --判断逻辑
      IF v_jugnum = 0 THEN
        --新增
        INSERT INTO scm_interface.t_ordered_itf
          (order_id,
           company_id,
           order_type,
           supplier_code,
           sho_id,
           goo_id,
           delivery_date,
           finish_time,
           isfirstordered,
           send_by_sup,
           is_product_order,
           memo,
           rationame,
           merchandiserid,
           operate_id,
           create_time,
           port_obj,
           port_status,
           port_time,
           err_code,
           err_msg,
           retry_num)
        VALUES
          (v_inordid,
           v_incompid,
           v_inpotype,
           v_insupidbase,
           v_inshoid,
           v_ingooid,
           to_date(v_indeliverdate, 'YYYY-MM-DD HH24-MI-SS'),
           to_date(v_infinishtime, 'YYYY-MM-DD HH24-MI-SS'),
           v_inisfirstordered,
           v_insendbysup,
           v_inisprodctorder,
           v_inmemo,
           v_inrationame,
           v_inmerchandiserid,
           v_inoperatorid,
           to_date(v_increatetime, 'YYYY-MM-DD HH24-MI-SS'),
           'ORDERED_ITF',
           v_portstatus,
           SYSDATE,
           v_errcode,
           v_errmsg,
           0);
      ELSE
        --修改
        UPDATE scm_interface.t_ordered_itf
           SET order_type       = v_inpotype,
               supplier_code    = v_insupidbase,
               goo_id           = v_ingooid,
               sho_id           = v_inshoid,
               delivery_date    = to_date(v_indeliverdate,
                                          'YYYY-MM-DD HH24-MI-SS'),
               finish_time      = to_date(v_infinishtime,
                                          'YYYY-MM-DD HH24-MI-SS'),
               isfirstordered   = v_inisfirstordered,
               send_by_sup      = v_insendbysup,
               is_product_order = v_inisprodctorder,
               memo             = v_inmemo,
               merchandiserid   = v_inmerchandiserid,
               rationame        = v_inrationame,
               operate_id       = v_inoperatorid,
               create_time      = to_date(v_increatetime,
                                          'YYYY-MM-DD HH24-MI-SS'),
               port_obj         = 'ORDERED_ITF',
               port_status      = v_portstatus,
               port_time        = SYSDATE,
               err_code         = v_errcode,
               err_msg          = v_errmsg
         WHERE order_id = v_inordid
           AND company_id = v_incompid;
      END IF;
    END IF;
  END p_ordered_itf_insert;

  /*=================================================================================
  
    ORDERS 接口数据插入 SCMDATA.T_ORDERS_ITF 表
  
    说明：
      用于获取主数据 NSFDATA.ORDERS 数据，并将数据直接插入
      SCMDATA.T_ORDERS_ITF 表，校验不通过则记录错误信息
  
    入参：
      V_INORDID          :  订单号
      V_INGOOID          :  货号，货号不存在于系统则单据不进入系统
      V_INORDERAMOUNT    :  订货量
      V_INGOTAMOUNT      :  到货量
      V_INDELIVERDATE    :  订单交期
      V_ININPRICE        :  订单单价
      V_INPDSUPID        :  供应商编号，供应商编号不存在于系统则单据不进入系统
      V_INMEMO           :  备注
      V_INCOMPID         :  数据归属企业Id
  
     版本：
       2022-06-30 : 订单接口重构
  
  =================================================================================*/
  PROCEDURE p_orders_itf_insert(v_inordid        IN VARCHAR2,
                                v_ingooid        IN VARCHAR2,
                                v_inorderamount  IN NUMBER,
                                v_ingotamount    IN NUMBER,
                                v_indeliverdate  IN VARCHAR2,
                                v_ininprice      IN NUMBER,
                                v_inisqcrequired IN NUMBER,
                                v_inpdsupid      IN VARCHAR2,
                                v_inmemo         IN VARCHAR2,
                                v_incompid       IN VARCHAR2) IS
    v_jugnum     NUMBER(1);
    v_issupasfac NUMBER(1);
    v_portstatus VARCHAR2(4);
    v_faccode    VARCHAR2(32);
    v_errcode    VARCHAR2(16);
    v_errmsg     CLOB;
  BEGIN
    IF v_inordid IS NOT NULL THEN
      --判断唯一
      SELECT COUNT(1)
        INTO v_jugnum
        FROM scm_interface.t_orders_itf
       WHERE order_id = v_inordid
         AND goo_id = v_ingooid
         AND company_id = v_incompid
         AND rownum = 1;
    
      --获取错误编码及错误信息
      p_orditf_check(v_relagooid     => v_ingooid,
                     v_insidesupcode => v_inpdsupid,
                     v_compid        => v_incompid,
                     v_errcode       => v_errcode,
                     v_errmsg        => v_errmsg);
    
      --数据状态赋值
      IF v_errcode IS NOT NULL THEN
        v_portstatus := 'ER';
      ELSE
        v_portstatus := 'SP';
      END IF;
    
      --进入前做校验
      SELECT nvl(MAX(1), 0)
        INTO v_issupasfac
        FROM scmdata.t_supplier_info sup
       INNER JOIN scmdata.t_coop_factory fac
          ON sup.supplier_info_id = fac.supplier_info_id
         AND sup.supplier_info_id = fac.fac_sup_info_id
         AND sup.company_id = fac.company_id
       WHERE sup.inside_supplier_code = v_inpdsupid
         AND sup.company_id = v_incompid;
    
      --判断是否替换
      IF v_issupasfac = 1 THEN
        v_faccode := v_inpdsupid;
      END IF;
    
      --判断逻辑
      IF v_jugnum = 0 THEN
        --新增
        INSERT INTO scm_interface.t_orders_itf
          (order_id,
           company_id,
           goo_id,
           order_price,
           order_amount,
           got_amount,
           delivery_date,
           factory_code,
           memo,
           is_qc_required,
           port_obj,
           port_status,
           port_time,
           err_code,
           err_msg,
           retry_num)
        VALUES
          (v_inordid,
           v_incompid,
           v_ingooid,
           v_ininprice,
           v_inorderamount,
           v_ingotamount,
           to_date(v_indeliverdate, 'YYYY-MM-DD HH24-MI-SS'),
           v_faccode,
           v_inmemo,
           v_inisqcrequired,
           'ORDERS_ITF',
           v_portstatus,
           SYSDATE,
           v_errcode,
           v_errmsg,
           0);
      ELSE
        --修改
        UPDATE scm_interface.t_orders_itf
           SET order_price    = v_ininprice,
               order_amount   = v_inorderamount,
               got_amount     = v_ingotamount,
               delivery_date  = to_date(v_indeliverdate,
                                        'YYYY-MM-DD HH24-MI-SS'),
               factory_code   = v_faccode,
               goo_id         = v_ingooid,
               memo           = v_inmemo,
               is_qc_required = v_inisqcrequired,
               port_obj       = 'ORDERS_ITF',
               port_time      = SYSDATE,
               port_status    = v_portstatus,
               err_code       = v_errcode,
               err_msg        = v_errmsg
         WHERE order_id = v_inordid
           AND goo_id = v_ingooid
           AND company_id = v_incompid;
      END IF;
    END IF;
  END p_orders_itf_insert;

  /*=================================================================================
  
    ORDERSITEM 接口数据插入 SCMDATA.T_ORDERSITEM 表
  
    说明：
      用于获取主数据 NSFDATA.ORDERSITEM 数据，并将数据直接插入
      SCMDATA.T_ORDERSITEM 表，校验不通过则插入日志表：SCMDATA.T_ORDER_INTERFACE_ERR
  
    入参：
      V_INORDID          :  订单号
      V_INGOOID          :  货号，货号不存在于系统则单据不进入系统
      V_INPDSUPID        :  供应商编号，供应商编号不存在于系统则单据不进入系统
      V_INBARCODE        :  条码
      V_INORDERAMOUNT    :  订货量
      V_INGOTAMOUNT      :  到货量
      V_INMEMO           :  备注
      V_INCOMPID         :  数据归属企业Id
  
     版本：
       2021-10-15之前: 完成订货量，到货量，备注接入
  
  =================================================================================*/
  PROCEDURE p_ordersitem_itf_insert(v_inordid       IN VARCHAR2,
                                    v_ingooid       IN VARCHAR2,
                                    v_insupidbase   IN VARCHAR2,
                                    v_inbarcode     IN VARCHAR2,
                                    v_inorderamount IN NUMBER,
                                    v_ingotamount   IN NUMBER,
                                    v_inmemo        IN VARCHAR2,
                                    v_incompid      IN VARCHAR2) IS
    v_jugnum     NUMBER(1);
    v_errcode    VARCHAR2(8);
    v_errmsg     CLOB;
    v_portstatus VARCHAR2(4);
  BEGIN
    IF v_inordid IS NOT NULL THEN
      --判断唯一
      SELECT COUNT(1)
        INTO v_jugnum
        FROM scm_interface.t_ordersitem_itf
       WHERE order_id = v_inordid
         AND goo_id = v_ingooid
         AND nvl(barcode, ' ') = nvl(v_inbarcode, ' ')
         AND company_id = v_incompid
         AND rownum = 1;
    
      --获取错误编码及错误信息
      p_orditf_check(v_relagooid     => v_ingooid,
                     v_insidesupcode => v_insupidbase,
                     v_compid        => v_incompid,
                     v_errcode       => v_errcode,
                     v_errmsg        => v_errmsg);
    
      --数据状态赋值
      IF v_errcode IS NOT NULL THEN
        v_portstatus := 'ER';
      ELSE
        v_portstatus := 'SP';
      END IF;
    
      --判断逻辑
      IF v_jugnum = 0 THEN
        --新增
        INSERT INTO scm_interface.t_ordersitem_itf
          (order_id,
           company_id,
           goo_id,
           barcode,
           supplier_code,
           order_amount,
           got_amount,
           memo,
           port_obj,
           port_status,
           port_time,
           err_code,
           err_msg,
           retry_num)
        VALUES
          (v_inordid,
           v_incompid,
           v_ingooid,
           nvl(v_inbarcode, ' '),
           v_insupidbase,
           v_inorderamount,
           v_ingotamount,
           v_inmemo,
           'ORDERS_ITF',
           v_portstatus,
           SYSDATE,
           v_errcode,
           v_errmsg,
           0);
      ELSE
        --修改
        UPDATE scm_interface.t_ordersitem_itf
           SET order_amount  = v_inorderamount,
               got_amount    = v_ingotamount,
               memo          = v_inmemo,
               supplier_code = v_insupidbase,
               goo_id        = v_ingooid,
               port_obj      = 'ORDERSITEM_ITF',
               port_time     = SYSDATE,
               port_status   = v_portstatus,
               err_code      = v_errcode,
               err_msg       = v_errmsg
         WHERE order_id = v_inordid
           AND goo_id = v_ingooid
           AND nvl(barcode, ' ') = nvl(v_inbarcode, ' ')
           AND company_id = v_incompid;
      END IF;
    END IF;
  END p_ordersitem_itf_insert;

  /*=================================================================================
  
    获取供应商编码
  
    说明：
      用于获取供应商编码
  
    入参：
      V_ISDSUPCODE   :  内部供应商编码
      V_COMPID       :  企业Id
  
    版本：
      2022-06-30 : ORDERED 订单接口重构
  
  =================================================================================*/
  FUNCTION f_get_supcode(v_isdsupcode IN VARCHAR2, v_compid IN VARCHAR2)
    RETURN VARCHAR2 IS
    v_supcode VARCHAR2(32);
  BEGIN
    SELECT MAX(supplier_code)
      INTO v_supcode
      FROM scmdata.t_supplier_info
     WHERE inside_supplier_code = v_isdsupcode
       AND company_id = v_compid;
  
    RETURN v_supcode;
  END f_get_supcode;

  /*=================================================================================
  
    获取商品档案编号
  
    说明：
      用于获取商品档案编号
  
    入参：
      V_RELAGOOID   :  货号
      V_COMPID      :  企业Id
  
    版本：
      2022-06-30 : ORDERED 订单接口重构
  
  =================================================================================*/
  FUNCTION f_get_gooid(v_relagooid IN VARCHAR2, v_compid IN VARCHAR2)
    RETURN VARCHAR2 IS
    v_gooid VARCHAR2(32);
  BEGIN
    SELECT MAX(goo_id)
      INTO v_gooid
      FROM scmdata.t_commodity_info
     WHERE rela_goo_id = v_relagooid
       AND company_id = v_compid;
  
    RETURN v_gooid;
  END f_get_gooid;

  /*=================================================================================
  
    ORDERED 订单接口数据同步
  
    说明：
      ORDERED 订单接口数据同步
  
    版本：
      2022-06-30 : ORDERED 订单接口重构
  
  =================================================================================*/
  PROCEDURE p_ordered_itf_sync IS
    v_ordid        VARCHAR2(32);
    v_compid       VARCHAR2(32);
    v_rtnum        NUMBER(1);
    v_dealfollower VARCHAR2(128);
    v_supcode      VARCHAR2(32);
    v_jugnum       NUMBER(1);
  BEGIN
    FOR i IN (SELECT order_id,
                     company_id,
                     order_type,
                     goo_id,
                     supplier_code,
                     sho_id,
                     delivery_date,
                     finish_time,
                     isfirstordered,
                     send_by_sup,
                     is_product_order,
                     memo,
                     rationame,
                     merchandiserid,
                     operate_id,
                     create_time
                FROM scm_interface.t_ordered_itf
               WHERE port_status = 'SP'
                 AND (err_code IS NULL OR err_code = 'RE')
               FETCH FIRST 100 rows ONLY) LOOP
      BEGIN
        v_ordid  := i.order_id;
        v_compid := i.company_id;
      
        v_dealfollower := f_get_dealfollower(v_operatorid => i.merchandiserid,
                                             v_supidbase  => i.supplier_code,
                                             v_gooid      => i.goo_id,
                                             v_compid     => i.company_id);
      
        v_supcode := f_get_supcode(v_isdsupcode => i.supplier_code,
                                   v_compid     => i.company_id);
      
        SELECT COUNT(1)
          INTO v_jugnum
          FROM scmdata.t_ordered
         WHERE order_code = i.order_id
           AND company_id = i.company_id
           AND rownum = 1;
      
        IF v_jugnum = 0 THEN
          INSERT INTO scmdata.t_ordered
            (order_id,
             company_id,
             order_code,
             order_status,
             order_type,
             delivery_date,
             supplier_code,
             send_order,
             send_order_date,
             create_id,
             create_time,
             finish_time,
             origin,
             memo,
             sho_id,
             deal_follower,
             send_by_sup,
             isfirstordered,
             is_product_order,
             rationame)
          VALUES
            (scmdata.f_get_uuid(),
             i.company_id,
             i.order_id,
             'OS01',
             i.order_type,
             i.delivery_date,
             v_supcode,
             i.operate_id,
             i.create_time,
             i.operate_id,
             i.create_time,
             i.finish_time,
             'MS_ORDERED',
             i.memo,
             i.sho_id,
             v_dealfollower,
             i.send_by_sup,
             i.isfirstordered,
             i.is_product_order,
             i.rationame);
        ELSE
          UPDATE scmdata.t_ordered
             SET order_type       = i.order_type,
                 delivery_date    = i.delivery_date,
                 supplier_code    = v_supcode,
                 send_order       = i.operate_id,
                 send_order_date  = i.create_time,
                 create_id        = i.operate_id,
                 create_time      = i.create_time,
                 finish_time      = i.finish_time,
                 memo             = i.memo,
                 sho_id           = i.sho_id,
                 deal_follower    = v_dealfollower,
                 send_by_sup      = i.send_by_sup,
                 isfirstordered   = i.isfirstordered,
                 is_product_order = i.is_product_order,
                 rationame        = i.rationame
           WHERE order_code = i.order_id
             AND company_id = i.company_id;
        END IF;
      
        scmdata.pkg_order_management.p_ordqcrela_iu_data(v_ordid  => i.order_id,
                                                         v_compid => i.company_id);
      
        UPDATE scm_interface.t_ordered_itf
           SET port_status = 'SS'
         WHERE order_id = i.order_id
           AND company_id = i.company_id;
      
      EXCEPTION
        WHEN OTHERS THEN
          SELECT MAX(retry_num)
            INTO v_rtnum
            FROM scm_interface.t_ordered_itf
           WHERE order_id = v_ordid
             AND company_id = v_compid;
        
          IF v_rtnum <= 2 THEN
            UPDATE scm_interface.t_ordered_itf ertmp1
               SET port_status = 'ER',
                   err_code    = 'RE',
                   retry_num   = ertmp1.retry_num + 1,
                   err_msg     = ertmp1.err_msg || chr(10) ||
                                 to_char(SYSDATE, 'YYYY-MM-DD HH24-MI-SS') ||
                                 chr(10) || 'FORMAT_ERROR_BACKTRACE:' ||
                                 dbms_utility.format_error_backtrace ||
                                 chr(10) || 'FORMAT_ERROR_STACK:' ||
                                 dbms_utility.format_error_stack || chr(10) ||
                                 'FORMAT_CALL_STACK:' ||
                                 dbms_utility.format_call_stack
             WHERE order_id = v_ordid
               AND company_id = v_compid;
          ELSE
            UPDATE scm_interface.t_ordered_itf ertmp2
               SET port_status = 'RW',
                   retry_num   = ertmp2.retry_num + 1,
                   err_msg     = ertmp2.err_msg || chr(10) ||
                                 to_char(SYSDATE, 'YYYY-MM-DD HH24-MI-SS') ||
                                 chr(10) || 'FORMAT_ERROR_BACKTRACE:' ||
                                 dbms_utility.format_error_backtrace ||
                                 chr(10) || 'FORMAT_ERROR_STACK:' ||
                                 dbms_utility.format_error_stack || chr(10) ||
                                 'FORMAT_CALL_STACK:' ||
                                 dbms_utility.format_call_stack
             WHERE order_id = v_ordid
               AND company_id = v_compid;
          END IF;
      END;
    END LOOP;
  END p_ordered_itf_sync;

  /*=================================================================================
  
    ORDERS 订单接口数据同步
  
    说明：
      ORDERS 订单接口数据同步
  
    版本：
      2022-06-30 : ORDERED 订单接口重构
      2023-03-15 : 订单生产工厂接口需求变更，
                   当订单供应商生产工厂存在本厂时赋值为订单供应商，否则赋值为空
  
  =================================================================================*/
  PROCEDURE p_orders_itf_sync IS
    v_rtnum     NUMBER(1);
    v_ordid     VARCHAR2(32);
    v_compid    VARCHAR2(32);
    v_relagooid VARCHAR2(32);
    v_gooid     VARCHAR2(32);
    v_faccode   VARCHAR2(32);
    v_jugnum    NUMBER(1);
  BEGIN
    FOR i IN (SELECT order_id,
                     company_id,
                     goo_id,
                     order_price,
                     order_amount,
                     got_amount,
                     delivery_date,
                     factory_code,
                     memo,
                     is_qc_required
                FROM scm_interface.t_orders_itf
               WHERE port_status = 'SP'
                 AND (err_code IS NULL OR err_code = 'RE')
               FETCH FIRST 100 rows ONLY) LOOP
      BEGIN
        v_ordid     := i.order_id;
        v_relagooid := i.goo_id;
        v_compid    := i.company_id;
        v_gooid     := f_get_gooid(v_relagooid => i.goo_id,
                                   v_compid    => i.company_id);
      
        v_faccode := f_get_supcode(v_isdsupcode => i.factory_code,
                                   v_compid     => i.company_id);
      
        SELECT COUNT(1)
          INTO v_jugnum
          FROM scmdata.t_orders
         WHERE order_id = i.order_id
           AND goo_id = v_gooid
           AND company_id = i.company_id
           AND rownum = 1;
      
        IF v_jugnum = 0 THEN
          INSERT INTO scmdata.t_orders
            (orders_id,
             company_id,
             orders_code,
             order_id,
             goo_id,
             order_amount,
             got_amount,
             order_price,
             delivery_date,
             memo,
             factory_code,
             is_qc_required)
          VALUES
            (scmdata.f_get_uuid(),
             i.company_id,
             ' ',
             i.order_id,
             v_gooid,
             i.order_amount,
             i.got_amount,
             i.order_price,
             i.delivery_date,
             i.memo,
             v_faccode,
             i.is_qc_required);
        ELSE
          UPDATE scmdata.t_orders
             SET order_price    = i.order_price,
                 order_amount   = i.order_amount,
                 got_amount     = i.got_amount,
                 delivery_date  = i.delivery_date,
                 factory_code   = v_faccode,
                 memo           = i.memo,
                 is_qc_required = i.is_qc_required
           WHERE order_id = i.order_id
             AND goo_id = v_gooid
             AND company_id = i.company_id;
        END IF;
      
        UPDATE scm_interface.t_orders_itf
           SET port_status = 'SS'
         WHERE order_id = i.order_id
           AND goo_id = i.goo_id
           AND company_id = i.company_id;
      
      EXCEPTION
        WHEN OTHERS THEN
          SELECT MAX(retry_num)
            INTO v_rtnum
            FROM scm_interface.t_orders_itf
           WHERE order_id = v_ordid
             AND goo_id = v_relagooid
             AND company_id = v_compid;
        
          IF v_rtnum <= 2 THEN
            UPDATE scm_interface.t_orders_itf ertmp1
               SET port_status = 'ER',
                   err_code    = 'RE',
                   retry_num   = ertmp1.retry_num + 1,
                   err_msg     = ertmp1.err_msg || chr(10) ||
                                 to_char(SYSDATE, 'YYYY-MM-DD HH24-MI-SS') ||
                                 chr(10) || 'FORMAT_ERROR_BACKTRACE:' ||
                                 dbms_utility.format_error_backtrace ||
                                 chr(10) || 'FORMAT_ERROR_STACK:' ||
                                 dbms_utility.format_error_stack || chr(10) ||
                                 'FORMAT_CALL_STACK:' ||
                                 dbms_utility.format_call_stack
             WHERE order_id = v_ordid
               AND goo_id = v_relagooid
               AND company_id = v_compid;
          ELSE
            UPDATE scm_interface.t_orders_itf ertmp2
               SET port_status = 'RW',
                   err_code    = 'RE',
                   retry_num   = ertmp2.retry_num + 1,
                   err_msg     = ertmp2.err_msg || chr(10) ||
                                 to_char(SYSDATE, 'YYYY-MM-DD HH24-MI-SS') ||
                                 chr(10) || 'FORMAT_ERROR_BACKTRACE:' ||
                                 dbms_utility.format_error_backtrace ||
                                 chr(10) || 'FORMAT_ERROR_STACK:' ||
                                 dbms_utility.format_error_stack || chr(10) ||
                                 'FORMAT_CALL_STACK:' ||
                                 dbms_utility.format_call_stack
             WHERE order_id = v_ordid
               AND goo_id = v_relagooid
               AND company_id = v_compid;
          END IF;
      END;
    END LOOP;
  END p_orders_itf_sync;

  /*=================================================================================
  
    ORDERSITEM 订单接口数据同步
  
    说明：
      ORDERSITEM 订单接口数据同步
  
    版本：
      2022-06-30 : ORDERED 订单接口重构
  
  =================================================================================*/
  PROCEDURE p_ordersitem_itf_sync IS
    v_rtnum     NUMBER(1);
    v_ordid     VARCHAR2(32);
    v_relagooid VARCHAR2(32);
    v_barcode   VARCHAR2(32);
    v_compid    VARCHAR2(32);
    v_gooid     VARCHAR2(32);
    v_jugnum    NUMBER(1);
  BEGIN
    FOR i IN (SELECT order_id,
                     company_id,
                     goo_id,
                     barcode,
                     supplier_code,
                     order_amount,
                     got_amount,
                     memo
                FROM scm_interface.t_ordersitem_itf
               WHERE port_status = 'SP'
                 AND (err_code IS NULL OR err_code = 'RE')
                 AND order_amount IS NOT NULL
               FETCH FIRST 1500 rows ONLY) LOOP
      BEGIN
        v_ordid     := i.order_id;
        v_relagooid := i.goo_id;
        v_barcode   := i.barcode;
        v_compid    := i.company_id;
      
        v_gooid := f_get_gooid(v_relagooid => i.goo_id,
                               v_compid    => i.company_id);
      
        SELECT COUNT(1)
          INTO v_jugnum
          FROM scmdata.t_ordersitem
         WHERE order_id = i.order_id
           AND goo_id = v_gooid
           AND barcode = i.barcode
           AND company_id = i.company_id
           AND rownum = 1;
      
        IF v_jugnum = 0 THEN
          INSERT INTO scmdata.t_ordersitem
            (ordersitem_id,
             company_id,
             ordersitem_code,
             order_id,
             goo_id,
             barcode,
             order_amount,
             got_amount,
             memo)
          VALUES
            (scmdata.f_get_uuid(),
             i.company_id,
             ' ',
             i.order_id,
             v_gooid,
             i.barcode,
             i.order_amount,
             i.got_amount,
             i.memo);
        ELSE
          UPDATE scmdata.t_ordersitem
             SET order_amount = i.order_amount,
                 got_amount   = i.got_amount,
                 memo         = i.memo
           WHERE order_id = i.order_id
             AND goo_id = v_gooid
             AND barcode = i.barcode
             AND company_id = i.company_id;
        END IF;
      
        UPDATE scm_interface.t_ordersitem_itf
           SET port_status = 'SS'
         WHERE order_id = i.order_id
           AND goo_id = i.goo_id
           AND barcode = i.barcode
           AND company_id = i.company_id;
---20230524 lsl add 大货BOM生成
        mrp.pkg_bulk_cargo_bom.p_bulk_cargo_bom(v_order_id   => i.order_id,
                                                v_barcode    => i.barcode,
                                                v_company_id => i.company_id);
--end 
      EXCEPTION
        WHEN OTHERS THEN
          SELECT MAX(retry_num)
            INTO v_rtnum
            FROM scm_interface.t_ordersitem_itf
           WHERE order_id = v_ordid
             AND goo_id = v_relagooid
             AND barcode = v_barcode
             AND company_id = v_compid;
        
          IF v_rtnum <= 2 THEN
            UPDATE scm_interface.t_ordersitem_itf ertmp1
               SET port_status = 'ER',
                   err_code    = 'RE',
                   retry_num   = ertmp1.retry_num + 1,
                   err_msg     = ertmp1.err_msg || chr(10) ||
                                 to_char(SYSDATE, 'YYYY-MM-DD HH24-MI-SS') ||
                                 chr(10) || 'FORMAT_ERROR_BACKTRACE:' ||
                                 dbms_utility.format_error_backtrace ||
                                 chr(10) || 'FORMAT_ERROR_STACK:' ||
                                 dbms_utility.format_error_stack || chr(10) ||
                                 'FORMAT_CALL_STACK:' ||
                                 dbms_utility.format_call_stack
             WHERE order_id = v_ordid
               AND goo_id = v_relagooid
               AND barcode = v_barcode
               AND company_id = v_compid;
          ELSE
            UPDATE scm_interface.t_ordersitem_itf ertmp2
               SET port_status = 'RW',
                   err_code    = 'RE',
                   retry_num   = ertmp2.retry_num + 1,
                   err_msg     = ertmp2.err_msg || chr(10) ||
                                 to_char(SYSDATE, 'YYYY-MM-DD HH24-MI-SS') ||
                                 chr(10) || 'FORMAT_ERROR_BACKTRACE:' ||
                                 dbms_utility.format_error_backtrace ||
                                 chr(10) || 'FORMAT_ERROR_STACK:' ||
                                 dbms_utility.format_error_stack || chr(10) ||
                                 'FORMAT_CALL_STACK:' ||
                                 dbms_utility.format_call_stack
             WHERE order_id = v_ordid
               AND goo_id = v_relagooid
               AND barcode = v_barcode
               AND company_id = v_compid;
          END IF;
      END;
    END LOOP;
  END p_ordersitem_itf_sync;

  /*=================================================================================
  
    订单接入未接入货号重传逻辑
  
    说明：
      订单接入未接入货号重传逻辑
  
    入参：
      V_GOOID  :  货号
  
    版本：
      2022-06-30 : ORDERED 订单接口重构
  
  =================================================================================*/
  PROCEDURE p_gen_retrans_gooinfo(v_gooid IN VARCHAR2) IS
    v_compid VARCHAR2(32);
    v_jugnum NUMBER(1);
  BEGIN
    SELECT MAX(company_id)
      INTO v_compid
      FROM scmdata.t_interface a
     WHERE a.interface_id = 'GOOD_MAIN';
  
    SELECT COUNT(1)
      INTO v_jugnum
      FROM scmdata.t_commodity_info_ctl
     WHERE itf_id = v_gooid
       AND rownum = 1;
  
    IF v_jugnum = 0 THEN
      INSERT INTO scmdata.t_commodity_info_ctl
        (ctl_id,
         itf_id,
         itf_type,
         batch_id,
         batch_num,
         batch_time,
         sender,
         receiver,
         send_time,
         receive_time,
         return_type,
         return_msg,
         create_id,
         create_time,
         update_id,
         update_time,
         remarks,
         company_id)
      VALUES
        (scmdata.f_get_uuid(),
         v_gooid,
         'GOOD_MAIN',
         NULL,
         NULL,
         SYSDATE,
         'mdm',
         'scm',
         SYSDATE,
         SYSDATE,
         'W',
         '商品货号' || v_gooid || '指定重新导入',
         'ADMIN',
         SYSDATE,
         'ADMIN',
         SYSDATE,
         NULL,
         v_compid);
    
      INSERT INTO scmdata.t_commodity_color_size_ctl
        (ctl_id,
         itf_id,
         itf_type,
         batch_id,
         batch_num,
         batch_time,
         sender,
         receiver,
         send_time,
         receive_time,
         return_type,
         return_msg,
         create_id,
         create_time,
         update_id,
         update_time,
         remarks,
         company_id)
      VALUES
        (scmdata.f_get_uuid(),
         v_gooid,
         '色码表接口导入',
         NULL,
         NULL,
         SYSDATE,
         'mdm',
         'scm',
         SYSDATE,
         SYSDATE,
         'R',
         '商品货号' || v_gooid || '指定重新导入',
         'ADMIN',
         SYSDATE,
         'ADMIN',
         SYSDATE,
         NULL,
         v_compid);
    
      INSERT INTO scmdata.t_commodity_composition_ctl
        (ctl_id,
         company_id,
         inf_id,
         goo_id,
         composname,
         loadrate,
         goo_raw,
         receive_time,
         create_time,
         memo,
         sort,
         return_type,
         return_msg,
         itf_type,
         sender,
         receiver)
      VALUES
        (scmdata.f_get_uuid(),
         v_compid,
         v_gooid,
         v_gooid,
         NULL,
         NULL,
         NULL,
         SYSDATE,
         SYSDATE,
         NULL,
         NULL,
         'R',
         '商品货号' || v_gooid || '指定重新导入',
         'GOODS_COMPOSITION',
         'mdm',
         'scm');
    END IF;
  END p_gen_retrans_gooinfo;

  /*=================================================================================
  
    获取 V_MINDEC 分钟内缺失的供应商编号
  
    说明：
      用于获取 V_MINDEC 分钟内缺失的供应商编号
  
    入参：
      V_MINDEC  :  分钟数
  
    版本：
      2022-06-30 : ORDERED 订单接口重构
  
  =================================================================================*/
  FUNCTION f_get_missed_supcodes(v_mindec IN NUMBER) RETURN CLOB IS
    v_info CLOB;
  BEGIN
    SELECT listagg(DISTINCT sup_code, ';')
      INTO v_info
      FROM (SELECT substr(err_msg,
                          instr(err_msg, '供应商缺失:') + 6,
                          length(err_msg)) sup_code
              FROM scm_interface.t_ordered_itf
             WHERE port_status = 'ER'
               AND err_code IN ('SM', 'GSM')
               AND port_time > SYSDATE - v_mindec / (24 * 60)
               AND company_id = 'b6cc680ad0f599cde0531164a8c0337f') tmp
     WHERE NOT EXISTS
     (SELECT 1
              FROM scmdata.sys_company_wecom_msg
             WHERE robot_type = 'SUP_MISS_MSG'
               AND create_time > trunc(SYSDATE) - 3
               AND instr(content, tmp.sup_code) > 0
               AND company_id = 'b6cc680ad0f599cde0531164a8c0337f');
  
    RETURN v_info;
  END f_get_missed_supcodes;

  /*=================================================================================
  
    获取 V_MINDEC 分钟内缺失的供应商编号并置入消息池提醒对应的人
  
    说明：
      用于 获取 V_MINDEC 分钟内缺失的供应商编号并置入消息池提醒对应的人
  
    入参：
      V_MINDEC  :  分钟数
  
    版本：
      2022-06-30 : ORDERED 订单接口重构
  
  =================================================================================*/
  PROCEDURE p_gen_supmissmsg_into_msgpool(v_mindec IN NUMBER) IS
    v_msg CLOB;
  BEGIN
    v_msg := f_get_missed_supcodes(v_mindec => v_mindec);
  
    IF v_msg IS NOT NULL THEN
      INSERT INTO scmdata.sys_company_wecom_msg
        (company_wecom_msg_id,
         robot_type,
         company_id,
         status,
         create_time,
         create_id,
         msgtype,
         content,
         mentioned_list,
         mentioned_mobile_list)
      VALUES
        (scmdata.f_get_uuid(),
         'SUP_MISS_MSG',
         'b6cc680ad0f599cde0531164a8c0337f',
         2,
         SYSDATE,
         'ADMIN',
         'markdown',
         '#### 订单接口错误通知
供应商编号<font color=''warning''>[' || v_msg || ']</font>不存在于scm。
<@JML26><@TQQ53>',
         'JML26;TQQ53',
         NULL);
    END IF;
  END p_gen_supmissmsg_into_msgpool;

  /*=================================================================================
  
    按模式获取更新后数据的：
      接口状态，错误码，错误信息（PORT_STATUS; ERR_CODE; ERR_MSG）
  
    说明：
      用于按模式获取更新后数据的:
        接口状态，错误码，错误信息（PORT_STATUS; ERR_CODE; ERR_MSG）
  
    入参：
      V_ORDID     :  订单Id
      V_COMPID    :  企业Id
      V_MODE      :  模式
      V_PTSTATUS  :  接口状态
      V_ERRCODE   :  错误码
      V_ERRMSG    :  错误信息
  
    版本：
      2022-06-30 : ORDERED 订单接口重构
  
  =================================================================================*/
  PROCEDURE p_get_right_psecem(v_ordid    IN VARCHAR2,
                               v_compid   IN VARCHAR2,
                               v_mode     IN VARCHAR2,
                               v_ptstatus IN OUT VARCHAR2,
                               v_errcode  IN OUT VARCHAR2,
                               v_errmsg   IN OUT VARCHAR2) IS
    v_startidx NUMBER(4);
    v_endidx   NUMBER(4);
    v_checkstr VARCHAR2(32);
    v_repcode  VARCHAR2(2);
  BEGIN
    SELECT MAX(port_status), MAX(err_code), MAX(to_char(err_msg))
      INTO v_ptstatus, v_errcode, v_errmsg
      FROM scm_interface.t_ordered_itf
     WHERE order_id = v_ordid
       AND company_id = v_compid;
  
    IF v_mode = 'GR' AND v_ptstatus = 'ER' AND instr(v_errcode, 'G') > 0 THEN
      v_checkstr := '货号缺失:';
      v_repcode  := 'G';
    ELSIF v_mode = 'SR' AND v_ptstatus = 'ER' AND instr(v_errcode, 'S') > 0 THEN
      v_checkstr := '供应商缺失:';
      v_repcode  := 'S';
    END IF;
  
    v_startidx := instr(v_errmsg, v_checkstr);
    v_endidx   := instr(v_errmsg, ' ', v_startidx, 1);
    IF v_startidx = 1 AND v_endidx = length(v_errmsg) THEN
      v_ptstatus := 'SP';
      v_errcode  := '';
      v_errmsg   := '';
    ELSE
      v_ptstatus := 'ER';
      v_errcode  := REPLACE(v_errcode, v_repcode, '');
      v_errmsg   := REPLACE(v_errmsg,
                            substr(v_errmsg, v_startidx, v_endidx),
                            '');
    END IF;
  END p_get_right_psecem;

  /*=================================================================================
  
    刷新供应商缺失订单数据（一天一次）
  
    说明：
      用于刷新供应商缺失订单数据（一天一次）
  
    版本：
      2022-06-30 : ORDERED 订单接口重构
  
  =================================================================================*/
  PROCEDURE p_upd_orditf_psecem(v_ordid    IN VARCHAR2,
                                v_compid   IN VARCHAR2,
                                v_ptstatus IN VARCHAR2,
                                v_errcode  IN VARCHAR2,
                                v_errmsg   IN CLOB) IS
  
  BEGIN
    --更新
    UPDATE scm_interface.t_ordered_itf
       SET port_status = v_ptstatus,
           err_code    = v_errcode,
           err_msg     = v_errmsg
     WHERE order_id = v_ordid
       AND company_id = v_compid;
  
    UPDATE scm_interface.t_orders_itf
       SET port_status = v_ptstatus,
           err_code    = v_errcode,
           err_msg     = v_errmsg
     WHERE order_id = v_ordid
       AND company_id = v_compid;
  
    UPDATE scm_interface.t_ordersitem_itf
       SET port_status = v_ptstatus,
           err_code    = v_errcode,
           err_msg     = v_errmsg
     WHERE order_id = v_ordid
       AND company_id = v_compid;
  END p_upd_orditf_psecem;

  /*=================================================================================
  
    刷新供应商缺失订单数据（一天一次）
  
    说明：
      用于刷新供应商缺失订单数据（一天一次）
  
    版本：
      2022-06-30 : ORDERED 订单接口重构
      2022-09-05 : 重构，由供应商更新带动错误数据同步变更为
                   错误数据反查供应商档案，从而完成更新
  
  =================================================================================*/
  PROCEDURE p_refresh_supmiss_itfdata IS
    v_ptstatus VARCHAR2(8);
    v_errcode  VARCHAR2(8);
    v_errmsg   CLOB;
  BEGIN
    FOR i IN (SELECT order_id, company_id, misssup
                FROM (SELECT x.order_id,
                             x.company_id,
                             (to_char(substr(x.err_msg,
                                             instr(x.err_msg, '供应商缺失:') + 6,
                                             instr(x.err_msg,
                                                   ' ',
                                                   instr(x.err_msg,
                                                         '供应商缺失:'),
                                                   1) -
                                             instr(x.err_msg, '供应商缺失:') - 6))) misssup
                        FROM scm_interface.t_ordered_itf x
                       WHERE x.port_status = 'ER'
                         AND instr(x.err_code, 'S') > 0
                         AND x.err_msg IS NOT NULL) tmp
               WHERE EXISTS (SELECT 1
                        FROM scmdata.t_supplier_info
                       WHERE inside_supplier_code = tmp.misssup
                         AND company_id = tmp.company_id
                         AND status = 1)) LOOP
      --更新 PORT_STATUS, ERR_CODE, ERR_MSG
      scmdata.pkg_port_sync.p_get_right_psecem(v_ordid    => i.order_id,
                                               v_compid   => i.company_id,
                                               v_mode     => 'SR',
                                               v_ptstatus => v_ptstatus,
                                               v_errcode  => v_errcode,
                                               v_errmsg   => v_errmsg);
    
      scmdata.pkg_port_sync.p_upd_orditf_psecem(v_ordid    => i.order_id,
                                                v_compid   => i.company_id,
                                                v_ptstatus => v_ptstatus,
                                                v_errcode  => v_errcode,
                                                v_errmsg   => v_errmsg);
    END LOOP;
  END p_refresh_supmiss_itfdata;

  /*=================================================================================
  
    刷新商品档案缺失订单数据（一天一次）
  
    说明：
      用于商品档案缺失订单数据（一天一次）
  
    版本：
      2022-06-30 : ORDERED 订单接口重构
      2022-09-05 : 重构，由商品档案更新带动错误数据同步变更为
                   错误数据反查商品档案，从而完成更新
  
  =================================================================================*/
  PROCEDURE p_refresh_goomiss_itfdata IS
    v_ptstatus VARCHAR2(8);
    v_errcode  VARCHAR2(8);
    v_errmsg   CLOB;
  BEGIN
    FOR i IN (SELECT order_id, company_id, missgoo
                FROM (SELECT x.order_id,
                             x.company_id,
                             (to_char(substr(x.err_msg,
                                             instr(x.err_msg, '货号缺失:') + 5,
                                             instr(x.err_msg,
                                                   ' ',
                                                   instr(x.err_msg, '货号缺失:'),
                                                   1) -
                                             instr(x.err_msg, '货号缺失:') - 5))) missgoo
                        FROM scm_interface.t_ordered_itf x
                       WHERE x.port_status = 'ER'
                         AND instr(x.err_code, 'G') > 0
                         AND x.err_msg IS NOT NULL) tmp
               WHERE EXISTS (SELECT 1
                        FROM scmdata.t_commodity_info
                       WHERE rela_goo_id = tmp.missgoo
                         AND company_id = tmp.company_id)) LOOP
      --更新 PORT_STATUS, ERR_CODE, ERR_MSG
      scmdata.pkg_port_sync.p_get_right_psecem(v_ordid    => i.order_id,
                                               v_compid   => i.company_id,
                                               v_mode     => 'GR',
                                               v_ptstatus => v_ptstatus,
                                               v_errcode  => v_errcode,
                                               v_errmsg   => v_errmsg);
    
      scmdata.pkg_port_sync.p_upd_orditf_psecem(v_ordid    => i.order_id,
                                                v_compid   => i.company_id,
                                                v_ptstatus => v_ptstatus,
                                                v_errcode  => v_errcode,
                                                v_errmsg   => v_errmsg);
    END LOOP;
  END p_refresh_goomiss_itfdata;

  /*=================================================================================
  
    ORDERCHANGE 接口数据插入 SCMDATA.T_ORDERCHANGE 表
  
    说明：
      用于获取主数据 NSFDATA.ORDERCHANGE 数据，并将数据直接插入
      SCMDATA.T_ORDERCHANGE 表，校验不通过则插入日志表：SCMDATA.T_ORDER_INTERFACE_ERR
  
    入参：
      V_INPCNO           :  变更单号
      V_INCHANGETYPE     :  变更类型代号
      V_INORDID          :  订单号
      V_INOLDNEEDDATE    :  旧交货日期
      V_INNEWNEEDDATE    :  新交货日期
      V_INOLDINPRICE     :  旧单价
      V_INNEWINPRICE     :  新单价
      V_INOLDSUPPLIER    :  旧供应商，供应商编码不存在于系统则单据不进入系统
      V_INNEWSUPPLIER    :  新供应商，供应商编码不存在于系统则单据不进入系统
      V_INOLDLOC         :  旧收货仓库
      V_INNEWLOC         :  新收货仓库
      V_INOLDSENDBYSUP   :  旧供应商代发
      V_INNEWSENDBYSUP   :  新供应商代发
      V_INREASON         :  变更原因
      V_INMEMO           :  备注
      V_INBARCODE        :  条码
      V_INAPPROVEDBY     :  批准人
      V_INAPPROVEDATE    :  批准日期
      V_INBRAID          :  分部
      V_INGOOID          :  货号，货号不存在于系统则单据不进入系统
      V_INCOMPID         :  数据归属企业Id
  
     版本：
       2021-10-15之前: 仓库变更接入
       2021-10-18: 当交期变更的变更原因，备注接入后，修改生产跟进表：
                   延期问题分类、延期问题原因、延期问题细分、问题描述字段
  
  =================================================================================*/
  PROCEDURE p_orderchange_insert_execute(v_inpcno         IN NUMBER,
                                         v_inchangetype   IN VARCHAR2,
                                         v_inordid        IN VARCHAR2,
                                         v_inoldneeddate  IN VARCHAR2,
                                         v_innewneeddate  IN VARCHAR2,
                                         v_inoldinprice   IN NUMBER,
                                         v_innewinprice   IN NUMBER,
                                         v_inoldsupplier  IN VARCHAR2,
                                         v_innewsupplier  IN VARCHAR2,
                                         v_inoldloc       IN VARCHAR2,
                                         v_innewloc       IN VARCHAR2,
                                         v_inoldsendbysup IN NUMBER,
                                         v_innewsendbysup IN NUMBER,
                                         v_inapprovedby   IN VARCHAR2,
                                         v_inapprovedate  IN VARCHAR2,
                                         v_inmemo         IN VARCHAR2,
                                         v_inreason       IN VARCHAR2,
                                         v_inbraid        IN VARCHAR2,
                                         v_ingooid        IN VARCHAR2,
                                         v_incompid       IN VARCHAR2) IS
    v_jugnum NUMBER(4);
    v_oldsup VARCHAR2(32);
    v_newsup VARCHAR2(32);
    v_gooid  VARCHAR2(32);
    v_exesql VARCHAR2(4000);
    v_orcols VARCHAR2(512);
    v_orvals VARCHAR2(2048);
    v_msg    VARCHAR2(512);
    v_type   VARCHAR2(4);
    v_ev     VARCHAR2(128);
    v_du     VARCHAR2(512);
  BEGIN
    SELECT COUNT(1)
      INTO v_jugnum
      FROM scmdata.t_orderchange
     WHERE company_id = v_incompid
       AND pc_no = v_inpcno;
  
    --当 ORDERCHANGE 没有该数据时
    IF v_jugnum = 0 AND v_inpcno IS NOT NULL THEN
      SELECT MAX(goo_id)
        INTO v_gooid
        FROM scmdata.t_commodity_info
       WHERE rela_goo_id = v_ingooid
         AND company_id = v_incompid;
    
      v_du := 'PC_NO = ''' || v_inpcno || '''';
    
      --当类型为供应商变更时
      IF v_inchangetype = 'SC' AND v_jugnum = 0 THEN
        SELECT MAX(supplier_code)
          INTO v_oldsup
          FROM scmdata.t_supplier_info
         WHERE company_id = v_incompid
           AND inside_supplier_code = v_inoldsupplier;
      
        SELECT MAX(supplier_code)
          INTO v_newsup
          FROM scmdata.t_supplier_info
         WHERE company_id = v_incompid
           AND inside_supplier_code = v_innewsupplier;
      
        --当商品档案存在
        IF v_gooid IS NOT NULL THEN
          --当旧供应商档案和新供应商档案都存在
          IF (v_inoldsupplier IS NULL OR v_oldsup IS NOT NULL) AND
             v_newsup IS NOT NULL THEN
            v_orcols := 'OC_ID,COMPANY_ID,PC_NO,CHANGE_TYPE,ORD_ID,OLDSUPPLIER,NEWSUPPLIER,' ||
                        'APPROVED_BY,APPROVE_DATE,BRA_ID,GOO_ID,STATUS';
          
            v_orvals := 'SCMDATA.F_GET_UUID(),''' || v_incompid || ''',' ||
                        v_inpcno || ',''' || v_inchangetype || ''',''' ||
                        v_inordid || ''',''' || v_oldsup || ''',''' ||
                        v_newsup || ''',''' || v_inapprovedby ||
                        ''',TO_DATE(''' || v_inapprovedate ||
                        ''',''YYYY-MM-DD HH24-MI-SS''),''' || v_inbraid ||
                        ''',''' || v_gooid || ''',''0''';
          
            v_exesql := 'INSERT INTO SCMDATA.T_ORDERCHANGE (' || v_orcols ||
                        ') VALUES (' || v_orvals || ')';
            --当旧供应商档案和新供应商档案只有一个存在
          ELSIF (v_oldsup IS NULL AND v_newsup IS NOT NULL AND
                v_inoldsupplier IS NOT NULL) OR
                ((v_inoldsupplier IS NULL OR v_oldsup IS NOT NULL) AND
                v_newsup IS NULL) THEN
            --当新供应商档案存在
            IF v_oldsup IS NULL THEN
              v_type   := 'OSM';
              v_msg    := '系统旧供应商缺失:' || v_inoldsupplier;
              v_ev     := '' || v_inoldsupplier;
              v_orcols := 'OC_ID,COMPANY_ID,PC_NO,CHANGE_TYPE,ORD_ID,NEWSUPPLIER,' ||
                          'APPROVED_BY,APPROVE_DATE,BRA_ID,GOO_ID,STATUS';
              v_orvals := 'SCMDATA.F_GET_UUID(),''' || v_incompid || ''',' ||
                          v_inpcno || ',''' || v_inchangetype || ''',''' ||
                          v_inordid || ''',''' || v_newsup || ''',''' ||
                          v_inapprovedby || ''',TO_DATE(''' ||
                          v_inapprovedate ||
                          ''',''yyyy-MM-dd HH24-mi-ss''),''' || v_inbraid ||
                          ''',''' || v_gooid || ''',''0''';
            ELSE
              v_type   := 'NSM';
              v_msg    := '系统新供应商缺失:' || v_innewsupplier;
              v_ev     := '' || v_innewsupplier;
              v_orcols := 'OC_ID,COMPANY_ID,PC_NO,CHANGE_TYPE,ORD_ID,OLDSUPPLIER,' ||
                          'APPROVED_BY,APPROVE_DATE,BRA_ID,GOO_ID,STATUS';
              v_orvals := 'SCMDATA.F_GET_UUID(),''' || v_incompid || ''',' ||
                          v_inpcno || ',''' || v_inchangetype || ''',''' ||
                          v_inordid || ''',''' || v_oldsup || ''',''' ||
                          v_inapprovedby || ''',TO_DATE(''' ||
                          v_inapprovedate ||
                          ''',''yyyy-MM-dd HH24-mi-ss''),''' || v_inbraid ||
                          ''',''' || v_gooid || ''',''0''';
            END IF;
            v_exesql := 'INSERT INTO SCMDATA.T_ORDER_INTERFACE_ERR' ||
                        '(OPE_ID,COMPANY_ID,ERR_TYPE,ERR_TIME,ERR_MSG,' ||
                        'INS_TAB,INS_NESCOL,INS_NESVAL,DATA_UNQ,ERR_VAL,IS_RETRANS) ' ||
                        'VALUES (SCMDATA.F_GET_UUID(),''' || v_incompid ||
                        ''',q''{' || v_type || '}'',SYSDATE,q''{' || v_msg ||
                        '}'',''SCMDATA.T_ORDERCHANGE'',q''{' || v_orcols ||
                        '}'',q''{' || v_orvals || '}'',q''{' || v_du ||
                        '}'',q''{' || v_ev || '}'',0)';
            --当旧供应商档案和新供应商档案都不存在
          ELSIF v_oldsup IS NULL AND v_newsup IS NULL AND
                v_inoldsupplier IS NOT NULL THEN
            v_type   := 'DSM';
            v_msg    := '双重系统供应商缺失:' || v_inoldsupplier || ';' ||
                        v_innewsupplier || ';';
            v_ev     := '' || v_inoldsupplier || ';' || v_innewsupplier || ';';
            v_orcols := 'OC_ID,COMPANY_ID,PC_NO,CHANGE_TYPE,ORD_ID,' ||
                        'APPROVED_BY,APPROVE_DATE,BRA_ID,GOO_ID,STATUS';
            v_orvals := 'SCMDATA.F_GET_UUID(),''' || v_incompid || ''',' ||
                        v_inpcno || ',''' || v_inchangetype || ''',''' ||
                        v_inordid || ''',''' || v_inapprovedby ||
                        ''',TO_DATE(''' || v_inapprovedate ||
                        ''',''yyyy-MM-dd HH24-mi-ss''),''' || v_inbraid ||
                        ''',''' || v_gooid || ''',''0''';
            v_exesql := 'INSERT INTO SCMDATA.T_ORDER_INTERFACE_ERR' ||
                        '(OPE_ID,COMPANY_ID,ERR_TYPE,ERR_TIME,ERR_MSG,' ||
                        'INS_TAB,INS_NESCOL,INS_NESVAL,DATA_UNQ,ERR_VAL,IS_RETRANS) ' ||
                        'VALUES (SCMDATA.F_GET_UUID(),''' || v_incompid ||
                        ''',q''{' || v_type || '}'',SYSDATE,q''{' || v_msg ||
                        '}'',''SCMDATA.T_ORDERCHANGE'',q''{' || v_orcols ||
                        '}'',q''{' || v_orvals || '}'',q''{' || v_du ||
                        '}'',q''{' || v_ev || '}'',0)';
          END IF;
        ELSE
          --当旧供应商档案和新供应商档案都存在
          IF v_oldsup IS NOT NULL AND v_newsup IS NOT NULL THEN
            v_type   := 'GOM';
            v_msg    := '系统货号缺失:' || v_ingooid;
            v_ev     := '' || v_ingooid;
            v_orcols := 'OC_ID,COMPANY_ID,PC_NO,CHANGE_TYPE,ORD_ID,OLDSUPPLIER,OLDSUPPLIER,' ||
                        'NEWSUPPLIER,APPROVED_BY,APPROVE_DATE,BRA_ID,STATUS';
            v_orvals := 'SCMDATA.F_GET_UUID(),''' || v_incompid || ''',' ||
                        v_inpcno || ',''' || v_inchangetype || ''',''' ||
                        v_inordid || ''',''' || v_oldsup || ''',''' ||
                        v_newsup || ''',''' || v_inapprovedby ||
                        ''',TO_DATE(''' || v_inapprovedate ||
                        ''',''yyyy-MM-dd HH24-mi-ss''),''' || v_inbraid ||
                        ''',''0''';
            v_exesql := 'INSERT INTO SCMDATA.T_ORDER_INTERFACE_ERR' ||
                        '(OPE_ID,COMPANY_ID,ERR_TYPE,ERR_TIME,ERR_MSG,' ||
                        'INS_TAB,INS_NESCOL,INS_NESVAL,DATA_UNQ,ERR_VAL,IS_RETRANS) ' ||
                        'VALUES (SCMDATA.F_GET_UUID(),''' || v_incompid ||
                        ''',q''{' || v_type || '}'',SYSDATE,q''{' || v_msg ||
                        '}'',''SCMDATA.T_ORDERCHANGE'',q''{' || v_orcols ||
                        '}'',q''{' || v_orvals || '}'',q''{' || v_du ||
                        '}'',q''{' || v_ev || '}'',0)';
            --当旧供应商档案和新供应商档案只有一个存在
          ELSIF (v_oldsup IS NULL AND v_newsup IS NOT NULL) OR
                (v_oldsup IS NOT NULL AND v_newsup IS NULL) THEN
            --当新供应商档案存在
            IF v_oldsup IS NULL THEN
              v_type   := 'GOSM';
              v_msg    := '系统货号:' || v_ingooid || ' 旧供应商缺失:' ||
                          v_inoldsupplier;
              v_ev     := '' || v_ingooid || ';' || v_inoldsupplier || ';';
              v_orcols := 'OC_ID,COMPANY_ID,PC_NO,CHANGE_TYPE,ORD_ID,NEWSUPPLIER,' ||
                          'APPROVED_BY,APPROVE_DATE,BRA_ID,STATUS';
              v_orvals := 'SCMDATA.F_GET_UUID(),''' || v_incompid || ''',' ||
                          v_inpcno || ',''' || v_inchangetype || ''',''' ||
                          v_inordid || ''',''' || v_newsup || ''',''' ||
                          v_inapprovedby || ''',TO_DATE(''' ||
                          v_inapprovedate ||
                          ''',''yyyy-MM-dd HH24-mi-ss''),''' || v_inbraid ||
                          ''',''0''';
            ELSE
              v_type   := 'GNSM';
              v_msg    := '系统货号:' || v_ingooid || ' 新供应商缺失:' ||
                          v_innewsupplier;
              v_ev     := '' || v_innewsupplier;
              v_orcols := 'OC_ID,COMPANY_ID,PC_NO,CHANGE_TYPE,ORD_ID,OLDSUPPLIER,' ||
                          'APPROVED_BY,APPROVE_DATE,BRA_ID,STATUS';
              v_orvals := 'SCMDATA.F_GET_UUID(),''' || v_incompid || ''',' ||
                          v_inpcno || ',''' || v_inchangetype || ''',''' ||
                          v_inordid || ''',''' || v_oldsup || ''',''' ||
                          v_inapprovedby || ''',TO_DATE(''' ||
                          v_inapprovedate ||
                          ''',''yyyy-MM-dd HH24-mi-ss''),''' || v_inbraid ||
                          ''',''0''';
            END IF;
            v_exesql := 'INSERT INTO SCMDATA.T_ORDER_INTERFACE_ERR' ||
                        '(OPE_ID,COMPANY_ID,ERR_TYPE,ERR_TIME,ERR_MSG,' ||
                        'INS_TAB,INS_NESCOL,INS_NESVAL,DATA_UNQ,ERR_VAL,IS_RETRANS) ' ||
                        'VALUES (SCMDATA.F_GET_UUID(),''' || v_incompid ||
                        ''',q''{' || v_type || '}'',SYSDATE,q''{' || v_msg ||
                        '}'',''SCMDATA.T_ORDERCHANGE'',q''{' || v_orcols ||
                        '}'',q''{' || v_orvals || '}'',q''{' || v_du ||
                        '}'',q''{' || v_ev || '}'',0)';
            --当旧供应商档案和新供应商档案都不存在
          ELSIF v_oldsup IS NULL AND v_newsup IS NULL THEN
            v_type   := 'GDSM';
            v_msg    := '系统货号:' || v_ingooid || ' 双重供应商缺失:' ||
                        v_inoldsupplier || ';' || v_innewsupplier || ';';
            v_ev     := '' || v_ingooid || ';' || v_inoldsupplier || ';' ||
                        v_innewsupplier || ';';
            v_orcols := 'OC_ID,COMPANY_ID,PC_NO,CHANGE_TYPE,ORD_ID,' ||
                        'APPROVED_BY,APPROVE_DATE,BRA_ID,STATUS';
            v_orvals := 'SCMDATA.F_GET_UUID(),''' || v_incompid || ''',' ||
                        v_inpcno || ',''' || v_inchangetype || ''',''' ||
                        v_inordid || ''',''' || v_inapprovedby ||
                        ''',TO_DATE(''' || v_inapprovedate ||
                        ''',''yyyy-MM-dd HH24-mi-ss''),''' || v_inbraid ||
                        ''',''0''';
            v_exesql := 'INSERT INTO SCMDATA.T_ORDER_INTERFACE_ERR' ||
                        '(OPE_ID,COMPANY_ID,ERR_TYPE,ERR_TIME,ERR_MSG,' ||
                        'INS_TAB,INS_NESCOL,INS_NESVAL,DATA_UNQ,ERR_VAL,IS_RETRANS) ' ||
                        'VALUES (SCMDATA.F_GET_UUID(),''' || v_incompid ||
                        ''',q''{' || v_type || '}'',SYSDATE,q''{' || v_msg ||
                        '}'',''SCMDATA.T_ORDERCHANGE'',q''{' || v_orcols ||
                        '}'',q''{' || v_orvals || '}'',q''{' || v_du ||
                        '}'',q''{' || v_ev || '}'',0)';
          END IF;
        END IF;
        --当类型为单价变更，且商品档案存在
      ELSIF v_inchangetype = 'PR' AND v_jugnum = 0 AND v_gooid IS NOT NULL THEN
        v_orcols := 'OC_ID,COMPANY_ID,PC_NO,CHANGE_TYPE,ORD_ID,OLDINPRICE,NEWINPRICE,' ||
                    'APPROVED_BY,APPROVE_DATE,BRA_ID,GOO_ID,STATUS';
      
        v_orvals := 'SCMDATA.F_GET_UUID(),''' || v_incompid || ''',' ||
                    v_inpcno || ',''' || v_inchangetype || ''',''' ||
                    v_inordid || ''',' || v_inoldinprice || ',' ||
                    v_innewinprice || ',''' || v_inapprovedby ||
                    ''',TO_DATE(''' || v_inapprovedate ||
                    ''',''yyyy-MM-dd HH24-mi-ss''),''' || v_inbraid ||
                    ''',''' || v_gooid || ''',''0''';
      
        v_exesql := 'INSERT INTO SCMDATA.T_ORDERCHANGE (' || v_orcols ||
                    ') VALUES (' || v_orvals || ')';
        --当类型为单价变更，且商品档案不存在
      ELSIF v_inchangetype = 'PR' AND v_jugnum = 0 AND v_gooid IS NULL THEN
        v_type   := 'GOM';
        v_msg    := '系统货号缺失:' || v_ingooid;
        v_ev     := '' || v_ingooid;
        v_orcols := 'OC_ID,COMPANY_ID,PC_NO,CHANGE_TYPE,ORD_ID,OLDINPRICE,NEWINPRICE,' ||
                    'APPROVED_BY,APPROVE_DATE,BRA_ID,STATUS';
        v_orvals := 'SCMDATA.F_GET_UUID(),''' || v_incompid || ''',' ||
                    v_inpcno || ',''' || v_inchangetype || ''',''' ||
                    v_inordid || ''',''' || v_inoldinprice || ''',''' ||
                    v_innewinprice || ''',''' || v_inapprovedby ||
                    ''',TO_DATE(''' || v_inapprovedate ||
                    ''',''yyyy-MM-dd HH24-mi-ss''),''' || v_inbraid ||
                    ''',''0''';
        v_exesql := 'INSERT INTO SCMDATA.T_ORDER_INTERFACE_ERR' ||
                    '(OPE_ID,COMPANY_ID,ERR_TYPE,ERR_TIME,ERR_MSG,' ||
                    'INS_TAB,INS_NESCOL,INS_NESVAL,DATA_UNQ,ERR_VAL,IS_RETRANS) ' ||
                    'VALUES (SCMDATA.F_GET_UUID(),''' || v_incompid ||
                    ''',q''{' || v_type || '}'',SYSDATE,q''{' || v_msg ||
                    '}'',''SCMDATA.T_ORDERCHANGE'',q''{' || v_orcols ||
                    '}'',q''{' || v_orvals || '}'',q''{' || v_du ||
                    '}'',q''{' || v_ev || '}'',0)';
        --当类型为交期变更，且商品档案存在
      ELSIF v_inchangetype = 'DT' AND v_jugnum = 0 AND v_gooid IS NOT NULL THEN
        v_orcols := 'OC_ID,COMPANY_ID,PC_NO,CHANGE_TYPE,ORD_ID,OLDNEED_DATE,NEWNEED_DATE,' ||
                    'APPROVED_BY,APPROVE_DATE,BRA_ID,GOO_ID,STATUS,MEMO,REASON';
      
        v_orvals := 'SCMDATA.F_GET_UUID(),''' || v_incompid || ''',' ||
                    v_inpcno || ',''' || v_inchangetype || ''',''' ||
                    v_inordid || ''',TO_DATE(''' || v_inoldneeddate ||
                    ''',''yyyy-MM-dd HH24-mi-ss''),TO_DATE(''' ||
                    v_innewneeddate || ''',''yyyy-MM-dd HH24-mi-ss''),''' ||
                    v_inapprovedby || ''',TO_DATE(''' || v_inapprovedate ||
                    ''',''yyyy-MM-dd HH24-mi-ss''),''' || v_inbraid ||
                    ''',''' || v_gooid || ''',''0'',''' || v_inmemo ||
                    ''',''' || v_inreason || '''';
      
        v_exesql := 'INSERT INTO SCMDATA.T_ORDERCHANGE (' || v_orcols ||
                    ') VALUES (' || v_orvals || ')';
        --当类型为交期变更，且商品档案不存在
      ELSIF v_inchangetype = 'DT' AND v_jugnum = 0 AND v_gooid IS NULL THEN
        v_type   := 'GOM';
        v_msg    := '系统货号缺失:' || v_ingooid;
        v_ev     := '' || v_ingooid;
        v_orcols := 'OC_ID,COMPANY_ID,PC_NO,CHANGE_TYPE,ORD_ID,OLDNEED_DATE,NEWNEED_DATE,' ||
                    'APPROVED_BY,APPROVE_DATE,BRA_ID,STATUS,MEMO,REASON';
        v_orvals := 'SCMDATA.F_GET_UUID(),''' || v_incompid || ''',' ||
                    v_inpcno || ',''' || v_inchangetype || ''',''' ||
                    v_inordid || ''',TO_DATE(''' || v_inoldneeddate ||
                    ''',''yyyy-MM-dd HH24-mi-ss''),TO_DATE(''' ||
                    v_innewneeddate || ''',''yyyy-MM-dd HH24-mi-ss''),''' ||
                    v_inapprovedby || ''',TO_DATE(''' || v_inapprovedate ||
                    ''',''yyyy-MM-dd HH24-mi-ss''),''' || v_inbraid ||
                    ''',''0'',''' || v_inmemo || ''',''' || v_inreason || '''';
        v_exesql := 'INSERT INTO SCMDATA.T_ORDER_INTERFACE_ERR' ||
                    '(OPE_ID,COMPANY_ID,ERR_TYPE,ERR_TIME,ERR_MSG,' ||
                    'INS_TAB,INS_NESCOL,INS_NESVAL,DATA_UNQ,ERR_VAL,IS_RETRANS) ' ||
                    'VALUES (SCMDATA.F_GET_UUID(),''' || v_incompid ||
                    ''',q''{' || v_type || '}'',SYSDATE,q''{' || v_msg ||
                    '}'',''SCMDATA.T_ORDERCHANGE'',q''{' || v_orcols ||
                    '}'',q''{' || v_orvals || '}'',q''{' || v_du ||
                    '}'',q''{' || v_ev || '}'',0)';
        --当类型为仓库变更，且商品档案存在
      ELSIF v_inchangetype = 'WH' AND v_jugnum = 0 AND v_gooid IS NOT NULL THEN
        v_orcols := 'OC_ID,COMPANY_ID,PC_NO,CHANGE_TYPE,ORD_ID,OLDLOC,NEWLOC,' ||
                    'APPROVED_BY,APPROVE_DATE,BRA_ID,GOO_ID,STATUS';
      
        v_orvals := 'SCMDATA.F_GET_UUID(),''' || v_incompid || ''',' ||
                    v_inpcno || ',''' || v_inchangetype || ''',''' ||
                    v_inordid || ''',''' || v_inoldloc || ''',''' ||
                    v_innewloc || ''',''' || v_inapprovedby ||
                    ''',TO_DATE(''' || v_inapprovedate ||
                    ''',''yyyy-MM-dd HH24-mi-ss''),''' || v_inbraid ||
                    ''',''' || v_gooid || ''',''0''';
      
        v_exesql := 'INSERT INTO SCMDATA.T_ORDERCHANGE (' || v_orcols ||
                    ') VALUES (' || v_orvals || ')';
        --当类型为仓库变更，且商品档案不存在
      ELSIF v_inchangetype = 'WH' AND v_jugnum = 0 AND v_gooid IS NULL THEN
        v_type   := 'GOM';
        v_msg    := '系统货号缺失:' || v_ingooid;
        v_ev     := '' || v_ingooid;
        v_orcols := 'OC_ID,COMPANY_ID,PC_NO,CHANGE_TYPE,ORD_ID,OLDLOC,NEWLOC,' ||
                    'APPROVED_BY,APPROVE_DATE,BRA_ID,STATUS';
        v_orvals := 'SCMDATA.F_GET_UUID(),''' || v_incompid || ''',' ||
                    v_inpcno || ',''' || v_inchangetype || ''',''' ||
                    v_inordid || ''',''' || v_inoldloc || ''',''' ||
                    v_innewloc || ''',''' || v_inapprovedby ||
                    ''',TO_DATE(''' || v_inapprovedate ||
                    ''',''yyyy-MM-dd HH24-mi-ss''),''' || v_inbraid ||
                    ''',''0''';
        v_exesql := 'INSERT INTO SCMDATA.T_ORDER_INTERFACE_ERR' ||
                    '(OPE_ID,COMPANY_ID,ERR_TYPE,ERR_TIME,ERR_MSG,' ||
                    'INS_TAB,INS_NESCOL,INS_NESVAL,DATA_UNQ,ERR_VAL,IS_RETRANS) ' ||
                    'VALUES (SCMDATA.F_GET_UUID(),''' || v_incompid ||
                    ''',q''{' || v_type || '}'',SYSDATE,q''{' || v_msg ||
                    '}'',''SCMDATA.T_ORDERCHANGE'',q''{' || v_orcols ||
                    '}'',q''{' || v_orvals || '}'',q''{' || v_du ||
                    '}'',q''{' || v_ev || '}'',0)';
        --当类型为供应商代发变更，且商品档案存在
      ELSIF v_inchangetype = 'SD' AND v_jugnum = 0 AND v_gooid IS NOT NULL THEN
        v_orcols := 'OC_ID,COMPANY_ID,PC_NO,CHANGE_TYPE,ORD_ID,OLDSEND_BY_SUP,NEWSEND_BY_SUP,' ||
                    'APPROVED_BY,APPROVE_DATE,BRA_ID,GOO_ID,STATUS';
      
        v_orvals := 'SCMDATA.F_GET_UUID(),''' || v_incompid || ''',' ||
                    v_inpcno || ',''' || v_inchangetype || ''',''' ||
                    v_inordid || ''',' || v_inoldsendbysup || ',' ||
                    v_innewsendbysup || ',''' || v_inapprovedby ||
                    ''',TO_DATE(''' || v_inapprovedate ||
                    ''',''yyyy-MM-dd HH24-mi-ss''),''' || v_inbraid ||
                    ''',''' || v_gooid || ''',''0''';
      
        v_exesql := 'INSERT INTO SCMDATA.T_ORDERCHANGE (' || v_orcols ||
                    ') VALUES (' || v_orvals || ')';
        --当类型为供应商代发变更，且商品档案不存在
      ELSIF v_inchangetype = 'SD' AND v_jugnum = 0 AND v_gooid IS NULL THEN
        v_type   := 'GOM';
        v_msg    := '系统货号缺失:' || v_ingooid;
        v_ev     := '' || v_ingooid;
        v_orcols := 'OC_ID,COMPANY_ID,PC_NO,CHANGE_TYPE,ORD_ID,OLDSEND_BY_SUP,NEWSEND_BY_SUP,' ||
                    'APPROVED_BY,APPROVE_DATE,BRA_ID,STATUS';
        v_orvals := 'SCMDATA.F_GET_UUID(),''' || v_incompid || ''',' ||
                    v_inpcno || ',''' || v_inchangetype || ''',''' ||
                    v_inordid || ''',' || v_inoldsendbysup || ',' ||
                    v_innewsendbysup || ',''' || v_inapprovedby ||
                    ''',TO_DATE(''' || v_inapprovedate ||
                    ''',''yyyy-MM-dd HH24-mi-ss''),''' || v_inbraid ||
                    ''',''0''';
        v_exesql := 'INSERT INTO SCMDATA.T_ORDER_INTERFACE_ERR' ||
                    '(OPE_ID,COMPANY_ID,ERR_TYPE,ERR_TIME,ERR_MSG,' ||
                    'INS_TAB,INS_NESCOL,INS_NESVAL,DATA_UNQ,ERR_VAL,IS_RETRANS) ' ||
                    'VALUES (SCMDATA.F_GET_UUID(),''' || v_incompid ||
                    ''',q''{' || v_type || '}'',SYSDATE,q''{' || v_msg ||
                    '}'',''SCMDATA.T_ORDERCHANGE'',q''{' || v_orcols ||
                    '}'',q''{' || v_orvals || '}'',q''{' || v_du ||
                    '}'',q''{' || v_ev || '}'',0)';
      END IF;
    
      IF v_type IS NULL THEN
        EXECUTE IMMEDIATE v_exesql;
      ELSE
        SELECT COUNT(1)
          INTO v_jugnum
          FROM scmdata.t_order_interface_err
         WHERE ins_tab = 'SCMDATA.T_ORDERCHANGE'
           AND data_unq = v_du
           AND err_type = v_type;
      
        IF v_jugnum = 0 THEN
          EXECUTE IMMEDIATE v_exesql;
        END IF;
      END IF;
    END IF;
  EXCEPTION
    WHEN OTHERS THEN
      v_du     := 'ORDER_CODE = ''' || v_inordid || '''';
      v_type   := 'ESE';
      v_msg    := 'SQL执行错误';
      v_ev     := '' || v_inordid;
      v_exesql := 'INSERT INTO SCMDATA.T_ORDER_INTERFACE_ERR' ||
                  '(OPE_ID,COMPANY_ID,ERR_TYPE,ERR_TIME,ERR_MSG,' ||
                  'INS_TAB,INS_NESCOL,INS_NESVAL,DATA_UNQ,ERR_VAL,IS_RETRANS) ' ||
                  'VALUES (SCMDATA.F_GET_UUID(),''' || v_incompid ||
                  ''',q''{' || v_type || '}'',SYSDATE,q''{' || v_msg ||
                  '}'',''SCMDATA.T_ORDERCHANGE'',q''{' || v_orcols ||
                  '}'',q''{' || v_orvals || '}'',q''{' || v_du ||
                  '}'',q''{' || v_ev || '}'',0)';
      EXECUTE IMMEDIATE v_exesql;
  END p_orderchange_insert_execute;

  /*=================================================================================
  
    变更原因插入到 PRODUCTION_PROGRESS 表
  
    说明：
      用于获取主数据 NSFDATA.ORDERCHANGE 数据，并将数据直接插入
      SCMDATA.T_ORDERCHANGE 表，校验不通过则插入日志表：SCMDATA.T_ORDER_INTERFACE_ERR
  
    入参：
      V_ORDERID  :  订单号
      V_COMPID   :  企业Id
      V_GOOID    :  货号
      V_CGREASON :  修改原因
      V_PRODESC  :  问题描述
  
     版本：
       2021-10-15之前: 仓库变更接入
       2021-10-18: 当交期变更的变更原因，备注接入后，修改生产跟进表：
                   延期问题分类、延期问题原因、延期问题细分、问题描述字段，
                   供应商是否免责、责任部门1级、责任部门2级、是否质量问题
                   字段更新
  
  =================================================================================*/
  PROCEDURE p_change_reason_insert(v_orderid  IN VARCHAR2,
                                   v_compid   IN VARCHAR2,
                                   v_gooid    IN VARCHAR2,
                                   v_cgreason IN VARCHAR2,
                                   v_prodesc  IN VARCHAR2) IS
    v_pgid                    VARCHAR2(32);
    v_reasonstr               VARCHAR2(1024) := v_cgreason || '-';
    v_delay_problem_class_pr  VARCHAR2(128);
    v_delay_cause_class_pr    VARCHAR2(128);
    v_delay_cause_detailed_pr VARCHAR2(128);
    v_is_sup_exemption        NUMBER;
    v_first_dept_id           VARCHAR2(100);
    v_second_dept_id          VARCHAR2(100);
    v_is_quality              NUMBER;
    v_goodid                  VARCHAR2(32);
  BEGIN
    --赋值
    IF v_cgreason IS NOT NULL THEN
      v_delay_problem_class_pr  := substr(v_reasonstr,
                                          instr(v_reasonstr, ')') + 1,
                                          instr(v_reasonstr, '-', 1, 1) -
                                          instr(v_reasonstr, ')') - 1);
      v_delay_cause_class_pr    := substr(v_reasonstr,
                                          instr(v_reasonstr, '-', 1, 1) + 1,
                                          instr(v_reasonstr, '-', 1, 2) -
                                          instr(v_reasonstr, '-', 1, 1) - 1);
      v_delay_cause_detailed_pr := substr(v_reasonstr,
                                          instr(v_reasonstr, '-', 1, 2) + 1,
                                          instr(v_reasonstr, '-', 1, 3) -
                                          instr(v_reasonstr, '-', 1, 2) - 1);
    END IF;
  
    --获取 V_GOODID
    SELECT MAX(goo_id)
      INTO v_goodid
      FROM scmdata.t_commodity_info
     WHERE rela_goo_id = v_gooid
       AND company_id = v_compid;
  
    IF v_goodid IS NULL THEN
      v_goodid := v_gooid;
    END IF;
  
    --获取 PRODUCTION_PROGRESS_ID
    SELECT MAX(product_gress_id)
      INTO v_pgid
      FROM scmdata.t_production_progress
     WHERE delay_problem_class IS NULL
       AND order_id = v_orderid
       AND goo_id = v_goodid
       AND company_id = v_compid;
  
    IF v_prodesc IS NOT NULL AND v_delay_problem_class_pr IS NOT NULL AND
       v_delay_cause_class_pr IS NOT NULL AND
       v_delay_cause_detailed_pr IS NOT NULL THEN
      SELECT MAX(first_dept_id),
             MAX(second_dept_id),
             MAX(is_quality_problem),
             MAX(is_sup_exemption)
        INTO v_first_dept_id,
             v_second_dept_id,
             v_is_quality,
             v_is_sup_exemption
        FROM (SELECT MAX(ad.is_sup_exemption) is_sup_exemption,
                     MAX(ad.is_quality_problem) is_quality_problem,
                     MAX(ad.first_dept_id) first_dept_id,
                     MAX(ad.second_dept_id) second_dept_id,
                     MAX(ad.company_id) company_id
                FROM scmdata.t_commodity_info tc
               INNER JOIN scmdata.t_abnormal_range_config ar
                  ON tc.company_id = ar.company_id
                 AND tc.category = ar.industry_classification
                 AND tc.product_cate = ar.production_category
                 AND instr(';' || ar.product_subclass || ';',
                           ';' || tc.samll_category || ';') > 0
                 AND ar.pause = 0
               INNER JOIN scmdata.t_abnormal_dtl_config ad
                  ON ar.company_id = ad.company_id
                 AND ar.abnormal_config_id = ad.abnormal_config_id
                 AND ad.pause = 0
               INNER JOIN scmdata.t_abnormal_config ab
                  ON ab.company_id = ad.company_id
                 AND ab.abnormal_config_id = ad.abnormal_config_id
                 AND ab.pause = 0
               WHERE tc.company_id = v_compid
                 AND tc.goo_id = v_goodid
                 AND ad.anomaly_classification = 'AC_DATE'
                 AND ad.problem_classification = v_delay_problem_class_pr
                 AND ad.cause_classification = v_delay_cause_class_pr
                 AND ad.cause_detail = v_delay_cause_detailed_pr);
    
      IF v_first_dept_id IS NOT NULL THEN
        UPDATE scmdata.t_production_progress t
           SET t.delay_problem_class  = v_delay_problem_class_pr,
               t.delay_cause_class    = v_delay_cause_class_pr,
               t.delay_cause_detailed = v_delay_cause_detailed_pr,
               t.problem_desc         = nvl(v_prodesc, ' '),
               t.is_sup_responsible   = v_is_sup_exemption,
               t.responsible_dept     = v_first_dept_id,
               t.responsible_dept_sec = v_second_dept_id,
               t.is_quality           = v_is_quality,
               t.is_order_reamem_upd  = 1
         WHERE t.product_gress_id = v_pgid;
      END IF;
    END IF;
  END p_change_reason_insert;

  /*=================================================================================
  
    订单结束时间进入接口表
  
    说明：
      用于获取主数据 NSFDATA.ORDERED 数据的结束时间数据，并将数据直接插入
      SCM_INTERFACE.T_ORD_FINISHTIME_ITF 表，如果存在则更新 FINISH_TIME 字段，
      如果不存在则新增记录
  
    入参：
      V_ORDID   :  订单
      V_COMPID  :  企业Id
      V_FTIME   :  结束时间，格式 YYYY-MM-DD HH24-MI-SS
  
     版本：
       2022-06-08: 订单结束时间进入接口表
  
  =================================================================================*/
  PROCEDURE p_iu_ord_finishtime_itf(v_ordid  IN VARCHAR2,
                                    v_compid IN VARCHAR2,
                                    v_ftime  IN VARCHAR2) IS
    v_jugnum NUMBER(1);
  BEGIN
    IF v_ordid IS NOT NULL THEN
      SELECT COUNT(1)
        INTO v_jugnum
        FROM scm_interface.t_ord_finishtime_itf
       WHERE order_id = v_ordid
         AND company_id = v_compid
         AND rownum = 1;
    
      IF v_jugnum = 0 THEN
        INSERT INTO scm_interface.t_ord_finishtime_itf
          (order_id,
           company_id,
           finish_time,
           port_obj,
           port_time,
           port_status)
        VALUES
          (v_ordid, v_compid, v_ftime, 'ord_finishtime_itf', SYSDATE, 'SP');
      ELSE
        UPDATE scm_interface.t_ord_finishtime_itf
           SET finish_time = v_ftime,
               port_obj    = 'ord_finishtime_itf',
               port_time   = SYSDATE,
               port_status = 'SP'
         WHERE order_id = v_ordid
           AND company_id = v_compid;
      END IF;
    END IF;
  END p_iu_ord_finishtime_itf;

  /*=================================================================================
  
    订单结束时间同步
  
    说明：
      用于将 SCM_INTERFACE.T_ORD_FINISHTIME_ITF 结束时间同步到 SCMDATA.T_ORDERED
  
     版本：
       2022-06-08: 订单结束时间同步
  
  =================================================================================*/
  PROCEDURE p_ord_finishtime_sync IS
    v_ordid  VARCHAR2(32);
    v_compid VARCHAR2(32);
    v_rtnum  NUMBER(2);
  BEGIN
    FOR i IN (SELECT order_id, company_id, finish_time
                FROM scm_interface.t_ord_finishtime_itf itf
               WHERE port_status IN ('SP', 'ER')
                 AND EXISTS (SELECT 1
                        FROM scmdata.t_ordered
                       WHERE order_code = itf.order_id
                         AND company_id = itf.company_id)) LOOP
      BEGIN
        v_ordid  := i.order_id;
        v_compid := i.company_id;
      
        UPDATE scmdata.t_ordered
           SET finish_time = to_date(i.finish_time, 'YYYY-MM-DD HH24-MI-SS')
         WHERE order_code = i.order_id
           AND company_id = i.company_id;
      
        UPDATE scm_interface.t_ord_finishtime_itf
           SET port_status = 'SS'
         WHERE order_id = i.order_id
           AND company_id = i.company_id;
      EXCEPTION
        WHEN OTHERS THEN
          SELECT MAX(retry_num)
            INTO v_rtnum
            FROM scm_interface.t_ord_finishtime_itf
           WHERE order_id = v_ordid
             AND company_id = v_compid;
        
          IF v_rtnum <= 3 THEN
            UPDATE scm_interface.t_ord_finishtime_itf tmp
               SET port_status = 'ER',
                   retry_num   = tmp.retry_num + 1,
                   err_msg     = 'FORMAT_ERROR_BACKTRACE:' ||
                                 dbms_utility.format_error_backtrace ||
                                 chr(10) || 'FORMAT_ERROR_STACK:' ||
                                 dbms_utility.format_error_stack || chr(10) ||
                                 'FORMAT_CALL_STACK:' ||
                                 dbms_utility.format_call_stack
             WHERE order_id = v_ordid
               AND company_id = v_compid;
          ELSE
            UPDATE scm_interface.t_ord_finishtime_itf tmp
               SET port_status = 'RW', --retry_wrong
                   retry_num   = tmp.retry_num + 1,
                   err_msg     = 'FORMAT_ERROR_BACKTRACE:' ||
                                 dbms_utility.format_error_backtrace ||
                                 chr(10) || 'FORMAT_ERROR_STACK:' ||
                                 dbms_utility.format_error_stack || chr(10) ||
                                 'FORMAT_CALL_STACK:' ||
                                 dbms_utility.format_call_stack
             WHERE order_id = v_ordid
               AND company_id = v_compid;
          END IF;
      END;
    END LOOP;
  END p_ord_finishtime_sync;

  /*=================================================================================
  
    通过订单追加Qa报告关联维度表仓库字段
  
    入参：
      v_inp_ordid   :  订单号
      v_inp_compid  :  企业Id
  
     版本：
       2023-02-22_zc314 : 通过订单追加Qa报告关联维度表仓库字段
  
  =================================================================================*/
  PROCEDURE p_append_qareprela_shoid_by_ordid(v_inp_ordid  IN VARCHAR2,
                                              v_inp_compid IN VARCHAR2) IS
    v_repshoid VARCHAR2(64);
    v_qarepid  VARCHAR2(32);
    v_compid   VARCHAR2(32);
    v_sql      CLOB;
  BEGIN
    FOR i IN (SELECT qa_report_id, company_id, order_id, sho_id
                FROM scmdata.t_qa_report_relainfodim
               WHERE instr(order_id, v_inp_ordid) > 0
                 AND company_id = v_inp_compid) LOOP
      BEGIN
        v_qarepid := i.qa_report_id;
        v_compid  := i.company_id;
      
        SELECT listagg(DISTINCT sho_id, ';')
          INTO v_repshoid
          FROM scmdata.t_ordered
         WHERE instr(i.order_id, order_id) > 0
           AND company_id = i.company_id;
      
        v_sql := 'UPDATE scmdata.t_qa_report_relainfodim
         SET sho_id = :v_repshoid
       WHERE qa_report_id = :v_qarepid
         AND company_id = :v_compid';
      
        EXECUTE IMMEDIATE v_sql
          USING v_repshoid, v_qarepid, v_compid;
      EXCEPTION
        WHEN OTHERS THEN
          CONTINUE;
      END;
    END LOOP;
  END p_append_qareprela_shoid_by_ordid;

  /*=================================================================================
  
    ORDERCHANGE 单价变更逻辑
  
    说明：
      用于修改 SCMDATA.T_ORDERS.ORDER_PRICE 为新值
  
    入参：
      V_ORDERID   :  订单
      V_COMPID    :  企业Id
      V_GOOID     :  商品档案编号
      V_OLDPRICE  :  旧单价
      V_NEWPRICE  :  新单价
  
    返回值:
      1 正常，2 异常
  
     版本：
       2021-10-15: 已完成基本单价变更
  
  =================================================================================*/
  FUNCTION f_orderchange_pr_sync(v_orderid  IN VARCHAR2,
                                 v_compid   IN VARCHAR2,
                                 v_gooid    IN VARCHAR2,
                                 v_oldprice IN NUMBER,
                                 v_newprice IN NUMBER) RETURN NUMBER IS
    v_exesql VARCHAR2(1024);
  BEGIN
    --单价变更
    v_exesql := 'UPDATE SCMDATA.T_ORDERS Z SET ORDER_PRICE = :A WHERE ORDER_ID = :B AND COMPANY_ID = :C AND GOO_ID = :D AND ORDER_PRICE = :E AND EXISTS (SELECT 1 FROM SCMDATA.T_ORDERED WHERE ORDER_CODE = Z.ORDER_ID AND COMPANY_ID = Z.COMPANY_ID AND ORDER_STATUS = ''OS01'')';
    EXECUTE IMMEDIATE v_exesql
      USING v_newprice, v_orderid, v_compid, v_gooid, v_oldprice;
  
    v_exesql := 'UPDATE SCMDATA.T_DEDUCTION Z SET DISCOUNT_UNIT_PRICE = :A WHERE ORDER_ID = :B AND COMPANY_ID = :C AND DISCOUNT_UNIT_PRICE = :D AND EXISTS (SELECT 1 FROM SCMDATA.T_ORDERED WHERE ORDER_CODE = Z.ORDER_ID AND COMPANY_ID = Z.COMPANY_ID AND ORDER_STATUS = ''OS01'')';
    EXECUTE IMMEDIATE v_exesql
      USING v_newprice, v_orderid, v_compid, v_oldprice;
  
    --单据状态正常
    RETURN 1;
  
    --异常
  EXCEPTION
    WHEN OTHERS THEN
      RETURN 2;
    
  END f_orderchange_pr_sync;

  /*=================================================================================
  
    ORDERCHANGE 交期变更逻辑
  
    说明：
      用于修改 SCMDATA.T_ORDERS.DELIVERY_DATE 为新值
  
    入参：
      V_ORDERID   :  订单
      V_COMPID    :  企业Id
      V_GOOID     :  商品档案编号
      V_OLDPRICE  :  旧单价
      V_NEWPRICE  :  新单价
  
    返回值:
      1 正常，2 异常
  
     版本：
       2021-10-15: 已完成基本交期变更逻辑
  
  =================================================================================*/
  FUNCTION f_orderchange_dt_sync(v_orderid  IN VARCHAR2,
                                 v_compid   IN VARCHAR2,
                                 v_gooid    IN VARCHAR2,
                                 v_olddate  IN DATE,
                                 v_newdate  IN DATE,
                                 v_cgreason IN VARCHAR2 DEFAULT NULL,
                                 v_prodesc  IN VARCHAR2 DEFAULT NULL)
    RETURN NUMBER IS
    v_exesql VARCHAR2(1024);
    v_jugnum NUMBER(1);
  BEGIN
    --交期变更
    v_exesql := 'UPDATE SCMDATA.T_ORDERS SET DELIVERY_DATE = TRUNC(:A) WHERE ORDER_ID = :B AND COMPANY_ID = :C AND GOO_ID = :D AND TRUNC(DELIVERY_DATE) = TRUNC(:E)';
    EXECUTE IMMEDIATE v_exesql
      USING v_newdate, v_orderid, v_compid, v_gooid, v_olddate;
  
    SELECT COUNT(1)
      INTO v_jugnum
      FROM scmdata.t_orders
     WHERE order_id = v_orderid
       AND company_id = v_compid
       AND trunc(delivery_date) = trunc(v_newdate)
       AND rownum = 1;
  
    IF v_jugnum = 1 THEN
      /*交期原因变更后,延期问题分类、延期问题原因、延期问题细分、
      问题描述字段，供应商是否免责、责任部门1级、责任部门2级、
      是否质量问题字段更新*/
      p_change_reason_insert(v_orderid  => v_orderid,
                             v_compid   => v_compid,
                             v_gooid    => v_gooid,
                             v_cgreason => v_cgreason,
                             v_prodesc  => v_prodesc);
    END IF;
  
    /*SCMDATA.PKG_CAPACITY_INQUEUE.P_COMMON_INQUEUE(V_CURUSERID => 'ADMIN',
    V_COMPID    => V_COMPID,
    V_TAB       => 'SCMDATA.T_ORDERS',
    V_VIEWTAB   => NULL,
    V_UNQFIELDS => 'ORDER_ID,COMPANY_ID',
    V_CKFIELDS  => 'FACTORY_CODE,DELIVERY_DATE',
    V_CONDS     => 'ORDER_ID = '''||V_ORDERID||''' AND COMPANY_ID = '''||V_COMPID||'''',
    V_METHOD    => 'UPD',
    V_VIEWLOGIC => NULL,
    V_QUEUETYPE => 'CAPC_ORDERS_DELDFAC_U');*/
  
    --交期变更正常
    RETURN 1;
  
    --异常
  EXCEPTION
    WHEN OTHERS THEN
      RETURN 2;
    
  END f_orderchange_dt_sync;

  /*=================================================================================
  
    ORDERCHANGE 供应商变更逻辑
  
    说明：
      用于修改 SCMDATA.T_ORDERS.DELIVERY_DATE 为新值，
      同时修改 SCMDATA.T_PRODUCTION_PROGRESS.SUPPLIER_CODE
               SCMDATA.T_PRODUCTION_PROGRESS.FACTORY_CODE 为新值
  
    入参：
      V_ORDERID   :  订单
      V_COMPID    :  企业Id
      V_OLDSUP    :  旧供应商
      V_NEWSUP    :  新供应商
  
    返回值:
      1 正常，2 异常
  
     版本：
       2021-10-15: 已完成基本供应商变更逻辑
  
  =================================================================================*/
  FUNCTION f_orderchange_sc_sync(v_orderid IN VARCHAR2,
                                 v_compid  IN VARCHAR2,
                                 v_oldsup  IN VARCHAR2,
                                 v_newsup  IN VARCHAR2) RETURN NUMBER IS
    v_exesql VARCHAR2(1024);
  BEGIN
    --供应商变更
    v_exesql := 'DECLARE
    TMPV VARCHAR2(32);
  BEGIN
    SELECT SUPPLIER_CODE
      INTO TMPV
      FROM SCMDATA.T_ORDERED
     WHERE ORDER_CODE = ''' || v_orderid || '''
       AND COMPANY_ID = ''' || v_compid || ''';
    IF ''' || v_oldsup || ''' = TMPV THEN
      UPDATE SCMDATA.T_ORDERED
         SET SUPPLIER_CODE = ''' || v_newsup || '''
       WHERE ORDER_CODE = ''' || v_orderid || '''
       AND COMPANY_ID = ''' || v_compid || '''
         AND SUPPLIER_CODE = ''' || v_oldsup || ''';

      UPDATE SCMDATA.T_ORDERS
         SET FACTORY_CODE = ''' || v_newsup || '''
       WHERE ORDER_ID = ''' || v_orderid || '''
         AND COMPANY_ID = ''' || v_compid || ''';
      UPDATE SCMDATA.T_PRODUCTION_PROGRESS
         SET SUPPLIER_CODE = ''' || v_newsup || ''',
             FACTORY_CODE = ''' || v_newsup || '''
       WHERE ORDER_ID = ''' || v_orderid || '''
         AND COMPANY_ID = ''' || v_compid || ''';
    END IF;
  END;';
    EXECUTE IMMEDIATE v_exesql;
  
    /*SCMDATA.PKG_CAPACITY_INQUEUE.P_COMMON_INQUEUE(V_CURUSERID => 'ADMIN',
    V_COMPID    => V_COMPID,
    V_TAB       => 'SCMDATA.T_ORDERED',
    V_VIEWTAB   => NULL,
    V_UNQFIELDS => 'ORDER_CODE,COMPANY_ID',
    V_CKFIELDS  => 'SUPPLIER_CODE',
    V_CONDS     => 'ORDER_CODE = '''||V_ORDERID||''' AND COMPANY_ID = '''||V_COMPID||'''',
    V_METHOD    => 'UPD',
    V_VIEWLOGIC => NULL,
    V_QUEUETYPE => 'CAPC_ORDERED_SUP_U');*/
  
    --供应商变更正常
    RETURN 1;
  
    --异常
  EXCEPTION
    WHEN OTHERS THEN
      RETURN 2;
    
  END f_orderchange_sc_sync;

  /*=================================================================================
  
    ORDERCHANGE 仓库变更逻辑
  
    说明：
      用于修改 SCMDATA.T_ORDERED.SHO_ID 为新值
  
    入参：
      V_ORDERID   :  订单
      V_COMPID    :  企业Id
      V_OLDLOC    :  旧仓库
      V_NEWLOC    :  新仓库
  
    返回值:
      1 正常，2 异常
  
     版本：
       2021-10-15: 已完成基本仓库变更逻辑
  
  =================================================================================*/
  FUNCTION f_orderchange_wh_sync(v_orderid IN VARCHAR2,
                                 v_compid  IN VARCHAR2,
                                 v_oldloc  IN VARCHAR2,
                                 v_newloc  IN VARCHAR2) RETURN NUMBER IS
    v_exesql VARCHAR2(1024);
  BEGIN
    --仓库变更
    v_exesql := 'UPDATE SCMDATA.T_ORDERED SET SHO_ID = :A WHERE ORDER_CODE = :B AND COMPANY_ID = :C AND SHO_ID = :D';
    EXECUTE IMMEDIATE v_exesql
      USING v_newloc, v_orderid, v_compid, v_oldloc;
  
    --仓库变更正常
    RETURN 1;
  
    --异常
  EXCEPTION
    WHEN OTHERS THEN
      RETURN 2;
  END f_orderchange_wh_sync;

  /*=================================================================================
  
    ORDERCHANGE 供应商代发变更逻辑
  
    说明：
      用于修改 SCMDATA.T_ORDERED.SEND_BY_SUP 为新值
  
    入参：
      V_ORDERID   :  订单
      V_COMPID    :  企业Id
      V_OLDSBS    :  旧是否代发值
      V_NEWSBS    :  新是否代发值
  
    返回值:
      1 正常，2 异常
  
     版本：
       2021-10-15: 已完成基本供应商代发变更逻辑
  
  =================================================================================*/
  FUNCTION f_orderchange_sd_sync(v_orderid IN VARCHAR2,
                                 v_compid  IN VARCHAR2,
                                 v_oldsbs  IN VARCHAR2,
                                 v_newsbs  IN VARCHAR2) RETURN NUMBER IS
    v_exesql VARCHAR2(1024);
    v_dlvrec scmdata.t_delivery_record%ROWTYPE;
  BEGIN
    --供应商代发变更
    v_exesql := 'UPDATE SCMDATA.T_ORDERED SET SEND_BY_SUP = :C WHERE ORDER_CODE = :A AND COMPANY_ID = :B AND SEND_BY_SUP = :D';
    EXECUTE IMMEDIATE v_exesql
      USING v_newsbs, v_orderid, v_compid, v_oldsbs;
  
    --判断：V_NEWSBS = 1 时，对下列数据进行更新
    IF v_newsbs = 1 THEN
      FOR z IN (SELECT *
                  FROM scmdata.t_ordered
                 WHERE order_code = v_orderid
                   AND company_id = v_compid
                   AND finish_time IS NOT NULL) LOOP
        UPDATE scmdata.t_delivery_record
           SET delivery_origin_time = z.finish_time,
               delivery_date        = z.finish_time
         WHERE order_code = z.order_code
           AND company_id = z.company_id;
      
        FOR x IN (SELECT delivery_record_id, company_id
                    FROM scmdata.t_delivery_record
                   WHERE order_code = z.order_code
                     AND company_id = z.company_id) LOOP
          SELECT *
            INTO v_dlvrec
            FROM scmdata.t_delivery_record
           WHERE delivery_record_id = x.delivery_record_id
             AND company_id = x.company_id;
        
          scmdata.pkg_production_progress.sync_delivery_record(p_delivery_rec => v_dlvrec);
        END LOOP;
      END LOOP;
    END IF;
  
    --供应商代发变更正常
    RETURN 1;
  
    --异常
  EXCEPTION
    WHEN OTHERS THEN
      RETURN 2;
  END f_orderchange_sd_sync;

  /*=================================================================================
  
    ORDERCHANGE 数据同步
  
    说明：
      用于将 SCMDATA.T_ORDERCHANGE 中的数据同步到对应表的对应字段
  
     版本：
       2021-10-15: 已完成供应商代发变更，供应商变更，单价变更，交期变更，
                   仓库变更逻辑
  
  =================================================================================*/
  PROCEDURE p_orderchange_sync IS
    v_ordsts VARCHAR2(8);
    v_status NUMBER(4);
    jug_num  NUMBER(4);
  BEGIN
    FOR i IN (SELECT oc_id,
                     company_id,
                     change_type,
                     pc_no,
                     ord_id,
                     goo_id,
                     oldinprice,
                     newinprice,
                     oldneed_date,
                     newneed_date,
                     oldsupplier,
                     newsupplier,
                     oldloc,
                     newloc,
                     oldsend_by_sup,
                     newsend_by_sup,
                     reason,
                     memo
                FROM (SELECT *
                        FROM scmdata.t_orderchange
                       WHERE change_type IN ('PR', 'DT', 'SC', 'WH', 'SD')
                         AND status = 0
                       ORDER BY pc_no)
               WHERE rownum <= 100) LOOP
      SELECT COUNT(1), MAX(nvl(order_status, ' '))
        INTO jug_num, v_ordsts
        FROM scmdata.t_ordered z
       WHERE order_code = i.ord_id
         AND company_id = i.company_id
         AND EXISTS (SELECT 1
                FROM scmdata.t_orders
               WHERE order_id = z.order_code
                 AND company_id = z.company_id);
      IF i.change_type = 'PR' AND jug_num = 1 THEN
        --订单单价变更同步
        v_status := f_orderchange_pr_sync(v_orderid  => i.ord_id,
                                          v_compid   => i.company_id,
                                          v_gooid    => i.goo_id,
                                          v_oldprice => i.oldinprice,
                                          v_newprice => i.newinprice);
      ELSIF i.change_type = 'DT' AND v_ordsts = 'OS01' AND jug_num = 1 THEN
        --交期变更同步
        v_status := f_orderchange_dt_sync(v_orderid  => i.ord_id,
                                          v_compid   => i.company_id,
                                          v_gooid    => i.goo_id,
                                          v_olddate  => i.oldneed_date,
                                          v_newdate  => i.newneed_date,
                                          v_cgreason => i.reason,
                                          v_prodesc  => i.memo);
      ELSIF i.change_type = 'SC' AND v_ordsts = 'OS01' AND jug_num = 1 THEN
        --供应商变更同步
        v_status := f_orderchange_sc_sync(v_orderid => i.ord_id,
                                          v_compid  => i.company_id,
                                          v_oldsup  => i.oldsupplier,
                                          v_newsup  => i.newsupplier);
      ELSIF i.change_type = 'WH' AND v_ordsts = 'OS01' AND jug_num = 1 THEN
        --仓库变更同步
        v_status := f_orderchange_wh_sync(v_orderid => i.ord_id,
                                          v_compid  => i.company_id,
                                          v_oldloc  => i.oldloc,
                                          v_newloc  => i.newloc);
      ELSIF i.change_type = 'SD' AND v_ordsts = 'OS01' AND jug_num = 1 THEN
        --供应商代发变更同步
        v_status := f_orderchange_sd_sync(v_orderid => i.ord_id,
                                          v_compid  => i.company_id,
                                          v_oldsbs  => i.oldsend_by_sup,
                                          v_newsbs  => i.newsend_by_sup);
      END IF;
    
      UPDATE scmdata.t_orderchange
         SET status = v_status
       WHERE oc_id = i.oc_id;
    
    END LOOP;
  END p_orderchange_sync;

  /*=================================================================================================================
  
    判断是否存在于 SCMDATA.T_CMX_RCA 中
  
    用途:
      判断是否存在于 SCMDATA.T_CMX_RCA 中
  
    入参:
      V_ORDID     : 订单号
      V_GOOID     : 货号
      V_OLDPRICE  : 旧单价
      V_NEWPRICE  : 新单价
      V_AUDITTIME : 审核时间
      V_COMPID    : 企业Id
  
    返回值:
      NUMBER类型，0-不存在 1-存在
  
    版本:
      2021-11-17 : 判断是否存在于 SCMDATA.T_CMX_RCA 中
  
  ==================================================================================================================*/
  FUNCTION f_check_cmx_rca_exists(v_ordid     IN VARCHAR2,
                                  v_gooid     IN VARCHAR2,
                                  v_oldprice  IN NUMBER,
                                  v_newprice  IN NUMBER,
                                  v_audittime IN DATE,
                                  v_compid    IN VARCHAR2) RETURN NUMBER IS
    v_jugnum NUMBER(1);
  BEGIN
    SELECT COUNT(1)
      INTO v_jugnum
      FROM scmdata.t_cmx_rca
     WHERE ord_id = v_ordid
       AND goo_id = v_gooid
       AND oldinprice = v_oldprice
       AND inprice = v_newprice
       AND audittime = v_audittime
       AND company_id = v_compid
       AND rownum = 1;
  
    RETURN v_jugnum;
  END f_check_cmx_rca_exists;

  /*=================================================================================================================
  
    SCMDATA.T_CMX_RCA 内校验
  
    用途:
      用于校验商品档案是否存在该货号
  
    入参:
      V_ORDID  : 订单号
      V_GOOID  : 货号
      V_COMPID : 企业Id
  
    版本:
      2021-11-17 : 判断是否存在于 SCMDATA.T_CMX_RCA 中
  
  ==================================================================================================================*/
  PROCEDURE p_check_cmxrca_info(v_ordid  IN VARCHAR2,
                                v_gooid  IN VARCHAR2,
                                v_compid IN VARCHAR2,
                                v_eobjid IN VARCHAR2) IS
    v_errinfo CLOB;
    v_tmperr  VARCHAR2(512);
    v_exesql  VARCHAR2(1024);
  BEGIN
    v_tmperr := scmdata.pkg_interface_log.f_check_good_and_generate_errinfo(v_gooid  => v_gooid,
                                                                            v_compid => v_compid);
    IF instr(v_tmperr, '错误信息') > 0 THEN
      v_errinfo := '错误表:SCMDATA.T_CMX_RCA' || chr(10) || '错误时间:' ||
                   to_char(SYSDATE, 'YYYY-MM-DD HH24-MI-SS') || chr(10) ||
                   '错误唯一列:ORD_ID-GOO_ID' || chr(10) || '错误唯一值:' || v_ordid || '-' ||
                   v_gooid || chr(10) || v_tmperr;
    END IF;
  
    IF v_errinfo IS NOT NULL THEN
      scmdata.pkg_interface_log.p_update_interface_variable(v_eobjid  => v_eobjid,
                                                            v_compid  => v_compid,
                                                            v_unqval  => v_ordid || '-' ||
                                                                         v_gooid,
                                                            v_errinfo => v_errinfo,
                                                            v_mode    => 'CE');
      v_exesql := 'UPDATE SCMDATA.T_CMX_RCA SET PORT_STATUS = ''CE'', PORT_TIME = SYSDATE WHERE ORD_ID = :A AND GOO_ID = :B AND COMPANY_ID = :C';
      EXECUTE IMMEDIATE v_exesql
        USING v_ordid, v_gooid, v_compid;
    ELSE
      scmdata.pkg_variable.p_set_variable_increment(v_objid   => v_eobjid,
                                                    v_compid  => v_compid,
                                                    v_varname => 'SSNUM');
    END IF;
  END p_check_cmxrca_info;

  /*================================================================================
  
    提单后成本变更接口
  
    用途:
      用于接收提单后成本变更数据到 SCMDATA.T_CMX_RCA 表
  
    入参:
      V_ORDID      :  订单号
      V_SHOID      :  仓库Id
      V_GOOID      :  货号
      V_OLDPRICE   :  旧价格
      V_NEWPIRCE   :  新价格
      V_OPERATORID :  操作人Id
      V_CREATETIME :  创建时间
      V_FINISHTIME :  结束时间
      V_AUDITORID  :  审核人Id
      V_AUDITTIME  :  审核时间
      V_MEMO       :  备注
      V_RCAID      :  RCA_ID
      V_BRAID      :  分部Id
      V_INGIDT     :  ING_ID_T
      V_INGIDJ     :  ING_ID_J
      V_EOBJID     :  执行对象Id
      V_COMPID     :  企业Id
      V_MINUTE     :  间隔分钟（记录到 SCMDATA.T_INTERFACE_LOG)
  
    版本:
      2021-11-17 : 用于接收提单后成本变更数据到 SCMDATA.T_CMX_RCA 表
  
  ================================================================================*/
  PROCEDURE p_insert_rca_itf(v_ordid      IN VARCHAR2,
                             v_shoid      IN VARCHAR2,
                             v_gooid      IN VARCHAR2,
                             v_oldprice   IN NUMBER,
                             v_newpirce   IN NUMBER,
                             v_operatorid IN VARCHAR2,
                             v_createtime IN VARCHAR2,
                             v_finishtime IN VARCHAR2,
                             v_auditorid  IN VARCHAR2,
                             v_audittime  IN VARCHAR2,
                             v_memo       IN VARCHAR2,
                             v_rcaid      IN VARCHAR2,
                             v_braid      IN VARCHAR2,
                             v_ingidt     IN VARCHAR2,
                             v_ingidj     IN VARCHAR2,
                             v_eobjid     IN VARCHAR2,
                             v_compid     IN VARCHAR2,
                             v_minute     IN NUMBER) IS
    v_jugnum  NUMBER(1);
    v_cretime DATE := to_date(v_createtime, 'YYYY-MM-DD HH24-MI-SS');
    v_fintime DATE := to_date(v_finishtime, 'YYYY-MM-DD HH24-MI-SS');
    v_audtime DATE := to_date(v_audittime, 'YYYY-MM-DD HH24-MI-SS');
    v_exesql  VARCHAR2(4000);
  BEGIN
    scmdata.pkg_interface_log.p_insert_info_and_init_variable(v_eobjid => v_eobjid,
                                                              v_compid => v_compid,
                                                              v_minute => v_minute);
  
    v_jugnum := f_check_cmx_rca_exists(v_ordid     => v_ordid,
                                       v_gooid     => v_gooid,
                                       v_oldprice  => v_oldprice,
                                       v_newprice  => v_newpirce,
                                       v_audittime => v_audtime,
                                       v_compid    => v_compid);
  
    IF v_jugnum = 0 THEN
      v_exesql := 'INSERT INTO SCMDATA.T_CMX_RCA (CR_ID,COMPANY_ID,ORD_ID,SHO_ID,GOO_ID,OLDINPRICE,INPRICE,OPERATORID,CREATETIME,FINISHTIME,AUDITORID,AUDITTIME,MEMO,RCA_ID,BRA_ID,ING_ID_T,ING_ID_J,PORT_ELEMENT,PORT_TIME,PORT_STATUS) VALUES (SCMDATA.F_GET_UUID(),:COMPANY_ID,:ORD_ID,:SHO_ID,:GOO_ID,:OLDINPRICE,:INPRICE,:OPERATORID,:CREATETIME,:FINISHTIME,:AUDITORID,:AUDITTIME,:MEMO,:RCA_ID,:BRA_ID,:ING_ID_T,:ING_ID_J,:PORT_ELEMENT,SYSDATE,''SP'')';
    
      EXECUTE IMMEDIATE v_exesql
        USING v_compid, v_ordid, v_shoid, v_gooid, v_oldprice, v_newpirce, v_operatorid, v_cretime, v_fintime, v_auditorid, v_audtime, v_memo, v_rcaid, v_braid, v_ingidt, v_ingidj, v_eobjid;
    
      p_check_cmxrca_info(v_ordid  => v_ordid,
                          v_gooid  => v_gooid,
                          v_compid => v_compid,
                          v_eobjid => v_eobjid);
    END IF;
  EXCEPTION
    WHEN OTHERS THEN
      v_exesql := 'INSERT INTO SCMDATA.T_CMX_RCA (CR_ID,COMPANY_ID,ORD_ID,SHO_ID,GOO_ID,OLDINPRICE,INPRICE,OPERATORID,' ||
                  'CREATETIME,FINISHTIME,AUDITORID,AUDITTIME,MEMO,RCA_ID,BRA_ID,ING_ID_T,ING_ID_J,PORT_ELEMENT,' ||
                  'PORT_TIME,PORT_STATUS) VALUES (SCMDATA.F_GET_UUID(),''' ||
                  v_compid || ''',''' || v_ordid || ''',''' || v_shoid ||
                  ''',''' || v_gooid || ''',' || v_oldprice || ',' ||
                  v_newpirce || ',''' || v_operatorid || ''',TO_DATE(''' ||
                  v_createtime ||
                  ''',''YYYY-MM-DD HH24-MI-SS''), TO_DATE(''' || v_fintime ||
                  ''',''YYYY-MM-DD HH24-MI-SS''),''' || v_auditorid ||
                  ''',TO_DATE(''' || v_audtime ||
                  ''',''YYYY-MM-DD HH24-MI-SS''),''' || v_memo || ''',''' ||
                  v_rcaid || ''',''' || v_braid || ''',''' || v_ingidt ||
                  ''',''' || v_ingidj || ''',''' || v_eobjid ||
                  ''',SYSDATE,''NC'')';
    
      scmdata.pkg_interface_log.p_itf_runtime_error_logic(v_eobjid  => v_eobjid,
                                                          v_compid  => v_compid,
                                                          v_tab     => 'SCMDATA.T_CMX_RCA',
                                                          v_errsql  => v_exesql,
                                                          v_unqcols => 'ORD_ID-GOO_ID',
                                                          v_unqvals => v_ordid || '-' ||
                                                                       v_gooid,
                                                          v_st      => dbms_utility.format_error_stack);
  END p_insert_rca_itf;

  /*=================================================================================================================
  
    SCMDATA.T_CMX_RCA 数据同步
  
    用途:
      用于将 SCMDATA.T_CMX_RCA 内数据同步到 SCMDATA.T_ORDERS
  
    版本:
      2021-11-17 : 用于将 SCMDATA.T_CMX_RCA 内数据同步到 SCMDATA.T_ORDERS，每次300条
  
  ==================================================================================================================*/
  PROCEDURE p_cmxrca_sync IS
    v_jugnum NUMBER(1);
    v_exesql VARCHAR2(512);
  BEGIN
    FOR i IN (SELECT a.cr_id,
                     a.ord_id,
                     a.company_id,
                     b.goo_id,
                     a.oldinprice,
                     a.inprice
                FROM (SELECT cr_id,
                             ord_id,
                             company_id,
                             goo_id,
                             oldinprice,
                             inprice
                        FROM scmdata.t_cmx_rca
                       WHERE port_status = 'SP'
                       ORDER BY createtime) a
               INNER JOIN scmdata.t_commodity_info b
                  ON a.goo_id = b.rela_goo_id
                 AND a.company_id = b.company_id
               WHERE rownum <= 300) LOOP
      BEGIN
        v_jugnum := scmdata.pkg_port_sync.f_orderchange_pr_sync(v_orderid  => i.ord_id,
                                                                v_compid   => i.company_id,
                                                                v_gooid    => i.goo_id,
                                                                v_oldprice => i.oldinprice,
                                                                v_newprice => i.inprice);
      
        IF v_jugnum = 1 THEN
          v_exesql := 'UPDATE SCMDATA.T_CMX_RCA SET PORT_STATUS = ''SS''  WHERE CR_ID = :A AND COMPANY_ID = :B';
        ELSE
          v_exesql := 'UPDATE SCMDATA.T_CMX_RCA SET PORT_STATUS = ''SE''  WHERE CR_ID = :A AND COMPANY_ID = :B';
        END IF;
      
        EXECUTE IMMEDIATE v_exesql
          USING i.cr_id, i.company_id;
      
        v_exesql := 'UPDATE SCMDATA.T_INGOODS A SET A.INPRICE = :A WHERE A.ING_ID IN
                   (SELECT ING_ID FROM SCMDATA.T_INGOOD W WHERE W.DOCUMENT_NO = :B
                    AND W.INGOOD_TYPE <> ''CA'' AND W.COMPANY_ID = :C
                    AND W.CHECKOUT_TIME IS NULL AND W.FINISH_TIME IS NOT NULL)
                    AND A.GOO_ID = :D AND A.COMPANY_ID = :C AND A.AMOUNT > 0 AND A.INPRICE = :E';
      
        EXECUTE IMMEDIATE v_exesql
          USING i.inprice, i.ord_id, i.company_id, i.goo_id, i.company_id, i.oldinprice;
      EXCEPTION
        WHEN OTHERS THEN
          v_jugnum := 0;
          v_exesql := NULL;
      END;
    END LOOP;
  END p_cmxrca_sync;

  /*=================================================================================
  
    获取 ORDERED / ORDERS / ORDERSITEM 数量
  
    入参：
      V_ORDID        :  订单号
      V_COMPID       :  企业Id
      V_EDNUM        :  ordered 数据条数
      V_ORDSNUM      :  orders 数据条数
      V_ORDSITEMNUM  :  ordersitem 数据条数
  
     版本：
       2022-04-15 : 获取 ORDERED / ORDERS / ORDERSITEM 数量
  
  =================================================================================*/
  PROCEDURE p_get_order_num(v_ordid   IN VARCHAR2,
                            v_compid  IN VARCHAR2,
                            v_ednum   IN OUT NUMBER,
                            v_snum    IN OUT NUMBER,
                            v_itemnum IN OUT NUMBER) IS
  
  BEGIN
    SELECT COUNT(1)
      INTO v_ednum
      FROM scmdata.t_ordered
     WHERE order_code = v_ordid
       AND company_id = v_compid;
  
    SELECT COUNT(1)
      INTO v_snum
      FROM scmdata.t_orders
     WHERE order_id = v_ordid
       AND company_id = v_compid;
  
    SELECT COUNT(1)
      INTO v_itemnum
      FROM scmdata.t_ordersitem
     WHERE order_id = v_ordid
       AND company_id = v_compid;
  END p_get_order_num;

  /*=================================================================================
  
    获取 供应商、商品档案 判断
  
    入参：
      V_SUPCODE   :  供应商编码
      V_GOOID     :  货号编码
      V_COMPID    :  企业Id
      V_ISSUPEX   :  供应商是否存在 0-存在 1-不存在
      V_ISGOOEX   :  商品档案是否存在 0-存在 1-不存在
  
     版本：
       2022-04-15 : 获取 ORDERS / ORDERSITEM 数量
  
  =================================================================================*/
  PROCEDURE p_check_sup_goo_ex(v_supcode IN VARCHAR2,
                               v_gooid   IN VARCHAR2,
                               v_compid  IN VARCHAR2,
                               v_issupex IN OUT NUMBER,
                               v_isgooex IN OUT NUMBER) IS
  
  BEGIN
    SELECT COUNT(1)
      INTO v_issupex
      FROM scmdata.t_supplier_info
     WHERE inside_supplier_code = v_supcode
       AND company_id = v_compid
       AND rownum = 1;
  
    SELECT COUNT(1)
      INTO v_isgooex
      FROM scmdata.t_commodity_info
     WHERE rela_goo_id = v_gooid
       AND company_id = v_compid
       AND rownum = 1;
  
    IF v_issupex = 1 THEN
      v_issupex := 0;
    ELSIF v_issupex = 0 THEN
      v_issupex := 1;
    END IF;
  
    IF v_isgooex = 1 THEN
      v_isgooex := 0;
    ELSIF v_isgooex = 0 THEN
      v_isgooex := 1;
    END IF;
  END p_check_sup_goo_ex;

  /*=================================================================================
  
    校验 ordered 是否已经接入
  
    入参：
      V_ORDID   :  订单号
      V_COMPID  :  企业Id
      V_PDEDNUM :  熊猫 ordered 数据条数
  
     版本：
       2022-04-15 : 校验 ordered 是否已经接入
  
  =================================================================================*/
  FUNCTION f_check_orded_altrans(v_ordid   IN VARCHAR2,
                                 v_compid  IN VARCHAR2,
                                 v_pdednum IN NUMBER) RETURN NUMBER IS
    v_cn     NUMBER(8);
    v_retnum NUMBER(1);
  BEGIN
    SELECT COUNT(1)
      INTO v_cn
      FROM scmdata.t_ordered
     WHERE order_code = v_ordid
       AND company_id = v_compid;
  
    IF v_cn = v_pdednum THEN
      v_retnum := 0;
    ELSE
      v_retnum := 1;
    END IF;
  
    RETURN v_retnum;
  END f_check_orded_altrans;

  /*=================================================================================
  
    校验 orders 是否已经接入
  
    入参：
      V_ORDID   :  订单号
      V_COMPID  :  企业Id
      V_PDSNUM  :  熊猫 orders 数据条数
  
     版本：
       2022-04-15 : 校验 orders 是否已经接入
  
  =================================================================================*/
  FUNCTION f_check_ords_altrans(v_ordid  IN VARCHAR2,
                                v_compid IN VARCHAR2,
                                v_pdsnum IN NUMBER) RETURN NUMBER IS
    v_cn     NUMBER(8);
    v_retnum NUMBER(1);
  BEGIN
    SELECT COUNT(1)
      INTO v_cn
      FROM scmdata.t_orders
     WHERE order_id = v_ordid
       AND company_id = v_compid;
  
    IF v_cn = v_pdsnum THEN
      v_retnum := 0;
    ELSE
      v_retnum := 1;
    END IF;
  
    RETURN v_retnum;
  END f_check_ords_altrans;

  /*=================================================================================
  
    校验 ordersitem 是否已经接入
  
    入参：
      V_ORDID     :  订单号
      V_COMPID    :  企业Id
      V_PDITEMNUM :  熊猫 ordersitem 数据条数
  
     版本：
       2022-04-15 : 校验 ordersitem 是否已经接入
  
  =================================================================================*/
  FUNCTION f_check_ordsitem_altrans(v_ordid     IN VARCHAR2,
                                    v_compid    IN VARCHAR2,
                                    v_pditemnum IN NUMBER) RETURN NUMBER IS
    v_cn     NUMBER(8);
    v_retnum NUMBER(1);
  BEGIN
    SELECT COUNT(1)
      INTO v_cn
      FROM scmdata.t_ordersitem
     WHERE order_id = v_ordid
       AND company_id = v_compid;
  
    IF v_cn = v_pditemnum THEN
      v_retnum := 0;
    ELSE
      v_retnum := 1;
    END IF;
  
    RETURN v_retnum;
  END f_check_ordsitem_altrans;

  /*=================================================================================
  
    更新 T_ORDER_LEAK ordered 是否接入字段
  
    入参：
      V_ORDID   :  订单号
      V_COMPID  :  企业Id
  
     版本：
       2022-04-15 : 更新 T_ORDER_LEAK ordered 是否接入字段
  
  =================================================================================*/
  PROCEDURE p_update_ordleak_isordedget(v_ordid  IN VARCHAR2,
                                        v_compid IN VARCHAR2) IS
    v_ordednum NUMBER(8);
    v_scmednum NUMBER(8);
  BEGIN
    SELECT MAX(orded_num)
      INTO v_ordednum
      FROM scmdata.t_order_leak
     WHERE order_id = v_ordid
       AND company_id = v_compid;
  
    SELECT COUNT(1)
      INTO v_scmednum
      FROM scmdata.t_ordered
     WHERE order_code = v_ordid
       AND company_id = v_compid;
  
    IF v_ordednum = v_scmednum THEN
      UPDATE scmdata.t_order_leak
         SET is_ordedget = 0
       WHERE order_id = v_ordid
         AND company_id = v_compid;
    END IF;
  END p_update_ordleak_isordedget;

  /*=================================================================================
  
    更新 T_ORDER_LEAK orders 是否接入字段
  
    入参：
      V_ORDID   :  订单号
      V_COMPID  :  企业Id
  
     版本：
       2022-04-15 : 更新 T_ORDER_LEAK orders 是否接入字段
  
  =================================================================================*/
  PROCEDURE p_update_ordleak_isordsget(v_ordid  IN VARCHAR2,
                                       v_compid IN VARCHAR2) IS
    v_ordsnum NUMBER(8);
    v_scmsnum NUMBER(8);
  BEGIN
    SELECT MAX(ords_num)
      INTO v_ordsnum
      FROM scmdata.t_order_leak
     WHERE order_id = v_ordid
       AND company_id = v_compid;
  
    SELECT COUNT(1)
      INTO v_scmsnum
      FROM scmdata.t_orders
     WHERE order_id = v_ordid
       AND company_id = v_compid;
  
    IF v_ordsnum = v_scmsnum THEN
      UPDATE scmdata.t_order_leak
         SET is_ordsget = 0
       WHERE order_id = v_ordid
         AND company_id = v_compid;
    END IF;
  END p_update_ordleak_isordsget;

  /*=================================================================================
  
    更新 T_ORDER_LEAK ordersitem 是否接入字段
  
    入参：
      V_ORDID   :  订单号
      V_COMPID  :  企业Id
  
     版本：
       2022-04-15 : 更新 T_ORDER_LEAK ordersitem 是否接入字段
  
  =================================================================================*/
  PROCEDURE p_update_ordleak_isordsitemget(v_ordid  IN VARCHAR2,
                                           v_compid IN VARCHAR2) IS
    v_ordsitemnum NUMBER(8);
    v_scmsitemnum NUMBER(8);
  BEGIN
    SELECT MAX(ordsitem_num)
      INTO v_ordsitemnum
      FROM scmdata.t_order_leak
     WHERE order_id = v_ordid
       AND company_id = v_compid;
  
    SELECT COUNT(1)
      INTO v_scmsitemnum
      FROM scmdata.t_orders
     WHERE order_id = v_ordid
       AND company_id = v_compid;
  
    IF v_ordsitemnum = v_scmsitemnum THEN
      UPDATE scmdata.t_order_leak
         SET is_ordsitemget = 0
       WHERE order_id = v_ordid
         AND company_id = v_compid;
    END IF;
  END p_update_ordleak_isordsitemget;

  /*=================================================================================
  
    获取 ORDER_LEAK 数据状态
  
    入参：
      V_ISSUPEX       :  供应商档案是否存在
      V_ISGOOEX       :  商品档案是否存在
      V_ISEDGET       :  ordered是否接入
      V_ISSGET        :  orders是否接入
      V_ISITEMGET     :  ordersitem是否接入
  
     版本：
       2022-04-15 : 获取 ORDER_LEAK 数据状态
  
  =================================================================================*/
  FUNCTION f_get_orderleak_status(v_issupex   IN NUMBER,
                                  v_isgooex   IN NUMBER,
                                  v_isedget   IN NUMBER,
                                  v_issget    IN NUMBER,
                                  v_isitemget IN NUMBER) RETURN VARCHAR2 IS
    v_status VARCHAR2(4);
  BEGIN
    IF v_issupex = 1 AND v_isgooex = 1 THEN
      v_status := 'SGM';
    ELSIF v_issupex = 1 THEN
      v_status := 'SM';
    ELSIF v_isgooex = 1 THEN
      v_status := 'GM';
    ELSIF v_isedget = 0 AND v_issget = 0 AND v_isitemget = 0 THEN
      v_status := 'AT';
    ELSE
      v_status := 'NT';
    END IF;
  
    RETURN v_status;
  END f_get_orderleak_status;

  /*=================================================================================
  
    订单漏接信息接入
  
    入参：
      V_ORDID         :  订单号
      V_SUPIDBASE     :  供应商编码
      V_GOOID         :  内部货号
      V_CREATETIME    :  订单创建时间
      V_ORDEDNUM      :  熊猫ordered数据条数
      V_ORDSNUM       :  熊猫orders数据条数
      V_ORDSITEMNUM   :  熊猫ordersitem数据条数
      V_COMPID        :  企业Id
  
     版本：
       2022-04-15 : 订单漏接信息接入
  
  =================================================================================*/
  PROCEDURE p_order_leak_insert(v_ordid       IN VARCHAR2,
                                v_supidbase   IN VARCHAR2,
                                v_gooid       IN VARCHAR2,
                                v_createtime  IN VARCHAR2,
                                v_ordednum    IN VARCHAR2,
                                v_ordsnum     IN VARCHAR2,
                                v_ordsitemnum IN VARCHAR2,
                                v_compid      IN VARCHAR2) IS
    v_jugnum    NUMBER(1);
    v_cretime   DATE := to_date(v_createtime, 'YYYY-MM-DD HH24-MI-SS');
    v_status    VARCHAR2(4);
    v_issupex   NUMBER(1);
    v_isgooex   NUMBER(1);
    v_isedget   NUMBER(1);
    v_issget    NUMBER(1);
    v_isitemget NUMBER(1);
  BEGIN
    SELECT COUNT(1)
      INTO v_jugnum
      FROM scmdata.t_order_leak
     WHERE order_id = v_ordid
       AND company_id = v_compid
       AND rownum = 1;
  
    p_check_sup_goo_ex(v_supcode => v_supidbase,
                       v_gooid   => v_gooid,
                       v_compid  => v_compid,
                       v_issupex => v_issupex,
                       v_isgooex => v_isgooex);
  
    v_isedget := f_check_orded_altrans(v_ordid   => v_ordid,
                                       v_compid  => v_compid,
                                       v_pdednum => v_ordednum);
  
    v_issget := f_check_ords_altrans(v_ordid  => v_ordid,
                                     v_compid => v_compid,
                                     v_pdsnum => v_ordsnum);
  
    v_isitemget := f_check_ordsitem_altrans(v_ordid     => v_ordid,
                                            v_compid    => v_compid,
                                            v_pditemnum => v_ordsitemnum);
  
    v_status := f_get_orderleak_status(v_issupex   => v_issupex,
                                       v_isgooex   => v_isgooex,
                                       v_isedget   => v_isedget,
                                       v_issget    => v_issget,
                                       v_isitemget => v_isitemget);
  
    IF v_jugnum = 0 THEN
      INSERT INTO scmdata.t_order_leak
        (order_id,
         company_id,
         status,
         order_cttime,
         sup_id_base,
         goo_id,
         orded_num,
         is_ordedget,
         ords_num,
         is_ordsget,
         ordsitem_num,
         is_ordsitemget)
      VALUES
        (v_ordid,
         v_compid,
         v_status,
         v_cretime,
         v_supidbase,
         v_gooid,
         v_ordednum,
         v_isedget,
         v_ordsnum,
         v_issget,
         v_ordsitemnum,
         v_isitemget);
    ELSE
      UPDATE scmdata.t_order_leak
         SET status         = v_status,
             orded_num      = v_ordednum,
             is_ordedget    = v_isedget,
             ords_num       = v_ordsnum,
             is_ordsget     = v_issget,
             ordsitem_num   = v_ordsitemnum,
             is_ordsitemget = v_isitemget
       WHERE order_id = v_ordid
         AND company_id = v_compid;
    END IF;
  END p_order_leak_insert;

END pkg_port_sync;
/

