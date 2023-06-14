CREATE OR REPLACE PACKAGE scmdata.pkg_ask_mange IS
  --�鳧����==>���鳧ҳ��
  FUNCTION f_query_uncheck_factory RETURN CLOB;
  --����鳧����  ������Ϣ item_id: a_check_101_1
  FUNCTION f_query_check_factory_base RETURN CLOB;
  --update
  --����鳧����-�޸�
  PROCEDURE p_update_check_factory_report(p_fac_rec scmdata.t_factory_report%ROWTYPE);
  --����鳧����_�鳧����鿴  item_id: a_check_101_1_1
  FUNCTION f_query_a_check_101_1_1 RETURN CLOB;
  --����鳧����_�鳧����༭  item_id: a_check_101_1_1
  PROCEDURE p_update_a_check_101_1_1(v_fac_rec t_factory_report%ROWTYPE);
  --����鳧����=����Ա��������鿴   ������Ϣ  item_id: a_check_101_1_2
  FUNCTION f_query_a_check_101_1_2(p_factory_report_id VARCHAR2) RETURN CLOB;
  --����鳧����=����Ա��������༭   ������Ϣ  item_id: a_check_101_1_2
  FUNCTION f_update_a_check_101_1_2(p_factory_report_id VARCHAR2) RETURN CLOB;
  --����鳧����=����������ά���鿴   ������Ϣ  item_id: a_check_101_1_3
  FUNCTION f_query_a_check_101_1_3(p_factory_report_id VARCHAR2) RETURN CLOB;
  --����鳧����=����������ά���༭   ������Ϣ  item_id: a_check_101_1_3
  FUNCTION f_update_a_check_101_1_3(p_factory_report_id VARCHAR2) RETURN CLOB;
  --����鳧����=��Ʒ����ϵ����ά���鿴  ������Ϣ  item_id: a_check_101_1_4
  FUNCTION f_query_a_check_101_1_4(p_factory_report_id VARCHAR2) RETURN CLOB;
  --����鳧����=��Ʒ����ϵ����ά���༭  ������Ϣ  item_id: a_check_101_1_4
  FUNCTION f_update_a_check_101_1_4(p_factory_report_id VARCHAR2) RETURN CLOB;
  --����鳧����   ���� item_id:a_check_101_4
  FUNCTION f_query_check_factory_file RETURN CLOB;

  --�鳧����==>�����
  FUNCTION f_query_checked_factory_103 RETURN CLOB;
  --�鳧����==>�����
  FUNCTION f_query_checked_factory_102 RETURN CLOB;
  --�����鳧����ʱ��ͬ��������Ա���á��������á�Ʒ����ϵ
  PROCEDURE p_generate_person_machine_config(p_company_id        VARCHAR2,
                                             p_user_id           VARCHAR2,
                                             p_factory_report_id VARCHAR2);
  /* --����
  PROCEDURE p_generate_person_machine_config_test(p_company_id        VARCHAR2,
                                                  p_user_id           VARCHAR2,
                                                  p_factory_report_id VARCHAR2);*/
  /*��Ա���á�������*/
  PROCEDURE p_insert_t_person_config_fr(p_t_per_rec t_person_config_fr%ROWTYPE);
  /*��Ա���á�����ѯ*/
  FUNCTION f_query_t_person_config_fr(p_factory_report_id VARCHAR2)
    RETURN CLOB;
  /*��Ա���á����༭*/
  PROCEDURE p_update_t_person_config_fr(p_t_per_rec t_person_config_fr%ROWTYPE);
  /*��Ա���á���ɾ��*/
  PROCEDURE p_delete_t_person_config_fr(p_t_per_rec t_person_config_fr%ROWTYPE);
  /*��Ա���á�������ʱ��ͬ�������������鳧����������Ϣ*/
  PROCEDURE p_generate_ask_record_product_info(p_company_id        VARCHAR2,
                                               p_factory_report_id VARCHAR2);
  /*�����豸��������*/
  PROCEDURE p_insert_t_machine_equipment_fr(p_t_mac_rec t_machine_equipment_fr%ROWTYPE);
  /*�����豸������ѯ*/
  FUNCTION f_query_t_machine_equipment_fr(p_factory_report_id VARCHAR2)
    RETURN CLOB;
  /*�����豸�����༭*/
  PROCEDURE p_update_t_machine_equipment_fr(p_t_mac_rec t_machine_equipment_fr%ROWTYPE);
  /*�����豸����ɾ��*/
  PROCEDURE p_delete_t_machine_equipment_fr(p_t_mac_rec t_machine_equipment_fr%ROWTYPE);
  /*Ʒ����ϵ��������*/
  PROCEDURE p_insert_t_quality_control_fr(p_t_qua_rec t_quality_control_fr%ROWTYPE);
  /*Ʒ����ϵ������ѯ*/
  FUNCTION f_query_t_quality_control_fr(p_factory_report_id VARCHAR2)
    RETURN CLOB;
  /*Ʒ����ϵ�����༭*/
  PROCEDURE p_update_t_quality_control_fr(p_t_qua_rec t_quality_control_fr%ROWTYPE);
  /*Ʒ����ϵ����ɾ��*/
  PROCEDURE p_delete_t_quality_control_fr(p_t_qua_rec t_quality_control_fr%ROWTYPE);
  --����鳧����=��Ʒ����ϵ����ά���鿴  �ֳ���Ʒ���������  item_id: a_check_101_1_8
  FUNCTION f_query_a_check_101_1_8(p_factory_report_id VARCHAR2) RETURN CLOB;
  --����鳧����=��Ʒ����ϵ����ά���༭  �ֳ���Ʒ���������  item_id: a_check_101_1_8
  FUNCTION f_update_a_check_101_1_8(p_factory_report_id varchar2) RETURN CLOB;
  --�鳧����==>�����==>�鿴�鳧����
  FUNCTION f_query_check_factory_report(p_factory_report_id varchar2)
    RETURN CLOB;
  --�鳧����==>�����==>�鿴�鳧����==������
  FUNCTION f_query_check_factory_report_file(p_factory_report_id varchar2)
    RETURN CLOB;

  PROCEDURE p_create_t_factory_report(p_factory_ask_id varchar2,
                                      p_company_id     varchar2,
                                      p_current_userid varchar2);
end pkg_ask_mange;
/
CREATE OR REPLACE PACKAGE BODY scmdata.pkg_ask_mange IS

  --�鳧����==>���鳧(item_id:a_check_101)
  FUNCTION f_query_uncheck_factory RETURN CLOB IS
    v_query_sql CLOB;
  BEGIN
    v_query_sql := q'[ WITH dic AS
 (SELECT group_dict_value, group_dict_name, group_dict_type
    FROM scmdata.sys_group_dict)
SELECT tfa.factory_ask_id,
       tfa.company_name ar_company_name_n,
       tfa.company_abbreviation ar_company_abbreviation_n,
       (case when tfa.is_urgent = '1' then '��' else '��' end) is_urgent,
       sd.dept_name check_dept_name,
       su.company_user_name check_apply_username,
       tfa.ask_date factory_ask_date,
       (SELECT listagg(b.group_dict_name, ';')within GROUP(ORDER BY b.group_dict_value)
          FROM dic b
         where instr(';' || tas.cooperation_classification || ';',
                     ';' || b.group_dict_value || ';') > 0
           AND b.group_dict_type = 'PRODUCT_TYPE') AR_COOP_CLASS_DESC_N,
       (SELECT listagg(group_dict_name, ';') within GROUP(ORDER BY group_dict_value)
          FROM dic
         WHERE group_dict_type = 'SUPPLY_TYPE'
           AND instr(';' || tfa.cooperation_model || ';',
                     ';' || group_dict_value || ';') > 0) AR_COOPERATION_MODEL_N,
       sgd.group_dict_name product_type,
       tfa.factory_name fa_company_name,
       tfa.ask_address ar_factroy_address,
       tfa.contact_name business_contact,
       tfa.contact_phone contact_number
  FROM (SELECT factory_ask_id,
               factrory_ask_flow_status,
               ask_date,
               ask_user_dept_id,
               factory_ask_type,
               cooperation_company_id,
               ask_company_id,
               ask_user_id,
               factory_name,
               ask_address,
               cooperation_type,
               cooperation_model,
               company_name,
               company_abbreviation,
               contact_name,
               contact_phone,
               product_type,
               company_address,
               company_id,
               create_date,
               a.is_urgent
          FROM scmdata.t_factory_ask a
         WHERE ask_company_id = %default_company_id%
           AND factrory_ask_flow_status = 'FA11') tfa
 inner join (select distinct object_id,be_company_id,listagg( distinct cooperation_classification, ';') cooperation_classification
              from scmdata.t_ask_scope where pause = 0 group by object_id,be_company_id ) tas
    on tas.object_id = tfa.factory_ask_id
   and tas.be_company_id = tfa.company_id
  LEFT JOIN scmdata.sys_company_dept sd
    ON tfa.company_id = sd.company_id
   AND tfa.ask_user_dept_id = sd.company_dept_id
  LEFT JOIN scmdata.sys_company_user su
    ON tfa.company_id = su.company_id
   AND tfa.ask_user_id = su.user_id
  LEFT JOIN dic sgd
    ON sgd.group_dict_type = 'FA_PRODUCT_TYPE'
   AND sgd.group_dict_value = tfa.product_type
 WHERE ((%is_company_admin% = 1) OR
       instr_priv(p_str1  => @subsql@,
                   p_str2  => tas.cooperation_classification,
                   p_split => ';') > 0)
 ORDER BY tfa.ask_date DESC,tfa.factory_ask_id DESC ]';
    RETURN v_query_sql;
  END f_query_uncheck_factory;

  --����鳧����  ������Ϣ item_id: a_check_101_1
  FUNCTION f_query_check_factory_base RETURN CLOB IS
    v_query_sql CLOB;
  BEGIN
/*    v_query_sql := Q'[ WITH company_user AS
 (SELECT company_id, company_user_name, phone, user_id
    FROM scmdata.sys_company_user)
SELECT tfa.factory_ask_id,
       tfa.rela_supplier_id,
       fr.factory_report_id ,
       ---�鳧����
       tfa.company_name ar_company_name_n,
       tfa.factory_name ar_factory_name,
       ---�鳧��Ա
       nvl(fr.check_person1, %current_userid%) check_person1, --�鳧��Ա1id
       su1.company_user_name check_person1_desc, --�鳧��Ա1
       fr.check_person2, --�鳧��Ա2id
       su2.company_user_name check_person2_desc, --�鳧��Ա2
       fr.check_date, --�鳧����
       --��Ա����
       '��Ա��������ά��' PERSON_DETAILS_LINK,
       fr.person_config_result person_config_result_id,
       ta.company_dict_name   person_config_result,
       fr.person_config_reason ,
       --�����豸
       '�����豸����ά��' MACHINE_DETAILS_LINK,
       fr.machine_equipment_result machine_equipment_result_id,
       tb.company_dict_name  machine_equipment_result,
       fr.machine_equipment_reason ,
       --Ʒ����ϵ
       'Ʒ����ϵ����ά��' CONTROL_DETAILS_LINK,
       fr.control_result control_result_id,
       tc.company_dict_name control_result,
       fr.control_reason 
  FROM scmdata.t_factory_ask tfa
 INNER JOIN scmdata.t_factory_report fr
    ON tfa.company_id = fr.company_id
   AND tfa.factory_ask_id = fr.factory_ask_id
  LEFT JOIN company_user su1
    ON su1.company_id = %default_company_id%
   AND su1.user_id = nvl(fr.check_person1, %current_userid%)
  LEFT JOIN company_user su2
    ON su2.company_id = %default_company_id%
   AND su2.user_id = nvl(fr.check_person2, %current_userid%)
  LEFT JOIN scmdata.sys_company_dict ta
    ON ta.company_id = %default_company_id%
   AND ta.company_dict_type ='ASK_REASON'
   AND ta.company_dict_value = fr.person_config_result
  LEFT JOIN scmdata.sys_company_dict tb
    ON tb.company_id = %default_company_id%
   AND tb.company_dict_type ='ASK_REASON'
   AND tb.company_dict_value = fr.machine_equipment_result
  LEFT JOIN scmdata.sys_company_dict tc
    ON tc.company_id = %default_company_id%
   AND tc.company_dict_type ='ASK_REASON'
   AND tc.company_dict_value = fr.control_result
 WHERE tfa.factory_ask_id = :factory_ask_id ]';*/
 v_query_sql := q'[  WITH company_user AS
 (SELECT company_id, company_user_name, phone, user_id
    FROM scmdata.sys_company_user)
SELECT tfa.factory_ask_id,
       tfa.rela_supplier_id,
       fr.factory_report_id ,
       ---�鳧����
       tfa.company_name ar_company_name_n,
       tfa.factory_name ar_factory_name,
       ---�鳧��Ա
       nvl(fr.check_person1, %current_userid%) check_person1, --�鳧��Ա1id
       su1.company_user_name check_person1_desc, --�鳧��Ա1
       fr.check_person2, --�鳧��Ա2id
       su2.company_user_name check_person2_desc, --�鳧��Ա2
       fr.check_date, --�鳧����
       --��Ա����
       '��Ա���ò���' PERSON_DETAILS_LINK,
       fr.person_config_result person_config_result_id,
       ta.company_dict_name   person_config_result,
       fr.person_config_reason ,
       --�����豸
       '�����豸����' MACHINE_DETAILS_LINK,
       fr.machine_equipment_result machine_equipment_result_id,
       tb.company_dict_name  machine_equipment_result,
       fr.machine_equipment_reason ,
       --Ʒ����ϵ
       'Ʒ����ϵ����' CONTROL_DETAILS_LINK,
       fr.control_result control_result_id,
       tc.company_dict_name control_result,
       fr.control_reason,
       --�鳧���
       '��������' FR_ABILITY_RESULT_DESC,
       fr.check_result ask_check_result_y,
       (select t.group_dict_name
          from scmdata.sys_group_dict t
         where t.group_dict_type = 'CHECK_RESULT'
           and t.group_dict_value = fr.check_result) ask_check_result_desc_y,
       fr.check_say,
       --��������
       fr.certificate_file ar_certificate_file_y,
       fr.check_report_file ask_report_files,
       fr.supplier_gate ar_supplier_gate_n,
       fr.supplier_office ar_supplier_office_n,
       fr.supplier_site ar_supplier_site_n,
       fr.supplier_product ar_supplier_product_n,
       fr.ask_files ASK_OTHER_FILES
  FROM scmdata.t_factory_ask tfa
 INNER JOIN scmdata.t_factory_report fr
    ON tfa.company_id = fr.company_id
   AND tfa.factory_ask_id = fr.factory_ask_id
  LEFT JOIN company_user su1
    ON su1.company_id = %default_company_id%
   AND su1.user_id = nvl(fr.check_person1, %current_userid%)
  LEFT JOIN company_user su2
    ON su2.company_id = %default_company_id%
   AND su2.user_id = nvl(fr.check_person2, %current_userid%)
  LEFT JOIN scmdata.sys_company_dict ta
    ON ta.company_id = %default_company_id%
   AND ta.company_dict_type ='ASK_REASON'
   AND ta.company_dict_value = fr.person_config_result
  LEFT JOIN scmdata.sys_company_dict tb
    ON tb.company_id = %default_company_id%
   AND tb.company_dict_type ='ASK_REASON'
   AND tb.company_dict_value = fr.machine_equipment_result
  LEFT JOIN scmdata.sys_company_dict tc
    ON tc.company_id = %default_company_id%
   AND tc.company_dict_type ='ASK_REASON'
   AND tc.company_dict_value = fr.control_result
 WHERE tfa.factory_ask_id = :factory_ask_id ]';
    RETURN v_query_sql;
  END f_query_check_factory_base;
  --update
  --����鳧����-�޸�
  PROCEDURE p_update_check_factory_report(p_fac_rec scmdata.t_factory_report%ROWTYPE) IS
  BEGIN
      if p_fac_rec.person_config_result = '01' then
        if p_fac_rec.person_config_reason is null then
          raise_application_error(-20002,
                                  '����Ա���ý���=�������ϡ�ʱ��������ԭ��Ϊ���');
        end if;
      end if;
      if p_fac_rec.machine_equipment_result = '01' then
        if p_fac_rec.machine_equipment_reason is null then
          raise_application_error(-20002,
                                  '�������豸����=�������ϡ�ʱ��������ԭ��Ϊ���');
        end if;
      end if;
      if p_fac_rec.control_result = '01' then
        if p_fac_rec.control_reason is null then
          raise_application_error(-20002,
                                  '��Ʒ����ϵ����=�������ϡ�ʱ��������ԭ��Ϊ���');
        end if;
      end if;
      UPDATE scmdata.t_factory_report t
         SET t.check_person1            = p_fac_rec.check_person1, --�鳧��Ա1 
             t.check_person2            = p_fac_rec.check_person2, --�鳧��Ա2 
             t.check_date               = p_fac_rec.check_date, --�鳧���� 
             t.person_config_result     = p_fac_rec.person_config_result, --���ۣ���Ա���ã�
             t.person_config_reason     = p_fac_rec.person_config_reason, --������ԭ����Ա���ã�
             t.machine_equipment_result = p_fac_rec.machine_equipment_result, --���ۣ������豸��
             t.machine_equipment_reason = p_fac_rec.machine_equipment_reason, --������ԭ�򣨻����豸��
             t.control_result           = p_fac_rec.control_result, --���ۣ�Ʒ����ϵ��
             t.control_reason           = p_fac_rec.control_reason, --������ԭ��Ʒ����ϵ��
             t.check_result             = p_fac_rec.check_result,
             t.check_say                = p_fac_rec.check_say,
             t.certificate_file         = p_fac_rec.certificate_file, --Ӫҵִ�� 
             t.ask_files                = p_fac_rec.ask_files, --�鳧���븽�� 
             t.supplier_gate            = p_fac_rec.supplier_gate, --��˾���Ÿ�����ַ 
             t.supplier_office          = p_fac_rec.supplier_office, --��˾�칫�Ҹ�����ַ 
             t.supplier_site            = p_fac_rec.supplier_site, --�����ֳ�������ַ 
             t.supplier_product         = p_fac_rec.supplier_product, --��ƷͼƬ������ַ 
             t.check_report_file        = p_fac_rec.check_report_file, --�ϴ��鳧���� 
             t.update_id                = p_fac_rec.update_id,
             t.update_date              = p_fac_rec.update_date
       WHERE t.factory_report_id = p_fac_rec.factory_report_id;
  END p_update_check_factory_report;

  --����鳧����_�鳧����鿴  item_id: a_check_101_1_1
  FUNCTION f_query_a_check_101_1_1 RETURN CLOB IS
    v_query_sql CLOB;
  BEGIN
    v_query_sql := Q'[ select fr.check_result ask_check_result_y,
       (select t.group_dict_name
          from scmdata.sys_group_dict t
         where t.group_dict_type = 'CHECK_RESULT'
           and t.group_dict_value = fr.check_result) ask_check_result_desc_y,
       fr.check_say
  from scmdata.t_factory_report fr
 where fr.factory_report_id = :factory_report_id]';
    RETURN v_query_sql;
  END f_query_a_check_101_1_1;

  --����鳧����_�鳧����༭  item_id: a_check_101_1_1
  PROCEDURE p_update_a_check_101_1_1(v_fac_rec t_factory_report%ROWTYPE) IS
  BEGIN
    UPDATE scmdata.t_factory_report t
       SET t.check_result = v_fac_rec.check_result,
           t.check_say    = v_fac_rec.check_say,
           t.update_id    = v_fac_rec.update_id,
           t.update_date  = v_fac_rec.update_date
     WHERE t.factory_report_id = v_fac_rec.factory_report_id;
  END p_update_a_check_101_1_1;

  --����鳧����=����Ա��������鿴   ������Ϣ  item_id: a_check_101_1_2
  FUNCTION f_query_a_check_101_1_2(p_factory_report_id VARCHAR2) RETURN CLOB IS
    v_sql CLOB;
  BEGIN
    v_sql := 'SELECT tfa.factory_ask_id,
       fr.factory_report_id,
       tfa.product_link AR_PRODUCT_LINK_N, --�������� 
     (select g.group_dict_name
        from scmdata.sys_group_dict g
       where g.group_dict_type = ''PRODUCT_LINK''
         and tfa.product_link = g.group_dict_value) AR_PRODUCT_LINK_DESC_N ,
       decode(fr.factory_area,null,nvl(tfa.factroy_area ,0),fr.factory_area) AR_FACTROY_AREA_Y, --�������
       fr.product_line AR_PRODUCT_LINE_N, --����������  
      (select g.group_dict_name
        from scmdata.sys_group_dict g
       where g.group_dict_type = ''PRODUCT_LINE''
         and fr.product_line = g.group_dict_value) AR_PRODUCT_LINE_DESC_N,
       fr.product_line_num PRODUCT_LINE_NUM_N, --���������� 
       decode(fr.work_hours_day,
              null,
              nvl(tfa.work_hours_day, 0),
              fr.work_hours_day) work_hours_day, --�ϰ�ʱ��/�� 
       fr.total_number,--������
       decode(fr.worker_num, null, nvl(tfa.worker_num, 0), fr.worker_num) worker_num, --��λ���� 
       fr.molding_number,--��������_Ь��  
       decode(fr.product_efficiency,
              null,tfa.product_efficiency,fr.product_efficiency) AR_PRODUCT_EFFICIENCY_Y, --����Ч�� 
       (select g.group_dict_name
          from scmdata.sys_group_dict g
         where g.group_dict_type = ''PATTERN_CAP''
           and nvl(fr.pattern_cap, ''00'') = g.group_dict_value ) pattern_cap,--������� 
       (select g.group_dict_name
          from scmdata.sys_group_dict g
         where g.group_dict_type = ''FABRIC_PURCHASE_CAP''
           and nvl(fr.fabric_purchase_cap, ''00'') = g.group_dict_value) fabric_purchase_cap --���ϲɹ����� 
  FROM scmdata.t_factory_ask tfa
 INNER JOIN scmdata.t_factory_report fr
    ON tfa.company_id = fr.company_id
   AND tfa.factory_ask_id = fr.factory_ask_id
 WHERE fr.factory_report_id = ''' || p_factory_report_id || '''';
    RETURN v_sql;
  END f_query_a_check_101_1_2;

  --����鳧����=����Ա��������༭   ������Ϣ  item_id: a_check_101_1_2
  FUNCTION f_update_a_check_101_1_2(p_factory_report_id VARCHAR2) RETURN CLOB IS
    v_sql CLOB;
  BEGIN
    v_sql := q'[DECLARE
  v_factory_ask_id    varchar2(32);
  v_factory_report_id varchar2(32) := ']' ||
             p_factory_report_id || q'[';
BEGIN
    --���鳧�����id
  select tf.factory_ask_id
    into v_factory_ask_id
    from scmdata.t_factory_report tf
   where tf.factory_report_id =  v_factory_report_id;
  --�����鳧�����
  update scmdata.t_factory_report tf
     set tf.factory_area       = :ar_factroy_area_y,
         tf.product_line       = :AR_PRODUCT_LINE_N,
         tf.product_line_num   = :product_line_num_n,
         tf.work_hours_day     = :work_hours_day,
         tf.product_efficiency = :ar_product_efficiency_y
   where tf.factory_report_id = v_factory_report_id;
  --�����鳧�����
  update scmdata.t_factory_ask tr
     set tr.product_link = :AR_PRODUCT_LINK_N
   where tr.factory_ask_id = v_factory_ask_id;
END;]';
    RETURN v_sql;
  END f_update_a_check_101_1_2;

  --����鳧����=����������ά���鿴   ������Ϣ  item_id: a_check_101_1_3
  FUNCTION f_query_a_check_101_1_3(p_factory_report_id VARCHAR2) RETURN CLOB IS
    v_sql CLOB;
  BEGIN
    v_sql := 'SELECT fr.factory_report_id ,
 decode(fr.machine_num,null,nvl(tfa.machine_num,0),fr.machine_num) AR_MACHINE_NUM_Y
  FROM scmdata.t_factory_report fr
 inner join scmdata.t_factory_ask tfa 
    ON tfa.company_id = fr.company_id
   AND tfa.factory_ask_id = fr.factory_ask_id
 WHERE fr.factory_report_id = ''' || p_factory_report_id || '''';
    RETURN v_sql;
  END f_query_a_check_101_1_3;

  --����鳧����=����������ά���༭   ������Ϣ  item_id: a_check_101_1_3
  FUNCTION f_update_a_check_101_1_3(p_factory_report_id VARCHAR2) RETURN CLOB IS
    v_sql CLOB;
  BEGIN
    v_sql := q'[ UPDATE SCMDATA.T_FACTORY_REPORT T
       SET T.MACHINE_NUM = :AR_MACHINE_NUM_Y,
           T.UPDATE_ID   = :USER_ID,
           T.UPDATE_DATE = SYSDATE
     WHERE T.FACTORY_REPORT_ID = ']' || p_factory_report_id || '''';
    RETURN v_sql;
  END f_update_a_check_101_1_3;

  --����鳧����=��Ʒ����ϵ����ά���鿴  ������Ϣ  item_id: a_check_101_1_4
  FUNCTION f_query_a_check_101_1_4(p_factory_report_id VARCHAR2) RETURN CLOB IS
    v_sql CLOB;
  BEGIN
    v_sql := 'SELECT fr.factory_report_id,fr.brand_type,fr.cooperation_brand,
       (SELECT listagg(b.group_dict_name, '';'') within GROUP(ORDER BY b.group_dict_value)
          FROM scmdata.sys_group_dict a
          LEFT JOIN scmdata.sys_group_dict b
            ON a.group_dict_type = ''COOPERATION_BRAND''
           AND a.group_dict_id = b.parent_id
           AND instr('';'' ||fr.brand_type || '';'',
                     '';'' || a.group_dict_value || '';'') > 0
           AND instr('';'' || fr.cooperation_brand || '';'',
                     '';'' || b.group_dict_value || '';'') > 0) ar_coop_brand_desc_n,
       fr.quality_step  ar_quality_step_y,
      (select t.group_dict_name
        from scmdata.sys_group_dict t
       where t.group_dict_type = ''QUALITY_STEP''
         and t.group_dict_value =  fr.quality_step) ar_quality_step_desc_y,
       fr.fabric_check_cap  ar_fabric_check_cap_y,
      (select t.group_dict_name
        from scmdata.sys_group_dict t
       where t.group_dict_type = ''FABRIC_CHECK_CAP''
         and t.group_dict_value = fr.fabric_check_cap)  ar_fabric_check_cap_desc_y,
       fr.spot_check_brand            FR_SPOT_CHECK_BRAND_N,
       fr.spot_check_type             FR_SPOT_CHECK_TYPE_N,
       fr.spot_check_result           FR_SPOT_CHECK_RESULT_Y,
       fr.disqualification_cause      FR_DISQUALIFICATION_CAUSE_N,
       fr.spot_check_result_accessory fr_check_result_accessory_n
        FROM scmdata.t_factory_report fr
       WHERE fr.factory_report_id = ''' || p_factory_report_id || '''';
    RETURN v_sql;
  END f_query_a_check_101_1_4;

  --����鳧����=��Ʒ����ϵ����ά���༭  ������Ϣ  item_id: a_check_101_1_4
  FUNCTION f_update_a_check_101_1_4(p_factory_report_id VARCHAR2) RETURN CLOB IS
    v_sql    CLOB;
   -- v_result varchar2(32);
  BEGIN
    v_sql := q'[
begin
    if :fr_spot_check_result_y = 'FR_01' then
       if :fr_disqualification_cause_n is null then
       raise_application_error(-20002, '�����������=�����ϸ�ʱ�������ϸ�ԭ�򡱱��');
       end if;
    end if;
  if :fr_spot_check_result_y is null then
    raise_application_error(-20002, '�������Ϊ�գ�');
  end if;
    UPDATE scmdata.t_factory_report t
       SET t.spot_check_brand            = :fr_spot_check_brand_n,
           t.spot_check_type             = :fr_spot_check_type_n,
           t.spot_check_result           = :fr_spot_check_result_y,
           t.disqualification_cause      = :fr_disqualification_cause_n,
           t.spot_check_result_accessory = :fr_check_result_accessory_n,
           T.BRAND_TYPE                  = :BRAND_TYPE,
           T.COOPERATION_BRAND           = :COOPERATION_BRAND,
           T.QUALITY_STEP                = :AR_QUALITY_STEP_Y,
           T.FABRIC_CHECK_CAP            = :AR_FABRIC_CHECK_CAP_Y,
           t.update_id                   = :user_id,
           t.update_date                 = sysdate
     WHERE t.factory_report_id =  ']' || p_factory_report_id || ''';
end;';
/*
    v_sql := q'[  UPDATE SCMDATA.T_FACTORY_REPORT T
       SET T.BRAND_TYPE        = :BRAND_TYPE,
           T.COOPERATION_BRAND = :COOPERATION_BRAND,
           T.QUALITY_STEP      = :AR_QUALITY_STEP_Y,
           T.FABRIC_CHECK_CAP  = :AR_FABRIC_CHECK_CAP_Y,
           T.UPDATE_ID         = :USER_ID,
           T.UPDATE_DATE       = SYSDATE
     WHERE T.FACTORY_REPORT_ID = ']' || p_factory_report_id || '''';*/
    RETURN v_sql;
  END f_update_a_check_101_1_4;

  --����鳧����   ���� item_id:a_check_101_4
  FUNCTION f_query_check_factory_file RETURN CLOB IS
    v_query_sql CLOB;
  BEGIN
    /*    v_query_sql := Q'[ SELECT fr.FACTORY_REPORT_ID,
          nvl(fr.certificate_file,tfa.certificate_file) ar_certificate_file_y,
          fr.check_report_file ask_report_files,
          nvl(fr.supplier_gate,tfa.supplier_gate) ar_supplier_gate_n,
          nvl(fr.supplier_office,tfa.supplier_office) ar_supplier_office_n,
          nvl(fr.supplier_site,tfa.supplier_site) ar_supplier_site_n,
          nvl(fr.supplier_product,tfa.supplier_product) ar_supplier_product_n,
          nvl(fr.ask_files,tfa.ask_files) ASK_OTHER_FILES
     FROM scmdata.t_factory_ask tfa
    INNER JOIN scmdata.t_factory_report fr
       ON tfa.company_id = fr.company_id
      AND tfa.factory_ask_id = fr.factory_ask_id
    WHERE fr.FACTORY_REPORT_ID = :FACTORY_REPORT_ID ]';*/
    v_query_sql := Q'[ SELECT fr.FACTORY_REPORT_ID,
           fr.certificate_file ar_certificate_file_y,
           fr.check_report_file ask_report_files,
           fr.supplier_gate ar_supplier_gate_n,
           fr.supplier_office ar_supplier_office_n,
           fr.supplier_site ar_supplier_site_n,
           fr.supplier_product ar_supplier_product_n,
           fr.ask_files ASK_OTHER_FILES
      FROM scmdata.t_factory_report fr
     WHERE fr.FACTORY_REPORT_ID = :FACTORY_REPORT_ID ]';
    RETURN v_query_sql;
  END f_query_check_factory_file;



  --�鳧����==> �����ҳ�� (item_id:a_check_103)
  FUNCTION f_query_checked_factory_103 RETURN CLOB IS
    v_query_sql CLOB;
  BEGIN
    v_query_sql := q'[ WITH dic AS
 (SELECT group_dict_value, group_dict_name, group_dict_type
    FROM scmdata.sys_group_dict)
SELECT tfa.factory_ask_id, --�鳧����ID
       tfa.company_name AR_COMPANY_NAME_N, --��˾����
       tfa.company_abbreviation AR_COMPANY_ABBREVIATION_N, --��˾���
       (case when tfa.is_urgent = '1' then '��' else '��' end) is_urgent, --�Ƿ����
       fr.factory_report_id,
       sg.group_dict_name ask_check_result,
       --fr.check_result ask_check_result,
       fr.check_say ask_check_say,
       (case
         when fr.check_person2 is null then
          (SELECT company_user_name
             FROM scmdata.sys_company_user
            WHERE company_id = fr.company_id
              AND user_id = fr.check_person1)
         else
          (SELECT company_user_name
             FROM scmdata.sys_company_user
            WHERE company_id = fr.company_id
              AND user_id = fr.check_person1) || ';' ||
          (SELECT company_user_name
             FROM scmdata.sys_company_user
            WHERE company_id = fr.company_id
              AND user_id = fr.check_person2)
       end) check_person,
       fr.check_date,
       (SELECT listagg(b.group_dict_name, ';')
          FROM (SELECT DISTINCT cooperation_classification tmp
                  FROM scmdata.t_ask_scope
                 WHERE object_id = tfa.factory_ask_id) a
         INNER JOIN dic b
            ON a.tmp = b.group_dict_value
           AND b.group_dict_type = 'PRODUCT_TYPE') AR_COOP_CLASS_DESC_N, --�����������
       (SELECT listagg(group_dict_name, ';') within GROUP(ORDER BY group_dict_value)
          FROM dic
         WHERE group_dict_type = 'SUPPLY_TYPE'
           AND instr(';' || tfa.cooperation_model || ';',
                     ';' || group_dict_value || ';') > 0) AR_COOPERATION_MODEL_N, --�������ģʽ
       (select t.group_dict_name
          from scmdata.sys_group_dict t
         where t.group_dict_type = 'FA_PRODUCT_TYPE'
           and t.group_dict_value = tfa.product_type) product_type, --��������
       tfa.factory_name fa_company_name, --��������
       tfa.ask_address ar_factroy_address, --������ַ
       (SELECT dept_name
          FROM scmdata.sys_company_dept
         where tfa.ask_user_dept_id = company_dept_id) check_dept_name, --�鳧�˲���
       (SELECT company_user_name
          FROM scmdata.sys_company_user
         WHERE company_id = tfa.company_id
           AND user_id = tfa.ask_user_id) check_apply_username, --�鳧������
       tfa.ask_date factory_ask_date --�鳧��������
  FROM (SELECT factory_ask_id,
               factrory_ask_flow_status,
               ask_date,
               ask_user_dept_id,
               factory_ask_type,
               cooperation_company_id,
               ask_company_id,
               ask_user_id,
               factory_name,
               ask_address,
               cooperation_type,
               cooperation_model,
               company_name,
               company_abbreviation,
               contact_name,
               contact_phone,
               product_type,
               company_address,
               company_id,
               create_date,
               a.is_urgent
          FROM scmdata.t_factory_ask a
         WHERE instr('FA13,', factrory_ask_flow_status || ',') > 0
           AND ask_company_id = %default_company_id% ) tfa
 inner join scmdata.t_factory_report fr
    on tfa.company_id = fr.company_id
   and tfa.factory_ask_id = fr.factory_ask_id
  left join scmdata.sys_user su
    on tfa.ask_user_id = su.user_id
  left join scmdata.sys_group_dict sg
    on sg.group_dict_type = 'CHECK_RESULT'
   and sg.group_dict_value = fr.check_result
 order by tfa.ask_date desc,factory_ask_id desc
]';
    RETURN v_query_sql;
  END f_query_checked_factory_103;

  --�鳧����==> �����ҳ�� (item_id:a_check_102)
  FUNCTION f_query_checked_factory_102 RETURN CLOB IS
    v_query_sql CLOB;
  BEGIN
    v_query_sql := q'[ WITH dic AS
 (SELECT group_dict_value, group_dict_name, group_dict_type
    FROM scmdata.sys_group_dict)
SELECT tfa.factory_ask_id, --�鳧����ID
       tfa.company_name AR_COMPANY_NAME_N, --��˾����
       tfa.company_abbreviation AR_COMPANY_ABBREVIATION_N, --��˾���
       tfa.factrory_ask_flow_status , --����״̬
       substr(status,instr(status, '+') + 1) FLOW_STATUS_DESC,
       fr.factory_result_suggest ,
       (SELECT listagg(b.group_dict_name, ';')within GROUP(ORDER BY b.group_dict_value)
          FROM dic b
         where instr(';' || tas.cooperation_classification || ';',
                     ';' || b.group_dict_value || ';') > 0
           AND b.group_dict_type = 'PRODUCT_TYPE') AR_COOP_CLASS_DESC_N,
       (SELECT listagg(group_dict_name, ';') within GROUP(ORDER BY group_dict_value)
          FROM dic
         WHERE group_dict_type = 'SUPPLY_TYPE'
           AND instr(';' || tfa.cooperation_model || ';',
                     ';' || group_dict_value || ';') > 0) AR_COOPERATION_MODEL_N, --�������ģʽ
       (select t.group_dict_name
          from scmdata.sys_group_dict t
         where t.group_dict_type = 'FA_PRODUCT_TYPE'
           and t.group_dict_value = tfa.product_type) product_type, --��������
       tfa.factory_name fa_company_name, --��������
       tfa.ask_address ar_factroy_address, --������ַ
       fr.factory_report_id,
       --fr.check_result ask_check_result,
       sg.group_dict_name ask_check_result,
       fr.check_say ask_check_say,
       fr.check_date,
       (SELECT dept_name
          FROM scmdata.sys_company_dept
         where tfa.ask_user_dept_id = company_dept_id) check_dept_name, --�鳧�˲���
       (SELECT company_user_name
          FROM scmdata.sys_company_user
         WHERE company_id = tfa.company_id
           AND user_id = tfa.ask_user_id) check_apply_username, --�鳧������
       tfa.ask_date factory_ask_date --�鳧��������
  FROM (SELECT factory_ask_id,
               factrory_ask_flow_status,
               ask_date,
               ask_user_dept_id,
               factory_ask_type,
               cooperation_company_id,
               ask_company_id,
               ask_user_id,
               factory_name,
               ask_address,
               cooperation_type,
               cooperation_model,
               company_name,
               company_abbreviation,
               contact_name,
               contact_phone,
               product_type,
               company_address,
               company_id,
               create_date,
               (SELECT group_dict_name
                  FROM dic
                 WHERE group_dict_value = factrory_ask_flow_status
                   AND group_dict_type = 'FACTORY_ASK_FLOW') status,
               a.is_urgent
          FROM scmdata.t_factory_ask a
         WHERE instr('FA12,FA14,FA21,FA22,FA32,FA33,SP_01,',factrory_ask_flow_status || ',') > 0 
           AND ask_company_id = %default_company_id% ) tfa
 inner join (select distinct object_id,be_company_id,listagg( distinct cooperation_classification, ';') cooperation_classification
              from scmdata.t_ask_scope where pause = 0 group by object_id,be_company_id ) tas
    on tas.object_id = tfa.factory_ask_id
   and tas.be_company_id = tfa.company_id
 inner join scmdata.t_factory_report fr
    on tfa.company_id = fr.company_id
   and tfa.factory_ask_id = fr.factory_ask_id
  left join scmdata.sys_user su
    on tfa.ask_user_id = su.user_id
  left join scmdata.sys_group_dict sg
    on sg.group_dict_type = 'CHECK_RESULT'
   and sg.group_dict_value = fr.check_result
 WHERE ((%is_company_admin% = 1) OR
       instr_priv(p_str1  => @subsql@,
                   p_str2  => tas.cooperation_classification,
                   p_split => ';') > 0)
 order by tfa.ask_date desc,factory_ask_id desc ]';
    RETURN v_query_sql;
  END f_query_checked_factory_102;

  --�����鳧����ʱ��ͬ��������Ա���������á�Ʒ����ϵ
  PROCEDURE p_generate_person_machine_config(p_company_id        VARCHAR2,
                                             p_user_id           VARCHAR2,
                                             p_factory_report_id VARCHAR2) IS
    v_flag           INT := 0;
    v_cnt            INT := 0;
    p_factory_ask_id varchar2(32);
  BEGIN
    --��Ա����
    DECLARE
      v_t_per_rec t_person_config_fr%ROWTYPE;
    BEGIN
      SELECT COUNT(1)
        INTO v_flag
        FROM scmdata.t_person_config_fr t
       WHERE t.factory_report_id = p_factory_report_id
         AND t.company_id = p_company_id;
      select max(t.factory_ask_id)
        into p_factory_ask_id
        from scmdata.t_factory_report t
       where t.factory_report_id = p_factory_report_id
         AND t.company_id = p_company_id;
      IF v_flag > 0 THEN
        NULL;
      ELSE
        FOR p_t_per_rec IN (SELECT *
                              FROM scmdata.t_person_config_fa t
                             WHERE t.company_id = p_company_id
                               and t.factory_ask_id = p_factory_ask_id) LOOP
          v_t_per_rec.person_config_id  := scmdata.f_get_uuid();
          v_t_per_rec.company_id        := p_company_id;
          v_t_per_rec.person_role_id    := p_t_per_rec.person_role_id;
          v_t_per_rec.department_id     := p_t_per_rec.department_id;
          v_t_per_rec.person_job_id     := p_t_per_rec.person_job_id;
          v_t_per_rec.apply_category_id := p_t_per_rec.apply_category_id;
          v_t_per_rec.job_state         := p_t_per_rec.job_state;
          v_t_per_rec.person_num        := p_t_per_rec.person_num;
          v_t_per_rec.seqno             := p_t_per_rec.seqno;
          v_t_per_rec.pause             := p_t_per_rec.pause;
          v_t_per_rec.remarks           := p_t_per_rec.remarks;
          v_t_per_rec.update_id         := p_user_id;
          v_t_per_rec.update_time       := SYSDATE;
          v_t_per_rec.create_id         := p_user_id;
          v_t_per_rec.create_time       := SYSDATE;
          v_t_per_rec.factory_report_id := p_factory_report_id;
          scmdata.pkg_ask_mange.p_insert_t_person_config_fr(p_t_per_rec => v_t_per_rec);
        END LOOP;
      END IF;
    END person_config;
  
    --��������
    DECLARE
      v_t_mac_rec t_machine_equipment_fr%ROWTYPE;
    BEGIN
      SELECT COUNT(1)
        INTO v_flag
        FROM scmdata.t_machine_equipment_fr t
       WHERE t.factory_report_id = p_factory_report_id
         AND t.company_id = p_company_id;
      select max(t.factory_ask_id)
        into p_factory_ask_id
        from scmdata.T_FACTORY_REPORT t
       where t.factory_report_id = p_factory_report_id
         AND t.company_id = p_company_id;
      IF v_flag > 0 THEN
        NULL;
      ELSE
        FOR p_t_mac_rec IN (SELECT *
                              FROM scmdata.t_machine_equipment_fa t
                             WHERE t.company_id = p_company_id
                               and t.factory_ask_id = p_factory_ask_id) LOOP
          v_t_mac_rec.machine_equipment_id  := scmdata.f_get_uuid();
          v_t_mac_rec.company_id            := p_company_id;
          v_t_mac_rec.equipment_category_id := p_t_mac_rec.equipment_category_id;
          v_t_mac_rec.equipment_name        := p_t_mac_rec.equipment_name;
          v_t_mac_rec.machine_num           := p_t_mac_rec.machine_num;
          v_t_mac_rec.seqno                 := p_t_mac_rec.seqno;
          v_t_mac_rec.orgin                 := p_t_mac_rec.orgin;
          v_t_mac_rec.pause                 := p_t_mac_rec.pause;
          v_t_mac_rec.remarks               := p_t_mac_rec.remarks;
          v_t_mac_rec.update_id             := p_user_id;
          v_t_mac_rec.update_time           := SYSDATE;
          v_t_mac_rec.create_id             := p_user_id;
          v_t_mac_rec.create_time           := SYSDATE;
          v_t_mac_rec.factory_report_id     := p_factory_report_id;
        
          scmdata.pkg_ask_mange.p_insert_t_machine_equipment_fr(p_t_mac_rec => v_t_mac_rec);
        END LOOP;
      END IF;
    END machine_config;
  
    v_cnt := 0;
  
    --Ʒ����ϵ����
    DECLARE
      v_t_qua_rec t_quality_control_fr%ROWTYPE;
    BEGIN
      SELECT COUNT(1)
        INTO v_flag
        FROM scmdata.t_quality_control_fr t
       WHERE t.factory_report_id = p_factory_report_id
         AND t.company_id = p_company_id;
      IF v_flag > 0 THEN
        NULL;
      ELSE
        FOR p_t_mac_rec IN (select *
                              from scmdata.t_quality_control t
                             where t.company_id = p_company_id
                             order by t.seqno) LOOP
          v_cnt                               := v_cnt + 1;
          v_t_qua_rec.quality_control_id      := scmdata.f_get_uuid();
          v_t_qua_rec.company_id              := p_company_id;
          v_t_qua_rec.department_id           := p_t_mac_rec.department_id;
          v_t_qua_rec.quality_control_link_id := p_t_mac_rec.quality_control_link_id;
          v_t_qua_rec.seqno                   := v_cnt;
          v_t_qua_rec.pause                   := 0;
          v_t_qua_rec.remarks                 := NULL;
          v_t_qua_rec.update_id               := p_user_id;
          v_t_qua_rec.update_time             := SYSDATE;
          v_t_qua_rec.create_id               := p_user_id;
          v_t_qua_rec.create_time             := SYSDATE;
          v_t_qua_rec.factory_report_id       := p_factory_report_id;
        
          scmdata.pkg_ask_mange.p_insert_t_quality_control_fr(p_t_qua_rec => v_t_qua_rec);
        END LOOP;
      END IF;
    END quality_control;
  
  END p_generate_person_machine_config;

  /*��Ա���á�������*/
  PROCEDURE p_insert_t_person_config_fr(p_t_per_rec t_person_config_fr%ROWTYPE) IS
  BEGIN
    INSERT INTO scmdata.t_person_config_fr
      (person_config_id,
       company_id,
       person_role_id,
       department_id,
       person_job_id,
       apply_category_id,
       job_state,
       person_num,
       seqno,
       pause,
       remarks,
       update_id,
       update_time,
       create_id,
       create_time,
       factory_report_id)
    VALUES
      (p_t_per_rec.person_config_id,
       p_t_per_rec.company_id,
       p_t_per_rec.person_role_id,
       p_t_per_rec.department_id,
       p_t_per_rec.person_job_id,
       p_t_per_rec.apply_category_id,
       p_t_per_rec.job_state,
       p_t_per_rec.person_num,
       p_t_per_rec.seqno,
       p_t_per_rec.pause,
       p_t_per_rec.remarks,
       p_t_per_rec.update_id,
       p_t_per_rec.update_time,
       p_t_per_rec.create_id,
       p_t_per_rec.create_time,
       p_t_per_rec.factory_report_id);
  END p_insert_t_person_config_fr;

  /*��Ա���á�����ѯ*/
  FUNCTION f_query_t_person_config_fr(p_factory_report_id VARCHAR2)
    RETURN CLOB IS
    v_sql CLOB;
  BEGIN
    v_sql := 'SELECT t.person_config_id,t.factory_report_id factory_report_id_fr,
       t.company_id,
       t.person_role_id ar_person_role_n,
       t.department_id  ar_department_n,
       t.person_job_id  ar_person_job_n,
       t.apply_category_id ar_apply_cate_n,
       t.person_num        ar_person_num_n,
       t.remarks           ar_remarks_n,
       t.job_state         ar_job_state_n
  FROM scmdata.t_person_config_fr t
 WHERE t.factory_report_id  = ''' || p_factory_report_id || '''
   AND t.company_id = %default_company_id% 
 order by t.seqno';
    RETURN v_sql;
  END f_query_t_person_config_fr;

  /*��Ա���á����༭*/
  PROCEDURE p_update_t_person_config_fr(p_t_per_rec t_person_config_fr%ROWTYPE) IS
  BEGIN
    UPDATE t_person_config_fr t
       SET t.person_num  = nvl(p_t_per_rec.person_num, 0),
           t.remarks     = p_t_per_rec.remarks,
           t.update_id   = p_t_per_rec.update_id,
           t.update_time = p_t_per_rec.update_time
     WHERE t.person_config_id = p_t_per_rec.person_config_id;
  END p_update_t_person_config_fr;
  /*��Ա���á���ɾ��*/
  PROCEDURE p_delete_t_person_config_fr(p_t_per_rec t_person_config_fr%ROWTYPE) IS
  BEGIN
    DELETE FROM t_person_config_fr t
     WHERE t.person_config_id = p_t_per_rec.person_config_id;
  END p_delete_t_person_config_fr;

  --��Ա���ñ���
  --ͬ�������������鳧����������Ϣ�ġ���������������λ������������������_Ь�ࡰ��������������������ϲɹ�������
  PROCEDURE p_generate_ask_record_product_info(p_company_id        VARCHAR2,
                                               p_factory_report_id VARCHAR2) IS
    v_person_num_total INT;
    v_person_num_cw    INT;
    v_person_num_form  INT;
    v_person_num_db    INT;
    v_person_num_cg    INT;
  BEGIN
    SELECT SUM(t.person_num) person_num_total,
           SUM(CASE
                 WHEN t.person_job_id = 'ROLE_01_01_01' THEN
                  t.person_num
                 ELSE
                  0
               END) person_num_cw,
           SUM(CASE
                 WHEN t.person_job_id = 'ROLE_01_01_08' THEN
                  t.person_num
                 ELSE
                  0
               END) person_num_form,
           SUM(CASE
                 WHEN t.person_job_id = 'ROLE_00_01_00' THEN
                  t.person_num
                 ELSE
                  0
               END) person_num_db,
           SUM(CASE
                 WHEN t.person_job_id = 'ROLE_03_01_00' THEN
                  t.person_num
                 ELSE
                  0
               END) person_num_cg
      INTO v_person_num_total,
           v_person_num_cw,
           v_person_num_form,
           v_person_num_db,
           v_person_num_cg
      FROM scmdata.t_person_config_fr t
     WHERE t.factory_report_id = p_factory_report_id
       AND t.company_id = p_company_id;
  
    UPDATE scmdata.t_factory_report t
       SET t.total_number        = v_person_num_total,
           t.worker_num          = v_person_num_cw,
           t.molding_number      = v_person_num_form,
           t.pattern_cap = (CASE
                             WHEN v_person_num_db > 0 THEN
                              '00'
                             ELSE
                              '01'
                           END),
           t.fabric_purchase_cap = (CASE
                                     WHEN v_person_num_cg > 0 THEN
                                      '00'
                                     ELSE
                                      '01'
                                   END)
     WHERE t.factory_report_id = p_factory_report_id
       AND t.company_id = p_company_id;
  END p_generate_ask_record_product_info;

  /*�����豸��������*/
  PROCEDURE p_insert_t_machine_equipment_fr(p_t_mac_rec t_machine_equipment_fr%ROWTYPE) IS
  BEGIN
    INSERT INTO scmdata.t_machine_equipment_fr
      (machine_equipment_id,
       company_id,
       equipment_category_id,
       equipment_name,
       machine_num,
       seqno,
       orgin,
       pause,
       remarks,
       update_id,
       update_time,
       create_id,
       create_time,
       factory_report_id)
    VALUES
      (p_t_mac_rec.machine_equipment_id,
       p_t_mac_rec.company_id,
       p_t_mac_rec.equipment_category_id,
       p_t_mac_rec.equipment_name,
       p_t_mac_rec.machine_num,
       p_t_mac_rec.seqno,
       p_t_mac_rec.orgin,
       p_t_mac_rec.pause,
       p_t_mac_rec.remarks,
       p_t_mac_rec.update_id,
       p_t_mac_rec.update_time,
       p_t_mac_rec.create_id,
       p_t_mac_rec.create_time,
       p_t_mac_rec.factory_report_id);
  END p_insert_t_machine_equipment_fr;

  /*�����豸������ѯ*/
  FUNCTION f_query_t_machine_equipment_fr(p_factory_report_id VARCHAR2)
    RETURN CLOB IS
    v_sql CLOB;
  BEGIN
    v_sql := 'SELECT t.machine_equipment_id,t.factory_report_id factory_report_id_fr,
           t.company_id,
           t.equipment_category_id ar_equipment_cate_n,
           t.equipment_name ar_equipment_name_y,
           t.machine_num ar_machine_num_n,
           t.remarks,
           t.orgin   orgin_val,
           decode(t.orgin,''AA'',''ϵͳ����'',''MA'',''�ֶ�����'') orgin
      FROM t_machine_equipment_fr t
    WHERE t.factory_report_id = ''' || p_factory_report_id || '''
   AND t.company_id = %default_company_id% 
 order by t.seqno';
    RETURN v_sql;
  END f_query_t_machine_equipment_fr;

  /*�����豸�����༭*/
  PROCEDURE p_update_t_machine_equipment_fr(p_t_mac_rec t_machine_equipment_fr%ROWTYPE) IS
  BEGIN
    UPDATE scmdata.t_machine_equipment_fr t
       SET t.equipment_category_id = p_t_mac_rec.equipment_category_id,
           t.equipment_name        = p_t_mac_rec.equipment_name,
           t.machine_num = p_t_mac_rec.machine_num,
           t.remarks     = p_t_mac_rec.remarks,
           t.update_id   = p_t_mac_rec.update_id,
           t.update_time = p_t_mac_rec.update_time
     WHERE t.machine_equipment_id = p_t_mac_rec.machine_equipment_id;
  END p_update_t_machine_equipment_fr;

  /*�����豸����ɾ��*/
  PROCEDURE p_delete_t_machine_equipment_fr(p_t_mac_rec t_machine_equipment_fr%ROWTYPE) IS
  BEGIN
    DELETE FROM t_machine_equipment_fr t
     WHERE t.machine_equipment_id = p_t_mac_rec.machine_equipment_id;
  END p_delete_t_machine_equipment_fr;

  /*Ʒ����ϵ��������*/
  PROCEDURE p_insert_t_quality_control_fr(p_t_qua_rec t_quality_control_fr%ROWTYPE) IS
  BEGIN
    INSERT INTO scmdata.t_quality_control_fr
      (quality_control_id,
       company_id,
       department_id,
       quality_control_link_id,
       seqno,
       pause,
       remarks,
       update_id,
       update_time,
       create_id,
       create_time,
       factory_report_id)
    VALUES
      (p_t_qua_rec.quality_control_id,
       p_t_qua_rec.company_id,
       p_t_qua_rec.department_id,
       p_t_qua_rec.quality_control_link_id,
       p_t_qua_rec.seqno,
       p_t_qua_rec.pause,
       p_t_qua_rec.remarks,
       p_t_qua_rec.update_id,
       p_t_qua_rec.update_time,
       p_t_qua_rec.create_id,
       p_t_qua_rec.create_time,
       p_t_qua_rec.factory_report_id);
  END p_insert_t_quality_control_fr;

  /*Ʒ����ϵ������ѯ*/
  FUNCTION f_query_t_quality_control_fr(p_factory_report_id VARCHAR2)
    RETURN CLOB IS
    v_sql CLOB;
  BEGIN
    v_sql := 'SELECT t.quality_control_id,t.factory_report_id factory_report_id_fr,
       t.company_id,
       t.department_id           fr_department_n,
       tc.company_dict_name      fr_department_desc_n,
       t.quality_control_link_id fr_quality_control_link_n,
       tb.company_dict_name      fr_quality_control_link_desc_n,
       t.is_quality_control      fr_is_quality_control_y,
       t.remarks
  FROM scmdata.t_quality_control_fr t
 inner join scmdata.sys_company_dict tc
    on tc.company_id = t.company_id
   and tc.company_dict_type = ''QUALITY_CONTROL_DEPT''
   and tc.company_dict_value = t.department_id
 inner join scmdata.sys_company_dict tb
    on tb.company_id = t.company_id
   and tb.company_dict_type = t.department_id
   and tb.company_dict_value = t.quality_control_link_id
 where t.factory_report_id = ''' || p_factory_report_id || '''
   AND t.company_id = %default_company_id% 
 order by t.seqno';
    RETURN v_sql;
  END f_query_t_quality_control_fr;

  /*Ʒ����ϵ�����༭*/
  PROCEDURE p_update_t_quality_control_fr(p_t_qua_rec t_quality_control_fr%ROWTYPE) IS
  BEGIN
  
    UPDATE scmdata.t_quality_control_fr t
       SET t.is_quality_control = p_t_qua_rec.is_quality_control,
           t.remarks            = p_t_qua_rec.remarks,
           t.update_id          = p_t_qua_rec.update_id,
           t.update_time        = p_t_qua_rec.update_time
     WHERE t.quality_control_id = p_t_qua_rec.quality_control_id;
  
  END p_update_t_quality_control_fr;

  /*Ʒ����ϵ����ɾ��*/
  PROCEDURE p_delete_t_quality_control_fr(p_t_qua_rec t_quality_control_fr%ROWTYPE) IS
  BEGIN
    DELETE FROM scmdata.t_quality_control_fr t
     WHERE t.quality_control_id = p_t_qua_rec.quality_control_id;
  END p_delete_t_quality_control_fr;

  --����鳧����=��Ʒ����ϵ����ά���鿴  �ֳ���Ʒ���������  item_id: a_check_101_1_8
  FUNCTION f_query_a_check_101_1_8(p_factory_report_id VARCHAR2) RETURN CLOB IS
    v_sql CLOB;
  BEGIN
    v_sql := 'select tf.factory_report_id p_id,
       tf.company_id,
       tf.spot_check_brand            FR_SPOT_CHECK_BRAND_N,
       tf.spot_check_type             FR_SPOT_CHECK_TYPE_N,
       tf.spot_check_result           FR_SPOT_CHECK_RESULT_Y,
       tf.disqualification_cause      FR_DISQUALIFICATION_CAUSE_N,
       tf.spot_check_result_accessory fr_check_result_accessory_n
  from scmdata.t_factory_report tf
 where tf.factory_report_id = ''' || p_factory_report_id || '''';
    RETURN v_sql;
  END f_query_a_check_101_1_8;

  --����鳧����=��Ʒ����ϵ����ά���༭  �ֳ���Ʒ���������  item_id: a_check_101_1_8
  FUNCTION f_update_a_check_101_1_8(p_factory_report_id varchar2) RETURN CLOB IS
    v_sql CLOB;
  BEGIN
    v_sql := q'[begin
    if :fr_spot_check_result_y = '01' then
       if :fr_disqualification_cause_n is null then
       raise_application_error(-20002, '�����������=�����ϸ�ʱ�������ϸ�ԭ�򡱱��');
       end if;
    end if;
    UPDATE scmdata.t_factory_report t
       SET t.spot_check_brand            = :fr_spot_check_brand_n,
           t.spot_check_type             = :fr_spot_check_type_n,
           t.spot_check_result           = :fr_spot_check_result_y,
           t.disqualification_cause      = :fr_disqualification_cause_n,
           t.spot_check_result_accessory = :fr_check_result_accessory_n,
           t.update_id                   = :user_id,
           t.update_date                 = sysdate
     WHERE t.factory_report_id = ']' || p_factory_report_id || ''';
end;';
    RETURN v_sql;
  END f_update_a_check_101_1_8;

  --�鿴�鳧����  ������Ϣ item_id: a_check_103_1
  FUNCTION f_query_check_factory_report(p_factory_report_id varchar2)
    RETURN CLOB IS
    v_query_sql CLOB;
  BEGIN
    v_query_sql := Q'[ WITH company_user AS
 (SELECT company_id, company_user_name, phone, user_id
    FROM scmdata.sys_company_user)
SELECT tfa.factory_ask_id,
       tfa.rela_supplier_id,
       fr.factory_report_id  v_factory_report_id,
       ---�鳧����
       tfa.company_name ar_company_name_n,
       tfa.factory_name ar_factory_name,
       ---�鳧��Ա
       nvl(fr.check_person1, %current_userid%) check_person1, --�鳧��Ա1id
       su1.company_user_name check_person1_desc, --�鳧��Ա1
       /*nvl(fr.check_person1_phone,
           (SELECT phone
              FROM company_user
             WHERE company_id = %default_company_id%
               AND user_id = %current_userid%)) check_person1_phone, --�鳧��Ա1�绰*/
       fr.check_person2, --�鳧��Ա2id
       su2.company_user_name check_person2_desc, --�鳧��Ա2
      /* fr.check_person2_phone, --�鳧��Ա2�绰*/
       fr.check_date, --�鳧����
       --�鳧����
       fr.check_result ask_check_result_y,
       sg1.group_dict_name ask_check_result_desc_y,
       fr.check_say
  FROM scmdata.t_factory_ask tfa
 INNER JOIN scmdata.t_factory_report fr
    ON tfa.company_id = fr.company_id
   AND tfa.factory_ask_id = fr.factory_ask_id
  LEFT JOIN company_user su1
    ON su1.company_id = %default_company_id%
   AND su1.user_id = nvl(fr.check_person1, %current_userid%)
  LEFT JOIN company_user su2
    ON su2.company_id = %default_company_id%
   AND su2.user_id = nvl(fr.check_person2, %current_userid%)
  LEFT JOIN scmdata.sys_group_dict sg1
    ON sg1.group_dict_type = 'CHECK_RESULT'
   AND sg1.group_dict_value = fr.check_result
 WHERE fr.factory_report_id  =  ']' ||
                   p_factory_report_id || '''';
    RETURN v_query_sql;
  END f_query_check_factory_report;

  --�鿴�鳧���� ����
  FUNCTION f_query_check_factory_report_file(p_factory_report_id varchar2)
    RETURN CLOB IS
    v_query_sql CLOB;
  BEGIN
    v_query_sql := Q'[ SELECT  fr.certificate_file  ar_certificate_file_y,
       fr.check_report_file ask_report_files,
       fr.supplier_gate     ar_supplier_gate_n,
       fr.supplier_office   ar_supplier_office_n,
       fr.supplier_site     ar_supplier_site_n,
       fr.supplier_product  ar_supplier_product_n,
       fr.ask_files         ASK_OTHER_FILES
  FROM scmdata.t_factory_report fr
 WHERE fr.FACTORY_REPORT_ID = ']' || p_factory_report_id || '''';
    RETURN v_query_sql;
  END f_query_check_factory_report_file;

  PROCEDURE p_create_t_factory_report(p_factory_ask_id varchar2,
                                      p_company_id     varchar2,
                                      p_current_userid varchar2) is
    judge               number(1);
    as_id               varchar2(32);
    fa_type             number(1);
    fac_province        varchar2(48);
    fac_city            varchar2(48);
    fac_county          varchar2(48);
    a_address           varchar2(256);
    coo_model           varchar2(48);
    coo_type            varchar2(48);
    com_name            varchar2(300);
    com_address         varchar2(256);
    fac_name            varchar2(300);
    fr_id               varchar2(50);
    rep_row             scmdata.t_factory_report%rowtype;
    memo                varchar2(4000);
    product_type        varchar2(300);
    product_line        varchar2(300);
    product_line_num    number;
    form_num            number;
    quality_step        varchar2(48); --�����ȼ� 
    fabric_check_cap    varchar2(48); --���ϼ������  
    factroy_area        number(14, 2);
    machine_num         number(8);
    product_efficiency  number(10, 2);
    worker_total_num    number(8);
    brand_type          varchar2(300);
    cooperation_brand   varchar2(300);
    v_factory_report_id VARCHAR2(50);
    v_report_id         VARCHAR2(256);
    v_certificate_file  VARCHAR2(256);
    v_supplier_gate     VARCHAR2(256);
    v_supplier_office   VARCHAR2(256);
    v_supplier_site     VARCHAR2(256);
    v_supplier_product  VARCHAR2(256);
    v_ask_files         VARCHAR2(256);
    work_hours_day      number(10, 1);
    pattern_cap         varchar2(48);
    fabric_purchase_cap varchar2(48);
    worker_num          varchar2(32);
  begin
    select count(factory_report_id)
      into judge
      from scmdata.t_factory_report
     where factory_ask_id = p_factory_ask_id;
  
    if judge = 0 then
      select scmdata.pkg_plat_comm.f_getkeyid_plat('CR', 'seq_cr', 99)
        into fr_id
        from dual;
    
      select max(ask_company_id),
             max(factory_ask_type),
             max(ask_address),
             max(cooperation_model),
             max(cooperation_type),
             max(company_name),
             max(company_address),
             max(memo),
             max(product_efficiency),
             max(work_hours_day),
             max(pattern_cap),
             max(fabric_purchase_cap),
             max(worker_num),
             max(product_type), --��������  
             max(product_line), --���������� 
             max(product_line_num), --����������(��) 
             max(form_num), --��������_Ь�� 
             max(quality_step), --�����ȼ� 
             max(fabric_check_cap), --���ϼ������  
             max(factroy_area), --���������m2�� 
             max(machine_num), --֯��̨��_ë֯�� 
             max(worker_total_num), --������ 
             max(brand_type), --����Ʒ��/�ͻ� ����  
             max(cooperation_brand) --����Ʒ��/�ͻ� 
        into as_id,
             fa_type,
             A_ADDRESS,
             COO_MODEL,
             COO_TYPE,
             COM_NAME,
             COM_ADDRESS,
             MEMO,
             product_efficiency,
             work_hours_day,
             pattern_cap,
             fabric_purchase_cap,
             worker_num,
             product_type,
             product_line,
             product_line_num,
             form_num,
             quality_step, --�����ȼ� 
             fabric_check_cap, --���ϼ������  
             factroy_area,
             machine_num,
             worker_total_num,
             brand_type,
             cooperation_brand
        from scmdata.t_factory_ask
       where factory_ask_id = p_factory_ask_id;
    
      insert into scmdata.t_factory_report
        (factory_report_id,
         factory_ask_id,
         company_name,
         company_code,
         check_user_id,
         check_method,
         check_province,
         check_city,
         check_county,
         check_address,
         check_report_file,
         check_say,
         check_result,
         check_date,
         cooperation_type,
         cooperation_model,
         create_id,
         create_date,
         product_efficiency,
         company_id,
         company_address,
         factory_name,
         review_id,
         review_date,
         remarks,
         factory_area,
         machine_num,
         product_line,
         product_line_num,
         molding_number,
         quality_step,
         fabric_check_cap,
         total_number,
         brand_type,
         cooperation_brand,
         pattern_cap,
         fabric_purchase_cap,
         work_hours_day,
         worker_num)
      values
        (fr_id,
         p_factory_ask_id,
         com_name,
         as_id,
         p_current_userid,
         fa_type,
         fac_province,
         fac_city,
         fac_county,
         a_address,
         ' ',
         ' ',
         ' ',
         sysdate,
         'PRODUCT_TYPE',
         coo_model,
         p_current_userid,
         sysdate,
         product_efficiency,
         p_company_id,
         com_address,
         fac_name,
         p_current_userid,
         sysdate,
         memo,
         factroy_area,
         machine_num,
         product_line,
         product_line_num,
         form_num,
         quality_step,
         fabric_check_cap,
         worker_total_num,
         brand_type,
         cooperation_brand,
         pattern_cap,
         fabric_purchase_cap,
         work_hours_day,
         worker_num);
    
      --���¸�������ҳ��
      select max(fr.factory_report_id),
             max(tfa.certificate_file),
             max(tfa.supplier_gate),
             max(tfa.supplier_office),
             max(tfa.supplier_site),
             max(tfa.supplier_product),
             max(tfa.ask_files)
        into v_report_id,
             v_certificate_file,
             v_supplier_gate,
             v_supplier_office,
             v_supplier_site,
             v_supplier_product,
             v_ask_files
        from scmdata.t_factory_ask tfa
       inner join scmdata.t_factory_report fr
          on tfa.company_id = fr.company_id
         and tfa.factory_ask_id = fr.factory_ask_id
         and tfa.factory_ask_id = p_factory_ask_id;
      update scmdata.t_factory_report t
         set t.certificate_file = v_certificate_file,
             t.supplier_gate    = v_supplier_gate,
             t.supplier_office  = v_supplier_office,
             t.supplier_site    = v_supplier_site,
             t.supplier_product = v_supplier_product,
             t.ask_files        = v_ask_files
       where t.factory_report_id = v_report_id;
    
      for rep_row in (select *
                        from scmdata.t_ask_scope
                       where object_id = p_factory_ask_id
                         and be_company_id = p_company_id) loop
        insert into scmdata.t_factory_report_ability
          (factory_report_ability_id,
           company_id,
           factory_report_id,
           cooperation_type,
           cooperation_classification,
           cooperation_product_cate,
           cooperation_subcategory,
           ability_result)
        values
          (scmdata.f_get_uuid(),
           p_company_id,
           fr_id,
           rep_row.cooperation_type,
           rep_row.cooperation_classification,
           rep_row.cooperation_product_cate,
           rep_row.cooperation_subcategory,
           ' ');
      end loop;
    
      update scmdata.t_factory_ask
         set factrory_ask_flow_status = 'FA11'
       where factory_ask_id = p_factory_ask_id;
    
      pkg_ask_mange.p_generate_person_machine_config(p_company_id        => p_company_id,
                                                     p_user_id           => p_current_userid,
                                                     p_factory_report_id => fr_id);
    
    else
    
      select max(factory_report_id)
        into v_factory_report_id
        from scmdata.t_factory_report
       where factory_ask_id = p_factory_ask_id;
      pkg_ask_mange.p_generate_person_machine_config(p_company_id        => p_company_id,
                                                     p_user_id           => p_current_userid,
                                                     p_factory_report_id => v_factory_report_id);
    
      scmdata.pkg_factory_inspection.p_check_cps(v_faid   => p_factory_ask_id,
                                                 v_compid => p_company_id);
    end if;
  end p_create_t_factory_report;

end pkg_ask_mange;
/
