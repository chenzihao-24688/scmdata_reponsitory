--1.action
DECLARE
  v_sql VARCHAR2(4000);
BEGIN
  v_sql := 'select 1 from dual';

  nbw.pkg_plat_config.config_actions(p_item_id       => 'g_540_1', --item_id
                                     p_element_id    => 'action_g_540_1_1', --��ťid
                                     p_element_type  => 'action', --��ť����
                                     p_data_source   => 'oracle_scmdata', --����Դ
                                     p_seq_no        => 1, --���
                                     p_pause         => 0, --�Ƿ����
                                     p_is_hide       => 0, --�Ƿ�����
                                     p_caption       => '��ӡ����', --��ť����
                                     p_action_type   => 4, --��ť��������
                                     p_action_sql    => v_sql, --��ťsql
                                     p_select_fields => '', --ѡ���ֶ� ������
                                     p_refresh_flag  => 1, --ˢ�±�־                                                                         
                                     p_status        => 1);
END;

SELECT ROWID, t.*
  FROM nbw.sys_element t
 WHERE t.element_id = 'action_c_2300_1_1';
SELECT ROWID, t.*
  FROM nbw.sys_action t
 WHERE t.element_id = 'action_c_2300_1_5';
SELECT ROWID, t.*
  FROM nbw.sys_item_element_rela t
 WHERE t.element_id = 'action_c_2300_1_1';

--2. lookup nbw.sys_look_up

DECLARE
  v_look_up_sql VARCHAR2(4000);
BEGIN
  v_look_up_sql := q'[SELECT a.group_dict_value deduction_method_pr,
       a.group_dict_name  deduction_method_desc
  FROM scmdata.sys_group_dict a
 WHERE a.group_dict_type = 'DEDUCTION_METHOD'
   AND a.pause = 0]';

  nbw.pkg_plat_config.config_look_ups(p_item_id          => 'a_product_118', --item_id
                                      p_element_id       => 'look_a_product_118_5', --��ťid
                                      p_element_type     => 'lookup', --��ť����
                                      p_data_source      => 'oracle_scmdata', --����Դ
                                      p_seq_no           => 1, --���
                                      p_pause            => 0, --�Ƿ����
                                      p_is_hide          => 0, --�Ƿ�����
                                      p_field_name       => 'deduction_method_desc', --�ֶ��� desc
                                      p_look_up_sql      => v_look_up_sql, --�б�sql 
                                      p_data_type        => '1', --��������1:����������,2.radio��ѡ��,3.checkbox��ѡ�� 
                                      p_key_field        => 'deduction_method_pr', --�����ֶ� pr
                                      p_result_field     => 'deduction_method_desc', --result_field desc
                                      p_before_field     => 'deduction_method_pr', --before_field pr
                                      p_search_flag      => 0, --������־  0����������  1��������   
                                      p_multi_value_flag => 0, --��ѡ��־  0����ѡ  1�������ѡ 
                                      p_disabled_field   => 0, --�����ֶ�   ���ֶλ�ȡ�Ľ��  0����ѡ  1������ѡ 
                                      p_group_field      => '', --�����ֶ�   ֻ��������һ�� 
                                      p_value_sep        => '', --�ָ���   
                                      p_icon             => '', --ͼƬ�ֶ��� 
                                      p_status           => 1);

END;

SELECT ROWID, t.*
  FROM nbw.sys_element t
 WHERE t.element_id = 'look_a_product_118_5';
SELECT ROWID, t.*
  FROM nbw.sys_look_up t
 WHERE t.element_id = 'look_a_quotation_111_2_2';
SELECT ROWID, t.*
  FROM nbw.sys_item_element_rela t
 WHERE t.element_id = 'look_a_product_118_5';

--3.pick_list
DECLARE
  v_pick_sql CLOB;
BEGIN
  v_pick_sql := q'[SELECT g.apply_id, g.icon, g.apply_name, g.tips
    FROM scmdata.sys_group_apply g
   ORDER BY g.sort ASC
]';

  nbw.pkg_plat_config.config_pick_lists(p_item_id          => 'g_530_2', --item_id
                                        p_element_id       => 'pick_g_530_2_1', --Ԫ��id ������ά���߼���ϵ�����ݿⲻ�������  
                                        p_element_type     => 'pick', --����
                                        p_data_source      => 'oracle_scmdata', --����Դ
                                        p_seq_no           => 1, --���
                                        p_pause            => 0, --�Ƿ����
                                        p_is_hide          => 0, --�Ƿ�����
                                        p_field_name       => 'apply_name', --�����ֶ��� 
                                        p_caption          => 'Ӧ������', --���� 
                                        p_pick_sql         => v_pick_sql, --ѡ��sql 
                                        p_from_field       => 'apply_name', --��Դ�ֶ� 
                                        p_query_fields     => 'apply_name', --��ѯ�ֶ� 
                                        p_other_fields     => 'apply_id', --�����ֶ� 
                                        p_tree_fields      => 'apply_name', --�����ֶ� 
                                        p_level_field      => '', --�㼶�ֶ� 
                                        p_image_names      => '', --ͼ������ 
                                        p_tree_id          => '', --�㼶��id 
                                        p_seperator        => '', --��ֵ�ָ��� 
                                        p_multi_value_flag => 0, --��ֵ��־  0:��ֵ     ��0����ֵ 
                                        p_recursion_flag   => 0, --�ݹ���ͼ��־ 0 �̶��㼶����1 ��̬�㼶�� 
                                        p_custom_query     => 0, --�Զ����ѯ�� ��ѯ���Զ�������0���Զ�������1�Զ�������Ĭ��Ϊ0 
                                        p_name_list_sql    => '', --�����б�֧��@selection��ֵ���뷽ʽ 
                                        p_port_id          => '', --�ӿ�id 
                                        p_port_sql         => '', --�ӿڲ�ѯsql 
                                        p_status           => 1);

END;

SELECT ROWID, t.*
  FROM nbw.sys_element t
 WHERE t.element_id = 'pick_g_530_2_1';
SELECT ROWID, t.*
  FROM nbw.sys_pick_list t
 WHERE t.element_id = 'pick_g_530_2_1';
SELECT ROWID, t.*
  FROM nbw.sys_item_element_rela t
 WHERE t.element_id = 'pick_g_530_2_1';

--4.����check_action
DECLARE
  v_cond_sql CLOB;
BEGIN
  v_cond_sql := 'select 0 flag from dual where 1=1'; --operate
  --v_cond_sql := 'select max(1) flag from dual where 1=1';
  nbw.pkg_plat_config.config_check_action( --����sys_cond_list
                                          p_cond_id         => 'cond_g_540_1_1', --����id 
                                          p_cond_sql        => v_cond_sql, --����sql 
                                          p_cond_type       => 1, --1��������ȷ��������ȡ������ť���ڣ����ݰ�ťѡ�����������ʾ��Ϣ�����û�ѡ��0��������ȷ������ť���ڣ���ִ�иò�������������Ч������ʾ����
                                          p_show_text       => '', --һ����ֱ��Щ��ʾ�ͱ�������ݡ����Ҫͨ��sql��䷵�ر������ݣ������û�������������
                                          p_data_source     => 'oracle_scmdata', --����Դ 
                                          p_cond_field_name => '', --���������ֶ� 
                                          p_memo            => '',
                                          --����sys_cond_rela
                                          p_obj_type => 91, --0:  node_id��11: item list������12: item listɾ�� ��13. item list�޸ģ�14: item list �鿴��15: item  detail ����sql��16: item checkvalue (�������޸�)��21: label_list ��ǩ��ӡ��41: hint ��50��key step��51: ��ݷ�ʽ��55: �̵㰴ť��91: action��92: handle��93: �̵���飻95: associate��97����ͬģ�� 
                                          p_ctl_id   => 'action_g_540_1_1', --����id 
                                          p_ctl_type => 1, --0:  condition  ��1:  ǰ��  ��2:  ���� ��3:  checkvalue��4: item�����������ݰ�ŦȨ�ޣ�5:item��������ģ�尴ŦȨ�ޣ�6:item�����ϴ����ݰ�ŦȨ�� 
                                          p_seq_no   => 1, --��� 
                                          p_pause    => 0, --�Ƿ���� 
                                          p_item_id  => '', --������Ŀidʱ��ֻ�������Ŀid������ 
                                          p_operate  => 1, --�Ƿ���������sys_cond_operate 1 �����ã�0��������
                                          --����sys_cond_operate --����ɲ���
                                          p_caption            => '��ʾ', --���� 
                                          p_content            => '�Ƿ�ǰ����ӡ��������ҳ�棿', --���ݣ�֧��sql 
                                          p_to_confirm_item_id => 'g_540_11', --��תȷ��ҳ��id 
                                          p_to_cancel_item_id  => ''); --��תȡ��ҳ��id 

END;

SELECT ROWID, t.*
  FROM nbw.sys_cond_list t
 WHERE t.cond_id = 'cond_g_540_1_1';

SELECT ROWID, t.*
  FROM nbw.sys_cond_rela t
 WHERE t.cond_id = 'cond_g_540_1_1';

SELECT ROWID, t.*
  FROM nbw.sys_cond_operate t
 WHERE t.cond_id = 'cond_g_540_1_1';

--5.����filedlist
DECLARE
BEGIN
  nbw.pkg_plat_config.config_field_list(p_field_name     => 'wrap_flag   ', --�ֶ��� 
                                        p_caption        => '��ťִ��SQL ', --���� 
                                        p_requiered_flag => '0', --1������������ 0������û������ 
                                        p_read_only_flag => '0', --�Ƿ�ֻ��
                                        p_no_edit        => '0', --�Ƿ�ɱ༭
                                        p_no_copy        => '0', --�Ƿ�ɸ���
                                        p_no_sort        => '0', --�Ƿ�����
                                        p_alignment      => '0', --0�������;��1���Ҷ���;2������; 
                                        p_check_express  => '', --У����ʽ 
                                        p_display_format => '', --0.00: С�����������뱣����λ������λ��0��ȫ.С������м���0��չʾ��Ҫ�м���С����0.##: С�����������뱣����λ��С������м������ż�����ʾ������λС����###,###: ���ַֽ�� 
                                        p_data_type      => '', --10:��ֵ��11:���ң�12:���ڣ�13:ʱ�䣻14:�ٷֱȣ�15:������16:�ı���17:�����ͣ�18:�ı�����У�20:blob���ʹ洢ͼƬ��26:ǩ����27:��ͼ��28:��ͼƬ��30:���ı���ʽ�ļ�,�ֶ����ݿ�����Ϊblob��31:�ı���ʽ�ļ�,�ֶ����ݿ�����Ϊblob��32:�����ӵ�ַ��33:�绰���룻34:�����ַ��35:checkbox����,ǰ��չʾС����(ֵΪ0����ʾ ����;1����״̬)��36:���ı�ֱ�ӱ���html��40:blob���͸�����43:�������ƣ������ļ�ָ��ͬһ�ű��ֶ�,ͨ��sys_blob_list�����������47:��������48:�฽�� 
                                        p_ime_care       => '0',
                                        p_ime_open       => '0',
                                        p_status         => '1');
END;

SELECT ROWID, t.*
  FROM nbw.sys_field_list t
 WHERE t.field_name LIKE upper('wrap_flag');

SELECT ROWID, t.*
  FROM nbw.sys_field_list t
 WHERE t.caption LIKE '%��ťִ��%';

--6.����Tabҳ
DECLARE
BEGIN
  nbw.pkg_plat_config.config_tab(p_item_id       => 'a_supp_100',
                                 p_union_item_id => 'a_supp_150',
                                 p_seqno         => 1,
                                 p_pause         => 0);
END;

--7.�������ӱ�
DECLARE
BEGIN
  nbw.pkg_plat_config.config_sys_item_rela(p_item_id     => 'c_2300_1', --��Ŀid 
                                           p_relate_id   => 'c_2300_11', --������Ŀid 
                                           p_relate_type => 'S', --s:�����ӱ�p:�����c:������ 
                                           p_seq_no      => '1', --��� 
                                           p_pause       => '0'); --0 ���� 1 ���� 
END;

--8.������
INSERT INTO nbw.sys_link_list
  (item_id, field_name, to_item_id, null_item_id, pause)
VALUES
  ('g_540_1', 'CAPTION', 'g_540_11', '', 0);
  
select rowid,t.* from nbw.sys_link_list t ;

--9.��ʱ����

insert into nbw.xxl_job_info (ID, APP_ID, JOB_GROUP, JOB_CRON, JOB_DESC, ADD_TIME, UPDATE_TIME, AUTHOR, ALARM_EMAIL, EXECUTOR_ROUTE_STRATEGY, EXECUTOR_HANDLER, EXECUTOR_PARAM, EXECUTOR_BLOCK_STRATEGY, EXECUTOR_TIMEOUT, EXECUTOR_FAIL_RETRY_COUNT, GLUE_TYPE, GLUE_SOURCE, GLUE_REMARK, GLUE_UPDATETIME, CHILD_JOBID, TRIGGER_STATUS, TRIGGER_LAST_TIME, TRIGGER_NEXT_TIME)
values (3500, 'scm', 202, '0 0 0 */1 * ?', '�Զ���������', to_date('27-07-2021 21:27:46', 'dd-mm-yyyy hh24:mi:ss'), to_date('27-07-2021 21:27:46', 'dd-mm-yyyy hh24:mi:ss'), '18172543571', null, 'ROUND', 'actionJobHandler', 'action_pro_generater', 'SERIAL_EXECUTION', 0, 0, 'BEAN', null, null, to_date('27-07-2021 21:27:46', 'dd-mm-yyyy hh24:mi:ss'), null, 1, 0, 0);


