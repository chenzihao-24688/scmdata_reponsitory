CREATE OR REPLACE PACKAGE SCMDATA.PKG_ASN_INTERFACE IS

  /*=================================================================================

    【正常使用】校验待传入 ASNORDERED_ITF 数据是否存在

    用途:
      用于校验传入数据是否存在于 SCMDATA.T_ASNORDERED_ITF

    入参:
      V_ASNID    :  ASN单号
      V_COMPID   :  企业id
      V_JUGNUM   :  判断变量（数字）
      V_PTSTATUS :  接口数据状态

    返回值:
      V_JUGNUM : 等于0，不存在于 SCMDATA.T_ASNORDERED_ITF 中，
                 等于1，存在于 SCMDATA.T_ASNORDERED_ITF 中

      V_PTSTATUS : RE-执行错误
                    CE-校验错误
                    SP-待同步
                    SS-已同步
                    SE-同步错误
                    UP-待更新
                    US-已更新
                    UE-更新错误

     版本:
       2021-10-18: 整合判断变量，接口数据状态作为返回值

  =================================================================================*/
  PROCEDURE P_CHECK_ASNORDERED_EXISTS(V_ASNID     IN VARCHAR2,
                                      V_COMPID    IN VARCHAR2,
                                      V_JUGNUM    IN OUT NUMBER,
                                      V_PTSTATUS  IN OUT VARCHAR2);


  /*=================================================================================

    【正常使用】校验待传入 ASNORDERS_ITF 数据是否存在

    用途:
      用于校验传入数据是否存在于 SCMDATA.T_ASNORDERS_ITF

    入参:
      V_ASNID    :  ASN单号
      V_COMPID   :  企业Id
      V_GOOID    :  商品档案编号
      V_JUGNUM   :  判断变量（数字）
      V_PTSTATUS :  接口数据状态

    返回值:
      V_JUGNUM : 等于0，不存在于 SCMDATA.T_ASNORDERS_ITF 中，
                 等于1，存在于 SCMDATA.T_ASNORDERS_ITF 中

      V_PTSTATUS :  RE-执行错误
                    CE-校验错误
                    SP-待同步
                    SS-已同步
                    SE-同步错误
                    UP-待更新
                    US-已更新
                    UE-更新错误

     版本:
       2021-10-18: 整合判断变量，接口数据状态作为返回值

  =================================================================================*/
  PROCEDURE P_CHECK_ASNORDERS_EXISTS(V_ASNID     IN VARCHAR2,
                                     V_COMPID    IN VARCHAR2,
                                     V_GOOID     IN VARCHAR2,
                                     V_JUGNUM    IN OUT NUMBER,
                                     V_PTSTATUS  IN OUT VARCHAR2);


  /*=================================================================================

    【正常使用】校验待传入 ASNORDERSITEM_ITF 数据是否存在

    用途:
      用于校验传入数据是否存在于 SCMDATA.T_ASNORDERSITEM_ITF

    入参:
      V_ASNID    :  ASN单号
      V_COMPID   :  企业Id
      V_BARCODE  :  条码
      V_JUGNUM   :  判断变量（数字）
      V_PTSTATUS :  接口数据状态

    返回值:
      V_JUGNUM : 等于0，不存在于 SCMDATA.T_ASNORDERS_ITF 中，
                 等于1，存在于 SCMDATA.T_ASNORDERS_ITF 中

      V_PTSTATUS :  RE-执行错误
                    CE-校验错误
                    SP-待同步
                    SS-已同步
                    SE-同步错误
                    UP-待更新
                    US-已更新
                    UE-更新错误

     版本:
       2021-10-18: 整合判断变量，接口数据状态作为返回值

  =================================================================================*/
  PROCEDURE P_CHECK_ASNORDERSITEM_EXISTS(V_ASNID     IN VARCHAR2,
                                         V_COMPID    IN VARCHAR2,
                                         V_BARCODE   IN VARCHAR2,
                                         V_JUGNUM    IN OUT NUMBER,
                                         V_PTSTATUS  IN OUT VARCHAR2);


  /*=================================================================================

    【正常使用】校验待传入 WMS 质检数据是否存在于 SCMDATA.T_QA_WMSRESULT_ITF

    用途:
      用于校验传入数据是否存在于 SCMDATA.T_QA_WMSRESULT_ITF

    入参:
      V_ASNID    :  ASN单号
      V_COMPID   :  企业Id
      V_BARCODES :  条码
      V_JUGNUM   :  判断变量（数字）
      V_PTSTATUS :  接口数据状态

    返回值:
      V_JUGNUM : 等于0，不存在于 SCMDATA.T_QA_WMSRESULT_ITF 中，
                 等于1，存在于 SCMDATA.T_QA_WMSRESULT_ITF 中

      V_PTSTATUS :  RE-执行错误
                    CE-校验错误
                    SP-待同步
                    SS-已同步
                    SE-同步错误
                    UP-待更新
                    US-已更新
                    UE-更新错误

     版本:
       2021-10-24: 整合判断变量，接口数据状态作为返回值

  =================================================================================*/
  PROCEDURE P_CHECK_WMSRESULT_EXISTS(V_ASNID     IN VARCHAR2,
                                     V_COMPID    IN VARCHAR2,
                                     V_BARCODES  IN VARCHAR2,
                                     V_JUGNUM    IN OUT NUMBER,
                                     V_PTSTATUS  IN OUT VARCHAR2);



  /*=================================================================================

    【正常使用】校验待传入 SCMDATA.T_ASNORDERPACKS_ITF 数据是否存在

    用途:
      用于校验传入数据是否存在于 SCMDATA.T_ASNORDERPACKS_ITF

    入参:
      V_ASNID        :  ASN单号
      V_COMPID       :  企业Id
      V_GOODSID      :  货号/条码
      V_PACKBARCODE  :  箱号
      V_JUGNUM       :  判断变量（数字）
      V_PTSTATUS     :  接口数据状态

    返回值:
      V_JUGNUM : 等于0，不存在于 SCMDATA.T_ASNORDERS_ITF 中，
                 等于1，存在于 SCMDATA.T_ASNORDERS_ITF 中

      V_PTSTATUS :  RE-执行错误
                    CE-校验错误
                    SP-待同步
                    SS-已同步
                    SE-同步错误
                    UP-待更新
                    US-已更新
                    UE-更新错误

     版本:
       2022-01-04: 整合判断变量，接口数据状态作为返回值

  =================================================================================*/
  PROCEDURE P_CHECK_ASNORDERPACKS_EXISTS(V_ASNID        IN VARCHAR2,
                                         V_COMPID       IN VARCHAR2,
                                         V_GOODSID      IN VARCHAR2,
                                         V_PACKBARCODE  IN VARCHAR2,
                                         V_JUGNUM       IN OUT NUMBER,
                                         V_PTSTATUS     IN OUT VARCHAR2);


  /*===================================================================================

    更新 ASN_PRETRANS_TO_WMS 最近更新人和最近更新时间

    用途:
      用于更新 ASN_PRETRANS_TO_WMS 最近更新人和最近更新时间

    入参:
      V_QAREPID  :  QA报告Id
      V_QASCPID  :  QA范围Id
      V_ASNID    :  ASN单据Id
      V_OPEROBJ  :  操作对象
      V_COMPID   :  企业Id

    版本:
      2022-03-22 : 用于更新 ASN_PRETRANS_TO_WMS 最近更新人和最近更新时间

  ===================================================================================*/
  PROCEDURE P_UPD_ASNPRETRANSWMS_LASTINFO(V_QAREPID  IN VARCHAR2 DEFAULT NULL,
                                          V_QASCPID  IN VARCHAR2 DEFAULT NULL,
                                          V_ASNID    IN VARCHAR2 DEFAULT NULL,
                                          V_OPEROBJ  IN VARCHAR2,
                                          V_COMPID   IN VARCHAR2);



  /*=================================================================================

    【正常使用】更新 T_ASNINFO_PRETRANS_TO_WMS 状态为 PD

    用途:
      将与传入的 ASN_ID, BARCODE, COMPANY_ID 相关的 QA_REPORT_ID/ QA_SCOPE_ID/ ASN_ID
      且 STATUS = “SE” 的数据状态修改为 “PD”

    版本:
      2021-11-05: 将与传入的 ASN_ID, BARCODE, COMPANY_ID 相关的
                  QA_REPORT_ID/ QA_SCOPE_ID/ ASN_ID 且 STATUS = “SE” 的数据状态修改为 “PD”

  =================================================================================*/
  PROCEDURE P_UPDATE_PRETRANSINFO(V_ASNID   IN VARCHAR2,
                                  V_BARCODE IN VARCHAR2,
                                  V_COMPID  IN VARCHAR2);


  /*=================================================================================

    【正常使用】更新 T_ASNINFO_PRETRANS_TO_WMS 状态为 PD

    入参:
      V_ASNID    :  asn单号
      V_GOOID    :  商品档案编号
      V_BARCODE  :  条码
      V_COMPID   :  企业Id

    版本:
      2022-03-26: 将与传入的 ASN_ID, GOO_ID, BARCODE, COMPANY_ID 相关的 QA_SCOPE_ID
                  且 STATUS = “SE” 的数据状态修改为 “PD”

  =================================================================================*/
  PROCEDURE P_UPDATE_ASNPTTOWMS_TO_PD(V_ASNID   IN VARCHAR2,
                                      V_GOOID   IN VARCHAR2,
                                      V_BARCODE IN VARCHAR2,
                                      V_COMPID  IN VARCHAR2);


  /*=================================================================================

    【正常使用】ASN接口通用校验

    用途:
      用于ASN单相关数据进入到接口表后的通用校验，校验通过/不通过更新接口表，
      接口数据状态（PORT_STATUS）字段，通过则更新接口数据状态为 V_SUCSTATUS，
      不通过则更新为 CE

    入参:
      V_TAB       :  被校验接口表
      V_ASNID     :  ASN单号
      V_GOOID     :  货号，可不填，填写则校验货号是否存在于商品档案中
      V_BARCODE   :  SKU条码，可不填，填写则生成对应的条件
      V_SUPCODE   :  供应商编号，可不填，填写则校验供应商货号是否存在于供应商档案中
      V_COMPANYID :  企业Id
      V_EOBJID    :  执行接口的Element_id
      V_SUCSTATUS :  校验正确编码

     版本:
       2021-10-18:增加 V_SUCSTATUS 以适用于更多场景
       2021-12-28:对 ASNORDERS_ITF 和 ASNORDERSITEM_ITF 增加语句更新条件

  =================================================================================*/
  PROCEDURE P_CHECK_ASNINFO(V_TAB         IN VARCHAR2,
                            V_ASNID       IN VARCHAR2,
                            V_GOOID       IN VARCHAR2 DEFAULT NULL,
                            V_BARCODE     IN VARCHAR2 DEFAULT NULL,
                            V_COMPANYID   IN VARCHAR2,
                            V_EOBJID      IN VARCHAR2,
                            V_SUCSTATUS   IN VARCHAR2 DEFAULT NULL);


  /*=================================================================================

    【正常使用】接入WMS待质检 ASNORDERED 数据

    用途:
      用于接入WMS待质检的 ASNORDERED 数据

    入参:
      V_ASNID      :  ASN单号
      V_COMPID     :  企业Id
      V_ORDERID    :  订单号
      V_SUPCODE    :  供应商编号
      V_PCOMEDATE  :  预计到仓日期
      V_PCOMEINTER :  预计到仓时段
      V_SCANTIME   :  扫描时间
      V_MEMO       :  备注
      V_EOBJID     :  执行对象Id
      V_MINUTE       :  日志等待时间，变量未操作超过 V_MINUTE 分钟，记录到日志

     版本:
       2021-10-18: 增加 V_EOBJID, V_MINUTE 以适应外部请求传输数据场景

  =================================================================================*/
  PROCEDURE P_INSERT_INTO_ASNORDERED_ITF(V_ASNID      IN VARCHAR2,
                                         V_COMPID     IN VARCHAR2,
                                         V_ORDERID    IN VARCHAR2,
                                         V_SUPCODE    IN VARCHAR2,
                                         V_PCOMEDATE  IN VARCHAR2,
                                         V_PCOMEINTER IN VARCHAR2,
                                         V_SCANTIME   IN VARCHAR2,
                                         V_MEMO       IN VARCHAR2,
                                         V_EOBJID     IN VARCHAR2,
                                         V_MINUTE     IN NUMBER);


  /*=================================================================================

    【正常使用】接入WMS待质检 ASNORDERS 数据

    用途:
      用于接入WMS待质检的 ASNORDERS 数据

    入参:
      V_ASNID        :  ASN单号
      V_COMPID       :  企业Id
      V_GOOID        :  商品档案编号
      V_ORDERAMOUNT  :  订货量
      V_PCOMEAMOUNT  :  预计到仓量（预计到货量）
      V_ASNGOTAMOUNT :  预到货收货量
      V_GOTAMOUNT    :  到货量
      V_MEMO         :  备注
      V_EOBJID       :  执行对象Id
      V_MINUTE       :  日志等待时间，变量未操作超过 V_MINUTE 分钟，记录到日志

     版本:
       2021-10-18: 增加 V_EOBJID, V_MINUTE 以适应外部请求传输数据场景

  =================================================================================*/
  PROCEDURE P_INSERT_INTO_ASNORDERS_ITF(V_ASNID        IN VARCHAR2,
                                        V_COMPID       IN VARCHAR2,
                                        V_GOOID        IN VARCHAR2,
                                        V_ORDERAMOUNT  IN NUMBER,
                                        V_PCOMEAMOUNT  IN NUMBER,
                                        V_ASNGOTAMOUNT IN NUMBER,
                                        V_GOTAMOUNT    IN NUMBER,
                                        V_MEMO         IN VARCHAR2,
                                        V_EOBJID       IN VARCHAR2,
                                        V_MINUTE       IN NUMBER);


  /*=================================================================================

    【正常使用】接入WMS待质检 ASNORDERSITEM 数据

    用途:
      用于接入WMS待质检的ASNORDERED数据

    入参:
      V_ASNID        :  ASN单号
      V_COMPID       :  企业Id
      V_GOOID        :  商品档案编号
      V_ORDERAMOUNT  :  订货量
      V_PCOMEAMOUNT  :  预计到仓量（预计到货量）
      V_ASNGOTAMOUNT :  预到货收货量
      V_GOTAMOUNT    :  到货量
      V_MEMO         :  备注
      V_EOBJID       :  执行对象Id
      V_MINUTE       :  日志等待时间，变量未操作超过 V_MINUTE 分钟，记录到日志

     版本:
       2021-10-18: 增加 V_EOBJID, V_MINUTE 以适应外部请求传输数据场景

  =================================================================================*/
  PROCEDURE P_INSERT_INTO_ASNORDERSITEM_ITF(V_ASNID        IN VARCHAR2,
                                            V_COMPID       IN VARCHAR2,
                                            V_GOOID        IN VARCHAR2,
                                            V_BARCODE      IN VARCHAR2,
                                            V_ORDERAMOUNT  IN NUMBER,
                                            V_PCOMEAMOUNT  IN NUMBER,
                                            V_ASNGOTAMOUNT IN NUMBER,
                                            V_GOTAMOUNT    IN NUMBER,
                                            V_MEMO         IN VARCHAR2,
                                            V_EOBJID       IN VARCHAR2,
                                            V_MINUTE       IN NUMBER);


  /*=================================================================================

    【正常使用】接入熊猫待质检 ASNORDERPACKS 数据

    用途:
      用于接入熊猫待质检的 ASNORDERPACKS 数据

    入参:
      V_ASNID            :  ASN单号
      V_COMPID           :  企业Id
      V_GOOID            :  商品档案编号
      V_GOOSID           :  商品档案编号（辅），如果有条码则为条码值，
                            无条码则为商品档案编号
      V_BARCODE          :  条码
      V_PACK_NO          :  包序号
      V_PACK_BARCODE     :  总箱数
      V_PACKAMOUNT       :  到货量
      V_SKUPACK_NO       :  sku序号
      V_SKUPACK_COUNT    :  sku总箱数
      V_SKU_NUMBER       :  sku数量
      V_RATIOID          :  配码比
      V_PACK_SPECS_SEND  :  送货包装规格
      V_MEMO             :  备注
      V_EOBJID           :  执行对象Id
      V_MINUTE           :  日志等待时间，变量未操作超过 V_MINUTE 分钟，记录到日志

     版本:
       2021-10-18: 增加 V_EOBJID, V_MINUTE 以适应外部请求传输数据场景

  =================================================================================*/
  PROCEDURE P_INSERT_INTO_ASNORDERPACKS_ITF(V_ASNID            IN VARCHAR2,
                                            V_COMPID           IN VARCHAR2,
                                            V_OPERATORID       IN VARCHAR2,
                                            V_GOOID            IN VARCHAR2,
                                            V_GOOSID           IN VARCHAR2,
                                            V_BARCODE          IN VARCHAR2,
                                            V_PACK_NO          IN VARCHAR2,
                                            V_PACK_BARCODE     IN VARCHAR2,
                                            V_PACKNO           IN NUMBER,
                                            V_PACKCOUNT        IN NUMBER,
                                            V_PACKAMOUNT       IN NUMBER,
                                            V_SKUPACK_NO       IN NUMBER,
                                            V_SKUPACK_COUNT    IN NUMBER,
                                            V_SKU_NUMBER       IN NUMBER,
                                            V_RATIOID          IN NUMBER,
                                            V_PACK_SPECS_SEND  IN NUMBER,
                                            V_MEMO             IN VARCHAR2,
                                            V_EOBJID           IN VARCHAR2,
                                            V_MINUTE           IN NUMBER);


  /*=================================================================================

    【正常使用】更新 SCMDATA.T_ASNORDERSITEM 时更新相关业务表和接口表的数据

    用途:
      在更新 SCMDATA.T_ASNORDERSITEM 时使用本过程同时更新 SCMDATA.T_QA_SCOPE，
      SCMDATA.T_ASNINFO_PRETRANS_TO_WMS 对应的数据和状态

    入参:
      V_ASNID    : ASN单号
      V_GOOID    : 货号
      V_BARCODE  : 条码
      V_COMPID   : 企业Id
      V_CURUSER  : 当前操作人Id

    版本:
      2021-11-01 : 在更新 SCMDATA.T_ASNORDERSITEM 时使用本过程同时更新 SCMDATA.T_QA_SCOPE，
                   SCMDATA.T_ASNINFO_PRETRANS_TO_WMS 对应的数据和状态

  =================================================================================*/
  PROCEDURE P_UPDATE_QASCOPE_TAKEOVERTIME(V_ASNID    IN VARCHAR2,
                                          V_GOOID    IN VARCHAR2,
                                          V_BARCODE  IN VARCHAR2,
                                          V_COMPID   IN VARCHAR2,
                                          V_CURUSER  IN VARCHAR2);


  /*=================================================================================

    【正常使用】产生质检任务

    用途:
      将最近5分钟内已获取到的质检数据生成质检任务,
      仅生成仓库为义务仓，品类为鞋包的数据，
      生成后，接口表状态修改为“SS”，
      对于不符合的，接口状态修改为“ME”

    版本:
      2021-11-25: 将最近5分钟内已获取到的质检数据生成质检任务
                  备注：仅生成仓库为义务仓，品类为鞋包的数据

  =================================================================================*/
  PROCEDURE P_SYNC_QA_MISSION;



  /*=================================================================================

    【正常使用】ASNORDERED_ITF 数据同步

    用途:
      将 SCMDATA.T_ASNORDEREDITF 内前300条数据，进行校验，
      如果不存在，则新增到 SCMDATA.T_ASNORDERED
      如果存在，则更新到 SCMDATA.T_ASNORDERED

    版本:
      2021-10-18: 增加 V_EOBJID, V_MINUTE 以适应外部请求传输数据场景

  =================================================================================*/
  PROCEDURE P_ASNORDEREDITF_SYNC;


  /*=================================================================================

    【正常使用】ASNORDERS_ITF 数据同步

    用途:
      将 SCMDATA.T_ASNORDERS_ITF 内前300条数据，进行校验，
      如果不存在，则新增到 SCMDATA.T_ASNORDERS
      如果存在，则更新到 SCMDATA.T_ASNORDERS

    版本:
      2021-10-18: 增加 V_EOBJID, V_MINUTE 以适应外部请求传输数据场景

  =================================================================================*/
  PROCEDURE P_ASNORDERSITF_SYNC;


  /*=================================================================================

    【正常使用】ASNORDERSITEM_ITF 数据同步

    用途:
      将 SCMDATA.T_ASNORDERSITEM_ITF 内前300条数据，进行校验，
      如果不存在，则新增到 SCMDATA.T_ASNORDERSITEM
      如果存在，则更新到 SCMDATA.T_ASNORDERSITEM

    版本:
      2021-10-18: 增加 V_EOBJID, V_MINUTE 以适应外部请求传输数据场景

  =================================================================================*/
  PROCEDURE P_ASNORDERSITEMITF_SYNC;


  /*=================================================================================

    【正常使用】ASNORDEREPACKS_ITF 数据同步

    用途:
      将 SCMDATA.T_ASNORDEREPACKS_ITF 内前300条数据，进行校验，
      如果不存在，则新增到 SCMDATA.T_ASNORDEREPACKS
      如果存在，则更新到 SCMDATA.T_ASNORDEREPACKS

    版本:
      2021-10-18: 增加 V_EOBJID, V_MINUTE 以适应外部请求传输数据场景

  =================================================================================*/
  PROCEDURE P_ASNORDERPACKSITF_SYNC;


  /*=================================================================================

    【正常使用】将 WMS-ASNORDERED 收货信息更新到 SCMDATA.T_ASNORDERED

    用途:
      将至多300条 WMS-ASNORDERED 收货信息更新到 SCMDATA.T_ASNORDERED，
      失败则更新 SCMDATA.T_ASNORDERED_ITF.PORT_STATUS 字段为 UE
            更新 SCMDATA.T_ASNORDERED_ITF.PORT_TIME   字段为 当前时间

    版本:
      2021-10-24: 将至多300条 WMS-ASNORDERED 收货信息更新到 SCMDATA.T_ASNORDERED，
                  失败则更新 SCMDATA.T_ASNORDERED_ITF.PORT_STATUS 字段为 UE
                  更新 SCMDATA.T_ASNORDERED_ITF.PORT_TIME   字段为 当前时间

  =================================================================================*/
  PROCEDURE P_ASNORDERED_ITF_REINFO_SYNC;


  /*=================================================================================

    【正常使用】将 WMS-ASNORDERS 收货信息更新到 SCMDATA.T_ASNORDERS

    用途:
      将至多300条 WMS-ASNORDERS 收货信息更新到 SCMDATA.T_ASNORDERS，
      失败则更新 SCMDATA.T_ASNORDERS_ITF.PORT_STATUS 字段为 UE
            更新 SCMDATA.T_ASNORDERS_ITF.PORT_TIME   字段为 当前时间

    版本:
      2021-10-24: 将至多300条 WMS-ASNORDERS 收货信息更新到 SCMDATA.T_ASNORDERS，
                  失败则更新 SCMDATA.T_ASNORDERS_ITF.PORT_STATUS 字段为 UE
                  更新 SCMDATA.T_ASNORDERS_ITF.PORT_TIME   字段为 当前时间

  =================================================================================*/
  PROCEDURE P_ASNORDERS_ITF_REINFO_SYNC;


  /*=================================================================================

    【正常使用】将 WMS-ASNORDERS 收货信息更新二次重传

    用途:
      将至多300条 WMS-ASNORDERS 收货信息更新到 SCMDATA.T_ASNORDERS，
      失败则更新 SCMDATA.T_ASNORDERS_ITF.PORT_STATUS 字段为 UE
            更新 SCMDATA.T_ASNORDERS_ITF.PORT_TIME   字段为 当前时间

    版本:
      2021-10-24: 将至多300条 WMS-ASNORDERS 收货信息更新到 SCMDATA.T_ASNORDERS，
                  失败则更新 SCMDATA.T_ASNORDERS_ITF.PORT_STATUS 字段为 UE
                  更新 SCMDATA.T_ASNORDERS_ITF.PORT_TIME   字段为 当前时间
      2022-03: 1.至多300条更改为至多500条
               2.旧更新 T_ASNINFO_PRETRANS_TO_WMS 逻辑被 P_UPDATE_ASNPTTOWMS_TO_PD 替换
               3.新增报错时间小于当前时间-7天时，状态由 UE 修改为 ENS（ERROR NOT SYNC）

  =================================================================================*/
  PROCEDURE P_ASNORDERS_ITF_REINFO_ESYNC;


  /*=================================================================================

    【正常使用】将 WMS-ASNORDERSITEM 收货信息更新到 SCMDATA.T_ASNORDERSITEM

    用途:
      将至多300条 WMS-ASNORDERSITEM 收货信息更新到 SCMDATA.T_ASNORDERSITEM，
      失败则更新 SCMDATA.T_ASNORDERSITEM_ITF.PORT_STATUS 字段为 UE
            更新 SCMDATA.T_ASNORDERSITEM_ITF.PORT_TIME   字段为 当前时间

    版本:
      2021-10-24: 将至多300条 WMS-ASNORDERSITEM 收货信息更新到 SCMDATA.T_ASNORDERSITEM，
                  失败则更新 SCMDATA.T_ASNORDERSITEM_ITF.PORT_STATUS 字段为 UE
                        更新 SCMDATA.T_ASNORDERSITEM_ITF.PORT_TIME   字段为 当前时间

  =================================================================================*/
  PROCEDURE P_ASNORDERSITEM_ITF_REINFO_SYNC;


  /*=================================================================================

    【正常使用】将 WMS-ASNORDERSITEM 收货信息错误信息二次同步

    用途:
      将至多1500条 WMS-ASNORDERSITEM 收货信息更新到 SCMDATA.T_ASNORDERSITEM，
      失败则更新 SCMDATA.T_ASNORDERSITEM_ITF.PORT_STATUS 字段为 UE
            更新 SCMDATA.T_ASNORDERSITEM_ITF.PORT_TIME   字段为 当前时间

    版本:
      2022-03-30: 将 WMS-ASNORDERSITEM 收货信息错误信息二次同步

  =================================================================================*/
  PROCEDURE P_ASNORDERSITEM_ITF_REINFO_ESYNC;


  /*=================================================================================

    【正常使用】接入 WMS-ASNORDERED 收获信息到接口表

    用途:
      将 WMS-ASNORDERED 收获信息到接口表

    入参：
      V_ASNID    :   ASN单号
      V_COMPID   :   企业ID
      V_SCTIME   :   到仓扫描时间
      V_CGTIMES  :   修改次数
      V_PCDATE   :   预计到仓日期
      V_PCINTVAL :   预计到仓时段
      V_EOBJID   :   执行对象Id
      V_MINUTE   :  日志等待时间，变量未操作超过 V_MINUTE 分钟，记录到日志

    版本:
      2021-10-18: 增加 V_EOBJID, V_MINUTE 以适应外部请求传输数据场景

  =================================================================================*/
  PROCEDURE P_UPDATE_REINFO_INTO_ASNORDERED(V_ASNID    IN VARCHAR2,
                                            V_COMPID   IN VARCHAR2,
                                            V_SCTIME   IN VARCHAR2,
                                            V_CGTIMES  IN NUMBER,
                                            V_PCDATE   IN VARCHAR2,
                                            V_PCINTVAL IN VARCHAR2,
                                            V_EOBJID   IN VARCHAR2,
                                            V_MINUTE   IN NUMBER);


  /*=================================================================================

    【正常使用】接入 WMS-ASNORDERS 收获信息到接口表

    用途:
      将 WMS-ASNORDERS 收获信息插入到接口表

    入参：
      V_ASNID       :   ASN单号
      V_COMPID      :   企业Id
      V_GOOID       :   商品档案编号
      V_ASNGOTAMT   :   预到货收货量
      V_GOTAMT      :   到货量
      V_RETAMT      :   退货量
      V_PKTIME      :   分拣时间
      V_SMTIME      :   发货时间
      V_WAPOS       :   库位
      V_EOBJID      :   执行对象Id
      V_MINUTE      :  日志等待时间，变量未操作超过 V_MINUTE 分钟，记录到日志

    版本:
      2021-10-18: 增加 V_EOBJID, V_MINUTE 以适应外部请求传输数据场景

  =================================================================================*/
  PROCEDURE P_UPDATE_REINFO_INTO_ASNORDERS(V_ASNID     IN VARCHAR2,
                                           V_COMPID    IN VARCHAR2,
                                           V_GOOID     IN VARCHAR2,
                                           V_ASNGOTAMT IN NUMBER,
                                           V_GOTAMT    IN NUMBER,
                                           V_RETAMT    IN NUMBER,
                                           V_PKTIME    IN VARCHAR2,
                                           V_SMTIME    IN VARCHAR2,
                                           V_RETIME    IN VARCHAR2,
                                           V_WAPOS     IN VARCHAR2,
                                           V_EOBJID    IN VARCHAR2,
                                           V_MINUTE    IN VARCHAR2);


  /*=================================================================================

    【正常使用】接入 WMS-ASNORDERSITEM 收获信息到接口表

    用途:
      将 WMS-ASNORDERSITEM 收获信息插入到接口表

    入参:
      V_ASNID     :  ASN单号
      V_COMPID    :  企业Id
      V_GOOID     :  商品档案编号
      V_BARCODE   :  条码
      V_ASNGOTAMT :  预到货收货量
      V_GOTAMT    :  到货量
      V_RETAMT    :  退货量
      V_PKTIME    :  分拣时间
      V_SMTIME    :  发货时间
      V_RETIME    :  收货时间
      V_WAPOS     :  库位
      V_EOBJID    :   执行对象Id
      V_MINUTE    :  日志等待时间，变量未操作超过 V_MINUTE 分钟，记录到日志


    版本:
      2021-10-18: 增加 V_EOBJID, V_MINUTE 以适应外部请求传输数据场景

  =================================================================================*/
  PROCEDURE P_UPDATE_REINFO_INTO_ASNORDERSITEM(V_ASNID     IN VARCHAR2,
                                               V_COMPID    IN VARCHAR2,
                                               V_GOOID     IN VARCHAR2,
                                               V_BARCODE   IN VARCHAR2,
                                               V_ASNGOTAMT IN NUMBER,
                                               V_GOTAMT    IN NUMBER,
                                               V_RETAMT    IN NUMBER,
                                               V_PKTIME    IN VARCHAR2,
                                               V_SMTIME    IN VARCHAR2,
                                               V_RETIME    IN VARCHAR2,
                                               V_WAPOS     IN VARCHAR2,
                                               V_EOBJID    IN VARCHAR2,
                                               V_MINUTE    IN VARCHAR2);


  /*=================================================================================

    【正常使用】接入WMS质检信息

    用途:
      接入WMS质检信息，存入 SCMDATA.T_QA_WMSRESULT_ITF 用于生成报告

    入参：
      V_ASNID    :  ASN单号
      V_GOOID    :  货号
      V_CFRLT    :  质检确认结果
      V_BCODES   :  条码
      V_CFRLTS   :  SKU质检确认结果
      V_EOBJID   :  执行对象Id
      V_COMPID   :  企业Id

    版本:
      2021-10-24: 接入WMS质检信息，存入 SCMDATA.T_QA_WMSRESULT_ITF 用于生成报告

  =================================================================================*/
  PROCEDURE P_INS_WMSQUALINFO_INTO_ITFTAB(V_ASNID    IN VARCHAR2,
                                          V_GOOID    IN VARCHAR2,
                                          V_CFRLT    IN VARCHAR2,
                                          V_BCODES   IN VARCHAR2,
                                          V_CFRLTS   IN VARCHAR2,
                                          V_EOBJID   IN VARCHAR2,
                                          V_COMPID   IN VARCHAR2);


  /*=================================================================================

    Wms质检确认信息同步

    用途:
      用于Wms质检确认信息同步

    版本:
      2022-06-14 : 用于Wms质检确认信息同步

  =================================================================================*/
  PROCEDURE P_WMSINFO_SYNC;


  /*=================================================================================

    根据Wms质检确认数据生成非返工待确认报告

    用途:
      用于根据Wms质检确认数据生成非返工待确认报告

    入参:
      V_ASNID       :  ASN单号
      V_COMPID      :  企业Id
      V_SYSUSER     :  操作人

    版本:
      2021-11-05 : 用于根据Wms质检确认数据生成非返工待确认报告

  =================================================================================*/
  PROCEDURE P_GEN_NCPCF_QAREP_BYWMSDATA(V_ASNID      IN VARCHAR2,
                                        V_COMPID     IN VARCHAR2,
                                        V_SYSUSER    IN VARCHAR2);


  /*=================================================================================

    根据Wms质检确认数据生成返工待确认报告

    用途:
      用于根据Wms质检确认数据生成返工待确认报告

    入参:
      V_ASNID       :  ASN单号
      V_COMPID      :  企业Id
      V_RAWREPID    :  待返工质检报告id
      V_SYSUSER     :  操作人

    版本:
      2021-11-05 : 用于根据Wms质检确认数据生成返工待确认报告

  =================================================================================*/
  PROCEDURE P_GEN_RCPCF_QAREP_BYWMSDATA(V_ASNID      IN VARCHAR2,
                                        V_COMPID     IN VARCHAR2,
                                        V_RAWREPIDS  IN CLOB,
                                        V_SYSUSER    IN VARCHAR2);


  /*=================================================================================

    根据Wms质检确认数据合并报告

    用途:
      用于根据Wms质检确认数据合并报告

    入参:
      V_ASNID       :  ASN单号
      V_COMPID      :  企业Id
      V_RAWREPID    :  待返工质检报告id
      V_SYSUSER     :  操作人

    版本:
      2022-06-15 : 根据Wms质检确认数据合并报告

  =================================================================================*/
  PROCEDURE P_COMBINE_QAREP_BYWMSDATA(V_ASNID     IN VARCHAR2,
                                      V_COMPID    IN VARCHAR2,
                                      V_RAWREPIDS IN CLOB,
                                      V_SYSUSER   IN VARCHAR2);


  /*=================================================================================

    【正常使用】修改 QA 质检报告 ORIGIN 和 CHECK_TYPE

    用途:
      用于修改 QA 质检报告来源

    入参:
      V_QAREPID     :  QA质检报告Id
      V_COMPID      :  企业Id
      V_RCBARCODES  :  返工质检SKU条码

    版本:
      2021-11-05 : 用于修改 QA 质检报告来源

  =================================================================================*/
  PROCEDURE P_UPDATE_REP_ORIGIN(V_QAREPID     IN VARCHAR2,
                                V_COMPID      IN VARCHAR2,
                                V_RCBARCODES  IN VARCHAR2);


  /*=================================================================================

    【正常使用】更新质检报告质检结果及状态

    用途:
      用于 WMS 质检数据进入业务表时更新质检报告质检结果及状态

    入参:
      V_QAREPID  :  QA质检报告ID
      V_CUID     :  操作人ID
      V_COMPID   :  企业ID

    版本:
      2021-11-08 :  用于 WMS 质检数据进入业务表时更新质检报告质检结果及状态

  =================================================================================*/
  PROCEDURE P_UPDATE_QAREP_CFRESULTANDSTATUS(V_QAREPID   IN VARCHAR2,
                                             V_CUID      IN VARCHAR2,
                                             V_COMPID    IN VARCHAR2);



  /*=================================================================================

    【正常使用】校验是否存在于 SCMDATA.T_ASNINFO_PRETRANS_TO_WMS

    用途:
      用于校验 T_QA_SCOPE 数据是否存在于 SCMDATA.T_ASNINFO_PRETRANS_TO_WMS

    入参:
      V_QAREPID   :  QA质检报告Id
      V_QASCOPEID :  QA质检报告明细Id
      V_COMPID    :  企业Id

    返回值:
      0 不存在，1 存在

    版本:
      2021-10-20 : 从 SCMDATA.PKG_QA_LOGIC 迁移至 SCMDATA.PKG_ASN_INTERFACE

  =================================================================================*/
  FUNCTION F_CHECK_INFO_ALREADY_EXIST(V_QAREPID   IN VARCHAR2,
                                      V_QASCOPEID IN VARCHAR2 DEFAULT NULL,
                                      V_COMPID    IN VARCHAR2) RETURN NUMBER;


  /*=================================================================================

    【正常使用】校验单据内是否存在未收货数据

    用途:
      用于校验 T_QA_SCOPE 数据是否存在 TAKEOVER_TIME 为空，返回值大于0，说明存在
      未收货数据，返回值=0说明不存在未收货数据

    入参:
      V_QAREPID   :  QA质检报告Id
      V_QASCOPEID :  QA质检报告明细Id
      V_COMPID    :  企业Id

    返回值:
      0 不存在，1 存在

    版本:
      2021-11-01 : 新增校验 T_QA_SCOPE 数据是否存在 TAKEOVER_TIME 为空

  =================================================================================*/
  FUNCTION F_GHECK_TAKEOVER_TIME_EXIST(V_QAREPID   IN VARCHAR2,
                                       V_QASCOPEID IN VARCHAR2 DEFAULT NULL,
                                       V_COMPID    IN VARCHAR2) RETURN NUMBER;


  /*=================================================================================

    【正常使用】生成预回传状态

    用途:
      用于生成预回传状态

    入参:
      V_QAREPID   :  QA质检报告Id
      V_QASCOPEID :  QA质检报告明细Id
      V_COMPID    :  企业Id

    返回值:
      ER 已存在，PD 待回传， TE 收货时间不存在

    版本:
      2021-10-20 : 从 SCMDATA.PKG_QA_LOGIC 迁移至 SCMDATA.PKG_ASN_INTERFACE
      2021-11-01 : 新增收货时间校验，新增 TE 返回状态

  =================================================================================*/
  FUNCTION F_GENERATE_ASN_PRETRANS_STATUS(V_QAREPID   IN VARCHAR2,
                                          V_QASCOPEID IN VARCHAR2 DEFAULT NULL,
                                          V_COMPID    IN VARCHAR2) RETURN VARCHAR2;


  /*=================================================================================

    【正常使用】生成 ASN-BARCODE 预回传信息

    用途:
      用于将要预回传到 WMS 的 QA_REPORT_ID, ASN_ID, QA_SCOPE_ID（可选） 存到
      SCMDATA.T_ASNINFO_PRETRANS_TO_WMS

    入参:
      V_QAREPID   :  QA质检报告Id
      V_QASCOPEID :  QA质检报告明细Id
      V_COMPID    :  企业Id
      V_CUID      :  当前操作人Id

    版本:
      2021-10-20 : 从 SCMDATA.PKG_QA_LOGIC 迁移至 SCMDATA.PKG_ASN_INTERFACE
      2021-11-01 : 将原有 STATUS <> 'PD' 不记录的限制去除
      2021-11-02 : 新增入参 ASN_ID 用于解决特批放行

  =================================================================================*/
  PROCEDURE P_GENERATE_ASN_PRETRANS_INFO(V_QAREPID   IN VARCHAR2 DEFAULT NULL,
                                         V_QASCOPEID IN VARCHAR2 DEFAULT NULL,
                                         V_ASNID     IN VARCHAR2 DEFAULT NULL,
                                         V_COMPID    IN VARCHAR2,
                                         V_CUID      IN VARCHAR2,
                                         V_STATUS    IN VARCHAR2 DEFAULT NULL);


  /*=================================================================================

    【正常使用】通过 QA_REPORT_ID 生成 T_QUALRESULT_TO_WMS 预回传信息

    入参:
      V_QAREPID   :  QA质检报告Id
      V_OPERID    :  操作人Id
      V_COMPID    :  企业Id

    版本:
      2022-03-26 : 通过 QA_REPORT_ID 生成 T_QUALRESULT_TO_WMS 预回传信息

  =================================================================================*/
  PROCEDURE P_GEN_ASNPTTOWMS_BY_REPID(V_QAREPID   IN VARCHAR2,
                                      V_OPERID    IN VARCHAR2 DEFAULT NULL,
                                      V_COMPID    IN VARCHAR2);


  /*=================================================================================

    【正常使用】通过 QA_SCOPE_ID 生成 T_QUALRESULT_TO_WMS 预回传信息

    入参:
      V_QASCPID   :  ASN单号
      V_OPERID    :  操作人Id
      V_COMPID    :  企业Id

    版本:
      2022-03-26 : 通过 QA_REPORT_ID 生成 T_QUALRESULT_TO_WMS 预回传信息

  =================================================================================*/
  PROCEDURE P_GEN_ASNPTTOWMS_BY_SCPID(V_QASCPID   IN VARCHAR2,
                                      V_OPERID    IN VARCHAR2 DEFAULT NULL,
                                      V_COMPID    IN VARCHAR2);


  /*=================================================================================

    【正常使用】通过 ASN_ID 生成 T_QUALRESULT_TO_WMS 预回传信息

    入参:
      V_ASNID     :  ASN单号
      V_OPERID    :  操作人Id
      V_COMPID    :  企业Id

    版本:
      2022-03-26 : 通过 QA_REPORT_ID 生成 T_QUALRESULT_TO_WMS 预回传信息

  =================================================================================*/
  PROCEDURE P_GEN_ASNPTTOWMS_BY_ASNID(V_ASNID     IN VARCHAR2,
                                      V_OPERID    IN VARCHAR2 DEFAULT NULL,
                                      V_COMPID    IN VARCHAR2);


  /*=================================================================================

    【正常使用】通过 QA_SCOPE_ID 生成 T_ASNINFO_PRETRANS_TO_WMS 预回传信息

    入参:
      V_QASCPID   :  ASN单号
      V_OPERID    :  操作人Id
      V_COMPID    :  企业Id

    版本:
      2022-03-30 : 通过 QA_SCOPE_ID 生成 T_QUALRESULT_TO_WMS 预回传信息

  =================================================================================*/
  PROCEDURE P_GEN_ASNPTTOWMS_BY_PPSCPID(V_QASCPID  IN VARCHAR2,
                                        V_OPERID   IN VARCHAR2,
                                        V_COMPID   IN VARCHAR2);


  /*=================================================================================

    【正常使用】根据 QA_REPORT_ID,COMPANY_ID 生成质检确认结果json

    用途:
      通过 QA_REPORT_ID,COMPANY_ID 生成质检确认结果JSON字符串，用于回传至 WMS

    入参:
      V_QAREPID   :  QA质检报告Id
      V_COMPID    :  企业Id

    返回样例:
      {
        "ASN_ID": "ASN20210819160955944289000",
        "COMFIRM_RESULT": "PP",
        "SKU_INFO": [{
          "GOO_ID": "440430",
          "GOODSID": "44043001",
          "SKUCOMFIRM_RESULT": "NP",
          "PACK_INFO": [{
            "PACK_BARCODE": "PB440430010045",
            "SUBS_AMOUNT": 0
          }]
        }, {
          "GOO_ID": "440430",
          "GOODSID": "44043002",
          "SKUCOMFIRM_RESULT": "NP",
          "PACK_INFO": [{
            "PACK_BARCODE": "PB440430020024",
            "SUBS_AMOUNT": 0
          }]
        }, {
          "GOO_ID": "440430",
          "GOODSID": "44043003",
          "SKUCOMFIRM_RESULT": "RT",
          "PACK_INFO": [{
            "PACK_BARCODE": "PB440430030013",
            "SUBS_AMOUNT": 0
          }]
        }]
      }

    版本:
      2021-10-20 : 从 SCMDATA.PKG_QA_LOGIC 迁移至 SCMDATA.PKG_ASN_INTERFACE

  =================================================================================*/
  FUNCTION F_GENERATE_COMFIRMRESULT_JSON_WITH_REP(V_QAREPID    IN VARCHAR2,
                                                  V_COMPID     IN VARCHAR2) RETURN CLOB;


  /*=================================================================================

    【停用】根据 QA_SCOPE_IDS,COMPANY_ID 生成质检确认结果json

    用途:
      通过 QA_SCOPE_IDS,COMPANY_ID 生成质检确认结果JSON字符串，用于回传至 WMS

    入参:
      V_QASCOPEID  :  QA质检明细Id
      V_COMPID     :  企业Id

    返回样例:
      {
        "ASN_ID": "ASN20210819160955944289000",
        "COMFIRM_RESULT": "PP",
        "SKU_INFO": [{
          "GOO_ID": "440430",
          "GOODSID": "44043001",
          "SKUCOMFIRM_RESULT": "NP",
          "PACK_INFO": [{
            "PACK_BARCODE": "PB440430010045",
            "SUBS_AMOUNT": 0
          }]
        }]
      }

    版本:
      2021-10-20 : 从 SCMDATA.PKG_QA_LOGIC 迁移至 SCMDATA.PKG_ASN_INTERFACE
      2021-11-25 : WMS 要求按照 ASN 单号进行合并，故停用

  =================================================================================*/
  FUNCTION F_GENERATE_COMFIRMRESULT_JSON_WITH_SCOPE(V_QASCOPEID IN VARCHAR2,
                                                    V_COMPID    IN VARCHAR2) RETURN CLOB;


  /*=================================================================================

    【正常使用】用于生成传入多个 QA_SCOPE_ID 的质检结果 JSON，
                质检结果 JSON 内部按 ASN_ID 合并

    用途:
      用于生成传入多个 QA_SCOPE_ID 的质检结果 JSON

    入参:
      V_QASCOPEIDS :  QA质检范围Id，多值，用逗号分隔
      V_COMPID     :  企业Id

    版本:
      2021-11-25 : 用于生成传入多个 QA_SCOPE_ID 的质检结果 JSON

  =================================================================================*/
  FUNCTION F_GEN_COMFIRMJSON_BYSCPIDS_CBASN(V_QASCOPEIDS  IN VARCHAR2,
                                            V_COMPID      IN VARCHAR2) RETURN CLOB;


  /*=================================================================================

    【正常使用】通过 QA_SCOPE_ID 生成 T_QUALRESULT_TO_WMS 预回传信息

    入参:
      V_ASNID     :  ASN单号
      V_OPERID    :  操作人Id
      V_COMPID    :  企业Id

    版本:
      2022-03-26 : 通过 QA_REPORT_ID 生成 T_QUALRESULT_TO_WMS 预回传信息

  =================================================================================*/
  FUNCTION F_GEN_CFJSON_BY_SCOPE RETURN CLOB;


  /*=================================================================================

    【正常使用】将质检确认结果为“部分通过”的SKU质检确认结果回传给wms

    版本:
      2022-03-30 : 将质检确认结果为“部分通过”的SKU质检确认结果回传给wms

  =================================================================================*/
  FUNCTION F_GEN_CFJSON_BY_PPSCOPE RETURN CLOB;



  /*=================================================================================

    【正常使用】为特批放行单据生成质检确认结果 json

    用途:
      为特批放行单据生成质检确认结果 json

    入参:
      V_ASNID      :  ASN单号
      V_COMPID     :  企业Id

    返回样例:
      {
        "ASN_ID": "ASN20210819160955944289000",
        "COMFIRM_RESULT": "PS",
        "SKU_INFO": [{
          "GOO_ID": "440430",
          "GOODSID": "44043001",
          "SKUCOMFIRM_RESULT": "PS",
          "PACK_INFO": [{
            "PACK_BARCODE": "PB440430010045",
            "SUBS_AMOUNT": 0
          }]
        }]
      }

    版本:
      2021-10-26 : 完成从单个特批ASN生成JSON存储过程，但在外层调用时，
                   需将 SCMDATA.T_ASNORDERED.ORIGIN = SCMSATP(SCM SPECIAL APPROVE TRANS PREPARED)
                   设置为 SCMSATF(SCM SPECIAL APPROVE TRANS FINISHED)


  =================================================================================*/
  FUNCTION F_GENERATE_COMFIRMRESULT_JSON_WITH_SAASN(V_ASNID  VARCHAR2,
                                                    V_COMPID VARCHAR2) RETURN CLOB;


  /*=================================================================================

    【正常使用】根据 QA_REPORT_IDS,COMPANY_ID 生成质检确认结果 JSON

    用途:
      通过校验传入的 QA_REPORT_IDS,COMPANY_ID ，如果质检报告下SKU全部确认收货，
      则生成对应的质检结果确认JSON，否则不生成

    入参:
      V_QAREPIDS : QA质检报告ID，多值用英文逗号分隔
      V_COMPID   : 企业Id

    版本:
      2021-11-01 : 通过校验传入的 QA_REPORT_IDS,COMPANY_ID ，如果存在SKU全部确认收货，
                   则生成对应的质检结果确认JSON
      2021-11-02 : 1.增加预回传信息记录 2.增加接口符合 QA_REPORT_ID 记录

  =================================================================================*/
  FUNCTION F_GENERATE_COMFIRMRESULT_JSON_WITH_REPS(V_QAREPIDS  IN VARCHAR2,
                                                   V_CUID      IN VARCHAR2,
                                                   V_COMPID    IN VARCHAR2) RETURN CLOB;


  /*=================================================================================

   【停用】 根据 QA_SCOPE_IDS,COMPANY_ID 生成质检确认结果json

    用途:
      用于在QA待确认报告-SKU质检确认提交按钮中，通过校验传入的 QA_REPORT_IDS,COMPANY_ID ，
      如果质检报告下SKU全部确认收货，则生成对应的质检结果确认JSON，否则不生成，


    入参:
      V_QAREPIDS : QA质检报告ID，多值用英文逗号分隔
      V_COMPID   : 企业Id

    版本:
      2021-11-01 : 通过校验传入的 QA_REPORT_IDS,COMPANY_ID ，如果存在SKU全部确认收货，
                   则生成对应的质检结果确认JSON
      2021-11-02 : 1.增加预回传信息记录 2.增加接口符合 QA_SCOPE_ID 记录
      2021-11-25 : WMS 要求按照 ASN 单号进行合并，故停用

  =================================================================================*/
  FUNCTION F_GENERATE_COMFIRMRESULT_JSON_WITH_SCOPES(V_QASCOPEIDS  IN VARCHAR2,
                                                     V_CUID        IN VARCHAR2,
                                                     V_COMPID      IN VARCHAR2) RETURN CLOB;


  /*=================================================================================


   【正常使用】 根据 QA_SCOPE_IDS,COMPANY_ID 获取质检确认结果json，
               并对数据进行记录和处理

    用途:
      用于在QA待确认报告-SKU质检确认提交按钮中，通过校验传入的 QA_SCOPE_IDS,COMPANY_ID ，
      如果质检报告下SKU全部确认收货，且来源不包含 WMS ,
      则生成对应的质检结果确认JSON，否则不生成

    入参:
      V_QASCOPEIDS : QA质检范围ID，多值用英文逗号分隔
      V_CUID       : 当前操作人Id
      V_COMPID     : 企业Id

    版本:
      2021-11-25 : 通过校验传入的 QA_REPORT_IDS,COMPANY_ID ，
                   如果存在SKU全部确认收货，且来源不包含 WMS ,
                   则生成对应的质检结果确认JSON

  =================================================================================*/
  FUNCTION F_GET_COMFIRM_JSON_BYSCPIDS_CBASN_PS(V_QASCOPEIDS  IN VARCHAR2,
                                                V_CUID        IN VARCHAR2,
                                                V_COMPID      IN VARCHAR2) RETURN CLOB;



  /*=================================================================================

    【正常使用】根据 ASN_IDS,COMPANY_ID 生成质检确认结果json

    用途:
      用于在QA待确认报告-SKU质检确认提交按钮中，通过校验传入的 QA_REPORT_IDS,COMPANY_ID ，
      如果质检报告下SKU全部确认收货，则生成对应的质检结果确认JSON，否则不生成，


    入参:
      V_QAREPIDS : QA质检报告ID，多值用英文逗号分隔
      V_COMPID   : 企业Id

    版本:
      2021-11-01 : 通过校验传入的 QA_REPORT_IDS,COMPANY_ID ，如果存在SKU全部确认收货，
                   则生成对应的质检结果确认JSON
      2021-11-02 : 1.增加预回传信息记录 2.增加 ASN_ID 记录

  =================================================================================*/
  FUNCTION F_GENERATE_COMFIRMRESULT_JSON_WITH_SAASNS(V_ASNIDS  IN VARCHAR2,
                                                     V_CUID    IN VARCHAR2,
                                                     V_COMPID  IN VARCHAR2) RETURN CLOB;


  /*=================================================================================

    【停用-速狮不支持返回值自定义】生成回传给 WMS 的 ASN_INFO JSON

    用途:
      通过 QA_SCOPE_IDS,COMPANY_ID 生成质检确认结果JSON字符串，用于回传至 WMS

    入参:
      V_QASCOPEID  :  QA质检明细Id
      V_QASCOPEID  :  QA质检明细Id
      V_COMPID     :  企业Id

    版本:
      2021-10-20 : 从 SCMDATA.PKG_QA_LOGIC 迁移至 SCMDATA.PKG_ASN_INTERFACE

  =================================================================================*/
  /*FUNCTION F_GENERATE_ASNINFO_JSON(V_QAREPID  IN VARCHAR2,
                                   V_QASCOPID IN VARCHAR2 DEFAULT NULL,
                                   V_COMPID   IN VARCHAR2) RETURN CLOB;*/


  /*=================================================================================

    【停用-速狮不支持返回值自定义】返回用于传输给 WMS 的质检结果

    用途:
      返回用于传输给 WMS 的质检结果

    版本:
      2021-10-20 : 整合测试

  =================================================================================*/
  /*FUNCTION F_GET_INFO_TO_WMS RETURN CLOB;*/



  /*=================================================================================

    【停用-速狮不支持返回值自定义】生成质检结果重传JSON

    用途:
      用于将前一批传给 WMS 的质检结果数据中的错误数据剔除后，重新生成质检结果JSON,
      进行二次传输

    版本:
      2021-10-27 : 从 SCMDATA.PKG_QA_LOGIC 迁移至 SCMDATA.PKG_ASN_INTERFACE

  =================================================================================*/
  /*FUNCTION F_GET_WMSRETRANS_JSON RETURN CLOB;*/


  /*=================================================================================

    【测试用】生成 ASNORDERPACKS 测试数据

    用途:
      用于生成与 WMS接口测试的 ASNORDERPACKS 数据

    版本:
      2021-10-21 : 接口测试

  =================================================================================*/
  PROCEDURE P_GEN_ASNORDERPACKS_DATA(V_ASNID   IN VARCHAR2,
                                     V_COMPID  IN VARCHAR2,
                                     V_GOOID   IN VARCHAR2,
                                     V_BARCODE IN VARCHAR2);



  /*=================================================================================

    【正常使用】asnordersitem_itf 同步时更新
               t_orders.got_amount, t_ordersitem.got_amount

    用途:
      asnordersitem_itf 同步时更新 t_orders.got_amount, t_ordersitem.got_amount

    入参:
      V_ASNID            :  ASN单号
      V_COMPID           :  企业Id

     版本:
       2021-12-23: asnordersitem_itf 同步时更新
                   t_orders.got_amount, t_ordersitem.got_amount

  =================================================================================*/
  PROCEDURE P_UPDATE_ORDS_AND_ORDSITEM_GOTAMT(V_ASNID  IN VARCHAR2,
                                              V_COMPID IN VARCHAR2);



  /*=================================================================================

    【正常使用】 asnorders_itf 同步时更新收货记录

    用途:
      asnorders_itf 同步时更新收货记录

    入参:
      V_ASNID            :  ASN单号
      V_COMPID           :  企业Id

     版本:
       2021-12-23: asnorders_itf 同步时更新收货记录

  =================================================================================*/
  PROCEDURE P_SYNC_ORD_DELIVERY_REC(V_ASNID  IN VARCHAR2,
                                    V_COMPID IN VARCHAR2);



  /*=================================================================================

    【正常使用】 asnordersitem_itf 同步时更新收货记录表

    用途:
      asnordersitem_itf 同步时更新收货记录表

    入参:
      V_ASNID    :  ASN单号
      V_GOOID    :  货号
      V_BARCODE  :  SKU条码
      V_COMPID   :  企业Id

     版本:
       2021-12-23: asnordersitem_itf 同步时更新收货记录表

  =================================================================================*/
  PROCEDURE P_SYNC_ORDSITEM_DELIVERY_REC(V_ASNID   IN VARCHAR2,
                                         V_GOOID   IN VARCHAR2,
                                         V_BARCODE IN VARCHAR2,
                                         V_COMPID  IN VARCHAR2);


  /*=================================================================================

    【正常使用】删除 ASNORDERSITEM.PCOME_AMOUNT = 0 的数据

    用途:
      将某一条 ASN 下 ASNORDERSITEM.PCOME_AMOUNT = 0 的数据删除，
      并且更新 ASNORDERS.ORDER_AMOUNT/PCOME_AMOUNT
            和 T_QA_REPORT.ORIGIN

    入参:


    版本:
      2022-01-12: 删除 ASNORDERSITEM.PCOME_AMOUNT = 0 的数据

  =================================================================================*/
  PROCEDURE P_DEL_PCOMEAMT_EQUALS_ZERO(V_ASNID   IN VARCHAR2,
                                       V_COMPID  IN VARCHAR2);


END PKG_ASN_INTERFACE;
/

CREATE OR REPLACE PACKAGE BODY SCMDATA.PKG_ASN_INTERFACE IS

  /*=================================================================================

    【正常使用】校验待传入 ASNORDERED_ITF 数据是否存在

    用途:
      用于校验传入数据是否存在于 SCMDATA.T_ASNORDERED_ITF

    入参:
      V_ASNID    :  ASN单号
      V_COMPID   :  企业id
      V_JUGNUM   :  判断变量（数字）
      V_PTSTATUS :  接口数据状态

    返回值:
      V_JUGNUM : 等于0，不存在于 SCMDATA.T_ASNORDERED_ITF 中，
                 等于1，存在于 SCMDATA.T_ASNORDERED_ITF 中

      V_PTSTATUS : RE-执行错误
                    CE-校验错误
                    SP-待同步
                    SS-已同步
                    SE-同步错误
                    UP-待更新
                    US-已更新
                    UE-更新错误

     版本:
       2021-10-18: 整合判断变量，接口数据状态作为返回值

  =================================================================================*/
  PROCEDURE P_CHECK_ASNORDERED_EXISTS(V_ASNID     IN VARCHAR2,
                                      V_COMPID    IN VARCHAR2,
                                      V_JUGNUM    IN OUT NUMBER,
                                      V_PTSTATUS  IN OUT VARCHAR2) IS
    V_EXESQL  VARCHAR2(1024);
  BEGIN
    IF V_PTSTATUS IS NOT NULL THEN
      V_EXESQL := 'SELECT COUNT(1) FROM SCMDATA.T_ASNORDERED_ITF WHERE ASN_ID = :A AND COMPANY_ID = :B AND ROWNUM = 1';
      EXECUTE IMMEDIATE V_EXESQL INTO V_JUGNUM USING V_ASNID, V_COMPID;
    ELSE
      V_EXESQL := 'SELECT COUNT(1), MAX(PORT_STATUS) FROM SCMDATA.T_ASNORDERED_ITF WHERE ASN_ID = :A AND COMPANY_ID = :B AND ROWNUM = 1';
      EXECUTE IMMEDIATE V_EXESQL INTO V_JUGNUM, V_PTSTATUS USING V_ASNID, V_COMPID;
    END IF;
  END P_CHECK_ASNORDERED_EXISTS;




  /*=================================================================================

    【正常使用】校验待传入 ASNORDERS_ITF 数据是否存在

    用途:
      用于校验传入数据是否存在于 SCMDATA.T_ASNORDERS_ITF

    入参:
      V_ASNID    :  ASN单号
      V_COMPID   :  企业Id
      V_GOOID    :  商品档案编号
      V_JUGNUM   :  判断变量（数字）
      V_PTSTATUS :  接口数据状态

    返回值:
      V_JUGNUM : 等于0，不存在于 SCMDATA.T_ASNORDERS_ITF 中，
                 等于1，存在于 SCMDATA.T_ASNORDERS_ITF 中

      V_PTSTATUS :  RE-执行错误
                    CE-校验错误
                    SP-待同步
                    SS-已同步
                    SE-同步错误
                    UP-待更新
                    US-已更新
                    UE-更新错误

     版本:
       2021-10-18: 整合判断变量，接口数据状态作为返回值

  =================================================================================*/
  PROCEDURE P_CHECK_ASNORDERS_EXISTS(V_ASNID     IN VARCHAR2,
                                     V_COMPID    IN VARCHAR2,
                                     V_GOOID     IN VARCHAR2,
                                     V_JUGNUM    IN OUT NUMBER,
                                     V_PTSTATUS  IN OUT VARCHAR2) IS
    V_EXESQL  VARCHAR2(1024);
  BEGIN
    IF V_PTSTATUS IS NOT NULL THEN
      V_EXESQL := 'SELECT COUNT(1) FROM SCMDATA.T_ASNORDERS_ITF WHERE ASN_ID = :A AND COMPANY_ID = :B AND GOO_ID = :C AND ROWNUM = 1';
      EXECUTE IMMEDIATE V_EXESQL INTO V_JUGNUM USING V_ASNID, V_COMPID, V_GOOID;
    ELSE
      V_EXESQL := 'SELECT COUNT(1), MAX(PORT_STATUS) FROM SCMDATA.T_ASNORDERS_ITF WHERE ASN_ID = :A AND COMPANY_ID = :B AND GOO_ID = :C AND ROWNUM = 1';
      EXECUTE IMMEDIATE V_EXESQL INTO V_JUGNUM, V_PTSTATUS USING V_ASNID, V_COMPID, V_GOOID;
    END IF;
  END P_CHECK_ASNORDERS_EXISTS;



  /*=================================================================================

    【正常使用】校验待传入 ASNORDERSITEM_ITF 数据是否存在

    用途:
      用于校验传入数据是否存在于 SCMDATA.T_ASNORDERSITEM_ITF

    入参:
      V_ASNID    :  ASN单号
      V_COMPID   :  企业Id
      V_BARCODE  :  条码
      V_JUGNUM   :  判断变量（数字）
      V_PTSTATUS :  接口数据状态

    返回值:
      V_JUGNUM : 等于0，不存在于 SCMDATA.T_ASNORDERS_ITF 中，
                 等于1，存在于 SCMDATA.T_ASNORDERS_ITF 中

      V_PTSTATUS :  RE-执行错误
                    CE-校验错误
                    SP-待同步
                    SS-已同步
                    SE-同步错误
                    UP-待更新
                    US-已更新
                    UE-更新错误

     版本:
       2021-10-18: 整合判断变量，接口数据状态作为返回值

  =================================================================================*/
  PROCEDURE P_CHECK_ASNORDERSITEM_EXISTS(V_ASNID     IN VARCHAR2,
                                         V_COMPID    IN VARCHAR2,
                                         V_BARCODE   IN VARCHAR2,
                                         V_JUGNUM    IN OUT NUMBER,
                                         V_PTSTATUS  IN OUT VARCHAR2) IS
    V_EXESQL  VARCHAR2(1024);
  BEGIN
    IF V_PTSTATUS IS NOT NULL THEN
      V_EXESQL := 'SELECT COUNT(1) FROM SCMDATA.T_ASNORDERSITEM_ITF WHERE ASN_ID = :A AND COMPANY_ID = :B AND BARCODE = :C AND ROWNUM = 1';
      EXECUTE IMMEDIATE V_EXESQL INTO V_JUGNUM USING V_ASNID, V_COMPID, V_BARCODE;
    ELSE
      V_EXESQL := 'SELECT COUNT(1), MAX(PORT_STATUS) FROM SCMDATA.T_ASNORDERSITEM_ITF WHERE ASN_ID = :A AND COMPANY_ID = :B AND BARCODE = :C AND ROWNUM = 1';
      EXECUTE IMMEDIATE V_EXESQL INTO V_JUGNUM, V_PTSTATUS USING V_ASNID, V_COMPID, V_BARCODE;
    END IF;
  END P_CHECK_ASNORDERSITEM_EXISTS;



  /*=================================================================================

    【正常使用】校验待传入 WMS 质检数据是否存在于 SCMDATA.T_QA_WMSRESULT_ITF

    用途:
      用于校验传入数据是否存在于 SCMDATA.T_QA_WMSRESULT_ITF

    入参:
      V_ASNID    :  ASN单号
      V_COMPID   :  企业Id
      V_BARCODES :  条码
      V_JUGNUM   :  判断变量（数字）
      V_PTSTATUS :  接口数据状态

    返回值:
      V_JUGNUM : 等于0，不存在于 SCMDATA.T_QA_WMSRESULT_ITF 中，
                 等于1，存在于 SCMDATA.T_QA_WMSRESULT_ITF 中

      V_PTSTATUS :  RE-执行错误
                    CE-校验错误
                    SP-待同步
                    SS-已同步
                    SE-同步错误
                    UP-待更新
                    US-已更新
                    UE-更新错误

     版本:
       2021-10-24: 整合判断变量，接口数据状态作为返回值

  =================================================================================*/
  PROCEDURE P_CHECK_WMSRESULT_EXISTS(V_ASNID     IN VARCHAR2,
                                     V_COMPID    IN VARCHAR2,
                                     V_BARCODES  IN VARCHAR2,
                                     V_JUGNUM    IN OUT NUMBER,
                                     V_PTSTATUS  IN OUT VARCHAR2) IS
    V_EXESQL  VARCHAR2(1024);
  BEGIN
    IF V_PTSTATUS IS NOT NULL THEN
      V_EXESQL := 'SELECT COUNT(1) FROM SCMDATA.T_QA_WMSRESULT_ITF WHERE ASN_ID = :A AND COMPANY_ID = :B AND BARCODES = :C AND ROWNUM = 1';
      EXECUTE IMMEDIATE V_EXESQL INTO V_JUGNUM USING V_ASNID, V_COMPID, V_BARCODES;
    ELSE
      V_EXESQL := 'SELECT COUNT(1), MAX(PORT_STATUS) FROM SCMDATA.T_QA_WMSRESULT_ITF WHERE ASN_ID = :A AND COMPANY_ID = :B AND BARCODES = :C AND ROWNUM = 1';
      EXECUTE IMMEDIATE V_EXESQL INTO V_JUGNUM, V_PTSTATUS USING V_ASNID, V_COMPID, V_BARCODES;
    END IF;
  END P_CHECK_WMSRESULT_EXISTS;



  /*=================================================================================

    【正常使用】校验待传入 SCMDATA.T_ASNORDERPACKS_ITF 数据是否存在

    用途:
      用于校验传入数据是否存在于 SCMDATA.T_ASNORDERPACKS_ITF

    入参:
      V_ASNID        :  ASN单号
      V_COMPID       :  企业Id
      V_GOODSID      :  货号/条码
      V_PACKBARCODE  :  箱号
      V_JUGNUM       :  判断变量（数字）
      V_PTSTATUS     :  接口数据状态

    返回值:
      V_JUGNUM : 等于0，不存在于 SCMDATA.T_ASNORDERS_ITF 中，
                 等于1，存在于 SCMDATA.T_ASNORDERS_ITF 中

      V_PTSTATUS :  RE-执行错误
                    CE-校验错误
                    SP-待同步
                    SS-已同步
                    SE-同步错误
                    UP-待更新
                    US-已更新
                    UE-更新错误

     版本:
       2022-01-04: 整合判断变量，接口数据状态作为返回值

  =================================================================================*/
  PROCEDURE P_CHECK_ASNORDERPACKS_EXISTS(V_ASNID        IN VARCHAR2,
                                         V_COMPID       IN VARCHAR2,
                                         V_GOODSID      IN VARCHAR2,
                                         V_PACKBARCODE  IN VARCHAR2,
                                         V_JUGNUM       IN OUT NUMBER,
                                         V_PTSTATUS     IN OUT VARCHAR2) IS
    V_EXESQL  VARCHAR2(1024);
  BEGIN
    IF V_PTSTATUS IS NOT NULL THEN
      V_EXESQL := 'SELECT COUNT(1) FROM SCMDATA.T_ASNORDERPACKS_ITF WHERE ASN_ID = :A AND COMPANY_ID = :B AND GOODSID = :C AND PACK_BARCODE = :D AND ROWNUM = 1';
      EXECUTE IMMEDIATE V_EXESQL INTO V_JUGNUM USING V_ASNID, V_COMPID, V_GOODSID, V_PACKBARCODE;
    ELSE
      V_EXESQL := 'SELECT COUNT(1), MAX(PORT_STATUS) FROM SCMDATA.T_ASNORDERPACKS_ITF WHERE ASN_ID = :A AND COMPANY_ID = :B AND GOODSID = :C AND PACK_BARCODE = :D AND ROWNUM = 1';
      EXECUTE IMMEDIATE V_EXESQL INTO V_JUGNUM, V_PTSTATUS USING V_ASNID, V_COMPID, V_GOODSID, V_PACKBARCODE;
    END IF;
  END P_CHECK_ASNORDERPACKS_EXISTS;



  /*===================================================================================

    更新 ASN_PRETRANS_TO_WMS 最近更新人和最近更新时间

    用途:
      用于更新 ASN_PRETRANS_TO_WMS 最近更新人和最近更新时间

    入参:
      V_QAREPID  :  QA报告Id
      V_QASCPID  :  QA范围Id
      V_ASNID    :  ASN单据Id
      V_OPEROBJ  :  操作对象
      V_COMPID   :  企业Id

    版本:
      2022-03-22 : 用于更新 ASN_PRETRANS_TO_WMS 最近更新人和最近更新时间

  ===================================================================================*/
  PROCEDURE P_UPD_ASNPRETRANSWMS_LASTINFO(V_QAREPID  IN VARCHAR2 DEFAULT NULL,
                                          V_QASCPID  IN VARCHAR2 DEFAULT NULL,
                                          V_ASNID    IN VARCHAR2 DEFAULT NULL,
                                          V_OPEROBJ  IN VARCHAR2,
                                          V_COMPID   IN VARCHAR2) IS

  BEGIN
    IF V_QAREPID IS NOT NULL THEN
      UPDATE SCMDATA.T_ASNINFO_PRETRANS_TO_WMS
         SET LASTUPD_ID = V_OPEROBJ,
             LASTUPD_TIME = SYSDATE
       WHERE QA_REPORT_ID = V_QAREPID
         AND COMPANY_ID = V_COMPID;
    ELSIF V_QASCPID IS NOT NULL THEN
      UPDATE SCMDATA.T_ASNINFO_PRETRANS_TO_WMS
         SET LASTUPD_ID = V_OPEROBJ,
             LASTUPD_TIME = SYSDATE
       WHERE QA_SCOPE_ID = V_QASCPID
         AND COMPANY_ID = V_COMPID;
    ELSIF V_ASNID IS NOT NULL THEN
      UPDATE SCMDATA.T_ASNINFO_PRETRANS_TO_WMS
         SET LASTUPD_ID = V_OPEROBJ,
             LASTUPD_TIME = SYSDATE
       WHERE ASN_ID = V_ASNID
         AND COMPANY_ID = V_COMPID;
    END IF;
  END P_UPD_ASNPRETRANSWMS_LASTINFO;



  /*=================================================================================

    【正常使用】更新 T_ASNINFO_PRETRANS_TO_WMS 状态为 PD

    用途:
      将与传入的 ASN_ID, BARCODE, COMPANY_ID 相关的 QA_REPORT_ID/ QA_SCOPE_ID/ ASN_ID
      且 STATUS = “SE” 的数据状态修改为 “PD”

    版本:
      2021-11-05: 将与传入的 ASN_ID, BARCODE, COMPANY_ID 相关的
                  QA_REPORT_ID/ QA_SCOPE_ID/ ASN_ID 且 STATUS = “SE” 的数据状态修改为 “PD”

  =================================================================================*/
  PROCEDURE P_UPDATE_PRETRANSINFO(V_ASNID   IN VARCHAR2,
                                  V_BARCODE IN VARCHAR2,
                                  V_COMPID  IN VARCHAR2) IS
    V_REPIDS CLOB;
    V_SCPIDS CLOB;
    V_ASNIDS CLOB;
  BEGIN
    SELECT LISTAGG(DISTINCT QA_REPORT_ID, ',')
      INTO V_REPIDS
      FROM SCMDATA.T_ASNINFO_PRETRANS_TO_WMS JUGTAB1
     WHERE QA_REPORT_ID IS NOT NULL
       AND STATUS = 'SE'
       AND EXISTS (SELECT 1
              FROM SCMDATA.T_QA_SCOPE
             WHERE ASN_ID = V_ASNID
               AND BARCODE = V_BARCODE
               AND COMPANY_ID = V_COMPID
               AND QA_REPORT_ID = JUGTAB1.QA_REPORT_ID
               AND COMPANY_ID = JUGTAB1.COMPANY_ID);

    SELECT LISTAGG(DISTINCT QA_SCOPE_ID, ',')
      INTO V_SCPIDS
      FROM SCMDATA.T_ASNINFO_PRETRANS_TO_WMS JUGTAB2
     WHERE QA_SCOPE_ID IS NOT NULL
       AND STATUS = 'SE'
       AND EXISTS (SELECT 1
              FROM SCMDATA.T_QA_SCOPE
             WHERE ASN_ID = V_ASNID
               AND BARCODE = V_BARCODE
               AND COMPANY_ID = V_COMPID
               AND QA_SCOPE_ID = JUGTAB2.QA_SCOPE_ID
               AND COMPANY_ID = JUGTAB2.COMPANY_ID);

    SELECT LISTAGG(DISTINCT ASN_ID, ',')
      INTO V_ASNIDS
      FROM SCMDATA.T_ASNINFO_PRETRANS_TO_WMS JUGTAB3
     WHERE ASN_ID IS NOT NULL
       AND STATUS = 'SE'
       AND EXISTS (SELECT 1
              FROM SCMDATA.T_ASNORDERED
             WHERE ASN_ID = V_ASNID
               AND STATUS = 'SA'
               AND COMPANY_ID = V_COMPID
               AND ASN_ID = JUGTAB3.ASN_ID
               AND COMPANY_ID = JUGTAB3.COMPANY_ID);

    UPDATE SCMDATA.T_ASNINFO_PRETRANS_TO_WMS
       SET STATUS = 'PD'
     WHERE (INSTR(',' || V_REPIDS || ',', ',' || QA_REPORT_ID || ',') > 0 OR
            INSTR(',' || V_SCPIDS || ',', ',' || QA_SCOPE_ID || ',') > 0 OR
            INSTR(',' || V_ASNIDS || ',', ',' || ASN_ID || ',') > 0)
       AND STATUS = 'SE'
       AND COMPANY_ID = V_COMPID;
  END P_UPDATE_PRETRANSINFO;



  /*=================================================================================

    【正常使用】更新 T_ASNINFO_PRETRANS_TO_WMS 状态为 PD

    入参:
      V_ASNID    :  asn单号
      V_GOOID    :  商品档案编号
      V_BARCODE  :  条码
      V_COMPID   :  企业Id

    版本:
      2022-03-26: 将与传入的 ASN_ID, GOO_ID, BARCODE, COMPANY_ID 相关的 QA_SCOPE_ID
                  且 STATUS = “SE” 的数据状态修改为 “PD”

  =================================================================================*/
  PROCEDURE P_UPDATE_ASNPTTOWMS_TO_PD(V_ASNID   IN VARCHAR2,
                                      V_GOOID   IN VARCHAR2,
                                      V_BARCODE IN VARCHAR2,
                                      V_COMPID  IN VARCHAR2) IS
    V_JUGNUM       NUMBER(1);
    V_ORDSIJUGNUM  NUMBER(1);
    V_ORDSJUGNUM   NUMBER(1);
  BEGIN
    IF V_BARCODE IS NOT NULL THEN
      UPDATE SCMDATA.T_ASNINFO_PRETRANS_TO_WMS
         SET STATUS = 'PD'
       WHERE QA_SCOPE_ID IS NOT NULL
         AND STATUS IN ('SE','NT')
         AND (QA_SCOPE_ID,COMPANY_ID)
          IN (SELECT QA_SCOPE_ID,COMPANY_ID
                FROM SCMDATA.T_QA_SCOPE
               WHERE ASN_ID = V_ASNID
                 AND GOO_ID = V_GOOID
                 AND BARCODE = V_BARCODE
                 AND COMPANY_ID = V_COMPID);

      UPDATE SCMDATA.T_ASNINFO_PRETRANS_TO_WMS
         SET STATUS = 'PD'
       WHERE PP_QA_SCOPE_ID IS NOT NULL
         AND STATUS IN ('SE','NT')
         AND (PP_QA_SCOPE_ID,COMPANY_ID)
          IN (SELECT QA_SCOPE_ID,COMPANY_ID
                FROM SCMDATA.T_QA_SCOPE
               WHERE ASN_ID = V_ASNID
                 AND GOO_ID = V_GOOID
                 AND BARCODE = V_BARCODE
                 AND COMPANY_ID = V_COMPID);
    ELSE
      UPDATE SCMDATA.T_ASNINFO_PRETRANS_TO_WMS
         SET STATUS = 'PD'
       WHERE QA_SCOPE_ID IS NOT NULL
         AND STATUS IN ('SE','NT')
         AND (QA_SCOPE_ID,COMPANY_ID)
          IN (SELECT QA_SCOPE_ID,COMPANY_ID
                FROM SCMDATA.T_QA_SCOPE
               WHERE ASN_ID = V_ASNID
                 AND GOO_ID = V_GOOID
                 AND BARCODE IS NULL
                 AND COMPANY_ID = V_COMPID);

      UPDATE SCMDATA.T_ASNINFO_PRETRANS_TO_WMS
         SET STATUS = 'PD'
       WHERE PP_QA_SCOPE_ID IS NOT NULL
         AND STATUS IN ('SE','NT')
         AND (PP_QA_SCOPE_ID,COMPANY_ID)
          IN (SELECT QA_SCOPE_ID,COMPANY_ID
                FROM SCMDATA.T_QA_SCOPE
               WHERE ASN_ID = V_ASNID
                 AND GOO_ID = V_GOOID
                 AND BARCODE IS NULL
                 AND COMPANY_ID = V_COMPID);
    END IF;

    SELECT COUNT(1)
      INTO V_JUGNUM
      FROM SCMDATA.T_ASNINFO_PRETRANS_TO_WMS
     WHERE ASN_ID = V_ASNID
       AND STATUS IN ('SE','NT')
       AND COMPANY_ID = V_COMPID
       AND ROWNUM = 1;

    IF V_JUGNUM = 1 THEN
      SELECT COUNT(1)
        INTO V_ORDSIJUGNUM
        FROM SCMDATA.T_ASNORDERSITEM_ITF
       WHERE ASN_ID = V_ASNID
         AND RECEIVE_TIME IS NULL
         AND COMPANY_ID = V_COMPID
         AND ROWNUM = 1;

      SELECT COUNT(1)
        INTO V_ORDSJUGNUM
        FROM SCMDATA.T_ASNORDERS_ITF
       WHERE ASN_ID = V_ASNID
         AND RECEIVE_TIME IS NULL
         AND COMPANY_ID = V_COMPID
         AND ROWNUM = 1;

      IF V_ORDSIJUGNUM = 0 AND V_ORDSJUGNUM = 0 THEN
        UPDATE SCMDATA.T_ASNINFO_PRETRANS_TO_WMS
           SET STATUS = 'PD'
         WHERE ASN_ID = V_ASNID
           AND STATUS IN ('SE','NT')
           AND COMPANY_ID = V_COMPID;
      END IF;
    END IF;
  END P_UPDATE_ASNPTTOWMS_TO_PD;



  /*=================================================================================

    【正常使用】ASN接口通用校验

    用途:
      用于ASN单相关数据进入到接口表后的通用校验，校验通过/不通过更新接口表，
      接口数据状态（PORT_STATUS）字段，通过则更新接口数据状态为 V_SUCSTATUS，
      不通过则更新为 CE

    入参:
      V_TAB       :  被校验接口表
      V_ASNID     :  ASN单号
      V_GOOID     :  货号，可不填，填写则校验货号是否存在于商品档案中
      V_BARCODE   :  SKU条码，可不填，填写则生成对应的条件
      V_SUPCODE   :  供应商编号，可不填，填写则校验供应商货号是否存在于供应商档案中
      V_COMPANYID :  企业Id
      V_EOBJID    :  执行接口的Element_id
      V_SUCSTATUS :  校验正确编码

     版本:
       2021-10-18:增加 V_SUCSTATUS 以适用于更多场景
       2021-12-28:对 ASNORDERS_ITF 和 ASNORDERSITEM_ITF 增加语句更新条件

  =================================================================================*/
  PROCEDURE P_CHECK_ASNINFO(V_TAB         IN VARCHAR2,
                            V_ASNID       IN VARCHAR2,
                            V_GOOID       IN VARCHAR2 DEFAULT NULL,
                            V_BARCODE     IN VARCHAR2 DEFAULT NULL,
                            V_COMPANYID   IN VARCHAR2,
                            V_EOBJID      IN VARCHAR2,
                            V_SUCSTATUS   IN VARCHAR2 DEFAULT NULL) IS
    V_GOODID       VARCHAR2(512);
    V_ERRINFO      VARCHAR2(512);
    V_ADDCOND      VARCHAR2(256);
    V_EXESQL       VARCHAR2(1024);
  BEGIN
    --商品档案是否存在校验
    IF V_GOOID IS NOT NULL THEN
      V_GOODID := SCMDATA.PKG_INTERFACE_LOG.F_CHECK_GOOD_AND_GENERATE_ERRINFO(V_GOOID   => V_GOOID,
                                                                              V_COMPID  => V_COMPANYID);
      IF (UPPER(V_TAB) = 'SCMDATA.T_ASNORDERS_ITF' OR UPPER(V_TAB) = 'SCMDATA.T_ASNORDERSITEM_ITF') THEN
        V_ADDCOND := ' AND GOO_ID = ''' || V_GOOID ||'''';
      END IF;
    END IF;

    IF (UPPER(V_TAB) = 'SCMDATA.T_ASNORDERS_ITF' OR UPPER(V_TAB) = 'SCMDATA.T_ASNORDERSITEM_ITF') AND V_BARCODE IS NOT NULL THEN
        V_ADDCOND := ' AND BARCODE = ''' || V_BARCODE ||'''';
      END IF;

   /* --供应商档案是否存在校验
    IF V_SUPCODE IS NOT NULL THEN
      V_SUPPCODE := SCMDATA.PKG_INTERFACE_LOG.F_CHECK_SUPPLIER_AND_GENERATE_ERRINFO(V_SUPPLIER_CODE => V_SUPCODE,
                                                                                    V_COMPID        => V_COMPANYID);
    END IF;

    IF INSTR(V_GOODID,'错误信息')>0 AND INSTR(V_SUPPCODE,'错误信息')>0 THEN
      V_ERRINFO := '错误表:'||V_TAB||CHR(10)||
                   '错误时间:'||TO_CHAR(SYSDATE,'YYYY-MM-DD HH24-MI-SS')||CHR(10)||
                   '错误唯一列:ASN_ID'||CHR(10)||
                   '错误唯一值:'||V_ASNID||'-'||V_GOODID||'-'||V_SUPPCODE;
    ELSIF INSTR(V_GOODID,'错误信息')>0 THEN
      V_ERRINFO := '错误表:'||V_TAB||CHR(10)||
                   '错误时间:'||TO_CHAR(SYSDATE,'YYYY-MM-DD HH24-MI-SS')||CHR(10)||
                   '错误唯一列:ASN_ID'||CHR(10)||
                   '错误唯一值:'||V_ASNID||'-'||V_GOODID;
    ELSIF INSTR(V_SUPPCODE,'错误信息')>0 THEN
      V_ERRINFO := '错误表:'||V_TAB||CHR(10)||
                   '错误时间:'||TO_CHAR(SYSDATE,'YYYY-MM-DD HH24-MI-SS')||CHR(10)||
                   '错误唯一列:ASN_ID'||CHR(10)||
                   '错误唯一值:'||V_ASNID||'-'||V_SUPPCODE;
    END IF;*/
    IF INSTR(V_GOODID,'错误信息')>0 THEN
      V_ERRINFO := '错误表:'||V_TAB||CHR(10)||
                   '错误时间:'||TO_CHAR(SYSDATE,'YYYY-MM-DD HH24-MI-SS')||CHR(10)||
                   '错误唯一列:ASN_ID'||CHR(10)||
                   '错误唯一值:'||V_ASNID||'-'||V_GOODID;
    END IF;

    IF INSTR(V_ERRINFO,'错误信息') > 0 THEN
      SCMDATA.PKG_INTERFACE_LOG.P_UPDATE_INTERFACE_VARIABLE(V_EOBJID  => V_EOBJID,
                                                            V_COMPID  => V_COMPANYID,
                                                            V_UNQVAL  => V_ASNID,
                                                            V_ERRINFO => V_ERRINFO,
                                                            V_MODE    => 'CE');
      V_EXESQL := 'UPDATE '||V_TAB||' SET PORT_ELEMENT = '''||V_EOBJID||
                  ''', PORT_STATUS = ''CE'', PORT_TIME = SYSDATE WHERE ASN_ID = :A AND COMPANY_ID = :B'||V_ADDCOND;
    ELSE
      SCMDATA.PKG_VARIABLE.P_SET_VARIABLE_INCREMENT(V_OBJID    => V_EOBJID,
                                                    V_COMPID   => V_COMPANYID,
                                                    V_VARNAME  => 'SSNUM');
      IF V_SUCSTATUS IS NOT NULL THEN
        V_EXESQL := 'UPDATE '||V_TAB||' SET PORT_ELEMENT = '''||V_EOBJID||
                     ''', PORT_STATUS = '''||V_SUCSTATUS||''', PORT_TIME = SYSDATE WHERE ASN_ID = :A AND COMPANY_ID = :B'||V_ADDCOND;
      ELSE
        V_EXESQL := 'UPDATE '||V_TAB||' SET PORT_ELEMENT = '''||V_EOBJID||''', PORT_TIME = SYSDATE WHERE ASN_ID = :A AND COMPANY_ID = :B'||V_ADDCOND;
      END IF;
    END IF;
    EXECUTE IMMEDIATE V_EXESQL USING V_ASNID, V_COMPANYID;
  END P_CHECK_ASNINFO;



  /*=================================================================================

    【正常使用】接入WMS待质检 ASNORDERED 数据

    用途:
      用于接入WMS待质检的 ASNORDERED 数据

    入参:
      V_ASNID      :  ASN单号
      V_COMPID     :  企业Id
      V_ORDERID    :  订单号
      V_SUPCODE    :  供应商编号
      V_PCOMEDATE  :  预计到仓日期
      V_PCOMEINTER :  预计到仓时段
      V_SCANTIME   :  扫描时间
      V_MEMO       :  备注
      V_EOBJID     :  执行对象Id
      V_MINUTE       :  日志等待时间，变量未操作超过 V_MINUTE 分钟，记录到日志

     版本:
       2021-10-18: 增加 V_EOBJID, V_MINUTE 以适应外部请求传输数据场景

  =================================================================================*/
  PROCEDURE P_INSERT_INTO_ASNORDERED_ITF(V_ASNID      IN VARCHAR2,
                                         V_COMPID     IN VARCHAR2,
                                         V_ORDERID    IN VARCHAR2,
                                         V_SUPCODE    IN VARCHAR2,
                                         V_PCOMEDATE  IN VARCHAR2,
                                         V_PCOMEINTER IN VARCHAR2,
                                         V_SCANTIME   IN VARCHAR2,
                                         V_MEMO       IN VARCHAR2,
                                         V_EOBJID     IN VARCHAR2,
                                         V_MINUTE     IN NUMBER) IS
    V_JUGNUM    NUMBER(1);
    V_PTSTATUS  VARCHAR2(8);
    V_EXESQL    VARCHAR2(1024);
    V_PDATE     DATE := TO_DATE(V_PCOMEDATE, 'YYYY-MM-DD HH24-MI-SS');
    V_STIME     DATE := TO_DATE(V_SCANTIME, 'YYYY-MM-DD HH24-MI-SS');
  BEGIN
    SCMDATA.PKG_INTERFACE_LOG.P_INSERT_INFO_AND_INIT_VARIABLE(V_EOBJID => V_EOBJID,
                                                              V_COMPID => V_COMPID,
                                                              V_MINUTE => V_MINUTE);

    P_CHECK_ASNORDERED_EXISTS(V_ASNID     => V_ASNID,
                              V_COMPID    => V_COMPID,
                              V_JUGNUM    => V_JUGNUM,
                              V_PTSTATUS  => V_PTSTATUS);

    IF V_JUGNUM = 0 THEN
      V_EXESQL := 'INSERT INTO SCMDATA.T_ASNORDERED_ITF
                    (ASN_ID,COMPANY_ID,DC_COMPANY_ID,ORDER_ID,SUPPLIER_CODE,PCOME_DATE,
                     PCOME_INTERVAL,SCAN_TIME,MEMO,CREATE_ID,CREATE_TIME,STATUS)
                   VALUES (:A,:B,:B,:C,:D,:E,:F,:G,:H,''SYS'',SYSDATE,''NC'')';

      EXECUTE IMMEDIATE V_EXESQL
        USING V_ASNID, V_COMPID, V_COMPID, V_ORDERID, V_SUPCODE, V_PDATE, V_PCOMEINTER, V_STIME, V_MEMO;

      P_CHECK_ASNINFO(V_TAB       => 'SCMDATA.T_ASNORDERED_ITF',
                      V_ASNID     => V_ASNID,
                      V_COMPANYID => V_COMPID,
                      V_EOBJID    => V_EOBJID,
                      V_SUCSTATUS => 'SP');
    END IF;
  EXCEPTION
    WHEN OTHERS THEN
      V_EXESQL  := 'INSERT INTO SCMDATA.T_ASNORDERED_ITF '||
                   '(ASN_ID,COMPANY_ID,DC_COMPANY_ID,ORDER_ID,SUPPLIER_CODE,PCOME_DATE,'||
                   'PCOME_INTERVAL,SCAN_TIME,MEMO,CREATE_ID,CREATE_TIME,STATUS) '||
                   'VALUES ('''||V_ASNID||''','''||V_COMPID||''','''||V_COMPID||''','''||
                   V_ORDERID||''','''||V_SUPCODE||''','''||V_PCOMEDATE||''','''||V_PCOMEINTER||
                   ''','''||V_SCANTIME||''','''||V_MEMO||''',''SYS'',SYSDATE,''NC'')';

      SCMDATA.PKG_INTERFACE_LOG.P_ITF_RUNTIME_ERROR_LOGIC(V_EOBJID  => V_EOBJID,
                                                          V_COMPID  => V_COMPID,
                                                          V_TAB     => 'SCMDATA.T_ASNORDERED_ITF',
                                                          V_ERRSQL  => V_EXESQL,
                                                          V_UNQCOLS => 'ASN_ID',
                                                          V_UNQVALS => V_ASNID,
                                                          V_ST      => DBMS_UTILITY.FORMAT_ERROR_STACK);
  END P_INSERT_INTO_ASNORDERED_ITF;
  /*PROCEDURE P_INSERT_INTO_ASNORDERED_ITF(V_ASNID      IN VARCHAR2,
                                         V_COMPID     IN VARCHAR2,
                                         V_ORDERID    IN VARCHAR2,
                                         V_SUPCODE    IN VARCHAR2,
                                         V_PCOMEDATE  IN DATE,
                                         V_PCOMEINTER IN VARCHAR2,
                                         V_SCANTIME   IN DATE,
                                         V_MEMO       IN VARCHAR2,
                                         V_EOBJID     IN VARCHAR2,
                                         V_MINUTE     IN NUMBER) IS
    V_JUGNUM    NUMBER(1);
    V_PTSTATUS  VARCHAR2(8);
    V_EXESQL    VARCHAR2(1024);
    V_PDATE     VARCHAR2(64) := TO_CHAR(V_PCOMEDATE, 'YYYY-MM-DD HH24-MI-SS');
    V_STIME     VARCHAR2(64) := TO_CHAR(V_SCANTIME, 'YYYY-MM-DD HH24-MI-SS');
  BEGIN
    SCMDATA.PKG_INTERFACE_LOG.P_INSERT_INFO_AND_INIT_VARIABLE(V_EOBJID => V_EOBJID,
                                                              V_COMPID => V_COMPID,
                                                              V_MINUTE => V_MINUTE);

    P_CHECK_ASNORDERED_EXISTS(V_ASNID     => V_ASNID,
                              V_COMPID    => V_COMPID,
                              V_JUGNUM    => V_JUGNUM,
                              V_PTSTATUS  => V_PTSTATUS);

    IF V_JUGNUM = 0 THEN
      V_EXESQL := 'INSERT INTO SCMDATA.T_ASNORDERED_ITF
                    (ASN_ID,COMPANY_ID,DC_COMPANY_ID,ORDER_ID,SUPPLIER_CODE,PCOME_DATE,
                     PCOME_INTERVAL,SCAN_TIME,MEMO,CREATE_ID,CREATE_TIME,STATUS)
                   VALUES (:A,:B,:B,:C,:D,:E,:F,:G,:H,''SYS'',SYSDATE,''NC'')';

      EXECUTE IMMEDIATE V_EXESQL
        USING V_ASNID, V_COMPID, V_COMPID, V_ORDERID, V_SUPCODE, V_PCOMEDATE, V_PCOMEINTER, V_SCANTIME, V_MEMO;

      P_CHECK_ASNINFO(V_TAB       => 'SCMDATA.T_ASNORDERED_ITF',
                      V_ASNID     => V_ASNID,
                      V_SUPCODE   => V_SUPCODE,
                      V_COMPANYID => V_COMPID,
                      V_EOBJID    => V_EOBJID,
                      V_SUCSTATUS => 'SP');
    END IF;
  EXCEPTION
    WHEN OTHERS THEN
      V_EXESQL  := 'INSERT INTO SCMDATA.T_ASNORDERED_ITF '||
                   '(ASN_ID,COMPANY_ID,DC_COMPANY_ID,ORDER_ID,SUPPLIER_CODE,PCOME_DATE,'||
                   'PCOME_INTERVAL,SCAN_TIME,MEMO,CREATE_ID,CREATE_TIME,STATUS) '||
                   'VALUES ('''||V_ASNID||''','''||V_COMPID||''','''||V_COMPID||''','''||
                   V_ORDERID||''','''||V_SUPCODE||''','''||V_PDATE||''','''||V_PCOMEINTER||
                   ''','''||V_STIME||''','''||V_MEMO||''',''SYS'',SYSDATE,''NC'')';

      SCMDATA.PKG_INTERFACE_LOG.P_ITF_RUNTIME_ERROR_LOGIC(V_EOBJID  => V_EOBJID,
                                                          V_COMPID  => V_COMPID,
                                                          V_TAB     => 'SCMDATA.T_ASNORDERED_ITF',
                                                          V_ERRSQL  => V_EXESQL,
                                                          V_UNQCOLS => 'ASN_ID',
                                                          V_UNQVALS => V_ASNID,
                                                          V_ST      => DBMS_UTILITY.FORMAT_ERROR_STACK);
  END P_INSERT_INTO_ASNORDERED_ITF;*/



  /*=================================================================================

    【废弃-质检任务发布接口修改】接入WMS待质检 ASNORDERS 数据

    用途:
      用于接入WMS待质检的 ASNORDERS 数据

    入参:
      V_ASNID        :  ASN单号
      V_COMPID       :  企业Id
      V_GOOID        :  商品档案编号
      V_ORDERAMOUNT  :  订货量
      V_PCOMEAMOUNT  :  预计到仓量（预计到货量）
      V_ASNGOTAMOUNT :  预到货收货量
      V_GOTAMOUNT    :  到货量
      V_MEMO         :  备注
      V_EOBJID       :  执行对象Id
      V_MINUTE       :  日志等待时间，变量未操作超过 V_MINUTE 分钟，记录到日志

     版本:
       2021-10-18: 增加 V_EOBJID, V_MINUTE 以适应外部请求传输数据场景

  =================================================================================*/
  PROCEDURE P_INSERT_INTO_ASNORDERS_ITF(V_ASNID        IN VARCHAR2,
                                        V_COMPID       IN VARCHAR2,
                                        V_GOOID        IN VARCHAR2,
                                        V_ORDERAMOUNT  IN NUMBER,
                                        V_PCOMEAMOUNT  IN NUMBER,
                                        V_ASNGOTAMOUNT IN NUMBER,
                                        V_GOTAMOUNT    IN NUMBER,
                                        V_MEMO         IN VARCHAR2,
                                        V_EOBJID       IN VARCHAR2,
                                        V_MINUTE       IN NUMBER) IS
    V_JUGNUM    NUMBER(1);
    V_PTSTATUS  VARCHAR2(8);
    V_EXESQL    VARCHAR2(1024);
  BEGIN
    SCMDATA.PKG_INTERFACE_LOG.P_INSERT_INFO_AND_INIT_VARIABLE(V_EOBJID => V_EOBJID,
                                                              V_COMPID => V_COMPID,
                                                              V_MINUTE => V_MINUTE);

    P_CHECK_ASNORDERS_EXISTS(V_ASNID     => V_ASNID,
                             V_COMPID    => V_COMPID,
                             V_GOOID     => V_GOOID,
                             V_JUGNUM    => V_JUGNUM,
                             V_PTSTATUS  => V_PTSTATUS);

    IF V_JUGNUM = 0 THEN
      V_EXESQL := 'INSERT INTO SCMDATA.T_ASNORDERS_ITF
                    (ASN_ID,COMPANY_ID,DC_COMPANY_ID,GOO_ID,ORDER_AMOUNT,PCOME_AMOUNT,
                     ASNGOT_AMOUNT,GOT_AMOUNT,MEMO,CREATE_ID,CREATE_TIME)
                   VALUES (:A,:B,:B,:C,:D,:E,:F,:G,:H,''SYS'',SYSDATE)';

      EXECUTE IMMEDIATE V_EXESQL
        USING V_ASNID, V_COMPID, V_COMPID, V_GOOID, V_ORDERAMOUNT, V_PCOMEAMOUNT, V_ASNGOTAMOUNT, V_GOTAMOUNT, V_MEMO;

      P_CHECK_ASNINFO(V_TAB       => 'SCMDATA.T_ASNORDERS_ITF',
                      V_ASNID     => V_ASNID,
                      V_GOOID     => V_GOOID,
                      V_COMPANYID => V_COMPID,
                      V_EOBJID    => V_EOBJID,
                      V_SUCSTATUS => 'SP');
    END IF;
  EXCEPTION
    WHEN OTHERS THEN
      V_EXESQL  := 'INSERT INTO SCMDATA.T_ASNORDERS_ITF '||
                   '(ASN_ID,COMPANY_ID,DC_COMPANY_ID,GOO_ID,ORDER_AMOUNT,PCOME_AMOUNT,'||
                   'ASNGOT_AMOUNT,GOT_AMOUNT,MEMO,CREATE_ID,CREATE_TIME) '||
                   'VALUES ('''||V_ASNID||''','''||V_COMPID||''','''||V_COMPID||''','''||
                   V_GOOID||''','||V_ORDERAMOUNT||','||V_PCOMEAMOUNT||','||V_ASNGOTAMOUNT||
                   ','||V_GOTAMOUNT||','''||V_MEMO||''',''SYS'',SYSDATE)';

      SCMDATA.PKG_INTERFACE_LOG.P_ITF_RUNTIME_ERROR_LOGIC(V_EOBJID  => V_EOBJID,
                                                          V_COMPID  => V_COMPID,
                                                          V_TAB     => 'SCMDATA.T_ASNORDERS_ITF',
                                                          V_ERRSQL  => V_EXESQL,
                                                          V_UNQCOLS => 'ASN_ID',
                                                          V_UNQVALS => V_ASNID,
                                                          V_ST      => DBMS_UTILITY.FORMAT_ERROR_STACK);

  END P_INSERT_INTO_ASNORDERS_ITF;



  /*=================================================================================

    【废弃-质检任务发布接口修改】接入WMS待质检 ASNORDERSITEM 数据

    用途:
      用于接入WMS待质检的ASNORDERED数据

    入参:
      V_ASNID        :  ASN单号
      V_COMPID       :  企业Id
      V_GOOID        :  商品档案编号
      V_ORDERAMOUNT  :  订货量
      V_PCOMEAMOUNT  :  预计到仓量（预计到货量）
      V_ASNGOTAMOUNT :  预到货收货量
      V_GOTAMOUNT    :  到货量
      V_MEMO         :  备注
      V_EOBJID       :  执行对象Id
      V_MINUTE       :  日志等待时间，变量未操作超过 V_MINUTE 分钟，记录到日志

     版本:
       2021-10-18: 增加 V_EOBJID, V_MINUTE 以适应外部请求传输数据场景

  =================================================================================*/
  PROCEDURE P_INSERT_INTO_ASNORDERSITEM_ITF(V_ASNID        IN VARCHAR2,
                                            V_COMPID       IN VARCHAR2,
                                            V_GOOID        IN VARCHAR2,
                                            V_BARCODE      IN VARCHAR2,
                                            V_ORDERAMOUNT  IN NUMBER,
                                            V_PCOMEAMOUNT  IN NUMBER,
                                            V_ASNGOTAMOUNT IN NUMBER,
                                            V_GOTAMOUNT    IN NUMBER,
                                            V_MEMO         IN VARCHAR2,
                                            V_EOBJID       IN VARCHAR2,
                                            V_MINUTE       IN NUMBER) IS
    V_JUGNUM    NUMBER(1);
    V_PTSTATUS  VARCHAR2(8);
    V_EXESQL    VARCHAR2(1024);
  BEGIN
    SCMDATA.PKG_INTERFACE_LOG.P_INSERT_INFO_AND_INIT_VARIABLE(V_EOBJID => V_EOBJID,
                                                              V_COMPID => V_COMPID,
                                                              V_MINUTE => V_MINUTE);

    P_CHECK_ASNORDERSITEM_EXISTS(V_ASNID     => V_ASNID,
                                 V_COMPID    => V_COMPID,
                                 V_BARCODE   => V_BARCODE,
                                 V_JUGNUM    => V_JUGNUM,
                                 V_PTSTATUS  => V_PTSTATUS);

    IF V_JUGNUM = 0 AND LENGTH(V_BARCODE) > 6 THEN
      V_EXESQL := 'INSERT INTO SCMDATA.T_ASNORDERSITEM_ITF
                    (ASN_ID,COMPANY_ID,DC_COMPANY_ID,GOO_ID,BARCODE,ORDER_AMOUNT,PCOME_AMOUNT,
                     ASNGOT_AMOUNT,GOT_AMOUNT,MEMO,CREATE_ID,CREATE_TIME)
                   VALUES (:A,:B,:B,:C,:D,:E,:F,:G,:H,:I,''SYS'',SYSDATE)';

      EXECUTE IMMEDIATE V_EXESQL
        USING V_ASNID, V_COMPID, V_COMPID, V_GOOID, V_BARCODE, V_ORDERAMOUNT, V_PCOMEAMOUNT, V_ASNGOTAMOUNT, V_GOTAMOUNT, V_MEMO;

      P_CHECK_ASNINFO(V_TAB       => 'SCMDATA.T_ASNORDERSITEM_ITF',
                      V_ASNID     => V_ASNID,
                      V_GOOID     => V_GOOID,
                      V_COMPANYID => V_COMPID,
                      V_EOBJID    => V_EOBJID,
                      V_SUCSTATUS => 'SP');
    END IF;
  EXCEPTION
    WHEN OTHERS THEN
      V_EXESQL  := 'INSERT INTO SCMDATA.T_ASNORDERSITEM_ITF '||
                   '(ASN_ID,COMPANY_ID,DC_COMPANY_ID,GOO_ID,BARCODE,ORDER_AMOUNT,PCOME_AMOUNT,'||
                   'ASNGOT_AMOUNT,GOT_AMOUNT,MEMO,CREATE_ID,CREATE_TIME) '||
                   'VALUES ('''||V_ASNID||''','''||V_COMPID||''','''||V_COMPID||''','''||
                   V_GOOID||''','''||V_BARCODE||''','||V_ORDERAMOUNT||','||V_PCOMEAMOUNT||','||
                   V_ASNGOTAMOUNT||','||V_GOTAMOUNT||','''||V_MEMO||''',''SYS'',SYSDATE)';

      SCMDATA.PKG_INTERFACE_LOG.P_ITF_RUNTIME_ERROR_LOGIC(V_EOBJID  => V_EOBJID,
                                                          V_COMPID  => V_COMPID,
                                                          V_TAB     => 'SCMDATA.T_ASNORDERSITEM_ITF',
                                                          V_ERRSQL  => V_EXESQL,
                                                          V_UNQCOLS => 'ASN_ID',
                                                          V_UNQVALS => V_ASNID,
                                                          V_ST      => DBMS_UTILITY.FORMAT_ERROR_STACK);

  END P_INSERT_INTO_ASNORDERSITEM_ITF;




  /*=================================================================================

    【正常使用】接入熊猫待质检 ASNORDERPACKS 数据

    用途:
      用于接入熊猫待质检的 ASNORDERPACKS 数据

    入参:
      V_ASNID            :  ASN单号
      V_COMPID           :  企业Id
      V_GOOID            :  商品档案编号
      V_GOOSID           :  商品档案编号（辅），如果有条码则为条码值，
                            无条码则为商品档案编号
      V_BARCODE          :  条码
      V_PACK_NO          :  包序号
      V_PACK_BARCODE     :  总箱数
      V_PACKAMOUNT       :  到货量
      V_SKUPACK_NO       :  sku序号
      V_SKUPACK_COUNT    :  sku总箱数
      V_SKU_NUMBER       :  sku数量
      V_RATIOID          :  配码比
      V_PACK_SPECS_SEND  :  送货包装规格
      V_MEMO             :  备注
      V_EOBJID           :  执行对象Id
      V_MINUTE           :  日志等待时间，变量未操作超过 V_MINUTE 分钟，记录到日志

     版本:
       2021-10-18: 增加 V_EOBJID, V_MINUTE 以适应外部请求传输数据场景

  =================================================================================*/
  PROCEDURE P_INSERT_INTO_ASNORDERPACKS_ITF(V_ASNID            IN VARCHAR2,
                                            V_COMPID           IN VARCHAR2,
                                            V_OPERATORID       IN VARCHAR2,
                                            V_GOOID            IN VARCHAR2,
                                            V_GOOSID           IN VARCHAR2,
                                            V_BARCODE          IN VARCHAR2,
                                            V_PACK_NO          IN VARCHAR2,
                                            V_PACK_BARCODE     IN VARCHAR2,
                                            V_PACKNO           IN NUMBER,
                                            V_PACKCOUNT        IN NUMBER,
                                            V_PACKAMOUNT       IN NUMBER,
                                            V_SKUPACK_NO       IN NUMBER,
                                            V_SKUPACK_COUNT    IN NUMBER,
                                            V_SKU_NUMBER       IN NUMBER,
                                            V_RATIOID          IN NUMBER,
                                            V_PACK_SPECS_SEND  IN NUMBER,
                                            V_MEMO             IN VARCHAR2,
                                            V_EOBJID           IN VARCHAR2,
                                            V_MINUTE           IN NUMBER) IS
    V_EXESQL   VARCHAR2(2048);
    V_JUGNUM   NUMBER(1);
  BEGIN
    SCMDATA.PKG_INTERFACE_LOG.P_INSERT_INFO_AND_INIT_VARIABLE(V_EOBJID => V_EOBJID,
                                                              V_COMPID => V_COMPID,
                                                              V_MINUTE => V_MINUTE);

    SELECT COUNT(1)
      INTO V_JUGNUM
      FROM SCMDATA.T_ASNORDERPACKS_ITF
     WHERE ASN_ID = V_ASNID
       AND GOO_ID = V_GOOID
       AND NVL(BARCODE,' ') = NVL(V_BARCODE,' ')
       AND PACK_BARCODE = V_PACK_BARCODE
       AND COMPANY_ID = V_COMPID
       AND ROWNUM = 1;

    IF V_JUGNUM = 0 THEN
      V_EXESQL := 'INSERT INTO SCMDATA.T_ASNORDERPACKS_ITF
        (ASN_ID, COMPANY_ID, DC_COMPANY_ID, OPERATOR_ID, GOO_ID,
         BARCODE, PACK_NO, PACK_BARCODE, PACKNO, PACKCOUNT, PACKAMOUNT,
         SKUPACK_NO, SKUPACK_COUNT, SKU_NUMBER, RATIOID, PACK_SPECS_SEND,
         MEMO, CREATE_ID, CREATE_TIME, GOODSID)
      VALUES
        (:A, :B, :B, :C, :D, :E, :F, :G, :H, :I, :J, :K, :L, :M,
         :N, :O, :P, ''SYS'', SYSDATE, :Q)';

      EXECUTE IMMEDIATE V_EXESQL
        USING V_ASNID, V_COMPID, V_COMPID, V_OPERATORID, V_GOOID, V_BARCODE,
              V_PACK_NO, V_PACK_BARCODE, V_PACKNO, V_PACKCOUNT, V_PACKAMOUNT,
              V_SKUPACK_NO, V_SKUPACK_COUNT, V_SKU_NUMBER, V_RATIOID, V_PACK_SPECS_SEND,
              V_MEMO, V_GOOSID;
    ELSE
      V_EXESQL := 'UPDATE SCMDATA.T_ASNORDERPACKS_ITF SET PACK_NO = :A, PACKNO = :B, PACKCOUNT = :C, PACKAMOUNT = :D,
                   SKUPACK_NO = :E, SKUPACK_COUNT = :F, SKU_NUMBER = :G, RATIOID = :H, PACK_SPECS_SEND = :I,
                   MEMO = :J WHERE ASN_ID = :K AND COMPANY_ID = :L AND PACK_BARCODE = :M AND NVL(BARCODE,'' '') = NVL(:N,'' '')';

      EXECUTE IMMEDIATE V_EXESQL USING V_PACK_NO, V_PACKNO, V_PACKCOUNT, V_PACKAMOUNT,
              V_SKUPACK_NO, V_SKUPACK_COUNT, V_SKU_NUMBER, V_RATIOID, V_PACK_SPECS_SEND,
              V_MEMO , V_ASNID, V_COMPID, V_PACK_BARCODE, V_BARCODE;
    END IF;

    P_CHECK_ASNINFO(V_TAB       => 'SCMDATA.T_ASNORDERPACKS_ITF',
                    V_ASNID     => V_ASNID,
                    V_GOOID     => V_GOOID,
                    V_COMPANYID => V_COMPID,
                    V_EOBJID    => V_EOBJID,
                    V_SUCSTATUS => 'SP');

    EXCEPTION
      WHEN OTHERS THEN
         V_EXESQL := 'INSERT INTO SCMDATA.T_ASNORDERPACKS_ITF
      (ASN_ID, COMPANY_ID, DC_COMPANY_ID, OPERATOR_ID, GOO_ID,
       BARCODE, PACK_NO, PACK_BARCODE, PACKNO, PACKCOUNT, PACKAMOUNT,
       SKUPACK_NO, SKUPACK_COUNT, SKU_NUMBER, RATIOID, PACK_SPECS_SEND,
       MEMO, CREATE_ID, CREATE_TIME, GOODSID)
    VALUES
      ('''||V_ASNID||''', '''||V_COMPID||''', '''||V_COMPID||''', '''||V_OPERATORID||
       ''', '''||V_GOOID||''', '''||V_BARCODE||''', '''||V_PACK_NO||''', '''||V_PACK_BARCODE||
       ''', '''||V_PACKNO||''', '''||V_PACKCOUNT||''', '''||V_PACKAMOUNT||''', '''||V_SKUPACK_NO||
       ''', '''||V_SKUPACK_COUNT||''', '''||V_SKU_NUMBER||''','''||V_RATIOID||''', '''||V_PACK_SPECS_SEND||
       ''', '''||V_MEMO||''', ''SYS'', SYSDATE, '''||V_GOOSID||''')';


         SCMDATA.PKG_INTERFACE_LOG.P_ITF_RUNTIME_ERROR_LOGIC(V_EOBJID  => V_EOBJID,
                                                             V_COMPID  => V_COMPID,
                                                             V_TAB     => 'SCMDATA.T_ASNORDERPACKS_ITF',
                                                             V_ERRSQL  => V_EXESQL,
                                                             V_UNQCOLS => 'ASN_ID',
                                                             V_UNQVALS => V_ASNID,
                                                             V_ST      => DBMS_UTILITY.FORMAT_ERROR_STACK);
  END P_INSERT_INTO_ASNORDERPACKS_ITF;



  /*=================================================================================

    【正常使用】更新 SCMDATA.T_ASNORDERSITEM 时更新相关业务表和接口表的数据

    用途:
      在更新 SCMDATA.T_ASNORDERSITEM 时使用本过程同时更新 SCMDATA.T_QA_SCOPE，
      SCMDATA.T_ASNINFO_PRETRANS_TO_WMS 对应的数据和状态

    入参:
      V_ASNID    : ASN单号
      V_GOOID    : 货号
      V_BARCODE  : 条码
      V_COMPID   : 企业Id
      V_CURUSER  : 当前操作人Id

    版本:
      2021-11-01 : 在更新 SCMDATA.T_ASNORDERSITEM 时使用本过程同时更新 SCMDATA.T_QA_SCOPE，
                   SCMDATA.T_ASNINFO_PRETRANS_TO_WMS 对应的数据和状态

  =================================================================================*/
  PROCEDURE P_UPDATE_QASCOPE_TAKEOVERTIME(V_ASNID    IN VARCHAR2,
                                          V_GOOID    IN VARCHAR2,
                                          V_BARCODE  IN VARCHAR2,
                                          V_COMPID   IN VARCHAR2,
                                          V_CURUSER  IN VARCHAR2) IS
    V_JUGNUM  NUMBER(4);
  BEGIN
    FOR I IN (SELECT * FROM SCMDATA.T_ASNORDERSITEM
               WHERE ASN_ID = V_ASNID
                 AND GOO_ID = V_GOOID
                 AND BARCODE = V_BARCODE
                 AND COMPANY_ID = V_COMPID) LOOP
      UPDATE SCMDATA.T_QA_SCOPE
         SET PCOME_AMOUNT = I.PCOME_AMOUNT,
             GOT_AMOUNT = I.GOT_AMOUNT,
             TAKEOVER_TIME = I.RECEIVE_TIME
       WHERE ASN_ID = I.ASN_ID
         AND GOO_ID = I.GOO_ID
         AND BARCODE = I.BARCODE
         AND COMPANY_ID = I.COMPANY_ID;
    END LOOP;

    FOR X IN (SELECT DISTINCT QA_REPORT_ID, COMPANY_ID
                FROM SCMDATA.T_QA_SCOPE
               WHERE ASN_ID = V_ASNID
                 AND COMPANY_ID = V_COMPID) LOOP
      SCMDATA.PKG_QA_RELA.P_UPDATE_REP_AMOUNT(V_QAREPID => X.QA_REPORT_ID,
                                              V_COMPID  => X.COMPANY_ID,
                                              V_CURUSER => V_CURUSER);

      V_JUGNUM := F_GHECK_TAKEOVER_TIME_EXIST(V_QAREPID   => X.QA_REPORT_ID,
                                              V_COMPID    => V_COMPID);
      IF V_JUGNUM = 0 THEN
        UPDATE SCMDATA.T_ASNINFO_PRETRANS_TO_WMS
           SET STATUS = 'PD'
         WHERE QA_REPORT_ID = X.QA_REPORT_ID
           AND STATUS = 'TE'
           AND COMPANY_ID = X.COMPANY_ID;
      END IF;
    END LOOP;

  END P_UPDATE_QASCOPE_TAKEOVERTIME;



  /*=================================================================================

    【正常使用】产生质检任务

    用途:
      将最近5分钟内已获取到的质检数据生成质检任务,
      仅生成仓库为义务仓，品类为鞋包的数据，
      生成后，接口表状态修改为“SS”，
      对于不符合的，接口状态修改为“ME”

    版本:
      2021-11-25: 将最近5分钟内已获取到的质检数据生成质检任务
                  备注：仅生成仓库为义务仓，品类为鞋包的数据

  =================================================================================*/
  PROCEDURE P_SYNC_QA_MISSION IS
    V_JUGNUM  NUMBER(1);
    V_ASNID   VARCHAR2(32);
    V_COMPID  VARCHAR2(32);
  BEGIN
    FOR I IN (SELECT * FROM SCMDATA.T_ASNORDERED_ITF
               WHERE PORT_STATUS IN ('SP','ME')
                 AND PORT_TIME >= TRUNC(SYSDATE)-1
                 AND PORT_ELEMENT IN ('a_qa_pt100_ins','a_qa_pt100_upd')
               ORDER BY PORT_TIME
               FETCH FIRST 1000 ROWS ONLY) LOOP
      SELECT COUNT(1)
        INTO V_JUGNUM
        FROM SCMDATA.T_ASNORDERED ASN
       WHERE ASN_ID = I.ASN_ID
         AND STATUS = 'IN'
         AND COMPANY_ID = I.COMPANY_ID
         AND EXISTS (SELECT 1 FROM SCMDATA.T_ORDERED
                      WHERE ORDER_CODE = ASN.ORDER_ID
                        /*AND SHO_ID = 'GZZ'*/
                        AND COMPANY_ID = ASN.COMPANY_ID)
         AND EXISTS (SELECT 1
                       FROM (SELECT GOO_ID,COMPANY_ID FROM SCMDATA.T_ORDERS
                              WHERE ORDER_ID = ASN.ORDER_ID
                                AND COMPANY_ID = ASN.COMPANY_ID) A
                      INNER JOIN SCMDATA.T_COMMODITY_INFO B
                         ON A.GOO_ID = B.GOO_ID
                        AND A.COMPANY_ID = B.COMPANY_ID
                        AND B.CATEGORY IN ('00','01','03','12'))
         AND ROWNUM = 1;

      IF V_JUGNUM > 0 THEN
        V_ASNID  := I.ASN_ID;
        V_COMPID := I.COMPANY_ID;

        UPDATE SCMDATA.T_ASNORDERED
           SET STATUS = 'NC',
               PCOME_DATE = I.PCOME_DATE,
               CHANGETIMES = I.CHANGETIMES,
               SCAN_TIME = I.SCAN_TIME,
               MEMO = I.MEMO,
               PCOME_INTERVAL = I.PCOME_INTERVAL
         WHERE ASN_ID = I.ASN_ID
           AND STATUS NOT IN ('CI','CD')
           AND COMPANY_ID = I.COMPANY_ID;

        UPDATE SCMDATA.T_ASNORDERED_ITF
           SET PORT_STATUS = 'SS'
         WHERE ASN_ID = I.ASN_ID
           AND COMPANY_ID = I.COMPANY_ID;
      ELSE
        UPDATE SCMDATA.T_ASNORDERED_ITF
           SET PORT_STATUS = 'ME'
         WHERE ASN_ID = I.ASN_ID
           AND COMPANY_ID = I.COMPANY_ID;
      END IF;
    END LOOP;
    EXCEPTION
      WHEN OTHERS THEN
        UPDATE SCMDATA.T_ASNORDERED_ITF
           SET PORT_STATUS = 'SE'
         WHERE ASN_ID = V_ASNID
           AND COMPANY_ID = V_COMPID;
  END P_SYNC_QA_MISSION;



  /*=================================================================================

    【正常使用】ASNORDERED_ITF 数据同步

    用途:
      将 SCMDATA.T_ASNORDEREDITF 内前300条数据，进行校验，
      如果不存在，则新增到 SCMDATA.T_ASNORDERED
      如果存在，则更新到 SCMDATA.T_ASNORDERED

    版本:
      2021-10-18: 增加 V_EOBJID, V_MINUTE 以适应外部请求传输数据场景

  =================================================================================*/
  PROCEDURE P_ASNORDEREDITF_SYNC IS
    V_ASNID  VARCHAR2(32);
    V_COMPID VARCHAR2(32);
    V_JUGNUM NUMBER(1);
  BEGIN
    FOR I IN (SELECT A.ASN_ID, A.COMPANY_ID, A.DC_COMPANY_ID,
                     A.STATUS, A.ORDER_ID, B.SUPPLIER_CODE,
                     A.PCOME_DATE, A.CHANGETIMES, A.SCAN_TIME,
                     A.MEMO, A.CREATE_ID, A.CREATE_TIME, A.PCOME_INTERVAL
                FROM (SELECT * FROM SCMDATA.T_ASNORDERED_ITF
                       WHERE PORT_STATUS = 'SP'
                         AND ROWNUM <= 300) A
                LEFT JOIN SCMDATA.T_SUPPLIER_INFO B
                  ON A.SUPPLIER_CODE = B.INSIDE_SUPPLIER_CODE
                 AND A.COMPANY_ID = B.COMPANY_ID) LOOP
      BEGIN
        V_ASNID := I.ASN_ID;
        V_COMPID := I.COMPANY_ID;

        SELECT COUNT(1)
          INTO V_JUGNUM
          FROM SCMDATA.T_ASNORDERED
         WHERE ASN_ID = I.ASN_ID
           AND COMPANY_ID = I.COMPANY_ID
           AND ROWNUM = 1;

        IF V_JUGNUM = 0 THEN
          INSERT INTO SCMDATA.T_ASNORDERED
            (ASN_ID, COMPANY_ID, DC_COMPANY_ID, STATUS, ORDER_ID,
             SUPPLIER_CODE, PCOME_DATE, CHANGETIMES, SCAN_TIME, MEMO,
             CREATE_ID, CREATE_TIME, PCOME_INTERVAL)
          VALUES
            (I.ASN_ID, I.COMPANY_ID, I.DC_COMPANY_ID, I.STATUS, I.ORDER_ID,
             I.SUPPLIER_CODE, I.PCOME_DATE, I.CHANGETIMES, I.SCAN_TIME,
             I.MEMO, I.CREATE_ID, I.CREATE_TIME, I.PCOME_INTERVAL);
        ELSE
          UPDATE SCMDATA.T_ASNORDERED
             SET PCOME_DATE = I.PCOME_DATE,
                 CHANGETIMES = I.CHANGETIMES,
                 SCAN_TIME = I.SCAN_TIME,
                 MEMO = I.MEMO
           WHERE ASN_ID = I.ASN_ID
             AND COMPANY_ID = I.COMPANY_ID;
        END IF;

        UPDATE SCMDATA.T_ASNORDERED_ITF
           SET PORT_STATUS = 'SS',
               PORT_TIME = SYSDATE
         WHERE ASN_ID = V_ASNID
           AND COMPANY_ID = V_COMPID;
      EXCEPTION
        WHEN OTHERS THEN
          UPDATE SCMDATA.T_ASNORDERED_ITF
             SET PORT_STATUS = 'SE',
                 PORT_TIME = SYSDATE
           WHERE ASN_ID = V_ASNID
             AND COMPANY_ID = V_COMPID;
      END;
    END LOOP;
  END P_ASNORDEREDITF_SYNC;



  /*=================================================================================

    【废弃-质检任务发布接口修改】ASNORDERS_ITF 数据同步

    用途:
      将 SCMDATA.T_ASNORDERS_ITF 内前300条数据，进行校验，
      如果不存在，则新增到 SCMDATA.T_ASNORDERS
      如果存在，则更新到 SCMDATA.T_ASNORDERS

    版本:
      2021-10-18: 增加 V_EOBJID, V_MINUTE 以适应外部请求传输数据场景

  =================================================================================*/
  PROCEDURE P_ASNORDERSITF_SYNC IS
    V_ASNID    VARCHAR2(32);
    V_COMPID   VARCHAR2(32);
    V_GOOID    VARCHAR2(32);
    V_JUGNUM   NUMBER(1);
  BEGIN
    FOR I IN (SELECT A.ASN_ID, A.COMPANY_ID, A.DC_COMPANY_ID,
                     B.GOO_ID, A.GOO_ID RELA_GOO_ID, A.ORDER_AMOUNT,
                     A.PCOME_AMOUNT, A.ASNGOT_AMOUNT, A.GOT_AMOUNT,
                     A.MEMO, A.CREATE_ID, A.CREATE_TIME, A.RET_AMOUNT,
                     A.PICK_TIME, A.SHIMENT_TIME, A.RECEIVE_TIME,
                     A.WAREHOUSE_POS
                FROM (SELECT * FROM SCMDATA.T_ASNORDERS_ITF
                       WHERE PORT_STATUS = 'SP'
                         AND ROWNUM <= 300) A
                LEFT JOIN SCMDATA.T_COMMODITY_INFO B
                  ON A.GOO_ID = B.RELA_GOO_ID
                 AND A.COMPANY_ID = B.COMPANY_ID) LOOP
      BEGIN
        V_ASNID := I.ASN_ID;
        V_GOOID := I.RELA_GOO_ID;
        V_COMPID := I.COMPANY_ID;

        SELECT COUNT(1)
          INTO V_JUGNUM
          FROM SCMDATA.T_ASNORDERS
         WHERE ASN_ID = I.ASN_ID
           AND GOO_ID = I.GOO_ID
           AND COMPANY_ID = I.COMPANY_ID;

        IF V_JUGNUM = 0 THEN
          INSERT INTO SCMDATA.T_ASNORDERS
            (ASN_ID, COMPANY_ID, DC_COMPANY_ID, GOO_ID, ORDER_AMOUNT, PCOME_AMOUNT,
             ASNGOT_AMOUNT, GOT_AMOUNT, MEMO, CREATE_ID, CREATE_TIME, RET_AMOUNT,
             PICK_TIME, SHIMENT_TIME, RECEIVE_TIME, WAREHOUSE_POS)
          VALUES
            (I.ASN_ID, I.COMPANY_ID, I.DC_COMPANY_ID, I.GOO_ID, I.ORDER_AMOUNT, I.PCOME_AMOUNT,
             I.ASNGOT_AMOUNT, I.GOT_AMOUNT, I.MEMO, I.CREATE_ID, I.CREATE_TIME, I.RET_AMOUNT,
             I.PICK_TIME, I.SHIMENT_TIME, I.RECEIVE_TIME, I.WAREHOUSE_POS);
        ELSE
          UPDATE SCMDATA.T_ASNORDERS
             SET ORDER_AMOUNT = I.ORDER_AMOUNT,
                 PCOME_AMOUNT = I.PCOME_AMOUNT,
                 ASNGOT_AMOUNT = I.ASNGOT_AMOUNT,
                 GOT_AMOUNT = I.GOT_AMOUNT,
                 RECEIVE_TIME = I.RECEIVE_TIME,
                 MEMO = I.MEMO
           WHERE ASN_ID = I.ASN_ID
             AND GOO_ID = I.GOO_ID
             AND COMPANY_ID = I.COMPANY_ID;

          UPDATE SCMDATA.T_QA_SCOPE
             SET TAKEOVER_TIME = I.RECEIVE_TIME
           WHERE ASN_ID = I.ASN_ID
             AND GOO_ID = I.GOO_ID
             AND BARCODE IS NULL
             AND COMPANY_ID = I.COMPANY_ID;
        END IF;

        UPDATE SCMDATA.T_ASNORDERS_ITF
           SET PORT_STATUS = 'SS',
               PORT_TIME = SYSDATE
         WHERE ASN_ID = V_ASNID
           AND GOO_ID = V_GOOID
           AND COMPANY_ID = V_COMPID;
      EXCEPTION
        WHEN OTHERS THEN
          UPDATE SCMDATA.T_ASNORDERS_ITF
             SET PORT_STATUS = 'SE',
                 PORT_TIME = SYSDATE
           WHERE ASN_ID = V_ASNID
             AND GOO_ID = V_GOOID
             AND COMPANY_ID = V_COMPID;
      END;
    END LOOP;
  END P_ASNORDERSITF_SYNC;



  /*=================================================================================

    【废弃-质检任务发布接口修改】ASNORDERSITEM_ITF 数据同步

    用途:
      将 SCMDATA.T_ASNORDERSITEM_ITF 内前300条数据，进行校验，
      如果不存在，则新增到 SCMDATA.T_ASNORDERSITEM
      如果存在，则更新到 SCMDATA.T_ASNORDERSITEM

    版本:
      2021-10-18: 增加 V_EOBJID, V_MINUTE 以适应外部请求传输数据场景

  =================================================================================*/
  PROCEDURE P_ASNORDERSITEMITF_SYNC IS
    V_ASNID    VARCHAR2(32);
    V_COMPID   VARCHAR2(32);
    V_GOOID    VARCHAR2(32);
    V_BARCODE  VARCHAR2(32);
    V_JUGNUM   NUMBER(1);
  BEGIN
    FOR I IN (SELECT A.ASN_ID, A.COMPANY_ID, A.DC_COMPANY_ID,
                     B.GOO_ID, A.GOO_ID RELA_GOO_ID, A.BARCODE,
                     A.ORDER_AMOUNT, A.PCOME_AMOUNT, A.ASNGOT_AMOUNT,
                     A.GOT_AMOUNT, A.RET_AMOUNT, A.PICK_TIME, A.SHIPMENT_TIME,
                     A.RECEIVE_TIME, A.WAREHOUSE_POS, A.MEMO, A.CREATE_ID, A.CREATE_TIME
                FROM (SELECT * FROM SCMDATA.T_ASNORDERSITEM_ITF
                       WHERE PORT_STATUS = 'SP'
                         AND ROWNUM <= 300) A
                LEFT JOIN SCMDATA.T_COMMODITY_INFO B
                  ON A.GOO_ID = B.RELA_GOO_ID
                 AND A.COMPANY_ID = B.COMPANY_ID) LOOP
      BEGIN
        V_ASNID := I.ASN_ID;
        V_GOOID := I.RELA_GOO_ID;
        V_BARCODE := I.BARCODE;
        V_COMPID := I.COMPANY_ID;

        SELECT COUNT(1)
          INTO V_JUGNUM
          FROM SCMDATA.T_ASNORDERSITEM
         WHERE ASN_ID = I.ASN_ID
           AND GOO_ID = I.GOO_ID
           AND BARCODE = I.BARCODE
           AND COMPANY_ID = I.COMPANY_ID;

        IF V_JUGNUM = 0 THEN
          INSERT INTO SCMDATA.T_ASNORDERSITEM
            (ASN_ID, COMPANY_ID, DC_COMPANY_ID, GOO_ID, BARCODE, ORDER_AMOUNT,
             PCOME_AMOUNT, ASNGOT_AMOUNT, GOT_AMOUNT, RET_AMOUNT, PICK_TIME,
             SHIPMENT_TIME, RECEIVE_TIME, WAREHOUSE_POS, MEMO, CREATE_ID, CREATE_TIME)
          VALUES
            (I.ASN_ID, I.COMPANY_ID, I.DC_COMPANY_ID, I.GOO_ID, I.BARCODE, I.ORDER_AMOUNT,
             I.PCOME_AMOUNT, I.ASNGOT_AMOUNT, I.GOT_AMOUNT, I.RET_AMOUNT, I.PICK_TIME,
             I.SHIPMENT_TIME, I.RECEIVE_TIME, I.WAREHOUSE_POS, I.MEMO, I.CREATE_ID, I.CREATE_TIME);
        ELSE
          UPDATE SCMDATA.T_ASNORDERSITEM
             SET ORDER_AMOUNT = I.ORDER_AMOUNT,
                 PCOME_AMOUNT = I.PCOME_AMOUNT,
                 ASNGOT_AMOUNT = I.ASNGOT_AMOUNT,
                 GOT_AMOUNT = I.GOT_AMOUNT,
                 RET_AMOUNT = I.RET_AMOUNT,
                 PICK_TIME = I.PICK_TIME,
                 SHIPMENT_TIME = I.SHIPMENT_TIME,
                 RECEIVE_TIME = I.RECEIVE_TIME,
                 WAREHOUSE_POS = I.WAREHOUSE_POS
           WHERE ASN_ID = I.ASN_ID
             AND GOO_ID = I.GOO_ID
             AND BARCODE = I.BARCODE
             AND COMPANY_ID = I.COMPANY_ID;
        END IF;

        UPDATE SCMDATA.T_ASNORDERSITEM_ITF
           SET PORT_STATUS = 'SS',
               PORT_TIME = SYSDATE
         WHERE ASN_ID = V_ASNID
           AND GOO_ID = V_GOOID
             AND BARCODE = V_BARCODE
           AND COMPANY_ID = V_COMPID;
      EXCEPTION
        WHEN OTHERS THEN
          UPDATE SCMDATA.T_ASNORDERSITEM_ITF
             SET PORT_STATUS = 'SE',
                 PORT_TIME = SYSDATE
           WHERE ASN_ID = V_ASNID
             AND GOO_ID = V_GOOID
             AND BARCODE = V_BARCODE
             AND COMPANY_ID = V_COMPID;
      END;
    END LOOP;
  END P_ASNORDERSITEMITF_SYNC;



  /*=================================================================================

    【正常使用】ASNORDEREPACKS_ITF 数据同步

    用途:
      将 SCMDATA.T_ASNORDEREPACKS_ITF 内前300条数据，进行校验，
      如果不存在，则新增到 SCMDATA.T_ASNORDEREPACKS
      如果存在，则更新到 SCMDATA.T_ASNORDEREPACKS

    版本:
      2021-10-18: 增加 V_EOBJID, V_MINUTE 以适应外部请求传输数据场景

  =================================================================================*/
  PROCEDURE P_ASNORDERPACKSITF_SYNC IS
    V_ASNID        VARCHAR2(32);
    V_COMPID       VARCHAR2(32);
    V_RELAGOOID    VARCHAR2(32);
    V_GOOID        VARCHAR2(32);
    V_BARCODE      VARCHAR2(32);
    V_PACKBARCODE  VARCHAR2(32);
    V_JUGNUM       NUMBER(1);
  BEGIN
    FOR I IN (SELECT A.ASN_ID,A.COMPANY_ID,A.DC_COMPANY_ID,A.OPERATOR_ID,
                     B.GOO_ID,A.GOO_ID RELA_GOO_ID,A.BARCODE,A.PACK_NO,A.PACK_BARCODE,A.PACKNO,
                     A.PACKCOUNT,A.PACKAMOUNT,A.SKUPACK_NO,A.SKUPACK_COUNT,
                     A.SKU_NUMBER,A.RATIOID,A.PACK_SPECS_SEND,A.MEMO,
                     A.CREATE_ID,A.CREATE_TIME,NVL(A.BARCODE,B.GOO_ID) GOODSID,
                     A.SUBS_AMOUNT,A.PORT_ELEMENT,A.PORT_TIME,A.PORT_STATUS
                FROM SCMDATA.T_ASNORDERPACKS_ITF A
               INNER JOIN SCMDATA.T_COMMODITY_INFO B
                  ON A.GOO_ID = B.RELA_GOO_ID
                 AND A.COMPANY_ID = B.COMPANY_ID
               WHERE A.PORT_STATUS = 'SP'
                 AND A.PORT_TIME <= SYSDATE - 2/(24*60)
               ORDER BY A.PORT_TIME) LOOP
      BEGIN
        V_ASNID := I.ASN_ID;
        V_GOOID := I.GOO_ID;
        V_RELAGOOID := I.RELA_GOO_ID;
        V_BARCODE := I.BARCODE;
        V_PACKBARCODE := I.PACK_BARCODE;
        V_COMPID := I.COMPANY_ID;

        SELECT COUNT(1)
          INTO V_JUGNUM
          FROM SCMDATA.T_ASNORDERPACKS
         WHERE ASN_ID = I.ASN_ID
           AND GOO_ID = I.GOO_ID
           AND NVL(BARCODE,' ') = NVL(I.BARCODE,' ')
           AND PACK_BARCODE = I.PACK_BARCODE
           AND COMPANY_ID = I.COMPANY_ID;

        IF V_JUGNUM = 0 THEN
          INSERT INTO SCMDATA.T_ASNORDERPACKS
            (ASN_ID, COMPANY_ID, DC_COMPANY_ID, OPERATOR_ID, GOO_ID, BARCODE,
             PACK_NO, PACK_BARCODE, PACKNO, PACKCOUNT, PACKAMOUNT, SKUPACK_NO,
             SKUPACK_COUNT, SKU_NUMBER, RATIOID, PACK_SPECS_SEND, MEMO,
             CREATE_ID, CREATE_TIME, GOODSID)
          VALUES
            (I.ASN_ID, I.COMPANY_ID, I.DC_COMPANY_ID, I.OPERATOR_ID, I.GOO_ID, I.BARCODE,
             I.PACK_NO, I.PACK_BARCODE, I.PACKNO, I.PACKCOUNT, I.PACKAMOUNT, I.SKUPACK_NO,
             I.SKUPACK_COUNT, I.SKU_NUMBER, I.RATIOID, I.PACK_SPECS_SEND, I.MEMO,
             I.CREATE_ID, I.CREATE_TIME, I.GOODSID);
        ELSE
          IF I.PACKCOUNT = 0 THEN
            DELETE FROM SCMDATA.T_ASNORDERPACKS
             WHERE ASN_ID = I.ASN_ID
               AND GOO_ID = I.GOO_ID
               AND NVL(BARCODE,' ') = NVL(I.BARCODE,' ')
               AND PACK_BARCODE = I.PACK_BARCODE
               AND COMPANY_ID = I.COMPANY_ID;
          ELSE
            UPDATE SCMDATA.T_ASNORDERPACKS
               SET PACKCOUNT = I.PACKCOUNT,
                   PACKAMOUNT = I.PACKAMOUNT,
                   SKUPACK_COUNT = I.SKUPACK_COUNT,
                   SKU_NUMBER = I.SKU_NUMBER,
                   RATIOID = I.RATIOID,
                   PACK_SPECS_SEND = I.PACK_SPECS_SEND,
                   MEMO = I.MEMO
             WHERE ASN_ID = I.ASN_ID
               AND GOO_ID = I.GOO_ID
               AND NVL(BARCODE,' ') = NVL(I.BARCODE,' ')
               AND PACK_BARCODE = I.PACK_BARCODE
               AND COMPANY_ID = I.COMPANY_ID;
          END IF;
        END IF;
        UPDATE SCMDATA.T_ASNORDERPACKS_ITF
           SET PORT_STATUS = 'SS',
               PORT_TIME = SYSDATE
         WHERE ASN_ID = I.ASN_ID
           AND GOO_ID = I.RELA_GOO_ID
           AND NVL(BARCODE,' ') = NVL(I.BARCODE,' ')
           AND PACK_BARCODE = I.PACK_BARCODE
           AND COMPANY_ID = I.COMPANY_ID;
      EXCEPTION
      WHEN OTHERS THEN
        UPDATE SCMDATA.T_ASNORDERPACKS_ITF
           SET PORT_STATUS = 'SE',
               PORT_TIME = SYSDATE
         WHERE ASN_ID = V_ASNID
           AND GOO_ID = V_RELAGOOID
           AND NVL(BARCODE,' ') = NVL(V_BARCODE,' ')
           AND PACK_BARCODE = V_PACKBARCODE
           AND COMPANY_ID = V_COMPID;
      END;
    END LOOP;
  END P_ASNORDERPACKSITF_SYNC;



  /*=================================================================================

    【正常使用】将 WMS-ASNORDERED 收货信息更新到 SCMDATA.T_ASNORDERED

    用途:
      将至多300条 WMS-ASNORDERED 收货信息更新到 SCMDATA.T_ASNORDERED，
      失败则更新 SCMDATA.T_ASNORDERED_ITF.PORT_STATUS 字段为 UE
            更新 SCMDATA.T_ASNORDERED_ITF.PORT_TIME   字段为 当前时间

    版本:
      2021-10-24: 将至多300条 WMS-ASNORDERED 收货信息更新到 SCMDATA.T_ASNORDERED，
                  失败则更新 SCMDATA.T_ASNORDERED_ITF.PORT_STATUS 字段为 UE
                  更新 SCMDATA.T_ASNORDERED_ITF.PORT_TIME   字段为 当前时间

  =================================================================================*/
  PROCEDURE P_ASNORDERED_ITF_REINFO_SYNC IS
    V_ASNID  VARCHAR2(32);
    V_COMPID VARCHAR2(32);
    V_JUGNUM NUMBER(1);
  BEGIN
    FOR I IN (SELECT ASN_ID,COMPANY_ID, SCAN_TIME, CHANGETIMES, PCOME_DATE, PCOME_INTERVAL, STATUS
                FROM (SELECT ASN_ID,COMPANY_ID, SCAN_TIME, CHANGETIMES,
                             PCOME_DATE, PCOME_INTERVAL, STATUS
                        FROM SCMDATA.T_ASNORDERED_ITF
                       WHERE PORT_STATUS IN ('UP','SP')
                         AND PORT_ELEMENT = 'a_qa_pt100_upd'
                       ORDER BY PORT_TIME)
               WHERE ROWNUM <= 500) LOOP
      BEGIN
        V_ASNID := I.ASN_ID;
        V_COMPID := I.COMPANY_ID;

        SELECT COUNT(1)
          INTO V_JUGNUM
          FROM SCMDATA.T_ASNORDERED ASN
         WHERE ASN_ID = I.ASN_ID
           AND STATUS = 'IN'
           AND COMPANY_ID = I.COMPANY_ID
           AND EXISTS (SELECT 1 FROM SCMDATA.T_ORDERED
                        WHERE ORDER_CODE = ASN.ORDER_ID
                          /*AND SHO_ID = 'GZZ'*/
                          AND COMPANY_ID = ASN.COMPANY_ID)
           AND EXISTS (SELECT 1
                         FROM (SELECT GOO_ID,COMPANY_ID FROM SCMDATA.T_ORDERS
                                WHERE ORDER_ID = ASN.ORDER_ID
                                  AND COMPANY_ID = ASN.COMPANY_ID) A
                        INNER JOIN SCMDATA.T_COMMODITY_INFO B
                           ON A.GOO_ID = B.GOO_ID
                          AND A.COMPANY_ID = B.COMPANY_ID
                          AND B.CATEGORY IN ('00','01','03','12'))
           AND ROWNUM = 1;

        IF V_JUGNUM > 0 THEN
          UPDATE SCMDATA.T_ASNORDERED
             SET SCAN_TIME = I.SCAN_TIME,
                 CHANGETIMES = I.CHANGETIMES,
                 PCOME_DATE = I.PCOME_DATE,
                 PCOME_INTERVAL = I.PCOME_INTERVAL,
                 STATUS = 'NC'
           WHERE ASN_ID = I.ASN_ID
             AND COMPANY_ID = I.COMPANY_ID;
        ELSE
          UPDATE SCMDATA.T_ASNORDERED
             SET SCAN_TIME = I.SCAN_TIME,
                 CHANGETIMES = I.CHANGETIMES,
                 PCOME_DATE = I.PCOME_DATE,
                 PCOME_INTERVAL = I.PCOME_INTERVAL
           WHERE ASN_ID = I.ASN_ID
             AND COMPANY_ID = I.COMPANY_ID;
        END IF;

        UPDATE SCMDATA.T_ASNORDERED_ITF
           SET PORT_STATUS = 'US',
               PORT_TIME = SYSDATE
         WHERE ASN_ID = I.ASN_ID
           AND COMPANY_ID = I.COMPANY_ID;

        --2022_01_05 新增交期表数据刷新
        /*P_SYNC_ORD_DELIVERY_REC(V_ASNID  => I.ASN_ID,
                                V_COMPID => I.COMPANY_ID);*/
      EXCEPTION
        WHEN OTHERS THEN
          UPDATE SCMDATA.T_ASNORDERED_ITF
             SET PORT_STATUS = 'UE',
                 PORT_TIME = SYSDATE
           WHERE ASN_ID = V_ASNID
             AND COMPANY_ID = V_COMPID;
      END;
    END LOOP;
  END P_ASNORDERED_ITF_REINFO_SYNC;



  /*=================================================================================

    【正常使用】将 WMS-ASNORDERS 收货信息更新到 SCMDATA.T_ASNORDERS

    用途:
      将至多300条 WMS-ASNORDERS 收货信息更新到 SCMDATA.T_ASNORDERS，
      失败则更新 SCMDATA.T_ASNORDERS_ITF.PORT_STATUS 字段为 UE
            更新 SCMDATA.T_ASNORDERS_ITF.PORT_TIME   字段为 当前时间

    版本:
      2021-10-24: 将至多300条 WMS-ASNORDERS 收货信息更新到 SCMDATA.T_ASNORDERS，
                  失败则更新 SCMDATA.T_ASNORDERS_ITF.PORT_STATUS 字段为 UE
                  更新 SCMDATA.T_ASNORDERS_ITF.PORT_TIME   字段为 当前时间
      2022-03: 1.至多300条更改为至多500条
               2.旧更新 T_ASNINFO_PRETRANS_TO_WMS 逻辑被 P_UPDATE_ASNPTTOWMS_TO_PD 替换
               3.新增报错时间小于当前时间-7天时，状态由 UE 修改为 ENS（ERROR NOT SYNC）

  =================================================================================*/
  PROCEDURE P_ASNORDERS_ITF_REINFO_SYNC IS
    V_JUGNUM       NUMBER(1);
    V_ASNID        VARCHAR2(32);
    V_COMPID       VARCHAR2(32);
    V_RELAGOOID    VARCHAR2(32);
    V_CRETIME      DATE;
    V_ESTATUS      VARCHAR2(4);
  BEGIN
    FOR I IN (SELECT A.ASN_ID, A.COMPANY_ID, B.GOO_ID, A.GOO_ID RELA_GOO_ID, A.ORDER_AMOUNT, A.GOT_AMOUNT, A.PCOME_AMOUNT, A.MEMO,
                     A.ASNGOT_AMOUNT, A.RET_AMOUNT, A.PICK_TIME, A.SHIMENT_TIME, A.RECEIVE_TIME, A.WAREHOUSE_POS, A.CREATE_ID, A.CREATE_TIME
                FROM (SELECT ASN_ID, COMPANY_ID, GOO_ID, ORDER_AMOUNT, PCOME_AMOUNT, ASNGOT_AMOUNT, GOT_AMOUNT, MEMO,
                             RET_AMOUNT, PICK_TIME, SHIMENT_TIME, RECEIVE_TIME, WAREHOUSE_POS, CREATE_ID, CREATE_TIME
                        FROM SCMDATA.T_ASNORDERS_ITF
                       WHERE PORT_STATUS IN ('UP','SP')
                         AND PORT_ELEMENT IN ('a_qa_pt100_ins','a_qa_pt100_upd')
                       ORDER BY PORT_TIME) A
                LEFT JOIN SCMDATA.T_COMMODITY_INFO B
                  ON A.GOO_ID = B.RELA_GOO_ID
                 AND A.COMPANY_ID = B.COMPANY_ID
               WHERE ROWNUM <= 500) LOOP
      BEGIN
        V_ASNID := I.ASN_ID;
        V_COMPID := I.COMPANY_ID;
        V_RELAGOOID := I.RELA_GOO_ID;

        SELECT COUNT(1)
          INTO V_JUGNUM
          FROM SCMDATA.T_ASNORDERS
         WHERE ASN_ID = I.ASN_ID
           AND COMPANY_ID = I.COMPANY_ID
           AND ROWNUM = 1;

        IF V_JUGNUM = 0 THEN
          INSERT INTO SCMDATA.T_ASNORDERS
            (ASN_ID,COMPANY_ID,DC_COMPANY_ID,GOO_ID,ORDER_AMOUNT,PCOME_AMOUNT,ASNGOT_AMOUNT,
             GOT_AMOUNT,RECEIVE_TIME,WAREHOUSE_POS,MEMO,CREATE_ID,CREATE_TIME)
          VALUES
            (I.ASN_ID,I.COMPANY_ID,I.COMPANY_ID,I.GOO_ID,I.ORDER_AMOUNT,I.PCOME_AMOUNT,I.ASNGOT_AMOUNT,
             I.GOT_AMOUNT,I.RECEIVE_TIME,I.WAREHOUSE_POS,I.MEMO,I.CREATE_ID,I.CREATE_TIME);
        ELSE
          UPDATE SCMDATA.T_ASNORDERS ASNS
             SET PCOME_AMOUNT = I.ORDER_AMOUNT,
                 GOT_AMOUNT = I.GOT_AMOUNT,
                 RET_AMOUNT = I.RET_AMOUNT,
                 RECEIVE_TIME = I.RECEIVE_TIME,
                 WAREHOUSE_POS = I.WAREHOUSE_POS
           WHERE ASN_ID = I.ASN_ID
             AND COMPANY_ID = I.COMPANY_ID
             AND GOO_ID = I.GOO_ID;
        END IF;

        UPDATE SCMDATA.T_ASNORDERS_ITF
             SET PORT_STATUS = 'US',
                 PORT_TIME = SYSDATE
           WHERE ASN_ID = I.ASN_ID
             AND COMPANY_ID = I.COMPANY_ID
             AND GOO_ID = I.RELA_GOO_ID;

        SELECT COUNT(1)
          INTO V_JUGNUM
          FROM SCMDATA.T_ASNORDERSITEM
         WHERE ASN_ID = I.ASN_ID
           AND COMPANY_ID = I.COMPANY_ID
           AND ROWNUM = 1;

        IF V_JUGNUM = 0 THEN
          UPDATE SCMDATA.T_QA_SCOPE
             SET PCOME_AMOUNT = I.ORDER_AMOUNT,
                 GOT_AMOUNT = I.GOT_AMOUNT,
                 TAKEOVER_TIME = I.RECEIVE_TIME,
                 IS_QUALITY = 0
           WHERE ASN_ID = I.ASN_ID
             AND GOO_ID = I.GOO_ID
             AND BARCODE IS NULL
             AND COMPANY_ID = I.COMPANY_ID;

          IF I.RECEIVE_TIME IS NOT NULL THEN
            P_UPDATE_ASNPTTOWMS_TO_PD(V_ASNID   => I.ASN_ID,
                                      V_GOOID   => I.GOO_ID,
                                      V_BARCODE => NULL,
                                      V_COMPID  => I.COMPANY_ID);
          END IF;
        END IF;
      EXCEPTION
        WHEN OTHERS THEN
          IF V_CRETIME < SYSDATE - 7 THEN
            V_ESTATUS := 'ENS'; --ERROR NOT SYNC
          ELSE
            V_ESTATUS := 'UE';
          END IF;

          UPDATE SCMDATA.T_ASNORDERS_ITF
             SET PORT_STATUS = V_ESTATUS,
                 PORT_TIME = SYSDATE
           WHERE ASN_ID = V_ASNID
             AND COMPANY_ID = V_COMPID
             AND GOO_ID = V_RELAGOOID;
      END;
    END LOOP;
  END P_ASNORDERS_ITF_REINFO_SYNC;



  /*=================================================================================

    【正常使用】将 WMS-ASNORDERS 收货信息更新二次重传

    用途:
      将至多300条 WMS-ASNORDERS 收货信息更新到 SCMDATA.T_ASNORDERS，
      失败则更新 SCMDATA.T_ASNORDERS_ITF.PORT_STATUS 字段为 UE
            更新 SCMDATA.T_ASNORDERS_ITF.PORT_TIME   字段为 当前时间

    版本:
      2021-10-24: 将至多300条 WMS-ASNORDERS 收货信息更新到 SCMDATA.T_ASNORDERS，
                  失败则更新 SCMDATA.T_ASNORDERS_ITF.PORT_STATUS 字段为 UE
                  更新 SCMDATA.T_ASNORDERS_ITF.PORT_TIME   字段为 当前时间
      2022-03: 1.至多300条更改为至多500条
               2.旧更新 T_ASNINFO_PRETRANS_TO_WMS 逻辑被 P_UPDATE_ASNPTTOWMS_TO_PD 替换
               3.新增报错时间小于当前时间-7天时，状态由 UE 修改为 ENS（ERROR NOT SYNC）

  =================================================================================*/
  PROCEDURE P_ASNORDERS_ITF_REINFO_ESYNC IS
    V_JUGNUM       NUMBER(1);
    V_ASNID        VARCHAR2(32);
    V_COMPID       VARCHAR2(32);
    V_RELAGOOID    VARCHAR2(32);
    V_CRETIME      DATE;
    V_ESTATUS      VARCHAR2(4);
  BEGIN
    FOR I IN (SELECT A.ASN_ID, A.COMPANY_ID, B.GOO_ID, A.GOO_ID RELA_GOO_ID, A.ORDER_AMOUNT, A.GOT_AMOUNT, A.PCOME_AMOUNT, A.MEMO,
                     A.ASNGOT_AMOUNT, A.RET_AMOUNT, A.PICK_TIME, A.SHIMENT_TIME, A.RECEIVE_TIME, A.WAREHOUSE_POS, A.CREATE_ID, A.CREATE_TIME
                FROM (SELECT ASN_ID, COMPANY_ID, GOO_ID, ORDER_AMOUNT, PCOME_AMOUNT, ASNGOT_AMOUNT, GOT_AMOUNT, MEMO,
                             RET_AMOUNT, PICK_TIME, SHIMENT_TIME, RECEIVE_TIME, WAREHOUSE_POS, CREATE_ID, CREATE_TIME
                        FROM SCMDATA.T_ASNORDERS_ITF
                       WHERE PORT_STATUS IN ('UE','SE')
                         AND PORT_ELEMENT IN ('a_qa_pt100_ins','a_qa_pt100_upd')
                       ORDER BY PORT_TIME) A
                LEFT JOIN SCMDATA.T_COMMODITY_INFO B
                  ON A.GOO_ID = B.RELA_GOO_ID
                 AND A.COMPANY_ID = B.COMPANY_ID
               WHERE ROWNUM <= 500) LOOP
      BEGIN
        V_ASNID := I.ASN_ID;
        V_COMPID := I.COMPANY_ID;
        V_RELAGOOID := I.RELA_GOO_ID;

        SELECT COUNT(1)
          INTO V_JUGNUM
          FROM SCMDATA.T_ASNORDERS
         WHERE ASN_ID = I.ASN_ID
           AND COMPANY_ID = I.COMPANY_ID
           AND ROWNUM = 1;

        IF V_JUGNUM = 0 THEN
          INSERT INTO SCMDATA.T_ASNORDERS
            (ASN_ID,COMPANY_ID,DC_COMPANY_ID,GOO_ID,ORDER_AMOUNT,PCOME_AMOUNT,ASNGOT_AMOUNT,
             GOT_AMOUNT,RECEIVE_TIME,WAREHOUSE_POS,MEMO,CREATE_ID,CREATE_TIME)
          VALUES
            (I.ASN_ID,I.COMPANY_ID,I.COMPANY_ID,I.GOO_ID,I.ORDER_AMOUNT,I.PCOME_AMOUNT,I.ASNGOT_AMOUNT,
             I.GOT_AMOUNT,I.RECEIVE_TIME,I.WAREHOUSE_POS,I.MEMO,I.CREATE_ID,I.CREATE_TIME);
        ELSE
          UPDATE SCMDATA.T_ASNORDERS ASNS
             SET PCOME_AMOUNT = I.ORDER_AMOUNT,
                 GOT_AMOUNT = I.GOT_AMOUNT,
                 RET_AMOUNT = I.RET_AMOUNT,
                 RECEIVE_TIME = I.RECEIVE_TIME,
                 WAREHOUSE_POS = I.WAREHOUSE_POS
           WHERE ASN_ID = I.ASN_ID
             AND COMPANY_ID = I.COMPANY_ID
             AND GOO_ID = I.GOO_ID;
        END IF;

        UPDATE SCMDATA.T_ASNORDERS_ITF
             SET PORT_STATUS = 'US',
                 PORT_TIME = SYSDATE
           WHERE ASN_ID = I.ASN_ID
             AND COMPANY_ID = I.COMPANY_ID
             AND GOO_ID = I.RELA_GOO_ID;

        SELECT COUNT(1)
          INTO V_JUGNUM
          FROM SCMDATA.T_ASNORDERSITEM
         WHERE ASN_ID = I.ASN_ID
           AND COMPANY_ID = I.COMPANY_ID
           AND ROWNUM = 1;

        IF V_JUGNUM = 0 THEN
          UPDATE SCMDATA.T_QA_SCOPE
             SET PCOME_AMOUNT = I.ORDER_AMOUNT,
                 GOT_AMOUNT = I.GOT_AMOUNT,
                 TAKEOVER_TIME = I.RECEIVE_TIME,
                 IS_QUALITY = 0
           WHERE ASN_ID = I.ASN_ID
             AND GOO_ID = I.GOO_ID
             AND BARCODE IS NULL
             AND COMPANY_ID = I.COMPANY_ID;

          IF I.RECEIVE_TIME IS NOT NULL THEN
            P_UPDATE_ASNPTTOWMS_TO_PD(V_ASNID   => I.ASN_ID,
                                      V_GOOID   => I.GOO_ID,
                                      V_BARCODE => NULL,
                                      V_COMPID  => I.COMPANY_ID);
          END IF;
        END IF;

      EXCEPTION
        WHEN OTHERS THEN
          IF V_CRETIME < SYSDATE - 10/(24*60) THEN
            V_ESTATUS := 'ENS'; --ERROR NOT SYNC
          ELSE
            V_ESTATUS := 'UE';
          END IF;

          UPDATE SCMDATA.T_ASNORDERS_ITF
             SET PORT_STATUS = V_ESTATUS,
                 PORT_TIME = SYSDATE
           WHERE ASN_ID = V_ASNID
             AND COMPANY_ID = V_COMPID
             AND GOO_ID = V_RELAGOOID;
      END;
    END LOOP;
  END P_ASNORDERS_ITF_REINFO_ESYNC;



  /*=================================================================================

    【正常使用】将 WMS-ASNORDERSITEM 收货信息更新到 SCMDATA.T_ASNORDERSITEM

    用途:
      将至多300条 WMS-ASNORDERSITEM 收货信息更新到 SCMDATA.T_ASNORDERSITEM，
      失败则更新 SCMDATA.T_ASNORDERSITEM_ITF.PORT_STATUS 字段为 UE
            更新 SCMDATA.T_ASNORDERSITEM_ITF.PORT_TIME   字段为 当前时间

    版本:
      2021-10-24: 将至多300条 WMS-ASNORDERSITEM 收货信息更新到 SCMDATA.T_ASNORDERSITEM，
                  失败则更新 SCMDATA.T_ASNORDERSITEM_ITF.PORT_STATUS 字段为 UE
                        更新 SCMDATA.T_ASNORDERSITEM_ITF.PORT_TIME   字段为 当前时间
      2022-03: 1.至多300条提升为至多1500条，并将状态为SP的也列入更新
               2.旧更新 T_ASNINFO_PRETRANS_TO_WMS 逻辑被 P_UPDATE_ASNPTTOWMS_TO_PD 替换
               3.新增报错时间小于当前时间-7天时，状态由 UE 修改为 ENS（ERROR NOT SYNC）

  =================================================================================*/
  PROCEDURE P_ASNORDERSITEM_ITF_REINFO_SYNC IS
    V_JUGNUM    NUMBER(1);
    V_ASNID     VARCHAR2(32);
    V_GOODID    VARCHAR2(32);
    V_COMPID    VARCHAR2(32);
    V_BARCODE   VARCHAR2(32);
    V_ESTATUS   VARCHAR2(4);
    V_CRETIME   DATE;
  BEGIN
    FOR I IN (SELECT ASN_ID, COMPANY_ID, GOO_ID, BARCODE, PCOME_AMOUNT,ASNGOT_AMOUNT, GOT_AMOUNT, ORDER_AMOUNT,
                     RET_AMOUNT, PICK_TIME, SHIPMENT_TIME, RECEIVE_TIME, WAREHOUSE_POS, CREATE_TIME
                FROM (SELECT ASN_ID,GOO_ID,BARCODE,COMPANY_ID,
                             MAX(PCOME_AMOUNT) PCOME_AMOUNT,
                             MAX(ASNGOT_AMOUNT) ASNGOT_AMOUNT,
                             SUM(GOT_AMOUNT) GOT_AMOUNT,
                             MAX(ORDER_AMOUNT) ORDER_AMOUNT,
                             MAX(RET_AMOUNT) RET_AMOUNT,
                             MAX(PICK_TIME) PICK_TIME,
                             MAX(SHIPMENT_TIME) SHIPMENT_TIME,
                             MAX(RECEIVE_TIME) RECEIVE_TIME,
                             LISTAGG(WAREHOUSE_POS,';') WAREHOUSE_POS,
                             MAX(CREATE_TIME) CREATE_TIME
                        FROM SCMDATA.T_ASNORDERSITEM_ITF
                       WHERE (ASN_ID,GOO_ID,BARCODE,COMPANY_ID)
                          IN (SELECT ASN_ID,GOO_ID,BARCODE,COMPANY_ID
                                FROM SCMDATA.T_ASNORDERSITEM_ITF
                               WHERE PORT_STATUS IN ('UP','SP')
                                 AND PORT_ELEMENT IN ('a_qa_pt100_ins','a_qa_pt100_upd'))
                       GROUP BY ASN_ID,GOO_ID,BARCODE,COMPANY_ID)
               ORDER BY CREATE_TIME
               FETCH FIRST 1500 ROWS ONLY) LOOP
      BEGIN
        V_ASNID   := I.ASN_ID;
        V_COMPID  := I.COMPANY_ID;
        V_BARCODE := I.BARCODE;
        V_CRETIME := I.CREATE_TIME;

        SELECT COUNT(1)
          INTO V_JUGNUM
          FROM SCMDATA.T_ASNORDERSITEM
         WHERE ASN_ID = I.ASN_ID
           AND BARCODE = I.BARCODE
           AND COMPANY_ID = I.COMPANY_ID;

        SELECT MAX(GOO_ID)
          INTO V_GOODID
          FROM SCMDATA.T_COMMODITY_INFO
         WHERE RELA_GOO_ID = I.GOO_ID
           AND COMPANY_ID = I.COMPANY_ID;

        IF V_JUGNUM > 0 THEN
          UPDATE SCMDATA.T_ASNORDERSITEM ASNSITEM
             SET PCOME_AMOUNT = I.PCOME_AMOUNT,
                 GOT_AMOUNT = I.GOT_AMOUNT,
                 RET_AMOUNT = I.RET_AMOUNT,
                 RECEIVE_TIME = I.RECEIVE_TIME,
                 WAREHOUSE_POS = I.WAREHOUSE_POS
           WHERE ASN_ID = I.ASN_ID
             AND BARCODE = I.BARCODE
             AND COMPANY_ID = I.COMPANY_ID;
        ELSE
          INSERT INTO SCMDATA.T_ASNORDERSITEM
            (ASN_ID, COMPANY_ID, DC_COMPANY_ID, GOO_ID, BARCODE, ORDER_AMOUNT,
             PCOME_AMOUNT, ASNGOT_AMOUNT, GOT_AMOUNT, RET_AMOUNT, PICK_TIME,
             SHIPMENT_TIME, RECEIVE_TIME, WAREHOUSE_POS, CREATE_ID, CREATE_TIME)
          VALUES
            (V_ASNID, V_COMPID, V_COMPID, V_GOODID, V_BARCODE, I.ORDER_AMOUNT,
             I.PCOME_AMOUNT, I.ASNGOT_AMOUNT, I.GOT_AMOUNT, I.RET_AMOUNT,
             I.PICK_TIME, I.SHIPMENT_TIME, I.RECEIVE_TIME, I.WAREHOUSE_POS,
             'ADMIN', SYSDATE);
        END IF;

        --更新 SCMDATA.T_QA_SCOPE, SCMDATA.T_QA_REPORT 数量相关数据
        FOR X IN (SELECT DISTINCT QA_SCOPE_ID,QA_REPORT_ID,COMPANY_ID
                    FROM SCMDATA.T_QA_SCOPE
                   WHERE ASN_ID = I.ASN_ID
                     AND BARCODE = I.BARCODE
                     AND COMPANY_ID = I.COMPANY_ID) LOOP
          UPDATE SCMDATA.T_QA_SCOPE
             SET PCOME_AMOUNT = I.PCOME_AMOUNT,
                 GOT_AMOUNT = I.GOT_AMOUNT,
                 TAKEOVER_TIME = I.RECEIVE_TIME,
                 IS_QUALITY = 0
           WHERE QA_SCOPE_ID = X.QA_SCOPE_ID
             AND COMPANY_ID = X.COMPANY_ID;

          SCMDATA.PKG_QA_RELA.P_UPDATE_REP_AMOUNT(V_QAREPID => X.QA_REPORT_ID,
                                                  V_COMPID  => X.COMPANY_ID,
                                                  V_CURUSER => 'ADMIN');
        END LOOP;

        --更新 ASNINFO_PRETRANS_TO_WMS
        IF I.RECEIVE_TIME IS NOT NULL THEN
          SCMDATA.PKG_ASN_INTERFACE.P_UPDATE_ASNPTTOWMS_TO_PD(V_ASNID   => I.ASN_ID,
                                    V_GOOID   => V_GOODID,
                                    V_BARCODE => I.BARCODE,
                                    V_COMPID  => I.COMPANY_ID);
        END IF;

        SCMDATA.PKG_ASN_INTERFACE.P_DEL_PCOMEAMT_EQUALS_ZERO(V_ASNID   => I.ASN_ID,
                                   V_COMPID  => I.COMPANY_ID);

        UPDATE SCMDATA.T_ASNORDERSITEM_ITF
           SET PORT_STATUS = 'US',
               PORT_TIME = SYSDATE
         WHERE ASN_ID = I.ASN_ID
           AND COMPANY_ID = I.COMPANY_ID
           AND BARCODE = I.BARCODE;

      EXCEPTION
        WHEN OTHERS THEN
          IF V_CRETIME < SYSDATE - 7 THEN
            V_ESTATUS := 'ENS';
          ELSE
            V_ESTATUS := 'UE';
          END IF;

          UPDATE SCMDATA.T_ASNORDERSITEM_ITF
             SET PORT_STATUS = V_ESTATUS,
                 PORT_TIME = SYSDATE
           WHERE ASN_ID = V_ASNID
             AND COMPANY_ID = V_COMPID
             AND BARCODE = V_BARCODE;
      END;
    END LOOP;
  END P_ASNORDERSITEM_ITF_REINFO_SYNC;



  /*=================================================================================

    【正常使用】将 WMS-ASNORDERSITEM 收货信息错误信息二次同步

    用途:
      将至多1500条 WMS-ASNORDERSITEM 收货信息更新到 SCMDATA.T_ASNORDERSITEM，
      失败则更新 SCMDATA.T_ASNORDERSITEM_ITF.PORT_STATUS 字段为 UE
            更新 SCMDATA.T_ASNORDERSITEM_ITF.PORT_TIME   字段为 当前时间

    版本:
      2022-03-30: 将 WMS-ASNORDERSITEM 收货信息错误信息二次同步

  =================================================================================*/
  PROCEDURE P_ASNORDERSITEM_ITF_REINFO_ESYNC IS
    V_JUGNUM    NUMBER(1);
    V_ASNID     VARCHAR2(32);
    V_GOODID    VARCHAR2(32);
    V_COMPID    VARCHAR2(32);
    V_BARCODE   VARCHAR2(32);
    V_ESTATUS   VARCHAR2(4);
    V_CRETIME   DATE;
  BEGIN
    FOR I IN (SELECT ASN_ID, COMPANY_ID, GOO_ID, BARCODE, PCOME_AMOUNT,ASNGOT_AMOUNT, GOT_AMOUNT, ORDER_AMOUNT,
                     RET_AMOUNT, PICK_TIME, SHIPMENT_TIME, RECEIVE_TIME, WAREHOUSE_POS, CREATE_TIME
                FROM (SELECT ASN_ID,GOO_ID,BARCODE,COMPANY_ID,
                             MAX(PCOME_AMOUNT) PCOME_AMOUNT,
                             MAX(ASNGOT_AMOUNT) ASNGOT_AMOUNT,
                             SUM(GOT_AMOUNT) GOT_AMOUNT,
                             MAX(ORDER_AMOUNT) ORDER_AMOUNT,
                             MAX(RET_AMOUNT) RET_AMOUNT,
                             MAX(PICK_TIME) PICK_TIME,
                             MAX(SHIPMENT_TIME) SHIPMENT_TIME,
                             MAX(RECEIVE_TIME) RECEIVE_TIME,
                             LISTAGG(WAREHOUSE_POS,';') WAREHOUSE_POS,
                             MAX(CREATE_TIME) CREATE_TIME
                        FROM SCMDATA.T_ASNORDERSITEM_ITF
                       WHERE (ASN_ID,GOO_ID,BARCODE,COMPANY_ID)
                          IN (SELECT ASN_ID,GOO_ID,BARCODE,COMPANY_ID
                                FROM SCMDATA.T_ASNORDERSITEM_ITF
                               WHERE PORT_STATUS IN ('UE','SE')
                                 AND PORT_ELEMENT IN ('a_qa_pt100_ins','a_qa_pt100_upd'))
                       GROUP BY ASN_ID,GOO_ID,BARCODE,COMPANY_ID)
               ORDER BY CREATE_TIME
               FETCH FIRST 1500 ROWS ONLY) LOOP
      BEGIN
        V_ASNID := I.ASN_ID;
        V_COMPID := I.COMPANY_ID;
        V_BARCODE := I.BARCODE;
        V_CRETIME := I.CREATE_TIME;

        SELECT COUNT(1)
          INTO V_JUGNUM
          FROM SCMDATA.T_ASNORDERSITEM
         WHERE ASN_ID = I.ASN_ID
           AND BARCODE = I.BARCODE
           AND COMPANY_ID = I.COMPANY_ID;

        IF V_JUGNUM > 0 THEN
          UPDATE SCMDATA.T_ASNORDERSITEM ASNSITEM
             SET PCOME_AMOUNT = I.PCOME_AMOUNT,
                 GOT_AMOUNT = I.GOT_AMOUNT,
                 RET_AMOUNT = I.RET_AMOUNT,
                 RECEIVE_TIME = I.RECEIVE_TIME,
                 WAREHOUSE_POS = I.WAREHOUSE_POS
           WHERE ASN_ID = I.ASN_ID
             AND BARCODE = I.BARCODE
             AND COMPANY_ID = I.COMPANY_ID;
        ELSE
          INSERT INTO SCMDATA.T_ASNORDERSITEM
          SELECT A.ASN_ID,
                 A.COMPANY_ID,
                 A.DC_COMPANY_ID,
                 B.GOO_ID,
                 A.BARCODE,
                 A.ORDER_AMOUNT,
                 A.PCOME_AMOUNT,
                 A.ASNGOT_AMOUNT,
                 A.GOT_AMOUNT,
                 A.RET_AMOUNT,
                 A.PICK_TIME,
                 A.SHIPMENT_TIME,
                 A.RECEIVE_TIME,
                 A.WAREHOUSE_POS,
                 A.MEMO,
                 A.CREATE_ID,
                 A.CREATE_TIME,
                 A.UPDATE_ID,
                 A.UPDATE_TIME
            FROM SCMDATA.T_ASNORDERSITEM_ITF A
            LEFT JOIN SCMDATA.T_COMMODITY_INFO B
              ON A.GOO_ID = B.RELA_GOO_ID
             AND A.COMPANY_ID = B.COMPANY_ID
           WHERE A.ASN_ID = I.ASN_ID
             AND A.BARCODE = I.BARCODE
             AND A.COMPANY_ID = I.COMPANY_ID;
        END IF;

        --更新 SCMDATA.T_QA_SCOPE, SCMDATA.T_QA_REPORT 数量相关数据
        FOR X IN (SELECT DISTINCT QA_SCOPE_ID,QA_REPORT_ID,COMPANY_ID
                    FROM SCMDATA.T_QA_SCOPE
                   WHERE ASN_ID = I.ASN_ID
                     AND BARCODE = I.BARCODE
                     AND COMPANY_ID = I.COMPANY_ID) LOOP
          UPDATE SCMDATA.T_QA_SCOPE
             SET PCOME_AMOUNT = I.PCOME_AMOUNT,
                 GOT_AMOUNT = I.GOT_AMOUNT,
                 TAKEOVER_TIME = I.RECEIVE_TIME,
                 IS_QUALITY = 0
           WHERE QA_SCOPE_ID = X.QA_SCOPE_ID
             AND COMPANY_ID = X.COMPANY_ID;

          SCMDATA.PKG_QA_RELA.P_UPDATE_REP_AMOUNT(V_QAREPID => X.QA_REPORT_ID,
                                                  V_COMPID  => X.COMPANY_ID,
                                                  V_CURUSER => 'ADMIN');
        END LOOP;

        --更新 ASNINFO_PRETRANS_TO_WMS
        IF I.RECEIVE_TIME IS NOT NULL THEN
          SELECT MAX(GOO_ID)
            INTO V_GOODID
            FROM SCMDATA.T_COMMODITY_INFO
           WHERE RELA_GOO_ID = I.GOO_ID
             AND COMPANY_ID = I.COMPANY_ID;

          P_UPDATE_ASNPTTOWMS_TO_PD(V_ASNID   => I.ASN_ID,
                                    V_GOOID   => V_GOODID,
                                    V_BARCODE => I.BARCODE,
                                    V_COMPID  => I.COMPANY_ID);
        END IF;

        P_DEL_PCOMEAMT_EQUALS_ZERO(V_ASNID   => I.ASN_ID,
                                   V_COMPID  => I.COMPANY_ID);

        UPDATE SCMDATA.T_ASNORDERSITEM_ITF
           SET PORT_STATUS = 'US',
               PORT_TIME = SYSDATE
         WHERE ASN_ID = I.ASN_ID
           AND COMPANY_ID = I.COMPANY_ID
           AND BARCODE = I.BARCODE;
      EXCEPTION
        WHEN OTHERS THEN
          IF V_CRETIME < SYSDATE - 10/(24*60) THEN
            V_ESTATUS := 'ENS'; --ERROR NOT SYNC
          ELSE
            V_ESTATUS := 'UE';
          END IF;

          UPDATE SCMDATA.T_ASNORDERSITEM_ITF
             SET PORT_STATUS = V_ESTATUS,
                 PORT_TIME = SYSDATE
           WHERE ASN_ID = V_ASNID
             AND COMPANY_ID = V_COMPID
             AND BARCODE = V_BARCODE;
      END;
    END LOOP;
  END P_ASNORDERSITEM_ITF_REINFO_ESYNC;



  /*=================================================================================

    【正常使用】接入 WMS-ASNORDERED 收获信息到接口表

    用途:
      将 WMS-ASNORDERED 收获信息到接口表

    入参：
      V_ASNID    :   ASN单号
      V_COMPID   :   企业ID
      V_SCTIME   :   到仓扫描时间
      V_CGTIMES  :   修改次数
      V_PCDATE   :   预计到仓日期
      V_PCINTVAL :   预计到仓时段
      V_EOBJID   :   执行对象Id
      V_MINUTE   :  日志等待时间，变量未操作超过 V_MINUTE 分钟，记录到日志

    版本:
      2021-10-18: 增加 V_EOBJID, V_MINUTE 以适应外部请求传输数据场景

  =================================================================================*/
  PROCEDURE P_UPDATE_REINFO_INTO_ASNORDERED(V_ASNID    IN VARCHAR2,
                                            V_COMPID   IN VARCHAR2,
                                            V_SCTIME   IN VARCHAR2,
                                            V_CGTIMES  IN NUMBER,
                                            V_PCDATE   IN VARCHAR2,
                                            V_PCINTVAL IN VARCHAR2,
                                            V_EOBJID   IN VARCHAR2,
                                            V_MINUTE   IN NUMBER) IS
    V_JUGNUM    NUMBER(1);
    V_PTSTATUS  VARCHAR2(8);
    V_SCANTIME  DATE := TO_DATE(V_SCTIME, 'YYYY-MM-DD HH24-MI-SS');
    V_PCOMEDATE DATE := TO_DATE(V_PCDATE, 'YYYY-MM-DD HH24-MI-SS');
    V_EXESQL    VARCHAR2(1024);
  BEGIN
    SCMDATA.PKG_INTERFACE_LOG.P_INSERT_INFO_AND_INIT_VARIABLE(V_EOBJID => V_EOBJID,
                                                              V_COMPID => V_COMPID,
                                                              V_MINUTE => V_MINUTE);
    P_CHECK_ASNORDERED_EXISTS(V_ASNID     => V_ASNID,
                              V_COMPID    => V_COMPID,
                              V_JUGNUM    => V_JUGNUM,
                              V_PTSTATUS  => V_PTSTATUS);

    IF V_JUGNUM = 1 THEN
      V_EXESQL := 'UPDATE SCMDATA.T_ASNORDERED_ITF SET SCAN_TIME = :A, CHANGETIMES = :B, PCOME_DATE = :C, PCOME_INTERVAL = :D WHERE ASN_ID = :E AND COMPANY_ID = :F';

      EXECUTE IMMEDIATE V_EXESQL
        USING V_SCANTIME, V_CGTIMES, V_PCOMEDATE, V_PCINTVAL, V_ASNID, V_COMPID;

      /*SCMDATA.PKG_INF_ASN.P_SYNC_DELIVERY_RECORD_BY_ASNORDER(P_ASN_ID     => V_ASNID,
                                                             P_COMPANY_ID => V_COMPID);*/

      IF INSTR(',SS,UP,US,', ','||V_PTSTATUS||',') > 0 THEN
        P_CHECK_ASNINFO(V_TAB       => 'SCMDATA.T_ASNORDERED_ITF',
                      V_ASNID     => V_ASNID,
                      V_COMPANYID => V_COMPID,
                      V_EOBJID    => V_EOBJID,
                      V_SUCSTATUS => 'UP');
      ELSE
        P_CHECK_ASNINFO(V_TAB       => 'SCMDATA.T_ASNORDERED_ITF',
                        V_ASNID     => V_ASNID,
                        V_COMPANYID => V_COMPID,
                        V_EOBJID    => V_EOBJID);
      END IF;

    END IF;
    EXCEPTION
      WHEN OTHERS THEN
        V_EXESQL := 'UPDATE SCMDATA.T_ASNORDERED SET SCAN_TIME = '''||V_SCTIME||''', CHANGE_TIMES = '||V_CGTIMES||
                    ', PCOME_DATE = '''||V_PCDATE||''', PCOME_INTERVAL='''||V_PCINTVAL||''' WHERE ASN_ID = '''||
                    V_ASNID||''' AND COMPANY_ID = '''||V_COMPID||'''';

        SCMDATA.PKG_INTERFACE_LOG.P_ITF_RUNTIME_ERROR_LOGIC(V_EOBJID  => V_EOBJID,
                                                            V_COMPID  => V_COMPID,
                                                            V_TAB     => 'SCMDATA.T_ASNORDERED_ITF',
                                                            V_ERRSQL  => V_EXESQL,
                                                            V_UNQCOLS => 'ASN_ID',
                                                            V_UNQVALS => V_ASNID,
                                                            V_ST      => DBMS_UTILITY.FORMAT_ERROR_STACK);
  END P_UPDATE_REINFO_INTO_ASNORDERED;



  /*=================================================================================

    【正常使用】接入 WMS-ASNORDERS 收获信息到接口表

    用途:
      将 WMS-ASNORDERS 收获信息插入到接口表

    入参：
      V_ASNID       :   ASN单号
      V_COMPID      :   企业Id
      V_GOOID       :   商品档案编号
      V_ASNGOTAMT   :   预到货收货量
      V_GOTAMT      :   到货量
      V_RETAMT      :   退货量
      V_PKTIME      :   分拣时间
      V_SMTIME      :   发货时间
      V_WAPOS       :   库位
      V_EOBJID      :   执行对象Id
      V_MINUTE      :  日志等待时间，变量未操作超过 V_MINUTE 分钟，记录到日志

    版本:
      2021-10-18: 增加 V_EOBJID, V_MINUTE 以适应外部请求传输数据场景

  =================================================================================*/
  PROCEDURE P_UPDATE_REINFO_INTO_ASNORDERS(V_ASNID     IN VARCHAR2,
                                           V_COMPID    IN VARCHAR2,
                                           V_GOOID     IN VARCHAR2,
                                           V_ASNGOTAMT IN NUMBER,
                                           V_GOTAMT    IN NUMBER,
                                           V_RETAMT    IN NUMBER,
                                           V_PKTIME    IN VARCHAR2,
                                           V_SMTIME    IN VARCHAR2,
                                           V_RETIME    IN VARCHAR2,
                                           V_WAPOS     IN VARCHAR2,
                                           V_EOBJID    IN VARCHAR2,
                                           V_MINUTE    IN VARCHAR2) IS
    V_PICKTIME     DATE := TO_DATE(V_PKTIME, 'YYYY-MM-DD HH24-MI-SS');
    V_SHIPMENTTIME DATE := TO_DATE(V_SMTIME, 'YYYY-MM-DD HH24-MI-SS');
    V_RECEIVETIME  DATE := TO_DATE(V_RETIME, 'YYYY-MM-DD HH24-MI-SS');
    V_JUGNUM       NUMBER(1);
    V_PTSTATUS     VARCHAR2(8);
    V_EXESQL       VARCHAR2(1024);
  BEGIN
    SCMDATA.PKG_INTERFACE_LOG.P_INSERT_INFO_AND_INIT_VARIABLE(V_EOBJID => V_EOBJID,
                                                              V_COMPID => V_COMPID,
                                                              V_MINUTE => V_MINUTE);

    P_CHECK_ASNORDERS_EXISTS(V_ASNID     => V_ASNID,
                             V_COMPID    => V_COMPID,
                             V_GOOID     => V_GOOID,
                             V_JUGNUM    => V_JUGNUM,
                             V_PTSTATUS  => V_PTSTATUS);

    IF V_JUGNUM = 1 THEN
      V_EXESQL := 'UPDATE SCMDATA.T_ASNORDERS_ITF SET ASNGOT_AMOUNT = :A, GOT_AMOUNT = :B, RET_AMOUNT = :C, PICK_TIME = :D, SHIMENT_TIME = :E, RECEIVE_TIME = :F, WAREHOUSE_POS = :G WHERE ASN_ID = :H AND COMPANY_ID = :I AND GOO_ID = :J';

      EXECUTE IMMEDIATE V_EXESQL
        USING V_ASNGOTAMT, V_GOTAMT, V_RETAMT, V_PICKTIME, V_SHIPMENTTIME, V_RECEIVETIME, V_WAPOS, V_ASNID, V_COMPID, V_GOOID;

      /*SCMDATA.PKG_INF_ASN.P_SYNC_DELIVERY_RECORD_BY_ASNORDER(P_ASN_ID     => V_ASNID,
                                                             P_COMPANY_ID => V_COMPID);*/

      IF INSTR(',SS,UP,US,', ','||V_PTSTATUS||',') > 0 THEN
        P_CHECK_ASNINFO(V_TAB       => 'SCMDATA.T_ASNORDERS_ITF',
                        V_ASNID     => V_ASNID,
                        V_GOOID     => V_GOOID,
                        V_COMPANYID => V_COMPID,
                        V_EOBJID    => V_EOBJID,
                        V_SUCSTATUS => 'UP');
      ELSE
        P_CHECK_ASNINFO(V_TAB       => 'SCMDATA.T_ASNORDERS_ITF',
                        V_ASNID     => V_ASNID,
                        V_GOOID     => V_GOOID,
                        V_COMPANYID => V_COMPID,
                        V_EOBJID    => V_EOBJID);
      END IF;
    END IF;
    EXCEPTION
      WHEN OTHERS THEN
        V_EXESQL := 'UPDATE SCMDATA.T_ASNORDERS SET ASNGOT_AMOUNT = '||V_ASNGOTAMT||
                    ', GOT_AMOUNT = '||V_GOTAMT||', RET_AMOUNT = '||V_RETAMT||', PICK_TIME = '''||V_PKTIME||
                    ''', SHIPMENT_TIME = '''||V_SMTIME||''', RECEIVE_TIME = '''||V_RETIME||''', WAREHOUSE_POS ='''||
                    V_WAPOS||''' WHERE ASN_ID = '''||V_ASNID||''' AND COMPANY_ID = '''||V_ASNID||''' AND GOO_ID = '''||V_GOOID||'''';

        SCMDATA.PKG_INTERFACE_LOG.P_ITF_RUNTIME_ERROR_LOGIC(V_EOBJID  => V_EOBJID,
                                                            V_COMPID  => V_COMPID,
                                                            V_TAB     => 'SCMDATA.T_ASNORDERS_ITF',
                                                            V_ERRSQL  => V_EXESQL,
                                                            V_UNQCOLS => 'ASN_ID-GOO_ID',
                                                            V_UNQVALS => V_ASNID||'-'||V_GOOID,
                                                            V_ST      => DBMS_UTILITY.FORMAT_ERROR_STACK);
  END P_UPDATE_REINFO_INTO_ASNORDERS;



  /*=================================================================================

    【正常使用】接入 WMS-ASNORDERSITEM 收获信息到接口表

    用途:
      将 WMS-ASNORDERSITEM 收获信息插入到接口表

    入参:
      V_ASNID     :  ASN单号
      V_COMPID    :  企业Id
      V_GOOID     :  商品档案编号
      V_BARCODE   :  条码
      V_ASNGOTAMT :  预到货收货量
      V_GOTAMT    :  到货量
      V_RETAMT    :  退货量
      V_PKTIME    :  分拣时间
      V_SMTIME    :  发货时间
      V_RETIME    :  收货时间
      V_WAPOS     :  库位
      V_EOBJID    :   执行对象Id
      V_MINUTE    :  日志等待时间，变量未操作超过 V_MINUTE 分钟，记录到日志


    版本:
      2021-10-18: 增加 V_EOBJID, V_MINUTE 以适应外部请求传输数据场景

  =================================================================================*/
  PROCEDURE P_UPDATE_REINFO_INTO_ASNORDERSITEM(V_ASNID     IN VARCHAR2,
                                               V_COMPID    IN VARCHAR2,
                                               V_GOOID     IN VARCHAR2,
                                               V_BARCODE   IN VARCHAR2,
                                               V_ASNGOTAMT IN NUMBER,
                                               V_GOTAMT    IN NUMBER,
                                               V_RETAMT    IN NUMBER,
                                               V_PKTIME    IN VARCHAR2,
                                               V_SMTIME    IN VARCHAR2,
                                               V_RETIME    IN VARCHAR2,
                                               V_WAPOS     IN VARCHAR2,
                                               V_EOBJID    IN VARCHAR2,
                                               V_MINUTE    IN VARCHAR2) IS
    V_PICKTIME     DATE := TO_DATE(V_PKTIME, 'YYYY-MM-DD HH24-MI-SS');
    V_SHIPMENTTIME DATE := TO_DATE(V_SMTIME, 'YYYY-MM-DD HH24-MI-SS');
    V_RECEIVETIME  DATE := TO_DATE(V_RETIME, 'YYYY-MM-DD HH24-MI-SS');
    V_JUGNUM       NUMBER(4);
    V_ORDAMT       NUMBER(8);
    V_PCAMT        NUMBER(8);
    V_WHPOS        VARCHAR2(2048);
    V_EXESQL       VARCHAR2(1024);
  BEGIN
    SCMDATA.PKG_INTERFACE_LOG.P_INSERT_INFO_AND_INIT_VARIABLE(V_EOBJID => V_EOBJID,
                                                              V_COMPID => V_COMPID,
                                                              V_MINUTE => V_MINUTE);

    SELECT MAX(SIGN(INSTR(DECODE(WAREHOUSE_POS, ' ', NVL(V_WAPOS, ' '), WAREHOUSE_POS), NVL(V_WAPOS, ' ')))),
           MAX(WAREHOUSE_POS),
           MAX(ORDER_AMOUNT),
           MAX(PCOME_AMOUNT)
      INTO V_JUGNUM, V_WHPOS, V_ORDAMT, V_PCAMT
      FROM SCMDATA.T_ASNORDERSITEM_ITF
     WHERE ASN_ID = V_ASNID
       AND BARCODE = V_BARCODE
       AND COMPANY_ID = V_COMPID;

    IF V_JUGNUM = 1 THEN
      --更新覆盖记录
      IF V_WHPOS <> ' ' THEN
        V_EXESQL := 'UPDATE SCMDATA.T_ASNORDERSITEM_ITF SET ASNGOT_AMOUNT = :A, GOT_AMOUNT = :B, RET_AMOUNT = :C, PICK_TIME = :D,
                     SHIPMENT_TIME = :E, RECEIVE_TIME = :F WHERE ASN_ID = :H AND COMPANY_ID = :I AND BARCODE = :J AND WAREHOUSE_POS = :G ';
        EXECUTE IMMEDIATE V_EXESQL
          USING V_ASNGOTAMT, V_GOTAMT, V_RETAMT, V_PICKTIME, V_SHIPMENTTIME, V_RECEIVETIME, V_ASNID, V_COMPID, V_BARCODE, NVL(V_WAPOS,' ');
      ELSE
        V_EXESQL := 'UPDATE SCMDATA.T_ASNORDERSITEM_ITF SET ASNGOT_AMOUNT = :A, GOT_AMOUNT = :B, RET_AMOUNT = :C, PICK_TIME = :D,
                     SHIPMENT_TIME = :E, RECEIVE_TIME = :F, WAREHOUSE_POS = :G  WHERE ASN_ID = :H AND COMPANY_ID = :I AND BARCODE = :J';
        EXECUTE IMMEDIATE V_EXESQL
          USING V_ASNGOTAMT, V_GOTAMT, V_RETAMT, V_PICKTIME, V_SHIPMENTTIME, V_RECEIVETIME, NVL(V_WAPOS,' '), V_ASNID, V_COMPID, V_BARCODE;
      END IF;
    ELSE
      --新增记录
      V_EXESQL := 'INSERT INTO SCMDATA.T_ASNORDERSITEM_ITF (ASN_ID, COMPANY_ID, DC_COMPANY_ID, GOO_ID, BARCODE, ORDER_AMOUNT,
                   PCOME_AMOUNT, ASNGOT_AMOUNT, GOT_AMOUNT, RET_AMOUNT, PICK_TIME, SHIPMENT_TIME, RECEIVE_TIME, WAREHOUSE_POS, CREATE_ID, CREATE_TIME)
                   VALUES (:A,:B,:B,:C,:D,:E,:F,:G,:H,:I,:J,:K,:L,:M,''ADMIN'',SYSDATE)';
      EXECUTE IMMEDIATE V_EXESQL USING V_ASNID, V_COMPID, V_COMPID, V_GOOID, V_BARCODE, V_ORDAMT, V_PCAMT,
                         V_ASNGOTAMT, V_GOTAMT, V_RETAMT, V_PICKTIME, V_SHIPMENTTIME, V_RECEIVETIME, NVL(V_WAPOS,' ');
    END IF;

    --校验并设置状态
    SCMDATA.PKG_ASN_INTERFACE.P_CHECK_ASNINFO(V_TAB       => 'SCMDATA.T_ASNORDERSITEM_ITF',
                                              V_ASNID     => V_ASNID,
                                              V_GOOID     => V_GOOID,
                                              V_COMPANYID => V_COMPID,
                                              V_EOBJID    => V_EOBJID,
                                              V_SUCSTATUS => 'UP');
    EXCEPTION
      WHEN OTHERS THEN
        V_EXESQL := 'UPDATE SCMDATA.T_ASNORDERSITEM_ITF SET ASNGOT_AMOUNT = '||V_ASNGOTAMT||', GOT_AMOUNT = '||V_GOTAMT||
                    ', RET_AMOUNT = '||V_RETAMT||', PICK_TIME = '''||V_PKTIME||''', SHIPMENT_TIME = '''||V_SMTIME||
                    ''', RECEIVE_TIME = '''||V_RETIME||''', WAREHOUSE_POS = '''||V_WAPOS||''' WHERE ASN_ID = '''||
                    V_ASNID||''' AND COMPANY_ID = '''||V_COMPID||''' AND BARCODE = '''||V_BARCODE||'''';

        SCMDATA.PKG_INTERFACE_LOG.P_ITF_RUNTIME_ERROR_LOGIC(V_EOBJID  => V_EOBJID,
                                                            V_COMPID  => V_COMPID,
                                                            V_TAB     => 'SCMDATA.T_ASNORDERSITEM_ITF',
                                                            V_ERRSQL  => V_EXESQL,
                                                            V_UNQCOLS => 'ASN_ID-GOO_ID-BARCODE',
                                                            V_UNQVALS => V_ASNID||'-'||V_GOOID||'-'||V_BARCODE,
                                                            V_ST      => DBMS_UTILITY.FORMAT_ERROR_STACK);
  END P_UPDATE_REINFO_INTO_ASNORDERSITEM;



  /*=================================================================================

    【正常使用】接入WMS质检信息

    用途:
      接入WMS质检信息，存入 SCMDATA.T_QA_WMSRESULT_ITF 用于生成报告

    入参：
      V_ASNID    :  ASN单号
      V_GOOID    :  货号
      V_CFRLT    :  质检确认结果
      V_BCODES   :  条码
      V_CFRLTS   :  SKU质检确认结果
      V_EOBJID   :  执行对象Id
      V_COMPID   :  企业Id

    版本:
      2021-10-24: 接入WMS质检信息，存入 SCMDATA.T_QA_WMSRESULT_ITF 用于生成报告

  =================================================================================*/
  PROCEDURE P_INS_WMSQUALINFO_INTO_ITFTAB(V_ASNID    IN VARCHAR2,
                                          V_GOOID    IN VARCHAR2,
                                          V_CFRLT    IN VARCHAR2,
                                          V_BCODES   IN VARCHAR2,
                                          V_CFRLTS   IN VARCHAR2,
                                          V_EOBJID   IN VARCHAR2,
                                          V_COMPID   IN VARCHAR2) IS
    V_JUGNUM    NUMBER(1);
    V_PTSTATUS  VARCHAR2(4);
  BEGIN
    SCMDATA.PKG_INTERFACE_LOG.P_INSERT_INFO_AND_INIT_VARIABLE(V_EOBJID => V_EOBJID,
                                                              V_COMPID => V_COMPID,
                                                              V_MINUTE => 1);

    P_CHECK_WMSRESULT_EXISTS(V_ASNID     => V_ASNID,
                             V_COMPID    => V_COMPID,
                             V_BARCODES  => V_BCODES,
                             V_JUGNUM    => V_JUGNUM,
                             V_PTSTATUS  => V_PTSTATUS);

    IF V_JUGNUM = 0 THEN
      INSERT INTO SCMDATA.T_QA_WMSRESULT_ITF
        (QW_ID, COMPANY_ID, ASN_ID, GOO_ID,COMFIRM_RESULT,
         BARCODES, COMFIRM_RESULTS_SKU,CREATE_ID, CREATE_TIME,
         PORT_ELEMENT, PORT_TIME, PORT_STATUS)
      VALUES
        (SCMDATA.F_GET_UUID(), V_COMPID, V_ASNID, V_GOOID,
         V_CFRLT, V_BCODES, V_CFRLTS, 'ADMIN', SYSDATE,
         V_EOBJID, SYSDATE, 'SP');
    ELSE
      UPDATE SCMDATA.T_QA_WMSRESULT_ITF
         SET COMFIRM_RESULT = V_CFRLT,
             COMFIRM_RESULTS_SKU = V_CFRLTS
       WHERE ASN_ID = V_ASNID
         AND BARCODES = V_BCODES
         AND COMPANY_ID = V_COMPID;
    END IF;
    SCMDATA.PKG_VARIABLE.P_SET_VARIABLE_INCREMENT(V_OBJID    => V_EOBJID,
                                                  V_COMPID   => V_COMPID,
                                                  V_VARNAME  => 'SSNUM');
    EXCEPTION
      WHEN OTHERS THEN
        SCMDATA.PKG_INTERFACE_LOG.P_UPDATE_INTERFACE_VARIABLE(V_EOBJID  => V_EOBJID,
                                                              V_COMPID  => V_COMPID,
                                                              V_UNQVAL  => V_ASNID||'-'||V_BCODES,
                                                              V_ERRINFO => DBMS_UTILITY.FORMAT_ERROR_STACK,
                                                              V_MODE    => 'RE');
  END P_INS_WMSQUALINFO_INTO_ITFTAB;



  /*=================================================================================

    Wms质检确认信息同步

    用途:
      用于Wms质检确认信息同步

    版本:
      2022-06-15 : 用于Wms质检确认信息同步

  =================================================================================*/
  PROCEDURE P_WMSINFO_SYNC IS
    V_ADMINUSER    VARCHAR2(32);
    V_RTQAREPIDS   CLOB;
    V_NRTQAREPIDS  CLOB;
    V_QWSTATUS     VARCHAR2(4);
    V_ASNID        VARCHAR2(32);
    V_COMPID       VARCHAR2(32);
    V_ASNSTATUS    VARCHAR2(4);
    V_NEEDRECALCQL VARCHAR2(1);
  BEGIN
    --获取管理员用户id
    SELECT MAX(USER_ID)
      INTO V_ADMINUSER
      FROM SCMDATA.SYS_USER
     WHERE UPPER(USER_ACCOUNT) IN ('SYS','ADMIN','SYSTEM');

    --隐式游标筛出需要生成报告的 asn_id
    FOR I IN (SELECT A.ASN_ID, A.COMPANY_ID
                FROM SCMDATA.T_QA_WMSRESULT_ITF A
               INNER JOIN SCMDATA.T_ASNORDERED B
                  ON A.ASN_ID = B.ASN_ID
                 AND A.COMPANY_ID = B.COMPANY_ID
               INNER JOIN SCMDATA.T_COMMODITY_INFO C
                  ON A.GOO_ID = C.RELA_GOO_ID
                 AND A.COMPANY_ID = C.COMPANY_ID
               WHERE A.PORT_STATUS = 'SP'
                 AND C.CATEGORY IN ('00', '01', '03', '12')
                 AND EXISTS (SELECT 1
                        FROM SCMDATA.T_ORDERED
                       WHERE ORDER_CODE = B.ORDER_ID
                         AND COMPANY_ID = B.COMPANY_ID)
               GROUP BY A.ASN_ID, A.COMPANY_ID
               ORDER BY MAX(A.PORT_TIME)
               FETCH FIRST 30 ROWS ONLY) LOOP
      --重置 SCMDATA.T_QA_WMSRESULT_ITF.STATUS;V_NEEDRECALCQL值
      V_QWSTATUS :='SS';
      V_NEEDRECALCQL := 'N';

      --将 asn_id,company_id 存入变量，在执行异常时使用
      V_ASNID := I.ASN_ID;
      V_COMPID := I.COMPANY_ID;

      --获取最新的报告Id
      SELECT MAX(CASE WHEN INSTR(LISTAGG(SKUCOMFIRM_RESULT,';'),'RT')>0 THEN LISTAGG(DISTINCT QA_REPORT_ID,';') ELSE NULL END)  RT_QAREPID,
             MAX(CASE WHEN INSTR(LISTAGG(SKUCOMFIRM_RESULT,';'),'PS')>0 OR INSTR(LISTAGG(NVL(SKUCOMFIRM_RESULT,'NP'),';'),'NP')>0 THEN LISTAGG(DISTINCT QA_REPORT_ID,';') ELSE NULL END) NRT_QAREPID
        INTO V_RTQAREPIDS, V_NRTQAREPIDS
        FROM (SELECT DISTINCT B.ASN_ID,B.GOO_ID,B.BARCODE,A.COMPANY_ID,
                              FIRST_VALUE(A.QA_REPORT_ID) OVER(PARTITION BY B.ASN_ID, B.GOO_ID, B.BARCODE, A.COMPANY_ID ORDER BY NVL(B.SKUCOMFIRM_TIME, A.COMFIRM_TIME) DESC) QA_REPORT_ID,
                              FIRST_VALUE(B.SKUCOMFIRM_RESULT) OVER(PARTITION BY B.ASN_ID, B.GOO_ID, B.BARCODE, A.COMPANY_ID ORDER BY NVL(B.SKUCOMFIRM_TIME, A.COMFIRM_TIME) DESC) SKUCOMFIRM_RESULT
                FROM SCMDATA.T_QA_REPORT A
               INNER JOIN SCMDATA.T_QA_SCOPE B
                  ON A.QA_REPORT_ID = B.QA_REPORT_ID
                 AND A.COMPANY_ID = B.COMPANY_ID
               WHERE B.ASN_ID = I.ASN_ID
                 AND B.COMPANY_ID = I.COMPANY_ID
                 AND A.STATUS IN ('N_PCF', 'R_PCF', 'N_ACF', 'R_ACF')
                 AND EXISTS (SELECT 1 FROM SCMDATA.T_QA_WMSRESULT_ITF C
                              INNER JOIN SCMDATA.T_COMMODITY_INFO D
                                 ON C.GOO_ID = D.RELA_GOO_ID
                                AND C.COMPANY_ID = D.COMPANY_ID
                              WHERE C.PORT_STATUS = 'SP'
                                AND C.ASN_ID = B.ASN_ID
                                AND NVL(C.BARCODES,D.GOO_ID) = NVL(B.BARCODE,B.GOO_ID)
                                AND C.COMPANY_ID = B.COMPANY_ID))
       GROUP BY ASN_ID, COMPANY_ID;

      --存在返工数据，对该 asn 下所有需要返工数据生成返工质检报告
      IF V_RTQAREPIDS IS NOT NULL THEN
        P_GEN_RCPCF_QAREP_BYWMSDATA(V_ASNID     => I.ASN_ID,
                                    V_COMPID    => I.COMPANY_ID,
                                    V_RAWREPIDS => V_RTQAREPIDS,
                                    V_SYSUSER   => V_ADMINUSER);

        --已检列表重算标识变量赋值
        V_NEEDRECALCQL := 'Y';
      END IF;

      --存在非返工数据，合并质检确认结果到报告内
      IF V_NRTQAREPIDS IS NOT NULL THEN
        P_COMBINE_QAREP_BYWMSDATA(V_ASNID     => I.ASN_ID,
                                  V_COMPID    => I.COMPANY_ID,
                                  V_RAWREPIDS => V_NRTQAREPIDS,
                                  V_SYSUSER   => V_ADMINUSER);

        --已检列表重算标识变量赋值
        V_NEEDRECALCQL := 'Y';
      END IF;


      IF V_RTQAREPIDS IS NULL AND V_NRTQAREPIDS IS NULL THEN
        --报告Id为空
        --存在2种情况，1是特批，1是还未质检
        SELECT MAX(STATUS)
          INTO V_ASNSTATUS
          FROM SCMDATA.T_ASNORDERED
         WHERE ASN_ID = I.ASN_ID
           AND COMPANY_ID = I.COMPANY_ID;

        IF V_ASNSTATUS = 'SA' THEN
          --生成非返工待检数据
          P_GEN_NCPCF_QAREP_BYWMSDATA(V_ASNID     => I.ASN_ID,
                                      V_COMPID    => I.COMPANY_ID,
                                      V_SYSUSER   => V_ADMINUSER);

          --已检列表重算标识变量赋值
          V_NEEDRECALCQL := 'Y';
        ELSIF V_ASNSTATUS = 'NC' THEN
          --生成非返工待检数据
          P_GEN_NCPCF_QAREP_BYWMSDATA(V_ASNID     => I.ASN_ID,
                                      V_COMPID    => I.COMPANY_ID,
                                      V_SYSUSER   => V_ADMINUSER);
        ELSE
          V_QWSTATUS := 'ER';
        END IF;
      END IF;

      --已检asn数据重算
      IF V_NEEDRECALCQL = 'Y' THEN
        SCMDATA.PKG_QA_RELA.P_IU_QUALEDLIST(V_ASNID  => I.ASN_ID,
                                            V_COMPID => I.COMPANY_ID);
      END IF;

      --状态变更
      UPDATE SCMDATA.T_QA_WMSRESULT_ITF
         SET PORT_STATUS = V_QWSTATUS
       WHERE ASN_ID = I.ASN_ID
         AND COMPANY_ID = I.COMPANY_ID
         AND PORT_STATUS = 'SP';
    END LOOP;
    EXCEPTION
      WHEN OTHERS THEN
        UPDATE SCMDATA.T_QA_WMSRESULT_ITF
           SET PORT_STATUS = 'ER'
         WHERE ASN_ID = V_ASNID
           AND COMPANY_ID = V_COMPID
           AND PORT_STATUS = 'SP';
  END P_WMSINFO_SYNC;



 /*=================================================================================

    根据Wms质检确认数据生成非返工待确认报告

    用途:
      用于根据Wms质检确认数据生成非返工待确认报告

    入参:
      V_ASNID       :  ASN单号
      V_COMPID      :  企业Id
      V_SYSUSER     :  操作人

    版本:
      2022-06-15 : 用于根据Wms质检确认数据生成非返工待确认报告

  =================================================================================*/
  PROCEDURE P_GEN_NCPCF_QAREP_BYWMSDATA(V_ASNID      IN VARCHAR2,
                                        V_COMPID     IN VARCHAR2,
                                        V_SYSUSER    IN VARCHAR2) IS
    V_QAREPID     VARCHAR2(32);
    V_GOOID       VARCHAR2(32);
  BEGIN
    --获取报告Id
    V_QAREPID := SCMDATA.F_GETKEYID_PLAT(PI_PRE     => 'QA',
                                         PI_SEQNAME => 'seq_qaid',
                                         PI_SEQNUM  => 2);

    SELECT MAX(GOO_ID)
      INTO V_GOOID
      FROM SCMDATA.T_ASNORDERS
     WHERE ASN_ID = V_ASNID
       AND COMPANY_ID = V_COMPID;

    --新增报告
    INSERT INTO SCMDATA.T_QA_REPORT
      (QA_REPORT_ID,COMPANY_ID,CHECK_TYPE,STATUS,GOO_ID,
       CREATE_ID,CREATE_TIME,ORIGIN,COMFIRM_ID,
       COMFIRM_TIME,COMFIRM_RESULT,COMMIT_ID,COMMIT_TIME,
       UNQUAL_TREATMENT,CHECK_DATE)
    VALUES
      (V_QAREPID,V_COMPID,'AC','N_PCF',V_GOOID,
       V_SYSUSER,SYSDATE,'SCM',V_SYSUSER,SYSDATE,'PP',
       V_SYSUSER,SYSDATE,'NON',SYSDATE);

    --新增质检范围逻辑
    FOR I IN (SELECT A.ORDER_ID, B.ASN_ID, B.GOO_ID, C.BARCODE, A.COMPANY_ID,
                     NVL(C.ORDER_AMOUNT,B.ORDER_AMOUNT) ORDAMT,
                     NVL(C.PCOME_AMOUNT,B.PCOME_AMOUNT) PCAMT,
                     NVL(C.GOT_AMOUNT,B.GOT_AMOUNT) GTAMT,
                     NVL(C.RET_AMOUNT,B.RET_AMOUNT) RTAMT,
                     NVL(C.PICK_TIME,B.PICK_TIME) PKTIME,
                     NVL(C.SHIPMENT_TIME,B.SHIMENT_TIME) SPTIME,
                     NVL(C.RECEIVE_TIME,B.RECEIVE_TIME) RCTIME,
                     NVL(C.WAREHOUSE_POS,B.WAREHOUSE_POS) WHPOS,
                     D.SUPPLIER_CODE, A.PCOME_DATE, A.SCAN_TIME
                FROM SCMDATA.T_ASNORDERED A
               INNER JOIN SCMDATA.T_ASNORDERS B
                  ON A.ASN_ID = B.ASN_ID
                 AND A.COMPANY_ID = B.COMPANY_ID
               INNER JOIN SCMDATA.T_ASNORDERSITEM C
                  ON A.ASN_ID = C.ASN_ID
                 AND A.COMPANY_ID = C.COMPANY_ID
                 AND C.PCOME_AMOUNT > 0
               INNER JOIN SCMDATA.T_ORDERED D
                  ON A.ORDER_ID = D.ORDER_CODE
                 AND A.COMPANY_ID = D.COMPANY_ID
               WHERE A.ASN_ID = V_ASNID
                 AND A.COMPANY_ID = V_COMPID) LOOP
      INSERT INTO SCMDATA.T_QA_SCOPE
        (QA_SCOPE_ID, QA_REPORT_ID, COMPANY_ID, ASN_ID, ORDER_ID, GOO_ID, BARCODE, PROCESSING_TYPE,
         SUPPLIER_CODE, PCOME_AMOUNT, GOT_AMOUNT, SUBS_AMOUNT, PCOME_TIME, SCAN_TIME, TAKEOVER_TIME,
         CREATE_ID, CREATE_TIME, ORIGIN)
      VALUES
        (SCMDATA.F_GET_UUID(),V_QAREPID, I.COMPANY_ID, I.ASN_ID, I.ORDER_ID, I.GOO_ID, I.BARCODE, 'NM',
         I.SUPPLIER_CODE, I.PCAMT, I.GTAMT, 0, I.PCOME_DATE, I.SCAN_TIME, I.RCTIME, V_SYSUSER, SYSDATE, 'SCM');
    END LOOP;

    --通过 wms 质检数据更新 scm 数据
    FOR L IN (SELECT QWI.ASN_ID, TCI.GOO_ID, QWI.BARCODES,
                     DECODE(QWI.COMFIRM_RESULTS_SKU,'AP','PS',QWI.COMFIRM_RESULTS_SKU) COMFIRM_RESULTS_SKU
                FROM SCMDATA.T_QA_WMSRESULT_ITF QWI
               INNER JOIN SCMDATA.T_COMMODITY_INFO TCI
                  ON QWI.GOO_ID = TCI.RELA_GOO_ID
                 AND QWI.COMPANY_ID = TCI.COMPANY_ID
               WHERE QWI.ASN_ID = V_ASNID
                 AND QWI.PORT_STATUS = 'SP'
                 AND QWI.COMPANY_ID = V_COMPID)LOOP
      UPDATE SCMDATA.T_QA_SCOPE
         SET SKUCOMFIRM_ID = V_SYSUSER,
             SKUCOMFIRM_TIME = SYSDATE,
             SKUCOMFIRM_RESULT = L.COMFIRM_RESULTS_SKU,
             ORIGIN = 'WMS'
       WHERE ASN_ID = L.ASN_ID
         AND NVL(BARCODE,GOO_ID) = NVL(L.BARCODES,L.GOO_ID)
         AND QA_REPORT_ID = V_QAREPID
         AND COMPANY_ID = V_COMPID;
    END LOOP;

    --生成次品记录
    SCMDATA.PKG_QA_RELA.P_GEN_SUBS_DATA(V_QAREPID => V_QAREPID,
                                        V_COMPID  => V_COMPID);

    --更新整个报告来源字段
    SCMDATA.PKG_ASN_INTERFACE.P_UPDATE_REP_ORIGIN(V_QAREPID    => V_QAREPID,
                                                  V_COMPID     => V_COMPID,
                                                  V_RCBARCODES => NULL);
    --更新报告数量
    SCMDATA.PKG_QA_RELA.P_UPDATE_REP_AMOUNT(V_QAREPID => V_QAREPID,
                                            V_COMPID  => V_COMPID,
                                            V_CURUSER => V_SYSUSER);

  END P_GEN_NCPCF_QAREP_BYWMSDATA;



  /*=================================================================================

    根据Wms质检确认数据生成返工待确认报告

    用途:
      用于根据Wms质检确认数据生成返工待确认报告

    入参:
      V_ASNID       :  ASN单号
      V_COMPID      :  企业Id
      V_RAWREPID    :  待返工质检报告id
      V_SYSUSER     :  操作人

    版本:
      2022-06-15 : 用于根据Wms质检确认数据生成返工待确认报告

  =================================================================================*/
  PROCEDURE P_GEN_RCPCF_QAREP_BYWMSDATA(V_ASNID      IN VARCHAR2,
                                        V_COMPID     IN VARCHAR2,
                                        V_RAWREPIDS  IN CLOB,
                                        V_SYSUSER    IN VARCHAR2) IS
    V_QAREPID       VARCHAR2(32);
    V_QASCPID       VARCHAR2(32);
    V_GOOID         VARCHAR2(32);
  BEGIN
    --获取报告Id
    V_QAREPID := SCMDATA.F_GETKEYID_PLAT(PI_PRE     => 'QA',
                                         PI_SEQNAME => 'seq_qaid',
                                         PI_SEQNUM  => 2);

    --获取商品档案编号
    SELECT MAX(GOO_ID)
      INTO V_GOOID
      FROM SCMDATA.T_ASNORDERS
     WHERE ASN_ID = V_ASNID
       AND COMPANY_ID = V_COMPID;

    --新增报告
    INSERT INTO SCMDATA.T_QA_REPORT
      (QA_REPORT_ID,COMPANY_ID,CHECK_TYPE,STATUS,GOO_ID,
       CREATE_ID,CREATE_TIME,ORIGIN,COMFIRM_ID,
       COMFIRM_TIME,COMFIRM_RESULT,COMMIT_ID,COMMIT_TIME,
       UNQUAL_TREATMENT,CHECK_DATE)
    VALUES
      (V_QAREPID,V_COMPID,'RC','R_PCF',V_GOOID,
       V_SYSUSER,SYSDATE,'SCM',V_SYSUSER,SYSDATE,'PP',
       V_SYSUSER,SYSDATE,'NON',SYSDATE);

    --按标准待确认报告生成流程生成质检范围表数据
    FOR L IN (SELECT B.ASN_ID, B.GOO_ID, B.BARCODE, B.COMPANY_ID,
                     B.ORDER_ID, B.SUPPLIER_CODE, B.PCOME_AMOUNT,
                     B.GOT_AMOUNT, B.PCOME_TIME, B.SCAN_TIME, B.TAKEOVER_TIME
                FROM SCMDATA.T_QA_REPORT A
               INNER JOIN SCMDATA.T_QA_SCOPE B
                  ON A.QA_REPORT_ID = B.QA_REPORT_ID
                 AND A.COMPANY_ID = B.COMPANY_ID
               WHERE INSTR(V_RAWREPIDS, A.QA_REPORT_ID) > 0
                 AND A.COMPANY_ID = V_COMPID
                 AND B.ASN_ID = V_ASNID
                 AND B.SKUCOMFIRM_RESULT = 'RT') LOOP
      --QA_SCOPE_ID
      V_QASCPID := SCMDATA.F_GET_UUID();

      --新增质检范围数据
      INSERT INTO SCMDATA.T_QA_SCOPE
        (QA_SCOPE_ID,QA_REPORT_ID,COMPANY_ID,ASN_ID,ORDER_ID,GOO_ID,BARCODE,
         PROCESSING_TYPE,SUPPLIER_CODE,PCOME_AMOUNT,GOT_AMOUNT,PCOME_TIME,
         SCAN_TIME,TAKEOVER_TIME,CREATE_ID,CREATE_TIME,COMMIT_TYPE,ORIGIN)
      VALUES
        (V_QASCPID,V_QAREPID,V_COMPID,L.ASN_ID,L.ORDER_ID,L.GOO_ID,
         L.BARCODE,'NM',L.SUPPLIER_CODE,L.PCOME_AMOUNT,L.GOT_AMOUNT,
         L.PCOME_TIME,L.SCAN_TIME,L.TAKEOVER_TIME,V_SYSUSER,SYSDATE,
         'PC','SCM');

      --新增次品记录数据
      FOR N IN (SELECT ASN_ID, COMPANY_ID, GOODSID, PACK_BARCODE
                  FROM SCMDATA.T_ASNORDERPACKS
                 WHERE ASN_ID = L.ASN_ID
                   AND GOODSID = NVL(L.BARCODE,L.GOO_ID)
                   AND COMPANY_ID = L.COMPANY_ID) LOOP
        INSERT INTO SCMDATA.T_QA_SUBSRELA
          (SR_ID, COMPANY_ID, QA_SCOPE_ID, ASN_ID, GOODSID,
           PACKBARCODE, SUBS_AMOUNT)
        VALUES
          (SCMDATA.F_GET_UUID(), N.COMPANY_ID, V_QASCPID, N.ASN_ID,
           N.GOODSID, N.PACK_BARCODE, 0);
      END LOOP;
    END LOOP;

    --更新 SCMDATA.T_QA_WMSRESULT_ITF 数据进入 SCMDATA.T_QA_SCOPE
    FOR M IN (SELECT A1.ASN_ID, B1.GOO_ID, A1.BARCODES,
                     DECODE(A1.COMFIRM_RESULTS_SKU,'AP','PS',A1.COMFIRM_RESULTS_SKU) COMFIRM_RESULTS_SKU
                FROM SCMDATA.T_QA_WMSRESULT_ITF A1
               INNER JOIN SCMDATA.T_COMMODITY_INFO B1
                  ON A1.GOO_ID = B1.RELA_GOO_ID
                 AND A1.COMPANY_ID = B1.COMPANY_ID
               WHERE A1.ASN_ID = V_ASNID
                 AND A1.PORT_STATUS = 'SP'
                 AND A1.COMPANY_ID = V_COMPID
                 AND EXISTS (SELECT 1 FROM SCMDATA.T_QA_SCOPE
                              WHERE INSTR(V_RAWREPIDS,QA_REPORT_ID) > 0
                                AND COMPANY_ID = V_COMPID
                                AND SKUCOMFIRM_RESULT = 'RT')) LOOP
      UPDATE SCMDATA.T_QA_SCOPE
         SET SKUCOMFIRM_ID = V_SYSUSER,
             SKUCOMFIRM_TIME = SYSDATE,
             SKUCOMFIRM_RESULT = M.COMFIRM_RESULTS_SKU,
             ORIGIN = 'WMS'
       WHERE QA_REPORT_ID = V_QAREPID
         AND COMPANY_ID = V_COMPID
         AND ASN_ID = M.ASN_ID
         AND GOO_ID = M.GOO_ID
         AND BARCODE = M.BARCODES;
    END LOOP;

    --生成次品记录
    SCMDATA.PKG_QA_RELA.P_GEN_SUBS_DATA(V_QAREPID => V_QAREPID,
                                        V_COMPID  => V_COMPID);

    --更新整个报告来源字段
    SCMDATA.PKG_ASN_INTERFACE.P_UPDATE_REP_ORIGIN(V_QAREPID    => V_QAREPID,
                                                  V_COMPID     => V_COMPID,
                                                  V_RCBARCODES => NULL);
    --更新报告数量
    SCMDATA.PKG_QA_RELA.P_UPDATE_REP_AMOUNT(V_QAREPID => V_QAREPID,
                                            V_COMPID  => V_COMPID,
                                            V_CURUSER => V_SYSUSER);
  END P_GEN_RCPCF_QAREP_BYWMSDATA;




  /*=================================================================================

    根据Wms质检确认数据合并报告

    用途:
      用于根据Wms质检确认数据合并报告

    入参:
      V_ASNID       :  ASN单号
      V_COMPID      :  企业Id
      V_RAWREPID    :  待返工质检报告id
      V_SYSUSER     :  操作人

    版本:
      2022-06-15 : 根据Wms质检确认数据合并报告

  =================================================================================*/
  PROCEDURE P_COMBINE_QAREP_BYWMSDATA(V_ASNID     IN VARCHAR2,
                                      V_COMPID    IN VARCHAR2,
                                      V_RAWREPIDS IN CLOB,
                                      V_SYSUSER   IN VARCHAR2) IS
    V_QAREPID VARCHAR2(32);
  BEGIN
    FOR I IN (SELECT A.ASN_ID,
                     B.GOO_ID,
                     A.BARCODES,
                     DECODE(A.COMFIRM_RESULTS_SKU,'AP','PS',A.COMFIRM_RESULTS_SKU) COMFIRM_RESULTS_SKU,
                     A.COMPANY_ID
                FROM SCMDATA.T_QA_WMSRESULT_ITF A
               INNER JOIN SCMDATA.T_COMMODITY_INFO B
                  ON A.GOO_ID = B.RELA_GOO_ID
                 AND A.COMPANY_ID = B.COMPANY_ID
               INNER JOIN SCMDATA.T_QA_SCOPE C
                  ON A.ASN_ID = C.ASN_ID
                 AND B.GOO_ID = C.GOO_ID
                 AND NVL(A.BARCODES,' ') = NVL(C.BARCODE,' ')
                 AND INSTR(V_RAWREPIDS,C.QA_REPORT_ID) > 0
                 AND NVL(C.SKUCOMFIRM_RESULT,' ') <> 'RT'
                 AND A.COMPANY_ID = C.COMPANY_ID
               WHERE A.ASN_ID = V_ASNID
                 AND A.PORT_STATUS = 'SP'
                 AND A.COMPANY_ID = V_COMPID) LOOP
      SELECT MAX(QAREPID)
        INTO V_QAREPID
        FROM (SELECT FIRST_VALUE(QA_REPORT_ID) OVER(PARTITION BY ASN_ID, GOO_ID, BARCODE, COMPANY_ID ORDER BY SKUCOMFIRM_TIME DESC) QAREPID
                FROM SCMDATA.T_QA_SCOPE TMPSCP
               WHERE ASN_ID = I.ASN_ID
                 AND GOO_ID = I.GOO_ID
                 AND BARCODE = I.BARCODES
                 AND COMPANY_ID = I.COMPANY_ID
                 AND EXISTS (SELECT 1 FROM SCMDATA.T_QA_REPORT
                              WHERE QA_REPORT_ID = TMPSCP.QA_REPORT_ID
                                AND COMPANY_ID = TMPSCP.COMPANY_ID
                                AND STATUS IN ('N_PCF','N_ACF','R_PCF','R_ACF')));

      IF V_QAREPID IS NOT NULL THEN
        UPDATE SCMDATA.T_QA_SCOPE
           SET SKUCOMFIRM_RESULT = I.COMFIRM_RESULTS_SKU,
               SKUCOMFIRM_ID     = V_SYSUSER,
               SKUCOMFIRM_TIME   = SYSDATE,
               ORIGIN            = 'WMS'
         WHERE ASN_ID = I.ASN_ID
           AND GOO_ID = I.GOO_ID
           AND BARCODE = I.BARCODES
           AND QA_REPORT_ID = V_QAREPID
           AND COMPANY_ID = I.COMPANY_ID;

        UPDATE SCMDATA.T_QA_REPORT
           SET COMFIRM_RESULT = 'PP'
         WHERE QA_REPORT_ID = V_QAREPID
           AND COMPANY_ID = I.COMPANY_ID;
      END IF;

      --更新整个报告来源字段
      SCMDATA.PKG_ASN_INTERFACE.P_UPDATE_REP_ORIGIN(V_QAREPID    => V_QAREPID,
                                                    V_COMPID     => V_COMPID,
                                                    V_RCBARCODES => NULL);
      --更新报告数量
      SCMDATA.PKG_QA_RELA.P_UPDATE_REP_AMOUNT(V_QAREPID => V_QAREPID,
                                              V_COMPID  => V_COMPID,
                                              V_CURUSER => V_SYSUSER);
    END LOOP;
  END P_COMBINE_QAREP_BYWMSDATA;



  /*=================================================================================

    【正常使用】修改 QA 质检报告 ORIGIN 和 CHECK_TYPE

    用途:
      用于修改 QA 质检报告来源

    入参:
      V_QAREPID     :  QA质检报告Id
      V_COMPID      :  企业Id
      V_RCBARCODES  :  返工质检SKU条码

    版本:
      2021-11-05 : 用于修改 QA 质检报告来源

  =================================================================================*/
  PROCEDURE P_UPDATE_REP_ORIGIN(V_QAREPID     IN VARCHAR2,
                                V_COMPID      IN VARCHAR2,
                                V_RCBARCODES  IN VARCHAR2) IS
    V_SCMNUM      NUMBER(4);
    V_WMSNUM      NUMBER(4);
    V_FINORIGIN   VARCHAR2(8);
    V_STR         VARCHAR2(128);
    V_EXESQL      VARCHAR2(1024);
  BEGIN
    SELECT COUNT(1)
      INTO V_SCMNUM
      FROM SCMDATA.T_QA_SCOPE
     WHERE QA_REPORT_ID = V_QAREPID
       AND COMPANY_ID = V_COMPID
       AND ORIGIN LIKE 'SCM%';

    SELECT COUNT(1)
      INTO V_WMSNUM
      FROM SCMDATA.T_QA_SCOPE
     WHERE QA_REPORT_ID = V_QAREPID
       AND COMPANY_ID = V_COMPID
       AND ORIGIN LIKE 'WMS%';

    IF V_SCMNUM > 0 AND V_WMSNUM > 0 THEN
      V_FINORIGIN := 'SCM_WMS';
    ELSIF V_SCMNUM = 0 AND V_WMSNUM > 0 THEN
      V_FINORIGIN := 'WMS';
    ELSIF V_SCMNUM > 0 AND V_WMSNUM = 0 THEN
      V_FINORIGIN := 'SCM';
    END IF;

    IF V_RCBARCODES IS NOT NULL THEN
      V_STR := ',CHECK_TYPE = ''RC'',STATUS = SUBSTR(T.STATUS,1,1)||''_PCF'')';
    END IF;

    IF V_STR IS NOT NULL THEN
      V_EXESQL := 'UPDATE SCMDATA.T_QA_REPORT T SET T.ORIGIN = '''||V_FINORIGIN||
                  ''''||V_STR||' WHERE T.QA_REPORT_ID = '''||V_QAREPID||''' AND T.COMPANY_ID = '''||V_COMPID||'''';
    ELSE
      V_EXESQL := 'UPDATE SCMDATA.T_QA_REPORT SET ORIGIN = '''||V_FINORIGIN||
                  ''' WHERE QA_REPORT_ID = '''||V_QAREPID||''' AND COMPANY_ID = '''||V_COMPID||'''';
    END IF;
    EXECUTE IMMEDIATE V_EXESQL;
  END P_UPDATE_REP_ORIGIN;



  /*=================================================================================

    【正常使用】更新质检报告质检结果及状态

    用途:
      用于 WMS 质检数据进入业务表时更新质检报告质检结果及状态

    入参:
      V_QAREPID  :  QA质检报告ID
      V_CUID     :  操作人ID
      V_COMPID   :  企业ID

    版本:
      2021-11-08 :  用于 WMS 质检数据进入业务表时更新质检报告质检结果及状态

  =================================================================================*/
  PROCEDURE P_UPDATE_QAREP_CFRESULTANDSTATUS(V_QAREPID   IN VARCHAR2,
                                             V_CUID      IN VARCHAR2,
                                             V_COMPID    IN VARCHAR2) IS
    V_PSNUM     NUMBER(4);
    V_NPNUM     NUMBER(4);
    V_RTNUM     NUMBER(4);
    V_NCFNUM    NUMBER(4);
    V_CFRESULT  VARCHAR2(8);
  BEGIN
    SELECT COUNT(1)
      INTO V_PSNUM
      FROM SCMDATA.T_QA_SCOPE
     WHERE QA_REPORT_ID = V_QAREPID
       AND COMPANY_ID = V_COMPID
       AND SKUCOMFIRM_RESULT = 'PS';

    SELECT COUNT(1)
      INTO V_NPNUM
      FROM SCMDATA.T_QA_SCOPE
     WHERE QA_REPORT_ID = V_QAREPID
       AND COMPANY_ID = V_COMPID
       AND SKUCOMFIRM_RESULT = 'NP';

    SELECT COUNT(1)
      INTO V_RTNUM
      FROM SCMDATA.T_QA_SCOPE
     WHERE QA_REPORT_ID = V_QAREPID
       AND COMPANY_ID = V_COMPID
       AND SKUCOMFIRM_RESULT = 'RT';

    SELECT COUNT(1)
      INTO V_NCFNUM
      FROM SCMDATA.T_QA_SCOPE
     WHERE QA_REPORT_ID = V_QAREPID
       AND COMPANY_ID = V_COMPID
       AND SKUCOMFIRM_RESULT IS NULL;

    IF V_NCFNUM = 0 AND V_PSNUM > 0 AND V_NPNUM = 0 AND V_RTNUM = 0 THEN
      V_CFRESULT := 'PS';
    ELSIF V_NCFNUM = 0 AND V_PSNUM = 0 AND (V_NPNUM > 0 OR V_RTNUM > 0) THEN
      V_CFRESULT := 'NP';
    ELSIF V_NCFNUM = 0 AND V_PSNUM > 0 AND (V_NPNUM > 0 OR V_RTNUM > 0) THEN
      V_CFRESULT := 'PP';
    END IF;

    IF V_CFRESULT IS NOT NULL THEN
      UPDATE SCMDATA.T_QA_REPORT T
         SET COMFIRM_RESULT = V_CFRESULT,
             COMFIRM_ID = V_CUID,
             COMFIRM_TIME = SYSDATE
       WHERE QA_REPORT_ID = V_QAREPID
         AND COMPANY_ID = V_COMPID;
    END IF;
  END P_UPDATE_QAREP_CFRESULTANDSTATUS;



  /*=================================================================================

    【正常使用】校验是否存在于 SCMDATA.T_ASNINFO_PRETRANS_TO_WMS

    用途:
      用于校验 T_QA_SCOPE 数据是否存在于 SCMDATA.T_ASNINFO_PRETRANS_TO_WMS

    入参:
      V_QAREPID   :  QA质检报告Id
      V_QASCOPEID :  QA质检报告明细Id
      V_COMPID    :  企业Id

    返回值:
      0 不存在，1 存在

    版本:
      2021-10-20 : 从 SCMDATA.PKG_QA_LOGIC 迁移至 SCMDATA.PKG_ASN_INTERFACE

  =================================================================================*/
  FUNCTION F_CHECK_INFO_ALREADY_EXIST(V_QAREPID   IN VARCHAR2,
                                      V_QASCOPEID IN VARCHAR2 DEFAULT NULL,
                                      V_COMPID    IN VARCHAR2) RETURN NUMBER IS
    V_RETNUM  NUMBER(1);
    V_COND    VARCHAR2(128);
    V_EXESQL  VARCHAR2(512);
  BEGIN
    IF V_QASCOPEID IS NOT NULL THEN
      V_COND := ' AND QA_SCOPE_ID = '''||V_QASCOPEID||'''';
    END IF;

    V_EXESQL := 'SELECT COUNT(1) FROM SCMDATA.T_QA_SCOPE Z '||
                'WHERE QA_REPORT_ID = '''||V_QAREPID||''' AND COMPANY_ID = '''||
                V_COMPID||''''|| V_COND ||' AND EXISTS '||
                '(SELECT 1 FROM SCMDATA.T_ASNINFO_PRETRANS_TO_WMS WHERE '||
                'QA_REPORT_ID = Z.QA_REPORT_ID AND QA_SCOPE_ID = Z.QA_SCOPE_ID '||
                'AND COMPANY_ID = Z.COMPANY_ID) AND ROWNUM = 1';

    EXECUTE IMMEDIATE V_EXESQL INTO V_RETNUM;

    RETURN V_RETNUM;
  END F_CHECK_INFO_ALREADY_EXIST;



  /*=================================================================================

    【正常使用】校验单据内是否存在未收货数据

    用途:
      用于校验 T_QA_SCOPE 数据是否存在 TAKEOVER_TIME 为空，返回值大于0，说明存在
      未收货数据，返回值=0说明不存在未收货数据

    入参:
      V_QAREPID   :  QA质检报告Id
      V_QASCOPEID :  QA质检报告明细Id
      V_COMPID    :  企业Id

    返回值:
      0 不存在，1 存在

    版本:
      2021-11-01 : 新增校验 T_QA_SCOPE 数据是否存在 TAKEOVER_TIME 为空

  =================================================================================*/
  FUNCTION F_GHECK_TAKEOVER_TIME_EXIST(V_QAREPID   IN VARCHAR2,
                                       V_QASCOPEID IN VARCHAR2 DEFAULT NULL,
                                       V_COMPID    IN VARCHAR2) RETURN NUMBER IS
    V_RETNUM  NUMBER(1);
    V_COND    VARCHAR2(128);
    V_EXESQL  VARCHAR2(512);
  BEGIN
    IF V_QASCOPEID IS NOT NULL THEN
      V_COND := ' AND QA_SCOPE_ID = '''||V_QASCOPEID||'''';
    END IF;

    V_EXESQL := 'SELECT COUNT(1) FROM SCMDATA.T_QA_SCOPE Z '||
                'WHERE QA_REPORT_ID = '''||V_QAREPID||''' AND COMPANY_ID = '''||
                V_COMPID||''''|| V_COND ||' AND TAKEOVER_TIME IS NULL AND IS_QUALITY = 0 AND ROWNUM = 1';

    EXECUTE IMMEDIATE V_EXESQL INTO V_RETNUM;
    RETURN V_RETNUM;
  END F_GHECK_TAKEOVER_TIME_EXIST;



  /*=================================================================================

    【正常使用】生成预回传状态

    用途:
      用于生成预回传状态

    入参:
      V_QAREPID   :  QA质检报告Id
      V_QASCOPEID :  QA质检报告明细Id
      V_COMPID    :  企业Id

    返回值:
      ER 已存在，PD 待回传， TE 收货时间不存在

    版本:
      2021-10-20 : 从 SCMDATA.PKG_QA_LOGIC 迁移至 SCMDATA.PKG_ASN_INTERFACE
      2021-11-01 : 新增收货时间校验，新增 TE 返回状态

  =================================================================================*/
  FUNCTION F_GENERATE_ASN_PRETRANS_STATUS(V_QAREPID   IN VARCHAR2,
                                          V_QASCOPEID IN VARCHAR2 DEFAULT NULL,
                                          V_COMPID    IN VARCHAR2) RETURN VARCHAR2 IS
    V_JUGNUM     NUMBER(1);
    V_RETSTATUS  VARCHAR2(8);
  BEGIN
    V_JUGNUM := F_CHECK_INFO_ALREADY_EXIST(V_QAREPID   => V_QAREPID,
                                           V_QASCOPEID => V_QASCOPEID,
                                           V_COMPID    => V_COMPID);
    IF V_JUGNUM > 0 THEN
      V_RETSTATUS := 'SE';
    ELSE
      V_JUGNUM := F_GHECK_TAKEOVER_TIME_EXIST(V_QAREPID   => V_QAREPID,
                                              V_QASCOPEID => V_QASCOPEID,
                                              V_COMPID    => V_COMPID);
      IF V_JUGNUM > 0 THEN
        V_RETSTATUS := 'TE';
      ELSE
        V_RETSTATUS := 'PD';
      END IF;
    END IF;

    RETURN V_RETSTATUS;
  END F_GENERATE_ASN_PRETRANS_STATUS;



  /*=================================================================================

    【正常使用】生成 ASN-BARCODE 预回传信息

    用途:
      用于将要预回传到 WMS 的 QA_REPORT_ID, ASN_ID, QA_SCOPE_ID（可选） 存到
      SCMDATA.T_ASNINFO_PRETRANS_TO_WMS

    入参:
      V_QAREPID   :  QA质检报告Id
      V_QASCOPEID :  QA质检报告明细Id
      V_COMPID    :  企业Id
      V_CUID      :  当前操作人Id

    版本:
      2021-10-20 : 从 SCMDATA.PKG_QA_LOGIC 迁移至 SCMDATA.PKG_ASN_INTERFACE
      2021-11-01 : 将原有 STATUS <> 'PD' 不记录的限制去除
      2021-11-02 : 新增入参 ASN_ID 用于解决特批放行

  =================================================================================*/
  PROCEDURE P_GENERATE_ASN_PRETRANS_INFO(V_QAREPID   IN VARCHAR2 DEFAULT NULL,
                                         V_QASCOPEID IN VARCHAR2 DEFAULT NULL,
                                         V_ASNID     IN VARCHAR2 DEFAULT NULL,
                                         V_COMPID    IN VARCHAR2,
                                         V_CUID      IN VARCHAR2,
                                         V_STATUS    IN VARCHAR2 DEFAULT NULL) IS
    V_TMPST    VARCHAR2(8):=V_STATUS;
    V_LOGIC    VARCHAR2(2048);
    V_COND     VARCHAR2(512);
    V_EXESQL   VARCHAR2(4000);
  BEGIN
    IF V_TMPST IS NULL THEN
      V_TMPST := SCMDATA.PKG_ASN_INTERFACE.F_GENERATE_ASN_PRETRANS_STATUS(V_QAREPID   => V_QAREPID,
                                                                          V_QASCOPEID => V_QASCOPEID,
                                                                          V_COMPID    => V_COMPID);
    END IF;

    IF V_QAREPID IS NOT NULL THEN
      V_COND := ' QA_REPORT_ID = ''' || V_QAREPID || '''';
      V_LOGIC := 'IF V_JUGNUM = 0 THEN INSERT INTO SCMDATA.T_ASNINFO_PRETRANS_TO_WMS ' ||
                 '(INFO_ID,COMPANY_ID,STATUS,QA_REPORT_ID,CREATE_ID,CREATE_TIME) '||
                 'VALUES (SCMDATA.F_GET_UUID(),''' ||V_COMPID|| ''',''' ||V_TMPST|| ''',''' || V_QAREPID || ''',''' ||
                 V_CUID || ''',SYSDATE); ELSE UPDATE SCMDATA.T_ASNINFO_PRETRANS_TO_WMS SET STATUS = ''' || V_TMPST ||
                 ''' WHERE QA_REPORT_ID = ''' || V_QAREPID || ''' AND COMPANY_ID = ''' || V_COMPID || '''; END IF; END;';
    ELSIF V_QASCOPEID IS NOT NULL THEN
      V_COND := ' QA_SCOPE_ID = ''' || V_QASCOPEID || '''';
      V_LOGIC := 'IF V_JUGNUM = 0 THEN INSERT INTO SCMDATA.T_ASNINFO_PRETRANS_TO_WMS '||
                  '(INFO_ID,COMPANY_ID,STATUS,QA_SCOPE_ID,CREATE_ID,CREATE_TIME) '||
                  'VALUES (SCMDATA.F_GET_UUID(),'''||V_COMPID||''','''||V_TMPST||''','''||V_QASCOPEID||''','''||
                  V_CUID||''',SYSDATE); ELSE UPDATE SCMDATA.T_ASNINFO_PRETRANS_TO_WMS SET STATUS = ''' || V_TMPST ||
                 ''' WHERE QA_SCOPE_ID = ''' || V_QASCOPEID || ''' AND COMPANY_ID = ''' || V_COMPID || '''; END IF; END;';
    ELSIF V_ASNID IS NOT NULL THEN
      V_COND := ' ASN_ID = ''' || V_ASNID || '''';
      V_LOGIC := 'IF V_JUGNUM = 0 THEN INSERT INTO SCMDATA.T_ASNINFO_PRETRANS_TO_WMS '||
                  '(INFO_ID,COMPANY_ID,STATUS,ASN_ID,CREATE_ID,CREATE_TIME) '||
                  'VALUES (SCMDATA.F_GET_UUID(),'''||V_COMPID||''','''||V_TMPST||''','''||V_ASNID||''','''||
                  V_CUID||''',SYSDATE); ELSE UPDATE SCMDATA.T_ASNINFO_PRETRANS_TO_WMS SET STATUS = ''' || V_TMPST ||
                 ''' WHERE ASN_ID = ''' || V_ASNID || ''' AND COMPANY_ID = ''' || V_COMPID || '''; END IF; END;';
    END IF;

    V_EXESQL := 'DECLARE V_JUGNUM NUMBER(1); BEGIN SELECT COUNT(1) INTO V_JUGNUM FROM SCMDATA.T_ASNINFO_PRETRANS_TO_WMS WHERE '||
                V_COND || ' AND COMPANY_ID = '''||V_COMPID||''' AND ROWNUM = 1; '||V_LOGIC;

    EXECUTE IMMEDIATE V_EXESQL;
  END P_GENERATE_ASN_PRETRANS_INFO;


  /*=================================================================================

    【正常使用】通过 QA_REPORT_ID 生成 T_QUALRESULT_TO_WMS 预回传信息

    入参:
      V_QAREPID   :  QA质检报告Id
      V_OPERID    :  操作人Id
      V_COMPID    :  企业Id

    版本:
      2022-03-26 : 通过 QA_REPORT_ID 生成 T_QUALRESULT_TO_WMS 预回传信息

  =================================================================================*/
  PROCEDURE P_GEN_ASNPTTOWMS_BY_REPID(V_QAREPID   IN VARCHAR2,
                                      V_OPERID    IN VARCHAR2 DEFAULT NULL,
                                      V_COMPID    IN VARCHAR2) IS
    V_USERID   VARCHAR2(32):= 'gen_qrtw_by_repid';
    V_STATUS   VARCHAR2(4);
  BEGIN
    IF V_OPERID IS NOT NULL THEN
      V_USERID := V_OPERID;
    END IF;

    FOR I IN (SELECT QA_SCOPE_ID, COMPANY_ID, TAKEOVER_TIME
                FROM SCMDATA.T_QA_SCOPE
               WHERE QA_REPORT_ID = V_QAREPID
                 AND COMPANY_ID = V_COMPID
                 AND SKUCOMFIRM_RESULT <> 'RT'
                 AND IS_QUALITY = 0
                 AND INSTR(ORIGIN, 'SCM') > 0) LOOP
      IF I.TAKEOVER_TIME IS NOT NULL THEN
        V_STATUS := 'PD';
      ELSE
        V_STATUS := 'SE';
      END IF;

      INSERT INTO SCMDATA.T_ASNINFO_PRETRANS_TO_WMS
        (INFO_ID, COMPANY_ID, STATUS, QA_SCOPE_ID, CREATE_ID, CREATE_TIME)
      VALUES
        (SCMDATA.F_GET_UUID(), I.COMPANY_ID, V_STATUS, I.QA_SCOPE_ID, V_USERID, SYSDATE);
    END LOOP;
  END P_GEN_ASNPTTOWMS_BY_REPID;


  /*=================================================================================

    【正常使用】通过 QA_SCOPE_ID 生成 T_QUALRESULT_TO_WMS 预回传信息

    入参:
      V_QASCPID   :  ASN单号
      V_OPERID    :  操作人Id
      V_COMPID    :  企业Id

    版本:
      2022-03-26 : 通过 QA_REPORT_ID 生成 T_QUALRESULT_TO_WMS 预回传信息

  =================================================================================*/
  PROCEDURE P_GEN_ASNPTTOWMS_BY_SCPID(V_QASCPID   IN VARCHAR2,
                                      V_OPERID    IN VARCHAR2 DEFAULT NULL,
                                      V_COMPID    IN VARCHAR2) IS
    V_USERID     VARCHAR2(32):= 'gen_asnpttowms_by_scpid';
    V_TOTIME     DATE;
    V_ISQUAL     NUMBER(1);
    V_SKUCFREST  VARCHAR2(4);
    V_ORIGIN     VARCHAR2(8);
    V_STATUS     VARCHAR2(4);
  BEGIN
    IF V_OPERID IS NOT NULL THEN
      V_USERID := V_OPERID;
    END IF;

    SELECT MAX(TAKEOVER_TIME),
           MAX(IS_QUALITY),
           MAX(SKUCOMFIRM_RESULT),
           MAX(ORIGIN)
      INTO V_TOTIME, V_ISQUAL, V_SKUCFREST, V_ORIGIN
      FROM SCMDATA.T_QA_SCOPE
     WHERE QA_SCOPE_ID = V_QASCPID
       AND COMPANY_ID = V_COMPID;

    IF V_TOTIME IS NOT NULL THEN
        V_STATUS := 'PD';
      ELSE
        V_STATUS := 'SE';
      END IF;

    IF V_ISQUAL = 0 AND V_SKUCFREST <> 'RT' AND INSTR(V_ORIGIN,'SCM')>0 THEN
      INSERT INTO SCMDATA.T_ASNINFO_PRETRANS_TO_WMS
        (INFO_ID, COMPANY_ID, STATUS, QA_SCOPE_ID, CREATE_ID, CREATE_TIME)
      VALUES
        (SCMDATA.F_GET_UUID(), V_COMPID, V_STATUS, V_QASCPID, V_USERID, SYSDATE);
    END IF;
  END P_GEN_ASNPTTOWMS_BY_SCPID;



  /*=================================================================================

    【正常使用】通过 ASN_ID 生成 T_QUALRESULT_TO_WMS 预回传信息

    入参:
      V_ASNID     :  ASN单号
      V_OPERID    :  操作人Id
      V_COMPID    :  企业Id

    版本:
      2022-03-26 : 通过 QA_REPORT_ID 生成 T_QUALRESULT_TO_WMS 预回传信息

  =================================================================================*/
  PROCEDURE P_GEN_ASNPTTOWMS_BY_ASNID(V_ASNID     IN VARCHAR2,
                                      V_OPERID    IN VARCHAR2 DEFAULT NULL,
                                      V_COMPID    IN VARCHAR2) IS
    V_USERID   VARCHAR2(32):= 'gen_asnpttowms_by_asnid';
  BEGIN
    IF V_OPERID IS NOT NULL THEN
      V_USERID := V_OPERID;
    END IF;

    INSERT INTO SCMDATA.T_ASNINFO_PRETRANS_TO_WMS
      (INFO_ID, COMPANY_ID, STATUS, ASN_ID, CREATE_ID, CREATE_TIME)
    VALUES
      (SCMDATA.F_GET_UUID(), V_COMPID, 'PD', V_ASNID, V_USERID, SYSDATE);
  END P_GEN_ASNPTTOWMS_BY_ASNID;



  /*=================================================================================

    【正常使用】通过 QA_SCOPE_ID 生成 T_ASNINFO_PRETRANS_TO_WMS 预回传信息

    入参:
      V_QASCPID   :  ASN单号
      V_OPERID    :  操作人Id
      V_COMPID    :  企业Id

    版本:
      2022-03-30 : 通过 QA_SCOPE_ID 生成 T_QUALRESULT_TO_WMS 预回传信息

  =================================================================================*/
  PROCEDURE P_GEN_ASNPTTOWMS_BY_PPSCPID(V_QASCPID  IN VARCHAR2,
                                        V_OPERID   IN VARCHAR2,
                                        V_COMPID   IN VARCHAR2) IS
    V_TKTIME  DATE;
    V_ORIGIN  VARCHAR2(8);
    V_SCFRST  VARCHAR2(8);
    V_STATUS  VARCHAR2(4);
    V_CREID   VARCHAR2(32):='gen_ppscpid_data';
  BEGIN
    SELECT MAX(TAKEOVER_TIME),
           MAX(ORIGIN),
           MAX(SKUCOMFIRM_RESULT)
      INTO V_TKTIME, V_ORIGIN, V_SCFRST
      FROM SCMDATA.T_QA_SCOPE
     WHERE QA_SCOPE_ID = V_QASCPID
       AND COMPANY_ID = V_COMPID;

    IF V_ORIGIN = 'SCM' AND V_SCFRST <> 'RT' THEN
      IF V_TKTIME IS NOT NULL THEN
        V_STATUS := 'PD';
      ELSE
        V_STATUS := 'SE';
      END IF;

      IF V_OPERID IS NOT NULL THEN
        V_CREID := V_OPERID;
      END IF;

      INSERT INTO SCMDATA.T_ASNINFO_PRETRANS_TO_WMS
        (INFO_ID, COMPANY_ID, STATUS, PP_QA_SCOPE_ID, CREATE_ID, CREATE_TIME)
      VALUES
        (SCMDATA.F_GET_UUID(), V_COMPID, V_STATUS, V_QASCPID, V_CREID, SYSDATE);
    END IF;
  END P_GEN_ASNPTTOWMS_BY_PPSCPID;



  /*=================================================================================

    【正常使用】根据 QA_REPORT_ID,COMPANY_ID 生成质检确认结果json

    用途:
      通过 QA_REPORT_ID,COMPANY_ID 生成质检确认结果JSON字符串，用于回传至 WMS

    入参:
      V_QAREPID   :  QA质检报告Id
      V_COMPID    :  企业Id

    返回样例:
      {
        "ASN_ID": "ASN20210819160955944289000",
        "COMFIRM_RESULT": "PP",
        "SKU_INFO": [{
          "GOO_ID": "440430",
          "GOODSID": "44043001",
          "SKUCOMFIRM_RESULT": "NP",
          "PACK_INFO": [{
            "PACK_BARCODE": "PB440430010045",
            "SUBS_AMOUNT": 0
          }]
        }, {
          "GOO_ID": "440430",
          "GOODSID": "44043002",
          "SKUCOMFIRM_RESULT": "NP",
          "PACK_INFO": [{
            "PACK_BARCODE": "PB440430020024",
            "SUBS_AMOUNT": 0
          }]
        }, {
          "GOO_ID": "440430",
          "GOODSID": "44043003",
          "SKUCOMFIRM_RESULT": "RT",
          "PACK_INFO": [{
            "PACK_BARCODE": "PB440430030013",
            "SUBS_AMOUNT": 0
          }]
        }]
      }

    版本:
      2021-10-20 : 从 SCMDATA.PKG_QA_LOGIC 迁移至 SCMDATA.PKG_ASN_INTERFACE

  =================================================================================*/
  FUNCTION F_GENERATE_COMFIRMRESULT_JSON_WITH_REP(V_QAREPID    IN VARCHAR2,
                                                  V_COMPID     IN VARCHAR2) RETURN CLOB IS
    /*V_JUGNUM    NUMBER(8);*/
    V_RETCLOB   CLOB;
    V_ASNCLOB   CLOB;
    V_TMPCLOB   CLOB;
  BEGIN
    FOR I IN (SELECT ASN_ID, MAX(QA_REPORT_ID) QA_REPORT_ID, MAX(COMPANY_ID) COMPANY_ID
                FROM (SELECT DISTINCT A.QA_REPORT_ID,A.COMPANY_ID,B.ASN_ID
                        FROM (SELECT QA_REPORT_ID,COMPANY_ID
                                FROM SCMDATA.T_QA_REPORT
                               WHERE QA_REPORT_ID = V_QAREPID
                                 AND COMPANY_ID = V_COMPID
                                 AND INSTR(ORIGIN,'SCM')>0) A
                        INNER JOIN SCMDATA.T_QA_SCOPE B
                           ON A.QA_REPORT_ID = B.QA_REPORT_ID
                          AND A.COMPANY_ID = B.COMPANY_ID)
               GROUP BY ASN_ID) LOOP
      SELECT JSON_OBJECT(ASN_ID, COMFIRM_RESULT)
        INTO V_ASNCLOB
        FROM (SELECT ASN_ID,
                     (CASE
                       WHEN INSTR(SKUCOMFIRM_RESULTS, ';') = 0 AND REPAMT = 1 THEN
                        SKUCOMFIRM_RESULTS
                       ELSE
                        'PP'
                     END) COMFIRM_RESULT
                FROM (SELECT ASN_ID,
                             LISTAGG(DISTINCT NVL(SKUCOMFIRM_RESULT,' '), ';') SKUCOMFIRM_RESULTS,
                             MAX(REPAMT) REPAMT
                        FROM (SELECT ASN_ID,
                                     BARCODE,
                                     COMPANY_ID,
                                     FIRST_VALUE(SKUCOMFIRM_RESULT) OVER(PARTITION BY ASN_ID, BARCODE, COMPANY_ID ORDER BY SKUCOMFIRM_TIME DESC) SKUCOMFIRM_RESULT,
                                     COUNT(DISTINCT QA_REPORT_ID) OVER(PARTITION BY ASN_ID, BARCODE, COMPANY_ID) REPAMT
                                FROM SCMDATA.T_QA_SCOPE TMPSCP
                               WHERE ASN_ID = I.ASN_ID
                                 AND COMPANY_ID = I.COMPANY_ID
                                 AND NOT EXISTS (SELECT 1 FROM SCMDATA.T_QA_REPORT
                                                  WHERE QA_REPORT_ID = TMPSCP.QA_REPORT_ID
                                                    AND COMPANY_ID = TMPSCP.COMPANY_ID
                                                    AND SUBSTR(STATUS,3,3) = 'PED'))
                       GROUP BY ASN_ID));

      SELECT JSON_ARRAYAGG(JSON_OBJECT(GOO_ID,GOODSID,SKUCOMFIRM_RESULT,PACK_INFO RETURNING CLOB) RETURNING CLOB)
        INTO V_TMPCLOB
        FROM (SELECT GOO_ID,GOODSID,SKUCOMFIRM_RESULT,PACK_INFO
                FROM (SELECT X.RELA_GOO_ID GOO_ID, NVL(Y.BARCODE,X.RELA_GOO_ID) GOODSID, Y.SKUCOMFIRM_RESULT,
                     (SELECT JSON_ARRAYAGG(JSON_OBJECT(PACK_BARCODE, SUBS_AMOUNT RETURNING CLOB) RETURNING CLOB)
                        FROM (SELECT ASNPACKS.PACK_BARCODE, NVL(SUBSRELA.SUBS_AMOUNT, 0) SUBS_AMOUNT
                                FROM (SELECT ASN_ID,BARCODE,PACK_BARCODE,COMPANY_ID
                                        FROM SCMDATA.T_ASNORDERPACKS
                                       WHERE GOODSID = NVL(Y.BARCODE,Y.GOO_ID)
                                         AND COMPANY_ID = Y.COMPANY_ID
                                         AND ASN_ID = I.ASN_ID) ASNPACKS
                                LEFT JOIN SCMDATA.T_QA_SUBSRELA SUBSRELA
                                  ON ASNPACKS.ASN_ID = SUBSRELA.ASN_ID
                                 AND ASNPACKS.BARCODE = SUBSRELA.GOODSID
                                 AND ASNPACKS.PACK_BARCODE = SUBSRELA.PACKBARCODE
                                 AND ASNPACKS.COMPANY_ID = SUBSRELA.COMPANY_ID
                                 AND SUBSRELA.QA_SCOPE_ID = Y.QA_SCOPE_ID)) PACK_INFO
                FROM (SELECT QA_SCOPE_ID, GOO_ID, BARCODE, COMPANY_ID, SKUCOMFIRM_RESULT
                        FROM SCMDATA.T_QA_SCOPE
                       WHERE QA_REPORT_ID = I.QA_REPORT_ID
                         AND ASN_ID = I.ASN_ID
                         AND COMPANY_ID = I.COMPANY_ID
                         AND INSTR(ORIGIN,'SCM')>0
                         AND SKUCOMFIRM_RESULT IS NOT NULL
                         AND SKUCOMFIRM_RESULT <> 'RT') Y
                LEFT JOIN SCMDATA.T_COMMODITY_INFO X
                  ON Y.GOO_ID = X.GOO_ID
                 AND Y.COMPANY_ID = X.COMPANY_ID));
      /*SELECT COUNT(BARCODE)
        INTO V_JUGNUM
        FROM SCMDATA.T_QA_SCOPE
       WHERE QA_REPORT_ID = I.QA_REPORT_ID
         AND COMPANY_ID = I.COMPANY_ID
         AND ASN_ID = I.ASN_ID;

      IF V_JUGNUM > 0 THEN
        SELECT JSON_ARRAYAGG(JSON_OBJECT(GOO_ID,GOODSID,SKUCOMFIRM_RESULT,PACK_INFO RETURNING CLOB) RETURNING CLOB)
          INTO V_TMPCLOB
          FROM (SELECT GOO_ID,GOODSID,SKUCOMFIRM_RESULT,PACK_INFO
                  FROM (SELECT X.RELA_GOO_ID GOO_ID, Y.BARCODE GOODSID, Y.SKUCOMFIRM_RESULT,
                       (SELECT JSON_ARRAYAGG(JSON_OBJECT(PACK_BARCODE, SUBS_AMOUNT RETURNING CLOB) RETURNING CLOB)
                          FROM (SELECT ASNPACKS.PACK_BARCODE, NVL(SUBSRELA.SUBS_AMOUNT, 0) SUBS_AMOUNT
                                  FROM (SELECT ASN_ID,BARCODE,PACK_BARCODE,COMPANY_ID
                                          FROM SCMDATA.T_ASNORDERPACKS
                                         WHERE BARCODE = Y.BARCODE
                                           AND COMPANY_ID = Y.COMPANY_ID
                                           AND ASN_ID = I.ASN_ID) ASNPACKS
                                  LEFT JOIN SCMDATA.T_QA_SUBSRELA SUBSRELA
                                    ON ASNPACKS.ASN_ID = SUBSRELA.ASN_ID
                                   AND ASNPACKS.BARCODE = SUBSRELA.GOODSID
                                   AND ASNPACKS.PACK_BARCODE = SUBSRELA.PACKBARCODE
                                   AND ASNPACKS.COMPANY_ID = SUBSRELA.COMPANY_ID
                                   AND SUBSRELA.QA_SCOPE_ID = Y.QA_SCOPE_ID)) PACK_INFO
                  FROM (SELECT QA_SCOPE_ID, GOO_ID, BARCODE, COMPANY_ID, SKUCOMFIRM_RESULT
                          FROM SCMDATA.T_QA_SCOPE
                         WHERE QA_REPORT_ID = I.QA_REPORT_ID
                           AND ASN_ID = I.ASN_ID
                           AND COMPANY_ID = I.COMPANY_ID
                           AND INSTR(ORIGIN,'SCM')>0
                           AND SKUCOMFIRM_RESULT IS NOT NULL
                           AND SKUCOMFIRM_RESULT <> 'RT') Y
                  LEFT JOIN SCMDATA.T_COMMODITY_INFO X
                    ON Y.GOO_ID = X.GOO_ID
                   AND Y.COMPANY_ID = X.COMPANY_ID));
      ELSE
        SELECT JSON_ARRAYAGG(JSON_OBJECT(GOO_ID,GOODSID,SKUCOMFIRM_RESULT,PACK_INFO RETURNING CLOB) RETURNING CLOB)
          INTO V_TMPCLOB
          FROM (SELECT GOO_ID,GOODSID,SKUCOMFIRM_RESULT,PACK_INFO
                  FROM (SELECT X.RELA_GOO_ID GOO_ID, X.RELA_GOO_ID GOODSID, Y.SKUCOMFIRM_RESULT,
                       (SELECT JSON_ARRAYAGG(JSON_OBJECT(PACK_BARCODE, SUBS_AMOUNT RETURNING CLOB) RETURNING CLOB)
                          FROM (SELECT ASNPACKS.PACK_BARCODE, NVL(SUBSRELA.SUBS_AMOUNT, 0) SUBS_AMOUNT
                                  FROM (SELECT ASN_ID,GOO_ID,PACK_BARCODE,COMPANY_ID
                                          FROM SCMDATA.T_ASNORDERPACKS
                                         WHERE GOO_ID = Y.GOO_ID
                                           AND COMPANY_ID = Y.COMPANY_ID
                                           AND ASN_ID = I.ASN_ID) ASNPACKS
                                  LEFT JOIN SCMDATA.T_QA_SUBSRELA SUBSRELA
                                    ON ASNPACKS.ASN_ID = SUBSRELA.ASN_ID
                                   AND ASNPACKS.GOO_ID = SUBSRELA.GOODSID
                                   AND ASNPACKS.PACK_BARCODE = SUBSRELA.PACKBARCODE
                                   AND ASNPACKS.COMPANY_ID = SUBSRELA.COMPANY_ID
                                   AND SUBSRELA.QA_SCOPE_ID = Y.QA_SCOPE_ID)) PACK_INFO
                  FROM (SELECT QA_SCOPE_ID, GOO_ID, BARCODE, COMPANY_ID, SKUCOMFIRM_RESULT
                          FROM SCMDATA.T_QA_SCOPE
                         WHERE QA_REPORT_ID = I.QA_REPORT_ID
                           AND ASN_ID = I.ASN_ID
                           AND COMPANY_ID = I.COMPANY_ID
                           AND INSTR(ORIGIN,'SCM')>0
                           AND SKUCOMFIRM_RESULT IS NOT NULL
                           AND SKUCOMFIRM_RESULT <> 'RT') Y
                  LEFT JOIN SCMDATA.T_COMMODITY_INFO X
                    ON Y.GOO_ID = X.GOO_ID
                   AND Y.COMPANY_ID = X.COMPANY_ID));
      END IF;*/
      IF V_TMPCLOB IS NOT NULL AND V_RETCLOB IS NULL THEN
        V_RETCLOB := SUBSTR(V_ASNCLOB,1,LENGTH(V_ASNCLOB)-1) || ',"SKU_INFO":' || V_TMPCLOB || '}';
      ELSIF V_TMPCLOB IS NOT NULL AND V_RETCLOB IS NOT NULL THEN
        V_RETCLOB := V_RETCLOB||','||SUBSTR(V_ASNCLOB,1,LENGTH(V_ASNCLOB)-1) || ',"SKU_INFO":' || V_TMPCLOB || '}';
      END IF;
    END LOOP;
    RETURN V_RETCLOB;
  END F_GENERATE_COMFIRMRESULT_JSON_WITH_REP;



  /*=================================================================================

    【停用】根据 QA_SCOPE_IDS,COMPANY_ID 生成质检确认结果json

    用途:
      通过 QA_SCOPE_IDS,COMPANY_ID 生成质检确认结果JSON字符串，用于回传至 WMS

    入参:
      V_QASCOPEID  :  QA质检明细Id
      V_COMPID     :  企业Id

    返回样例:
      {
        "ASN_ID": "ASN20210819160955944289000",
        "COMFIRM_RESULT": "PP",
        "SKU_INFO": [{
          "GOO_ID": "440430",
          "GOODSID": "44043001",
          "SKUCOMFIRM_RESULT": "NP",
          "PACK_INFO": [{
            "PACK_BARCODE": "PB440430010045",
            "SUBS_AMOUNT": 0
          }]
        }]
      }

    版本:
      2021-10-20 : 从 SCMDATA.PKG_QA_LOGIC 迁移至 SCMDATA.PKG_ASN_INTERFACE
      2021-11-25 : WMS 要求按照 ASN 单号进行合并，故停用

  =================================================================================*/
  FUNCTION F_GENERATE_COMFIRMRESULT_JSON_WITH_SCOPE(V_QASCOPEID IN VARCHAR2,
                                                    V_COMPID    IN VARCHAR2) RETURN CLOB IS
    V_RETCLOB   CLOB;
    V_ASNCLOB   CLOB;
    V_TMPCLOB   CLOB;
  BEGIN
    FOR I IN (SELECT ASN_ID,GOO_ID,BARCODE,MAX(QA_REPORT_ID) QA_REPORT_ID, MAX(COMPANY_ID) COMPANY_ID
                FROM (SELECT DISTINCT QA_REPORT_ID,COMPANY_ID,ASN_ID,GOO_ID,BARCODE
                        FROM SCMDATA.T_QA_SCOPE
                       WHERE QA_SCOPE_ID = V_QASCOPEID
                         AND COMPANY_ID = V_COMPID
                         AND INSTR(ORIGIN,'SCM')>0)
               GROUP BY ASN_ID,GOO_ID,BARCODE) LOOP

      SELECT JSON_OBJECT(ASN_ID, COMFIRM_RESULT)
        INTO V_ASNCLOB
        FROM (SELECT ASN_ID,
                     (CASE
                       WHEN INSTR(SKUCOMFIRM_RESULTS, ';') = 0 AND REPAMT = 1 THEN
                        SKUCOMFIRM_RESULTS
                       ELSE
                        'PP'
                     END) COMFIRM_RESULT
                FROM (SELECT ASN_ID,
                             LISTAGG(DISTINCT NVL(SKUCOMFIRM_RESULT,' '), ';') SKUCOMFIRM_RESULTS,
                             MAX(REPAMT) REPAMT
                        FROM (SELECT ASN_ID,
                                     BARCODE,
                                     COMPANY_ID,
                                     FIRST_VALUE(SKUCOMFIRM_RESULT) OVER(PARTITION BY ASN_ID, BARCODE, COMPANY_ID ORDER BY SKUCOMFIRM_TIME DESC) SKUCOMFIRM_RESULT,
                                     COUNT(DISTINCT QA_REPORT_ID) OVER(PARTITION BY ASN_ID, BARCODE, COMPANY_ID) REPAMT
                                FROM SCMDATA.T_QA_SCOPE TMPSCP
                               WHERE ASN_ID = I.ASN_ID
                                 AND COMPANY_ID = I.COMPANY_ID
                                 AND NOT EXISTS (SELECT 1 FROM SCMDATA.T_QA_REPORT
                                                  WHERE QA_REPORT_ID = TMPSCP.QA_REPORT_ID
                                                    AND COMPANY_ID = TMPSCP.COMPANY_ID
                                                    AND SUBSTR(STATUS,3,3) = 'PED'))
                       GROUP BY ASN_ID));

      SELECT JSON_ARRAYAGG(JSON_OBJECT(GOO_ID,GOODSID,SKUCOMFIRM_RESULT,PACK_INFO RETURNING CLOB) RETURNING CLOB)
        INTO V_TMPCLOB
        FROM (SELECT X.RELA_GOO_ID GOO_ID, NVL(Y.BARCODE, X.RELA_GOO_ID) GOODSID, Y.SKUCOMFIRM_RESULT,
                     (SELECT JSON_ARRAYAGG(JSON_OBJECT(PACK_BARCODE, SUBS_AMOUNT RETURNING CLOB) RETURNING CLOB)
                        FROM (SELECT ASNPACKS.PACK_BARCODE, NVL(SUBSRELA.SUBS_AMOUNT, 0) SUBS_AMOUNT
                                FROM (SELECT ASN_ID,BARCODE,PACK_BARCODE,COMPANY_ID
                                        FROM SCMDATA.T_ASNORDERPACKS
                                       WHERE GOODSID = NVL(Y.BARCODE,Y.GOO_ID)
                                         AND COMPANY_ID = Y.COMPANY_ID
                                         AND ASN_ID = I.ASN_ID) ASNPACKS
                                LEFT JOIN SCMDATA.T_QA_SUBSRELA SUBSRELA
                                  ON ASNPACKS.ASN_ID = SUBSRELA.ASN_ID
                                 AND ASNPACKS.BARCODE = SUBSRELA.GOODSID
                                 AND ASNPACKS.PACK_BARCODE = SUBSRELA.PACKBARCODE
                                 AND ASNPACKS.COMPANY_ID = SUBSRELA.COMPANY_ID
                                 AND SUBSRELA.QA_SCOPE_ID = Y.QA_SCOPE_ID)) PACK_INFO
                FROM (SELECT QA_SCOPE_ID, GOO_ID, BARCODE, COMPANY_ID, SKUCOMFIRM_RESULT
                        FROM SCMDATA.T_QA_SCOPE
                       WHERE QA_SCOPE_ID = V_QASCOPEID
                         AND ASN_ID = I.ASN_ID
                         AND COMPANY_ID = I.COMPANY_ID
                         AND INSTR(ORIGIN,'SCM')>0
                         AND SKUCOMFIRM_RESULT IS NOT NULL
                         AND SKUCOMFIRM_RESULT <> 'RT') Y
                LEFT JOIN SCMDATA.T_COMMODITY_INFO X
                  ON Y.GOO_ID = X.GOO_ID
                 AND Y.COMPANY_ID = X.COMPANY_ID);


      /*IF I.BARCODE IS NOT NULL THEN
        SELECT JSON_ARRAYAGG(JSON_OBJECT(GOO_ID,GOODSID,SKUCOMFIRM_RESULT,PACK_INFO RETURNING CLOB) RETURNING CLOB)
          INTO V_TMPCLOB
          FROM (SELECT X.RELA_GOO_ID GOO_ID, Y.BARCODE GOODSID, Y.SKUCOMFIRM_RESULT,
                       (SELECT JSON_ARRAYAGG(JSON_OBJECT(PACK_BARCODE, SUBS_AMOUNT RETURNING CLOB) RETURNING CLOB)
                          FROM (SELECT ASNPACKS.PACK_BARCODE, NVL(SUBSRELA.SUBS_AMOUNT, 0) SUBS_AMOUNT
                                  FROM (SELECT ASN_ID,BARCODE,PACK_BARCODE,COMPANY_ID
                                          FROM SCMDATA.T_ASNORDERPACKS
                                         WHERE BARCODE = Y.BARCODE
                                           AND COMPANY_ID = Y.COMPANY_ID
                                           AND ASN_ID = I.ASN_ID) ASNPACKS
                                  LEFT JOIN SCMDATA.T_QA_SUBSRELA SUBSRELA
                                    ON ASNPACKS.ASN_ID = SUBSRELA.ASN_ID
                                   AND ASNPACKS.BARCODE = SUBSRELA.GOODSID
                                   AND ASNPACKS.PACK_BARCODE = SUBSRELA.PACKBARCODE
                                   AND ASNPACKS.COMPANY_ID = SUBSRELA.COMPANY_ID
                                   AND SUBSRELA.QA_SCOPE_ID = Y.QA_SCOPE_ID)) PACK_INFO
                  FROM (SELECT QA_SCOPE_ID, GOO_ID, BARCODE, COMPANY_ID, SKUCOMFIRM_RESULT
                          FROM SCMDATA.T_QA_SCOPE
                         WHERE QA_SCOPE_ID = V_QASCOPEID
                           AND ASN_ID = I.ASN_ID
                           AND COMPANY_ID = I.COMPANY_ID
                           AND INSTR(ORIGIN,'SCM')>0
                           AND SKUCOMFIRM_RESULT IS NOT NULL
                           AND SKUCOMFIRM_RESULT <> 'RT') Y
                  LEFT JOIN SCMDATA.T_COMMODITY_INFO X
                    ON Y.GOO_ID = X.GOO_ID
                   AND Y.COMPANY_ID = X.COMPANY_ID);
      ELSE
        SELECT JSON_ARRAYAGG(JSON_OBJECT(GOO_ID,GOODSID,SKUCOMFIRM_RESULT,PACK_INFO RETURNING CLOB) RETURNING CLOB)
          INTO V_TMPCLOB
          FROM (SELECT X.RELA_GOO_ID GOO_ID, X.RELA_GOO_ID GOODSID, Y.SKUCOMFIRM_RESULT,
                       (SELECT JSON_ARRAYAGG(JSON_OBJECT(PACK_BARCODE, SUBS_AMOUNT RETURNING CLOB) RETURNING CLOB)
                          FROM (SELECT ASNPACKS.PACK_BARCODE, NVL(SUBSRELA.SUBS_AMOUNT, 0) SUBS_AMOUNT
                                  FROM (SELECT ASN_ID,GOO_ID,PACK_BARCODE,COMPANY_ID
                                          FROM SCMDATA.T_ASNORDERPACKS
                                         WHERE GOO_ID = Y.GOO_ID
                                           AND COMPANY_ID = Y.COMPANY_ID
                                           AND ASN_ID = I.ASN_ID) ASNPACKS
                                  LEFT JOIN SCMDATA.T_QA_SUBSRELA SUBSRELA
                                    ON ASNPACKS.ASN_ID = SUBSRELA.ASN_ID
                                   AND ASNPACKS.GOO_ID = SUBSRELA.GOODSID
                                   AND ASNPACKS.PACK_BARCODE = SUBSRELA.PACKBARCODE
                                   AND ASNPACKS.COMPANY_ID = SUBSRELA.COMPANY_ID
                                   AND SUBSRELA.QA_SCOPE_ID = Y.QA_SCOPE_ID)) PACK_INFO
                  FROM (SELECT QA_SCOPE_ID, GOO_ID, BARCODE, COMPANY_ID, SKUCOMFIRM_RESULT
                          FROM SCMDATA.T_QA_SCOPE
                         WHERE QA_SCOPE_ID = V_QASCOPEID
                           AND ASN_ID = I.ASN_ID
                           AND COMPANY_ID = I.COMPANY_ID
                           AND INSTR(ORIGIN,'SCM')>0
                           AND SKUCOMFIRM_RESULT IS NOT NULL
                           AND SKUCOMFIRM_RESULT <> 'RT') Y
                  LEFT JOIN SCMDATA.T_COMMODITY_INFO X
                    ON Y.GOO_ID = X.GOO_ID
                   AND Y.COMPANY_ID = X.COMPANY_ID);
      END IF;*/
      IF V_TMPCLOB IS NOT NULL AND V_RETCLOB IS NULL THEN
        V_RETCLOB := SUBSTR(V_ASNCLOB,1,LENGTH(V_ASNCLOB)-1) || ',"SKU_INFO":' || V_TMPCLOB || '}';
      ELSIF V_TMPCLOB IS NOT NULL AND V_RETCLOB IS NOT NULL THEN
        V_RETCLOB := V_RETCLOB||','||SUBSTR(V_ASNCLOB,1,LENGTH(V_ASNCLOB)-1) || ',"SKU_INFO":' || V_TMPCLOB || '}';
      END IF;
    END LOOP;
    RETURN V_RETCLOB;
  END F_GENERATE_COMFIRMRESULT_JSON_WITH_SCOPE;



  /*=================================================================================

    【正常使用】用于生成传入多个 QA_SCOPE_ID 的质检结果 JSON，
                质检结果 JSON 内部按 ASN_ID 合并

    用途:
      用于生成传入多个 QA_SCOPE_ID 的质检结果 JSON

    入参:
      V_QASCOPEIDS :  QA质检范围Id，多值，用逗号分隔
      V_COMPID     :  企业Id

    版本:
      2021-11-25 : 用于生成传入多个 QA_SCOPE_ID 的质检结果 JSON

  =================================================================================*/
  FUNCTION F_GEN_COMFIRMJSON_BYSCPIDS_CBASN(V_QASCOPEIDS  IN VARCHAR2,
                                            V_COMPID      IN VARCHAR2) RETURN CLOB IS
    V_RETCLOB   CLOB;
    V_ASNCLOB   CLOB;
    V_TMPCLOB   CLOB;
  BEGIN
    FOR I IN (SELECT ASN_ID,COMPANY_ID,
                     MAX(QA_REPORT_ID) QA_REPORT_ID,
                     LISTAGG(DISTINCT QA_SCOPE_ID,',') QA_SCOPE_IDS,
                     LISTAGG(DISTINCT BARCODE,',') BARCODES
                FROM (SELECT DISTINCT QA_REPORT_ID, COMPANY_ID, ASN_ID, GOO_ID, BARCODE, QA_SCOPE_ID
                        FROM SCMDATA.T_QA_SCOPE
                       WHERE INSTR(',' || V_QASCOPEIDS || ',', ',' || QA_SCOPE_ID || ',') > 0
                         AND COMPANY_ID = V_COMPID
                         AND INSTR(ORIGIN, 'SCM') > 0)
               GROUP BY ASN_ID, COMPANY_ID) LOOP
      SELECT JSON_OBJECT(ASN_ID, COMFIRM_RESULT)
        INTO V_ASNCLOB
        FROM (SELECT ASN_ID,
                     (CASE
                       WHEN INSTR(SKUCOMFIRM_RESULTS, ';') = 0 AND REPAMT = 1 THEN
                        SKUCOMFIRM_RESULTS
                       ELSE
                        'PP'
                     END) COMFIRM_RESULT
                FROM (SELECT ASN_ID,
                             LISTAGG(DISTINCT NVL(SKUCOMFIRM_RESULT,' '), ';') SKUCOMFIRM_RESULTS,
                             MAX(REPAMT) REPAMT
                        FROM (SELECT ASN_ID,
                                     BARCODE,
                                     COMPANY_ID,
                                     FIRST_VALUE(SKUCOMFIRM_RESULT) OVER(PARTITION BY ASN_ID, BARCODE, COMPANY_ID ORDER BY SKUCOMFIRM_TIME DESC) SKUCOMFIRM_RESULT,
                                     COUNT(DISTINCT QA_REPORT_ID) OVER(PARTITION BY ASN_ID, BARCODE, COMPANY_ID) REPAMT
                                FROM SCMDATA.T_QA_SCOPE TMPSCP
                               WHERE ASN_ID = I.ASN_ID
                                 AND COMPANY_ID = I.COMPANY_ID
                                 AND NOT EXISTS (SELECT 1 FROM SCMDATA.T_QA_REPORT
                                                  WHERE QA_REPORT_ID = TMPSCP.QA_REPORT_ID
                                                    AND COMPANY_ID = TMPSCP.COMPANY_ID
                                                    AND SUBSTR(STATUS,3,3) = 'PED'))
                       GROUP BY ASN_ID));

      SELECT JSON_ARRAYAGG(JSON_OBJECT(GOO_ID,GOODSID,SKUCOMFIRM_RESULT,PACK_INFO RETURNING CLOB) RETURNING CLOB)
        INTO V_TMPCLOB
        FROM (SELECT X.RELA_GOO_ID GOO_ID, NVL(Y.BARCODE, X.RELA_GOO_ID) GOODSID, Y.SKUCOMFIRM_RESULT,
                     (SELECT JSON_ARRAYAGG(JSON_OBJECT(PACK_BARCODE, SUBS_AMOUNT RETURNING CLOB) RETURNING CLOB)
                        FROM (SELECT ASNPACKS.PACK_BARCODE, NVL(SUBSRELA.SUBS_AMOUNT, 0) SUBS_AMOUNT
                                FROM (SELECT ASN_ID,BARCODE,PACK_BARCODE,COMPANY_ID
                                        FROM SCMDATA.T_ASNORDERPACKS
                                       WHERE GOODSID = NVL(Y.BARCODE,Y.GOO_ID)
                                         AND COMPANY_ID = Y.COMPANY_ID
                                         AND ASN_ID = I.ASN_ID) ASNPACKS
                                LEFT JOIN SCMDATA.T_QA_SUBSRELA SUBSRELA
                                  ON ASNPACKS.ASN_ID = SUBSRELA.ASN_ID
                                 AND ASNPACKS.BARCODE = SUBSRELA.GOODSID
                                 AND ASNPACKS.PACK_BARCODE = SUBSRELA.PACKBARCODE
                                 AND ASNPACKS.COMPANY_ID = SUBSRELA.COMPANY_ID
                                 AND SUBSRELA.QA_SCOPE_ID = Y.QA_SCOPE_ID)) PACK_INFO
                FROM (SELECT QA_SCOPE_ID, GOO_ID, BARCODE, COMPANY_ID, SKUCOMFIRM_RESULT
                        FROM SCMDATA.T_QA_SCOPE
                       WHERE INSTR(','||I.QA_SCOPE_IDS||',', ','||QA_SCOPE_ID||',')>0
                         AND ASN_ID = I.ASN_ID
                         AND COMPANY_ID = I.COMPANY_ID
                         AND INSTR(ORIGIN,'SCM')>0
                         AND SKUCOMFIRM_RESULT IS NOT NULL
                         AND SKUCOMFIRM_RESULT <> 'RT') Y
                LEFT JOIN SCMDATA.T_COMMODITY_INFO X
                  ON Y.GOO_ID = X.GOO_ID
                 AND Y.COMPANY_ID = X.COMPANY_ID);

      /*IF I.BARCODES IS NOT NULL THEN
        SELECT JSON_ARRAYAGG(JSON_OBJECT(GOO_ID,GOODSID,SKUCOMFIRM_RESULT,PACK_INFO RETURNING CLOB) RETURNING CLOB)
          INTO V_TMPCLOB
          FROM (SELECT X.RELA_GOO_ID GOO_ID, Y.BARCODE GOODSID, Y.SKUCOMFIRM_RESULT,
                       (SELECT JSON_ARRAYAGG(JSON_OBJECT(PACK_BARCODE, SUBS_AMOUNT RETURNING CLOB) RETURNING CLOB)
                          FROM (SELECT ASNPACKS.PACK_BARCODE, NVL(SUBSRELA.SUBS_AMOUNT, 0) SUBS_AMOUNT
                                  FROM (SELECT ASN_ID,BARCODE,PACK_BARCODE,COMPANY_ID
                                          FROM SCMDATA.T_ASNORDERPACKS
                                         WHERE BARCODE = Y.BARCODE
                                           AND COMPANY_ID = Y.COMPANY_ID
                                           AND ASN_ID = I.ASN_ID) ASNPACKS
                                  LEFT JOIN SCMDATA.T_QA_SUBSRELA SUBSRELA
                                    ON ASNPACKS.ASN_ID = SUBSRELA.ASN_ID
                                   AND ASNPACKS.BARCODE = SUBSRELA.GOODSID
                                   AND ASNPACKS.PACK_BARCODE = SUBSRELA.PACKBARCODE
                                   AND ASNPACKS.COMPANY_ID = SUBSRELA.COMPANY_ID
                                   AND SUBSRELA.QA_SCOPE_ID = Y.QA_SCOPE_ID)) PACK_INFO
                  FROM (SELECT QA_SCOPE_ID, GOO_ID, BARCODE, COMPANY_ID, SKUCOMFIRM_RESULT
                          FROM SCMDATA.T_QA_SCOPE
                         WHERE INSTR(','||I.QA_SCOPE_IDS||',', ','||QA_SCOPE_ID||',')>0
                           AND ASN_ID = I.ASN_ID
                           AND COMPANY_ID = I.COMPANY_ID
                           AND INSTR(ORIGIN,'SCM')>0
                           AND SKUCOMFIRM_RESULT IS NOT NULL
                           AND SKUCOMFIRM_RESULT <> 'RT') Y
                  LEFT JOIN SCMDATA.T_COMMODITY_INFO X
                    ON Y.GOO_ID = X.GOO_ID
                   AND Y.COMPANY_ID = X.COMPANY_ID);
      ELSE
        SELECT JSON_ARRAYAGG(JSON_OBJECT(GOO_ID,GOODSID,SKUCOMFIRM_RESULT,PACK_INFO RETURNING CLOB) RETURNING CLOB)
          INTO V_TMPCLOB
          FROM (SELECT X.RELA_GOO_ID GOO_ID, X.RELA_GOO_ID GOODSID, Y.SKUCOMFIRM_RESULT,
                       (SELECT JSON_ARRAYAGG(JSON_OBJECT(PACK_BARCODE, SUBS_AMOUNT RETURNING CLOB) RETURNING CLOB)
                          FROM (SELECT ASNPACKS.PACK_BARCODE, NVL(SUBSRELA.SUBS_AMOUNT, 0) SUBS_AMOUNT
                                  FROM (SELECT ASN_ID,GOO_ID,PACK_BARCODE,COMPANY_ID
                                          FROM SCMDATA.T_ASNORDERPACKS
                                         WHERE GOO_ID = Y.GOO_ID
                                           AND COMPANY_ID = Y.COMPANY_ID
                                           AND ASN_ID = I.ASN_ID) ASNPACKS
                                  LEFT JOIN SCMDATA.T_QA_SUBSRELA SUBSRELA
                                    ON ASNPACKS.ASN_ID = SUBSRELA.ASN_ID
                                   AND ASNPACKS.GOO_ID = SUBSRELA.GOODSID
                                   AND ASNPACKS.PACK_BARCODE = SUBSRELA.PACKBARCODE
                                   AND ASNPACKS.COMPANY_ID = SUBSRELA.COMPANY_ID
                                   AND SUBSRELA.QA_SCOPE_ID = Y.QA_SCOPE_ID)) PACK_INFO
                  FROM (SELECT QA_SCOPE_ID, GOO_ID, BARCODE, COMPANY_ID, SKUCOMFIRM_RESULT
                          FROM SCMDATA.T_QA_SCOPE
                         WHERE INSTR(','||I.QA_SCOPE_IDS||',', ','||QA_SCOPE_ID||',')>0
                           AND ASN_ID = I.ASN_ID
                           AND COMPANY_ID = I.COMPANY_ID
                           AND INSTR(ORIGIN,'SCM')>0
                           AND SKUCOMFIRM_RESULT IS NOT NULL
                           AND SKUCOMFIRM_RESULT <> 'RT') Y
                  LEFT JOIN SCMDATA.T_COMMODITY_INFO X
                    ON Y.GOO_ID = X.GOO_ID
                   AND Y.COMPANY_ID = X.COMPANY_ID);
      END IF;*/
      IF V_TMPCLOB IS NOT NULL AND V_RETCLOB IS NULL THEN
        V_RETCLOB := SUBSTR(V_ASNCLOB,1,LENGTH(V_ASNCLOB)-1) || ',"SKU_INFO":' || V_TMPCLOB || '}';
      ELSIF V_TMPCLOB IS NOT NULL AND V_RETCLOB IS NOT NULL THEN
        V_RETCLOB := V_RETCLOB||','||SUBSTR(V_ASNCLOB,1,LENGTH(V_ASNCLOB)-1) || ',"SKU_INFO":' || V_TMPCLOB || '}';
      END IF;
    END LOOP;
    RETURN V_RETCLOB;
  END F_GEN_COMFIRMJSON_BYSCPIDS_CBASN;


  /*=================================================================================

    【正常使用】通过 QA_SCOPE_ID 生成 T_QUALRESULT_TO_WMS 预回传信息

    版本:
      2022-03-26 : 通过 QA_REPORT_ID 生成 T_QUALRESULT_TO_WMS 预回传信息

  =================================================================================*/
  FUNCTION F_GEN_CFJSON_BY_SCOPE RETURN CLOB IS
    PRAGMA AUTONOMOUS_TRANSACTION;
    V_RETCLOB CLOB;
    V_ASNCLOB CLOB;
    V_TMPCLOB CLOB;
  BEGIN
    FOR I IN (SELECT ASN_ID,COMPANY_ID,QA_REPORT_ID
                FROM (SELECT B.ASN_ID, B.COMPANY_ID, B.QA_REPORT_ID,
                             MAX(CASE WHEN C.RECEIVE_TIME IS NULL THEN 1 ELSE 0 END) ASNS_RECTIMENULL,
                             COUNT(CASE WHEN D.ASN_ID IS NOT NULL THEN 1 ELSE 0 END) ASNITEM_NUM,
                             MAX(CASE WHEN D.RECEIVE_TIME IS NULL THEN 1 ELSE 0 END) ASNITEM_RECTIMENULL,
                             MAX(NVL(D.CREATE_TIME,C.CREATE_TIME)) CREATE_TIME
                        FROM SCMDATA.T_ASNINFO_PRETRANS_TO_WMS A
                       INNER JOIN SCMDATA.T_QA_SCOPE B
                          ON A.QA_SCOPE_ID = B.QA_SCOPE_ID
                         AND A.COMPANY_ID = B.COMPANY_ID
                        LEFT JOIN SCMDATA.T_ASNORDERS_ITF C
                          ON B.ASN_ID = C.ASN_ID
                         AND B.COMPANY_ID = C.COMPANY_ID
                        LEFT JOIN SCMDATA.T_ASNORDERSITEM_ITF D
                          ON B.ASN_ID = D.ASN_ID
                         AND NVL(D.WAREHOUSE_POS,' ') <> ' '
                         AND B.COMPANY_ID = D.COMPANY_ID
                       WHERE A.QA_SCOPE_ID IS NOT NULL
                         AND B.IS_QUALITY = 0
                         AND B.ORIGIN = 'SCM'
                         AND A.STATUS = 'PD'
                         AND EXISTS (SELECT 1 FROM SCMDATA.T_QA_REPORT
                                      WHERE QA_REPORT_ID = B.QA_REPORT_ID
                                        AND COMPANY_ID = B.COMPANY_ID
                                        AND STATUS IN ('N_ACF','R_ACF'))
               GROUP BY B.ASN_ID, B.COMPANY_ID, B.QA_REPORT_ID)
               WHERE (ASNS_RECTIMENULL = 0 AND ASNITEM_NUM = 0)
                  OR (ASNITEM_NUM > 0 AND ASNITEM_RECTIMENULL = 0)
               ORDER BY CREATE_TIME
               FETCH FIRST 10 ROWS ONLY) LOOP
      SELECT JSON_OBJECT(ASN_ID, COMFIRM_RESULT)
        INTO V_ASNCLOB
        FROM (SELECT ASN_ID, SKUCOMFIRM_RESULT COMFIRM_RESULT
          FROM (SELECT ASN_ID,
                       MAX(SKUCOMFIRM_RESULT) SKUCOMFIRM_RESULT,
                       MAX(ITEMCN) ITEMCN,
                       COUNT(DISTINCT BARCODE) SCPCN
                  FROM (SELECT ASN_ID,
                               BARCODE,
                               COMPANY_ID,
                               FIRST_VALUE(SKUCOMFIRM_RESULT) OVER(PARTITION BY ASN_ID, BARCODE, COMPANY_ID ORDER BY SKUCOMFIRM_TIME DESC) SKUCOMFIRM_RESULT,
                               (SELECT COUNT(BARCODE) FROM SCMDATA.T_ASNORDERSITEM_ITF WHERE ASN_ID = TMPSCP.ASN_ID AND COMPANY_ID = TMPSCP.COMPANY_ID AND NVL(WAREHOUSE_POS,' ') <> ' ') ITEMCN
                                FROM SCMDATA.T_QA_SCOPE TMPSCP
                               WHERE ASN_ID = I.ASN_ID
                                 AND ORIGIN = 'SCM'
                                 AND COMPANY_ID = I.COMPANY_ID
                                 AND EXISTS
                               (SELECT 1
                                        FROM SCMDATA.T_QA_REPORT
                                       WHERE QA_REPORT_ID = TMPSCP.QA_REPORT_ID
                                         AND COMPANY_ID = TMPSCP.COMPANY_ID
                                         AND STATUS IN ('N_ACF','R_ACF')))
                       GROUP BY ASN_ID));

      FOR X IN (SELECT DISTINCT TASNS.ASN_ID,
                                TASNS.COMPANY_ID,
                                TCI.GOO_ID,
                                TASNS.RECEIVE_TIME     SRECTIME,
                                TASNSITEM.BARCODE,
                                TASNSITEM.RECEIVE_TIME IRECTIME
                  FROM SCMDATA.T_ASNORDERS_ITF TASNS
                 INNER JOIN SCMDATA.T_COMMODITY_INFO TCI
                    ON TASNS.GOO_ID = TCI.RELA_GOO_ID
                   AND TASNS.COMPANY_ID = TCI.COMPANY_ID
                  LEFT JOIN SCMDATA.T_ASNORDERSITEM_ITF TASNSITEM
                    ON TASNS.ASN_ID = TASNSITEM.ASN_ID
                   AND NVL(TASNSITEM.WAREHOUSE_POS,' ') <> ' '
                   AND TASNS.COMPANY_ID = TASNSITEM.COMPANY_ID
                 WHERE TASNS.ASN_ID = I.ASN_ID
                   AND TASNS.COMPANY_ID = I.COMPANY_ID) LOOP
        IF X.BARCODE IS NOT NULL THEN
          UPDATE SCMDATA.T_QA_SCOPE
             SET TAKEOVER_TIME = X.IRECTIME
           WHERE ASN_ID = X.ASN_ID
             AND GOO_ID = X.GOO_ID
             AND BARCODE = X.BARCODE
             AND COMPANY_ID = X.COMPANY_ID;
        ELSE
          UPDATE SCMDATA.T_QA_SCOPE
             SET TAKEOVER_TIME = X.SRECTIME
           WHERE ASN_ID = X.ASN_ID
             AND GOO_ID = X.GOO_ID
             AND BARCODE IS NULL
             AND COMPANY_ID = X.COMPANY_ID;
        END IF;
      END LOOP;

      SELECT JSON_ARRAYAGG(JSON_OBJECT(GOO_ID,
                                       GOODSID,
                                       SKUCOMFIRM_RESULT,
                                       PACK_INFO RETURNING CLOB) RETURNING CLOB)
        INTO V_TMPCLOB
        FROM (SELECT X.RELA_GOO_ID GOO_ID,
                     NVL(Y.BARCODE, X.RELA_GOO_ID) GOODSID,
                     Y.SKUCOMFIRM_RESULT,
                     (SELECT JSON_ARRAYAGG(JSON_OBJECT(PACK_BARCODE,
                                                       SUBS_AMOUNT RETURNING CLOB)
                                           RETURNING CLOB)
                        FROM (SELECT ASNPACKS.PACK_BARCODE,
                                     NVL(SUBSRELA.SUBS_AMOUNT, 0) SUBS_AMOUNT
                                FROM (SELECT ASN_ID,
                                             BARCODE,
                                             PACK_BARCODE,
                                             COMPANY_ID
                                        FROM SCMDATA.T_ASNORDERPACKS
                                       WHERE GOODSID = NVL(Y.BARCODE, Y.GOO_ID)
                                         AND COMPANY_ID = Y.COMPANY_ID
                                         AND ASN_ID = I.ASN_ID) ASNPACKS
                                LEFT JOIN SCMDATA.T_QA_SUBSRELA SUBSRELA
                                  ON ASNPACKS.ASN_ID = SUBSRELA.ASN_ID
                                 AND ASNPACKS.BARCODE = SUBSRELA.GOODSID
                                 AND ASNPACKS.PACK_BARCODE =
                                     SUBSRELA.PACKBARCODE
                                 AND ASNPACKS.COMPANY_ID = SUBSRELA.COMPANY_ID
                                 AND SUBSRELA.QA_SCOPE_ID = Y.QA_SCOPE_ID)) PACK_INFO
                FROM (SELECT QA_SCOPE_ID,
                             GOO_ID,
                             BARCODE,
                             COMPANY_ID,
                             SKUCOMFIRM_RESULT
                        FROM SCMDATA.T_QA_SCOPE TSCP
                       WHERE QA_REPORT_ID = I.QA_REPORT_ID
                         AND ASN_ID = I.ASN_ID
                         AND COMPANY_ID = I.COMPANY_ID
                         AND ORIGIN = 'SCM'
                         AND SKUCOMFIRM_RESULT IS NOT NULL
                         AND TAKEOVER_TIME IS NOT NULL
                         AND SKUCOMFIRM_RESULT <> 'RT'
                         AND IS_QUALITY = 0) Y
                LEFT JOIN SCMDATA.T_COMMODITY_INFO X
                  ON Y.GOO_ID = X.GOO_ID
                 AND Y.COMPANY_ID = X.COMPANY_ID);

      IF V_TMPCLOB IS NOT NULL AND V_RETCLOB IS NULL THEN
        V_RETCLOB := SUBSTR(V_ASNCLOB, 1, LENGTH(V_ASNCLOB) - 1) ||
                     ',"SKU_INFO":' || V_TMPCLOB || '}';
      ELSIF V_TMPCLOB IS NOT NULL AND V_RETCLOB IS NOT NULL THEN
        V_RETCLOB := V_RETCLOB || ',' ||
                     SUBSTR(V_ASNCLOB, 1, LENGTH(V_ASNCLOB) - 1) ||
                     ',"SKU_INFO":' || V_TMPCLOB || '}';
      END IF;

      UPDATE SCMDATA.T_ASNINFO_PRETRANS_TO_WMS
         SET STATUS = 'FD',
             ERR_INFO =  '{ "portBody" : [' || LTRIM(V_RETCLOB, ',') || ']}',
             LASTUPD_ID = 'cfjson_by_scope',
             LASTUPD_TIME = SYSDATE
       WHERE STATUS = 'PD'
         AND (QA_SCOPE_ID, COMPANY_ID) IN
             (SELECT QA_SCOPE_ID, COMPANY_ID
                FROM SCMDATA.T_QA_SCOPE
               WHERE QA_REPORT_ID = I.QA_REPORT_ID
                 AND COMPANY_ID = I.COMPANY_ID
                 AND ORIGIN = 'SCM'
                 AND IS_QUALITY = 0
                 AND SKUCOMFIRM_RESULT <> 'RT'
                 AND TAKEOVER_TIME IS NOT NULL);
    END LOOP;
    COMMIT;

    V_RETCLOB := '{ "portBody" : [' || LTRIM(V_RETCLOB, ',') || ']}';

    RETURN V_RETCLOB;
  END F_GEN_CFJSON_BY_SCOPE;



  /*=================================================================================

    【正常使用】将质检确认结果为“部分通过”的SKU质检确认结果回传给wms

    版本:
      2022-03-30 : 将质检确认结果为“部分通过”的SKU质检确认结果回传给wms

  =================================================================================*/
  FUNCTION F_GEN_CFJSON_BY_PPSCOPE RETURN CLOB IS
    PRAGMA AUTONOMOUS_TRANSACTION;
    V_RETCLOB CLOB;
    V_ASNCLOB CLOB;
    V_TMPCLOB CLOB;
  BEGIN
    FOR I IN (SELECT DISTINCT B.ASN_ID, B.COMPANY_ID
                FROM SCMDATA.T_ASNINFO_PRETRANS_TO_WMS A
               INNER JOIN SCMDATA.T_QA_SCOPE B
                  ON A.PP_QA_SCOPE_ID = B.QA_SCOPE_ID
                 AND A.COMPANY_ID = B.COMPANY_ID
                 AND B.IS_QUALITY = 0
               INNER JOIN SCMDATA.T_COMMODITY_INFO C
                  ON B.GOO_ID = C.GOO_ID
                 AND B.COMPANY_ID = C.COMPANY_ID
               WHERE A.PP_QA_SCOPE_ID IS NOT NULL
                 AND B.ORIGIN = 'SCM'
                 AND A.STATUS = 'PD'
                 AND B.TAKEOVER_TIME IS NOT NULL
                 AND B.SKUCOMFIRM_RESULT <> 'RT'
                 AND EXISTS (SELECT 1
                        FROM SCMDATA.T_QA_REPORT
                       WHERE QA_REPORT_ID = B.QA_REPORT_ID
                         AND COMPANY_ID = B.COMPANY_ID
                         AND STATUS NOT IN ('N_PED','R_PED'))
               GROUP BY B.ASN_ID, B.COMPANY_ID
               ORDER BY MAX(A.CREATE_TIME)
               FETCH FIRST 10 ROWS ONLY) LOOP
      SELECT JSON_OBJECT(ASN_ID, COMFIRM_RESULT)
        INTO V_ASNCLOB
        FROM (SELECT ASN_ID,
               (CASE
                 WHEN INSTR(SKUCOMFIRM_RESULTS, ';') = 0 AND ITEMCN = SCPCN THEN
                  SKUCOMFIRM_RESULTS
                 ELSE
                  'PP'
               END) COMFIRM_RESULT
          FROM (SELECT ASN_ID,
                       LISTAGG(DISTINCT NVL(SKUCOMFIRM_RESULT, ' '), ';') SKUCOMFIRM_RESULTS,
                       MAX(ITEMCN) ITEMCN,
                       COUNT(DISTINCT BARCODE) SCPCN
                  FROM (SELECT ASN_ID,
                               BARCODE,
                               COMPANY_ID,
                               FIRST_VALUE(SKUCOMFIRM_RESULT) OVER(PARTITION BY ASN_ID, BARCODE, COMPANY_ID ORDER BY SKUCOMFIRM_TIME DESC) SKUCOMFIRM_RESULT,
                               (SELECT COUNT(BARCODE) FROM SCMDATA.T_ASNORDERSITEM_ITF WHERE ASN_ID = TMPSCP.ASN_ID AND COMPANY_ID = TMPSCP.COMPANY_ID AND NVL(WAREHOUSE_POS,' ') <> ' ') ITEMCN
                                FROM SCMDATA.T_QA_SCOPE TMPSCP
                               WHERE ASN_ID = I.ASN_ID
                                 AND ORIGIN = 'SCM'
                                 AND COMPANY_ID = I.COMPANY_ID
                                 AND EXISTS
                               (SELECT 1
                                        FROM SCMDATA.T_QA_REPORT
                                       WHERE QA_REPORT_ID = TMPSCP.QA_REPORT_ID
                                         AND COMPANY_ID = TMPSCP.COMPANY_ID
                                         AND STATUS IN ('N_PCF','R_PCF','N_ACF','R_ACF')))
                       GROUP BY ASN_ID));

      FOR H IN (SELECT DISTINCT TASNS.ASN_ID,
                                TASNS.COMPANY_ID,
                                TCI.GOO_ID,
                                TASNS.RECEIVE_TIME     SRECTIME,
                                TASNSITEM.BARCODE,
                                TASNSITEM.RECEIVE_TIME IRECTIME
                  FROM SCMDATA.T_ASNORDERS_ITF TASNS
                 INNER JOIN SCMDATA.T_COMMODITY_INFO TCI
                    ON TASNS.GOO_ID = TCI.RELA_GOO_ID
                   AND TASNS.COMPANY_ID = TCI.COMPANY_ID
                  LEFT JOIN SCMDATA.T_ASNORDERSITEM_ITF TASNSITEM
                    ON TASNS.ASN_ID = TASNSITEM.ASN_ID
                   AND NVL(TASNSITEM.WAREHOUSE_POS,' ') <> ' '
                   AND TASNS.COMPANY_ID = TASNSITEM.COMPANY_ID
                 WHERE TASNS.ASN_ID = I.ASN_ID
                   AND TASNS.COMPANY_ID = I.COMPANY_ID) LOOP
        IF H.BARCODE IS NOT NULL THEN
          UPDATE SCMDATA.T_QA_SCOPE
             SET TAKEOVER_TIME = H.IRECTIME
           WHERE ASN_ID = H.ASN_ID
             AND GOO_ID = H.GOO_ID
             AND BARCODE = H.BARCODE
             AND COMPANY_ID = H.COMPANY_ID;
        ELSE
          UPDATE SCMDATA.T_QA_SCOPE
             SET TAKEOVER_TIME = H.SRECTIME
           WHERE ASN_ID = H.ASN_ID
             AND GOO_ID = H.GOO_ID
             AND BARCODE IS NULL
             AND COMPANY_ID = H.COMPANY_ID;
        END IF;
      END LOOP;

      SELECT JSON_ARRAYAGG(JSON_OBJECT(GOO_ID,
                                       GOODSID,
                                       SKUCOMFIRM_RESULT,
                                       PACK_INFO RETURNING CLOB) RETURNING CLOB)
        INTO V_TMPCLOB
        FROM (SELECT X.RELA_GOO_ID GOO_ID,
                     NVL(Y.BARCODE, X.RELA_GOO_ID) GOODSID,
                     Y.SKUCOMFIRM_RESULT,
                     (SELECT JSON_ARRAYAGG(JSON_OBJECT(PACK_BARCODE,
                                                       SUBS_AMOUNT RETURNING CLOB)
                                           RETURNING CLOB)
                        FROM (SELECT ASNPACKS.PACK_BARCODE,
                                     NVL(SUBSRELA.SUBS_AMOUNT, 0) SUBS_AMOUNT
                                FROM (SELECT ASN_ID,
                                             BARCODE,
                                             PACK_BARCODE,
                                             COMPANY_ID
                                        FROM SCMDATA.T_ASNORDERPACKS
                                       WHERE GOODSID = NVL(Y.BARCODE, Y.GOO_ID)
                                         AND COMPANY_ID = Y.COMPANY_ID
                                         AND ASN_ID = I.ASN_ID) ASNPACKS
                                LEFT JOIN SCMDATA.T_QA_SUBSRELA SUBSRELA
                                  ON ASNPACKS.ASN_ID = SUBSRELA.ASN_ID
                                 AND ASNPACKS.BARCODE = SUBSRELA.GOODSID
                                 AND ASNPACKS.PACK_BARCODE =
                                     SUBSRELA.PACKBARCODE
                                 AND ASNPACKS.COMPANY_ID = SUBSRELA.COMPANY_ID
                                 AND SUBSRELA.QA_SCOPE_ID = Y.QA_SCOPE_ID)) PACK_INFO
                FROM (SELECT QA_SCOPE_ID,
                             GOO_ID,
                             BARCODE,
                             COMPANY_ID,
                             SKUCOMFIRM_RESULT
                        FROM SCMDATA.T_QA_SCOPE TSCP
                       WHERE ASN_ID = I.ASN_ID
                         AND COMPANY_ID = I.COMPANY_ID
                         AND ORIGIN = 'SCM'
                         AND TAKEOVER_TIME IS NOT NULL
                         AND SKUCOMFIRM_RESULT IS NOT NULL
                         AND SKUCOMFIRM_RESULT <> 'RT'
                         AND IS_QUALITY = 0
                         AND EXISTS (SELECT 1
                                       FROM SCMDATA.T_ASNINFO_PRETRANS_TO_WMS
                                      WHERE PP_QA_SCOPE_ID = TSCP.QA_SCOPE_ID
                                        AND COMPANY_ID = TSCP.COMPANY_ID
                                        AND STATUS = 'PD')) Y
                LEFT JOIN SCMDATA.T_COMMODITY_INFO X
                  ON Y.GOO_ID = X.GOO_ID
                 AND Y.COMPANY_ID = X.COMPANY_ID);

      IF V_TMPCLOB IS NOT NULL AND V_RETCLOB IS NULL THEN
        V_RETCLOB := SUBSTR(V_ASNCLOB, 1, LENGTH(V_ASNCLOB) - 1) ||
                     ',"SKU_INFO":' || V_TMPCLOB || '}';
      ELSIF V_TMPCLOB IS NOT NULL AND V_RETCLOB IS NOT NULL THEN
        V_RETCLOB := V_RETCLOB || ',' ||
                     SUBSTR(V_ASNCLOB, 1, LENGTH(V_ASNCLOB) - 1) ||
                     ',"SKU_INFO":' || V_TMPCLOB || '}';
      END IF;

      FOR G IN (SELECT B.QA_SCOPE_ID, B.COMPANY_ID
                  FROM SCMDATA.T_ASNINFO_PRETRANS_TO_WMS A
                 INNER JOIN SCMDATA.T_QA_SCOPE B
                    ON A.PP_QA_SCOPE_ID = B.QA_SCOPE_ID
                   AND A.COMPANY_ID = B.COMPANY_ID
                   AND B.IS_QUALITY = 0
                 INNER JOIN SCMDATA.T_COMMODITY_INFO C
                    ON B.GOO_ID = C.GOO_ID
                   AND B.COMPANY_ID = C.COMPANY_ID
                 WHERE A.PP_QA_SCOPE_ID IS NOT NULL
                   AND B.ASN_ID = I.ASN_ID
                   AND B.COMPANY_ID = I.COMPANY_ID
                   AND B.ORIGIN = 'SCM'
                   AND A.STATUS = 'PD'
                   AND B.IS_QUALITY = 0
                   AND B.TAKEOVER_TIME IS NOT NULL
                   AND B.SKUCOMFIRM_RESULT <> 'RT') LOOP
        UPDATE SCMDATA.T_ASNINFO_PRETRANS_TO_WMS
           SET STATUS = 'FD',
               ERR_INFO =  '{ "portBody" : [' || LTRIM(V_RETCLOB, ',') || ']}',
               LASTUPD_ID = 'cfjson_by_ppscope',
               LASTUPD_TIME = SYSDATE
         WHERE STATUS = 'PD'
           AND PP_QA_SCOPE_ID = G.QA_SCOPE_ID
           AND COMPANY_ID = G.COMPANY_ID;
      END LOOP;
    END LOOP;
    COMMIT;

    V_RETCLOB := '{ "portBody" : [' || LTRIM(V_RETCLOB, ',') || ']}';

    RETURN V_RETCLOB;
  END F_GEN_CFJSON_BY_PPSCOPE;



  /*=================================================================================

    【正常使用】为特批放行单据生成质检确认结果 json

    用途:
      为特批放行单据生成质检确认结果 json

    入参:
      V_ASNID      :  ASN单号
      V_COMPID     :  企业Id

    返回样例:
      {
        "ASN_ID": "ASN20210819160955944289000",
        "COMFIRM_RESULT": "PS",
        "SKU_INFO": [{
          "GOO_ID": "440430",
          "GOODSID": "44043001",
          "SKUCOMFIRM_RESULT": "PS",
          "PACK_INFO": [{
            "PACK_BARCODE": "PB440430010045",
            "SUBS_AMOUNT": 0
          }]
        }]
      }

    版本:
      2021-10-26 : 完成从单个特批ASN生成JSON存储过程，但在外层调用时，
                   需将 SCMDATA.T_ASNORDERED.ORIGIN = SCMSATP(SCM SPECIAL APPROVE TRANS PREPARED)
                   设置为 SCMSATF(SCM SPECIAL APPROVE TRANS FINISHED)


  =================================================================================*/
  FUNCTION F_GENERATE_COMFIRMRESULT_JSON_WITH_SAASN(V_ASNID  VARCHAR2,
                                                    V_COMPID VARCHAR2) RETURN CLOB IS
    V_ASNCLOB CLOB;
    V_SKUCLOB CLOB;
    V_RETCLOB CLOB;
  BEGIN
    SELECT JSON_OBJECT(ASN_ID, COMFIRM_RESULT)
      INTO V_ASNCLOB
      FROM (SELECT V_ASNID ASN_ID, 'PS' COMFIRM_RESULT FROM DUAL);

    SELECT JSON_ARRAYAGG(JSON_OBJECT(GOO_ID,
                                     GOODSID,
                                     SKUCOMFIRM_RESULT,
                                     PACK_INFO  RETURNING CLOB) RETURNING CLOB)
      INTO V_SKUCLOB
      FROM (SELECT A.ASN_ID,
                   A.COMPANY_ID,
                   C.RELA_GOO_ID GOO_ID,
                   NVL(B.BARCODE, C.RELA_GOO_ID) GOODSID,
                   'PS' SKUCOMFIRM_RESULT,
                   (SELECT JSON_ARRAYAGG(JSON_OBJECT(PACK_BARCODE, SUBS_AMOUNT RETURNING CLOB) RETURNING CLOB)
                      FROM (SELECT PACK_BARCODE, 0 SUBS_AMOUNT
                              FROM (SELECT ASN_ID,GOODSID,PACK_BARCODE,COMPANY_ID
                                      FROM SCMDATA.T_ASNORDERPACKS
                                     WHERE ASN_ID = A.ASN_ID
                                       AND GOODSID = NVL(B.BARCODE, A.GOO_ID)
                                       AND COMPANY_ID = A.COMPANY_ID))) PACK_INFO
              FROM (SELECT ASN_ID, COMPANY_ID, GOO_ID
                      FROM SCMDATA.T_ASNORDERS
                     WHERE ASN_ID = V_ASNID
                       AND COMPANY_ID = V_COMPID) A
              LEFT JOIN SCMDATA.T_ASNORDERSITEM B
                ON A.ASN_ID = B.ASN_ID
               AND A.COMPANY_ID = B.COMPANY_ID
               AND EXISTS (SELECT 1 FROM SCMDATA.T_ASNORDERSITEM_ITF
                            WHERE PORT_STATUS IN ('SP','SS','UP','UE','US')
                              AND ASN_ID = B.ASN_ID
                              AND BARCODE = B.BARCODE
                              AND COMPANY_ID = B.COMPANY_ID)
              LEFT JOIN SCMDATA.T_COMMODITY_INFO C
                ON A.GOO_ID = C.GOO_ID
               AND A.COMPANY_ID = C.COMPANY_ID);

    IF V_RETCLOB IS NULL THEN
      V_RETCLOB := SUBSTR(V_ASNCLOB,1,LENGTH(V_ASNCLOB)-1) || ',"SKU_INFO":' || V_SKUCLOB || '}';
    ELSIF V_RETCLOB IS NOT NULL THEN
      V_RETCLOB := V_RETCLOB||','||SUBSTR(V_ASNCLOB,1,LENGTH(V_ASNCLOB)-1) || ',"SKU_INFO":' || V_SKUCLOB || '}';
    END IF;
    RETURN V_RETCLOB;
  END F_GENERATE_COMFIRMRESULT_JSON_WITH_SAASN;



  /*=================================================================================

    【正常使用】根据 QA_REPORT_IDS,COMPANY_ID 生成质检确认结果 JSON

    用途:
      通过校验传入的 QA_REPORT_IDS,COMPANY_ID ，如果质检报告下SKU全部确认收货，
      则生成对应的质检结果确认JSON，否则不生成

    入参:
      V_QAREPIDS : QA质检报告ID，多值用英文逗号分隔
      V_COMPID   : 企业Id

    版本:
      2021-11-01 : 通过校验传入的 QA_REPORT_IDS,COMPANY_ID ，如果存在SKU全部确认收货，
                   则生成对应的质检结果确认JSON
      2021-11-02 : 1.增加预回传信息记录 2.增加接口符合 QA_REPORT_ID 记录

  =================================================================================*/
  FUNCTION F_GENERATE_COMFIRMRESULT_JSON_WITH_REPS(V_QAREPIDS  IN VARCHAR2,
                                                   V_CUID      IN VARCHAR2,
                                                   V_COMPID    IN VARCHAR2) RETURN CLOB IS
    PRAGMA AUTONOMOUS_TRANSACTION;
    V_JUGNUM    NUMBER(1);
    /*V_REPIDS    CLOB;*/
    V_RETCLOB   CLOB;
  BEGIN
    FOR I IN (SELECT DISTINCT QA_REPORT_ID, COMPANY_ID
                FROM SCMDATA.T_QA_REPORT
               WHERE INSTR(','||V_QAREPIDS||',', ','||QA_REPORT_ID||',')>0
                 AND COMPANY_ID = V_COMPID) LOOP
      V_JUGNUM := F_GHECK_TAKEOVER_TIME_EXIST(V_QAREPID => I.QA_REPORT_ID,
                                              V_COMPID  => I.COMPANY_ID);
      IF V_JUGNUM = 0 THEN
        /*V_REPIDS := V_REPIDS || ',' || I.QA_REPORT_ID;*/
        SCMDATA.PKG_ASN_INTERFACE.P_GENERATE_ASN_PRETRANS_INFO(V_QAREPID => I.QA_REPORT_ID,
                                                               V_COMPID  => I.COMPANY_ID,
                                                               V_CUID    => V_CUID,
                                                               V_STATUS  => 'FD');
        V_RETCLOB := V_RETCLOB || ',' || F_GENERATE_COMFIRMRESULT_JSON_WITH_REP(V_QAREPID  => I.QA_REPORT_ID,
                                                                                V_COMPID   => I.COMPANY_ID);
      ELSE
        SCMDATA.PKG_ASN_INTERFACE.P_GENERATE_ASN_PRETRANS_INFO(V_QAREPID => I.QA_REPORT_ID,
                                                               V_COMPID  => I.COMPANY_ID,
                                                               V_CUID    => V_CUID,
                                                               V_STATUS  => 'SE');
      END IF;

      --更新 T_ASN_PRETRANS_TO_WMS
      P_UPD_ASNPRETRANSWMS_LASTINFO(V_QAREPID  => I.QA_REPORT_ID,
                                    V_OPEROBJ  => 'gen_rep_json',
                                    V_COMPID   => I.COMPANY_ID);
    END LOOP;

    --正式用
    V_RETCLOB  := '{ "portBody" : ['|| LTRIM(V_RETCLOB,',') || ']}';
    --测试用
    /*V_RETCLOB := REPLACE(REPLACE(LTRIM(V_RETCLOB,','),':','='),'"','');
    V_REPIDS := LTRIM(V_REPIDS,',');
    IF V_REPIDS IS NOT NULL THEN
      SCMDATA.PKG_VARIABLE.P_INS_OR_UPD_VARIABLE_WITH_CHAID(V_OBJID   => 'result_to_wms',
                                                            V_COMPID  => V_COMPID,
                                                            V_VARNAME => 'QA_REPORT_IDS',
                                                            V_VARTYPE => 'CLOB',
                                                            V_CLOB    => V_REPIDS,
                                                            V_CHAID   => V_CUID);
    END IF;*/
    COMMIT;
    RETURN V_RETCLOB;
  END F_GENERATE_COMFIRMRESULT_JSON_WITH_REPS;



  /*=================================================================================

   【停用】 根据 QA_SCOPE_IDS,COMPANY_ID 生成质检确认结果json

    用途:
      用于在QA待确认报告-SKU质检确认提交按钮中，通过校验传入的 QA_REPORT_IDS,COMPANY_ID ，
      如果质检报告下SKU全部确认收货，则生成对应的质检结果确认JSON，否则不生成，


    入参:
      V_QAREPIDS : QA质检报告ID，多值用英文逗号分隔
      V_COMPID   : 企业Id

    版本:
      2021-11-01 : 通过校验传入的 QA_REPORT_IDS,COMPANY_ID ，如果存在SKU全部确认收货，
                   则生成对应的质检结果确认JSON
      2021-11-02 : 1.增加预回传信息记录 2.增加接口符合 QA_SCOPE_ID 记录
      2021-11-25 : WMS 要求按照 ASN 单号进行合并，故停用

  =================================================================================*/
  FUNCTION F_GENERATE_COMFIRMRESULT_JSON_WITH_SCOPES(V_QASCOPEIDS  IN VARCHAR2,
                                                     V_CUID        IN VARCHAR2,
                                                     V_COMPID      IN VARCHAR2) RETURN CLOB IS
    PRAGMA AUTONOMOUS_TRANSACTION;
    V_JUGNUM    NUMBER(1);
    /*V_SCOPEIDS  CLOB;*/
    V_RETCLOB   CLOB;
  BEGIN
    FOR I IN (SELECT QA_REPORT_ID, QA_SCOPE_ID, COMPANY_ID, ORIGIN
                FROM SCMDATA.T_QA_SCOPE
               WHERE INSTR(','||V_QASCOPEIDS||',', ','||QA_SCOPE_ID||',')>0
                 AND COMPANY_ID = V_COMPID) LOOP
      IF I.ORIGIN <> 'WMS' THEN
        V_JUGNUM := F_GHECK_TAKEOVER_TIME_EXIST(V_QAREPID   => I.QA_REPORT_ID,
                                                V_QASCOPEID => I.QA_SCOPE_ID,
                                                V_COMPID    => I.COMPANY_ID);
        IF V_JUGNUM = 0 THEN
          /*V_SCOPEIDS := V_SCOPEIDS || ',' || I.QA_SCOPE_ID;*/
          SCMDATA.PKG_ASN_INTERFACE.P_GENERATE_ASN_PRETRANS_INFO(V_QASCOPEID => I.QA_SCOPE_ID,
                                                                 V_COMPID    => I.COMPANY_ID,
                                                                 V_CUID      => V_CUID,
                                                                 V_STATUS    => 'FD');
          V_RETCLOB := V_RETCLOB || ',' || F_GENERATE_COMFIRMRESULT_JSON_WITH_SCOPE(V_QASCOPEID => I.QA_SCOPE_ID,
                                                                                    V_COMPID    => I.COMPANY_ID);
        ELSE
          SCMDATA.PKG_ASN_INTERFACE.P_GENERATE_ASN_PRETRANS_INFO(V_QASCOPEID => I.QA_SCOPE_ID,
                                                                 V_COMPID    => I.COMPANY_ID,
                                                                 V_CUID      => V_CUID,
                                                                 V_STATUS    => 'SE');
        END IF;
      END IF;
    END LOOP;
    --正式用
    V_RETCLOB  := '{ "portBody" : ['|| LTRIM(V_RETCLOB,',') || ']}';
    --测试用
    /*V_RETCLOB := REPLACE(REPLACE(LTRIM(V_RETCLOB,','),':','='),'"','');*/
    /*V_RETCLOB  := REPLACE(REPLACE(V_RETCLOB,':','='),'"','');*/
    /*V_SCOPEIDS := LTRIM(V_SCOPEIDS,',');
    IF V_SCOPEIDS IS NOT NULL THEN
      SCMDATA.PKG_VARIABLE.P_INS_OR_UPD_VARIABLE_WITH_CHAID(V_OBJID   => 'result_to_wms',
                                                            V_COMPID  => V_COMPID,
                                                            V_VARNAME => 'QA_SCOPE_IDS',
                                                            V_VARTYPE => 'CLOB',
                                                            V_CLOB    => V_SCOPEIDS,
                                                            V_CHAID   => V_CUID);
    END IF;*/
    COMMIT;
    RETURN V_RETCLOB;
  END F_GENERATE_COMFIRMRESULT_JSON_WITH_SCOPES;



  /*=================================================================================


   【正常使用】 根据 QA_SCOPE_IDS,COMPANY_ID 获取质检确认结果json，
               并对数据进行记录和处理

    用途:
      用于在QA待确认报告-SKU质检确认提交按钮中，通过校验传入的 QA_SCOPE_IDS,COMPANY_ID ，
      如果质检报告下SKU全部确认收货，且来源不包含 WMS ,
      则生成对应的质检结果确认JSON，否则不生成

    入参:
      V_QASCOPEIDS : QA质检范围ID，多值用英文逗号分隔
      V_CUID       : 当前操作人Id
      V_COMPID     : 企业Id

    版本:
      2021-11-25 : 通过校验传入的 QA_REPORT_IDS,COMPANY_ID ，
                   如果存在SKU全部确认收货，且来源不包含 WMS ,
                   则生成对应的质检结果确认JSON

  =================================================================================*/
  FUNCTION F_GET_COMFIRM_JSON_BYSCPIDS_CBASN_PS(V_QASCOPEIDS  IN VARCHAR2,
                                                V_CUID        IN VARCHAR2,
                                                V_COMPID      IN VARCHAR2) RETURN CLOB IS
    PRAGMA AUTONOMOUS_TRANSACTION;
    V_JUGNUM    NUMBER(1);
    V_SCOPEIDS  CLOB;
    V_RETCLOB   CLOB;
  BEGIN
    FOR I IN (SELECT QA_REPORT_ID, QA_SCOPE_ID, COMPANY_ID, ORIGIN, SKUCOMFIRM_RESULT
                FROM SCMDATA.T_QA_SCOPE
               WHERE INSTR(','||V_QASCOPEIDS||',', ','||QA_SCOPE_ID||',')>0
                 AND COMPANY_ID = V_COMPID) LOOP
      IF I.ORIGIN <> 'WMS' AND I.SKUCOMFIRM_RESULT <> 'RT' THEN
        V_JUGNUM := F_GHECK_TAKEOVER_TIME_EXIST(V_QAREPID   => I.QA_REPORT_ID,
                                                V_QASCOPEID => I.QA_SCOPE_ID,
                                                V_COMPID    => I.COMPANY_ID);
        IF V_JUGNUM = 0 THEN
          V_SCOPEIDS := V_SCOPEIDS || ',' || I.QA_SCOPE_ID;
          SCMDATA.PKG_ASN_INTERFACE.P_GENERATE_ASN_PRETRANS_INFO(V_QASCOPEID => I.QA_SCOPE_ID,
                                                                 V_COMPID    => I.COMPANY_ID,
                                                                 V_CUID      => V_CUID,
                                                                 V_STATUS    => 'SS');
        ELSE
          SCMDATA.PKG_ASN_INTERFACE.P_GENERATE_ASN_PRETRANS_INFO(V_QASCOPEID => I.QA_SCOPE_ID,
                                                                 V_COMPID    => I.COMPANY_ID,
                                                                 V_CUID      => V_CUID,
                                                                 V_STATUS    => 'SE');
        END IF;
      END IF;

      --更新 T_ASN_PRETRANS_TO_WMS
      P_UPD_ASNPRETRANSWMS_LASTINFO(V_QASCPID  => I.QA_SCOPE_ID,
                                    V_OPEROBJ  => 'gen_scp_json',
                                    V_COMPID   => I.COMPANY_ID);
    END LOOP;

    V_RETCLOB :=  F_GEN_COMFIRMJSON_BYSCPIDS_CBASN(V_QASCOPEIDS  => V_SCOPEIDS,
                                                   V_COMPID      => V_COMPID);
    --正式用
    V_RETCLOB  := '{ "portBody" : ['|| V_RETCLOB || ']}';
    --测试用
    /*V_RETCLOB := REPLACE(REPLACE(LTRIM(V_RETCLOB,','),':','='),'"','');*/
    COMMIT;
    RETURN V_RETCLOB;
  END F_GET_COMFIRM_JSON_BYSCPIDS_CBASN_PS;



  /*=================================================================================

    【正常使用】根据 ASN_IDS,COMPANY_ID 生成质检确认结果json

    用途:
      用于在QA待确认报告-SKU质检确认提交按钮中，通过校验传入的 QA_REPORT_IDS,COMPANY_ID ，
      如果质检报告下SKU全部确认收货，则生成对应的质检结果确认JSON，否则不生成，


    入参:
      V_QAREPIDS : QA质检报告ID，多值用英文逗号分隔
      V_COMPID   : 企业Id

    版本:
      2021-11-01 : 通过校验传入的 QA_REPORT_IDS,COMPANY_ID ，如果存在SKU全部确认收货，
                   则生成对应的质检结果确认JSON
      2021-11-02 : 1.增加预回传信息记录 2.增加 ASN_ID 记录

  =================================================================================*/
  FUNCTION F_GENERATE_COMFIRMRESULT_JSON_WITH_SAASNS(V_ASNIDS  IN VARCHAR2,
                                                     V_CUID    IN VARCHAR2,
                                                     V_COMPID  IN VARCHAR2) RETURN CLOB IS
    PRAGMA AUTONOMOUS_TRANSACTION;
    V_RETCLOB   CLOB;
  BEGIN
    FOR I IN (SELECT DISTINCT ASN_ID, COMPANY_ID
                FROM SCMDATA.T_ASNORDERED
               WHERE INSTR(','||V_ASNIDS||',', ','||ASN_ID||',')>0
                 AND COMPANY_ID = V_COMPID) LOOP
      SCMDATA.PKG_ASN_INTERFACE.P_GENERATE_ASN_PRETRANS_INFO(V_ASNID     => I.ASN_ID,
                                                             V_COMPID    => I.COMPANY_ID,
                                                             V_CUID      => V_CUID,
                                                             V_STATUS    => 'FD');
      V_RETCLOB := V_RETCLOB || ',' || F_GENERATE_COMFIRMRESULT_JSON_WITH_SAASN(V_ASNID  => I.ASN_ID,
                                                                                V_COMPID => I.COMPANY_ID);

      --更新 T_ASN_PRETRANS_TO_WMS
      UPDATE SCMDATA.T_ASNINFO_PRETRANS_TO_WMS TAB
         SET TAB.ERR_INFO =  '{ "portBody" : ['|| LTRIM(V_RETCLOB,',') || ']}',
             TAB.LASTUPD_ID = V_CUID,
             TAB.LASTUPD_TIME = SYSDATE
       WHERE TAB.ASN_ID = I.ASN_ID
         AND TAB.COMPANY_ID = I.COMPANY_ID;
    END LOOP;

    --正式用
    V_RETCLOB  := '{ "portBody" : ['|| LTRIM(V_RETCLOB,',') || ']}';
    --测试用
    /*V_RETCLOB := REPLACE(REPLACE(LTRIM(V_RETCLOB,','),':','='),'"','');*/
    /*IF V_ASNIDS IS NOT NULL THEN
      SCMDATA.PKG_VARIABLE.P_INS_OR_UPD_VARIABLE_WITH_CHAID(V_OBJID   => 'result_to_wms',
                                                            V_COMPID  => V_COMPID,
                                                            V_VARNAME => 'ASN_IDS',
                                                            V_VARTYPE => 'CLOB',
                                                            V_CLOB    => V_ASNIDS,
                                                            V_CHAID   => V_CUID);
    END IF;*/
    COMMIT;
    RETURN V_RETCLOB;
  END F_GENERATE_COMFIRMRESULT_JSON_WITH_SAASNS;



  /*=================================================================================

    【停用-速狮不支持返回值自定义】生成回传给 WMS 的 ASN_INFO JSON

    用途:
      通过 QA_SCOPE_IDS,COMPANY_ID 生成质检确认结果JSON字符串，用于回传至 WMS

    入参:
      V_QASCOPEID  :  QA质检明细Id
      V_QASCOPEID  :  QA质检明细Id
      V_COMPID     :  企业Id

    版本:
      2021-10-20 : 从 SCMDATA.PKG_QA_LOGIC 迁移至 SCMDATA.PKG_ASN_INTERFACE

  =================================================================================*/
  /*FUNCTION F_GENERATE_ASNINFO_JSON(V_QAREPID  IN VARCHAR2,
                                   V_QASCOPID IN VARCHAR2 DEFAULT NULL,
                                   V_COMPID   IN VARCHAR2) RETURN CLOB IS
    V_RETCLOB  CLOB;
  BEGIN
    IF V_QASCOPID IS NULL THEN
      V_RETCLOB := F_GENERATE_COMFIRMRESULT_JSON_WITH_REP(V_QAREPID  => V_QAREPID,
                                                          V_COMPID   => V_COMPID);
    ELSE
      V_RETCLOB := F_GENERATE_COMFIRMRESULT_JSON_WITH_SCOPE(V_QASCOPEID => V_QASCOPID,
                                                            V_COMPID    => V_COMPID);
    END IF;
    RETURN V_RETCLOB;
  END F_GENERATE_ASNINFO_JSON;*/



  /*=================================================================================

    【停用-速狮不支持返回值自定义】返回用于传输给 WMS 的质检结果

    用途:
      返回用于传输给 WMS 的质检结果

    版本:
      2021-10-20 : 整合测试

  =================================================================================*/
  /*FUNCTION F_GET_INFO_TO_WMS RETURN CLOB IS
    PRAGMA      AUTONOMOUS_TRANSACTION;
    V_INFO      CLOB;
    V_COMPID    VARCHAR2(32):='b6cc680ad0f599cde0531164a8c0337f';
    V_COUNTER   NUMBER(4):= 1;
  BEGIN
    SCMDATA.PKG_VARIABLE.P_INS_OR_UPD_VARIABLE(V_OBJID   => 'f_get_info_to_wms',
                                               V_COMPID  => V_COMPID,
                                               V_VARNAME => 'INFO_ID',
                                               V_VARTYPE => 'CLOB',
                                               V_CLOB    => ' ');

    SCMDATA.PKG_VARIABLE.P_INS_OR_UPD_VARIABLE(V_OBJID   => 'f_get_info_to_wms',
                                               V_COMPID  => V_COMPID,
                                               V_VARNAME => 'ASN_ID',
                                               V_VARTYPE => 'CLOB',
                                               V_CLOB    => ' ');


    SCMDATA.PKG_VARIABLE.P_INS_OR_UPD_VARIABLE(V_OBJID   => 'f_get_info_to_wms',
                                               V_COMPID  => V_COMPID,
                                               V_VARNAME => 'ERASN_ID',
                                               V_VARTYPE => 'CLOB',
                                               V_CLOB    => ' ');

    FOR I IN (SELECT QA_REPORT_ID, COMPANY_ID,
                     MAX(QA_SCOPE_ID) QA_SCOPE_ID,
                     ','||LISTAGG(DISTINCT INFO_ID, ',')||',' INFO_ID
                FROM (SELECT INFO_ID, QA_REPORT_ID, COMPANY_ID, QA_SCOPE_ID
                        FROM SCMDATA.T_ASNINFO_PRETRANS_TO_WMS Z
                       WHERE STATUS = 'PD'
                         AND EXISTS
                       (SELECT 1
                                FROM SCMDATA.T_QA_REPORT
                               WHERE QA_REPORT_ID = Z.QA_REPORT_ID
                                 AND COMPANY_ID = Z.COMPANY_ID)
                       ORDER BY CREATE_TIME)
               GROUP BY QA_REPORT_ID, COMPANY_ID) LOOP
      IF V_COUNTER <= 50 THEN
        IF V_INFO IS NULL THEN
          V_INFO := SCMDATA.PKG_ASN_INTERFACE.F_GENERATE_ASNINFO_JSON(V_QAREPID  => I.QA_REPORT_ID,
                                                                      V_QASCOPID => I.QA_SCOPE_ID,
                                                                      V_COMPID   => I.COMPANY_ID);
        ELSE
          V_INFO := V_INFO || ',' || SCMDATA.PKG_ASN_INTERFACE.F_GENERATE_ASNINFO_JSON(V_QAREPID  => I.QA_REPORT_ID,
                                                                                       V_QASCOPID => I.QA_SCOPE_ID,
                                                                                       V_COMPID   => I.COMPANY_ID);
        END IF;

        SCMDATA.PKG_VARIABLE.P_APPEND_CLOB_VARIABLE(V_OBJID   => 'f_get_info_to_wms',
                                                    V_COMPID  => V_COMPID,
                                                    V_VARNAME => 'INFO_ID',
                                                    V_APPSTR  => I.INFO_ID);
      ELSE
        EXIT;
      END IF;

      V_COUNTER := V_COUNTER + 1;
    END LOOP;

    V_COUNTER := 1;

    FOR L IN (SELECT ASN_ID, COMPANY_ID
                FROM SCMDATA.T_ASNORDERED
               WHERE STATUS = 'SA'
                 AND SA_TRANS = 0
               ORDER BY CREATE_TIME) LOOP
      IF V_COUNTER <= 50 THEN
        IF V_INFO IS NULL THEN
          V_INFO := SCMDATA.PKG_ASN_INTERFACE.F_GENERATE_COMFIRMRESULT_JSON_WITH_SAASN(V_ASNID => L.ASN_ID,
                                                                                       V_COMPID => L.COMPANY_ID);
        ELSE
          V_INFO := V_INFO || ',' || SCMDATA.PKG_ASN_INTERFACE.F_GENERATE_COMFIRMRESULT_JSON_WITH_SAASN(V_ASNID => L.ASN_ID,
                                                                                                        V_COMPID => L.COMPANY_ID);
        END IF;

        SCMDATA.PKG_VARIABLE.P_APPEND_CLOB_VARIABLE(V_OBJID   => 'f_get_info_to_wms',
                                                    V_COMPID  => V_COMPID,
                                                    V_VARNAME => 'ASN_ID',
                                                    V_APPSTR  => L.ASN_ID);
      ELSE
        EXIT;
      END IF;

      V_COUNTER := V_COUNTER + 1;
    END LOOP;
    COMMIT;
    RETURN V_INFO;
  END F_GET_INFO_TO_WMS;*/



  /*=================================================================================

    【停用-速狮不支持返回值自定义】生成质检结果重传JSON

    用途:
      用于将前一批传给 WMS 的质检结果数据中的错误数据剔除后，重新生成质检结果JSON,
      进行二次传输

    版本:
      2021-10-27 : 从 SCMDATA.PKG_QA_LOGIC 迁移至 SCMDATA.PKG_ASN_INTERFACE

  =================================================================================*/
  /*FUNCTION F_GET_WMSRETRANS_JSON RETURN CLOB IS
    V_COMPID   VARCHAR2(32):='b6cc680ad0f599cde0531164a8c0337f';
    V_INFOIDS  CLOB;
    V_ASNIDS   CLOB;
    V_ERASNIDS CLOB;
    V_LASTUPD  DATE;
    V_JUGCLOB  CLOB;
    V_INFO     CLOB;
  BEGIN
    V_JUGCLOB := SCMDATA.PKG_VARIABLE.F_GET_CLOB(V_OBJID   => 'f_get_info_to_wms',
                                                 V_COMPID  => V_COMPID,
                                                 V_VARNAME => 'ERASN_ID');

    IF V_JUGCLOB <> ' ' THEN
      SELECT VAR_CLOB, LAST_UPDTIME
        INTO V_ASNIDS,V_LASTUPD
        FROM SCMDATA.T_VARIABLE
       WHERE OBJ_ID = 'f_get_info_to_wms'
         AND COMPANY_ID = V_COMPID
         AND VAR_NAME = 'ASN_ID';

      V_ASNIDS := REPLACE(V_ASNIDS,CHR(10),',');

      IF V_LASTUPD >= SYSDATE-1/(60*24) AND V_LASTUPD >= SYSDATE-2/(60*24) THEN
        V_INFOIDS := REPLACE(SCMDATA.PKG_VARIABLE.F_GET_CLOB(V_OBJID   => 'f_get_info_to_wms',
                                                             V_COMPID  => V_COMPID,
                                                             V_VARNAME => 'INFO_ID'),CHR(10),',');

        V_ERASNIDS := REPLACE(SCMDATA.PKG_VARIABLE.F_GET_CLOB(V_OBJID   => 'f_get_info_to_wms',
                                                              V_COMPID  => V_COMPID,
                                                              V_VARNAME => 'ERASN_ID'),CHR(10),',');

        UPDATE SCMDATA.T_ASNINFO_PRETRANS_TO_WMS
           SET STATUS = 'FD'
         WHERE INSTR(','||V_INFOIDS||',', ','||INFO_ID||',')>0
           AND INSTR(','||V_ERASNIDS||',', ','||ASN_ID||',')=0;

        UPDATE SCMDATA.T_ASNINFO_PRETRANS_TO_WMS
           SET STATUS = 'WE'
         WHERE INSTR(','||V_INFOIDS||',', ','||INFO_ID||',')>0
           AND INSTR(','||V_ERASNIDS||',', ','||ASN_ID||',')>0;

        UPDATE SCMDATA.T_ASNORDERED
           SET SA_TRANS = 1
         WHERE INSTR(','||V_ASNIDS||',', ','||ASN_ID||',')>0
           AND INSTR(','||V_ERASNIDS||',', ','||ASN_ID||',')=0;

        UPDATE SCMDATA.T_ASNORDERED
           SET SA_TRANS = 2
         WHERE INSTR(','||V_ASNIDS||',', ','||ASN_ID||',')>0
           AND INSTR(','||V_ERASNIDS||',', ','||ASN_ID||',')>0;

        FOR I IN (SELECT QA_REPORT_ID, COMPANY_ID, QA_SCOPE_ID
                    FROM SCMDATA.T_ASNINFO_PRETRANS_TO_WMS Z
                   WHERE INSTR(','||V_INFOIDS||',', ','||INFO_ID||',') > 0
                     AND INSTR(','||V_ERASNIDS||',', ','||ASN_ID||',') = 0
                     AND COMPANY_ID = V_COMPID) LOOP
          IF V_INFO IS NULL THEN
            V_INFO := SCMDATA.PKG_ASN_INTERFACE.F_GENERATE_ASNINFO_JSON(V_QAREPID  => I.QA_REPORT_ID,
                                                                        V_QASCOPID => I.QA_SCOPE_ID,
                                                                        V_COMPID   => I.COMPANY_ID);
          ELSE
            V_INFO := V_INFO || ',' || SCMDATA.PKG_ASN_INTERFACE.F_GENERATE_ASNINFO_JSON(V_QAREPID  => I.QA_REPORT_ID,
                                                                                         V_QASCOPID => I.QA_SCOPE_ID,
                                                                                         V_COMPID   => I.COMPANY_ID);
          END IF;
        END LOOP;

        FOR L IN (SELECT ASN_ID, COMPANY_ID
                    FROM SCMDATA.T_ASNORDERED
                   WHERE INSTR(','||V_ASNIDS||',', ','||ASN_ID||',') > 0
                     AND INSTR(','||V_ERASNIDS||',', ','||ASN_ID||',') = 0
                     AND COMPANY_ID = V_COMPID) LOOP
          IF V_INFO IS NULL THEN
             V_INFO := SCMDATA.PKG_ASN_INTERFACE.F_GENERATE_COMFIRMRESULT_JSON_WITH_SAASN(V_ASNID => L.ASN_ID,
                                                                                          V_COMPID => L.COMPANY_ID);
            ELSE
             V_INFO := V_INFO || ',' || SCMDATA.PKG_ASN_INTERFACE.F_GENERATE_COMFIRMRESULT_JSON_WITH_SAASN(V_ASNID => L.ASN_ID,
                                                                                                            V_COMPID => L.COMPANY_ID);
          END IF;
        END LOOP;
      END IF;
    END IF;
    RETURN V_INFO;
  END F_GET_WMSRETRANS_JSON;*/




  /*=================================================================================

    【测试用】生成 ASNORDERPACKS 测试数据

    用途:
      用于生成与 WMS接口测试的 ASNORDERPACKS 数据

    版本:
      2021-10-21 : 接口测试

  =================================================================================*/
  PROCEDURE P_GEN_ASNORDERPACKS_DATA(V_ASNID   IN VARCHAR2,
                                     V_COMPID  IN VARCHAR2,
                                     V_GOOID   IN VARCHAR2,
                                     V_BARCODE IN VARCHAR2) IS
    V_RESTNUM  NUMBER(4);
  BEGIN
    IF V_BARCODE IS NULL THEN
      FOR I IN (SELECT * FROM SCMDATA.T_ASNORDERS
                 WHERE ASN_ID = V_ASNID
                   AND GOO_ID = V_GOOID
                   AND COMPANY_ID = V_COMPID) LOOP
        V_RESTNUM := TRUNC(DBMS_RANDOM.VALUE(0,1)*10);
        INSERT INTO SCMDATA.T_ASNORDERPACKS
          (ASN_ID,COMPANY_ID,DC_COMPANY_ID,OPERATOR_ID,GOO_ID,BARCODE,GOODSID,
           PACK_BARCODE,PACKAMOUNT,CREATE_ID,CREATE_TIME)
        VALUES
          (I.ASN_ID,I.COMPANY_ID,I.DC_COMPANY_ID,I.CREATE_ID,I.GOO_ID,I.GOO_ID,I.GOO_ID,
           'PB'||TO_CHAR(SYSTIMESTAMP,'YYMMDDHH24MISSFF')||LPAD(TRUNC(TO_CHAR(DBMS_RANDOM.VALUE(0,1)*100)),3,'0'),
           I.PCOME_AMOUNT-V_RESTNUM,I.CREATE_ID,I.CREATE_TIME);
      END LOOP;
    ELSE
      FOR M IN (SELECT * FROM SCMDATA.T_ASNORDERSITEM
                 WHERE ASN_ID = V_ASNID
                   AND GOO_ID = V_GOOID
                   AND BARCODE = V_BARCODE
                   AND COMPANY_ID = V_COMPID) LOOP
        V_RESTNUM := TRUNC(DBMS_RANDOM.VALUE(0,M.PCOME_AMOUNT));
        INSERT INTO SCMDATA.T_ASNORDERPACKS
          (ASN_ID,COMPANY_ID,DC_COMPANY_ID,OPERATOR_ID,GOO_ID,BARCODE,GOODSID,
           PACK_BARCODE,PACKAMOUNT,CREATE_ID,CREATE_TIME)
        VALUES
          (M.ASN_ID,M.COMPANY_ID,M.DC_COMPANY_ID,M.CREATE_ID,M.GOO_ID,M.BARCODE,M.BARCODE,
           'PB'||TO_CHAR(SYSTIMESTAMP,'YYMMDDHH24MISSFF')||LPAD(TRUNC(TO_CHAR(DBMS_RANDOM.VALUE(0,1)*100)),3,'0'),
           M.PCOME_AMOUNT-V_RESTNUM,M.CREATE_ID,M.CREATE_TIME);
      END LOOP;
    END IF;
  END P_GEN_ASNORDERPACKS_DATA;



  /*=================================================================================

    【正常使用】asnordersitem_itf 同步时更新
               t_orders.got_amount, t_ordersitem.got_amount

    用途:
      asnordersitem_itf 同步时更新 t_orders.got_amount, t_ordersitem.got_amount

    入参:
      V_ASNID            :  ASN单号
      V_COMPID           :  企业Id

     版本:
       2021-12-23: asnordersitem_itf 同步时更新
                   t_orders.got_amount, t_ordersitem.got_amount

  =================================================================================*/
  PROCEDURE P_UPDATE_ORDS_AND_ORDSITEM_GOTAMT(V_ASNID  IN VARCHAR2,
                                              V_COMPID IN VARCHAR2) IS
    V_ORDID   VARCHAR2(32);
    V_GOOID   VARCHAR2(32);
    V_GOTAMT  NUMBER(8);
  BEGIN
    FOR I IN (SELECT A.ORDER_ID, B.GOO_ID, B.BARCODE, B.ASNGOT_AMOUNT
                FROM SCMDATA.T_ASNORDERED A
                LEFT JOIN SCMDATA.T_ASNORDERSITEM B
                  ON A.ASN_ID = B.ASN_ID
                 AND A.COMPANY_ID = B.COMPANY_ID
               WHERE A.ASN_ID = V_ASNID
                 AND A.COMPANY_ID = V_COMPID) LOOP
      IF V_ORDID IS NULL THEN
        V_ORDID := I.ORDER_ID;
      END IF;

      IF V_GOOID IS NULL THEN
        V_GOOID := I.GOO_ID;
      END IF;

      UPDATE SCMDATA.T_ORDERSITEM
         SET GOT_AMOUNT = I.ASNGOT_AMOUNT
       WHERE ORDER_ID = I.ORDER_ID
         AND GOO_ID = I.GOO_ID
         AND BARCODE = I.BARCODE;
    END LOOP;

    SELECT SUM(NVL(GOT_AMOUNT,0))
      INTO V_GOTAMT
      FROM SCMDATA.T_ORDERSITEM
     WHERE ORDER_ID = V_ORDID;

    UPDATE SCMDATA.T_ORDERS
       SET GOT_AMOUNT = V_GOTAMT
     WHERE ORDER_ID = V_ORDID
       AND GOO_ID = V_GOOID
       AND COMPANY_ID = V_COMPID;

  END P_UPDATE_ORDS_AND_ORDSITEM_GOTAMT;



  /*=================================================================================

    【正常使用】 asnorders_itf 同步时更新收货记录

    用途:
      asnorders_itf 同步时更新收货记录

    入参:
      V_ASNID            :  ASN单号
      V_COMPID           :  企业Id

     版本:
       2021-12-23: asnorders_itf 同步时更新收货记录

  =================================================================================*/
  PROCEDURE P_SYNC_ORD_DELIVERY_REC(V_ASNID  IN VARCHAR2,
                                    V_COMPID IN VARCHAR2) IS
    PRAGMA AUTONOMOUS_TRANSACTION;
  BEGIN
    SCMDATA.PKG_INF_ASN.P_SYNC_DELIVERY_RECORD_BY_ASNORDER(P_ASN_ID => V_ASNID,
                                                           P_COMPANY_ID => V_COMPID);
    COMMIT;
  END P_SYNC_ORD_DELIVERY_REC;



  /*=================================================================================

    【正常使用】 asnordersitem_itf 同步时更新收货记录表

    用途:
      asnordersitem_itf 同步时更新收货记录表

    入参:
      V_ASNID    :  ASN单号
      V_GOOID    :  货号
      V_BARCODE  :  SKU条码
      V_COMPID   :  企业Id

     版本:
       2021-12-23: asnordersitem_itf 同步时更新收货记录表

  =================================================================================*/
  PROCEDURE P_SYNC_ORDSITEM_DELIVERY_REC(V_ASNID   IN VARCHAR2,
                                         V_GOOID   IN VARCHAR2,
                                         V_BARCODE IN VARCHAR2,
                                         V_COMPID  IN VARCHAR2) IS
    PRAGMA AUTONOMOUS_TRANSACTION;
    V_PEF  NUMBER(1);
  BEGIN
    SCMDATA.PKG_INF_ASN.P_SYNC_DELIVERY_RECORD_ITEM_BY_ASNORDERSITEM(P_ASN_ID     => V_ASNID,
                                                                     P_GOO_ID     => V_GOOID,
                                                                     P_COMPANY_ID => V_BARCODE,
                                                                     P_BARCODE    => V_COMPID,
                                                                     PO_ERROR_FLG => V_PEF);
    COMMIT;
  END P_SYNC_ORDSITEM_DELIVERY_REC;



  /*=================================================================================

    【正常使用】删除 ASNORDERSITEM.PCOME_AMOUNT = 0 的数据

    用途:
      将某一条 ASN 下 ASNORDERSITEM.PCOME_AMOUNT = 0 的数据删除，
      并且更新 ASNORDERS.ORDER_AMOUNT/PCOME_AMOUNT
            和 T_QA_REPORT.ORIGIN

    入参:


    版本:
      2022-01-12: 删除 ASNORDERSITEM.PCOME_AMOUNT = 0 的数据

  =================================================================================*/
  PROCEDURE P_DEL_PCOMEAMT_EQUALS_ZERO(V_ASNID   IN VARCHAR2,
                                       V_COMPID  IN VARCHAR2) IS
    V_ORDERAMTGOO  NUMBER(8);
    V_PCOMEAMTGOO  NUMBER(8);
    V_ASNGOTAMTGOO NUMBER(8);
    V_GOTAMTGOO    NUMBER(8);
    V_JUGNUM       NUMBER(1);
  BEGIN
    SELECT COUNT(1)
      INTO V_JUGNUM
      FROM SCMDATA.T_ASNORDERSITEM
     WHERE ASN_ID = V_ASNID
       AND COMPANY_ID = V_COMPID
       AND PCOME_AMOUNT = 0
       AND ROWNUM = 1;

    IF V_JUGNUM > 0 THEN
      FOR I IN (SELECT ASN_ID,GOO_ID,BARCODE,COMPANY_ID
                  FROM SCMDATA.T_ASNORDERSITEM
                 WHERE ASN_ID = V_ASNID
                   AND COMPANY_ID = V_COMPID
                   AND PCOME_AMOUNT = 0) LOOP
        DELETE FROM SCMDATA.T_ASNORDERSITEM
         WHERE ASN_ID = I.ASN_ID
           AND GOO_ID = I.GOO_ID
           AND BARCODE = I.BARCODE
           AND COMPANY_ID = I.COMPANY_ID
           AND PCOME_AMOUNT = 0;
      END LOOP;

      FOR L IN (SELECT DISTINCT ASN_ID, GOO_ID, COMPANY_ID
                  FROM SCMDATA.T_ASNORDERSITEM
                 WHERE ASN_ID = V_ASNID
                   AND COMPANY_ID = V_COMPID) LOOP
        SELECT SUM(ORDER_AMOUNT),
               SUM(PCOME_AMOUNT),
               SUM(ASNGOT_AMOUNT),
               SUM(GOT_AMOUNT)
          INTO V_ORDERAMTGOO, V_PCOMEAMTGOO, V_ASNGOTAMTGOO, V_GOTAMTGOO
          FROM SCMDATA.T_ASNORDERSITEM
         WHERE ASN_ID = L.ASN_ID
           AND GOO_ID = L.GOO_ID
           AND COMPANY_ID = L.COMPANY_ID;

        UPDATE SCMDATA.T_ASNORDERS
           SET ORDER_AMOUNT = V_ORDERAMTGOO,
               PCOME_AMOUNT = V_PCOMEAMTGOO,
               ASNGOT_AMOUNT = V_ASNGOTAMTGOO,
               GOT_AMOUNT = V_GOTAMTGOO
         WHERE ASN_ID = L.ASN_ID
           AND GOO_ID = L.GOO_ID
           AND COMPANY_ID = L.COMPANY_ID;
      END LOOP;

      FOR M IN (SELECT QA_REPORT_ID,COMPANY_ID,LISTAGG(ORIGIN,'/') ORIGINS
                  FROM SCMDATA.T_QA_SCOPE
                 WHERE ASN_ID = V_ASNID
                   AND COMPANY_ID = V_COMPID
                 GROUP BY QA_REPORT_ID,COMPANY_ID) LOOP
        UPDATE SCMDATA.T_QA_REPORT
           SET ORIGIN = REPLACE(M.ORIGINS,'质检','')||'质检'
         WHERE QA_REPORT_ID = M.QA_REPORT_ID
           AND COMPANY_ID = M.COMPANY_ID;
      END LOOP;
    ELSE
      FOR N IN (SELECT DISTINCT ASN_ID, GOO_ID, COMPANY_ID
                  FROM SCMDATA.T_ASNORDERSITEM
                 WHERE ASN_ID = V_ASNID
                   AND COMPANY_ID = V_COMPID) LOOP
        SELECT SUM(ORDER_AMOUNT),
               SUM(PCOME_AMOUNT),
               SUM(ASNGOT_AMOUNT),
               SUM(GOT_AMOUNT)
          INTO V_ORDERAMTGOO, V_PCOMEAMTGOO, V_ASNGOTAMTGOO, V_GOTAMTGOO
          FROM SCMDATA.T_ASNORDERSITEM
         WHERE ASN_ID = N.ASN_ID
           AND GOO_ID = N.GOO_ID
           AND COMPANY_ID = N.COMPANY_ID;

        UPDATE SCMDATA.T_ASNORDERS
           SET ORDER_AMOUNT = V_ORDERAMTGOO,
               PCOME_AMOUNT = V_PCOMEAMTGOO,
               ASNGOT_AMOUNT = V_ASNGOTAMTGOO,
               GOT_AMOUNT = V_GOTAMTGOO
         WHERE ASN_ID = N.ASN_ID
           AND GOO_ID = N.GOO_ID
           AND COMPANY_ID = N.COMPANY_ID;
      END LOOP;
    END IF;
  END P_DEL_PCOMEAMT_EQUALS_ZERO;

END PKG_ASN_INTERFACE;
/

