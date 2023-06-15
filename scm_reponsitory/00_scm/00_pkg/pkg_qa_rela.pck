CREATE OR REPLACE PACKAGE SCMDATA.PKG_QA_RELA IS

  --更新不合格项字符串
  PROCEDURE P_UPDATE_UQUAL_STR(V_QAREPID   IN VARCHAR2,
                               V_COMPID    IN VARCHAR2);

  --校验必填项
  PROCEDURE P_CHECK_QAREPORT_NESINFO(V_QA_REPORT_ID  IN VARCHAR2,
                                     V_COMPANY_ID    IN VARCHAR2);

  --无条件必填字段校验
  FUNCTION F_CHECK_QAREPORT_NOCOND_NESINFO(V_QA_REPORT_ID IN VARCHAR2,
                                           V_COMPANY_ID   IN VARCHAR2) RETURN CLOB;

  --QA质检报告条件必填校验
  FUNCTION F_QAREPORT_CHECK_COND_NESINFO(V_QA_REPORT_ID   IN VARCHAR2,
                                         V_COMPANY_ID     IN VARCHAR2,
                                         V_EINFO          IN CLOB) RETURN CLOB;

  --质检结果校验
  PROCEDURE P_CHECK_QA_RESULT(V_QA_REPORT_ID  IN VARCHAR2,
                              V_COMPANY_ID    IN VARCHAR2,
                              V_OPERATE       IN VARCHAR2 DEFAULT 'COMMIT');

  --校验 QA_SCOPE.PROCESSING_TYPE = ' '
  PROCEDURE P_CHECK_QASCOPE_PROCESSING_TYPE(V_QAREPID   IN VARCHAR2,
                                            V_COMPID    IN VARCHAR2);

  --QA质检报告提交校验
  PROCEDURE P_QA_REPORT_COMMIT_CHECK(V_QARID   IN VARCHAR2,
                                     V_COMPID  IN VARCHAR2);

  --SKU质检确认
  PROCEDURE P_QA_COMFIRM_CHECK_SKU(V_QAREPORT_ID IN VARCHAR2,
                                   V_COMPANY_ID  IN VARCHAR2);

  --QA_CONFIG校验
  PROCEDURE P_QA_CONFIG_CHECK(QA_CLAS  IN VARCHAR2,
                              QA_PROC  IN VARCHAR2,
                              QA_SUBC  IN VARCHAR2,
                              QA_CID   IN VARCHAR2,
                              QA_COMP  IN VARCHAR2);

  --待检/已检列表数量相关更新
  PROCEDURE P_UPDATE_REP_AMOUNT(V_QAREPID IN VARCHAR2,
                                V_COMPID  IN VARCHAR2,
                                V_CURUSER IN VARCHAR2);

  --质检报告更新汇总数量
  PROCEDURE P_UPDATE_REP_SUMAMOUNT(V_QAREPID IN VARCHAR2,
                                   V_COMPID  IN VARCHAR2,
                                   V_CURUSER IN VARCHAR2);

  --质检报告更新汇总数量(用于新增)
  PROCEDURE P_UPDATE_REP_SUMAMOUNT_WITHOUT_UPDINFO(V_QAREPID IN VARCHAR2,
                                                   V_COMPID  IN VARCHAR2);

  --质检报告更新次品数量
  PROCEDURE P_UPDATE_REP_SUBSAMOUNT(V_QAREPID IN VARCHAR2,
                                    V_COMPID  IN VARCHAR2,
                                    V_CURUSER IN VARCHAR2);

  --质检报告通过类型更新汇总数量
  PROCEDURE P_UPDATE_REP_SUMAMOUNT_BY_TYPE(V_QAREPID IN VARCHAR2,
                                           V_COMPID  IN VARCHAR2,
                                           V_CURUSER IN VARCHAR2);

  --生成批版记录sql
  FUNCTION F_GET_QA_APPROVE_VERSION_SQL(V_ID      IN VARCHAR2,
                                        V_COMPID  IN VARCHAR2) RETURN CLOB;


  --生成面料检测sql
  FUNCTION F_GET_QA_FABRIC_SQL(V_ID      IN VARCHAR2,
                               V_COMPID  IN VARCHAR2) RETURN CLOB;

  --生成产前会sql
  FUNCTION F_GET_QC_PRE_MEETING_SQL(V_ID      IN VARCHAR2,
                                    V_COMPID  IN VARCHAR2) RETURN CLOB;

  --生成洗水测试sql
  FUNCTION F_GET_QC_WASH_TESTING_SQL(V_ID      IN VARCHAR2,
                                     V_COMPID  IN VARCHAR2) RETURN CLOB;

  --生成qc其余检测环节sql
  FUNCTION F_GET_QC_ELSE_SQL(V_ID      IN VARCHAR2,
                             V_COMPID  IN VARCHAR2) RETURN CLOB;

  --生成QA检测sql
  FUNCTION F_GET_QA_REPORT_SQL(V_ID      IN VARCHAR2,
                               V_COMPID  IN VARCHAR2) RETURN CLOB;

  --获取多重展示页面正确sql
  FUNCTION F_GET_RIGHT_SQL_FOR_MULTI_VIEW(V_ID      IN VARCHAR2,
                                          V_COMPID  IN VARCHAR2) RETURN CLOB;


  --获取修改质检范围-添加ASN单sql
  FUNCTION F_GET_ASN_ADDED_SQL(V_QAREPID   IN VARCHAR2,
                               V_COMPID    IN VARCHAR2) RETURN CLOB;

  --获取不合格处理明细-添加明细sql
  FUNCTION F_GET_UNQUAL_ADD_DETAIL_SQL(V_QAREPID   IN VARCHAR2,
                                       V_COMPID    IN VARCHAR2) RETURN CLOB;

  --校验QA单据是否重复提交
  PROCEDURE P_CHECK_REP_REPEAT_COMMIT(V_QAREPID   IN VARCHAR2,
                                      V_COMPID    IN VARCHAR2);

  --当不合格处理明细等于整批返工/整批拒收时，更新QASCOPE表
  PROCEDURE P_UPDATE_QAUNQUAL_TREATMENT(V_QAREPID   IN VARCHAR2,
                                        V_COMPID    IN VARCHAR2);

  --更新QAreport相关值
  PROCEDURE P_UPDATE_VALUE_AFTER_COMMIT_CHECK(V_QAREPID   IN VARCHAR2,
                                              V_COMPID    IN VARCHAR2,
                                              V_CUID      IN VARCHAR2);

  --QA报告提交相关逻辑
  PROCEDURE P_QAREP_COMMIT(V_QAREPID   IN VARCHAR2,
                           V_COMPID    IN VARCHAR2,
                           V_CUID      IN VARCHAR2);

  --编辑质检报告部分
  --获取QA质检报告编辑页面sql
  FUNCTION F_GET_EDIT_QAREP_SQL(V_QAREPID   IN VARCHAR2,
                                V_COMPID    IN VARCHAR2,
                                V_CUID      IN VARCHAR2,
                                ASS_METHOD  IN VARCHAR2) RETURN CLOB;

  --编辑质检报告部分-修改相关逻辑
  PROCEDURE P_UPDATE_QAREP(V_QAREP_RAC IN scmdata.t_qa_report_backup%ROWTYPE);


  --质检报告按钮跳转页面部分
  --修改质检范围部分
  --获取修改质检范围sql-select_sql
  FUNCTION F_GET_CHANGE_QAREPORT_SCOPE_SQL(V_QAREPID  IN VARCHAR2,
                                           V_COMPID   IN VARCHAR2) RETURN CLOB;

  --修改质检范围update_sql
  PROCEDURE P_CHANGE_QUAL_RANGE_INSERT(V_ASNID   IN VARCHAR2,
                                       V_COMPID  IN VARCHAR2,
                                       V_QAREPID IN VARCHAR2,
                                       V_CUID    IN VARCHAR2);

  --修改质检范围delete_sql
  PROCEDURE P_CHANGE_QUAL_RANGE_DELETE(V_QAREPID  IN VARCHAR2,
                                       V_COMPID   IN VARCHAR2,
                                       V_ASNID    IN VARCHAR2);

  --修改质检范围删除前校验
  PROCEDURE P_CHECK_BEFORE_QUAL_RANGE_DELETE(V_QAREPID  IN VARCHAR2,
                                             V_COMPID   IN VARCHAR2,
                                             V_ASNID    IN VARCHAR2);

  --修改质检范围-删除核
  PROCEDURE P_CHANGE_QUAL_RANGE_DELETE_CORE(V_QAREPID  IN VARCHAR2,
                                            V_COMPID   IN VARCHAR2,
                                            V_ASNID    IN VARCHAR2);

  --修改质检范围从表-select_sql
  FUNCTION F_GET_QUALIFY_SKU_DETAIL_SQL(V_QAREPID  IN VARCHAR2,
                                        V_COMPID   IN VARCHAR2,
                                        V_ASNID    IN VARCHAR2) RETURN CLOB;

  --不合格处理明细部分sql
  --不合格处理明细select_sql
  FUNCTION F_GET_UNQUAL_TREATMENT_SQL(V_QAREPID  IN VARCHAR2,
                                      V_COMPID   IN VARCHAR2) RETURN CLOB;

  --不合格处理明细update_sql
  PROCEDURE P_UNQUAL_TREATMENT_UPDATE(V_QASCOPEID  IN VARCHAR2,
                                      V_PROTYPE    IN VARCHAR2,
                                      V_CUID       IN VARCHAR2,
                                      V_COMPID     IN VARCHAR2);

  --不合格处理明细update_sql-不合格处理明细更新前校验
  PROCEDURE P_UNQUAL_TREATMENT_CHECK_BEFORE_UPDATE(V_QASCOPEID  IN VARCHAR2,
                                                   V_COMPID     IN VARCHAR2,
                                                   V_PROTYPE    IN VARCHAR2);

  --不合格处理明细update_sql-不合格处理明细更新核
  PROCEDURE P_UNQUAL_TREATMENT_UPDATE_CORE(V_QASCOPEID  IN VARCHAR2,
                                           V_PROTYPE    IN VARCHAR2,
                                           V_CUID       IN VARCHAR2,
                                           V_COMPID     IN VARCHAR2);

  --不合格处理明细-insert_sql
  PROCEDURE P_UNQUAL_TREAETMENT_INSERT(V_QASCOPEID IN VARCHAR2,
                                       V_COMPID    IN VARCHAR2);

  --不合格处理明细——delete_sql
  PROCEDURE P_UNQUAL_TREAETMENT_DELETE(V_QASCOPEID IN VARCHAR2,
                                       V_CURUSER   IN VARCHAR2,
                                       V_COMPID    IN VARCHAR2);

  --维护次品数量部分
  --维护次品数量-select_sql
  FUNCTION F_GET_SUBS_SQL(V_QAREPID  IN VARCHAR2,
                          V_COMPID   IN VARCHAR2) RETURN CLOB;


  --维护次品数量-update_sql
  PROCEDURE P_SUBS_UPDATE(V_QASCOPEID  IN VARCHAR2,
                          V_COMPID     IN VARCHAR2,
                          V_ANOMPB     IN VARCHAR2,
                          V_SUBSAMOUNT IN NUMBER,
                          V_CUID       IN VARCHAR2);

  --维护次品数量-修改前校验
  PROCEDURE P_SUBS_CHECK_BEFORE_UPDATE(V_QASCOPEID  IN VARCHAR2,
                                       V_COMPID     IN VARCHAR2,
                                       V_ANOMPB     IN VARCHAR2,
                                       V_SUBSAMOUNT IN NUMBER,
                                       V_QAREPID    IN OUT VARCHAR2,
                                       V_GOOID      IN OUT VARCHAR2,
                                       V_BARCODE    IN OUT VARCHAR2,
                                       V_ASNID      IN OUT VARCHAR2);

  --维护次品数量-更新核
  PROCEDURE P_SUBS_UPDATE_CORE(V_QAREPID    IN VARCHAR2,
                               V_QASCOPEID  IN VARCHAR2,
                               V_COMPID     IN VARCHAR2,
                               V_ANOMPB     IN VARCHAR2,
                               V_SUBSAMOUNT IN NUMBER,
                               V_ASNID      IN VARCHAR2,
                               V_GOOID      IN VARCHAR2,
                               V_BARCODE    IN VARCHAR2,
                               V_CUID       IN VARCHAR2);

  --生成次品记录
  PROCEDURE P_GEN_SUBS_DATA(V_QAREPID  IN VARCHAR2,
                            V_COMPID   IN VARCHAR2);

  --删除次品记录
  PROCEDURE P_DELETE_SUBSAMT_RECORD(V_QAREPID IN VARCHAR2,
                                    V_COMPID  IN VARCHAR2);

  /*=====================================================================================

    清空返工次品

    用途:
      用于将 QA 质检报告中质检确认结果为：返工 的次品清零

    入参:
      V_QAREPIDS  :  质检报告Id，多值用逗号分隔
      V_QASCPIDS  :  质检SCOPEId，多值用逗号分隔
      V_CURUSER   :  当前操作人
      V_COMPID    :  企业Id

    版本:
      2021-11-20 : 用于将 QA 质检报告中质检确认结果为：返工 的次品清零

  =====================================================================================*/
  PROCEDURE P_RT_CLEAR_SUBSAMT(V_QAREPIDS  IN VARCHAR2 DEFAULT NULL,
                               V_QASCPIDS  IN VARCHAR2 DEFAULT NULL,
                               V_CURUSER   IN VARCHAR2,
                               V_COMPID    IN VARCHAR2);



  /*=====================================================================================

    通过【SKU条码】和【质检报告范围ID】更新预到货收货量

    用途:
      通过【SKU条码】和【质检报告范围ID】更新预到货收货量

    入参:
      V_ASNID    :  ASN单号
      V_COMPID   :  企业Id
      V_GOOID    :  货号
      V_BARCODE  :  SKU条码

    版本:
      2022-01-05 : 通过【SKU条码】和【质检报告范围ID】更新预到货收货量

  =====================================================================================*/
  PROCEDURE P_UPDATE_ASNGOTAMT_WITH_BARCODEANDSCPID(V_ASNID      IN VARCHAR2,
                                                    V_COMPID     IN VARCHAR2,
                                                    V_GOOID      IN VARCHAR2,
                                                    V_BARCODE    IN VARCHAR2,
                                                    V_QASCOPEID  IN VARCHAR2);



  /*=====================================================================================

    通过【货号】和【质检报告范围ID】更新预到货收货量

    用途:
      通过【货号】和【质检报告范围ID】更新预到货收货量

    入参:
      V_ASNID    :  ASN单号
      V_COMPID   :  企业Id
      V_GOOID    :  货号

    版本:
      2022-01-05 : 通过【货号】和【质检报告范围ID】更新预到货收货量

  =====================================================================================*/
  PROCEDURE P_UPDATE_ASNGOTAMT_WITH_GOOIDANDSCPID(V_ASNID      IN VARCHAR2,
                                                  V_COMPID     IN VARCHAR2,
                                                  V_GOOID      IN VARCHAR2,
                                                  V_QASCOPEID  IN VARCHAR2);



  /*=====================================================================================

    更新预到货收货量

    用途:
      更新预到货收货量

    入参:
      V_ASNID    :  ASN单号
      V_COMPID   :  企业Id

    版本:
      2022-01-05 : 更新预到货收货量

  =====================================================================================*/
  PROCEDURE P_UPDATE_ASNGOTAMT(V_QAREPID   IN VARCHAR2,
                               V_COMPID    IN VARCHAR2);


  /*===================================================================================

    Qa已检预增改表-增改

    用途:
       Qa已检预增改表-增改

    入参:
      V_ASNID    :  ASN编号
      V_COMPID   :  企业Id

    版本:
      2022-06-10 :  Qa已检预增改表-增改

  ===================================================================================*/
  PROCEDURE P_IU_QA_QUALEDLIST_PREIU(V_ASNID   IN VARCHAR2,
                                     V_COMPID  IN VARCHAR2);

  /*===================================================================================

    Qa已检预增改表-数据同步

    用途:
       Qa已检预增改表-数据同步

    版本:
      2022-06-10 :  Qa已检预增改表-数据同步

  ===================================================================================*/
  PROCEDURE P_QA_QUALLIST_PREIU_SYNC;

  /*===================================================================================

    生成已检列表 asn 基础维度数据（注意已检列表拒收和返工计算方式）

    用途:
      生成已检列表 asn 基础维度数据（注意已检列表拒收和返工计算方式）

    入参:
      V_ASNID    :  ASN编号
      V_COMPID   :  企业Id

    版本:
      2022-06-10 : 生成已检列表 asn 基础维度数据（注意已检列表拒收和返工计算方式）

  ===================================================================================*/
  PROCEDURE P_IU_QUALEDLIST_BASICDIM(V_ASNID   IN VARCHAR2,
                                     V_COMPID  IN VARCHAR2);

  /*===================================================================================

    生成已检列表 asn 基础维度数据（特批放行）

    用途:
      生成已检列表 asn 基础维度数据（特批放行）

    入参:
      V_ASNID    :  ASN编号
      V_COMPID   :  企业Id

    版本:
      2022-06-10 : 生成已检列表 asn 基础维度数据（特批放行）

  ===================================================================================*/
  PROCEDURE P_IU_QUALEDLIST_BASICDIM_SA(V_ASNID     IN VARCHAR2,
                                        V_COMPID    IN VARCHAR2);

  /*===================================================================================

    生成已检列表 asn 基础维度数据（特批放行）

    用途:
      生成已检列表 asn 基础维度数据（特批放行）

    入参:
      V_ASNID    :  ASN编号
      V_COMPID   :  企业Id

    版本:
      2022-06-10 : 生成已检列表 asn 基础维度数据（特批放行）

  ===================================================================================*/
  PROCEDURE P_IU_QUALEDLIST_BASICDIM_CD(V_ASNID     IN VARCHAR2,
                                        V_COMPID    IN VARCHAR2);

  /*===================================================================================

    已检列表 asn 基础维度数据增改核

    用途:
      已检列表 asn 基础维度数据增改核

    入参:
      V_ASNID        :  ASN编号
      V_COMPID       :  企业Id
      V_GOOID        :  商品档案编号
      V_BARCODE      :  SKU条码
      V_ORDID        :  订单号
      V_PCOMEAMT     :  预计到仓数量（计算公式：sku预计到仓数量-拒收数量）
      V_GOTAMT       :  到仓数量（计算公式：sku到仓数量-拒收数量）
      V_SUBSAMT      :  次品数量（计算公式：sku次品数量汇总）
      V_REJAMT       :  拒收数量（sku质检确认结果 = 不通过时，取sku到仓数量，否则为 0 ）
      V_RETAMT       :  返工数量（sku质检确认结果 = 返工时，取sku到仓数量，否则为 0 ）
      V_SKUCFRESULT  :  SKU质检确认结果
      V_PCOMEDATE    :  预计到仓日期
      V_SCANTIME     :  到仓扫描时间
      V_RECEIVETIME  :  上架时间

    版本:
      2022-06-10 : 已检列表 asn 基础维度数据增改核

  ===================================================================================*/
  PROCEDURE P_IU_QUALEDLIST_BASICDIM_CORE(V_ASNID        IN VARCHAR2,
                                          V_COMPID       IN VARCHAR2,
                                          V_GOOID        IN VARCHAR2,
                                          V_BARCODE      IN VARCHAR2,
                                          V_ORDID        IN VARCHAR2,
                                          V_PCOMEAMT     IN NUMBER,
                                          V_GOTAMT       IN NUMBER,
                                          V_SUBSAMT      IN NUMBER,
                                          V_REJAMT       IN NUMBER,
                                          V_RETAMT       IN NUMBER,
                                          V_SKUCFRESULT  IN VARCHAR2,
                                          V_SKUCFUSERID  IN VARCHAR2,
                                          V_SKUCFTIME    IN DATE,
                                          V_PCOMEDATE    IN DATE,
                                          V_SCANTIME     IN DATE,
                                          V_RECEIVETIME  IN DATE);

  /*=====================================================================================

    增/改 Qa已检列表数据

    用途:
      增/改 Qa已检列表数据

    入参:
      V_ASNID    :  ASN单号
      V_COMPID   :  企业Id

    版本:
      2022-01-05 : 增/改 Qa已检列表数据

  =====================================================================================*/
  PROCEDURE P_IU_QUALEDLIST(V_ASNID  VARCHAR2,
                            V_COMPID VARCHAR2);

END PKG_QA_RELA;
/

CREATE OR REPLACE PACKAGE BODY SCMDATA.PKG_QA_RELA IS

  --更新不合格项字符串
  PROCEDURE P_UPDATE_UQUAL_STR(V_QAREPID   IN VARCHAR2,
                               V_COMPID    IN VARCHAR2) IS
    V_STR  VARCHAR2(512);
  BEGIN
    SELECT DECODE(YY_RESULT,'NP','样衣不符合',NULL)||';'||
           DECODE(MFL_RESULT,'NP','面辅料不合格',NULL)||';'||
           DECODE(GY_RESULT,'NP','工艺不合格',NULL)||';'||
           DECODE(BX_RESULT,'NP','版型尺寸不合格',NULL)||';'
      INTO V_STR
      FROM scmdata.t_qa_report_backup
     WHERE QA_REPORT_ID = V_QAREPID
       AND COMPANY_ID = V_COMPID;

    V_STR := LTRIM(REGEXP_REPLACE(V_STR,';{1,}',';'),';');

    UPDATE scmdata.t_qa_report_backup
       SET UNQUAL_SUBJUECTS = V_STR
     WHERE QA_REPORT_ID = V_QAREPID
       AND COMPANY_ID = V_COMPID;
  END P_UPDATE_UQUAL_STR;

  --校验必填项
  PROCEDURE P_CHECK_QAREPORT_NESINFO(V_QA_REPORT_ID  IN VARCHAR2,
                                     V_COMPANY_ID    IN VARCHAR2) IS
    EINFO CLOB;
  BEGIN
    --无条件必填字段
    EINFO := F_CHECK_QAREPORT_NOCOND_NESINFO(V_QA_REPORT_ID => V_QA_REPORT_ID,
                                             V_COMPANY_ID   => V_COMPANY_ID);

    --条件必填字段
    EINFO := F_QAREPORT_CHECK_COND_NESINFO(V_QA_REPORT_ID => V_QA_REPORT_ID,
                                           V_COMPANY_ID   => V_COMPANY_ID,
                                           V_EINFO        => EINFO);

    IF REGEXP_COUNT(REPLACE(EINFO,'当QA质检报告不合格时:',''),'\w') > 0 THEN
      RAISE_APPLICATION_ERROR(-20002,EINFO);
    END IF;

  END P_CHECK_QAREPORT_NESINFO;


  --无条件必填字段校验
  FUNCTION F_CHECK_QAREPORT_NOCOND_NESINFO(V_QA_REPORT_ID IN VARCHAR2,
                                           V_COMPANY_ID   IN VARCHAR2) RETURN CLOB IS
    TMPNUM1  NUMBER(8);
    TMPNUM2  NUMBER(8);
    TMPNUM3  NUMBER(8);
    TMPSTR1  VARCHAR2(8);
    TMPSTR2  VARCHAR2(8);
    TMPSTR3  VARCHAR2(512);
    TMPDATE1 DATE;
    ERRINFO  CLOB;
  BEGIN
    --首抽件数，质检员，质检日期，质检结果必填
    SELECT MAX(FIRSTCHECK_AMOUNT), MAX(ADDCHECK_AMOUNT),
           MAX(PCOMESUM_AMOUNT), MAX(CHECK_RESULT),
           MAX(UNQUAL_TREATMENT), MAX(CHECKERS), MAX(CHECK_DATE)
      INTO TMPNUM1, TMPNUM2, TMPNUM3, TMPSTR1, TMPSTR2, TMPSTR3, TMPDATE1
      FROM scmdata.t_qa_report_backup
     WHERE QA_REPORT_ID = V_QA_REPORT_ID
       AND COMPANY_ID = V_COMPANY_ID;

    IF TMPNUM1 IS NULL THEN
      ERRINFO := ERRINFO || CHR(10) || '字段【首抽件数】必填';
    ELSIF TMPNUM3 < TMPNUM1 THEN
      ERRINFO := ERRINFO || CHR(10) || '字段【首抽件数】不能大于【预计到仓件数】';
    END IF;

    IF NVL(TMPNUM3,0) < NVL(TMPNUM1,0) + NVL(TMPNUM2,0) THEN
      ERRINFO := ERRINFO || CHR(10) || '字段【首抽件数】+字段【加抽件数】不能大于【预计到仓件数】';
    END IF;

    IF TMPSTR1 IS NULL THEN
      ERRINFO := ERRINFO || CHR(10) || '字段【质检结果】必填';
    ELSIF TMPSTR1 = 'QU' AND TMPSTR2 <> 'NON' THEN
      ERRINFO := ERRINFO || CHR(10) || '当【质检结果】为“合格”，【不合格处理】必须为“无”！';
    ELSIF TMPSTR1 = 'UQ' AND TMPSTR2 = 'NON' THEN
      ERRINFO := ERRINFO || CHR(10) || '当【质检结果】为“不合格”，【不合格处理】不能为“无”！';
    END IF;

    IF TMPSTR3 IS NULL THEN
      ERRINFO := ERRINFO || CHR(10) || '字段【查货员】必填';
    END IF;

    IF TRUNC(TMPDATE1) > TRUNC(SYSDATE) THEN
      ERRINFO := ERRINFO || CHR(10) || '质检日期不能大于当前日期！';
    END IF;

    ERRINFO := LTRIM(ERRINFO,CHR(10));

    RETURN ERRINFO;
  END F_CHECK_QAREPORT_NOCOND_NESINFO;





  --QA质检报告条件必填校验
  FUNCTION F_QAREPORT_CHECK_COND_NESINFO(V_QA_REPORT_ID   IN VARCHAR2,
                                         V_COMPANY_ID     IN VARCHAR2,
                                         V_EINFO          IN CLOB) RETURN CLOB IS
    V_CHECK_RESULT       VARCHAR2(8);
    V_YY_RESULT          VARCHAR2(8);
    V_YY_UQDESC          VARCHAR2(512);
    V_MFL_RESULT         VARCHAR2(8);
    V_MFL_UQDESC         VARCHAR2(512);
    V_GY_RESULT          VARCHAR2(8);
    V_GY_UQDESC          VARCHAR2(512);
    V_BX_RESULT          VARCHAR2(8);
    V_BX_UQDESC          VARCHAR2(512);
    V_SUBS_AMOUNT        NUMBER(8);
    V_UNQUAL_AMOUNT      NUMBER(8);
    V_CHECKSUM_AMOUNT    NUMBER(8);
    V_UNQUALREASONCLASS  VARCHAR2(16);
    V_ERRINFO            CLOB;
  BEGIN
    SELECT CHECK_RESULT,YY_RESULT,YY_UQDESC,MFL_RESULT,MFL_UQDESC,GY_RESULT,GY_UQDESC,BX_RESULT,
           BX_UQDESC,SUBS_AMOUNT,UNQUAL_AMOUNT,CHECKSUM_AMOUNT,UNQUALREASON_CLASS
      INTO V_CHECK_RESULT,V_YY_RESULT,V_YY_UQDESC,V_MFL_RESULT,V_MFL_UQDESC,V_GY_RESULT,V_GY_UQDESC,
           V_BX_RESULT,V_BX_UQDESC,V_SUBS_AMOUNT,V_UNQUAL_AMOUNT,V_CHECKSUM_AMOUNT,V_UNQUALREASONCLASS
      FROM scmdata.t_qa_report_backup
     WHERE QA_REPORT_ID = V_QA_REPORT_ID
       AND COMPANY_ID = V_COMPANY_ID;

    IF V_CHECK_RESULT = 'UQ' THEN
      IF V_UNQUAL_AMOUNT IS NULL THEN
        V_ERRINFO := V_ERRINFO || CHR(10) || '【不合格数】结果必填！';
        IF V_UNQUAL_AMOUNT IS NOT NULL AND V_UNQUAL_AMOUNT > V_CHECKSUM_AMOUNT THEN
          V_ERRINFO := V_ERRINFO || CHR(10) || '【不合格数】不能大于【抽查件数】';
        END IF;
      END IF;

      IF V_YY_RESULT IS NULL THEN
        V_ERRINFO := V_ERRINFO || CHR(10) || '【样衣核对】结果必填！';
      ELSIF V_YY_RESULT = 'NP' AND V_YY_UQDESC IS NULL THEN
         V_ERRINFO := V_ERRINFO || CHR(10) || '当样衣核对结果不合格时，【不合格项】必选！';
      END IF;

      IF V_MFL_RESULT IS NULL THEN
        V_ERRINFO := V_ERRINFO || CHR(10) || '【面辅料查验】结果必填！';
      ELSIF V_MFL_RESULT = 'NP' AND V_MFL_UQDESC IS NULL THEN
         V_ERRINFO := V_ERRINFO || CHR(10) || '当面辅料查验结果不合格时，【不合格项】必选！';
      END IF;

      IF V_GY_RESULT IS NULL THEN
        V_ERRINFO := V_ERRINFO || CHR(10) || '【工艺查验】结果必填！';
      ELSIF V_GY_RESULT = 'NP' AND V_GY_UQDESC IS NULL THEN
         V_ERRINFO := V_ERRINFO || CHR(10) || '当工艺查验结果不合格时，【不合格项】必选！';
      END IF;

      IF V_BX_RESULT IS NULL THEN
        V_ERRINFO := V_ERRINFO || CHR(10) || '【版型尺寸查验】结果必填！';
      ELSIF V_BX_RESULT = 'NP' AND V_BX_UQDESC IS NULL THEN
        V_ERRINFO := V_ERRINFO || CHR(10) || '当版型尺寸查验结果不合格时，【不合格项】必选！';
      END IF;

      IF V_UNQUALREASONCLASS IS NULL OR V_UNQUALREASONCLASS = 'NONE' THEN
        V_ERRINFO := V_ERRINFO || CHR(10) || '【不合格原因分类】必填！';
      END IF;
    END IF;

    IF REGEXP_INSTR(V_ERRINFO,'\w') > 0 THEN
      V_ERRINFO := V_EINFO || CHR(10) || '当QA质检报告不合格时:' || CHR(10) || V_ERRINFO;
    ELSE
      V_ERRINFO := V_EINFO;
    END IF;
    RETURN V_ERRINFO;

  END F_QAREPORT_CHECK_COND_NESINFO;


  --质检结果校验
  PROCEDURE P_CHECK_QA_RESULT(V_QA_REPORT_ID  IN VARCHAR2,
                              V_COMPANY_ID    IN VARCHAR2,
                              V_OPERATE       IN VARCHAR2 DEFAULT 'COMMIT') IS
    V_RESULT    VARCHAR2(8);
    V_UT        VARCHAR2(8);
    V_UQNUM     NUMBER(4);
    V_CT        VARCHAR2(8);
    V_ORIGIN    VARCHAR2(8);
    V_JUG_NUM   NUMBER(4);
    V_ASNIDS    VARCHAR2(4000);
    V_BCSKUS    VARCHAR2(4000);
    V_AEINFO    VARCHAR2(4000);
    V_PRESTR    VARCHAR2(32);
  BEGIN
    SELECT MAX(CHECK_RESULT),
           MAX(UNQUAL_TREATMENT),
           MAX(CHECK_TYPE),
           MAX(ORIGIN)
      INTO V_RESULT, V_UT, V_CT, V_ORIGIN
      FROM scmdata.t_qa_report_backup
     WHERE QA_REPORT_ID = V_QA_REPORT_ID
       AND COMPANY_ID = V_COMPANY_ID;

    SELECT LISTAGG(DISTINCT ASN_ID,', ')||', ',LISTAGG(DISTINCT BARCODE,', ')||', '
      INTO V_ASNIDS,V_BCSKUS
      FROM scmdata.t_qa_scope_backup
     WHERE QA_REPORT_ID = V_QA_REPORT_ID
       AND COMPANY_ID = V_COMPANY_ID;

    SELECT COUNT(1)
      INTO V_UQNUM
      FROM scmdata.t_qa_scope_backup
     WHERE QA_REPORT_ID = V_QA_REPORT_ID
       AND COMPANY_ID = V_COMPANY_ID
       AND PROCESSING_TYPE IN ('RJ','RT');

    SELECT LISTAGG(DISTINCT COL,';')
      INTO V_AEINFO
      FROM (SELECT B.ASN_ID || ':' || LISTAGG(C.COLORNAME||'+'||C.SIZENAME,',') COL
      FROM scmdata.t_qa_report_backup A
     INNER JOIN scmdata.t_qa_scope_backup B
        ON A.QA_REPORT_ID = B.QA_REPORT_ID
       AND A.QA_REPORT_ID <> V_QA_REPORT_ID
       AND A.COMPANY_ID = B.COMPANY_ID
       AND INSTR('N_PCF, N_ACF, R_PCF, R_ACF, ', A.STATUS||',') > 0
       AND INSTR(V_ASNIDS, B.ASN_ID || ',') > 0
       AND INSTR(V_BCSKUS, B.BARCODE || ',') > 0
     INNER JOIN SCMDATA.T_COMMODITY_COLOR_SIZE C
        ON B.BARCODE = C.BARCODE
       AND C.COMPANY_ID = C.COMPANY_ID
     GROUP BY B.ASN_ID,B.COMPANY_ID);

    IF V_OPERATE = 'COMMIT' THEN
      V_PRESTR := '提交失败！';
    ELSIF V_OPERATE = 'CONFIRM' THEN
      V_PRESTR := '质检确认失败！';
    END IF;


    IF V_RESULT = 'UQ' AND V_UT = 'PTJ' THEN
      SELECT SIGN(COUNT(1))
        INTO V_JUG_NUM
        FROM scmdata.t_qa_scope_backup
       WHERE QA_REPORT_ID = V_QA_REPORT_ID
         AND COMPANY_ID = V_COMPANY_ID
         AND PROCESSING_TYPE IN ('RJ','RT');
      IF V_JUG_NUM = 0 THEN
        RAISE_APPLICATION_ERROR(-20002,V_PRESTR||'不合格处理为【部分拒收/返工】，请维护不合格处理明细。');
      END IF;
    ELSIF V_RESULT = 'QU' AND V_UQNUM > 0 THEN
      RAISE_APPLICATION_ERROR(-20002,V_PRESTR||'质检结果为合格，【不合格处理明细】数据需为空，请检查。');
    ELSIF V_AEINFO IS NOT NULL AND V_CT <> 'RC' AND INSTR(V_ORIGIN,'WMS') = 0 THEN
      RAISE_APPLICATION_ERROR(-20002,V_AEINFO||';已提交质检报告，请修改质检范围！');
    END IF;
  END P_CHECK_QA_RESULT;


  --校验 QA_SCOPE.PROCESSING_TYPE = ' '
  PROCEDURE P_CHECK_QASCOPE_PROCESSING_TYPE(V_QAREPID   IN VARCHAR2,
                                            V_COMPID    IN VARCHAR2) IS
    V_JUGNUM NUMBER(1);
  BEGIN
    SELECT COUNT(1)
      INTO V_JUGNUM
      FROM scmdata.t_qa_scope_backup
     WHERE QA_REPORT_ID = V_QAREPID
       AND COMPANY_ID = V_COMPID
       AND PROCESSING_TYPE = ' '
       AND ROWNUM < 2;

    IF V_JUGNUM > 0 THEN
      RAISE_APPLICATION_ERROR(-20002,'【不合格处理明细】存在未选择处理类型的数据，请补充完整！');
    END IF;

  END P_CHECK_QASCOPE_PROCESSING_TYPE;


  --QA质检报告提交校验
  PROCEDURE P_QA_REPORT_COMMIT_CHECK(V_QARID   IN VARCHAR2,
                                     V_COMPID  IN VARCHAR2) IS
  BEGIN
    P_CHECK_QAREPORT_NESINFO(V_QA_REPORT_ID  => V_QARID,
                             V_COMPANY_ID    => V_COMPID);

    P_CHECK_QA_RESULT(V_QA_REPORT_ID  => V_QARID,
                      V_COMPANY_ID    => V_COMPID);

    P_CHECK_QASCOPE_PROCESSING_TYPE(V_QAREPID  => V_QARID,
                                    V_COMPID   => V_COMPID);

    P_CHECK_REP_REPEAT_COMMIT(V_QAREPID => V_QARID,
                              V_COMPID  => V_COMPID);
  END P_QA_REPORT_COMMIT_CHECK;


  --SKU质检确认
  PROCEDURE P_QA_COMFIRM_CHECK_SKU(V_QAREPORT_ID IN VARCHAR2,
                                   V_COMPANY_ID  IN VARCHAR2) IS
    V_JUGNUM   NUMBER(4):=0;
  BEGIN
    SELECT SIGN(COUNT(1))
      INTO V_JUGNUM
      FROM SCMDATA.T_ASNORDERSITEM
     WHERE RECEIVE_TIME IS NULL
       AND (ASN_ID, COMPANY_ID, BARCODE) IN
           (SELECT ASN_ID, COMPANY_ID, BARCODE
              FROM scmdata.t_qa_scope_backup
             WHERE QA_REPORT_ID = V_QAREPORT_ID
               AND COMPANY_ID = V_COMPANY_ID);
    IF V_JUGNUM > 0 THEN
      RAISE_APPLICATION_ERROR(-20002,'质检确认失败！质检报告存在未收货完成的ASN单，请检查。');
    END IF;
  END P_QA_COMFIRM_CHECK_SKU;


  --QA_CONFIG校验
  PROCEDURE P_QA_CONFIG_CHECK(QA_CLAS  IN VARCHAR2,
                              QA_PROC  IN VARCHAR2,
                              QA_SUBC  IN VARCHAR2,
                              QA_CID   IN VARCHAR2,
                              QA_COMP  IN VARCHAR2) IS
    V_JUGNUM  NUMBER(4);
    V_CP      VARCHAR2(32);
  BEGIN
    IF QA_CLAS IS NULL THEN
      RAISE_APPLICATION_ERROR(-20002,'分类不能为空！');
    ELSIF QA_PROC IS NULL THEN
       RAISE_APPLICATION_ERROR(-20002,'生产分类不能为空！');
    ELSIF QA_SUBC IS NULL THEN
      RAISE_APPLICATION_ERROR(-20002,'子类不能为空！');
    END IF;

    SELECT COUNT(1)
      INTO V_JUGNUM
      FROM SCMDATA.T_QA_CONFIG
     WHERE CLASSIFICATION = QA_CLAS
       AND PRODUCT_CATE = QA_PROC
       AND QACONFIG_ID <> QA_CID
       AND COMPANY_ID = QA_COMP
       AND ROWNUM < 2;

    IF V_JUGNUM > 0 THEN
      SELECT A.GROUP_DICT_NAME||'+'||B.GROUP_DICT_NAME
        INTO V_CP
        FROM (SELECT GROUP_DICT_VALUE,
                     GROUP_DICT_NAME,
                     GROUP_DICT_TYPE
                FROM SCMDATA.SYS_GROUP_DICT
               WHERE GROUP_DICT_VALUE = QA_CLAS
                 AND GROUP_DICT_TYPE = 'PRODUCT_TYPE') A
       INNER JOIN SCMDATA.SYS_GROUP_DICT B
          ON A.GROUP_DICT_VALUE = B.GROUP_DICT_TYPE
         AND B.GROUP_DICT_VALUE = QA_PROC;

      RAISE_APPLICATION_ERROR(-20002,'类别'||V_CP||'重复，请检查！');
    END IF;
  END P_QA_CONFIG_CHECK;


  --待检/已检列表数量相关更新
  PROCEDURE P_UPDATE_REP_AMOUNT(V_QAREPID IN VARCHAR2,
                                V_COMPID  IN VARCHAR2,
                                V_CURUSER IN VARCHAR2) IS
    QA_REPID   VARCHAR2(32):=V_QAREPID;
    COMP_ID    VARCHAR2(32):=V_COMPID;
    USER_ID    VARCHAR2(32):=V_CURUSER;
  BEGIN
    --质检报告更新汇总数量
    P_UPDATE_REP_SUMAMOUNT(V_QAREPID => QA_REPID,
                           V_COMPID  => COMP_ID,
                           V_CURUSER => USER_ID);

    --质检报告更新次品数量
    P_UPDATE_REP_SUBSAMOUNT(V_QAREPID => QA_REPID,
                            V_COMPID  => COMP_ID,
                            V_CURUSER => USER_ID);

    --质检报告通过类型更新汇总数量
    P_UPDATE_REP_SUMAMOUNT_BY_TYPE(V_QAREPID => QA_REPID,
                                   V_COMPID  => COMP_ID,
                                   V_CURUSER => USER_ID);
  END P_UPDATE_REP_AMOUNT;


  --质检报告更新汇总数量
  PROCEDURE P_UPDATE_REP_SUMAMOUNT(V_QAREPID IN VARCHAR2,
                                   V_COMPID  IN VARCHAR2,
                                   V_CURUSER IN VARCHAR2) IS
    V_PA       NUMBER(8);
    V_GA       NUMBER(8);
    V_TMPGA    NUMBER(8);
    V_SUBSA    NUMBER(8);
  BEGIN
    FOR X IN (SELECT QA_SCOPE_ID,COMPANY_ID,ASN_ID,GOO_ID,BARCODE
                FROM scmdata.t_qa_scope_backup
               WHERE QA_REPORT_ID = V_QAREPID
                 AND COMPANY_ID = V_COMPID) LOOP
      SELECT SUM(SUBS_AMOUNT)
        INTO V_SUBSA
        FROM SCMDATA.T_QA_SUBSRELA
       WHERE QA_SCOPE_ID = X.QA_SCOPE_ID
         AND ASN_ID = X.ASN_ID
         AND GOODSID = NVL(X.BARCODE,X.GOO_ID)
         AND COMPANY_ID = X.COMPANY_ID;

      IF X.BARCODE IS NOT NULL THEN
        SELECT SUM(GOT_AMOUNT)
          INTO V_TMPGA
          FROM SCMDATA.T_ASNORDERSITEM
         WHERE ASN_ID = X.ASN_ID
           AND GOO_ID = X.GOO_ID
           AND BARCODE = X.BARCODE
           AND COMPANY_ID = X.COMPANY_ID;
      ELSE
        SELECT SUM(GOT_AMOUNT)
          INTO V_TMPGA
          FROM SCMDATA.T_ASNORDERS
         WHERE ASN_ID = X.ASN_ID
           AND GOO_ID = X.GOO_ID
           AND COMPANY_ID = X.COMPANY_ID;
      END IF;

      UPDATE scmdata.t_qa_scope_backup
         SET GOT_AMOUNT = V_TMPGA, -- - V_SUBSA,
             SUBS_AMOUNT = V_SUBSA
       WHERE QA_SCOPE_ID = X.QA_SCOPE_ID
         AND COMPANY_ID = X.COMPANY_ID;
    END LOOP;


    SELECT NVL(SUM(PCOME_AMOUNT),0),
           NVL(SUM(GOT_AMOUNT),0)
      INTO V_PA,V_GA
      FROM scmdata.t_qa_scope_backup
     WHERE QA_REPORT_ID = V_QAREPID
       AND COMPANY_ID = V_COMPID;

    UPDATE scmdata.t_qa_report_backup
       SET PCOMESUM_AMOUNT = V_PA,
           GOTSUM_AMOUNT = V_GA,
           UPDATE_ID = V_CURUSER,
           UPDATE_TIME = SYSDATE
     WHERE QA_REPORT_ID = V_QAREPID
       AND COMPANY_ID = V_COMPID;
  END P_UPDATE_REP_SUMAMOUNT;


  --质检报告更新汇总数量(用于新增)
  PROCEDURE P_UPDATE_REP_SUMAMOUNT_WITHOUT_UPDINFO(V_QAREPID IN VARCHAR2,
                                                   V_COMPID  IN VARCHAR2) IS
    V_PA  NUMBER(8);
    V_GA  NUMBER(8);
  BEGIN
    SELECT NVL(SUM(PCOME_AMOUNT),0),
           NVL(SUM(GOT_AMOUNT),0)
      INTO V_PA,V_GA
      FROM scmdata.t_qa_scope_backup
     WHERE QA_REPORT_ID = V_QAREPID
       AND COMPANY_ID = V_COMPID;

    UPDATE scmdata.t_qa_report_backup
       SET PCOMESUM_AMOUNT = V_PA,
           GOTSUM_AMOUNT = V_GA
     WHERE QA_REPORT_ID = V_QAREPID
       AND COMPANY_ID = V_COMPID;
  END P_UPDATE_REP_SUMAMOUNT_WITHOUT_UPDINFO;


  --质检报告更新次品数量
  PROCEDURE P_UPDATE_REP_SUBSAMOUNT(V_QAREPID IN VARCHAR2,
                                    V_COMPID  IN VARCHAR2,
                                    V_CURUSER IN VARCHAR2) IS
    V_SA  NUMBER(8);
  BEGIN
    SELECT NVL(SUM(SUBS_AMOUNT),0)
      INTO V_SA
      FROM scmdata.t_qa_scope_backup
     WHERE QA_REPORT_ID = V_QAREPID
       AND COMPANY_ID = V_COMPID;

    UPDATE scmdata.t_qa_report_backup
       SET SUBSSUM_AMOUNT = V_SA,
           UPDATE_ID = V_CURUSER,
           UPDATE_TIME = SYSDATE
     WHERE QA_REPORT_ID = V_QAREPID
       AND COMPANY_ID = V_COMPID;
  END P_UPDATE_REP_SUBSAMOUNT;


  --质检报告通过类型更新汇总数量
  PROCEDURE P_UPDATE_REP_SUMAMOUNT_BY_TYPE(V_QAREPID IN VARCHAR2,
                                           V_COMPID  IN VARCHAR2,
                                           V_CURUSER IN VARCHAR2) IS
    V_JA  NUMBER(8);
    V_TA  NUMBER(8);
  BEGIN
    SELECT NVL(SUM(GOT_AMOUNT),0)
      INTO V_JA
      FROM scmdata.t_qa_scope_backup
     WHERE QA_REPORT_ID = V_QAREPID
       AND COMPANY_ID = V_COMPID
       AND PROCESSING_TYPE = 'RJ';

    SELECT NVL(SUM(GOT_AMOUNT),0)
      INTO V_TA
      FROM scmdata.t_qa_scope_backup
     WHERE QA_REPORT_ID = V_QAREPID
       AND COMPANY_ID = V_COMPID
       AND PROCESSING_TYPE = 'RT';

    UPDATE scmdata.t_qa_report_backup
       SET REJSUM_AMOUNT = V_JA,
           RETSUM_AMOUNT = V_TA,
           UPDATE_ID = V_CURUSER,
           UPDATE_TIME = SYSDATE
     WHERE QA_REPORT_ID = V_QAREPID
       AND COMPANY_ID = V_COMPID;
  END P_UPDATE_REP_SUMAMOUNT_BY_TYPE;


  --生成批版记录sql
  FUNCTION F_GET_QA_APPROVE_VERSION_SQL(V_ID      IN VARCHAR2,
                                        V_COMPID  IN VARCHAR2) RETURN CLOB IS
    V_EXESQL  CLOB;
  BEGIN
    V_EXESQL := 'WITH TMP AS
   (SELECT *
      FROM SCMDATA.T_APPROVE_RISK_ASSESSMENT
     WHERE APPROVE_VERSION_ID = '''||V_ID||'''),
  FILE_TEMP AS
   (SELECT *
      FROM SCMDATA.T_APPROVE_FILE
     WHERE APPROVE_VERSION_ID = '''||V_ID||'''),
  G_DIC AS
   (SELECT GROUP_DICT_VALUE, GROUP_DICT_NAME, GROUP_DICT_TYPE
      FROM SCMDATA.SYS_GROUP_DICT),
  C_DIC AS
   (SELECT COMPANY_DICT_VALUE,
           COMPANY_DICT_NAME,
           COMPANY_DICT_TYPE,
           COMPANY_ID
      FROM SCMDATA.SYS_COMPANY_DICT)
  SELECT CI.RELA_GOO_ID,
         A.STYLE_CODE,
         CI.STYLE_NAME,
         (SELECT SUPPLIER_COMPANY_NAME
            FROM SCMDATA.T_SUPPLIER_INFO
           WHERE COMPANY_ID = A.COMPANY_ID
             AND SUPPLIER_CODE = CI.SUPPLIER_CODE) SUPPLIER,
         (SELECT GROUP_DICT_NAME
            FROM SCMDATA.SYS_GROUP_DICT
           WHERE GROUP_DICT_VALUE = A.APPROVE_RESULT) APPROVE_RESULT,
         A.APPROVE_NUMBER,
         (SELECT COMPANY_USER_NAME
            FROM SCMDATA.SYS_COMPANY_USER
           WHERE USER_ID = A.APPROVE_USER_ID
             AND COMPANY_ID = '''||V_COMPID||''') APPROVE_USER,
         A.APPROVE_TIME,
         A.REMARKS,
         ''面辅料'' ASSESS_TYPE_DESC_1,
         (SELECT COMPANY_USER_NAME
            FROM SCMDATA.SYS_COMPANY_USER
           WHERE COMPANY_ID =
                 (SELECT COMPANY_ID FROM TMP WHERE ASSESS_TYPE = ''EVAL11'')
             AND USER_ID =
                 (SELECT ASSESS_USER_ID FROM TMP WHERE ASSESS_TYPE = ''EVAL11'')) MFL_AU,
         (SELECT GROUP_DICT_NAME
            FROM G_DIC
           WHERE GROUP_DICT_TYPE = ''EVAL_RESULT''
             AND GROUP_DICT_VALUE =
                 (SELECT ASSESS_RESULT FROM TMP WHERE ASSESS_TYPE = ''EVAL11'')) MFL_AR,
         (SELECT GROUP_DICT_NAME
            FROM G_DIC
           WHERE GROUP_DICT_TYPE = ''APPROVE_RISK_WARNING''
             AND GROUP_DICT_VALUE =
                 (SELECT RISK_WARNING FROM TMP WHERE ASSESS_TYPE = ''EVAL11'')) MFL_RW,
         (SELECT COMPANY_DICT_NAME
            FROM C_DIC
           WHERE COMPANY_DICT_TYPE = ''EVAL11''
             AND COMPANY_ID = '''||V_COMPID||'''
             AND COMPANY_DICT_VALUE =
                 (SELECT UNQUALIFIED_SAY FROM TMP WHERE ASSESS_TYPE = ''EVAL11'')) MFL_US,
         (SELECT ASSESS_SAY FROM TMP WHERE ASSESS_TYPE = ''EVAL11'') APR_MFL_AS,
         ''印绣花'' ASSESS_TYPE_DESC_2,
         (SELECT COMPANY_USER_NAME
            FROM SCMDATA.SYS_COMPANY_USER
           WHERE COMPANY_ID =
                 (SELECT COMPANY_ID FROM TMP WHERE ASSESS_TYPE = ''EVAL12'')
             AND USER_ID =
                 (SELECT ASSESS_USER_ID FROM TMP WHERE ASSESS_TYPE = ''EVAL12'')) YXH_AU,
         (SELECT GROUP_DICT_NAME
            FROM G_DIC
           WHERE GROUP_DICT_TYPE = ''EVAL_RESULT''
             AND GROUP_DICT_VALUE =
                 (SELECT ASSESS_RESULT FROM TMP WHERE ASSESS_TYPE = ''EVAL12'')) YXH_AR,
         (SELECT GROUP_DICT_NAME
            FROM G_DIC
           WHERE GROUP_DICT_TYPE = ''APPROVE_RISK_WARNING''
             AND GROUP_DICT_VALUE =
                 (SELECT RISK_WARNING FROM TMP WHERE ASSESS_TYPE = ''EVAL12'')) YXH_RW,
         (SELECT COMPANY_DICT_NAME
            FROM C_DIC
           WHERE COMPANY_DICT_TYPE = ''EVAL12''
             AND COMPANY_ID = '''||V_COMPID||'''
             AND COMPANY_DICT_VALUE =
                 (SELECT UNQUALIFIED_SAY FROM TMP WHERE ASSESS_TYPE = ''EVAL12'')) YXH_US,
         (SELECT ASSESS_SAY FROM TMP WHERE ASSESS_TYPE = ''EVAL12'') YXH_AS,
         ''工艺'' ASSESS_TYPE_DESC_3,
         (SELECT COMPANY_USER_NAME
            FROM SCMDATA.SYS_COMPANY_USER
           WHERE COMPANY_ID =
                 (SELECT COMPANY_ID FROM TMP WHERE ASSESS_TYPE = ''EVAL13'')
             AND USER_ID =
                 (SELECT ASSESS_USER_ID FROM TMP WHERE ASSESS_TYPE = ''EVAL13'')) GY_AU,
         (SELECT GROUP_DICT_NAME
            FROM G_DIC
           WHERE GROUP_DICT_TYPE = ''EVAL_RESULT''
             AND GROUP_DICT_VALUE =
                 (SELECT ASSESS_RESULT FROM TMP WHERE ASSESS_TYPE = ''EVAL13'')) GY_AR,
         (SELECT GROUP_DICT_NAME
            FROM G_DIC
           WHERE GROUP_DICT_TYPE = ''APPROVE_RISK_WARNING''
             AND GROUP_DICT_VALUE =
                 (SELECT RISK_WARNING FROM TMP WHERE ASSESS_TYPE = ''EVAL13'')) GY_RW,
         (SELECT COMPANY_DICT_NAME
            FROM C_DIC
           WHERE COMPANY_DICT_TYPE = ''EVAL13''
             AND COMPANY_ID = '''||V_COMPID||'''
             AND COMPANY_DICT_VALUE =
                 (SELECT UNQUALIFIED_SAY FROM TMP WHERE ASSESS_TYPE = ''EVAL13'')) GY_US,
         (SELECT ASSESS_SAY FROM TMP WHERE ASSESS_TYPE = ''EVAL13'') GY_AS,
         ''版型尺寸'' ASSESS_TYPE_DESC_4,
         (SELECT COMPANY_USER_NAME
            FROM SCMDATA.SYS_COMPANY_USER
           WHERE COMPANY_ID =
                 (SELECT COMPANY_ID FROM TMP WHERE ASSESS_TYPE = ''EVAL14'')
             AND USER_ID =
                 (SELECT ASSESS_USER_ID FROM TMP WHERE ASSESS_TYPE = ''EVAL14'')) BXCC_AU,
         (SELECT GROUP_DICT_NAME
            FROM G_DIC
           WHERE GROUP_DICT_TYPE = ''EVAL_RESULT''
             AND GROUP_DICT_VALUE =
                 (SELECT ASSESS_RESULT FROM TMP WHERE ASSESS_TYPE = ''EVAL14'')) BXCC_AR,
         (SELECT GROUP_DICT_NAME
            FROM G_DIC
           WHERE GROUP_DICT_TYPE = ''APPROVE_RISK_WARNING''
             AND GROUP_DICT_VALUE =
                 (SELECT RISK_WARNING FROM TMP WHERE ASSESS_TYPE = ''EVAL14'')) BXCC_RW,
         (SELECT COMPANY_DICT_NAME
            FROM C_DIC
           WHERE COMPANY_DICT_TYPE = ''EVAL14''
             AND COMPANY_ID = '''||V_COMPID||'''
             AND COMPANY_DICT_VALUE =
                 (SELECT UNQUALIFIED_SAY FROM TMP WHERE ASSESS_TYPE = ''EVAL14'')) BXCC_US,
         (SELECT ASSESS_SAY FROM TMP WHERE ASSESS_TYPE = ''EVAL14'') BXCC_AS,
         (SELECT LISTAGG(FILE_ID, '','') FROM FILE_TEMP) FILE_ID_PR
    FROM (SELECT *
            FROM SCMDATA.T_APPROVE_VERSION
           WHERE APPROVE_VERSION_ID = '''||V_ID||'''
             AND COMPANY_ID = '''||V_COMPID||''') A
   INNER JOIN SCMDATA.T_COMMODITY_INFO CI
      ON CI.GOO_ID = A.GOO_ID
     AND A.COMPANY_ID = CI.COMPANY_ID';
    RETURN V_EXESQL;
  END F_GET_QA_APPROVE_VERSION_SQL;




  --生成面料检测sql
  FUNCTION F_GET_QA_FABRIC_SQL(V_ID      IN VARCHAR2,
                               V_COMPID  IN VARCHAR2) RETURN CLOB IS
    V_EXESQL  CLOB;
  BEGIN
    V_EXESQL := 'SELECT A.GOO_ID,
         A.SEND_CHECK_AMOUNT,
         A.CHECK_COMPANY_NAME FABRIC_CHECK_COMPANY_NAME,
         G.RELA_GOO_ID,
         NVL(A.SEND_CHECK_SUP_NAME, SI.SUPPLIER_COMPANY_NAME) SEND_CHECK_SUP_NAME,
         A.CHECK_TYPE,
         G.STYLE_NUMBER,
         A.SEND_CHECK_USER_NAME,
         NVL(U.COMPANY_USER_NAME, FABRIC_CHECK_USER_NAME) FABRIC_CHECK_USER_NAME,
         A.COLOR_LIST,
         A.SEND_CHECK_DATE,
         A.CHECK_DATE FABRIC_CHECK_DATE,
         A.CHECK_RESULT,
         A.UNQUALIFIED_TYPE,
         A.UNQUALIFIED_COLOR,
         A.CHECK_LINK,
         A.ARCHIVES_NUMBER,
         A.SEND_CHECK_FILE_ID,
         A.CHECK_REPORT_FILE_ID FABRIC_CHECK_REPORT_FILE,
         A.MEMO
    FROM (SELECT *
            FROM SCMDATA.T_CHECK_REQUEST
           WHERE CHECK_REQUEST_CODE = '''||V_ID||'''
             AND COMPANY_ID = '''||V_COMPID||''') A
   INNER JOIN SCMDATA.T_COMMODITY_INFO G
      ON G.GOO_ID = A.GOO_ID
     AND G.COMPANY_ID = A.COMPANY_ID
   INNER JOIN SCMDATA.SYS_GROUP_DICT GD1
      ON GD1.GROUP_DICT_TYPE = ''PRODUCT_TYPE''
     AND GD1.GROUP_DICT_VALUE = G.CATEGORY
   INNER JOIN SCMDATA.SYS_GROUP_DICT GD2
      ON GD2.GROUP_DICT_TYPE = GD1.GROUP_DICT_VALUE
     AND GD2.GROUP_DICT_VALUE = G.PRODUCT_CATE
   INNER JOIN SCMDATA.SYS_COMPANY_DICT CD
      ON CD.COMPANY_DICT_TYPE = GD2.GROUP_DICT_VALUE
     AND CD.COMPANY_DICT_VALUE = G.SAMLL_CATEGORY
     AND CD.COMPANY_ID = '''||V_COMPID||'''
   INNER JOIN SCMDATA.SYS_COMPANY_USER U
      ON U.USER_ID = A.CHECK_USER_ID
     AND U.COMPANY_ID = A.COMPANY_ID
    LEFT JOIN SCMDATA.T_SUPPLIER_INFO SI
      ON SI.SUPPLIER_INFO_ID = A.SEND_CHECK_SUP_ID
     AND SI.COMPANY_ID = A.COMPANY_ID
   ORDER BY A.CREATE_TIME DESC';
    RETURN V_EXESQL;
  END F_GET_QA_FABRIC_SQL;




  --生成产前会sql
  FUNCTION F_GET_QC_PRE_MEETING_SQL(V_ID      IN VARCHAR2,
                                    V_COMPID  IN VARCHAR2) RETURN CLOB IS
    V_EXESQL  CLOB;
  BEGIN
    V_EXESQL := 'SELECT CI.RELA_GOO_ID,
         CI.STYLE_NUMBER,
         SI.SUPPLIER_COMPANY_NAME SUPPLIER,
         FI.SUPPLIER_COMPANY_NAME PRODUCT_FACTORY,
         A.QC_CHECK_NUM PRE_MEETING_NUM,
         A.PRE_MEETING_TIME,
         A.IS_FABRIC_BACK,
         A.FABRIC_BACK_DATE,
         A.IS_SUB_FABRIC_BACK,
         A.SUB_FABRIC_BACK_DATE,
         A.IS_CAPACITY_MATCH,
         A.CAPACITY_UNQ_SAY,
         A.DELAY_RISK_LEVEL,
         A.DELAY_RISK_SAY,
         A.PRE_MEETING_RECORD,
         (SELECT LISTAGG(O.ORDER_ID, ''; '') WITHIN GROUP(ORDER BY 1)
            FROM SCMDATA.T_QC_CHECK_RELA_ORDER K
           INNER JOIN SCMDATA.T_ORDERS O
              ON O.ORDERS_ID = K.ORDERS_ID
           WHERE K.QC_CHECK_ID = A.QC_CHECK_ID) RELA_ORDER_ID,
         A.MEMO,
         (SELECT COMPANY_USER_NAME
            FROM SCMDATA.SYS_COMPANY_USER
           WHERE USER_ID = A.FINISH_QC_ID
             AND COMPANY_ID = '''||V_COMPID||''') QC_CHECK_USER,
         A.FINISH_TIME SUBMIT_TIME
    FROM SCMDATA.T_QC_CHECK A
   INNER JOIN SCMDATA.T_COMMODITY_INFO CI
      ON CI.GOO_ID = A.GOO_ID
     AND A.COMPANY_ID = CI.COMPANY_ID
    LEFT JOIN SCMDATA.T_SUPPLIER_INFO SI
      ON SI.SUPPLIER_CODE = A.SUPPLIER_CODE
     AND A.COMPANY_ID = SI.COMPANY_ID
    LEFT JOIN SCMDATA.T_SUPPLIER_INFO FI
      ON FI.SUPPLIER_CODE = A.FACTORY_CODE
     AND A.COMPANY_ID = FI.COMPANY_ID
   WHERE A.QC_CHECK_CODE = '''||V_ID||'''
     AND A.COMPANY_ID = '''||V_COMPID||'''';
    RETURN V_EXESQL;
  END F_GET_QC_PRE_MEETING_SQL;


  --生成洗水测试sql
  FUNCTION F_GET_QC_WASH_TESTING_SQL(V_ID      IN VARCHAR2,
                                     V_COMPID  IN VARCHAR2) RETURN CLOB IS
    V_EXESQL  CLOB;
  BEGIN
    V_EXESQL := 'SELECT CI.RELA_GOO_ID,
         CI.STYLE_NUMBER,
         SI.SUPPLIER_COMPANY_NAME SUPPLIER,
         FI.SUPPLIER_COMPANY_NAME PRODUCT_FACTORY,
         A.QC_CHECK_NUM WASH_TEST_NUM,
         QW.WASH_TEST_DATE,
         QW.WASH_FLOAT,
         QW.WASH_FLOAT_UNQ,
         QW.DYED_STAIN,
         QW.DYED_STAIN_UNQ,
         QW.CLOTH_SHRINKAGE,
         QW.CLOTH_SHRINKAGE_UNQ,
         QW.APPEARANCE_AF,
         QW.APPEARANCE_AF_UNQ,
         A.QC_RESULT WASH_TEST_RESULT,
         A.QC_UNQ_SAY WASH_TEST_UNQ_SAY,
         QW.WASH_TEST_LOG,
         (SELECT LISTAGG(O.ORDER_ID, ''; '') WITHIN GROUP(ORDER BY 1)
            FROM SCMDATA.T_QC_CHECK_RELA_ORDER K
           INNER JOIN SCMDATA.T_ORDERS O
              ON O.ORDERS_ID = K.ORDERS_ID
           WHERE K.QC_CHECK_ID = A.QC_CHECK_ID) WASH_TEST_ORDER_ID,
         A.MEMO,
         (SELECT COMPANY_USER_NAME
            FROM SCMDATA.SYS_COMPANY_USER
           WHERE USER_ID = A.FINISH_QC_ID
             AND COMPANY_ID = '''||V_COMPID||''') QC_CHECK_USER
    FROM SCMDATA.T_QC_CHECK A
   INNER JOIN SCMDATA.T_QC_CHECK_WASH QW
      ON A.QC_CHECK_ID = QW.QC_CHECK_ID
   INNER JOIN SCMDATA.T_COMMODITY_INFO CI
      ON CI.GOO_ID = A.GOO_ID
     AND A.COMPANY_ID = CI.COMPANY_ID
    LEFT JOIN SCMDATA.T_SUPPLIER_INFO SI
      ON SI.SUPPLIER_CODE = A.SUPPLIER_CODE
     AND A.COMPANY_ID = SI.COMPANY_ID
    LEFT JOIN SCMDATA.T_SUPPLIER_INFO FI
      ON FI.SUPPLIER_CODE = A.FACTORY_CODE
     AND A.COMPANY_ID = FI.COMPANY_ID
   WHERE A.QC_CHECK_CODE = '''||V_ID||'''
     AND A.COMPANY_ID = '''||V_COMPID||'''';
    RETURN V_EXESQL;
  END F_GET_QC_WASH_TESTING_SQL;



  --生成qc其余检测环节sql
  FUNCTION F_GET_QC_ELSE_SQL(V_ID      IN VARCHAR2,
                             V_COMPID  IN VARCHAR2) RETURN CLOB IS
    V_EXESQL  CLOB;
  BEGIN
    V_EXESQL := 'SELECT CI.RELA_GOO_ID,
         CI.STYLE_NUMBER,
         SU.SUPPLIER_COMPANY_NAME,
         A.QC_CHECK_NODE,
         SYSDATE QC_FINISH_DATE,
         A.TS_PRODUCT_NUM,
         A.TS_CHECK_NUM,
         A.TS_UNQUALITY_NUM,
         A.TS_CHECK_PERCENTY,
         A.TS_QUALITY_PERCENTY,
         A.QC_CHECK_NUM QC_CHECK_NUM,
         (SELECT COMPANY_USER_NAME
            FROM SCMDATA.SYS_COMPANY_USER
           WHERE USER_ID = A.CREATE_ID
             AND COMPANY_ID = '''||V_COMPID||''') QC_CHECK_USER,
         A.QC_FILE_ID,
         (SELECT LISTAGG(O.ORDER_ID, ''; '') WITHIN GROUP(ORDER BY 1)
            FROM SCMDATA.T_QC_CHECK_RELA_ORDER K
           INNER JOIN SCMDATA.T_ORDERS O
              ON O.ORDERS_ID = K.ORDERS_ID
           WHERE K.QC_CHECK_ID = A.QC_CHECK_ID) RELA_ORDER_ID,
         A.QC_RESULT,
         A.QC_UNQ_SAY,
         A.QC_UNQ_ADVICE,
         A.MEMO,
         ''样衣核对'' CHECK_TYPE_DESC_1,
         QCR.SAMPLER_RESULT,
         QCR.SAMPLER_UNQ,
         ''面辅料查验'' CHECK_TYPE_DESC_2,
         QCR.FABRIB_RESULT,
         QCR.FABRIB_UNQ,
         ''工艺做工查验'' CHECK_TYPE_DESC_3,
         QCR.CRAFT_RESULT,
         QCR.CRAFT_UNQ,
         ''版型尺寸查验'' CHECK_TYPE_DESC_4,
         QCR.TYPE_SIZE_RESULT,
         QCR.TYPE_SIZE_UNQ,
         (SELECT LISTAGG(PICTURE_ID, '','') WITHIN GROUP(ORDER BY 1)
            FROM SCMDATA.T_COMMODITY_FILE
           WHERE COMMODITY_INFO_ID = CI.COMMODITY_INFO_ID
             AND FILE_TYPE = ''01'') COMMODITY_SIZE_CHART
    FROM SCMDATA.T_QC_CHECK A
   INNER JOIN SCMDATA.T_QC_CHECK_REPORT QCR
      ON A.QC_CHECK_ID = QCR.QC_CHECK_ID
   INNER JOIN SCMDATA.T_COMMODITY_INFO CI
      ON A.GOO_ID = CI.GOO_ID
     AND A.COMPANY_ID = CI.COMPANY_ID
   INNER JOIN SCMDATA.T_SUPPLIER_INFO SU
      ON CI.SUPPLIER_CODE = SU.SUPPLIER_CODE
     AND CI.COMPANY_ID = SU.COMPANY_ID
   WHERE A.QC_CHECK_CODE = '''||V_ID||'''
     AND A.COMPANY_ID = '''||V_COMPID||'''';
    RETURN V_EXESQL;
  END F_GET_QC_ELSE_SQL;


  --生成QA检测sql
  FUNCTION F_GET_QA_REPORT_SQL(V_ID      IN VARCHAR2,
                               V_COMPID  IN VARCHAR2) RETURN CLOB IS
    V_EXESQL CLOB;
  BEGIN
    V_EXESQL := 'SELECT A.QA_REPORT_ID,
         A.COMPANY_ID,
         B.RELA_GOO_ID,
         B.STYLE_NUMBER,
         B.STYLE_NAME,
         (SELECT SUPPLIER_COMPANY_NAME
            FROM SCMDATA.T_SUPPLIER_INFO
           WHERE SUPPLIER_CODE = A.SUPPLIER_CODE
             AND COMPANY_ID = A.COMPANY_ID) SUPPLIER,
         A.PCOMESUM_AMOUNT QAPCOMESUM_AMOUNT,
         A.FIRSTCHECK_AMOUNT QAFIRSTCHECK_AMOUNT,
         (SELECT GROUP_DICT_NAME
            FROM SCMDATA.SYS_GROUP_DICT
           WHERE GROUP_DICT_VALUE = A.CHECK_TYPE
             AND GROUP_DICT_TYPE = ''QA_REPCHECK_TYPE'') QACHECK_TYPE,
         A.ADDCHECK_AMOUNT QAADDCHECK_AMOUNT,
         A.CHECKSUM_AMOUNT QACHECKSUM_AMOUNT,
         A.CHECKERS QACHECKERS,
         NVL(TO_CHAR(ROUND(A.CHECKSUM_AMOUNT / DECODE(A.PCOMESUM_AMOUNT,0,1,A.PCOMESUM_AMOUNT) * 100,2),''fm990.00''),0.00)||''%'' QACHECK_RATE,
         A.CHECK_DATE QACHECK_DATE,
         A.MEMO,
         A.CHECK_RESULT QACHECK_RESULT,
         A.CHECKSUM_AMOUNT QACHECK_AMOUNT,
         A.UNQUAL_TREATMENT,A.UNQUALREASON_CLASS,
         A.UNQUAL_SUBJUECTS,
         A.UNQUAL_AMOUNT QAUNQUAL_AMOUNT,
         NVL(TO_CHAR(ROUND((1-(NVL(A.UNQUAL_AMOUNT,0) / DECODE(A.CHECKSUM_AMOUNT,0,1,A.CHECKSUM_AMOUNT))) * 100,2),''fm990.00''),0.00)||''%'' QAQUAL_RATE,
         A.ATTACHMENT,A.YY_RESULT VW_YYRESULT,A.YY_UQDESC,A.MFL_RESULT VW_MFLRESULT,A.MFL_UQDESC,
         A.GY_RESULT VW_GYRESULT,A.GY_UQDESC,A.BX_RESULT VW_BXRESULT,A.BX_UQDESC,
         ''查看'' TO_CHECK_RANGE,
         ''查看'' TO_SUBS_AMOUNT,
         ''查看'' TO_UNQUAL_TREATMENT
    FROM (SELECT Z.QA_REPORT_ID,Z.COMPANY_ID,Z.PCOMESUM_AMOUNT,Z.FIRSTCHECK_AMOUNT,Z.ADDCHECK_AMOUNT,
                 Z.CHECKSUM_AMOUNT,Z.GOTSUM_AMOUNT,Z.SUBS_AMOUNT,Z.REJSUM_AMOUNT,Z.RETSUM_AMOUNT,
                 Z.CHECKERS,Z.CHECK_DATE,Z.CHECK_RESULT,Z.UNQUAL_TREATMENT,Z.UNQUAL_SUBJUECTS,
                 Z.UNQUAL_AMOUNT,Z.ATTACHMENT,Z.MEMO,Z.YY_RESULT,Z.YY_UQDESC,Z.MFL_RESULT,Z.MFL_UQDESC,
                 Z.GY_RESULT,Z.GY_UQDESC,Z.BX_RESULT,Z.BX_UQDESC,Z.CHECK_TYPE,Z.GOO_ID,Z.UNQUALREASON_CLASS,
                 (SELECT MAX(SUPPLIER_CODE)
                    FROM scmdata.t_qa_scope_backup
                   WHERE QA_REPORT_ID = Z.QA_REPORT_ID
                     AND COMPANY_ID = Z.COMPANY_ID) SUPPLIER_CODE
            FROM scmdata.t_qa_report_backup Z
           WHERE COMPANY_ID = '''||V_COMPID||'''
             AND QA_REPORT_ID = '''||V_ID||''') A
   INNER JOIN SCMDATA.T_COMMODITY_INFO B
      ON A.GOO_ID = B.GOO_ID
     AND A.COMPANY_ID = B.COMPANY_ID';
    RETURN V_EXESQL;
  END F_GET_QA_REPORT_SQL;


  --获取多重展示页面正确sql
  FUNCTION F_GET_RIGHT_SQL_FOR_MULTI_VIEW(V_ID      IN VARCHAR2,
                                          V_COMPID  IN VARCHAR2) RETURN CLOB IS
    V_SQL   CLOB;
    V_NODE VARCHAR2(32);
  BEGIN
    IF V_ID LIKE 'AP_VERSION%' THEN
      V_SQL := F_GET_QA_APPROVE_VERSION_SQL(V_ID      => V_ID,
                                            V_COMPID  => V_COMPID);
    ELSIF V_ID LIKE 'SJ%' THEN
      V_SQL := F_GET_QA_FABRIC_SQL(V_ID      => V_ID,
                                   V_COMPID  => V_COMPID);
    ELSIF V_ID LIKE 'QA%' THEN
      V_SQL := F_GET_QA_REPORT_SQL(V_ID      => V_ID,
                                   V_COMPID  => V_COMPID);
    ELSE
      SELECT MAX(A.QC_CHECK_NODE)
        INTO V_NODE
        FROM SCMDATA.T_QC_CHECK A
       WHERE A.QC_CHECK_CODE = V_ID
         AND A.COMPANY_ID = V_COMPID;
      IF V_NODE = 'QC_PRE_MEETING' THEN
        V_SQL := F_GET_QC_PRE_MEETING_SQL(V_ID      => V_ID,
                                          V_COMPID  => V_COMPID);
      ELSIF V_NODE = 'QC_WASH_TESTING' THEN
        V_SQL := F_GET_QC_WASH_TESTING_SQL(V_ID      => V_ID,
                                           V_COMPID  => V_COMPID);
      ELSE
        V_SQL := F_GET_QC_ELSE_SQL(V_ID      => V_ID,
                                   V_COMPID  => V_COMPID);
      END IF;
    END IF;
    RETURN V_SQL;
  END F_GET_RIGHT_SQL_FOR_MULTI_VIEW;


  --获取修改质检范围-添加ASN单sql
  FUNCTION F_GET_ASN_ADDED_SQL(V_QAREPID   IN VARCHAR2,
                               V_COMPID    IN VARCHAR2) RETURN CLOB IS
    V_GOOID  VARCHAR2(32);
    V_SUPCD  VARCHAR2(32);
    V_ASNIDS CLOB;
    V_CT     VARCHAR2(8);
    V_EXESQL CLOB;
  BEGIN
    IF V_QAREPID IS NULL THEN
      RAISE_APPLICATION_ERROR(-20002,'请勾选需要数据！');
    END IF;

    SELECT GOO_ID,CHECK_TYPE,
         (SELECT MAX(SUPPLIER_CODE)
            FROM SCMDATA.T_ASNORDERED
           WHERE ASN_ID IN (SELECT ASN_ID
                              FROM scmdata.t_qa_scope_backup
                             WHERE QA_REPORT_ID = Z.QA_REPORT_ID
                               AND COMPANY_ID = Z.COMPANY_ID))
      INTO V_GOOID, V_CT, V_SUPCD
      FROM scmdata.t_qa_report_backup Z
     WHERE QA_REPORT_ID = V_QAREPID
       AND COMPANY_ID = V_COMPID;

    SELECT ','||LISTAGG(DISTINCT ASN_ID,',')||','
      INTO V_ASNIDS
      FROM scmdata.t_qa_scope_backup A
     WHERE EXISTS (SELECT 1
                     FROM scmdata.t_qa_report_backup
                    WHERE QA_REPORT_ID = A.QA_REPORT_ID
                      AND COMPANY_ID = A.COMPANY_ID
                      AND STATUS NOT IN ('N_PED','R_PED'))
        OR EXISTS (SELECT 1
                     FROM scmdata.t_qa_scope_backup
                    WHERE QA_SCOPE_ID = A.QA_SCOPE_ID
                      AND COMPANY_ID = A.COMPANY_ID
                      AND QA_REPORT_ID = V_QAREPID
                      AND COMPANY_ID = V_COMPID);

    IF V_CT = 'RC' THEN
      RAISE_APPLICATION_ERROR(-20002,'返工质检报告无法修改质检范围！');
    END IF;

    V_EXESQL := 'SELECT A.ASN_ID,A.ORDER_ID QAORDER_ID,C.RELA_GOO_ID,
         C.STYLE_NUMBER, C.STYLE_NAME,
         (SELECT SUPPLIER_COMPANY_NAME
            FROM SCMDATA.T_SUPPLIER_INFO
           WHERE SUPPLIER_CODE = A.SUPPLIER_CODE
             AND COMPANY_ID = A.COMPANY_ID) SUPPLIER,
         B.GOT_AMOUNT,A.SCAN_TIME,
         (SELECT MAX(RECEIVE_TIME)
            FROM SCMDATA.T_ASNORDERSITEM
           WHERE ASN_ID = A.ASN_ID
             AND COMPANY_ID = A.COMPANY_ID) RECEIVE_TIME
    FROM (SELECT ASN_ID, COMPANY_ID, ORDER_ID, SCAN_TIME, SUPPLIER_CODE
            FROM SCMDATA.T_ASNORDERED Z
           WHERE STATUS = ''NC''
             AND SUPPLIER_CODE = '''||V_SUPCD||'''
             AND INSTR('''||V_ASNIDS||''','',''||ASN_ID||'','')=0) A
   INNER JOIN SCMDATA.T_ASNORDERS B
      ON A.ASN_ID = B.ASN_ID
     AND A.COMPANY_ID = B.COMPANY_ID
     AND B.GOO_ID = '''||V_GOOID||'''
   INNER JOIN SCMDATA.T_COMMODITY_INFO C
      ON B.GOO_ID = C.GOO_ID
     AND B.COMPANY_ID = C.COMPANY_ID';
    RETURN V_EXESQL;
  END F_GET_ASN_ADDED_SQL;


  --获取不合格处理明细-添加明细sql
  FUNCTION F_GET_UNQUAL_ADD_DETAIL_SQL(V_QAREPID   IN VARCHAR2,
                                       V_COMPID    IN VARCHAR2) RETURN CLOB IS
    V_EXESQL  CLOB;
  BEGIN
    V_EXESQL := 'SELECT A.QA_SCOPE_ID, A.ASN_ID, A.BARCODE, B.COLORNAME, B.SIZENAME, A.GOT_AMOUNT QAGOT_AMOUNT
    FROM (SELECT QA_SCOPE_ID, ASN_ID, COMPANY_ID, BARCODE, GOT_AMOUNT
            FROM scmdata.t_qa_scope_backup
           WHERE QA_REPORT_ID = '''||V_QAREPID||'''
             AND PROCESSING_TYPE = ''NM''
             AND COMPANY_ID = '''||V_COMPID||''') A
   INNER JOIN SCMDATA.T_COMMODITY_COLOR_SIZE B
      ON A.BARCODE = B.BARCODE
     AND A.COMPANY_ID = B.COMPANY_ID';
    RETURN V_EXESQL;
  END F_GET_UNQUAL_ADD_DETAIL_SQL;


  --校验QA单据是否重复提交
  --加入到P_QA_REPORT_COMMIT_CHECK中
  PROCEDURE P_CHECK_REP_REPEAT_COMMIT(V_QAREPID   IN VARCHAR2,
                                      V_COMPID    IN VARCHAR2) IS
    V_STATUS  VARCHAR2(8);
    V_CKTYPE  VARCHAR2(4);
    V_JUGNUM  NUMBER(1);
  BEGIN
    SELECT MAX(STATUS), MAX(CHECK_TYPE)
      INTO V_STATUS, V_CKTYPE
      FROM scmdata.t_qa_report_backup
     WHERE QA_REPORT_ID = V_QAREPID
       AND COMPANY_ID = V_COMPID;

    IF V_STATUS IN ('N_PCF','R_PCF','N_ACF','R_ACF') THEN
      RAISE_APPLICATION_ERROR(-20002,'该单据已提交请勿重复提交！请在待确认报告页面进行质检确认！');
    END IF;

    SELECT COUNT(1)
      INTO V_JUGNUM
      FROM scmdata.t_qa_scope_backup TAB
     WHERE QA_REPORT_ID <> V_QAREPID
       AND (ASN_ID, GOO_ID,  NVL(BARCODE,' '), COMPANY_ID)
        IN (SELECT ASN_ID, GOO_ID, NVL(BARCODE,' '), COMPANY_ID
              FROM scmdata.t_qa_scope_backup
             WHERE QA_REPORT_ID = V_QAREPID
               AND COMPANY_ID = V_COMPID)
       AND EXISTS (SELECT 1
                     FROM scmdata.t_qa_report_backup
                    WHERE QA_REPORT_ID = TAB.QA_REPORT_ID
                      AND COMPANY_ID = TAB.COMPANY_ID
                      AND STATUS IN ('N_PCF','N_ACF','R_PCF','R_ACF')
                      AND CHECK_TYPE <> 'RC')
      AND ROWNUM = 1;

    IF V_JUGNUM > 0 AND V_CKTYPE <> 'RC' THEN
      RAISE_APPLICATION_ERROR(-20002,'该SKU已提交请勿重复提交！请在待确认报告页面进行质检确认！');
    END IF;
  END P_CHECK_REP_REPEAT_COMMIT;


  --当不合格处理明细等于整批返工/整批拒收时，更新QASCOPE表
  PROCEDURE P_UPDATE_QAUNQUAL_TREATMENT(V_QAREPID   IN VARCHAR2,
                                        V_COMPID    IN VARCHAR2) IS
    V_UTFINAL  VARCHAR2(8);
  BEGIN
    SELECT UNQUAL_TREATMENT
      INTO V_UTFINAL
      FROM scmdata.t_qa_report_backup
     WHERE QA_REPORT_ID = V_QAREPID
       AND COMPANY_ID = V_COMPID;

    IF V_UTFINAL = 'WRJ' THEN
      UPDATE scmdata.t_qa_scope_backup
         SET PROCESSING_TYPE = 'RJ'
       WHERE QA_REPORT_ID = V_QAREPID
         AND COMPANY_ID = V_COMPID;
    ELSIF V_UTFINAL = 'WRT' THEN
      UPDATE scmdata.t_qa_scope_backup
         SET PROCESSING_TYPE = 'RT'
       WHERE QA_REPORT_ID = V_QAREPID
         AND COMPANY_ID = V_COMPID;
    END IF;
  END P_UPDATE_QAUNQUAL_TREATMENT;


  --更新QAreport相关值
  PROCEDURE P_UPDATE_VALUE_AFTER_COMMIT_CHECK(V_QAREPID   IN VARCHAR2,
                                              V_COMPID    IN VARCHAR2,
                                              V_CUID      IN VARCHAR2) IS

  BEGIN
    UPDATE scmdata.t_qa_report_backup T
       SET STATUS = SUBSTR(T.STATUS,1,1)||'_PCF',
           COMMIT_ID = V_CUID,
           COMMIT_TIME = SYSDATE
     WHERE QA_REPORT_ID = V_QAREPID
       AND COMPANY_ID = V_COMPID;

    FOR I IN (SELECT DISTINCT ASN_ID, COMPANY_ID
                FROM scmdata.t_qa_scope_backup
               WHERE QA_REPORT_ID = V_QAREPID
                 AND COMPANY_ID = V_COMPID) LOOP
      UPDATE SCMDATA.T_ASNORDERED
         SET STATUS = 'CI'
       WHERE ASN_ID = I.ASN_ID
         AND COMPANY_ID = I.COMPANY_ID;
    END LOOP;
  END P_UPDATE_VALUE_AFTER_COMMIT_CHECK;


  --QA报告提交相关逻辑
  PROCEDURE P_QAREP_COMMIT(V_QAREPID   IN VARCHAR2,
                           V_COMPID    IN VARCHAR2,
                           V_CUID      IN VARCHAR2) IS

  BEGIN
    --提交前校验
    P_QA_REPORT_COMMIT_CHECK(V_QARID   => V_QAREPID,
                             V_COMPID  => V_COMPID);

    --当不合格处理明细等于整批返工/整批拒收时，更新QASCOPE表
    P_UPDATE_QAUNQUAL_TREATMENT(V_QAREPID => V_QAREPID,
                                V_COMPID  => V_COMPID);

    --更新QAreport相关值
    P_UPDATE_VALUE_AFTER_COMMIT_CHECK(V_QAREPID => V_QAREPID,
                                      V_COMPID  => V_COMPID,
                                      V_CUID    => V_CUID);

    --更新数量数据
    P_UPDATE_REP_AMOUNT(V_QAREPID => V_QAREPID,
                        V_COMPID  => V_COMPID,
                        V_CURUSER => V_CUID);
  END P_QAREP_COMMIT;


  --编辑质检报告部分
  --获取QA质检报告编辑页面sql
  FUNCTION F_GET_EDIT_QAREP_SQL(V_QAREPID   IN VARCHAR2,
                                V_COMPID    IN VARCHAR2,
                                V_CUID      IN VARCHAR2,
                                ASS_METHOD  IN VARCHAR2) RETURN CLOB IS
    V_EXESQL  CLOB;
    V_DIFSQL  VARCHAR2(512);
  BEGIN
    IF ASS_METHOD = 'VAR' THEN
      V_DIFSQL := 'WHERE (COMPANY_ID, QA_REPORT_ID)
    IN (SELECT COMPANY_ID, VAR_VARCHAR
          FROM SCMDATA.T_VARIABLE
         WHERE OBJ_ID = '''||V_CUID||'''
           AND COMPANY_ID = '''||V_COMPID||'''
           AND VAR_NAME = ''QA_REPORT_ID'')';
    ELSIF ASS_METHOD = 'REP' THEN
      V_DIFSQL := 'WHERE QA_REPORT_ID = '''||V_QAREPID||
                   ''' AND COMPANY_ID = '''||V_COMPID||'''';
    END IF;

    V_EXESQL := 'SELECT A.QA_REPORT_ID,A.COMPANY_ID,B.RELA_GOO_ID,B.STYLE_NUMBER,B.STYLE_NAME,
         (SELECT SUPPLIER_COMPANY_NAME
            FROM SCMDATA.T_SUPPLIER_INFO
           WHERE SUPPLIER_CODE = A.SUPPLIER_CODE
             AND COMPANY_ID = A.COMPANY_ID) SUPPLIER,
         A.PCOMESUM_AMOUNT QAPCOMESUM_AMOUNT,
         A.FIRSTCHECK_AMOUNT QAFIRSTCHECK_AMOUNT,
         (SELECT GROUP_DICT_NAME
            FROM SCMDATA.SYS_GROUP_DICT
           WHERE GROUP_DICT_VALUE = A.CHECK_TYPE
             AND GROUP_DICT_TYPE = ''QA_REPCHECK_TYPE'') QACHECK_TYPE,
         A.ADDCHECK_AMOUNT QAADDCHECK_AMOUNT,
         A.CHECKSUM_AMOUNT QACHECKSUM_AMOUNT,
         A.CHECKERS QACHECKERS,
         NVL(TO_CHAR(ROUND(A.CHECKSUM_AMOUNT / DECODE(A.PCOMESUM_AMOUNT,0,1,A.PCOMESUM_AMOUNT) * 100,2),''fm990.00''),0.00)||''%'' QACHECK_RATE,
         A.CHECK_DATE QACHECK_DATE,
         A.MEMO,
         A.UNQUALREASON_CLASS,
         A.CHECK_RESULT QACHECK_RESULT,
         A.CHECKSUM_AMOUNT QACHECK_AMOUNT,
         A.UNQUAL_TREATMENT,
         A.UNQUAL_SUBJUECTS,
         A.UNQUAL_AMOUNT QAUNQUAL_AMOUNT,
         NVL(TO_CHAR(ROUND((1-(NVL(A.UNQUAL_AMOUNT,0) / DECODE(A.CHECKSUM_AMOUNT,0,1,A.CHECKSUM_AMOUNT))) * 100,2),''fm990.00''),0.00)||''%'' QAQUAL_RATE,
         A.ATTACHMENT,A.YY_RESULT,A.YY_UQDESC,A.MFL_RESULT,A.MFL_UQDESC,A.GY_RESULT,A.GY_UQDESC,
         A.BX_RESULT,A.BX_UQDESC
    FROM (SELECT Z.QA_REPORT_ID,Z.COMPANY_ID,Z.PCOMESUM_AMOUNT,Z.FIRSTCHECK_AMOUNT,Z.ADDCHECK_AMOUNT,
                 Z.CHECKSUM_AMOUNT,Z.GOTSUM_AMOUNT,Z.SUBS_AMOUNT,Z.REJSUM_AMOUNT,Z.RETSUM_AMOUNT,
                 Z.CHECKERS,Z.CHECK_DATE,Z.CHECK_RESULT,Z.UNQUAL_TREATMENT,Z.UNQUAL_SUBJUECTS,
                 Z.UNQUAL_AMOUNT,Z.ATTACHMENT,Z.MEMO,Z.YY_RESULT,Z.YY_UQDESC,Z.MFL_RESULT,Z.MFL_UQDESC,
                 Z.GY_RESULT,Z.GY_UQDESC,Z.BX_RESULT,Z.BX_UQDESC,Z.CHECK_TYPE,Z.GOO_ID,Z.UNQUALREASON_CLASS,
                 (SELECT MAX(SUPPLIER_CODE)
                    FROM scmdata.t_qa_scope_backup
                   WHERE QA_REPORT_ID = Z.QA_REPORT_ID
                     AND COMPANY_ID = Z.COMPANY_ID) SUPPLIER_CODE
            FROM scmdata.t_qa_report_backup Z '|| V_DIFSQL ||') A
   INNER JOIN SCMDATA.T_COMMODITY_INFO B
      ON A.GOO_ID = B.GOO_ID
     AND A.COMPANY_ID = B.COMPANY_ID';
    RETURN V_EXESQL;
  END F_GET_EDIT_QAREP_SQL;

  --编辑质检报告部分-修改相关逻辑
  PROCEDURE P_UPDATE_QAREP(V_QAREP_RAC IN scmdata.t_qa_report_backup%ROWTYPE) IS

  BEGIN
    UPDATE scmdata.t_qa_report_backup
       SET CHECKSUM_AMOUNT    = V_QAREP_RAC.CHECKSUM_AMOUNT,
           FIRSTCHECK_AMOUNT  = V_QAREP_RAC.FIRSTCHECK_AMOUNT,
           ADDCHECK_AMOUNT    = V_QAREP_RAC.ADDCHECK_AMOUNT,
           CHECKERS           = V_QAREP_RAC.CHECKERS,
           CHECK_DATE         = V_QAREP_RAC.CHECK_DATE,
           CHECK_RESULT       = V_QAREP_RAC.CHECK_RESULT,
           UNQUAL_TREATMENT   = V_QAREP_RAC.UNQUAL_TREATMENT,
           UNQUAL_AMOUNT      = V_QAREP_RAC.UNQUAL_AMOUNT,
           ATTACHMENT         = V_QAREP_RAC.ATTACHMENT,
           MEMO               = V_QAREP_RAC.MEMO,
           YY_RESULT          = V_QAREP_RAC.YY_RESULT,
           YY_UQDESC          = V_QAREP_RAC.YY_UQDESC,
           MFL_RESULT         = V_QAREP_RAC.MFL_RESULT,
           MFL_UQDESC         = V_QAREP_RAC.MFL_UQDESC,
           GY_RESULT          = V_QAREP_RAC.GY_RESULT,
           GY_UQDESC          = V_QAREP_RAC.GY_UQDESC,
           BX_RESULT          = V_QAREP_RAC.BX_RESULT,
           BX_UQDESC          = V_QAREP_RAC.BX_UQDESC,
           UNQUALREASON_CLASS = V_QAREP_RAC.UNQUALREASON_CLASS,
           UPDATE_ID          = V_QAREP_RAC.UPDATE_ID,
           UPDATE_TIME        = V_QAREP_RAC.UPDATE_TIME
     WHERE QA_REPORT_ID = V_QAREP_RAC.QA_REPORT_ID
       AND COMPANY_ID = V_QAREP_RAC.COMPANY_ID;

    SCMDATA.PKG_QA_RELA.P_CHECK_QAREPORT_NESINFO(V_QA_REPORT_ID => V_QAREP_RAC.QA_REPORT_ID,
                                                 V_COMPANY_ID => V_QAREP_RAC.COMPANY_ID);

    SCMDATA.PKG_QA_RELA.P_UPDATE_UQUAL_STR(V_QAREPID => V_QAREP_RAC.QA_REPORT_ID,
                                           V_COMPID  => V_QAREP_RAC.COMPANY_ID);

    SCMDATA.PKG_QA_RELA.P_UPDATE_REP_SUMAMOUNT_BY_TYPE(V_QAREPID =>  V_QAREP_RAC.QA_REPORT_ID,
                                                       V_COMPID  =>  V_QAREP_RAC.COMPANY_ID,
                                                       V_CURUSER =>  V_QAREP_RAC.UPDATE_ID);
  END P_UPDATE_QAREP;


  --质检报告按钮跳转页面部分
  --修改质检范围部分
  ----获取修改质检范围sql-select_sql
  FUNCTION F_GET_CHANGE_QAREPORT_SCOPE_SQL(V_QAREPID  IN VARCHAR2,
                                           V_COMPID   IN VARCHAR2) RETURN CLOB IS
    V_EXESQL  CLOB;
  BEGIN
    V_EXESQL := 'SELECT A.ASN_ID, A.ORDER_ID QAORDER_ID, B.RELA_GOO_ID,
         B.STYLE_NUMBER, B.STYLE_NAME,
         (SELECT SUPPLIER_COMPANY_NAME
            FROM SCMDATA.T_SUPPLIER_INFO
           WHERE INSTR(A.SUPPLIER_CODE||'','', SUPPLIER_CODE) > 0
             AND COMPANY_ID = A.COMPANY_ID) SUPPLIER,
         A.PCOME_AMOUNT QAPCOME_AMOUNT, A.GOT_AMOUNT QAGOT_AMOUNT,
         TO_CHAR(A.PCOME_TIME,''YYYY-MM-DD'') PCOME_DATE, A.SCAN_TIME,
         A.TAKEOVER_TIME, A.COMPANY_ID
    FROM (SELECT QA_REPORT_ID, COMPANY_ID, ASN_ID, GOO_ID, MAX(ORDER_ID) ORDER_ID,
                 LISTAGG(SUPPLIER_CODE,'','') SUPPLIER_CODE,
                 SUM(PCOME_AMOUNT) PCOME_AMOUNT,
                 SUM(GOT_AMOUNT) GOT_AMOUNT,
                 MAX(PCOME_TIME) PCOME_TIME,
                 MAX(SCAN_TIME) SCAN_TIME,
                 MAX(TAKEOVER_TIME) TAKEOVER_TIME
            FROM (SELECT * FROM scmdata.t_qa_scope_backup
                   WHERE QA_REPORT_ID = '''||V_QAREPID||'''
                     AND COMPANY_ID = '''||V_COMPID||''')
           GROUP BY QA_REPORT_ID, COMPANY_ID, ASN_ID, GOO_ID) A
   INNER JOIN SCMDATA.T_COMMODITY_INFO B
      ON A.GOO_ID = B.GOO_ID
     AND A.COMPANY_ID = B.COMPANY_ID';
    RETURN V_EXESQL;
  END F_GET_CHANGE_QAREPORT_SCOPE_SQL;


  ----修改质检范围update_sql
  PROCEDURE P_CHANGE_QUAL_RANGE_INSERT(V_ASNID   IN VARCHAR2,
                                       V_COMPID  IN VARCHAR2,
                                       V_QAREPID IN VARCHAR2,
                                       V_CUID    IN VARCHAR2) IS
    V_QASCOPEID  VARCHAR2(32);
    V_ORIGIN     VARCHAR2(8);
  BEGIN
    IF V_ASNID IS NULL THEN
      RAISE_APPLICATION_ERROR(-20002,'请勾选需要数据！');
    END IF;

    SELECT MAX(ORIGIN)
      INTO V_ORIGIN
      FROM scmdata.t_qa_report_backup
     WHERE QA_REPORT_ID = V_QAREPID
       AND COMPANY_ID = V_COMPID;

    IF V_ORIGIN = 'WMSCD' THEN
      RAISE_APPLICATION_ERROR(-20002,'WMS已质检数据不能修改质检范围！');
    END IF;


    FOR I IN (SELECT A.ASN_ID,A.COMPANY_ID,A.ORDER_ID,A.SUPPLIER_CODE,
                     A.PCOME_DATE PCOME_TIME,A.SCAN_TIME,B.GOO_ID,C.BARCODE,
                     NVL(C.PCOME_AMOUNT,B.PCOME_AMOUNT) PCOME_AMOUNT,
                     NVL(C.GOT_AMOUNT,B.GOT_AMOUNT) GOT_AMOUNT,
                     NVL(B.RECEIVE_TIME,C.RECEIVE_TIME) RECEIVE_TIME
                FROM (SELECT ASN_ID,ORDER_ID,COMPANY_ID,SUPPLIER_CODE,
                             PCOME_DATE, SCAN_TIME
                        FROM SCMDATA.T_ASNORDERED
                       WHERE ASN_ID = V_ASNID
                         AND COMPANY_ID = V_COMPID) A
               INNER JOIN SCMDATA.T_ASNORDERS B
                  ON A.ASN_ID = B.ASN_ID
                 AND A.COMPANY_ID = B.COMPANY_ID
                LEFT JOIN SCMDATA.T_ASNORDERSITEM C
                  ON A.ASN_ID = C.ASN_ID
                 AND A.COMPANY_ID = C.COMPANY_ID) LOOP

      V_QASCOPEID := SCMDATA.F_GET_UUID();

      INSERT INTO scmdata.t_qa_scope_backup
        (QA_SCOPE_ID,QA_REPORT_ID,COMPANY_ID,ASN_ID,ORDER_ID,
         GOO_ID,BARCODE,PROCESSING_TYPE,SUPPLIER_CODE,
         PCOME_AMOUNT,GOT_AMOUNT,PCOME_TIME,SCAN_TIME,
         TAKEOVER_TIME,CREATE_ID,CREATE_TIME,COMMIT_TYPE,ORIGIN)
      VALUES
        (V_QASCOPEID,V_QAREPID,V_COMPID,
         I.ASN_ID,I.ORDER_ID,I.GOO_ID,I.BARCODE,'NM',
         I.SUPPLIER_CODE,I.PCOME_AMOUNT,I.GOT_AMOUNT,
         I.PCOME_TIME,I.SCAN_TIME,I.RECEIVE_TIME,
         V_CUID,SYSDATE,'PC','SCM');

      UPDATE SCMDATA.T_ASNORDERED
         SET STATUS = 'CI'
       WHERE ASN_ID = I.ASN_ID
         AND COMPANY_ID = I.COMPANY_ID;
    END LOOP;

    SCMDATA.PKG_QA_RELA.P_GEN_SUBS_DATA(V_QAREPID => V_QAREPID,
                                        V_COMPID  => V_COMPID);

    SCMDATA.PKG_QA_RELA.P_UPDATE_QAUNQUAL_TREATMENT(V_QAREPID => V_QAREPID, V_COMPID => V_COMPID);

    SCMDATA.PKG_QA_RELA.P_UPDATE_REP_AMOUNT(V_QAREPID => V_QAREPID,
                                            V_COMPID  => V_COMPID,
                                            V_CURUSER => V_CUID);
  END P_CHANGE_QUAL_RANGE_INSERT;


  ----修改质检范围delete_sql
  PROCEDURE P_CHANGE_QUAL_RANGE_DELETE(V_QAREPID  IN VARCHAR2,
                                       V_COMPID   IN VARCHAR2,
                                       V_ASNID    IN VARCHAR2) IS

  BEGIN
    --删除前校验
    P_CHECK_BEFORE_QUAL_RANGE_DELETE(V_QAREPID => V_QAREPID,
                                     V_COMPID  => V_COMPID,
                                     V_ASNID   => V_ASNID);
    --删除核
    P_CHANGE_QUAL_RANGE_DELETE_CORE(V_QAREPID  => V_QAREPID,
                                    V_COMPID   => V_COMPID,
                                    V_ASNID    => V_ASNID);
  END P_CHANGE_QUAL_RANGE_DELETE;


  ------修改质检范围删除前校验
  PROCEDURE P_CHECK_BEFORE_QUAL_RANGE_DELETE(V_QAREPID  IN VARCHAR2,
                                             V_COMPID   IN VARCHAR2,
                                             V_ASNID    IN VARCHAR2) IS
    V_JUGNUM     NUMBER(4);
    V_CT         VARCHAR2(8);
    V_ST         VARCHAR2(8);
    V_UT         VARCHAR2(8);
    V_ORIGIN     VARCHAR2(256);
  BEGIN
    SELECT CHECK_TYPE, STATUS, UNQUAL_TREATMENT
      INTO V_CT, V_ST, V_UT
      FROM scmdata.t_qa_report_backup
     WHERE QA_REPORT_ID = V_QAREPID
       AND COMPANY_ID = V_COMPID;

    SELECT LISTAGG(ORIGIN,',')
      INTO V_ORIGIN
      FROM scmdata.t_qa_scope_backup
     WHERE QA_REPORT_ID =  V_QAREPID
       AND COMPANY_ID = V_COMPID
       AND ASN_ID = V_ASNID;

    IF V_CT = 'RC' THEN
      RAISE_APPLICATION_ERROR(-20002,'返工质检报告无法修改质检范围！');
    ELSIF V_UT = 'WRJ' AND INSTR(V_ST,'_PCF') > 0 THEN
      RAISE_APPLICATION_ERROR(-20002,'不合格处理为“整批拒收”，无法修改质检范围！');
    ELSIF V_UT = 'WRT' AND INSTR(V_ST,'_PCF') > 0 THEN
      RAISE_APPLICATION_ERROR(-20002,'不合格处理为“整批返工”，无法修改质检范围！');
    ELSIF INSTR(V_ORIGIN,'WMS')>0 THEN
      RAISE_APPLICATION_ERROR(-20002,'存在WMS质检数据，不能删除！');
    END IF;

    SELECT COUNT(1)
      INTO V_JUGNUM
      FROM scmdata.t_qa_scope_backup
     WHERE QA_REPORT_ID = V_QAREPID
       AND ASN_ID = V_ASNID
       AND COMPANY_ID = V_COMPID
       AND SKUCOMFIRM_RESULT IS NOT NULL
       AND COMMIT_TYPE = 'CD';

    IF V_JUGNUM > 0 THEN
      RAISE_APPLICATION_ERROR(-20002,'删除失败！所选报告存在质检确认并提交的SKU数据，请检查。');
    END IF;
  END P_CHECK_BEFORE_QUAL_RANGE_DELETE;

  ------修改质检范围-删除核
  PROCEDURE P_CHANGE_QUAL_RANGE_DELETE_CORE(V_QAREPID  IN VARCHAR2,
                                            V_COMPID   IN VARCHAR2,
                                            V_ASNID    IN VARCHAR2) IS
    V_JUGNUM  NUMBER(1);
    V_EXESQL  VARCHAR2(1024);
  BEGIN
    SELECT COUNT(1)
      INTO V_JUGNUM
      FROM scmdata.t_qa_scope_backup
     WHERE QA_REPORT_ID = V_QAREPID
       AND ASN_ID <> V_ASNID
       AND COMPANY_ID = V_COMPID
       AND ROWNUM = 1;

    IF V_JUGNUM > 0 THEN
      V_EXESQL := 'DELETE FROM scmdata.t_qa_scope_backup WHERE ASN_ID = '''||
                    V_ASNID||''' AND COMPANY_ID = '''||V_COMPID||'''';
      EXECUTE IMMEDIATE V_EXESQL;
      V_EXESQL := 'UPDATE SCMDATA.T_ASNORDERED SET STATUS = ''NC'' WHERE ASN_ID = '''||
                    V_ASNID||''' AND COMPANY_ID = '''||V_COMPID||'''';
      EXECUTE IMMEDIATE V_EXESQL;
    ELSE
      RAISE_APPLICATION_ERROR(-20002,'删除失败！至少保留一条数据。');
    END IF;
  END P_CHANGE_QUAL_RANGE_DELETE_CORE;




  ----修改质检范围从表-select_sql
  FUNCTION F_GET_QUALIFY_SKU_DETAIL_SQL(V_QAREPID  IN VARCHAR2,
                                        V_COMPID   IN VARCHAR2,
                                        V_ASNID    IN VARCHAR2) RETURN CLOB IS
    V_EXESQL  CLOB;
  BEGIN
    V_EXESQL := 'SELECT A.QA_SCOPE_ID, A.COMPANY_ID, A.QA_REPORT_ID, A.ASN_ID,
         A.BARCODE, B.COLORNAME, B.SIZENAME, A.PCOME_AMOUNT QAPCOME_AMOUNT, A.GOT_AMOUNT QAGOT_AMOUNT
    FROM (SELECT QA_SCOPE_ID, COMPANY_ID, QA_REPORT_ID, ASN_ID,
                 BARCODE, PCOME_AMOUNT, GOT_AMOUNT
            FROM scmdata.t_qa_scope_backup
           WHERE QA_REPORT_ID = '''||V_QAREPID||'''
             AND ASN_ID = '''||V_ASNID||'''
             AND COMPANY_ID = '''||V_COMPID||''') A
   INNER JOIN SCMDATA.T_COMMODITY_COLOR_SIZE B
      ON A.BARCODE = B.BARCODE
     AND A.COMPANY_ID = B.COMPANY_ID';
    RETURN V_EXESQL;
  END F_GET_QUALIFY_SKU_DETAIL_SQL;






  --不合格处理明细部分sql
  --不合格处理明细select_sql
  FUNCTION F_GET_UNQUAL_TREATMENT_SQL(V_QAREPID  IN VARCHAR2,
                                      V_COMPID   IN VARCHAR2) RETURN CLOB IS
    V_EXESQL  CLOB;
  BEGIN
    V_EXESQL := 'SELECT A.QA_SCOPE_ID,A.PROCESSING_TYPE,A.ASN_ID,B.RELA_GOO_ID,A.BARCODE,C.COLORNAME,
         C.SIZENAME,A.PCOME_AMOUNT QAPCOME_AMOUNT,A.GOT_AMOUNT QAGOT_AMOUNT
    FROM (SELECT QA_SCOPE_ID,COMPANY_ID,ASN_ID,GOO_ID,BARCODE,
                 PCOME_AMOUNT,GOT_AMOUNT,PROCESSING_TYPE
            FROM scmdata.t_qa_scope_backup
           WHERE QA_REPORT_ID = '''||V_QAREPID||'''
             AND PROCESSING_TYPE <> ''NM''
             AND COMPANY_ID = '''||V_COMPID||''') A
    LEFT JOIN SCMDATA.T_COMMODITY_INFO B
      ON A.GOO_ID = B.GOO_ID
     AND A.COMPANY_ID = B.COMPANY_ID
    LEFT JOIN SCMDATA.T_COMMODITY_COLOR_SIZE C
      ON A.BARCODE = C.BARCODE
     AND A.COMPANY_ID = C.COMPANY_ID';
    RETURN V_EXESQL;
  END F_GET_UNQUAL_TREATMENT_SQL;


  --不合格处理明细update_sql
  PROCEDURE P_UNQUAL_TREATMENT_UPDATE(V_QASCOPEID  IN VARCHAR2,
                                      V_PROTYPE    IN VARCHAR2,
                                      V_CUID       IN VARCHAR2,
                                      V_COMPID     IN VARCHAR2) IS

  BEGIN
    --更新前校验
    P_UNQUAL_TREATMENT_CHECK_BEFORE_UPDATE(V_QASCOPEID => V_QASCOPEID,
                                           V_COMPID    => V_COMPID,
                                           V_PROTYPE   => V_PROTYPE);
    --更新核
    P_UNQUAL_TREATMENT_UPDATE_CORE(V_QASCOPEID => V_QASCOPEID,
                                   V_PROTYPE   => V_PROTYPE,
                                   V_CUID      => V_CUID,
                                   V_COMPID    => V_COMPID);
  END P_UNQUAL_TREATMENT_UPDATE;



  --不合格处理明细update_sql-不合格处理明细更新前校验
  PROCEDURE P_UNQUAL_TREATMENT_CHECK_BEFORE_UPDATE(V_QASCOPEID  IN VARCHAR2,
                                                   V_COMPID     IN VARCHAR2,
                                                   V_PROTYPE    IN VARCHAR2) IS
    V_JUGNUM       NUMBER(8);
    V_EINFO        VARCHAR2(512);
  BEGIN
    SELECT COUNT(1),MAX(A.ASN_ID||':'||B.COLORNAME||'+'||B.SIZENAME)
      INTO V_JUGNUM,V_EINFO
      FROM (SELECT ASN_ID,COMPANY_ID,BARCODE
              FROM scmdata.t_qa_scope_backup
             WHERE QA_SCOPE_ID = V_QASCOPEID
               AND COMPANY_ID = V_COMPID
               AND COMMIT_TYPE = 'CD') A
      LEFT JOIN SCMDATA.T_COMMODITY_COLOR_SIZE B
        ON A.BARCODE = B.BARCODE
       AND A.COMPANY_ID = B.COMPANY_ID;

    IF V_JUGNUM > 0 THEN
      RAISE_APPLICATION_ERROR(-20002,V_EINFO||'已提交质检确认结果，不能修改！');
    END IF;

    IF V_PROTYPE IS NULL THEN
      RAISE_APPLICATION_ERROR(-20002,'【处理类型】字段为必填，请选择！');
    END IF;
  END P_UNQUAL_TREATMENT_CHECK_BEFORE_UPDATE;


  --不合格处理明细update_sql-不合格处理明细更新核
  PROCEDURE P_UNQUAL_TREATMENT_UPDATE_CORE(V_QASCOPEID  IN VARCHAR2,
                                           V_PROTYPE    IN VARCHAR2,
                                           V_CUID       IN VARCHAR2,
                                           V_COMPID     IN VARCHAR2) IS
    V_QAREPID  VARCHAR2(32);
  BEGIN
    SELECT QA_REPORT_ID
      INTO V_QAREPID
      FROM scmdata.t_qa_scope_backup
     WHERE QA_SCOPE_ID = V_QASCOPEID
       AND COMPANY_ID = V_COMPID;

    UPDATE scmdata.t_qa_scope_backup
       SET PROCESSING_TYPE = V_PROTYPE
     WHERE QA_SCOPE_ID = V_QASCOPEID
       AND COMPANY_ID = V_COMPID;

    SCMDATA.PKG_QA_RELA.P_UPDATE_REP_SUMAMOUNT_BY_TYPE(V_QAREPID => V_QAREPID,
                                                       V_COMPID  => V_COMPID,
                                                       V_CURUSER => V_CUID);
  END P_UNQUAL_TREATMENT_UPDATE_CORE;


  --不合格处理明细-insert_sql
  PROCEDURE P_UNQUAL_TREAETMENT_INSERT(V_QASCOPEID IN VARCHAR2,
                                       V_COMPID    IN VARCHAR2) IS
    V_ASNID  VARCHAR2(32);
    V_BD     VARCHAR2(32);
    V_CT     VARCHAR2(8);
  BEGIN
    IF V_QASCOPEID IS NOT NULL THEN
      SELECT ASN_ID,BARCODE,COMMIT_TYPE
        INTO V_ASNID,V_BD,V_CT
        FROM scmdata.t_qa_scope_backup
       WHERE QA_SCOPE_ID = V_QASCOPEID
         AND COMPANY_ID = V_COMPID;
      IF V_CT = 'CD' THEN
        RAISE_APPLICATION_ERROR(-20002,V_ASNID||'-'||V_BD||'该SKU已质检确认提交，不能修改其不合格处理明细！');
      ELSE
        UPDATE scmdata.t_qa_scope_backup
           SET PROCESSING_TYPE = ' '
         WHERE QA_SCOPE_ID = V_QASCOPEID
           AND COMPANY_ID = V_COMPID;
      END IF;
    ELSE
      RAISE_APPLICATION_ERROR(-20002,'请勾选需要数据！');
    END IF;
  END P_UNQUAL_TREAETMENT_INSERT;


  --不合格处理明细——delete_sql
  PROCEDURE P_UNQUAL_TREAETMENT_DELETE(V_QASCOPEID IN VARCHAR2,
                                       V_CURUSER   IN VARCHAR2,
                                       V_COMPID    IN VARCHAR2) IS
    V_JUGNUM       NUMBER(8);
    V_QAREPID      VARCHAR2(32);
    V_EINFO        VARCHAR2(512);
  BEGIN
    SELECT COUNT(1),MAX(A.ASN_ID||':'||B.COLORNAME||'+'||B.SIZENAME)
      INTO V_JUGNUM,V_EINFO
      FROM (SELECT ASN_ID,COMPANY_ID,BARCODE
              FROM scmdata.t_qa_scope_backup
             WHERE QA_SCOPE_ID = V_QASCOPEID
               AND COMPANY_ID = V_COMPID
               AND COMMIT_TYPE = 'CD') A
      LEFT JOIN SCMDATA.T_COMMODITY_COLOR_SIZE B
        ON A.BARCODE = B.BARCODE
       AND A.COMPANY_ID = B.COMPANY_ID;

    IF V_JUGNUM > 0 THEN
      RAISE_APPLICATION_ERROR(-20002,V_EINFO||'已提交质检确认结果，不能修改！');
    END IF;

    SELECT MAX(QA_REPORT_ID)
      INTO V_QAREPID
      FROM scmdata.t_qa_scope_backup
     WHERE QA_SCOPE_ID = V_QASCOPEID
       AND COMPANY_ID = V_COMPID;

    UPDATE scmdata.t_qa_scope_backup
       SET PROCESSING_TYPE = 'NM'
     WHERE QA_SCOPE_ID = V_QASCOPEID
       AND COMPANY_ID = V_COMPID;

    P_UPDATE_REP_AMOUNT(V_QAREPID => V_QAREPID,
                        V_COMPID  => V_COMPID,
                        V_CURUSER => V_CURUSER);
  END P_UNQUAL_TREAETMENT_DELETE;



  --维护次品数量部分
  FUNCTION F_GET_SUBS_SQL(V_QAREPID  IN VARCHAR2,
                          V_COMPID   IN VARCHAR2) RETURN CLOB IS
    V_EXESQL VARCHAR2(2048);
  BEGIN
    V_EXESQL := 'SELECT A.QA_SCOPE_ID, A.ASN_ID, D.RELA_GOO_ID,C.PACK_BARCODE QAPACK_BARCODE,
         C.PACK_BARCODE ANOMQAPACK_BARCODE, A.BARCODE, B.COLORNAME,
         B.SIZENAME, A.PCOME_AMOUNT QAPCOME_AMOUNT,A.GOT_AMOUNT QAGOT_AMOUNT,
         C.PACKAMOUNT QAPACK_AMOUNT, E.SUBS_AMOUNT QASUBS_AMOUNT
    FROM (SELECT QA_SCOPE_ID, ASN_ID, COMPANY_ID, BARCODE, PCOME_AMOUNT,
                 GOT_AMOUNT, SUBS_AMOUNT, GOO_ID
            FROM scmdata.t_qa_scope_backup
           WHERE QA_REPORT_ID = '''||V_QAREPID||'''
             AND COMPANY_ID = '''||V_COMPID||''') A
    LEFT JOIN SCMDATA.T_COMMODITY_COLOR_SIZE B
      ON A.BARCODE = B.BARCODE
     AND A.COMPANY_ID = B.COMPANY_ID
    LEFT JOIN SCMDATA.T_ASNORDERPACKS C
      ON A.ASN_ID = C.ASN_ID
     AND A.BARCODE = C.BARCODE
     AND A.COMPANY_ID = C.COMPANY_ID
    LEFT JOIN SCMDATA.T_COMMODITY_INFO D
      ON A.GOO_ID = D.GOO_ID
     AND A.COMPANY_ID = D.COMPANY_ID
    LEFT JOIN SCMDATA.T_QA_SUBSRELA E
      ON A.QA_SCOPE_ID = E.QA_SCOPE_ID
     AND A.ASN_ID = E.ASN_ID
     AND C.GOODSID = E.GOODSID
     AND C.PACK_BARCODE = E.PACKBARCODE
     AND A.COMPANY_ID = E.COMPANY_ID';
    RETURN V_EXESQL;
  END F_GET_SUBS_SQL;


  --维护次品数量-update_sql
  PROCEDURE P_SUBS_UPDATE(V_QASCOPEID  IN VARCHAR2,
                          V_COMPID     IN VARCHAR2,
                          V_ANOMPB     IN VARCHAR2,
                          V_SUBSAMOUNT IN NUMBER,
                          V_CUID       IN VARCHAR2) IS
    V_QAREPID  VARCHAR2(32);
    V_GOOID    VARCHAR2(32);
    V_BARCODE  VARCHAR2(32);
    V_ASNID    VARCHAR2(32);
  BEGIN
    --修改前校验
    P_SUBS_CHECK_BEFORE_UPDATE(V_QASCOPEID  => V_QASCOPEID,
                               V_COMPID     => V_COMPID,
                               V_ANOMPB     => V_ANOMPB,
                               V_SUBSAMOUNT => V_SUBSAMOUNT,
                               V_QAREPID    => V_QAREPID,
                               V_GOOID      => V_GOOID,
                               V_BARCODE    => V_BARCODE,
                               V_ASNID      => V_ASNID);

    --修改核
    P_SUBS_UPDATE_CORE(V_QAREPID    => V_QAREPID,
                       V_QASCOPEID  => V_QASCOPEID,
                       V_COMPID     => V_COMPID,
                       V_ANOMPB     => V_ANOMPB,
                       V_SUBSAMOUNT => V_SUBSAMOUNT,
                       V_ASNID      => V_ASNID,
                       V_GOOID      => V_GOOID,
                       V_BARCODE    => V_BARCODE,
                       V_CUID       => V_CUID);
  END P_SUBS_UPDATE;


  --维护次品数量-修改前校验
  PROCEDURE P_SUBS_CHECK_BEFORE_UPDATE(V_QASCOPEID  IN VARCHAR2,
                                       V_COMPID     IN VARCHAR2,
                                       V_ANOMPB     IN VARCHAR2,
                                       V_SUBSAMOUNT IN NUMBER,
                                       V_QAREPID    IN OUT VARCHAR2,
                                       V_GOOID      IN OUT VARCHAR2,
                                       V_BARCODE    IN OUT VARCHAR2,
                                       V_ASNID      IN OUT VARCHAR2) IS
    V_JUGNUM       NUMBER(8);
    V_EINFO        VARCHAR2(512);
    V_PCOMEAMOUNT  NUMBER(8);
    V_GOTAMOUNT    NUMBER(8);
    V_PACKAMOUNT   NUMBER(8);
  BEGIN
    SELECT COUNT(1),MAX(A.ASN_ID||':'||A.GOO_ID||'+'||B.COLORNAME||'+'||B.SIZENAME)
      INTO V_JUGNUM, V_EINFO
      FROM (SELECT ASN_ID,BARCODE,COMPANY_ID,GOO_ID
              FROM scmdata.t_qa_scope_backup
             WHERE QA_SCOPE_ID = V_QASCOPEID
               AND COMPANY_ID = V_COMPID
               AND COMMIT_TYPE = 'CD') A
      LEFT JOIN SCMDATA.T_COMMODITY_COLOR_SIZE B
        ON A.BARCODE = B.BARCODE
       AND A.COMPANY_ID = B.COMPANY_ID;

    IF V_JUGNUM > 0 THEN
      RAISE_APPLICATION_ERROR(-20002,RTRIM(V_EINFO,'+')||'已提交质检确认结果，不能修改！');
    END IF;

    SELECT MAX(PCOME_AMOUNT),MAX(GOT_AMOUNT),MAX(QA_REPORT_ID),MAX(BARCODE),MAX(ASN_ID),MAX(GOO_ID)
      INTO V_PCOMEAMOUNT,V_GOTAMOUNT,V_QAREPID,V_BARCODE,V_ASNID,V_GOOID
      FROM scmdata.t_qa_scope_backup
     WHERE QA_SCOPE_ID = V_QASCOPEID
       AND COMPANY_ID = V_COMPID;

    SELECT MAX(PACKAMOUNT)
      INTO V_PACKAMOUNT
      FROM SCMDATA.T_ASNORDERPACKS
     WHERE PACK_BARCODE = V_ANOMPB
       AND ASN_ID = V_ASNID
       AND BARCODE = V_BARCODE
       AND COMPANY_ID = V_COMPID;

    /*IF NVL(V_SUBSAMOUNT,0) > V_PCOMEAMOUNT THEN
      RAISE_APPLICATION_ERROR(-20002,'次品数量不能大于预计到仓数量');
    ELSIF NVL(V_SUBSAMOUNT,0) > V_GOTAMOUNT THEN
      RAISE_APPLICATION_ERROR(-20002,'次品数量不能大于到货量');
    ELS*/IF NVL(V_SUBSAMOUNT,0) > V_PACKAMOUNT THEN
      RAISE_APPLICATION_ERROR(-20002,'次品数量不能大于箱内SKU件数');
    END IF;
  END P_SUBS_CHECK_BEFORE_UPDATE;



  --维护次品数量-更新核
  PROCEDURE P_SUBS_UPDATE_CORE(V_QAREPID    IN VARCHAR2,
                               V_QASCOPEID  IN VARCHAR2,
                               V_COMPID     IN VARCHAR2,
                               V_ANOMPB     IN VARCHAR2,
                               V_SUBSAMOUNT IN NUMBER,
                               V_ASNID      IN VARCHAR2,
                               V_GOOID      IN VARCHAR2,
                               V_BARCODE    IN VARCHAR2,
                               V_CUID       IN VARCHAR2) IS
    V_BARSUBS      NUMBER(8);
    V_GOTAMT       NUMBER(8);
  BEGIN
    UPDATE SCMDATA.T_QA_SUBSRELA
       SET SUBS_AMOUNT = V_SUBSAMOUNT
     WHERE QA_SCOPE_ID = V_QASCOPEID
       AND ASN_ID = V_ASNID
       AND GOODSID = NVL(V_BARCODE,V_GOOID)
       AND PACKBARCODE = V_ANOMPB
       AND COMPANY_ID = V_COMPID;

    SELECT SUM(SUBS_AMOUNT)
      INTO V_BARSUBS
      FROM SCMDATA.T_QA_SUBSRELA
     WHERE QA_SCOPE_ID = V_QASCOPEID
       AND ASN_ID = V_ASNID
       AND GOODSID = NVL(V_BARCODE,V_GOOID)
       AND PACKBARCODE = V_ANOMPB
       AND COMPANY_ID = V_COMPID;

    IF V_BARCODE IS NOT NULL THEN
      SELECT GOT_AMOUNT
        INTO V_GOTAMT
        FROM SCMDATA.T_ASNORDERSITEM
       WHERE ASN_ID = V_ASNID
        AND GOO_ID = V_GOOID
        AND BARCODE = V_BARCODE
        AND COMPANY_ID = V_COMPID;
    ELSE
      SELECT GOT_AMOUNT
        INTO V_GOTAMT
        FROM SCMDATA.T_ASNORDERS
       WHERE ASN_ID = V_ASNID
        AND GOO_ID = V_GOOID
        AND COMPANY_ID = V_COMPID;
    END IF;

    UPDATE scmdata.t_qa_scope_backup
       SET GOT_AMOUNT = V_GOTAMT,
           SUBS_AMOUNT = V_BARSUBS
     WHERE QA_SCOPE_ID = V_QASCOPEID
       AND COMPANY_ID = V_COMPID;

    P_UPDATE_REP_SUMAMOUNT(V_QAREPID => V_QAREPID,
                           V_COMPID  => V_COMPID,
                           V_CURUSER => V_CUID);

    P_UPDATE_REP_SUBSAMOUNT(V_QAREPID => V_QAREPID,
                            V_COMPID  => V_COMPID,
                            V_CURUSER => V_CUID);
  END P_SUBS_UPDATE_CORE;

  --生成次品记录
  PROCEDURE P_GEN_SUBS_DATA(V_QAREPID  IN VARCHAR2,
                            V_COMPID   IN VARCHAR2) IS
    V_JUGNUM NUMBER(1);
  BEGIN
    FOR I IN (SELECT A.QA_SCOPE_ID, A.ASN_ID, B.GOODSID, B.PACK_BARCODE, A.COMPANY_ID
                FROM (SELECT QA_SCOPE_ID, ASN_ID, GOO_ID, BARCODE, COMPANY_ID
                        FROM scmdata.t_qa_scope_backup
                       WHERE QA_REPORT_ID = V_QAREPID
                         AND COMPANY_ID = V_COMPID) A
                LEFT JOIN SCMDATA.T_ASNORDERPACKS B
                  ON A.ASN_ID = B.ASN_ID
                 AND NVL(A.BARCODE,A.GOO_ID) = B.GOODSID
                 AND A.COMPANY_ID = B.COMPANY_ID) LOOP
      SELECT COUNT(1)
        INTO V_JUGNUM
        FROM SCMDATA.T_QA_SUBSRELA
       WHERE QA_SCOPE_ID = I.QA_SCOPE_ID
         AND ASN_ID = I.ASN_ID
         AND GOODSID = I.GOODSID
         AND PACKBARCODE = I.PACK_BARCODE
         AND COMPANY_ID = I.COMPANY_ID
         AND ROWNUM = 1;

      IF I.GOODSID IS NOT NULL AND V_JUGNUM = 0 THEN
        INSERT INTO SCMDATA.T_QA_SUBSRELA
          (SR_ID,COMPANY_ID,QA_SCOPE_ID,ASN_ID,GOODSID,PACKBARCODE,SUBS_AMOUNT)
        VALUES
          (SCMDATA.F_GET_UUID(),I.COMPANY_ID,I.QA_SCOPE_ID,I.ASN_ID,I.GOODSID,I.PACK_BARCODE,0);
      ELSIF I.GOODSID IS NULL THEN
        RAISE_APPLICATION_ERROR(-20002,'未接入收货箱号相关数据！');
      END IF;
    END LOOP;
  END P_GEN_SUBS_DATA;


  --删除次品记录
  PROCEDURE P_DELETE_SUBSAMT_RECORD(V_QAREPID IN VARCHAR2,
                                    V_COMPID  IN VARCHAR2) IS

  BEGIN
    FOR I IN (SELECT QA_SCOPE_ID,COMPANY_ID
                FROM scmdata.t_qa_scope_backup
               WHERE QA_REPORT_ID = V_QAREPID
                 AND COMPANY_ID = V_COMPID) LOOP
      DELETE FROM SCMDATA.T_QA_SUBSRELA
       WHERE QA_SCOPE_ID = I.QA_SCOPE_ID
         AND COMPANY_ID = I.COMPANY_ID;
    END LOOP;
  END P_DELETE_SUBSAMT_RECORD;


  /*=====================================================================================

    清空返工次品

    用途:
      用于将 QA 质检报告中质检确认结果为：返工 的次品清零

    入参:
      V_QAREPIDS  :  质检报告Id，多值用逗号分隔
      V_QASCPIDS  :  质检SCOPEId，多值用逗号分隔
      V_CURUSER   :  当前操作人
      V_COMPID    :  企业Id

    版本:
      2021-11-20 : 用于将 QA 质检报告中质检确认结果为：返工 的次品清零

  =====================================================================================*/
  PROCEDURE P_RT_CLEAR_SUBSAMT(V_QAREPIDS  IN VARCHAR2 DEFAULT NULL,
                               V_QASCPIDS  IN VARCHAR2 DEFAULT NULL,
                               V_CURUSER   IN VARCHAR2,
                               V_COMPID    IN VARCHAR2) IS
    V_EXESQL    VARCHAR2(4000);
    V_REPIDS    VARCHAR2(512):=V_QAREPIDS;
    V_SCOPEIDS  CLOB;
  BEGIN
    IF V_QAREPIDS IS NOT NULL THEN
      V_EXESQL := 'SELECT '',''||LISTAGG(QA_SCOPE_ID,'','')||'','' FROM scmdata.t_qa_scope_backup WHERE INSTR('',''||'''||V_QAREPIDS||
                  '''||'','', '',''||QA_REPORT_ID||'','') > 0 AND SKUCOMFIRM_RESULT = ''RT'' AND COMPANY_ID = '''||V_COMPID||'''';
    ELSIF V_QASCPIDS IS NOT NULL THEN
      V_EXESQL := 'SELECT '',''||LISTAGG(QA_SCOPE_ID,'','')||'','' FROM scmdata.t_qa_scope_backup WHERE INSTR('',''||'''||V_QASCPIDS||
                  '''||'','', '',''||QA_SCOPE_ID||'','') > 0 AND SKUCOMFIRM_RESULT = ''RT'' AND COMPANY_ID = '''||V_COMPID||'''';
    END IF;

    IF V_EXESQL IS NOT NULL THEN
      EXECUTE IMMEDIATE V_EXESQL INTO V_SCOPEIDS;
    END IF;

    IF REGEXP_INSTR(V_SCOPEIDS,'\w') > 0 THEN
      UPDATE SCMDATA.T_QA_SUBSRELA
         SET SUBS_AMOUNT = 0
       WHERE INSTR(','||V_SCOPEIDS||',', ','||QA_SCOPE_ID||',') > 0
         AND COMPANY_ID = V_COMPID;
    END IF;

    IF V_REPIDS IS NULL THEN
      SELECT ','||LISTAGG(DISTINCT QA_REPORT_ID,',')||','
        INTO V_REPIDS
        FROM scmdata.t_qa_scope_backup
       WHERE INSTR(','||V_SCOPEIDS||',', ','||QA_SCOPE_ID||',') > 0
         AND COMPANY_ID = V_COMPID;
    END IF;

    FOR I IN (SELECT QA_REPORT_ID, COMPANY_ID
                FROM scmdata.t_qa_report_backup
               WHERE INSTR(','||V_REPIDS||',', ','||QA_REPORT_ID||',') > 0
                 AND COMPANY_ID = V_COMPID) LOOP
      P_UPDATE_REP_AMOUNT(V_QAREPID => I.QA_REPORT_ID,
                          V_COMPID  => I.COMPANY_ID,
                          V_CURUSER => V_CURUSER);

      P_UPDATE_ASNGOTAMT(V_QAREPID  => I.QA_REPORT_ID,
                         V_COMPID   => I.COMPANY_ID);
    END LOOP;
  END P_RT_CLEAR_SUBSAMT;



  /*=====================================================================================

    通过【SKU条码】和【质检报告范围ID】更新预到货收货量

    用途:
      通过【SKU条码】和【质检报告范围ID】更新预到货收货量

    入参:
      V_ASNID    :  ASN单号
      V_COMPID   :  企业Id
      V_GOOID    :  货号
      V_BARCODE  :  SKU条码

    版本:
      2022-01-05 : 通过【SKU条码】和【质检报告范围ID】更新预到货收货量

  =====================================================================================*/
  PROCEDURE P_UPDATE_ASNGOTAMT_WITH_BARCODEANDSCPID(V_ASNID      IN VARCHAR2,
                                                    V_COMPID     IN VARCHAR2,
                                                    V_GOOID      IN VARCHAR2,
                                                    V_BARCODE    IN VARCHAR2,
                                                    V_QASCOPEID  IN VARCHAR2) IS
    V_BARSUBS    NUMBER(8);
    V_ORIGIN     VARCHAR2(8);
    V_ASNGOTAMT  NUMBER(8);
  BEGIN
    SELECT MAX(ORIGIN)
      INTO V_ORIGIN
      FROM scmdata.t_qa_scope_backup
     WHERE QA_SCOPE_ID = V_QASCOPEID
       AND COMPANY_ID = V_COMPID;

    IF INSTR(V_ORIGIN,'WMS') = 0 THEN
      SELECT SUM(SUBS_AMOUNT)
        INTO V_BARSUBS
        FROM SCMDATA.T_QA_SUBSRELA
       WHERE QA_SCOPE_ID = V_QASCOPEID
         AND ASN_ID = V_ASNID
         AND GOODSID = NVL(V_BARCODE,V_GOOID)
         AND COMPANY_ID = V_COMPID;

      UPDATE SCMDATA.T_ASNORDERSITEM ASNITEM
         SET ASNGOT_AMOUNT = ASNITEM.GOT_AMOUNT - V_BARSUBS
       WHERE ASN_ID = V_ASNID
         AND GOO_ID = V_GOOID
         AND BARCODE = V_BARCODE
         AND COMPANY_ID = V_COMPID;

      SELECT SUM(ASNGOT_AMOUNT)
        INTO V_ASNGOTAMT
        FROM SCMDATA.T_ASNORDERSITEM
       WHERE ASN_ID = V_ASNID
         AND GOO_ID = V_GOOID
         AND COMPANY_ID = V_COMPID;

      UPDATE SCMDATA.T_ASNORDERS
         SET ASNGOT_AMOUNT = V_ASNGOTAMT
       WHERE ASN_ID = V_ASNID
         AND GOO_ID = V_GOOID
         AND COMPANY_ID = V_COMPID;
    END IF;
  END P_UPDATE_ASNGOTAMT_WITH_BARCODEANDSCPID;



  /*=====================================================================================

    通过【货号】更新预到货收货量

    用途:
      通过【货号】更新预到货收货量

    入参:
      V_ASNID    :  ASN单号
      V_COMPID   :  企业Id
      V_GOOID    :  货号

    版本:
      2022-01-05 : 通过【货号】更新预到货收货量

  =====================================================================================*/
  PROCEDURE P_UPDATE_ASNGOTAMT_WITH_GOOIDANDSCPID(V_ASNID      IN VARCHAR2,
                                                  V_COMPID     IN VARCHAR2,
                                                  V_GOOID      IN VARCHAR2,
                                                  V_QASCOPEID  IN VARCHAR2) IS
    V_SUBSAMT  NUMBER(8);
  BEGIN
    SELECT SUM(SUBS_AMOUNT)
      INTO V_SUBSAMT
      FROM SCMDATA.T_QA_SUBSRELA
     WHERE QA_SCOPE_ID = V_QASCOPEID
       AND ASN_ID = V_ASNID
       AND GOODSID = V_GOOID
       AND COMPANY_ID = V_COMPID;

    UPDATE SCMDATA.T_ASNORDERS TAB
       SET ASNGOT_AMOUNT = TAB.GOT_AMOUNT - V_SUBSAMT
     WHERE ASN_ID = V_ASNID
       AND GOO_ID = V_GOOID
       AND COMPANY_ID = V_COMPID;
  END P_UPDATE_ASNGOTAMT_WITH_GOOIDANDSCPID;



  /*=====================================================================================

    更新预到货收货量

    用途:
      更新预到货收货量

    入参:
      V_ASNID    :  ASN单号
      V_COMPID   :  企业Id

    版本:
      2022-01-05 : 更新预到货收货量

  =====================================================================================*/
  PROCEDURE P_UPDATE_ASNGOTAMT(V_QAREPID   IN VARCHAR2,
                               V_COMPID    IN VARCHAR2) IS
  BEGIN
    FOR X IN (SELECT DISTINCT QA_SCOPE_ID, ASN_ID, GOO_ID, BARCODE, COMPANY_ID
                FROM scmdata.t_qa_scope_backup
               WHERE QA_REPORT_ID = V_QAREPID
                 AND COMPANY_ID = V_COMPID) LOOP
      IF X.BARCODE IS NOT NULL THEN
        P_UPDATE_ASNGOTAMT_WITH_BARCODEANDSCPID(V_ASNID     => X.ASN_ID,
                                                V_COMPID    => X.COMPANY_ID,
                                                V_GOOID     => X.GOO_ID,
                                                V_BARCODE   => X.BARCODE,
                                                V_QASCOPEID => X.QA_SCOPE_ID);
      ELSE
        P_UPDATE_ASNGOTAMT_WITH_GOOIDANDSCPID(V_ASNID     => X.ASN_ID,
                                              V_COMPID    => X.COMPANY_ID,
                                              V_GOOID     => X.GOO_ID,
                                              V_QASCOPEID => X.QA_SCOPE_ID);
      END IF;
    END LOOP;
  END P_UPDATE_ASNGOTAMT;


  /*===================================================================================

    Qa已检预增改表-增改

    用途:
       Qa已检预增改表-增改

    入参:
      V_ASNID    :  ASN编号
      V_COMPID   :  企业Id

    版本:
      2022-06-10 :  Qa已检预增改表-增改

  ===================================================================================*/
  PROCEDURE P_IU_QA_QUALEDLIST_PREIU(V_ASNID   IN VARCHAR2,
                                     V_COMPID  IN VARCHAR2) IS
    V_JUGNUM  NUMBER(1);
  BEGIN
    SELECT COUNT(1)
      INTO V_JUGNUM
      FROM SCMDATA.T_QA_QUALED_LIST_PREIU
     WHERE ASN_ID = V_ASNID
       AND COMPANY_ID = V_COMPID
       AND ROWNUM = 1;

    IF V_JUGNUM = 0 THEN
      INSERT INTO SCMDATA.T_QA_QUALED_LIST_PREIU
        (ASN_ID,COMPANY_ID,PORT_OBJ,PORT_TIME,PORT_STATUS)
      VALUES
        (V_ASNID,V_COMPID,'prcd_p_iu_quallist_preiu',SYSDATE,'SP');
    ELSE
      UPDATE SCMDATA.T_QA_QUALED_LIST_PREIU
         SET PORT_OBJ = 'prcd_p_iu_quallist_preiu',
             PORT_TIME = SYSDATE,
             PORT_STATUS = 'SP'
       WHERE ASN_ID = V_ASNID
         AND COMPANY_ID = V_COMPID;
    END IF;
  END P_IU_QA_QUALEDLIST_PREIU;



  /*===================================================================================

    Qa已检预增改表-数据同步

    用途:
       Qa已检预增改表-数据同步

    版本:
      2022-06-10 :  Qa已检预增改表-数据同步

  ===================================================================================*/
  PROCEDURE P_QA_QUALLIST_PREIU_SYNC IS
    V_ASNID   VARCHAR2(32);
    V_COMPID  VARCHAR2(32);
    V_RTNUM   NUMBER(1);
  BEGIN
    FOR I IN (SELECT ASN_ID, COMPANY_ID
                FROM SCMDATA.T_QA_QUALED_LIST_PREIU
               WHERE PORT_STATUS IN ('ER','SP')
               ORDER BY PORT_TIME
               FETCH FIRST 50 ROWS ONLY) LOOP
      V_ASNID := I.ASN_ID;
      V_COMPID := I.COMPANY_ID;
      P_IU_QUALEDLIST(V_ASNID  => I.ASN_ID,
                      V_COMPID => I.COMPANY_ID);

      UPDATE SCMDATA.T_QA_QUALED_LIST_PREIU
         SET PORT_STATUS = 'SS'
       WHERE ASN_ID = V_ASNID
         AND COMPANY_ID = V_COMPID;
    END LOOP;
    EXCEPTION
      WHEN OTHERS THEN
        SELECT MAX(RETRY_NUM)
          INTO V_RTNUM
          FROM SCMDATA.T_QA_QUALED_LIST_PREIU
         WHERE ASN_ID = V_ASNID
           AND COMPANY_ID = V_COMPID;

        IF V_RTNUM <= 3 THEN
          UPDATE SCMDATA.T_QA_QUALED_LIST_PREIU TMP
             SET PORT_STATUS = 'ER',
                 RETRY_NUM = TMP.RETRY_NUM + 1,
                 ERR_MSG = 'ERR_TIME:' || TO_CHAR(SYSDATE,'YYYY-MM-DD HH24-MI-SS') || CHR(10) ||
                           'FORMAT_ERROR_BACKTRACE:' || DBMS_UTILITY.FORMAT_ERROR_BACKTRACE || CHR(10) ||
                           'FORMAT_ERROR_STACK:' || DBMS_UTILITY.FORMAT_ERROR_STACK || CHR(10) ||
                           'FORMAT_CALL_STACK:' || DBMS_UTILITY.FORMAT_CALL_STACK
           WHERE ASN_ID = V_ASNID
             AND COMPANY_ID = V_COMPID;
        ELSE
          UPDATE SCMDATA.T_QA_QUALED_LIST_PREIU TMP
             SET PORT_STATUS = 'RW',
                 RETRY_NUM = TMP.RETRY_NUM + 1,
                 ERR_MSG = 'ERR_TIME:' || TO_CHAR(SYSDATE,'YYYY-MM-DD HH24-MI-SS') || CHR(10) ||
                           'FORMAT_ERROR_BACKTRACE:' || DBMS_UTILITY.FORMAT_ERROR_BACKTRACE || CHR(10) ||
                           'FORMAT_ERROR_STACK:' || DBMS_UTILITY.FORMAT_ERROR_STACK || CHR(10) ||
                           'FORMAT_CALL_STACK:' || DBMS_UTILITY.FORMAT_CALL_STACK
           WHERE ASN_ID = V_ASNID
             AND COMPANY_ID = V_COMPID;
        END IF;
  END P_QA_QUALLIST_PREIU_SYNC;



  /*===================================================================================

    生成已检列表 asn 基础维度数据（注意已检列表拒收和返工计算方式）

    用途:
      生成已检列表 asn 基础维度数据（注意已检列表拒收和返工计算方式）

    入参:
      V_ASNID    :  ASN编号
      V_COMPID   :  企业Id

    版本:
      2022-06-10 : 生成已检列表 asn 基础维度数据（注意已检列表拒收和返工计算方式）

  ===================================================================================*/
  PROCEDURE P_IU_QUALEDLIST_BASICDIM(V_ASNID   IN VARCHAR2,
                                     V_COMPID  IN VARCHAR2) IS
    V_STATUS  VARCHAR2(4);
  BEGIN
    SELECT MAX(STATUS)
      INTO V_STATUS
      FROM SCMDATA.T_ASNORDERED
     WHERE ASN_ID = V_ASNID
       AND COMPANY_ID = V_COMPID;

    IF V_STATUS = 'SA' THEN
      P_IU_QUALEDLIST_BASICDIM_SA(V_ASNID   => V_ASNID,
                                  V_COMPID  => V_COMPID);
    ELSIF V_STATUS = 'CD' THEN
      P_IU_QUALEDLIST_BASICDIM_CD(V_ASNID   => V_ASNID,
                                  V_COMPID  => V_COMPID);
    END IF;
  END P_IU_QUALEDLIST_BASICDIM;



  /*===================================================================================

    生成已检列表 asn 基础维度数据（特批放行）

    用途:
      生成已检列表 asn 基础维度数据（特批放行）

    入参:
      V_ASNID    :  ASN编号
      V_COMPID   :  企业Id

    版本:
      2022-06-10 : 生成已检列表 asn 基础维度数据（特批放行）

  ===================================================================================*/
  PROCEDURE P_IU_QUALEDLIST_BASICDIM_SA(V_ASNID     IN VARCHAR2,
                                        V_COMPID    IN VARCHAR2) IS

  BEGIN
    FOR I IN (SELECT ASN_ID, COMPANY_ID, GOO_ID, BARCODE, ORDER_ID, PCOME_AMOUNT,
                     GOT_AMOUNT, 0 SUBS_AMOUNT, 0 REJ_AMOUNT, 0 RET_AMOUNT, 'SA' SKUCOMFIRM_RESULT,
                     SAUSER_ID SKUCOMFIRM_USERID, SA_TIME SKUCOMFIRM_TIME,
                     PCOME_DATE, SCAN_TIME, RECEIVE_TIME
                FROM (SELECT E.ASN_ID, E.COMPANY_ID, F.GOO_ID, G.BARCODE, E.ORDER_ID,
                             NVL(G.PCOME_AMOUNT,F.PCOME_AMOUNT) PCOME_AMOUNT,
                             NVL(G.GOT_AMOUNT,F.GOT_AMOUNT) GOT_AMOUNT,
                             E.PCOME_DATE, E.SCAN_TIME, G.RECEIVE_TIME,
                             E.SAUSER_ID, E.SA_TIME
                        FROM SCMDATA.T_ASNORDERED E
                       INNER JOIN SCMDATA.T_ASNORDERS F
                          ON E.ASN_ID = F.ASN_ID
                         AND E.COMPANY_ID = F.COMPANY_ID
                        LEFT JOIN SCMDATA.T_ASNORDERSITEM G
                          ON E.ASN_ID = G.ASN_ID
                         AND E.COMPANY_ID = G.COMPANY_ID
                       WHERE E.ASN_ID = V_ASNID
                         AND E.COMPANY_ID = V_COMPID
                         AND E.STATUS = 'SA')) LOOP
      P_IU_QUALEDLIST_BASICDIM_CORE(V_ASNID        => I.ASN_ID,
                                    V_COMPID       => I.COMPANY_ID,
                                    V_GOOID        => I.GOO_ID,
                                    V_BARCODE      => NVL(I.BARCODE,I.GOO_ID),
                                    V_ORDID        => I.ORDER_ID,
                                    V_PCOMEAMT     => I.PCOME_AMOUNT - I.REJ_AMOUNT,
                                    V_GOTAMT       => I.GOT_AMOUNT - I.REJ_AMOUNT,
                                    V_SUBSAMT      => I.SUBS_AMOUNT,
                                    V_REJAMT       => I.REJ_AMOUNT,
                                    V_RETAMT       => I.RET_AMOUNT,
                                    V_SKUCFRESULT  => I.SKUCOMFIRM_RESULT,
                                    V_SKUCFUSERID  => I.SKUCOMFIRM_USERID,
                                    V_SKUCFTIME    => I.SKUCOMFIRM_TIME,
                                    V_PCOMEDATE    => I.PCOME_DATE,
                                    V_SCANTIME     => I.SCAN_TIME,
                                    V_RECEIVETIME  => I.RECEIVE_TIME);
    END LOOP;
  END P_IU_QUALEDLIST_BASICDIM_SA;



  /*===================================================================================

    生成已检列表 asn 基础维度数据（特批放行）

    用途:
      生成已检列表 asn 基础维度数据（特批放行）

    入参:
      V_ASNID    :  ASN编号
      V_COMPID   :  企业Id

    版本:
      2022-06-10 : 生成已检列表 asn 基础维度数据（特批放行）

  ===================================================================================*/
  PROCEDURE P_IU_QUALEDLIST_BASICDIM_CD(V_ASNID     IN VARCHAR2,
                                        V_COMPID    IN VARCHAR2) IS

  BEGIN
    FOR I IN (SELECT ASN_ID,COMPANY_ID,GOO_ID,BARCODE,ORDER_ID,
                     PCOME_AMOUNT, GOT_AMOUNT, SUBS_AMOUNT,
                     CASE WHEN SKUCOMFIRM_RESULT = 'NP' THEN GOT_AMOUNT ELSE 0 END REJ_AMOUNT,
                     CASE WHEN SKUCOMFIRM_RESULT = 'RT' THEN GOT_AMOUNT ELSE 0 END RET_AMOUNT,
                     SKUCOMFIRM_RESULT, SKUCOMFIRM_ID, SKUCOMFIRM_TIME, PCOME_DATE, SCAN_TIME, RECEIVE_TIME
                FROM (SELECT A.ASN_ID, A.COMPANY_ID, B.GOO_ID, C.BARCODE, A.ORDER_ID,
                             NVL(C.PCOME_AMOUNT,B.PCOME_AMOUNT) PCOME_AMOUNT,
                             NVL(C.GOT_AMOUNT,B.GOT_AMOUNT) GOT_AMOUNT,
                             NVL(FIRST_VALUE(D.SUBS_AMOUNT) OVER(PARTITION BY A.ASN_ID, A.COMPANY_ID, B.GOO_ID, C.BARCODE ORDER BY D.SKUCOMFIRM_TIME DESC),0) SUBS_AMOUNT,
                             NVL(FIRST_VALUE(D.SKUCOMFIRM_RESULT) OVER(PARTITION BY A.ASN_ID, A.COMPANY_ID, B.GOO_ID, C.BARCODE ORDER BY D.SKUCOMFIRM_TIME DESC),NULL) SKUCOMFIRM_RESULT,
                             D.SKUCOMFIRM_ID, D.SKUCOMFIRM_TIME, A.PCOME_DATE, A.SCAN_TIME, C.RECEIVE_TIME
                        FROM SCMDATA.T_ASNORDERED A
                        LEFT JOIN SCMDATA.T_ASNORDERS B
                          ON A.ASN_ID = B.ASN_ID
                         AND A.COMPANY_ID = B.COMPANY_ID
                        LEFT JOIN SCMDATA.T_ASNORDERSITEM C
                          ON A.ASN_ID = C.ASN_ID
                         AND A.COMPANY_ID = C.COMPANY_ID
                        LEFT JOIN scmdata.t_qa_scope_backup D
                          ON A.ASN_ID = D.ASN_ID
                         AND NVL(C.BARCODE,B.GOO_ID) = NVL(D.BARCODE,D.GOO_ID)
                         AND A.COMPANY_ID = D.COMPANY_ID
                       WHERE A.ASN_ID = V_ASNID
                         AND A.COMPANY_ID = V_COMPID
                         AND A.STATUS = 'CD'
                         AND EXISTS (SELECT 1 FROM scmdata.t_qa_report_backup
                                      WHERE QA_REPORT_ID = D.QA_REPORT_ID
                                        AND COMPANY_ID = D.COMPANY_ID
                                        AND STATUS IN ('N_ACF','R_ACF')))) LOOP
      P_IU_QUALEDLIST_BASICDIM_CORE(V_ASNID        => I.ASN_ID,
                                    V_COMPID       => I.COMPANY_ID,
                                    V_GOOID        => I.GOO_ID,
                                    V_BARCODE      => NVL(I.BARCODE,I.GOO_ID),
                                    V_ORDID        => I.ORDER_ID,
                                    V_PCOMEAMT     => I.PCOME_AMOUNT - I.REJ_AMOUNT,
                                    V_GOTAMT       => I.GOT_AMOUNT - I.REJ_AMOUNT,
                                    V_SUBSAMT      => I.SUBS_AMOUNT,
                                    V_REJAMT       => I.REJ_AMOUNT,
                                    V_RETAMT       => I.RET_AMOUNT,
                                    V_SKUCFRESULT  => I.SKUCOMFIRM_RESULT,
                                    V_SKUCFUSERID  => I.SKUCOMFIRM_ID,
                                    V_SKUCFTIME    => I.SKUCOMFIRM_TIME,
                                    V_PCOMEDATE    => I.PCOME_DATE,
                                    V_SCANTIME     => I.SCAN_TIME,
                                    V_RECEIVETIME  => I.RECEIVE_TIME);
    END LOOP;
  END P_IU_QUALEDLIST_BASICDIM_CD;



  /*===================================================================================

    已检列表 asn 基础维度数据增改核

    用途:
      已检列表 asn 基础维度数据增改核

    入参:
      V_ASNID        :  ASN编号
      V_COMPID       :  企业Id
      V_GOOID        :  商品档案编号
      V_BARCODE      :  SKU条码
      V_ORDID        :  订单号
      V_PCOMEAMT     :  预计到仓数量（计算公式：sku预计到仓数量-拒收数量）
      V_GOTAMT       :  到仓数量（计算公式：sku到仓数量-拒收数量）
      V_SUBSAMT      :  次品数量（计算公式：sku次品数量汇总）
      V_REJAMT       :  拒收数量（sku质检确认结果 = 不通过时，取sku到仓数量，否则为 0 ）
      V_RETAMT       :  返工数量（sku质检确认结果 = 返工时，取sku到仓数量，否则为 0 ）
      V_SKUCFRESULT  :  SKU质检确认结果
      V_PCOMEDATE    :  预计到仓日期
      V_SCANTIME     :  到仓扫描时间
      V_RECEIVETIME  :  上架时间

    版本:
      2022-06-10 : 已检列表 asn 基础维度数据增改核

  ===================================================================================*/
  PROCEDURE P_IU_QUALEDLIST_BASICDIM_CORE(V_ASNID        IN VARCHAR2,
                                          V_COMPID       IN VARCHAR2,
                                          V_GOOID        IN VARCHAR2,
                                          V_BARCODE      IN VARCHAR2,
                                          V_ORDID        IN VARCHAR2,
                                          V_PCOMEAMT     IN NUMBER,
                                          V_GOTAMT       IN NUMBER,
                                          V_SUBSAMT      IN NUMBER,
                                          V_REJAMT       IN NUMBER,
                                          V_RETAMT       IN NUMBER,
                                          V_SKUCFRESULT  IN VARCHAR2,
                                          V_SKUCFUSERID  IN VARCHAR2,
                                          V_SKUCFTIME    IN DATE,
                                          V_PCOMEDATE    IN DATE,
                                          V_SCANTIME     IN DATE,
                                          V_RECEIVETIME  IN DATE) IS
    V_JUGNUM  NUMBER(1);
  BEGIN
    SELECT COUNT(1)
      INTO V_JUGNUM
      FROM SCMDATA.T_QA_QUALED_LIST_BASICDIM
     WHERE ASN_ID = V_ASNID
       AND COMPANY_ID = V_COMPID
       AND GOO_ID = V_GOOID
       AND BARCODE = V_BARCODE
       AND ROWNUM = 1;

    IF V_JUGNUM = 0 THEN
      INSERT INTO SCMDATA.T_QA_QUALED_LIST_BASICDIM
        (ASN_ID, COMPANY_ID, GOO_ID, BARCODE, ORDER_ID, PCOME_AMOUNT, GOT_AMOUNT,
         SUBS_AMOUNT, REJ_AMOUNT, RET_AMOUNT, SKUCOMFIRM_RESULT, SKUCOMFIRM_USERID,
         SKUCOMFIRM_TIME, PCOME_DATE, SCAN_TIME, RECEIVE_TIME)
      VALUES
        (V_ASNID, V_COMPID, V_GOOID, V_BARCODE, V_ORDID, V_PCOMEAMT, V_GOTAMT,
         V_SUBSAMT, V_REJAMT, V_RETAMT, V_SKUCFRESULT, V_SKUCFUSERID, V_SKUCFTIME,
         V_PCOMEDATE, V_SCANTIME, V_RECEIVETIME);
    ELSE
      UPDATE SCMDATA.T_QA_QUALED_LIST_BASICDIM
         SET ORDER_ID = V_ORDID,
             PCOME_AMOUNT = V_PCOMEAMT,
             GOT_AMOUNT = V_GOTAMT,
             SUBS_AMOUNT = V_SUBSAMT,
             REJ_AMOUNT = V_REJAMT,
             RET_AMOUNT = V_RETAMT,
             SKUCOMFIRM_RESULT = V_SKUCFRESULT,
             SKUCOMFIRM_USERID = V_SKUCFUSERID,
             SKUCOMFIRM_TIME = V_SKUCFTIME,
             PCOME_DATE = V_PCOMEDATE,
             SCAN_TIME = V_SCANTIME,
             RECEIVE_TIME = V_RECEIVETIME
       WHERE ASN_ID = V_ASNID
         AND COMPANY_ID = V_COMPID
         AND GOO_ID = V_GOOID
         AND BARCODE = V_BARCODE;
    END IF;
  END P_IU_QUALEDLIST_BASICDIM_CORE;




  /*=====================================================================================

    增/改 Qa已检列表数据

    用途:
      增/改 Qa已检列表数据

    入参:
      V_ASNID    :  ASN单号
      V_COMPID   :  企业Id

    版本:
      2022-01-05 : 增/改 Qa已检列表数据

  =====================================================================================*/
  PROCEDURE P_IU_QUALEDLIST(V_ASNID  VARCHAR2,
                            V_COMPID VARCHAR2) IS
    V_ASNIDS   VARCHAR2(4000);
    V_GOOID    VARCHAR2(32);
    V_ORDID    VARCHAR2(32);
    V_PCAMT    NUMBER(16);
    V_GTAMT    NUMBER(16);
    V_SBAMT    NUMBER(16);
    V_RJAMT    NUMBER(16);
    V_RTAMT    NUMBER(16);
    V_JUGNUM   NUMBER(1);
  BEGIN
    P_IU_QUALEDLIST_BASICDIM(V_ASNID   => V_ASNID,
                             V_COMPID  => V_COMPID);

    SELECT MAX(ORDER_ID)
      INTO V_ORDID
      FROM SCMDATA.T_ASNORDERED
     WHERE ASN_ID = V_ASNID
       AND COMPANY_ID = V_COMPID;

    SELECT COUNT(1)
      INTO V_JUGNUM
      FROM SCMDATA.T_QA_QUALED_LIST_BASICDIM
     WHERE ORDER_ID = V_ORDID
       AND COMPANY_ID = V_COMPID
       AND ROWNUM = 1;

    IF V_JUGNUM > 0 THEN
      SELECT LISTAGG(DISTINCT ASN_ID,';'), MAX(GOO_ID),
             SUM(NVL(PCOME_AMOUNT,0)),
             SUM(NVL(GOT_AMOUNT,0)),
             SUM(NVL(SUBS_AMOUNT,0)),
             SUM(NVL(REJ_AMOUNT,0)),
             SUM(NVL(RET_AMOUNT,0))
        INTO V_ASNIDS, V_GOOID, V_PCAMT, V_GTAMT, V_SBAMT, V_RJAMT, V_RTAMT
        FROM SCMDATA.T_QA_QUALED_LIST_BASICDIM
       WHERE ORDER_ID = V_ORDID
         AND COMPANY_ID = V_COMPID
       GROUP BY ORDER_ID, COMPANY_ID;

      SELECT COUNT(1)
        INTO V_JUGNUM
        FROM SCMDATA.T_QA_QUALED_LIST
       WHERE ORDER_ID = V_ORDID
         AND COMPANY_ID = V_COMPID
         AND ROWNUM = 1;

      IF V_JUGNUM = 0 THEN
        INSERT INTO SCMDATA.T_QA_QUALED_LIST
          (ORDER_ID, COMPANY_ID, ASN_ID, GOO_ID, PCOME_AMOUNT,
           GOT_AMOUNT, SUBS_AMOUNT, REJ_AMOUNT, RET_AMOUNT)
        VALUES
          (V_ORDID, V_COMPID, V_ASNIDS, V_GOOID, V_PCAMT,
           V_GTAMT, V_SBAMT, V_RJAMT, V_RTAMT);
      ELSE
        UPDATE SCMDATA.T_QA_QUALED_LIST
           SET ASN_ID = V_ASNIDS,
               GOO_ID = V_GOOID,
               PCOME_AMOUNT = V_PCAMT,
               GOT_AMOUNT = V_GTAMT,
               SUBS_AMOUNT = V_SBAMT,
               REJ_AMOUNT = V_RJAMT,
               RET_AMOUNT = V_RTAMT
         WHERE ORDER_ID = V_ORDID
           AND COMPANY_ID = V_COMPID;
      END IF;
    END IF;

    EXCEPTION
      WHEN OTHERS THEN
        P_IU_QA_QUALEDLIST_PREIU(V_ASNID  => V_ASNID,
                                 V_COMPID => V_COMPID);
  END P_IU_QUALEDLIST;


END PKG_QA_RELA;
/

