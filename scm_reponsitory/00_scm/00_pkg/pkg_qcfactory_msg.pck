create or replace package scmdata.pkg_qcfactory_msg is

  -- Author  : SANFU
  -- Created : 2022/5/19 11:33:26
  -- Purpose : qc工厂配置发送消息

  --通知存在未配置的工厂
  procedure send_unconfig_factory_msg(p_company_id varchar2);
  --通知存在未配置的qc
  procedure send_unconfig_qc_msg(p_company_id varchar2);
end pkg_qcfactory_msg;
/

create or replace package body scmdata.pkg_qcfactory_msg is

  --通知存在未配置的工厂
  procedure send_unconfig_factory_msg(p_company_id varchar2) is
    --p_count   number;
    --p_factory varchar2(256);
    --p_manage_inner_id varchar2(32);
  begin
    --查询是否有未配置的工厂，根据qc分组划分
    /*for x in (select count( distinct si.supplier_code) p_count,
                     qc_group_id,
                     max(cu.user_id) p_manage_user_id,
                     listagg(distinct si.supplier_company_name, ';') p_factory
                from scmdata.t_qc_factory_config_category a
               inner join scmdata.t_supplier_info si
                  on si.supplier_code = a.factory_code
                 and si.company_id = a.company_id
               inner join scmdata.sys_company_user cu
                  on cu.company_id = a.company_id
                 and cu.user_id = a.qc_manage
               where a.company_id = p_company_id
                 and a.qc_user_id is null
                 and a.pause = 0
               group by a.qc_group_id) loop
    
      if x.p_count > 3 then
        p_factory := regexp_substr(x.p_factory, '[^;]+;[^;]+;[^;]+')|| '等';
      else
        p_factory := x.p_factory;
      end if;
    
      scmdata.pkg_send_wx_msg.p_send_com_person_wx_msg(p_company_id => p_company_id,
                                                       p_user_id    => x.p_manage_user_id,
                                                       p_content    => '<SCM系统消息>您好！'||p_factory ||
                                                                       x.p_count ||
                                                                       '家工厂没有分配到查货QC，请您前往【QC品控-QC查货工厂分配】中进行维护。',
                                                       p_sender     => 'scm');
    
    end loop;*/
    null;
  end send_unconfig_factory_msg;
  --通知存在未配置的qc
  procedure send_unconfig_qc_msg(p_company_id varchar2) is
  
    --p_user_name varchar2(256);
    --p_count     number;
  begin
    /*--查询所有未配置的qc
    for x in (select a.qc_group_id,
                     a.qc_group_leader,
                     mu.user_id,
                     a.qc_group_dept_id
                from scmdata.t_qc_group_config a
               inner join scmdata.sys_company_user mu
                  on mu.user_id = a.qc_group_leader
                 and mu.company_id = a.company_id
               where a.pause = 1
                 and a.company_id = p_company_id) loop
      select count(distinct cu.company_user_name), listagg( distinct cu.company_user_name, ';')
        into p_count, p_user_name
        from scmdata.sys_company_user_dept cud
       inner join scmdata.sys_company_user cu
          on cu.company_id = cud.company_id
         and cu.user_id = cud.user_id
         and cu.pause = 0
       inner join scmdata.sys_company_job cj
       on cj.company_id=cud.company_id
       and cj.job_id=cu.job_id
       where cud.company_dept_id = x.qc_group_dept_id
         and cud.company_id = p_company_id
         and cj.job_name='QC'
         and not exists
       (select 1
                from scmdata.t_qc_factory_config_category qc
               where qc.qc_group_id = x.qc_group_id
                 and instr(';' || qc.qc_user_id || ';',
                           ';' || cu.user_id || ';') > 0);
      if p_count >= 1 then
        if p_count > 3 then
          p_user_name := regexp_substr(p_user_name, '[^;]+;[^;]+;[^;]+') || '等';
        end if;
        scmdata.pkg_send_wx_msg.p_send_com_person_wx_msg(p_company_id => p_company_id,
                                                         p_user_id    => x.user_id,
                                                         p_content    => '<SCM系统消息>您好！'||p_user_name ||
                                                                         p_count ||
                                                                         '个组员没有分配到查货工厂，请您前往【QC品控-QC查货工厂分配】中进行维护。',
                                                         p_sender     => 'scm');
      end if;
    end loop;*/
    null;
  end send_unconfig_qc_msg;

end pkg_qcfactory_msg;
/

