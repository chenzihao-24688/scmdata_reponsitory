DECLARE
  v_select_sql CLOB;
  v_insert_sql CLOB;
  v_update_sql CLOB;
BEGIN
  v_select_sql := q'[select a.abnormal_dtl_config_id,
       a.pause,
       a.anomaly_classification,
       a.problem_classification,
       a.cause_classification,
       a.cause_detail,
       a.is_sup_exemption,
       a.first_dept_id,
       a.second_dept_id,
       a.is_quality_problem,
       cua.company_user_name    CREATOR,
       a.create_time,
       cub.company_user_name    UPDATOR,
       a.update_time
  from scmdata.t_abnormal_dtl_config a
 inner join sys_company_user cua
    on a.create_id = cua.user_id
   and a.company_id = cua.company_id
 inner join sys_company_user cub
    on a.update_id = cub.user_id
   and a.company_id = cub.company_id
 where a.abnormal_config_id = :abnormal_config_id
 order by a.create_time desc]';
  v_insert_sql := q'[
declare
  p_id varchar2(32);
  p_i  int;
begin
  --czh 210910 add  begin
  if :anomaly_classification = 'AC_DATE' and :is_quality_problem is null then
   raise_application_error(-20002,
                            '����ʧ�ܣ��쳣����Ϊ�������쳣��ʱ�����Ƿ��������⡱������顣');
  else
    null;
  end if;
  --czh 210910 add  end

  p_id := f_get_uuid();
  insert into t_abnormal_dtl_config
    (abnormal_dtl_config_id,
     company_id,
     abnormal_config_id,
     anomaly_classification,
     problem_classification,
     cause_classification,
     cause_detail,
     is_sup_exemption,
     first_dept_id,
     second_dept_id,
     is_quality_problem,--czh add
     pause,
     create_id,
     create_time,
     update_id,
     update_time,
     memo)
  values
    (p_id,
     %default_company_id%,
     :abnormal_config_id,
     :anomaly_classification,
     :problem_classification,
     :cause_classification,
     :cause_detail,
     :is_sup_exemption,
     :first_dept_id,
     :second_dept_id,
     :is_quality_problem,
     0,
     :user_id,
     sysdate,
     :user_id,
     sysdate,
     null);

  select nvl(max(1), 0)
    into p_i
    from t_abnormal_dtl_config a
   where a.anomaly_classification = :anomaly_classification
     and a.cause_classification = :cause_classification
     and a.problem_classification = :problem_classification
     and a.cause_detail=:cause_detail
     and a.abnormal_dtl_config_id <> p_id
     and a.abnormal_config_id = :abnormal_config_id;
  if p_i = 1 then
    raise_application_error(-20002,
                            '�Ѵ�����ͬ���쳣����+�������+ԭ�����+ԭ��ϸ�֣����飡(������ǵڶ��ο�������Ϣ�������Ҳ��ȡ����ˢ��ҳ�棡��');
  end if;

end;]';
  v_update_sql := q'[
declare
  p_i int;
begin
  --czh 210910 add  begin
  if :anomaly_classification = 'AC_DATE' and :is_quality_problem is null then
   raise_application_error(-20002,
                            '����ʧ�ܣ��쳣����Ϊ�������쳣��ʱ�����Ƿ��������⡱������顣');
  else
    null;
  end if;
  --czh 210910 add  end

  update t_abnormal_dtl_config a
     set a.anomaly_classification = :anomaly_classification,
         a.problem_classification = :problem_classification,
         a.cause_classification   = :cause_classification,
         a.cause_detail           = :cause_detail,
         a.is_sup_exemption       = :is_sup_exemption,
         a.first_dept_id          = :first_dept_id,
         a.second_dept_id         = :second_dept_id,
         a.is_quality_problem     = :is_quality_problem, --czh 210910 add �Ƿ���������
         a.update_id              = :user_id,
         a.update_time            = sysdate
   where a.abnormal_dtl_config_id = :abnormal_dtl_config_id;
  select nvl(max(1), 0)
    into p_i
    from t_abnormal_dtl_config a
   where a.anomaly_classification = :anomaly_classification
     and a.cause_classification = :cause_classification
     and a.problem_classification = :problem_classification
     and a.cause_detail=:cause_detail
     and a.abnormal_dtl_config_id <> :abnormal_dtl_config_id
     and a.abnormal_config_id = :abnormal_config_id;
  if p_i = 1 then
    raise_application_error(-20002,
                            '�Ѵ�����ͬ���쳣����+�������+ԭ�����+ԭ��ϸ�֣����飡(������ǵڶ��ο�������Ϣ�������Ҳ��ȡ����ˢ��ҳ�棡��');
  end if;
end;]';
  UPDATE bw3.sys_item_list t
     SET t.select_sql = v_select_sql,
         t.insert_sql = v_insert_sql,
         t.update_sql = v_update_sql
   WHERE t.item_id = 'a_config_122_2';
END;
