﻿CREATE OR REPLACE PACKAGE SCMDATA.pkg_plat_log IS

  -- Author  : SANFU
  -- Created : 2022/5/25 11:33:52
  -- Purpose : 平台通用操作日志

  --平台通用日志记录
  PROCEDURE p_record_plat_log(p_company_id         VARCHAR2,
                              p_apply_module       VARCHAR2,
                              p_base_table         VARCHAR2,
                              p_apply_pk_id        VARCHAR2,
                              p_action_type        VARCHAR2,
                              p_seq_no             INT DEFAULT 1,
                              p_log_id             VARCHAR2 DEFAULT NULL,
                              p_log_msg            CLOB DEFAULT NULL,
                              p_log_dict_type      VARCHAR2 DEFAULT NULL,
                              p_log_type           VARCHAR2,
                              p_is_logs            INT DEFAULT 1,
                              p_field_desc         VARCHAR2 DEFAULT NULL,
                              p_operate_field      VARCHAR2 DEFAULT NULL,
                              p_field_type         VARCHAR2 DEFAULT NULL,
                              p_old_code           VARCHAR2 DEFAULT NULL,
                              p_new_code           VARCHAR2 DEFAULT NULL,
                              p_old_value          VARCHAR2 DEFAULT NULL,
                              p_new_value          VARCHAR2 DEFAULT NULL,
                              p_user_id            VARCHAR2,
                              p_operate_company_id VARCHAR2,
                              p_memo               VARCHAR2 DEFAULT NULL,
                              p_memo_desc          CLOB DEFAULT NULL,
                              p_is_show            INT DEFAULT 1,
                              po_log_id            OUT VARCHAR2,
                              p_type               INT DEFAULT 0);
  --更新日志主表log_msg
  PROCEDURE p_update_plat_logmsg(p_company_id        VARCHAR2,
                                 p_log_id            VARCHAR2,
                                 p_log_msg           CLOB DEFAULT NULL,
                                 p_is_logsmsg        INT DEFAULT 1,
                                 p_is_flhide_fileds  INT DEFAULT 0,
                                 p_is_splice_fields  INT DEFAULT 0,
                                 p_is_show_memo_desc INT DEFAULT 0,
                                 p_type              INT DEFAULT 0);

  --获取日志明细，拼接log_msg字段
  PROCEDURE p_plat_log_msg(p_log_id            VARCHAR2,
                           p_company_id        VARCHAR2,
                           p_is_splice_fields  INT DEFAULT 0,
                           p_is_flhide_fileds  INT DEFAULT 0,
                           p_is_show_memo_desc INT DEFAULT 0,
                           po_log_msg          OUT CLOB,
                           po_log_msg_f        OUT CLOB);
  --新增日志
  PROCEDURE p_insert_t_plat_log(p_company_id         VARCHAR2,
                                p_apply_module       VARCHAR2,
                                p_base_table         VARCHAR2,
                                p_apply_pk_id        VARCHAR2,
                                p_action_type        VARCHAR2,
                                p_log_dict_type      VARCHAR2 DEFAULT NULL,
                                p_log_type           VARCHAR2,
                                p_log_msg            VARCHAR2,
                                p_user_id            VARCHAR2,
                                p_operate_company_id VARCHAR2,
                                po_log_id            OUT VARCHAR2);
  --新增日志明细
  PROCEDURE p_insert_plat_logs(p_log_id        VARCHAR2,
                               p_company_id    VARCHAR2,
                               p_field_desc    VARCHAR2,
                               p_operate_field VARCHAR2,
                               p_field_type    VARCHAR2,
                               p_old_code      VARCHAR2,
                               p_new_code      VARCHAR2,
                               p_old_value     VARCHAR2,
                               p_new_value     VARCHAR2,
                               p_memo          VARCHAR2,
                               p_memo_desc     CLOB,
                               p_is_show       INT DEFAULT 1,
                               p_seq_no        INT);
  --判断字段新旧值是否相等
  FUNCTION f_is_check_fields_eq(p_old_field VARCHAR2, p_new_field VARCHAR2)
    RETURN INT;
  --日志同步至plm、mrp
  PROCEDURE p_insert_plat_log_to_plm_or_mrp(p_log_id      VARCHAR2,
                                            p_log_msg     VARCHAR2,
                                            p_class_name  VARCHAR2 DEFAULT NULL,
                                            p_method_name VARCHAR2 DEFAULT NULL,
                                            p_type        INT DEFAULT 0);
  --获取日志字典名称
  FUNCTION f_get_log_type_dict_name(p_log_dict_type VARCHAR2,
                                    p_log_type      VARCHAR2) RETURN VARCHAR2;

  --记录平台操作日志（全平台）  
  --p_type :0 scm 1 plm 2 mrp
  PROCEDURE p_sync_record_plat_log(p_company_id         VARCHAR2,
                                   p_apply_module       VARCHAR2,
                                   p_apply_module_desc  VARCHAR2,
                                   p_base_table         VARCHAR2,
                                   p_apply_pk_id        VARCHAR2,
                                   p_action_type        VARCHAR2,
                                   p_log_dict_type      VARCHAR2,
                                   p_log_type           VARCHAR2,
                                   p_log_msg            CLOB,
                                   p_operate_field      VARCHAR2,
                                   p_field_type         VARCHAR2,
                                   p_field_desc         VARCHAR2,
                                   p_old_code           VARCHAR2 DEFAULT NULL,
                                   p_new_code           VARCHAR2 DEFAULT NULL,
                                   p_old_value          VARCHAR2 DEFAULT NULL,
                                   p_new_value          VARCHAR2 DEFAULT NULL,
                                   p_operate_company_id VARCHAR2,
                                   p_user_id            VARCHAR2,
                                   p_memo               VARCHAR2 DEFAULT NULL,
                                   p_memo_desc          CLOB DEFAULT NULL,
                                   p_type               INT DEFAULT 0);

  /*=========================================================*
  * Author        : CZH55
  * Created_Time  : 2023-06-01 14:05:40
  * Alerter       : 
  * Alerter_Time  : 
  * Purpose       : 单据变更溯源
  * Obj_Name      : P_DOCUMENT_CHANGE_TRACE
  * Arg_Number    : 6
  * < IN PARAMS > : 6
  * P_COMPANY_ID  : 企业ID（品牌方） 
  * P_DOCUMENT_ID : 单据ID （可以分号;作分隔符，进行拼接多张单据ID） 如：一张单：A001  多张单：A001;B001;C001
  * P_DATA_SOURCE_PARENT_CODE : 数据来源父级编码（多级数据字典中，操作日志对应字典编码）
  * P_DATA_SOURCE_CHILD_CODE : 数据来源子级编码（多级数据字典中，操作日志对应字典编码）
  * P_OPERATE_COMPANY_ID : 操作方企业ID
  * P_USER_ID     : 当前操作人
  *=========================================================*/
  PROCEDURE p_document_change_trace(p_company_id              VARCHAR2,
                                    p_document_id             VARCHAR2,
                                    p_data_source_parent_code VARCHAR2,
                                    p_data_source_child_code  VARCHAR2,
                                    p_operate_company_id      VARCHAR2,
                                    p_user_id                 VARCHAR2);

  /*=========================================================*
  * Author        : CZH55
  * Created_Time  : 2023-06-07 14:14:30
  * Alerter       : 
  * Alerter_Time  : 
  * Purpose       : 根据单据变更溯源表 返回参数
  * Obj_Name      : P_GET_DOCUMENT_CHANGE_TRACE_PARAMS
  * Arg_Number    : 3
  * < IN PARAMS > : 2
  * P_COMPANY_ID  : 企业ID （品牌方）
  * P_DOCUMENT_ID : 单据ID
  * < OUT PARAMS >: 1
  * PO_DOCUMENT_REC : 单据变更溯源表记录
  *=========================================================*/
  PROCEDURE p_get_document_change_trace_params(p_company_id    VARCHAR2,
                                               p_document_id   VARCHAR2,
                                               po_document_rec OUT scmdata.t_document_change_trace%ROWTYPE);
END pkg_plat_log;
/

CREATE OR REPLACE PACKAGE BODY SCMDATA.pkg_plat_log IS

  /*============================================*
  * Author   : CZH
  * Created  : 2022-05-21 09:15:53
  * ALERTER  :
  * ALERTER_TIME  :
  * Purpose  :  平台通用日志记录
  * Obj_Name    : P_RECORD_PLAT_LOG
  * Arg_Number  : 19
  * < IN PARAMS >
  * P_COMPANY_ID : 企业ID
  * P_APPLY_MODULE : 应用模块  item_id
  * P_BASE_TABLE : 基表（针对字段发生该表的表）
  * P_APPLY_PK_ID : 基表主键ID
  * P_ACTION_TYPE : 操作类型 例：UPDATE 、INSERT
  * P_SEQ_NO : 日志明细序号，用于排序
  * P_LOG_ID : 日志主表ID （选填）：1.默认为空，自动生成  2.可传参，用于校验日志主表是否已存在该LOG_ID：是 则无操作，否 则生成主表LOG_ID
  * P_LOG_MSG : 日志主表 操作内容（选填） ：1.默认为空 可拼接日志明细  2.可传参，自定义操作内容
  * P_LOG_TYPE : 日志类型，取操作字典。如 生产进度，延期原因等
  * P_FIELD_DESC :字段描述
  * P_OPERATE_FIELD :操作字段 记录单字段（常用）,多字段（特殊情况）
  * P_FIELD_TYPE : 字段类型 记录字段常用类型：VARCHAR,NUMBER,DATE等
  * P_OLD_CODE : 旧值编码 （选填）
  * P_NEW_CODE : 新值编码（选填）
  * P_OLD_VALUE : 旧值
  * P_NEW_VALUE : 新值
  * p_MEMO_DESC :操作原因
  * P_USER_ID : 操作人
  * P_OPERATE_COMPANY_ID : 操作方企业
  * P_TYPE               :日志记录类型 （默认0：仅记录至平台操作日志；1：日志同步至 plm；2：日志同步至mrp）
  * < OUT PARAMS >
  * PO_LOG_ID : 日志主表ID
  *============================================*/

  PROCEDURE p_record_plat_log(p_company_id         VARCHAR2,
                              p_apply_module       VARCHAR2,
                              p_base_table         VARCHAR2,
                              p_apply_pk_id        VARCHAR2,
                              p_action_type        VARCHAR2,
                              p_seq_no             INT DEFAULT 1,
                              p_log_id             VARCHAR2 DEFAULT NULL,
                              p_log_msg            CLOB DEFAULT NULL,
                              p_log_dict_type      VARCHAR2 DEFAULT NULL,
                              p_log_type           VARCHAR2,
                              p_is_logs            INT DEFAULT 1,
                              p_field_desc         VARCHAR2 DEFAULT NULL,
                              p_operate_field      VARCHAR2 DEFAULT NULL,
                              p_field_type         VARCHAR2 DEFAULT NULL,
                              p_old_code           VARCHAR2 DEFAULT NULL,
                              p_new_code           VARCHAR2 DEFAULT NULL,
                              p_old_value          VARCHAR2 DEFAULT NULL,
                              p_new_value          VARCHAR2 DEFAULT NULL,
                              p_user_id            VARCHAR2,
                              p_operate_company_id VARCHAR2,
                              p_memo               VARCHAR2 DEFAULT NULL,
                              p_memo_desc          CLOB DEFAULT NULL,
                              p_is_show            INT DEFAULT 1,
                              po_log_id            OUT VARCHAR2,
                              p_type               INT DEFAULT 0) IS
    v_log_id      VARCHAR2(32) := p_log_id;
    v_flag        INT;
    v_method_name VARCHAR2(256);
  BEGIN
    --判断是否需要新增日志明细
    --0: 否
    IF p_is_logs = 0 THEN
      p_insert_t_plat_log(p_company_id         => p_company_id,
                          p_apply_module       => p_apply_module,
                          p_base_table         => upper(p_base_table),
                          p_apply_pk_id        => p_apply_pk_id,
                          p_action_type        => upper(p_action_type),
                          p_log_dict_type      => p_log_dict_type,
                          p_log_type           => p_log_type,
                          p_log_msg            => p_log_msg, --1.手动编写 2.如有日志明细 则设置自动赋值
                          p_user_id            => p_user_id,
                          p_operate_company_id => p_operate_company_id,
                          po_log_id            => v_log_id);
    ELSE
      --1：是
      --判断新旧值是否一致
      --一致 不做操作
      --否则  新增日志
      IF scmdata.pkg_plat_log.f_is_check_fields_eq(p_old_value, p_new_value) = 0 THEN
        --判断是否日志主表是否已存在LOG_ID
        SELECT COUNT(1)
          INTO v_flag
          FROM scmdata.t_plat_log t
         WHERE t.log_id = v_log_id;
        --新增日志主表
        IF v_flag > 0 THEN
          NULL;
        ELSE
          p_insert_t_plat_log(p_company_id         => p_company_id,
                              p_apply_module       => p_apply_module,
                              p_base_table         => upper(p_base_table),
                              p_apply_pk_id        => p_apply_pk_id,
                              p_action_type        => upper(p_action_type),
                              p_log_dict_type      => p_log_dict_type,
                              p_log_type           => p_log_type,
                              p_log_msg            => p_log_msg, --1.手动编写 2.如有日志明细 则设置自动赋值
                              p_user_id            => p_user_id,
                              p_operate_company_id => p_operate_company_id,
                              po_log_id            => v_log_id);
        END IF;
        --新增日志明细
        p_insert_plat_logs(p_log_id        => v_log_id,
                           p_company_id    => p_company_id,
                           p_field_desc    => p_field_desc,
                           p_operate_field => upper(p_operate_field),
                           p_field_type    => upper(p_field_type),
                           p_old_code      => p_old_code,
                           p_new_code      => p_new_code,
                           p_old_value     => p_old_value,
                           p_new_value     => p_new_value,
                           p_memo          => p_memo,
                           p_memo_desc     => p_memo_desc,
                           p_is_show       => p_is_show,
                           p_seq_no        => p_seq_no);
      ELSE
        NULL;
      END IF;
    END IF;
    po_log_id := v_log_id;
    --同步日志至plm或mrp
    IF p_type IN (1, 2) THEN
      v_method_name := f_get_log_type_dict_name(p_log_dict_type => 'QUOTATION_LOG',
                                                p_log_type      => p_log_type);
    
      p_insert_plat_log_to_plm_or_mrp(p_log_id      => v_log_id,
                                      p_log_msg     => p_log_msg,
                                      p_class_name  => 'SCM-ODM报价管理',
                                      p_method_name => v_method_name,
                                      p_type        => p_type);
    END IF;
  END p_record_plat_log;

  /*============================================*
  * Author   : CZH
  * Created  : 2022-05-21 09:27:18
  * ALERTER  :
  * ALERTER_TIME  :
  * Purpose  : 更新日志主表log_msg
  * Obj_Name    : P_UPDATE_PLAT_LOGMSG
  * Arg_Number  : 5
  * < IN PARAMS >
  * P_COMPANY_ID : 企业ID
  * P_LOG_ID : 日志主表LOG_ID
  * P_LOG_MSG : 操作内容（选填） 1.默认为空 2.有值则覆盖操作内容
  * P_IS_LOGSMSG : 是否把日志明细 拼接至日志主表的LOG_MSG
  * P_IS_SPLICE_FIELDS : 是否将同一日志明细字段合并
  * P_TYPE : 类型 默认0为scm日志，1为plm日志，2为mrp日志
  *============================================*/

  PROCEDURE p_update_plat_logmsg(p_company_id        VARCHAR2,
                                 p_log_id            VARCHAR2,
                                 p_log_msg           CLOB DEFAULT NULL,
                                 p_is_logsmsg        INT DEFAULT 1,
                                 p_is_flhide_fileds  INT DEFAULT 0,
                                 p_is_splice_fields  INT DEFAULT 0,
                                 p_is_show_memo_desc INT DEFAULT 0,
                                 p_type              INT DEFAULT 0) IS
    vo_log_msg    CLOB;
    vo_log_msg_f  CLOB;
    v_method_name VARCHAR2(256);
    v_log_type    VARCHAR2(32);
  BEGIN
    --是否按明细赋值log_msg
    IF p_is_logsmsg = 1 THEN
      p_plat_log_msg(p_log_id            => p_log_id,
                     p_company_id        => p_company_id,
                     p_is_splice_fields  => p_is_splice_fields,
                     p_is_flhide_fileds  => p_is_flhide_fileds,
                     p_is_show_memo_desc => p_is_show_memo_desc,
                     po_log_msg          => vo_log_msg,
                     po_log_msg_f        => vo_log_msg_f);
    ELSE
      vo_log_msg := p_log_msg;
    END IF;
  
    UPDATE scmdata.t_plat_log t
       SET t.log_msg = vo_log_msg, t.log_msg_f = vo_log_msg_f
     WHERE t.log_id = p_log_id
       AND t.company_id = p_company_id;
  
    --同步日志至plm或mrp
    IF p_type IN (1, 2) THEN
    
      SELECT MAX(t.log_type)
        INTO v_log_type
        FROM scmdata.t_plat_log t
       WHERE t.log_id = p_log_id;
    
      v_method_name := f_get_log_type_dict_name(p_log_dict_type => 'QUOTATION_LOG',
                                                p_log_type      => v_log_type);
    
      p_insert_plat_log_to_plm_or_mrp(p_log_id      => p_log_id,
                                      p_log_msg     => vo_log_msg,
                                      p_class_name  => 'SCM-ODM报价管理',
                                      p_method_name => v_method_name,
                                      p_type        => p_type);
    END IF;
  END p_update_plat_logmsg;

  --获取日志明细，拼接log_msg字段
  PROCEDURE p_plat_log_msg(p_log_id            VARCHAR2,
                           p_company_id        VARCHAR2,
                           p_is_splice_fields  INT DEFAULT 0,
                           p_is_flhide_fileds  INT DEFAULT 0,
                           p_is_show_memo_desc INT DEFAULT 0,
                           po_log_msg          OUT CLOB,
                           po_log_msg_f        OUT CLOB) IS
    v_log_msg   CLOB;
    v_log_msg_f CLOB;
    v_flag      INT := 0;
    v_cnt       INT := 0;
    v_memo_dic  VARCHAR2(32);
  BEGIN
    SELECT COUNT(1)
      INTO v_flag
      FROM scmdata.t_plat_logs t
     WHERE t.log_id = p_log_id
       AND t.company_id = p_company_id;
  
    IF v_flag > 0 THEN
      --全部字段
      FOR p_log_rec IN (SELECT t.field_desc,
                               t.operate_field,
                               t.old_value,
                               t.new_value,
                               t.field_type,
                               t.is_show,
                               t.memo,
                               t.memo_desc
                          FROM scmdata.t_plat_logs t
                         WHERE t.log_id = p_log_id
                           AND t.company_id = p_company_id
                         ORDER BY t.seq_no ASC) LOOP
        --判断是否展示备注
        IF p_is_show_memo_desc = 1 THEN
          --备注类型
          v_memo_dic := scmdata.pkg_plat_comm.f_get_platorcompany_dict(p_type            => 'MEMO_TYPE',
                                                                       p_value           => p_log_rec.memo,
                                                                       p_is_company_dict => 0);
        ELSE
          NULL;
        END IF;
      
        IF p_is_splice_fields = 0 THEN
          v_cnt := v_cnt + 1;
          IF v_cnt = 1 THEN
            v_log_msg := v_cnt || '.' || p_log_rec.field_desc || '：' ||
                         p_log_rec.new_value || ';' || CASE
                           WHEN p_is_show_memo_desc = 1 THEN
                            CASE
                              WHEN v_memo_dic IS NULL THEN
                               NULL
                              ELSE
                               '【' || v_memo_dic || '：' || p_log_rec.memo_desc || '】'
                            END
                         END;
          ELSE
            v_log_msg := v_log_msg || chr(10) || v_cnt || '.' || p_log_rec.field_desc || '：' ||
                         p_log_rec.new_value || ';' || CASE
                           WHEN p_is_show_memo_desc = 1 THEN
                            CASE
                              WHEN v_memo_dic IS NULL THEN
                               NULL
                              ELSE
                               '【' || v_memo_dic || '：' || p_log_rec.memo_desc || '】'
                            END
                         END;
          END IF;
        ELSE
          v_log_msg := v_log_msg || p_log_rec.new_value || '-';
        END IF;
      END LOOP;
      v_log_msg := rtrim(v_log_msg, '-');
      --过滤隐藏字段
      IF p_is_flhide_fileds = 1 THEN
        v_cnt := 0;
        FOR p_log_rec IN (SELECT t.field_desc,
                                 t.operate_field,
                                 t.old_value,
                                 t.new_value,
                                 t.field_type,
                                 t.is_show,
                                 t.memo,
                                 t.memo_desc
                            FROM scmdata.t_plat_logs t
                           WHERE t.log_id = p_log_id
                             AND t.company_id = p_company_id
                             AND t.is_show = 1
                           ORDER BY t.seq_no ASC) LOOP
          --判断是否展示备注
          IF p_is_show_memo_desc = 1 THEN
            --备注类型
            v_memo_dic := scmdata.pkg_plat_comm.f_get_platorcompany_dict(p_type            => 'MEMO_TYPE',
                                                                         p_value           => p_log_rec.memo,
                                                                         p_is_company_dict => 0);
          ELSE
            NULL;
          END IF;
        
          IF p_is_splice_fields = 0 THEN
            v_cnt := v_cnt + 1;
            IF v_cnt = 1 THEN
              v_log_msg_f := v_cnt || '.' || p_log_rec.field_desc || '：' ||
                             p_log_rec.new_value || ';' || CASE
                               WHEN p_is_show_memo_desc = 1 THEN
                                CASE
                                  WHEN v_memo_dic IS NULL THEN
                                   NULL
                                  ELSE
                                   '【' || v_memo_dic || '：' || p_log_rec.memo_desc || '】'
                                END
                             END;
            ELSE
              v_log_msg_f := v_log_msg_f || chr(10) || v_cnt || '.' ||
                             p_log_rec.field_desc || '：' || p_log_rec.new_value || ';' || CASE
                               WHEN p_is_show_memo_desc = 1 THEN
                                CASE
                                  WHEN v_memo_dic IS NULL THEN
                                   NULL
                                  ELSE
                                   '【' || v_memo_dic || '：' || p_log_rec.memo_desc || '】'
                                END
                             END;
            END IF;
          ELSE
            v_log_msg_f := v_log_msg_f || p_log_rec.new_value || '-';
          END IF;
        END LOOP;
        v_log_msg_f := rtrim(v_log_msg_f, '-');
      ELSE
        NULL;
      END IF;
    END IF;
    po_log_msg   := v_log_msg;
    po_log_msg_f := v_log_msg_f;
  
  END p_plat_log_msg;

  /*============================================*
  * Author   : CZH
  * Created  : 2022-05-21 09:30:35
  * ALERTER  :
  * ALERTER_TIME  :
  * Purpose  : 新增日志主表
  * Obj_Name    : P_INSERT_T_PLAT_LOG
  * Arg_Number  : 10
  * < IN PARAMS >
  * P_COMPANY_ID : 企业ID
  * P_APPLY_MODULE : 应用模块（item_id）
  * P_BASE_TABLE : 基表
  * P_APPLY_PK_ID : 基表主键
  * P_ACTION_TYPE : 执行动作类型
  * P_LOG_TYPE : 日志类型
  * P_LOG_MSG : 操作内容
  * P_USER_ID : 操作人
  * P_OPERATE_COMPANY_ID : 操作方企业
  * < OUT PARAMS >
  * PO_LOG_ID : 日志ID
  *============================================*/

  PROCEDURE p_insert_t_plat_log(p_company_id         VARCHAR2,
                                p_apply_module       VARCHAR2,
                                p_base_table         VARCHAR2,
                                p_apply_pk_id        VARCHAR2,
                                p_action_type        VARCHAR2,
                                p_log_dict_type      VARCHAR2 DEFAULT NULL,
                                p_log_type           VARCHAR2,
                                p_log_msg            VARCHAR2,
                                p_user_id            VARCHAR2,
                                p_operate_company_id VARCHAR2,
                                po_log_id            OUT VARCHAR2) IS
    v_uuid       VARCHAR2(32);
    v_pre_log_id VARCHAR2(32);
  BEGIN
    v_uuid := scmdata.f_get_uuid();
    --记录当前日志的前后置LOG_ID
    SELECT MAX(v.log_id)
      INTO v_pre_log_id
      FROM (SELECT t.log_id
              FROM scmdata.t_plat_log t
             WHERE t.apply_pk_id = p_apply_pk_id
               AND t.company_id = p_company_id
             ORDER BY t.create_time DESC) v
     WHERE rownum < 2;
  
    INSERT INTO scmdata.t_plat_log
      (log_id, pre_log_id, suf_log_id, company_id, apply_module, base_table,
       apply_pk_id, action_type, log_type, log_msg, operater,
       operate_company_id, create_id, create_time, update_id, update_time,
       memo, log_parent_type)
    VALUES
      (v_uuid, v_pre_log_id, NULL, p_company_id, p_apply_module,
       p_base_table, p_apply_pk_id, p_action_type, p_log_type, p_log_msg,
       p_user_id, p_operate_company_id, 'ADMIN', SYSDATE, 'ADMIN', SYSDATE,
       NULL, p_log_dict_type);
  
    IF v_pre_log_id IS NOT NULL THEN
      UPDATE scmdata.t_plat_log t
         SET t.suf_log_id = v_uuid
       WHERE t.log_id = v_pre_log_id
         AND t.company_id = p_company_id;
    END IF;
    po_log_id := v_uuid;
  END p_insert_t_plat_log;

  /*============================================*
  * Author   : CZH
  * Created  : 2022-05-21 09:33:44
  * ALERTER  :
  * ALERTER_TIME  :
  * Purpose  : 新增日志明细
  * Obj_Name    : P_INSERT_PLAT_LOGS
  * Arg_Number  : 10
  * < IN PARAMS >
  * P_LOG_ID : 日志主表ID
  * P_COMPANY_ID : 企业ID
  * P_FIELD_DESC : 字段描述
  * P_OPERATE_FIELD : 操作字段
  * P_FIELD_TYPE : 字段类型
  * P_OLD_CODE : 旧值编码
  * P_NEW_CODE : 新值编码
  * P_OLD_VALUE : 旧值
  * P_NEW_VALUE : 新值
  * P_SEQ_NO : 日志序号
  *============================================*/

  PROCEDURE p_insert_plat_logs(p_log_id        VARCHAR2,
                               p_company_id    VARCHAR2,
                               p_field_desc    VARCHAR2,
                               p_operate_field VARCHAR2,
                               p_field_type    VARCHAR2,
                               p_old_code      VARCHAR2,
                               p_new_code      VARCHAR2,
                               p_old_value     VARCHAR2,
                               p_new_value     VARCHAR2,
                               p_memo          VARCHAR2,
                               p_memo_desc     CLOB,
                               p_is_show       INT DEFAULT 1,
                               p_seq_no        INT) IS
  BEGIN
    INSERT INTO scmdata.t_plat_logs
      (logs_id, log_id, company_id, field_desc, operate_field, field_type,
       old_code, new_code, old_value, new_value, create_id, create_time,
       update_id, update_time, memo, seq_no, memo_desc, is_show)
    VALUES
      (scmdata.f_get_uuid(), p_log_id, p_company_id, p_field_desc,
       p_operate_field, p_field_type, p_old_code, p_new_code, p_old_value,
       p_new_value, 'ADMIN', SYSDATE, 'ADMIN', SYSDATE, p_memo, p_seq_no,
       p_memo_desc, p_is_show);
  END p_insert_plat_logs;
  --判断字段新旧值是否相等
  FUNCTION f_is_check_fields_eq(p_old_field VARCHAR2, p_new_field VARCHAR2)
    RETURN INT IS
  BEGIN
    IF (p_old_field IS NULL AND p_new_field IS NOT NULL) OR
       (p_old_field IS NOT NULL AND p_new_field IS NULL) OR
       (p_old_field <> p_new_field) THEN
      RETURN 0;
    ELSE
      RETURN 1;
    END IF;
  END f_is_check_fields_eq;

  --日志同步至plm、mrp
  PROCEDURE p_insert_plat_log_to_plm_or_mrp(p_log_id      VARCHAR2,
                                            p_log_msg     VARCHAR2,
                                            p_class_name  VARCHAR2 DEFAULT NULL,
                                            p_method_name VARCHAR2 DEFAULT NULL,
                                            p_type        INT DEFAULT 0) IS
    v_ope_name VARCHAR2(64);
    v_id       NUMBER;
  BEGIN
    --操作人
    SELECT nvl(MAX(t.nick_name), 'ADMIN')
      INTO v_ope_name
      FROM scmdata.sys_user t
     INNER JOIN scmdata.t_plat_log l
        ON t.user_id = l.operater
     WHERE l.log_id = p_log_id;
  
    --插入plm日志
    IF p_type = 1 THEN
      v_id := plm.pkg_outside_material.f_get_mrp_keyid(pi_pre     => 1,
                                                       pi_owner   => 'PLM',
                                                       pi_seqname => 'SEQ_OUTMATERIAL_ID',
                                                       pi_seqnum  => 999);
      INSERT INTO plm.plm_log
        (id, user_name, operate_content, operate, create_time, thirdpart_id,
         class_name, method_name)
        SELECT v_id,
               v_ope_name,
               p_log_msg,
               l.action_type,
               SYSDATE,
               l.apply_pk_id,
               p_class_name,
               p_method_name
          FROM scmdata.t_plat_log l
         WHERE l.log_id = p_log_id;
    
      --插入mrp日志
    ELSIF p_type = 2 THEN
      v_id := plm.pkg_outside_material.f_get_mrp_keyid(pi_pre     => 1,
                                                       pi_owner   => 'PLM',
                                                       pi_seqname => 'SEQ_OUTMATERIAL_ID',
                                                       pi_seqnum  => 999);
      INSERT INTO mrp.mrp_log
        (id, user_name, operate_content, operate, create_time, thirdpart_id,
         class_name, method_name)
        SELECT v_id,
               v_ope_name,
               p_log_msg,
               l.action_type,
               SYSDATE,
               l.apply_pk_id,
               p_class_name,
               p_method_name
          FROM scmdata.t_plat_log l
         WHERE l.log_id = p_log_id;
    ELSE
      NULL;
    END IF;
  END p_insert_plat_log_to_plm_or_mrp;

  --获取日志字典名称
  FUNCTION f_get_log_type_dict_name(p_log_dict_type VARCHAR2,
                                    p_log_type      VARCHAR2) RETURN VARCHAR2 IS
    v_method_name VARCHAR2(256);
  BEGIN
    SELECT MAX(a.group_dict_name)
      INTO v_method_name
      FROM scmdata.sys_group_dict a
     WHERE a.group_dict_type = p_log_dict_type
       AND a.group_dict_value = p_log_type;
    RETURN v_method_name;
  END f_get_log_type_dict_name;

  /*============================================*
  * Author   : CZH
  * Created  : 2023-05-10 13:26:04
  * ALERTER  : 
  * ALERTER_TIME  : 
  * Purpose  : 记录平台操作日志（全平台） 
  * Obj_Name    : P_SYNC_RECORD_PLAT_LOG
  * Arg_Number  : 21
  * < IN PARAMS >  
  * P_COMPANY_ID : 企业ID
  * P_APPLY_MODULE : 应用模块ID
  * P_APPLY_MODULE_DESC :应用模块描述
  * P_BASE_TABLE : 基表（针对字段发生变更的表）
  * P_APPLY_PK_ID : 基表主键ID
  * P_ACTION_TYPE : 操作类型 例：UPDATE 、INSERT
  * P_LOG_DICT_TYPE : 平台日志字典编码
  * P_LOG_TYPE : 日志类型编码
  * P_LOG_MSG : 日志内容
  * P_OPERATE_FIELD : 操作字段
  * P_FIELD_TYPE : 字段类型 记录字段常用类型：VARCHAR,NUMBER,DATE等
  * P_FIELD_DESC :字段描述
  * P_OLD_CODE : 旧值编码
  * P_NEW_CODE : 新值编码
  * P_OLD_VALUE :旧值
  * P_NEW_VALUE :新值
  * P_OPERATE_COMPANY_ID : 操作方
  * P_USER_ID : 操作人
  * P_MEMO : 备注编码（选填）
  * P_MEMO_DESC : 备注描述（选填）
  * P_TYPE : 系统同步日志类型 （选填，默认同步日志至scm）
  *          0：scm ，1：plm，2：mrp
  *============================================*/

  PROCEDURE p_sync_record_plat_log(p_company_id         VARCHAR2,
                                   p_apply_module       VARCHAR2,
                                   p_apply_module_desc  VARCHAR2,
                                   p_base_table         VARCHAR2,
                                   p_apply_pk_id        VARCHAR2,
                                   p_action_type        VARCHAR2,
                                   p_log_dict_type      VARCHAR2,
                                   p_log_type           VARCHAR2,
                                   p_log_msg            CLOB,
                                   p_operate_field      VARCHAR2,
                                   p_field_type         VARCHAR2,
                                   p_field_desc         VARCHAR2,
                                   p_old_code           VARCHAR2 DEFAULT NULL,
                                   p_new_code           VARCHAR2 DEFAULT NULL,
                                   p_old_value          VARCHAR2 DEFAULT NULL,
                                   p_new_value          VARCHAR2 DEFAULT NULL,
                                   p_operate_company_id VARCHAR2,
                                   p_user_id            VARCHAR2,
                                   p_memo               VARCHAR2 DEFAULT NULL,
                                   p_memo_desc          CLOB DEFAULT NULL,
                                   p_type               INT DEFAULT 0) IS
    vo_log_id     VARCHAR2(32);
    v_method_name VARCHAR2(256);
  BEGIN
    --1.同步记录scm平台日志
    pkg_plat_log.p_record_plat_log(p_company_id         => p_company_id,
                                   p_apply_module       => p_apply_module,
                                   p_base_table         => p_base_table,
                                   p_apply_pk_id        => p_apply_pk_id,
                                   p_action_type        => p_action_type,
                                   p_seq_no             => 1,
                                   p_log_id             => NULL,
                                   p_log_msg            => p_log_msg,
                                   p_log_dict_type      => p_log_dict_type,
                                   p_log_type           => p_log_type,
                                   p_is_logs            => 1,
                                   p_field_desc         => p_field_desc,
                                   p_operate_field      => p_operate_field,
                                   p_field_type         => p_field_type,
                                   p_old_code           => p_old_code,
                                   p_new_code           => p_new_code,
                                   p_old_value          => p_old_value,
                                   p_new_value          => p_new_value,
                                   p_user_id            => p_user_id,
                                   p_operate_company_id => p_operate_company_id,
                                   p_memo               => p_memo,
                                   p_memo_desc          => p_memo_desc,
                                   p_is_show            => 1,
                                   po_log_id            => vo_log_id,
                                   p_type               => 0);
  
    --2.同步记录plm、mrp日志 
    SELECT MAX(a.group_dict_name)
      INTO v_method_name
      FROM scmdata.sys_group_dict a
     WHERE a.group_dict_type = p_log_dict_type
       AND a.group_dict_value = p_log_type;
  
    p_insert_plat_log_to_plm_or_mrp(p_log_id      => vo_log_id,
                                    p_log_msg     => p_log_msg,
                                    p_class_name  => p_apply_module_desc,
                                    p_method_name => v_method_name,
                                    p_type        => p_type);
  
  END p_sync_record_plat_log;

  /*=========================================================*
  * Author        : CZH55
  * Created_Time  : 2023-06-01 14:05:40
  * Alerter       : 
  * Alerter_Time  : 
  * Purpose       : 单据变更溯源
  * Obj_Name      : P_DOCUMENT_CHANGE_TRACE
  * Arg_Number    : 6
  * < IN PARAMS > : 6
  * P_COMPANY_ID  : 企业ID（品牌方） 
  * P_DOCUMENT_ID : 单据ID （可以分号;作分隔符，进行拼接多张单据ID） 如：一张单：A001  多张单：A001;B001;C001
  * P_DATA_SOURCE_PARENT_CODE : 数据来源父级编码（多级数据字典中，操作日志对应字典编码）
  * P_DATA_SOURCE_CHILD_CODE : 数据来源子级编码（多级数据字典中，操作日志对应字典编码）
  * P_OPERATE_COMPANY_ID : 操作方企业ID
  * P_USER_ID     : 当前操作人
  *=========================================================*/
  PROCEDURE p_document_change_trace(p_company_id              VARCHAR2,
                                    p_document_id             VARCHAR2,
                                    p_data_source_parent_code VARCHAR2,
                                    p_data_source_child_code  VARCHAR2,
                                    p_operate_company_id      VARCHAR2,
                                    p_user_id                 VARCHAR2) IS
    v_flag      INT;
    v_t_doc_rec t_document_change_trace%ROWTYPE;
  BEGIN
    FOR rec IN (SELECT regexp_substr(p_document_id, '[^;]+', 1, LEVEL) AS document_id
                  FROM dual
                CONNECT BY LEVEL <= regexp_count(p_document_id, ';') + 1) LOOP
      SELECT COUNT(1)
        INTO v_flag
        FROM scmdata.t_document_change_trace t
       WHERE t.document_id = rec.document_id
         AND t.company_id = p_company_id;
    
      v_t_doc_rec.company_id              := p_company_id; --企业ID（品牌方）
      v_t_doc_rec.document_id             := rec.document_id; --单据ID
      v_t_doc_rec.operate_company_id      := p_operate_company_id; --操作方企业ID
      v_t_doc_rec.data_source_parent_code := p_data_source_parent_code; --来源父级编码（取对应数据字典）
      v_t_doc_rec.data_source_child_code  := p_data_source_child_code; --来源子级编码（取对应数据字典）  
      v_t_doc_rec.update_id               := p_user_id; --修改人
      v_t_doc_rec.update_time             := SYSDATE; --修改时间
      v_t_doc_rec.memo                    := NULL; --备注
    
      IF v_flag > 0 THEN
        scmdata.pkg_t_document_change_trace.p_update_t_document_change_trace(p_t_doc_rec => v_t_doc_rec);
      ELSE
        v_t_doc_rec.id          := scmdata.f_get_uuid(); --主键      
        v_t_doc_rec.create_id   := p_user_id; --创建人
        v_t_doc_rec.create_time := SYSDATE; --创建时间
        scmdata.pkg_t_document_change_trace.p_insert_t_document_change_trace(p_t_doc_rec => v_t_doc_rec);
      END IF;
    END LOOP;
  END p_document_change_trace;

  /*=========================================================*
  * Author        : CZH55
  * Created_Time  : 2023-06-07 14:14:30
  * Alerter       : 
  * Alerter_Time  : 
  * Purpose       : 根据单据变更溯源表 返回参数
  * Obj_Name      : P_GET_DOCUMENT_CHANGE_TRACE_PARAMS
  * Arg_Number    : 3
  * < IN PARAMS > : 2
  * P_COMPANY_ID  : 企业ID （品牌方）
  * P_DOCUMENT_ID : 单据ID
  * < OUT PARAMS >: 1
  * PO_DOCUMENT_REC : 单据变更溯源表记录
  *=========================================================*/
  PROCEDURE p_get_document_change_trace_params(p_company_id    VARCHAR2,
                                               p_document_id   VARCHAR2,
                                               po_document_rec OUT scmdata.t_document_change_trace%ROWTYPE) IS
    v_flag INT;
  BEGIN
    SELECT COUNT(1)
      INTO v_flag
      FROM scmdata.t_document_change_trace t
     WHERE t.company_id = p_company_id
       AND t.document_id = p_document_id;
  
    IF v_flag > 0 THEN
      SELECT t.*
        INTO po_document_rec
        FROM scmdata.t_document_change_trace t
       WHERE t.company_id = p_company_id
         AND t.document_id = p_document_id;
    ELSE
      raise_application_error(-20002,
                              '【单据变更溯源】返回参数为空，请联系管理员');
    END IF;
  END p_get_document_change_trace_params;

END pkg_plat_log;
/

