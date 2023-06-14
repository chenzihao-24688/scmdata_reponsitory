--��Ӧ�̵���-�ӿڿ���

select rowid,t.* from bw3.sys_item t where t.item_id = 'a_supp_140';   
select rowid,t.* from bw3.sys_tree_list t where t.item_id = 'a_supp_140';   
select rowid,t.* from bw3.sys_item_list t where t.item_id in ('a_supp_140','a_supp_141'); 

SELECT ROWID, t.* FROM bw3.sys_element t where t.element_id = 'action_a_supp_110';
SELECT ROWID, t.* FROM bw3.sys_action t where t.element_id = 'action_a_supp_110';
SELECT ROWID, t.* FROM bw3.sys_item_element_rela t where t.element_id = 'action_a_supp_110';

select rowid,t.* from bwptest1.sys_open_info t;
SELECT ROWID, t.* FROM bwptest1.sys_open_interface t;
SELECT ROWID, t.* FROM bw3.sys_method t where t.method_id in('method_a_supp_110','method_a_supp_110_9');
SELECT ROWID, t.* FROM bw3.sys_port_http t where t.port_name in ('port_a_supp_110','port_a_supp_110_9');
SELECT ROWID, t.* FROM bw3.sys_port_method t where t.method_id in('method_a_supp_110','method_a_supp_110_9');
SELECT ROWID, t.* FROM bw3.sys_port_map t where t.port_name in ('port_a_supp_110','port_a_supp_110_9');
SELECT ROWID, t.* FROM bw3.sys_action t where t.element_id in ('action_a_supp_110','action_a_supp_110_9');
SELECT ROWID, t.* FROM bw3.sys_port_submap t;
select rowid,t.* from bw3.sys_param_list t where t.param_name = 'BATCH_TIME';
select * from bw3.sys_field_list t where t.field_name = 'BATCH_TIME';--SUP_ID_BASE   
scmdata.t_coop_scope

select * from  t_supplier_info_ctl;
select * from  scmdata.t_supplier_base_itf;
--ɾ��

DECLARE
BEGIN
  --ɾ��scm��Ӧ�̽ӿ�����
  DELETE FROM t_supplier_info_ctl;
  DELETE FROM scmdata.t_supplier_base_itf;
  select /*rowid,*/t.supplier_company_name from scmdata.t_supplier_info t group by t.supplier_company_name having count(t.supplier_company_name)>1;
  
  update scmdata.t_supplier_info t set t.inside_supplier_code = null , t.publish_id = null,t.publish_date = null ;
  
  update scmdata.t_supplier_info t set t.update_id = t.create_id, t.update_date = t.create_date where t.supplier_info_origin <> 'II';
  --DELETE FROM scmdata.t_supp_batch_itf;

  DELETE FROM scmdata.t_supplier_shared;
  DELETE FROM scmdata.t_supplier_ability;
  DELETE FROM scmdata.t_coop_scope;
  DELETE FROM scmdata.t_contract_info;
  delete from scmdata.t_supplier_info_oper_log;
  DELETE FROM scmdata.t_supplier_info t;

  DELETE FROM scmdata.t_supplier_info t
   WHERE t.supplier_info_origin = 'II';
END;

--����ʱ��

DECLARE
BEGIN
  FOR i IN (SELECT regexp_substr('2004,' || '2005,' || '2006,' || '2007,' ||
                                 '2008,' || '2009,' || '2010,' || '2011,' ||
                                 '2012,' || '2013,' || '2014,' || '2015,' ||
                                 '2016,' || '2017,' || '2018,' || '2019,' ||
                                 '2020',
                                 '[^,]+',
                                 1,
                                 LEVEL) size_gd
              FROM dual
            CONNECT BY LEVEL <=
                       regexp_count('2004,' || '2005,' || '2006,' || '2007,' ||
                                    '2008,' || '2009,' || '2010,' || '2011,' ||
                                    '2012,' || '2013,' || '2014,' || '2015,' ||
                                    '2016,' || '2017,' || '2018,' || '2019,' ||
                                    '2020',
                                    '[^,]+')) LOOP
    -- dbms_output.put_line(i.size_gd);
    INSERT INTO scmdata.t_supp_batch_itf
      (supp_batch_id, batch_time)
    VALUES
      (scmdata.f_get_uuid, i.size_gd);
  END LOOP;
END;



--1��.action_sql

DECLARE
  v_sql VARCHAR2(4000);
  v_i   VARCHAR2(100);
BEGIN
   --1.��ʼ��������
    v_i   := '2004';
   --2.��ѯ��ر��������ڣ�����д��ʼֵ
   select decode(t.batch_time,null,v_i,t.batch_time + 1)  into v_i from scmdata.t_supplier_info_ctl t where t.batch_time = v_i;
   
    v_sql := q'[select ]' || q'[']' || v_i || q'[']' || ' BATCH_TIME' ||
             q'[,'' SUP_ID_BASE,'' SUP_NAME,'' LEGALPERSON, '' LINKMAN,'' PHONENUMBER,'' ADDRESS,'' SUP_TYPE,'' INSERTTIME,'' LASTMODIFYTIME,'' LASTPUBLISHTIME,'' SUP_STATUS,'' COUNTYID,'' PROVINCEID, 
             '' CITYNO,'' TAX_ID,'' COMPANY_TYPE,'' SEND_TIME from dual]';
             
    dbms_output.put_line(v_sql);

END;

--2��.PORT_SQL

DECLARE
v_itf_id varchar2(32);
v_flag varchar2(32);
supp_itf_rec t_supplier_base_itf%rowtype;
BEGIN

--1.�ӿڱ�
v_itf_id := scmdata.f_get_uuid();

INSERT INTO t_supplier_base_itf
  (itf_id,
   sup_id_base,
   sup_name,
   legalperson,
   linkman,
   phonenumber,
   address,
   sup_type,
   inserttime,
   lastmodifytime,
   lastpublishtime,
   sup_status,
   countyid,
   provinceid,
   cityno,
   tax_id,
   company_type)
VALUES
  (v_itf_id,
   :sup_id_base,
   :sup_name,
   :legalperson,
   :linkman,
   :phonenumber,
   :address,
   :sup_type,
   :inserttime,
   :lastmodifytime,
   :lastpublishtime,
   :sup_status,
   :countyid,
   :provinceid,
   :cityno,
   :tax_id,
   :company_type);
   
--2.�ӿڱ�����У��(����Ƽȷ�Ϻ󿪷�)

--3.��¼�ӿڱ���Ϣ����ر�

INSERT INTO t_supplier_info_ctl
  (ctl_id,
   itf_id,
   itf_type,
   batch_id,
   batch_num,
   batch_time,
   sender,
   receiver,
   send_time,
   receive_time,
   return_type,
   return_msg,
   create_id,
   create_time,
   update_id,
   update_time)
VALUES
  (scmdata.f_get_uuid(),
   v_itf_id,
   '��Ӧ�̽ӿڵ���',
   '',
   '',
   :batch_time,
   '181',
   'scm',
   :send_time,
   sysdate,
   'Y',--����У������ȷ��,��ȷ��
   '����У��ɹ�',--����У������ȷ��,��ȷ��
   'czh',
   sysdate,
   'czh',
   sysdate);
   
--�жϼ�ر������Ƿ���ȷ
select t.return_type INTO v_flag from t_supplier_info_ctl t where t.itf_id = v_itf_id and t.batch_time = :batch_time;
if v_flag = 'Y' then
  
--�ӽӿ�������
select * into supp_itf_rec from t_supplier_base_itf t where t.itf_id = v_itf_id and t.batch_time = :batch_time;

--4.���սӿڵ��뵽ҵ���
INSERT INTO scmdata.t_supplier_info
  (supplier_info_id,
   company_id,
   supplier_info_origin_id,
   inside_supplier_code,
   supplier_company_id,
   supplier_company_name,
   supplier_company_abbreviation,
   company_create_date,
   legal_representative,
   create_id,
   create_date,
   regist_address,
   company_address,
   certificate_validity_start,
   certificate_validity_end,
   regist_price,
   social_credit_code,
   company_type,
   company_person,
   company_contact_person,
   company_contact_phone,
   taxpayer,
   company_say,
   certificate_file,
   organization_file,
   --��������
   cooperation_method,
   cooperation_model,
   cooperation_type,
   production_mode,
   sharing_type,
   supplier_info_origin,
   pause,
   status)
VALUES
  (scmdata.f_get_uuid(),
   %default_company_id%,
   '',
   supp_itf_rec.SUP_ID_BASE,
   '',
   supp_itf_rec.SUP_NAME,
   supp_itf_rec.SUP_NAME,
   '',
   '',
   %currentuserid%,
   SYSDATE,
   '',
   '',
   '',
   '',
   '',
   nvl(supp_itf_rec.TAX_ID,'ɶҲû��'),
   '',
   '',
   supp_itf_rec.LINKMAN,
   supp_itf_rec.PHONENUMBER,
   '',
   '',
   '',
   '',
   --��������
   '',
   supp_itf_rec.SUP_TYPE,
   'COOPERATION_CLASSIFICATION',
   '',
   '00',
   'II',
   0,
   0);
end if;
END;
