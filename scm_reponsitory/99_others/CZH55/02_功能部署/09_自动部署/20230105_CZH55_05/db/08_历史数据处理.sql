BEGIN
  --扣款单
  FOR rec IN (SELECT d.deduction_id, d.order_id, d.abnormal_id, d.company_id
                FROM scmdata.t_deduction d
               WHERE d.company_id = 'b6cc680ad0f599cde0531164a8c0337f') LOOP
    UPDATE scmdata.t_abnormal t
       SET t.orgin_type = 'TD', t.origin_id = rec.deduction_id
     WHERE t.origin_id IS NULL
       AND t.origin = 'SC'
       AND t.company_id = 'b6cc680ad0f599cde0531164a8c0337f'
       AND t.order_id = rec.order_id
       AND t.abnormal_id = rec.abnormal_id
       AND t.company_id = rec.company_id;
  END LOOP;
END;
/ 
begin
  for x in (select a.abnormal_id,
                   qc.company_id,
                   qc.finish_qc_id,
                   qc.qc_check_node,
                   qc.qc_check_num,
                   qc.origin,
                   qc.finish_time
              from scmdata.t_abnormal a
             inner join scmdata.t_qc_check qc
                on qc.qc_check_id = a.origin_id
               and qc.finish_time is not null
             where a.origin = 'MA') loop
  
    update scmdata.t_abnormal a
       set a.origin         = 'SC',
           a.orgin_type     = 'QC',
           a.abnormal_orgin = scmdata.pkg_production_progress.f_get_user_third_dept_id(p_user_id    => x.finish_qc_id,
                                                                                       p_company_id => x.company_id),
           a.checker        = x.finish_qc_id,
           a.check_link     = x.qc_check_node,
           a.check_num     =
           (select count(*)
              from scmdata.t_orders os
             inner join scmdata.t_qc_check_rela_order qo
                on qo.orders_id = os.orders_id
             inner join scmdata.t_qc_check qc
                on qc.qc_check_id = qo.qc_check_id
             where os.order_id = a.order_id
               and os.company_id = a.company_id
               and qc.finish_time is not null
               and qc.qc_check_node = x.qc_check_node
               and qc.finish_time <= x.finish_time)
     where a.abnormal_id = x.abnormal_id;
  end loop;
end;
/
begin
  for x in (select a.abnormal_id, a.company_id, a.create_id
              from scmdata.t_abnormal a
             inner join scmdata.sys_company_user cu
                on cu.user_id = a.create_id
               and cu.company_id = a.company_id
             inner join scmdata.sys_company_job cj
                on cj.job_id = cu.job_id
               and cj.company_id = cu.company_id           
             where a.origin = 'MA'
               and cj.job_name = 'QC') loop
    update scmdata.t_abnormal a
       set a.origin         = 'SC',
           a.orgin_type     = 'QC',
           a.abnormal_orgin = scmdata.pkg_production_progress.f_get_user_third_dept_id(p_user_id    => x.create_id,
                                                                                       p_company_id => x.company_id),
           a.checker        = x.create_id
     where a.abnormal_id = x.abnormal_id;
  end loop;
end;
/
BEGIN
 --异常单
  UPDATE scmdata.t_abnormal t
     SET t.orgin_type = 'ABN', t.origin_id = t.abnormal_id
   WHERE t.origin_id IS NULL
     AND t.origin = 'MA'
     AND t.company_id = 'b6cc680ad0f599cde0531164a8c0337f';
END;
/
DECLARE
  v_third_dept_id VARCHAR2(32);
  v_last_dept_id  VARCHAR2(32);
  v_company_id    VARCHAR2(32) := 'b6cc680ad0f599cde0531164a8c0337f';
BEGIN
  FOR i IN (SELECT t.abnormal_id, t.company_id, t.create_id
              FROM scmdata.t_abnormal t
             WHERE t.company_id = v_company_id
               AND t.origin = 'MA') LOOP
  
    SELECT MAX(b.company_dept_id)
      INTO v_last_dept_id
      FROM scmdata.sys_company_user a
     INNER JOIN scmdata.sys_company_user_dept b
        ON b.user_id = a.user_id
       AND b.company_id = a.company_id
     WHERE a.user_id = i.create_id
       AND a.company_id = i.company_id;
  
    SELECT MAX(CASE
                 WHEN va.dept_name = '跟单部' THEN
                  NULL
                 ELSE
                  va.company_dept_id
               END)
      INTO v_third_dept_id
      FROM (SELECT row_number() over(ORDER BY v.dept_level DESC) rn,
                   v.company_dept_id,
                   v.dept_name
              FROM (SELECT c.company_dept_id,
                           c.company_id,
                           c.dept_name,
                           LEVEL dept_level
                      FROM scmdata.sys_company_dept c
                     WHERE c.company_id = i.company_id
                     START WITH c.company_dept_id = v_last_dept_id
                    CONNECT BY c.company_dept_id = PRIOR c.parent_id) v) va
     WHERE va.rn = 3;
  
    UPDATE scmdata.t_abnormal t
       SET t.abnormal_orgin = v_third_dept_id,
           t.checker        = NULL,
           t.check_link     = NULL,
           t.check_num      = NULL
     WHERE t.abnormal_id = i.abnormal_id;
  END LOOP;
END;
/
