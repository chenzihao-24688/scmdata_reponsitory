CREATE OR REPLACE PACKAGE SCMDATA.pkg_panda_asn IS

  /*=================================================================================
    
    包：
      pkg_panda_asn(熊猫Asn包)
    
    函数名:
      【Asn遗漏】获取 wms 传入质检任务后，熊猫 Asn 接口遗漏的 Asnordered.asnid
    
     版本:
       2023-03-14: 获取 wms 传入质检任务后，熊猫 Asn 接口遗漏的 Asnordered.asnid
    
  =================================================================================*/
  FUNCTION f_asnleak_get_panda_leak_asnordered RETURN VARCHAR2;

  /*=================================================================================
    
    包：
      pkg_panda_asn(熊猫Asn包)
    
    函数名:
      【Asn遗漏】获取 wms 传入质检任务后，熊猫 Asn 接口遗漏的 Asnorders.asnid
    
     版本:
       2023-03-14: 获取 wms 传入质检任务后，熊猫 Asn 接口遗漏的 Asnorders.asnid
    
  =================================================================================*/
  FUNCTION f_asnleak_get_panda_leak_asnorders RETURN VARCHAR2;

  /*=================================================================================
    
    包：
      pkg_panda_asn(熊猫Asn包)
    
    函数名:
      【Asn遗漏】获取 wms 传入质检任务后，熊猫 Asn 接口遗漏的 Asnordersitem.asnid
    
     版本:
       2023-03-14: 获取 wms 传入质检任务后，熊猫 Asn 接口遗漏的 Asnordersitem.asnid
    
  =================================================================================*/
  FUNCTION f_asnleak_get_panda_leak_asnordersitem RETURN VARCHAR2;

  /*=================================================================================
  
    包：
      pkg_panda_asn(熊猫Asn包)
  
    过程名:
      【Asn遗漏】新增/修改进入 Asnordered_inf表
  
    入参:
      v_inp_asnid          :  Asn单号
      v_inp_compid         :  企业Id
      v_inp_orderid        :  订单号
      v_inp_pcomedate      :  预计到仓日期
      v_inp_scantime       :  到仓扫描时间
      v_inp_pcomeinterval  :  预计到仓时间段
      v_inp_memo           :  备注
      v_inp_operid         :  操作人Id
      v_inp_opertime       :  操作时间
  
     版本:
       2023-03-14: 新增/修改进入 Asnordered_inf表
  
  =================================================================================*/
  PROCEDURE p_asnleak_iou_asnordered_info_into_inf(v_inp_asnid         IN VARCHAR2,
                                                   v_inp_compid        IN VARCHAR2,
                                                   v_inp_orderid       IN VARCHAR2,
                                                   v_inp_pcomedate     IN VARCHAR2,
                                                   v_inp_scantime      IN VARCHAR2,
                                                   v_inp_pcomeinterval IN VARCHAR2,
                                                   v_inp_memo          IN VARCHAR2,
                                                   v_inp_operid        IN VARCHAR2,
                                                   v_inp_opertime      IN VARCHAR2);

  /*=================================================================================
  
    包：
      pkg_panda_asn(熊猫Asn包)
  
    过程名:
      【Asn遗漏】新增/修改进入 Asnorders_inf表
  
    入参:
      v_inp_asnid          :  Asn单号
      v_inp_compid         :  企业Id
      v_inp_orderid        :  订单号
      v_inp_pcomedate      :  预计到仓日期
      v_inp_scantime       :  到仓扫描时间
      v_inp_pcomeinterval  :  预计到仓时间段
      v_inp_memo           :  备注
      v_inp_operid         :  操作人Id
      v_inp_opertime       :  操作时间
  
     版本:
       2023-03-14: 新增/修改进入 Asnorders_inf表
  
  =================================================================================*/
  PROCEDURE p_asnleak_iou_asnorders_info_into_inf(v_inp_asnid        IN VARCHAR2,
                                                  v_inp_compid       IN VARCHAR2,
                                                  v_inp_relagooid    IN VARCHAR2,
                                                  v_inp_orderamount  IN NUMBER,
                                                  v_inp_pcomeamount  IN NUMBER,
                                                  v_inp_asngotamount IN NUMBER,
                                                  v_inp_gotamount    IN NUMBER,
                                                  v_inp_retamount    IN NUMBER,
                                                  v_inp_memo         IN VARCHAR2,
                                                  v_inp_picktime     IN VARCHAR2,
                                                  v_inp_shimenttime  IN VARCHAR2,
                                                  v_inp_receivetime  IN VARCHAR2,
                                                  v_inp_warehousepos IN VARCHAR2,
                                                  v_inp_receivetype  IN VARCHAR2,
                                                  v_inp_receivemsg   IN VARCHAR2,
                                                  v_inp_isfclout     IN NUMBER,
                                                  v_inp_isqcrequired IN NUMBER,
                                                  v_inp_sortingtime  IN VARCHAR2,
                                                  v_inp_packcases    IN NUMBER,
                                                  v_inp_operid       IN VARCHAR2,
                                                  v_inp_opertime     IN VARCHAR2);

  /*=================================================================================
  
    包：
      pkg_panda_asn(熊猫Asn包)
  
    过程名:
      【Asn遗漏】新增/修改进入 Asnorders_inf表
  
    入参:
      v_inp_asnid          :  Asn单号
      v_inp_compid         :  企业Id
      v_inp_orderid        :  订单号
      v_inp_pcomedate      :  预计到仓日期
      v_inp_scantime       :  到仓扫描时间
      v_inp_pcomeinterval  :  预计到仓时间段
      v_inp_memo           :  备注
      v_inp_operid         :  操作人Id
      v_inp_opertime       :  操作时间
  
     版本:
       2023-03-14: 新增/修改进入 Asnorders_inf表
  
  =================================================================================*/
  PROCEDURE p_asnleak_iou_asnordersitem_info_into_inf(v_inp_asnid        IN VARCHAR2,
                                                      v_inp_compid       IN VARCHAR2,
                                                      v_inp_relagooid    IN VARCHAR2,
                                                      v_inp_barcode      IN VARCHAR2,
                                                      v_inp_orderamount  IN NUMBER,
                                                      v_inp_pcomeamount  IN NUMBER,
                                                      v_inp_asngotamount IN NUMBER,
                                                      v_inp_gotamount    IN NUMBER,
                                                      v_inp_retamount    IN NUMBER,
                                                      v_inp_picktime     IN VARCHAR2,
                                                      v_inp_shipmenttime IN VARCHAR2,
                                                      v_inp_receivetime  IN VARCHAR2,
                                                      v_inp_warehousepos IN VARCHAR2,
                                                      v_inp_memo         IN VARCHAR2,
                                                      v_inp_packcases    IN NUMBER,
                                                      v_inp_operid       IN VARCHAR2,
                                                      v_inp_opertime     IN VARCHAR2);

  /*=================================================================================
    
    包：
      pkg_panda_asn(熊猫Asn包)
    
    过程名:
      【Asn遗漏】 Asnorders_inf表数据同步
    
     版本:
       2023-03-14: Asnorders_inf表数据同步
    
  =================================================================================*/
  PROCEDURE p_asnleak_asnordered_inf_sync;

  /*=================================================================================
    
    包：
      pkg_panda_asn(熊猫Asn包)
    
    过程名:
      【Asn遗漏】 Asnorders_inf表数据同步
    
     版本:
       2023-03-14: Asnorders_inf表数据同步
    
  =================================================================================*/
  PROCEDURE p_asnleak_asnorders_inf_sync;

  /*=================================================================================
    
    包：
      pkg_panda_asn(熊猫Asn包)
    
    过程名:
      【Asn遗漏】 Asnorders_inf表数据同步
    
     版本:
       2023-03-14: Asnorders_inf表数据同步
    
  =================================================================================*/
  PROCEDURE p_asnleak_asnordersitem_inf_sync;

  /*=================================================================================
          
    包:
      pkg_panda_asn(熊猫Asn包)
          
    过程名:
      【Asn遗漏】通过 Asnordered / Asnorders 同步交货记录
      
    入参:
      v_inp_asnid        :  Asn单号
      v_inp_compid       :  企业Id
        
    版本:
      2023-03-29: 通过 Asnordered / Asnorders 同步交货记录
          
  =================================================================================*/
  PROCEDURE p_sync_delivery_record_by_asnorder(v_inp_asnid  IN VARCHAR2,
                                               v_inp_compid IN VARCHAR2);

  /*=================================================================================
          
    包:
      pkg_panda_asn(熊猫Asn包)
          
    过程名:
      【Asn遗漏】通过 Asnordersitem 同步交货记录
      
    入参:
      v_inp_asnid    :  Asn单号
      v_inp_gooid    :  商品档案编号
      v_inp_barcode  :  条码
      v_inp_compid   :  企业Id
        
    版本:
      2023-03-29: 通过 Asnordersitem 同步交货记录
          
  =================================================================================*/
  PROCEDURE p_sync_delivery_record_item_by_asnordersitem(v_inp_asnid   IN VARCHAR2,
                                                         v_inp_gooid   IN VARCHAR2,
                                                         v_inp_barcode IN VARCHAR2,
                                                         v_inp_compid  IN VARCHAR2);

  /*=================================================================================
      
    包:
      pkg_panda_asn(熊猫Asn包)
      
    过程名:
      【Asn遗漏】直接刷新 Asnordered 数据
      
    入参:
      v_inp_asnid         :  Asn单号
      v_inp_compid        :  企业Id
      v_inp_status        :  Asn状态
      v_inp_ordid         :  订单号
      v_inp_pcomedate     :  预计到仓日期
      v_inp_changetimes   :  修改次数
      v_inp_scantime      :  到仓扫描时间
      v_inp_memo          :  备注
      v_inp_createid      :  创建人
      v_inp_createtime    :  创建时间
      v_inp_pcomeinterval :  预计到仓时段
      v_inp_endacctime    :  熊猫结束收货时间
      
    版本:
      2023-03-27: 直接刷新 Asnordered 数据
      
  =================================================================================*/
  PROCEDURE p_leakasn_direct_refresh_asnordered(v_inp_asnid         IN VARCHAR2,
                                                v_inp_compid        IN VARCHAR2,
                                                v_inp_status        IN VARCHAR2,
                                                v_inp_ordid         IN VARCHAR2,
                                                v_inp_pcomedate     IN DATE,
                                                v_inp_changetimes   IN NUMBER,
                                                v_inp_scantime      IN DATE,
                                                v_inp_memo          IN VARCHAR2,
                                                v_inp_createid      IN VARCHAR2,
                                                v_inp_createtime    IN DATE,
                                                v_inp_pcomeinterval IN VARCHAR2,
                                                v_inp_endacctime    IN DATE);

  /*=================================================================================
        
    包:
      pkg_panda_asn(熊猫Asn包)
        
    过程名:
      【Asn遗漏】直接刷新 Asnorders 数据
    
    入参:
      v_inp_asnid        :  Asn单号
      v_inp_compid       :  企业Id
      v_inp_relagooid    :  货号
      v_inp_orderamount  :  订单数量
      v_inp_pcomeamount  :  预计到仓数量
      v_inp_gotamount    :  到货量
      v_inp_retamount    :  退货量
      v_inp_memo         :  备注
      v_inp_isqcrequired :  是否需要质检
      v_inp_isfclout     :  是否直发
      v_inp_operid       :  操作人Id
      v_inp_opertime     :  操作时间
      
    版本:
      2023-03-27: 直接刷新 Asnorders 数据
        
  =================================================================================*/
  PROCEDURE p_leakasn_direct_refresh_asnorders(v_inp_asnid        IN VARCHAR2,
                                               v_inp_compid       IN VARCHAR2,
                                               v_inp_relagooid    IN VARCHAR2,
                                               v_inp_orderamount  IN NUMBER,
                                               v_inp_pcomeamount  IN NUMBER,
                                               v_inp_gotamount    IN NUMBER,
                                               v_inp_retamount    IN NUMBER,
                                               v_inp_memo         IN VARCHAR2,
                                               v_inp_isqcrequired IN NUMBER,
                                               v_inp_isfclout     IN NUMBER,
                                               v_inp_operid       IN VARCHAR2,
                                               v_inp_opertime     IN DATE);

  /*=================================================================================
          
    包:
      pkg_panda_asn(熊猫Asn包)
          
    过程名:
      【Asn遗漏】直接刷新 Asnordersitem 数据
      
    入参:
      v_inp_asnid        :  Asn单号
      v_inp_compid       :  企业Id
      v_inp_relagooid    :  货号
      v_inp_barcode      :  条码
      v_inp_orderamount  :  订单数量
      v_inp_pcomeamount  :  预计到仓数量
      v_inp_gotamount    :  上架数量
      v_inp_retamount    :  退货数量
      v_inp_memo         :  备注
      v_inp_operid       :  操作人Id
      v_inp_opertime     :  操作时间
        
    版本:
      2023-03-28: 直接刷新 Asnordersitem 数据
          
  =================================================================================*/
  PROCEDURE p_leakasn_direct_refresh_asnordersitem(v_inp_asnid       IN VARCHAR2,
                                                   v_inp_compid      IN VARCHAR2,
                                                   v_inp_relagooid   IN VARCHAR2,
                                                   v_inp_barcode     IN VARCHAR2,
                                                   v_inp_orderamount IN NUMBER,
                                                   v_inp_pcomeamount IN NUMBER,
                                                   v_inp_gotamount   IN NUMBER,
                                                   v_inp_retamount   IN NUMBER,
                                                   v_inp_memo        IN VARCHAR2,
                                                   v_inp_operid      IN VARCHAR2,
                                                   v_inp_opertime    IN DATE);
END pkg_panda_asn;
/

CREATE OR REPLACE PACKAGE BODY SCMDATA.pkg_panda_asn IS

  /*=================================================================================
    
    包:
      pkg_panda_asn(熊猫Asn包)
    
    函数名:
      【Asn遗漏】获取 wms 传入质检任务后，熊猫 Asn 接口遗漏的 Asnordered.asnid
    
     版本:
       2023-03-14: 获取 wms 传入质检任务后，熊猫 Asn 接口遗漏的 Asnordered.asnid
    
  =================================================================================*/
  FUNCTION f_asnleak_get_panda_leak_asnordered RETURN VARCHAR2 IS
    v_asnids VARCHAR2(1024);
  BEGIN
    SELECT listagg(asn_id, ';')
      INTO v_asnids
      FROM (SELECT asn_id
              FROM scmdata.t_asnordered_itf itf
             WHERE itf.port_time > trunc(SYSDATE) - 2
               AND NOT EXISTS
             (SELECT 1
                      FROM scmdata.t_asnordered
                     WHERE asn_id = itf.asn_id
                       AND company_id = itf.company_id)
             ORDER BY itf.create_time FETCH FIRST 20 rows ONLY);
  
    RETURN v_asnids;
  END f_asnleak_get_panda_leak_asnordered;

  /*=================================================================================
    
    包:
      pkg_panda_asn(熊猫Asn包)
    
    函数名:
      【Asn遗漏】获取 wms 传入质检任务后，熊猫 Asn 接口遗漏的 Asnorders.asnid
    
     版本:
       2023-03-14: 获取 wms 传入质检任务后，熊猫 Asn 接口遗漏的 Asnorders.asnid
    
  =================================================================================*/
  FUNCTION f_asnleak_get_panda_leak_asnorders RETURN VARCHAR2 IS
    v_asnids VARCHAR2(1024);
  BEGIN
    SELECT listagg(asn_id, ';')
      INTO v_asnids
      FROM (SELECT asn_id
              FROM scmdata.t_asnorders_itf itf
             WHERE itf.port_time > trunc(SYSDATE) - 2
               AND NOT EXISTS
             (SELECT 1
                      FROM scmdata.t_asnorders
                     WHERE asn_id = itf.asn_id
                       AND company_id = itf.company_id)
             ORDER BY itf.create_time FETCH FIRST 20 rows ONLY);
  
    RETURN v_asnids;
  END f_asnleak_get_panda_leak_asnorders;

  /*=================================================================================
    
    包:
      pkg_panda_asn(熊猫Asn包)
    
    函数名:
      【Asn遗漏】获取 wms 传入质检任务后，熊猫 Asn 接口遗漏的 Asnordersitem.asnid
    
     版本:
       2023-03-14: 获取 wms 传入质检任务后，熊猫 Asn 接口遗漏的 Asnordersitem.asnid
    
  =================================================================================*/
  FUNCTION f_asnleak_get_panda_leak_asnordersitem RETURN VARCHAR2 IS
    v_asnids VARCHAR2(1024);
  BEGIN
    SELECT listagg(asn_id, ';')
      INTO v_asnids
      FROM (SELECT asn_id
              FROM scmdata.t_asnordersitem_itf itf
             WHERE itf.port_time > trunc(SYSDATE) - 2
               AND NOT EXISTS
             (SELECT 1
                      FROM scmdata.t_asnordersitem asnitm
                     INNER JOIN scmdata.t_commodity_info goo
                        ON asnitm.goo_id = goo.goo_id
                       AND asnitm.company_id = goo.company_id
                     WHERE asnitm.asn_id = itf.asn_id
                       AND goo.rela_goo_id = itf.goo_id
                       AND nvl(asnitm.barcode, ' ') = nvl(barcode, ' ')
                       AND asnitm.company_id = itf.company_id)
             GROUP BY itf.asn_id
             ORDER BY MAX(itf.create_time) FETCH FIRST 20 rows ONLY);
  
    RETURN v_asnids;
  END f_asnleak_get_panda_leak_asnordersitem;

  /*=================================================================================
  
    包:
      pkg_panda_asn(熊猫Asn包)
  
    过程名:
      【Asn遗漏】新增/修改进入 Asnordered_inf表
  
    入参:
      v_inp_asnid          :  Asn单号
      v_inp_compid         :  企业Id
      v_inp_orderid        :  订单号
      v_inp_pcomedate      :  预计到仓日期
      v_inp_scantime       :  到仓扫描时间
      v_inp_pcomeinterval  :  预计到仓时间段
      v_inp_memo           :  备注
      v_inp_operid         :  操作人Id
      v_inp_opertime       :  操作时间
  
     版本:
       2023-03-14: 新增/修改进入 Asnordered_inf表
  
  =================================================================================*/
  PROCEDURE p_asnleak_iou_asnordered_info_into_inf(v_inp_asnid         IN VARCHAR2,
                                                   v_inp_compid        IN VARCHAR2,
                                                   v_inp_orderid       IN VARCHAR2,
                                                   v_inp_pcomedate     IN VARCHAR2,
                                                   v_inp_scantime      IN VARCHAR2,
                                                   v_inp_pcomeinterval IN VARCHAR2,
                                                   v_inp_memo          IN VARCHAR2,
                                                   v_inp_operid        IN VARCHAR2,
                                                   v_inp_opertime      IN VARCHAR2) IS
    v_jugnum          NUMBER(1);
    v_supcode         VARCHAR2(32);
    v_pcomedate       DATE := to_date(v_inp_pcomedate,
                                      'yyyy-mm-dd hh24-mi-ss');
    v_scantime        DATE := to_date(v_inp_scantime,
                                      'yyyy-mm-dd hh24-mi-ss');
    v_opertime        DATE := to_date(v_inp_opertime,
                                      'yyyy-mm-dd hh24-mi-ss');
    v_sqlerrm         VARCHAR2(1024);
    v_errinfo         CLOB;
    v_sql             CLOB;
    v_selfdescription VARCHAR2(1024) := 'scmdata.pkg_panda_asn.p_asnleak_ins_asnordered_info_into_inf';
  BEGIN
    --判断是否存在
    SELECT nvl(MAX(1), 0)
      INTO v_jugnum
      FROM scmdata.t_asnordered_inf
     WHERE asn_id = v_inp_asnid
       AND company_id = v_inp_compid
       AND rownum = 1;
  
    --当Asn不存在于 scmdata.t_asnordered_itf
    IF v_jugnum = 0 THEN
      --获取供应商编码
      SELECT MAX(supplier_code)
        INTO v_supcode
        FROM scmdata.t_ordered
       WHERE order_code = v_inp_orderid
         AND company_id = v_inp_compid;
    
      --构建执行Sql
      v_sql := 'INSERT INTO scmdata.t_asnordered_inf
  (asn_id,
   company_id,
   dc_company_id,
   status,
   order_id,
   supplier_code,
   pcome_date,
   scan_time,
   pcome_interval,
   memo,
   create_id,
   create_time,
   operation_flag,
   operation_type,
   leak_status)
VALUES
  (:v_inp_asnid,
   :v_inp_compid,
   :v_inp_compid,
   ''IN'',
   :v_inp_orderid,
   :v_supcode,
   :v_pcomedate,
   :v_scantime,
   :v_inp_pcomeinterval,
   :v_inp_memo,
   :v_inp_operid,
   :v_opertime,
   1,
   ''I'',
   ''R'')';
    
      --执行Sql
      EXECUTE IMMEDIATE v_sql
        USING v_inp_asnid, v_inp_compid, v_inp_compid, v_inp_orderid, v_supcode, v_pcomedate, v_scantime, v_inp_pcomeinterval, v_inp_memo, v_inp_operid, v_opertime;
    ELSE
      --执行Sql赋值
      v_sql := 'UPDATE scmdata.t_asnordered_inf
   SET order_id       = :v_inp_orderid,
       supplier_code  = :v_supcode,
       pcome_date     = :v_pcomedate,
       scan_time      = :v_scantime,
       pcome_interval = :v_inp_pcomeinterval,
       memo           = :v_inp_memo,
       update_id      = :v_inp_operid,
       update_time    = :v_opertime,
       operation_flag = 1,
       operation_type = ''U'',
       leak_status    = ''R''
 WHERE asn_id = :v_inp_asnid
   AND company_id = :v_inp_compid';
    
      --执行Sql
      EXECUTE IMMEDIATE v_sql
        USING v_inp_orderid, v_supcode, v_pcomedate, v_scantime, v_inp_pcomeinterval, v_inp_memo, v_inp_operid, v_opertime, v_inp_asnid, v_inp_compid;
    END IF;
  EXCEPTION
    WHEN OTHERS THEN
      --错误信息赋值
      v_sqlerrm := substr(dbms_utility.format_error_stack, 1, 1024);
      v_errinfo := 'Error Object: ' || v_selfdescription || chr(10) ||
                   'Error Info: ' || v_sqlerrm || chr(10) || 'Execute_sql:' ||
                   v_sql || chr(10) || 'Params: ' || chr(10) ||
                   'v_inp_asnid: ' || v_inp_asnid || chr(10) ||
                   'v_inp_compid: ' || v_inp_compid || chr(10) ||
                   'v_inp_orderid: ' || v_inp_orderid || chr(10) ||
                   'v_supcode: ' || v_supcode || chr(10) || 'v_pcomedate: ' ||
                   v_inp_pcomedate || chr(10) || 'v_scantime: ' ||
                   v_inp_scantime || chr(10) || 'v_inp_pcomeinterval: ' ||
                   v_inp_pcomeinterval || chr(10) || 'v_inp_memo: ' ||
                   v_inp_memo || chr(10) || 'v_inp_operid: ' ||
                   v_inp_operid || chr(10) || 'v_inp_opertime: ' ||
                   v_inp_opertime;
    
      --新增进入错误信息表
      scmdata.pkg_qa_ee.p_ins_errrecord_at(v_inp_errprogram     => v_selfdescription,
                                           v_inp_causeerruserid => 'itf_asn_leak',
                                           v_inp_erroccurtime   => SYSDATE,
                                           v_inp_errinfo        => v_errinfo,
                                           v_inp_compid         => v_inp_compid);
  END p_asnleak_iou_asnordered_info_into_inf;

  /*=================================================================================
  
    包:
      pkg_panda_asn(熊猫Asn包)
  
    过程名:
      【Asn遗漏】新增/修改进入 Asnorders_inf表
  
    入参:
      v_inp_asnid          :  Asn单号
      v_inp_compid         :  企业Id
      v_inp_orderid        :  订单号
      v_inp_pcomedate      :  预计到仓日期
      v_inp_scantime       :  到仓扫描时间
      v_inp_pcomeinterval  :  预计到仓时间段
      v_inp_memo           :  备注
      v_inp_operid         :  操作人Id
      v_inp_opertime       :  操作时间
  
     版本:
       2023-03-14: 新增/修改进入 Asnorders_inf表
  
  =================================================================================*/
  PROCEDURE p_asnleak_iou_asnorders_info_into_inf(v_inp_asnid        IN VARCHAR2,
                                                  v_inp_compid       IN VARCHAR2,
                                                  v_inp_relagooid    IN VARCHAR2,
                                                  v_inp_orderamount  IN NUMBER,
                                                  v_inp_pcomeamount  IN NUMBER,
                                                  v_inp_asngotamount IN NUMBER,
                                                  v_inp_gotamount    IN NUMBER,
                                                  v_inp_retamount    IN NUMBER,
                                                  v_inp_memo         IN VARCHAR2,
                                                  v_inp_picktime     IN VARCHAR2,
                                                  v_inp_shimenttime  IN VARCHAR2,
                                                  v_inp_receivetime  IN VARCHAR2,
                                                  v_inp_warehousepos IN VARCHAR2,
                                                  v_inp_receivetype  IN VARCHAR2,
                                                  v_inp_receivemsg   IN VARCHAR2,
                                                  v_inp_isfclout     IN NUMBER,
                                                  v_inp_isqcrequired IN NUMBER,
                                                  v_inp_sortingtime  IN VARCHAR2,
                                                  v_inp_packcases    IN NUMBER,
                                                  v_inp_operid       IN VARCHAR2,
                                                  v_inp_opertime     IN VARCHAR2) IS
    v_jugnum          NUMBER(1);
    v_picktime        DATE := to_date(v_inp_picktime,
                                      'yyyy-mm-dd hh24-mi-ss');
    v_shimenttime     DATE := to_date(v_inp_shimenttime,
                                      'yyyy-mm-dd hh24-mi-ss');
    v_receivetime     DATE := to_date(v_inp_receivetime,
                                      'yyyy-mm-dd hh24-mi-ss');
    v_sortingtime     DATE := to_date(v_inp_sortingtime,
                                      'yyyy-mm-dd hh24-mi-ss');
    v_opertime        DATE := to_date(v_inp_opertime,
                                      'yyyy-mm-dd hh24-mi-ss');
    v_sqlerrm         VARCHAR2(1024);
    v_errinfo         CLOB;
    v_sql             CLOB;
    v_selfdescription VARCHAR2(1024) := 'scmdata.pkg_panda_asn.p_asnleak_iou_asnorders_info_into_inf';
  BEGIN
    --判断是否存在
    SELECT nvl(MAX(1), 0)
      INTO v_jugnum
      FROM scmdata.t_asnorders_inf
     WHERE asn_id = v_inp_asnid
       AND company_id = v_inp_compid
       AND rownum = 1;
  
    --当Asn不存在于 scmdata.t_asnordered_itf
    IF v_jugnum = 0 THEN
      --构建执行Sql
      v_sql := 'INSERT INTO scmdata.t_asnorders_inf
  (asn_id,
   company_id,
   dc_company_id,
   goo_id,
   order_amount,
   pcome_amount,
   asngot_amount,
   got_amount,
   memo,
   ret_amount,
   pick_time,
   shiment_time,
   receive_time,
   warehouse_pos,
   receive_type,
   receive_msg,
   operation_flag,
   operation_type,
   is_fcl_out,
   is_qc_required,
   sorting_time,
   packcases,
   create_id,
   create_time,
   leak_status)
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
   :v_inp_retamount,
   :v_picktime,
   :v_shimenttime,
   :v_receivetime,
   :v_inp_warehousepos,
   :v_inp_receivetype,
   :v_inp_receivemsg,
   1,
   ''I'',
   :v_inp_isfclout,
   :v_inp_isqcrequired,
   :v_sortingtime,
   :v_inp_packcases,
   :v_inp_operid,
   :v_opertime,
   ''R'')';
    
      --执行Sql
      EXECUTE IMMEDIATE v_sql
        USING v_inp_asnid, v_inp_compid, v_inp_compid, v_inp_relagooid, v_inp_orderamount, v_inp_pcomeamount, v_inp_asngotamount, v_inp_gotamount, v_inp_memo, v_inp_retamount, v_picktime, v_shimenttime, v_receivetime, v_inp_warehousepos, v_inp_receivetype, v_inp_receivemsg, v_inp_isfclout, v_inp_isqcrequired, v_sortingtime, v_inp_packcases, v_inp_operid, v_opertime;
    ELSE
      --执行Sql赋值
      v_sql := 'UPDATE scmdata.t_asnorders_inf
   SET order_amount   = :v_inp_orderamount,
       pcome_amount   = :v_inp_pcomeamount,
       asngot_amount  = :v_inp_asngotamount,
       got_amount     = :v_inp_gotamount,
       memo           = :v_inp_memo,
       ret_amount     = :v_inp_retamount,
       pick_time      = :v_picktime,
       shiment_time   = :v_shimenttime,
       receive_time   = :v_receivetime,
       warehouse_pos  = :v_inp_warehousepos,
       receive_type   = :v_inp_receivetype,
       receive_msg    = :v_inp_receivemsg,
       operation_flag = 1,
       operation_type = ''U'',
       is_fcl_out     = :v_inp_isfclout,
       is_qc_required = :v_inp_isqcrequired,
       sorting_time   = :v_sortingtime,
       packcases      = :v_inp_packcases,
       update_id      = :v_inp_operid,
       update_time    = :v_opertime,
       leak_status    = ''R''
 WHERE asn_id = :v_inp_asnid
   AND company_id = :v_inp_compid';
    
      --执行Sql
      EXECUTE IMMEDIATE v_sql
        USING v_inp_orderamount, v_inp_pcomeamount, v_inp_asngotamount, v_inp_gotamount, v_inp_memo, v_inp_retamount, v_picktime, v_shimenttime, v_receivetime, v_inp_warehousepos, v_inp_receivetype, v_inp_receivemsg, v_inp_isfclout, v_inp_isqcrequired, v_sortingtime, v_inp_packcases, v_inp_operid, v_opertime, v_inp_asnid, v_inp_compid;
    END IF;
  EXCEPTION
    WHEN OTHERS THEN
      --错误信息赋值
      v_sqlerrm := substr(dbms_utility.format_error_stack, 1, 1024);
      v_errinfo := 'Error Object: ' || v_selfdescription || chr(10) ||
                   'Error Info: ' || v_sqlerrm || chr(10) || 'Execute_sql:' ||
                   v_sql || chr(10) || 'Params: ' || chr(10) ||
                   'v_inp_asnid: ' || v_inp_asnid || chr(10) ||
                   'v_inp_compid: ' || v_inp_compid || chr(10) ||
                   'v_inp_relagooid: ' || v_inp_relagooid || chr(10) ||
                   'v_inp_orderamount: ' || to_char(v_inp_orderamount) ||
                   chr(10) || 'v_inp_pcomeamount: ' ||
                   to_char(v_inp_pcomeamount) || chr(10) ||
                   'v_inp_gotamount: ' || to_char(v_inp_gotamount) ||
                   chr(10) || 'v_inp_memo: ' || v_inp_memo || chr(10) ||
                   'v_inp_retamount: ' || to_char(v_inp_retamount) ||
                   chr(10) || 'v_inp_picktime: ' || v_inp_picktime ||
                   chr(10) || 'v_inp_shimenttime: ' || v_inp_shimenttime ||
                   chr(10) || 'v_inp_receivetime: ' || v_inp_receivetime ||
                   chr(10) || 'v_inp_warehousepos: ' || v_inp_warehousepos ||
                   chr(10) || 'v_inp_receivetype: ' || v_inp_receivetype ||
                   chr(10) || 'v_inp_receivemsg: ' || v_inp_receivemsg ||
                   chr(10) || 'v_inp_isfclout: ' || to_char(v_inp_isfclout) ||
                   chr(10) || 'v_inp_isqcrequired: ' ||
                   to_char(v_inp_isqcrequired) || chr(10) ||
                   'v_inp_sortingtime: ' || v_inp_sortingtime || chr(10) ||
                   'v_inp_packcases: ' || to_char(v_inp_packcases) ||
                   chr(10) || 'v_inp_operid: ' || v_inp_operid || chr(10) ||
                   'v_inp_opertime: ' || v_inp_opertime;
    
      --新增进入错误信息表
      scmdata.pkg_qa_ee.p_ins_errrecord_at(v_inp_errprogram     => v_selfdescription,
                                           v_inp_causeerruserid => 'itf_asn_leak',
                                           v_inp_erroccurtime   => SYSDATE,
                                           v_inp_errinfo        => v_errinfo,
                                           v_inp_compid         => v_inp_compid);
  END p_asnleak_iou_asnorders_info_into_inf;

  /*=================================================================================
  
    包:
      pkg_panda_asn(熊猫Asn包)
  
    过程名:
      【Asn遗漏】新增/修改进入 Asnorders_inf表
  
    入参:
      v_inp_asnid          :  Asn单号
      v_inp_compid         :  企业Id
      v_inp_orderid        :  订单号
      v_inp_pcomedate      :  预计到仓日期
      v_inp_scantime       :  到仓扫描时间
      v_inp_pcomeinterval  :  预计到仓时间段
      v_inp_memo           :  备注
      v_inp_operid         :  操作人Id
      v_inp_opertime       :  操作时间
  
     版本:
       2023-03-14: 新增/修改进入 Asnorders_inf表
  
  =================================================================================*/
  PROCEDURE p_asnleak_iou_asnordersitem_info_into_inf(v_inp_asnid        IN VARCHAR2,
                                                      v_inp_compid       IN VARCHAR2,
                                                      v_inp_relagooid    IN VARCHAR2,
                                                      v_inp_barcode      IN VARCHAR2,
                                                      v_inp_orderamount  IN NUMBER,
                                                      v_inp_pcomeamount  IN NUMBER,
                                                      v_inp_asngotamount IN NUMBER,
                                                      v_inp_gotamount    IN NUMBER,
                                                      v_inp_retamount    IN NUMBER,
                                                      v_inp_picktime     IN VARCHAR2,
                                                      v_inp_shipmenttime IN VARCHAR2,
                                                      v_inp_receivetime  IN VARCHAR2,
                                                      v_inp_warehousepos IN VARCHAR2,
                                                      v_inp_memo         IN VARCHAR2,
                                                      v_inp_packcases    IN NUMBER,
                                                      v_inp_operid       IN VARCHAR2,
                                                      v_inp_opertime     IN VARCHAR2) IS
    v_jugnum          NUMBER(1);
    v_picktime        DATE := to_date(v_inp_picktime,
                                      'yyyy-mm-dd hh24-mi-ss');
    v_shipmenttime    DATE := to_date(v_inp_shipmenttime,
                                      'yyyy-mm-dd hh24-mi-ss');
    v_receivetime     DATE := to_date(v_inp_receivetime,
                                      'yyyy-mm-dd hh24-mi-ss');
    v_opertime        DATE := to_date(v_inp_opertime,
                                      'yyyy-mm-dd hh24-mi-ss');
    v_sqlerrm         VARCHAR2(1024);
    v_errinfo         CLOB;
    v_sql             CLOB;
    v_selfdescription VARCHAR2(1024) := 'scmdata.pkg_panda_asn.p_asnleak_iou_asnorders_info_into_inf';
  BEGIN
    --判断是否存在
    SELECT nvl(MAX(1), 0)
      INTO v_jugnum
      FROM scmdata.t_asnordersitem_inf
     WHERE asn_id = v_inp_asnid
       AND goo_id = v_inp_relagooid
       AND nvl(barcode, ' ') = nvl(v_inp_barcode, ' ')
       AND company_id = v_inp_compid
       AND rownum = 1;
  
    --当Asn不存在于 scmdata.t_asnordered_itf
    IF v_jugnum = 0 THEN
      --构建执行Sql
      v_sql := 'INSERT INTO scmdata.t_asnordersitem_inf
  (asn_id,
   company_id,
   dc_company_id,
   goo_id,
   barcode,
   order_amount,
   pcome_amount,
   asngot_amount,
   got_amount,
   ret_amount,
   pick_time,
   shipment_time,
   receive_time,
   warehouse_pos,
   memo,
   packcases,
   create_id,
   create_time,
   operation_flag,
   operation_type,
   leak_status)
VALUES
  (:v_inp_asnid, 
   :v_inp_compid,
   :v_inp_compid,
   :v_inp_relagooid,
   :v_inp_barcode,
   :v_inp_orderamount,
   :v_inp_pcomeamount,
   :v_inp_asngotamount,
   :v_inp_gotamount,
   :v_inp_retamount,
   :v_picktime,
   :v_shipmenttime,
   :v_receivetime,
   :v_inp_warehousepos,
   :v_inp_memo,
   :v_inp_packcases,
   :v_inp_operid,
   :v_opertime,
   1,
   ''I'',
   ''R'')';
    
      --执行Sql
      EXECUTE IMMEDIATE v_sql
        USING v_inp_asnid, v_inp_compid, v_inp_compid, v_inp_relagooid, v_inp_barcode, v_inp_orderamount, v_inp_pcomeamount, v_inp_asngotamount, v_inp_gotamount, v_inp_retamount, v_picktime, v_shipmenttime, v_receivetime, v_inp_warehousepos, v_inp_memo, v_inp_packcases, v_inp_operid, v_opertime;
    ELSE
      --执行Sql赋值
      v_sql := 'UPDATE scmdata.t_asnordersitem_inf
   SET order_amount   = :v_inp_orderamount,
       pcome_amount   = :v_inp_pcomeamount,
       asngot_amount  = :v_inp_asngotamount,
       got_amount     = :v_inp_gotamount,
       ret_amount     = :v_inp_retamount,
       pick_time      = :v_picktime,
       shipment_time  = :v_shipmenttime,
       receive_time   = :v_receivetime,
       warehouse_pos  = :v_inp_warehousepos,
       memo           = :v_inp_memo,
       packcases      = :v_inp_packcases,
       update_id      = :v_inp_operid,
       update_time    = :v_opertime,
       operation_flag = 1,
       operation_type = ''U'',
       leak_status    = ''R''
 WHERE asn_id = :v_inp_asnid
   AND goo_id = :v_inp_relagooid
   AND nvl(barcode, '' '') = nvl(:v_inp_barcode, '' '')
   AND company_id = :v_inp_compid';
    
      --执行Sql
      EXECUTE IMMEDIATE v_sql
        USING v_inp_orderamount, v_inp_pcomeamount, v_inp_asngotamount, v_inp_gotamount, v_inp_retamount, v_picktime, v_shipmenttime, v_receivetime, v_inp_warehousepos, v_inp_memo, v_inp_packcases, v_inp_operid, v_opertime, v_inp_asnid, v_inp_relagooid, v_inp_barcode, v_inp_compid;
    END IF;
  EXCEPTION
    WHEN OTHERS THEN
      --错误信息赋值   
      v_sqlerrm := substr(dbms_utility.format_error_stack, 1, 1024);
      v_errinfo := 'Error Object: ' || v_selfdescription || chr(10) ||
                   'Error Info: ' || v_sqlerrm || chr(10) || 'Execute_sql:' ||
                   v_sql || chr(10) || 'Params: ' || chr(10) ||
                   'v_inp_asnid: ' || v_inp_asnid || chr(10) ||
                   'v_inp_compid: ' || v_inp_compid || chr(10) ||
                   'v_inp_relagooid: ' || v_inp_relagooid || chr(10) ||
                   'v_inp_barcode: ' || v_inp_barcode || chr(10) ||
                   'v_inp_orderamount: ' || to_char(v_inp_orderamount) ||
                   chr(10) || 'v_inp_pcomeamount: ' ||
                   to_char(v_inp_pcomeamount) || chr(10) ||
                   'v_inp_asngotamount: ' || to_char(v_inp_asngotamount) ||
                   chr(10) || 'v_inp_gotamount: ' ||
                   to_char(v_inp_gotamount) || chr(10) ||
                   'v_inp_retamount: ' || to_char(v_inp_retamount) ||
                   chr(10) || 'v_inp_picktime: ' || v_inp_picktime ||
                   chr(10) || 'v_inp_shipmenttime: ' || v_inp_shipmenttime ||
                   chr(10) || 'v_inp_receivetime: ' || v_inp_receivetime ||
                   chr(10) || 'v_inp_warehousepos: ' || v_inp_warehousepos ||
                   chr(10) || 'v_inp_memo: ' || v_inp_memo || chr(10) ||
                   'v_inp_packcases: ' || to_char(v_inp_packcases) ||
                   chr(10) || 'v_inp_operid: ' || v_inp_operid || chr(10) ||
                   'v_inp_opertime: ' || v_inp_opertime;
    
      --新增进入错误信息表
      scmdata.pkg_qa_ee.p_ins_errrecord_at(v_inp_errprogram     => v_selfdescription,
                                           v_inp_causeerruserid => 'itf_asn_leak',
                                           v_inp_erroccurtime   => SYSDATE,
                                           v_inp_errinfo        => v_errinfo,
                                           v_inp_compid         => v_inp_compid);
  END p_asnleak_iou_asnordersitem_info_into_inf;

  /*=================================================================================
    
    包:
      pkg_panda_asn(熊猫Asn包)
    
    过程名:
      【Asn遗漏】 Asnorders_inf表数据同步
    
     版本:
       2023-03-14: Asnorders_inf表数据同步
    
  =================================================================================*/
  PROCEDURE p_asnleak_asnordered_inf_sync IS
    v_jugnum  NUMBER(1);
    v_asnid   VARCHAR2(32);
    v_compid  VARCHAR2(32);
    v_sqlerrm VARCHAR2(1024);
  BEGIN
    FOR i IN (SELECT asn_id,
                     company_id,
                     dc_company_id,
                     status,
                     order_id,
                     supplier_code,
                     pcome_date,
                     scan_time,
                     pcome_interval,
                     memo,
                     create_id,
                     create_time,
                     update_id,
                     update_time
                FROM scmdata.t_asnordered_inf
               WHERE nvl(leak_status, ' ') IN ('E', 'R')
               ORDER BY create_time FETCH FIRST 1000 rows ONLY) LOOP
      BEGIN
        --判断是否存在于 Asnordered
        SELECT nvl(MAX(1), 0)
          INTO v_jugnum
          FROM scmdata.t_asnordered
         WHERE asn_id = i.asn_id
           AND company_id = i.company_id
           AND rownum = 1;
      
        IF v_jugnum = 0 THEN
          --新增进入 Asnordered
          INSERT INTO scmdata.t_asnordered
            (asn_id,
             company_id,
             dc_company_id,
             status,
             order_id,
             supplier_code,
             pcome_date,
             scan_time,
             pcome_interval,
             memo,
             create_id,
             create_time)
          VALUES
            (i.asn_id,
             i.company_id,
             i.dc_company_id,
             i.status,
             i.order_id,
             i.supplier_code,
             i.pcome_date,
             i.scan_time,
             i.pcome_interval,
             i.memo,
             i.create_id,
             i.create_time);
        
          --修改 Asnordered_inf 缺失状态为成功
          UPDATE scmdata.t_asnordered_inf
             SET leak_status = 'S'
           WHERE asn_id = i.asn_id
             AND company_id = i.company_id;
        END IF;
      EXCEPTION
        WHEN OTHERS THEN
          --缺失错误信息赋值
          v_sqlerrm := substr(dbms_utility.format_error_stack, 1, 1024);
        
          --修改 Asnordered_inf 缺失状态为失败，并记录缺失错误信息
          UPDATE scmdata.t_asnordered_inf
             SET leak_status  = 'E',
                 leak_errinfo = v_sqlerrm
           WHERE asn_id = v_asnid
             AND company_id = v_compid;
        
          --异常后继续循环
          CONTINUE;
      END;
    END LOOP;
  END p_asnleak_asnordered_inf_sync;

  /*=================================================================================
    
    包:
      pkg_panda_asn(熊猫Asn包)
    
    过程名:
      【Asn遗漏】 Asnorders_inf表数据同步
    
     版本:
       2023-03-14: Asnorders_inf表数据同步
    
  =================================================================================*/
  PROCEDURE p_asnleak_asnorders_inf_sync IS
    v_jugnum  NUMBER(1);
    v_asnid   VARCHAR2(32);
    v_compid  VARCHAR2(32);
    v_sqlerrm VARCHAR2(1024);
  BEGIN
    FOR i IN (SELECT inf.asn_id,
                     inf.company_id,
                     inf.dc_company_id,
                     goo.goo_id,
                     inf.order_amount,
                     inf.pcome_amount,
                     inf.asngot_amount,
                     inf.got_amount,
                     inf.memo,
                     inf.ret_amount,
                     inf.pick_time,
                     inf.shiment_time,
                     inf.receive_time,
                     inf.warehouse_pos,
                     inf.receive_type,
                     inf.receive_msg,
                     inf.operation_flag,
                     inf.operation_type,
                     inf.is_fcl_out,
                     inf.is_qc_required,
                     inf.sorting_time,
                     inf.packcases,
                     inf.create_id,
                     inf.create_time
                FROM scmdata.t_asnorders_inf inf
               INNER JOIN scmdata.t_commodity_info goo
                  ON inf.goo_id = goo.rela_goo_id
                 AND inf.company_id = goo.company_id
               WHERE nvl(inf.leak_status, ' ') IN ('E', 'R')
               ORDER BY inf.create_time FETCH FIRST 1000 rows ONLY) LOOP
      BEGIN
        --判断是否存在于 Asnordered
        SELECT nvl(MAX(1), 0)
          INTO v_jugnum
          FROM scmdata.t_asnorders
         WHERE asn_id = i.asn_id
           AND company_id = i.company_id
           AND rownum = 1;
      
        IF v_jugnum = 0 THEN
          --新增进入 Asnordered
          INSERT INTO scmdata.t_asnorders
            (asn_id,
             company_id,
             dc_company_id,
             goo_id,
             order_amount,
             pcome_amount,
             asngot_amount,
             got_amount,
             memo,
             ret_amount,
             pick_time,
             shiment_time,
             receive_time,
             warehouse_pos,
             is_fcl_out,
             is_qc_required,
             sorting_time,
             packcases,
             create_id,
             create_time)
          VALUES
            (i.asn_id,
             i.company_id,
             i.dc_company_id,
             i.goo_id,
             i.order_amount,
             i.pcome_amount,
             i.asngot_amount,
             i.got_amount,
             i.memo,
             i.ret_amount,
             i.pick_time,
             i.shiment_time,
             i.receive_time,
             i.warehouse_pos,
             i.is_fcl_out,
             i.is_qc_required,
             i.sorting_time,
             i.packcases,
             i.create_id,
             i.create_time);
        
          --修改 Asnordered_inf 缺失状态为成功
          UPDATE scmdata.t_asnorders_inf
             SET leak_status = 'S'
           WHERE asn_id = i.asn_id
             AND company_id = i.company_id;
        END IF;
      EXCEPTION
        WHEN OTHERS THEN
          --缺失错误信息赋值
          v_sqlerrm := substr(dbms_utility.format_error_stack, 1, 1024);
        
          --修改 Asnordered_inf 缺失状态为失败，并记录缺失错误信息
          UPDATE scmdata.t_asnorders_inf
             SET leak_status  = 'E',
                 leak_errinfo = v_sqlerrm
           WHERE asn_id = v_asnid
             AND company_id = v_compid;
        
          --异常后继续循环
          CONTINUE;
      END;
    END LOOP;
  END p_asnleak_asnorders_inf_sync;

  /*=================================================================================
    
    包:
      pkg_panda_asn(熊猫Asn包)
    
    过程名:
      【Asn遗漏】 Asnorders_inf表数据同步
    
     版本:
       2023-03-14: Asnorders_inf表数据同步
    
  =================================================================================*/
  PROCEDURE p_asnleak_asnordersitem_inf_sync IS
    v_jugnum  NUMBER(1);
    v_asnid   VARCHAR2(32);
    v_gooid   VARCHAR2(32);
    v_barcode VARCHAR2(32);
    v_compid  VARCHAR2(32);
    v_sqlerrm VARCHAR2(1024);
  BEGIN
    FOR i IN (SELECT inf.asn_id,
                     inf.company_id,
                     inf.dc_company_id,
                     goo.goo_id,
                     inf.barcode,
                     inf.order_amount,
                     inf.pcome_amount,
                     inf.asngot_amount,
                     inf.got_amount,
                     inf.ret_amount,
                     inf.pick_time,
                     inf.shipment_time,
                     inf.receive_time,
                     inf.warehouse_pos,
                     inf.memo,
                     inf.packcases,
                     inf.create_id,
                     inf.create_time
                FROM scmdata.t_asnordersitem_inf inf
               INNER JOIN scmdata.t_commodity_info goo
                  ON inf.goo_id = goo.rela_goo_id
                 AND inf.company_id = goo.company_id
               WHERE nvl(inf.leak_status, ' ') IN ('E', 'R')
               ORDER BY inf.create_time FETCH FIRST 3000 rows ONLY) LOOP
      BEGIN
        --变量赋值
        v_asnid   := i.asn_id;
        v_gooid   := i.goo_id;
        v_barcode := i.barcode;
        v_compid  := i.company_id;
      
        --判断是否存在于 Asnordered
        SELECT nvl(MAX(1), 0)
          INTO v_jugnum
          FROM scmdata.t_asnordersitem
         WHERE asn_id = i.asn_id
           AND goo_id = i.goo_id
           AND nvl(barcode, ' ') = nvl(i.barcode, ' ')
           AND company_id = i.company_id
           AND rownum = 1;
      
        IF v_jugnum = 0 THEN
          --新增进入 Asnordered
          INSERT INTO scmdata.t_asnordersitem
            (asn_id,
             company_id,
             dc_company_id,
             goo_id,
             barcode,
             order_amount,
             pcome_amount,
             asngot_amount,
             got_amount,
             ret_amount,
             pick_time,
             shipment_time,
             receive_time,
             warehouse_pos,
             memo,
             packcases,
             create_id,
             create_time)
          VALUES
            (i.asn_id,
             i.company_id,
             i.dc_company_id,
             i.goo_id,
             i.barcode,
             i.order_amount,
             i.pcome_amount,
             i.asngot_amount,
             i.got_amount,
             i.ret_amount,
             i.pick_time,
             i.shipment_time,
             i.receive_time,
             i.warehouse_pos,
             i.memo,
             i.packcases,
             i.create_id,
             i.create_time);
        
          --修改 Asnordered_inf 缺失状态为成功
          UPDATE scmdata.t_asnordersitem_inf
             SET leak_status = 'S'
           WHERE asn_id = i.asn_id
             AND company_id = i.company_id;
        END IF;
      EXCEPTION
        WHEN OTHERS THEN
          --缺失错误信息赋值
          v_sqlerrm := substr(dbms_utility.format_error_stack, 1, 1024);
        
          --修改 Asnordered_inf 缺失状态为失败，并记录缺失错误信息
          UPDATE scmdata.t_asnordersitem_inf
             SET leak_status  = 'E',
                 leak_errinfo = v_sqlerrm
           WHERE asn_id = v_asnid
             AND goo_id = v_gooid
             AND nvl(barcode, ' ') = nvl(v_barcode, ' ')
             AND company_id = v_compid;
        
          --异常后继续循环
          CONTINUE;
      END;
    END LOOP;
  END p_asnleak_asnordersitem_inf_sync;

  /*=================================================================================
          
    包:
      pkg_panda_asn(熊猫Asn包)
          
    过程名:
      【Asn遗漏】通过 Asnordered / Asnorders 同步交货记录
      
    入参:
      v_inp_asnid   :  Asn单号
      v_inp_compid  :  企业Id
        
    版本:
      2023-03-29: 通过 Asnordered / Asnorders 同步交货记录
          
  =================================================================================*/
  PROCEDURE p_sync_delivery_record_by_asnorder(v_inp_asnid  IN VARCHAR2,
                                               v_inp_compid IN VARCHAR2) IS
    v_delivery_record_id   VARCHAR2(32);
    v_delivery_record_code VARCHAR2(32);
    v_delivery_rec         scmdata.t_delivery_record%ROWTYPE;
    v_send_by_sup          NUMBER(1);
    v_finish_time          DATE;
  BEGIN
    FOR x IN (SELECT b.goo_id,
                     a.order_id,
                     a.create_time,
                     a.create_id,
                     a.memo,
                     a.scan_time,
                     b.receive_time,
                     b.pick_time,
                     b.shiment_time,
                     a.asn_id,
                     b.pcome_amount,
                     b.got_amount,
                     nvl(b.got_amount, 0) + nvl(b.ret_amount, 0) receive_amount,
                     a.end_acc_time,
                     b.is_fcl_out,
                     b.is_qc_required,
                     o.send_by_sup,
                     b.sorting_time,
                     a.pcome_date,
                     b.asn_documents_status,
                     b.packcases
                FROM scmdata.t_asnordered a
               INNER JOIN scmdata.t_asnorders b
                  ON a.asn_id = b.asn_id
                 AND a.company_id = b.company_id
               INNER JOIN scmdata.t_ordered o
                  ON o.order_code = a.order_id
                 AND a.company_id = o.company_id
               WHERE a.company_id = v_inp_compid
                 AND a.asn_id = v_inp_asnid) LOOP
      --获取交货记录主表Id
      SELECT MAX(delivery_record_id)
        INTO v_delivery_record_id
        FROM scmdata.t_delivery_record a
       WHERE a.asn_id = v_inp_asnid
         AND a.goo_id = x.goo_id
         AND a.company_id = v_inp_compid;
    
      --判断
      IF v_delivery_record_id IS NULL THEN
        --当交货记录主表Id为空
        --获取是否为供应商代发， 结束时间字段
        SELECT MAX(send_by_sup), MAX(finish_time)
          INTO v_send_by_sup, v_finish_time
          FROM scmdata.t_ordered a
         WHERE a.order_code = x.order_id
           AND a.company_id = v_inp_compid;
      
        --交货记录Id赋值
        v_delivery_record_id := scmdata.f_get_uuid();
      
        --交货记录编码赋值
        v_delivery_record_code := pkg_plat_comm.f_getkeyid_plat(pi_pre     => 'DR',
                                                                pi_seqname => 'SEQ_T_DELIVERY_RECORD',
                                                                pi_seqnum  => 99);
      
        --新增交货记录
        INSERT INTO scmdata.t_delivery_record
          (delivery_record_id,
           company_id,
           delivery_record_code,
           order_code,
           ing_id,
           goo_id,
           delivery_price,
           create_id,
           create_time,
           memo,
           delivery_date,
           accept_date,
           sorting_date,
           shipment_date,
           update_id,
           update_time,
           asn_id,
           predict_delivery_amount,
           delivery_origin_time,
           delivery_origin_amount,
           delivery_amount,
           end_acc_time,
           is_fcl_out,
           is_qc_required,
           predict_delivery_date,
           asn_documents_status,
           packcases)
        VALUES
          (v_delivery_record_id,
           v_inp_compid,
           v_delivery_record_code,
           x.order_id,
           NULL,
           x.goo_id,
           0,
           x.create_id,
           x.create_time,
           x.memo,
           decode(v_send_by_sup, 1, x.sorting_time, x.scan_time),
           x.receive_time,
           x.sorting_time,
           x.shiment_time,
           x.create_id,
           x.create_time,
           x.asn_id,
           x.pcome_amount,
           decode(v_send_by_sup, 1, x.sorting_time, x.scan_time),
           x.receive_amount,
           x.got_amount,
           x.end_acc_time,
           x.is_fcl_out,
           x.is_qc_required,
           x.pcome_date,
           x.asn_documents_status,
           x.packcases);
      
        --补充同步至条码生成表
        MERGE INTO scmdata.t_delivery_record_barcode a
        USING (SELECT x.asn_id asn_id FROM dual) b
        ON (b.asn_id = a.asn_id)
        WHEN NOT MATCHED THEN
          INSERT
            (a.delivery_record_barcode_id,
             a.asn_id,
             a.create_id,
             a.create_time,
             a.generated,
             a.generate_time,
             a.barcode_file_id,
             a.pause)
          VALUES
            (scmdata.f_get_uuid(),
             b.asn_id,
             'ADMIN',
             SYSDATE,
             0,
             NULL,
             NULL,
             0);
      ELSE
        --当交货记录主表Id不为空
        UPDATE scmdata.t_delivery_record a
           SET a.memo                    = x.memo,
               a.delivery_date = CASE
                                   WHEN x.send_by_sup = 1 THEN
                                    nvl(x.sorting_time, a.delivery_date)
                                   ELSE
                                    nvl(x.scan_time, a.delivery_date)
                                 END,
               a.accept_date             = nvl(x.receive_time, a.accept_date),
               a.sorting_date            = nvl(x.sorting_time,
                                               a.sorting_date),
               a.shipment_date           = nvl(x.shiment_time,
                                               a.shipment_date),
               a.update_id               = 'ADMIN',
               a.update_time             = SYSDATE,
               a.predict_delivery_amount = x.pcome_amount,
               a.delivery_origin_time = CASE
                                          WHEN x.send_by_sup = 1 THEN
                                           nvl(x.sorting_time,
                                               a.delivery_origin_time)
                                          ELSE
                                           nvl(x.scan_time,
                                               a.delivery_origin_time)
                                        END,
               a.delivery_origin_amount  = x.receive_amount,
               a.end_acc_time            = x.end_acc_time,
               a.is_fcl_out              = x.is_fcl_out,
               a.is_qc_required          = x.is_qc_required,
               a.predict_delivery_date   = x.pcome_date,
               a.delivery_amount         = x.got_amount,
               a.order_code              = x.order_id,
               a.asn_documents_status    = x.asn_documents_status,
               a.packcases               = x.packcases
         WHERE a.asn_id = x.asn_id
           AND a.company_id = v_inp_compid
           AND a.goo_id = x.goo_id;
      END IF;
    
      --交货记录所有信息获取
      SELECT *
        INTO v_delivery_rec
        FROM scmdata.t_delivery_record a
       WHERE a.delivery_record_id = v_delivery_record_id;
    
      --同步交货记录
      scmdata.pkg_production_progress.sync_delivery_record(p_delivery_rec => v_delivery_rec);
    END LOOP;
  EXCEPTION
    WHEN dup_val_on_index THEN
      ROLLBACK;
      RETURN;
  END p_sync_delivery_record_by_asnorder;

  /*=================================================================================
          
    包:
      pkg_panda_asn(熊猫Asn包)
          
    过程名:
      【Asn遗漏】通过 Asnordersitem 同步交货记录
      
    入参:
      v_inp_asnid    :  Asn单号
      v_inp_gooid    :  商品档案编号
      v_inp_barcode  :  条码
      v_inp_compid   :  企业Id
        
    版本:
      2023-03-29: 通过 Asnordersitem 同步交货记录
          
  =================================================================================*/
  PROCEDURE p_sync_delivery_record_item_by_asnordersitem(v_inp_asnid   IN VARCHAR2,
                                                         v_inp_gooid   IN VARCHAR2,
                                                         v_inp_barcode IN VARCHAR2,
                                                         v_inp_compid  IN VARCHAR2) IS
    v_delivery_record_item_id VARCHAR2(32);
    v_delivery_record_id      VARCHAR2(32);
  BEGIN
    --判断主表是否已经进来
    SELECT MAX(a.delivery_record_id)
      INTO v_delivery_record_id
      FROM scmdata.t_delivery_record a
     WHERE a.asn_id = v_inp_asnid
       AND a.goo_id = v_inp_gooid
       AND a.company_id = v_inp_compid;
  
    IF v_delivery_record_id IS NOT NULL THEN
      FOR x IN (SELECT c.asn_id,
                       c.company_id,
                       c.dc_company_id,
                       c.goo_id,
                       c.barcode,
                       c.order_amount,
                       c.pcome_amount,
                       c.got_amount,
                       nvl(c.got_amount, 0) + nvl(c.ret_amount, 0) receive_amount,
                       c.pick_time,
                       c.shipment_time,
                       c.receive_time,
                       c.warehouse_pos,
                       c.memo,
                       c.create_id,
                       c.create_time,
                       c.update_id,
                       c.update_time,
                       c.packcases
                  FROM scmdata.t_asnordersitem c
                 WHERE c.company_id = v_inp_compid
                   AND c.goo_id = v_inp_gooid
                   AND c.barcode = v_inp_barcode
                   AND c.asn_id = v_inp_asnid) LOOP
        --获取交货记录从表Id
        SELECT MAX(delivery_record_item_id)
          INTO v_delivery_record_item_id
          FROM scmdata.t_delivery_record_item a
         WHERE a.company_id = v_inp_compid
           AND a.goo_id = v_inp_gooid
           AND a.delivery_record_id = v_delivery_record_id
           AND a.barcode = v_inp_barcode;
      
        --判断
        IF v_delivery_record_item_id IS NULL THEN
          --交货记录从表Id为空
          --交货记录从表Id赋值
          v_delivery_record_item_id := f_get_uuid();
        
          --新增进入交货记录从表
          INSERT INTO scmdata.t_delivery_record_item
            (delivery_record_item_id,
             company_id,
             goo_id,
             delivery_record_id,
             barcode,
             delivery_amount,
             create_time,
             create_id,
             predict_delivery_amount,
             delivery_origin_amount,
             packcases)
          VALUES
            (v_delivery_record_item_id,
             v_inp_compid,
             v_inp_gooid,
             v_delivery_record_id,
             v_inp_barcode,
             x.got_amount,
             SYSDATE,
             'ADMIN',
             x.pcome_amount,
             x.receive_amount,
             x.packcases);
        ELSE
          --交货记录从表不为空
          --更新交货记录从表
          UPDATE scmdata.t_delivery_record_item a
             SET a.delivery_amount         = x.got_amount,
                 a.predict_delivery_amount = x.pcome_amount,
                 a.delivery_origin_amount  = x.receive_amount,
                 a.packcases               = x.packcases
           WHERE a.company_id = v_inp_compid
             AND a.goo_id = v_inp_gooid
             AND a.delivery_record_id = v_delivery_record_id
             AND a.barcode = v_inp_barcode;
        END IF;
      
        --更新订单sku层表数据
        UPDATE scmdata.t_ordersitem a
           SET a.got_amount = nvl((SELECT SUM(ki.delivery_amount)
                                    FROM scmdata.t_delivery_record k
                                   INNER JOIN scmdata.t_delivery_record_item ki
                                      ON k.delivery_record_id =
                                         ki.delivery_record_id
                                   WHERE k.order_code =
                                         (SELECT order_code
                                            FROM scmdata.t_delivery_record
                                           WHERE delivery_record_id =
                                                 v_delivery_record_id)
                                     AND k.company_id = v_inp_compid
                                     AND k.goo_id = v_inp_gooid
                                     AND ki.barcode = v_inp_barcode),
                                  0)
         WHERE a.company_id = v_inp_compid
           AND a.goo_id = v_inp_gooid
           AND a.order_id =
               (SELECT order_code
                  FROM scmdata.t_delivery_record
                 WHERE delivery_record_id = v_delivery_record_id)
           AND a.barcode = v_inp_barcode;
      END LOOP;
    END IF;
  END p_sync_delivery_record_item_by_asnordersitem;

  /*=================================================================================
      
    包:
      pkg_panda_asn(熊猫Asn包)
      
    过程名:
      【Asn遗漏】直接刷新 Asnordered 数据
      
    入参:
      v_inp_asnid         :  Asn单号
      v_inp_compid        :  企业Id
      v_inp_status        :  Asn状态
      v_inp_ordid         :  订单号
      v_inp_pcomedate     :  预计到仓日期
      v_inp_changetimes   :  修改次数
      v_inp_scantime      :  到仓扫描时间
      v_inp_memo          :  备注
      v_inp_createid      :  创建人
      v_inp_createtime    :  创建时间
      v_inp_pcomeinterval :  预计到仓时段
      v_inp_endacctime    :  熊猫结束收货时间
      
    版本:
      2023-03-27: 直接刷新 Asnordered 数据
      
  =================================================================================*/
  PROCEDURE p_leakasn_direct_refresh_asnordered(v_inp_asnid         IN VARCHAR2,
                                                v_inp_compid        IN VARCHAR2,
                                                v_inp_status        IN VARCHAR2,
                                                v_inp_ordid         IN VARCHAR2,
                                                v_inp_pcomedate     IN DATE,
                                                v_inp_changetimes   IN NUMBER,
                                                v_inp_scantime      IN DATE,
                                                v_inp_memo          IN VARCHAR2,
                                                v_inp_createid      IN VARCHAR2,
                                                v_inp_createtime    IN DATE,
                                                v_inp_pcomeinterval IN VARCHAR2,
                                                v_inp_endacctime    IN DATE) IS
    v_jugnum  NUMBER(1);
    v_ordid   VARCHAR2(32);
    v_supcode VARCHAR2(32);
    v_sqlerrm VARCHAR2(1024);
    v_errinfo CLOB;
    v_sql     CLOB;
  BEGIN
    --判断是否存在于业务表
    SELECT nvl(MAX(1), 0), MAX(order_id)
      INTO v_jugnum, v_ordid
      FROM scmdata.t_asnordered
     WHERE asn_id = v_inp_asnid
       AND company_id = v_inp_compid;
  
    --当 Asnordered表内订单号不等于传入订单号
    IF v_jugnum = 1
       AND v_ordid <> v_inp_ordid THEN
      --通过 Asn单号删除asn相关信息
      scmdata.pkg_inf_asn.p_delete_by_asn(p_asn_id     => v_inp_asnid,
                                          p_company_id => v_inp_compid);
      v_jugnum := 0;
    END IF;
  
    --获取供应商档案编号
    SELECT MAX(supplier_code)
      INTO v_supcode
      FROM scmdata.t_ordered
     WHERE order_code = v_inp_ordid
       AND company_id = v_inp_compid;
  
    IF v_jugnum = 0 THEN
      --执行 Sql 赋值
      v_sql := 'INSERT INTO scmdata.t_asnordered 
  (asn_id, company_id, dc_company_id, status, order_id, supplier_code, pcome_date, 
   changetimes, scan_time, memo, create_id, create_time, pcome_interval, end_acc_time) 
VALUES 
  (:v_inp_asnid, :v_inp_compid, :v_inp_compid, :v_inp_status, :v_inp_ordid, :v_supcode, 
   :v_inp_pcomedate, :v_inp_changetimes, :v_inp_scantime, :v_inp_memo, :v_inp_createid, 
   :v_inp_createtime, :v_inp_pcomeinterval, :v_inp_endacctime)';
    
      --执行 Sql 
      EXECUTE IMMEDIATE v_sql
        USING v_inp_asnid, v_inp_compid, v_inp_compid, v_inp_status, v_inp_ordid, v_supcode, v_inp_pcomedate, v_inp_changetimes, v_inp_scantime, v_inp_memo, v_inp_createid, v_inp_createtime, v_inp_pcomeinterval, v_inp_endacctime;
    ELSE
      --执行 Sql 赋值
      v_sql := 'UPDATE scmdata.t_asnordered
   SET pcome_date     = :v_inp_pcomedate,
       changetimes    = :v_inp_changetimes,
       scan_time      = :v_inp_scantime,
       memo           = :v_inp_memo,
       pcome_interval = :v_inp_pcomeinterval,
       end_acc_time   = :v_inp_endacctime
 WHERE asn_id = :v_inp_asnid
   AND company_id = :v_inp_compid';
    
      --执行 Sql 
      EXECUTE IMMEDIATE v_sql
        USING v_inp_pcomedate, v_inp_changetimes, v_inp_scantime, v_inp_memo, v_inp_pcomeinterval, v_inp_endacctime, v_inp_asnid, v_inp_compid;
    END IF;
  
    --按 Asnordered 刷新
    scmdata.pkg_inf_asn.p_sync_delivery_record_by_asnorder(p_asn_id     => v_inp_asnid,
                                                           p_company_id => v_inp_compid);
  EXCEPTION
    WHEN OTHERS THEN
      --错误信息赋值
      v_sqlerrm := substr(dbms_utility.format_error_stack, 1, 1024);
      v_errinfo := 'Error Object: scmdata.pkg_asn_leak.p_leakasn_iouasnordered' ||
                   chr(10) || 'Error Info: ' || v_sqlerrm || chr(10) ||
                   'Execute_sql:' || v_sql || chr(10) || 'Params: ' ||
                   chr(10) || 'v_inp_asnid: ' || v_inp_asnid || chr(10) ||
                   'v_inp_compid: ' || v_inp_compid || chr(10) ||
                   'v_inp_status: ' || v_inp_status || chr(10) ||
                   'v_inp_ordid: ' || v_inp_ordid || chr(10) ||
                   'v_supcode: ' || v_supcode || chr(10) ||
                   'v_inp_pcomedate: ' ||
                   to_char(v_inp_pcomedate, 'yyyy-mm-dd hh24-mi-ss') ||
                   chr(10) || 'v_inp_changetimes: ' ||
                   to_char(v_inp_changetimes) || chr(10) ||
                   'v_inp_scantime: ' ||
                   to_char(v_inp_scantime, 'yyyy-mm-dd hh24-mi-ss') ||
                   chr(10) || 'v_inp_memo: ' || v_inp_memo || chr(10) ||
                   'v_inp_createid: ' || v_inp_createid || chr(10) ||
                   'v_inp_createtime: ' ||
                   to_char(v_inp_createtime, 'yyyy-mm-dd hh24-mi-ss') ||
                   chr(10) || 'v_inp_pcomeinterval: ' ||
                   v_inp_pcomeinterval || chr(10) || 'v_inp_endacctime: ' ||
                   to_char(v_inp_endacctime, 'yyyy-mm-dd hh24-mi-ss');
    
      --新增进入错误信息表
      scmdata.pkg_qa_ee.p_ins_errrecord_at(v_inp_errprogram     => 'scmdata.pkg_qa_itf.p_qamission_asnordereditfins',
                                           v_inp_causeerruserid => 'leak_asnordered',
                                           v_inp_erroccurtime   => SYSDATE,
                                           v_inp_errinfo        => v_errinfo,
                                           v_inp_compid         => v_inp_compid);
  END p_leakasn_direct_refresh_asnordered;

  /*=================================================================================
        
    包:
      pkg_panda_asn(熊猫Asn包)
        
    过程名:
      【Asn遗漏】直接刷新 Asnorders 数据
    
    入参:
      v_inp_asnid        :  Asn单号
      v_inp_compid       :  企业Id
      v_inp_relagooid    :  货号
      v_inp_orderamount  :  订单数量
      v_inp_pcomeamount  :  预计到仓数量
      v_inp_gotamount    :  到货量
      v_inp_retamount    :  退货量
      v_inp_memo         :  备注
      v_inp_isqcrequired :  是否需要质检
      v_inp_isfclout     :  是否直发
      v_inp_operid       :  操作人Id
      v_inp_opertime     :  操作时间
      
    版本:
      2023-03-27: 直接刷新 Asnorders 数据
        
  =================================================================================*/
  PROCEDURE p_leakasn_direct_refresh_asnorders(v_inp_asnid        IN VARCHAR2,
                                               v_inp_compid       IN VARCHAR2,
                                               v_inp_relagooid    IN VARCHAR2,
                                               v_inp_orderamount  IN NUMBER,
                                               v_inp_pcomeamount  IN NUMBER,
                                               v_inp_gotamount    IN NUMBER,
                                               v_inp_retamount    IN NUMBER,
                                               v_inp_memo         IN VARCHAR2,
                                               v_inp_isqcrequired IN NUMBER,
                                               v_inp_isfclout     IN NUMBER,
                                               v_inp_operid       IN VARCHAR2,
                                               v_inp_opertime     IN DATE) IS
    v_jugnum       NUMBER(1);
    v_gooid        VARCHAR2(32);
    v_warehousepos VARCHAR2(1024);
    v_receivetime  DATE;
    v_sqlerrm      VARCHAR2(1024);
    v_errinfo      CLOB;
    v_sql          CLOB;
  BEGIN
    --判断是否存在于业务表
    SELECT nvl(MAX(1), 0)
      INTO v_jugnum
      FROM scmdata.t_asnorders
     WHERE asn_id = v_inp_asnid
       AND company_id = v_inp_compid;
  
    --获取供应商档案编号
    SELECT MAX(goo_id)
      INTO v_gooid
      FROM scmdata.t_commodity_info
     WHERE rela_goo_id = v_inp_relagooid
       AND company_id = v_inp_compid;
  
    --获取库位，上架时间
    SELECT MAX(warehouse_pos), MAX(receive_time)
      INTO v_warehousepos, v_receivetime
      FROM scmdata.t_asnorders_itf
     WHERE asn_id = v_inp_asnid
       AND company_id = v_inp_compid;
  
    IF v_jugnum = 0 THEN
      --执行 Sql 赋值
      v_sql := 'INSERT INTO scmdata.t_asnorders 
  (asn_id, company_id, dc_company_id, goo_id, order_amount, 
   pcome_amount, ret_amount, got_amount, memo, create_id, create_time, 
   is_fcl_out, is_qc_required, warehouse_pos, receive_time) 
VALUES 
  (:v_inp_asnid, :v_inp_compid, :v_inp_compid, :v_gooid, :v_inp_orderamount, 
   :v_inp_pcomeamount, :v_inp_retamount, :v_inp_gotamount, :v_inp_memo, 
   :v_inp_operid, :v_inp_opertime, :v_inp_isfclout, :v_inp_isqcrequired, 
   :v_warehousepos, :v_receivetime)';
    
      --执行 Sql 
      EXECUTE IMMEDIATE v_sql
        USING v_inp_asnid, v_inp_compid, v_inp_compid, v_gooid, v_inp_orderamount, v_inp_pcomeamount, v_inp_retamount, v_inp_gotamount, v_inp_memo, v_inp_operid, v_inp_opertime, v_inp_isfclout, v_inp_isqcrequired, v_warehousepos, v_receivetime;
    ELSE
      --执行 Sql 赋值
      v_sql := 'UPDATE scmdata.t_asnorders
   SET order_amount   = :v_inp_orderamount,
       pcome_amount   = :v_inp_pcomeamount,
       got_amount     = :v_inp_gotamount,
       ret_amount     = :v_inp_retamount,
       memo           = :v_inp_memo,
       is_fcl_out     = :v_inp_isfclout,
       is_qc_required = :v_inp_isqcrequired,
       warehouse_pos  = :v_warehousepos,
       receive_time   = :v_receivetime
 WHERE asn_id = :v_inp_asnid
   AND company_id = :v_inp_compid';
    
      --执行 Sql 
      EXECUTE IMMEDIATE v_sql
        USING v_inp_orderamount, v_inp_pcomeamount, v_inp_gotamount, v_inp_retamount, v_inp_memo, v_inp_isfclout, v_inp_isqcrequired, v_warehousepos, v_receivetime, v_inp_asnid, v_inp_compid;
    END IF;
  
    --按 asnorders 刷新交货记录表
    p_sync_delivery_record_by_asnorder(v_inp_asnid  => v_inp_asnid,
                                       v_inp_compid => v_inp_compid);
  EXCEPTION
    WHEN OTHERS THEN
      --错误信息赋值
      v_sqlerrm := substr(dbms_utility.format_error_stack, 1, 1024);
      v_errinfo := 'Error Object: scmdata.pkg_asn_leak.p_leakasn_iouasnordered' ||
                   chr(10) || 'Error Info: ' || v_sqlerrm || chr(10) ||
                   'Execute_sql:' || v_sql || chr(10) || 'Params: ' ||
                   chr(10) || 'v_inp_asnid: ' || v_inp_asnid || chr(10) ||
                   'v_inp_compid: ' || v_inp_compid || chr(10) ||
                   'v_gooid: ' || v_gooid || chr(10) ||
                   'v_inp_orderamount: ' || to_char(v_inp_orderamount) ||
                   chr(10) || 'v_inp_pcomeamount: ' ||
                   to_char(v_inp_pcomeamount) || chr(10) ||
                   'v_inp_retamount: ' || to_char(v_inp_retamount) ||
                   chr(10) || 'v_inp_gotamount: ' ||
                   to_char(v_inp_gotamount) || chr(10) || 'v_inp_memo: ' ||
                   v_inp_memo || chr(10) || 'v_inp_operid: ' ||
                   v_inp_operid || chr(10) || 'v_inp_opertime: ' ||
                   to_char(v_inp_opertime, 'yyyy-mm-dd hh24-mi-ss') ||
                   chr(10) || 'v_inp_isfclout: ' || to_char(v_inp_isfclout) ||
                   chr(10) || 'v_inp_isqcrequired: ' ||
                   to_char(v_inp_isqcrequired);
    
      --新增进入错误信息表
      scmdata.pkg_qa_ee.p_ins_errrecord_at(v_inp_errprogram     => 'scmdata.pkg_panda_asn.p_leakasn_direct_refresh_asnorders',
                                           v_inp_causeerruserid => 'leak_asnorders',
                                           v_inp_erroccurtime   => SYSDATE,
                                           v_inp_errinfo        => v_errinfo,
                                           v_inp_compid         => v_inp_compid);
  END p_leakasn_direct_refresh_asnorders;

  /*=================================================================================
          
    包:
      pkg_panda_asn(熊猫Asn包)
          
    过程名:
      【Asn遗漏】直接刷新 Asnordersitem 数据
      
    入参:
      v_inp_asnid        :  Asn单号
      v_inp_compid       :  企业Id
      v_inp_relagooid    :  货号
      v_inp_barcode      :  条码
      v_inp_orderamount  :  订单数量
      v_inp_pcomeamount  :  预计到仓数量
      v_inp_gotamount    :  上架数量
      v_inp_retamount    :  退货数量
      v_inp_memo         :  备注
      v_inp_operid       :  操作人Id
      v_inp_opertime     :  操作时间
        
    版本:
      2023-03-28: 直接刷新 Asnordersitem 数据
          
  =================================================================================*/
  PROCEDURE p_leakasn_direct_refresh_asnordersitem(v_inp_asnid       IN VARCHAR2,
                                                   v_inp_compid      IN VARCHAR2,
                                                   v_inp_relagooid   IN VARCHAR2,
                                                   v_inp_barcode     IN VARCHAR2,
                                                   v_inp_orderamount IN NUMBER,
                                                   v_inp_pcomeamount IN NUMBER,
                                                   v_inp_gotamount   IN NUMBER,
                                                   v_inp_retamount   IN NUMBER,
                                                   v_inp_memo        IN VARCHAR2,
                                                   v_inp_operid      IN VARCHAR2,
                                                   v_inp_opertime    IN DATE) IS
    v_gooid        VARCHAR2(32);
    v_jugnum       NUMBER(1);
    v_warehousepos VARCHAR2(2048);
    v_receivetime  DATE;
    v_sqlerrm      VARCHAR2(1024);
    v_errinfo      CLOB;
    v_sql          CLOB;
  BEGIN
    --获取商品档案编号
    SELECT MAX(goo_id)
      INTO v_gooid
      FROM scmdata.t_commodity_info
     WHERE rela_goo_id = v_inp_relagooid
       AND company_id = v_inp_compid;
  
    --判断是否存在
    SELECT nvl(MAX(1), 0)
      INTO v_jugnum
      FROM scmdata.t_asnordersitem
     WHERE asn_id = v_inp_asnid
       AND goo_id = v_gooid
       AND nvl(barcode, ' ') = nvl(v_inp_barcode, ' ')
       AND company_id = v_inp_compid;
  
    --获取箱号，上架时间
    SELECT MAX(warehouse_pos), MAX(receive_time)
      INTO v_warehousepos, v_receivetime
      FROM scmdata.t_asnordersitem_itf
     WHERE asn_id = v_inp_asnid
       AND goo_id = v_gooid
       AND nvl(barcode, ' ') = nvl(v_inp_barcode, ' ')
       AND company_id = v_inp_compid;
  
    --判断
    IF v_jugnum = 0 THEN
      --当 Asnordersitem 不存在
      --构建执行 Sql
      v_sql := 'INSERT INTO scmdata.t_asnordersitem 
  (asn_id, company_id, dc_company_id, goo_id, barcode, order_amount, pcome_amount, ret_amount, 
   got_amount, receive_time, warehouse_pos, memo, create_id, create_time) 
VALUES 
  (:v_inp_asnid, :v_inp_compid, :v_inp_compid, :v_gooid, :v_inp_barcode, :v_inp_orderamount, 
   :v_inp_pcomeamount, :v_inp_retamount, :v_inp_gotamount, :v_receivetime, :v_warehousepos,
   :v_inp_memo, :v_inp_operid, :v_inp_opertime)';
    
      --执行 Sql
      EXECUTE IMMEDIATE v_sql
        USING v_inp_asnid, v_inp_compid, v_inp_compid, v_gooid, nvl(v_inp_barcode, ' '), v_inp_orderamount, v_inp_pcomeamount, v_inp_retamount, v_inp_gotamount, v_receivetime, v_warehousepos, v_inp_memo, v_inp_operid, v_inp_opertime;
    ELSE
      --当 Asnordersitem 存在
      --构建执行 Sql
      v_sql := 'UPDATE scmdata.t_asnordersitem
   SET order_amount  = :v_inp_orderamount,
       pcome_amount  = :v_inp_pcomeamount,
       got_amount    = :v_inp_gotamount,
       ret_amount    = :v_inp_retamount,
       receive_time  = :v_receivetime,
       warehouse_pos = :v_warehousepos,
       memo          = :v_inp_memo,
       update_id     = :v_inp_operid,
       update_time   = SYSDATE
 WHERE asn_id = :v_inp_asnid
   AND goo_id = :v_gooid
   AND nvl(barcode, '' '') = nvl(:v_inp_barcode, '' '')
   AND company_id = :v_inp_compid';
    
      --执行 Sql
      EXECUTE IMMEDIATE v_sql
        USING v_inp_orderamount, v_inp_pcomeamount, v_inp_gotamount, v_inp_retamount, v_receivetime, v_warehousepos, v_inp_memo, v_inp_operid, v_inp_asnid, v_gooid, v_inp_barcode, v_inp_compid;
    END IF;
  
    --根据 Asnordersitem 刷新
    p_sync_delivery_record_item_by_asnordersitem(v_inp_asnid   => v_inp_asnid,
                                                 v_inp_gooid   => v_gooid,
                                                 v_inp_barcode => v_inp_barcode,
                                                 v_inp_compid  => v_inp_compid);
  EXCEPTION
    WHEN OTHERS THEN
      --错误信息赋值
      v_sqlerrm := substr(dbms_utility.format_error_stack, 1, 1024);
      v_errinfo := 'Error Object: scmdata.pkg_asn_leak.p_leakasn_iouasnordered' ||
                   chr(10) || 'Error Info: ' || v_sqlerrm || chr(10) ||
                   'Execute_sql:' || v_sql || chr(10) || 'Params: ' ||
                   chr(10) || 'v_inp_asnid: ' || v_inp_asnid || chr(10) ||
                   'v_inp_compid: ' || v_inp_compid || chr(10) ||
                   'v_gooid: ' || v_gooid || chr(10) || 'v_inp_barcode: ' ||
                   v_inp_barcode || chr(10) || 'v_inp_orderamount: ' ||
                   to_char(v_inp_orderamount) || chr(10) ||
                   'v_inp_pcomeamount: ' || to_char(v_inp_pcomeamount) ||
                   chr(10) || 'v_inp_retamount: ' ||
                   to_char(v_inp_retamount) || chr(10) ||
                   'v_inp_gotamount: ' || to_char(v_inp_gotamount) ||
                   chr(10) || 'v_receivetime: ' ||
                   to_char(v_receivetime, 'yyyy-mm-dd hh24-mi-ss') ||
                   chr(10) || 'v_warehousepos: ' || v_warehousepos ||
                   chr(10) || 'v_inp_memo: ' || v_inp_memo || chr(10) ||
                   'v_inp_operid: ' || v_inp_operid || chr(10) ||
                   'v_inp_opertime: ' ||
                   to_char(v_inp_opertime, 'yyyy-mm-dd hh24-mi-ss');
    
      --新增进入错误信息表
      scmdata.pkg_qa_ee.p_ins_errrecord_at(v_inp_errprogram     => 'scmdata.pkg_panda_asn.p_leakasn_direct_refresh_asnordersitem',
                                           v_inp_causeerruserid => 'leak_asnordersitem',
                                           v_inp_erroccurtime   => SYSDATE,
                                           v_inp_errinfo        => v_errinfo,
                                           v_inp_compid         => v_inp_compid);
  END p_leakasn_direct_refresh_asnordersitem;

END pkg_panda_asn;
/

