CREATE OR REPLACE PACKAGE SCMDATA.pkg_zc_test IS

  /*=============================================================================
  
     包：
       pkg_delivery_send(送货单处理包)
  
     过程名:
       送货单接口表新增
  
     入参:
       v_inp_deliverysendinfid  :  送货单接口表Id
       v_inp_compid             :  企业id
       v_inp_ordids             :  订单号
       v_inp_operuserid         :  操作人Id
       v_inp_asnbody            :  asnordered信息
       v_inp_asnitembody        :  asnordersitem信息
       v_inp_createtime         :  创建时间
       v_inp_dealt              :  是否已处理
       v_inp_asnids             :  asn单号
  
     版本:
       2023-02-28_zc314 : 送货单接口表新增
  
  ==============================================================================*/
  PROCEDURE p_ins_delivery_send_inf(v_inp_deliverysendinfid IN VARCHAR2,
                                    v_inp_compid            IN VARCHAR2,
                                    v_inp_ordids            IN VARCHAR2,
                                    v_inp_operuserid        IN VARCHAR2,
                                    v_inp_asnbody           IN VARCHAR2,
                                    v_inp_asnitembody       IN VARCHAR2,
                                    v_inp_createtime        IN DATE,
                                    v_inp_dealt             IN NUMBER,
                                    v_inp_asnids            IN VARCHAR2);

  /*=============================================================================
    
     包：
       pkg_delivery_send(送货单处理包)
    
     过程名:
       处理无用的asn单号
    
     入参:
       v_inp_asnlist :  Asn单号
       v_inp_ordid   :  订单号
    
     版本:
       2023-02-28_zc314 : 处理无用的asn单号
    
  ==============================================================================*/
  PROCEDURE p_exclude_useless_asn(v_inp_asnlist VARCHAR2,
                                  v_inp_ordid   VARCHAR2);

  /*=============================================================================
      
     包：
       pkg_delivery_send(送货单处理包)
      
     过程名:
       删除asn单号相关信息
      
     入参:
       v_inp_asnid   :  Asn单号
       v_inp_compid  :  订单号
      
     版本:
       2023-03-01_zc314 : 删除asn单号相关信息
      
  ==============================================================================*/
  PROCEDURE p_delete_by_asn(v_inp_asnid  IN VARCHAR2,
                            v_inp_compid IN VARCHAR2);

  /*=============================================================================
      
     包：
       pkg_delivery_send(送货单处理包)
      
     过程名:
       交货记录表新增记录
      
     入参:
       v_inp_delivery_record_code    :  交货记录编码
       v_inp_order_code              :  订单号
       v_inp_ing_id                  :  进仓单号
       v_inp_goo_id                  :  商品档案编号
       v_inp_delivery_price          :  交货成本
       v_inp_delivery_amount         :  交货数量
       v_inp_create_id               :  创建人Id
       v_inp_create_time             :  创建时间
       v_inp_memo                    :  备注
       v_inp_accept_date             :  确定收货日期
       v_inp_sorting_date            :  最新分拣日期
       v_inp_delivery_date           :  交货日期 
       v_inp_shipment_date           :  发货日期
       v_inp_update_id               :  更新人Id
       v_inp_update_time             :  更新时间
       v_inp_asn_id                  :  Asn单号
       v_inp_predict_delivery_amount :  预计到货数量
       v_inp_delivery_origin_amount  :  到仓数量
       v_inp_pick_time               :  分拣时间
       v_inp_is_fcl_out              :  是否直发
       v_inp_is_qc_required          :  是否需要质检
       v_inp_predict_delivery_date   :  预计交货日期
       v_inp_end_acc_time            :  确定结束时间
       v_inp_asn_documents_status    :  Asn单据状态
       v_inp_packcases               :  包装数
       v_inp_company_id              :  企业Id
      
     版本:
       2023-03-01_zc314 : 交货记录表新增记录
      
  ==============================================================================*/
  PROCEDURE p_ins_delivery_record(v_inp_delivery_record_code    IN VARCHAR2,
                                  v_inp_order_code              IN VARCHAR2,
                                  v_inp_ing_id                  IN VARCHAR2,
                                  v_inp_goo_id                  IN VARCHAR2,
                                  v_inp_delivery_price          IN NUMBER,
                                  v_inp_delivery_amount         IN NUMBER,
                                  v_inp_create_id               IN VARCHAR2,
                                  v_inp_create_time             IN DATE,
                                  v_inp_memo                    IN VARCHAR2,
                                  v_inp_accept_date             IN DATE,
                                  v_inp_sorting_date            IN DATE,
                                  v_inp_shipment_date           IN DATE,
                                  v_inp_delivery_date           IN DATE,
                                  v_inp_update_id               IN VARCHAR2,
                                  v_inp_update_time             IN DATE,
                                  v_inp_asn_id                  IN VARCHAR2,
                                  v_inp_predict_delivery_amount IN NUMBER,
                                  v_inp_delivery_origin_amount  IN NUMBER,
                                  v_inp_pick_time               IN DATE,
                                  v_inp_is_fcl_out              IN NUMBER,
                                  v_inp_is_qc_required          IN NUMBER,
                                  v_inp_predict_delivery_date   IN DATE,
                                  v_inp_end_acc_time            IN DATE,
                                  v_inp_asn_documents_status    IN VARCHAR2,
                                  v_inp_packcases               IN VARCHAR2,
                                  v_inp_company_id              IN VARCHAR2);

  /*=============================================================================
        
     包：
       pkg_delivery_send(送货单处理包)
        
     过程名:
       交货记录Sku维度表新增记录
        
     入参:
       v_inp_deliveryrecordid       :  交货记录Sku维度表Id
       v_inp_companyid              :  企业Id
       v_inp_gooid                  :  商品档案编号
       v_inp_barcode                :  条码
       v_inp_deliveramount          :  交货数量
       v_inp_createid               :  创建人Id
       v_inp_createtime             :  创建时间
       v_inp_acceptdate             :  最新确认收货日期
       v_inp_sortingdate            :  最新分拣日期
       v_inp_shipmentdate           :  最新发货日期
       v_inp_predictdeliveryamount  :  预计交货数量
       v_inp_deliveryoriginamount   :  到仓数量
       v_inp_packcases              :  包装数
        
     版本:
       2023-03-01_zc314 : 交货记录Sku维度表新增记录
        
  ==============================================================================*/
  PROCEDURE p_ins_delivery_record_item(v_inp_deliveryrecordid      IN VARCHAR2,
                                       v_inp_companyid             IN VARCHAR2,
                                       v_inp_gooid                 IN VARCHAR2,
                                       v_inp_barcode               IN VARCHAR2,
                                       v_inp_deliveramount         IN NUMBER,
                                       v_inp_createid              IN VARCHAR2,
                                       v_inp_createtime            IN DATE,
                                       v_inp_acceptdate            IN DATE,
                                       v_inp_sortingdate           IN DATE,
                                       v_inp_shipmentdate          IN DATE,
                                       v_inp_predictdeliveryamount IN NUMBER,
                                       v_inp_deliveryoriginamount  IN NUMBER,
                                       v_inp_packcases             IN NUMBER);

  /*=============================================================================
        
     包：
       pkg_delivery_send(送货单处理包)
        
     过程名:
       交货记录 Ctl 表新增
        
     入参:
       v_inp_ctl_id           :  交货记录Ctl表Id
       v_inp_inf_id           :  数据主键
       v_inp_company_id       :  企业Id
       v_inp_order_code       :  订单号
       v_inp_ing_id           :  进仓单号
       v_inp_goo_id           :  商品档案编号
       v_inp_delivery_price   :  价格
       v_inp_delivery_amount  :  到仓数量
       v_inp_delivery_date    :  到仓时间
       v_inp_create_id        :  创建人Id
       v_inp_return_type      :  返回结果类型
       v_inp_return_msg       :  返回结果信息
       v_inp_itf_type         :  接口类型
       v_inp_sender           :  发送人Id
       v_inp_receiver         :  接收人Id
       v_inp_receive_time     :  接受时间
        
     版本:
       2023-03-01_zc314 : 交货记录 Ctl 表新增
        
  ==============================================================================*/
  PROCEDURE p_ins_delivery_record_ctl(v_inp_ctl_id          IN VARCHAR2,
                                      v_inp_inf_id          IN VARCHAR2,
                                      v_inp_company_id      IN VARCHAR2,
                                      v_inp_order_code      IN VARCHAR2,
                                      v_inp_ing_id          IN VARCHAR2,
                                      v_inp_goo_id          IN VARCHAR2,
                                      v_inp_delivery_price  IN NUMBER,
                                      v_inp_delivery_amount IN NUMBER,
                                      v_inp_delivery_date   IN DATE,
                                      v_inp_create_id       IN VARCHAR2,
                                      v_inp_return_type     IN VARCHAR2,
                                      v_inp_return_msg      IN VARCHAR2,
                                      v_inp_itf_type        IN VARCHAR2,
                                      v_inp_sender          IN VARCHAR2,
                                      v_inp_receiver        IN VARCHAR2,
                                      v_inp_receive_time    IN DATE);

  /*=============================================================================
        
     包：
       pkg_delivery_send(送货单处理包)
        
     过程名:
       交货记录相关信息新增前信息获取和数据校验
        
     入参:
       v_inp_asn_id              :  Asn单号
       v_inp_company_id          :  企业Id
       v_inp_rela_goo_id         :  货号
       v_inp_order_code          :  订单号
     
     入出参: 
       v_iop_has_itf_ex          :  Wms-Asn是否已经传入 0-未传入 1-已传入
       v_iop_order_code          :  订单号
       v_iop_goo_id              :  商品档案编号
       v_iop_delivery_record_id  :  交货记录Id
       v_iop_error_info          :  错误信息
        
     版本:
       2023-03-08_zc314 : 交货记录相关信息新增前信息获取和数据校验
        
  ==============================================================================*/
  PROCEDURE p_ins_delivery_record_rela_infoget_and_check(v_inp_asn_id             IN VARCHAR2,
                                                         v_inp_company_id         IN VARCHAR2,
                                                         v_inp_rela_goo_id        IN VARCHAR2,
                                                         v_inp_order_code         IN VARCHAR2,
                                                         v_iop_has_itf_ex         IN OUT NUMBER,
                                                         v_iop_send_by_sup        IN OUT NUMBER,
                                                         v_iop_goo_id             IN OUT VARCHAR2,
                                                         v_iop_delivery_record_id IN OUT VARCHAR2,
                                                         v_iop_error_info         IN OUT CLOB);

  /*=============================================================================
          
     包：
       pkg_delivery_send(送货单处理包)
          
     过程名:
       根据交货记录更新 Orders.got_amount 字段
          
     入参:
       v_inp_order_code   :  订单号
       v_inp_goo_id       :  商品档案编号
       v_inp_company_id   :  企业Id
          
     版本:
       2023-03-16_zc314 : 根据交货记录更新 Orders.got_amount 字段
          
  ==============================================================================*/
  PROCEDURE p_upd_ordersgotamount_from_deliveryrecord(v_inp_order_code IN VARCHAR2,
                                                      v_inp_goo_id     IN VARCHAR2,
                                                      v_inp_company_id IN VARCHAR2);

END pkg_zc_test;
/

CREATE OR REPLACE PACKAGE BODY SCMDATA.pkg_zc_test IS

  /*=============================================================================
  
     包：
       pkg_delivery_send(送货单处理包)
  
     过程名:
       送货单接口表新增
  
     入参:
       v_inp_deliverysendinfid  :  送货单接口表Id
       v_inp_compid             :  企业id
       v_inp_ordids             :  订单号
       v_inp_operuserid         :  操作人Id
       v_inp_asnbody            :  asnordered信息
       v_inp_asnitembody        :  asnordersitem信息
       v_inp_createtime         :  创建时间
       v_inp_dealt              :  是否已处理
       v_inp_asnids             :  asn单号
  
     版本:
       2023-02-28_zc314 : 送货单接口表新增
  
  ==============================================================================*/
  PROCEDURE p_ins_delivery_send_inf(v_inp_deliverysendinfid IN VARCHAR2,
                                    v_inp_compid            IN VARCHAR2,
                                    v_inp_ordids            IN VARCHAR2,
                                    v_inp_operuserid        IN VARCHAR2,
                                    v_inp_asnbody           IN VARCHAR2,
                                    v_inp_asnitembody       IN VARCHAR2,
                                    v_inp_createtime        IN DATE,
                                    v_inp_dealt             IN NUMBER,
                                    v_inp_asnids            IN VARCHAR2) IS
    v_selfdescription VARCHAR2(256) := 'scmdata.pkg_delivery_send.p_ins_delivery_send_inf';
    v_sql             CLOB;
    v_errinfo         CLOB;
    v_sqlerrm         VARCHAR2(512);
  BEGIN
    v_sql := 'INSERT INTO scmdata.t_delivery_send_inf
    (delivery_send_inf_id,
     company_id,
     ord_ids,
     oper_user_id,
     asn_body,
     asnitem_body,
     create_time,
     dealt,
     asn_ids)
  VALUES
    (:v_inp_deliverysendinfid,
     :v_inp_compid,
     :v_inp_ordids,
     :v_inp_operuserid,
     :v_inp_asnbody,
     :v_inp_asnitembody,
     :v_inp_createtime,
     :v_inp_dealt,
     :v_inp_asnids)';
  
    EXECUTE IMMEDIATE v_sql
      USING v_inp_deliverysendinfid, v_inp_compid, v_inp_ordids, v_inp_operuserid, v_inp_asnbody, v_inp_asnitembody, v_inp_createtime, v_inp_dealt, v_inp_asnids;
  
  EXCEPTION
    WHEN OTHERS THEN
      --错误信息赋值
      v_sqlerrm := substr(dbms_utility.format_error_stack, 1, 512);
    
      v_errinfo := 'Error Object:' || v_selfdescription || chr(10) ||
                   'Error Info: ' || v_sqlerrm || chr(10) || 'Execute_sql:' ||
                   v_sql || chr(10) || 'Params: ' || chr(10) ||
                   'v_inp_deliverysendinfid: ' || v_inp_deliverysendinfid ||
                   chr(10) || 'v_inp_compid: ' || v_inp_compid || chr(10) ||
                   'v_inp_ordids: ' || v_inp_ordids || chr(10) ||
                   'v_inp_operuserid: ' || v_inp_operuserid || chr(10) ||
                   'v_inp_asnbody: ' || v_inp_asnbody || chr(10) ||
                   'v_inp_asnitembody: ' || v_inp_asnitembody || chr(10) ||
                   'v_inp_createtime: ' ||
                   to_char(v_inp_createtime, 'yyyy-mmm-dd hh24-mi-ss') ||
                   chr(10) || 'v_inp_dealt: ' || to_char(v_inp_dealt) ||
                   chr(10) || 'v_inp_asnids: ' || v_inp_asnids;
    
      scmdata.pkg_qa_ee.p_ins_errrecord_at(v_inp_errprogram     => v_selfdescription,
                                           v_inp_causeerruserid => 'asn_appointment',
                                           v_inp_erroccurtime   => SYSDATE,
                                           v_inp_errinfo        => v_errinfo,
                                           v_inp_compid         => v_inp_compid);
  END p_ins_delivery_send_inf;

  /*=============================================================================
    
     包：
       pkg_delivery_send(送货单处理包)
    
     过程名:
       处理无用的asn单号
    
     入参:
       v_inp_asnlist :  Asn单号
       v_inp_ordid   :  订单号
    
     版本:
       2023-02-28_zc314 : 处理无用的asn单号
    
  ==============================================================================*/
  PROCEDURE p_exclude_useless_asn(v_inp_asnlist VARCHAR2,
                                  v_inp_ordid   VARCHAR2) IS
    v_compid          VARCHAR2(32);
    v_asnid           VARCHAR2(32);
    v_ordid           VARCHAR2(32);
    v_delivid         VARCHAR2(32);
    v_sql             CLOB;
    v_errinfo         CLOB;
    v_sqlerrm         VARCHAR2(512);
    v_selfdescription VARCHAR2(256) := 'scmdata.pkg_delivery_send.p_exclude_useless_asn';
  BEGIN
    SELECT MAX(company_id)
      INTO v_compid
      FROM scmdata.t_interface a
     WHERE a.interface_id = 'ASN_MAIN';
  
    FOR x IN (SELECT a.asn_id, a.order_code, a.delivery_record_id
                FROM scmdata.t_delivery_record a
               WHERE a.order_code = v_inp_ordid
                 AND a.company_id = v_compid
                 AND a.delivery_origin_time IS NULL
                 AND a.accept_date IS NULL
                 AND a.delivery_amount = 0
                 AND a.end_acc_time IS NULL
                 AND NOT instr(';' || v_inp_asnlist || ';',
                               ';' || a.asn_id || ';') > 0) LOOP
      BEGIN
        v_asnid   := x.asn_id;
        v_ordid   := x.order_code;
        v_delivid := x.delivery_record_id;
      
        v_sql := 'DELETE FROM scmdata.t_asnordersitem WHERE asn_id = :v_asnid AND company_id = :v_compid';
        EXECUTE IMMEDIATE v_sql
          USING v_asnid, v_compid;
      
        v_sql := 'DELETE FROM scmdata.t_asnorders WHERE asn_id = :v_asnid AND company_id = :v_compid';
        EXECUTE IMMEDIATE v_sql
          USING v_asnid, v_compid;
      
        v_sql := 'DELETE FROM scmdata.t_asnordered WHERE asn_id = :v_asnid AND company_id = :v_compid';
        EXECUTE IMMEDIATE v_sql
          USING v_asnid, v_compid;
      
        v_sql := 'DELETE FROM scmdata.t_asnordersitem_inf WHERE asn_id = :v_asnid AND company_id = :v_compid';
        EXECUTE IMMEDIATE v_sql
          USING v_asnid, v_compid;
      
        v_sql := 'DELETE FROM scmdata.t_asnorders_inf WHERE asn_id = :v_asnid AND company_id = :v_compid';
        EXECUTE IMMEDIATE v_sql
          USING v_asnid, v_compid;
      
        v_sql := 'DELETE FROM scmdata.t_asnordered_inf WHERE asn_id = :v_asnid AND company_id = :v_compid';
        EXECUTE IMMEDIATE v_sql
          USING v_asnid, v_compid;
      
        v_sql := 'DELETE FROM scmdata.t_delivery_record_item WHERE delivery_record_id = :v_delivid';
        EXECUTE IMMEDIATE v_sql
          USING v_delivid;
      
        v_sql := 'DELETE FROM scmdata.t_delivery_record WHERE delivery_record_id = :v_delivid';
        EXECUTE IMMEDIATE v_sql
          USING v_delivid;
      
        v_sql := 'DELETE FROM scmdata.t_sendorders WHERE asn_id = :v_asnid AND order_code = :v_ordid AND company_id = :v_compid';
        EXECUTE IMMEDIATE v_sql
          USING v_asnid, v_ordid, v_compid;
      
        v_sql := 'DELETE FROM scmdata.t_sendordered WHERE asn_id = :v_asnid AND order_code = :v_ordid AND company_id = :v_compid';
        EXECUTE IMMEDIATE v_sql
          USING v_asnid, v_ordid, v_compid;
      EXCEPTION
        WHEN OTHERS THEN
          --错误信息赋值
          v_sqlerrm := substr(dbms_utility.format_error_stack, 1, 512);
        
          v_errinfo := 'Error Object:' || v_selfdescription || chr(10) ||
                       'Error Info: ' || v_sqlerrm || chr(10) ||
                       'Execute_sql:' || v_sql || chr(10) || 'Params: ' ||
                       chr(10) || 'v_asnid: ' || v_asnid || chr(10) ||
                       'v_ordid: ' || v_ordid || chr(10) || 'v_delivid: ' ||
                       v_delivid || chr(10) || 'v_compid: ' || v_compid;
        
          scmdata.pkg_qa_ee.p_ins_errrecord_at(v_inp_errprogram     => v_selfdescription,
                                               v_inp_causeerruserid => 'asn_appointment',
                                               v_inp_erroccurtime   => SYSDATE,
                                               v_inp_errinfo        => v_errinfo,
                                               v_inp_compid         => v_compid);
      END;
    END LOOP;
  END p_exclude_useless_asn;

  /*=============================================================================
      
     包：
       pkg_delivery_send(送货单处理包)
      
     过程名:
       删除asn单号相关信息
      
     入参:
       v_inp_asnid   :  Asn单号
       v_inp_compid  :  订单号
      
     版本:
       2023-03-01_zc314 : 删除asn单号相关信息
      
  ==============================================================================*/
  PROCEDURE p_delete_by_asn(v_inp_asnid  IN VARCHAR2,
                            v_inp_compid IN VARCHAR2) IS
    v_sql             CLOB;
    v_errinfo         CLOB;
    v_sqlerrm         VARCHAR2(512);
    v_selfdescription VARCHAR2(256) := 'scmdata.pkg_delivery_send.p_delete_by_asn';
  BEGIN
    v_sql := 'DELETE FROM scmdata.t_asnordersitem_inf WHERE asn_id = :v_inp_asnid AND company_id = :v_inp_compid';
    EXECUTE IMMEDIATE v_sql
      USING v_inp_asnid, v_inp_compid;
  
    v_sql := 'DELETE FROM scmdata.t_asnorders_inf WHERE asn_id = :v_inp_asnid AND company_id = :v_inp_compid';
    EXECUTE IMMEDIATE v_sql
      USING v_inp_asnid, v_inp_compid;
  
    v_sql := 'DELETE FROM scmdata.t_asnordered_inf WHERE asn_id = :v_inp_asnid AND company_id = :v_inp_compid';
    EXECUTE IMMEDIATE v_sql
      USING v_inp_asnid, v_inp_compid;
  
    v_sql := 'DELETE FROM scmdata.t_asnordersitem WHERE asn_id = :v_inp_asnid AND company_id = :v_inp_compid';
    EXECUTE IMMEDIATE v_sql
      USING v_inp_asnid, v_inp_compid;
  
    v_sql := 'DELETE FROM scmdata.t_asnorders WHERE asn_id = :v_inp_asnid AND company_id = :v_inp_compid';
    EXECUTE IMMEDIATE v_sql
      USING v_inp_asnid, v_inp_compid;
  
    v_sql := 'DELETE FROM scmdata.t_asnordered WHERE asn_id = :v_inp_asnid AND company_id = :v_inp_compid';
    EXECUTE IMMEDIATE v_sql
      USING v_inp_asnid, v_inp_compid;
  
    v_sql := 'DELETE FROM scmdata.t_delivery_record_item a WHERE a.delivery_record_id IN (SELECT delivery_record_id FROM scmdata.t_delivery_record b WHERE b.asn_id = :v_inp_asnid AND b.company_id = :v_inp_compid)';
    EXECUTE IMMEDIATE v_sql
      USING v_inp_asnid, v_inp_compid;
  
    v_sql := 'DELETE FROM scmdata.t_delivery_record WHERE asn_id = :v_inp_asnid AND company_id = :v_inp_compid';
    EXECUTE IMMEDIATE v_sql
      USING v_inp_asnid, v_inp_compid;
  EXCEPTION
    WHEN OTHERS THEN
      --错误信息赋值
      v_sqlerrm := substr(dbms_utility.format_error_stack, 1, 512);
    
      v_errinfo := 'Error Object:' || v_selfdescription || chr(10) ||
                   'Error Info: ' || v_sqlerrm || chr(10) || 'Execute_sql:' ||
                   v_sql || chr(10) || 'Params: ' || chr(10) || 'v_asnid: ' ||
                   v_inp_asnid || chr(10) || 'v_compid: ' || v_inp_compid;
    
      scmdata.pkg_qa_ee.p_ins_errrecord_at(v_inp_errprogram     => v_selfdescription,
                                           v_inp_causeerruserid => 'asn_appointment',
                                           v_inp_erroccurtime   => SYSDATE,
                                           v_inp_errinfo        => v_errinfo,
                                           v_inp_compid         => v_inp_compid);
  END p_delete_by_asn;

  /*=============================================================================
      
     包：
       pkg_delivery_send(送货单处理包)
      
     过程名:
       交货记录表新增记录
      
     入参:
       v_inp_delivery_record_code    :  交货记录编码
       v_inp_order_code              :  订单号
       v_inp_ing_id                  :  进仓单号
       v_inp_goo_id                  :  商品档案编号
       v_inp_delivery_price          :  交货成本
       v_inp_delivery_amount         :  交货数量
       v_inp_create_id               :  创建人Id
       v_inp_create_time             :  创建时间
       v_inp_memo                    :  备注
       v_inp_accept_date             :  确定收货日期
       v_inp_sorting_date            :  最新分拣日期
       v_inp_delivery_date           :  交货日期 
       v_inp_shipment_date           :  发货日期
       v_inp_update_id               :  更新人Id
       v_inp_update_time             :  更新时间
       v_inp_asn_id                  :  Asn单号
       v_inp_predict_delivery_amount :  预计到货数量
       v_inp_delivery_origin_amount  :  到仓数量
       v_inp_pick_time               :  分拣时间
       v_inp_is_fcl_out              :  是否直发
       v_inp_is_qc_required          :  是否需要质检
       v_inp_predict_delivery_date   :  预计交货日期
       v_inp_end_acc_time            :  确定结束时间
       v_inp_asn_documents_status    :  Asn单据状态
       v_inp_packcases               :  包装数
       v_inp_company_id              :  企业Id
      
     版本:
       2023-03-01_zc314 : 交货记录表新增记录
      
  ==============================================================================*/
  PROCEDURE p_ins_delivery_record(v_inp_delivery_record_code    IN VARCHAR2,
                                  v_inp_order_code              IN VARCHAR2,
                                  v_inp_ing_id                  IN VARCHAR2,
                                  v_inp_goo_id                  IN VARCHAR2,
                                  v_inp_delivery_price          IN NUMBER,
                                  v_inp_delivery_amount         IN NUMBER,
                                  v_inp_create_id               IN VARCHAR2,
                                  v_inp_create_time             IN DATE,
                                  v_inp_memo                    IN VARCHAR2,
                                  v_inp_accept_date             IN DATE,
                                  v_inp_sorting_date            IN DATE,
                                  v_inp_shipment_date           IN DATE,
                                  v_inp_delivery_date           IN DATE,
                                  v_inp_update_id               IN VARCHAR2,
                                  v_inp_update_time             IN DATE,
                                  v_inp_asn_id                  IN VARCHAR2,
                                  v_inp_predict_delivery_amount IN NUMBER,
                                  v_inp_delivery_origin_amount  IN NUMBER,
                                  v_inp_pick_time               IN DATE,
                                  v_inp_is_fcl_out              IN NUMBER,
                                  v_inp_is_qc_required          IN NUMBER,
                                  v_inp_predict_delivery_date   IN DATE,
                                  v_inp_end_acc_time            IN DATE,
                                  v_inp_asn_documents_status    IN VARCHAR2,
                                  v_inp_packcases               IN VARCHAR2,
                                  v_inp_company_id              IN VARCHAR2) IS
    v_delvrecid            VARCHAR2(32);
    v_sendbysup            NUMBER(1);
    v_delivery_date        DATE;
    v_delivery_origin_time DATE;
    v_sql                  CLOB;
    v_errinfo              CLOB;
    v_sqlerrm              VARCHAR2(512);
    v_selfdescription      VARCHAR2(256) := 'scmdata.pkg_delivery_send.p_ins_delivery_record';
  BEGIN
    --判断是否是供应商代发且已结束，
    SELECT MAX(send_by_sup)
      INTO v_sendbysup
      FROM scmdata.t_ordered
     WHERE order_code = v_inp_order_code
       AND company_id = v_inp_company_id;
  
    IF v_sendbysup = 1 THEN
      v_delivery_date        := v_inp_sorting_date;
      v_delivery_origin_time := v_inp_sorting_date;
    ELSE
      v_delivery_date        := v_inp_delivery_date;
      v_delivery_origin_time := v_inp_delivery_date;
    END IF;
  
    --交货记录表Id
    v_delvrecid := scmdata.f_get_uuid();
  
    --执行 Sql 赋值
    v_sql := 'INSERT INTO scmdata.t_delivery_record
    (delivery_record_id,
     company_id,
     delivery_record_code,
     order_code,
     ing_id,
     goo_id,
     delivery_price,
     delivery_amount,
     create_id,
     create_time,
     memo,
     delivery_date,
     delivery_origin_time,
     accept_date,
     sorting_date,
     shipment_date,
     update_id,
     update_time,
     asn_id,
     predict_delivery_amount,
     delivery_origin_amount,
     pick_time,
     is_fcl_out,
     is_qc_required,
     predict_delivery_date,
     end_acc_time,
     asn_documents_status,
     packcases)
  VALUES
    (:v_inp_delivery_record_id,
     :v_inp_company_id,
     :v_inp_delivery_record_code,
     :v_inp_order_code,
     :v_inp_ing_id,
     :v_inp_goo_id,
     :v_inp_delivery_price,
     :v_inp_delivery_amount,
     :v_inp_create_id,
     :v_inp_create_time,
     :v_inp_memo,
     :v_delivery_date,
     :v_delivery_origin_time,
     :v_inp_accept_date,
     :v_inp_sorting_date,
     :v_inp_shipment_date,
     :v_inp_update_id,
     :v_inp_update_time,
     :v_inp_asn_id,
     :v_inp_predict_delivery_amount,
     :v_inp_delivery_origin_amount,
     :v_inp_pick_time,
     :v_inp_is_fcl_out,
     :v_inp_is_qc_required,
     :v_inp_predict_delivery_date,
     :v_inp_end_acc_time,
     :v_inp_asn_documents_status,
     :v_inp_packcases)';
  
    --执行 Sql
    EXECUTE IMMEDIATE v_sql
      USING v_delvrecid, v_inp_company_id, v_inp_delivery_record_code, v_inp_order_code, v_inp_ing_id, v_inp_goo_id, v_inp_delivery_price, v_inp_delivery_amount, v_inp_create_id, v_inp_create_time, v_inp_memo, v_delivery_date, v_delivery_origin_time, v_inp_accept_date, v_inp_sorting_date, v_inp_shipment_date, v_inp_update_id, v_inp_update_time, v_inp_asn_id, v_inp_predict_delivery_amount, v_inp_delivery_origin_amount, v_inp_pick_time, v_inp_is_fcl_out, v_inp_is_qc_required, v_inp_predict_delivery_date, v_inp_end_acc_time, v_inp_asn_documents_status, v_inp_packcases;
  EXCEPTION
    WHEN OTHERS THEN
      --错误信息赋值
      v_sqlerrm := substr(dbms_utility.format_error_stack, 1, 512);
    
      v_errinfo := 'Error Object:' || v_selfdescription || chr(10) ||
                   'Error Info: ' || v_sqlerrm || chr(10) || 'Execute_sql:' ||
                   v_sql || chr(10) || 'Params: ' || chr(10) ||
                   'v_delvrecid: ' || v_delvrecid || chr(10) ||
                   'v_inp_company_id: ' || v_inp_company_id || chr(10) ||
                   'v_inp_delivery_record_code: ' ||
                   v_inp_delivery_record_code || chr(10) ||
                   'v_inp_order_code: ' || v_inp_order_code || chr(10) ||
                   'v_inp_ing_id: ' || v_inp_ing_id || chr(10) ||
                   'v_inp_goo_id: ' || v_inp_goo_id || chr(10) ||
                   'v_inp_delivery_price: ' ||
                   to_char(v_inp_delivery_price) || chr(10) ||
                   'v_inp_create_id: ' || v_inp_create_id || chr(10) ||
                   'v_inp_create_time: ' ||
                   to_char(v_inp_create_time, 'yyyy-mm-dd hh24-mi-ss') ||
                   chr(10) || 'v_inp_memo: ' || v_inp_memo || chr(10) ||
                   'v_delivery_date: ' ||
                   to_char(v_delivery_date, 'yyyy-mm-dd hh24-mi-ss') ||
                   chr(10) || 'v_delivery_origin_time: ' ||
                   to_char(v_delivery_origin_time, 'yyyy-mm-dd hh24-mi-ss') ||
                   chr(10) || 'v_inp_accept_date: ' ||
                   to_char(v_inp_accept_date, 'yyyy-mm-dd hh24-mi-ss') ||
                   chr(10) || 'v_inp_sorting_date: ' ||
                   to_char(v_inp_sorting_date, 'yyyy-mm-dd hh24-mi-ss') ||
                   chr(10) || 'v_inp_shipment_date: ' ||
                   to_char(v_inp_shipment_date, 'yyyy-mm-dd hh24-mi-ss') ||
                   chr(10) || 'v_inp_update_id: ' || v_inp_update_id ||
                   chr(10) || 'v_inp_asn_id: ' || v_inp_asn_id || chr(10) ||
                   'v_inp_predict_delivery_amount: ' ||
                   to_char(v_inp_predict_delivery_amount) || chr(10) ||
                   'v_inp_delivery_origin_amount: ' ||
                   to_char(v_inp_delivery_origin_amount) || chr(10) ||
                   'v_inp_pick_time: ' ||
                   to_char(v_inp_pick_time, 'yyyy-mm-dd hh24-mi-ss') ||
                   chr(10) || 'v_inp_is_fcl_out: ' ||
                   to_char(v_inp_is_fcl_out) || chr(10) ||
                   'v_inp_is_qc_required: ' ||
                   to_char(v_inp_is_qc_required) || chr(10) ||
                   'v_inp_predict_delivery_date: ' ||
                   to_char(v_inp_predict_delivery_date,
                           'yyyy-mm-dd hh24-mi-ss') || chr(10) ||
                   'v_inp_end_acc_time: ' ||
                   to_char(v_inp_end_acc_time, 'yyyy-mm-dd hh24-mi-ss') ||
                   chr(10) || 'v_inp_asn_documents_status: ' ||
                   v_inp_asn_documents_status || chr(10) ||
                   'v_inp_packcases: ' || v_inp_packcases;
    
      --新增进入错误记录
      scmdata.pkg_qa_ee.p_ins_errrecord_at(v_inp_errprogram     => v_selfdescription,
                                           v_inp_causeerruserid => 'asn_appointment',
                                           v_inp_erroccurtime   => SYSDATE,
                                           v_inp_errinfo        => v_errinfo,
                                           v_inp_compid         => v_inp_company_id);
  END p_ins_delivery_record;

  /*=============================================================================
        
     包：
       pkg_delivery_send(送货单处理包)
        
     过程名:
       交货记录Sku维度表新增记录
        
     入参:
       v_inp_deliveryrecordid       :  交货记录Sku维度表Id
       v_inp_companyid              :  企业Id
       v_inp_gooid                  :  商品档案编号
       v_inp_barcode                :  条码
       v_inp_deliveramount          :  交货数量
       v_inp_createid               :  创建人Id
       v_inp_createtime             :  创建时间
       v_inp_acceptdate             :  最新确认收货日期
       v_inp_sortingdate            :  最新分拣日期
       v_inp_shipmentdate           :  最新发货日期
       v_inp_predictdeliveryamount  :  预计交货数量
       v_inp_deliveryoriginamount   :  到仓数量
       v_inp_packcases              :  包装数
        
     版本:
       2023-03-01_zc314 : 交货记录Sku维度表新增记录
        
  ==============================================================================*/
  PROCEDURE p_ins_delivery_record_item(v_inp_deliveryrecordid      IN VARCHAR2,
                                       v_inp_companyid             IN VARCHAR2,
                                       v_inp_gooid                 IN VARCHAR2,
                                       v_inp_barcode               IN VARCHAR2,
                                       v_inp_deliveramount         IN NUMBER,
                                       v_inp_createid              IN VARCHAR2,
                                       v_inp_createtime            IN DATE,
                                       v_inp_acceptdate            IN DATE,
                                       v_inp_sortingdate           IN DATE,
                                       v_inp_shipmentdate          IN DATE,
                                       v_inp_predictdeliveryamount IN NUMBER,
                                       v_inp_deliveryoriginamount  IN NUMBER,
                                       v_inp_packcases             IN NUMBER) IS
    v_sql             CLOB;
    v_errinfo         CLOB;
    v_sqlerrm         VARCHAR2(512);
    v_selfdescription VARCHAR2(256) := 'scmdata.pkg_delivery_send.p_ins_delivery_record_item';
  BEGIN
    --执行 Sql 赋值
    v_sql := 'INSERT INTO scmdata.t_delivery_record_item
  (delivery_record_item_id,
   delivery_record_id,
   company_id,
   goo_id,
   barcode,
   delivery_amount,
   create_id,
   create_time,
   accept_date,
   sorting_date,
   shipment_date,
   predict_delivery_amount,
   delivery_origin_amount,
   packcases)
VALUES
  (scmdata.f_get_uuid(),
   :v_inp_deliveryrecordid,
   :v_inp_companyid,
   :v_inp_gooid,
   :v_inp_barcode,
   :v_inp_deliveramount,
   :v_inp_createid,
   :v_inp_createtime,
   :v_inp_acceptdate,
   :v_inp_sortingdate,
   :v_inp_shipmentdate,
   :v_inp_predictdeliveryamount,
   :v_inp_deliveryoriginamount,
   :v_inp_packcases)';
  
    --执行 Sql
    EXECUTE IMMEDIATE v_sql
      USING v_inp_deliveryrecordid, v_inp_companyid, v_inp_gooid, v_inp_barcode, v_inp_deliveramount, v_inp_createid, v_inp_createtime, v_inp_acceptdate, v_inp_sortingdate, v_inp_shipmentdate, v_inp_predictdeliveryamount, v_inp_deliveryoriginamount, v_inp_packcases;
  EXCEPTION
    WHEN OTHERS THEN
      --错误信息赋值
      v_sqlerrm := substr(dbms_utility.format_error_stack, 1, 256);
    
      v_errinfo := 'Error Object:' || v_selfdescription || chr(10) ||
                   'Error Info: ' || v_sqlerrm || chr(10) || 'Execute_sql:' ||
                   v_sql || chr(10) || 'Params: ' || chr(10) ||
                   'v_inp_deliveryrecordid: ' || v_inp_deliveryrecordid ||
                   chr(10) || 'v_inp_companyid: ' || v_inp_companyid ||
                   chr(10) || 'v_inp_gooid: ' || v_inp_gooid || chr(10) ||
                   'v_inp_deliveramount: ' || to_char(v_inp_deliveramount) ||
                   chr(10) || 'v_inp_createid: ' || v_inp_createid ||
                   chr(10) || 'v_inp_createtime: ' ||
                   to_char(v_inp_createtime, 'yyyy-mm-dd hh24-mi-ss') ||
                   chr(10) || 'v_inp_acceptdate: ' ||
                   to_char(v_inp_acceptdate, 'yyyy-mm-dd hh24-mi-ss') ||
                   chr(10) || 'v_inp_sortingdate: ' ||
                   to_char(v_inp_sortingdate, 'yyyy-mm-dd hh24-mi-ss') ||
                   chr(10) || 'v_inp_shipmentdate: ' ||
                   to_char(v_inp_shipmentdate, 'yyyy-mm-dd hh24-mi-ss') ||
                   chr(10) || 'v_inp_predictdeliveryamount: ' ||
                   to_char(v_inp_predictdeliveryamount) || chr(10) ||
                   'v_inp_deliveryoriginamount: ' ||
                   to_char(v_inp_deliveryoriginamount) || chr(10) ||
                   'v_inp_packcases: ' || to_char(v_inp_packcases);
    
      --新增进入错误记录
      scmdata.pkg_qa_ee.p_ins_errrecord_at(v_inp_errprogram     => v_selfdescription,
                                           v_inp_causeerruserid => 'asn_appointment',
                                           v_inp_erroccurtime   => SYSDATE,
                                           v_inp_errinfo        => v_errinfo,
                                           v_inp_compid         => v_inp_companyid);
  END p_ins_delivery_record_item;

  /*=============================================================================
        
     包：
       pkg_delivery_send(送货单处理包)
        
     过程名:
       交货记录 Ctl 表新增
        
     入参:
       v_inp_ctl_id           :  交货记录Ctl表Id
       v_inp_inf_id           :  数据主键
       v_inp_company_id       :  企业Id
       v_inp_order_code       :  订单号
       v_inp_ing_id           :  进仓单号
       v_inp_goo_id           :  商品档案编号
       v_inp_delivery_price   :  价格
       v_inp_delivery_amount  :  到仓数量
       v_inp_delivery_date    :  到仓时间
       v_inp_create_id        :  创建人Id
       v_inp_return_type      :  返回结果类型
       v_inp_return_msg       :  返回结果信息
       v_inp_itf_type         :  接口类型
       v_inp_sender           :  发送人Id
       v_inp_receiver         :  接收人Id
       v_inp_receive_time     :  接受时间
        
     版本:
       2023-03-01_zc314 : 交货记录 Ctl 表新增
        
  ==============================================================================*/
  PROCEDURE p_ins_delivery_record_ctl(v_inp_ctl_id          IN VARCHAR2,
                                      v_inp_inf_id          IN VARCHAR2,
                                      v_inp_company_id      IN VARCHAR2,
                                      v_inp_order_code      IN VARCHAR2,
                                      v_inp_ing_id          IN VARCHAR2,
                                      v_inp_goo_id          IN VARCHAR2,
                                      v_inp_delivery_price  IN NUMBER,
                                      v_inp_delivery_amount IN NUMBER,
                                      v_inp_delivery_date   IN DATE,
                                      v_inp_create_id       IN VARCHAR2,
                                      v_inp_return_type     IN VARCHAR2,
                                      v_inp_return_msg      IN VARCHAR2,
                                      v_inp_itf_type        IN VARCHAR2,
                                      v_inp_sender          IN VARCHAR2,
                                      v_inp_receiver        IN VARCHAR2,
                                      v_inp_receive_time    IN DATE) IS
    v_sql             CLOB;
    v_sqlerrm         CLOB;
    v_errinfo         CLOB;
    v_selfdescription VARCHAR2(256) := 'scmdata.pkg_delivery_send.p_ins_delivery_record_ctl';
  BEGIN
    v_sql := 'INSERT INTO scmdata.t_delivery_record_ctl 
  (ctl_id,
   inf_id,
   company_id,
   order_code,
   ing_id,
   goo_id,
   delivery_price,
   delivery_amount,
   delivery_date,
   create_id,
   return_type,
   return_msg,
   itf_type,
   sender,
   receiver,
   receive_time)
VALUES
  (:v_inp_ctl_id,
   :v_inp_inf_id,
   :v_inp_company_id,
   :v_inp_order_code,
   :v_inp_ing_id,
   :v_inp_goo_id,
   :v_inp_delivery_price,
   :v_inp_delivery_amount,
   :v_inp_delivery_date,
   :v_inp_create_id,
   :v_inp_return_type,
   :v_inp_return_msg,
   :v_inp_itf_type,
   :v_inp_sender,
   :v_inp_receiver,
   :v_inp_receive_time)';
  
    EXECUTE IMMEDIATE v_sql
      USING v_inp_ctl_id, v_inp_inf_id, v_inp_company_id, v_inp_order_code, v_inp_ing_id, v_inp_goo_id, v_inp_delivery_price, v_inp_delivery_amount, v_inp_delivery_date, v_inp_create_id, v_inp_return_type, v_inp_return_msg, v_inp_itf_type, v_inp_sender, v_inp_receiver, v_inp_receive_time;
  EXCEPTION
    WHEN OTHERS THEN
      --错误信息赋值
      v_sqlerrm := substr(dbms_utility.format_error_stack, 1, 512);
    
      v_errinfo := 'Error Object:' || v_selfdescription || chr(10) ||
                   'Error Info: ' || v_sqlerrm || chr(10) || 'Execute_sql:' ||
                   v_sql || chr(10) || 'Params: ' || chr(10) ||
                   'v_inp_ctl_id: ' || v_inp_ctl_id || chr(10) ||
                   'v_inp_inf_id: ' || v_inp_inf_id || chr(10) ||
                   'v_inp_company_id: ' || v_inp_company_id || chr(10) ||
                   'v_inp_order_code: ' || v_inp_order_code || chr(10) ||
                   'v_inp_ing_id: ' || v_inp_ing_id || chr(10) ||
                   'v_inp_goo_id: ' || v_inp_goo_id || chr(10) ||
                   'v_inp_delivery_price: ' ||
                   to_char(v_inp_delivery_price) || chr(10) ||
                   'v_inp_delivery_date: ' ||
                   to_char(v_inp_delivery_date, 'yyyy-mm-dd hh24-mi-ss') ||
                   chr(10) || 'v_inp_create_id: ' || v_inp_create_id ||
                   chr(10) || 'v_inp_return_type: ' || v_inp_return_type ||
                   chr(10) || 'v_inp_return_msg: ' || v_inp_return_msg ||
                   chr(10) || 'v_inp_itf_type: ' || v_inp_itf_type ||
                   chr(10) || 'v_inp_sender: ' || v_inp_sender || chr(10) ||
                   'v_inp_receiver: ' || v_inp_receiver || chr(10) ||
                   'v_inp_receive_time: ' ||
                   to_char(v_inp_receive_time, 'yyyy-mm-dd hh24-mi-ss');
    
      --新增进入错误记录
      scmdata.pkg_qa_ee.p_ins_errrecord_at(v_inp_errprogram     => v_selfdescription,
                                           v_inp_causeerruserid => 'asn_pre_appointment',
                                           v_inp_erroccurtime   => SYSDATE,
                                           v_inp_errinfo        => v_errinfo,
                                           v_inp_compid         => v_inp_company_id);
  END p_ins_delivery_record_ctl;

  /*=============================================================================
        
     包：
       pkg_delivery_send(送货单处理包)
        
     过程名:
       交货记录相关信息新增前信息获取和数据校验
        
     入参:
       v_inp_asn_id              :  Asn单号
       v_inp_company_id          :  企业Id
       v_inp_rela_goo_id         :  货号
       v_inp_order_code          :  订单号
     
     入出参: 
       v_iop_has_itf_ex          :  Wms-Asn是否已经传入 0-未传入 1-已传入
       v_iop_order_code          :  订单号
       v_iop_goo_id              :  商品档案编号
       v_iop_delivery_record_id  :  交货记录Id
       v_iop_error_info          :  错误信息
        
     版本:
       2023-03-08_zc314 : 交货记录相关信息新增前信息获取和数据校验
        
  ==============================================================================*/
  PROCEDURE p_ins_delivery_record_rela_infoget_and_check(v_inp_asn_id             IN VARCHAR2,
                                                         v_inp_company_id         IN VARCHAR2,
                                                         v_inp_rela_goo_id        IN VARCHAR2,
                                                         v_inp_order_code         IN VARCHAR2,
                                                         v_iop_has_itf_ex         IN OUT NUMBER,
                                                         v_iop_send_by_sup        IN OUT NUMBER,
                                                         v_iop_goo_id             IN OUT VARCHAR2,
                                                         v_iop_delivery_record_id IN OUT VARCHAR2,
                                                         v_iop_error_info         IN OUT CLOB) IS
    v_order_code       VARCHAR2(32);
    v_self_description VARCHAR2(256) := 'scmdata.pkg_delivery_send.f_dual_delivery_record_if_check';
  BEGIN
    --判断 Asnordered_itf 是否存在数据
    SELECT nvl(MAX(1), 0)
      INTO v_iop_has_itf_ex
      FROM scmdata.t_asnordered_itf
     WHERE asn_id = v_inp_asn_id
       AND company_id = v_inp_company_id;
  
    --判断 Asnorders_itf 是否存在数据
    SELECT nvl(MAX(1), v_iop_has_itf_ex)
      INTO v_iop_has_itf_ex
      FROM scmdata.t_asnorders_itf
     WHERE asn_id = v_inp_asn_id
       AND company_id = v_inp_company_id;
  
    --获取商品档案编号
    SELECT MAX(goo_id)
      INTO v_iop_goo_id
      FROM scmdata.t_commodity_info
     WHERE rela_goo_id = v_inp_rela_goo_id
       AND company_id = v_inp_company_id;
  
    --获取是否供应商代发
    SELECT MAX(send_by_sup)
      INTO v_iop_send_by_sup
      FROM scmdata.t_ordered
     WHERE order_code = v_inp_order_code
       AND company_id = v_inp_company_id;
  
    --判断是否存在
    SELECT MAX(delivery_record_id), MAX(order_code)
      INTO v_iop_delivery_record_id, v_order_code
      FROM scmdata.t_delivery_record
     WHERE asn_id = v_inp_asn_id
       AND company_id = v_inp_company_id;
  
    --商品档案编号是否存在判断
    IF v_iop_goo_id IS NULL THEN
      --回传错误信息
      v_iop_error_info := 'Error Object:' || v_self_description || chr(10) ||
                          'Error Info: Asn-' || v_inp_asn_id ||
                          ' 传入货号在商品档案内未能找到数据';
    END IF;
  
    --交货记录表Id 不为空，
    IF v_iop_delivery_record_id IS NOT NULL
       AND v_inp_order_code <> v_order_code THEN
      --删除asn相关数据
      p_delete_by_asn(v_inp_asnid  => v_inp_asn_id,
                      v_inp_compid => v_inp_company_id);
    
      --交货记录Id 置空
      v_iop_delivery_record_id := NULL;
    END IF;
  END p_ins_delivery_record_rela_infoget_and_check;

  /*=============================================================================
          
     包：
       pkg_delivery_send(送货单处理包)
          
     过程名:
       根据交货记录更新 Orders.got_amount 字段
          
     入参:
       v_inp_order_code   :  订单号
       v_inp_goo_id       :  商品档案编号
       v_inp_company_id   :  企业Id
          
     版本:
       2023-03-16_zc314 : 根据交货记录更新 Orders.got_amount 字段
          
  ==============================================================================*/
  PROCEDURE p_upd_ordersgotamount_from_deliveryrecord(v_inp_order_code IN VARCHAR2,
                                                      v_inp_goo_id     IN VARCHAR2,
                                                      v_inp_company_id IN VARCHAR2) IS
    v_delivery_amount_sum NUMBER(8);
  BEGIN
    --获取交货记录总交货量
    SELECT nvl(SUM(delivery_amount), 0)
      INTO v_delivery_amount_sum
      FROM scmdata.t_delivery_record k
     WHERE order_code = v_inp_order_code
       AND goo_id = v_inp_goo_id
       AND company_id = v_inp_company_id;
  
    --更新订单总到货量
    UPDATE scmdata.t_orders
       SET got_amount = v_delivery_amount_sum
     WHERE order_id = v_inp_order_code
       AND goo_id = v_inp_goo_id
       AND company_id = v_inp_company_id;
  END p_upd_ordersgotamount_from_deliveryrecord;

END pkg_zc_test;
/

