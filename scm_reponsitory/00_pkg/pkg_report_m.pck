create or replace package scmdata.pkg_report_m is

  -- Author  : zwh73
  -- Created : 2021/8/11 14:21:20
  -- Purpose : 面料检测相关报表

  --生成某天的的面料检测问题报表，不清空，
  procedure p_create_REPORT_KPI_M_PROBLEM(p_date date);

  --生成某天的面料个人批版检测量报表
  procedure p_create_report_KPI_M_P_SUM(p_date date);

  --生成某天的面料供应商批版检测量报表
  procedure p_create_report_KPI_M_S_SUM(p_date date);

  --生成某天的前一天的信息数据，负责错误清空，
  procedure p_update_REPORT_KPI_M_PROBLEM(p_date date default sysdate);
end pkg_report_m;
/

create or replace package body scmdata.pkg_report_m is

  procedure p_create_REPORT_KPI_M_PROBLEM(p_date date) is
    p_year  number(10);
    p_month number(10);
    p_day   number(10);
  begin
    delete from scmdata.t_report_kpi_m_problem a where a.whendate = p_date;
    delete from scmdata.t_report_kpi_m_tag a where a.whendate = p_date;
  
    p_year  := extract(year from p_date);
    p_month := extract(month from p_date);
    p_day   := extract(day from p_date);
  
    --计算面料数量
    merge into scmdata.t_report_kpi_m_problem a
    using (select k.category,
                  p_date            whendate,
                  k.company_id      company_id,
                  k.M_CHECK_SUM,
                  k.M_CHECK_UNQ_SUM
             from (select count(*) M_CHECK_SUM,
                          ci.category,
                          a.company_id,
                          count(case
                                  when a.check_result = 'FABRIC_UNQUAILIFIED' then
                                   1
                                  else
                                   null
                                end) M_CHECK_UNQ_SUM
                     from scmdata.t_check_request a
                    inner join scmdata.t_commodity_info ci
                       on ci.goo_id = a.goo_id
                      and ci.company_id = a.company_id
                    where a.check_date = p_date
                      and a.check_link <> 'LINK_05'
                    group by a.company_id, ci.category) k) b
    on (a.company_id = b.company_id and a.whendate = b.whendate and a.category = b.category)
    when matched then
      update
         set a.m_check_sum          = b.m_check_sum,
             a.m_check_unq_sum      = b.M_CHECK_UNQ_SUM,
             a.m_check_unq_percenty = b.M_CHECK_UNQ_SUM / b.M_CHECK_SUM
    when not matched then
      insert
        (a.report_kpi_m_problem_id,
         a.company_id,
         a.report_year,
         a.report_month,
         a.category,
         a.m_check_sum,
         a.m_check_unq_sum,
         a.m_check_unq_percenty,
         a.report_day,
         a.whendate)
      values
        (f_get_uuid(),
         b.company_id,
         p_year,
         p_month,
         b.category,
         b.m_check_sum,
         b.m_check_unq_sum,
         b.m_check_unq_sum / b.M_CHECK_SUM,
         p_day,
         p_date);
  
    --批版数量
    merge into scmdata.t_report_kpi_m_problem a
    using (select w.category,
                  w.M_APPROVE_SUM,
                  p_date              whendate,
                  w.company_id        company_id,
                  w.M_APPROVE_UNQ_SUM
             from (select count(*) M_APPROVE_SUM,
                          ci.category,
                          a.company_id,
                          count(case
                                  when ar.assess_result = 'EVRT02' then
                                   1
                                  else
                                   null
                                end) M_APPROVE_UNQ_SUM
                     from scmdata.t_approve_version a
                    inner join scmdata.t_approve_risk_assessment ar
                       on ar.assess_type = 'EVAL11'
                      and ar.assess_result in ('EVRT01', 'EVRT02', 'EVRT03')
                      and a.approve_version_id = ar.approve_version_id
                      and a.company_id = ar.company_id
                    inner join scmdata.t_commodity_info ci
                       on ci.goo_id = a.goo_id
                      and ci.company_id = a.company_id
                    where a.approve_time is not null
                      and trunc(ar.assess_time, 'DD') = p_date
                    group by a.company_id, ci.category) w) b
    on (a.company_id = b.company_id and a.whendate = b.whendate and a.category = b.category)
    when matched then
      update
         set a.m_approve_sum          = b.M_APPROVE_SUM,
             a.m_approve_unq_sum      = b.M_APPROVE_UNQ_SUM,
             a.m_approve_unq_percenty = b.M_APPROVE_UNQ_SUM /
                                        b.M_APPROVE_SUM
    when not matched then
      insert
        (a.report_kpi_m_problem_id,
         a.company_id,
         a.report_year,
         a.report_month,
         a.category,
         a.m_approve_sum,
         a.m_approve_unq_sum,
         a.m_approve_unq_percenty,
         a.report_day,
         a.whendate)
      values
        (f_get_uuid(),
         b.company_id,
         p_year,
         p_month,
         b.category,
         b.M_APPROVE_SUM,
         b.M_APPROVE_UNQ_SUM,
         b.M_APPROVE_UNQ_SUM / b.M_APPROVE_SUM,
         p_day,
         p_date);
    --问题设置 检测类型 APPROVE_M_UNQ_COUNT CHECK_M_CHECK_UNQ_COUNT
    --面料不合格问题统计
    merge into scmdata.t_report_kpi_m_tag a
    using (select count(*) m_check_unq_sum,
                  ci.category,
                  a.company_id,
                  cd.company_dict_value unqualified_type
             from scmdata.t_check_request a
            inner join scmdata.t_commodity_info ci
               on ci.goo_id = a.goo_id
              and ci.company_id = a.company_id
            inner join scmdata.sys_company_dict cd
               on instr(a.unqualified_type, cd.company_dict_value) > 0
              and cd.company_dict_type = 'FABRIC_UNQUALIFY_TYPE_DICT'
              and cd.company_id = a.company_id
            where a.check_date = p_date
              and a.check_link <> 'LINK_05'
              and a.check_result = 'FABRIC_UNQUAILIFIED'
            group by ci.category, a.company_id, cd.company_dict_value) b
    on (a.whendate = p_date and a.company_id = b.company_id and a.category = b.category and a.tag_type = 'CHECK_M_CHECK_UNQ_COUNT' and a.tag_name = b.unqualified_type)
    when not matched then
      insert
        (a.report_kpi_m_tag_id,
         a.report_year,
         a.report_month,
         a.report_day,
         a.whendate,
         a.company_id,
         a.category,
         a.tag_type,
         a.tag_name,
         a.tag_count)
      values
        (f_get_uuid(),
         p_year,
         p_month,
         p_day,
         p_date,
         b.company_id,
         b.category,
         'CHECK_M_CHECK_UNQ_COUNT',
         b.unqualified_type,
         b.m_check_unq_sum)
    when matched then
      update set a.tag_count = b.m_check_unq_sum;
    --批版不合格问题统计
    merge into scmdata.t_report_kpi_m_tag a
    using (select count(*) m_approve_unq_sum,
                  ci.category,
                  a.company_id,
                  ar.unqualified_say
             from scmdata.t_approve_version a
            inner join scmdata.t_approve_risk_assessment ar
               on ar.assess_type = 'EVAL11'
              and ar.assess_result in ('EVRT01', 'EVRT02', 'EVRT03')
              and a.approve_version_id = ar.approve_version_id
              and a.company_id = ar.company_id
            inner join scmdata.t_commodity_info ci
               on ci.goo_id = a.goo_id
              and ci.company_id = a.company_id
            where a.approve_time is not null
              and trunc(ar.assess_time, 'DD') = p_date
              and ar.assess_result = 'EVRT02'
            group by ci.category, a.company_id, ar.unqualified_say) b
    on (a.whendate = p_date and a.company_id = b.company_id and a.category = b.category and a.tag_type = 'APPROVE_M_UNQ_COUNT' and a.tag_name = b.unqualified_say)
    when not matched then
      insert
        (a.report_kpi_m_tag_id,
         a.report_year,
         a.report_month,
         a.report_day,
         a.whendate,
         a.company_id,
         a.category,
         a.tag_type,
         a.tag_name,
         a.tag_count)
      values
        (f_get_uuid(),
         p_year,
         p_month,
         p_day,
         p_date,
         b.company_id,
         b.category,
         'APPROVE_M_UNQ_COUNT',
         b.unqualified_say,
         b.m_approve_unq_sum)
    when matched then
      update set a.tag_count = b.m_approve_unq_sum;
  
  end p_create_REPORT_KPI_M_PROBLEM;

  procedure p_create_report_KPI_M_P_SUM(p_date date) is
    p_year  number(10);
    p_month number(10);
    p_day   number(10);
  begin
    delete from scmdata.t_report_kpi_m_p_sum a where a.whendate = p_date;
  
    p_year  := extract(year from p_date);
    p_month := extract(month from p_date);
    p_day   := extract(day from p_date);
    --面料个人数量
    merge into scmdata.t_report_kpi_m_p_sum a
    using (select count(*) M_P_CHECK_SUM,
                  ci.category,
                  a.company_id,
                  a.check_user_id
             from scmdata.t_check_request a
            inner join scmdata.t_commodity_info ci
               on ci.goo_id = a.goo_id
              and ci.company_id = a.company_id
            where a.check_date = p_date
              and a.check_link <> 'LINK_05'
            group by a.company_id, ci.category, a.check_user_id) b
    on (a.company_id = b.company_id and a.user_id = b.check_user_id and a.category = b.category and a.whendate = p_date)
    when not matched then
      insert
        (a.report_kpi_m_p_sum_id,
         a.company_id,
         a.report_year,
         a.report_month,
         a.report_day,
         a.category,
         a.m_p_approve_sum,
         a.m_p_check_sum,
         a.whendate,
         a.user_id)
      values
        (f_get_uuid(),
         b.company_id,
         p_year,
         p_month,
         p_day,
         b.category,
         null,
         b.M_P_CHECK_SUM,
         p_date,
         b.check_user_id)
    when matched then
      update set a.m_p_check_sum = b.M_P_CHECK_SUM;
    --批版个人数量
    merge into scmdata.t_report_kpi_m_p_sum a
    using (select count(*) M_P_APPROVE_SUM,
                  ci.category,
                  a.company_id,
                  ar.assess_user_id
             from scmdata.t_approve_version a
            inner join scmdata.t_approve_risk_assessment ar
               on ar.assess_type = 'EVAL11'
              and a.approve_version_id = ar.approve_version_id
              and ar.assess_result in ('EVRT01', 'EVRT02', 'EVRT03')
              and a.company_id = ar.company_id
            inner join scmdata.t_commodity_info ci
               on ci.goo_id = a.goo_id
              and ci.company_id = a.company_id
            where a.approve_time is not null
              and trunc(ar.assess_time, 'DD') = p_date
            group by a.company_id, ci.category, ar.assess_user_id) b
    on (a.company_id = b.company_id and a.user_id = b.assess_user_id and a.category = b.category and a.whendate = p_date)
    when not matched then
      insert
        (a.report_kpi_m_p_sum_id,
         a.company_id,
         a.report_year,
         a.report_month,
         a.report_day,
         a.category,
         a.m_p_approve_sum,
         a.m_p_check_sum,
         a.whendate,
         a.user_id)
      values
        (f_get_uuid(),
         b.company_id,
         p_year,
         p_month,
         p_day,
         b.category,
         b.M_P_APPROVE_SUM,
         null,
         p_date,
         b.assess_user_id)
    when matched then
      update set a.m_p_approve_sum = b.M_P_APPROVE_SUM;
  
  end p_create_report_KPI_M_P_SUM;

  procedure p_create_report_KPI_M_S_SUM(p_date date) is
    p_year  number(10);
    p_month number(10);
    p_day   number(10);
  begin
    delete from scmdata.t_report_kpi_m_s_sum a where a.whendate = p_date;
    delete from scmdata.t_report_kpi_m_s_tag a where a.whendate = p_date;
  
    p_year  := extract(year from p_date);
    p_month := extract(month from p_date);
    p_day   := extract(day from p_date);
  
    --面料供应商数量
    merge into scmdata.t_report_kpi_m_s_sum a
    using (select count(*) M_S_CHECK_SUM,
                  p_date whendate,
                  count(case
                          when a.check_result = 'FABRIC_UNQUAILIFIED' then
                           1
                          else
                           null
                        end) M_CHECK_UNQ_SUM,
                  ci.category,
                  a.company_id,
                  si.supplier_code
             from scmdata.t_check_request a
            inner join scmdata.t_commodity_info ci
               on ci.goo_id = a.goo_id
              and ci.company_id = a.company_id
            inner join scmdata.t_supplier_info si
               on a.send_check_sup_id = si.supplier_info_id
            where a.check_date = p_date
              and a.check_link <> 'LINK_05'
            group by a.company_id, ci.category, si.supplier_code) b
    on (a.company_id = b.company_id and a.supplier_code = b.supplier_code and a.category = b.category and a.whendate = p_date)
    when not matched then
      insert
        (a.report_kpi_m_s_sum_id,
         a.company_id,
         a.report_year,
         a.report_month,
         a.report_day,
         a.category,
         a.m_s_approve_sum,
         a.m_s_check_sum,
         a.m_s_check_unq_sum,
         a.m_s_check_unq_percenty,
         a.whendate,
         a.supplier_code)
      values
        (f_get_uuid(),
         b.company_id,
         p_year,
         p_month,
         p_day,
         b.category,
         null,
         b.M_S_CHECK_SUM,
         b.M_CHECK_UNQ_SUM,
         b.M_CHECK_UNQ_SUM / b.M_S_CHECK_SUM,
         p_date,
         b.supplier_code)
    when matched then
      update
         set a.m_s_check_sum          = b.M_S_CHECK_SUM,
             a.m_s_check_unq_sum      = b.M_CHECK_UNQ_SUM,
             a.m_s_check_unq_percenty = b.M_CHECK_UNQ_SUM / b.M_S_CHECK_SUM;
  
    --面料供应商不合格标签
    merge into scmdata.t_report_kpi_m_s_tag a
    using (select count(*) m_check_unq_sum,
                  ci.category,
                  a.company_id,
                  si.supplier_code,
                  cd.company_dict_value unqualified_type
             from scmdata.t_check_request a
            inner join scmdata.t_commodity_info ci
               on ci.goo_id = a.goo_id
              and ci.company_id = a.company_id
            inner join scmdata.t_supplier_info si
               on a.send_check_sup_id = si.supplier_info_id
            inner join scmdata.sys_company_dict cd
               on instr(a.unqualified_type, cd.company_dict_value) > 0
              and cd.company_dict_type = 'FABRIC_UNQUALIFY_TYPE_DICT'
              and cd.company_id = a.company_id
            where a.check_date = p_date
              and a.check_link <> 'LINK_05'
              and a.check_result = 'FABRIC_UNQUAILIFIED'
            group by ci.category,
                     a.company_id,
                     si.supplier_code,
                     cd.company_dict_value) b
    on (a.whendate = p_date and a.company_id = b.company_id and a.category = b.category and a.tag_type = 'CHECK_M_CHECK_UNQ_COUNT' and a.tag_name = b.unqualified_type and b.supplier_code = a.supplier_code)
    when not matched then
      insert
        (a.report_kpi_m_s_tag_id,
         a.company_id,
         a.report_year,
         a.report_month,
         a.report_day,
         a.whendate,
         a.supplier_code,
         a.category,
         a.tag_type,
         a.tag_name,
         a.tag_count)
      values
        (f_get_uuid(),
         b.company_id,
         p_year,
         p_month,
         p_day,
         p_date,
         b.supplier_code,
         b.category,
         'CHECK_M_CHECK_UNQ_COUNT',
         b.unqualified_type,
         b.m_check_unq_sum)
    when matched then
      update set a.tag_count = b.m_check_unq_sum;
  
    --批版供应商数量
    merge into scmdata.t_report_kpi_m_s_sum a
    using (select count(*) M_S_APPROVE_SUM,
                  count(case
                          when ar.assess_result = 'EVRT02' then
                           1
                          else
                           null
                        end) M_APPROVE_UNQ_SUM,
                  ci.category,
                  a.company_id,
                  a.supplier_code
             from scmdata.t_approve_version a
            inner join scmdata.t_approve_risk_assessment ar
               on ar.assess_type = 'EVAL11'
              and ar.assess_result in ('EVRT01', 'EVRT02', 'EVRT03')
              and a.approve_version_id = ar.approve_version_id
              and a.company_id = ar.company_id
            inner join scmdata.t_commodity_info ci
               on ci.goo_id = a.goo_id
              and ci.company_id = a.company_id
            where a.approve_time is not null
              and trunc(ar.assess_time, 'DD') = p_date
            group by a.company_id, ci.category, a.supplier_code) b
    on (a.company_id = b.company_id and a.supplier_code = b.supplier_code and a.category = b.category and a.whendate = p_date)
    when not matched then
      insert
        (a.report_kpi_m_s_sum_id,
         a.company_id,
         a.report_year,
         a.report_month,
         a.report_day,
         a.category,
         a.m_s_approve_sum,
         a.m_s_approve_unq_sum,
         a.m_s_approve_unq_percenty,
         a.m_s_check_sum,
         a.whendate,
         a.supplier_code)
      values
        (f_get_uuid(),
         b.company_id,
         p_year,
         p_month,
         p_day,
         b.category,
         b.M_S_APPROVE_SUM,
         b.M_APPROVE_UNQ_SUM,
         b.M_APPROVE_UNQ_SUM / b.M_S_APPROVE_SUM,
         null,
         p_date,
         b.supplier_code)
    when matched then
      update
         set a.m_s_approve_sum          = b.M_S_APPROVE_SUM,
             a.m_s_approve_unq_sum      = b.M_APPROVE_UNQ_SUM,
             a.m_s_approve_unq_percenty = b.M_APPROVE_UNQ_SUM /
                                          b.M_S_APPROVE_SUM;
    --批版供应商不合格标签
    merge into scmdata.t_report_kpi_m_s_tag a
    using (select count(*) m_approve_unq_sum,
                  ci.category,
                  a.company_id,
                  ar.unqualified_say,
                  a.supplier_code
             from scmdata.t_approve_version a
            inner join scmdata.t_approve_risk_assessment ar
               on ar.assess_type = 'EVAL11'
              and ar.assess_result in ('EVRT01', 'EVRT02', 'EVRT03')
              and a.approve_version_id = ar.approve_version_id
              and a.company_id = ar.company_id
            inner join scmdata.t_commodity_info ci
               on ci.goo_id = a.goo_id
              and ci.company_id = a.company_id
            where a.approve_time is not null
              and trunc(ar.assess_time, 'DD') = p_date
              and ar.assess_result = 'EVRT02'
            group by ci.category,
                     a.company_id,
                     ar.unqualified_say,
                     a.supplier_code) b
    on (a.whendate = p_date and a.company_id = b.company_id and a.category = b.category and a.tag_type = 'APPROVE_M_UNQ_COUNT' and a.tag_name = b.unqualified_say and b.supplier_code = a.supplier_code)
    when not matched then
      insert
        (a.report_kpi_m_s_tag_id,
         a.company_id,
         a.report_year,
         a.report_month,
         a.report_day,
         a.whendate,
         a.supplier_code,
         a.category,
         a.tag_type,
         a.tag_name,
         a.tag_count)
      values
        (f_get_uuid(),
         b.company_id,
         p_year,
         p_month,
         p_day,
         p_date,
         b.supplier_code,
         b.category,
         'APPROVE_M_UNQ_COUNT',
         b.unqualified_say,
         b.m_approve_unq_sum)
    when matched then
      update set a.tag_count = b.m_approve_unq_sum;
  
  end p_create_report_KPI_M_S_SUM;

  procedure p_update_REPORT_KPI_M_PROBLEM(p_date date default sysdate) is
    p_check_date   date;
    p_approve_date date;
    p_least_date   date;
  begin
    --获取当天更新的数据中，创建时间不等于检测时间最早的一个，然后从当天开始清空数据重新生成报表
    --获取当天更新审核的批版数据中，面料评估时间不等于批版时间最早的一个，和面料最早时间比较后，重新生成报表
    select nvl(min(a.check_date), p_date)
      into p_check_date
      from scmdata.t_check_request a
     where trunc(a.update_time, 'DD') = p_date
       and a.check_link <> 'LINK_05'
       and trunc(a.create_time, 'DD') <> a.check_date;
    select nvl(min(ar.assess_time), p_date)
      into p_approve_date
      from scmdata.t_approve_version a
     inner join scmdata.t_approve_risk_assessment ar
        on ar.assess_type = 'EVAL11'
       and a.approve_version_id = ar.approve_version_id
       and a.company_id = ar.company_id
     where trunc(a.approve_time) = p_date
       and trunc(ar.assess_time) <> trunc(a.approve_time);
  
    --如果时间差的太大不行，
    p_least_date := least(p_check_date, p_date, p_approve_date);
  
    while p_least_date < sysdate loop
      scmdata.pkg_report_m.p_create_report_KPI_M_P_SUM(p_date => p_least_date);
      scmdata.pkg_report_m.p_create_REPORT_KPI_M_PROBLEM(p_date => p_least_date);
      scmdata.pkg_report_m.p_create_report_KPI_M_S_SUM(p_date => p_least_date);
      p_least_date := p_least_date + 1;
    end loop;
  
  end p_update_REPORT_KPI_M_PROBLEM;

end pkg_report_m;
/

