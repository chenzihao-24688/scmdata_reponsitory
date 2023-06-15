CREATE OR REPLACE PACKAGE SCMDATA.pkg_qa_ld IS

  /*=============================================================================
  
     包：
       pkg_qa_ld(qa逻辑细节包)
  
     函数名:
       asn免检参数校验
  
     入参:
       v_inp_asnid        : asnid
       v_inp_compid       : 企业id
       v_inp_aeresoncode  : 免检原因编码
       v_inp_invokeobj    : 调用对象
  
     返回值:
       varchar2 类型，错误信息
  
     版本:
       2022-10-09_zc314 : asn免检
  
  ==============================================================================*/
  FUNCTION f_check_asnexemptionparam(v_inp_asnid       IN VARCHAR2,
                                     v_inp_compid      IN VARCHAR2,
                                     v_inp_aeresoncode IN VARCHAR2,
                                     v_inp_invokeobj   IN VARCHAR2)
    RETURN VARCHAR2;

  /*=============================================================================
  
     包：
       pkg_qa_ld(qa逻辑细节包)
  
     过程名:
       修改 Asn状态
  
     入参:
       v_inp_asnids      :  Asn单号，多值，用分号分隔
       v_inp_compid      :  企业id
       v_inp_status      :  Asn状态
       v_inp_operuserid  :  当前操作人Id
       v_inp_invokeobj   :  调用对象
  
     版本:
       2022-10-13_zc314 : 修改 Asn状态
  
  ==============================================================================*/
  PROCEDURE p_upd_asnstatus(v_inp_asnids     IN VARCHAR2,
                            v_inp_compid     IN VARCHAR2,
                            v_inp_status     IN VARCHAR2,
                            v_inp_operuserid IN VARCHAR2,
                            v_inp_invokeobj  IN VARCHAR2);

  /*=============================================================================
  
     包：
       pkg_qa_ld(qa逻辑细节包)
  
     过程名:
       Asn免检流程-更新Asn状态与免检原因
  
     入参:
       v_inp_asnid        : asnid
       v_inp_compid       : 企业id
       v_inp_aeresoncode  : 免检原因编码
       v_inp_curuserid    : 当前操作人Id
       v_inp_invokeobj    : 调用对象
  
     版本:
       2022-10-09_zc314 : Asn免检流程-更新Asn状态与免检原因
  
  ==============================================================================*/
  PROCEDURE p_upd_asnstatusandaereason(v_inp_asnid       IN VARCHAR2,
                                       v_inp_compid      IN VARCHAR2,
                                       v_inp_aeresoncode IN VARCHAR2,
                                       v_inp_curuserid   IN VARCHAR2,
                                       v_inp_invokeobj   IN VARCHAR2);

  /*=============================================================================
  
     包：
       pkg_qa_ld(qa逻辑细节包)
  
     过程名:
       Asn 预回传 Wms 表 新增
  
     入参:
       v_inp_asnid      :  Asn单号
       v_inp_gooid      :  货号
       v_inp_barcode    :  条码
       v_inp_compid     :  企业Id
       v_inp_status     :  状态： PT-准备回传 TS-传输成功 TE-传输错误 CE-校验错误
       v_inp_errinfo    :  错误信息
       v_inp_transtype  :  传输类型： ASN-按Asn整单质检完成传输 SKU-按Sku传输 AE-按Asn整单免检传输
       v_inp_curuserid  :  当前操作人Id
       v_inp_invokeobj  :  调用对象
  
     版本:
       2022-10-26_zc314 : Asn 预回传 Wms 表 新增
       2022-11-21_zc314 : 增加 err_info 中对接口数据是否更新成功校验
  
  ==============================================================================*/
  PROCEDURE p_ins_asninfopretranstowms(v_inp_asnid     IN VARCHAR2,
                                       v_inp_gooid     IN VARCHAR2 DEFAULT NULL,
                                       v_inp_barcode   IN VARCHAR2 DEFAULT NULL,
                                       v_inp_compid    IN VARCHAR2,
                                       v_inp_status    IN VARCHAR2,
                                       v_inp_errinfo   IN CLOB,
                                       v_inp_transtype IN VARCHAR2,
                                       v_inp_curuserid IN VARCHAR2,
                                       v_inp_invokeobj IN VARCHAR2);

  /*=============================================================================
  
     包：
       pkg_qa_ld(qa逻辑细节包)
  
     过程名:
       asn 预回传 wms 表 更新
  
     入参:
       v_inp_asnid      :  asn单号
       v_inp_gooid      :  货号
       v_inp_barcode    :  条码
       v_inp_compid     :  企业id
       v_inp_transtype  :  传输类型： asn-按asn整单质检完成传输 sku-按sku传输 ae-按asn整单免检传输
       v_inp_status     :  状态： pt-准备回传 ts-传输成功 te-传输错误 ce-校验错误
       v_inp_errinfo    :  错误信息
       v_inp_curuserid  :  当前操作人id
       v_inp_invokeobj  :  调用对象
  
     版本:
       2022-12-06_zc314 : asn 预回传 wms 表 更新
       2023-02-15_zc314 : 增加传输类型更新逻辑
  
  ==============================================================================*/
  PROCEDURE p_upd_asninfopretranstowms(v_inp_asnid     IN VARCHAR2,
                                       v_inp_gooid     IN VARCHAR2 DEFAULT NULL,
                                       v_inp_barcode   IN VARCHAR2 DEFAULT NULL,
                                       v_inp_compid    IN VARCHAR2,
                                       v_inp_transtype IN VARCHAR2,
                                       v_inp_status    IN VARCHAR2,
                                       v_inp_errinfo   IN CLOB,
                                       v_inp_curuserid IN VARCHAR2,
                                       v_inp_invokeobj IN VARCHAR2);

  /*=============================================================================
  
     包：
       pkg_qa_ld(qa逻辑细节包)
  
     过程名:
       已检列表基础维度数据新增
  
     入参:
       v_inp_asnid              :  asn编号
       v_inp_compid             :  企业id
       v_inp_gooid              :  商品档案编号
       v_inp_barcode            :  sku条码
       v_inp_ordid              :  订单号
       v_inp_pcomeamt           :  预计到仓数量
       v_inp_wmsgotamt          :  wms上架数量
       v_inp_qualdecreamt       :  质检减数
       v_inp_qualpassamt        :  质检通过减数
       v_inp_qualresult         :  质检结果
       v_inp_unqualprosresult   :  不合格处理原因
       v_inp_arrretnum          :  到仓返工数量
       v_inp_aereason           :  免检原因
       v_inp_pcomedate          :  预计到仓日期
       v_inp_scantime           :  到仓扫描时间
       v_inp_receivetime        :  上架时间
       v_inp_qualfinishtime     :  质检完成时间
       v_inp_colorname          :  颜色名称
       v_inp_sizename           :  尺寸名称
       v_inp_datasource         :  数据源
       v_inp_wmsskucheckresult  :  Wms_Sku质检结果
       v_inp_operuserid         :  操作人Id
       v_inp_invokeobj          :  调用对象
  
     版本:
       2022-10-09_zc314 : 已检列表基础维度数据新增
       2022-10-13_zc314 : pkg_qa_ee 异常处理逻辑补充
       2022-12-03_zc314 : 增加 scmdata.t_qaqualedlist_sla.color_name, size_name列
                          以解决已检列表从表颜色尺码列无数据问题
  
  ==============================================================================*/
  PROCEDURE p_ins_qaqualedlistsla(v_inp_asnid             IN VARCHAR2,
                                  v_inp_compid            IN VARCHAR2,
                                  v_inp_gooid             IN VARCHAR2,
                                  v_inp_barcode           IN VARCHAR2,
                                  v_inp_ordid             IN VARCHAR2,
                                  v_inp_pcomeamt          IN NUMBER,
                                  v_inp_wmsgotamt         IN NUMBER,
                                  v_inp_qualdecreamt      IN NUMBER,
                                  v_inp_qualpassamt       IN NUMBER,
                                  v_inp_qualresult        IN VARCHAR2,
                                  v_inp_unqualprosresult  IN VARCHAR2,
                                  v_inp_arrretnum         IN NUMBER,
                                  v_inp_aereason          IN VARCHAR2,
                                  v_inp_pcomedate         IN DATE,
                                  v_inp_scantime          IN DATE,
                                  v_inp_receivetime       IN DATE,
                                  v_inp_qualfinishtime    IN DATE,
                                  v_inp_colorname         IN VARCHAR2,
                                  v_inp_sizename          IN VARCHAR2,
                                  v_inp_datasource        IN VARCHAR2,
                                  v_inp_wmsskucheckresult IN VARCHAR2,
                                  v_inp_operuserid        IN VARCHAR2,
                                  v_inp_invokeobj         IN VARCHAR2);

  /*=============================================================================
  
     包：
       pkg_qa_ld(qa逻辑细节包)
  
     过程名:
       已检列表基础维度数据修改
  
     入参:
       v_inp_asnid              :  asn编号
       v_inp_compid             :  企业id
       v_inp_gooid              :  商品档案编号
       v_inp_barcode            :  sku条码
       v_inp_ordid              :  订单号
       v_inp_pcomeamt           :  预计到仓数量
       v_inp_wmsgotamt          :  wms上架数量
       v_inp_qualdecreamt       :  质检减数
       v_inp_qualpassamt        :  质检通过减数
       v_inp_qualresult         :  质检结果
       v_inp_unqualprosresult   :  不合格处理原因
       v_inp_arrretnum          :  到仓返工数量
       v_inp_aereason           :  免检原因
       v_inp_pcomedate          :  预计到仓日期
       v_inp_scantime           :  到仓扫描时间
       v_inp_receivetime        :  上架时间
       v_inp_qualfinishtime     :  质检完成时间
       v_inp_colorname          :  颜色名称
       v_inp_sizename           :  尺寸名称
       v_inp_datasource         :  数据源
       v_inp_wmsskucheckresult  :  Wms_Sku质检结果
       v_inp_operuserid         :  操作人Id
       v_inp_invokeobj          :  调用对象
  
     版本:
       2022-10-09_zc314 : 已检列表基础维度数据修改
       2022-10-13_zc314 : pkg_qa_ee 异常处理逻辑补充
       2022-12-03_zc314 : 增加 scmdata.t_qaqualedlist_sla.color_name, size_name列
                          以解决已检列表从表颜色尺码列无数据问题
  
  ==============================================================================*/
  PROCEDURE p_upd_qaqualedlistsla(v_inp_asnid             IN VARCHAR2,
                                  v_inp_compid            IN VARCHAR2,
                                  v_inp_gooid             IN VARCHAR2,
                                  v_inp_barcode           IN VARCHAR2,
                                  v_inp_ordid             IN VARCHAR2,
                                  v_inp_pcomeamt          IN NUMBER,
                                  v_inp_wmsgotamt         IN NUMBER,
                                  v_inp_qualdecreamt      IN NUMBER,
                                  v_inp_qualpassamt       IN NUMBER,
                                  v_inp_qualresult        IN VARCHAR2,
                                  v_inp_unqualprosresult  IN VARCHAR2,
                                  v_inp_arrretnum         IN NUMBER,
                                  v_inp_aereason          IN VARCHAR2,
                                  v_inp_pcomedate         IN DATE,
                                  v_inp_scantime          IN DATE,
                                  v_inp_receivetime       IN DATE,
                                  v_inp_qualfinishtime    IN DATE,
                                  v_inp_colorname         IN VARCHAR2,
                                  v_inp_sizename          IN VARCHAR2,
                                  v_inp_datasource        IN VARCHAR2,
                                  v_inp_wmsskucheckresult IN VARCHAR2,
                                  v_inp_operuserid        IN VARCHAR2,
                                  v_inp_invokeobj         IN VARCHAR2);

  /*=============================================================================
  
     包：
       pkg_qa_ld(qa逻辑细节包)
  
     过程名:
       已检列表基础维度数据新增
  
     入参:
       v_inp_asnid            :  asn编号
       v_inp_compid           :  企业id
       v_inp_gooid            :  商品档案编号
       v_inp_barcode          :  sku条码
       v_inp_ordid            :  订单号
       v_inp_pcomeamt         :  预计到仓数量
       v_inp_wmsgotamt        :  wms上架数量
       v_inp_qualdecreamt     :  质检减数
       v_inp_qualpassamt      :  质检通过减数
       v_inp_qualresult       :  质检结果
       v_inp_unqualprosresult :  不合格处理原因
       v_inp_arrretnum        :  到仓返工数量
       v_inp_aereason         :  免检原因
       v_inp_pcomedate        :  预计到仓日期
       v_inp_scantime         :  到仓扫描时间
       v_inp_receivetime      :  上架时间
       v_inp_qualfinishtime   :  质检完成时间
       v_inp_operuserid       :  操作人Id
       v_inp_invokeobj        :  调用对象
  
     版本:
       2022-10-09_zc314 : 已检列表基础维度数据新增
       2022-10-13_zc314 : pkg_qa_ee 异常处理逻辑补充
  
  ==============================================================================*/
  PROCEDURE p_ins_qaqualedlistmas(v_inp_asnid            IN VARCHAR2,
                                  v_inp_compid           IN VARCHAR2,
                                  v_inp_ordid            IN VARCHAR2,
                                  v_inp_pcomeamt         IN NUMBER,
                                  v_inp_wmsgotamt        IN NUMBER,
                                  v_inp_qualdecreamt     IN NUMBER,
                                  v_inp_qualpassamt      IN NUMBER,
                                  v_inp_qualresult       IN VARCHAR2,
                                  v_inp_unqualprosresult IN VARCHAR2,
                                  v_inp_arrretnum        IN NUMBER,
                                  v_inp_aereason         IN VARCHAR2,
                                  v_inp_pcomedate        IN DATE,
                                  v_inp_scantime         IN DATE,
                                  v_inp_receivetime      IN DATE,
                                  v_inp_qualfinishtime   IN DATE,
                                  v_inp_operuserid       IN VARCHAR2,
                                  v_inp_invokeobj        IN VARCHAR2);

  /*=============================================================================
  
     包：
       pkg_qa_ld(qa逻辑细节包)
  
     过程名:
       已检列表基础维度数据新增
  
     入参:
       v_inp_asnid            :  asn编号
       v_inp_compid           :  企业id
       v_inp_gooid            :  商品档案编号
       v_inp_barcode          :  sku条码
       v_inp_ordid            :  订单号
       v_inp_pcomeamt         :  预计到仓数量
       v_inp_wmsgotamt        :  wms上架数量
       v_inp_qualdecreamt     :  质检减数
       v_inp_qualpassamt      :  质检通过减数
       v_inp_qualresult       :  质检结果
       v_inp_unqualprosresult :  不合格处理原因
       v_inp_arrretnum        :  到仓返工数量
       v_inp_aereason         :  免检原因
       v_inp_pcomedate        :  预计到仓日期
       v_inp_scantime         :  到仓扫描时间
       v_inp_receivetime      :  上架时间
       v_inp_qualfinishtime   :  质检完成时间
       v_inp_operuserid       :  操作人Id
       v_inp_invokeobj        :  调用对象
  
     版本:
       2022-10-09_zc314 : 已检列表基础维度数据新增
       2022-10-13_zc314 : pkg_qa_ee 异常处理逻辑补充
  
  ==============================================================================*/
  PROCEDURE p_upd_qaqualedlistmas(v_inp_asnid            IN VARCHAR2,
                                  v_inp_compid           IN VARCHAR2,
                                  v_inp_ordid            IN VARCHAR2,
                                  v_inp_pcomeamt         IN NUMBER,
                                  v_inp_wmsgotamt        IN NUMBER,
                                  v_inp_qualdecreamt     IN NUMBER,
                                  v_inp_qualpassamt      IN NUMBER,
                                  v_inp_qualresult       IN VARCHAR2,
                                  v_inp_unqualprosresult IN VARCHAR2,
                                  v_inp_arrretnum        IN NUMBER,
                                  v_inp_aereason         IN VARCHAR2,
                                  v_inp_pcomedate        IN DATE,
                                  v_inp_scantime         IN DATE,
                                  v_inp_receivetime      IN DATE,
                                  v_inp_qualfinishtime   IN DATE,
                                  v_inp_operuserid       IN VARCHAR2,
                                  v_inp_invokeobj        IN VARCHAR2);

  /*=============================================================================
  
     包：
       pkg_qa_ld(qa逻辑细节包)
  
     函数名:
       获取 Asn免检 barcode维度数据 Sql
  
     入参:
       v_inp_invokeobj : 调用对象
  
     版本:
       2022-10-11_zc314 : 获取 Asn免检 barcode维度数据 Sql
  
  ==============================================================================*/
  FUNCTION f_get_asnae_barcodedim_sql(v_inp_invokeobj IN VARCHAR2)
    RETURN CLOB;

  /*=============================================================================
  
     包：
       pkg_qa_ld(qa逻辑细节包)
  
     函数名:
       获取 Asn质检 barcode维度数据 Sql
  
     入参:
       v_inp_invokeobj : 调用对象
  
     版本:
       2022-10-11_zc314 : 获取 Asn质检 barcode维度数据 Sql
  
  ==============================================================================*/
  FUNCTION f_get_asnfa_barcodedim_sql(v_inp_invokeobj IN VARCHAR2)
    RETURN CLOB;

  /*=============================================================================
  
     包：
       pkg_qa_ld(qa逻辑细节包)
  
     函数名:
       Asn已检列表主表增改数据 Sql
  
     入参:
       v_inp_invokeobj : 调用对象
  
     版本:
       2022-10-11_zc314 : Asn已检列表主表增改数据 Sql
  
  ==============================================================================*/
  FUNCTION f_get_qualedlistmas_iusql(v_inp_invokeobj IN VARCHAR2) RETURN CLOB;

  /*=============================================================================
  
     包：
       pkg_qa_ld(qa逻辑细节包)
  
     函数名:
       获取输入字段长度是否小于等于4000
  
     入参:
       v_inp_clob      : 输入值
       v_inp_invokeobj : 调用对象
  
     返回值:
       Number 类型，0-大于4000 1-小于等于4000
  
     版本:
       2022-10-12_zc314 : 获取输入字段长度是否小于等于4000
  
  ==============================================================================*/
  FUNCTION f_is_cloblengthlessorequalfourk(v_inp_clob      IN CLOB,
                                           v_inp_invokeobj IN VARCHAR2)
    RETURN NUMBER;

  /*=============================================================================
  
     包：
       pkg_qa_ld(qa逻辑细节包)
  
     函数名:
       获取通过 Asn 查询预计到仓总数，收货/上架总数 Sql
  
     入参:
       v_inp_invokeobj : 调用对象
  
     版本:
       2022-10-12_zc314 : 获取通过 Asn 查询预计到仓总数，收货/上架总数 Sql
  
  ==============================================================================*/
  FUNCTION f_get_asnpcomeamoutandgotamount_sql(v_inp_invokeobj IN VARCHAR2)
    RETURN CLOB;

  /*=============================================================================
  
     包：
       pkg_qa_ld(qa逻辑细节包)
  
     函数名:
       Qa质检报告主表新增
  
     入参:
       v_inp_qarepid              :  Qa质检报告Id
       v_inp_compid               :  企业Id
       v_inp_status               :  状态
       v_inp_checktype            :  质检类型
       v_inp_checkresult          :  质检结果
       v_inp_problemclassifiction :  问题分类
       v_inp_problemdescription   :  问题描述
       v_inp_reviewcomments       :  审核意见
       v_inp_checks               :  查货员
       v_inp_checkdate            :  质检日期
       v_inp_qualattachment       :  质检附件
       v_inp_review_attachment    :  批复附件
       v_inp_memo                 :  备注
       v_inp_curuserid            :  当前操作人Id
       v_inp_curtime              :  当前时间
       v_inp_invokeobj            :  调用对象
  
     版本:
       2022-10-12_zc314 : Qa质检报告主表新增
       2022-10-13_zc314 : pkg_qa_ee 异常处理逻辑补充
  
  ==============================================================================*/
  PROCEDURE p_ins_qareportmas(v_inp_qarepid              IN VARCHAR2,
                              v_inp_compid               IN VARCHAR2,
                              v_inp_status               IN VARCHAR2,
                              v_inp_checktype            IN VARCHAR2,
                              v_inp_checkresult          IN VARCHAR2,
                              v_inp_problemclassifiction IN VARCHAR2,
                              v_inp_problemdescription   IN VARCHAR2,
                              v_inp_reviewcomments       IN VARCHAR2,
                              v_inp_checkers             IN VARCHAR2,
                              v_inp_checkdate            IN DATE,
                              v_inp_qualattachment       IN VARCHAR2,
                              v_inp_reviewattachment     IN VARCHAR2,
                              v_inp_memo                 IN VARCHAR2,
                              v_inp_curuserid            IN VARCHAR2,
                              v_inp_curtime              IN DATE,
                              v_inp_ispriority           IN NUMBER,
                              v_inp_invokeobj            IN VARCHAR2);

  /*=============================================================================
  
     包：
       pkg_qa_ld(qa逻辑细节包)
  
     函数名:
       Qa质检报告主表修改
  
     入参:
       v_inp_qarepid              :  Qa质检报告Id
       v_inp_compid               :  企业Id
       v_inp_status               :  状态
       v_inp_checktype            :  质检类型
       v_inp_checkresult          :  质检结果
       v_inp_problemclassifiction :  问题分类
       v_inp_problemdescription   :  问题描述
       v_inp_reviewcomments       :  审核意见
       v_inp_checks               :  查货员
       v_inp_checkdate            :  质检日期
       v_inp_qualattachment       :  质检附件
       v_inp_review_attachment    :  批复附件
       v_inp_memo                 :  备注
       v_inp_curuserid            :  当前操作人Id
       v_inp_curtime              :  当前时间
       v_inp_invokeobj            :  调用对象
  
     版本:
       2022-10-12_zc314 : Qa质检报告主表修改
       2022-10-13_zc314 : pkg_qa_ee 异常处理逻辑补充
  
  ==============================================================================*/
  PROCEDURE p_upd_qareportmas(v_inp_qarepid              IN VARCHAR2,
                              v_inp_compid               IN VARCHAR2,
                              v_inp_status               IN VARCHAR2,
                              v_inp_checktype            IN VARCHAR2,
                              v_inp_checkresult          IN VARCHAR2,
                              v_inp_problemclassifiction IN VARCHAR2,
                              v_inp_problemdescription   IN VARCHAR2,
                              v_inp_reviewcomments       IN VARCHAR2,
                              v_inp_checkers             IN VARCHAR2,
                              v_inp_checkdate            IN DATE,
                              v_inp_qualattachment       IN VARCHAR2,
                              v_inp_reviewattachment     IN VARCHAR2,
                              v_inp_memo                 IN VARCHAR2,
                              v_inp_curuserid            IN VARCHAR2,
                              v_inp_curtime              IN DATE,
                              v_inp_ispriority           IN NUMBER,
                              v_inp_invokeobj            IN VARCHAR2);

  /*=============================================================================
  
     包：
       pkg_qa_ld(qa逻辑细节包)
  
     函数名:
       Qa质检报告报告级数字维度表新增
  
     入参:
       v_inp_qarepid                  :  Qa质检报告Id
       v_inp_compid                   :  企业Id
       v_inp_firstsamplingamount      :  首抽件数
       v_inp_addsamplingamount        :  加抽件数
       v_inp_unqualsamplingamount     :  不合格件数
       v_inp_pcomesumamount           :  预计到仓总数
       v_inp_wmsgotsumamount          :  wms上架总数
       v_inp_qualdecreasesumamount    :  质检件数
       v_inp_prereprocessingsumamount :  待返工数量
       v_inp_operuserid               :  操作人Id
       v_inp_invokeobj                :  调用对象
  
     版本:
       2022-10-12_zc314 : Qa质检报告报告级数字维度表新增
  
  ==============================================================================*/
  PROCEDURE p_ins_qarepnumdim(v_inp_qarepid                  IN VARCHAR2,
                              v_inp_compid                   IN VARCHAR2,
                              v_inp_firstsamplingamount      IN NUMBER,
                              v_inp_addsamplingamount        IN NUMBER,
                              v_inp_unqualsamplingamount     IN NUMBER,
                              v_inp_pcomesumamount           IN NUMBER,
                              v_inp_wmsgotsumamount          IN NUMBER,
                              v_inp_qualdecreasesumamount    IN NUMBER,
                              v_inp_prereprocessingsumamount IN NUMBER,
                              v_inp_operuserid               IN VARCHAR2,
                              v_inp_invokeobj                IN VARCHAR2);

  /*=============================================================================
  
     包：
       pkg_qa_ld(qa逻辑细节包)
  
     函数名:
       Qa质检报告报告级数字维度表修改
  
     入参:
       v_inp_qarepid                  :  Qa质检报告Id
       v_inp_compid                   :  企业Id
       v_inp_firstsamplingamount      :  首抽件数
       v_inp_addsamplingamount        :  加抽件数
       v_inp_unqualsamplingamount     :  不合格件数
       v_inp_pcomesumamount           :  预计到仓总数
       v_inp_wmsgotsumamount          :  wms上架总数
       v_inp_qualdecreasesumamount    :  质检件数
       v_inp_prereprocessingsumamount :  待返工数量
       v_inp_operuserid               :  操作人Id
       v_inp_invokeobj                :  调用对象
  
     版本:
       2022-10-12_zc314 : Qa质检报告报告级数字维度表修改
  
  ==============================================================================*/
  PROCEDURE p_upd_qarepnumdim(v_inp_qarepid                  IN VARCHAR2,
                              v_inp_compid                   IN VARCHAR2,
                              v_inp_firstsamplingamount      IN NUMBER,
                              v_inp_addsamplingamount        IN NUMBER,
                              v_inp_unqualsamplingamount     IN NUMBER,
                              v_inp_pcomesumamount           IN NUMBER,
                              v_inp_wmsgotsumamount          IN NUMBER,
                              v_inp_qualdecreasesumamount    IN NUMBER,
                              v_inp_prereprocessingsumamount IN NUMBER,
                              v_inp_operuserid               IN VARCHAR2,
                              v_inp_invokeobj                IN VARCHAR2);

  /*=============================================================================
  
     包：
       pkg_qa_ld(qa逻辑细节包)
  
     函数名:
       Qa质检报告Sku维度表新增
  
     入参:
       v_inp_qarepid             :  Qa质检报告Id
       v_inp_compid              :  企业Id
       v_inp_asnid               :  Asn单号
       v_inp_gooid               :  商品档案编号
       v_inp_barcode             :  条码
       v_inp_status              :  状态: PA-待审核，PE-待处理，AF-已完成
       v_inp_skuprocessingresult :  Sku处理结果
       v_inp_skucheckresult      :  Sku质检结果: PS-通过 NP-不通过
       v_inp_pcomeamount         :  预计到仓数量
       v_inp_wmsgotamount        :  wms上架数量
       v_inp_qualdecreaseamount  :  质检减数
       v_inp_unqualamount        :  质检不合格数量
       v_inp_reprocessednumber   :  已到仓返工次数
       v_inp_pcomedate           :  预计到仓日期
       v_inp_scantime            :  到仓扫描时间
       v_inp_receivetime         :  收货/上架时间
       v_inp_reviewid            :  审核Id
       v_inp_reviewtime          :  审核时间
       v_inp_colorname           :  颜色名称
       v_inp_sizename            :  尺码名称
       v_inp_qualfinishtime      :  质检结束时间
       v_inp_operuserid          :  操作人Id
       v_inp_invokeobj           :  调用对象
  
     版本:
       2022-10-12_zc314 : Qa质检报告Sku维度表新增
       2022-10-13_zc314 : pkg_qa_ee 异常处理逻辑补充
       2022-10-26_zc314 : scmdata.t_qa_report_skudim
                         增加 color_name, size_name字段，完成对配码比支持
  
  ==============================================================================*/
  PROCEDURE p_ins_qareportskudim(v_inp_qarepid             IN VARCHAR2,
                                 v_inp_compid              IN VARCHAR2,
                                 v_inp_asnid               IN VARCHAR2,
                                 v_inp_gooid               IN VARCHAR2,
                                 v_inp_barcode             IN VARCHAR2,
                                 v_inp_status              IN VARCHAR2,
                                 v_inp_skuprocessingresult IN VARCHAR2,
                                 v_inp_skucheckresult      IN VARCHAR2,
                                 v_inp_pcomeamount         IN NUMBER,
                                 v_inp_wmsgotamount        IN NUMBER,
                                 v_inp_qualdecreaseamount  IN NUMBER,
                                 v_inp_unqualamount        IN NUMBER,
                                 v_inp_reprocessednumber   IN NUMBER,
                                 v_inp_pcomedate           IN DATE,
                                 v_inp_scantime            IN DATE,
                                 v_inp_receivetime         IN DATE,
                                 v_inp_reviewid            IN VARCHAR2,
                                 v_inp_reviewtime          IN DATE,
                                 v_inp_colorname           IN VARCHAR2,
                                 v_inp_sizename            IN VARCHAR2,
                                 v_inp_qualfinishtime      IN DATE,
                                 v_inp_operuserid          IN VARCHAR2,
                                 v_inp_invokeobj           IN VARCHAR2);

  /*=============================================================================
  
     包：
       pkg_qa_ld(qa逻辑细节包)
  
     函数名:
       qa质检报告sku维度表修改
  
     入参:
       v_inp_qarepid             :  qa质检报告id
       v_inp_compid              :  企业id
       v_inp_asnid               :  asn单号
       v_inp_gooid               :  商品档案编号
       v_inp_barcode             :  条码
       v_inp_status              :  状态: pa-待审核，pe-待处理，af-已完成
       v_inp_skuprocessingresult :  sku处理结果
       v_inp_skucheckresult      :  sku质检结果: ps-通过 np-不通过
       v_inp_pcomeamount         :  预计到仓数量
       v_inp_wmsgotamount        :  wms上架数量
       v_inp_qualdecreaseamount  :  质检减数
       v_inp_unqualamount        :  质检不合格数量
       v_inp_scantime            :  到仓扫描时间
       v_inp_receivetime         :  收货/上架时间
       v_inp_reviewid            :  审核id
       v_inp_reviewtime          :  审核时间
       v_inp_colorname           :  颜色名称
       v_inp_sizename            :  尺码名称
       v_inp_qualfinishtime      :  质检结束时间
       v_inp_operuserid          :  操作人id
       v_inp_invokeobj           :  调用对象
  
     版本:
       2022-10-12_zc314 : qa质检报告sku维度表修改
       2022-10-13_zc314 : pkg_qa_ee 异常处理逻辑补充
       2022-10-26_zc314 : scmdata.t_qa_report_skudim
                         增加 color_name, size_name字段，完成对配码比支持
  
  ==============================================================================*/
  PROCEDURE p_upd_qareportskudim(v_inp_qarepid             IN VARCHAR2,
                                 v_inp_compid              IN VARCHAR2,
                                 v_inp_asnid               IN VARCHAR2,
                                 v_inp_gooid               IN VARCHAR2,
                                 v_inp_barcode             IN VARCHAR2,
                                 v_inp_status              IN VARCHAR2,
                                 v_inp_skuprocessingresult IN VARCHAR2,
                                 v_inp_skucheckresult      IN VARCHAR2,
                                 v_inp_pcomeamount         IN NUMBER,
                                 v_inp_wmsgotamount        IN NUMBER,
                                 v_inp_qualdecreaseamount  IN NUMBER,
                                 v_inp_unqualamount        IN NUMBER,
                                 v_inp_reprocessednumber   IN NUMBER,
                                 v_inp_pcomedate           IN DATE,
                                 v_inp_scantime            IN DATE,
                                 v_inp_receivetime         IN DATE,
                                 v_inp_reviewid            IN VARCHAR2,
                                 v_inp_reviewtime          IN DATE,
                                 v_inp_colorname           IN VARCHAR2,
                                 v_inp_sizename            IN VARCHAR2,
                                 v_inp_qualfinishtime      IN DATE,
                                 v_inp_operuserid          IN VARCHAR2,
                                 v_inp_invokeobj           IN VARCHAR2);

  /*=============================================================================
  
     包：
       pkg_qa_ld(qa逻辑细节包)
  
     函数名:
       Qa质检报告关联信息维度表新增
  
     入参:
       v_inp_qarepid     :  Qa质检报告Id
       v_inp_compid      :  企业Id
       v_inp_asnid       :  Asn单号
       v_inp_gooid       :  商品档案编号
       v_inp_orderid     :  订单号
       v_inp_supcode     :  供应商编码
       v_inp_faccode     :  生产工厂编码
       v_inp_shoid       :  仓库Id
       v_inp_operuserid  :  当前操作人Id
       v_inp_invokeobj   :  调用对象
  
     版本:
       2022-10-13_zc314 : Qa质检报告关联信息维度表新增
  
  ==============================================================================*/
  PROCEDURE p_ins_qareportrelainfodim(v_inp_qarepid    IN VARCHAR2,
                                      v_inp_compid     IN VARCHAR2,
                                      v_inp_asnid      IN VARCHAR2,
                                      v_inp_gooid      IN VARCHAR2,
                                      v_inp_orderid    IN VARCHAR2,
                                      v_inp_supcode    IN VARCHAR2,
                                      v_inp_faccode    IN VARCHAR2,
                                      v_inp_shoid      IN VARCHAR2,
                                      v_inp_operuserid IN VARCHAR2,
                                      v_inp_invokeobj  IN VARCHAR2);

  /*=============================================================================
  
     包：
       pkg_qa_ld(qa逻辑细节包)
  
     函数名:
       Qa质检报告关联信息维度表修改
  
     入参:
       v_inp_qarepid     :  Qa质检报告Id
       v_inp_compid      :  企业Id
       v_inp_asnid       :  Asn单号
       v_inp_gooid       :  商品档案编号
       v_inp_orderid     :  订单号
       v_inp_supcode     :  供应商编码
       v_inp_faccode     :  生产工厂编码
       v_inp_shoid       :  仓库Id
       v_inp_operuserid  :  当前操作人Id
       v_inp_invokeobj   :  调用对象
  
     版本:
       2022-10-13_zc314 : Qa质检报告关联信息维度表修改
  
  ==============================================================================*/
  PROCEDURE p_upd_qareportrelainfodim(v_inp_qarepid    IN VARCHAR2,
                                      v_inp_compid     IN VARCHAR2,
                                      v_inp_asnid      IN VARCHAR2,
                                      v_inp_gooid      IN VARCHAR2,
                                      v_inp_orderid    IN VARCHAR2,
                                      v_inp_supcode    IN VARCHAR2,
                                      v_inp_faccode    IN VARCHAR2,
                                      v_inp_shoid      IN VARCHAR2,
                                      v_inp_operuserid IN VARCHAR2,
                                      v_inp_invokeobj  IN VARCHAR2);

  /*=============================================================================
  
     包：
       pkg_qa_ld(qa逻辑细节包)
  
     函数名:
       Qa质检报告报告级质检细节表新增
  
     入参:
       v_inp_qarepid            :  Qa质检报告Id
       v_inp_compid             :  企业Id
       v_inp_yyresult           :  样衣结果
       v_inp_yyunqualsubjects   :  样衣不合格项
       v_inp_mflresult          :  面辅料结果
       v_inp_mflunqualsubjects  :  面辅料不合格项
       v_inp_gyresult           :  工艺结果
       v_inp_gyunqualsubjects   :  工艺不合格项
       v_inp_bxresult           :  版型结果
       v_inp_bxuqualsubjects    :  版型不合格项
       v_inp_scaleamount        :  度尺件数
       v_inp_operuserid         :  操作人Id
       v_inp_invokeobj          :  调用对象
  
     版本:
       2022-10-12_zc314 : Qa质检报告报告级质检细节表新增
       2022-12-15_zc314 :
  
  ==============================================================================*/
  PROCEDURE p_ins_qarepcheckdetaildim(v_inp_qarepid           IN VARCHAR2,
                                      v_inp_compid            IN VARCHAR2,
                                      v_inp_yyresult          IN VARCHAR2,
                                      v_inp_yyunqualsubjects  IN VARCHAR2,
                                      v_inp_mflresult         IN VARCHAR2,
                                      v_inp_mflunqualsubjects IN VARCHAR2,
                                      v_inp_gyresult          IN VARCHAR2,
                                      v_inp_gyunqualsubjects  IN VARCHAR2,
                                      v_inp_bxresult          IN VARCHAR2,
                                      v_inp_bxuqualsubjects   IN VARCHAR2,
                                      v_inp_scaleamount       IN NUMBER,
                                      v_inp_operuserid        IN VARCHAR2,
                                      v_inp_invokeobj         IN VARCHAR2);

  /*=============================================================================
  
     包：
       pkg_qa_ld(qa逻辑细节包)
  
     函数名:
       Qa质检报告报告级质检细节表修改
  
     入参:
       v_inp_qarepid            :  Qa质检报告Id
       v_inp_compid             :  企业Id
       v_inp_yyresult           :  样衣结果
       v_inp_yyunqualsubjects   :  样衣不合格项
       v_inp_mflresult          :  面辅料结果
       v_inp_mflunqualsubjects  :  面辅料不合格项
       v_inp_gyresult           :  工艺结果
       v_inp_gyunqualsubjects   :  工艺不合格项
       v_inp_bxresult           :  版型结果
       v_inp_bxuqualsubjects    :  版型不合格项
       v_inp_scaleamount        :  度尺件数
       v_inp_operuserid         :  操作人Id
       v_inp_invokeobj          :  调用对象
  
     版本:
       2022-10-12_zc314 : Qa质检报告报告级质检细节表修改
  
  ==============================================================================*/
  PROCEDURE p_upd_qarepcheckdetaildim(v_inp_qarepid           IN VARCHAR2,
                                      v_inp_compid            IN VARCHAR2,
                                      v_inp_yyresult          IN VARCHAR2,
                                      v_inp_yyunqualsubjects  IN VARCHAR2,
                                      v_inp_mflresult         IN VARCHAR2,
                                      v_inp_mflunqualsubjects IN VARCHAR2,
                                      v_inp_gyresult          IN VARCHAR2,
                                      v_inp_gyunqualsubjects  IN VARCHAR2,
                                      v_inp_bxresult          IN VARCHAR2,
                                      v_inp_bxuqualsubjects   IN VARCHAR2,
                                      v_inp_scaleamount       IN NUMBER,
                                      v_inp_operuserid        IN VARCHAR2,
                                      v_inp_invokeobj         IN VARCHAR2);

  /*=============================================================================
  
     包：
       pkg_qa_ld(qa逻辑细节包)
  
     函数名:
       获取 Qa质检报告Sku维度表新增数据 Sql
  
     入参:
       v_inp_invokeobj : 调用对象
  
     版本:
       2022-10-12_zc314 : 获取 Qa质检报告Sku维度表新增数据 Sql
  
  ==============================================================================*/
  FUNCTION f_get_qarepskudiminsdata_sql(v_inp_invokeobj IN VARCHAR2)
    RETURN CLOB;

  /*=============================================================================
  
     包：
       pkg_qa_ld(qa逻辑细节包)
  
     函数名:
       获取 Qa质检报告Sku级汇总数字相关数据 Sql
  
     入参:
       v_inp_invokeobj : 调用对象
  
     版本:
       2022-10-12_zc314 : 获取 Qa质检报告Sku级汇总数字相关数据 Sql
  
  ==============================================================================*/
  FUNCTION f_get_qarepskudimsumdata_sql(v_inp_invokeobj IN VARCHAR2)
    RETURN CLOB;

  /*=============================================================================
  
     包：
       pkg_qa_ld(qa逻辑细节包)
  
     函数名:
       获取 Qa已检列表Sku维度已到仓返工次数 Sql
  
     入参:
       v_inp_invokeobj : 调用对象
  
     版本:
       2022-10-12_zc314 : 获取 Qa已检列表Sku维度已到仓返工次数 Sql
  
  ==============================================================================*/
  FUNCTION f_get_asnbarcodereprocessingnum_sql(v_inp_invokeobj IN VARCHAR2)
    RETURN CLOB;

  /*=============================================================================
  
     包：
       pkg_qa_ld(qa逻辑细节包)
  
     函数名:
       Qa质检报告获取 AsnId,GooId,OrderId Sql
  
     入参:
       v_inp_invokeobj : 调用对象
  
     版本:
       2022-10-12_zc314 : Qa质检报告获取 AsnId,GooId,OrderId Sql
  
  ==============================================================================*/
  FUNCTION f_get_qarepasngooorder_sql(v_inp_invokeobj IN VARCHAR2)
    RETURN CLOB;

  /*=============================================================================
  
     包：
       pkg_qa_ld(qa逻辑细节包)
  
     过程名:
       批量录入合格质检报告信息更新
  
     入参:
       v_inp_qarepids     :  质检报告Id，多值，用【分号】分隔
       v_inp_compid       :  企业Id
       v_inp_checkresult  :  质检结果
       v_inp_checkdate    :  查货日期
       v_inp_checkuserids :  查货员
       v_inp_curuserid    :  当前操作人Id
       v_inp_invokeobj    :  调用对象
  
     版本:
       2022-10-19_zc314 : 批量录入合格质检报告信息更新
  
  ==============================================================================*/
  PROCEDURE p_upd_batchqarepinfo(v_inp_qarepids     IN VARCHAR2,
                                 v_inp_compid       IN VARCHAR2,
                                 v_inp_checkresult  IN VARCHAR2,
                                 v_inp_checkdate    IN DATE,
                                 v_inp_checkuserids IN VARCHAR2,
                                 v_inp_curuserid    IN VARCHAR2,
                                 v_inp_invokeobj    IN VARCHAR2);

  /*=============================================================================
  
     包：
       pkg_qa_ld(qa逻辑细节包)
  
     函数名:
       获取Qa质检报告更新首抽件数Sql
  
     入参:
       v_inp_qarepids          :  质检报告Id，多值，用【分号】分隔
       v_inp_compid            :  企业Id
       v_inp_firstcheckamount  :  首抽件数
       v_inp_curuserid         :  当前操作人Id
       v_inp_invokeobj         :  调用对象
  
     版本:
       2022-10-19_zc314 : 获取Qa质检报告更新首抽件数Sql
  
  ==============================================================================*/
  PROCEDURE p_upd_qarepfirstsamplingamount(v_inp_qarepids         IN VARCHAR2,
                                           v_inp_compid           IN VARCHAR2,
                                           v_inp_firstcheckamount IN NUMBER,
                                           v_inp_curuserid        IN VARCHAR2,
                                           v_inp_invokeobj        IN VARCHAR2);

  /*=============================================================================
  
     包：
       pkg_qa_ld(qa逻辑细节包)
  
     过程名:
       更新 Qa质检报告 Sku维度表所有质检结果
  
     入参:
       v_inp_qarepids          :  质检报告Id，多值，用【分号】分隔
       v_inp_compid            :  企业Id
       v_inp_skucheckresult    :  质检结果
       v_inp_curuserid         :  当前操作人Id
       v_inp_invokeobj         :  调用对象
  
     版本:
       2022-10-20_zc314 : 更新 Qa质检报告 Sku维度表所有质检结果
  
  ==============================================================================*/
  PROCEDURE p_upd_qarepskudimcheckresult(v_inp_qarepids       IN VARCHAR2,
                                         v_inp_compid         IN VARCHAR2,
                                         v_inp_skucheckresult IN VARCHAR2,
                                         v_inp_curuserid      IN VARCHAR2,
                                         v_inp_invokeobj      IN VARCHAR2);

  /*=============================================================================
  
     包：
       pkg_qa_ld(qa逻辑细节包)
  
     过程名:
       Qa质检报告编辑页面--Qa质检报告表更新
  
     入参:
       v_inp_qarepid               :  质检报告Id
       v_inp_compid                :  企业Id
       v_inp_checkers              :  查货员
       v_inp_checkdate             :  质检时间
       v_inp_checkresult           :  质检结果
       v_inp_problemclassification :  问题分类
       v_inp_problemdescription    :  问题描述
       v_inp_reviewcomments        :  审核意见
       v_inp_memo                  :  备注
       v_inp_qualattachment        :  质检附件
       v_inp_reviewattachment      :  批复附件
       v_inp_curuserid             :  当前操作人Id
       v_inp_invokeobj             :  调用对象
  
     版本:
       2022-10-20_zc314 : Qa质检报告编辑页面--Qa质检报告表更新
  
  ==============================================================================*/
  PROCEDURE p_upd_qarepinfoinreppage(v_inp_qarepid               IN VARCHAR2,
                                     v_inp_compid                IN VARCHAR2,
                                     v_inp_checkers              IN VARCHAR2,
                                     v_inp_checkdate             IN DATE,
                                     v_inp_checkresult           IN VARCHAR2,
                                     v_inp_problemclassification IN VARCHAR2,
                                     v_inp_problemdescription    IN VARCHAR2,
                                     v_inp_reviewcomments        IN VARCHAR2,
                                     v_inp_memo                  IN VARCHAR2,
                                     v_inp_qualattachment        IN VARCHAR2,
                                     v_inp_reviewattachment      IN VARCHAR2,
                                     v_inp_curuserid             IN VARCHAR2,
                                     v_inp_invokeobj             IN VARCHAR2);

  /*=============================================================================
  
     包：
       pkg_qa_ld(qa逻辑细节包)
  
     过程名:
       Qa质检报告编辑页面--Qa质检报告数字维度表更新
  
     入参:
       v_inp_qarepid               :  Qa质检报告Id
       v_inp_compid                :  企业Id
       v_inp_firstsamplingamount   :  首抽件数
       v_inp_addsamplingamount     :  加抽件数
       v_inp_unqualsamplingamount  :  不合格件数
       v_inp_curuserid             :  当前操作人Id
       v_inp_invokeobj             :  调用对象
  
     版本:
       2022-10-20_zc314 : Qa质检报告编辑页面--Qa质检报告数字维度表更新
  
  ==============================================================================*/
  PROCEDURE p_upd_qarepnumdiminreppage(v_inp_qarepid              IN VARCHAR2,
                                       v_inp_compid               IN VARCHAR2,
                                       v_inp_firstsamplingamount  IN NUMBER,
                                       v_inp_addsamplingamount    IN NUMBER,
                                       v_inp_unqualsamplingamount IN NUMBER,
                                       v_inp_curuserid            IN VARCHAR2,
                                       v_inp_invokeobj            IN VARCHAR2);

  /*=============================================================================
  
     包：
       pkg_qa_ld(qa逻辑细节包)
  
     过程名:
       Qa质检报告编辑页面--Qa质检报告数字维度表更新
  
     入参:
       v_inp_qarepid          :  Qa质检报告Id
       v_inp_compid           :  企业Id
       v_inp_yyresult         :  样衣结果
       v_inp_yyuqualsubjects  :  样衣不合格项
       v_inp_mflresult        :  面辅料结果
       v_inp_mfluqualsubjects :  面辅料不合格项
       v_inp_gyresult         :  工艺结果
       v_inp_gyuqualsubjects  :  工艺不合格项
       v_inp_bxresult         :  版型结果
       v_inp_bxuqualsubjects  :  版型不合格项
       v_inp_scaleamount      :  度尺件数
       v_inp_curuserid        :  当前操作人Id
       v_inp_invokeobj        :  调用对象
  
     版本:
       2022-10-20_zc314 : Qa质检报告编辑页面--Qa质检报告数字维度表更新
  
  ==============================================================================*/
  PROCEDURE p_upd_qarepcheckdetaildiminreppage(v_inp_qarepid          IN VARCHAR2,
                                               v_inp_compid           IN VARCHAR2,
                                               v_inp_yyresult         IN VARCHAR2,
                                               v_inp_yyuqualsubjects  IN VARCHAR2,
                                               v_inp_mflresult        IN VARCHAR2,
                                               v_inp_mfluqualsubjects IN VARCHAR2,
                                               v_inp_gyresult         IN VARCHAR2,
                                               v_inp_gyuqualsubjects  IN VARCHAR2,
                                               v_inp_bxresult         IN VARCHAR2,
                                               v_inp_bxuqualsubjects  IN VARCHAR2,
                                               v_inp_scaleamount      IN NUMBER,
                                               v_inp_curuserid        IN VARCHAR2,
                                               v_inp_invokeobj        IN VARCHAR2);

  /*=============================================================================
  
     包：
       pkg_qa_ld(QA逻辑细节包)
  
     过程名:
       质检报告问题分类字段更新（异常处理配置表删除前执行）
  
     入参:
       v_inp_abnormaldtlcfgid  :  异常处理配置表Id
       v_inp_compid            :  企业Id
  
     版本:
       2022-10-21_ZC314 : 质检报告问题分类字段更新（异常处理配置表删除前执行）
  
  ==============================================================================*/
  PROCEDURE p_upd_qarepprobclassbfabdtlcfgdel(v_inp_abnormaldtlcfgid IN VARCHAR2,
                                              v_inp_compid           IN VARCHAR2);

  /*=============================================================================
  
     包：
       pkg_qa_ld(qa逻辑细节包)
  
     过程名:
       维护不合格明细-添加明细
  
     入参:
       v_inp_qarepid         :  Qa质检报告Id
       v_inp_asnid           :  Asn单号
       v_inp_gooid           :  商品档案编号
       v_inp_barcode         :  条码
       v_inp_compid          :  企业Id
       v_inp_skucheckresult  :  Sku质检结果
       v_inp_curuserid       :  当前操作人Id
       v_inp_invokeobj       :  调用对象
  
     版本:
       2022-10-21_zc314 : 维护不合格明细-添加明细
  
  ==============================================================================*/
  PROCEDURE p_upd_qarepskudimcheckresulttonp(v_inp_qarepid        IN VARCHAR2,
                                             v_inp_asnid          IN VARCHAR2,
                                             v_inp_gooid          IN VARCHAR2,
                                             v_inp_barcode        IN VARCHAR2,
                                             v_inp_compid         IN VARCHAR2,
                                             v_inp_skucheckresult IN VARCHAR2,
                                             v_inp_curuserid      IN VARCHAR2,
                                             v_inp_invokeobj      IN VARCHAR2);

  /*=============================================================================
  
     包：
       pkg_qa_ld(qa逻辑细节包)
  
     过程名:
       维护不合格明细-添加明细
  
     入参:
       v_inp_qarepid          :  质检报告Id
       v_inp_compid           :  企业Id
       v_inp_asnid            :  asn单号
       v_inp_gooid            :  商品档案编码
       v_inp_barcode          :  条码
       v_inp_defectiveamount  :  质检次品数量
       v_inp_washlessamount   :  洗水减数
       v_inp_otherlessamount  :  其他减数
       v_inp_curuserid        :  当前操作人Id
       v_inp_invokeobj        :  调用对象
  
     版本:
       2022-10-21_zc314 : 维护不合格明细-添加明细
  
  ==============================================================================*/
  PROCEDURE p_upd_qualdecrerela(v_inp_qarepid         IN VARCHAR2,
                                v_inp_compid          IN VARCHAR2,
                                v_inp_asnid           IN VARCHAR2,
                                v_inp_gooid           IN VARCHAR2,
                                v_inp_barcode         IN VARCHAR2,
                                v_inp_defectiveamount IN NUMBER,
                                v_inp_washlessamount  IN NUMBER,
                                v_inp_otherlessamount IN NUMBER,
                                v_inp_curuserid       IN VARCHAR2,
                                v_inp_invokeobj       IN VARCHAR2);

  /*=============================================================================
  
     包：
       pkg_qa_ld(qa逻辑细节包)
  
     过程名:
       获取报告提交校验值Sql
  
     入参:
       v_inp_invokeobj   :  调用对象
  
     版本:
       2022-10-24_zc314 : 获取报告提交校验值Sql
  
  ==============================================================================*/
  FUNCTION f_get_commitchecksql(v_inp_invokeobj IN VARCHAR2) RETURN CLOB;

  /*=============================================================================
  
     包：
       pkg_qa_ld(qa逻辑细节包)
  
     函数名:
       更新质检报告下Sku质检结果
  
     入参:
       v_inp_qarepid         :  Qa质检报告Id
       v_inp_compid          :  企业Id
       v_inp_skucheckresult  :  Asn状态
       v_inp_curuserid       :  当前操作人Id
       v_inp_invokeobj       :  调用对象
  
     版本:
       2022-10-24_zc314 : 更新质检报告下Sku质检结果
       2022-11-03_zc314 : 新增Sku质检结果字段用于适配质检报告通过场景（需求变更）
  
  ==============================================================================*/
  PROCEDURE p_upd_allskucheckresult(v_inp_qarepid        IN VARCHAR2,
                                    v_inp_compid         IN VARCHAR2,
                                    v_inp_skucheckresult IN VARCHAR2,
                                    v_inp_curuserid      IN VARCHAR2,
                                    v_inp_invokeobj      IN VARCHAR2);

  /*=============================================================================
  
     包：
       pkg_qa_ld(qa逻辑细节包)
  
     函数名:
       Qa质检报告提交更新
  
     入参:
       v_inp_qarepid      :  Qa质检报告Id
       v_inp_compid       :  企业Id
       v_inp_operuserid   :  操作人Id
       v_inp_invokeobj    :  调用对象
  
     版本:
       2022-10-12_zc314 : Qa质检报告提交更新
  
  ==============================================================================*/
  PROCEDURE p_upd_qarepcommit(v_inp_qarepid   IN VARCHAR2,
                              v_inp_compid    IN VARCHAR2,
                              v_inp_curuserid IN VARCHAR2,
                              v_inp_invokeobj IN VARCHAR2);

  /*=============================================================================
  
     包：
       pkg_qa_ld(qa逻辑细节包)
  
     函数名:
       通过质检报告Id更新asn状态
  
     入参:
       v_inp_qarepid      :  Qa质检报告Id
       v_inp_compid       :  企业Id
       v_inp_asnstatus    :  Asn状态
       v_inp_curuserid    :  当前操作人Id
       v_inp_invokeobj    :  调用对象
  
     版本:
       2022-10-24_zc314 : 通过质检报告Id更新asn状态
  
  ==============================================================================*/
  PROCEDURE p_upd_qarepasnstatusbyqarepid(v_inp_qarepid   IN VARCHAR2,
                                          v_inp_compid    IN VARCHAR2,
                                          v_inp_asnstatus IN VARCHAR2,
                                          v_inp_curuserid IN VARCHAR2,
                                          v_inp_invokeobj IN VARCHAR2);

  /*=============================================================================
  
     包：
       pkg_qa_ld(qa逻辑细节包)
  
     过程名:
       更新 Qa质检报告 Sku不合格数量
  
     入参:
       v_inp_qarepid     :  Qa质检报告Id
       v_inp_compid      :  企业id
       v_inp_asnid       :  Asn单号
       v_inp_gooid       :  商品档案编号
       v_inp_barcode     :  条码
       v_inp_curuserid   :  当前操作人Id
       v_inp_invokeobj   :  调用对象
  
     版本:
       2022-10-25_zc314 : 更新 Qa质检报告 Sku不合格数量
       2022-10-31_zc314 : 修改更新维度至Sku
  
  ==============================================================================*/
  PROCEDURE p_upd_qarepskuunqualamount(v_inp_qarepid   IN VARCHAR2,
                                       v_inp_compid    IN VARCHAR2,
                                       v_inp_asnid     IN VARCHAR2,
                                       v_inp_gooid     IN VARCHAR2,
                                       v_inp_barcode   IN VARCHAR2,
                                       v_inp_curuserid IN VARCHAR2,
                                       v_inp_invokeobj IN VARCHAR2);

  /*=============================================================================
  
     包：
       pkg_qa_ld(qa逻辑细节包)
  
     过程名:
       更新 Qa质检报告不合格数量
  
     入参:
       v_inp_qarepid     :  Qa质检报告Id
       v_inp_compid      :  企业id
       v_inp_curuserid   :  当前操作人Id
       v_inp_invokeobj   :  调用对象
  
     版本:
       2022-10-25_zc314 : 更新 Qa质检报告不合格数量
  
  ==============================================================================*/
  PROCEDURE p_upd_qarepunqualamount(v_inp_qarepid   IN VARCHAR2,
                                    v_inp_compid    IN VARCHAR2,
                                    v_inp_curuserid IN VARCHAR2,
                                    v_inp_invokeobj IN VARCHAR2);

  /*=============================================================================
  
     包：
       pkg_qa_ld(qa逻辑细节包)
  
     过程名:
       更新 Qa质检报告修改人修改时间
  
     入参:
       v_inp_qarepid     :  Qa质检报告Id
       v_inp_compid      :  企业id
       v_inp_curuserid   :  修改人Id
       v_inp_curtime     :  修改时间
       v_inp_invokeobj   :  调用对象
  
     版本:
       2022-10-25_zc314 : 更新 Qa质检报告修改人修改时间
  
  ==============================================================================*/
  PROCEDURE p_upd_qarepupdateidtime(v_inp_qarepid   IN VARCHAR2,
                                    v_inp_compid    IN VARCHAR2,
                                    v_inp_curuserid IN VARCHAR2,
                                    v_inp_curtime   IN DATE,
                                    v_inp_invokeobj IN VARCHAR2);

  /*=============================================================================
  
     包：
       pkg_qa_ld(qa逻辑细节包)
  
     过程名:
       更新 Qa质检报告质检减数
  
     入参:
       v_inp_qarepid     :  Qa质检报告Id
       v_inp_compid      :  企业id
       v_inp_curuserid   :  当前操作人Id
       v_inp_invokeobj   :  调用对象
  
     版本:
       2022-10-25_zc314 : 更新 Qa质检报告质检减数
  
  ==============================================================================*/
  PROCEDURE p_upd_qarepdecreamount(v_inp_qarepid   IN VARCHAR2,
                                   v_inp_compid    IN VARCHAR2,
                                   v_inp_curuserid IN VARCHAR2,
                                   v_inp_invokeobj IN VARCHAR2);

  /*=============================================================================
  
     包：
       pkg_qa_ld(qa逻辑细节包)
  
     过程名:
       校验Qa质检报告是否重复进行质检报告审核
  
     入参:
       v_inp_qarepid    :  asn编号
       v_inp_compid     :  企业id
       v_inp_invokeobj  :  调用对象
  
     版本:
       2022-10-26_zc314 : 校验Qa质检报告是否重复进行质检报告审核
  
  ==============================================================================*/
  PROCEDURE p_check_qareprepeatreview(v_inp_qarepid   IN VARCHAR2,
                                      v_inp_compid    IN VARCHAR2,
                                      v_inp_invokeobj IN VARCHAR2);

  /*=============================================================================
  
     包：
       pkg_qa_ld(qa逻辑细节包)
  
     函数名:
       Qa质检报告级审核
  
     入参:
       v_inp_qarepid         :  Qa质检报告Id
       v_inp_compid          :  企业Id
       v_inp_repstatus       :  质检报告状态
       v_inp_processingtype  :  质检报告处理结果
       v_inp_curuserid       :  操作人Id
       v_inp_invokeobj       :  调用对象
  
     版本:
       2022-10-31_zc314 : Qa质检报告审核更新
       2022-12-03_zc314 : 增加质检处理类型
  
  ==============================================================================*/
  PROCEDURE p_upd_qarepreview(v_inp_qarepid        IN VARCHAR2,
                              v_inp_compid         IN VARCHAR2,
                              v_inp_repstatus      IN VARCHAR2,
                              v_inp_processingtype IN VARCHAR2,
                              v_inp_curuserid      IN VARCHAR2,
                              v_inp_invokeobj      IN VARCHAR2);

  /*=============================================================================
  
     包：
       pkg_qa_ld(qa逻辑细节包)
  
     函数名:
       Qa质检报告Sku级审核
  
     入参:
       v_inp_qarepid      :  Qa质检报告Id
       v_inp_compid       :  企业Id
       v_inp_curuserid    :  操作人Id
       v_inp_invokeobj    :  调用对象
  
     版本:
       2022-10-31_zc314 : Qa质检报告Sku级审核更新
  
  ==============================================================================*/
  PROCEDURE p_upd_qarepskureview(v_inp_qarepid   IN VARCHAR2,
                                 v_inp_compid    IN VARCHAR2,
                                 v_inp_curuserid IN VARCHAR2,
                                 v_inp_invokeobj IN VARCHAR2);

  /*=============================================================================
  
     包：
       pkg_qa_ld(qa逻辑细节包)
  
     函数名:
       更新质检报告Sku结束时间
  
     入参:
       v_inp_qarepid         :  Qa质检报告Id
       v_inp_compid          :  企业Id
       v_inp_asnid           :  AsnId
       v_inp_gooid           :  商品档案编号
       v_inp_barcode         :  条码
       v_inp_qualfinishtime  :  质检结束时间
       v_inp_curuserid       :  操作人Id
       v_inp_invokeobj       :  调用对象
  
     版本:
       2022-10-26_zc314 : 更新质检报告Sku结束时间
  
  ==============================================================================*/
  PROCEDURE p_upd_qarepskuqualfinishtime(v_inp_qarepid        IN VARCHAR2,
                                         v_inp_compid         IN VARCHAR2,
                                         v_inp_asnid          IN VARCHAR2,
                                         v_inp_gooid          IN VARCHAR2,
                                         v_inp_barcode        IN VARCHAR2,
                                         v_inp_qualfinishtime IN DATE,
                                         v_inp_curuserid      IN VARCHAR2,
                                         v_inp_invokeobj      IN VARCHAR2);

  /*=============================================================================
  
     包：
       pkg_qa_ld(qa逻辑细节包)
  
     函数名:
       更新质检报告处理类型，处理结果
  
     入参:
       v_inp_qarepid           :  Qa质检报告Id
       v_inp_compid            :  企业Id
       v_inp_processingtype    :  AsnId
       v_inp_processingresult  :  商品档案编号
       v_inp_curuserid         :  操作人Id
       v_inp_invokeobj         :  调用对象
  
     版本:
       2022-10-26_zc314 : 更新质检报告处理类型，处理结果
  
  ==============================================================================*/
  PROCEDURE p_upd_qarepprocessingrela(v_inp_qarepid          IN VARCHAR2,
                                      v_inp_compid           IN VARCHAR2,
                                      v_inp_processingtype   IN VARCHAR2,
                                      v_inp_processingresult IN VARCHAR2,
                                      v_inp_curuserid        IN VARCHAR2,
                                      v_inp_invokeobj        IN VARCHAR2);

  /*=============================================================================
  
     包：
       pkg_qa_ld(qa逻辑细节包)
  
     函数名:
       质检报告主表整批处理时，更新质检报告Sku处理结果，质检结束时间
  
     入参:
       v_inp_qarepid           :  Qa质检报告Id
       v_inp_compid            :  企业Id
       v_inp_processingresult  :  处理结果
       v_inp_curuserid         :  操作人Id
       v_inp_invokeobj         :  调用对象
  
     版本:
       2022-10-26_zc314 : 质检报告主表整批处理时，更新质检报告Sku处理结果，质检结束时间
  
  ==============================================================================*/
  PROCEDURE p_upd_qarepskuprocesswbrela(v_inp_qarepid          IN VARCHAR2,
                                        v_inp_compid           IN VARCHAR2,
                                        v_inp_processingresult IN VARCHAR2,
                                        v_inp_curuserid        IN VARCHAR2,
                                        v_inp_invokeobj        IN VARCHAR2);

  /*=============================================================================
  
     包：
       pkg_qa_ld(qa逻辑细节包)
  
     函数名:
       更新质检报告Sku处理结果，质检结束时间，状态
  
     入参:
       v_inp_qarepid           :  Qa质检报告Id
       v_inp_compid            :  企业Id
       v_inp_asnid             :  Asn单号
       v_inp_gooid             :  商品档案编号
       v_inp_barcode           :  条码
       v_inp_processingresult  :  处理结果
       v_inp_curuserid         :  操作人Id
       v_inp_invokeobj         :  调用对象
  
     版本:
       2022-10-27_zc314 : 更新质检报告Sku处理结果，质检结束时间，状态
  
  ==============================================================================*/
  PROCEDURE p_upd_qarepskuprocesswbrelawithsku(v_inp_qarepid          IN VARCHAR2,
                                               v_inp_compid           IN VARCHAR2,
                                               v_inp_asnid            IN VARCHAR2,
                                               v_inp_gooid            IN VARCHAR2,
                                               v_inp_barcode          IN VARCHAR2,
                                               v_inp_processingresult IN VARCHAR2,
                                               v_inp_curuserid        IN VARCHAR2,
                                               v_inp_invokeobj        IN VARCHAR2);

  /*=============================================================================
  
     包：
       pkg_qa_ld(qa逻辑细节包)
  
     函数名:
       更新质检报告状态
  
     入参:
       v_inp_qarepid           :  Qa质检报告Id
       v_inp_compid            :  企业Id
       v_inp_status            :  质检报告状态
       v_inp_curuserid         :  操作人Id
       v_inp_invokeobj         :  调用对象
  
     版本:
       2022-10-27_zc314 : 更新质检报告处理类型，处理结果
  
  ==============================================================================*/
  PROCEDURE p_upd_qarepstatus(v_inp_qarepid   IN VARCHAR2,
                              v_inp_compid    IN VARCHAR2,
                              v_inp_status    IN VARCHAR2,
                              v_inp_curuserid IN VARCHAR2,
                              v_inp_invokeobj IN VARCHAR2);

  /*=============================================================================
  
     包：
       pkg_qa_ld(qa逻辑细节包)
  
     函数名:
       获取返工Sku Sql
  
     入参:
       v_inp_invokeobj : 调用对象
  
     版本:
       2022-10-28_zc314 : 获取返工Sku Sql
  
  ==============================================================================*/
  FUNCTION f_get_reworkskusql(v_inp_invokeobj IN VARCHAR2) RETURN CLOB;

  /*=============================================================================
  
     包：
       pkg_qa_ld(qa逻辑细节包)
  
     过程名:
       更新 Qa质检报告待返工数量
  
     入参:
       v_inp_qarepids            :  Qa质检报告Id，多值，用分号分隔
       v_inp_compid              :  企业id
       v_inp_prereprocessingnum  :  待返工数量
       v_inp_curuserid           :  当前操作人Id
       v_inp_invokeobj           :  调用对象
  
     版本:
       2022-10-28_zc314 : 更新 Qa质检报告待返工数量
  
  ==============================================================================*/
  PROCEDURE p_upd_qarepreprocessingsumamount(v_inp_qarepids           IN VARCHAR2,
                                             v_inp_compid             IN VARCHAR2,
                                             v_inp_prereprocessingnum IN NUMBER,
                                             v_inp_curuserid          IN VARCHAR2,
                                             v_inp_invokeobj          IN VARCHAR2);

  /*=============================================================================
  
     包：
       pkg_qa_ld(qa逻辑细节包)
  
     过程名:
       更新 Qa质检报告待返工数量+1
  
     入参:
       v_inp_qarepids   :  Qa质检报告Id，多值，用分号分隔
       v_inp_compid     :  企业id
       v_inp_curuserid  :  当前操作人Id
       v_inp_invokeobj  :  调用对象
  
     版本:
       2022-11-01_zc314 : 更新 Qa质检报告待返工数量+1
  
  ==============================================================================*/
  PROCEDURE p_upd_qarepreprocessingsumamountaddone(v_inp_qarepids  IN VARCHAR2,
                                                   v_inp_compid    IN VARCHAR2,
                                                   v_inp_curuserid IN VARCHAR2,
                                                   v_inp_invokeobj IN VARCHAR2);

  /*=============================================================================
  
     包：
       pkg_qa_ld(qa逻辑细节包)
  
     过程名:
       更新 Qa质检报告数据汇总相关
  
     入参:
       v_inp_qarepid      : 质检报告Id
       v_inp_compid       : 企业Id
       v_inp_curuserid    : 当前操作人
       v_inp_invokeobj    : 调用对象
  
     版本:
       2022-10-31_zc314 : 更新 Qa质检报告数据汇总相关
  
  ==============================================================================*/
  PROCEDURE p_upd_qarepresumamountrela(v_inp_qarepid   IN VARCHAR2,
                                       v_inp_compid    IN VARCHAR2,
                                       v_inp_curuserid IN VARCHAR2,
                                       v_inp_invokeobj IN VARCHAR2);

  /*=============================================================================
  
     包：
       pkg_qa_ld(qa逻辑细节包)
  
     函数名:
       更新质检报告通过Sku状态为已完成，Sku结束时间为当前时间
  
     入参:
       v_inp_qarepid    :  Qa质检报告Id
       v_inp_compid     :  企业Id
       v_inp_curuserid  :  操作人Id
       v_inp_invokeobj  :  调用对象
  
     版本:
       2022-10-31_zc314 : 更新质检报告通过Sku状态为已完成，
                          Sku结束时间为当前时间
  
  ==============================================================================*/
  PROCEDURE p_upd_qareppsskustatusfinishtime(v_inp_qarepid   IN VARCHAR2,
                                             v_inp_compid    IN VARCHAR2,
                                             v_inp_curuserid IN VARCHAR2,
                                             v_inp_invokeobj IN VARCHAR2);

  /*=============================================================================
  
     包：
       pkg_qa_ld(qa逻辑细节包)
  
     函数名:
       维护不合格处理主表更新逻辑
  
     入参:
       v_inp_qarepid           :  Qa质检报告Id
       v_inp_compid            :  企业Id
       v_inp_processingtype    :  处理类型
       v_inp_processingresult  :  处理结果
       v_inp_curuserid         :  操作人Id
       v_inp_invokeobj         :  调用对象
  
     版本:
       2022-10-31_zc314 : 维护不合格处理主表更新逻辑
  
  ==============================================================================*/
  PROCEDURE p_upd_qarepmantenancemas(v_inp_qarepid          IN VARCHAR2,
                                     v_inp_compid           IN VARCHAR2,
                                     v_inp_processingtype   IN VARCHAR2,
                                     v_inp_processingresult IN VARCHAR2,
                                     v_inp_curuserid        IN VARCHAR2,
                                     v_inp_invokeobj        IN VARCHAR2);

  /*=============================================================================
  
     包：
       pkg_qa_ld(qa逻辑细节包)
  
     函数名:
       维护不合格处理=整批处理，更新报告Sku处理类型，处理结果，状态，结束时间
  
     入参:
       v_inp_qarepid           :  Qa质检报告Id
       v_inp_compid            :  企业Id
       v_inp_processingresult  :  处理结果
       v_inp_curuserid         :  操作人Id
       v_inp_invokeobj         :  调用对象
  
     版本:
       2022-10-31_zc314 : 维护不合格处理=整批处理，
                          更新报告Sku处理类型，处理结果，状态，结束时间
  
  ==============================================================================*/
  PROCEDURE p_upd_qarepmantenancewbsku(v_inp_qarepid          IN VARCHAR2,
                                       v_inp_compid           IN VARCHAR2,
                                       v_inp_processingresult IN VARCHAR2,
                                       v_inp_curuserid        IN VARCHAR2,
                                       v_inp_invokeobj        IN VARCHAR2);

  /*=============================================================================
  
     包：
       pkg_qa_ld(qa逻辑细节包)
  
     过程名:
       待检任务-删除，删除质检报告关联信息
  
     入参:
       v_inp_qarepid    :  Qa质检报告Id
       v_inp_compid     :  企业id
       v_inp_invokeobj  :  调用对象
  
     版本:
       2022-11-01_zc314 : 待检任务-删除，删除质检报告关联信息
  
  ==============================================================================*/
  PROCEDURE p_del_qareprela(v_inp_qarepid   IN VARCHAR2,
                            v_inp_compid    IN VARCHAR2,
                            v_inp_invokeobj IN VARCHAR2);

  /*=============================================================================
  
     包：
       pkg_qa_ld(qa逻辑细节包)
  
     过程名:
       待检任务-更新优先级
  
     入参:
       v_inp_qarepid      :  质检报告Id
       v_inp_compid       :  企业Id
       v_inp_ispriority   :  是否优先
       v_inp_curuserid    :  当前操作人Id
       v_inp_invokeobj    :  调用对象
  
     版本:
       2022-11-01_zc314 : 待检任务-更新优先级
  
  ==============================================================================*/
  PROCEDURE p_upd_qarepispriority(v_inp_qarepid    IN VARCHAR2,
                                  v_inp_compid     IN VARCHAR2,
                                  v_inp_ispriority IN NUMBER,
                                  v_inp_curuserid  IN VARCHAR2,
                                  v_inp_invokeobj  IN VARCHAR2);

  /*=============================================================================
  
     包：
       pkg_qa_ld(qa逻辑细节包)
  
     过程名:
       通过Sku 更新质检报告处理结果
  
     入参:
       v_inp_qarepid     :  质检报告Id
       v_inp_compid      :  企业id
       v_inp_operuserid  :  操作人Id
       v_inp_invokeobj   :  调用对象
  
     版本:
       2022-11-08_zc314 : 通过Sku 更新质检报告处理结果
  
  ==============================================================================*/
  PROCEDURE p_upd_qarepprocessresultbysku(v_inp_qarepid    IN VARCHAR2,
                                          v_inp_compid     IN VARCHAR2,
                                          v_inp_operuserid IN VARCHAR2,
                                          v_inp_invokeobj  IN VARCHAR2);

  /*=============================================================================
  
     包：
       pkg_qa_ld(qa逻辑细节包)
  
     函数名:
       刷新报告下Asn传输结果
  
     入参:
       v_inp_qarepid     :  Qa质检报告Id
       v_inp_compid      :  企业Id
       v_inp_asnid       :  Asn单号
       v_inp_operuserid  :  当前操作人Id
       v_inp_invokeobj   :  调用对象
  
     版本:
       2022-12-01_zc314 : 刷新报告下Asn传输结果
  
  ==============================================================================*/
  PROCEDURE p_refresh_qareptransresult(v_inp_qarepid    IN VARCHAR2,
                                       v_inp_compid     IN VARCHAR2,
                                       v_inp_asnid      IN VARCHAR2,
                                       v_inp_operuserid IN VARCHAR2,
                                       v_inp_invokeobj  IN VARCHAR2);

  /*=============================================================================
  
     包：
       pkg_qa_ld(qa逻辑细节包)
  
     函数名:
       获取 Qa质检报告页面显示sql
  
     入参:
       v_inp_qarepid      :  Qa质检报告Id
       v_inp_compid       :  企业id
  
     返回值:
       Clob 类型，错误信息
  
     版本:
       2022-11-14_zc314 : 获取 Qa质检报告页面显示sql
  
  ==============================================================================*/
  FUNCTION f_get_qarepsql(v_inp_qarepid IN VARCHAR2,
                          v_inp_compid  IN VARCHAR2) RETURN CLOB;

  /*=============================================================================
  
     包：
       pkg_qa_ld(qa逻辑细节包)
  
     函数名:
       【消息提醒】构建“质检结果通知物流部”-头部消息
  
     入参:
       v_inp_qarepid       :  质检报告Id
       v_inp_compid        :  企业Id
       v_inp_checkresults  :  质检结果
       v_inp_curuserid     :  当前操作人Id
       v_inp_invokeobj     :  调用对象
  
     版本:
       2022-12-08_zc314 : 构建“质检结果通知物流部”-头部消息
  
  ==============================================================================*/
  FUNCTION f_message_genlogisticsheadmsg(v_inp_qarepid      IN VARCHAR2,
                                         v_inp_compid       IN VARCHAR2,
                                         v_inp_checkresults IN VARCHAR2 DEFAULT NULL,
                                         v_inp_curuserid    IN VARCHAR2,
                                         v_inp_invokeobj    IN VARCHAR2)
    RETURN CLOB;

  /*=============================================================================
  
     包：
       pkg_qa_ld(qa逻辑细节包)
  
     函数名:
       【消息提醒】构建“质检结果通知物流部”-剩余消息
  
     入参:
       v_inp_qarepid    :  质检报告Id
       v_inp_compid     :  企业Id
       v_inp_curuserid  :  当前操作人Id
       v_inp_invokeobj  :  调用对象
  
     版本:
       2022-12-08_zc314 : 构建“质检结果通知物流部”-剩余消息
  
  ==============================================================================*/
  FUNCTION f_message_genlogisticsrestmsg(v_inp_qarepid   IN VARCHAR2,
                                         v_inp_compid    IN VARCHAR2,
                                         v_inp_curuserid IN VARCHAR2,
                                         v_inp_invokeobj IN VARCHAR2)
    RETURN CLOB;

  /*=============================================================================
  
     包：
       pkg_qa_ld(qa逻辑细节包)
  
     函数名:
       获取不合格提示人相关信息
  
     入参:
       v_inp_qarepid    :  质检报告Id
       v_inp_compid     :  企业Id
       v_inp_curuserid  :  当前操作人Id
       v_inp_invokeobj  :  调用对象
  
     出参:
       Clob 类型， 不合格提示人相关信息
  
     版本:
       2022-12-12_ZC314 : 获取不合格提示人相关信息
  
  ==============================================================================*/
  FUNCTION f_message_unqualmetionrelauserinfo(v_inp_qarepid   IN VARCHAR2,
                                              v_inp_compid    IN VARCHAR2,
                                              v_inp_curuserid IN VARCHAR2,
                                              v_inp_invokeobj IN VARCHAR2)
    RETURN CLOB;

  /*=============================================================================
  
     包：
       pkg_qa_ld(qa逻辑细节包)
  
     函数名:
       获取不合格提示人相关信息
  
     入参:
       v_inp_qarepid    :  质检报告Id
       v_inp_invokeobj  :  调用对象
  
     出参:
       Clob 类型， 不合格提示人相关信息
  
     版本:
       2022-12-12_ZC314 : 获取不合格提示人相关信息
  
  ==============================================================================*/
  FUNCTION f_message_unqualmetionqarepinfo(v_inp_qarepid   IN VARCHAR2,
                                           v_inp_invokeobj IN VARCHAR2)
    RETURN CLOB;

  /*=============================================================================
  
     包：
       pkg_qa_lc(QA逻辑链包)
  
     过程名:
       根据质检报告获取已检消息的消息头
  
     入参:
       v_inp_qarepid    :  Qa质检报告Id
       v_inp_compid     :  企业Id
       v_inp_curuserid  :  当前操作人Id
       v_inp_invokeobj  :  调用对象
  
     版本:
       2022-12-12_ZC314 : 根据质检报告获取已检消息的消息头
  
  ==============================================================================*/
  FUNCTION f_message_getqualedheadinfobyqarep(v_inp_qarepid   IN VARCHAR2,
                                              v_inp_compid    IN VARCHAR2,
                                              v_inp_curuserid IN VARCHAR2,
                                              v_inp_invokeobj IN VARCHAR2)
    RETURN CLOB;

  /*=============================================================================
  
     包：
       pkg_qa_ld(QA逻辑细节包)
  
     函数名:
       获取已检信息
  
     入参:
       v_inp_qarepid      :  质检报告Id
       v_inp_transresult  :  质检传输结果
       v_inp_compid       :  企业Id
       v_inp_curuserid    :  当前操作人Id
       v_inp_invokeobj    :  调用对象
  
     版本:
       2022-12-13_zc314 : 获取已检信息
  
  ==============================================================================*/
  FUNCTION f_message_getqualedmsgbyqarep(v_inp_qarepid     IN VARCHAR2,
                                         v_inp_transresult IN VARCHAR2,
                                         v_inp_compid      IN VARCHAR2,
                                         v_inp_curuserid   IN VARCHAR2,
                                         v_inp_invokeobj   IN VARCHAR2)
    RETURN CLOB;

  /*=============================================================================
  
     包：
       pkg_qa_ld(qa逻辑细节包)
  
     过程名:
       qa消息配置表新增
  
     入参:
       v_inp_configcode   :  qa消息配置编码
       v_inp_configname   :  qa消息配置名称
       v_inp_keyurl       :  机器人key（url）
       v_inp_curuserid    :  操作人id
       v_inp_compid       :  企业id
       v_inp_invokeobj    :  调用对象
  
     版本:
       2022-12-08_zc314 : qa消息配置表新增
  
  ==============================================================================*/
  PROCEDURE p_msg_insqamsgconfig(v_inp_configcode IN VARCHAR2,
                                 v_inp_configname IN VARCHAR2,
                                 v_inp_keyurl     IN VARCHAR2,
                                 v_inp_curuserid  IN VARCHAR2,
                                 v_inp_compid     IN VARCHAR2,
                                 v_inp_invokeobj  IN VARCHAR2);

  /*=============================================================================
  
     包：
       pkg_qa_ld(qa逻辑细节包)
  
     过程名:
       qa消息配置表修改
  
     入参:
       v_inp_configcode   :  qa消息配置编码
       v_inp_configname   :  qa消息配置名称
       v_inp_keyurl       :  机器人key（url）
       v_inp_curuserid    :  操作人id
       v_inp_compid       :  企业id
       v_inp_invokeobj    :  调用对象
  
     版本:
       2022-12-08_zc314 : qa消息配置表修改
  
  ==============================================================================*/
  PROCEDURE p_msg_updqamsgconfig(v_inp_configcode IN VARCHAR2,
                                 v_inp_configname IN VARCHAR2,
                                 v_inp_keyurl     IN VARCHAR2,
                                 v_inp_curuserid  IN VARCHAR2,
                                 v_inp_compid     IN VARCHAR2,
                                 v_inp_invokeobj  IN VARCHAR2);

  /*=============================================================================
  
     包：
       pkg_qa_ld(qa逻辑细节包)
  
     过程名:
       Qa消息表新增
  
     入参:
       v_inp_configcode  :  qa消息配置编码
       v_inp_unqinfo     :  唯一信息
       v_inp_msgstatus   :  消息状态
       v_inp_msginfo     :  消息内容
       v_inp_curuserid   :  当前操作人Id
       v_inp_compid      :  企业Id
       v_inp_invokeobj   :  调用对象
  
     版本:
       2022-12-08_zc314 : Qa消息表新增
  
  ==============================================================================*/
  PROCEDURE p_msg_insqamsginfo(v_inp_configcode IN VARCHAR2,
                               v_inp_unqinfo    IN VARCHAR2,
                               v_inp_msgstatus  IN VARCHAR2,
                               v_inp_msgtype    IN VARCHAR2,
                               v_inp_msginfo    IN VARCHAR2,
                               v_inp_curuserid  IN VARCHAR2,
                               v_inp_compid     IN VARCHAR2,
                               v_inp_invokeobj  IN VARCHAR2);

  /*=============================================================================
  
     包：
       pkg_qa_ld(qa逻辑细节包)
  
     过程名:
       Qa消息表修改
  
     入参:
       v_inp_configcode  :  qa消息配置编码
       v_inp_unqinfo     :  唯一信息
       v_inp_msgstatus   :  消息状态
       v_inp_msgtype     :  消息类型
       v_inp_msginfo     :  消息内容
       v_inp_curuserid   :  当前操作人Id
       v_inp_compid      :  企业Id
       v_inp_invokeobj   :  调用对象
  
     版本:
       2022-12-08_zc314 : Qa消息表修改
  
  ==============================================================================*/
  PROCEDURE p_msg_updqamsginfo(v_inp_configcode IN VARCHAR2,
                               v_inp_unqinfo    IN VARCHAR2,
                               v_inp_msgstatus  IN VARCHAR2,
                               v_inp_msgtype    IN VARCHAR2,
                               v_inp_msginfo    IN VARCHAR2,
                               v_inp_curuserid  IN VARCHAR2,
                               v_inp_compid     IN VARCHAR2,
                               v_inp_invokeobj  IN VARCHAR2);

  /*=============================================================================
  
     包：
       pkg_qa_ld(qa逻辑细节包)
  
     函数名:
       【消息提醒】启停xxl_job特定执行参数任务
  
     入参:
       v_inp_triggerstatus  :  触发器状态 0-停用 1-启用
       v_inp_executorparam  :  执行参数
       v_inp_invokeobj      :  调用对象
  
     版本:
       2022-12-08_zc314 : 启停xxl_job特定执行参数任务
  
  ==============================================================================*/
  PROCEDURE p_msg_updxxlinfotriggerstatus(v_inp_triggerstatus IN VARCHAR2,
                                          v_inp_executorparam IN VARCHAR2,
                                          v_inp_invokeobj     IN VARCHAR2);

  /*=============================================================================
  
     包：
       pkg_qa_ld(qa逻辑细节包)
  
     过程名:
       【scm传输wms】启停xxl_job特定执行参数任务
  
     入参:
       v_inp_triggerstatus  :  触发器状态 0-停用 1-启用
       v_inp_executorparam  :  执行参数
       v_inp_invokeobj      :  调用对象
  
     版本:
       2023-03-02_zc314 : 启停xxl_job特定执行参数任务
  
  ==============================================================================*/
  PROCEDURE p_scmtwms_updxxlinfotriggerstatus_at(v_inp_triggerstatus IN VARCHAR2,
                                                 v_inp_executorparam IN VARCHAR2,
                                                 v_inp_invokeobj     IN VARCHAR2);

  /*=============================================================================
  
     包：
       pkg_qa_ld(qa逻辑细节包)
  
     函数名:
       Qa尺寸核对表新增
  
     入参:
       v_inp_qarepid     :  Qa质检报告Id
       v_inp_position    :  部位
       v_inp_compid      :  企业Id
       v_inp_gooid       :  商品档案编号
       v_inp_barcode     :  条码
       v_inp_seqno       :  序号
       v_inp_actualsize  :  实际尺码
       v_inp_curuserid   :  当前操作人Id
       v_inp_invokeobj   :  调用对象
  
     版本:
       2022-12-14_zc314 : Qa尺寸核对表新增
       2022-12-15_zc314 : 维度调整，增加尺寸表Id维度
       2023-01-04_zc314 : 维度调整，尺寸表Id修改为部位
  
  ==============================================================================*/
  PROCEDURE p_sizechart_insqasizecheckchart(v_inp_qarepid    IN VARCHAR2,
                                            v_inp_position   IN VARCHAR2,
                                            v_inp_compid     IN VARCHAR2,
                                            v_inp_gooid      IN VARCHAR2,
                                            v_inp_barcode    IN VARCHAR2,
                                            v_inp_seqno      IN NUMBER,
                                            v_inp_actualsize IN NUMBER,
                                            v_inp_curuserid  IN VARCHAR2,
                                            v_inp_invokeobj  IN VARCHAR2);

  /*=============================================================================
  
     包：
       pkg_qa_ld(qa逻辑细节包)
  
     函数名:
       Qa尺寸核对表修改
  
     入参:
       v_inp_qarepid      :  Qa质检报告Id
       v_inp_position     :  部位
       v_inp_compid       :  企业Id
       v_inp_gooid        :  商品档案编号
       v_inp_barcode      :  条码
       v_inp_seqno        :  序号
       v_inp_actualsize   :  实际尺码
       v_inp_curuserid    :  当前操作人Id
       v_inp_invokeobj    :  调用对象
  
     版本:
       2022-12-14_zc314 : Qa尺寸核对表修改
       2022-12-15_zc314 : 维度调整，增加尺寸表Id维度
       2023-01-04_zc314 : 维度调整，尺寸表Id修改为部位
  
  ==============================================================================*/
  PROCEDURE p_sizechart_updqasizecheckchart(v_inp_qarepid    IN VARCHAR2,
                                            v_inp_position   IN VARCHAR2,
                                            v_inp_compid     IN VARCHAR2,
                                            v_inp_gooid      IN VARCHAR2,
                                            v_inp_barcode    IN VARCHAR2,
                                            v_inp_seqno      IN NUMBER,
                                            v_inp_actualsize IN NUMBER,
                                            v_inp_curuserid  IN VARCHAR2,
                                            v_inp_invokeobj  IN VARCHAR2);

  /*=============================================================================
  
     包：
       pkg_qa_ld(qa逻辑细节包)
  
     函数名:
       根据商品档案编号更新 Qa尺寸核对表数据为作废
  
     入参:
       v_inp_gooid      :  商品档案编号
       v_inp_compid     :  企业Id
       v_inp_curuserid  :  当前操作人Id
       v_inp_invokeobj  :  调用对象
  
     版本:
       2023-01-04_zc314 : 根据商品档案编号更新 Qa尺寸核对表数据为作废
  
  ==============================================================================*/
  PROCEDURE p_sizechart_updqasccisdeprecationastrue(v_inp_gooid     IN VARCHAR2,
                                                    v_inp_compid    IN VARCHAR2,
                                                    v_inp_curuserid IN VARCHAR2,
                                                    v_inp_invokeobj IN VARCHAR2);

  /*=============================================================================
  
     包：
       pkg_qa_ld(qa逻辑细节包)
  
     函数名:
       Qa质检报告查货员更新
  
     入参:
       v_inp_qarepid    :  Qa质检报告Id
       v_inp_compid     :  企业Id
       v_inp_checkers   :  拿货员Id
       v_inp_curuserid  :  当前操作人Id
       v_inp_invokeobj  :  调用对象Id
  
     版本:
       2023-01-09_zc314 : Qa质检报告查货员更新
  
  ==============================================================================*/
  PROCEDURE p_goodtake_updqarepcheckers(v_inp_qarepid   IN VARCHAR2,
                                        v_inp_compid    IN VARCHAR2,
                                        v_inp_checkers  IN VARCHAR2,
                                        v_inp_curuserid IN VARCHAR2,
                                        v_inp_invokeobj IN VARCHAR2);

  /*=============================================================================
  
     包：
       pkg_qa_ld(qa逻辑细节包)
  
     函数名:
       qa预回传表质检类型刷新
  
     入参:
       v_inp_asnid      :  asn单号
       v_inp_compid     :  企业id
       v_inp_transtype  :  传输类型
       v_inp_curuserid  :  操作人Id
       v_inp_invokeobj  :  调用对象
  
     版本:
       2023-02-09_zc314 : qa预回传表质检类型刷新
  
  ==============================================================================*/
  PROCEDURE p_maintenance_slabackrefreshtranstype(v_inp_asnid     IN VARCHAR2,
                                                  v_inp_compid    IN VARCHAR2,
                                                  v_inp_transtype IN VARCHAR2,
                                                  v_inp_curuserid IN VARCHAR2,
                                                  v_inp_invokeobj IN VARCHAR2);

  /*=============================================================================
  
     包：
       pkg_qa_ld(qa逻辑细节包)
  
     过程名:
       Qa生成返工报告清空次品
  
     入参:
       v_inp_asnid      :  asn单号
       v_inp_compid     :  企业id
       v_inp_gooid      :  商品档案编号
       v_inp_barcode    :  条码
       v_inp_curuserid  :  操作人Id
       v_inp_invokeobj  :  调用对象
  
     版本:
       2023-02-15_zc314 : Qa生成返工报告清空次品
  
  ==============================================================================*/
  PROCEDURE p_rcrepgen_clearpackssubsamount(v_inp_asnid     IN VARCHAR2,
                                            v_inp_compid    IN VARCHAR2,
                                            v_inp_gooid     IN VARCHAR2,
                                            v_inp_barcode   IN VARCHAR2,
                                            v_inp_curuserid IN VARCHAR2,
                                            v_inp_invokeobj IN VARCHAR2);

END pkg_qa_ld;
/

CREATE OR REPLACE PACKAGE BODY SCMDATA.pkg_qa_ld IS

  /*=============================================================================
  
     包：
       pkg_qa_ld(qa逻辑细节包)
  
     函数名:
       asn免检参数校验
  
     入参:
       v_inp_asnid        : asnid
       v_inp_compid       : 企业id
       v_inp_aeresoncode  : 免检原因编码
       v_inp_invokeobj    : 调用对象
  
     返回值:
       varchar2 类型，错误信息
  
     版本:
       2022-10-09_zc314 : asn免检
  
  ==============================================================================*/
  FUNCTION f_check_asnexemptionparam(v_inp_asnid       IN VARCHAR2,
                                     v_inp_compid      IN VARCHAR2,
                                     v_inp_aeresoncode IN VARCHAR2,
                                     v_inp_invokeobj   IN VARCHAR2)
    RETURN VARCHAR2 IS
    v_errinfo         VARCHAR2(1024);
    v_jugnum          NUMBER(1);
    v_allowinvokeobj  CLOB := 'scmdata.pkg_qa_lc.p_asnexemption';
    v_selfdescription VARCHAR2(1024) := 'scmdata.pkg_qa_ld.f_check_asnexemptionparam';
  BEGIN
    --访问控制
    IF instr(v_allowinvokeobj, v_inp_invokeobj) = 0 THEN
      raise_application_error(-20002,
                              '拒绝访问：调用方-' || v_inp_invokeobj || ' 被调用方-' ||
                              v_selfdescription);
    END IF;
  
    IF v_inp_asnid IS NULL THEN
      v_errinfo := 'Error Object:' || v_selfdescription || chr(10) ||
                   scmdata.f_sentence_append_rc(v_sentence   => v_errinfo,
                                                v_appendstr  => '【asn_id】为空',
                                                v_middliestr => chr(10));
    END IF;
  
    IF v_inp_compid IS NULL THEN
      v_errinfo := 'Error Object:' || v_selfdescription || chr(10) ||
                   scmdata.f_sentence_append_rc(v_sentence   => v_errinfo,
                                                v_appendstr  => '【企业Id】为空',
                                                v_middliestr => chr(10));
    END IF;
  
    IF v_inp_aeresoncode IS NULL THEN
      v_errinfo := 'Error Object:' || v_selfdescription || chr(10) ||
                   scmdata.f_sentence_append_rc(v_sentence   => v_errinfo,
                                                v_appendstr  => '【免检原因】为空',
                                                v_middliestr => chr(10));
    
    ELSE
      v_jugnum := scmdata.pkg_qa_da.f_is_asnexemptionreason_in_dic(v_inp_aeresoncode => v_inp_aeresoncode);
    
      IF v_jugnum = 0 THEN
        v_errinfo := 'Error Object:' || v_selfdescription || chr(10) ||
                     scmdata.f_sentence_append_rc(v_sentence   => v_errinfo,
                                                  v_appendstr  => '【免检原因】不存在于系统字典中',
                                                  v_middliestr => chr(10));
      END IF;
    END IF;
  
    RETURN v_errinfo;
  END f_check_asnexemptionparam;

  /*=============================================================================
  
     包：
       pkg_qa_ld(qa逻辑细节包)
  
     过程名:
       修改 asn状态
  
     入参:
       v_inp_asnids      :  asn单号，多值，用分号分隔
       v_inp_compid      :  企业id
       v_inp_status      :  asn状态
       v_inp_operuserid  :  当前操作人id
       v_inp_invokeobj   :  调用对象
  
     版本:
       2022-10-13_zc314 : 修改 asn状态
  
  ==============================================================================*/
  PROCEDURE p_upd_asnstatus(v_inp_asnids     IN VARCHAR2,
                            v_inp_compid     IN VARCHAR2,
                            v_inp_status     IN VARCHAR2,
                            v_inp_operuserid IN VARCHAR2,
                            v_inp_invokeobj  IN VARCHAR2) IS
    priv_exception EXCEPTION;
    v_sql             CLOB;
    v_errinfo         CLOB;
    v_sqlerrm         VARCHAR2(512);
    v_allowinvokeobj  CLOB := 'scmdata.pkg_qa_lc.p_asnexemption;scmdata.pkg_qa_lc.p_ins_qareportinfo;scmdata.pkg_qa_lc.p_gen_rcqarep;scmdata.pkg_qa_lc.p_maintenance_unqualprocessingsla;scmdata.pkg_qa_lc.p_gen_rcqarep;scmdata.pkg_qa_lc.p_del_pcqareport;scmdata.pkg_qa_lc.p_maintenance_unqualprocessingmas';
    v_selfdescription VARCHAR2(1024) := 'scmdata.pkg_qa_ld.p_upd_asnstatus';
  BEGIN
    --访问控制
    IF instr(v_allowinvokeobj, v_inp_invokeobj) = 0 THEN
      v_sqlerrm := '拒绝访问：调用方-' || v_inp_invokeobj || ' 被调用方-' ||
                   v_selfdescription;
      RAISE priv_exception;
    END IF;
  
    --执行 sql 赋值
    v_sql := 'UPDATE scmdata.t_asnordered
   SET status = :v_inp_status
 WHERE instr(:v_inp_asnids, asn_id) > 0
   AND company_id = :v_inp_compid';
  
    --执行 sql
    EXECUTE IMMEDIATE v_sql
      USING v_inp_status, v_inp_asnids, v_inp_compid;
  
  EXCEPTION
    WHEN priv_exception THEN
      --抛出报错
      raise_application_error(-20002, v_sqlerrm);
    WHEN OTHERS THEN
      --错误信息赋值
      v_sqlerrm := substr(dbms_utility.format_error_stack, 1, 1024);
      v_errinfo := 'Error Object:' || v_selfdescription || chr(10) ||
                   'Error Info: ' || v_sqlerrm || chr(10) || 'Execute sql:' ||
                   v_sql || chr(10) || 'Params: ' || chr(10) ||
                   'v_inp_status: ' || v_inp_status || chr(10) ||
                   'v_inp_asnids: ' || v_inp_asnids || chr(10) ||
                   'v_inp_compid: ' || v_inp_compid;
    
      --新增进入错误信息表
      scmdata.pkg_qa_ee.p_ins_errrecord_at(v_inp_errprogram     => v_selfdescription,
                                           v_inp_causeerruserid => v_inp_operuserid,
                                           v_inp_erroccurtime   => SYSDATE,
                                           v_inp_errinfo        => v_errinfo,
                                           v_inp_compid         => v_inp_compid);
    
      --抛出报错
      raise_application_error(-20002, v_sqlerrm);
  END p_upd_asnstatus;

  /*=============================================================================
  
     包：
       pkg_qa_ld(qa逻辑细节包)
  
     过程名:
       asn免检流程-更新asn状态与免检原因
  
     入参:
       v_inp_asnid        : asnid
       v_inp_compid       : 企业id
       v_inp_aeresoncode  : 免检原因编码
       v_inp_curuserid    : 当前操作人id
       v_inp_invokeobj    : 调用对象
  
     版本:
       2022-10-09_zc314 : asn免检流程-更新asn状态与免检原因
  
  ==============================================================================*/
  PROCEDURE p_upd_asnstatusandaereason(v_inp_asnid       IN VARCHAR2,
                                       v_inp_compid      IN VARCHAR2,
                                       v_inp_aeresoncode IN VARCHAR2,
                                       v_inp_curuserid   IN VARCHAR2,
                                       v_inp_invokeobj   IN VARCHAR2) IS
    priv_exception EXCEPTION;
    v_sql             CLOB;
    v_errinfo         CLOB;
    v_sqlerrm         VARCHAR2(512);
    v_allowinvokeobj  CLOB := 'scmdata.pkg_qa_lc.p_asnexemption';
    v_selfdescription VARCHAR2(1024) := 'scmdata.pkg_qa_ld.p_upd_asnstatusandaereason';
  BEGIN
    --访问控制
    IF instr(v_allowinvokeobj, v_inp_invokeobj) = 0 THEN
      v_sqlerrm := '拒绝访问：调用方-' || v_inp_invokeobj || ' 被调用方-' ||
                   v_selfdescription;
      RAISE priv_exception;
    END IF;
  
    --构建执行sql
    v_sql := 'UPDATE scmdata.t_asnordered
       SET status    = ''AE'',
           ae_reason = :v_inp_aeresoncode,
           ae_userid = :v_inp_curuserid,
           ae_time   = SYSDATE
     WHERE asn_id = :v_inp_asnid
       AND company_id = :v_inp_compid';
  
    --执行sql
    EXECUTE IMMEDIATE v_sql
      USING v_inp_aeresoncode, v_inp_curuserid, v_inp_asnid, v_inp_compid;
  
  EXCEPTION
    WHEN priv_exception THEN
      --抛出报错
      raise_application_error(-20002, v_sqlerrm);
    WHEN OTHERS THEN
      --错误信息赋值
      v_sqlerrm := substr(dbms_utility.format_error_stack, 1, 1024);
      v_errinfo := 'Error Object:' || v_selfdescription || chr(10) ||
                   'Error Info: ' || v_sqlerrm || chr(10) || 'Execute sql:' ||
                   v_sql || chr(10) || 'Params: ' || chr(10) ||
                   'v_inp_aeresoncode: ' || v_inp_aeresoncode || chr(10) ||
                   'v_inp_curuserid: ' || v_inp_curuserid || chr(10) ||
                   'v_inp_asnid: ' || v_inp_asnid || chr(10) ||
                   'v_inp_compid: ' || v_inp_compid;
    
      --新增进入错误信息表
      scmdata.pkg_qa_ee.p_ins_errrecord_at(v_inp_errprogram     => v_selfdescription,
                                           v_inp_causeerruserid => v_inp_curuserid,
                                           v_inp_erroccurtime   => SYSDATE,
                                           v_inp_errinfo        => v_errinfo,
                                           v_inp_compid         => v_inp_compid);
    
      --抛出报错
      raise_application_error(-20002, v_sqlerrm);
  END p_upd_asnstatusandaereason;

  /*=============================================================================
  
     包：
       pkg_qa_ld(qa逻辑细节包)
  
     过程名:
       asn 预回传 wms 表 新增
  
     入参:
       v_inp_asnid      :  asn单号
       v_inp_gooid      :  货号
       v_inp_barcode    :  条码
       v_inp_compid     :  企业id
       v_inp_status     :  状态： pt-准备回传 ts-传输成功 te-传输错误 ce-校验错误
       v_inp_errinfo    :  错误信息
       v_inp_transtype  :  传输类型： asn-按asn整单质检完成传输 sku-按sku传输 ae-按asn整单免检传输
       v_inp_curuserid  :  当前操作人id
       v_inp_invokeobj  :  调用对象
  
     版本:
       2022-10-26_zc314 : asn 预回传 wms 表 新增
       2022-11-21_zc314 : 增加 err_info 中对接口数据是否更新成功校验
  
  ==============================================================================*/
  PROCEDURE p_ins_asninfopretranstowms(v_inp_asnid     IN VARCHAR2,
                                       v_inp_gooid     IN VARCHAR2 DEFAULT NULL,
                                       v_inp_barcode   IN VARCHAR2 DEFAULT NULL,
                                       v_inp_compid    IN VARCHAR2,
                                       v_inp_status    IN VARCHAR2,
                                       v_inp_errinfo   IN CLOB,
                                       v_inp_transtype IN VARCHAR2,
                                       v_inp_curuserid IN VARCHAR2,
                                       v_inp_invokeobj IN VARCHAR2) IS
    priv_exception EXCEPTION;
    v_sql             CLOB;
    v_qpid            VARCHAR2(32) := scmdata.f_get_uuid();
    v_errinfo         CLOB;
    v_sqlerrm         VARCHAR2(512);
    v_allowinvokeobj  CLOB := 'scmdata.pkg_qa_lc.p_gen_asninfopretranstowms_data_ae;scmdata.pkg_qa_lc.p_review_qareport;scmdata.pkg_qa_lc.p_maintenance_unqualprocessing;scmdata.pkg_qa_lc.p_maintenance_unqualprocessingmas;scmdata.pkg_qa_lc.p_maintenance_unqualprocessingsla;scmdata.pkg_qa_lc.p_ins_qarepafskuintopretrans;scmdata.pkg_qa_lc.p_iflpretrans_refreshpretransdata';
    v_selfdescription VARCHAR2(1024) := 'scmdata.pkg_qa_ld.p_ins_asninfopretranstowms';
  BEGIN
    --访问控制
    IF instr(v_allowinvokeobj, v_inp_invokeobj) = 0 THEN
      v_sqlerrm := '拒绝访问：调用方-' || v_inp_invokeobj || ' 被调用方-' ||
                   v_selfdescription;
      RAISE priv_exception;
    END IF;
  
    --v_sql赋值
    v_sql := 'INSERT INTO scmdata.t_qa_pretranstowms
  (qp_id,
   company_id,
   status,
   trans_type,
   asn_id,
   goo_id,
   barcode,
   create_id,
   create_time,
   err_info)
VALUES
  (:v_qpid,
   :v_inp_compid,
   :v_inp_status,
   :v_inp_transtype,
   :v_inp_asnid,
   :v_inp_gooid,
   :v_inp_barcode,
   :v_inp_curuserid,
   SYSDATE,
   :v_inp_errinfo)';
  
    --执行 v_sql
    EXECUTE IMMEDIATE v_sql
      USING v_qpid, v_inp_compid, v_inp_status, v_inp_transtype, v_inp_asnid, v_inp_gooid, v_inp_barcode, v_inp_curuserid, v_inp_errinfo;
  
  EXCEPTION
    WHEN priv_exception THEN
      --抛出报错
      raise_application_error(-20002, v_sqlerrm);
    WHEN OTHERS THEN
      --错误信息赋值
      v_sqlerrm := substr(dbms_utility.format_error_stack, 1, 1024);
      v_errinfo := 'Error Object:' || v_selfdescription || chr(10) ||
                   'Error Info: ' || v_sqlerrm || chr(10) || 'Execute sql:' ||
                   v_sql || chr(10) || 'Params: ' || chr(10) || 'v_qpid: ' ||
                   v_qpid || chr(10) || 'v_inp_compid: ' || v_inp_compid ||
                   chr(10) || 'v_inp_status: ' || v_inp_status || chr(10) ||
                   'v_inp_transtype: ' || v_inp_transtype || chr(10) ||
                   'v_inp_asnid: ' || v_inp_asnid || chr(10) ||
                   'v_inp_gooid: ' || v_inp_gooid || chr(10) ||
                   'v_inp_barcode: ' || v_inp_barcode || chr(10) ||
                   'v_inp_curuserid: ' || v_inp_curuserid || chr(10) ||
                   'v_inp_errinfo: ' || v_inp_errinfo;
    
      --新增进入错误信息表
      scmdata.pkg_qa_ee.p_ins_errrecord_at(v_inp_errprogram     => v_selfdescription,
                                           v_inp_causeerruserid => v_inp_curuserid,
                                           v_inp_erroccurtime   => SYSDATE,
                                           v_inp_errinfo        => v_errinfo,
                                           v_inp_compid         => v_inp_compid);
    
      --抛出报错
      raise_application_error(-20002, v_sqlerrm);
  END p_ins_asninfopretranstowms;

  /*=============================================================================
  
     包：
       pkg_qa_ld(qa逻辑细节包)
  
     过程名:
       asn 预回传 wms 表 更新
  
     入参:
       v_inp_asnid      :  asn单号
       v_inp_gooid      :  货号
       v_inp_barcode    :  条码
       v_inp_compid     :  企业id
       v_inp_transtype  :  传输类型： asn-按asn整单质检完成传输 sku-按sku传输 ae-按asn整单免检传输
       v_inp_status     :  状态： pt-准备回传 ts-传输成功 te-传输错误 ce-校验错误
       v_inp_errinfo    :  错误信息
       v_inp_curuserid  :  当前操作人id
       v_inp_invokeobj  :  调用对象
  
     版本:
       2022-12-06_zc314 : asn 预回传 wms 表 更新
       2023-02-15_zc314 : 增加传输类型更新逻辑
  
  ==============================================================================*/
  PROCEDURE p_upd_asninfopretranstowms(v_inp_asnid     IN VARCHAR2,
                                       v_inp_gooid     IN VARCHAR2 DEFAULT NULL,
                                       v_inp_barcode   IN VARCHAR2 DEFAULT NULL,
                                       v_inp_compid    IN VARCHAR2,
                                       v_inp_transtype IN VARCHAR2,
                                       v_inp_status    IN VARCHAR2,
                                       v_inp_errinfo   IN CLOB,
                                       v_inp_curuserid IN VARCHAR2,
                                       v_inp_invokeobj IN VARCHAR2) IS
    priv_exception EXCEPTION;
    v_sql             CLOB;
    v_errinfo         CLOB;
    v_sqlerrm         VARCHAR2(512);
    v_allowinvokeobj  CLOB := 'scmdata.pkg_qa_lc.p_gen_asninfopretranstowms_data_ae;scmdata.pkg_qa_lc.p_review_qareport;scmdata.pkg_qa_lc.p_maintenance_unqualprocessing;scmdata.pkg_qa_lc.p_maintenance_unqualprocessingmas;scmdata.pkg_qa_lc.p_maintenance_unqualprocessingsla;scmdata.pkg_qa_lc.p_ins_qarepafskuintopretrans;scmdata.pkg_qa_lc.p_iflpretrans_refreshpretransdata';
    v_selfdescription VARCHAR2(1024) := 'scmdata.pkg_qa_ld.p_ins_asninfopretranstowms';
  BEGIN
    --访问控制
    IF instr(v_allowinvokeobj, v_inp_invokeobj) = 0 THEN
      v_sqlerrm := '拒绝访问：调用方-' || v_inp_invokeobj || ' 被调用方-' ||
                   v_selfdescription;
      RAISE priv_exception;
    END IF;
  
    --v_sql赋值
    v_sql := 'UPDATE scmdata.t_qa_pretranstowms
   SET trans_type = :v_inp_transtype,
       status = :v_inp_status,
       err_info = :v_inp_errinfo
 WHERE asn_id = :v_inp_asnid
   AND NVL(goo_id,''  '') = NVL(:v_inp_gooid,'' '')
   AND NVL(barcode, '' '') = NVL(:v_inp_barcode, '' '')
   AND company_id = :v_inp_compid';
  
    --执行 v_sql
    EXECUTE IMMEDIATE v_sql
      USING v_inp_transtype, v_inp_status, v_inp_errinfo, v_inp_asnid, v_inp_gooid, v_inp_barcode, v_inp_compid;
  
  EXCEPTION
    WHEN priv_exception THEN
      --抛出报错
      raise_application_error(-20002, v_sqlerrm);
    WHEN OTHERS THEN
      --错误信息赋值
      v_sqlerrm := substr(dbms_utility.format_error_stack, 1, 1024);
      v_errinfo := 'Error Object:' || v_selfdescription || chr(10) ||
                   'Error Info: ' || v_sqlerrm || chr(10) || 'Execute sql:' ||
                   v_sql || chr(10) || 'Params: ' || chr(10) ||
                   'v_inp_transtype: ' || v_inp_transtype || chr(10) ||
                   'v_inp_status: ' || v_inp_status || chr(10) ||
                   'v_inp_errinfo: ' || v_inp_errinfo || chr(10) ||
                   'v_inp_asnid: ' || v_inp_asnid || chr(10) ||
                   'v_inp_gooid: ' || v_inp_gooid || chr(10) ||
                   'v_inp_barcode: ' || v_inp_barcode || chr(10) ||
                   'v_inp_compid: ' || v_inp_compid;
    
      --新增进入错误信息表
      scmdata.pkg_qa_ee.p_ins_errrecord_at(v_inp_errprogram     => v_selfdescription,
                                           v_inp_causeerruserid => v_inp_curuserid,
                                           v_inp_erroccurtime   => SYSDATE,
                                           v_inp_errinfo        => v_errinfo,
                                           v_inp_compid         => v_inp_compid);
    
      --抛出报错
      raise_application_error(-20002, v_sqlerrm);
  END p_upd_asninfopretranstowms;

  /*=============================================================================
  
     包：
       pkg_qa_ld(qa逻辑细节包)
  
     过程名:
       已检列表基础维度数据新增
  
     入参:
       v_inp_asnid              :  asn编号
       v_inp_compid             :  企业id
       v_inp_gooid              :  商品档案编号
       v_inp_barcode            :  sku条码
       v_inp_ordid              :  订单号
       v_inp_pcomeamt           :  预计到仓数量
       v_inp_wmsgotamt          :  wms上架数量
       v_inp_qualdecreamt       :  质检减数
       v_inp_qualpassamt        :  质检通过减数
       v_inp_qualresult         :  质检结果
       v_inp_unqualprosresult   :  不合格处理原因
       v_inp_arrretnum          :  到仓返工数量
       v_inp_aereason           :  免检原因
       v_inp_pcomedate          :  预计到仓日期
       v_inp_scantime           :  到仓扫描时间
       v_inp_receivetime        :  上架时间
       v_inp_qualfinishtime     :  质检完成时间
       v_inp_colorname          :  颜色名称
       v_inp_sizename           :  尺寸名称
       v_inp_datasource         :  数据源
       v_inp_wmsskucheckresult  :  wms_sku质检结果
       v_inp_operuserid         :  操作人id
       v_inp_invokeobj          :  调用对象
  
     版本:
       2022-10-09_zc314 : 已检列表基础维度数据新增
       2022-10-13_zc314 : pkg_qa_ee 异常处理逻辑补充
       2022-12-03_zc314 : 增加 scmdata.t_qaqualedlist_sla.color_name, size_name列
                          以解决已检列表从表颜色尺码列无数据问题
  
  ==============================================================================*/
  PROCEDURE p_ins_qaqualedlistsla(v_inp_asnid             IN VARCHAR2,
                                  v_inp_compid            IN VARCHAR2,
                                  v_inp_gooid             IN VARCHAR2,
                                  v_inp_barcode           IN VARCHAR2,
                                  v_inp_ordid             IN VARCHAR2,
                                  v_inp_pcomeamt          IN NUMBER,
                                  v_inp_wmsgotamt         IN NUMBER,
                                  v_inp_qualdecreamt      IN NUMBER,
                                  v_inp_qualpassamt       IN NUMBER,
                                  v_inp_qualresult        IN VARCHAR2,
                                  v_inp_unqualprosresult  IN VARCHAR2,
                                  v_inp_arrretnum         IN NUMBER,
                                  v_inp_aereason          IN VARCHAR2,
                                  v_inp_pcomedate         IN DATE,
                                  v_inp_scantime          IN DATE,
                                  v_inp_receivetime       IN DATE,
                                  v_inp_qualfinishtime    IN DATE,
                                  v_inp_colorname         IN VARCHAR2,
                                  v_inp_sizename          IN VARCHAR2,
                                  v_inp_datasource        IN VARCHAR2,
                                  v_inp_wmsskucheckresult IN VARCHAR2,
                                  v_inp_operuserid        IN VARCHAR2,
                                  v_inp_invokeobj         IN VARCHAR2) IS
    priv_exception EXCEPTION;
    v_sql             CLOB;
    v_errinfo         CLOB;
    v_sqlerrm         VARCHAR2(512);
    v_allowinvokeobj  CLOB := 'scmdata.pkg_qa_lc.p_iu_qaqualedlistsla';
    v_selfdescription VARCHAR2(1024) := 'scmdata.pkg_qa_ld.p_ins_qaqualedlistsla';
  BEGIN
    --访问控制
    IF instr(v_allowinvokeobj, v_inp_invokeobj) = 0 THEN
      v_sqlerrm := '拒绝访问：调用方-' || v_inp_invokeobj || ' 被调用方-' ||
                   v_selfdescription;
      RAISE priv_exception;
    END IF;
  
    v_sql := 'INSERT INTO scmdata.t_qaqualedlist_sla
  (asn_id,
   company_id,
   order_id,
   goo_id,
   barcode,
   pcome_amount,
   wmsgot_amount,
   qual_decreamount,
   qual_passamount,
   qual_result,
   unqual_prosresult,
   arrive_retnum,
   ae_reason,
   pcome_date,
   scan_time,
   receive_time,
   qual_finishtime,
   color_name,
   size_name,
   data_source,
   wmsskucheck_result)
VALUES
  (:v_inp_asnid,
   :v_inp_compid,
   :v_inp_ordid,
   :v_inp_gooid,
   :v_inp_barcode,
   :v_inp_pcomeamt,
   :v_inp_wmsgotamt,
   :v_inp_qualdecreamt,
   :v_inp_qualpassamt,
   :v_inp_qualresult,
   :v_inp_unqualprosresult,
   :v_inp_arrretnum,
   :v_inp_aereason,
   :v_inp_pcomedate,
   :v_inp_scantime,
   :v_inp_receivetime,
   :v_inp_qualfinishtime,
   :v_inp_colorname,
   :v_inp_sizename,
   :v_inp_datasource,
   :v_inp_wmsskucheckresult)';
  
    EXECUTE IMMEDIATE v_sql
      USING v_inp_asnid, v_inp_compid, v_inp_ordid, v_inp_gooid, nvl(v_inp_barcode, v_inp_gooid), v_inp_pcomeamt, v_inp_wmsgotamt, v_inp_qualdecreamt, v_inp_qualpassamt, v_inp_qualresult, v_inp_unqualprosresult, v_inp_arrretnum, v_inp_aereason, v_inp_pcomedate, v_inp_scantime, v_inp_receivetime, v_inp_qualfinishtime, v_inp_colorname, v_inp_sizename, v_inp_datasource, v_inp_wmsskucheckresult;
  EXCEPTION
    WHEN priv_exception THEN
      --抛出报错
      raise_application_error(-20002, v_sqlerrm);
    WHEN OTHERS THEN
      --错误信息赋值
      v_sqlerrm := substr(dbms_utility.format_error_stack, 1, 1024);
      v_errinfo := 'Error Object:' || v_selfdescription || chr(10) ||
                   'Error Info: ' || v_sqlerrm || chr(10) || 'Execute sql:' ||
                   v_sql || chr(10) || 'Params: ' || chr(10) ||
                   'v_inp_asnid: ' || v_inp_asnid || chr(10) ||
                   'v_inp_compid: ' || v_inp_compid || chr(10) ||
                   'v_inp_ordid: ' || v_inp_ordid || chr(10) ||
                   'v_inp_gooid: ' || v_inp_gooid || chr(10) ||
                   'v_inp_barcode: ' || v_inp_barcode || chr(10) ||
                   'v_inp_pcomeamt: ' || to_char(v_inp_pcomeamt) || chr(10) ||
                   'v_inp_wmsgotamt: ' || to_char(v_inp_wmsgotamt) ||
                   chr(10) || 'v_inp_qualdecreamt: ' ||
                   to_char(v_inp_qualdecreamt) || chr(10) ||
                   'v_inp_qualpassamt: ' || to_char(v_inp_qualpassamt) ||
                   chr(10) || 'v_inp_qualresult: ' || v_inp_qualresult ||
                   chr(10) || 'v_inp_unqualprosresult: ' ||
                   v_inp_unqualprosresult || chr(10) || 'v_inp_arrretnum: ' ||
                   to_char(v_inp_arrretnum) || chr(10) ||
                   'v_inp_aereason: ' || v_inp_aereason || chr(10) ||
                   'v_inp_pcomedate: ' ||
                   to_char(v_inp_pcomedate, 'yyyy-mm-dd hh24-mi-ss') ||
                   chr(10) || 'v_inp_scantime: ' ||
                   to_char(v_inp_scantime, 'yyyy-mm-dd hh24-mi-ss') ||
                   chr(10) || 'v_inp_receivetime: ' ||
                   to_char(v_inp_receivetime, 'yyyy-mm-dd hh24-mi-ss') ||
                   chr(10) || 'v_inp_qualfinishtime: ' ||
                   to_char(v_inp_qualfinishtime, 'yyyy-mm-dd hh24-mi-ss') ||
                   'v_inp_colorname: ' || v_inp_colorname || chr(10) ||
                   'v_inp_sizename: ' || v_inp_sizename || chr(10) ||
                   'v_inp_datasource: ' || v_inp_datasource || chr(10) ||
                   'v_inp_wmsskucheckresult: ' || v_inp_wmsskucheckresult;
    
      --新增进入错误信息表
      scmdata.pkg_qa_ee.p_ins_errrecord_at(v_inp_errprogram     => v_selfdescription,
                                           v_inp_causeerruserid => v_inp_operuserid,
                                           v_inp_erroccurtime   => SYSDATE,
                                           v_inp_errinfo        => v_errinfo,
                                           v_inp_compid         => v_inp_compid);
    
      --抛出报错
      raise_application_error(-20002, v_sqlerrm);
  END p_ins_qaqualedlistsla;

  /*=============================================================================
  
     包：
       pkg_qa_ld(qa逻辑细节包)
  
     过程名:
       已检列表基础维度数据修改
  
     入参:
       v_inp_asnid              :  asn编号
       v_inp_compid             :  企业id
       v_inp_gooid              :  商品档案编号
       v_inp_barcode            :  sku条码
       v_inp_ordid              :  订单号
       v_inp_pcomeamt           :  预计到仓数量
       v_inp_wmsgotamt          :  wms预计
       v_inp_qualdecreamt       :  质检减数
       v_inp_qualpassamt        :  质检通过减数
       v_inp_qualresult         :  质检结果
       v_inp_unqualprosresult   :  不合格处理原因
       v_inp_arrretnum          :  到仓返工数量
       v_inp_aereason           :  免检原因
       v_inp_pcomedate          :  预计到仓日期
       v_inp_scantime           :  到仓扫描时间
       v_inp_receivetime        :  上架时间
       v_inp_qualfinishtime     :  质检完成时间
       v_inp_colorname          :  颜色名称
       v_inp_sizename           :  尺寸名称
       v_inp_datasource         :  数据源
       v_inp_wmsskucheckresult  :  wms_sku质检结果
       v_inp_operuserid         :  操作人id
       v_inp_invokeobj          :  调用对象
  
     版本:
       2022-10-09_zc314 : 已检列表基础维度数据修改
       2022-10-13_zc314 : pkg_qa_ee 异常处理逻辑补充
       2022-12-03_zc314 : 增加 scmdata.t_qaqualedlist_sla.color_name, size_name列
                          以解决已检列表从表颜色尺码列无数据问题
  
  ==============================================================================*/
  PROCEDURE p_upd_qaqualedlistsla(v_inp_asnid             IN VARCHAR2,
                                  v_inp_compid            IN VARCHAR2,
                                  v_inp_gooid             IN VARCHAR2,
                                  v_inp_barcode           IN VARCHAR2,
                                  v_inp_ordid             IN VARCHAR2,
                                  v_inp_pcomeamt          IN NUMBER,
                                  v_inp_wmsgotamt         IN NUMBER,
                                  v_inp_qualdecreamt      IN NUMBER,
                                  v_inp_qualpassamt       IN NUMBER,
                                  v_inp_qualresult        IN VARCHAR2,
                                  v_inp_unqualprosresult  IN VARCHAR2,
                                  v_inp_arrretnum         IN NUMBER,
                                  v_inp_aereason          IN VARCHAR2,
                                  v_inp_pcomedate         IN DATE,
                                  v_inp_scantime          IN DATE,
                                  v_inp_receivetime       IN DATE,
                                  v_inp_qualfinishtime    IN DATE,
                                  v_inp_colorname         IN VARCHAR2,
                                  v_inp_sizename          IN VARCHAR2,
                                  v_inp_datasource        IN VARCHAR2,
                                  v_inp_wmsskucheckresult IN VARCHAR2,
                                  v_inp_operuserid        IN VARCHAR2,
                                  v_inp_invokeobj         IN VARCHAR2) IS
    priv_exception EXCEPTION;
    v_sql             CLOB;
    v_errinfo         CLOB;
    v_sqlerrm         VARCHAR2(512);
    v_allowinvokeobj  CLOB := 'scmdata.pkg_qa_lc.p_iu_qaqualedlistsla';
    v_selfdescription VARCHAR2(1024) := 'scmdata.pkg_qa_ld.p_upd_qaqualedlistsla';
  BEGIN
    --访问控制
    IF instr(v_allowinvokeobj, v_inp_invokeobj) = 0 THEN
      v_sqlerrm := '拒绝访问：调用方-' || v_inp_invokeobj || ' 被调用方-' ||
                   v_selfdescription;
      RAISE priv_exception;
    END IF;
  
    --执行sql赋值
    v_sql := 'UPDATE scmdata.t_qaqualedlist_sla
    SET order_id = :v_inp_ordid,
        pcome_amount = :v_inp_pcomeamt,
        wmsgot_amount = :v_inp_wmsgotamt,
        qual_decreamount = :v_inp_qualdecreamt,
        qual_passamount = :v_inp_qualpassamt,
        qual_result = :v_inp_qualresult,
        unqual_prosresult = :v_inp_unqualprosresult,
        arrive_retnum = :v_inp_arrretnum,
        ae_reason = :v_inp_aereason,
        pcome_date = :v_inp_pcomedate,
        scan_time = :v_inp_scantime,
        receive_time = :v_inp_receivetime,
        qual_finishtime = :v_inp_qualfinishtime,
        color_name = :v_inp_colorname,
        size_name = :v_inp_sizename,
        data_source = :v_inp_datasource,
        wmsskucheck_result = :v_inp_wmsskucheckresult
  WHERE asn_id = :v_inp_asnid
    AND goo_id = :v_inp_gooid
    AND nvl(barcode, '' '') = nvl(:v_inp_barcode, '' '')
    AND company_id = :v_inp_compid';
  
    --执行sql
    EXECUTE IMMEDIATE v_sql
      USING v_inp_ordid, v_inp_pcomeamt, v_inp_wmsgotamt, v_inp_qualdecreamt, v_inp_qualpassamt, v_inp_qualresult, v_inp_unqualprosresult, v_inp_arrretnum, v_inp_aereason, v_inp_pcomedate, v_inp_scantime, v_inp_receivetime, v_inp_qualfinishtime, v_inp_datasource, v_inp_wmsskucheckresult, v_inp_asnid, v_inp_gooid, v_inp_barcode, v_inp_compid, v_inp_colorname, v_inp_sizename;
  
  EXCEPTION
    WHEN priv_exception THEN
      --抛出报错
      raise_application_error(-20002, v_sqlerrm);
    WHEN OTHERS THEN
      --错误信息赋值
      v_sqlerrm := substr(dbms_utility.format_error_stack, 1, 1024);
      v_errinfo := 'Error Object:' || v_selfdescription || chr(10) ||
                   'Error Info: ' || v_sqlerrm || chr(10) || 'Execute sql:' ||
                   v_sql || chr(10) || 'Params: ' || chr(10) ||
                   'v_inp_pcomeamt: ' || to_char(v_inp_pcomeamt) || chr(10) ||
                   'v_inp_wmsgotamt: ' || to_char(v_inp_wmsgotamt) ||
                   chr(10) || 'v_inp_qualdecreamt: ' ||
                   to_char(v_inp_qualdecreamt) || chr(10) ||
                   'v_inp_qualpassamt: ' || to_char(v_inp_qualpassamt) ||
                   chr(10) || 'v_inp_qualresult: ' || v_inp_qualresult ||
                   chr(10) || 'v_inp_arrretnum: ' ||
                   to_char(v_inp_arrretnum) || chr(10) ||
                   'v_inp_aereason: ' || v_inp_aereason || chr(10) ||
                   'v_inp_pcomedate: ' ||
                   to_char(v_inp_pcomedate, 'yyyy-mm-dd hh24-mi-ss') ||
                   chr(10) || 'v_inp_scantime: ' ||
                   to_char(v_inp_scantime, 'yyyy-mm-dd hh24-mi-ss') ||
                   chr(10) || 'v_inp_receivetime: ' ||
                   to_char(v_inp_receivetime, 'yyyy-mm-dd hh24-mi-ss') ||
                   chr(10) || 'v_inp_qualfinishtime: ' ||
                   to_char(v_inp_qualfinishtime, 'yyyy-mm-dd hh24-mi-ss') ||
                   chr(10) || 'v_inp_colorname: ' || v_inp_colorname ||
                   chr(10) || 'v_inp_sizename: ' || v_inp_sizename ||
                   'v_inp_datasource: ' || v_inp_datasource || chr(10) ||
                   'v_inp_wmsskucheckresult: ' || v_inp_wmsskucheckresult ||
                   chr(10) || chr(10) || 'v_inp_asnid: ' || v_inp_asnid ||
                   chr(10) || 'v_inp_gooid: ' || v_inp_gooid || chr(10) ||
                   'v_inp_barcode: ' || v_inp_barcode || chr(10) ||
                   'v_inp_compid: ' || v_inp_compid;
    
      --新增进入错误信息表
      scmdata.pkg_qa_ee.p_ins_errrecord_at(v_inp_errprogram     => v_selfdescription,
                                           v_inp_causeerruserid => v_inp_operuserid,
                                           v_inp_erroccurtime   => SYSDATE,
                                           v_inp_errinfo        => v_errinfo,
                                           v_inp_compid         => v_inp_compid);
    
      --抛出报错
      raise_application_error(-20002, v_sqlerrm);
  END p_upd_qaqualedlistsla;

  /*=============================================================================
  
     包：
       pkg_qa_ld(qa逻辑细节包)
  
     过程名:
       已检列表基础维度数据新增
  
     入参:
       v_inp_asnid            :  asn编号
       v_inp_compid           :  企业id
       v_inp_gooid            :  商品档案编号
       v_inp_barcode          :  sku条码
       v_inp_ordid            :  订单号
       v_inp_pcomeamt         :  预计到仓数量
       v_inp_wmsgotamt        :  wms上架数量
       v_inp_qualdecreamt     :  质检减数
       v_inp_qualpassamt      :  质检通过减数
       v_inp_qualresult       :  质检结果
       v_inp_unqualprosresult :  不合格处理原因
       v_inp_arrretnum        :  到仓返工数量
       v_inp_aereason         :  免检原因
       v_inp_pcomedate        :  预计到仓日期
       v_inp_scantime         :  到仓扫描时间
       v_inp_receivetime      :  上架时间
       v_inp_qualfinishtime   :  质检完成时间
       v_inp_operuserid       :  操作人id
       v_inp_invokeobj        :  调用对象
  
     版本:
       2022-10-09_zc314 : 已检列表基础维度数据新增
       2022-10-13_zc314 : pkg_qa_ee 异常处理逻辑补充
  
  ==============================================================================*/
  PROCEDURE p_ins_qaqualedlistmas(v_inp_asnid            IN VARCHAR2,
                                  v_inp_compid           IN VARCHAR2,
                                  v_inp_ordid            IN VARCHAR2,
                                  v_inp_pcomeamt         IN NUMBER,
                                  v_inp_wmsgotamt        IN NUMBER,
                                  v_inp_qualdecreamt     IN NUMBER,
                                  v_inp_qualpassamt      IN NUMBER,
                                  v_inp_qualresult       IN VARCHAR2,
                                  v_inp_unqualprosresult IN VARCHAR2,
                                  v_inp_arrretnum        IN NUMBER,
                                  v_inp_aereason         IN VARCHAR2,
                                  v_inp_pcomedate        IN DATE,
                                  v_inp_scantime         IN DATE,
                                  v_inp_receivetime      IN DATE,
                                  v_inp_qualfinishtime   IN DATE,
                                  v_inp_operuserid       IN VARCHAR2,
                                  v_inp_invokeobj        IN VARCHAR2) IS
    priv_exception EXCEPTION;
    v_sql             CLOB;
    v_errinfo         CLOB;
    v_sqlerrm         VARCHAR2(512);
    v_allowinvokeobj  CLOB := 'scmdata.pkg_qa_lc.p_iu_qaqualedlistmas';
    v_selfdescription VARCHAR2(1024) := 'scmdata.pkg_qa_ld.p_ins_qaqualedlistmas';
  BEGIN
    --访问控制
    IF instr(v_allowinvokeobj, v_inp_invokeobj) = 0 THEN
      v_sqlerrm := '拒绝访问：调用方-' || v_inp_invokeobj || ' 被调用方-' ||
                   v_selfdescription;
      RAISE priv_exception;
    END IF;
  
    --执行 sql 赋值
    v_sql := 'INSERT INTO scmdata.t_qaqualedlist_mas
 (asn_id, company_id, order_id, pcome_amount, wmsgot_amount, qual_decreamount, qual_passamount,
  qual_result, unqual_prosresult, arrive_retnum, ae_reason, pcome_date, scan_time, receive_time,
  qual_finishtime)
VALUES
  (:v_inp_asnid, :v_inp_compid, :v_inp_ordid, :v_inp_pcomeamt, :v_inp_wmsgotamt, :v_inp_qualdecreamt,
   :v_inp_qualpassamt, :v_inp_qualresult, :v_inp_unqualprosresult, :v_inp_arrretnum, :v_inp_aereason,
   :v_inp_pcomedate, :v_inp_scantime, :v_inp_receivetime, :v_inp_qualfinishtime)';
  
    --执行 sql
    EXECUTE IMMEDIATE v_sql
      USING v_inp_asnid, v_inp_compid, v_inp_ordid, v_inp_pcomeamt, v_inp_wmsgotamt, v_inp_qualdecreamt, v_inp_qualpassamt, v_inp_qualresult, v_inp_unqualprosresult, v_inp_arrretnum, v_inp_aereason, v_inp_pcomedate, v_inp_scantime, v_inp_receivetime, v_inp_qualfinishtime;
  
  EXCEPTION
    WHEN priv_exception THEN
      --抛出报错
      raise_application_error(-20002, v_sqlerrm);
    WHEN OTHERS THEN
      --错误信息赋值
      v_sqlerrm := substr(dbms_utility.format_error_stack, 1, 1024);
      v_errinfo := 'Error Object:' || v_selfdescription || chr(10) ||
                   'Error Info: ' || v_sqlerrm || chr(10) || 'Execute_sql:' ||
                   v_sql || chr(10) || 'Params: ' || chr(10) || 'asn_id: ' ||
                   v_inp_asnid || chr(10) || 'company_id: ' || v_inp_compid ||
                   chr(10) || 'order_id: ' || v_inp_ordid || chr(10) ||
                   'pcome_amount: ' || to_char(v_inp_pcomeamt) || chr(10) ||
                   'wmsgot_amount: ' || to_char(v_inp_wmsgotamt) || chr(10) ||
                   'v_inp_qualdecreamt: ' || to_char(v_inp_qualdecreamt) ||
                   chr(10) || 'qual_passamount: ' ||
                   to_char(v_inp_qualpassamt) || chr(10) || 'qual_result: ' ||
                   v_inp_qualresult || chr(10) || 'unqual_prosresult: ' ||
                   v_inp_unqualprosresult || chr(10) || 'arrive_retnum: ' ||
                   to_char(v_inp_arrretnum) || chr(10) || 'ae_reason: ' ||
                   v_inp_aereason || chr(10) || 'pcome_date: ' ||
                   to_char(v_inp_pcomedate, 'yyyy-mm-dd hh24-mi-ss') ||
                   chr(10) || 'scan_time: ' ||
                   to_char(v_inp_scantime, 'yyyy-mm-dd hh24-mi-ss') ||
                   chr(10) || 'receive_time: ' ||
                   to_char(v_inp_receivetime, 'yyyy-mm-dd hh24-mi-ss') ||
                   chr(10) || 'qual_finishtime: ' ||
                   to_char(v_inp_qualfinishtime, 'yyyy-mm-dd hh24-mi-ss');
    
      --新增进入错误信息表
      scmdata.pkg_qa_ee.p_ins_errrecord_at(v_inp_errprogram     => v_selfdescription,
                                           v_inp_causeerruserid => v_inp_operuserid,
                                           v_inp_erroccurtime   => SYSDATE,
                                           v_inp_errinfo        => v_errinfo,
                                           v_inp_compid         => v_inp_compid);
    
      --抛出报错
      raise_application_error(-20002, v_sqlerrm);
  END p_ins_qaqualedlistmas;

  /*=============================================================================
  
     包：
       pkg_qa_ld(qa逻辑细节包)
  
     过程名:
       已检列表基础维度数据新增
  
     入参:
       v_inp_asnid            :  asn编号
       v_inp_compid           :  企业id
       v_inp_gooid            :  商品档案编号
       v_inp_barcode          :  sku条码
       v_inp_ordid            :  订单号
       v_inp_pcomeamt         :  预计到仓数量
       v_inp_wmsgotamt        :  wms上架数量
       v_inp_qualdecreamt     :  质检减数
       v_inp_qualpassamt      :  质检通过减数
       v_inp_qualresult       :  质检结果
       v_inp_unqualprosresult :  不合格处理原因
       v_inp_arrretnum        :  到仓返工数量
       v_inp_aereason         :  免检原因
       v_inp_pcomedate        :  预计到仓日期
       v_inp_scantime         :  到仓扫描时间
       v_inp_receivetime      :  上架时间
       v_inp_qualfinishtime   :  质检完成时间
       v_inp_operuserid       :  操作人id
       v_inp_invokeobj        :  调用对象
  
     版本:
       2022-10-09_zc314 : 已检列表基础维度数据新增
       2022-10-13_zc314 : pkg_qa_ee 异常处理逻辑补充
  
  ==============================================================================*/
  PROCEDURE p_upd_qaqualedlistmas(v_inp_asnid            IN VARCHAR2,
                                  v_inp_compid           IN VARCHAR2,
                                  v_inp_ordid            IN VARCHAR2,
                                  v_inp_pcomeamt         IN NUMBER,
                                  v_inp_wmsgotamt        IN NUMBER,
                                  v_inp_qualdecreamt     IN NUMBER,
                                  v_inp_qualpassamt      IN NUMBER,
                                  v_inp_qualresult       IN VARCHAR2,
                                  v_inp_unqualprosresult IN VARCHAR2,
                                  v_inp_arrretnum        IN NUMBER,
                                  v_inp_aereason         IN VARCHAR2,
                                  v_inp_pcomedate        IN DATE,
                                  v_inp_scantime         IN DATE,
                                  v_inp_receivetime      IN DATE,
                                  v_inp_qualfinishtime   IN DATE,
                                  v_inp_operuserid       IN VARCHAR2,
                                  v_inp_invokeobj        IN VARCHAR2) IS
    priv_exception EXCEPTION;
    v_sql             CLOB;
    v_errinfo         CLOB;
    v_sqlerrm         VARCHAR2(512);
    v_allowinvokeobj  CLOB := 'scmdata.pkg_qa_lc.p_iu_qaqualedlistmas';
    v_selfdescription VARCHAR2(1024) := 'scmdata.pkg_qa_ld.p_upd_qaqualedlistmas';
  BEGIN
    --访问控制
    IF instr(v_allowinvokeobj, v_inp_invokeobj) = 0 THEN
      v_sqlerrm := '拒绝访问：调用方-' || v_inp_invokeobj || ' 被调用方-' ||
                   v_selfdescription;
      RAISE priv_exception;
    END IF;
  
    --执行 sql 赋值
    v_sql := 'UPDATE scmdata.t_qaqualedlist_mas
   SET order_id          = :v_inp_ordid,
       pcome_amount      = :v_inp_pcomeamt,
       wmsgot_amount     = :v_inp_wmsgotamt,
       qual_decreamount  = :v_inp_qualdecreamt,
       qual_passamount   = :v_inp_qualpassamt,
       qual_result       = :v_inp_qualresult,
       unqual_prosresult = :v_inp_unqualprosresult,
       arrive_retnum     = :v_inp_arrretnum,
       ae_reason         = :v_inp_aereason,
       pcome_date        = :v_inp_pcomedate,
       scan_time         = :v_inp_scantime,
       receive_time      = :v_inp_receivetime,
       qual_finishtime   = :v_inp_qualfinishtime
 WHERE asn_id = :v_inp_asnid
   AND company_id = :v_inp_compid';
  
    --执行 sql
    EXECUTE IMMEDIATE v_sql
      USING v_inp_ordid, v_inp_pcomeamt, v_inp_wmsgotamt, v_inp_qualdecreamt, v_inp_qualpassamt, v_inp_qualresult, v_inp_unqualprosresult, v_inp_arrretnum, v_inp_aereason, v_inp_pcomedate, v_inp_scantime, v_inp_receivetime, v_inp_qualfinishtime, v_inp_asnid, v_inp_compid;
  
  EXCEPTION
    WHEN priv_exception THEN
      --抛出报错
      raise_application_error(-20002, v_sqlerrm);
    WHEN OTHERS THEN
      --错误信息赋值
      v_sqlerrm := substr(dbms_utility.format_error_stack, 1, 1024);
      v_errinfo := 'Error Object:' || v_selfdescription || chr(10) ||
                   'Error Info: ' || v_sqlerrm || chr(10) || 'Execute_sql:' ||
                   v_sql || chr(10) || 'Params: ' || chr(10) ||
                   'order_id: ' || v_inp_ordid || chr(10) ||
                   'pcome_amount: ' || to_char(v_inp_pcomeamt) || chr(10) ||
                   'wmsgot_amount: ' || to_char(v_inp_wmsgotamt) || chr(10) ||
                   'qual_decreamount: ' || to_char(v_inp_qualdecreamt) ||
                   chr(10) || 'qual_passamount: ' ||
                   to_char(v_inp_qualpassamt) || chr(10) || 'qual_result: ' ||
                   v_inp_qualresult || chr(10) || 'unqual_prosresult: ' ||
                   v_inp_unqualprosresult || chr(10) || 'arrive_retnum: ' ||
                   to_char(v_inp_arrretnum) || chr(10) || 'ae_reason: ' ||
                   v_inp_aereason || chr(10) || 'pcome_date: ' ||
                   to_char(v_inp_pcomedate, 'yyyy-mm-dd hh24-mi-ss') ||
                   chr(10) || 'scan_time: ' ||
                   to_char(v_inp_scantime, 'yyyy-mm-dd hh24-mi-ss') ||
                   chr(10) || 'receive_time: ' ||
                   to_char(v_inp_receivetime, 'yyyy-mm-dd hh24-mi-ss') ||
                   chr(10) || 'qual_finishtime: ' ||
                   to_char(v_inp_qualfinishtime, 'yyyy-mm-dd hh24-mi-ss') ||
                   chr(10) || 'asn_id: ' || v_inp_asnid || chr(10) ||
                   'company_id: ' || v_inp_compid;
    
      --新增进入错误信息表
      scmdata.pkg_qa_ee.p_ins_errrecord_at(v_inp_errprogram     => v_selfdescription,
                                           v_inp_causeerruserid => v_inp_operuserid,
                                           v_inp_erroccurtime   => SYSDATE,
                                           v_inp_errinfo        => v_errinfo,
                                           v_inp_compid         => v_inp_compid);
    
      --抛出报错
      raise_application_error(-20002, v_sqlerrm);
  END p_upd_qaqualedlistmas;

  /*=============================================================================
  
     包：
       pkg_qa_ld(qa逻辑细节包)
  
     函数名:
       获取 asn免检 barcode维度数据 sql
  
     入参:
       v_inp_invokeobj : 调用对象
  
     版本:
       2022-10-11_zc314 : 获取 asn免检 barcode维度数据 sql
  
  ==============================================================================*/
  FUNCTION f_get_asnae_barcodedim_sql(v_inp_invokeobj IN VARCHAR2)
    RETURN CLOB IS
    v_sql             CLOB;
    v_allowinvokeobj  CLOB := 'scmdata.pkg_qa_lc.p_iu_qaqualedlistsla';
    v_selfdescription VARCHAR2(1024) := 'scmdata.pkg_qa_ld.f_get_asnae_barcodedim_sql';
  BEGIN
    --访问控制
    IF instr(v_allowinvokeobj, v_inp_invokeobj) = 0 THEN
      raise_application_error(-20002,
                              '拒绝访问：调用方-' || v_inp_invokeobj || ' 被调用方-' ||
                              v_selfdescription);
    END IF;
  
    v_sql := 'SELECT asned.asn_id,
       asned.company_id,
       asns.goo_id,
       asnitem.barcode,
       asned.order_id,
       asnitem.pcome_amount,
       asnitem.wmsgot_amount,
       0 qualdecre_amount,
       asnitem.wmsgot_amount,
       ''AE'' qual_result,
       '''' unqual_prosresult,
       0 arrret_num,
       asned.ae_reason,
       asned.pcome_date,
       asned.scan_time,
       asnitem.receive_time,
       asned.ae_time,
       CASE WHEN INSTR(asnitem.barcode,''*'')>0 THEN asnitem.color_name ELSE colorsize.colorname END color_name,
       CASE WHEN INSTR(asnitem.barcode,''*'')>0 THEN NULL ELSE colorsize.sizename END size_name,
       ''SCM'' data_source,
       '''' wmsskucheck_result
  FROM scmdata.t_asnordered asned
  LEFT JOIN scmdata.t_asnorders asns
    ON asned.asn_id = asns.asn_id
   AND asned.company_id = asns.company_id
  LEFT JOIN scmdata.t_asnordersitem_itf asnitem
    ON asned.asn_id = asnitem.asn_id
   AND asned.company_id = asnitem.company_id
  LEFT JOIN scmdata.t_commodity_color_size colorsize
    ON asns.goo_id = colorsize.goo_id
   AND NVL(asnitem.barcode, '' '') = NVL(colorsize.barcode, '' '')
   AND asns.company_id = colorsize.company_id
 WHERE asned.asn_id = :a
   AND asned.company_id = :b
   AND asned.status = ''AE''';
  
    RETURN v_sql;
  END f_get_asnae_barcodedim_sql;

  /*=============================================================================
  
     包：
       pkg_qa_ld(qa逻辑细节包)
  
     函数名:
       获取 asn质检 barcode维度数据 sql
  
     入参:
       v_inp_invokeobj : 调用对象
  
     版本:
       2022-10-11_zc314 : 获取 asn质检 barcode维度数据 sql
  
  ==============================================================================*/
  FUNCTION f_get_asnfa_barcodedim_sql(v_inp_invokeobj IN VARCHAR2)
    RETURN CLOB IS
    v_sql             CLOB;
    v_allowinvokeobj  CLOB := 'scmdata.pkg_qa_lc.p_iu_qaqualedlistsla';
    v_selfdescription VARCHAR2(1024) := 'scmdata.pkg_qa_ld.f_get_asncd_barcodedim_sql';
  BEGIN
    --访问控制
    IF instr(v_allowinvokeobj, v_inp_invokeobj) = 0 THEN
      raise_application_error(-20002,
                              '拒绝访问：调用方-' || v_inp_invokeobj || ' 被调用方-' ||
                              v_selfdescription);
    END IF;
  
    --语句sql
    v_sql := 'SELECT repsku.asn_id,
       repsku.company_id,
       repsku.goo_id,
       repsku.barcode,
       asned.order_id,
       repsku.pcome_amount,
       repsku.wmsgot_amount,
       repsku.qualdecrease_amount,
       CASE
         WHEN repsku.skucheck_result = ''PS'' THEN
          decode(repsku.wmsgot_amount,
                 NULL,
                 repsku.pcome_amount - repsku.qualdecrease_amount,
                 repsku.wmsgot_amount - repsku.qualdecrease_amount)
         WHEN repsku.skucheck_result = ''NP'' AND
              repsku.skuprocessing_result NOT IN (''AWR'', ''WD'') THEN
          decode(repsku.wmsgot_amount,
                 NULL,
                 repsku.pcome_amount - repsku.qualdecrease_amount,
                 repsku.wmsgot_amount - repsku.qualdecrease_amount)
         ELSE
          0
       END AS qualpass_amount,
       repsku.skucheck_result,
       repsku.skuprocessing_result,
       repsku.reprocessed_number,
       asned.ae_reason,
       repsku.pcome_date,
       repsku.scan_time,
       repsku.receive_time,
       repsku.qualfinish_time,
       repsku.color_name,
       repsku.size_name,
       repsku.data_source,
       repsku.wmsskucheck_result
  FROM scmdata.t_qa_report_skudim repsku
  LEFT JOIN scmdata.t_asnordered asned
    ON repsku.asn_id = asned.asn_id
   AND repsku.company_id = asned.company_id
 WHERE (repsku.qa_report_id, repsku.company_id) IN
       (SELECT first_value(qa_report_id) OVER(PARTITION BY asn_id, company_id ORDER BY QUALFINISH_TIME DESC) qa_report_id,
               first_value(company_id) OVER(PARTITION BY asn_id, company_id ORDER BY QUALFINISH_TIME DESC) company_id
          FROM scmdata.t_qa_report_skudim
         WHERE asn_id = :v_inp_asnid
           AND company_id = :v_inp_compid)';
  
    RETURN v_sql;
  END f_get_asnfa_barcodedim_sql;

  /*=============================================================================
  
     包：
       pkg_qa_ld(qa逻辑细节包)
  
     函数名:
       asn已检列表主表增改数据 sql
  
     入参:
       v_inp_invokeobj : 调用对象
  
     版本:
       2022-10-11_zc314 : asn已检列表主表增改数据 sql
  
  ==============================================================================*/
  FUNCTION f_get_qualedlistmas_iusql(v_inp_invokeobj IN VARCHAR2) RETURN CLOB IS
    v_sql             CLOB;
    v_allowinvokeobj  CLOB := 'scmdata.pkg_qa_lc.p_iu_qaqualedlistmas';
    v_selfdescription VARCHAR2(1024) := 'scmdata.pkg_qa_ld.f_get_qualedlistmas_iusql';
  BEGIN
    --访问控制
    IF instr(v_allowinvokeobj, v_inp_invokeobj) = 0 THEN
      raise_application_error(-20002,
                              '拒绝访问：调用方-' || v_inp_invokeobj || ' 被调用方-' ||
                              v_selfdescription);
    END IF;
  
    v_sql := 'SELECT asn_id,
       company_id,
       order_id,
       pcome_amount,
       wmsgot_amount,
       qualdecre_amount,
       qual_passamount,
       CASE
         WHEN qual_result = ''PS'' THEN
           ''APS''
         WHEN qual_result = ''NP'' THEN
           ''ANP''
         WHEN qual_result = ''NP;PS'' OR qual_result = ''PS;NP'' THEN
           ''PNP''
         WHEN qual_result = ''AE'' THEN
           ''AE''
       END AS qual_result,
       unqual_prosresult,
       arrive_retnum,
       ae_reason,
       pcome_date,
       scan_time,
       receive_time,
       qual_finishtime
  FROM (SELECT asn_id,
               company_id,
               MAX(order_id) order_id,
               SUM(NVL(pcome_amount, 0)) pcome_amount,
               SUM(NVL(wmsgot_amount, 0)) wmsgot_amount,
               SUM(NVL(qual_decreamount, 0)) qualdecre_amount,
               SUM(NVL(qual_passamount, 0)) qual_passamount,
               listagg(DISTINCT qual_result, '';'') qual_result,
               listagg(DISTINCT unqual_prosresult, '';'') unqual_prosresult,
               MAX(arrive_retnum) arrive_retnum,
               listagg(DISTINCT ae_reason, '';'') ae_reason,
               MAX(pcome_date) pcome_date,
               MAX(scan_time) scan_time,
               MAX(receive_time) receive_time,
               MAX(qual_finishtime) qual_finishtime
          FROM scmdata.t_qaqualedlist_sla
         WHERE asn_id = :v_inp_asnid
           AND company_id = :v_inp_compid
         GROUP BY asn_id, company_id)';
  
    RETURN v_sql;
  END f_get_qualedlistmas_iusql;

  /*=============================================================================
  
     包：
       pkg_qa_ld(qa逻辑细节包)
  
     函数名:
       获取输入字段长度是否小于等于4000
  
     入参:
       v_inp_clob      : 输入值
       v_inp_invokeobj : 调用对象
  
     返回值:
       number 类型，0-大于4000 1-小于等于4000
  
     版本:
       2022-10-12_zc314 : 获取输入字段长度是否小于等于4000
  
  ==============================================================================*/
  FUNCTION f_is_cloblengthlessorequalfourk(v_inp_clob      IN CLOB,
                                           v_inp_invokeobj IN VARCHAR2)
    RETURN NUMBER IS
    v_length          NUMBER(16);
    v_jugnum          NUMBER(1);
    v_allowinvokeobj  CLOB := 'scmdata.pkg_qa_lc.p_check_multiselectallowmaxobjnum;scmdata.pkg_qa_lc.p_batch_passqarep';
    v_selfdescription VARCHAR2(1024) := 'scmdata.pkg_qa_ld.f_is_cloblengthlessorequalfourk';
  BEGIN
    --访问控制
    IF instr(v_allowinvokeobj, v_inp_invokeobj) = 0 THEN
      raise_application_error(-20002,
                              '拒绝访问：调用方-' || v_inp_invokeobj || ' 被调用方-' ||
                              v_selfdescription);
    END IF;
  
    v_length := length(v_inp_clob);
  
    IF v_length > 4000 THEN
      v_jugnum := 0;
    ELSE
      v_jugnum := 1;
    END IF;
  
    RETURN v_jugnum;
  END f_is_cloblengthlessorequalfourk;

  /*=============================================================================
  
     包：
       pkg_qa_ld(qa逻辑细节包)
  
     函数名:
       获取通过 asn 查询预计到仓总数，收货/上架总数 sql
  
     入参:
       v_inp_invokeobj : 调用对象
  
     版本:
       2022-10-12_zc314 : 获取通过 asn 查询预计到仓总数，收货/上架总数 sql
  
  ==============================================================================*/
  FUNCTION f_get_asnpcomeamoutandgotamount_sql(v_inp_invokeobj IN VARCHAR2)
    RETURN CLOB IS
    v_sql             CLOB;
    v_allowinvokeobj  CLOB := 'scmdata.pkg_qa_lc.p_ins_qareportinfo';
    v_selfdescription VARCHAR2(1024) := 'scmdata.pkg_qa_ld.f_get_asnpcomeamoutandgooid_sql';
  BEGIN
    --访问控制
    IF instr(v_allowinvokeobj, v_inp_invokeobj) = 0 THEN
      raise_application_error(-20002,
                              '拒绝访问：调用方-' || v_inp_invokeobj || ' 被调用方-' ||
                              v_selfdescription);
    END IF;
  
    v_sql := 'SELECT SUM(pcome_amount), SUM(wmsgot_amount) FROM scmdata.t_asnorders WHERE INSTR(:a, asn_id)>0 AND company_id = :b';
  
    RETURN v_sql;
  END f_get_asnpcomeamoutandgotamount_sql;

  /*=============================================================================
  
     包：
       pkg_qa_ld(qa逻辑细节包)
  
     函数名:
       qa质检报告主表新增
  
     入参:
       v_inp_qarepid              :  qa质检报告id
       v_inp_compid               :  企业id
       v_inp_status               :  状态
       v_inp_checktype            :  质检类型
       v_inp_checkresult          :  质检结果
       v_inp_problemclassifiction :  问题分类
       v_inp_problemdescription   :  问题描述
       v_inp_reviewcomments       :  审核意见
       v_inp_checks               :  查货员
       v_inp_checkdate            :  质检日期
       v_inp_qualattachment       :  质检附件
       v_inp_review_attachment    :  批复附件
       v_inp_memo                 :  备注
       v_inp_curuserid            :  当前操作人id
       v_inp_curtime              :  当前时间
       v_inp_ispriority           :  是否优先
       v_inp_invokeobj            :  调用对象
  
     版本:
       2022-10-12_zc314 : qa质检报告主表新增
       2022-10-13_zc314 : pkg_qa_ee 异常处理逻辑补充
  
  ==============================================================================*/
  PROCEDURE p_ins_qareportmas(v_inp_qarepid              IN VARCHAR2,
                              v_inp_compid               IN VARCHAR2,
                              v_inp_status               IN VARCHAR2,
                              v_inp_checktype            IN VARCHAR2,
                              v_inp_checkresult          IN VARCHAR2,
                              v_inp_problemclassifiction IN VARCHAR2,
                              v_inp_problemdescription   IN VARCHAR2,
                              v_inp_reviewcomments       IN VARCHAR2,
                              v_inp_checkers             IN VARCHAR2,
                              v_inp_checkdate            IN DATE,
                              v_inp_qualattachment       IN VARCHAR2,
                              v_inp_reviewattachment     IN VARCHAR2,
                              v_inp_memo                 IN VARCHAR2,
                              v_inp_curuserid            IN VARCHAR2,
                              v_inp_curtime              IN DATE,
                              v_inp_ispriority           IN NUMBER,
                              v_inp_invokeobj            IN VARCHAR2) IS
    priv_exception EXCEPTION;
    v_sql             CLOB;
    v_errinfo         CLOB;
    v_sqlerrm         VARCHAR2(512);
    v_allowinvokeobj  CLOB := 'scmdata.pkg_qa_lc.p_ins_qareportinfo;scmdata.pkg_qa_lc.p_gen_rcqarep';
    v_selfdescription VARCHAR2(1024) := 'scmdata.pkg_qa_ld.p_ins_qareportmas';
  BEGIN
    --访问控制
    IF instr(v_allowinvokeobj, v_inp_invokeobj) = 0 THEN
      v_sqlerrm := '拒绝访问：调用方-' || v_inp_invokeobj || ' 被调用方-' ||
                   v_selfdescription;
      RAISE priv_exception;
    END IF;
  
    --qa质检报告主表新增
    v_sql := 'INSERT INTO scmdata.t_qa_report
  (qa_report_id,
   company_id,
   status,
   check_type,
   check_result,
   problem_classification,
   problem_descriptions,
   review_comments,
   checkers,
   checkdate,
   qual_attachment,
   review_attachment,
   memo,
   is_priority,
   create_id,
   create_time)
VALUES
  (:v_inp_qarepid,
   :v_inp_compid,
   :v_inp_status,
   :v_inp_checktype,
   :v_inp_checkresult,
   :v_inp_problemclassifiction,
   :v_inp_problemdescription,
   :v_inp_reviewcomments,
   :v_inp_checkers,
   :v_inp_checkdate,
   :v_inp_qualattachment,
   :v_inp_reviewattachment,
   :v_inp_memo,
   :v_inp_ispriority,
   :v_inp_curuserid,
   :v_inp_curtime)';
  
    EXECUTE IMMEDIATE v_sql
      USING v_inp_qarepid, v_inp_compid, v_inp_status, v_inp_checktype, v_inp_checkresult, v_inp_problemclassifiction, v_inp_problemdescription, v_inp_reviewcomments, v_inp_checkers, v_inp_checkdate, v_inp_qualattachment, v_inp_reviewattachment, v_inp_memo, v_inp_ispriority, v_inp_curuserid, v_inp_curtime;
  
  EXCEPTION
    WHEN priv_exception THEN
      --抛出报错
      raise_application_error(-20002, v_sqlerrm);
    WHEN OTHERS THEN
      --错误信息赋值
      v_sqlerrm := substr(dbms_utility.format_error_stack, 1, 1024);
      v_errinfo := 'Error Object:' || v_selfdescription || chr(10) ||
                   'Error Info: ' || v_sqlerrm || chr(10) || 'Execute_sql:' ||
                   v_sql || chr(10) || 'Params: ' || chr(10) ||
                   'qa_report_id: ' || v_inp_qarepid || chr(10) ||
                   'company_id: ' || v_inp_compid || chr(10) || 'status: ' ||
                   v_inp_status || chr(10) || 'check_type: ' ||
                   v_inp_checktype || chr(10) || 'check_result: ' ||
                   v_inp_checkresult || chr(10) ||
                   'problem_classification: ' || v_inp_problemclassifiction ||
                   chr(10) || 'problem_descriptions: ' ||
                   v_inp_problemdescription || chr(10) ||
                   'review_comments: ' || v_inp_reviewcomments || chr(10) ||
                   'checkers: ' || v_inp_checkers || chr(10) ||
                   'checkdate: ' ||
                   to_char(v_inp_checkdate, 'yyyy-mm-dd hh24-mi-ss') ||
                   chr(10) || 'qual_attachment: ' || v_inp_qualattachment ||
                   chr(10) || 'review_attachment: ' ||
                   v_inp_reviewattachment || chr(10) || 'memo: ' ||
                   v_inp_memo || chr(10) || 'is_priority: ' ||
                   to_char(v_inp_ispriority) || chr(10) || 'create_id: ' ||
                   v_inp_curuserid || chr(10) || 'create_time: ' ||
                   to_char(v_inp_curtime, 'yyyy-mm-dd hh24-mi-ss');
    
      --新增进入错误信息表
      scmdata.pkg_qa_ee.p_ins_errrecord_at(v_inp_errprogram     => v_selfdescription,
                                           v_inp_causeerruserid => v_inp_curuserid,
                                           v_inp_erroccurtime   => SYSDATE,
                                           v_inp_errinfo        => v_errinfo,
                                           v_inp_compid         => v_inp_compid);
    
      --抛出报错
      raise_application_error(-20002, v_sqlerrm);
  END p_ins_qareportmas;

  /*=============================================================================
  
     包：
       pkg_qa_ld(qa逻辑细节包)
  
     函数名:
       qa质检报告主表修改
  
     入参:
       v_inp_qarepid              :  qa质检报告id
       v_inp_compid               :  企业id
       v_inp_status               :  状态
       v_inp_checktype            :  质检类型
       v_inp_checkresult          :  质检结果
       v_inp_problemclassifiction :  问题分类
       v_inp_problemdescription   :  问题描述
       v_inp_reviewcomments       :  审核意见
       v_inp_checks               :  查货员
       v_inp_checkdate            :  质检日期
       v_inp_qualattachment       :  质检附件
       v_inp_review_attachment    :  批复附件
       v_inp_memo                 :  备注
       v_inp_curuserid            :  当前操作人id
       v_inp_curtime              :  当前时间
       v_inp_invokeobj            :  调用对象
  
     版本:
       2022-10-12_zc314 : qa质检报告主表修改
       2022-10-13_zc314 : pkg_qa_ee 异常处理逻辑补充
  
  ==============================================================================*/
  PROCEDURE p_upd_qareportmas(v_inp_qarepid              IN VARCHAR2,
                              v_inp_compid               IN VARCHAR2,
                              v_inp_status               IN VARCHAR2,
                              v_inp_checktype            IN VARCHAR2,
                              v_inp_checkresult          IN VARCHAR2,
                              v_inp_problemclassifiction IN VARCHAR2,
                              v_inp_problemdescription   IN VARCHAR2,
                              v_inp_reviewcomments       IN VARCHAR2,
                              v_inp_checkers             IN VARCHAR2,
                              v_inp_checkdate            IN DATE,
                              v_inp_qualattachment       IN VARCHAR2,
                              v_inp_reviewattachment     IN VARCHAR2,
                              v_inp_memo                 IN VARCHAR2,
                              v_inp_curuserid            IN VARCHAR2,
                              v_inp_curtime              IN DATE,
                              v_inp_ispriority           IN NUMBER,
                              v_inp_invokeobj            IN VARCHAR2) IS
    priv_exception EXCEPTION;
    v_sql             CLOB;
    v_errinfo         CLOB;
    v_sqlerrm         VARCHAR2(512);
    v_allowinvokeobj  CLOB := 'scmdata.pkg_qa_lc.p_ins_qareportinfo';
    v_selfdescription VARCHAR2(1024) := 'scmdata.pkg_qa_ld.p_upd_qareportmas';
  BEGIN
    --访问控制
    IF instr(v_allowinvokeobj, v_inp_invokeobj) = 0 THEN
      v_sqlerrm := '拒绝访问：调用方-' || v_inp_invokeobj || ' 被调用方-' ||
                   v_selfdescription;
      RAISE priv_exception;
    END IF;
  
    --执行 sql 赋值
    v_sql := 'UPDATE scmdata.t_qa_report
   SET status                 = :v_inp_status,
       check_type             = :v_inp_checktype,
       check_result           = :v_inp_checkresult,
       problem_classification = :v_inp_problemclassifiction,
       problem_descriptions   = :v_inp_problemdescription,
       review_comments        = :v_inp_reviewcomments,
       checkers               = :v_inp_checkers,
       checkdate              = :v_inp_checkdate,
       qual_attachment        = :v_inp_qualattachment,
       review_attachment      = :v_inp_reviewattachment,
       memo                   = :v_inp_memo,
       is_priority            = :v_inp_ispriority,
       update_id              = :v_inp_curuserid,
       update_time            = :v_inp_curtime
 WHERE qa_report_id = :v_inp_qarepid
   AND company_id = :v_inp_compid';
  
    --执行 sql
    EXECUTE IMMEDIATE v_sql
      USING v_inp_status, v_inp_checktype, v_inp_checkresult, v_inp_problemclassifiction, v_inp_problemdescription, v_inp_reviewcomments, v_inp_checkers, v_inp_checkdate, v_inp_qualattachment, v_inp_reviewattachment, v_inp_memo, v_inp_curuserid, v_inp_curtime;
  
  EXCEPTION
    WHEN priv_exception THEN
      --抛出报错
      raise_application_error(-20002, v_sqlerrm);
    WHEN OTHERS THEN
      --错误信息赋值
      v_sqlerrm := substr(dbms_utility.format_error_stack, 1, 1024);
      v_errinfo := 'Error Object:' || v_selfdescription || chr(10) ||
                   'Error Info: ' || v_sqlerrm || chr(10) || 'Execute_sql:' ||
                   v_sql || chr(10) || 'Params: ' || chr(10) || 'status: ' ||
                   v_inp_status || chr(10) || 'check_type: ' ||
                   v_inp_checktype || chr(10) || 'check_result: ' ||
                   v_inp_checkresult || chr(10) ||
                   'problem_classification: ' || v_inp_problemclassifiction ||
                   chr(10) || 'problem_descriptions: ' ||
                   v_inp_problemdescription || chr(10) ||
                   'review_comments: ' || v_inp_reviewcomments || chr(10) ||
                   'checkers: ' || v_inp_checkers || chr(10) ||
                   'checkdate: ' ||
                   to_char(v_inp_checkdate, 'yyyy-mm-dd hh24-mi-ss') ||
                   chr(10) || 'qual_attachment: ' || v_inp_qualattachment ||
                   chr(10) || 'review_attachment: ' ||
                   v_inp_reviewattachment || chr(10) || 'memo: ' ||
                   v_inp_memo || chr(10) || 'is_priority: ' ||
                   to_char(v_inp_ispriority) || chr(10) || 'update_id: ' ||
                   v_inp_curuserid || chr(10) || 'update_time: ' ||
                   to_char(v_inp_curtime, 'yyyy-mm-dd hh24-mi-ss') ||
                   chr(10) || 'qa_report_id: ' || v_inp_qarepid || chr(10) ||
                   'company_id: ' || v_inp_compid;
    
      --新增进入错误信息表
      scmdata.pkg_qa_ee.p_ins_errrecord_at(v_inp_errprogram     => v_selfdescription,
                                           v_inp_causeerruserid => v_inp_curuserid,
                                           v_inp_erroccurtime   => SYSDATE,
                                           v_inp_errinfo        => v_errinfo,
                                           v_inp_compid         => v_inp_compid);
    
      --抛出报错
      raise_application_error(-20002, v_sqlerrm);
  END p_upd_qareportmas;

  /*=============================================================================
  
     包：
       pkg_qa_ld(qa逻辑细节包)
  
     函数名:
       qa质检报告报告级数字维度表新增
  
     入参:
       v_inp_qarepid                  :  qa质检报告id
       v_inp_compid                   :  企业id
       v_inp_firstsamplingamount      :  首抽件数
       v_inp_addsamplingamount        :  加抽件数
       v_inp_unqualsamplingamount     :  不合格件数
       v_inp_pcomesumamount           :  预计到仓总数
       v_inp_wmsgotsumamount          :  wms上架总数
       v_inp_qualdecreasesumamount    :  质检件数
       v_inp_prereprocessingsumamount :  待返工数量
       v_inp_operuserid               :  操作人id
       v_inp_invokeobj                :  调用对象
  
     版本:
       2022-10-12_zc314 : qa质检报告报告级数字维度表新增
  
  ==============================================================================*/
  PROCEDURE p_ins_qarepnumdim(v_inp_qarepid                  IN VARCHAR2,
                              v_inp_compid                   IN VARCHAR2,
                              v_inp_firstsamplingamount      IN NUMBER,
                              v_inp_addsamplingamount        IN NUMBER,
                              v_inp_unqualsamplingamount     IN NUMBER,
                              v_inp_pcomesumamount           IN NUMBER,
                              v_inp_wmsgotsumamount          IN NUMBER,
                              v_inp_qualdecreasesumamount    IN NUMBER,
                              v_inp_prereprocessingsumamount IN NUMBER,
                              v_inp_operuserid               IN VARCHAR2,
                              v_inp_invokeobj                IN VARCHAR2) IS
    priv_exception EXCEPTION;
    v_sql             CLOB;
    v_errinfo         CLOB;
    v_sqlerrm         VARCHAR2(512);
    v_allowinvokeobj  CLOB := 'scmdata.pkg_qa_lc.p_iu_qareportnumdim';
    v_selfdescription VARCHAR2(1024) := 'scmdata.pkg_qa_ld.p_ins_qarepnumdim';
  BEGIN
    --访问控制
    IF instr(v_allowinvokeobj, v_inp_invokeobj) = 0 THEN
      v_sqlerrm := '拒绝访问：调用方-' || v_inp_invokeobj || ' 被调用方-' ||
                   v_selfdescription;
      RAISE priv_exception;
    END IF;
  
    --执行 sql 赋值
    v_sql := 'INSERT INTO scmdata.t_qa_report_numdim
  (qa_report_id,
   company_id,
   firstsampling_amount,
   addsampling_amount,
   unqualsampling_amount,
   pcomesum_amount,
   wmsgotsum_amount,
   qualdecreasesum_amount,
   prereprocessingsum_amount)
VALUES
  (:v_inp_qarepid,
   :v_inp_compid,
   :v_inp_firstsamplingamount,
   :v_inp_addsamplingamount,
   :v_inp_unqualsamplingamount,
   :v_inp_pcomesumamount,
   :v_inp_wmsgotsumamount,
   :v_inp_qualdecreasesumamount,
   :v_inp_prereprocessingsumamount)';
  
    --执行 sql
    EXECUTE IMMEDIATE v_sql
      USING v_inp_qarepid, v_inp_compid, v_inp_firstsamplingamount, v_inp_addsamplingamount, v_inp_unqualsamplingamount, v_inp_pcomesumamount, v_inp_wmsgotsumamount, v_inp_qualdecreasesumamount, v_inp_prereprocessingsumamount;
  
  EXCEPTION
    WHEN priv_exception THEN
      --抛出报错
      raise_application_error(-20002, v_sqlerrm);
    WHEN OTHERS THEN
      --错误信息赋值
      v_sqlerrm := substr(dbms_utility.format_error_stack, 1, 1024);
      v_errinfo := 'Error Object:' || v_selfdescription || chr(10) ||
                   'Error Info: ' || v_sqlerrm || chr(10) || 'Execute_sql:' ||
                   v_sql || chr(10) || 'Params: ' || chr(10) ||
                   'qa_report_id: ' || v_inp_qarepid || chr(10) ||
                   'company_id: ' || v_inp_compid || chr(10) ||
                   'firstsampling_amount: ' ||
                   to_char(v_inp_firstsamplingamount) || chr(10) ||
                   'addsampling_amount: ' ||
                   to_char(v_inp_addsamplingamount) || chr(10) ||
                   'unqualsampling_amount: ' ||
                   to_char(v_inp_unqualsamplingamount) || chr(10) ||
                   'pcomesum_amount: ' || to_char(v_inp_pcomesumamount) ||
                   chr(10) || 'wmsgotsum_amount: ' ||
                   to_char(v_inp_wmsgotsumamount) || chr(10) ||
                   'qualdecreasesum_amount: ' ||
                   to_char(v_inp_qualdecreasesumamount) || chr(10) ||
                   'prereprocessingsum_amount: ' ||
                   to_char(v_inp_prereprocessingsumamount);
    
      --新增进入错误信息表
      scmdata.pkg_qa_ee.p_ins_errrecord_at(v_inp_errprogram     => v_selfdescription,
                                           v_inp_causeerruserid => v_inp_operuserid,
                                           v_inp_erroccurtime   => SYSDATE,
                                           v_inp_errinfo        => v_errinfo,
                                           v_inp_compid         => v_inp_compid);
    
      --抛出报错
      raise_application_error(-20002, v_sqlerrm);
  END p_ins_qarepnumdim;

  /*=============================================================================
  
     包：
       pkg_qa_ld(qa逻辑细节包)
  
     函数名:
       qa质检报告报告级数字维度表修改
  
     入参:
       v_inp_qarepid                  :  qa质检报告id
       v_inp_compid                   :  企业id
       v_inp_firstsamplingamount      :  首抽件数
       v_inp_addsamplingamount        :  加抽件数
       v_inp_unqualsamplingamount     :  不合格件数
       v_inp_pcomesumamount           :  预计到仓总数
       v_inp_wmsgotsumamount          :  wms上架总数
       v_inp_qualdecreasesumamount    :  质检件数
       v_inp_prereprocessingsumamount :  待返工数量
       v_inp_operuserid               :  操作人id
       v_inp_invokeobj                :  调用对象
  
     版本:
       2022-10-12_zc314 : qa质检报告报告级数字维度表修改
  
  ==============================================================================*/
  PROCEDURE p_upd_qarepnumdim(v_inp_qarepid                  IN VARCHAR2,
                              v_inp_compid                   IN VARCHAR2,
                              v_inp_firstsamplingamount      IN NUMBER,
                              v_inp_addsamplingamount        IN NUMBER,
                              v_inp_unqualsamplingamount     IN NUMBER,
                              v_inp_pcomesumamount           IN NUMBER,
                              v_inp_wmsgotsumamount          IN NUMBER,
                              v_inp_qualdecreasesumamount    IN NUMBER,
                              v_inp_prereprocessingsumamount IN NUMBER,
                              v_inp_operuserid               IN VARCHAR2,
                              v_inp_invokeobj                IN VARCHAR2) IS
    priv_exception EXCEPTION;
    v_sql             CLOB;
    v_errinfo         CLOB;
    v_sqlerrm         VARCHAR2(512);
    v_allowinvokeobj  CLOB := 'scmdata.pkg_qa_lc.p_iu_qareportnumdim';
    v_selfdescription VARCHAR2(1024) := 'scmdata.pkg_qa_ld.p_upd_qarepnumdim';
  BEGIN
    --访问控制
    IF instr(v_allowinvokeobj, v_inp_invokeobj) = 0 THEN
      v_sqlerrm := '拒绝访问：调用方-' || v_inp_invokeobj || ' 被调用方-' ||
                   v_selfdescription;
      RAISE priv_exception;
    END IF;
  
    --执行 sql 赋值
    v_sql := 'UPDATE scmdata.t_qa_report_numdim
   SET firstsampling_amount      = :v_inp_firstsamplingamount,
       addsampling_amount        = :v_inp_addsamplingamount,
       unqualsampling_amount     = :v_inp_unqualsamplingamount,
       pcomesum_amount           = :v_inp_pcomesumamount,
       wmsgotsum_amount          = :v_inp_wmsgotsumamount,
       qualdecreasesum_amount    = :v_inp_qualdecreasesumamount,
       prereprocessingsum_amount = :v_inp_prereprocessingsumamount
 WHERE qa_report_id = :v_inp_qarepid
   AND company_id = :v_inp_compid';
  
    --执行 sql
    EXECUTE IMMEDIATE v_sql
      USING v_inp_firstsamplingamount, v_inp_addsamplingamount, v_inp_unqualsamplingamount, v_inp_pcomesumamount, v_inp_wmsgotsumamount, v_inp_qualdecreasesumamount, v_inp_prereprocessingsumamount, v_inp_qarepid, v_inp_compid;
  
  EXCEPTION
    WHEN priv_exception THEN
      --抛出报错
      raise_application_error(-20002, v_sqlerrm);
    WHEN OTHERS THEN
      --错误信息赋值
      v_sqlerrm := substr(dbms_utility.format_error_stack, 1, 1024);
      v_errinfo := 'Error Object:' || v_selfdescription || chr(10) ||
                   'Error Info: ' || v_sqlerrm || chr(10) || 'Execute_sql:' ||
                   v_sql || chr(10) || 'Params: ' || chr(10) ||
                   'firstsampling_amount: ' ||
                   to_char(v_inp_firstsamplingamount) || chr(10) ||
                   'addsampling_amount: ' ||
                   to_char(v_inp_addsamplingamount) || chr(10) ||
                   'unqualsampling_amount: ' ||
                   to_char(v_inp_unqualsamplingamount) || chr(10) ||
                   'pcomesum_amount: ' || to_char(v_inp_pcomesumamount) ||
                   chr(10) || 'gotsum_amount: ' ||
                   to_char(v_inp_wmsgotsumamount) || chr(10) ||
                   'qualdecreasesum_amount: ' ||
                   to_char(v_inp_qualdecreasesumamount) || chr(10) ||
                   'prereprocessingsum_amount: ' ||
                   to_char(v_inp_prereprocessingsumamount) || chr(10) ||
                   'qa_report_id: ' || v_inp_qarepid || chr(10) ||
                   'company_id: ' || v_inp_compid;
    
      --新增进入错误信息表
      scmdata.pkg_qa_ee.p_ins_errrecord_at(v_inp_errprogram     => v_selfdescription,
                                           v_inp_causeerruserid => v_inp_operuserid,
                                           v_inp_erroccurtime   => SYSDATE,
                                           v_inp_errinfo        => v_errinfo,
                                           v_inp_compid         => v_inp_compid);
    
      --抛出报错
      raise_application_error(-20002, v_sqlerrm);
  END p_upd_qarepnumdim;

  /*=============================================================================
  
     包：
       pkg_qa_ld(qa逻辑细节包)
  
     函数名:
       qa质检报告sku维度表新增
  
     入参:
       v_inp_qarepid             :  qa质检报告id
       v_inp_compid              :  企业id
       v_inp_asnid               :  asn单号
       v_inp_gooid               :  商品档案编号
       v_inp_barcode             :  条码
       v_inp_status              :  状态: pa-待审核，pe-待处理，af-已完成
       v_inp_skuprocessingresult :  sku处理结果
       v_inp_skucheckresult      :  sku质检结果: ps-通过 np-不通过
       v_inp_pcomeamount         :  预计到仓数量
       v_inp_gotamount           :  收货/上架数量
       v_inp_qualdecreaseamount  :  质检减数
       v_inp_unqualamount        :  质检不合格数量
       v_inp_reprocessednumber   :  已到仓返工次数
       v_inp_pcomedate           :  预计到仓日期
       v_inp_scantime            :  到仓扫描时间
       v_inp_receivetime         :  收货/上架时间
       v_inp_reviewid            :  审核id
       v_inp_reviewtime          :  审核时间
       v_inp_colorname           :  颜色名称
       v_inp_sizename            :  尺码名称
       v_inp_qualfinishtime      :  质检结束时间
       v_inp_operuserid          :  操作人id
       v_inp_invokeobj           :  调用对象
  
     版本:
       2022-10-12_zc314 : qa质检报告sku维度表新增
       2022-10-13_zc314 : pkg_qa_ee 异常处理逻辑补充
       2022-10-26_zc314 : scmdata.t_qa_report_skudim
                          增加 color_name, size_name字段，完成对配码比支持
  
  ==============================================================================*/
  PROCEDURE p_ins_qareportskudim(v_inp_qarepid             IN VARCHAR2,
                                 v_inp_compid              IN VARCHAR2,
                                 v_inp_asnid               IN VARCHAR2,
                                 v_inp_gooid               IN VARCHAR2,
                                 v_inp_barcode             IN VARCHAR2,
                                 v_inp_status              IN VARCHAR2,
                                 v_inp_skuprocessingresult IN VARCHAR2,
                                 v_inp_skucheckresult      IN VARCHAR2,
                                 v_inp_pcomeamount         IN NUMBER,
                                 v_inp_wmsgotamount        IN NUMBER,
                                 v_inp_qualdecreaseamount  IN NUMBER,
                                 v_inp_unqualamount        IN NUMBER,
                                 v_inp_reprocessednumber   IN NUMBER,
                                 v_inp_pcomedate           IN DATE,
                                 v_inp_scantime            IN DATE,
                                 v_inp_receivetime         IN DATE,
                                 v_inp_reviewid            IN VARCHAR2,
                                 v_inp_reviewtime          IN DATE,
                                 v_inp_colorname           IN VARCHAR2,
                                 v_inp_sizename            IN VARCHAR2,
                                 v_inp_qualfinishtime      IN DATE,
                                 v_inp_operuserid          IN VARCHAR2,
                                 v_inp_invokeobj           IN VARCHAR2) IS
    priv_exception EXCEPTION;
    v_sql             CLOB;
    v_errinfo         CLOB;
    v_sqlerrm         VARCHAR2(512);
    v_allowinvokeobj  CLOB := 'scmdata.pkg_qa_lc.p_iu_qareportskudim';
    v_selfdescription VARCHAR2(1024) := 'scmdata.pkg_qa_ld.p_ins_qareportskudim';
  BEGIN
    --访问控制
    IF instr(v_allowinvokeobj, v_inp_invokeobj) = 0 THEN
      v_sqlerrm := '拒绝访问：调用方-' || v_inp_invokeobj || ' 被调用方-' ||
                   v_selfdescription;
      RAISE priv_exception;
    END IF;
  
    --执行 sql 赋值
    v_sql := 'INSERT INTO scmdata.t_qa_report_skudim
  (qa_report_id,
   company_id,
   asn_id,
   goo_id,
   barcode,
   status,
   skuprocessing_result,
   skucheck_result,
   pcome_amount,
   wmsgot_amount,
   qualdecrease_amount,
   unqual_amount,
   reprocessed_number,
   pcome_date,
   scan_time,
   receive_time,
   review_id,
   review_time,
   color_name,
   size_name,
   qualfinish_time)
VALUES
  (:v_inp_qarepid,
   :v_inp_compid,
   :v_inp_asnid,
   :v_inp_gooid,
   :v_inp_barcode,
   :v_inp_status,
   :v_inp_skuprocessingresult,
   :v_inp_skucheckresult,
   :v_inp_pcomeamount,
   :v_inp_wmsgotamount,
   :v_inp_qualdecreaseamount,
   :v_inp_unqualamount,
   :v_inp_reprocessednumber,
   :v_inp_pcomedate,
   :v_inp_scantime,
   :v_inp_receivetime,
   :v_inp_reviewid,
   :v_inp_reviewtime,
   :v_inp_colorname,
   :v_inp_sizename,
   :v_inp_qualfinishtime)';
  
    --执行 sql
    EXECUTE IMMEDIATE v_sql
      USING v_inp_qarepid, v_inp_compid, v_inp_asnid, v_inp_gooid, nvl(v_inp_barcode, v_inp_gooid), v_inp_status, v_inp_skuprocessingresult, v_inp_skucheckresult, v_inp_pcomeamount, v_inp_wmsgotamount, v_inp_qualdecreaseamount, v_inp_unqualamount, v_inp_reprocessednumber, v_inp_pcomedate, v_inp_scantime, v_inp_receivetime, v_inp_reviewid, v_inp_reviewtime, v_inp_colorname, v_inp_sizename, v_inp_qualfinishtime;
  
  EXCEPTION
    WHEN priv_exception THEN
      --抛出报错
      raise_application_error(-20002, v_sqlerrm);
    WHEN OTHERS THEN
      --错误信息赋值
      v_sqlerrm := substr(dbms_utility.format_error_stack, 1, 1024);
      v_errinfo := 'Error Object:' || v_selfdescription || chr(10) ||
                   'Error Info: ' || v_sqlerrm || chr(10) || 'Execute_sql:' ||
                   v_sql || chr(10) || 'Params: ' || chr(10) ||
                   'qa_report_id: ' || v_inp_qarepid || chr(10) ||
                   'company_id: ' || v_inp_compid || chr(10) || 'asn_id: ' ||
                   v_inp_asnid || chr(10) || 'goo_id: ' || v_inp_gooid ||
                   chr(10) || 'barcode: ' || v_inp_barcode || chr(10) ||
                   'status: ' || v_inp_status || chr(10) ||
                   'skuprocessing_result: ' || v_inp_skuprocessingresult ||
                   chr(10) || 'skucheck_result: ' || v_inp_skucheckresult ||
                   chr(10) || 'pcome_amount: ' ||
                   to_char(v_inp_pcomeamount) || chr(10) ||
                   'wmsgot_amount: ' || to_char(v_inp_wmsgotamount) ||
                   chr(10) || 'qualdecrease_amount: ' ||
                   to_char(v_inp_qualdecreaseamount) || chr(10) ||
                   'unqual_amount: ' || to_char(v_inp_unqualamount) ||
                   chr(10) || 'reprocessed_number: ' ||
                   to_char(v_inp_reprocessednumber) || chr(10) ||
                   'pcome_date: ' ||
                   to_char(v_inp_pcomedate, 'yyyy-mm-dd hh24-mi-ss') ||
                   chr(10) || 'scan_time: ' ||
                   to_char(v_inp_scantime, 'yyyy-mm-dd hh24-mi-ss') ||
                   chr(10) || 'receive_time: ' ||
                   to_char(v_inp_receivetime, 'yyyy-mm-dd hh24-mi-ss') ||
                   chr(10) || 'review_id: ' || v_inp_reviewid || chr(10) ||
                   'review_time: ' ||
                   to_char(v_inp_reviewtime, 'yyyy-mm-dd hh24-mi-ss') ||
                   chr(10) || 'color_name: ' || v_inp_colorname || chr(10) ||
                   'size_name: ' || v_inp_sizename || chr(10) ||
                   'qualfinish_time: ' ||
                   to_char(v_inp_qualfinishtime, 'yyyy-mm-dd hh24-mi-ss');
    
      --新增进入错误信息表
      scmdata.pkg_qa_ee.p_ins_errrecord_at(v_inp_errprogram     => v_selfdescription,
                                           v_inp_causeerruserid => v_inp_operuserid,
                                           v_inp_erroccurtime   => SYSDATE,
                                           v_inp_errinfo        => v_errinfo,
                                           v_inp_compid         => v_inp_compid);
    
      --抛出报错
      raise_application_error(-20002, v_sqlerrm);
  END p_ins_qareportskudim;

  /*=============================================================================
  
     包：
       pkg_qa_ld(qa逻辑细节包)
  
     函数名:
       qa质检报告sku维度表修改
  
     入参:
       v_inp_qarepid             :  qa质检报告id
       v_inp_compid              :  企业id
       v_inp_asnid               :  asn单号
       v_inp_gooid               :  商品档案编号
       v_inp_barcode             :  条码
       v_inp_status              :  状态: pa-待审核，pe-待处理，af-已完成
       v_inp_skuprocessingresult :  sku处理结果
       v_inp_skucheckresult      :  sku质检结果: ps-通过 np-不通过
       v_inp_pcomeamount         :  预计到仓数量
       v_inp_wmsgotamount        :  wms上架数量
       v_inp_qualdecreaseamount  :  质检减数
       v_inp_unqualamount        :  质检不合格数量
       v_inp_scantime            :  到仓扫描时间
       v_inp_receivetime         :  收货/上架时间
       v_inp_reviewid            :  审核id
       v_inp_reviewtime          :  审核时间
       v_inp_colorname           :  颜色名称
       v_inp_sizename            :  尺码名称
       v_inp_qualfinishtime      :  质检结束时间
       v_inp_operuserid          :  操作人id
       v_inp_invokeobj           :  调用对象
  
     版本:
       2022-10-12_zc314 : qa质检报告sku维度表修改
       2022-10-13_zc314 : pkg_qa_ee 异常处理逻辑补充
       2022-10-26_zc314 : scmdata.t_qa_report_skudim
                         增加 color_name, size_name字段，完成对配码比支持
  
  ==============================================================================*/
  PROCEDURE p_upd_qareportskudim(v_inp_qarepid             IN VARCHAR2,
                                 v_inp_compid              IN VARCHAR2,
                                 v_inp_asnid               IN VARCHAR2,
                                 v_inp_gooid               IN VARCHAR2,
                                 v_inp_barcode             IN VARCHAR2,
                                 v_inp_status              IN VARCHAR2,
                                 v_inp_skuprocessingresult IN VARCHAR2,
                                 v_inp_skucheckresult      IN VARCHAR2,
                                 v_inp_pcomeamount         IN NUMBER,
                                 v_inp_wmsgotamount        IN NUMBER,
                                 v_inp_qualdecreaseamount  IN NUMBER,
                                 v_inp_unqualamount        IN NUMBER,
                                 v_inp_reprocessednumber   IN NUMBER,
                                 v_inp_pcomedate           IN DATE,
                                 v_inp_scantime            IN DATE,
                                 v_inp_receivetime         IN DATE,
                                 v_inp_reviewid            IN VARCHAR2,
                                 v_inp_reviewtime          IN DATE,
                                 v_inp_colorname           IN VARCHAR2,
                                 v_inp_sizename            IN VARCHAR2,
                                 v_inp_qualfinishtime      IN DATE,
                                 v_inp_operuserid          IN VARCHAR2,
                                 v_inp_invokeobj           IN VARCHAR2) IS
    priv_exception EXCEPTION;
    v_sql             CLOB;
    v_errinfo         CLOB;
    v_sqlerrm         VARCHAR2(512);
    v_allowinvokeobj  CLOB := 'scmdata.pkg_qa_lc.p_iu_qareportskudim';
    v_selfdescription VARCHAR2(1024) := 'scmdata.pkg_qa_ld.p_upd_qareportskudim';
  BEGIN
    --访问控制
    IF instr(v_allowinvokeobj, v_inp_invokeobj) = 0 THEN
      v_sqlerrm := '拒绝访问：调用方-' || v_inp_invokeobj || ' 被调用方-' ||
                   v_selfdescription;
      RAISE priv_exception;
    END IF;
  
    --执行 sql 赋值
    v_sql := 'UPDATE scmdata.t_qa_report_skudim
   SET status               = :v_inp_status,
       skuprocessing_result = :v_inp_skuprocessingresult,
       skucheck_result      = :v_inp_skucheckresult,
       pcome_amount         = :v_inp_pcomeamount,
       wmsgot_amount        = :v_inp_wmsgotamount,
       qualdecrease_amount  = :v_inp_qualdecreaseamount,
       unqual_amount        = :v_inp_unqualamount,
       reprocessed_number   = :v_inp_reprocessednumber,
       pcome_date           = :v_inp_pcomedate,
       scan_time            = :v_inp_scantime,
       receive_time         = :v_inp_receivetime,
       review_id            = :v_inp_reviewid,
       review_time          = :v_inp_reviewtime,
       color_name           = :v_inp_colorname,
       size_name            = :v_inp_sizename,
       qualfinish_time      = :v_inp_qualfinishtime
 WHERE qa_report_id = :v_inp_qarepid
   AND company_id = :v_inp_compid
   AND asn_id = :v_inp_asnid
   AND goo_id = :v_inp_gooid
   AND nvl(barcode, '' '') = nvl(:v_inp_barcode, '' '')';
  
    --执行 sql
    EXECUTE IMMEDIATE v_sql
      USING v_inp_status, v_inp_skuprocessingresult, v_inp_skucheckresult, v_inp_pcomeamount, v_inp_wmsgotamount, v_inp_qualdecreaseamount, v_inp_unqualamount, v_inp_reprocessednumber, v_inp_pcomedate, v_inp_scantime, v_inp_receivetime, v_inp_reviewid, v_inp_reviewtime, v_inp_colorname, v_inp_sizename, v_inp_qualfinishtime, v_inp_qarepid, v_inp_compid, v_inp_asnid, v_inp_gooid, nvl(v_inp_barcode, v_inp_gooid);
  
  EXCEPTION
    WHEN priv_exception THEN
      --抛出报错
      raise_application_error(-20002, v_sqlerrm);
    WHEN OTHERS THEN
      --错误信息赋值
      v_sqlerrm := substr(dbms_utility.format_error_stack, 1, 1024);
      v_errinfo := 'Error Object:' || v_selfdescription || chr(10) ||
                   'Error Info: ' || v_sqlerrm || chr(10) || 'Execute_sql:' ||
                   v_sql || chr(10) || 'Params: ' || chr(10) || 'status: ' ||
                   v_inp_status || chr(10) || 'skuprocessing_result: ' ||
                   v_inp_skuprocessingresult || chr(10) ||
                   'skucheck_result: ' || v_inp_skucheckresult || chr(10) ||
                   'pcome_amount: ' || to_char(v_inp_pcomeamount) ||
                   chr(10) || 'wmsgot_amount: ' ||
                   to_char(v_inp_wmsgotamount) || chr(10) ||
                   'qualdecrease_amount: ' ||
                   to_char(v_inp_qualdecreaseamount) || chr(10) ||
                   'unqual_amount: ' || to_char(v_inp_unqualamount) ||
                   chr(10) || 'reprocessed_number: ' ||
                   to_char(v_inp_reprocessednumber) || chr(10) ||
                   'pcome_date: ' ||
                   to_char(v_inp_pcomedate, 'yyyy-mm-dd hh24-mi-ss') ||
                   chr(10) || 'scan_time: ' ||
                   to_char(v_inp_scantime, 'yyyy-mm-dd hh24-mi-ss') ||
                   chr(10) || 'receive_time: ' ||
                   to_char(v_inp_receivetime, 'yyyy-mm-dd hh24-mi-ss') ||
                   chr(10) || 'review_id: ' || to_char(v_inp_reviewid) ||
                   chr(10) || 'review_time: ' ||
                   to_char(v_inp_reviewtime, 'yyyy-mm-dd hh24-mi-ss') ||
                   chr(10) || 'color_name: ' || v_inp_colorname || chr(10) ||
                   'size_name: ' || v_inp_sizename || chr(10) ||
                   'qualfinish_time: ' ||
                   to_char(v_inp_qualfinishtime, 'yyyy-mm-dd hh24-mi-ss') ||
                   chr(10) || 'qa_report_id: ' || v_inp_qarepid || chr(10) ||
                   'company_id: ' || v_inp_compid || chr(10) || 'asn_id: ' ||
                   v_inp_asnid || chr(10) || 'goo_id: ' || v_inp_gooid ||
                   chr(10) || 'barcode: ' || v_inp_barcode;
    
      --新增进入错误信息表
      scmdata.pkg_qa_ee.p_ins_errrecord_at(v_inp_errprogram     => v_selfdescription,
                                           v_inp_causeerruserid => v_inp_operuserid,
                                           v_inp_erroccurtime   => SYSDATE,
                                           v_inp_errinfo        => v_errinfo,
                                           v_inp_compid         => v_inp_compid);
    
      --抛出报错
      raise_application_error(-20002, v_sqlerrm);
  END p_upd_qareportskudim;

  /*=============================================================================
  
     包：
       pkg_qa_ld(qa逻辑细节包)
  
     函数名:
       qa质检报告关联信息维度表新增
  
     入参:
       v_inp_qarepid     :  qa质检报告id
       v_inp_compid      :  企业id
       v_inp_asnid       :  asn单号
       v_inp_gooid       :  商品档案编号
       v_inp_orderid     :  订单号
       v_inp_supcode     :  供应商编码
       v_inp_faccode     :  生产工厂编码
       v_inp_shoid       :  仓库id
       v_inp_operuserid  :  当前操作人id
       v_inp_invokeobj   :  调用对象
  
     版本:
       2022-10-13_zc314 : qa质检报告关联信息维度表新增
  
  ==============================================================================*/
  PROCEDURE p_ins_qareportrelainfodim(v_inp_qarepid    IN VARCHAR2,
                                      v_inp_compid     IN VARCHAR2,
                                      v_inp_asnid      IN VARCHAR2,
                                      v_inp_gooid      IN VARCHAR2,
                                      v_inp_orderid    IN VARCHAR2,
                                      v_inp_supcode    IN VARCHAR2,
                                      v_inp_faccode    IN VARCHAR2,
                                      v_inp_shoid      IN VARCHAR2,
                                      v_inp_operuserid IN VARCHAR2,
                                      v_inp_invokeobj  IN VARCHAR2) IS
    priv_exception EXCEPTION;
    v_sql             CLOB;
    v_errinfo         CLOB;
    v_sqlerrm         VARCHAR2(512);
    v_allowinvokeobj  CLOB := 'scmdata.pkg_qa_lc.p_iu_qareportrelainfodim';
    v_selfdescription VARCHAR2(1024) := 'scmdata.pkg_qa_ld.p_ins_qareportrelainfodim';
  BEGIN
    --访问控制
    IF instr(v_allowinvokeobj, v_inp_invokeobj) = 0 THEN
      v_sqlerrm := '拒绝访问：调用方-' || v_inp_invokeobj || ' 被调用方-' ||
                   v_selfdescription;
      RAISE priv_exception;
    END IF;
  
    --执行 sql 赋值
    v_sql := 'INSERT INTO scmdata.t_qa_report_relainfodim
    (qa_report_id,
     company_id,
     asn_id,
     goo_id,
     order_id,
     supplier_code,
     factory_code,
     sho_id)
  VALUES
    (:v_inp_qarepid,
     :v_inp_compid,
     :v_inp_asnid,
     :v_inp_gooid,
     :v_inp_orderid,
     :v_inp_supcode,
     :v_inp_faccode,
     :v_inp_shoid)';
  
    --执行 sql
    EXECUTE IMMEDIATE v_sql
      USING v_inp_qarepid, v_inp_compid, v_inp_asnid, v_inp_gooid, v_inp_orderid, v_inp_supcode, v_inp_faccode, v_inp_shoid;
  
  EXCEPTION
    WHEN priv_exception THEN
      --抛出报错
      raise_application_error(-20002, v_sqlerrm);
    WHEN OTHERS THEN
      --错误信息赋值
      v_sqlerrm := substr(dbms_utility.format_error_stack, 1, 1024);
      v_errinfo := 'Error Object:' || v_selfdescription || chr(10) ||
                   'Error Info: ' || v_sqlerrm || chr(10) || 'Execute_sql:' ||
                   v_sql || chr(10) || 'Params: ' || chr(10) ||
                   'qa_report_id: ' || v_inp_qarepid || chr(10) ||
                   'company_id: ' || v_inp_compid || chr(10) || 'asn_id: ' ||
                   v_inp_asnid || chr(10) || 'goo_id: ' || v_inp_gooid ||
                   chr(10) || 'order_id: ' || v_inp_orderid || chr(10) ||
                   'supplier_code: ' || v_inp_supcode || chr(10) ||
                   'factory_code: ' || v_inp_faccode || chr(10) ||
                   'sho_id: ' || v_inp_shoid;
    
      --新增进入错误信息表
      scmdata.pkg_qa_ee.p_ins_errrecord_at(v_inp_errprogram     => v_selfdescription,
                                           v_inp_causeerruserid => v_inp_operuserid,
                                           v_inp_erroccurtime   => SYSDATE,
                                           v_inp_errinfo        => v_errinfo,
                                           v_inp_compid         => v_inp_compid);
    
      --抛出报错
      raise_application_error(-20002, v_sqlerrm);
  END p_ins_qareportrelainfodim;

  /*=============================================================================
  
     包：
       pkg_qa_ld(qa逻辑细节包)
  
     函数名:
       qa质检报告关联信息维度表修改
  
     入参:
       v_inp_qarepid     :  qa质检报告id
       v_inp_compid      :  企业id
       v_inp_asnid       :  asn单号
       v_inp_gooid       :  商品档案编号
       v_inp_orderid     :  订单号
       v_inp_supcode     :  供应商编码
       v_inp_faccode     :  生产工厂编码
       v_inp_shoid       :  仓库id
       v_inp_operuserid  :  当前操作人id
       v_inp_invokeobj   :  调用对象
  
     版本:
       2022-10-13_zc314 : qa质检报告关联信息维度表修改
  
  ==============================================================================*/
  PROCEDURE p_upd_qareportrelainfodim(v_inp_qarepid    IN VARCHAR2,
                                      v_inp_compid     IN VARCHAR2,
                                      v_inp_asnid      IN VARCHAR2,
                                      v_inp_gooid      IN VARCHAR2,
                                      v_inp_orderid    IN VARCHAR2,
                                      v_inp_supcode    IN VARCHAR2,
                                      v_inp_faccode    IN VARCHAR2,
                                      v_inp_shoid      IN VARCHAR2,
                                      v_inp_operuserid IN VARCHAR2,
                                      v_inp_invokeobj  IN VARCHAR2) IS
    priv_exception EXCEPTION;
    v_sql             CLOB;
    v_errinfo         CLOB;
    v_sqlerrm         VARCHAR2(512);
    v_allowinvokeobj  CLOB := 'scmdata.pkg_qa_lc.p_iu_qareportrelainfodim';
    v_selfdescription VARCHAR2(1024) := 'scmdata.pkg_qa_ld.p_upd_qareportrelainfodim';
  BEGIN
    --访问控制
    IF instr(v_allowinvokeobj, v_inp_invokeobj) = 0 THEN
      v_sqlerrm := '拒绝访问：调用方-' || v_inp_invokeobj || ' 被调用方-' ||
                   v_selfdescription;
      RAISE priv_exception;
    END IF;
  
    --执行 sql 赋值
    v_sql := 'UPDATE scmdata.t_qa_report_relainfodim
     SET asn_id   = :v_inp_asnid,
         goo_id   = :v_inp_gooid,
         order_id = :v_inp_orderid,
         supplier_code = :v_inp_supcode,
         factory_code = :v_inp_faccode,
         sho_id = :v_inp_shoid
   WHERE qa_report_id = :v_inp_qarepid
     AND company_id = :v_inp_compid';
  
    --执行 sql
    EXECUTE IMMEDIATE v_sql
      USING v_inp_asnid, v_inp_gooid, v_inp_orderid, v_inp_supcode, v_inp_faccode, v_inp_shoid, v_inp_qarepid, v_inp_compid;
  
  EXCEPTION
    WHEN priv_exception THEN
      --抛出报错
      raise_application_error(-20002, v_sqlerrm);
    WHEN OTHERS THEN
      --错误信息赋值
      v_sqlerrm := substr(dbms_utility.format_error_stack, 1, 1024);
      v_errinfo := 'Error Object:' || v_selfdescription || chr(10) ||
                   'Error Info: ' || v_sqlerrm || chr(10) || 'Execute_sql:' ||
                   v_sql || chr(10) || 'Params: ' || chr(10) || 'asn_id: ' ||
                   v_inp_asnid || chr(10) || 'goo_id: ' || v_inp_gooid ||
                   chr(10) || 'order_id: ' || v_inp_orderid || chr(10) ||
                   'supplier_code: ' || v_inp_supcode || chr(10) ||
                   'factory_code: ' || v_inp_faccode || chr(10) ||
                   'sho_id: ' || v_inp_shoid || chr(10) || 'qa_report_id: ' ||
                   v_inp_qarepid || chr(10) || 'company_id: ' ||
                   v_inp_compid;
    
      --新增进入错误信息表
      scmdata.pkg_qa_ee.p_ins_errrecord_at(v_inp_errprogram     => v_selfdescription,
                                           v_inp_causeerruserid => v_inp_operuserid,
                                           v_inp_erroccurtime   => SYSDATE,
                                           v_inp_errinfo        => v_errinfo,
                                           v_inp_compid         => v_inp_compid);
    
      --抛出报错
      raise_application_error(-20002, v_sqlerrm);
  END p_upd_qareportrelainfodim;

  /*=============================================================================
  
     包：
       pkg_qa_ld(qa逻辑细节包)
  
     函数名:
       qa质检报告报告级质检细节表新增
  
     入参:
       v_inp_qarepid            :  qa质检报告id
       v_inp_compid             :  企业id
       v_inp_yyresult           :  样衣结果
       v_inp_yyunqualsubjects   :  样衣不合格项
       v_inp_mflresult          :  面辅料结果
       v_inp_mflunqualsubjects  :  面辅料不合格项
       v_inp_gyresult           :  工艺结果
       v_inp_gyunqualsubjects   :  工艺不合格项
       v_inp_bxresult           :  版型结果
       v_inp_bxuqualsubjects    :  版型不合格项
       v_inp_scaleamount        :  度尺件数
       v_inp_operuserid         :  操作人id
       v_inp_invokeobj          :  调用对象
  
     版本:
       2022-10-12_zc314 : qa质检报告报告级质检细节表新增
  
  ==============================================================================*/
  PROCEDURE p_ins_qarepcheckdetaildim(v_inp_qarepid           IN VARCHAR2,
                                      v_inp_compid            IN VARCHAR2,
                                      v_inp_yyresult          IN VARCHAR2,
                                      v_inp_yyunqualsubjects  IN VARCHAR2,
                                      v_inp_mflresult         IN VARCHAR2,
                                      v_inp_mflunqualsubjects IN VARCHAR2,
                                      v_inp_gyresult          IN VARCHAR2,
                                      v_inp_gyunqualsubjects  IN VARCHAR2,
                                      v_inp_bxresult          IN VARCHAR2,
                                      v_inp_bxuqualsubjects   IN VARCHAR2,
                                      v_inp_scaleamount       IN NUMBER,
                                      v_inp_operuserid        IN VARCHAR2,
                                      v_inp_invokeobj         IN VARCHAR2) IS
    priv_exception EXCEPTION;
    v_sql             CLOB;
    v_errinfo         CLOB;
    v_sqlerrm         VARCHAR2(512);
    v_allowinvokeobj  CLOB := 'scmdata.pkg_qa_lc.p_iu_qareportcheckdetaildim';
    v_selfdescription VARCHAR2(1024) := 'scmdata.pkg_qa_ld.p_ins_qarepnumdim';
  BEGIN
    --访问控制
    IF instr(v_allowinvokeobj, v_inp_invokeobj) = 0 THEN
      v_sqlerrm := '拒绝访问：调用方-' || v_inp_invokeobj || ' 被调用方-' ||
                   v_selfdescription;
      RAISE priv_exception;
    END IF;
  
    --执行 sql 赋值
    v_sql := 'INSERT INTO scmdata.t_qa_report_checkdetaildim
  (qa_report_id,
   company_id,
   yy_result,
   yy_uqualsubjects,
   mfl_result,
   mfl_uqualsubjects,
   gy_result,
   gy_uqualsubjects,
   bx_result,
   bx_uqualsubjects,
   scale_amount)
VALUES
  (:v_inp_qarepid,
   :v_inp_compid,
   :v_inp_yyresult,
   :v_inp_yyunqualsubjects,
   :v_inp_mflresult,
   :v_inp_mflunqualsubjects,
   :v_inp_gyresult,
   :v_inp_gyunqualsubjects,
   :v_inp_bxresult,
   :v_inp_bxuqualsubjects,
   :v_inp_scaleamount)';
  
    --执行 sql
    EXECUTE IMMEDIATE v_sql
      USING v_inp_qarepid, v_inp_compid, v_inp_yyresult, v_inp_yyunqualsubjects, v_inp_mflresult, v_inp_mflunqualsubjects, v_inp_gyresult, v_inp_gyunqualsubjects, v_inp_bxresult, v_inp_bxuqualsubjects, v_inp_scaleamount;
  
  EXCEPTION
    WHEN priv_exception THEN
      --抛出报错
      raise_application_error(-20002, v_sqlerrm);
    WHEN OTHERS THEN
      --错误信息赋值
      v_sqlerrm := substr(dbms_utility.format_error_stack, 1, 1024);
      v_errinfo := 'Error Object:' || v_selfdescription || chr(10) ||
                   'Error Info: ' || v_sqlerrm || chr(10) || 'Execute_sql:' ||
                   v_sql || chr(10) || 'Params: ' || chr(10) ||
                   'v_inp_qarepid: ' || v_inp_qarepid || chr(10) ||
                   'v_inp_compid: ' || v_inp_compid || chr(10) ||
                   'v_inp_yyresult: ' || v_inp_yyresult || chr(10) ||
                   'v_inp_yyunqualsubjects: ' || v_inp_yyunqualsubjects ||
                   chr(10) || 'v_inp_mflresult: ' || v_inp_mflresult ||
                   chr(10) || 'v_inp_mflunqualsubjects: ' ||
                   v_inp_mflunqualsubjects || chr(10) || 'v_inp_gyresult: ' ||
                   v_inp_gyresult || chr(10) || 'v_inp_gyunqualsubjects: ' ||
                   v_inp_gyunqualsubjects || chr(10) || 'v_inp_bxresult: ' ||
                   v_inp_bxresult || chr(10) || 'v_inp_bxuqualsubjects: ' ||
                   v_inp_bxuqualsubjects || chr(10) ||
                   'v_inp_scaleamount: ' || v_inp_scaleamount;
    
      --新增进入错误信息表
      scmdata.pkg_qa_ee.p_ins_errrecord_at(v_inp_errprogram     => v_selfdescription,
                                           v_inp_causeerruserid => v_inp_operuserid,
                                           v_inp_erroccurtime   => SYSDATE,
                                           v_inp_errinfo        => v_errinfo,
                                           v_inp_compid         => v_inp_compid);
    
      --抛出报错
      raise_application_error(-20002, v_sqlerrm);
  END p_ins_qarepcheckdetaildim;

  /*=============================================================================
  
     包：
       pkg_qa_ld(qa逻辑细节包)
  
     函数名:
       qa质检报告报告级质检细节表修改
  
     入参:
       v_inp_qarepid            :  qa质检报告id
       v_inp_compid             :  企业id
       v_inp_yyresult           :  样衣结果
       v_inp_yyunqualsubjects   :  样衣不合格项
       v_inp_mflresult          :  面辅料结果
       v_inp_mflunqualsubjects  :  面辅料不合格项
       v_inp_gyresult           :  工艺结果
       v_inp_gyunqualsubjects   :  工艺不合格项
       v_inp_bxresult           :  版型结果
       v_inp_bxuqualsubjects    :  版型不合格项
       v_inp_scaleamount        :  度尺件数
       v_inp_operuserid         :  操作人id
       v_inp_invokeobj          :  调用对象
  
     版本:
       2022-10-12_zc314 : qa质检报告报告级质检细节表修改
  
  ==============================================================================*/
  PROCEDURE p_upd_qarepcheckdetaildim(v_inp_qarepid           IN VARCHAR2,
                                      v_inp_compid            IN VARCHAR2,
                                      v_inp_yyresult          IN VARCHAR2,
                                      v_inp_yyunqualsubjects  IN VARCHAR2,
                                      v_inp_mflresult         IN VARCHAR2,
                                      v_inp_mflunqualsubjects IN VARCHAR2,
                                      v_inp_gyresult          IN VARCHAR2,
                                      v_inp_gyunqualsubjects  IN VARCHAR2,
                                      v_inp_bxresult          IN VARCHAR2,
                                      v_inp_bxuqualsubjects   IN VARCHAR2,
                                      v_inp_scaleamount       IN NUMBER,
                                      v_inp_operuserid        IN VARCHAR2,
                                      v_inp_invokeobj         IN VARCHAR2) IS
    priv_exception EXCEPTION;
    v_sql             CLOB;
    v_errinfo         CLOB;
    v_sqlerrm         VARCHAR2(512);
    v_allowinvokeobj  CLOB := 'scmdata.pkg_qa_lc.p_iu_qareportcheckdetaildim';
    v_selfdescription VARCHAR2(1024) := 'scmdata.pkg_qa_ld.p_ins_qarepnumdim';
  BEGIN
    --访问控制
    IF instr(v_allowinvokeobj, v_inp_invokeobj) = 0 THEN
      v_sqlerrm := '拒绝访问：调用方-' || v_inp_invokeobj || ' 被调用方-' ||
                   v_selfdescription;
      RAISE priv_exception;
    END IF;
  
    --执行 sql 赋值
    v_sql := 'UPDATE scmdata.t_qa_report_checkdetaildim
   SET yy_result         = :v_inp_yyresult,
       yy_uqualsubjects  = :v_inp_yyunqualsubjects,
       mfl_result        = :v_inp_mflresult,
       mfl_uqualsubjects = :v_inp_mflunqualsubjects,
       gy_result         = :v_inp_gyresult,
       gy_uqualsubjects  = :v_inp_gyunqualsubjects,
       bx_result         = :v_inp_bxresult,
       bx_uqualsubjects  = :v_inp_bxuqualsubjects,
       scale_amount      = :v_inp_scaleamount
 WHERE qa_report_id = :v_inp_qarepid
   AND company_id = :v_inp_compid)';
  
    --执行 sql
    EXECUTE IMMEDIATE v_sql
      USING v_inp_yyresult, v_inp_yyunqualsubjects, v_inp_mflresult, v_inp_mflunqualsubjects, v_inp_gyresult, v_inp_gyunqualsubjects, v_inp_bxresult, v_inp_bxuqualsubjects, v_inp_scaleamount, v_inp_qarepid, v_inp_compid;
  
  EXCEPTION
    WHEN priv_exception THEN
      --抛出报错
      raise_application_error(-20002, v_sqlerrm);
    WHEN OTHERS THEN
      --错误信息赋值
      v_sqlerrm := substr(dbms_utility.format_error_stack, 1, 1024);
      v_errinfo := 'Error Object:' || v_selfdescription || chr(10) ||
                   'Error Info: ' || v_sqlerrm || chr(10) || 'Execute_sql:' ||
                   v_sql || chr(10) || 'Params: ' || chr(10) ||
                   'v_inp_yyresult: ' || v_inp_yyresult || chr(10) ||
                   'v_inp_yyunqualsubjects: ' || v_inp_yyunqualsubjects ||
                   chr(10) || 'v_inp_mflresult: ' || v_inp_mflresult ||
                   chr(10) || 'v_inp_mflunqualsubjects: ' ||
                   v_inp_mflunqualsubjects || chr(10) || 'v_inp_gyresult: ' ||
                   v_inp_gyresult || chr(10) || 'v_inp_gyunqualsubjects: ' ||
                   v_inp_gyunqualsubjects || chr(10) || 'v_inp_bxresult: ' ||
                   v_inp_bxresult || chr(10) || 'v_inp_bxuqualsubjects: ' ||
                   v_inp_bxuqualsubjects || chr(10) ||
                   'v_inp_scaleamount: ' || v_inp_scaleamount || chr(10) ||
                   'qa_report_id: ' || v_inp_qarepid || chr(10) ||
                   'company_id: ' || v_inp_compid;
    
      --新增进入错误信息表
      scmdata.pkg_qa_ee.p_ins_errrecord_at(v_inp_errprogram     => v_selfdescription,
                                           v_inp_causeerruserid => v_inp_operuserid,
                                           v_inp_erroccurtime   => SYSDATE,
                                           v_inp_errinfo        => v_errinfo,
                                           v_inp_compid         => v_inp_compid);
    
      --抛出报错
      raise_application_error(-20002, v_sqlerrm);
  END p_upd_qarepcheckdetaildim;

  /*=============================================================================
  
     包：
       pkg_qa_ld(qa逻辑细节包)
  
     函数名:
       获取 qa质检报告sku维度表新增数据 sql
  
     入参:
       v_inp_invokeobj : 调用对象
  
     版本:
       2022-10-12_zc314 : 获取 qa质检报告sku维度表新增数据 sql
  
  ==============================================================================*/
  FUNCTION f_get_qarepskudiminsdata_sql(v_inp_invokeobj IN VARCHAR2)
    RETURN CLOB IS
    v_sql             CLOB;
    v_allowinvokeobj  CLOB := 'scmdata.pkg_qa_lc.p_ins_qareportinfo';
    v_selfdescription VARCHAR2(1024) := 'scmdata.pkg_qa_ld.f_get_qarepskudiminsdata_sql';
  BEGIN
    --访问控制
    IF instr(v_allowinvokeobj, v_inp_invokeobj) = 0 THEN
      raise_application_error(-20002,
                              '拒绝访问：调用方-' || v_inp_invokeobj || ' 被调用方-' ||
                              v_selfdescription);
    END IF;
  
    v_sql := 'SELECT asned.asn_id,
       asned.company_id,
       asns.goo_id,
       asnitemitf.barcode,
       nvl(asnitemitf.pcome_amount, asns.pcome_amount),
       nvl(asnitemitf.wmsgot_amount, asns.pcome_amount),
       asned.pcome_date,
       asned.scan_time,
       NVL(asnitemitf.receive_time, asns.receive_time),
       CASE WHEN INSTR(asnitemitf.barcode,''*'') = 0 THEN sku.colorname ELSE asnitemitf.color_name END,
       CASE WHEN INSTR(asnitemitf.barcode,''*'') = 0 THEN sku.sizename ELSE NULL END
  FROM scmdata.t_asnordered asned
 INNER JOIN scmdata.t_asnorders asns
    ON asned.asn_id = asns.asn_id
   AND asned.company_id = asns.company_id
  LEFT JOIN (SELECT itf.asn_id, itf.company_id, itfgoo.goo_id, itf.barcode,
                    MAX(itf.pcome_amount) pcome_amount,
                    SUM(itf.wmsgot_amount) wmsgot_amount,
                    MAX(itf.color_name) color_name,
                    max(itf.receive_time) receive_time
               FROM scmdata.t_asnordersitem_itf itf
              INNER JOIN scmdata.t_commodity_info itfgoo
                 ON itf.goo_id = itfgoo.rela_goo_id
                AND itf.company_id = itfgoo.company_id
              GROUP BY itf.asn_id, itf.company_id, itfgoo.goo_id, itf.barcode) asnitemitf
    ON asned.asn_id = asnitemitf.asn_id
   AND asned.company_id = asnitemitf.company_id
   AND asnitemitf.pcome_amount > 0
  LEFT JOIN scmdata.t_commodity_info goo
    ON asns.goo_id = goo.goo_id
   AND asns.company_id = goo.company_id
  LEFT JOIN scmdata.t_commodity_color_size sku
    ON goo.commodity_info_id = sku.commodity_info_id
   AND NVL(asnitemitf.barcode, '' '') = NVL(sku.barcode, '' '')
   AND goo.company_id = sku.company_id
 WHERE instr(:a, asned.asn_id) > 0
   AND asned.company_id = :b';
  
    RETURN v_sql;
  END f_get_qarepskudiminsdata_sql;

  /*=============================================================================
  
     包：
       pkg_qa_ld(qa逻辑细节包)
  
     函数名:
       获取 qa质检报告sku级汇总数字相关数据 sql
  
     入参:
       v_inp_invokeobj : 调用对象
  
     版本:
       2022-10-12_zc314 : 获取 qa质检报告sku级汇总数字相关数据 sql
  
  ==============================================================================*/
  FUNCTION f_get_qarepskudimsumdata_sql(v_inp_invokeobj IN VARCHAR2)
    RETURN CLOB IS
    v_sql             CLOB;
    v_allowinvokeobj  CLOB := 'scmdata.pkg_qa_lc.p_ins_qareportinfo;scmdata.pkg_qa_lc.p_gen_rcqarep;scmdata.pkg_qa_itf.p_receiveinfo_refreshrepunqualamount';
    v_selfdescription VARCHAR2(1024) := 'scmdata.pkg_qa_ld.f_get_qarepskudimsumdata_sql';
  BEGIN
    --访问控制
    IF instr(v_allowinvokeobj, v_inp_invokeobj) = 0 THEN
      raise_application_error(-20002,
                              '拒绝访问：调用方-' || v_inp_invokeobj || ' 被调用方-' ||
                              v_selfdescription);
    END IF;
  
    v_sql := 'SELECT MAX(pcomesum_amount),
    MAX(wmsgotsum_amount),
    MAX(qualdecreasesum_amount),
    MAX(unqualsum_amount)
  FROM (SELECT qa_report_id,
               company_id,
               SUM(pcome_amount) pcomesum_amount,
               SUM(wmsgot_amount) wmsgotsum_amount,
               SUM(qualdecrease_amount) qualdecreasesum_amount,
               SUM(unqual_amount) unqualsum_amount
          FROM scmdata.t_qa_report_skudim
         WHERE qa_report_id = :a
           AND company_id = :b
         GROUP BY qa_report_id, company_id)';
  
    RETURN v_sql;
  END f_get_qarepskudimsumdata_sql;

  /*=============================================================================
  
     包：
       pkg_qa_ld(qa逻辑细节包)
  
     函数名:
       获取 qa已检列表sku维度已到仓返工次数 sql
  
     入参:
       v_inp_invokeobj : 调用对象
  
     版本:
       2022-10-12_zc314 : 获取 qa已检列表sku维度已到仓返工次数 sql
  
  ==============================================================================*/
  FUNCTION f_get_asnbarcodereprocessingnum_sql(v_inp_invokeobj IN VARCHAR2)
    RETURN CLOB IS
    v_sql             CLOB;
    v_allowinvokeobj  CLOB := 'scmdata.pkg_qa_lc.p_ins_qareportinfo';
    v_selfdescription VARCHAR2(1024) := 'scmdata.pkg_qa_ld.f_get_qarepskudiminsdata_sql';
  BEGIN
    --访问控制
    IF instr(v_allowinvokeobj, v_inp_invokeobj) = 0 THEN
      raise_application_error(-20002,
                              '拒绝访问：调用方-' || v_inp_invokeobj || ' 被调用方-' ||
                              v_selfdescription);
    END IF;
  
    v_sql := 'SELECT COUNT(1)
  FROM scmdata.t_qa_report qr
 WHERE check_type = ''RC''
   AND EXISTS (SELECT 1 FROM scmdata.t_qa_report_skudim
                WHERE qa_report_id = qr.qa_report_id
                  AND company_id = qr.company_id
                  AND asn_id = :a
                  AND company_id = :b
                  and goo_id = :c
                  and nvl(barcode,'' '') = nvl(:d, '' ''))';
  
    RETURN v_sql;
  END f_get_asnbarcodereprocessingnum_sql;

  /*=============================================================================
  
     包：
       pkg_qa_ld(qa逻辑细节包)
  
     函数名:
       qa质检报告获取 asnid,gooid,orderid sql
  
     入参:
       v_inp_invokeobj : 调用对象
  
     版本:
       2022-10-12_zc314 : qa质检报告获取 asnid,gooid,orderid sql
  
  ==============================================================================*/
  FUNCTION f_get_qarepasngooorder_sql(v_inp_invokeobj IN VARCHAR2)
    RETURN CLOB IS
    v_sql             CLOB;
    v_allowinvokeobj  CLOB := 'scmdata.pkg_qa_lc.p_ins_qareportinfo;scmdata.pkg_qa_lc.p_gen_rcqarep';
    v_selfdescription VARCHAR2(1024) := 'scmdata.pkg_qa_ld.f_get_qarepasngooorder_sql';
  BEGIN
    --访问控制
    IF instr(v_allowinvokeobj, v_inp_invokeobj) = 0 THEN
      raise_application_error(-20002,
                              '拒绝访问：调用方-' || v_inp_invokeobj || ' 被调用方-' ||
                              v_selfdescription);
    END IF;
  
    v_sql := 'SELECT LISTAGG(DISTINCT qrs.asn_id, '';''),
       MAX(qrs.goo_id),
       LISTAGG(DISTINCT asn.order_id, '';''),
       MAX(orded.supplier_code),
       LISTAGG(DISTINCT ords.factory_code, '';''),
       LISTAGG(DISTINCT orded.sho_id, '';'')
  FROM scmdata.t_qa_report qr
 INNER JOIN scmdata.t_qa_report_skudim qrs
    ON qr.qa_report_id = qrs.qa_report_id
   AND qr.company_id = qrs.company_id
  LEFT JOIN scmdata.t_asnordered asn
    ON qrs.asn_id = asn.asn_id
   AND qrs.company_id = asn.company_id
  LEFT JOIN scmdata.t_ordered orded
    ON asn.order_id = orded.order_code
   AND asn.company_id = orded.company_id
  LEFT JOIN scmdata.t_orders ords
    ON asn.order_id = ords.order_id
   AND asn.company_id = ords.company_id
 WHERE qr.qa_report_id = :a
   AND qr.company_id = :b
 GROUP BY qr.qa_report_id, qr.company_id';
    RETURN v_sql;
  END f_get_qarepasngooorder_sql;

  /*=============================================================================
  
     包：
       pkg_qa_ld(qa逻辑细节包)
  
     过程名:
       批量录入合格质检报告信息更新
  
     入参:
       v_inp_qarepids     :  质检报告id，多值，用【分号】分隔
       v_inp_compid       :  企业id
       v_inp_checkresult  :  质检结果
       v_inp_checkdate    :  查货日期
       v_inp_checkuserids :  查货员
       v_inp_curuserid    :  当前操作人id
       v_inp_invokeobj    :  调用对象
  
     版本:
       2022-10-19_zc314 : 批量录入合格质检报告信息更新
  
  ==============================================================================*/
  PROCEDURE p_upd_batchqarepinfo(v_inp_qarepids     IN VARCHAR2,
                                 v_inp_compid       IN VARCHAR2,
                                 v_inp_checkresult  IN VARCHAR2,
                                 v_inp_checkdate    IN DATE,
                                 v_inp_checkuserids IN VARCHAR2,
                                 v_inp_curuserid    IN VARCHAR2,
                                 v_inp_invokeobj    IN VARCHAR2) IS
    priv_exception EXCEPTION;
    v_sql             CLOB;
    v_errinfo         CLOB;
    v_sqlerrm         VARCHAR2(512);
    v_allowinvokeobj  CLOB := 'scmdata.pkg_qa_lc.p_batch_passqarep';
    v_selfdescription VARCHAR2(1024) := 'scmdata.pkg_qa_ld.p_upd_batchqarepinfo';
  BEGIN
    --访问控制
    IF instr(v_allowinvokeobj, v_inp_invokeobj) = 0 THEN
      v_sqlerrm := '拒绝访问：调用方-' || v_inp_invokeobj || ' 被调用方-' ||
                   v_selfdescription;
      RAISE priv_exception;
    END IF;
  
    --构建sql
    v_sql := 'UPDATE scmdata.t_qa_report
     SET check_result = :v_inp_checkresult,
         checkdate    = :v_inp_checkdate,
         checkers     = :v_inp_checkuserids,
         update_id    = :v_inp_curuserid,
         update_time  = SYSDATE
   WHERE instr(:v_inp_qarepids, qa_report_id) > 0
     AND company_id = :v_inp_compid';
  
    --更新
    EXECUTE IMMEDIATE v_sql
      USING v_inp_checkresult, v_inp_checkdate, v_inp_checkuserids, v_inp_curuserid, v_inp_qarepids, v_inp_compid;
  EXCEPTION
    WHEN priv_exception THEN
      --抛出报错
      raise_application_error(-20002, v_sqlerrm);
    WHEN OTHERS THEN
      --错误信息赋值
      v_sqlerrm := substr(dbms_utility.format_error_stack, 1, 1024);
      v_errinfo := 'Error Object:' || v_selfdescription || chr(10) ||
                   'Error Info: ' || v_sqlerrm || chr(10) || 'Execute_sql:' ||
                   v_sql || chr(10) || 'Params: ' || chr(10) ||
                   'v_inp_checkresult: ' || v_inp_checkresult || chr(10) ||
                   'v_inp_checkdate: ' || v_inp_checkdate || chr(10) ||
                   'v_inp_checkuserids: ' || v_inp_checkuserids || chr(10) ||
                   'v_inp_curuserid: ' || v_inp_curuserid || chr(10) ||
                   'v_inp_qarepids: ' || v_inp_qarepids || chr(10) ||
                   'v_inp_compid: ' || v_inp_compid;
    
      --新增进入错误信息表
      scmdata.pkg_qa_ee.p_ins_errrecord_at(v_inp_errprogram     => v_selfdescription,
                                           v_inp_causeerruserid => v_inp_curuserid,
                                           v_inp_erroccurtime   => SYSDATE,
                                           v_inp_errinfo        => v_errinfo,
                                           v_inp_compid         => v_inp_compid);
    
      --抛出报错
      raise_application_error(-20002, v_sqlerrm);
  END p_upd_batchqarepinfo;

  /*=============================================================================
  
     包：
       pkg_qa_ld(qa逻辑细节包)
  
     函数名:
       获取qa质检报告更新首抽件数sql
  
     入参:
       v_inp_qarepids          :  质检报告id，多值，用【分号】分隔
       v_inp_compid            :  企业id
       v_inp_firstcheckamount  :  首抽件数
       v_inp_curuserid         :  当前操作人id
       v_inp_invokeobj         :  调用对象
  
     版本:
       2022-10-19_zc314 : 获取qa质检报告更新首抽件数sql
  
  ==============================================================================*/
  PROCEDURE p_upd_qarepfirstsamplingamount(v_inp_qarepids         IN VARCHAR2,
                                           v_inp_compid           IN VARCHAR2,
                                           v_inp_firstcheckamount IN NUMBER,
                                           v_inp_curuserid        IN VARCHAR2,
                                           v_inp_invokeobj        IN VARCHAR2) IS
    priv_exception EXCEPTION;
    v_sql             CLOB;
    v_errinfo         CLOB;
    v_sqlerrm         VARCHAR2(512);
    v_allowinvokeobj  CLOB := 'scmdata.pkg_qa_lc.p_batch_passqarep';
    v_selfdescription VARCHAR2(1024) := 'scmdata.pkg_qa_ld.f_get_qarepfirstsamplingamountupdsql';
  BEGIN
    --访问控制
    IF instr(v_allowinvokeobj, v_inp_invokeobj) = 0 THEN
      v_sqlerrm := '拒绝访问：调用方-' || v_inp_invokeobj || ' 被调用方-' ||
                   v_selfdescription;
      RAISE priv_exception;
    END IF;
  
    --构建sql
    v_sql := 'UPDATE scmdata.t_qa_report_numdim
   SET firstsampling_amount = :v_inp_firstcheckamount
 WHERE instr(:v_inp_qarepids, qa_report_id) > 0
   AND company_id = :v_inp_compid';
  
    --执行sql
    EXECUTE IMMEDIATE v_sql
      USING v_inp_firstcheckamount, v_inp_qarepids, v_inp_compid;
  
  EXCEPTION
    WHEN priv_exception THEN
      --抛出报错
      raise_application_error(-20002, v_sqlerrm);
    WHEN OTHERS THEN
      --错误信息赋值
      v_sqlerrm := substr(dbms_utility.format_error_stack, 1, 1024);
      v_errinfo := 'Error Object:' || v_selfdescription || chr(10) ||
                   'Error Info: ' || v_sqlerrm || chr(10) || 'Execute_sql:' ||
                   v_sql || chr(10) || 'Params: ' || chr(10) ||
                   'v_inp_firstcheckamount: ' || v_inp_firstcheckamount ||
                   chr(10) || 'v_inp_qarepids: ' || v_inp_qarepids ||
                   chr(10) || 'v_inp_compid: ' || v_inp_compid;
    
      --新增进入错误信息表
      scmdata.pkg_qa_ee.p_ins_errrecord_at(v_inp_errprogram     => v_selfdescription,
                                           v_inp_causeerruserid => v_inp_curuserid,
                                           v_inp_erroccurtime   => SYSDATE,
                                           v_inp_errinfo        => v_errinfo,
                                           v_inp_compid         => v_inp_compid);
    
      --抛出报错
      raise_application_error(-20002, v_sqlerrm);
  END p_upd_qarepfirstsamplingamount;

  /*=============================================================================
  
     包：
       pkg_qa_ld(qa逻辑细节包)
  
     过程名:
       更新 qa质检报告 sku维度表所有质检结果
  
     入参:
       v_inp_qarepids          :  质检报告id，多值，用【分号】分隔
       v_inp_compid            :  企业id
       v_inp_skucheckresult    :  质检结果
       v_inp_curuserid         :  当前操作人id
       v_inp_invokeobj         :  调用对象
  
     版本:
       2022-10-20_zc314 : 更新 qa质检报告 sku维度表所有质检结果
  
  ==============================================================================*/
  PROCEDURE p_upd_qarepskudimcheckresult(v_inp_qarepids       IN VARCHAR2,
                                         v_inp_compid         IN VARCHAR2,
                                         v_inp_skucheckresult IN VARCHAR2,
                                         v_inp_curuserid      IN VARCHAR2,
                                         v_inp_invokeobj      IN VARCHAR2) IS
    priv_exception EXCEPTION;
    v_sql             CLOB;
    v_errinfo         CLOB;
    v_sqlerrm         VARCHAR2(512);
    v_allowinvokeobj  CLOB := 'scmdata.pkg_qa_lc.p_batch_passqarep';
    v_selfdescription VARCHAR2(1024) := 'scmdata.pkg_qa_ld.f_get_qarepfirstsamplingamountupdsql';
  BEGIN
    --访问控制
    IF instr(v_allowinvokeobj, v_inp_invokeobj) = 0 THEN
      v_sqlerrm := '拒绝访问：调用方-' || v_inp_invokeobj || ' 被调用方-' ||
                   v_selfdescription;
      RAISE priv_exception;
    END IF;
  
    --构建sql
    v_sql := 'UPDATE scmdata.t_qa_report_skudim
   SET skuprocessing_result = :v_inp_skucheckresult
 WHERE instr(:v_inp_qarepids, qa_report_id) > 0
   AND company_id = :v_inp_compid';
  
    --执行sql
    EXECUTE IMMEDIATE v_sql
      USING v_inp_skucheckresult, v_inp_qarepids, v_inp_compid;
  
  EXCEPTION
    WHEN priv_exception THEN
      --抛出报错
      raise_application_error(-20002, v_sqlerrm);
    WHEN OTHERS THEN
      --错误信息赋值
      v_sqlerrm := substr(dbms_utility.format_error_stack, 1, 1024);
      v_errinfo := 'Error Object:' || v_selfdescription || chr(10) ||
                   'Error Info: ' || v_sqlerrm || chr(10) || 'Execute_sql:' ||
                   v_sql || chr(10) || 'Params: ' || chr(10) ||
                   'v_inp_skucheckresult: ' || v_inp_skucheckresult ||
                   chr(10) || 'v_inp_qarepids: ' || v_inp_qarepids ||
                   chr(10) || 'v_inp_compid: ' || v_inp_compid;
    
      --新增进入错误信息表
      scmdata.pkg_qa_ee.p_ins_errrecord_at(v_inp_errprogram     => v_selfdescription,
                                           v_inp_causeerruserid => v_inp_curuserid,
                                           v_inp_erroccurtime   => SYSDATE,
                                           v_inp_errinfo        => v_errinfo,
                                           v_inp_compid         => v_inp_compid);
    
      --抛出报错
      raise_application_error(-20002, v_sqlerrm);
  END p_upd_qarepskudimcheckresult;

  /*=============================================================================
  
     包：
       pkg_qa_ld(qa逻辑细节包)
  
     过程名:
       qa质检报告编辑页面--qa质检报告表更新
  
     入参:
       v_inp_qarepid               :  质检报告id
       v_inp_compid                :  企业id
       v_inp_checkers              :  查货员
       v_inp_checkdate             :  质检时间
       v_inp_checkresult           :  质检结果
       v_inp_problemclassification :  问题分类
       v_inp_problemdescription    :  问题描述
       v_inp_reviewcomments        :  审核意见
       v_inp_memo                  :  备注
       v_inp_qualattachment        :  质检附件
       v_inp_reviewattachment      :  批复附件
       v_inp_curuserid             :  当前操作人id
       v_inp_invokeobj             :  调用对象
  
     版本:
       2022-10-20_zc314 : qa质检报告编辑页面--qa质检报告表更新
  
  ==============================================================================*/
  PROCEDURE p_upd_qarepinfoinreppage(v_inp_qarepid               IN VARCHAR2,
                                     v_inp_compid                IN VARCHAR2,
                                     v_inp_checkers              IN VARCHAR2,
                                     v_inp_checkdate             IN DATE,
                                     v_inp_checkresult           IN VARCHAR2,
                                     v_inp_problemclassification IN VARCHAR2,
                                     v_inp_problemdescription    IN VARCHAR2,
                                     v_inp_reviewcomments        IN VARCHAR2,
                                     v_inp_memo                  IN VARCHAR2,
                                     v_inp_qualattachment        IN VARCHAR2,
                                     v_inp_reviewattachment      IN VARCHAR2,
                                     v_inp_curuserid             IN VARCHAR2,
                                     v_inp_invokeobj             IN VARCHAR2) IS
    priv_exception EXCEPTION;
    v_sql             CLOB;
    v_errinfo         CLOB;
    v_sqlerrm         VARCHAR2(512);
    v_allowinvokeobj  CLOB := 'scmdata.pkg_qa_lc.p_upd_qareport';
    v_selfdescription VARCHAR2(1024) := 'scmdata.pkg_qa_ld.p_upd_qarepinfoinreppage';
  BEGIN
    --访问控制
    IF instr(v_allowinvokeobj, v_inp_invokeobj) = 0 THEN
      v_sqlerrm := '拒绝访问：调用方-' || v_inp_invokeobj || ' 被调用方-' ||
                   v_selfdescription;
      RAISE priv_exception;
    END IF;
  
    --构建执行sql
    v_sql := 'UPDATE scmdata.t_qa_report
   SET checkers = :v_inp_checkers,
       checkdate = :v_inp_checkdate,
       check_result = :v_inp_checkresult,
       problem_classification = :v_inp_problemclassification,
       problem_descriptions = :v_inp_problemdescription,
       review_comments = :v_inp_reviewcomments,
       memo = :v_inp_memo,
       qual_attachment = :v_inp_qualattachment,
       review_attachment = :v_inp_reviewattachment,
       update_id = :v_inp_curuserid,
       update_time = sysdate
 WHERE qa_report_id = :v_inp_qarepid
   AND company_id = :v_inp_compid';
  
    --执行sql
    EXECUTE IMMEDIATE v_sql
      USING v_inp_checkers, v_inp_checkdate, v_inp_checkresult, v_inp_problemclassification, v_inp_problemdescription, v_inp_reviewcomments, v_inp_memo, v_inp_qualattachment, v_inp_reviewattachment, v_inp_curuserid, v_inp_qarepid, v_inp_compid;
  
  EXCEPTION
    WHEN priv_exception THEN
      --抛出报错
      raise_application_error(-20002, v_sqlerrm);
    WHEN OTHERS THEN
      --错误信息赋值
      v_sqlerrm := substr(dbms_utility.format_error_stack, 1, 1024);
      v_errinfo := 'Error Object:' || v_selfdescription || chr(10) ||
                   'Error Info: ' || v_sqlerrm || chr(10) || 'Execute_sql:' ||
                   v_sql || chr(10) || 'Params: ' || chr(10) ||
                   'v_inp_checkers: ' || v_inp_checkers || chr(10) ||
                   'v_inp_checkdate: ' || v_inp_checkdate || chr(10) ||
                   'v_inp_checkresult: ' || v_inp_checkresult || chr(10) ||
                   'v_inp_problemclassification: ' ||
                   v_inp_problemclassification || chr(10) ||
                   'v_inp_problemdescription: ' || v_inp_problemdescription ||
                   chr(10) || 'v_inp_reviewcomments: ' ||
                   v_inp_reviewcomments || chr(10) || 'v_inp_memo: ' ||
                   v_inp_memo || chr(10) || 'v_inp_qualattachment: ' ||
                   v_inp_qualattachment || chr(10) ||
                   'v_inp_reviewattachment: ' || v_inp_reviewattachment ||
                   chr(10) || 'v_inp_qarepid: ' || v_inp_qarepid || chr(10) ||
                   'v_inp_compid: ' || v_inp_compid;
    
      --新增进入错误信息表
      scmdata.pkg_qa_ee.p_ins_errrecord_at(v_inp_errprogram     => v_selfdescription,
                                           v_inp_causeerruserid => v_inp_curuserid,
                                           v_inp_erroccurtime   => SYSDATE,
                                           v_inp_errinfo        => v_errinfo,
                                           v_inp_compid         => v_inp_compid);
    
      --抛出报错
      raise_application_error(-20002, v_sqlerrm);
  END p_upd_qarepinfoinreppage;

  /*=============================================================================
  
     包：
       pkg_qa_ld(qa逻辑细节包)
  
     过程名:
       qa质检报告编辑页面--qa质检报告数字维度表更新
  
     入参:
       v_inp_qarepid               :  qa质检报告id
       v_inp_compid                :  企业id
       v_inp_firstsamplingamount   :  首抽件数
       v_inp_addsamplingamount     :  加抽件数
       v_inp_unqualsamplingamount  :  不合格件数
       v_inp_curuserid             :  当前操作人id
       v_inp_invokeobj             :  调用对象
  
     版本:
       2022-10-20_zc314 : qa质检报告编辑页面--qa质检报告数字维度表更新
  
  ==============================================================================*/
  PROCEDURE p_upd_qarepnumdiminreppage(v_inp_qarepid              IN VARCHAR2,
                                       v_inp_compid               IN VARCHAR2,
                                       v_inp_firstsamplingamount  IN NUMBER,
                                       v_inp_addsamplingamount    IN NUMBER,
                                       v_inp_unqualsamplingamount IN NUMBER,
                                       v_inp_curuserid            IN VARCHAR2,
                                       v_inp_invokeobj            IN VARCHAR2) IS
    priv_exception EXCEPTION;
    v_sql             CLOB;
    v_errinfo         CLOB;
    v_sqlerrm         VARCHAR2(512);
    v_allowinvokeobj  CLOB := 'scmdata.pkg_qa_lc.p_upd_qareport';
    v_selfdescription VARCHAR2(1024) := 'scmdata.pkg_qa_ld.p_upd_qarepinfoinreppage';
  BEGIN
    --访问控制
    IF instr(v_allowinvokeobj, v_inp_invokeobj) = 0 THEN
      v_sqlerrm := '拒绝访问：调用方-' || v_inp_invokeobj || ' 被调用方-' ||
                   v_selfdescription;
      RAISE priv_exception;
    END IF;
  
    --构建执行sql
    v_sql := 'update scmdata.t_qa_report_numdim
   set firstsampling_amount = :v_inp_firstsamplingamount,
       addsampling_amount = :v_inp_addsamplingamount,
       unqualsampling_amount = :v_inp_unqualsamplingamount
 where qa_report_id = :v_inp_qarepid
   AND company_id = :v_inp_compid';
  
    --执行sql
    EXECUTE IMMEDIATE v_sql
      USING v_inp_firstsamplingamount, v_inp_addsamplingamount, v_inp_unqualsamplingamount, v_inp_qarepid, v_inp_compid;
  EXCEPTION
    WHEN priv_exception THEN
      --抛出报错
      raise_application_error(-20002, v_sqlerrm);
    WHEN OTHERS THEN
      --错误信息赋值
      v_sqlerrm := substr(dbms_utility.format_error_stack, 1, 1024);
      v_errinfo := 'Error Object:' || v_selfdescription || chr(10) ||
                   'Error Info: ' || v_sqlerrm || chr(10) || 'Execute_sql:' ||
                   v_sql || chr(10) || 'Params: ' || chr(10) ||
                   'v_inp_firstsamplingamount: ' ||
                   v_inp_firstsamplingamount || chr(10) ||
                   'v_inp_addsamplingamount: ' || v_inp_addsamplingamount ||
                   chr(10) || 'v_inp_unqualsamplingamount: ' ||
                   v_inp_unqualsamplingamount || chr(10) ||
                   'v_inp_qarepid: ' || v_inp_qarepid || chr(10) ||
                   'v_inp_compid: ' || v_inp_compid;
    
      --新增进入错误信息表
      scmdata.pkg_qa_ee.p_ins_errrecord_at(v_inp_errprogram     => v_selfdescription,
                                           v_inp_causeerruserid => v_inp_curuserid,
                                           v_inp_erroccurtime   => SYSDATE,
                                           v_inp_errinfo        => v_errinfo,
                                           v_inp_compid         => v_inp_compid);
    
      --抛出报错
      raise_application_error(-20002, v_sqlerrm);
  END p_upd_qarepnumdiminreppage;

  /*=============================================================================
  
     包：
       pkg_qa_ld(qa逻辑细节包)
  
     过程名:
       qa质检报告编辑页面--qa质检报告数字维度表更新
  
     入参:
       v_inp_qarepid          :  qa质检报告id
       v_inp_compid           :  企业id
       v_inp_yyresult         :  样衣结果
       v_inp_yyuqualsubjects  :  样衣不合格项
       v_inp_mflresult        :  面辅料结果
       v_inp_mfluqualsubjects :  面辅料不合格项
       v_inp_gyresult         :  工艺结果
       v_inp_gyuqualsubjects  :  工艺不合格项
       v_inp_bxresult         :  版型结果
       v_inp_bxuqualsubjects  :  版型不合格项
       v_inp_scaleamount      :  度尺件数
       v_inp_curuserid        :  当前操作人id
       v_inp_invokeobj        :  调用对象
  
     版本:
       2022-10-20_zc314 : qa质检报告编辑页面--qa质检报告数字维度表更新
  
  ==============================================================================*/
  PROCEDURE p_upd_qarepcheckdetaildiminreppage(v_inp_qarepid          IN VARCHAR2,
                                               v_inp_compid           IN VARCHAR2,
                                               v_inp_yyresult         IN VARCHAR2,
                                               v_inp_yyuqualsubjects  IN VARCHAR2,
                                               v_inp_mflresult        IN VARCHAR2,
                                               v_inp_mfluqualsubjects IN VARCHAR2,
                                               v_inp_gyresult         IN VARCHAR2,
                                               v_inp_gyuqualsubjects  IN VARCHAR2,
                                               v_inp_bxresult         IN VARCHAR2,
                                               v_inp_bxuqualsubjects  IN VARCHAR2,
                                               v_inp_scaleamount      IN NUMBER,
                                               v_inp_curuserid        IN VARCHAR2,
                                               v_inp_invokeobj        IN VARCHAR2) IS
    priv_exception EXCEPTION;
    v_sql             CLOB;
    v_errinfo         CLOB;
    v_sqlerrm         VARCHAR2(512);
    v_allowinvokeobj  CLOB := 'scmdata.pkg_qa_lc.p_upd_qareport';
    v_selfdescription VARCHAR2(1024) := 'scmdata.pkg_qa_ld.p_upd_qarepinfoinreppage';
  BEGIN
    --访问控制
    IF instr(v_allowinvokeobj, v_inp_invokeobj) = 0 THEN
      v_sqlerrm := '拒绝访问：调用方-' || v_inp_invokeobj || ' 被调用方-' ||
                   v_selfdescription;
      RAISE priv_exception;
    END IF;
  
    --构建执行sql
    v_sql := 'UPDATE scmdata.t_qa_report_checkdetaildim
   SET YY_RESULT         = :v_inp_yyresult,
       YY_UQUALSUBJECTS  = :v_inp_yyuqualsubjects,
       MFL_RESULT        = :v_inp_mflresult,
       MFL_UQUALSUBJECTS = :v_inp_mfluqualsubjects,
       GY_RESULT         = :v_inp_gyresult,
       GY_UQUALSUBJECTS  = :v_inp_gyuqualsubjects,
       bx_result         = :v_inp_bxresult,
       bx_uqualsubjects  = :v_inp_bxuqualsubjects,
       scale_amount      = :v_inp_scaleamount
 WHERE qa_report_id = :v_inp_qarepid
   AND company_id = :v_inp_compid';
  
    --执行sql
    EXECUTE IMMEDIATE v_sql
      USING v_inp_yyresult, v_inp_yyuqualsubjects, v_inp_mflresult, v_inp_mfluqualsubjects, v_inp_gyresult, v_inp_gyuqualsubjects, v_inp_bxresult, v_inp_bxuqualsubjects, v_inp_scaleamount, v_inp_qarepid, v_inp_compid;
  EXCEPTION
    WHEN priv_exception THEN
      --抛出报错
      raise_application_error(-20002, v_sqlerrm);
    WHEN OTHERS THEN
      --错误信息赋值
      v_sqlerrm := substr(dbms_utility.format_error_stack, 1, 1024);
      v_errinfo := 'Error Object:' || v_selfdescription || chr(10) ||
                   'Error Info: ' || v_sqlerrm || chr(10) || 'Execute_sql:' ||
                   v_sql || chr(10) || 'Params: ' || chr(10) ||
                   'v_inp_yyresult: ' || v_inp_yyresult || chr(10) ||
                   'v_inp_yyuqualsubjects: ' || v_inp_yyuqualsubjects ||
                   chr(10) || 'v_inp_mflresult: ' || v_inp_mflresult ||
                   chr(10) || 'v_inp_mfluqualsubjects: ' ||
                   v_inp_mfluqualsubjects || chr(10) || 'v_inp_gyresult: ' ||
                   v_inp_gyresult || chr(10) || 'v_inp_gyuqualsubjects: ' ||
                   v_inp_gyuqualsubjects || chr(10) || 'v_inp_bxresult: ' ||
                   v_inp_bxresult || chr(10) || 'v_inp_bxuqualsubjects: ' ||
                   v_inp_bxuqualsubjects || chr(10) ||
                   'v_inp_scaleamount: ' || v_inp_scaleamount || chr(10) ||
                   'v_inp_qarepid: ' || v_inp_qarepid || chr(10) ||
                   'v_inp_compid: ' || v_inp_compid;
    
      --新增进入错误信息表
      scmdata.pkg_qa_ee.p_ins_errrecord_at(v_inp_errprogram     => v_selfdescription,
                                           v_inp_causeerruserid => v_inp_curuserid,
                                           v_inp_erroccurtime   => SYSDATE,
                                           v_inp_errinfo        => v_errinfo,
                                           v_inp_compid         => v_inp_compid);
    
      --抛出报错
      raise_application_error(-20002, v_sqlerrm);
  END p_upd_qarepcheckdetaildiminreppage;

  /*=============================================================================
  
     包：
       pkg_qa_ld(qa逻辑细节包)
  
     过程名:
       质检报告问题分类字段更新（异常处理配置表删除前执行）
  
     入参:
       v_inp_abnormaldtlcfgid  :  异常处理配置表id
       v_inp_compid            :  企业id
  
     版本:
       2022-10-21_zc314 : 质检报告问题分类字段更新（异常处理配置表删除前执行）
  
  ==============================================================================*/
  PROCEDURE p_upd_qarepprobclassbfabdtlcfgdel(v_inp_abnormaldtlcfgid IN VARCHAR2,
                                              v_inp_compid           IN VARCHAR2) IS
    v_causedetaildesc VARCHAR2(32);
  BEGIN
    SELECT MAX(cause_detail)
      INTO v_causedetaildesc
      FROM scmdata.t_abnormal_dtl_config
     WHERE abnormal_dtl_config_id = v_inp_abnormaldtlcfgid
       AND company_id = v_inp_compid;
  
    UPDATE scmdata.t_qa_report
       SET problem_classification = v_causedetaildesc
     WHERE problem_classification = v_inp_abnormaldtlcfgid
       AND company_id = v_inp_compid;
  END p_upd_qarepprobclassbfabdtlcfgdel;

  /*=============================================================================
  
     包：
       pkg_qa_ld(qa逻辑细节包)
  
     过程名:
       维护不合格明细-添加明细
  
     入参:
       v_inp_qarepid         :  qa质检报告id
       v_inp_asnid           :  asn单号
       v_inp_gooid           :  商品档案编号
       v_inp_barcode         :  条码
       v_inp_compid          :  企业id
       v_inp_skucheckresult  :  sku质检结果
       v_inp_curuserid       :  当前操作人id
       v_inp_invokeobj       :  调用对象
  
     版本:
       2022-10-21_zc314 : 维护不合格明细-添加明细
  
  ==============================================================================*/
  PROCEDURE p_upd_qarepskudimcheckresulttonp(v_inp_qarepid        IN VARCHAR2,
                                             v_inp_asnid          IN VARCHAR2,
                                             v_inp_gooid          IN VARCHAR2,
                                             v_inp_barcode        IN VARCHAR2,
                                             v_inp_compid         IN VARCHAR2,
                                             v_inp_skucheckresult IN VARCHAR2,
                                             v_inp_curuserid      IN VARCHAR2,
                                             v_inp_invokeobj      IN VARCHAR2) IS
    priv_exception EXCEPTION;
    v_sql             CLOB;
    v_errinfo         CLOB;
    v_sqlerrm         VARCHAR2(512);
    v_allowinvokeobj  CLOB := 'scmdata.pkg_qa_lc.p_change_qarepunqualdetail';
    v_selfdescription VARCHAR2(1024) := 'scmdata.pkg_qa_ld.p_upd_qarepskudimcheckresulttonp';
  BEGIN
    --访问控制
    IF instr(v_allowinvokeobj, v_inp_invokeobj) = 0 THEN
      v_sqlerrm := '拒绝访问：调用方-' || v_inp_invokeobj || ' 被调用方-' ||
                   v_selfdescription;
      RAISE priv_exception;
    END IF;
  
    --构建sql
    v_sql := 'UPDATE scmdata.t_qa_report_skudim
   SET skucheck_result = :v_inp_skucheckresult
 WHERE qa_report_id = :v_inp_qarepid
   AND asn_id = :v_inp_asnid
   AND goo_id = :v_inp_gooid
   AND nvl(barcode, '' '') = nvl(:v_inp_barcode, '' '')
   AND company_id = :v_inp_compid';
  
    --执行sql
    EXECUTE IMMEDIATE v_sql
      USING v_inp_skucheckresult, v_inp_qarepid, v_inp_asnid, v_inp_gooid, v_inp_barcode, v_inp_compid;
  
  EXCEPTION
    WHEN priv_exception THEN
      --抛出报错
      raise_application_error(-20002, v_sqlerrm);
    WHEN OTHERS THEN
      --错误信息赋值
      v_sqlerrm := substr(dbms_utility.format_error_stack, 1, 1024);
      v_errinfo := 'Error Object:' || v_selfdescription || chr(10) ||
                   'Error Info: ' || v_sqlerrm || chr(10) || 'Execute_sql:' ||
                   v_sql || chr(10) || 'Params: ' || chr(10) ||
                   'v_inp_skucheckresult: ' || v_inp_skucheckresult ||
                   chr(10) || 'v_inp_qarepid: ' || v_inp_qarepid || chr(10) ||
                   'v_inp_asnid: ' || v_inp_asnid || chr(10) ||
                   'v_inp_gooid: ' || v_inp_gooid || chr(10) ||
                   'v_inp_barcode: ' || v_inp_barcode || chr(10) ||
                   'v_inp_compid: ' || v_inp_compid;
    
      --新增进入错误信息表
      scmdata.pkg_qa_ee.p_ins_errrecord_at(v_inp_errprogram     => v_selfdescription,
                                           v_inp_causeerruserid => v_inp_curuserid,
                                           v_inp_erroccurtime   => SYSDATE,
                                           v_inp_errinfo        => v_errinfo,
                                           v_inp_compid         => v_inp_compid);
    
      --抛出报错
      raise_application_error(-20002, v_sqlerrm);
  END p_upd_qarepskudimcheckresulttonp;

  /*=============================================================================
  
     包：
       pkg_qa_ld(qa逻辑细节包)
  
     过程名:
       维护不合格明细-添加明细
  
     入参:
       v_inp_qarepid          :  质检报告id
       v_inp_compid           :  企业id
       v_inp_asnid            :  asn单号
       v_inp_gooid            :  商品档案编码
       v_inp_barcode          :  条码
       v_inp_defectiveamount  :  质检次品数量
       v_inp_washlessamount   :  洗水减数
       v_inp_otherlessamount  :  其他减数
       v_inp_curuserid        :  当前操作人id
       v_inp_invokeobj        :  调用对象
  
     版本:
       2022-10-21_zc314 : 维护不合格明细-添加明细
  
  ==============================================================================*/
  PROCEDURE p_upd_qualdecrerela(v_inp_qarepid         IN VARCHAR2,
                                v_inp_compid          IN VARCHAR2,
                                v_inp_asnid           IN VARCHAR2,
                                v_inp_gooid           IN VARCHAR2,
                                v_inp_barcode         IN VARCHAR2,
                                v_inp_defectiveamount IN NUMBER,
                                v_inp_washlessamount  IN NUMBER,
                                v_inp_otherlessamount IN NUMBER,
                                v_inp_curuserid       IN VARCHAR2,
                                v_inp_invokeobj       IN VARCHAR2) IS
    priv_exception EXCEPTION;
    v_sql             CLOB;
    v_errinfo         CLOB;
    v_sqlerrm         VARCHAR2(512);
    v_allowinvokeobj  CLOB := 'scmdata.pkg_qa_lc.p_upd_qualdecrerela';
    v_selfdescription VARCHAR2(1024) := 'scmdata.pkg_qa_ld.p_upd_qualdecrerela';
  BEGIN
    --访问控制
    IF instr(v_allowinvokeobj, v_inp_invokeobj) = 0 THEN
      v_sqlerrm := '拒绝访问：调用方-' || v_inp_invokeobj || ' 被调用方-' ||
                   v_selfdescription;
      RAISE priv_exception;
    END IF;
  
    --构建sql
    v_sql := 'UPDATE scmdata.t_qa_report_skudim
     SET defective_amount = :v_inp_defectiveamount,
         washless_amount = :v_inp_washlessamount,
         otherless_amount = :v_inp_otherlessamount,
         qualdecrease_amount = NVL(:v_inp_defectiveamount,0) + NVL(:v_inp_washlessamount,0) + NVL(:v_inp_otherlessamount,0)
   WHERE asn_id = :v_inp_asnid
     AND goo_id = :v_inp_gooid
     AND nvl(barcode, '' '') = nvl(:v_inp_barcode, '' '')
     AND qa_report_id = :v_inp_qarepid
     AND company_id = :v_inp_compid';
  
    --执行sql
    EXECUTE IMMEDIATE v_sql
      USING v_inp_defectiveamount, v_inp_washlessamount, v_inp_otherlessamount, v_inp_defectiveamount, v_inp_washlessamount, v_inp_otherlessamount, v_inp_asnid, v_inp_gooid, v_inp_barcode, v_inp_qarepid, v_inp_compid;
  
  EXCEPTION
    WHEN priv_exception THEN
      --抛出报错
      raise_application_error(-20002, v_sqlerrm);
    WHEN OTHERS THEN
      --错误信息赋值
      v_sqlerrm := substr(dbms_utility.format_error_stack, 1, 1024);
      v_errinfo := 'Error Object:' || v_selfdescription || chr(10) ||
                   'Error Info: ' || v_sqlerrm || chr(10) || 'Execute_sql:' ||
                   v_sql || chr(10) || 'Params: ' || chr(10) ||
                   'v_inp_defectiveamount: ' || v_inp_defectiveamount ||
                   chr(10) || 'v_inp_washlessamount: ' ||
                   v_inp_washlessamount || chr(10) ||
                   'v_inp_otherlessamount: ' || v_inp_otherlessamount ||
                   chr(10) || 'v_inp_defectiveamount: ' ||
                   v_inp_defectiveamount || chr(10) ||
                   'v_inp_washlessamount: ' || v_inp_washlessamount ||
                   chr(10) || 'v_inp_otherlessamount: ' ||
                   v_inp_otherlessamount || chr(10) || 'v_inp_asnid: ' ||
                   v_inp_asnid || chr(10) || 'v_inp_gooid: ' || v_inp_gooid ||
                   chr(10) || 'v_inp_barcode: ' || v_inp_barcode || chr(10) ||
                   'v_inp_qarepid: ' || v_inp_qarepid || chr(10) ||
                   'v_inp_compid: ' || v_inp_compid;
    
      --新增进入错误信息表
      scmdata.pkg_qa_ee.p_ins_errrecord_at(v_inp_errprogram     => v_selfdescription,
                                           v_inp_causeerruserid => v_inp_curuserid,
                                           v_inp_erroccurtime   => SYSDATE,
                                           v_inp_errinfo        => v_errinfo,
                                           v_inp_compid         => v_inp_compid);
    
      --抛出报错
      raise_application_error(-20002, v_sqlerrm);
  END p_upd_qualdecrerela;

  /*=============================================================================
  
     包：
       pkg_qa_ld(qa逻辑细节包)
  
     过程名:
       修改 asn状态
  
     入参:
       v_inp_asnids      :  asn单号，多值，用分号分隔
       v_inp_compid      :  企业id
       v_inp_status      :  asn状态
       v_inp_operuserid  :  当前操作人id
       v_inp_invokeobj   :  调用对象
  
     版本:
       2022-10-24_zc314 : 修改 asn状态
  
  ==============================================================================*/
  FUNCTION f_get_commitchecksql(v_inp_invokeobj IN VARCHAR2) RETURN CLOB IS
    v_sql             CLOB;
    v_allowinvokeobj  CLOB := 'scmdata.pkg_qa_lc.p_commit_qarep';
    v_selfdescription VARCHAR2(1024) := 'scmdata.pkg_qa_ld.f_get_commitchecksql';
  BEGIN
    --访问控制
    IF instr(v_allowinvokeobj, v_inp_invokeobj) = 0 THEN
      raise_application_error(-20002,
                              '拒绝访问：调用方-' || v_inp_invokeobj || ' 被调用方-' ||
                              v_selfdescription);
    END IF;
  
    --构建sql
    v_sql := 'SELECT max(repnum.firstsampling_amount),
       max(repnum.addsampling_amount),
       max(rep.checkers),
       max(rep.checkdate),
       max(rep.check_result),
       max(rep.problem_descriptions),
       max(rep.review_comments),
       max(rep.problem_classification),
       max(repnum.unqualsampling_amount),
       max(repdetail.yy_result),
       max(repdetail.yy_uqualsubjects),
       max(repdetail.mfl_result),
       max(repdetail.mfl_uqualsubjects),
       max(repdetail.gy_result),
       max(repdetail.gy_uqualsubjects),
       max(repdetail.bx_result),
       max(repdetail.bx_uqualsubjects),
       max(repdetail.scale_amount)
  FROM scmdata.t_qa_report rep
 INNER JOIN scmdata.t_qa_report_checkdetaildim repdetail
    ON rep.qa_report_id = repdetail.qa_report_id
   AND rep.company_id = repdetail.company_id
 INNER JOIN scmdata.t_qa_report_numdim repnum
    ON rep.qa_report_id = repnum.qa_report_id
   AND rep.company_id = repnum.company_id
 WHERE rep.qa_report_id = :v_inp_qarepid
   AND rep.company_id = :v_inp_compid';
  
    RETURN v_sql;
  END f_get_commitchecksql;

  /*=============================================================================
  
     包：
       pkg_qa_ld(qa逻辑细节包)
  
     函数名:
       更新质检报告下sku质检结果
  
     入参:
       v_inp_qarepid         :  qa质检报告id
       v_inp_compid          :  企业id
       v_inp_skucheckresult  :  asn状态
       v_inp_curuserid       :  当前操作人id
       v_inp_invokeobj       :  调用对象
  
     版本:
       2022-10-24_zc314 : 更新质检报告下sku质检结果
       2022-11-03_zc314 : 新增sku质检结果字段用于适配质检报告通过场景（需求变更）
  
  ==============================================================================*/
  PROCEDURE p_upd_allskucheckresult(v_inp_qarepid        IN VARCHAR2,
                                    v_inp_compid         IN VARCHAR2,
                                    v_inp_skucheckresult IN VARCHAR2,
                                    v_inp_curuserid      IN VARCHAR2,
                                    v_inp_invokeobj      IN VARCHAR2) IS
    priv_exception EXCEPTION;
    v_sql             CLOB;
    v_errinfo         CLOB;
    v_sqlerrm         VARCHAR2(512);
    v_allowinvokeobj  CLOB := 'scmdata.pkg_qa_lc.p_check_qarepcheckresultconsistent';
    v_selfdescription VARCHAR2(1024) := 'scmdata.pkg_qa_ld.p_upd_allskucheckresult';
  BEGIN
    --访问控制
    IF instr(v_allowinvokeobj, v_inp_invokeobj) = 0 THEN
      v_sqlerrm := '拒绝访问：调用方-' || v_inp_invokeobj || ' 被调用方-' ||
                   v_selfdescription;
      RAISE priv_exception;
    END IF;
  
    --构建 sql
    v_sql := 'UPDATE scmdata.t_qa_report_skudim
   SET skucheck_result = :v_inp_skucheckresult
 WHERE qa_report_id = :v_inp_qarepid
   AND company_id = :v_inp_compid';
  
    --执行 sql
    EXECUTE IMMEDIATE v_sql
      USING v_inp_skucheckresult, v_inp_qarepid, v_inp_compid;
  EXCEPTION
    WHEN priv_exception THEN
      --抛出报错
      raise_application_error(-20002, v_sqlerrm);
    WHEN OTHERS THEN
      --错误信息赋值
      v_sqlerrm := substr(dbms_utility.format_error_stack, 1, 1024);
      v_errinfo := 'Error Object:' || v_selfdescription || chr(10) ||
                   'Error Info: ' || v_sqlerrm || chr(10) || 'Execute_sql:' ||
                   v_sql || chr(10) || 'Params: ' || chr(10) ||
                   'v_inp_skucheckresult: ' || v_inp_skucheckresult ||
                   chr(10) || 'v_inp_qarepid: ' || v_inp_qarepid || chr(10) ||
                   'v_inp_compid: ' || v_inp_compid;
    
      --新增进入错误信息表
      scmdata.pkg_qa_ee.p_ins_errrecord_at(v_inp_errprogram     => v_selfdescription,
                                           v_inp_causeerruserid => v_inp_curuserid,
                                           v_inp_erroccurtime   => SYSDATE,
                                           v_inp_errinfo        => v_errinfo,
                                           v_inp_compid         => v_inp_compid);
    
      --抛出报错
      raise_application_error(-20002, v_sqlerrm);
  END p_upd_allskucheckresult;

  /*=============================================================================
  
     包：
       pkg_qa_ld(qa逻辑细节包)
  
     函数名:
       qa质检报告提交更新
  
     入参:
       v_inp_qarepid      :  qa质检报告id
       v_inp_compid       :  企业id
       v_inp_operuserid   :  操作人id
       v_inp_invokeobj    :  调用对象
  
     版本:
       2022-10-12_zc314 : qa质检报告提交更新
  
  ==============================================================================*/
  PROCEDURE p_upd_qarepcommit(v_inp_qarepid   IN VARCHAR2,
                              v_inp_compid    IN VARCHAR2,
                              v_inp_curuserid IN VARCHAR2,
                              v_inp_invokeobj IN VARCHAR2) IS
    priv_exception EXCEPTION;
    v_sql             CLOB;
    v_errinfo         CLOB;
    v_sqlerrm         VARCHAR2(512);
    v_allowinvokeobj  CLOB := 'scmdata.pkg_qa_lc.p_commit_qarep';
    v_selfdescription VARCHAR2(1024) := 'scmdata.pkg_qa_ld.p_upd_qarepcommit';
  BEGIN
    --访问控制
    IF instr(v_allowinvokeobj, v_inp_invokeobj) = 0 THEN
      v_sqlerrm := '拒绝访问：调用方-' || v_inp_invokeobj || ' 被调用方-' ||
                   v_selfdescription;
      RAISE priv_exception;
    END IF;
  
    --执行 sql赋值
    v_sql := 'UPDATE scmdata.t_qa_report
       SET commit_id = :v_inp_curuserid,
           commit_time = SYSDATE,
           status = ''PA''
     WHERE qa_report_id = :v_inp_qarepid
       AND company_id = :v_inp_compid';
  
    --执行 sql
    EXECUTE IMMEDIATE v_sql
      USING v_inp_curuserid, v_inp_qarepid, v_inp_compid;
  
    --执行 sql赋值
    v_sql := 'UPDATE scmdata.t_qa_report_skudim
   SET status = ''PA''
 WHERE qa_report_id = :v_inp_qarepid
   AND company_id = :v_inp_compid';
  
    --执行 sql
    EXECUTE IMMEDIATE v_sql
      USING v_inp_qarepid, v_inp_compid;
  
  EXCEPTION
    WHEN priv_exception THEN
      --抛出报错
      raise_application_error(-20002, v_sqlerrm);
    WHEN OTHERS THEN
      --错误信息赋值
      v_sqlerrm := substr(dbms_utility.format_error_stack, 1, 1024);
      v_errinfo := 'Error Object:' || v_selfdescription || chr(10) ||
                   'Error Info: ' || v_sqlerrm || chr(10) || 'Execute_sql:' ||
                   v_sql || chr(10) || 'Params: ' || chr(10) ||
                   'v_inp_curuserid: ' || v_inp_curuserid || chr(10) ||
                   'v_inp_qarepid: ' || v_inp_qarepid || chr(10) ||
                   'v_inp_compid: ' || v_inp_compid;
    
      --新增进入错误信息表
      scmdata.pkg_qa_ee.p_ins_errrecord_at(v_inp_errprogram     => v_selfdescription,
                                           v_inp_causeerruserid => v_inp_curuserid,
                                           v_inp_erroccurtime   => SYSDATE,
                                           v_inp_errinfo        => v_errinfo,
                                           v_inp_compid         => v_inp_compid);
    
      --抛出报错
      raise_application_error(-20002, v_sqlerrm);
  END p_upd_qarepcommit;

  /*=============================================================================
  
     包：
       pkg_qa_ld(qa逻辑细节包)
  
     函数名:
       通过质检报告id更新asn状态
  
     入参:
       v_inp_qarepid      :  qa质检报告id
       v_inp_compid       :  企业id
       v_inp_asnstatus    :  asn状态
       v_inp_curuserid    :  当前操作人id
       v_inp_invokeobj    :  调用对象
  
     版本:
       2022-10-24_zc314 : 通过质检报告id更新asn状态
  
  ==============================================================================*/
  PROCEDURE p_upd_qarepasnstatusbyqarepid(v_inp_qarepid   IN VARCHAR2,
                                          v_inp_compid    IN VARCHAR2,
                                          v_inp_asnstatus IN VARCHAR2,
                                          v_inp_curuserid IN VARCHAR2,
                                          v_inp_invokeobj IN VARCHAR2) IS
    priv_exception EXCEPTION;
    v_sql             CLOB;
    v_errinfo         CLOB;
    v_sqlerrm         VARCHAR2(512);
    v_allowinvokeobj  CLOB := 'scmdata.pkg_qa_lc.p_commit_qarep;scmdata.pkg_qa_lc.p_review_qareport';
    v_selfdescription VARCHAR2(1024) := 'scmdata.pkg_qa_ld.p_upd_qarepasnstatusbyqarepid';
  BEGIN
    --访问控制
    IF instr(v_allowinvokeobj, v_inp_invokeobj) = 0 THEN
      v_sqlerrm := '拒绝访问：调用方-' || v_inp_invokeobj || ' 被调用方-' ||
                   v_selfdescription;
      RAISE priv_exception;
    END IF;
  
    --执行 sql赋值
    v_sql := 'UPDATE scmdata.t_asnordered asned
   SET status = :v_inp_asnstatus
 WHERE EXISTS (SELECT 1 FROM scmdata.t_qa_report_skudim
                WHERE qa_report_id = :v_inp_qarepid
                  AND company_id = :v_inp_compid
                  AND asn_id = asned.asn_id
                  AND company_id = asned.company_id)';
  
    --执行sql
    EXECUTE IMMEDIATE v_sql
      USING v_inp_asnstatus, v_inp_qarepid, v_inp_compid;
  
  EXCEPTION
    WHEN priv_exception THEN
      --抛出报错
      raise_application_error(-20002, v_sqlerrm);
    WHEN OTHERS THEN
      --错误信息赋值
      v_sqlerrm := substr(dbms_utility.format_error_stack, 1, 1024);
      v_errinfo := 'Error Object:' || v_selfdescription || chr(10) ||
                   'Error Info: ' || v_sqlerrm || chr(10) || 'Execute_sql:' ||
                   v_sql || chr(10) || 'Params: ' || chr(10) ||
                   'v_inp_asnstatus: ' || v_inp_asnstatus || chr(10) ||
                   'v_inp_qarepid: ' || v_inp_qarepid || chr(10) ||
                   'v_inp_compid: ' || v_inp_compid;
    
      --新增进入错误信息表
      scmdata.pkg_qa_ee.p_ins_errrecord_at(v_inp_errprogram     => v_selfdescription,
                                           v_inp_causeerruserid => v_inp_curuserid,
                                           v_inp_erroccurtime   => SYSDATE,
                                           v_inp_errinfo        => v_errinfo,
                                           v_inp_compid         => v_inp_compid);
    
      --抛出报错
      raise_application_error(-20002, v_sqlerrm);
  END p_upd_qarepasnstatusbyqarepid;

  /*=============================================================================
  
     包：
       pkg_qa_ld(qa逻辑细节包)
  
     过程名:
       更新 qa质检报告 sku不合格数量
  
     入参:
       v_inp_qarepid     :  qa质检报告id
       v_inp_compid      :  企业id
       v_inp_asnid       :  asn单号
       v_inp_gooid       :  商品档案编号
       v_inp_barcode     :  条码
       v_inp_curuserid   :  当前操作人id
       v_inp_invokeobj   :  调用对象
  
     版本:
       2022-10-25_zc314 : 更新 qa质检报告 sku不合格数量
       2022-10-31_zc314 : 修改更新维度至sku
  
  ==============================================================================*/
  PROCEDURE p_upd_qarepskuunqualamount(v_inp_qarepid   IN VARCHAR2,
                                       v_inp_compid    IN VARCHAR2,
                                       v_inp_asnid     IN VARCHAR2,
                                       v_inp_gooid     IN VARCHAR2,
                                       v_inp_barcode   IN VARCHAR2,
                                       v_inp_curuserid IN VARCHAR2,
                                       v_inp_invokeobj IN VARCHAR2) IS
    priv_exception EXCEPTION;
    v_sql             CLOB;
    v_errinfo         CLOB;
    v_sqlerrm         VARCHAR2(512);
    v_allowinvokeobj  CLOB := 'scmdata.pkg_qa_lc.p_change_qarepunqualdetail;scmdata.pkg_qa_lc.p_check_qarepcheckresultconsistent';
    v_selfdescription VARCHAR2(1024) := 'scmdata.pkg_qa_ld.p_upd_qarepskuunqualamount';
  BEGIN
    --访问控制
    IF instr(v_allowinvokeobj, v_inp_invokeobj) = 0 THEN
      v_sqlerrm := '拒绝访问：调用方-' || v_inp_invokeobj || ' 被调用方-' ||
                   v_selfdescription;
      RAISE priv_exception;
    END IF;
  
    --构建sql
    v_sql := 'UPDATE scmdata.t_qa_report_skudim tab
   SET unqual_amount = CASE
                         WHEN tab.skucheck_result = ''NP'' AND
                              tab.receive_time IS NULL THEN
                          NVL(tab.pcome_amount, 0)
                         WHEN tab.skucheck_result = ''NP'' AND
                              tab.receive_time IS NOT NULL THEN
                          NVL(tab.wmsgot_amount, 0)
                         WHEN tab.skucheck_result = ''PS'' THEN
                          0
                       END
 WHERE qa_report_id = :v_inp_qarepid
   AND company_id = :v_inp_compid
   AND asn_id = :v_inp_asnid
   AND goo_id = :v_inp_gooid
   AND nvl(barcode, '' '') = nvl(:v_inp_barcode, '' '')';
  
    EXECUTE IMMEDIATE v_sql
      USING v_inp_qarepid, v_inp_compid, v_inp_asnid, v_inp_gooid, v_inp_barcode;
  EXCEPTION
    WHEN priv_exception THEN
      --抛出报错
      raise_application_error(-20002, v_sqlerrm);
    WHEN OTHERS THEN
      --错误信息赋值
      v_sqlerrm := substr(dbms_utility.format_error_stack, 1, 1024);
      v_errinfo := 'Error Object:' || v_selfdescription || chr(10) ||
                   'Error Info: ' || v_sqlerrm || chr(10) || 'Execute_sql:' ||
                   v_sql || chr(10) || 'Params: ' || chr(10) ||
                   'v_inp_qarepid: ' || v_inp_qarepid || chr(10) ||
                   'v_inp_compid: ' || v_inp_compid || chr(10) ||
                   'v_inp_asnid: ' || v_inp_asnid || chr(10) ||
                   'v_inp_gooid: ' || v_inp_gooid || chr(10) ||
                   'v_inp_barcode: ' || v_inp_barcode;
    
      --新增进入错误信息表
      scmdata.pkg_qa_ee.p_ins_errrecord_at(v_inp_errprogram     => v_selfdescription,
                                           v_inp_causeerruserid => v_inp_curuserid,
                                           v_inp_erroccurtime   => SYSDATE,
                                           v_inp_errinfo        => v_errinfo,
                                           v_inp_compid         => v_inp_compid);
    
      --抛出报错
      raise_application_error(-20002, v_sqlerrm);
  END p_upd_qarepskuunqualamount;

  /*=============================================================================
  
     包：
       pkg_qa_ld(qa逻辑细节包)
  
     过程名:
       更新 qa质检报告不合格数量
  
     入参:
       v_inp_qarepid     :  qa质检报告id
       v_inp_compid      :  企业id
       v_inp_curuserid   :  当前操作人id
       v_inp_invokeobj   :  调用对象
  
     版本:
       2022-10-25_zc314 : 更新 qa质检报告不合格数量
  
  ==============================================================================*/
  PROCEDURE p_upd_qarepunqualamount(v_inp_qarepid   IN VARCHAR2,
                                    v_inp_compid    IN VARCHAR2,
                                    v_inp_curuserid IN VARCHAR2,
                                    v_inp_invokeobj IN VARCHAR2) IS
    priv_exception EXCEPTION;
    v_sql             CLOB;
    v_unqualamount    NUMBER(8);
    v_errinfo         CLOB;
    v_sqlerrm         VARCHAR2(512);
    v_allowinvokeobj  CLOB := 'scmdata.pkg_qa_lc.p_change_qarepunqualdetail;scmdata.pkg_qa_lc.p_check_qarepcheckresultconsistent';
    v_selfdescription VARCHAR2(1024) := 'scmdata.pkg_qa_ld.p_upd_qarepunqualamount';
  BEGIN
    --访问控制
    IF instr(v_allowinvokeobj, v_inp_invokeobj) = 0 THEN
      v_sqlerrm := '拒绝访问：调用方-' || v_inp_invokeobj || ' 被调用方-' ||
                   v_selfdescription;
      RAISE priv_exception;
    END IF;
  
    --获取报告不合格数量
    v_unqualamount := scmdata.pkg_qa_da.f_get_qarepunqualamount(v_inp_qarepid => v_inp_qarepid,
                                                                v_inp_compid  => v_inp_compid);
  
    --构建sql
    v_sql := 'UPDATE scmdata.t_qa_report_numdim
   SET unqual_amount = :v_unqualamount
 WHERE qa_report_id = :v_inp_qarepid
   AND company_id = :v_inp_compid';
  
    EXECUTE IMMEDIATE v_sql
      USING v_unqualamount, v_inp_qarepid, v_inp_compid;
  EXCEPTION
    WHEN priv_exception THEN
      --抛出报错
      raise_application_error(-20002, v_sqlerrm);
    WHEN OTHERS THEN
      --错误信息赋值
      v_sqlerrm := substr(dbms_utility.format_error_stack, 1, 1024);
      v_errinfo := 'Error Object:' || v_selfdescription || chr(10) ||
                   'Error Info: ' || v_sqlerrm || chr(10) || 'Execute_sql:' ||
                   v_sql || chr(10) || 'Params: ' || chr(10) ||
                   'v_unqualamount: ' || to_char(v_unqualamount) || chr(10) ||
                   'v_inp_qarepid: ' || v_inp_qarepid || chr(10) ||
                   'v_inp_compid: ' || v_inp_compid;
    
      --新增进入错误信息表
      scmdata.pkg_qa_ee.p_ins_errrecord_at(v_inp_errprogram     => v_selfdescription,
                                           v_inp_causeerruserid => v_inp_curuserid,
                                           v_inp_erroccurtime   => SYSDATE,
                                           v_inp_errinfo        => v_errinfo,
                                           v_inp_compid         => v_inp_compid);
    
      --抛出报错
      raise_application_error(-20002, v_sqlerrm);
  END p_upd_qarepunqualamount;

  /*=============================================================================
  
     包：
       pkg_qa_ld(qa逻辑细节包)
  
     过程名:
       更新 qa质检报告修改人修改时间
  
     入参:
       v_inp_qarepid     :  qa质检报告id
       v_inp_compid      :  企业id
       v_inp_curuserid   :  修改人id
       v_inp_curtime     :  修改时间
       v_inp_invokeobj   :  调用对象
  
     版本:
       2022-10-25_zc314 : 更新 qa质检报告修改人修改时间
  
  ==============================================================================*/
  PROCEDURE p_upd_qarepupdateidtime(v_inp_qarepid   IN VARCHAR2,
                                    v_inp_compid    IN VARCHAR2,
                                    v_inp_curuserid IN VARCHAR2,
                                    v_inp_curtime   IN DATE,
                                    v_inp_invokeobj IN VARCHAR2) IS
    priv_exception EXCEPTION;
    v_sql             CLOB;
    v_errinfo         CLOB;
    v_sqlerrm         VARCHAR2(512);
    v_allowinvokeobj  CLOB := 'scmdata.pkg_qa_lc.p_change_qarepunqualdetail';
    v_selfdescription VARCHAR2(1024) := 'scmdata.pkg_qa_ld.p_upd_qarepupdateidtime';
  BEGIN
    --访问控制
    IF instr(v_allowinvokeobj, v_inp_invokeobj) = 0 THEN
      v_sqlerrm := '拒绝访问：调用方-' || v_inp_invokeobj || ' 被调用方-' ||
                   v_selfdescription;
      RAISE priv_exception;
    END IF;
  
    --构建sql
    v_sql := 'UPDATE scmdata.t_qa_report
   SET update_id = :v_inp_curuserid,
       update_time = :v_inp_curtime
 WHERE qa_report_id = :v_inp_qarepid
   AND company_id = :v_inp_compid';
  
    EXECUTE IMMEDIATE v_sql
      USING v_inp_curuserid, v_inp_curtime, v_inp_qarepid, v_inp_compid;
  EXCEPTION
    WHEN priv_exception THEN
      --抛出报错
      raise_application_error(-20002, v_sqlerrm);
    WHEN OTHERS THEN
      --错误信息赋值
      v_sqlerrm := substr(dbms_utility.format_error_stack, 1, 1024);
      v_errinfo := 'Error Object:' || v_selfdescription || chr(10) ||
                   'Error Info: ' || v_sqlerrm || chr(10) || 'Execute_sql:' ||
                   v_sql || chr(10) || 'Params: ' || chr(10) ||
                   'v_inp_curuserid: ' || v_inp_curuserid || chr(10) ||
                   'v_inp_curtime: ' || v_inp_curtime || chr(10) ||
                   'v_inp_qarepid: ' || v_inp_qarepid || chr(10) ||
                   'v_inp_compid: ' || v_inp_compid;
    
      --新增进入错误信息表
      scmdata.pkg_qa_ee.p_ins_errrecord_at(v_inp_errprogram     => v_selfdescription,
                                           v_inp_causeerruserid => v_inp_curuserid,
                                           v_inp_erroccurtime   => SYSDATE,
                                           v_inp_errinfo        => v_errinfo,
                                           v_inp_compid         => v_inp_compid);
    
      --抛出报错
      raise_application_error(-20002, v_sqlerrm);
  END p_upd_qarepupdateidtime;

  /*=============================================================================
  
     包：
       pkg_qa_ld(qa逻辑细节包)
  
     过程名:
       更新 qa质检报告质检减数
  
     入参:
       v_inp_qarepid     :  qa质检报告id
       v_inp_compid      :  企业id
       v_inp_curuserid   :  当前操作人id
       v_inp_invokeobj   :  调用对象
  
     版本:
       2022-10-25_zc314 : 更新 qa质检报告质检减数
  
  ==============================================================================*/
  PROCEDURE p_upd_qarepdecreamount(v_inp_qarepid   IN VARCHAR2,
                                   v_inp_compid    IN VARCHAR2,
                                   v_inp_curuserid IN VARCHAR2,
                                   v_inp_invokeobj IN VARCHAR2) IS
    priv_exception EXCEPTION;
    v_sql                CLOB;
    v_qualdecreaseamount NUMBER(8);
    v_errinfo            CLOB;
    v_sqlerrm            VARCHAR2(512);
    v_allowinvokeobj     CLOB := 'scmdata.pkg_qa_lc.p_upd_qualdecrerela';
    v_selfdescription    VARCHAR2(1024) := 'scmdata.pkg_qa_ld.p_upd_qarepunqualamount';
  BEGIN
    --访问控制
    IF instr(v_allowinvokeobj, v_inp_invokeobj) = 0 THEN
      v_sqlerrm := '拒绝访问：调用方-' || v_inp_invokeobj || ' 被调用方-' ||
                   v_selfdescription;
      RAISE priv_exception;
    END IF;
  
    --获取质检报告质检减数
    v_qualdecreaseamount := scmdata.pkg_qa_da.f_get_qarepdecreamount(v_inp_qarepid => v_inp_qarepid,
                                                                     v_inp_compid  => v_inp_compid);
  
    --构建 sql
    v_sql := 'UPDATE scmdata.t_qa_report_numdim
   SET qualdecreasesum_amount = :v_qualdecreaseamount
 WHERE qa_report_id = :v_inp_qarepid
   AND company_id = :v_inp_compid';
  
    --执行sql
    EXECUTE IMMEDIATE v_sql
      USING v_qualdecreaseamount, v_inp_qarepid, v_inp_compid;
  EXCEPTION
    WHEN priv_exception THEN
      --抛出报错
      raise_application_error(-20002, v_sqlerrm);
    WHEN OTHERS THEN
      --错误信息赋值
      v_sqlerrm := substr(dbms_utility.format_error_stack, 1, 1024);
      v_errinfo := 'Error Object:' || v_selfdescription || chr(10) ||
                   'Error Info: ' || v_sqlerrm || chr(10) || 'Execute_sql:' ||
                   v_sql || chr(10) || 'Params: ' || chr(10) ||
                   'v_qualdecreaseamount: ' ||
                   to_char(v_qualdecreaseamount) || chr(10) ||
                   'v_inp_qarepid: ' || v_inp_qarepid || chr(10) ||
                   'v_inp_compid: ' || v_inp_compid;
    
      --新增进入错误信息表
      scmdata.pkg_qa_ee.p_ins_errrecord_at(v_inp_errprogram     => v_selfdescription,
                                           v_inp_causeerruserid => v_inp_curuserid,
                                           v_inp_erroccurtime   => SYSDATE,
                                           v_inp_errinfo        => v_errinfo,
                                           v_inp_compid         => v_inp_compid);
    
      --抛出报错
      raise_application_error(-20002, v_sqlerrm);
  END p_upd_qarepdecreamount;

  /*=============================================================================
  
     包：
       pkg_qa_ld(qa逻辑细节包)
  
     过程名:
       校验qa质检报告是否重复进行质检报告审核
  
     入参:
       v_inp_qarepid    :  asn编号
       v_inp_compid     :  企业id
       v_inp_invokeobj  :  调用对象
  
     版本:
       2022-10-26_zc314 : 校验qa质检报告是否重复进行质检报告审核
  
  ==============================================================================*/
  PROCEDURE p_check_qareprepeatreview(v_inp_qarepid   IN VARCHAR2,
                                      v_inp_compid    IN VARCHAR2,
                                      v_inp_invokeobj IN VARCHAR2) IS
    v_status          VARCHAR2(8);
    v_allowinvokeobj  CLOB := 'scmdata.pkg_qa_lc.p_review_qareport';
    v_selfdescription VARCHAR2(1024) := 'scmdata.pkg_qa_ld.p_check_qareprereview';
  BEGIN
    --访问控制
    IF instr(v_allowinvokeobj, v_inp_invokeobj) = 0 THEN
      raise_application_error(-20002,
                              '拒绝访问：调用方-' || v_inp_invokeobj || ' 被调用方-' ||
                              v_selfdescription);
    END IF;
    --获取质检报告状态
    v_status := scmdata.pkg_qa_da.f_get_qarepstatus(v_inp_qarepid => v_inp_qarepid,
                                                    v_inp_compid  => v_inp_compid);
  
    --校验质检报告状态
    IF v_status = 'PE' THEN
      raise_application_error(-20002, '已审核质检报告不能重复审核！');
    END IF;
  END p_check_qareprepeatreview;

  /*=============================================================================
  
     包：
       pkg_qa_ld(qa逻辑细节包)
  
     函数名:
       qa质检报告级审核
  
     入参:
       v_inp_qarepid         :  qa质检报告id
       v_inp_compid          :  企业id
       v_inp_repstatus       :  质检报告状态
       v_inp_processingtype  :  质检报告处理结果
       v_inp_curuserid       :  操作人id
       v_inp_invokeobj       :  调用对象
  
     版本:
       2022-10-31_zc314 : qa质检报告审核更新
       2022-12-03_zc314 : 增加质检处理类型
  
  ==============================================================================*/
  PROCEDURE p_upd_qarepreview(v_inp_qarepid        IN VARCHAR2,
                              v_inp_compid         IN VARCHAR2,
                              v_inp_repstatus      IN VARCHAR2,
                              v_inp_processingtype IN VARCHAR2,
                              v_inp_curuserid      IN VARCHAR2,
                              v_inp_invokeobj      IN VARCHAR2) IS
    priv_exception EXCEPTION;
    v_sql             CLOB;
    v_errinfo         CLOB;
    v_sqlerrm         VARCHAR2(512);
    v_allowinvokeobj  CLOB := 'scmdata.pkg_qa_lc.p_review_qareport';
    v_selfdescription VARCHAR2(1024) := 'scmdata.pkg_qa_ld.p_upd_qarepreview';
  BEGIN
    --访问控制
    IF instr(v_allowinvokeobj, v_inp_invokeobj) = 0 THEN
      v_sqlerrm := '拒绝访问：调用方-' || v_inp_invokeobj || ' 被调用方-' ||
                   v_selfdescription;
      RAISE priv_exception;
    END IF;
  
    --构建 sql
    v_sql := 'UPDATE scmdata.t_qa_report
   SET review_id = :v_inp_curuserid,
       review_time = sysdate,
       status = :v_inp_repstatus,
       processing_type = :v_inp_processingtype
 WHERE qa_report_id = :v_inp_qarepid
   AND company_id = :v_inp_compid';
  
    --执行 sql
    EXECUTE IMMEDIATE v_sql
      USING v_inp_curuserid, v_inp_repstatus, v_inp_processingtype, v_inp_qarepid, v_inp_compid;
  
  EXCEPTION
    WHEN priv_exception THEN
      --抛出报错
      raise_application_error(-20002, v_sqlerrm);
    WHEN OTHERS THEN
      --错误信息赋值
      v_sqlerrm := substr(dbms_utility.format_error_stack, 1, 1024);
      v_errinfo := 'Error Object:' || v_selfdescription || chr(10) ||
                   'Error Info: ' || v_sqlerrm || chr(10) || 'Execute_sql:' ||
                   v_sql || chr(10) || 'Params: ' || chr(10) ||
                   'v_inp_curuserid: ' || v_inp_curuserid || chr(10) ||
                   'v_inp_repstatus: ' || v_inp_repstatus || chr(10) ||
                   'v_inp_processingtype: ' || v_inp_processingtype ||
                   chr(10) || 'v_inp_qarepid: ' || v_inp_qarepid || chr(10) ||
                   'v_inp_compid: ' || v_inp_compid;
    
      --新增进入错误信息表
      scmdata.pkg_qa_ee.p_ins_errrecord_at(v_inp_errprogram     => v_selfdescription,
                                           v_inp_causeerruserid => v_inp_curuserid,
                                           v_inp_erroccurtime   => SYSDATE,
                                           v_inp_errinfo        => v_errinfo,
                                           v_inp_compid         => v_inp_compid);
    
      --抛出报错
      raise_application_error(-20002, v_sqlerrm);
  END p_upd_qarepreview;

  /*=============================================================================
  
     包：
       pkg_qa_ld(qa逻辑细节包)
  
     函数名:
       qa质检报告sku级审核
  
     入参:
       v_inp_qarepid      :  qa质检报告id
       v_inp_compid       :  企业id
       v_inp_curuserid    :  操作人id
       v_inp_invokeobj    :  调用对象
  
     版本:
       2022-10-31_zc314 : qa质检报告sku级审核更新
  
  ==============================================================================*/
  PROCEDURE p_upd_qarepskureview(v_inp_qarepid   IN VARCHAR2,
                                 v_inp_compid    IN VARCHAR2,
                                 v_inp_curuserid IN VARCHAR2,
                                 v_inp_invokeobj IN VARCHAR2) IS
    priv_exception EXCEPTION;
    v_sql             CLOB;
    v_errinfo         CLOB;
    v_sqlerrm         VARCHAR2(512);
    v_allowinvokeobj  CLOB := 'scmdata.pkg_qa_lc.p_review_qareport';
    v_selfdescription VARCHAR2(1024) := 'scmdata.pkg_qa_ld.p_upd_qarepreview';
  BEGIN
    --访问控制
    IF instr(v_allowinvokeobj, v_inp_invokeobj) = 0 THEN
      v_sqlerrm := '拒绝访问：调用方-' || v_inp_invokeobj || ' 被调用方-' ||
                   v_selfdescription;
      RAISE priv_exception;
    END IF;
  
    --构建 sql
    v_sql := 'UPDATE scmdata.t_qa_report_skudim tab
   SET review_id   = :v_inp_curuserid,
       review_time = SYSDATE,
       status = CASE
                  WHEN tab.skucheck_result = ''PS'' THEN
                   ''AF''
                  WHEN tab.skucheck_result = ''NP'' THEN
                   ''PE''
                END,
       trans_result = CASE
                  WHEN tab.skucheck_result = ''PS'' THEN
                   ''PS''
                  END
 WHERE qa_report_id = :v_inp_qarepid
   AND company_id = :v_inp_compid';
  
    --执行 sql
    EXECUTE IMMEDIATE v_sql
      USING v_inp_curuserid, v_inp_qarepid, v_inp_compid;
  
  EXCEPTION
    WHEN priv_exception THEN
      --抛出报错
      raise_application_error(-20002, v_sqlerrm);
    WHEN OTHERS THEN
      --错误信息赋值
      v_sqlerrm := substr(dbms_utility.format_error_stack, 1, 1024);
      v_errinfo := 'Error Object:' || v_selfdescription || chr(10) ||
                   'Error Info: ' || v_sqlerrm || chr(10) || 'Execute_sql:' ||
                   v_sql || chr(10) || 'Params: ' || chr(10) ||
                   'v_inp_curuserid: ' || v_inp_curuserid || chr(10) ||
                   'v_inp_qarepid: ' || v_inp_qarepid || chr(10) ||
                   'v_inp_compid: ' || v_inp_compid;
    
      --新增进入错误信息表
      scmdata.pkg_qa_ee.p_ins_errrecord_at(v_inp_errprogram     => v_selfdescription,
                                           v_inp_causeerruserid => v_inp_curuserid,
                                           v_inp_erroccurtime   => SYSDATE,
                                           v_inp_errinfo        => v_errinfo,
                                           v_inp_compid         => v_inp_compid);
    
      --抛出报错
      raise_application_error(-20002, v_sqlerrm);
  END p_upd_qarepskureview;

  /*=============================================================================
  
     包：
       pkg_qa_ld(qa逻辑细节包)
  
     函数名:
       更新质检报告sku结束时间
  
     入参:
       v_inp_qarepid         :  qa质检报告id
       v_inp_compid          :  企业id
       v_inp_asnid           :  asnid
       v_inp_gooid           :  商品档案编号
       v_inp_barcode         :  条码
       v_inp_qualfinishtime  :  质检结束时间
       v_inp_curuserid       :  操作人id
       v_inp_invokeobj       :  调用对象
  
     版本:
       2022-10-26_zc314 : 更新质检报告sku结束时间
  
  ==============================================================================*/
  PROCEDURE p_upd_qarepskuqualfinishtime(v_inp_qarepid        IN VARCHAR2,
                                         v_inp_compid         IN VARCHAR2,
                                         v_inp_asnid          IN VARCHAR2,
                                         v_inp_gooid          IN VARCHAR2,
                                         v_inp_barcode        IN VARCHAR2,
                                         v_inp_qualfinishtime IN DATE,
                                         v_inp_curuserid      IN VARCHAR2,
                                         v_inp_invokeobj      IN VARCHAR2) IS
    priv_exception EXCEPTION;
    v_sql             CLOB;
    v_errinfo         CLOB;
    v_sqlerrm         VARCHAR2(512);
    v_allowinvokeobj  CLOB := 'scmdata.pkg_qa_lc.p_review_qareport;scmdata.pkg_qa_lc.p_maintenance_unqualprocessingmas';
    v_selfdescription VARCHAR2(1024) := 'scmdata.pkg_qa_ld.p_upd_qarepskuqualfinishtime';
  BEGIN
    --访问控制
    IF instr(v_allowinvokeobj, v_inp_invokeobj) = 0 THEN
      v_sqlerrm := '拒绝访问：调用方-' || v_inp_invokeobj || ' 被调用方-' ||
                   v_selfdescription;
      RAISE priv_exception;
    END IF;
  
    --构建 sql
    v_sql := 'UPDATE scmdata.t_qa_report_skudim tab
   SET qualfinish_time = CASE WHEN tab.status = ''AF'' THEN :v_inp_qualfinishtime ELSE NULL END
 WHERE qa_report_id = :v_inp_qarepid
   AND company_id = :v_inp_compid
   AND asn_id = :v_inp_asnid
   AND goo_id = :v_inp_gooid
   AND NVL(barcode, '' '') = NVL(:v_inp_barcode, '' '')';
  
    --执行 sql
    EXECUTE IMMEDIATE v_sql
      USING v_inp_qualfinishtime, v_inp_qarepid, v_inp_compid, v_inp_asnid, v_inp_gooid, v_inp_barcode;
  
  EXCEPTION
    WHEN priv_exception THEN
      --抛出报错
      raise_application_error(-20002, v_sqlerrm);
    WHEN OTHERS THEN
      --错误信息赋值
      v_sqlerrm := substr(dbms_utility.format_error_stack, 1, 1024);
      v_errinfo := 'Error Object:' || v_selfdescription || chr(10) ||
                   'Error Info: ' || v_sqlerrm || chr(10) || 'Execute_sql:' ||
                   v_sql || chr(10) || 'Params: ' || chr(10) ||
                   'v_inp_qualfinishtime: ' ||
                   to_char(v_inp_qualfinishtime, 'yyyy-mm-dd hh24-mi-ss') ||
                   chr(10) || 'v_inp_qarepid: ' || v_inp_qarepid || chr(10) ||
                   'v_inp_compid: ' || v_inp_compid || chr(10) ||
                   'v_inp_asnid: ' || v_inp_asnid || chr(10) ||
                   'v_inp_gooid: ' || v_inp_gooid || chr(10) ||
                   'v_inp_barcode: ' || v_inp_barcode;
    
      --新增进入错误信息表
      scmdata.pkg_qa_ee.p_ins_errrecord_at(v_inp_errprogram     => v_selfdescription,
                                           v_inp_causeerruserid => v_inp_curuserid,
                                           v_inp_erroccurtime   => SYSDATE,
                                           v_inp_errinfo        => v_errinfo,
                                           v_inp_compid         => v_inp_compid);
    
      --抛出报错
      raise_application_error(-20002, v_sqlerrm);
  END p_upd_qarepskuqualfinishtime;

  /*=============================================================================
  
     包：
       pkg_qa_ld(qa逻辑细节包)
  
     函数名:
       更新质检报告处理类型，处理结果
  
     入参:
       v_inp_qarepid           :  qa质检报告id
       v_inp_compid            :  企业id
       v_inp_processingtype    :  asnid
       v_inp_processingresult  :  商品档案编号
       v_inp_curuserid         :  操作人id
       v_inp_invokeobj         :  调用对象
  
     版本:
       2022-10-26_zc314 : 更新质检报告处理类型，处理结果
  
  ==============================================================================*/
  PROCEDURE p_upd_qarepprocessingrela(v_inp_qarepid          IN VARCHAR2,
                                      v_inp_compid           IN VARCHAR2,
                                      v_inp_processingtype   IN VARCHAR2,
                                      v_inp_processingresult IN VARCHAR2,
                                      v_inp_curuserid        IN VARCHAR2,
                                      v_inp_invokeobj        IN VARCHAR2) IS
    priv_exception EXCEPTION;
    v_sql             CLOB;
    v_errinfo         CLOB;
    v_sqlerrm         VARCHAR2(512);
    v_allowinvokeobj  CLOB := 'scmdata.pkg_qa_lc.p_maintenance_unqualprocessingmas';
    v_selfdescription VARCHAR2(1024) := 'scmdata.pkg_qa_ld.p_upd_qarepprocessingrela';
  BEGIN
    --访问控制
    IF instr(v_allowinvokeobj, v_inp_invokeobj) = 0 THEN
      v_sqlerrm := '拒绝访问：调用方-' || v_inp_invokeobj || ' 被调用方-' ||
                   v_selfdescription;
      RAISE priv_exception;
    END IF;
  
    --构建 sql
    v_sql := 'UPDATE scmdata.t_qa_report
   SET processing_type   = :v_inp_processingtype,
       processing_result = decode(:v_inp_processingtype,''WB'',:v_inp_processingresult,NULL)
 WHERE qa_report_id = :v_inp_qarepid
   AND company_id = :v_inp_compid
   AND check_result IN (''ANP'',''PNP'')';
  
    EXECUTE IMMEDIATE v_sql
      USING v_inp_processingtype, v_inp_processingtype, v_inp_processingresult, v_inp_qarepid, v_inp_compid;
  
  EXCEPTION
    WHEN priv_exception THEN
      --抛出报错
      raise_application_error(-20002, v_sqlerrm);
    WHEN OTHERS THEN
      --错误信息赋值
      v_sqlerrm := substr(dbms_utility.format_error_stack, 1, 1024);
      v_errinfo := 'Error Object:' || v_selfdescription || chr(10) ||
                   'Error Info: ' || v_sqlerrm || chr(10) || 'Execute_sql:' ||
                   v_sql || chr(10) || 'Params: ' || chr(10) ||
                   'v_inp_processingtype: ' || v_inp_processingtype ||
                   chr(10) || 'v_inp_processingresult: ' ||
                   v_inp_processingresult || chr(10) || 'v_inp_qarepid: ' ||
                   v_inp_qarepid || chr(10) || 'v_inp_compid: ' ||
                   v_inp_compid;
    
      --新增进入错误信息表
      scmdata.pkg_qa_ee.p_ins_errrecord_at(v_inp_errprogram     => v_selfdescription,
                                           v_inp_causeerruserid => v_inp_curuserid,
                                           v_inp_erroccurtime   => SYSDATE,
                                           v_inp_errinfo        => v_errinfo,
                                           v_inp_compid         => v_inp_compid);
    
      --抛出报错
      raise_application_error(-20002, v_sqlerrm);
  END p_upd_qarepprocessingrela;

  /*=============================================================================
  
     包：
       pkg_qa_ld(qa逻辑细节包)
  
     函数名:
       质检报告主表整批处理时，更新质检报告sku处理结果，质检结束时间
  
     入参:
       v_inp_qarepid           :  qa质检报告id
       v_inp_compid            :  企业id
       v_inp_processingresult  :  处理结果
       v_inp_curuserid         :  操作人id
       v_inp_invokeobj         :  调用对象
  
     版本:
       2022-10-26_zc314 : 质检报告主表整批处理时，更新质检报告sku处理结果，质检结束时间
  
  ==============================================================================*/
  PROCEDURE p_upd_qarepskuprocesswbrela(v_inp_qarepid          IN VARCHAR2,
                                        v_inp_compid           IN VARCHAR2,
                                        v_inp_processingresult IN VARCHAR2,
                                        v_inp_curuserid        IN VARCHAR2,
                                        v_inp_invokeobj        IN VARCHAR2) IS
    priv_exception EXCEPTION;
    v_sql             CLOB;
    v_errinfo         CLOB;
    v_sqlerrm         VARCHAR2(512);
    v_allowinvokeobj  CLOB := 'scmdata.pkg_qa_lc.p_maintenance_unqualprocessingmas';
    v_selfdescription VARCHAR2(1024) := 'scmdata.pkg_qa_ld.p_upd_qarepskuprocesswbrela';
  BEGIN
    --访问控制
    IF instr(v_allowinvokeobj, v_inp_invokeobj) = 0 THEN
      v_sqlerrm := '拒绝访问：调用方-' || v_inp_invokeobj || ' 被调用方-' ||
                   v_selfdescription;
      RAISE priv_exception;
    END IF;
  
    --构建 sql
    v_sql := 'UPDATE scmdata.t_qa_report_skudim
   SET skuprocessing_result = :v_inp_processingresult,
       qualfinish_time = SYSDATE,
       status = ''AF''
 WHERE qa_report_id = :v_inp_qarepid
   AND company_id = :v_inp_compid
   AND skucheck_result = ''NP''';
  
    EXECUTE IMMEDIATE v_sql
      USING v_inp_processingresult, v_inp_qarepid, v_inp_compid;
  
  EXCEPTION
    WHEN priv_exception THEN
      --抛出报错
      raise_application_error(-20002, v_sqlerrm);
    WHEN OTHERS THEN
      --错误信息赋值
      v_sqlerrm := substr(dbms_utility.format_error_stack, 1, 1024);
      v_errinfo := 'Error Object:' || v_selfdescription || chr(10) ||
                   'Error Info: ' || v_sqlerrm || chr(10) || 'Execute_sql:' ||
                   v_sql || chr(10) || 'Params: ' || chr(10) ||
                   'v_inp_processingresult: ' || v_inp_processingresult ||
                   chr(10) || 'v_inp_qarepid: ' || v_inp_qarepid || chr(10) ||
                   'v_inp_compid: ' || v_inp_compid;
    
      --新增进入错误信息表
      scmdata.pkg_qa_ee.p_ins_errrecord_at(v_inp_errprogram     => v_selfdescription,
                                           v_inp_causeerruserid => v_inp_curuserid,
                                           v_inp_erroccurtime   => SYSDATE,
                                           v_inp_errinfo        => v_errinfo,
                                           v_inp_compid         => v_inp_compid);
    
      --抛出报错
      raise_application_error(-20002, v_sqlerrm);
  END p_upd_qarepskuprocesswbrela;

  /*=============================================================================
  
     包：
       pkg_qa_ld(qa逻辑细节包)
  
     函数名:
       通过报告sku更新质检报告sku处理结果，质检结束时间，状态
  
     入参:
       v_inp_qarepid           :  qa质检报告id
       v_inp_compid            :  企业id
       v_inp_asnid             :  asn单号
       v_inp_gooid             :  商品档案编号
       v_inp_barcode           :  条码
       v_inp_processingresult  :  处理结果
       v_inp_curuserid         :  操作人id
       v_inp_invokeobj         :  调用对象
  
     版本:
       2022-10-27_zc314 : 通过报告sku更新质检报告sku处理结果，质检结束时间，状态
  
  ==============================================================================*/
  PROCEDURE p_upd_qarepskuprocesswbrelawithsku(v_inp_qarepid          IN VARCHAR2,
                                               v_inp_compid           IN VARCHAR2,
                                               v_inp_asnid            IN VARCHAR2,
                                               v_inp_gooid            IN VARCHAR2,
                                               v_inp_barcode          IN VARCHAR2,
                                               v_inp_processingresult IN VARCHAR2,
                                               v_inp_curuserid        IN VARCHAR2,
                                               v_inp_invokeobj        IN VARCHAR2) IS
    priv_exception EXCEPTION;
    v_sql             CLOB;
    v_errinfo         CLOB;
    v_sqlerrm         VARCHAR2(512);
    v_allowinvokeobj  CLOB := 'scmdata.pkg_qa_lc.p_maintenance_qarepskuprocessresult;scmdata.pkg_qa_lc.p_maintenance_unqualprocessingsla';
    v_selfdescription VARCHAR2(1024) := 'scmdata.pkg_qa_ld.p_upd_qarepskuprocesswbrelawithsku';
  BEGIN
    --访问控制
    IF instr(v_allowinvokeobj, v_inp_invokeobj) = 0 THEN
      v_sqlerrm := '拒绝访问：调用方-' || v_inp_invokeobj || ' 被调用方-' ||
                   v_selfdescription;
      RAISE priv_exception;
    END IF;
  
    --构建 sql
    v_sql := 'UPDATE scmdata.t_qa_report_skudim
   SET skuprocessing_result = :v_inp_processingresult,
       qualfinish_time = SYSDATE,
       status = ''AF''
 WHERE qa_report_id = :v_inp_qarepid
   AND company_id = :v_inp_compid
   AND asn_id = :v_inp_asnid
   AND goo_id = :v_inp_gooid
   AND nvl(barcode, '' '') = nvl(:v_inp_barcode, '' '')';
  
    EXECUTE IMMEDIATE v_sql
      USING v_inp_processingresult, v_inp_qarepid, v_inp_compid, v_inp_asnid, v_inp_gooid, v_inp_barcode;
  
  EXCEPTION
    WHEN priv_exception THEN
      --抛出报错
      raise_application_error(-20002, v_sqlerrm);
    WHEN OTHERS THEN
      --错误信息赋值
      v_sqlerrm := substr(dbms_utility.format_error_stack, 1, 1024);
      v_errinfo := 'Error Object:' || v_selfdescription || chr(10) ||
                   'Error Info: ' || v_sqlerrm || chr(10) || 'Execute_sql:' ||
                   v_sql || chr(10) || 'Params: ' || chr(10) ||
                   'v_inp_processingresult: ' || v_inp_processingresult ||
                   chr(10) || 'v_inp_qarepid: ' || v_inp_qarepid || chr(10) ||
                   'v_inp_compid: ' || v_inp_compid || chr(10) ||
                   'v_inp_asnid: ' || v_inp_asnid || chr(10) ||
                   'v_inp_gooid: ' || v_inp_gooid || chr(10) ||
                   'v_inp_barcode: ' || v_inp_barcode;
    
      --新增进入错误信息表
      scmdata.pkg_qa_ee.p_ins_errrecord_at(v_inp_errprogram     => v_selfdescription,
                                           v_inp_causeerruserid => v_inp_curuserid,
                                           v_inp_erroccurtime   => SYSDATE,
                                           v_inp_errinfo        => v_errinfo,
                                           v_inp_compid         => v_inp_compid);
    
      --抛出报错
      raise_application_error(-20002, v_sqlerrm);
  END p_upd_qarepskuprocesswbrelawithsku;

  /*=============================================================================
  
     包：
       pkg_qa_ld(qa逻辑细节包)
  
     函数名:
       更新质检报告状态
  
     入参:
       v_inp_qarepid           :  qa质检报告id
       v_inp_compid            :  企业id
       v_inp_status            :  质检报告状态
       v_inp_curuserid         :  操作人id
       v_inp_invokeobj         :  调用对象
  
     版本:
       2022-10-27_zc314 : 更新质检报告处理类型，处理结果
  
  ==============================================================================*/
  PROCEDURE p_upd_qarepstatus(v_inp_qarepid   IN VARCHAR2,
                              v_inp_compid    IN VARCHAR2,
                              v_inp_status    IN VARCHAR2,
                              v_inp_curuserid IN VARCHAR2,
                              v_inp_invokeobj IN VARCHAR2) IS
    priv_exception EXCEPTION;
    v_sql             CLOB;
    v_errinfo         CLOB;
    v_sqlerrm         VARCHAR2(512);
    v_allowinvokeobj  CLOB := 'scmdata.pkg_qa_lc.p_maintenance_qarepskuprocessresult;scmdata.pkg_qa_lc.p_maintenance_unqualprocessingsla;scmdata.pkg_qa_lc.p_maintenance_unqualprocessingmas';
    v_selfdescription VARCHAR2(1024) := 'scmdata.pkg_qa_ld.p_upd_qarepstatus';
  BEGIN
    --访问控制
    IF instr(v_allowinvokeobj, v_inp_invokeobj) = 0 THEN
      v_sqlerrm := '拒绝访问：调用方-' || v_inp_invokeobj || ' 被调用方-' ||
                   v_selfdescription;
      RAISE priv_exception;
    END IF;
  
    --构建 sql
    v_sql := 'UPDATE scmdata.t_qa_report
   SET status = :v_inp_status
 WHERE qa_report_id = :v_inp_qarepid
   AND company_id = :v_inp_compid';
  
    EXECUTE IMMEDIATE v_sql
      USING v_inp_status, v_inp_qarepid, v_inp_compid;
  
  EXCEPTION
    WHEN priv_exception THEN
      --抛出报错
      raise_application_error(-20002, v_sqlerrm);
    WHEN OTHERS THEN
      --错误信息赋值
      v_sqlerrm := substr(dbms_utility.format_error_stack, 1, 1024);
      v_errinfo := 'Error Object:' || v_selfdescription || chr(10) ||
                   'Error Info: ' || v_sqlerrm || chr(10) || 'Execute_sql:' ||
                   v_sql || chr(10) || 'Params: ' || chr(10) ||
                   'v_inp_status: ' || v_inp_status || chr(10) ||
                   'v_inp_qarepid: ' || v_inp_qarepid || chr(10) ||
                   'v_inp_compid: ' || v_inp_compid;
    
      --新增进入错误信息表
      scmdata.pkg_qa_ee.p_ins_errrecord_at(v_inp_errprogram     => v_selfdescription,
                                           v_inp_causeerruserid => v_inp_curuserid,
                                           v_inp_erroccurtime   => SYSDATE,
                                           v_inp_errinfo        => v_errinfo,
                                           v_inp_compid         => v_inp_compid);
    
      --抛出报错
      raise_application_error(-20002, v_sqlerrm);
  END p_upd_qarepstatus;

  /*=============================================================================
  
     包：
       pkg_qa_ld(qa逻辑细节包)
  
     函数名:
       获取返工sku sql
  
     入参:
       v_inp_invokeobj : 调用对象
  
     版本:
       2022-10-28_zc314 : 获取返工sku sql
  
  ==============================================================================*/
  FUNCTION f_get_reworkskusql(v_inp_invokeobj IN VARCHAR2) RETURN CLOB IS
    v_sql             CLOB;
    v_allowinvokeobj  CLOB := 'scmdata.pkg_qa_lc.p_gen_rcqarep;scmdata.pkg_qa_lc.p_gen_rcqarep';
    v_selfdescription VARCHAR2(1024) := 'scmdata.pkg_qa_ld.p_upd_qarepskuprocesswbrelawithsku';
  BEGIN
    --访问控制
    IF instr(v_allowinvokeobj, v_inp_invokeobj) = 0 THEN
      raise_application_error(-20002,
                              '拒绝访问：调用方-' || v_inp_invokeobj || ' 被调用方-' ||
                              v_selfdescription);
    END IF;
  
    v_sql := 'SELECT asn_id,
       goo_id,
       barcode,
       pcome_amount,
       wmsgot_amount,
       reprocessed_number + 1,
       pcome_date,
       scan_time,
       receive_time,
       color_name,
       size_name
  FROM scmdata.t_qa_report_skudim
 WHERE INSTR(:v_inp_qarepids, qa_report_id) > 0
   AND company_id = :v_inp_compid
   AND skuprocessing_result = ''AWR''';
  
    RETURN v_sql;
  END f_get_reworkskusql;

  /*=============================================================================
  
     包：
       pkg_qa_ld(qa逻辑细节包)
  
     过程名:
       更新 qa质检报告待返工数量
  
     入参:
       v_inp_qarepids            :  qa质检报告id，多值，用分号分隔
       v_inp_compid              :  企业id
       v_inp_prereprocessingnum  :  待返工数量
       v_inp_curuserid           :  当前操作人id
       v_inp_invokeobj           :  调用对象
  
     版本:
       2022-10-28_zc314 : 更新 qa质检报告待返工数量
  
  ==============================================================================*/
  PROCEDURE p_upd_qarepreprocessingsumamount(v_inp_qarepids           IN VARCHAR2,
                                             v_inp_compid             IN VARCHAR2,
                                             v_inp_prereprocessingnum IN NUMBER,
                                             v_inp_curuserid          IN VARCHAR2,
                                             v_inp_invokeobj          IN VARCHAR2) IS
    priv_exception EXCEPTION;
    v_sql             CLOB;
    v_errinfo         CLOB;
    v_sqlerrm         VARCHAR2(512);
    v_allowinvokeobj  CLOB := 'scmdata.pkg_qa_lc.p_gen_rcqarep';
    v_selfdescription VARCHAR2(1024) := 'scmdata.pkg_qa_ld.p_upd_qarepreprocessingsumamount';
  BEGIN
    --访问控制
    IF instr(v_allowinvokeobj, v_inp_invokeobj) = 0 THEN
      v_sqlerrm := '拒绝访问：调用方-' || v_inp_invokeobj || ' 被调用方-' ||
                   v_selfdescription;
      RAISE priv_exception;
    END IF;
  
    --构建 sql
    v_sql := 'UPDATE scmdata.t_qa_report_numdim
   SET prereprocessingsum_amount = :v_inp_prereprocessingnum
 WHERE instr(:v_inp_qarepid, qa_report_id) > 0
   AND company_id = :v_inp_compid';
  
    --执行sql
    EXECUTE IMMEDIATE v_sql
      USING v_inp_prereprocessingnum, v_inp_qarepids, v_inp_compid;
  EXCEPTION
    WHEN priv_exception THEN
      --抛出报错
      raise_application_error(-20002, v_sqlerrm);
    WHEN OTHERS THEN
      --错误信息赋值
      v_sqlerrm := substr(dbms_utility.format_error_stack, 1, 1024);
      v_errinfo := 'Error Object:' || v_selfdescription || chr(10) ||
                   'Error Info: ' || v_sqlerrm || chr(10) || 'Execute_sql:' ||
                   v_sql || chr(10) || 'Params: ' || chr(10) ||
                   'v_inp_prereprocessingnum: ' ||
                   to_char(v_inp_prereprocessingnum) || chr(10) ||
                   'v_inp_qarepids: ' || v_inp_qarepids || chr(10) ||
                   'v_inp_compid: ' || v_inp_compid;
    
      --新增进入错误信息表
      scmdata.pkg_qa_ee.p_ins_errrecord_at(v_inp_errprogram     => v_selfdescription,
                                           v_inp_causeerruserid => v_inp_curuserid,
                                           v_inp_erroccurtime   => SYSDATE,
                                           v_inp_errinfo        => v_errinfo,
                                           v_inp_compid         => v_inp_compid);
    
      --抛出报错
      raise_application_error(-20002, v_sqlerrm);
  END p_upd_qarepreprocessingsumamount;

  /*=============================================================================
  
     包：
       pkg_qa_ld(qa逻辑细节包)
  
     过程名:
       更新 qa质检报告待返工数量+1
  
     入参:
       v_inp_qarepids            :  qa质检报告id，多值，用分号分隔
       v_inp_compid              :  企业id
       v_inp_curuserid           :  当前操作人id
       v_inp_invokeobj           :  调用对象
  
     版本:
       2022-11-01_zc314 : 更新 qa质检报告待返工数量+1
  
  ==============================================================================*/
  PROCEDURE p_upd_qarepreprocessingsumamountaddone(v_inp_qarepids  IN VARCHAR2,
                                                   v_inp_compid    IN VARCHAR2,
                                                   v_inp_curuserid IN VARCHAR2,
                                                   v_inp_invokeobj IN VARCHAR2) IS
    priv_exception EXCEPTION;
    v_sql             CLOB;
    v_errinfo         CLOB;
    v_sqlerrm         VARCHAR2(512);
    v_allowinvokeobj  CLOB := 'scmdata.pkg_qa_lc.p_upd_qareportrepreprocessnum';
    v_selfdescription VARCHAR2(1024) := 'scmdata.pkg_qa_ld.p_upd_qarepreprocessingsumamount';
  BEGIN
    --访问控制
    IF instr(v_allowinvokeobj, v_inp_invokeobj) = 0 THEN
      v_sqlerrm := '拒绝访问：调用方-' || v_inp_invokeobj || ' 被调用方-' ||
                   v_selfdescription;
      RAISE priv_exception;
    END IF;
  
    --构建 sql
    v_sql := 'UPDATE scmdata.t_qa_report_numdim tab
   SET prereprocessingsum_amount = NVL(tab.prereprocessingsum_amount,0) + 1
 WHERE instr(:v_inp_qarepid, qa_report_id) > 0
   AND company_id = :v_inp_compid';
  
    --执行sql
    EXECUTE IMMEDIATE v_sql
      USING v_inp_qarepids, v_inp_compid;
  EXCEPTION
    WHEN priv_exception THEN
      --抛出报错
      raise_application_error(-20002, v_sqlerrm);
    WHEN OTHERS THEN
      --错误信息赋值
      v_sqlerrm := substr(dbms_utility.format_error_stack, 1, 1024);
      v_errinfo := 'Error Object:' || v_selfdescription || chr(10) ||
                   'Error Info: ' || v_sqlerrm || chr(10) || 'Execute_sql:' ||
                   v_sql || chr(10) || 'Params: ' || chr(10) ||
                   'v_inp_qarepids: ' || v_inp_qarepids || chr(10) ||
                   'v_inp_compid: ' || v_inp_compid;
    
      --新增进入错误信息表
      scmdata.pkg_qa_ee.p_ins_errrecord_at(v_inp_errprogram     => v_selfdescription,
                                           v_inp_causeerruserid => v_inp_curuserid,
                                           v_inp_erroccurtime   => SYSDATE,
                                           v_inp_errinfo        => v_errinfo,
                                           v_inp_compid         => v_inp_compid);
    
      --抛出报错
      raise_application_error(-20002, v_sqlerrm);
  END p_upd_qarepreprocessingsumamountaddone;

  /*=============================================================================
  
     包：
       pkg_qa_ld(qa逻辑细节包)
  
     过程名:
       更新 qa质检报告数据汇总相关
  
     入参:
       v_inp_qarepid      : 质检报告id
       v_inp_compid       : 企业id
       v_inp_curuserid    : 当前操作人
       v_inp_invokeobj    : 调用对象
  
     版本:
       2022-10-31_zc314 : 更新 qa质检报告数据汇总相关
  
  ==============================================================================*/
  PROCEDURE p_upd_qarepresumamountrela(v_inp_qarepid   IN VARCHAR2,
                                       v_inp_compid    IN VARCHAR2,
                                       v_inp_curuserid IN VARCHAR2,
                                       v_inp_invokeobj IN VARCHAR2) IS
    priv_exception EXCEPTION;
    v_sql                CLOB;
    v_errinfo            CLOB;
    v_sqlerrm            VARCHAR2(512);
    v_prereprocessamount NUMBER(4);
    v_qualdecreaseamount NUMBER(8);
    v_unqualamount       NUMBER(8);
    v_allowinvokeobj     CLOB := '';
    v_selfdescription    VARCHAR2(1024) := 'scmdata.pkg_qa_ld.p_upd_qarepreprocessamountaddone';
  BEGIN
    --访问控制
    IF instr(v_allowinvokeobj, v_inp_invokeobj) = 0 THEN
      v_sqlerrm := '拒绝访问：调用方-' || v_inp_invokeobj || ' 被调用方-' ||
                   v_selfdescription;
      RAISE priv_exception;
    END IF;
  
    --获取报告待返工sku个数，质检减数，不合格数量
    scmdata.pkg_qa_da.p_get_qareppreamountrela(v_inp_qarepid          => v_inp_qarepid,
                                               v_inp_compid           => v_inp_compid,
                                               v_iop_preprocessamount => v_prereprocessamount,
                                               v_iop_decreaseamount   => v_qualdecreaseamount,
                                               v_iop_unqualsumamount  => v_unqualamount);
  
    --执行 sql 赋值
    v_sql := 'UPDATE scmdata.t_qa_report_numdim
   SET prereprocessingsum_amount = :v_prereprocessamount,
       qualdecreasesum_amount = :v_qualdecreaseamount,
       unqual_amount = :v_unqualamount
 WHERE qa_report_id = :v_inp_qarepid
   AND company_id = :v_inp_compid';
  
    --执行 sql
    EXECUTE IMMEDIATE v_sql
      USING v_prereprocessamount, v_qualdecreaseamount, v_unqualamount, v_inp_qarepid, v_inp_compid;
  
  EXCEPTION
    WHEN priv_exception THEN
      --抛出报错
      raise_application_error(-20002, v_sqlerrm);
    WHEN OTHERS THEN
      --错误信息赋值
      v_sqlerrm := substr(dbms_utility.format_error_stack, 1, 1024);
      v_errinfo := 'Error Object:' || v_selfdescription || chr(10) ||
                   'Error Info: ' || v_sqlerrm || chr(10) || 'Execute sql:' ||
                   v_sql || chr(10) || 'Params: ' || chr(10) ||
                   'v_prereprocessamount: ' || v_prereprocessamount ||
                   chr(10) || 'v_qualdecreaseamount: ' ||
                   v_qualdecreaseamount || chr(10) || 'v_unqualamount: ' ||
                   v_unqualamount || chr(10) || 'v_inp_qarepid: ' ||
                   v_inp_qarepid || chr(10) || 'v_inp_compid: ' ||
                   v_inp_compid;
    
      --新增进入错误信息表
      scmdata.pkg_qa_ee.p_ins_errrecord_at(v_inp_errprogram     => v_selfdescription,
                                           v_inp_causeerruserid => v_inp_curuserid,
                                           v_inp_erroccurtime   => SYSDATE,
                                           v_inp_errinfo        => v_errinfo,
                                           v_inp_compid         => v_inp_compid);
    
      --抛出报错
      raise_application_error(-20002, v_sqlerrm);
  END p_upd_qarepresumamountrela;

  /*=============================================================================
  
     包：
       pkg_qa_ld(qa逻辑细节包)
  
     函数名:
       更新质检报告通过sku状态为已完成，sku结束时间为当前时间
  
     入参:
       v_inp_qarepid    :  qa质检报告id
       v_inp_compid     :  企业id
       v_inp_curuserid  :  操作人id
       v_inp_invokeobj  :  调用对象
  
     版本:
       2022-10-31_zc314 : 更新质检报告通过sku状态为已完成，
                          sku结束时间为当前时间
  
  ==============================================================================*/
  PROCEDURE p_upd_qareppsskustatusfinishtime(v_inp_qarepid   IN VARCHAR2,
                                             v_inp_compid    IN VARCHAR2,
                                             v_inp_curuserid IN VARCHAR2,
                                             v_inp_invokeobj IN VARCHAR2) IS
    priv_exception EXCEPTION;
    v_sql             CLOB;
    v_errinfo         CLOB;
    v_sqlerrm         VARCHAR2(512);
    v_allowinvokeobj  CLOB := 'scmdata.pkg_qa_lc.p_review_qareport';
    v_selfdescription VARCHAR2(1024) := 'scmdata.pkg_qa_ld.p_upd_qareppsskustatusfinishtime';
  BEGIN
    --访问控制
    IF instr(v_allowinvokeobj, v_inp_invokeobj) = 0 THEN
      v_sqlerrm := '拒绝访问：调用方-' || v_inp_invokeobj || ' 被调用方-' ||
                   v_selfdescription;
      RAISE priv_exception;
    END IF;
  
    --构建 sql
    v_sql := 'UPDATE scmdata.t_qa_report_skudim
   SET qualfinish_time = SYSDATE,
       status = ''AF''
 WHERE qa_report_id = :v_inp_qarepid
   AND company_id = :v_inp_compid
   AND skucheck_result = ''PS''';
  
    --执行 sql
    EXECUTE IMMEDIATE v_sql
      USING v_inp_qarepid, v_inp_compid;
  
  EXCEPTION
    WHEN priv_exception THEN
      --抛出报错
      raise_application_error(-20002, v_sqlerrm);
    WHEN OTHERS THEN
      --错误信息赋值
      v_sqlerrm := substr(dbms_utility.format_error_stack, 1, 1024);
      v_errinfo := 'Error Object:' || v_selfdescription || chr(10) ||
                   'Error Info: ' || v_sqlerrm || chr(10) || 'Execute_sql:' ||
                   v_sql || chr(10) || 'Params: ' || chr(10) ||
                   'v_inp_qarepid: ' || v_inp_qarepid || chr(10) ||
                   'v_inp_compid: ' || v_inp_compid;
    
      --新增进入错误信息表
      scmdata.pkg_qa_ee.p_ins_errrecord_at(v_inp_errprogram     => v_selfdescription,
                                           v_inp_causeerruserid => v_inp_curuserid,
                                           v_inp_erroccurtime   => SYSDATE,
                                           v_inp_errinfo        => v_errinfo,
                                           v_inp_compid         => v_inp_compid);
    
      --抛出报错
      raise_application_error(-20002, v_sqlerrm);
  END p_upd_qareppsskustatusfinishtime;

  /*=============================================================================
  
     包：
       pkg_qa_ld(qa逻辑细节包)
  
     函数名:
       维护不合格处理主表更新逻辑
  
     入参:
       v_inp_qarepid           :  qa质检报告id
       v_inp_compid            :  企业id
       v_inp_processingtype    :  处理类型
       v_inp_processingresult  :  处理结果
       v_inp_curuserid         :  操作人id
       v_inp_invokeobj         :  调用对象
  
     版本:
       2022-10-31_zc314 : 维护不合格处理主表更新逻辑
  
  ==============================================================================*/
  PROCEDURE p_upd_qarepmantenancemas(v_inp_qarepid          IN VARCHAR2,
                                     v_inp_compid           IN VARCHAR2,
                                     v_inp_processingtype   IN VARCHAR2,
                                     v_inp_processingresult IN VARCHAR2,
                                     v_inp_curuserid        IN VARCHAR2,
                                     v_inp_invokeobj        IN VARCHAR2) IS
    priv_exception EXCEPTION;
    v_sql             CLOB;
    v_errinfo         CLOB;
    v_sqlerrm         VARCHAR2(512);
    v_allowinvokeobj  CLOB := 'scmdata.pkg_qa_lc.p_maintenance_unqualprocessingmas';
    v_selfdescription VARCHAR2(1024) := 'scmdata.pkg_qa_ld.p_upd_qarepprocessingrela';
  BEGIN
    --访问控制
    IF instr(v_allowinvokeobj, v_inp_invokeobj) = 0 THEN
      v_sqlerrm := '拒绝访问：调用方-' || v_inp_invokeobj || ' 被调用方-' ||
                   v_selfdescription;
      RAISE priv_exception;
    END IF;
  
    --构建 sql
    v_sql := 'UPDATE scmdata.t_qa_report
   SET processing_type   = :v_inp_processingtype,
       processing_result = CASE
                             WHEN :v_inp_processingtype = ''WB'' THEN
                              :v_inp_processingresult
                             ELSE
                              NULL
                           END
 WHERE qa_report_id = :v_inp_qarepid
   AND company_id = :v_inp_compid
   AND check_result IN (''ANP'', ''PNP'')';
  
    EXECUTE IMMEDIATE v_sql
      USING v_inp_processingtype, v_inp_processingtype, v_inp_processingresult, v_inp_qarepid, v_inp_compid;
  
  EXCEPTION
    WHEN OTHERS THEN
      --错误信息赋值
      v_sqlerrm := substr(dbms_utility.format_error_stack, 1, 1024);
      v_errinfo := 'Error Object:' || v_selfdescription || chr(10) ||
                   'Error Info: ' || v_sqlerrm || chr(10) || 'Execute_sql:' ||
                   v_sql || chr(10) || 'Params: ' || chr(10) ||
                   'v_inp_processingtype: ' || v_inp_processingtype ||
                   chr(10) || 'v_inp_processingresult: ' ||
                   v_inp_processingresult || chr(10) || 'v_inp_qarepid: ' ||
                   v_inp_qarepid || chr(10) || 'v_inp_compid: ' ||
                   v_inp_compid;
    
      --新增进入错误信息表
      scmdata.pkg_qa_ee.p_ins_errrecord_at(v_inp_errprogram     => v_selfdescription,
                                           v_inp_causeerruserid => v_inp_curuserid,
                                           v_inp_erroccurtime   => SYSDATE,
                                           v_inp_errinfo        => v_errinfo,
                                           v_inp_compid         => v_inp_compid);
    
      --抛出报错
      raise_application_error(-20002, v_sqlerrm);
  END p_upd_qarepmantenancemas;

  /*=============================================================================
  
     包：
       pkg_qa_ld(qa逻辑细节包)
  
     函数名:
       维护不合格处理=整批处理，更新报告sku处理类型，处理结果，状态，结束时间
  
     入参:
       v_inp_qarepid           :  qa质检报告id
       v_inp_compid            :  企业id
       v_inp_processingresult  :  处理结果
       v_inp_curuserid         :  操作人id
       v_inp_invokeobj         :  调用对象
  
     版本:
       2022-10-31_zc314 : 维护不合格处理=整批处理，
                          更新报告sku处理类型，处理结果，状态，结束时间
  
  ==============================================================================*/
  PROCEDURE p_upd_qarepmantenancewbsku(v_inp_qarepid          IN VARCHAR2,
                                       v_inp_compid           IN VARCHAR2,
                                       v_inp_processingresult IN VARCHAR2,
                                       v_inp_curuserid        IN VARCHAR2,
                                       v_inp_invokeobj        IN VARCHAR2) IS
    priv_exception EXCEPTION;
    v_sql             CLOB;
    v_errinfo         CLOB;
    v_sqlerrm         VARCHAR2(512);
    v_allowinvokeobj  CLOB := 'scmdata.pkg_qa_lc.p_maintenance_unqualprocessingmas';
    v_selfdescription VARCHAR2(1024) := 'scmdata.pkg_qa_ld.p_upd_qarepmantenancewbsku';
  BEGIN
    --访问控制
    IF instr(v_allowinvokeobj, v_inp_invokeobj) = 0 THEN
      v_sqlerrm := '拒绝访问：调用方-' || v_inp_invokeobj || ' 被调用方-' ||
                   v_selfdescription;
      RAISE priv_exception;
    END IF;
  
    --构建 sql
    v_sql := 'UPDATE scmdata.t_qa_report_skudim
   SET skuprocessing_result = :v_inp_processingresult,
       status = ''AF'',
       qualfinish_time = SYSDATE
 WHERE qa_report_id = :v_inp_qarepid
   AND company_id = :v_inp_compid
   AND skucheck_result = ''NP''';
  
    EXECUTE IMMEDIATE v_sql
      USING v_inp_processingresult, v_inp_qarepid, v_inp_compid;
  
  EXCEPTION
    WHEN priv_exception THEN
      --抛出报错
      raise_application_error(-20002, v_sqlerrm);
    WHEN OTHERS THEN
      --错误信息赋值
      v_sqlerrm := substr(dbms_utility.format_error_stack, 1, 1024);
      v_errinfo := 'Error Object:' || v_selfdescription || chr(10) ||
                   'Error Info: ' || v_sqlerrm || chr(10) || 'Execute_sql:' ||
                   v_sql || chr(10) || 'Params: ' || chr(10) ||
                   'v_inp_processingresult: ' || v_inp_processingresult ||
                   chr(10) || 'v_inp_qarepid: ' || v_inp_qarepid || chr(10) ||
                   'v_inp_compid: ' || v_inp_compid;
    
      --新增进入错误信息表
      scmdata.pkg_qa_ee.p_ins_errrecord_at(v_inp_errprogram     => v_selfdescription,
                                           v_inp_causeerruserid => v_inp_curuserid,
                                           v_inp_erroccurtime   => SYSDATE,
                                           v_inp_errinfo        => v_errinfo,
                                           v_inp_compid         => v_inp_compid);
    
      --抛出报错
      raise_application_error(-20002, v_sqlerrm);
  END p_upd_qarepmantenancewbsku;

  /*=============================================================================
  
     包：
       pkg_qa_ld(qa逻辑细节包)
  
     过程名:
       待检任务-删除，删除质检报告关联信息
  
     入参:
       v_inp_qarepid    :  qa质检报告id
       v_inp_compid     :  企业id
       v_inp_invokeobj  :  调用对象
  
     版本:
       2022-11-01_zc314 : 待检任务-删除，删除质检报告关联信息
  
  ==============================================================================*/
  PROCEDURE p_del_qareprela(v_inp_qarepid   IN VARCHAR2,
                            v_inp_compid    IN VARCHAR2,
                            v_inp_invokeobj IN VARCHAR2) IS
  
    v_allowinvokeobj  CLOB := 'scmdata.pkg_qa_lc.p_del_pcqareport';
    v_selfdescription VARCHAR2(1024) := 'scmdata.pkg_qa_ld.p_del_qareprela';
  BEGIN
    --访问控制
    IF instr(v_allowinvokeobj, v_inp_invokeobj) = 0 THEN
      raise_application_error(-20002,
                              '拒绝访问：调用方-' || v_inp_invokeobj || ' 被调用方-' ||
                              v_selfdescription);
    END IF;
    --删除质检报告数据维度
    DELETE FROM scmdata.t_qa_report_numdim
     WHERE qa_report_id = v_inp_qarepid
       AND company_id = v_inp_compid;
  
    --删除质检报告关联信息维度
    DELETE FROM scmdata.t_qa_report_relainfodim
     WHERE qa_report_id = v_inp_qarepid
       AND company_id = v_inp_compid;
  
    --删除质检报告sku维度
    DELETE FROM scmdata.t_qa_report_skudim
     WHERE qa_report_id = v_inp_qarepid
       AND company_id = v_inp_compid;
  
    --删除质检报告
    DELETE FROM scmdata.t_qa_report
     WHERE qa_report_id = v_inp_qarepid
       AND company_id = v_inp_compid;
  END p_del_qareprela;

  /*=============================================================================
  
     包：
       pkg_qa_ld(qa逻辑细节包)
  
     过程名:
       待检任务-更新优先级
  
     入参:
       v_inp_qarepid      :  质检报告id
       v_inp_compid       :  企业id
       v_inp_ispriority   :  是否优先
       v_inp_curuserid    :  当前操作人id
       v_inp_invokeobj    :  调用对象
  
     版本:
       2022-11-01_zc314 : 待检任务-更新优先级
  
  ==============================================================================*/
  PROCEDURE p_upd_qarepispriority(v_inp_qarepid    IN VARCHAR2,
                                  v_inp_compid     IN VARCHAR2,
                                  v_inp_ispriority IN NUMBER,
                                  v_inp_curuserid  IN VARCHAR2,
                                  v_inp_invokeobj  IN VARCHAR2) IS
    priv_exception EXCEPTION;
    v_sql             CLOB;
    v_errinfo         CLOB;
    v_sqlerrm         VARCHAR2(512);
    v_allowinvokeobj  CLOB := 'a_qa_302.update_sql';
    v_selfdescription VARCHAR2(1024) := 'scmdata.pkg_qa_ld.p_upd_qarepispriority';
  BEGIN
    --访问控制
    IF instr(v_allowinvokeobj, v_inp_invokeobj) = 0 THEN
      v_sqlerrm := '拒绝访问：调用方-' || v_inp_invokeobj || ' 被调用方-' ||
                   v_selfdescription;
      RAISE priv_exception;
    END IF;
  
    --构建 sql
    v_sql := 'UPDATE scmdata.t_qa_report
   SET is_priority = :v_inp_ispriority,
       update_id   = :v_inp_curuserid,
       update_time = SYSDATE
 WHERE qa_report_id = :v_inp_qarepid
   AND company_id = :v_inp_compid';
  
    --执行 sql
    EXECUTE IMMEDIATE v_sql
      USING v_inp_ispriority, v_inp_curuserid, v_inp_qarepid, v_inp_compid;
  EXCEPTION
    WHEN priv_exception THEN
      --抛出报错
      raise_application_error(-20002, v_sqlerrm);
    WHEN OTHERS THEN
      --错误信息赋值
      v_sqlerrm := substr(dbms_utility.format_error_stack, 1, 1024);
      v_errinfo := 'Error Object:' || v_selfdescription || chr(10) ||
                   'Error Info: ' || v_sqlerrm || chr(10) || 'Execute_sql:' ||
                   v_sql || chr(10) || 'Params: ' || chr(10) ||
                   'v_inp_ispriority: ' || to_char(v_inp_ispriority) ||
                   chr(10) || 'v_inp_curuserid: ' || v_inp_curuserid ||
                   chr(10) || 'v_inp_qarepid: ' || v_inp_qarepid || chr(10) ||
                   'v_inp_compid: ' || v_inp_compid;
    
      --新增进入错误信息表
      scmdata.pkg_qa_ee.p_ins_errrecord_at(v_inp_errprogram     => v_selfdescription,
                                           v_inp_causeerruserid => v_inp_curuserid,
                                           v_inp_erroccurtime   => SYSDATE,
                                           v_inp_errinfo        => v_errinfo,
                                           v_inp_compid         => v_inp_compid);
    
      --抛出报错
      raise_application_error(-20002, v_sqlerrm);
  END p_upd_qarepispriority;

  /*=============================================================================
  
     包：
       pkg_qa_ld(qa逻辑细节包)
  
     过程名:
       通过sku 更新质检报告处理结果
  
     入参:
       v_inp_qarepid     :  质检报告id
       v_inp_compid      :  企业id
       v_inp_operuserid  :  操作人id
       v_inp_invokeobj   :  调用对象
  
     版本:
       2022-11-08_zc314 : 通过sku 更新质检报告处理结果
  
  ==============================================================================*/
  PROCEDURE p_upd_qarepprocessresultbysku(v_inp_qarepid    IN VARCHAR2,
                                          v_inp_compid     IN VARCHAR2,
                                          v_inp_operuserid IN VARCHAR2,
                                          v_inp_invokeobj  IN VARCHAR2) IS
    priv_exception EXCEPTION;
    v_processresult   VARCHAR2(128);
    v_sql             CLOB;
    v_errinfo         CLOB;
    v_sqlerrm         VARCHAR2(512);
    v_allowinvokeobj  CLOB := 'scmdata.pkg_qa_lc.p_maintenance_unqualprocessingsla';
    v_selfdescription VARCHAR2(1024) := 'scmdata.pkg_qa_ld.p_upd_qarepprocessresultbysku';
  BEGIN
    --访问控制
    IF instr(v_allowinvokeobj, v_inp_invokeobj) = 0 THEN
      v_sqlerrm := '拒绝访问：调用方-' || v_inp_invokeobj || ' 被调用方-' ||
                   v_selfdescription;
      RAISE priv_exception;
    END IF;
  
    --获取质检报告处理结果
    v_processresult := scmdata.pkg_qa_da.f_get_qarepprocessresultbysku(v_inp_qarepid => v_inp_qarepid,
                                                                       v_inp_compid  => v_inp_compid);
  
    --执行 sql 赋值
    v_sql := 'UPDATE scmdata.t_qa_report
   SET processing_result = :v_processresult
 WHERE qa_report_id = :v_inp_qarepid
   AND company_id = :v_inp_compid';
  
    --执行 sql
    EXECUTE IMMEDIATE v_sql
      USING v_processresult, v_inp_qarepid, v_inp_compid;
  
  EXCEPTION
    WHEN priv_exception THEN
      --抛出报错
      raise_application_error(-20002, v_sqlerrm);
    WHEN OTHERS THEN
      --错误信息赋值
      v_sqlerrm := substr(dbms_utility.format_error_stack, 1, 1024);
      v_errinfo := 'Error Object:' || v_selfdescription || chr(10) ||
                   'Error Info: ' || v_sqlerrm || chr(10) || 'Execute sql:' ||
                   v_sql || chr(10) || 'Params: ' || chr(10) ||
                   'v_processresult: ' || v_processresult || chr(10) ||
                   'v_inp_qarepid: ' || v_inp_qarepid || chr(10) ||
                   'v_inp_compid: ' || v_inp_compid;
    
      --新增进入错误信息表
      scmdata.pkg_qa_ee.p_ins_errrecord_at(v_inp_errprogram     => v_selfdescription,
                                           v_inp_causeerruserid => v_inp_operuserid,
                                           v_inp_erroccurtime   => SYSDATE,
                                           v_inp_errinfo        => v_errinfo,
                                           v_inp_compid         => v_inp_compid);
    
      --抛出报错
      raise_application_error(-20002, v_sqlerrm);
  END p_upd_qarepprocessresultbysku;

  /*=============================================================================
  
     包：
       pkg_qa_ld(qa逻辑细节包)
  
     函数名:
       刷新报告下asn传输结果
  
     入参:
       v_inp_qarepid     :  qa质检报告id
       v_inp_compid      :  企业id
       v_inp_asnid       :  asn单号
       v_inp_operuserid  :  当前操作人id
       v_inp_invokeobj   :  调用对象
  
     版本:
       2022-12-01_zc314 : 刷新报告下asn传输结果
  
  ==============================================================================*/
  PROCEDURE p_refresh_qareptransresult(v_inp_qarepid    IN VARCHAR2,
                                       v_inp_compid     IN VARCHAR2,
                                       v_inp_asnid      IN VARCHAR2,
                                       v_inp_operuserid IN VARCHAR2,
                                       v_inp_invokeobj  IN VARCHAR2) IS
    v_repprocessingtype VARCHAR2(8);
    v_repcheckresult    VARCHAR2(8);
    v_transresult       VARCHAR2(8);
    v_sql               CLOB;
    v_gooid             VARCHAR2(32);
    v_barcode           VARCHAR2(32);
    v_errinfo           CLOB;
    v_sqlerrm           VARCHAR2(512);
    v_allowinvokeobj    CLOB := 'scmdata.pkg_qa_lc.p_review_qareport;scmdata.pkg_qa_lc.p_maintenance_unqualprocessingmas;scmdata.pkg_qa_lc.p_maintenance_unqualprocessingsla';
    v_selfdescription   VARCHAR2(1024) := 'scmdata.pkg_qa_ld.p_refresh_qareptransresult';
  BEGIN
    --访问控制
    IF instr(v_allowinvokeobj, v_inp_invokeobj) = 0 THEN
      raise_application_error(-20002,
                              '拒绝访问：调用方-' || v_inp_invokeobj || ' 被调用方-' ||
                              v_selfdescription);
    END IF;
  
    --获取报告质检结果
    v_repcheckresult := scmdata.pkg_qa_da.f_get_qarepcheckresult(v_inp_qarepid => v_inp_qarepid,
                                                                 v_inp_compid  => v_inp_compid);
  
    --获取报告处理方式
    v_repprocessingtype := scmdata.pkg_qa_da.f_get_qarepprocessingtype(v_inp_qarepid => v_inp_qarepid,
                                                                       v_inp_compid  => v_inp_compid);
  
    --隐式游标展开结果
    FOR i IN (SELECT asn_id,
                     goo_id,
                     barcode,
                     skucheck_result,
                     skuprocessing_result
                FROM scmdata.t_qa_report_skudim
               WHERE qa_report_id = v_inp_qarepid
                 AND asn_id = v_inp_asnid
                 AND company_id = v_inp_compid
                 AND status = 'AF') LOOP
      BEGIN
        --变量赋值
        v_gooid   := i.goo_id;
        v_barcode := i.barcode;
      
        --传输结果合并
        IF v_repcheckresult = 'APS' THEN
          --报告级质检结果=【合格】，回传结果=【通过】
          v_transresult := 'PS';
        ELSE
          --报告级质检结果=【整批不合格/部分不合格】
          --报告级处理类型=【整批处理】
          IF nvl(v_repprocessingtype, 'PBCC') = 'WB' THEN
            IF i.skuprocessing_result = 'AWR' THEN
              --sku处理结果=【到仓返工】，回传结果=【返工】
              v_transresult := 'RT';
            ELSIF i.skuprocessing_result = 'WD' THEN
              --sku处理结果=【批退】，回传结果=【不通过】
              v_transresult := 'NP';
            ELSIF i.skuprocessing_result IN
                  ('CR', 'CWR', 'WR', 'ADQ', 'DR', 'DSR', 'GR') THEN
              --sku处理结果=【让步收货/警告收货/严重警告收货/扣款收货/代销收货/担保收货/加抽合格】，回传结果=【通过】
              v_transresult := 'PS';
            ELSIF i.skucheck_result = 'PS' THEN
              --sku质检结果=【合格】
              v_transresult := 'PS';
            END IF;
          ELSIF nvl(v_repprocessingtype, 'PBCC') = 'PBCC' THEN
            --报告级处理类型=【按色码处理】
            IF i.skucheck_result = 'PS' THEN
              --sku质检结果=【合格】，回传结果=【通过】
              v_transresult := 'PS';
            ELSIF i.skucheck_result = 'NP'
                  AND i.skuprocessing_result IN
                  ('CR', 'CWR', 'WR', 'ADQ', 'DR', 'DSR', 'GR') THEN
              --sku质检结果=【不合格】，sku处理结果=【让步收货/警告收货/严重警告收货/扣款收货/代销收货/担保收货/加抽合格】，回传结果=【通过】
              v_transresult := 'PS';
            ELSIF i.skucheck_result = 'NP'
                  AND i.skuprocessing_result = 'WD' THEN
              --sku质检结果=【不合格】，sku处理结果=【批退】，回传结果=【不通过】
              v_transresult := 'NP';
            ELSIF i.skucheck_result = 'NP'
                  AND i.skuprocessing_result = 'AWR' THEN
              --sku质检结果=【不合格】，sku处理结果=【到仓返工】，回传结果=【返工】
              v_transresult := 'RT';
            END IF;
          END IF;
        END IF;
      
        --执行 sql赋值
        v_sql := 'UPDATE scmdata.t_qa_report_skudim
   SET trans_result = :v_transresult
 WHERE qa_report_id = :v_inp_qarepid
   AND company_id = :v_inp_compid
   AND asn_id = :v_inp_asnid
   AND goo_id = :v_gooid
   AND NVL(barcode, '' '') = NVL(:v_barcode, '' '')';
      
        --执行 sql
        EXECUTE IMMEDIATE v_sql
          USING v_transresult, v_inp_qarepid, v_inp_compid, v_inp_asnid, v_gooid, v_barcode;
      EXCEPTION
        WHEN OTHERS THEN
          --错误信息赋值
          v_sqlerrm := substr(dbms_utility.format_error_stack, 1, 1024);
          v_errinfo := 'Error Object:' || v_selfdescription || chr(10) ||
                       'Error Info: ' || v_sqlerrm || chr(10) ||
                       'Execute_sql:' || v_sql || chr(10) || 'Params: ' ||
                       chr(10) || 'v_transresult: ' || v_transresult ||
                       chr(10) || 'v_inp_qarepid: ' || v_inp_qarepid ||
                       chr(10) || 'v_inp_compid: ' || v_inp_compid ||
                       chr(10) || 'v_inp_asnid: ' || v_inp_asnid || chr(10) ||
                       'v_gooid: ' || v_gooid || chr(10) || 'v_barcode: ' ||
                       v_barcode;
        
          --新增进入错误信息表
          scmdata.pkg_qa_ee.p_ins_errrecord_at(v_inp_errprogram     => v_selfdescription,
                                               v_inp_causeerruserid => v_inp_operuserid,
                                               v_inp_erroccurtime   => SYSDATE,
                                               v_inp_errinfo        => v_errinfo,
                                               v_inp_compid         => v_inp_compid);
        
          --抛出报错
          raise_application_error(-20002, v_sqlerrm);
      END;
    END LOOP;
  END p_refresh_qareptransresult;

  /*=============================================================================
  
     包：
       pkg_qa_ld(qa逻辑细节包)
  
     函数名:
       获取 qa质检报告页面显示sql
  
     入参:
       v_inp_qarepid      :  qa质检报告id
       v_inp_compid       :  企业id
  
     返回值:
       clob 类型，错误信息
  
     版本:
       2022-11-14_zc314 : 获取 qa质检报告页面显示sql
  
  ==============================================================================*/
  FUNCTION f_get_qarepsql(v_inp_qarepid IN VARCHAR2,
                          v_inp_compid  IN VARCHAR2) RETURN CLOB IS
    v_sql CLOB;
  BEGIN
    v_sql := 'SELECT goo.rela_goo_id relagooid_00000,
       goo.style_number stylenumber_00000,
       goo.style_name stylename_00000,
       sup.supplier_company_name supplier_00000,
       repnum.pcomesum_amount pcomesumamount_01000,
       repnum.firstsampling_amount firstcheckamount_11000,
       checktypedic.group_dict_name checktype_00000,
       (NVL(repnum.firstsampling_amount, 0) +
       NVL(repnum.addsampling_amount, 0)) checksumamount_01000,
       repnum.addsampling_amount addcheckamount_01000,
       rep.checkers checkers_10000,
       rep.checkdate checkdate_11202,
       ROUND(DECODE((NVL(repnum.firstsampling_amount, 0) +
                    NVL(repnum.addsampling_amount, 0)),
                    0,
                    0,
                    ((NVL(repnum.firstsampling_amount, 0) +
                    NVL(repnum.addsampling_amount, 0)) /
                    NVL(repnum.pcomesum_amount, 0))),
             4) checkrate_01400,
       rep.check_result checkresult_10000,
       rep.problem_classification problemclass,
       NVL(probclass.cause_detail, rep.problem_classification) problemclass_00000,
       rep.problem_descriptions problemdescription_01800,
       rep.review_comments reviewcomments_00000,
       rep.memo memo_01800,
       repnum.unqualsampling_amount unqualsamplingamount_01000,
       CASE
         WHEN repnum.unqualsampling_amount IS NULL AND
              repnum.firstsampling_amount IS NULL AND
              repnum.addsampling_amount IS NULL THEN
          0
         WHEN repnum.unqualsampling_amount IS NULL AND
              (repnum.firstsampling_amount IS NOT NULL OR
              repnum.addsampling_amount IS NOT NULL) THEN
          1
         ELSE
          ROUND(1 - DECODE(NVL(repnum.unqualsampling_amount, 0),
                           0,
                           0,
                           NVL(repnum.unqualsampling_amount, 0) /
                           (NVL(repnum.firstsampling_amount, 0) +
                            NVL(repnum.addsampling_amount, 0))),
                4)
       END qualifiedrate_01400,
       rep.qual_attachment qualattachment_05000,
       rep.review_attachment reviewattachment_05000,
       repdetail.yy_result yyresult_00000,
       repdetail.yy_uqualsubjects yyuqualsubjects_00000,
       repdetail.mfl_result mflresult_00000,
       repdetail.mfl_uqualsubjects mfluqualsubjects_00000,
       repdetail.gy_result gyresult_00000,
       repdetail.gy_uqualsubjects gyuqualsubjects_00000,
       repdetail.bx_result bxresult_00000,
       repdetail.bx_uqualsubjects bxuqualsubjects_00000,
       repdetail.scale_amount scaleamount_01000,
       ''尺寸核对查看'' sizecheck_00000,
       ''查看'' qualdecreaseview_00000,
       ''查看'' unqualdetailview_00000,
       rep.qa_report_id,
       goo.category
  FROM scmdata.t_qa_report rep
 INNER JOIN scmdata.t_qa_report_relainfodim reprela
    ON rep.qa_report_id = reprela.qa_report_id
   AND rep.company_id = reprela.company_id
 INNER JOIN scmdata.t_qa_report_numdim repnum
    ON rep.qa_report_id = repnum.qa_report_id
   AND rep.company_id = repnum.company_id
 INNER JOIN scmdata.t_qa_report_checkdetaildim repdetail
    ON rep.qa_report_id = repdetail.qa_report_id
   AND rep.company_id = repdetail.company_id
  LEFT JOIN scmdata.t_commodity_info goo
    ON reprela.goo_id = goo.goo_id
   AND reprela.company_id = goo.company_id
  LEFT JOIN scmdata.t_ordered orded
    ON reprela.order_id = orded.order_code
   AND reprela.company_id = orded.company_id
  LEFT JOIN scmdata.t_supplier_info sup
    ON orded.supplier_code = sup.supplier_code
   AND orded.company_id = sup.company_id
  LEFT JOIN scmdata.sys_group_dict checktypedic
    ON checktypedic.group_dict_type = ''QA_CHECKTYPE''
   AND checktypedic.group_dict_value = rep.check_type
  LEFT JOIN scmdata.t_abnormal_dtl_config probclass
    ON rep.problem_classification = probclass.abnormal_dtl_config_id
   AND rep.company_id = probclass.company_id
 WHERE rep.qa_report_id = ''' || v_inp_qarepid || '''
   AND rep.company_id = ''' || v_inp_compid || '''';
  
    RETURN v_sql;
  END f_get_qarepsql;

  /*=============================================================================
  
     包：
       pkg_qa_ld(qa逻辑细节包)
  
     函数名:
       【消息提醒】构建“质检结果通知物流部”-头部消息
  
     入参:
       v_inp_qarepid       :  质检报告id
       v_inp_compid        :  企业id
       v_inp_checkresults  :  质检结果
       v_inp_curuserid     :  当前操作人id
       v_inp_invokeobj     :  调用对象
  
     版本:
       2022-12-08_zc314 : 构建“质检结果通知物流部”-头部消息
  
  ==============================================================================*/
  FUNCTION f_message_genlogisticsheadmsg(v_inp_qarepid      IN VARCHAR2,
                                         v_inp_compid       IN VARCHAR2,
                                         v_inp_checkresults IN VARCHAR2 DEFAULT NULL,
                                         v_inp_curuserid    IN VARCHAR2,
                                         v_inp_invokeobj    IN VARCHAR2)
    RETURN CLOB IS
    v_msg CLOB;
    priv_exception EXCEPTION;
    v_sql             CLOB;
    v_errinfo         CLOB;
    v_sqlerrm         VARCHAR2(512);
    v_allowinvokeobj  CLOB := 'scmdata.pkg_qa_lc.f_msg_genlogisticsmsgbyqarep;scmdata.pkg_qa_lc.f_msg_genunqualmsgbyqarep';
    v_selfdescription VARCHAR2(1024) := 'scmdata.pkg_qa_ld.f_message_genlogisticsheadmsg';
  BEGIN
    --访问控制
    IF instr(v_allowinvokeobj, v_inp_invokeobj) = 0 THEN
      v_sqlerrm := '拒绝访问：调用方-' || v_inp_invokeobj || ' 被调用方-' ||
                   v_selfdescription;
      RAISE priv_exception;
    END IF;
  
    --构建执行sql
    IF v_inp_checkresults IS NOT NULL THEN
      v_sql := 'SELECT MAX(supname || '', '' || realgooname || '', '' || stylenumname || '', '' ||
         checktypename || check_result)
    FROM (SELECT sup.supplier_company_name supname,
                 goo.rela_goo_id realgooname,
                 goo.style_number stylenumname,
                 DECODE(rep.check_type, ''RC'', ''返工抽查'', NULL) checktypename,
                 CASE
                   WHEN rep.check_result = ''APS'' THEN
                    ''合格''
                   WHEN rep.check_result = ''ANP'' THEN
                    ''整批不合格''
                   WHEN rep.check_result = ''PNP'' THEN
                    ''部分不合格''
                 END check_result
            FROM scmdata.t_qa_report rep
           INNER JOIN scmdata.t_qa_report_relainfodim reprela
              ON rep.qa_report_id = reprela.qa_report_id
             AND rep.company_id = reprela.company_id
           INNER JOIN scmdata.t_commodity_info goo
              ON reprela.goo_id = goo.goo_id
             AND reprela.company_id = goo.company_id
           INNER JOIN scmdata.t_supplier_info sup
              ON reprela.supplier_code = sup.supplier_code
             AND reprela.company_id = sup.company_id
           WHERE rep.qa_report_id = :v_inp_qarepid
             AND instr(:v_inp_checkresults, rep.check_result) > 0
             AND rep.company_id = :v_inp_compid
             AND rep.review_id is not null)';
    
      EXECUTE IMMEDIATE v_sql
        INTO v_msg
        USING v_inp_qarepid, v_inp_checkresults, v_inp_compid;
    ELSE
      v_sql := 'SELECT MAX(supname || '', '' || realgooname || '', '' || stylenumname || '', '' ||
         checktypename || check_result)
    FROM (SELECT sup.supplier_company_name supname,
                 goo.rela_goo_id realgooname,
                 goo.style_number stylenumname,
                 DECODE(rep.check_type, ''RC'', ''返工抽查'', NULL) checktypename,
                 CASE
                   WHEN rep.check_result = ''APS'' THEN
                    ''合格''
                   WHEN rep.check_result = ''ANP'' THEN
                    ''整批不合格''
                   WHEN rep.check_result = ''PNP'' THEN
                    ''部分不合格''
                 END check_result
            FROM scmdata.t_qa_report rep
           INNER JOIN scmdata.t_qa_report_relainfodim reprela
              ON rep.qa_report_id = reprela.qa_report_id
             AND rep.company_id = reprela.company_id
           INNER JOIN scmdata.t_commodity_info goo
              ON reprela.goo_id = goo.goo_id
             AND reprela.company_id = goo.company_id
           INNER JOIN scmdata.t_supplier_info sup
              ON reprela.supplier_code = sup.supplier_code
             AND reprela.company_id = sup.company_id
           WHERE rep.qa_report_id = :v_inp_qarepid
             AND rep.company_id = :v_inp_compid
             AND rep.review_id is not null)';
    
      EXECUTE IMMEDIATE v_sql
        INTO v_msg
        USING v_inp_qarepid, v_inp_compid;
    END IF;
  
    RETURN v_msg;
  EXCEPTION
    WHEN priv_exception THEN
      --抛出报错
      raise_application_error(-20002, v_sqlerrm);
    WHEN OTHERS THEN
      --错误信息赋值
      v_sqlerrm := substr(dbms_utility.format_error_stack, 1, 1024);
      v_errinfo := 'Error Object:' || v_selfdescription || chr(10) ||
                   'Error Info: ' || v_sqlerrm || chr(10) || 'Execute_sql:' ||
                   v_sql || chr(10) || 'Params: ' || chr(10) ||
                   'v_inp_qarepid: ' || v_inp_qarepid || chr(10) ||
                   'v_inp_checkresults: ' || v_inp_checkresults || chr(10) ||
                   'v_inp_compid: ' || v_inp_compid;
    
      --新增进入错误信息表
      scmdata.pkg_qa_ee.p_ins_errrecord_at(v_inp_errprogram     => v_selfdescription,
                                           v_inp_causeerruserid => v_inp_curuserid,
                                           v_inp_erroccurtime   => SYSDATE,
                                           v_inp_errinfo        => v_errinfo,
                                           v_inp_compid         => v_inp_compid);
    
      --抛出报错
      raise_application_error(-20002, v_sqlerrm);
  END f_message_genlogisticsheadmsg;

  /*=============================================================================
  
     包：
       pkg_qa_ld(qa逻辑细节包)
  
     函数名:
       【消息提醒】构建“质检结果通知物流部”-剩余消息
  
     入参:
       v_inp_qarepid    :  质检报告id
       v_inp_compid     :  企业id
       v_inp_curuserid  :  当前操作人id
       v_inp_invokeobj  :  调用对象
  
     版本:
       2022-12-08_zc314 : 构建“质检结果通知物流部”-剩余消息
  
  ==============================================================================*/
  FUNCTION f_message_genlogisticsrestmsg(v_inp_qarepid   IN VARCHAR2,
                                         v_inp_compid    IN VARCHAR2,
                                         v_inp_curuserid IN VARCHAR2,
                                         v_inp_invokeobj IN VARCHAR2)
    RETURN CLOB IS
    priv_exception EXCEPTION;
    v_msg             CLOB;
    v_sql             CLOB;
    v_errinfo         CLOB;
    v_sqlerrm         VARCHAR2(512);
    v_allowinvokeobj  CLOB := 'scmdata.pkg_qa_lc.f_msg_genlogisticsmsgbyqarep';
    v_selfdescription VARCHAR2(1024) := 'scmdata.pkg_qa_ld.f_message_genreviewrestmsg';
  BEGIN
    --访问控制
    IF instr(v_allowinvokeobj, v_inp_invokeobj) = 0 THEN
      v_sqlerrm := '拒绝访问：调用方-' || v_inp_invokeobj || ' 被调用方-' ||
                   v_selfdescription;
      RAISE priv_exception;
    END IF;
  
    --构建执行sql
    v_sql := 'SELECT listagg(info, '','')
    FROM (SELECT CASE
                   WHEN npcnt = 0 THEN
                    NULL
                   WHEN wholecolorcnt = npcnt THEN
                    color_name
                   WHEN wholecolorcnt > npcnt THEN
                    color_name || ''('' || size_name || '')''
                 END info
            FROM (SELECT repsku.asn_id,
                         repsku.company_id,
                         repsku.color_name,
                         listagg(DECODE(repsku.skucheck_result,
                                        ''NP'',
                                        size_name,
                                        NULL),
                                 '';'') size_name,
                         COUNT(DISTINCT color_name || NVL(size_name, '' '')) wholecolorcnt,
                         SUM(DECODE(repsku.skucheck_result, ''NP'', 1, 0)) npcnt
                    FROM scmdata.t_qa_report_skudim repsku
                   WHERE qa_report_id = :v_inp_qarepid
                     AND company_id = :v_inp_compid
                     AND EXISTS (SELECT 1 FROM scmdata.t_qa_report
                                  WHERE qa_report_id = repsku.qa_report_id
                                    AND company_id = repsku.company_id
                                    AND review_id IS NOT NULL)
                   GROUP BY repsku.asn_id,
                            repsku.company_id,
                            repsku.color_name))';
  
    --执行sql
    EXECUTE IMMEDIATE v_sql
      INTO v_msg
      USING v_inp_qarepid, v_inp_compid;
  
    --返回数据
    RETURN v_msg;
  EXCEPTION
    WHEN priv_exception THEN
      --抛出报错
      raise_application_error(-20002, v_sqlerrm);
    WHEN OTHERS THEN
      --错误信息赋值
      v_sqlerrm := substr(dbms_utility.format_error_stack, 1, 1024);
      v_errinfo := 'Error Object:' || v_selfdescription || chr(10) ||
                   'Error Info: ' || v_sqlerrm || chr(10) || 'Execute_sql:' ||
                   v_sql || chr(10) || 'Params: ' || chr(10) ||
                   'v_inp_qarepid: ' || v_inp_qarepid || chr(10) ||
                   'v_inp_compid: ' || v_inp_compid;
    
      --新增进入错误信息表
      scmdata.pkg_qa_ee.p_ins_errrecord_at(v_inp_errprogram     => v_selfdescription,
                                           v_inp_causeerruserid => v_inp_curuserid,
                                           v_inp_erroccurtime   => SYSDATE,
                                           v_inp_errinfo        => v_errinfo,
                                           v_inp_compid         => v_inp_compid);
    
      --抛出报错
      raise_application_error(-20002, v_sqlerrm);
  END f_message_genlogisticsrestmsg;

  /*=============================================================================
  
     包：
       pkg_qa_ld(qa逻辑细节包)
  
     函数名:
       获取不合格提示人相关信息
  
     入参:
       v_inp_qarepid    :  质检报告id
       v_inp_compid     :  企业id
       v_inp_curuserid  :  当前操作人id
       v_inp_invokeobj  :  调用对象
  
     出参:
       clob 类型， 不合格提示人相关信息
  
     版本:
       2022-12-12_zc314 : 获取不合格提示人相关信息
  
  ==============================================================================*/
  FUNCTION f_message_unqualmetionrelauserinfo(v_inp_qarepid   IN VARCHAR2,
                                              v_inp_compid    IN VARCHAR2,
                                              v_inp_curuserid IN VARCHAR2,
                                              v_inp_invokeobj IN VARCHAR2)
    RETURN CLOB IS
    v_dealfollower VARCHAR2(128);
    v_dealmanager  VARCHAR2(128);
    v_qcmanager    VARCHAR2(128);
    v_relainfo     CLOB;
    priv_exception EXCEPTION;
    v_sql             CLOB;
    v_errinfo         CLOB;
    v_sqlerrm         VARCHAR2(512);
    v_allowinvokeobj  CLOB := 'scmdata.pkg_qa_lc.f_msg_genunqualmsgbyqarep';
    v_selfdescription VARCHAR2(1024) := 'scmdata.pkg_qa_ld.f_message_unqualmetionrelauserinfo';
  BEGIN
    --访问控制
    IF instr(v_allowinvokeobj, v_inp_invokeobj) = 0 THEN
      v_sqlerrm := '拒绝访问：调用方-' || v_inp_invokeobj || ' 被调用方-' ||
                   v_selfdescription;
      RAISE priv_exception;
    END IF;
  
    --构建执行 sql
    v_sql := 'SELECT listagg(DISTINCT UPPER(dealuser.inner_user_id), ''><@'') deal_follower,
         listagg(DISTINCT UPPER(dealmang.inner_user_id), ''><@'') deal_manager,
         listagg(DISTINCT UPPER(qcmang.inner_user_id), ''><@'') qc_manager
    FROM scmdata.pt_ordered ptord
    LEFT JOIN scmdata.sys_company_user dealuser
      ON instr(ptord.flw_order, dealuser.user_id) > 0
     AND ptord.company_id = dealuser.company_id
     AND dealuser.pause = 0
    LEFT JOIN scmdata.sys_company_user dealmang
      ON instr(ptord.flw_order_manager, dealmang.user_id) > 0
     AND ptord.company_id = dealmang.company_id
     AND dealmang.pause = 0
    LEFT JOIN scmdata.sys_company_user qcmang
      ON instr(ptord.qc_manager, qcmang.user_id) > 0
     AND ptord.company_id = qcmang.company_id
     AND qcmang.pause = 0
   WHERE EXISTS (SELECT 1
            FROM scmdata.t_qa_report_skudim repsku
           INNER JOIN scmdata.t_asnordered asned
              ON repsku.asn_id = asned.asn_id
             AND repsku.company_id = asned.company_id
           WHERE repsku.qa_report_id = :v_inp_qarepid
             AND repsku.company_id = :v_inp_compid
             AND asned.order_id = ptord.product_gress_code
             AND asned.company_id = ptord.company_id)';
  
    --执行 sql
    EXECUTE IMMEDIATE v_sql
      INTO v_dealfollower, v_dealmanager, v_qcmanager
      USING v_inp_qarepid, v_inp_compid;
  
    --非空在字符串前方增加@
    IF v_dealfollower IS NOT NULL THEN
      v_dealfollower := '<@' || v_dealfollower || '>';
    END IF;
  
    IF v_dealmanager IS NOT NULL THEN
      v_dealmanager := '<@' || v_dealmanager || '>';
    END IF;
  
    IF v_qcmanager IS NOT NULL THEN
      v_qcmanager := '<@' || v_qcmanager || '>';
    END IF;
  
    --关联信息整合
    v_relainfo := scmdata.f_sentence_append_rc(v_sentence   => v_relainfo,
                                               v_appendstr  => v_dealfollower,
                                               v_middliestr => '');
  
    v_relainfo := scmdata.f_sentence_append_rc(v_sentence   => v_relainfo,
                                               v_appendstr  => v_dealmanager,
                                               v_middliestr => '');
  
    v_relainfo := scmdata.f_sentence_append_rc(v_sentence   => v_relainfo,
                                               v_appendstr  => v_qcmanager,
                                               v_middliestr => '');
  
    IF v_relainfo IS NOT NULL THEN
      v_relainfo := '请' || v_relainfo || '及时处理';
    END IF;
  
    RETURN v_relainfo;
  EXCEPTION
    WHEN priv_exception THEN
      --抛出报错
      raise_application_error(-20002, v_sqlerrm);
    WHEN OTHERS THEN
      --错误信息赋值
      v_sqlerrm := substr(dbms_utility.format_error_stack, 1, 1024);
      v_errinfo := 'Error Object:' || v_selfdescription || chr(10) ||
                   'Error Info: ' || v_sqlerrm || chr(10) || 'Execute_sql:' ||
                   v_sql || chr(10) || 'Params: ' || chr(10) ||
                   'v_inp_qarepid: ' || v_inp_qarepid || chr(10) ||
                   'v_inp_compid: ' || v_inp_compid;
    
      --新增进入错误信息表
      scmdata.pkg_qa_ee.p_ins_errrecord_at(v_inp_errprogram     => v_selfdescription,
                                           v_inp_causeerruserid => v_inp_curuserid,
                                           v_inp_erroccurtime   => SYSDATE,
                                           v_inp_errinfo        => v_errinfo,
                                           v_inp_compid         => v_inp_compid);
    
      --抛出报错
      raise_application_error(-20002, v_sqlerrm);
  END f_message_unqualmetionrelauserinfo;

  /*=============================================================================
  
     包：
       pkg_qa_ld(qa逻辑细节包)
  
     函数名:
       获取不合格提示人相关信息
  
     入参:
       v_inp_qarepid    :  质检报告id
       v_inp_invokeobj  :  调用对象
  
     出参:
       clob 类型， 不合格提示人相关信息
  
     版本:
       2022-12-12_zc314 : 获取不合格提示人相关信息
  
  ==============================================================================*/
  FUNCTION f_message_unqualmetionqarepinfo(v_inp_qarepid   IN VARCHAR2,
                                           v_inp_invokeobj IN VARCHAR2)
    RETURN CLOB IS
    priv_exception EXCEPTION;
    v_retinfo         CLOB;
    v_sqlerrm         VARCHAR2(512);
    v_allowinvokeobj  CLOB := 'scmdata.pkg_qa_lc.f_msg_genunqualmsgbyqarep';
    v_selfdescription VARCHAR2(1024) := 'scmdata.pkg_qa_ld.f_message_unqualmetionrelauserinfo';
  BEGIN
    --访问控制
    IF instr(v_allowinvokeobj, v_inp_invokeobj) = 0 THEN
      v_sqlerrm := '拒绝访问：调用方-' || v_inp_invokeobj || ' 被调用方-' ||
                   v_selfdescription;
      RAISE priv_exception;
    END IF;
  
    --构建执行 sql
    v_retinfo := '质检报告编号: ' || v_inp_qarepid ||
                 ', 报告详情请前往“SCM/QA质检/QA查货不合格待处理清单”查看';
  
    RETURN v_retinfo;
  EXCEPTION
    WHEN priv_exception THEN
      --抛出报错
      raise_application_error(-20002, v_sqlerrm);
  END f_message_unqualmetionqarepinfo;

  /*=============================================================================
  
     包：
       pkg_qa_lc(qa逻辑链包)
  
     过程名:
       根据质检报告获取已检消息的消息头
  
     入参:
       v_inp_qarepid    :  qa质检报告id
       v_inp_compid     :  企业id
       v_inp_curuserid  :  当前操作人id
       v_inp_invokeobj  :  调用对象
  
     版本:
       2022-12-12_zc314 : 根据质检报告获取已检消息的消息头
  
  ==============================================================================*/
  FUNCTION f_message_getqualedheadinfobyqarep(v_inp_qarepid   IN VARCHAR2,
                                              v_inp_compid    IN VARCHAR2,
                                              v_inp_curuserid IN VARCHAR2,
                                              v_inp_invokeobj IN VARCHAR2)
    RETURN CLOB IS
    priv_exception EXCEPTION;
    v_sql             CLOB;
    v_errinfo         CLOB;
    v_sqlerrm         VARCHAR2(512);
    v_retinfo         CLOB;
    v_allowinvokeobj  CLOB := 'scmdata.pkg_qa_lc.f_msg_genqualedmsgbyqarep';
    v_selfdescription VARCHAR2(1024) := 'scmdata.pkg_qa_ld.f_message_getqualedheadinfobyqarep';
  BEGIN
    --访问控制
    IF instr(v_allowinvokeobj, v_inp_invokeobj) = 0 THEN
      v_sqlerrm := '拒绝访问：调用方-' || v_inp_invokeobj || ' 被调用方-' ||
                   v_selfdescription;
      RAISE priv_exception;
    END IF;
  
    --构建执行 sql
    v_sql := 'SELECT MAX(sup.supplier_company_name || '', '' || goo.rela_goo_id || '', '' ||
           goo.style_number || '', 不合格处理结果: '')
  FROM scmdata.t_qa_report_relainfodim reprela
 INNER JOIN scmdata.t_commodity_info goo
    ON reprela.goo_id = goo.goo_id
   AND reprela.company_id = goo.company_id
 INNER JOIN scmdata.t_supplier_info sup
    ON reprela.supplier_code = sup.supplier_code
   AND reprela.company_id = sup.company_id
 WHERE reprela.qa_report_id = :v_inp_qarepid
   AND reprela.company_id = :v_inp_compid';
  
    --执行sql
    EXECUTE IMMEDIATE v_sql
      INTO v_retinfo
      USING v_inp_qarepid, v_inp_compid;
  
    RETURN v_retinfo;
  EXCEPTION
    WHEN priv_exception THEN
      --抛出报错
      raise_application_error(-20002, v_sqlerrm);
    WHEN OTHERS THEN
      --错误信息赋值
      v_sqlerrm := substr(dbms_utility.format_error_stack, 1, 1024);
      v_errinfo := 'Error Object:' || v_selfdescription || chr(10) ||
                   'Error Info: ' || v_sqlerrm || chr(10) || 'Execute_sql:' ||
                   v_sql || chr(10) || 'Params: ' || chr(10) ||
                   'v_inp_qarepid: ' || v_inp_qarepid || chr(10) ||
                   'v_inp_compid: ' || v_inp_compid;
    
      --新增进入错误信息表
      scmdata.pkg_qa_ee.p_ins_errrecord_at(v_inp_errprogram     => v_selfdescription,
                                           v_inp_causeerruserid => v_inp_curuserid,
                                           v_inp_erroccurtime   => SYSDATE,
                                           v_inp_errinfo        => v_errinfo,
                                           v_inp_compid         => v_inp_compid);
    
      --抛出报错
      raise_application_error(-20002, v_sqlerrm);
  END f_message_getqualedheadinfobyqarep;

  /*=============================================================================
  
     包：
       pkg_qa_ld(qa逻辑细节包)
  
     函数名:
       获取已检信息
  
     入参:
       v_inp_qarepid      :  质检报告id
       v_inp_transresult  :  质检传输结果
       v_inp_compid       :  企业id
       v_inp_curuserid    :  当前操作人id
       v_inp_invokeobj    :  调用对象
  
     版本:
       2022-12-13_zc314 : 获取已检信息
  
  ==============================================================================*/
  FUNCTION f_message_getqualedmsgbyqarep(v_inp_qarepid     IN VARCHAR2,
                                         v_inp_transresult IN VARCHAR2,
                                         v_inp_compid      IN VARCHAR2,
                                         v_inp_curuserid   IN VARCHAR2,
                                         v_inp_invokeobj   IN VARCHAR2)
    RETURN CLOB IS
    priv_exception EXCEPTION;
    v_sql             CLOB;
    v_errinfo         CLOB;
    v_sqlerrm         VARCHAR2(512);
    v_infos           CLOB;
    v_allowinvokeobj  CLOB := 'scmdata.pkg_qa_lc.f_msg_genqualedmsgbyqarep';
    v_selfdescription VARCHAR2(1024) := 'scmdata.pkg_qa_ld.f_message_getqualedmsg';
  BEGIN
    --访问控制
    IF instr(v_allowinvokeobj, v_inp_invokeobj) = 0 THEN
      v_sqlerrm := '拒绝访问：调用方-' || v_inp_invokeobj || ' 被调用方-' ||
                   v_selfdescription;
      RAISE priv_exception;
    END IF;
  
    --构建执行 sql
    v_sql := 'SELECT listagg(info, '', '') infos
  FROM (SELECT CASE
                 WHEN nagnum = 0 AND posnum > 0 THEN
                  color_name
                 WHEN posnum > 0 THEN
                  color_name || ''('' || sizenames || '')''
                 WHEN posnum = 0 THEN
                   NULL
               END info
          FROM (SELECT color_name,
                       listagg(sizename, ''、'') sizenames,
                       SUM(posnum) posnum,
                       SUM(nagnum) nagnum
                  FROM (SELECT asn_id,
                               company_id,
                               color_name,
                               (CASE
                                 WHEN trans_result = :v_inp_transresult THEN
                                  size_name
                               END) sizename,
                               (CASE
                                 WHEN trans_result = :v_inp_transresult THEN
                                  1
                                 ELSE
                                  0
                               END) posnum,
                               (CASE
                                 WHEN trans_result <> :v_inp_transresult THEN
                                  1
                                 ELSE
                                  0
                               END) nagnum
                          FROM scmdata.t_qa_report_skudim repsku
                         WHERE qa_report_id = :v_inp_qarepid
                           AND company_id = :v_inp_compid
                           AND EXISTS
                         (SELECT 1
                                  FROM scmdata.t_qa_report
                                 WHERE qa_report_id = repsku.qa_report_id
                                   AND company_id = repsku.company_id
                                   AND status = ''AF''))
                 GROUP BY color_name))';
  
    --执行sql
    EXECUTE IMMEDIATE v_sql
      INTO v_infos
      USING v_inp_transresult, v_inp_transresult, v_inp_transresult, v_inp_qarepid, v_inp_compid;
  
    --如果质检信息为空，赋值为“无”
    IF v_infos IS NULL THEN
      v_infos := '无';
    END IF;
  
    --根据传输结果变换拼接数据
    IF v_inp_transresult = 'PS' THEN
      v_infos := '①收货 [ ' || v_infos || ' ]';
    ELSIF v_inp_transresult = 'NP' THEN
      v_infos := '②批退 [ ' || v_infos || ' ]';
    ELSIF v_inp_transresult = 'RT' THEN
      v_infos := '③到仓返工 [ ' || v_infos || ' ]';
    END IF;
  
    --返回质检消息
    RETURN v_infos;
  EXCEPTION
    WHEN priv_exception THEN
      --抛出报错
      raise_application_error(-20002, v_sqlerrm);
    WHEN OTHERS THEN
      --错误信息赋值
      v_sqlerrm := substr(dbms_utility.format_error_stack, 1, 1024);
      v_errinfo := 'Error Object:' || v_selfdescription || chr(10) ||
                   'Error Info: ' || v_sqlerrm || chr(10) || 'Execute_sql:' ||
                   v_sql || chr(10) || 'Params: ' || chr(10) ||
                   'v_inp_qarepid: ' || v_inp_qarepid || chr(10) ||
                   'v_inp_compid: ' || v_inp_compid;
    
      --新增进入错误信息表
      scmdata.pkg_qa_ee.p_ins_errrecord_at(v_inp_errprogram     => v_selfdescription,
                                           v_inp_causeerruserid => v_inp_curuserid,
                                           v_inp_erroccurtime   => SYSDATE,
                                           v_inp_errinfo        => v_errinfo,
                                           v_inp_compid         => v_inp_compid);
    
      --抛出报错
      raise_application_error(-20002, v_sqlerrm);
  END f_message_getqualedmsgbyqarep;

  /*=============================================================================
  
     包：
       pkg_qa_ld(qa逻辑细节包)
  
     过程名:
       qa消息配置表新增
  
     入参:
       v_inp_configcode   :  qa消息配置编码
       v_inp_configname   :  qa消息配置名称
       v_inp_keyurl       :  机器人key（url）
       v_inp_curuserid    :  操作人id
       v_inp_compid       :  企业id
       v_inp_invokeobj    :  调用对象
  
     版本:
       2022-12-08_zc314 : qa消息配置表新增
  
  ==============================================================================*/
  PROCEDURE p_msg_insqamsgconfig(v_inp_configcode IN VARCHAR2,
                                 v_inp_configname IN VARCHAR2,
                                 v_inp_keyurl     IN VARCHAR2,
                                 v_inp_curuserid  IN VARCHAR2,
                                 v_inp_compid     IN VARCHAR2,
                                 v_inp_invokeobj  IN VARCHAR2) IS
    priv_exception EXCEPTION;
    v_sql             CLOB;
    v_errinfo         CLOB;
    v_sqlerrm         VARCHAR2(512);
    v_configid        VARCHAR2(32) := scmdata.f_get_uuid();
    v_allowinvokeobj  CLOB := 'scmdata.pkg_qa_lc.p_msg_insorupdqamsgconfig';
    v_selfdescription VARCHAR2(1024) := 'scmdata.pkg_qa_ld.p_msg_insqamsgconfig';
  BEGIN
    --访问控制
    IF instr(v_allowinvokeobj, v_inp_invokeobj) = 0 THEN
      v_sqlerrm := '拒绝访问：调用方-' || v_inp_invokeobj || ' 被调用方-' ||
                   v_selfdescription;
      RAISE priv_exception;
    END IF;
  
    v_sql := 'INSERT INTO scmdata.t_qa_msgconfig
  (config_id,
   company_id,
   config_code,
   config_name,
   key_url,
   create_id,
   create_time)
VALUES
  (:v_configid,
   :v_inp_compid,
   :v_inp_configcode,
   :v_inp_configname,
   :v_inp_keyurl,
   :v_inp_curuserid,
   SYSDATE)';
  
    EXECUTE IMMEDIATE v_sql
      USING v_configid, v_inp_compid, v_inp_configcode, v_inp_configname, v_inp_keyurl, v_inp_curuserid;
  EXCEPTION
    WHEN priv_exception THEN
      --抛出报错
      raise_application_error(-20002, v_sqlerrm);
    WHEN OTHERS THEN
      --错误信息赋值
      v_sqlerrm := substr(dbms_utility.format_error_stack, 1, 1024);
      v_errinfo := 'Error Object:' || v_selfdescription || chr(10) ||
                   'Error Info: ' || v_sqlerrm || chr(10) || 'Execute_sql:' ||
                   v_sql || chr(10) || 'Params: ' || chr(10) ||
                   'v_configid: ' || v_configid || chr(10) ||
                   'v_inp_compid: ' || v_inp_compid || chr(10) ||
                   'v_inp_configcode: ' || v_inp_configcode || chr(10) ||
                   'v_inp_configname: ' || v_inp_configname || chr(10) ||
                   'v_inp_keyurl: ' || v_inp_keyurl || chr(10) ||
                   'v_inp_curuserid: ' || v_inp_curuserid;
    
      --新增进入错误信息表
      scmdata.pkg_qa_ee.p_ins_errrecord_at(v_inp_errprogram     => v_selfdescription,
                                           v_inp_causeerruserid => v_inp_curuserid,
                                           v_inp_erroccurtime   => SYSDATE,
                                           v_inp_errinfo        => v_errinfo,
                                           v_inp_compid         => v_inp_compid);
    
      --抛出报错
      raise_application_error(-20002, v_sqlerrm);
  END p_msg_insqamsgconfig;

  /*=============================================================================
  
     包：
       pkg_qa_ld(qa逻辑细节包)
  
     过程名:
       qa消息配置表修改
  
     入参:
       v_inp_configcode   :  qa消息配置编码
       v_inp_configname   :  qa消息配置名称
       v_inp_keyurl       :  机器人key（url）
       v_inp_curuserid    :  操作人id
       v_inp_compid       :  企业id
       v_inp_invokeobj    :  调用对象
  
     版本:
       2022-12-08_zc314 : qa消息配置表修改
  
  ==============================================================================*/
  PROCEDURE p_msg_updqamsgconfig(v_inp_configcode IN VARCHAR2,
                                 v_inp_configname IN VARCHAR2,
                                 v_inp_keyurl     IN VARCHAR2,
                                 v_inp_curuserid  IN VARCHAR2,
                                 v_inp_compid     IN VARCHAR2,
                                 v_inp_invokeobj  IN VARCHAR2) IS
    priv_exception EXCEPTION;
    v_sql             CLOB;
    v_errinfo         CLOB;
    v_sqlerrm         VARCHAR2(512);
    v_allowinvokeobj  CLOB := 'scmdata.pkg_qa_lc.p_msg_insorupdqamsgconfig';
    v_selfdescription VARCHAR2(1024) := 'scmdata.pkg_qa_ld.p_msg_updqamsgconfig';
  BEGIN
    --访问控制
    IF instr(v_allowinvokeobj, v_inp_invokeobj) = 0 THEN
      v_sqlerrm := '拒绝访问：调用方-' || v_inp_invokeobj || ' 被调用方-' ||
                   v_selfdescription;
      RAISE priv_exception;
    END IF;
  
    v_sql := 'UPDATE scmdata.t_qa_msgconfig
   SET config_name = :v_inp_configname,
       key_url = :v_inp_keyurl,
       update_id = :v_inp_curuserid,
       update_time = SYSDATE
 WHERE config_code = :v_inp_configcode
   AND company_id = :v_inp_compid';
  
    EXECUTE IMMEDIATE v_sql
      USING v_inp_configname, v_inp_keyurl, v_inp_curuserid, v_inp_configcode, v_inp_compid;
  EXCEPTION
    WHEN priv_exception THEN
      --抛出报错
      raise_application_error(-20002, v_sqlerrm);
    WHEN OTHERS THEN
      --错误信息赋值
      v_sqlerrm := substr(dbms_utility.format_error_stack, 1, 1024);
      v_errinfo := 'Error Object:' || v_selfdescription || chr(10) ||
                   'Error Info: ' || v_sqlerrm || chr(10) || 'Execute_sql:' ||
                   v_sql || chr(10) || 'Params: ' || chr(10) ||
                   'v_inp_configname: ' || v_inp_configname || chr(10) ||
                   'v_inp_keyurl: ' || v_inp_keyurl || chr(10) ||
                   'v_inp_curuserid: ' || v_inp_curuserid || chr(10) ||
                   'v_inp_configcode: ' || v_inp_configcode || chr(10) ||
                   'v_inp_compid: ' || v_inp_compid;
    
      --新增进入错误信息表
      scmdata.pkg_qa_ee.p_ins_errrecord_at(v_inp_errprogram     => v_selfdescription,
                                           v_inp_causeerruserid => v_inp_curuserid,
                                           v_inp_erroccurtime   => SYSDATE,
                                           v_inp_errinfo        => v_errinfo,
                                           v_inp_compid         => v_inp_compid);
    
      --抛出报错
      raise_application_error(-20002, v_sqlerrm);
  END p_msg_updqamsgconfig;

  /*=============================================================================
  
     包：
       pkg_qa_ld(qa逻辑细节包)
  
     过程名:
       qa消息表新增
  
     入参:
       v_inp_configcode  :  qa消息配置编码
       v_inp_unqinfo     :  唯一信息
       v_inp_msgstatus   :  消息状态
       v_inp_msginfo     :  消息内容
       v_inp_curuserid   :  当前操作人id
       v_inp_compid      :  企业id
       v_inp_invokeobj   :  调用对象
  
     版本:
       2022-12-08_zc314 : qa消息表新增
  
  ==============================================================================*/
  PROCEDURE p_msg_insqamsginfo(v_inp_configcode IN VARCHAR2,
                               v_inp_unqinfo    IN VARCHAR2,
                               v_inp_msgstatus  IN VARCHAR2,
                               v_inp_msgtype    IN VARCHAR2,
                               v_inp_msginfo    IN VARCHAR2,
                               v_inp_curuserid  IN VARCHAR2,
                               v_inp_compid     IN VARCHAR2,
                               v_inp_invokeobj  IN VARCHAR2) IS
    priv_exception EXCEPTION;
    v_msginfoid       VARCHAR2(32) := scmdata.f_get_uuid();
    v_sql             CLOB;
    v_errinfo         CLOB;
    v_sqlerrm         VARCHAR2(512);
    v_allowinvokeobj  CLOB := 'scmdata.pkg_qa_lc.p_msg_insorupdqamsginfo';
    v_selfdescription VARCHAR2(1024) := 'scmdata.pkg_qa_ld.p_msg_insqamsginfo';
  BEGIN
    --访问控制
    IF instr(v_allowinvokeobj, v_inp_invokeobj) = 0 THEN
      v_sqlerrm := '拒绝访问：调用方-' || v_inp_invokeobj || ' 被调用方-' ||
                   v_selfdescription;
      RAISE priv_exception;
    END IF;
  
    --构建执行sql
    v_sql := 'INSERT INTO scmdata.t_qa_msginfo
  (msginfo_id,
   company_id,
   config_code,
   unq_info,
   msg_status,
   msg_type,
   msg_info,
   create_id,
   create_time)
VALUES
  (:v_msginfoid,
   :v_inp_compid,
   :v_inp_configcode,
   :v_inp_unqinfo,
   :v_inp_msgstatus,
   :v_inp_msgtype,
   :v_inp_msginfo,
   :v_inp_curuserid,
   SYSDATE)';
  
    --执行sql
    EXECUTE IMMEDIATE v_sql
      USING v_msginfoid, v_inp_compid, v_inp_configcode, v_inp_unqinfo, v_inp_msgstatus, v_inp_msgtype, v_inp_msginfo, v_inp_curuserid;
  
  EXCEPTION
    WHEN priv_exception THEN
      --抛出报错
      raise_application_error(-20002, v_sqlerrm);
    WHEN OTHERS THEN
      --错误信息赋值
      v_sqlerrm := substr(dbms_utility.format_error_stack, 1, 1024);
      v_errinfo := 'Error Object:' || v_selfdescription || chr(10) ||
                   'Error Info: ' || v_sqlerrm || chr(10) || 'Execute_sql:' ||
                   v_sql || chr(10) || 'Params: ' || chr(10) ||
                   'v_msginfoid: ' || v_msginfoid || chr(10) ||
                   'v_inp_compid: ' || v_inp_compid || chr(10) ||
                   'v_inp_configcode: ' || v_inp_configcode || chr(10) ||
                   'v_inp_unqinfo: ' || v_inp_unqinfo || chr(10) ||
                   'v_inp_msgstatus: ' || v_inp_msgstatus || chr(10) ||
                   'v_inp_msgtype: ' || v_inp_msgtype || chr(10) ||
                   'v_inp_msginfo: ' || v_inp_msginfo || chr(10) ||
                   'v_inp_curuserid: ' || v_inp_curuserid;
    
      --新增进入错误信息表
      scmdata.pkg_qa_ee.p_ins_errrecord_at(v_inp_errprogram     => v_selfdescription,
                                           v_inp_causeerruserid => v_inp_curuserid,
                                           v_inp_erroccurtime   => SYSDATE,
                                           v_inp_errinfo        => v_errinfo,
                                           v_inp_compid         => v_inp_compid);
    
      --抛出报错
      raise_application_error(-20002, v_sqlerrm);
  END p_msg_insqamsginfo;

  /*=============================================================================
  
     包：
       pkg_qa_ld(qa逻辑细节包)
  
     过程名:
       qa消息表修改
  
     入参:
       v_inp_configcode  :  qa消息配置编码
       v_inp_unqinfo     :  唯一信息
       v_inp_msgstatus   :  消息状态
       v_inp_msgtype     :  消息类型
       v_inp_msginfo     :  消息内容
       v_inp_curuserid   :  当前操作人id
       v_inp_compid      :  企业id
       v_inp_invokeobj   :  调用对象
  
     版本:
       2022-12-08_zc314 : qa消息表修改
  
  ==============================================================================*/
  PROCEDURE p_msg_updqamsginfo(v_inp_configcode IN VARCHAR2,
                               v_inp_unqinfo    IN VARCHAR2,
                               v_inp_msgstatus  IN VARCHAR2,
                               v_inp_msgtype    IN VARCHAR2,
                               v_inp_msginfo    IN VARCHAR2,
                               v_inp_curuserid  IN VARCHAR2,
                               v_inp_compid     IN VARCHAR2,
                               v_inp_invokeobj  IN VARCHAR2) IS
    priv_exception EXCEPTION;
    v_sql             CLOB;
    v_errinfo         CLOB;
    v_sqlerrm         VARCHAR2(512);
    v_allowinvokeobj  CLOB := 'scmdata.pkg_qa_lc.p_msg_insorupdqamsginfo';
    v_selfdescription VARCHAR2(1024) := 'scmdata.pkg_qa_ld.p_msg_insqamsginfo';
  BEGIN
    --访问控制
    IF instr(v_allowinvokeobj, v_inp_invokeobj) = 0 THEN
      v_sqlerrm := '拒绝访问：调用方-' || v_inp_invokeobj || ' 被调用方-' ||
                   v_selfdescription;
      RAISE priv_exception;
    END IF;
  
    --构建执行sql
    v_sql := 'UPDATE scmdata.t_qa_msginfo
   SET msg_status = :v_inp_msgstatus,
       msg_type = :v_inp_msgtype,
       msg_info = :v_inp_msginfo,
       update_id = :v_inp_curuserid,
       update_time = SYSDATE
 WHERE config_code = :v_inp_configcode
   AND unq_info = :v_inp_unqinfo';
  
    --执行sql
    EXECUTE IMMEDIATE v_sql
      USING v_inp_msgstatus, v_inp_msgtype, v_inp_msginfo, v_inp_curuserid, v_inp_configcode, v_inp_unqinfo;
  
  EXCEPTION
    WHEN priv_exception THEN
      --抛出报错
      raise_application_error(-20002, v_sqlerrm);
    WHEN OTHERS THEN
      --错误信息赋值
      v_sqlerrm := substr(dbms_utility.format_error_stack, 1, 1024);
      v_errinfo := 'Error Object:' || v_selfdescription || chr(10) ||
                   'Error Info: ' || v_sqlerrm || chr(10) || 'Execute_sql:' ||
                   v_sql || chr(10) || 'Params: ' || chr(10) ||
                   'v_inp_msgstatus: ' || v_inp_msgstatus || chr(10) ||
                   'v_inp_msgtype: ' || v_inp_msgtype || chr(10) ||
                   'v_inp_msginfo: ' || v_inp_msginfo || chr(10) ||
                   'v_inp_curuserid: ' || v_inp_curuserid || chr(10) ||
                   'v_inp_configcode: ' || v_inp_configcode || chr(10) ||
                   'v_inp_unqinfo: ' || v_inp_unqinfo;
    
      --新增进入错误信息表
      scmdata.pkg_qa_ee.p_ins_errrecord_at(v_inp_errprogram     => v_selfdescription,
                                           v_inp_causeerruserid => v_inp_curuserid,
                                           v_inp_erroccurtime   => SYSDATE,
                                           v_inp_errinfo        => v_errinfo,
                                           v_inp_compid         => v_inp_compid);
    
      --抛出报错
      raise_application_error(-20002, v_sqlerrm);
  END p_msg_updqamsginfo;

  /*=============================================================================
  
     包：
       pkg_qa_ld(qa逻辑细节包)
  
     函数名:
       【消息提醒】启停xxl_job特定执行参数任务
  
     入参:
       v_inp_triggerstatus  :  触发器状态 0-停用 1-启用
       v_inp_executorparam  :  执行参数
       v_inp_invokeobj      :  调用对象
  
     版本:
       2022-12-08_zc314 : 启停xxl_job特定执行参数任务
  
  ==============================================================================*/
  PROCEDURE p_msg_updxxlinfotriggerstatus(v_inp_triggerstatus IN VARCHAR2,
                                          v_inp_executorparam IN VARCHAR2,
                                          v_inp_invokeobj     IN VARCHAR2) IS
    priv_exception EXCEPTION;
    v_compid          VARCHAR2(32) := 'b6cc680ad0f599cde0531164a8c0337f';
    v_sql             CLOB;
    v_errinfo         CLOB;
    v_sqlerrm         VARCHAR2(512);
    v_allowinvokeobj  CLOB := 'scmdata.pkg_qa_lc.f_msg_earliestqamsg;scmdata.pkg_qa_lc.p_msg_listenerinfo';
    v_selfdescription VARCHAR2(1024) := 'scmdata.pkg_qa_ld.p_upd_xxlinfotriggerstatus';
  BEGIN
    --访问控制
    IF instr(v_allowinvokeobj, v_inp_invokeobj) = 0 THEN
      v_sqlerrm := '拒绝访问：调用方-' || v_inp_invokeobj || ' 被调用方-' ||
                   v_selfdescription;
      RAISE priv_exception;
    END IF;
  
    --构建执行sql
    v_sql := 'UPDATE bw3.xxl_job_info
   SET trigger_status = :v_inp_triggerstatus
 WHERE executor_param = :v_inp_executorparam';
  
    --执行sql
    EXECUTE IMMEDIATE v_sql
      USING v_inp_triggerstatus, v_inp_executorparam;
  EXCEPTION
    WHEN priv_exception THEN
      --抛出报错
      raise_application_error(-20002, v_sqlerrm);
    WHEN OTHERS THEN
      --错误信息赋值
      v_sqlerrm := substr(dbms_utility.format_error_stack, 1, 1024);
      v_errinfo := 'Error Object:' || v_selfdescription || chr(10) ||
                   'Error Info: ' || v_sqlerrm || chr(10) || 'Execute_sql:' ||
                   v_sql || chr(10) || 'Params: ' || chr(10) ||
                   'v_inp_triggerstatus: ' ||
                   to_number(v_inp_triggerstatus) || chr(10) ||
                   'v_inp_executorparam: ' || v_inp_executorparam;
    
      --新增进入错误信息表
      scmdata.pkg_qa_ee.p_ins_errrecord_at(v_inp_errprogram     => v_selfdescription,
                                           v_inp_causeerruserid => v_inp_invokeobj,
                                           v_inp_erroccurtime   => SYSDATE,
                                           v_inp_errinfo        => v_errinfo,
                                           v_inp_compid         => v_compid);
    
      --抛出报错
      raise_application_error(-20002, v_sqlerrm);
  END p_msg_updxxlinfotriggerstatus;

  /*=============================================================================
  
     包：
       pkg_qa_ld(qa逻辑细节包)
  
     过程名:
       【scm传输wms】启停xxl_job特定执行参数任务
  
     入参:
       v_inp_triggerstatus  :  触发器状态 0-停用 1-启用
       v_inp_executorparam  :  执行参数
       v_inp_invokeobj      :  调用对象
  
     版本:
       2023-03-02_zc314 : 启停xxl_job特定执行参数任务
  
  ==============================================================================*/
  PROCEDURE p_scmtwms_updxxlinfotriggerstatus_at(v_inp_triggerstatus IN VARCHAR2,
                                                 v_inp_executorparam IN VARCHAR2,
                                                 v_inp_invokeobj     IN VARCHAR2) IS
    PRAGMA AUTONOMOUS_TRANSACTION;
    priv_exception EXCEPTION;
    v_compid          VARCHAR2(32) := 'b6cc680ad0f599cde0531164a8c0337f';
    v_sql             CLOB;
    v_errinfo         CLOB;
    v_sqlerrm         VARCHAR2(512);
    v_allowinvokeobj  CLOB := 'action_transwmsbyasn;action_disptranswmsbyasn;action_transwmsbysku;action_disptranswmsbysku;action_transwmsbyae;action_disptranswmsbyae';
    v_selfdescription VARCHAR2(1024) := 'scmdata.pkg_qa_ld.p_scmtwms_updxxlinfotriggerstatus_at';
  BEGIN
    --访问控制
    IF instr(v_allowinvokeobj, v_inp_invokeobj) = 0 THEN
      v_sqlerrm := '拒绝访问：调用方-' || v_inp_invokeobj || ' 被调用方-' ||
                   v_selfdescription;
      RAISE priv_exception;
    END IF;
  
    --构建执行sql
    v_sql := 'UPDATE bw3.xxl_job_info
   SET trigger_status = :v_inp_triggerstatus
 WHERE executor_param = :v_inp_executorparam';
  
    --执行sql
    EXECUTE IMMEDIATE v_sql
      USING v_inp_triggerstatus, v_inp_executorparam;
  
    --提交
    COMMIT;
  EXCEPTION
    WHEN priv_exception THEN
      --抛出报错
      raise_application_error(-20002, v_sqlerrm);
    WHEN OTHERS THEN
      --错误信息赋值
      v_sqlerrm := substr(dbms_utility.format_error_stack, 1, 1024);
      v_errinfo := 'Error Object:' || v_selfdescription || chr(10) ||
                   'Error Info: ' || v_sqlerrm || chr(10) || 'Execute_sql:' ||
                   v_sql || chr(10) || 'Params: ' || chr(10) ||
                   'v_inp_triggerstatus: ' ||
                   to_number(v_inp_triggerstatus) || chr(10) ||
                   'v_inp_executorparam: ' || v_inp_executorparam;
    
      --新增进入错误信息表
      scmdata.pkg_qa_ee.p_ins_errrecord_at(v_inp_errprogram     => v_selfdescription,
                                           v_inp_causeerruserid => v_inp_invokeobj,
                                           v_inp_erroccurtime   => SYSDATE,
                                           v_inp_errinfo        => v_errinfo,
                                           v_inp_compid         => v_compid);
    
      --抛出报错
      raise_application_error(-20002, v_sqlerrm);
  END p_scmtwms_updxxlinfotriggerstatus_at;

  /*=============================================================================
  
     包：
       pkg_qa_ld(qa逻辑细节包)
  
     函数名:
       qa尺寸核对表新增
  
     入参:
       v_inp_qarepid     :  qa质检报告id
       v_inp_position    :  部位
       v_inp_compid      :  企业id
       v_inp_gooid       :  商品档案编号
       v_inp_barcode     :  条码
       v_inp_seqno       :  序号
       v_inp_actualsize  :  实际尺码
       v_inp_curuserid   :  当前操作人id
       v_inp_invokeobj   :  调用对象
  
     版本:
       2022-12-14_zc314 : qa尺寸核对表新增
       2022-12-15_zc314 : 维度调整，增加尺寸表id维度
       2023-01-04_zc314 : 维度调整，尺寸表id修改为部位
  
  ==============================================================================*/
  PROCEDURE p_sizechart_insqasizecheckchart(v_inp_qarepid    IN VARCHAR2,
                                            v_inp_position   IN VARCHAR2,
                                            v_inp_compid     IN VARCHAR2,
                                            v_inp_gooid      IN VARCHAR2,
                                            v_inp_barcode    IN VARCHAR2,
                                            v_inp_seqno      IN NUMBER,
                                            v_inp_actualsize IN NUMBER,
                                            v_inp_curuserid  IN VARCHAR2,
                                            v_inp_invokeobj  IN VARCHAR2) IS
    priv_exception EXCEPTION;
    v_sccid           VARCHAR2(32) := scmdata.f_get_uuid();
    v_sql             CLOB;
    v_errinfo         CLOB;
    v_sqlerrm         VARCHAR2(512);
    v_allowinvokeobj  CLOB := 'scmdata.pkg_qa_lc.p_sizechart_insorupdqasizecheckchart;scmdata.pkg_qa_lc.p_sizechart_genqasizecheckchartkleakdatabysizechartins';
    v_selfdescription VARCHAR2(1024) := 'scmdata.pkg_qa_ld.p_sizechart_insqasizecheckchart';
  BEGIN
    --访问控制
    IF instr(v_allowinvokeobj, v_inp_invokeobj) = 0 THEN
      v_sqlerrm := '拒绝访问：调用方-' || v_inp_invokeobj || ' 被调用方-' ||
                   v_selfdescription;
      RAISE priv_exception;
    END IF;
  
    --构建 sql
    v_sql := 'INSERT INTO scmdata.t_qa_sizecheckchart
  (scc_id,
   company_id,
   qa_report_id,
   position,
   goo_id,
   barcode,
   seq_no,
   actual_size,
   create_id,
   create_time)
VALUES
  (:v_sccid,
   :v_inp_compid,
   :v_inp_qarepid,
   :v_inp_position,
   :v_inp_gooid,
   :v_inp_barcode,
   :v_inp_seqno,
   :v_inp_actualsize,
   :v_inp_curuserid,
   SYSDATE)';
  
    EXECUTE IMMEDIATE v_sql
      USING v_sccid, v_inp_compid, v_inp_qarepid, v_inp_position, v_inp_gooid, v_inp_barcode, v_inp_seqno, v_inp_actualsize, v_inp_curuserid;
  
  EXCEPTION
    WHEN priv_exception THEN
      --抛出报错
      raise_application_error(-20002, v_sqlerrm);
    WHEN OTHERS THEN
      --错误信息赋值
      v_sqlerrm := substr(dbms_utility.format_error_stack, 1, 1024);
      v_errinfo := 'Error Object:' || v_selfdescription || chr(10) ||
                   'Error Info: ' || v_sqlerrm || chr(10) || 'Execute_sql:' ||
                   v_sql || chr(10) || 'Params: ' || chr(10) || 'v_sccid: ' ||
                   v_sccid || chr(10) || 'v_inp_compid: ' || v_inp_compid ||
                   chr(10) || 'v_inp_qarepid: ' || v_inp_qarepid || chr(10) ||
                   'v_inp_position: ' || v_inp_position || chr(10) ||
                   'v_inp_gooid: ' || v_inp_gooid || chr(10) ||
                   'v_inp_barcode: ' || v_inp_barcode || chr(10) ||
                   'v_inp_seqno: ' || to_char(v_inp_seqno) || chr(10) ||
                   'v_inp_actualsize: ' || v_inp_actualsize || chr(10) ||
                   'v_inp_curuserid: ' || v_inp_curuserid;
    
      --新增进入错误信息表
      scmdata.pkg_qa_ee.p_ins_errrecord_at(v_inp_errprogram     => v_selfdescription,
                                           v_inp_causeerruserid => v_inp_curuserid,
                                           v_inp_erroccurtime   => SYSDATE,
                                           v_inp_errinfo        => v_errinfo,
                                           v_inp_compid         => v_inp_compid);
    
      --抛出报错
      raise_application_error(-20002, v_sqlerrm);
  END p_sizechart_insqasizecheckchart;

  /*=============================================================================
  
     包：
       pkg_qa_ld(qa逻辑细节包)
  
     函数名:
       qa尺寸核对表修改
  
     入参:
       v_inp_qarepid      :  qa质检报告id
       v_inp_position     :  部位
       v_inp_compid       :  企业id
       v_inp_gooid        :  商品档案编号
       v_inp_barcode      :  条码
       v_inp_seqno        :  序号
       v_inp_actualsize   :  实际尺码
       v_inp_curuserid    :  当前操作人id
       v_inp_invokeobj    :  调用对象
  
     版本:
       2022-12-14_zc314 : qa尺寸核对表修改
       2022-12-15_zc314 : 维度调整，增加尺寸表id维度
       2023-01-04_zc314 : 维度调整，尺寸表id修改为部位
  
  ==============================================================================*/
  PROCEDURE p_sizechart_updqasizecheckchart(v_inp_qarepid    IN VARCHAR2,
                                            v_inp_position   IN VARCHAR2,
                                            v_inp_compid     IN VARCHAR2,
                                            v_inp_gooid      IN VARCHAR2,
                                            v_inp_barcode    IN VARCHAR2,
                                            v_inp_seqno      IN NUMBER,
                                            v_inp_actualsize IN NUMBER,
                                            v_inp_curuserid  IN VARCHAR2,
                                            v_inp_invokeobj  IN VARCHAR2) IS
    priv_exception EXCEPTION;
    v_sql             CLOB;
    v_errinfo         CLOB;
    v_sqlerrm         VARCHAR2(512);
    v_allowinvokeobj  CLOB := 'scmdata.pkg_qa_lc.p_sizechart_insorupdqasizecheckchart';
    v_selfdescription VARCHAR2(1024) := 'scmdata.pkg_qa_ld.p_sizechart_updqasizecheckchart';
  BEGIN
    --访问控制
    IF instr(v_allowinvokeobj, v_inp_invokeobj) = 0 THEN
      v_sqlerrm := '拒绝访问：调用方-' || v_inp_invokeobj || ' 被调用方-' ||
                   v_selfdescription;
      RAISE priv_exception;
    END IF;
  
    --构建 sql
    v_sql := 'UPDATE scmdata.t_qa_sizecheckchart
   SET actual_size = :v_inp_actualsize,
       update_id = :v_inp_curuserid,
       update_time = SYSDATE
 WHERE qa_report_id = :v_inp_qarepid
   AND position = :v_inp_position
   AND company_id = :v_inp_compid
   AND goo_id = :v_inp_gooid
   AND barcode = :v_inp_barcode
   AND seq_no = :v_inp_seqno';
  
    EXECUTE IMMEDIATE v_sql
      USING v_inp_actualsize, v_inp_curuserid, v_inp_qarepid, v_inp_position, v_inp_compid, v_inp_gooid, v_inp_barcode, v_inp_seqno;
  
  EXCEPTION
    WHEN priv_exception THEN
      --抛出报错
      raise_application_error(-20002, v_sqlerrm);
    WHEN OTHERS THEN
      --错误信息赋值
      v_sqlerrm := substr(dbms_utility.format_error_stack, 1, 1024);
      v_errinfo := 'Error Object:' || v_selfdescription || chr(10) ||
                   'Error Info: ' || v_sqlerrm || chr(10) || 'Execute_sql:' ||
                   v_sql || chr(10) || 'Params: ' || chr(10) ||
                   'v_inp_actualsize: ' || v_inp_actualsize || chr(10) ||
                   'v_inp_curuserid: ' || v_inp_curuserid || chr(10) ||
                   'v_inp_qarepid: ' || v_inp_qarepid || chr(10) ||
                   'v_inp_position: ' || v_inp_position || chr(10) ||
                   'v_inp_compid: ' || v_inp_compid || chr(10) ||
                   'v_inp_gooid: ' || v_inp_gooid || chr(10) ||
                   'v_inp_barcode: ' || v_inp_barcode || chr(10) ||
                   'v_inp_seqno: ' || to_char(v_inp_seqno);
    
      --新增进入错误信息表
      scmdata.pkg_qa_ee.p_ins_errrecord_at(v_inp_errprogram     => v_selfdescription,
                                           v_inp_causeerruserid => v_inp_curuserid,
                                           v_inp_erroccurtime   => SYSDATE,
                                           v_inp_errinfo        => v_errinfo,
                                           v_inp_compid         => v_inp_compid);
    
      --抛出报错
      raise_application_error(-20002, v_sqlerrm);
  END p_sizechart_updqasizecheckchart;

  /*=============================================================================
  
     包：
       pkg_qa_ld(qa逻辑细节包)
  
     函数名:
       根据商品档案编号更新 qa尺寸核对表数据为作废
  
     入参:
       v_inp_gooid      :  商品档案编号
       v_inp_compid     :  企业id
       v_inp_curuserid  :  当前操作人id
       v_inp_invokeobj  :  调用对象
  
     版本:
       2023-01-04_zc314 : 根据商品档案编号更新 qa尺寸核对表数据为作废
  
  ==============================================================================*/
  PROCEDURE p_sizechart_updqasccisdeprecationastrue(v_inp_gooid     IN VARCHAR2,
                                                    v_inp_compid    IN VARCHAR2,
                                                    v_inp_curuserid IN VARCHAR2,
                                                    v_inp_invokeobj IN VARCHAR2) IS
  
    priv_exception EXCEPTION;
    v_sql             CLOB;
    v_errinfo         CLOB;
    v_sqlerrm         VARCHAR2(512);
    v_allowinvokeobj  CLOB := 'scmdata.pkg_qa_lc.p_sizechart_updqasizecheckchartbysizechartdel';
    v_selfdescription VARCHAR2(1024) := 'scmdata.pkg_qa_lc.p_sizechart_updqasizecheckchartbysizechartdel';
  BEGIN
    --访问控制
    IF instr(v_allowinvokeobj, v_inp_invokeobj) = 0 THEN
      v_sqlerrm := '拒绝访问：调用方-' || v_inp_invokeobj || ' 被调用方-' ||
                   v_selfdescription;
      RAISE priv_exception;
    END IF;
  
    --构建 sql
    v_sql := 'UPDATE scmdata.t_qa_sizecheckchart scc
   SET is_deprecation = 1
 WHERE goo_id = :v_inp_gooid
   AND company_id = :v_inp_compid
   AND not exists (SELECT 1 FROM scmdata.t_size_chart
                    WHERE goo_id = scc.goo_id
                      AND position = scc.position
                      AND company_id = scc.company_id)';
  
    EXECUTE IMMEDIATE v_sql
      USING v_inp_gooid, v_inp_compid;
  
    v_sql := 'UPDATE scmdata.t_qa_sizecheckchart scc
   SET is_deprecation = 0
 WHERE goo_id = :v_inp_gooid
   AND company_id = :v_inp_compid
   AND exists (SELECT 1 FROM scmdata.t_size_chart
                WHERE goo_id = scc.goo_id
                  AND position = scc.position
                  AND company_id = scc.company_id)';
  
    EXECUTE IMMEDIATE v_sql
      USING v_inp_gooid, v_inp_compid;
  EXCEPTION
    WHEN priv_exception THEN
      --抛出报错
      raise_application_error(-20002, v_sqlerrm);
    WHEN OTHERS THEN
      --错误信息赋值
      v_sqlerrm := substr(dbms_utility.format_error_stack, 1, 1024);
      v_errinfo := 'Error Object:' || v_selfdescription || chr(10) ||
                   'Error Info: ' || v_sqlerrm || chr(10) || 'Execute_sql:' ||
                   v_sql || chr(10) || 'Params: ' || chr(10) ||
                   'v_inp_gooid: ' || v_inp_gooid || chr(10) ||
                   'v_inp_compid: ' || v_inp_compid;
    
      --新增进入错误信息表
      scmdata.pkg_qa_ee.p_ins_errrecord_at(v_inp_errprogram     => v_selfdescription,
                                           v_inp_causeerruserid => v_inp_curuserid,
                                           v_inp_erroccurtime   => SYSDATE,
                                           v_inp_errinfo        => v_errinfo,
                                           v_inp_compid         => v_inp_compid);
    
      --抛出报错
      raise_application_error(-20002, v_sqlerrm);
  END p_sizechart_updqasccisdeprecationastrue;

  /*=============================================================================
  
     包：
       pkg_qa_ld(qa逻辑细节包)
  
     函数名:
       qa质检报告查货员更新
  
     入参:
       v_inp_qarepid    :  qa质检报告id
       v_inp_compid     :  企业id
       v_inp_checkers   :  拿货员id
       v_inp_curuserid  :  当前操作人id
       v_inp_invokeobj  :  调用对象id
  
     版本:
       2023-01-09_zc314 : qa质检报告查货员更新
  
  ==============================================================================*/
  PROCEDURE p_goodtake_updqarepcheckers(v_inp_qarepid   IN VARCHAR2,
                                        v_inp_compid    IN VARCHAR2,
                                        v_inp_checkers  IN VARCHAR2,
                                        v_inp_curuserid IN VARCHAR2,
                                        v_inp_invokeobj IN VARCHAR2) IS
    priv_exception EXCEPTION;
    v_sql             CLOB;
    v_errinfo         CLOB;
    v_sqlerrm         VARCHAR2(512);
    v_allowinvokeobj  CLOB := 'scmdata.pkg_qa_lc.p_takegood_dispatchgoodtaker;scmdata.pkg_qa_lc.p_takegood_takegood';
    v_selfdescription VARCHAR2(1024) := 'scmdata.pkg_qa_ld.p_goodtake_updqarepcheckers';
  BEGIN
    --访问控制
    IF instr(v_allowinvokeobj, v_inp_invokeobj) = 0 THEN
      v_sqlerrm := '拒绝访问：调用方-' || v_inp_invokeobj || ' 被调用方-' ||
                   v_selfdescription;
      RAISE priv_exception;
    END IF;
  
    --构建 sql
    v_sql := 'UPDATE scmdata.t_qa_report
   SET checkers = :v_inp_checkers,
       update_id = :v_inp_curuserid,
       update_time = SYSDATE
 WHERE qa_report_id = :v_inp_qarepid
   AND company_id = :v_inp_compid ';
  
    --执行 sql
    EXECUTE IMMEDIATE v_sql
      USING v_inp_checkers, v_inp_curuserid, v_inp_qarepid, v_inp_compid;
  
  EXCEPTION
    WHEN priv_exception THEN
      --抛出报错
      raise_application_error(-20002, v_sqlerrm);
    WHEN OTHERS THEN
      --错误信息赋值
      v_sqlerrm := substr(dbms_utility.format_error_stack, 1, 1024);
      v_errinfo := 'Error Object:' || v_selfdescription || chr(10) ||
                   'Error Info: ' || v_sqlerrm || chr(10) || 'Execute_sql:' ||
                   v_sql || chr(10) || 'Params: ' || chr(10) ||
                   'v_inp_checkers: ' || v_inp_checkers || chr(10) ||
                   'v_inp_curuserid: ' || v_inp_curuserid || chr(10) ||
                   'v_inp_qarepid: ' || v_inp_qarepid || chr(10) ||
                   'v_inp_compid: ' || v_inp_compid;
    
      --新增进入错误信息表
      scmdata.pkg_qa_ee.p_ins_errrecord_at(v_inp_errprogram     => v_selfdescription,
                                           v_inp_causeerruserid => v_inp_curuserid,
                                           v_inp_erroccurtime   => SYSDATE,
                                           v_inp_errinfo        => v_errinfo,
                                           v_inp_compid         => v_inp_compid);
    
      --抛出报错
      raise_application_error(-20002, v_sqlerrm);
  END p_goodtake_updqarepcheckers;

  /*=============================================================================
  
     包：
       pkg_qa_ld(qa逻辑细节包)
  
     函数名:
       qa预回传表质检类型刷新
  
     入参:
       v_inp_asnid      :  asn单号
       v_inp_compid     :  企业id
       v_inp_transtype  :  传输类型
       v_inp_curuserid  :  操作人Id
       v_inp_invokeobj  :  调用对象
  
     版本:
       2023-02-09_zc314 : qa预回传表质检类型刷新
  
  ==============================================================================*/
  PROCEDURE p_maintenance_slabackrefreshtranstype(v_inp_asnid     IN VARCHAR2,
                                                  v_inp_compid    IN VARCHAR2,
                                                  v_inp_transtype IN VARCHAR2,
                                                  v_inp_curuserid IN VARCHAR2,
                                                  v_inp_invokeobj IN VARCHAR2) IS
    priv_exception EXCEPTION;
    v_sql             CLOB;
    v_errinfo         CLOB;
    v_sqlerrm         VARCHAR2(512);
    v_allowinvokeobj  CLOB := 'scmdata.pkg_qa_lc.p_maintenance_unqualprocessingsla';
    v_selfdescription VARCHAR2(1024) := 'scmdata.pkg_qa_ld.p_maintenance_slabackrefreshtranstype';
  BEGIN
    --访问控制
    IF instr(v_allowinvokeobj, v_inp_invokeobj) = 0 THEN
      v_sqlerrm := '拒绝访问：调用方-' || v_inp_invokeobj || ' 被调用方-' ||
                   v_selfdescription;
      RAISE priv_exception;
    END IF;
  
    --当传输类型为：Asn
    IF v_inp_transtype = 'ASN' THEN
      --构建执行 Sql
      v_sql := 'UPDATE scmdata.t_qa_pretranstowms
         SET trans_type = :v_inp_transtype
       WHERE asn_id = :v_inp_asnid
         AND company_id = :v_inp_compid';
    
      --执行 Sql
      EXECUTE IMMEDIATE v_sql
        USING v_inp_transtype, v_inp_asnid, v_inp_compid;
    END IF;
  EXCEPTION
    WHEN priv_exception THEN
      --抛出报错
      raise_application_error(-20002, v_sqlerrm);
    WHEN OTHERS THEN
      --错误信息赋值
      v_sqlerrm := substr(dbms_utility.format_error_stack, 1, 1024);
      v_errinfo := 'Error Object:' || v_selfdescription || chr(10) ||
                   'Error Info: ' || v_sqlerrm || chr(10) || 'Execute_sql:' ||
                   v_sql || chr(10) || 'Params: ' || chr(10) ||
                   'v_inp_transtype: ' || v_inp_transtype || chr(10) ||
                   'v_inp_asnid: ' || v_inp_asnid || chr(10) ||
                   'v_inp_compid: ' || v_inp_compid;
    
      --新增进入错误信息表
      scmdata.pkg_qa_ee.p_ins_errrecord_at(v_inp_errprogram     => v_selfdescription,
                                           v_inp_causeerruserid => v_inp_curuserid,
                                           v_inp_erroccurtime   => SYSDATE,
                                           v_inp_errinfo        => v_errinfo,
                                           v_inp_compid         => v_inp_compid);
    
      --抛出报错
      raise_application_error(-20002, v_sqlerrm);
  END p_maintenance_slabackrefreshtranstype;

  /*=============================================================================
  
     包：
       pkg_qa_ld(qa逻辑细节包)
  
     过程名:
       Qa生成返工报告清空次品
  
     入参:
       v_inp_asnid      :  asn单号
       v_inp_compid     :  企业id
       v_inp_gooid      :  商品档案编号
       v_inp_barcode    :  条码
       v_inp_curuserid  :  操作人Id
       v_inp_invokeobj  :  调用对象
  
     版本:
       2023-02-15_zc314 : Qa生成返工报告清空次品
  
  ==============================================================================*/
  PROCEDURE p_rcrepgen_clearpackssubsamount(v_inp_asnid     IN VARCHAR2,
                                            v_inp_compid    IN VARCHAR2,
                                            v_inp_gooid     IN VARCHAR2,
                                            v_inp_barcode   IN VARCHAR2,
                                            v_inp_curuserid IN VARCHAR2,
                                            v_inp_invokeobj IN VARCHAR2) IS
    priv_exception EXCEPTION;
    v_sql             CLOB;
    v_errinfo         CLOB;
    v_sqlerrm         VARCHAR2(512);
    v_allowinvokeobj  CLOB := 'scmdata.pkg_qa_lc.p_gen_rcqarep';
    v_selfdescription VARCHAR2(1024) := 'scmdata.pkg_qa_ld.p_rcrepgen_clearpackssubsamount';
  BEGIN
    --访问控制
    IF instr(v_allowinvokeobj, v_inp_invokeobj) = 0 THEN
      v_sqlerrm := '拒绝访问：调用方-' || v_inp_invokeobj || ' 被调用方-' ||
                   v_selfdescription;
      RAISE priv_exception;
    END IF;
  
    --执行sql赋值
    v_sql := 'UPDATE scmdata.t_asnorderpacks
         SET subs_amount = 0
       WHERE asn_id = :v_inp_asnid
         AND company_id = :v_inp_compid
         and goo_id = :v_inp_gooid
         and nvl(barcode, '' '') = nvl(:v_inp_barcode, '' '')';
  
    --执行sql
    EXECUTE IMMEDIATE v_sql
      USING v_inp_asnid, v_inp_compid, v_inp_gooid, v_inp_barcode;
  EXCEPTION
    WHEN priv_exception THEN
      --抛出报错
      raise_application_error(-20002, v_sqlerrm);
    WHEN OTHERS THEN
      --错误信息赋值
      v_sqlerrm := substr(dbms_utility.format_error_stack, 1, 1024);
      v_errinfo := 'Error Object:' || v_selfdescription || chr(10) ||
                   'Error Info: ' || v_sqlerrm || chr(10) || 'Execute_sql:' ||
                   v_sql || chr(10) || 'Params: ' || chr(10) ||
                   'v_inp_asnid: ' || v_inp_asnid || chr(10) ||
                   'v_inp_compid: ' || v_inp_compid || chr(10) ||
                   'v_inp_gooid: ' || v_inp_gooid || chr(10) ||
                   'v_inp_barcode: ' || v_inp_barcode;
    
      --新增进入错误信息表
      scmdata.pkg_qa_ee.p_ins_errrecord_at(v_inp_errprogram     => v_selfdescription,
                                           v_inp_causeerruserid => v_inp_curuserid,
                                           v_inp_erroccurtime   => SYSDATE,
                                           v_inp_errinfo        => v_errinfo,
                                           v_inp_compid         => v_inp_compid);
    
      --抛出报错
      raise_application_error(-20002, v_sqlerrm);
  END p_rcrepgen_clearpackssubsamount;

END pkg_qa_ld;
/

