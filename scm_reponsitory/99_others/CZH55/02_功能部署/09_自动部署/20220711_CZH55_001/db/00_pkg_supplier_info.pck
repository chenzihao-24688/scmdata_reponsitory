CREATE OR REPLACE PACKAGE scmdata.pkg_supplier_info IS

  -- Author  : SANFU
  -- Created : 2020/11/6 14:52:03
  -- Purpose :
  ----------------------------------------------------  ���ô���   begin  ----------------------------------------------------------------------------
  --Query
  --��Ӧ�̹���
  --������
  FUNCTION f_query_unfile_supp_info RETURN CLOB;
  --�ѽ���
  FUNCTION f_query_filed_supp_info RETURN CLOB;
  --����״̬
  FUNCTION f_query_coop_status_looksql(p_coop_status_field VARCHAR2,
                                       p_suffix            VARCHAR2)
    RETURN CLOB;

  --��ȡ��֯�ܹ� ��Ա��Ϣ
  FUNCTION f_query_person_info_looksql(p_person_field VARCHAR2,
                                       p_suffix       VARCHAR2,
                                       p_coop_type    VARCHAR2,
                                       p_coop_cate    VARCHAR2) RETURN CLOB;

  --��ȡ��֯�ܹ� ��Ա��Ϣ pick
  FUNCTION f_query_person_info_pick(p_person_field VARCHAR2,
                                    p_suffix       VARCHAR2) RETURN CLOB;

  --������Χ  begin
  --select_sql
  FUNCTION f_query_sup_coop_list(p_item_id VARCHAR2) RETURN CLOB;
  --insert sql
  FUNCTION f_insert_sup_coop_list(p_item_id VARCHAR2) RETURN CLOB;
  --update sql
  FUNCTION f_update_sup_coop_list(p_item_id VARCHAR2) RETURN CLOB;
  --delete sql
  FUNCTION f_delete_sup_coop_list(p_item_id VARCHAR2) RETURN CLOB;
  --������Χ  end
  --�������� begin 'a_supp_151_7'
  --select_sql
  FUNCTION f_query_coop_factory_list(p_item_id VARCHAR2) RETURN CLOB;
  --insert sql
  FUNCTION f_insert_coop_factory_list(p_item_id VARCHAR2) RETURN CLOB;
  --��ȡ�������� pick
  FUNCTION f_query_coop_factory_pick(p_item_id VARCHAR2) RETURN CLOB;
  --������������
  FUNCTION f_query_fac_type_looksql(p_fac_type_field VARCHAR2,
                                    p_suffix         VARCHAR2) RETURN CLOB;
  --���� ͣ�� ��ť
  PROCEDURE p_coop_fac_pause(p_company_id      VARCHAR2,
                             p_coop_factory_id VARCHAR2,
                             p_user_id         VARCHAR2,
                             p_status          VARCHAR2);
  --���º�������״̬
  PROCEDURE update_coop_fac_status(p_company_id VARCHAR2,
                                   p_sup_id     VARCHAR2,
                                   p_fac_id     VARCHAR2 DEFAULT NULL,
                                   p_status     NUMBER,
                                   p_pause_type VARCHAR2);
  --��Ӧ���빤��������ϵ ��ͣ״̬У��
  --��Ӧ��/���� ��ͣ��ť����
  PROCEDURE p_check_sup_fac_pause(p_company_id VARCHAR2, p_sup_id VARCHAR2);

  --��Ӧ�̵ĺ�����Χ�빤��������ϵ ��ͣ״̬У��
  PROCEDURE p_check_coop_fac_pause(p_company_id VARCHAR2,
                                   p_sup_id     VARCHAR2,
                                   p_type       VARCHAR2);

  --�������� end
  ----------------------------------------------------  ���ô���   end  ----------------------------------------------------------------------------

  ----------------------------------------------------  ҵ�����   begin  ---------------------------------------------------------------------------
  --������������
  PROCEDURE p_insert_coop_factory(p_fac_rec scmdata.t_coop_factory%ROWTYPE);
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
  PROCEDURE check_t_supplier_info(p_supplier_info_id VARCHAR2);
  --У��ͳһ���ô���
  PROCEDURE p_check_social_credit_code(p_company_id         VARCHAR2,
                                       p_supplier_info_id   VARCHAR2,
                                       p_social_credit_code VARCHAR2);
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

  PROCEDURE check_save_t_supplier_info(p_sp_data scmdata.t_supplier_info%ROWTYPE);
  --У�鹤����Ϣ
  /*  FUNCTION check_fask_data(p_company_id       VARCHAR2,
  p_factory_ask_id   VARCHAR2,
  p_com_manufacturer VARCHAR2) RETURN NUMBER;*/

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

  --ͨ������ �ֲ���ȡ��������id
  FUNCTION f_get_category_config_by_pick(p_company_id VARCHAR2,
                                         p_supp_id    VARCHAR2,
                                         p_province   VARCHAR2,
                                         p_city       VARCHAR2)
    RETURN VARCHAR2;

  --����ʱ ͨ������Ʒ�� ��ȡ���ڷ��� 
  FUNCTION f_get_category_config(p_company_id VARCHAR2, p_supp_id VARCHAR2)
    RETURN VARCHAR2;

  --ͨ����������  ��ȡ���ڷ���
  /*  FUNCTION get_area_config(p_company_id VARCHAR2, p_supp_id VARCHAR2)
  RETURN VARCHAR2;*/

  --��ȡ����
  --���ڷ�����ݹ�Ӧ�̵�Ʒ�ࡢ���򣬴����ڷ���������ƥ�䣬�Զ���ȡ��Ӧ���飻
  FUNCTION f_get_group_config_id(p_company_id VARCHAR2,
                                 p_supp_id    VARCHAR2,
                                 p_is_by_pick INT DEFAULT 0,
                                 p_province   VARCHAR2 DEFAULT NULL,
                                 p_city       VARCHAR2 DEFAULT NULL)
    RETURN VARCHAR2;
  --��ȡ����
  FUNCTION f_get_group_name(p_company_id      VARCHAR2,
                            p_group_config_id VARCHAR2) RETURN VARCHAR2;
  --�����������ڷ���
  PROCEDURE p_batch_update_group_name(p_company_id VARCHAR2,
                                      p_is_trigger INT DEFAULT 0,
                                      p_pause      INT DEFAULT 1,
                                      p_is_by_pick INT DEFAULT 0);
  --������������ �����鳤
  PROCEDURE p_update_group_name(p_company_id       VARCHAR2,
                                p_supplier_info_id VARCHAR2,
                                p_is_create_sup    INT DEFAULT 0,
                                p_is_trigger       INT DEFAULT 0,
                                p_pause            INT DEFAULT 1,
                                p_is_by_pick       INT DEFAULT 0,
                                p_province         VARCHAR2 DEFAULT NULL,
                                p_city             VARCHAR2 DEFAULT NULL);

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

  PROCEDURE create_t_supplier_info(p_company_id      VARCHAR2,
                                   p_factory_ask_id  VARCHAR2,
                                   p_user_id         VARCHAR2,
                                   p_is_trialorder   NUMBER,
                                   p_trialorder_type VARCHAR2);

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

  PROCEDURE insert_supplier_info(p_sp_data scmdata.t_supplier_info%ROWTYPE);
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

  PROCEDURE update_supplier_info(p_sp_data t_supplier_info%ROWTYPE,
                                 p_item_id VARCHAR2 DEFAULT NULL);

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
  /*У���ͬ��������*/
  PROCEDURE check_import_constract(p_temp_id IN VARCHAR2);
  /*�ύ��������ĺ�ͬ*/

  PROCEDURE submit_t_contract_info(p_company_id IN VARCHAR2,
                                   p_user_id    IN VARCHAR2);
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
  PROCEDURE insert_coop_scope(p_cp_data scmdata.t_coop_scope%ROWTYPE,
                              p_type    NUMBER DEFAULT 1);
  --�޸ĺ�����Χ
  PROCEDURE update_coop_scope(p_cp_data scmdata.t_coop_scope%ROWTYPE);
  --ɾ��������Χ
  PROCEDURE delete_coop_scope(p_cp_data scmdata.t_coop_scope%ROWTYPE);
  --��ȡ��Ӧ������
  --FUNCTION get_supp_batch_id(pi_company_id VARCHAR2) RETURN VARCHAR2;
  --����������Ӧ��
  PROCEDURE insert_supplier_shared(scope_rec       scmdata.t_coop_scope%ROWTYPE,
                                   p_supplier_code VARCHAR2);
  --ɾ��������Ӧ��
  PROCEDURE delete_supplier_shared(p_supplier_shared_id VARCHAR2);

  --��ȡ��Ӧ����״̬
  PROCEDURE get_supp_oper_status(p_factory_ask_id VARCHAR2,
                                 po_flow_status   OUT VARCHAR2,
                                 po_flow_node     OUT VARCHAR2);
  --��Ӧ���� ������΢�����˷�����Ϣ
  FUNCTION send_fac_wx_msg(p_company_id     VARCHAR2,
                           p_factory_ask_id VARCHAR2,
                           p_msgtype        VARCHAR2, --��Ϣ���� text��markdown
                           p_msg_title      VARCHAR2, --��Ϣ����
                           p_bot_key        VARCHAR2, --������key
                           p_robot_type     VARCHAR2 --��������������
                           ) RETURN CLOB;
  ----------------------------------------------------  ҵ�����   end  ---------------------------------------------------------------------------
END pkg_supplier_info;
/
CREATE OR REPLACE PACKAGE BODY scmdata.pkg_supplier_info IS
  ----------------------------------------------------  ���ô���   begin  ----------------------------------------------------------------------------
  --Query
  --��Ӧ�̹���
  --������
  FUNCTION f_query_unfile_supp_info RETURN CLOB IS
    v_query_sql CLOB;
  BEGIN
    v_query_sql := q'[--�Ż���Ĳ�ѯ����
WITH dic AS
 (SELECT group_dict_value,
         group_dict_name,
         group_dict_type,
         group_dict_id,
         parent_id,
         pause
    FROM scmdata.sys_group_dict
   WHERE pause = 0)
SELECT v.supplier_info_id,
       v.company_id,
       v.status,
       v.pause coop_status,
       v.supplier_code,
       v.inside_supplier_code,
       v.supplier_company_id,
       v.supplier_company_name,
       v.supplier_company_abbreviation,
       nvl(v.cooperation_classification_sp, '') cooperation_classification_sp, --�������ࣺ���鳧ȡ���뵥�����ݣ��鳧ȡ�����Լ�����������ϸ��
       v.cooperation_model_sp,
       v.company_type,
       v.cooperation_method_sp,
       v.production_mode_sp,
       v.ask_date,
       v.check_date,
       v.create_supp_date,
       v.social_credit_code,
       v.cooperation_type_sp,
       v.fa_contact_name,
       v.fa_contact_phone,
       v.supplier_info_origin,
       v.supplier_info_origin_id factory_ask_id,
       CASE
         WHEN fa.is_urgent = '1' THEN
          10090495
         ELSE
          NULL
       END gridbackcolor
  FROM (SELECT e.group_dict_name supplier_info_origin,
               sp.status,
               sp.pause,
               sp.supplier_code,
               sp.inside_supplier_code,
               sp.supplier_company_name,
               sp.supplier_company_abbreviation,
               ar.ask_date,
               fr.check_date,
               sp.create_supp_date,
               sp.social_credit_code,
               sp.regist_address,
               sp.legal_representative,
               sp.company_create_date,
               sp.regist_price,
               a.group_dict_name cooperation_type_sp,
               va.coop_classification,
               (SELECT listagg(DISTINCT t.group_dict_name, ';') within GROUP(ORDER BY t.group_dict_value)
                  FROM dic t
                 WHERE t.group_dict_type = sp.cooperation_type
                   AND instr(';' || va.coop_classification || ';',
                             ';' || t.group_dict_value || ';') > 0) cooperation_classification_sp,
               b.group_dict_name cooperation_method_sp,
               (SELECT listagg(group_dict_name, ';') within GROUP(ORDER BY group_dict_value)
                  FROM dic
                 WHERE group_dict_type = 'SUPPLY_TYPE'
                   AND instr(';' || sp.cooperation_model || ';',
                             ';' || group_dict_value || ';') > 0) cooperation_model_sp,
               d.group_dict_name production_mode_sp,
               sp.fa_contact_name,
               sp.fa_contact_phone,
               sp.create_date,
               sp.supplier_info_origin_id,
               sp.cooperation_type,
               sp.supplier_info_id,
               sp.supplier_company_id,
               sp.company_id,
               f.group_dict_name company_type
          FROM scmdata.t_supplier_info sp
          LEFT JOIN scmdata.t_factory_ask fa
            ON sp.supplier_info_origin_id = fa.factory_ask_id
          LEFT JOIN scmdata.t_factory_report fr
            ON fa.factory_ask_id = fr.factory_ask_id
          LEFT JOIN scmdata.t_ask_record ar
            ON fa.ask_record_id = ar.ask_record_id
          LEFT JOIN scmdata.sys_group_dict e
            ON e.group_dict_type = 'ORIGIN_TYPE'
           AND e.group_dict_value = sp.supplier_info_origin
          LEFT JOIN dic a
            ON a.group_dict_type = 'COOPERATION_TYPE'
           AND sp.cooperation_type = a.group_dict_value
          LEFT JOIN dic b
            ON b.group_dict_type = 'COOP_METHOD'
           AND b.group_dict_value = sp.cooperation_method
          LEFT JOIN dic d
            ON d.group_dict_type = 'CPMODE_TYPE'
           AND d.group_dict_value = sp.production_mode
          LEFT JOIN dic f
            ON f.group_dict_type = 'COMPANY_TYPE'
           AND f.group_dict_value = sp.company_type
          LEFT JOIN (SELECT listagg(DISTINCT sa.coop_classification, ';') within GROUP(ORDER BY sa.coop_classification) coop_classification,
                            sa.supplier_info_id,
                            sa.company_id
                      FROM scmdata.t_coop_scope sa
                     WHERE sa.pause = 0
                     GROUP BY sa.supplier_info_id, sa.company_id) va
            ON va.supplier_info_id = sp.supplier_info_id
           AND va.company_id = sp.company_id
         WHERE sp.company_id = %default_company_id%
           AND sp.status = 0
           AND sp.supplier_info_origin <> 'II') v --�Ȳ�չʾ�ӿڵ��������
  LEFT JOIN scmdata.t_factory_ask fa
    ON fa.factory_ask_id = v.supplier_info_origin_id
 WHERE ((%is_company_admin% = 1) OR
       instr_priv(p_str1  => @subsql@,
                   p_str2  => v.coop_classification,
                   p_split => ';') > 0)
 ORDER BY nvl(fa.is_urgent, 0) DESC,
          v.create_date DESC,
          v.supplier_info_id DESC
]';
    RETURN v_query_sql;
  END f_query_unfile_supp_info;

  --�ѽ���
  FUNCTION f_query_filed_supp_info RETURN CLOB IS
    v_query_sql CLOB;
  BEGIN
    v_query_sql := q'[
--�Ż���Ĳ�ѯ����
--��������Ȩ�޺���
WITH dic AS
 (SELECT group_dict_value,
         group_dict_name,
         group_dict_type,
         group_dict_id,
         parent_id,
         pause
    FROM scmdata.sys_group_dict
   WHERE pause = 0)
SELECT v.supplier_info_id,
       v.company_id,
       v.status,
       v.pause coop_status,
       v.supplier_code,
       v.inside_supplier_code,
       v.supplier_company_id,
       v.supplier_company_name,
       v.supplier_company_abbreviation,
       nvl(v.cooperation_classification_sp, '') cooperation_classification_sp, --�������ࣺ���鳧ȡ���뵥�����ݣ��鳧ȡ�����Լ�����������ϸ��
       v.cooperation_model_sp,
       v.group_name,
       v.flw_order,
       v.company_type,
       v.cooperation_method_sp,
       v.production_mode_sp,
       v.ask_date,
       v.check_date,
       v.create_supp_date,
       v.social_credit_code,
       v.cooperation_type_sp,
       v.regist_status,
       v.bind_status,
       v.fa_contact_name,
       v.fa_contact_phone,
       v.supplier_info_origin,
       v.supplier_info_origin_id factory_ask_id
  FROM (SELECT e.group_dict_name supplier_info_origin,
               sp.status,
               sp.pause,
               nvl2(sp.supplier_company_id, '��ע��', 'δע��') regist_status,
               sp.bind_status,
               sp.supplier_code,
               sp.inside_supplier_code,
               sp.supplier_company_name,
               sp.supplier_company_abbreviation,
               ar.ask_date,
               fr.check_date,
               sp.create_supp_date,
               sp.social_credit_code,
               sp.regist_address,
               sp.legal_representative,
               sp.company_create_date,
               sp.regist_price,
               a.group_dict_name cooperation_type_sp,
               va.coop_classification,
               (SELECT listagg(DISTINCT t.group_dict_name, ';') within GROUP(ORDER BY t.group_dict_value)
                  FROM dic t
                 WHERE t.group_dict_type = sp.cooperation_type
                   AND instr(';' || va.coop_classification || ';',
                             ';' || t.group_dict_value || ';') > 0) cooperation_classification_sp,
               b.group_dict_name cooperation_method_sp,
               (SELECT listagg(group_dict_name, ';') within GROUP(ORDER BY group_dict_value)
                  FROM dic
                 WHERE group_dict_type = 'SUPPLY_TYPE'
                   AND instr(';' || sp.cooperation_model || ';',
                             ';' || group_dict_value || ';') > 0) cooperation_model_sp,
               (SELECT listagg(fu_a.company_user_name, ',')
                  FROM scmdata.sys_company_user fu_a
                 WHERE fu_a.company_id = sp.company_id
                   AND instr(',' || sp.gendan_perid || ',',
                             ',' || fu_a.user_id || ',') > 0) flw_order,
               d.group_dict_name production_mode_sp,
               sp.fa_contact_name,
               sp.fa_contact_phone,
               sp.create_date,
               sp.supplier_info_origin_id,
               sp.cooperation_type,
               sp.supplier_info_id,
               sp.supplier_company_id,
               sp.company_id,
               f.group_dict_name company_type,
               sp.group_name
          FROM scmdata.t_supplier_info sp
          LEFT JOIN scmdata.t_factory_ask fa
            ON sp.supplier_info_origin_id = fa.factory_ask_id
          LEFT JOIN scmdata.t_factory_report fr
            ON fa.factory_ask_id = fr.factory_ask_id
          LEFT JOIN scmdata.t_ask_record ar
            ON fa.ask_record_id = ar.ask_record_id
          LEFT JOIN scmdata.sys_company fc
            ON sp.social_credit_code = fc.licence_num
          LEFT JOIN dic e
            ON e.group_dict_type = 'ORIGIN_TYPE'
           AND e.group_dict_value = sp.supplier_info_origin
          LEFT JOIN dic a
            ON a.group_dict_type = 'COOPERATION_TYPE'
           AND sp.cooperation_type = a.group_dict_value
          LEFT JOIN dic b
            ON b.group_dict_type = 'COOP_METHOD'
           AND b.group_dict_value = sp.cooperation_method
          LEFT JOIN dic d
            ON d.group_dict_type = 'CPMODE_TYPE'
           AND d.group_dict_value = sp.production_mode
          LEFT JOIN dic f
            ON f.group_dict_type = 'COMPANY_TYPE'
           AND f.group_dict_value = sp.company_type
          LEFT JOIN (SELECT listagg(DISTINCT sa.coop_classification, ';') within GROUP(ORDER BY sa.coop_classification) coop_classification,
                            sa.supplier_info_id,
                            sa.company_id
                      FROM scmdata.t_coop_scope sa
                     WHERE sa.pause = 0
                     GROUP BY sa.supplier_info_id, sa.company_id) va
            ON va.supplier_info_id = sp.supplier_info_id
           AND va.company_id = sp.company_id
         WHERE sp.company_id = %default_company_id%
           AND sp.status = 1
           AND sp.supplier_info_origin <> 'II') v --�Ȳ�չʾ�ӿڵ��������
  LEFT JOIN scmdata.t_factory_ask fa
    ON fa.factory_ask_id = v.supplier_info_origin_id
 WHERE ((%is_company_admin% = 1) OR
       instr_priv(p_str1  => @subsql@,
                   p_str2  => v.coop_classification,
                   p_split => ';') > 0)
 ORDER BY v.create_date DESC, v.supplier_info_id DESC
]';
    RETURN v_query_sql;
  END f_query_filed_supp_info;

  --����״̬
  FUNCTION f_query_coop_status_looksql(p_coop_status_field VARCHAR2,
                                       p_suffix            VARCHAR2)
    RETURN CLOB IS
    v_query_sql CLOB;
  BEGIN
    v_query_sql := 'SELECT t.group_dict_value ' || p_coop_status_field ||
                   ', t.group_dict_name ' || p_coop_status_field ||
                   p_suffix || '
      FROM scmdata.sys_group_dict t
     WHERE t.group_dict_type = ''COOP_STATUS''
     ORDER BY t.group_dict_sort asc';
    RETURN v_query_sql;
  END f_query_coop_status_looksql;

  --��ȡ��֯�ܹ� ָ������Ա ��Ϣ lookup
  FUNCTION f_query_person_info_looksql(p_person_field VARCHAR2,
                                       p_suffix       VARCHAR2,
                                       p_coop_type    VARCHAR2,
                                       p_coop_cate    VARCHAR2) RETURN CLOB IS
    v_query_sql CLOB;
  BEGIN
  
    v_query_sql := 'SELECT /*d.dept_name,b.avatar,*/ DISTINCT a.user_id ' ||
                   p_person_field || ', a.company_user_name ' ||
                   p_person_field || p_suffix || '
      FROM sys_company_user a
  INNER JOIN sys_user b
    ON a.user_id = b.user_id
  LEFT JOIN sys_company_user_dept c
    ON a.user_id = c.user_id
   AND a.company_id = c.company_id
  LEFT JOIN sys_company_dept d
    ON c.company_dept_id = d.company_dept_id
   AND c.company_id = d.company_id
  LEFT JOIN scmdata.sys_company_dept_cate_map e
    ON d.company_id = e.company_id
   AND d.company_dept_id = e.company_dept_id
  INNER JOIN scmdata.sys_company_job f 
   ON f.job_id  = a.job_id
   AND f.company_id = a.company_id
   AND f.company_job_id IN (''1001005003005002001'',''1001005003005002'')
 WHERE a.company_id = %default_company_id%
   AND e.cooperation_type = ''' || p_coop_type || '''
   AND instr(''' || p_coop_cate || ''', e.cooperation_classification) > 0
   AND a.pause = 0
   AND b.pause = 0
   AND e.pause = 0';
    RETURN v_query_sql;
  
  END f_query_person_info_looksql;

  --��ȡ��֯�ܹ� ��Ա��Ϣ pick
  FUNCTION f_query_person_info_pick(p_person_field VARCHAR2,
                                    p_suffix       VARCHAR2) RETURN CLOB IS
    v_query_sql CLOB;
  BEGIN
    v_query_sql := 'SELECT d.dept_name, b.avatar, a.user_id ' ||
                   p_person_field || ', a.company_user_name ' ||
                   p_person_field || p_suffix || ' ,a.phone ' ||
                   p_person_field || '_phone' || '
  FROM sys_company_user a
 INNER JOIN sys_user b
    ON a.user_id = b.user_id
  LEFT JOIN sys_company_user_dept c
    ON a.user_id = c.user_id
   AND a.company_id = c.company_id
  LEFT JOIN sys_company_dept d
    ON c.company_dept_id = d.company_dept_id
   AND c.company_id = d.company_id
 WHERE a.company_id = %default_company_id%
   AND a.pause = 0
   AND b.pause = 0';
    RETURN v_query_sql;
  END f_query_person_info_pick;

  --������Χ  begin  'a_supp_151_1', 'a_supp_161_1', 'a_supp_171_1'
  --select_sql
  FUNCTION f_query_sup_coop_list(p_item_id VARCHAR2) RETURN CLOB IS
    v_query_sql CLOB;
  BEGIN
    v_query_sql := q'[SELECT tc.coop_scope_id,
       tc.pause,
       tc.coop_classification,
       a.group_dict_name coop_classification_desc,
       tc.coop_product_cate,
       b.group_dict_name coop_product_cate_desc,
       tc.coop_subcategory,
       (SELECT listagg(c.company_dict_name, ';')
          FROM scmdata.sys_company_dict c
         WHERE c.company_id = %default_company_id%
           AND c.company_dict_type = b.group_dict_value
           AND instr(';' || tc.coop_subcategory || ';',
                     ';' || c.company_dict_value || ';') > 0) coop_subcategory_desc
  FROM scmdata.t_coop_scope tc
 INNER JOIN scmdata.sys_group_dict a
    ON tc.coop_classification = a.group_dict_value
   AND a.group_dict_type = 'PRODUCT_TYPE'
 INNER JOIN scmdata.sys_group_dict b
    ON b.group_dict_type = a.group_dict_value
   AND tc.coop_product_cate = b.group_dict_value
 WHERE tc.supplier_info_id = :supplier_info_id
   AND tc.company_id = %default_company_id%
   ORDER BY tc.create_time asc]';
    IF p_item_id IN ('a_supp_151_1', 'a_supp_161_1', 'a_supp_171_1') THEN
      RETURN v_query_sql;
    ELSE
      RETURN NULL;
    END IF;
  END f_query_sup_coop_list;
  --insert sql
  FUNCTION f_insert_sup_coop_list(p_item_id VARCHAR2) RETURN CLOB IS
    v_insert_sql CLOB;
  BEGIN
    v_insert_sql := q'[DECLARE
  p_cp_data scmdata.t_coop_scope%ROWTYPE;
BEGIN
  p_cp_data.coop_scope_id       := scmdata.f_get_uuid();
  p_cp_data.supplier_info_id    := :supplier_info_id;
  p_cp_data.company_id          := %default_company_id%;
  p_cp_data.coop_classification := :coop_classification;
  p_cp_data.coop_product_cate   := :coop_product_cate;
  p_cp_data.coop_subcategory    := :coop_subcategory;
  p_cp_data.create_id           := %user_id%;
  p_cp_data.create_time         := SYSDATE;
  p_cp_data.update_id           := %user_id%;
  p_cp_data.update_time         := SYSDATE;
  p_cp_data.remarks             := '';
  p_cp_data.pause               := 0;
  p_cp_data.sharing_type        := :sharing_type;
  p_cp_data.publish_id          := '';
  p_cp_data.publish_date        := '';

  IF p_cp_data.coop_product_cate IS NULL THEN RAISE_APPLICATION_ERROR(-20002, '���������Ϊ�գ�����д');
  ELSIF p_cp_data.coop_subcategory IS NULL THEN RAISE_APPLICATION_ERROR(-20002, '������Ʒ���಻��Ϊ�գ�����д');
  ELSE
  scmdata.pkg_supplier_info.insert_coop_scope(p_cp_data => p_cp_data);
  END IF;]' || CASE
                      WHEN p_item_id = 'a_supp_161_1' THEN
                       q'[
  --2.ͬ�����º�������-������ϵ
  pkg_supplier_info.p_check_sup_fac_pause(p_company_id => %default_company_id%,p_sup_id => :supplier_info_id);
  --3.������־����
  --scmdata.pkg_supplier_info.insert_oper_log(:supplier_info_id,'�޸ĵ���-����������Χ','',%user_id%,%default_company_id%,SYSDATE);

  --ZC314ADD
  SCMDATA.PKG_CAPACITY_INQUEUE.P_COMMON_INQUEUE(V_CURUSERID  => %CURRENT_USERID%,
                                                V_COMPID     => %DEFAULT_COMPANY_ID%,
                                                V_TAB        => 'SCMDATA.T_COOP_SCOPE',
                                                V_VIEWTAB    => NULL,
                                                V_UNQFIELDS  => 'COOP_SCOPE_ID,COMPANY_ID',
                                                V_CKFIELDS   => 'COOP_CLASSIFICATION,COOP_PRODUCT_CATE,COOP_SUBCATEGORY,PAUSE,CREATE_ID,CREATE_TIME',
                                                V_CONDS      => 'COOP_SCOPE_ID = '''||p_cp_data.coop_scope_id||''' AND COMPANY_ID = '''||%DEFAULT_COMPANY_ID%||'''',
                                                V_METHOD     => 'INS',
                                                V_VIEWLOGIC  => NULL,
                                                V_QUEUETYPE  => 'CAPC_SUPFILE_COOPSCOPEINFO_IU');]'
                      ELSE
                       NULL
                    END || q'[
END;]';
    IF p_item_id IN ('a_supp_151_1', 'a_supp_161_1', 'a_supp_171_1') THEN
      RETURN v_insert_sql;
    ELSE
      RETURN NULL;
    END IF;
  END f_insert_sup_coop_list;
  --update sql
  FUNCTION f_update_sup_coop_list(p_item_id VARCHAR2) RETURN CLOB IS
    v_update_sql CLOB;
  BEGIN
    v_update_sql := q'[DECLARE
  p_cp_data scmdata.t_coop_scope%ROWTYPE;
  --v_company_province VARCHAR2(32); 
  --v_company_city VARCHAR2(32);
BEGIN
  p_cp_data.coop_scope_id       := :coop_scope_id;
  p_cp_data.supplier_info_id    := :supplier_info_id;
  p_cp_data.company_id          := %default_company_id%;
  p_cp_data.coop_classification := :coop_classification;
  p_cp_data.coop_product_cate   := :coop_product_cate;
  p_cp_data.coop_subcategory    := :coop_subcategory;
  p_cp_data.update_id           := %user_id%;
  p_cp_data.update_time         := SYSDATE;
  IF p_cp_data.coop_product_cate IS NULL THEN RAISE_APPLICATION_ERROR(-20002, '���������Ϊ�գ�����д');
  ELSIF p_cp_data.coop_subcategory IS NULL THEN RAISE_APPLICATION_ERROR(-20002, '������Ʒ���಻��Ϊ�գ�����д');
  ELSE
  scmdata.pkg_supplier_info.update_coop_scope(p_cp_data => p_cp_data);
  END IF;
  --1.�������ڷ���
  /*SELECT sp.company_province, sp.company_city
    INTO v_company_province, v_company_city
    FROM scmdata.t_supplier_info sp
   WHERE sp.supplier_info_id = :supplier_info_id
     AND sp.company_id = %default_company_id%;

  --�������ڷ��飬�����鳤
  pkg_supplier_info.p_update_group_name(p_company_id       => %default_company_id%,
                                        p_supplier_info_id => :supplier_info_id,
                                        p_is_by_pick       => 1,
                                        p_province         => v_company_province,
                                        p_city             => v_company_city);*/]' || CASE
                      WHEN p_item_id = 'a_supp_161_1' THEN
                       q'[
  --2.ͬ�����º�������-������ϵ
  pkg_supplier_info.p_check_sup_fac_pause(p_company_id => %default_company_id%,p_sup_id => :supplier_info_id);
  --3.������־����
  --scmdata.pkg_supplier_info.insert_oper_log(:supplier_info_id,'�޸ĵ���-�޸ĺ�����Χ','',%user_id%,%default_company_id%,SYSDATE);

  --ZC314 ADD
  SCMDATA.PKG_CAPACITY_INQUEUE.P_COMMON_INQUEUE(V_CURUSERID  => %CURRENT_USERID%,
                                                V_COMPID     => %DEFAULT_COMPANY_ID%,
                                                V_TAB        => 'SCMDATA.T_COOP_SCOPE',
                                                V_VIEWTAB    => NULL,
                                                V_UNQFIELDS  => 'COOP_SCOPE_ID,COMPANY_ID',
                                                V_CKFIELDS   => 'COOP_CLASSIFICATION,COOP_PRODUCT_CATE,COOP_SUBCATEGORY,PAUSE,UPDATE_ID,UPDATE_TIME',
                                                V_CONDS      => 'COOP_SCOPE_ID = '''||:COOP_SCOPE_ID||''' AND COMPANY_ID = '''||%DEFAULT_COMPANY_ID%||'''',
                                                V_METHOD     => 'UPD',
                                                V_VIEWLOGIC  => NULL,
                                                V_QUEUETYPE  => 'CAPC_SUPFILE_COOPSCOPEINFO_IU');]'
                      ELSE
                       NULL
                    END || q'[
END;]';
    IF p_item_id IN ('a_supp_151_1', 'a_supp_161_1', 'a_supp_171_1') THEN
      RETURN v_update_sql;
    ELSE
      RETURN NULL;
    END IF;
  END f_update_sup_coop_list;

  --delete sql
  FUNCTION f_delete_sup_coop_list(p_item_id VARCHAR2) RETURN CLOB IS
    v_delete_sql CLOB;
  BEGIN
    v_delete_sql := q'[DECLARE
  p_cp_data scmdata.t_coop_scope%ROWTYPE;
BEGIN
  p_cp_data.coop_scope_id       := :coop_scope_id;
  p_cp_data.supplier_info_id    := :supplier_info_id;
  p_cp_data.company_id          := %default_company_id%;
  scmdata.pkg_supplier_info.delete_coop_scope(p_cp_data => p_cp_data);
  --�������ڷ��飬�����鳤
  pkg_supplier_info.p_update_group_name(p_company_id  => %default_company_id%,p_supplier_info_id => :supplier_info_id);
END;]';
    IF p_item_id IN ('a_supp_151_1', 'a_supp_161_1', 'a_supp_171_1') THEN
      RETURN v_delete_sql;
    ELSE
      RETURN NULL;
    END IF;
  END f_delete_sup_coop_list;
  --������Χ  end

  --�������� begin 'a_supp_151_7'
  --select_sql
  FUNCTION f_query_coop_factory_list(p_item_id VARCHAR2) RETURN CLOB IS
    v_query_sql CLOB;
  BEGIN
    v_query_sql := q'[WITH group_dict AS
 (SELECT t.group_dict_type,
         t.group_dict_value,
         t.group_dict_name,
         t.group_dict_id,
         t.parent_id
    FROM scmdata.sys_group_dict t
   WHERE t.pause = 0)
   SELECT f.coop_factory_id,
       f.supplier_info_id,
       f.fac_sup_info_id,
       f.company_id,
       sp.SUPPLIER_CODE supplier_code,
       sp.SUPPLIER_COMPANY_NAME factory_name,
       f.factory_type coop_factory_type,
       decode(f.pause, 1, 1, 0) coop_status,
       sp.worker_num,
       sp.machine_num,
       sp.product_efficiency,
       sp.work_hours_day,
       sp.product_type,
       sp.product_link,
       sp.product_line,
       --sp.cooperation_brand,
       (SELECT listagg(b.group_dict_name, ';') within GROUP(ORDER BY b.group_dict_value)
          FROM group_dict t
          LEFT JOIN group_dict b
            ON t.group_dict_type = 'COOPERATION_BRAND'
           AND t.group_dict_id = b.parent_id
           AND instr(';' || sp.brand_type || ';',
                     ';' || t.group_dict_value || ';') > 0
           AND instr(';' || sp.cooperation_brand || ';',
                     ';' || b.group_dict_value || ';') > 0) cooperation_brand_desc,
       nvl(s_a.nick_name,s_a.company_user_name) create_id,
       f.create_time,
       nvl(s_b.nick_name,s_b.company_user_name) update_id,
       f.update_time
  FROM scmdata.t_coop_factory f
 INNER JOIN scmdata.t_supplier_info sp
    ON f.company_id = sp.company_id
   AND f.fac_sup_info_id  = sp.supplier_info_id
 LEFT JOIN scmdata.sys_company_user s_a on f.create_id = s_a.user_id and f.company_id = s_a.company_id
 LEFT JOIN scmdata.sys_company_user s_b on f.update_id = s_b.user_id and f.company_id = s_b.company_id
 WHERE f.supplier_info_id = :supplier_info_id  --substr(:supplier_info_id,1,instr(:supplier_info_id,';')-1)
   AND f.company_id = %default_company_id%
   AND SP.STATUS = 1
 ORDER BY f.factory_type ASC]';
    IF p_item_id IN ('a_supp_151_7') THEN
      RETURN v_query_sql;
    ELSE
      RETURN NULL;
    END IF;
  END f_query_coop_factory_list;
  --insert sql
  FUNCTION f_insert_coop_factory_list(p_item_id VARCHAR2) RETURN CLOB IS
    v_insert_sql CLOB;
  BEGIN
    v_insert_sql := q'[DECLARE
      v_fac_rec scmdata.t_coop_factory%ROWTYPE;
    BEGIN
      v_fac_rec.coop_factory_id  := scmdata.f_get_uuid();
      v_fac_rec.company_id       := %default_company_id%;
      v_fac_rec.fac_sup_info_id  := :fac_sup_info_id;
      v_fac_rec.factory_code     := :supplier_code;
      v_fac_rec.factory_name     := :factory_name;
      v_fac_rec.factory_type     := :coop_factory_type;
      v_fac_rec.pause            := :coop_status;
      v_fac_rec.create_id        := :user_id;
      v_fac_rec.create_time      := SYSDATE;
      v_fac_rec.update_id        := :user_id;
      v_fac_rec.update_time      := SYSDATE;
      v_fac_rec.memo             := :memo;
      v_fac_rec.supplier_info_id := :supplier_info_id;
      scmdata.pkg_supplier_info.p_insert_coop_factory(p_fac_rec => v_fac_rec);

      --ZC314 ADD
      SCMDATA.PKG_CAPACITY_INQUEUE.P_COMMON_INQUEUE(V_CURUSERID  => %CURRENT_USERID%,
                                                    V_COMPID     => %DEFAULT_COMPANY_ID%,
                                                    V_TAB        => 'SCMDATA.T_COOP_FACTORY',
                                                    V_VIEWTAB    => NULL,
                                                    V_UNQFIELDS  => 'COOP_FACTORY_ID,COMPANY_ID',
                                                    V_CKFIELDS   => 'FACTORY_CODE,PAUSE,CREATE_ID,CREATE_TIME',
                                                    V_CONDS      => 'COOP_FACTORY_ID = '''||:COOP_FACTORY_ID||''' AND COMPANY_ID = '''||%DEFAULT_COMPANY_ID%||'''',
                                                    V_METHOD     => 'UPD',
                                                    V_VIEWLOGIC  => NULL,
                                                    V_QUEUETYPE  => 'CAPC_SUPFILE_COOPFACINFO_IU');
    END;]';
    IF p_item_id IN ('a_supp_151_7') THEN
      RETURN v_insert_sql;
    ELSE
      RETURN NULL;
    END IF;
  END f_insert_coop_factory_list;

  --��ȡ�������� pick
  FUNCTION f_query_coop_factory_pick(p_item_id VARCHAR2) RETURN CLOB IS
    v_query_sql CLOB;
  BEGIN
  
    v_query_sql := '{DECLARE
v_coop_class varchar2(4000);
v_sql clob;
BEGIN
  SELECT listagg(tc.coop_classification, '';'') coop_class
    INTO v_coop_class
    FROM scmdata.t_coop_scope tc
   WHERE tc.supplier_info_id = :supplier_info_id
     AND tc.company_id = :company_id
     AND tc.pause = 0;

   v_sql :=  ''SELECT distinct sp.supplier_code,sp.supplier_info_id fac_sup_info_id, sp.supplier_company_name factory_name,
       decode(sp.pause,1,1,0) coop_status,''''01'''' coop_factory_type,:supplier_info_id supplier_info_id
    FROM scmdata.t_supplier_info sp
   INNER JOIN scmdata.t_coop_scope tc
      ON sp.supplier_info_id = tc.supplier_info_id
     AND sp.company_id = tc.company_id
     AND tc.pause = 0
   WHERE sp.company_id = %default_company_id%
     --AND sp.cooperation_model = ''''OF''''
     AND sp.status = 1
     AND sp.pause <> 1
     AND instr(''''''||v_coop_class||'''''', tc.coop_classification) > 0
     AND sp.supplier_info_id not in
     (select t.fac_sup_info_id from scmdata.t_coop_factory t
      where t.supplier_info_id = :supplier_info_id
      and t.company_id = %default_company_id%) '';
 @strresult := v_sql;
END;}';
    IF p_item_id IN ('a_supp_151_7') THEN
      RETURN v_query_sql;
    ELSE
      RETURN NULL;
    END IF;
  END f_query_coop_factory_pick;

  --������������
  FUNCTION f_query_fac_type_looksql(p_fac_type_field VARCHAR2,
                                    p_suffix         VARCHAR2) RETURN CLOB IS
    v_query_sql CLOB;
  BEGIN
    v_query_sql := 'SELECT t.group_dict_value ' || p_fac_type_field ||
                   ', t.group_dict_name ' || p_fac_type_field || p_suffix || '
      FROM scmdata.sys_group_dict t
     WHERE t.group_dict_type = ''COOP_FAC_TYPE''
     ORDER BY t.group_dict_sort asc';
    RETURN v_query_sql;
  END f_query_fac_type_looksql;

  --���� ͣ�� ��ť
  PROCEDURE p_coop_fac_pause(p_company_id      VARCHAR2,
                             p_coop_factory_id VARCHAR2,
                             p_user_id         VARCHAR2,
                             p_status          VARCHAR2) IS
    v_where           CLOB;
    v_type            VARCHAR2(256);
    v_sup_name        VARCHAR2(256);
    v_fac_name        VARCHAR2(256);
    v_sup_info_id     VARCHAR2(256);
    v_fac_sup_info_id VARCHAR2(256);
    v_coop_class      VARCHAR2(256);
    v_sup_pause       NUMBER;
    v_fac_pause       NUMBER;
    v_pcnt            NUMBER;
    v_tcnt            NUMBER;
  BEGIN
    IF p_status = 0 THEN
      SELECT MAX(t.pause_type),
             MAX(a.supplier_company_name) sup_name,
             MAX(b.supplier_company_name) fac_name,
             MAX(t.supplier_info_id) supplier_info_id,
             MAX(t.fac_sup_info_id) fac_sup_info_id,
             MAX(a.pause) sup_pause,
             MAX(b.pause) fac_pause
        INTO v_type,
             v_sup_name,
             v_fac_name,
             v_sup_info_id,
             v_fac_sup_info_id,
             v_sup_pause,
             v_fac_pause
        FROM scmdata.t_coop_factory t
       INNER JOIN scmdata.t_supplier_info a
          ON a.supplier_info_id = t.supplier_info_id
         AND a.company_id = t.company_id
       INNER JOIN scmdata.t_supplier_info b
          ON b.supplier_info_id = t.fac_sup_info_id
         AND b.company_id = t.company_id
       WHERE t.coop_factory_id = p_coop_factory_id
         AND t.company_id = p_company_id;
    
      IF v_type IN ('SUP', 'COOP_PAUSE') THEN
        IF v_sup_pause = 1 THEN
          raise_application_error(-20002,
                                  '��Ӧ��:[' || v_sup_name ||
                                  '],Ŀǰ����״̬Ϊͣ��,�������ú�����ϵ��');
        ELSE
          NULL;
        END IF;
      END IF;
      IF v_type IN ('SUP_COOP', 'COOP_PAUSE') THEN
        SELECT listagg(DISTINCT CASE
                         WHEN a.pause = 1 THEN
                          b.group_dict_name
                         ELSE
                          NULL
                       END,
                       ';') coop_class
          INTO v_coop_class
          FROM scmdata.t_coop_scope a
         INNER JOIN scmdata.sys_group_dict b
            ON a.coop_classification = b.group_dict_value
           AND b.group_dict_type = 'PRODUCT_TYPE'
         WHERE a.supplier_info_id = v_sup_info_id
           AND a.company_id = p_company_id
           AND a.coop_classification IN
               (SELECT c.coop_classification
                  FROM scmdata.t_coop_scope c
                 WHERE c.supplier_info_id = v_fac_sup_info_id
                   AND c.company_id = p_company_id);
        IF v_coop_class IS NULL THEN
          NULL;
        ELSE
          raise_application_error(-20002,
                                  '��Ӧ��:[' || v_sup_name || ']��Ӧ�ĺ�������:[' ||
                                  v_coop_class || '],״̬Ϊͣ��,�������ú�����ϵ��');
        END IF;
      END IF;
      IF v_type IN ('OF', 'COOP_PAUSE') THEN
        IF v_fac_pause = 1 THEN
          raise_application_error(-20002,
                                  '��Э��:[' || v_fac_name ||
                                  '],Ŀǰ����״̬Ϊͣ��,�������ú�����ϵ��');
        ELSE
          NULL;
        END IF;
      END IF;
      IF v_type IN ('OF_COOP', 'COOP_PAUSE') THEN
        SELECT listagg(DISTINCT CASE
                         WHEN a.pause = 1 THEN
                          b.group_dict_name
                         ELSE
                          NULL
                       END,
                       ';') coop_class,
               SUM(CASE
                     WHEN a.pause = 1 THEN
                      1
                     ELSE
                      0
                   END) p_cnt,
               COUNT(1) t_cnt
          INTO v_coop_class, v_pcnt, v_tcnt
          FROM scmdata.t_coop_scope a
         INNER JOIN scmdata.sys_group_dict b
            ON a.coop_classification = b.group_dict_value
           AND b.group_dict_type = 'PRODUCT_TYPE'
         WHERE a.supplier_info_id = v_fac_sup_info_id
           AND a.company_id = p_company_id
           AND a.coop_classification IN
               (SELECT c.coop_classification
                  FROM scmdata.t_coop_scope c
                 WHERE c.supplier_info_id = v_sup_info_id
                   AND c.company_id = p_company_id);
        IF v_pcnt = v_tcnt THEN
          IF v_coop_class IS NULL THEN
            NULL;
          ELSE
            raise_application_error(-20002,
                                    '��Э��:[' || v_fac_name || ']��Ӧ�ĺ�������:[' ||
                                    v_coop_class || '],״̬Ϊͣ��,�������ú�����ϵ��');
          END IF;
        END IF;
      END IF;
    ELSE
      NULL;
    END IF;
    v_where := q'[ where company_id = ']' || p_company_id ||
               q'[' and coop_factory_id   = ']' || p_coop_factory_id ||
               q'[']';
    scmdata.pkg_plat_comm.p_pause(p_table       => 'T_COOP_FACTORY',
                                  p_pause_field => 'PAUSE',
                                  p_where       => v_where,
                                  p_user_id     => p_user_id,
                                  p_status      => p_status);
  
    UPDATE scmdata.t_coop_factory t
       SET t.pause_type = CASE
                            WHEN p_status = 1 THEN
                             'COOP_PAUSE'
                            ELSE
                             'COOP_UNPAUSE'
                          END
     WHERE company_id = p_company_id
       AND coop_factory_id = p_coop_factory_id;
  
  END p_coop_fac_pause;

  --���º�������״̬
  PROCEDURE update_coop_fac_status(p_company_id VARCHAR2,
                                   p_sup_id     VARCHAR2,
                                   p_fac_id     VARCHAR2 DEFAULT NULL,
                                   p_status     NUMBER,
                                   p_pause_type VARCHAR2) IS
  BEGIN
    IF p_pause_type = 'SUP' THEN
      UPDATE scmdata.t_coop_factory t
         SET t.pause       = p_status,
             t.pause_type  = p_pause_type,
             t.update_id   = 'ADMIN',
             t.update_time = SYSDATE
       WHERE t.supplier_info_id = p_sup_id
         AND t.company_id = p_company_id
         AND t.pause_type <> 'COOP_PAUSE';
    ELSIF p_pause_type IN ('SUP_COOP', 'OF_COOP') THEN
      UPDATE scmdata.t_coop_factory t
         SET t.pause       = p_status,
             t.pause_type  = p_pause_type,
             t.update_id   = 'ADMIN',
             t.update_time = SYSDATE
       WHERE t.supplier_info_id = p_sup_id
         AND t.fac_sup_info_id = p_fac_id
         AND t.company_id = p_company_id
         AND t.pause_type <> 'COOP_PAUSE';
    ELSIF p_pause_type = 'OF' THEN
      UPDATE scmdata.t_coop_factory t
         SET t.pause       = p_status,
             t.pause_type  = p_pause_type,
             t.update_id   = 'ADMIN',
             t.update_time = SYSDATE
       WHERE t.fac_sup_info_id = p_sup_id
         AND t.company_id = p_company_id
         AND t.pause_type <> 'COOP_PAUSE';
    ELSE
      NULL;
    END IF;
  END update_coop_fac_status;

  --��Ӧ���빤��������ϵ ��ͣ״̬У��
  --��Ӧ��/���� ��ͣ��ť����
  PROCEDURE p_check_sup_fac_pause(p_company_id VARCHAR2, p_sup_id VARCHAR2) IS
    v_sup_pause NUMBER;
    v_fac_cnt   NUMBER;
    v_befac_cnt NUMBER;
  BEGIN
  
    SELECT COUNT(1)
      INTO v_fac_cnt
      FROM scmdata.t_coop_factory t
     WHERE t.supplier_info_id = p_sup_id
       AND t.company_id = p_company_id;
  
    SELECT MAX(t.pause)
      INTO v_sup_pause
      FROM scmdata.t_supplier_info t
     WHERE t.supplier_info_id = p_sup_id
       AND t.company_id = p_company_id;
  
    --��Ϊ��Ӧ�̣��ж��Ƿ��й���
    IF v_fac_cnt > 0 THEN
      --�жϹ�Ӧ����ͣ
      IF v_sup_pause = 1 THEN
        update_coop_fac_status(p_company_id => p_company_id,
                               p_sup_id     => p_sup_id,
                               p_status     => v_sup_pause,
                               p_pause_type => 'SUP');
      
      ELSE
        p_check_coop_fac_pause(p_company_id => p_company_id,
                               p_sup_id     => p_sup_id,
                               p_type       => 'SUP');
      END IF;
    ELSE
      NULL;
    END IF;
    --��Ϊ�������ж��Ƿ���Ϊ������Ӧ�̵Ĺ���
    SELECT COUNT(1)
      INTO v_befac_cnt
      FROM scmdata.t_coop_factory t
     WHERE t.fac_sup_info_id = p_sup_id
       AND t.company_id = p_company_id;
    IF v_befac_cnt > 0 THEN
      IF v_sup_pause = 1 THEN
        update_coop_fac_status(p_company_id => p_company_id,
                               p_sup_id     => p_sup_id,
                               p_status     => v_sup_pause,
                               p_pause_type => 'OF');
      
      ELSE
        p_check_coop_fac_pause(p_company_id => p_company_id,
                               p_sup_id     => p_sup_id,
                               p_type       => 'OF');
      END IF;
    ELSE
      NULL;
    END IF;
  END p_check_sup_fac_pause;

  --��Ӧ�̵ĺ�����Χ�빤��������ϵ ��ͣ״̬У��
  PROCEDURE p_check_coop_fac_pause(p_company_id VARCHAR2,
                                   p_sup_id     VARCHAR2,
                                   p_type       VARCHAR2) IS
    v_coop_class VARCHAR2(2048);
  BEGIN
    --1:������Χ��ͣ
    --��ȡ��ǰ��Ӧ��/���������õĺ�����Χ
    SELECT nvl(listagg(DISTINCT t.coop_classification, ';'), '-1') coop_class
      INTO v_coop_class
      FROM scmdata.t_coop_scope t
     WHERE t.supplier_info_id = p_sup_id
       AND t.company_id = p_company_id
       AND t.pause = 0;
    IF p_type = 'SUP' THEN
      IF v_coop_class = '-1' THEN
        update_coop_fac_status(p_company_id => p_company_id,
                               p_sup_id     => p_sup_id,
                               p_fac_id     => p_sup_id,
                               p_status     => 1,
                               p_pause_type => 'SUP');
      ELSE
        --��Ϊ��Ӧ�̣��жϹ����ĺ�����Χ�Ƿ񲿷�/ȫ�������ڵ�ǰ��Ӧ�������õĺ�����Χ������ǣ�������ϵ�����ã�����ͣ��
        FOR i IN (SELECT listagg(DISTINCT c.coop_classification, ';') coop_class,
                         c.supplier_info_id
                    FROM scmdata.t_coop_factory a
                   INNER JOIN scmdata.t_supplier_info b
                      ON a.company_id = b.company_id
                     AND a.fac_sup_info_id = b.supplier_info_id
                   INNER JOIN scmdata.t_coop_scope c
                      ON b.supplier_info_id = c.supplier_info_id
                     AND b.company_id = c.company_id
                     AND c.pause = 0
                   WHERE a.supplier_info_id = p_sup_id --��Ӧ��ID
                     AND a.company_id = p_company_id
                   GROUP BY c.supplier_info_id) LOOP
          IF scmdata.instr_priv(v_coop_class, i.coop_class) > 0 THEN
            update_coop_fac_status(p_company_id => p_company_id,
                                   p_sup_id     => p_sup_id,
                                   p_fac_id     => i.supplier_info_id,
                                   p_status     => 0,
                                   p_pause_type => 'SUP_COOP');
          ELSE
            update_coop_fac_status(p_company_id => p_company_id,
                                   p_sup_id     => p_sup_id,
                                   p_fac_id     => i.supplier_info_id,
                                   p_status     => 1,
                                   p_pause_type => 'SUP_COOP');
          END IF;
        END LOOP;
      END IF;
    ELSIF p_type = 'OF' THEN
      IF v_coop_class = '-1' THEN
        update_coop_fac_status(p_company_id => p_company_id,
                               p_sup_id     => p_sup_id,
                               p_status     => 1,
                               p_pause_type => 'OF');
      ELSE
        --��Ϊ���������жϸù�Ӧ�̣��������ĺ�����Χ�Ƿ񲿷�/ȫ��������������Ӧ�̵����ĺ�����Χ������ǣ�������ϵ�����ã�����ͣ��
        FOR i IN (SELECT listagg(DISTINCT c.coop_classification, ';') coop_class,
                         c.supplier_info_id
                    FROM scmdata.t_coop_factory a
                   INNER JOIN scmdata.t_supplier_info b
                      ON a.supplier_info_id = b.supplier_info_id
                     AND a.company_id = b.company_id
                   INNER JOIN scmdata.t_coop_scope c
                      ON b.supplier_info_id = c.supplier_info_id
                     AND b.company_id = c.company_id
                     AND c.pause = 0
                   WHERE a.company_id = p_company_id
                     AND a.fac_sup_info_id = p_sup_id --����ID
                   GROUP BY c.supplier_info_id) LOOP
          IF scmdata.instr_priv(i.coop_class, v_coop_class) > 0 THEN
            update_coop_fac_status(p_company_id => p_company_id,
                                   p_sup_id     => i.supplier_info_id,
                                   p_fac_id     => p_sup_id,
                                   p_status     => 0,
                                   p_pause_type => 'OF_COOP');
          ELSE
            update_coop_fac_status(p_company_id => p_company_id,
                                   p_sup_id     => i.supplier_info_id,
                                   p_fac_id     => p_sup_id,
                                   p_status     => 1,
                                   p_pause_type => 'OF_COOP');
          END IF;
        END LOOP;
      END IF;
    ELSE
      NULL;
    END IF;
  END p_check_coop_fac_pause;

  --�������� end
  ----------------------------------------------------  ���ô���   end  ----------------------------------------------------------------------------

  ----------------------------------------------------  ҵ�����   begin  ---------------------------------------------------------------------------
  --������������
  PROCEDURE p_insert_coop_factory(p_fac_rec scmdata.t_coop_factory%ROWTYPE) IS
  BEGIN
    INSERT INTO scmdata.t_coop_factory
    VALUES
      (p_fac_rec.coop_factory_id,
       p_fac_rec.company_id,
       p_fac_rec.supplier_info_id,
       p_fac_rec.fac_sup_info_id,
       p_fac_rec.factory_code,
       p_fac_rec.factory_name,
       p_fac_rec.factory_type,
       p_fac_rec.pause,
       p_fac_rec.create_id,
       p_fac_rec.create_time,
       p_fac_rec.update_id,
       p_fac_rec.update_time,
       p_fac_rec.memo,
       nvl(p_fac_rec.pause_type, 'COOP_UNPAUSE'));
  END p_insert_coop_factory;

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
  PROCEDURE check_t_supplier_info(p_supplier_info_id VARCHAR2) IS
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
    check_save_t_supplier_info(p_sp_data => supp_info_rec);
  
    --3.У�������ΧTABҳ����Ϊ��
    SELECT COUNT(1)
      INTO v_flag
      FROM scmdata.t_coop_scope t
     WHERE t.supplier_info_id = supp_info_rec.supplier_info_id;
  
    IF v_flag = 0 AND supp_info_rec.supplier_info_origin <> 'QC' THEN
      raise_application_error(-20002,
                              '������Χ����Ϊ��,���ȵ��·�<������Χ>TABҳ������д�����ύ��');
    END IF;
  
  END check_t_supplier_info;
  --У��ͳһ���ô���
  --p_company_id :��ҵID
  --p_supplier_info_id ����Ӧ�̱�� ����
  --p_social_credit_code ��ͳһ������ô���
  PROCEDURE p_check_social_credit_code(p_company_id         VARCHAR2,
                                       p_supplier_info_id   VARCHAR2,
                                       p_social_credit_code VARCHAR2) IS
    v_scc_flag NUMBER;
  BEGIN
    IF p_social_credit_code IS NULL THEN
      raise_application_error(-20002, 'ͳһ������ô��벻��Ϊ�գ�');
    ELSE
      IF scmdata.pkg_check_data_comm.f_check_soial_code(p_social_credit_code) = 1 THEN
        NULL;
      ELSE
        raise_application_error(-20002,
                                '��������ȷ��ͳһ������ô��룬�ҳ���ӦΪ18λ��');
      END IF;
      --�����뵱ǰ��ҵ��Ӧ�̵��������������ѽ�����ͳһ������ô����ظ���
      SELECT COUNT(1)
        INTO v_scc_flag
        FROM scmdata.t_supplier_info sp
       WHERE sp.social_credit_code = p_social_credit_code
         AND sp.company_id = p_company_id
         AND sp.supplier_info_id <> p_supplier_info_id;
    
      IF v_scc_flag > 0 THEN
        raise_application_error(-20002, 'ͳһ������ô��벻���ظ���');
      END IF;
      --��ǰ��ҵ��ͳһ���ô����Ѵ��������У����飻
      SELECT COUNT(1)
        INTO v_scc_flag
        FROM scmdata.t_ask_record a
        LEFT JOIN scmdata.t_factory_ask b
          ON a.be_company_id = b.company_id
         AND a.ask_record_id = b.ask_record_id
       WHERE a.be_company_id = p_company_id
         AND (a.social_credit_code = p_social_credit_code OR
             b.social_credit_code = p_social_credit_code);
    
      IF v_scc_flag > 0 THEN
        raise_application_error(-20002,
                                '��ǰ��ҵ��ͳһ���ô����Ѵ��������У����飡��');
      END IF;
    
    END IF;
  END p_check_social_credit_code;

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

  PROCEDURE check_save_t_supplier_info(p_sp_data scmdata.t_supplier_info%ROWTYPE) IS
    v_supp_flag_tp NUMBER := 0;
  
  BEGIN
    --У���������
    --1 ��Ӧ�����Ʋ���Ϊ��
    IF p_sp_data.supplier_company_name IS NULL THEN
      raise_application_error(-20002, '��Ӧ�����Ʋ���Ϊ�գ�');
    ELSE
      --��Ӧ�̵�������Ӧ�����ƿɱ༭��
      --���������޸ģ�����У�鹩Ӧ�������Ƿ��ظ�
      --1�� ���ƽ�����д���ļ��������ţ�
      IF pkg_check_data_comm.f_check_varchar(pi_data => p_sp_data.supplier_company_name,
                                             pi_type => 0) <> 1 THEN
        raise_application_error(-20002,
                                '��Ӧ��������д���󣬽�����д���ļ��������ţ�');
      END IF;
      --2�� �����뵱ǰ��ҵ��Ӧ�̵��������������ѽ����Ĺ�Ӧ�������ظ���
      SELECT COUNT(1)
        INTO v_supp_flag_tp
        FROM scmdata.t_supplier_info t
       WHERE t.company_id = p_sp_data.company_id
         AND t.supplier_info_id <> p_sp_data.supplier_info_id
         AND t.supplier_company_name = p_sp_data.supplier_company_name;
    
      IF v_supp_flag_tp > 0 THEN
        raise_application_error(-20002, '��Ӧ�̵����Ѵ��ڸù�Ӧ������!!');
      END IF;
      --3�� �����뵱ǰ��ҵ��׼�������еĹ�˾���ƴ����ظ���
      scmdata.pkg_compname_check.p_tfa_compname_check_for_new(comp_name => p_sp_data.supplier_company_name,
                                                              dcomp_id  => p_sp_data.company_id,
                                                              p_fask_id => p_sp_data.supplier_info_origin_id);
    END IF;
    --�ֶ����� �� ������
    IF p_sp_data.supplier_info_origin = 'MA' AND p_sp_data.status = 0 THEN
      --2 У�� ͳһ������ô���
      p_check_social_credit_code(p_company_id         => p_sp_data.company_id,
                                 p_supplier_info_id   => p_sp_data.supplier_info_id,
                                 p_social_credit_code => p_sp_data.social_credit_code);
    ELSE
      NULL;
    END IF;
  
    --3 ����У��
    --��˾��ϵ�˵绰
    IF p_sp_data.company_contact_phone IS NOT NULL THEN
      IF scmdata.pkg_check_data_comm.f_check_phone(p_sp_data.company_contact_phone) = 1 THEN
        NULL;
      ELSE
        raise_application_error(-20002, '��������ȷ�Ĺ�˾��ϵ�˵绰���룡');
      END IF;
    END IF;
  
    --У�鹫˾����Ϊxxxʱ���������ģʽֻ��Ϊxxx
    scmdata.pkg_ask_record_mange.p_check_company_type(p_company_type      => p_sp_data.company_type,
                                                      p_cooperation_model => p_sp_data.cooperation_model);
  
  END check_save_t_supplier_info;

  --У�鹤����Ϣ
  /* FUNCTION check_fask_data(p_company_id       VARCHAR2,
                           p_factory_ask_id   VARCHAR2,
                           p_com_manufacturer VARCHAR2) RETURN NUMBER IS
    v_social_credit_code VARCHAR2(18);
    v_flag               NUMBER;
  BEGIN
    IF p_com_manufacturer = '01' THEN
      --У��ù�Ӧ���Ƿ���ڹ���
      SELECT t.fa_social_credit_code
        INTO v_social_credit_code
        FROM scmdata.t_factory_ask_out t
       WHERE t.factory_ask_id = p_factory_ask_id;
      --�ù����Ƿ��Ѿ���������
      IF v_social_credit_code IS NOT NULL THEN
        SELECT COUNT(1)
          INTO v_flag
          FROM scmdata.t_supplier_info sp
         WHERE sp.company_id = p_company_id
           AND sp.social_credit_code = v_social_credit_code;
        IF v_flag > 0 THEN
          RETURN 0;
        ELSE
          RETURN 1;
        END IF;
      ELSE
        RETURN 0;
      END IF;
    ELSE
      RETURN 0;
    END IF;
  END check_fask_data;*/

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
      INTO v_supplier_company_id, v_cooperation_type, v_company_id
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
  --ͨ������pick �ֲ���ȡ��������id
  FUNCTION f_get_category_config_by_pick(p_company_id VARCHAR2,
                                         p_supp_id    VARCHAR2,
                                         p_province   VARCHAR2,
                                         p_city       VARCHAR2)
    RETURN VARCHAR2 IS
    v_group_config_id VARCHAR2(32);
  BEGIN
  
    SELECT MAX(aa.group_config_id)
      INTO v_group_config_id
      FROM scmdata.t_supplier_group_config aa
     INNER JOIN scmdata.t_supplier_group_category_config bb
        ON aa.group_config_id = bb.group_config_id
       AND aa.pause = 1
       AND bb.pause = 1
       AND trunc(SYSDATE) BETWEEN trunc(aa.effective_time) AND
           trunc(aa.end_time)
     INNER JOIN scmdata.t_supplier_group_area_config ee
        ON ee.pause = 1
       AND ee.group_type = 'GROUP_AREA'
       AND instr(bb.area_config_id, ee.group_area_config_id) > 0
       AND (instr(';' || ee.province_id || ';', ';' || p_province || ';') > 0 AND
           instr(';' || ee.city_id || ';', ';' || p_city || ';') > 0)
     INNER JOIN (SELECT coop_classification, coop_product_cate
                   FROM (SELECT sa.coop_classification,
                                sa.coop_product_cate,
                                row_number() over(ORDER BY sa.create_time) rn
                           FROM scmdata.t_supplier_info sp
                          INNER JOIN scmdata.t_coop_scope sa
                             ON sa.company_id = sp.company_id
                            AND sa.supplier_info_id = sp.supplier_info_id
                          WHERE sp.supplier_info_id = p_supp_id
                            AND sp.company_id = p_company_id)
                  WHERE rn = 1) cc
        ON instr(';' || bb.cooperation_classification || ';',
                 ';' || cc.coop_classification || ';') > 0
       AND instr(';' || bb.cooperation_product_cate || ';',
                 ';' || cc.coop_product_cate || ';') > 0
     WHERE aa.company_id = p_company_id;
    RETURN v_group_config_id;
  
  END f_get_category_config_by_pick;

  --ͨ������Ʒ�� ��ȡ���ڷ��� 
  --p_company_id ��˾ID
  --p_supp_id ��Ӧ��ID
  FUNCTION f_get_category_config(p_company_id VARCHAR2, p_supp_id VARCHAR2)
    RETURN VARCHAR2 IS
    v_group_config_id VARCHAR2(32);
  BEGIN
    SELECT MAX(dd.group_config_id)
      INTO v_group_config_id
      FROM (SELECT *
              FROM (SELECT sa.coop_classification,
                           sa.coop_product_cate,
                           sp.company_province,
                           sp.company_city,
                           sp.company_id,
                           sp.supplier_info_id,
                           row_number() over(ORDER BY sa.create_time) rn
                      FROM scmdata.t_supplier_info sp
                     INNER JOIN scmdata.t_coop_scope sa
                        ON sa.company_id = sp.company_id
                       AND sa.supplier_info_id = sp.supplier_info_id
                     WHERE sa.supplier_info_id = p_supp_id
                       AND sa.company_id = p_company_id) va
             WHERE va.rn = 1) cc
     INNER JOIN (SELECT aa.group_name,
                        aa.group_config_id,
                        aa.area_group_leader,
                        bb.cooperation_classification,
                        bb.cooperation_product_cate,
                        ee.province_id,
                        ee.city_id
                   FROM scmdata.t_supplier_group_config aa
                  INNER JOIN scmdata.t_supplier_group_category_config bb
                     ON aa.group_config_id = bb.group_config_id
                    AND aa.pause = 1
                    AND bb.pause = 1
                  INNER JOIN scmdata.t_supplier_group_area_config ee
                     ON ee.pause = 1
                    AND instr(bb.area_config_id, ee.group_area_config_id) > 0
                  WHERE trunc(SYSDATE) BETWEEN trunc(aa.effective_time) AND
                        trunc(aa.end_time)) dd
        ON instr(';' || dd.cooperation_classification || ';',
                 ';' || cc.coop_classification || ';') > 0
       AND instr(';' || dd.cooperation_product_cate || ';',
                 ';' || cc.coop_product_cate || ';') > 0
       AND (instr(';' || dd.province_id || ';',
                  ';' || cc.company_province || ';') > 0 AND
            instr(';' || dd.city_id || ';', ';' || cc.company_city || ';') > 0);
    RETURN v_group_config_id;
  END f_get_category_config;

  --��ȡ����
  --���ڷ�����ݹ�Ӧ�̵�Ʒ�ࡢ���򣬴����ڷ���������ƥ�䣬�Զ���ȡ��Ӧ���飻
  FUNCTION f_get_group_config_id(p_company_id VARCHAR2,
                                 p_supp_id    VARCHAR2,
                                 p_is_by_pick INT DEFAULT 0,
                                 p_province   VARCHAR2 DEFAULT NULL,
                                 p_city       VARCHAR2 DEFAULT NULL)
    RETURN VARCHAR2 IS
    v_flag             NUMBER;
    vo_group_config_id VARCHAR2(32);
  BEGIN
    SELECT COUNT(1)
      INTO v_flag
      FROM scmdata.t_supplier_info sp
      LEFT JOIN scmdata.t_coop_scope tc
        ON sp.supplier_info_id = tc.supplier_info_id
       AND sp.company_id = tc.company_id
     WHERE sp.supplier_info_id = p_supp_id
       AND sp.company_id = p_company_id;
    --���ڷ�����ݹ�Ӧ�̵�Ʒ�ࡢ���򣬴����ڷ���������ƥ�䣬�Զ���ȡ��Ӧ���飻
    IF v_flag > 0 THEN
      IF p_is_by_pick = 0 THEN
        vo_group_config_id := f_get_category_config(p_company_id => p_company_id,
                                                    p_supp_id    => p_supp_id);
      ELSIF p_is_by_pick = 1 THEN
        vo_group_config_id := f_get_category_config_by_pick(p_company_id => p_company_id,
                                                            p_supp_id    => p_supp_id,
                                                            p_province   => p_province,
                                                            p_city       => p_city);
      ELSE
        NULL;
      END IF;
    ELSE
      vo_group_config_id := NULL;
    END IF;
    RETURN vo_group_config_id;
  END f_get_group_config_id;
  --��ȡ����
  FUNCTION f_get_group_name(p_company_id      VARCHAR2,
                            p_group_config_id VARCHAR2) RETURN VARCHAR2 IS
    v_group_name VARCHAR2(2000);
  BEGIN
    SELECT MAX(t.group_name)
      INTO v_group_name
      FROM scmdata.t_supplier_group_config t
     WHERE t.group_config_id = p_group_config_id
       AND t.company_id = p_company_id
       AND t.pause = 1;
    RETURN v_group_name;
  END f_get_group_name;
  --�����������ڷ���
  PROCEDURE p_batch_update_group_name(p_company_id VARCHAR2,
                                      p_is_trigger INT DEFAULT 0,
                                      p_pause      INT DEFAULT 1,
                                      p_is_by_pick INT DEFAULT 0) IS
  BEGIN
    FOR sup_rec IN (SELECT t.company_province,
                           t.company_city,
                           vc.coop_classification,
                           vc.coop_product_cate,
                           t.supplier_info_id,
                           t.company_id
                      FROM scmdata.t_supplier_info t
                     INNER JOIN (SELECT *
                                  FROM (SELECT tc.coop_classification,
                                               tc.coop_product_cate,
                                               row_number() over(PARTITION BY tc.supplier_info_id, tc.company_id ORDER BY tc.create_time DESC) rn,
                                               tc.supplier_info_id,
                                               tc.company_id
                                          FROM scmdata.t_coop_scope tc
                                         WHERE tc.company_id = p_company_id)
                                 WHERE rn = 1) vc
                        ON vc.supplier_info_id = t.supplier_info_id
                       AND vc.company_id = t.company_id
                     WHERE t.company_id = p_company_id
                       AND t.supplier_code = 'C03155') LOOP
    
      pkg_supplier_info.p_update_group_name(p_company_id       => sup_rec.company_id,
                                            p_supplier_info_id => sup_rec.supplier_info_id,
                                            p_is_trigger       => p_is_trigger,
                                            p_pause            => p_pause,
                                            p_is_by_pick       => p_is_by_pick,
                                            p_province         => sup_rec.company_province,
                                            p_city             => sup_rec.company_city);
    END LOOP;
  END p_batch_update_group_name;

  --������������ �����鳤
  PROCEDURE p_update_group_name(p_company_id       VARCHAR2,
                                p_supplier_info_id VARCHAR2,
                                p_is_create_sup    INT DEFAULT 0,
                                p_is_trigger       INT DEFAULT 0,
                                p_pause            INT DEFAULT 1,
                                p_is_by_pick       INT DEFAULT 0,
                                p_province         VARCHAR2 DEFAULT NULL,
                                p_city             VARCHAR2 DEFAULT NULL) IS
    vo_group_config_id VARCHAR2(32);
    v_group_name       VARCHAR2(32);
  BEGIN
    IF p_pause = 0 THEN
      vo_group_config_id := NULL;
    ELSE
      IF p_is_by_pick = 0 THEN
        vo_group_config_id := pkg_supplier_info.f_get_group_config_id(p_company_id => p_company_id,
                                                                      p_supp_id    => p_supplier_info_id,
                                                                      p_is_by_pick => 0);
      ELSIF p_is_by_pick = 1 THEN
        vo_group_config_id := pkg_supplier_info.f_get_group_config_id(p_company_id => p_company_id,
                                                                      p_supp_id    => p_supplier_info_id,
                                                                      p_is_by_pick => 1,
                                                                      p_province   => p_province,
                                                                      p_city       => p_city);
      ELSE
        NULL;
      END IF;
      --�жϻ�ȡ���÷��صķ����Ƿ�Ϊ��   
      IF p_is_create_sup = 0 THEN
        IF vo_group_config_id IS NULL THEN
          SELECT MAX(t.group_name)
            INTO v_group_name
            FROM scmdata.t_supplier_info t
           WHERE t.supplier_info_id = p_supplier_info_id
             AND t.company_id = p_company_id;
          --�жϹ�Ӧ�� ����ԭֵ�Ƿ�Ϊ��
          IF v_group_name IS NULL THEN
            IF p_is_trigger = 0 THEN
              raise_application_error(-20002,
                                      '���鲻��Ϊ�գ������������÷������ϵ����Ա���з������ã�');
            ELSIF p_is_trigger = 1 THEN
              vo_group_config_id := NULL;
            ELSE
              NULL;
            END IF;
          ELSE
            vo_group_config_id := v_group_name;
          END IF;
        ELSE
          NULL;
        END IF;
      END IF;
    END IF;
    UPDATE scmdata.t_supplier_info t
       SET t.group_name = vo_group_config_id
     WHERE t.supplier_info_id = p_supplier_info_id
       AND t.company_id = p_company_id;
  END p_update_group_name;

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

  PROCEDURE create_t_supplier_info(p_company_id      VARCHAR2,
                                   p_factory_ask_id  VARCHAR2,
                                   p_user_id         VARCHAR2,
                                   p_is_trialorder   NUMBER,
                                   p_trialorder_type VARCHAR2) IS
  
    --��Դ���� ׼����� ��������� =�� ͬ�� =��������������Ӧ������
    v_cooperation_company_id VARCHAR2(100);
    v_supply_id              VARCHAR2(100);
    v_coop_state             NUMBER;
    v_coop_position          VARCHAR2(48);
    iv_supp_info             scmdata.t_supplier_info%ROWTYPE; --�鳧����  ��Ӧ����Ϣ
    iv_sp_scope_info         scmdata.t_coop_scope%ROWTYPE; --�鳧����  ��Ӧ����Ϣ ������Χ
    fask_rec                 scmdata.t_factory_ask%ROWTYPE;
    fr_rec                   scmdata.t_factory_report%ROWTYPE;
    --�鳧���뵥 ���������Χ
    CURSOR fask_scope_cur(p_factory_ask_id VARCHAR2) IS
      SELECT t.*
        FROM scmdata.t_ask_scope t
       WHERE t.object_id = p_factory_ask_id
         AND t.object_type = 'CA';
    --�鳧���� ��������������ϸ
    CURSOR faskrp_ability_cur(p_factory_ask_id VARCHAR2) IS
      SELECT ra.cooperation_classification,
             ra.cooperation_product_cate,
             listagg(ra.cooperation_subcategory, ';') cooperation_subcategory
        FROM scmdata.t_factory_report         fr,
             scmdata.t_factory_report_ability ra
       WHERE fr.factory_report_id = ra.factory_report_id
         AND fr.factory_ask_id = p_factory_ask_id
         AND ra.ability_result = 'AGREE'
       GROUP BY ra.factory_report_id,
                ra.cooperation_classification,
                ra.cooperation_product_cate;
    /*SELECT ra.*
     FROM scmdata.t_factory_report         fr,
          scmdata.t_factory_report_ability ra
    WHERE fr.factory_report_id = ra.factory_report_id
      AND fr.factory_ask_id = p_factory_ask_id
      AND ra.ability_result = 'AGREE';*/
  BEGIN
    --����Դ
    --�鳧���뵥 ����Ӧ�̻�����Ϣ��
    SELECT *
      INTO fask_rec
      FROM scmdata.t_factory_ask fa
     WHERE fa.factory_ask_id = p_factory_ask_id --�ⲿ���� :factory_ask_id
       AND fa.factrory_ask_flow_status IN ('FA12', 'FA31')
       AND fa.company_id = p_company_id;
  
    --��Ӧ���Ƿ���ƽ̨ע�ᣬ����ƽ̨ע���ͨ�����ͳһ���ô���ȡ��˾id
    SELECT MAX(fc.company_id)
      INTO v_cooperation_company_id
      FROM scmdata.sys_company fc
     WHERE fc.licence_num = fask_rec.social_credit_code;
  
    ---���ֺ�����λ
    SELECT decode(MAX(cooperation_model), 'OF', '��Э��', '��ͨ��')
      INTO v_coop_position
      FROM scmdata.t_factory_ask fz
     WHERE fz.factory_ask_id = fask_rec.factory_ask_id;
  
    --��ȡƽ̨Ψһ����
    v_supply_id                          := scmdata.pkg_plat_comm.f_getkeyid_plat('GY',
                                                                                  'seq_plat_code',
                                                                                  99);
    iv_supp_info.supplier_info_id        := v_supply_id;
    iv_supp_info.company_id              := p_company_id;
    iv_supp_info.supplier_info_origin    := 'AA';
    iv_supp_info.supplier_info_origin_id := fask_rec.factory_ask_id;
    iv_supp_info.supplier_company_id     := nvl(fask_rec.cooperation_company_id,
                                                v_cooperation_company_id);
    --������Ϣ
    iv_supp_info.supplier_company_name         := fask_rec.company_name;
    iv_supp_info.supplier_company_abbreviation := fask_rec.company_abbreviation;
    iv_supp_info.social_credit_code            := fask_rec.social_credit_code;
    iv_supp_info.legal_representative          := fask_rec.legal_representative; --��ֵ������
    iv_supp_info.fa_contact_name               := fask_rec.contact_name; --��ֵ������
    iv_supp_info.fa_contact_phone              := fask_rec.contact_phone; --��ֵ������
    iv_supp_info.company_province              := fask_rec.company_province;
    iv_supp_info.company_city                  := fask_rec.company_city;
    iv_supp_info.company_county                := fask_rec.company_county;
    iv_supp_info.company_address               := fask_rec.company_address;
  
    SELECT MAX(t.company_contact_phone)
      INTO iv_supp_info.company_contact_phone
      FROM scmdata.t_ask_record t
     WHERE t.ask_record_id = fask_rec.ask_record_id;
  
    iv_supp_info.company_contact_person := fask_rec.contact_name;
    iv_supp_info.company_contact_phone  := fask_rec.contact_phone;
    iv_supp_info.company_type           := fask_rec.company_type; --��ֵ������
    --������Ϣ
    iv_supp_info.product_type      := fask_rec.product_type;
    iv_supp_info.product_link      := fask_rec.product_link;
    iv_supp_info.brand_type        := fask_rec.brand_type;
    iv_supp_info.cooperation_brand := fask_rec.cooperation_brand;
  
    --������Ϣ
    iv_supp_info.pause := CASE
                            WHEN p_is_trialorder = 1 THEN
                             2
                            ELSE
                             0
                          END;
    --׼����
    iv_supp_info.admit_result := p_trialorder_type;
    iv_supp_info.status       := 0;
    iv_supp_info.bind_status  := 1;
    iv_supp_info.create_id    := p_user_id;
    iv_supp_info.create_date  := SYSDATE;
    iv_supp_info.update_id    := p_user_id;
    iv_supp_info.update_date  := SYSDATE;
    --����
    iv_supp_info.cooperation_type  := fask_rec.cooperation_type;
    iv_supp_info.cooperation_model := fask_rec.cooperation_model;
    iv_supp_info.sharing_type      := '00';
    iv_supp_info.coop_position     := v_coop_position;
  
    --�ж��鳧��ʽ
    --1.���鳧  ��Դֻ���鳧���뵥
    --���鳧���뵥 ��Ӧ����Ϣ ���ɵ���
    IF fask_rec.factory_ask_type = 0 THEN
      --������Ϣ
      iv_supp_info.worker_num  := fask_rec.worker_num;
      iv_supp_info.machine_num := fask_rec.machine_num;
      --iv_supp_info.reserve_capacity   := fask_rec.reserve_capacity;
      iv_supp_info.product_efficiency := fask_rec.product_efficiency;
      iv_supp_info.work_hours_day     := fask_rec.work_hours_day;
      iv_supp_info.file_remark        := fask_rec.memo;
      --������Ϣ
      iv_supp_info.certificate_file := fask_rec.certificate_file;
      iv_supp_info.ask_files        := fask_rec.ask_files;
      iv_supp_info.supplier_gate    := fask_rec.supplier_gate;
      iv_supp_info.supplier_office  := fask_rec.supplier_office;
      iv_supp_info.supplier_site    := fask_rec.supplier_site;
      iv_supp_info.supplier_product := fask_rec.supplier_product;
    
      insert_supplier_info(p_sp_data => iv_supp_info);
    
      --2��������Χȡ =�����������Χ
      FOR fscope_rec IN fask_scope_cur(fask_rec.factory_ask_id) LOOP
      
        iv_sp_scope_info.coop_scope_id       := scmdata.f_get_uuid();
        iv_sp_scope_info.supplier_info_id    := v_supply_id;
        iv_sp_scope_info.company_id          := p_company_id;
        iv_sp_scope_info.coop_mode           := fask_rec.cooperation_model;
        iv_sp_scope_info.coop_classification := fscope_rec.cooperation_classification;
        iv_sp_scope_info.coop_product_cate   := fscope_rec.cooperation_product_cate;
        iv_sp_scope_info.coop_subcategory    := fscope_rec.cooperation_subcategory;
        iv_sp_scope_info.create_id           := p_user_id;
        iv_sp_scope_info.create_time         := SYSDATE;
        iv_sp_scope_info.update_id           := p_user_id;
        iv_sp_scope_info.update_time         := SYSDATE;
        iv_sp_scope_info.remarks             := '';
        iv_sp_scope_info.pause               := 0;
        iv_sp_scope_info.sharing_type := CASE
                                           WHEN fask_rec.rela_supplier_id IS NULL THEN
                                            '00'
                                           ELSE
                                            '02'
                                         END;
        iv_sp_scope_info.coop_state          := v_coop_state;
      
        insert_coop_scope(p_cp_data => iv_sp_scope_info, p_type => 0);
        /*          --ָ������
        IF fask_rec.rela_supplier_id IS NULL THEN
          NULL;
        ELSE
          SELECT t.supplier_code
            INTO v_rela_supp_code
            FROM scmdata.t_supplier_info t
           WHERE t.supplier_info_id = fask_rec.rela_supplier_id;
          insert_supplier_shared(scope_rec       => iv_sp_scope_info,
                                 p_supplier_code => v_rela_supp_code);
        END IF;*/
      END LOOP;
    ELSE
      --2.�鳧  ��Դ���鳧���棬��������
      --�ж��Ƿ����鳧����
      SELECT fr.*
        INTO fr_rec
        FROM scmdata.t_factory_report fr
       WHERE fr.factory_ask_id = fask_rec.factory_ask_id;
      --�鳧����
      IF fr_rec.factory_report_id IS NOT NULL THEN
        --������Ϣ
        iv_supp_info.product_line     := fr_rec.product_line;
        iv_supp_info.product_line_num := fr_rec.product_line_num;
        iv_supp_info.worker_num       := fr_rec.worker_num;
        iv_supp_info.machine_num      := fr_rec.machine_num;
        --iv_supp_info.reserve_capacity    := fr_rec.reserve_capacity;
        iv_supp_info.product_efficiency  := fr_rec.product_efficiency;
        iv_supp_info.work_hours_day      := fr_rec.work_hours_day;
        iv_supp_info.quality_step        := fr_rec.quality_step;
        iv_supp_info.pattern_cap         := fr_rec.pattern_cap;
        iv_supp_info.fabric_purchase_cap := fr_rec.fabric_purchase_cap;
        iv_supp_info.fabric_check_cap    := fr_rec.fabric_check_cap;
        iv_supp_info.cost_step           := fr_rec.cost_step;
        iv_supp_info.file_remark         := fr_rec.remarks;
      
        --������Ϣ
        iv_supp_info.certificate_file := fr_rec.certificate_file;
        iv_supp_info.ask_files        := fr_rec.ask_files;
        iv_supp_info.supplier_gate    := fr_rec.supplier_gate;
        iv_supp_info.supplier_office  := fr_rec.supplier_office;
        iv_supp_info.supplier_site    := fr_rec.supplier_site;
        iv_supp_info.supplier_product := fr_rec.supplier_product;
      
        insert_supplier_info(p_sp_data => iv_supp_info);
      
        --2��������Χȡ =���鳧���� ��������������ϸ(����)
        --ֻ����������������ϸ(����)���ܽ��������Χ
        FOR faskrp_ability_rec IN faskrp_ability_cur(fask_rec.factory_ask_id) LOOP
          iv_sp_scope_info.coop_scope_id       := scmdata.f_get_uuid();
          iv_sp_scope_info.supplier_info_id    := v_supply_id;
          iv_sp_scope_info.company_id          := p_company_id;
          iv_sp_scope_info.coop_mode           := fask_rec.cooperation_model;
          iv_sp_scope_info.coop_classification := faskrp_ability_rec.cooperation_classification;
          iv_sp_scope_info.coop_product_cate   := faskrp_ability_rec.cooperation_product_cate;
          iv_sp_scope_info.coop_subcategory    := faskrp_ability_rec.cooperation_subcategory;
          iv_sp_scope_info.create_id           := p_user_id;
          iv_sp_scope_info.create_time         := SYSDATE;
          iv_sp_scope_info.update_id           := p_user_id;
          iv_sp_scope_info.update_time         := SYSDATE;
          iv_sp_scope_info.remarks             := '';
          iv_sp_scope_info.pause               := 0;
          iv_sp_scope_info.sharing_type := CASE
                                             WHEN fask_rec.rela_supplier_id IS NULL THEN
                                              '00'
                                             ELSE
                                              '02'
                                           END;
          iv_sp_scope_info.coop_state          := v_coop_state;
        
          insert_coop_scope(p_cp_data => iv_sp_scope_info, p_type => 0);
          /*          --ָ������
          IF fask_rec.rela_supplier_id IS NULL THEN
            NULL;
          ELSE
            SELECT t.supplier_code
              INTO v_rela_supp_code
              FROM scmdata.t_supplier_info t
             WHERE t.supplier_info_id = fask_rec.rela_supplier_id;
            insert_supplier_shared(scope_rec       => iv_sp_scope_info,
                                   p_supplier_code => v_rela_supp_code);
          END IF;*/
        END LOOP;
      ELSE
        NULL;
      END IF;
    END IF;
  
    --ָ������
    DECLARE
      v_fac_rec scmdata.t_coop_factory%ROWTYPE;
      --v_factory_code VARCHAR2(32);
      --v_factory_name VARCHAR2(256);
    BEGIN
      --���й������� ���Զ�������Э����Ϣ����������
      IF fask_rec.rela_supplier_id IS NULL THEN
        NULL;
      ELSE
        /*SELECT MAX(t.supplier_code), MAX(t.supplier_company_name)
         INTO v_factory_code, v_factory_name
         FROM scmdata.t_supplier_info t
        WHERE t.supplier_info_id = fask_rec.rela_supplier_id;*/
        --ԭָ��������������������
        /*insert_supplier_shared(scope_rec       => iv_sp_scope_info,
        p_supplier_code => v_rela_supp_code);*/
        --�������߼�  ׼����Զ�������Э������������
        /*v_fac_rec.coop_factory_id  := scmdata.f_get_uuid();
        v_fac_rec.company_id       := p_company_id;
        v_fac_rec.fac_sup_info_id  := fask_rec.rela_supplier_id;
        v_fac_rec.factory_code     := v_factory_code;
        v_fac_rec.factory_name     := v_factory_name;
        v_fac_rec.factory_type     := '01'; --��Э��
        v_fac_rec.pause            := 0; --Ĭ������
        v_fac_rec.create_id        := 'ADMIN';
        v_fac_rec.create_time      := SYSDATE;
        v_fac_rec.update_id        := 'ADMIN';
        v_fac_rec.update_time      := SYSDATE;
        v_fac_rec.supplier_info_id := v_supply_id;*/
        --׼����Զ����ɹ�����Ӧ�̵���Э�� by DYY153 20220408
        v_fac_rec.coop_factory_id  := scmdata.f_get_uuid();
        v_fac_rec.company_id       := p_company_id;
        v_fac_rec.fac_sup_info_id  := v_supply_id;
        v_fac_rec.factory_name     := fask_rec.company_name;
        v_fac_rec.factory_type     := '01'; --��Э��
        v_fac_rec.pause            := 0; --Ĭ������
        v_fac_rec.create_id        := 'ADMIN';
        v_fac_rec.create_time      := SYSDATE;
        v_fac_rec.update_id        := 'ADMIN';
        v_fac_rec.update_time      := SYSDATE;
        v_fac_rec.supplier_info_id := fask_rec.rela_supplier_id;
        scmdata.pkg_supplier_info.p_insert_coop_factory(p_fac_rec => v_fac_rec);
      END IF;
    END;
  
    --������������ �����鳤
    p_update_group_name(p_company_id       => p_company_id,
                        p_supplier_info_id => v_supply_id,
                        p_is_create_sup    => 1,
                        p_is_by_pick       => 0);
  
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
    v_fac_id  VARCHAR2(32);
    v_origin  VARCHAR2(32);
    vo_log_id VARCHAR2(32);
  BEGIN
    --1.У������
    check_t_supplier_info(p_supplier_info_id);
  
    --2.���ɹ�Ӧ�̵������
    v_supplier_code := get_supplier_code_by_rule(p_supplier_info_id,
                                                 p_default_company_id);
  
    --3.�������߼�  �������Զ����ɱ�����Ϣ����������
    DECLARE
      v_fac_rec      scmdata.t_coop_factory%ROWTYPE;
      v_factory_name VARCHAR2(256);
    BEGIN
      v_fac_rec.coop_factory_id := scmdata.f_get_uuid();
      v_fac_rec.company_id      := p_default_company_id;
      v_fac_rec.fac_sup_info_id := p_supplier_info_id;
      v_fac_rec.factory_code    := v_supplier_code;
      SELECT MAX(sp.supplier_company_name)
        INTO v_factory_name
        FROM scmdata.t_supplier_info sp
       WHERE sp.supplier_info_id = p_supplier_info_id
         AND sp.company_id = p_default_company_id;
      v_fac_rec.factory_name     := v_factory_name;
      v_fac_rec.factory_type     := '00'; --����
      v_fac_rec.pause            := 0; --Ĭ������
      v_fac_rec.create_id        := 'ADMIN';
      v_fac_rec.create_time      := SYSDATE;
      v_fac_rec.update_id        := 'ADMIN';
      v_fac_rec.update_time      := SYSDATE;
      v_fac_rec.supplier_info_id := p_supplier_info_id;
      scmdata.pkg_supplier_info.p_insert_coop_factory(p_fac_rec => v_fac_rec);
      --���¸ù�������Ϊ��Э�����Ĺ�Ӧ�̱�������������� DYY153 20220411
      UPDATE scmdata.t_coop_factory t
         SET t.factory_code = v_supplier_code
       WHERE t.fac_sup_info_id = p_supplier_info_id
         AND t.company_id = p_default_company_id;
    END;
  
    --4.���µ���״̬ ������ =���ѽ��� ,������MA����Ӧ�� => δ�󶨣�׼�루AA��=> �Ѱ�
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
    
      --5.��¼������־
      /*insert_oper_log(p_supplier_info_id,
      '��������',
      '',
      p_user_id,
      p_default_company_id,
      SYSDATE);*/
    
      scmdata.pkg_plat_log.p_record_plat_log(p_company_id         => p_default_company_id,
                                             p_apply_module       => 'action_a_supp_151_1',
                                             p_base_table         => 't_supplier_info',
                                             p_apply_pk_id        => p_supplier_info_id,
                                             p_action_type        => 'UPDATE',
                                             p_log_id             => vo_log_id,
                                             p_log_type           => '00',
                                             p_field_desc         => '����״̬',
                                             p_operate_field      => 'status',
                                             p_field_type         => 'VARCHAR',
                                             p_old_code           => 0,
                                             p_new_code           => 1,
                                             p_old_value          => '������',
                                             p_new_value          => '�ѽ���',
                                             p_user_id            => p_user_id,
                                             p_operate_company_id => p_default_company_id,
                                             p_seq_no             => 1,
                                             po_log_id            => vo_log_id);
    
      scmdata.pkg_plat_log.p_update_plat_logmsg(p_company_id       => p_default_company_id,
                                                p_log_id           => vo_log_id,
                                                p_is_logsmsg       => 1,
                                                p_is_splice_fields => 0);
    
      --6.�жϹ�Ӧ�̵�����Դ
      --��AA�� ���̹����� �������̲�����¼
      --'MA'/����  ����¼
      SELECT MAX(t.supplier_info_origin_id), MAX(t.supplier_info_origin)
        INTO v_fac_id, v_origin
        FROM scmdata.t_supplier_info t
       WHERE t.supplier_info_id = p_supplier_info_id;
    
      IF v_origin = 'AA' THEN
        --��Ӧ�����ɵ����󣬼Ӽ��Ĺ�Ӧ����ȡ��������ʾ���ö�
        UPDATE scmdata.t_factory_ask t
           SET t.is_urgent = 0
         WHERE t.factory_ask_id = v_fac_id
           AND t.company_id = p_default_company_id;
        --���̲�����¼
        pkg_ask_record_mange.p_log_fac_records_oper(p_company_id   => p_default_company_id,
                                                    p_user_id      => p_user_id,
                                                    p_fac_ask_id   => v_fac_id,
                                                    p_flow_status  => 'SP_FILED',
                                                    p_fac_ask_flow => 'SP_01',
                                                    p_memo         => '');
      ELSE
        NULL;
      END IF;
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
    -- v_name VARCHAR2(100);
  BEGIN
    /*    SELECT fc.company_user_name
     INTO v_name
     FROM scmdata.sys_company_user fc
    WHERE fc.company_id = p_company_id
      AND fc.user_id = p_user_id;*/
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
       p_user_id,
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
    x_err_msg VARCHAR2(1000);
    supplier_info_exp EXCEPTION;
  BEGIN
  
    SELECT sp.pause
      INTO v_status
      FROM scmdata.t_supplier_info sp
     WHERE sp.supplier_info_id = p_supplier_info_id
       AND sp.company_id = p_company_id;
  
    IF p_status <> v_status THEN
      --���ã�ͣ��
      UPDATE scmdata.t_supplier_info sp
         SET sp.pause       = p_status,
             sp.pause_cause = p_reason,
             sp.update_id   = p_user_id,
             sp.update_date = SYSDATE
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
    
      UPDATE scmdata.t_supplier_info sp
         SET sp.bind_status = p_status,
             sp.update_id   = p_user_id,
             sp.update_date = SYSDATE
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

  PROCEDURE insert_supplier_info(p_sp_data scmdata.t_supplier_info%ROWTYPE) IS
  BEGIN
  
    INSERT INTO scmdata.t_supplier_info
      (supplier_info_id,
       company_id,
       supplier_info_origin_id,
       supplier_company_id,
       supplier_company_name,
       supplier_company_abbreviation,
       social_credit_code,
       inside_supplier_code,
       company_contact_person,
       company_contact_phone,
       legal_representative,
       fa_contact_name,
       fa_contact_phone,
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
       update_date,
       company_province,
       company_city,
       company_county,
       coop_state,
       group_name,
       area_group_leader,
       coop_position,
       product_type,
       product_link,
       brand_type,
       cooperation_brand,
       product_line,
       product_line_num,
       worker_num,
       machine_num,
       quality_step,
       pattern_cap,
       fabric_purchase_cap,
       fabric_check_cap,
       cost_step,
       --reserve_capacity,
       product_efficiency,
       work_hours_day,
       remarks,
       company_type,
       supplier_gate,
       supplier_office,
       supplier_site,
       supplier_product,
       file_remark,
       ask_files,
       admit_result)
    VALUES
      (p_sp_data.supplier_info_id,
       p_sp_data.company_id,
       p_sp_data.supplier_info_origin_id,
       p_sp_data.supplier_company_id,
       p_sp_data.supplier_company_name,
       p_sp_data.supplier_company_abbreviation,
       p_sp_data.social_credit_code,
       p_sp_data.inside_supplier_code,
       p_sp_data.company_contact_person,
       p_sp_data.company_contact_phone,
       p_sp_data.legal_representative,
       p_sp_data.fa_contact_name,
       p_sp_data.fa_contact_phone,
       p_sp_data.company_address,
       p_sp_data.certificate_file,
       p_sp_data.cooperation_type,
       p_sp_data.cooperation_model,
       p_sp_data.sharing_type,
       p_sp_data.supplier_info_origin,
       p_sp_data.pause,
       '0',
       p_sp_data.bind_status,
       p_sp_data.create_id,
       SYSDATE,
       p_sp_data.create_id,
       SYSDATE,
       p_sp_data.company_province,
       p_sp_data.company_city,
       p_sp_data.company_county,
       p_sp_data.coop_state,
       p_sp_data.group_name,
       p_sp_data.area_group_leader,
       p_sp_data.coop_position,
       p_sp_data.product_type,
       p_sp_data.product_link,
       p_sp_data.brand_type,
       p_sp_data.cooperation_brand,
       p_sp_data.product_line,
       p_sp_data.product_line_num,
       p_sp_data.worker_num,
       p_sp_data.machine_num,
       p_sp_data.quality_step,
       p_sp_data.pattern_cap,
       p_sp_data.fabric_purchase_cap,
       p_sp_data.fabric_check_cap,
       p_sp_data.cost_step,
       --p_sp_data.reserve_capacity,
       p_sp_data.product_efficiency,
       p_sp_data.work_hours_day,
       p_sp_data.remarks,
       p_sp_data.company_type,
       p_sp_data.supplier_gate,
       p_sp_data.supplier_office,
       p_sp_data.supplier_site,
       p_sp_data.supplier_product,
       p_sp_data.file_remark,
       p_sp_data.ask_files,
       p_sp_data.admit_result);
  
  END insert_supplier_info;

  /*============================================*
  * Author   : SANFU
  * Created  : 2020-09-28 10:15:31
  * ALERTER  :
  * ALERTER_TIME  :
  * Purpose  : �޸Ĺ�Ӧ��
  * Obj_Name    : update_supplier_info
  * Arg_Number  : 3
  * P_SP_DATA : ��Ӧ�̵�������
  * p_item_id   ��ҳ������
  * p_origin ����Դ
  *============================================*/

  PROCEDURE update_supplier_info(p_sp_data t_supplier_info%ROWTYPE,
                                 p_item_id VARCHAR2 DEFAULT NULL) IS
    v_update_sql CLOB;
  BEGIN
    --��ҳ��Ϊ������ �ѽ�������ҳ ���±���ʱУ������
    check_save_t_supplier_info(p_sp_data => p_sp_data);
  
    v_update_sql := q'[UPDATE scmdata.t_supplier_info sp
    --������Ϣ
       SET ]' || CASE
                      WHEN p_sp_data.supplier_info_origin = 'MA' AND
                           p_sp_data.status = 0 THEN
                       ' sp.social_credit_code            = :social_credit_code,'
                      ELSE
                       ''
                    END || q'[
           sp.supplier_company_name         = :supplier_company_name,
           sp.supplier_company_abbreviation = :supplier_company_abbreviation,
           sp.legal_representative = :legal_representative,
           sp.inside_supplier_code = :inside_supplier_code,
           sp.company_province     = :company_province,
           sp.company_city         = :company_city,
           sp.company_county       = :company_county,
           sp.company_address      = :company_address,
           sp.company_contact_phone = :company_contact_phone,
           sp.fa_contact_name       = :fa_contact_name,
           sp.fa_contact_phone      = :fa_contact_phone,
           sp.company_type          = :company_type,
           sp.group_name            = :group_name,
           sp.area_group_leader     = :area_group_leader,
           --������Ϣ
           sp.product_type        = :product_type,
           sp.product_link        = :product_link,
           sp.brand_type          = :brand_type,
           sp.cooperation_brand   = :cooperation_brand,
           sp.product_line        = :product_line,
           sp.product_line_num    = :product_line_num,
           sp.worker_num          = :worker_num,
           sp.machine_num         = :machine_num,
           sp.quality_step        = :quality_step,
           sp.pattern_cap         = :pattern_cap,
           sp.fabric_purchase_cap = :fabric_purchase_cap,
           sp.fabric_check_cap    = :fabric_check_cap,
           sp.cost_step           = :cost_step,
           --sp.reserve_capacity    = :reserve_capacity,
           sp.product_efficiency  = :product_efficiency,
           sp.work_hours_day      = :work_hours_day,
           --������Ϣ
           sp.pause               = :coop_state,
           sp.pause_cause         = :pause_cause,
           --sp.cooperation_type  = :cooperation_type,
           sp.cooperation_model   = :cooperation_model,
           sp.coop_position = :coop_position,
           --��������
           sp.certificate_file = :certificate_file,
           sp.ask_files        = :ask_files,
           sp.supplier_gate    = :supplier_gate,
           sp.supplier_office  = :supplier_office,
           sp.supplier_site    = :supplier_site,
           sp.supplier_product = :supplier_product,
           sp.company_say      = :company_say,
           sp.file_remark      = :file_remark,
           sp.update_id        = :update_id,
           sp.update_date      = :update_date
     WHERE sp.supplier_info_id = :supplier_info_id]';
    --��ԴΪ׼�� ͳһ������ô��� ���ɸ���
    --��ԴΪ�ֶ����� �� ������ ͳһ������ô��� �ɸ���
    IF p_sp_data.supplier_info_origin = 'MA' AND p_sp_data.status = 0 THEN
      EXECUTE IMMEDIATE v_update_sql
        USING p_sp_data.social_credit_code, p_sp_data.supplier_company_name, p_sp_data.supplier_company_abbreviation, p_sp_data.legal_representative, p_sp_data.inside_supplier_code, p_sp_data.company_province, p_sp_data.company_city, p_sp_data.company_county, p_sp_data.company_address, p_sp_data.company_contact_phone, p_sp_data.fa_contact_name, p_sp_data.fa_contact_phone, p_sp_data.company_type, p_sp_data.group_name, p_sp_data.area_group_leader, p_sp_data.product_type, p_sp_data.product_link, p_sp_data.brand_type, p_sp_data.cooperation_brand, p_sp_data.product_line, p_sp_data.product_line_num, p_sp_data.worker_num, p_sp_data.machine_num, p_sp_data.quality_step, p_sp_data.pattern_cap, p_sp_data.fabric_purchase_cap, p_sp_data.fabric_check_cap, p_sp_data.cost_step, /*p_sp_data.reserve_capacity,*/
      p_sp_data.product_efficiency, p_sp_data.work_hours_day, p_sp_data.pause, p_sp_data.pause_cause, p_sp_data.cooperation_model, p_sp_data.coop_position, p_sp_data.certificate_file, p_sp_data.ask_files, p_sp_data.supplier_gate, p_sp_data.supplier_office, p_sp_data.supplier_site, p_sp_data.supplier_product, p_sp_data.company_say, p_sp_data.file_remark, p_sp_data.update_id, SYSDATE, p_sp_data.supplier_info_id;
    ELSE
      EXECUTE IMMEDIATE v_update_sql
        USING p_sp_data.supplier_company_name, p_sp_data.supplier_company_abbreviation, p_sp_data.legal_representative, p_sp_data.inside_supplier_code, p_sp_data.company_province, p_sp_data.company_city, p_sp_data.company_county, p_sp_data.company_address, p_sp_data.company_contact_phone, p_sp_data.fa_contact_name, p_sp_data.fa_contact_phone, p_sp_data.company_type, p_sp_data.group_name, p_sp_data.area_group_leader, p_sp_data.product_type, p_sp_data.product_link, p_sp_data.brand_type, p_sp_data.cooperation_brand, p_sp_data.product_line, p_sp_data.product_line_num, p_sp_data.worker_num, p_sp_data.machine_num, p_sp_data.quality_step, p_sp_data.pattern_cap, p_sp_data.fabric_purchase_cap, p_sp_data.fabric_check_cap, p_sp_data.cost_step, /*p_sp_data.reserve_capacity,*/
      p_sp_data.product_efficiency, p_sp_data.work_hours_day, p_sp_data.pause, p_sp_data.pause_cause, p_sp_data.cooperation_model, p_sp_data.coop_position, p_sp_data.certificate_file, p_sp_data.ask_files, p_sp_data.supplier_gate, p_sp_data.supplier_office, p_sp_data.supplier_site, p_sp_data.supplier_product, p_sp_data.company_say, p_sp_data.file_remark, p_sp_data.update_id, SYSDATE, p_sp_data.supplier_info_id;
    END IF;
  END update_supplier_info;

  /*============================================*
  * Author   p_sp_data. SANFU
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

  /*У���ͬ��������*/
  PROCEDURE check_import_constract(p_temp_id IN VARCHAR2) IS
    p_contract_info_temp t_contract_info_temp%ROWTYPE;
    p_con_i              INT;
    p_flag               INT;
    p_con_flag           INT;
    p_con_msg            VARCHAR2(3000);
    p_con_desc           VARCHAR2(600);
  BEGIN
    p_con_i := 0;
    SELECT a.*
      INTO p_contract_info_temp
      FROM t_contract_info_temp a
     WHERE a.temp_id = p_temp_id;
    ---У�鹩Ӧ�̱��
    SELECT COUNT(1), MAX(t.status), MAX(supplier_company_name)
      INTO p_flag, p_con_flag, p_con_desc
      FROM scmdata.t_supplier_info t
     WHERE t.inside_supplier_code =
           p_contract_info_temp.inside_supplier_code
       AND t.company_id = p_contract_info_temp.company_id;
  
    IF p_flag = 0 THEN
      p_con_i   := p_con_i + 1;
      p_con_msg := p_con_msg || p_con_i || ')�����ڵĹ�Ӧ�̱��,';
    
    ELSIF p_con_flag = 0 THEN
      p_con_i   := p_con_i + 1;
      p_con_msg := p_con_msg || p_con_i || ')��Ӧ��δ����,';
    
    ELSIF p_con_desc <> p_contract_info_temp.supplier_company_name THEN
      p_con_i   := p_con_i + 1;
      p_con_msg := p_con_msg || p_con_i || ')��Ӧ�̱�ź͹�Ӧ�����Ʋ���Ӧ,��ǰ��ӦΪ:' ||
                   p_con_desc || ' ,';
    END IF;
  
    ----У���ͬ����
    IF p_contract_info_temp.contract_start_date >
       p_contract_info_temp.contract_stop_date THEN
      p_con_msg := '��ͬ���ڣ��������ڱ���ݿ�ʼ����';
    END IF;
  
    ----У���ͬ����
  
    SELECT MAX(a.group_dict_value)
      INTO p_contract_info_temp.contract_type
      FROM sys_group_dict a
     WHERE a.group_dict_value = p_contract_info_temp.contract_type
       AND a.group_dict_type = 'CONTRACT_TYPE'
       AND pause = 0;
    IF p_contract_info_temp.contract_type IS NULL THEN
      p_con_i   := p_con_i + 1;
      p_con_msg := p_con_msg || p_con_i || ')�����ڵĺ�ͬ����';
    ELSE
      UPDATE scmdata.t_contract_info_temp t
         SET t.contract_type = p_contract_info_temp.contract_type
       WHERE t.temp_id = p_temp_id;
    END IF;
  
    ----У���ظ�����
  
    ----�����û�����
  
    p_contract_info_temp.operator_id  := p_contract_info_temp.user_id;
    p_contract_info_temp.operate_time := SYSDATE;
    p_contract_info_temp.change_id    := p_contract_info_temp.user_id;
    p_contract_info_temp.change_time  := SYSDATE;
  
    UPDATE scmdata.t_contract_info_temp t
       SET t.operator_id  = p_contract_info_temp.operator_id,
           t.operate_time = p_contract_info_temp.operate_time,
           t.change_id    = p_contract_info_temp.change_id,
           t.change_time  = p_contract_info_temp.change_time
     WHERE t.temp_id = p_temp_id;
  
    IF p_con_msg IS NOT NULL THEN
      UPDATE scmdata.t_contract_info_temp t
         SET t.msg_type = 'E', t.msg = p_con_msg
       WHERE t.temp_id = p_temp_id;
    ELSE
      UPDATE scmdata.t_contract_info_temp t
         SET t.msg_type = 'S', t.msg = 'У��ɹ�'
       WHERE t.temp_id = p_temp_id;
    END IF;
  
  END check_import_constract;

  /*�ύ��������ĺ�ͬ*/

  PROCEDURE submit_t_contract_info(p_company_id IN VARCHAR2,
                                   p_user_id    IN VARCHAR2) IS
    p_sub_id      VARCHAR2(32);
    p_sub_supp_id VARCHAR2(32);
  BEGIN
    FOR data_sub IN (SELECT *
                       FROM scmdata.t_contract_info_temp t
                      WHERE t.company_id = p_company_id
                        AND t.user_id = p_user_id) LOOP
      IF data_sub.msg_type = 'E' OR data_sub.msg_type IS NULL THEN
        raise_application_error(-20002,
                                '���������Ƿ��Ѽ���ɹ����޸���ȷ�����ύ!');
      ELSE
        p_sub_id := f_get_uuid();
      
        SELECT supplier_info_id
          INTO p_sub_supp_id
          FROM scmdata.t_supplier_info a
         WHERE a.inside_supplier_code = data_sub.inside_supplier_code
           AND a.company_id = data_sub.company_id;
      
        INSERT INTO scmdata.t_contract_info
          (contract_info_id,
           supplier_info_id,
           company_id,
           contract_start_date,
           contract_stop_date,
           contract_sign_date,
           contract_file,
           contract_type,
           contract_num,
           operator_id,
           operate_time,
           change_id,
           change_time)
        VALUES
          (p_sub_id,
           p_sub_supp_id,
           data_sub.company_id,
           data_sub.contract_start_date,
           data_sub.contract_stop_date,
           data_sub.contract_sign_date,
           data_sub.contract_file,
           data_sub.contract_type,
           data_sub.contract_num,
           data_sub.operator_id,
           data_sub.operate_time,
           data_sub.change_id,
           data_sub.change_time);
      END IF;
    END LOOP;
    DELETE FROM t_contract_info_temp t
     WHERE t.company_id = p_company_id
       AND t.user_id = p_user_id;
  END submit_t_contract_info;

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
       contract_file,
       contract_type,
       contract_num,
       operator_id,
       operate_time,
       change_id,
       change_time)
    VALUES
      (scmdata.f_get_uuid(),
       p_contract_rec.supplier_info_id,
       p_contract_rec.company_id,
       p_contract_rec.contract_start_date,
       p_contract_rec.contract_stop_date,
       p_contract_rec.contract_sign_date,
       p_contract_rec.contract_file,
       p_contract_rec.contract_type,
       p_contract_rec.contract_num,
       p_contract_rec.operator_id,
       SYSDATE,
       p_contract_rec.change_id,
       SYSDATE);
  
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
           t.contract_file       = p_contract_rec.contract_file,
           t.contract_type       = p_contract_rec.contract_type,
           t.contract_num        = p_contract_rec.contract_num,
           t.change_id           = p_contract_rec.change_id,
           t.change_time         = p_contract_rec.change_time
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
        insert_supplier_info(p_sp_data => p_sp_data);
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
    p_desc            VARCHAR2(600);
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
    /*   IF p_supplier_id IS NOT NULL AND
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
    */
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
    p_code        VARCHAR2(32);
    p_id          VARCHAR2(32);
    p_supplier_id VARCHAR2(32);
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
      
        SELECT supplier_info_id
          INTO p_supplier_id
          FROM t_supplier_info a
         WHERE a.inside_supplier_code = p_code
           AND a.company_id = data_rec.company_id;
        SELECT MAX(coop_scope_id)
          INTO p_id
          FROM t_coop_scope a
         WHERE a.supplier_info_id = p_supplier_id
           AND a.company_id = p_company_id
           AND a.coop_classification = data_rec.coop_classification
           AND a.coop_product_cate = data_rec.coop_product_cate;
        IF p_id IS NOT NULL THEN
          UPDATE scmdata.t_coop_scope a
             SET a.coop_subcategory = data_rec.coop_subcategory,
                 a.update_id        = data_rec.create_id,
                 a.update_time      = SYSDATE,
                 a.sharing_type     = data_rec.sharing_type
           WHERE a.coop_scope_id = p_id;
          DELETE FROM scmdata.t_supplier_shared a
           WHERE a.coop_scope_id = p_id;
        ELSE
          p_id := f_get_uuid();
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
             p_supplier_id,
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
        END IF;
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
               p_supplier_id,
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
  PROCEDURE insert_coop_scope(p_cp_data scmdata.t_coop_scope%ROWTYPE,
                              p_type    NUMBER DEFAULT 1) IS
  BEGIN
    --У�������Χ  p_status�� IU ����/���� D ɾ��
    IF p_type = 1 THEN
      check_coop_scopre(p_cp_data => p_cp_data, p_status => 'IU');
    ELSE
      NULL;
    END IF;
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

  --����������Ӧ��
  PROCEDURE insert_supplier_shared(scope_rec       scmdata.t_coop_scope%ROWTYPE,
                                   p_supplier_code VARCHAR2) IS
  BEGIN
    INSERT INTO t_supplier_shared
      (coop_scope_id,
       supplier_shared_id,
       company_id,
       supplier_info_id,
       shared_supplier_code,
       remarks)
    VALUES
      (scope_rec.coop_scope_id,
       scmdata.f_get_uuid(),
       scope_rec.company_id,
       scope_rec.supplier_info_id,
       p_supplier_code,
       '');
  END insert_supplier_shared;
  --ɾ��������Ӧ��
  PROCEDURE delete_supplier_shared(p_supplier_shared_id VARCHAR2) IS
  BEGIN
    DELETE FROM scmdata.t_supplier_shared t
     WHERE t.supplier_shared_id = p_supplier_shared_id;
  END delete_supplier_shared;

  --��ȡ��Ӧ����״̬
  PROCEDURE get_supp_oper_status(p_factory_ask_id VARCHAR2,
                                 po_flow_status   OUT VARCHAR2,
                                 po_flow_node     OUT VARCHAR2) IS
    vo_flow_status VARCHAR2(32);
    vo_flow_node   VARCHAR2(32);
  BEGIN
  
    SELECT status_af_oper, flow_node_name_af || flow_node_status_desc_af
      INTO vo_flow_status, vo_flow_node
      FROM (SELECT factory_ask_id,
                   status_af_oper,
                   substr(gs.group_dict_name,
                          0,
                          instr(gs.group_dict_name, '+') - 1) flow_node_name_af,
                   substr(gs.group_dict_name,
                          instr(gs.group_dict_name, '+') + 1,
                          length(gs.group_dict_name)) flow_node_status_desc_af
              FROM t_factory_ask_oper_log a
             INNER JOIN sys_group_dict goper
                ON goper.group_dict_value = upper(a.oper_code)
               AND goper.group_dict_type = 'DICT_FLOW_STATUS'
             INNER JOIN sys_group_dict gs
                ON gs.group_dict_value = a.status_af_oper
               AND gs.group_dict_type = 'FACTORY_ASK_FLOW'
             INNER JOIN sys_company_user cua
                ON a.oper_user_id = cua.user_id
               AND a.oper_user_company_id = cua.company_id
             WHERE a.factory_ask_id = p_factory_ask_id
                OR (a.ask_record_id IS NOT NULL AND
                   a.ask_record_id =
                   (SELECT ask_record_id
                       FROM t_factory_ask
                      WHERE factory_ask_id = p_factory_ask_id) AND
                   a.factory_ask_id IS NULL)
             ORDER BY a.oper_time DESC) tablealias
     WHERE factory_ask_id = p_factory_ask_id
       AND rownum = 1;
  
    po_flow_status := vo_flow_status;
    po_flow_node   := vo_flow_node;
  
  END get_supp_oper_status;

  --��Ӧ���� ������΢�����˷�����Ϣ
  FUNCTION send_fac_wx_msg(p_company_id     VARCHAR2,
                           p_factory_ask_id VARCHAR2,
                           p_msgtype        VARCHAR2, --��Ϣ���� text��markdown
                           p_msg_title      VARCHAR2, --��Ϣ����
                           p_bot_key        VARCHAR2, --������key
                           p_robot_type     VARCHAR2 --��������������
                           ) RETURN CLOB IS
    v_msg_body     CLOB;
    v_sender       CLOB;
    v_wx_sql       CLOB;
    vo_flow_status VARCHAR2(32);
    vo_flow_name   VARCHAR2(32);
    v_sup_name     VARCHAR2(256);
    v_pause        VARCHAR2(32);
    v_sup_code     VARCHAR2(32);
    v_all_cnt      NUMBER;
    v_shoe_cnt     NUMBER;
  BEGIN
    --��ȡ��Ӧ������  ������
    SELECT t.company_name,
           (SELECT t.inner_user_id
              FROM scmdata.sys_company_user t
             WHERE t.company_id = p_company_id
               AND t.user_id = t.ask_user_id)
      INTO v_sup_name, v_sender
      FROM scmdata.t_factory_ask t
     WHERE t.factory_ask_id = p_factory_ask_id;
  
    scmdata.pkg_supplier_info.get_supp_oper_status(p_factory_ask_id => p_factory_ask_id,
                                                   po_flow_status   => vo_flow_status,
                                                   po_flow_node     => vo_flow_name);
  
    --FA21  FA33  '׼�벻ͨ��', '�������벻ͨ��'
    IF vo_flow_status IN ('FA21', 'FA33') THEN
      v_msg_body := '���ã�����<' || v_sup_name || '>��Ӧ�̵��鳧���Ϊ[' || vo_flow_name ||
                    '],�뼰ʱ����������ǰ��SCMϵͳ���в鿴,лл��';
      --FA22  FA32  '�������������', '׼�����������'
    ELSIF vo_flow_status IN ('FA22', 'FA32') THEN
      --���� ����״̬
      SELECT decode(t.pause, 0, 'ͨ��', 2, '�Ե�', 'ͣ��')
        INTO v_pause
        FROM scmdata.t_supplier_info t
       WHERE t.company_id = p_company_id
         AND t.supplier_info_origin_id = p_factory_ask_id;
    
      v_msg_body := '���ã�����<' || v_sup_name || '>��Ӧ�̵��鳧���Ϊ[' || v_pause ||
                    '],������ǰ��SCMϵͳ���в鿴,лл��';
      --SP_01 '��Ӧ�̵����ѽ���'
    ELSIF vo_flow_status IN ('SP_01') THEN
      --���� ����״̬,��Ӧ������
      SELECT decode(t.pause, 0, 'ͨ��', 2, '�Ե�', 'ͣ��'), t.supplier_code
        INTO v_pause, v_sup_code
        FROM scmdata.t_supplier_info t
       WHERE t.company_id = p_company_id
         AND t.supplier_info_origin_id = p_factory_ask_id;
    
      v_msg_body := '���ã�<' || v_sup_name || '>��Ӧ���ѽ���,�������Ϊ[' || v_pause ||
                    '],�������Ϊ��[' || v_sup_code || '],��֪Ϥ,лл��';
    
    ELSIF vo_flow_status IN ('FA13') THEN
      --���ý�����  Ĭ������������ ������Ь�ӵ��������ࣺҶ����  Ь����ƽ
      SELECT COUNT(1) all_cnt,
             SUM(CASE
                   WHEN b.cooperation_classification = '08' AND
                        b.cooperation_product_cate IN ('111', '113', '114') THEN
                    1
                   ELSE
                    0
                 END) shoe_cnt
        INTO v_all_cnt, v_shoe_cnt
        FROM scmdata.t_factory_report a
       INNER JOIN scmdata.t_factory_report_ability b
          ON a.factory_report_id = b.factory_report_id
         AND a.company_id = b.company_id
       WHERE a.factory_ask_id = p_factory_ask_id
         AND a.company_id = p_company_id;
    
      IF v_shoe_cnt = 0 THEN
        v_sender := 'YQL13';
      ELSIF v_shoe_cnt = v_all_cnt THEN
        v_sender := 'KP2';
      ELSE
        v_sender := 'YQL13;KP2';
      END IF;
      v_msg_body := '���ã�<' || v_sup_name ||
                    '>��Ӧ�̵��鳧�������ύ,�뼰ʱ��ˡ�������ǰ��SCMϵͳ���в鿴,лл��';
    ELSE
      raise_application_error(-20002,
                              '��΢�����˷�����Ϣʧ��,����ϵ����Ա����');
    END IF;
  
    --������Ϣ֪ͨ
    v_wx_sql := scmdata.pkg_plat_comm.send_wx_msg(p_company_id => p_company_id,
                                                  p_msgtype    => p_msgtype,
                                                  p_msg_title  => p_msg_title,
                                                  p_msg_body   => v_msg_body,
                                                  p_sender     => v_sender,
                                                  p_bot_key    => p_bot_key,
                                                  p_robot_type => p_robot_type);
    RETURN v_wx_sql;
  END send_fac_wx_msg;
  ----------------------------------------------------  ҵ�����   end  ---------------------------------------------------------------------------
END pkg_supplier_info;
/
