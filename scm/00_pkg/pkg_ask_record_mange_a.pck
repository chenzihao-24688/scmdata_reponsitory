CREATE OR REPLACE PACKAGE pkg_ask_record_mange_a IS

  -- Author  : SANFU
  -- Created : 2022/12/21 16:46:21
  -- Purpose : �����������

  --��������
  --��Ա����������
  --��ѯT_PERSON_CONFIG_FA
  FUNCTION f_query_t_person_config_fa(p_factory_ask_id VARCHAR2) RETURN CLOB;
  --����T_PERSON_CONFIG_FA
  PROCEDURE p_insert_t_person_config_fa(p_t_per_rec t_person_config_fa%ROWTYPE);
  --�޸�T_PERSON_CONFIG_FA
  PROCEDURE p_update_t_person_config_fa(p_t_per_rec t_person_config_fa%ROWTYPE);
  --ɾ��T_PERSON_CONFIG_FA
  PROCEDURE p_delete_t_person_config_fa(p_t_per_rec t_person_config_fa%ROWTYPE);

  --��ѯT_MACHINE_EQUIPMENT_FA
  FUNCTION f_query_t_machine_equipment_fa(p_factory_ask_id VARCHAR2)
    RETURN CLOB;
  --����T_MACHINE_EQUIPMENT_FA
  PROCEDURE p_insert_t_machine_equipment_fa(p_t_mac_rec t_machine_equipment_fa%ROWTYPE);
  --�޸�T_MACHINE_EQUIPMENT_FA
  PROCEDURE p_update_t_machine_equipment_fa(p_t_mac_rec t_machine_equipment_fa%ROWTYPE);
  --���� �޸�У��
  PROCEDURE p_check_t_machine_equipment_fa(p_t_mac_rec t_machine_equipment_fa%ROWTYPE);
  --ɾ��У��
  PROCEDURE p_check_t_machine_equipment_fa_by_delete(p_orgin VARCHAR2);
  --ɾ��T_MACHINE_EQUIPMENT_FA
  PROCEDURE p_delete_t_machine_equipment_fa(p_t_mac_rec t_machine_equipment_fa%ROWTYPE);

  --�����鳧ʱ��ͬ��������Ա����������
  PROCEDURE p_generate_person_machine_config(p_company_id     VARCHAR2,
                                             p_user_id        VARCHAR2,
                                             p_factory_ask_id VARCHAR2,
                                             p_ask_record_id  VARCHAR2);
  --��Ա���ñ���
  --ͬ������������������Ϣ�ġ���������������λ������������������_Ь�ࡰ��������������������ϲɹ�������
  PROCEDURE p_generate_ask_record_product_info(p_company_id     VARCHAR2,
                                               p_factory_ask_id VARCHAR2);
  --�鳧���� ���У��
  --���������Χ �ύУ��
  PROCEDURE p_check_t_ask_scope(p_factory_ask_id VARCHAR2 DEFAULT NULL,
                                p_company_id     VARCHAR2,
                                p_ask_record_id  VARCHAR2 DEFAULT NULL,
                                p_check_type     INT DEFAULT 0);
  --У��������� �������Ƿ����е���
  PROCEDURE p_check_is_has_factory_ask(p_ask_record_id VARCHAR2,
                                       p_company_id    VARCHAR2);

END pkg_ask_record_mange_a;
/
CREATE OR REPLACE PACKAGE BODY pkg_ask_record_mange_a IS

  --�鳧����
  --��Ա����������
  /*============================================*
  * Author   : CZH
  * Created  : 08-11��-22
  * ALERTER  :
  * ALERTER_TIME  :
  * Purpose  : ��ѯT_PERSON_CONFIG_FA
  * Obj_Name    : F_QUERY_T_PERSON_CONFIG_FA
  *============================================*/
  FUNCTION f_query_t_person_config_fa(p_factory_ask_id VARCHAR2) RETURN CLOB IS
    v_sql CLOB;
  BEGIN
    v_sql := 'SELECT t.person_config_id,
       t.company_id,
       t.person_role_id ar_person_role_n,
       t.department_id  ar_department_n,
       t.person_job_id  ar_person_job_n,
       t.apply_category_id ar_apply_cate_n,
       t.job_state         ar_job_state_n,
       t.person_num        ar_person_num_n,
       t.remarks           ar_remarks_n
  FROM t_person_config_fa t
 WHERE t.factory_ask_id = ''' || p_factory_ask_id || '''
   AND t.company_id = %default_company_id%';
    RETURN v_sql;
  END f_query_t_person_config_fa;

  /*============================================*
  * Author   : CZH
  * Created  : 08-11��-22
  * ALERTER  :
  * ALERTER_TIME  :
  * Purpose  : ����T_PERSON_CONFIG_FA
  * Obj_Name    : P_INSERT_T_PERSON_CONFIG_FA
  *============================================*/
  PROCEDURE p_insert_t_person_config_fa(p_t_per_rec t_person_config_fa%ROWTYPE) IS
  BEGIN
    INSERT INTO t_person_config_fa
      (person_config_id, company_id, person_role_id, department_id,
       person_job_id, apply_category_id, job_state, person_num, seqno, pause,
       remarks, update_id, update_time, create_id, create_time,
       factory_ask_id)
    VALUES
      (p_t_per_rec.person_config_id, p_t_per_rec.company_id,
       p_t_per_rec.person_role_id, p_t_per_rec.department_id,
       p_t_per_rec.person_job_id, p_t_per_rec.apply_category_id,
       p_t_per_rec.job_state, p_t_per_rec.person_num, p_t_per_rec.seqno,
       p_t_per_rec.pause, p_t_per_rec.remarks, p_t_per_rec.update_id,
       p_t_per_rec.update_time, p_t_per_rec.create_id,
       p_t_per_rec.create_time, p_t_per_rec.factory_ask_id);
  END p_insert_t_person_config_fa;

  /*============================================*
  * Author   : CZH
  * Created  : 08-11��-22
  * ALERTER  :
  * ALERTER_TIME  :
  * Purpose  : �޸�T_PERSON_CONFIG_FA
  * Obj_Name    : P_UPDATE_T_PERSON_CONFIG_FA
  *============================================*/
  PROCEDURE p_update_t_person_config_fa(p_t_per_rec t_person_config_fa%ROWTYPE) IS
  BEGIN
    UPDATE t_person_config_fa t
       SET t.person_num  = nvl(p_t_per_rec.person_num, 0),
           t.remarks     = p_t_per_rec.remarks,
           t.update_id   = p_t_per_rec.update_id,
           t.update_time = p_t_per_rec.update_time
     WHERE t.person_config_id = p_t_per_rec.person_config_id;
  END p_update_t_person_config_fa;

  /*============================================*
  * Author   : CZH
  * Created  : 08-11��-22
  * ALERTER  :
  * ALERTER_TIME  :
  * Purpose  : ɾ��T_PERSON_CONFIG_FA
  * Obj_Name    : P_DELETE_T_PERSON_CONFIG_FA
  *============================================*/
  PROCEDURE p_delete_t_person_config_fa(p_t_per_rec t_person_config_fa%ROWTYPE) IS
  BEGIN
    DELETE FROM t_person_config_fa t
     WHERE t.person_config_id = p_t_per_rec.person_config_id;
  END p_delete_t_person_config_fa;

  /*============================================*
  * Author   : CZH
  * Created  : 08-11��-22
  * ALERTER  :
  * ALERTER_TIME  :
  * Purpose  : ��ѯT_MACHINE_EQUIPMENT_FA
  * Obj_Name    : F_QUERY_T_MACHINE_EQUIPMENT_FA
  *============================================*/
  FUNCTION f_query_t_machine_equipment_fa(p_factory_ask_id VARCHAR2)
    RETURN CLOB IS
    v_sql CLOB;
  BEGIN
    v_sql := 'SELECT t.machine_equipment_id,
           t.company_id,
           t.equipment_category_id ar_equipment_cate_n,
           t.equipment_name ar_equipment_name_y,
           t.machine_num ar_machine_num_n,
           t.remarks,
           t.orgin   orgin_val,
           decode(t.orgin,''AA'',''ϵͳ����'',''MA'',''�ֶ�����'') orgin
      FROM t_machine_equipment_fa t
    WHERE t.factory_ask_id = ''' || p_factory_ask_id || '''
   AND t.company_id = %default_company_id% 
   ORDER BY t.seqno ASC';
    RETURN v_sql;
  END f_query_t_machine_equipment_fa;

  /*============================================*
  * Author   : CZH
  * Created  : 08-11��-22
  * ALERTER  :
  * ALERTER_TIME  :
  * Purpose  : ����T_MACHINE_EQUIPMENT_FA
  * Obj_Name    : P_INSERT_T_MACHINE_EQUIPMENT_FA
  *============================================*/
  PROCEDURE p_insert_t_machine_equipment_fa(p_t_mac_rec t_machine_equipment_fa%ROWTYPE) IS
  BEGIN
    INSERT INTO t_machine_equipment_fa
      (machine_equipment_id, company_id, equipment_category_id,
       equipment_name, machine_num, seqno, orgin, pause, remarks, update_id,
       update_time, create_id, create_time, factory_ask_id)
    VALUES
      (p_t_mac_rec.machine_equipment_id, p_t_mac_rec.company_id,
       p_t_mac_rec.equipment_category_id, p_t_mac_rec.equipment_name,
       p_t_mac_rec.machine_num, p_t_mac_rec.seqno, p_t_mac_rec.orgin,
       p_t_mac_rec.pause, p_t_mac_rec.remarks, p_t_mac_rec.update_id,
       p_t_mac_rec.update_time, p_t_mac_rec.create_id,
       p_t_mac_rec.create_time, p_t_mac_rec.factory_ask_id);
  END p_insert_t_machine_equipment_fa;

  /*============================================*
  * Author   : CZH
  * Created  : 08-11��-22
  * ALERTER  :
  * ALERTER_TIME  :
  * Purpose  : �޸�T_MACHINE_EQUIPMENT_FA
  * Obj_Name    : P_UPDATE_T_MACHINE_EQUIPMENT_FA
  *============================================*/
  PROCEDURE p_update_t_machine_equipment_fa(p_t_mac_rec t_machine_equipment_fa%ROWTYPE) IS
  BEGIN
    UPDATE t_machine_equipment_fa t
       SET t.equipment_category_id = p_t_mac_rec.equipment_category_id,
           t.equipment_name        = p_t_mac_rec.equipment_name,
           t.machine_num           = p_t_mac_rec.machine_num,
           t.remarks               = p_t_mac_rec.remarks,
           t.update_id             = p_t_mac_rec.update_id,
           t.update_time           = p_t_mac_rec.update_time
     WHERE t.machine_equipment_id = p_t_mac_rec.machine_equipment_id;
  END p_update_t_machine_equipment_fa;

  --���� �޸�У��
  PROCEDURE p_check_t_machine_equipment_fa(p_t_mac_rec t_machine_equipment_fa%ROWTYPE) IS
    v_cnt INT;
  BEGIN
    SELECT COUNT(1)
      INTO v_cnt
      FROM scmdata.t_machine_equipment_fa t
     WHERE t.machine_equipment_id <> p_t_mac_rec.machine_equipment_id
       AND t.factory_ask_id = p_t_mac_rec.factory_ask_id
       AND t.equipment_name = p_t_mac_rec.equipment_name;
    IF v_cnt > 0 THEN
      raise_application_error(-20002, '���豸���ơ������ظ���');
    END IF;
  END p_check_t_machine_equipment_fa;

  --ɾ��У��
  PROCEDURE p_check_t_machine_equipment_fa_by_delete(p_orgin VARCHAR2) IS
  BEGIN
    IF p_orgin = 'AA' THEN
      raise_application_error(-20002, 'ϵͳ���õ����ݲ�����ɾ����');
    ELSE
      NULL;
    END IF;
  END p_check_t_machine_equipment_fa_by_delete;

  /*============================================*
  * Author   : CZH
  * Created  : 08-11��-22
  * ALERTER  :
  * ALERTER_TIME  :
  * Purpose  : ɾ��T_MACHINE_EQUIPMENT_FA
  * Obj_Name    : P_DELETE_T_MACHINE_EQUIPMENT_FA
  *============================================*/
  PROCEDURE p_delete_t_machine_equipment_fa(p_t_mac_rec t_machine_equipment_fa%ROWTYPE) IS
  BEGIN
    p_check_t_machine_equipment_fa_by_delete(p_orgin => p_t_mac_rec.orgin);
  
    DELETE FROM t_machine_equipment_fa t
     WHERE t.machine_equipment_id = p_t_mac_rec.machine_equipment_id;
  
  END p_delete_t_machine_equipment_fa;

  --�����鳧ʱ��ͬ����������ʱ���ɵ���Ա����������
  PROCEDURE p_generate_person_machine_config(p_company_id     VARCHAR2,
                                             p_user_id        VARCHAR2,
                                             p_factory_ask_id VARCHAR2,
                                             p_ask_record_id  VARCHAR2) IS
    v_flag INT := 0;
  BEGIN
    --��Ա����
    DECLARE
      v_t_per_rec t_person_config_fa%ROWTYPE;
    BEGIN
      SELECT COUNT(1)
        INTO v_flag
        FROM scmdata.t_person_config_fa t
       WHERE t.factory_ask_id = p_factory_ask_id
         AND t.company_id = p_company_id;
    
      IF v_flag > 0 THEN
        NULL;
      ELSE
        FOR p_t_per_rec IN (SELECT *
                              FROM scmdata.t_person_config_hz t
                             WHERE t.company_id = p_company_id
                               AND t.ask_record_id = p_ask_record_id) LOOP
          v_t_per_rec.person_config_id  := scmdata.f_get_uuid();
          v_t_per_rec.company_id        := p_company_id;
          v_t_per_rec.person_role_id    := p_t_per_rec.person_role_id;
          v_t_per_rec.department_id     := p_t_per_rec.department_id;
          v_t_per_rec.person_job_id     := p_t_per_rec.person_job_id;
          v_t_per_rec.apply_category_id := p_t_per_rec.apply_category_id;
          v_t_per_rec.job_state         := p_t_per_rec.job_state;
          v_t_per_rec.person_num        := p_t_per_rec.person_num;
          v_t_per_rec.seqno             := p_t_per_rec.seqno;
          v_t_per_rec.pause             := 0;
          v_t_per_rec.remarks           := p_t_per_rec.remarks;
          v_t_per_rec.update_id         := p_user_id;
          v_t_per_rec.update_time       := SYSDATE;
          v_t_per_rec.create_id         := p_user_id;
          v_t_per_rec.create_time       := SYSDATE;
          v_t_per_rec.factory_ask_id    := p_factory_ask_id;
          scmdata.pkg_ask_record_mange_a.p_insert_t_person_config_fa(p_t_per_rec => v_t_per_rec);
        END LOOP;
      END IF;
    END person_config;
  
    --��������
    DECLARE
      v_t_mac_rec t_machine_equipment_fa%ROWTYPE;
    BEGIN
      SELECT COUNT(1)
        INTO v_flag
        FROM scmdata.t_machine_equipment_fa t
       WHERE t.factory_ask_id = p_factory_ask_id
         AND t.company_id = p_company_id;
    
      IF v_flag > 0 THEN
        NULL;
      ELSE
        FOR p_t_mac_rec IN (SELECT *
                              FROM scmdata.t_machine_equipment_hz t
                             WHERE t.company_id = p_company_id
                               AND t.ask_record_id = p_ask_record_id) LOOP
          v_t_mac_rec.machine_equipment_id  := scmdata.f_get_uuid();
          v_t_mac_rec.company_id            := p_company_id;
          v_t_mac_rec.equipment_category_id := p_t_mac_rec.equipment_category_id;
          v_t_mac_rec.equipment_name        := p_t_mac_rec.equipment_name;
          v_t_mac_rec.machine_num           := p_t_mac_rec.machine_num;
          v_t_mac_rec.seqno                 := p_t_mac_rec.seqno;
          v_t_mac_rec.orgin                 := p_t_mac_rec.orgin;
          v_t_mac_rec.pause                 := 0;
          v_t_mac_rec.remarks               := p_t_mac_rec.remarks;
          v_t_mac_rec.update_id             := p_user_id;
          v_t_mac_rec.update_time           := SYSDATE;
          v_t_mac_rec.create_id             := p_user_id;
          v_t_mac_rec.create_time           := SYSDATE;
          v_t_mac_rec.factory_ask_id        := p_factory_ask_id;
        
          scmdata.pkg_ask_record_mange_a.p_insert_t_machine_equipment_fa(p_t_mac_rec => v_t_mac_rec);
        END LOOP;
      END IF;
    END machine_config;
  END p_generate_person_machine_config;

  --��Ա���ñ���
  --ͬ������������������Ϣ�ġ���������������λ������������������_Ь�ࡰ��������������������ϲɹ�������
  PROCEDURE p_generate_ask_record_product_info(p_company_id     VARCHAR2,
                                               p_factory_ask_id VARCHAR2) IS
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
      FROM scmdata.t_person_config_fa t
     WHERE t.factory_ask_id = p_factory_ask_id
       AND t.company_id = p_company_id;
  
    UPDATE scmdata.t_factory_ask t
       SET t.worker_total_num    = v_person_num_total,
           t.worker_num          = v_person_num_cw,
           t.form_num            = v_person_num_form,
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
     WHERE t.factory_ask_id = p_factory_ask_id
       AND t.company_id = p_company_id;
  END p_generate_ask_record_product_info;

  --�鳧���� ���У��
  --���������Χ �ύУ��
  PROCEDURE p_check_t_ask_scope(p_factory_ask_id VARCHAR2 DEFAULT NULL,
                                p_company_id     VARCHAR2,
                                p_ask_record_id  VARCHAR2 DEFAULT NULL,
                                p_check_type     INT DEFAULT 0) IS
    v_flag          INT;
    v_coop_type_str VARCHAR2(256);
    v_coop_type     VARCHAR2(256);
  BEGIN
    SELECT COUNT(ask_scope_id),
           listagg(DISTINCT cooperation_type, ';') || ';'
      INTO v_flag, v_coop_type_str
      FROM scmdata.t_ask_scope t
     WHERE t.object_id = nvl(p_ask_record_id, p_factory_ask_id)
       AND t.company_id = p_company_id;
  
    IF v_flag > 0 THEN
      IF p_check_type = 1 THEN
        SELECT cooperation_type || ';'
          INTO v_coop_type
          FROM scmdata.t_ask_record
         WHERE ask_record_id = p_ask_record_id
           AND be_company_id = p_company_id;
      
        IF v_coop_type_str <> v_coop_type THEN
          raise_application_error(-20002,
                                  '���������������ӱ��������Ͳ��������޸ĺ����ύ��');
        ELSE
          NULL;
        END IF;
      ELSE
        NULL;
      END IF;
    ELSE
      raise_application_error(-20003, '����д���������Χ���ύ��');
    END IF;
  END p_check_t_ask_scope;

  --У��������� �������Ƿ����е���
  PROCEDURE p_check_is_has_factory_ask(p_ask_record_id VARCHAR2,
                                       p_company_id    VARCHAR2) IS
    v_flag INT;
  BEGIN
    SELECT COUNT(factrory_ask_flow_status)
      INTO v_flag
      FROM (SELECT *
              FROM (SELECT factrory_ask_flow_status
                      FROM scmdata.t_factory_ask
                     WHERE ask_record_id = p_ask_record_id
                       AND company_id = p_company_id
                     ORDER BY create_date DESC)
             WHERE rownum < 3)
     WHERE factrory_ask_flow_status NOT IN
           ('CA01', 'FA01', 'FA03', 'FA21', 'FA33')
       AND rownum < 2;
  
    IF v_flag = 0 THEN
      NULL;
    ELSE
      raise_application_error(-20004,
                              '���е����������л�ù�Ӧ����׼��ͨ���������ظ��ύ��');
    END IF;
  END p_check_is_has_factory_ask;

END pkg_ask_record_mange_a;
/