CREATE OR REPLACE PACKAGE pkg_production_progress IS
  --校验是否已经同步生产进度
  FUNCTION check_is_sync_production_progress(po_header_rec scmdata.t_ordered%ROWTYPE)
    RETURN NUMBER;
  --订单熊猫=》接口导入=》已接单的订单=》自动同步生产进度
  PROCEDURE sync_production_progress(po_header_rec scmdata.t_ordered%ROWTYPE);
  --同步节点进度
  PROCEDURE sync_production_progress_node(po_header_rec scmdata.t_ordered%ROWTYPE,
                                          po_line_rec   scmdata.t_orders%ROWTYPE,
                                          p_produ_rec   t_production_progress%ROWTYPE,
                                          p_status      NUMBER);
  --订单接口  供应商变更，需同步更新生产订单
  PROCEDURE sync_ordered_update_product(po_header_rec scmdata.t_ordered%ROWTYPE);
  --订单接口  订单交期，成本，需同步更新生产订单计算逻辑
  PROCEDURE sync_orders_update_product(po_header_rec scmdata.t_ordered%ROWTYPE,
                                       po_line_rec   scmdata.t_orders%ROWTYPE,
                                       p_produ_rec   t_production_progress%ROWTYPE);
  --校验节点进度模板
  FUNCTION check_production_node_config(p_produ_rec t_production_progress%ROWTYPE)
    RETURN NUMBER;
  --新增节点进度
  PROCEDURE insert_production_progress_node(p_produ_rec t_production_progress%ROWTYPE);

  PROCEDURE insert_production_progress(p_produ_rec scmdata.t_production_progress%ROWTYPE);
  PROCEDURE update_production_progress(p_produ_rec scmdata.t_production_progress%ROWTYPE);
  PROCEDURE delete_production_progress(p_produ_rec scmdata.t_production_progress%ROWTYPE);
  --校验生产跟进单
  PROCEDURE check_production_progress(p_product_gress_id VARCHAR2);
  --结束订单
  PROCEDURE finish_production_progress(p_product_gress_id VARCHAR2,
                                       p_status           VARCHAR2);

  --校验是否有交货记录
  FUNCTION check_delivery_record(p_pro_rec scmdata.t_production_progress%ROWTYPE)
    RETURN NUMBER;

  --判断是否有扣款明细，有则修改订单-扣款审核状态-待审核
  PROCEDURE check_deductions(p_company_id VARCHAR2, p_order_id VARCHAR2);

  --交货记录表变更-同步至生产进度表                                     
  PROCEDURE sync_delivery_record(p_delivery_rec scmdata.t_delivery_record%ROWTYPE);
  --校验异常分类配置 返回值：模板编号
  FUNCTION check_abnormal_config(p_company_id VARCHAR2, p_goo_id VARCHAR2)
    RETURN VARCHAR2;
  --校验异常单
  PROCEDURE check_abnormal(p_abn_rec scmdata.t_abnormal%ROWTYPE);
  --新增异常单
  PROCEDURE handle_abnormal(p_abn_rec scmdata.t_abnormal%ROWTYPE);
  --更新异常单
  PROCEDURE update_abnormal(p_abn_rec scmdata.t_abnormal%ROWTYPE);
  --更新生产进度，异常单状态
  PROCEDURE sync_abnormal(p_abn_rec scmdata.t_abnormal%ROWTYPE,
                          p_status  VARCHAR2);
  --提交异常单
  PROCEDURE submit_abnormal(p_abn_rec scmdata.t_abnormal%ROWTYPE);
  --确认异常单
  PROCEDURE confirm_abnormal(p_abn_rec scmdata.t_abnormal%ROWTYPE);
  --确认异常单
  PROCEDURE revoke_abnormal(p_abn_rec scmdata.t_abnormal%ROWTYPE);
  --校验节点进度
  PROCEDURE check_production_node(pno_rec scmdata.t_production_node%ROWTYPE);
  --新增节点进度
  PROCEDURE insert_production_node(pno_rec scmdata.t_production_node%ROWTYPE);
  --计算预测交期
  PROCEDURE get_forecast_delivery_date(p_company_id          VARCHAR2,
                                       p_product_gress_id    VARCHAR2,
                                       p_progress_status     VARCHAR2,
                                       po_forecast_date      OUT DATE,
                                       po_plan_complete_date OUT DATE);
  --修改节点进度
  PROCEDURE update_production_node(pno_rec  scmdata.t_production_node%ROWTYPE,
                                   p_status NUMBER DEFAULT 0);
  --修改订单备注
  PROCEDURE update_ordered(po_rec scmdata.t_ordered%ROWTYPE);
  --扣款单审核
  PROCEDURE approve_orders(po_rec scmdata.t_ordered%ROWTYPE);
  --扣款单撤销审核
  PROCEDURE revoke_approve_orders(po_rec scmdata.t_ordered%ROWTYPE);
  --获取延期天数
  FUNCTION get_delay_days(p_arrival_date DATE, p_order_date DATE)
    RETURN NUMBER;
  --获取订单交期，生产进度表中的订单交期取下单列表的订单交期（即熊猫的交期日期）
  FUNCTION get_order_date(p_company_id VARCHAR2,
                          p_order_code VARCHAR2,
                          p_status     NUMBER) RETURN DATE;
  --获取商品单价
  FUNCTION get_order_price(p_pro_rec scmdata.t_production_progress%ROWTYPE)
    RETURN NUMBER;
  --获取扣款金额/扣款比例
  PROCEDURE get_deduction(p_company_id       VARCHAR2,
                          p_goo_id           VARCHAR2,
                          p_delay_day        NUMBER,
                          po_deduction_type  OUT VARCHAR2,
                          po_deduction_money OUT NUMBER);
  --到仓日期一致则合并，生成1条扣款单
  PROCEDURE get_date_same_deduction(p_pro_rec       scmdata.t_production_progress%ROWTYPE,
                                    p_delivery_date DATE,
                                    p_orgin         VARCHAR2,
                                    p_abnormal_id   VARCHAR2);

  --到仓日期不一致，生成1条扣款单
  PROCEDURE get_date_nsame_deduction(p_pro_rec       scmdata.t_production_progress%ROWTYPE,
                                     p_delivery_date DATE,
                                     p_orgin         VARCHAR2,
                                     p_abnormal_id   VARCHAR2);
  --校验一致的到仓日期
  FUNCTION check_delivery_date_same(p_pro_rec       scmdata.t_production_progress%ROWTYPE,
                                    p_delivery_date DATE) RETURN NUMBER;
  --校验不一致的到仓日期
  FUNCTION check_delivery_date_nsame(p_pro_rec       scmdata.t_production_progress%ROWTYPE,
                                     p_delivery_date DATE) RETURN NUMBER;

  --到仓日期一致，生成1条扣款单(内衣)
  PROCEDURE get_uwmax_date_same_deduction(p_pro_rec           scmdata.t_production_progress%ROWTYPE,
                                          p_delivery_date     DATE,
                                          p_orgin             VARCHAR2,
                                          p_abnormal_id       VARCHAR2,
                                          p_max_delivery_date DATE);

  --到仓日期不一致，生成1条扣款单(内衣)
  PROCEDURE get_uwmax_date_nsame_deduction(p_pro_rec           scmdata.t_production_progress%ROWTYPE,
                                           p_delivery_date     DATE,
                                           p_orgin             VARCHAR2,
                                           p_abnormal_id       VARCHAR2,
                                           p_max_delivery_date DATE);

  --内衣-取最迟的交货记录,仅生成1条延期扣款
  PROCEDURE get_uwmax_delivery_date(p_pro_rec       scmdata.t_production_progress%ROWTYPE,
                                    p_delivery_date DATE,
                                    p_orgin         VARCHAR2,
                                    p_abnormal_id   VARCHAR2);
  --原始到仓日期转换=》到仓确定日期
  PROCEDURE transform_delivery_date(p_delivery_rec          scmdata.t_delivery_record%ROWTYPE,
                                    p_deduction_change_time DATE);
  --原始到仓日期按配置规则进行转换=》到仓确定日期
  PROCEDURE tranf_deduction_config(p_delivery_rec scmdata.t_delivery_record%ROWTYPE);

  --订单商品（行业分类+生产类别+产品子类）与延期扣款规则配置任一模型匹配
  PROCEDURE check_deduction_config(p_company_id       VARCHAR2,
                                   p_goo_id           VARCHAR2,
                                   p_status           NUMBER,
                                   po_count           OUT NUMBER,
                                   po_ded_change_time OUT DATE);
  --自动创建的扣款单
  PROCEDURE sync_deduction(p_pro_rec     scmdata.t_production_progress%ROWTYPE,
                           p_orgin       VARCHAR2,
                           p_abnormal_id VARCHAR2);

  --生成异常单，扣款单
  PROCEDURE sync_abn_ded_bill(p_company_id         VARCHAR2,
                              p_order_id           VARCHAR2,
                              p_goo_id             VARCHAR2,
                              p_create_id          VARCHAR2,
                              p_deduction_type     VARCHAR2 DEFAULT NULL,
                              p_delay_day          NUMBER,
                              p_delay_amount       NUMBER,
                              p_order_price        NUMBER,
                              p_discount_price     NUMBER,
                              p_act_discount_price NUMBER,
                              p_orgin              VARCHAR2, --来源 系统创建 SC / 手动创建 MA
                              p_arrival_date       DATE DEFAULT NULL, --到仓日期（供打印报表使用）
                              p_abnormal_id        VARCHAR2);
  --新增扣款明细
  PROCEDURE insert_deduction(p_duc_rec scmdata.t_deduction%ROWTYPE);
END pkg_production_progress;
/
CREATE OR REPLACE PACKAGE BODY pkg_production_progress IS
  --校验是否已经同步生产进度
  FUNCTION check_is_sync_production_progress(po_header_rec scmdata.t_ordered%ROWTYPE)
    RETURN NUMBER IS
    v_flag NUMBER;
  BEGIN
    SELECT COUNT(1)
      INTO v_flag
      FROM scmdata.t_production_progress pr
     WHERE pr.company_id = po_header_rec.company_id
       AND pr.order_id = po_header_rec.order_code;
    IF v_flag > 0 THEN
      RETURN 1;
    ELSE
      RETURN 0;
    END IF;
  
  END check_is_sync_production_progress;

  /*============================================*
  * Author   : CZH
  * Created  : 2021-01-04 15:08:07
  * ALERTER  : 
  * ALERTER_TIME  : 
  * Purpose  : 订单熊猫=》接口导入=》已接单的订单=》自动同步生产进度
  * Obj_Name    : SYNC_PRODUCTION_PROGRESS
  * Arg_Number  : 1
  * PO_HEADER_REC :订单头数据
  *============================================*/
  PROCEDURE sync_production_progress(po_header_rec scmdata.t_ordered%ROWTYPE) IS
    p_produ_rec          t_production_progress%ROWTYPE; --生产进度
    v_product_gress_code VARCHAR2(100); --生产进度编码
    v_count              NUMBER; --统计一个采购订单的订单明细数
    v_approve_edition    VARCHAR2(100); --批版状态
    v_flag               NUMBER; --判断生产进度配置表是否有适用范围，有则生成节点进度，无则不用生成。
    v_rela_goo_id        VARCHAR2(100); --关联货号
    v_check_flag         NUMBER;
    v_evaluate_result    VARCHAR2(32);
  BEGIN
    --校验同步生产进度时，是否已经产生数据
    v_check_flag := check_is_sync_production_progress(po_header_rec => po_header_rec);
    IF v_check_flag = 1 THEN
      NULL;
    ELSE
      --统计货号 一个采购订单的订单明细数
      SELECT COUNT(l.goo_id)
        INTO v_count
        FROM scmdata.t_orders l
       WHERE l.company_id = po_header_rec.company_id
         AND l.order_id = po_header_rec.order_code;
      --获取订单明细
      FOR po_line_rec IN (SELECT *
                            FROM scmdata.t_orders l
                           WHERE l.company_id = po_header_rec.company_id
                             AND l.order_id = po_header_rec.order_code) LOOP
      
        --1.生产订单编号
        -- A 若一个采购订单编号只对应一个货号，则生产订单编号=采购订单编号；
        -- B 若一个采购订单编号对应多个货号，则生产订单编号=采购订单编号+关联货号
        IF v_count = 1 THEN
          v_product_gress_code := po_header_rec.order_code;
        ELSE
          SELECT tc.rela_goo_id
            INTO v_rela_goo_id
            FROM scmdata.t_commodity_info tc
           WHERE tc.company_id = po_header_rec.company_id
             AND tc.goo_id = po_line_rec.goo_id;
        
          v_product_gress_code := po_header_rec.order_code || '-' ||
                                  v_rela_goo_id;
        END IF;
      
        --2.批版状态(关于商品档案，订单模块接口导入时，数据可能会存在不同步的情况)
        /*SELECT MAX(a.approve_status)
         INTO v_approve_edition
         FROM scmdata.t_approve_version a
        WHERE a.company_id = po_header_rec.company_id
          AND a.goo_id = po_line_rec.goo_id
          AND a.approve_status = 'AS03';*/
        --修改
        SELECT MAX(approve_result)
          INTO v_approve_edition
          FROM (SELECT a.approve_result
                  FROM scmdata.t_approve_version a
                 WHERE a.company_id = po_line_rec.company_id
                   AND a.goo_id = po_line_rec.goo_id
                   AND a.approve_status <> 'AS00'
                 ORDER BY a.approve_time DESC)
         WHERE rownum < 2;
        --面料检测
        SELECT MAX(a.evaluate_result)
          INTO v_evaluate_result
          FROM scmdata.t_fabric_evaluate a
         WHERE a.company_id = po_line_rec.company_id
           AND a.goo_id = po_line_rec.goo_id;
      
        --3.赋值
        p_produ_rec.product_gress_id   := scmdata.f_get_uuid();
        p_produ_rec.company_id         := po_header_rec.company_id;
        p_produ_rec.product_gress_code := v_product_gress_code; --生产订单编号
        p_produ_rec.order_id           := po_header_rec.order_code;
        p_produ_rec.progress_status    := '00'; --生产进度状态  初始值：未开始
        p_produ_rec.goo_id             := po_line_rec.goo_id;
        p_produ_rec.supplier_code      := po_header_rec.supplier_code;
        p_produ_rec.factory_code       := po_line_rec.factory_code;
        --p_produ_rec.forecast_delivery_date       := po_line_rec.delivery_date; --预测交期  :A.生产进度状态为未开始，且计划完成日期为空时，预测交期=订单交期；
        p_produ_rec.forecast_delivery_date       := po_header_rec.delivery_date;
        p_produ_rec.forecast_delay_day           := 0; --预测延误天数  初始0 其他按天数向上取整  ceil(sysdate - to_date('2020-11-13','YYYY-MM-DD'))
        p_produ_rec.actual_delivery_date         := '';
        p_produ_rec.actual_delay_day             := 0;
        p_produ_rec.latest_planned_delivery_date := get_order_date(p_company_id => po_header_rec.company_id,
                                                                   p_order_code => po_header_rec.order_code,
                                                                   p_status     => 2);
        p_produ_rec.order_amount                 := po_line_rec.order_amount;
        p_produ_rec.delivery_amount              := 0;
        p_produ_rec.approve_edition              := v_approve_edition; --取最新批版结果
        p_produ_rec.fabric_check                 := v_evaluate_result; --面料检测 还未开发此模块，暂不处理，默认为空
        p_produ_rec.qc_quality_check             := ''; --二期
        p_produ_rec.exception_handle_status      := '00';
        p_produ_rec.handle_opinions              := ''; --初始为空
        p_produ_rec.create_id                    := po_header_rec.create_id;
        p_produ_rec.create_time                  := SYSDATE;
        p_produ_rec.origin                       := 'SC';
        p_produ_rec.memo                         := '';
        p_produ_rec.qc_check                     := ''; --暂时没有
        p_produ_rec.qa_check                     := ''; --暂时没有
      
        --4.生成生产进度
        insert_production_progress(p_produ_rec => p_produ_rec);
      
        --5.判断生产进度配置表是否有适用范围(同时校验是否停用)，有则生成节点进度，无则不用生成。
      
        v_flag := check_production_node_config(p_produ_rec => p_produ_rec);
      
        --6.同步生成节点进度
        IF v_flag = 1 THEN
        
          sync_production_progress_node(po_header_rec => po_header_rec,
                                        po_line_rec   => po_line_rec,
                                        p_produ_rec   => p_produ_rec,
                                        p_status      => 0);
        
        END IF;
      
      --7.生成qc汇总检测表
      /*scmdata.pkg_a_qcqa.p_create_goo_collect(p_goo_id     => po_line_rec.goo_id,
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  p_company_id => po_line_rec.company_id);*/
      END LOOP;
    END IF;
  
  END sync_production_progress;

  /*============================================*
  * Author   : CZH
  * Created  : 2021-01-04 15:09:13
  * ALERTER  : 
  * ALERTER_TIME  : 
  * Purpose  : 同步生成节点进度
  * Obj_Name    : SYNC_PRODUCTION_PROGRESS_NODE
  * Arg_Number  : 2
  * PO_HEADER_REC :订单头数据
  * po_line_rec ：订单明细
  * P_PRODU_REC :生产订单数据
  * p_status     : 订单接口数据：新增 0 / 修改 1
  *============================================*/
  PROCEDURE sync_production_progress_node(po_header_rec scmdata.t_ordered%ROWTYPE,
                                          po_line_rec   scmdata.t_orders%ROWTYPE,
                                          p_produ_rec   t_production_progress%ROWTYPE,
                                          p_status      NUMBER) IS
    pno_rec             scmdata.t_production_node%ROWTYPE;
    v_product_node_code VARCHAR2(100);
    --下一个节点的目标完成日期,初始值为交货-目标完成日期 
    v_target_completion_time DATE;
    --生产周期 
    v_product_cycle NUMBER;
    --下一个节点的节点周期 ,初始值为交货-节点周期 
    v_node_cycle NUMBER;
    --生产进度通过货号=》商品档案 =》找商品档案编号=》找到商品档案相应的分类，生产类别，子类 =》生产节点配置=》对应节点模板的使用范围 =》 节点配置模板数据
    CURSOR pno_cur IS
      SELECT pn.progress_node_config_id,
             pn.progress_node_num,
             pn.progress_node_name,
             pn.time_ratio,
             row_number() over(ORDER BY pn.progress_node_num ASC) node_num --增加重新排序 ：节点配置会被停用导致progress_node_num 跳号
        FROM scmdata.t_commodity_info tc
       INNER JOIN scmdata.t_progress_range_config pr
          ON tc.company_id = pr.company_id
         AND tc.category = pr.industry_classification
         AND tc.product_cate = pr.production_category
         AND instr(';' || pr.product_subclass || ';',
                   ';' || tc.samll_category || ';') > 0
         AND pr.pause = 0
       INNER JOIN scmdata.t_progress_node_config pn
          ON pr.company_id = pn.company_id
         AND pr.progress_config_id = pn.progress_config_id
         AND pn.pause = 0
       INNER JOIN scmdata.t_progress_config pg
          ON pg.company_id = pn.company_id
         AND pg.progress_config_id = pn.progress_config_id
         AND pg.pause = 0
       WHERE tc.company_id = p_produ_rec.company_id
         AND tc.goo_id = p_produ_rec.goo_id
       ORDER BY pn.progress_node_num DESC; --按节点倒推
  
  BEGIN
    --0.生产周期 订单交期与下单日期为同一天，则计算生产周期为1,否则 生产周期 = 订单交期-接单日期
    SELECT decode(trunc(po_header_rec.delivery_date),
                  trunc(po_header_rec.create_time),
                  1,
                  ceil(trunc(po_header_rec.delivery_date) -
                       trunc(po_header_rec.create_time)))
      INTO v_product_cycle
      FROM dual;
  
    FOR pnode_rec IN pno_cur LOOP
    
      --1.节点进度-目标完成日期计算规则：
      IF pnode_rec.progress_node_name = '交货' THEN
        --1.1 按节点倒推，最后一个节点为固定值“交货”，目标完成日期=订单交期；
        v_target_completion_time := trunc(po_header_rec.delivery_date);
        --节点周期=生产周期*该节点用时占比
        v_node_cycle := ceil(v_product_cycle * pnode_rec.time_ratio * 0.01);
      ELSE
        --1.2 其余节点的目标完成日期=下一个节点的目标完成日期-下一个节点的节点周期。       
        v_target_completion_time := v_target_completion_time - v_node_cycle;
        --节点周期=生产周期*当前节点用时占比
        v_node_cycle := ceil(v_product_cycle * pnode_rec.time_ratio * 0.01);
      END IF;
      --2.订单接口-新增
      IF p_status = 0 THEN
        --2.1 生产节点进度编号 
        v_product_node_code := scmdata.pkg_plat_comm.f_getkeycode(pi_table_name  => 't_production_node', --表名
                                                                  pi_column_name => 'product_node_code', --列名
                                                                  pi_company_id  => p_produ_rec.company_id, --公司编号
                                                                  pi_pre         => 'PN', --前缀
                                                                  pi_serail_num  => 6);
        --2.2 赋值
        pno_rec.product_node_id        := scmdata.f_get_uuid();
        pno_rec.company_id             := p_produ_rec.company_id;
        pno_rec.product_gress_id       := p_produ_rec.product_gress_id;
        pno_rec.product_node_code      := v_product_node_code;
        pno_rec.node_num               := pnode_rec.node_num; --节点序号
        pno_rec.node_name              := pnode_rec.progress_node_name; --节点名称
        pno_rec.time_ratio             := pnode_rec.time_ratio; --用时占比
        pno_rec.target_completion_time := v_target_completion_time; --目标完成时间，自动计算
        pno_rec.plan_completion_time   := ''; --计划完成时间 
        pno_rec.actual_completion_time := ''; --实际完成时间 
        pno_rec.complete_amount        := ''; --完成数量 
        pno_rec.progress_status        := ''; --节点进度状态
        pno_rec.progress_say           := ''; --进度说明 
        pno_rec.update_id              := '';
        pno_rec.update_date            := '';
        pno_rec.create_id              := p_produ_rec.create_id;
        pno_rec.create_time            := SYSDATE;
        pno_rec.memo                   := '';
      
        --2.3 同步节点进度
        insert_production_node(pno_rec => pno_rec);
        --3.订单接口-修改（触发器实现）
      ELSIF p_status = 1 THEN
        --4.同步节点进度
        UPDATE scmdata.t_production_node pn
           SET pn.target_completion_time = v_target_completion_time
         WHERE pn.company_id = p_produ_rec.company_id
           AND pn.product_gress_id = p_produ_rec.product_gress_id
           AND pn.node_name = pnode_rec.progress_node_name;
      
      END IF;
    END LOOP;
    --COMMIT;
  END sync_production_progress_node;

  --订单接口  供应商变更，需同步更新生产订单（供ordered触发器调用）
  PROCEDURE sync_ordered_update_product(po_header_rec scmdata.t_ordered%ROWTYPE) IS
  BEGIN
    --1.供应商变更 ：更新生产进度-供应商编号
    UPDATE scmdata.t_production_progress pr
       SET pr.supplier_code = po_header_rec.supplier_code
     WHERE pr.company_id = po_header_rec.company_id
       AND pr.order_id = po_header_rec.order_code;
  
  END sync_ordered_update_product;

  --订单接口  订单交期，成本需同步更新生产订单计算逻辑（供orders触发器调用）  触发器禁用：原订单交期变更（订单明细最新交期）
  PROCEDURE sync_orders_update_product(po_header_rec scmdata.t_ordered%ROWTYPE,
                                       po_line_rec   scmdata.t_orders%ROWTYPE,
                                       p_produ_rec   t_production_progress%ROWTYPE) IS
    v_flag NUMBER;
  BEGIN
    --1.订单交期变更：更新生产进度-预测交期，需校验生产进度状态是否为未开始，且计划完成日期为空时，预测交期=订单交期；
  
    SELECT COUNT(1)
      INTO v_flag
      FROM scmdata.t_production_progress pr
     INNER JOIN scmdata.t_production_node pn
        ON pr.company_id = pn.company_id
       AND pr.product_gress_id = pn.product_gress_id
     WHERE pr.company_id = po_line_rec.company_id
       AND pr.order_id = po_line_rec.order_id
       AND pr.goo_id = po_line_rec.goo_id
       AND pr.progress_status = '00'
       AND pn.plan_completion_time IS NULL;
  
    IF v_flag > 0 THEN
      UPDATE scmdata.t_production_progress pr
         SET pr.forecast_delivery_date = po_header_rec.delivery_date
       WHERE pr.company_id = po_line_rec.company_id
         AND pr.order_id = po_line_rec.order_id
         AND pr.goo_id = po_line_rec.goo_id;
    END IF;
  
    --2.下单生产进度表-节点进度 目标完成时间
  
    sync_production_progress_node(po_header_rec => po_header_rec,
                                  po_line_rec   => po_line_rec,
                                  p_produ_rec   => p_produ_rec,
                                  p_status      => 1);
  
  END sync_orders_update_product;

  --校验节点进度模板
  FUNCTION check_production_node_config(p_produ_rec t_production_progress%ROWTYPE)
    RETURN NUMBER IS
    v_flag       NUMBER; --节点模板存在标志
    v_range_flag NUMBER; --适用范围存在标志
  BEGIN
    --1.同步节点进度 
    --节点模板
    SELECT COUNT(1)
      INTO v_flag
      FROM scmdata.t_commodity_info tc
     INNER JOIN scmdata.t_progress_range_config pr
        ON tc.company_id = pr.company_id
       AND tc.category = pr.industry_classification
       AND tc.product_cate = pr.production_category
       AND instr(';' || pr.product_subclass || ';',
                 ';' || tc.samll_category || ';') > 0
     INNER JOIN scmdata.t_progress_node_config pn
        ON pr.company_id = pn.company_id
       AND pr.progress_config_id = pn.progress_config_id
     INNER JOIN scmdata.t_progress_config pg
        ON pg.company_id = pn.company_id
       AND pg.progress_config_id = pn.progress_config_id
       AND pg.pause = 0
     WHERE tc.company_id = p_produ_rec.company_id
       AND tc.goo_id = p_produ_rec.goo_id;
  
    IF v_flag > 0 THEN
      --适用范围
      SELECT COUNT(1)
        INTO v_range_flag
        FROM scmdata.t_commodity_info tc
       INNER JOIN scmdata.t_progress_range_config pr
          ON tc.company_id = pr.company_id
         AND tc.category = pr.industry_classification
         AND tc.product_cate = pr.production_category
         AND instr(';' || pr.product_subclass || ';',
                   ';' || tc.samll_category || ';') > 0
         AND pr.pause = 0
       INNER JOIN scmdata.t_progress_node_config pn
          ON pr.company_id = pn.company_id
         AND pr.progress_config_id = pn.progress_config_id
       INNER JOIN scmdata.t_progress_config pg
          ON pg.company_id = pn.company_id
         AND pg.progress_config_id = pn.progress_config_id
         AND pg.pause = 0
       WHERE tc.company_id = p_produ_rec.company_id
         AND tc.goo_id = p_produ_rec.goo_id;
    
      IF v_range_flag > 0 THEN
        RETURN 1;
      ELSE
        RETURN 0;
      END IF;
    ELSE
      RETURN 0;
    END IF;
  
  END check_production_node_config;

  --生产节点模板
  PROCEDURE insert_production_progress_node(p_produ_rec t_production_progress%ROWTYPE) IS
    v_flag        NUMBER;
    po_header_rec scmdata.t_ordered%ROWTYPE;
    po_line_rec   scmdata.t_orders%ROWTYPE;
  BEGIN
    --1.判断该生产进度是否有节点进度，有则，提示不用生成节点。
    --2.无则判断节点进度配置表是否存在模板，存在生成节点进度，不存在则提示，请联系管理员配置
    SELECT COUNT(1)
      INTO v_flag
      FROM scmdata.t_production_node pn
     WHERE pn.company_id = p_produ_rec.company_id
       AND pn.product_gress_id = p_produ_rec.product_gress_id;
  
    IF v_flag > 0 THEN
      raise_application_error(-20002,
                              '已存在节点进度，不能重复生成节点进度！');
    ELSE
      --3.判断生产进度配置表是否有适用范围，有则生成节点进度，无则不用生成。
      --3.1
      v_flag := check_production_node_config(p_produ_rec => p_produ_rec);
    
      --4.同步生成节点进度
      IF v_flag = 1 THEN
        SELECT *
          INTO po_header_rec
          FROM scmdata.t_ordered po
         WHERE po.company_id = p_produ_rec.company_id
           AND po.order_code = p_produ_rec.order_id;
      
        SELECT *
          INTO po_line_rec
          FROM scmdata.t_orders pln
         WHERE pln.company_id = p_produ_rec.company_id
           AND pln.order_id = p_produ_rec.order_id
           AND pln.goo_id = p_produ_rec.goo_id;
      
        sync_production_progress_node(po_header_rec => po_header_rec,
                                      po_line_rec   => po_line_rec,
                                      p_produ_rec   => p_produ_rec,
                                      p_status      => 0);
      
      ELSE
        raise_application_error(-20002,
                                '节点进度配置不存在或已禁用，请联系管理员配置！');
      END IF;
    
    END IF;
  
  END insert_production_progress_node;

  /*============================================*
  * Author   : CZH
  * Created  : 2021-01-04 15:10:47
  * ALERTER  : 
  * ALERTER_TIME  : 
  * Purpose  : 新增生产进度
  * Obj_Name    : INSERT_PRODUCTION_PROGRESS
  * Arg_Number  : 1
  * P_PRODU_REC :生产订单数据
  *============================================*/
  PROCEDURE insert_production_progress(p_produ_rec scmdata.t_production_progress%ROWTYPE) IS
  BEGIN
    INSERT INTO t_production_progress
      (product_gress_id,
       company_id,
       product_gress_code,
       order_id,
       progress_status,
       goo_id,
       supplier_code,
       factory_code,
       forecast_delivery_date,
       forecast_delay_day,
       actual_delivery_date,
       actual_delay_day,
       latest_planned_delivery_date,
       order_amount,
       delivery_amount,
       approve_edition,
       fabric_check,
       qc_quality_check,
       exception_handle_status,
       handle_opinions,
       create_id,
       create_time,
       origin,
       memo,
       qc_check,
       qa_check)
    VALUES
      (p_produ_rec.product_gress_id,
       p_produ_rec.company_id,
       p_produ_rec.product_gress_code,
       p_produ_rec.order_id,
       p_produ_rec.progress_status,
       p_produ_rec.goo_id,
       p_produ_rec.supplier_code,
       p_produ_rec.factory_code,
       trunc(p_produ_rec.forecast_delivery_date),
       p_produ_rec.forecast_delay_day,
       trunc(p_produ_rec.actual_delivery_date, 'YYYY-MM-DD'),
       p_produ_rec.actual_delay_day,
       trunc(p_produ_rec.latest_planned_delivery_date),
       p_produ_rec.order_amount,
       p_produ_rec.delivery_amount,
       p_produ_rec.approve_edition,
       p_produ_rec.fabric_check,
       p_produ_rec.qc_quality_check,
       p_produ_rec.exception_handle_status,
       p_produ_rec.handle_opinions,
       p_produ_rec.create_id,
       p_produ_rec.create_time,
       p_produ_rec.origin,
       p_produ_rec.memo,
       p_produ_rec.qc_check,
       p_produ_rec.qa_check);
  END insert_production_progress;

  /*============================================*
  * Author   : CZH
  * Created  : 2021-01-04 15:11:32
  * ALERTER  : 
  * ALERTER_TIME  : 
  * Purpose  : 修改生产进度
  * Obj_Name    : UPDATE_PRODUCTION_PROGRESS
  * Arg_Number  : 1
  * P_PRODU_REC :生产订单数据
  *============================================*/

  PROCEDURE update_production_progress(p_produ_rec scmdata.t_production_progress%ROWTYPE) IS
  BEGIN
    UPDATE t_production_progress t
       SET t.progress_status              = p_produ_rec.progress_status,
           t.forecast_delivery_date       = trunc(p_produ_rec.forecast_delivery_date),
           t.latest_planned_delivery_date = trunc(p_produ_rec.latest_planned_delivery_date)
     WHERE t.product_gress_id = p_produ_rec.product_gress_id;
  
  END update_production_progress;

  /*============================================*
  * Author   : CZH
  * Created  : 2021-01-04 15:11:32
  * ALERTER  : 
  * ALERTER_TIME  : 
  * Purpose  : 删除生产进度
  * Obj_Name    : DELETE_PRODUCTION_PROGRESS
  * Arg_Number  : 1
  * P_PRODU_REC :生产订单数据
  *============================================*/
  PROCEDURE delete_production_progress(p_produ_rec scmdata.t_production_progress%ROWTYPE) IS
  BEGIN
  
    DELETE FROM t_production_progress t
     WHERE t.product_gress_id = p_produ_rec.product_gress_id;
  
  END delete_production_progress;

  --校验生产跟进单
  PROCEDURE check_production_progress(p_product_gress_id VARCHAR2) IS
    v_abn_status       NUMBER; --已处理异常单数量
    v_abn_status_tol   NUMBER; --全部异常单数量
    v_tips             VARCHAR2(1000);
    v_actual_delay_day NUMBER;
    v_count            NUMBER;
  BEGIN
    --1.结束生产订单，必须所有异常处理单全部处理完才能结束
    SELECT SUM(decode(abn.progress_status, '02', 1, 0)), COUNT(*)
      INTO v_abn_status, v_abn_status_tol
      FROM scmdata.t_abnormal abn
     INNER JOIN scmdata.t_production_progress pr
        ON abn.company_id = pr.company_id
       AND abn.order_id = pr.order_id
       AND abn.goo_id = pr.goo_id
     WHERE pr.product_gress_id = p_product_gress_id;
  
    IF v_abn_status <> v_abn_status_tol THEN
      --操作失败，存在未提交或待处理的异常处理单，
      --请检查！未提交异常处理单的账号(按账号)：FAKEINFO013，王XX、徐XX；FAKEINFO014：王XX。待处理异常处理单（不按账号）：FAKEINFO015、FAKEINFO016。
      /*WITH company_user AS
       (SELECT f.company_id, f.user_id, f.company_user_name
          FROM scmdata.sys_company_user f
         INNER JOIN scmdata.sys_user su
            ON su.user_id = f.user_id),
      abn_bill AS
       (SELECT abn.company_id,
               abn.create_id,
               abn.progress_status,
               pr.product_gress_code
          FROM scmdata.t_abnormal abn
         INNER JOIN scmdata.t_production_progress pr
            ON abn.company_id = pr.company_id
           AND abn.order_id = pr.order_id
           AND abn.goo_id = pr.goo_id
         WHERE pr.product_gress_id = p_product_gress_id)
      SELECT '操作失败，存在未提交或待处理的异常处理单，请检查！' || listagg(v.handle_bill, ';') o_handle_bill
        INTO v_tips
        FROM (SELECT nvl2(a.product_gress_code || ',' ||
                          listagg(fc.company_user_name, '、'),
                          '未提交异常处理单的账号：' || a.product_gress_code || ',' ||
                          listagg(fc.company_user_name, '、'),
                          '') handle_bill
                FROM abn_bill a
               INNER JOIN company_user fc
                  ON fc.company_id = a.company_id
                 AND fc.user_id = a.create_id
               WHERE a.progress_status = '00'
               GROUP BY a.product_gress_code
              UNION ALL
              SELECT nvl2(listagg(DISTINCT a.product_gress_code, '、'),
                          '待处理异常处理单：' ||
                          listagg(DISTINCT a.product_gress_code, '、'),
                          '') handle_bill
                FROM abn_bill a
               WHERE a.progress_status = '01') v;*/
    
      --改：操作失败，账号：A、B 存在未提交异常处理单：FAKExxxx，账号：A、B 存在待处理异常处理单：FAKEXXX，请先完成异常处理！
    
      WITH company_user AS
       (SELECT f.company_id, f.user_id, f.company_user_name
          FROM scmdata.sys_company_user f
         INNER JOIN scmdata.sys_user su
            ON su.user_id = f.user_id),
      abn_bill AS
       (SELECT abn.company_id,
               abn.create_id,
               abn.progress_status,
               pr.product_gress_code
          FROM scmdata.t_abnormal abn
         INNER JOIN scmdata.t_production_progress pr
            ON abn.company_id = pr.company_id
           AND abn.order_id = pr.order_id
           AND abn.goo_id = pr.goo_id
         WHERE pr.product_gress_id = p_product_gress_id)
      SELECT '操作失败，请检查！' || listagg(v.handle_bill, '；') o_handle_bill
        INTO v_tips
        FROM (SELECT nvl2(a.product_gress_code || '，' ||
                          listagg(DISTINCT fc.company_user_name, '、'),
                          '账号：[' || listagg(fc.company_user_name, '、') ||
                          '],存在未提交异常处理单：[' || a.product_gress_code || ']',
                          '') handle_bill
                FROM abn_bill a
               INNER JOIN company_user fc
                  ON fc.company_id = a.company_id
                 AND fc.user_id = a.create_id
               WHERE a.progress_status = '00'
               GROUP BY a.product_gress_code
              UNION ALL
              SELECT nvl2(a.product_gress_code || '，' ||
                          listagg(DISTINCT fc.company_user_name, '、'),
                          '账号：[' || listagg(fc.company_user_name, '、') ||
                          '],存在待处理异常处理单：[' || a.product_gress_code || ']',
                          '') handle_bill
                FROM abn_bill a
               INNER JOIN company_user fc
                  ON fc.company_id = a.company_id
                 AND fc.user_id = a.create_id
               WHERE a.progress_status = '01'
               GROUP BY a.product_gress_code) v;
    
      raise_application_error(-20002, v_tips);
    END IF;
    --2. 结束订单需校验实际延误天数＞2天时，延期问题分类、延期原因分类、延期原因细分、问题描述是否已填写
    --如果未填时，订单结束失败，提示用户：“订单结束失败，订单实际延误天数＞2天，请填写'"延期问题分类、延期原因分类、延期原因细分、问题描述"！“
    SELECT t.actual_delay_day,
           nvl2(t.delay_problem_class, 1, 0) +
           nvl2(t.delay_cause_class, 1, 0) +
           nvl2(t.delay_cause_detailed, 1, 0) + nvl2(t.problem_desc, 1, 0) dcount
      INTO v_actual_delay_day, v_count
      FROM scmdata.t_production_progress t
     WHERE t.product_gress_id = p_product_gress_id;
  
    --2.1 如果未填时，订单结束失败，提示用户：“订单结束失败，订单实际延误天数＞2天，请填写'"延期问题分类、延期原因分类、延期原因细分、问题描述"！“（舍弃）
    --需求更改：结束订单时，实际延误天数＞0天时校验。
    IF v_actual_delay_day > 0 THEN
      IF v_count <> 4 THEN
        raise_application_error(-20002,
                                q'[提示：订单结束失败，订单结束失败,订单实际延误天数＞0，请填写,延期问题分类、延期原因分类、延期原因细分、问题描述！]');
      END IF;
    END IF;
  
  END check_production_progress;

  /*============================================*
  * Author   : CZH
  * Created  : 2021-01-04 15:12:27
  * ALERTER  : 
  * ALERTER_TIME  : 
  * Purpose  : 结束结束订单
  * Obj_Name    : FINISH_PRODUCTION_PROGRESS
  * Arg_Number  : 2
  * P_PRODUCT_GRESS_ID : 生产订单编号
  * P_STATUS : 生产订单状态
  *============================================*/
  PROCEDURE finish_production_progress(p_product_gress_id VARCHAR2,
                                       p_status           VARCHAR2) IS
    p_pro_rec        scmdata.t_production_progress%ROWTYPE;
    v_flag           NUMBER; --是否有 异常处理列表-已处理，是否扣款为‘是’的异常处理单
    v_delivery_flag  NUMBER; --是否有交货记录且有实际交货记录数
    v_suc_count      NUMBER; --该订单结束生产订单数量
    v_pr_tol         NUMBER; --该订单生产订单总和
    v_discount_price NUMBER; --扣款金额
    v_order_amount   NUMBER; --生产订单数量
    v_order_price    NUMBER; --“单价”指订单商品单价
    v_arrival_date   DATE; --到仓日期（供打印报表使用）
  BEGIN
    --1.校验生产订单
    pkg_production_progress.check_production_progress(p_product_gress_id => p_product_gress_id);
  
    --2.获取生产订单
    SELECT *
      INTO p_pro_rec
      FROM scmdata.t_production_progress t
     WHERE t.product_gress_id = p_product_gress_id;
  
    --3.结束订单
    IF p_pro_rec.progress_status <> p_status THEN
    
      UPDATE scmdata.t_production_progress t
         SET t.progress_status = '01'
       WHERE t.product_gress_id = p_product_gress_id;
    
      --4.判断该订单下  结束生产订单数量，生产订单数量总和
      SELECT SUM(decode(pr.progress_status, '01', 1, 0)), COUNT(1)
        INTO v_suc_count, v_pr_tol
        FROM scmdata.t_production_progress pr
       WHERE pr.company_id = p_pro_rec.company_id
         AND pr.order_id = p_pro_rec.order_id;
    
      --如结束生产订单数量 = 生产订单数量总和，说明所有生产订单已经结束，则该订单结束
      IF v_suc_count = v_pr_tol THEN
      
        --5.修改订单结束时间,以及状态
        UPDATE scmdata.t_ordered po
           SET po.order_status = 'OS02', po.finish_time_scm = SYSDATE
         WHERE po.company_id = p_pro_rec.company_id
           AND po.order_code = p_pro_rec.order_id;
      
        --6.判断是否有交货记录，有则生成相应扣款单 ，无则不作操作     
        v_delivery_flag := check_delivery_record(p_pro_rec => p_pro_rec);
      
        --7.判断是否有交货记录且实际收货记录数不能为0
        --有实际收货数量记录时,自动创建的扣款单   
        --没有实际收货数量记录时：不生成扣款记录
        IF v_delivery_flag = 1 THEN
          --8.判断是否有 异常处理列表-已处理，是否扣款为‘是’的异常处理单
          SELECT COUNT(1)
            INTO v_flag
            FROM scmdata.t_abnormal abn
           WHERE abn.company_id = p_pro_rec.company_id
             AND abn.order_id = p_pro_rec.order_id
             AND abn.progress_status = '02'
             AND abn.is_deduction = 1;
          --9.结束订单后手动创建的扣款单(质量异常、其他异常)   
          IF v_flag > 0 THEN
            FOR p_abn_rec IN (SELECT abn.abnormal_id,
                                     abn.delay_date,
                                     abn.delay_amount,
                                     abn.anomaly_class,
                                     abn.deduction_unit_price,
                                     abn.deduction_method
                                FROM scmdata.t_abnormal abn
                               WHERE abn.company_id = p_pro_rec.company_id
                                 AND abn.order_id = p_pro_rec.order_id
                                 AND abn.progress_status = '02'
                                 AND abn.is_deduction = 1) LOOP
              --计算实际收货总量
              SELECT SUM(dr.delivery_amount)
                INTO v_order_amount
                FROM scmdata.t_delivery_record dr
               WHERE dr.company_id = p_pro_rec.company_id
                 AND dr.order_code = p_pro_rec.order_id
                 AND dr.goo_id = p_pro_rec.goo_id;
            
              SELECT MAX(dr.delivery_date)
                INTO v_arrival_date
                FROM scmdata.t_delivery_record dr
               WHERE dr.company_id = p_pro_rec.company_id
                 AND dr.order_code = p_pro_rec.order_id
                 AND dr.goo_id = p_pro_rec.goo_id
                 AND dr.delivery_amount > 0;
            
              --根据异常单的异常分类，不同的扣款规则生成不同扣款单           
              --9.1交期异常
              --因业务要求：异常处理单为交期异常且是否扣款为‘是’的异常单，不手动创建扣款单。只保留质量异常的异常单。
              --9.2质量异常                    
              IF p_abn_rec.anomaly_class = 'AC_QUALITY' THEN
                --根据扣款方式进行扣款
                --质量异常扣款金额取数：            
                IF p_abn_rec.deduction_method = 'METHOD_00' THEN
                  --扣款方式为扣款单价，扣款金额=实际交货数量*扣款单价
                
                  v_discount_price := p_abn_rec.deduction_unit_price *
                                      v_order_amount;
                
                ELSIF p_abn_rec.deduction_method = 'METHOD_01' THEN
                  --扣款方式为扣款总额，直接取扣款金额
                  v_discount_price := p_abn_rec.deduction_unit_price;
                ELSE
                  NULL;
                END IF;
                --生成扣款单
                sync_abn_ded_bill(p_company_id         => p_pro_rec.company_id,
                                  p_order_id           => p_pro_rec.order_id,
                                  p_goo_id             => p_pro_rec.goo_id,
                                  p_create_id          => p_pro_rec.create_id,
                                  p_delay_day          => p_abn_rec.delay_date, --延期天数 
                                  p_delay_amount       => v_order_amount, --舍弃原有逻辑：p_abn_rec.delay_amount, --延期数量 ，改为：“质量异常，其他异常”，数量取值：订单实际收货总量
                                  p_order_price        => p_abn_rec.deduction_unit_price,
                                  p_discount_price     => v_discount_price, --扣款金额
                                  p_act_discount_price => v_discount_price, --实际扣款金额
                                  p_orgin              => 'MA', --来源 系统创建 SC / 手动创建 MA
                                  p_arrival_date       => v_arrival_date,
                                  p_abnormal_id        => p_abn_rec.abnormal_id);
                --9.3其它异常
              ELSIF p_abn_rec.anomaly_class = 'AC_OTHERS' THEN
                --根据扣款方式进行扣款
                --其它异常扣款金额取数：            
                IF p_abn_rec.deduction_method = 'METHOD_01' THEN
                  --扣款方式为扣款总额，直接取扣款金额
                  v_discount_price := p_abn_rec.deduction_unit_price;
                
                ELSIF p_abn_rec.deduction_method = 'METHOD_02' THEN
                  --扣款方式为扣款比例，扣款金额=数量*单价*扣款比例（“单价”指订单商品单价）
                  --商品单价
                  v_order_price := get_order_price(p_pro_rec => p_pro_rec);
                
                  v_discount_price := (v_order_amount * v_order_price *
                                      p_abn_rec.deduction_unit_price) / 100;
                ELSE
                  NULL;
                END IF;
                --生成扣款单
                sync_abn_ded_bill(p_company_id         => p_pro_rec.company_id,
                                  p_order_id           => p_pro_rec.order_id,
                                  p_goo_id             => p_pro_rec.goo_id,
                                  p_create_id          => p_pro_rec.create_id,
                                  p_delay_day          => p_abn_rec.delay_date, --延期天数 
                                  p_delay_amount       => v_order_amount, --舍弃原有逻辑：p_abn_rec.delay_amount, --延期数量 ，改为：“质量异常，其他异常”，数量取值：订单实际收货总量
                                  p_order_price        => v_order_price,
                                  p_discount_price     => v_discount_price, --扣款金额
                                  p_act_discount_price => v_discount_price, --实际扣款金额
                                  p_orgin              => 'MA', --来源 系统创建 SC / 手动创建 MA
                                  p_arrival_date       => v_arrival_date,
                                  p_abnormal_id        => p_abn_rec.abnormal_id);
              END IF;
            
            END LOOP;
            --11.判断是否有扣款明细，有则修改订单-扣款审核状态-待审核
            check_deductions(p_pro_rec.company_id, p_pro_rec.order_id);
          END IF;
        
          --12.结束订单后自动创建的扣款单 (延期异常)  
          sync_deduction(p_pro_rec     => p_pro_rec,
                         p_orgin       => 'SC',
                         p_abnormal_id => '');
        
          --13.判断是否有扣款明细，有则修改订单-扣款审核状态-待审核
          check_deductions(p_pro_rec.company_id, p_pro_rec.order_id);
        
        ELSE
          NULL;
        END IF;
      END IF;
    ELSE
      --操作重复报提示信息
      raise_application_error(-20002, '已结束该生产订单，不可重复操作！');
    END IF;
  
  END finish_production_progress;
  --校验是否有交货记录
  FUNCTION check_delivery_record(p_pro_rec scmdata.t_production_progress%ROWTYPE)
    RETURN NUMBER IS
    v_flag            NUMBER;
    v_delivery_amount NUMBER;
  BEGIN
    SELECT COUNT(1), COUNT(dr.delivery_amount)
      INTO v_flag, v_delivery_amount
      FROM scmdata.t_delivery_record dr
     WHERE dr.company_id = p_pro_rec.company_id
       AND dr.order_code = p_pro_rec.order_id
       AND dr.goo_id = p_pro_rec.goo_id;
    --判断是否有交货记录且实际收货记录数不能为0
    --有实际收货数量记录时,自动创建的扣款单   
    --没有实际收货数量记录时：不生成扣款记录
    IF v_flag > 0 THEN
      IF v_delivery_amount > 0 THEN
        RETURN 1;
      ELSE
        RETURN 0;
      END IF;
    ELSE
      RETURN 0;
    END IF;
  END;

  --判断是否有扣款明细，有则修改订单-扣款审核状态-待审核
  PROCEDURE check_deductions(p_company_id VARCHAR2, p_order_id VARCHAR2) IS
    v_deds_flag NUMBER;
  BEGIN
    SELECT COUNT(1)
      INTO v_deds_flag
      FROM scmdata.t_deduction td
     INNER JOIN scmdata.t_production_progress pr
        ON td.company_id = pr.company_id
       AND td.order_id = pr.order_id
     INNER JOIN scmdata.t_abnormal abn
        ON pr.company_id = abn.company_id
       AND pr.order_id = abn.order_id
       AND pr.goo_id = abn.goo_id
       AND td.abnormal_id = abn.abnormal_id
     WHERE td.company_id = p_company_id
       AND td.order_id = p_order_id;
  
    IF v_deds_flag > 0 THEN
      UPDATE scmdata.t_ordered po
         SET po.approve_status = '00'
       WHERE po.company_id = p_company_id
         AND po.order_code = p_order_id;
    ELSE
      NULL;
    END IF;
  
  END check_deductions;
  /*============================================*
  * Author   : CZH
  * Created  : 2021-01-04 15:13:57
  * ALERTER  : 
  * ALERTER_TIME  : 
  * Purpose  : 交货记录表变更-同步至生产进度表
  * Obj_Name    : SYNC_DELIVERY_RECORD
  * Arg_Number  : 1
  * P_DELIVERY_REC :交货记录
  *============================================*/
  PROCEDURE sync_delivery_record(p_delivery_rec scmdata.t_delivery_record%ROWTYPE) IS
    v_delivery_date   DATE; --实际交货日期
    v_delay_day       NUMBER; --实际延误天数
    v_delivery_amount NUMBER; --交货数量
    v_order_date      DATE; --订单交期
    v_order_amount    NUMBER; --订单数量
    v_order_full_rate NUMBER;
  BEGIN
    --0.原始到仓日期按配置规则进行转换=》到仓确定日期
    IF p_delivery_rec.delivery_origin_time = p_delivery_rec.delivery_date THEN
      tranf_deduction_config(p_delivery_rec => p_delivery_rec);
    END IF;
  
    --1.订单交期
    v_order_date := get_order_date(p_company_id => p_delivery_rec.company_id,
                                   p_order_code => p_delivery_rec.order_code,
                                   p_status     => 1);
    SELECT ln.order_amount
      INTO v_order_amount
      FROM scmdata.t_orders ln
     WHERE ln.company_id = p_delivery_rec.company_id
       AND ln.order_id = p_delivery_rec.order_code
       AND ln.goo_id = p_delivery_rec.goo_id;
  
    --2.取最新的交货日期
    --3.交货数量,交货记录的‘交货数量’相加
    --4.订单满足率：    
    --1）订单满足率 = 到货金额 / 订货金额
    --2）到货金额 = 商品单价 * 未延期到货数量（订单交货记录中，到仓日期 - 订单交期 ≤ 2的交货数量总数）
    --3）订货金额 = 商品单价 * 订单数量
    SELECT MAX(trunc(td.delivery_date)),
           SUM(td.delivery_amount),
           (SUM(CASE
                  WHEN ceil(trunc(td.delivery_date) - v_order_date) <= 2 THEN
                   td.delivery_amount
                  ELSE
                   0
                END) * 100) / v_order_amount order_full_rate
      INTO v_delivery_date, v_delivery_amount, v_order_full_rate
      FROM scmdata.t_delivery_record td
     WHERE td.company_id = p_delivery_rec.company_id
       AND td.order_code = p_delivery_rec.order_code
       AND td.goo_id = p_delivery_rec.goo_id;
  
    --5.实际延误天数:实际交货日期-订单交期,大于0时显示实际计算结果，小于0时延误天数为0 
    --v_delay_day := nvl(ceil(v_delivery_date - v_order_date), 0);
    v_delay_day := get_delay_days(p_arrival_date => v_delivery_date,
                                  p_order_date   => v_order_date);
  
    --6.更新生产进度
    UPDATE t_production_progress t
       SET t.actual_delivery_date = v_delivery_date,
           t.actual_delay_day     = decode(sign(v_delay_day),
                                           -1,
                                           0,
                                           v_delay_day),
           t.delivery_amount      = nvl(v_delivery_amount, 0),
           t.order_full_rate      = nvl(v_order_full_rate, 0)
     WHERE t.company_id = p_delivery_rec.company_id
       AND t.order_id = p_delivery_rec.order_code
       AND t.goo_id = p_delivery_rec.goo_id;
  
  END sync_delivery_record;
  --校验异常分类配置  返回值v_abnormal_config_id：模板编号
  FUNCTION check_abnormal_config(p_company_id VARCHAR2, p_goo_id VARCHAR2)
    RETURN VARCHAR2 IS
    v_abnormal_config_id VARCHAR2(100);
  BEGIN
    SELECT DISTINCT dr.abnormal_config_id
      INTO v_abnormal_config_id
      FROM scmdata.t_commodity_info tc
     INNER JOIN scmdata.t_abnormal_range_config dr
        ON tc.company_id = dr.company_id
       AND tc.category = dr.industry_classification
       AND tc.product_cate = dr.production_category
       AND instr(';' || dr.product_subclass || ';',
                 ';' || tc.samll_category || ';') > 0
       AND dr.pause = 0
     INNER JOIN scmdata.t_abnormal_dtl_config dc
        ON dr.company_id = dc.company_id
       AND dr.abnormal_config_id = dc.abnormal_config_id
       AND dc.pause = 0
     INNER JOIN scmdata.t_abnormal_config td
        ON td.company_id = dc.company_id
       AND td.abnormal_config_id = dc.abnormal_config_id
       AND td.pause = 0
     WHERE tc.company_id = p_company_id
       AND tc.goo_id = p_goo_id;
    RETURN v_abnormal_config_id;
  END check_abnormal_config;

  /*============================================*
  * Author   : CZH
  * Created  : 2021-01-04 15:14:41
  * ALERTER  : 
  * ALERTER_TIME  : 
  * Purpose  : 校验异常单
  * Obj_Name    : CHECK_ABNORMAL
  * Arg_Number  : 1
  * P_ABN_REC :异常单
  *============================================*/

  PROCEDURE check_abnormal(p_abn_rec scmdata.t_abnormal%ROWTYPE) IS
    v_order_amount NUMBER;
  BEGIN
  
    IF p_abn_rec.anomaly_class IS NOT NULL AND
       p_abn_rec.anomaly_class <> ' ' THEN
    
      --校验异常分类为‘交期异常’时,延期天数必填！
      IF p_abn_rec.anomaly_class = 'AC_DATE' THEN
      
        IF p_abn_rec.delay_date IS NULL THEN
          raise_application_error(-20002,
                                  '异常分类为‘交期异常’时,延期天数必填！');
        END IF;
        --异常分类为‘交期异常’时,延期数量必填！
        IF p_abn_rec.delay_amount IS NULL THEN
          raise_application_error(-20002,
                                  '异常分类为‘交期异常’时,延期数量必填！');
        END IF;
        --交期异常是否扣款必须选“否”！
        IF p_abn_rec.is_deduction = 1 THEN
          raise_application_error(-20002,
                                  '保存失败！交期异常是否扣款必须选“否”！');
        
        END IF;
      END IF;
      --根据异常分类，校验质量异常/其它异常的扣款方式
      IF p_abn_rec.anomaly_class = 'AC_QUALITY' THEN
        IF p_abn_rec.deduction_method = 'METHOD_02' THEN
          raise_application_error(-20002,
                                  '异常分类为交期异常/质量异常的异常单，扣款方式只能选择扣款单价/扣款总额！');
        END IF;
      ELSIF p_abn_rec.anomaly_class = 'AC_OTHERS' THEN
        IF p_abn_rec.deduction_method = 'METHOD_00' THEN
          raise_application_error(-20002,
                                  '异常分类为其它异常的异常单，扣款方式只能选择扣款总额/扣款比例！');
        END IF;
      ELSE
        NULL;
      END IF;
    
      --问题描述不能为空
      IF p_abn_rec.detailed_reasons = ' ' THEN
        raise_application_error(-20002, '问题描述不能为空！');
      END IF;
      --是否扣款为‘是’时,扣款单价必填
      IF p_abn_rec.is_deduction = 1 THEN
        IF p_abn_rec.deduction_method IS NULL THEN
          raise_application_error(-20002,
                                  '是否扣款为‘是’时,扣款方式必填！');
        ELSE
          IF p_abn_rec.deduction_unit_price IS NULL THEN
            raise_application_error(-20002,
                                    '是否扣款为‘是’时,扣款单价/金额/比例必填！');
          END IF;
        END IF;
      END IF;
    
      --延期数量不能大于订单数量
      SELECT MAX(pln.order_amount)
        INTO v_order_amount
        FROM scmdata.t_ordered po
       INNER JOIN scmdata.t_orders pln
          ON po.company_id = pln.company_id
         AND po.order_code = pln.order_id
       WHERE pln.company_id = p_abn_rec.company_id
         AND pln.order_id = p_abn_rec.order_id
         AND pln.goo_id = p_abn_rec.goo_id;
    
      IF p_abn_rec.delay_amount > v_order_amount THEN
        raise_application_error(-20002, '数量不能大于订单数量！');
      END IF;
    
    ELSE
      raise_application_error(-20002, '异常分类不能为空！');
    END IF;
  
  END check_abnormal;

  /*============================================*
  * Author   : CZH
  * Created  : 2021-01-04 15:14:41
  * ALERTER  : 
  * ALERTER_TIME  : 
  * Purpose  : 新增异常单
  * Obj_Name    : handle_abnormal
  * Arg_Number  : 1
  * P_ABN_REC :异常单
  *============================================*/
  PROCEDURE handle_abnormal(p_abn_rec scmdata.t_abnormal%ROWTYPE) IS
  
  BEGIN
    --校验异常单
    --check_abnormal(p_abn_rec => p_abn_rec);
  
    INSERT INTO t_abnormal
      (abnormal_id,
       company_id,
       abnormal_code,
       order_id,
       progress_status,
       goo_id,
       anomaly_class,
       problem_class,
       cause_class,
       cause_detailed,
       detailed_reasons,
       is_sup_responsible,
       delay_date,
       delay_amount,
       responsible_party,
       responsible_dept,
       responsible_dept_sec,
       handle_opinions,
       quality_deduction,
       is_deduction,
       deduction_method,
       deduction_unit_price,
       file_id,
       applicant_id,
       applicant_date,
       confirm_id,
       confirm_company_id,
       confirm_date,
       create_id,
       create_time,
       update_id,
       update_time,
       origin,
       origin_id,
       memo)
    VALUES
      (p_abn_rec.abnormal_id,
       p_abn_rec.company_id,
       p_abn_rec.abnormal_code,
       p_abn_rec.order_id,
       p_abn_rec.progress_status,
       p_abn_rec.goo_id,
       p_abn_rec.anomaly_class,
       p_abn_rec.problem_class,
       p_abn_rec.cause_class,
       p_abn_rec.cause_detailed,
       p_abn_rec.detailed_reasons,
       p_abn_rec.is_sup_responsible,
       p_abn_rec.delay_date,
       p_abn_rec.delay_amount,
       p_abn_rec.responsible_party,
       p_abn_rec.responsible_dept,
       p_abn_rec.responsible_dept_sec,
       p_abn_rec.handle_opinions,
       p_abn_rec.quality_deduction,
       p_abn_rec.is_deduction,
       p_abn_rec.deduction_method,
       p_abn_rec.deduction_unit_price,
       p_abn_rec.file_id,
       p_abn_rec.applicant_id,
       p_abn_rec.applicant_date,
       p_abn_rec.confirm_id,
       p_abn_rec.confirm_company_id,
       to_date(to_char(p_abn_rec.confirm_date, 'YYYY-MM-DD'), 'YYYY-MM-DD'),
       p_abn_rec.create_id,
       p_abn_rec.create_time,
       p_abn_rec.update_id,
       p_abn_rec.update_time,
       p_abn_rec.origin,
       p_abn_rec.origin_id,
       p_abn_rec.memo);
  
  END handle_abnormal;

  /*============================================*
  * Author   : CZH
  * Created  : 2021-01-04 15:14:41
  * ALERTER  : 
  * ALERTER_TIME  : 
  * Purpose  : 修改异常单
  * Obj_Name    : update_abnormal
  * Arg_Number  : 1
  * P_ABN_REC :异常单
  *============================================*/
  PROCEDURE update_abnormal(p_abn_rec scmdata.t_abnormal%ROWTYPE) IS
  
  BEGIN
    --校验异常单
    check_abnormal(p_abn_rec => p_abn_rec);
  
    IF p_abn_rec.anomaly_class = 'AC_DATE' THEN
      UPDATE t_abnormal t
         SET t.delay_date           = p_abn_rec.delay_date,
             t.delay_amount         = p_abn_rec.delay_amount,
             t.responsible_party    = p_abn_rec.responsible_party,
             t.handle_opinions      = p_abn_rec.handle_opinions,
             t.is_deduction         = p_abn_rec.is_deduction,
             t.deduction_method     = p_abn_rec.deduction_method,
             t.deduction_unit_price = round(p_abn_rec.deduction_unit_price,
                                            2),
             t.file_id              = p_abn_rec.file_id,
             t.applicant_id         = p_abn_rec.applicant_id,
             t.applicant_date       = p_abn_rec.applicant_date,
             t.memo                 = p_abn_rec.memo,
             t.update_id            = p_abn_rec.update_id,
             t.update_time          = p_abn_rec.update_time
       WHERE t.company_id = p_abn_rec.company_id
         AND t.abnormal_id = p_abn_rec.abnormal_id;
    ELSIF p_abn_rec.anomaly_class = 'AC_QUALITY' THEN
      UPDATE t_abnormal t
         SET t.problem_class        = p_abn_rec.problem_class,
             t.cause_class          = p_abn_rec.cause_class,
             t.cause_detailed       = p_abn_rec.cause_detailed,
             t.detailed_reasons     = p_abn_rec.detailed_reasons,
             t.delay_date           = p_abn_rec.delay_date,
             t.delay_amount         = p_abn_rec.delay_amount,
             t.is_sup_responsible   = p_abn_rec.is_sup_responsible,
             t.responsible_party    = p_abn_rec.responsible_party,
             t.responsible_dept     = p_abn_rec.responsible_dept,
             t.responsible_dept_sec = p_abn_rec.responsible_dept_sec,
             t.handle_opinions      = p_abn_rec.handle_opinions,
             t.is_deduction         = p_abn_rec.is_deduction,
             t.deduction_method     = p_abn_rec.deduction_method,
             t.deduction_unit_price = round(p_abn_rec.deduction_unit_price,
                                            2),
             t.file_id              = p_abn_rec.file_id,
             t.applicant_id         = p_abn_rec.applicant_id,
             t.applicant_date       = p_abn_rec.applicant_date,
             t.memo                 = p_abn_rec.memo,
             t.update_id            = p_abn_rec.update_id,
             t.update_time          = p_abn_rec.update_time
       WHERE t.company_id = p_abn_rec.company_id
         AND t.abnormal_id = p_abn_rec.abnormal_id;
    ELSIF p_abn_rec.anomaly_class = 'AC_OTHERS' THEN
      UPDATE t_abnormal t
         SET t.detailed_reasons     = p_abn_rec.detailed_reasons,
             t.delay_date           = p_abn_rec.delay_date,
             t.delay_amount         = p_abn_rec.delay_amount,
             t.is_sup_responsible   = p_abn_rec.is_sup_responsible,
             t.responsible_party    = p_abn_rec.responsible_party,
             t.responsible_dept     = p_abn_rec.responsible_dept,
             t.responsible_dept_sec = p_abn_rec.responsible_dept_sec,
             t.handle_opinions      = p_abn_rec.handle_opinions,
             t.is_deduction         = p_abn_rec.is_deduction,
             t.deduction_method     = p_abn_rec.deduction_method,
             t.deduction_unit_price = round(p_abn_rec.deduction_unit_price,
                                            2),
             t.file_id              = p_abn_rec.file_id,
             t.applicant_id         = p_abn_rec.applicant_id,
             t.applicant_date       = p_abn_rec.applicant_date,
             t.memo                 = p_abn_rec.memo,
             t.update_id            = p_abn_rec.update_id,
             t.update_time          = p_abn_rec.update_time
       WHERE t.company_id = p_abn_rec.company_id
         AND t.abnormal_id = p_abn_rec.abnormal_id;
    END IF;
  
  END update_abnormal;

  /*============================================*
  * Author   : CZH
  * Created  : 2021-01-04 15:15:51
  * ALERTER  : 
  * ALERTER_TIME  : 
  * Purpose  : 更新生产进度，异常单状态
  * Obj_Name    : SYNC_ABNORMAL
  * Arg_Number  : 2
  * P_ABN_REC : 异常单
  * P_STATUS :生产进度-异常状态
  *============================================*/

  PROCEDURE sync_abnormal(p_abn_rec scmdata.t_abnormal%ROWTYPE,
                          p_status  VARCHAR2) IS
    v_handle_opinions VARCHAR2(100);
    v_flag            NUMBER;
  BEGIN
    --处理中，需校验已处理是否存在单据，有则处理结果取已处理最新单据的处理结果
    IF p_status = '01' THEN
      SELECT MAX(t.handle_opinions)
        INTO v_handle_opinions
        FROM (SELECT abn.handle_opinions
                FROM scmdata.t_abnormal abn
               WHERE abn.company_id = p_abn_rec.company_id
                 AND abn.order_id = p_abn_rec.order_id
                 AND abn.goo_id = p_abn_rec.goo_id
                 AND abn.progress_status = '02'
               ORDER BY abn.create_time DESC) t
       WHERE rownum = 1;
    
      UPDATE scmdata.t_production_progress pr
         SET pr.exception_handle_status = p_status,
             pr.handle_opinions         = v_handle_opinions
       WHERE pr.company_id = p_abn_rec.company_id
         AND pr.order_id = p_abn_rec.order_id
         AND pr.goo_id = p_abn_rec.goo_id;
      --已处理    
    ELSIF p_status = '02' THEN
      SELECT COUNT(1)
        INTO v_flag
        FROM scmdata.t_abnormal abn
       WHERE abn.company_id = p_abn_rec.company_id
         AND abn.order_id = p_abn_rec.order_id
         AND abn.goo_id = p_abn_rec.goo_id
         AND abn.progress_status = '01';
      --同一张单存在多条异常处理单时，需要全部确认了，订单的异常状态才可变为“已处理”
      IF v_flag = 0 THEN
        UPDATE scmdata.t_production_progress pr
           SET pr.exception_handle_status = p_status,
               pr.handle_opinions         = p_abn_rec.handle_opinions
         WHERE pr.company_id = p_abn_rec.company_id
           AND pr.order_id = p_abn_rec.order_id
           AND pr.goo_id = p_abn_rec.goo_id;
      END IF;
      --删除异常单
    ELSIF p_status = '00' THEN
      UPDATE scmdata.t_production_progress pr
         SET pr.exception_handle_status = p_status,
             pr.handle_opinions         = p_abn_rec.handle_opinions
       WHERE pr.company_id = p_abn_rec.company_id
         AND pr.order_id = p_abn_rec.order_id
         AND pr.goo_id = p_abn_rec.goo_id;
    END IF;
  END sync_abnormal;

  /*============================================*
  * Author   : CZH
  * Created  : 2021-01-04 15:16:45
  * ALERTER  : 
  * ALERTER_TIME  : 
  * Purpose  : 提交异常单
  * Obj_Name    : SUBMIT_ABNORMAL
  * Arg_Number  : 1
  * P_ABN_REC : 异常单
  *============================================*/

  PROCEDURE submit_abnormal(p_abn_rec scmdata.t_abnormal%ROWTYPE) IS
  
  BEGIN
    --校验异常单
    check_abnormal(p_abn_rec => p_abn_rec);
  
    UPDATE t_abnormal t
       SET t.progress_status = '01'
     WHERE t.company_id = p_abn_rec.company_id
       AND t.abnormal_id = p_abn_rec.abnormal_id;
  
    --更新生产进度，异常单状态
    sync_abnormal(p_abn_rec => p_abn_rec, p_status => '01');
  
  END submit_abnormal;

  /*============================================*
  * Author   : CZH
  * Created  : 2021-01-04 15:16:45
  * ALERTER  : 
  * ALERTER_TIME  : 
  * Purpose  : 确认异常单
  * Obj_Name    : confirm_abnormal
  * Arg_Number  : 1
  * P_ABN_REC : 异常单
  *============================================*/
  PROCEDURE confirm_abnormal(p_abn_rec scmdata.t_abnormal%ROWTYPE) IS
  BEGIN
    --1.校验异常单
    --check_abnormal(p_abn_rec => p_abn_rec);
    --2.确认异常单
    UPDATE t_abnormal t
       SET t.progress_status    = '02',
           t.confirm_id         = p_abn_rec.confirm_id,
           t.confirm_company_id = p_abn_rec.confirm_company_id,
           t.confirm_date       = p_abn_rec.confirm_date
     WHERE t.company_id = p_abn_rec.company_id
       AND t.abnormal_id = p_abn_rec.abnormal_id;
  
    --3.更新生产进度，异常单状态
    sync_abnormal(p_abn_rec => p_abn_rec, p_status => '02');
  
  END confirm_abnormal;

  /*============================================*
  * Author   : CZH
  * Created  : 2021-01-04 15:16:45
  * ALERTER  : 
  * ALERTER_TIME  : 
  * Purpose  : 撤销异常单
  * Obj_Name    : revoke_abnormal
  * Arg_Number  : 1
  * P_ABN_REC : 异常单
  *============================================*/
  PROCEDURE revoke_abnormal(p_abn_rec scmdata.t_abnormal%ROWTYPE) IS
    v_progress_status VARCHAR2(100);
  BEGIN
    SELECT MAX(pr.progress_status)
      INTO v_progress_status
      FROM scmdata.t_abnormal abn
     INNER JOIN scmdata.t_production_progress pr
        ON abn.company_id = pr.company_id
       AND abn.order_id = pr.order_id
       AND abn.goo_id = pr.goo_id
       AND abn.abnormal_id = p_abn_rec.abnormal_id;
    --生产订单结束不可撤销
    IF v_progress_status = '01' THEN
      raise_application_error(-20002, '提示：所选订单已结束，不可撤销！');
    END IF;
  
    UPDATE t_abnormal t
       SET t.progress_status = '01'
     WHERE t.company_id = p_abn_rec.company_id
       AND t.abnormal_id = p_abn_rec.abnormal_id;
  
    --更新生产进度，异常单状态
    sync_abnormal(p_abn_rec => p_abn_rec, p_status => '01');
  
  END revoke_abnormal;

  --校验节点进度
  PROCEDURE check_production_node(pno_rec scmdata.t_production_node%ROWTYPE) IS
    v_pre_flag      NUMBER;
    v_next_flag     NUMBER;
    v_pre_node_num  NUMBER;
    v_next_node_num NUMBER;
    v_max_node_num  NUMBER;
    --v_flag                      NUMBER;
    v_next_plan_completion_time DATE;
    v_next_node_name            VARCHAR2(100);
    v_pre_plan_completion_time  DATE;
    v_pre_node_name             VARCHAR2(100);
    v_order_amount              NUMBER;
    --v_complete_amount           NUMBER;
  
  BEGIN
    --1.校验当前节点的上一节点是否存在
    SELECT COUNT(1)
      INTO v_pre_flag
      FROM scmdata.t_production_node pn
     WHERE pn.company_id = pno_rec.company_id
       AND pn.product_gress_id = pno_rec.product_gress_id
       AND pn.node_num = pno_rec.node_num - 1;
  
    IF v_pre_flag > 0 THEN
    
      v_pre_node_num := pno_rec.node_num; --初始值为当前节点
    
      LOOP
        SELECT pn.plan_completion_time, pn.node_name
          INTO v_pre_plan_completion_time, v_pre_node_name
          FROM scmdata.t_production_node pn
         WHERE pn.company_id = pno_rec.company_id
           AND pn.product_gress_id = pno_rec.product_gress_id
           AND pn.node_num = v_pre_node_num - 1;
      
        --校验当前节点不能早于前一节点日期
        IF trunc(v_pre_plan_completion_time) >
           trunc(pno_rec.plan_completion_time) THEN
          raise_application_error(-20002,
                                  '当前节点：' || pno_rec.node_name ||
                                  '的日期不能早于前节点:' || v_pre_node_name ||
                                  '的日期！');
        END IF;
        v_pre_node_num := v_pre_node_num - 1;
      
        EXIT WHEN v_pre_node_num = 1; --结束条件 节点编号为1则退出
      
      END LOOP;
    
    ELSE
      NULL;
    END IF;
  
    --2.校验当前节点的下一节点是否存在
    SELECT COUNT(1)
      INTO v_next_flag
      FROM scmdata.t_production_node pn
     WHERE pn.company_id = pno_rec.company_id
       AND pn.product_gress_id = pno_rec.product_gress_id
       AND pn.node_num = pno_rec.node_num + 1;
  
    IF v_next_flag > 0 THEN
      --获取最大节点
      SELECT MAX(pn.node_num)
        INTO v_max_node_num
        FROM scmdata.t_production_node pn
       WHERE pn.company_id = pno_rec.company_id
         AND pn.product_gress_id = pno_rec.product_gress_id;
    
      v_next_node_num := pno_rec.node_num; --初始值为当前节点
    
      LOOP
        SELECT pn.plan_completion_time, pn.node_name
          INTO v_next_plan_completion_time, v_next_node_name
          FROM scmdata.t_production_node pn
         WHERE pn.company_id = pno_rec.company_id
           AND pn.product_gress_id = pno_rec.product_gress_id
           AND pn.node_num = v_next_node_num + 1;
      
        --校验当前节点日期是否大于后一节点日期
        IF trunc(pno_rec.plan_completion_time) >
           trunc(v_next_plan_completion_time) THEN
          raise_application_error(-20002,
                                  '当前节点：' || pno_rec.node_name ||
                                  '的日期不能晚于后节点:' || v_next_node_name ||
                                  '的日期！');
        END IF;
      
        v_next_node_num := v_next_node_num + 1;
      
        EXIT WHEN v_next_node_num = v_max_node_num; --结束条件 节点编号为最大值则退出
      
      END LOOP;
    
    ELSE
      NULL;
    END IF;
  
    --3.校验实际完成日期，与进度状态，两者任一字段有值，则另一字段必填
    IF pno_rec.actual_completion_time IS NOT NULL THEN
      IF pno_rec.progress_status IS NULL OR pno_rec.progress_status <> '01' THEN
        raise_application_error(-20002,
                                '实际完成日期有值，节点进度状态必选‘已完成’！');
      END IF;
    END IF;
  
    IF pno_rec.progress_status = '01' THEN
      IF pno_rec.actual_completion_time IS NULL THEN
        raise_application_error(-20002,
                                '节点进度状态为‘已完成’，实际完成日期必填！');
      END IF;
    END IF;
  
    --4.校验完成数量不能大于订单数量
  
    SELECT pr.order_amount
      INTO v_order_amount
      FROM scmdata.t_production_progress pr
     WHERE pr.product_gress_id = pno_rec.product_gress_id;
  
    IF pno_rec.complete_amount > v_order_amount THEN
      raise_application_error(-20002,
                              '完成数量不能大于该生产订单的订单数量！');
    END IF;
  
  END check_production_node;

  /*============================================*
  * Author   : CZH
  * Created  : 2021-01-04 15:17:52
  * ALERTER  : 
  * ALERTER_TIME  : 
  * Purpose  : 新增节点进度
  * Obj_Name    : INSERT_PRODUCTION_NODE
  * Arg_Number  : 1
  * PNO_REC :节点进度
  *============================================*/

  PROCEDURE insert_production_node(pno_rec scmdata.t_production_node%ROWTYPE) IS
  BEGIN
    INSERT INTO t_production_node
      (product_node_id,
       company_id,
       product_gress_id,
       product_node_code,
       node_num,
       node_name,
       time_ratio,
       target_completion_time,
       plan_completion_time,
       actual_completion_time,
       complete_amount,
       progress_status,
       progress_say,
       update_id,
       update_date,
       create_id,
       create_time,
       memo)
    VALUES
      (pno_rec.product_node_id,
       pno_rec.company_id,
       pno_rec.product_gress_id,
       pno_rec.product_node_code,
       pno_rec.node_num,
       pno_rec.node_name,
       pno_rec.time_ratio,
       trunc(pno_rec.target_completion_time),
       trunc(pno_rec.plan_completion_time),
       trunc(pno_rec.actual_completion_time),
       pno_rec.complete_amount,
       pno_rec.progress_status,
       pno_rec.progress_say,
       pno_rec.update_id,
       pno_rec.update_date,
       pno_rec.create_id,
       pno_rec.create_time,
       pno_rec.memo);
  
  END insert_production_node;
  --计算预测交期
  PROCEDURE get_forecast_delivery_date(p_company_id          VARCHAR2,
                                       p_product_gress_id    VARCHAR2,
                                       p_progress_status     VARCHAR2,
                                       po_forecast_date      OUT DATE,
                                       po_plan_complete_date OUT DATE) IS
    v_plan_completion_time   DATE;
    v_actual_completion_time DATE;
    v_delivery_date          DATE; --订单交期
    v_product_cycle          NUMBER; --生产周期
    v_node_cycle             NUMBER := 0; --剩余未完成节点的节点周期 
    v_node_num               NUMBER := 0; --节点序号
  BEGIN
    --生产周期 订单交期与下单日期为同一天，则计算生产周期为1,否则 生产周期 = 订单交期-接单日期 
    SELECT trunc(po.delivery_date),
           decode(trunc(po.delivery_date),
                  trunc(po.create_time),
                  1,
                  ceil(trunc(po.delivery_date) - trunc(po.create_time)))
      INTO v_delivery_date, v_product_cycle
      FROM scmdata.t_ordered po
     INNER JOIN scmdata.t_orders pln
        ON po.company_id = pln.company_id
       AND po.order_code = pln.order_id
     INNER JOIN scmdata.t_production_progress pr
        ON pln.company_id = pr.company_id
       AND pln.order_id = pr.order_id
       AND pln.goo_id = pr.goo_id
     WHERE pr.company_id = p_company_id
       AND pr.product_gress_id = p_product_gress_id;
  
    --2.2 预测交期  B 生产进度状态为未开始，计划完成日期有值时，预测交期=计划完成日期（交货）；
    SELECT MAX(trunc(pn.plan_completion_time))
      INTO v_plan_completion_time
      FROM scmdata.t_production_node pn
     WHERE pn.company_id = p_company_id
       AND pn.product_gress_id = p_product_gress_id
       AND pn.node_name = '交货';
  
    IF p_progress_status = '00' THEN
      IF v_plan_completion_time IS NULL THEN
        po_forecast_date := v_delivery_date; --订单交期
      ELSE
        po_forecast_date := v_plan_completion_time; --计划完成日期（交货）
      END IF;
    ELSE
      --2.3 C 生产进度状态为进行中，预测交期=最新节点实际完成日期+剩余未完成节点的节点周期 .
      --如果都为进行中，则取计划完成日期（交货）/订单交期  
      --2.4生产进度状态为进行中，且当前日期已超过计划完成日期，则预测交期=最新节点实际完成日期+剩余未完成节点的节点周期+超计划完成日期天数
      --超计划完成日期天数= 当前日期 - 当前节点计划完成日期
      SELECT MAX(trunc(actual_completion_time)),
             MAX(node_num),
             MAX(trunc(plan_completion_time))
        INTO v_actual_completion_time, v_node_num, po_plan_complete_date
        FROM (SELECT pn.actual_completion_time,
                     pn.node_num,
                     pn.plan_completion_time
                FROM scmdata.t_production_node pn
               WHERE pn.company_id = p_company_id
                 AND pn.product_gress_id = p_product_gress_id
                 AND pn.progress_status = '01' --01 已完成                
               ORDER BY pn.node_num DESC)
       WHERE rownum = 1;
      --剩余未完成节点的节点周期.
      --节点周期=生产周期*该节点用时占比
      --生产周期=订单交期-接单日期
      FOR pn_data IN (SELECT pn.time_ratio
                        FROM scmdata.t_production_node pn
                       WHERE pn.company_id = p_company_id
                         AND pn.product_gress_id = p_product_gress_id
                         AND pn.node_num > v_node_num
                         AND (pn.progress_status = '00' OR
                             pn.progress_status IS NULL)) LOOP
        --00 节点周期累加完之后，再进行取整
        v_node_cycle := nvl(v_node_cycle +
                            v_product_cycle * pn_data.time_ratio * 0.01,
                            0);
      END LOOP;
    
      po_forecast_date := nvl((v_actual_completion_time +
                              ceil(v_node_cycle)),
                              nvl(v_plan_completion_time, v_delivery_date));
    
    END IF;
  
  END get_forecast_delivery_date;

  /*============================================*
  * Author   : CZH
  * Created  : 2021-01-04 15:17:52
  * ALERTER  : 
  * ALERTER_TIME  : 
  * Purpose  : 修改节点进度  ,此处涉及生产进度表字段变化逻辑
  * Obj_Name    : update_production_node
  * Arg_Number  : 1
  * PNO_REC :节点进度
  * p_status :0:更新  1：批量复制调用 不走校验节点进度
  *============================================*/
  PROCEDURE update_production_node(pno_rec  scmdata.t_production_node%ROWTYPE,
                                   p_status NUMBER DEFAULT 0) IS
    p_produ_rec           t_production_progress%ROWTYPE; --生产进度
    vo_forecast_date      DATE;
    vo_plan_complete_date DATE;
    v_over_plan_days      NUMBER;
  BEGIN
    --校验节点进度
    IF p_status = 0 THEN
      check_production_node(pno_rec => pno_rec);
    END IF;
  
    --1.修改节点进度
    UPDATE t_production_node t
       SET t.plan_completion_time   = trunc(pno_rec.plan_completion_time),
           t.actual_completion_time = trunc(pno_rec.actual_completion_time),
           t.complete_amount        = pno_rec.complete_amount,
           t.progress_status        = pno_rec.progress_status,
           t.progress_say           = pno_rec.progress_say,
           t.update_id              = pno_rec.update_id,
           t.update_date            = pno_rec.update_date,
           t.operator               = pno_rec.operator
     WHERE t.product_node_id = pno_rec.product_node_id;
  
    --2.生产进度表字段随节点进度字段变化逻辑 
    --生产进度主键
    p_produ_rec.product_gress_id := pno_rec.product_gress_id;
  
    --2.1 生产进度状态：中间节点状态：取节点进度状态最后一条非空的状态值，展示“节点名称+进度状态” 舍弃放置查询item
    /*    SELECT nvl((SELECT pno_status
               FROM (SELECT pn.node_name || a.group_dict_name pno_status
                       FROM scmdata.t_production_node pn
                      INNER JOIN scmdata.sys_group_dict a
                         ON a.group_dict_value = pn.progress_status
                      INNER JOIN scmdata.sys_group_dict b
                         ON a.group_dict_type = b.group_dict_value
                        AND b.group_dict_value = 'PROGRESS_NODE_TYPE'
                      WHERE pn.company_id = pno_rec.company_id
                        AND pn.product_gress_id = pno_rec.product_gress_id
                        AND pn.progress_status IS NOT NULL
                      ORDER BY pn.node_num DESC)
              WHERE rownum = 1),
             '00') pno_status
    INTO p_produ_rec.progress_status
    FROM dual;*/
  
    --修改字段progress_status在数据库按编码 00：未开始，01：已完成，02：进行中形式存储数据
    SELECT nvl2(MAX(pno_status), '02', '00')
      INTO p_produ_rec.progress_status
      FROM (SELECT pn.node_name || a.group_dict_name pno_status
              FROM scmdata.t_production_node pn
             INNER JOIN scmdata.sys_group_dict a
                ON a.group_dict_value = pn.progress_status
             INNER JOIN scmdata.sys_group_dict b
                ON a.group_dict_type = b.group_dict_value
               AND b.group_dict_value = 'PROGRESS_NODE_TYPE'
             WHERE pn.company_id = pno_rec.company_id
               AND pn.product_gress_id = pno_rec.product_gress_id
               AND pn.progress_status IS NOT NULL
             ORDER BY pn.node_num DESC)
     WHERE rownum = 1;
  
    --获取预测交期 
    get_forecast_delivery_date(p_company_id          => pno_rec.company_id,
                               p_product_gress_id    => pno_rec.product_gress_id,
                               p_progress_status     => p_produ_rec.progress_status,
                               po_forecast_date      => vo_forecast_date,
                               po_plan_complete_date => vo_plan_complete_date);
  
    --生产进度状态为进行中，且当前日期已超过计划完成日期，则预测交期=最新节点实际完成日期+剩余未完成节点的节点周期+超计划完成日期天数
    v_over_plan_days := trunc(SYSDATE) -
                        nvl(trunc(vo_plan_complete_date), trunc(SYSDATE));
    IF v_over_plan_days > 0 THEN
      p_produ_rec.forecast_delivery_date := vo_forecast_date +
                                            v_over_plan_days;
    ELSE
      p_produ_rec.forecast_delivery_date := vo_forecast_date;
    END IF;
    --最新计划交期  =计划完成日期（交货）
    --p_produ_rec.latest_planned_delivery_date := vo_plan_complete_date;
  
    --3.更新生产进度表
    update_production_progress(p_produ_rec => p_produ_rec);
  
  END update_production_node;
  --修改订单备注
  PROCEDURE update_ordered(po_rec scmdata.t_ordered%ROWTYPE) IS
  BEGIN
    UPDATE scmdata.t_ordered po
       SET po.memo_dedu        = po_rec.memo_dedu,
           po.update_id_dedu  =
           (SELECT fc.company_user_name
              FROM scmdata.sys_company_user fc
             WHERE fc.company_id = po_rec.company_id
               AND fc.user_id = po_rec.update_id_dedu),
           po.update_time_dedu = po_rec.update_time_dedu
     WHERE po.company_id = po_rec.company_id
       AND po.order_id = po_rec.order_id;
  END update_ordered;
  /*============================================*
  * Author   : CZH
  * Created  : 2021-01-04 15:19:01
  * ALERTER  : 
  * ALERTER_TIME  : 
  * Purpose  : 扣款单审核
  * Obj_Name    : APPROVE_ORDERS
  * Arg_Number  : 1
  * PO_REC :订单头
  *============================================*/

  PROCEDURE approve_orders(po_rec scmdata.t_ordered%ROWTYPE) IS
  BEGIN
    IF po_rec.approve_status = '00' THEN
      UPDATE scmdata.t_ordered po
         SET po.approve_status = '01',
             po.approve_id     = po_rec.approve_id,
             po.approve_time   = po_rec.approve_time
       WHERE po.company_id = po_rec.company_id
         AND po.order_id = po_rec.order_id;
    END IF;
  END;

  /*============================================*
  * Author   : CZH
  * Created  : 2021-01-04 15:19:01
  * ALERTER  : 
  * ALERTER_TIME  : 
  * Purpose  : 扣款单撤销审核
  * Obj_Name    : revoke_approve_orders
  * Arg_Number  : 1
  * PO_REC :订单头
  *============================================*/
  PROCEDURE revoke_approve_orders(po_rec scmdata.t_ordered%ROWTYPE) IS
  BEGIN
    IF po_rec.approve_status = '01' THEN
      UPDATE scmdata.t_ordered po
         SET po.approve_status = '00',
             po.approve_id     = po_rec.approve_id,
             po.approve_time   = po_rec.approve_time
       WHERE po.company_id = po_rec.company_id
         AND po.order_id = po_rec.order_id;
    END IF;
  END revoke_approve_orders;

  --获取延期天数
  FUNCTION get_delay_days(p_arrival_date DATE, p_order_date DATE)
    RETURN NUMBER IS
    v_delay_days NUMBER;
  BEGIN
    v_delay_days := nvl(to_number(trunc(p_arrival_date) -
                                  trunc(p_order_date)),
                        0);
    RETURN v_delay_days;
  END get_delay_days;

  --获取订单交期
  --1.生产进度表中的订单交期取下单列表的订单交期（即熊猫的交期日期）
  --2.生产进度表中的最新计划交期取下单列表的最新计划交期（即熊猫的新交货交期）
  FUNCTION get_order_date(p_company_id VARCHAR2,
                          p_order_code VARCHAR2,
                          p_status     NUMBER) RETURN DATE IS
    v_delivery_date DATE;
  BEGIN
    IF p_status = 1 THEN
      SELECT MAX(po.delivery_date)
        INTO v_delivery_date
        FROM scmdata.t_ordered po
       WHERE po.company_id = p_company_id
         AND po.order_code = p_order_code;
      RETURN v_delivery_date;
    ELSIF p_status = 2 THEN
      SELECT MAX(pn.delivery_date)
        INTO v_delivery_date
        FROM scmdata.t_orders pn
       WHERE pn.company_id = p_company_id
         AND pn.order_id = p_order_code;
      RETURN v_delivery_date;
    ELSE
      RETURN NULL;
    END IF;
  
  END get_order_date;

  --获取商品单价
  FUNCTION get_order_price(p_pro_rec scmdata.t_production_progress%ROWTYPE)
    RETURN NUMBER IS
    v_order_price NUMBER;
  BEGIN
    SELECT nvl(MAX(ln.order_price), 0)
      INTO v_order_price --商品单价
      FROM scmdata.t_orders ln
     WHERE ln.company_id = p_pro_rec.company_id
       AND ln.order_id = p_pro_rec.order_id;
  
    RETURN v_order_price;
  
  END get_order_price;
  --获取扣款金额/扣款比例：根据订单商品（行业分类+生产类别+产品子类）及延期天数匹配相应扣款规则
  PROCEDURE get_deduction(p_company_id       VARCHAR2,
                          p_goo_id           VARCHAR2,
                          p_delay_day        NUMBER,
                          po_deduction_type  OUT VARCHAR2,
                          po_deduction_money OUT NUMBER) IS
    v_deduction_type  VARCHAR2(100);
    v_deduction_ratio NUMBER;
    v_deduction_money NUMBER;
  BEGIN
  
    SELECT MAX(dc.deduction_type),
           nvl(MAX(dc.deduction_money), -1),
           nvl(MAX(dc.deduction_ratio) * 0.01, -1)
      INTO v_deduction_type, v_deduction_money, v_deduction_ratio
      FROM scmdata.t_commodity_info tc
     INNER JOIN scmdata.t_deduction_range_config dr
        ON tc.company_id = dr.company_id
       AND tc.category = dr.industry_classification
       AND tc.product_cate = dr.production_category
       AND instr(';' || dr.product_subclass || ';',
                 ';' || tc.samll_category || ';') > 0
       AND dr.pause = 0
     INNER JOIN scmdata.t_deduction_dtl_config dc
        ON dr.company_id = dc.company_id
       AND dr.deduction_config_id = dc.deduction_config_id
       AND dc.pause = 0
     INNER JOIN scmdata.t_deduction_config td
        ON td.company_id = dc.company_id
       AND td.deduction_config_id = dc.deduction_config_id
       AND td.pause = 0
     WHERE tc.company_id = p_company_id
       AND tc.goo_id = p_goo_id
       AND (p_delay_day >= dc.section_start AND
           p_delay_day < dc.section_end);
  
    po_deduction_type := v_deduction_type;
  
    --扣款总额
    IF v_deduction_type = 'METHOD_01' THEN
      po_deduction_money := v_deduction_money;
      --扣款比例
    ELSIF v_deduction_type = 'METHOD_02' THEN
      po_deduction_money := v_deduction_ratio;
    ELSE
      NULL;
    END IF;
  END get_deduction;

  --到仓日期一致则合并，生成1条扣款单
  PROCEDURE get_date_same_deduction(p_pro_rec       scmdata.t_production_progress%ROWTYPE,
                                    p_delivery_date DATE,
                                    p_orgin         VARCHAR2,
                                    p_abnormal_id   VARCHAR2) IS
    v_delay_day          NUMBER;
    v_order_price        NUMBER;
    v_deduction_type     VARCHAR2(100);
    v_deduction_money    NUMBER;
    v_discount_price     NUMBER;
    v_act_discount_price NUMBER;
    --到仓日期＞订单交期，交货日期一致的交货记录  待优化
    CURSOR p_date_cur(p_order_date DATE) IS
      SELECT DISTINCT trunc(dr.delivery_date) delivery_date,
                      dr.company_id,
                      dr.order_code,
                      dr.goo_id,
                      SUM(dr.delivery_amount) over(PARTITION BY trunc(dr.delivery_date)) delivery_amount_sum
        FROM scmdata.t_delivery_record dr
       WHERE dr.company_id = p_pro_rec.company_id
         AND dr.order_code = p_pro_rec.order_id
         AND dr.goo_id = p_pro_rec.goo_id
         AND trunc(dr.delivery_date) > trunc(p_order_date)
         AND dr.delivery_amount <> 0
         AND EXISTS
       (SELECT 1
                FROM scmdata.t_delivery_record t
               WHERE dr.company_id = t.company_id
                 AND dr.order_code = t.order_code
                 AND dr.goo_id = t.goo_id
                 AND dr.delivery_record_id <> t.delivery_record_id
                 AND trunc(dr.delivery_date) = trunc(t.delivery_date));
  BEGIN
    FOR p_date_rec IN p_date_cur(p_delivery_date) LOOP
      --延期天数计算规则：延期天数=交货记录到仓日期-订单交期
      --v_delay_day := ceil(p_date_rec.delivery_date - p_delivery_date);
      v_delay_day := get_delay_days(p_arrival_date => p_date_rec.delivery_date,
                                    p_order_date   => p_delivery_date);
    
      --判断延期天数是否在扣款配置中
      --获取扣款金额/扣款比例       
      get_deduction(p_company_id       => p_pro_rec.company_id,
                    p_goo_id           => p_pro_rec.goo_id,
                    p_delay_day        => v_delay_day,
                    po_deduction_type  => v_deduction_type,
                    po_deduction_money => v_deduction_money);
    
      --8.2 金额计算：根据订单商品（行业分类+生产类别+产品子类）及延期天数匹配相应扣款规则   
      --扣款金额
      IF v_deduction_type = 'METHOD_01' THEN
        --8.2.1 扣款金额=延期数量*商品单价*扣款比例
        v_discount_price := v_deduction_money;
      
        --8.2.2 实际扣款金额=扣款金额+调整金额
        v_act_discount_price := v_discount_price + 0;
        --扣款比例
      ELSIF v_deduction_type = 'METHOD_02' THEN
      
        --商品单价
        v_order_price := get_order_price(p_pro_rec => p_pro_rec);
      
        --8.2.3 扣款金额=延期数量*商品单价*扣款比例
        v_discount_price := p_date_rec.delivery_amount_sum * v_order_price *
                            v_deduction_money;
      
        --8.2.4 实际扣款金额=扣款金额+调整金额
        v_act_discount_price := v_discount_price + 0;
      ELSE
        NULL;
      END IF;
    
      IF v_deduction_type IS NULL THEN
        NULL;
      ELSE
        --8.2.5 生成异常单,生成扣款单
        sync_abn_ded_bill(p_company_id         => p_pro_rec.company_id,
                          p_order_id           => p_pro_rec.order_id,
                          p_goo_id             => p_pro_rec.goo_id,
                          p_create_id          => p_pro_rec.create_id,
                          p_deduction_type     => v_deduction_type,
                          p_delay_day          => v_delay_day, --延期天数
                          p_delay_amount       => p_date_rec.delivery_amount_sum, --延期数量
                          p_order_price        => v_order_price,
                          p_discount_price     => v_discount_price, --扣款金额
                          p_act_discount_price => v_act_discount_price, --实际扣款金额
                          p_orgin              => p_orgin, --来源 系统创建 SC / 手动创建 MA
                          p_arrival_date       => p_date_rec.delivery_date,
                          p_abnormal_id        => p_abnormal_id); --异常单编号，手动创建过来，则为空 
      END IF;
    
    END LOOP;
  END get_date_same_deduction;

  --到仓日期不一致，生成1条扣款单
  PROCEDURE get_date_nsame_deduction(p_pro_rec       scmdata.t_production_progress%ROWTYPE,
                                     p_delivery_date DATE,
                                     p_orgin         VARCHAR2,
                                     p_abnormal_id   VARCHAR2) IS
    v_delay_day          NUMBER;
    v_order_price        NUMBER;
    v_deduction_type     VARCHAR2(100);
    v_deduction_money    NUMBER;
    v_discount_price     NUMBER;
    v_act_discount_price NUMBER;
    --到仓日期＞订单交期，到仓日期不一致的交货记录 待优化
    CURSOR p_date_not_cur(p_order_date DATE) IS
      SELECT dr.delivery_record_id,
             dr.delivery_amount,
             trunc(dr.delivery_date) delivery_date
        FROM scmdata.t_delivery_record dr
       WHERE dr.company_id = p_pro_rec.company_id
         AND dr.order_code = p_pro_rec.order_id
         AND dr.goo_id = p_pro_rec.goo_id
         AND dr.delivery_record_id NOT IN
             (SELECT dr.delivery_record_id
                FROM scmdata.t_delivery_record dr
               INNER JOIN scmdata.t_delivery_record t
                  ON dr.company_id = t.company_id
                 AND dr.order_code = t.order_code
                 AND dr.goo_id = t.goo_id
                 AND dr.delivery_record_id <> t.delivery_record_id
                 AND trunc(dr.delivery_date) = trunc(t.delivery_date)
               WHERE dr.company_id = p_pro_rec.company_id
                 AND dr.order_code = p_pro_rec.order_id
                 AND dr.goo_id = p_pro_rec.goo_id
                 AND trunc(dr.delivery_date) > trunc(p_order_date))
         AND trunc(dr.delivery_date) > trunc(p_order_date)
         AND dr.delivery_amount <> 0;
  BEGIN
    FOR p_date_not_rec IN p_date_not_cur(p_delivery_date) LOOP
    
      --延期天数计算规则：延期天数=交货记录到仓日期-订单交期
      --v_delay_day := ceil(p_date_not_rec.delivery_date - p_delivery_date);
      v_delay_day := get_delay_days(p_arrival_date => p_date_not_rec.delivery_date,
                                    p_order_date   => p_delivery_date);
    
      --判断延期天数是否在扣款配置中
      --获取扣款比例
      get_deduction(p_company_id       => p_pro_rec.company_id,
                    p_goo_id           => p_pro_rec.goo_id,
                    p_delay_day        => v_delay_day,
                    po_deduction_type  => v_deduction_type,
                    po_deduction_money => v_deduction_money);
    
      --8.4 金额计算：根据订单商品（行业分类+生产类别+产品子类）及延期天数匹配相应扣款规则  
      --扣款金额
      IF v_deduction_type = 'METHOD_01' THEN
        --8.4.1 扣款金额=扣款金额
        v_discount_price := v_deduction_money;
        --8.4.2 实际扣款金额=扣款金额+调整金额
        v_act_discount_price := v_discount_price + 0;
        --扣款比例
      ELSIF v_deduction_type = 'METHOD_02' THEN
        --商品单价
        v_order_price := get_order_price(p_pro_rec => p_pro_rec);
      
        --8.4.3 扣款金额=延期数量*商品单价*扣款比例
        v_discount_price := p_date_not_rec.delivery_amount * v_order_price *
                            v_deduction_money;
      
        --8.4.4 实际扣款金额=扣款金额+调整金额
        v_act_discount_price := v_discount_price + 0;
      ELSE
        NULL;
      END IF;
      IF v_deduction_type IS NULL THEN
        NULL;
      ELSE
        --8.5 生成异常单,生成扣款单
        sync_abn_ded_bill(p_company_id         => p_pro_rec.company_id,
                          p_order_id           => p_pro_rec.order_id,
                          p_goo_id             => p_pro_rec.goo_id,
                          p_create_id          => p_pro_rec.create_id,
                          p_deduction_type     => v_deduction_type,
                          p_delay_day          => v_delay_day, --延期天数
                          p_delay_amount       => p_date_not_rec.delivery_amount, --延期数量
                          p_order_price        => v_order_price,
                          p_discount_price     => v_discount_price, --扣款金额
                          p_act_discount_price => v_act_discount_price, --实际扣款金额
                          p_orgin              => p_orgin, --来源 系统创建 SC / 手动创建 MA
                          p_arrival_date       => p_date_not_rec.delivery_date,
                          p_abnormal_id        => p_abnormal_id); --异常单编号，手动创建过来，则为空
      END IF;
    
    END LOOP;
  END get_date_nsame_deduction;
  --校验到仓日期的一致性
  FUNCTION check_delivery_date_same(p_pro_rec       scmdata.t_production_progress%ROWTYPE,
                                    p_delivery_date DATE) RETURN NUMBER IS
    v_date_count NUMBER;
  BEGIN
    --有交货记录时：到仓日期＞订单交期的交货记录，对应生成对应条数的扣款单
    --根据延期扣款规则配置及交货记录，生成1或多张扣款单 
    --判断到仓日期是否一致
    SELECT COUNT(1)
      INTO v_date_count
      FROM scmdata.t_delivery_record dr
     INNER JOIN scmdata.t_delivery_record t
        ON dr.company_id = t.company_id
       AND dr.order_code = t.order_code
       AND dr.goo_id = t.goo_id
       AND dr.delivery_record_id <> t.delivery_record_id
       AND trunc(dr.delivery_date) = trunc(t.delivery_date)
     WHERE dr.company_id = p_pro_rec.company_id
       AND dr.order_code = p_pro_rec.order_id
       AND dr.goo_id = p_pro_rec.goo_id
       AND trunc(dr.delivery_date) > p_delivery_date;
    IF v_date_count > 0 THEN
      RETURN 1;
    ELSE
      RETURN 0;
    END IF;
  END check_delivery_date_same;

  --校验不一致的到仓日期
  FUNCTION check_delivery_date_nsame(p_pro_rec       scmdata.t_production_progress%ROWTYPE,
                                     p_delivery_date DATE) RETURN NUMBER IS
    v_date_not_count NUMBER;
  BEGIN
    --有交货记录时：到仓日期＞订单交期的交货记录，对应生成对应条数的扣款单
    --根据延期扣款规则配置及交货记录，生成1或多张扣款单 
    --判断到仓日期是否一致
    SELECT COUNT(1)
      INTO v_date_not_count
      FROM scmdata.t_delivery_record dr
     WHERE dr.company_id = p_pro_rec.company_id
       AND dr.order_code = p_pro_rec.order_id
       AND dr.goo_id = p_pro_rec.goo_id
       AND dr.delivery_record_id NOT IN
           (SELECT dr.delivery_record_id
              FROM scmdata.t_delivery_record dr
             INNER JOIN scmdata.t_delivery_record t
                ON dr.company_id = t.company_id
               AND dr.order_code = t.order_code
               AND dr.goo_id = t.goo_id
               AND dr.delivery_record_id <> t.delivery_record_id
               AND trunc(dr.delivery_date) = trunc(t.delivery_date)
             WHERE dr.company_id = p_pro_rec.company_id
               AND dr.order_code = p_pro_rec.order_id
               AND dr.goo_id = p_pro_rec.goo_id
               AND trunc(dr.delivery_date) > p_delivery_date)
       AND trunc(dr.delivery_date) > p_delivery_date;
    IF v_date_not_count > 0 THEN
      RETURN 1;
    ELSE
      RETURN 0;
    END IF;
  END check_delivery_date_nsame;

  ----到仓日期一致则合并，生成1条扣款单(内衣)
  PROCEDURE get_uwmax_date_same_deduction(p_pro_rec           scmdata.t_production_progress%ROWTYPE,
                                          p_delivery_date     DATE,
                                          p_orgin             VARCHAR2,
                                          p_abnormal_id       VARCHAR2,
                                          p_max_delivery_date DATE) IS
    v_delay_day          NUMBER;
    v_order_price        NUMBER;
    v_deduction_type     VARCHAR2(100);
    v_deduction_money    NUMBER;
    v_discount_price     NUMBER;
    v_act_discount_price NUMBER;
    --到仓日期＞订单交期，交货日期一致的交货记录  待优化
    CURSOR p_date_cur(p_order_date DATE) IS
      SELECT DISTINCT trunc(dr.delivery_date) delivery_date,
                      dr.company_id,
                      dr.order_code,
                      dr.goo_id,
                      SUM(dr.delivery_amount) over(PARTITION BY trunc(dr.delivery_date)) delivery_amount_sum
        FROM scmdata.t_delivery_record dr
       WHERE dr.company_id = p_pro_rec.company_id
         AND dr.order_code = p_pro_rec.order_id
         AND dr.goo_id = p_pro_rec.goo_id
         AND trunc(dr.delivery_date) > trunc(p_order_date)
         AND dr.delivery_amount <> 0
         AND trunc(dr.delivery_date) = trunc(p_max_delivery_date);
  BEGIN
    FOR p_date_rec IN p_date_cur(p_delivery_date) LOOP
      --延期天数计算规则：延期天数=交货记录到仓日期-订单交期
      --v_delay_day := ceil(p_date_rec.delivery_date - p_delivery_date);
      v_delay_day := get_delay_days(p_arrival_date => p_date_rec.delivery_date,
                                    p_order_date   => p_delivery_date);
      --判断延期天数是否在扣款配置中
      --获取扣款金额/扣款比例       
      get_deduction(p_company_id       => p_pro_rec.company_id,
                    p_goo_id           => p_pro_rec.goo_id,
                    p_delay_day        => v_delay_day,
                    po_deduction_type  => v_deduction_type,
                    po_deduction_money => v_deduction_money);
    
      --8.2 金额计算：根据订单商品（行业分类+生产类别+产品子类）及延期天数匹配相应扣款规则   
      --扣款金额
      IF v_deduction_type = 'METHOD_01' THEN
        --8.2.1 扣款金额=延期数量*商品单价*扣款比例
        v_discount_price := v_deduction_money;
      
        --8.2.2 实际扣款金额=扣款金额+调整金额
        v_act_discount_price := v_discount_price + 0;
        --扣款比例
      ELSIF v_deduction_type = 'METHOD_02' THEN
      
        --商品单价
        v_order_price := get_order_price(p_pro_rec => p_pro_rec);
      
        --8.2.3 扣款金额=延期数量*商品单价*扣款比例
        v_discount_price := p_date_rec.delivery_amount_sum * v_order_price *
                            v_deduction_money;
      
        --8.2.4 实际扣款金额=扣款金额+调整金额
        v_act_discount_price := v_discount_price + 0;
      ELSE
        NULL;
      END IF;
    
      IF v_deduction_type IS NULL THEN
        NULL;
      ELSE
        --8.2.5 生成异常单,生成扣款单
        sync_abn_ded_bill(p_company_id         => p_pro_rec.company_id,
                          p_order_id           => p_pro_rec.order_id,
                          p_goo_id             => p_pro_rec.goo_id,
                          p_create_id          => p_pro_rec.create_id,
                          p_deduction_type     => v_deduction_type,
                          p_delay_day          => v_delay_day, --延期天数
                          p_delay_amount       => p_date_rec.delivery_amount_sum, --延期数量
                          p_order_price        => v_order_price,
                          p_discount_price     => v_discount_price, --扣款金额
                          p_act_discount_price => v_act_discount_price, --实际扣款金额
                          p_orgin              => p_orgin, --来源 系统创建 SC / 手动创建 MA
                          p_arrival_date       => p_date_rec.delivery_date,
                          p_abnormal_id        => p_abnormal_id); --异常单编号，手动创建过来，则为空 
      END IF;
    
    END LOOP;
  END get_uwmax_date_same_deduction;

  --到仓日期不一致，生成1条扣款单(内衣)
  PROCEDURE get_uwmax_date_nsame_deduction(p_pro_rec           scmdata.t_production_progress%ROWTYPE,
                                           p_delivery_date     DATE,
                                           p_orgin             VARCHAR2,
                                           p_abnormal_id       VARCHAR2,
                                           p_max_delivery_date DATE) IS
    v_delay_day          NUMBER;
    v_order_price        NUMBER;
    v_deduction_type     VARCHAR2(100);
    v_deduction_money    NUMBER;
    v_discount_price     NUMBER;
    v_act_discount_price NUMBER;
    v_delivery_amount    NUMBER;
  
  BEGIN
    SELECT dr.delivery_amount
      INTO v_delivery_amount
      FROM scmdata.t_delivery_record dr
     WHERE dr.company_id = p_pro_rec.company_id
       AND dr.order_code = p_pro_rec.order_id
       AND dr.goo_id = p_pro_rec.goo_id
       AND trunc(dr.delivery_date) = trunc(p_max_delivery_date);
  
    --延期天数计算规则：延期天数=交货记录到仓日期-订单交期
    --v_delay_day := trunc(p_max_delivery_date) - trunc(p_delivery_date);
    v_delay_day := get_delay_days(p_arrival_date => p_max_delivery_date,
                                  p_order_date   => p_delivery_date);
  
    --判断延期天数是否在扣款配置中
    --获取扣款比例
    get_deduction(p_company_id       => p_pro_rec.company_id,
                  p_goo_id           => p_pro_rec.goo_id,
                  p_delay_day        => v_delay_day,
                  po_deduction_type  => v_deduction_type,
                  po_deduction_money => v_deduction_money);
  
    --8.4 金额计算：根据订单商品（行业分类+生产类别+产品子类）及延期天数匹配相应扣款规则  
    --扣款金额
    IF v_deduction_type = 'METHOD_01' THEN
      --8.4.1 扣款金额=扣款金额
      v_discount_price := v_deduction_money;
      --8.4.2 实际扣款金额=扣款金额+调整金额
      v_act_discount_price := v_discount_price + 0;
      --扣款比例
    ELSIF v_deduction_type = 'METHOD_02' THEN
      --商品单价
      v_order_price := get_order_price(p_pro_rec => p_pro_rec);
    
      --8.4.3 扣款金额=延期数量*商品单价*扣款比例
      v_discount_price := v_delivery_amount * v_order_price *
                          v_deduction_money;
    
      --8.4.4 实际扣款金额=扣款金额+调整金额
      v_act_discount_price := v_discount_price + 0;
    ELSE
      NULL;
    END IF;
    IF v_deduction_type IS NULL THEN
      NULL;
    ELSE
      --8.5 生成异常单,生成扣款单
      sync_abn_ded_bill(p_company_id         => p_pro_rec.company_id,
                        p_order_id           => p_pro_rec.order_id,
                        p_goo_id             => p_pro_rec.goo_id,
                        p_create_id          => p_pro_rec.create_id,
                        p_deduction_type     => v_deduction_type,
                        p_delay_day          => v_delay_day, --延期天数
                        p_delay_amount       => v_delivery_amount, --延期数量
                        p_order_price        => v_order_price,
                        p_discount_price     => v_discount_price, --扣款金额
                        p_act_discount_price => v_act_discount_price, --实际扣款金额
                        p_orgin              => p_orgin, --来源 系统创建 SC / 手动创建 MA
                        p_arrival_date       => trunc(p_max_delivery_date),
                        p_abnormal_id        => p_abnormal_id); --异常单编号，手动创建过来，则为空
    END IF;
  
  END get_uwmax_date_nsame_deduction;

  --内衣-取最迟的交货记录,仅生成1条延期扣款
  PROCEDURE get_uwmax_delivery_date(p_pro_rec       scmdata.t_production_progress%ROWTYPE,
                                    p_delivery_date DATE,
                                    p_orgin         VARCHAR2,
                                    p_abnormal_id   VARCHAR2) IS
    v_max_delivery_date DATE;
    v_date_count        NUMBER;
  BEGIN
    --获取最迟的交货记录
    SELECT MAX(DISTINCT dr.delivery_date)
      INTO v_max_delivery_date
      FROM scmdata.t_delivery_record dr
     WHERE dr.company_id = p_pro_rec.company_id
       AND dr.order_code = p_pro_rec.order_id
       AND dr.goo_id = p_pro_rec.goo_id;
  
    --判断到仓日期是否一致
    SELECT COUNT(1)
      INTO v_date_count
      FROM scmdata.t_delivery_record dr
     INNER JOIN scmdata.t_delivery_record t
        ON dr.company_id = t.company_id
       AND dr.order_code = t.order_code
       AND dr.goo_id = t.goo_id
       AND dr.delivery_record_id <> t.delivery_record_id
       AND trunc(dr.delivery_date) = trunc(t.delivery_date)
     WHERE dr.company_id = p_pro_rec.company_id
       AND dr.order_code = p_pro_rec.order_id
       AND dr.goo_id = p_pro_rec.goo_id
       AND trunc(dr.delivery_date) > p_delivery_date
       AND dr.delivery_date = v_max_delivery_date;
    --如到仓日期一致则合并为1条扣款单；
    IF v_date_count > 0 THEN
      get_uwmax_date_same_deduction(p_pro_rec           => p_pro_rec,
                                    p_delivery_date     => p_delivery_date,
                                    p_orgin             => p_orgin,
                                    p_abnormal_id       => p_abnormal_id,
                                    p_max_delivery_date => v_max_delivery_date);
      --到仓日期不一致，则生成另一扣款单
    ELSE
      get_uwmax_date_nsame_deduction(p_pro_rec           => p_pro_rec,
                                     p_delivery_date     => p_delivery_date,
                                     p_orgin             => p_orgin,
                                     p_abnormal_id       => p_abnormal_id,
                                     p_max_delivery_date => v_max_delivery_date);
    END IF;
  END get_uwmax_delivery_date;

  --原始到仓日期按配置规则进行转换=》到仓确定日期
  PROCEDURE transform_delivery_date(p_delivery_rec          scmdata.t_delivery_record%ROWTYPE,
                                    p_deduction_change_time DATE) IS
    v_deadline_time     VARCHAR2(32); --延期变更截止时间 
    v_deadline_date     VARCHAR2(32); --原始到仓日期
    v_deadline_dtime    DATE;
    v_deadline_dtime_bf DATE;
    v_deadline_dtime_af DATE;
    v_transform_date    DATE; --转换后的到仓确定日期
  BEGIN
    v_deadline_date := to_char(trunc(p_delivery_rec.delivery_origin_time),
                               'yyyy-mm-dd');
    v_deadline_time := to_char(p_deduction_change_time, 'hh24:mi:ss');
    --当天v_deadline_time
    v_deadline_dtime := to_date(v_deadline_date || ' ' || v_deadline_time,
                                'yyyy-mm-dd hh24:mi:ss');
    --前一天v_deadline_time
    v_deadline_dtime_bf := v_deadline_dtime - 1;
    --后一天v_deadline_time
    v_deadline_dtime_af := v_deadline_dtime + 1;
    --判断原始到仓日期是否在区间
    --注：到仓确定日期 只限制到日期，此后生成扣款逻辑，均按此日期计算
    --1）区间(前一天v_deadline_time,当天v_deadline_time]，到仓确定日期：前一天
    --2）区间(当天v_deadline_time,后一天v_deadline_time]，到仓确定日期：当天 
    IF p_delivery_rec.delivery_origin_time > v_deadline_dtime_bf AND
       p_delivery_rec.delivery_origin_time <= v_deadline_dtime THEN
    
      v_transform_date := trunc(v_deadline_dtime_bf);
    
    ELSIF p_delivery_rec.delivery_origin_time > v_deadline_dtime AND
          p_delivery_rec.delivery_origin_time <= v_deadline_dtime_af THEN
      
      v_transform_date := trunc(v_deadline_dtime);
    
    ELSE
      raise_application_error(-20002,
                              '原始到仓日期按配置规则进行转换成到仓确定日期失败，请联系管理员！！');
    END IF;
  
    UPDATE scmdata.t_delivery_record dr
       SET dr.delivery_date = v_transform_date
     WHERE dr.delivery_record_id = p_delivery_rec.delivery_record_id;
  
  END transform_delivery_date;

  --转换原始到仓日期=》到仓确定日期
  PROCEDURE tranf_deduction_config(p_delivery_rec scmdata.t_delivery_record%ROWTYPE) IS
    vo_count                 NUMBER;
    vo_deduction_change_time DATE; --延期变更截止时间
  BEGIN
    --1. 订单商品（行业分类+生产类别+产品子类）与延期扣款规则配置任一模型匹配；
    check_deduction_config(p_company_id       => p_delivery_rec.company_id,
                           p_goo_id           => p_delivery_rec.goo_id,
                           p_status           => 1,
                           po_count           => vo_count,
                           po_ded_change_time => vo_deduction_change_time);
  
    IF vo_count > 0 AND vo_deduction_change_time IS NOT NULL THEN
      --按延期变更截止时间  转换原始到仓日期=》到仓确定日期 
      transform_delivery_date(p_delivery_rec          => p_delivery_rec,
                              p_deduction_change_time => vo_deduction_change_time);
    ELSE
      --无转换规则，不作处理。接口同步时，到仓确定日期 默认等于 原始到仓日期
      NULL;
    END IF;
  
  END tranf_deduction_config;

  --订单商品（行业分类+生产类别+产品子类）与延期扣款规则配置任一模型匹配
  PROCEDURE check_deduction_config(p_company_id       VARCHAR2,
                                   p_goo_id           VARCHAR2,
                                   p_status           NUMBER,
                                   po_count           OUT NUMBER,
                                   po_ded_change_time OUT DATE) IS
    v_count           NUMBER;
    v_ded_change_time DATE;
  BEGIN
    SELECT COUNT(1), MAX(td.deduction_change_time)
      INTO v_count, v_ded_change_time
      FROM scmdata.t_commodity_info tc
     INNER JOIN scmdata.t_deduction_range_config dr
        ON tc.company_id = dr.company_id
       AND tc.category = dr.industry_classification
       AND tc.product_cate = dr.production_category
       AND instr(';' || dr.product_subclass || ';',
                 ';' || tc.samll_category || ';') > 0
       AND dr.pause = 0
     INNER JOIN scmdata.t_deduction_dtl_config dc
        ON dr.company_id = dc.company_id
       AND dr.deduction_config_id = dc.deduction_config_id
       AND dc.pause = 0
     INNER JOIN scmdata.t_deduction_config td
        ON td.company_id = dc.company_id
       AND td.deduction_config_id = dc.deduction_config_id
       AND td.pause = 0
     WHERE tc.company_id = p_company_id
       AND tc.goo_id = p_goo_id;
  
    IF p_status = 0 THEN
      po_count           := v_count;
      po_ded_change_time := NULL;
    ELSIF p_status = 1 THEN
      po_count           := v_count;
      po_ded_change_time := v_ded_change_time;
    ELSE
      NULL;
    END IF;
  
  END check_deduction_config;

  /*============================================*
  * Author   : CZH
  * Created  : 2021-01-04 15:19:42
  * ALERTER  : 
  * ALERTER_TIME  : 
  * Purpose  : 自动创建的扣款单
  * Obj_Name    : SYNC_DEDUCTION
  * Arg_Number  : 3
  * P_PRO_REC : 生产进度
  * P_ORGIN : 来源 系统创建 SC / 手动创建 MA
  * P_ABNORMAL_ID : 异常单编号，手动创建过来，则为空
  *============================================*/

  PROCEDURE sync_deduction(p_pro_rec     scmdata.t_production_progress%ROWTYPE,
                           p_orgin       VARCHAR2, --来源 系统创建 SC / 手动创建 MA
                           p_abnormal_id VARCHAR2) IS
    --异常单编号，手动创建过来，则为空
    vo_count           NUMBER;
    vo_ded_change_time DATE;
    --v_order_price    NUMBER;
    v_category       VARCHAR2(100);
    v_delivery_date  DATE;
    v_date_count     NUMBER;
    v_date_not_count NUMBER;
  
  BEGIN
    --订单交期
    SELECT trunc(po.delivery_date)
      INTO v_delivery_date
      FROM scmdata.t_ordered po
     WHERE po.company_id = p_pro_rec.company_id
       AND po.order_code = p_pro_rec.order_id;
  
    /*    --商品单价
    SELECT ln.order_price
      INTO v_order_price --商品单价
      FROM scmdata.t_orders ln
     WHERE p_pro_rec.company_id = ln.company_id
       AND p_pro_rec.order_id = ln.order_id;*/
    --AND p_pro_rec.goo_id = ln.goo_id; 注释原因：业务更改，现订单对商品是一对一关系。取订单商品单价
  
    --1. 订单商品（行业分类+生产类别+产品子类）与延期扣款规则配置任一模型匹配才需生成，所生成的异常分类为“交期异常”；
    check_deduction_config(p_company_id       => p_pro_rec.company_id,
                           p_goo_id           => p_pro_rec.goo_id,
                           p_status           => 0,
                           po_count           => vo_count,
                           po_ded_change_time => vo_ded_change_time);
  
    --2. 延期扣款规则无配置时不作处理,有配置时进行以下操作
    IF vo_count > 0 THEN
      SELECT tc.category
        INTO v_category
        FROM scmdata.t_commodity_info tc
       WHERE tc.company_id = p_pro_rec.company_id
         AND tc.goo_id = p_pro_rec.goo_id;
    
      --3.由于内衣分部扣款与其他分部扣款方式不同，经沟通延期扣款-内衣分部暂先做以下特殊的处理：   
      --其他分类按原规则处理
      IF v_category <> '03' THEN
        --4.有交货记录时：到仓日期＞订单交期的交货记录，对应生成对应条数的扣款单
        -- 根据延期扣款规则配置及交货记录，生成1或多张扣款单 
        --判断到仓日期是否一致
        v_date_count := check_delivery_date_same(p_pro_rec       => p_pro_rec,
                                                 p_delivery_date => v_delivery_date);
      
        --5.如到仓日期一致则合并为1条扣款单；
        IF v_date_count > 0 THEN
        
          get_date_same_deduction(p_pro_rec       => p_pro_rec,
                                  p_delivery_date => v_delivery_date,
                                  p_orgin         => p_orgin,
                                  p_abnormal_id   => p_abnormal_id);
        END IF;
      
        v_date_not_count := check_delivery_date_nsame(p_pro_rec       => p_pro_rec,
                                                      p_delivery_date => v_delivery_date);
      
        --6.到仓日期不一致，则生成另一扣款单
        IF v_date_not_count > 0 THEN
          get_date_nsame_deduction(p_pro_rec       => p_pro_rec,
                                   p_delivery_date => v_delivery_date,
                                   p_orgin         => p_orgin,
                                   p_abnormal_id   => p_abnormal_id);
        END IF;
      
      ELSE
        --1）仅生成1条延期扣款，
        --2）取最迟的交货记录；延期天数（存在多条记录日期相同记录则按原有规则进行合并）
        --3）订单商品（分类+生产类型+产品子类）+延期天数，匹配延期扣款配置进行计算扣款（匹配规则及计算规则与原有规则一致）。
        get_uwmax_delivery_date(p_pro_rec       => p_pro_rec,
                                p_delivery_date => v_delivery_date,
                                p_orgin         => p_orgin,
                                p_abnormal_id   => p_abnormal_id);
      
      END IF;
    
    END IF;
  
  END sync_deduction;

  /*============================================*
  * Author   : CZH
  * Created  : 2021-01-04 15:20:50
  * ALERTER  : 
  * ALERTER_TIME  : 
  * Purpose  : 生成异常单，扣款单
  * Obj_Name    : SYNC_ABN_DED_BILL
  * Arg_Number  : 10
  * P_COMPANY_ID :公司ID
  * P_ORDER_ID :订单ID
  * P_GOO_ID :商品档案编号
  * P_CREATE_ID :创建人
  * P_DELAY_DAY :延期天数
  * P_DELAY_AMOUNT :延期数量
  * P_DISCOUNT_PRICE :扣款金额
  * P_ACT_DISCOUNT_PRICE :实际扣款金额
  * P_ORGIN :来源 系统创建 SC / 手动创建 MA
  * P_ABNORMAL_ID :异常单编号，手动创建过来，则为空
  *============================================*/
  PROCEDURE sync_abn_ded_bill(p_company_id         VARCHAR2,
                              p_order_id           VARCHAR2,
                              p_goo_id             VARCHAR2,
                              p_create_id          VARCHAR2,
                              p_deduction_type     VARCHAR2 DEFAULT NULL,
                              p_delay_day          NUMBER,
                              p_delay_amount       NUMBER,
                              p_order_price        NUMBER,
                              p_discount_price     NUMBER,
                              p_act_discount_price NUMBER,
                              p_orgin              VARCHAR2, --来源 系统创建 SC / 手动创建 MA
                              p_arrival_date       DATE DEFAULT NULL, --到仓日期（供打印报表使用）
                              p_abnormal_id        VARCHAR2) IS
    --异常单编号，手动创建过来，则为空
    p_abn_rec          scmdata.t_abnormal%ROWTYPE;
    p_duc_rec          scmdata.t_deduction%ROWTYPE;
    v_abnormal_id      VARCHAR2(100);
    v_deduction_method VARCHAR2(32);
  BEGIN
    --1.系统创建
    IF p_orgin = 'SC' THEN
      v_abnormal_id := scmdata.f_get_uuid();
      --1.1 生成异常单
      p_abn_rec.abnormal_id          := v_abnormal_id;
      p_abn_rec.company_id           := p_company_id;
      p_abn_rec.abnormal_code        := scmdata.pkg_plat_comm.f_getkeycode(pi_table_name  => 't_abnormal',
                                                                           pi_column_name => 'abnormal_code',
                                                                           pi_company_id  => p_company_id,
                                                                           pi_pre         => 'ABN',
                                                                           pi_serail_num  => '6');
      p_abn_rec.order_id             := p_order_id;
      p_abn_rec.progress_status      := '02';
      p_abn_rec.goo_id               := p_goo_id;
      p_abn_rec.anomaly_class        := 'AC_DATE';
      p_abn_rec.problem_class        := ' ';
      p_abn_rec.cause_class          := ' ';
      p_abn_rec.detailed_reasons     := '延期扣款';
      p_abn_rec.delay_date           := nvl(p_delay_day, 0);
      p_abn_rec.delay_amount         := nvl(p_delay_amount, 0); --延期数量
      p_abn_rec.responsible_party    := ' ';
      p_abn_rec.responsible_dept     := ' ';
      p_abn_rec.handle_opinions      := '';
      p_abn_rec.quality_deduction    := 0;
      p_abn_rec.is_deduction         := 1;
      p_abn_rec.deduction_method     := p_deduction_type;
      p_abn_rec.deduction_unit_price := 0;
      p_abn_rec.applicant_id         := p_create_id;
      p_abn_rec.applicant_date       := SYSDATE;
      p_abn_rec.create_id            := p_create_id;
      p_abn_rec.create_time          := SYSDATE;
      p_abn_rec.origin               := p_orgin;
    
      scmdata.pkg_production_progress.handle_abnormal(p_abn_rec => p_abn_rec);
    
      --1.2 生成扣款单
      p_duc_rec.deduction_id          := scmdata.f_get_uuid();
      p_duc_rec.company_id            := p_company_id;
      p_duc_rec.order_company_id      := '';
      p_duc_rec.order_id              := p_order_id;
      p_duc_rec.abnormal_id           := v_abnormal_id;
      p_duc_rec.deduction_status      := '00'; --待处理
      p_duc_rec.discount_unit_price   := nvl(p_order_price, 0);
      p_duc_rec.discount_type         := '';
      p_duc_rec.discount_proportion   := '';
      p_duc_rec.discount_price        := nvl(p_discount_price, 0); --扣款金额
      p_duc_rec.adjust_type           := '';
      p_duc_rec.adjust_proportion     := '';
      p_duc_rec.adjust_price          := 0; --调整金额，初始为0
      p_duc_rec.adjust_reason         := '';
      p_duc_rec.actual_discount_price := nvl(p_act_discount_price, 0); --实际扣款金额
      p_duc_rec.create_id             := p_create_id;
      p_duc_rec.create_time           := SYSDATE;
      p_duc_rec.memo                  := '';
      p_duc_rec.orgin                 := p_orgin; --来源。系统创建
      p_duc_rec.arrival_date          := p_arrival_date; --到仓日期
    
      scmdata.pkg_production_progress.insert_deduction(p_duc_rec => p_duc_rec);
      --2.手动创建 
    ELSIF p_orgin = 'MA' THEN
      v_abnormal_id := p_abnormal_id;
    
      SELECT ar.deduction_method
        INTO v_deduction_method
        FROM scmdata.t_abnormal ar
       WHERE ar.abnormal_id = p_abnormal_id;
    
      --2.1 生成扣款单
      p_duc_rec.deduction_id     := scmdata.f_get_uuid();
      p_duc_rec.company_id       := p_company_id;
      p_duc_rec.order_company_id := '';
      p_duc_rec.order_id         := p_order_id;
      p_duc_rec.abnormal_id      := v_abnormal_id;
      p_duc_rec.deduction_status := '00'; --待处理
      --按扣款方式给扣款单价赋值
      IF v_deduction_method = 'METHOD_00' OR
         v_deduction_method = 'METHOD_02' THEN
        p_duc_rec.discount_unit_price := nvl(p_order_price, 0);
      ELSE
        p_duc_rec.discount_unit_price := nvl('', 0);
      END IF;
      p_duc_rec.discount_type       := '';
      p_duc_rec.discount_proportion := '';
      p_duc_rec.discount_price      := nvl(p_discount_price, 0); --扣款金额
      --按扣款方式给扣款金额赋值
      /*      IF v_deduction_method = 'METHOD_01' THEN
        p_duc_rec.discount_price := nvl(p_discount_price, 0); --扣款金额
      ELSE
        p_duc_rec.discount_price := nvl('', 0);
      END IF;*/
      p_duc_rec.adjust_type           := '';
      p_duc_rec.adjust_proportion     := '';
      p_duc_rec.adjust_price          := 0; --调整金额，初始为0
      p_duc_rec.adjust_reason         := '';
      p_duc_rec.actual_discount_price := nvl(p_act_discount_price, 0); --实际扣款金额
      p_duc_rec.create_id             := p_create_id;
      p_duc_rec.create_time           := SYSDATE;
      p_duc_rec.memo                  := '';
      p_duc_rec.orgin                 := p_orgin; --来源。手动创建
      p_duc_rec.arrival_date          := p_arrival_date; --到仓日期
    
      scmdata.pkg_production_progress.insert_deduction(p_duc_rec => p_duc_rec);
    
    END IF;
  
  END sync_abn_ded_bill;

  /*============================================*
  * Author   : CZH
  * Created  : 2021-01-04 15:22:23
  * ALERTER  : 
  * ALERTER_TIME  : 
  * Purpose  : 新增扣款明细
  * Obj_Name    : INSERT_DEDUCTION
  * Arg_Number  : 1
  * P_DUC_REC :扣款单
  *============================================*/

  PROCEDURE insert_deduction(p_duc_rec scmdata.t_deduction%ROWTYPE) IS
  BEGIN
    INSERT INTO t_deduction
      (deduction_id,
       company_id,
       order_company_id,
       order_id,
       abnormal_id,
       deduction_status,
       discount_unit_price,
       discount_type,
       discount_proportion,
       discount_price,
       adjust_type,
       adjust_proportion,
       adjust_price,
       adjust_reason,
       actual_discount_price,
       create_id,
       create_time,
       memo,
       orgin,
       arrival_date)
    VALUES
      (p_duc_rec.deduction_id,
       p_duc_rec.company_id,
       p_duc_rec.order_company_id,
       p_duc_rec.order_id,
       p_duc_rec.abnormal_id,
       p_duc_rec.deduction_status,
       p_duc_rec.discount_unit_price,
       p_duc_rec.discount_type,
       p_duc_rec.discount_proportion,
       p_duc_rec.discount_price,
       p_duc_rec.adjust_type,
       p_duc_rec.adjust_proportion,
       p_duc_rec.adjust_price,
       p_duc_rec.adjust_reason,
       p_duc_rec.actual_discount_price,
       p_duc_rec.create_id,
       p_duc_rec.create_time,
       p_duc_rec.memo,
       p_duc_rec.orgin,
       p_duc_rec.arrival_date);
  
  END;

END pkg_production_progress;
/
