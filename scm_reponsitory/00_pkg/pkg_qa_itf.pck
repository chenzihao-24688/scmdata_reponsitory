CREATE OR REPLACE PACKAGE SCMDATA.pkg_qa_itf IS

  /*=============================================================================

     包：
       pkg_qa_itf(qa接口包)

     函数名:
       校验传入数据是否存在于 scmdata.t_asnordered_itf

     入参:
       v_inp_asnid   :  asn单号
       v_inp_compid  :  企业id

     返回值:
       number 类型: 0-不存在于 scmdata.t_asnordered_itf
                    1-存在于 scmdata.t_asnordered_itf

     版本:
       2022-11-11_zc314 : 校验传入数据是否存在于 scmdata.t_asnordered_itf

  ==============================================================================*/
  FUNCTION f_is_existsinasnordereditf(v_inp_asnid  IN VARCHAR2,
                                      v_inp_compid IN VARCHAR2) RETURN NUMBER;

  /*=============================================================================

     包：
       pkg_qa_itf(qa接口包)

     函数名:
       校验 Asn是否存在 sku级数据

     入参:
       v_inp_asnid   :  asn单号
       v_inp_compid  :  企业id

     返回值:
       number 类型: 0-不存在 sku级数据
                    1-存在 sku级数据

     版本:
       2022-11-21_zc314 : 校验 Asn是否存在 sku级数据

  ==============================================================================*/
  FUNCTION f_is_asnhasskuleveldata(v_inp_asnid  IN VARCHAR2,
                                   v_inp_compid IN VARCHAR2) RETURN NUMBER;

  /*=============================================================================

     包：
       pkg_qa_itf(qa接口包)

     函数名:
       校验传入数据是否存在于 scmdata.t_asnordered

     入参:
       v_inp_asnid   :  asn单号
       v_inp_compid  :  企业id

     返回值:
       number 类型: 0-不存在于 scmdata.t_asnordered
                    1-存在于 scmdata.t_asnordered

     版本:
       2022-11-11_zc314 : 校验传入数据是否存在于 scmdata.t_asnordered

  ==============================================================================*/
  FUNCTION f_is_existsinasnordered(v_inp_asnid  IN VARCHAR2,
                                   v_inp_compid IN VARCHAR2) RETURN NUMBER;

  /*=============================================================================

     包：
       pkg_qa_itf(qa接口包)

     函数名:
       校验传入 Asn 在系统中是否有对应订单

     入参:
       v_inp_asnid   :  asn单号
       v_inp_compid  :  企业id

     返回值:
       number 类型: 0-传入 Asn 在系统中没有对应订单
                    1-传入 Asn 在系统中没有对应订单

     版本:
       2022-11-11_zc314 : 校验传入 Asn 在系统中是否有对应订单

  ==============================================================================*/
  FUNCTION f_is_existsinordered(v_inp_asnid  IN VARCHAR2,
                                v_inp_compid IN VARCHAR2) RETURN NUMBER;

  /*=============================================================================

     包：
       pkg_qa_itf(qa接口包)

     函数名:
       校验传入数据是否存在于 scmdata.t_asnorders_itf

     入参:
       v_inp_asnid   :  asn单号
       v_inp_compid  :  企业id

     返回值:
       number 类型: 0-不存在于 scmdata.t_asnorders_itf
                    1-存在于 scmdata.t_asnorders_itf

     版本:
       2022-11-11_zc314 : 校验传入数据是否存在于 scmdata.t_asnorders_itf

  ==============================================================================*/
  FUNCTION f_is_existsinasnordersitf(v_inp_asnid  IN VARCHAR2,
                                     v_inp_compid IN VARCHAR2) RETURN NUMBER;

  /*=============================================================================

     包：
       pkg_qa_itf(qa接口包)

     函数名:
       校验传入数据是否存在于 scmdata.t_asnorders

     入参:
       v_inp_asnid   :  asn单号
       v_inp_compid  :  企业id

     返回值:
       number 类型: 0-不存在于 scmdata.t_asnorders
                    1-存在于 scmdata.t_asnorders

     版本:
       2022-11-11_zc314 : 校验传入数据是否存在于 scmdata.t_asnorders

  ==============================================================================*/
  FUNCTION f_is_existsinasnorders(v_inp_asnid  IN VARCHAR2,
                                  v_inp_compid IN VARCHAR2) RETURN NUMBER;

  /*=============================================================================

     包：
       pkg_qa_itf(qa接口包)

     函数名:
       校验传入数据是否存在于 scmdata.t_asnordersitem_itf

     入参:
       v_inp_asnid         :  Asn单号
       v_inp_relagooid     :  货号
       v_inp_barcode       :  条码
       v_inp_warehousepos  :  库位
       v_inp_compid        :  企业Id

     返回值:
       Number 类型: 0-不存在于 scmdata.t_asnordersitem_itf
                    1-存在于 scmdata.t_asnordersitem_itf

     版本:
       2022-11-11_zc314 : 校验传入数据是否存在于 scmdata.t_asnordersitem_itf

  ==============================================================================*/
  FUNCTION f_is_existsinasnordersitemitf(v_inp_asnid        IN VARCHAR2,
                                         v_inp_relagooid    IN VARCHAR2,
                                         v_inp_barcode      IN VARCHAR2,
                                         v_inp_warehousepos IN VARCHAR2,
                                         v_inp_compid       IN VARCHAR2)
    RETURN NUMBER;

  /*=============================================================================

     包：
       pkg_qa_itf(qa接口包)

     函数名:
       校验传入数据是否存在于 scmdata.t_asnordersitem

     入参:
       v_inp_asnid      :  Asn单号
       v_inp_relagooid  :  货号
       v_inp_barcode    :  条码
       v_inp_compid     :  企业id

     返回值:
       number 类型: 0-不存在于 scmdata.t_asnordersitem
                    1-存在于 scmdata.t_asnordersitem

     版本:
       2022-11-11_zc314 : 校验传入数据是否存在于 scmdata.t_asnordersitem

  ==============================================================================*/
  FUNCTION f_is_existsinasnordersitem(v_inp_asnid     IN VARCHAR2,
                                      v_inp_relagooid IN VARCHAR2,
                                      v_inp_barcode   IN VARCHAR2,
                                      v_inp_compid    IN VARCHAR2)
    RETURN NUMBER;

  /*=============================================================================

     包：
       pkg_qa_itf(qa接口包)

     函数名:
       校验是否存在于商品档案

     入参:
       v_inp_relagooid  :  货号
       v_inp_compid     :  企业id

     返回值:
       number 类型: 0-不存在于商品档案
                    1-存在于商品档案

     版本:
       2022-11-11_zc314 : 校验是否存在于商品档案

  ==============================================================================*/
  FUNCTION f_is_existsincommodityinfo(v_inp_relagooid IN VARCHAR2,
                                      v_inp_compid    IN VARCHAR2)
    RETURN NUMBER;

  /*=============================================================================

     包：
       pkg_qa_itf(qa接口包)

     函数名:
       校验是否存在于供应商档案

     入参:
       v_inp_supcode  :  内部供应商编码
       v_inp_compid   :  企业id

     返回值:
       number 类型: 0-不存在于供应商档案
                    1-存在于供应商档案

     版本:
       2022-11-11_zc314 : 校验是否存在于供应商档案

  ==============================================================================*/
  FUNCTION f_is_existsinsupplierinfo(v_inp_supcode IN VARCHAR2,
                                     v_inp_compid  IN VARCHAR2) RETURN NUMBER;

  /*=================================================================================

    包：
      pkg_qa_itf(qa接口包)

    函数名:
      获取 Asn 相关校验结果

    入参:
      v_inp_asnid      :  asn单号
      v_inp_relagooid  :  货号，可不填，填写则校验货号是否存在于商品档案中
      v_inp_barcode    :  sku条码，可不填，填写则生成对应的条件
      v_inp_compid     :  企业Id

    返回值:
      Clob 类型，Asn相关校验结果

     版本:
       2022-11-11 : 获取 Asn 相关校验结果

  =================================================================================*/
  FUNCTION f_get_asninfocheckresult(v_inp_asnid     IN VARCHAR2,
                                    v_inp_relagooid IN VARCHAR2 DEFAULT NULL,
                                    v_inp_barcode   IN VARCHAR2 DEFAULT NULL,
                                    v_inp_compid    IN VARCHAR2) RETURN CLOB;

  /*=============================================================================

     包：
       pkg_qa_itf(qa接口包)

     函数名:
       校验 Asnordersitem_itf 内特定 Asn条码库位是否为空

     入参:
       v_inp_asnid      :  Asn单号
       v_inp_relagooid  :  货号
       v_inp_barcode    :  条码
       v_inp_compid     :  企业id

     返回值:
       number 类型: 0-该Asn条码不存在为空的库位
                    1-该Asn条码存在为空的库位

     版本:
       2022-11-18_zc314 : 校验 Asnordersitem_itf 内特定 Asn条码库位是否为空

  ==============================================================================*/
  FUNCTION f_is_asnordersitemwarehouseposnull(v_inp_asnid     IN VARCHAR2,
                                              v_inp_relagooid IN VARCHAR2,
                                              v_inp_barcode   IN VARCHAR2,
                                              v_inp_compid    IN VARCHAR2)
    RETURN NUMBER;

  /*=================================================================================

    包：
      pkg_qa_itf(qa接口包)

    函数名:
      校验 Asnorderpacks 是否存在

    入参:
      v_inp_asnid          :  Asn单号
      v_inp_compid         :  企业Id
      v_inp_relagooid      :  货号
      v_inp_barcode        :  条码
      v_inp_packbarcode    :  收货标签条码

    返回值:
      Number 类型， 0-不存在于 Scmdata.t_asnorderpacks
                    1-存在于 Scmdata.t_asnorderpacks

     版本:
       2022-11-19: 校验 Asnorderpacks 是否存在

  =================================================================================*/
  FUNCTION f_is_asnorderpacksexists(v_inp_asnid       IN VARCHAR2,
                                    v_inp_compid      IN VARCHAR2,
                                    v_inp_relagooid   IN VARCHAR2,
                                    v_inp_barcode     IN VARCHAR2,
                                    v_inp_packbarcode IN VARCHAR2)
    RETURN NUMBER;

  /*=================================================================================

    包：
      pkg_qa_itf(qa接口包)

    函数名:
      校验 Asnorderpacks_itf 是否存在

    入参:
      v_inp_asnid          :  Asn单号
      v_inp_compid         :  企业Id
      v_inp_relagooid      :  货号
      v_inp_barcode        :  条码
      v_inp_packbarcode    :  收货标签条码

    返回值:
      Number 类型， 0-不存在于 Scmdata.t_asnorderpacks_itf
                    1-存在于 Scmdata.t_asnorderpacks_itf

     版本:
       2022-11-19: 校验 Asnorderpacks_itf 是否存在

  =================================================================================*/
  FUNCTION f_is_asnorderpacksitfexists(v_inp_asnid       IN VARCHAR2,
                                       v_inp_compid      IN VARCHAR2,
                                       v_inp_relagooid   IN VARCHAR2,
                                       v_inp_barcode     IN VARCHAR2,
                                       v_inp_packbarcode IN VARCHAR2)
    RETURN NUMBER;

  /*=============================================================================

     包：
       pkg_qa_itf(qa接口包)

     函数名:
       根据 Sku获取最新质检报告Id

     入参:
       v_inp_asnid    :  Asn单号
       v_inp_compid   :  企业Id
       v_inp_gooid    :  商品档案编号
       v_inp_barcode  :  条码

     版本:
       2022-11-19_ZC314 : 根据 Sku获取最新质检报告Id

  ==============================================================================*/
  FUNCTION f_get_latestqarepbysku(v_inp_asnid   IN VARCHAR2,
                                  v_inp_compid  IN VARCHAR2,
                                  v_inp_gooid   IN VARCHAR2 DEFAULT NULL,
                                  v_inp_barcode IN VARCHAR2 DEFAULT NULL)
    RETURN VARCHAR2;

  /*=============================================================================

     包：
       pkg_qa_itf(qa接口包)

     函数名:
       【Scm质检结果回传wms接口】获取 Sku质检减数

     入参:
       v_inp_qarepid  :  质检报告编号
       v_inp_compid   :  企业Id
       v_inp_asnid    :  Asn单号
       v_inp_gooid    :  商品档案编号
       v_inp_barcode  :  条码

     版本:
       2022-11-19_ZC314 : 获取 Sku质检减数

  ==============================================================================*/
  FUNCTION f_scmtwms_getskuqualdecreamount(v_inp_qarepid IN VARCHAR2,
                                           v_inp_compid  IN VARCHAR2,
                                           v_inp_asnid   IN VARCHAR2,
                                           v_inp_gooid   IN VARCHAR2,
                                           v_inp_barcode IN VARCHAR2)
    RETURN NUMBER;

  /*=============================================================================

     包：
       pkg_qa_itf(qa接口包)

     函数名:
       【Scm质检结果回传wms接口】获取 Sku已减减数

     入参:
       v_inp_asnid    :  Asn单号
       v_inp_compid   :  企业Id
       v_inp_gooid    :  商品档案编号
       v_inp_barcode  :  条码

     版本:
       2022-12-03_ZC314 : 获取 Sku已减减数

  ==============================================================================*/
  FUNCTION f_scmtwms_getskualqualdecreamount(v_inp_asnid   IN VARCHAR2,
                                             v_inp_compid  IN VARCHAR2,
                                             v_inp_gooid   IN VARCHAR2,
                                             v_inp_barcode IN VARCHAR2)
    RETURN NUMBER;

  /*=============================================================================

     包：
       pkg_qa_itf(qa接口包)

     函数名:
       【Scm质检结果回传wms接口】获取颜色已减减数

     入参:
       v_inp_asnid      :  Asn单号
       v_inp_compid     :  企业Id
       v_inp_colorname  :  颜色名称

     版本:
       2022-12-03_ZC314 : 获取颜色已减减数

  ==============================================================================*/
  FUNCTION f_scmtwms_getcoloralqualdecreamount(v_inp_asnid     IN VARCHAR2,
                                               v_inp_compid    IN VARCHAR2,
                                               v_inp_colorname IN VARCHAR2)
    RETURN NUMBER;

  /*=============================================================================

     包：
       pkg_qa_itf(qa接口包)

     函数名:
       校验 Asn 是否存在于 Asnordersitem_itf 中

     入参:
       v_inp_asnid    :  Asn单号
       v_inp_compid   :  企业Id

     版本:
       2022-11-30_ZC314 : 校验 Asn 是否存在于 Asnordersitem_itf 中

  ==============================================================================*/
  FUNCTION f_is_asnexistsinasnordersitemitf(v_inp_asnid  IN VARCHAR2,
                                            v_inp_compid IN VARCHAR2)
    RETURN NUMBER;

  /*=================================================================================

    包：
      pkg_qa_itf(qa接口包)

    函数名:
      判断 Asn 条码是否包含【*】

    入参:
      v_inp_asnid   :  Asn单号
      v_inp_compid  :  企业Id

     版本:
       2022-12-03: 判断 Asn 条码是否包含【*】

  =================================================================================*/
  FUNCTION f_is_asnbarcodeincludestar(v_inp_asnid  IN VARCHAR2,
                                      v_inp_compid IN VARCHAR2) RETURN NUMBER;

  /*=================================================================================

    包：
      pkg_qa_itf(qa接口包)

    过程名:
      【质检任务接口】更新 QaAsn质检信息是否完整字段

    入参:
      v_inp_asnid   :  Asn单号
      v_inp_compid  :  企业Id

     版本:
       2022-11-21: 更新 QaAsn质检信息是否完整字段

  =================================================================================*/
  PROCEDURE p_qamission_isqaasninfocompleteupd(v_inp_asnid  IN VARCHAR2,
                                               v_inp_compid IN VARCHAR2);

  /*=================================================================================

    包：
      pkg_qa_itf(qa接口包)

    过程名:
      orderchange变更导致 t_qa_report_relainfodim.sho_id变更

    入参:
      v_inp_ordid   :  订单号
      v_inp_compid  :  企业id

     版本:
       2023-01-17: orderchange变更导致 t_qa_report_relainfodim.sho_id变更

  =================================================================================*/
  PROCEDURE p_shoid_qarelashoidupd(v_inp_ordid  IN VARCHAR2,
                                   v_inp_compid IN VARCHAR2);

  /*=================================================================================

    包：
      pkg_qa_itf(qa接口包)

    过程名:
      刷新 Asn接口表数据状态与错误信息

    版本:
      2023-01-10: 刷新 Asn接口表数据状态与错误信息

  =================================================================================*/
  PROCEDURE p_cerefresh_asnitfcerefresh;

  /*=================================================================================

    包：
      pkg_qa_itf(qa接口包)

    过程名:
      【质检任务接口】接入wms待质检 asnordered 数据到接口表

    入参:
      v_inp_asnid      :  asn单号
      v_inp_compid     :  企业id
      v_inp_orderid    :  订单号
      v_inp_supcode    :  供应商编号
      v_inp_pcomedate  :  预计到仓日期
      v_inp_pcomeinter :  预计到仓时段
      v_inp_scantime   :  扫描时间
      v_inp_memo       :  备注

     版本:
       2022-11-11: 接入wms待质检 asnordered 数据到接口表

  =================================================================================*/
  PROCEDURE p_qamission_asnordereditfins(v_inp_asnid      IN VARCHAR2,
                                         v_inp_compid     IN VARCHAR2,
                                         v_inp_orderid    IN VARCHAR2,
                                         v_inp_supcode    IN VARCHAR2,
                                         v_inp_pcomedate  IN VARCHAR2,
                                         v_inp_pcomeinter IN VARCHAR2,
                                         v_inp_scantime   IN VARCHAR2,
                                         v_inp_memo       IN VARCHAR2);

  /*=================================================================================

    包：
      pkg_qa_itf(qa接口包)

    过程名:
      【质检任务接口】接入wms待质检 asnordered 数据到接口表

    入参:
      v_inp_asnid         :  asn单号
      v_inp_compid        :  企业id
      v_inp_relagooid     :  货号
      v_inp_orderamount   :  订货数量
      v_inp_pcomeamount   :  预计到仓数量
      v_inp_asngotamount  :  asn预计到仓数量
      v_inp_gotamount     :  预计到仓数量
      v_inp_memo          :  备注

     版本:
       2022-11-17: 接入wms待质检 asnordered 数据到接口表

  =================================================================================*/
  PROCEDURE p_qamission_asnordersitfins(v_inp_asnid        IN VARCHAR2,
                                        v_inp_compid       IN VARCHAR2,
                                        v_inp_relagooid    IN VARCHAR2,
                                        v_inp_orderamount  IN NUMBER,
                                        v_inp_pcomeamount  IN NUMBER,
                                        v_inp_asngotamount IN NUMBER,
                                        v_inp_gotamount    IN NUMBER,
                                        v_inp_memo         IN VARCHAR2);

  /*=================================================================================

    包：
      pkg_qa_itf(qa接口包)

    过程名:
      【质检任务接口】接入wms待质检 asnordersitem 数据到接口表

    入参:
      v_inp_asnid         :  asn单号
      v_inp_compid        :  企业id
      v_inp_relagooid     :  货号
      v_inp_barcode       :  条码
      v_inp_warehousepos  :  库位
      v_inp_orderamount   :  订货数量
      v_inp_pcomeamount   :  预计到仓数量
      v_inp_asngotamount  :  asn预计到仓数量
      v_inp_gotamount     :  预计到仓数量
      v_inp_memo          :  备注
      v_inp_colorname     :  颜色名称

     版本:
       2022-11-17: 接入wms待质检 asnordersitem 数据到接口表

  =================================================================================*/
  PROCEDURE p_qamission_asnordersitemitfins(v_inp_asnid        IN VARCHAR2,
                                            v_inp_compid       IN VARCHAR2,
                                            v_inp_relagooid    IN VARCHAR2,
                                            v_inp_barcode      IN VARCHAR2,
                                            v_inp_warehousepos IN VARCHAR2,
                                            v_inp_orderamount  IN NUMBER,
                                            v_inp_pcomeamount  IN NUMBER,
                                            v_inp_asngotamount IN NUMBER,
                                            v_inp_gotamount    IN NUMBER,
                                            v_inp_colorname    IN VARCHAR2,
                                            v_inp_memo         IN VARCHAR2);

  /*=================================================================================

    包：
      pkg_qa_itf(qa接口包)

    过程名:
      【质检任务接口】Qa质检任务 Asnordered 数据同步

    入参:
      v_inp_portstatus  :  接口状态

     版本:
       2022-11-17: Qa质检任务 Asnordered 数据同步

  =================================================================================*/
  PROCEDURE p_qamission_asnorderedsync(v_inp_portstatus IN VARCHAR2);

  /*=================================================================================

    包：
      pkg_qa_itf(qa接口包)

    过程名:
      【质检任务接口】Qa质检任务 Asnorders 数据同步

    入参:
      v_inp_portstatus  :  接口状态

     版本:
       2022-11-17: Qa质检任务 Asnorders 数据同步

  =================================================================================*/
  PROCEDURE p_qamission_asnorderssync(v_inp_portstatus IN VARCHAR2);

  /*=================================================================================

    包：
      pkg_qa_itf(qa接口包)

    过程名:
      【质检任务接口】Qa质检任务 Asnordersitem 数据同步

    入参:
      v_inp_portstatus  :  接口状态

     版本:
       2022-11-17: Qa质检任务 Asnordersitem 数据同步

  =================================================================================*/
  PROCEDURE p_qamission_asnordersitemsync(v_inp_portstatus IN VARCHAR2);

  /*=============================================================================

     包：
       pkg_qa_itf(qa接口包)

     过程名:
       根据 asn 刷新 Qa质检报告 Sku不合格数量

     入参:
       v_inp_asnid       :  Asn单号
       v_inp_compid      :  企业Id
       v_inp_curuserid   :  当前操作人Id
       v_inp_invokeobj   :  调用对象

     版本:
       2023-01-17_zc314 : 根据 asn 刷新 Qa质检报告 Sku不合格数量

  ==============================================================================*/
  PROCEDURE p_receiveinfo_updqarepskuunqualamountbyasn(v_inp_asnid     IN VARCHAR2,
                                                       v_inp_compid    IN VARCHAR2,
                                                       v_inp_invokeobj IN VARCHAR2);

  /*=================================================================================

    包：
      pkg_qa_itf(qa接口包)

    过程名:
      【上架信息更新接口】更新 asnordered 上架信息到接口表

    入参:
      v_inp_asnid    :  asn单号
      v_inp_compid   :  企业id
      v_inp_sctime   :  到仓扫描时间
      v_inp_cgtimes  :  变更次数
      v_inp_pcdate   :  预计到仓日期
      v_inp_pcintval :  预计到仓时段

     版本:
       2022-11-17: 更新 asnordered 上架信息到接口表

  =================================================================================*/
  PROCEDURE p_receiveinfo_asnordereditfupd(v_inp_asnid    IN VARCHAR2,
                                           v_inp_compid   IN VARCHAR2,
                                           v_inp_sctime   IN VARCHAR2,
                                           v_inp_cgtimes  IN NUMBER,
                                           v_inp_pcdate   IN VARCHAR2,
                                           v_inp_pcintval IN VARCHAR2);

  /*=================================================================================

    包：
      pkg_qa_itf(qa接口包)

    过程名:
      【上架信息更新接口】接入 wms-asnorders 上架信息到接口表

    入参：
      v_inp_asnid         :   asn单号
      v_inp_compid        :   企业id
      v_inp_relagooid     :   货号
      v_inp_asngotamount  :   Asn到货量
      v_inp_gotamount     :   到货量
      v_inp_retamount     :   退货量
      v_inp_picktime      :   分拣时间
      v_inp_shipmenttime  :   发货时间
      v_inp_warehousepos  :   库位

    版本:
      2022-11-17: 接入 wms-asnorders 上架信息到接口表

  =================================================================================*/
  PROCEDURE p_receiveinfo_asnordersitfupd(v_inp_asnid        IN VARCHAR2,
                                          v_inp_compid       IN VARCHAR2,
                                          v_inp_relagooid    IN VARCHAR2,
                                          v_inp_asngotamount IN NUMBER,
                                          v_inp_gotamount    IN NUMBER,
                                          v_inp_retamount    IN NUMBER,
                                          v_inp_picktime     IN VARCHAR2,
                                          v_inp_receivetime  IN VARCHAR2,
                                          v_inp_shipmenttime IN VARCHAR2,
                                          v_inp_warehousepos IN VARCHAR2);

  /*=================================================================================

    包：
      pkg_qa_itf(qa接口包)

    过程名:
      【上架信息更新接口】接入 wms-asnordersitem 收获信息到接口表

    入参:
      v_inp_asnid         :  asn单号
      v_inp_compid        :  企业id
      v_inp_relagooid     :  货号
      v_inp_barcode       :  条码
      v_inp_asngotamount  :  预到货收货量
      v_inp_gotamount     :  到货量
      v_inp_retamount     :  退货量
      v_inp_picktime      :  分拣时间
      v_inp_shipmenttime  :  发货时间
      v_inp_receivetime   :  收货时间
      v_inp_warehousepos  :  库位

    版本:
      2022-11-18: 接入 wms-asnordersitem 收获信息到接口表

  =================================================================================*/
  PROCEDURE p_receiveinfo_asnordersitemitfupd(v_inp_asnid        IN VARCHAR2,
                                              v_inp_compid       IN VARCHAR2,
                                              v_inp_relagooid    IN VARCHAR2,
                                              v_inp_barcode      IN VARCHAR2,
                                              v_inp_asngotamount IN NUMBER,
                                              v_inp_gotamount    IN NUMBER,
                                              v_inp_retamount    IN NUMBER,
                                              v_inp_picktime     IN VARCHAR2,
                                              v_inp_shipmenttime IN VARCHAR2,
                                              v_inp_receivetime  IN VARCHAR2,
                                              v_inp_warehousepos IN VARCHAR2);

  /*=================================================================================

    包：
      pkg_qa_itf(qa接口包)

    过程名:
      【上架信息更新接口】 Asnordered 上架信息同步

    入参:
      v_inp_portstatus  :  接口状态

     版本:
       2022-11-18: Asnordered 上架信息同步

  =================================================================================*/
  PROCEDURE p_receiveinfo_asnorderedsync(v_inp_portstatus IN VARCHAR2);

  /*=================================================================================

    包：
      pkg_qa_itf(qa接口包)

    过程名:
      【上架信息更新接口】 Asnorders 上架信息刷新

    入参:
      v_inp_portstatus  :  接口状态

     版本:
       2022-12-01: Asnorders 上架信息刷新

  =================================================================================*/
  PROCEDURE p_receiveinfo_asnordersitfupdrefresh(v_inp_asnid  IN VARCHAR2,
                                                 v_inp_compid IN VARCHAR2);

  /*=================================================================================

    包：
      pkg_qa_itf(qa接口包)

    过程名:
      【上架信息更新接口】 Asnorders 上架信息同步

    入参:
      v_inp_portstatus  :  接口状态

     版本:
       2022-11-18: Asnorders 上架信息同步

  =================================================================================*/
  PROCEDURE p_receiveinfo_asnorderssync(v_inp_portstatus IN VARCHAR2);

  /*=================================================================================

    包：
      pkg_qa_itf(qa接口包)

    过程名:
      【上架信息更新接口】 Asnordersitem 上架信息刷新

    入参:
      v_inp_portstatus  :  接口状态

     版本:
       2022-12-01: Asnordersitem 上架信息刷新

  =================================================================================*/
  PROCEDURE p_receiveinfo_asnordersitemitfupdrefresh(v_inp_asnid   IN VARCHAR2,
                                                     v_inp_gooid   IN VARCHAR2,
                                                     v_inp_barcode IN VARCHAR2,
                                                     v_inp_compid  IN VARCHAR2);

  /*=================================================================================

    包：
      pkg_qa_itf(qa接口包)

    过程名:
      【上架信息更新接口】 Asnordersitem 上架信息同步

    入参:
      v_inp_portstatus  :  接口状态

     版本:
       2022-11-18: Asnordersitem 上架信息同步

  =================================================================================*/
  PROCEDURE p_receiveinfo_asnordersitemsync(v_inp_portstatus IN VARCHAR2);

  /*=================================================================================

    包：
      pkg_qa_itf(qa接口包)

    过程名:
      【Asn结束接口】Asn结束

    入参:
      v_inp_asnid       :  Asn单号
      v_inp_compid      :  企业Id
      v_inp_isfinished  :  是否结束 0-未结束 1-已结束

     版本:
       2022-11-17: Qa质检任务 Asnorders 数据同步

  =================================================================================*/
  PROCEDURE p_asnfinish_asnorderedupd(v_inp_asnid      IN VARCHAR2,
                                      v_inp_compid     IN VARCHAR2,
                                      v_inp_isfinished IN NUMBER);

  /*=================================================================================

    包：
      pkg_qa_itf(qa接口包)

    过程名:
      【asnorderpacks接口】 asnorderpacks 对 t_qa_pretranstowms 刷新

    入参:
      v_inp_asnid   :  asn单号
      v_inp_compid  :  企业id

     版本:
       2023-01-20: asnorderpacks 对 t_qa_pretranstowms 刷新

  =================================================================================*/
  PROCEDURE p_asnorderpacks_refreshpretransinfo(v_inp_asnid  IN VARCHAR2,
                                                v_inp_compid IN VARCHAR2);

  /*=================================================================================

    包：
      pkg_qa_itf(qa接口包)

    过程名:
      【Asnorderpacks接口】 Asnorderpacks增改

    入参:
      v_inp_asnid          :  Asn单号
      v_inp_compid         :  企业Id
      v_inp_operatorid     :  操作人Id
      v_inp_relagooid      :  货号
      v_inp_goodsid        :  货号/条码，货号为空取条码
      v_inp_barcode        :  条码
      v_inp_packfno        :  包序号
      v_inp_packbarcode    :  收货标签条码
      v_inp_packsno        :  总箱数序号
      v_inp_packcount      :  总箱数
      v_inp_packamount     :  包装数量
      v_inp_skupackno      :  sku序号
      v_inp_skupackcount   :  sku总箱数
      v_inp_skunumber      :  sku数量
      v_inp_ratioid        :  配码比
      v_inp_packspecssend  :  送货包装规格
      v_inp_memo           :  备注

     版本:
       2022-11-19: Asnorderpacks增改

  =================================================================================*/
  PROCEDURE p_asnorderpacks_iuasnorderpacksitf(v_inp_asnid         IN VARCHAR2,
                                               v_inp_compid        IN VARCHAR2,
                                               v_inp_operatorid    IN VARCHAR2,
                                               v_inp_relagooid     IN VARCHAR2,
                                               v_inp_goodsid       IN VARCHAR2,
                                               v_inp_barcode       IN VARCHAR2,
                                               v_inp_packfno       IN VARCHAR2,
                                               v_inp_packbarcode   IN VARCHAR2,
                                               v_inp_packsno       IN NUMBER,
                                               v_inp_packcount     IN NUMBER,
                                               v_inp_packamount    IN NUMBER,
                                               v_inp_skupackno     IN NUMBER,
                                               v_inp_skupackcount  IN NUMBER,
                                               v_inp_skunumber     IN NUMBER,
                                               v_inp_ratioid       IN NUMBER,
                                               v_inp_packspecssend IN NUMBER,
                                               v_inp_memo          IN VARCHAR2);

  /*=================================================================================

    包：
      pkg_qa_itf(qa接口包)

    过程名:
      【Asnorderpacks接口】 Asnorderpacks增改

    入参:
      v_inp_asnid          :  Asn单号
      v_inp_compid         :  企业Id
      v_inp_operatorid     :  操作人Id
      v_inp_relagooid      :  货号
      v_inp_goodsid        :  货号/条码，货号为空取条码
      v_inp_barcode        :  条码
      v_inp_packfno        :  包序号
      v_inp_packbarcode    :  收货标签条码
      v_inp_packsno        :  总箱数序号
      v_inp_packcount      :  总箱数
      v_inp_packamount     :  包装数量
      v_inp_skupackno      :  sku序号
      v_inp_skupackcount   :  sku总箱数
      v_inp_skunumber      :  sku数量
      v_inp_ratioid        :  配码比
      v_inp_packspecssend  :  送货包装规格
      v_inp_memo           :  备注

     版本:
       2022-11-19: Asnorderpacks增改

  =================================================================================*/
  PROCEDURE p_asnorderpacks_asnorderpacksitfsync;

  /*=================================================================================

    包：
      pkg_qa_itf(qa接口包)

    过程名:
      【Scm质检结果传给Wms接口】根据质检报告 Asn分配次品

    入参:
      v_inp_qarepid  :  质检报告Id
      v_inp_asnid    :  Asn单号
      v_inp_compid   :  企业Id

     版本:
       2022-12-05: 根据质检报告 Asn分配次品

  =================================================================================*/
  PROCEDURE p_scmtwms_allocatedsubsamountbyrepasn(v_inp_qarepid IN VARCHAR2,
                                                  v_inp_asnid   IN VARCHAR2,
                                                  v_inp_compid  IN VARCHAR2);

  /*=================================================================================

    包：
      pkg_qa_itf(qa接口包)

    过程名:
      【Scm质检结果传给Wms接口】根据质检报告 Sku分配次品

    入参:
      v_inp_qarepid  :  质检报告Id
      v_inp_asnid    :  Asn单号
      v_inp_gooid    :  商品档案编号
      v_inp_barcode  :  条码
      v_inp_compid   :  企业Id

     版本:
       2022-12-05: 根据质检报告 Sku分配次品

  =================================================================================*/
  PROCEDURE p_scmtwms_allocatedsubsamountbyrepsku(v_inp_qarepid IN VARCHAR2,
                                                  v_inp_asnid   IN VARCHAR2,
                                                  v_inp_gooid   IN VARCHAR2,
                                                  v_inp_barcode IN VARCHAR2,
                                                  v_inp_compid  IN VARCHAR2);

  /*=================================================================================

    包：
      pkg_qa_itf(qa接口包)

    过程名:
      次品分配逻辑

    入参:
      v_inp_qarepid  :  质检报告Id
      v_inp_asnid    :  Asn单号
      v_inp_gooid    :  商品档案编号
      v_inp_barcode  :  条码
      v_inp_compid   :  企业Id

     版本:
       2022-12-05 : 次品分配逻辑

  =================================================================================*/
  PROCEDURE p_allocated_subsamount(v_inp_qarepid IN VARCHAR2,
                                   v_inp_asnid   IN VARCHAR2,
                                   v_inp_compid  IN VARCHAR2,
                                   v_inp_gooid   IN VARCHAR2 DEFAULT NULL,
                                   v_inp_barcode IN VARCHAR2 DEFAULT NULL);

  /*=================================================================================

    包：
      pkg_qa_itf(qa接口包)

    过程名:
      【Scm质检结果传给Wms接口】获取asn级回传数据字段

    入参:
      v_inp_asnid   :  Asn单号
      v_inp_compid  :  企业Id

     版本:
       2022-11-23: 获取asn级回传数据字段

  =================================================================================*/
  FUNCTION f_scmtwms_getasnlevelinfo(v_inp_asnid  IN VARCHAR2,
                                     v_inp_compid IN VARCHAR2) RETURN CLOB;

  /*=================================================================================

    包：
      pkg_qa_itf(qa接口包)

    过程名:
      【Scm质检结果传给Wms接口】根据 Asn获取 Sku级回传数据字段

    入参:
      v_inp_asnid   :  Asn单号
      v_inp_compid  :  企业Id

     版本:
       2022-11-24: 根据 Asn获取 Sku级回传数据字段

  =================================================================================*/
  FUNCTION f_scmtwms_getskulevelinfobyasn(v_inp_asnid  IN VARCHAR2,
                                          v_inp_compid IN VARCHAR2)
    RETURN CLOB;

  /*=================================================================================

    包：
      pkg_qa_itf(qa接口包)

    过程名:
      【Scm质检结果传给Wms接口】根据 Sku获取 Sku级回传数据字段

    入参:
      v_inp_asnid    :  Asn单号
      v_inp_compid   :  企业Id
      v_inp_gooid    :  商品档案编号
      v_inp_barcode  :  条码

     版本:
       2022-11-24: 根据 Sku获取 Sku级回传数据字段

  =================================================================================*/
  FUNCTION f_scmtwms_getskulevelinfobysku(v_inp_asnid   IN VARCHAR2,
                                          v_inp_compid  IN VARCHAR2,
                                          v_inp_gooid   IN VARCHAR2,
                                          v_inp_barcode IN VARCHAR2)
    RETURN CLOB;

  /*=================================================================================

    包：
      pkg_qa_itf(qa接口包)

    过程名:
      【Scm质检结果传给Wms接口】获取特定asn回传数据

    入参:
      v_inp_asnid   :  Asn单号
      v_inp_compid  :  企业Id

     版本:
       2022-11-24: 获取特定asn回传数据

  =================================================================================*/
  FUNCTION f_scmtwms_getasntransinfo(v_inp_asnid  IN VARCHAR2,
                                     v_inp_compid IN VARCHAR2) RETURN CLOB;

  /*=================================================================================

    包：
      pkg_qa_itf(qa接口包)

    过程名:
      【Scm质检结果传给Wms接口】获取特定 Sku回传数据

    入参:
      v_inp_asnid    :  Asn单号
      v_inp_compid   :  企业Id
      v_inp_gooid    :  商品档案编号
      v_inp_barcode  :  条码

     版本:
       2022-11-24: 获取特定 Sku回传数据

  =================================================================================*/
  FUNCTION f_scmtwms_getskutransinfo(v_inp_asnid   IN VARCHAR2,
                                     v_inp_compid  IN VARCHAR2,
                                     v_inp_gooid   IN VARCHAR2,
                                     v_inp_barcode IN VARCHAR2) RETURN CLOB;

  /*=================================================================================

    包：
      pkg_qa_itf(qa接口包)

    过程名:
      【Scm质检结果传给Wms接口】获取免检回传数据

    入参:
      v_inp_asnid    :  Asn单号
      v_inp_compid   :  企业Id

     版本:
       2022-12-06: 获取免检回传数据

  =================================================================================*/
  FUNCTION f_scmtwms_getaetransinfo(v_inp_asnid  IN VARCHAR2,
                                    v_inp_compid IN VARCHAR2) RETURN CLOB;

  /*=================================================================================

    包：
      pkg_qa_itf(qa接口包)

    过程名:
      【Scm质检结果传给Wms接口】获取按 Asn回传前5行的回传数据

     版本:
       2022-12-06: 获取按 Asn回传前5行的回传数据

  =================================================================================*/
  FUNCTION f_scmtwms_get5rowsasntransinfo RETURN CLOB;

  /*=================================================================================

    包：
      pkg_qa_itf(qa接口包)

    过程名:
      【Scm质检结果传给Wms接口】获取按 Sku回传前15行的回传数据

     版本:
       2022-12-06: 获取按 Sku回传前15行的回传数据

  =================================================================================*/
  FUNCTION f_scmtwms_get5rowsskutransinfo RETURN CLOB;

  /*=================================================================================

    包：
      pkg_qa_itf(qa接口包)

    过程名:
      【Wms质检结果传给Scm接口】校验待传入 wms 质检数据是否
                                存在于 scmdata.t_qa_wmsresult_itf中

    入参:
      v_inp_asnid      :  asn单号
      v_inp_compid     :  企业id
      v_inp_relagooid  :  货号
      v_inp_barcodes   :  条码

    返回值:
      Number 类型 : 等于0，不存在于 scmdata.t_qa_wmsresult_itf 中，
                    等于1，存在于 scmdata.t_qa_wmsresult_itf 中

     版本:
       2022-11-25: 校验待传入 wms 质检数据是否
                   存在于 scmdata.t_qa_wmsresult_itf中

  =================================================================================*/
  FUNCTION f_wmstscm_checkwmsresultexists(v_inp_asnid     IN VARCHAR2,
                                          v_inp_compid    IN VARCHAR2,
                                          v_inp_relagooid IN VARCHAR2,
                                          v_inp_barcode   IN VARCHAR2)
    RETURN NUMBER;

  /*=================================================================================

    包：
      pkg_qa_itf(qa接口包)

    过程名:
      【Wms质检结果传给Scm接口】接入wms质检信息

    入参：
      v_inp_asnid             :  asn单号
      v_inp_relagooid         :  货号
      v_inp_comfirmresult     :  质检确认结果
      v_inp_barcodes          :  条码
      v_inp_skucomfirmresult  :  sku质检确认结果
      v_inp_eobjid            :  执行对象id
      v_inp_compid            :  企业id

    版本:
      2022-11-25: 接入wms质检信息，存入 scmdata.t_qa_wmsresult_itf 用于生成报告

  =================================================================================*/
  PROCEDURE p_wmstscm_qawmsresultitfinsorupd(v_inp_asnid            IN VARCHAR2,
                                             v_inp_relagooid        IN VARCHAR2,
                                             v_inp_comfirmresult    IN VARCHAR2,
                                             v_inp_barcodes         IN VARCHAR2,
                                             v_inp_skucomfirmresult IN VARCHAR2,
                                             v_inp_eobjid           IN VARCHAR2,
                                             v_inp_compid           IN VARCHAR2);

  /*=============================================================================

     包：
       pkg_qa_itf(qa接口包)

     过程名:
       【Wms质检结果传给Scm接口】Wms质检结果同步

     入参:
       v_inp_compid  :  企业Id

     版本:
       2022-12-07_ZC314 : Wms质检结果同步

  ==============================================================================*/
  PROCEDURE p_wmstscm_qawmsresultitfsync(v_inp_compid IN VARCHAR2);

  /*=============================================================================

     包：
       pkg_qa_itf(qa接口包)

     函数名:
       【Wms质检结果传给Scm接口】获取 Sku/Good 所有质检报告Id

     入参:
       v_inp_asnid    :  Asn单号
       v_inp_gooid    :  商品档案编号
       v_inp_barcode  :  条码
       v_inp_compid   :  企业Id

     返回值:
       Clob 类型，报告级质检结果

     版本:
       2022-12-06_ZC314 : 获取 Sku/Good 所有质检报告Id

  ==============================================================================*/
  FUNCTION f_wmstscm_getskugoodallqarepid(v_inp_asnid   IN VARCHAR2,
                                          v_inp_compid  IN VARCHAR2,
                                          v_inp_gooid   IN VARCHAR2 DEFAULT NULL,
                                          v_inp_barcode IN VARCHAR2 DEFAULT NULL)
    RETURN CLOB;

  /*=============================================================================

     包：
       pkg_qa_itf(qa接口包)

     过程名:
       【Wms质检结果传给Scm接口】刷新质检报告数据源

     入参:
       v_inp_qarepidclob  :  质检报告编号，多值由分号分割
       v_inp_compid       :  企业Id

     版本:
       2022-12-06_ZC314 : 刷新质检报告数据源

  ==============================================================================*/
  PROCEDURE p_wmstscm_refreshrelaqarepdatasource(v_inp_qarepidclob IN CLOB,
                                                 v_inp_compid      IN VARCHAR2);

  /*=============================================================================

     包：
       pkg_qa_itf(qa接口包)

     过程名:
       【Wms质检结果传给Scm接口】生成质检报告时，刷新报告wms质检确认数据

     入参:
       v_inp_asnids  :  Asn单号，多值用分号分隔
       v_inp_compid  :  企业Id

     版本:
       2022-12-07_ZC314 : 生成质检报告时，刷新报告wms质检确认数据

  ==============================================================================*/
  PROCEDURE p_wmstscm_refreshwmsresultwhengenqarep(v_inp_asnids IN CLOB,
                                                   v_inp_compid IN VARCHAR2);

END pkg_qa_itf;
/

CREATE OR REPLACE PACKAGE BODY SCMDATA.pkg_qa_itf IS

  /*=============================================================================

     包：
       pkg_qa_itf(qa接口包)

     函数名:
       校验传入数据是否存在于 scmdata.t_asnordered_itf

     入参:
       v_inp_asnid   :  asn单号
       v_inp_compid  :  企业id

     返回值:
       number 类型: 0-不存在于 scmdata.t_asnordered_itf
                    1-存在于 scmdata.t_asnordered_itf

     版本:
       2022-11-11_zc314 : 校验传入数据是否存在于 scmdata.t_asnordered_itf

  ==============================================================================*/
  FUNCTION f_is_existsinasnordereditf(v_inp_asnid  IN VARCHAR2,
                                      v_inp_compid IN VARCHAR2) RETURN NUMBER IS
    v_jugnum NUMBER(1);
  BEGIN
    SELECT nvl(MAX(1), 0)
      INTO v_jugnum
      FROM scmdata.t_asnordered_itf
     WHERE asn_id = v_inp_asnid
       AND company_id = v_inp_compid
       AND rownum = 1;

    RETURN v_jugnum;
  END f_is_existsinasnordereditf;

  /*=============================================================================

     包：
       pkg_qa_itf(qa接口包)

     函数名:
       校验 asn是否存在 sku级数据

     入参:
       v_inp_asnid   :  asn单号
       v_inp_compid  :  企业id

     返回值:
       number 类型: 0-不存在 sku级数据
                    1-存在 sku级数据

     版本:
       2022-11-21_zc314 : 校验 asn是否存在 sku级数据

  ==============================================================================*/
  FUNCTION f_is_asnhasskuleveldata(v_inp_asnid  IN VARCHAR2,
                                   v_inp_compid IN VARCHAR2) RETURN NUMBER IS
    v_jugnum NUMBER(1);
  BEGIN
    SELECT nvl(MAX(1), 0)
      INTO v_jugnum
      FROM scmdata.t_asnordersitem_itf
     WHERE asn_id = v_inp_asnid
       AND company_id = v_inp_compid
       AND rownum = 1;

    RETURN v_jugnum;
  END f_is_asnhasskuleveldata;

  /*=============================================================================

     包：
       pkg_qa_itf(qa接口包)

     函数名:
       校验传入数据是否存在于 scmdata.t_asnordered

     入参:
       v_inp_asnid   :  asn单号
       v_inp_compid  :  企业id

     返回值:
       number 类型: 0-不存在于 scmdata.t_asnordered
                    1-存在于 scmdata.t_asnordered

     版本:
       2022-11-11_zc314 : 校验传入数据是否存在于 scmdata.t_asnordered

  ==============================================================================*/
  FUNCTION f_is_existsinasnordered(v_inp_asnid  IN VARCHAR2,
                                   v_inp_compid IN VARCHAR2) RETURN NUMBER IS
    v_jugnum NUMBER(1);
  BEGIN
    SELECT nvl(MAX(1), 0)
      INTO v_jugnum
      FROM scmdata.t_asnordered
     WHERE asn_id = v_inp_asnid
       AND company_id = v_inp_compid
       AND rownum = 1;

    RETURN v_jugnum;
  END f_is_existsinasnordered;

  /*=============================================================================

     包：
       pkg_qa_itf(qa接口包)

     函数名:
       校验传入 asn 在系统中是否有对应订单

     入参:
       v_inp_asnid   :  asn单号
       v_inp_compid  :  企业id

     返回值:
       number 类型: 0-传入 asn 在系统中没有对应订单
                    1-传入 asn 在系统中没有对应订单

     版本:
       2022-11-11_zc314 : 校验传入 asn 在系统中是否有对应订单

  ==============================================================================*/
  FUNCTION f_is_existsinordered(v_inp_asnid  IN VARCHAR2,
                                v_inp_compid IN VARCHAR2) RETURN NUMBER IS
    v_jugnum NUMBER(1);
  BEGIN
    SELECT nvl(MAX(1), 0)
      INTO v_jugnum
      FROM scmdata.t_ordered orded
     WHERE EXISTS (SELECT 1
              FROM scmdata.t_asnordered
             WHERE asn_id = v_inp_asnid
               AND company_id = v_inp_compid
               AND order_id = orded.order_code
               AND company_id = orded.company_id);

    RETURN v_jugnum;
  END f_is_existsinordered;

  /*=============================================================================

     包：
       pkg_qa_itf(qa接口包)

     函数名:
       校验传入数据是否存在于 scmdata.t_asnorders_itf

     入参:
       v_inp_asnid   :  asn单号
       v_inp_compid  :  企业id

     返回值:
       number 类型: 0-不存在于 scmdata.t_asnorders_itf
                    1-存在于 scmdata.t_asnorders_itf

     版本:
       2022-11-11_zc314 : 校验传入数据是否存在于 scmdata.t_asnorders_itf

  ==============================================================================*/
  FUNCTION f_is_existsinasnordersitf(v_inp_asnid  IN VARCHAR2,
                                     v_inp_compid IN VARCHAR2) RETURN NUMBER IS
    v_jugnum NUMBER(1);
  BEGIN
    SELECT nvl(MAX(1), 0)
      INTO v_jugnum
      FROM scmdata.t_asnorders_itf
     WHERE asn_id = v_inp_asnid
       AND company_id = v_inp_compid
       AND rownum = 1;

    RETURN v_jugnum;
  END f_is_existsinasnordersitf;

  /*=============================================================================

     包：
       pkg_qa_itf(qa接口包)

     函数名:
       校验传入数据是否存在于 scmdata.t_asnorders

     入参:
       v_inp_asnid   :  asn单号
       v_inp_compid  :  企业id

     返回值:
       number 类型: 0-不存在于 scmdata.t_asnorders
                    1-存在于 scmdata.t_asnorders

     版本:
       2022-11-11_zc314 : 校验传入数据是否存在于 scmdata.t_asnorders

  ==============================================================================*/
  FUNCTION f_is_existsinasnorders(v_inp_asnid  IN VARCHAR2,
                                  v_inp_compid IN VARCHAR2) RETURN NUMBER IS
    v_jugnum NUMBER(1);
  BEGIN
    SELECT nvl(MAX(1), 0)
      INTO v_jugnum
      FROM scmdata.t_asnorders
     WHERE asn_id = v_inp_asnid
       AND company_id = v_inp_compid
       AND rownum = 1;

    RETURN v_jugnum;
  END f_is_existsinasnorders;

  /*=============================================================================

     包：
       pkg_qa_itf(qa接口包)

     函数名:
       校验传入数据是否存在于 scmdata.t_asnordersitem_itf

     入参:
       v_inp_asnid         :  asn单号
       v_inp_relagooid     :  货号
       v_inp_barcode       :  条码
       v_inp_warehousepos  :  库位
       v_inp_compid        :  企业id

     返回值:
       number 类型: 0-不存在于 scmdata.t_asnordersitem_itf
                    1-存在于 scmdata.t_asnordersitem_itf

     版本:
       2022-11-11_zc314 : 校验传入数据是否存在于 scmdata.t_asnordersitem_itf

  ==============================================================================*/
  FUNCTION f_is_existsinasnordersitemitf(v_inp_asnid        IN VARCHAR2,
                                         v_inp_relagooid    IN VARCHAR2,
                                         v_inp_barcode      IN VARCHAR2,
                                         v_inp_warehousepos IN VARCHAR2,
                                         v_inp_compid       IN VARCHAR2)
    RETURN NUMBER IS
    v_jugnum NUMBER(1);
  BEGIN
    SELECT nvl(MAX(1), 0)
      INTO v_jugnum
      FROM scmdata.t_asnordersitem_itf
     WHERE asn_id = v_inp_asnid
       AND goo_id = v_inp_relagooid
       AND nvl(barcode, ' ') = nvl(v_inp_barcode, ' ')
       AND nvl(warehouse_pos, ' ') = nvl(v_inp_warehousepos, ' ')
       AND company_id = v_inp_compid
       AND rownum = 1;

    RETURN v_jugnum;
  END f_is_existsinasnordersitemitf;

  /*=============================================================================

     包：
       pkg_qa_itf(qa接口包)

     函数名:
       校验传入数据是否存在于 scmdata.t_asnordersitem

     入参:
       v_inp_asnid      :  asn单号
       v_inp_relagooid  :  货号
       v_inp_barcode    :  条码
       v_inp_compid     :  企业id

     返回值:
       number 类型: 0-不存在于 scmdata.t_asnordersitem
                    1-存在于 scmdata.t_asnordersitem

     版本:
       2022-11-11_zc314 : 校验传入数据是否存在于 scmdata.t_asnordersitem

  ==============================================================================*/
  FUNCTION f_is_existsinasnordersitem(v_inp_asnid     IN VARCHAR2,
                                      v_inp_relagooid IN VARCHAR2,
                                      v_inp_barcode   IN VARCHAR2,
                                      v_inp_compid    IN VARCHAR2)
    RETURN NUMBER IS
    v_jugnum NUMBER(1);
    v_gooid  VARCHAR2(32);
  BEGIN
    SELECT MAX(goo_id)
      INTO v_gooid
      FROM scmdata.t_commodity_info
     WHERE rela_goo_id = v_inp_relagooid
       AND company_id = v_inp_compid;

    SELECT nvl(MAX(1), 0)
      INTO v_jugnum
      FROM scmdata.t_asnordersitem
     WHERE asn_id = v_inp_asnid
       AND goo_id = v_gooid
       AND nvl(barcode, ' ') = nvl(v_inp_barcode, ' ')
       AND company_id = v_inp_compid
       AND rownum = 1;

    RETURN v_jugnum;
  END f_is_existsinasnordersitem;

  /*=============================================================================

     包：
       pkg_qa_itf(qa接口包)

     函数名:
       校验是否存在于商品档案

     入参:
       v_inp_relagooid  :  货号
       v_inp_compid     :  企业id

     返回值:
       number 类型: 0-不存在于商品档案
                    1-存在于商品档案

     版本:
       2022-11-11_zc314 : 校验是否存在于商品档案

  ==============================================================================*/
  FUNCTION f_is_existsincommodityinfo(v_inp_relagooid IN VARCHAR2,
                                      v_inp_compid    IN VARCHAR2)
    RETURN NUMBER IS
    v_jugnum NUMBER(1);
  BEGIN
    SELECT nvl(MAX(1), 0)
      INTO v_jugnum
      FROM scmdata.t_commodity_info
     WHERE rela_goo_id = v_inp_relagooid
       AND company_id = v_inp_compid
       AND rownum = 1;

    RETURN v_jugnum;
  END f_is_existsincommodityinfo;

  /*=============================================================================

     包：
       pkg_qa_itf(qa接口包)

     函数名:
       校验是否存在于供应商档案

     入参:
       v_inp_supcode  :  内部供应商编码
       v_inp_compid   :  企业id

     返回值:
       number 类型: 0-不存在于供应商档案
                    1-存在于供应商档案

     版本:
       2022-11-11_zc314 : 校验是否存在于供应商档案

  ==============================================================================*/
  FUNCTION f_is_existsinsupplierinfo(v_inp_supcode IN VARCHAR2,
                                     v_inp_compid  IN VARCHAR2) RETURN NUMBER IS
    v_jugnum NUMBER(1);
  BEGIN
    SELECT nvl(MAX(1), 0)
      INTO v_jugnum
      FROM scmdata.t_supplier_info
     WHERE inside_supplier_code = v_inp_supcode
       AND company_id = v_inp_compid
       AND rownum = 1;

    RETURN v_jugnum;
  END f_is_existsinsupplierinfo;

  /*=================================================================================

    包：
      pkg_qa_itf(qa接口包)

    函数名:
      获取 asn 相关校验结果

    入参:
      v_inp_asnid      :  asn单号
      v_inp_relagooid  :  货号，可不填，填写则校验货号是否存在于商品档案中
      v_inp_barcode    :  sku条码，可不填，填写则生成对应的条件
      v_inp_compid     :  企业id

    返回值:
      clob 类型，asn相关校验结果

     版本:
       2022-11-11 : 获取 asn 相关校验结果

  =================================================================================*/
  FUNCTION f_get_asninfocheckresult(v_inp_asnid     IN VARCHAR2,
                                    v_inp_relagooid IN VARCHAR2 DEFAULT NULL,
                                    v_inp_barcode   IN VARCHAR2 DEFAULT NULL,
                                    v_inp_compid    IN VARCHAR2) RETURN CLOB IS
    v_jugnum  NUMBER(1);
    v_errinfo CLOB;
  BEGIN
    --是否存在 asnorders
    v_jugnum := f_is_existsinasnorders(v_inp_asnid  => v_inp_asnid,
                                       v_inp_compid => v_inp_compid);

    --不存在 asnordered
    IF v_jugnum = 0 THEN
      v_errinfo := scmdata.f_sentence_append_rc(v_sentence   => v_errinfo,
                                                v_appendstr  => 'Asn: ' ||
                                                                v_inp_asnid ||
                                                                ' Asnorders未接入',
                                                v_middliestr => chr(10));
    END IF;

    IF v_inp_barcode IS NOT NULL THEN
      --是否存在 asnordersitem
      v_jugnum := f_is_existsinasnordersitem(v_inp_asnid     => v_inp_asnid,
                                             v_inp_relagooid => v_inp_relagooid,
                                             v_inp_barcode   => v_inp_barcode,
                                             v_inp_compid    => v_inp_compid);

      --不存在 asnordersitem
      IF v_jugnum = 0 THEN
        v_errinfo := scmdata.f_sentence_append_rc(v_sentence   => v_errinfo,
                                                  v_appendstr  => 'Asn: ' ||
                                                                  v_inp_asnid ||
                                                                  ' Asnordersitem未接入',
                                                  v_middliestr => chr(10));
      END IF;
    END IF;

    --是否存在 asnordered
    v_jugnum := f_is_existsinasnordered(v_inp_asnid  => v_inp_asnid,
                                        v_inp_compid => v_inp_compid);

    --不存在 asnordered
    IF v_jugnum = 0 THEN
      v_errinfo := scmdata.f_sentence_append_rc(v_sentence   => v_errinfo,
                                                v_appendstr  => 'Asn: ' ||
                                                                v_inp_asnid ||
                                                                ' Asnordered未接入',
                                                v_middliestr => chr(10));

    ELSE
      --是否存在对应订单
      v_jugnum := f_is_existsinordered(v_inp_asnid  => v_inp_asnid,
                                       v_inp_compid => v_inp_compid);

      --不存在订单
      IF v_jugnum = 0 THEN
        v_errinfo := scmdata.f_sentence_append_rc(v_sentence   => v_errinfo,
                                                  v_appendstr  => 'Asn: ' ||
                                                                  v_inp_asnid ||
                                                                  ' 订单未接入',
                                                  v_middliestr => chr(10));
      END IF;
    END IF;

    --是否存在于商品档案
    IF v_inp_relagooid IS NOT NULL THEN
      v_jugnum := f_is_existsincommodityinfo(v_inp_relagooid => v_inp_relagooid,
                                             v_inp_compid    => v_inp_compid);

      IF v_jugnum = 0 THEN
        v_errinfo := scmdata.f_sentence_append_rc(v_sentence   => v_errinfo,
                                                  v_appendstr  => '货号: ' ||
                                                                  v_inp_relagooid ||
                                                                  ' 不存在于商品档案',
                                                  v_middliestr => chr(10));
      END IF;
    END IF;

    RETURN v_errinfo;
  END f_get_asninfocheckresult;

  /*=============================================================================

     包：
       pkg_qa_itf(qa接口包)

     函数名:
       校验 asnordersitem_itf 内特定 asn条码库位是否为空

     入参:
       v_inp_asnid      :  asn单号
       v_inp_relagooid  :  货号
       v_inp_barcode    :  条码
       v_inp_compid     :  企业id

     返回值:
       number 类型: 0-该asn条码不存在为空的库位
                    1-该asn条码存在为空的库位

     版本:
       2022-11-18_zc314 : 校验 asnordersitem_itf 内特定 asn条码库位是否为空

  ==============================================================================*/
  FUNCTION f_is_asnordersitemwarehouseposnull(v_inp_asnid     IN VARCHAR2,
                                              v_inp_relagooid IN VARCHAR2,
                                              v_inp_barcode   IN VARCHAR2,
                                              v_inp_compid    IN VARCHAR2)
    RETURN NUMBER IS
    v_jugnum NUMBER(1);
  BEGIN
    SELECT nvl(MAX(1), 0)
      INTO v_jugnum
      FROM scmdata.t_asnordersitem_itf
     WHERE asn_id = v_inp_asnid
       AND goo_id = v_inp_relagooid
       AND nvl(barcode, ' ') = nvl(v_inp_barcode, ' ')
       AND warehouse_pos = ' '
       AND company_id = v_inp_compid
       AND rownum = 1;

    RETURN v_jugnum;
  END f_is_asnordersitemwarehouseposnull;

  /*=================================================================================

    包：
      pkg_qa_itf(qa接口包)

    函数名:
      校验 asnorderpacks 是否存在

    入参:
      v_inp_asnid          :  asn单号
      v_inp_compid         :  企业id
      v_inp_relagooid      :  货号
      v_inp_barcode        :  条码
      v_inp_packbarcode    :  收货标签条码

    返回值:
      number 类型， 0-不存在于 scmdata.t_asnorderpacks
                    1-存在于 scmdata.t_asnorderpacks

     版本:
       2022-11-19: 校验 asnorderpacks 是否存在

  =================================================================================*/
  FUNCTION f_is_asnorderpacksexists(v_inp_asnid       IN VARCHAR2,
                                    v_inp_compid      IN VARCHAR2,
                                    v_inp_relagooid   IN VARCHAR2,
                                    v_inp_barcode     IN VARCHAR2,
                                    v_inp_packbarcode IN VARCHAR2)
    RETURN NUMBER IS
    v_gooid  VARCHAR2(32);
    v_jugnum NUMBER(1);
  BEGIN
    SELECT MAX(goo_id)
      INTO v_gooid
      FROM scmdata.t_commodity_info
     WHERE rela_goo_id = v_inp_relagooid
       AND company_id = v_inp_compid;

    SELECT nvl(MAX(1), 0)
      INTO v_jugnum
      FROM scmdata.t_asnorderpacks
     WHERE asn_id = v_inp_asnid
       AND goo_id = v_gooid
       AND nvl(barcode, ' ') = nvl(v_inp_barcode, ' ')
       AND pack_barcode = v_inp_packbarcode
       AND company_id = v_inp_compid
       AND rownum = 1;

    RETURN v_jugnum;
  END f_is_asnorderpacksexists;

  /*=================================================================================

    包：
      pkg_qa_itf(qa接口包)

    函数名:
      校验 asnorderpacks_itf 是否存在

    入参:
      v_inp_asnid          :  asn单号
      v_inp_compid         :  企业id
      v_inp_relagooid      :  货号
      v_inp_barcode        :  条码
      v_inp_packbarcode    :  收货标签条码

    返回值:
      number 类型， 0-不存在于 scmdata.t_asnorderpacks_itf
                    1-存在于 scmdata.t_asnorderpacks_itf

     版本:
       2022-11-19: 校验 asnorderpacks_itf 是否存在

  =================================================================================*/
  FUNCTION f_is_asnorderpacksitfexists(v_inp_asnid       IN VARCHAR2,
                                       v_inp_compid      IN VARCHAR2,
                                       v_inp_relagooid   IN VARCHAR2,
                                       v_inp_barcode     IN VARCHAR2,
                                       v_inp_packbarcode IN VARCHAR2)
    RETURN NUMBER IS
    v_jugnum NUMBER(1);
  BEGIN
    SELECT nvl(MAX(1), 0)
      INTO v_jugnum
      FROM scmdata.t_asnorderpacks_itf
     WHERE asn_id = v_inp_asnid
       AND goo_id = v_inp_relagooid
       AND nvl(barcode, ' ') = nvl(v_inp_barcode, ' ')
       AND pack_barcode = v_inp_packbarcode
       AND company_id = v_inp_compid
       AND rownum = 1;

    RETURN v_jugnum;
  END f_is_asnorderpacksitfexists;

  /*=============================================================================

     包：
       pkg_qa_itf(qa接口包)

     函数名:
       根据 sku获取最新质检报告id

     入参:
       v_inp_asnid    :  asn单号
       v_inp_compid   :  企业id
       v_inp_gooid    :  商品档案编号
       v_inp_barcode  :  条码

     版本:
       2022-11-19_zc314 : 根据 sku获取最新质检报告id

  ==============================================================================*/
  FUNCTION f_get_latestqarepbysku(v_inp_asnid   IN VARCHAR2,
                                  v_inp_compid  IN VARCHAR2,
                                  v_inp_gooid   IN VARCHAR2 DEFAULT NULL,
                                  v_inp_barcode IN VARCHAR2 DEFAULT NULL)
    RETURN VARCHAR2 IS
    v_qarepid VARCHAR2(32);
  BEGIN
    IF v_inp_barcode IS NOT NULL THEN
      SELECT MAX(qa_report_id)
        INTO v_qarepid
        FROM (SELECT qa_report_id
                FROM scmdata.t_qa_report_skudim
               WHERE status = 'AF'
                 AND asn_id = v_inp_asnid
                 AND goo_id = v_inp_gooid
                 AND nvl(barcode, ' ') = nvl(v_inp_barcode, ' ')
                 AND company_id = v_inp_compid
               ORDER BY qualfinish_time DESC
               FETCH FIRST 1 rows ONLY);
    ELSE
      SELECT MAX(qa_report_id)
        INTO v_qarepid
        FROM (SELECT qa_report_id
                FROM scmdata.t_qa_report_skudim
               WHERE status = 'AF'
                 AND asn_id = v_inp_asnid
                 AND company_id = v_inp_compid
               ORDER BY qualfinish_time DESC
               FETCH FIRST 1 rows ONLY);
    END IF;

    RETURN v_qarepid;
  END f_get_latestqarepbysku;

  /*=============================================================================

     包：
       pkg_qa_itf(qa接口包)

     函数名:
       【scm质检结果回传wms接口】获取 sku质检减数

     入参:
       v_inp_qarepid  :  质检报告编号
       v_inp_compid   :  企业id
       v_inp_asnid    :  asn单号
       v_inp_gooid    :  商品档案编号
       v_inp_barcode  :  条码

     版本:
       2022-11-19_zc314 : 获取 sku质检减数

  ==============================================================================*/
  FUNCTION f_scmtwms_getskuqualdecreamount(v_inp_qarepid IN VARCHAR2,
                                           v_inp_compid  IN VARCHAR2,
                                           v_inp_asnid   IN VARCHAR2,
                                           v_inp_gooid   IN VARCHAR2,
                                           v_inp_barcode IN VARCHAR2)
    RETURN NUMBER IS
    v_qualdecreamount NUMBER(8);
  BEGIN
    SELECT MAX(CASE
                 WHEN nvl(got_amount, 0) > nvl(qualdecrease_amount, 0) THEN
                  nvl(qualdecrease_amount, 0)
                 WHEN nvl(got_amount, 0) <= nvl(qualdecrease_amount, 0) THEN
                  nvl(got_amount, 0)
               END)
      INTO v_qualdecreamount
      FROM scmdata.t_qa_report_skudim
     WHERE qa_report_id = v_inp_qarepid
       AND company_id = v_inp_compid
       AND asn_id = v_inp_asnid
       AND goo_id = v_inp_gooid
       AND nvl(barcode, ' ') = nvl(v_inp_barcode, ' ')
       AND receive_time IS NOT NULL;

    RETURN v_qualdecreamount;
  END f_scmtwms_getskuqualdecreamount;

  /*=============================================================================

     包：
       pkg_qa_itf(qa接口包)

     函数名:
       【scm质检结果回传wms接口】获取 sku已减减数

     入参:
       v_inp_asnid    :  asn单号
       v_inp_compid   :  企业id
       v_inp_gooid    :  商品档案编号
       v_inp_barcode  :  条码

     版本:
       2022-12-03_zc314 : 获取 sku已减减数

  ==============================================================================*/
  FUNCTION f_scmtwms_getskualqualdecreamount(v_inp_asnid   IN VARCHAR2,
                                             v_inp_compid  IN VARCHAR2,
                                             v_inp_gooid   IN VARCHAR2,
                                             v_inp_barcode IN VARCHAR2)
    RETURN NUMBER IS
    v_alqualdecreamount NUMBER(8);
  BEGIN
    SELECT SUM(nvl(subs_amount, 0))
      INTO v_alqualdecreamount
      FROM scmdata.t_asnorderpacks
     WHERE asn_id = v_inp_asnid
       AND company_id = v_inp_compid
       AND goo_id = v_inp_gooid
       AND nvl(barcode, ' ') = nvl(v_inp_barcode, ' ');

    RETURN v_alqualdecreamount;
  END f_scmtwms_getskualqualdecreamount;

  /*=============================================================================

     包：
       pkg_qa_itf(qa接口包)

     函数名:
       【scm质检结果回传wms接口】获取颜色已减减数

     入参:
       v_inp_asnid      :  asn单号
       v_inp_compid     :  企业id
       v_inp_colorname  :  颜色名称

     版本:
       2022-12-03_zc314 : 获取颜色已减减数

  ==============================================================================*/
  FUNCTION f_scmtwms_getcoloralqualdecreamount(v_inp_asnid     IN VARCHAR2,
                                               v_inp_compid    IN VARCHAR2,
                                               v_inp_colorname IN VARCHAR2)
    RETURN NUMBER IS
    v_alsubsnum NUMBER(8);
  BEGIN
    SELECT COUNT(DISTINCT packs.pack_barcode)
      INTO v_alsubsnum
      FROM scmdata.t_asnorderpacks packs
     INNER JOIN scmdata.t_commodity_color_size colorsize
        ON packs.goo_id = colorsize.goo_id
       AND nvl(packs.barcode, ' ') = nvl(colorsize.barcode, ' ')
       AND packs.company_id = colorsize.company_id
     WHERE packs.asn_id = v_inp_asnid
       AND colorsize.colorname = v_inp_colorname
       AND packs.company_id = v_inp_compid
       AND packs.subs_amount > 0
       AND EXISTS (SELECT 1
              FROM scmdata.t_asnordersitem_itf
             WHERE asn_id = packs.asn_id
               AND company_id = packs.company_id
               AND instr(barcode, '*') > 0);

    RETURN v_alsubsnum;
  END f_scmtwms_getcoloralqualdecreamount;

  /*=============================================================================

     包：
       pkg_qa_itf(qa接口包)

     函数名:
       校验 asn 是否存在于 asnordersitem_itf 中

     入参:
       v_inp_asnid    :  asn单号
       v_inp_compid   :  企业id

     版本:
       2022-11-30_zc314 : 校验 asn 是否存在于 asnordersitem_itf 中

  ==============================================================================*/
  FUNCTION f_is_asnexistsinasnordersitemitf(v_inp_asnid  IN VARCHAR2,
                                            v_inp_compid IN VARCHAR2)
    RETURN NUMBER IS
    v_jugnum NUMBER(1);
  BEGIN
    SELECT nvl(MAX(1), 0)
      INTO v_jugnum
      FROM scmdata.t_asnordersitem_itf
     WHERE asn_id = v_inp_asnid
       AND company_id = v_inp_compid
       AND rownum = 1;

    RETURN v_jugnum;
  END f_is_asnexistsinasnordersitemitf;

  /*=================================================================================

    包：
      pkg_qa_itf(qa接口包)

    函数名:
      判断 asn 条码是否包含【*】

    入参:
      v_inp_asnid   :  asn单号
      v_inp_compid  :  企业id

     版本:
       2022-12-03: 判断 asn 条码是否包含【*】

  =================================================================================*/
  FUNCTION f_is_asnbarcodeincludestar(v_inp_asnid  IN VARCHAR2,
                                      v_inp_compid IN VARCHAR2) RETURN NUMBER IS
    v_jugnum NUMBER(1);
  BEGIN
    SELECT MAX(CASE
                 WHEN instr(barcode, '*') > 0 THEN
                  1
                 ELSE
                  0
               END)
      INTO v_jugnum
      FROM scmdata.t_asnordersitem_itf
     WHERE asn_id = v_inp_asnid
       AND company_id = v_inp_compid;

    RETURN v_jugnum;
  END f_is_asnbarcodeincludestar;

  /*=================================================================================

    包：
      pkg_qa_itf(qa接口包)

    过程名:
      刷新 asn接口表数据状态与错误信息

    版本:
      2023-01-10: 刷新 asn接口表数据状态与错误信息

  =================================================================================*/
  PROCEDURE p_cerefresh_asnitfcerefresh IS
    v_errinfo CLOB;
    v_status  VARCHAR2(8);
  BEGIN
    --asnordered_itf 错误数据状态刷新
    FOR i IN (SELECT asn_id, company_id
                FROM scmdata.t_asnordered_itf
               WHERE port_status = 'CE'
                 AND port_time >= trunc(SYSDATE) - 2) LOOP
      --错误信息赋值
      v_errinfo := f_get_asninfocheckresult(v_inp_asnid  => i.asn_id,
                                            v_inp_compid => i.company_id);

      --根据错误信息对状态赋值
      IF v_errinfo IS NOT NULL THEN
        v_status := 'CE';
      ELSE
        v_status := 'SP';
      END IF;

      --更新接口状态及错误信息
      BEGIN
        UPDATE scmdata.t_asnordered_itf
           SET port_status = v_status, err_info = v_errinfo
         WHERE asn_id = i.asn_id
           AND company_id = i.company_id;
      EXCEPTION
        WHEN OTHERS THEN
          v_errinfo := NULL;
          v_status  := NULL;
      END;
    END LOOP;

    --asnorders_itf 错误数据刷新
    FOR l IN (SELECT asn_id, company_id, goo_id
                FROM scmdata.t_asnorders_itf
               WHERE port_status = 'CE'
                 AND port_time >= trunc(SYSDATE) - 2) LOOP
      --错误信息赋值
      v_errinfo := f_get_asninfocheckresult(v_inp_asnid     => l.asn_id,
                                            v_inp_relagooid => l.goo_id,
                                            v_inp_compid    => l.company_id);

      --根据错误信息对状态赋值
      IF v_errinfo IS NOT NULL THEN
        v_status := 'CE';
      ELSE
        v_status := 'SP';
      END IF;

      --更新接口状态及错误信息
      BEGIN
        UPDATE scmdata.t_asnorders_itf
           SET port_status = v_status, err_info = v_errinfo
         WHERE asn_id = l.asn_id
           AND company_id = l.company_id;
      EXCEPTION
        WHEN OTHERS THEN
          v_errinfo := NULL;
          v_status  := NULL;
      END;
    END LOOP;

    --asnordersitem_itf 错误数据刷新
    FOR m IN (SELECT DISTINCT asn_id, company_id, goo_id, barcode
                FROM scmdata.t_asnordersitem_itf
               WHERE port_status = 'CE'
                 AND port_time >= trunc(SYSDATE) - 2) LOOP
      --错误信息赋值
      v_errinfo := f_get_asninfocheckresult(v_inp_asnid     => m.asn_id,
                                            v_inp_relagooid => m.goo_id,
                                            v_inp_barcode   => m.barcode,
                                            v_inp_compid    => m.company_id);

      --根据错误信息对状态赋值
      IF v_errinfo IS NOT NULL THEN
        v_status := 'CE';
      ELSE
        v_status := 'SP';
      END IF;

      --更新接口状态及错误信息
      BEGIN
        UPDATE scmdata.t_asnordersitem_itf
           SET port_status = v_status, err_info = v_errinfo
         WHERE asn_id = m.asn_id
           AND goo_id = m.goo_id
           AND nvl(barcode, ' ') = nvl(m.barcode, ' ')
           AND company_id = m.company_id;
      EXCEPTION
        WHEN OTHERS THEN
          v_errinfo := NULL;
          v_status  := NULL;
      END;
    END LOOP;
  END p_cerefresh_asnitfcerefresh;

  /*=================================================================================

    包：
      pkg_qa_itf(qa接口包)

    过程名:
      orderchange变更导致 t_qa_report_relainfodim.sho_id变更

    入参:
      v_inp_ordid   :  订单号
      v_inp_compid  :  企业id

     版本:
       2023-01-17: orderchange变更导致 t_qa_report_relainfodim.sho_id变更

  =================================================================================*/
  PROCEDURE p_shoid_qarelashoidupd(v_inp_ordid  IN VARCHAR2,
                                   v_inp_compid IN VARCHAR2) IS
    v_shoid   VARCHAR2(8);
    v_sql     CLOB;
    v_sqlerrm CLOB;
    v_errinfo CLOB;
  BEGIN
    --获取订单仓库
    SELECT MAX(sho_id)
      INTO v_shoid
      FROM scmdata.t_ordered
     WHERE order_code = v_inp_ordid
       AND company_id = v_inp_compid;

    --执行 sql 赋值
    v_sql := 'UPDATE scmdata.t_qa_report_relainfodim
     SET sho_id = :v_shoid
   WHERE order_id = :v_inp_ordid
     AND company_id = :v_inp_compid';

    --执行 sql
    EXECUTE IMMEDIATE v_sql
      USING v_shoid, v_inp_ordid, v_inp_compid;
  EXCEPTION
    WHEN OTHERS THEN
      --错误堆栈记录
      v_sqlerrm := substr(dbms_utility.format_error_stack, 1, 1024);
      --错误信息记录
      v_errinfo := 'Error Object: scmdata.pkg_qa_itf.p_shoid_qarelashoidupd' ||
                   chr(10) || 'Error Info: ' || v_sqlerrm || chr(10) ||
                   'Execute_sql:' || v_sql || chr(10) || 'Params: ' ||
                   chr(10) || 'v_inp_ordid: ' || v_inp_ordid || chr(10) ||
                   'v_inp_compid: ' || v_inp_compid || chr(10) ||
                   'v_shoid: ' || v_shoid;

      --新增进入错误信息表
      scmdata.pkg_qa_ee.p_ins_errrecord_at(v_inp_errprogram     => 'scmdata.pkg_qa_itf.p_shoid_qarelashoidupd',
                                           v_inp_causeerruserid => 'shoidchange_upd_qarelashoid',
                                           v_inp_erroccurtime   => SYSDATE,
                                           v_inp_errinfo        => v_errinfo,
                                           v_inp_compid         => v_inp_compid);
  END p_shoid_qarelashoidupd;

  /*=================================================================================

    包：
      pkg_qa_itf(qa接口包)

    过程名:
      【质检任务接口】更新 qaasn质检信息是否完整字段

    入参:
      v_inp_asnid   :  asn单号
      v_inp_compid  :  企业id

     版本:
       2022-11-21: 更新 qaasn质检信息是否完整字段

  =================================================================================*/
  PROCEDURE p_qamission_isqaasninfocompleteupd(v_inp_asnid  IN VARCHAR2,
                                               v_inp_compid IN VARCHAR2) IS
    v_edjugnum   NUMBER(1);
    v_sjugnum    NUMBER(1);
    v_itemjugnum NUMBER(1);
  BEGIN
    SELECT MIN(CASE
                 WHEN ed.asn_id IS NULL THEN
                  0
                 ELSE
                  1
               END)
      INTO v_edjugnum
      FROM scmdata.t_asnordered_itf editf
      LEFT JOIN scmdata.t_asnordered ed
        ON editf.asn_id = ed.asn_id
       AND editf.company_id = ed.company_id
     WHERE editf.asn_id = v_inp_asnid
       AND editf.company_id = v_inp_compid;

    SELECT MIN(CASE
                 WHEN s.asn_id IS NULL THEN
                  0
                 ELSE
                  1
               END)
      INTO v_sjugnum
      FROM scmdata.t_asnorders_itf sitf
     INNER JOIN scmdata.t_commodity_info goo
        ON sitf.goo_id = goo.rela_goo_id
       AND sitf.company_id = goo.company_id
      LEFT JOIN scmdata.t_asnorders s
        ON sitf.asn_id = s.asn_id
       AND goo.goo_id = s.goo_id
       AND sitf.company_id = s.company_id
     WHERE sitf.asn_id = v_inp_asnid
       AND sitf.company_id = v_inp_compid;

    SELECT MIN(CASE
                 WHEN itemitf.asn_id IS NULL THEN
                  0
                 ELSE
                  1
               END)
      INTO v_itemjugnum
      FROM scmdata.t_asnordersitem_itf itemitf
     INNER JOIN scmdata.t_commodity_info goo
        ON itemitf.goo_id = goo.rela_goo_id
       AND itemitf.company_id = goo.company_id
      LEFT JOIN scmdata.t_asnordersitem item
        ON itemitf.asn_id = item.asn_id
       AND goo.goo_id = item.goo_id
       AND itemitf.barcode = item.barcode
       AND itemitf.company_id = item.company_id
     WHERE itemitf.asn_id = v_inp_asnid
       AND itemitf.company_id = v_inp_compid;

    IF v_edjugnum = 1 AND v_sjugnum = 1 AND v_itemjugnum = 1 THEN
      UPDATE scmdata.t_asnordered
         SET is_qaasninfocomplete = 1
       WHERE asn_id = v_inp_asnid
         AND company_id = v_inp_compid;
    END IF;
  END p_qamission_isqaasninfocompleteupd;

  /*=================================================================================

    包：
      pkg_qa_itf(qa接口包)

    过程名:
      【质检任务接口】接入wms待质检 asnordered 数据到接口表

    入参:
      v_inp_asnid      :  asn单号
      v_inp_compid     :  企业id
      v_inp_orderid    :  订单号
      v_inp_supcode    :  供应商编号
      v_inp_pcomedate  :  预计到仓日期
      v_inp_pcomeinter :  预计到仓时段
      v_inp_scantime   :  扫描时间
      v_inp_memo       :  备注

     版本:
       2022-11-11: 接入wms待质检 asnordered 数据到接口表

  =================================================================================*/
  PROCEDURE p_qamission_asnordereditfins(v_inp_asnid      IN VARCHAR2,
                                         v_inp_compid     IN VARCHAR2,
                                         v_inp_orderid    IN VARCHAR2,
                                         v_inp_supcode    IN VARCHAR2,
                                         v_inp_pcomedate  IN VARCHAR2,
                                         v_inp_pcomeinter IN VARCHAR2,
                                         v_inp_scantime   IN VARCHAR2,
                                         v_inp_memo       IN VARCHAR2) IS
    v_jugnum    NUMBER(1);
    v_sql       CLOB;
    v_sqlerrm   CLOB;
    v_errinfo   CLOB;
    v_pcomedate DATE := to_date(v_inp_pcomedate, 'YYYY-MM-DD HH24-MI-SS');
    v_scantime  DATE := to_date(v_inp_scantime, 'YYYY-MM-DD HH24-MI-SS');
    v_itfname   VARCHAR2(64) := 'itf_qamission';
  BEGIN
    --判断是否存在于 scmdata.t_asnordered_itf
    v_jugnum := f_is_existsinasnordereditf(v_inp_asnid  => v_inp_asnid,
                                           v_inp_compid => v_inp_compid);

    --如果不存在
    IF v_jugnum = 0 THEN
      --构建执行 sql
      v_sql := 'INSERT INTO scmdata.t_asnordered_itf
    (asn_id,
     company_id,
     dc_company_id,
     order_id,
     supplier_code,
     pcome_date,
     pcome_interval,
     scan_time,
     memo,
     create_id,
     create_time,
     status,
     port_element,
     port_time,
     port_status)
  VALUES
    (:v_inp_asnid,
     :v_inp_compid,
     :v_inp_compid,
     :v_inp_orderid,
     :v_inp_supcode,
     :v_pcomedate,
     :v_inp_pcomeinter,
     :v_scantime,
     :v_inp_memo,
     ''SYS'',
     SYSDATE,
     ''PC'',
     :v_itfname,
     SYSDATE,
     ''SP'')';

      --执行 sql
      EXECUTE IMMEDIATE v_sql
        USING v_inp_asnid, v_inp_compid, v_inp_compid, v_inp_orderid, v_inp_supcode, v_pcomedate, v_inp_pcomeinter, v_scantime, v_inp_memo, v_itfname;
    ELSE
      v_sql := 'UPDATE scmdata.t_asnordered_itf
     SET order_id = :v_inp_orderid,
         supplier_code = :v_inp_supcode,
         pcome_date = :v_pcomedate,
         pcome_interval = :v_inp_pcomeinter,
         scan_time = :v_scantime,
         memo = :v_inp_memo,
         port_element = :v_itfname,
         port_time = SYSDATE
   WHERE asn_id = :v_inp_asnid
     AND company_id = :v_inp_compid
     AND port_status IN (''SP'', ''CE'')';

      EXECUTE IMMEDIATE v_sql
        USING v_inp_orderid, v_inp_supcode, v_pcomedate, v_inp_pcomeinter, v_scantime, v_inp_memo, v_itfname, v_inp_asnid, v_inp_compid;
    END IF;
  EXCEPTION
    WHEN OTHERS THEN
      --错误信息赋值
      v_sqlerrm := substr(dbms_utility.format_error_stack, 1, 1024);
      v_errinfo := 'Error Object: scmdata.pkg_qa_itf.p_qamission_asnordereditfins' ||
                   chr(10) || 'Error Info: ' || v_sqlerrm || chr(10) ||
                   'Execute_sql:' || v_sql || chr(10) || 'Params: ' ||
                   chr(10) || 'v_inp_asnid: ' || v_inp_asnid || chr(10) ||
                   'v_inp_compid: ' || v_inp_compid || chr(10) ||
                   'v_inp_orderid: ' || v_inp_orderid || chr(10) ||
                   'v_inp_supcode: ' || v_inp_supcode || chr(10) ||
                   'v_pcomedate: ' || v_inp_pcomedate || chr(10) ||
                   'v_inp_pcomeinter: ' || v_inp_pcomeinter || chr(10) ||
                   'v_scantime: ' || v_inp_scantime || chr(10) ||
                   'v_inp_memo: ' || v_inp_memo || chr(10) || 'v_itfname: ' ||
                   v_itfname;

      --新增进入错误信息表
      scmdata.pkg_qa_ee.p_ins_errrecord_at(v_inp_errprogram     => 'scmdata.pkg_qa_itf.p_qamission_asnordereditfins',
                                           v_inp_causeerruserid => v_itfname,
                                           v_inp_erroccurtime   => SYSDATE,
                                           v_inp_errinfo        => v_errinfo,
                                           v_inp_compid         => v_inp_compid);
  END p_qamission_asnordereditfins;

  /*=================================================================================

    包：
      pkg_qa_itf(qa接口包)

    过程名:
      【质检任务接口】接入wms待质检 asnordered 数据到接口表

    入参:
      v_inp_asnid         :  asn单号
      v_inp_compid        :  企业id
      v_inp_relagooid     :  货号
      v_inp_orderamount   :  订货数量
      v_inp_pcomeamount   :  预计到仓数量
      v_inp_asngotamount  :  asn预计到仓数量
      v_inp_gotamount     :  预计到仓数量
      v_inp_memo          :  备注
      v_inp_eobjid        :  执行对象id

     版本:
       2022-11-17: 接入wms待质检 asnordered 数据到接口表

  =================================================================================*/
  PROCEDURE p_qamission_asnordersitfins(v_inp_asnid        IN VARCHAR2,
                                        v_inp_compid       IN VARCHAR2,
                                        v_inp_relagooid    IN VARCHAR2,
                                        v_inp_orderamount  IN NUMBER,
                                        v_inp_pcomeamount  IN NUMBER,
                                        v_inp_asngotamount IN NUMBER,
                                        v_inp_gotamount    IN NUMBER,
                                        v_inp_memo         IN VARCHAR2) IS
    v_jugnum  NUMBER(1);
    v_status  VARCHAR2(8);
    v_sql     CLOB;
    v_sqlerrm CLOB;
    v_errinfo CLOB;
    v_itfname VARCHAR2(64) := 'itf_qamission';
  BEGIN
    --判断是否存在于 scmdata.t_asnorders_itf
    v_jugnum := f_is_existsinasnordersitf(v_inp_asnid  => v_inp_asnid,
                                          v_inp_compid => v_inp_compid);

    --获取错误信息
    v_errinfo := f_get_asninfocheckresult(v_inp_asnid     => v_inp_asnid,
                                          v_inp_relagooid => v_inp_relagooid,
                                          v_inp_compid    => v_inp_compid);

    --根据错误信息给接口状态字段赋值
    IF v_errinfo IS NOT NULL THEN
      v_status := 'CE';
    ELSE
      v_status := 'SP';
    END IF;

    IF v_jugnum = 0 THEN
      --执行 sql 赋值
      v_sql := 'INSERT INTO scmdata.t_asnorders_itf
  (asn_id,
   company_id,
   dc_company_id,
   goo_id,
   order_amount,
   pcome_amount,
   asngot_amount,
   got_amount,
   memo,
   create_id,
   create_time,
   port_element,
   port_status,
   port_time,
   err_info)
VALUES
  (:v_inp_asnid,
   :v_inp_compid,
   :v_inp_compid,
   :v_inp_relagooid,
   :v_inp_orderamount,
   :v_inp_pcomeamount,
   :v_inp_asngotamount,
   :v_inp_gotamount,
   :v_inp_memo,
   ''SYS'',
   SYSDATE,
   :v_itfname,
   :v_status,
   SYSDATE,
   :v_errinfo)';

      --执行 sql
      EXECUTE IMMEDIATE v_sql
        USING v_inp_asnid, v_inp_compid, v_inp_compid, v_inp_relagooid, v_inp_orderamount, v_inp_pcomeamount, v_inp_asngotamount, v_inp_gotamount, v_inp_memo, v_itfname, v_status, v_errinfo;
    ELSE
      --执行 sql 赋值
      v_sql := 'UPDATE scmdata.t_asnorders_itf
   SET order_amount  = :v_inp_orderamount,
       pcome_amount  = :v_inp_pcomeamount,
       asngot_amount = :v_inp_asngotamount,
       got_amount    = :v_inp_gotamount,
       memo          = :v_inp_memo,
       port_element  = :v_itfname,
       port_time     = SYSDATE,
       port_status   = :v_status,
       err_info      = :v_errinfo
 WHERE asn_id = :v_inp_asnid
   AND company_id = :v_inp_compid
   AND port_status IN (''SP'',''CE'')';

      --执行 sql
      EXECUTE IMMEDIATE v_sql
        USING v_inp_orderamount, v_inp_pcomeamount, v_inp_asngotamount, v_inp_gotamount, v_inp_memo, v_itfname, v_status, v_errinfo, v_inp_asnid, v_inp_compid;
    END IF;
  EXCEPTION
    WHEN OTHERS THEN
      --错误信息赋值
      v_sqlerrm := substr(dbms_utility.format_error_stack, 1, 1024);
      v_errinfo := 'Error Object: scmdata.pkg_qa_itf.p_qamission_asnordersitfins' ||
                   chr(10) || 'Error Info: ' || v_sqlerrm || chr(10) ||
                   'Execute_sql:' || v_sql || chr(10) || 'Params: ' ||
                   chr(10) || 'v_inp_asnid: ' || v_inp_asnid || chr(10) ||
                   'v_inp_compid: ' || v_inp_compid || chr(10) ||
                   'v_inp_relagooid: ' || v_inp_relagooid || chr(10) ||
                   'v_inp_orderamount: ' || to_char(v_inp_orderamount) ||
                   chr(10) || 'v_inp_pcomeamount: ' ||
                   to_char(v_inp_pcomeamount) || chr(10) ||
                   'v_inp_asngotamount: ' || to_char(v_inp_asngotamount) ||
                   chr(10) || 'v_inp_gotamount: ' ||
                   to_char(v_inp_gotamount) || chr(10) || 'v_inp_memo: ' ||
                   v_inp_memo || chr(10) || 'v_itfname: ' || v_itfname;

      --新增进入错误信息表
      scmdata.pkg_qa_ee.p_ins_errrecord_at(v_inp_errprogram     => 'scmdata.pkg_qa_itf.p_qamission_asnordersitfins',
                                           v_inp_causeerruserid => v_itfname,
                                           v_inp_erroccurtime   => SYSDATE,
                                           v_inp_errinfo        => v_errinfo,
                                           v_inp_compid         => v_inp_compid);
  END p_qamission_asnordersitfins;

  /*=================================================================================

    包：
      pkg_qa_itf(qa接口包)

    过程名:
      【质检任务接口】接入wms待质检 asnordersitem 数据到接口表

    入参:
      v_inp_asnid         :  asn单号
      v_inp_compid        :  企业id
      v_inp_relagooid     :  货号
      v_inp_barcode       :  条码
      v_inp_warehousepos  :  库位
      v_inp_orderamount   :  订货数量
      v_inp_pcomeamount   :  预计到仓数量
      v_inp_asngotamount  :  asn预计到仓数量
      v_inp_gotamount     :  预计到仓数量
      v_inp_colorname     :  颜色名称
      v_inp_memo          :  备注

     版本:
       2022-11-17: 接入wms待质检 asnordersitem 数据到接口表

  =================================================================================*/
  PROCEDURE p_qamission_asnordersitemitfins(v_inp_asnid        IN VARCHAR2,
                                            v_inp_compid       IN VARCHAR2,
                                            v_inp_relagooid    IN VARCHAR2,
                                            v_inp_barcode      IN VARCHAR2,
                                            v_inp_warehousepos IN VARCHAR2,
                                            v_inp_orderamount  IN NUMBER,
                                            v_inp_pcomeamount  IN NUMBER,
                                            v_inp_asngotamount IN NUMBER,
                                            v_inp_gotamount    IN NUMBER,
                                            v_inp_colorname    IN VARCHAR2,
                                            v_inp_memo         IN VARCHAR2) IS
    v_jugnum  NUMBER(1);
    v_status  VARCHAR2(8);
    v_sql     CLOB;
    v_sqlerrm CLOB;
    v_errinfo CLOB;
    v_itfname VARCHAR2(64) := 'itf_qamission';
  BEGIN
    --判断是否存在于 scmdata.t_asnordersitem_itf
    v_jugnum := f_is_existsinasnordersitemitf(v_inp_asnid        => v_inp_asnid,
                                              v_inp_relagooid    => v_inp_relagooid,
                                              v_inp_barcode      => v_inp_barcode,
                                              v_inp_warehousepos => v_inp_warehousepos,
                                              v_inp_compid       => v_inp_compid);

    --获取错误信息
    v_errinfo := f_get_asninfocheckresult(v_inp_asnid     => v_inp_asnid,
                                          v_inp_relagooid => v_inp_relagooid,
                                          v_inp_barcode   => v_inp_barcode,
                                          v_inp_compid    => v_inp_compid);

    --根据错误信息给接口状态字段赋值
    IF v_errinfo IS NOT NULL THEN
      v_status := 'CE';
    ELSE
      v_status := 'SP';
    END IF;

    IF v_jugnum = 0 THEN
      --执行 sql 赋值
      v_sql := 'INSERT INTO scmdata.t_asnordersitem_itf
  (asn_id,
   company_id,
   dc_company_id,
   goo_id,
   barcode,
   warehouse_pos,
   order_amount,
   pcome_amount,
   asngot_amount,
   got_amount,
   memo,
   color_name,
   create_id,
   create_time,
   port_element,
   port_status,
   port_time,
   err_info)
VALUES
  (:v_inp_asnid,
   :v_inp_compid,
   :v_inp_compid,
   :v_inp_relagooid,
   :v_inp_barcode,
   :v_inp_warehousepos,
   :v_inp_orderamount,
   :v_inp_pcomeamount,
   :v_inp_asngotamount,
   :v_inp_gotamount,
   :v_inp_memo,
   :v_inp_colorname,
   ''SYS'',
   SYSDATE,
   :v_itfname,
   :v_status,
   SYSDATE,
   :v_errinfo)';

      --执行 sql
      EXECUTE IMMEDIATE v_sql
        USING v_inp_asnid, v_inp_compid, v_inp_compid, v_inp_relagooid, v_inp_barcode, v_inp_warehousepos, v_inp_orderamount, v_inp_pcomeamount, v_inp_asngotamount, v_inp_gotamount, v_inp_memo, v_inp_colorname, v_itfname, v_status, v_errinfo;
    ELSE
      v_sql := 'UPDATE scmdata.t_asnordersitem_itf
   SET order_amount  = :v_inp_orderamount,
       pcome_amount  = :v_inp_pcomeamount,
       asngot_amount = :v_inp_asngotamount,
       got_amount    = :v_inp_gotamount,
       memo          = :v_inp_memo,
       color_name    = :v_inp_colorname,
       port_element  = :v_itfname,
       port_status   = :v_status,
       port_time     = SYSDATE,
       err_info      = :v_errinfo
 WHERE asn_id = :v_inp_asnid
   AND company_id = :v_inp_compid
   AND goo_id = :v_inp_relagooid
   AND NVL(barcode, '' '') = NVL(:v_inp_barcode, '' '')
   AND NVL(warehouse_pos, '' '') = NVL(:v_inp_warehousepos, '' '')
   AND port_status IN (''SP'',''CE'')';

      EXECUTE IMMEDIATE v_sql
        USING v_inp_orderamount, v_inp_pcomeamount, v_inp_asngotamount, v_inp_gotamount, v_inp_memo, v_inp_colorname, v_itfname, v_status, v_errinfo, v_inp_asnid, v_inp_compid, v_inp_relagooid, v_inp_barcode, v_inp_warehousepos;
    END IF;
  EXCEPTION
    WHEN OTHERS THEN
      --错误信息赋值
      v_sqlerrm := substr(dbms_utility.format_error_stack, 1, 1024);
      v_errinfo := 'Error Object: scmdata.pkg_qa_itf.p_qamission_asnordersitemitfins' ||
                   chr(10) || 'Error Info: ' || v_sqlerrm || chr(10) ||
                   'Execute_sql:' || v_sql || chr(10) || 'Params: ' ||
                   chr(10) || 'v_inp_asnid: ' || v_inp_asnid || chr(10) ||
                   'v_inp_compid: ' || v_inp_compid || chr(10) ||
                   'v_inp_relagooid: ' || v_inp_relagooid || chr(10) ||
                   'v_inp_barcode: ' || nvl(v_inp_barcode, ' ') || chr(10) ||
                   'v_inp_warehousepos: ' || nvl(v_inp_warehousepos, ' ') ||
                   chr(10) || 'v_inp_orderamount: ' ||
                   to_char(v_inp_orderamount) || chr(10) ||
                   'v_inp_pcomeamount: ' || to_char(v_inp_pcomeamount) ||
                   chr(10) || 'v_inp_asngotamount: ' ||
                   to_char(v_inp_asngotamount) || chr(10) ||
                   'v_inp_colorname: ' || v_inp_colorname || chr(10) ||
                   'v_inp_gotamount: ' || to_char(v_inp_gotamount) ||
                   chr(10) || 'v_inp_memo: ' || v_inp_memo || chr(10) ||
                   'v_itfname: ' || v_itfname;

      --新增进入错误信息表
      scmdata.pkg_qa_ee.p_ins_errrecord_at(v_inp_errprogram     => 'scmdata.pkg_qa_itf.p_qamission_asnordersitemitfins',
                                           v_inp_causeerruserid => v_itfname,
                                           v_inp_erroccurtime   => SYSDATE,
                                           v_inp_errinfo        => v_errinfo,
                                           v_inp_compid         => v_inp_compid);
  END p_qamission_asnordersitemitfins;

  /*=================================================================================

    包：
      pkg_qa_itf(qa接口包)

    过程名:
      【质检任务接口】qa质检任务 asnordered 数据同步

    入参:
      v_inp_portstatus  :  接口状态

     版本:
       2022-11-17: qa质检任务 asnordered 数据同步

  =================================================================================*/
  PROCEDURE p_qamission_asnorderedsync(v_inp_portstatus IN VARCHAR2) IS
    v_portstatus    VARCHAR2(8);
    v_asnid         VARCHAR2(32);
    v_compid        VARCHAR2(32);
    v_ordid         VARCHAR2(32);
    v_supcode       VARCHAR2(32);
    v_createid      VARCHAR2(32);
    v_jugnum        NUMBER(1);
    v_pcomedate     DATE;
    v_pcomeinterval VARCHAR2(8);
    v_scantime      DATE;
    v_changetimes   NUMBER(4);
    v_memo          VARCHAR2(512);
    v_sql           CLOB;
    v_errinfo       CLOB;
    v_sqlerrm       VARCHAR2(1024);
  BEGIN
    --接口状态赋值
    IF v_inp_portstatus = 'SE' THEN
      v_portstatus := 'SE';
    ELSE
      v_portstatus := 'SP';
    END IF;

    --循环取值
    FOR i IN (SELECT editf.asn_id,
                     editf.company_id,
                     editf.dc_company_id,
                     editf.status,
                     editf.order_id,
                     editf.pcome_date,
                     editf.changetimes,
                     editf.scan_time,
                     editf.memo,
                     editf.create_id,
                     editf.create_time,
                     editf.pcome_interval
                FROM scmdata.t_asnordered_itf editf
               WHERE port_element = 'itf_qamission'
                 AND port_status = v_portstatus
                 AND port_time < SYSDATE - 1 / (24 * 60)
                 AND EXISTS
               (SELECT 1
                        FROM scmdata.t_asnorders asns
                       INNER JOIN scmdata.t_commodity_info goo
                          ON asns.goo_id = goo.goo_id
                         AND asns.company_id = goo.company_id
                       WHERE asns.asn_id = editf.asn_id
                         AND asns.company_id = editf.company_id
                         AND goo.category IN
                             ('00', '01', '03', '06', '07', '08'))
               ORDER BY port_time
               FETCH FIRST 300 rows ONLY) LOOP
      BEGIN
        --参数赋值
        v_asnid         := i.asn_id;
        v_compid        := i.company_id;
        v_ordid         := i.order_id;
        v_pcomedate     := i.pcome_date;
        v_pcomeinterval := i.pcome_interval;
        v_scantime      := i.scan_time;
        v_changetimes   := i.changetimes;
        v_memo          := i.memo;
        v_createid      := i.create_id;

        --判断 asn 是否存在于 asnordered
        v_jugnum := scmdata.pkg_qa_da.f_is_asnorderedrecexists(v_inp_asnid  => v_asnid,
                                                               v_inp_compid => v_compid);

        IF v_jugnum = 0 THEN
          --供应商编码获取
          SELECT MAX(supplier_code)
            INTO v_supcode
            FROM scmdata.t_ordered
           WHERE order_code = i.order_id
             AND company_id = i.company_id;

          --执行 sql 赋值
          v_sql := 'INSERT INTO scmdata.t_asnordered
            (asn_id,
             company_id,
             dc_company_id,
             status,
             order_id,
             supplier_code,
             pcome_date,
             changetimes,
             scan_time,
             memo,
             create_id,
             create_time,
             pcome_interval)
          VALUES
            (:v_asnid,
             :v_compid,
             :v_compid,
             ''PC'',
             :v_ordid,
             :v_supcode,
             :v_pcomedate,
             :v_changetimes,
             :v_scantime,
             :v_memo,
             :v_createid,
             SYSDATE,
             :v_pcomeinterval)';

          --执行 sql
          EXECUTE IMMEDIATE v_sql
            USING v_asnid, v_compid, v_compid, v_ordid, v_supcode, v_pcomedate, v_changetimes, v_scantime, v_memo, v_createid, v_pcomeinterval;
        ELSE
          --执行 sql 赋值
          v_sql := 'UPDATE scmdata.t_asnordered
             SET status         = ''PC'',
                 pcome_date     = :v_pcomedate,
                 pcome_interval = :v_pcomeinterval,
                 scan_time      = :v_scantime,
                 changetimes    = :v_changetimes,
                 memo           = :v_memo
           WHERE asn_id = :v_asnid
             AND company_id = :v_compid';

          --执行 sql
          EXECUTE IMMEDIATE v_sql
            USING v_pcomedate, v_pcomeinterval, v_scantime, v_changetimes, v_memo, v_asnid, v_compid;
        END IF;

        --asnordered.is_qaasninfocomplete 更新
        p_qamission_isqaasninfocompleteupd(v_inp_asnid  => v_asnid,
                                           v_inp_compid => v_compid);

        --状态更新
        UPDATE scmdata.t_asnordered_itf
           SET port_status = 'SS'
         WHERE asn_id = v_asnid
           AND company_id = v_compid;
      EXCEPTION
        WHEN OTHERS THEN
          --错误信息赋值
          v_sqlerrm := substr(dbms_utility.format_error_stack, 1, 1024);
          v_errinfo := 'Error_Object: scmdata.pkg_qa_itf.p_qamission_asnorderedsync' ||
                       chr(10) || 'Error_message: ' || v_sqlerrm || chr(10) ||
                       'Error_Time:: ' ||
                       to_char(SYSDATE, 'yyyy-mm-dd hh24-mi-ss') || chr(10) ||
                       'Error_sql: ' || chr(10) || v_sql || chr(10) ||
                       'v_asnid: ' || v_asnid || chr(10) || 'v_compid: ' ||
                       v_compid || chr(10) || 'v_ordid: ' || v_ordid ||
                       chr(10) || 'v_supcode: ' || v_supcode || chr(10) ||
                       'v_createid: ' || v_createid || chr(10) ||
                       'v_pcomedate: ' ||
                       to_char(v_pcomedate, 'yyyy-mm-dd hh24-mi-ss') ||
                       chr(10) || 'v_pcomeinterval: ' || v_pcomeinterval ||
                       chr(10) || 'v_scantime: ' ||
                       to_char(v_scantime, 'yyyy-mm-dd hh24-mi-ss') ||
                       chr(10) || 'v_changetimes: ' ||
                       to_char(v_changetimes) || chr(10) || 'v_memo: ' ||
                       v_memo;

          --接口状态及错误信息赋值
          UPDATE scmdata.t_asnordered_itf
             SET port_status = 'SE', err_info = v_errinfo
           WHERE asn_id = v_asnid
             AND company_id = v_compid;
      END;
    END LOOP;
  END p_qamission_asnorderedsync;

  /*=================================================================================

    包：
      pkg_qa_itf(qa接口包)

    过程名:
      【质检任务接口】qa质检任务 asnorders 数据同步

    入参:
      v_inp_portstatus  :  接口状态

     版本:
       2022-11-17: qa质检任务 asnorders 数据同步

  =================================================================================*/
  PROCEDURE p_qamission_asnorderssync(v_inp_portstatus IN VARCHAR2) IS
    v_portstatus   VARCHAR2(8);
    v_asnid        VARCHAR2(32);
    v_compid       VARCHAR2(32);
    v_sql          CLOB;
    v_orderamount  NUMBER(8);
    v_pcomeamount  NUMBER(8);
    v_asngotamount NUMBER(8);
    v_gotamount    NUMBER(8);
    v_retamount    NUMBER(8);
    v_memo         VARCHAR2(512);
    v_picktime     DATE;
    v_shimenttime  DATE;
    v_receivetime  DATE;
    v_errinfo      CLOB;
    v_sqlerrm      VARCHAR2(1024);
  BEGIN
    --接口状态赋值
    IF v_inp_portstatus = 'SE' THEN
      v_portstatus := 'SE';
    ELSE
      v_portstatus := 'SP';
    END IF;

    --循环取值
    FOR i IN (SELECT sitf.asn_id,
                     sitf.company_id,
                     sitf.dc_company_id,
                     sitf.goo_id,
                     sitf.order_amount,
                     sitf.pcome_amount,
                     sitf.asngot_amount,
                     sitf.got_amount,
                     sitf.memo,
                     sitf.create_id,
                     sitf.create_time,
                     sitf.ret_amount,
                     sitf.pick_time,
                     sitf.shiment_time,
                     sitf.receive_time
                FROM scmdata.t_asnorders_itf sitf
               WHERE port_element = 'itf_qamission'
                 AND port_status = v_portstatus
                 AND port_time < SYSDATE - 1 / (24 * 60)
                 AND EXISTS
               (SELECT 1
                        FROM scmdata.t_asnorders
                       WHERE asn_id = sitf.asn_id
                         AND company_id = sitf.company_id)
               ORDER BY port_time
               FETCH FIRST 300 rows ONLY) LOOP
      BEGIN
        --参数赋值
        v_asnid        := i.asn_id;
        v_compid       := i.company_id;
        v_orderamount  := i.order_amount;
        v_pcomeamount  := i.pcome_amount;
        v_asngotamount := i.asngot_amount;
        v_gotamount    := i.got_amount;
        v_retamount    := i.ret_amount;
        v_memo         := i.memo;
        v_picktime     := i.pick_time;
        v_shimenttime  := i.shiment_time;
        v_receivetime  := i.receive_time;

        --执行 sql 赋值
        v_sql := 'UPDATE scmdata.t_asnorders
           SET order_amount  = :v_orderamount,
               pcome_amount  = :v_pcomeamount,
               asngot_amount = :v_asngotamount,
               got_amount    = :v_gotamount,
               ret_amount    = :v_retamount,
               memo          = :v_memo,
               pick_time     = :v_picktime,
               shiment_time  = :v_shimenttime,
               receive_time  = :v_receivetime
         WHERE asn_id = :v_asnid
           AND company_id = :v_compid';

        --执行 sql
        EXECUTE IMMEDIATE v_sql
          USING v_orderamount, v_pcomeamount, v_asngotamount, v_gotamount, v_retamount, v_memo, v_picktime, v_shimenttime, v_receivetime, v_asnid, v_compid;

        --asnordered.is_qaasninfocomplete 更新
        p_qamission_isqaasninfocompleteupd(v_inp_asnid  => v_asnid,
                                           v_inp_compid => v_compid);

        --状态更新
        UPDATE scmdata.t_asnorders_itf
           SET port_status = 'SS'
         WHERE asn_id = v_asnid
           AND company_id = v_compid;
      EXCEPTION
        WHEN OTHERS THEN
          --错误信息赋值
          v_sqlerrm := substr(dbms_utility.format_error_stack, 1, 1024);
          v_errinfo := 'Error_Object: scmdata.pkg_qa_itf.p_qamission_asnorderssync' ||
                       chr(10) || 'Error_message: ' || v_sqlerrm || chr(10) ||
                       'Error_Time:: ' ||
                       to_char(SYSDATE, 'yyyy-mm-dd hh24-mi-ss') || chr(10) ||
                       'Error_sql: ' || chr(10) || v_sql || chr(10) ||
                       'v_orderamount: ' || to_char(v_orderamount) ||
                       chr(10) || 'v_pcomeamount: ' ||
                       to_char(v_pcomeamount) || chr(10) ||
                       'v_asngotamount: ' || to_char(v_asngotamount) ||
                       chr(10) || 'v_gotamount: ' || to_char(v_gotamount) ||
                       chr(10) || 'v_retamount: ' || to_char(v_retamount) ||
                       chr(10) || 'v_memo: ' || v_memo || chr(10) ||
                       'v_picktime: ' ||
                       to_char(v_picktime, 'yyyy-mm-dd hh24-mi-ss') ||
                       chr(10) || 'v_shimenttime: ' ||
                       to_char(v_shimenttime, 'yyyy-mm-dd hh24-mi-ss') ||
                       chr(10) || 'v_receivetime: ' ||
                       to_char(v_receivetime, 'yyyy-mm-dd hh24-mi-ss') ||
                       chr(10) || 'v_asnid: ' || v_asnid || chr(10) ||
                       'v_compid: ' || v_compid;

          --更新接口状态和错误信息
          UPDATE scmdata.t_asnordered_itf
             SET port_status = 'SE', err_info = v_errinfo
           WHERE asn_id = v_asnid
             AND company_id = v_compid;
      END;
    END LOOP;
  END p_qamission_asnorderssync;

  /*=================================================================================

    包：
      pkg_qa_itf(qa接口包)

    过程名:
      【质检任务接口】qa质检任务 asnordersitem 数据同步

    入参:
      v_inp_portstatus  :  接口状态

     版本:
       2022-11-17: qa质检任务 asnordersitem 数据同步

  =================================================================================*/
  PROCEDURE p_qamission_asnordersitemsync(v_inp_portstatus IN VARCHAR2) IS
    v_portstatus   VARCHAR2(8);
    v_asnid        VARCHAR2(32);
    v_compid       VARCHAR2(32);
    v_gooid        VARCHAR2(32);
    v_relagooid    VARCHAR2(32);
    v_barcode      VARCHAR2(32);
    v_sql          CLOB;
    v_orderamount  NUMBER(8);
    v_pcomeamount  NUMBER(8);
    v_asngotamount NUMBER(8);
    v_gotamount    NUMBER(8);
    v_retamount    NUMBER(8);
    v_memo         VARCHAR2(512);
    v_colorname    VARCHAR2(32);
    v_picktime     DATE;
    v_shipmenttime DATE;
    v_receivetime  DATE;
    v_errinfo      CLOB;
    v_sqlerrm      VARCHAR2(1024);
  BEGIN
    --接口状态赋值
    IF v_inp_portstatus = 'SE' THEN
      v_portstatus := 'SE';
    ELSE
      v_portstatus := 'SP';
    END IF;

    --循环取值
    FOR i IN (SELECT sitemitf.asn_id,
                     goo.goo_id,
                     sitemitf.barcode,
                     sitemitf.company_id,
                     MAX(sitemitf.goo_id) rela_goo_id,
                     MAX(sitemitf.order_amount) order_amount,
                     MAX(sitemitf.pcome_amount) pcome_amount,
                     SUM(nvl(sitemitf.asngot_amount, 0)) asngot_amount,
                     SUM(nvl(sitemitf.got_amount, 0)) got_amount,
                     MAX(nvl(sitemitf.ret_amount, 0)) ret_amount,
                     MAX(sitemitf.pick_time) pick_time,
                     MAX(sitemitf.shipment_time) shipment_time,
                     MAX(sitemitf.receive_time) receive_time,
                     MAX(sitemitf.warehouse_pos) warehouse_pos,
                     MAX(sitemitf.memo) memo,
                     MAX(sitemitf.color_name) color_name,
                     MAX(sitemitf.create_id) create_id,
                     MAX(sitemitf.create_time) create_time,
                     MAX(sitemitf.port_time) port_time
                FROM scmdata.t_asnordersitem_itf sitemitf
               INNER JOIN scmdata.t_commodity_info goo
                  ON sitemitf.goo_id = goo.rela_goo_id
                 AND sitemitf.company_id = goo.company_id
               WHERE port_element = 'itf_qamission'
                 AND port_status = v_portstatus
                 AND port_time < SYSDATE - 1 / (24 * 60)
                 AND EXISTS
               (SELECT 1
                        FROM scmdata.t_asnordersitem
                       WHERE asn_id = sitemitf.asn_id
                         AND goo_id = goo.goo_id
                         AND nvl(barcode, ' ') = nvl(sitemitf.barcode, ' ')
                         AND company_id = sitemitf.company_id)
               GROUP BY sitemitf.asn_id,
                        goo.goo_id,
                        sitemitf.barcode,
                        sitemitf.company_id
               ORDER BY port_time
               FETCH FIRST 1500 rows ONLY) LOOP
      BEGIN
        --参数赋值
        v_asnid        := i.asn_id;
        v_compid       := i.company_id;
        v_gooid        := i.goo_id;
        v_relagooid    := i.rela_goo_id;
        v_barcode      := i.barcode;
        v_orderamount  := i.order_amount;
        v_pcomeamount  := i.pcome_amount;
        v_asngotamount := i.asngot_amount;
        v_gotamount    := i.got_amount;
        v_retamount    := i.ret_amount;
        v_memo         := i.memo;
        v_colorname    := i.color_name;
        v_picktime     := i.pick_time;
        v_shipmenttime := i.shipment_time;
        v_receivetime  := i.receive_time;

        --执行 sql 赋值
        v_sql := 'UPDATE scmdata.t_asnordersitem
           SET order_amount  = :v_orderamount,
               pcome_amount  = :v_pcomeamount,
               asngot_amount = :v_asngotamount,
               got_amount    = :v_gotamount,
               ret_amount    = :v_retamount,
               memo          = :v_memo,
               color_name    = :v_colorname,
               pick_time     = :v_picktime,
               shipment_time = :v_shipmenttime,
               receive_time  = :v_receivetime
         WHERE asn_id = :v_asnid
           AND goo_id = :v_gooid
           AND NVL(barcode, '' '') = NVL(:v_barcode, '' '')
           AND company_id = :v_compid';

        --执行 sql
        EXECUTE IMMEDIATE v_sql
          USING v_orderamount, v_pcomeamount, v_asngotamount, v_gotamount, v_retamount, v_memo, v_colorname, v_picktime, v_shipmenttime, v_receivetime, v_asnid, v_gooid, v_barcode, v_compid;

        --asnordered.is_qaasninfocomplete 更新
        p_qamission_isqaasninfocompleteupd(v_inp_asnid  => v_asnid,
                                           v_inp_compid => v_compid);

        --状态更新
        UPDATE scmdata.t_asnordersitem_itf
           SET port_status = 'SS'
         WHERE asn_id = v_asnid
           AND goo_id = v_relagooid
           AND nvl(barcode, ' ') = nvl(v_barcode, ' ')
           AND company_id = v_compid;
      EXCEPTION
        WHEN OTHERS THEN
          --错误信息赋值
          v_sqlerrm := substr(dbms_utility.format_error_stack, 1, 1024);
          v_errinfo := 'Error_Object: scmdata.pkg_qa_itf.p_qamission_asnordersitemsync' ||
                       chr(10) || 'Error_message: ' || v_sqlerrm || chr(10) ||
                       'Error_Time::' ||
                       to_char(SYSDATE, 'yyyy-mm-dd hh24-mi-ss') || chr(10) ||
                       'Error_sql: ' || chr(10) || v_sql || chr(10) ||
                       'v_orderamount: ' || to_char(v_orderamount) ||
                       chr(10) || 'v_pcomeamount: ' ||
                       to_char(v_pcomeamount) || chr(10) ||
                       'v_asngotamount: ' || to_char(v_asngotamount) ||
                       chr(10) || 'v_gotamount: ' || to_char(v_gotamount) ||
                       chr(10) || 'v_retamount: ' || to_char(v_retamount) ||
                       chr(10) || 'v_memo: ' || v_memo || chr(10) ||
                       'v_colorname: ' || v_colorname || chr(10) ||
                       'v_picktime: ' ||
                       to_char(v_picktime, 'yyyy-mm-dd hh24-mi-ss') ||
                       chr(10) || 'v_shipmenttime: ' ||
                       to_char(v_shipmenttime, 'yyyy-mm-dd hh24-mi-ss') ||
                       chr(10) || 'v_receivetime: ' ||
                       to_char(v_receivetime, 'yyyy-mm-dd hh24-mi-ss') ||
                       chr(10) || 'v_asnid: ' || v_asnid || chr(10) ||
                       'v_compid: ' || v_compid || chr(10) || 'v_gooid: ' ||
                       v_gooid || chr(10) || 'v_barcode: ' || v_barcode;

          --更新接口状态和错误信息
          UPDATE scmdata.t_asnordersitem_itf
             SET port_status = 'SE', err_info = v_errinfo
           WHERE asn_id = v_asnid
             AND goo_id = v_relagooid
             AND nvl(barcode, ' ') = nvl(v_barcode, ' ')
             AND company_id = v_compid;
      END;
    END LOOP;
  END p_qamission_asnordersitemsync;

  /*=============================================================================

     包：
       pkg_qa_itf(qa接口包)

     过程名:
       根据 asn 刷新 Qa质检报告 Sku不合格数量

     入参:
       v_inp_asnid       :  Asn单号
       v_inp_compid      :  企业Id
       v_inp_curuserid   :  当前操作人Id
       v_inp_invokeobj   :  调用对象

     版本:
       2023-01-17_zc314 : 根据 asn 刷新 Qa质检报告 Sku不合格数量

  ==============================================================================*/
  PROCEDURE p_receiveinfo_updqarepskuunqualamountbyasn(v_inp_asnid     IN VARCHAR2,
                                                       v_inp_compid    IN VARCHAR2,
                                                       v_inp_invokeobj IN VARCHAR2) IS
    priv_exception    EXCEPTION;
    v_sql             CLOB;
    v_errinfo         CLOB;
    v_sqlerrm         VARCHAR2(512);
    v_allowinvokeobj  CLOB := 'scmdata.pkg_qa_itf.p_receiveinfo_refreshrepunqualamount';
    v_selfdescription VARCHAR2(1024) := 'scmdata.pkg_qa_ld.p_upd_qarepskuunqualamountbyasn';
  BEGIN
    --访问控制
    IF instr(v_allowinvokeobj, v_inp_invokeobj) = 0 THEN
      v_sqlerrm := '拒绝访问：调用方-' || v_inp_invokeobj || ' 被调用方-' ||
                   v_selfdescription;
      RAISE priv_exception;
    END IF;
    --构建Sql
    v_sql := 'UPDATE scmdata.t_qa_report_skudim tab
   SET unqual_amount = CASE
                         WHEN tab.skucheck_result = ''NP'' AND
                              tab.receive_time IS NULL THEN
                          NVL(tab.pcome_amount, 0)
                         WHEN tab.skucheck_result = ''NP'' AND
                              tab.receive_time IS NOT NULL THEN
                          NVL(tab.got_amount, 0)
                         WHEN tab.skucheck_result = ''PS'' THEN
                          0
                       END
 WHERE asn_id = :v_inp_asnid
   AND company_id = :v_inp_compid';

    EXECUTE IMMEDIATE v_sql
      USING v_inp_asnid, v_inp_compid;
  EXCEPTION
    WHEN priv_exception THEN
      --抛出报错
      raise_application_error(-20002, v_sqlerrm);
    WHEN OTHERS THEN
      --错误信息赋值
      v_sqlerrm := substr(dbms_utility.format_error_stack, 1, 1024);
      v_errinfo := 'Error Object:' || v_selfdescription || chr(10) ||
                   'Error Info: ' || v_sqlerrm || CHR(10) || 'Execute_sql:' ||
                   v_sql || CHR(10) || 'Params: ' || CHR(10) ||
                   'v_inp_asnid: ' || v_inp_asnid || CHR(10) ||
                   'v_inp_compid: ' || v_inp_compid;

      --新增进入错误信息表
      scmdata.pkg_qa_ee.p_ins_errrecord_at(v_inp_errprogram     => v_selfdescription,
                                           v_inp_causeerruserid => 'itf_qa_receiveinfo',
                                           v_inp_erroccurtime   => SYSDATE,
                                           v_inp_errinfo        => v_errinfo,
                                           v_inp_compid         => v_inp_compid);

      --抛出报错
      raise_application_error(-20002, v_sqlerrm);
  END p_receiveinfo_updqarepskuunqualamountbyasn;

  /*=============================================================================

     包：
       pkg_qa_itf(qa接口包)

     过程名:
       刷新 asn 关联的 Qa质检报告 Sku不合格数量和报告数量数据

     入参:
       v_inp_asnid       :  Asn单号
       v_inp_compid      :  企业Id
       v_inp_curuserid   :  当前操作人Id
       v_inp_invokeobj   :  调用对象

     版本:
       2023-01-17_zc314 : 刷新 asn 关联的 Qa质检报告 Sku不合格数量
                          和报告数量数据

  ==============================================================================*/
  PROCEDURE p_receiveinfo_refreshrepunqualamount(v_inp_asnid  IN VARCHAR2,
                                                 v_inp_compid IN VARCHAR2) IS
    v_sql                    CLOB;
    v_pcomesumamount         NUMBER(8);
    v_gotsumamount           NUMBER(8);
    v_qualdrecreasesumamount NUMBER(8);
    v_unqualsumamount        NUMBER(8);
    v_selfdescription        VARCHAR2(1024) := 'scmdata.pkg_qa_itf.p_receiveinfo_refreshrepunqualamount';
  BEGIN
    --刷新质检报告不合格数量
    p_receiveinfo_updqarepskuunqualamountbyasn(v_inp_asnid     => v_inp_asnid,
                                               v_inp_compid    => v_inp_compid,
                                               v_inp_invokeobj => v_selfdescription);

    FOR i IN (SELECT DISTINCT qa_report_id, company_id
                FROM scmdata.t_qa_report_skudim
               WHERE asn_id = v_inp_asnid
                 AND company_id = v_inp_compid) LOOP
      --获取 Qa质检报告Sku级汇总数字相关数据 Sql
      v_sql := scmdata.pkg_qa_ld.f_get_qarepskudimsumdata_sql(v_inp_invokeobj => v_selfdescription);

      --执行前Sql非空判断
      IF v_sql IS NOT NULL THEN
        --执行 Sql对变量进行赋值
        EXECUTE IMMEDIATE v_sql
          INTO v_pcomesumamount, v_gotsumamount, v_qualdrecreasesumamount, v_unqualsumamount
          USING i.qa_report_id, i.company_id;

        --Qa质检报告数据维度表增改
        scmdata.pkg_qa_lc.p_iu_qareportnumdim(v_inp_qarepid                  => i.qa_report_id,
                                              v_inp_compid                   => i.company_id,
                                              v_inp_firstsamplingamount      => NULL,
                                              v_inp_addsamplingamount        => NULL,
                                              v_inp_unqualsamplingamount     => NULL,
                                              v_inp_pcomesumamount           => v_pcomesumamount,
                                              v_inp_gotsumamount             => v_gotsumamount,
                                              v_inp_qualdecreasesumamount    => v_qualdrecreasesumamount,
                                              v_inp_prereprocessingsumamount => v_unqualsumamount,
                                              v_inp_operuserid               => 'itf_qa_receiveinfo');
      END IF;
    END LOOP;
  END p_receiveinfo_refreshrepunqualamount;

  /*=================================================================================

    包：
      pkg_qa_itf(qa接口包)

    过程名:
      【上架信息更新接口】更新 asnordered 上架信息到接口表

    入参:
      v_inp_asnid    :  asn单号
      v_inp_compid   :  企业id
      v_inp_sctime   :  到仓扫描时间
      v_inp_cgtimes  :  变更次数
      v_inp_pcdate   :  预计到仓日期
      v_inp_pcintval :  预计到仓时段

     版本:
       2022-11-17: 更新 asnordered 上架信息到接口表

  =================================================================================*/
  PROCEDURE p_receiveinfo_asnordereditfupd(v_inp_asnid    IN VARCHAR2,
                                           v_inp_compid   IN VARCHAR2,
                                           v_inp_sctime   IN VARCHAR2,
                                           v_inp_cgtimes  IN NUMBER,
                                           v_inp_pcdate   IN VARCHAR2,
                                           v_inp_pcintval IN VARCHAR2) IS
    v_jugnum    NUMBER(1);
    v_status    VARCHAR2(8);
    v_errinfo   CLOB;
    v_scantime  DATE := to_date(v_inp_sctime, 'YYYY-MM-DD HH24-MI-SS');
    v_pcomedate DATE := to_date(v_inp_pcdate, 'YYYY-MM-DD HH24-MI-SS');
    v_sql       CLOB;
    v_itfname   VARCHAR2(64) := 'itf_receiveinfo';
    v_sqlerrm   VARCHAR2(1024);
  BEGIN
    --判断是否已经存在于 scmdata.t_asnordered_itf
    v_jugnum := f_is_existsinasnordereditf(v_inp_asnid  => v_inp_asnid,
                                           v_inp_compid => v_inp_compid);

    --存在于 scmdata.t_asnordered_itf
    IF v_jugnum = 1 THEN
      --错误校验
      v_errinfo := f_get_asninfocheckresult(v_inp_asnid  => v_inp_asnid,
                                            v_inp_compid => v_inp_compid);

      --错误信息不为空
      IF v_errinfo IS NOT NULL THEN
        v_status := 'CE';
      ELSE
        v_status := 'UP';
      END IF;

      BEGIN
        --构建执行 sql
        v_sql := 'UPDATE scmdata.t_asnordered_itf
   SET scan_time      = :v_scantime,
       changetimes    = :v_inp_cgtimes,
       pcome_date     = :v_pcomedate,
       pcome_interval = :v_inp_pcintval,
       port_status    = :v_status,
       port_element   = :v_itfname,
       port_time      = SYSDATE,
       err_info       = :v_errinfo
 WHERE asn_id = :v_inp_asnid
   AND company_id = :v_inp_compid';

        --执行 sql
        EXECUTE IMMEDIATE v_sql
          USING v_scantime, v_inp_cgtimes, v_pcomedate, v_inp_pcintval, v_status, v_itfname, v_errinfo, v_inp_asnid, v_inp_compid;
      EXCEPTION
        WHEN OTHERS THEN
          --错误信息赋值
          v_sqlerrm := substr(dbms_utility.format_error_stack, 1, 1024);
          v_errinfo := 'Error_Object: scmdata.pkg_qa_itf.p_receiveinfo_asnordereditfupd' ||
                       chr(10) || 'Error_message: ' || v_sqlerrm || chr(10) ||
                       'Error_Time::' ||
                       to_char(SYSDATE, 'yyyy-mm-dd hh24-mi-ss') || chr(10) ||
                       'Error_sql: ' || chr(10) || v_sql || chr(10) ||
                       'v_scantime: ' ||
                       to_char(v_scantime, 'yyyy-mm-dd hh24-mi-ss') ||
                       chr(10) || 'v_pcomedate: ' ||
                       to_char(v_pcomedate, 'yyyy-mm-dd hh24-mi-ss') ||
                       chr(10) || 'v_inp_pcintval: ' || v_inp_pcintval ||
                       chr(10) || 'v_status: ' || v_status || chr(10) ||
                       'v_itfname: ' || v_itfname || chr(10) ||
                       'v_errinfo: ' || v_errinfo || chr(10) ||
                       'v_inp_asnid: ' || v_inp_asnid || chr(10) ||
                       'v_inp_compid: ' || v_inp_compid;

          --更新接口状态和错误信息
          UPDATE scmdata.t_asnordered_itf
             SET port_status = 'UE', err_info = v_errinfo
           WHERE asn_id = v_inp_asnid
             AND company_id = v_inp_compid;
      END;
    END IF;
  END p_receiveinfo_asnordereditfupd;

  /*=================================================================================

    包：
      pkg_qa_itf(qa接口包)

    过程名:
      【上架信息更新接口】接入 wms-asnorders 上架信息到接口表

    入参：
      v_inp_asnid         :   asn单号
      v_inp_compid        :   企业id
      v_inp_relagooid     :   货号
      v_inp_asngotamount  :   asn到货量
      v_inp_gotamount     :   到货量
      v_inp_retamount     :   退货量
      v_inp_picktime      :   分拣时间
      v_inp_shipmenttime  :   发货时间
      v_inp_warehousepos  :   库位

    版本:
      2022-11-17: 接入 wms-asnorders 上架信息到接口表

  =================================================================================*/
  PROCEDURE p_receiveinfo_asnordersitfupd(v_inp_asnid        IN VARCHAR2,
                                          v_inp_compid       IN VARCHAR2,
                                          v_inp_relagooid    IN VARCHAR2,
                                          v_inp_asngotamount IN NUMBER,
                                          v_inp_gotamount    IN NUMBER,
                                          v_inp_retamount    IN NUMBER,
                                          v_inp_picktime     IN VARCHAR2,
                                          v_inp_receivetime  IN VARCHAR2,
                                          v_inp_shipmenttime IN VARCHAR2,
                                          v_inp_warehousepos IN VARCHAR2) IS
    v_picktime     DATE := to_date(v_inp_picktime, 'YYYY-MM-DD HH24-MI-SS');
    v_shipmenttime DATE := to_date(v_inp_shipmenttime,
                                   'YYYY-MM-DD HH24-MI-SS');
    v_receivetime  DATE := to_date(v_inp_receivetime,
                                   'YYYY-MM-DD HH24-MI-SS');
    v_jugnum       NUMBER(1);
    v_status       VARCHAR2(8);
    v_errinfo      CLOB;
    v_sql          CLOB;
    v_itfname      VARCHAR2(64) := 'itf_receiveinfo';
    v_sqlerrm      VARCHAR2(1024);
  BEGIN
    --判断是否存在于 scmdata.t_asnorders_itf
    v_jugnum := f_is_existsinasnordersitf(v_inp_asnid  => v_inp_asnid,
                                          v_inp_compid => v_inp_compid);

    --不存在于 scmdata.t_asnorders_itf
    IF v_jugnum = 1 THEN
      --错误校验
      v_errinfo := f_get_asninfocheckresult(v_inp_asnid     => v_inp_asnid,
                                            v_inp_relagooid => v_inp_relagooid,
                                            v_inp_compid    => v_inp_compid);

      --错误信息不为空
      IF v_errinfo IS NOT NULL THEN
        v_status := 'CE';
      ELSE
        v_status := 'UP';
      END IF;

      BEGIN
        --执行 sql 赋值
        v_sql := 'UPDATE scmdata.t_asnorders_itf
   SET asngot_amount = :v_inp_asngotamount,
       got_amount    = :v_inp_gotamount,
       ret_amount    = :v_inp_retamount,
       pick_time     = :v_picktime,
       shiment_time  = :v_shipmenttime,
       receive_time  = :v_receivetime,
       warehouse_pos = :v_inp_warehousepos,
       port_element  = :v_itfname,
       port_time     = SYSDATE,
       port_status   = :v_status,
       err_info      = :v_errinfo
 WHERE asn_id = :v_inp_asnid
   AND company_id = :v_inp_compid';

        --执行 sql
        EXECUTE IMMEDIATE v_sql
          USING v_inp_asngotamount, v_inp_gotamount, v_inp_retamount, v_picktime, v_shipmenttime, v_receivetime, v_inp_warehousepos, v_itfname, v_status, v_errinfo, v_inp_asnid, v_inp_compid;

      EXCEPTION
        WHEN OTHERS THEN
          --错误信息赋值
          v_sqlerrm := substr(dbms_utility.format_error_stack, 1, 1024);
          v_errinfo := 'Error_Object: scmdata.pkg_qa_itf.p_receiveinfo_asnordersitfupd' ||
                       chr(10) || 'Error_message: ' || v_sqlerrm || chr(10) ||
                       'Error_Time::' ||
                       to_char(SYSDATE, 'yyyy-mm-dd hh24-mi-ss') || chr(10) ||
                       'Error_sql: ' || chr(10) || v_sql || chr(10) ||
                       'v_inp_asngotamount: ' ||
                       to_char(v_inp_asngotamount) || chr(10) ||
                       'v_inp_gotamount: ' || to_char(v_inp_gotamount) ||
                       chr(10) || 'v_inp_retamount: ' ||
                       to_char(v_inp_retamount) || chr(10) ||
                       'v_picktime: ' || v_inp_picktime || chr(10) ||
                       'v_shipmenttime: ' || v_inp_shipmenttime || chr(10) ||
                       'v_receivetime: ' || v_inp_receivetime || chr(10) ||
                       'v_inp_warehousepos: ' || v_inp_warehousepos ||
                       chr(10) || 'v_itfname: ' || v_itfname || chr(10) ||
                       'v_status: ' || v_status || chr(10) || 'v_errinfo: ' ||
                       v_errinfo || chr(10) || 'v_inp_asnid: ' ||
                       v_inp_asnid || chr(10) || 'v_inp_compid: ' ||
                       v_inp_compid;

          --更新接口状态及错误信息
          UPDATE scmdata.t_asnorders_itf
             SET port_status = 'UE', err_info = v_errinfo
           WHERE asn_id = v_inp_asnid
             AND company_id = v_inp_compid;
      END;
    END IF;
  END p_receiveinfo_asnordersitfupd;

  /*=================================================================================

    包：
      pkg_qa_itf(qa接口包)

    过程名:
      【上架信息更新接口】接入 wms-asnordersitem 收获信息到接口表

    入参:
      v_inp_asnid         :  asn单号
      v_inp_compid        :  企业id
      v_inp_relagooid     :  货号
      v_inp_barcode       :  条码
      v_inp_asngotamount  :  预到货收货量
      v_inp_gotamount     :  到货量
      v_inp_retamount     :  退货量
      v_inp_picktime      :  分拣时间
      v_inp_shipmenttime  :  发货时间
      v_inp_receivetime   :  收货时间
      v_inp_warehousepos  :  库位

    版本:
      2022-11-18: 接入 wms-asnordersitem 收获信息到接口表

  =================================================================================*/
  PROCEDURE p_receiveinfo_asnordersitemitfupd(v_inp_asnid        IN VARCHAR2,
                                              v_inp_compid       IN VARCHAR2,
                                              v_inp_relagooid    IN VARCHAR2,
                                              v_inp_barcode      IN VARCHAR2,
                                              v_inp_asngotamount IN NUMBER,
                                              v_inp_gotamount    IN NUMBER,
                                              v_inp_retamount    IN NUMBER,
                                              v_inp_picktime     IN VARCHAR2,
                                              v_inp_shipmenttime IN VARCHAR2,
                                              v_inp_receivetime  IN VARCHAR2,
                                              v_inp_warehousepos IN VARCHAR2) IS
    v_picktime        DATE := to_date(v_inp_picktime,
                                      'YYYY-MM-DD HH24-MI-SS');
    v_shipmenttime    DATE := to_date(v_inp_shipmenttime,
                                      'YYYY-MM-DD HH24-MI-SS');
    v_receivetime     DATE := to_date(v_inp_receivetime,
                                      'YYYY-MM-DD HH24-MI-SS');
    v_cnt             NUMBER(1);
    v_isemptywhexists NUMBER(1);
    v_iswhequal       NUMBER(1);
    v_orderamount     NUMBER(8);
    v_pcomeamount     NUMBER(8);
    v_colorname       VARCHAR2(32);
    v_status          VARCHAR2(8);
    v_errinfo         CLOB;
    v_sql             CLOB;
    v_itfname         VARCHAR2(64) := 'itf_receiveinfo';
    v_sqlerrm         VARCHAR2(1024);
  BEGIN
    --错误校验
    v_errinfo := f_get_asninfocheckresult(v_inp_asnid     => v_inp_asnid,
                                          v_inp_relagooid => v_inp_relagooid,
                                          v_inp_compid    => v_inp_compid);

    --错误信息不为空
    IF v_errinfo IS NOT NULL THEN
      v_status := 'CE';
    ELSE
      v_status := 'UP';
    END IF;

    --判断该 asn条码是否存在空库位数据
    SELECT nvl(MAX(cnt), 0),
           MAX(is_emptywhexists),
           MAX(is_warehouseposequal)
      INTO v_cnt, v_isemptywhexists, v_iswhequal
      FROM (SELECT 1 cnt,
                   CASE
                     WHEN nvl(warehouse_pos, ' ') = ' ' THEN
                      1
                     ELSE
                      0
                   END is_emptywhexists,
                   CASE
                     WHEN nvl(warehouse_pos, ' ') = v_inp_warehousepos THEN
                      1
                     ELSE
                      0
                   END is_warehouseposequal
              FROM scmdata.t_asnordersitem_itf
             WHERE asn_id = v_inp_asnid
               AND company_id = v_inp_compid
               AND goo_id = v_inp_relagooid
               AND nvl(barcode, ' ') = nvl(v_inp_barcode, ' '));

    IF v_cnt = 0 OR (v_isemptywhexists = 0 AND v_iswhequal = 0) THEN
      SELECT MAX(order_amount), MAX(pcome_amount)
        INTO v_orderamount, v_pcomeamount
        FROM scmdata.t_asnordersitem_itf
       WHERE asn_id = v_inp_asnid
         AND company_id = v_inp_compid;

      SELECT MAX(color_name)
        INTO v_colorname
        FROM scmdata.t_asnordersitem_itf
       WHERE asn_id = v_inp_asnid
         AND company_id = v_inp_compid
         AND goo_id = v_inp_relagooid
         AND nvl(barcode, ' ') = nvl(v_inp_barcode, ' ');

      --构建执行 sql
      v_sql := 'INSERT INTO scmdata.t_asnordersitem_itf
  (asn_id,
   company_id,
   dc_company_id,
   goo_id,
   barcode,
   warehouse_pos,
   order_amount,
   pcome_amount,
   asngot_amount,
   got_amount,
   ret_amount,
   pick_time,
   shipment_time,
   receive_time,
   color_name,
   create_id,
   create_time,
   port_element,
   port_status,
   port_time)
VALUES
  (:v_inp_asnid,
   :v_inp_compid,
   :v_inp_compid,
   :v_inp_relagooid,
   :v_inp_barcode,
   :v_inp_warehousepos,
   :v_orderamount,
   :v_pcomeamount,
   :v_inp_asngotamount,
   :v_inp_gotamount,
   :v_inp_retamount,
   :v_picktime,
   :v_shipmenttime,
   :v_receivetime,
   :v_colorname,
   ''SYS'',
   SYSDATE,
   :v_itfname,
   :v_status,
   SYSDATE)';

      --执行 sql
      EXECUTE IMMEDIATE v_sql
        USING v_inp_asnid, v_inp_compid, v_inp_compid, v_inp_relagooid, v_inp_barcode, v_inp_warehousepos, v_orderamount, v_pcomeamount, v_inp_asngotamount, v_inp_gotamount, v_inp_retamount, v_picktime, v_shipmenttime, v_receivetime, v_colorname, v_itfname, v_status;
    ELSIF v_cnt = 1 AND v_isemptywhexists = 1 AND v_iswhequal = 0 THEN
      --当该asn条码存在空库位数据，构建执行 sql
      v_sql := 'UPDATE scmdata.t_asnordersitem_itf
   SET asngot_amount = :v_inp_asngotamount,
       got_amount    = :v_inp_gotamount,
       ret_amount    = :v_inp_retamount,
       pick_time     = :v_picktime,
       shipment_time = :v_shipmenttime,
       receive_time  = :v_receivetime,
       warehouse_pos = :v_inp_warehousepos,
       port_element  = :v_itfname,
       port_status   = :v_status,
       port_time     = SYSDATE
 WHERE asn_id = :v_inp_asnid
   AND company_id = :v_inp_compid
   AND goo_id = :v_inp_relagooid
   AND NVL(barcode, '' '') = NVL(:v_inp_barcode, '' '')';

      --执行 sql
      EXECUTE IMMEDIATE v_sql
        USING v_inp_asngotamount, v_inp_gotamount, v_inp_retamount, v_picktime, v_shipmenttime, v_receivetime, v_inp_warehousepos, v_itfname, v_status, v_inp_asnid, v_inp_compid, v_inp_relagooid, v_inp_barcode;
    ELSIF v_cnt = 1 AND v_isemptywhexists = 0 AND v_iswhequal = 1 THEN
      --当该asn条码不存在空库位数据，构建执行 sql
      v_sql := 'UPDATE scmdata.t_asnordersitem_itf
   SET asngot_amount = :v_inp_asngotamount,
       got_amount    = :v_inp_gotamount,
       ret_amount    = :v_inp_retamount,
       pick_time     = :v_picktime,
       shipment_time = :v_shipmenttime,
       receive_time  = :v_receivetime,
       port_element  = :v_itfname,
       port_status   = :v_status,
       port_time     = SYSDATE
 WHERE asn_id = :v_inp_asnid
   AND company_id = :v_inp_compid
   AND goo_id = :v_inp_relagooid
   AND NVL(barcode, '' '') = NVL(:v_inp_barcode, '' '')
   AND NVL(warehouse_pos, '' '') = NVL(:v_inp_warehousepos, '' '')';

      --执行 sql
      EXECUTE IMMEDIATE v_sql
        USING v_inp_asngotamount, v_inp_gotamount, v_inp_retamount, v_picktime, v_shipmenttime, v_receivetime, v_itfname, v_status, v_inp_asnid, v_inp_compid, v_inp_relagooid, v_inp_barcode, v_inp_warehousepos;
    END IF;

  EXCEPTION
    WHEN OTHERS THEN
      --错误信息赋值
      v_sqlerrm := substr(dbms_utility.format_error_stack, 1, 1024);
      v_errinfo := 'Error_Object: scmdata.pkg_qa_itf.p_receiveinfo_asnordersitemitfupd' ||
                   chr(10) || 'Error_message: ' || v_sqlerrm || chr(10) ||
                   'Error_Time::' ||
                   to_char(SYSDATE, 'yyyy-mm-dd hh24-mi-ss') || chr(10) ||
                   'Error_sql: ' || chr(10) || v_sql || chr(10) ||
                   'v_orderamount: ' || to_char(v_orderamount) || chr(10) ||
                   'v_pcomeamount: ' || to_char(v_pcomeamount) || chr(10) ||
                   'v_inp_asngotamount: ' || to_char(v_inp_asngotamount) ||
                   chr(10) || 'v_inp_gotamount: ' ||
                   to_char(v_inp_gotamount) || chr(10) ||
                   'v_inp_retamount: ' || to_char(v_inp_retamount) ||
                   chr(10) || 'v_picktime: ' || v_inp_picktime || chr(10) ||
                   'v_shipmenttime: ' || v_inp_shipmenttime || chr(10) ||
                   'v_receivetime: ' || v_inp_receivetime || chr(10) ||
                   'v_inp_warehousepos: ' || v_inp_warehousepos || chr(10) ||
                   'v_itfname: ' || v_itfname || chr(10) || 'v_status: ' ||
                   v_status || chr(10) || 'v_errinfo: ' || v_errinfo ||
                   chr(10) || 'v_inp_asnid: ' || v_inp_asnid || chr(10) ||
                   'v_inp_compid: ' || v_inp_compid || chr(10) ||
                   'v_inp_relagooid: ' || v_inp_relagooid || chr(10) ||
                   'v_inp_barcode: ' || v_inp_barcode;

      --更新接口状态及错误信息
      UPDATE scmdata.t_asnordersitem_itf
         SET port_status = 'UE', err_info = v_errinfo
       WHERE asn_id = v_inp_asnid
         AND goo_id = v_inp_relagooid
         AND nvl(barcode, ' ') = nvl(v_inp_barcode, ' ')
         AND company_id = v_inp_compid;
  END p_receiveinfo_asnordersitemitfupd;

  /*=================================================================================

    包：
      pkg_qa_itf(qa接口包)

    过程名:
      【上架信息更新接口】 asnordered 上架信息同步

    入参:
      v_inp_portstatus  :  接口状态

     版本:
       2022-11-18: asnordered 上架信息同步

  =================================================================================*/
  PROCEDURE p_receiveinfo_asnorderedsync(v_inp_portstatus IN VARCHAR2) IS
    v_portstatus    VARCHAR2(8);
    v_asnid         VARCHAR2(32);
    v_compid        VARCHAR2(32);
    v_status        VARCHAR2(32);
    v_scantime      DATE;
    v_pcomedate     DATE;
    v_pcomeinterval VARCHAR2(32);
    v_changetimes   NUMBER(8);
    v_sql           CLOB;
    v_errinfo       CLOB;
    v_sqlerrm       VARCHAR2(1024);
  BEGIN
    --接口状态赋值
    IF v_inp_portstatus = 'UE' THEN
      v_portstatus := 'UE';
    ELSE
      v_portstatus := 'UP';
    END IF;

    --循环取值
    FOR i IN (SELECT asn_id,
                     company_id,
                     pcome_date,
                     scan_time,
                     pcome_interval,
                     changetimes
                FROM scmdata.t_asnordered_itf editf
               WHERE port_element = 'itf_receiveinfo'
                 AND port_status = v_portstatus
                 AND port_time < SYSDATE - 1 / (24 * 60)
                 AND EXISTS
               (SELECT 1
                        FROM scmdata.t_asnordered
                       WHERE asn_id = editf.asn_id
                         AND company_id = editf.company_id)
               ORDER BY port_time
               FETCH FIRST 300 rows ONLY) LOOP
      BEGIN
        --参数赋值
        v_asnid         := i.asn_id;
        v_compid        := i.company_id;
        v_scantime      := i.scan_time;
        v_pcomedate     := i.pcome_date;
        v_pcomeinterval := i.pcome_interval;
        v_changetimes   := i.changetimes;

        --获取 asn状态
        v_status := scmdata.pkg_qa_da.f_get_asnstatus(v_inp_asnid  => v_asnid,
                                                      v_inp_compid => v_compid);

        --判断状态是否为“in-已进入”
        IF v_status = 'IN' THEN
          --执行 sql 赋值
          v_sql := 'UPDATE scmdata.t_asnordered
   SET status         = ''PC'',
       scan_time      = :v_scantime,
       changetimes    = :v_changetimes,
       pcome_date     = :v_pcomedate,
       pcome_interval = :v_pcomeinterval
 WHERE asn_id = :v_asnid
   AND company_id = :v_compid';

          --执行 sql
          EXECUTE IMMEDIATE v_sql
            USING v_scantime, v_changetimes, v_pcomedate, v_pcomeinterval, v_asnid, v_compid;
        ELSE
          --执行 sql 赋值
          v_sql := 'UPDATE scmdata.t_asnordered
   SET scan_time      = :v_scantime,
       changetimes    = :v_changetimes,
       pcome_date     = :v_pcomedate,
       pcome_interval = :v_pcomeinterval
 WHERE asn_id = :v_asnid
   AND company_id = :v_compid';

          --执行 sql
          EXECUTE IMMEDIATE v_sql
            USING v_scantime, v_changetimes, v_pcomedate, v_pcomeinterval, v_asnid, v_compid;
        END IF;

        --构建执行 sql
        v_sql := 'UPDATE scmdata.t_qa_report_skudim
   SET pcome_date = :v_pcomedate,
       scan_time  = :v_scantime
 WHERE asn_id = :v_asnid
   AND company_id = :v_compid';

        --执行 sql
        EXECUTE IMMEDIATE v_sql
          USING v_pcomedate, v_scantime, v_asnid, v_compid;

        --更新接口状态
        UPDATE scmdata.t_asnordered_itf
           SET port_status = 'US'
         WHERE asn_id = v_asnid
           AND company_id = v_compid;
      EXCEPTION
        WHEN OTHERS THEN
          --错误信息赋值
          v_sqlerrm := substr(dbms_utility.format_error_stack, 1, 1024);
          v_errinfo := 'Error_Object: scmdata.pkg_qa_itf.p_receiveinfo_asnorderedsync' ||
                       chr(10) || 'Error_message: ' || v_sqlerrm || chr(10) ||
                       'Error_Time:: ' ||
                       to_char(SYSDATE, 'yyyy-mm-dd hh24-mi-ss') || chr(10) ||
                       'Error_sql: ' || chr(10) || v_sql || chr(10) ||
                       'v_scantime: ' ||
                       to_char(v_scantime, 'yyyy-mm-dd hh24-mi-ss') ||
                       chr(10) || 'v_pcomeinterval: ' || v_pcomeinterval ||
                       chr(10) || 'v_pcomedate: ' ||
                       to_char(v_pcomedate, 'yyyy-mm-dd hh24-mi-ss') ||
                       chr(10) || 'v_changetimes: ' ||
                       to_char(v_changetimes) || chr(10) || 'v_asnid: ' ||
                       v_asnid || chr(10) || 'v_compid: ' || v_compid;

          --更新接口表状态和错误信息
          UPDATE scmdata.t_asnordered_itf
             SET port_status = 'UE', err_info = v_errinfo
           WHERE asn_id = v_asnid
             AND company_id = v_compid;
      END;
    END LOOP;
  END p_receiveinfo_asnorderedsync;

  /*=================================================================================

    包：
      pkg_qa_itf(qa接口包)

    过程名:
      【上架信息更新接口】 asnorders 上架信息刷新

    入参:
      v_inp_portstatus  :  接口状态

     版本:
       2022-12-01: asnorders 上架信息刷新

  =================================================================================*/
  PROCEDURE p_receiveinfo_asnordersitfupdrefresh(v_inp_asnid  IN VARCHAR2,
                                                 v_inp_compid IN VARCHAR2) IS
    v_ispretransinfoexists NUMBER(1);
    v_status               VARCHAR2(8);
    v_operuserid           VARCHAR2(32);
    v_errinfo              CLOB;
  BEGIN
    --判断是否存在预回传表数据
    SELECT nvl(MAX(1), 0)
      INTO v_ispretransinfoexists
      FROM scmdata.t_qa_pretranstowms
     WHERE asn_id = v_inp_asnid
       AND company_id = v_inp_compid
       AND status IN ('TE', 'CE')
       AND rownum = 1;

    --当存在错误的预回传表数据
    IF v_ispretransinfoexists = 1 THEN
      --获取预回传表状态，错误信息
      scmdata.pkg_qa_da.p_get_pretransstatusanderrinfo(v_inp_asnid   => v_inp_asnid,
                                                       v_inp_compid  => v_inp_compid,
                                                       v_inp_status  => v_status,
                                                       v_inp_errinfo => v_errinfo);

      --更新预回传表状态，错误信息
      UPDATE scmdata.t_qa_pretranstowms
         SET status = v_status, err_info = v_errinfo
       WHERE asn_id = v_inp_asnid
         AND company_id = v_inp_compid
         AND status IN ('TE', 'CE');

      --当 asn状态为免检或
      IF v_status IN ('AE', 'AF') THEN
        --获取 v_operuserid
        SELECT MAX(qualfinish_userid)
          INTO v_operuserid
          FROM (SELECT first_value(review_id) over(PARTITION BY asn_id, company_id ORDER BY qualfinish_time DESC) qualfinish_userid
                  FROM scmdata.t_qa_report_skudim
                 WHERE asn_id = v_inp_asnid
                   AND company_id = v_inp_compid);

        --已检列表刷新
        scmdata.pkg_qa_lc.p_iu_qaqualedlistsla(v_inp_asnid      => v_inp_asnid,
                                               v_inp_operuserid => v_operuserid,
                                               v_inp_compid     => v_inp_compid);
      END IF;
    END IF;
  END p_receiveinfo_asnordersitfupdrefresh;

  /*=================================================================================

    包：
      pkg_qa_itf(qa接口包)

    过程名:
      【上架信息更新接口】 asnorders 上架信息同步

    入参:
      v_inp_portstatus  :  接口状态

     版本:
       2022-11-18: asnorders 上架信息同步

  =================================================================================*/
  PROCEDURE p_receiveinfo_asnorderssync(v_inp_portstatus IN VARCHAR2) IS
    v_jugnum       NUMBER(1);
    v_portstatus   VARCHAR2(8);
    v_asnid        VARCHAR2(32);
    v_compid       VARCHAR2(32);
    v_asngotamount NUMBER(8);
    v_gotamount    NUMBER(8);
    v_retamount    NUMBER(8);
    v_picktime     DATE;
    v_shimenttime  DATE;
    v_receivetime  DATE;
    v_warehousepos VARCHAR2(1024);
    v_sql          CLOB;
    v_errinfo      CLOB;
    v_sqlerrm      VARCHAR2(1024);
  BEGIN
    --接口状态赋值
    IF v_inp_portstatus = 'UE' THEN
      v_portstatus := 'UE';
    ELSE
      v_portstatus := 'UP';
    END IF;

    --循环取值
    FOR i IN (SELECT asn_id,
                     company_id,
                     asngot_amount,
                     got_amount,
                     ret_amount,
                     pick_time,
                     shiment_time,
                     receive_time,
                     warehouse_pos
                FROM scmdata.t_asnorders_itf sitf
               WHERE port_element = 'itf_receiveinfo'
                 AND port_status = v_portstatus
                 AND port_time < SYSDATE - 1 / (24 * 60)
                 AND EXISTS
               (SELECT 1
                        FROM scmdata.t_asnorders
                       WHERE asn_id = sitf.asn_id
                         AND company_id = sitf.company_id)
               ORDER BY port_time
               FETCH FIRST 300 rows ONLY) LOOP
      BEGIN
        --参数赋值
        v_asnid        := i.asn_id;
        v_compid       := i.company_id;
        v_asngotamount := i.asngot_amount;
        v_gotamount    := i.got_amount;
        v_retamount    := i.ret_amount;
        v_picktime     := i.pick_time;
        v_shimenttime  := i.shiment_time;
        v_receivetime  := i.receive_time;
        v_warehousepos := i.warehouse_pos;

        --执行 sql 赋值
        v_sql := 'UPDATE scmdata.t_asnorders
   SET asngot_amount = :v_asngotamount,
       got_amount    = :v_gotamount,
       ret_amount    = :v_retamount,
       pick_time     = :v_picktime,
       shiment_time  = :v_shimenttime,
       receive_time  = :v_receivetime,
       warehouse_pos = :v_warehousepos
 WHERE asn_id = :v_asnid
   AND company_id = :v_compid';

        --执行 sql
        EXECUTE IMMEDIATE v_sql
          USING v_asngotamount, v_gotamount, v_retamount, v_picktime, v_shimenttime, v_receivetime, v_warehousepos, v_asnid, v_compid;

        --判断是否存在 sku级数据
        v_jugnum := f_is_asnhasskuleveldata(v_inp_asnid  => v_asnid,
                                            v_inp_compid => v_compid);

        IF v_jugnum = 0 THEN
          --构建执行 sql
          v_sql := 'UPDATE scmdata.t_qa_report_skudim
   SET got_amount = :v_gotamount,
       receive_time = :v_receivetime
 WHERE asn_id = :v_asnid
   AND company_id = :v_compid';

          --执行 sql
          EXECUTE IMMEDIATE v_sql
            USING v_gotamount, v_receivetime, v_asnid, v_compid;
        END IF;

        --asnorders 上架信息刷新
        p_receiveinfo_asnordersitfupdrefresh(v_inp_asnid  => v_asnid,
                                             v_inp_compid => v_compid);

        --更新接口状态
        UPDATE scmdata.t_asnorders_itf
           SET port_status = 'US'
         WHERE asn_id = v_asnid
           AND company_id = v_compid;
      EXCEPTION
        WHEN OTHERS THEN
          --错误信息赋值
          v_sqlerrm := substr(dbms_utility.format_error_stack, 1, 1024);
          v_errinfo := 'Error_Object: scmdata.pkg_qa_itf.p_receiveinfo_asnorderssync' ||
                       chr(10) || 'Error_message: ' || v_sqlerrm || chr(10) ||
                       'Error_Time:: ' ||
                       to_char(SYSDATE, 'yyyy-mm-dd hh24-mi-ss') || chr(10) ||
                       'Error_sql: ' || chr(10) || v_sql || chr(10) ||
                       'v_asngotamount: ' || to_char(v_asngotamount) ||
                       chr(10) || 'v_gotamount: ' || to_char(v_gotamount) ||
                       chr(10) || 'v_retamount: ' || to_char(v_retamount) ||
                       chr(10) || 'v_picktime: ' ||
                       to_char(v_picktime, 'yyyy-mm-dd hh24-mi-ss') ||
                       chr(10) || 'v_shimenttime: ' ||
                       to_char(v_shimenttime, 'yyyy-mm-dd hh24-mi-ss') ||
                       chr(10) || 'v_receivetime: ' ||
                       to_char(v_receivetime, 'yyyy-mm-dd hh24-mi-ss') ||
                       chr(10) || 'v_warehousepos: ' || v_warehousepos ||
                       chr(10) || 'v_asnid: ' || v_asnid || chr(10) ||
                       'v_compid: ' || v_compid;

          --接口状态及错误信息赋值
          UPDATE scmdata.t_asnorders_itf
             SET port_status = 'UE', err_info = v_errinfo
           WHERE asn_id = v_asnid
             AND company_id = v_compid;
      END;
    END LOOP;
  END p_receiveinfo_asnorderssync;

  /*=================================================================================

    包：
      pkg_qa_itf(qa接口包)

    过程名:
      【上架信息更新接口】 asnordersitem 上架信息刷新

    入参:
      v_inp_portstatus  :  接口状态

     版本:
       2022-12-01: asnordersitem 上架信息刷新

  =================================================================================*/
  PROCEDURE p_receiveinfo_asnordersitemitfupdrefresh(v_inp_asnid   IN VARCHAR2,
                                                     v_inp_gooid   IN VARCHAR2,
                                                     v_inp_barcode IN VARCHAR2,
                                                     v_inp_compid  IN VARCHAR2) IS
    v_transtype  VARCHAR2(8);
    v_status     VARCHAR2(8);
    v_operuserid VARCHAR2(32);
    v_errinfo    CLOB;
  BEGIN
    --获取asn状态
    SELECT MAX(status)
      INTO v_status
      FROM scmdata.t_asnordered
     WHERE asn_id = v_inp_asnid
       AND company_id = v_inp_compid;

    --获取该 asn回传类型
    SELECT MAX(trans_type)
      INTO v_transtype
      FROM scmdata.t_qa_pretranstowms
     WHERE asn_id = v_inp_asnid
       AND company_id = v_inp_compid;

    --判断回传类型
    IF v_transtype IN ('ASN', 'AE') THEN
      --获取预回传表状态，错误信息
      scmdata.pkg_qa_da.p_get_pretransstatusanderrinfo(v_inp_asnid   => v_inp_asnid,
                                                       v_inp_compid  => v_inp_compid,
                                                       v_inp_status  => v_status,
                                                       v_inp_errinfo => v_errinfo);

      --更新预回传表状态，错误信息
      UPDATE scmdata.t_qa_pretranstowms
         SET status = v_status, err_info = v_errinfo
       WHERE asn_id = v_inp_asnid
         AND company_id = v_inp_compid
         AND status IN ('TE', 'CE');
    ELSIF v_transtype = 'SKU' THEN
      --获取预回传表状态，错误信息
      scmdata.pkg_qa_da.p_get_pretransstatusanderrinfo(v_inp_asnid   => v_inp_asnid,
                                                       v_inp_compid  => v_inp_compid,
                                                       v_inp_gooid   => v_inp_gooid,
                                                       v_inp_barcode => v_inp_barcode,
                                                       v_inp_status  => v_status,
                                                       v_inp_errinfo => v_errinfo);

      --更新预回传表状态，错误信息
      UPDATE scmdata.t_qa_pretranstowms
         SET status = v_status, err_info = v_errinfo
       WHERE asn_id = v_inp_asnid
         AND goo_id = v_inp_gooid
         AND nvl(barcode, ' ') = nvl(v_inp_barcode, ' ')
         AND company_id = v_inp_compid
         AND status IN ('TE', 'CE');
    END IF;

    --当 asn状态为免检或
    IF v_status IN ('AE', 'AF') THEN
      --获取 v_operuserid
      SELECT MAX(qualfinish_userid)
        INTO v_operuserid
        FROM (SELECT first_value(review_id) over(PARTITION BY asn_id, company_id ORDER BY qualfinish_time DESC) qualfinish_userid
                FROM scmdata.t_qa_report_skudim
               WHERE asn_id = v_inp_asnid
                 AND company_id = v_inp_compid);

      --已检列表刷新
      scmdata.pkg_qa_lc.p_iu_qaqualedlistsla(v_inp_asnid      => v_inp_asnid,
                                             v_inp_operuserid => v_operuserid,
                                             v_inp_compid     => v_inp_compid);
    END IF;
  END p_receiveinfo_asnordersitemitfupdrefresh;

  /*=================================================================================

    包：
      pkg_qa_itf(qa接口包)

    过程名:
      【上架信息更新接口】 asnordersitem 上架信息同步

    入参:
      v_inp_portstatus  :  接口状态

     版本:
       2022-11-18: asnordersitem 上架信息同步

  =================================================================================*/
  PROCEDURE p_receiveinfo_asnordersitemsync(v_inp_portstatus IN VARCHAR2) IS
    v_portstatus   VARCHAR2(8);
    v_asnid        VARCHAR2(32);
    v_compid       VARCHAR2(32);
    v_relagooid    VARCHAR2(32);
    v_gooid        VARCHAR2(32);
    v_barcode      VARCHAR2(32);
    v_asngotamount NUMBER(8);
    v_gotamount    NUMBER(8);
    v_retamount    NUMBER(8);
    v_picktime     DATE;
    v_shipmenttime DATE;
    v_receivetime  DATE;
    v_warehousepos VARCHAR2(1024);
    v_colorname    VARCHAR2(32);
    v_sql          CLOB;
    v_errinfo      CLOB;
    v_sqlerrm      VARCHAR2(1024);
  BEGIN
    --接口状态赋值
    IF v_inp_portstatus = 'UE' THEN
      v_portstatus := 'UE';
    ELSE
      v_portstatus := 'UP';
    END IF;

    --循环取值
    FOR i IN (SELECT sitemitf.asn_id,
                     sitemitf.company_id,
                     goo.goo_id,
                     sitemitf.barcode,
                     MAX(sitemitf.goo_id) rela_goo_id,
                     MAX(nvl(sitemitf.asngot_amount, 0)) asngot_amount,
                     SUM(nvl(sitemitf.got_amount, 0)) got_amount,
                     SUM(nvl(sitemitf.ret_amount, 0)) ret_amount,
                     MAX(sitemitf.pick_time) pick_time,
                     MAX(sitemitf.shipment_time) shipment_time,
                     MAX(sitemitf.receive_time) receive_time,
                     listagg(sitemitf.warehouse_pos, ';') warehouse_pos,
                     MAX(sitemitf.color_name) color_name
                FROM scmdata.t_asnordersitem_itf sitemitf
               INNER JOIN scmdata.t_commodity_info goo
                  ON sitemitf.goo_id = goo.rela_goo_id
                 AND sitemitf.company_id = goo.company_id
               WHERE sitemitf.port_element = 'itf_receiveinfo'
                 AND sitemitf.port_status = v_portstatus
                 AND sitemitf.port_time < SYSDATE - 1 / (24 * 60)
                 AND EXISTS
               (SELECT 1
                        FROM scmdata.t_asnordersitem
                       WHERE asn_id = sitemitf.asn_id
                         AND goo_id = goo.goo_id
                         AND nvl(barcode, ' ') = nvl(sitemitf.barcode, ' ')
                         AND company_id = sitemitf.company_id)
               GROUP BY sitemitf.asn_id,
                        sitemitf.company_id,
                        goo.goo_id,
                        sitemitf.barcode
               ORDER BY MAX(port_time)
               FETCH FIRST 1500 rows ONLY) LOOP
      BEGIN
        --参数赋值
        v_asnid        := i.asn_id;
        v_compid       := i.company_id;
        v_relagooid    := i.rela_goo_id;
        v_gooid        := i.goo_id;
        v_barcode      := i.barcode;
        v_asngotamount := i.asngot_amount;
        v_gotamount    := i.got_amount;
        v_retamount    := i.ret_amount;
        v_picktime     := i.pick_time;
        v_shipmenttime := i.shipment_time;
        v_receivetime  := i.receive_time;
        v_warehousepos := i.warehouse_pos;
        v_colorname    := i.color_name;

        --执行 sql 赋值
        v_sql := 'UPDATE scmdata.t_asnordersitem
   SET asngot_amount = :v_asngotamount,
       got_amount    = :v_gotamount,
       ret_amount    = :v_retamount,
       pick_time     = :v_picktime,
       shipment_time = :v_shipmenttime,
       receive_time  = :v_receivetime,
       warehouse_pos = :v_warehousepos,
       color_name    = :v_colorname
 WHERE asn_id = :v_asnid
   AND company_id = :v_compid
   AND goo_id = :v_gooid
   AND NVL(barcode, '' '') = NVL(:v_barcode, '' '')';

        --执行 sql
        EXECUTE IMMEDIATE v_sql
          USING v_asngotamount, v_gotamount, v_retamount, v_picktime, v_shipmenttime, v_receivetime, v_warehousepos, v_colorname, v_asnid, v_compid, v_gooid, v_barcode;

        --构建执行 sql
        v_sql := 'UPDATE scmdata.t_qa_report_skudim
   SET got_amount = :v_gotamount,
       receive_time = :v_receivetime
 WHERE asn_id = :v_asnid
   AND goo_id = :v_gooid
   AND NVL(barcode, '' '') = NVL(:v_barcode, '' '')
   AND company_id = :v_compid';

        --执行 sql
        EXECUTE IMMEDIATE v_sql
          USING v_gotamount, v_receivetime, v_asnid, v_gooid, v_barcode, v_compid;

        --质检报告数据维度刷新
        p_receiveinfo_refreshrepunqualamount(v_inp_asnid  => v_asnid,
                                             v_inp_compid => v_compid);

        --asnordersitem 上架信息刷新
        p_receiveinfo_asnordersitemitfupdrefresh(v_inp_asnid   => v_asnid,
                                                 v_inp_gooid   => v_gooid,
                                                 v_inp_barcode => v_barcode,
                                                 v_inp_compid  => v_compid);

        --更新接口状态
        UPDATE scmdata.t_asnordersitem_itf
           SET port_status = 'US'
         WHERE asn_id = v_asnid
           AND goo_id = v_relagooid
           AND nvl(barcode, ' ') = nvl(v_barcode, ' ')
           AND company_id = v_compid;
      EXCEPTION
        WHEN OTHERS THEN
          --错误信息赋值
          v_sqlerrm := substr(dbms_utility.format_error_stack, 1, 1024);
          v_errinfo := 'Error_Object: scmdata.pkg_qa_itf.p_receiveinfo_asnordersitemsync' ||
                       chr(10) || 'Error_message: ' || v_sqlerrm || chr(10) ||
                       'Error_Time:: ' ||
                       to_char(SYSDATE, 'yyyy-mm-dd hh24-mi-ss') || chr(10) ||
                       'Error_sql: ' || chr(10) || v_sql || chr(10) ||
                       'v_asngotamount: ' || to_char(v_asngotamount) ||
                       chr(10) || 'v_gotamount: ' || to_char(v_gotamount) ||
                       chr(10) || 'v_retamount: ' || to_char(v_retamount) ||
                       chr(10) || 'v_picktime: ' ||
                       to_char(v_picktime, 'yyyy-mm-dd hh24-mi-ss') ||
                       chr(10) || 'v_shipmenttime: ' ||
                       to_char(v_shipmenttime, 'yyyy-mm-dd hh24-mi-ss') ||
                       chr(10) || 'v_receivetime: ' ||
                       to_char(v_receivetime, 'yyyy-mm-dd hh24-mi-ss') ||
                       chr(10) || 'v_warehousepos: ' || v_warehousepos ||
                       chr(10) || 'v_asnid: ' || v_asnid || chr(10) ||
                       'v_compid: ' || v_compid || chr(10) || 'v_gooid: ' ||
                       v_gooid || chr(10) || 'v_barcode: ' || v_barcode ||
                       chr(10) || 'v_colorname: ' || v_colorname;

          --接口状态及错误信息赋值
          UPDATE scmdata.t_asnordersitem_itf
             SET port_status = 'UE', err_info = v_errinfo
           WHERE asn_id = v_asnid
             AND goo_id = v_relagooid
             AND nvl(barcode, ' ') = nvl(v_barcode, ' ')
             AND company_id = v_compid;
      END;
    END LOOP;
  END p_receiveinfo_asnordersitemsync;

  /*=================================================================================

    包：
      pkg_qa_itf(qa接口包)

    过程名:
      【asn结束接口】asn结束

    入参:
      v_inp_asnid       :  asn单号
      v_inp_compid      :  企业id
      v_inp_isfinished  :  是否结束 0-未结束 1-已结束

     版本:
       2022-11-17: qa质检任务 asnorders 数据同步

  =================================================================================*/
  PROCEDURE p_asnfinish_asnorderedupd(v_inp_asnid      IN VARCHAR2,
                                      v_inp_compid     IN VARCHAR2,
                                      v_inp_isfinished IN NUMBER) IS

  BEGIN
    IF v_inp_asnid IS NOT NULL AND v_inp_compid IS NOT NULL THEN
      UPDATE scmdata.t_asnordered
         SET is_asnfinished = v_inp_isfinished
       WHERE asn_id = v_inp_asnid
         AND company_id = v_inp_compid;
    END IF;
  END p_asnfinish_asnorderedupd;

  /*=================================================================================

    包：
      pkg_qa_itf(qa接口包)

    过程名:
      【asnorderpacks接口】 asnorderpacks 对 t_qa_pretranstowms 刷新

    入参:
      v_inp_asnid   :  asn单号
      v_inp_compid  :  企业id

     版本:
       2023-01-20: asnorderpacks 对 t_qa_pretranstowms 刷新

  =================================================================================*/
  PROCEDURE p_asnorderpacks_refreshpretransinfo(v_inp_asnid  IN VARCHAR2,
                                                v_inp_compid IN VARCHAR2) IS
    v_cnt       NUMBER(8);
    v_status    VARCHAR2(8);
    v_errinfo   CLOB;
    v_asnid     VARCHAR2(32);
    v_compid    VARCHAR2(32);
    v_transtype VARCHAR2(8);
    v_gooid     VARCHAR2(32);
    v_barcode   VARCHAR2(32);
    v_sql       CLOB;
    v_sqlerrm   VARCHAR2(1024);
  BEGIN
    SELECT COUNT(1)
      INTO v_cnt
      FROM scmdata.t_asnorderpacks_itf
     WHERE asn_id = v_inp_asnid
       AND company_id = v_inp_compid
       AND port_status = 'SP';

    IF v_cnt = 0 THEN
      FOR i IN (SELECT asn_id, company_id, goo_id, barcode, trans_type
                  FROM scmdata.t_qa_pretranstowms
                 WHERE asn_id = v_inp_asnid
                   AND company_id = v_inp_compid
                   AND status IN ('CE', 'TE')) LOOP
        BEGIN
          --变量赋值
          v_asnid     := i.asn_id;
          v_compid    := i.company_id;
          v_transtype := i.trans_type;
          v_gooid     := i.goo_id;
          v_barcode   := i.barcode;

          --判断回传类型
          IF v_transtype IN ('ASN', 'AE') THEN
            --获取预回传表状态，错误信息
            scmdata.pkg_qa_da.p_get_pretransstatusanderrinfo(v_inp_asnid   => v_asnid,
                                                             v_inp_compid  => v_compid,
                                                             v_inp_status  => v_status,
                                                             v_inp_errinfo => v_errinfo);

            --更新预回传表状态，错误信息
            v_sql := 'UPDATE scmdata.t_qa_pretranstowms
           SET status = :v_status, err_info = :v_errinfo
         WHERE asn_id = :v_asnid
           AND company_id = :v_compid
           AND status IN (''TE'', ''CE'')';

            EXECUTE IMMEDIATE v_sql
              USING v_status, v_errinfo, v_asnid, v_compid;
          ELSIF v_transtype = 'SKU' THEN
            --获取预回传表状态，错误信息
            scmdata.pkg_qa_da.p_get_pretransstatusanderrinfo(v_inp_asnid   => v_asnid,
                                                             v_inp_compid  => v_compid,
                                                             v_inp_gooid   => v_gooid,
                                                             v_inp_barcode => v_barcode,
                                                             v_inp_status  => v_status,
                                                             v_inp_errinfo => v_errinfo);

            --更新预回传表状态，错误信息
            v_sql := 'UPDATE scmdata.t_qa_pretranstowms
           SET status = :v_status, err_info = :v_errinfo
         WHERE asn_id = :v_asnid
           AND goo_id = :v_gooid
           AND nvl(barcode, '' '') = nvl(:v_barcode, '' '')
           AND company_id = :v_compid
           AND status IN (''TE'', ''CE'')';

            EXECUTE IMMEDIATE v_sql
              USING v_status, v_errinfo, v_asnid, v_gooid, v_barcode, v_compid;
          END IF;
        EXCEPTION
          WHEN OTHERS THEN
            --错误信息赋值
            v_sqlerrm := substr(dbms_utility.format_error_stack, 1, 1024);
            v_errinfo := 'Error_Object: scmdata.pkg_qa_itf.p_receiveinfo_asnordersitemsync' ||
                         chr(10) || 'Error_message: ' || v_sqlerrm ||
                         chr(10) || 'Error_Time: ' ||
                         to_char(SYSDATE, 'yyyy-mm-dd hh24-mi-ss') ||
                         chr(10) || 'Error_sql: ' || chr(10) || v_sql ||
                         chr(10) || 'v_status: ' || v_status || chr(10) ||
                         'v_errinfo: ' || v_errinfo || chr(10) ||
                         'v_asnid: ' || v_asnid || chr(10) || 'v_gooid: ' ||
                         v_gooid || chr(10) || 'v_barcode: ' || v_barcode ||
                         chr(10) || 'v_compid: ' || v_compid;

            --新增进入错误信息表
            scmdata.pkg_qa_ee.p_ins_errrecord_at(v_inp_errprogram     => 'scmdata.pkg_qa_itf.p_asnorderpacks_refreshpretransinfo',
                                                 v_inp_causeerruserid => 'asnorderpacks_sync',
                                                 v_inp_erroccurtime   => SYSDATE,
                                                 v_inp_errinfo        => v_errinfo,
                                                 v_inp_compid         => v_inp_compid);
        END;
      END LOOP;
    END IF;
  END p_asnorderpacks_refreshpretransinfo;

  /*=================================================================================

    包：
      pkg_qa_itf(qa接口包)

    过程名:
      【asnorderpacks接口】 asnorderpacks增改

    入参:
      v_inp_asnid          :  asn单号
      v_inp_compid         :  企业id
      v_inp_operatorid     :  操作人id
      v_inp_relagooid      :  货号
      v_inp_goodsid        :  货号/条码，货号为空取条码
      v_inp_barcode        :  条码
      v_inp_packfno        :  包序号
      v_inp_packbarcode    :  收货标签条码
      v_inp_packsno        :  总箱数序号
      v_inp_packcount      :  总箱数
      v_inp_packamount     :  包装数量
      v_inp_skupackno      :  sku序号
      v_inp_skupackcount   :  sku总箱数
      v_inp_skunumber      :  sku数量
      v_inp_ratioid        :  配码比
      v_inp_packspecssend  :  送货包装规格
      v_inp_memo           :  备注

     版本:
       2022-11-19: asnorderpacks增改

  =================================================================================*/
  PROCEDURE p_asnorderpacks_iuasnorderpacksitf(v_inp_asnid         IN VARCHAR2,
                                               v_inp_compid        IN VARCHAR2,
                                               v_inp_operatorid    IN VARCHAR2,
                                               v_inp_relagooid     IN VARCHAR2,
                                               v_inp_goodsid       IN VARCHAR2,
                                               v_inp_barcode       IN VARCHAR2,
                                               v_inp_packfno       IN VARCHAR2,
                                               v_inp_packbarcode   IN VARCHAR2,
                                               v_inp_packsno       IN NUMBER,
                                               v_inp_packcount     IN NUMBER,
                                               v_inp_packamount    IN NUMBER,
                                               v_inp_skupackno     IN NUMBER,
                                               v_inp_skupackcount  IN NUMBER,
                                               v_inp_skunumber     IN NUMBER,
                                               v_inp_ratioid       IN NUMBER,
                                               v_inp_packspecssend IN NUMBER,
                                               v_inp_memo          IN VARCHAR2) IS
    v_jugnum  NUMBER(1);
    v_status  VARCHAR2(8) := 'SP';
    v_itfname VARCHAR2(32) := 'asnorderpacks';
    v_sql     CLOB;
    v_errinfo CLOB;
    v_sqlerrm VARCHAR2(1024);
  BEGIN
    --校验是否存在于 scmdata.t_asnorderpacks_itf
    v_jugnum := f_is_asnorderpacksitfexists(v_inp_asnid       => v_inp_asnid,
                                            v_inp_compid      => v_inp_compid,
                                            v_inp_relagooid   => v_inp_relagooid,
                                            v_inp_barcode     => v_inp_barcode,
                                            v_inp_packbarcode => v_inp_packbarcode);

    IF v_jugnum = 0 THEN
      v_status := 'SP';
      v_sql    := 'INSERT INTO scmdata.t_asnorderpacks_itf
  (asn_id,
   company_id,
   dc_company_id,
   operator_id,
   goo_id,
   goodsid,
   barcode,
   pack_no,
   pack_barcode,
   packno,
   packcount,
   packamount,
   skupack_no,
   skupack_count,
   sku_number,
   ratioid,
   pack_specs_send,
   memo,
   create_id,
   create_time,
   port_element,
   port_status,
   port_time,
   err_info)
VALUES
  (:v_inp_asnid,
   :v_inp_compid,
   :v_inp_compid,
   :v_inp_operatorid,
   :v_inp_relagooid,
   :v_inp_goodsid,
   :v_inp_barcode,
   :v_inp_packfno,
   :v_inp_packbarcode,
   :v_inp_packsno,
   :v_inp_packcount,
   :v_inp_packamount,
   :v_inp_skupackno,
   :v_inp_skupackcount,
   :v_inp_skunumber,
   :v_inp_ratioid,
   :v_inp_packspecssend,
   :v_inp_memo,
   ''SYS'',
   SYSDATE,
   :v_itfname,
   :v_status,
   SYSDATE,
   :v_errinfo)';
      EXECUTE IMMEDIATE v_sql
        USING v_inp_asnid, v_inp_compid, v_inp_compid, v_inp_operatorid, v_inp_relagooid, v_inp_goodsid, v_inp_barcode, v_inp_packfno, v_inp_packbarcode, v_inp_packsno, v_inp_packcount, v_inp_packamount, v_inp_skupackno, v_inp_skupackcount, v_inp_skunumber, v_inp_ratioid, v_inp_packspecssend, v_inp_memo, v_itfname, v_status, v_errinfo;
    ELSE
      v_sql := 'UPDATE scmdata.t_asnorderpacks_itf
   SET operator_id     = :v_inp_operatorid,
       pack_no         = :v_inp_packfno,
       pack_barcode    = :v_inp_packbarcode,
       packno          = :v_inp_packsno,
       packcount       = :v_inp_packcount,
       packamount      = :v_inp_packamount,
       skupack_no      = :v_inp_skupackno,
       skupack_count   = :v_inp_skupackcount,
       sku_number      = :v_inp_skunumber,
       ratioid         = :v_inp_ratioid,
       pack_specs_send = :v_inp_packspecssend,
       memo            = :v_inp_memo,
       port_status     = :v_status,
       port_time       = SYSDATE
 WHERE asn_id = :v_inp_asnid
   AND goo_id = :v_inp_relagooid
   AND goodsid = :v_inp_goodsid
   AND pack_barcode = :v_inp_packbarcode
   AND company_id = :v_inp_compid';
      EXECUTE IMMEDIATE v_sql
        USING v_inp_operatorid, v_inp_packfno, v_inp_packbarcode, v_inp_packsno, v_inp_packcount, v_inp_packamount, v_inp_skupackno, v_inp_skupackcount, v_inp_skunumber, v_inp_ratioid, v_inp_packspecssend, v_inp_memo, v_status, v_inp_asnid, v_inp_relagooid, v_inp_goodsid, v_inp_packbarcode, v_inp_compid;
    END IF;
  EXCEPTION
    WHEN OTHERS THEN
      --错误信息赋值
      v_sqlerrm := substr(dbms_utility.format_error_stack, 1, 1024);
      v_errinfo := 'Error_Object: scmdata.pkg_qa_itf.p_receiveinfo_asnordersitemsync' ||
                   chr(10) || 'Error_message: ' || v_sqlerrm || chr(10) ||
                   'Error_Time:: ' ||
                   to_char(SYSDATE, 'yyyy-mm-dd hh24-mi-ss') || chr(10) ||
                   'Error_sql: ' || chr(10) || v_sql || chr(10) ||
                   'v_inp_asnid: ' || v_inp_asnid || chr(10) ||
                   'v_inp_compid: ' || v_inp_compid || chr(10) ||
                   'v_inp_operatorid: ' || v_inp_operatorid || chr(10) ||
                   'v_inp_relagooid: ' || v_inp_relagooid || chr(10) ||
                   'v_inp_goodsid: ' || v_inp_goodsid || chr(10) ||
                   'v_inp_barcode: ' || v_inp_barcode || chr(10) ||
                   'v_inp_packfno: ' || v_inp_packfno || chr(10) ||
                   'v_inp_packbarcode: ' || v_inp_packbarcode || chr(10) ||
                   'v_inp_packsno: ' || to_char(v_inp_packsno) || chr(10) ||
                   'v_inp_packamount: ' || to_char(v_inp_packamount) ||
                   chr(10) || 'v_inp_skupackno: ' ||
                   to_char(v_inp_skupackno) || chr(10) ||
                   'v_inp_skupackcount: ' || to_char(v_inp_skupackcount) ||
                   chr(10) || 'v_inp_skunumber: ' ||
                   to_char(v_inp_skunumber) || chr(10) || 'v_inp_ratioid: ' ||
                   v_inp_ratioid || chr(10) || 'v_inp_packspecssend: ' ||
                   v_inp_packspecssend || chr(10) || 'v_inp_memo: ' ||
                   v_inp_memo;

      --接口状态及错误信息赋值
      UPDATE scmdata.t_asnorderpacks_itf
         SET port_status = 'SE', err_info = v_errinfo
       WHERE asn_id = v_inp_asnid
         AND goo_id = v_inp_relagooid
         AND nvl(barcode, ' ') = nvl(v_inp_barcode, ' ')
         AND company_id = v_inp_compid;
  END p_asnorderpacks_iuasnorderpacksitf;

  /*=================================================================================

    包：
      pkg_qa_itf(qa接口包)

    过程名:
      【asnorderpacks接口】 asnorderpacks增改

    入参:
      v_inp_asnid          :  asn单号
      v_inp_compid         :  企业id
      v_inp_operatorid     :  操作人id
      v_inp_relagooid      :  货号
      v_inp_goodsid        :  货号/条码，货号为空取条码
      v_inp_barcode        :  条码
      v_inp_packfno        :  包序号
      v_inp_packbarcode    :  收货标签条码
      v_inp_packsno        :  总箱数序号
      v_inp_packcount      :  总箱数
      v_inp_packamount     :  包装数量
      v_inp_skupackno      :  sku序号
      v_inp_skupackcount   :  sku总箱数
      v_inp_skunumber      :  sku数量
      v_inp_ratioid        :  配码比
      v_inp_packspecssend  :  送货包装规格
      v_inp_memo           :  备注

     版本:
       2022-11-19: asnorderpacks增改

  =================================================================================*/
  PROCEDURE p_asnorderpacks_asnorderpacksitfsync IS
    v_jugnum        NUMBER(1);
    v_itfname       VARCHAR2(32) := 'asnorderpacks';
    v_asnid         VARCHAR2(32);
    v_compid        VARCHAR2(32);
    v_operatorid    VARCHAR2(32);
    v_gooid         VARCHAR2(32);
    v_relagooid     VARCHAR2(32);
    v_barcode       VARCHAR2(32);
    v_packfno       NUMBER;
    v_packbarcode   VARCHAR2(32);
    v_packsno       NUMBER;
    v_packcount     NUMBER;
    v_packamount    NUMBER;
    v_skupackno     NUMBER;
    v_skupackcount  NUMBER;
    v_skunumber     NUMBER;
    v_ratioid       NUMBER;
    v_packspecssend NUMBER;
    v_memo          VARCHAR2(512);
    v_createid      VARCHAR2(32);
    v_createtime    DATE;
    v_updateid      VARCHAR2(32);
    v_updatetime    DATE;
    v_goodsid       VARCHAR2(32);
    v_sqlerrmsg     VARCHAR2(1024);
    v_sql           CLOB;
    v_errinfo       CLOB;
  BEGIN
    FOR i IN (SELECT itf.asn_id,
                     itf.company_id,
                     itf.operator_id,
                     goo.goo_id,
                     itf.goo_id rela_goo_id,
                     itf.barcode,
                     itf.pack_no,
                     itf.pack_barcode,
                     itf.packno,
                     itf.packcount,
                     itf.packamount,
                     itf.skupack_no,
                     itf.skupack_count,
                     itf.sku_number,
                     itf.ratioid,
                     itf.pack_specs_send,
                     itf.memo,
                     itf.create_id,
                     itf.create_time,
                     itf.update_id,
                     itf.update_time,
                     itf.goodsid
                FROM scmdata.t_asnorderpacks_itf itf
               INNER JOIN scmdata.t_commodity_info goo
                  ON itf.goo_id = goo.rela_goo_id
                 AND itf.company_id = goo.company_id
               WHERE port_status = 'SP'
                 AND port_time < SYSDATE - 1 / (24 * 60)) LOOP
      BEGIN
        --变量赋值
        v_asnid         := i.asn_id;
        v_compid        := i.company_id;
        v_operatorid    := i.operator_id;
        v_gooid         := i.goo_id;
        v_relagooid     := i.rela_goo_id;
        v_barcode       := i.barcode;
        v_packfno       := i.pack_no;
        v_packbarcode   := i.pack_barcode;
        v_packsno       := i.packno;
        v_packcount     := i.packcount;
        v_packamount    := i.packamount;
        v_skupackno     := i.skupack_no;
        v_skupackcount  := i.skupack_count;
        v_skunumber     := i.sku_number;
        v_ratioid       := i.ratioid;
        v_packspecssend := i.pack_specs_send;
        v_memo          := i.memo;
        v_createid      := i.create_id;
        v_createtime    := i.create_time;
        v_updateid      := i.update_id;
        v_updatetime    := i.update_time;
        v_goodsid       := i.goodsid;

        --判断是否存在
        v_jugnum := f_is_asnorderpacksexists(v_inp_asnid       => i.asn_id,
                                             v_inp_compid      => i.company_id,
                                             v_inp_relagooid   => i.goo_id,
                                             v_inp_barcode     => i.barcode,
                                             v_inp_packbarcode => i.pack_barcode);

        IF v_jugnum = 0 THEN
          IF v_packcount > 0 THEN
            v_sql := 'INSERT INTO scmdata.t_asnorderpacks
  (asn_id,
   company_id,
   dc_company_id,
   operator_id,
   goo_id,
   barcode,
   pack_no,
   pack_barcode,
   packno,
   packcount,
   packamount,
   skupack_no,
   skupack_count,
   sku_number,
   ratioid,
   pack_specs_send,
   memo,
   create_id,
   create_time,
   goodsid)
VALUES
  (:v_asnid,
   :v_compid,
   :v_compid,
   :v_operatorid,
   :v_gooid,
   :v_barcode,
   :v_packfno,
   :v_packbarcode,
   :v_packsno,
   :v_packcount,
   :v_packamount,
   :v_skupackno,
   :v_skupackcount,
   :v_skunumber,
   :v_ratioid,
   :v_packspecssend,
   :v_memo,
   :v_createid,
   :v_createtime,
   :v_goodsid)';
            EXECUTE IMMEDIATE v_sql
              USING v_asnid, v_compid, v_compid, v_operatorid, v_gooid, v_barcode, v_packfno, v_packbarcode, v_packsno, v_packcount, v_packamount, v_skupackno, v_skupackcount, v_skunumber, v_ratioid, v_packspecssend, v_memo, v_createid, v_createtime, v_goodsid;
          END IF;
        ELSE
          IF v_packcount > 0 THEN
            v_sql := 'UPDATE scmdata.t_asnorderpacks
   SET packcount       = :v_packcount,
       packamount      = :v_packamount,
       skupack_count   = :v_skupackcount,
       sku_number      = :v_skunumber,
       ratioid         = :v_ratioid,
       pack_specs_send = :v_packspecssend,
       memo            = :v_memo,
       update_id       = :v_updateid,
       update_time     = :v_udpatetime
 WHERE asn_id = :v_asnid
   AND goo_id = :v_gooid
   AND nvl(barcode, '' '') = nvl(:v_barcode, '' '')
   AND pack_barcode = :v_packbarcode
   AND company_id = :v_compid';
            EXECUTE IMMEDIATE v_sql
              INTO v_packcount, v_packamount, v_skupackcount, v_skunumber, v_ratioid, v_packspecssend, v_memo, v_updateid, v_updatetime, v_asnid, v_gooid, v_barcode, v_packbarcode, v_compid;
          ELSE
            v_sql := 'DELETE FROM scmdata.t_asnorderpacks
 WHERE asn_id = :v_asnid
   AND goo_id = :v_gooid
   AND nvl(barcode, '' '') = nvl(:v_barcode, '' '')
   AND pack_barcode = :v_packbarcode
   AND company_id = :v_compid';
            EXECUTE IMMEDIATE v_sql
              USING v_asnid, v_gooid, v_barcode, v_packbarcode, v_compid;
          END IF;
        END IF;

        v_sql := 'UPDATE scmdata.t_asnorderpacks_itf
   SET port_status = ''SS'',
       port_time = SYSDATE
 WHERE asn_id = :v_asnid
   AND goo_id = :v_relagooid
   AND nvl(barcode, '' '') = nvl(:v_barcode, '' '')
   AND pack_barcode = :v_packbarcode
   AND company_id = :v_compid';
        EXECUTE IMMEDIATE v_sql
          USING v_asnid, v_relagooid, v_barcode, v_packbarcode, v_compid;

        p_asnorderpacks_refreshpretransinfo(v_inp_asnid  => v_asnid,
                                            v_inp_compid => v_compid);
      EXCEPTION
        WHEN OTHERS THEN
          v_sqlerrmsg := substr(dbms_utility.format_error_stack, 1, 1024);
          --错误信息赋值
          v_errinfo := 'Error_Object: scmdata.pkg_qa_itf.p_asnorderpacks_asnorderpacksitfsync' ||
                       chr(10) || 'Error_message: ' || v_sqlerrmsg ||
                       chr(10) || 'Error_Time:: ' ||
                       to_char(SYSDATE, 'yyyy-mm-dd hh24-mi-ss') || chr(10) ||
                       'Error_sql: ' || chr(10) || v_sql || chr(10) ||
                       'v_asnid: ' || v_asnid || chr(10) || 'v_compid: ' ||
                       v_compid || chr(10) || 'v_operatorid: ' ||
                       v_operatorid || chr(10) || 'v_gooid: ' || v_gooid ||
                       chr(10) || 'v_barcode: ' || v_barcode || chr(10) ||
                       'v_packfno: ' || to_char(v_packfno) || chr(10) ||
                       'v_packbarcode: ' || v_packbarcode || chr(10) ||
                       'v_packsno: ' || to_char(v_packsno) || chr(10) ||
                       'v_packcount: ' || to_char(v_packcount) || chr(10) ||
                       'v_packamount: ' || to_char(v_packamount) || chr(10) ||
                       'v_skupackno: ' || to_char(v_skupackno) || chr(10) ||
                       'v_skupackcount: ' || to_char(v_skupackcount) ||
                       chr(10) || 'v_skunumber: ' || to_char(v_skunumber) ||
                       chr(10) || 'v_ratioid: ' || to_char(v_ratioid) ||
                       chr(10) || 'v_packspecssend: ' ||
                       to_char(v_packspecssend) || chr(10) || 'v_memo: ' ||
                       v_memo || chr(10) || 'v_createid: ' || v_createid ||
                       chr(10) || 'v_createtime: ' ||
                       to_char(v_createtime, 'yyyy-mm-dd hh24-mi-ss') ||
                       chr(10) || 'v_updateid: ' || v_updateid || chr(10) ||
                       'v_udpatetime: ' ||
                       to_char(v_updatetime, 'yyyy-mm-dd hh24-mi-ss') ||
                       chr(10) || 'v_itfname: ' || v_itfname;

          UPDATE scmdata.t_asnorderpacks_itf
             SET port_status = 'SE', err_info = v_errinfo
           WHERE asn_id = v_asnid
             AND company_id = v_compid
             AND goo_id = v_relagooid
             AND nvl(barcode, ' ') = nvl(v_barcode, ' ')
             AND nvl(pack_barcode, ' ') = nvl(v_packbarcode, ' ');
      END;
    END LOOP;
  END p_asnorderpacks_asnorderpacksitfsync;

  /*=================================================================================

    包：
      pkg_qa_itf(qa接口包)

    过程名:
      【scm质检结果传给wms接口】根据质检报告 asn分配次品

    入参:
      v_inp_qarepid  :  质检报告id
      v_inp_asnid    :  asn单号
      v_inp_compid   :  企业id

     版本:
       2022-12-05: 根据质检报告 asn分配次品

  =================================================================================*/
  PROCEDURE p_scmtwms_allocatedsubsamountbyrepasn(v_inp_qarepid IN VARCHAR2,
                                                  v_inp_asnid   IN VARCHAR2,
                                                  v_inp_compid  IN VARCHAR2) IS
    v_jugnum            NUMBER(1);
    v_alqualdecreamount NUMBER(8);
    v_subsamount        NUMBER(8);
    v_restamount        NUMBER(8);
  BEGIN
    --判断是否该 sku的 asnorderpacks_itf 是否全部同步正常
    SELECT nvl(MAX(1), 0)
      INTO v_jugnum
      FROM scmdata.t_asnorderpacks_itf
     WHERE asn_id = v_inp_asnid
       AND company_id = v_inp_compid
       AND port_status <> 'SS';

    IF v_jugnum = 1 THEN
      --更新状态和错误信息
      UPDATE scmdata.t_qa_pretranstowms
         SET status   = 'CE',
             err_info = '该 Asn的 Asnorderpacks_itf 同步不正常'
       WHERE asn_id = v_inp_asnid
         AND company_id = v_inp_compid;
    ELSE
      --获取已质检数据
      FOR i IN (SELECT asn_id,
                       goo_id,
                       barcode,
                       color_name,
                       company_id,
                       qualdecrease_amount
                  FROM scmdata.t_qa_report_skudim
                 WHERE qa_report_id = v_inp_qarepid
                   AND asn_id = v_inp_asnid
                   AND company_id = v_inp_compid
                   AND qualdecrease_amount > 0
                   AND trans_result <> 'RT'
                   AND status = 'AF') LOOP
        IF instr(i.barcode, '*') = 0 THEN
          --获取已减减数
          v_alqualdecreamount := f_scmtwms_getskualqualdecreamount(v_inp_asnid   => i.asn_id,
                                                                   v_inp_compid  => i.company_id,
                                                                   v_inp_gooid   => i.goo_id,
                                                                   v_inp_barcode => i.barcode);

          --剩余待分配减数
          v_restamount := nvl(i.qualdecrease_amount, 0) -
                          nvl(v_alqualdecreamount, 0);

          --隐式游标展开
          FOR l IN (SELECT pack_barcode, packamount
                      FROM scmdata.t_asnorderpacks
                     WHERE asn_id = i.asn_id
                       AND company_id = i.company_id
                       AND goo_id = i.goo_id
                       AND nvl(barcode, ' ') = nvl(i.barcode, ' ')
                       AND subs_amount IS NULL
                     ORDER BY pack_barcode) LOOP
            --当剩余数量=0，就退出循环
            IF v_restamount > 0 THEN
              --当剩余数量大于箱内数量时
              IF v_restamount > l.packamount THEN
                --次品数量赋值
                v_subsamount := l.packamount;
                --剩余数量赋值
                v_restamount := v_restamount - l.packamount;
              ELSE
                --次品数量赋值
                v_subsamount := v_restamount;
                --剩余数量赋值
                v_restamount := 0;
              END IF;

              --更新箱内次品数量
              UPDATE scmdata.t_asnorderpacks
                 SET subs_amount = v_subsamount
               WHERE asn_id = i.asn_id
                 AND company_id = i.company_id
                 AND goo_id = i.goo_id
                 AND nvl(barcode, ' ') = nvl(i.barcode, ' ')
                 AND pack_barcode = l.pack_barcode;
            END IF;
          END LOOP;
        ELSE
          --获取已减减数
          v_alqualdecreamount := f_scmtwms_getcoloralqualdecreamount(v_inp_asnid     => i.asn_id,
                                                                     v_inp_compid    => i.company_id,
                                                                     v_inp_colorname => i.color_name);

          --剩余待分配减数
          v_restamount := nvl(i.qualdecrease_amount, 0) -
                          nvl(v_alqualdecreamount, 0);

          --当剩余数量=0，就退出循环
          IF v_restamount > 0 THEN
            UPDATE scmdata.t_asnorderpacks tab
               SET subs_amount = tab.packamount
             WHERE subs_amount IS NULL
               AND (asn_id, goo_id, barcode, pack_barcode, company_id) IN
                   (SELECT asnpacks1.asn_id,
                           asnpacks1.goo_id,
                           asnpacks1.barcode,
                           asnpacks1.pack_barcode,
                           asnpacks1.company_id
                      FROM scmdata.t_asnordersitem asnsitem
                     INNER JOIN scmdata.t_commodity_color_size colsiz
                        ON asnsitem.goo_id = colsiz.goo_id
                       AND nvl(asnsitem.barcode, ' ') =
                           nvl(colsiz.barcode, ' ')
                       AND asnsitem.company_id = colsiz.company_id
                     INNER JOIN scmdata.t_asnorderpacks asnpacks1
                        ON asnsitem.asn_id = asnpacks1.asn_id
                       AND asnsitem.company_id = asnpacks1.company_id
                       AND asnsitem.goo_id = asnpacks1.goo_id
                       AND nvl(asnsitem.barcode, ' ') =
                           nvl(asnpacks1.barcode, ' ')
                     WHERE asnsitem.asn_id = i.asn_id
                       AND asnsitem.company_id = i.company_id
                       AND colsiz.colorname = i.color_name
                     ORDER BY asnpacks1.pack_barcode
                     FETCH FIRST v_restamount rows ONLY);
          END IF;
        END IF;
      END LOOP;
    END IF;
  END p_scmtwms_allocatedsubsamountbyrepasn;

  /*=================================================================================

    包：
      pkg_qa_itf(qa接口包)

    过程名:
      【scm质检结果传给wms接口】根据质检报告 sku分配次品

    入参:
      v_inp_qarepid  :  质检报告id
      v_inp_asnid    :  asn单号
      v_inp_gooid    :  商品档案编号
      v_inp_barcode  :  条码
      v_inp_compid   :  企业id

     版本:
       2022-12-05: 根据质检报告 sku分配次品

  =================================================================================*/
  PROCEDURE p_scmtwms_allocatedsubsamountbyrepsku(v_inp_qarepid IN VARCHAR2,
                                                  v_inp_asnid   IN VARCHAR2,
                                                  v_inp_gooid   IN VARCHAR2,
                                                  v_inp_barcode IN VARCHAR2,
                                                  v_inp_compid  IN VARCHAR2) IS
    v_relagooid         VARCHAR2(32);
    v_jugnum            NUMBER(1);
    v_alqualdecreamount NUMBER(8);
    v_subsamount        NUMBER(8);
    v_restamount        NUMBER(8);
  BEGIN
    --获取货号
    SELECT MAX(rela_goo_id)
      INTO v_relagooid
      FROM scmdata.t_commodity_info
     WHERE goo_id = v_inp_gooid
       AND company_id = v_inp_compid;

    --判断是否该 sku的 asnorderpacks_itf 是否全部同步正常
    SELECT nvl(MAX(1), 0)
      INTO v_jugnum
      FROM scmdata.t_asnorderpacks_itf
     WHERE asn_id = v_inp_asnid
       AND company_id = v_inp_compid
       AND goo_id = v_relagooid
       AND nvl(barcode, ' ') = nvl(v_inp_barcode, ' ')
       AND port_status <> 'SS';

    IF v_jugnum = 1 THEN
      --更新状态和错误信息
      UPDATE scmdata.t_qa_pretranstowms
         SET status   = 'CE',
             err_info = '该 Asn的 Asnorderpacks_itf 同步不正常'
       WHERE asn_id = v_inp_asnid
         AND goo_id = v_inp_gooid
         AND nvl(barcode, ' ') = nvl(v_inp_barcode, ' ')
         AND company_id = v_inp_compid;
    ELSE
      --获取已质检数据
      FOR i IN (SELECT asn_id,
                       goo_id,
                       barcode,
                       color_name,
                       company_id,
                       qualdecrease_amount
                  FROM scmdata.t_qa_report_skudim
                 WHERE qa_report_id = v_inp_qarepid
                   AND asn_id = v_inp_asnid
                   AND company_id = v_inp_compid
                   AND goo_id = v_inp_gooid
                   AND nvl(barcode, ' ') = nvl(v_inp_barcode, ' ')
                   AND qualdecrease_amount > 0
                   AND trans_result <> 'RT'
                   AND status = 'AF') LOOP
        IF instr(i.barcode, '*') = 0 THEN
          --获取已减减数
          v_alqualdecreamount := f_scmtwms_getskualqualdecreamount(v_inp_asnid   => i.asn_id,
                                                                   v_inp_compid  => i.company_id,
                                                                   v_inp_gooid   => i.goo_id,
                                                                   v_inp_barcode => i.barcode);

          --剩余待分配减数
          v_restamount := nvl(i.qualdecrease_amount, 0) -
                          nvl(v_alqualdecreamount, 0);

          --隐式游标展开
          FOR l IN (SELECT pack_barcode, packamount
                      FROM scmdata.t_asnorderpacks
                     WHERE asn_id = i.asn_id
                       AND company_id = i.company_id
                       AND goo_id = i.goo_id
                       AND nvl(barcode, ' ') = nvl(i.barcode, ' ')
                       AND subs_amount IS NULL
                     ORDER BY pack_barcode) LOOP
            --当剩余数量=0，就退出循环
            IF v_restamount > 0 THEN
              --当剩余数量大于箱内数量时
              IF v_restamount > l.packamount THEN
                --次品数量赋值
                v_subsamount := l.packamount;
                --剩余数量赋值
                v_restamount := v_restamount - l.packamount;
              ELSE
                --次品数量赋值
                v_subsamount := v_restamount;
                --剩余数量赋值
                v_restamount := 0;
              END IF;

              --更新箱内次品数量
              UPDATE scmdata.t_asnorderpacks
                 SET subs_amount = v_subsamount
               WHERE asn_id = i.asn_id
                 AND company_id = i.company_id
                 AND goo_id = i.goo_id
                 AND nvl(barcode, ' ') = nvl(i.barcode, ' ')
                 AND pack_barcode = l.pack_barcode;
            END IF;
          END LOOP;
        ELSE
          --获取已减减数
          v_alqualdecreamount := f_scmtwms_getcoloralqualdecreamount(v_inp_asnid     => i.asn_id,
                                                                     v_inp_compid    => i.company_id,
                                                                     v_inp_colorname => i.color_name);

          --剩余待分配减数
          v_restamount := nvl(i.qualdecrease_amount, 0) -
                          nvl(v_alqualdecreamount, 0);

          --当剩余数量=0，就退出循环
          IF v_restamount > 0 THEN
            UPDATE scmdata.t_asnorderpacks tab
               SET subs_amount = tab.packamount
             WHERE subs_amount IS NULL
               AND (asn_id, goo_id, barcode, pack_barcode, company_id) IN
                   (SELECT asnpacks1.asn_id,
                           asnpacks1.goo_id,
                           asnpacks1.barcode,
                           asnpacks1.pack_barcode,
                           asnpacks1.company_id
                      FROM scmdata.t_asnordersitem asnsitem
                     INNER JOIN scmdata.t_commodity_color_size colsiz
                        ON asnsitem.goo_id = colsiz.goo_id
                       AND nvl(asnsitem.barcode, ' ') =
                           nvl(colsiz.barcode, ' ')
                       AND asnsitem.company_id = colsiz.company_id
                     INNER JOIN scmdata.t_asnorderpacks asnpacks1
                        ON asnsitem.asn_id = asnpacks1.asn_id
                       AND asnsitem.company_id = asnpacks1.company_id
                       AND asnsitem.goo_id = asnpacks1.goo_id
                       AND nvl(asnsitem.barcode, ' ') =
                           nvl(asnpacks1.barcode, ' ')
                     WHERE asnsitem.asn_id = i.asn_id
                       AND asnsitem.company_id = i.company_id
                       AND asnsitem.goo_id = i.goo_id
                       AND nvl(asnsitem.barcode, ' ') = nvl(i.barcode, ' ')
                       AND colsiz.colorname = i.color_name
                     ORDER BY asnpacks1.pack_barcode
                     FETCH FIRST v_restamount rows ONLY);
          END IF;
        END IF;
      END LOOP;
    END IF;
  END p_scmtwms_allocatedsubsamountbyrepsku;

  /*=================================================================================

    包：
      pkg_qa_itf(qa接口包)

    过程名:
      次品分配逻辑

    入参:
      v_inp_qarepid  :  质检报告id
      v_inp_asnid    :  asn单号
      v_inp_gooid    :  商品档案编号
      v_inp_barcode  :  条码
      v_inp_compid   :  企业id

     版本:
       2022-12-05 : 次品分配逻辑

  =================================================================================*/
  PROCEDURE p_allocated_subsamount(v_inp_qarepid IN VARCHAR2,
                                   v_inp_asnid   IN VARCHAR2,
                                   v_inp_compid  IN VARCHAR2,
                                   v_inp_gooid   IN VARCHAR2 DEFAULT NULL,
                                   v_inp_barcode IN VARCHAR2 DEFAULT NULL) IS

  BEGIN
    IF v_inp_barcode IS NOT NULL THEN
      p_scmtwms_allocatedsubsamountbyrepsku(v_inp_qarepid => v_inp_qarepid,
                                            v_inp_asnid   => v_inp_asnid,
                                            v_inp_gooid   => v_inp_gooid,
                                            v_inp_barcode => v_inp_barcode,
                                            v_inp_compid  => v_inp_compid);
    ELSE
      p_scmtwms_allocatedsubsamountbyrepasn(v_inp_qarepid => v_inp_qarepid,
                                            v_inp_asnid   => v_inp_asnid,
                                            v_inp_compid  => v_inp_compid);
    END IF;
  END p_allocated_subsamount;

  /*=================================================================================

    包：
      pkg_qa_itf(qa接口包)

    过程名:
      【scm质检结果传给wms接口】获取asn级回传数据字段

    入参:
      v_inp_asnid   :  asn单号
      v_inp_compid  :  企业id

     版本:
       2022-11-23: 获取asn级回传数据字段

  =================================================================================*/
  FUNCTION f_scmtwms_getasnlevelinfo(v_inp_asnid  IN VARCHAR2,
                                     v_inp_compid IN VARCHAR2) RETURN CLOB IS
    v_resultcount NUMBER(4);
    v_result      VARCHAR2(8);
    v_retstr      CLOB;
  BEGIN
    SELECT COUNT(DISTINCT trans_result), MAX(trans_result)
      INTO v_resultcount, v_result
      FROM scmdata.t_qa_report_skudim repsku
     WHERE asn_id = v_inp_asnid
       AND company_id = v_inp_compid
       AND qualfinish_time IS NOT NULL
     GROUP BY asn_id, company_id;

    IF v_resultcount > 1 THEN
      v_retstr := '"ASN_ID": "' || v_inp_asnid ||
                  '", "COMFIRM_RESULT": "PP"';
    ELSIF v_resultcount = 1 AND v_result = 'NP' THEN
      v_retstr := '"ASN_ID": "' || v_inp_asnid ||
                  '", "COMFIRM_RESULT": "NP"';
    ELSIF v_resultcount = 1 AND v_result = 'PS' THEN
      v_retstr := '"ASN_ID": "' || v_inp_asnid ||
                  '", "COMFIRM_RESULT": "PS"';
    END IF;

    RETURN v_retstr;
  END f_scmtwms_getasnlevelinfo;

  /*=================================================================================

    包：
      pkg_qa_itf(qa接口包)

    过程名:
      【scm质检结果传给wms接口】根据 asn获取 sku级回传数据字段

    入参:
      v_inp_asnid   :  asn单号
      v_inp_compid  :  企业id

     版本:
       2022-11-24 : 根据 asn获取 sku级回传数据字段
       2022-12-05 : 新增适配配码比场景

  =================================================================================*/
  FUNCTION f_scmtwms_getskulevelinfobyasn(v_inp_asnid  IN VARCHAR2,
                                          v_inp_compid IN VARCHAR2)
    RETURN CLOB IS
    v_jugnum  NUMBER(1);
    v_retclob CLOB;
  BEGIN
    --判断是否是配码比数据
    v_jugnum := f_is_asnbarcodeincludestar(v_inp_asnid  => v_inp_asnid,
                                           v_inp_compid => v_inp_compid);

    IF v_jugnum = 0 THEN
      --非配码比数据
      SELECT json_arrayagg(json_object(goo_id,
                                       goodsid,
                                       skucomfirm_result,
                                       pack_info RETURNING CLOB) RETURNING CLOB)
        INTO v_retclob
        FROM (SELECT asn_id,
                     company_id,
                     goo_id,
                     goodsid,
                     MAX(skucomfirm_result) skucomfirm_result,
                     json_arrayagg(json_object(pack_barcode,
                                               subs_amount RETURNING CLOB)
                                   RETURNING CLOB) pack_info
                FROM (SELECT gsinfo.asn_id,
                             gsinfo.company_id,
                             gsinfo.goo_id,
                             gsinfo.goodsid,
                             gsinfo.trans_result skucomfirm_result,
                             asnpacks.pack_barcode,
                             nvl(asnpacks.subs_amount, 0) subs_amount
                        FROM (SELECT repsku.asn_id,
                                     repsku.company_id,
                                     repsku.goo_id,
                                     nvl(repsku.barcode, repsku.goo_id) goodsid,
                                     first_value(repsku.trans_result) over(PARTITION BY repsku.asn_id, repsku.company_id, repsku.goo_id, repsku.barcode ORDER BY repsku.qualfinish_time DESC) trans_result
                                FROM scmdata.t_qa_report_skudim repsku
                               WHERE asn_id = v_inp_asnid
                                 AND company_id = v_inp_compid
                                 AND trans_result <> 'RT'
                                 AND data_source <> 'WMS') gsinfo
                       INNER JOIN scmdata.t_asnorderpacks asnpacks
                          ON gsinfo.asn_id = asnpacks.asn_id
                         AND gsinfo.company_id = asnpacks.company_id
                         AND gsinfo.goo_id = asnpacks.goo_id
                         AND gsinfo.goodsid = asnpacks.goodsid)
               GROUP BY asn_id, company_id, goo_id, goodsid);
    ELSE
      --配码比数据
      SELECT json_arrayagg(json_object(goo_id,
                                       goodsid,
                                       skucomfirm_result,
                                       pack_info RETURNING CLOB) RETURNING CLOB)
        INTO v_retclob
        FROM (SELECT asn_id,
                     company_id,
                     goo_id,
                     goodsid,
                     MAX(skucomfirm_result) skucomfirm_result,
                     json_arrayagg(json_object(pack_barcode,
                                               subs_amount RETURNING CLOB)
                                   RETURNING CLOB) pack_info
                FROM (SELECT gsinfo.asn_id,
                             gsinfo.company_id,
                             gsinfo.goo_id,
                             gsinfo.goodsid,
                             gsinfo.trans_result skucomfirm_result,
                             asnpacks.pack_barcode,
                             nvl(asnpacks.subs_amount, 0) subs_amount
                        FROM (SELECT repsku.asn_id,
                                     repsku.company_id,
                                     repsku.goo_id,
                                     nvl(repsku.barcode, repsku.goo_id) goodsid,
                                     first_value(repsku.trans_result) over(PARTITION BY repsku.asn_id, repsku.company_id, repsku.goo_id, repsku.barcode ORDER BY repsku.qualfinish_time DESC) trans_result,
                                     first_value(repsku.color_name) over(PARTITION BY repsku.asn_id, repsku.company_id, repsku.goo_id, repsku.barcode ORDER BY repsku.qualfinish_time DESC) color_name
                                FROM scmdata.t_qa_report_skudim repsku
                               WHERE asn_id = v_inp_asnid
                                 AND company_id = v_inp_compid
                                 AND trans_result <> 'RT'
                                 AND data_source <> 'WMS') gsinfo
                       INNER JOIN scmdata.t_commodity_color_size colsiz
                          ON gsinfo.goo_id = colsiz.goo_id
                         AND gsinfo.color_name = colsiz.colorname
                         AND gsinfo.company_id = colsiz.company_id
                       INNER JOIN scmdata.t_asnordersitem sitem
                          ON gsinfo.asn_id = sitem.asn_id
                         AND gsinfo.goo_id = sitem.goo_id
                         AND nvl(colsiz.barcode, ' ') =
                             nvl(sitem.barcode, ' ')
                         AND gsinfo.company_id = sitem.company_id
                       INNER JOIN scmdata.t_asnorderpacks asnpacks
                          ON sitem.asn_id = asnpacks.asn_id
                         AND sitem.company_id = asnpacks.company_id
                         AND sitem.goo_id = asnpacks.goo_id
                         AND nvl(sitem.barcode, ' ') =
                             nvl(asnpacks.barcode, ' '))
               GROUP BY asn_id, company_id, goo_id, goodsid);
    END IF;

    RETURN v_retclob;
  END f_scmtwms_getskulevelinfobyasn;

  /*=================================================================================

    包：
      pkg_qa_itf(qa接口包)

    过程名:
      【scm质检结果传给wms接口】根据 sku获取 sku级回传数据字段

    入参:
      v_inp_asnid    :  asn单号
      v_inp_compid   :  企业id
      v_inp_gooid    :  商品档案编号
      v_inp_barcode  :  条码

     版本:
       2022-11-24: 根据 sku获取 sku级回传数据字段

  =================================================================================*/
  FUNCTION f_scmtwms_getskulevelinfobysku(v_inp_asnid   IN VARCHAR2,
                                          v_inp_compid  IN VARCHAR2,
                                          v_inp_gooid   IN VARCHAR2,
                                          v_inp_barcode IN VARCHAR2)
    RETURN CLOB IS
    v_retclob CLOB;
  BEGIN
    IF instr(v_inp_barcode, '*') = 0 THEN
      SELECT json_arrayagg(json_object(goo_id,
                                       goodsid,
                                       skucomfirm_result,
                                       pack_info RETURNING CLOB) RETURNING CLOB)
        INTO v_retclob
        FROM (SELECT asn_id,
                     company_id,
                     goo_id,
                     goodsid,
                     MAX(skucomfirm_result) skucomfirm_result,
                     json_arrayagg(json_object(pack_barcode,
                                               subs_amount RETURNING CLOB)
                                   RETURNING CLOB) pack_info
                FROM (SELECT gsinfo.asn_id,
                             gsinfo.company_id,
                             gsinfo.goo_id,
                             gsinfo.goodsid,
                             gsinfo.trans_result skucomfirm_result,
                             asnpacks.pack_barcode,
                             nvl(asnpacks.subs_amount, 0) subs_amount
                        FROM (SELECT repsku.asn_id,
                                     repsku.company_id,
                                     repsku.goo_id,
                                     nvl(repsku.barcode, repsku.goo_id) goodsid,
                                     first_value(repsku.trans_result) over(PARTITION BY repsku.asn_id, repsku.company_id, repsku.goo_id, repsku.barcode ORDER BY repsku.qualfinish_time DESC) trans_result
                                FROM scmdata.t_qa_report_skudim repsku
                               WHERE asn_id = v_inp_asnid
                                 AND company_id = v_inp_compid
                                 AND goo_id = v_inp_gooid
                                 AND nvl(barcode, ' ') =
                                     nvl(v_inp_barcode, ' ')
                                 AND trans_result <> 'RT'
                                 AND data_source <> 'WMS') gsinfo
                       INNER JOIN scmdata.t_asnorderpacks asnpacks
                          ON gsinfo.asn_id = asnpacks.asn_id
                         AND gsinfo.company_id = asnpacks.company_id
                         AND gsinfo.goo_id = asnpacks.goo_id
                         AND gsinfo.goodsid = asnpacks.goodsid)
               GROUP BY asn_id, company_id, goo_id, goodsid);
    ELSE
      --配码比数据
      SELECT json_arrayagg(json_object(goo_id,
                                       goodsid,
                                       skucomfirm_result,
                                       pack_info RETURNING CLOB) RETURNING CLOB)
        INTO v_retclob
        FROM (SELECT asn_id,
                     company_id,
                     goo_id,
                     goodsid,
                     MAX(skucomfirm_result) skucomfirm_result,
                     json_arrayagg(json_object(pack_barcode,
                                               subs_amount RETURNING CLOB)
                                   RETURNING CLOB) pack_info
                FROM (SELECT gsinfo.asn_id,
                             gsinfo.company_id,
                             gsinfo.goo_id,
                             gsinfo.goodsid,
                             gsinfo.trans_result skucomfirm_result,
                             asnpacks.pack_barcode,
                             nvl(asnpacks.subs_amount, 0) subs_amount
                        FROM (SELECT repsku.asn_id,
                                     repsku.company_id,
                                     repsku.goo_id,
                                     nvl(repsku.barcode, repsku.goo_id) goodsid,
                                     first_value(repsku.trans_result) over(PARTITION BY repsku.asn_id, repsku.company_id, repsku.goo_id, repsku.barcode ORDER BY repsku.qualfinish_time DESC) trans_result,
                                     first_value(repsku.color_name) over(PARTITION BY repsku.asn_id, repsku.company_id, repsku.goo_id, repsku.barcode ORDER BY repsku.qualfinish_time DESC) color_name
                                FROM scmdata.t_qa_report_skudim repsku
                               WHERE asn_id = v_inp_asnid
                                 AND company_id = v_inp_compid
                                 AND goo_id = v_inp_gooid
                                 AND nvl(barcode, ' ') =
                                     nvl(v_inp_barcode, ' ')
                                 AND trans_result <> 'RT'
                                 AND data_source <> 'WMS') gsinfo
                       INNER JOIN scmdata.t_commodity_color_size colsiz
                          ON gsinfo.goo_id = colsiz.goo_id
                         AND gsinfo.color_name = colsiz.colorname
                         AND gsinfo.company_id = colsiz.company_id
                       INNER JOIN scmdata.t_asnordersitem sitem
                          ON gsinfo.asn_id = sitem.asn_id
                         AND gsinfo.goo_id = sitem.goo_id
                         AND nvl(colsiz.barcode, ' ') =
                             nvl(sitem.barcode, ' ')
                         AND gsinfo.company_id = sitem.company_id
                       INNER JOIN scmdata.t_asnorderpacks asnpacks
                          ON sitem.asn_id = asnpacks.asn_id
                         AND sitem.company_id = asnpacks.company_id
                         AND sitem.goo_id = asnpacks.goo_id
                         AND nvl(sitem.barcode, ' ') =
                             nvl(asnpacks.barcode, ' '))
               GROUP BY asn_id, company_id, goo_id, goodsid);
    END IF;

    RETURN v_retclob;
  END f_scmtwms_getskulevelinfobysku;

  /*=================================================================================

    包：
      pkg_qa_itf(qa接口包)

    过程名:
      【scm质检结果传给wms接口】获取特定asn回传数据

    入参:
      v_inp_asnid   :  asn单号
      v_inp_compid  :  企业id

     版本:
       2022-11-24: 获取特定asn回传数据

  =================================================================================*/
  FUNCTION f_scmtwms_getasntransinfo(v_inp_asnid  IN VARCHAR2,
                                     v_inp_compid IN VARCHAR2) RETURN CLOB IS
    v_asninfo CLOB;
    v_skuinfo CLOB;
    v_retclob CLOB;
  BEGIN
    --asn信息
    v_asninfo := f_scmtwms_getasnlevelinfo(v_inp_asnid  => v_inp_asnid,
                                           v_inp_compid => v_inp_compid);

    --sku信息
    v_skuinfo := f_scmtwms_getskulevelinfobyasn(v_inp_asnid  => v_inp_asnid,
                                                v_inp_compid => v_inp_compid);

    --返回值构建
    v_retclob := '{' || v_asninfo || ', "SKU_INFO":' || v_skuinfo || '}';

    RETURN v_retclob;
  END f_scmtwms_getasntransinfo;

  /*=================================================================================

    包：
      pkg_qa_itf(qa接口包)

    过程名:
      【scm质检结果传给wms接口】获取特定 sku回传数据

    入参:
      v_inp_asnid    :  asn单号
      v_inp_compid   :  企业id
      v_inp_gooid    :  商品档案编号
      v_inp_barcode  :  条码

     版本:
       2022-11-24: 获取特定 sku回传数据

  =================================================================================*/
  FUNCTION f_scmtwms_getskutransinfo(v_inp_asnid   IN VARCHAR2,
                                     v_inp_compid  IN VARCHAR2,
                                     v_inp_gooid   IN VARCHAR2,
                                     v_inp_barcode IN VARCHAR2) RETURN CLOB IS
    v_asninfo CLOB;
    v_skuinfo CLOB;
    v_retclob CLOB;
  BEGIN
    --asn信息
    v_asninfo := f_scmtwms_getasnlevelinfo(v_inp_asnid  => v_inp_asnid,
                                           v_inp_compid => v_inp_compid);

    --sku信息
    v_skuinfo := f_scmtwms_getskulevelinfobysku(v_inp_asnid   => v_inp_asnid,
                                                v_inp_gooid   => v_inp_gooid,
                                                v_inp_barcode => v_inp_barcode,
                                                v_inp_compid  => v_inp_compid);

    --返回值构建
    v_retclob := '{' || v_asninfo || ', "SKU_INFO":' || v_skuinfo || '}';

    RETURN v_retclob;
  END f_scmtwms_getskutransinfo;

  /*=================================================================================

    包：
      pkg_qa_itf(qa接口包)

    过程名:
      【scm质检结果传给wms接口】获取免检回传数据

    入参:
      v_inp_asnid    :  asn单号
      v_inp_compid   :  企业id

     版本:
       2022-12-06: 获取免检回传数据

  =================================================================================*/
  FUNCTION f_scmtwms_getaetransinfo(v_inp_asnid  IN VARCHAR2,
                                    v_inp_compid IN VARCHAR2) RETURN CLOB IS
    v_asninfo    CLOB;
    v_skuinfo    CLOB;
    v_resultinfo CLOB;
  BEGIN
    v_asninfo := '"ASN_ID": "' || v_inp_asnid ||
                 '", "COMFIRM_RESULT": "PS"';

    SELECT json_arrayagg(json_object(goo_id,
                                     goodsid,
                                     skucomfirm_result,
                                     pack_info RETURNING CLOB) RETURNING CLOB)
      INTO v_skuinfo
      FROM (SELECT asn_id,
                   company_id,
                   goo_id,
                   goodsid,
                   MAX(skucomfirm_result) skucomfirm_result,
                   json_arrayagg(json_object(pack_barcode,
                                             subs_amount RETURNING CLOB)
                                 RETURNING CLOB) pack_info
              FROM (SELECT sitemitf.asn_id,
                           sitemitf.company_id,
                           sitemitf.goo_id,
                           nvl(sitemitf.barcode, sitemitf.goo_id) goodsid,
                           'PS' skucomfirm_result,
                           packs.pack_barcode,
                           nvl(packs.subs_amount, 0) subs_amount
                      FROM scmdata.t_asnordersitem_itf sitemitf
                     INNER JOIN scmdata.t_commodity_info goo
                        ON sitemitf.goo_id = goo.rela_goo_id
                       AND sitemitf.company_id = goo.company_id
                     INNER JOIN scmdata.t_commodity_color_size colsiz
                        ON goo.goo_id = colsiz.goo_id
                       AND sitemitf.color_name = colsiz.colorname
                       AND sitemitf.company_id = colsiz.company_id
                     INNER JOIN scmdata.t_asnordersitem sitem
                        ON sitemitf.asn_id = sitem.asn_id
                       AND goo.goo_id = sitem.goo_id
                       AND colsiz.barcode = sitem.barcode
                       AND sitemitf.company_id = sitem.company_id
                     INNER JOIN scmdata.t_asnorderpacks packs
                        ON sitem.asn_id = packs.asn_id
                       AND sitem.goo_id = packs.goo_id
                       AND sitem.barcode = packs.barcode
                       AND sitem.company_id = packs.company_id
                     WHERE sitemitf.asn_id = v_inp_asnid
                       AND sitemitf.company_id = v_inp_compid)
             GROUP BY asn_id, company_id, goo_id, goodsid);

    v_resultinfo := '{' || v_asninfo || ', "SKU_INFO":' || v_skuinfo || '}';
    RETURN v_resultinfo;
  END f_scmtwms_getaetransinfo;

  /*=================================================================================

    包：
      pkg_qa_itf(qa接口包)

    过程名:
      【scm质检结果传给wms接口】获取按 asn回传前5行的回传数据

     版本:
       2022-12-06: 获取按 asn回传前5行的回传数据

  =================================================================================*/
  FUNCTION f_scmtwms_get5rowsasntransinfo RETURN CLOB IS
    v_tmpclob CLOB;
    v_retclob CLOB;
  BEGIN
    FOR i IN (SELECT DISTINCT asn_id, company_id, trans_type
                FROM scmdata.t_qa_pretranstowms
               WHERE status = 'PT'
                 AND trans_type IN ('ASN', 'AE')
               ORDER BY nvl(lastupd_time, create_time)
               FETCH FIRST 5 rows ONLY) LOOP
      IF i.trans_type = 'AE' THEN
        --获取免检信息
        v_tmpclob := f_scmtwms_getaetransinfo(v_inp_asnid  => i.asn_id,
                                              v_inp_compid => i.company_id);
      ELSE
        --获取 asn传输信息
        v_tmpclob := f_scmtwms_getasntransinfo(v_inp_asnid  => i.asn_id,
                                               v_inp_compid => i.company_id);
      END IF;

      --构建返回值
      v_retclob := scmdata.f_sentence_append_rc(v_sentence   => v_retclob,
                                                v_appendstr  => v_tmpclob,
                                                v_middliestr => ',');
    END LOOP;

    --构建返回值
    v_retclob := '{ "portBody":[' || v_retclob || ']}';

    RETURN v_retclob;
  END f_scmtwms_get5rowsasntransinfo;

  /*=================================================================================

    包：
      pkg_qa_itf(qa接口包)

    过程名:
      【scm质检结果传给wms接口】获取按 sku回传前15行的回传数据

     版本:
       2022-12-06: 获取按 sku回传前15行的回传数据

  =================================================================================*/
  FUNCTION f_scmtwms_get5rowsskutransinfo RETURN CLOB IS
    v_tmpclob CLOB;
    v_retclob CLOB;
  BEGIN
    FOR i IN (SELECT DISTINCT asn_id, company_id, goo_id, barcode
                FROM scmdata.t_qa_pretranstowms
               WHERE status = 'PT'
                 AND trans_type = 'SKU'
               ORDER BY nvl(lastupd_time, create_time)
               FETCH FIRST 15 rows ONLY) LOOP
      --获取 asn传输信息
      v_tmpclob := f_scmtwms_getskutransinfo(v_inp_asnid   => i.asn_id,
                                             v_inp_gooid   => i.goo_id,
                                             v_inp_barcode => i.barcode,
                                             v_inp_compid  => i.company_id);

      --构建返回值
      v_retclob := scmdata.f_sentence_append_rc(v_sentence   => v_retclob,
                                                v_appendstr  => v_tmpclob,
                                                v_middliestr => ',');
    END LOOP;

    --构建返回值
    v_retclob := '{ "portBody":[' || v_retclob || ']}';

    RETURN v_retclob;
  END f_scmtwms_get5rowsskutransinfo;

  /*=================================================================================

    包：
      pkg_qa_itf(qa接口包)

    过程名:
      【wms质检结果传给scm接口】校验待传入 wms 质检数据是否
                                存在于 scmdata.t_qa_wmsresult_itf中

    入参:
      v_inp_asnid      :  asn单号
      v_inp_compid     :  企业id
      v_inp_relagooid  :  货号
      v_inp_barcodes   :  条码

    返回值:
      number 类型 : 等于0，不存在于 scmdata.t_qa_wmsresult_itf 中，
                    等于1，存在于 scmdata.t_qa_wmsresult_itf 中

     版本:
       2022-11-25: 校验待传入 wms 质检数据是否
                   存在于 scmdata.t_qa_wmsresult_itf中

  =================================================================================*/
  FUNCTION f_wmstscm_checkwmsresultexists(v_inp_asnid     IN VARCHAR2,
                                          v_inp_compid    IN VARCHAR2,
                                          v_inp_relagooid IN VARCHAR2,
                                          v_inp_barcode   IN VARCHAR2)
    RETURN NUMBER IS
    v_jugnum NUMBER(1);
  BEGIN
    SELECT nvl(MAX(1), 0)
      INTO v_jugnum
      FROM scmdata.t_qa_wmsresult_itf
     WHERE asn_id = v_inp_asnid
       AND company_id = v_inp_compid
       AND goo_id = v_inp_relagooid
       AND nvl(barcodes, ' ') = nvl(v_inp_barcode, ' ');

    RETURN v_jugnum;
  END f_wmstscm_checkwmsresultexists;

  /*=================================================================================

    包：
      pkg_qa_itf(qa接口包)

    过程名:
      【wms质检结果传给scm接口】接入wms质检信息

    入参：
      v_inp_asnid             :  asn单号
      v_inp_relagooid         :  货号
      v_inp_comfirmresult     :  质检确认结果
      v_inp_barcodes          :  条码
      v_inp_skucomfirmresult  :  sku质检确认结果
      v_inp_eobjid            :  执行对象id
      v_inp_compid            :  企业id

    版本:
      2022-11-25: 接入wms质检信息，存入 scmdata.t_qa_wmsresult_itf 用于生成报告

  =================================================================================*/
  PROCEDURE p_wmstscm_qawmsresultitfinsorupd(v_inp_asnid            IN VARCHAR2,
                                             v_inp_relagooid        IN VARCHAR2,
                                             v_inp_comfirmresult    IN VARCHAR2,
                                             v_inp_barcodes         IN VARCHAR2,
                                             v_inp_skucomfirmresult IN VARCHAR2,
                                             v_inp_eobjid           IN VARCHAR2,
                                             v_inp_compid           IN VARCHAR2) IS
    v_jugnum NUMBER(1);
  BEGIN
    v_jugnum := f_wmstscm_checkwmsresultexists(v_inp_asnid     => v_inp_asnid,
                                               v_inp_compid    => v_inp_compid,
                                               v_inp_relagooid => v_inp_relagooid,
                                               v_inp_barcode   => v_inp_barcodes);

    IF v_jugnum = 0 THEN
      INSERT INTO scmdata.t_qa_wmsresult_itf
        (qw_id,
         company_id,
         asn_id,
         goo_id,
         comfirm_result,
         barcodes,
         comfirm_results_sku,
         create_id,
         create_time,
         port_element,
         port_time,
         port_status)
      VALUES
        (scmdata.f_get_uuid(),
         v_inp_compid,
         v_inp_asnid,
         v_inp_relagooid,
         v_inp_comfirmresult,
         v_inp_barcodes,
         v_inp_skucomfirmresult,
         'ADMIN',
         SYSDATE,
         v_inp_eobjid,
         SYSDATE,
         'SP');
    ELSE
      UPDATE scmdata.t_qa_wmsresult_itf
         SET comfirm_result      = v_inp_comfirmresult,
             comfirm_results_sku = v_inp_skucomfirmresult,
             port_status         = 'SP'
       WHERE asn_id = v_inp_asnid
         AND goo_id = v_inp_relagooid
         AND nvl(barcodes, ' ') = nvl(v_inp_barcodes, ' ')
         AND company_id = v_inp_compid;
    END IF;
  END p_wmstscm_qawmsresultitfinsorupd;

  /*=============================================================================

     包：
       pkg_qa_itf(qa接口包)

     过程名:
       【wms质检结果传给scm接口】wms质检结果同步

     入参:
       v_inp_compid  :  企业id

     版本:
       2022-12-07_zc314 : wms质检结果同步

  ==============================================================================*/
  PROCEDURE p_wmstscm_qawmsresultitfsync(v_inp_compid IN VARCHAR2) IS
    v_iflqarepids CLOB;
    v_tmpqarepids CLOB;
  BEGIN
    FOR i IN (SELECT itf.asn_id,
                     itf.goo_id              rela_goo_id,
                     goo.goo_id,
                     itf.barcodes            barcode,
                     itf.comfirm_results_sku,
                     itf.company_id
                FROM scmdata.t_qa_wmsresult_itf itf
               INNER JOIN scmdata.t_commodity_info goo
                  ON itf.goo_id = goo.rela_goo_id
                 AND itf.company_id = goo.company_id
               WHERE port_status = 'SP'
                 AND EXISTS
               (SELECT 1
                        FROM scmdata.t_qa_report_skudim
                       WHERE asn_id = itf.asn_id
                         AND goo_id = goo.goo_id
                         AND nvl(barcode, ' ') = nvl(itf.barcodes, ' ')
                         AND company_id = itf.company_id)
               ORDER BY itf.port_time
               FETCH FIRST 100 rows ONLY) LOOP
      BEGIN
        --获取 sku/good全部质检报告id
        v_tmpqarepids := f_wmstscm_getskugoodallqarepid(v_inp_asnid   => i.asn_id,
                                                        v_inp_compid  => i.company_id,
                                                        v_inp_gooid   => i.goo_id,
                                                        v_inp_barcode => i.barcode);

        --不断拼接到 v_iflqarepids
        v_iflqarepids := scmdata.f_sentence_append_rc(v_sentence   => v_iflqarepids,
                                                      v_appendstr  => v_tmpqarepids,
                                                      v_middliestr => ';');

        --更新质检报告 sku维度 wms质检结果，数据来源
        UPDATE scmdata.t_qa_report_skudim
           SET wmsskucheck_result = i.comfirm_results_sku,
               data_source        = 'WMS'
         WHERE asn_id = i.asn_id
           AND goo_id = i.goo_id
           AND nvl(barcode, ' ') = nvl(i.barcode, ' ')
           AND company_id = i.company_id;

        --更新
        UPDATE scmdata.t_qa_wmsresult_itf
           SET port_status = 'SS'
         WHERE asn_id = i.asn_id
           AND goo_id = i.rela_goo_id
           AND nvl(barcodes, ' ') = nvl(i.barcode, ' ')
           AND company_id = i.company_id;
      EXCEPTION
        WHEN OTHERS THEN
          UPDATE scmdata.t_qa_wmsresult_itf
             SET port_status = 'SE',
                 err_info    = dbms_utility.format_error_backtrace
           WHERE asn_id = i.asn_id
             AND goo_id = i.goo_id
             AND nvl(barcodes, ' ') = nvl(i.barcode, ' ')
             AND company_id = i.company_id;
      END;
    END LOOP;

    --质检报告data_source字段刷新
    p_wmstscm_refreshrelaqarepdatasource(v_inp_qarepidclob => v_iflqarepids,
                                         v_inp_compid      => v_inp_compid);
  END p_wmstscm_qawmsresultitfsync;

  /*=============================================================================

     包：
       pkg_qa_itf(qa接口包)

     函数名:
       【wms质检结果传给scm接口】获取 sku/good 所有质检报告id

     入参:
       v_inp_asnid    :  asn单号
       v_inp_gooid    :  商品档案编号
       v_inp_barcode  :  条码
       v_inp_compid   :  企业id

     返回值:
       clob 类型，报告级质检结果

     版本:
       2022-12-06_zc314 : 获取 sku/good 所有质检报告id

  ==============================================================================*/
  FUNCTION f_wmstscm_getskugoodallqarepid(v_inp_asnid   IN VARCHAR2,
                                          v_inp_compid  IN VARCHAR2,
                                          v_inp_gooid   IN VARCHAR2 DEFAULT NULL,
                                          v_inp_barcode IN VARCHAR2 DEFAULT NULL)
    RETURN CLOB IS
    v_qarepid CLOB;
  BEGIN
    IF v_inp_barcode IS NOT NULL THEN
      SELECT listagg(DISTINCT rep.qa_report_id, ';')
        INTO v_qarepid
        FROM scmdata.t_qa_report rep
       INNER JOIN scmdata.t_qa_report_skudim repsku
          ON rep.qa_report_id = repsku.qa_report_id
         AND rep.company_id = repsku.company_id
       WHERE repsku.asn_id = v_inp_asnid
         AND repsku.company_id = v_inp_compid
         AND nvl(repsku.goo_id, ' ') = nvl(v_inp_gooid, ' ')
         AND nvl(repsku.barcode, ' ') = nvl(v_inp_barcode, ' ');
    ELSE
      SELECT listagg(DISTINCT rep.qa_report_id, ';')
        INTO v_qarepid
        FROM scmdata.t_qa_report rep
       INNER JOIN scmdata.t_qa_report_skudim repsku
          ON rep.qa_report_id = repsku.qa_report_id
         AND rep.company_id = repsku.company_id
       WHERE repsku.asn_id = v_inp_asnid
         AND repsku.company_id = v_inp_compid;
    END IF;

    RETURN v_qarepid;
  END f_wmstscm_getskugoodallqarepid;

  /*=============================================================================

     包：
       pkg_qa_itf(qa接口包)

     过程名:
       【wms质检结果传给scm接口】刷新质检报告数据源

     入参:
       v_inp_qarepidclob  :  质检报告编号，多值由分号分割
       v_inp_compid       :  企业id

     版本:
       2022-12-06_zc314 : 刷新质检报告数据源

  ==============================================================================*/
  PROCEDURE p_wmstscm_refreshrelaqarepdatasource(v_inp_qarepidclob IN CLOB,
                                                 v_inp_compid      IN VARCHAR2) IS
    v_dscnt  NUMBER(1);
    v_dsname VARCHAR2(8);
  BEGIN
    FOR i IN (SELECT DISTINCT regexp_substr(to_char(v_inp_qarepidclob),
                                            '[^;]+',
                                            1,
                                            LEVEL) qa_report_id
                FROM dual
              CONNECT BY LEVEL <=
                         regexp_count(to_char(v_inp_qarepidclob), ';') + 1) LOOP
      SELECT COUNT(DISTINCT data_source), MAX(data_source)
        INTO v_dscnt, v_dsname
        FROM scmdata.t_qa_report_skudim
       WHERE qa_report_id = to_char(i.qa_report_id)
         AND company_id = v_inp_compid;

      IF v_dscnt > 1 THEN
        v_dsname := 'SCM/WMS';
      END IF;

      UPDATE scmdata.t_qa_report
         SET data_source = v_dsname
       WHERE qa_report_id = to_char(i.qa_report_id)
         AND company_id = v_inp_compid;
    END LOOP;
  END p_wmstscm_refreshrelaqarepdatasource;

  /*=============================================================================

     包：
       pkg_qa_itf(qa接口包)

     过程名:
       【wms质检结果传给scm接口】生成质检报告时，刷新报告wms质检确认数据

     入参:
       v_inp_asnids  :  asn单号，多值用分号分隔
       v_inp_compid  :  企业id

     版本:
       2022-12-07_zc314 : 生成质检报告时，刷新报告wms质检确认数据

  ==============================================================================*/
  PROCEDURE p_wmstscm_refreshwmsresultwhengenqarep(v_inp_asnids IN CLOB,
                                                   v_inp_compid IN VARCHAR2) IS
    v_jugnum      NUMBER(1);
    v_iflqarepids CLOB;
    v_tmpqarepids CLOB;
  BEGIN
    --判断是否存在于wms质检结果回传表
    SELECT nvl(MAX(1), 0)
      INTO v_jugnum
      FROM scmdata.t_qa_wmsresult_itf
     WHERE instr(v_inp_asnids, asn_id) > 0
       AND company_id = v_inp_compid;

    --存在于wms质检结果回传表
    IF v_jugnum > 0 THEN
      FOR i IN (SELECT itf.asn_id,
                       itf.goo_id              rela_goo_id,
                       goo.goo_id,
                       itf.barcodes            barcode,
                       itf.comfirm_results_sku,
                       itf.company_id
                  FROM scmdata.t_qa_wmsresult_itf itf
                 INNER JOIN scmdata.t_commodity_info goo
                    ON itf.goo_id = goo.rela_goo_id
                   AND itf.company_id = goo.company_id
                 WHERE instr(v_inp_asnids, itf.asn_id) > 0
                   AND itf.company_id = v_inp_compid) LOOP
        BEGIN
          --获取 sku/good全部质检报告id
          v_tmpqarepids := f_wmstscm_getskugoodallqarepid(v_inp_asnid   => i.asn_id,
                                                          v_inp_compid  => i.company_id,
                                                          v_inp_gooid   => i.goo_id,
                                                          v_inp_barcode => i.barcode);

          --不断拼接到 v_iflqarepids
          v_iflqarepids := scmdata.f_sentence_append_rc(v_sentence   => v_iflqarepids,
                                                        v_appendstr  => v_tmpqarepids,
                                                        v_middliestr => ';');

          --更新质检报告 sku维度 wms质检结果，数据来源
          UPDATE scmdata.t_qa_report_skudim
             SET wmsskucheck_result = i.comfirm_results_sku,
                 data_source        = 'WMS'
           WHERE asn_id = i.asn_id
             AND goo_id = i.goo_id
             AND nvl(barcode, ' ') = nvl(i.barcode, ' ')
             AND company_id = i.company_id;

          --更新
          UPDATE scmdata.t_qa_wmsresult_itf
             SET port_status = 'SS'
           WHERE asn_id = i.asn_id
             AND goo_id = i.rela_goo_id
             AND nvl(barcodes, ' ') = nvl(i.barcode, ' ')
             AND company_id = i.company_id;
        EXCEPTION
          WHEN OTHERS THEN
            UPDATE scmdata.t_qa_wmsresult_itf
               SET port_status = 'SE',
                   err_info    = dbms_utility.format_error_backtrace
             WHERE asn_id = i.asn_id
               AND goo_id = i.goo_id
               AND nvl(barcodes, ' ') = nvl(i.barcode, ' ')
               AND company_id = i.company_id;
        END;
      END LOOP;

      --质检报告data_source字段刷新
      p_wmstscm_refreshrelaqarepdatasource(v_inp_qarepidclob => v_iflqarepids,
                                           v_inp_compid      => v_inp_compid);

    END IF;

  END p_wmstscm_refreshwmsresultwhengenqarep;

END pkg_qa_itf;
/

