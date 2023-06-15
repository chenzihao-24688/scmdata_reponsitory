create or replace trigger scmdata.trg_trial_order_report_send_wx
  before update of if_trial_order, follower_leader_suggest, qc_leader_suggest, send_number on scmdata.t_supplier_trial_order_report
  for each row
declare
  p_supplier   varchar2(128);
  p_company_id varchar2(32);
  p_type       number(1);
  p_type       number(3);
  pragma autonomous_transaction;
begin
  --试单供应商报表
  /* 供应商试单是否到期字段
   状态：是 否
  状态由否-->是 触发推送个人企微消息*/

  /*场景一、QC、跟单未维护场景*/
  /*1.首次推送消息 p_type = 1*/
  ---(1)试单未结束tab页 p_type2 = 301
  if :new.if_trial_order = '是' and :old.if_trial_order = '否' then
    select max(t.supplier_company_abbreviation), max(t.company_id)
      into p_supplier, p_company_id
      from scmdata.t_supplier_trial_order_report t
     inner join scmdata.t_supplier_info ts
        on ts.supplier_info_id = t.supplier_info_id
       and ts.company_id = t.company_id
     where t.order_report_id = :old.order_report_id
       and t.statu = '2'
       and t.trial_results is null
       and t.trialorder_type is not null
       and ts.product_type = '01'
       and ts.cooperation_model = 'OF';
    if p_supplier is null then
      select max(t.supplier_company_abbreviation), max(t.company_id)
        into p_supplier, p_company_id
        from scmdata.t_supplier_trial_order_report t
       where t.order_report_id = :old.order_report_id
         and t.statu = '2'
         and t.trial_results is null;
      if p_supplier is not null and p_company_id is not null then
        scmdata.pkg_report.p_supplier_trial_first_send_wx1(v_supplier => p_supplier,
                                                           v_id       => p_company_id,
                                                           v_type     => '1',
                                                           v_type2    => '301');
      
        :new.send_time := sysdate + 3;
      end if;
    else
      :new.statu := 1;
      :new.send_time := (case when :old.trial_results is null then :old.trial_order_end_date else :old.end_date end);
    update scmdata.t_supplier_info ts
       set ts.pause       = '1',
           ts.update_date = sysdate,
           ts.pause_cause = '停用',
           ts.update_id   = 'admin'
     where ts.supplier_info_id = :old.supplier_info_id;
    --启停合作工厂关系
    pkg_supplier_info.p_check_sup_fac_pause(p_company_id => :old.company_id ,
                                            p_sup_id     => :old.supplier_info_id);
    end if;
  
  end if;
  commit;
  ---(2)继续试单tab页 p_type2 = 302
  if :new.if_trial_order = '是' and :old.if_trial_order = '否' then
    select max(t.supplier_company_abbreviation), max(t.company_id)
      into p_supplier, p_company_id
      from scmdata.t_supplier_trial_order_report t
     where t.order_report_id = :old.order_report_id
       and t.statu = '2'
       and t.trial_results = '2';
    if p_supplier is not null and p_company_id is not null then
      scmdata.pkg_report.p_supplier_trial_first_send_wx1(v_supplier => p_supplier,
                                                         v_id       => p_company_id,
                                                         v_type     => '1',
                                                         v_type2    => '302');
    
      :new.send_time := sysdate + 3;
    end if;
  end if;
  commit;
  /* 2.推送消息3天后 p_type = 2*/
  ---(1)试单未结束tab页 p_type2 = 301
  if :new.send_number <> :old.send_number then
    select max(t.supplier_company_abbreviation), max(t.company_id)
      into p_supplier, p_company_id
      from scmdata.t_supplier_trial_order_report t
     where t.order_report_id = :old.order_report_id
       and t.statu = '2'
       and t.trial_results is null;
    if p_supplier is not null and p_company_id is not null then
      scmdata.pkg_report.p_supplier_trial_first_send_wx1(v_supplier => p_supplier,
                                                         v_id       => p_company_id,
                                                         v_type     => '2',
                                                         v_type2    => '301');
    end if;
  end if;
  commit;
  ---(2)继续试单tab页 p_type2 = 302
  if :new.send_number <> :old.send_number then
    select max(t.supplier_company_abbreviation), max(t.company_id)
      into p_supplier, p_company_id
      from scmdata.t_supplier_trial_order_report t
     where t.order_report_id = :old.order_report_id
       and t.statu = '2'
       and t.trial_results = '2';
    if p_supplier is not null and p_company_id is not null then
      scmdata.pkg_report.p_supplier_trial_first_send_wx1(v_supplier => p_supplier,
                                                         v_id       => p_company_id,
                                                         v_type     => '2',
                                                         v_type2    => '302');
    end if;
  end if;
  commit;
  /*场景二、当QC、跟单维护完推送消息给供管场景*/
  /*1.首次推送消息 p_type = 1*/
  ---(1)试单未结束tab页 p_type2 = 301
  if ((:new.follower_leader_suggest is not null and
     :old.follower_leader_suggest is null) or
     (:new.qc_leader_suggest is not null and
     :old.qc_leader_suggest is null)) and
     ((:new.follower_leader_suggest is not null or
     :old.follower_leader_suggest is not null) and
     (:new.qc_leader_suggest is not null or
     :old.qc_leader_suggest is not null)) then
    select max(t.supplier_company_abbreviation), max(t.company_id)
      into p_supplier, p_company_id
      from scmdata.t_supplier_trial_order_report t
     where t.order_report_id = :old.order_report_id
       and t.statu = '2'
       and t.trial_results is null
       and (:new.follower_leader_suggest is not null or
           :old.follower_leader_suggest is not null)
       and (:new.qc_leader_suggest is not null or
           :old.qc_leader_suggest is not null);
    if p_supplier is not null and p_company_id is not null then
      scmdata.pkg_report.p_supplier_trial_send_wx1(v_supplier => p_supplier,
                                                   v_id       => p_company_id,
                                                   v_type     => '1',
                                                   v_type2    => '301');
    
      :new.send_time := sysdate + 3;
    end if;
  end if;
  commit;
  ---(2)继续试单tab页 v_type2 = 302
  if ((:new.follower_leader_suggest is not null and
     :old.follower_leader_suggest is null) or
     (:new.qc_leader_suggest is not null and
     :old.qc_leader_suggest is null)) and
     ((:new.follower_leader_suggest is not null or
     :old.follower_leader_suggest is not null) and
     (:new.qc_leader_suggest is not null or
     :old.qc_leader_suggest is not null)) then
    select max(t.supplier_company_abbreviation), max(t.company_id)
      into p_supplier, p_company_id
      from scmdata.t_supplier_trial_order_report t
     where t.order_report_id = :old.order_report_id
       and t.statu = '2'
       and t.trial_results = '2'
       and (:new.follower_leader_suggest is not null or
           :old.follower_leader_suggest is not null)
       and (:new.qc_leader_suggest is not null or
           :old.qc_leader_suggest is not null);
    if p_supplier is not null and p_company_id is not null then
      scmdata.pkg_report.p_supplier_trial_send_wx1(v_supplier => p_supplier,
                                                   v_id       => p_company_id,
                                                   v_type     => '1',
                                                   v_type2    => '302');
    
      :new.send_time := sysdate + 3;
    end if;
  end if;
  commit;
  /*  1.推送消息3天后 p_type = 2*/
  ---(1)试单未结束tab页 p_type2 = 301
  if :new.send_number <> :old.send_number then
    select max(t.supplier_company_abbreviation), max(t.company_id)
      into p_supplier, p_company_id
      from scmdata.t_supplier_trial_order_report t
     where t.order_report_id = :old.order_report_id
       and t.statu = '2'
       and t.trial_results is null
       and t.follower_review_time is not null
       and t.qc_review_time is not null;
    if p_supplier is not null and p_company_id is not null then
      scmdata.pkg_report.p_supplier_trial_first_send_wx1(v_supplier => p_supplier,
                                                         v_id       => p_company_id,
                                                         v_type     => '2',
                                                         v_type2    => '301');
    end if;
  end if;
  commit;
  ---(2)继续试单tab页 p_type2 = 302
  if :new.send_number <> :old.send_number then
    select max(t.supplier_company_abbreviation), max(t.company_id)
      into p_supplier, p_company_id
      from scmdata.t_supplier_trial_order_report t
     where t.order_report_id = :old.order_report_id
       and t.statu = '2'
       and t.trial_results = '2'
       and t.follower_review_time is not null
       and t.qc_review_time is not null;
    if p_supplier is not null and p_company_id is not null then
      scmdata.pkg_report.p_supplier_trial_first_send_wx1(v_supplier => p_supplier,
                                                         v_id       => p_company_id,
                                                         v_type     => '2',
                                                         v_type2    => '302');
    end if;
  end if;
  commit;
end trg_trial_order_report_send_wx;
/

