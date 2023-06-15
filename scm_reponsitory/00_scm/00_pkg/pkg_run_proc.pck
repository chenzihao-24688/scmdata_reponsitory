CREATE OR REPLACE PACKAGE SCMDATA."PKG_RUN_PROC" IS

  -- Author  : SANFU
  -- Created : 2021/7/30 11:01:55
  -- Purpose : 定时任务

  /*  declare
    job number;
  BEGIN
    DBMS_JOB.SUBMIT(
          JOB => job,  \*自动生成JOB_ID*\
          WHAT => 'proc_add_test;',  \*需要执行的存储过程名称或SQL语句*\
          NEXT_DATE => sysdate+3/(24*60),  \*初次执行时间-下一个3分钟*\
          INTERVAL => 'trunc(sysdate,''mi'')+1/(24*60)' \*每隔1分钟执行一次*\
        );
    commit;
  end;*/

  --例子：
  /*DECLARE
  BEGIN
    EXECUTE IMMEDIATE 'insert into scmdata.t_day_proc (day_proc_id ,seqno ,proc_sql ,pause,proc_name,remarks) values (:day_proc_id ,:seqno ,:proc_sql ,:pause,:proc_name,:remarks)'
      USING scmdata.f_get_uuid(), 10000, 'call pkg_day_proc.p_merge_order_dayproc', 1, '订单数据表','
    每天更新订单交期数据表
    更新频率：每天凌晨0000更新1次数据
    更新说明：每月5号0000，上月数据更新最后1次，后续不再更新；（按订单交期月份判断是否为上月数据）';
  END;*/

  --记录(非接口的任务)至 scmdata.t_day_proc
  PROCEDURE merge_day_proc(p_seqno     NUMBER, --任务号
                           p_sql       CLOB, --执行sql / plsql块
                           p_pause     NUMBER,
                           p_proc_name VARCHAR2, --任务名称
                           p_remarks   VARCHAR2);

  --记录xxl_job_info至 scmdata.t_day_proc
  PROCEDURE run_day_proc;
  --执行 scmdata.t_day_proc 中的proc_sql
  PROCEDURE run_proc_sql(p_seqno NUMBER);
  --执行sql
  PROCEDURE proc_sql(p_seqno NUMBER,
                     p_sql   CLOB,
                     po_flag OUT BOOLEAN,
                     po_msg  OUT CLOB);
  --记录日志
  PROCEDURE insert_log(p_record_id VARCHAR2,
                       p_log_type  VARCHAR2,
                       p_log_flag  CHAR,
                       p_msg       CLOB);
END pkg_run_proc;
/

CREATE OR REPLACE PACKAGE BODY SCMDATA."PKG_RUN_PROC" IS

  --记录(非接口的任务)至 scmdata.t_day_proc
  PROCEDURE merge_day_proc(p_seqno     NUMBER, --任务号
                           p_sql       CLOB, --执行sql / plsql块
                           p_pause     NUMBER,
                           p_proc_name VARCHAR2, --任务名称
                           p_remarks   VARCHAR2) --备注
   IS
  BEGIN
    MERGE INTO scmdata.t_day_proc a
    USING (SELECT p_seqno     seqno, --任务号
                  p_sql       proc_sql, --执行sql / plsql块
                  p_pause     pause,
                  p_proc_name proc_name, --任务名称
                  p_remarks   remarks --备注
             FROM dual) b
    ON (a.seqno = b.seqno)
    WHEN MATCHED THEN
      UPDATE
         SET a.proc_sql  = b.proc_sql,
             a.pause     = b.pause,
             a.proc_name = b.proc_name,
             a.remarks   = b.remarks
    WHEN NOT MATCHED THEN
      INSERT
        (day_proc_id, seqno, proc_sql, pause, proc_name, remarks)
      VALUES
        (scmdata.f_get_uuid(),
         b.seqno,
         b.proc_sql,
         b.pause,
         b.proc_name,
         b.remarks);
  
  END merge_day_proc;

  --记录XXL_JOB_info(非接口的任务)至 scmdata.t_day_proc
  PROCEDURE run_day_proc IS
    v_flag NUMBER;
  BEGIN
  
    SELECT COUNT(1)
      INTO v_flag
      FROM nbw.xxl_job_info t
     WHERE t.id IS NOT NULL
       AND t.executor_param IS NOT NULL
       AND t.trigger_status = 1;
    IF v_flag > 0 THEN
    
      FOR job_info IN (SELECT t.id,
                              t.executor_param,
                              t.trigger_next_time,
                              t.job_desc,
                              a.action_sql
                         FROM nbw.xxl_job_info t
                        INNER JOIN nbw.sys_action a
                           ON t.executor_param = a.element_id
                          AND a.action_type <> 8
                        WHERE t.id IS NOT NULL
                          AND t.executor_param IS NOT NULL
                          AND t.trigger_status = 1) LOOP
        BEGIN
          EXECUTE IMMEDIATE 'select count(1) from scmdata.t_day_proc b where b.seqno = :1'
            INTO v_flag
            USING IN job_info.id;
        
          IF v_flag = 0 THEN
            EXECUTE IMMEDIATE 'insert into scmdata.t_day_proc (day_proc_id ,seqno ,proc_sql ,pause,proc_name) values (:day_proc_id ,:seqno ,:proc_sql ,:pause,:proc_name)'
              USING scmdata.f_get_uuid(), job_info.id, job_info.action_sql, 1, job_info.job_desc;
          ELSE
            EXECUTE IMMEDIATE 'update scmdata.t_day_proc set proc_sql = :proc_sql where seqno = :seqno'
              USING job_info.action_sql, job_info.id;
          END IF;
          COMMIT;
        END;
      
      END LOOP;
    END IF;
  END run_day_proc;

  --执行 scmdata.t_day_proc 中的proc_sql 供定时任务调用
  PROCEDURE run_proc_sql(p_seqno NUMBER) IS
    vo_po_flag BOOLEAN;
    vo_msg     CLOB;
  BEGIN
    FOR proc_rec IN (SELECT a.seqno, a.proc_sql, a.proc_name
                       FROM scmdata.t_day_proc a
                      WHERE a.seqno = p_seqno
                        AND a.pause = 1) LOOP
      EXECUTE IMMEDIATE 'BEGIN  pkg_run_proc.proc_sql(:p_seqno,:p_sql,:po_flag,:p_out_msg); END;'
        USING IN proc_rec.seqno, IN proc_rec.proc_sql, OUT vo_po_flag, OUT vo_msg;
    END LOOP;
  EXCEPTION
    WHEN OTHERS THEN
      ROLLBACK;
      BEGIN
        EXECUTE IMMEDIATE 'BEGIN  pkg_run_proc.insert_log(p_record_id => :record_id,
                                                            p_log_type  => :log_type,
                                                            p_log_flag  => :log_flag,
                                                            p_msg       => :msg); END;'
          USING '0000', 'SYS_ERR', 'F', 'PKG_RUN_PROC.PROC_SQL-----RUN_PROC_SQL:' || dbms_utility.format_error_backtrace || dbms_utility.format_error_stack;
      END;
    
  END run_proc_sql;

  --执行sql
  PROCEDURE proc_sql(p_seqno NUMBER,
                     p_sql   CLOB,
                     po_flag OUT BOOLEAN,
                     po_msg  OUT CLOB) IS
    v_str_current_program CLOB;
    v_start_time          DATE;
    v_end_time            DATE;
    v_seconds             NUMBER;
    v_msg                 CLOB;
  BEGIN
    v_str_current_program := 'PKG_RUN_PROC.PROC_SQL-----DAY_PROC:SEQNO=' ||
                             nvl(to_char(p_seqno), 'NULL');
    v_start_time          := SYSDATE;
    IF p_sql IS NOT NULL THEN
      --执行sql
      EXECUTE IMMEDIATE p_sql;
      v_end_time := SYSDATE;
      v_seconds  := to_number(v_end_time - v_start_time) * 24 * 60 * 60 * 1000;
      BEGIN
        EXECUTE IMMEDIATE 'update scmdata.t_day_proc set proc_time = :proc_time, seconds = :seconds, proc_end_time = :proc_end_time where seqno = :seqno'
          USING v_start_time, v_seconds, v_end_time, p_seqno;
        COMMIT;
      END;
      v_msg   := to_char(SYSDATE, 'YYYY-MM-DD HH24:MI:SS') || '   [' ||
                 v_str_current_program || ']' || ',执行成功。';
      po_msg  := v_msg;
      po_flag := TRUE;
    ELSE
      v_msg   := v_str_current_program || ',无可执行sql语句。';
      po_msg  := v_msg;
      po_flag := FALSE;
    END IF;
  
    EXECUTE IMMEDIATE 'BEGIN  pkg_run_proc.insert_log(p_record_id => :record_id,
                                                            p_log_type  => :log_type,
                                                            p_log_flag  => :log_flag,
                                                            p_msg       => :msg); END;'
      USING p_seqno, 'JOB', CASE po_flag WHEN TRUE THEN 'S' ELSE 'F' END, v_msg;
  
  EXCEPTION
    WHEN OTHERS THEN
      ROLLBACK;
      BEGIN
        v_end_time := SYSDATE;
        v_seconds  := to_number(v_end_time - v_start_time) * 24 * 60 * 60 * 1000;
      
        EXECUTE IMMEDIATE 'update scmdata.t_day_proc set  proc_time = :proc_time, seconds = :seconds, proc_end_time = :proc_end_time where seqno = :seqno'
          USING v_start_time, v_seconds, v_end_time, p_seqno;
        v_msg := to_char(SYSDATE, 'YYYY-MM-DD HH24:MI:SS') || '   [' ||
                 v_str_current_program || ']' || chr(13) || chr(10) ||
                 dbms_utility.format_error_backtrace ||
                 dbms_utility.format_error_stack;
      
        po_msg  := v_msg;
        po_flag := FALSE;
      
        EXECUTE IMMEDIATE 'BEGIN  pkg_run_proc.insert_log(p_record_id => :record_id,
                                                            p_log_type  => :log_type,
                                                            p_log_flag  => :log_flag,
                                                            p_msg       => :msg); END;'
          USING p_seqno, 'JOB', CASE po_flag WHEN TRUE THEN 'S' ELSE 'F' END, v_msg;
      
        COMMIT;
      END;
    
  END proc_sql;
  --记录日志
  PROCEDURE insert_log(p_record_id VARCHAR2,
                       p_log_type  VARCHAR2,
                       p_log_flag  CHAR,
                       p_msg       CLOB) IS
    PRAGMA AUTONOMOUS_TRANSACTION; --声明自治事务
    v_wx_rec   scmdata.sys_company_wecom_msg%ROWTYPE;
    v_pro_name VARCHAR2(256);
    v_user_id  VARCHAR2(256);
  BEGIN
    EXECUTE IMMEDIATE 'insert into scmdata.t_log
    VALUES
      (:log_id, :record_id, :log_type, :log_flag, :log_msg, :create_time)'
      USING scmdata.f_get_uuid(), p_record_id, p_log_type, p_log_flag, p_msg, SYSDATE;
    --增加企微机器消息推送
    IF p_log_flag = 'F' THEN
      SELECT MAX(t.proc_name), MAX(t.user_id)
        INTO v_pro_name, v_user_id
        FROM scmdata.t_day_proc t
       WHERE t.seqno = p_record_id;
      v_wx_rec.company_wecom_msg_id  := scmdata.f_get_uuid();
      v_wx_rec.robot_type            := 'SUP_MSG';
      v_wx_rec.company_id            := 'b6cc680ad0f599cde0531164a8c0337f';
      v_wx_rec.status                := 2;
      v_wx_rec.create_time           := SYSDATE;
      v_wx_rec.create_id             := 'CZH';
      v_wx_rec.msgtype               := 'text';
      v_wx_rec.content               := '【测试环境】数据库JOB执行失败！任务号：[' ||
                                        p_record_id || '],任务名称：[' ||
                                        v_pro_name || '];请检查日志：[' || p_msg || ']';
      v_wx_rec.mentioned_list        := v_user_id;
      v_wx_rec.mentioned_mobile_list := '';
      pkg_send_wx_msg.p_send_com_wx_msg(p_wx_rec => v_wx_rec);
    END IF;
    COMMIT;
  END insert_log;

END pkg_run_proc;
/

