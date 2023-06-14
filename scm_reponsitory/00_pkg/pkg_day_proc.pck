CREATE OR REPLACE PACKAGE SCMDATA.pkg_day_proc IS

  -- Author  : SANFU
  -- Created : 2021/9/18 11:01:02
  -- Purpose : 执行定时任务
  --1.订单数据表
  --每天更新订单交期数据表
  --更新频率：每天凌晨0000更新1次数据
  --更新说明：每月5号0000，上月数据更新最后1次，后续不再更新；（按订单交期月份判断是否为上月数据）
  PROCEDURE p_merge_order_dayproc;

  --2.刷新所在分组配置   begin
  PROCEDURE p_update_group_config_dayproc;

  --3 更新回货计划表 begin
  PROCEDURE p_merge_return_plan_dayproc;

END pkg_day_proc;
/

CREATE OR REPLACE PACKAGE BODY SCMDATA.pkg_day_proc IS
  --1.订单数据表 begin
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
  --1.订单数据表 end

  --2.刷新所在分组配置   begin
  PROCEDURE p_update_group_config_dayproc IS
  BEGIN
    NULL;
    /*   FOR p_com_rec IN (SELECT fc.company_id FROM scmdata.sys_company fc) LOOP
      pkg_db_job.p_update_supp_group_config(p_company_id => p_com_rec.company_id);
    END LOOP;*/
  END p_update_group_config_dayproc;
  --2.刷新所在分组配置   end

  --3.更新回货计划表 begin
  PROCEDURE p_merge_return_plan_dayproc IS
  BEGIN
    pkg_db_job.p_merge_return_plan;
  END;
  --3.更新回货计划表 end
END pkg_day_proc;
/

