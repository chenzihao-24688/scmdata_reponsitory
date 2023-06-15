CREATE OR REPLACE PACKAGE SCMDATA.pkg_qa_lc IS

  /*=============================================================================
  
     包：
       pkg_qa_lc(QA逻辑链包)
  
     过程名:
       构建仓库，分部权限条件 Sql
  
     入参:
       v_inp_catealias  :  分部别名
       v_inp_shoalias   :  仓库别名
       v_inp_isadmin    :  是否管理员
       v_inp_privstr    :  权限字段
  
     版本:
       2022-10-14_ZC314 : 构建仓库，分部权限条件 Sql
       2022-10-27_ZC314 : 增加分部别名，仓库别名以适应更多场景
  
  ==============================================================================*/
  FUNCTION f_get_shoandcatecondsql(v_inp_catealias IN VARCHAR2,
                                   v_inp_shoalias  IN VARCHAR2,
                                   v_inp_isadmin   IN VARCHAR2,
                                   v_inp_privstr   IN VARCHAR2) RETURN CLOB;

  /*=============================================================================
  
     包：
       pkg_qa_lc(QA逻辑链包)
  
     过程名:
       Asn免检
  
     入参:
       v_inp_asnid        : AsnId
       v_inp_compid       : 企业Id
       v_inp_aeresoncode  : 免检原因编码
       v_inp_curuserid    : 当前操作人Id
  
     版本:
       2022-10-09_ZC314 : Asn免检
       2022-10-13_zc314 : pkg_qa_ee异常处理需要记录操作人
  
  ==============================================================================*/
  PROCEDURE p_asnexemption(v_inp_asnid       IN VARCHAR2,
                           v_inp_compid      IN VARCHAR2,
                           v_inp_aeresoncode IN VARCHAR2,
                           v_inp_curuserid   IN VARCHAR2);

  /*=============================================================================
  
     包：
       pkg_qa_lc(QA逻辑链包)
  
     过程名:
       免检生成 Asn 预回传 Wms 表信息
  
     入参:
       v_inp_asnid      : AsnId
       v_inp_compid     : 企业Id
       v_inp_curuserid  : 当前操作人Id
  
     版本:
       2022-10-09_ZC314 : 免检生成 Asn 预回传 Wms 表信息
  
  ==============================================================================*/
  PROCEDURE p_gen_asninfopretranstowms_data_ae(v_inp_asnid     IN VARCHAR2,
                                               v_inp_compid    IN VARCHAR2,
                                               v_inp_curuserid IN VARCHAR2);

  /*=============================================================================
  
     包：
       pkg_qa_lc(QA逻辑链包)
  
     过程名:
       新增/修改 Qa已检列表从表
  
     入参:
       v_inp_asnid       :  AsnId
       v_inp_operuserid  :  当前操作人Id
       v_inp_compid      :  企业Id
  
     版本:
       2022-10-11_ZC314 : 新增/修改 Qa已检列表从表
       2022-10-13_zc314 : pkg_qa_ee异常处理需要记录操作人
  
  ==============================================================================*/
  PROCEDURE p_iu_qaqualedlistsla(v_inp_asnid      IN VARCHAR2,
                                 v_inp_operuserid IN VARCHAR2,
                                 v_inp_compid     IN VARCHAR2);

  /*=============================================================================
  
     包：
       pkg_qa_lc(QA逻辑链包)
  
     过程名:
       新增/修改 Qa已检列表主表
  
     入参:
       v_inp_asnid      : AsnId
       v_inp_operuserid : 当前操作人Id
       v_inp_compid     : 企业Id
  
     版本:
       2022-10-11_ZC314 : 新增/修改 Qa已检列表主表
       2022-10-13_ZC314 : pkg_qa_ee异常处理增加当前操作人
  
  ==============================================================================*/
  PROCEDURE p_iu_qaqualedlistmas(v_inp_asnid      IN VARCHAR2,
                                 v_inp_operuserid IN VARCHAR2,
                                 v_inp_compid     IN VARCHAR2);

  /*=============================================================================
  
     包：
       pkg_qa_lc(QA逻辑链包)
  
     过程名:
       新增/修改 Qa已检列表数据
  
     入参:
       v_inp_asnid      :  AsnId
       v_inp_curuserid  :  当前操作人Id
       v_inp_compid     :  企业Id
  
     版本:
       2022-10-11_ZC314 : Qa已检列表数据
       2022-10-13_zc314 : pkg_qa_ee异常处理需要记录操作人
  
  ==============================================================================*/
  PROCEDURE p_iu_qaqualedlist(v_inp_asnid     IN VARCHAR2,
                              v_inp_curuserid IN VARCHAR2,
                              v_inp_compid    IN VARCHAR2);

  /*=============================================================================
  
     包：
       pkg_qa_lc(QA逻辑链包)
  
     过程名:
       新增/修改 Qa质检报告 Sku维度信息表
  
     入参:
       v_inp_qarepid             :  质检报告Id
       v_inp_compid              :  企业Id
       v_inp_asnid               :  Asn单号
       v_inp_gooid               :  商品档案编号
       v_inp_barcode             :  条码
       v_inp_status              :  状态
       v_inp_skuprocessingresult :  Sku处理结果
       v_inp_skucheckresult      :  Sku质检结果
       v_inp_pcomeamount         :  预计到仓数量
       v_inp_wmsgotamount        :  wms上架数量
       v_inp_qualdecreaseamount  :  质检减数
       v_inp_unqualamount        :  不合格数量
       v_inp_reprocessednumber   :  返工次数
       v_inp_pcomedate           :  预计到仓日期
       v_inp_scantime            :  到仓扫描时间
       v_inp_receivetime         :  收货时间
       v_inp_colorname           :  颜色名称
       v_inp_sizename            :  尺码名称
       v_inp_reviewid            :  审核人Id
       v_inp_reviewtime          :  审核时间
       v_inp_qualfinishtime      :  质检结束时间
       v_inp_operuserid          :  当前操作人Id
  
     版本:
       2022-10-14_zc314 : 新增/修改 Qa质检报告 Sku维度信息表
  
  ==============================================================================*/
  PROCEDURE p_iu_qareportskudim(v_inp_qarepid             IN VARCHAR2,
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
                                v_inp_colorname           IN VARCHAR2,
                                v_inp_sizename            IN VARCHAR2,
                                v_inp_reviewid            IN VARCHAR2,
                                v_inp_reviewtime          IN DATE,
                                v_inp_qualfinishtime      IN DATE,
                                v_inp_operuserid          IN VARCHAR2);

  /*=============================================================================
  
     包：
       pkg_qa_lc(QA逻辑链包)
  
     过程名:
       新增/修改 Qa质检报告关联信息表
  
     入参:
       v_inp_qarepid    :  质检报告Id
       v_inp_compid     :  企业Id
       v_inp_asnid      :  AsnId
       v_inp_gooid      :  商品档案货号
       v_inp_orderid    :  订单号
       v_inp_supcode    :  供应商编码
       v_inp_faccode    :  生产工厂编码
       v_inp_shoid      :  仓库Id
       v_inp_curuserid  :  当前操作人Id
  
     版本:
       2022-10-13_zc314 : 新增/修改 Qa质检报告关联信息表
  
  ==============================================================================*/
  PROCEDURE p_iu_qareportrelainfodim(v_inp_qarepid    IN VARCHAR2,
                                     v_inp_compid     IN VARCHAR2,
                                     v_inp_asnid      IN VARCHAR2,
                                     v_inp_gooid      IN VARCHAR2,
                                     v_inp_orderid    IN VARCHAR2,
                                     v_inp_supcode    IN VARCHAR2,
                                     v_inp_faccode    IN VARCHAR2,
                                     v_inp_shoid      IN VARCHAR2,
                                     v_inp_operuserid IN VARCHAR2);

  /*=============================================================================
  
     包：
       pkg_qa_lc(QA逻辑链包)
  
     过程名:
       新增/修改 Qa质检报告关联信息表
  
     入参:
       v_inp_qarepid                  :  Qa报告Id
       v_inp_compid                   :  企业Id
       v_inp_firstsamplingamount      :  首抽件数
       v_inp_addsamplingamount        :  加抽件数
       v_inp_unqualsamplingamount     :  不合格件数
       v_inp_pcomesumamount           :  预计到仓总数
       v_inp_wmsgotsumamount          :  wms上架总数
       v_inp_qualdecreasesumamount    :  质检件数总数
       v_inp_prereprocessingsumamount :  待返工数量
       v_inp_operuserid               :  操作人Id
  
     版本:
       2022-10-14_zc314 : Qa质检报告关联信息表
  
  ==============================================================================*/
  PROCEDURE p_iu_qareportnumdim(v_inp_qarepid                  IN VARCHAR2,
                                v_inp_compid                   IN VARCHAR2,
                                v_inp_firstsamplingamount      IN NUMBER,
                                v_inp_addsamplingamount        IN NUMBER,
                                v_inp_unqualsamplingamount     IN NUMBER,
                                v_inp_pcomesumamount           IN NUMBER,
                                v_inp_wmsgotsumamount          IN NUMBER,
                                v_inp_qualdecreasesumamount    IN NUMBER,
                                v_inp_prereprocessingsumamount IN NUMBER,
                                v_inp_operuserid               IN VARCHAR2);

  /*=============================================================================
  
     包：
       pkg_qa_lc(QA逻辑链包)
  
     过程名:
       新增/修改 Qa质检报告报告级质检细节表增改
  
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
  
     版本:
       2022-10-14_zc314 : Qa质检报告报告级质检细节表增改
  
  ==============================================================================*/
  PROCEDURE p_iu_qareportcheckdetaildim(v_inp_qarepid           IN VARCHAR2,
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
                                        v_inp_operuserid        IN VARCHAR2);

  /*=============================================================================
  
     包：
       pkg_qa_lc(QA逻辑链包)
  
     过程名:
       校验多选对象合并字符串最大长度，大于4000报错
  
     入参:
       v_inp_clob : 输入值
  
     版本:
       2022-10-12_ZC314 : 校验多选对象合并字符串最大长度，大于4000报错
  
  ==============================================================================*/
  PROCEDURE p_check_multiselectallowmaxobjnum(v_inp_clob IN CLOB);

  /*=============================================================================
  
     包：
       pkg_qa_lc(QA逻辑链包)
  
     过程名:
       校验选中 Asn是否都是同一供应商，同一货号，
       非同一供应商，同一货号报错
  
     入参:
       v_inp_asnids   : 多个Asn_Id，由分号分隔
       v_inp_compid   : 企业Id
  
     版本:
       2022-10-12_ZC314 : 校验选中 Asn是否都是同一供应商，同一货号
                          非同一供应商，同一货号报错
  
  ==============================================================================*/
  PROCEDURE p_check_multiasnhassamesupplierandgoo(v_inp_asnids IN CLOB,
                                                  v_inp_compid IN VARCHAR2);

  /*=============================================================================
  
     包：
       pkg_qa_lc(QA逻辑链包)
  
     过程名:
       新增 Qa质检报告
  
     入参:
       v_inp_asnids     : 多个Asn_Id，由分号分隔
       v_inp_compid     : 企业Id
       v_inp_curuserid  : 当前操作人Id
  
     版本:
       2022-10-12_ZC314 : 新增 Qa质检报告
  
  ==============================================================================*/
  PROCEDURE p_ins_qareportinfo(v_inp_asnids     IN CLOB,
                               v_inp_compid     IN VARCHAR2,
                               v_inp_ispriority IN NUMBER,
                               v_inp_curuserid  IN VARCHAR2);

  /*=============================================================================
  
     包：
       pkg_qa_lc(QA逻辑链包)
  
     函数名:
       校验输入人员是否存在于当前企业Qa组
  
     入参:
       v_inp_userids   :  输入人员Id，多值，用分号分隔
       v_inp_compid    :  企业Id
  
     返回值:
       Clob 类型，错误信息
  
     版本:
       2022-10-19_ZC314 : 校验输入人员是否存在于当前企业Qa组
  
  ==============================================================================*/
  FUNCTION f_check_checkersnotinqagroup(v_inp_checkers IN VARCHAR2,
                                        v_inp_compid   IN VARCHAR2)
    RETURN CLOB;

  /*=============================================================================
  
     包：
       pkg_qa_ld(QA逻辑细节包)
  
     函数名:
       批量录入合格质检报告--值校验
  
     入参:
       v_inp_qarepids         :  质检报告Id
       v_inp_checkresult      :  质检确认结果
       v_inp_pcomeamount      :  预计到仓数量
       v_inp_firstcheckamount :  首抽件数
       v_inp_checkdate        :  查货时间
       v_inp_checkuserids     :  查货员
       v_inp_compid           :  企业Id
  
     版本:
       2022-10-19_ZC314 : 批量录入合格质检报告--值校验
  
  ==============================================================================*/
  FUNCTION f_batchpassqarep_valuecheck(v_inp_qarepid          IN CLOB,
                                       v_inp_checkresult      IN VARCHAR2,
                                       v_inp_pcomeamount      IN NUMBER,
                                       v_inp_firstcheckamount IN NUMBER,
                                       v_inp_checkdate        IN DATE,
                                       v_inp_checkuserids     IN VARCHAR2,
                                       v_inp_compid           IN VARCHAR2)
    RETURN CLOB;

  /*=============================================================================
  
     包：
       pkg_qa_lc(qa逻辑链包)
  
     过程名:
       批量生成合格报告
  
     入参:
       v_inp_qarepids          :  多个质检报告id，由分号分隔
       v_inp_checkresult       :  质检确认结果
       v_inp_firstcheckamount  :  首抽件数
       v_inp_checkdate         :  质检日期
       v_inp_checkuserids      :  质检确认人员
       v_inp_curuserid         :  当前操作人id
       v_inp_compid            :  企业id
  
  
     版本:
       2022-10-19_zc314 : 批量生成合格报告
  
  ==============================================================================*/
  PROCEDURE p_batch_passqarep(v_inp_qarepids         IN CLOB,
                              v_inp_checkresult      IN VARCHAR2,
                              v_inp_firstcheckamount IN NUMBER,
                              v_inp_checkdate        IN DATE,
                              v_inp_checkuserids     IN VARCHAR2,
                              v_inp_curuserid        IN VARCHAR2,
                              v_inp_compid           IN VARCHAR2);

  /*=============================================================================
  
     包：
       pkg_qa_lc(QA逻辑链包)
  
     函数名:
       质检报告更新--值校验
  
     入参:
       v_inp_qarepid               :  质检报告Id
       v_inp_compid                :  企业Id
       v_inp_firstsamplingamount   :  首抽件数
       v_inp_checkers              :  查货员
       v_inp_checkdate             :  质检日期
       v_inp_checkresult           :  质检结果
       v_inp_problemdescription    :  问题描述
       v_inp_reviewcomments        :  审核意见
       v_inp_problemclassification :  问题分类
       v_inp_unqualsamplingamount  :  不合格数
       v_inp_yyresult              :  样衣核对-核对结果
       v_inp_yyuqualsubjects       :  样衣核对-不合格项
       v_inp_mflresult             :  面辅料查验-查验结果
       v_inp_mfluqualsubjects      :  面辅料查验-不合格项
       v_inp_gyresult              :  工艺查验-查验结果
       v_inp_gyuqualsubjects       :  工艺查验-不合格项
       v_inp_bxresult              :  版型查验-查验结果
       v_inp_bxuqualsubjects       :  版型查验-不合格项
       v_inp_scaleamount           :  度尺件数
  
     版本:
       2022-10-20_ZC314 : 质检报告更新--值校验
       2022-10-21_zc314 : 值校验增加条件校验
       2022-10-26_zc314 : 增加Sku质检结果与报告质检结果一致性校验
       2022-12-15_zc314 : 增加“度尺件数”字段
  
  ==============================================================================*/
  FUNCTION f_check_qareportupd(v_inp_qarepid               IN VARCHAR2,
                               v_inp_compid                IN VARCHAR2,
                               v_inp_firstsamplingamount   IN NUMBER,
                               v_inp_addsamplingamount     IN NUMBER,
                               v_inp_checkers              IN VARCHAR2,
                               v_inp_checkdate             IN DATE,
                               v_inp_checkresult           IN VARCHAR2,
                               v_inp_problemdescription    IN VARCHAR2,
                               v_inp_reviewcomments        IN VARCHAR2,
                               v_inp_problemclassification IN VARCHAR2,
                               v_inp_unqualsamplingamount  IN NUMBER,
                               v_inp_yyresult              IN VARCHAR2,
                               v_inp_yyuqualsubjects       IN VARCHAR2,
                               v_inp_mflresult             IN VARCHAR2,
                               v_inp_mfluqualsubjects      IN VARCHAR2,
                               v_inp_gyresult              IN VARCHAR2,
                               v_inp_gyuqualsubjects       IN VARCHAR2,
                               v_inp_bxresult              IN VARCHAR2,
                               v_inp_bxuqualsubjects       IN VARCHAR2,
                               v_inp_scaleamount           IN NUMBER)
    RETURN CLOB;

  /*=============================================================================
  
     包：
       pkg_qa_lc(qa逻辑链包)
  
     过程名:
       Qa质检报告编辑页面--更新质检报告
  
     入参:
       v_inp_qarepid                 :  Qa质检报告Id
       v_inp_compid                  :  企业Id
       v_inp_checkers                :  查货员
       v_inp_checkdate               :  质检日期
       v_inp_checkresult             :  质检结果
       v_inp_problemclassification   :  问题分类
       v_inp_problemdescription      :  问题描述
       v_inp_reviewcomments          :  审核意见
       v_inp_memo                    :  备注
       v_inp_qualattachment          :  质检附件
       v_inp_reviewattachment        :  批复附件
       v_inp_firstsamplingamount     :  首抽件数
       v_inp_addsamplingamount       :  加抽件数
       v_inp_unqualsamplingamount    :  不合格件数
       v_inp_yyresult                :  样衣核对结果
       v_inp_yyuqualsubjects         :  样衣不合格项
       v_inp_mflresult               :  面辅料查验结果
       v_inp_mfluqualsubjects        :  面辅料不合格项
       v_inp_gyresult                :  工艺查验结果
       v_inp_gyuqualsubjects         :  工艺不合格项
       v_inp_bxresult                :  版型查验结果
       v_inp_bxuqualsubjects         :  版型不合格项
       v_inp_curuserid               :  当前操作人Id
  
     版本:
       2022-10-20_zc314 : Qa质检报告编辑页面--更新质检报告
       2022-10-21_zc314 : 值校验增加条件校验
  
  ==============================================================================*/
  PROCEDURE p_upd_qareport(v_inp_qarepid               IN VARCHAR2,
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
                           v_inp_firstsamplingamount   IN NUMBER,
                           v_inp_addsamplingamount     IN NUMBER,
                           v_inp_unqualsamplingamount  IN NUMBER,
                           v_inp_yyresult              IN VARCHAR2,
                           v_inp_yyuqualsubjects       IN VARCHAR2,
                           v_inp_mflresult             IN VARCHAR2,
                           v_inp_mfluqualsubjects      IN VARCHAR2,
                           v_inp_gyresult              IN VARCHAR2,
                           v_inp_gyuqualsubjects       IN VARCHAR2,
                           v_inp_bxresult              IN VARCHAR2,
                           v_inp_bxuqualsubjects       IN VARCHAR2,
                           v_inp_scaleamount           IN NUMBER,
                           v_inp_curuserid             IN VARCHAR2);

  /*=============================================================================
  
     包：
       pkg_qa_lc(qa逻辑链包)
  
     过程名:
       质检减数-更新逻辑
  
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
  
     版本:
       2022-10-24_zc314 : 质检减数-更新逻辑
  
  ==============================================================================*/
  PROCEDURE p_upd_qualdecrerela(v_inp_qarepid         IN VARCHAR2,
                                v_inp_compid          IN VARCHAR2,
                                v_inp_asnid           IN VARCHAR2,
                                v_inp_gooid           IN VARCHAR2,
                                v_inp_barcode         IN VARCHAR2,
                                v_inp_defectiveamount IN NUMBER,
                                v_inp_washlessamount  IN NUMBER,
                                v_inp_otherlessamount IN NUMBER,
                                v_inp_curuserid       IN VARCHAR2);

  /*=============================================================================
  
     包：
       pkg_qa_lc(QA逻辑链包)
  
     函数名:
       质检报告报告级质检结果与不合格明细一致性校验
  
     入参:
       v_inp_qarepid    :  质检报告Id
       v_inp_compid     :  企业Id
       v_inp_curuserid  :  当前操作人Id
  
     版本:
       2022-10-24_ZC314 : 质检报告报告级质检结果与不合格明细一致性校验
  
  ==============================================================================*/
  PROCEDURE p_check_qarepcheckresultconsistent(v_inp_qarepid   IN VARCHAR2,
                                               v_inp_compid    IN VARCHAR2,
                                               v_inp_curuserid IN VARCHAR2);

  /*=============================================================================
  
     包：
       pkg_qa_lc(qa逻辑链包)
  
     过程名:
       Qa质检报告信息校验
  
     入参:
       v_inp_qarepid    :  质检报告Id
       v_inp_compid     :  企业Id
       v_inp_curuserid  :  当前操作人Id
  
     版本:
       2022-10-26_zc314 : Qa质检报告信息校验
  
  ==============================================================================*/
  PROCEDURE p_check_qareportinfo(v_inp_qarepid   IN VARCHAR2,
                                 v_inp_compid    IN VARCHAR2,
                                 v_inp_curuserid IN VARCHAR2);

  /*=============================================================================
  
     包：
       pkg_qa_lc(qa逻辑链包)
  
     过程名:
       qa质检报告编辑页面--质检报告提交
  
     入参:
       v_inp_qarepid    :  质检报告Id
       v_inp_compid     :  企业Id
       v_inp_curuserid  :  当前操作人Id
  
     版本:
       2022-10-24_zc314 : qa质检报告编辑页面--质检报告提交
       2022-10-26_zc314 : 因Qa质检报告信息校验提取为存储过程修改
  
  ==============================================================================*/
  PROCEDURE p_commit_qarep(v_inp_qarepid   IN VARCHAR2,
                           v_inp_compid    IN VARCHAR2,
                           v_inp_curuserid IN VARCHAR2);

  /*=============================================================================
  
     包：
       pkg_qa_lc(QA逻辑链包)
  
     函数名:
       Qa质检报告维护不合格处理明细
  
     入参:
       v_inp_qarepid         :  质检报告Id
       v_inp_compid          :  企业Id
       v_inp_asnid           :  Asn单号
       v_inp_gooid           :  商品档案货号
       v_inp_barcode         :  条码
       v_inp_skucheckresult  :  Sku质检结果
       v_inp_curuserid       :  当前操作人Id
  
     版本:
       2022-10-25_ZC314 : Qa质检报告维护不合格处理明细
  
  ==============================================================================*/
  PROCEDURE p_change_qarepunqualdetail(v_inp_qarepid        IN VARCHAR2,
                                       v_inp_compid         IN VARCHAR2,
                                       v_inp_asnid          IN VARCHAR2,
                                       v_inp_gooid          IN VARCHAR2,
                                       v_inp_barcode        IN VARCHAR2,
                                       v_inp_skucheckresult IN VARCHAR2,
                                       v_inp_curuserid      IN VARCHAR2);

  /*=============================================================================
  
     包：
       pkg_qa_lc(qa逻辑链包)
  
     过程名:
       待审核报告--质检结果审核
  
     入参:
       v_inp_qarepid    :  质检报告Id
       v_inp_compid     :  企业Id
       v_inp_curuserid  :  当前操作人Id
  
     版本:
       2022-10-26_zc314 : 待审核报告--质检结果审核
  
  ==============================================================================*/
  PROCEDURE p_review_qareport(v_inp_qarepid   IN VARCHAR2,
                              v_inp_compid    IN VARCHAR2,
                              v_inp_curuserid IN VARCHAR2);

  /*=============================================================================
  
     包：
       pkg_qa_ld(qa逻辑细节包)
  
     函数名:
       报告内已结束Sku新增进入预回传表
  
     入参:
       v_inp_qarepid           :  Qa质检报告Id
       v_inp_compid            :  企业Id
       v_inp_curuserid         :  操作人Id
  
     版本:
       2022-10-31_zc314 : 报告内已结束Sku新增进入预回传表
  
  ==============================================================================*/
  PROCEDURE p_ins_qarepafinfointopretrans(v_inp_qarepid   IN VARCHAR2,
                                          v_inp_compid    IN VARCHAR2,
                                          v_inp_curuserid IN VARCHAR2);

  /*=============================================================================
  
     包：
       pkg_qa_lc(QA逻辑链包)
  
     函数名:
       维护不合格处理校验
  
     入参:
       v_inp_qarepid        :  质检报告Id
       v_inp_compid         :  企业Id
       v_inp_processtype    :  处理类型
       v_inp_processresult  :  处理结果
  
     版本:
       2022-10-26_ZC314 : 维护不合格处理校验
  
  ==============================================================================*/
  PROCEDURE p_check_mantenanceunqualexecute(v_inp_qarepid       IN VARCHAR2,
                                            v_inp_compid        IN VARCHAR2,
                                            v_inp_processtype   IN VARCHAR2,
                                            v_inp_processresult IN VARCHAR2);

  /*=============================================================================
  
     包：
       pkg_qa_lc(qa逻辑链包)
  
     过程名:
       待审核报告--主表维护不合格处理
  
     入参:
       v_inp_qarepid        :  质检报告Id
       v_inp_compid         :  企业Id
       v_inp_processtype    :  处理方式
       v_inp_processresult  :  处理结果
       v_inp_curuserid      :  当前操作人Id
  
     版本:
       2022-10-26_zc314 : 待审核报告--主表维护不合格处理
  
  ==============================================================================*/
  PROCEDURE p_maintenance_unqualprocessingmas(v_inp_qarepid       IN VARCHAR2,
                                              v_inp_compid        IN VARCHAR2,
                                              v_inp_processtype   IN VARCHAR2,
                                              v_inp_processresult IN VARCHAR2,
                                              v_inp_curuserid     IN VARCHAR2);

  /*=============================================================================
  
     包：
       pkg_qa_lc(qa逻辑链包)
  
     过程名:
       待审核报告--从表维护不合格处理
  
     入参:
       v_inp_qarepid           :  质检报告Id
       v_inp_compid            :  企业Id
       v_inp_asnid             :  Asn单号
       v_inp_gooid             :  商品档案编号
       v_inp_barcode           :  条码
       v_inp_processingresult  :  处理结果
       v_inp_datasource        :  数据来源
       v_inp_curuserid         :  当前操作人Id
  
     版本:
       2022-10-27_zc314 : 待审核报告--从表维护不合格处理
       2023-02-09_zc314 : 增加数据来源字段
  
  ==============================================================================*/
  PROCEDURE p_maintenance_unqualprocessingsla(v_inp_qarepid          IN VARCHAR2,
                                              v_inp_compid           IN VARCHAR2,
                                              v_inp_asnid            IN VARCHAR2,
                                              v_inp_gooid            IN VARCHAR2,
                                              v_inp_barcode          IN VARCHAR2,
                                              v_inp_processingresult IN VARCHAR2,
                                              v_inp_datasource       IN VARCHAR2,
                                              v_inp_curuserid        IN VARCHAR2);

  /*=============================================================================
  
     包：
       pkg_qa_lc(QA逻辑链包)
  
     过程名:
       生成 Qa返工质检报告校验
  
     入参:
       v_inp_qarepids   :  多个质检报告Id，由分号分隔
       v_inp_compid     :  企业Id
       v_inp_curuserid  :  当前操作人Id
  
     版本:
       2022-10-28_ZC314 : 生成 Qa返工质检报告校验
  
  ==============================================================================*/
  PROCEDURE p_check_genrcqarep(v_inp_qarepids IN VARCHAR2,
                               v_inp_compid   IN VARCHAR2);

  /*=============================================================================
  
     包：
       pkg_qa_lc(QA逻辑链包)
  
     过程名:
       生成 Qa返工质检报告
  
     入参:
       v_inp_qarepids   :  多个质检报告Id，由分号分隔
       v_inp_compid     :  企业Id
       v_inp_curuserid  :  当前操作人Id
  
     需求:
       1. 存在需要返工的数据才可操作[新增返工质检报告]，可通过“待返工SKU个数＞0”判断为存在需要返工的数据；
       2. 勾选多条待返工的数据，操作新增同一个返工质检报告时，勾选的数据“货号+供应商”需一致，否则操作失败；
       3. 操作[新增返工质检报告]成功，则当前页面更新“待返工SKU个数”字段，同时在【待检任务】页面生成“质检类型=返工抽查”的报告；
  
     版本:
       2022-10-28_ZC314 : 生成 Qa返工质检报告
  
  ==============================================================================*/
  PROCEDURE p_gen_rcqarep(v_inp_qarepids  IN VARCHAR2,
                          v_inp_compid    IN VARCHAR2,
                          v_inp_curuserid IN VARCHAR2);

  /*=============================================================================
  
     包：
       pkg_qa_lc(QA逻辑链包)
  
     函数名:
       待检任务-删除，删除返工质检报告，根据报告内 Sku更新
       其对应最新质检报告待返工 Sku个数
  
     入参:
       v_inp_qarepid    :  质检报告Id
       v_inp_compid     :  企业Id
       v_inp_curuserid  :  当前操作人Id
  
     版本:
       2022-11-01_ZC314 : 待检任务-删除，删除返工质检报告，根据报告内 Sku更新
                          其对应最新质检报告待返工 Sku个数
  
  ==============================================================================*/
  PROCEDURE p_upd_qareportrepreprocessnum(v_inp_qarepid   IN VARCHAR2,
                                          v_inp_compid    IN VARCHAR2,
                                          v_inp_curuserid IN VARCHAR2);

  /*=============================================================================
  
     包：
       pkg_qa_lc(QA逻辑链包)
  
     函数名:
       质检报告报告级质检结果与不合格明细一致性校验
  
     入参:
       v_inp_qarepid    :  质检报告Id
       v_inp_compid     :  企业Id
       v_inp_curuserid  :  当前操作人Id
  
     版本:
       2022-10-24_ZC314 : 质检报告报告级质检结果与不合格明细一致性校验
  
  ==============================================================================*/
  PROCEDURE p_del_pcqareport(v_inp_qarepid   IN VARCHAR2,
                             v_inp_compid    IN VARCHAR2,
                             v_inp_curuserid IN VARCHAR2);

  /*=============================================================================
  
     包：
       pkg_qa_ld(QA逻辑细节包)
  
     过程名:
       Qa消息配置新增/修改
  
     入参:
       v_inp_configcode  :  消息配置编码
       v_inp_configname  :  消息配置名称
       v_inp_keyurl      :  消息Key（url）
       v_inp_curuserid   :  当前操作人Id
       v_inp_compid      :  企业Id
  
     版本:
       2022-12-08_ZC314 : Qa消息配置新增/修改
  
  ==============================================================================*/
  PROCEDURE p_msg_insorupdqamsgconfig(v_inp_configcode IN VARCHAR2,
                                      v_inp_configname IN VARCHAR2,
                                      v_inp_keyurl     IN VARCHAR2,
                                      v_inp_curuserid  IN VARCHAR2,
                                      v_inp_compid     IN VARCHAR2);

  /*=============================================================================
  
     包：
       pkg_qa_ld(QA逻辑细节包)
  
     过程名:
       Qa消息新增/修改
  
     入参:
       v_inp_configcode  :  Qa消息配置编码
       v_inp_unqinfo     :  Qa消息表唯一信息
       v_inp_msgstatus   :  消息状态：R-准备 E-错误 S-成功
       v_inp_msgtype     :  消息类型
       v_inp_msginfo     :  消息内容
       v_inp_curuserid   :  当前操作人Id
       v_inp_compid      :  企业Id
  
     版本:
       2022-12-08_ZC314 : Qa消息新增/修改
  
  ==============================================================================*/
  PROCEDURE p_msg_insorupdqamsginfo(v_inp_configcode IN VARCHAR2,
                                    v_inp_unqinfo    IN VARCHAR2,
                                    v_inp_msgstatus  IN VARCHAR2,
                                    v_inp_msgtype    IN VARCHAR2,
                                    v_inp_msginfo    IN VARCHAR2,
                                    v_inp_curuserid  IN VARCHAR2,
                                    v_inp_compid     IN VARCHAR2);

  /*=============================================================================
  
     包：
       pkg_qa_lc(QA逻辑链包)
  
     函数名:
       生成物流部提醒消息
  
     入参:
       v_inp_qarepid    :  质检报告Id
       v_inp_compid     :  企业Id
       v_inp_curuserid  :  当前操作人Id
  
     返回值:
       Varchar 类型，消息内容
  
     版本:
       2022-12-08_ZC314 : 生成物流部提醒消息
  
  ==============================================================================*/
  FUNCTION f_msg_genlogisticsmsgbyqarep(v_inp_qarepid   IN VARCHAR2,
                                        v_inp_compid    IN VARCHAR2,
                                        v_inp_curuserid IN VARCHAR2)
    RETURN VARCHAR2;

  /*=============================================================================
  
     包：
       pkg_qa_lc(QA逻辑链包)
  
     过程名:
       物流消息进入Qa信息表
  
     入参:
       v_inp_qarepid    :  质检报告Id
       v_inp_compid     :  企业Id
       v_inp_curuserid  :  当前操作人Id
  
     版本:
       2022-12-09_ZC314 : 物流消息进入Qa信息表
  
  ==============================================================================*/
  PROCEDURE p_msg_putlogisticsmsginqamsginfo(v_inp_qarepid   IN VARCHAR2,
                                             v_inp_compid    IN VARCHAR2,
                                             v_inp_curuserid IN VARCHAR2);

  /*=============================================================================
  
     包：
       pkg_qa_lc(QA逻辑链包)
  
     过程名:
       生成质检不合格提醒消息
  
     入参:
       v_inp_qarepid    :  质检报告Id
       v_inp_compid     :  企业Id
       v_inp_curuserid  :  当前操作人Id
  
     返回值:
       Varchar 类型，消息内容
  
     版本:
       2022-12-12_ZC314 : 生成质检不合格提醒消息
  
  ==============================================================================*/
  FUNCTION f_msg_genunqualmsgbyqarep(v_inp_qarepid   IN VARCHAR2,
                                     v_inp_compid    IN VARCHAR2,
                                     v_inp_curuserid IN VARCHAR2)
    RETURN VARCHAR2;

  /*=============================================================================
  
     包：
       pkg_qa_lc(QA逻辑链包)
  
     过程名:
       不合格信息进入Qa信息表
  
     入参:
       v_inp_qarepid    :  质检报告Id
       v_inp_compid     :  企业Id
       v_inp_curuserid  :  当前操作人Id
  
     版本:
       2022-12-12_ZC314 : 物流消息进入Qa信息表
  
  ==============================================================================*/
  PROCEDURE p_msg_putgenunqualmsgintoinqamsginfo(v_inp_qarepid   IN VARCHAR2,
                                                 v_inp_compid    IN VARCHAR2,
                                                 v_inp_curuserid IN VARCHAR2);

  /*=============================================================================
  
     包：
       pkg_qa_lc(QA逻辑链包)
  
     过程名:
       生成已检消息
  
     入参:
       v_inp_qarepid    :  质检报告Id
       v_inp_compid     :  企业Id
       v_inp_curuserid  :  当前操作人Id
  
     返回值:
       Varchar 类型，消息内容
  
     版本:
       2022-12-13_ZC314 : 生成已检消息
  
  ==============================================================================*/
  FUNCTION f_msg_genqualedmsgbyqarep(v_inp_qarepid   IN VARCHAR2,
                                     v_inp_compid    IN VARCHAR2,
                                     v_inp_curuserid IN VARCHAR2) RETURN CLOB;

  /*=============================================================================
  
     包：
       pkg_qa_lc(QA逻辑链包)
  
     过程名:
       已检消息进入Qa消息表
  
     入参:
       v_inp_qarepid    :  质检报告Id
       v_inp_compid     :  企业Id
       v_inp_curuserid  :  当前操作人Id
  
     版本:
       2022-12-13_ZC314 : 已检消息进入Qa消息表
  
  ==============================================================================*/
  PROCEDURE p_msg_putqualedmsgintoinqamsginfo(v_inp_qarepid   IN VARCHAR2,
                                              v_inp_compid    IN VARCHAR2,
                                              v_inp_curuserid IN VARCHAR2);

  /*=============================================================================
  
     包：
       pkg_qa_lc(QA逻辑链包)
  
     过程名:
       获取最早一条未发出的Qa消息（Qa消息发送器内部逻辑已合并进入）
  
     入参:
       v_inp_msglistener  :  消息监听器 element_id
       v_inp_msgsender    :  消息发送器 element_id
       v_inp_compid       :  企业Id
  
     版本:
       2022-12-09_ZC314 : 获取最早一条未发出的Qa消息
                          （Qa消息发送器内部逻辑已合并进入）
  
  ==============================================================================*/
  FUNCTION f_msg_getearliestqamsg(v_inp_msglistener IN VARCHAR2,
                                  v_inp_msgsender   IN VARCHAR2,
                                  v_inp_compid      IN VARCHAR2) RETURN CLOB;

  /*=============================================================================
  
     包：
       pkg_qa_lc(QA逻辑链包)
  
     过程名:
       Qa消息监听器逻辑
  
     入参:
       v_inp_msglistener  :  消息监听器 element_id
       v_inp_msgsender    :  消息发送器 element_id
       v_inp_second       :  秒
       v_inp_compid       :  企业Id
  
     版本:
       2022-12-09_ZC314 : Qa消息监听器逻辑
  
  ==============================================================================*/
  PROCEDURE p_msg_listenerlogic(v_inp_msglistener IN VARCHAR2,
                                v_inp_msgsender   IN VARCHAR2,
                                v_inp_second      IN NUMBER,
                                v_inp_compid      IN VARCHAR2);

  /*=============================================================================
  
     包：
       pkg_qa_lc(qa逻辑链包)
  
     函数名:
       Qa尺寸核对表新增/修改
  
     入参:
       v_inp_qarepid    :  Qa质检报告Id
       v_inp_position   :  部位
       v_inp_compid     :  企业Id
       v_inp_gooid      :  商品档案货号
       v_inp_barcode    :  条码
       v_inp_seqno      :  序号
       v_inp_actualsize :  实际尺码
       v_inp_curuserid  :  当前操作人Id
  
     版本:
       2022-12-14_zc314 : Qa尺寸核对表新增/修改
       2022-12-15_zc314 : 维度调整，增加尺寸表Id维度
       2023-01-04_zc314 : 维度调整，尺寸表Id变更为部位
  
  ==============================================================================*/
  PROCEDURE p_sizechart_insorupdqasizecheckchart(v_inp_qarepid    IN VARCHAR2,
                                                 v_inp_position   IN VARCHAR2,
                                                 v_inp_compid     IN VARCHAR2,
                                                 v_inp_gooid      IN VARCHAR2,
                                                 v_inp_barcode    IN VARCHAR2,
                                                 v_inp_seqno      IN NUMBER,
                                                 v_inp_actualsize IN NUMBER,
                                                 v_inp_curuserid  IN VARCHAR2);

  /*=============================================================================
  
     包：
       pkg_qa_lc(qa逻辑链包)
  
     函数名:
       根据Qa质检报告生成Qa尺寸核对表
  
     入参:
       v_inp_qarepid     :  Qa质检报告Id
       v_inp_compid      :  企业Id
       v_inp_gooid       :  商品档案货号
       v_inp_barcode     :  条码
       v_inp_seqno       :  序号
       v_inp_curuserid   :  当前操作人Id
  
     版本:
       2022-12-15_zc314 : 根据Qa质检报告生成Qa尺寸核对表
       2023-01-04_zc314 : 维度调整，尺寸表Id变更为部位
  
  ==============================================================================*/
  PROCEDURE p_sizechart_genqasizecheckchartbyqarep(v_inp_qarepid   IN VARCHAR2,
                                                   v_inp_compid    IN VARCHAR2,
                                                   v_inp_gooid     IN VARCHAR2,
                                                   v_inp_barcode   IN VARCHAR2,
                                                   v_inp_seqno     IN VARCHAR2,
                                                   v_inp_curuserid IN VARCHAR2);

  /*=============================================================================
  
     包：
       pkg_qa_lc(qa逻辑链包)
  
     函数名:
       尺寸表新增 Qa尺寸表新增数据
  
     入参:
       v_inp_gooid      :  商品档案编号
       v_inp_compid     :  企业Id
       v_inp_curuserid  :  当前操作人Id
  
     版本:
       2023-01-04_zc314 : 尺寸表新增 Qa尺寸表新增数据
  
  ==============================================================================*/
  PROCEDURE p_sizechart_genqasizecheckchartkleakdatabysizechartins(v_inp_gooid     IN VARCHAR2,
                                                                   v_inp_compid    IN VARCHAR2,
                                                                   v_inp_curuserid IN VARCHAR2);

  /*=============================================================================
  
     包：
       pkg_qa_lc(qa逻辑链包)
  
     过程名:
       尺寸表删除 Qa尺寸表作废数据
  
     入参:
       v_inp_gooid   :  商品档案编号
       v_inp_compid  :  企业Id
  
     版本:
       2023-01-04_zc314 : 尺寸表删除 Qa尺寸表作废数据
  
  ==============================================================================*/
  PROCEDURE p_sizechart_updqasizecheckchartbysizechartdel(v_inp_gooid     IN VARCHAR2,
                                                          v_inp_compid    IN VARCHAR2,
                                                          v_inp_curuserid IN VARCHAR2);

  /*=============================================================================
  
     包：
       pkg_qa_lc(qa逻辑细节包)
  
     过程名:
       拿货action
  
     入参:
       v_inp_qarepid   :  Qa质检报告Id
       v_inp_compid    :  企业Id
       v_inp_cuserid   :  当前操作人Id
  
     版本:
       2023-01-09_zc314  :  拿货action
  
  ==============================================================================*/
  PROCEDURE p_takegood_takegood(v_inp_qarepid IN VARCHAR2,
                                v_inp_compid  IN VARCHAR2,
                                v_inp_cuserid IN VARCHAR2);

END pkg_qa_lc;
/

CREATE OR REPLACE PACKAGE BODY SCMDATA.pkg_qa_lc IS

  /*=============================================================================
  
     包：
       pkg_qa_lc(QA逻辑链包)
  
     过程名:
       构建仓库，分部权限条件 Sql
  
     入参:
       v_inp_catealias  :  分部别名
       v_inp_shoalias   :  仓库别名
       v_inp_isadmin    :  是否管理员
       v_inp_privstr    :  权限字段
  
     版本:
       2022-10-14_ZC314 : 构建仓库，分部权限条件 Sql
       2022-10-27_ZC314 : 增加分部别名，仓库别名以适应更多场景
  
  ==============================================================================*/
  FUNCTION f_get_shoandcatecondsql(v_inp_catealias IN VARCHAR2,
                                   v_inp_shoalias  IN VARCHAR2,
                                   v_inp_isadmin   IN VARCHAR2,
                                   v_inp_privstr   IN VARCHAR2) RETURN CLOB IS
    v_shoresult   VARCHAR2(32);
    v_cateresult  VARCHAR2(32);
    v_isadmincond VARCHAR2(64);
    v_shocond     VARCHAR2(256);
    v_catecond    VARCHAR2(256);
    v_cond        VARCHAR2(512);
  BEGIN
    --仓库权限
    v_shoresult := scmdata.pkg_data_privs.parse_json(p_jsonstr => v_inp_privstr,
                                                     p_key     => 'COL_11');
    --分部权限
    v_cateresult := scmdata.pkg_data_privs.parse_json(p_jsonstr => v_inp_privstr,
                                                      p_key     => 'COL_2');
  
    --【是否管理员】Sql构建
    v_isadmincond := ' (' || v_inp_isadmin || ' = 1) ';
  
    --【仓库权限】Sql构建
    IF v_shoresult IS NOT NULL THEN
      v_shocond := 'scmdata.instr_priv(p_str1  => ''' || v_shoresult ||
                   ''',p_str2  => ' || v_inp_shoalias ||
                   '.sho_id,p_split => '';'')>0 ';
    END IF;
  
    --【分部权限】Sql构建
    IF v_cateresult IS NOT NULL THEN
      v_catecond := 'scmdata.instr_priv(p_str1 => ''' || v_cateresult ||
                    ''',p_str2 => ' || v_inp_catealias ||
                    '.category,p_split => '';'')>0';
    END IF;
  
    --【条件Sql】构建
    IF v_shocond IS NULL
       AND v_catecond IS NULL THEN
      v_cond := v_isadmincond;
    ELSIF v_shocond IS NOT NULL
          AND v_catecond IS NULL THEN
      v_cond := ' (' || v_isadmincond || ' or ' || v_shocond || ') ';
    ELSIF v_shocond IS NULL
          AND v_catecond IS NOT NULL THEN
      v_cond := ' (' || v_isadmincond || ' or ' || v_catecond || ') ';
    ELSIF v_shocond IS NOT NULL
          AND v_catecond IS NOT NULL THEN
      v_cond := ' (' || v_isadmincond || ' or (' || v_shocond || ' and ' ||
                v_catecond || ')) ';
    END IF;
  
    RETURN v_cond;
  END f_get_shoandcatecondsql;

  /*=============================================================================
  
     包：
       pkg_qa_lc(QA逻辑链包)
  
     过程名:
       Asn免检
  
     入参:
       v_inp_asnid        : AsnId
       v_inp_compid       : 企业Id
       v_inp_aeresoncode  : 免检原因编码
       v_inp_curuserid    : 当前操作人Id
  
     版本:
       2022-10-09_ZC314 : Asn免检
       2022-10-13_zc314 : pkg_qa_ee异常处理需要记录操作人
  
  ==============================================================================*/
  PROCEDURE p_asnexemption(v_inp_asnid       IN VARCHAR2,
                           v_inp_compid      IN VARCHAR2,
                           v_inp_aeresoncode IN VARCHAR2,
                           v_inp_curuserid   IN VARCHAR2) IS
    v_errmsg          VARCHAR2(1024);
    v_selfdescription VARCHAR2(1024) := 'scmdata.pkg_qa_lc.p_asnexemption';
  BEGIN
    --校验 Asn 免检输入参数
    v_errmsg := scmdata.pkg_qa_ld.f_check_asnexemptionparam(v_inp_asnid       => v_inp_asnid,
                                                            v_inp_compid      => v_inp_compid,
                                                            v_inp_aeresoncode => v_inp_aeresoncode,
                                                            v_inp_invokeobj   => v_selfdescription);
  
    --参数校验结果不为空，抛出错误信息
    IF v_errmsg IS NOT NULL THEN
      raise_application_error(-20002, v_errmsg);
    END IF;
  
    --Asn 状态及免检原因更新
    scmdata.pkg_qa_ld.p_upd_asnstatusandaereason(v_inp_asnid       => v_inp_asnid,
                                                 v_inp_compid      => v_inp_compid,
                                                 v_inp_aeresoncode => v_inp_aeresoncode,
                                                 v_inp_curuserid   => v_inp_curuserid,
                                                 v_inp_invokeobj   => v_selfdescription);
  
    --生成 Asn 预回传 Wms 表信息
    p_gen_asninfopretranstowms_data_ae(v_inp_asnid     => v_inp_asnid,
                                       v_inp_compid    => v_inp_compid,
                                       v_inp_curuserid => v_inp_curuserid);
  
    --生成 Asn 已检列表信息
    p_iu_qaqualedlist(v_inp_asnid     => v_inp_asnid,
                      v_inp_curuserid => v_inp_curuserid,
                      v_inp_compid    => v_inp_compid);
  END p_asnexemption;

  /*=============================================================================
  
     包：
       pkg_qa_lc(QA逻辑链包)
  
     过程名:
       免检生成 Asn 预回传 Wms 表信息
  
     入参:
       v_inp_asnid      : AsnId
       v_inp_compid     : 企业Id
       v_inp_curuserid  : 当前操作人Id
  
     版本:
       2022-10-09_ZC314 : 免检生成 Asn 预回传 Wms 表信息
  
  ==============================================================================*/
  PROCEDURE p_gen_asninfopretranstowms_data_ae(v_inp_asnid     IN VARCHAR2,
                                               v_inp_compid    IN VARCHAR2,
                                               v_inp_curuserid IN VARCHAR2) IS
    v_status          VARCHAR2(8);
    v_errinfo         CLOB;
    v_jugnum          NUMBER(1);
    v_selfdescription VARCHAR2(1024) := 'scmdata.pkg_qa_lc.p_gen_asninfopretranstowms_data_ae';
  BEGIN
    --判断是否存在于 Asn预回传Wms表
    v_jugnum := scmdata.pkg_qa_da.f_is_asninfopretranstowms_exists(v_inp_asnid  => v_inp_asnid,
                                                                   v_inp_compid => v_inp_compid);
  
    IF v_jugnum = 0 THEN
      --状态，错误信息赋值
      scmdata.pkg_qa_da.p_get_pretransstatusanderrinfo(v_inp_asnid   => v_inp_asnid,
                                                       v_inp_compid  => v_inp_compid,
                                                       v_inp_status  => v_status,
                                                       v_inp_errinfo => v_errinfo);
    
      --新增进入Asn预回传Wms表
      scmdata.pkg_qa_ld.p_ins_asninfopretranstowms(v_inp_asnid     => v_inp_asnid,
                                                   v_inp_compid    => v_inp_compid,
                                                   v_inp_status    => v_status,
                                                   v_inp_errinfo   => v_errinfo,
                                                   v_inp_transtype => 'AE',
                                                   v_inp_curuserid => v_inp_curuserid,
                                                   v_inp_invokeobj => v_selfdescription);
    END IF;
  END p_gen_asninfopretranstowms_data_ae;

  /*=============================================================================
  
     包：
       pkg_qa_lc(QA逻辑链包)
  
     过程名:
       新增/修改 Qa已检列表从表
  
     入参:
       v_inp_asnid       :  AsnId
       v_inp_operuserid  :  当前操作人Id
       v_inp_compid      :  企业Id
  
     版本:
       2022-10-11_ZC314 : 新增/修改 Qa已检列表从表
       2022-10-13_zc314 : pkg_qa_ee异常处理需要记录操作人
  
  ==============================================================================*/
  PROCEDURE p_iu_qaqualedlistsla(v_inp_asnid      IN VARCHAR2,
                                 v_inp_operuserid IN VARCHAR2,
                                 v_inp_compid     IN VARCHAR2) IS
    TYPE refcursor IS REF CURSOR;
    cursor_rc           refcursor;
    v_status            VARCHAR2(8);
    v_jugnum            NUMBER(1);
    v_sql               CLOB;
    v_asnid             VARCHAR2(32);
    v_compid            VARCHAR2(32);
    v_gooid             VARCHAR2(32);
    v_barcode           VARCHAR2(32);
    v_ordid             VARCHAR2(32);
    v_pcomeamt          VARCHAR2(32);
    v_wmsgotamt         VARCHAR2(32);
    v_qualdecreamt      NUMBER(8);
    v_qualpassamt       NUMBER(8);
    v_qualresult        VARCHAR2(8);
    v_unqualprosresult  VARCHAR2(8);
    v_arrretnum         NUMBER(8);
    v_aereason          VARCHAR2(8);
    v_pcomedate         DATE;
    v_scantime          DATE;
    v_receivetime       DATE;
    v_qualfinishtime    DATE;
    v_colorname         VARCHAR2(32);
    v_sizename          VARCHAR2(32);
    v_datasource        VARCHAR2(8);
    v_wmsskucheckresult VARCHAR2(8);
    v_selfdescription   VARCHAR2(1024) := 'scmdata.pkg_qa_lc.p_iu_qaqualedlistsla';
  BEGIN
    --获取Asn状态
    v_status := scmdata.pkg_qa_da.f_get_asnstatus(v_inp_asnid  => v_inp_asnid,
                                                  v_inp_compid => v_inp_compid);
  
    --判断
    IF v_status = 'AE' THEN
      --获取相关变量的值
      v_sql := scmdata.pkg_qa_ld.f_get_asnae_barcodedim_sql(v_inp_invokeobj => v_selfdescription);
    ELSIF v_status = 'FA' THEN
      --获取相关变量的值
      v_sql := scmdata.pkg_qa_ld.f_get_asnfa_barcodedim_sql(v_inp_invokeobj => v_selfdescription);
    END IF;
  
    IF v_sql IS NOT NULL THEN
      --使用 v_inp_asnid, v_inp_compid 开启动态游标
      OPEN cursor_rc FOR v_sql
        USING v_inp_asnid, v_inp_compid;
      LOOP
        --动态游标赋值
        FETCH cursor_rc
          INTO v_asnid,
               v_compid,
               v_gooid,
               v_barcode,
               v_ordid,
               v_pcomeamt,
               v_wmsgotamt,
               v_qualdecreamt,
               v_qualpassamt,
               v_qualresult,
               v_unqualprosresult,
               v_arrretnum,
               v_aereason,
               v_pcomedate,
               v_scantime,
               v_receivetime,
               v_qualfinishtime,
               v_colorname,
               v_sizename,
               v_datasource,
               v_wmsskucheckresult;
        --动态游标无值时退出
        EXIT WHEN cursor_rc%NOTFOUND;
      
        --判断第一次无值时不进入实际流程
        IF v_asnid IS NOT NULL THEN
          --判断是否存在于已检列表-从表
          v_jugnum := scmdata.pkg_qa_da.f_is_qaqualedlistsla_exists(v_inp_asnid   => v_asnid,
                                                                    v_inp_gooid   => v_gooid,
                                                                    v_inp_barcode => v_barcode,
                                                                    v_inp_compid  => v_compid);
        
          --判断，新增，修改
          IF v_jugnum = 0 THEN
            --新增
            scmdata.pkg_qa_ld.p_ins_qaqualedlistsla(v_inp_asnid             => v_asnid,
                                                    v_inp_compid            => v_compid,
                                                    v_inp_gooid             => v_gooid,
                                                    v_inp_barcode           => v_barcode,
                                                    v_inp_ordid             => v_ordid,
                                                    v_inp_pcomeamt          => v_pcomeamt,
                                                    v_inp_wmsgotamt         => v_wmsgotamt,
                                                    v_inp_qualdecreamt      => v_qualdecreamt,
                                                    v_inp_qualpassamt       => v_qualpassamt,
                                                    v_inp_qualresult        => v_qualresult,
                                                    v_inp_unqualprosresult  => v_unqualprosresult,
                                                    v_inp_arrretnum         => v_arrretnum,
                                                    v_inp_aereason          => v_aereason,
                                                    v_inp_pcomedate         => v_pcomedate,
                                                    v_inp_scantime          => v_scantime,
                                                    v_inp_receivetime       => v_receivetime,
                                                    v_inp_qualfinishtime    => v_qualfinishtime,
                                                    v_inp_colorname         => v_colorname,
                                                    v_inp_sizename          => v_sizename,
                                                    v_inp_datasource        => v_datasource,
                                                    v_inp_wmsskucheckresult => v_wmsskucheckresult,
                                                    v_inp_operuserid        => v_inp_operuserid,
                                                    v_inp_invokeobj         => v_selfdescription);
          ELSIF v_jugnum > 0 THEN
            --修改
            scmdata.pkg_qa_ld.p_upd_qaqualedlistsla(v_inp_asnid             => v_asnid,
                                                    v_inp_compid            => v_compid,
                                                    v_inp_gooid             => v_gooid,
                                                    v_inp_barcode           => v_barcode,
                                                    v_inp_ordid             => v_ordid,
                                                    v_inp_pcomeamt          => v_pcomeamt,
                                                    v_inp_wmsgotamt         => v_wmsgotamt,
                                                    v_inp_qualdecreamt      => v_qualdecreamt,
                                                    v_inp_qualpassamt       => v_qualpassamt,
                                                    v_inp_qualresult        => v_qualresult,
                                                    v_inp_unqualprosresult  => v_unqualprosresult,
                                                    v_inp_arrretnum         => v_arrretnum,
                                                    v_inp_aereason          => v_aereason,
                                                    v_inp_pcomedate         => v_pcomedate,
                                                    v_inp_scantime          => v_scantime,
                                                    v_inp_receivetime       => v_receivetime,
                                                    v_inp_qualfinishtime    => v_qualfinishtime,
                                                    v_inp_colorname         => v_colorname,
                                                    v_inp_sizename          => v_sizename,
                                                    v_inp_datasource        => v_datasource,
                                                    v_inp_wmsskucheckresult => v_wmsskucheckresult,
                                                    v_inp_operuserid        => v_inp_operuserid,
                                                    v_inp_invokeobj         => v_selfdescription);
          END IF;
        END IF;
      END LOOP;
      --关闭动态游标
      CLOSE cursor_rc;
    END IF;
  END p_iu_qaqualedlistsla;

  /*=============================================================================
  
     包：
       pkg_qa_lc(QA逻辑链包)
  
     过程名:
       新增/修改 Qa已检列表主表
  
     入参:
       v_inp_asnid      : AsnId
       v_inp_operuserid : 当前操作人Id
       v_inp_compid     : 企业Id
  
     版本:
       2022-10-11_ZC314 : 新增/修改 Qa已检列表主表
       2022-10-13_ZC314 : pkg_qa_ee异常处理增加当前操作人
  
  ==============================================================================*/
  PROCEDURE p_iu_qaqualedlistmas(v_inp_asnid      IN VARCHAR2,
                                 v_inp_operuserid IN VARCHAR2,
                                 v_inp_compid     IN VARCHAR2) IS
  
    v_asnid           VARCHAR2(32);
    v_compid          VARCHAR2(32);
    v_ordid           VARCHAR2(32);
    v_pcomeamt        NUMBER(8);
    v_wmsgotamt       NUMBER(8);
    v_qualdecreamt    NUMBER(8);
    v_qualpassamt     NUMBER(8);
    v_qualresult      VARCHAR2(8);
    v_unqualproresult VARCHAR2(128);
    v_arriveretnum    NUMBER(8);
    v_aereason        VARCHAR2(8);
    v_pcomedate       DATE;
    v_scantime        DATE;
    v_receivetime     DATE;
    v_qualfinishtime  DATE;
    v_sql             CLOB;
    v_jugnum          NUMBER(1);
    v_selfdescription VARCHAR2(1024) := 'scmdata.pkg_qa_lc.p_iu_qaqualedlistmas';
  BEGIN
    --获取新增/更新所需变量值
    v_sql := scmdata.pkg_qa_ld.f_get_qualedlistmas_iusql(v_inp_invokeobj => v_selfdescription);
  
    EXECUTE IMMEDIATE v_sql
      INTO v_asnid, v_compid, v_ordid, v_pcomeamt, v_wmsgotamt, v_qualdecreamt, v_qualpassamt, v_qualresult, v_unqualproresult, v_arriveretnum, v_aereason, v_pcomedate, v_scantime, v_receivetime, v_qualfinishtime
      USING v_inp_asnid, v_inp_compid;
  
    --判断该 Asn 是否存在于已检列表主表
    v_jugnum := scmdata.pkg_qa_da.f_is_qaqualedlistmas_exists(v_inp_asnid  => v_inp_asnid,
                                                              v_inp_compid => v_inp_compid);
  
    IF v_jugnum = 0 THEN
      --新增
      scmdata.pkg_qa_ld.p_ins_qaqualedlistmas(v_inp_asnid            => v_asnid,
                                              v_inp_compid           => v_compid,
                                              v_inp_ordid            => v_ordid,
                                              v_inp_pcomeamt         => v_pcomeamt,
                                              v_inp_wmsgotamt        => v_wmsgotamt,
                                              v_inp_qualdecreamt     => v_qualdecreamt,
                                              v_inp_qualpassamt      => v_qualpassamt,
                                              v_inp_qualresult       => v_qualresult,
                                              v_inp_unqualprosresult => v_unqualproresult,
                                              v_inp_arrretnum        => v_arriveretnum,
                                              v_inp_aereason         => v_aereason,
                                              v_inp_pcomedate        => v_pcomedate,
                                              v_inp_scantime         => v_scantime,
                                              v_inp_receivetime      => v_receivetime,
                                              v_inp_qualfinishtime   => v_qualfinishtime,
                                              v_inp_operuserid       => v_inp_operuserid,
                                              v_inp_invokeobj        => v_selfdescription);
    ELSE
      --更新
      scmdata.pkg_qa_ld.p_upd_qaqualedlistmas(v_inp_asnid            => v_asnid,
                                              v_inp_compid           => v_compid,
                                              v_inp_ordid            => v_ordid,
                                              v_inp_pcomeamt         => v_pcomeamt,
                                              v_inp_wmsgotamt        => v_wmsgotamt,
                                              v_inp_qualdecreamt     => v_qualdecreamt,
                                              v_inp_qualpassamt      => v_qualpassamt,
                                              v_inp_qualresult       => v_qualresult,
                                              v_inp_unqualprosresult => v_unqualproresult,
                                              v_inp_arrretnum        => v_arriveretnum,
                                              v_inp_aereason         => v_aereason,
                                              v_inp_pcomedate        => v_pcomedate,
                                              v_inp_scantime         => v_scantime,
                                              v_inp_receivetime      => v_receivetime,
                                              v_inp_qualfinishtime   => v_qualfinishtime,
                                              v_inp_operuserid       => v_inp_operuserid,
                                              v_inp_invokeobj        => v_selfdescription);
    END IF;
  END p_iu_qaqualedlistmas;

  /*=============================================================================
  
     包：
       pkg_qa_lc(QA逻辑链包)
  
     过程名:
       新增/修改 Qa已检列表数据
  
     入参:
       v_inp_asnid      :  AsnId
       v_inp_curuserid  :  当前操作人Id
       v_inp_compid     :  企业Id
  
     版本:
       2022-10-11_ZC314 : Qa已检列表数据
       2022-10-13_zc314 : pkg_qa_ee异常处理需要记录操作人
  
  ==============================================================================*/
  PROCEDURE p_iu_qaqualedlist(v_inp_asnid     IN VARCHAR2,
                              v_inp_curuserid IN VARCHAR2,
                              v_inp_compid    IN VARCHAR2) IS
    v_jugnum NUMBER(1);
  BEGIN
    --判断 Asn状态是否为已质检/免检
    v_jugnum := scmdata.pkg_qa_da.f_is_asnstatusaeorfa(v_inp_asnid  => v_inp_asnid,
                                                       v_inp_compid => v_inp_compid);
  
    IF v_jugnum > 0 THEN
      --已检从表数据增改
      p_iu_qaqualedlistsla(v_inp_asnid      => v_inp_asnid,
                           v_inp_operuserid => v_inp_curuserid,
                           v_inp_compid     => v_inp_compid);
    
      --已检主表数据增改
      p_iu_qaqualedlistmas(v_inp_asnid      => v_inp_asnid,
                           v_inp_operuserid => v_inp_curuserid,
                           v_inp_compid     => v_inp_compid);
    END IF;
  
  END p_iu_qaqualedlist;

  /*=============================================================================
  
     包：
       pkg_qa_lc(QA逻辑链包)
  
     过程名:
       新增/修改 Qa质检报告 Sku维度信息表
  
     入参:
       v_inp_qarepid             :  质检报告Id
       v_inp_compid              :  企业Id
       v_inp_asnid               :  Asn单号
       v_inp_gooid               :  商品档案编号
       v_inp_barcode             :  条码
       v_inp_status              :  状态
       v_inp_skuprocessingresult :  Sku处理结果
       v_inp_skucheckresult      :  Sku质检结果
       v_inp_pcomeamount         :  预计到仓数量
       v_inp_wmsgotamount        :  wms上架数量
       v_inp_qualdecreaseamount  :  质检减数
       v_inp_unqualamount        :  不合格数量
       v_inp_reprocessednumber   :  返工次数
       v_inp_pcomedate           :  预计到仓日期
       v_inp_scantime            :  到仓扫描时间
       v_inp_receivetime         :  收货时间
       v_inp_colorname           :  颜色名称
       v_inp_sizename            :  尺码名称
       v_inp_reviewid            :  审核人Id
       v_inp_reviewtime          :  审核时间
       v_inp_qualfinishtime      :  质检结束时间
       v_inp_operuserid          :  当前操作人Id
  
     版本:
       2022-10-14_zc314 : 新增/修改 Qa质检报告 Sku维度信息表
  
  ==============================================================================*/
  PROCEDURE p_iu_qareportskudim(v_inp_qarepid             IN VARCHAR2,
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
                                v_inp_colorname           IN VARCHAR2,
                                v_inp_sizename            IN VARCHAR2,
                                v_inp_reviewid            IN VARCHAR2,
                                v_inp_reviewtime          IN DATE,
                                v_inp_qualfinishtime      IN DATE,
                                v_inp_operuserid          IN VARCHAR2) IS
    v_jugnum          NUMBER(1);
    v_selfdescription VARCHAR2(1024) := 'scmdata.pkg_qa_lc.p_iu_qareportskudim';
  BEGIN
    --判断是否存在Qa质检报告关联信息表数据
    v_jugnum := scmdata.pkg_qa_da.f_is_qarephasskudimdata(v_inp_qarepid => v_inp_qarepid,
                                                          v_inp_compid  => v_inp_compid,
                                                          v_inp_asnid   => v_inp_asnid,
                                                          v_inp_gooid   => v_inp_gooid,
                                                          v_inp_barcode => v_inp_barcode);
  
    --判断，新增，修改
    IF v_jugnum = 0 THEN
      --新增
      scmdata.pkg_qa_ld.p_ins_qareportskudim(v_inp_qarepid             => v_inp_qarepid,
                                             v_inp_compid              => v_inp_compid,
                                             v_inp_asnid               => v_inp_asnid,
                                             v_inp_gooid               => v_inp_gooid,
                                             v_inp_barcode             => v_inp_barcode,
                                             v_inp_status              => v_inp_status,
                                             v_inp_skuprocessingresult => v_inp_skuprocessingresult,
                                             v_inp_skucheckresult      => v_inp_skucheckresult,
                                             v_inp_pcomeamount         => v_inp_pcomeamount,
                                             v_inp_wmsgotamount        => v_inp_wmsgotamount,
                                             v_inp_qualdecreaseamount  => v_inp_qualdecreaseamount,
                                             v_inp_unqualamount        => v_inp_unqualamount,
                                             v_inp_reprocessednumber   => v_inp_reprocessednumber,
                                             v_inp_pcomedate           => v_inp_pcomedate,
                                             v_inp_scantime            => v_inp_scantime,
                                             v_inp_receivetime         => v_inp_receivetime,
                                             v_inp_colorname           => v_inp_colorname,
                                             v_inp_sizename            => v_inp_sizename,
                                             v_inp_reviewid            => v_inp_reviewid,
                                             v_inp_reviewtime          => v_inp_reviewtime,
                                             v_inp_qualfinishtime      => v_inp_qualfinishtime,
                                             v_inp_operuserid          => v_inp_operuserid,
                                             v_inp_invokeobj           => v_selfdescription);
    ELSE
      --修改
      scmdata.pkg_qa_ld.p_upd_qareportskudim(v_inp_qarepid             => v_inp_qarepid,
                                             v_inp_compid              => v_inp_compid,
                                             v_inp_asnid               => v_inp_asnid,
                                             v_inp_gooid               => v_inp_gooid,
                                             v_inp_barcode             => v_inp_barcode,
                                             v_inp_status              => v_inp_status,
                                             v_inp_skuprocessingresult => v_inp_skuprocessingresult,
                                             v_inp_skucheckresult      => v_inp_skucheckresult,
                                             v_inp_pcomeamount         => v_inp_pcomeamount,
                                             v_inp_wmsgotamount        => v_inp_wmsgotamount,
                                             v_inp_qualdecreaseamount  => v_inp_qualdecreaseamount,
                                             v_inp_unqualamount        => v_inp_unqualamount,
                                             v_inp_reprocessednumber   => v_inp_reprocessednumber,
                                             v_inp_pcomedate           => v_inp_pcomedate,
                                             v_inp_scantime            => v_inp_scantime,
                                             v_inp_receivetime         => v_inp_receivetime,
                                             v_inp_colorname           => v_inp_colorname,
                                             v_inp_sizename            => v_inp_sizename,
                                             v_inp_reviewid            => v_inp_reviewid,
                                             v_inp_reviewtime          => v_inp_reviewtime,
                                             v_inp_qualfinishtime      => v_inp_qualfinishtime,
                                             v_inp_operuserid          => v_inp_operuserid,
                                             v_inp_invokeobj           => v_selfdescription);
    END IF;
  END p_iu_qareportskudim;

  /*=============================================================================
  
     包：
       pkg_qa_lc(QA逻辑链包)
  
     过程名:
       新增/修改 Qa质检报告关联信息表
  
     入参:
       v_inp_qarepid    :  质检报告Id
       v_inp_compid     :  企业Id
       v_inp_asnid      :  AsnId
       v_inp_gooid      :  商品档案编号
       v_inp_orderid    :  订单号
       v_inp_supcode    :  供应商编码
       v_inp_faccode    :  生产工厂编码
       v_inp_shoid      :  仓库Id
       v_inp_curuserid  :  当前操作人Id
  
     版本:
       2022-10-13_zc314 : 新增/修改 Qa质检报告关联信息表
  
  ==============================================================================*/
  PROCEDURE p_iu_qareportrelainfodim(v_inp_qarepid    IN VARCHAR2,
                                     v_inp_compid     IN VARCHAR2,
                                     v_inp_asnid      IN VARCHAR2,
                                     v_inp_gooid      IN VARCHAR2,
                                     v_inp_orderid    IN VARCHAR2,
                                     v_inp_supcode    IN VARCHAR2,
                                     v_inp_faccode    IN VARCHAR2,
                                     v_inp_shoid      IN VARCHAR2,
                                     v_inp_operuserid IN VARCHAR2) IS
    v_jugnum          NUMBER(1);
    v_selfdescription VARCHAR2(1024) := 'scmdata.pkg_qa_lc.p_iu_qareportrelainfodim';
  BEGIN
    --判断是否存在Qa质检报告关联信息表数据
    v_jugnum := scmdata.pkg_qa_da.f_is_asnshasqareportrelainfodim(v_inp_qarepid => v_inp_qarepid,
                                                                  v_inp_compid  => v_inp_compid);
  
    --判断，新增，修改
    IF v_jugnum = 0 THEN
      --新增
      scmdata.pkg_qa_ld.p_ins_qareportrelainfodim(v_inp_qarepid    => v_inp_qarepid,
                                                  v_inp_compid     => v_inp_compid,
                                                  v_inp_asnid      => v_inp_asnid,
                                                  v_inp_gooid      => v_inp_gooid,
                                                  v_inp_orderid    => v_inp_orderid,
                                                  v_inp_supcode    => v_inp_supcode,
                                                  v_inp_faccode    => v_inp_faccode,
                                                  v_inp_shoid      => v_inp_shoid,
                                                  v_inp_operuserid => v_inp_operuserid,
                                                  v_inp_invokeobj  => v_selfdescription);
    ELSE
      --修改
      scmdata.pkg_qa_ld.p_upd_qareportrelainfodim(v_inp_qarepid    => v_inp_qarepid,
                                                  v_inp_compid     => v_inp_compid,
                                                  v_inp_asnid      => v_inp_asnid,
                                                  v_inp_gooid      => v_inp_gooid,
                                                  v_inp_orderid    => v_inp_orderid,
                                                  v_inp_supcode    => v_inp_supcode,
                                                  v_inp_faccode    => v_inp_faccode,
                                                  v_inp_shoid      => v_inp_shoid,
                                                  v_inp_operuserid => v_inp_operuserid,
                                                  v_inp_invokeobj  => v_selfdescription);
    END IF;
  END p_iu_qareportrelainfodim;

  /*=============================================================================
  
     包：
       pkg_qa_lc(QA逻辑链包)
  
     过程名:
       新增/修改 Qa质检报告关联信息表
  
     入参:
       v_inp_qarepid                  :  Qa报告Id
       v_inp_compid                   :  企业Id
       v_inp_firstsamplingamount      :  首抽件数
       v_inp_addsamplingamount        :  加抽件数
       v_inp_unqualsamplingamount     :  不合格件数
       v_inp_pcomesumamount           :  预计到仓总数
       v_inp_wmsgotsumamount          :  wms上架总数
       v_inp_qualdecreasesumamount    :  质检件数总数
       v_inp_prereprocessingsumamount :  待返工数量
       v_inp_operuserid               :  操作人Id
  
     版本:
       2022-10-14_zc314 : Qa质检报告关联信息表
  
  ==============================================================================*/
  PROCEDURE p_iu_qareportnumdim(v_inp_qarepid                  IN VARCHAR2,
                                v_inp_compid                   IN VARCHAR2,
                                v_inp_firstsamplingamount      IN NUMBER,
                                v_inp_addsamplingamount        IN NUMBER,
                                v_inp_unqualsamplingamount     IN NUMBER,
                                v_inp_pcomesumamount           IN NUMBER,
                                v_inp_wmsgotsumamount          IN NUMBER,
                                v_inp_qualdecreasesumamount    IN NUMBER,
                                v_inp_prereprocessingsumamount IN NUMBER,
                                v_inp_operuserid               IN VARCHAR2) IS
    v_jugnum          NUMBER(1);
    v_selfdescription VARCHAR2(1024) := 'scmdata.pkg_qa_lc.p_iu_qareportnumdim';
  BEGIN
    --判断是否存在Qa质检报告关联信息表数据
    v_jugnum := scmdata.pkg_qa_da.f_is_qarephasnumdimdata(v_inp_qarepid => v_inp_qarepid,
                                                          v_inp_compid  => v_inp_compid);
  
    --判断，新增，修改
    IF v_jugnum = 0 THEN
      --新增
      scmdata.pkg_qa_ld.p_ins_qarepnumdim(v_inp_qarepid                  => v_inp_qarepid,
                                          v_inp_compid                   => v_inp_compid,
                                          v_inp_firstsamplingamount      => v_inp_firstsamplingamount,
                                          v_inp_addsamplingamount        => v_inp_addsamplingamount,
                                          v_inp_unqualsamplingamount     => v_inp_unqualsamplingamount,
                                          v_inp_pcomesumamount           => v_inp_pcomesumamount,
                                          v_inp_wmsgotsumamount          => v_inp_wmsgotsumamount,
                                          v_inp_qualdecreasesumamount    => v_inp_qualdecreasesumamount,
                                          v_inp_prereprocessingsumamount => v_inp_prereprocessingsumamount,
                                          v_inp_operuserid               => v_inp_operuserid,
                                          v_inp_invokeobj                => v_selfdescription);
    ELSE
      --修改
      scmdata.pkg_qa_ld.p_upd_qarepnumdim(v_inp_qarepid                  => v_inp_qarepid,
                                          v_inp_compid                   => v_inp_compid,
                                          v_inp_firstsamplingamount      => v_inp_firstsamplingamount,
                                          v_inp_addsamplingamount        => v_inp_addsamplingamount,
                                          v_inp_unqualsamplingamount     => v_inp_unqualsamplingamount,
                                          v_inp_pcomesumamount           => v_inp_pcomesumamount,
                                          v_inp_wmsgotsumamount          => v_inp_wmsgotsumamount,
                                          v_inp_qualdecreasesumamount    => v_inp_qualdecreasesumamount,
                                          v_inp_prereprocessingsumamount => v_inp_prereprocessingsumamount,
                                          v_inp_operuserid               => v_inp_operuserid,
                                          v_inp_invokeobj                => v_selfdescription);
    END IF;
  END p_iu_qareportnumdim;

  /*=============================================================================
  
     包：
       pkg_qa_lc(QA逻辑链包)
  
     过程名:
       新增/修改 Qa质检报告报告级质检细节表增改
  
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
  
     版本:
       2022-10-14_zc314 : Qa质检报告报告级质检细节表增改
  
  ==============================================================================*/
  PROCEDURE p_iu_qareportcheckdetaildim(v_inp_qarepid           IN VARCHAR2,
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
                                        v_inp_operuserid        IN VARCHAR2) IS
    v_jugnum          NUMBER(1);
    v_selfdescription VARCHAR2(1024) := 'scmdata.pkg_qa_lc.p_iu_qareportcheckdetaildim';
  BEGIN
    --判断是否存在Qa质检报告关联信息表数据
    v_jugnum := scmdata.pkg_qa_da.f_is_qarephascheckdetaildimdata(v_inp_qarepid => v_inp_qarepid,
                                                                  v_inp_compid  => v_inp_compid);
  
    --判断，新增，修改
    IF v_jugnum = 0 THEN
      scmdata.pkg_qa_ld.p_ins_qarepcheckdetaildim(v_inp_qarepid           => v_inp_qarepid,
                                                  v_inp_compid            => v_inp_compid,
                                                  v_inp_yyresult          => v_inp_yyresult,
                                                  v_inp_yyunqualsubjects  => v_inp_yyunqualsubjects,
                                                  v_inp_mflresult         => v_inp_mflresult,
                                                  v_inp_mflunqualsubjects => v_inp_mflunqualsubjects,
                                                  v_inp_gyresult          => v_inp_gyresult,
                                                  v_inp_gyunqualsubjects  => v_inp_gyunqualsubjects,
                                                  v_inp_bxresult          => v_inp_bxresult,
                                                  v_inp_bxuqualsubjects   => v_inp_bxuqualsubjects,
                                                  v_inp_scaleamount       => v_inp_scaleamount,
                                                  v_inp_operuserid        => v_inp_operuserid,
                                                  v_inp_invokeobj         => v_selfdescription);
    ELSE
      scmdata.pkg_qa_ld.p_upd_qarepcheckdetaildim(v_inp_qarepid           => v_inp_qarepid,
                                                  v_inp_compid            => v_inp_compid,
                                                  v_inp_yyresult          => v_inp_yyresult,
                                                  v_inp_yyunqualsubjects  => v_inp_yyunqualsubjects,
                                                  v_inp_mflresult         => v_inp_mflresult,
                                                  v_inp_mflunqualsubjects => v_inp_mflunqualsubjects,
                                                  v_inp_gyresult          => v_inp_gyresult,
                                                  v_inp_gyunqualsubjects  => v_inp_gyunqualsubjects,
                                                  v_inp_bxresult          => v_inp_bxresult,
                                                  v_inp_bxuqualsubjects   => v_inp_bxuqualsubjects,
                                                  v_inp_scaleamount       => v_inp_scaleamount,
                                                  v_inp_operuserid        => v_inp_operuserid,
                                                  v_inp_invokeobj         => v_selfdescription);
    END IF;
  END p_iu_qareportcheckdetaildim;

  /*=============================================================================
  
     包：
       pkg_qa_lc(QA逻辑链包)
  
     过程名:
       校验多选对象合并字符串最大长度，大于4000报错
  
     入参:
       v_inp_clob : 输入值
  
     版本:
       2022-10-12_ZC314 : 校验多选对象合并字符串最大长度，大于4000报错
  
  ==============================================================================*/
  PROCEDURE p_check_multiselectallowmaxobjnum(v_inp_clob IN CLOB) IS
    v_jugnum          NUMBER(1);
    v_selfdescription VARCHAR2(1024) := 'scmdata.pkg_qa_lc.p_check_multiselectallowmaxobjnum';
  BEGIN
    --获取多选对象合并字符串最大长度是否小于等于4000
    v_jugnum := scmdata.pkg_qa_ld.f_is_cloblengthlessorequalfourk(v_inp_clob      => v_inp_clob,
                                                                  v_inp_invokeobj => v_selfdescription);
  
    --字符串大于4000，报错
    IF v_jugnum = 0 THEN
      raise_application_error(-20002,
                              '多选对象合并字符串最大长度不能大于4000！');
    END IF;
  END p_check_multiselectallowmaxobjnum;

  /*=============================================================================
  
     包：
       pkg_qa_lc(QA逻辑链包)
  
     过程名:
       校验选中 Asn是否都是同一供应商，同一货号，
       非同一供应商，同一货号报错
  
     入参:
       v_inp_asnids   : 多个Asn_Id，由分号分隔
       v_inp_compid   : 企业Id
  
     版本:
       2022-10-12_ZC314 : 校验选中 Asn是否都是同一供应商，同一货号
                          非同一供应商，同一货号报错
  
  ==============================================================================*/
  PROCEDURE p_check_multiasnhassamesupplierandgoo(v_inp_asnids IN CLOB,
                                                  v_inp_compid IN VARCHAR2) IS
    v_jugnum NUMBER(1);
  BEGIN
    --获取是否存在同一供应商，同一货号
    v_jugnum := scmdata.pkg_qa_da.f_is_multiasnhassamesupplierandgoo(v_inp_asnids => v_inp_asnids,
                                                                     v_inp_compid => v_inp_compid);
  
    --不符合条件，报错
    IF v_jugnum = 0 THEN
      raise_application_error(-20002,
                              '所选ASN单需货号+供应商一致，否则不能生成QA质检报告！');
    END IF;
  END p_check_multiasnhassamesupplierandgoo;

  /*=============================================================================
  
     包：
       pkg_qa_lc(QA逻辑链包)
  
     过程名:
       新增 Qa质检报告
  
     入参:
       v_inp_asnids     : 多个Asn_Id，由分号分隔
       v_inp_compid     : 企业Id
       v_inp_curuserid  : 当前操作人Id
  
     版本:
       2022-10-12_ZC314 : 新增 Qa质检报告
  
  ==============================================================================*/
  PROCEDURE p_ins_qareportinfo(v_inp_asnids     IN CLOB,
                               v_inp_compid     IN VARCHAR2,
                               v_inp_ispriority IN NUMBER,
                               v_inp_curuserid  IN VARCHAR2) IS
    TYPE refcursor_qarepins IS REF CURSOR;
    cursor_datains           refcursor_qarepins;
    v_jugnum                 NUMBER(1);
    v_qarepid                VARCHAR2(32);
    v_sql                    CLOB;
    v_getreprocessednumsql   CLOB;
    v_asnid                  VARCHAR2(1024);
    v_compid                 VARCHAR2(32);
    v_gooid                  VARCHAR2(32);
    v_orderid                VARCHAR2(1024);
    v_barcode                VARCHAR2(1024);
    v_colorname              VARCHAR2(32);
    v_sizename               VARCHAR2(32);
    v_supcode                VARCHAR2(32);
    v_faccode                VARCHAR2(1024);
    v_shoid                  VARCHAR2(32);
    v_pcomeamount            NUMBER(8);
    v_wmsgotamount           NUMBER(8);
    v_pcomedate              DATE;
    v_scantime               DATE;
    v_receivetime            DATE;
    v_pcomesumamount         NUMBER(8);
    v_wmsgotsumamount        NUMBER(8);
    v_qualdrecreasesumamount NUMBER(8);
    v_unqualsumamount        NUMBER(8);
    v_reprocessednumber      NUMBER(8);
    v_selfdescription        VARCHAR2(1024) := 'scmdata.pkg_qa_lc.p_ins_qareportinfo';
  BEGIN
    --校验最大输入长度小于等于4000
    scmdata.pkg_qa_lc.p_check_multiselectallowmaxobjnum(v_inp_clob => v_inp_asnids);
  
    --所选ASN单需货号+供应商一致，否则不能生成QA质检报告！
    scmdata.pkg_qa_lc.p_check_multiasnhassamesupplierandgoo(v_inp_asnids => v_inp_asnids,
                                                            v_inp_compid => v_inp_compid);
  
    --判断Asn是否已存在Qa质检确认报告
    v_jugnum := scmdata.pkg_qa_da.f_is_asnshasqareport(v_inp_asnids => v_inp_asnids,
                                                       v_inp_compid => v_inp_compid);
  
    IF v_jugnum > 0 THEN
      --存在报错
      raise_application_error(-20002, '所选中的Asn已生成Qa质检确认报告！');
    
    ELSIF v_jugnum = 0 THEN
      --不存在，新增流程
      --Qa质检报告Id赋值
      v_qarepid := scmdata.f_getkeyid_plat(pi_pre     => 'QA',
                                           pi_seqname => 'seq_qaid',
                                           pi_seqnum  => 2);
    
      --Qa质检报告主表新增
      scmdata.pkg_qa_ld.p_ins_qareportmas(v_inp_qarepid              => v_qarepid,
                                          v_inp_compid               => v_inp_compid,
                                          v_inp_status               => 'PC',
                                          v_inp_checktype            => 'AC',
                                          v_inp_checkresult          => NULL,
                                          v_inp_problemclassifiction => NULL,
                                          v_inp_problemdescription   => NULL,
                                          v_inp_reviewcomments       => NULL,
                                          v_inp_checkers             => NULL,
                                          v_inp_checkdate            => SYSDATE,
                                          v_inp_qualattachment       => NULL,
                                          v_inp_reviewattachment     => NULL,
                                          v_inp_memo                 => NULL,
                                          v_inp_curuserid            => v_inp_curuserid,
                                          v_inp_curtime              => SYSDATE,
                                          v_inp_ispriority           => v_inp_ispriority,
                                          v_inp_invokeobj            => v_selfdescription);
    
      --获取 Qa质检报告Sku维度新增数据 Sql
      v_sql := scmdata.pkg_qa_ld.f_get_qarepskudiminsdata_sql(v_inp_invokeobj => v_selfdescription);
    
      --开启游标前非空判断
      IF v_sql IS NOT NULL THEN
        --开启动态游标
        OPEN cursor_datains FOR v_sql
          USING v_inp_asnids, v_inp_compid;
        LOOP
          --动态游标赋值
          FETCH cursor_datains
            INTO v_asnid,
                 v_compid,
                 v_gooid,
                 v_barcode,
                 v_pcomeamount,
                 v_wmsgotamount,
                 v_pcomedate,
                 v_scantime,
                 v_receivetime,
                 v_colorname,
                 v_sizename;
          EXIT WHEN cursor_datains%NOTFOUND;
        
          --判断，防止第一次无值进入正常流程
          IF v_asnid IS NOT NULL THEN
            --获取Sku到仓返工次数
            v_getreprocessednumsql := scmdata.pkg_qa_ld.f_get_asnbarcodereprocessingnum_sql(v_inp_invokeobj => v_selfdescription);
            EXECUTE IMMEDIATE v_getreprocessednumsql
              INTO v_reprocessednumber
              USING v_asnid, v_compid, v_gooid, v_barcode;
          
            --Qa质检报告Sku维度表增改
            p_iu_qareportskudim(v_inp_qarepid             => v_qarepid,
                                v_inp_compid              => v_compid,
                                v_inp_asnid               => v_asnid,
                                v_inp_gooid               => v_gooid,
                                v_inp_barcode             => v_barcode,
                                v_inp_status              => 'PA',
                                v_inp_skuprocessingresult => NULL,
                                v_inp_skucheckresult      => 'PS',
                                v_inp_pcomeamount         => nvl(v_pcomeamount,
                                                                 0),
                                v_inp_wmsgotamount        => nvl(v_wmsgotamount,
                                                                 0),
                                v_inp_qualdecreaseamount  => 0,
                                v_inp_unqualamount        => NULL,
                                v_inp_reprocessednumber   => v_reprocessednumber,
                                v_inp_pcomedate           => v_pcomedate,
                                v_inp_scantime            => v_scantime,
                                v_inp_receivetime         => v_receivetime,
                                v_inp_colorname           => v_colorname,
                                v_inp_sizename            => v_sizename,
                                v_inp_reviewid            => NULL,
                                v_inp_reviewtime          => NULL,
                                v_inp_qualfinishtime      => NULL,
                                v_inp_operuserid          => v_inp_curuserid);
          END IF;
        END LOOP;
        --关闭动态游标
        CLOSE cursor_datains;
      END IF;
    
      --获取 Qa质检报告Sku级汇总数字相关数据 Sql
      v_sql := scmdata.pkg_qa_ld.f_get_qarepskudimsumdata_sql(v_inp_invokeobj => v_selfdescription);
    
      --执行前Sql非空判断
      IF v_sql IS NOT NULL THEN
        --执行 Sql对变量进行赋值
        EXECUTE IMMEDIATE v_sql
          INTO v_pcomesumamount, v_wmsgotsumamount, v_qualdrecreasesumamount, v_unqualsumamount
          USING v_qarepid, v_inp_compid;
      
        --Qa质检报告数据维度表增改
        p_iu_qareportnumdim(v_inp_qarepid                  => v_qarepid,
                            v_inp_compid                   => v_inp_compid,
                            v_inp_firstsamplingamount      => NULL,
                            v_inp_addsamplingamount        => NULL,
                            v_inp_unqualsamplingamount     => v_unqualsumamount,
                            v_inp_pcomesumamount           => v_pcomesumamount,
                            v_inp_wmsgotsumamount          => v_wmsgotsumamount,
                            v_inp_qualdecreasesumamount    => v_qualdrecreasesumamount,
                            v_inp_prereprocessingsumamount => NULL,
                            v_inp_operuserid               => v_inp_curuserid);
      END IF;
    
      --获取 Qa质检报告关联信息数据 Sql
      v_sql := scmdata.pkg_qa_ld.f_get_qarepasngooorder_sql(v_inp_invokeobj => v_selfdescription);
    
      --执行前Sql非空判断
      IF v_sql IS NOT NULL THEN
        --执行 Sql对变量进行赋值
        EXECUTE IMMEDIATE v_sql
          INTO v_asnid, v_gooid, v_orderid, v_supcode, v_faccode, v_shoid
          USING v_qarepid, v_inp_compid;
      
        --Qa质检报告关联信息增改
        p_iu_qareportrelainfodim(v_inp_qarepid    => v_qarepid,
                                 v_inp_compid     => v_inp_compid,
                                 v_inp_asnid      => v_asnid,
                                 v_inp_gooid      => v_gooid,
                                 v_inp_orderid    => v_orderid,
                                 v_inp_supcode    => v_supcode,
                                 v_inp_shoid      => v_shoid,
                                 v_inp_faccode    => v_faccode,
                                 v_inp_operuserid => v_inp_curuserid);
      END IF;
    
      --Qa质检报告报告级质检细节表增改
      p_iu_qareportcheckdetaildim(v_inp_qarepid           => v_qarepid,
                                  v_inp_compid            => v_inp_compid,
                                  v_inp_yyresult          => NULL,
                                  v_inp_yyunqualsubjects  => NULL,
                                  v_inp_mflresult         => NULL,
                                  v_inp_mflunqualsubjects => NULL,
                                  v_inp_gyresult          => NULL,
                                  v_inp_gyunqualsubjects  => NULL,
                                  v_inp_bxresult          => NULL,
                                  v_inp_bxuqualsubjects   => NULL,
                                  v_inp_scaleamount       => NULL,
                                  v_inp_operuserid        => v_inp_curuserid);
    
      --修改 Asnordered 【Asn状态】字段
      scmdata.pkg_qa_ld.p_upd_asnstatus(v_inp_asnids     => v_inp_asnids,
                                        v_inp_compid     => v_inp_compid,
                                        v_inp_status     => 'PE',
                                        v_inp_operuserid => v_inp_curuserid,
                                        v_inp_invokeobj  => v_selfdescription);
    
      --刷新wms质检确认结果及来源字段
      scmdata.pkg_qa_itf.p_wmstscm_refreshwmsresultwhengenqarep(v_inp_asnids => v_inp_asnids,
                                                                v_inp_compid => v_inp_compid);
    END IF;
  END p_ins_qareportinfo;

  /*=============================================================================
  
     包：
       pkg_qa_lc(QA逻辑链包)
  
     函数名:
       校验输入人员是否存在于当前企业Qa组
  
     入参:
       v_inp_userids   :  输入人员Id，多值，用分号分隔
       v_inp_compid    :  企业Id
  
     返回值:
       Clob 类型，错误信息
  
     版本:
       2022-10-19_ZC314 : 校验输入人员是否存在于当前企业Qa组
  
  ==============================================================================*/
  FUNCTION f_check_checkersnotinqagroup(v_inp_checkers IN VARCHAR2,
                                        v_inp_compid   IN VARCHAR2)
    RETURN CLOB IS
    v_jugnum  NUMBER(1);
    v_errinfo CLOB;
  BEGIN
    --校验输入人员是否存在于当前企业内
    IF v_errinfo IS NULL THEN
      v_jugnum := scmdata.pkg_qa_da.f_is_usersincompany(v_inp_userids => v_inp_checkers,
                                                        v_inp_compid  => v_inp_compid);
    
      --判断校验结果
      IF v_jugnum = 0 THEN
        --报错信息记录
        v_errinfo := '查货员中存在非当前企业人员！';
      END IF;
    END IF;
  
    --校验当前输入人员是否被禁用
    IF v_errinfo IS NULL THEN
      v_jugnum := scmdata.pkg_qa_da.f_is_companyuserpaused(v_inp_userids => v_inp_checkers,
                                                           v_inp_compid  => v_inp_compid);
    
      --判断校验结果
      IF v_jugnum = 1 THEN
        --报错信息记录
        v_errinfo := '查货员中存在部分人员被禁用！';
      END IF;
    END IF;
  
    --校验人员是否都属于输入企业Qa组
    IF v_errinfo IS NULL THEN
      v_jugnum := scmdata.pkg_qa_da.f_is_userincompanyqadept(v_inp_userids => v_inp_checkers,
                                                             v_inp_compid  => v_inp_compid);
    
      --判断校验结果
      IF v_jugnum = 0 THEN
        --报错信息记录
        v_errinfo := '存在人员不属于当前企业Qa组！';
      END IF;
    END IF;
  
    RETURN v_errinfo;
  END f_check_checkersnotinqagroup;

  /*=============================================================================
  
     包：
       pkg_qa_ld(QA逻辑细节包)
  
     函数名:
       批量录入合格质检报告--值校验
  
     入参:
       v_inp_qarepids         :  质检报告Id
       v_inp_checkresult      :  质检确认结果
       v_inp_pcomeamount      :  预计到仓数量
       v_inp_firstcheckamount :  首抽件数
       v_inp_checkdate        :  查货时间
       v_inp_checkuserids     :  查货员
       v_inp_compid           :  企业Id
  
     版本:
       2022-10-19_ZC314 : 批量录入合格质检报告--值校验
  
  ==============================================================================*/
  FUNCTION f_batchpassqarep_valuecheck(v_inp_qarepid          IN CLOB,
                                       v_inp_checkresult      IN VARCHAR2,
                                       v_inp_pcomeamount      IN NUMBER,
                                       v_inp_firstcheckamount IN NUMBER,
                                       v_inp_checkdate        IN DATE,
                                       v_inp_checkuserids     IN VARCHAR2,
                                       v_inp_compid           IN VARCHAR2)
    RETURN CLOB IS
    v_errinfo CLOB;
  BEGIN
    IF v_inp_qarepid IS NULL THEN
      v_errinfo := scmdata.f_sentence_append_rc(v_sentence   => v_errinfo,
                                                v_appendstr  => '未选中质检报告！请先选择后再操作【批量录入合格质检报告】按钮',
                                                v_middliestr => chr(10));
    END IF;
  
    IF v_inp_checkresult IS NULL THEN
      v_errinfo := scmdata.f_sentence_append_rc(v_sentence   => v_errinfo,
                                                v_appendstr  => '【质检确认结果】不能为空！',
                                                v_middliestr => chr(10));
    ELSIF v_inp_checkresult <> 'APS' THEN
      v_errinfo := scmdata.f_sentence_append_rc(v_sentence   => v_errinfo,
                                                v_appendstr  => '【质检确认】结果必须为通过！',
                                                v_middliestr => chr(10));
    END IF;
  
    IF v_inp_firstcheckamount IS NULL THEN
      v_errinfo := scmdata.f_sentence_append_rc(v_sentence   => v_errinfo,
                                                v_appendstr  => '【首抽件数】不能为空！',
                                                v_middliestr => chr(10));
    ELSIF v_inp_firstcheckamount <= 0 THEN
      v_errinfo := scmdata.f_sentence_append_rc(v_sentence   => v_errinfo,
                                                v_appendstr  => '【首抽件数】必须大于0！',
                                                v_middliestr => chr(10));
    ELSE
      IF v_inp_pcomeamount < v_inp_firstcheckamount THEN
        v_errinfo := scmdata.f_sentence_append_rc(v_sentence   => v_errinfo,
                                                  v_appendstr  => '【首抽件数】必须小于/等于【预计到仓数量】！',
                                                  v_middliestr => chr(10));
      END IF;
    END IF;
  
    IF v_inp_checkdate IS NULL THEN
      v_errinfo := scmdata.f_sentence_append_rc(v_sentence   => v_errinfo,
                                                v_appendstr  => '【质检日期】不能为空！',
                                                v_middliestr => chr(10));
    END IF;
  
    IF v_inp_checkuserids IS NULL THEN
      v_errinfo := scmdata.f_sentence_append_rc(v_sentence   => v_errinfo,
                                                v_appendstr  => '【查货员】不能为空！',
                                                v_middliestr => chr(10));
    ELSE
      v_errinfo := scmdata.f_sentence_append_rc(v_sentence   => v_errinfo,
                                                v_appendstr  => f_check_checkersnotinqagroup(v_inp_checkers => v_inp_checkuserids,
                                                                                             v_inp_compid   => v_inp_compid),
                                                v_middliestr => chr(10));
    END IF;
  
    RETURN v_errinfo;
  END f_batchpassqarep_valuecheck;

  /*=============================================================================
  
     包：
       pkg_qa_lc(qa逻辑链包)
  
     过程名:
       批量生成合格报告
  
     入参:
       v_inp_qarepids          :  多个质检报告id，由分号分隔
       v_inp_checkresult       :  质检确认结果
       v_inp_firstcheckamount  :  首抽件数
       v_inp_checkdate         :  质检日期
       v_inp_checkuserids      :  质检确认人员
       v_inp_curuserid         :  当前操作人id
       v_inp_compid            :  企业id
  
  
     版本:
       2022-10-19_zc314 : 批量生成合格报告
  
  ==============================================================================*/
  PROCEDURE p_batch_passqarep(v_inp_qarepids         IN CLOB,
                              v_inp_checkresult      IN VARCHAR2,
                              v_inp_firstcheckamount IN NUMBER,
                              v_inp_checkdate        IN DATE,
                              v_inp_checkuserids     IN VARCHAR2,
                              v_inp_curuserid        IN VARCHAR2,
                              v_inp_compid           IN VARCHAR2) IS
    v_jugnum          NUMBER(1);
    v_pcomeamount     NUMBER(8);
    v_errinfo         CLOB;
    v_selfdescription VARCHAR2(1024) := 'scmdata.pkg_qa_lc.p_batch_passqarep';
  BEGIN
    --校验选中质检报告数量是否超出限制
    v_jugnum := scmdata.pkg_qa_ld.f_is_cloblengthlessorequalfourk(v_inp_clob      => v_inp_qarepids,
                                                                  v_inp_invokeobj => v_selfdescription);
  
    --选中报告数量超出限制
    IF v_jugnum = 0 THEN
      --报错
      raise_application_error(-20002, '选中报告数量超出限制！');
    END IF;
  
    --输入值校验
    FOR i IN (SELECT regexp_substr(v_inp_qarepids, '[^;]+', 1, LEVEL) qa_report_id
                FROM dual
              CONNECT BY LEVEL <= regexp_count(v_inp_qarepids, '\;') + 1) LOOP
      --获取qa报告预计到仓数量
      v_pcomeamount := scmdata.pkg_qa_da.f_get_qareppcomeamount(v_inp_qarepid => i.qa_report_id,
                                                                v_inp_compid  => v_inp_compid);
    
      --校验并返回错误信息
      v_errinfo := scmdata.pkg_qa_lc.f_batchpassqarep_valuecheck(v_inp_qarepid          => i.qa_report_id,
                                                                 v_inp_checkresult      => v_inp_checkresult,
                                                                 v_inp_pcomeamount      => v_pcomeamount,
                                                                 v_inp_firstcheckamount => v_inp_firstcheckamount,
                                                                 v_inp_checkdate        => v_inp_checkdate,
                                                                 v_inp_checkuserids     => v_inp_checkuserids,
                                                                 v_inp_compid           => v_inp_compid);
    
      --错误信息不为空
      IF v_errinfo IS NOT NULL THEN
        --报错
        raise_application_error(-20002,
                                '质检报告编号:' || i.qa_report_id || chr(10) ||
                                v_errinfo);
      END IF;
    END LOOP;
  
    --更新Qa质检报告: 质检结果，查货日期，查货员，更新人，更新时间
    scmdata.pkg_qa_ld.p_upd_batchqarepinfo(v_inp_qarepids     => v_inp_qarepids,
                                           v_inp_compid       => v_inp_compid,
                                           v_inp_checkresult  => v_inp_checkresult,
                                           v_inp_checkdate    => v_inp_checkdate,
                                           v_inp_checkuserids => v_inp_checkuserids,
                                           v_inp_curuserid    => v_inp_curuserid,
                                           v_inp_invokeobj    => v_selfdescription);
  
    --更新 Qa质检报告 首抽件数
    scmdata.pkg_qa_ld.p_upd_qarepfirstsamplingamount(v_inp_qarepids         => v_inp_qarepids,
                                                     v_inp_compid           => v_inp_compid,
                                                     v_inp_firstcheckamount => v_inp_firstcheckamount,
                                                     v_inp_curuserid        => v_inp_curuserid,
                                                     v_inp_invokeobj        => v_selfdescription);
  END p_batch_passqarep;

  /*=============================================================================
  
     包：
       pkg_qa_lc(QA逻辑链包)
  
     函数名:
       质检报告更新--值校验
  
     入参:
       v_inp_qarepid               :  质检报告Id
       v_inp_compid                :  企业Id
       v_inp_firstsamplingamount   :  首抽件数
       v_inp_checkers              :  查货员
       v_inp_checkdate             :  质检日期
       v_inp_checkresult           :  质检结果
       v_inp_problemdescription    :  问题描述
       v_inp_reviewcomments        :  审核意见
       v_inp_problemclassification :  问题分类
       v_inp_unqualsamplingamount  :  不合格数
       v_inp_yyresult              :  样衣核对-核对结果
       v_inp_yyuqualsubjects       :  样衣核对-不合格项
       v_inp_mflresult             :  面辅料查验-查验结果
       v_inp_mfluqualsubjects      :  面辅料查验-不合格项
       v_inp_gyresult              :  工艺查验-查验结果
       v_inp_gyuqualsubjects       :  工艺查验-不合格项
       v_inp_bxresult              :  版型查验-查验结果
       v_inp_bxuqualsubjects       :  版型查验-不合格项
       v_inp_scaleamount           :  度尺件数
  
     版本:
       2022-10-20_ZC314 : 质检报告更新--值校验
       2022-10-21_zc314 : 值校验增加条件校验
       2022-10-26_zc314 : 增加Sku质检结果与报告质检结果一致性校验
       2022-12-15_zc314 : 增加“度尺件数”字段
  
  ==============================================================================*/
  FUNCTION f_check_qareportupd(v_inp_qarepid               IN VARCHAR2,
                               v_inp_compid                IN VARCHAR2,
                               v_inp_firstsamplingamount   IN NUMBER,
                               v_inp_addsamplingamount     IN NUMBER,
                               v_inp_checkers              IN VARCHAR2,
                               v_inp_checkdate             IN DATE,
                               v_inp_checkresult           IN VARCHAR2,
                               v_inp_problemdescription    IN VARCHAR2,
                               v_inp_reviewcomments        IN VARCHAR2,
                               v_inp_problemclassification IN VARCHAR2,
                               v_inp_unqualsamplingamount  IN NUMBER,
                               v_inp_yyresult              IN VARCHAR2,
                               v_inp_yyuqualsubjects       IN VARCHAR2,
                               v_inp_mflresult             IN VARCHAR2,
                               v_inp_mfluqualsubjects      IN VARCHAR2,
                               v_inp_gyresult              IN VARCHAR2,
                               v_inp_gyuqualsubjects       IN VARCHAR2,
                               v_inp_bxresult              IN VARCHAR2,
                               v_inp_bxuqualsubjects       IN VARCHAR2,
                               v_inp_scaleamount           IN NUMBER)
    RETURN CLOB IS
    v_errinfo            CLOB;
    v_qarepstatus        VARCHAR2(8);
    v_checkresult        VARCHAR2(8);
    v_problemdescription VARCHAR2(4000);
    v_pcomeamount        NUMBER(8);
    v_reviewcomments     VARCHAR2(512);
  BEGIN
    --非条件校验---------------------------------------------------------------------------
    --首抽件数非空校验
    IF v_inp_firstsamplingamount IS NULL THEN
      v_errinfo := scmdata.f_sentence_append_rc(v_sentence   => v_errinfo,
                                                v_appendstr  => '【首抽件数】不能为空！',
                                                v_middliestr => chr(10));
    END IF;
  
    --首抽件数+加抽件数不能超过预计到仓数量校验
    --获取预计到仓数量
    v_pcomeamount := scmdata.pkg_qa_da.f_get_qareppcomeamount(v_inp_qarepid => v_inp_qarepid,
                                                              v_inp_compid  => v_inp_compid);
  
    IF (nvl(v_inp_firstsamplingamount, 0) + nvl(v_inp_addsamplingamount, 0)) >
       v_pcomeamount THEN
      v_errinfo := scmdata.f_sentence_append_rc(v_sentence   => v_errinfo,
                                                v_appendstr  => '【抽查总件数】不能超过【预计到仓数量】！',
                                                v_middliestr => chr(10));
    END IF;
  
    --不合格件数校验
    IF (nvl(v_inp_firstsamplingamount, 0) + nvl(v_inp_addsamplingamount, 0)) <
       v_inp_unqualsamplingamount THEN
      v_errinfo := scmdata.f_sentence_append_rc(v_sentence   => v_errinfo,
                                                v_appendstr  => '【不合格数】不能超过【抽查总件数】！',
                                                v_middliestr => chr(10));
    END IF;
  
    --查货员非空校验
    IF v_inp_checkers IS NULL THEN
      v_errinfo := scmdata.f_sentence_append_rc(v_sentence   => v_errinfo,
                                                v_appendstr  => '【查货员】不能为空！',
                                                v_middliestr => chr(10));
    END IF;
  
    --质检日期非空校验
    IF v_inp_checkdate IS NULL THEN
      v_errinfo := scmdata.f_sentence_append_rc(v_sentence   => v_errinfo,
                                                v_appendstr  => '【质检日期】不能为空！',
                                                v_middliestr => chr(10));
    END IF;
  
    --质检结果非空校验
    IF v_inp_checkresult IS NULL THEN
      v_errinfo := scmdata.f_sentence_append_rc(v_sentence   => v_errinfo,
                                                v_appendstr  => '【质检结果】不能为空！',
                                                v_middliestr => chr(10));
    END IF;
  
    --条件校验---------------------------------------------------------------------------
    --获取质检报告状态
    v_qarepstatus := scmdata.pkg_qa_da.f_get_qarepstatus(v_inp_qarepid => v_inp_qarepid,
                                                         v_inp_compid  => v_inp_compid);
  
    --获取质检报告-质检结果，问题描述，审核意见字段
    scmdata.pkg_qa_da.p_get_qarepcondcheckfields(v_inp_qarepid             => v_inp_qarepid,
                                                 v_inp_compid              => v_inp_compid,
                                                 v_iop_checkresult         => v_checkresult,
                                                 v_iop_problemdescriptions => v_problemdescription,
                                                 v_iop_reviewcomments      => v_reviewcomments);
  
    --质检结果校验
    IF v_qarepstatus IN ('PE', 'AF')
       AND nvl(v_checkresult, ' ') <> nvl(v_inp_checkresult, ' ') THEN
      v_errinfo := scmdata.f_sentence_append_rc(v_sentence   => v_errinfo,
                                                v_appendstr  => '在【质检结果审核】之后，【质检结果】字段不可再编辑修改！',
                                                v_middliestr => chr(10));
    END IF;
  
    --问题描述校验
    IF v_qarepstatus <> 'PC'
       AND
       nvl(v_problemdescription, ' ') <> nvl(v_inp_problemdescription, ' ') THEN
      v_errinfo := scmdata.f_sentence_append_rc(v_sentence   => v_errinfo,
                                                v_appendstr  => '非【待检任务】页面进入质检报告不能修改【问题描述】字段！',
                                                v_middliestr => chr(10));
    END IF;
  
    --审核意见校验
    IF v_qarepstatus <> 'PA'
       AND nvl(v_reviewcomments, ' ') <> nvl(v_inp_reviewcomments, ' ') THEN
      v_errinfo := scmdata.f_sentence_append_rc(v_sentence   => v_errinfo,
                                                v_appendstr  => '仅限【待审核报告】页面【质检结果审核】前质检报告才可修改【审核意见】',
                                                v_middliestr => chr(10));
    END IF;
  
    --质检结果为部分通过/整批不通过时
    IF v_inp_checkresult IN ('ANP', 'PNP') THEN
      --问题分类校验
      IF v_inp_problemclassification IS NULL THEN
        v_errinfo := scmdata.f_sentence_append_rc(v_sentence   => v_errinfo,
                                                  v_appendstr  => '当质检报告结果为【整批不合格】或【部分不合格】时，【问题分类】必填！',
                                                  v_middliestr => chr(10));
      END IF;
    
      --问题描述校验
      IF v_inp_problemdescription IS NULL
         AND v_qarepstatus = 'PC' THEN
        v_errinfo := scmdata.f_sentence_append_rc(v_sentence   => v_errinfo,
                                                  v_appendstr  => '当质检报告结果为【整批不合格】或【部分不合格】时，【问题描述】必填！',
                                                  v_middliestr => chr(10));
      END IF;
    
      --不合格数校验
      IF v_inp_unqualsamplingamount IS NULL THEN
        v_errinfo := scmdata.f_sentence_append_rc(v_sentence   => v_errinfo,
                                                  v_appendstr  => '当质检报告结果为【整批不合格】或【部分不合格】时，【不合格数】必填！',
                                                  v_middliestr => chr(10));
      END IF;
    
      --样衣核对-核对结果校验
      IF v_inp_yyresult IS NULL THEN
        v_errinfo := scmdata.f_sentence_append_rc(v_sentence   => v_errinfo,
                                                  v_appendstr  => '当质检报告结果为【整批不合格】或【部分不合格】时，【样衣核对-核对结果】必填！',
                                                  v_middliestr => chr(10));
      END IF;
    
      --面辅料查验-查验结果校验
      IF v_inp_mflresult IS NULL THEN
        v_errinfo := scmdata.f_sentence_append_rc(v_sentence   => v_errinfo,
                                                  v_appendstr  => '当质检报告结果为【整批不合格】或【部分不合格】时，【面辅料查验-查验结果】必填！',
                                                  v_middliestr => chr(10));
      END IF;
    
      --工艺查验-查验结果校验
      IF v_inp_gyresult IS NULL THEN
        v_errinfo := scmdata.f_sentence_append_rc(v_sentence   => v_errinfo,
                                                  v_appendstr  => '当质检报告结果为【整批不合格】或【部分不合格】时，【工艺查验-查验结果】必填！',
                                                  v_middliestr => chr(10));
      END IF;
    
      --版型查验-查验结果校验
      IF v_inp_bxresult IS NULL THEN
        v_errinfo := scmdata.f_sentence_append_rc(v_sentence   => v_errinfo,
                                                  v_appendstr  => '当质检报告结果为【整批不合格】或【部分不合格】时，【版型查验-查验结果】必填！',
                                                  v_middliestr => chr(10));
      END IF;
    
    END IF;
  
    --样衣核对-不符合项校验
    IF v_inp_yyresult = 'UQ'
       AND v_inp_yyuqualsubjects IS NULL THEN
      v_errinfo := scmdata.f_sentence_append_rc(v_sentence   => v_errinfo,
                                                v_appendstr  => '当【样衣核对】查验不合格，不合格项不可为空！',
                                                v_middliestr => chr(10));
    END IF;
  
    --面辅料查验-不符合项校验
    IF v_inp_mflresult = 'UQ'
       AND v_inp_mfluqualsubjects IS NULL THEN
      v_errinfo := scmdata.f_sentence_append_rc(v_sentence   => v_errinfo,
                                                v_appendstr  => '当【面辅料查验】不合格，不合格项不可为空！',
                                                v_middliestr => chr(10));
    END IF;
  
    --工艺查验-不符合项校验
    IF v_inp_gyresult = 'UQ'
       AND v_inp_gyuqualsubjects IS NULL THEN
      v_errinfo := scmdata.f_sentence_append_rc(v_sentence   => v_errinfo,
                                                v_appendstr  => '当【工艺查验】不合格，不合格项不可为空！',
                                                v_middliestr => chr(10));
    END IF;
  
    --版型查验-不符合项校验
    IF v_inp_bxresult = 'UQ'
       AND v_inp_bxuqualsubjects IS NULL THEN
      v_errinfo := scmdata.f_sentence_append_rc(v_sentence   => v_errinfo,
                                                v_appendstr  => '当【版型查验】不合格，不合格项不可为空！',
                                                v_middliestr => chr(10));
    END IF;
  
    --度尺件数校验
    IF nvl(v_inp_scaleamount, 0) >
       (nvl(v_inp_firstsamplingamount, 0) + nvl(v_inp_addsamplingamount, 0)) THEN
      v_errinfo := scmdata.f_sentence_append_rc(v_sentence   => v_errinfo,
                                                v_appendstr  => '【度尺件数】不能超过【抽查总件数】！',
                                                v_middliestr => chr(10));
    END IF;
  
    RETURN v_errinfo;
  END f_check_qareportupd;

  /*=============================================================================
  
     包：
       pkg_qa_lc(qa逻辑链包)
  
     过程名:
       Qa质检报告编辑页面--更新质检报告
  
     入参:
       v_inp_qarepid                 :  Qa质检报告Id
       v_inp_compid                  :  企业Id
       v_inp_checkers                :  查货员
       v_inp_checkdate               :  质检日期
       v_inp_checkresult             :  质检结果
       v_inp_problemclassification   :  问题分类
       v_inp_problemdescription      :  问题描述
       v_inp_reviewcomments          :  审核意见
       v_inp_memo                    :  备注
       v_inp_qualattachment          :  质检附件
       v_inp_reviewattachment        :  批复附件
       v_inp_firstsamplingamount     :  首抽件数
       v_inp_addsamplingamount       :  加抽件数
       v_inp_unqualsamplingamount    :  不合格件数
       v_inp_yyresult                :  样衣核对结果
       v_inp_yyuqualsubjects         :  样衣不合格项
       v_inp_mflresult               :  面辅料查验结果
       v_inp_mfluqualsubjects        :  面辅料不合格项
       v_inp_gyresult                :  工艺查验结果
       v_inp_gyuqualsubjects         :  工艺不合格项
       v_inp_bxresult                :  版型查验结果
       v_inp_bxuqualsubjects         :  版型不合格项
       v_inp_curuserid               :  当前操作人Id
  
     版本:
       2022-10-20_zc314 : Qa质检报告编辑页面--更新质检报告
       2022-10-21_zc314 : 值校验增加条件校验
       2022-12-15_zc314 : 增加“度尺件数”字段
  
  ==============================================================================*/
  PROCEDURE p_upd_qareport(v_inp_qarepid               IN VARCHAR2,
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
                           v_inp_firstsamplingamount   IN NUMBER,
                           v_inp_addsamplingamount     IN NUMBER,
                           v_inp_unqualsamplingamount  IN NUMBER,
                           v_inp_yyresult              IN VARCHAR2,
                           v_inp_yyuqualsubjects       IN VARCHAR2,
                           v_inp_mflresult             IN VARCHAR2,
                           v_inp_mfluqualsubjects      IN VARCHAR2,
                           v_inp_gyresult              IN VARCHAR2,
                           v_inp_gyuqualsubjects       IN VARCHAR2,
                           v_inp_bxresult              IN VARCHAR2,
                           v_inp_bxuqualsubjects       IN VARCHAR2,
                           v_inp_scaleamount           IN NUMBER,
                           v_inp_curuserid             IN VARCHAR2) IS
    v_errinfo         CLOB;
    v_selfdescription VARCHAR2(1024) := 'scmdata.pkg_qa_lc.p_upd_qareport';
  BEGIN
    --值校验
    v_errinfo := f_check_qareportupd(v_inp_qarepid               => v_inp_qarepid,
                                     v_inp_compid                => v_inp_compid,
                                     v_inp_firstsamplingamount   => v_inp_firstsamplingamount,
                                     v_inp_addsamplingamount     => v_inp_addsamplingamount,
                                     v_inp_checkers              => v_inp_checkers,
                                     v_inp_checkdate             => v_inp_checkdate,
                                     v_inp_checkresult           => v_inp_checkresult,
                                     v_inp_problemdescription    => v_inp_problemdescription,
                                     v_inp_reviewcomments        => v_inp_reviewcomments,
                                     v_inp_problemclassification => v_inp_problemclassification,
                                     v_inp_unqualsamplingamount  => v_inp_unqualsamplingamount,
                                     v_inp_yyresult              => v_inp_yyresult,
                                     v_inp_yyuqualsubjects       => v_inp_yyuqualsubjects,
                                     v_inp_mflresult             => v_inp_mflresult,
                                     v_inp_mfluqualsubjects      => v_inp_mfluqualsubjects,
                                     v_inp_gyresult              => v_inp_gyresult,
                                     v_inp_gyuqualsubjects       => v_inp_gyuqualsubjects,
                                     v_inp_bxresult              => v_inp_bxresult,
                                     v_inp_bxuqualsubjects       => v_inp_bxuqualsubjects,
                                     v_inp_scaleamount           => v_inp_scaleamount);
  
    --错误信息非空
    IF v_errinfo IS NOT NULL THEN
      --报错
      raise_application_error(-20002, v_errinfo);
    END IF;
  
    --更新Qa质检报告
    scmdata.pkg_qa_ld.p_upd_qarepinfoinreppage(v_inp_qarepid               => v_inp_qarepid,
                                               v_inp_compid                => v_inp_compid,
                                               v_inp_checkers              => v_inp_checkers,
                                               v_inp_checkdate             => v_inp_checkdate,
                                               v_inp_checkresult           => v_inp_checkresult,
                                               v_inp_problemclassification => v_inp_problemclassification,
                                               v_inp_problemdescription    => v_inp_problemdescription,
                                               v_inp_reviewcomments        => v_inp_reviewcomments,
                                               v_inp_memo                  => v_inp_memo,
                                               v_inp_qualattachment        => v_inp_qualattachment,
                                               v_inp_reviewattachment      => v_inp_reviewattachment,
                                               v_inp_curuserid             => v_inp_curuserid,
                                               v_inp_invokeobj             => v_selfdescription);
  
    --更新Qa数量维度表
    scmdata.pkg_qa_ld.p_upd_qarepnumdiminreppage(v_inp_qarepid              => v_inp_qarepid,
                                                 v_inp_compid               => v_inp_compid,
                                                 v_inp_firstsamplingamount  => v_inp_firstsamplingamount,
                                                 v_inp_addsamplingamount    => v_inp_addsamplingamount,
                                                 v_inp_unqualsamplingamount => v_inp_unqualsamplingamount,
                                                 v_inp_curuserid            => v_inp_curuserid,
                                                 v_inp_invokeobj            => v_selfdescription);
  
    --更新Qa质检细节维度表
    scmdata.pkg_qa_ld.p_upd_qarepcheckdetaildiminreppage(v_inp_qarepid          => v_inp_qarepid,
                                                         v_inp_compid           => v_inp_compid,
                                                         v_inp_yyresult         => v_inp_yyresult,
                                                         v_inp_yyuqualsubjects  => v_inp_yyuqualsubjects,
                                                         v_inp_mflresult        => v_inp_mflresult,
                                                         v_inp_mfluqualsubjects => v_inp_mfluqualsubjects,
                                                         v_inp_gyresult         => v_inp_gyresult,
                                                         v_inp_gyuqualsubjects  => v_inp_gyuqualsubjects,
                                                         v_inp_bxresult         => v_inp_bxresult,
                                                         v_inp_bxuqualsubjects  => v_inp_bxuqualsubjects,
                                                         v_inp_scaleamount      => v_inp_scaleamount,
                                                         v_inp_curuserid        => v_inp_curuserid,
                                                         v_inp_invokeobj        => v_selfdescription);
  END p_upd_qareport;

  /*=============================================================================
  
     包：
       pkg_qa_lc(qa逻辑链包)
  
     过程名:
       质检减数-更新逻辑
  
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
  
     版本:
       2022-10-24_zc314 : 质检减数-更新逻辑
  
  ==============================================================================*/
  PROCEDURE p_upd_qualdecrerela(v_inp_qarepid         IN VARCHAR2,
                                v_inp_compid          IN VARCHAR2,
                                v_inp_asnid           IN VARCHAR2,
                                v_inp_gooid           IN VARCHAR2,
                                v_inp_barcode         IN VARCHAR2,
                                v_inp_defectiveamount IN NUMBER,
                                v_inp_washlessamount  IN NUMBER,
                                v_inp_otherlessamount IN NUMBER,
                                v_inp_curuserid       IN VARCHAR2) IS
    v_status          VARCHAR2(8);
    v_checknumber     NUMBER(8);
    v_selfdescription VARCHAR2(1024) := 'scmdata.pkg_qa_lc.p_upd_qualdecrerela';
  BEGIN
    --获取报告状态
    v_status := scmdata.pkg_qa_da.f_get_qarepskustatus(v_inp_qarepid => v_inp_qarepid,
                                                       v_inp_compid  => v_inp_compid,
                                                       v_inp_asnid   => v_inp_asnid,
                                                       v_inp_gooid   => v_inp_gooid,
                                                       v_inp_barcode => v_inp_barcode);
  
    --当报告状态=已完成，质检减数不能操作保存
    IF v_status = 'AF' THEN
      raise_application_error(-20002,
                              '质检报告Sku状态为【已完成】，不能操作质检减数！');
    END IF;
  
    --获取校验数值
    v_checknumber := scmdata.pkg_qa_da.f_get_checkamountbysku(v_inp_qarepid => v_inp_qarepid,
                                                              v_inp_compid  => v_inp_compid,
                                                              v_inp_asnid   => v_inp_asnid,
                                                              v_inp_gooid   => v_inp_gooid,
                                                              v_inp_barcode => v_inp_barcode);
  
    --判断是否大于校验数值
    IF v_checknumber <
       nvl(v_inp_defectiveamount, 0) + nvl(v_inp_washlessamount, 0) +
       nvl(v_inp_otherlessamount, 0) THEN
      raise_application_error(-20002,
                              '质检减数大于Sku收货数量/预计到仓数量');
    ELSE
      --更新Sku质检减数相关数据
      scmdata.pkg_qa_ld.p_upd_qualdecrerela(v_inp_qarepid         => v_inp_qarepid,
                                            v_inp_compid          => v_inp_compid,
                                            v_inp_asnid           => v_inp_asnid,
                                            v_inp_gooid           => v_inp_gooid,
                                            v_inp_barcode         => v_inp_barcode,
                                            v_inp_defectiveamount => v_inp_defectiveamount,
                                            v_inp_washlessamount  => v_inp_washlessamount,
                                            v_inp_otherlessamount => v_inp_otherlessamount,
                                            v_inp_curuserid       => v_inp_curuserid,
                                            v_inp_invokeobj       => v_selfdescription);
    
      --更新质检报告质检减数
      scmdata.pkg_qa_ld.p_upd_qarepdecreamount(v_inp_qarepid   => v_inp_qarepid,
                                               v_inp_compid    => v_inp_compid,
                                               v_inp_curuserid => v_inp_curuserid,
                                               v_inp_invokeobj => v_selfdescription);
    END IF;
  END p_upd_qualdecrerela;

  /*=============================================================================
  
     包：
       pkg_qa_lc(QA逻辑链包)
  
     函数名:
       质检报告报告级质检结果与不合格明细一致性校验
  
     入参:
       v_inp_qarepid    :  质检报告Id
       v_inp_compid     :  企业Id
       v_inp_curuserid  :  当前操作人Id
  
     版本:
       2022-10-24_ZC314 : 质检报告报告级质检结果与不合格明细一致性校验
  
  ==============================================================================*/
  PROCEDURE p_check_qarepcheckresultconsistent(v_inp_qarepid   IN VARCHAR2,
                                               v_inp_compid    IN VARCHAR2,
                                               v_inp_curuserid IN VARCHAR2) IS
    v_checkresult       VARCHAR2(8);
    v_skucheckresultnum NUMBER(4);
    v_errinfo           CLOB;
    v_selfdescription   VARCHAR2(1024) := 'scmdata.pkg_qa_lc.p_check_qarepcheckresultconsistent';
  BEGIN
    --获取质检结果
    v_checkresult := scmdata.pkg_qa_da.f_get_qarepcheckresult(v_inp_qarepid => v_inp_qarepid,
                                                              v_inp_compid  => v_inp_compid);
  
    --质检结果为空
    IF v_checkresult IS NULL THEN
      --报错
      raise_application_error(-20002,
                              '质检报告报告级质检结果与不合格明细一致性校验中报告级质检确认结果为空！');
    ELSE
      --当报告质检结果为【整批不通过】,更新Sku维度质检结果为不通过
      IF v_checkresult = 'ANP' THEN
        scmdata.pkg_qa_ld.p_upd_allskucheckresult(v_inp_qarepid        => v_inp_qarepid,
                                                  v_inp_compid         => v_inp_compid,
                                                  v_inp_skucheckresult => 'NP',
                                                  v_inp_curuserid      => v_inp_curuserid,
                                                  v_inp_invokeobj      => v_selfdescription);
      
        --更新报告Sku不合格数量
        FOR i IN (SELECT DISTINCT asn_id,
                                  goo_id,
                                  barcode,
                                  company_id,
                                  qa_report_id
                    FROM scmdata.t_qa_report_skudim
                   WHERE qa_report_id = v_inp_qarepid
                     AND company_id = v_inp_compid) LOOP
          scmdata.pkg_qa_ld.p_upd_qarepskuunqualamount(v_inp_qarepid   => i.qa_report_id,
                                                       v_inp_compid    => i.company_id,
                                                       v_inp_asnid     => i.asn_id,
                                                       v_inp_gooid     => i.goo_id,
                                                       v_inp_barcode   => i.barcode,
                                                       v_inp_curuserid => v_inp_curuserid,
                                                       v_inp_invokeobj => v_selfdescription);
        END LOOP;
      
        --更新报告不合格数量
        scmdata.pkg_qa_ld.p_upd_qarepunqualamount(v_inp_qarepid   => v_inp_qarepid,
                                                  v_inp_compid    => v_inp_compid,
                                                  v_inp_curuserid => v_inp_curuserid,
                                                  v_inp_invokeobj => v_selfdescription);
      ELSIF v_checkresult = 'APS' THEN
        scmdata.pkg_qa_ld.p_upd_allskucheckresult(v_inp_qarepid        => v_inp_qarepid,
                                                  v_inp_compid         => v_inp_compid,
                                                  v_inp_skucheckresult => 'PS',
                                                  v_inp_curuserid      => v_inp_curuserid,
                                                  v_inp_invokeobj      => v_selfdescription);
      
        --更新报告Sku不合格数量
        FOR l IN (SELECT DISTINCT asn_id,
                                  goo_id,
                                  barcode,
                                  company_id,
                                  qa_report_id
                    FROM scmdata.t_qa_report_skudim
                   WHERE qa_report_id = v_inp_qarepid
                     AND company_id = v_inp_compid) LOOP
          scmdata.pkg_qa_ld.p_upd_qarepskuunqualamount(v_inp_qarepid   => l.qa_report_id,
                                                       v_inp_compid    => l.company_id,
                                                       v_inp_asnid     => l.asn_id,
                                                       v_inp_gooid     => l.goo_id,
                                                       v_inp_barcode   => l.barcode,
                                                       v_inp_curuserid => v_inp_curuserid,
                                                       v_inp_invokeobj => v_selfdescription);
        END LOOP;
      
        --更新报告不合格数量
        scmdata.pkg_qa_ld.p_upd_qarepunqualamount(v_inp_qarepid   => v_inp_qarepid,
                                                  v_inp_compid    => v_inp_compid,
                                                  v_inp_curuserid => v_inp_curuserid,
                                                  v_inp_invokeobj => v_selfdescription);
      END IF;
    
      --获取Sku质检结果唯一数量及sku质检结果最大值
      v_skucheckresultnum := scmdata.pkg_qa_da.f_get_qarepskucheckresultcount(v_inp_qarepid => v_inp_qarepid,
                                                                              v_inp_compid  => v_inp_compid);
    
      --如果Sku质检结果唯一值等于1
      IF v_skucheckresultnum <= 1
         AND v_checkresult = 'PNP' THEN
        v_errinfo := '当报告质检确认结果必须为【部分不合格】时，Sku质检结果必须包含合格与不合格2种结果！';
      END IF;
    
      --当错误信息不为空时
      IF v_errinfo IS NOT NULL THEN
        --报错
        raise_application_error(-20002, v_errinfo);
      END IF;
    END IF;
  END p_check_qarepcheckresultconsistent;

  /*=============================================================================
  
     包：
       pkg_qa_lc(qa逻辑链包)
  
     过程名:
       Qa质检报告信息校验
  
     入参:
       v_inp_qarepid    :  质检报告Id
       v_inp_compid     :  企业Id
       v_inp_curuserid  :  当前操作人Id
  
     版本:
       2022-10-26_zc314 : Qa质检报告信息校验
  
  ==============================================================================*/
  PROCEDURE p_check_qareportinfo(v_inp_qarepid   IN VARCHAR2,
                                 v_inp_compid    IN VARCHAR2,
                                 v_inp_curuserid IN VARCHAR2) IS
    v_sql                   CLOB;
    v_firstsamplingamount   NUMBER(8);
    v_addsamplingamount     NUMBER(8);
    v_checkers              VARCHAR2(1024);
    v_checkdate             DATE;
    v_checkresult           VARCHAR2(8);
    v_problemdescription    VARCHAR2(4000);
    v_problemclassification VARCHAR2(32);
    v_unqualsamplingamount  NUMBER(8);
    v_yyresult              VARCHAR2(8);
    v_yyunqualsubjects      VARCHAR2(32);
    v_mflresult             VARCHAR2(8);
    v_mflunqualsubjects     VARCHAR2(32);
    v_gyresult              VARCHAR2(8);
    v_gyunqualsubjects      VARCHAR2(32);
    v_bxresult              VARCHAR2(8);
    v_bxunqualsubjects      VARCHAR2(32);
    v_reviewcomments        VARCHAR2(512);
    v_scaleamount           NUMBER(8);
    v_errinfo               CLOB;
    v_selfdescription       VARCHAR2(1024) := 'scmdata.pkg_qa_lc.p_commit_qarep';
  BEGIN
    --值校验
    --值数据 sql获取
    v_sql := scmdata.pkg_qa_ld.f_get_commitchecksql(v_inp_invokeobj => v_selfdescription);
  
    --获取值
    EXECUTE IMMEDIATE v_sql
      INTO v_firstsamplingamount, v_addsamplingamount, v_checkers, v_checkdate, v_checkresult, v_problemdescription, v_reviewcomments, v_problemclassification, v_unqualsamplingamount, v_yyresult, v_yyunqualsubjects, v_mflresult, v_mflunqualsubjects, v_gyresult, v_gyunqualsubjects, v_bxresult, v_bxunqualsubjects, v_scaleamount
      USING v_inp_qarepid, v_inp_compid;
  
    --值校验
    v_errinfo := f_check_qareportupd(v_inp_qarepid               => v_inp_qarepid,
                                     v_inp_compid                => v_inp_compid,
                                     v_inp_firstsamplingamount   => v_firstsamplingamount,
                                     v_inp_addsamplingamount     => v_addsamplingamount,
                                     v_inp_checkers              => v_checkers,
                                     v_inp_checkdate             => v_checkdate,
                                     v_inp_checkresult           => v_checkresult,
                                     v_inp_problemdescription    => v_problemdescription,
                                     v_inp_reviewcomments        => v_reviewcomments,
                                     v_inp_problemclassification => v_problemclassification,
                                     v_inp_unqualsamplingamount  => v_unqualsamplingamount,
                                     v_inp_yyresult              => v_yyresult,
                                     v_inp_yyuqualsubjects       => v_yyunqualsubjects,
                                     v_inp_mflresult             => v_mflresult,
                                     v_inp_mfluqualsubjects      => v_mflunqualsubjects,
                                     v_inp_gyresult              => v_gyresult,
                                     v_inp_gyuqualsubjects       => v_gyunqualsubjects,
                                     v_inp_bxresult              => v_bxresult,
                                     v_inp_bxuqualsubjects       => v_bxunqualsubjects,
                                     v_inp_scaleamount           => v_scaleamount);
  
    --如果错误信息不为空
    IF v_errinfo IS NOT NULL THEN
      --报错
      raise_application_error(-20002, v_errinfo);
    END IF;
  
    --质检结果=合格/部分不合格/整批不合格时，不合格明细内数据相符
    p_check_qarepcheckresultconsistent(v_inp_qarepid   => v_inp_qarepid,
                                       v_inp_compid    => v_inp_compid,
                                       v_inp_curuserid => v_inp_curuserid);
  END p_check_qareportinfo;

  /*=============================================================================
  
     包：
       pkg_qa_lc(qa逻辑链包)
  
     过程名:
       qa质检报告编辑页面--质检报告提交
  
     入参:
       v_inp_qarepid    :  质检报告Id
       v_inp_compid     :  企业Id
       v_inp_curuserid  :  当前操作人Id
  
     版本:
       2022-10-24_zc314 : qa质检报告编辑页面--质检报告提交
       2022-10-26_zc314 : 因Qa质检报告信息校验提取为存储过程修改
  
  ==============================================================================*/
  PROCEDURE p_commit_qarep(v_inp_qarepid   IN VARCHAR2,
                           v_inp_compid    IN VARCHAR2,
                           v_inp_curuserid IN VARCHAR2) IS
    v_selfdescription VARCHAR2(1024) := 'scmdata.pkg_qa_lc.p_commit_qarep';
  BEGIN
    --Qa质检数据校验
    p_check_qareportinfo(v_inp_qarepid   => v_inp_qarepid,
                         v_inp_compid    => v_inp_compid,
                         v_inp_curuserid => v_inp_curuserid);
  
    --提交，记录提交人，提交时间，报告状态修改
    scmdata.pkg_qa_ld.p_upd_qarepcommit(v_inp_qarepid   => v_inp_qarepid,
                                        v_inp_compid    => v_inp_compid,
                                        v_inp_curuserid => v_inp_curuserid,
                                        v_inp_invokeobj => v_selfdescription);
  
    --asn状态修改
    scmdata.pkg_qa_ld.p_upd_qarepasnstatusbyqarepid(v_inp_qarepid   => v_inp_qarepid,
                                                    v_inp_compid    => v_inp_compid,
                                                    v_inp_asnstatus => 'PA',
                                                    v_inp_curuserid => v_inp_curuserid,
                                                    v_inp_invokeobj => v_selfdescription);
  
  END p_commit_qarep;

  /*=============================================================================
  
     包：
       pkg_qa_lc(QA逻辑链包)
  
     函数名:
       Qa质检报告维护不合格处理明细
  
     入参:
       v_inp_qarepid         :  质检报告Id
       v_inp_compid          :  企业Id
       v_inp_asnid           :  Asn单号
       v_inp_gooid           :  商品档案编号
       v_inp_barcode         :  条码
       v_inp_skucheckresult  :  Sku质检结果
       v_inp_curuserid       :  当前操作人Id
  
     版本:
       2022-10-25_ZC314 : Qa质检报告维护不合格处理明细
  
  ==============================================================================*/
  PROCEDURE p_change_qarepunqualdetail(v_inp_qarepid        IN VARCHAR2,
                                       v_inp_compid         IN VARCHAR2,
                                       v_inp_asnid          IN VARCHAR2,
                                       v_inp_gooid          IN VARCHAR2,
                                       v_inp_barcode        IN VARCHAR2,
                                       v_inp_skucheckresult IN VARCHAR2,
                                       v_inp_curuserid      IN VARCHAR2) IS
    v_status          VARCHAR2(8);
    v_selfdescription VARCHAR2(1024) := 'scmdata.pkg_qa_lc.p_change_qarepunqualdetail';
  BEGIN
    --获取质检报告状态
    v_status := scmdata.pkg_qa_da.f_get_qarepstatus(v_inp_qarepid => v_inp_qarepid,
                                                    v_inp_compid  => v_inp_compid);
  
    --当报告状态为【待处理】
    IF v_status = 'PE' THEN
      --报错
      raise_application_error(-20002,
                              '【质检结果审核】后，再进入【QA质检报告编辑-不合格明细】页面，不可添加、删除不合格明细！');
    END IF;
  
    --更新Sku质检结果
    scmdata.pkg_qa_ld.p_upd_qarepskudimcheckresulttonp(v_inp_qarepid        => v_inp_qarepid,
                                                       v_inp_asnid          => v_inp_asnid,
                                                       v_inp_gooid          => v_inp_gooid,
                                                       v_inp_barcode        => v_inp_barcode,
                                                       v_inp_compid         => v_inp_compid,
                                                       v_inp_skucheckresult => v_inp_skucheckresult,
                                                       v_inp_curuserid      => v_inp_curuserid,
                                                       v_inp_invokeobj      => v_selfdescription);
  
    --更新报告Sku不合格数量
    scmdata.pkg_qa_ld.p_upd_qarepskuunqualamount(v_inp_qarepid   => v_inp_qarepid,
                                                 v_inp_compid    => v_inp_compid,
                                                 v_inp_asnid     => v_inp_asnid,
                                                 v_inp_gooid     => v_inp_gooid,
                                                 v_inp_barcode   => v_inp_barcode,
                                                 v_inp_curuserid => v_inp_curuserid,
                                                 v_inp_invokeobj => v_selfdescription);
  
    --更新报告不合格数量
    scmdata.pkg_qa_ld.p_upd_qarepunqualamount(v_inp_qarepid   => v_inp_qarepid,
                                              v_inp_compid    => v_inp_compid,
                                              v_inp_curuserid => v_inp_curuserid,
                                              v_inp_invokeobj => v_selfdescription);
  
    --更新报告修改人，修改时间
    scmdata.pkg_qa_ld.p_upd_qarepupdateidtime(v_inp_qarepid   => v_inp_qarepid,
                                              v_inp_compid    => v_inp_compid,
                                              v_inp_curuserid => v_inp_curuserid,
                                              v_inp_curtime   => SYSDATE,
                                              v_inp_invokeobj => v_selfdescription);
  END p_change_qarepunqualdetail;

  /*=============================================================================
  
     包：
       pkg_qa_lc(qa逻辑链包)
  
     过程名:
       待审核报告--质检结果审核
  
     入参:
       v_inp_qarepid    :  质检报告Id
       v_inp_compid     :  企业Id
       v_inp_curuserid  :  当前操作人Id
  
     需求:
      * 校验
        * 报告质检结果与不合格处理唯一性校验
      * 逻辑
        * 报告质检结果=【合格】，数据操作质检结果审核后：
          * 报告状态为【已完成】
          * Sku状态为【已完成】
          * Sku质检结束时间等于当前时间
        * 报告质检结果=【不合格】，数据操作质检结果审核后
          * 报告状态为【待处理】
  
     版本:
       2022-10-26_zc314 : 待审核报告--质检结果审核
  
  ==============================================================================*/
  PROCEDURE p_review_qareport(v_inp_qarepid   IN VARCHAR2,
                              v_inp_compid    IN VARCHAR2,
                              v_inp_curuserid IN VARCHAR2) IS
    v_checkresult     VARCHAR2(8);
    v_selfdescription VARCHAR2(1024) := 'scmdata.pkg_qa_lc.p_review_qareport';
  BEGIN
    --质检审核数据校验
    scmdata.pkg_qa_ld.p_check_qareprepeatreview(v_inp_qarepid   => v_inp_qarepid,
                                                v_inp_compid    => v_inp_compid,
                                                v_inp_invokeobj => v_selfdescription);
  
    --Qa质检数据校验
    p_check_qareportinfo(v_inp_qarepid   => v_inp_qarepid,
                         v_inp_compid    => v_inp_compid,
                         v_inp_curuserid => v_inp_curuserid);
  
    --质检报告结果取值
    v_checkresult := scmdata.pkg_qa_da.f_get_qarepcheckresult(v_inp_qarepid => v_inp_qarepid,
                                                              v_inp_compid  => v_inp_compid);
  
    --质检报告状态，Asn状态赋值
    IF v_checkresult IN ('PNP', 'ANP') THEN
      --质检报告结果=【不合格】/【部分不合格】
      --更新Sku状态为【待处理】
      scmdata.pkg_qa_ld.p_upd_qarepskureview(v_inp_qarepid   => v_inp_qarepid,
                                             v_inp_compid    => v_inp_compid,
                                             v_inp_curuserid => v_inp_curuserid,
                                             v_inp_invokeobj => v_selfdescription);
    
      --更新质检报告状态为【待处理】
      scmdata.pkg_qa_ld.p_upd_qarepreview(v_inp_qarepid        => v_inp_qarepid,
                                          v_inp_compid         => v_inp_compid,
                                          v_inp_repstatus      => 'PE',
                                          v_inp_processingtype => NULL,
                                          v_inp_curuserid      => v_inp_curuserid,
                                          v_inp_invokeobj      => v_selfdescription);
    
      --asn状态修改
      scmdata.pkg_qa_ld.p_upd_qarepasnstatusbyqarepid(v_inp_qarepid   => v_inp_qarepid,
                                                      v_inp_compid    => v_inp_compid,
                                                      v_inp_asnstatus => 'PEX',
                                                      v_inp_curuserid => v_inp_curuserid,
                                                      v_inp_invokeobj => v_selfdescription);
    
      --数据刷新
      scmdata.pkg_qa_ld.p_upd_qarepskureview(v_inp_qarepid   => v_inp_qarepid,
                                             v_inp_compid    => v_inp_compid,
                                             v_inp_curuserid => v_inp_curuserid,
                                             v_inp_invokeobj => v_selfdescription);
    
      FOR i IN (SELECT DISTINCT qa_report_id, asn_id, company_id
                  FROM scmdata.t_qa_report_skudim
                 WHERE qa_report_id = v_inp_qarepid
                   AND company_id = v_inp_compid
                   AND skucheck_result = 'PS'
                   AND skuprocessing_result IS NULL) LOOP
        --刷新Asn回传结果
        scmdata.pkg_qa_ld.p_refresh_qareptransresult(v_inp_qarepid    => i.qa_report_id,
                                                     v_inp_compid     => i.company_id,
                                                     v_inp_asnid      => i.asn_id,
                                                     v_inp_operuserid => v_inp_curuserid,
                                                     v_inp_invokeobj  => v_selfdescription);
      
        --Asn次品分配进箱
        scmdata.pkg_qa_itf.p_scmtwms_allocatedsubsamountbyrepasn(v_inp_qarepid => i.qa_report_id,
                                                                 v_inp_asnid   => i.asn_id,
                                                                 v_inp_compid  => i.company_id);
      END LOOP;
    ELSE
      --质检报告结果=【合格】
      --更新Sku状态为【已完成】
      scmdata.pkg_qa_ld.p_upd_qarepskureview(v_inp_qarepid   => v_inp_qarepid,
                                             v_inp_compid    => v_inp_compid,
                                             v_inp_curuserid => v_inp_curuserid,
                                             v_inp_invokeobj => v_selfdescription);
    
      --更新质检报告状态为【已完成】
      scmdata.pkg_qa_ld.p_upd_qarepreview(v_inp_qarepid        => v_inp_qarepid,
                                          v_inp_compid         => v_inp_compid,
                                          v_inp_repstatus      => 'AF',
                                          v_inp_processingtype => 'NULL',
                                          v_inp_curuserid      => v_inp_curuserid,
                                          v_inp_invokeobj      => v_selfdescription);
    
      --数据刷新
      FOR i IN (SELECT DISTINCT qa_report_id, asn_id, company_id
                  FROM scmdata.t_qa_report_skudim
                 WHERE qa_report_id = v_inp_qarepid
                   AND company_id = v_inp_compid) LOOP
        --刷新Asn回传结果
        scmdata.pkg_qa_ld.p_refresh_qareptransresult(v_inp_qarepid    => i.qa_report_id,
                                                     v_inp_compid     => i.company_id,
                                                     v_inp_asnid      => i.asn_id,
                                                     v_inp_operuserid => v_inp_curuserid,
                                                     v_inp_invokeobj  => v_selfdescription);
      
        --Asn次品分配进箱
        scmdata.pkg_qa_itf.p_scmtwms_allocatedsubsamountbyrepasn(v_inp_qarepid => i.qa_report_id,
                                                                 v_inp_asnid   => i.asn_id,
                                                                 v_inp_compid  => i.company_id);
      END LOOP;
    
      --更新质检报告主表数据汇总
      scmdata.pkg_qa_ld.p_upd_qarepresumamountrela(v_inp_qarepid   => v_inp_qarepid,
                                                   v_inp_compid    => v_inp_compid,
                                                   v_inp_curuserid => v_inp_curuserid,
                                                   v_inp_invokeobj => v_selfdescription);
    
      --asn状态修改
      scmdata.pkg_qa_ld.p_upd_qarepasnstatusbyqarepid(v_inp_qarepid   => v_inp_qarepid,
                                                      v_inp_compid    => v_inp_compid,
                                                      v_inp_asnstatus => 'FA',
                                                      v_inp_curuserid => v_inp_curuserid,
                                                      v_inp_invokeobj => v_selfdescription);
    
    END IF;
  
    --质检报告Sku状态等于已结束时，补更新Sku质检结束时间为当前时间
    FOR l IN (SELECT qa_report_id, company_id, asn_id, goo_id, barcode
                FROM scmdata.t_qa_report_skudim
               WHERE qa_report_id = v_inp_qarepid
                 AND company_id = v_inp_compid) LOOP
      scmdata.pkg_qa_ld.p_upd_qarepskuqualfinishtime(v_inp_qarepid        => l.qa_report_id,
                                                     v_inp_compid         => l.company_id,
                                                     v_inp_asnid          => l.asn_id,
                                                     v_inp_gooid          => l.goo_id,
                                                     v_inp_barcode        => l.barcode,
                                                     v_inp_qualfinishtime => SYSDATE,
                                                     v_inp_curuserid      => v_inp_curuserid,
                                                     v_inp_invokeobj      => v_selfdescription);
    END LOOP;
  
    --预回传表新增
    p_ins_qarepafinfointopretrans(v_inp_qarepid   => v_inp_qarepid,
                                  v_inp_compid    => v_inp_compid,
                                  v_inp_curuserid => v_inp_curuserid);
  
    --生成已检列表数据
    FOR n IN (SELECT DISTINCT asn_id, company_id
                FROM scmdata.t_qa_report_skudim repskudim
               WHERE EXISTS (SELECT 1
                        FROM scmdata.t_qa_report
                       WHERE qa_report_id = v_inp_qarepid
                         AND company_id = v_inp_compid
                         AND status = 'AF'
                         AND qa_report_id = repskudim.qa_report_id
                         AND company_id = repskudim.company_id)) LOOP
      --生成已检列表数据
      p_iu_qaqualedlist(v_inp_asnid     => n.asn_id,
                        v_inp_curuserid => v_inp_curuserid,
                        v_inp_compid    => n.company_id);
    END LOOP;
  
    --生成物流部提醒
    p_msg_putlogisticsmsginqamsginfo(v_inp_qarepid   => v_inp_qarepid,
                                     v_inp_compid    => v_inp_compid,
                                     v_inp_curuserid => v_inp_curuserid);
  
    --生成质检结果不合格提醒
    p_msg_putgenunqualmsgintoinqamsginfo(v_inp_qarepid   => v_inp_qarepid,
                                         v_inp_compid    => v_inp_compid,
                                         v_inp_curuserid => v_inp_curuserid);
  END p_review_qareport;

  /*=============================================================================
  
     包：
       pkg_qa_ld(qa逻辑细节包)
  
     函数名:
       报告内已结束Asn/Sku数据新增进入预回传表
  
     入参:
       v_inp_qarepid           :  Qa质检报告Id
       v_inp_compid            :  企业Id
       v_inp_curuserid         :  操作人Id
  
     版本:
       2022-10-31_zc314 : 报告内已结束Sku新增进入预回传表
       2022-12-03_zc314 : 新增Asn新增进入预回传表
  
  ==============================================================================*/
  PROCEDURE p_ins_qarepafinfointopretrans(v_inp_qarepid   IN VARCHAR2,
                                          v_inp_compid    IN VARCHAR2,
                                          v_inp_curuserid IN VARCHAR2) IS
    v_processingtype  VARCHAR2(8);
    v_checkresult     VARCHAR2(8);
    v_status          VARCHAR2(8);
    v_errinfo         CLOB;
    v_jugnum          NUMBER(1);
    v_transtype       VARCHAR2(8);
    v_selfdescription VARCHAR2(1024) := 'scmdata.pkg_qa_lc.p_ins_qarepafskuintopretrans';
  BEGIN
    --获取报告质检结果
    v_checkresult := scmdata.pkg_qa_da.f_get_qarepcheckresult(v_inp_qarepid => v_inp_qarepid,
                                                              v_inp_compid  => v_inp_compid);
  
    --获取报告处理类型
    v_processingtype := scmdata.pkg_qa_da.f_get_qarepprocessingtype(v_inp_qarepid => v_inp_qarepid,
                                                                    v_inp_compid  => v_inp_compid);
  
    IF v_checkresult = 'APS'
       OR v_processingtype = 'WB' THEN
      --将该报告下所有质检结果为“合格”的Sku状态和质检结束时间赋值
      FOR y IN (SELECT DISTINCT asn_id, company_id
                  FROM scmdata.t_qa_report_skudim repsku
                 WHERE qa_report_id = v_inp_qarepid
                   AND company_id = v_inp_compid
                   AND status = 'AF'
                   AND nvl(repsku.skuprocessing_result, ' ') <> 'AWR'
                   AND data_source = 'SCM'
                   AND NOT EXISTS
                 (SELECT 1
                          FROM scmdata.t_qa_pretranstowms
                         WHERE asn_id = repsku.asn_id
                           AND goo_id IS NULL
                           AND barcode IS NULL
                           AND company_id = repsku.company_id)) LOOP
        --状态，错误信息赋值
        scmdata.pkg_qa_da.p_get_pretransstatusanderrinfo(v_inp_asnid   => y.asn_id,
                                                         v_inp_compid  => y.company_id,
                                                         v_inp_status  => v_status,
                                                         v_inp_errinfo => v_errinfo);
      
        --判断预回传表内数据是否存在
        v_jugnum := scmdata.pkg_qa_da.f_is_asninfopretranstowms_exists(v_inp_asnid  => y.asn_id,
                                                                       v_inp_compid => y.company_id);
      
        --Transtype获取
        v_transtype := scmdata.pkg_qa_da.f_qapretrans_get_transtype_by_asn(v_inp_asnid  => y.asn_id,
                                                                           v_inp_compid => y.company_id);
      
        IF v_transtype = 'SKU' THEN
          --将该报告下所有质检结果为“合格”的Sku状态和质检结束时间赋值
          FOR x IN (SELECT DISTINCT asn_id, goo_id, barcode, company_id
                      FROM scmdata.t_qa_report_skudim repsku
                     WHERE qa_report_id = v_inp_qarepid
                       AND company_id = v_inp_compid
                       AND status = 'AF'
                       AND nvl(repsku.skuprocessing_result, ' ') <> 'AWR'
                       AND data_source = 'SCM'
                       AND NOT EXISTS
                     (SELECT 1
                              FROM scmdata.t_qa_pretranstowms
                             WHERE asn_id = repsku.asn_id
                               AND goo_id = repsku.goo_id
                               AND nvl(barcode, ' ') =
                                   nvl(repsku.barcode, ' ')
                               AND trans_type <> 'DEL'
                               AND company_id = repsku.company_id)) LOOP
            --状态，错误信息赋值
            scmdata.pkg_qa_da.p_get_pretransstatusanderrinfo(v_inp_asnid   => x.asn_id,
                                                             v_inp_compid  => x.company_id,
                                                             v_inp_gooid   => x.goo_id,
                                                             v_inp_barcode => x.barcode,
                                                             v_inp_status  => v_status,
                                                             v_inp_errinfo => v_errinfo);
          
            --判断预回传表内数据是否存在
            v_jugnum := scmdata.pkg_qa_da.f_is_asninfopretranstowms_exists(v_inp_asnid   => x.asn_id,
                                                                           v_inp_gooid   => x.goo_id,
                                                                           v_inp_barcode => x.barcode,
                                                                           v_inp_compid  => x.company_id);
          
            --Transtype获取
            v_transtype := scmdata.pkg_qa_da.f_qapretrans_get_transtype_by_asn(v_inp_asnid  => x.asn_id,
                                                                               v_inp_compid => x.company_id);
          
            --如果不存在与预回传表内
            IF v_jugnum = 0 THEN
              --预回传表数据新增
              scmdata.pkg_qa_ld.p_ins_asninfopretranstowms(v_inp_asnid     => x.asn_id,
                                                           v_inp_gooid     => x.goo_id,
                                                           v_inp_barcode   => x.barcode,
                                                           v_inp_compid    => x.company_id,
                                                           v_inp_status    => v_status,
                                                           v_inp_errinfo   => v_errinfo,
                                                           v_inp_transtype => v_transtype,
                                                           v_inp_curuserid => v_inp_curuserid,
                                                           v_inp_invokeobj => v_selfdescription);
            ELSE
              --预回传表数据修改
              scmdata.pkg_qa_ld.p_upd_asninfopretranstowms(v_inp_asnid     => x.asn_id,
                                                           v_inp_gooid     => x.goo_id,
                                                           v_inp_barcode   => x.barcode,
                                                           v_inp_compid    => x.company_id,
                                                           v_inp_transtype => v_transtype,
                                                           v_inp_status    => v_status,
                                                           v_inp_errinfo   => v_errinfo,
                                                           v_inp_curuserid => v_inp_curuserid,
                                                           v_inp_invokeobj => v_selfdescription);
            END IF;
          
          END LOOP;
        ELSE
          --如果不存在与预回传表内
          IF v_jugnum = 0 THEN
            --新增进入Asn预回传Wms表
            scmdata.pkg_qa_ld.p_ins_asninfopretranstowms(v_inp_asnid     => y.asn_id,
                                                         v_inp_compid    => y.company_id,
                                                         v_inp_status    => v_status,
                                                         v_inp_errinfo   => v_errinfo,
                                                         v_inp_transtype => v_transtype,
                                                         v_inp_curuserid => v_inp_curuserid,
                                                         v_inp_invokeobj => v_selfdescription);
          ELSE
            scmdata.pkg_qa_ld.p_upd_asninfopretranstowms(v_inp_asnid     => y.asn_id,
                                                         v_inp_compid    => y.company_id,
                                                         v_inp_status    => v_status,
                                                         v_inp_transtype => v_transtype,
                                                         v_inp_errinfo   => v_errinfo,
                                                         v_inp_curuserid => v_inp_curuserid,
                                                         v_inp_invokeobj => v_selfdescription);
          END IF;
        
          DELETE FROM scmdata.t_qa_pretranstowms
           WHERE asn_id = y.asn_id
             AND company_id = y.company_id
             AND goo_id IS NOT NULL
             AND barcode IS NOT NULL;
        END IF;
      
      END LOOP;
    ELSE
      --将该报告下所有质检结果为“合格”的Sku状态和质检结束时间赋值
      FOR x IN (SELECT DISTINCT asn_id, goo_id, barcode, company_id
                  FROM scmdata.t_qa_report_skudim repsku
                 WHERE qa_report_id = v_inp_qarepid
                   AND company_id = v_inp_compid
                   AND status = 'AF'
                   AND nvl(repsku.skuprocessing_result, ' ') <> 'AWR'
                   AND data_source = 'SCM'
                   AND NOT EXISTS
                 (SELECT 1
                          FROM scmdata.t_qa_pretranstowms
                         WHERE asn_id = repsku.asn_id
                           AND goo_id = repsku.goo_id
                           AND nvl(barcode, ' ') = nvl(repsku.barcode, ' ')
                           AND trans_type <> 'DEL'
                           AND company_id = repsku.company_id)) LOOP
        --状态，错误信息赋值
        scmdata.pkg_qa_da.p_get_pretransstatusanderrinfo(v_inp_asnid   => x.asn_id,
                                                         v_inp_compid  => x.company_id,
                                                         v_inp_gooid   => x.goo_id,
                                                         v_inp_barcode => x.barcode,
                                                         v_inp_status  => v_status,
                                                         v_inp_errinfo => v_errinfo);
      
        --判断预回传表内数据是否存在
        v_jugnum := scmdata.pkg_qa_da.f_is_asninfopretranstowms_exists(v_inp_asnid   => x.asn_id,
                                                                       v_inp_gooid   => x.goo_id,
                                                                       v_inp_barcode => x.barcode,
                                                                       v_inp_compid  => x.company_id);
      
        --Transtype获取
        v_transtype := scmdata.pkg_qa_da.f_qapretrans_get_transtype_by_asn(v_inp_asnid  => x.asn_id,
                                                                           v_inp_compid => x.company_id);
      
        --如果不存在与预回传表内
        IF v_jugnum = 0 THEN
          --预回传表数据新增
          scmdata.pkg_qa_ld.p_ins_asninfopretranstowms(v_inp_asnid     => x.asn_id,
                                                       v_inp_gooid     => x.goo_id,
                                                       v_inp_barcode   => x.barcode,
                                                       v_inp_compid    => x.company_id,
                                                       v_inp_status    => v_status,
                                                       v_inp_errinfo   => v_errinfo,
                                                       v_inp_transtype => v_transtype,
                                                       v_inp_curuserid => v_inp_curuserid,
                                                       v_inp_invokeobj => v_selfdescription);
        ELSE
          --预回传表数据修改
          scmdata.pkg_qa_ld.p_upd_asninfopretranstowms(v_inp_asnid     => x.asn_id,
                                                       v_inp_gooid     => x.goo_id,
                                                       v_inp_barcode   => x.barcode,
                                                       v_inp_compid    => x.company_id,
                                                       v_inp_transtype => v_transtype,
                                                       v_inp_status    => v_status,
                                                       v_inp_errinfo   => v_errinfo,
                                                       v_inp_curuserid => v_inp_curuserid,
                                                       v_inp_invokeobj => v_selfdescription);
        END IF;
      
      END LOOP;
    END IF;
  
  END p_ins_qarepafinfointopretrans;

  /*=============================================================================
  
     包：
       pkg_qa_lc(QA逻辑链包)
  
     函数名:
       维护不合格处理校验
  
     入参:
       v_inp_qarepid        :  质检报告Id
       v_inp_compid         :  企业Id
       v_inp_processtype    :  处理方式
       v_inp_processresult  :  处理结果
  
     版本:
       2022-10-26_ZC314 : 维护不合格处理校验
  
  ==============================================================================*/
  PROCEDURE p_check_mantenanceunqualexecute(v_inp_qarepid       IN VARCHAR2,
                                            v_inp_compid        IN VARCHAR2,
                                            v_inp_processtype   IN VARCHAR2,
                                            v_inp_processresult IN VARCHAR2) IS
    v_status         VARCHAR2(8);
    v_processingtype VARCHAR2(8);
  BEGIN
    --处理方式必填校验
    IF v_inp_processtype IS NULL THEN
      raise_application_error(-20002, '【处理方式】字段必填！');
    ELSIF v_inp_processtype = 'WB'
          AND v_inp_processresult IS NULL THEN
      raise_application_error(-20002,
                              '当【处理方式】等于【整批处理】时，【处理结果】必填！');
    END IF;
  
    --获取质检报告状态
    v_status := scmdata.pkg_qa_da.f_get_qarepstatus(v_inp_qarepid => v_inp_qarepid,
                                                    v_inp_compid  => v_inp_compid);
  
    --校验非待处理状态不能维护不合格处理
    IF v_status <> 'PE' THEN
      raise_application_error(-20002,
                              '非【待处理】状态不能操作维护不合格处理！');
    ELSE
      v_processingtype := scmdata.pkg_qa_da.f_get_qarepprocessingtype(v_inp_qarepid => v_inp_qarepid,
                                                                      v_inp_compid  => v_inp_compid);
    
      IF v_processingtype IS NOT NULL THEN
        raise_application_error(-20002, '【维护不合格处理】不能重复操作！');
      END IF;
    END IF;
  END p_check_mantenanceunqualexecute;

  /*=============================================================================
  
     包：
       pkg_qa_lc(qa逻辑链包)
  
     过程名:
       待审核报告--主表维护不合格处理
  
     入参:
       v_inp_qarepid        :  质检报告Id
       v_inp_compid         :  企业Id
       v_inp_processtype    :  处理方式
       v_inp_processresult  :  处理结果
       v_inp_curuserid      :  当前操作人Id
  
     版本:
       2022-10-31_zc314 : 待审核报告--主表维护不合格处理
  
  ==============================================================================*/
  PROCEDURE p_maintenance_unqualprocessingmas(v_inp_qarepid       IN VARCHAR2,
                                              v_inp_compid        IN VARCHAR2,
                                              v_inp_processtype   IN VARCHAR2,
                                              v_inp_processresult IN VARCHAR2,
                                              v_inp_curuserid     IN VARCHAR2) IS
  
    v_selfdescription VARCHAR2(1024) := 'scmdata.pkg_qa_lc.p_maintenance_unqualprocessingmas';
  BEGIN
    --维护不合格处理校验
    p_check_mantenanceunqualexecute(v_inp_qarepid       => v_inp_qarepid,
                                    v_inp_compid        => v_inp_compid,
                                    v_inp_processtype   => v_inp_processtype,
                                    v_inp_processresult => v_inp_processresult);
  
    --维护不合格明细--处理方式=【整批处理】时更新逻辑
    IF v_inp_processtype = 'WB' THEN
      --质检报告主表，处理方式跟处理结果更新
      scmdata.pkg_qa_ld.p_upd_qarepmantenancemas(v_inp_qarepid          => v_inp_qarepid,
                                                 v_inp_compid           => v_inp_compid,
                                                 v_inp_processingtype   => v_inp_processtype,
                                                 v_inp_processingresult => v_inp_processresult,
                                                 v_inp_curuserid        => v_inp_curuserid,
                                                 v_inp_invokeobj        => v_selfdescription);
    
      --质检报告主表整批处理时，更新质检报告Sku处理结果，质检结束时间
      scmdata.pkg_qa_ld.p_upd_qarepmantenancewbsku(v_inp_qarepid          => v_inp_qarepid,
                                                   v_inp_compid           => v_inp_compid,
                                                   v_inp_processingresult => v_inp_processresult,
                                                   v_inp_curuserid        => v_inp_curuserid,
                                                   v_inp_invokeobj        => v_selfdescription);
    
      --更新质检报告主表数据汇总
      scmdata.pkg_qa_ld.p_upd_qarepresumamountrela(v_inp_qarepid   => v_inp_qarepid,
                                                   v_inp_compid    => v_inp_compid,
                                                   v_inp_curuserid => v_inp_curuserid,
                                                   v_inp_invokeobj => v_selfdescription);
    
      --修改质检报告状态
      scmdata.pkg_qa_ld.p_upd_qarepstatus(v_inp_qarepid   => v_inp_qarepid,
                                          v_inp_compid    => v_inp_compid,
                                          v_inp_status    => 'AF',
                                          v_inp_curuserid => v_inp_curuserid,
                                          v_inp_invokeobj => v_selfdescription);
    
      --刷新Asn回传数据
      FOR i IN (SELECT DISTINCT qa_report_id, asn_id, company_id
                  FROM scmdata.t_qa_report_skudim
                 WHERE qa_report_id = v_inp_qarepid
                   AND company_id = v_inp_compid) LOOP
        scmdata.pkg_qa_ld.p_refresh_qareptransresult(v_inp_qarepid    => i.qa_report_id,
                                                     v_inp_compid     => i.company_id,
                                                     v_inp_asnid      => i.asn_id,
                                                     v_inp_operuserid => v_inp_curuserid,
                                                     v_inp_invokeobj  => v_selfdescription);
      END LOOP;
    
      FOR i IN (SELECT DISTINCT asn_id, company_id
                  FROM scmdata.t_qa_report_skudim
                 WHERE qa_report_id = v_inp_qarepid
                   AND company_id = v_inp_compid) LOOP
        --修改Asn状态
        scmdata.pkg_qa_ld.p_upd_asnstatus(v_inp_asnids     => i.asn_id,
                                          v_inp_compid     => i.company_id,
                                          v_inp_status     => 'FA',
                                          v_inp_operuserid => v_inp_curuserid,
                                          v_inp_invokeobj  => v_selfdescription);
      
        --生成已检列表数据
        p_iu_qaqualedlist(v_inp_asnid     => i.asn_id,
                          v_inp_curuserid => v_inp_curuserid,
                          v_inp_compid    => i.company_id);
      
        --Asn次品分配进箱
        scmdata.pkg_qa_itf.p_scmtwms_allocatedsubsamountbyrepasn(v_inp_qarepid => v_inp_qarepid,
                                                                 v_inp_asnid   => i.asn_id,
                                                                 v_inp_compid  => i.company_id);
      END LOOP;
    
      --新增进入预回传表
      p_ins_qarepafinfointopretrans(v_inp_qarepid   => v_inp_qarepid,
                                    v_inp_compid    => v_inp_compid,
                                    v_inp_curuserid => v_inp_curuserid);
    ELSE
      --维护不合格明细--处理方式=【按色码处理】时更新逻辑
      --质检报告主表，处理方式跟处理结果更新
      scmdata.pkg_qa_ld.p_upd_qarepmantenancemas(v_inp_qarepid          => v_inp_qarepid,
                                                 v_inp_compid           => v_inp_compid,
                                                 v_inp_processingtype   => v_inp_processtype,
                                                 v_inp_processingresult => v_inp_processresult,
                                                 v_inp_curuserid        => v_inp_curuserid,
                                                 v_inp_invokeobj        => v_selfdescription);
    
      --更新质检报告主表数据汇总
      scmdata.pkg_qa_ld.p_upd_qarepresumamountrela(v_inp_qarepid   => v_inp_qarepid,
                                                   v_inp_compid    => v_inp_compid,
                                                   v_inp_curuserid => v_inp_curuserid,
                                                   v_inp_invokeobj => v_selfdescription);
    
      --刷新Asn回传数据
      FOR m IN (SELECT DISTINCT qa_report_id, asn_id, company_id
                  FROM scmdata.t_qa_report_skudim
                 WHERE qa_report_id = v_inp_qarepid
                   AND company_id = v_inp_compid) LOOP
        scmdata.pkg_qa_ld.p_refresh_qareptransresult(v_inp_qarepid    => m.qa_report_id,
                                                     v_inp_compid     => m.company_id,
                                                     v_inp_asnid      => m.asn_id,
                                                     v_inp_operuserid => v_inp_curuserid,
                                                     v_inp_invokeobj  => v_selfdescription);
      END LOOP;
    END IF;
  
    IF v_inp_processtype = 'WB' THEN
      --已检不合格消息进入Qa消息表
      p_msg_putqualedmsgintoinqamsginfo(v_inp_qarepid   => v_inp_qarepid,
                                        v_inp_compid    => v_inp_compid,
                                        v_inp_curuserid => v_inp_curuserid);
    END IF;
  END p_maintenance_unqualprocessingmas;

  /*=============================================================================
  
     包：
       pkg_qa_lc(qa逻辑链包)
  
     过程名:
       待审核报告--从表维护不合格处理
  
     入参:
       v_inp_qarepid           :  质检报告Id
       v_inp_compid            :  企业Id
       v_inp_asnid             :  Asn单号
       v_inp_gooid             :  商品档案编号
       v_inp_barcode           :  条码
       v_inp_processingresult  :  处理结果
       v_inp_datasource        :  数据来源
       v_inp_curuserid         :  当前操作人Id
  
     版本:
       2022-10-27_zc314 : 待审核报告--从表维护不合格处理
       2023-02-09_zc314 : 增加数据来源字段
  
  ==============================================================================*/
  PROCEDURE p_maintenance_unqualprocessingsla(v_inp_qarepid          IN VARCHAR2,
                                              v_inp_compid           IN VARCHAR2,
                                              v_inp_asnid            IN VARCHAR2,
                                              v_inp_gooid            IN VARCHAR2,
                                              v_inp_barcode          IN VARCHAR2,
                                              v_inp_processingresult IN VARCHAR2,
                                              v_inp_datasource       IN VARCHAR2,
                                              v_inp_curuserid        IN VARCHAR2) IS
  
    v_jugnum          NUMBER(1);
    v_processtype     VARCHAR2(8);
    v_skustatus       VARCHAR2(8);
    v_status          VARCHAR2(8);
    v_errinfo         CLOB;
    v_transtype       VARCHAR2(8);
    v_selfdescription VARCHAR2(1024) := 'scmdata.pkg_qa_lc.p_maintenance_unqualprocessingsla';
  BEGIN
    --获取Qa质检报告处理方式
    v_processtype := scmdata.pkg_qa_da.f_get_qarepprocessingtype(v_inp_qarepid => v_inp_qarepid,
                                                                 v_inp_compid  => v_inp_compid);
  
    --获取Qa质检报告Sku状态
    v_skustatus := scmdata.pkg_qa_da.f_get_qarepskustatus(v_inp_qarepid => v_inp_qarepid,
                                                          v_inp_compid  => v_inp_compid,
                                                          v_inp_asnid   => v_inp_asnid,
                                                          v_inp_gooid   => v_inp_gooid,
                                                          v_inp_barcode => v_inp_barcode);
  
    --当报告处理方式 <> 按色码处理 或 SKu状态 <> 待处理
    IF nvl(v_processtype, ' ') <> 'PBCC'
       OR nvl(v_skustatus, ' ') <> 'PE' THEN
      raise_application_error(-20002,
                              '仅当质检报告处理方式为【按色码处理】且 Sku状态为【待处理】才能操作【维护不合格处理】！');
    END IF;
  
    --更新Sku处理结果
    scmdata.pkg_qa_ld.p_upd_qarepskuprocesswbrelawithsku(v_inp_qarepid          => v_inp_qarepid,
                                                         v_inp_compid           => v_inp_compid,
                                                         v_inp_asnid            => v_inp_asnid,
                                                         v_inp_gooid            => v_inp_gooid,
                                                         v_inp_barcode          => v_inp_barcode,
                                                         v_inp_processingresult => v_inp_processingresult,
                                                         v_inp_curuserid        => v_inp_curuserid,
                                                         v_inp_invokeobj        => v_selfdescription);
  
    --更新Qa质检报告主表处理结果
    scmdata.pkg_qa_ld.p_upd_qarepprocessresultbysku(v_inp_qarepid    => v_inp_qarepid,
                                                    v_inp_compid     => v_inp_compid,
                                                    v_inp_operuserid => v_inp_curuserid,
                                                    v_inp_invokeobj  => v_selfdescription);
  
    --更新质检报告主表数据汇总
    scmdata.pkg_qa_ld.p_upd_qarepresumamountrela(v_inp_qarepid   => v_inp_qarepid,
                                                 v_inp_compid    => v_inp_compid,
                                                 v_inp_curuserid => v_inp_curuserid,
                                                 v_inp_invokeobj => v_selfdescription);
  
    --Sku次品分配进箱
    scmdata.pkg_qa_itf.p_scmtwms_allocatedsubsamountbyrepsku(v_inp_qarepid => v_inp_qarepid,
                                                             v_inp_asnid   => v_inp_asnid,
                                                             v_inp_gooid   => v_inp_gooid,
                                                             v_inp_barcode => v_inp_barcode,
                                                             v_inp_compid  => v_inp_compid);
  
    IF v_inp_processingresult <> 'AWR'
       AND v_inp_datasource = 'SCM' THEN
      --状态赋值
      scmdata.pkg_qa_da.p_get_pretransstatusanderrinfo(v_inp_asnid   => v_inp_asnid,
                                                       v_inp_compid  => v_inp_compid,
                                                       v_inp_gooid   => v_inp_gooid,
                                                       v_inp_barcode => v_inp_barcode,
                                                       v_inp_status  => v_status,
                                                       v_inp_errinfo => v_errinfo);
      --Transtype获取
      v_transtype := scmdata.pkg_qa_da.f_qapretrans_get_transtype_by_asn(v_inp_asnid  => v_inp_asnid,
                                                                         v_inp_compid => v_inp_compid);
    
      --预回传表数据新增
      scmdata.pkg_qa_ld.p_ins_asninfopretranstowms(v_inp_asnid     => v_inp_asnid,
                                                   v_inp_gooid     => v_inp_gooid,
                                                   v_inp_barcode   => v_inp_barcode,
                                                   v_inp_compid    => v_inp_compid,
                                                   v_inp_status    => v_status,
                                                   v_inp_errinfo   => v_errinfo,
                                                   v_inp_transtype => v_transtype,
                                                   v_inp_curuserid => v_inp_curuserid,
                                                   v_inp_invokeobj => v_selfdescription);
    
      --刷新
      scmdata.pkg_qa_ld.p_maintenance_slabackrefreshtranstype(v_inp_asnid     => v_inp_asnid,
                                                              v_inp_compid    => v_inp_compid,
                                                              v_inp_transtype => v_transtype,
                                                              v_inp_curuserid => v_inp_curuserid,
                                                              v_inp_invokeobj => v_selfdescription);
    END IF;
  
    --刷新Asn回传数据
    scmdata.pkg_qa_ld.p_refresh_qareptransresult(v_inp_qarepid    => v_inp_qarepid,
                                                 v_inp_compid     => v_inp_compid,
                                                 v_inp_asnid      => v_inp_asnid,
                                                 v_inp_operuserid => v_inp_curuserid,
                                                 v_inp_invokeobj  => v_selfdescription);
  
    --判断报告内Asn下所有Sku状态是否都是未完成
    v_jugnum := scmdata.pkg_qa_da.f_is_anyqarepasnskunotaf(v_inp_qarepid => v_inp_qarepid,
                                                           v_inp_asnid   => v_inp_asnid,
                                                           v_inp_compid  => v_inp_compid);
  
    --报告内Asn下所有Sku状态都是已完成
    IF v_jugnum = 0 THEN
      --修改Asn状态
      scmdata.pkg_qa_ld.p_upd_asnstatus(v_inp_asnids     => v_inp_asnid,
                                        v_inp_compid     => v_inp_compid,
                                        v_inp_status     => 'FA',
                                        v_inp_operuserid => v_inp_curuserid,
                                        v_inp_invokeobj  => v_selfdescription);
    
      --生成已检列表数据
      p_iu_qaqualedlist(v_inp_asnid     => v_inp_asnid,
                        v_inp_curuserid => v_inp_curuserid,
                        v_inp_compid    => v_inp_compid);
    
      --判断报告内是否存在Sku未完成质检
      v_jugnum := scmdata.pkg_qa_da.f_is_anyqarepskunotaf(v_inp_qarepid => v_inp_qarepid,
                                                          v_inp_compid  => v_inp_compid);
    
      --报告内所有Sku状态都是已完成
      IF v_jugnum = 0 THEN
        --修改质检报告状态
        scmdata.pkg_qa_ld.p_upd_qarepstatus(v_inp_qarepid   => v_inp_qarepid,
                                            v_inp_compid    => v_inp_compid,
                                            v_inp_status    => 'AF',
                                            v_inp_curuserid => v_inp_curuserid,
                                            v_inp_invokeobj => v_selfdescription);
      
        --已检不合格消息进入Qa消息表
        p_msg_putqualedmsgintoinqamsginfo(v_inp_qarepid   => v_inp_qarepid,
                                          v_inp_compid    => v_inp_compid,
                                          v_inp_curuserid => v_inp_curuserid);
      END IF;
    END IF;
  
  END p_maintenance_unqualprocessingsla;

  /*=============================================================================
  
     包：
       pkg_qa_lc(QA逻辑链包)
  
     过程名:
       生成 Qa返工质检报告校验
  
     入参:
       v_inp_qarepids   :  多个质检报告Id，由分号分隔
       v_inp_compid     :  企业Id
       v_inp_curuserid  :  当前操作人Id
  
     版本:
       2022-10-12_ZC314 : 生成 Qa返工质检报告校验
  
  ==============================================================================*/
  PROCEDURE p_check_genrcqarep(v_inp_qarepids IN VARCHAR2,
                               v_inp_compid   IN VARCHAR2) IS
    v_jugnum NUMBER(1);
  
  BEGIN
    --校验传入数据【待返工Sku个数】是否都大于0
    v_jugnum := scmdata.pkg_qa_da.f_is_anyqarepprereworkskunumequalzero(v_inp_qarepids => v_inp_qarepids,
                                                                        v_inp_compid   => v_inp_compid);
  
    --当存在【待返工Sku个数=0】的质检报告Id等于0时
    IF v_jugnum = 1 THEN
      --报错
      raise_application_error(-20002, '选中的数据不存在待返工数据！');
    END IF;
  
    --校验多条待返工数据，货号+供应商一致
    v_jugnum := scmdata.pkg_qa_da.f_is_qarepssupplierandgoonotsame(v_inp_qarepids => v_inp_qarepids,
                                                                   v_inp_compid   => v_inp_compid);
  
    --当存在【供应商】+【货号】不同的数据时
    IF v_jugnum = 1 THEN
      --报错
      raise_application_error(-20002,
                              '选中数据中不能存在【供应商】+【货号】不同的数据！');
    END IF;
  END p_check_genrcqarep;

  /*=============================================================================
  
     包：
       pkg_qa_lc(QA逻辑链包)
  
     过程名:
       生成 Qa返工质检报告
  
     入参:
       v_inp_qarepids   :  多个质检报告Id，由分号分隔
       v_inp_compid     :  企业Id
       v_inp_curuserid  :  当前操作人Id
  
     需求:
       1. 存在需要返工的数据才可操作[新增返工质检报告]，可通过“待返工SKU个数＞0”判断为存在需要返工的数据；
       2. 勾选多条待返工的数据，操作新增同一个返工质检报告时，勾选的数据“货号+供应商”需一致，否则操作失败；
       3. 操作[新增返工质检报告]成功，则当前页面更新“待返工SKU个数”字段，同时在【待检任务】页面生成“质检类型=返工抽查”的报告；
  
     版本:
       2022-10-28_ZC314 : 生成 Qa返工质检报告
  
  ==============================================================================*/
  PROCEDURE p_gen_rcqarep(v_inp_qarepids  IN VARCHAR2,
                          v_inp_compid    IN VARCHAR2,
                          v_inp_curuserid IN VARCHAR2) IS
    TYPE rcqarepcur IS REF CURSOR;
    tmprc                    rcqarepcur;
    v_sql                    CLOB;
    v_qarepid                VARCHAR2(32);
    v_asnid                  VARCHAR2(1024);
    v_gooid                  VARCHAR2(32);
    v_orderid                VARCHAR2(1024);
    v_supcode                VARCHAR2(32);
    v_faccode                VARCHAR2(1024);
    v_shoid                  VARCHAR2(32);
    v_barcode                VARCHAR2(32);
    v_pcomeamount            NUMBER(8);
    v_wmsgotamount           NUMBER(8);
    v_reworknum              NUMBER(8);
    v_pcomedate              DATE;
    v_scantime               DATE;
    v_receivetime            DATE;
    v_colorname              VARCHAR2(32);
    v_sizename               VARCHAR2(32);
    v_pcomesumamount         NUMBER(8);
    v_wmsgotsumamount        NUMBER(8);
    v_qualdrecreasesumamount NUMBER(8);
    v_unqualsumamount        NUMBER(8);
    v_asnids                 VARCHAR2(1024);
    v_selfdescription        VARCHAR2(1024) := 'scmdata.pkg_qa_lc.p_gen_rcqarep';
  BEGIN
    --生成返工质检报告校验
    p_check_genrcqarep(v_inp_qarepids => v_inp_qarepids,
                       v_inp_compid   => v_inp_compid);
  
    /*== 新增 scmdata.t_qa_report ================================================================*/
    --Qa质检报告Id赋值
    v_qarepid := scmdata.f_getkeyid_plat(pi_pre     => 'QA',
                                         pi_seqname => 'seq_qaid',
                                         pi_seqnum  => 2);
  
    --新增 Qa质检报告主表
    scmdata.pkg_qa_ld.p_ins_qareportmas(v_inp_qarepid              => v_qarepid,
                                        v_inp_compid               => v_inp_compid,
                                        v_inp_status               => 'PC',
                                        v_inp_checktype            => 'RC',
                                        v_inp_checkresult          => NULL,
                                        v_inp_problemclassifiction => NULL,
                                        v_inp_problemdescription   => NULL,
                                        v_inp_reviewcomments       => NULL,
                                        v_inp_checkers             => NULL,
                                        v_inp_checkdate            => NULL,
                                        v_inp_qualattachment       => NULL,
                                        v_inp_reviewattachment     => NULL,
                                        v_inp_memo                 => NULL,
                                        v_inp_curuserid            => v_inp_curuserid,
                                        v_inp_curtime              => SYSDATE,
                                        v_inp_ispriority           => NULL,
                                        v_inp_invokeobj            => v_selfdescription);
  
    /*== 新增 scmdata.t_qa_report_skudim ================================================================*/
    --获取待新增 Sku信息
    v_sql := scmdata.pkg_qa_ld.f_get_reworkskusql(v_inp_invokeobj => v_selfdescription);
  
    --开启游标
    OPEN tmprc FOR v_sql
      USING v_inp_qarepids, v_inp_compid;
    LOOP
      --游标动态赋值
      FETCH tmprc
        INTO v_asnid,
             v_gooid,
             v_barcode,
             v_pcomeamount,
             v_wmsgotamount,
             v_reworknum,
             v_pcomedate,
             v_scantime,
             v_receivetime,
             v_colorname,
             v_sizename;
      --当游标找不到下一个时，退出
      EXIT WHEN tmprc%NOTFOUND;
    
      --判断排除数据为空时，禁止进入正确逻辑
      IF v_asnid IS NOT NULL THEN
        --Qa质检报告Sku维度表增改
        p_iu_qareportskudim(v_inp_qarepid             => v_qarepid,
                            v_inp_compid              => v_inp_compid,
                            v_inp_asnid               => v_asnid,
                            v_inp_gooid               => v_gooid,
                            v_inp_barcode             => v_barcode,
                            v_inp_status              => 'PA',
                            v_inp_skuprocessingresult => NULL,
                            v_inp_skucheckresult      => 'PS',
                            v_inp_pcomeamount         => nvl(v_pcomeamount,
                                                             0),
                            v_inp_wmsgotamount        => nvl(v_wmsgotamount,
                                                             0),
                            v_inp_qualdecreaseamount  => 0,
                            v_inp_unqualamount        => NULL,
                            v_inp_reprocessednumber   => v_reworknum,
                            v_inp_pcomedate           => v_pcomedate,
                            v_inp_scantime            => v_scantime,
                            v_inp_receivetime         => v_receivetime,
                            v_inp_colorname           => v_colorname,
                            v_inp_sizename            => v_sizename,
                            v_inp_reviewid            => NULL,
                            v_inp_reviewtime          => NULL,
                            v_inp_qualfinishtime      => NULL,
                            v_inp_operuserid          => v_inp_curuserid);
      
        --生成返工报告清空次品
        scmdata.pkg_qa_ld.p_rcrepgen_clearpackssubsamount(v_inp_asnid     => v_asnid,
                                                          v_inp_compid    => v_inp_compid,
                                                          v_inp_gooid     => v_gooid,
                                                          v_inp_barcode   => v_barcode,
                                                          v_inp_curuserid => v_inp_curuserid,
                                                          v_inp_invokeobj => v_selfdescription);
      
        IF v_asnids IS NULL THEN
          v_asnids := v_asnid;
        ELSE
          IF instr(v_asnids, v_asnid) = 0 THEN
            v_asnids := v_asnids || ';' || v_asnid;
          END IF;
        END IF;
      END IF;
    END LOOP;
    --关闭动态游标
    CLOSE tmprc;
  
    /*== 新增 scmdata.t_qa_report_numdim ================================================================*/
    --获取 Qa质检报告Sku级汇总数字相关数据 Sql
    v_sql := scmdata.pkg_qa_ld.f_get_qarepskudimsumdata_sql(v_inp_invokeobj => v_selfdescription);
  
    --执行前Sql非空判断
    IF v_sql IS NOT NULL THEN
      --执行 Sql对变量进行赋值
      EXECUTE IMMEDIATE v_sql
        INTO v_pcomesumamount, v_wmsgotsumamount, v_qualdrecreasesumamount, v_unqualsumamount
        USING v_qarepid, v_inp_compid;
    
      --Qa质检报告数据维度表增改
      p_iu_qareportnumdim(v_inp_qarepid                  => v_qarepid,
                          v_inp_compid                   => v_inp_compid,
                          v_inp_firstsamplingamount      => NULL,
                          v_inp_addsamplingamount        => NULL,
                          v_inp_unqualsamplingamount     => NULL,
                          v_inp_pcomesumamount           => v_pcomesumamount,
                          v_inp_wmsgotsumamount          => v_wmsgotsumamount,
                          v_inp_qualdecreasesumamount    => v_qualdrecreasesumamount,
                          v_inp_prereprocessingsumamount => v_unqualsumamount,
                          v_inp_operuserid               => v_inp_curuserid);
    END IF;
  
    /*== 新增 scmdata.t_qa_report_relainfodim ================================================================*/
    --获取 Qa质检报告关联信息数据 Sql
    v_sql := scmdata.pkg_qa_ld.f_get_qarepasngooorder_sql(v_inp_invokeobj => v_selfdescription);
  
    --执行前Sql非空判断
    IF v_sql IS NOT NULL THEN
      --执行 Sql对变量进行赋值
      EXECUTE IMMEDIATE v_sql
        INTO v_asnid, v_gooid, v_orderid, v_supcode, v_faccode, v_shoid
        USING v_qarepid, v_inp_compid;
    
      --Qa质检报告关联信息增改
      p_iu_qareportrelainfodim(v_inp_qarepid    => v_qarepid,
                               v_inp_compid     => v_inp_compid,
                               v_inp_asnid      => v_asnid,
                               v_inp_gooid      => v_gooid,
                               v_inp_orderid    => v_orderid,
                               v_inp_supcode    => v_supcode,
                               v_inp_shoid      => v_shoid,
                               v_inp_faccode    => v_faccode,
                               v_inp_operuserid => v_inp_curuserid);
    END IF;
  
    /*== 新增 scmdata.t_qa_report_checkdetaildim ================================================================*/
    --Qa质检报告报告级质检细节表增改
    p_iu_qareportcheckdetaildim(v_inp_qarepid           => v_qarepid,
                                v_inp_compid            => v_inp_compid,
                                v_inp_yyresult          => NULL,
                                v_inp_yyunqualsubjects  => NULL,
                                v_inp_mflresult         => NULL,
                                v_inp_mflunqualsubjects => NULL,
                                v_inp_gyresult          => NULL,
                                v_inp_gyunqualsubjects  => NULL,
                                v_inp_bxresult          => NULL,
                                v_inp_bxuqualsubjects   => NULL,
                                v_inp_scaleamount       => NULL,
                                v_inp_operuserid        => v_inp_curuserid);
  
    /*== 修改 Asn状态 ================================================================*/
    scmdata.pkg_qa_ld.p_upd_asnstatus(v_inp_asnids     => v_asnids,
                                      v_inp_compid     => v_inp_compid,
                                      v_inp_status     => 'PE',
                                      v_inp_operuserid => v_inp_curuserid,
                                      v_inp_invokeobj  => v_selfdescription);
  
    /*== 修改原报告 scmdata.t_qa_report_numdim.prereprocessingsum_amount = 0 ================================================================*/
    scmdata.pkg_qa_ld.p_upd_qarepreprocessingsumamount(v_inp_qarepids           => v_inp_qarepids,
                                                       v_inp_compid             => v_inp_compid,
                                                       v_inp_prereprocessingnum => 0,
                                                       v_inp_curuserid          => v_inp_curuserid,
                                                       v_inp_invokeobj          => v_selfdescription);
  END p_gen_rcqarep;

  /*=============================================================================
  
     包：
       pkg_qa_lc(QA逻辑链包)
  
     函数名:
       待检任务-删除，删除返工质检报告，根据报告内 Sku更新
       其对应最新质检报告待返工 Sku个数
  
     入参:
       v_inp_qarepid    :  质检报告Id
       v_inp_compid     :  企业Id
       v_inp_curuserid  :  当前操作人Id
  
     版本:
       2022-11-01_ZC314 : 待检任务-删除，删除返工质检报告，根据报告内 Sku更新
                          其对应最新质检报告待返工 Sku个数
  
  ==============================================================================*/
  PROCEDURE p_upd_qareportrepreprocessnum(v_inp_qarepid   IN VARCHAR2,
                                          v_inp_compid    IN VARCHAR2,
                                          v_inp_curuserid IN VARCHAR2) IS
    v_qarepid         VARCHAR2(32);
    v_selfdescription VARCHAR2(1024) := 'scmdata.pkg_qa_lc.p_upd_qareportrepreprocessnum';
  BEGIN
    FOR i IN (SELECT DISTINCT asn_id,
                              goo_id,
                              barcode,
                              company_id,
                              qa_report_id
                FROM scmdata.t_qa_report_skudim
               WHERE qa_report_id = v_inp_qarepid
                 AND company_id = v_inp_compid) LOOP
      --获取该Sku最新的质检报告Id
      v_qarepid := scmdata.pkg_qa_da.f_get_skulastestqarepid(v_inp_asnid   => i.asn_id,
                                                             v_inp_gooid   => i.goo_id,
                                                             v_inp_barcode => i.barcode,
                                                             v_inp_qarepid => i.qa_report_id,
                                                             v_inp_compid  => i.company_id);
    
      --更新待返工数量+1
      scmdata.pkg_qa_ld.p_upd_qarepreprocessingsumamountaddone(v_inp_qarepids  => v_qarepid,
                                                               v_inp_compid    => i.company_id,
                                                               v_inp_curuserid => v_inp_curuserid,
                                                               v_inp_invokeobj => v_selfdescription);
    END LOOP;
  END p_upd_qareportrepreprocessnum;

  /*=============================================================================
  
     包：
       pkg_qa_lc(QA逻辑链包)
  
     函数名:
       质检报告报告级质检结果与不合格明细一致性校验
  
     入参:
       v_inp_qarepid    :  质检报告Id
       v_inp_compid     :  企业Id
       v_inp_curuserid  :  当前操作人Id
  
     版本:
       2022-10-24_ZC314 : 质检报告报告级质检结果与不合格明细一致性校验
  
  ==============================================================================*/
  PROCEDURE p_del_pcqareport(v_inp_qarepid   IN VARCHAR2,
                             v_inp_compid    IN VARCHAR2,
                             v_inp_curuserid IN VARCHAR2) IS
    v_checktype       VARCHAR2(8);
    v_selfdescription VARCHAR2(1024) := 'scmdata.pkg_qa_lc.p_del_pcqareport';
  BEGIN
    --获取质检类型
    v_checktype := scmdata.pkg_qa_da.f_get_qarepchecktype(v_inp_qarepid => v_inp_qarepid,
                                                          v_inp_compid  => v_inp_compid);
  
    --当质检类型=返工质检
    IF v_checktype = 'RC' THEN
      --待返工Sku个数增加
      p_upd_qareportrepreprocessnum(v_inp_qarepid   => v_inp_qarepid,
                                    v_inp_compid    => v_inp_compid,
                                    v_inp_curuserid => v_inp_curuserid);
    
      --删除质检报告相关数据
      scmdata.pkg_qa_ld.p_del_qareprela(v_inp_qarepid   => v_inp_qarepid,
                                        v_inp_compid    => v_inp_compid,
                                        v_inp_invokeobj => v_selfdescription);
    
    ELSE
      --修改 Asn状态
      FOR i IN (SELECT DISTINCT asn_id, company_id
                  FROM scmdata.t_qa_report_skudim
                 WHERE qa_report_id = v_inp_qarepid
                   AND company_id = v_inp_compid) LOOP
        scmdata.pkg_qa_ld.p_upd_asnstatus(v_inp_asnids     => i.asn_id,
                                          v_inp_compid     => i.company_id,
                                          v_inp_status     => 'PC',
                                          v_inp_operuserid => v_inp_curuserid,
                                          v_inp_invokeobj  => v_selfdescription);
      END LOOP;
    
      --删除质检报告相关数据
      scmdata.pkg_qa_ld.p_del_qareprela(v_inp_qarepid   => v_inp_qarepid,
                                        v_inp_compid    => v_inp_compid,
                                        v_inp_invokeobj => v_selfdescription);
    END IF;
  END p_del_pcqareport;

  /*=============================================================================
  
     包：
       pkg_qa_ld(QA逻辑细节包)
  
     过程名:
       Qa消息配置新增/修改
  
     入参:
       v_inp_configcode  :  消息配置编码
       v_inp_configname  :  消息配置名称
       v_inp_keyurl      :  消息Key（url）
       v_inp_curuserid   :  当前操作人Id
       v_inp_compid      :  企业Id
  
     版本:
       2022-12-08_ZC314 : Qa消息配置新增/修改
  
  ==============================================================================*/
  PROCEDURE p_msg_insorupdqamsgconfig(v_inp_configcode IN VARCHAR2,
                                      v_inp_configname IN VARCHAR2,
                                      v_inp_keyurl     IN VARCHAR2,
                                      v_inp_curuserid  IN VARCHAR2,
                                      v_inp_compid     IN VARCHAR2) IS
    v_jugnum          NUMBER(1);
    v_selfdescription VARCHAR2(1024) := 'scmdata.pkg_qa_lc.p_msg_insorupdqamsgconfig';
  BEGIN
    --判断是否存在于Qa消息配置表中
    v_jugnum := scmdata.pkg_qa_da.f_is_qamsgconfigexists(v_inp_configcode => v_inp_configcode,
                                                         v_inp_compid     => v_inp_compid);
  
    IF v_jugnum = 0 THEN
      --不存在，新增
      scmdata.pkg_qa_ld.p_msg_insqamsgconfig(v_inp_configcode => v_inp_configcode,
                                             v_inp_configname => v_inp_configname,
                                             v_inp_keyurl     => v_inp_keyurl,
                                             v_inp_curuserid  => v_inp_curuserid,
                                             v_inp_compid     => v_inp_compid,
                                             v_inp_invokeobj  => v_selfdescription);
    ELSE
      --存在，更新
      scmdata.pkg_qa_ld.p_msg_updqamsgconfig(v_inp_configcode => v_inp_configcode,
                                             v_inp_configname => v_inp_configname,
                                             v_inp_keyurl     => v_inp_keyurl,
                                             v_inp_curuserid  => v_inp_curuserid,
                                             v_inp_compid     => v_inp_compid,
                                             v_inp_invokeobj  => v_selfdescription);
    END IF;
  END p_msg_insorupdqamsgconfig;

  /*=============================================================================
  
     包：
       pkg_qa_ld(QA逻辑细节包)
  
     过程名:
       Qa消息新增/修改
  
     入参:
       v_inp_configcode  :  Qa消息配置编码
       v_inp_unqinfo     :  Qa消息表唯一信息
       v_inp_msgstatus   :  消息状态：R-准备 E-错误 S-成功
       v_inp_msgtype     :  消息类型
       v_inp_msginfo     :  消息内容
       v_inp_curuserid   :  当前操作人Id
       v_inp_compid      :  企业Id
  
     版本:
       2022-12-08_ZC314 : Qa消息新增/修改
  
  ==============================================================================*/
  PROCEDURE p_msg_insorupdqamsginfo(v_inp_configcode IN VARCHAR2,
                                    v_inp_unqinfo    IN VARCHAR2,
                                    v_inp_msgstatus  IN VARCHAR2,
                                    v_inp_msgtype    IN VARCHAR2,
                                    v_inp_msginfo    IN VARCHAR2,
                                    v_inp_curuserid  IN VARCHAR2,
                                    v_inp_compid     IN VARCHAR2) IS
    v_jugnum          NUMBER(1);
    v_selfdescription VARCHAR2(1024) := 'scmdata.pkg_qa_lc.p_msg_insorupdqamsginfo';
  BEGIN
    --判断是否存在于Qa消息表中
    v_jugnum := scmdata.pkg_qa_da.f_is_qamsginfoexists(v_inp_configcode => v_inp_configcode,
                                                       v_inp_unqinfo    => v_inp_unqinfo,
                                                       v_inp_compid     => v_inp_compid);
  
    IF v_jugnum = 0 THEN
      --不存在，新增
      scmdata.pkg_qa_ld.p_msg_insqamsginfo(v_inp_configcode => v_inp_configcode,
                                           v_inp_unqinfo    => v_inp_unqinfo,
                                           v_inp_msgstatus  => v_inp_msgstatus,
                                           v_inp_msgtype    => v_inp_msgtype,
                                           v_inp_msginfo    => v_inp_msginfo,
                                           v_inp_curuserid  => v_inp_curuserid,
                                           v_inp_compid     => v_inp_compid,
                                           v_inp_invokeobj  => v_selfdescription);
    ELSE
      --存在，更新
      scmdata.pkg_qa_ld.p_msg_updqamsginfo(v_inp_configcode => v_inp_configcode,
                                           v_inp_unqinfo    => v_inp_unqinfo,
                                           v_inp_msgstatus  => v_inp_msgstatus,
                                           v_inp_msgtype    => v_inp_msgtype,
                                           v_inp_msginfo    => v_inp_msginfo,
                                           v_inp_curuserid  => v_inp_curuserid,
                                           v_inp_compid     => v_inp_compid,
                                           v_inp_invokeobj  => v_selfdescription);
    END IF;
  END p_msg_insorupdqamsginfo;

  /*=============================================================================
  
     包：
       pkg_qa_lc(QA逻辑链包)
  
     过程名:
       生成物流部提醒消息
  
     入参:
       v_inp_qarepid    :  质检报告Id
       v_inp_compid     :  企业Id
       v_inp_curuserid  :  当前操作人Id
  
     返回值:
       Varchar 类型，消息内容
  
     版本:
       2022-12-08_ZC314 : 生成物流部提醒消息
  
  ==============================================================================*/
  FUNCTION f_msg_genlogisticsmsgbyqarep(v_inp_qarepid   IN VARCHAR2,
                                        v_inp_compid    IN VARCHAR2,
                                        v_inp_curuserid IN VARCHAR2)
    RETURN VARCHAR2 IS
    v_headmsg         CLOB;
    v_restmsg         CLOB;
    v_checkresult     VARCHAR2(8);
    v_msg             VARCHAR2(4000);
    v_selfdescription VARCHAR2(1024) := 'scmdata.pkg_qa_lc.f_msg_genlogisticsmsgbyqarep';
  BEGIN
    --消息头赋值
    v_headmsg := scmdata.pkg_qa_ld.f_message_genlogisticsheadmsg(v_inp_qarepid   => v_inp_qarepid,
                                                                 v_inp_compid    => v_inp_compid,
                                                                 v_inp_curuserid => v_inp_curuserid,
                                                                 v_inp_invokeobj => v_selfdescription);
  
    --获取质检结果
    v_checkresult := scmdata.pkg_qa_da.f_get_qarepcheckresult(v_inp_qarepid => v_inp_qarepid,
                                                              v_inp_compid  => v_inp_compid);
  
    --仅当报告质检结果为“部分通过时”，存在剩余消息
    IF v_checkresult = 'PNP' THEN
      --剩余消息赋值
      v_restmsg := scmdata.pkg_qa_ld.f_message_genlogisticsrestmsg(v_inp_qarepid   => v_inp_qarepid,
                                                                   v_inp_compid    => v_inp_compid,
                                                                   v_inp_curuserid => v_inp_curuserid,
                                                                   v_inp_invokeobj => v_selfdescription);
    END IF;
  
    --剩余消息拼接赋值
    IF v_restmsg IS NOT NULL THEN
      v_restmsg := v_restmsg || '}';
    END IF;
  
    --消息组合
    v_msg := scmdata.f_sentence_append_rc(v_sentence   => v_headmsg,
                                          v_appendstr  => v_restmsg,
                                          v_middliestr => chr(10) ||
                                                          '不合格明细:{');
  
    --返回消息
    RETURN v_msg;
  END f_msg_genlogisticsmsgbyqarep;

  /*=============================================================================
  
     包：
       pkg_qa_lc(QA逻辑链包)
  
     过程名:
       物流消息进入Qa信息表
  
     入参:
       v_inp_qarepid    :  质检报告Id
       v_inp_compid     :  企业Id
       v_inp_curuserid  :  当前操作人Id
  
     版本:
       2022-12-09_ZC314 : 物流消息进入Qa信息表
  
  ==============================================================================*/
  PROCEDURE p_msg_putlogisticsmsginqamsginfo(v_inp_qarepid   IN VARCHAR2,
                                             v_inp_compid    IN VARCHAR2,
                                             v_inp_curuserid IN VARCHAR2) IS
    v_msgcode VARCHAR2(32);
    v_msg     VARCHAR2(4000);
    v_shoid   VARCHAR2(8);
  BEGIN
    --获取仓库
    v_shoid := scmdata.pkg_qa_da.f_get_shoid(v_inp_qarepid => v_inp_qarepid,
                                             v_inp_compid  => v_inp_compid);
  
    --判断，对消息类型取值
    IF instr(v_shoid, 'GZZ') > 0
       OR instr(v_shoid, 'GDZ') > 0 THEN
      v_msgcode := 'QA_LD_GZ';
    ELSIF instr(v_shoid, 'YWZ') > 0
          OR instr(v_shoid, 'YDZ') > 0 THEN
      v_msgcode := 'QA_LD_YW';
    END IF;
  
    --获取消息内容
    v_msg := f_msg_genlogisticsmsgbyqarep(v_inp_qarepid   => v_inp_qarepid,
                                          v_inp_compid    => v_inp_compid,
                                          v_inp_curuserid => v_inp_curuserid);
  
    --Qa信息表新增/修改
    p_msg_insorupdqamsginfo(v_inp_configcode => v_msgcode,
                            v_inp_unqinfo    => v_inp_qarepid,
                            v_inp_msgstatus  => 'R',
                            v_inp_msgtype    => 'markdown',
                            v_inp_msginfo    => v_msg,
                            v_inp_curuserid  => v_inp_curuserid,
                            v_inp_compid     => v_inp_compid);
  END p_msg_putlogisticsmsginqamsginfo;

  /*=============================================================================
  
     包：
       pkg_qa_lc(QA逻辑链包)
  
     过程名:
       生成质检不合格提醒消息
  
     入参:
       v_inp_qarepid    :  质检报告Id
       v_inp_compid     :  企业Id
       v_inp_curuserid  :  当前操作人Id
  
     返回值:
       Varchar 类型，消息内容
  
     版本:
       2022-12-12_ZC314 : 生成质检不合格提醒消息
  
  ==============================================================================*/
  FUNCTION f_msg_genunqualmsgbyqarep(v_inp_qarepid   IN VARCHAR2,
                                     v_inp_compid    IN VARCHAR2,
                                     v_inp_curuserid IN VARCHAR2)
    RETURN VARCHAR2 IS
    v_headmsg         CLOB;
    v_midmsg          CLOB;
    v_finmsg          CLOB;
    v_jugnum          NUMBER(1);
    v_msg             VARCHAR2(4000);
    v_selfdescription VARCHAR2(1024) := 'scmdata.pkg_qa_lc.f_msg_genunqualmsgbyqarep';
  BEGIN
    --判断是否存在Sku质检不合格数据
    v_jugnum := scmdata.pkg_qa_da.f_has_npskucheckresult(v_inp_qarepid => v_inp_qarepid,
                                                         v_inp_compid  => v_inp_compid);
  
    --存在Sku质检不合格数据
    IF v_jugnum > 0 THEN
      --消息头赋值
      v_headmsg := scmdata.pkg_qa_ld.f_message_genlogisticsheadmsg(v_inp_qarepid      => v_inp_qarepid,
                                                                   v_inp_compid       => v_inp_compid,
                                                                   v_inp_checkresults => 'ANP,PNP',
                                                                   v_inp_curuserid    => v_inp_curuserid,
                                                                   v_inp_invokeobj    => v_selfdescription);
    
      --消息头无值则后续不执行
      IF v_headmsg IS NOT NULL THEN
        --中部消息赋值
        v_midmsg := scmdata.pkg_qa_ld.f_message_unqualmetionrelauserinfo(v_inp_qarepid   => v_inp_qarepid,
                                                                         v_inp_compid    => v_inp_compid,
                                                                         v_inp_curuserid => v_inp_curuserid,
                                                                         v_inp_invokeobj => v_selfdescription);
      
        --消息拼接赋值
        IF v_midmsg IS NOT NULL THEN
          v_msg := v_headmsg || ', ' || v_midmsg;
        ELSE
          v_msg := v_headmsg;
        END IF;
      
        --消息尾赋值
        v_finmsg := scmdata.pkg_qa_ld.f_message_unqualmetionqarepinfo(v_inp_qarepid   => v_inp_qarepid,
                                                                      v_inp_invokeobj => v_selfdescription);
      
        --消息组合
        v_msg := scmdata.f_sentence_append_rc(v_sentence   => v_msg,
                                              v_appendstr  => v_finmsg,
                                              v_middliestr => chr(10));
      END IF;
    END IF;
  
    --返回消息
    RETURN v_msg;
  END f_msg_genunqualmsgbyqarep;

  /*=============================================================================
  
     包：
       pkg_qa_lc(QA逻辑链包)
  
     过程名:
       不合格信息进入Qa信息表
  
     入参:
       v_inp_qarepid    :  质检报告Id
       v_inp_compid     :  企业Id
       v_inp_curuserid  :  当前操作人Id
  
     版本:
       2022-12-12_ZC314 : 物流消息进入Qa信息表
  
  ==============================================================================*/
  PROCEDURE p_msg_putgenunqualmsgintoinqamsginfo(v_inp_qarepid   IN VARCHAR2,
                                                 v_inp_compid    IN VARCHAR2,
                                                 v_inp_curuserid IN VARCHAR2) IS
    v_msgcode VARCHAR2(32);
    v_msg     VARCHAR2(4000);
    v_shoids  VARCHAR2(128);
    v_cates   VARCHAR2(128);
  BEGIN
    --获取仓库
    scmdata.pkg_qa_da.p_get_multishoandcatebyqarep(v_inp_qarepid => v_inp_qarepid,
                                                   v_inp_compid  => v_inp_compid,
                                                   v_iop_shoids  => v_shoids,
                                                   v_iop_cates   => v_cates);
  
    --判断，对消息类型取值
    IF instr(v_cates, '07') > 0 THEN
      v_msgcode := 'QA_UQ_TP';
    ELSE
      IF instr(v_shoids, 'GZZ') > 0
         OR instr(v_shoids, 'GDZ') > 0 THEN
        v_msgcode := 'QA_UQ_GZ';
      ELSIF instr(v_shoids, 'YWZ') > 0
            OR instr(v_shoids, 'YDZ') > 0 THEN
        v_msgcode := 'QA_UQ_YW';
      END IF;
    END IF;
  
    --获取消息内容
    v_msg := f_msg_genunqualmsgbyqarep(v_inp_qarepid   => v_inp_qarepid,
                                       v_inp_compid    => v_inp_compid,
                                       v_inp_curuserid => v_inp_curuserid);
  
    --消息内容不为空执行新增/修改
    IF v_msg IS NOT NULL THEN
      --Qa信息表新增/修改
      p_msg_insorupdqamsginfo(v_inp_configcode => v_msgcode,
                              v_inp_unqinfo    => v_inp_qarepid,
                              v_inp_msgstatus  => 'R',
                              v_inp_msgtype    => 'markdown',
                              v_inp_msginfo    => v_msg,
                              v_inp_curuserid  => v_inp_curuserid,
                              v_inp_compid     => v_inp_compid);
    END IF;
  
  END p_msg_putgenunqualmsgintoinqamsginfo;

  /*=============================================================================
  
     包：
       pkg_qa_lc(QA逻辑链包)
  
     过程名:
       生成已检消息
  
     入参:
       v_inp_qarepid    :  质检报告Id
       v_inp_compid     :  企业Id
       v_inp_curuserid  :  当前操作人Id
  
     返回值:
       Varchar 类型，消息内容
  
     版本:
       2022-12-13_ZC314 : 生成已检消息
  
  ==============================================================================*/
  FUNCTION f_msg_genqualedmsgbyqarep(v_inp_qarepid   IN VARCHAR2,
                                     v_inp_compid    IN VARCHAR2,
                                     v_inp_curuserid IN VARCHAR2) RETURN CLOB IS
    v_transresultnum  NUMBER(8);
    v_maxtransresult  VARCHAR2(8);
    v_headinfo        CLOB;
    v_psinfo          CLOB;
    v_npinfo          CLOB;
    v_rtinfo          CLOB;
    v_retinfo         CLOB;
    v_selfdescription VARCHAR2(1024) := 'scmdata.pkg_qa_lc.f_msg_genqualedmsgbyqarep';
  BEGIN
    --获取已检消息的消息头
    v_headinfo := scmdata.pkg_qa_ld.f_message_getqualedheadinfobyqarep(v_inp_qarepid   => v_inp_qarepid,
                                                                       v_inp_compid    => v_inp_compid,
                                                                       v_inp_curuserid => v_inp_curuserid,
                                                                       v_inp_invokeobj => v_selfdescription);
  
    --获取质检报告唯一传输结果数量，传输结果最大值
    scmdata.pkg_qa_da.p_get_qualedtrnumandmaxtr(v_inp_qarepid => v_inp_qarepid,
                                                v_inp_compid  => v_inp_compid,
                                                v_iop_trnum   => v_transresultnum,
                                                v_iop_maxtr   => v_maxtransresult);
  
    --根据唯一传输结果数量构建返回信息
    IF v_transresultnum = 1 THEN
      IF v_maxtransresult = 'PS' THEN
        v_retinfo := v_headinfo || '收货';
      ELSIF v_maxtransresult = 'NP' THEN
        v_retinfo := v_headinfo || '批退';
      ELSIF v_maxtransresult = 'RT' THEN
        v_retinfo := v_headinfo || '到仓返工';
      END IF;
    ELSE
      --通过信息
      v_psinfo := scmdata.pkg_qa_ld.f_message_getqualedmsgbyqarep(v_inp_qarepid     => v_inp_qarepid,
                                                                  v_inp_transresult => 'PS',
                                                                  v_inp_compid      => v_inp_compid,
                                                                  v_inp_curuserid   => v_inp_curuserid,
                                                                  v_inp_invokeobj   => v_selfdescription);
    
      --不通过信息
      v_npinfo := scmdata.pkg_qa_ld.f_message_getqualedmsgbyqarep(v_inp_qarepid     => v_inp_qarepid,
                                                                  v_inp_transresult => 'NP',
                                                                  v_inp_compid      => v_inp_compid,
                                                                  v_inp_curuserid   => v_inp_curuserid,
                                                                  v_inp_invokeobj   => v_selfdescription);
    
      --返工信息
      v_rtinfo := scmdata.pkg_qa_ld.f_message_getqualedmsgbyqarep(v_inp_qarepid     => v_inp_qarepid,
                                                                  v_inp_transresult => 'RT',
                                                                  v_inp_compid      => v_inp_compid,
                                                                  v_inp_curuserid   => v_inp_curuserid,
                                                                  v_inp_invokeobj   => v_selfdescription);
    
      --构建返回信息
      v_retinfo := v_headinfo || chr(10) || v_psinfo || chr(10) || v_npinfo ||
                   chr(10) || v_rtinfo;
    END IF;
  
    --返回
    RETURN v_retinfo;
  END f_msg_genqualedmsgbyqarep;

  /*=============================================================================
  
     包：
       pkg_qa_lc(QA逻辑链包)
  
     过程名:
       已检不合格消息进入Qa消息表
  
     入参:
       v_inp_qarepid    :  质检报告Id
       v_inp_compid     :  企业Id
       v_inp_curuserid  :  当前操作人Id
  
     版本:
       2022-12-13_ZC314 : 已检不合格消息进入Qa消息表
  
  ==============================================================================*/
  PROCEDURE p_msg_putqualedmsgintoinqamsginfo(v_inp_qarepid   IN VARCHAR2,
                                              v_inp_compid    IN VARCHAR2,
                                              v_inp_curuserid IN VARCHAR2) IS
    v_shoid   VARCHAR2(32);
    v_msgcode VARCHAR2(32);
    v_msg     CLOB;
  BEGIN
    --获取仓库
    v_shoid := scmdata.pkg_qa_da.f_get_shoid(v_inp_qarepid => v_inp_qarepid,
                                             v_inp_compid  => v_inp_compid);
  
    --判断，对消息类型取值
    IF instr(v_shoid, 'GZZ') > 0
       OR instr(v_shoid, 'GDZ') > 0 THEN
      v_msgcode := 'QA_QD_GZ';
    ELSIF instr(v_shoid, 'YWZ') > 0
          OR instr(v_shoid, 'YDZ') > 0 THEN
      v_msgcode := 'QA_QD_YW';
    END IF;
  
    --获取消息内容
    v_msg := f_msg_genqualedmsgbyqarep(v_inp_qarepid   => v_inp_qarepid,
                                       v_inp_compid    => v_inp_compid,
                                       v_inp_curuserid => v_inp_curuserid);
  
    --当消息不为空
    IF v_msg IS NOT NULL THEN
      --Qa信息表新增/修改
      p_msg_insorupdqamsginfo(v_inp_configcode => v_msgcode,
                              v_inp_unqinfo    => v_inp_qarepid,
                              v_inp_msgstatus  => 'R',
                              v_inp_msgtype    => 'markdown',
                              v_inp_msginfo    => v_msg,
                              v_inp_curuserid  => v_inp_curuserid,
                              v_inp_compid     => v_inp_compid);
    END IF;
  
  END p_msg_putqualedmsgintoinqamsginfo;

  /*=============================================================================
  
     包：
       pkg_qa_lc(QA逻辑链包)
  
     过程名:
       获取最早一条未发出的Qa消息（Qa消息发送器内部逻辑已合并进入）
  
     入参:
       v_inp_msglistener   :  消息监听器 element_id
       v_inp_msgsender     :  消息发送器 element_id
       v_inp_compid        :  企业Id
  
     版本:
       2022-12-09_ZC314 : 获取最早一条未发出的Qa消息
                          （Qa消息发送器内部逻辑已合并进入）
  
  ==============================================================================*/
  FUNCTION f_msg_getearliestqamsg(v_inp_msglistener IN VARCHAR2,
                                  v_inp_msgsender   IN VARCHAR2,
                                  v_inp_compid      IN VARCHAR2) RETURN CLOB IS
    v_jugnum          NUMBER(1);
    v_unqid           VARCHAR2(32);
    v_key             VARCHAR2(4000);
    v_configcode      VARCHAR2(16);
    v_msgcnt          NUMBER(8);
    v_msgtype         VARCHAR2(32);
    v_msginfo         VARCHAR2(4000);
    v_sql             CLOB;
    v_selfdescription VARCHAR2(1024) := 'scmdata.pkg_qa_lc.f_msg_earliestqamsg';
  BEGIN
    --获取消息表Id，消息配置编码，消息类型，消息内容
    SELECT MAX(msginfo_id), MAX(config_code), MAX(msg_type), MAX(msg_info)
      INTO v_unqid, v_configcode, v_msgtype, v_msginfo
      FROM (SELECT msginfo_id, config_code, msg_type, msg_info
              FROM scmdata.t_qa_msginfo
             WHERE company_id = v_inp_compid
               AND msg_status = 'R'
             ORDER BY nvl(update_time, create_time) FETCH FIRST 1 rows ONLY);
  
    --获取除当前待发送消息外还有多少未发送消息
    SELECT nvl(COUNT(1) - 1, 0)
      INTO v_msgcnt
      FROM scmdata.t_qa_msginfo
     WHERE company_id = v_inp_compid
       AND msg_status = 'R';
  
    --获取机器人Key（url）
    SELECT MAX(key_url)
      INTO v_key
      FROM scmdata.t_qa_msgconfig
     WHERE config_code = v_configcode
       AND company_id = v_inp_compid;
  
    IF v_configcode IS NOT NULL THEN
      --记录唯一Id，用于接口错误数据处理
      scmdata.pkg_variable.p_ins_or_upd_variable_at(v_objid   => 'SCM_QA_MSG',
                                                    v_compid  => v_inp_compid,
                                                    v_varname => v_configcode,
                                                    v_vartype => 'VARCHAR',
                                                    v_varchar => v_unqid);
    END IF;
  
    --如果还有剩余消息未发送
    IF v_msgcnt > 0 THEN
      --构建返回值sql
      v_sql := 'select ''' || v_msgtype || ''' MSGTYPE, ''' || v_key ||
               ''' key, ''' || v_msginfo ||
               ''' CONTENT, null mentioned_list, ''' || v_msginfo ||
               ''' markdown_content from dual';
    
      --消息状态变更
      UPDATE scmdata.t_qa_msginfo
         SET msg_status = 'S'
       WHERE msginfo_id = v_unqid
         AND company_id = v_inp_compid;
    
      --获取xxl_job特定执行参数的触发状态
      v_jugnum := scmdata.pkg_qa_da.f_get_xxltriggerstatus(v_executeparam => v_inp_msglistener);
    
      IF v_jugnum <> 0 THEN
        --监听器暂停
        scmdata.pkg_qa_ld.p_msg_updxxlinfotriggerstatus(v_inp_triggerstatus => 0,
                                                        v_inp_executorparam => v_inp_msglistener,
                                                        v_inp_invokeobj     => v_selfdescription);
      END IF;
    ELSIF v_msgcnt = 0 THEN
      --构建返回值sql
      v_sql := 'select ''' || v_msgtype || ''' msgtype, ''' || v_key ||
               ''' key, ''' || v_msginfo || ''' markdown_content from dual';
    
      --消息状态变更
      UPDATE scmdata.t_qa_msginfo
         SET msg_status = 'S'
       WHERE msginfo_id = v_unqid
         AND company_id = v_inp_compid;
    
      --消息发送器暂停
      scmdata.pkg_qa_ld.p_msg_updxxlinfotriggerstatus(v_inp_triggerstatus => 0,
                                                      v_inp_executorparam => v_inp_msgsender,
                                                      v_inp_invokeobj     => v_selfdescription);
      --监听器启动
      scmdata.pkg_qa_ld.p_msg_updxxlinfotriggerstatus(v_inp_triggerstatus => 1,
                                                      v_inp_executorparam => v_inp_msglistener,
                                                      v_inp_invokeobj     => v_selfdescription);
    ELSE
      --构建返回值Sql
      v_sql := 'select 1 from dual';
    
      --消息发送器暂停
      scmdata.pkg_qa_ld.p_msg_updxxlinfotriggerstatus(v_inp_triggerstatus => 0,
                                                      v_inp_executorparam => v_inp_msgsender,
                                                      v_inp_invokeobj     => v_selfdescription);
      --监听器启动
      scmdata.pkg_qa_ld.p_msg_updxxlinfotriggerstatus(v_inp_triggerstatus => 1,
                                                      v_inp_executorparam => v_inp_msglistener,
                                                      v_inp_invokeobj     => v_selfdescription);
    END IF;
  
    --返回Sql
    RETURN v_sql;
  END f_msg_getearliestqamsg;

  /*=============================================================================
  
     包：
       pkg_qa_lc(QA逻辑链包)
  
     过程名:
       Qa消息监听器逻辑
  
     入参:
       v_inp_msglistener  :  消息监听器 element_id
       v_inp_msgsender    :  消息发送器 element_id
       v_inp_second       :  秒
       v_inp_compid       :  企业Id
  
     版本:
       2022-12-09_ZC314 : Qa消息监听器逻辑
  
  ==============================================================================*/
  PROCEDURE p_msg_listenerlogic(v_inp_msglistener IN VARCHAR2,
                                v_inp_msgsender   IN VARCHAR2,
                                v_inp_second      IN NUMBER,
                                v_inp_compid      IN VARCHAR2) IS
    v_hasmsgnotsend   NUMBER(1);
    v_lastupdtime     DATE;
    v_selfdescription VARCHAR2(1024) := 'scmdata.pkg_qa_lc.p_msg_listenerinfo';
  BEGIN
    --获取是否存在未发送消息
    SELECT nvl(MAX(1), 0)
      INTO v_hasmsgnotsend
      FROM scmdata.t_qa_msginfo
     WHERE company_id = v_inp_compid
       AND msg_status = 'R'
       AND rownum = 1;
  
    --获取最近更新时间
    SELECT MAX(last_updtime)
      INTO v_lastupdtime
      FROM scmdata.t_variable
     WHERE obj_id = 'SCM_QA_MSG'
       AND var_type = 'VARCHAR'
       AND company_id = v_inp_compid;
  
    --当存在未发送消息且最近更新时间小于当前时间 - v_inp_second 秒时
    IF v_hasmsgnotsend > 0
       AND (v_lastupdtime IS NULL OR
       v_lastupdtime < SYSDATE - v_inp_second / (24 * 60 * 60)) THEN
      --监听器暂停
      scmdata.pkg_qa_ld.p_msg_updxxlinfotriggerstatus(v_inp_triggerstatus => 0,
                                                      v_inp_executorparam => v_inp_msglistener,
                                                      v_inp_invokeobj     => v_selfdescription);
    
      --消息发送器启动
      scmdata.pkg_qa_ld.p_msg_updxxlinfotriggerstatus(v_inp_triggerstatus => 1,
                                                      v_inp_executorparam => v_inp_msgsender,
                                                      v_inp_invokeobj     => v_selfdescription);
    END IF;
  END p_msg_listenerlogic;

  /*=============================================================================
  
     包：
       pkg_qa_lc(qa逻辑链包)
  
     函数名:
       Qa尺寸核对表新增/修改
  
     入参:
       v_inp_qarepid    :  Qa质检报告Id
       v_inp_position   :  部位
       v_inp_compid     :  企业Id
       v_inp_gooid      :  商品档案编号
       v_inp_barcode    :  条码
       v_inp_seqno      :  序号
       v_inp_actualsize :  实际尺码
       v_inp_curuserid  :  当前操作人Id
  
     版本:
       2022-12-14_zc314 : Qa尺寸核对表新增/修改
       2022-12-15_zc314 : 维度调整，增加尺寸表Id维度
       2023-01-04_zc314 : 维度调整，尺寸表Id变更为部位
  
  ==============================================================================*/
  PROCEDURE p_sizechart_insorupdqasizecheckchart(v_inp_qarepid    IN VARCHAR2,
                                                 v_inp_position   IN VARCHAR2,
                                                 v_inp_compid     IN VARCHAR2,
                                                 v_inp_gooid      IN VARCHAR2,
                                                 v_inp_barcode    IN VARCHAR2,
                                                 v_inp_seqno      IN NUMBER,
                                                 v_inp_actualsize IN NUMBER,
                                                 v_inp_curuserid  IN VARCHAR2) IS
    v_jugnum          NUMBER(1);
    v_operuserid      VARCHAR2(32);
    v_selfdescription VARCHAR2(1024) := 'scmdata.pkg_qa_lc.p_sizechart_insorupdqasizecheckchart';
  BEGIN
    --判断是否存在于Qa尺寸核对表中
    v_jugnum := scmdata.pkg_qa_da.f_is_qasizecheckchartexists(v_inp_qarepid  => v_inp_qarepid,
                                                              v_inp_position => v_inp_position,
                                                              v_inp_compid   => v_inp_compid,
                                                              v_inp_gooid    => v_inp_gooid,
                                                              v_inp_barcode  => v_inp_barcode,
                                                              v_inp_seqno    => v_inp_seqno);
  
    --如果不存在
    IF v_jugnum = 0 THEN
      scmdata.pkg_qa_ld.p_sizechart_insqasizecheckchart(v_inp_qarepid    => v_inp_qarepid,
                                                        v_inp_position   => v_inp_position,
                                                        v_inp_compid     => v_inp_compid,
                                                        v_inp_gooid      => v_inp_gooid,
                                                        v_inp_barcode    => v_inp_barcode,
                                                        v_inp_seqno      => v_inp_seqno,
                                                        v_inp_actualsize => v_inp_actualsize,
                                                        v_inp_curuserid  => v_inp_curuserid,
                                                        v_inp_invokeobj  => v_selfdescription);
    ELSE
      --获取当前数据操作人Id
      v_operuserid := scmdata.pkg_qa_da.f_get_qasizechartoperuserid(v_inp_qarepid  => v_inp_qarepid,
                                                                    v_inp_compid   => v_inp_compid,
                                                                    v_inp_position => v_inp_position,
                                                                    v_inp_gooid    => v_inp_gooid,
                                                                    v_inp_barcode  => v_inp_barcode,
                                                                    v_inp_seqno    => v_inp_seqno);
    
      --尺寸录入人校验
      IF v_operuserid <> v_inp_curuserid
         AND v_operuserid IS NOT NULL THEN
        raise_application_error(-20002, '非尺寸录入人不能操作当前数据！');
      END IF;
    
      --更新
      scmdata.pkg_qa_ld.p_sizechart_updqasizecheckchart(v_inp_qarepid    => v_inp_qarepid,
                                                        v_inp_position   => v_inp_position,
                                                        v_inp_compid     => v_inp_compid,
                                                        v_inp_gooid      => v_inp_gooid,
                                                        v_inp_barcode    => v_inp_barcode,
                                                        v_inp_seqno      => v_inp_seqno,
                                                        v_inp_actualsize => v_inp_actualsize,
                                                        v_inp_curuserid  => v_inp_curuserid,
                                                        v_inp_invokeobj  => v_selfdescription);
    
      --判断当前操作是否会清空 Qa尺寸录入记录
      v_jugnum := scmdata.pkg_qa_da.f_is_qasizechartupdtoempty(v_inp_qarepid => v_inp_qarepid,
                                                               v_inp_compid  => v_inp_compid,
                                                               v_inp_gooid   => v_inp_gooid,
                                                               v_inp_barcode => v_inp_barcode,
                                                               v_inp_seqno   => v_inp_seqno);
    
      IF v_jugnum = 1 THEN
        --报错
        raise_application_error(-20002,
                                '当前操作会清空此件Qa尺寸录入数据，不能执行！');
      END IF;
    END IF;
  END p_sizechart_insorupdqasizecheckchart;

  /*=============================================================================
  
     包：
       pkg_qa_lc(qa逻辑链包)
  
     函数名:
       根据Qa质检报告生成Qa尺寸核对表
  
     入参:
       v_inp_qarepid     :  Qa质检报告Id
       v_inp_compid      :  企业Id
       v_inp_gooid       :  商品档案编号
       v_inp_barcode     :  条码
       v_inp_seqno       :  序号
       v_inp_curuserid   :  当前操作人Id
  
     版本:
       2022-12-15_zc314 : 根据Qa质检报告生成Qa尺寸核对表
       2023-01-04_zc314 : 维度调整，尺寸表Id变更为部位
  
  ==============================================================================*/
  PROCEDURE p_sizechart_genqasizecheckchartbyqarep(v_inp_qarepid   IN VARCHAR2,
                                                   v_inp_compid    IN VARCHAR2,
                                                   v_inp_gooid     IN VARCHAR2,
                                                   v_inp_barcode   IN VARCHAR2,
                                                   v_inp_seqno     IN VARCHAR2,
                                                   v_inp_curuserid IN VARCHAR2) IS
    v_jugnum    NUMBER(1);
    v_relagooid VARCHAR2(32);
  BEGIN
    --判断商品是否存在尺寸表
    v_jugnum := scmdata.pkg_qa_da.f_is_goosizechartexists(v_inp_gooid  => v_inp_gooid,
                                                          v_inp_compid => v_inp_compid);
  
    --判断
    IF v_jugnum = 0 THEN
      --获取货号
      v_relagooid := scmdata.pkg_qa_da.f_get_relagooidbygooid(v_inp_gooid  => v_inp_gooid,
                                                              v_inp_compid => v_inp_compid);
    
      --如果不存在，报错
      raise_application_error(-20002,
                              '商品【' || v_relagooid || '】不存在尺寸表，请先生成尺寸表！');
    ELSE
      --如果存在，循环增改
      FOR i IN (SELECT DISTINCT position
                  FROM scmdata.t_size_chart sz
                 WHERE goo_id = v_inp_gooid
                   AND company_id = v_inp_compid) LOOP
        p_sizechart_insorupdqasizecheckchart(v_inp_qarepid    => v_inp_qarepid,
                                             v_inp_position   => i.position,
                                             v_inp_compid     => v_inp_compid,
                                             v_inp_gooid      => v_inp_gooid,
                                             v_inp_barcode    => v_inp_barcode,
                                             v_inp_seqno      => v_inp_seqno,
                                             v_inp_actualsize => NULL,
                                             v_inp_curuserid  => v_inp_curuserid);
      END LOOP;
    END IF;
  END p_sizechart_genqasizecheckchartbyqarep;

  /*=============================================================================
  
     包：
       pkg_qa_lc(qa逻辑链包)
  
     函数名:
       尺寸表新增 Qa尺寸表新增数据
  
     入参:
       v_inp_gooid      :  商品档案编号
       v_inp_compid     :  企业Id
       v_inp_curuserid  :  当前操作人Id
  
     版本:
       2023-01-04_zc314 : 尺寸表新增 Qa尺寸表新增数据
  
  ==============================================================================*/
  PROCEDURE p_sizechart_genqasizecheckchartkleakdatabysizechartins(v_inp_gooid     IN VARCHAR2,
                                                                   v_inp_compid    IN VARCHAR2,
                                                                   v_inp_curuserid IN VARCHAR2) IS
    v_jugnum          NUMBER(1);
    v_selfdescription VARCHAR2(1024) := 'scmdata.pkg_qa_lc.p_sizechart_genqasizecheckchartkleakdatabysizechartins';
  BEGIN
    --判断当前商品档案编号是否存在Qa尺寸核对表
    v_jugnum := scmdata.pkg_qa_da.f_is_gooexistinqasizecheckchart(v_inp_gooid  => v_inp_gooid,
                                                                  v_inp_compid => v_inp_compid);
  
    --判断，当前商品档案编号存在Qa尺寸核对表
    IF v_jugnum > 0 THEN
      --判断当前商品档案编号尺寸表内是否存在Qa尺寸核对表内不存在部位
      v_jugnum := scmdata.pkg_qa_da.f_is_goospositionnotexistsinqasizecheckchart(v_inp_gooid  => v_inp_gooid,
                                                                                 v_inp_compid => v_inp_compid);
    
      --判断，当前商品档案编号尺寸表内存在Qa尺寸核对表内不存在部位
      IF v_jugnum > 0 THEN
        --新增空数据
        FOR i IN (SELECT DISTINCT position, goo_id, company_id
                    FROM (SELECT qasz1.qa_report_id,
                                 qasz1.position qaposition,
                                 MAX(qasz1.seq_no) over(PARTITION BY qa_report_id) maxcnt,
                                 COUNT(qasz1.position) over(PARTITION BY qasz1.position) countcnt,
                                 sz1.position,
                                 sz1.goo_id,
                                 sz1.company_id
                            FROM scmdata.t_size_chart sz1
                            LEFT JOIN scmdata.t_qa_sizecheckchart qasz1
                              ON sz1.goo_id = qasz1.goo_id
                             AND sz1.position = qasz1.position
                             AND sz1.company_id = qasz1.company_id
                           WHERE sz1.goo_id = v_inp_gooid
                             AND sz1.company_id = v_inp_compid)
                   WHERE nvl(maxcnt, -1) <> nvl(countcnt, -1)) LOOP
        
          FOR l IN (SELECT DISTINCT qa_report_id,
                                    company_id,
                                    goo_id,
                                    barcode,
                                    seq_no
                      FROM scmdata.t_qa_sizecheckchart
                     WHERE goo_id = i.goo_id
                       AND company_id = i.company_id) LOOP
            --判断是否存在于Qa尺寸核对表中
            v_jugnum := scmdata.pkg_qa_da.f_is_qasizecheckchartexists(v_inp_qarepid  => l.qa_report_id,
                                                                      v_inp_position => i.position,
                                                                      v_inp_compid   => i.company_id,
                                                                      v_inp_gooid    => l.goo_id,
                                                                      v_inp_barcode  => l.barcode,
                                                                      v_inp_seqno    => l.seq_no);
          
            --如果不存在
            IF v_jugnum = 0 THEN
              scmdata.pkg_qa_ld.p_sizechart_insqasizecheckchart(v_inp_qarepid    => l.qa_report_id,
                                                                v_inp_position   => i.position,
                                                                v_inp_compid     => i.company_id,
                                                                v_inp_gooid      => l.goo_id,
                                                                v_inp_barcode    => l.barcode,
                                                                v_inp_seqno      => l.seq_no,
                                                                v_inp_actualsize => NULL,
                                                                v_inp_curuserid  => v_inp_curuserid,
                                                                v_inp_invokeobj  => v_selfdescription);
            
            END IF;
          END LOOP;
        
        END LOOP;
      END IF;
    END IF;
  END p_sizechart_genqasizecheckchartkleakdatabysizechartins;

  /*=============================================================================
  
     包：
       pkg_qa_lc(qa逻辑链包)
  
     过程名:
       尺寸表删除 Qa尺寸表作废数据
  
     入参:
       v_inp_gooid   :  商品档案编号
       v_inp_compid  :  企业Id
  
     版本:
       2023-01-04_zc314 : 尺寸表删除 Qa尺寸表作废数据
  
  ==============================================================================*/
  PROCEDURE p_sizechart_updqasizecheckchartbysizechartdel(v_inp_gooid     IN VARCHAR2,
                                                          v_inp_compid    IN VARCHAR2,
                                                          v_inp_curuserid IN VARCHAR2) IS
    v_selfdescription VARCHAR2(1024) := 'scmdata.pkg_qa_lc.p_sizechart_updqasizecheckchartbysizechartdel';
  BEGIN
    --更新对应的 Qa尺寸表作废数据
    scmdata.pkg_qa_ld.p_sizechart_updqasccisdeprecationastrue(v_inp_gooid     => v_inp_gooid,
                                                              v_inp_compid    => v_inp_compid,
                                                              v_inp_curuserid => v_inp_curuserid,
                                                              v_inp_invokeobj => v_selfdescription);
  END p_sizechart_updqasizecheckchartbysizechartdel;

  /*=============================================================================
  
     包：
       pkg_qa_lc(qa逻辑细节包)
  
     过程名:
       拿货action
  
     入参:
       v_inp_qarepid   :  Qa质检报告Id
       v_inp_compid    :  企业Id
       v_inp_cuserid   :  当前操作人Id
  
     版本:
       2023-01-09_zc314  :  拿货action
  
  ==============================================================================*/
  PROCEDURE p_takegood_takegood(v_inp_qarepid IN VARCHAR2,
                                v_inp_compid  IN VARCHAR2,
                                v_inp_cuserid IN VARCHAR2) IS
    v_checkers        VARCHAR2(1024);
    v_selfdescription VARCHAR2(1024) := 'scmdata.pkg_qa_lc.p_takegood_takegood';
  BEGIN
    --获取查货员
    v_checkers := scmdata.pkg_qa_da.f_get_qarepcheckers(v_inp_qarepid => v_inp_qarepid,
                                                        v_inp_compid  => v_inp_compid);
  
    --当操作人不存在于已有查货员
    IF instr(nvl(v_checkers, ' '), nvl(v_inp_cuserid, ' ')) = 0 THEN
      scmdata.pkg_qa_ld.p_goodtake_updqarepcheckers(v_inp_qarepid   => v_inp_qarepid,
                                                    v_inp_compid    => v_inp_compid,
                                                    v_inp_checkers  => v_checkers || ';' ||
                                                                       v_inp_cuserid,
                                                    v_inp_curuserid => v_inp_cuserid,
                                                    v_inp_invokeobj => v_selfdescription);
    END IF;
  END p_takegood_takegood;

END pkg_qa_lc;
/

