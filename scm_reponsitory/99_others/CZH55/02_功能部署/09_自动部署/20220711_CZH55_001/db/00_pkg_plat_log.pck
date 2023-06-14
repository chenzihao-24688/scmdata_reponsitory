CREATE OR REPLACE PACKAGE pkg_plat_log IS

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
                              po_log_id            OUT VARCHAR2);
  --更新日志主表log_msg
  PROCEDURE p_update_plat_logmsg(p_company_id        VARCHAR2,
                                 p_log_id            VARCHAR2,
                                 p_log_msg           CLOB DEFAULT NULL,
                                 p_is_logsmsg        INT DEFAULT 1,
                                 p_is_flhide_fileds  INT DEFAULT 0,
                                 p_is_splice_fields  INT DEFAULT 0,
                                 p_is_show_memo_desc INT DEFAULT 0);

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
END pkg_plat_log;
/
CREATE OR REPLACE PACKAGE BODY pkg_plat_log IS

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
                              po_log_id            OUT VARCHAR2) IS
    v_log_id VARCHAR2(32) := p_log_id;
    v_flag   INT;
  BEGIN
    --判断是否需要新增日志明细
    --0: 否
    IF p_is_logs = 0 THEN
      p_insert_t_plat_log(p_company_id         => p_company_id,
                          p_apply_module       => p_apply_module,
                          p_base_table         => upper(p_base_table),
                          p_apply_pk_id        => p_apply_pk_id,
                          p_action_type        => upper(p_action_type),
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
  *============================================*/

  PROCEDURE p_update_plat_logmsg(p_company_id        VARCHAR2,
                                 p_log_id            VARCHAR2,
                                 p_log_msg           CLOB DEFAULT NULL,
                                 p_is_logsmsg        INT DEFAULT 1,
                                 p_is_flhide_fileds  INT DEFAULT 0,
                                 p_is_splice_fields  INT DEFAULT 0,
                                 p_is_show_memo_desc INT DEFAULT 0) IS
    vo_log_msg   CLOB;
    vo_log_msg_f CLOB;
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
                            '【' || v_memo_dic || '：' || p_log_rec.memo_desc || '】'
                         END;
          ELSE
            v_log_msg := v_log_msg || chr(10) || v_cnt || '.' || p_log_rec.field_desc || '：' ||
                         p_log_rec.new_value || ';' || CASE
                           WHEN p_is_show_memo_desc = 1 THEN
                            '【' || v_memo_dic || '：' || p_log_rec.memo_desc || '】'
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
                                '【' || v_memo_dic || '：' || p_log_rec.memo_desc || '】'
                             END;
            ELSE
              v_log_msg_f := v_log_msg_f || chr(10) || v_cnt || '.' ||
                             p_log_rec.field_desc || '：' || p_log_rec.new_value || ';' || CASE
                               WHEN p_is_show_memo_desc = 1 THEN
                                '【' || v_memo_dic || '：' || p_log_rec.memo_desc || '】'
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
      (log_id,
       pre_log_id,
       suf_log_id,
       company_id,
       apply_module,
       base_table,
       apply_pk_id,
       action_type,
       log_type,
       log_msg,
       operater,
       operate_company_id,
       create_id,
       create_time,
       update_id,
       update_time,
       memo)
    VALUES
      (v_uuid,
       v_pre_log_id,
       NULL,
       p_company_id,
       p_apply_module,
       p_base_table,
       p_apply_pk_id,
       p_action_type,
       p_log_type,
       p_log_msg,
       p_user_id,
       p_operate_company_id,
       'ADMIN',
       SYSDATE,
       'ADMIN',
       SYSDATE,
       NULL);
  
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
      (logs_id,
       log_id,
       company_id,
       field_desc,
       operate_field,
       field_type,
       old_code,
       new_code,
       old_value,
       new_value,
       create_id,
       create_time,
       update_id,
       update_time,
       memo,
       seq_no,
       memo_desc,
       is_show)
    VALUES
      (scmdata.f_get_uuid(),
       p_log_id,
       p_company_id,
       p_field_desc,
       p_operate_field,
       p_field_type,
       p_old_code,
       p_new_code,
       p_old_value,
       p_new_value,
       'ADMIN',
       SYSDATE,
       'ADMIN',
       SYSDATE,
       p_memo,
       p_seq_no,
       p_memo_desc,
       p_is_show);
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
END pkg_plat_log;
/
