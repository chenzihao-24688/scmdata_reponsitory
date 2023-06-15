CREATE OR REPLACE PACKAGE SCMDATA.pkg_qa_it IS

  /*=============================================================================
  
     包：
       pkg_qa_it(qa集成测试包)
  
     函数名:
       Asn单造数据--获取随机大写字母
  
     入参:
       v_inp_invokeobj  : 调用对象
  
     版本:
       2022-10-15_zc314 : Asn单造数据--获取随机大写字母
  
  ==============================================================================*/
  FUNCTION f_get_randommajuscule(v_inp_invokeobj IN VARCHAR2) RETURN VARCHAR2;

  /*=============================================================================
  
     包：
       pkg_qa_it(qa集成测试包)
  
     函数名:
       Asn单造数据--获取随机库位
  
     入参:
       v_inp_invokeobj  : 调用对象
  
     版本:
       2022-10-15_zc314 : Asn单造数据--获取随机库位
  
  ==============================================================================*/
  FUNCTION f_get_randomwarehousepos(v_inp_invokeobj IN VARCHAR2)
    RETURN VARCHAR2;

  /*=============================================================================
  
     包：
       pkg_qa_it(qa集成测试包)
  
     函数名:
       根据质检报告状态随机获取质检报告Id
  
     入参:
       v_inp_qarepstatus  :  质检报告状态
       v_inp_compid       :  企业Id
  
     版本:
       2022-10-24_zc314 : 根据质检报告状态随机获取质检报告Id
  
  ==============================================================================*/
  FUNCTION f_get_randomqarepid(v_inp_qarepstatus IN VARCHAR2,
                               v_inp_compid      IN VARCHAR2) RETURN VARCHAR2;

  /*=============================================================================
  
     包：
       pkg_qa_it(qa集成测试包)
  
     函数名:
       Asn单造数据--判断输入订单号是否存在
  
     入参:
       v_inp_ordid  : 订单Id
       v_inp_compid : 企业id
  
     版本:
       2022-10-14_zc314 : Asn单造数据--判断输入订单号是否存在
  
  ==============================================================================*/
  FUNCTION f_is_orderexists(v_inp_ordid     IN VARCHAR2,
                            v_inp_compid    IN VARCHAR2,
                            v_inp_invokeobj IN VARCHAR2) RETURN NUMBER;

  /*=============================================================================
  
     包：
       pkg_qa_it(qa集成测试包)
  
     函数名:
       Asn单造数据--判断输入订单商品维度信息是否存在
  
     入参:
       v_inp_ordid  : 订单Id
       v_inp_compid : 企业id
  
     版本:
       2022-10-14_zc314 : Asn单造数据--判断输入订单商品维度信息是否存在
  
  ==============================================================================*/
  FUNCTION f_is_ordersexists(v_inp_ordid     IN VARCHAR2,
                             v_inp_compid    IN VARCHAR2,
                             v_inp_invokeobj IN VARCHAR2) RETURN NUMBER;

  /*=============================================================================
  
     包：
       pkg_qa_it(qa集成测试包)
  
     函数名:
       Asn单造数据--判断输入订单Sku维度信息是否存在
  
     入参:
       v_inp_ordid  : 订单Id
       v_inp_compid : 企业id
  
     版本:
       2022-10-14_zc314 : Asn单造数据--判断输入订单Sku维度信息是否存在
  
  ==============================================================================*/
  FUNCTION f_is_ordersitemexists(v_inp_ordid     IN VARCHAR2,
                                 v_inp_compid    IN VARCHAR2,
                                 v_inp_invokeobj IN VARCHAR2) RETURN NUMBER;

  /*=============================================================================
  
     包：
       pkg_qa_it(qa集成测试包)
  
     函数名:
       Asn单造数据--判断 Asnordered 是否存在
  
     入参:
       v_inp_ordid  : 订单Id
       v_inp_compid : 企业id
  
     返回值:
       Number 类型，0-不存在，1-存在
  
     版本:
       2022-10-14_zc314 : Asn单造数据--判断 Asnordered 是否存在
  
  ==============================================================================*/
  FUNCTION f_is_asnorderedexists(v_inp_ordid     IN VARCHAR2,
                                 v_inp_compid    IN VARCHAR2,
                                 v_inp_invokeobj IN VARCHAR2) RETURN NUMBER;

  /*=============================================================================
  
     包：
       pkg_qa_it(qa集成测试包)
  
     函数名:
       Asn单造数据--判断 Asnorders 是否存在
  
     入参:
       v_inp_ordid      :  订单Id
       v_inp_compid     :  企业id
       v_inp_gooid      :  商品档案编号
       v_inp_invokeobj  :  调用对象
  
     返回值:
       Number 类型，0-不存在，1-存在
  
     版本:
       2022-10-17_zc314 : Asn单造数据--判断 Asnorders 是否存在
  
  ==============================================================================*/
  FUNCTION f_is_asnordersexists(v_inp_asnid     IN VARCHAR2,
                                v_inp_compid    IN VARCHAR2,
                                v_inp_gooid     IN VARCHAR2,
                                v_inp_invokeobj IN VARCHAR2) RETURN NUMBER;

  /*=============================================================================
  
     包：
       pkg_qa_it(qa集成测试包)
  
     函数名:
       Asn单造数据--判断 Asnordersitem 是否存在
  
     入参:
       v_inp_ordid      :  订单Id
       v_inp_compid     :  企业id
       v_inp_gooid      :  商品档案编号
       v_inp_barcode    :  条码
       v_inp_invokeobj  :  调用对象
  
     返回值:
       Number 类型，0-不存在，1-存在
  
     版本:
       2022-10-17_zc314 : Asn单造数据--判断 Asnordersitem 是否存在
  
  ==============================================================================*/
  FUNCTION f_is_asnordersitemexists(v_inp_asnid     IN VARCHAR2,
                                    v_inp_compid    IN VARCHAR2,
                                    v_inp_gooid     IN VARCHAR2,
                                    v_inp_barcode   IN VARCHAR2,
                                    v_inp_invokeobj IN VARCHAR2)
    RETURN NUMBER;

  /*=============================================================================
  
     包：
       pkg_qa_it(qa集成测试包)
  
     过程名:
       Asn单造数据--获取预计到仓时段
  
     入参:
       v_inp_scantime : 到仓扫描时间
       v_inp_invokeobj : 调度对象
  
     版本:
       2022-10-14_zc314 : Asn单造数据--获取预计到仓时段
  
  ==============================================================================*/
  FUNCTION f_get_intervalname(v_inp_scantime  IN DATE,
                              v_inp_invokeobj IN VARCHAR2) RETURN VARCHAR2;

  /*=============================================================================
  
     包：
       pkg_qa_it(qa集成测试包)
  
     函数名:
       Asn单造数据--生成 Asnordered数据
  
     入参:
       v_inp_ordid  : 订单Id
       v_inp_compid : 企业id
  
     版本:
       2022-10-14_zc314 : Asn单造数据--生成 Asnordered数据
  
  ==============================================================================*/
  FUNCTION f_get_asninfobyorder(v_inp_invokeobj IN VARCHAR2) RETURN CLOB;

  /*=============================================================================
  
     包：
       pkg_qa_it(qa集成测试包)
  
     函数名:
       Asn单造数据--Asn单号前缀是否合格
  
     入参:
       v_inp_prestr    : Asn单号前缀
       v_inp_invokeobj : 调用对象
  
     版本:
       2022-10-14_zc314 : Asn单造数据--Asn单号前缀是否合格
  
  ==============================================================================*/
  FUNCTION f_is_asnprestrconform(v_inp_prestr    IN VARCHAR2,
                                 v_inp_invokeobj IN VARCHAR2) RETURN NUMBER;

  /*=============================================================================
  
     包：
       pkg_qa_it(qa集成测试包)
  
     过程名:
       Asn单造数据--生成 Asn单号参数控制
  
     入参:
       v_inp_ordid  : 订单Id
       v_inp_compid : 企业id
  
     版本:
       2022-10-14_zc314 : Asn单造数据--生成 Asn单号参数控制
  
  ==============================================================================*/
  PROCEDURE p_paramcontrol_genasnid(v_inp_prestr        IN VARCHAR2,
                                    v_inp_deliverydate  IN DATE,
                                    v_iop_prestr        IN OUT VARCHAR2,
                                    v_iop_delliverydate IN OUT DATE,
                                    v_inp_invokeobj     IN VARCHAR2);

  /*=============================================================================
  
     包：
       pkg_qa_it(qa集成测试包)
  
     函数名:
       Asn单造数据--获取Asn日序号
  
     入参:
       v_inp_deliverydate : 交期
       v_inp_invokeobj    : 调用对象
  
     版本:
       2022-10-15_zc314 : Asn单造数据--获取Asn日序号
  
  ==============================================================================*/
  FUNCTION f_get_asndayseqstr(v_inp_deliverydate IN DATE,
                              v_inp_invokeobj    IN VARCHAR2) RETURN NUMBER;

  /*=============================================================================
  
     包：
       pkg_qa_it(qa集成测试包)
  
     函数名:
       Asn单造数据--生成 Asn单号
  
     入参:
       v_inp_ordid  : 订单Id
       v_inp_compid : 企业id
  
     版本:
       2022-10-15_zc315 : Asn单造数据--生成 Asn单号
  
  ==============================================================================*/
  FUNCTION f_gen_asnid(v_inp_prestr       IN VARCHAR2,
                       v_inp_deliverydate IN DATE,
                       v_inp_invokeobj    IN VARCHAR2) RETURN CLOB;

  /*=============================================================================
  
     包：
       pkg_qa_it(qa集成测试包)
  
     过程名:
       Asn单造数据--获取 Orders 数据 Sql
  
     入参:
       v_inp_invokeobj  : 调用对象
  
     版本:
       2022-10-15_zc314 : Asn单造数据--获取 Orders 数据 Sql
  
  ==============================================================================*/
  FUNCTION f_get_ordersinfosql(v_inp_invokeobj IN VARCHAR2) RETURN CLOB;

  /*=============================================================================
  
     包：
       pkg_qa_it(qa集成测试包)
  
     过程名:
       Asn单造数据--获取 Orders 数据 Sql
  
     入参:
       v_inp_invokeobj  : 调用对象
  
     版本:
       2022-10-15_zc314 : Asn单造数据--获取 Orders 数据 Sql
  
  ==============================================================================*/
  FUNCTION f_get_ordersiteminfosql(v_inp_invokeobj IN VARCHAR2) RETURN CLOB;

  /*=============================================================================
  
     包：
       pkg_qa_it(qa集成测试包)
  
     过程名:
       Asn单造数据--获取 Asnordersitem 数据汇总 Sql
  
     入参:
       v_inp_invokeobj  : 调用对象
  
     版本:
       2022-10-15_zc314 : Asn单造数据--获取 Orders 数据 Sql
  
  ==============================================================================*/
  FUNCTION f_get_asnordersitemdatasuminfo(v_inp_invokeobj IN VARCHAR2)
    RETURN CLOB;

  /*=============================================================================
  
     包：
       pkg_qa_it(qa集成测试包)
  
     函数名:
       Asn单造数据--新增 Asnordered数据
  
     入参:
       v_inp_asnid         :  Asn单号
       v_inp_compid        :  企业Id
       v_inp_status        :  状态
       v_inp_orderid       :  订单号
       v_inp_suppliercode  :  供应商编码
       v_inp_pcomedate     :  预计到仓日期
       v_inp_changetimes   :  变更次数
       v_inp_scantime      :  扫描时间
       v_inp_memo          :  备注
       v_inp_createid      :  创建人
       v_inp_createtime    :  创建时间
       v_inp_pcomeinterval :  预计到仓时段
       v_inp_invokeobj     :  调用对象
  
     版本:
       2022-10-14_zc314 : Asn单造数据--新增 Asnordered数据
  
  ==============================================================================*/
  PROCEDURE p_ins_asnordered(v_inp_asnid         IN VARCHAR2,
                             v_inp_compid        IN VARCHAR2,
                             v_inp_status        IN VARCHAR2,
                             v_inp_orderid       IN VARCHAR2,
                             v_inp_suppliercode  IN VARCHAR2,
                             v_inp_pcomedate     IN DATE,
                             v_inp_changetimes   IN NUMBER,
                             v_inp_scantime      IN DATE,
                             v_inp_memo          IN VARCHAR2,
                             v_inp_createid      IN VARCHAR2,
                             v_inp_createtime    IN VARCHAR2,
                             v_inp_pcomeinterval IN VARCHAR2,
                             v_inp_invokeobj     IN VARCHAR2);

  /*=============================================================================
  
     包：
       pkg_qa_it(qa集成测试包)
  
     过程名:
       Asn单造数据--新增 Asnorders 信息
  
     入参:
       v_inp_ordid  : 订单Id
       v_inp_compid : 企业id
  
     版本:
       2022-10-14_zc314 : Asn单造数据--新增 Asnorders 信息
  
  ==============================================================================*/
  PROCEDURE p_ins_asnorders(v_inp_asnid        IN VARCHAR2,
                            v_inp_compid       IN VARCHAR2,
                            v_inp_gooid        IN VARCHAR2,
                            v_inp_orderamount  IN NUMBER,
                            v_inp_pcomeamount  IN NUMBER,
                            v_inp_asngotamount IN NUMBER,
                            v_inp_wmsgotamount IN NUMBER,
                            v_inp_retamount    IN NUMBER,
                            v_inp_picktime     IN DATE,
                            v_inp_shimenttime  IN DATE,
                            v_inp_receivetime  IN DATE,
                            v_inp_sortingtime  IN DATE,
                            v_inp_warehousepos IN VARCHAR2,
                            v_inp_isflcout     IN NUMBER,
                            v_inp_qcrequired   IN NUMBER,
                            v_inp_memo         IN VARCHAR2,
                            v_inp_createid     IN VARCHAR2,
                            v_inp_createtime   IN DATE,
                            v_inp_invokeobj    IN VARCHAR2);

  /*=============================================================================
  
     包：
       pkg_qa_it(qa集成测试包)
  
     过程名:
       Asn单造数据--新增 Asnordersitem 信息
  
     入参:
       v_inp_ordid  : 订单Id
       v_inp_compid : 企业id
  
     版本:
       2022-10-14_zc314 : Asn单造数据--新增 Asnordersitem 信息
  
  ==============================================================================*/
  PROCEDURE p_ins_asnordersitem(v_inp_asnid        IN VARCHAR2,
                                v_inp_compid       IN VARCHAR2,
                                v_inp_gooid        IN VARCHAR2,
                                v_inp_barcode      IN VARCHAR2,
                                v_inp_orderamount  IN NUMBER,
                                v_inp_pcomeamount  IN NUMBER,
                                v_inp_asngotamount IN NUMBER,
                                v_inp_wmsgotamount IN NUMBER,
                                v_inp_retamount    IN NUMBER,
                                v_inp_picktime     IN DATE,
                                v_inp_shimenttime  IN DATE,
                                v_inp_receivetime  IN DATE,
                                v_inp_warehousepos IN VARCHAR2,
                                v_inp_memo         IN VARCHAR2,
                                v_inp_createid     IN VARCHAR2,
                                v_inp_createtime   IN DATE,
                                v_inp_invokeobj    IN VARCHAR2);

  /*=============================================================================
  
     包：
       pkg_qa_it(qa集成测试包)
  
     过程名:
       Asn单造数据--生成 Asnordered数据
  
     入参:
       v_inp_prestr     : 前缀
       v_inp_ordid      : 订单Id
       v_inp_compid     : 企业id
       v_inp_operuserid : 操作人Id
       v_inp_invokeobj  : 调用对象
  
     入出参:
       v_iop_asnid      : Asn单号
  
     版本:
       2022-10-15_zc314 : Asn单造数据--生成 Asnordered数据
  
  ==============================================================================*/
  PROCEDURE p_gen_asnordereddata(v_inp_prestr     IN VARCHAR2,
                                 v_inp_ordid      IN VARCHAR2,
                                 v_inp_compid     IN VARCHAR2,
                                 v_inp_operuserid IN VARCHAR2,
                                 v_inp_invokeobj  IN VARCHAR2,
                                 v_iop_asnid      IN OUT VARCHAR2);

  /*=============================================================================
  
     包：
       pkg_qa_it(qa集成测试包)
  
     过程名:
       Asn单造数据--生成 Asnordered数据
  
     入参:
       v_inp_prestr     : 前缀
       v_inp_ordid      : 订单Id
       v_inp_compid     : 企业id
       v_inp_operuserid : 操作人Id
       v_inp_invokeobj  : 调用对象
  
     版本:
       2022-10-15_zc314 : Asn单造数据--生成 Asnordered数据
  
  ==============================================================================*/
  PROCEDURE p_gen_asnordersdatabyorder(v_inp_asnid      IN VARCHAR2,
                                       v_inp_ordid      IN VARCHAR2,
                                       v_inp_compid     IN VARCHAR2,
                                       v_inp_operuserid IN VARCHAR2,
                                       v_inp_invokeobj  IN VARCHAR2);

  /*=============================================================================
  
     包：
       pkg_qa_it(qa集成测试包)
  
     过程名:
       Asn单造数据--生成 Asnordersitem数据
  
     入参:
       v_inp_prestr     : 前缀
       v_inp_ordid      : 订单Id
       v_inp_compid     : 企业id
       v_inp_operuserid : 操作人Id
       v_inp_invokeobj  : 调用对象
  
     版本:
       2022-10-15_zc314 : Asn单造数据--生成 Asnordersitem数据
  
  ==============================================================================*/
  PROCEDURE p_gen_asnordersitemdata(v_inp_asnid      IN VARCHAR2,
                                    v_inp_ordid      IN VARCHAR2,
                                    v_inp_compid     IN VARCHAR2,
                                    v_inp_operuserid IN VARCHAR2,
                                    v_inp_invokeobj  IN VARCHAR2);

  /*=============================================================================
  
     包：
       pkg_qa_it(qa集成测试包)
  
     过程名:
       Asn单造数据--新增 Asn 信息
  
     入参:
       v_inp_prestr      : Asn单前缀
       v_inp_ordid       : 订单Id
       v_inp_operuserid  :  当前操作人Id
       v_inp_compid      : 企业id
  
     版本:
       2022-10-17_zc314 : Asn单造数据--判断输入订单号是否存在
  
  ==============================================================================*/
  PROCEDURE p_gen_asninfo(v_inp_prestr     IN VARCHAR2,
                          v_inp_ordid      IN VARCHAR2,
                          v_inp_operuserid IN VARCHAR2,
                          v_inp_compid     IN VARCHAR2);

  /*=============================================================================
  
     包：
       pkg_qa_it(qa集成测试包)
  
     过程名:
       集成测试--Asn免检
  
     入参:
       v_inp_aereasondicname   :  Asn免检原因字典名称
       v_inp_companyname       :  企业名称
       v_inp_asnstatusdicname  :  Asn状态字典名称
       v_inp_curuserid         :  当前操作人Id
       v_inp_getasnnumber      :  获取Asn数量
  
     版本:
       2022-10-18_zc314 : 集成测试--Asn免检
       2022-10-20_zc314 : 单元测试增加入参以适应更多测试情况
  
  ==============================================================================*/
  PROCEDURE p_it_asnae(v_inp_aereasondicname  IN VARCHAR2,
                       v_inp_companyname      IN VARCHAR2,
                       v_inp_asnstatusdicname IN VARCHAR2,
                       v_inp_curuserid        IN VARCHAR2,
                       v_inp_getasnnumber     IN NUMBER);

  /*=============================================================================
  
     包：
       pkg_qa_it(qa集成测试包)
  
     过程名:
       集成测试--生成质检报告
  
     入参:
       v_inp_mocknumstrategy  :  模拟数字策略
       v_inp_companyname      :  企业名称
       v_inp_getasnnumber     :  获取Asn数量
       v_inp_asnstatus        :  获取asn状态
  
     版本:
       2022-10-18_zc314 : 集成测试--生成质检报告
       2022-10-20_zc314 : 生成质检报告增加入参以适应更多测试场景
  
  ==============================================================================*/
  PROCEDURE p_it_genqareport(v_inp_mocknumstrategy IN VARCHAR2,
                             v_inp_companyname     IN VARCHAR2,
                             v_inp_getasnnumber    IN NUMBER,
                             v_inp_asnstatus       IN VARCHAR2);

  /*=============================================================================
  
     包：
       pkg_qa_it(qa集成测试包)
  
     过程名:
       集成测试--生成质检报告
  
     入参:
       v_inp_compname                :  企业名称
       v_inp_checkresultdicname      :  质检结果字典名称
       v_firstsampingamountstrategy  :  首抽件数生成策略
       v_checkdatestrategy           :  质检日期生成策略
  
     版本:
       2022-10-20_zc314 : 集成测试--生成质检报告
  
  ==============================================================================*/
  PROCEDURE p_it_batchrecordpassqarep(v_inp_compname               IN VARCHAR2,
                                      v_inp_checkresultdicname     IN VARCHAR2,
                                      v_firstsampingamountstrategy IN VARCHAR2,
                                      v_checkdatestrategy          IN VARCHAR2);

  /*=============================================================================
  
     包：
       pkg_qa_it(qa集成测试包)
  
     过程名:
       集成测试--修改质检报告
  
     入参:
       v_inp_compname              :  企业名称
       v_inp_checkresultdicname    :  质检结果字典名称
       v_inp_checkdatestrategy     :  质检日期生成策略
       v_inp_problemclassdicname   :  问题分类字典编码
       v_inp_longtextstrategy      :  长文本生成策略
  
     版本:
       2022-10-24_zc314 : 集成测试--修改质检报告
  
  ==============================================================================*/
  PROCEDURE p_it_qarepinfochange(v_inp_compname            IN VARCHAR2,
                                 v_inp_checkresultdicname  IN VARCHAR2,
                                 v_inp_checkdatestrategy   IN VARCHAR2,
                                 v_inp_problemclassdicname IN VARCHAR2,
                                 v_inp_longtextstrategy    IN VARCHAR2);

  /*=============================================================================
  
     包：
       pkg_qa_it(QA集成测试包)
  
     过程名:
       通过 Asnordersitem生成 Asnordersitem_itf数据
  
     入参:
       v_inp_asnid   :  Asn单号
       v_inp_compid  :  企业Id
  
     版本:
       2022-11-01_ZC314 : 通过 Asnordersitem生成 Asnordersitem_itf数据
       
  ==============================================================================*/
  PROCEDURE p_gen_asnordersitemitfdata(v_inp_asnid  IN VARCHAR2,
                                       v_inp_compid IN VARCHAR2);

  /*=================================================================================
          
    包：
      pkg_qa_it(qa集成测试包)
          
    过程名:
      生成 Asnorderpacks数据
          
    入参:
      v_inp_asnid   :  Asn单号
      v_inp_compid  :  企业Id
          
     版本:
       2022-11-24: 生成 Asnorderpacks数据
          
  =================================================================================*/
  PROCEDURE p_gen_asnorderpacksinfo(v_inp_asnid  IN VARCHAR2,
                                    v_inp_compid IN VARCHAR2);

END pkg_qa_it;
/

CREATE OR REPLACE PACKAGE BODY SCMDATA.pkg_qa_it IS

  /*=============================================================================
  
     包：
       pkg_qa_it(qa集成测试包)
  
     函数名:
       Asn单造数据--获取随机大写字母
  
     入参:
       v_inp_invokeobj  : 调用对象
  
     版本:
       2022-10-15_zc314 : Asn单造数据--获取随机大写字母
  
  ==============================================================================*/
  FUNCTION f_get_randommajuscule(v_inp_invokeobj IN VARCHAR2) RETURN VARCHAR2 IS
    v_num             NUMBER(2) := trunc(dbms_random.value(65, 90));
    v_char            VARCHAR2(1);
    v_sql             CLOB;
    v_allowinvokeobj  CLOB := 'scmdata.pkg_qa_it.f_get_randomwarehousepos';
    v_selfdescription VARCHAR2(1024) := 'scmdata.pkg_qa_it.f_get_randommajuscule';
  BEGIN
    --访问控制
    IF instr(v_allowinvokeobj, v_inp_invokeobj) = 0 THEN
      raise_application_error(-20002,
                              '拒绝访问：调用方-' || v_inp_invokeobj || ' 被调用方-' ||
                              v_selfdescription);
    END IF;
  
    --构建 Sql
    v_sql := 'SELECT CHR(' || to_char(v_num) || ') FROM dual';
  
    --执行 Sql，赋值
    EXECUTE IMMEDIATE v_sql
      INTO v_char;
  
    RETURN v_char;
  END f_get_randommajuscule;

  /*=============================================================================
  
     包：
       pkg_qa_it(qa集成测试包)
  
     函数名:
       Asn单造数据--获取随机库位
  
     入参:
       v_inp_invokeobj  : 调用对象
  
     版本:
       2022-10-15_zc314 : Asn单造数据--获取随机库位
  
  ==============================================================================*/
  FUNCTION f_get_randomwarehousepos(v_inp_invokeobj IN VARCHAR2)
    RETURN VARCHAR2 IS
    v_firstchar       VARCHAR2(1);
    v_secoundchar     VARCHAR2(1);
    v_warehousepos    VARCHAR2(32);
    v_allowinvokeobj  CLOB := 'scmdata.pkg_qa_it.p_gen_asnordersdatabyorder;scmdata.pkg_qa_it.p_gen_asnordersitemdata';
    v_selfdescription VARCHAR2(1024) := 'scmdata.pkg_qa_it.f_get_randomwarehousepos';
  BEGIN
    --访问控制
    IF instr(v_allowinvokeobj, v_inp_invokeobj) = 0 THEN
      raise_application_error(-20002,
                              '拒绝访问：调用方-' || v_inp_invokeobj || ' 被调用方-' ||
                              v_selfdescription);
    END IF;
  
    --获取库位首字母
    v_firstchar := scmdata.pkg_qa_it.f_get_randommajuscule(v_inp_invokeobj => v_selfdescription);
  
    --获取库位次字母
    v_secoundchar := scmdata.pkg_qa_it.f_get_randommajuscule(v_inp_invokeobj => v_selfdescription);
  
    --库位构成
    v_warehousepos := v_firstchar ||
                      lpad(trunc(dbms_random.value(1, 20)), 2, '0') || '-' ||
                      v_secoundchar ||
                      lpad(trunc(dbms_random.value(1, 20)), 2, '0') || '-' ||
                      lpad(trunc(dbms_random.value(1, 20)), 2, '0');
  
    RETURN v_warehousepos;
  END f_get_randomwarehousepos;

  /*=============================================================================
  
     包：
       pkg_qa_it(qa集成测试包)
  
     函数名:
       根据质检报告状态随机获取质检报告Id
  
     入参:
       v_inp_qarepstatus  :  质检报告状态
       v_inp_compid       :  企业Id
  
     版本:
       2022-10-24_zc314 : 根据质检报告状态随机获取质检报告Id
  
  ==============================================================================*/
  FUNCTION f_get_randomqarepid(v_inp_qarepstatus IN VARCHAR2,
                               v_inp_compid      IN VARCHAR2) RETURN VARCHAR2 IS
    v_qarepid VARCHAR2(32);
  BEGIN
    SELECT MAX(qa_report_id)
      INTO v_qarepid
      FROM scmdata.t_qa_report
     WHERE status = v_inp_qarepstatus
       AND company_id = v_inp_compid;
  
    RETURN v_qarepid;
  END f_get_randomqarepid;

  /*=============================================================================
  
     包：
       pkg_qa_it(qa集成测试包)
  
     函数名:
       Asn单造数据--判断输入订单号是否存在
  
     入参:
       v_inp_ordid  : 订单Id
       v_inp_compid : 企业id
  
     版本:
       2022-10-14_zc314 : Asn单造数据--判断输入订单号是否存在
  
  ==============================================================================*/
  FUNCTION f_is_orderexists(v_inp_ordid     IN VARCHAR2,
                            v_inp_compid    IN VARCHAR2,
                            v_inp_invokeobj IN VARCHAR2) RETURN NUMBER IS
    v_jugnum          NUMBER(1);
    v_allowinvokeobj  CLOB := 'scmdata.pkg_qa_it.p_gen_asninfo';
    v_selfdescription VARCHAR2(1024) := 'scmdata.pkg_qa_it.f_is_orderexists';
  BEGIN
    --访问控制
    IF instr(v_allowinvokeobj, v_inp_invokeobj) = 0 THEN
      raise_application_error(-20002,
                              '拒绝访问：调用方-' || v_inp_invokeobj || ' 被调用方-' ||
                              v_selfdescription);
    END IF;
  
    SELECT nvl(MAX(1), 0)
      INTO v_jugnum
      FROM scmdata.t_ordered
     WHERE order_code = v_inp_ordid
       AND company_id = v_inp_compid;
  
    RETURN v_jugnum;
  END f_is_orderexists;

  /*=============================================================================
  
     包：
       pkg_qa_it(qa集成测试包)
  
     函数名:
       Asn单造数据--判断输入订单商品维度信息是否存在
  
     入参:
       v_inp_ordid  : 订单Id
       v_inp_compid : 企业id
  
     版本:
       2022-10-14_zc314 : Asn单造数据--判断输入订单商品维度信息是否存在
  
  ==============================================================================*/
  FUNCTION f_is_ordersexists(v_inp_ordid     IN VARCHAR2,
                             v_inp_compid    IN VARCHAR2,
                             v_inp_invokeobj IN VARCHAR2) RETURN NUMBER IS
    v_jugnum          NUMBER(1);
    v_allowinvokeobj  CLOB := 'scmdata.pkg_qa_it.p_gen_asninfo';
    v_selfdescription VARCHAR2(1024) := 'scmdata.pkg_qa_it.f_is_ordersexists';
  BEGIN
    --访问控制
    IF instr(v_allowinvokeobj, v_inp_invokeobj) = 0 THEN
      raise_application_error(-20002,
                              '拒绝访问：调用方-' || v_inp_invokeobj || ' 被调用方-' ||
                              v_selfdescription);
    END IF;
  
    SELECT nvl(MAX(1), 0)
      INTO v_jugnum
      FROM scmdata.t_orders
     WHERE order_id = v_inp_ordid
       AND company_id = v_inp_compid;
  
    RETURN v_jugnum;
  END f_is_ordersexists;

  /*=============================================================================
  
     包：
       pkg_qa_it(qa集成测试包)
  
     函数名:
       Asn单造数据--判断输入订单Sku维度信息是否存在
  
     入参:
       v_inp_ordid  : 订单Id
       v_inp_compid : 企业id
  
     版本:
       2022-10-14_zc314 : Asn单造数据--判断输入订单Sku维度信息是否存在
  
  ==============================================================================*/
  FUNCTION f_is_ordersitemexists(v_inp_ordid     IN VARCHAR2,
                                 v_inp_compid    IN VARCHAR2,
                                 v_inp_invokeobj IN VARCHAR2) RETURN NUMBER IS
    v_jugnum          NUMBER(1);
    v_allowinvokeobj  CLOB := 'scmdata.pkg_qa_it.p_gen_asninfo';
    v_selfdescription VARCHAR2(1024) := 'scmdata.pkg_qa_it.f_is_ordersexists';
  BEGIN
    --访问控制
    IF instr(v_allowinvokeobj, v_inp_invokeobj) = 0 THEN
      raise_application_error(-20002,
                              '拒绝访问：调用方-' || v_inp_invokeobj || ' 被调用方-' ||
                              v_selfdescription);
    END IF;
  
    SELECT nvl(MAX(1), 0)
      INTO v_jugnum
      FROM scmdata.t_ordersitem
     WHERE order_id = v_inp_ordid
       AND company_id = v_inp_compid;
  
    RETURN v_jugnum;
  END f_is_ordersitemexists;

  /*=============================================================================
  
     包：
       pkg_qa_it(qa集成测试包)
  
     函数名:
       Asn单造数据--判断 Asnordered 是否存在
  
     入参:
       v_inp_ordid  : 订单Id
       v_inp_compid : 企业id
  
     返回值:
       Number 类型，0-不存在，1-存在
  
     版本:
       2022-10-14_zc314 : Asn单造数据--判断 Asnordered 是否存在
  
  ==============================================================================*/
  FUNCTION f_is_asnorderedexists(v_inp_ordid     IN VARCHAR2,
                                 v_inp_compid    IN VARCHAR2,
                                 v_inp_invokeobj IN VARCHAR2) RETURN NUMBER IS
    v_jugnum          NUMBER(1);
    v_allowinvokeobj  CLOB := 'scmdata.pkg_qa_it.p_gen_asninfo';
    v_selfdescription VARCHAR2(1024) := 'scmdata.pkg_qa_it.f_is_asnorderedexists';
  BEGIN
    --访问控制
    IF instr(v_allowinvokeobj, v_inp_invokeobj) = 0 THEN
      raise_application_error(-20002,
                              '拒绝访问：调用方-' || v_inp_invokeobj || ' 被调用方-' ||
                              v_selfdescription);
    END IF;
  
    SELECT nvl(MAX(1), 0)
      INTO v_jugnum
      FROM scmdata.t_asnordered
     WHERE order_id = v_inp_ordid
       AND company_id = v_inp_compid;
  
    RETURN v_jugnum;
  END f_is_asnorderedexists;

  /*=============================================================================
  
     包：
       pkg_qa_it(qa集成测试包)
  
     函数名:
       Asn单造数据--判断 Asnorders 是否存在
  
     入参:
       v_inp_ordid      :  订单Id
       v_inp_compid     :  企业id
       v_inp_gooid      :  商品档案编号
       v_inp_invokeobj  :  调用对象
  
     返回值:
       Number 类型，0-不存在，1-存在
  
     版本:
       2022-10-17_zc314 : Asn单造数据--判断 Asnorders 是否存在
  
  ==============================================================================*/
  FUNCTION f_is_asnordersexists(v_inp_asnid     IN VARCHAR2,
                                v_inp_compid    IN VARCHAR2,
                                v_inp_gooid     IN VARCHAR2,
                                v_inp_invokeobj IN VARCHAR2) RETURN NUMBER IS
    v_jugnum          NUMBER(1);
    v_allowinvokeobj  CLOB := 'scmdata.pkg_qa_it.p_gen_asnordersdatabyasnordersitem;scmdata.pkg_qa_it.p_gen_asnordersdatabyorder';
    v_selfdescription VARCHAR2(1024) := 'scmdata.pkg_qa_it.f_is_asnordersexists';
  BEGIN
    --访问控制
    IF instr(v_allowinvokeobj, v_inp_invokeobj) = 0 THEN
      raise_application_error(-20002,
                              '拒绝访问：调用方-' || v_inp_invokeobj || ' 被调用方-' ||
                              v_selfdescription);
    END IF;
  
    SELECT nvl(MAX(1), 0)
      INTO v_jugnum
      FROM scmdata.t_asnorders
     WHERE asn_id = v_inp_asnid
       AND goo_id = v_inp_gooid
       AND company_id = v_inp_compid;
  
    RETURN v_jugnum;
  END f_is_asnordersexists;

  /*=============================================================================
  
     包：
       pkg_qa_it(qa集成测试包)
  
     函数名:
       Asn单造数据--判断 Asnordersitem 是否存在
  
     入参:
       v_inp_ordid      :  订单Id
       v_inp_compid     :  企业id
       v_inp_gooid      :  商品档案编号
       v_inp_barcode    :  条码
       v_inp_invokeobj  :  调用对象
  
     返回值:
       Number 类型，0-不存在，1-存在
  
     版本:
       2022-10-17_zc314 : Asn单造数据--判断 Asnordersitem 是否存在
  
  ==============================================================================*/
  FUNCTION f_is_asnordersitemexists(v_inp_asnid     IN VARCHAR2,
                                    v_inp_compid    IN VARCHAR2,
                                    v_inp_gooid     IN VARCHAR2,
                                    v_inp_barcode   IN VARCHAR2,
                                    v_inp_invokeobj IN VARCHAR2)
    RETURN NUMBER IS
    v_jugnum          NUMBER(1);
    v_allowinvokeobj  CLOB := 'scmdata.pkg_qa_it.p_gen_asnordersitemdata';
    v_selfdescription VARCHAR2(1024) := 'scmdata.pkg_qa_it.f_is_asnordersitemexists';
  BEGIN
    --访问控制
    IF instr(v_allowinvokeobj, v_inp_invokeobj) = 0 THEN
      raise_application_error(-20002,
                              '拒绝访问：调用方-' || v_inp_invokeobj || ' 被调用方-' ||
                              v_selfdescription);
    END IF;
  
    SELECT nvl(MAX(1), 0)
      INTO v_jugnum
      FROM scmdata.t_asnordersitem
     WHERE asn_id = v_inp_asnid
       AND goo_id = v_inp_gooid
       AND nvl(barcode, ' ') = nvl(v_inp_barcode, ' ')
       AND company_id = v_inp_compid;
  
    RETURN v_jugnum;
  END f_is_asnordersitemexists;

  /*=============================================================================
  
     包：
       pkg_qa_it(qa集成测试包)
  
     过程名:
       Asn单造数据--获取预计到仓时段
  
     入参:
       v_inp_scantime : 到仓扫描时间
       v_inp_invokeobj : 调度对象
  
     版本:
       2022-10-14_zc314 : Asn单造数据--获取预计到仓时段
  
  ==============================================================================*/
  FUNCTION f_get_intervalname(v_inp_scantime  IN DATE,
                              v_inp_invokeobj IN VARCHAR2) RETURN VARCHAR2 IS
    v_hournum         NUMBER(2);
    v_intervalname    VARCHAR2(8);
    v_allowinvokeobj  CLOB := 'scmdata.pkg_qa_it.p_gen_asnordereddata';
    v_selfdescription VARCHAR2(1024) := 'scmdata.pkg_qa_it.f_get_intervalname';
  BEGIN
    --访问控制
    IF instr(v_allowinvokeobj, v_inp_invokeobj) = 0 THEN
      raise_application_error(-20002,
                              '拒绝访问：调用方-' || v_inp_invokeobj || ' 被调用方-' ||
                              v_selfdescription);
    END IF;
  
    IF v_inp_scantime IS NULL THEN
      raise_application_error(-20002, '输入的到仓扫描时间不能为空');
    ELSE
      SELECT to_number(to_char(v_inp_scantime, 'hh24'))
        INTO v_hournum
        FROM dual;
    
      IF v_hournum <= 12 THEN
        v_intervalname := '上午';
      ELSIF v_hournum > 12
            AND v_hournum <= 18 THEN
        v_intervalname := '下午';
      ELSIF v_hournum > 18
            AND v_hournum <= 24 THEN
        v_intervalname := '晚上';
      END IF;
    END IF;
  
    RETURN v_intervalname;
  END f_get_intervalname;

  /*=============================================================================
  
     包：
       pkg_qa_it(qa集成测试包)
  
     函数名:
       Asn单造数据--生成 Asnordered数据
  
     入参:
       v_inp_ordid  : 订单Id
       v_inp_compid : 企业id
  
     版本:
       2022-10-14_zc314 : Asn单造数据--生成 Asnordered数据
  
  ==============================================================================*/
  FUNCTION f_get_asninfobyorder(v_inp_invokeobj IN VARCHAR2) RETURN CLOB IS
    v_sql             CLOB;
    v_allowinvokeobj  CLOB := 'scmdata.pkg_qa_it.p_gen_asnordereddata';
    v_selfdescription VARCHAR2(1024) := 'scmdata.pkg_qa_it.f_get_asninfobyorder';
  BEGIN
    --访问控制
    IF instr(v_allowinvokeobj, v_inp_invokeobj) = 0 THEN
      raise_application_error(-20002,
                              '拒绝访问：调用方-' || v_inp_invokeobj || ' 被调用方-' ||
                              v_selfdescription);
    END IF;
  
    --v_sql 赋值
    v_sql := 'SELECT MAX(ords.delivery_date), MAX(orded.supplier_code)
  FROM scmdata.t_ordered orded
 INNER JOIN scmdata.t_orders ords
    ON orded.order_code = ords.order_id
   AND orded.company_id = ords.company_id
 WHERE orded.order_code = :a
   AND orded.company_id = :b';
  
    RETURN v_sql;
  END f_get_asninfobyorder;

  /*=============================================================================
  
     包：
       pkg_qa_it(qa集成测试包)
  
     函数名:
       Asn单造数据--Asn单号前缀是否合格
  
     入参:
       v_inp_prestr    : Asn单号前缀
       v_inp_invokeobj : 调用对象
  
     版本:
       2022-10-14_zc314 : Asn单造数据--Asn单号前缀是否合格
  
  ==============================================================================*/
  FUNCTION f_is_asnprestrconform(v_inp_prestr    IN VARCHAR2,
                                 v_inp_invokeobj IN VARCHAR2) RETURN NUMBER IS
    v_length          NUMBER(16);
    v_jugnum          NUMBER(1);
    v_allowinvokeobj  CLOB := 'scmdata.pkg_qa_it.p_paramcontrol_genasnid';
    v_selfdescription VARCHAR2(1024) := 'scmdata.pkg_qa_it.f_is_asnprestrconform';
  BEGIN
    --访问控制
    IF instr(v_allowinvokeobj, v_inp_invokeobj) = 0 THEN
      raise_application_error(-20002,
                              '拒绝访问：调用方-' || v_inp_invokeobj || ' 被调用方-' ||
                              v_selfdescription);
    END IF;
  
    --获取传入前缀长度
    v_length := length(v_inp_prestr);
  
    --判断赋值
    IF v_length = 3 THEN
      v_jugnum := 1;
    ELSE
      v_jugnum := 0;
    END IF;
  
    RETURN v_jugnum;
  END f_is_asnprestrconform;

  /*=============================================================================
  
     包：
       pkg_qa_it(qa集成测试包)
  
     过程名:
       Asn单造数据--生成 Asn单号参数控制
  
     入参:
       v_inp_ordid  : 订单Id
       v_inp_compid : 企业id
  
     版本:
       2022-10-14_zc314 : Asn单造数据--生成 Asn单号参数控制
  
  ==============================================================================*/
  PROCEDURE p_paramcontrol_genasnid(v_inp_prestr        IN VARCHAR2,
                                    v_inp_deliverydate  IN DATE,
                                    v_iop_prestr        IN OUT VARCHAR2,
                                    v_iop_delliverydate IN OUT DATE,
                                    v_inp_invokeobj     IN VARCHAR2) IS
    v_jugnum          NUMBER(1);
    v_allowinvokeobj  CLOB := 'scmdata.pkg_qa_it.f_gen_asnid';
    v_selfdescription VARCHAR2(1024) := 'scmdata.pkg_qa_it.p_paramcontrol_genasnid';
  BEGIN
    --访问控制
    IF instr(v_allowinvokeobj, v_inp_invokeobj) = 0 THEN
      raise_application_error(-20002,
                              '拒绝访问：调用方-' || v_inp_invokeobj || ' 被调用方-' ||
                              v_selfdescription);
    END IF;
  
    --前缀校验
    v_jugnum := f_is_asnprestrconform(v_inp_prestr    => v_inp_prestr,
                                      v_inp_invokeobj => v_selfdescription);
  
    --
    IF v_jugnum = 1 THEN
      v_iop_prestr := v_inp_prestr;
    ELSE
      v_iop_prestr := 'GZZ';
    END IF;
  
    IF v_inp_deliverydate IS NULL THEN
      v_iop_delliverydate := SYSDATE;
    ELSE
      v_iop_delliverydate := v_inp_deliverydate;
    END IF;
  END p_paramcontrol_genasnid;

  /*=============================================================================
  
     包：
       pkg_qa_it(qa集成测试包)
  
     函数名:
       Asn单造数据--获取Asn日序号
  
     入参:
       v_inp_deliverydate : 交期
       v_inp_invokeobj    : 调用对象
  
     版本:
       2022-10-15_zc314 : Asn单造数据--获取Asn日序号
  
  ==============================================================================*/
  FUNCTION f_get_asndayseqstr(v_inp_deliverydate IN DATE,
                              v_inp_invokeobj    IN VARCHAR2) RETURN NUMBER IS
    v_retnum          NUMBER(8);
    v_allowinvokeobj  CLOB := 'scmdata.pkg_qa_it.f_gen_asnid';
    v_selfdescription VARCHAR2(1024) := 'scmdata.pkg_qa_it.f_get_asndayseqstr';
  BEGIN
    --访问控制
    IF instr(v_allowinvokeobj, v_inp_invokeobj) = 0 THEN
      raise_application_error(-20002,
                              '拒绝访问：调用方-' || v_inp_invokeobj || ' 被调用方-' ||
                              v_selfdescription);
    END IF;
  
    SELECT nvl(MAX(to_number(substr(asn_id, 11, 5))), 0) + 1
      INTO v_retnum
      FROM scmdata.t_asnordered
     WHERE substr(asn_id, 5, 6) = to_char(v_inp_deliverydate, 'yymmdd');
  
    RETURN v_retnum;
  END f_get_asndayseqstr;

  /*=============================================================================
  
     包：
       pkg_qa_it(qa集成测试包)
  
     函数名:
       Asn单造数据--生成 Asn单号
  
     入参:
       v_inp_ordid  : 订单Id
       v_inp_compid : 企业id
  
     版本:
       2022-10-15_zc315 : Asn单造数据--生成 Asn单号
  
  ==============================================================================*/
  FUNCTION f_gen_asnid(v_inp_prestr       IN VARCHAR2,
                       v_inp_deliverydate IN DATE,
                       v_inp_invokeobj    IN VARCHAR2) RETURN CLOB IS
    v_prestr          VARCHAR2(3);
    v_deliverydate    DATE;
    v_datestr         VARCHAR2(8);
    v_dayseq          NUMBER(8);
    v_seqstr          VARCHAR2(8);
    v_retstr          VARCHAR2(32);
    v_allowinvokeobj  CLOB := 'scmdata.pkg_qa_it.p_gen_asnordereddata';
    v_selfdescription VARCHAR2(1024) := 'scmdata.pkg_qa_it.f_gen_asnid';
  BEGIN
    --访问控制
    IF instr(v_allowinvokeobj, v_inp_invokeobj) = 0 THEN
      raise_application_error(-20002,
                              '拒绝访问：调用方-' || v_inp_invokeobj || ' 被调用方-' ||
                              v_selfdescription);
    END IF;
  
    --参数控制
    p_paramcontrol_genasnid(v_inp_prestr        => v_inp_prestr,
                            v_inp_deliverydate  => v_inp_deliverydate,
                            v_iop_prestr        => v_prestr,
                            v_iop_delliverydate => v_deliverydate,
                            v_inp_invokeobj     => v_selfdescription);
  
    --日字符串赋值
    v_datestr := to_char(v_deliverydate, 'yymmdd');
  
    --日参数序号
    v_dayseq := f_get_asndayseqstr(v_inp_deliverydate => v_deliverydate,
                                   v_inp_invokeobj    => v_selfdescription);
  
    --日参数序号转换为日参数序号字符串
    v_seqstr := lpad(to_char(v_dayseq), 5, '0');
  
    --多值汇总成 Asn_id
    v_retstr := v_prestr || 'X' || v_datestr || v_seqstr;
  
    RETURN v_retstr;
  END f_gen_asnid;

  /*=============================================================================
  
     包：
       pkg_qa_it(qa集成测试包)
  
     过程名:
       Asn单造数据--获取 Orders 数据 Sql
  
     入参:
       v_inp_invokeobj  : 调用对象
  
     版本:
       2022-10-15_zc314 : Asn单造数据--获取 Orders 数据 Sql
  
  ==============================================================================*/
  FUNCTION f_get_ordersinfosql(v_inp_invokeobj IN VARCHAR2) RETURN CLOB IS
    v_sql             CLOB;
    v_allowinvokeobj  CLOB := 'scmdata.pkg_qa_it.p_gen_asnordersdatabyorder';
    v_selfdescription VARCHAR2(1024) := 'scmdata.pkg_qa_it.f_get_ordersinfosql';
  BEGIN
    --访问控制
    IF instr(v_allowinvokeobj, v_inp_invokeobj) = 0 THEN
      raise_application_error(-20002,
                              '拒绝访问：调用方-' || v_inp_invokeobj || ' 被调用方-' ||
                              v_selfdescription);
    END IF;
  
    --构建返回 Sql
    v_sql := 'SELECT MAX(goo_id),
         MAX(order_amount),
         MAX(got_amount),
         MAX(delivery_date),
         MAX(is_qc_required)
    FROM scmdata.t_orders
   WHERE order_id = :a
     AND company_id = :b';
    RETURN v_sql;
  END f_get_ordersinfosql;

  /*=============================================================================
  
     包：
       pkg_qa_it(qa集成测试包)
  
     过程名:
       Asn单造数据--获取 Orders 数据 Sql
  
     入参:
       v_inp_invokeobj  : 调用对象
  
     版本:
       2022-10-15_zc314 : Asn单造数据--获取 Orders 数据 Sql
  
  ==============================================================================*/
  FUNCTION f_get_ordersiteminfosql(v_inp_invokeobj IN VARCHAR2) RETURN CLOB IS
    v_sql             CLOB;
    v_allowinvokeobj  CLOB := 'scmdata.pkg_qa_it.p_gen_asnordersitemdata';
    v_selfdescription VARCHAR2(1024) := 'scmdata.pkg_qa_it.f_get_ordersiteminfosql';
  BEGIN
    --访问控制
    IF instr(v_allowinvokeobj, v_inp_invokeobj) = 0 THEN
      raise_application_error(-20002,
                              '拒绝访问：调用方-' || v_inp_invokeobj || ' 被调用方-' ||
                              v_selfdescription);
    END IF;
  
    --构建 Sql
    v_sql := 'SELECT orditem.goo_id,
       orditem.barcode,
       orditem.order_amount,
       orditem.got_amount,
       ords.delivery_date
  FROM scmdata.t_ordersitem orditem
  LEFT JOIN scmdata.t_orders ords
    ON orditem.order_id = ords.order_id
   AND orditem.company_id = ords.company_id
 WHERE orditem.order_id = :a
   AND orditem.company_id = :b';
  
    RETURN v_sql;
  END f_get_ordersiteminfosql;

  /*=============================================================================
  
     包：
       pkg_qa_it(qa集成测试包)
  
     过程名:
       Asn单造数据--获取 Asnordersitem 数据汇总 Sql
  
     入参:
       v_inp_invokeobj  : 调用对象
  
     版本:
       2022-10-15_zc314 : Asn单造数据--获取 Orders 数据 Sql
  
  ==============================================================================*/
  FUNCTION f_get_asnordersitemdatasuminfo(v_inp_invokeobj IN VARCHAR2)
    RETURN CLOB IS
    v_sql             CLOB;
    v_allowinvokeobj  CLOB := 'scmdata.pkg_qa_it.p_gen_asnordersdatabyasnordersitem';
    v_selfdescription VARCHAR2(1024) := 'scmdata.pkg_qa_it.f_get_asnordersitemdatasuminfo';
  BEGIN
    --访问控制
    IF instr(v_allowinvokeobj, v_inp_invokeobj) = 0 THEN
      raise_application_error(-20002,
                              '拒绝访问：调用方-' || v_inp_invokeobj || ' 被调用方-' ||
                              v_selfdescription);
    END IF;
  
    --构建 Sql
    v_sql := 'SELECT asn_id,company_id,
       MAX(goo_id) goo_id,
       NVL(SUM(order_amount),0) order_amount,
       NVL(SUM(pcome_amount),0) pcome_amount,
       NVL(SUM(asngot_amount),0) asngot_amount,
       NVL(SUM(wmsgot_amount),0) wmsgot_amount,
       NVL(SUM(ret_amount),0) ret_amount,
       MAX(pick_time) pick_time,
       MAX(shipment_time) shipment_time,
       MAX(receive_time) receive_time,
       listagg(DISTINCT warehouse_pos, '';'') warehouse_pos,
       MAX(memo) memo
  FROM scmdata.t_asnordersitem
 WHERE asn_id = :a
   AND company_id = :b
 GROUP BY asn_id,company_id';
  
    RETURN v_sql;
  END f_get_asnordersitemdatasuminfo;

  /*=============================================================================
  
     包：
       pkg_qa_it(qa集成测试包)
  
     函数名:
       Asn单造数据--新增 Asnordered数据
  
     入参:
       v_inp_asnid         :  Asn单号
       v_inp_compid        :  企业Id
       v_inp_status        :  状态
       v_inp_orderid       :  订单号
       v_inp_suppliercode  :  供应商编码
       v_inp_pcomedate     :  预计到仓日期
       v_inp_changetimes   :  变更次数
       v_inp_scantime      :  扫描时间
       v_inp_memo          :  备注
       v_inp_createid      :  创建人
       v_inp_createtime    :  创建时间
       v_inp_pcomeinterval :  预计到仓时段
       v_inp_invokeobj     :  调用对象
  
     版本:
       2022-10-14_zc314 : Asn单造数据--新增 Asnordered数据
  
  ==============================================================================*/
  PROCEDURE p_ins_asnordered(v_inp_asnid         IN VARCHAR2,
                             v_inp_compid        IN VARCHAR2,
                             v_inp_status        IN VARCHAR2,
                             v_inp_orderid       IN VARCHAR2,
                             v_inp_suppliercode  IN VARCHAR2,
                             v_inp_pcomedate     IN DATE,
                             v_inp_changetimes   IN NUMBER,
                             v_inp_scantime      IN DATE,
                             v_inp_memo          IN VARCHAR2,
                             v_inp_createid      IN VARCHAR2,
                             v_inp_createtime    IN VARCHAR2,
                             v_inp_pcomeinterval IN VARCHAR2,
                             v_inp_invokeobj     IN VARCHAR2) IS
    v_sql             CLOB;
    v_errinfo         CLOB;
    v_allowinvokeobj  CLOB := 'scmdata.pkg_qa_it.p_gen_asnordereddata';
    v_selfdescription VARCHAR2(1024) := 'scmdata.pkg_qa_it.p_ins_asnordered';
  BEGIN
    --访问控制
    IF instr(v_allowinvokeobj, v_inp_invokeobj) = 0 THEN
      raise_application_error(-20002,
                              '拒绝访问：调用方-' || v_inp_invokeobj || ' 被调用方-' ||
                              v_selfdescription);
    END IF;
  
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
    (:v_inp_asnid,
     :v_inp_compid,
     :v_inp_dccompid,
     :v_inp_status,
     :v_inp_orderid,
     :v_inp_suppliercode,
     :v_inp_pcomedate,
     :v_inp_changetimes,
     :v_inp_scantime,
     :v_inp_memo,
     :v_inp_createid,
     :v_inp_createtime,
     :v_inp_pcomeinterval)';
  
    EXECUTE IMMEDIATE v_sql
      USING v_inp_asnid, v_inp_compid, v_inp_compid, v_inp_status, v_inp_orderid, v_inp_suppliercode, v_inp_pcomedate, v_inp_changetimes, v_inp_scantime, v_inp_memo, v_inp_createid, v_inp_createtime, v_inp_pcomeinterval;
  
  EXCEPTION
    WHEN OTHERS THEN
      --错误信息赋值
      v_errinfo := 'Format_Error_Backtrace:' ||
                   substr(dbms_utility.format_error_backtrace, 1, 256) ||
                   chr(10) || 'Execute_sql:' || v_sql || chr(10) ||
                   'Params: ' || chr(10) || 'asn_id: ' || v_inp_asnid ||
                   chr(10) || 'company_id: ' || v_inp_compid || chr(10) ||
                   'dc_company_id: ' || v_inp_compid || chr(10) ||
                   'status: ' || v_inp_status || chr(10) || 'order_id: ' ||
                   v_inp_orderid || chr(10) || 'supplier_code: ' ||
                   v_inp_suppliercode || chr(10) || 'pcome_date: ' ||
                   to_char(v_inp_pcomedate, 'yyyy-mm-dd hh24-mi-ss') ||
                   chr(10) || 'changetimes: ' || to_char(v_inp_changetimes) ||
                   chr(10) || 'scan_time: ' || v_inp_scantime || chr(10) ||
                   'memo: ' || v_inp_memo || chr(10) || 'create_id: ' ||
                   v_inp_createid || chr(10) || 'create_time: ' ||
                   to_char(v_inp_createtime, 'yyyy-mm-dd hh24-mi-ss') ||
                   chr(10) || 'pcome_interval: ' || v_inp_pcomeinterval;
    
      --新增进入错误信息表
      scmdata.pkg_qa_ee.p_ins_errrecord_at(v_inp_errprogram     => v_selfdescription,
                                           v_inp_causeerruserid => v_inp_createid,
                                           v_inp_erroccurtime   => SYSDATE,
                                           v_inp_errinfo        => v_errinfo,
                                           v_inp_compid         => v_inp_compid);
  END p_ins_asnordered;

  /*=============================================================================
  
     包：
       pkg_qa_it(qa集成测试包)
  
     过程名:
       Asn单造数据--新增 Asnorders 信息
  
     入参:
       v_inp_ordid  : 订单Id
       v_inp_compid : 企业id
  
     版本:
       2022-10-14_zc314 : Asn单造数据--新增 Asnorders 信息
  
  ==============================================================================*/
  PROCEDURE p_ins_asnorders(v_inp_asnid        IN VARCHAR2,
                            v_inp_compid       IN VARCHAR2,
                            v_inp_gooid        IN VARCHAR2,
                            v_inp_orderamount  IN NUMBER,
                            v_inp_pcomeamount  IN NUMBER,
                            v_inp_asngotamount IN NUMBER,
                            v_inp_wmsgotamount IN NUMBER,
                            v_inp_retamount    IN NUMBER,
                            v_inp_picktime     IN DATE,
                            v_inp_shimenttime  IN DATE,
                            v_inp_receivetime  IN DATE,
                            v_inp_sortingtime  IN DATE,
                            v_inp_warehousepos IN VARCHAR2,
                            v_inp_isflcout     IN NUMBER,
                            v_inp_qcrequired   IN NUMBER,
                            v_inp_memo         IN VARCHAR2,
                            v_inp_createid     IN VARCHAR2,
                            v_inp_createtime   IN DATE,
                            v_inp_invokeobj    IN VARCHAR2) IS
    v_sql             CLOB;
    v_errinfo         CLOB;
    v_allowinvokeobj  CLOB := 'scmdata.pkg_qa_it.p_gen_asninfo;scmdata.pkg_qa_it.p_gen_asnordersdatabyasnordersitem;scmdata.pkg_qa_it.p_gen_asnordersdatabyorder';
    v_selfdescription VARCHAR2(1024) := 'scmdata.pkg_qa_it.p_ins_asnorders';
  BEGIN
    --访问控制
    IF instr(v_allowinvokeobj, v_inp_invokeobj) = 0 THEN
      raise_application_error(-20002,
                              '拒绝访问：调用方-' || v_inp_invokeobj || ' 被调用方-' ||
                              v_selfdescription);
    END IF;
  
    v_sql := 'INSERT INTO scmdata.t_asnorders
    (asn_id,
     company_id,
     dc_company_id,
     goo_id,
     order_amount,
     pcome_amount,
     asngot_amount,
     wmsgot_amount,
     ret_amount,
     pick_time,
     shiment_time,
     receive_time,
     sorting_time,
     warehouse_pos,
     is_fcl_out,
     is_qc_required,
     memo,
     create_id,
     create_time)
  VALUES
    (:v_inp_asnid,
     :v_inp_compid,
     :v_inp_dccompid,
     :v_inp_gooid,
     :v_inp_orderamount,
     :v_inp_pcomeamount,
     :v_inp_asngotamount,
     :v_inp_gotamount,
     :v_inp_retamount,
     :v_inp_picktime,
     :v_inp_shimenttime,
     :v_inp_receivetime,
     :v_inp_sortingtime,
     :v_inp_warehousepos,
     :v_inp_isflcout,
     :v_inp_qcrequired,
     :v_inp_memo,
     :v_inp_createid,
     :v_inp_createtime)';
  
    EXECUTE IMMEDIATE v_sql
      USING v_inp_asnid, v_inp_compid, v_inp_compid, v_inp_gooid, v_inp_orderamount, v_inp_pcomeamount, v_inp_asngotamount, v_inp_wmsgotamount, v_inp_retamount, v_inp_picktime, v_inp_shimenttime, v_inp_receivetime, v_inp_sortingtime, v_inp_warehousepos, v_inp_isflcout, v_inp_qcrequired, v_inp_memo, v_inp_createid, v_inp_createtime;
  
  EXCEPTION
    WHEN OTHERS THEN
      --错误信息赋值
      v_errinfo := 'Format_Error_Backtrace:' ||
                   substr(dbms_utility.format_error_backtrace, 1, 256) ||
                   chr(10) || 'Execute_sql:' || v_sql || chr(10) ||
                   'Params: ' || chr(10) || 'asn_id: ' || v_inp_asnid ||
                   chr(10) || 'company_id: ' || v_inp_compid || chr(10) ||
                   'dc_company_id: ' || v_inp_compid || chr(10) ||
                   'goo_id: ' || v_inp_gooid || chr(10) || 'order_amount: ' ||
                   v_inp_orderamount || chr(10) || 'pcome_amount: ' ||
                   v_inp_pcomeamount || chr(10) || 'asngot_amount: ' ||
                   v_inp_asngotamount || chr(10) || 'wmsgot_amount: ' ||
                   v_inp_wmsgotamount || chr(10) || 'ret_amount: ' ||
                   v_inp_retamount || chr(10) || 'pick_time: ' ||
                   v_inp_picktime || chr(10) || 'shiment_time: ' ||
                   v_inp_shimenttime || chr(10) || 'receive_time: ' ||
                   v_inp_receivetime || chr(10) || 'sorting_time: ' ||
                   v_inp_sortingtime || chr(10) || 'warehouse_pos: ' ||
                   v_inp_warehousepos || chr(10) || 'is_fcl_out: ' ||
                   v_inp_isflcout || chr(10) || 'is_qc_required: ' ||
                   v_inp_qcrequired || chr(10) || 'v_inp_memo: ' ||
                   v_inp_memo || chr(10) || 'create_id: ' || v_inp_createid ||
                   chr(10) || 'create_time: ' || v_inp_createtime;
    
      --新增进入错误信息表
      scmdata.pkg_qa_ee.p_ins_errrecord_at(v_inp_errprogram     => v_selfdescription,
                                           v_inp_causeerruserid => v_inp_createid,
                                           v_inp_erroccurtime   => SYSDATE,
                                           v_inp_errinfo        => v_errinfo,
                                           v_inp_compid         => v_inp_compid);
  END p_ins_asnorders;

  /*=============================================================================
  
     包：
       pkg_qa_it(qa集成测试包)
  
     过程名:
       Asn单造数据--新增 Asnordersitem 信息
  
     入参:
       v_inp_ordid  : 订单Id
       v_inp_compid : 企业id
  
     版本:
       2022-10-14_zc314 : Asn单造数据--新增 Asnordersitem 信息
  
  ==============================================================================*/
  PROCEDURE p_ins_asnordersitem(v_inp_asnid        IN VARCHAR2,
                                v_inp_compid       IN VARCHAR2,
                                v_inp_gooid        IN VARCHAR2,
                                v_inp_barcode      IN VARCHAR2,
                                v_inp_orderamount  IN NUMBER,
                                v_inp_pcomeamount  IN NUMBER,
                                v_inp_asngotamount IN NUMBER,
                                v_inp_wmsgotamount IN NUMBER,
                                v_inp_retamount    IN NUMBER,
                                v_inp_picktime     IN DATE,
                                v_inp_shimenttime  IN DATE,
                                v_inp_receivetime  IN DATE,
                                v_inp_warehousepos IN VARCHAR2,
                                v_inp_memo         IN VARCHAR2,
                                v_inp_createid     IN VARCHAR2,
                                v_inp_createtime   IN DATE,
                                v_inp_invokeobj    IN VARCHAR2) IS
    v_sql             CLOB;
    v_errinfo         CLOB;
    v_allowinvokeobj  CLOB := 'scmdata.pkg_qa_it.p_gen_asnordersitemdata';
    v_selfdescription VARCHAR2(1024) := 'scmdata.pkg_qa_it.p_ins_asnordersitem';
  BEGIN
    --访问控制
    IF instr(v_allowinvokeobj, v_inp_invokeobj) = 0 THEN
      raise_application_error(-20002,
                              '拒绝访问：调用方-' || v_inp_invokeobj || ' 被调用方-' ||
                              v_selfdescription);
    END IF;
  
    v_sql := 'INSERT INTO scmdata.t_asnordersitem
  (asn_id,
   company_id,
   dc_company_id,
   goo_id,
   barcode,
   order_amount,
   pcome_amount,
   asngot_amount,
   wmsgot_amount,
   ret_amount,
   pick_time,
   shipment_time,
   receive_time,
   warehouse_pos,
   memo,
   create_id,
   create_time)
VALUES
  (:v_inp_asnid,
   :v_inp_compid,
   :v_inp_dccompid,
   :v_inp_gooid,
   :v_inp_barcode,
   :v_inp_orderamount,
   :v_inp_pcomeamount,
   :v_inp_asngotamount,
   :v_inp_wmsgotamount,
   :v_inp_retamount,
   :v_inp_picktime,
   :v_inp_shimenttime,
   :v_inp_receivetime,
   :v_inp_warehousepos,
   :v_inp_memo,
   :v_inp_createid,
   :v_inp_createtime)';
  
    EXECUTE IMMEDIATE v_sql
      USING v_inp_asnid, v_inp_compid, v_inp_compid, v_inp_gooid, v_inp_barcode, v_inp_orderamount, v_inp_pcomeamount, v_inp_asngotamount, v_inp_wmsgotamount, v_inp_retamount, v_inp_picktime, v_inp_shimenttime, v_inp_receivetime, v_inp_warehousepos, v_inp_memo, v_inp_createid, v_inp_createtime;
  
  EXCEPTION
    WHEN OTHERS THEN
      --错误信息赋值
      v_errinfo := 'Format_Error_Backtrace:' ||
                   substr(dbms_utility.format_error_backtrace, 1, 256) ||
                   chr(10) || 'Execute_sql:' || v_sql || chr(10) ||
                   'Params: ' || chr(10) || 'asn_id: ' || v_inp_asnid ||
                   chr(10) || 'company_id: ' || v_inp_compid || chr(10) ||
                   'dc_company_id: ' || v_inp_compid || chr(10) ||
                   'goo_id: ' || v_inp_gooid || chr(10) || 'barcode: ' ||
                   v_inp_barcode || chr(10) || 'order_amount: ' ||
                   v_inp_orderamount || chr(10) || 'pcome_amount: ' ||
                   v_inp_pcomeamount || chr(10) || 'asngot_amount: ' ||
                   v_inp_asngotamount || chr(10) || 'wmsgot_amount: ' ||
                   v_inp_wmsgotamount || chr(10) || 'ret_amount: ' ||
                   v_inp_retamount || chr(10) || 'pick_time: ' ||
                   v_inp_picktime || chr(10) || 'shipment_time: ' ||
                   v_inp_shimenttime || chr(10) || 'receive_time: ' ||
                   v_inp_receivetime || chr(10) || 'warehouse_pos: ' ||
                   v_inp_warehousepos || chr(10) || 'memo: ' || v_inp_memo ||
                   chr(10) || 'create_id: ' || v_inp_createid || chr(10) ||
                   'create_time: ' || v_inp_createtime;
    
      --新增进入错误信息表
      scmdata.pkg_qa_ee.p_ins_errrecord_at(v_inp_errprogram     => v_selfdescription,
                                           v_inp_causeerruserid => v_inp_createid,
                                           v_inp_erroccurtime   => SYSDATE,
                                           v_inp_errinfo        => v_errinfo,
                                           v_inp_compid         => v_inp_compid);
  END p_ins_asnordersitem;

  /*=============================================================================
  
     包：
       pkg_qa_it(qa集成测试包)
  
     过程名:
       Asn单造数据--生成 Asnordered数据
  
     入参:
       v_inp_prestr     : 前缀
       v_inp_ordid      : 订单Id
       v_inp_compid     : 企业id
       v_inp_operuserid : 操作人Id
       v_inp_invokeobj  : 调用对象
  
     入出参:
       v_iop_asnid      : Asn单号
  
     版本:
       2022-10-15_zc314 : Asn单造数据--生成 Asnordered数据
  
  ==============================================================================*/
  PROCEDURE p_gen_asnordereddata(v_inp_prestr     IN VARCHAR2,
                                 v_inp_ordid      IN VARCHAR2,
                                 v_inp_compid     IN VARCHAR2,
                                 v_inp_operuserid IN VARCHAR2,
                                 v_inp_invokeobj  IN VARCHAR2,
                                 v_iop_asnid      IN OUT VARCHAR2) IS
    v_pcomedate       DATE;
    v_scantime        DATE;
    v_sql             CLOB;
    v_deliverydate    DATE;
    v_suppliercode    VARCHAR2(32);
    v_pcomeinterval   VARCHAR2(8);
    v_allowinvokeobj  CLOB := 'scmdata.pkg_qa_it.p_gen_asninfo';
    v_selfdescription VARCHAR2(1024) := 'scmdata.pkg_qa_it.p_gen_asnordereddata';
  BEGIN
    --访问控制
    IF instr(v_allowinvokeobj, v_inp_invokeobj) = 0 THEN
      raise_application_error(-20002,
                              '拒绝访问：调用方-' || v_inp_invokeobj || ' 被调用方-' ||
                              v_selfdescription);
    END IF;
  
    --获取订单内所需信息
    v_sql := f_get_asninfobyorder(v_inp_invokeobj => v_selfdescription);
  
    --执行 Sql 赋值
    EXECUTE IMMEDIATE v_sql
      INTO v_deliverydate, v_suppliercode
      USING v_inp_ordid, v_inp_compid;
  
    --获取 Asn_id
    v_iop_asnid := f_gen_asnid(v_inp_prestr       => v_inp_prestr,
                               v_inp_deliverydate => v_deliverydate,
                               v_inp_invokeobj    => v_selfdescription);
  
    --获取
    v_pcomedate     := trunc(v_deliverydate);
    v_scantime      := v_pcomedate + dbms_random.value(1, 10);
    v_pcomeinterval := f_get_intervalname(v_inp_scantime  => v_scantime,
                                          v_inp_invokeobj => v_selfdescription);
  
    IF v_pcomedate IS NOT NULL
       AND v_scantime IS NOT NULL
       AND v_suppliercode IS NOT NULL THEN
      p_ins_asnordered(v_inp_asnid         => v_iop_asnid,
                       v_inp_compid        => v_inp_compid,
                       v_inp_status        => 'PC',
                       v_inp_orderid       => v_inp_ordid,
                       v_inp_suppliercode  => v_suppliercode,
                       v_inp_pcomedate     => v_pcomedate,
                       v_inp_changetimes   => 0,
                       v_inp_scantime      => v_scantime,
                       v_inp_memo          => NULL,
                       v_inp_createid      => v_inp_operuserid,
                       v_inp_createtime    => v_deliverydate - 1,
                       v_inp_pcomeinterval => v_pcomeinterval,
                       v_inp_invokeobj     => v_selfdescription);
    ELSE
      raise_application_error(-20002,
                              '参数缺失导致 Asnordered生成失败' || chr(10) ||
                              'v_pcomedate: ' ||
                              to_char(v_pcomedate, 'yyyy-mm-dd hh24-mi-ss') ||
                              chr(10) || 'v_scantime: ' ||
                              to_char(v_scantime, 'yyyy-mm-dd hh24-mi-ss') ||
                              chr(10) || 'v_suppliercode: ' ||
                              v_suppliercode);
    END IF;
  END p_gen_asnordereddata;

  /*=============================================================================
  
     包：
       pkg_qa_it(qa集成测试包)
  
     过程名:
       Asn单造数据--生成 Asnordered数据
  
     入参:
       v_inp_prestr     : 前缀
       v_inp_ordid      : 订单Id
       v_inp_compid     : 企业id
       v_inp_operuserid : 操作人Id
       v_inp_invokeobj  : 调用对象
  
     版本:
       2022-10-15_zc314 : Asn单造数据--生成 Asnordered数据
  
  ==============================================================================*/
  PROCEDURE p_gen_asnordersdatabyorder(v_inp_asnid      IN VARCHAR2,
                                       v_inp_ordid      IN VARCHAR2,
                                       v_inp_compid     IN VARCHAR2,
                                       v_inp_operuserid IN VARCHAR2,
                                       v_inp_invokeobj  IN VARCHAR2) IS
    v_sql             CLOB;
    v_jugnum          NUMBER(1);
    v_gooid           VARCHAR2(32);
    v_orderamount     NUMBER(8);
    v_gotamount       NUMBER(8);
    v_deliverydate    DATE;
    v_isqcrequired    NUMBER(1);
    v_receivetime     DATE;
    v_sortingtime     DATE;
    v_warehousepos    VARCHAR2(32);
    v_allowinvokeobj  CLOB := 'scmdata.pkg_qa_it.p_gen_asninfo';
    v_selfdescription VARCHAR2(1024) := 'scmdata.pkg_qa_it.p_gen_asnordersdatabyorder';
  BEGIN
    --访问控制
    IF instr(v_allowinvokeobj, v_inp_invokeobj) = 0 THEN
      raise_application_error(-20002,
                              '拒绝访问：调用方-' || v_inp_invokeobj || ' 被调用方-' ||
                              v_selfdescription);
    END IF;
  
    --获得用于获取 Orders内部信息的 Sql
    v_sql := f_get_ordersinfosql(v_inp_invokeobj => v_selfdescription);
  
    --执行 Sql，赋值
    EXECUTE IMMEDIATE v_sql
      INTO v_gooid, v_orderamount, v_gotamount, v_deliverydate, v_isqcrequired
      USING v_inp_ordid, v_inp_compid;
  
    --判断 Asnorders 是否存在
    v_jugnum := f_is_asnordersexists(v_inp_asnid     => v_inp_asnid,
                                     v_inp_compid    => v_inp_compid,
                                     v_inp_gooid     => v_gooid,
                                     v_inp_invokeobj => v_selfdescription);
  
    IF v_orderamount IS NOT NULL
       AND v_gotamount IS NOT NULL
       AND v_deliverydate IS NOT NULL
       AND v_jugnum = 0 THEN
      --上架时间，分拣时间赋值
      v_receivetime  := v_deliverydate + dbms_random.value(1, 2);
      v_sortingtime  := v_receivetime + dbms_random.value(1, 2);
      v_warehousepos := f_get_randomwarehousepos(v_inp_invokeobj => v_selfdescription);
    
      --新增 Asnorders
      scmdata.pkg_qa_it.p_ins_asnorders(v_inp_asnid        => v_inp_asnid,
                                        v_inp_compid       => v_inp_compid,
                                        v_inp_gooid        => v_gooid,
                                        v_inp_orderamount  => v_orderamount,
                                        v_inp_pcomeamount  => v_orderamount,
                                        v_inp_asngotamount => v_gotamount,
                                        v_inp_wmsgotamount => v_gotamount,
                                        v_inp_retamount    => 0,
                                        v_inp_picktime     => NULL,
                                        v_inp_shimenttime  => NULL,
                                        v_inp_receivetime  => v_receivetime,
                                        v_inp_sortingtime  => v_sortingtime,
                                        v_inp_warehousepos => v_warehousepos,
                                        v_inp_isflcout     => 0,
                                        v_inp_qcrequired   => v_isqcrequired,
                                        v_inp_memo         => NULL,
                                        v_inp_createid     => v_inp_operuserid,
                                        v_inp_createtime   => SYSDATE,
                                        v_inp_invokeobj    => v_selfdescription);
    ELSE
      raise_application_error(-20002,
                              '参数缺失导致 Asnorders生成失败' || chr(10) ||
                              'v_pcomedate: ' || to_char(v_orderamount) ||
                              chr(10) || 'v_scantime: ' ||
                              to_char(v_gotamount) || chr(10) ||
                              'v_suppliercode: ' ||
                              to_char(v_deliverydate,
                                      'yyyy-mm-dd hh24-mi-ss'));
    END IF;
  
  END p_gen_asnordersdatabyorder;

  /*=============================================================================
  
     包：
       pkg_qa_it(qa集成测试包)
  
     过程名:
       Asn单造数据--通过 Asnordersitem 生成 Asnorders数据
  
     入参:
       v_inp_prestr     : 前缀
       v_inp_ordid      : 订单Id
       v_inp_compid     : 企业id
       v_inp_operuserid : 操作人Id
       v_inp_invokeobj  : 调用对象
  
     版本:
       2022-10-17_zc314 : Asn单造数据--通过 Asnordersitem 生成 Asnorders数据
  
  ==============================================================================*/
  PROCEDURE p_gen_asnordersdatabyasnordersitem(v_inp_asnid      IN VARCHAR2,
                                               v_inp_compid     IN VARCHAR2,
                                               v_inp_operuserid IN VARCHAR2,
                                               v_inp_invokeobj  IN VARCHAR2) IS
    v_sql             CLOB;
    v_jugnum          NUMBER(1);
    v_asnid           VARCHAR2(32);
    v_compid          VARCHAR2(32);
    v_gooid           VARCHAR2(32);
    v_orderamount     NUMBER(8);
    v_pcomeamount     NUMBER(8);
    v_asngotamount    NUMBER(8);
    v_gotamount       NUMBER(8);
    v_retamount       NUMBER(8);
    v_picktime        DATE;
    v_shimenttime     DATE;
    v_receivetime     DATE;
    v_warehousepos    VARCHAR2(1024);
    v_memo            VARCHAR2(256);
    v_allowinvokeobj  CLOB := 'scmdata.pkg_qa_it.p_gen_asninfo';
    v_selfdescription VARCHAR2(1024) := 'scmdata.pkg_qa_it.p_gen_asnordersdatabyasnordersitem';
  BEGIN
    --访问控制
    IF instr(v_allowinvokeobj, v_inp_invokeobj) = 0 THEN
      raise_application_error(-20002,
                              '拒绝访问：调用方-' || v_inp_invokeobj || ' 被调用方-' ||
                              v_selfdescription);
    END IF;
  
    --获取 Asnordersitem 数据执行 Sql
    v_sql := scmdata.pkg_qa_it.f_get_asnordersitemdatasuminfo(v_inp_invokeobj => v_selfdescription);
  
    --执行 Sql 赋值
    EXECUTE IMMEDIATE v_sql
      INTO v_asnid, v_compid, v_gooid, v_orderamount, v_pcomeamount, v_asngotamount, v_gotamount, v_retamount, v_picktime, v_shimenttime, v_receivetime, v_warehousepos, v_memo
      USING v_inp_asnid, v_inp_compid;
  
    --判断 Asnorders 是否存在
    v_jugnum := f_is_asnordersexists(v_inp_asnid     => v_asnid,
                                     v_inp_compid    => v_compid,
                                     v_inp_gooid     => v_gooid,
                                     v_inp_invokeobj => v_selfdescription);
  
    --参数非空控制
    IF v_asnid IS NOT NULL
       AND v_compid IS NOT NULL
       AND v_gooid IS NOT NULL
       AND v_jugnum = 0 THEN
      --新增进入 Asnorders
      scmdata.pkg_qa_it.p_ins_asnorders(v_inp_asnid        => v_asnid,
                                        v_inp_compid       => v_compid,
                                        v_inp_gooid        => v_gooid,
                                        v_inp_orderamount  => v_orderamount,
                                        v_inp_pcomeamount  => v_pcomeamount,
                                        v_inp_asngotamount => v_asngotamount,
                                        v_inp_wmsgotamount => v_gotamount,
                                        v_inp_retamount    => v_retamount,
                                        v_inp_picktime     => v_picktime,
                                        v_inp_shimenttime  => v_shimenttime,
                                        v_inp_receivetime  => v_receivetime,
                                        v_inp_sortingtime  => v_receivetime +
                                                              dbms_random.value(1,
                                                                                2),
                                        v_inp_warehousepos => v_warehousepos,
                                        v_inp_isflcout     => 0,
                                        v_inp_qcrequired   => 1,
                                        v_inp_memo         => v_memo,
                                        v_inp_createid     => v_inp_operuserid,
                                        v_inp_createtime   => SYSDATE,
                                        v_inp_invokeobj    => v_selfdescription);
    ELSE
      raise_application_error(-20002,
                              '参数缺失导致 Asnorders生成失败' || chr(10) ||
                              'v_asnid: ' || v_asnid || chr(10) ||
                              'v_compid: ' || v_compid || chr(10) ||
                              'v_gooid: ' || v_gooid);
    END IF;
  END p_gen_asnordersdatabyasnordersitem;

  /*=============================================================================
  
     包：
       pkg_qa_it(qa集成测试包)
  
     过程名:
       Asn单造数据--生成 Asnordersitem数据
  
     入参:
       v_inp_prestr     : 前缀
       v_inp_ordid      : 订单Id
       v_inp_compid     : 企业id
       v_inp_operuserid : 操作人Id
       v_inp_invokeobj  : 调用对象
  
     版本:
       2022-10-15_zc314 : Asn单造数据--生成 Asnordersitem数据
  
  ==============================================================================*/
  PROCEDURE p_gen_asnordersitemdata(v_inp_asnid      IN VARCHAR2,
                                    v_inp_ordid      IN VARCHAR2,
                                    v_inp_compid     IN VARCHAR2,
                                    v_inp_operuserid IN VARCHAR2,
                                    v_inp_invokeobj  IN VARCHAR2) IS
    TYPE refcursor IS REF CURSOR;
    asnitemcursor     refcursor;
    v_jugnum          NUMBER(1);
    v_sql             CLOB;
    v_gooid           VARCHAR2(32);
    v_barcode         VARCHAR2(32);
    v_orderamount     NUMBER(8);
    v_wmsgotamount    NUMBER(8);
    v_deliverydate    DATE;
    v_warehousepos    VARCHAR2(16);
    v_allowinvokeobj  CLOB := 'scmdata.pkg_qa_it.p_gen_asninfo';
    v_selfdescription VARCHAR2(1024) := 'scmdata.pkg_qa_it.p_gen_asnordersitemdata';
  BEGIN
    --访问控制
    IF instr(v_allowinvokeobj, v_inp_invokeobj) = 0 THEN
      raise_application_error(-20002,
                              '拒绝访问：调用方-' || v_inp_invokeobj || ' 被调用方-' ||
                              v_selfdescription);
    END IF;
  
    --数据获取 Sql
    v_sql := scmdata.pkg_qa_it.f_get_ordersiteminfosql(v_inp_invokeobj => v_selfdescription);
  
    --开启动态游标
    OPEN asnitemcursor FOR v_sql
      USING v_inp_ordid, v_inp_compid;
    LOOP
      --动态游标赋值
      FETCH asnitemcursor
        INTO v_gooid,
             v_barcode,
             v_orderamount,
             v_wmsgotamount,
             v_deliverydate;
      --动态游标无值退出
      EXIT WHEN asnitemcursor%NOTFOUND;
    
      --防止动态游标赋值第一次为空进入逻辑
      IF v_barcode IS NOT NULL THEN
        --获取随机库位
        v_warehousepos := scmdata.pkg_qa_it.f_get_randomwarehousepos(v_inp_invokeobj => v_selfdescription);
      
        --判断是否存在
        v_jugnum := f_is_asnordersitemexists(v_inp_asnid     => v_inp_asnid,
                                             v_inp_compid    => v_inp_compid,
                                             v_inp_gooid     => v_gooid,
                                             v_inp_barcode   => v_barcode,
                                             v_inp_invokeobj => v_selfdescription);
      
        IF v_jugnum = 0 THEN
          --Asnordersitem 新增
          scmdata.pkg_qa_it.p_ins_asnordersitem(v_inp_asnid        => v_inp_asnid,
                                                v_inp_compid       => v_inp_compid,
                                                v_inp_gooid        => v_gooid,
                                                v_inp_barcode      => v_barcode,
                                                v_inp_orderamount  => v_orderamount,
                                                v_inp_pcomeamount  => v_orderamount,
                                                v_inp_asngotamount => v_wmsgotamount,
                                                v_inp_wmsgotamount => v_wmsgotamount,
                                                v_inp_retamount    => 0,
                                                v_inp_picktime     => NULL,
                                                v_inp_shimenttime  => NULL,
                                                v_inp_receivetime  => v_deliverydate +
                                                                      dbms_random.value(1,
                                                                                        10),
                                                v_inp_warehousepos => v_warehousepos,
                                                v_inp_memo         => NULL,
                                                v_inp_createid     => v_inp_operuserid,
                                                v_inp_createtime   => SYSDATE,
                                                v_inp_invokeobj    => v_selfdescription);
        END IF;
      END IF;
    END LOOP;
    --关闭动态游标
    CLOSE asnitemcursor;
  
  END p_gen_asnordersitemdata;

  /*=============================================================================
  
     包：
       pkg_qa_it(qa集成测试包)
  
     过程名:
       Asn单造数据--新增 Asn 信息
  
     入参:
       v_inp_prestr      : Asn单前缀
       v_inp_ordid       : 订单Id
       v_inp_operuserid  :  当前操作人Id
       v_inp_compid      : 企业id
  
     版本:
       2022-10-17_zc314 : Asn单造数据--判断输入订单号是否存在
  
  ==============================================================================*/
  PROCEDURE p_gen_asninfo(v_inp_prestr     IN VARCHAR2,
                          v_inp_ordid      IN VARCHAR2,
                          v_inp_operuserid IN VARCHAR2,
                          v_inp_compid     IN VARCHAR2) IS
    v_ordedjugnum     NUMBER(1);
    v_ordsjugnum      NUMBER(1);
    v_ordsitemjugnum  NUMBER(1);
    v_asnid           VARCHAR2(32);
    v_selfdescription VARCHAR2(1024) := 'scmdata.pkg_qa_it.p_gen_asninfo';
  BEGIN
    --订单号是否存在判断
    v_ordedjugnum := f_is_orderexists(v_inp_ordid     => v_inp_ordid,
                                      v_inp_compid    => v_inp_compid,
                                      v_inp_invokeobj => v_selfdescription);
  
    --不存在订单号
    IF v_ordedjugnum = 0 THEN
      --报错
      raise_application_error(-20002,
                              '系统中无此订单号，无法新增对应Asn单！');
    ELSE
      --Orders 是否存在数据判断
      v_ordsjugnum := f_is_ordersexists(v_inp_ordid     => v_inp_ordid,
                                        v_inp_compid    => v_inp_compid,
                                        v_inp_invokeobj => v_selfdescription);
    
      --Ordersitem 是否存在数据判断
      v_ordsitemjugnum := f_is_ordersitemexists(v_inp_ordid     => v_inp_ordid,
                                                v_inp_compid    => v_inp_compid,
                                                v_inp_invokeobj => v_selfdescription);
    
      --如果仅存在 Orders 不存在 Ordersitem
      IF v_ordsjugnum = 1
         AND v_ordsitemjugnum = 0 THEN
        --仅生成 Asnordered, Asnorders 数据
        p_gen_asnordereddata(v_inp_prestr     => v_inp_prestr,
                             v_inp_ordid      => v_inp_ordid,
                             v_inp_compid     => v_inp_compid,
                             v_inp_operuserid => v_inp_operuserid,
                             v_inp_invokeobj  => v_selfdescription,
                             v_iop_asnid      => v_asnid);
      
        p_gen_asnordersdatabyorder(v_inp_asnid      => v_asnid,
                                   v_inp_ordid      => v_inp_ordid,
                                   v_inp_compid     => v_inp_compid,
                                   v_inp_operuserid => v_inp_operuserid,
                                   v_inp_invokeobj  => v_selfdescription);
      
        --如果存在 Orders 和 Ordersitem
      ELSIF v_ordsjugnum = 1
            AND v_ordsitemjugnum = 1 THEN
        --Todo: 生成 Asnordered, Asnorders, Asnordersitem 数据
        p_gen_asnordereddata(v_inp_prestr     => v_inp_prestr,
                             v_inp_ordid      => v_inp_ordid,
                             v_inp_compid     => v_inp_compid,
                             v_inp_operuserid => v_inp_operuserid,
                             v_inp_invokeobj  => v_selfdescription,
                             v_iop_asnid      => v_asnid);
      
        p_gen_asnordersitemdata(v_inp_asnid      => v_asnid,
                                v_inp_ordid      => v_inp_ordid,
                                v_inp_compid     => v_inp_compid,
                                v_inp_operuserid => v_inp_operuserid,
                                v_inp_invokeobj  => v_selfdescription);
      
        p_gen_asnordersdatabyasnordersitem(v_inp_asnid      => v_asnid,
                                           v_inp_compid     => v_inp_compid,
                                           v_inp_operuserid => v_inp_operuserid,
                                           v_inp_invokeobj  => v_selfdescription);
      
        --Orders 和 Ordersitem 都不存在
      ELSE
        raise_application_error(-20002,
                                '此订单号：' || v_inp_ordid ||
                                '没有Orders 和 Ordersitem 数据，是错误数据');
      END IF;
    END IF;
  END p_gen_asninfo;

  /*=============================================================================
  
     包：
       pkg_qa_it(qa集成测试包)
  
     过程名:
       集成测试--Asn免检
  
     入参:
       v_inp_aereasondicname   :  Asn免检原因字典名称
       v_inp_companyname       :  企业名称
       v_inp_asnstatusdicname  :  Asn状态字典名称
       v_inp_curuserid         :  当前操作人Id
       v_inp_getasnnumber      :  获取Asn数量
  
     版本:
       2022-10-18_zc314 : 集成测试--Asn免检
       2022-10-20_zc314 : 单元测试增加入参以适应更多测试情况
  
  ==============================================================================*/
  PROCEDURE p_it_asnae(v_inp_aereasondicname  IN VARCHAR2,
                       v_inp_companyname      IN VARCHAR2,
                       v_inp_asnstatusdicname IN VARCHAR2,
                       v_inp_curuserid        IN VARCHAR2,
                       v_inp_getasnnumber     IN NUMBER) IS
    v_aereason  VARCHAR2(8);
    v_compid    VARCHAR2(32);
    v_asnstatus VARCHAR2(8);
    v_asnids    CLOB;
  BEGIN
    --创建保存点
    SAVEPOINT aetest;
  
    --获取asn状态
    v_asnstatus := scmdata.pkg_mock.f_get_mockgroupdicval(v_inp_groupdictname => v_inp_asnstatusdicname);
  
    --ae_reason, company_id, asnids 赋值
    v_aereason := scmdata.pkg_mock.f_get_mockgroupdicval(v_inp_groupdictname => v_inp_aereasondicname);
    v_compid   := scmdata.pkg_mock.f_get_companyid(v_inp_compname => v_inp_companyname);
    v_asnids   := scmdata.pkg_mock.f_get_asnidsbystatus(v_inp_asnstatus => v_asnstatus,
                                                        v_inp_asnnumber => v_inp_getasnnumber,
                                                        v_inp_compid    => v_compid);
  
    --循环进入
    FOR i IN (SELECT asn_id, company_id
                FROM scmdata.t_asnordered
               WHERE instr(v_asnids, asn_id) > 0
                 AND company_id = v_compid) LOOP
      --免检流程
      scmdata.pkg_qa_lc.p_asnexemption(v_inp_asnid       => i.asn_id,
                                       v_inp_compid      => i.company_id,
                                       v_inp_aeresoncode => v_aereason,
                                       v_inp_curuserid   => v_inp_curuserid);
    END LOOP;
  
    --打印相关 scmdata.t_asnordered 数据
    scmdata.pkg_mock.p_get_sperateline(v_inp_sperateinfo => 'scmdata.t_asnordered');
    scmdata.pkg_mock.p_get_printdata(v_inp_owner => 'scmdata',
                                     v_inp_table => 't_asnordered',
                                     v_inp_cond  => 'instr(''' || v_asnids ||
                                                    ''',asn_id)>0');
  
    --打印 scmdata.t_qaqualedlist_mas 数据
    scmdata.pkg_mock.p_get_sperateline(v_inp_sperateinfo => 'scmdata.t_qaqualedlist_mas');
    scmdata.pkg_mock.p_get_printdata(v_inp_owner => 'scmdata',
                                     v_inp_table => 't_qaqualedlist_mas',
                                     v_inp_cond  => 'instr(''' || v_asnids ||
                                                    ''',asn_id)>0');
  
    --打印 scmdata.t_qaqualedlist_sla 数据
    scmdata.pkg_mock.p_get_sperateline(v_inp_sperateinfo => 'scmdata.t_qaqualedlist_sla');
    scmdata.pkg_mock.p_get_printdata(v_inp_owner => 'scmdata',
                                     v_inp_table => 't_qaqualedlist_sla',
                                     v_inp_cond  => 'instr(''' || v_asnids ||
                                                    ''',asn_id)>0');
  
    --打印 scmdata.t_asninfo_pretrans_to_wms 数据
    scmdata.pkg_mock.p_get_sperateline(v_inp_sperateinfo => 'scmdata.t_asninfo_pretrans_to_wms');
    scmdata.pkg_mock.p_get_printdata(v_inp_owner => 'scmdata',
                                     v_inp_table => 't_asninfo_pretrans_to_wms',
                                     v_inp_cond  => 'instr(''' || v_asnids ||
                                                    ''',asn_id)>0');
  
    --回滚到保存点
    ROLLBACK TO aetest;
  END p_it_asnae;

  /*=============================================================================
  
     包：
       pkg_qa_it(qa集成测试包)
  
     过程名:
       集成测试--生成质检报告
  
     入参:
       v_inp_mocknumstrategy  :  模拟数字策略
       v_inp_companyname      :  企业名称
       v_inp_getasnnumber     :  获取Asn数量
       v_inp_asnstatus        :  获取asn状态
  
     版本:
       2022-10-18_zc314 : 集成测试--生成质检报告
       2022-10-20_zc314 : 生成质检报告增加入参以适应更多测试场景
  
  ==============================================================================*/
  PROCEDURE p_it_genqareport(v_inp_mocknumstrategy IN VARCHAR2,
                             v_inp_companyname     IN VARCHAR2,
                             v_inp_getasnnumber    IN NUMBER,
                             v_inp_asnstatus       IN VARCHAR2) IS
    v_ispriority  NUMBER(1);
    v_asnids      CLOB;
    v_compid      VARCHAR2(32);
    v_curuserid   VARCHAR2(32);
    v_qareportids VARCHAR2(256);
  BEGIN
    --创建保存点
    SAVEPOINT genqareport;
  
    --删除错误记录表数据
    DELETE FROM scmdata.t_errrecord WHERE 1 = 1;
  
    --数据模拟
    v_ispriority := scmdata.pkg_mock.f_get_mocknumber(v_inp_length      => 1,
                                                      v_inp_numstrategy => v_inp_mocknumstrategy);
    v_compid     := scmdata.pkg_mock.f_get_companyid(v_inp_compname => v_inp_companyname);
    v_curuserid  := scmdata.pkg_mock.f_get_mockcompanyuserid(v_inp_compid => v_compid);
    v_asnids     := scmdata.pkg_mock.f_get_asnidsbystatus(v_inp_asnstatus => v_inp_asnstatus,
                                                          v_inp_asnnumber => v_inp_getasnnumber,
                                                          v_inp_compid    => v_compid);
  
    --参数控制
    IF v_asnids IS NULL THEN
      raise_application_error(-20002, '没有选中待质检状态AsnId！');
    
    ELSE
      --新增 Qa质检报告
      scmdata.pkg_qa_lc.p_ins_qareportinfo(v_inp_asnids     => v_asnids,
                                           v_inp_compid     => v_compid,
                                           v_inp_ispriority => v_ispriority,
                                           v_inp_curuserid  => v_curuserid);
    
    END IF;
  
    --获取qa_report_ids
    SELECT listagg(qa_report_id, ';')
      INTO v_qareportids
      FROM scmdata.t_qa_report_relainfodim
     WHERE instr(v_asnids, asn_id) > 0
       AND company_id = v_compid;
  
    --打印 Qa 质检报告主表
    scmdata.pkg_mock.p_get_sperateline(v_inp_sperateinfo => 'scmdata.t_qa_report');
    scmdata.pkg_mock.p_get_printdata(v_inp_owner => 'scmdata',
                                     v_inp_table => 't_qa_report',
                                     v_inp_cond  => 'instr(''' ||
                                                    v_qareportids ||
                                                    ''',qa_report_id)>0');
  
    --打印 Qa 质检报告质检细节维度表
    scmdata.pkg_mock.p_get_sperateline(v_inp_sperateinfo => 'scmdata.t_qa_report_checkdetaildim');
    scmdata.pkg_mock.p_get_printdata(v_inp_owner => 'scmdata',
                                     v_inp_table => 't_qa_report_checkdetaildim',
                                     v_inp_cond  => 'instr(''' ||
                                                    v_qareportids ||
                                                    ''',qa_report_id)>0');
  
    --打印 Qa 质检报告数字维度表
    scmdata.pkg_mock.p_get_sperateline(v_inp_sperateinfo => 'scmdata.t_qa_report_numdim');
    scmdata.pkg_mock.p_get_printdata(v_inp_owner => 'scmdata',
                                     v_inp_table => 't_qa_report_numdim',
                                     v_inp_cond  => 'instr(''' ||
                                                    v_qareportids ||
                                                    ''',qa_report_id)>0');
  
    --打印 Qa 质检报告关联信息维度表
    scmdata.pkg_mock.p_get_sperateline(v_inp_sperateinfo => 'scmdata.t_qa_report_relainfodim');
    scmdata.pkg_mock.p_get_printdata(v_inp_owner => 'scmdata',
                                     v_inp_table => 't_qa_report_relainfodim',
                                     v_inp_cond  => 'instr(''' ||
                                                    v_qareportids ||
                                                    ''',qa_report_id)>0');
  
    --打印 Qa 质检报告Sku维度表
    scmdata.pkg_mock.p_get_sperateline(v_inp_sperateinfo => 'scmdata.t_qa_report_skudim');
    scmdata.pkg_mock.p_get_printdata(v_inp_owner => 'scmdata',
                                     v_inp_table => 't_qa_report_skudim',
                                     v_inp_cond  => 'instr(''' ||
                                                    v_qareportids ||
                                                    ''',qa_report_id)>0');
  
    --打印错误记录表数据
    scmdata.pkg_mock.p_get_sperateline(v_inp_sperateinfo => 'scmdata.t_errrecord');
    scmdata.pkg_mock.p_get_printdata(v_inp_owner => 'scmdata',
                                     v_inp_table => 't_errrecord',
                                     v_inp_cond  => '1=1');
  
    --回滚到保存点
    ROLLBACK TO genqareport;
  END p_it_genqareport;

  /*=============================================================================
  
     包：
       pkg_qa_it(qa集成测试包)
  
     过程名:
       集成测试--生成质检报告
  
     入参:
       v_inp_compname                :  企业名称
       v_inp_checkresultdicname      :  质检结果字典名称
       v_firstsampingamountstrategy  :  首抽件数生成策略
       v_checkdatestrategy           :  质检日期生成策略
  
     版本:
       2022-10-20_zc314 : 集成测试--生成质检报告
  
  ==============================================================================*/
  PROCEDURE p_it_batchrecordpassqarep(v_inp_compname               IN VARCHAR2,
                                      v_inp_checkresultdicname     IN VARCHAR2,
                                      v_firstsampingamountstrategy IN VARCHAR2,
                                      v_checkdatestrategy          IN VARCHAR2) IS
    v_qarepids         CLOB;
    v_checkresult      VARCHAR2(4);
    v_firstcheckamount NUMBER(8);
    v_checkdate        DATE;
    v_checkers         VARCHAR2(1024);
    v_compid           VARCHAR2(32);
    v_curuserid        VARCHAR2(32);
  BEGIN
    --创建保存点
    SAVEPOINT batchpassreport;
  
    --变量模拟赋值
    v_compid           := scmdata.pkg_mock.f_get_companyid(v_inp_compname => v_inp_compname);
    v_checkers         := scmdata.pkg_mock.f_get_mockcompanyuserid(v_inp_compid => v_compid);
    v_checkresult      := scmdata.pkg_mock.f_get_mockgroupdicval(v_inp_groupdictname => v_inp_checkresultdicname);
    v_firstcheckamount := scmdata.pkg_mock.f_get_mocknumber(v_inp_numstrategy => v_checkdatestrategy);
    v_checkdate        := scmdata.pkg_mock.f_get_mockdate(v_inp_datestrategy => v_firstsampingamountstrategy);
    v_curuserid        := scmdata.pkg_mock.f_get_mockcompanyuserid(v_inp_compid => v_compid);
  
    --合并3个质检报告Id
    FOR i IN (SELECT qa_report_id
                FROM scmdata.t_qa_report
               WHERE status = 'PC'
                 AND company_id = v_compid) LOOP
      v_qarepids := scmdata.f_sentence_append_rc(v_sentence   => v_qarepids,
                                                 v_appendstr  => i.qa_report_id,
                                                 v_middliestr => ';');
    END LOOP;
  
    --质检报告批量通过
    scmdata.pkg_qa_lc.p_batch_passqarep(v_inp_qarepids         => v_qarepids,
                                        v_inp_checkresult      => v_checkresult,
                                        v_inp_firstcheckamount => v_firstcheckamount,
                                        v_inp_checkdate        => v_checkdate,
                                        v_inp_checkuserids     => v_checkers,
                                        v_inp_curuserid        => v_curuserid,
                                        v_inp_compid           => v_compid);
  
    --打印数据
    scmdata.pkg_mock.p_get_sperateline(v_inp_sperateinfo => 'scmdata.t_qa_report');
    scmdata.pkg_mock.p_get_printdata(v_inp_owner => 'scmdata',
                                     v_inp_table => 't_qa_report',
                                     v_inp_cond  => 'instr(''' || v_qarepids ||
                                                    ''',qa_report_id)>0');
  
    scmdata.pkg_mock.p_get_sperateline(v_inp_sperateinfo => 'scmdata.t_qa_report_checkdetaildim');
    scmdata.pkg_mock.p_get_printdata(v_inp_owner => 'scmdata',
                                     v_inp_table => 't_qa_report_checkdetaildim',
                                     v_inp_cond  => 'instr(''' || v_qarepids ||
                                                    ''',qa_report_id)>0');
  
    scmdata.pkg_mock.p_get_sperateline(v_inp_sperateinfo => 'scmdata.t_qa_report_numdim');
    scmdata.pkg_mock.p_get_printdata(v_inp_owner => 'scmdata',
                                     v_inp_table => 't_qa_report_numdim',
                                     v_inp_cond  => 'instr(''' || v_qarepids ||
                                                    ''',qa_report_id)>0');
  
    scmdata.pkg_mock.p_get_sperateline(v_inp_sperateinfo => 'scmdata.t_qa_report_relainfodim');
    scmdata.pkg_mock.p_get_printdata(v_inp_owner => 'scmdata',
                                     v_inp_table => 't_qa_report_relainfodim',
                                     v_inp_cond  => 'instr(''' || v_qarepids ||
                                                    ''',qa_report_id)>0');
  
    scmdata.pkg_mock.p_get_sperateline(v_inp_sperateinfo => 'scmdata.t_qa_report_skudim');
    scmdata.pkg_mock.p_get_printdata(v_inp_owner => 'scmdata',
                                     v_inp_table => 't_qa_report_skudim',
                                     v_inp_cond  => 'instr(''' || v_qarepids ||
                                                    ''',qa_report_id)>0');
  
    --回滚至保存点
    ROLLBACK TO batchpassreport;
  END p_it_batchrecordpassqarep;

  /*=============================================================================
  
     包：
       pkg_qa_it(qa集成测试包)
  
     过程名:
       集成测试--修改质检报告
  
     入参:
       v_inp_compname              :  企业名称
       v_inp_checkresultdicname    :  质检结果字典名称
       v_inp_checkdatestrategy     :  质检日期生成策略
       v_inp_problemclassdicname   :  问题分类字典编码
       v_inp_longtextstrategy      :  长文本生成策略
  
     版本:
       2022-10-24_zc314 : 集成测试--修改质检报告
  
  ==============================================================================*/
  PROCEDURE p_it_qarepinfochange(v_inp_compname            IN VARCHAR2,
                                 v_inp_checkresultdicname  IN VARCHAR2,
                                 v_inp_checkdatestrategy   IN VARCHAR2,
                                 v_inp_problemclassdicname IN VARCHAR2,
                                 v_inp_longtextstrategy    IN VARCHAR2) IS
    v_qarepid               VARCHAR2(32);
    v_compid                VARCHAR2(32);
    v_checkers              VARCHAR2(512);
    v_checkresult           VARCHAR2(8);
    v_checkdate             DATE;
    v_problemclassification VARCHAR2(8);
    v_problemdescription    VARCHAR2(512);
    v_reviewcomments        VARCHAR2(512);
    v_memo                  VARCHAR2(512);
    v_qualattachment        VARCHAR2(32);
    v_reviewattachment      VARCHAR2(32);
    v_firstsamplingamount   NUMBER(8);
    v_addsamplingamount     NUMBER(8);
    v_unqualsamplingamount  NUMBER(8);
    v_yyresult              VARCHAR2(8);
    v_yyuqualsubjects       VARCHAR2(8);
    v_mflresult             VARCHAR2(8);
    v_mfluqualsubjects      VARCHAR2(8);
    v_gyresult              VARCHAR2(8);
    v_gyuqualsubjects       VARCHAR2(8);
    v_bxresult              VARCHAR2(8);
    v_bxuqualsubjects       VARCHAR2(8);
    v_curuserid             VARCHAR2(32);
  BEGIN
    --创建保存点
    SAVEPOINT qarepinfochange;
  
    --模拟数据
    v_compid := scmdata.pkg_mock.f_get_companyid(v_inp_compname => v_inp_compname);
  
    v_qarepid := scmdata.pkg_qa_it.f_get_randomqarepid(v_inp_qarepstatus => 'PC',
                                                       v_inp_compid      => v_compid);
  
    v_checkers := scmdata.pkg_mock.f_get_mockcompanyuserid(v_inp_compid => v_compid);
  
    v_checkresult := scmdata.pkg_mock.f_get_mockgroupdicval(v_inp_groupdictname => v_inp_checkresultdicname);
  
    v_checkdate := scmdata.pkg_mock.f_get_mockdate(v_inp_min          => 1,
                                                   v_inp_max          => 5,
                                                   v_inp_datestrategy => v_inp_checkdatestrategy);
  
    v_problemclassification := scmdata.pkg_mock.f_get_mockgroupdicval(v_inp_groupdictname => v_inp_problemclassdicname);
  
    v_problemdescription := scmdata.pkg_mock.f_get_mockstring(v_inp_length      => 20,
                                                              v_inp_varstrategy => v_inp_longtextstrategy);
  
    v_reviewcomments := scmdata.pkg_mock.f_get_mockstring(v_inp_length      => 20,
                                                          v_inp_varstrategy => v_inp_longtextstrategy);
  
    v_memo := scmdata.pkg_mock.f_get_mockstring(v_inp_length      => 20,
                                                v_inp_varstrategy => v_inp_longtextstrategy);
  
    v_yyresult := scmdata.pkg_mock.f_get_mockrandomvalinfields(v_inp_fields    => ',UQ,QU,NO,,',
                                                               v_inp_seperator => ',');
  
    v_yyuqualsubjects := scmdata.pkg_mock.f_get_mockrandomvalinfields(v_inp_fields    => ',YYUQSJ01,YYUQSJ02,,',
                                                                      v_inp_seperator => ',');
  
    v_mflresult := scmdata.pkg_mock.f_get_mockrandomvalinfields(v_inp_fields    => ',UQ,QU,NO,,',
                                                                v_inp_seperator => ',');
  
    v_mfluqualsubjects := scmdata.pkg_mock.f_get_mockrandomvalinfields(v_inp_fields    => ',MFLUQSJ01,MFLUQSJ02,MFLUQSJ03,MFLUQSJ04,,',
                                                                       v_inp_seperator => ',');
  
    v_gyresult := scmdata.pkg_mock.f_get_mockrandomvalinfields(v_inp_fields    => ',UQ,QU,NO,,',
                                                               v_inp_seperator => ',');
  
    v_gyuqualsubjects := scmdata.pkg_mock.f_get_mockrandomvalinfields(v_inp_fields    => ',GYUQSJ01,GYUQSJ02,GYUQSJ03,GYUQSJ04,GYUQSJ05,,',
                                                                      v_inp_seperator => ',');
  
    v_bxresult := scmdata.pkg_mock.f_get_mockrandomvalinfields(v_inp_fields    => ',UQ,QU,NO,,',
                                                               v_inp_seperator => ',');
  
    v_bxuqualsubjects := scmdata.pkg_mock.f_get_mockrandomvalinfields(v_inp_fields    => ',BXUQSJ01,BXUQSJ02,',
                                                                      v_inp_seperator => ',');
  
    v_curuserid := scmdata.pkg_mock.f_get_mockcompanyuserid(v_inp_compid => v_compid);
  
    --核心逻辑
    scmdata.pkg_qa_lc.p_upd_qareport(v_inp_qarepid               => v_qarepid,
                                     v_inp_compid                => v_compid,
                                     v_inp_checkers              => v_checkers,
                                     v_inp_checkdate             => v_checkdate,
                                     v_inp_checkresult           => v_checkresult,
                                     v_inp_problemclassification => v_problemclassification,
                                     v_inp_problemdescription    => v_problemdescription,
                                     v_inp_reviewcomments        => v_reviewcomments,
                                     v_inp_memo                  => v_memo,
                                     v_inp_qualattachment        => v_qualattachment,
                                     v_inp_reviewattachment      => v_reviewattachment,
                                     v_inp_firstsamplingamount   => v_firstsamplingamount,
                                     v_inp_addsamplingamount     => v_addsamplingamount,
                                     v_inp_unqualsamplingamount  => v_unqualsamplingamount,
                                     v_inp_yyresult              => v_yyresult,
                                     v_inp_yyuqualsubjects       => v_yyuqualsubjects,
                                     v_inp_mflresult             => v_mflresult,
                                     v_inp_mfluqualsubjects      => v_mfluqualsubjects,
                                     v_inp_gyresult              => v_gyresult,
                                     v_inp_gyuqualsubjects       => v_gyuqualsubjects,
                                     v_inp_bxresult              => v_bxresult,
                                     v_inp_bxuqualsubjects       => v_bxuqualsubjects,
                                     v_inp_scaleamount           => NULL,
                                     v_inp_curuserid             => v_curuserid);
  
    --回滚至保存点
    ROLLBACK TO qarepinfochange;
  END p_it_qarepinfochange;

  /*=============================================================================
  
     包：
       pkg_qa_it(QA集成测试包)
  
     过程名:
       通过 Asnordersitem生成 Asnordersitem_itf数据
  
     入参:
       v_inp_asnid   :  Asn单号
       v_inp_compid  :  企业Id
  
     版本:
       2022-11-01_ZC314 : 通过 Asnordersitem生成 Asnordersitem_itf数据
       
  ==============================================================================*/
  PROCEDURE p_gen_asnordersitemitfdata(v_inp_asnid  IN VARCHAR2,
                                       v_inp_compid IN VARCHAR2) IS
    v_itemjugnum NUMBER(1);
  BEGIN
  
    SELECT nvl(MAX(1), 0)
      INTO v_itemjugnum
      FROM scmdata.t_asnordersitem
     WHERE asn_id = v_inp_asnid
       AND company_id = v_inp_compid;
  
    IF v_itemjugnum = 0 THEN
      raise_application_error(-20002,
                              'asnordersitem 没有数据不能生成 asnordersitem_itf 数据');
    ELSE
      INSERT INTO scmdata.t_asnordersitem_itf
        (asn_id,
         company_id,
         dc_company_id,
         goo_id,
         barcode,
         order_amount,
         pcome_amount,
         asngot_amount,
         wmsgot_amount,
         ret_amount,
         pick_time,
         shipment_time,
         receive_time,
         warehouse_pos,
         memo,
         create_id,
         create_time,
         update_id,
         update_time,
         port_element,
         port_time,
         port_status,
         color_name)
        SELECT item.asn_id,
               item.company_id,
               item.dc_company_id,
               item.goo_id,
               item.barcode,
               item.order_amount,
               item.pcome_amount,
               item.asngot_amount,
               item.wmsgot_amount,
               item.ret_amount,
               item.pick_time,
               item.shipment_time,
               item.receive_time,
               item.warehouse_pos,
               item.memo,
               item.create_id,
               item.create_time,
               item.update_id,
               item.update_time,
               'test',
               SYSDATE,
               'SP',
               colsiz.colorname
          FROM scmdata.t_asnordersitem item
          LEFT JOIN scmdata.t_commodity_color_size colsiz
            ON item.goo_id = colsiz.goo_id
           AND item.barcode = colsiz.barcode
           AND item.company_id = colsiz.company_id
         WHERE item.asn_id = v_inp_asnid
           AND item.company_id = v_inp_compid;
    END IF;
  END p_gen_asnordersitemitfdata;

  /*=================================================================================
          
    包：
      pkg_qa_it(qa集成测试包)
          
    过程名:
      生成 Asnorderpacks数据
          
    入参:
      v_inp_asnid   :  Asn单号
      v_inp_compid  :  企业Id
          
     版本:
       2022-11-24: 生成 Asnorderpacks数据
          
  =================================================================================*/
  PROCEDURE p_gen_asnorderpacksinfo(v_inp_asnid  IN VARCHAR2,
                                    v_inp_compid IN VARCHAR2) IS
    v_randomnum   NUMBER(1);
    v_packamount  NUMBER(8);
    v_packbarcode VARCHAR2(32);
  BEGIN
    FOR i IN (SELECT asns.asn_id,
                     asns.company_id,
                     asns.goo_id,
                     goo.rela_goo_id,
                     asnitem.barcode,
                     nvl(asnitem.pcome_amount, asns.pcome_amount) pcome_amount
                FROM scmdata.t_asnorders asns
               INNER JOIN scmdata.t_commodity_info goo
                  ON asns.goo_id = goo.goo_id
                 AND asns.company_id = goo.company_id
                LEFT JOIN scmdata.t_asnordersitem asnitem
                  ON asns.asn_id = asnitem.asn_id
                 AND asns.company_id = asnitem.company_id
               WHERE asns.asn_id = v_inp_asnid
                 AND asns.company_id = v_inp_compid) LOOP
      v_randomnum := dbms_random.value(1, 3);
    
      FOR x IN 1 .. v_randomnum LOOP
        IF x = v_randomnum THEN
          v_packamount := i.pcome_amount -
                          trunc(i.pcome_amount / v_randomnum *
                                (v_randomnum - 1));
        ELSE
          IF trunc(i.pcome_amount / v_randomnum) = 0 THEN
            v_packamount := i.pcome_amount;
          ELSE
            v_packamount := trunc(i.pcome_amount / v_randomnum);
          END IF;
        END IF;
      
        IF i.barcode IS NULL THEN
          v_packbarcode := i.goo_id || lpad(to_char(x), 4, '0');
        ELSE
          v_packbarcode := i.barcode || lpad(to_char(x), 2, '0');
        END IF;
      
        INSERT INTO scmdata.t_asnorderpacks
          (asn_id,
           company_id,
           dc_company_id,
           operator_id,
           goo_id,
           barcode,
           pack_barcode,
           packamount,
           create_id,
           create_time,
           goodsid)
        VALUES
          (i.asn_id,
           i.company_id,
           i.company_id,
           'zc314',
           i.goo_id,
           i.barcode,
           v_packbarcode,
           v_packamount,
           'zc314',
           SYSDATE,
           nvl(i.barcode, i.goo_id));
      END LOOP;
    
    END LOOP;
  END p_gen_asnorderpacksinfo;

END pkg_qa_it;
/

