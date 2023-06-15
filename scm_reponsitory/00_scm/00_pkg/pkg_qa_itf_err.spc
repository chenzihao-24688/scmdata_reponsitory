CREATE OR REPLACE PACKAGE SCMDATA.pkg_qa_itf_err IS

  /*=============================================================================

     包：
       pkg_qa_itf_err(qa接口包)

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
       pkg_qa_itf_err(qa接口包)

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
                                   v_inp_compid IN VARCHAR2) RETURN NUMBER;

  /*=============================================================================

     包：
       pkg_qa_itf_err(qa接口包)

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
       pkg_qa_itf_err(qa接口包)

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
                                v_inp_compid IN VARCHAR2) RETURN NUMBER;

  /*=============================================================================

     包：
       pkg_qa_itf_err(qa接口包)

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
       pkg_qa_itf_err(qa接口包)

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
       pkg_qa_itf_err(qa接口包)

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
    RETURN NUMBER;

  /*=============================================================================

     包：
       pkg_qa_itf_err(qa接口包)

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
    RETURN NUMBER;

  /*=============================================================================

     包：
       pkg_qa_itf_err(qa接口包)

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
       pkg_qa_itf_err(qa接口包)

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
      pkg_qa_itf_err(qa接口包)

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
                                    v_inp_compid    IN VARCHAR2) RETURN CLOB;

  /*=============================================================================

     包：
       pkg_qa_itf_err(qa接口包)

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
    RETURN NUMBER;

  /*=================================================================================

    包：
      pkg_qa_itf_err(qa接口包)

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
    RETURN NUMBER;

  /*=================================================================================

    包：
      pkg_qa_itf_err(qa接口包)

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
    RETURN NUMBER;

  /*=============================================================================

     包：
       pkg_qa_itf_err(qa接口包)

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
    RETURN VARCHAR2;

  /*=============================================================================

     包：
       pkg_qa_itf_err(qa接口包)

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
    RETURN NUMBER;

  /*=============================================================================

     包：
       pkg_qa_itf_err(qa接口包)

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
    RETURN NUMBER;

  /*=============================================================================

     包：
       pkg_qa_itf_err(qa接口包)

     函数名:
       【scm质检结果回传wms接口】获取颜色剩余减数

     入参:
       v_inp_asnid      :  asn单号
       v_inp_compid     :  企业id
       v_inp_gooid      :  商品档案编号
       v_inp_barcode    :  条码
       v_inp_colorname  :  颜色名称

     版本:
       2022-12-03_zc314 : 获取颜色已减减数
       2023-03-17_zc314 : 逻辑调整，传入箱号内 packamount 存在非6倍数情景，
                          改为获取颜色剩余减数

  ==============================================================================*/
  FUNCTION f_scmtwms_getcolorrestqualdecreamount(v_inp_asnid     IN VARCHAR2,
                                                 v_inp_compid    IN VARCHAR2,
                                                 v_inp_gooid     IN VARCHAR2 DEFAULT NULL,
                                                 v_inp_barcode   IN VARCHAR2 DEFAULT NULL,
                                                 v_inp_colorname IN VARCHAR2)
    RETURN NUMBER;

  /*=============================================================================

     包：
       pkg_qa_itf_err(qa接口包)

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
    RETURN NUMBER;

  /*=================================================================================

    包：
      pkg_qa_itf_err(qa接口包)

    函数名:
      判断 asn 条码是否包含【*】

    入参:
      v_inp_asnid   :  asn单号
      v_inp_compid  :  企业id

     版本:
       2022-12-03: 判断 asn 条码是否包含【*】

  =================================================================================*/
  FUNCTION f_is_asnbarcodeincludestar(v_inp_asnid  IN VARCHAR2,
                                      v_inp_compid IN VARCHAR2) RETURN NUMBER;

  /*=============================================================================

     包：
       pkg_qa_ld(qa逻辑细节包)

     过程名:
       预回传数据刷新

     入参:
       v_inp_asnid      :  Qa质检报告Id
       v_inp_compid     :  企业Id

     版本:
       2023-02-14_zc314 : 预回传数据刷新

  ==============================================================================*/
  PROCEDURE p_iflpretrans_refreshpretransdata(v_inp_asnid  IN VARCHAR2,
                                              v_inp_compid IN VARCHAR2);

  /*=================================================================================

    包：
      pkg_qa_itf_err(qa接口包)

    过程名:
      刷新 asn接口表数据状态与错误信息

    版本:
      2023-01-10: 刷新 asn接口表数据状态与错误信息

  =================================================================================*/
  PROCEDURE p_cerefresh_asnitfcerefresh;

  /*=================================================================================

    包：
      pkg_qa_itf_err(qa接口包)

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
      pkg_qa_itf_err(qa接口包)

    过程名:
      根据Asn刷新预回传表状态及错误信息

    入参:
      v_inp_asnid   :  asn单号
      v_inp_compid  :  企业id

     版本:
       2023-03-10: 根据Asn刷新预回传表状态及错误信息

  =================================================================================*/
  PROCEDURE p_refresh_pretrans_status_and_errinfo_by_asn(v_inp_asnid  IN VARCHAR2,
                                                         v_inp_compid IN VARCHAR2);

  /*=================================================================================

    包：
      pkg_qa_itf_err(qa接口包)

    过程名:
      【质检任务接口】更新 qaasn质检信息是否完整字段

    入参:
      v_inp_asnid   :  asn单号
      v_inp_compid  :  企业id

     版本:
       2022-11-21: 更新 qaasn质检信息是否完整字段

  =================================================================================*/
  PROCEDURE p_qamission_isqaasninfocompleteupd(v_inp_asnid  IN VARCHAR2,
                                               v_inp_compid IN VARCHAR2);

  /*=================================================================================

    包：
      pkg_qa_itf_err(qa接口包)

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
      pkg_qa_itf_err(qa接口包)

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
                                        v_inp_memo         IN VARCHAR2);

  /*=================================================================================

    包：
      pkg_qa_itf_err(qa接口包)

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
                                            v_inp_memo         IN VARCHAR2);

  /*=================================================================================

    包：
      pkg_qa_itf_err(qa接口包)

    过程名:
      【质检任务接口】qa质检任务 asnordered 数据同步

    入参:
      v_inp_portstatus  :  接口状态

     版本:
       2022-11-17: qa质检任务 asnordered 数据同步

  =================================================================================*/
  PROCEDURE p_qamission_asnorderedsync(v_inp_portstatus IN VARCHAR2);

  /*=================================================================================

    包：
      pkg_qa_itf_err(qa接口包)

    过程名:
      【质检任务接口】qa质检任务 asnorders 数据同步

    入参:
      v_inp_portstatus  :  接口状态

     版本:
       2022-11-17: qa质检任务 asnorders 数据同步

  =================================================================================*/
  PROCEDURE p_qamission_asnorderssync(v_inp_portstatus IN VARCHAR2);

  /*=================================================================================

    包：
      pkg_qa_itf_err(qa接口包)

    过程名:
      【质检任务接口】qa质检任务 asnordersitem 数据同步

    入参:
      v_inp_portstatus  :  接口状态

     版本:
       2022-11-17: qa质检任务 asnordersitem 数据同步

  =================================================================================*/
  PROCEDURE p_qamission_asnordersitemsync(v_inp_portstatus IN VARCHAR2);

  /*=============================================================================

     包：
       pkg_qa_itf_err(qa接口包)

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

  /*=============================================================================

     包：
       pkg_qa_itf_err(qa接口包)

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
                                                 v_inp_compid IN VARCHAR2);

  /*=================================================================================

    包：
      pkg_qa_itf_err(qa接口包)

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
      pkg_qa_itf_err(qa接口包)

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
                                          v_inp_warehousepos IN VARCHAR2);

  /*=================================================================================

    包：
      pkg_qa_itf_err(qa接口包)

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
      pkg_qa_itf_err(qa接口包)

    过程名:
      【上架信息更新接口】 asnordered 上架信息同步

     版本:
       2022-11-18: asnordered 上架信息同步
       2023-03-09: 去除【接口状态】入参

  =================================================================================*/
  PROCEDURE p_receiveinfo_asnorderedsync;

  /*=================================================================================

    包：
      pkg_qa_itf_err(qa接口包)

    过程名:
      【上架信息更新接口】 asnorders 上架信息刷新

     版本:
       2022-12-01: asnorders 上架信息刷新
       2023-03-09: 去除-

  =================================================================================*/
  PROCEDURE p_receiveinfo_asnordersitfupdrefresh(v_inp_asnid  IN VARCHAR2,
                                                 v_inp_compid IN VARCHAR2);

  /*=================================================================================

    包：
      pkg_qa_itf_err(qa接口包)

    过程名:
      【上架信息更新接口】 asnorders 上架信息同步

     版本:
       2022-11-18: asnorders 上架信息同步
       2023-03-09: 去除【接口状态】入参

  =================================================================================*/
  PROCEDURE p_receiveinfo_asnorderssync;

  /*=================================================================================

    包：
      pkg_qa_itf_err(qa接口包)

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
                                                     v_inp_compid  IN VARCHAR2);

  /*=================================================================================

    包：
      pkg_qa_itf_err(qa接口包)

    过程名:
      【上架信息更新接口】 asnordersitem 上架信息同步

     版本:
       2022-11-18: asnordersitem 上架信息同步

  =================================================================================*/
  PROCEDURE p_receiveinfo_asnordersitemsync;

  /*=================================================================================

    包：
      pkg_qa_itf_err(qa接口包)

    过程名:
      【上架信息更新接口】 asnordersitem 上架信息通过分类同步

    入参:
      v_inp_cates  :  分类

     版本:
       2023-03-21: asnordersitem 上架信息通过分类同步

  =================================================================================*/
  PROCEDURE p_receiveinfo_asnordersitemsync_by_cates(v_inp_cates IN VARCHAR2);

  /*=================================================================================

    包：
      pkg_qa_itf_err(qa接口包)

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
                                      v_inp_isfinished IN NUMBER);

  /*=================================================================================

    包：
      pkg_qa_itf_err(qa接口包)

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
      pkg_qa_itf_err(qa接口包)

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
                                               v_inp_memo          IN VARCHAR2);

  /*=================================================================================

    包：
      pkg_qa_itf_err(qa接口包)

    过程名:
      【asnorderpacks接口】 asnorderpacks同步

     版本:
       2022-11-19: asnorderpacks同步

  =================================================================================*/
  PROCEDURE p_asnorderpacks_asnorderpacksitfsync;

  /*=================================================================================

    包：
      pkg_qa_itf_err(qa接口包)

    过程名:
      【asnorderpacks接口】 asnorderpacks根据分类同步

     版本:
       2023-03-23: asnorderpacks根据分类同步

  =================================================================================*/
  PROCEDURE p_asnorderpacks_asnorderpacksitfsync_bycates(v_inp_cates IN VARCHAR2);

  /*=================================================================================

    包：
      pkg_qa_itf_err(qa接口包)

    过程名:
      【scm质检结果传给wms接口】根据质检报告 asn分配次品

    入参:
      v_inp_qarepid  :  质检报告id
      v_inp_asnid    :  asn单号
      v_inp_compid   :  企业id

     版本:
       2022-12-05: 根据质检报告 asn分配次品
       2023-03-17_zc314 : 逻辑调整，传入箱号内 packamount 存在非6倍数情景

  =================================================================================*/
  PROCEDURE p_scmtwms_allocatedsubsamountbyrepasn(v_inp_qarepid IN VARCHAR2,
                                                  v_inp_asnid   IN VARCHAR2,
                                                  v_inp_compid  IN VARCHAR2);

  /*=================================================================================

    包：
      pkg_qa_itf_err(qa接口包)

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
                                                  v_inp_compid  IN VARCHAR2);

  /*=================================================================================

    包：
      pkg_qa_itf_err(qa接口包)

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
                                   v_inp_barcode IN VARCHAR2 DEFAULT NULL);

  /*=================================================================================

    包：
      pkg_qa_itf_err(qa接口包)

    过程名:
      【scm质检结果传给wms接口】获取分离的合并信息

    入参:
      v_inp_combineinfo  :  合并信息

    入出参:
      v_iop_asnid        :  Asn单号
      v_iop_gooid        :  商品档案编号
      v_iop_barcode      :  条码

     版本:
       2023-03-15: 获取分离的合并信息

  =================================================================================*/
  PROCEDURE p_scmtwms_get_sperated_combineinfo(v_inp_combineinfo IN VARCHAR2,
                                               v_iop_asnid       IN OUT VARCHAR2,
                                               v_iop_gooid       IN OUT VARCHAR2,
                                               v_iop_barcode     IN OUT VARCHAR2);

  /*=============================================================================

     包：
       pkg_qa_itf_err(qa接口包)

     过程名:
       【scm回传wms】更新预回传表状态（自治事务）

     入参:
       v_inp_asnid    :  Asn单号
       v_inp_compid   :  企业Id
       v_inp_gooid    :  商品档案编号
       v_inp_barcode  :  条码
       v_inp_status   :  状态
       v_inp_operobj  :  操作对象

     版本:
       2023-03-06_zc314 : 更新预回传表状态（自治事务）

  ==============================================================================*/
  PROCEDURE p_scmtwms_upd_qapretranstowms_status_at(v_inp_asnid   IN VARCHAR2,
                                                    v_inp_compid  IN VARCHAR2,
                                                    v_inp_gooid   IN VARCHAR2 DEFAULT NULL,
                                                    v_inp_barcode IN VARCHAR2 DEFAULT NULL,
                                                    v_inp_status  IN VARCHAR2,
                                                    v_inp_operobj IN VARCHAR2);

  /*=============================================================================

     包：
       pkg_qa_itf_err(qa接口包)

     过程名:
       【scm回传wms】更新预回传表信息（自治事务）

     入参:
       v_inp_asnid    :  Asn单号
       v_inp_compid   :  企业Id
       v_inp_status   :  状态
       v_inp_operobj  :  操作对象

     版本:
       2023-03-06_zc314 : 更新预回传表信息（自治事务）

  ==============================================================================*/
  PROCEDURE p_scmtwms_upd_qapretrans_info_at(v_inp_asnid   IN VARCHAR2,
                                             v_inp_compid  IN VARCHAR2,
                                             v_inp_status  IN VARCHAR2,
                                             v_inp_operobj IN VARCHAR2);

  /*=============================================================================

     包：
       pkg_qa_itf_err(qa接口包)

     过程名:
       【scm回传wms】更新预回传表信息（自治事务）

     入参:
       v_inp_asnid      :  Asn单号
       v_inp_compid     :  企业Id
       v_inp_gooid      :  商品档案编号
       v_inp_barcode    :  条码
       v_inp_status     :  状态
       v_inp_transinfo  :  回传信息
       v_inp_operobj    :  操作对象

     版本:
       2023-03-06_zc314 : 更新预回传表信息（自治事务）

  ==============================================================================*/
  PROCEDURE p_scmtwms_upd_qapretrans_with_transinfo_at(v_inp_asnid     IN VARCHAR2,
                                                       v_inp_compid    IN VARCHAR2,
                                                       v_inp_gooid     IN VARCHAR2 DEFAULT NULL,
                                                       v_inp_barcode   IN VARCHAR2 DEFAULT NULL,
                                                       v_inp_status    IN VARCHAR2,
                                                       v_inp_transinfo IN CLOB,
                                                       v_inp_operobj   IN VARCHAR2);

  /*=============================================================================

     包：
       pkg_qa_itf_err(qa接口包)

     过程名:
       【scm回传wms】更新预回传表信息（自治事务）

     入参:
       v_inp_asnid      :  Asn单号
       v_inp_compid     :  企业Id
       v_inp_barcodes   :  条码(复数)
       v_inp_status     :  状态
       v_inp_transinfo  :  回传信息
       v_inp_operobj    :  操作对象

     版本:
       2023-03-06_zc314 : 更新预回传表信息（自治事务）

  ==============================================================================*/
  PROCEDURE p_scmtwms_upd_qapretrans_with_transinfo_at_raw(v_inp_asnid     IN VARCHAR2,
                                                           v_inp_compid    IN VARCHAR2,
                                                           v_inp_barcodes  IN VARCHAR2 DEFAULT NULL,
                                                           v_inp_status    IN VARCHAR2,
                                                           v_inp_transinfo IN CLOB,
                                                           v_inp_operobj   IN VARCHAR2);

  /*=================================================================================

    包：
      pkg_qa_itf_err(qa接口包)

    过程名:
      【scm质检结果传给wms接口】获取asn级回传数据字段

    入参:
      v_inp_asnid   :  asn单号
      v_inp_compid  :  企业id

     版本:
       2023-03-22: 获取asn级回传数据字段

  =================================================================================*/
  FUNCTION f_scmtwms_getasnlevelinfo_final(v_inp_asnid  IN VARCHAR2,
                                           v_inp_compid IN VARCHAR2)
    RETURN CLOB;

  /*=================================================================================

    包：
      pkg_qa_itf_err(qa接口包)

    过程名:
      【scm质检结果传给wms接口】按 Asn 回传根据 Asn 获取 sku 级回传数据 Json

    入参:
      v_inp_asnid   :  asn单号
      v_inp_compid  :  企业id

     版本:
       2023-03-22_zc314 : 按 Asn 回传根据 Asn 获取 sku 级回传数据 Json

  =================================================================================*/
  FUNCTION f_scmtwms_getskulevelinfobyasn_transtypeasasn_final(v_inp_asnid  IN VARCHAR2,
                                                               v_inp_compid IN VARCHAR2)
    RETURN CLOB;

  /*=================================================================================

    包：
      pkg_qa_itf_err(qa接口包)

    过程名:
      【scm质检结果传给wms接口】按 Sku 回传根据 Asn 获取 sku 级回传数据 Json

    入参:
      v_inp_asnid   :  asn单号
      v_inp_compid  :  企业id

     版本:
       2023-03-22_zc314 : 按 Sku 回传根据 Asn 获取 sku 级回传数据 Json

  =================================================================================*/
  FUNCTION f_scmtwms_getskulevelinfobyasn_transtypeassku_final(v_inp_asnid  IN VARCHAR2,
                                                               v_inp_compid IN VARCHAR2)
    RETURN CLOB;

  /*=================================================================================

    包：
      pkg_qa_itf_err(qa接口包)

    过程名:
      【scm质检结果传给wms接口】获取特定asn回传数据

    入参:
      v_inp_asnid   :  asn单号
      v_inp_compid  :  企业id

     版本:
       2023-03-22: 获取特定asn回传数据

  =================================================================================*/
  FUNCTION f_scmtwms_getasntransinfo_final(v_inp_asnid  IN VARCHAR2,
                                           v_inp_compid IN VARCHAR2)
    RETURN CLOB;

  /*=================================================================================

    包：
      pkg_qa_itf_err(qa接口包)

    过程名:
      【scm质检结果传给wms接口】获取特定sku回传数据

    入参:
      v_inp_asnid   :  asn单号
      v_inp_compid  :  企业id

     版本:
       2023-03-22 : 获取特定sku回传数据

  =================================================================================*/
  FUNCTION f_scmtwms_getskutransinfo_final(v_inp_asnid  IN VARCHAR2,
                                           v_inp_compid IN VARCHAR2)
    RETURN CLOB;

  /*=================================================================================

    包：
      pkg_qa_itf_err(qa接口包)

    过程名:
      【scm质检结果传给wms接口】获取免检回传数据

    入参:
      v_inp_asnid    :  asn单号
      v_inp_compid   :  企业id

     版本:
       2023-03-22: 获取免检回传数据

  =================================================================================*/
  FUNCTION f_scmtwms_getaetransinfo_final(v_inp_asnid  IN VARCHAR2,
                                          v_inp_compid IN VARCHAR2)
    RETURN CLOB;

  /*=============================================================================

     包：
       pkg_qa_itf_err(qa接口包)

     函数名:
       【scm传输wms】获取预回传表传输信息

     入参:
       v_inp_asnid      :  asn单号
       v_inp_compid     :  企业id
       v_inp_transtype  :  传输类型

     返回值:
       clob 类型，预回传信息

     版本:
       2023-03-22_zc314 : 获取预回传表传输信息

  ==============================================================================*/
  FUNCTION f_scmtwms_get_qa_pretrans_transinfo_final(v_inp_asnid     IN VARCHAR2,
                                                     v_inp_compid    IN VARCHAR2,
                                                     v_inp_transtype IN VARCHAR2)
    RETURN CLOB;

  /*=================================================================================

    包：
      pkg_qa_itf_err(qa接口包)

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
    RETURN NUMBER;

  /*=================================================================================

    包：
      pkg_qa_itf_err(qa接口包)

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
                                             v_inp_compid           IN VARCHAR2);

  /*=============================================================================

     包：
       pkg_qa_itf_err(qa接口包)

     过程名:
       【wms质检结果传给scm接口】wms质检结果同步

     入参:
       v_inp_compid  :  企业id

     版本:
       2022-12-07_zc314 : wms质检结果同步

  ==============================================================================*/
  PROCEDURE p_wmstscm_qawmsresultitfsync(v_inp_compid IN VARCHAR2);

  /*=============================================================================

     包：
       pkg_qa_itf_err(qa接口包)

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
    RETURN CLOB;

  /*=============================================================================

     包：
       pkg_qa_itf_err(qa接口包)

     过程名:
       【wms质检结果传给scm接口】刷新质检报告数据源

     入参:
       v_inp_qarepidclob  :  质检报告编号，多值由分号分割
       v_inp_compid       :  企业id

     版本:
       2022-12-06_zc314 : 刷新质检报告数据源

  ==============================================================================*/
  PROCEDURE p_wmstscm_refreshrelaqarepdatasource(v_inp_qarepidclob IN CLOB,
                                                 v_inp_compid      IN VARCHAR2);

  /*=============================================================================

     包：
       pkg_qa_itf_err(qa接口包)

     过程名:
       【wms质检结果传给scm接口】生成质检报告时，刷新报告wms质检确认数据

     入参:
       v_inp_asnids  :  asn单号，多值用分号分隔
       v_inp_compid  :  企业id

     版本:
       2022-12-07_zc314 : 生成质检报告时，刷新报告wms质检确认数据

  ==============================================================================*/
  PROCEDURE p_wmstscm_refreshwmsresultwhengenqarep(v_inp_asnids IN CLOB,
                                                   v_inp_compid IN VARCHAR2);

  /*=================================================================================

    包：
      pkg_qa_itf_err(qa接口包)

    过程名:
      不同分类中是否存在箱号遗漏的情况

    入参:
      v_inp_cates  :  分类

     版本:
       2023-03-21: 不同分类中是否存在箱号遗漏的情况

  =================================================================================*/
  FUNCTION f_is_anyasnorderpacksleak_in_diffcates(v_inp_cates IN VARCHAR2)
    RETURN NUMBER;

  /*=================================================================================

    包：
      pkg_qa_itf_err(qa接口包)

    过程名:
      通过不同分部获取确实箱号的asn单号

    入参:
      v_inp_cates  :  分类

     版本:
       2023-03-21: 通过不同分部获取确实箱号的asn单号

  =================================================================================*/
  FUNCTION f_get_asnorderpacksleakasnids_in_diffcates(v_inp_cates IN VARCHAR2)
    RETURN VARCHAR2;

  /*=================================================================================

    包：
      pkg_qa_itf_err(qa接口包)

    过程名:
      【结果传输】按 Asn/Ae回传，获取变量名称，传输 Asn单号，企业Id，传输中 Asn单号

    入参:
      v_inp_transtype       :  传输类型

    入出参:
      v_iop_varname         :  变量名称
      v_iop_transingasnids  :  传输中Asn单号，多值，分号分隔
      v_iop_transasnid      :  传输 Asn单号
      v_iop_transcompid     :  传输 企业Id

     版本:
       2023-04-03: 按 Asn/Ae回传，获取变量名称，传输 Asn单号，企业Id，传输中 Asn单号

  =================================================================================*/
  PROCEDURE p_resulttrans_get_asnae_asnid_compid_transingasnids(v_inp_transtype      IN VARCHAR2,
                                                                v_iop_varname        IN OUT VARCHAR2,
                                                                v_iop_transingasnids IN OUT CLOB,
                                                                v_iop_transasnid     IN OUT VARCHAR2,
                                                                v_iop_transcompid    IN OUT VARCHAR2);

  /*=================================================================================

    包：
      pkg_qa_itf_err(qa接口包)

    过程名:
      【结果传输】按 Sku 回传获取变量名称，传输 Asn单号，企业Id，传输中 Asn单号

    入参:
      v_inp_transtype       :  传输类型

    入出参:
      v_iop_varname         :  变量名称
      v_inp_transingasnids  :  传输中Asn单号，多值，分号分隔
      v_iop_transasnid      :  传输 Asn单号
      v_iop_transbarcodes   :  传输条码
      v_iop_transcompid     :  传输 企业Id

     版本:
       2023-04-03: 按 Sku 回传获取变量名称，传输 Asn单号，企业Id，传输中 Asn单号

  =================================================================================*/
  PROCEDURE p_resulttrans_get_sku_asnid_compid_transingasnids(v_inp_transtype      IN VARCHAR2,
                                                              v_iop_varname        IN OUT VARCHAR2,
                                                              v_iop_transingasnids IN OUT CLOB,
                                                              v_iop_transasnid     IN OUT VARCHAR2,
                                                              v_iop_transbarcodes  IN OUT VARCHAR2,
                                                              v_iop_transcompid    IN OUT VARCHAR2);

  /*=================================================================================

    包：
      pkg_qa_itf_err(qa接口包)

    过程名:
      【结果传输】判定特定传输类型的所有信息已回传，如该传输类型所有信息已回传，
                  开启调度器，关闭执行器

    入参:
      v_inp_transtype       :  传输类型
      v_inp_transingasnids  :  传输中Asn单号，多值，分号分隔
      v_inp_dispelement     :  调度器 Element_id
      v_inp_transelement    :  执行器 Element_id

     版本:
       2023-04-03: 判定特定传输类型的所有信息已回传，如该传输类型所有信息已回传，
                   开启调度器，关闭执行器

  =================================================================================*/
  PROCEDURE p_resulttrans_judge_all_info_transed(v_inp_transtype      IN VARCHAR2,
                                                 v_inp_transingasnids IN VARCHAR2,
                                                 v_inp_dispelement    IN VARCHAR2,
                                                 v_inp_transelement   IN VARCHAR2);

  /*=================================================================================

    包：
      pkg_qa_itf_err(qa接口包)

    过程名:
      【结果传输】刷新未回传的 Asn单号

    入参:
      v_inp_transtype    :  传输类型
      v_inp_transingids  :  传输ids

     版本:
       2023-04-03: 刷新未回传的 Asn单号

  =================================================================================*/
  PROCEDURE p_resulttrans_refresh_not_transed_ids(v_inp_transtype   IN VARCHAR2,
                                                  v_inp_transingids IN CLOB);

END pkg_qa_itf_err;
/

