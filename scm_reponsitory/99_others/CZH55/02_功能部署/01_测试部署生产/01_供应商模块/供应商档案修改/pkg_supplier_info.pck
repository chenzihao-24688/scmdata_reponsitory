CREATE OR REPLACE PACKAGE pkg_supplier_info IS

  -- Author  : SANFU
  -- Created : 2020/11/6 14:52:03
  -- Purpose : 
  /*============================================*
  * Author   : SANFU
  * Created  : 2020-09-09 16:52:50
  * ALERTER  : 
  * ALERTER_TIME  : 
  * Purpose  : �ύʱ���� =��У��-��Ӧ�̵����������ӱ�������Χ������ֵ�� 
  * Obj_Name    : check_t_supplier_info
  * Arg_Number  : 1
  * p_supplier_info_id : ��ǰ��Ӧ�̱��
  * p_default_company_id �� Ĭ����ҵ���
  *============================================*/
  PROCEDURE check_t_supplier_info(p_supplier_info_id   VARCHAR2,
                                  p_default_company_id VARCHAR2);

  /*============================================*
  * Author   : SANFU
  * Created  : 2020-09-28 10:15:31
  * ALERTER  : 
  * ALERTER_TIME  : 
  * Purpose  : �����������£�����ʱУ�� 
  * Obj_Name    : CHECK_SAVE_T_SUPPLIER_INFO
  * Arg_Number  : 2
  * P_SP_DATA : ��Ӧ�̵�������
  * P_DEFAULT_COMPANY_ID : ƽ̨��ǰĬ����ҵ
  * p_status : ״̬��NEW,OLD��
  *============================================*/

  PROCEDURE check_save_t_supplier_info(p_sp_data            scmdata.t_supplier_info%ROWTYPE,
                                       p_default_company_id VARCHAR2,
                                       p_status             VARCHAR2);

  /*============================================*
  * Author   : SANFU
  * Created  : 2020-09-03 17:10:14
  * ALERTER  : 
  * ALERTER_TIME  : 
  * Purpose  : ���ɹ�Ӧ�̱���
  * Obj_Name    : get_supplier_code_by_rule
  * Arg_Number  : 1
  * P_SUPPLIER_INFO_ID :��Ӧ�̵������
  *============================================*/
  FUNCTION get_supplier_code_by_rule(p_supplier_info_id   VARCHAR2,
                                     p_default_company_id VARCHAR2)
    RETURN VARCHAR2;

  /*============================================*
  * Author   : SANFU
  * Created  : 2020-09-09 16:52:50
  * ALERTER  : 
  * ALERTER_TIME  : 
  * Purpose  : ����δ�����Ĺ�Ӧ�̵���
  * Obj_Name    : CREATE_T_SUPPLIER_INFO
  * Arg_Number  : 3
  * P_COMPANY_ID : ��ǰ��ҵ���
  * P_FACTORY_ASK_ID : ���뵥���
  * p_user_id:��ǰ��¼�û����
  *============================================*/

  PROCEDURE create_t_supplier_info(p_company_id     VARCHAR2,
                                   p_factory_ask_id VARCHAR2,
                                   p_user_id        VARCHAR2);

  /*============================================*
  * Author   : SANFU
  * Created  : 2020-09-03 17:10:14
  * ALERTER  : 
  * ALERTER_TIME  : 
  * Purpose  : �ύ     ���ɹ�Ӧ�̱��룬δ����=���ѽ���
  * Obj_Name    : SUBMIT_T_SUPPLIER_INFO
  * Arg_Number  : 3
  * P_SUPPLIER_INFO_ID :��Ӧ�̵������
  * p_default_company_id ��
  * p_user_id ��
  *============================================*/
  PROCEDURE submit_t_supplier_info(p_supplier_info_id   VARCHAR2,
                                   p_default_company_id VARCHAR2,
                                   p_user_id            VARCHAR2);

  --����������־�ӱ�
  PROCEDURE insert_oper_log(p_supplier_info_id VARCHAR2,
                            oper_type          VARCHAR2,
                            p_reason           VARCHAR2,
                            p_user_id          VARCHAR2,
                            p_company_id       VARCHAR2,
                            p_create_time      DATE);

  /*============================================*
  * Author   : SANFU
  * Created  : 2020-07-22 15:29:43
  * ALERTER  : 
  * ALERTER_TIME  : 
  * Purpose  :   ���¹�Ӧ�̵���״̬��0��������1��ͣ�ã�
  * Obj_Name    : update_supplier_info_status
  * Arg_Number  : 5
  * p_supplier_info_id :��Ӧ�̵������
  * p_reason ��ԭ��
  * P_STATUS :״̬
  * p_user_id ����ǰ������
  * p_company_id ����ǰ������ҵ
  *============================================*/
  PROCEDURE update_supplier_info_status(p_supplier_info_id VARCHAR2,
                                        p_reason           VARCHAR2,
                                        p_status           NUMBER,
                                        p_user_id          VARCHAR2,
                                        p_company_id       VARCHAR2);

  /*============================================*
  * Author   : SANFU
  * Created  : 2020-07-22 15:29:43
  * ALERTER  : 
  * ALERTER_TIME  : 
  * Purpose  :   ���¹�Ӧ�̵���״̬��0��������1��ͣ�ã�
  * Obj_Name    : update_supp_info_bind_status
  * Arg_Number  : 2
  * p_supplier_info_id :��Ӧ�̵������
  * P_STATUS :״̬
  *============================================*/
  PROCEDURE update_supp_info_bind_status(p_company_id       VARCHAR2,
                                         p_supplier_info_id VARCHAR2,
                                         p_user_id          VARCHAR2,
                                         p_status           NUMBER);

  /*============================================*
  * Author   : SANFU
  * Created  : 2020-07-22 15:29:43
  * ALERTER  : 
  * ALERTER_TIME  : 
  * Purpose  :   ���¹�Ӧ�̵���-������Χ״̬��0��������1��ͣ�ã�
  * Obj_Name    : update_supplier_info_status
  * Arg_Number  : 4
  * p_supplier_info_id :��Ӧ�̵������
  * P_STATUS :״̬
  * p_company_id ����ǰ������ҵ
  * p_coop_scope_id : ������Χ���
  *============================================*/
  PROCEDURE update_coop_scope_status(p_company_id       VARCHAR2,
                                     p_user_id          VARCHAR2,
                                     p_supplier_info_id VARCHAR2,
                                     p_coop_scope_id    VARCHAR2,
                                     p_status           NUMBER);
  /*============================================*
  * Author   : SANFU
  * Created  : 2020-09-28 10:15:31
  * ALERTER  : 
  * ALERTER_TIME  : 
  * Purpose  : ������Ӧ�� 
  * Obj_Name    : insert_supplier_info
  * Arg_Number  : 2
  * P_SP_DATA : ��Ӧ�̵�������
  * P_DEFAULT_COMPANY_ID : ƽ̨��ǰĬ����ҵ
  *============================================*/

  PROCEDURE insert_supplier_info(p_sp_data            scmdata.t_supplier_info%ROWTYPE,
                                 p_default_company_id VARCHAR2);
  /*============================================*
  * Author   : SANFU
  * Created  : 2020-09-28 10:15:31
  * ALERTER  : 
  * ALERTER_TIME  : 
  * Purpose  : �޸Ĺ�Ӧ�� 
  * Obj_Name    : update_supplier_info
  * Arg_Number  : 2
  * P_SP_DATA : ��Ӧ�̵�������
  * P_DEFAULT_COMPANY_ID : ƽ̨��ǰĬ����ҵ
  *============================================*/
  PROCEDURE update_supplier_info(p_sp_data            scmdata.t_supplier_info%ROWTYPE,
                                 p_default_company_id VARCHAR2);

  /*============================================*
  * Author   : SANFU
  * Created  : 2020-09-28 10:15:31
  * ALERTER  : 
  * ALERTER_TIME  : 
  * Purpose  : ɾ����Ӧ�� 
  * Obj_Name    : update_supplier_info
  * Arg_Number  : 2
  * p_supplier_info_id : ��Ӧ�̵������
  * P_DEFAULT_COMPANY_ID : ƽ̨��ǰĬ����ҵ
  *============================================*/

  PROCEDURE delete_supplier_info(p_supplier_info_id   VARCHAR2,
                                 p_default_company_id VARCHAR2);
  /*============================================*
  * Author   : SANFU
  * Created  : 2020-09-28 10:15:31
  * ALERTER  : 
  * ALERTER_TIME  : 
  * Purpose  : У���ͬ����
  * Obj_Name    : check_contract_info
  * Arg_Number  : 1
  * p_contract_rec : ��ͬ��¼
  *============================================*/
  PROCEDURE check_contract_info(p_contract_rec scmdata.t_contract_info%ROWTYPE);
  /*============================================*
  * Author   : SANFU
  * Created  : 2020-09-28 10:15:31
  * ALERTER  : 
  * ALERTER_TIME  : 
  * Purpose  : ������ͬ 
  * Obj_Name    : insert_contract_info
  * Arg_Number  : 1
  * p_contract_rec : ��ͬ��¼
  *============================================*/
  PROCEDURE insert_contract_info(p_contract_rec scmdata.t_contract_info%ROWTYPE);
  /*============================================*
  * Author   : SANFU
  * Created  : 2020-09-28 10:15:31
  * ALERTER  : 
  * ALERTER_TIME  : 
  * Purpose  : �޸ĺ�ͬ
  * Obj_Name    : update_contract_info
  * Arg_Number  : 1
  * p_contract_rec : ��ͬ��¼
  *============================================*/
  PROCEDURE update_contract_info(p_contract_rec scmdata.t_contract_info%ROWTYPE);

  /*============================================*
  * Author   : SANFU
  * Created  : 2020-10-23 17:42:18
  * ALERTER  : 
  * ALERTER_TIME  : 
  * Purpose  : У�鵼������
  * Obj_Name    : CHECK_IMPORTDATAS
  * Arg_Number  : 2
  * P_COMPANY_ID :��ҵID
  * P_USER_ID :�û�ID
  * p_supplier_temp_id :��ʱ��ID
  *============================================*/

  PROCEDURE check_importdatas(p_company_id       IN VARCHAR2,
                              p_user_id          IN VARCHAR2,
                              p_supplier_temp_id IN VARCHAR2);
  /*============================================*
  * Author   : SANFU
  * Created  : 2020-10-23 17:38:28
  * ALERTER  : 
  * ALERTER_TIME  : 
  * Purpose  :  EXCEL���� �ύ���յ� ����ʱ�����ύ��ҵ�����
  * Obj_Name    : submit_comm_craft_temp
  * Arg_Number  : 2
  * p_company_id :��ҵID
  * p_user_id ���û�ID
  *============================================*/
  PROCEDURE submit_supplier_info_temp(p_company_id IN VARCHAR2,
                                      p_user_id    IN VARCHAR2);

  /*============================================*
  * Author   : SANFU
  * Created  : 2020-10-23 17:38:28
  * ALERTER  : 
  * ALERTER_TIME  : 
  * Purpose  :  EXCEL���� ������Ӧ��������ʱ����
  * Obj_Name    : insert_supplier_info_temp
  * Arg_Number  : 1
  * P_CRAFT_REC :��ʱ����
  *============================================*/

  PROCEDURE insert_supplier_info_temp(p_supp_rec scmdata.t_supplier_info_temp%ROWTYPE);
  /*============================================*
  * Author   : SANFU
  * Created  : 2020-10-23 17:38:28
  * ALERTER  : 
  * ALERTER_TIME  : 
  * Purpose  :  EXCEL���� �޸Ĺ�Ӧ��������ʱ����
  * Obj_Name    : update_supplier_info_temp
  * Arg_Number  : 1
  * P_CRAFT_REC :��ʱ����
  *============================================*/
  PROCEDURE update_supplier_info_temp(p_supp_rec scmdata.t_supplier_info_temp%ROWTYPE);
  /*============================================*
  * Author   : SANFU
  * Created  : 2020-09-28 10:15:31
  * ALERTER  : 
  * ALERTER_TIME  : 
  * Purpose  : ɾ����ͬ
  * Obj_Name    : delete_contract_info
  * Arg_Number  : 1
  * p_contract_info_id : ��ͬid
  *============================================*/
  PROCEDURE delete_contract_info(p_contract_info_id VARCHAR2);
  /*============================================*
  * Author   : SANFU
  * Created  : 2020-10-23 17:43:35
  * ALERTER  : 
  * ALERTER_TIME  : 
  * Purpose  : ��յ�������
  * Obj_Name    : delete_supplier_info_temp
  * Arg_Number  : 2
  * P_COMPANY_ID :��ҵID
  * P_USER_ID : �û�ID
  *============================================*/
  PROCEDURE delete_supplier_info_temp(p_company_id IN VARCHAR2,
                                      p_user_id    IN VARCHAR2);
  /*============================================*
  * Author   : zwh73
  * Created  : 2020-10-23 17:42:18
  * ALERTER  : 
  * ALERTER_TIME  : 
  * Purpose  : У�鵼������
  * Obj_Name    : check_importdatas_coop_scope
  * Arg_Number  : 1
  * p_supplier_temp_id :��ʱ��ID
  *============================================*/

  PROCEDURE check_importdatas_coop_scope(p_coop_scope_temp_id IN VARCHAR2);
  /*============================================*
  * Author   : zwh73
  * Created  : 2020-10-23 17:38:28
  * ALERTER  : 
  * ALERTER_TIME  : 
  * Purpose  :  EXCEL���� �ύ��Ӧ�̺�����Χ ����ʱ�����ύ��ҵ�����
  * Obj_Name    : submit_t_coop_scope_temp
  * Arg_Number  : 2
  * p_company_id :��ҵID
  * p_user_id ���û�ID
  *============================================*/
  PROCEDURE submit_t_coop_scope_temp(p_company_id IN VARCHAR2,
                                     p_user_id    IN VARCHAR2);
  --У�������Χ  p_status�� IU ����/���� D ɾ��
  PROCEDURE check_coop_scopre(p_cp_data scmdata.t_coop_scope%ROWTYPE,
                              p_status  VARCHAR2);

  --����������Χ
  PROCEDURE insert_coop_scope(p_cp_data scmdata.t_coop_scope%ROWTYPE);
  --�޸ĺ�����Χ
  PROCEDURE update_coop_scope(p_cp_data scmdata.t_coop_scope%ROWTYPE);
  --ɾ��������Χ
  PROCEDURE delete_coop_scope(p_cp_data scmdata.t_coop_scope%ROWTYPE);
  --��ȡ��Ӧ������
  FUNCTION get_supp_batch_id(pi_company_id VARCHAR2) RETURN VARCHAR2;
END pkg_supplier_info;
/
CREATE OR REPLACE PACKAGE BODY pkg_supplier_info IS

  /*============================================*
  * Author   : SANFU
  * Created  : 2020-09-09 16:52:50
  * ALERTER  : 
  * ALERTER_TIME  : 
  * Purpose  : �ύʱ���� =��У��-��Ӧ�̵����������ӱ�������Χ������ֵ�� 
  * Obj_Name    : check_t_supplier_info
  * Arg_Number  : 1
  * p_supplier_info_id : ��ǰ��Ӧ�̱��
  * p_default_company_id �� Ĭ����ҵ���
  *============================================*/
  PROCEDURE check_t_supplier_info(p_supplier_info_id   VARCHAR2,
                                  p_default_company_id VARCHAR2) IS
    supplier_submit_exp EXCEPTION;
    --��Ӧ�̵���
    supp_info_rec scmdata.t_supplier_info%ROWTYPE;
    v_flag        NUMBER;
  
  BEGIN
    --����Դ
    --��Ӧ�̵���
    SELECT *
      INTO supp_info_rec
      FROM scmdata.t_supplier_info sp
     WHERE sp.supplier_info_id = p_supplier_info_id;
  
    --1.У�鹩Ӧ�̵�������Ƿ��Ѿ�����
  
    IF supp_info_rec.supplier_code IS NOT NULL THEN
      raise_application_error(-20002,
                              '�ù�Ӧ�̵����Ѿ����ɣ������ظ��ύ��');
    END IF;
  
    --2.�ύ =��У�������Ƿ���Ч
    check_save_t_supplier_info(p_sp_data            => supp_info_rec,
                               p_default_company_id => p_default_company_id,
                               p_status             => 'OLD');
  
    --3.У�������ΧTABҳ����Ϊ��
    SELECT COUNT(1)
      INTO v_flag
      FROM scmdata.t_coop_scope t
     WHERE t.supplier_info_id = supp_info_rec.supplier_info_id;
  
    IF v_flag = 0 AND supp_info_rec.supplier_info_origin <> 'QC' THEN
      raise_application_error(-20002,
                              '������Χ������Ϊ��,���ȵ��·���������ΧTABҳ��������д��');
    END IF;
  
  END check_t_supplier_info;

  /*============================================*
  * Author   : SANFU
  * Created  : 2020-09-28 10:15:31
  * ALERTER  : 
  * ALERTER_TIME  : 
  * Purpose  : �����������£�����ʱУ�� 
  * Obj_Name    : CHECK_SAVE_T_SUPPLIER_INFO
  * Arg_Number  : 2
  * P_SP_DATA : ��Ӧ�̵�������
  * P_DEFAULT_COMPANY_ID : ƽ̨��ǰĬ����ҵ
  * p_status : ״̬��NEW,OLD��
  *============================================*/

  PROCEDURE check_save_t_supplier_info(p_sp_data            scmdata.t_supplier_info%ROWTYPE,
                                       p_default_company_id VARCHAR2,
                                       p_status             VARCHAR2) IS
    v_scc_flag     NUMBER;
    v_supp_flag    NUMBER := 0;
    v_supp_flag_tp NUMBER := 0;
  
  BEGIN
    --1.У��������� 
    IF p_sp_data.supplier_company_name IS NULL THEN
      raise_application_error(-20002, '��˾���Ʋ���Ϊ�գ�');
    END IF;
  
    IF p_sp_data.social_credit_code IS NULL THEN
      raise_application_error(-20002, 'ͳһ������ô��벻��Ϊ�գ�');
    END IF;
  
    SELECT COUNT(1)
      INTO v_scc_flag
      FROM scmdata.t_supplier_info sp
     WHERE sp.social_credit_code = p_sp_data.social_credit_code
       AND sp.company_id = p_default_company_id
       AND sp.supplier_info_id <> p_sp_data.supplier_info_id;
  
    IF v_scc_flag > 0 THEN
      raise_application_error(-20002, 'ͳһ������ô��벻���ظ���');
    END IF;
  
    IF p_sp_data.social_credit_code IS NOT NULL THEN
      IF scmdata.pkg_check_data_comm.f_check_soial_code(p_sp_data.social_credit_code) = 1 THEN
        NULL;
      ELSE
        raise_application_error(-20002,
                                '��������ȷ��ͳһ������ô��룬�ҳ���ӦΪ18λ��');
      END IF;
    END IF;
  
    IF p_sp_data.company_contact_phone IS NOT NULL THEN
      IF scmdata.pkg_check_data_comm.f_check_phone(p_sp_data.company_contact_phone) = 1 THEN
        NULL;
      ELSE
        raise_application_error(-20002, '��������ȷ����ϵ���ֻ����룡');
      END IF;
    END IF;
  
    --׼�����̣���Ӧ�̵�������Ӧ�����ƿɱ༭��
    --���������޸ģ�����У�鹩Ӧ�������Ƿ��ظ�
  
    -- 1�� ���ƽ�����д���ļ��������ţ�
    IF p_sp_data.supplier_company_name IS NOT NULL THEN
      IF pkg_check_data_comm.f_check_varchar(pi_data => p_sp_data.supplier_company_name,
                                             pi_type => 0) <> 1 THEN
        raise_application_error(-20002,
                                '��Ӧ��������д���󣬽�����д���ļ��������ţ�');
      END IF;
    
      --2�� �����뵱ǰ��ҵ��Ӧ�̵��������������ѽ����Ĺ�Ӧ�������ظ���  
      SELECT COUNT(1)
        INTO v_supp_flag_tp
        FROM scmdata.t_supplier_info t
       WHERE t.company_id = p_default_company_id
         AND t.supplier_info_id <> p_sp_data.supplier_info_id
         AND t.supplier_company_name = p_sp_data.supplier_company_name;
    
      IF v_supp_flag_tp > 0 THEN
        raise_application_error(-20002,
                                '��Ӧ�������빩Ӧ�̵������������ظ���');
      END IF;
    
    END IF;
  
    --2.����ʱ��У����ҵ��ƽ̨�Ƿ���ڹ�Ӧ�̵���
    IF p_status = 'NEW' THEN
      IF p_sp_data.supplier_company_name IS NOT NULL THEN
        --1�� �����뵱ǰ��ҵ��׼�������еĹ�˾���ƴ����ظ���
        scmdata.pkg_compname_check.p_tfa_compname_check_for_new(comp_name => p_sp_data.supplier_company_name,
                                                                dcomp_id  => p_default_company_id);
      END IF;
      IF p_sp_data.social_credit_code IS NOT NULL THEN
        --2)У�鵱ǰ��ҵ�Ƿ��Ѵ��ڹ�Ӧ�̵���
        SELECT COUNT(1)
          INTO v_supp_flag
          FROM scmdata.t_supplier_info sp
         WHERE sp.social_credit_code = p_sp_data.social_credit_code
           AND sp.company_id = p_default_company_id;
      
        IF v_supp_flag > 0 THEN
          raise_application_error(-20002,
                                  p_sp_data.supplier_company_name ||
                                  ',����ҵ�Ѵ��ڹ�Ӧ�̵�����');
        END IF;
      END IF;
    ELSIF p_status = 'OLD' THEN
      IF p_sp_data.supplier_company_name IS NOT NULL THEN
        --3�� �����뵱ǰ��ҵ��׼�������еĹ�˾���ƴ����ظ���
        scmdata.pkg_compname_check.p_tfa_compname_check_for_dcheck(comp_name => p_sp_data.supplier_company_name,
                                                                   dcomp_id  => p_default_company_id,
                                                                   origin_id => p_sp_data.supplier_info_origin_id);
      END IF;
    END IF;
  
  END check_save_t_supplier_info;

  /*============================================*
  * Author   : SANFU
  * Created  : 2020-09-03 17:10:14
  * ALERTER  : 
  * ALERTER_TIME  : 
  * Purpose  : ���ɹ�Ӧ�̱���
  * Obj_Name    : get_supplier_code_by_rule
  * Arg_Number  : 1
  * P_SUPPLIER_INFO_ID :��Ӧ�̵������
  *============================================*/
  FUNCTION get_supplier_code_by_rule(p_supplier_info_id   VARCHAR2,
                                     p_default_company_id VARCHAR2)
    RETURN VARCHAR2 IS
    v_company_id          VARCHAR2(200);
    v_supplier_company_id VARCHAR2(200);
    v_cooperation_type    VARCHAR2(200);
    --v_origin              VARCHAR2(100);
    v_flag            NUMBER;
    c_product_type    VARCHAR2(100) := 'C';
    c_material_type   VARCHAR2(100) := 'W';
    c_technology_type VARCHAR2(100) := 'T';
    c_equip_type      VARCHAR2(100) := 'S';
    c_service_type    VARCHAR2(100) := 'F';
    v_table_name      VARCHAR2(100) := 't_supplier_info';
    v_column_name     VARCHAR2(100) := 'supplier_code';
    v_serail_num      NUMBER := 5; --��ˮ�ų���
    v_supplier_code   VARCHAR2(100); --��Ӧ�̱���
    supplier_info_exp    EXCEPTION;
    cooperation_type_exp EXCEPTION;
    x_err_msg VARCHAR2(1000);
  BEGIN
    SELECT sp.supplier_company_id, sp.cooperation_type, sp.company_id
    /*,sp.supplier_info_origin*/
      INTO v_supplier_company_id, v_cooperation_type, v_company_id /*,v_origin*/
      FROM scmdata.t_supplier_info sp
     WHERE sp.supplier_info_id = p_supplier_info_id
       AND sp.company_id = p_default_company_id;
  
    --1������1�����룬1����Ӧ�̽�������1������
    SELECT COUNT(1)
      INTO v_flag
      FROM scmdata.t_supplier_info sp
     WHERE sp.supplier_company_id = v_supplier_company_id
       AND sp.company_id = v_company_id
       AND sp.status = 1;
  
    IF v_flag > 0 THEN
      RAISE supplier_info_exp;
    ELSE
      --��Ʒ��Ӧ��C ���Ϲ�Ӧ��W ���⹤�չ�Ӧ��T �豸��Ӧ��S ������F 
      IF v_cooperation_type IS NOT NULL THEN
        IF v_cooperation_type = 'PRODUCT_TYPE' THEN
          --������ҵ������
          v_supplier_code := scmdata.pkg_plat_comm.f_getkeycode(pi_table_name  => v_table_name,
                                                                pi_column_name => v_column_name,
                                                                pi_company_id  => v_company_id,
                                                                pi_pre         => c_product_type,
                                                                pi_serail_num  => v_serail_num);
        
        ELSIF v_cooperation_type = 'MATERIAL_TYPE' THEN
          v_supplier_code := scmdata.pkg_plat_comm.f_getkeycode(pi_table_name  => v_table_name,
                                                                pi_column_name => v_column_name,
                                                                pi_company_id  => v_company_id,
                                                                pi_pre         => c_material_type,
                                                                pi_serail_num  => v_serail_num);
        
        ELSIF v_cooperation_type = 'TECHNOLOGY_TYPE' THEN
          v_supplier_code := scmdata.pkg_plat_comm.f_getkeycode(pi_table_name  => v_table_name,
                                                                pi_column_name => v_column_name,
                                                                pi_company_id  => v_company_id,
                                                                pi_pre         => c_technology_type,
                                                                pi_serail_num  => v_serail_num);
        
        ELSIF v_cooperation_type = 'EQUIP_TYPE' THEN
          v_supplier_code := scmdata.pkg_plat_comm.f_getkeycode(pi_table_name  => v_table_name,
                                                                pi_column_name => v_column_name,
                                                                pi_company_id  => v_company_id,
                                                                pi_pre         => c_equip_type,
                                                                pi_serail_num  => v_serail_num);
        
        ELSIF v_cooperation_type = 'SERVICE_TYPE' THEN
        
          v_supplier_code := scmdata.pkg_plat_comm.f_getkeycode(pi_table_name  => v_table_name,
                                                                pi_column_name => v_column_name,
                                                                pi_company_id  => v_company_id,
                                                                pi_pre         => c_service_type,
                                                                pi_serail_num  => v_serail_num);
          /*        ELSIF v_origin = 'II' THEN
          --�ӿڽ��������ݣ�Ĭ������������ҵ������ 'PRODUCT_TYPE' 
          v_supplier_code := scmdata.pkg_plat_comm.f_getkeycode(pi_table_name  => v_table_name,
                                                                pi_column_name => v_column_name,
                                                                pi_company_id  => v_company_id,
                                                                pi_pre         => c_product_type,
                                                                pi_serail_num  => v_serail_num);*/
        ELSE
          raise_application_error(-20002,
                                  '���ɹ�Ӧ�̱���ʧ�ܣ�����ϵ��ƽ̨��Ա����');
        END IF;
      
      ELSE
        RAISE cooperation_type_exp;
      END IF;
    END IF;
  
    RETURN v_supplier_code;
  
  EXCEPTION
    WHEN supplier_info_exp THEN
      x_err_msg := '�Ѵ��ڸù�Ӧ�̵����������ظ����ɹ�Ӧ�̵�������';
      sys_raise_app_error_pkg.is_running_error(p_err_msg          => x_err_msg,
                                               p_is_running_error => 'F');
    
    WHEN cooperation_type_exp THEN
      x_err_msg := '��������Ϊ�գ���';
      sys_raise_app_error_pkg.is_running_error(p_err_msg          => x_err_msg,
                                               p_is_running_error => 'F');
    WHEN OTHERS THEN
      sys_raise_app_error_pkg.is_running_error(p_err_msg          => x_err_msg,
                                               p_is_running_error => 'T');
  END get_supplier_code_by_rule;
  /*============================================*
  * Author   : SANFU
  * Created  : 2020-09-09 16:52:50
  * ALERTER  : 
  * ALERTER_TIME  : 
  * Purpose  : ����δ�����Ĺ�Ӧ�̵���
  * Obj_Name    : CREATE_T_SUPPLIER_INFO
  * Arg_Number  : 3
  * P_COMPANY_ID : ��ǰ��ҵ���
  * P_FACTORY_ASK_ID : ���뵥���
  * p_user_id:��ǰ��¼�û����
  *============================================*/

  PROCEDURE create_t_supplier_info(p_company_id     VARCHAR2,
                                   p_factory_ask_id VARCHAR2,
                                   p_user_id        VARCHAR2) IS
  
    --��Դ���� ׼����� ��������� =�� ͬ�� =��������������Ӧ������
    v_company_id VARCHAR2(100) := p_company_id;
  
    v_cooperation_company_id VARCHAR2(100);
  
    v_supply_id VARCHAR2(100);
  
    v_certificate_file VARCHAR2(4000);
  
    v_flag NUMBER;
  
    fask_rec scmdata.t_factory_ask%ROWTYPE;
  
    --�鳧���뵥 ���������Χ
    CURSOR fask_scope_cur(p_factory_ask_id VARCHAR2) IS
      SELECT t.*
        FROM scmdata.t_ask_scope t
       WHERE t.object_id = p_factory_ask_id
         AND t.object_type = 'CA';
  
    --�鳧���� ��������������ϸ
    CURSOR faskrp_ability_cur(p_factory_ask_id VARCHAR2) IS
      SELECT ra.*
        FROM scmdata.t_factory_report         fr,
             scmdata.t_factory_report_ability ra
       WHERE fr.factory_report_id = ra.factory_report_id
         AND fr.factory_ask_id = p_factory_ask_id;
  
  BEGIN
    --����Դ
    --�鳧���뵥 ����Ӧ�̻�����Ϣ��
    SELECT *
      INTO fask_rec
      FROM scmdata.t_factory_ask fa
     WHERE fa.factory_ask_id = p_factory_ask_id --�ⲿ���� :factory_ask_id
       AND fa.factrory_ask_flow_status IN ('FA22', 'FA32')
       AND fa.company_id = v_company_id;
  
    --��Ӧ���Ƿ���ƽ̨ע�ᣬ����ƽ̨ע���ͨ�����ͳһ���ô���ȡ��˾id
    SELECT MAX(fc.company_id)
      INTO v_cooperation_company_id
      FROM scmdata.sys_company fc
     WHERE fc.licence_num = fask_rec.social_credit_code;
  
    --Ӫҵִ��
    SELECT tr.certificate_file
      INTO v_certificate_file
      FROM scmdata.t_ask_record tr
     WHERE tr.ask_record_id = fask_rec.ask_record_id;
  
    --�ж��鳧��ʽ
    --1.���鳧  ��Դֻ���鳧���뵥
  
    IF fask_rec.factory_ask_type = 0 THEN
      --��ȡƽ̨Ψһ����
      v_supply_id := scmdata.pkg_plat_comm.f_getkeyid_plat('GY',
                                                           'seq_plat_code',
                                                           99);
    
      --1��������Ϣ
      INSERT INTO scmdata.t_supplier_info
        (supplier_info_id,
         company_id,
         supplier_info_origin_id,
         supplier_company_id,
         supplier_company_name,
         supplier_company_abbreviation,
         social_credit_code,
         company_contact_person,
         company_contact_phone,
         company_address,
         certificate_file,
         cooperation_type,
         cooperation_model,
         sharing_type,
         supplier_info_origin,
         pause,
         status,
         bind_status,
         create_id,
         create_date,
         update_id,
         update_date)
      VALUES
        (v_supply_id,
         v_company_id,
         fask_rec.factory_ask_id,
         nvl(fask_rec.cooperation_company_id, v_cooperation_company_id),
         fask_rec.company_name,
         fask_rec.company_name,
         fask_rec.social_credit_code,
         fask_rec.contact_name,
         fask_rec.contact_phone,
         fask_rec.company_address,
         v_certificate_file,
         fask_rec.cooperation_type,
         fask_rec.cooperation_model,
         '00',
         'AA',
         0,
         0,
         1,
         p_user_id,
         SYSDATE,
         p_user_id,
         SYSDATE);
      --2��������Χȡ=�����������Χ
      FOR fscope_rec IN fask_scope_cur(fask_rec.factory_ask_id) LOOP
        INSERT INTO t_coop_scope
          (coop_scope_id,
           supplier_info_id,
           company_id,
           coop_mode,
           coop_classification,
           coop_product_cate,
           coop_subcategory,
           create_id,
           create_time,
           update_id,
           update_time,
           remarks,
           pause,
           sharing_type)
        VALUES
          (scmdata.f_get_uuid(),
           v_supply_id,
           v_company_id,
           fask_rec.cooperation_model,
           fscope_rec.cooperation_classification,
           fscope_rec.cooperation_product_cate,
           fscope_rec.cooperation_subcategory,
           p_user_id,
           SYSDATE,
           p_user_id,
           SYSDATE,
           '',
           0,
           '00');
      
      END LOOP;
    
    ELSE
      --2.�鳧  ��Դ���鳧���棬��������
      --�ж��Ƿ����鳧����
      SELECT COUNT(1)
        INTO v_flag
        FROM scmdata.t_factory_report fr
       WHERE fr.factory_ask_id = fask_rec.factory_ask_id;
      --�鳧����
      IF v_flag > 0 THEN
        --��ȡƽ̨Ψһ����
        v_supply_id := scmdata.pkg_plat_comm.f_getkeyid_plat('GY',
                                                             'seq_plat_code',
                                                             99);
      
        --1��������Ϣ
        INSERT INTO scmdata.t_supplier_info
          (supplier_info_id,
           company_id,
           supplier_info_origin_id,
           supplier_company_id,
           supplier_company_name,
           supplier_company_abbreviation,
           social_credit_code,
           company_contact_person,
           company_contact_phone,
           company_address,
           certificate_file,
           cooperation_type,
           cooperation_model,
           sharing_type,
           supplier_info_origin,
           pause,
           status,
           bind_status,
           create_id,
           create_date,
           update_id,
           update_date)
        VALUES
          (v_supply_id,
           v_company_id,
           fask_rec.factory_ask_id,
           nvl(fask_rec.cooperation_company_id, v_cooperation_company_id),
           fask_rec.company_name,
           fask_rec.company_name,
           fask_rec.social_credit_code,
           fask_rec.contact_name,
           fask_rec.contact_phone,
           fask_rec.company_address,
           v_certificate_file,
           fask_rec.cooperation_type,
           fask_rec.cooperation_model,
           '00',
           'AA',
           0,
           0,
           1,
           p_user_id,
           SYSDATE,
           p_user_id,
           SYSDATE);
      
        --2��������Χȡ =���鳧���� ��������������ϸ(����)
        FOR faskrp_ability_rec IN faskrp_ability_cur(fask_rec.factory_ask_id) LOOP
          --ֻ����������������ϸ(����)���ܽ��������Χ
          IF faskrp_ability_rec.ability_result = 'AGREE' THEN
            --����������ϸ
            INSERT INTO t_coop_scope
              (coop_scope_id,
               supplier_info_id,
               company_id,
               coop_mode,
               coop_classification,
               coop_product_cate,
               coop_subcategory,
               remarks,
               pause,
               sharing_type,
               create_id,
               create_time,
               update_id,
               update_time)
            VALUES
              (scmdata.f_get_uuid(),
               v_supply_id,
               v_company_id,
               fask_rec.cooperation_model,
               faskrp_ability_rec.cooperation_classification,
               faskrp_ability_rec.cooperation_product_cate,
               faskrp_ability_rec.cooperation_subcategory,
               '',
               0,
               '00',
               p_user_id,
               SYSDATE,
               p_user_id,
               SYSDATE);
          ELSE
            NULL;
          END IF;
        END LOOP;
      
      ELSE
        NULL;
      END IF;
    END IF;
  END create_t_supplier_info;

  /*============================================*
  * Author   : SANFU
  * Created  : 2020-09-03 17:10:14
  * ALERTER  : 
  * ALERTER_TIME  : 
  * Purpose  : �ύ     ���ɹ�Ӧ�̱��룬δ����=���ѽ���
  * Obj_Name    : SUBMIT_T_SUPPLIER_INFO
  * Arg_Number  : 1
  * P_SUPPLIER_INFO_ID :��Ӧ�̵������
  *============================================*/
  PROCEDURE submit_t_supplier_info(p_supplier_info_id   VARCHAR2,
                                   p_default_company_id VARCHAR2,
                                   p_user_id            VARCHAR2) IS
    v_supplier_code VARCHAR2(100); --��Ӧ�̱���
    supplier_code_exp EXCEPTION;
    x_err_msg VARCHAR2(100);
  BEGIN
    --1.У������
    check_t_supplier_info(p_supplier_info_id, p_default_company_id);
    --2.���ɹ�Ӧ�̵������
    v_supplier_code := get_supplier_code_by_rule(p_supplier_info_id,
                                                 p_default_company_id);
    --3.���µ���״̬ ������ =���ѽ��� ,������MA����Ӧ�� => δ�󶨣�׼�루AA��=> �Ѱ�
    IF v_supplier_code IS NULL THEN
      RAISE supplier_code_exp;
    ELSE
      UPDATE scmdata.t_supplier_info sp
         SET sp.supplier_code    = v_supplier_code,
             sp.status           = 1,
             sp.bind_status      = decode(sp.supplier_info_origin,
                                          'AA',
                                          1,
                                          'MA',
                                          0,
                                          'QC',
                                          0,
                                          0),
             sp.create_supp_date = SYSDATE,
             sp.update_id        = p_user_id,
             sp.update_date      = SYSDATE
       WHERE sp.supplier_info_id = p_supplier_info_id;
    
      --��¼������־
      insert_oper_log(p_supplier_info_id,
                      '��������',
                      '',
                      p_user_id,
                      p_default_company_id,
                      SYSDATE);
    END IF;
  
  EXCEPTION
    WHEN supplier_code_exp THEN
      x_err_msg := '���ɹ�Ӧ�̱���ʧ�ܣ�����ϵ��ƽ̨��Ա����';
      sys_raise_app_error_pkg.is_running_error(p_err_msg          => x_err_msg,
                                               p_is_running_error => 'F');
  END submit_t_supplier_info;
  --����������־�ӱ�
  PROCEDURE insert_oper_log(p_supplier_info_id VARCHAR2,
                            oper_type          VARCHAR2,
                            p_reason           VARCHAR2,
                            p_user_id          VARCHAR2,
                            p_company_id       VARCHAR2,
                            p_create_time      DATE) IS
    v_name VARCHAR2(100);
  BEGIN
    SELECT fc.company_user_name
      INTO v_name
      FROM scmdata.sys_company_user fc
     WHERE fc.company_id = p_company_id
       AND fc.user_id = p_user_id;
    --������־�ӱ�
    INSERT INTO scmdata.t_supplier_info_oper_log
      (log_id,
       supplier_info_id,
       oper_type,
       reason,
       create_id,
       create_time,
       company_id)
    VALUES
      (scmdata.f_get_uuid(),
       p_supplier_info_id,
       oper_type,
       p_reason,
       v_name,
       p_create_time,
       p_company_id);
  END insert_oper_log;

  /*============================================*
  * Author   : SANFU
  * Created  : 2020-07-22 15:29:43
  * ALERTER  : 
  * ALERTER_TIME  : 
  * Purpose  :   ���¹�Ӧ�̵���״̬��0��������1��ͣ�ã�
  * Obj_Name    : update_supplier_info_status
  * Arg_Number  : 5
  * p_supplier_info_id :��Ӧ�̵������
  * p_reason ��ԭ��
  * P_STATUS :״̬
  * p_user_id ����ǰ������
  * p_company_id ����ǰ������ҵ
  *============================================*/
  PROCEDURE update_supplier_info_status(p_supplier_info_id VARCHAR2,
                                        p_reason           VARCHAR2,
                                        p_status           NUMBER,
                                        p_user_id          VARCHAR2,
                                        p_company_id       VARCHAR2) IS
    v_status  NUMBER;
    oper_type VARCHAR2(100);
    x_err_msg VARCHAR2(1000);
    supplier_info_exp EXCEPTION;
  BEGIN
  
    SELECT sp.pause
      INTO v_status
      FROM scmdata.t_supplier_info sp
     WHERE sp.supplier_info_id = p_supplier_info_id;
  
    IF p_status <> v_status THEN
      IF p_status = 0 THEN
        oper_type := '����';
      ELSIF p_status = 1 THEN
        oper_type := 'ͣ��';
      ELSE
        NULL;
      END IF;
      --�������á�ͣ�ò�����־�ӱ�
      insert_oper_log(p_supplier_info_id,
                      oper_type,
                      p_reason,
                      p_user_id,
                      p_company_id,
                      SYSDATE);
    
      --���ã�ͣ��
      UPDATE scmdata.t_supplier_info sp
         SET sp.pause = p_status, sp.update_date = SYSDATE
       WHERE sp.supplier_info_id = p_supplier_info_id;
    ELSE
      --�����ظ�����ʾ��Ϣ
      RAISE supplier_info_exp;
    END IF;
  
  EXCEPTION
    WHEN supplier_info_exp THEN
      x_err_msg := '�����ظ���������';
      sys_raise_app_error_pkg.is_running_error(p_err_msg          => x_err_msg,
                                               p_is_running_error => 'F');
    WHEN OTHERS THEN
      sys_raise_app_error_pkg.is_running_error(p_err_msg          => x_err_msg,
                                               p_is_running_error => 'T');
    
  END update_supplier_info_status;

  /*============================================*
  * Author   : SANFU
  * Created  : 2020-07-22 15:29:43
  * ALERTER  : 
  * ALERTER_TIME  : 
  * Purpose  :   ���¹�Ӧ�̵���״̬��0��������1��ͣ�ã�
  * Obj_Name    : update_supp_info_bind_status
  * Arg_Number  : 2
  * p_supplier_info_id :��Ӧ�̵������
  * P_STATUS :״̬
  *============================================*/
  PROCEDURE update_supp_info_bind_status(p_company_id       VARCHAR2,
                                         p_supplier_info_id VARCHAR2,
                                         p_user_id          VARCHAR2,
                                         p_status           NUMBER) IS
    v_status          NUMBER;
    oper_type         VARCHAR2(100);
    v_supp_company_id VARCHAR2(100);
    x_err_msg         VARCHAR2(1000);
    supplier_info_exp EXCEPTION;
    supplier_bind_exp EXCEPTION;
  BEGIN
  
    SELECT sp.bind_status, sp.supplier_company_id
      INTO v_status, v_supp_company_id
      FROM scmdata.t_supplier_info sp
     WHERE sp.supplier_info_id = p_supplier_info_id
       AND sp.company_id = p_company_id;
  
    --����ע�ṩӦ�̽��а󶨣����
    IF p_status <> nvl(v_status, 0) THEN
      IF v_supp_company_id IS NULL THEN
        RAISE supplier_bind_exp;
      END IF;
      IF p_status = 0 THEN
        oper_type := '���';
      ELSIF p_status = 1 THEN
        oper_type := '��';
      ELSE
        NULL;
      END IF;
      --�����󶨡���������־�ӱ�
      insert_oper_log(p_supplier_info_id,
                      oper_type,
                      '',
                      p_user_id,
                      p_company_id,
                      SYSDATE);
    
      UPDATE scmdata.t_supplier_info sp
         SET sp.bind_status = p_status
       WHERE sp.company_id = p_company_id
         AND sp.supplier_info_id = p_supplier_info_id
         AND sp.supplier_company_id IS NOT NULL;
    ELSE
      --�����ظ�����ʾ��Ϣ
      RAISE supplier_info_exp;
    END IF;
  
  EXCEPTION
    WHEN supplier_bind_exp THEN
      x_err_msg := 'δע�ṩӦ�̲��ܽ��а󶨣���';
      sys_raise_app_error_pkg.is_running_error(p_err_msg          => x_err_msg,
                                               p_is_running_error => 'F');
    WHEN supplier_info_exp THEN
      x_err_msg := '�����ظ���������';
      sys_raise_app_error_pkg.is_running_error(p_err_msg          => x_err_msg,
                                               p_is_running_error => 'F');
    WHEN OTHERS THEN
      sys_raise_app_error_pkg.is_running_error(p_err_msg          => x_err_msg,
                                               p_is_running_error => 'T');
    
  END update_supp_info_bind_status;

  /*============================================*
  * Author   : SANFU
  * Created  : 2020-07-22 15:29:43
  * ALERTER  : 
  * ALERTER_TIME  : 
  * Purpose  :   ���¹�Ӧ�̵���-������Χ״̬��0��������1��ͣ�ã�
  * Obj_Name    : update_supplier_info_status
  * Arg_Number  : 4
  * p_supplier_info_id :��Ӧ�̵������
  * P_STATUS :״̬
  * p_company_id ����ǰ������ҵ
  * p_coop_scope_id : ������Χ���
  *============================================*/
  PROCEDURE update_coop_scope_status(p_company_id       VARCHAR2,
                                     p_user_id          VARCHAR2,
                                     p_supplier_info_id VARCHAR2,
                                     p_coop_scope_id    VARCHAR2,
                                     p_status           NUMBER) IS
    v_status  NUMBER;
    oper_type VARCHAR2(100);
    x_err_msg VARCHAR2(1000);
    coop_scope_exp EXCEPTION;
  BEGIN
  
    SELECT sp.pause
      INTO v_status
      FROM scmdata.t_coop_scope sp
     WHERE sp.company_id = p_company_id
       AND sp.supplier_info_id = p_supplier_info_id
       AND sp.coop_scope_id = p_coop_scope_id;
  
    IF p_status <> v_status THEN
      --���ã�ͣ��
      UPDATE scmdata.t_coop_scope sp
         SET sp.pause       = p_status,
             sp.update_id   = p_user_id,
             sp.update_time = SYSDATE
       WHERE sp.company_id = p_company_id
         AND sp.supplier_info_id = p_supplier_info_id
         AND sp.coop_scope_id = p_coop_scope_id;
    
      IF p_status = 0 THEN
        oper_type := '����';
      ELSIF p_status = 1 THEN
        oper_type := 'ͣ��';
      ELSE
        NULL;
      END IF;
    
      --����������־�ӱ�
      insert_oper_log(p_supplier_info_id,
                      '�޸ĵ���-' || oper_type || '������Χ',
                      '',
                      p_user_id,
                      p_company_id,
                      SYSDATE);
    ELSE
      --�����ظ�����ʾ��Ϣ
      RAISE coop_scope_exp;
    END IF;
  
  EXCEPTION
    WHEN coop_scope_exp THEN
      x_err_msg := '�����ظ���������';
      sys_raise_app_error_pkg.is_running_error(p_err_msg          => x_err_msg,
                                               p_is_running_error => 'F');
    WHEN OTHERS THEN
      sys_raise_app_error_pkg.is_running_error(p_err_msg          => '',
                                               p_is_running_error => 'T');
    
  END update_coop_scope_status;

  /*============================================*
  * Author   : SANFU
  * Created  : 2020-09-28 10:15:31
  * ALERTER  : 
  * ALERTER_TIME  : 
  * Purpose  : ������Ӧ�� 
  * Obj_Name    : insert_supplier_info
  * Arg_Number  : 2
  * P_SP_DATA : ��Ӧ�̵�������
  * P_DEFAULT_COMPANY_ID : ƽ̨��ǰĬ����ҵ
  *============================================*/

  PROCEDURE insert_supplier_info(p_sp_data            scmdata.t_supplier_info%ROWTYPE,
                                 p_default_company_id VARCHAR2) IS
  BEGIN
  
    INSERT INTO scmdata.t_supplier_info
      (supplier_info_id,
       company_id,
       inside_supplier_code,
       supplier_company_name,
       company_province,
       company_city,
       company_county,
       company_address,
       supplier_company_abbreviation,
       social_credit_code,
       legal_representative,
       company_contact_person,
       company_type,
       cooperation_model,
       company_contact_phone,
       certificate_file,
       company_say,
       cooperation_type,
       status,
       supplier_info_origin,
       pause,
       create_id,
       create_date,
       update_id,
       update_date,
       remarks)
    VALUES
      (p_sp_data.supplier_info_id,
       p_default_company_id,
       p_sp_data.inside_supplier_code,
       p_sp_data.supplier_company_name,
       p_sp_data.company_province,
       p_sp_data.company_city,
       p_sp_data.company_county,
       p_sp_data.company_address,
       p_sp_data.supplier_company_abbreviation,
       p_sp_data.social_credit_code,
       p_sp_data.legal_representative,
       p_sp_data.company_contact_person,
       p_sp_data.company_type,
       p_sp_data.cooperation_model,
       p_sp_data.company_contact_phone,
       p_sp_data.certificate_file,
       p_sp_data.company_say,
       p_sp_data.cooperation_type,
       0,
       p_sp_data.supplier_info_origin,
       '0',
       p_sp_data.create_id,
       SYSDATE,
       p_sp_data.create_id,
       SYSDATE,
       p_sp_data.remarks);
  
  END insert_supplier_info;

  /*============================================*
  * Author   : SANFU
  * Created  : 2020-09-28 10:15:31
  * ALERTER  : 
  * ALERTER_TIME  : 
  * Purpose  : �޸Ĺ�Ӧ�� 
  * Obj_Name    : update_supplier_info
  * Arg_Number  : 2
  * P_SP_DATA : ��Ӧ�̵�������
  * P_DEFAULT_COMPANY_ID : ƽ̨��ǰĬ����ҵ
  *============================================*/

  PROCEDURE update_supplier_info(p_sp_data            scmdata.t_supplier_info%ROWTYPE,
                                 p_default_company_id VARCHAR2) IS
  BEGIN
  
    UPDATE scmdata.t_supplier_info
       SET inside_supplier_code          = p_sp_data.inside_supplier_code,
           supplier_company_name         = p_sp_data.supplier_company_name,
           company_province              = p_sp_data.company_province,
           company_city                  = p_sp_data.company_city,
           company_county                = p_sp_data.company_county,
           company_address               = p_sp_data.company_address,
           supplier_company_abbreviation = p_sp_data.supplier_company_abbreviation,
           social_credit_code            = p_sp_data.social_credit_code,
           legal_representative          = p_sp_data.legal_representative,
           company_contact_person        = p_sp_data.company_contact_person,
           company_type                  = p_sp_data.company_type,
           cooperation_model             = p_sp_data.cooperation_model,
           company_contact_phone         = p_sp_data.company_contact_phone,
           certificate_file              = p_sp_data.certificate_file,
           company_say                   = p_sp_data.company_say,
           cooperation_type              = p_sp_data.cooperation_type,
           update_id                     = p_sp_data.update_id,
           update_date                   = SYSDATE,
           remarks                       = p_sp_data.remarks
     WHERE supplier_info_id = p_sp_data.supplier_info_id
       AND company_id = p_default_company_id;
  
  END update_supplier_info;

  /*============================================*
  * Author   : SANFU
  * Created  : 2020-09-28 10:15:31
  * ALERTER  : 
  * ALERTER_TIME  : 
  * Purpose  : ɾ����Ӧ�� 
  * Obj_Name    : update_supplier_info
  * Arg_Number  : 2
  * p_supplier_info_id : ��Ӧ�̵������
  * P_DEFAULT_COMPANY_ID : ƽ̨��ǰĬ����ҵ
  *============================================*/

  PROCEDURE delete_supplier_info(p_supplier_info_id   VARCHAR2,
                                 p_default_company_id VARCHAR2) IS
    v_origin VARCHAR2(100);
  BEGIN
    SELECT sp.supplier_info_origin
      INTO v_origin
      FROM scmdata.t_supplier_info sp
     WHERE sp.company_id = p_default_company_id
       AND sp.supplier_info_id = p_supplier_info_id
       AND sp.status = 0;
    IF v_origin <> 'MA' THEN
      raise_application_error(-20002,
                              'ֻ��ɾ�����ֶ��������Ĵ�������Ӧ�̵�����');
    ELSE
    
      DELETE FROM scmdata.t_supplier_shared ts
       WHERE ts.company_id = p_default_company_id
         AND ts.supplier_info_id = p_supplier_info_id;
    
      DELETE FROM scmdata.t_coop_scope tc
       WHERE tc.company_id = p_default_company_id
         AND tc.supplier_info_id = p_supplier_info_id;
    
      DELETE FROM scmdata.t_contract_info tc
       WHERE tc.company_id = p_default_company_id
         AND tc.supplier_info_id = p_supplier_info_id;
    
      DELETE FROM scmdata.t_supplier_info sp
       WHERE sp.company_id = p_default_company_id
         AND sp.supplier_info_id = p_supplier_info_id
         AND sp.supplier_info_origin = 'MA'
         AND sp.status = 0;
    END IF;
  END delete_supplier_info;

  /*============================================*
  * Author   : SANFU
  * Created  : 2020-09-28 10:15:31
  * ALERTER  : 
  * ALERTER_TIME  : 
  * Purpose  :  У���ͬ 
  * Obj_Name    : check_contract_info
  * Arg_Number  : 1
  * p_contract_rec : ��ͬ��¼
  *============================================*/
  PROCEDURE check_contract_info(p_contract_rec scmdata.t_contract_info%ROWTYPE) IS
  BEGIN
    IF p_contract_rec.contract_start_date >
       p_contract_rec.contract_stop_date THEN
      raise_application_error(-20002, '��ͬ���ڣ��������ڱ���ݿ�ʼ����');
    END IF;
  END check_contract_info;
  /*============================================*
  * Author   : SANFU
  * Created  : 2020-09-28 10:15:31
  * ALERTER  : 
  * ALERTER_TIME  : 
  * Purpose  :  ������ͬ 
  * Obj_Name    : insert_contract_info
  * Arg_Number  : 1
  * p_contract_rec : ��ͬ��¼
  *============================================*/
  PROCEDURE insert_contract_info(p_contract_rec scmdata.t_contract_info%ROWTYPE) IS
  BEGIN
    --У���ͬ���ڣ��������ڱ���ݿ�ʼ����
    check_contract_info(p_contract_rec => p_contract_rec);
  
    INSERT INTO t_contract_info
      (contract_info_id,
       supplier_info_id,
       company_id,
       contract_start_date,
       contract_stop_date,
       contract_sign_date,
       contract_file)
    VALUES
      (scmdata.f_get_uuid(),
       p_contract_rec.supplier_info_id,
       p_contract_rec.company_id,
       p_contract_rec.contract_start_date,
       p_contract_rec.contract_stop_date,
       p_contract_rec.contract_sign_date,
       p_contract_rec.contract_file);
  
  END insert_contract_info;
  /*============================================*
  * Author   : SANFU
  * Created  : 2020-09-28 10:15:31
  * ALERTER  : 
  * ALERTER_TIME  : 
  * Purpose  :  �޸ĺ�ͬ 
  * Obj_Name    : update_contract_info
  * Arg_Number  : 1
  * p_contract_rec : ��ͬ��¼
  *============================================*/
  PROCEDURE update_contract_info(p_contract_rec scmdata.t_contract_info%ROWTYPE) IS
  BEGIN
    --У���ͬ���ڣ��������ڱ���ݿ�ʼ����
    check_contract_info(p_contract_rec => p_contract_rec);
  
    UPDATE t_contract_info t
       SET t.contract_start_date = p_contract_rec.contract_start_date,
           t.contract_stop_date  = p_contract_rec.contract_stop_date,
           t.contract_sign_date  = p_contract_rec.contract_sign_date,
           t.contract_file       = p_contract_rec.contract_file
     WHERE t.contract_info_id = p_contract_rec.contract_info_id;
  
  END update_contract_info;
  /*============================================*
  * Author   : SANFU
  * Created  : 2020-09-28 10:15:31
  * ALERTER  : 
  * ALERTER_TIME  : 
  * Purpose  :  ɾ����ͬ 
  * Obj_Name    : delete_contract_info
  * Arg_Number  : 1
  * p_contract_rec : ��ͬ��¼
  *============================================*/
  PROCEDURE delete_contract_info(p_contract_info_id VARCHAR2) IS
  BEGIN
  
    DELETE t_contract_info t WHERE t.contract_info_id = p_contract_info_id;
  
  END delete_contract_info;
  /*============================================*
  * Author   : SANFU
  * Created  : 2020-10-23 17:38:28
  * ALERTER  : 
  * ALERTER_TIME  : 
  * Purpose  :  EXCEL���� �ύ���յ� ����ʱ�����ύ��ҵ�����
  * Obj_Name    : submit_comm_craft_temp
  * Arg_Number  : 2
  * p_company_id :��ҵID
  * p_user_id ���û�ID
  *============================================*/
  PROCEDURE submit_supplier_info_temp(p_company_id IN VARCHAR2,
                                      p_user_id    IN VARCHAR2) IS
    p_sp_data scmdata.t_supplier_info%ROWTYPE;
    --��ʱ����,У����Ϣ                               
    CURSOR import_data_cur IS
      SELECT t.*, m.msg_type
        FROM scmdata.t_supplier_info_temp t
        LEFT JOIN scmdata.t_supplier_info_import_msg m
          ON t.err_msg_id = m.msg_id
       WHERE t.company_id = p_company_id
         AND t.user_id = p_user_id;
  BEGIN
  
    FOR data_rec IN import_data_cur LOOP
      --�ж������Ƿ�У��ɹ���ֻ�ж�У��ɹ��ˣ����ܽ����ύ
      IF data_rec.msg_type = 'E' OR data_rec.msg_type IS NULL THEN
        raise_application_error(-20002,
                                '���������Ƿ��Ѽ���ɹ����޸���ȷ�����ύ!');
      
      ELSE
        p_sp_data.supplier_info_id       := scmdata.f_get_uuid();
        p_sp_data.company_id             := data_rec.company_id;
        p_sp_data.create_id              := data_rec.user_id;
        p_sp_data.inside_supplier_code   := data_rec.inside_supplier_code;
        p_sp_data.supplier_company_name  := data_rec.supplier_company_name;
        p_sp_data.cooperation_type       := data_rec.cooperation_type;
        p_sp_data.company_city           := data_rec.company_city;
        p_sp_data.company_province       := data_rec.company_province;
        p_sp_data.company_county         := data_rec.company_county;
        p_sp_data.company_address        := data_rec.company_address;
        p_sp_data.social_credit_code     := data_rec.social_credit_code;
        p_sp_data.legal_representative   := data_rec.legal_representative;
        p_sp_data.company_contact_person := data_rec.company_contact_person;
        p_sp_data.company_contact_phone  := data_rec.company_contact_phone;
        p_sp_data.cooperation_type       := data_rec.cooperation_type_code;
        p_sp_data.cooperation_model      := data_rec.cooperation_model_code;
        p_sp_data.company_city           := data_rec.company_city_code;
        p_sp_data.company_province       := data_rec.company_province_code;
        p_sp_data.company_county         := data_rec.company_county_code;
        p_sp_data.remarks                := data_rec.memo;
        p_sp_data.supplier_info_origin   := 'QC';
      
        --����ʱ�����ύ��ҵ�����,������
        insert_supplier_info(p_sp_data            => p_sp_data,
                             p_default_company_id => p_company_id);
        -- �ύ=���ѽ���                                    
        submit_t_supplier_info(p_supplier_info_id   => p_sp_data.supplier_info_id,
                               p_default_company_id => p_company_id,
                               p_user_id            => p_user_id);
      END IF;
    
    END LOOP;
  
    --��������ʱ�������Լ�������Ϣ�������
    delete_supplier_info_temp(p_company_id => p_company_id,
                              p_user_id    => p_user_id);
  END submit_supplier_info_temp;

  /*============================================*
  * Author   : SANFU
  * Created  : 2020-10-23 17:42:18
  * ALERTER  : 
  * ALERTER_TIME  : 
  * Purpose  : У�鵼������
  * Obj_Name    : CHECK_IMPORTDATAS
  * Arg_Number  : 2
  * P_COMPANY_ID :��ҵID
  * P_USER_ID :�û�ID
  * p_supplier_temp_id :��ʱ��ID
  *============================================*/

  PROCEDURE check_importdatas(p_company_id       IN VARCHAR2,
                              p_user_id          IN VARCHAR2,
                              p_supplier_temp_id IN VARCHAR2) IS
  
    v_num          NUMBER := 0;
    v_err_num      NUMBER := 0;
    v_msg_id       NUMBER;
    v_supp_flag    NUMBER := 0;
    v_supp_flag_tp NUMBER := 0;
    v_msg          VARCHAR2(2000);
    v_flag         NUMBER := 0;
    v_coop_name    VARCHAR2(100);
    v_coop_mdname  VARCHAR2(100);
    v_import_flag  VARCHAR2(100);
    v_province     VARCHAR2(100);
    v_city         VARCHAR2(100);
    v_county       VARCHAR2(100);
    --�������ʱ����
    data_rec scmdata.t_supplier_info_temp%ROWTYPE;
    /*    CURSOR importdatas IS
    SELECT *
      FROM scmdata.t_supplier_info_temp t
     WHERE t.company_id = p_company_id
       AND t.user_id = p_user_id;*/
  BEGIN
    SELECT *
      INTO data_rec
      FROM scmdata.t_supplier_info_temp t
     WHERE t.company_id = p_company_id
       AND t.user_id = p_user_id
       AND t.supplier_temp_id = p_supplier_temp_id;
  
    --FOR data_rec IN importdatas LOOP
    IF data_rec.inside_supplier_code IS NULL THEN
      v_err_num := v_err_num + 1;
      v_msg     := v_err_num || '.��Ӧ�̱�Ų���Ϊ�գ�';
    ELSE
    
      --1����������ݹ�Ӧ�̱�Ų����ظ�
      SELECT COUNT(1)
        INTO v_supp_flag_tp
        FROM scmdata.t_supplier_info_temp t
       WHERE t.company_id = p_company_id
         AND t.user_id = p_user_id
         AND t.inside_supplier_code = data_rec.inside_supplier_code;
    
      --2�� �����й�Ӧ�̵����Ĺ�Ӧ�̱��벻���ظ�
    
      SELECT COUNT(1)
        INTO v_supp_flag
        FROM scmdata.t_supplier_info t
       WHERE t.company_id = p_company_id
         AND t.inside_supplier_code = data_rec.inside_supplier_code;
    
      --��Ӧ�̱���Ƿ���ڣ������ظ�
      IF v_supp_flag_tp > 1 OR v_supp_flag > 0 THEN
        v_err_num := v_err_num + 1;
        v_msg     := v_err_num || '.��Ӧ�̱�Ų����ظ����������ݴ����ظ����빩Ӧ�̵������б���ظ���';
      END IF;
    END IF;
  
    IF data_rec.supplier_company_name IS NULL THEN
      v_err_num := v_err_num + 1;
      v_msg     := v_msg || v_err_num || '.��Ӧ�����Ʋ���Ϊ�գ�';
    ELSE
      --3) ��Ӧ������ֻ����д���ļ���������  
      IF pkg_check_data_comm.f_check_varchar(pi_data => data_rec.supplier_company_name,
                                             pi_type => 0) <> 1 THEN
        raise_application_error(-20002,
                                '��Ӧ��������д���󣬽�����д���ļ��������ţ�');
      END IF;
      --4����������ݹ�Ӧ�����Ʋ����ظ�
      SELECT COUNT(1)
        INTO v_supp_flag_tp
        FROM scmdata.t_supplier_info_temp t
       WHERE t.company_id = p_company_id
         AND t.user_id = p_user_id
         AND t.supplier_company_name = data_rec.supplier_company_name;
      --5�� �����й�Ӧ�̵����Ĺ�Ӧ�����Ʋ����ظ�
      SELECT COUNT(1)
        INTO v_supp_flag
        FROM scmdata.t_supplier_info t
       WHERE t.company_id = p_company_id
         AND t.supplier_company_name = data_rec.supplier_company_name;
    
      --��Ӧ�������Ƿ���ڣ������ظ�
      IF v_supp_flag_tp > 1 OR v_supp_flag > 0 THEN
        v_err_num := v_err_num + 1;
        v_msg     := v_err_num || '.��Ӧ�����Ʋ����ظ����������ݴ����ظ����빩Ӧ�̵������������ظ���';
      END IF;
    END IF;
  
    IF data_rec.cooperation_type_code IS NULL THEN
      v_err_num := v_err_num + 1;
      v_msg     := v_msg || v_err_num || '.�������ͱ��벻��Ϊ�գ�';
    END IF;
  
    IF data_rec.cooperation_type IS NULL THEN
      v_err_num := v_err_num + 1;
      v_msg     := v_msg || v_err_num || '.�������Ͳ���Ϊ�գ�';
    END IF;
  
    IF data_rec.cooperation_model_code IS NULL THEN
      v_err_num := v_err_num + 1;
      v_msg     := v_msg || v_err_num || '.����ģʽ���벻��Ϊ�գ�';
    END IF;
  
    IF data_rec.cooperation_model IS NULL THEN
      v_err_num := v_err_num + 1;
      v_msg     := v_msg || v_err_num || '.����ģʽ����Ϊ�գ�';
    END IF;
  
    --У��ͳһ������ô���
    IF data_rec.social_credit_code IS NULL THEN
    
      v_err_num := v_err_num + 1;
      v_msg     := v_msg || v_err_num || '.ͳһ������ô��벻��Ϊ�գ�';
    
    ELSIF pkg_check_data_comm.f_check_soial_code(data_rec.social_credit_code) = 0 THEN
      v_err_num := v_err_num + 1;
      v_msg     := v_msg || v_err_num || '.ͳһ������ô���:[' ||
                   data_rec.social_credit_code ||
                   ']����ӦΪ18λ������д��ȷ��ͳһ������ô��룡';
    ELSE
      --У��ͳһ������ô��� �ڸ���ҵ���ѽ����Ƿ�Ψһ
      SELECT COUNT(1)
        INTO v_flag
        FROM scmdata.t_supplier_info t
       WHERE t.company_id = data_rec.company_id
         AND t.status = 1
         AND t.social_credit_code = data_rec.social_credit_code;
    
      IF v_flag > 0 THEN
        v_err_num := v_err_num + 1;
        v_msg     := v_msg || v_err_num || '.ͳһ������ô���:[' ||
                     data_rec.social_credit_code ||
                     ']�ڸ���ҵ���Ѵ��ڣ�����д��ȷ��ͳһ������ô��룡';
      END IF;
    
    END IF;
  
    --У��������ͱ���
    SELECT COUNT(t.group_dict_value)
      INTO v_flag
      FROM scmdata.sys_group_dict t
     WHERE t.group_dict_type = 'COOPERATION_TYPE'
       AND t.group_dict_value = data_rec.cooperation_type_code;
  
    IF v_flag = 0 THEN
      v_err_num := v_err_num + 1;
      v_msg     := v_msg || v_err_num || '.�������ͱ���:[' ||
                   data_rec.cooperation_type_code ||
                   ']�������ֵ��в����ڣ�����д��ȷ�ĺ������ͱ��룡';
    ELSE
      SELECT MAX(t.group_dict_name)
        INTO v_coop_name
        FROM scmdata.sys_group_dict t
       WHERE t.group_dict_type = 'COOPERATION_TYPE'
         AND t.group_dict_value = data_rec.cooperation_type_code;
    
      IF v_coop_name <> data_rec.cooperation_type THEN
        v_err_num := v_err_num + 1;
        v_msg     := v_msg || v_err_num || '.�������ͱ���:[' ||
                     data_rec.cooperation_type_code || ']�������������:[' ||
                     data_rec.cooperation_type || ']��Ӧ��ϵ��һ�£���ȷ�Ϻ���д��';
      ELSE
        NULL;
      END IF;
    END IF;
  
    --У�����ģʽ����
    SELECT COUNT(t.group_dict_value)
      INTO v_flag
      FROM scmdata.sys_group_dict t
     WHERE t.group_dict_type = 'SUPPLY_TYPE'
       AND t.group_dict_value = data_rec.cooperation_model_code;
  
    IF v_flag = 0 THEN
      v_err_num := v_err_num + 1;
      v_msg     := v_msg || v_err_num || '.����ģʽ����:[' ||
                   data_rec.cooperation_model_code ||
                   ']�������ֵ��в����ڣ�����д��ȷ�ĺ���ģʽ���룡';
    ELSE
      SELECT MAX(t.group_dict_name)
        INTO v_coop_mdname
        FROM scmdata.sys_group_dict t
       WHERE t.group_dict_type = 'SUPPLY_TYPE'
         AND t.group_dict_value = data_rec.cooperation_model_code;
    
      IF v_coop_mdname <> data_rec.cooperation_model THEN
        v_err_num := v_err_num + 1;
        v_msg     := v_msg || v_err_num || '.����ģʽ����:[' ||
                     data_rec.cooperation_model_code || ']�����ģʽ����:[' ||
                     data_rec.cooperation_model || ']��Ӧ��ϵ��һ�£���ȷ�Ϻ���д��';
      ELSE
        NULL;
      END IF;
    END IF;
  
    --У���ֻ�����
    IF pkg_check_data_comm.f_check_phone(pi_data => data_rec.company_contact_phone) = 0 THEN
      v_err_num := v_err_num + 1;
      v_msg     := v_msg || v_err_num || '.��ϵ���ֻ�:[' ||
                   data_rec.company_contact_phone || ']����д��ȷ����ϵ���ֻ���';
    END IF;
    --У��ʡ����
    --ʡ
    IF data_rec.company_province_code IS NOT NULL THEN
      SELECT COUNT(1)
        INTO v_num
        FROM scmdata.dic_province p
       WHERE p.provinceid = data_rec.company_province_code;
    
      IF v_num = 0 THEN
        v_err_num := v_err_num + 1;
        v_msg     := v_msg || v_err_num || '.ʡ�ݱ��:[' ||
                     data_rec.company_province_code ||
                     ']�������ֵ��в����ڣ�����д��ȷ��ʡ�ݱ�ţ�';
      ELSE
        SELECT MAX(p.province)
          INTO v_province
          FROM scmdata.dic_province p
         WHERE p.provinceid = data_rec.company_province_code;
      
        IF v_province <> data_rec.company_province THEN
          v_err_num := v_err_num + 1;
          v_msg     := v_msg || v_err_num || '.ʡ�ݱ��:[' ||
                       data_rec.company_province_code || ']��ʡ������:[' ||
                       data_rec.company_province || ']��Ӧ��ϵ��һ�£���ȷ�Ϻ���д��';
        ELSE
          --��
          IF data_rec.company_city_code IS NOT NULL THEN
          
            SELECT COUNT(1)
              INTO v_num
              FROM scmdata.dic_city c
             WHERE c.provinceid = data_rec.company_province_code
               AND c.cityno = data_rec.company_city_code;
          
            IF v_num = 0 THEN
              v_err_num := v_err_num + 1;
              v_msg     := v_msg || v_err_num || '.���б��:[' ||
                           data_rec.company_city_code || ']�������ֵ��в�����/[' ||
                           data_rec.company_city || ']������[' ||
                           data_rec.company_province || ']������д��ȷ�ĳ��б�ţ�';
            ELSE
              SELECT MAX(c.city)
                INTO v_city
                FROM scmdata.dic_city c
               WHERE c.provinceid = data_rec.company_province_code
                 AND c.cityno = data_rec.company_city_code;
            
              IF v_city <> data_rec.company_city THEN
                v_err_num := v_err_num + 1;
                v_msg     := v_msg || v_err_num || '.���б��:[' ||
                             data_rec.company_city_code || ']���������:[' ||
                             data_rec.company_city || ']��Ӧ��ϵ��һ�£���ȷ�Ϻ���д��';
              ELSE
                --��
                IF data_rec.company_county_code IS NOT NULL THEN
                
                  SELECT COUNT(1)
                    INTO v_num
                    FROM scmdata.dic_county d
                   WHERE d.cityno = data_rec.company_city_code
                     AND d.countyid = data_rec.company_county_code;
                
                  IF v_num = 0 THEN
                    v_err_num := v_err_num + 1;
                    v_msg     := v_msg || v_err_num || '.���ر��:[' ||
                                 data_rec.company_county_code ||
                                 ']�������ֵ��в�����/[' || data_rec.company_county ||
                                 ']������[' || data_rec.company_city ||
                                 ']������д��ȷ�����ر�ţ�';
                  ELSE
                    SELECT MAX(d.county)
                      INTO v_county
                      FROM scmdata.dic_county d
                     WHERE d.cityno = data_rec.company_city_code
                       AND d.countyid = data_rec.company_county_code;
                  
                    IF v_county <> data_rec.company_county THEN
                      v_err_num := v_err_num + 1;
                      v_msg     := v_msg || v_err_num || '.���ر��:[' ||
                                   data_rec.company_county_code ||
                                   ']����������:[' || data_rec.company_county ||
                                   ']��Ӧ��ϵ��һ�£���ȷ�Ϻ���д��';
                    END IF;
                  END IF;
                END IF;
              END IF;
            END IF;
          END IF;
        END IF;
      END IF;
    END IF;
    --��У����Ϣ���뵽������Ϣ��
    v_msg_id := scmdata.t_supplier_info_import_msg_s.nextval;
  
    UPDATE scmdata.t_supplier_info_temp t
       SET t.err_msg_id = v_msg_id
     WHERE t.company_id = data_rec.company_id
       AND t.user_id = data_rec.user_id
       AND t.supplier_temp_id = data_rec.supplier_temp_id;
  
    IF v_err_num > 0 THEN
      v_import_flag := 'У����󣺹�' || v_err_num || '������';
      INSERT INTO scmdata.t_supplier_info_import_msg
      VALUES
        (v_msg_id,
         data_rec.company_id,
         data_rec.user_id,
         'E',
         v_import_flag || v_msg,
         SYSDATE);
      --��մ����¼
      /*      v_num     := 0;
      v_err_num := 0;
      v_msg     := NULL;*/
    ELSE
      v_import_flag := 'У��ɹ�';
      INSERT INTO scmdata.t_supplier_info_import_msg
      VALUES
        (v_msg_id,
         data_rec.company_id,
         data_rec.user_id,
         'Y',
         v_import_flag,
         SYSDATE);
    END IF;
  
    --END LOOP;
  
  END check_importdatas;

  /*============================================*
  * Author   : SANFU
  * Created  : 2020-10-23 17:38:28
  * ALERTER  : 
  * ALERTER_TIME  : 
  * Purpose  :  EXCEL���� ������Ӧ��������ʱ����
  * Obj_Name    : insert_supplier_info_temp
  * Arg_Number  : 1
  * P_CRAFT_REC :��ʱ����
  *============================================*/

  PROCEDURE insert_supplier_info_temp(p_supp_rec scmdata.t_supplier_info_temp%ROWTYPE) IS
  BEGIN
  
    INSERT INTO t_supplier_info_temp
      (supplier_temp_id,
       company_id,
       user_id,
       err_msg_id,
       inside_supplier_code,
       supplier_company_name,
       cooperation_type,
       cooperation_model_code,
       cooperation_model,
       company_city,
       company_province,
       company_county,
       company_address,
       social_credit_code,
       legal_representative,
       company_contact_person,
       company_contact_phone,
       cooperation_type_code,
       company_city_code,
       company_province_code,
       company_county_code,
       memo)
    VALUES
      (p_supp_rec.supplier_temp_id,
       p_supp_rec.company_id,
       p_supp_rec.user_id,
       p_supp_rec.err_msg_id,
       p_supp_rec.inside_supplier_code,
       p_supp_rec.supplier_company_name,
       p_supp_rec.cooperation_type,
       p_supp_rec.cooperation_model_code,
       p_supp_rec.cooperation_model,
       p_supp_rec.company_city,
       p_supp_rec.company_province,
       p_supp_rec.company_county,
       p_supp_rec.company_address,
       p_supp_rec.social_credit_code,
       p_supp_rec.legal_representative,
       p_supp_rec.company_contact_person,
       p_supp_rec.company_contact_phone,
       p_supp_rec.cooperation_type_code,
       p_supp_rec.company_city_code,
       p_supp_rec.company_province_code,
       p_supp_rec.company_county_code,
       p_supp_rec.memo);
  
    --�����У������ 
    check_importdatas(p_company_id       => p_supp_rec.company_id,
                      p_user_id          => p_supp_rec.user_id,
                      p_supplier_temp_id => p_supp_rec.supplier_temp_id);
  
  EXCEPTION
    WHEN OTHERS THEN
      sys_raise_app_error_pkg.is_running_error(p_err_msg          => 'EXCEL���빩Ӧ��������������ϵ����Ա��',
                                               p_is_running_error => 'T');
  END insert_supplier_info_temp;

  /*============================================*
  * Author   : SANFU
  * Created  : 2020-10-23 17:38:28
  * ALERTER  : 
  * ALERTER_TIME  : 
  * Purpose  :  EXCEL���� �޸Ĺ�Ӧ��������ʱ����
  * Obj_Name    : update_supplier_info_temp
  * Arg_Number  : 1
  * P_CRAFT_REC :��ʱ����
  *============================================*/
  PROCEDURE update_supplier_info_temp(p_supp_rec scmdata.t_supplier_info_temp%ROWTYPE) IS
  BEGIN
  
    UPDATE t_supplier_info_temp t
       SET t.inside_supplier_code   = p_supp_rec.inside_supplier_code,
           t.supplier_company_name  = p_supp_rec.supplier_company_name,
           t.cooperation_type       = p_supp_rec.cooperation_type,
           t.cooperation_model_code = p_supp_rec.cooperation_model_code,
           t.cooperation_model      = p_supp_rec.cooperation_model,
           t.company_city           = p_supp_rec.company_city,
           t.company_province       = p_supp_rec.company_province,
           t.company_county         = p_supp_rec.company_county,
           t.company_address        = p_supp_rec.company_address,
           t.social_credit_code     = p_supp_rec.social_credit_code,
           t.legal_representative   = p_supp_rec.legal_representative,
           t.company_contact_person = p_supp_rec.company_contact_person,
           t.company_contact_phone  = p_supp_rec.company_contact_phone,
           t.cooperation_type_code  = p_supp_rec.cooperation_type_code,
           t.company_city_code      = p_supp_rec.company_city_code,
           t.company_province_code  = p_supp_rec.company_province_code,
           t.company_county_code    = p_supp_rec.company_county_code,
           t.memo                   = p_supp_rec.memo
     WHERE t.supplier_temp_id = p_supp_rec.supplier_temp_id;
  
    --�����У������
    --�����У������ ����
    check_importdatas(p_company_id       => p_supp_rec.company_id,
                      p_user_id          => p_supp_rec.user_id,
                      p_supplier_temp_id => p_supp_rec.supplier_temp_id);
  EXCEPTION
    WHEN OTHERS THEN
      sys_raise_app_error_pkg.is_running_error(p_err_msg          => 'EXCEL���빩Ӧ��������������ϵ����Ա��',
                                               p_is_running_error => 'T');
  END update_supplier_info_temp;
  /*============================================*
  * Author   : SANFU
  * Created  : 2020-10-23 17:43:35
  * ALERTER  : 
  * ALERTER_TIME  : 
  * Purpose  : ��յ�������
  * Obj_Name    : delete_supplier_info_temp
  * Arg_Number  : 2
  * P_COMPANY_ID :��ҵID
  * P_USER_ID : �û�ID
  *============================================*/
  PROCEDURE delete_supplier_info_temp(p_company_id IN VARCHAR2,
                                      p_user_id    IN VARCHAR2) IS
  
  BEGIN
    --�����ʱ��������Ϣ�������
    DELETE FROM scmdata.t_supplier_info_import_msg m
     WHERE m.company_id = p_company_id
       AND m.user_id = p_user_id;
  
    DELETE FROM scmdata.t_supplier_info_temp t
     WHERE t.company_id = p_company_id
       AND t.user_id = p_user_id;
  
  END delete_supplier_info_temp;

  --�ӿڻ�ȡ����
  FUNCTION get_supp_batch_id(pi_company_id VARCHAR2) RETURN VARCHAR2 IS
    v_i VARCHAR2(100);
  BEGIN
    --1.��ʼ��������
    v_i := pkg_plat_comm.f_getkeycode(pi_table_name  => 't_supplier_info_ctl',
                                      pi_column_name => 'batch_id',
                                      pi_company_id  => pi_company_id,
                                      pi_pre         => '',
                                      pi_serail_num  => 6);
  
    --2.��ѯ��ر������ţ�����д��ʼֵ
    SELECT decode(MAX(t.batch_id), NULL, v_i, v_i)
      INTO v_i
      FROM scmdata.t_supplier_info_ctl t;
  
    RETURN v_i;
  END get_supp_batch_id;
  /*============================================*
  * Author   : zwh73
  * Created  : 2020-10-23 17:42:18
  * ALERTER  : 
  * ALERTER_TIME  : 
  * Purpose  : У�鵼������
  * Obj_Name    : check_importdatas_coop_scope
  * Arg_Number  : 1
  * p_supplier_temp_id :��ʱ��ID
  *============================================*/

  PROCEDURE check_importdatas_coop_scope(p_coop_scope_temp_id IN VARCHAR2) IS
    p_coop_scope_temp t_coop_scope_temp%ROWTYPE;
    p_flag            INT;
    p_i               INT;
    p_msg             VARCHAR2(3000);
    p_desc            VARCHAR2(100);
    p_supplier_id     VARCHAR2(32);
  BEGIN
    p_i := 0;
    SELECT t.*
      INTO p_coop_scope_temp
      FROM scmdata.t_coop_scope_temp t
     WHERE coop_scope_temp_id = p_coop_scope_temp_id;
    --У�鹩Ӧ�̺���
    SELECT MAX(t.status),
           MAX(supplier_company_name),
           MAX(t.supplier_info_id)
      INTO p_flag, p_desc, p_supplier_id
      FROM scmdata.t_supplier_info t
     WHERE t.inside_supplier_code = p_coop_scope_temp.inside_supplier_code
       AND t.company_id = p_coop_scope_temp.company_id;
    IF p_flag IS NULL THEN
      p_i   := p_i + 1;
      p_msg := p_msg || p_i || ')�����ڵĹ�Ӧ�̱��,';
    
    ELSIF p_flag = 0 THEN
      p_i   := p_i + 1;
      p_msg := p_msg || p_i || ')��Ӧ��δ����,';
    
    ELSIF p_desc <> p_coop_scope_temp.supplier_company_name THEN
      p_i   := p_i + 1;
      p_msg := p_msg || p_i || ')��Ӧ�̱�ź͹�Ӧ�����Ʋ���Ӧ,��ǰ��ӦΪ:' || p_desc || ' ,';
    
    END IF;
    --�������
    SELECT MAX(a.group_dict_value)
      INTO p_coop_scope_temp.coop_classification
      FROM sys_group_dict a
     WHERE a.group_dict_name = p_coop_scope_temp.coop_classification_desc
       AND a.group_dict_type = 'PRODUCT_TYPE'
       AND pause = 0;
    IF p_coop_scope_temp.coop_classification IS NULL THEN
      p_i   := p_i + 1;
      p_msg := p_msg || p_i || ')�����ڵĺ�������';
    ELSE
      UPDATE scmdata.t_coop_scope_temp t
         SET t.coop_classification = p_coop_scope_temp.coop_classification
       WHERE coop_scope_temp_id = p_coop_scope_temp_id;
    END IF;
    --У�����
    SELECT MAX(a.group_dict_value)
      INTO p_coop_scope_temp.coop_product_cate
      FROM sys_group_dict a
     WHERE a.group_dict_name = p_coop_scope_temp.coop_product_cate_desc
       AND a.group_dict_type = p_coop_scope_temp.coop_classification
       AND pause = 0;
    IF p_coop_scope_temp.coop_product_cate IS NULL THEN
      p_i   := p_i + 1;
      p_msg := p_msg || p_i || ')�����ڵĿ��������';
    ELSE
      UPDATE scmdata.t_coop_scope_temp t
         SET t.coop_product_cate = p_coop_scope_temp.coop_product_cate
       WHERE coop_scope_temp_id = p_coop_scope_temp_id;
    
    END IF;
    IF p_supplier_id IS NOT NULL AND
       p_coop_scope_temp.coop_classification IS NOT NULL AND
       p_coop_scope_temp.coop_product_cate IS NOT NULL THEN
      SELECT nvl(MAX(1), 0)
        INTO p_flag
        FROM scmdata.t_coop_scope a
       WHERE a.supplier_info_id = p_supplier_id
         AND a.coop_classification = p_coop_scope_temp.coop_classification
         AND a.coop_product_cate = p_coop_scope_temp.coop_product_cate;
      IF p_flag = 1 THEN
        p_i   := p_i + 1;
        p_msg := p_msg || p_i || ')��Ӧ��Ӧ�̵��������ظ��ķ���+�������';
      END IF;
    END IF;
  
    --У��С��
  
    IF p_coop_scope_temp.coop_subcategory_desc IS NULL THEN
      UPDATE scmdata.t_coop_scope_temp t
         SET coop_subcategory     =
             (SELECT listagg(company_dict_value, ';') within GROUP(ORDER BY 1)
                FROM sys_company_dict
               WHERE company_dict_type = p_coop_scope_temp.coop_product_cate
                 AND company_id = p_coop_scope_temp.company_id),
             coop_subcategory_desc =
             (SELECT listagg(company_dict_name, ';') within GROUP(ORDER BY 1)
                FROM sys_company_dict
               WHERE company_dict_type = p_coop_scope_temp.coop_product_cate
                 AND company_id = p_coop_scope_temp.company_id)
       WHERE coop_scope_temp_id = p_coop_scope_temp_id;
    ELSE
      SELECT listagg(c.company_dict_value, ';') within GROUP(ORDER BY 1)
        INTO p_coop_scope_temp.coop_subcategory
        FROM scmdata.sys_company_dict c
       WHERE c.company_id = p_coop_scope_temp.company_id
         AND company_dict_type = p_coop_scope_temp.coop_product_cate
         AND instr(';' || p_coop_scope_temp.coop_subcategory_desc || ';',
                   ';' || company_dict_name || ';') > 0;
      IF p_coop_scope_temp.coop_subcategory IS NULL THEN
        p_i   := p_i + 1;
        p_msg := p_msg || p_i || ')�����ڵĿɺ�����Ʒ����';
      
      ELSE
        UPDATE scmdata.t_coop_scope_temp t
           SET t.coop_subcategory = p_coop_scope_temp.coop_subcategory
         WHERE coop_scope_temp_id = p_coop_scope_temp_id;
      
      END IF;
    END IF;
  
    --У�鲻���ڵ�����
    SELECT nvl(length(regexp_replace(p_coop_scope_temp.coop_subcategory,
                                     '[^;]',
                                     '')),
               0),
           nvl(length(regexp_replace(p_coop_scope_temp.coop_subcategory_desc,
                                     '[^;]',
                                     '')),
               0)
      INTO p_i, p_flag
      FROM dual;
    IF p_i <> p_flag THEN
      SELECT listagg(c.company_dict_name, ';') within GROUP(ORDER BY 1)
        INTO p_desc
        FROM scmdata.sys_company_dict c
       WHERE c.company_id = p_coop_scope_temp.company_id
         AND company_dict_type = p_coop_scope_temp.coop_product_cate
         AND instr(';' || p_coop_scope_temp.coop_subcategory || ';',
                   ';' || company_dict_value || ';') > 0;
      p_i   := p_i + 1;
      p_msg := p_msg || p_i || ')�в��ֲ�Ʒ����û����scm�����ã����飬��ǰ��������Ϊ��' || p_desc;
    END IF;
    --У�������}
    SELECT COUNT(col) - COUNT(DISTINCT col)
      INTO p_flag
      FROM (SELECT regexp_substr(p_coop_scope_temp.coop_subcategory,
                                 '[^;]+',
                                 1,
                                 LEVEL,
                                 'i') col,
                   LEVEL seq_no
              FROM dual
            CONNECT BY LEVEL <= length(p_coop_scope_temp.coop_subcategory) -
                       length(regexp_replace(p_coop_scope_temp.coop_subcategory,
                                                      ';',
                                                      '')) + 1);
    IF p_flag > 0 THEN
      p_i   := p_i + 1;
      p_msg := p_msg || p_i || ')�����ظ��Ŀɺ�����Ʒ����';
    
    END IF;
  
    SELECT MAX(a.group_dict_name)
      INTO p_desc
      FROM sys_group_dict a
     WHERE a.group_dict_value = p_coop_scope_temp.sharing_type
       AND a.group_dict_type = 'SHARE_METHOD'
       AND pause = 0;
    IF p_desc IS NULL THEN
      p_i   := p_i + 1;
      p_msg := p_msg || p_i || ')�����ڵ��Ƿ����������Ӧ�̱���';
    
    ELSIF p_desc <> p_coop_scope_temp.sharing_type_desc THEN
      p_i   := p_i + 1;
      p_msg := p_msg || p_i || ')�Ƿ����������Ӧ�̱�����Ƿ����������Ӧ����������Ӧ,��ǰ��ӦΪ:' ||
               p_desc;
    
    END IF;
  
    IF p_coop_scope_temp.sharing_type = '02' AND
       p_coop_scope_temp.sharing_sup_code IS NULL THEN
      p_i   := p_i + 1;
      p_msg := p_msg || p_i || ')���ֹ���ʱ��������ӹ�����Ӧ���б�';
    END IF;
    IF p_coop_scope_temp.sharing_sup_code IS NOT NULL THEN
      SELECT listagg(a.supplier_company_name, ';') within GROUP(ORDER BY 1)
        INTO p_desc
        FROM t_supplier_info a
       WHERE a.company_id = p_coop_scope_temp.company_id
         AND a.inside_supplier_code IN
             (SELECT regexp_substr(p_coop_scope_temp.sharing_sup_code,
                                   '[^;]+',
                                   1,
                                   LEVEL,
                                   'i')
                FROM dual
              CONNECT BY LEVEL <= length(p_coop_scope_temp.sharing_sup_code) -
                         length(regexp_replace(p_coop_scope_temp.sharing_sup_code,
                                                        ';',
                                                        '')) + 1);
      IF p_desc IS NULL THEN
        p_i   := p_i + 1;
        p_msg := p_msg || p_i || ')������Ӧ�̱���û���ҵ���Ӧ�Ĺ�Ӧ��';
      ELSIF p_desc <> p_coop_scope_temp.sharing_sup_code_desc OR
            p_coop_scope_temp.sharing_sup_code_desc IS NULL THEN
        p_i   := p_i + 1;
        p_msg := p_msg || p_i || ')������Ӧ�̱���͹�����Ӧ��������������Ӧ,��ǰ��ӦΪ:' || p_desc;
      END IF;
    END IF;
  
    IF p_coop_scope_temp.sharing_sup_code LIKE
       '%' || p_coop_scope_temp.inside_supplier_code || '%' THEN
      p_i   := p_i + 1;
      p_msg := p_msg || p_i || ')������Ӧ�̱��벻�ܰ�������';
    END IF;
  
    IF p_msg IS NOT NULL THEN
      UPDATE scmdata.t_coop_scope_temp t
         SET t.msg_type = 'E', t.msg = p_msg
       WHERE t.coop_scope_temp_id = p_coop_scope_temp_id;
    ELSE
      UPDATE scmdata.t_coop_scope_temp t
         SET t.msg_type = 'N', t.msg = NULL
       WHERE t.coop_scope_temp_id = p_coop_scope_temp_id;
    END IF;
  END check_importdatas_coop_scope;
  /*============================================*
  * Author   : zwh73
  * Created  : 2020-10-23 17:38:28
  * ALERTER  : 
  * ALERTER_TIME  : 
  * Purpose  :  EXCEL���� �ύ��Ӧ�̺�����Χ ����ʱ�����ύ��ҵ�����
  * Obj_Name    : submit_t_coop_scope_temp
  * Arg_Number  : 2
  * p_company_id :��ҵID
  * p_user_id ���û�ID
  *============================================*/
  PROCEDURE submit_t_coop_scope_temp(p_company_id IN VARCHAR2,
                                     p_user_id    IN VARCHAR2) IS
    p_code VARCHAR2(32);
    p_id   VARCHAR2(32);
  BEGIN
    FOR data_rec IN (SELECT *
                       FROM scmdata.t_coop_scope_temp t
                      WHERE t.company_id = p_company_id
                        AND t.create_id = p_user_id) LOOP
      IF data_rec.msg_type = 'E' OR data_rec.msg_type IS NULL THEN
        raise_application_error(-20002,
                                '���������Ƿ��Ѽ���ɹ����޸���ȷ�����ύ!');
      ELSE
        p_code := data_rec.inside_supplier_code;
        p_id   := f_get_uuid();
        INSERT INTO t_coop_scope
          (coop_scope_id,
           supplier_info_id,
           company_id,
           coop_mode,
           coop_classification,
           coop_product_cate,
           coop_subcategory,
           create_id,
           create_time,
           update_id,
           update_time,
           remarks,
           pause,
           sharing_type)
        VALUES
          (p_id,
           (SELECT supplier_info_id
              FROM t_supplier_info a
             WHERE a.inside_supplier_code = p_code
               AND a.company_id = data_rec.company_id),
           data_rec.company_id,
           data_rec.coop_mode,
           data_rec.coop_classification,
           data_rec.coop_product_cate,
           data_rec.coop_subcategory,
           data_rec.create_id,
           SYSDATE,
           data_rec.create_id,
           SYSDATE,
           NULL,
           0,
           data_rec.sharing_type);
        ---���Ϲ���
        IF data_rec.sharing_sup_code IS NOT NULL THEN
          FOR sup IN (SELECT regexp_substr(data_rec.sharing_sup_code,
                                           '[^;]+',
                                           1,
                                           LEVEL,
                                           'i') code
                        FROM dual
                      CONNECT BY LEVEL <=
                                 length(data_rec.sharing_sup_code) -
                                 length(regexp_replace(data_rec.sharing_sup_code,
                                                       ';',
                                                       '')) + 1) LOOP
            INSERT INTO scmdata.t_supplier_shared
              (supplier_shared_id,
               company_id,
               supplier_info_id,
               shared_supplier_code,
               remarks,
               coop_scope_id)
            VALUES
              (f_get_uuid(),
               data_rec.company_id,
               (SELECT a.supplier_info_id
                  FROM t_supplier_info a
                 WHERE a.inside_supplier_code =
                       data_rec.inside_supplier_code
                   AND a.company_id = data_rec.company_id),
               (SELECT a.supplier_code
                  FROM t_supplier_info a
                 WHERE a.inside_supplier_code = sup.code
                   AND a.company_id = data_rec.company_id),
               NULL,
               p_id);
          END LOOP;
        END IF;
      END IF;
    END LOOP;
  
    --���
    DELETE FROM scmdata.t_coop_scope_temp
     WHERE company_id = p_company_id
       AND create_id = p_user_id;
  END submit_t_coop_scope_temp;
  --У�������Χ  p_status�� IU ����/���� D ɾ��
  PROCEDURE check_coop_scopre(p_cp_data scmdata.t_coop_scope%ROWTYPE,
                              p_status  VARCHAR2) IS
    v_flag NUMBER := 0; --У���ظ�
    v_num  NUMBER := 0; --У���Ƿ�ֻʣ���һ��
  BEGIN
    IF p_status = 'IU' THEN
      --1) ����/���� У��������࣬��������𣬿ɺ�����Ʒ���಻���ظ�
      SELECT COUNT(1)
        INTO v_flag
        FROM t_coop_scope t
       WHERE t.company_id = p_cp_data.company_id
         AND t.supplier_info_id = p_cp_data.supplier_info_id
         AND t.coop_classification = p_cp_data.coop_classification
         AND t.coop_product_cate = p_cp_data.coop_product_cate
         AND t.coop_scope_id <> p_cp_data.coop_scope_id;
    
      IF v_flag > 0 THEN
        raise_application_error(-20002,
                                '�������ࡢ����������Ѿ����ڣ���������д��');
      END IF;
    ELSIF p_status = 'D' THEN
    
      --2) ɾ�� ��������Χֻ��1������ʱ������ɾ��
      SELECT COUNT(1)
        INTO v_num
        FROM t_coop_scope t
       WHERE t.company_id = p_cp_data.company_id
         AND t.supplier_info_id = p_cp_data.supplier_info_id;
    
      IF v_num = 1 THEN
        raise_application_error(-20002,
                                'ɾ��ʧ�ܣ�������Χ�����ٱ���1�����ݣ�');
      END IF;
    END IF;
  END check_coop_scopre;

  --����������Χ
  PROCEDURE insert_coop_scope(p_cp_data scmdata.t_coop_scope%ROWTYPE) IS
  BEGIN
    --У�������Χ  p_status�� IU ����/���� D ɾ��
    check_coop_scopre(p_cp_data => p_cp_data, p_status => 'IU');
  
    INSERT INTO t_coop_scope
      (coop_scope_id,
       supplier_info_id,
       company_id,
       coop_classification,
       coop_product_cate,
       coop_subcategory,
       create_id,
       create_time,
       update_id,
       update_time,
       remarks,
       pause,
       sharing_type,
       publish_id,
       publish_date)
    VALUES
      (p_cp_data.coop_scope_id,
       p_cp_data.supplier_info_id,
       p_cp_data.company_id,
       p_cp_data.coop_classification,
       p_cp_data.coop_product_cate,
       p_cp_data.coop_subcategory,
       p_cp_data.create_id,
       p_cp_data.create_time,
       p_cp_data.update_id,
       p_cp_data.update_time,
       p_cp_data.remarks,
       p_cp_data.pause,
       p_cp_data.sharing_type,
       p_cp_data.publish_id,
       p_cp_data.publish_date);
  
  END insert_coop_scope;
  --�޸ĺ�����Χ
  PROCEDURE update_coop_scope(p_cp_data scmdata.t_coop_scope%ROWTYPE) IS
  BEGIN
    --У�������Χ  p_status�� IU ����/���� D ɾ��
    check_coop_scopre(p_cp_data => p_cp_data, p_status => 'IU');
  
    UPDATE t_coop_scope t
       SET t.coop_classification = p_cp_data.coop_classification,
           t.coop_product_cate   = p_cp_data.coop_product_cate,
           t.coop_subcategory    = p_cp_data.coop_subcategory,
           t.update_id           = p_cp_data.update_id,
           t.update_time         = p_cp_data.update_time,
           t.sharing_type        = p_cp_data.sharing_type
     WHERE t.company_id = p_cp_data.company_id
       AND t.supplier_info_id = p_cp_data.supplier_info_id
       AND t.coop_scope_id = p_cp_data.coop_scope_id;
  
  END update_coop_scope;

  --ɾ��������Χ
  PROCEDURE delete_coop_scope(p_cp_data scmdata.t_coop_scope%ROWTYPE) IS
  BEGIN
    --У�������Χ  p_status�� IU ����/���� D ɾ��
    check_coop_scopre(p_cp_data => p_cp_data, p_status => 'D');
  
    DELETE FROM scmdata.t_supplier_shared t
     WHERE t.company_id = p_cp_data.company_id
       AND t.supplier_info_id = p_cp_data.supplier_info_id
       AND t.coop_scope_id = p_cp_data.coop_scope_id;
  
    DELETE FROM t_coop_scope t
     WHERE t.company_id = p_cp_data.company_id
       AND t.supplier_info_id = p_cp_data.supplier_info_id
       AND t.coop_scope_id = p_cp_data.coop_scope_id;
  
  END delete_coop_scope;

END pkg_supplier_info;
/
