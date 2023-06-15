CREATE OR REPLACE PACKAGE SCMDATA.pkg_qa_da IS

  /*=============================================================================

     包：
       pkg_qa_da(QA数据访问包)

     函数名:
       校验Asn免检参数编码是否存在于系统字典中

     入参:
       v_inp_asnid        : AsnId
       v_inp_compid       : 企业Id
       v_inp_aeresoncode  : 免检原因编码

     返回值:
       Number 类型，0-不存在，1-存在

     版本:
       2022-10-09_ZC314 : 校验Asn免检参数编码是否存在于系统字典中

  ==============================================================================*/
  FUNCTION f_is_asnexemptionreason_in_dic(v_inp_aeresoncode IN VARCHAR2)
    RETURN NUMBER;

  /*=============================================================================

     包：
       pkg_qa_da(QA数据访问包)

     函数名:
       根据 Asn_id 获取 Asnorders 上架时间为空的数量

     入参:
       v_inp_asnid    : AsnId
       v_inp_compid   : 企业Id

     返回值:
       Number 类型，上架时间为空的数据数量

     版本:
       2022-10-09_ZC314 : 根据 Asn_id 获取 Asnorders 上架时间为空的数量

  ==============================================================================*/
  FUNCTION f_get_asnorders_receivetime_null_number_by_asnid(v_inp_asnid  IN VARCHAR2,
                                                            v_inp_compid IN VARCHAR2)
    RETURN NUMBER;

  /*=============================================================================

     包：
       pkg_qa_da(QA数据访问包)

     函数名:
       根据 Asn_id 获取 Asnordersitem 上架时间为空的数量

     入参:
       v_inp_asnid    : AsnId
       v_inp_compid   : 企业Id

     返回值:
       Number 类型，上架时间为空的数据数量

     版本:
       2022-10-09_ZC314 : 根据 Asn_id 获取 Asnordersitem 上架时间为空的数量

  ==============================================================================*/
  FUNCTION f_get_asnordersitem_receivetime_null_number_by_asnid(v_inp_asnid  IN VARCHAR2,
                                                                v_inp_compid IN VARCHAR2)
    RETURN NUMBER;

  /*=============================================================================

     包：
       pkg_qa_da(QA数据访问包)

     函数名:
       判断 Asn 预回传 Wms 表中是否存在该数据

     入参:
       v_inp_asnid    :  Asn单号
       v_inp_gooid    :  商品档案货号
       v_inp_barcode  :  条码
       v_inp_compid   : 企业Id

     返回值:
       Number 类型，0-不存在，1-存在

     版本:
       2022-10-09_ZC314 : 判断 Asn 预回传 Wms 表中是否存在该数据

  ==============================================================================*/
  FUNCTION f_is_asninfopretranstowms_exists(v_inp_asnid   IN VARCHAR2,
                                            v_inp_gooid   IN VARCHAR2 DEFAULT NULL,
                                            v_inp_barcode IN VARCHAR2 DEFAULT NULL,
                                            v_inp_compid  IN VARCHAR2)
    RETURN NUMBER;

  /*=============================================================================

     包：
       pkg_qa_da(QA数据访问包)

     函数名:
       获取 Asn 状态

     入参:
       v_inp_asnid    : Asn_Id
       v_inp_compid   : 企业Id

     返回值:
       Varchar2 类型，Asn状态编码

     版本:
       2022-10-09_ZC314 : 获取 Asn 状态

  ==============================================================================*/
  FUNCTION f_get_asnstatus(v_inp_asnid  IN VARCHAR2,
                           v_inp_compid IN VARCHAR2) RETURN VARCHAR2;

  /*=============================================================================

     包：
       pkg_qa_da(QA数据访问包)

     函数名:
       判断Qa已检从表中是否存在

     入参:
       v_inp_asnid    : Asn_Id
       v_inp_gooid    : 商品档案货号
       v_inp_barcode  : 条码
       v_inp_compid   : 企业Id

     返回值:
       Number 类型，0-不存在，1-存在

     版本:
       2022-10-09_ZC314 : 判断Qa已检从表中是否存在

  ==============================================================================*/
  FUNCTION f_is_qaqualedlistsla_exists(v_inp_asnid   IN VARCHAR2,
                                       v_inp_gooid   IN VARCHAR2,
                                       v_inp_barcode IN VARCHAR2,
                                       v_inp_compid  IN VARCHAR2)
    RETURN NUMBER;

  /*=============================================================================

     包：
       pkg_qa_da(QA数据访问包)

     函数名:
       判断Qa已检主表中是否存在

     入参:
       v_inp_asnid    : Asn_Id
       v_inp_gooid    : 商品档案货号
       v_inp_barcode  : 条码
       v_inp_compid   : 企业Id

     返回值:
       Number 类型，0-不存在，1-存在

     版本:
       2022-10-09_ZC314 : 判断Qa已检主表中是否存在

  ==============================================================================*/
  FUNCTION f_is_qaqualedlistmas_exists(v_inp_asnid  IN VARCHAR2,
                                       v_inp_compid IN VARCHAR2)
    RETURN NUMBER;

  /*=============================================================================

     包：
       pkg_qa_da(QA数据访问包)

     函数名:
       获取 Asn状态是否为已质检/免检

     入参:
       v_inp_asnid    : Asn_Id
       v_inp_compid   : 企业Id

     返回值:
       Number 类型，0-否，1-是

     版本:
       2022-10-11_ZC314 : 获取 Asn状态是否为已质检/免检

  ==============================================================================*/
  FUNCTION f_is_asnstatusaeorfa(v_inp_asnid  IN VARCHAR2,
                                v_inp_compid IN VARCHAR2) RETURN NUMBER;

  /*=============================================================================

     包：
       pkg_qa_da(QA数据访问包)

     函数名:
       判断是否多个asn拥有相同的供应商和货号

     入参:
       v_inp_asnids   : 多个Asn_Id，由分号分隔
       v_inp_compid   : 企业Id

     返回值:
       Number 类型，0-否，1-是

     版本:
       2022-10-12_ZC314 : 判断是否多个asn拥有相同的供应商和货号

  ==============================================================================*/
  FUNCTION f_is_multiasnhassamesupplierandgoo(v_inp_asnids IN CLOB,
                                              v_inp_compid IN VARCHAR2)
    RETURN NUMBER;

  /*=============================================================================

     包：
       pkg_qa_da(QA数据访问包)

     函数名:
       获取多个 Asn是否存在 Qa质检报告

     入参:
       v_inp_asnids   : 多个Asn_Id，由分号分隔
       v_inp_compid   : 企业Id

     返回值:
       Number 类型，0-否，1-是

     版本:
       2022-10-12_ZC314 : 获取多个 Asn是否存在 Qa质检报告

  ==============================================================================*/
  FUNCTION f_is_asnshasqareport(v_inp_asnids IN CLOB,
                                v_inp_compid IN VARCHAR2) RETURN NUMBER;

  /*=============================================================================

     包：
       pkg_qa_da(QA数据访问包)

     函数名:
       判断 Qa质检报告是否存在 Sku维度表数据

     入参:
       v_inp_qarepid  :  质检报告Id
       v_inp_compid   :  企业Id

     返回值:
       Number 类型，0-否，1-是

     版本:
       2022-10-14_ZC314 : 判断 Qa质检报告是否存在 Sku维度表数据

  ==============================================================================*/
  FUNCTION f_is_qarephasskudimdata(v_inp_qarepid IN VARCHAR2,
                                   v_inp_compid  IN VARCHAR2,
                                   v_inp_asnid   IN VARCHAR2,
                                   v_inp_gooid   IN VARCHAR2,
                                   v_inp_barcode IN VARCHAR2) RETURN NUMBER;

  /*=============================================================================

     包：
       pkg_qa_da(QA数据访问包)

     函数名:
       判断 Qa质检报告是否存在数据维度表数据

     入参:
       v_inp_qarepid  :  质检报告Id
       v_inp_compid   :  企业Id

     返回值:
       Number 类型，0-否，1-是

     版本:
       2022-10-14_ZC314 : 判断 Qa质检报告是否存在数据维度表数据

  ==============================================================================*/
  FUNCTION f_is_qarephasnumdimdata(v_inp_qarepid IN VARCHAR2,
                                   v_inp_compid  IN VARCHAR2) RETURN NUMBER;

  /*=============================================================================

     包：
       pkg_qa_da(QA数据访问包)

     函数名:
       判断 Qa质检报告是否存在质检细节维度表数据

     入参:
       v_inp_qarepid  :  质检报告Id
       v_inp_compid   :  企业Id

     返回值:
       Number 类型，0-否，1-是

     版本:
       2022-10-14_ZC314 : 判断 Qa质检报告是否存在质检细节维度表数据

  ==============================================================================*/
  FUNCTION f_is_qarephascheckdetaildimdata(v_inp_qarepid IN VARCHAR2,
                                           v_inp_compid  IN VARCHAR2)
    RETURN NUMBER;

  /*=============================================================================

     包：
       pkg_qa_da(QA数据访问包)

     函数名:
       判断 Qa质检报告是否存在关联信息维度数据

     入参:
       v_inp_qarepid  :  质检报告Id
       v_inp_compid   :  企业Id

     返回值:
       Number 类型，0-否，1-是

     版本:
       2022-10-13_ZC314 : 判断 Qa质检报告是否存在关联信息维度数据

  ==============================================================================*/
  FUNCTION f_is_asnshasqareportrelainfodim(v_inp_qarepid IN VARCHAR2,
                                           v_inp_compid  IN VARCHAR2)
    RETURN NUMBER;

  /*=============================================================================

     包：
       pkg_qa_da(QA数据访问包)

     函数名:
       校验输入人员是否存在于当前企业(需搭配v_inp_userids去重逻辑)

     入参:
       v_inp_userids   :  输入人员Id，多值，用【分号】分隔
       v_inp_compid    :  企业Id

     返回值:
       Number 类型，0-存在输入人员不存在于企业的情况
                    1-所有输入人员都存在于当前企业

     版本:
       2022-10-19_ZC314 : 校验输入人员是否存在于当前企业(需搭配v_inp_userids去重逻辑)

  ==============================================================================*/
  FUNCTION f_is_usersincompany(v_inp_userids IN VARCHAR2,
                               v_inp_compid  IN VARCHAR2) RETURN NUMBER;

  /*=============================================================================

     包：
       pkg_qa_da(QA数据访问包)

     函数名:
       校验输入人员是否存在被禁用的情况

     入参:
       v_inp_userids   :  输入人员Id，多值，用分隔符分隔
       v_inp_compid    :  企业Id

     返回值:
       Number 类型，0-不存在人员被禁用的情况
                    1-存在人员被禁用的情况

     版本:
       2022-10-19_ZC314 : 校验输入人员是否存在被禁用的情况

  ==============================================================================*/
  FUNCTION f_is_companyuserpaused(v_inp_userids IN VARCHAR2,
                                  v_inp_compid  IN VARCHAR2) RETURN NUMBER;

  /*=============================================================================

     包：
       pkg_qa_da(QA数据访问包)

     函数名:
       校验输入人员是否都属于输入企业Qa组

     入参:
       v_inp_userids   :  输入人员Id，多值，用分隔符分隔
       v_inp_compid    :  企业Id

     返回值:
       Number 类型，0-存在人员不属于当前企业Qa组
                    1-所有人员都属于当前企业Qa组

     版本:
       2022-10-19_ZC314 : 校验输入人员是否都属于输入企业Qa组

  ==============================================================================*/
  FUNCTION f_is_userincompanyqadept(v_inp_userids IN VARCHAR2,
                                    v_inp_compid  IN VARCHAR2) RETURN NUMBER;

  /*=============================================================================

     包：
       pkg_qa_da(QA数据访问包)

     函数名:
       根据Qa质检报告获取预计到仓数量

     入参:
       v_inp_qarepid  :  Qa质检报告Id
       v_inp_compid   :  企业Id

     返回值:
       Number 类型，预计到仓数量

     版本:
       2022-10-19_ZC314 : 根据Qa质检报告获取预计到仓数量

  ==============================================================================*/
  FUNCTION f_get_qareppcomeamount(v_inp_qarepid IN VARCHAR2,
                                  v_inp_compid  IN VARCHAR2) RETURN NUMBER;

  /*=============================================================================

     包：
       pkg_qa_da(qa数据访问包)

     函数名:
       获取质检报告状态

     入参:
       v_inp_qarepid  :  质检报告Id
       v_inp_compid   :  企业Id

     返回值:
       Varchar2 类型，质检报告状态

     版本:
       2022-10-21_zc314 : 获取质检报告状态

  ==============================================================================*/
  FUNCTION f_get_qarepstatus(v_inp_qarepid IN VARCHAR2,
                             v_inp_compid  IN VARCHAR2) RETURN VARCHAR2;

  /*=============================================================================

     包：
       pkg_qa_da(qa数据访问包)

     函数名:
       获取质检报告质检结果

     入参:
       v_inp_qarepid  :  质检报告Id
       v_inp_compid   :  企业Id

     返回值:
       Varchar2 类型，质检报告质检结果

     版本:
       2022-10-21_zc314 : 获取质检报告质检结果

  ==============================================================================*/
  FUNCTION f_get_qarepcheckresult(v_inp_qarepid IN VARCHAR2,
                                  v_inp_compid  IN VARCHAR2) RETURN VARCHAR2;

  /*=============================================================================

     包：
       pkg_qa_da(qa数据访问包)

     函数名:
       判断报告下Asn是否没有完成收货上架

     入参:
       v_inp_qarepid  :  质检报告Id
       v_inp_compid   :  企业Id

     返回值:
       Number 类型，0-已完成收货上架
                    1-未完成收货上架

     版本:
       2022-12-01_zc314 : 判断报告下Asn是否没有完成收货上架

  ==============================================================================*/
  FUNCTION f_isrepasnnotreceived(v_inp_qarepid IN VARCHAR2,
                                 v_inp_asnid   IN VARCHAR2,
                                 v_inp_compid  IN VARCHAR2) RETURN VARCHAR2;

  /*=============================================================================

     包：
       pkg_qa_da(qa数据访问包)

     过程名:
       获取质检报告条件检查字段值

     入参:
       v_inp_qarepid  :  质检报告Id
       v_inp_compid   :  企业Id

     入出参:
       v_iop_checkresult          :  质检结果
       v_iop_problemdescriptions  :  问题描述
       v_iop_reviewcomments       :  审核意见

     版本:
       2022-10-21_zc314 : 获取质检报告条件检查字段值

  ==============================================================================*/
  PROCEDURE p_get_qarepcondcheckfields(v_inp_qarepid             IN VARCHAR2,
                                       v_inp_compid              IN VARCHAR2,
                                       v_iop_checkresult         IN OUT VARCHAR2,
                                       v_iop_problemdescriptions IN OUT VARCHAR2,
                                       v_iop_reviewcomments      IN OUT VARCHAR2);

  /*=============================================================================

     包：
       pkg_qa_da(QA数据访问包)

     函数名:
       通过Sku获取质检报告内质检减数校验数量值

     入参:
       v_inp_qarepid  :  质检报告Id
       v_inp_compid   :  企业Id
       v_inp_asnid    :  Asn单号
       v_inp_gooid    :  商品档案货号
       v_inp_barcode  :  条码

     返回值:
       Number 类型，收货数量/预计到仓数量

     版本:
       2022-10-24_ZC314 : 通过Sku获取质检报告内质检减数校验数量值

  ==============================================================================*/
  FUNCTION f_get_checkamountbysku(v_inp_qarepid IN VARCHAR2,
                                  v_inp_compid  IN VARCHAR2,
                                  v_inp_asnid   IN VARCHAR2,
                                  v_inp_gooid   IN VARCHAR2,
                                  v_inp_barcode IN VARCHAR2) RETURN NUMBER;

  /*=============================================================================

     包：
       pkg_qa_da(QA数据访问包)

     函数名:
       通过质检报告Id，企业Id 获取 Sku唯一质检结果数量

     入参:
       v_inp_qarepid  :  质检报告Id
       v_inp_compid   :  企业Id

     返回值:
       Number 类型: Sku唯一质检结果数量

     版本:
       2022-10-24_ZC314 : 通过质检报告Id，企业Id获取Sku唯一质检结果数量，质检结果最大值
       2022-11-03_ZC314 : 修改为仅获取Sku唯一质检结果数量

  ==============================================================================*/
  FUNCTION f_get_qarepskucheckresultcount(v_inp_qarepid IN VARCHAR2,
                                          v_inp_compid  IN VARCHAR2)
    RETURN NUMBER;

  /*=============================================================================

     包：
       pkg_qa_da(QA数据访问包)

     函数名:
       获取质检报告不合格数量

     入参:
       v_inp_qarepid    :  质检报告Id
       v_inp_compid     :  企业Id

     版本:
       2022-10-25_ZC314 : 获取质检报告不合格数量

  ==============================================================================*/
  FUNCTION f_get_qarepunqualamount(v_inp_qarepid IN VARCHAR2,
                                   v_inp_compid  IN VARCHAR2) RETURN NUMBER;

  /*=============================================================================

     包：
       pkg_qa_da(QA数据访问包)

     函数名:
       获取质检报告质检减数

     入参:
       v_inp_qarepid    :  质检报告Id
       v_inp_compid     :  企业Id

     版本:
       2022-10-25_ZC314 : 获取质检报告质检减数

  ==============================================================================*/
  FUNCTION f_get_qarepdecreamount(v_inp_qarepid IN VARCHAR2,
                                  v_inp_compid  IN VARCHAR2) RETURN NUMBER;

  /*=============================================================================

     包：
       pkg_qa_da(QA数据访问包)

     函数名:
       判断报告内是否存在Sku未收货

     入参:
       v_inp_qarepid    :  质检报告Id
       v_inp_asnid      :  AsnId
       v_inp_compid     :  企业Id

     返回值:
       Number 类型: 0-已全部收货
                    1-存在Sku未收货

     版本:
       2022-10-26_ZC314 : 判断报告内是否存在Sku未收货

  ==============================================================================*/
  FUNCTION f_is_asnskunotreceived(v_inp_qarepid IN VARCHAR2,
                                  v_inp_asnid   IN VARCHAR2,
                                  v_inp_compid  IN VARCHAR2) RETURN NUMBER;

  /*=============================================================================

    包：
      pkg_qa_ld(qa逻辑细节包)

    函数名:
      校验 Asn/Asn sku接口数据是否已经同步正确

    入参:
      v_inp_asnid    :  asn单号
      v_inp_compid   :  企业id
      v_inp_barcode  :  条码

    返回值:
      number 类型: 0-Asn/Asn sku接口数据存在部分不成功
                   1-Asn/Asn sku接口数据已同步成功

    版本:
      2022-11-21_zc314 : 校验 Asn/Asn sku接口数据是否已经同步正确

  ==============================================================================*/
  FUNCTION f_is_asnitfsynccorrectly(v_inp_asnid   IN VARCHAR2,
                                    v_inp_compid  IN VARCHAR2,
                                    v_inp_barcode IN VARCHAR2 DEFAULT NULL)
    RETURN NUMBER;

  /*=================================================================================

    包：
      pkg_qa_da(qa数据访问包)

    过程名:
      获取预回传表状态，错误信息

    入参:
      v_inp_asnid    :  Asn单号
      v_inp_compid   :  企业Id
      v_inp_gooid    :  货号
      v_inp_barcode  :  条码

    入出参:
      v_inp_status   :  预回传表状态
      v_inp_errinfo  :  预回传表错误信息

     版本:
       2022-11-21: 获取预回传表状态，错误信息

  =================================================================================*/
  PROCEDURE p_get_pretransstatusanderrinfo(v_inp_asnid   IN VARCHAR2,
                                           v_inp_compid  IN VARCHAR2,
                                           v_inp_gooid   IN VARCHAR2 DEFAULT NULL,
                                           v_inp_barcode IN VARCHAR2 DEFAULT NULL,
                                           v_inp_status  IN OUT VARCHAR2,
                                           v_inp_errinfo IN OUT CLOB);

  /*=============================================================================

     包：
       pkg_qa_da(QA数据访问包)

     函数名:
       获取质检报告处理类型

     入参:
       v_inp_qarepid    :  质检报告Id
       v_inp_compid     :  企业Id

     返回值:
       Varchar2 类型: 报告处理类型

     版本:
       2022-10-26_ZC314 : 获取质检报告处理类型

  ==============================================================================*/
  FUNCTION f_get_qarepprocessingtype(v_inp_qarepid IN VARCHAR2,
                                     v_inp_compid  IN VARCHAR2)
    RETURN VARCHAR2;

  /*=============================================================================

     包：
       pkg_qa_da(QA数据访问包)

     函数名:
       判断报告内是否存在 Sku未完成质检

     入参:
       v_inp_qarepid  :  质检报告Id
       v_inp_asnid    :  Asn单号
       v_inp_compid   :  企业Id

     返回值:
       Number 类型: 0-已全部完成质检
                    1-存在Sku未完成质检

     版本:
       2022-10-28_ZC314 : 判断报告内是否存在 Sku未完成质检

  ==============================================================================*/
  FUNCTION f_is_anyqarepskunotaf(v_inp_qarepid IN VARCHAR2,
                                 v_inp_compid  IN VARCHAR2) RETURN NUMBER;

  /*=============================================================================

     包：
       pkg_qa_da(QA数据访问包)

     函数名:
       判断报告内是否存在某 Asn下 Sku未完成质检

     入参:
       v_inp_qarepid  :  质检报告Id
       v_inp_asnid    :  Asn单号
       v_inp_compid   :  企业Id

     返回值:
       Number 类型: 0-已全部完成质检
                    1-存在Sku未完成质检

     版本:
       2022-10-28_ZC314 : 判断报告内是否存在某 Asn下 Sku未完成质检

  ==============================================================================*/
  FUNCTION f_is_anyqarepasnskunotaf(v_inp_qarepid IN VARCHAR2,
                                    v_inp_asnid   IN VARCHAR2,
                                    v_inp_compid  IN VARCHAR2) RETURN NUMBER;

  /*=============================================================================

     包：
       pkg_qa_da(QA数据访问包)

     函数名:
       判断报告Sku是否重复维护不合格处理

     入参:
       v_inp_qarepid    :  质检报告Id
       v_inp_compid     :  企业Id
       v_inp_asnid      :  Asn单号
       v_inp_gooid      :  商品档案货号
       v_inp_barcode    :  条码

     返回值:
       Number 类型: 0-Sku未重复维护不合格处理
                    1-Sku重复维护不合格处理

     版本:
       2022-10-27_ZC314 : 判断报告Sku是否重复维护不合格处理

  ==============================================================================*/
  FUNCTION f_is_qareprepeatsetprocessresult(v_inp_qarepid IN VARCHAR2,
                                            v_inp_compid  IN VARCHAR2,
                                            v_inp_asnid   IN VARCHAR2,
                                            v_inp_gooid   IN VARCHAR2,
                                            v_inp_barcode IN VARCHAR2)
    RETURN NUMBER;

  /*=============================================================================

     包：
       pkg_qa_da(QA数据访问包)

     函数名:
       校验传入数据是否存在【待返工Sku个数】等于0

     入参:
       v_inp_qarepids :  质检报告Id，多值，用分号分隔
       v_inp_compid   :  企业Id

     返回值:
       Number 类型: 0-已全部完成质检
                    1-存在Sku未完成质检

     版本:
       2022-10-28_ZC314 : 校验传入数据是否存在【待返工Sku个数】等于0

  ==============================================================================*/
  FUNCTION f_is_anyqarepprereworkskunumequalzero(v_inp_qarepids IN VARCHAR2,
                                                 v_inp_compid   IN VARCHAR2)
    RETURN NUMBER;

  /*=============================================================================

     包：
       pkg_qa_da(QA数据访问包)

     函数名:
       校验传入数据是否存在【供应商】+【货号】不唯一

     入参:
       v_inp_qarepids :  质检报告Id，多值，用分号分隔
       v_inp_compid   :  企业Id

     返回值:
       Number 类型: 0-传入数据【供应商】+【货号】唯一
                    1-传入数据【供应商】+【货号】不唯一

     版本:
       2022-10-28_ZC314 : 校验传入数据是否存在【供应商】+【货号】不唯一

  ==============================================================================*/
  FUNCTION f_is_qarepssupplierandgoonotsame(v_inp_qarepids IN VARCHAR2,
                                            v_inp_compid   IN VARCHAR2)
    RETURN NUMBER;

  /*=============================================================================

     包：
       pkg_qa_da(QA数据访问包)

     过程名:
       获取报告待返工 Sku数量，质检减数总数，不合格总数

     入参:
       v_inp_qarepid      : 质检报告Id
       v_inp_compid       : 企业Id

     入出参:
       v_iop_preprocessamount  :  待返工Sku数量
       v_iop_decreaseamount    :  质检减数总和
       v_iop_unqualsumamount   :  质检不合格数量总和

     版本:
       2022-10-31_ZC314 : 获取报告待返工 Sku数量，质检减数总数，不合格总数

  ==============================================================================*/
  PROCEDURE p_get_qareppreamountrela(v_inp_qarepid          IN VARCHAR2,
                                     v_inp_compid           IN VARCHAR2,
                                     v_iop_preprocessamount IN OUT NUMBER,
                                     v_iop_decreaseamount   IN OUT NUMBER,
                                     v_iop_unqualsumamount  IN OUT NUMBER);

  /*=============================================================================

     包：
       pkg_qa_da(QA数据访问包)

     过程名:
       获取报告Sku状态

     入参:
       v_inp_qarepid  :  质检报告Id
       v_inp_compid   :  企业Id
       v_inp_asnid    :  asn单号
       v_inp_gooid    :  商品档案货号
       v_inp_barcode  :  条码

     版本:
       2022-10-31_ZC314 : 获取报告Sku状态

  ==============================================================================*/
  FUNCTION f_get_qarepskustatus(v_inp_qarepid IN VARCHAR2,
                                v_inp_compid  IN VARCHAR2,
                                v_inp_asnid   IN VARCHAR2,
                                v_inp_gooid   IN VARCHAR2,
                                v_inp_barcode IN VARCHAR2) RETURN VARCHAR2;

  /*=============================================================================

     包：
       pkg_qa_da(QA数据访问包)

     函数名:
       获取质检报告-质检类型

     入参:
       v_inp_qarepid  :  质检报告Id
       v_inp_compid   :  企业Id

     返回值:
       Varchar2 类型，质检类型

     版本:
       2022-11-01_ZC314 : 获取质检报告-质检类型

  ==============================================================================*/
  FUNCTION f_get_qarepchecktype(v_inp_qarepid IN VARCHAR2,
                                v_inp_compid  IN VARCHAR2) RETURN VARCHAR2;

  /*=============================================================================

     包：
       pkg_qa_da(QA数据访问包)

     函数名:
       获取 Sku最新的质检报告Id

     入参:
       v_inp_asnid    :  Asn单号
       v_inp_gooid    :  商品档案货号
       v_inp_barcode  :  条码
       v_inp_qarepid  :  质检报告Id
       v_inp_compid   :  企业Id

     返回值:
       Varchar2 类型，质检报告Id

     版本:
       2022-11-01_ZC314 : 获取 Sku最新的质检报告Id

  ==============================================================================*/
  FUNCTION f_get_skulastestqarepid(v_inp_asnid   IN VARCHAR2,
                                   v_inp_gooid   IN VARCHAR2,
                                   v_inp_barcode IN VARCHAR2,
                                   v_inp_qarepid IN VARCHAR2,
                                   v_inp_compid  IN VARCHAR2) RETURN VARCHAR2;

  /*=============================================================================

     包：
       pkg_qa_da(QA数据访问包)

     函数名:
       获取汇总 Qa质检报告 Sku处理结果

     入参:
       v_inp_qarepid    :  质检报告Id
       v_inp_compid     :  企业Id

     出参:
       Varchar2 类型，处理结果

     版本:
       2022-10-11_zc314 : 获取汇总 Qa质检报告 Sku处理结果

  ==============================================================================*/
  FUNCTION f_get_qarepprocessresultbysku(v_inp_qarepid IN VARCHAR2,
                                         v_inp_compid  IN VARCHAR2)
    RETURN VARCHAR2;

  /*=============================================================================

     包：
       pkg_qa_da(QA数据访问包)

     函数名:
       获取质检报告仓库

     入参:
       v_inp_qarepid  :  质检报告Id
       v_inp_compid   :  企业Id

     出参:
       Varchar2 类型，仓库

     版本:
       2022-10-11_zc314 : 获取质检报告仓库

  ==============================================================================*/
  FUNCTION f_get_shoid(v_inp_qarepid IN VARCHAR2, v_inp_compid IN VARCHAR2)
    RETURN VARCHAR2;

  /*=============================================================================

     包：
       pkg_qa_ld(qa逻辑细节包)

     过程名:
       Qa消息配置表是否存在数据

     入参:
       v_inp_configcode  :  qa消息配置编码
       v_inp_compid      :  企业Id

     返回值:
       Number 类型，0-不存在于Qa消息配置表
                    1-存在于Qa消息配置表

     版本:
       2022-12-08_zc314 : Qa消息表是否存在数据

  ==============================================================================*/
  FUNCTION f_is_qamsgconfigexists(v_inp_configcode IN VARCHAR2,
                                  v_inp_compid     IN VARCHAR2) RETURN NUMBER;

  /*=============================================================================

     包：
       pkg_qa_ld(qa逻辑细节包)

     过程名:
       Qa消息表是否存在数据

     入参:
       v_inp_configcode  :  qa消息配置编码
       v_inp_unqinfo     :  唯一信息
       v_inp_compid      :  企业Id

     返回值:
       Number 类型，0-不存在于Qa消息表
                    1-存在于Qa消息表

     版本:
       2022-12-08_zc314 : Qa消息表是否存在数据

  ==============================================================================*/
  FUNCTION f_is_qamsginfoexists(v_inp_configcode IN VARCHAR2,
                                v_inp_unqinfo    IN VARCHAR2,
                                v_inp_compid     IN VARCHAR2) RETURN NUMBER;

  /*=============================================================================

     包：
       pkg_qa_da(QA数据访问包)

     函数名:
       获取特定执行参数的触发状态

     入参:
       v_executeparam  :  执行参数

     出参:
       Varchar2 类型，仓库

     版本:
       2022-12-09_zc314 : 获取特定执行参数的触发状态

  ==============================================================================*/
  FUNCTION f_get_xxltriggerstatus(v_executeparam IN VARCHAR2) RETURN NUMBER;

  /*=============================================================================

     包：
       pkg_qa_da(QA数据访问包)

     函数名:
       获取质检报告仓库，分类

     入参:
       v_inp_qarepid  :  质检报告Id
       v_inp_compid   :  企业Id

     入出参:
       v_iop_shoids  :  仓库Id，多值，用分号分隔
       v_iop_cates   :  分类Id，多值，用分号分隔

     版本:
       2022-12-12_zc314 : 获取质检报告仓库

  ==============================================================================*/
  PROCEDURE p_get_multishoandcatebyqarep(v_inp_qarepid IN VARCHAR2,
                                         v_inp_compid  IN VARCHAR2,
                                         v_iop_shoids  IN OUT VARCHAR2,
                                         v_iop_cates   IN OUT VARCHAR2);

  /*=============================================================================

     包：
       pkg_qa_da(QA数据访问包)

     函数名:
       获取质检报告唯一传输结果数量，传输结果最大值

     入参:
       v_inp_qarepid  :  质检报告Id
       v_inp_compid   :  企业Id

     入出参:
       v_iop_trnum  :  唯一传输结果数量
       v_iop_maxtr  :  传输结果最大值

     版本:
       2022-12-12_zc314 : 获取质检报告仓库

  ==============================================================================*/
  PROCEDURE p_get_qualedtrnumandmaxtr(v_inp_qarepid IN VARCHAR2,
                                      v_inp_compid  IN VARCHAR2,
                                      v_iop_trnum   IN OUT NUMBER,
                                      v_iop_maxtr   IN OUT VARCHAR2);

  /*=============================================================================

     包：
       pkg_qa_da(QA数据访问包)

     函数名:
       判断是否存在批退数据

     入参:
       v_inp_qarepid  :  质检报告Id
       v_inp_compid   :  企业Id

     返回值:
       Number 类型，0-不存在批退数据
                    1-存在批退数据

     版本:
       2022-12-13_zc314 : 判断是否存在批退数据

  ==============================================================================*/
  FUNCTION f_has_nptransresult(v_inp_qarepid IN VARCHAR2,
                               v_inp_compid  IN VARCHAR2) RETURN NUMBER;

  /*=============================================================================

     包：
       pkg_qa_da(QA数据访问包)

     函数名:
       判断是否存在Sku质检不合格数据

     入参:
       v_inp_qarepid  :  质检报告Id
       v_inp_compid   :  企业Id

     返回值:
       Number 类型，0-不存在Sku质检不合格数据
                    1-存在Sku质检不合格数据

     版本:
       2022-12-13_zc314 : 判断是否存在Sku质检不合格数据

  ==============================================================================*/
  FUNCTION f_has_npskucheckresult(v_inp_qarepid IN VARCHAR2,
                                  v_inp_compid  IN VARCHAR2) RETURN NUMBER;

  /*=============================================================================

     包：
       pkg_qa_da(qa数据访问包)

     函数名:
       判断是否存在于Qa尺寸核对表

     入参:
       v_inp_qarepid   :  Qa质检报告Id
       v_inp_position  :  部位
       v_inp_compid    :  企业Id
       v_inp_gooid     :  商品档案货号
       v_inp_barcode   :  条码
       v_inp_seqno     :  序号

     返回值:
       Number 类型，0-不存在于Qa尺寸核对表
                    1-存在于Qa尺寸核对表

     版本:
       2022-12-14_zc314 : 判断是否存在于Qa尺寸核对表
       2022-12-15_zc314 : 维度调整，增加尺寸表Id维度
       2023-01-04_zc314 : 维度调整，尺寸表Id修改为部位

  ==============================================================================*/
  FUNCTION f_is_qasizecheckchartexists(v_inp_qarepid  IN VARCHAR2,
                                       v_inp_position IN VARCHAR2,
                                       v_inp_compid   IN VARCHAR2,
                                       v_inp_gooid    IN VARCHAR2,
                                       v_inp_barcode  IN VARCHAR2,
                                       v_inp_seqno    IN NUMBER)
    RETURN NUMBER;

  /*=============================================================================

     包：
       pkg_qa_da(qa数据访问包)

     函数名:
       判断商品是否存在尺寸表

     入参:
       v_inp_gooid        :  商品档案货号
       v_inp_compid       :  企业Id

     返回值:
       Number 类型，0-商品不存在尺寸表
                    1-商品存在尺寸表

     版本:
       2022-12-15_zc314 : 判断商品是否存在尺寸表

  ==============================================================================*/
  FUNCTION f_is_goosizechartexists(v_inp_gooid  IN VARCHAR2,
                                   v_inp_compid IN VARCHAR2) RETURN NUMBER;

  /*=============================================================================

     包：
       pkg_qa_da(qa数据访问包)

     过程名:
       根据质检报告获取度尺件数

     入参:
       v_inp_qarepid    :  质检报告Id
       v_inp_compid     :  企业Id

     返回值:
       Number 类型，质检报告度尺件数

     版本:
       2022-12-15_zc314 : 根据质检报告获取度尺件数

  ==============================================================================*/
  FUNCTION f_get_scaleamountqarep(v_inp_qarepid IN VARCHAR2,
                                  v_inp_compid  IN VARCHAR2) RETURN NUMBER;

  /*=============================================================================

     包：
       pkg_qa_da(qa数据访问包)

     函数名:
       判断当前报告Sku是否存在下一件尺寸核对数据

     入参:
       v_inp_qarepid    :  质检报告Id
       v_inp_gooid      :  商品档案货号
       v_inp_barcode    :  条码
       v_inp_nextseq    :  下一件序号
       v_inp_compid     :  企业Id

     返回值:
       Number 类型，0-不存在下一件尺寸核对数据
                    1-存在下一件尺寸核对数据

     版本:
       2022-12-15_zc314 : 判断当前报告Sku是否存在下一件尺寸核对数据

  ==============================================================================*/
  FUNCTION f_is_qarepskuhasnextsizecheckdata(v_inp_qarepid IN VARCHAR2,
                                             v_inp_gooid   IN VARCHAR2,
                                             v_inp_barcode IN VARCHAR2,
                                             v_inp_nextseq IN NUMBER,
                                             v_inp_compid  IN VARCHAR2)
    RETURN NUMBER;

  /*=============================================================================

     包：
       pkg_qa_da(qa数据访问包)

     函数名:
       获取当前报告Sku尺寸核对单据总和

     入参:
       v_inp_qarepid    :  质检报告Id
       v_inp_compid     :  企业Id
       v_inp_gooid      :  商品档案货号
       v_inp_barcode    :  条码

     返回值:
       Number 类型，当前报告Sku尺寸核对单据总和

     版本:
       2022-12-15_zc314 : 获取当前报告Sku尺寸核对单据总和

  ==============================================================================*/
  FUNCTION f_get_qarepskusizechecktotalnum(v_inp_qarepid IN VARCHAR2,
                                           v_inp_compid  IN VARCHAR2,
                                           v_inp_gooid   IN VARCHAR2,
                                           v_inp_barcode IN VARCHAR2)
    RETURN NUMBER;

  /*=============================================================================

     包：
       pkg_qa_da(QA数据访问包)

     函数名:
       获取 Qa 尺寸表操作人Id

     入参:
       v_inp_qarepid   :  Qa质检报告Id
       v_inp_compid    :  企业Id
       v_inp_position  :  部位
       v_inp_gooid     :  商品档案货号
       v_inp_barcode   :  条码
       v_inp_seqno     :  序号

     返回值:
       Varchar2 类型，Qa 尺寸表操作人Id

     版本:
       2022-12-30_ZC314 : 获取 Qa 尺寸表操作人Id
       2023-01-04_ZC314 : 维度调整尺寸表Id修改为部位

  ==============================================================================*/
  FUNCTION f_get_qasizechartoperuserid(v_inp_qarepid  IN VARCHAR2,
                                       v_inp_compid   IN VARCHAR2,
                                       v_inp_position IN VARCHAR2,
                                       v_inp_gooid    IN VARCHAR2,
                                       v_inp_barcode  IN VARCHAR2,
                                       v_inp_seqno    IN NUMBER)
    RETURN VARCHAR2;

  /*=============================================================================

     包：
       pkg_qa_da(QA数据访问包)

     函数名:
       判断当前操作是否将清空 Qa尺寸核对录入记录

     入参:
       v_inp_qarepid      :  Qa质检报告Id
       v_inp_compid       :  企业Id
       v_inp_gooid        :  商品档案货号
       v_inp_barcode      :  条码
       v_inp_seqno        :  序号

     返回值:
       Number 类型，0-当前操作不会清空Qa尺寸核对录入记录
                    1-当前操作会清空Qa尺寸核对录入记录

     版本:
       2022-12-30_ZC314 : 判断当前操作是否将清空 Qa尺寸核对录入记录

  ==============================================================================*/
  FUNCTION f_is_qasizechartupdtoempty(v_inp_qarepid IN VARCHAR2,
                                      v_inp_compid  IN VARCHAR2,
                                      v_inp_gooid   IN VARCHAR2,
                                      v_inp_barcode IN VARCHAR2,
                                      v_inp_seqno   IN NUMBER) RETURN NUMBER;

  /*=============================================================================

     包：
       pkg_qa_da(QA数据访问包)

     函数名:
       获取当前Sku Qa尺寸录入记录为空的序号

     入参:
       v_inp_qarepid  :  Qa质检报告Id
       v_inp_compid   :  企业Id
       v_inp_gooid    :  商品档案货号
       v_inp_barcode  :  条码

     返回值:
       Number 类型，Qa尺寸录入记录为空的序号

     版本:
       2022-12-30_ZC314 : 获取当前Sku Qa尺寸录入记录为空的序号

  ==============================================================================*/
  FUNCTION f_get_qasizechartemptyseqno(v_inp_qarepid IN VARCHAR2,
                                       v_inp_compid  IN VARCHAR2,
                                       v_inp_gooid   IN VARCHAR2,
                                       v_inp_barcode IN VARCHAR2)
    RETURN NUMBER;

  /*=============================================================================

     包：
       pkg_qa_da(QA数据访问包)

     函数名:
       判断 Asn 是否存在于 Asnordered

     入参:
       v_inp_asnid   :  Qa质检报告Id
       v_inp_compid  :  企业Id

     返回值:
       Number 类型，0-Asn 不存在于 Asnordered
                    1-Asn 存在于 Asnordered

     版本:
       2022-12-31_ZC314 : 判断 Asn 是否存在于 Asnordered

  ==============================================================================*/
  FUNCTION f_is_asnorderedrecexists(v_inp_asnid  IN VARCHAR2,
                                    v_inp_compid IN VARCHAR2) RETURN NUMBER;

  /*=============================================================================

     包：
       pkg_qa_da(QA数据访问包)

     函数名:
       校验商品档案货号是否存在于Qa尺寸核对表内

     入参:
       v_inp_gooid   :  商品档案货号
       v_inp_compid  :  企业Id

     返回值:
       Number 类型，0-不存在，1-存在

     版本:
       2023-01-04_ZC314 : 校验商品档案货号是否存在于Qa尺寸核对表内

  ==============================================================================*/
  FUNCTION f_is_gooexistinqasizecheckchart(v_inp_gooid  IN VARCHAR2,
                                           v_inp_compid IN VARCHAR2)
    RETURN NUMBER;

  /*=============================================================================

     包：
       pkg_qa_da(QA数据访问包)

     函数名:
       校验商品档案货号是否存在“部位”不存在于Qa尺寸核对表内

     入参:
       v_inp_gooid   :  商品档案货号
       v_inp_compid  :  企业Id

     返回值:
       Number 类型，0-所有部位都已存在于Qa尺寸核对表中
                    1-有部位不存在于Qa尺寸核对表中

     版本:
       2023-01-04_ZC314 : 校验商品档案货号是否存在“部位”不存在于Qa尺寸核对表内

  ==============================================================================*/
  FUNCTION f_is_goospositionnotexistsinqasizecheckchart(v_inp_gooid  IN VARCHAR2,
                                                        v_inp_compid IN VARCHAR2)
    RETURN NUMBER;

  /*=============================================================================

     包：
       pkg_qa_da(QA数据访问包)

     函数名:
       根据商品档案编号获取货号

     入参:
       v_inp_gooid   :  商品档案货号
       v_inp_compid  :  企业Id

     返回值:
       Varchar 类型，货号

     版本:
       2023-01-04_ZC314 : 根据商品档案编号获取货号

  ==============================================================================*/
  FUNCTION f_get_relagooidbygooid(v_inp_gooid  IN VARCHAR2,
                                  v_inp_compid IN VARCHAR2) RETURN VARCHAR2;

  /*=============================================================================

     包：
       pkg_qa_da(QA数据访问包)

     函数名:
       获取拿货员和拿货记录

     入参:
       v_inp_qarepid  :  质检报告Id
       v_inp_compid   :  企业Id

     返回值:
       Varchar2 类型，查货员

     版本:
       2023-01-09_ZC314 : 获取拿货员和拿货记录

  ==============================================================================*/
  FUNCTION f_get_qarepcheckers(v_inp_qarepid IN VARCHAR2,
                               v_inp_compid  IN VARCHAR2) RETURN VARCHAR2;

  /*=============================================================================

     包：
       pkg_qa_da(QA数据访问包)

     函数名:
       根据传入用户Id获取企业用户名称

     入参:
       v_inp_userid  :  用户Id
       v_inp_compid  :  企业Id

     返回值:
       Varchar 类型，企业用户名称

     版本:
       2023-01-07_ZC314 : 根据传入用户Id获取企业用户名称

  ==============================================================================*/
  FUNCTION f_get_companyusernamebyuserid(v_inp_userid IN VARCHAR2,
                                         v_inp_compid IN VARCHAR2)
    RETURN VARCHAR2;

END pkg_qa_da;
/

CREATE OR REPLACE PACKAGE BODY SCMDATA.pkg_qa_da IS

  /*=============================================================================

     包：
       pkg_qa_da(QA数据访问包)

     函数名:
       校验Asn免检参数编码是否存在于系统字典中

     入参:
       v_inp_asnid        : AsnId
       v_inp_compid       : 企业Id
       v_inp_aeresoncode  : 免检原因编码

     返回值:
       Number 类型，0-不存在，1-存在

     版本:
       2022-10-09_ZC314 : 校验Asn免检参数编码是否存在于系统字典中

  ==============================================================================*/
  FUNCTION f_is_asnexemptionreason_in_dic(v_inp_aeresoncode IN VARCHAR2)
    RETURN NUMBER IS
    v_jugnum NUMBER(1);
  BEGIN
    SELECT nvl(MAX(1), 0)
      INTO v_jugnum
      FROM scmdata.sys_group_dict
     WHERE group_dict_type = 'QA_AEREASON'
       AND upper(group_dict_value) = upper(v_inp_aeresoncode);

    RETURN v_jugnum;
  END f_is_asnexemptionreason_in_dic;

  /*=============================================================================

     包：
       pkg_qa_da(QA数据访问包)

     函数名:
       根据 Asn_id 获取 Asnorders 上架时间为空的数量

     入参:
       v_inp_asnid    : AsnId
       v_inp_compid   : 企业Id

     返回值:
       Number 类型，上架时间为空的数据数量

     版本:
       2022-10-09_ZC314 : 根据 Asn_id 获取 Asnorders 上架时间为空的数量

  ==============================================================================*/
  FUNCTION f_get_asnorders_receivetime_null_number_by_asnid(v_inp_asnid  IN VARCHAR2,
                                                            v_inp_compid IN VARCHAR2)
    RETURN NUMBER IS
    v_receivetimenullnum NUMBER(8);
  BEGIN
    SELECT COUNT(1)
      INTO v_receivetimenullnum
      FROM scmdata.t_asnorders
     WHERE asn_id = v_inp_asnid
       AND company_id = v_inp_compid
       AND receive_time IS NULL;

    RETURN v_receivetimenullnum;
  END f_get_asnorders_receivetime_null_number_by_asnid;

  /*=============================================================================

     包：
       pkg_qa_da(QA数据访问包)

     函数名:
       根据 Asn_id 获取 Asnordersitem 上架时间为空的数量

     入参:
       v_inp_asnid    : AsnId
       v_inp_compid   : 企业Id

     返回值:
       Number 类型，上架时间为空的数据数量

     版本:
       2022-10-09_ZC314 : 根据 Asn_id 获取 Asnordersitem 上架时间为空的数量

  ==============================================================================*/
  FUNCTION f_get_asnordersitem_receivetime_null_number_by_asnid(v_inp_asnid  IN VARCHAR2,
                                                                v_inp_compid IN VARCHAR2)
    RETURN NUMBER IS
    v_receivetimenullnum NUMBER(8);
  BEGIN
    SELECT COUNT(1)
      INTO v_receivetimenullnum
      FROM scmdata.t_asnordersitem
     WHERE asn_id = v_inp_asnid
       AND company_id = v_inp_compid
       AND receive_time IS NULL;

    RETURN v_receivetimenullnum;
  END f_get_asnordersitem_receivetime_null_number_by_asnid;

  /*=============================================================================

     包：
       pkg_qa_da(QA数据访问包)

     函数名:
       判断 Asn 预回传 Wms 表中是否存在该数据

     入参:
       v_inp_asnid    :  Asn单号
       v_inp_gooid    :  商品档案货号
       v_inp_barcode  :  条码
       v_inp_compid   : 企业Id

     返回值:
       Number 类型，0-不存在，1-存在

     版本:
       2022-10-09_ZC314 : 判断 Asn 预回传 Wms 表中是否存在该数据

  ==============================================================================*/
  FUNCTION f_is_asninfopretranstowms_exists(v_inp_asnid   IN VARCHAR2,
                                            v_inp_gooid   IN VARCHAR2 DEFAULT NULL,
                                            v_inp_barcode IN VARCHAR2 DEFAULT NULL,
                                            v_inp_compid  IN VARCHAR2)
    RETURN NUMBER IS
    v_jugnum NUMBER(1);
  BEGIN
    SELECT nvl(MAX(1), 0)
      INTO v_jugnum
      FROM scmdata.t_qa_pretranstowms
     WHERE asn_id = v_inp_asnid
       AND nvl(goo_id, ' ') = nvl(v_inp_gooid, ' ')
       AND nvl(barcode, ' ') = nvl(v_inp_barcode, ' ')
       AND company_id = v_inp_compid;

    RETURN v_jugnum;
  END f_is_asninfopretranstowms_exists;

  /*=============================================================================

     包：
       pkg_qa_da(QA数据访问包)

     函数名:
       获取 Asn 状态

     入参:
       v_inp_asnid    : Asn_Id
       v_inp_compid   : 企业Id

     返回值:
       Varchar2 类型，Asn状态编码

     版本:
       2022-10-09_ZC314 : 获取 Asn 状态

  ==============================================================================*/
  FUNCTION f_get_asnstatus(v_inp_asnid  IN VARCHAR2,
                           v_inp_compid IN VARCHAR2) RETURN VARCHAR2 IS
    v_status VARCHAR2(8);
  BEGIN
    SELECT MAX(status)
      INTO v_status
      FROM scmdata.t_asnordered
     WHERE asn_id = v_inp_asnid
       AND company_id = v_inp_compid;

    RETURN v_status;
  END f_get_asnstatus;

  /*=============================================================================

     包：
       pkg_qa_da(QA数据访问包)

     函数名:
       判断Qa已检从表中是否存在

     入参:
       v_inp_asnid    : Asn_Id
       v_inp_gooid    : 商品档案货号
       v_inp_barcode  : 条码
       v_inp_compid   : 企业Id

     返回值:
       Number 类型，0-不存在，1-存在

     版本:
       2022-10-09_ZC314 : 判断Qa已检从表中是否存在

  ==============================================================================*/
  FUNCTION f_is_qaqualedlistsla_exists(v_inp_asnid   IN VARCHAR2,
                                       v_inp_gooid   IN VARCHAR2,
                                       v_inp_barcode IN VARCHAR2,
                                       v_inp_compid  IN VARCHAR2)
    RETURN NUMBER IS
    v_jugnum NUMBER(1);
  BEGIN
    SELECT nvl(MAX(1), 0)
      INTO v_jugnum
      FROM scmdata.t_qaqualedlist_sla
     WHERE asn_id = v_inp_asnid
       AND company_id = v_inp_compid
       AND goo_id = v_inp_gooid
       AND nvl(barcode, ' ') = nvl(v_inp_barcode, ' ');

    RETURN v_jugnum;
  END f_is_qaqualedlistsla_exists;

  /*=============================================================================

     包：
       pkg_qa_da(QA数据访问包)

     函数名:
       判断Qa已检主表中是否存在

     入参:
       v_inp_asnid    : Asn_Id
       v_inp_gooid    : 商品档案货号
       v_inp_barcode  : 条码
       v_inp_compid   : 企业Id

     返回值:
       Number 类型，0-不存在，1-存在

     版本:
       2022-10-09_ZC314 : 判断Qa已检主表中是否存在

  ==============================================================================*/
  FUNCTION f_is_qaqualedlistmas_exists(v_inp_asnid  IN VARCHAR2,
                                       v_inp_compid IN VARCHAR2)
    RETURN NUMBER IS
    v_jugnum NUMBER(1);
  BEGIN
    SELECT nvl(MAX(1), 0)
      INTO v_jugnum
      FROM scmdata.t_qaqualedlist_mas
     WHERE asn_id = v_inp_asnid
       AND company_id = v_inp_compid;

    RETURN v_jugnum;
  END f_is_qaqualedlistmas_exists;

  /*=============================================================================

     包：
       pkg_qa_da(QA数据访问包)

     函数名:
       获取 Asn状态是否为已质检/免检

     入参:
       v_inp_asnid    : Asn_Id
       v_inp_compid   : 企业Id

     返回值:
       Number 类型，0-否，1-是

     版本:
       2022-10-11_ZC314 : 获取 Asn状态是否为已质检/免检

  ==============================================================================*/
  FUNCTION f_is_asnstatusaeorfa(v_inp_asnid  IN VARCHAR2,
                                v_inp_compid IN VARCHAR2) RETURN NUMBER IS
    v_jugnum NUMBER(1);
  BEGIN
    SELECT nvl(MAX(1), 0)
      INTO v_jugnum
      FROM scmdata.t_asnordered
     WHERE asn_id = v_inp_asnid
       AND company_id = v_inp_compid
       AND status IN ('FA', 'AE');

    RETURN v_jugnum;
  END f_is_asnstatusaeorfa;

  /*=============================================================================

     包：
       pkg_qa_da(QA数据访问包)

     函数名:
       判断是否多个asn拥有相同的供应商和货号

     入参:
       v_inp_asnids   : 多个Asn_Id，由分号分隔
       v_inp_compid   : 企业Id

     返回值:
       Number 类型，0-否，1-是

     版本:
       2022-10-12_ZC314 : 判断是否多个asn拥有相同的供应商和货号

  ==============================================================================*/
  FUNCTION f_is_multiasnhassamesupplierandgoo(v_inp_asnids IN CLOB,
                                              v_inp_compid IN VARCHAR2)
    RETURN NUMBER IS
    v_jugnum NUMBER(1);
  BEGIN
    SELECT DECODE(COUNT(DISTINCT orded.supplier_code || '-' || asns.goo_id),
                  1,
                  1,
                  0)
      INTO v_jugnum
      FROM scmdata.t_asnordered asned
     INNER JOIN scmdata.t_asnorders asns
        ON asned.asn_id = asns.asn_id
       AND asned.company_id = asns.company_id
      LEFT JOIN scmdata.t_ordered orded
        ON asned.order_id = orded.order_code
       AND asned.company_id = orded.company_id
     WHERE instr(v_inp_asnids, asned.asn_id) > 0
       AND asned.company_id = v_inp_compid;

    RETURN v_jugnum;
  END f_is_multiasnhassamesupplierandgoo;

  /*=============================================================================

     包：
       pkg_qa_da(QA数据访问包)

     函数名:
       获取多个 Asn是否存在 Qa质检报告

     入参:
       v_inp_asnids   : 多个Asn_Id，由分号分隔
       v_inp_compid   : 企业Id

     返回值:
       Number 类型，0-否，1-是

     版本:
       2022-10-12_ZC314 : 获取多个 Asn是否存在 Qa质检报告

  ==============================================================================*/
  FUNCTION f_is_asnshasqareport(v_inp_asnids IN CLOB,
                                v_inp_compid IN VARCHAR2) RETURN NUMBER IS
    v_jugnum NUMBER(1);
  BEGIN
    SELECT NVL(MAX(qa_report_id), 0)
      INTO v_jugnum
      FROM scmdata.t_qa_report qr
     WHERE EXISTS (SELECT 1
              FROM scmdata.t_qa_report_skudim
             WHERE INSTR(v_inp_asnids, asn_id) > 0
               AND company_id = v_inp_compid
               AND qa_report_id = qr.qa_report_id
               AND company_id = qr.company_id);

    RETURN v_jugnum;
  END f_is_asnshasqareport;

  /*=============================================================================

     包：
       pkg_qa_da(QA数据访问包)

     函数名:
       判断 Qa质检报告是否存在 Sku维度表数据

     入参:
       v_inp_qarepid  :  质检报告Id
       v_inp_compid   :  企业Id

     返回值:
       Number 类型，0-否，1-是

     版本:
       2022-10-14_ZC314 : 判断 Qa质检报告是否存在 Sku维度表数据

  ==============================================================================*/
  FUNCTION f_is_qarephasskudimdata(v_inp_qarepid IN VARCHAR2,
                                   v_inp_compid  IN VARCHAR2,
                                   v_inp_asnid   IN VARCHAR2,
                                   v_inp_gooid   IN VARCHAR2,
                                   v_inp_barcode IN VARCHAR2) RETURN NUMBER IS
    v_jugnum NUMBER(1);
  BEGIN
    SELECT NVL(MAX(1), 0)
      INTO v_jugnum
      FROM scmdata.t_qa_report_skudim
     WHERE qa_report_id = v_inp_qarepid
       AND company_id = v_inp_compid
       AND asn_id = v_inp_asnid
       AND goo_id = v_inp_gooid
       AND NVL(barcode, ' ') = NVL(v_inp_barcode, ' ');

    RETURN v_jugnum;
  END f_is_qarephasskudimdata;

  /*=============================================================================

     包：
       pkg_qa_da(QA数据访问包)

     函数名:
       判断 Qa质检报告是否存在数据维度表数据

     入参:
       v_inp_qarepid  :  质检报告Id
       v_inp_compid   :  企业Id

     返回值:
       Number 类型，0-否，1-是

     版本:
       2022-10-14_ZC314 : 判断 Qa质检报告是否存在数据维度表数据

  ==============================================================================*/
  FUNCTION f_is_qarephasnumdimdata(v_inp_qarepid IN VARCHAR2,
                                   v_inp_compid  IN VARCHAR2) RETURN NUMBER IS
    v_jugnum NUMBER(1);
  BEGIN
    SELECT NVL(MAX(1), 0)
      INTO v_jugnum
      FROM scmdata.t_qa_report_numdim
     WHERE qa_report_id = v_inp_qarepid
       AND company_id = v_inp_compid;

    RETURN v_jugnum;
  END f_is_qarephasnumdimdata;

  /*=============================================================================

     包：
       pkg_qa_da(QA数据访问包)

     函数名:
       判断 Qa质检报告是否存在质检细节维度表数据

     入参:
       v_inp_qarepid  :  质检报告Id
       v_inp_compid   :  企业Id

     返回值:
       Number 类型，0-否，1-是

     版本:
       2022-10-14_ZC314 : 判断 Qa质检报告是否存在质检细节维度表数据

  ==============================================================================*/
  FUNCTION f_is_qarephascheckdetaildimdata(v_inp_qarepid IN VARCHAR2,
                                           v_inp_compid  IN VARCHAR2)
    RETURN NUMBER IS
    v_jugnum NUMBER(1);
  BEGIN
    SELECT NVL(MAX(1), 0)
      INTO v_jugnum
      FROM scmdata.t_qa_report_checkdetaildim
     WHERE qa_report_id = v_inp_qarepid
       AND company_id = v_inp_compid;

    RETURN v_jugnum;
  END f_is_qarephascheckdetaildimdata;

  /*=============================================================================

     包：
       pkg_qa_da(QA数据访问包)

     函数名:
       判断 Qa质检报告是否存在关联信息维度数据

     入参:
       v_inp_qarepid  :  质检报告Id
       v_inp_compid   :  企业Id

     返回值:
       Number 类型，0-否，1-是

     版本:
       2022-10-13_ZC314 : 判断 Qa质检报告是否存在关联信息维度数据

  ==============================================================================*/
  FUNCTION f_is_asnshasqareportrelainfodim(v_inp_qarepid IN VARCHAR2,
                                           v_inp_compid  IN VARCHAR2)
    RETURN NUMBER IS
    v_jugnum NUMBER(1);
  BEGIN
    SELECT NVL(MAX(1), 0)
      INTO v_jugnum
      FROM scmdata.t_qa_report_relainfodim
     WHERE qa_report_id = v_inp_qarepid
       AND company_id = v_inp_compid;

    RETURN v_jugnum;
  END f_is_asnshasqareportrelainfodim;

  /*=============================================================================

     包：
       pkg_qa_da(QA数据访问包)

     函数名:
       校验输入人员是否存在于当前企业(需搭配v_inp_userids去重逻辑)

     入参:
       v_inp_userids   :  输入人员Id，多值，用【分号】分隔
       v_inp_compid    :  企业Id

     返回值:
       Number 类型，0-存在输入人员不存在于企业的情况
                    1-所有输入人员都存在于当前企业

     版本:
       2022-10-19_ZC314 : 校验输入人员是否存在于当前企业(需搭配v_inp_userids去重逻辑)

  ==============================================================================*/
  FUNCTION f_is_usersincompany(v_inp_userids IN VARCHAR2,
                               v_inp_compid  IN VARCHAR2) RETURN NUMBER IS
    v_compblognum NUMBER(8);
    v_jugnum      NUMBER(1);
  BEGIN
    SELECT NVL(COUNT(1), 0)
      INTO v_compblognum
      FROM scmdata.sys_company_user
     WHERE INSTR(v_inp_userids, user_id) > 0
       AND company_id = v_inp_compid;

    IF v_compblognum = regexp_count(v_inp_userids || ';', ';') THEN
      v_jugnum := 1;
    ELSE
      v_jugnum := 0;
    END IF;

    RETURN v_jugnum;
  END f_is_usersincompany;

  /*=============================================================================

     包：
       pkg_qa_da(QA数据访问包)

     函数名:
       校验输入人员是否存在被禁用的情况

     入参:
       v_inp_userids   :  输入人员Id，多值，用分隔符分隔
       v_inp_compid    :  企业Id

     返回值:
       Number 类型，0-不存在人员被禁用的情况
                    1-存在人员被禁用的情况

     版本:
       2022-10-19_ZC314 : 校验输入人员是否存在被禁用的情况

  ==============================================================================*/
  FUNCTION f_is_companyuserpaused(v_inp_userids IN VARCHAR2,
                                  v_inp_compid  IN VARCHAR2) RETURN NUMBER IS
    v_jugnum NUMBER(1);
  BEGIN
    SELECT NVL(MAX(1), 0)
      INTO v_jugnum
      FROM scmdata.sys_company_user
     WHERE INSTR(v_inp_userids, user_id) > 0
       AND company_id = v_inp_compid
       AND pause = 1;

    RETURN v_jugnum;
  END f_is_companyuserpaused;

  /*=============================================================================

     包：
       pkg_qa_da(QA数据访问包)

     函数名:
       校验输入人员是否都属于输入企业Qa组

     入参:
       v_inp_userids   :  输入人员Id，多值，用分隔符分隔
       v_inp_compid    :  企业Id

     返回值:
       Number 类型，0-存在人员不属于当前企业Qa组
                    1-所有人员都属于当前企业Qa组

     版本:
       2022-10-19_ZC314 : 校验输入人员是否都属于输入企业Qa组

  ==============================================================================*/
  FUNCTION f_is_userincompanyqadept(v_inp_userids IN VARCHAR2,
                                    v_inp_compid  IN VARCHAR2) RETURN NUMBER IS
    v_userblogcompqagroup NUMBER(8);
    v_jugnum              NUMBER(1);
  BEGIN
    SELECT NVL(COUNT(1), 0)
      INTO v_userblogcompqagroup
      FROM scmdata.sys_company_user_dept compuserdept
     INNER JOIN scmdata.sys_company_dept compdept
        ON compuserdept.company_dept_id = compdept.company_dept_id
       AND compuserdept.company_id = compdept.company_id
     WHERE INSTR(v_inp_userids, compuserdept.user_id) > 0
       AND compdept.dept_name IN ('广州QA组', '义乌QA组')
       AND compuserdept.company_id = v_inp_compid;

    IF v_userblogcompqagroup = regexp_count(v_inp_userids, ';') + 1 THEN
      v_jugnum := 1;
    ELSE
      v_jugnum := 0;
    END IF;

    RETURN v_jugnum;
  END f_is_userincompanyqadept;

  /*=============================================================================

     包：
       pkg_qa_da(QA数据访问包)

     函数名:
       根据Qa质检报告获取预计到仓数量

     入参:
       v_inp_qarepid  :  Qa质检报告Id
       v_inp_compid   :  企业Id

     返回值:
       Number 类型，预计到仓数量

     版本:
       2022-10-19_ZC314 : 根据Qa质检报告获取预计到仓数量

  ==============================================================================*/
  FUNCTION f_get_qareppcomeamount(v_inp_qarepid IN VARCHAR2,
                                  v_inp_compid  IN VARCHAR2) RETURN NUMBER IS
    v_pcomeamount NUMBER(8);
  BEGIN
    SELECT NVL(MAX(pcomesum_amount), 0)
      INTO v_pcomeamount
      FROM scmdata.t_qa_report_numdim
     WHERE qa_report_id = v_inp_qarepid
       AND company_id = v_inp_compid;

    RETURN v_pcomeamount;
  END f_get_qareppcomeamount;

  /*=============================================================================

     包：
       pkg_qa_da(qa数据访问包)

     函数名:
       获取质检报告状态

     入参:
       v_inp_qarepid  :  质检报告Id
       v_inp_compid   :  企业Id

     返回值:
       Varchar2 类型，质检报告状态

     版本:
       2022-10-21_zc314 : 获取质检报告状态

  ==============================================================================*/
  FUNCTION f_get_qarepstatus(v_inp_qarepid IN VARCHAR2,
                             v_inp_compid  IN VARCHAR2) RETURN VARCHAR2 IS
    v_status VARCHAR2(4);
  BEGIN
    --获取质检报告状态
    SELECT MAX(status)
      INTO v_status
      FROM scmdata.t_qa_report
     WHERE qa_report_id = v_inp_qarepid
       AND company_id = v_inp_compid;

    RETURN v_status;
  END f_get_qarepstatus;

  /*=============================================================================

     包：
       pkg_qa_da(qa数据访问包)

     函数名:
       获取质检报告质检结果

     入参:
       v_inp_qarepid  :  质检报告Id
       v_inp_compid   :  企业Id

     返回值:
       Varchar2 类型，质检报告质检结果

     版本:
       2022-10-24_zc314 : 获取质检报告质检结果

  ==============================================================================*/
  FUNCTION f_get_qarepcheckresult(v_inp_qarepid IN VARCHAR2,
                                  v_inp_compid  IN VARCHAR2) RETURN VARCHAR2 IS
    v_checkresult VARCHAR2(8);
  BEGIN
    SELECT MAX(check_result)
      INTO v_checkresult
      FROM scmdata.t_qa_report
     WHERE qa_report_id = v_inp_qarepid
       AND company_id = v_inp_compid;

    RETURN v_checkresult;
  END f_get_qarepcheckresult;

  /*=============================================================================

     包：
       pkg_qa_da(qa数据访问包)

     函数名:
       判断报告下Asn是否没有完成收货上架

     入参:
       v_inp_qarepid  :  质检报告Id
       v_inp_compid   :  企业Id

     返回值:
       Number 类型，0-已完成收货上架
                    1-未完成收货上架

     版本:
       2022-12-01_zc314 : 判断报告下Asn是否没有完成收货上架

  ==============================================================================*/
  FUNCTION f_isrepasnnotreceived(v_inp_qarepid IN VARCHAR2,
                                 v_inp_asnid   IN VARCHAR2,
                                 v_inp_compid  IN VARCHAR2) RETURN VARCHAR2 IS
    v_isrepasnnotreceived NUMBER(1);
  BEGIN
    SELECT NVL(MAX(1), 0)
      INTO v_isrepasnnotreceived
      FROM scmdata.t_qa_report_skudim
     WHERE qa_report_id = v_inp_qarepid
       AND asn_id = v_inp_asnid
       AND company_id = v_inp_compid
       AND receive_time IS NULL;

    RETURN v_isrepasnnotreceived;
  END f_isrepasnnotreceived;

  /*=============================================================================

     包：
       pkg_qa_da(qa数据访问包)

     过程名:
       获取质检报告条件检查字段值

     入参:
       v_inp_qarepid  :  质检报告Id
       v_inp_compid   :  企业Id

     入出参:
       v_iop_checkresult          :  质检结果
       v_iop_problemdescriptions  :  问题描述
       v_iop_reviewcomments       :  审核意见

     版本:
       2022-10-21_zc314 : 获取质检报告条件检查字段值

  ==============================================================================*/
  PROCEDURE p_get_qarepcondcheckfields(v_inp_qarepid             IN VARCHAR2,
                                       v_inp_compid              IN VARCHAR2,
                                       v_iop_checkresult         IN OUT VARCHAR2,
                                       v_iop_problemdescriptions IN OUT VARCHAR2,
                                       v_iop_reviewcomments      IN OUT VARCHAR2) IS
  BEGIN
    --获取质检报告状态
    SELECT MAX(check_result),
           MAX(problem_descriptions),
           MAX(review_comments)
      INTO v_iop_checkresult,
           v_iop_problemdescriptions,
           v_iop_reviewcomments
      FROM scmdata.t_qa_report
     WHERE qa_report_id = v_inp_qarepid
       AND company_id = v_inp_compid;

  END p_get_qarepcondcheckfields;

  /*=============================================================================

     包：
       pkg_qa_da(QA数据访问包)

     函数名:
       通过Sku获取质检报告内质检减数校验数量值

     入参:
       v_inp_qarepid  :  质检报告Id
       v_inp_compid   :  企业Id
       v_inp_asnid    :  Asn单号
       v_inp_gooid    :  商品档案货号
       v_inp_barcode  :  条码

     返回值:
       Number 类型，收货数量/预计到仓数量

     版本:
       2022-10-24_ZC314 : 通过Sku获取质检报告内质检减数校验数量值

  ==============================================================================*/
  FUNCTION f_get_checkamountbysku(v_inp_qarepid IN VARCHAR2,
                                  v_inp_compid  IN VARCHAR2,
                                  v_inp_asnid   IN VARCHAR2,
                                  v_inp_gooid   IN VARCHAR2,
                                  v_inp_barcode IN VARCHAR2) RETURN NUMBER IS
    v_amount NUMBER(8);
  BEGIN
    SELECT CASE
             WHEN receive_time IS NULL THEN
              nvl(pcome_amount, 0)
             ELSE
              nvl(got_amount, 0)
           END
      INTO v_amount
      FROM scmdata.t_qa_report_skudim
     WHERE qa_report_id = v_inp_qarepid
       AND company_id = v_inp_compid
       AND asn_id = v_inp_asnid
       AND goo_id = v_inp_gooid
       AND barcode = v_inp_barcode;

    RETURN v_amount;
  END f_get_checkamountbysku;

  /*=============================================================================

     包：
       pkg_qa_da(QA数据访问包)

     函数名:
       通过质检报告Id，企业Id 获取 Sku唯一质检结果数量

     入参:
       v_inp_qarepid  :  质检报告Id
       v_inp_compid   :  企业Id

     返回值:
       Number 类型: Sku唯一质检结果数量

     版本:
       2022-10-24_ZC314 : 通过质检报告Id，企业Id获取Sku唯一质检结果数量，质检结果最大值
       2022-11-03_ZC314 : 修改为仅获取Sku唯一质检结果数量

  ==============================================================================*/
  FUNCTION f_get_qarepskucheckresultcount(v_inp_qarepid IN VARCHAR2,
                                          v_inp_compid  IN VARCHAR2)
    RETURN NUMBER IS
    v_skucheckresultnum NUMBER(4);
  BEGIN
    SELECT COUNT(DISTINCT skucheck_result)
      INTO v_skucheckresultnum
      FROM scmdata.t_qa_report_skudim
     WHERE qa_report_id = v_inp_qarepid
       AND company_id = v_inp_compid;

    RETURN v_skucheckresultnum;
  END f_get_qarepskucheckresultcount;

  /*=============================================================================

     包：
       pkg_qa_da(QA数据访问包)

     函数名:
       获取质检报告不合格数量

     入参:
       v_inp_qarepid    :  质检报告Id
       v_inp_compid     :  企业Id

     返回值:
       Number 类型: 报告不合格数量

     版本:
       2022-10-25_ZC314 : 获取质检报告不合格数量

  ==============================================================================*/
  FUNCTION f_get_qarepunqualamount(v_inp_qarepid IN VARCHAR2,
                                   v_inp_compid  IN VARCHAR2) RETURN NUMBER IS
    v_retnum NUMBER(8);
  BEGIN
    SELECT SUM(nvl(unqual_amount, 0))
      INTO v_retnum
      FROM scmdata.t_qa_report_skudim
     WHERE qa_report_id = v_inp_qarepid
       AND company_id = v_inp_compid;

    RETURN v_retnum;
  END f_get_qarepunqualamount;

  /*=============================================================================

     包：
       pkg_qa_da(QA数据访问包)

     函数名:
       获取质检报告质检减数

     入参:
       v_inp_qarepid    :  质检报告Id
       v_inp_compid     :  企业Id

     返回值:
       Number 类型: 报告质检减数

     版本:
       2022-10-25_ZC314 : 获取质检报告质检减数

  ==============================================================================*/
  FUNCTION f_get_qarepdecreamount(v_inp_qarepid IN VARCHAR2,
                                  v_inp_compid  IN VARCHAR2) RETURN NUMBER IS
    v_retnum NUMBER(8);
  BEGIN
    SELECT SUM(NVL(qualdecrease_amount, 0))
      INTO v_retnum
      FROM scmdata.t_qa_report_skudim
     WHERE qa_report_id = v_inp_qarepid
       AND company_id = v_inp_compid;

    RETURN v_retnum;
  END f_get_qarepdecreamount;

  /*=============================================================================

     包：
       pkg_qa_da(QA数据访问包)

     函数名:
       判断报告内是否存在Sku未收货

     入参:
       v_inp_qarepid    :  质检报告Id
       v_inp_asnid      :  AsnId
       v_inp_compid     :  企业Id

     返回值:
       Number 类型: 0-已全部收货
                    1-存在Sku未收货

     版本:
       2022-10-26_ZC314 : 判断报告内是否存在Sku未收货

  ==============================================================================*/
  FUNCTION f_is_asnskunotreceived(v_inp_qarepid IN VARCHAR2,
                                  v_inp_asnid   IN VARCHAR2,
                                  v_inp_compid  IN VARCHAR2) RETURN NUMBER IS
    v_retnum NUMBER(1);
  BEGIN
    SELECT NVL(MAX(1), 0)
      INTO v_retnum
      FROM scmdata.t_qa_report_skudim
     WHERE qa_report_id = v_inp_qarepid
       AND asn_id = v_inp_asnid
       AND company_id = v_inp_compid
       AND receive_time IS NULL;

    RETURN v_retnum;
  END f_is_asnskunotreceived;

  /*=============================================================================

    包：
      pkg_qa_ld(qa逻辑细节包)

    函数名:
      校验 Asn/Asn sku接口数据是否已经同步正确

    入参:
      v_inp_asnid    :  asn单号
      v_inp_compid   :  企业id
      v_inp_barcode  :  条码

    返回值:
      number 类型: 0-Asn/Asn sku接口数据存在部分不成功
                   1-Asn/Asn sku接口数据已同步成功

    版本:
      2022-11-21_zc314 : 校验 Asn/Asn sku接口数据是否已经同步正确

  ==============================================================================*/
  FUNCTION f_is_asnitfsynccorrectly(v_inp_asnid   IN VARCHAR2,
                                    v_inp_compid  IN VARCHAR2,
                                    v_inp_barcode IN VARCHAR2 DEFAULT NULL)
    RETURN NUMBER IS
    v_relagooid  VARCHAR2(32);
    v_edjugnum   NUMBER(1);
    v_sjugnum    NUMBER(1);
    v_itemjugnum NUMBER(1);
    v_retnum     NUMBER(1);
  BEGIN
    --获取货号
    SELECT MAX(goo_id)
      INTO v_relagooid
      FROM scmdata.t_asnorders_itf
     WHERE asn_id = v_inp_asnid
       AND company_id = v_inp_compid;

    --Asnordered_itf 是否存在未正常同步数据
    SELECT nvl(MAX(1), 0)
      INTO v_edjugnum
      FROM scmdata.t_asnordered_itf
     WHERE asn_id = v_inp_asnid
       AND company_id = v_inp_compid
       AND port_status NOT IN ('SS', 'US');

    --传入 v_inp_barcode（条码）不为空
    IF v_inp_barcode IS NOT NULL THEN
      --Asnorders_itf 是否存在未正常同步数据
      SELECT nvl(MAX(1), 0)
        INTO v_sjugnum
        FROM scmdata.t_asnorders_itf
       WHERE asn_id = v_inp_asnid
         AND goo_id = v_relagooid
         AND company_id = v_inp_compid
         AND port_status NOT IN ('SS', 'US');

      --Asnordersitem_itf 是否存在未正常同步数据
      SELECT nvl(MAX(1), 0)
        INTO v_itemjugnum
        FROM scmdata.t_asnordersitem_itf
       WHERE asn_id = v_inp_asnid
         AND goo_id = v_relagooid
         AND NVL(barcode, ' ') = NVL(v_inp_barcode, ' ')
         AND company_id = v_inp_compid
         AND port_status NOT IN ('SS', 'US');
    ELSE
      --Asnorders_itf 是否存在未正常同步数据
      SELECT nvl(MAX(1), 0)
        INTO v_sjugnum
        FROM scmdata.t_asnorders_itf
       WHERE asn_id = v_inp_asnid
         AND goo_id = v_relagooid
         AND company_id = v_inp_compid
         AND port_status NOT IN ('SS', 'US');
    END IF;

    --返回值赋值
    IF v_inp_barcode IS NOT NULL THEN
      v_retnum := sign(v_edjugnum + v_sjugnum + v_itemjugnum);
    ELSE
      v_retnum := sign(v_edjugnum + v_sjugnum);
    END IF;

    --意义反转
    IF v_retnum = 0 THEN
      v_retnum := 1;
    ELSE
      v_retnum := 0;
    END IF;

    RETURN v_retnum;
  END f_is_asnitfsynccorrectly;

  /*=================================================================================

    包：
      pkg_qa_da(qa数据访问包)

    过程名:
      判断 Asn箱号接入是否完整

    入参:
      v_inp_asnid   :  Asn单号
      v_inp_compid  :  企业Id

    返回值:
      Number 类型， 0-Asn箱号接入不完整
                    1-Asn箱号接入完整

     版本:
       2023-01-18: 判断 Asn箱号接入是否完整

  =================================================================================*/
  FUNCTION f_is_asnpackinfo_complete(v_inp_asnid  IN VARCHAR2,
                                     v_inp_compid IN VARCHAR2) RETURN NUMBER IS
    v_isasnpacksexists NUMBER(1);
    v_jugnum           NUMBER(1);
    v_asnpackamount    NUMBER(8);
    v_pcomeamount      NUMBER(8);
  BEGIN
    SELECT NVL(MAX(1), 0)
      INTO v_isasnpacksexists
      FROM scmdata.t_asnorderpacks
     WHERE asn_id = v_inp_asnid
       AND company_id = v_inp_compid
       AND ROWNUM = 1;

    IF v_isasnpacksexists = 0 THEN
      v_jugnum := 0;
    ELSE
      SELECT NVL(SUM(PACKAMOUNT), 0)
        INTO v_asnpackamount
        FROM scmdata.t_asnorderpacks
       WHERE asn_id = v_inp_asnid
         AND company_id = v_inp_compid;

      SELECT NVL(SUM(asnitem.pcome_amount), NVL(SUM(asns.pcome_amount), 0))
        INTO v_pcomeamount
        FROM scmdata.t_asnorders asns
        LEFT JOIN scmdata.t_asnordersitem asnitem
          ON asns.asn_id = asnitem.asn_id
         AND asns.company_id = asnitem.company_id
       WHERE asns.asn_id = v_inp_asnid
         AND asns.company_id = v_inp_compid;

      IF v_asnpackamount = v_pcomeamount THEN
        v_jugnum := 1;
      ELSE
        v_jugnum := 0;
      END IF;
    END IF;

    RETURN v_jugnum;
  END f_is_asnpackinfo_complete;

  /*=================================================================================

    包：
      pkg_qa_da(qa数据访问包)

    过程名:
      获取预回传表状态，错误信息

    入参:
      v_inp_asnid    :  Asn单号
      v_inp_compid   :  企业Id
      v_inp_gooid    :  货号
      v_inp_barcode  :  条码

    入出参:
      v_inp_status   :  预回传表状态
      v_inp_errinfo  :  预回传表错误信息

     版本:
       2022-11-21: 获取预回传表状态，错误信息

  =================================================================================*/
  PROCEDURE p_get_pretransstatusanderrinfo(v_inp_asnid   IN VARCHAR2,
                                           v_inp_compid  IN VARCHAR2,
                                           v_inp_gooid   IN VARCHAR2 DEFAULT NULL,
                                           v_inp_barcode IN VARCHAR2 DEFAULT NULL,
                                           v_inp_status  IN OUT VARCHAR2,
                                           v_inp_errinfo IN OUT CLOB) IS
    v_jugnum NUMBER(1);
  BEGIN
    --Asn/Asn sku接口数据是否已经同步正确
    v_jugnum := f_is_asnitfsynccorrectly(v_inp_asnid   => v_inp_asnid,
                                         v_inp_compid  => v_inp_compid,
                                         v_inp_barcode => v_inp_barcode);

    --判断接口数据是否同步正确
    IF v_jugnum = 0 THEN
      --不正确，状态赋值
      v_inp_status  := 'CE';
      v_inp_errinfo := scmdata.f_sentence_append_rc(v_sentence   => v_inp_errinfo,
                                                    v_appendstr  => 'Asn/Asn sku接口数据存在部分不成功',
                                                    v_middliestr => chr(10));
    ELSE
      --校验是否完成收货
      IF v_inp_barcode IS NOT NULL THEN
        SELECT NVL(MAX(1), 0)
          INTO v_jugnum
          FROM scmdata.t_qa_report_skudim
         WHERE asn_id = v_inp_asnid
           AND goo_id = v_inp_gooid
           AND NVL(barcode, ' ') = NVL(v_inp_barcode, ' ')
           AND company_id = v_inp_compid
           AND receive_time IS NULL;
      ELSE
        SELECT NVL(MAX(1), 0)
          INTO v_jugnum
          FROM scmdata.t_qa_report_skudim
         WHERE asn_id = v_inp_asnid
           AND company_id = v_inp_compid
           AND receive_time IS NULL;
      END IF;

      --状态，错误信息赋值
      IF v_jugnum = 0 THEN
        v_inp_status := 'PT';
      ELSE
        v_inp_status  := 'CE';
        v_inp_errinfo := scmdata.f_sentence_append_rc(v_sentence   => v_inp_errinfo,
                                                      v_appendstr  => 'Asn/Asn sku未完成收货',
                                                      v_middliestr => chr(10));
      END IF;

      --判断 Asnorderpacks是否同步完整
      v_jugnum := f_is_asnpackinfo_complete(v_inp_asnid  => v_inp_asnid,
                                            v_inp_compid => v_inp_compid);

      IF v_jugnum = 0 THEN
        v_inp_status  := 'CE';
        v_inp_errinfo := scmdata.f_sentence_append_rc(v_sentence   => v_inp_errinfo,
                                                      v_appendstr  => 'Asnorderpacks未能同步完整',
                                                      v_middliestr => chr(10));
      END IF;
    END IF;
  END p_get_pretransstatusanderrinfo;

  /*=============================================================================

     包：
       pkg_qa_da(QA数据访问包)

     函数名:
       获取质检报告处理类型

     入参:
       v_inp_qarepid    :  质检报告Id
       v_inp_compid     :  企业Id

     返回值:
       Varchar2 类型: 报告处理类型

     版本:
       2022-10-26_ZC314 : 获取质检报告处理类型

  ==============================================================================*/
  FUNCTION f_get_qarepprocessingtype(v_inp_qarepid IN VARCHAR2,
                                     v_inp_compid  IN VARCHAR2)
    RETURN VARCHAR2 IS
    v_processingtype VARCHAR2(8);
  BEGIN
    SELECT MAX(processing_type)
      INTO v_processingtype
      FROM scmdata.t_qa_report
     WHERE qa_report_id = v_inp_qarepid
       AND company_id = v_inp_compid;

    RETURN v_processingtype;
  END f_get_qarepprocessingtype;

  /*=============================================================================

     包：
       pkg_qa_da(QA数据访问包)

     函数名:
       判断报告内是否存在 Sku未完成质检

     入参:
       v_inp_qarepid  :  质检报告Id
       v_inp_asnid    :  Asn单号
       v_inp_compid   :  企业Id

     返回值:
       Number 类型: 0-已全部完成质检
                    1-存在Sku未完成质检

     版本:
       2022-10-28_ZC314 : 判断报告内是否存在 Sku未完成质检

  ==============================================================================*/
  FUNCTION f_is_anyqarepskunotaf(v_inp_qarepid IN VARCHAR2,
                                 v_inp_compid  IN VARCHAR2) RETURN NUMBER IS
    v_jugnum NUMBER(1);
  BEGIN
    SELECT NVL(MAX(1), 0)
      INTO v_jugnum
      FROM scmdata.t_qa_report_skudim
     WHERE qa_report_id = v_inp_qarepid
       AND company_id = v_inp_compid
       AND status <> 'AF';

    RETURN v_jugnum;
  END f_is_anyqarepskunotaf;

  /*=============================================================================

     包：
       pkg_qa_da(QA数据访问包)

     函数名:
       判断报告内是否存在某 Asn下 Sku未完成质检

     入参:
       v_inp_qarepid  :  质检报告Id
       v_inp_asnid    :  Asn单号
       v_inp_compid   :  企业Id

     返回值:
       Number 类型: 0-已全部完成质检
                    1-存在Sku未完成质检

     版本:
       2022-10-28_ZC314 : 判断报告内是否存在某 Asn下 Sku未完成质检

  ==============================================================================*/
  FUNCTION f_is_anyqarepasnskunotaf(v_inp_qarepid IN VARCHAR2,
                                    v_inp_asnid   IN VARCHAR2,
                                    v_inp_compid  IN VARCHAR2) RETURN NUMBER IS
    v_jugnum NUMBER(1);
  BEGIN
    SELECT NVL(MAX(1), 0)
      INTO v_jugnum
      FROM scmdata.t_qa_report_skudim
     WHERE qa_report_id = v_inp_qarepid
       AND asn_id = v_inp_asnid
       AND company_id = v_inp_compid
       AND status <> 'AF';

    RETURN v_jugnum;
  END f_is_anyqarepasnskunotaf;

  /*=============================================================================

     包：
       pkg_qa_da(QA数据访问包)

     函数名:
       判断报告Sku是否重复维护不合格处理

     入参:
       v_inp_qarepid    :  质检报告Id
       v_inp_compid     :  企业Id
       v_inp_asnid      :  Asn单号
       v_inp_gooid      :  商品档案货号
       v_inp_barcode    :  条码

     返回值:
       Number 类型: 0-Sku未重复维护不合格处理
                    1-Sku重复维护不合格处理

     版本:
       2022-10-27_ZC314 : 判断报告Sku是否重复维护不合格处理

  ==============================================================================*/
  FUNCTION f_is_qareprepeatsetprocessresult(v_inp_qarepid IN VARCHAR2,
                                            v_inp_compid  IN VARCHAR2,
                                            v_inp_asnid   IN VARCHAR2,
                                            v_inp_gooid   IN VARCHAR2,
                                            v_inp_barcode IN VARCHAR2)
    RETURN NUMBER IS
    v_jugnum NUMBER(1);
  BEGIN
    SELECT NVL(MAX(1), 0)
      INTO v_jugnum
      FROM scmdata.t_qa_report_skudim
     WHERE qa_report_id = v_inp_qarepid
       AND company_id = v_inp_compid
       AND asn_id = v_inp_asnid
       AND goo_id = v_inp_gooid
       AND NVL(barcode, ' ') = NVL(v_inp_barcode, ' ')
       AND skuprocessing_result IS NOT NULL;

    RETURN v_jugnum;
  END f_is_qareprepeatsetprocessresult;

  /*=============================================================================

     包：
       pkg_qa_da(QA数据访问包)

     函数名:
       校验传入数据是否存在【待返工Sku个数】等于0

     入参:
       v_inp_qarepids :  质检报告Id，多值，用分号分隔
       v_inp_compid   :  企业Id

     返回值:
       Number 类型: 0-已全部完成质检
                    1-存在Sku未完成质检

     版本:
       2022-10-28_ZC314 : 校验传入数据是否存在【待返工Sku个数】等于0

  ==============================================================================*/
  FUNCTION f_is_anyqarepprereworkskunumequalzero(v_inp_qarepids IN VARCHAR2,
                                                 v_inp_compid   IN VARCHAR2)
    RETURN NUMBER IS
    v_jugnum NUMBER(1);
  BEGIN
    SELECT NVL(MAX(1), 0)
      INTO v_jugnum
      FROM scmdata.t_qa_report_numdim
     WHERE INSTR(v_inp_qarepids, qa_report_id) > 0
       AND company_id = v_inp_compid
       AND prereprocessingsum_amount = 0;

    RETURN v_jugnum;
  END f_is_anyqarepprereworkskunumequalzero;

  /*=============================================================================

     包：
       pkg_qa_da(QA数据访问包)

     函数名:
       校验传入数据是否存在【供应商】+【货号】不唯一

     入参:
       v_inp_qarepids :  质检报告Id，多值，用分号分隔
       v_inp_compid   :  企业Id

     返回值:
       Number 类型: 0-传入数据【供应商】+【货号】唯一
                    1-传入数据【供应商】+【货号】不唯一

     版本:
       2022-10-28_ZC314 : 校验传入数据是否存在【供应商】+【货号】不唯一

  ==============================================================================*/
  FUNCTION f_is_qarepssupplierandgoonotsame(v_inp_qarepids IN VARCHAR2,
                                            v_inp_compid   IN VARCHAR2)
    RETURN NUMBER IS
    v_jugnum NUMBER(1);
  BEGIN
    SELECT MAX(jug)
      INTO v_jugnum
      FROM (SELECT sign(COUNT(DISTINCT supplier_code || '-' || goo_id) - 1) jug
              FROM scmdata.t_qa_report_relainfodim
             WHERE instr(v_inp_qarepids, qa_report_id) > 0
               AND company_id = v_inp_compid);

    RETURN v_jugnum;
  END f_is_qarepssupplierandgoonotsame;

  /*=============================================================================

     包：
       pkg_qa_da(QA数据访问包)

     过程名:
       获取报告待返工 Sku数量，质检减数总数，不合格总数

     入参:
       v_inp_qarepid      : 质检报告Id
       v_inp_compid       : 企业Id

     入出参:
       v_iop_preprocessamount  :  待返工Sku数量
       v_iop_decreaseamount    :  质检减数总和
       v_iop_unqualsumamount   :  质检不合格数量总和

     版本:
       2022-10-31_ZC314 : 获取报告待返工 Sku数量，质检减数总数，不合格总数

  ==============================================================================*/
  PROCEDURE p_get_qareppreamountrela(v_inp_qarepid          IN VARCHAR2,
                                     v_inp_compid           IN VARCHAR2,
                                     v_iop_preprocessamount IN OUT NUMBER,
                                     v_iop_decreaseamount   IN OUT NUMBER,
                                     v_iop_unqualsumamount  IN OUT NUMBER) IS

  BEGIN
    SELECT COUNT(1)
      INTO v_iop_preprocessamount
      FROM scmdata.t_qa_report_skudim
     WHERE qa_report_id = v_inp_qarepid
       AND company_id = v_inp_compid
       AND skuprocessing_result = 'AWR';

    SELECT SUM(NVL(qualdecrease_amount, 0))
      INTO v_iop_decreaseamount
      FROM scmdata.t_qa_report_skudim
     WHERE qa_report_id = v_inp_qarepid
       AND company_id = v_inp_compid;

    SELECT SUM(NVL(unqual_amount, 0))
      INTO v_iop_unqualsumamount
      FROM scmdata.t_qa_report_skudim
     WHERE qa_report_id = v_inp_qarepid
       AND company_id = v_inp_compid;

  END p_get_qareppreamountrela;

  /*=============================================================================

     包：
       pkg_qa_da(QA数据访问包)

     过程名:
       获取报告Sku状态

     入参:
       v_inp_qarepid  :  质检报告Id
       v_inp_compid   :  企业Id
       v_inp_asnid    :  asn单号
       v_inp_gooid    :  商品档案货号
       v_inp_barcode  :  条码

     版本:
       2022-10-31_ZC314 : 获取报告Sku状态

  ==============================================================================*/
  FUNCTION f_get_qarepskustatus(v_inp_qarepid IN VARCHAR2,
                                v_inp_compid  IN VARCHAR2,
                                v_inp_asnid   IN VARCHAR2,
                                v_inp_gooid   IN VARCHAR2,
                                v_inp_barcode IN VARCHAR2) RETURN VARCHAR2 IS
    v_status VARCHAR2(8);
  BEGIN
    SELECT MAX(status)
      INTO v_status
      FROM scmdata.t_qa_report_skudim
     WHERE qa_report_id = v_inp_qarepid
       AND company_id = v_inp_compid
       AND asn_id = v_inp_asnid
       AND goo_id = v_inp_gooid
       AND NVL(barcode, ' ') = NVL(v_inp_barcode, ' ');

    RETURN v_status;
  END f_get_qarepskustatus;

  /*=============================================================================

     包：
       pkg_qa_da(QA数据访问包)

     函数名:
       获取质检报告-质检类型

     入参:
       v_inp_qarepid  :  质检报告Id
       v_inp_compid   :  企业Id

     返回值:
       Varchar2 类型，质检类型

     版本:
       2022-11-01_ZC314 : 获取质检报告-质检类型

  ==============================================================================*/
  FUNCTION f_get_qarepchecktype(v_inp_qarepid IN VARCHAR2,
                                v_inp_compid  IN VARCHAR2) RETURN VARCHAR2 IS
    v_checktype VARCHAR2(8);
  BEGIN
    SELECT MAX(check_type)
      INTO v_checktype
      FROM scmdata.t_qa_report
     WHERE qa_report_id = v_inp_qarepid
       AND company_id = v_inp_compid;

    RETURN v_checktype;
  END f_get_qarepchecktype;

  /*=============================================================================

     包：
       pkg_qa_da(QA数据访问包)

     函数名:
       获取 Sku最新的质检报告Id

     入参:
       v_inp_asnid    :  Asn单号
       v_inp_gooid    :  商品档案货号
       v_inp_barcode  :  条码
       v_inp_qarepid  :  质检报告Id
       v_inp_compid   :  企业Id

     返回值:
       Varchar2 类型，质检报告Id

     版本:
       2022-11-01_ZC314 : 获取 Sku最新的质检报告Id

  ==============================================================================*/
  FUNCTION f_get_skulastestqarepid(v_inp_asnid   IN VARCHAR2,
                                   v_inp_gooid   IN VARCHAR2,
                                   v_inp_barcode IN VARCHAR2,
                                   v_inp_qarepid IN VARCHAR2,
                                   v_inp_compid  IN VARCHAR2) RETURN VARCHAR2 IS
    v_qarepid VARCHAR2(32);
  BEGIN
    SELECT MAX(qa_report_id)
      INTO v_qarepid
      FROM (SELECT first_value(repsku.qa_report_id) OVER(PARTITION BY repsku.asn_id, repsku.goo_id, repsku.barcode, repsku.company_id ORDER BY NVL(repsku.qualfinish_time, rep.create_time)) qa_report_id
              FROM scmdata.t_qa_report_skudim repsku
             INNER JOIN scmdata.t_qa_report rep
                ON repsku.qa_report_id = rep.qa_report_id
               AND repsku.company_id = rep.company_id
             WHERE repsku.asn_id = v_inp_asnid
               AND repsku.goo_id = v_inp_gooid
               AND NVL(repsku.barcode, ' ') = NVL(v_inp_barcode, ' ')
               AND repsku.qa_report_id <> v_inp_qarepid
               AND repsku.company_id = v_inp_compid);

    RETURN v_qarepid;
  END f_get_skulastestqarepid;

  /*=============================================================================

     包：
       pkg_qa_da(QA数据访问包)

     函数名:
       获取汇总 Qa质检报告 Sku处理结果

     入参:
       v_inp_qarepid    :  质检报告Id
       v_inp_compid     :  企业Id

     出参:
       Varchar2 类型，处理结果

     版本:
       2022-10-11_zc314 : 获取汇总 Qa质检报告 Sku处理结果

  ==============================================================================*/
  FUNCTION f_get_qarepprocessresultbysku(v_inp_qarepid IN VARCHAR2,
                                         v_inp_compid  IN VARCHAR2)
    RETURN VARCHAR2 IS
    v_processresult VARCHAR2(128);
  BEGIN
    SELECT listagg(DISTINCT skuprocessing_result, ';')
      INTO v_processresult
      FROM scmdata.t_qa_report_skudim
     WHERE qa_report_id = v_inp_qarepid
       AND company_id = v_inp_compid;

    RETURN v_processresult;
  END f_get_qarepprocessresultbysku;

  /*=============================================================================

     包：
       pkg_qa_da(QA数据访问包)

     函数名:
       获取质检报告仓库

     入参:
       v_inp_qarepid  :  质检报告Id
       v_inp_compid   :  企业Id

     出参:
       Varchar2 类型，仓库

     版本:
       2022-10-11_zc314 : 获取质检报告仓库

  ==============================================================================*/
  FUNCTION f_get_shoid(v_inp_qarepid IN VARCHAR2, v_inp_compid IN VARCHAR2)
    RETURN VARCHAR2 IS
    v_shoid VARCHAR2(8);
  BEGIN
    SELECT MAX(sho_id)
      INTO v_shoid
      FROM scmdata.t_qa_report_relainfodim
     WHERE qa_report_id = v_inp_qarepid
       AND company_id = v_inp_compid;

    RETURN v_shoid;
  END f_get_shoid;

  /*=============================================================================

     包：
       pkg_qa_ld(qa逻辑细节包)

     过程名:
       Qa消息配置表是否存在数据

     入参:
       v_inp_configcode  :  qa消息配置编码
       v_inp_compid      :  企业Id

     返回值:
       Number 类型，0-不存在于Qa消息配置表
                    1-存在于Qa消息配置表

     版本:
       2022-12-08_zc314 : Qa消息表是否存在数据

  ==============================================================================*/
  FUNCTION f_is_qamsgconfigexists(v_inp_configcode IN VARCHAR2,
                                  v_inp_compid     IN VARCHAR2) RETURN NUMBER IS
    v_jugnum NUMBER(1);
  BEGIN
    SELECT NVL(MAX(1), 0)
      INTO v_jugnum
      FROM scmdata.t_qa_msgconfig
     WHERE config_code = v_inp_configcode
       AND company_id = v_inp_compid;

    RETURN v_jugnum;
  END f_is_qamsgconfigexists;

  /*=============================================================================

     包：
       pkg_qa_ld(qa逻辑细节包)

     过程名:
       Qa消息表是否存在数据

     入参:
       v_inp_configcode  :  qa消息配置编码
       v_inp_unqinfo     :  唯一信息
       v_inp_compid      :  企业Id

     返回值:
       Number 类型，0-不存在于Qa消息表
                    1-存在于Qa消息表

     版本:
       2022-12-08_zc314 : Qa消息表是否存在数据

  ==============================================================================*/
  FUNCTION f_is_qamsginfoexists(v_inp_configcode IN VARCHAR2,
                                v_inp_unqinfo    IN VARCHAR2,
                                v_inp_compid     IN VARCHAR2) RETURN NUMBER IS
    v_jugnum NUMBER(1);
  BEGIN
    SELECT NVL(MAX(1), 0)
      INTO v_jugnum
      FROM scmdata.t_qa_msginfo
     WHERE config_code = v_inp_configcode
       AND unq_info = v_inp_unqinfo
       AND company_id = v_inp_compid;

    RETURN v_jugnum;
  END f_is_qamsginfoexists;

  /*=============================================================================

     包：
       pkg_qa_da(QA数据访问包)

     函数名:
       获取特定执行参数的触发状态

     入参:
       v_executeparam  :  执行参数

     出参:
       Number 类型，0-停止
                    1-运行

     版本:
       2022-12-09_zc314 : 获取特定执行参数的触发状态

  ==============================================================================*/
  FUNCTION f_get_xxltriggerstatus(v_executeparam IN VARCHAR2) RETURN NUMBER IS
    v_triggerstatus NUMBER(1);
  BEGIN
    SELECT MAX(trigger_status)
      INTO v_triggerstatus
      FROM bw3.xxl_job_info
     WHERE executor_param = v_executeparam;

    RETURN v_triggerstatus;
  END f_get_xxltriggerstatus;

  /*=============================================================================

     包：
       pkg_qa_da(QA数据访问包)

     函数名:
       获取质检报告仓库，分类

     入参:
       v_inp_qarepid  :  质检报告Id
       v_inp_compid   :  企业Id

     入出参:
       v_iop_shoids  :  仓库Id，多值，用分号分隔
       v_iop_cates   :  分类Id，多值，用分号分隔

     版本:
       2022-12-12_zc314 : 获取质检报告仓库

  ==============================================================================*/
  PROCEDURE p_get_multishoandcatebyqarep(v_inp_qarepid IN VARCHAR2,
                                         v_inp_compid  IN VARCHAR2,
                                         v_iop_shoids  IN OUT VARCHAR2,
                                         v_iop_cates   IN OUT VARCHAR2) IS

  BEGIN
    SELECT listagg(DISTINCT sho_id, ';'), listagg(DISTINCT category, ';')
      INTO v_iop_shoids, v_iop_cates
      FROM scmdata.t_qa_report_relainfodim repsku
     INNER JOIN scmdata.t_commodity_info goo
        ON repsku.goo_id = goo.goo_id
       AND repsku.company_id = goo.company_id
     WHERE repsku.qa_report_id = v_inp_qarepid
       AND repsku.company_id = v_inp_compid;
  END p_get_multishoandcatebyqarep;

  /*=============================================================================

     包：
       pkg_qa_da(QA数据访问包)

     函数名:
       获取质检报告唯一传输结果数量，传输结果最大值

     入参:
       v_inp_qarepid  :  质检报告Id
       v_inp_compid   :  企业Id

     入出参:
       v_iop_trnum  :  唯一传输结果数量
       v_iop_maxtr  :  传输结果最大值

     版本:
       2022-12-12_zc314 : 获取质检报告仓库

  ==============================================================================*/
  PROCEDURE p_get_qualedtrnumandmaxtr(v_inp_qarepid IN VARCHAR2,
                                      v_inp_compid  IN VARCHAR2,
                                      v_iop_trnum   IN OUT NUMBER,
                                      v_iop_maxtr   IN OUT VARCHAR2) IS

  BEGIN
    SELECT COUNT(DISTINCT trans_result), MAX(trans_result)
      INTO v_iop_trnum, v_iop_maxtr
      FROM scmdata.t_qa_report_skudim
     WHERE qa_report_id = v_inp_qarepid
       AND company_id = v_inp_compid;
  END p_get_qualedtrnumandmaxtr;

  /*=============================================================================

     包：
       pkg_qa_da(QA数据访问包)

     函数名:
       判断是否存在批退数据

     入参:
       v_inp_qarepid  :  质检报告Id
       v_inp_compid   :  企业Id

     返回值:
       Number 类型，0-不存在批退数据
                    1-存在批退数据

     版本:
       2022-12-13_zc314 : 判断是否存在批退数据

  ==============================================================================*/
  FUNCTION f_has_nptransresult(v_inp_qarepid IN VARCHAR2,
                               v_inp_compid  IN VARCHAR2) RETURN NUMBER IS
    v_jugnum NUMBER(1);
  BEGIN
    SELECT NVL(MAX(1), 0)
      INTO v_jugnum
      FROM scmdata.t_qa_report_skudim
     WHERE qa_report_id = v_inp_qarepid
       AND company_id = v_inp_compid
       AND trans_result = 'NP'
       AND ROWNUM = 1;

    RETURN v_jugnum;
  END f_has_nptransresult;

  /*=============================================================================

     包：
       pkg_qa_da(QA数据访问包)

     函数名:
       判断是否存在Sku质检不合格数据

     入参:
       v_inp_qarepid  :  质检报告Id
       v_inp_compid   :  企业Id

     返回值:
       Number 类型，0-不存在Sku质检不合格数据
                    1-存在Sku质检不合格数据

     版本:
       2022-12-13_zc314 : 判断是否存在Sku质检不合格数据

  ==============================================================================*/
  FUNCTION f_has_npskucheckresult(v_inp_qarepid IN VARCHAR2,
                                  v_inp_compid  IN VARCHAR2) RETURN NUMBER IS
    v_jugnum NUMBER(1);
  BEGIN
    SELECT NVL(MAX(1), 0)
      INTO v_jugnum
      FROM scmdata.t_qa_report_skudim
     WHERE qa_report_id = v_inp_qarepid
       AND company_id = v_inp_compid
       AND skucheck_result = 'NP'
       AND ROWNUM = 1;

    RETURN v_jugnum;
  END f_has_npskucheckresult;

  /*=============================================================================

     包：
       pkg_qa_da(qa数据访问包)

     函数名:
       判断是否存在于Qa尺寸核对表

     入参:
       v_inp_qarepid   :  Qa质检报告Id
       v_inp_position  :  部位
       v_inp_compid    :  企业Id
       v_inp_gooid     :  商品档案货号
       v_inp_barcode   :  条码
       v_inp_seqno     :  序号

     返回值:
       Number 类型，0-不存在于Qa尺寸核对表
                    1-存在于Qa尺寸核对表

     版本:
       2022-12-14_zc314 : 判断是否存在于Qa尺寸核对表
       2022-12-15_zc314 : 维度调整，增加尺寸表Id维度
       2023-01-04_zc314 : 维度调整，尺寸表Id修改为部位

  ==============================================================================*/
  FUNCTION f_is_qasizecheckchartexists(v_inp_qarepid  IN VARCHAR2,
                                       v_inp_position IN VARCHAR2,
                                       v_inp_compid   IN VARCHAR2,
                                       v_inp_gooid    IN VARCHAR2,
                                       v_inp_barcode  IN VARCHAR2,
                                       v_inp_seqno    IN NUMBER)
    RETURN NUMBER IS
    v_jugnum NUMBER(1);
  BEGIN
    SELECT NVL(MAX(1), 0)
      INTO v_jugnum
      FROM scmdata.t_qa_sizecheckchart
     WHERE qa_report_id = v_inp_qarepid
       AND position = v_inp_position
       AND company_id = v_inp_compid
       AND goo_id = v_inp_gooid
       AND barcode = v_inp_barcode
       AND seq_no = v_inp_seqno
       AND ROWNUM = 1;

    RETURN v_jugnum;
  END f_is_qasizecheckchartexists;

  /*=============================================================================

     包：
       pkg_qa_da(qa数据访问包)

     函数名:
       判断商品是否存在尺寸表

     入参:
       v_inp_gooid        :  商品档案货号
       v_inp_compid       :  企业Id

     返回值:
       Number 类型，0-商品不存在尺寸表
                    1-商品存在尺寸表

     版本:
       2022-12-15_zc314 : 判断商品是否存在尺寸表

  ==============================================================================*/
  FUNCTION f_is_goosizechartexists(v_inp_gooid  IN VARCHAR2,
                                   v_inp_compid IN VARCHAR2) RETURN NUMBER IS
    v_jugnum NUMBER(1);
  BEGIN
    SELECT NVL(MAX(1), 0)
      INTO v_jugnum
      FROM scmdata.t_size_chart
     WHERE goo_id = v_inp_gooid
       AND company_id = v_inp_compid
       AND ROWNUM = 1;

    RETURN v_jugnum;
  END f_is_goosizechartexists;

  /*=============================================================================

     包：
       pkg_qa_da(qa数据访问包)

     过程名:
       根据质检报告获取度尺件数

     入参:
       v_inp_qarepid    :  质检报告Id
       v_inp_compid     :  企业Id

     返回值:
       Number 类型，质检报告度尺件数

     版本:
       2022-12-15_zc314 : 根据质检报告获取度尺件数

  ==============================================================================*/
  FUNCTION f_get_scaleamountqarep(v_inp_qarepid IN VARCHAR2,
                                  v_inp_compid  IN VARCHAR2) RETURN NUMBER IS
    v_scaleamount NUMBER(8);
  BEGIN
    SELECT MAX(scale_amount)
      INTO v_scaleamount
      FROM scmdata.t_qa_report_checkdetaildim
     WHERE qa_report_id = v_inp_qarepid
       AND company_id = v_inp_compid;

    RETURN v_scaleamount;
  END f_get_scaleamountqarep;

  /*=============================================================================

     包：
       pkg_qa_da(qa数据访问包)

     函数名:
       判断当前报告Sku是否存在下一件尺寸核对数据

     入参:
       v_inp_qarepid    :  质检报告Id
       v_inp_gooid      :  商品档案货号
       v_inp_barcode    :  条码
       v_inp_nextseq    :  下一件序号
       v_inp_compid     :  企业Id

     返回值:
       Number 类型，0-不存在下一件尺寸核对数据
                    1-存在下一件尺寸核对数据

     版本:
       2022-12-15_zc314 : 判断当前报告Sku是否存在下一件尺寸核对数据

  ==============================================================================*/
  FUNCTION f_is_qarepskuhasnextsizecheckdata(v_inp_qarepid IN VARCHAR2,
                                             v_inp_gooid   IN VARCHAR2,
                                             v_inp_barcode IN VARCHAR2,
                                             v_inp_nextseq IN NUMBER,
                                             v_inp_compid  IN VARCHAR2)
    RETURN NUMBER IS
    v_totalamount NUMBER(8);
    v_retnum      NUMBER(1);
  BEGIN
    SELECT MAX(seq_no)
      INTO v_totalamount
      FROM scmdata.t_qa_sizecheckchart
     WHERE qa_report_id = v_inp_qarepid
       AND goo_id = v_inp_gooid
       AND NVL(barcode, ' ') = NVL(v_inp_barcode, ' ')
       AND company_id = v_inp_compid;

    IF v_totalamount < v_inp_nextseq THEN
      v_retnum := 0;
    ELSE
      v_retnum := 1;
    END IF;

    RETURN v_retnum;
  END f_is_qarepskuhasnextsizecheckdata;

  /*=============================================================================

     包：
       pkg_qa_da(qa数据访问包)

     函数名:
       获取当前报告Sku尺寸核对单据总和

     入参:
       v_inp_qarepid    :  质检报告Id
       v_inp_compid     :  企业Id
       v_inp_gooid      :  商品档案货号
       v_inp_barcode    :  条码

     返回值:
       Number 类型，当前报告Sku尺寸核对单据总和

     版本:
       2022-12-15_zc314 : 获取当前报告Sku尺寸核对单据总和

  ==============================================================================*/
  FUNCTION f_get_qarepskusizechecktotalnum(v_inp_qarepid IN VARCHAR2,
                                           v_inp_compid  IN VARCHAR2,
                                           v_inp_gooid   IN VARCHAR2,
                                           v_inp_barcode IN VARCHAR2)
    RETURN NUMBER IS
    v_totalamount NUMBER(8);
  BEGIN
    SELECT COUNT(DISTINCT seq_no)
      INTO v_totalamount
      FROM scmdata.t_qa_sizecheckchart
     WHERE qa_report_id = v_inp_qarepid
       AND company_id = v_inp_compid
       AND goo_id = v_inp_gooid
       AND nvl(barcode, ' ') = nvl(v_inp_barcode, ' ');

    RETURN v_totalamount;
  END f_get_qarepskusizechecktotalnum;

  /*=============================================================================

     包：
       pkg_qa_da(QA数据访问包)

     函数名:
       获取 Qa 尺寸表操作人Id

     入参:
       v_inp_qarepid   :  Qa质检报告Id
       v_inp_compid    :  企业Id
       v_inp_position  :  部位
       v_inp_gooid     :  商品档案货号
       v_inp_barcode   :  条码
       v_inp_seqno     :  序号

     返回值:
       Varchar2 类型，Qa 尺寸表操作人Id

     版本:
       2022-12-30_ZC314 : 获取 Qa 尺寸表操作人Id
       2023-01-04_ZC314 : 维度调整尺寸表Id修改为部位

  ==============================================================================*/
  FUNCTION f_get_qasizechartoperuserid(v_inp_qarepid  IN VARCHAR2,
                                       v_inp_compid   IN VARCHAR2,
                                       v_inp_position IN VARCHAR2,
                                       v_inp_gooid    IN VARCHAR2,
                                       v_inp_barcode  IN VARCHAR2,
                                       v_inp_seqno    IN NUMBER)
    RETURN VARCHAR2 IS
    v_userid VARCHAR2(32);
  BEGIN
    SELECT MAX(update_id)
      INTO v_userid
      FROM scmdata.t_qa_sizecheckchart
     WHERE qa_report_id = v_inp_qarepid
       AND company_id = v_inp_compid
       AND position = v_inp_position
       AND goo_id = v_inp_gooid
       AND nvl(barcode, ' ') = nvl(v_inp_barcode, ' ')
       AND seq_no = v_inp_seqno;

    RETURN v_userid;
  END f_get_qasizechartoperuserid;

  /*=============================================================================

     包：
       pkg_qa_da(QA数据访问包)

     函数名:
       判断当前操作是否将清空 Qa尺寸核对录入记录

     入参:
       v_inp_qarepid      :  Qa质检报告Id
       v_inp_compid       :  企业Id
       v_inp_gooid        :  商品档案货号
       v_inp_barcode      :  条码
       v_inp_seqno        :  序号

     返回值:
       Number 类型，0-当前操作不会清空Qa尺寸核对录入记录
                    1-当前操作会清空Qa尺寸核对录入记录

     版本:
       2022-12-30_ZC314 : 判断当前操作是否将清空 Qa尺寸核对录入记录

  ==============================================================================*/
  FUNCTION f_is_qasizechartupdtoempty(v_inp_qarepid IN VARCHAR2,
                                      v_inp_compid  IN VARCHAR2,
                                      v_inp_gooid   IN VARCHAR2,
                                      v_inp_barcode IN VARCHAR2,
                                      v_inp_seqno   IN NUMBER) RETURN NUMBER IS
    v_jugnum NUMBER(1);
  BEGIN
    SELECT NVL(MAX(1), 0)
      INTO v_jugnum
      FROM scmdata.t_qa_sizecheckchart
     WHERE qa_report_id = v_inp_qarepid
       AND company_id = v_inp_compid
       AND goo_id = v_inp_gooid
       AND nvl(barcode, ' ') = nvl(v_inp_barcode, ' ')
       AND seq_no = v_inp_seqno
       AND actual_size IS NOT NULL;

    --意义反转
    IF v_jugnum = 0 THEN
      v_jugnum := 1;
    ELSE
      v_jugnum := 0;
    END IF;

    RETURN v_jugnum;
  END f_is_qasizechartupdtoempty;

  /*=============================================================================

     包：
       pkg_qa_da(QA数据访问包)

     函数名:
       获取当前Sku Qa尺寸录入记录为空的序号

     入参:
       v_inp_qarepid  :  Qa质检报告Id
       v_inp_compid   :  企业Id
       v_inp_gooid    :  商品档案货号
       v_inp_barcode  :  条码

     返回值:
       Number 类型，Qa尺寸录入记录为空的序号

     版本:
       2022-12-30_ZC314 : 获取当前Sku Qa尺寸录入记录为空的序号

  ==============================================================================*/
  FUNCTION f_get_qasizechartemptyseqno(v_inp_qarepid IN VARCHAR2,
                                       v_inp_compid  IN VARCHAR2,
                                       v_inp_gooid   IN VARCHAR2,
                                       v_inp_barcode IN VARCHAR2)
    RETURN NUMBER IS
    v_jugnum NUMBER(1);
    v_seqno  NUMBER(4);
  BEGIN
    SELECT NVL(MAX(1), 0)
      INTO v_jugnum
      FROM scmdata.t_qa_sizecheckchart
     WHERE qa_report_id = v_inp_qarepid
       AND company_id = v_inp_compid
       AND goo_id = v_inp_gooid
       AND nvl(barcode, ' ') = nvl(v_inp_barcode, ' ')
       AND rownum = 1;

    IF v_jugnum = 1 THEN
      SELECT MAX(seq_no)
        INTO v_seqno
        FROM (SELECT seq_no, MAX(jug) maxjug
                FROM (SELECT seq_no,
                             CASE
                               WHEN actual_size IS NOT NULL THEN
                                1
                               ELSE
                                0
                             END jug
                        FROM scmdata.t_qa_sizecheckchart
                       WHERE qa_report_id = v_inp_qarepid
                         AND company_id = v_inp_compid
                         AND goo_id = v_inp_gooid
                         AND nvl(barcode, ' ') = nvl(v_inp_barcode, ' '))
               GROUP BY seq_no)
       WHERE maxjug = 0;
    END IF;

    RETURN v_seqno;
  END f_get_qasizechartemptyseqno;

  /*=============================================================================

     包：
       pkg_qa_da(QA数据访问包)

     函数名:
       判断 Asn 是否存在于 Asnordered

     入参:
       v_inp_asnid   :  Qa质检报告Id
       v_inp_compid  :  企业Id

     返回值:
       Number 类型，0-Asn 不存在于 Asnordered
                    1-Asn 存在于 Asnordered

     版本:
       2022-12-31_ZC314 : 判断 Asn 是否存在于 Asnordered

  ==============================================================================*/
  FUNCTION f_is_asnorderedrecexists(v_inp_asnid  IN VARCHAR2,
                                    v_inp_compid IN VARCHAR2) RETURN NUMBER IS
    v_jugnum NUMBER(1);
  BEGIN
    SELECT NVL(MAX(1), 0)
      INTO v_jugnum
      FROM scmdata.t_asnordered
     WHERE asn_id = v_inp_asnid
       AND company_id = v_inp_compid;

    RETURN v_jugnum;
  END f_is_asnorderedrecexists;

  /*=============================================================================

     包：
       pkg_qa_da(QA数据访问包)

     函数名:
       校验商品档案货号是否存在于Qa尺寸核对表内

     入参:
       v_inp_gooid   :  商品档案货号
       v_inp_compid  :  企业Id

     返回值:
       Number 类型，0-不存在，1-存在

     版本:
       2023-01-04_ZC314 : 校验商品档案货号是否存在于Qa尺寸核对表内

  ==============================================================================*/
  FUNCTION f_is_gooexistinqasizecheckchart(v_inp_gooid  IN VARCHAR2,
                                           v_inp_compid IN VARCHAR2)
    RETURN NUMBER IS
    v_jugnum NUMBER(1);
  BEGIN
    SELECT NVL(MAX(1), 0)
      INTO v_jugnum
      FROM scmdata.t_qa_sizecheckchart
     WHERE goo_id = v_inp_gooid
       AND company_id = v_inp_compid
       AND rownum = 1;

    RETURN v_jugnum;
  END f_is_gooexistinqasizecheckchart;

  /*=============================================================================

     包：
       pkg_qa_da(QA数据访问包)

     函数名:
       校验商品档案货号是否存在“部位”不存在于Qa尺寸核对表内

     入参:
       v_inp_gooid   :  商品档案货号
       v_inp_compid  :  企业Id

     返回值:
       Number 类型，0-所有部位都已存在于Qa尺寸核对表中
                    1-有部位不存在于Qa尺寸核对表中

     版本:
       2023-01-04_ZC314 : 校验商品档案货号是否存在“部位”不存在于Qa尺寸核对表内

  ==============================================================================*/
  FUNCTION f_is_goospositionnotexistsinqasizecheckchart(v_inp_gooid  IN VARCHAR2,
                                                        v_inp_compid IN VARCHAR2)
    RETURN NUMBER IS
    v_jugnum NUMBER(1);
  BEGIN
    SELECT MAX(1)
      INTO v_jugnum
      FROM (SELECT sz.position
              FROM scmdata.t_qa_sizecheckchart qasz
              LEFT JOIN scmdata.t_size_chart sz
                ON qasz.goo_id = sz.goo_id
               AND qasz.position = sz.position
               AND qasz.company_id = sz.company_id
             WHERE qasz.goo_id = v_inp_gooid
               AND qasz.company_id = v_inp_compid)
     WHERE position IS NULL
       AND ROWNUM = 1;

    RETURN v_jugnum;
  END f_is_goospositionnotexistsinqasizecheckchart;

  /*=============================================================================

     包：
       pkg_qa_da(QA数据访问包)

     函数名:
       根据商品档案编号获取货号

     入参:
       v_inp_gooid   :  商品档案货号
       v_inp_compid  :  企业Id

     返回值:
       Varchar 类型，货号

     版本:
       2023-01-04_ZC314 : 根据商品档案编号获取货号

  ==============================================================================*/
  FUNCTION f_get_relagooidbygooid(v_inp_gooid  IN VARCHAR2,
                                  v_inp_compid IN VARCHAR2) RETURN VARCHAR2 IS
    v_relagooid VARCHAR2(32);
  BEGIN
    SELECT MAX(rela_goo_id)
      INTO v_relagooid
      FROM scmdata.t_commodity_info
     WHERE goo_id = v_inp_gooid
       AND company_id = v_inp_compid;

    RETURN v_relagooid;
  END f_get_relagooidbygooid;

  /*=============================================================================

     包：
       pkg_qa_da(QA数据访问包)

     函数名:
       获取拿货员和拿货记录

     入参:
       v_inp_qarepid  :  质检报告Id
       v_inp_compid   :  企业Id

     返回值:
       Varchar2 类型，查货员

     版本:
       2023-01-09_ZC314 : 获取拿货员和拿货记录

  ==============================================================================*/
  FUNCTION f_get_qarepcheckers(v_inp_qarepid IN VARCHAR2,
                               v_inp_compid  IN VARCHAR2) RETURN VARCHAR2 IS
    v_checkers VARCHAR2(1024);
  BEGIN
    SELECT MAX(checkers)
      INTO v_checkers
      FROM scmdata.t_qa_report
     WHERE qa_report_id = v_inp_qarepid
       AND company_id = v_inp_compid;

    RETURN v_checkers;
  END f_get_qarepcheckers;

  /*=============================================================================

     包：
       pkg_qa_da(QA数据访问包)

     函数名:
       根据传入用户Id获取企业用户名称

     入参:
       v_inp_userid  :  用户Id
       v_inp_compid  :  企业Id

     返回值:
       Varchar 类型，企业用户名称

     版本:
       2023-01-07_ZC314 : 根据传入用户Id获取企业用户名称

  ==============================================================================*/
  FUNCTION f_get_companyusernamebyuserid(v_inp_userid IN VARCHAR2,
                                         v_inp_compid IN VARCHAR2)
    RETURN VARCHAR2 IS
    v_compusername VARCHAR2(128);
  BEGIN
    SELECT MAX(company_user_name)
      INTO v_compusername
      FROM scmdata.sys_company_user
     WHERE user_id = v_inp_userid
       AND company_id = v_inp_compid;

    RETURN v_compusername;
  END f_get_companyusernamebyuserid;

END pkg_qa_da;
/

