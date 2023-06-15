CREATE OR REPLACE PACKAGE SCMDATA.pkg_day_proc IS

  -- Author  : SANFU
  -- Created : 2021/9/18 11:01:02
  -- Purpose : 执行定时任务
  --订单数据表
  --每天更新订单交期数据表
  --更新频率：每天凌晨0000更新1次数据
  --更新说明：每月5号0000，上月数据更新最后1次，后续不再更新；（按订单交期月份判断是否为上月数据）
  PROCEDURE p_merge_order_dayproc;

  --3 更新回货计划表 begin
  PROCEDURE p_merge_return_plan_dayproc;
  --end
  --4.更新生产进度表  订单交期延期 
  --订单交期延期≤2天，延期原因为空时，默认为其他问题-其他问题影响-其他，可修改，不为空时则不赋值；
  --PROCEDURE p_update_product_progress_dayproc;
END pkg_day_proc;
/

CREATE OR REPLACE PACKAGE BODY SCMDATA.pkg_day_proc IS
  --订单数据表
  --每天更新订单交期数据表
  --更新频率：每天凌晨0000更新1次数据
  --更新说明：每月5号0000，上月数据更新最后1次，后续不再更新；（按订单交期月份判断是否为上月数据）
  PROCEDURE p_merge_order_dayproc IS
    v_begin_date DATE;
    v_end_date   DATE;
  BEGIN
    --当月1号  
    v_begin_date := trunc(SYSDATE, 'mm');
    --当月最后一天
    v_end_date := last_day(SYSDATE);
  
    FOR p_com_rec IN (SELECT fc.company_id FROM scmdata.sys_company fc) LOOP
      pkg_db_job.p_merge_order(p_company_id => p_com_rec.company_id,
                               p_begin_date => v_begin_date,
                               p_end_date   => v_end_date);
    END LOOP;
  END p_merge_order_dayproc;

  --3.更新回货计划表 begin
  PROCEDURE p_merge_return_plan_dayproc IS
  BEGIN
    pkg_db_job.p_merge_return_plan;
  END;
  --3.更新回货计划表 end

  --4.更新生产进度表  订单交期延期 
  --订单交期延期≤2天，延期原因为空时，默认为其他问题-其他问题影响-其他，可修改，不为空时则不赋值；
/*  PROCEDURE p_update_product_progress_dayproc IS
  BEGIN
    pkg_db_job.p_update_product_progress;
  END p_update_product_progress_dayproc;*/

END pkg_day_proc;
/

