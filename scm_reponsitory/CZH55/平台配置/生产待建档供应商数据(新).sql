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

  v_supply_id VARCHAR2(100);

  v_flag NUMBER;

  fask_rec scmdata.t_factory_ask%ROWTYPE;

  cinfo_rec scmdata.sys_company%ROWTYPE;

  faskrp_rec scmdata.t_factory_report%ROWTYPE;

  --�鳧���뵥 ���������Χ
  CURSOR fask_scope_cur(p_factory_ask_id VARCHAR2) IS
    SELECT t.*
      FROM scmdata.t_ask_scope t
     WHERE t.object_id = p_factory_ask_id
       AND t.object_type = 'CA';

  --�鳧���� ��������������ϸ
  CURSOR faskrp_ability_cur(p_factory_ask_id VARCHAR2) IS
    SELECT ra.*
      FROM scmdata.t_factory_report fr, scmdata.t_factory_report_ability ra
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
       sharing_type,
       supplier_info_origin,
       pause,
       status,
       bind_status,
       supplier_company_name,
       supplier_company_abbreviation,
       social_credit_code,
       company_contact_person,
       company_contact_phone,
       cooperation_type,
       create_id,
       create_date,
       update_id,
       update_date)
    VALUES
      (v_supply_id,
       v_company_id,
       fask_rec.factory_ask_id,
       fask_rec.cooperation_company_id,
       '00',
       'AA',
       0,
       0,
       1,
       fask_rec.company_name,
       fask_rec.company_name,
       fask_rec.social_credit_code,
       fask_rec.contact_name,
       fask_rec.contact_phone,
       fask_rec.cooperation_type,
       p_user_id,
       SYSDATE,
       p_user_id,
       SYSDATE);
    --2��������Χȡ=�����������Χ
    FOR fscope_rec IN fask_scope_cur LOOP
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
         fscope_rec.production_mode,
         fscope_rec.cooperation_subcategory,
         fscope_rec.create_id,
         fscope_rec.create_time,
         fscope_rec.update_id,
         fscope_rec.update_time,
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
         sharing_type,
         supplier_info_origin,
         pause,
         status,
         bind_status,
         supplier_company_name,
         supplier_company_abbreviation,
         social_credit_code,
         company_contact_person,
         company_contact_phone,
         cooperation_type,
         create_id,
         create_date,
         update_id,
         update_date)
      VALUES
        (v_supply_id,
         v_company_id,
         fask_rec.factory_ask_id,
         fask_rec.cooperation_company_id,
         '00',
         'AA',
         0,
         0,
         1,
         fask_rec.company_name,
         fask_rec.company_name,
         fask_rec.social_credit_code,
         fask_rec.contact_name,
         fask_rec.contact_phone,
         fask_rec.cooperation_type,
         p_user_id,
         SYSDATE,
         p_user_id,
         SYSDATE);
    
      --2��������Χȡ =���鳧���� ��������������ϸ(����)
      FOR faskrp_ability_rec IN faskrp_ability_cur(fask_rec.factory_ask_id) LOOP
        --ֻ����������������ϸ(����)���ܽ��������Χ
        IF faskrp_ability_rec.ability_result = '����' THEN
          --����������ϸ
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
             faskrp_ability_rec.cooperation_classification,
             faskrp_ability_rec.cooperation_product_cate,
             faskrp_ability_rec.cooperation_subcategory,
             faskrp_ability_rec.create_id,
             faskrp_ability_rec.create_time,
             faskrp_ability_rec.update_id,
             faskrp_ability_rec.update_time,
             '',
             0,
             '00');
        ELSE
          NULL;
        END IF;
      END LOOP;
    
    ELSE
      NULL;
    END IF;
  END IF;
END create_t_supplier_info;
